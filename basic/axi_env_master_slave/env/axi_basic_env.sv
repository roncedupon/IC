//=======================================================================
// AXI Basic Environment
// Description: Top-level environment containing AXI system env and virtual sequencer
//=======================================================================

`ifndef GUARD_AXI_BASIC_ENV_SV
`define GUARD_AXI_BASIC_ENV_SV

// Include dependent files
`include "cust_svt_axi_system_configuration.sv"
`include "axi_virtual_sequencer.sv"

class axi_basic_env extends uvm_env;
  
  /** AXI System Environment - provided by VIP */
  svt_axi_system_env axi_system_env;
  
  /** Virtual Sequencer for coordinating sequences */
  axi_virtual_sequencer sequencer;
  
  /** Configuration object */
  cust_svt_axi_system_configuration cfg;
  
  /** UVM Component Utility macro */
  `uvm_component_utils(axi_basic_env)
  
  /** Class Constructor */
  function new(string name = "axi_basic_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  /** Build Phase - construct components */
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered...", UVM_LOW)
    super.build_phase(phase);
    
    // Check if configuration is passed from test
    if (!uvm_config_db#(cust_svt_axi_system_configuration)::get(this, "", "cfg", cfg)) begin
      // Create default configuration if not provided
      cfg = cust_svt_axi_system_configuration::type_id::create("cfg");
    end
    
    // Apply configuration to system env
    uvm_config_db#(svt_axi_system_configuration)::set(this, "axi_system_env", "cfg", cfg);
    
    // Construct AXI System Environment
    axi_system_env = svt_axi_system_env::type_id::create("axi_system_env", this);
    
    // Construct Virtual Sequencer
    sequencer = axi_virtual_sequencer::type_id::create("sequencer", this);
    
    `uvm_info("build_phase", "Exiting...", UVM_LOW)
  endfunction
  
  /** Connect Phase - establish TLM connections */
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    // Assign master sequencer handle to virtual sequencer
    sequencer.m_master_seqr = axi_system_env.master[0].sequencer;
    
    // Assign slave sequencer handle to virtual sequencer  
    sequencer.m_slave_seqr = axi_system_env.slave[0].sequencer;
    
  endfunction
  
endclass

`endif // GUARD_AXI_BASIC_ENV_SV
