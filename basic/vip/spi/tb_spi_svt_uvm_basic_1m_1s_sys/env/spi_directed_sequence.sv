
`ifndef GUARD_SPI_DIRECTED_SEQUENCE_UVM_SV
`define GUARD_SPI_DIRECTED_SEQUENCE_UVM_SV

/**
 * Abstract:
 * spi_directed_sequence demonstrates, the way user can control the subset of 
 * the svt_spi_transaction class. Transaction class members are assigned 
 * values here. 
 * 
 * It demonstrates the creation of transaction, by assigning values to the 
 * transactions rather than randomization, and then transmitted using 
 * `uvm_send. Here One spi packet is sent back-to-back.
 * 
 * For full set of transaction class members and their complete description 
 * refer "SPI Verification IP UVM Class Reference Manual."
 * 
 * Execution phase: main_phase
 * Sequencer: Can be used with svt_spi_transaction_sequencer sequencer
 */
class spi_directed_sequence extends uvm_sequence #(svt_spi_transaction); 
  
  /** Sequence Length in Virtual Sequence, to set to the actual default sequence */
  rand int unsigned sequence_length =1;
  
  svt_spi_transaction tx_xact;

  /** Configuration obtained from the sequencer */
  svt_spi_configuration  spi_cfg;

  /** UVM object utility macro */
  `uvm_object_utils(spi_directed_sequence)

  /** 
   * This macro is used to declare a variable p_sequencer whose type is
   * svt_spi_transaction_sequencer
   */
  `uvm_declare_p_sequencer(svt_spi_transaction_sequencer)

  /** Class constructor */
  function new (string name = "spi_directed_sequence");
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

    svt_configuration cfg;
    p_sequencer.get_cfg(cfg);

    if(!$cast(spi_cfg,cfg))
      `uvm_fatal("body","unable to cast the configuration to svt_spi_configuration class");
  
    `uvm_info("body", "Entered ...", UVM_LOW)

    /** Create instance of svt_spi_transaction class. */
    `uvm_create(tx_xact)  

    /** Assigning the fields of SPI Transaction class*/
    tx_xact.slave_id = 0;
    tx_xact.transmit_delay = 10;
    tx_xact.transfer_mode = 2'b10;
    tx_xact.double_transfer_rate_mode = 0;
    tx_xact.timer_leading = 1;
    tx_xact.timer_trailing = 1;
    tx_xact.timer_idling_between_transfers = 1;
    tx_xact.data_frame_size = 1;
    tx_xact.data = new [tx_xact.data_frame_size];
    foreach (tx_xact.data[i]) begin 
      tx_xact.data[i] = i;
    end 
    tx_xact.cfg = spi_cfg;
    /** Inject the directed transaction in the output stream of SPI sequencer.*/
    `uvm_send(tx_xact)  

    get_response(rsp);

    `uvm_info("body", "SPI PACKET has finished", UVM_LOW)

    `uvm_info("body", "Exiting ...", UVM_LOW)
  endtask : body

endclass : spi_directed_sequence 

/**
 * This directed sequence generates the transaction with pause enable and pause <br/>
 * duration set to generate error scenario for violating sclk period check. <br/>
 */
//--------------------------------------------------------------------------------------------------
// spi_flash_directed_sclk_pause_sequence
//--------------------------------------------------------------------------------------------------
class spi_flash_directed_sclk_pause_sequence extends uvm_sequence #(svt_spi_transaction); 
  
  /** Declaring xact handle */
  svt_spi_transaction tx_xact;

  /** Configuration obtained from the sequencer */
  svt_spi_configuration  spi_cfg;

  /** UVM object utility macro */
  `uvm_object_utils(spi_flash_directed_sclk_pause_sequence)

  /** 
   * This macro is used to declare a variable p_sequencer whose type is
   * svt_spi_transaction_sequencer
   */
  `uvm_declare_p_sequencer(svt_spi_transaction_sequencer)

  /** Class constructor */
  function new (string name = "spi_flash_directed_sclk_pause_sequence");
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
    int success;
    svt_configuration cfg;
    p_sequencer.get_cfg(cfg);

    if(!$cast(spi_cfg,cfg))
      `uvm_fatal("body","unable to cast the configuration to svt_spi_configuration class");
  
    `uvm_info("body", "Entered ...", UVM_LOW)

    /** Create instance of svt_spi_transaction class. */
    `uvm_create(tx_xact)  

    /** Assigning the fields of SPI Transaction class*/
    // Initiate Transaction to Slave Id =0
    tx_xact.slave_id = 0;
    // Delay parameters, constrant value 4 
    // to make sure no timing check is violated.
    tx_xact.transmit_delay    = 4;
    tx_xact.timer_leading     = 4;
    tx_xact.timer_trailing    = 4;
    tx_xact.timer_idling_between_transfers = 4;
    tx_xact.transfer_mode = 2'b10;
    tx_xact.cfg = spi_cfg;
    // Pause feature parameters
    tx_xact.sclk_pause_after_sclk_count         = new[2]; // Inserting 2 SCLK pause in between. 
    tx_xact.sclk_pause_duration                 = new[2]; // size of sclk_pause_duration[] should be same as size of sclk_pause_after_sclk_count[] 
    foreach(tx_xact.sclk_pause_after_sclk_count[i]) begin
      tx_xact.sclk_pause_after_sclk_count[i]      = i+10; // Inserting pause after every 10 bus_clk edge
      tx_xact.sclk_pause_duration[i]              = 10;   // Setting the pause duration to max value i.e 10
    end
    tx_xact.data_frame_size = 5;
    tx_xact.data = new[tx_xact.data_frame_size];
    foreach (tx_xact.data[i]) begin 
      tx_xact.data[i] = 8'h5A; // directed data frame
    end 
    /** Inject the directed transaction in the output stream of SPI sequencer.*/
    `uvm_send(tx_xact)  

    get_response(rsp);

    `uvm_info("body", "SPI PACKET has finished", UVM_LOW)

    `uvm_info("body", "Exiting ...", UVM_LOW)
  endtask : body

endclass : spi_flash_directed_sclk_pause_sequence
`endif // GUARD_SPI_DIRECTED_SEQUENCE_UVM_SV

