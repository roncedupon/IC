module fsm_moore_tb;

parameter  N = 3;

reg clk_in;
reg rst_l_in;

wire [3:0] dout_out;
wire [N-1:0] q_o;

Top  #(.N(N)) U3
(
    .clk_i(clk_in),
    .rst_l_i(rst_l_in),

    .dout_o(dout_out),
    .q_o(q_o)
);

initial begin
    $vcdpluson();
end

initial begin
    clk_in <= 1'b0;
    rst_l_in <= 1'b1;
    #22 
    rst_l_in <= 1'b0;
    #17
    rst_l_in <= 1'b1;
    #1000
    $finish;
end

always #5
    clk_in <= ~clk_in; 

endmodule
