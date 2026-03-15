`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;

// 简单测试类
class my_test extends uvm_test;
  `uvm_component_utils(my_test)

  function new(string name="my_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  // 任务：输入参数 data 默认值 = $random
  task my_task(int data = $random);
    `uvm_info("TASK", $sformatf("data = 0x%08h", data), UVM_LOW)
  endtask

  task run_phase(uvm_phase phase);
    int my_data;
    my_data=345;
    // 1. 用命令行 +uvm_set_config 传值
    //    如果没传，就用默认值 $random
    if (!uvm_config_db#(int)::get(this, "", "my_data", my_data)) begin
      `uvm_info("CFG", "No cmdline config, use default $random", UVM_LOW)
      my_task(); // 使用默认值
    end
    `uvm_info("CFG", $sformatf("Use cmdline data: 0x%08h", 345), UVM_LOW)
    my_task(.data(10>2?7:8)); // 使用命令行传入值
  endtask
endclass

module top;
  initial begin
    run_test("my_test");
  end
endmodule