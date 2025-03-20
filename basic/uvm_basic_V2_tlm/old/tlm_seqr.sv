`ifndef TLM_SEQR
`define TLM_SEQR
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "tlm_tr.sv"
import uvm_pkg::*;
class tlm_seqr extends uvm_sequencer#(tlm_tr);
    `uvm_component_utils(tlm_seqr)
    function new(string name="tlm_sequencer",uvm_component parent);
        super.new(name,parent);
    endfunction
    
endclass
`endif 