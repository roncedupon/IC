
/**
 * Abstract:
 * The file contains the class extended from i2c_base_test.
 * It disables the base test case virtual sequence on the virtual sequencer.
 * This test case showcases how to corrupt first address frame for 10 bit read.
 * Using this error injection read packet sent after START can be corrupted.
 * This EI will not work when 10 bit READ is attempted after Sr. This is beacause:
 *     a. It is not compulsory to send the Master code pad with WRITE bit for READS after Sr.
 *     b. If VIP master is configured to send the Master CODE + WRITE after SR and this EI is used, slave will still ACK the frame
          as it was not aware whether master is sending the first frame or not. THis might hang the test case.
 */

`include "corrupt_10b_rd_sequence.sv"
`include "i2c_null_virtual_sequence.sv"
`include "i2c_master_corrupt_10bit_read_callback.sv"

class corrupt_10b_rd_test extends i2c_base_test;

  /** UVM component utility macro */
  `uvm_component_utils(corrupt_10b_rd_test)
  i2c_master_corrupt_10bit_read_callback cust_callback;
  /** Class constructor */
  function new(string name = "corrupt_10b_rd_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  /** build() - Method to build various component */
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build phase", "Entered ...", UVM_LOW)

    super.build_phase(phase);
    cust_callback = new("cust_callback");
    cfg.slave_cfg[0].enable_10bit_addr =  1;
    cfg.slave_cfg[0].slave_address=  'h006;
    cfg.master_cfg[0].checks_coverage_enable = 1;
    cfg.slave_cfg[0].checks_coverage_enable = 1;

    /** Disable the virtual default sequence on the the virtual sequencer started in the i2c_base_test */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.i2c_system_env.sequencer.main_phase", "default_sequence", i2c_null_virtual_sequence::type_id::get());

    /** Apply the master eeprom sequence to the i2c master sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.i2c_system_env.master[0].sequencer.main_phase", "default_sequence", corrupt_10b_rd_sequence::type_id::get());

   
    `uvm_info("build phase", "Exited ...", UVM_LOW)
  endfunction : build_phase


   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     svt_i2c_master_callback_pool::add(env.i2c_system_env.master[0].driver,cust_callback);
     env.sb.enable = 0; //Disabling score board because sb will give pre-post mismatch error when using this EI.
     disable_error(); 
   endfunction: connect_phase

  function void disable_error();
    env.i2c_system_env.master[0].monitor.err_check.i2c_10b_slv_addr_fst_rd_cmd.set_default_fail_effect(svt_err_check_stats::NOTE);
    env.i2c_system_env.slave[0].monitor.err_check.i2c_10b_slv_addr_fst_rd_cmd.set_default_fail_effect(svt_err_check_stats::NOTE);
  endfunction: disable_error

endclass
