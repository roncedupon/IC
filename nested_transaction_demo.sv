`ifndef NESTED_TRANSACTION_DEMO_SV
`define NESTED_TRANSACTION_DEMO_SV
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;


// 内部transaction类
class inner_transaction extends uvm_object;
  `uvm_object_utils(inner_transaction)
  
  rand int id;
  rand bit [7:0] value;
  rand string name;
  
  // 构造函数
  function new(string name = "inner_transaction");
    super.new(name);
  endfunction
  
  // 约束
  constraint c_id { id inside {[0:99]}; }
  constraint c_value { value inside {[0:255]}; }
  constraint c_name { name dist {
    "A" := 1,
    "B" := 1,
    "C" := 1
  }; }
endclass

// 外部transaction类
class outer_transaction extends uvm_object;
  `uvm_object_utils(outer_transaction)
  
  rand int id;
  rand bit [15:0] data;
  rand inner_transaction inner;
  
  // 构造函数
  function new(string name = "outer_transaction");
    super.new(name);
    // 创建内部transaction实例
    inner = inner_transaction::type_id::create("inner");
  endfunction
  
  // 约束
  constraint c_id { id inside {[100:199]}; }
  constraint c_data { data inside {[0:65535]}; }
endclass

// 测试模块
module test_nested_transaction;
  outer_transaction outer;
  
  initial begin
    $display("=== Nested Transaction Demo ===");
    
    // 创建外部transaction实例
    outer = outer_transaction::type_id::create("outer");
    
    // 随机化
    if (!outer.randomize()) begin
      `uvm_error("test", "Randomization failed");
    end
    
    // 使用UVM自带的print方法打印
    $display("\n1. Using uvm_object::print():");
    outer.print();
    
    // 再次随机化
    if (!outer.randomize()) begin
      `uvm_error("test", "Randomization failed");
    end
    
    // 使用UVM自带的print方法打印，指定深度
    $display("\n2. Using uvm_object::print() with depth=2:");
    outer.print(2);
    
    // 再次随机化
    if (!outer.randomize()) begin
      `uvm_error("test", "Randomization failed");
    end
    
    // 使用UVM自带的sprint方法（返回字符串）
    $display("\n3. Using uvm_object::sprint():");
    $display("%s", outer.sprint());
    
    $display("\n=== Demo Complete ===");
  end
endmodule

`endif // NESTED_TRANSACTION_DEMO_SV
