module test_static_task;
  // 默认static task：局部变量count是静态存储（全局唯一）
   task automatic count_up(int max);
    int count = 0; // 静态变量，所有调用共享同一个count
    repeat(max) begin
      #1 count++;
      $display("[%0t] static task: count = %0d (max=%0d)", $time, count, max);
    end
  endtask

  initial begin
    // 并发调用同一个static task
    fork
      count_up(3); // 第一个调用：期望count从1→3
      count_up(2); // 第二个调用：期望count从1→2
    join
  end
endmodule

