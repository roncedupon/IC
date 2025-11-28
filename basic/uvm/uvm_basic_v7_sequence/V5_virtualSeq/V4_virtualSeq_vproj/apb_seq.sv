`include "uvm_pkg.sv"
`include "uvm_macros.svh"

`include "apb_transaction.sv"
import uvm_pkg::*;
//  Class: apb_seq
//
// event send_over;//全局事件
class apb_seq extends uvm_sequence;
    apb_transaction tr;
    int nums=10;
    string tr_name="apb_default_name";
    `uvm_object_utils(apb_seq);

    function new(string name = "apb_seq");
        super.new(name);
    endfunction: new

    virtual task body();
        super.body();
        
        if(starting_phase!=null)begin
            `uvm_info("apb_seq body","starting_phase!=null,starting_phase.raise_objection(this);",UVM_ALL_ON)
            starting_phase.raise_objection(this);
        end
    
        repeat(nums)begin
            // $display("apb_seq");
            `uvm_do(tr);
        end
        #1000
        if(starting_phase!=null)begin
            `uvm_info("apb_seq body","starting_phase!=null,starting_phase.drop_objection(this);",UVM_ALL_ON)
            starting_phase.drop_objection(this);
        end
        
    endtask

    
endclass: apb_seq