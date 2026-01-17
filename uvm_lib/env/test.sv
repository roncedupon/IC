module queue2dyn_array;
  // 定义动态数组和队列（元素类型均为bit）
  bit AAA[];
  bit BBB[$];

  initial begin
    // 1. 给队列赋值
    #2ms;
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



    // 原数组（示例：长度70）
    bit A[] = new[70];
    foreach(A[i]) A[i] = (i % 2);

    // 拆分后的数组：二维动态数组（每一行是一个拆分块）
    bit split_A[][];

    // 步骤1：计算块数并初始化拆分数组
    int block_num = (A.size() + 29) / 30;
    split_A = new[block_num];

    // 步骤2：逐块拆分（保留实际长度）
    foreach(split_A[blk_idx]) begin
      // 计算当前块的实际长度：前n-1块30位，最后一块=原数组长度 - (blk_idx*30)
      int block_len = (blk_idx == block_num - 1) ? (A.size() - blk_idx*30) : 30;
      split_A[blk_idx] = new[block_len]; // 初始化当前块的长度
      
      // 逐位赋值
      for(int bit_idx = 0; bit_idx < block_len; bit_idx++) begin
        int global_idx = blk_idx * 30 + bit_idx;
        split_A[blk_idx][bit_idx] = A[global_idx];
      end
    end

    // 打印拆分结果（验证）
    `uvm_info("SPLIT_RESULT", $sformatf("原数组长度：%0d，拆分块数：%0d", A.size(), split_A.size()), UVM_MEDIUM);
    foreach(split_A[blk_idx]) begin
      `uvm_info("SPLIT_RESULT", $sformatf("第%0d块（长度%0d）：%0b", blk_idx, split_A[blk_idx].size(), split_A[blk_idx]), UVM_MEDIUM);
    end
  end


  
endmodule