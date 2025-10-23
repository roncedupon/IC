
/**
 * Abstract:
 * class spi_default_sequence is used by the testbench to provide 
 * default transaction sequence which is initiated on the virtual sequence 
 * through the virtual sequencer. It defines a sequence in which it generates the
 * request object randomly
 * 
 * Execution phase: main_phase
 * Sequencer: Can be used with both DTE and DCE Agent sequencer
 */
class spi_default_sequence extends uvm_sequence #(svt_spi_transaction);
   
  /** Sequence Length in Virtual Sequence, to set to the actual default sequence */
  rand int unsigned sequence_length = 1;
  rand int unsigned data_frame_size = 1;
  constraint data_frame_size_c {data_frame_size inside {[1:`SVT_SPI_MAX_DATA_TRANSFER]};}

  /** Configuration obtained from the sequencer */
  svt_spi_configuration  spi_cfg;
   
  /** UVM object utility macro */
  `uvm_object_utils(spi_default_sequence)

  /**
   * This macro is used to declare a variable p_sequencer whose type is
   * svt_spi_transaction_sequencer 
   */
  `uvm_declare_p_sequencer(svt_spi_transaction_sequencer)

  /** Class constructor */
  function new(string name="spi_default_sequence");
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
      `uvm_do_with(req, {slave_id        == 0;
                         transfer_mode   == 2'b10;//TXRX MODE 
                         data_frame_size == local::data_frame_size;
                         double_transfer_rate_mode == 0;
                        })


      get_response(rsp);
      `uvm_info("body", $sformatf("Response received for iteration=%0d", i), UVM_LOW)
    end

    `uvm_info("body", "Exiting ...", UVM_DEBUG)
  endtask 
endclass

//--------------------------------------------------------------------------------------------
// SPI EEPROM Sequence
//--------------------------------------------------------------------------------------------
class spi_eeprom_sequence extends uvm_sequence #(svt_spi_transaction);
   
  /** Sequence Length in Virtual Sequence, to set to the actual default sequence */
  rand int unsigned sequence_length =1;
  rand int unsigned instruction_frame_size = 8;
  rand int unsigned address_frame_size = 2;
  rand int unsigned data_frame_size = 8;

  /** Configuration obtained from the sequencer */
  svt_spi_configuration  spi_cfg;
   
  /** UVM object utility macro */
  `uvm_object_utils(spi_eeprom_sequence)

  /**
   * This macro is used to declare a variable p_sequencer whose type is
   * svt_spi_transaction_sequencer 
   */
  `uvm_declare_p_sequencer(svt_spi_transaction_sequencer)

  /** Class constructor */
  function new(string name="spi_eeprom_sequence");
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
      `uvm_do_with(req, {slave_id                  == 0;
                         transfer_mode             == 2'b11;
                         double_transfer_rate_mode == 0;
                         instruction_frame_size    == local::instruction_frame_size;
                         address_frame_size        == local::address_frame_size;
                         data_frame_size           == local::data_frame_size;
                         })

      get_response(rsp);
      `uvm_info("body", $sformatf("Response received for iteration=%0d", i), UVM_LOW)
    end

    `uvm_info("body", "Exiting ...", UVM_DEBUG)
  endtask 
endclass

