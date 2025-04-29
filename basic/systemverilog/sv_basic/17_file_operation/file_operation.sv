module top;
    task read_file(string filename, output int line_cnt=0);
        string buff;    
        int file_ptr;
        file_ptr = $fopen(filename, "r");
        
        if (file_ptr == 0) begin
            $display("Error: Cannot open file %s", filename);
            return;
        end
        
        while (!$feof(file_ptr)) begin
            bit is_empty = 1;
            void'($fgets(buff, file_ptr));
            
            // 去除行尾换行符
            buff = buff.substr(0, buff.len()-1);
            
            // 检查是否为空行（仅包含空白字符）
            
            foreach (buff[i]) begin
                if (buff[i] != " " && buff[i] != "\t" && buff[i] != "\n" && buff[i] != "\r") begin
                    is_empty = 0;
                    break;
                end
            end
            
            if (!is_empty) begin
                line_cnt = line_cnt + 1; 
            end
        end
        $fclose(file_ptr);
    endtask

    initial begin
        int line_cnt;
        read_file("/mnt/disk_0/IC/basic/systemverilog/sv_basic/17_file_operation/test.txt", line_cnt);
        $display("Non-empty line count: %0d", line_cnt);
    end
endmodule