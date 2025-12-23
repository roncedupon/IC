  // 监控逻辑：等待 my_signal 从其他值跳变为 0xFFFFFFFF
  logic [31:0] prev_signal;
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