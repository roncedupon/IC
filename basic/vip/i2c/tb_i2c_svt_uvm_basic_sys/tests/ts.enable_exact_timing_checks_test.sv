
/**
 * Abstract:
 * The file contains the class extended from i2c_base_test.
 * It disables the base test case virtual sequence on the virtual sequencer.
 * This test case showcases how to send user configurable data from slave.
 */

`include "i2c_base_test.sv"
`include "i2c_master_write_two_byte_sequence.sv"
`include "i2c_slave_user_conf_sequence.sv"
`include "i2c_null_virtual_sequence.sv"

class enable_exact_timing_checks_test extends i2c_base_test;

    i2c_master_write_two_byte_sequence mst_seq;
    i2c_slave_user_conf_sequence slv_seq;

  /** UVM component utility macro */
  `uvm_component_utils(enable_exact_timing_checks_test)

  /** Class constructor */
  function new(string name = "enable_exact_timing_checks_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  /** build() - Method to build various component */
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build phase", "Entered ...", UVM_LOW)

    super.build_phase(phase);

    cfg.master_cfg[0].bus_speed = STANDARD_MODE;   // Set Bus-Speed to STANDARD MODE
    cfg.slave_cfg[0].bus_speed  = STANDARD_MODE;   // Set Bus-Speed to STANDARD MODE
    cfg.slave_cfg[0].hd_dat_time_fs                 = 300; 
    cfg.master_cfg[0].hd_dat_time_fs                = 300; 
    cfg.slave_cfg[0].checks_enable                  = 1; 
    cfg.master_cfg[0].checks_enable                 = 1; 
    cfg.master_cfg[0].enable_chk_scl_high_time_ss   = 1; 
    cfg.master_cfg[0].enable_chk_scl_low_time_ss    = 1; 
    cfg.master_cfg[0].enable_chk_min_hd_sta_time_ss = 1; 
    cfg.master_cfg[0].enable_chk_min_su_sto_time_ss = 1; 
    cfg.slave_cfg[0].enable_chk_scl_high_time_ss    = 1; 
    cfg.slave_cfg[0].enable_chk_scl_low_time_ss     = 1; 
    cfg.slave_cfg[0].enable_chk_min_hd_sta_time_ss  = 1; 
    cfg.slave_cfg[0].enable_chk_min_su_sto_time_ss  = 1; 

    /** Set Master configuration in environment */
    uvm_config_db#(cust_svt_i2c_system_configuration)::set(this,"env", "i2c_system_cfg", cfg);

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

    mst_seq = i2c_master_write_two_byte_sequence::type_id::create("mst_seq"); // Creating mst seq
    slv_seq = i2c_slave_user_conf_sequence::type_id::create("slv_seq");  // Creating slv seq 

    fork
      mst_seq.start(env.i2c_system_env.master[0].sequencer);    // Starting seq on mst sequencer
      slv_seq.start(env.i2c_system_env.slave[0].sequencer);     // Starting seq on slv sequencer 
    join
   
    /** Reconfigure Master and Slave */
    cfg.master_cfg[0].bus_speed = FAST_MODE;   // Set Bus-Speed to FAST MODE
    cfg.slave_cfg[0].bus_speed  = FAST_MODE;   // Set Bus-Speed to FAST MODE
    cfg.slave_cfg[0].checks_enable                  = 1; 
    cfg.master_cfg[0].checks_enable                 = 1; 
    cfg.master_cfg[0].enable_chk_scl_high_time_ss   = 0; 
    cfg.master_cfg[0].enable_chk_scl_low_time_ss    = 0; 
    cfg.master_cfg[0].enable_chk_min_hd_sta_time_ss = 0; 
    cfg.master_cfg[0].enable_chk_min_su_sto_time_ss = 0; 
    cfg.slave_cfg[0].enable_chk_scl_high_time_ss    = 0; 
    cfg.slave_cfg[0].enable_chk_scl_low_time_ss     = 0; 
    cfg.slave_cfg[0].enable_chk_min_hd_sta_time_ss  = 0; 
    cfg.slave_cfg[0].enable_chk_min_su_sto_time_ss  = 0; 
    cfg.master_cfg[0].enable_chk_scl_high_time_fs   = 1; 
    cfg.master_cfg[0].enable_chk_scl_low_time_fs    = 1; 
    cfg.master_cfg[0].enable_chk_min_hd_sta_time_fs = 1; 
    cfg.master_cfg[0].enable_chk_min_su_sto_time_fs = 1; 
    cfg.slave_cfg[0].enable_chk_scl_high_time_fs    = 1; 
    cfg.slave_cfg[0].enable_chk_scl_low_time_fs     = 1; 
    cfg.slave_cfg[0].enable_chk_min_hd_sta_time_fs  = 1; 
    cfg.slave_cfg[0].enable_chk_min_su_sto_time_fs  = 1; 

    env.i2c_system_env.master[0].reconfigure_via_task(cfg.master_cfg[0]);  // Reconfigure method 
    env.i2c_system_env.slave[0].reconfigure_via_task(cfg.slave_cfg[0]);    // Reconfigure method 

    fork
      mst_seq.start(env.i2c_system_env.master[0].sequencer); // Starting seq on mst sequencer
      slv_seq.start(env.i2c_system_env.slave[0].sequencer);  // Starting seq on slv sequencer
    join


    /** Reconfigure Master and Slave */
    cfg.master_cfg[0].bus_speed = HIGHSPEED_MODE;   // Set Bus-Speed to HIGHSPEED MODE
    cfg.slave_cfg[0].bus_speed  = HIGHSPEED_MODE;   // Set Bus-Speed to HIGHSPEED MODE
    cfg.slave_cfg[0].checks_enable                  = 1; 
    cfg.master_cfg[0].checks_enable                 = 1; 
    cfg.master_cfg[0].enable_chk_scl_high_time_fs   = 0; 
    cfg.master_cfg[0].enable_chk_scl_low_time_fs    = 0; 
    cfg.master_cfg[0].enable_chk_min_hd_sta_time_fs = 0; 
    cfg.master_cfg[0].enable_chk_min_su_sto_time_fs = 0; 
    cfg.slave_cfg[0].enable_chk_scl_high_time_fs    = 0; 
    cfg.slave_cfg[0].enable_chk_scl_low_time_fs     = 0; 
    cfg.slave_cfg[0].enable_chk_min_hd_sta_time_fs  = 0; 
    cfg.slave_cfg[0].enable_chk_min_su_sto_time_fs  = 0; 
    cfg.master_cfg[0].enable_chk_min_hd_sta_time_hs = 1; 
    cfg.master_cfg[0].enable_chk_min_su_sto_time_hs = 1; 
    cfg.slave_cfg[0].enable_chk_min_hd_sta_time_hs  = 1; 
    cfg.slave_cfg[0].enable_chk_min_su_sto_time_hs  = 1; 

    env.i2c_system_env.master[0].reconfigure_via_task(cfg.master_cfg[0]);  // Reconfigure method 
    env.i2c_system_env.slave[0].reconfigure_via_task(cfg.slave_cfg[0]);    // Reconfigure method 

    fork
      mst_seq.start(env.i2c_system_env.master[0].sequencer); // Starting seq on mst sequencer
      slv_seq.start(env.i2c_system_env.slave[0].sequencer);  // Starting seq on slv sequencer
    join

    /** Reconfigure Master and Slave */
    cfg.master_cfg[0].bus_speed = FAST_MODE_PLUS;   // Set Bus-Speed to FAST MODE PLUS
    cfg.slave_cfg[0].bus_speed  = FAST_MODE_PLUS;   // Set Bus-Speed to FAST MODE PLUS
    cfg.slave_cfg[0].checks_enable                  = 1; 
    cfg.master_cfg[0].checks_enable                 = 1; 
    cfg.master_cfg[0].enable_chk_min_hd_sta_time_hs      = 0; 
    cfg.master_cfg[0].enable_chk_min_su_sto_time_hs      = 0; 
    cfg.slave_cfg[0].enable_chk_min_hd_sta_time_hs       = 0; 
    cfg.slave_cfg[0].enable_chk_min_su_sto_time_hs       = 0; 
    cfg.master_cfg[0].enable_chk_scl_high_time_fm_plus   = 1; 
    cfg.master_cfg[0].enable_chk_scl_low_time_fm_plus    = 1; 
    cfg.master_cfg[0].enable_chk_min_hd_sta_time_fm_plus = 1; 
    cfg.master_cfg[0].enable_chk_min_su_sto_time_fm_plus = 1; 
    cfg.slave_cfg[0].enable_chk_scl_high_time_fm_plus    = 1; 
    cfg.slave_cfg[0].enable_chk_scl_low_time_fm_plus     = 1; 
    cfg.slave_cfg[0].enable_chk_min_hd_sta_time_fm_plus  = 1; 
    cfg.slave_cfg[0].enable_chk_min_su_sto_time_fm_plus  = 1; 

    env.i2c_system_env.master[0].reconfigure_via_task(cfg.master_cfg[0]);  // Reconfigure method 
    env.i2c_system_env.slave[0].reconfigure_via_task(cfg.slave_cfg[0]);    // Reconfigure method 

    fork
      mst_seq.start(env.i2c_system_env.master[0].sequencer); // Starting seq on mst sequencer
      slv_seq.start(env.i2c_system_env.slave[0].sequencer);  // Starting seq on slv sequencer
    join

    phase.drop_objection(this);
    `uvm_info ("run_phase", "Objection Dropped ",UVM_LOW)
  endtask

endclass
