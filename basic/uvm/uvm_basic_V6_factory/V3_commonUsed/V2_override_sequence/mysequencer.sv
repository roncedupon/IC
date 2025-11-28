`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
//  Class: mysequencer
//
class mysequencer extends uvm_sequencer#(mytransaction);
    `uvm_component_utils(mysequencer);

    function new(string name = "mysequencer", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    
endclass: mysequencer
