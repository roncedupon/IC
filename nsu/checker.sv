`include "uvm_macros.svh"
import uvm_pkg::*;
// 导入你的事务类
import tsu2nsu_pkg::*;

// ======================================
// 1. 定义虚接口：采样总线所有信号 (必须，替换成你的接口名和信号名)
// ======================================
interface tsu2nsu_if(input clk, input rst_n);
  // wcmd信号
  logic        wcmd_valid;
  logic [5:0]  wcmd_ost_id;
  logic        wcmd_with_data;
  logic [7:0]  wcmd_length; // length位宽可改，比如[15:0]
  // awcmd信号
  logic        awcmd_valid;
  logic [5:0]  awcmd_ost_id;
  // wdata信号
  logic        wdata_valid;
  logic [31:0] wdata;
endinterface

// ======================================
// 2. 核心：tsu2nsu_monitor 完整实现 (按你的要求定制)
// ======================================
class tsu2nsu_monitor extends uvm_monitor;
  `uvm_component_utils(tsu2nsu_monitor)

  // ---------------- 核心成员 ----------------
  virtual tsu2nsu_if  vif;                // 虚接口，采样总线信号
  uvm_analysis_port#(tsu2nsu_transaction) ap; // 分析端口，推送采样好的事务到Checker

  // 关键缓存：存储【不带数据的wcmd】，key=ost_id，value=对应的wcmd信息
  // awcmd到来时，通过ost_id查找该表，获取需要采样的length
  tsu2nsu_transaction  wcmd_cache[int];

  // ---------------- 构造函数 & Build_phase ----------------
  function new(string name = "tsu2nsu_monitor", uvm_component parent = null);
    super.new(name, parent);
    ap = new("ap", this); // 初始化分析端口
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // 从配置池获取虚接口，UVM标准写法
    if(!uvm_config_db#(virtual tsu2nsu_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NO_VIF", "Monitor无法获取虚接口tsu2nsu_if！");
    end
  endfunction

  // ---------------- 核心：run_phase 并行运行所有采样任务 ----------------
  // 3个并行任务：复位监测 + wcmd采样 + awcmd采样
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("MONITOR_START", "tsu2nsu Monitor 启动采样...", UVM_LOW);
    fork
      monitor_rst();          // 复位处理：清空缓存
      sample_wcmd();          // 采样wcmd，核心逻辑1
      sample_awcmd();         // 采样awcmd，核心逻辑2
    join_none
  endtask

  // ---------------- 任务1：复位监测，复位时清空所有缓存 ----------------
  task monitor_rst();
    forever begin
      @(negedge vif.rst_n);
      `uvm_info("RST", "监测到复位信号，清空所有wcmd缓存", UVM_LOW);
      wcmd_cache.delete(); // 复位清空缓存，防止脏数据
      @(posedge vif.rst_n);
    end
  endtask

  // ---------------- 任务2：采样WCMD 【核心逻辑】 ----------------
  // 功能：
  // 1. 检测到带数据的wcmd → 立即调用采样任务，采length拍wdata，打包推送
  // 2. 检测到不带数据的wcmd → 只存入缓存表，不采样，等待awcmd匹配
  task sample_wcmd();
    tsu2nsu_transaction  wcmd_tr;
    forever begin
      @(posedge vif.clk iff vif.rst_n && vif.wcmd_valid); // 时钟沿采样有效wcmd
      // 1. 提取wcmd总线信号，封装成事务
      wcmd_tr = tsu2nsu_transaction::type_id::create("wcmd_tr");
      wcmd_tr.ost_id    = vif.wcmd_ost_id;
      wcmd_tr.with_data = vif.wcmd_with_data;
      wcmd_tr.length    = vif.wcmd_length;

      `uvm_info("SAMPLE_WCMD", $sformatf("采样到WCMD: ost_id=0x%0x, with_data=%0b, length=%0d",
                    wcmd_tr.ost_id, wcmd_tr.with_data, wcmd_tr.length), UVM_LOW);
      
      // 2. 带数据的wcmd → 立即采样length拍wdata并推送
      if(wcmd_tr.with_data) begin
        sample_wdata_and_pkg(wcmd_tr); // 采样wdata+打包推送
      end
      // 3. 不带数据的wcmd → 存入缓存表，等待awcmd匹配
      else begin
        if(wcmd_cache.exists(wcmd_tr.ost_id)) begin
          `uvm_warning("WCMD_EXIST", $sformatf("ost_id=0x%0x的wcmd已存在缓存，覆盖旧数据",wcmd_tr.ost_id));
        end
        wcmd_cache[wcmd_tr.ost_id] = wcmd_tr;
      end
    end
  endtask

  // ---------------- 任务3：采样AWCMD 【核心逻辑】 ----------------
  // 功能：
  // 1. 检测到awcmd → 通过ost_id查找缓存表中的【不带数据wcmd】
  // 2. 找到匹配的wcmd → 调用采样任务，采对应length拍wdata，打包推送
  // 3. 找不到 → 报错误日志
  task sample_awcmd();
    tsu2nsu_transaction  wcmd_tr;
    bit [5:0]  curr_ost_id;
    forever begin
      @(posedge vif.clk iff vif.rst_n && vif.awcmd_valid); // 时钟沿采样有效awcmd
      curr_ost_id = vif.awcmd_ost_id;
      `uvm_info("SAMPLE_AWCMD", $sformatf("采样到AWCMD: ost_id=0x%0x",curr_ost_id), UVM_LOW);

      // 1. 根据ost_id查找缓存的wcmd
      if(wcmd_cache.exists(curr_ost_id)) begin
        wcmd_tr = wcmd_cache[curr_ost_id];
        wcmd_cache.delete(curr_ost_id); // 找到后删除缓存，防止重复采样
        sample_wdata_and_pkg(wcmd_tr);  // 采样wdata+打包推送
      end
      // 2. 未找到匹配的wcmd，报错
      else begin
        `uvm_error("AWCMD_NO_WCMD", $sformatf("ost_id=0x%0x的AWCMD无匹配的WCMD！",curr_ost_id));
      end
    end
  endtask

  // ---------------- 核心工具任务：采样WDATA+打包事务+推送 【最核心】 ----------------
  // 入参：匹配好的wcmd_tr(带length) → 采样length拍有效的wdata → 写入事务 → 推送至Checker
  // 严格按你的要求：采样【length拍】wdata，一个不多一个不少
  task sample_wdata_and_pkg(tsu2nsu_transaction tr);
    int sample_cnt = 0; // 已采样的wdata拍数
    `uvm_info("START_SAMPLE_WDATA", $sformatf("开始采样wdata: ost_id=0x%0x, 需要采样%0d拍",tr.ost_id,tr.length), UVM_LOW);

    // 循环采样，直到采够length拍有效wdata
    while(sample_cnt < tr.length) begin
      @(posedge vif.clk iff vif.rst_n);
      // 采样有效wdata
      if(vif.wdata_valid) begin
        tr.wdata_que.push_back(vif.wdata); // 写入事务的wdata队列
        sample_cnt++;
        `uvm_info("SAMPLE_WDATA", $sformatf("ost_id=0x%0x 采样第%0d拍wdata: 0x%08x",tr.ost_id,sample_cnt,vif.wdata), UVM_HIGH);
      end
    end

    // 采样完成：推送完整事务到Checker (UVM标准，ap.write)
    ap.write(tr);
    `uvm_info("PKG_AND_SEND", $sformatf("ost_id=0x%0x 采样完成！共采%0d拍wdata，已推送至Checker",tr.ost_id,tr.length), UVM_MEDIUM);
  endtask

endclass