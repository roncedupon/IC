`timescale 1ns/1ps

module width_demo;

  // 原始信号
  bit [31:0] data;
  
  // 使用 $width() 系统函数获取位宽并创建宽一位的新信号
  bit [$width(data):0] data_b;
  
  initial begin
    // 测试不同值
    data = 32'h00000000;
    data_b = {1'b0, data};
    $display("data = %h, data_b = %h", data, data_b);
    
    data = 32'h12345678;
    data_b = {1'b0, data};
    $display("data = %h, data_b = %h", data, data_b);
    
    data = 32'hFFFFFFFF;
    data_b = {1'b0, data};
    $display("data = %h, data_b = %h", data, data_b);
    
    // 测试符号扩展
    data = 32'h80000000; // 负数
    data_b = {{1{data[31]}}, data}; // 符号扩展
    $display("data = %h, data_b (sign-extended) = %h", data, data_b);
    
    $finish;
  end
  
endmodule