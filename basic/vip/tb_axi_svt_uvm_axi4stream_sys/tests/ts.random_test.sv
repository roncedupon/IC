//=======================================================================
// COPYRIGHT (C) 2010, 2011, 2012, 2013 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//-----------------------------------------------------------------------

`include "axi_base_test.sv"
`include "axi_null_virtual_sequence.sv"
`include "axi_master_random_sequence.sv"
/**
 * Abstract:
 * This file creates test 'random_test', which is extended from the
 * base test class.
 *
 * In the build_phase phase of the test we will set the necessary test related 
 * information:
 *  - Disable the virtual sequence by assigning the null sequence
 *  - Configure the axi_master_random_sequence as the default sequence for
 *    the main phase of the Master Sequencer
 *  - Configure the Master Sequence length to 50
 *  - Configure axi_slave_random_response_sequence as the default sequence
 *    for the run phase of the Slave Sequencer
 *  .
 */
class random_test extends axi_base_test;

  /** UVM Component Utility macro */
  `uvm_component_utils (random_test)

  /** Class Constructor */
  function new (string name="random_test", uvm_component parent=null);
    super.new (name, parent);
  endfunction : new

  virtual function void build_phase(uvm_phase phase);
    `uvm_info ("build_phase", "Entered...", UVM_LOW)

    super.build_phase(phase);

    /** Apply the null sequence to the System ENV virtual sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.axi_system_env.sequencer.main_phase", "default_sequence", axi_null_virtual_sequence::type_id::get());

    /** Apply the master sequence to the master sequencers */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.axi_system_env.master*.sequencer.main_phase", "default_sequence", axi_master_random_sequence::type_id::get());

    /** Set the sequence 'length' to generate 50 transactions with random constraints */
    uvm_config_db#(int unsigned)::set(this, "env.axi_system_env.master*.sequencer.axi_master_random_sequence", "sequence_length", 50);

    /** Apply the slave response sequence to the slave sequencers */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.axi_system_env.slave*.sequencer.run_phase", "default_sequence", axi_slave_mem_response_sequence::type_id::get());

    `uvm_info ("build_phase", "Exiting...",UVM_LOW)
  endfunction : build_phase

endclass
