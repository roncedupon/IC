/**
 * Abstract:
 * THIS TEST IS USED TO CHECK COVERAGE FOR CBUS ADDRESS DETECTION AND 10 BIT ADDRESSING 2ND BYTE ADDRESS ACK 
 */

`include "i2c_base_test.sv"
`include "i2c_mst_directed_read_cov_seq.sv"
`include "i2c_slv_directed_sequence.sv"
`include "i2c_null_virtual_sequence.sv"

class i2c_cbus_10bit_addressing_coverage_test extends i2c_base_test;

  /** UVM component utility macro */
  `uvm_component_utils(i2c_cbus_10bit_addressing_coverage_test)


  /** Class constructor */
  function new(string name = "i2c_cbus_10bit_addressing_coverage_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  /** build() - Method to build various component */
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered ...", UVM_LOW)

    super.build_phase(phase);

    cfg.slave_cfg[0].slave_address = 7'b000_0001;
    cfg.slave_cfg[0].enable_10bit_addr  =  1;  // disable 10-bit Addressing

 
   /** Disable the virtual default sequence on the the virtual sequencer started in the i2c_base_test */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.i2c_system_env.sequencer.main_phase", "default_sequence", i2c_null_virtual_sequence::type_id::get());

    /** Apply the master directed i2c sequence to the i2c master sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.i2c_system_env.master[0].sequencer.main_phase", "default_sequence", i2c_mst_directed_read_cov_seq::type_id::get());
 
    /** Apply the slave directed i2c sequence to the i2c slave sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.i2c_system_env.slave[0].sequencer.main_phase", "default_sequence", i2c_slv_directed_sequence::type_id::get());
  
    `uvm_info("build_phase", "Exited ...", UVM_LOW)
  endfunction : build_phase

   function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
   endfunction: connect_phase

endclass

//------------------------------------------------------------------------
//-----------------------END OF FILE--------------------------------------
//------------------------------------------------------------------------


