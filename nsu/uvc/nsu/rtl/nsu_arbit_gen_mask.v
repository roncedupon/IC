`timescale 1ns/1ps

module nsu_arbit_gen_mask(/*autoarg*/
    //Inputs
    clk, rst_n, grant, vld, rdy,
    last,
    //Outputs
    arb_mask, grant_rdy,
    dat_grant_out
);

//============================Parameter============================
//============================In/Out Signal============================
input                           clk             ;
input                           rst_n           ;
input                           grant           ;
input                           vld             ;
input                           rdy             ;
input                           last            ;
output                          arb_mask        ;
output                          grant_rdy       ;
output                          dat_grant_out   ;

//============================Wire/Reg SIGNAL============================
/*autodef*/
reg                             grant_d         ;

//============================Process============================
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        grant_d <= 1'b0;
    else if(grant & vld & grant_rdy & last)
        grant_d <= 1'b0;
    else if(vld & grant_rdy & last)
        grant_d <= 1'b0;
    else if(grant)
        grant_d <= 1'b1;
end

assign grant_rdy      = dat_grant_out ? rdy : 1'b0;
assign arb_mask       = grant_d;
assign dat_grant_out  = (grant | grant_d);

//Local Variables:
//verilog-library-directories:(".")
//verilog-library-directories-recursive:0
//End:
endmodule