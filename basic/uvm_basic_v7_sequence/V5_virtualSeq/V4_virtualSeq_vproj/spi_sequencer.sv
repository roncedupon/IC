`ifndef SPI_SEQR
`define SPI_SEQR
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "spi_transaction.sv"
// `include "mysequence.sv"
import uvm_pkg::*;
//  Class: spi_sequencer
//
class spi_sequencer extends uvm_sequencer#(spi_transaction);
    `uvm_component_utils(spi_sequencer);

    function new(string name = "spi_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction: new

    
endclass: spi_sequencer

`endif