module d_gate(
            output      Q ,
            input       D, CP);

   reg                  Q_r ;
   always @(posedge CP)
     Q_r <= D ;
   assign       Q = Q_r ;

endmodule
