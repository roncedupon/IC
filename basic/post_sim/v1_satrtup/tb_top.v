`timescale 1ns/1ps
module dff (
    input  wire clk,
    input  wire rstn,
    input  wire d,
    output reg  q
);

  always @(posedge clk or negedge rstn) begin
    if (!rstn)
      q <= 1'b0;
    else
      q <= d;
  end

endmodule

module tb_top;

  reg clk, rstn, d;
  wire q;

  // DUT
  dff dut (
    .clk(clk),
    .rstn(rstn),
    .d(d),
    .q(q)
  );

  // Clock
  initial clk = 0;
  always #5 clk = ~clk;  // 100MHz

  // Stimulus
  initial begin
    rstn = 0;
    d    = 0;
    #20 rstn = 1;
    #15 d = 1;
    #10 d = 0;
    #20 d = 1;
    #50 $finish;
  end
  // SDF 反标
  initial begin
    // 把 dff.sdf 反标到 tb_top.dut
    $sdf_annotate("/mnt/disk_0/IC/basic/post_sim/v1_satrtup/dff.sdf", tb_top.dut, , "sdf_anno.log", "MAXIMUM");
  end
  // FSDB dump
  initial begin
    $fsdbDumpfile("post_sim.fsdb");
    $fsdbDumpvars(0, tb_top);
  end

endmodule
