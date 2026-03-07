`timescale 1ns/1ps

module nsu_ip_lton(/*autoarg*/
    // Inputs
    in_vld,
    in_dat,
    in_addr,
    out_rdy,
    // Outputs
    in_rdy,
    out_vld,
    out_dat
);

//============================Parameter============================
parameter DATA_WH   = 4;
parameter ADDR_WH   = 8;
parameter OUT_NUM   = 8;
// localparam CMD_PIPE_NUM = 5;

//============================In/Out Signal============================
input                  in_vld;
input  [DATA_WH-1:0]   in_dat;
input  [ADDR_WH-1:0]   in_addr;
input  [OUT_NUM-1:0]   out_rdy;
output                 in_rdy;
output [OUT_NUM-1:0]   out_vld;
output [DATA_WH-1:0]   out_dat [OUT_NUM-1:0];

//============================Wire/Reg SIGNAL============================
wire   [OUT_NUM-1:0]   s_ready;
genvar i;

//============================Process============================
assign in_rdy = |s_ready;

generate
    for(i = 0; i < OUT_NUM; i = i + 1) begin : gen_lton
        assign s_ready[i]   = in_addr[i] & out_rdy[i] & in_vld;
        assign out_vld[i]   = in_vld & in_addr[i];
        assign out_dat[i]   = out_vld[i] ? in_dat : 'd0;
    end
endgenerate

endmodule