
/**
 * Abstract:
 * class ahb_master_random_discrete_virtual_sequence defines a virtual sequence
 * which is used as the default sequence for this environment.  The sequence
 * executes a ahb_master_random_discrete_master_sequence on every master in the
 * environment.
 *
 * Execution phase: main_phase
 * Sequencer: Virtual sequencer in AHB System ENV
*/

`ifndef GUARD_AHB_MASTER_RANDOM_DISCRETE_VIRTUAL_SEQUENCE_SV
`define GUARD_AHB_MASTER_RANDOM_DISCRETE_VIRTUAL_SEQUENCE_SV

`include "ahb_master_random_discrete_sequence.sv"

class ahb_master_random_discrete_virtual_sequence extends svt_ahb_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

  /** UVM Object Utility macro */
  `uvm_object_utils(ahb_master_random_discrete_virtual_sequence)

  /** Class Constructor */
  function new (string name = "ahb_master_random_discrete_virtual_sequence");
    super.new(name);
    /** 
     * Setting this attribute to 1'b1 causes the base sequence to manage the 
     * raising and dropping of the objections. 
     * So any extended sequences including this sequence need not implement 
     * the pre_body() and post_body() virtual methods to mange the objections.
     */
    manage_objection = 1'b1;
  endfunction : new

  virtual task body();
    bit status;
    int counter = 0;
    int local_sequence_length;
    ahb_master_random_discrete_sequence master_seq[];

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
          master_seq[j] = new($sformatf("master_seq[%0d]", j));
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

endclass: ahb_master_random_discrete_virtual_sequence 

`endif // GUARD_AHB_VIRTUAL_MASTER_RANDOM_DISCRETE_SEQUENCE_UVM_SV

