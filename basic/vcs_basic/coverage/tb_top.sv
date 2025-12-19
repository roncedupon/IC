// 测试平台：仅生成时钟/复位/输入激励，打印关键信号
`timescale 1ns/1ps
`include "dut.sv"
module tb;
    // 信号定义
    logic        clk;
    logic        rst_n;
    logic [7:0]  din;  // 顶层输入
    logic [7:0]  dout; // 顶层输出

    // 例化顶层模块
    top u_top(
        .clk    (clk),
        .rst_n  (rst_n),
        .din    (din),
        .dout   (dout)
    );

    // 1. 时钟激励：10ns周期（5ns高/5ns低）
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // 2. 复位激励：先复位（10ns），后释放
    initial begin
        rst_n = 1'b0; // 复位有效
        #10;          // 复位持续10ns
        rst_n = 1'b1; // 释放复位
        #100;         // 稳定运行100ns
        $finish;      // 结束仿真
    end

    // 3. 输入激励：动态变化din，覆盖不同输入值
    initial begin
        din = 8'h00;  // 初始值
        #15 din = 8'h01; // 复位释放后第一个时钟
        #10 din = 8'h08; // 第二个时钟
        #10 din = 8'h10; // 第三个时钟
        #10 din = 8'h20; // 第四个时钟
        #10 din = 8'hFF; // 最大值
    end

    // 4. 信号打印：每个时钟打印关键信号，观测输出
    initial begin
        $timeformat(-9, 1, "ns", 10); // 时间格式：ns，保留1位小数
        $display("时间     clk  rst_n  din   dout");
        $display("----------------------------------");
        forever @(posedge clk) begin
            #1; // 避开时钟沿竞争
            $display("%t    %b    %b    0x%02X  0x%02X", 
                     $time, clk, rst_n, din, dout);
        end
    end

endmodule