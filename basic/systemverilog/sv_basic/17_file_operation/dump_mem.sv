module test;
    reg [1023:0] mem [$];
    integer fd;
    integer i;

    initial begin
        // 打开文件（"w" 表示写模式，若已存在会覆盖）
        fd = $fopen("mem_out.txt", "w");
        for(int i=0;i<1024;i++)begin
            mem.push_back(i);
        end
        if (fd == 0) begin
            $display("ERROR: Cannot open file!");
            $finish;
        end

        // 循环写内存
        foreach (mem[i]) begin
            $fwrite(fd, "%016h\n", mem[i]);  // 每行写一个字节，16进制
        end

        $fclose(fd);
        $display("Memory written to mem_out.txt");
    end

endmodule