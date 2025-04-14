module hex_file_reader;

    // 参数定义
    parameter MEM_DEPTH = 1024;  // 内存深度
    parameter DATA_WIDTH = 1024; // 数据宽度(1024位)
    
    // 定义内存
    reg [DATA_WIDTH-1:0] mem [0:MEM_DEPTH-1];
    integer file_handle;
    integer line_count;
    integer scan_count;
    
    initial begin
        // 打开文件
        file_handle = $fopen("/mnt/disk_0/IC/basic/systemverilog/sv_basic/sv_lib/all_instrs.hex", "r");
        if (!file_handle) begin
            $display("Error: Could not open file!");
            $finish;
        end
        
        line_count = 0;
        
        // 逐行读取文件
        while (!$feof(file_handle) && (line_count < MEM_DEPTH)) begin
            // 读取格式为 "行号:1024位十六进制"
            // %*d跳过行号，%256h读取256个十六进制字符(1024位)
            scan_count = $fscanf(file_handle, "%*d:%256h", mem[line_count]);
            
            if (scan_count == 1) begin
                for (int i=0;i<256/8;i++)begin
                    $display("Read line %0d: %h", line_count, mem[line_count][i*32+:32]);
                end
                
                line_count = line_count + 1;
            end
            else begin
                $display("Warning: Line %0d format error", line_count);
            end
        end
        
        // 关闭文件
        $fclose(file_handle);
        $display("Finished reading %0d lines", line_count);
        $finish;
    end

endmodule