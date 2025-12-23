

module top;
    task read_file(string filename,output int line_cnt=0);
        string buff;    
        int file_ptr;
        file_ptr=$fopen(filename,"r");
        
        while(!$feof(file_ptr))begin
            $fgets(buff,file_ptr);
            if (buff.len() > 0 && buff != "\n") begin
                // 去除纯换行，空白行不计
                bit is_blank = 1;
                foreach (buff[i]) begin
                    if (buff[i] != " " && buff[i] != "\t" && buff[i] != "\n" && buff[i] != "\r")//注意这里并不能处理空格
                        is_blank = 0;
                    if(!is_blank)begin
                        line_cnt=line_cnt+1; 
                        break;
                    end
                end
            end
        end
        $fclose(file_ptr);
    endtask
    initial begin
        int line_cnt;
        read_file("/mnt/disk_0/IC/basic/systemverilog/sv_basic/17_file_operation/test.txt",line_cnt);
        $display("line_cnt is %0d",line_cnt);
        $display("line_cnt is %0d",line_cnt);
        $display("line_cnt is %0d",line_cnt);
        $display("line_cnt is %0d",line_cnt);
        $display("line_cnt is %0d",line_cnt);

    end
endmodule