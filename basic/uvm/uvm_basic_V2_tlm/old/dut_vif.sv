`ifndef DUT_VIF
`define DUT_VIF
interface dut_vif(input clk,input rstn);
     logic    [7:0]a;
     logic    [7:0]b;
     logic    [8:0]c;
endinterface: dut_vif
`endif