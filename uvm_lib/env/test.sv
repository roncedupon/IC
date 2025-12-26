module queue2dyn_array;
  // 定义动态数组和队列（元素类型均为bit）
  bit AAA[];
  bit BBB[$];

  initial begin
    // 1. 给队列赋值
    BBB = {1'b1, 1'b0, 1'b1, 1'b0}; // 队列长度=4
    $display("初始队列BBB: 长度=%0d, 元素=%p", BBB.size(), BBB);

    // 2. 队列直接赋值给动态数组
    AAA = BBB;
    $display("赋值后AAA: 长度=%0d, 元素=%p", AAA.size(), AAA);

    // 3. 修改原队列，验证值拷贝（非引用）
    BBB[0] = 1'b0; // 改队列第一个元素
    $display("\n修改队列后BBB: %p", BBB);
    $display("修改队列后AAA: %p", AAA); // AAA不受影响

    // 4. 空队列赋值测试
    BBB.delete(); // 清空队列
    AAA = BBB;
    $display("\n空队列赋值后AAA长度: %0d", AAA.size()); // 输出0
  end
endmodule