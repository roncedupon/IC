module test;
  bit [31:0] A; // 假设A是一个6位的变量，足以表示2到32的值
  initial begin
    repeat (10) begin
      randomize(A) with {
        // A inside { [2:32] }; // A的值在2到32之间
        A>='h24_0000;
        A<='h24_0000+64*1024;
        A[6:0] == 7'b0;//128B对齐
      };
      if (!$isunknown(A)) begin // 检查A是否已被随机化
        $display("A = %b", A);
      end
    end
  end
endmodule