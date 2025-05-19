module tb;

  reg [7:0] mem [0:255]; // 声明一个 256 字节的内存

  initial begin
    // 初始化部分内容
    mem[0] = 8'h12;
    mem[1] = 8'h34;
    mem[2] = 8'h56;

    // 导出整个内存为十六进制
    $writememh("mem_dump.hex", mem);

    // 也可以指定起止地址
    $writememh("partial_dump.hex", mem, 0, 15);
  end

endmodule
