`timescale 1ns/1ps

module top;

  // 定义一个32位 × 128深度的数组
  reg [31:0] data [0:127];
  reg clk;

  // 产生时钟
  initial clk = 0;
  always #5 clk = ~clk;  // 100MHz时钟周期10ns

  // 初始化阶段
  initial begin
    integer i;
    // 从文件读入初始值（可选）
    $readmemh("data.txt", data);
    $display("[TB] Data loaded from data.txt");

    // 模拟期间修改数组值
    #5000;
    for (i = 0; i < 128; i++) begin
      data[i] = i;
    end

    #5000;
    $display("[TB] Simulation done at %0t", $time);
    $writememh("data_dump.txt", data);    
    $finish;
  end

  // FSDB 波形导出
  initial begin
    $fsdbDumpfile("waves.fsdb");
    $fsdbDumpvars(0, top);
    $fsdbDumpMDA(0, top);  // dump 多维数组（很重要）
  end

endmodule
