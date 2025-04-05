class MemoryAccess;
  rand bit [31:0] addr; // 定义随机变量地址

  // 约束块
  constraint addr_range_alignment_c {
    // 地址大于 128K (128 * 1024 = 131072 = 0x20000)
    addr > 32'h20000;

    // 地址小于 196K (196 * 1024 = 200704 = 0x31000)
    addr < 32'h31000;

    // 地址按 128 字节对齐 (低7位为0)
    addr[6:0] == 7'b0;
    // 或者使用取模运算： addr % 128 == 0;
  }
endclass

// --- 使用示例 ---
module test;
  initial begin
    MemoryAccess mem_access = new();
    for (int i = 0; i < 5; i++) begin // 随机化5次并打印
      if (mem_access.randomize()) begin
        $display("Randomized addr = 0x%h (%0d)", mem_access.addr, mem_access.addr);
      end else begin
        $error("Randomization failed!");
      end
    end
  end
endmodule