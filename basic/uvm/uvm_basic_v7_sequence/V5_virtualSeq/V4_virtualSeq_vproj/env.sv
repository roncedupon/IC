`ifndef ENV
`define ENV
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "apb_driver.sv"
`include "spi_driver.sv"
`include "apb_transaction.sv"
`include "spi_transaction.sv"
`include "apb_seq.sv"
`include "spi_seq.sv"
`include "apb_sequencer.sv"
`include "spi_sequencer.sv"
`include "vseqr.sv"
import uvm_pkg::*;
class env extends uvm_env;
    spi_driver spi_drv;
    apb_driver apb_drv;
    apb_sequencer apb_seqr;
    spi_sequencer spi_seqr;
    vseqr   virtual_sequencer;
    `uvm_component_utils(env)
    function new(string name="env",uvm_component parennt);    
        super.new(name,parennt);
    endfunction //new()
    //  Function: build_phase
    extern function void build_phase(uvm_phase phase);
    //  Function: connect_phase
    extern function void connect_phase(uvm_phase phase);

    // extern task run_phase(uvm_phase phase);
endclass 

function void env::build_phase(uvm_phase phase);

    spi_drv=spi_driver::type_id::create("spi_drv",this);
    apb_drv=apb_driver::type_id::create("apb_drv",this);
    apb_seqr=apb_sequencer::type_id::create("apb_seqr",this);
    spi_seqr=spi_sequencer::type_id::create("spi_seqr",this);
    virtual_sequencer=vseqr::type_id::create("virtual_sequencer",this);

    
endfunction: build_phase

function void env::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    spi_drv.seq_item_port.connect(spi_seqr.seq_item_export);
    apb_drv.seq_item_port.connect(apb_seqr.seq_item_export);
    virtual_sequencer.apb_seqr=apb_seqr;
    virtual_sequencer.spi_seqr=spi_seqr;
    
endfunction: connect_phase


`endif