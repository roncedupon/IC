`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "svt_ahb_slave_agent.sv"
`include "mydriver.sv"
`include "cust_svt_ahb_master_configuration.sv"
`include "simpleSeq.sv"
`include "ahb_slave_mem_response_sequence.sv"
import uvm_pkg::*;


class myenv extends uvm_env;
    mydriver drv;//declare master & slave agent
    svt_ahb_slave_agent s_agent;
    mysequencer seqr;

    cust_svt_ahb_system_configuration cfg;//declare configuraion
    `uvm_component_utils(myenv)
    function new(string name="myenv",uvm_component parent);
        super.new(name,parent);
    endfunction
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);

endclass 

function void myenv::build_phase(uvm_phase phase);
    drv=mydriver::type_id::create("drv",this);
    seqr=mysequencer::type_id::create("seqr",this);
    s_agent=svt_ahb_slave_agent::type_id::create("s_agent",this);
    
    /**
     * Check if the configuration is passed to the environment.
     * If not then create the configuration and pass it to the agent.
     */
    if (!uvm_config_db#(cust_svt_ahb_system_configuration)::get(this, "", "cfg", cfg)) begin
        cfg = cust_svt_ahb_system_configuration::type_id::create("cfg");
    end

    /** Apply the configuration to the slave_agent ENV */
    uvm_config_db#(svt_ahb_slave_configuration)::set(this, "s_agent", "cfg", cfg.slave_cfg[0]);
    uvm_config_db#(uvm_object_wrapper)::set(this, "s_agent.sequencer.run_phase", "default_sequence", ahb_slave_mem_response_sequence::type_id::get());
    uvm_config_db#(uvm_object_wrapper)::set(this, "seqr.run_phase", "default_sequence", mysequence::type_id::get());

endfunction: build_phase

function void myenv::connect_phase(uvm_phase phase);
    drv.seq_item_port.connect(seqr.seq_item_export);
endfunction