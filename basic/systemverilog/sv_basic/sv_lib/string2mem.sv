module string2mem;
    logic [1023:0] mem[4096];  // 32位宽，4096深度的内存
    
    // 将字符串写入内存的任务
    task write_string_to_mem0(input string str, input int start_addr);
        int char_count;
        int words_needed;
        char_count=str.len();
        words_needed= (char_count+4-1)/4;
        $display("char_count is %0d",char_count);
        $display("words_needed is %0d",words_needed);


        for (int i=0;i<words_needed;i++)begin
            logic [31:0]word;
            for (int j=0;j<4;j++)begin
                automatic int char_pos=i*4+j;
                if(char_pos<str.len())begin
                    // word[(j+1)*8-1:j*8]=str[char_pos];
                    mem[i][start_addr+j*8+:8]=str[char_pos];
                end
                else begin
                    // word[(j+1)*8-1:j*8]=8'h0;
                    mem[i][start_addr+j*8+:8]=str[char_pos];
                end
            end
        end
        $display("char count is %0d",char_count);

    endtask

    task str2hex(input string filename);
        int file_ptr;
        string line_buff;
        int line_cnt;
        bit flag;
        bit[1023:0]mem_tmp;
        file_ptr=$fopen(filename,"r");
        if(file_ptr==0)begin
            $display("ERROR,file %s cannnot be opened!!!",filename);
        end
        else begin
            while(!$feof(file_ptr))begin
                $fgets(line_buff,file_ptr);
                
                // $display("line is %s \n",line_buff);
                // $display("line[2:] is %s",line_buff.substr(2, line_buff.len()-1));
                // $display("hex is %0256x",line_buff.substr(2, line_buff.len()-1).atohex());//line_buff.len()-1).atohex());
                // $display("hex is %d",line_buff.substr(2, line_buff.len()-1).atohex());//line_buff.len()-1).atohex());
                for (int i=0;i<256/8;i++)begin
                    mem_tmp[i*32+:32]=line_buff.substr(2+i*8, 2+(i+1)*8-1).atohex();
                    $display("mem_tmp is %x",mem_tmp);
                end
                mem[line_cnt]=mem_tmp;
                line_cnt=line_cnt+1;
            end
        end        

    endtask

    task count_up();
        int counter = 0;  // 默认静态存储
        counter=counter+1;
        $display("Counter = %0d", counter);
    endtask    
    initial begin
        str2hex("/mnt/disk_0/IC/basic/systemverilog/sv_basic/sv_lib/all_instrs.hex");
        $display("mem[0] = %h", mem[0]);  // 应显示48656c6c ("Hell")
        $display("mem[0] = %s", mem[0]);  // 应显示48656c6c ("Hell")
        $display("mem[1] = %h", mem[1]);  // 应显示6f000000 ("o\0\0\0")
        $display("mem[1] = %s", mem[1]);  // 应显示6f000000 ("o\0\0\0")
        
    end

    `define WAVES_FSDB
    `ifdef WAVES_FSDB
      initial begin
        
        $fsdbDumpfile($sformatf("waves.fsdb"));
        $fsdbDumpvars("+all");
        $fsdbDumpSVA();
        $fsdbDumpMDA(0,string2mem);
      end
    `elsif WAVES_VCD
      initial begin
        $dumpvars;
      end
    `elsif WAVES
      initial begin
        $vcdpluson;
      end
    `endif
endmodule