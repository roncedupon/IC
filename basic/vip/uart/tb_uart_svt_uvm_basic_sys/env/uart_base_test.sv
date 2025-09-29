
`ifndef GUARD_UART_BASE_TEST_SV
`define GUARD_UART_BASE_TEST_SV

`include "cust_svt_uart_transaction.sv"
`include "cust_svt_uart_agent_configuration.sv"
`include "uart_basic_env.sv"
`include "uart_default_sequence.sv"
`include "uart_default_virtual_sequence.sv"
`include "uart_simple_reset_sequence.sv"
`include "uart_null_virtual_sequence.sv"

/**
 * Abstract:
 * This file creates a base test, which serves as the base class for the rest
 * of the tests in this environment.  This test sets up the default behavior
 * for the rest of the tests in this environment.
 *
 * In the build_phase phase of the test we will set the necessary test related 
 * information:
 *  - Use type wide factory override to set cust_svt_uart_transaction
 *    as the default transaction type
 *  - Create a default configuration and set it to the uart_basic_env instance
 *    using the configuration DB
 *  - Create the uart_basic_env instance (named env)
 *  - Configure the uart_default_virtual_sequence as the default
 *    sequence for the main phase of the UART ENV virtual sequencer
 *  - Configure the sequence length to 10
 *  - Configure the uart_simple_reset_sequence as the default sequence
 *    for the reset phase of the TB ENV virtual sequencer
 *  - Set the Pass/Fail criterion in the final_phase() using report_server
 */

class uart_base_test extends uvm_test;

  /** Instance of the environment */
  uart_basic_env env;
  
  /** Configuration Instance for DTE agent */
  cust_svt_uart_agent_configuration dte_cfg;
  /** Configuration Instance for DCE agent */
  cust_svt_uart_agent_configuration dce_cfg;

  /** UVM component utility macro */
  `uvm_component_utils(uart_base_test)

  /** Class constructor */
  function new(string name ="uart_base_test", uvm_component parent);
    super.new(name,parent);
  endfunction : new

  /**
   * Build Phase
   * - Create and apply the customized configuration transaction factory
   * - Create the TB ENV
   * - Set the default sequences
   */
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered ...", UVM_LOW)
    super.build_phase(phase);

    /** Replace blueprint of svt_uart_transaction with cust_svt_uart_transaction using factories in UVM */
    set_type_override_by_type(svt_uart_transaction::get_type(),cust_svt_uart_transaction::get_type());

    /** Create the configuration object for DTE agent */
    dte_cfg = cust_svt_uart_agent_configuration::type_id::create("dte_cfg");

    /** Create the configuration object for DCE agent */
    dce_cfg = cust_svt_uart_agent_configuration::type_id::create("dce_cfg");

    /** Set the configuration values for DTE agent */
    dte_cfg.is_active                     = 1;
    /** Set the configuration values for DCE agent */
    dce_cfg.is_active                     = 1;

    /** Set DTE configuration in environment */
    uvm_config_db#(cust_svt_uart_agent_configuration)::set(this,"env","dte_cfg",dte_cfg);

    /** Set DCE configuration in environment */
    uvm_config_db#(cust_svt_uart_agent_configuration)::set(this,"env","dce_cfg",dce_cfg);

    /** Create the environment */
    env = uart_basic_env::type_id::create("env", this);
     
    /** Apply the null virtual sequence to the Uart ENV virtual sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.sequencer.main_phase", "default_sequence", 
					    uart_default_virtual_sequence::type_id::get());

    /** Set the sequence 'length' to generate 10 transaction with constraints */
    uvm_config_db#(int unsigned)::set(this, "env.sequencer.uart_default_virtual_sequence", 
				      "sequence_length", 10);
    
    /** Apply the default reset sequence */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.sequencer.reset_phase", "default_sequence", 
					    uart_simple_reset_sequence::type_id::get());
   
    `uvm_info("build_phase", "Exited ...", UVM_LOW)
  endfunction : build_phase
   
  /** The drain time is set up for the main phase, as 
   * the stimulus is set for the main_phase. 
   * The value of drain time is set such as to ensure that all the  
   * transmitted packets are successfully received at the Receiver.
   * The timeunit must be ensured to be in units of 
   * nanoseconds(ns).
   */
  task main_phase(uvm_phase phase);
    uvm_objection phase_over;
    `uvm_info("main_phase", "Entered ...",UVM_LOW)
    `uvm_info("main_phase",$sformatf("Setting the drain time in the main_phase of the base test to 6000000"),UVM_NONE) 

    phase_over = phase.get_objection();
    phase_over.set_drain_time(this, (6000000));
    `uvm_info("main_phase", "Exited ...",UVM_LOW)
  endtask // main_phase

  /**
   * Calculate the pass or fail status for the test in the final phase method of the
   * test. If a UVM_FATAL, UVM_ERROR, or a UVM_WARNING message has been generated the
   * test will fail.
   */
  function void final_phase(uvm_phase phase);
    uvm_report_server svr;
    `uvm_info("final_phase", "Entered ...",UVM_LOW)

    super.final_phase(phase);

    svr = uvm_report_server::get_server();

    if (svr.get_severity_count(UVM_FATAL) + 
      svr.get_severity_count(UVM_ERROR) + 
      svr.get_severity_count(UVM_WARNING) > 0)
      `uvm_info("final_phase", "\nSvtTestEpilog: Failed\n", UVM_LOW)
    else
      `uvm_info("final_phase", "\nSvtTestEpilog: Passed\n", UVM_LOW)
    `uvm_info("final_phase", "Exited ...",UVM_LOW)
  endfunction

endclass : uart_base_test

`endif //  `ifndef GUARD_UART_BASE_TEST_SV

