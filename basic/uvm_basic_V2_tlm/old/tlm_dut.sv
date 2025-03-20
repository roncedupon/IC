`ifndef TLM_DUT
`define TLM_DUT
module tlm_dut(
    input [7:0]a,
    input [7:0]b,
    input clk,
    input rstn,
    output reg[8:0]c
);
always_ff@(posedge clk or negedge rstn)begin
    if(~rstn)begin
        c<=9'd0;
    end
    else begin
        c<=a+b;
    end
end
endmodule
`endif