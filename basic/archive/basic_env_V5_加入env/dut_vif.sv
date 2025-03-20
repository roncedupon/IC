`ifndef DUT_VIF
`define DUT_VIF
interface dut_vif(input clk,input rstn);
     logic    data_in;
     logic    data_out;
     logic    en_i;
     logic    en_o;
endinterface: dut_vif
`endif