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
//=======================================================================

/**
 * Abstract:
 * class axi_null_virtual_sequence defines a virtual sequence axi_null_virtual_sequence.
 * axi_null_virtual_sequence is a no-operation sequence since the body() method
 * has empty implementation.
 *
 * axi_null_virtual_sequence is used by directed_test and random_wr_rd_test.
 * These tests load this null sequence into the virtual sequencer in testbench
 * ENV, as these tests use the sequencer in the master agent.
 *
 * Execution phase: main_phase 
 * Sequencer: Can be used with any sequencer in
 * which default sequence needs to be overridden with a null sequence. In this
 * example, this sequence has been used with virtual sequencer in the testbench
 * environment.
 */

`ifndef GUARD_AXI_NULL_VIRTUAL_SEQUENCE_SV
`define GUARD_AXI_NULL_VIRTUAL_SEQUENCE_SV

class axi_null_virtual_sequence extends uvm_sequence;

  /** UVM Object Utility macro */
  `uvm_object_utils(axi_null_virtual_sequence)

  /** Class Constructor */
  function new (string name = "axi_null_virtual_sequence");
     super.new(name);
  endfunction : new

  /** Need an empty body function to override the warning from the UVM base class */
  virtual task body();
  endtask

endclass : axi_null_virtual_sequence 

`endif // GUARD_AXI_NULL_VIRTUAL_SEQUENCE_UVM_SV

