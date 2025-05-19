module write_test;

  integer f;
  initial begin
    f = $fopen("output.txt", "w");


    // 使用 fdisplay 自动换行
    $fdisplay(f, "Line 1\n");
    $fdisplay(f, "Line 2\n");

    $fclose(f);
  end

endmodule
