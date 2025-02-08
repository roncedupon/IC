`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "svt_ahb_master_agent.sv"
`include "svt_ahb_slave_agent.sv"
`include "ahb_master_directed_sequence.sv"
`include "cust_svt_ahb_system_configuration.sv"
`include "simpleSeq.sv"
`include "ahb_slave_mem_response_sequence.sv"
import uvm_pkg::*;


class myenv extends uvm_env;
    svt_ahb_master_agent m_agent;//declare master & slave agent
    svt_ahb_slave_agent s_agent;

    cust_svt_ahb_system_configuration cfg;//declare configuraion
    `uvm_component_utils(myenv)
    function new(string name="myenv",uvm_component parent);
        super.new(name,parent);
    endfunction
    extern function void build_phase(uvm_phase phase);

endclass 

function void myenv::build_phase(uvm_phase phase);
    m_agent=svt_ahb_master_agent::type_id::create("m_agent",this);
    s_agent=svt_ahb_slave_agent::type_id::create("s_agent",this);
    
    /**
     * Check if the configuration is passed to the environment.
     * If not then create the configuration and pass it to the agent.
     */
    if (!uvm_config_db#(cust_svt_ahb_system_configuration)::get(this, "", "cfg", cfg)) begin
        cfg = cust_svt_ahb_system_configuration::type_id::create("cfg");
    end
    /** Apply the configuration to the master_agent ENV */
    uvm_config_db#(svt_ahb_master_configuration)::set(this, "m_agent", "cfg", cfg.master_cfg[0]);
    /** Apply the configuration to the slave_agent ENV */
    uvm_config_db#(svt_ahb_slave_configuration)::set(this, "s_agent", "cfg", cfg.slave_cfg[0]);
    uvm_config_db#(uvm_object_wrapper)::set(this, "m_agent.sequencer.main_phase", "default_sequence", ahb_master_directed_sequence::type_id::get());
    uvm_config_db#(uvm_object_wrapper)::set(this, "s_agent.sequencer.run_phase", "default_sequence", ahb_slave_mem_response_sequence::type_id::get());
    uvm_config_db#(int unsigned)::set(this, "uvm_test_top.m_agent.sequencer.ahb_master_directed_sequence", "sequence_length", 50);

endfunction: build_phase

// function void myenv::check_internal();
//     if (agt == null) begin
//         `uvm_fatal("NULL_AGENT", "Failed to create AHB Master Agent")
//     end
  
//     `uvm_info("MYENV", "Setting cfg and vif", UVM_LOW)
//     // agt.cfg = cfg;
//     // agt.vif = vif;
  
//     // 确保cfg和vif已正确传递
//     if (agt.cfg == null) begin
//       `uvm_fatal("NULL_CFG", "AHB Master Agent cfg is null")
//     end
  
//     if (agt.vif == null) begin
//       `uvm_fatal("NULL_VIF", "AHB Master Agent vif is null")
//     end
// endfunction

