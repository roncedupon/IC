/**
 * Abstract:
 * The file contains the class extended from i2c_base_test
 * A simple directed test showcases the use of the directed sequence.
 * It disables the base test case virtual sequence on the virtual sequencer.
 * Aftet that a directed sequence is set on the agent's sequencers.
 */

`include "i2c_base_test.sv"
`include "i2c_master_send_rsvd_1111xxx_to_slv_seq.sv"
`include "i2c_slv_directed_sequence.sv"
`include "i2c_null_virtual_sequence.sv"

class i2c_master_send_rsvd_1111xxx_to_slv_test extends i2c_base_test;

  //i2c_master_started_transction_without_issuing_start_pulse_callback cust_callback;

  /** UVM component utility macro */
  `uvm_component_utils(i2c_master_send_rsvd_1111xxx_to_slv_test)

  /** Class constructor */
  function new(string name = "i2c_master_send_rsvd_1111xxx_to_slv_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  /** build() - Method to build various component */
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build phase", "Entered ...", UVM_LOW)

    super.build_phase(phase);

    //cust_callback = new("cust_callback");

    cfg.set_bus_speed(FAST_MODE);
    cfg.master_cfg[0].enable_put_response = 0;
    cfg.slave_cfg[0].enable_put_response = 0;
    cfg.master_cfg[0].hd_dat_time_fs = 300;
    cfg.slave_cfg[0].hd_dat_time_fs  = 300;
    cfg.slave_cfg[0].slave_address = 7'b1111_101; //reserved address
 
   /** Disable the virtual default sequence on the the virtual sequencer started in the i2c_base_test */
   uvm_config_db#(uvm_object_wrapper)::set(this, "env.i2c_system_env.sequencer.main_phase", "default_sequence", i2c_null_virtual_sequence::type_id::get());

   /** Apply the master directed i2c sequence to the i2c master sequencer */
   uvm_config_db#(uvm_object_wrapper)::set(this, "env.i2c_system_env.master[0].sequencer.main_phase", "default_sequence", i2c_master_send_rsvd_1111xxx_to_slv_seq::type_id::get());
 
   /** Apply the slave directed i2c sequence to the i2c slave sequencer */
   uvm_config_db#(uvm_object_wrapper)::set(this, "env.i2c_system_env.slave[0].sequencer.main_phase", "default_sequence", i2c_slv_directed_sequence::type_id::get());
  
   `uvm_info("build phase", "Exited ...", UVM_LOW)
 endfunction : build_phase

  /** This is the main_phase */ 
  task main_phase(uvm_phase phase);
    `ifdef SVT_UVM_1800_2_2017_OR_HIGHER
     uvm_objection phase_d;
    `endif
    `uvm_info("main_phase", "Entered ...",UVM_LOW)
    `uvm_info("main_phase", $sformatf("Setting the drain time in the main_phase of the i2c_master_send_rsvd_1111xxx_to_slv_test"), UVM_NONE) 
      `ifdef SVT_UVM_1800_2_2017_OR_HIGHER
      phase_d = phase.get_objection();
      phase_d.set_drain_time(this, (200));
    `else
      phase.phase_done.set_drain_time(this, (200));
    `endif
    `uvm_info("main_phase", "Exited ...",UVM_LOW)
  endtask : main_phase

   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     //svt_i2c_master_callback_pool::add(env.i2c_system_env.master[0].driver,cust_callback);
     disable_error();
     //env.sb.enable = 0;
   endfunction: connect_phase

   function void disable_error();
    env.i2c_system_env.master[0].monitor.err_check.i2c_ack_received_for_invalid_slave_id.set_default_fail_effect(svt_err_check_stats::NOTE);
    env.i2c_system_env.master[0].monitor.err_check.i2c_invalid_reserved_slave_id.set_default_fail_effect(svt_err_check_stats::NOTE);
    env.i2c_system_env.slave[0].monitor.err_check.i2c_ack_received_for_invalid_slave_id.set_default_fail_effect(svt_err_check_stats::NOTE);
    env.i2c_system_env.slave[0].monitor.err_check.i2c_invalid_reserved_slave_id.set_default_fail_effect(svt_err_check_stats::NOTE);
  endfunction: disable_error

endclass
