`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "mydriver.sv"
`include "mytransaction.sv"
`include "mysequencer.sv"
`include "mysequence.sv"
import uvm_pkg::*;
class myenv extends uvm_env;
    mydriver drv;
    mysequencer seqr;
    `uvm_component_utils(myenv)
    function new(string name="myenv",uvm_component parennt);    
        super.new(name,parennt);
    endfunction //new()
    //  Function: build_phase
    extern function void build_phase(uvm_phase phase);
    //  Function: connect_phase
    extern function void connect_phase(uvm_phase phase);

    extern task run_phase(uvm_phase phase);
endclass 

function void myenv::build_phase(uvm_phase phase);
    /*  note: Do not call super.build_phase() from any class that is extended from an UVM base class!  */
    /*  For more information see UVM Cookbook v1800.2 p.503  */
    //super.build_phase(phase);
    drv=mydriver::type_id::create("drv",this);
    seqr=mysequencer::type_id::create("seqr",this);
    // uvm_config_db#(uvm_object_wrapper)::set(this,"seqr.main_phase","default_sequence",mysequence::type_id::get());
    
endfunction: build_phase

function void myenv::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.seq_item_port.connect(seqr.seq_item_export);
endfunction: connect_phase

task myenv::run_phase(uvm_phase phase);
    mysequence seq1;
    mysequence2 seq2;
    `uvm_info(get_name(), "<run_phase> started, objection raised.", UVM_NONE)
    seq1=new("seq1");
    seq2=new("seq2");
    seq1.starting_phase=phase;
    seq2.starting_phase=phase;
    // fork 
    //     seq1.start(seqr);
    //     seq2.start(seqr);
    // join
        
    `uvm_info(get_name(), "<run_phase> finished, objection dropped.", UVM_NONE)
endtask: run_phase
