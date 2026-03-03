`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;

// ===================== 父类：包含所有字段 =====================
class tsu2nsu_transaction extends uvm_sequence_item;
  // 1. 你关心的RCMD字段（需要打印的）
  rand bit [31:0] rcmd_nsu_addr_l;
  rand bit [31:0] rcmd_nsu_addr_h;
  rand bit [15:0] rcmd_length;
  rand bit [7:0]  rcmd_ost_id;
  rand bit [31:0] rcmd_mask_l;
  rand bit [31:0] rcmd_mask_h;
  rand bit [15:0] rcmd_rsv2;
  rand bit        rcmd_end_flag;
  rand bit        rcmd_start_flag;
  rand bit [7:0]  rcmd_rsv3;
  rand bit        rcmd_fast_read_flag;
  rand bit        rcmd_io_read_flag;
  rand bit        rcmd_nsu_hw_sw;
  rand bit [3:0]  rcmd_vld_num;

  // 2. 其他无关字段（不需要打印的）
  rand bit [63:0] other_field1;
  rand bit [127:0] other_field2;
  rand bit [7:0] other_flag;

  // 父类注册：可选（若注册则包含所有字段，不注册则仅子类生效）
  `uvm_object_utils_begin(tsu2nsu_transaction)
    `uvm_field_int(other_field1, UVM_ALL_ON)  // 其他字段
    `uvm_field_int(other_field2, UVM_ALL_ON)
    `uvm_field_int(other_flag, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "tsu2nsu_transaction");
    super.new(name);
  endfunction
endclass

// ===================== 子类：仅注册需要打印的字段 =====================
class tsu2nsu_rcmd_only_trans extends tsu2nsu_transaction;
  // 子类仅注册RCMD相关字段（核心：只保留需要打印的）
  `uvm_object_utils_begin(tsu2nsu_rcmd_only_trans)
    `uvm_field_int(rcmd_nsu_addr_l,  UVM_ALL_ON)
    `uvm_field_int(rcmd_nsu_addr_h,  UVM_ALL_ON)
    `uvm_field_int(rcmd_length,      UVM_ALL_ON)
    `uvm_field_int(rcmd_ost_id,      UVM_ALL_ON)
    `uvm_field_int(rcmd_mask_l,      UVM_ALL_ON)
    `uvm_field_int(rcmd_mask_h,      UVM_ALL_ON)
    `uvm_field_int(rcmd_rsv2,        UVM_ALL_ON)
    `uvm_field_int(rcmd_end_flag,    UVM_ALL_ON)
    `uvm_field_int(rcmd_start_flag,  UVM_ALL_ON)
    `uvm_field_int(rcmd_rsv3,        UVM_ALL_ON)
    `uvm_field_int(rcmd_fast_read_flag, UVM_ALL_ON)
    `uvm_field_int(rcmd_io_read_flag,   UVM_ALL_ON)
    `uvm_field_int(rcmd_nsu_hw_sw,      UVM_ALL_ON)
    `uvm_field_int(rcmd_vld_num,        UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "tsu2nsu_rcmd_only_trans");
    super.new(name);
  endfunction
endclass

// ===================== 测试模块 =====================
module uvm_subclass_print_demo;
  initial begin
    // 1. 创建父类实例（包含所有字段）
    tsu2nsu_transaction parent_trans;
    tsu2nsu_rcmd_only_trans child_trans;    
    parent_trans = tsu2nsu_transaction::type_id::create("parent_trans");
    
    // 2. 创建子类实例（仅打印RCMD字段）

    child_trans = tsu2nsu_rcmd_only_trans::type_id::create("child_trans");

    // 3. 随机化父类（模拟实际数据）
    if(!parent_trans.randomize()) begin
      `uvm_error("RAND_ERR", "Parent transaction randomization failed!")
    end

    // 4. 将父类数据赋值给子类（子类继承所有字段，仅打印注册的）
    child_trans.copy(parent_trans);

    // 5. 打印对比
    // 父类打印：包含所有字段（RCMD + 其他字段）
    `uvm_info("PARENT_PRINT", "============= Parent Transaction (All Fields) =============", UVM_LOW)
    parent_trans.print();

    // 子类打印：仅打印注册的RCMD字段
    `uvm_info("CHILD_PRINT", "============= Child Transaction (Only RCMD Fields) =============", UVM_LOW)
    child_trans.print();

    $finish;
  end
endmodule