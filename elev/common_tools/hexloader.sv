`define COM_SIZE_ILM 1024
`include "uvm_macros.svh"
`include "uvm_pkg.sv"

import uvm_pkg::*;
class common_tools extends uvm_component;
    `uvm_component_utils(common_tools)

    function new(string name="common_tools",uvm_component parent=null);
        super.new(name,parent);
    endfunction

    // Task to load a hex file into memory
    task automatic read_cpu_hex(string hex_str, ref bit[31:0] mem[]);
        int fd;
        string line, tok;
        int last_addr, last_word_addr;
        int data_count = 4;
        int pos = 0;
        int mem_size;
        string tokens[$];

        // -------------------------------
        // Step 1. Open the file and move to the last line
        // -------------------------------
        fd = $fopen(hex_str, "r");
        if(fd == 0) begin
            `uvm_fatal(get_full_name(), $sformatf("%s not exist!!", hex_str))
            return;
        end
        while(!$feof(fd)) begin // move to the last line
            void'($fgets(line, fd));
        end
        $fclose(fd);

        `uvm_info(get_full_name(),$sformatf("last line is %s",line),UVM_LOW)

        // -------------------------------
        // Step 2. Parse the last line
        // -------------------------------
        if(line.len() == 0) begin
            `uvm_fatal(get_full_name(), "empty file!!")
            return;
        end

        // Extract the last address
        void'($sscanf(line, "@%x", last_addr));
        // Assume the file stores byte addresses → convert directly to word index
        last_word_addr = last_addr;

        // Count number of data words in the last line
        // (currently hard-coded as 4, can be extended to dynamic parsing)

        // -------------------------------
        // Step 3. Calculate the final memory size
        // -------------------------------
        mem_size = last_word_addr + data_count;
        mem = new[mem_size];              // Allocate memory space
        $readmemh(hex_str, mem);          // Load file contents into memory

        // -------------------------------
        // Step 4. Print checking information
        // -------------------------------
        `uvm_info(get_full_name(),
                $sformatf("last_addr=0x%x (word index=%0d), data_count=%0d, mem_size=%0d",
                            last_addr, last_word_addr, data_count, mem_size),
                UVM_LOW)

        // -------------------------------
        // Step 5. Endianness check
        // Print the first few words byte-by-byte to verify the byte order
        // -------------------------------
        for(int i=0; i < (mem_size  < 4 ? mem_size  : 4); i++) begin
            `uvm_info(get_full_name(),
                    $sformatf("mem[%0d] = %08x (bytes: %02x %02x %02x %02x)",
                                i, mem[i],
                                mem[i][7:0], mem[i][15:8],
                                mem[i][23:16], mem[i][31:24]),
                    UVM_LOW)
        end

        // -------------------------------
        // Step 6. Byte-order conversion (if needed)
        // For little-endian CPU, swap byte order here
        // -------------------------------
        foreach(mem[i])
            mem[i] = {mem[i][7:0], mem[i][15:8], mem[i][23:16], mem[i][31:24]};
    endtask

    task width_convert_32To8(bit[31:0]mem_32bit[],ref bit[7:0]mem_8bit[]);
        int byte_size   = mem_32bit.size() * 4; // 1 word = 4 bytes
        mem_8bit        = new[byte_size];
        foreach(mem_32bit[i]) begin
            mem_8bit[i*4 + 0] = mem_32bit[i][7:0];     // byte 0
            mem_8bit[i*4 + 1] = mem_32bit[i][15:8];    // byte 1
            mem_8bit[i*4 + 2] = mem_32bit[i][23:16];   // byte 2
            mem_8bit[i*4 + 3] = mem_32bit[i][31:24];   // byte 3
        end
        // Debug print first few
        foreach(mem_8bit[j]) begin
            if (j < 16)
                $display("mem_8bit[%0d] = %02x", j, mem_8bit[j]);
        end
    endtask

endclass



module top;
    initial begin
        bit [31:0]mem[];
        bit [7:0]byte_stream[];
        common_tools tools;
        tools=new();
        tools.read_cpu_hex("/home/dy/IC/elev/common_tools/hex.dat",mem);
        
        foreach(mem[i])begin
            `uvm_info("TOP",$sformatf("mem[%2d] is %8x",i,mem[i]),UVM_LOW)
        end
        tools.width_convert_32To8(mem,byte_stream);
    end
endmodule