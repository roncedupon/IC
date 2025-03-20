`ifndef APB_SEQR
`define APB_SEQR
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "apb_transaction.sv"
// `include "mysequence.sv"
import uvm_pkg::*;
//  Class: apb_sequencer
//
class apb_sequencer extends uvm_sequencer#(apb_transaction);
    `uvm_component_utils(apb_sequencer);

    function new(string name = "apb_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    
endclass: apb_sequencer
`endif 