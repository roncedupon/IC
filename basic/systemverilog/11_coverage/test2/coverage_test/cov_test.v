module cov_test(

    input wire a,
    input wire b,
    input wire c,

    input wire CLK,
    input wire RSTn,
    output wire out1,
    output wire out2,
    output wire out3
);

reg rout1;
reg rout2;
reg rout3;

always@(*)
begin
    if(a && b && c)
        rout1 = 1'b1;
    else
        rout1 = 1'b0;
    if(a && b && ~c)
        rout2 = 1'b1;
    else
        rout2 = 1'b0;
end

reg [1:0]i;

always@(posedge CLK or negedge RSTn)
begin
    if(!RSTn)
        begin
            i <= 2'd0;
            rout3 <= 1'b0;
        end
    else
        case(i)
            2'd0: begin i <= i + 1;  rout3 <= 0; end
            2'd1: begin i <= 2'd3; rout3 <= 0; end
            3'd3: begin i <= 2'd0; rout3 <= 1; end
        endcase
end

assign out1 = rout1;
assign out2 = rout2;
assign out3 = rout3;
endmodule
