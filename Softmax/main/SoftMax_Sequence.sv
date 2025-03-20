`ifndef SEQUENCE
`define SEQUENCE
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
`include "SoftMax_Transaction.sv"
class SoftMax_Sequence extends uvm_sequence#(SoftMax_Transaction);
    SoftMax_Transaction m_trans;
    function new(string name="SoftMax_Sequence");
        super.new(name);
    endfunction
    virtual task pre_body();
        if(starting_phase!=null)begin
            starting_phase.raise_objection(this);
            $display("starting_phase!=null,start raise objection");
        end
        else begin
            `uvm_error("SoftMax_Sequence","starting_phase is null");
        end
    endtask

    virtual task body();
        $display("getting in virtual task of SoftMax_Sequence");
        if(starting_phase!=null)begin
            starting_phase.raise_objection(this);
            $display("starting_phase!=null,start raise objection");
        end
        else begin
            `uvm_error("SoftMax_Sequence","starting_phase is null");
        end

        repeat (10) begin//重复十次
           `uvm_do(m_trans)
        end
        #1000;
        if(starting_phase != null) 
           starting_phase.drop_objection(this);
    endtask
    virtual task post_body();
        if(starting_phase!=null)begin
            starting_phase.drop_objection(this);
            $display("starting_phase!=null,start drop objection");
        end
            
    endtask 
    `uvm_object_utils(SoftMax_Sequence);
endclass


`endif 
