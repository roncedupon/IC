`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "tlm_tr.sv"
import uvm_pkg::*;
class tlm_seq extends uvm_sequence;
    tlm_tr tr;
    `uvm_object_utils(tlm_seq)
    function new(string name="tlm_seq");
        super.new(name);
    endfunction
    virtual task body();
        if(starting_phase!=null)
            starting_phase.raise_objection(this);
        repeat(10)begin
            `uvm_do(tr);
        end
        #1000
        if(starting_phase!=null)
            starting_phase.drop_objection(this);
    endtask
    
endclass