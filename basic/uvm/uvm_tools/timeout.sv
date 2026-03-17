`timescale 1ns/1ps  // 仿真时间单位：1ns，精度1ps

`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
// 1. 定义简单的测试用例（包含timeout设置 + 模拟耗时逻辑）
class my_test extends uvm_test;
  `uvm_component_utils(my_test)

  function new(string name = "my_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // 在build_phase设置timeout（50ms）
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("BUILD_PHASE", "Set timeout to 50ms in build_phase", UVM_LOW)
    uvm_root::get().set_timeout(50_000_000, 1); // 50ms = 50*1e6 ns
    //50_000_000 对应 50ms，前提是代码中有 timescale 1ns/1ps：1ns = 1×10⁻⁹s → 50_000_000 ns = 50×10⁻³s = 50ms
  endfunction

  // 在start_of_simulation_phase覆盖timeout为80ms（优先级更高）
//   virtual function void start_of_simulation_phase(uvm_phase phase);
//     super.start_of_simulation_phase(phase);
//     `uvm_info("START_SIM_PHASE", "Override timeout to 80ms", UVM_LOW)
//     uvm_top.set_timeout(80_000_000, 1); // 80ms = 80*1e6 ns
//   endfunction

  // 模拟耗时操作（超过80ms，触发timeout）
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this); // 阻止仿真提前结束

    `uvm_info("RUN_PHASE", "Start long-running operation...", UVM_LOW)
    // 模拟90ms的耗时操作（超过80ms的timeout）
    #90_000_000; 
    `uvm_info("RUN_PHASE", "Operation done (won't print, timeout first)", UVM_LOW)

    phase.drop_objection(this);
  endtask
endclass

// 2. 顶层测试模块
module top_tb;
  initial begin
    `uvm_info("TOP_TB", "UVM simulation start", UVM_LOW)
    // 启动测试用例
    run_test("my_test");
  end
endmodule