`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;

class offwbf_transaction extends uvm_sequence_item;
    rand int plane_num;
    rand bit [7:0] ost_id_nsu2offline;
    rand bit [31:0] src_mem_addr;
    rand bit [31:0] dest_mem_addr;
    rand bit [15:0] descramble_seed;
    rand bit offline_wbf_out_flag;
    
    `uvm_object_utils_begin(offwbf_transaction)
        `uvm_field_int(plane_num, UVM_ALL_ON)
        `uvm_field_int(ost_id_nsu2offline, UVM_ALL_ON)
        `uvm_field_int(src_mem_addr, UVM_ALL_ON)
        `uvm_field_int(dest_mem_addr, UVM_ALL_ON)
        `uvm_field_int(descramble_seed, UVM_ALL_ON)
        `uvm_field_int(offline_wbf_out_flag, UVM_ALL_ON)
    `uvm_object_utils_end
    
    function new(string name = "offwbf_transaction");
        super.new(name);
    endfunction
endclass

class offwbf_demo_component extends uvm_component;
    int total_offwbf_count;
    `uvm_component_utils(offwbf_demo_component)
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
        total_offwbf_count = 0;
    endfunction
    
    function void print_offwbf_info(offwbf_transaction offwbf_tr);
        bit [31:0] src_mem_addr_32bit  = offwbf_tr.src_mem_addr[31:0];
        bit [31:0] dest_mem_addr_32bit = offwbf_tr.dest_mem_addr[31:0];    


        
        // 修复后的 uvm_info 换行打印
        string OFFWBF_LOG_FMT = $sformatf(
        "\n========== Received OFFWBF_CMD #%0d ==========\n  \
        plane_num:             %0d\n  \
        ost_id_nsu2offline:    %0h\n  \
        src_mem_addr (32bit):  %0h\n  \
        dest_mem_addr (32bit): %0h\n  \
        descramble_seed:       %0h\n  \
        offline_wbf_out_flag:  %0b\n=============================================\n",
        total_offwbf_count,
        offwbf_tr.plane_num, offwbf_tr.ost_id_nsu2offline,
        src_mem_addr_32bit, dest_mem_addr_32bit,
        offwbf_tr.descramble_seed, offwbf_tr.offline_wbf_out_flag);
        total_offwbf_count++;
        `uvm_info(get_type_name(),OFFWBF_LOG_FMT , UVM_LOW)
    endfunction
    
    task run_phase(uvm_phase phase);
        offwbf_transaction offwbf_tr;
        phase.raise_objection(this);
        
        offwbf_tr = offwbf_transaction::type_id::create("offwbf_tr");
        assert(offwbf_tr.randomize() with {
            plane_num             == 2;
            ost_id_nsu2offline    == 8'h1A;
            src_mem_addr          == 32'h12345678;
            dest_mem_addr         == 32'h87654321;
            descramble_seed       == 16'hABCD;
            offline_wbf_out_flag  == 1'b1;
        });
        print_offwbf_info(offwbf_tr);
        
        #10;
        offwbf_tr = offwbf_transaction::type_id::create("offwbf_tr");
        assert(offwbf_tr.randomize() with {
            plane_num             == 3;
            ost_id_nsu2offline    == 8'h3F;
            src_mem_addr          == 32'hAABBCCDD;
            dest_mem_addr         == 32'hDDCCBBAA;
            descramble_seed       == 16'h1234;
            offline_wbf_out_flag  == 1'b0;
        });
        print_offwbf_info(offwbf_tr);
        
        phase.drop_objection(this);
    endtask
endclass

class offwbf_demo_test extends uvm_test;
    offwbf_demo_component demo_comp;
    `uvm_component_utils(offwbf_demo_test)
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        demo_comp = offwbf_demo_component::type_id::create("demo_comp", this);
    endfunction
endclass

module top;
    initial begin
        run_test("offwbf_demo_test");
    end
endmodule