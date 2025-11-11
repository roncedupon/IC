
/**
 * Abstract:
 * The file contains the class extended from i2c_base_test
 * A simple directed test showcases the use of the directed sequence.
 * It disables the base test case virtual sequence on the virtual sequencer.
 * Aftet that a directed sequence is set on the agent's sequencers.
 */

`include "i2c_base_test.sv"
`include "i2c_mst_retry_if_nack_sequence.sv"
`include "i2c_slv_nack_data_sequence.sv"
`include "i2c_null_virtual_sequence.sv"

class directed_test_for_nack_for_data_test extends i2c_base_test;

  /** UVM component utility macro */
  `uvm_component_utils(directed_test_for_nack_for_data_test)

  /** Class constructor */
  function new(string name = "directed_test_for_nack_for_data_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  /** build() - Method to build various component */
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered ...", UVM_LOW)

    super.build_phase(phase);
 
   /** Disable the virtual default sequence on the the virtual sequencer started in the i2c_base_test */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.i2c_system_env.sequencer.main_phase", "default_sequence", i2c_null_virtual_sequence::type_id::get());

    /** Apply the master directed i2c sequence to the i2c master sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.i2c_system_env.master[0].sequencer.main_phase", "default_sequence", i2c_mst_retry_if_nack_sequence::type_id::get());
 
    /** Apply the slave directed i2c sequence to the i2c slave sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.i2c_system_env.slave[0].sequencer.main_phase", "default_sequence", i2c_slv_nack_data_sequence::type_id::get());
  
    `uvm_info("build_phase", "Exited ...", UVM_LOW)
  endfunction : build_phase

  /** This is the main_phase */ 
  task main_phase(uvm_phase phase);
    `ifdef SVT_UVM_1800_2_2017_OR_HIGHER
     uvm_objection phase_d;
    `endif
    `uvm_info("main_phase", "Entered ...",UVM_LOW)
    `uvm_info("main_phase", $sformatf("Setting the drain time in the main_phase "), UVM_NONE) 
      `ifdef SVT_UVM_1800_2_2017_OR_HIGHER
      phase_d = phase.get_objection();
      phase_d.set_drain_time(this, (5));
    `else
      phase.phase_done.set_drain_time(this, (5));
    `endif
    `uvm_info("main_phase", "Exited ...",UVM_LOW)
  endtask

endclass
