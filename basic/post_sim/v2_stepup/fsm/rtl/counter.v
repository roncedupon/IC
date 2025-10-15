module counter #(
    parameter N = 3
)(

    input wire clk_i,
    input wire rst_l_i,

    output [N-1 : 0] q_o

);

reg [N-1 : 0] q_lac;

assign q_o = q_lac;

always@ (posedge clk_i or negedge rst_l_i) begin
    if(!rst_l_i)
        q_lac <= { (N){1'b0} };
    else
        q_lac <= q_lac + {{(N-1){1'b0}},1'b1}; 
end

endmodule
