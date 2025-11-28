`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "mytransaction.sv"
import uvm_pkg::*;
//  Class: mysequence
//
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
        
        `uvm_do(tr);
        $display("this is %s ",tr.tr_name);
    end

    #1000
    if(starting_phase!=null)begin
        `uvm_info("seq body","starting_phase!=null,starting_phase.drop_objection(this);",UVM_ALL_ON)
        starting_phase.drop_objection(this);
    end
endtask

//========================================================================================================
class mysequence2 extends mysequence;
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
    repeat(1000)begin
        $display("seq2");
        `uvm_do(tr);
    end
    #1000
    if(starting_phase!=null)begin
        `uvm_info("seq body","starting_phase!=null,starting_phase.drop_objection(this);",UVM_ALL_ON)
        starting_phase.drop_objection(this);
    end
endtask