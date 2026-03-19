`timescale 1ns/1ps

// 简单的 Verilog 测试，演示 $value$plusargs 的基本用法
module test_args ();
  reg [255:0] testname;
  reg [31:0] num;
  
  initial begin
    $display("=== Testing $value$plusargs ===");
    
    // 第一次调用
    if ($value$plusargs("TESTNAME=%s", testname))
      $display("First call: Running test {%0s}......", testname);
    else 
      testname="default";
    
    if ($value$plusargs("num=%d", num))
      $display("First call: num= {%0d}......", num);
    else
      num=100;
    
    $display("First call: %s---%0d", testname, num);
    
    // 第二次调用（模拟派生类中的调用）
    $display("\nSecond call (simulating derived class):");
    if ($value$plusargs("TESTNAME=%s", testname))
      $display("Second call: Running test {%0s}......", testname);
    else 
      testname="default";
    
    if ($value$plusargs("num=%d", num))
      $display("Second call: num= {%0d}......", num);
    else
      num=100;
    
    $display("Second call: %s---%0d", testname, num);
    
    $display("\n=== Test completed ===");
  end
endmodule