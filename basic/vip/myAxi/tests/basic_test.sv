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
 *  - Create a default configuration and set it to the basic_env instance
 *    using the configuration DB
 *  - Create the basic_env instance (named env)
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
`ifndef GUARD_basic_test_SV
`define GUARD_basic_test_SV
class basic_test extends uvm_test;

  /** UVM Component Utility macro */
  `uvm_component_utils(basic_test)

  /** Instance of the environment */
  basic_env env;


  
  function new(string name = "basic_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction: new


  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered...", UVM_LOW)
    super.build_phase(phase);
    env = basic_env::type_id::create("env", this);
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

`endif // GUARD_basic_test_SV
