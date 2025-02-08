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
 * class axi_master_random_discrete_virtual_sequence defines a virtual sequence
 * which is used as the default sequence for this environment.  The sequence
 * executes a axi_master_random_discrete_master_sequence on every master in the
 * environment.
 *
 * Execution phase: main_phase
 * Sequencer: Virtual sequencer in AXI System ENV
*/

`ifndef GUARD_AXI_MASTER_RANDOM_DISCRETE_VIRTUAL_SEQUENCE_SV
`define GUARD_AXI_MASTER_RANDOM_DISCRETE_VIRTUAL_SEQUENCE_SV

`include "axi_master_random_discrete_sequence.sv"

class axi_master_random_discrete_virtual_sequence extends svt_axi_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

  /** UVM Object Utility macro */
  `uvm_object_utils(axi_master_random_discrete_virtual_sequence)
  
  /** Class Constructor */
  function new (string name = "axi_master_random_discrete_virtual_sequence");
    super.new(name);
  endfunction : new
  /** Raise an objection if this is the parent sequence */
  virtual task pre_body();
    uvm_phase starting_phase_for_curr_seq ;
    super.pre_body();
`ifdef SVT_UVM_12_OR_HIGHER
    starting_phase_for_curr_seq = get_starting_phase();
`else
    starting_phase_for_curr_seq = starting_phase;
`endif
  if (starting_phase_for_curr_seq!=null) begin
    starting_phase_for_curr_seq.raise_objection(this);
  end
  endtask: pre_body

  /** Drop an objection if this is the parent sequence */
  virtual task post_body();
    uvm_phase starting_phase_for_curr_seq;
    super.post_body();
`ifdef SVT_UVM_12_OR_HIGHER
    starting_phase_for_curr_seq = get_starting_phase();
`else
    starting_phase_for_curr_seq = starting_phase;
`endif
  if (starting_phase_for_curr_seq!=null) begin
    starting_phase_for_curr_seq.drop_objection(this);
  end
  endtask: post_body
  
  virtual task body();
    bit status;
    int counter = 0;
    int local_sequence_length;
    axi_master_random_discrete_sequence master_seq[];

    `uvm_info("body", "Entered...", UVM_LOW)

    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    `uvm_info("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"), UVM_LOW);

    /**
     * Since the contained sequence and this one have the same property name, the
     * inline constraint was not able to resolve to the correct scope.  Therefore the
     * sequence length of the virtual sequencer is assigned to a local property which
     * is used in the constraint.
     */
    local_sequence_length = sequence_length;

    /** Run the sequence on each master in parallel */
    master_seq = new[p_sequencer.master_sequencer.size()];
    foreach(p_sequencer.master_sequencer[i]) begin
      fork
        automatic int j = i;
        begin
          `uvm_do_on_with(master_seq[j], p_sequencer.master_sequencer[j], {sequence_length == local_sequence_length;})
          counter++;
        end
      join_none
    end

    /**
     * This counter will wait until every `uvm_do_on_with statement called in the
     * loop above returns.
     */
    while (counter != p_sequencer.master_sequencer.size()) begin
      wait(counter);
    end

    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask: body

endclass: axi_master_random_discrete_virtual_sequence 

`endif // GUARD_AXI_VIRTUAL_MASTER_RANDOM_DISCRETE_SEQUENCE_UVM_SV

