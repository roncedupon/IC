`ifndef GUARD_SPI_RANDOM_TIMING_VIRTUAL_SEQUENCE_SV
`define GUARD_SPI_RANDOM_TIMING_VIRTUAL_SEQUENCE_SV

/**
 * Abstract:
 * The file contains the class extended from uvm_sequence. It is a virtual sequence 
 * that encapsulates the random timing sequence and ties it to the virtual sequencer. It also,
 * determines the sequence length and timer values of the underlying sequence. It is started in the base 
 * test case on the virtual sequencer.
 * 
 * Execution phase: main_phase
 * Sequencer: ENV virtual sequencer
 */
class spi_random_timing_virtual_sequence extends uvm_sequence #(uvm_sequence_item,uvm_sequence_item);

  /** Sequence Length in Virtual Sequence, to set to the actual default sequence */
  int unsigned sequence_length = 1;
  
  /** It specifies the leading. */
  int timer_leading = 1;

  /** It specifies Minimum leading time  */
  int min_timer_leading = 1;

  /** It specifies Maximum leading time  */
  int max_timer_leading = `SVT_SPI_MAX_LEADING_TIME;

  /** It specifies Minimum trailing time after the last clock edge. It is in multiple of half interface signal */
  int timer_trailing = 1; 

  /** It specifies Minimum trailing time  */
  int min_timer_trailing = 1;

  /** It specifies Maximum trailing time  */
  int max_timer_trailing = `SVT_SPI_MAX_TRAILING_TIME;

  /** Minimum Idle between Two commands to satisfy tCS_ns timing constraint */
  int timer_idling_between_transfers = `SVT_SPI_MAX_IDLE_TIME_BETWEEN_TRANSFER ;

  /**
   * Minimum Idle between Two command. This can be overriden from tests,
   * depending on the test scenario. Default is maximum idle timer to satisfy tCS_ns timing constraint.
   */
  int min_timer_idling_between_transfers = `SVT_SPI_MAX_IDLE_TIME_BETWEEN_TRANSFER;

  /** Maximum Idle between Two command. This can be overriden from tests, depending on the test scenario. */
  int max_timer_idling_between_transfers = `SVT_SPI_MAX_IDLE_TIME_BETWEEN_TRANSFER;

  /** Number of clock delay before Master initiates transaction */
  int transmit_delay = `SVT_SPI_MAX_TRANSMIT_DELAY;

  /** Minimum number of clock delay before Master initiates transaction. */
  int min_transmit_delay = 0;

  /** Maximum number of clock delay before Master initiates transaction. */
  int max_transmit_delay = `SVT_SPI_MAX_TRANSMIT_DELAY;

  /** UVM object utility macro */
  `uvm_object_utils(spi_random_timing_virtual_sequence)

  /** This macro is used to declare a variable p_sequencer whose type is spi_virtual_sequencer */
  `uvm_declare_p_sequencer(spi_virtual_sequencer)

  /** Class constructor */
  function new (string name = "spi_random_timing_virtual_sequence");
    super.new(name);
  endfunction : new

  /** Raise an objection if this is the parent sequence */
  virtual task pre_body();
    uvm_phase phase;
    int success;
    super.pre_body();
`ifdef SVT_UVM_12_OR_HIGHER
    phase = get_starting_phase();
`else
    phase = starting_phase;
`endif
    if (phase!=null) begin
      phase.raise_objection(this);
    end

    /** To get the min_timer_idling_between_transfers overriden value from the test. If no value passed from test, default value will be picked. */
    void'(uvm_config_db#(int)::get(null, get_full_name(), "min_timer_idling_between_transfers", min_timer_idling_between_transfers));
    
    /** To get the max_timer_idling_between_transfers overriden value from the test. If no value passed from test, default value will be picked. */
    void'(uvm_config_db#(int)::get(null, get_full_name(), "max_timer_idling_between_transfers", max_timer_idling_between_transfers));

    /** To get the min_transmit_delay overriden value from the test. If no value passed from test, default value will be picked. */
    void'(uvm_config_db#(int)::get(null, get_full_name(), "min_transmit_delay", min_transmit_delay));
    
    /** To get the max_transmit_delay overriden value from the test. If no value passed from test, default value will be picked. */
    void'(uvm_config_db#(int)::get(null, get_full_name(), "max_transmit_delay", max_transmit_delay));

    /** To get the min_timer_leading overriden value from the test. If no value passed from test, default value will be picked. */
    void'(uvm_config_db#(int)::get(null, get_full_name(), "min_timer_leading", min_timer_leading));

    /** To get the max_timer_leading overriden value from the test. If no value passed from test, default value will be picked. */
    void'(uvm_config_db#(int)::get(null, get_full_name(), "max_timer_leading", max_timer_leading));

    /** To get the min_timer_trailing overriden value from the test. If no value passed from test, default value will be picked. */
    void'(uvm_config_db#(int)::get(null, get_full_name(), "min_timer_trailing", min_timer_trailing));

    /** To get the max_timer_trailing overriden value from the test. If no value passed from test, default value will be picked. */
    void'(uvm_config_db#(int)::get(null, get_full_name(), "max_timer_trailing", max_timer_trailing));

    /** Get the randomized value of timer_idling_between_transfers. */
    success = std::randomize(timer_idling_between_transfers) with { timer_idling_between_transfers inside {[min_timer_idling_between_transfers:max_timer_idling_between_transfers]};};
    
    /** Get the randomized value of transmit delay. */
    success = std::randomize(transmit_delay) with { transmit_delay inside {[min_transmit_delay:max_transmit_delay]};};

    /** Get the randomized value of timer_trailing. */
    success = std::randomize(timer_trailing) with { timer_trailing inside {[min_timer_trailing:max_timer_trailing]};};

    /** Get the randomized value of timer_leading. */
    success = std::randomize(timer_leading) with { timer_leading inside {[min_timer_leading:max_timer_leading]};};
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
    spi_random_timing_sequence seq;

    `uvm_info("body", "Entered ...", UVM_DEBUG)

    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    `uvm_info("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"), UVM_LOW);

    fork
      begin
        `uvm_do_on_with(seq, p_sequencer.master_sequencer, {sequence_length                == local::sequence_length;
                                                            timer_idling_between_transfers == local::timer_idling_between_transfers;
                                                            transmit_delay                 == local::transmit_delay;
                                                            timer_trailing                 == local::timer_trailing;
                                                            timer_leading                  == local::timer_leading;})
      end
      begin
        `uvm_do_on_with(seq, p_sequencer.slave_sequencer, {sequence_length                == local::sequence_length;
                                                           timer_idling_between_transfers == local::timer_idling_between_transfers;
                                                           transmit_delay                 == local::transmit_delay;
                                                           timer_trailing                 == local::timer_trailing;
                                                           timer_leading                  == local::timer_leading;})
      end
    join

    `uvm_info("body", "Exiting ...", UVM_DEBUG)
  endtask : body

endclass : spi_random_timing_virtual_sequence

`endif // GUARD_SPI_RANDOM_TIMING_VIRTUAL_SEQUENCE_SV
