module test;

  string header = "Test:";
  string body = "SystemVerilog";
  int version = 2023;
  string result;

  initial begin
    // 拼接
    result = $sformatf("%s %s Version %0d", header, body, version);
    $display("Result: %s", result); // 输出：Test: SystemVerilog Version 2023
  end

endmodule
