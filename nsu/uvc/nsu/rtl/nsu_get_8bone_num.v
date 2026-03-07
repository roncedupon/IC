`timescale 1ns/1ps

module nsu_get_8bone_num(/*autoarg*/
    //Inputs
    clk, rst_n, dat_in, en,
    //Outputs
    dat_out
);

//============================In/Out Signal============================
input                           clk         ;
input                           rst_n       ;
input      [7:0]                dat_in      ;
input                           en          ;
output reg [3:0]                dat_out     ;

//============================Wire/Reg SIGNAL============================
/*autodef*/

//============================Process============================
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        dat_out <= 'd0;
    else if(en)
        dat_out <= get_oen_sum_8(dat_in);
end

function [3:0] get_oen_sum_8;
    input  [7:0] i_data;
    reg    [3:0] sum0;
    reg    [3:0] sum1;
begin
    sum0 = get_oen_sum_4(i_data[4*0+:4]);
    sum1 = get_oen_sum_4(i_data[4*1+:4]);
    get_oen_sum_8 = sum0 + sum1;
end
endfunction

function [3:0] get_oen_sum_4;
    input  [3:0] i_data;
begin
    case(i_data)
        4'b0000:get_oen_sum_4 = 4'd0;
        4'b0001:get_oen_sum_4 = 4'd1;
        4'b0010:get_oen_sum_4 = 4'd1;
        4'b0011:get_oen_sum_4 = 4'd2;
        4'b0100:get_oen_sum_4 = 4'd1;
        4'b0101:get_oen_sum_4 = 4'd2;
        4'b0110:get_oen_sum_4 = 4'd2;
        4'b0111:get_oen_sum_4 = 4'd3;
        4'b1000:get_oen_sum_4 = 4'd1;
        4'b1001:get_oen_sum_4 = 4'd2;
        4'b1010:get_oen_sum_4 = 4'd2;
        4'b1011:get_oen_sum_4 = 4'd3;
        4'b1100:get_oen_sum_4 = 4'd2;
        4'b1101:get_oen_sum_4 = 4'd3;
        4'b1110:get_oen_sum_4 = 4'd3;
        4'b1111:get_oen_sum_4 = 4'd4;
        default:get_oen_sum_4 = 4'd0;
    endcase
end
endfunction

//Local Variables:
//verilog-library-directories:(".")
//verilog-library-directories-recursive:0
//End:
endmodule