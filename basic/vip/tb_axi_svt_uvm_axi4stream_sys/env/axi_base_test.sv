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
//=======================================================================

/**
 * Abstract:
 * This file creates a basetest, which serves as the base class for the rest
 * of the tests in this environment.  This test sets up the default behavior
 * for the rest of the tests in this environment.
 *
 * In the build_phase phase of the test we will set the necessary test related 
 * information:
 *  - Use type wide factory override to set cust_svt_axi_master_transaction
 *    as the default master transaction type
 *  - Create a default configuration and set it to the axi_basic_env instance
 *    using the configuration DB
 *  - Create the axi_basic_env instance (named env)
 *  - Configure the axi_master_random_discrete_virtual_sequence as the default
 *    sequence for the main phase of the virtual sequence of the AXI System ENV
 *    virtual sequencer.  This sequence can be disabled by extended tests by
 *    setting the axi_null_virtual_sequence.
 *  - Configure the sequence length to 50
 *  - Configure the axi_slave_mem_response_sequence as the default
 *    sequence for all Slave Sequencers
 *  - Configure the axi_simple_reset_sequence as the default sequence
 *    for the reset phase of the TB ENV virtual sequencer
 */
`ifndef GUARD_AXI_BASE_TEST_SV
`define GUARD_AXI_BASE_TEST_SV

`include "axi_basic_env.sv"
`include "cust_svt_axi_system_configuration.sv"
`include "cust_svt_axi_system_cc_configuration.sv"
`include "cust_svt_axi_master_transaction.sv"
`include "axi_master_random_discrete_virtual_sequence.sv"
`include "axi_slave_mem_response_sequence.sv"
`include "axi_simple_reset_sequence.sv"


class axi_base_test extends uvm_test;

  /** UVM Component Utility macro */
  `uvm_component_utils(axi_base_test)

  /** Instance of the environment */
  axi_basic_env env;

  /** Load through configCreator and load_prop_val */ 
  /** Required to set to 1 if load vip configurations through configCreator gui */ 
  bit load_through_config_creator = 0;

  /** Path variable for the Config file created through configCreator to configure the vip */ 
  string axi_cfg_file = "./env/axi_config.cfg";

  /** Customized configuration */
  cust_svt_axi_system_configuration cfg;

  /** Customized configCreator configuration handle */
  cust_svt_axi_system_cc_configuration cc_cfg;

  /** Class Constructor */
  function new(string name = "axi_base_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction: new

  /**
   * Build Phase
   * - Create and apply the customized configuration transaction factory
   * - Create the TB ENV
   * - Set the default sequences
   */
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered...", UVM_LOW)
    super.build_phase(phase);

    /** Factory override of the master transaction object */
    set_type_override_by_type (svt_axi_master_transaction::get_type(),
                               cust_svt_axi_master_transaction::get_type());

    `uvm_info("build_phase", "Value of load_through_config_creator ...", UVM_LOW)
    `uvm_info("build_phase", $sformatf("load_through_config_creator = %0b",load_through_config_creator), UVM_LOW)

    /** Load through configCreator */
    if (load_through_config_creator) begin
      cc_cfg = cust_svt_axi_system_cc_configuration::type_id::create("cc_cfg");
      cc_cfg.create_sub_cfgs(1,1);
      if (cc_cfg.load_prop_vals(axi_cfg_file)) begin
        `uvm_info("build_phase", "Successfully loaded cust_svt_axi_system_cc_configuration ...", UVM_LOW)
        if (cc_cfg.is_valid(0)) begin
	  `uvm_info("build_phase", "Loaded cust_svt_axi_system_cc_configuration is VALID ...", UVM_LOW)
    	  uvm_config_db#(cust_svt_axi_system_cc_configuration)::set(this, "env", "cc_cfg", this.cc_cfg);
	end
	else begin
	  `uvm_fatal("build_phase", "Loaded cust_svt_axi_system_cc_configuration is NOT VALID ...")
	end
      end
      else begin
        `uvm_fatal("build_phase", "Failed attempting to load cust_svt_axi_system_cc_configuration ...")
      end
    end
    else begin
      `uvm_info("build_phase", "Loaded cust_svt_axi_system_configuration ", UVM_LOW)
      /** Create the configuration object */
      cfg = cust_svt_axi_system_configuration::type_id::create("cfg");

      /** Set configuration in environment */
      uvm_config_db#(cust_svt_axi_system_configuration)::set(this, "env", "cfg", this.cfg);
    end

    /** Create the environment */
    env = axi_basic_env::type_id::create("env", this);

    /** Apply the default sequence to the System ENV virtual sequencer
     * A virtual sequence is applied by default which generates unconstrained random
     * master transactions on all masters.  Extended tests can disable this behavior in
     * one of two ways:
     *   1) If using UVM 1.0 then this virtual sequence can be overriden with the
     *      axi_null_virtual_sequence.
     *   2) If using UVM 1.1 then his virtual sequence can be overriden by configuring
     *      the default sequence of the main phase as 'null'.
     * 
     * Note that this sequence is configured using the uvm_object_wrapper with the
     * uvm_config_db. So extended tests must also configure the default_sequence using
     * the uvm_object_wrapper rather than using a sequence instance.
     */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.axi_system_env.sequencer.main_phase", "default_sequence", axi_master_random_discrete_virtual_sequence::type_id::get());

    /** Set the sequence 'length' to generate 50 transactions */
    uvm_config_db#(int unsigned)::set(this, "env.axi_system_env.sequencer.axi_master_random_discrete_virtual_sequence", "sequence_length", 50);

    /** Set the default_sequence for slave vip */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.axi_system_env.slave[0].sequencer.run_phase", "default_sequence", axi_slave_mem_response_sequence::type_id::get());
    /** Apply the default reset sequence */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.sequencer.reset_phase", "default_sequence", axi_simple_reset_sequence::type_id::get());

    `uvm_info("build_phase", "Exiting...", UVM_LOW)
  endfunction: build_phase

  function void end_of_elaboration_phase(uvm_phase phase);
    uvm_object_wrapper _get_slave_resp_seq_item;
    `uvm_info("end_of_elaboration_phase", "Entered...", UVM_LOW)

    /** Apply the Slave default response sequence to every Slave sequencer
     * Slaves will use the memory response sequence by default.  To override this behavior
     * extended tests can apply a different sequence to the Slave Sequencers.
     * 
     * This sequence is configured for the run phase since the slave should always
     * respond to recognized requests.
     */

    uvm_top.print_topology();
    `uvm_info("end_of_elaboration_phase", "Exiting...", UVM_LOW)
  endfunction: end_of_elaboration_phase

  /**
   * Calculate the pass or fail status for the test in the final phase method of the
   * test. If a UVM_FATAL, UVM_ERROR, or a UVM_WARNING message has been generated the
   * test will fail.
   */
  function void final_phase(uvm_phase phase);
    uvm_report_server svr;
    `uvm_info("final_phase", "Entered...",UVM_LOW)

    super.final_phase(phase);

    svr = uvm_report_server::get_server();

    if (svr.get_severity_count(UVM_FATAL) +
        svr.get_severity_count(UVM_ERROR) +
        svr.get_severity_count(UVM_WARNING) > 0) 
      `uvm_info("final_phase", "\nSvtTestEpilog: Failed\n", UVM_LOW)
    else
      `uvm_info("final_phase", "\nSvtTestEpilog: Passed\n", UVM_LOW)

    `uvm_info("final_phase", "Exiting...", UVM_LOW)
  endfunction: final_phase

endclass

`endif // GUARD_AXI_BASE_TEST_SV
