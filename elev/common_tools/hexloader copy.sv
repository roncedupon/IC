`define COM_SIZE_ILM 1024
// typedef int queue_of_int[$];
// class commom_tools;
//     function bit[31:0] read_cpu_hex(output bit[31:]mem[$],string hex_path);

//     endfunction

// endclass

module top;


    initial begin
        int fd;
        bit[31:0] mem[];
        string hex_path="/mnt/disk_0/IC/elev/common_tools/cpu.hex";
        mem = new[`COM_SIZE_ILM/4];
        // check
        fd = $fopen(hex_path,"r");
        if(fd==0) begin
            $display("hex.dat not exist!!");
        end
        else $fclose(fd);
        // process

        $readmemh(hex_path,mem);
        foreach(mem[i]) mem[i] = {mem[i][7:0],mem[i][15:8],mem[i][23:16],mem[i][31:24]};
        $display("cpu_hex data read done.mem size is %d",mem.size());

        
        $display("\nInfo: First 10 elements of mem:");
        for (int i = 0; i < 10 && i < mem.size(); i++) begin
            $display("mem[%0d] = 0x%08h", i, mem[i]);
        end
    end
endmodule