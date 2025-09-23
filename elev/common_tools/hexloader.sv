`define COM_SIZE_ILM 1024
`include "uvm_macros.svh"
`include "uvm_pkg.sv"

import uvm_pkg::*;
class common_tools extends uvm_component;
    `uvm_component_utils(common_tools)
    function new(string name="common_tools",uvm_component parent=null);
        super.new(name,parent);
    endfunction
    // 在类中定义
    task automatic read_cpu_hex(string hex_str, ref bit[31:0] mem[]);
        int fd;
        string line;
        int word_count = 0;
        int max_addr   = 0;
        int addr, val;
        bit [31:0] tmp_mem[$]; // 动态队列，先存放数据
        
        // -------------------------------
        // Step 1. 检查文件是否存在
        // -------------------------------
        fd = $fopen(hex_str, "r");
        if(fd == 0) begin
            `uvm_fatal(get_full_name(), $sformatf("%s not exist!!", hex_str))
            return;
        end

        // -------------------------------
        // Step 2. 扫描文件，确定最大地址和总元素数
        // -------------------------------
        while(!$feof(fd)) begin
            line = "";
            void'($fgets(line, fd));
            if(line.len() == 0) continue;

            // 如果是地址行，形如 "@00000010"
            if(line.tolower().substr(0,0) == "@") begin
                void'($sscanf(line, "@%x", addr));
                if(addr > max_addr) max_addr = addr;
            end
            else begin
                // 数据行，可能有多个数
                string tok;
                int pos = 0;
                while($sscanf(line.substr(pos), "%s", tok)) begin
                    void'($sscanf(tok, "%x", val));
                    tmp_mem.push_back(val);
                    word_count++;
                    pos += tok.len() + 1; // 往后挪动
                end
            end
        end
        $fclose(fd);

        // -------------------------------
        // Step 3. 分配最终 mem 大小
        // -------------------------------
        mem = new[word_count];
        foreach(mem[i]) mem[i] = tmp_mem[i];

        // -------------------------------
        // Step 4. 打印检查信息
        // -------------------------------
        `uvm_info(get_full_name(),
                $sformatf("hex dat %s read done. total %0d words, max_addr = %0d",
                            hex_str, word_count, max_addr),
                UVM_NONE)

        // -------------------------------
        // Step 5. 字节序检查
        // 打印前几个 word 的 4 个字节，方便确认是否需要 swap
        // -------------------------------
        for(int i=0; i < (word_count < 4 ? word_count : 4); i++) begin
            `uvm_info(get_full_name(),
                    $sformatf("mem[%0d] = %08x (bytes: %02x %02x %02x %02x)",
                                i, mem[i],
                                mem[i][7:0], mem[i][15:8],
                                mem[i][23:16], mem[i][31:24]),
                    UVM_LOW)
        end

        // -------------------------------
        // Step 6. 如果需要字节序转换，在这里加 swap
        // -------------------------------
        // 例如小端 CPU，需要翻转:
        foreach(mem[i])
            mem[i] = {mem[i][7:0], mem[i][15:8], mem[i][23:16], mem[i][31:24]};
    endtask

    
endclass

module top;
    initial begin
        bit [31:0]mem[];

        common_tools tools;
        tools=new();
        tools.read_cpu_hex("/home/dy/IC/elev/common_tools/hex.dat",mem);
        
        foreach(mem[i])begin
            `uvm_info("TOP",$sformatf("mem[%d] is %x",i,mem[i]),UVM_LOW)
        end
    end
endmodule