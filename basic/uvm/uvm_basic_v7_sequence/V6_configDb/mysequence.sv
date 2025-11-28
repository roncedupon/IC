`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "mytransaction.sv"
import uvm_pkg::*;
//  Class: mysequence
//
class mysequence extends uvm_sequence;
    mytransaction tr;
    int count=0;
    `uvm_object_utils(mysequence);

    function new(string name = "mysequence");
        super.new(name);
    endfunction: new

    extern virtual task body();

    
endclass: mysequence

task mysequence::body();
    if(!uvm_config_db#(int)::get(null,get_full_name(),"count",count))begin
        `uvm_fatal(get_type_name(),"didn't get count!!")
        $display("path is",get_full_name());
    end


    if(starting_phase!=null)begin
        `uvm_info("seq body","starting_phase!=null,starting_phase.raise_objection(this);",UVM_ALL_ON)
        starting_phase.raise_objection(this);
    end
    repeat(1000)begin
        $display("%s and count is %d",get_full_name(),count);
        `uvm_do(tr);
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
    repeat(1000)begin
        $display("%s",get_full_name());
        `uvm_do(tr);
    end
    #1000
    if(starting_phase!=null)begin
        `uvm_info("seq body","starting_phase!=null,starting_phase.drop_objection(this);",UVM_ALL_ON)
        starting_phase.drop_objection(this);
    end
endtask