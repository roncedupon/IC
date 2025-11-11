`include "i2c_base_test.sv"
`include "eeprom_2_bit_paging_wr_rd_sequence.sv"

/**
 * Abstract:
 * The file contains the class extended from i2c_base_test
 * eeprom_test showcases the use of the eeprom sequences.
 * It disables the base test case virtual sequence on the virtual sequencer.
 * After that an eeprom sequence is set on the agent's sequencers.
 */

class eeprom_2_bit_paging_wr_rd_test extends i2c_base_test;

  /** OVM component utility macro */
  `uvm_component_utils(eeprom_2_bit_paging_wr_rd_test)
  bit page;
  /** Class constructor */
  function new(string name = "eeprom_2_bit_paging_wr_rd_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction: new
  
  
/** build() - Method to build various component */
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    cfg.slave_cfg[0].eeprom_paging = 2'b10;
    
    cfg.slave_cfg[0].slave_type = `SVT_I2C_EEPROM;
    cfg.slave_cfg[0].slave_address = 10'b000_1010_000; // slave 0 page 00
    cfg.master_cfg[0].enable_put_response = 1;
    `uvm_info("build_phase","Entered ...",UVM_LOW)

    /** Set Master configuration in environment */
    //uvm_config_db#(cust_svt_i2c_system_configuration)::set(this,"env", "i2c_system_cfg_1", cfg);


    /** Set the sequence 'length' to generate 2 transactions with random constraints    */
    uvm_config_db#(int unsigned)::set(this, "env.i2c_system_env.master[0].sequencer.eeprom_2_bit_paging_wr_rd_sequence", "sequence_length", 1);

    /** Disable the virtual default sequence on the the virtual sequencer started in the i2c_base_test */
   uvm_config_db#(uvm_object_wrapper)::set(this, "env.i2c_system_env.sequencer.main_phase", "default_sequence", i2c_null_virtual_sequence::type_id::get());

    /** Apply the master eeprom sequence to the i2c master sequencer */
   uvm_config_db#(uvm_object_wrapper)::set(this, "env.i2c_system_env.master[0].sequencer.main_phase", "default_sequence", eeprom_2_bit_paging_wr_rd_sequence::type_id::get());



  
    `uvm_info("build_phase","Exited ...",UVM_LOW)
  endfunction: build_phase
  
endclass: eeprom_2_bit_paging_wr_rd_test
