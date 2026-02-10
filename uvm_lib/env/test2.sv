// module demo_array_queue_assignment;
//   // 定义你要求的变量：动态数组A + 队列B
//   bit   [15:0] A[];  // dynamic array: bit[15:0] elements
//   logic [15:0] B[$]; // queue: logic[15:0] elements

//   initial begin
//     // Step 1: 给队列B 填充一些测试数据 (队列用push_back添加元素)
//     B.push_back(16'h1234);
//     B.push_back(16'h5678);
//     B.push_back(16'hABCD);
//     $display("=== Initial Queue B Data ===");
//     foreach(B[i]) begin
//       $display("B[%0d] = 0x%04h", i, B[i]);
//     end

//     // ✅ 核心赋值1: 队列B 赋值给 动态数组A  --> A = B (你重点要的写法)
//     A = B;
//     $display("\n=== After Assign B -> A (A = B) ===");
//     foreach(A[i]) begin
//       $display("A[%0d] = 0x%04h", i, A[i]);
//     end

//     // ✅ 扩展赋值2: 动态数组A 修改数据后，赋值回队列B --> B = A
//     A[1] = 16'hFFFF; // 修改动态数组的第二个元素
//     B = A;
//     $display("\n=== After Modify A[1], Assign A -> B (B = A) ===");
//     foreach(B[i]) begin
//       $display("B[%0d] = 0x%04h", i, B[i]);
//     end
//   end

// endmodule

module demo_array_queue_correct;
  bit   [15:0] A[]; 
  logic [15:0] B[$];

  initial begin
    B.push_back(16'h1234);
    B.push_back(16'h5678);
    B.push_back(16'hABCD);
    $display("=== Initial Queue B Data (16bit完整) ===");
    foreach(B[i]) begin
      $display("B[%0d] = 0x%04h", i, B[i]);
    end

    A = B;
    $display("\n=== After Assign B -> A (A = B) ");
    foreach(A[i]) begin
      $display("A[%0d] = 0x%04h", i, A[i]);
    end
  end
endmodule