`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "dut_env.sv"
`include "dut_sequence.sv"
import uvm_pkg::*;
class dut_test extends uvm_test;
    `uvm_component_utils(dut_test)
    function new(string name="dut_test",uvm_component parent=null);
        super.new(name,parent);
        // uvm_root::get().set_timeout(.timeout(1ms));
    endfunction

    dut_env dut_env_inst;
    virtual dut_vif vif;
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("TEST","dut test build_phase start",UVM_LOW)
        dut_env_inst=dut_env::type_id::create("dut_env_inst",this);
        if(!uvm_config_db#(virtual dut_vif)::get(this,"","dut_test",vif))
            `uvm_fatal("TEST","Did not get vif");

                                                                     
    endfunction
    extern virtual function void report_phase(uvm_phase phase);
    // virtual task run_phase(uvm_phase phase);
        
    //     // super.run_phase(phase);
    //     dut_sequence seq=dut_sequence::type_id::create("seq");
    //     super.run_phase(phase);
    //     `uvm_info("run_phase","run_phase in test",UVM_ALL_ON);
    //     phase.raise_objection(this);
    //     apply_reset();
    //     seq.randomize();
    //     seq.start(dut_env_inst.dut_agent_inst.s0);
    //     #200
    //     phase.drop_objection(this);
    // endtask

    virtual task apply_reset();
        // `uvm_info("Apply rstn","start apply rstn",UVM_ALL_ON);
        // vif.rstn<=0;
        // repeat(100)@(posedge vif.clk);
        // vif.rstn<=1'b1;
        // repeat(100)@(posedge vif.clk);
        // `uvm_info("Apply rstn","end apply rstn",UVM_ALL_ON);
        $display("apply_reset do nothing");
    endtask
endclass
function void dut_test::report_phase(uvm_phase phase);
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