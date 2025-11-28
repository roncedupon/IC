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
// task mysequence3::body();//下面这个和上面那个不一样，是因为uvm_do是一个宏定义吗？所以在第0时没有消耗仿真时间，这时又没有检测到objection，所以直接退出了？
//     mysequence seq1;
//     mysequence2 seq2;

//     repeat(1)begin
//         `uvm_do(seq1);
//         `uvm_do(seq2);
//     end

// endtask