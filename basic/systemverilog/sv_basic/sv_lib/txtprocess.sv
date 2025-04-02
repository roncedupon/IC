module  txtprocess;
    integer file_ptr;
    string buff;
    logic[31:0 ]buff1;
    int line_cnt;
    string file="/mnt/disk_0/IC/basic/systemverilog/sv_basic/sv_lib/timing.txt";
    initial begin
        file_ptr = $fopen(file, "r");
        if (file_ptr == 0) begin
            $error("Failed to open file");
        end
        else begin
            line_cnt = 0;
            while ($fgets(buff, file_ptr) != 0) begin
                
                
                line_cnt++;
                $display("Line0 %0d: %s", line_cnt, buff);
                
            end
            $display("Total lines: %0d", line_cnt);
            $display("================================================");
            $fclose(file_ptr);
        end
    end
    initial begin
        file_ptr = $fopen(file, "r");
        if (file_ptr == 0) begin
            $error("Failed to open file");
        end
        else begin
            line_cnt = 0;
            while (!$feof(file_ptr)) begin
                $fgets(buff1,file_ptr);
                
                line_cnt++;
                $display("Line1 %0d: %s", line_cnt, buff);//注意这个地方由于声明buff1为logic[31:0]，也就是4字节，如果一行数据超过4字节，fgets就会分批将这一行数据存入缓冲区
                
            end
            $display("Total lines: %0d", line_cnt);
            $fclose(file_ptr);
        end
    end
endmodule