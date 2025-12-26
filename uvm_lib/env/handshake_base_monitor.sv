`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;

// -------------------------- 接口侧别枚举（仅用于日志区分） --------------------------
typedef enum {MASTER, SLAVE} handshake_side_e;

// -------------------------- 统一握手接口（核心：消除m/s拆分） --------------------------
interface simple_handshake_interface #(parameter DATA_WIDTH = 32) (input logic clk);  
  // 统一信号名（去掉m_/s_前缀）
  logic                  valid;         
  logic                  rdy;
  logic [DATA_WIDTH-1:0] tr_data;   
  
  // Master侧Driver：驱动valid/tr_data，采样rdy
  clocking master_driver_cb @(posedge clk);            
    output valid, tr_data;            
    input  rdy;        
  endclocking   
  
  // Slave侧Driver：驱动rdy，采样valid/tr_data
  clocking slave_driver_cb @(posedge clk);            
    input  valid, tr_data;            
    output rdy;        
  endclocking   
             
  // 通用Monitor clocking：仅采样所有信号（master/slave侧监控逻辑一致）
  clocking monitor_cb @(posedge clk);            
    input valid, rdy, tr_data;        
  endclocking

  // Modport区分master/slave的驱动方向（仅Driver侧有差异，Monitor侧通用）
  modport master_mp(clocking master_driver_cb, input clk);        
  modport slave_mp(clocking slave_driver_cb, input clk);        
  modport monitor_mp(clocking monitor_cb, input clk);  // 通用Monitor modport
endinterface

// -------------------------- 通用配置类（简化：仅日志侧别+基础配置） --------------------------
class simple_handshake_config #(parameter DATA_WIDTH = 32) extends uvm_object;
  `uvm_object_param_utils(simple_handshake_config#(DATA_WIDTH))

  // 仅用于日志标注：当前监控的是master侧还是slave侧
  handshake_side_e monitor_side;
  // 通用配置
  bit enable_protocol_checks = 1'b1;
  string default_dump_file = "handshake_dump.txt";

  function new(string name = "simple_handshake_config");
    super.new(name);
  endfunction
endclass

// -------------------------- 通用握手Monitor（完全无需区分m/s接口） --------------------------
class simple_handshake_monitor #(parameter DATA_WIDTH = 32) extends uvm_monitor;
  `uvm_component_param_utils(simple_handshake_monitor#(DATA_WIDTH))

  // 通用属性
  logic [DATA_WIDTH-1:0] dump_data[];
  simple_handshake_config#(DATA_WIDTH) cfg;
  int file_handle;

  // 分析端口
  uvm_analysis_port #(uvm_sequence_item) ap;

  // 协议检查临时变量
  logic                   valid_data_check_flag;
  logic [DATA_WIDTH-1:0]  tr_data_check;

  // 核心简化：仅保留一个统一的握手接口句柄（无m_vif/s_vif区分）
  virtual simple_handshake_interface#(DATA_WIDTH) vif;

  // -------------------------- 构造函数 --------------------------
  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
    dump_data = {};
  endfunction

  // -------------------------- Build阶段（仅获取统一接口，无分支） --------------------------
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // 获取配置
    if (!uvm_config_db#(simple_handshake_config#(DATA_WIDTH))::get(this, "", "handshake_cfg", cfg)) begin
      `uvm_fatal(get_full_name(), "Handshake config not found in uvm_config_db")
    end
    // 获取统一接口（无需区分m/s，直接绑定）
    if (!uvm_config_db#(virtual simple_handshake_interface#(DATA_WIDTH))::get(this, "", "handshake_vif", vif)) begin
      `uvm_fatal(get_full_name(), "Virtual handshake interface not found!")
    end
  endfunction

  // -------------------------- 统一信号访问（无分支，直接访问通用信号名） --------------------------
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

  // -------------------------- 通用数据Dump功能 --------------------------
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

  // -------------------------- 核心监控逻辑（完全通用，无m/s区分） --------------------------
  virtual task monitor_transaction();
    uvm_sequence_item tr;

    // 1. 记录valid=1但rdy=0时的初始数据
    if (get_valid() === 1'b1 && get_rdy() === 1'b0) begin
      valid_data_check_flag = 1'b1;
      tr_data_check = get_tr_data();
    end

    // 2. 捕获完整握手（valid=1 & rdy=1）
    if (get_valid() === 1'b1 && get_rdy() === 1'b1) begin
      tr = uvm_sequence_item::type_id::create("tr");
      dump_data.push_back(get_tr_data());
      ap.write(tr);
      valid_data_check_flag = 1'b0;

      `uvm_info(get_full_name(), $sformatf("[%0s] Capture transaction: data=0x%0h", cfg.monitor_side.name(), get_tr_data()), UVM_HIGH)
    end
  endtask

  // -------------------------- 通用协议检查（无m/s区分） --------------------------
  virtual task perform_protocol_checks();
    if (!cfg.enable_protocol_checks) return;

    // 检查1：valid=1时数据不能有X/Z
    if (get_valid() === 1'b1 && $isunknown(get_tr_data())) begin
      `uvm_error(get_full_name(), $sformatf("[%0s] Data has X/Z when valid=1: 0x%0h", cfg.monitor_side.name(), get_tr_data()))
    end

    // 检查2：valid=1 & rdy=0时，valid/data不能变化
    if (valid_data_check_flag) begin
      if (get_valid() == 1'b0) begin
        `uvm_error(get_full_name(), $sformatf("[%0s] valid changed to 0 before rdy=1!", cfg.monitor_side.name()))
      end
      if (get_tr_data() != tr_data_check) begin
        `uvm_error(get_full_name(), $sformatf("[%0s] data changed when valid=1 & rdy=0: 0x%0h", cfg.monitor_side.name(), get_tr_data()))
      end
    end
  endtask

  // -------------------------- Run阶段（极简循环） --------------------------
  virtual task run_phase(uvm_phase phase);
    forever begin
      wait_monitor_cb();
      monitor_transaction();
      perform_protocol_checks();
    end
  endtask

endclass