`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "svt_ahb_master_agent.sv"
`include "cust_svt_ahb_master_configuration.sv"
`include "simpleSeq.sv"
import uvm_pkg::*;


class myenv extends uvm_env;
    svt_ahb_master_agent agt;

    cust_svt_ahb_system_configuration cfg;
    svt_ahb_master_configuration mycfg;
    
    `uvm_component_utils(myenv)
    function new(string name="myenv",uvm_component parent);
        super.new(name,parent);
        
    endfunction
    extern function void build_phase(uvm_phase phase);
    function void end_of_elaboration_phase(uvm_phase phase);
        `uvm_info("end_of_elaboration_phase", "Entered...", UVM_LOW)
        uvm_top.print_topology();
        `uvm_info("end_of_elaboration_phase", "Exiting...", UVM_LOW)
      endfunction: end_of_elaboration_phase
    // extern virtual function void check_internal();
endclass 

function void myenv::build_phase(uvm_phase phase);
    /**
     * Check if the configuration is passed to the environment.
     * If not then create the configuration and pass it to the agent.
     */
    agt=svt_ahb_master_agent::type_id::create("agt",this);
    cfg = cust_svt_ahb_system_configuration::type_id::create("cfg");
    mycfg=svt_ahb_master_configuration::type_id::create("mycfg");

    // mycfg.transaction_coverage_enable=1;
    // mycfg.
    mycfg.is_active=1;
    mycfg.data_width=32;
    mycfg.enable_xml_gen=1;
    mycfg.transaction_coverage_enable=1;

  
    /** Apply the configuration to the System ENV */
    uvm_config_db#(svt_ahb_master_configuration)::set(this, "agt", "cfg", cfg.master_cfg[0]);//采用system_cfg
    // uvm_config_db#(svt_ahb_master_configuration)::set(this, "agt", "cfg", mycfg);//采用master_cfg，这样就会有问题

    
    // uvm_config_db#(virtual ahb_reset_if.ahb_reset_modport)::set(uvm_root::get(), "uvm_test_top.env.sequencer", "reset_mp", ahb_reset_if.ahb_reset_modport);
    uvm_config_db#(uvm_object_wrapper)::set(this, "agt.sequencer.main_phase", "default_sequence", simpleSeq::type_id::get());
    uvm_config_db#(int unsigned)::set(this, "uvm_test_top.agt.sequencer.simpleSeq", "sequence_length", 50);

    $display("this is your first vip,success!!");
    // check_internal();
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

