`ifndef VSEQ
`define VSEQ
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
`include "vseqr.sv"
class Virtua1Sequence extends uvm_sequence;
    `uvm_object_utils(Virtua1Sequence)
    `uvm_declare_p_sequencer(vseqr)

    apb_seq seq1;
    spi_seq seq2;
    virtual task body();
        if(starting_phase != null) 
            starting_phase.raise_objection(this);
            
        seq1=apb_seq::type_id::create("seq1");
        seq2=spi_seq::type_id::create("seq2");
        seq1.tr_name="apb_123";
        seq2.tr_name="spi_123";
        fork
            seq1.start(p_sequencer.apb_seqr);
            seq2.start(p_sequencer.spi_seqr);
        join
        if(starting_phase != null) 
            starting_phase.drop_objection(this);
    endtask
endclass
`endif