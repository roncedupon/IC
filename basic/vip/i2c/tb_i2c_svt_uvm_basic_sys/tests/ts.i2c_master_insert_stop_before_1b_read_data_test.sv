/**
 * Abstract:
 * This test is used to provide the usecase of EI "I2C_INSERT_P_BEFORE_1_BIT_RD_DATA".
 * The EI is used to forcefully insert stop right before the very 1st bit of slave data for read (right after ACK received for slave address).
 * The callback "i2c_master_insert_stop_before_1bit_of_read_data_byte_callback" is used to send EI.
 * NOTE:
 * There is a limitation for using this EI:
 * Since this EI intercepts Master changing SDA line and Slave to drive SDA line for data, slave should always drive 1st bit as "1" so that
 * Stop can be seen on bus and devices can recover from erroneous conditions.
 */

`include "i2c_base_test.sv"
`include "i2c_mst_directed_read_seq.sv"
`include "i2c_slv_directed_sequence.sv"
`include "i2c_null_virtual_sequence.sv"
`include "i2c_master_insert_stop_before_1bit_of_read_data_byte_callback.sv"

class i2c_master_insert_stop_before_1b_read_data_test extends i2c_base_test;

  /** UVM component utility macro */
  `uvm_component_utils(i2c_master_insert_stop_before_1b_read_data_test)

  i2c_master_insert_stop_before_1bit_of_read_data_byte_callback cust_callback;

  /** Class constructor */
  function new(string name = "i2c_master_insert_stop_before_1b_read_data_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  /** build() - Method to build various component */
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered ...", UVM_LOW)

    super.build_phase(phase);

    cust_callback = new("cust_callback");
 
   /** Disable the virtual default sequence on the the virtual sequencer started in the i2c_base_test */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.i2c_system_env.sequencer.main_phase", "default_sequence", i2c_null_virtual_sequence::type_id::get());

    /** Apply the master directed i2c sequence to the i2c master sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.i2c_system_env.master[0].sequencer.main_phase", "default_sequence", i2c_mst_directed_read_seq::type_id::get());
 
    /** Apply the slave directed i2c sequence to the i2c slave sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.i2c_system_env.slave[0].sequencer.main_phase", "default_sequence", i2c_slv_directed_sequence::type_id::get());
  
    `uvm_info("build_phase", "Exited ...", UVM_LOW)
  endfunction : build_phase

   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     svt_i2c_master_callback_pool::add(env.i2c_system_env.master[0].driver,cust_callback);
   endfunction: connect_phase

   /** This is the main_phase */ 
  task main_phase(uvm_phase phase);
    `ifdef SVT_UVM_1800_2_2017_OR_HIGHER
     uvm_objection phase_d;
    `endif
    disable_error();
    `uvm_info("main_phase",$sformatf("Setting the drain time in the main_phase"),UVM_NONE) 
    `ifdef SVT_UVM_1800_2_2017_OR_HIGHER
      phase_d = phase.get_objection();
      phase_d.set_drain_time(this, (5));
    `else
      phase.phase_done.set_drain_time(this, (5));
    `endif
  endtask: main_phase

  /**
   * disabling error by making UVM_ERROR to UVM_INFO
   */
  task disable_error();
    env.i2c_system_env.master[0].monitor.err_check.i2c_rd_inval_stop_after_ack.set_default_fail_effect(svt_err_check_stats::NOTE);
    env.i2c_system_env.slave[0].monitor.err_check.i2c_rd_inval_stop_after_ack.set_default_fail_effect(svt_err_check_stats::NOTE);
  endtask: disable_error

endclass

//------------------------------------------------------------------------
//-----------------------END OF FILE--------------------------------------
//------------------------------------------------------------------------
