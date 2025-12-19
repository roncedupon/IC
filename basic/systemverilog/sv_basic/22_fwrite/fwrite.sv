module write_test;

  integer f;
  logic count[8];
  initial begin

    foreach(count[i]) begin
      count[i] = i;
      $display("i/4,i/2",i/4,i%4);
    end

    f = $fopen("output.txt", "w");


    // 使用 fdisplay 自动换行
    $fdisplay(f, "Line 1\n");
    $fdisplay(f, "Line 2\n");

    $fclose(f);
  end




endmodule
