// tb_top.sv - top testbench that includes two DUTs from relative paths
`timescale 1ns/1ps

`include "dir1/dut1.sv"
`include "dir2/dir2_1/dut2_1.sv"

module tb_top;
    // simple clock/reset
    logic clk;
    logic rst_n;

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz
    end

    initial begin
        rst_n = 0;
        #20;
        rst_n = 1;
        #1000;
        $finish;
    end

    // Instantiate DUTs (adjust port names if your DUTs use different ports)
    // Expecting modules named `dut1` and `dut2` in the included files.
    dut1 u_dut1 (
        .clk  (clk),
        .rst_n(rst_n)
    );

    dut2_1 u_dut2 (
        .clk  (clk),
        .rst_n(rst_n)
    );

endmodule