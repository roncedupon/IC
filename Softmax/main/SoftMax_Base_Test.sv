`ifndef SOFTMAX_BASE_TEST
`define SOFTMAX_BASE_TEST
`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;

`include "SoftMax_Env.sv"
`include "SoftMax_Sequence.sv"
class SoftMax_Base_Test extends uvm_test;
    SoftMax_Env env;
    function new(string name="SoftMax_Base_Test",uvm_component parent=null);
        super.new(name,parent);
    endfunction
    
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void report_phase(uvm_phase phase);

    `uvm_component_utils(SoftMax_Base_Test);

endclass

function void SoftMax_Base_Test::build_phase(uvm_phase phase);
    super.build_phase(phase);
    env=SoftMax_Env::type_id::create("env",this);
    //这里应该写default seq，但是现在default seq死活不通。。。。
    // uvm_config_db#(uvm_object_wrapper)::set(this,
    // "env.Stage1_FindMax_iAgent.Stage1_FindMax_Sequencer.main_phase",
    // "default_sequence",
    // SoftMax_Sequence::type_id::get());
endfunction

function void SoftMax_Base_Test::report_phase(uvm_phase phase);
    uvm_report_server server;
    int err_num;
    super.report_phase(phase);

    server=get_report_server();
    err_num=server.get_severity_count(UVM_ERROR);

    if(err_num!=0)begin
        $display("Test case failed!!");
    end
    else $display("Test case passed!!");
endfunction

`endif
