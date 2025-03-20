`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "mysequencer.sv"
`include "mytransaction.sv"
import uvm_pkg::*;
//  Class: mysequence
//
// event send_over;//全局事件
class mysequence extends uvm_sequence;
    mytransaction tr;
    `uvm_object_utils(mysequence);

    function new(string name = "mysequence");
        super.new(name);
    endfunction: new

    extern virtual task body();

    
endclass: mysequence

task mysequence::body();
    if(starting_phase!=null)begin
        `uvm_info("seq body","starting_phase!=null,starting_phase.raise_objection(this);",UVM_ALL_ON)
        starting_phase.raise_objection(this);
    end

    repeat(10)begin
        $display("seq1");
        `uvm_do_pri(tr,200);//设置优先级
    end
    #1000
    if(starting_phase!=null)begin
        `uvm_info("seq body","starting_phase!=null,starting_phase.drop_objection(this);",UVM_ALL_ON)
        starting_phase.drop_objection(this);
    end
endtask

//========================================================================================================
class mysequence2 extends uvm_sequence;
    mytransaction tr;
    `uvm_object_utils(mysequence2);

    function new(string name = "mysequence2");
        super.new(name);
    endfunction: new

    extern virtual task body();

    
endclass: mysequence2

task mysequence2::body();
    if(starting_phase!=null)begin
        `uvm_info("seq body","starting_phase!=null,starting_phase.raise_objection(this);",UVM_ALL_ON)
        starting_phase.raise_objection(this);
    end
    repeat(10)begin
        $display("seq2");
        `uvm_do_pri(tr,100);//设置优先级
    end
    #1000
    if(starting_phase!=null)begin
        `uvm_info("seq body","starting_phase!=null,starting_phase.drop_objection(this);",UVM_ALL_ON)
        starting_phase.drop_objection(this);
    end
endtask
//========================================================================================================
class mysequence3 extends uvm_sequence;
    mytransaction tr;
    `uvm_object_utils(mysequence3);

    function new(string name = "mysequence3");
        super.new(name);
    endfunction: new

    extern virtual task body();

    
endclass: mysequence3

task mysequence3::body();
    mysequence seq1;
    mysequence2 seq2;
    if(starting_phase!=null)begin
        `uvm_info("seq body","starting_phase!=null,starting_phase.raise_objection(this);",UVM_ALL_ON)
        starting_phase.raise_objection(this);
    end
    repeat(1)begin
        `uvm_do(seq1);
        `uvm_do(seq2);
    end
    if(starting_phase!=null)begin
        `uvm_info("seq body","starting_phase!=null,starting_phase.drop_objection(this);",UVM_ALL_ON)
        starting_phase.drop_objection(this);
    end
endtask
//================================================================================================================================
class Virtua1Sequence extends uvm_sequence;
    `uvm_object_utils(Virtua1Sequence)
    `uvm_declare_p_sequencer(myVseqr)
    mytransaction tr;
    mysequence seq1;
    mysequence2 seq2;
    virtual task body();
    if(starting_phase != null) 
        starting_phase.raise_objection(this);

        // `uvm_do_on(seq1,p_sequencer.seqr1)
        `uvm_do_on(seq1,p_sequencer.seqr1)
        fork
            `uvm_do_on(seq1,p_sequencer.seqr1)
            `uvm_do_on(seq2,p_sequencer.seqr2)
        join
    if(starting_phase != null) 
        starting_phase.drop_objection(this);
    endtask
endclass