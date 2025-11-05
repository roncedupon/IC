
/**
 * Abstract:
 * class spi_txonly_sequence is used by the testbench to provide 
 * default transaction sequence which is initiated on the virtual sequence 
 * through the virtual sequencer. It defines a sequence in which it generates the
 * request object randomly
 * 
 * Execution phase: main_phase
 * Sequencer: Can be used with both DTE and DCE Agent sequencer
 */
class spi_txonly_sequence extends uvm_sequence #(svt_spi_transaction);
   
  /** Sequence Length in Virtual Sequence, to set to the actual default sequence */
  rand int unsigned sequence_length =1;

  /** Configuration obtained from the sequencer */
  svt_spi_configuration  spi_cfg;
   
  /** UVM object utility macro */
  `uvm_object_utils(spi_txonly_sequence)

  /**
   * This macro is used to declare a variable p_sequencer whose type is
   * svt_spi_transaction_sequencer 
   */
  `uvm_declare_p_sequencer(svt_spi_transaction_sequencer)

  /** Class constructor */
  function new(string name="spi_txonly_sequence");
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
      `uvm_do_with(req, {transmit_delay == 10;slave_id==0;
       transfer_mode == 2'b00;double_transfer_rate_mode==0;})

      get_response(rsp);
      `uvm_info("body", $sformatf("Response received for iteration=%0d", i), UVM_LOW)
    end

    `uvm_info("body", "Exiting ...", UVM_DEBUG)
  endtask 
endclass

