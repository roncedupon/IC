`timescale 1ns/1ps

`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;


// ============================================================
// Transaction
// ============================================================
class tsu2nsu_transaction extends uvm_sequence_item;

  // -------------------------
  // RCMD 字段
  // -------------------------
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

  // 其他字段
  rand bit [63:0]  other_field1;
  rand bit [127:0] other_field2;

  // -------------------------
  // UVM 注册（保持自动化功能）
  // -------------------------
  `uvm_object_utils_begin(tsu2nsu_transaction)

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

    // `uvm_field_int(other_field1, UVM_ALL_ON)
    // `uvm_field_int(other_field2, UVM_ALL_ON)

  `uvm_object_utils_end


  function new(string name="tsu2nsu_transaction");
    super.new(name);
  endfunction


  // ============================================================
  // ✅ 重写 do_print —— 只打印 RCMD 字段
  // ============================================================
// 替换你原来的 print_rcmd_fields 方法
  function void print_rcmd_fields();
    uvm_printer printer;
    printer = uvm_default_printer; 

    `uvm_info("PRINT_RCMD", "============= RCMD Fields Start =============", UVM_LOW)

    // 2. 将数据手动推入打印器（不需要修改对象的打印配置，没有任何副作用）
    printer.print_field("rcmd_nsu_addr_l",   this.rcmd_nsu_addr_l,   32);
    printer.print_field("rcmd_nsu_addr_h",   this.rcmd_nsu_addr_h,   32);
    printer.print_field("rcmd_length",       this.rcmd_length,       16);
    printer.print_field("rcmd_ost_id",       this.rcmd_ost_id,        8);
    printer.print_field("rcmd_mask_l",       this.rcmd_mask_l,       32);
    printer.print_field("rcmd_mask_h",       this.rcmd_mask_h,       32);
    printer.print_field("rcmd_rsv2",         this.rcmd_rsv2,         16);
    printer.print_field("rcmd_end_flag",     this.rcmd_end_flag,      1); // flag通常用二进制看更直观
    printer.print_field("rcmd_start_flag",   this.rcmd_start_flag,    1);
    printer.print_field("rcmd_rsv3",         this.rcmd_rsv3,          8);
    printer.print_field("rcmd_fast_read_flag",this.rcmd_fast_read_flag,1);
    printer.print_field("rcmd_io_read_flag", this.rcmd_io_read_flag,  1);
    printer.print_field("rcmd_nsu_hw_sw",    this.rcmd_nsu_hw_sw,     1);
    printer.print_field("rcmd_vld_num",      this.rcmd_vld_num,       4); // 数量通常用十进制看更直观


    `uvm_info("PRINT_RCMD", "============= RCMD Fields End ===============", UVM_LOW)
  endfunction

endclass



// ============================================================
// Test Module
// ============================================================
module uvm_print_demo;

  initial begin

    tsu2nsu_transaction trans;

    trans = tsu2nsu_transaction::type_id::create("trans");

    if (!trans.randomize()) begin
      `uvm_fatal("RAND_FAIL", "Randomization failed")
    end

    `uvm_info("DEMO", "============= Print Transaction =============", UVM_LOW)

    // 现在 print() 只会打印 RCMD 字段
    trans.print_rcmd_fields();
    `uvm_info("DEMO", "============= Print Transaction done=============", UVM_LOW)
    $finish;
  end

endmodule