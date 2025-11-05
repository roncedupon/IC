/**********************************
copyright@FPGA OPEN SOURCE STUDIO
微信公众号：FPGA开源工作室
***********************************/
`timescale 1ns / 1ps

module heart_tb();

reg clk;
reg reset_n;

wire signed [31:0] love;

initial begin
  clk=0;
  reset_n=0;
  #100;
  reset_n =1;
  #10000000;
  $finish;
end

always #(10) clk = ~clk;

initial	begin
	    $fsdbDumpfile("tb.fsdb");//这个是产生名为tb.fsdb的文件
	    $fsdbDumpvars;
end



heart Uheart(
      .clk(clk),
	  .reset_n(reset_n),
	  .heart(love)
	   );

endmodule
