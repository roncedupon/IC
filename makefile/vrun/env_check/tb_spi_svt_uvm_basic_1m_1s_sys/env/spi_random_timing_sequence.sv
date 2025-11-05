/**
 * Abstract:
 * class spi_random_timing_sequence is used by the testbench to provide 
 * random timing transaction sequence which is initiated on the virtual sequence 
 * through the virtual sequencer. It defines a sequence in which it generates the
 * request object with random timing values(timer_leading, timer_trailing and timer 
 * idling_between_transfers)
 * 
 * Execution phase: main_phase
 * Sequencer: Can be used with both DTE and DCE Agent sequencer
 */
class spi_random_timing_sequence extends uvm_sequence #(svt_spi_transaction);
   
  /** Sequence Length in Virtual Sequence, to set to the actual spi_random_leading_timer_sequence */
  rand int unsigned sequence_length = 1;
  rand int unsigned data_frame_size = 1;
  rand int timer_leading = 1 ; 
  rand int timer_trailing = 1 ;
  rand int transmit_delay = 1 ;
  rand int timer_idling_between_transfers = `SVT_SPI_MAX_IDLE_TIME_BETWEEN_TRANSFER ;
  constraint data_frame_size_c {data_frame_size inside {[1:`SVT_SPI_MAX_DATA_TRANSFER]};}
  constraint timer_leading_c {timer_leading inside {[1:`SVT_SPI_MAX_LEADING_TIME]};}
  constraint timer_trailing_c {timer_trailing inside {[1:`SVT_SPI_MAX_TRAILING_TIME]};}
  constraint timer_delay_c {transmit_delay inside {[0:`SVT_SPI_MAX_TRANSMIT_DELAY]};}
  constraint timer_idling_between_transfers_c {timer_idling_between_transfers inside {[0:`SVT_SPI_MAX_IDLE_TIME_BETWEEN_TRANSFER]};}

  /** Configuration obtained from the sequencer */
  svt_spi_configuration  spi_cfg;
   
  /** UVM object utility macro */
  `uvm_object_utils(spi_random_timing_sequence)

  /**
   * This macro is used to declare a variable p_sequencer whose type is
   * svt_spi_transaction_sequencer 
   */
  `uvm_declare_p_sequencer(svt_spi_transaction_sequencer)

  /** Class constructor */
  function new(string name="spi_random_timing_sequence");
    super.new(name);
  endfunction 

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
   
  /** Body of Sequence */
  virtual task body();

    svt_configuration cfg;
    p_sequencer.get_cfg(cfg);

    if(!$cast(spi_cfg,cfg))
      `uvm_fatal("body","Unable to cast the configuration to svt_spi_configuration class");
  
    `uvm_info("body", "Entered ...", UVM_DEBUG)

    for(int i = 0; i < sequence_length; i++) begin
      `uvm_info("body", $sformatf("Calling `uvm_do, iteration=%0d", i), UVM_LOW)

      /** Generate SPI packets randomly.  */
      `uvm_do_with(req, {slave_id                         == 0;
                         transfer_mode                    == 2'b10;//TXRX MODE 
                         data_frame_size                  == local::data_frame_size;
                         timer_leading                    == local::timer_leading;
                         timer_trailing                   == local::timer_trailing;
                         transmit_delay                   == local::transmit_delay;
                         timer_idling_between_transfers   == local::timer_idling_between_transfers;
                         double_transfer_rate_mode        == 0;
                        })


      get_response(rsp);
      `uvm_info("body", $sformatf("Response received for iteration=%0d", i), UVM_LOW)
    end

    `uvm_info("body", "Exiting ...", UVM_DEBUG)
  endtask 
endclass
