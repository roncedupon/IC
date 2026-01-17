`timescale 1ns/1ps
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;

// ====================== 第一步：全局参数定义（统一位宽/时钟） ======================
parameter CLK_PERIOD   = 10;    // 时钟周期10ns（100MHz）
parameter WCMD_WIDTH   = 32;    // tsu_nsu_wcmd位宽（按需调整）
parameter DATA_WIDTH   = WCMD_WIDTH; // 和通用接口位宽对齐

// ====================== 第二步：原始TSU-NSU写命令接口（你的接口+Monitor补全） ======================
interface tsu_nsu_wcmd_if (input logic clk, input logic rst_n);
  // 原始握手信号
  logic [WCMD_WIDTH-1:0] tsu_nsu_wcmd;    // 写命令数据
  logic                  tsu_nsu_wcmd_vld; // 写命令有效
  logic                  tsu_nsu_wcmd_rdy; // 写命令就绪

  // Driver时钟块（Master侧：输出vld/wcmd，输入rdy）
  clocking driver_cb @(posedge clk);
    output tsu_nsu_wcmd, tsu_nsu_wcmd_vld;
    input  tsu_nsu_wcmd_rdy;
    input  rst_n; // 复位同步
  endclocking

  // Monitor时钟块（仅采样，无驱动）
  clocking monitor_cb @(posedge clk);
    input tsu_nsu_wcmd, tsu_nsu_wcmd_vld, tsu_nsu_wcmd_rdy;
    input  rst_n;
  endclocking

  // Modport区分
  modport driver_mp(clocking driver_cb, input clk, rst_n);
  modport monitor_mp(clocking monitor_cb, input clk, rst_n);

endinterface

// ====================== 第三步：通用握手接口（复用之前的） ======================
interface simple_handshake_interface #(parameter DATA_WIDTH = 32) (input logic clk, input logic rst_n);  
  logic                  valid;         
  logic                  rdy;
  logic [DATA_WIDTH-1:0] tr_data;   
  
  // Master侧Driver clocking
  clocking master_driver_cb @(posedge clk);            
    output valid, tr_data;            
    input  rdy;        
    input  rst_n;
  endclocking   
  
  // Slave侧Driver clocking
  clocking slave_driver_cb @(posedge clk);            
    input  valid, tr_data;            
    output rdy;        
    input  rst_n;
  endclocking   
             
  // 通用Monitor clocking
  clocking monitor_cb @(posedge clk);            
    input valid, rdy, tr_data, rst_n;        
  endclocking

  modport master_mp(clocking master_driver_cb, input clk, rst_n);        
  modport slave_mp(clocking slave_driver_cb, input clk, rst_n);        
  modport monitor_mp(clocking monitor_cb, input clk, rst_n);
endinterface

// ====================== 第四步：通用配置类（复用之前的） ======================
typedef enum {MASTER, SLAVE} handshake_side_e;
class simple_handshake_config #(parameter DATA_WIDTH = 32) extends uvm_object;
  `uvm_object_param_utils(simple_handshake_config#(DATA_WIDTH))

  handshake_side_e monitor_side;
  bit enable_protocol_checks = 1'b1;
  string default_dump_file = "tsu_nsu_wcmd_dump.txt";

  function new(string name = "simple_handshake_config");
    super.new(name);
  endfunction
endclass

// ====================== 第五步：通用握手Monitor（复用之前的） ======================
class simple_handshake_monitor #(parameter DATA_WIDTH = 32) extends uvm_monitor;
  `uvm_component_param_utils(simple_handshake_monitor#(DATA_WIDTH))

  logic [DATA_WIDTH-1:0] dump_data[];
  simple_handshake_config#(DATA_WIDTH) cfg;
  int file_handle;

  uvm_analysis_port #(uvm_sequence_item) ap;

  logic                   valid_data_check_flag;
  logic [DATA_WIDTH-1:0]  tr_data_check;

  virtual simple_handshake_interface#(DATA_WIDTH) vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
    dump_data = {};
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(simple_handshake_config#(DATA_WIDTH))::get(this, "", "handshake_cfg", cfg)) begin
      `uvm_fatal(get_full_name(), "Handshake config not found in uvm_config_db")
    end
    if (!uvm_config_db#(virtual simple_handshake_interface#(DATA_WIDTH))::get(this, "", "handshake_vif", vif)) begin
      `uvm_fatal(get_full_name(), "Virtual handshake interface not found!")
    end
  endfunction

  virtual function bit get_valid();
    return vif.monitor_cb.valid;
  endfunction

  virtual function bit get_rdy();
    return vif.monitor_cb.rdy;
  endfunction

  virtual function logic [DATA_WIDTH-1:0] get_tr_data();
    return vif.monitor_cb.tr_data;
  endfunction

  virtual task wait_monitor_cb();
    @(vif.monitor_cb);
  endtask

  virtual function void dump_all_data(string file_name = "");
    if (file_name == "") begin
      file_name = cfg.default_dump_file;
      `uvm_warning(get_full_name(), $sformatf("File name empty, use default: %s", file_name))
    end

    file_handle = $fopen(file_name, "w");
    if (file_handle == 0) begin
      `uvm_error(get_full_name(), $sformatf("Open file %s failed!", file_name))
      return;
    end

    `uvm_info(get_full_name(), $sformatf("Dump %0d data to %s (monitor side: %0s)", dump_data.size(), file_name, cfg.monitor_side.name()), UVM_MEDIUM)
    foreach(dump_data[i]) begin
      $fdisplay(file_handle, "0x%0h", dump_data[i]);
    end
    $fclose(file_handle);
  endfunction

  virtual task monitor_transaction();
    uvm_sequence_item tr;

    if (get_valid() === 1'b1 && get_rdy() === 1'b0) begin
      valid_data_check_flag = 1'b1;
      tr_data_check = get_tr_data();
    end

    if (get_valid() === 1'b1 && get_rdy() === 1'b1) begin
      tr = uvm_sequence_item::type_id::create("tr");
      dump_data.push_back(get_tr_data());
      ap.write(tr);
      valid_data_check_flag = 1'b0;

      `uvm_info(get_full_name(), $sformatf("[%0s] Capture transaction: data=0x%0h", cfg.monitor_side.name(), get_tr_data()), UVM_HIGH)
    end
  endtask

  virtual task perform_protocol_checks();
    if (!cfg.enable_protocol_checks || !vif.monitor_cb.rst_n) return; // 复位时关闭检查

    if (get_valid() === 1'b1 && $isunknown(get_tr_data())) begin
      `uvm_error(get_full_name(), $sformatf("[%0s] Data has X/Z when valid=1: 0x%0h", cfg.monitor_side.name(), get_tr_data()))
    end

    if (valid_data_check_flag) begin
      if (get_valid() == 1'b0) begin
        `uvm_error(get_full_name(), $sformatf("[%0s] valid changed to 0 before rdy=1!", cfg.monitor_side.name()))
      end
      if (get_tr_data() != tr_data_check) begin
        `uvm_error(get_full_name(), $sformatf("[%0s] data changed when valid=1 & rdy=0: 0x%0h", cfg.monitor_side.name(), get_tr_data()))
      end
    end
  endtask

  virtual task run_phase(uvm_phase phase);
    forever begin
      wait_monitor_cb();
      if (vif.monitor_cb.rst_n) begin // 复位释放后才监控
        monitor_transaction();
        perform_protocol_checks();
      end else begin
        valid_data_check_flag = 1'b0; // 复位清空检查标志
      end
    end
  endtask

endclass

// ====================== 第六步：新增Driver（产生TSU-NSU握手激励） ======================
class tsu_nsu_wcmd_driver extends uvm_driver;
  `uvm_component_utils(tsu_nsu_wcmd_driver)

  // 原始接口句柄
  virtual tsu_nsu_wcmd_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual tsu_nsu_wcmd_if)::get(this, "", "tsu_nsu_wcmd_vif", vif)) begin
      `uvm_fatal(get_full_name(), "TSU-NSU interface not found in config db!")
    end
  endfunction

  // 核心：产生握手激励（模拟Master侧发写命令）
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);

    // 复位释放后初始化
    wait(vif.driver_cb.rst_n);
    vif.driver_cb.tsu_nsu_wcmd_vld <= 1'b0;
    vif.driver_cb.tsu_nsu_wcmd     <= '0;
    @(vif.driver_cb);

    // 产生5笔握手事务（模拟真实激励）
    for (int i=0; i<5; i++) begin
      // 1. 置位valid和随机数据
      vif.driver_cb.tsu_nsu_wcmd_vld <= 1'b1;
      vif.driver_cb.tsu_nsu_wcmd     <= $random(); // 随机写命令
      `uvm_info(get_full_name(), $sformatf("Drive wcmd_vld=1, wcmd=0x%0h", vif.driver_cb.tsu_nsu_wcmd), UVM_MEDIUM)

      // 2. 等待Slave侧rdy=1（握手完成）
      while (!vif.driver_cb.tsu_nsu_wcmd_rdy) begin
        @(vif.driver_cb);
        `uvm_info(get_full_name(), "Wait wcmd_rdy=1...", UVM_LOW)
      end

      // 3. 握手完成，拉低valid
      @(vif.driver_cb);
      vif.driver_cb.tsu_nsu_wcmd_vld <= 1'b0;
      `uvm_info(get_full_name(), $sformatf("Handshake done for trans %0d", i), UVM_MEDIUM)

      // 4. 间隔2个时钟再发下一笔
      repeat(2) @(vif.driver_cb);
    end

    phase.drop_objection(this);
  endtask

endclass

// ====================== 第七步：Agent（封装Driver+Monitor） ======================
class tsu_nsu_wcmd_agent extends uvm_agent;
  `uvm_component_utils(tsu_nsu_wcmd_agent)

  // 组件实例
  tsu_nsu_wcmd_driver                driver;
  simple_handshake_monitor#(DATA_WIDTH) monitor;
  simple_handshake_config#(DATA_WIDTH) cfg;

  // 接口句柄
  virtual tsu_nsu_wcmd_if                tsu_nsu_vif;
  virtual simple_handshake_interface#(DATA_WIDTH) handshake_vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // 1. 获取原始接口
    if (!uvm_config_db#(virtual tsu_nsu_wcmd_if)::get(this, "", "tsu_nsu_wcmd_vif", tsu_nsu_vif)) begin
      `uvm_fatal(get_full_name(), "TSU-NSU interface not found!")
    end

    // 2. 实例化配置类
    cfg = simple_handshake_config#(DATA_WIDTH)::type_id::create("cfg");
    cfg.monitor_side = MASTER; // 你的接口是Master侧
    cfg.default_dump_file = "tsu_nsu_wcmd_dump.txt";

    // 3. 实例化Driver（ACTIVE模式）
    driver = tsu_nsu_wcmd_driver::type_id::create("driver", this);

    // 4. 实例化Monitor
    monitor = simple_handshake_monitor#(DATA_WIDTH)::type_id::create("monitor", this);

    // 5. 配置DB传递（Driver用原始接口，Monitor用通用接口）
    uvm_config_db#(virtual tsu_nsu_wcmd_if)::set(this, "driver", "tsu_nsu_wcmd_vif", tsu_nsu_vif);
    uvm_config_db#(simple_handshake_config#(DATA_WIDTH))::set(this, "monitor", "handshake_cfg", cfg);
    uvm_config_db#(virtual simple_handshake_interface#(DATA_WIDTH))::set(this, "monitor", "handshake_vif", handshake_vif);
  endfunction

endclass

// ====================== 第八步：Env（封装Agent） ======================
class tsu_nsu_env extends uvm_env;
  `uvm_component_utils(tsu_nsu_env)

  tsu_nsu_wcmd_agent agent;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent = tsu_nsu_wcmd_agent::type_id::create("agent", this);
  endfunction

  // 仿真结束前触发数据Dump
  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    agent.monitor.dump_all_data();
  endfunction

endclass

// ====================== 第九步：Testcase（顶层配置） ======================
class tsu_nsu_base_test extends uvm_test;
  `uvm_component_utils(tsu_nsu_base_test)

  tsu_nsu_env env;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = tsu_nsu_env::type_id::create("env", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    // 仿真总时长：100个时钟周期
    phase.raise_objection(this);
    repeat(100) @(posedge tb_top.clk);
    phase.drop_objection(this);
  endtask

endclass

// ====================== 第十步：TB顶层（时钟/复位/接口实例化/信号映射） ======================
module tb_top;
  // 时钟/复位
  logic clk;
  logic rst_n;

  // 1. 实例化原始接口
  tsu_nsu_wcmd_if tsu_nsu_wcmd_vif(clk, rst_n);

  // 2. 实例化通用握手接口（信号映射核心）
  simple_handshake_interface#(DATA_WIDTH) handshake_vif(clk, rst_n);
  // 映射规则：原始信号 → 通用接口信号
  assign handshake_vif.valid    = tsu_nsu_wcmd_vif.tsu_nsu_wcmd_vld;
  assign handshake_vif.rdy      = tsu_nsu_wcmd_vif.tsu_nsu_wcmd_rdy;
  assign handshake_vif.tr_data  = tsu_nsu_wcmd_vif.tsu_nsu_wcmd;

  // 3. 模拟Slave侧rdy响应（让握手能完成）
  initial begin
    tsu_nsu_wcmd_vif.tsu_nsu_wcmd_rdy <= 1'b0;
    wait(rst_n);
    forever begin
      @(posedge clk);
      // 随机拉高低rdy（模拟Slave侧就绪状态）
      tsu_nsu_wcmd_vif.tsu_nsu_wcmd_rdy <= $random() % 2;
    end
  end

  // 4. 生成时钟
  initial begin
    clk = 1'b0;
    forever #(CLK_PERIOD/2) clk = ~clk;
  end

  // 5. 生成复位（100ns后释放）
  initial begin
    rst_n = 1'b0;
    #100;
    rst_n = 1'b1;
    `uvm_info("TB_TOP", "Reset released!", UVM_MEDIUM)
  end

  // 6. UVM仿真启动
  initial begin
    // 将接口写入全局config DB
    uvm_config_db#(virtual tsu_nsu_wcmd_if)::set(uvm_root::get(), "*", "tsu_nsu_wcmd_vif", tsu_nsu_wcmd_vif);
    uvm_config_db#(virtual simple_handshake_interface#(DATA_WIDTH))::set(uvm_root::get(), "*", "handshake_vif", handshake_vif);
    
    // 启动Testcase
    run_test("tsu_nsu_base_test");
  end

endmodule