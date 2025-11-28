`ifndef DUT_SEQUENCE
`define  DUT_SEQUENCE
//第二步:实现好transaction后，接下来实现sequence，需要注意sequence也是一个object
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "dut_transaction.sv"
import uvm_pkg::*;
class dut_sequence extends uvm_sequence;
    dut_transaction dut_tr;
    `uvm_object_utils(dut_sequence)
    function new(string name="dut_sequence");
        super.new(name);
    endfunction
    virtual task pre_body();
        `uvm_info("seq pre body","get inside",UVM_ALL_ON)
        if(starting_phase!=null)begin
            `uvm_info("seq pre body","starting_phase!=null,starting_phase.raise_objection(this);",UVM_ALL_ON)
            starting_phase.raise_objection(this);
        end
    endtask
    virtual task body();
        //第一步声明一个transaction
        `uvm_info("seq pre body","get inside",UVM_ALL_ON)
        if(starting_phase!=null)begin
            `uvm_info("seq pre body","starting_phase!=null,starting_phase.raise_objection(this);",UVM_ALL_ON)
            starting_phase.raise_objection(this);
        end
        `uvm_info("dut_sequence","getting in body()",UVM_ALL_ON)
        repeat(15)begin
            `uvm_do(dut_tr);
            //好像也能用下面这种，自己手动实例化
            // dut_tr=dut_transaction::type_id::create("dut_tr");
            // start_item(dut_tr);
            // assert(dut_tr.randomize());
            // finish_item(dut_tr);
        end
        #1000
        if(starting_phase!=null)begin
            starting_phase.drop_objection(this);
            $display("starting_phase!=null,start drop objection");
        end
    endtask

    virtual task post_body();
        `uvm_info("seq post body","get inside",UVM_ALL_ON)
        if(starting_phase!=null)begin
            `uvm_info("seq post body","starting_phase!=null,starting_phase.drop_objection(this);",UVM_ALL_ON)
            starting_phase.drop_objection(this);
        end
    endtask
endclass
`endif 