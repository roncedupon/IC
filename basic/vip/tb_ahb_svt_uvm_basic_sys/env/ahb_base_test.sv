
/**
 * Abstract:
 * This file creates a base test, which serves as the base class for the rest
 * of the tests in this environment.  This test sets up the default behavior
 * for the rest of the tests in this environment.
 *
 * In the build phase of the test we will set the necessary test related 
 * information:
 *  - Use type wide factory override to set cust_svt_ahb_master_transaction
 *    as the default master transaction type
 *  - Create a default configuration and set it to the ahb_basic_env instance
 *    using the configuration DB
 *  - Create the ahb_basic_env instance (named env)
 *  - Configure the ahb_master_random_discrete_virtual_sequence as the default
 *    sequence for the main phase of the virtual sequence of the AHB System ENV
 *    virtual sequencer.  This sequence can be disabled by extended tests by
 *    setting the ahb_null_virtual_sequence.
 *  - Configure the sequence length to 50
 *  - Configure the ahb_slave_mem_response_sequence as the default
 *    sequence for all Slave Sequencers
 *  - Configure the ahb_simple_reset_sequence as the default sequence
 *    for the reset phase of the TB ENV virtual sequencer
 */
`ifndef GUARD_AHB_BASE_TEST_SV
`define GUARD_AHB_BASE_TEST_SV

`include "ahb_basic_env.sv"
`include "cust_svt_ahb_system_configuration.sv"
`include "cust_svt_ahb_master_transaction.sv"
`include "cust_svt_ahb_slave_transaction.sv"
`include "ahb_master_random_discrete_virtual_sequence.sv"
`include "ahb_slave_mem_response_sequence.sv"
`include "ahb_simple_reset_sequence.sv"

class ahb_base_test extends uvm_test;

  /** UVM Component Utility macro */
  `uvm_component_utils(ahb_base_test)

  /** Instance of the environment */
  ahb_basic_env env;

  /** Customized configuration */
  cust_svt_ahb_system_configuration cfg;

  /** Class Constructor */
  function new(string name = "ahb_base_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction: new

  /** Allow a test to tweak the configuration */
  virtual function void test_cfg(cust_svt_ahb_system_configuration cfg);
  endfunction

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
    set_type_override_by_type (svt_ahb_master_transaction::get_type(),
                               cust_svt_ahb_master_transaction::get_type());

    /** Factory override of the slave transaction object */
    set_type_override_by_type (svt_ahb_slave_transaction::get_type(),
                               cust_svt_ahb_slave_transaction::get_type());

    /** Create the configuration object */
    cfg = cust_svt_ahb_system_configuration::type_id::create("cfg");
    test_cfg(cfg);

    /** Set configuration in environment */
    uvm_config_db#(cust_svt_ahb_system_configuration)::set(this, "env", "cfg", this.cfg);

    /** Create the environment */
    env = ahb_basic_env::type_id::create("env", this);

    /** Apply the default sequence to the System ENV virtual sequencer
     * A virtual sequence is applied by default which generates unconstrained random
     * master transactions on all masters.  Extended tests can disable this behavior in
     * one of two ways:
     *   1) If using UVM 1.0 then this virtual sequence can be overriden with the
     *      ahb_null_virtual_sequence.
     *   2) If using UVM 1.1 then his virtual sequence can be overriden by configuring
     *      the default sequence of the main phase as 'null'.
     * 
     * Note that this sequence is configured using the uvm_object_wrapper with the
     * uvm_config_db. So extended tests must also configure the default_sequence using
     * the uvm_object_wrapper rather than using a sequence instance.
     */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.ahb_system_env.sequencer.main_phase", "default_sequence", ahb_master_random_discrete_virtual_sequence::type_id::get());

    /** Set the sequence 'length' to generate 50 transactions */
    uvm_config_db#(int unsigned)::set(this, "env.ahb_system_env.sequencer.ahb_master_random_discrete_virtual_sequence", "sequence_length", 50);

    /** Apply the Slave default response sequence to every Slave sequencer
     * Slaves will use the memory response sequence by default.  To override this behavior
     * extended tests can apply a different sequence to the Slave Sequencers.
     * 
     * This sequence is configured for the run phase since the slave should always
     * respond to recognized requests.
     */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.ahb_system_env.slave*.sequencer.run_phase", "default_sequence", ahb_slave_mem_response_sequence::type_id::get());

    /** Apply the default reset sequence */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.sequencer.reset_phase", "default_sequence", ahb_simple_reset_sequence::type_id::get());

    `uvm_info("build_phase", "Exiting...", UVM_LOW)
  endfunction: build_phase

  function void end_of_elaboration_phase(uvm_phase phase);
    `uvm_info("end_of_elaboration_phase", "Entered...", UVM_LOW)
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

`endif // GUARD_AHB_BASE_TEST_SV
