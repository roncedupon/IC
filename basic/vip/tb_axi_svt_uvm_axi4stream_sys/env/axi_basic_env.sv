//=======================================================================
// COPYRIGHT (C) 2010, 2011, 2012, 2013 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//-----------------------------------------------------------------------

/**
 * Abstract: 
 * class 'axi_basic_env' is extended from uvm_env base class.  It implements
 * the build phase to construct the structural elements of this environment.
 *
 * axi_basic_env is the testbench environment, which constructs the AXI System
 * ENV in the build_phase method using the UVM factory service.  The AXI System
 * ENV  is the top level component provided by the AXI VIP. The AXI System ENV
 * in turn, instantiates constructs the AXI Master and Slave agents. 
 *
 * axi_basic env also constructs the virtual sequencer. This virtual sequencer
 * in the testbench environment obtains a handle to the reset interface using
 * the config db.  This allows reset sequences to be written for this virtual
 * sequencer.
 *
 * The simulation ends after all the objections are dropped.  This is done by
 * using objections provided by phase arguments.
 */
`ifndef GUARD_AXI_BASIC_ENV_SV
`define GUARD_AXI_BASIC_ENV_SV

`include "axi_virtual_sequencer.sv"
`include "cust_svt_axi_system_configuration.sv"
`include "cust_svt_axi_system_cc_configuration.sv"

class axi_basic_env extends uvm_env;

  /** AXI System ENV */
  svt_axi_system_env   axi_system_env;

  /** Virtual Sequencer */
  axi_virtual_sequencer sequencer;

  /** AXI System Configuration */
  cust_svt_axi_system_configuration cfg;

  /** AXI System Configuration from Core Consultant */
  cust_svt_axi_system_cc_configuration cc_cfg;

  /** UVM Component Utility macro */
  `uvm_component_utils(axi_basic_env)

  /** Class Constructor */
  function new (string name="axi_basic_env", uvm_component parent=null);
    super.new (name, parent);
  endfunction

  /** Build the AXI System ENV */
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered...",UVM_LOW)

    super.build_phase(phase);

    /**
     * Check if the configuration is passed to the environment.
     * If not then create the configuration and pass it to the agent.
     */

    // Configuration created through core consultant
    if (uvm_config_db#(cust_svt_axi_system_cc_configuration)::get(this, "", "cc_cfg", cc_cfg)) begin
      /** Apply the configuration to the System ENV */
      uvm_config_db#(svt_axi_system_configuration)::set(this, "axi_system_env", "cfg", cc_cfg);
    end
    else if (uvm_config_db#(cust_svt_axi_system_configuration)::get(this, "", "cfg", cfg)) begin
      /** Apply the configuration to the System ENV */
      uvm_config_db#(svt_axi_system_configuration)::set(this, "axi_system_env", "cfg", cfg);
    end
    // No configuration passed from test
    else begin
      cfg = cust_svt_axi_system_configuration::type_id::create("cfg");
      /** Apply the configuration to the System ENV */
      uvm_config_db#(svt_axi_system_configuration)::set(this, "axi_system_env", "cfg", cfg);
    end

    /** Construct the system agent */
    axi_system_env = svt_axi_system_env::type_id::create("axi_system_env", this);

    /** Construct the virtual sequencer */
    sequencer = axi_virtual_sequencer::type_id::create("sequencer", this);

    `uvm_info("build_phase", "Exiting...", UVM_LOW)
  endfunction


endclass

`endif // GUARD_AXI_BASIC_ENV_SV
