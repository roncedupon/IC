module test;
 // 假设A是一个6位的变量，足以表示2到32的值
  bit [31:0] B;
  initial begin
      bit [31:0] A;
    repeat (10) begin
      randomize(A) with {
        A[0]  == A[1];  A[2]  == A[3];  A[4]  == A[5];  A[6]  == A[7];
        A[8]  == A[9];  A[10] == A[11]; A[12] == A[13]; A[14] == A[15];
        A[16] == A[17]; A[18] == A[19]; A[20] == A[21]; A[22] == A[23];
        A[24] == A[25]; A[26] == A[27]; A[28] == A[29]; A[30] == A[31];
      };
      randomize(B);
      if (!$isunknown(A)) begin // 检查A是否已被随机化
        $display("A = %b", A);
      end
      if (!$isunknown(B)) begin // 检查B是否已被随机化
        $display("B = %b", B);
      end      
    end
  end
endmodule