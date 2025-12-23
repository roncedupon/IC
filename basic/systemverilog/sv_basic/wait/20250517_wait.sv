module tb;

  logic [31:0] my_signal;
  logic [31:0] prev_signal;

  // 生成 stimulus（输入激励）
  initial begin
    my_signal = 32'h00000000;
    #10 my_signal = 32'h12345678;
    #10 my_signal = 32'hFFFF0000;
    #10 my_signal = 32'hFFFFFFFF;  // <- 目标变化
    #10 my_signal = 32'hAAAAAAAA;
  end

  // 监控逻辑：等待 my_signal 从其他值跳变为 0xFFFFFFFF
  initial begin
    prev_signal = my_signal;
    forever begin
      @(my_signal);  // 等待信号发生变化（任一位）
      if (my_signal == 32'hFFFF_FFFF && prev_signal != 32'hFFFF_FFFF) begin
        $display(">>> Detected jump to 0xFFFF_FFFF at time %0t", $time);
        break;  // 如果只监控一次跳变，跳出循环
      end
      prev_signal = my_signal; // 更新前一个值
    end
  end

endmodule
