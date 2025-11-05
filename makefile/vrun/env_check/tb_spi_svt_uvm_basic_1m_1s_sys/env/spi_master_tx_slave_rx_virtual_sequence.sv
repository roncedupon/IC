
`ifndef GUARD_SPI_MASTER_TX_SLAVE_RX_VIRTUAL_SEQUENCE_SV
`define GUARD_SPI_MASTER_TX_SLAVE_RX_VIRTUAL_SEQUENCE_SV

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

class spi_master_tx_slave_rx_virtual_sequence extends uvm_sequence #(uvm_sequence_item,uvm_sequence_item);

  /** Sequence Length in Virtual Sequence, to set to the actual default sequence */
  int unsigned sequence_length = 1;

  /** UVM object utility macro */
  `uvm_object_utils(spi_master_tx_slave_rx_virtual_sequence)

  /** This macro is used to declare a variable p_sequencer whose type is spi_virtual_sequencer */
  `uvm_declare_p_sequencer(spi_virtual_sequencer)

  /** Class constructor */
  function new (string name = "spi_master_tx_slave_rx_virtual_sequence");
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
    spi_txonly_sequence mstr_seq;
    spi_rxonly_sequence slave_seq;

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

    fork
    begin
    `uvm_do_on_with(mstr_seq, p_sequencer.master_sequencer, {mstr_seq.sequence_length == local_sequence_length;})
    end
    begin
    `uvm_do_on_with(slave_seq, p_sequencer.slave_sequencer, {slave_seq.sequence_length == local_sequence_length;})
    end
    join

    `uvm_info("body", "Exiting ...", UVM_DEBUG)
  endtask : body

endclass : spi_master_tx_slave_rx_virtual_sequence 

`endif //GUARD_SPI_MASTER_TX_SLAVE_RX_VIRTUAL_SEQUENCE_SV 

