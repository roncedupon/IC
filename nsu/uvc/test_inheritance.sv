`timescale 1ns/1ps

class A;
  string testname;
  int num;
  
  function new();
    if ($value$plusargs("TESTNAME=%s", testname))
      $display("Class A: Running test {%0s}......", testname);
    else 
      testname="default_A";
    if ($value$plusargs("num=%d", num))
      $display("Class A: num= {%0d}......", num);
    else
      num=100;
    $display("Class A: %s---%0d", testname, num);
  endfunction
endclass

class B extends A;
  string testname_b;
  int num_b;
  
  function new();
    super.new(); // 调用基类构造函数
    
    // 派生类中再次使用 $value$plusargs
    if ($value$plusargs("TESTNAME=%s", testname_b))
      $display("Class B: Running test {%0s}......", testname_b);
    else 
      testname_b="default_B";
    if ($value$plusargs("num=%d", num_b))
      $display("Class B: num= {%0d}......", num_b);
    else
      num_b=200;
    $display("Class B: %s---%0d", testname_b, num_b);
    
    // 验证基类中获取的参数
    $display("Class B: Base testname=%s, Base num=%0d", super.testname, super.num);
  endfunction
endclass

module test_inheritance ();
  initial begin
    $display("=== Testing class inheritance with $value$plusargs ===");
    
    // 创建基类实例
    $display("\nCreating class A instance:");
    A a = new();
    
    // 创建派生类实例
    $display("\nCreating class B instance:");
    B b = new();
    
    $display("\n=== Test completed ===");
  end
endmodule