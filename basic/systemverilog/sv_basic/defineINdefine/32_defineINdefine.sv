//20251006
`define AA 24'h000001

`define AA_EQ_000001 (`AA == 24'h000001)
`define AA_EQ_000002 (`AA == 24'h000002)

`define DO_BY_AA \
  if (`AA_EQ_000001) begin \
      $display("Case 1: AA = %h", `AA); \
  end \
  else if (`AA_EQ_000002) begin \
      $display("Case 2: AA = %h", `AA); \
  end \
  else begin \
      $display("Default case: AA = %h", `AA); \
  end

module test;
  initial begin
    `DO_BY_AA
  end
endmodule

