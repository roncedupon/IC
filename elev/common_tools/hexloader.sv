`define COM_SIZE_ILM 1024
`include "uvm_macros.svh"
`include "uvm_pkg.sv"

import uvm_pkg::*;
class common_tools;

    task read_host_cpu_hex(bit[31:0] mem[]);
        
        int fd;
        // check
        fd = $fopen("hex/host.dat","r");
        if(fd==0) `uvm_fatal(get_full_name(),"hex/host.dat not exist!!")
        else $fclose(fd);
        // process
        mem = new[`COM_SIZE_ILM/4];
        $readmemh("./hex/host.dat",mem);
        foreach(mem[i]) mem[i] = {mem[i][7:0],mem[i][15:8],mem[i][23:16],mem[i][31:24]};
        
        `uvm_info(get_full_name(),$sformatf("host_cpu_hex_proc(): die-%0d done.",die_id),UVM_NONE)
    endtask

endclass