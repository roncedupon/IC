
module fsm_moore ( clk_i, rst_l_i, dout );
  output [3:0] dout;
  input clk_i, rst_l_i;
  wire   next_1_, n1, n2;
  wire   [1:0] state;

  DFFRX1 state_reg_0_ ( .D(n2), .CK(clk_i), .RN(rst_l_i), .Q(state[0]), .QN(n2) );
  DFFRX1 state_reg_1_ ( .D(next_1_), .CK(clk_i), .RN(rst_l_i), .Q(state[1]), 
        .QN(n1) );
  OR2X1 U3 ( .A(dout[2]), .B(dout[1]), .Y(next_1_) );
  NOR2X1 U4 ( .A(n2), .B(state[1]), .Y(dout[1]) );
  NOR2X1 U5 ( .A(n1), .B(state[0]), .Y(dout[2]) );
  NOR2X1 U6 ( .A(n2), .B(n1), .Y(dout[3]) );
endmodule


module counter_N3 ( clk_i, rst_l_i, q_o );
  output [2:0] q_o;
  input clk_i, rst_l_i;
  wire   N2, N3, n1, n2, n3;

  DFFRX1 q_lac_reg_0_ ( .D(n1), .CK(clk_i), .RN(rst_l_i), .Q(q_o[0]), .QN(n1)
         );
  DFFRX1 q_lac_reg_2_ ( .D(N3), .CK(clk_i), .RN(rst_l_i), .Q(q_o[2]), .QN(n2)
         );
  DFFRX1 q_lac_reg_1_ ( .D(N2), .CK(clk_i), .RN(rst_l_i), .Q(q_o[1]), .QN() );
  XNOR2X1 U3 ( .A(q_o[1]), .B(n1), .Y(N2) );
  XOR2X1 U4 ( .A(n2), .B(n3), .Y(N3) );
  NAND2X1 U5 ( .A(q_o[1]), .B(q_o[0]), .Y(n3) );
endmodule


module Top ( clk_i, rst_l_i, dout_o, q_o );
  output [3:0] dout_o;
  output [2:0] q_o;
  input clk_i, rst_l_i;
  wire   SYNOPSYS_UNCONNECTED_1;

  fsm_moore U1 ( .clk_i(clk_i), .rst_l_i(rst_l_i), .dout({dout_o[3:1], 
        SYNOPSYS_UNCONNECTED_1}) );
  counter_N3 U2 ( .clk_i(clk_i), .rst_l_i(rst_l_i), .q_o(q_o) );
  INVX1 U4 ( .A(1'b1), .Y(dout_o[0]) );
endmodule

