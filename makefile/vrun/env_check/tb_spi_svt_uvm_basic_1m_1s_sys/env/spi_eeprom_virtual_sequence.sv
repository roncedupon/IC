
`ifndef GUARD_SPI_EEPROM_VIRTUAL_SEQUENCE_SV
`define GUARD_SPI_EEPROM_VIRTUAL_SEQUENCE_SV

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

class spi_eeprom_virtual_sequence extends uvm_sequence #(uvm_sequence_item,uvm_sequence_item);

  /** Sequence Length in Virtual Sequence, to set to the actual default sequence */
  int unsigned sequence_length = 1;

  /**
   * Specifies Memory core buffer is enabled.
   */ 
  bit enable_mem_core = 1'b0;

  /** UVM object utility macro */
  `uvm_object_utils(spi_eeprom_virtual_sequence)

  /** This macro is used to declare a variable p_sequencer whose type is spi_virtual_sequencer */
  `uvm_declare_p_sequencer(spi_virtual_sequencer)

  /** Class constructor */
  function new (string name = "spi_eeprom_virtual_sequence");
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
    int unsigned instruction_frame_size = 8;
    int unsigned address_frame_size = 24;
    int unsigned data_frame_size = 8;
    bit success;

    /** Instance of default sequence, to be started on the virtual sequencer. */
    spi_eeprom_sequence seq;

    `uvm_info("body", "Entered ...", UVM_DEBUG)

    void' ($value$plusargs("enable_mem_core=%d", enable_mem_core));

    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    `uvm_info("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"), UVM_LOW);

    for (int index = 0; index < sequence_length;index++) begin
      success = std::randomize(instruction_frame_size,data_frame_size) with {
                               instruction_frame_size inside {[0:`SVT_SPI_MAX_INST_FRAME_WIDTH]};
                               data_frame_size inside {[1:`SVT_SPI_MAX_DATA_TRANSFER]};
                              };

      if (p_sequencer.cfg.enable_mem_core) begin
        success = std::randomize(address_frame_size) with {
                                 address_frame_size == p_sequencer.cfg.spi_mem_cfg.addr_width-1;
                                };
      end
      else begin
        success = std::randomize(address_frame_size) with {
                                 address_frame_size inside {[0:`SVT_SPI_MAX_ADDR_FRAME_WIDTH]};
                                };
      end 

      fork
      begin
      `uvm_do_on_with(seq, p_sequencer.master_sequencer, {sequence_length       == local::sequence_length;
                                                          instruction_frame_size== local::instruction_frame_size;
                                                          address_frame_size    == local::address_frame_size;
                                                          data_frame_size       == local::data_frame_size;})
      end
      begin
      `uvm_do_on_with(seq, p_sequencer.slave_sequencer, {sequence_length       == local::sequence_length;
                                                         instruction_frame_size== local::instruction_frame_size;
                                                         address_frame_size    == local::address_frame_size;
                                                         data_frame_size       == local::data_frame_size;})
      end
      join
    end

    `uvm_info("body", "Exiting ...", UVM_DEBUG)
  endtask : body

endclass : spi_eeprom_virtual_sequence 

`endif // GUARD_SPI_EEPROM_VIRTUAL_SEQUENCE_SV

