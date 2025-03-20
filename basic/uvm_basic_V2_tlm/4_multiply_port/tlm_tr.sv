`ifndef TLM_TR
`define TLM_TR
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
class tlm_tr extends uvm_sequence_item;
    rand bit[7:0]a;
    rand bit[7:0]b;
    rand bit[7:0]c;
    
    function new(string name="tlm_tr");
        super.new(name);
    endfunction
    `uvm_object_utils_begin(tlm_tr)
    `uvm_field_int(a,UVM_ALL_ON)
    `uvm_field_int(b,UVM_ALL_ON)
    `uvm_object_utils_end
endclass
`endif 