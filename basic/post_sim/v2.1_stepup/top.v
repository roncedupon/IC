module top(
   output  and_out,
   input   in1, in2, clk);

   wire    res_tmp ;
   and_gate u_and(res_tmp, in1, in2);
   d_gate   u_dt(and_out, res_tmp, clk);

endmodule
