module counter_tb;

parameter N = 3;

reg clk_in;
reg rst_l_in;
wire [N-1:0] q_out;

counter #(.N(N)) U1
(
    .clk_i(clk_in),
    .rst_l_i(rst_l_in),
    .q_o(q_out)
);

initial begin
`ifdef DUMP_VPD
    $vcdpluson();
`endif
end

initial begin
    clk_in <= 1'b0;
    rst_l_in <= 1'b0;
    #23
    rst_l_in <= 1'b1;
    #100
    rst_l_in <= 1'b0;
    #100
    rst_l_in <= 1'b1;
    #100
    $finish;
end


always #5
    clk_in <= ~clk_in;



endmodule
