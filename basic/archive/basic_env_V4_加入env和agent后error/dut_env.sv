`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "dut_agent.sv"
// `include "dut_scoreboard.sv"
// `include "dut_sequence.sv"
import uvm_pkg::*;
class dut_env extends uvm_env;
    `uvm_component_utils(dut_env);
    function new(string name="dut_env",uvm_component parent);
        super.new(name,parent);
    endfunction

    dut_agent dut_agent_inst;
    // dut_scoreboard dut_scorebaord_inst;
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        $display("starting env build_phase");
        `uvm_info("dut_env","starting env build_phase",UVM_ALL_ON)
        dut_agent_inst=dut_agent::type_id::create("dut_agent_inst",this);
        // dut_scorebaord_inst=dut_scoreboard::type_id::create("dut_scoreboard_inst",this);
        `uvm_info("dut_env"," env build_phase end",UVM_ALL_ON)
        // uvm_config_db#(uvm_object_wrapper)::set(this,"dut_agent_inst.s0.main_phase","default_sequence",dut_sequence::type_id::get());    
        // `uvm_info("TEST","dut test build_phase end",UVM_LOW)         
        $display("env build_phase end");
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        $display("env connect_phase start");
        // `uvm_info("dut_env","env connect_phase start",UVM_ALL_ON)
        super.connect_phase(phase);
        // dut_agent_inst.dut_monitor_inst.mon_analysis_port.connect(dut_scorebaord_inst.m_analysis_imp);
        // `uvm_info("dut_env","env connect_phase end",UVM_ALL_ON)
        $display("env connect_phase end");
    endfunction
    virtual task main_phase(uvm_phase phase);
        
        // dut_sequence seq;
        super.main_phase(phase);
        // phase.raise_objection(this) ;
        // seq=dut_sequence::type_id::create("seq");
        // seq.start(dut_agent_inst.s0);
        // phase.drop_objection(this);
    endtask
endclass
