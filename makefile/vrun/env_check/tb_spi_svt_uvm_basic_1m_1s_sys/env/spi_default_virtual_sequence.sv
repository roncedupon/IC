
`ifndef GUARD_SPI_DEFAULT_VIRTUAL_SEQUENCE_SV
`define GUARD_SPI_DEFAULT_VIRTUAL_SEQUENCE_SV

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

class spi_default_virtual_sequence extends uvm_sequence #(uvm_sequence_item,uvm_sequence_item);

  /** Sequence Length in Virtual Sequence, to set to the actual default sequence */
  int unsigned sequence_length = 1;

  /** UVM object utility macro */
  `uvm_object_utils(spi_default_virtual_sequence)

  /** This macro is used to declare a variable p_sequencer whose type is spi_virtual_sequencer */
  `uvm_declare_p_sequencer(spi_virtual_sequencer)

  /** Class constructor */
  function new (string name = "spi_default_virtual_sequence");
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

    /** Instance of default sequence, to be started on the virtual sequencer. */
    spi_default_sequence seq;

    `uvm_info("body", "Entered ...", UVM_DEBUG)

    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    `uvm_info("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"), UVM_LOW);

    fork
      begin
        `uvm_do_on_with(seq, p_sequencer.master_sequencer, {sequence_length == local::sequence_length;})
      end
      begin
        `uvm_do_on_with(seq, p_sequencer.slave_sequencer, {sequence_length == local::sequence_length;})
      end
    join

    `uvm_info("body", "Exiting ...", UVM_DEBUG)
  endtask : body

endclass : spi_default_virtual_sequence 

`endif // GUARD_SPI_DEFAULT_VIRTUAL_SEQUENCE_SV

