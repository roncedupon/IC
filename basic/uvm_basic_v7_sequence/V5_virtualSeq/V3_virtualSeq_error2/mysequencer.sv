`ifndef MYSEQUENCER
`define MYSEQUENCER
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
// `include "mysequence.sv"
import uvm_pkg::*;
//  Class: mysequencer
//
class mysequencer extends uvm_sequencer#(mytransaction);
    `uvm_component_utils(mysequencer);

    function new(string name = "mysequencer", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    
endclass: mysequencer
//这是一个virtual sequencer--虚拟sequencer的意思就是压根不发送transaction，它只是控制其他的sequence，起到统一的调度作用。
class myVseqr extends uvm_sequencer;
    `uvm_component_utils(myVseqr);
    mysequencer seqr1; //
    mysequencer seqr2;//
    function new(string name = "myVseqr",uvm_component parent);
        super.new(name,parent);
    endfunction: new
endclass: myVseqr
`endif