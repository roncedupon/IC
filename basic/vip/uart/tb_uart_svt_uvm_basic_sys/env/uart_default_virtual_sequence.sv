
`ifndef GUARD_UART_DEFAULT_VIRTUAL_SEQUENCE_SV
`define GUARD_UART_DEFAULT_VIRTUAL_SEQUENCE_SV

/**
 * Abstract:
 * The file contains the class extended from uvm_sequence. It is a virtual sequence 
 * that encapsulates the default sequence and ties it to the virtual sequencer. It also,
 * determines the sequence length of the underlying sequence. It is started in the base 
 * test case on the virtual sequencer.
 * 
 * Execution phase: main_phase
 * Sequencer: ENV virtual sequencer
 */

class uart_default_virtual_sequence extends uvm_sequence;

  /** Sequence Length in Virtual Sequence, to set to the actual default sequence */
  int unsigned sequence_length = 10;

  /** UVM object utility macro */
  `uvm_object_utils(uart_default_virtual_sequence)

  /** This macro is used to declare a variable p_sequencer whose type is uart_virtual_sequencer */
  `uvm_declare_p_sequencer(uart_virtual_sequencer)

  /** Class constructor */
  function new (string name = "uart_default_virtual_sequence");
    super.new(name);
  endfunction : new

  /** Raise an objection if this is the parent sequence */
  virtual task pre_body();
    uvm_phase phase;
    super.pre_body();
`ifdef SVT_UVM_12_OR_HIGHER
    phase = get_starting_phase();
`else
    phase = starting_phase;
`endif
    if (phase!=null) begin
      phase.raise_objection(this);
    end
  endtask: pre_body
  
  /** Drop an objection if this is the parent sequence */
  virtual task post_body();
    uvm_phase phase;
    super.post_body();
`ifdef SVT_UVM_12_OR_HIGHER
    phase = get_starting_phase();
`else
    phase = starting_phase;
`endif
    if (phase!=null) begin
      phase.drop_objection(this);
    end
  endtask: post_body
  
  virtual task body();
    bit status;
    int local_sequence_length;

    /** Instance of default sequence, to be started on the virtual sequencer. */
    uart_default_sequence seq;

    `uvm_info("body", "Entered ...", UVM_DEBUG)

    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    `uvm_info("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"), UVM_LOW);

    /**
     * Since the contained sequence and this one have the same property name, the
     * inline constraint was not able to resolve to the correct scope.  Therefore the
     * sequence length of the virtual sequencer is assigned to a local property which
     * is used in the constraint.
     */
    local_sequence_length = sequence_length;
`ifdef SVT_UVM_1800_2_2017_OR_HIGHER
    `uvm_do(seq, p_sequencer.dte_sequencer, -1, {seq.sequence_length == local_sequence_length;})
    `uvm_do(seq, p_sequencer.dce_sequencer, -1, {seq.sequence_length == local_sequence_length;})
`else
    `uvm_do_on_with(seq, p_sequencer.dte_sequencer, {seq.sequence_length == local_sequence_length;})
    `uvm_do_on_with(seq, p_sequencer.dce_sequencer, {seq.sequence_length == local_sequence_length;})

`endif 
    `uvm_info("body", "Exiting ...", UVM_DEBUG)
  endtask : body

endclass : uart_default_virtual_sequence 

`endif // GUARD_UART_DEFAULT_VIRTUAL_SEQUENCE_SV

