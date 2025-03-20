`ifndef SOFTMAX_SEQUENCER
`define SOFTMAX_SEQUENCER
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
`include "SoftMax_Transaction.sv"
`include "SoftMax_Funs.sv"
import uvm_pkg::*;
import SoftMax_Funs::*;
class SoftMax_Sequencer extends uvm_sequencer#(SoftMax_Transaction);//sequencer 作为一个参数化的类，用于产生transaction，而diver则只需要负责接受transaction并驱动

    //  Group: Variables


    //  Group: Constraints


    //  Group: Functions

    //  Constructor: new
    function new(string name = "SoftMax_Sequencer",uvm_component parent);
        super.new(name,parent);
    endfunction: new

    `uvm_component_utils(SoftMax_Sequencer);
    
endclass: SoftMax_Sequencer


`endif 

