module Top #(
    parameter N = 3
)(
    input wire clk_i,
    input wire rst_l_i,
    output wire [3:0] dout_o,
    output wire [N-1:0] q_o
);

fsm_moore U1(
    .clk_i(clk_i),
    .rst_l_i(rst_l_i),

    .dout(dout_o)
); 


counter #(.N(N)) U2
(
    .clk_i(clk_i),
    .rst_l_i(rst_l_i),

    .q_o(q_o)
);


endmodule
