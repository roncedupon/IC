
`ifndef GUARD_I2C_BASE_TEST_SV
`define GUARD_I2C_BASE_TEST_SV

`include "cust_svt_i2c_master_transaction.sv"
`include "cust_svt_i2c_slave_transaction.sv"
`include "cust_svt_i2c_system_configuration.sv"
`include "i2c_basic_env.sv"
`include "i2c_default_mst_sequence.sv"
`include "i2c_default_slv_sequence.sv"
`include "i2c_default_virtual_sequence.sv"
`include "i2c_simple_reset_sequence.sv"
`include "i2c_mst_deviceid_sequence.sv"
`include "i2c_mst_generate_stop_insted_of_repeatedstart_after_10bit_slave_address_deviceid_sequence.sv"
`include "i2c_mst_generate_stop_insted_of_repeatedstart_after_slave_address_deviceid_sequence.sv"
`include "i2c_mst_send_nack_after_1st_byte_of_deviceid_sequence.sv"
`include "i2c_mst_send_nack_after_2nd_byte_of_deviceid_sequence.sv"
`include "i2c_mst_send_nack_after_3rd_byte_of_deviceid_sequence.sv"
`include "i2c_mst_send_nack_after_3rd_byte_of_deviceid_with_rollback_iteration_enable_sequence.sv"
`include "i2c_mst_send_nack_after_5th_byte_of_deviceid_with_rollback_iteration_enable_sequence.sv"
`include "i2c_mst_send_nack_after_6th_byte_of_deviceid_with_rollback_iteration_enable_sequence.sv"

/**
 * Abstract:
 * In the build_phase phase of the test we will set the necessary test related 
 * information:
 * - Use type wide factory override to set cust_svt_i2c_master_transaction
 *   and cust_svt_i2c_slave_transaction as the default transaction type
 * - Create a default configuration and set it to the i2c_basic_env instance
 *   using the configuration DB
 * - Create the i2c_basic_env instance (named env)
 * - Configure the i2c_default_virtual_sequence as the default
 *   sequence for the main phase of the I2C ENV virtual sequencer
 * - Configure the sequence length to 1
 * - Configure the i2c_simple_reset_sequence as the default sequence
 *   for the reset phase of the TB ENV virtual sequencer
 * .
 */
class i2c_base_test extends uvm_test;
   
  /** UVM component utility macro */
  `uvm_component_utils(i2c_base_test)

  /** Instance of the environment */
  i2c_basic_env env;

  /** Instantiate the configuration for Master*/
  cust_svt_i2c_system_configuration cfg;

  /** Class constructor */
  function new(string name = "i2c_base_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  /** build() - Method to build various component */
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

   `uvm_info("build_phase", "i2c_base_test BUILD-FLOW: Starting...",UVM_LOW)

    /** replace blueprint of svt_i2c_master_transaction with cust_svt_i2c_master_transaction using factories in UVM */
    set_type_override_by_type(svt_i2c_master_transaction::get_type(),cust_svt_i2c_master_transaction::get_type());
    
    /** replace blueprint of svt_i2c_slave_transaction with cust_svt_i2c_slave_transaction using factories in UVM */
    set_type_override_by_type(svt_i2c_slave_transaction::get_type(),cust_svt_i2c_slave_transaction::get_type());

    /** Create the configuration object for Master agent */
    cfg = cust_svt_i2c_system_configuration::type_id::create("cfg");

    /** Configure Master and Slave configurations */
    cfg.set_bus_speed(STANDARD_MODE);                           // Set Bus-Speed
    cfg.master_cfg[0].master_code       = 3'b101             ;  // Set Master Code
    cfg.slave_cfg[0].slave_address      = `SVT_I2C_SLAVE0_ADDRESS;  // Set Slave Address     
    cfg.slave_cfg[0].enable_10bit_addr  =  0                 ;  // disable 10-bit Addressing
    cfg.slave_cfg[0].slave_type         = `SVT_I2C_GENERIC       ;  // Set Slave as Generic 

    /** Set Master configuration in environment */
    uvm_config_db#(cust_svt_i2c_system_configuration)::set(this,"env", "i2c_system_cfg", cfg);

    /** Create the environment */
    env = i2c_basic_env::type_id::create("env", this);

    /** Apply the default virtual sequence */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.i2c_system_env.sequencer.main_phase", "default_sequence", i2c_default_virtual_sequence::type_id::get());

    /** Set the sequence 'length' to generate 1 transaction with constraints */
    uvm_config_db#(int unsigned)::set(this, "env.i2c_system_env.sequencer.i2c_default_virtual_sequence", "sequence_length", 100);
    
    /** Apply the default reset sequence */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.sequencer.reset_phase", "default_sequence", i2c_simple_reset_sequence::type_id::get());

    `uvm_info("build_phase", "i2c_base_test BUILD-FLOW: Finishing...",UVM_LOW)
  endfunction : build_phase
  
  /** This is the main_phase */ 
  task main_phase(uvm_phase phase);
    `ifdef SVT_UVM_1800_2_2017_OR_HIGHER
     uvm_objection phase_d;
    `endif
    `uvm_info("main_phase", "Entered ...",UVM_LOW)
    `uvm_info("main_phase", $sformatf("Setting the drain time in the main_phase of the base test to twice the configured IPG Length 200"), UVM_NONE) 
      `ifdef SVT_UVM_1800_2_2017_OR_HIGHER
      phase_d = phase.get_objection();
      phase_d.set_drain_time(this, (500));
    `else
      phase.phase_done.set_drain_time(this, (500));
    `endif
    `uvm_info("main_phase", "Exited ...",UVM_LOW)
  endtask
  
  /**
   * Calculate the pass or fail status for the test in the final phase method of the
   * test. If a UVM_FATAL, UVM_ERROR, or a UVM_WARNING message has been generated the
   * test will fail.
   */  
  function void final_phase(uvm_phase phase);
    uvm_report_server svr;

    super.final_phase(phase);

    `uvm_info("final_phase", "i2c_base_test FINAL-FLOW: Starting...",UVM_LOW)

    svr = uvm_report_server::get_server();

    if (svr.get_severity_count(UVM_FATAL) + svr.get_severity_count(UVM_ERROR) + 
	    svr.get_severity_count(UVM_WARNING) > 0) begin
        `uvm_info("final_phase", "\nSvtTestEpilog: Failed\n", UVM_LOW)
    end
    else begin
      `uvm_info("final_phase", "\nSvtTestEpilog: Passed\n", UVM_LOW)
    end
	
    `uvm_info("final_phase", "i2c_base_test FINAL-FLOW: Finishing...",UVM_LOW)
  endfunction : final_phase

endclass : i2c_base_test

`endif

//--------------------------------------------------------------------------
//-------------------------END OF FILE--------------------------------------
//--------------------------------------------------------------------------
