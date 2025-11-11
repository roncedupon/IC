
/**
 * Abstract:
 * This test shows the usecase of EI "I2C_INSERT_P_AFTER_MASTER_CODE".
 * This EI is used to forcefully insert stop right after master code is received inspite of NACK reception.
 * Callback used is "i2c_master_insert_stop_after_master_code_callback".
 * Following errors are expected to arrive and needs to be demoted when using this EI:
 * 1: i2c_master_id_followed_by_ack
 */

`include "i2c_base_test.sv"
`include "i2c_master_write_data_sequence.sv"
`include "i2c_slave_user_conf_sequence.sv"
`include "i2c_null_virtual_sequence.sv"
`include "i2c_master_insert_stop_after_master_code_callback.sv"

class i2c_master_insert_stop_after_master_code_in_hs_mode_test extends i2c_base_test;

    i2c_master_write_data_sequence mst_seq;
    i2c_slave_user_conf_sequence slv_seq;
    i2c_master_insert_stop_after_master_code_callback cust_callback;

  /** UVM component utility macro */
  `uvm_component_utils(i2c_master_insert_stop_after_master_code_in_hs_mode_test)

  /** Class constructor */
  function new(string name = "i2c_master_insert_stop_after_master_code_in_hs_mode_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  /** build() - Method to build various component */
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build phase", "Entered ...", UVM_LOW)

    super.build_phase(phase);

    cust_callback = new("cust_callback");

    /** Disable the virtual default sequence on the the virtual sequencer started in the i2c_base_test */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.i2c_system_env.sequencer.main_phase", "default_sequence", i2c_null_virtual_sequence::type_id::get());

    `uvm_info("build phase", "Exited ...", UVM_LOW)
  endfunction : build_phase

  // run_phase
  virtual task run_phase(uvm_phase phase);
    `uvm_info ("run_phase", "Entered in Run Phase ... ",UVM_LOW)

    phase.raise_objection(this);
    `uvm_info ("run_phase", "Objection Raised ",UVM_LOW)

    super.run_phase(phase);

    mst_seq = i2c_master_write_data_sequence::type_id::create("mst_seq");
    mst_seq.insert_error = 0; //this variable is used to enable/disable the EI. [Here EI is disabled].
    slv_seq = i2c_slave_user_conf_sequence::type_id::create("slv_seq");

    fork
      mst_seq.start(env.i2c_system_env.master[0].sequencer);
      slv_seq.start(env.i2c_system_env.slave[0].sequencer);
    join

     /** Reconfigure Master and Slave */
    cfg.master_cfg[0].bus_speed = HIGHSPEED_MODE;   // Set Bus-Speed to HIGHSPEED MODE
    cfg.slave_cfg[0].bus_speed  = HIGHSPEED_MODE;   // Set Bus-Speed to HIGHSPEED MODE
    cfg.master_cfg[0].start_hs_in_fm_plus = 1'b1; 
    cfg.slave_cfg[0].start_hs_in_fm_plus = 1'b1; 

    env.i2c_system_env.master[0].reconfigure_via_task(cfg.master_cfg[0]);  // Reconfigure method 
    env.i2c_system_env.slave[0].reconfigure_via_task(cfg.slave_cfg[0]);    // Reconfigure method 
    mst_seq.insert_error = 1; //this variable is used to enable/disable the EI. [Here EI is enabled].

    fork
      mst_seq.start(env.i2c_system_env.master[0].sequencer);
      slv_seq.start(env.i2c_system_env.slave[0].sequencer);
    join

    /** Reconfigure Master and Slave */
    cfg.master_cfg[0].bus_speed = HIGHSPEED_MODE;   // Set Bus-Speed to HIGHSPEED MODE
    cfg.slave_cfg[0].bus_speed  = HIGHSPEED_MODE;   // Set Bus-Speed to HIGHSPEED MODE
    cfg.master_cfg[0].start_hs_in_fm_plus = 1'b1; 
    cfg.slave_cfg[0].start_hs_in_fm_plus = 1'b1; 

    env.i2c_system_env.master[0].reconfigure_via_task(cfg.master_cfg[0]);  // Reconfigure method 
    env.i2c_system_env.slave[0].reconfigure_via_task(cfg.slave_cfg[0]);    // Reconfigure method 
    mst_seq.insert_error = 1; //this variable is used to enable/disable the EI. [Here EI is enabled].

    fork
      mst_seq.start(env.i2c_system_env.master[0].sequencer);
      slv_seq.start(env.i2c_system_env.slave[0].sequencer);
    join

    /** Reconfigure Master and Slave */
    cfg.master_cfg[0].bus_speed = HIGHSPEED_MODE;   // Set Bus-Speed to HIGHSPEED MODE
    cfg.slave_cfg[0].bus_speed  = HIGHSPEED_MODE;   // Set Bus-Speed to HIGHSPEED MODE
    cfg.master_cfg[0].start_hs_in_fm_plus = 1'b1; 
    cfg.slave_cfg[0].start_hs_in_fm_plus = 1'b1; 

    env.i2c_system_env.master[0].reconfigure_via_task(cfg.master_cfg[0]);  // Reconfigure method 
    env.i2c_system_env.slave[0].reconfigure_via_task(cfg.slave_cfg[0]);    // Reconfigure method 
    mst_seq.insert_error = 0; //this variable is used to enable/disable the EI. [Here EI is disabled].

    fork
      mst_seq.start(env.i2c_system_env.master[0].sequencer);
      slv_seq.start(env.i2c_system_env.slave[0].sequencer);
    join

   
    phase.drop_objection(this);
    `uvm_info ("run_phase", "Objection Dropped ",UVM_LOW)
  endtask

   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     svt_i2c_master_callback_pool::add(env.i2c_system_env.master[0].driver,cust_callback);
     disable_error();
   endfunction: connect_phase

   function void disable_error();
    env.i2c_system_env.master[0].monitor.err_check.i2c_master_id_followed_by_ack.set_default_fail_effect(svt_err_check_stats::NOTE);
    env.i2c_system_env.slave[0].monitor.err_check.i2c_master_id_followed_by_ack.set_default_fail_effect(svt_err_check_stats::NOTE);
  endfunction: disable_error

endclass
