`ifndef VSEQR
`define VSEQR
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
`include "apb_sequencer.sv"
`include "spi_sequencer.sv"
class vseqr extends uvm_sequencer;
    `uvm_component_utils(vseqr);
    apb_sequencer apb_seqr; //
    spi_sequencer spi_seqr;//
    function new(string name = "vseqr",uvm_component parent);
        super.new(name,parent);
    endfunction: new
endclass: vseqr
`endif