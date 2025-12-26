`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;

// // 时钟定义（顶层传递）
// `ifndef CLK_DEF
// `define CLK_DEF
// logic clk;
// `endif

// -------------------------- Master 接口（主动发起握手） --------------------------
interface simple_handshake_master_interface #(parameter DATA_WIDTH = 32) (input logic clk);  
  // 握手信号：master输出valid/data，输入rdy
  logic                  m_valid;         
  logic                  m_rdy;
  logic [DATA_WIDTH-1:0] m_tr_data;   
  
  // Driver/Monitor clocking块（沿posedge clk采样）
  clocking driver_cb @(posedge clk);            
    output m_valid, m_tr_data;  // master驱动valid/data
    input  m_rdy;               // master采样slave的rdy
  endclocking   
             
  clocking monitor_cb @(posedge clk);            
    input m_valid, m_rdy, m_tr_data;  // monitor采样所有信号
  endclocking

  modport master_mp(clocking driver_cb, input clk);        
  modport monitor_mp(clocking monitor_cb, input clk);  
endinterface

// -------------------------- Slave 接口（被动响应握手） --------------------------
interface simple_handshake_slave_interface #(parameter DATA_WIDTH = 32) (input logic clk);  
  // 握手信号：slave输入valid/data，输出rdy
  logic                  s_valid;         
  logic                  s_rdy;
  logic [DATA_WIDTH-1:0] s_tr_data;   
  
  // Driver/Monitor clocking块（沿posedge clk采样）
  clocking driver_cb @(posedge clk);            
    input  s_valid, s_tr_data;  // slave采样master的valid/data
    output s_rdy;               // slave驱动rdy
  endclocking   
             
  clocking monitor_cb @(posedge clk);            
    input s_valid, s_rdy, s_tr_data;  // monitor采样所有信号
  endclocking

  modport slave_mp(clocking driver_cb, input clk);        
  modport monitor_mp(clocking monitor_cb, input clk);  
endinterface

