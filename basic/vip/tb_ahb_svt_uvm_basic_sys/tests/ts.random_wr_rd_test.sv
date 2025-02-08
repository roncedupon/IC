
`include "ahb_base_test.sv"
`include "ahb_null_virtual_sequence.sv"
`include "ahb_master_wr_rd_sequence.sv"
`include "ahb_slave_random_response_sequence.sv"

/**
 * Abstract:
 * This file creates test 'random_wr_rd_test', which is extended from the
 * base test class.
 *
 * In the build_phase phase of the test we will set the necessary test related 
 * information:
 *  - Disable the virtual sequence by assigning the null sequence
 *  - Configure the ahb_master_wr_rd_sequence as the default sequence for
 *    the main phase of the Master Sequencer
 *  - Configure the Master Sequence length to 50
 *  - Configure ahb_slave_random_response_sequence as the default sequence
 *    for the run phase of the Slave Sequencer
 *  .
 */
class random_wr_rd_test extends ahb_base_test;

  /** UVM Component Utility macro */
  `uvm_component_utils (random_wr_rd_test)

  /** Class Constructor */
  function new (string name="random_wr_rd_test", uvm_component parent=null);
    super.new (name, parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    `uvm_info ("build_phase", "Entered...", UVM_LOW)

    super.build_phase(phase);

    /** Apply the null sequence to the System ENV virtual sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.ahb_system_env.sequencer.main_phase", "default_sequence", ahb_null_virtual_sequence::type_id::get());

    /** Apply the master sequence to the master sequencers */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.ahb_system_env.master*.sequencer.main_phase", "default_sequence", ahb_master_wr_rd_sequence::type_id::get());

    /** Set the sequence 'length' to generate 50 transactions with random constraints */
    uvm_config_db#(int unsigned)::set(this, "env.ahb_system_env.master*.sequencer.ahb_master_wr_rd_sequence", "sequence_length", 50);

    /** Apply the Slave random response sequence to Slave sequencer
     *
     * This sequence is configured for the run phase since the slave should always
     * respond to recognized requests.
     */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.ahb_system_env.slave*.sequencer.run_phase", "default_sequence", ahb_slave_random_response_sequence::type_id::get());

    `uvm_info ("build_phase", "Exiting...",UVM_LOW)
  endfunction : build_phase

endclass
