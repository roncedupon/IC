module test;
  bit [5:0] A; // 假设A是一个6位的变量，足以表示2到32的值
  initial begin
    repeat (1) begin
      randomize(A) with {
        // A inside { [2:32] }; // A的值在2到32之间
        A == 2 || A inside {[3:31]}; // A的值至少为2，或者在3到31之间
      };
      if (!$isunknown(A)) begin // 检查A是否已被随机化
        $display("A = %d", A);
      end
    end
  end
endmodule