class simple_handshake_base_config #(parameter DATA_WIDTH = 32) extends uvm_object;
  `uvm_object_param_utils(simple_handshake_base_config#(DATA_WIDTH))

  // 通用配置
  // int unsigned DATA_WIDTH = DATA_WIDTH;          // 数据位宽
  bit enable_protocol_checks = 1'b1;             // 协议检查开关
  string default_dump_file = "handshake_dump.txt";// 默认dump文件

  function new(string name = "simple_handshake_base_config");
    super.new(name);
  endfunction
endclass

// Slave 专属配置（可扩展slave特有配置）
class simple_handshake_slave_config #(parameter DATA_WIDTH = 32) extends simple_handshake_base_config#(DATA_WIDTH);
  `uvm_object_param_utils(simple_handshake_slave_config#(DATA_WIDTH))
  function new(string name = "simple_handshake_slave_config");
    super.new(name);
  endfunction
endclass

// Master 专属配置（可扩展master特有配置）
class simple_handshake_master_config #(parameter DATA_WIDTH = 32) extends simple_handshake_base_config#(DATA_WIDTH);
  `uvm_object_param_utils(simple_handshake_master_config#(DATA_WIDTH))
  function new(string name = "simple_handshake_master_config");
    super.new(name);
  endfunction
endclass


// 定义握手monitor的行为接口类（仅声明纯虚方法）
// interface class handshake_monitor_if #(parameter DATA_WIDTH = 32);
//   pure virtual function bit get_valid();                // 获取valid信号
//   pure virtual function bit get_rdy();                  // 获取rdy信号
//   pure virtual function logic [DATA_WIDTH-1:0] get_tr_data(); // 获取数据
//   pure virtual task wait_monitor_cb();                  // 等待clocking块
// endclass

class simple_handshake_base_monitor #(parameter DATA_WIDTH = 32) extends uvm_monitor ; // 实现行为接口类

  `uvm_component_param_utils(simple_handshake_base_monitor#(DATA_WIDTH))

  // 通用属性
  logic [DATA_WIDTH-1:0] dump_data[];  // 存储监控的所有数据
  simple_handshake_base_config#(DATA_WIDTH) cfg; // 公共配置
  int file_handle;

  // 分析端口（传递监控到的事务）
  uvm_analysis_port #(uvm_sequence_item) ap;

  // 协议检查临时变量（通用）
  logic                   valid_data_check_flag;
  logic [DATA_WIDTH-1:0]  tr_data_check;

  // -------------------------- 修正：改为普通virtual方法（留空实现） --------------------------
  virtual function bit get_valid();                return 1'b0; endfunction
  virtual function bit get_rdy();                  return 1'b0; endfunction
  virtual function logic [DATA_WIDTH-1:0] get_tr_data(); return '0; endfunction
  virtual task wait_monitor_cb();                  endtask

  // -------------------------- 构造函数 --------------------------
  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
    dump_data = {};
  endfunction

  // -------------------------- 通用Build阶段 --------------------------
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // 获取配置（子类需保证cfg已通过uvm_config_db传入）
    if (!uvm_config_db#(simple_handshake_base_config#(DATA_WIDTH))::get(this, "", "handshake_cfg", cfg)) begin
      `uvm_fatal("BASE_MON", "Handshake config not found in uvm_config_db")
    end
  endfunction

  // -------------------------- 通用数据Dump功能 --------------------------
  virtual function void dump_all_data(string file_name = "");
    if (file_name == "") begin
      file_name = cfg.default_dump_file;
      `uvm_warning("BASE_MON", $sformatf("File name empty, use default: %s", file_name))
    end

    file_handle = $fopen(file_name, "w");
    if (file_handle == 0) begin
      `uvm_error("BASE_MON", $sformatf("Open file %s failed!", file_name))
      return;
    end

    `uvm_info("BASE_MON", $sformatf("Dump %0d data to %s", dump_data.size(), file_name), UVM_MEDIUM)
    foreach(dump_data[i]) begin
      $fdisplay(file_handle, "0x%0h", dump_data[i]);
    end
    $fclose(file_handle);
  endfunction

  // -------------------------- 通用Run阶段 --------------------------
  virtual task run_phase(uvm_phase phase);
    forever begin
      wait_monitor_cb();  // 等待clocking块（子类重写实现）
      monitor_transaction(); // 监控事务（子类重写实现）
      perform_protocol_checks(); // 协议检查（子类重写实现）
    end
  endtask

  // -------------------------- 需子类重写的核心方法 --------------------------
  virtual task monitor_transaction(); endtask
  virtual task perform_protocol_checks(); endtask

endclass

class simple_handshake_slave_monitor #(parameter DATA_WIDTH = 32) 
  extends simple_handshake_base_monitor#(DATA_WIDTH);

  `uvm_component_param_utils(simple_handshake_slave_monitor#(DATA_WIDTH))

  // 绑定slave接口
  virtual simple_handshake_slave_interface#(DATA_WIDTH) vif;

  // 事务类型（可替换为自定义slave事务）
  typedef uvm_sequence_item tr_t;

  // -------------------------- 重写基类方法（实现具体接口访问） --------------------------
  virtual function bit get_valid();
    return vif.monitor_cb.s_valid;
  endfunction

  virtual function bit get_rdy();
    return vif.monitor_cb.s_rdy;
  endfunction

  virtual function logic [DATA_WIDTH-1:0] get_tr_data();
    return vif.monitor_cb.s_tr_data;
  endfunction

  virtual task wait_monitor_cb();
    @(vif.monitor_cb);
  endtask

  // -------------------------- 构造函数 --------------------------
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // -------------------------- Build阶段：获取接口 --------------------------
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // 获取slave接口
    if (!uvm_config_db#(virtual simple_handshake_slave_interface#(DATA_WIDTH))::get(this, "", "slave_handshake_vif", vif)) begin
      `uvm_fatal("SLAVE_MON", "Virtual slave interface not found!")
    end
  endfunction

  // -------------------------- 监控Slave侧事务 --------------------------
  virtual task monitor_transaction();
    tr_t tr;

    // 1. 记录valid=1但rdy=0时的初始数据（协议检查用）
    if (get_valid() === 1'b1 && get_rdy() === 1'b0) begin
      valid_data_check_flag = 1'b1;
      tr_data_check = get_tr_data();
    end

    // 2. 捕获完整握手（valid=1 & rdy=1）
    if (get_valid() === 1'b1 && get_rdy() === 1'b1) begin
      tr = tr_t::type_id::create("tr");
      // 给事务赋值（自定义事务需扩展此部分）
      if ($cast(tr, tr)) begin
        // 示例：若自定义事务有tr_data字段，需赋值
        // tr.tr_data = get_tr_data();
      end
      dump_data.push_back(get_tr_data()); // 存储数据
      ap.write(tr); // 发送到analysis port
      valid_data_check_flag = 1'b0;

      `uvm_info("SLAVE_MON", $sformatf("Capture slave transaction: data=0x%0h", get_tr_data()), UVM_HIGH)
    end
  endtask

  // -------------------------- Slave侧协议检查 --------------------------
  virtual task perform_protocol_checks();
    if (!cfg.enable_protocol_checks) return;

    // 检查1：valid=1时数据不能有X/Z
    if (get_valid() === 1'b1 && $isunknown(get_tr_data())) begin
      `uvm_error("SLAVE_MON", $sformatf("Data has X/Z when s_valid=1: 0x%0h", get_tr_data()))
    end

    // 检查2：valid=1 & rdy=0时，valid/data不能变化
    if (valid_data_check_flag) begin
      if (get_valid() == 1'b0) begin
        `uvm_error("SLAVE_MON", "s_valid changed to 0 before s_rdy=1!")
      end
      if (get_tr_data() != tr_data_check) begin
        `uvm_error("SLAVE_MON", $sformatf("s_tr_data changed when s_valid=1 & s_rdy=0: 0x%0h", get_tr_data()))
      end
    end
  endtask

endclass


class simple_handshake_master_monitor #(parameter DATA_WIDTH = 32) 
  extends simple_handshake_base_monitor#(DATA_WIDTH);

  `uvm_component_param_utils(simple_handshake_master_monitor#(DATA_WIDTH))

  // 绑定master接口
  virtual simple_handshake_master_interface#(DATA_WIDTH) vif;

  // 事务类型（可替换为自定义master事务）
  typedef uvm_sequence_item tr_t;

  // -------------------------- 重写基类方法（实现具体接口访问） --------------------------
  virtual function bit get_valid();
    return vif.monitor_cb.m_valid;
  endfunction

  virtual function bit get_rdy();
    return vif.monitor_cb.m_rdy;
  endfunction

  virtual function logic [DATA_WIDTH-1:0] get_tr_data();
    return vif.monitor_cb.m_tr_data;
  endfunction

  virtual task wait_monitor_cb();
    @(vif.monitor_cb);
  endtask

  // -------------------------- 构造函数 --------------------------
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // -------------------------- Build阶段：获取接口 --------------------------
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // 获取master接口
    if (!uvm_config_db#(virtual simple_handshake_master_interface#(DATA_WIDTH))::get(this, "", "master_handshake_vif", vif)) begin
      `uvm_fatal("MASTER_MON", "Virtual master interface not found!")
    end
  endfunction

  // -------------------------- 监控Master侧事务 --------------------------
  virtual task monitor_transaction();
    tr_t tr;

    // 1. 记录valid=1但rdy=0时的初始数据（协议检查用）
    if (get_valid() === 1'b1 && get_rdy() === 1'b0) begin
      valid_data_check_flag = 1'b1;
      tr_data_check = get_tr_data();
    end

    // 2. 捕获完整握手（valid=1 & rdy=1）
    if (get_valid() === 1'b1 && get_rdy() === 1'b1) begin
      tr = tr_t::type_id::create("tr");
      // 给事务赋值（自定义事务需扩展此部分）
      if ($cast(tr, tr)) begin
        // 示例：若自定义事务有tr_data字段，需赋值
        // tr.tr_data = get_tr_data();
      end
      dump_data.push_back(get_tr_data()); // 存储数据
      ap.write(tr); // 发送到analysis port
      valid_data_check_flag = 1'b0;

      `uvm_info("MASTER_MON", $sformatf("Capture master transaction: data=0x%0h", get_tr_data()), UVM_HIGH)
    end
  endtask

  // -------------------------- Master侧协议检查 --------------------------
  virtual task perform_protocol_checks();
    if (!cfg.enable_protocol_checks) return;

    // 检查1：valid=1时数据不能有X/Z
    if (get_valid() === 1'b1 && $isunknown(get_tr_data())) begin
      `uvm_error("MASTER_MON", $sformatf("Data has X/Z when m_valid=1: 0x%0h", get_tr_data()))
    end

    // 检查2：valid=1 & rdy=0时，valid/data不能变化
    if (valid_data_check_flag) begin
      if (get_valid() == 1'b0) begin
        `uvm_error("MASTER_MON", "m_valid changed to 0 before m_rdy=1!")
      end
      if (get_tr_data() != tr_data_check) begin
        `uvm_error("MASTER_MON", $sformatf("m_tr_data changed when m_valid=1 & m_rdy=0: 0x%0h", get_tr_data()))
      end
    end
  endtask

endclass