module cov_test_tb;

reg a_in;
reg b_in;
reg c_in;
reg CLK_in;
reg RSTn_in;

wire out1;
wire out2;
wire out3;
cov_test U1(

    .a(a_in),
    .b(b_in),
    .c(c_in),

    .CLK(CLK_in),
    .RSTn(RSTn_in),

    .out1(out1),
    .out2(out2),
    .out3(out3)
);

initial begin
    CLK_in = 1'b0;
    RSTn_in = 1'b1;
    a_in = 1'b0;
    b_in = 1'b0;
    c_in = 1'b0;
    #10
    RSTn_in = 1'b0;
    {a_in, b_in, c_in} = 3'b001;
    #10   
    RSTn_in = 1'b1;
    {a_in, b_in, c_in} = 3'b011;
    #10
    {a_in, b_in, c_in} = 3'b111;
    #10    
    #100
    $finish;
end

always#5
    CLK_in = ~CLK_in;

initial begin
    $vcdpluson();
end

endmodule
