`ifndef RCMD_MASK_MT_DEMO_SV
`define RCMD_MASK_MT_DEMO_SV

class transaction;
  // 类全局变量：多线程共享
  bit [31:0] rcmd_mask;

  function new();
    rcmd_mask = 32'h0; // 初始值0
  endfunction

  // 线程1：随机化 rcmd_mask（修复约束，期望生成非零值）
  task thread1_rand();
    int rand_status;
    $display("\n[线程1] 开始随机化 rcmd_mask...");
    rand_status = randomize(this.rcmd_mask) with {
      // 仅低16位成对相等 + 高16位清零 + 非零
      rcmd_mask[0]   == rcmd_mask[1];
      rcmd_mask[2]   == rcmd_mask[3];
      rcmd_mask[4]   == rcmd_mask[5];
      rcmd_mask[6]   == rcmd_mask[7];
      rcmd_mask[8]   == rcmd_mask[9];
      rcmd_mask[10]  == rcmd_mask[11];
      rcmd_mask[12]  == rcmd_mask[13];
      rcmd_mask[14]  == rcmd_mask[15];
      rcmd_mask[31:16] == 0;
      rcmd_mask > 0;
    };
    $display("[线程1] 随机化完成：rand_status=%0d，rcmd_mask=0x%08x", rand_status, this.rcmd_mask);
  endtask

  // 线程2：强制将 rcmd_mask 置0
  task thread2_set_zero();
    #1ns; // 延迟1ns，确保线程1先开始随机化
    $display("\n[线程2] 强制将 rcmd_mask 置0...");
    this.rcmd_mask = 32'h0;
    $display("[线程2] 置0完成：rcmd_mask=0x%08x", this.rcmd_mask);
  endtask

  // 线程3：循环读取 rcmd_mask，观察值的变化
  task thread3_read();
    repeat(5) begin
      #0.5ns; // 每0.5ns读一次
      $display("[线程3] 读取 rcmd_mask：0x%08x", this.rcmd_mask);
    end
  endtask
endclass

// 测试入口：启动3个线程
module demo_tb;
  initial begin
    transaction tr;

    bit [31:0] final_rcmd_mask;
    tr = new();
    do begin
        final_rcmd_mask=$urandom(); // 随机初始值，增加不确定性
    end while(final_rcmd_mask == 0); // 确保初始值非零

    $display("final_rcmd_mask is %x", final_rcmd_mask);
    $display("===== 多线程操作 rcmd_mask 开始 =====");
    fork
      tr.thread1_rand();   // 线程1：随机化（期望非零）
      tr.thread2_set_zero();// 线程2：强制置0
      tr.thread3_read();   // 线程3：实时读取
    join

    $display("\n===== 最终结果 =====");
    $display("rcmd_mask 最终值：0x%08x", tr.rcmd_mask);
  end
endmodule

`endif