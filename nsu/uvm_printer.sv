
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
// 1. 定义一个简单的UVM事务类（模拟你的tsu2nsu_transaction）
class my_transaction extends uvm_sequence_item;
  // 定义多个测试字段（模拟你的tr_type、tsu_nsu_wcmd、wcmd_flag等）
  int a;          // 需要打印的字段1
  int b;          // 不需要打印的字段
  bit [7:0] c;    // 需要打印的字段2
  string d;       // 不需要打印的字段

  // UVM宏注册（保持默认即可，无需修改宏参数）
  `uvm_object_utils(my_transaction)

  // 构造函数
  function new(string name = "my_transaction");
    super.new(name);
  endfunction
endclass

// 2. 测试模块（核心演示逻辑）
module test_printer_demo;
  initial begin
    // 创建事务实例并赋值
    uvm_table_printer my_printer;    
    my_transaction tr = new();
    tr.a = 100;
    tr.b = 200;
    tr.c = 8'hAB;
    tr.d = "hello";

    // ========== 核心：创建自定义printer，仅包含需要的字段 ==========
    my_printer = new();  // 创建表格型printer（UVM默认格式）
    my_printer.include_field("a");         // 仅包含字段a
    my_printer.include_field("c");         // 仅包含字段c
    // 注意：不写的字段会被自动排除，无需额外排除

    // ========== 打印对比 ==========
    $display("===== 默认打印（所有字段） =====");
    tr.print();  // 默认打印所有字段（a/b/c/d）

    $display("\n===== 自定义打印（仅a和c） =====");
    tr.print(my_printer);  // 仅打印包含的字段（a和c）
  end
endmodule