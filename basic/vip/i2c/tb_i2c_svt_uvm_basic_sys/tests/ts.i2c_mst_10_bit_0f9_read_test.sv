
/**
 * Abstract:
 * The file contains the class extended from i2c_base_test.
 * It disables the base test case virtual sequence on the virtual sequencer.
 * This test case showcases how to send user configurable data from slave.
 */

`include "i2c_base_test.sv"
`include "i2c_mst_10b_0f9_rd_addr_seq.sv"
`include "i2c_slave_user_conf_sequence.sv"
`include "i2c_null_virtual_sequence.sv"

class i2c_mst_10_bit_0f9_read_test extends i2c_base_test;

  /** UVM component utility macro */
  `uvm_component_utils(i2c_mst_10_bit_0f9_read_test)

  /** Class constructor */
  function new(string name = "i2c_mst_10_bit_0f9_read_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  /** build() - Method to build various component */
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build phase", "Entered ...", UVM_LOW)

    super.build_phase(phase);

    cfg.slave_cfg[0].enable_10bit_addr =  1;                       // disable 10-bit Addressing
    cfg.slave_cfg[0].slave_address =  'h0f9;                       // disable 10-bit Addressing

    /** Disable the virtual default sequence on the the virtual sequencer started in the i2c_base_test */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.i2c_system_env.sequencer.main_phase", "default_sequence", i2c_null_virtual_sequence::type_id::get());

    /** Apply the master eeprom sequence to the i2c master sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.i2c_system_env.master[0].sequencer.main_phase", "default_sequence", i2c_mst_10b_0f9_rd_addr_seq::type_id::get());

    /** Apply the random slave sequence to the i2c slave sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.i2c_system_env.slave[0].sequencer.main_phase", "default_sequence", i2c_slave_user_conf_sequence::type_id::get());
   
    `uvm_info("build phase", "Exited ...", UVM_LOW)
  endfunction : build_phase

endclass
