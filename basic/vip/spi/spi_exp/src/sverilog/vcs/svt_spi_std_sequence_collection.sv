`ifndef SVT_SPI_STD_SEQUENCE_COLLECTION_SV
`define SVT_SPI_STD_SEQUENCE_COLLECTION_SV

//---------------------------------------------------------------------------------------------
/**
 * SPI STD Base Sequence
 */ 
class spi_std_base_sequence extends svt_sequence #(svt_spi_transaction);
   
  /** Sequence Length */
  rand int unsigned sequence_length =1;

  /** Selected Slave ID for the transfer */
  rand int unsigned slave_id = 0;
  
  /** Configuration obtained from the sequencer */
  svt_spi_configuration  spi_cfg;

  /** Object utility macro */
  `svt_xvm_object_utils(spi_std_base_sequence)

  /**
   * This macro is used to declare a variable p_sequencer whose type is
   * svt_spi_transaction_sequencer 
   */
  `svt_xvm_declare_p_sequencer(svt_spi_transaction_sequencer)

  /** Class constructor */
  function new(string name="spi_std_base_sequence");
    super.new(name);
    this.manage_objection=1;
  endfunction 

  /** Body of Sequence */
  virtual task body();
  endtask

endclass

//---------------------------------------------------------------------------------------------
/**
 * Abstract:
 * class spi_std_txrx_sequence is used to generate stimulus in TxRx mode on selected slave_id. 
 * 
 * Execution phase: main_phase
 * Sequencer: Can be used with svt_spi_agent transaction sequencer
 */
class spi_std_txrx_sequence extends spi_std_base_sequence;
   
  /* Data word count */ 
  rand int unsigned data_frame_size = 1;

  /** Object utility macro */
  `svt_xvm_object_utils(spi_std_txrx_sequence)

  /**
   * This macro is used to declare a variable p_sequencer whose type is
   * svt_spi_transaction_sequencer 
   */
  `svt_xvm_declare_p_sequencer(svt_spi_transaction_sequencer)

  /** Class constructor */
  function new(string name="spi_std_txrx_sequence");
    super.new(name);
  endfunction 
   
  /** Body of Sequence */
  virtual task body();

    svt_configuration cfg;
    p_sequencer.get_cfg(cfg);

    if(!$cast(spi_cfg,cfg))
      `svt_fatal("body","Unable to cast the configuration to svt_spi_configuration class");
  
    `svt_debug("body", "Entered ...");

    for(int i = 0; i < sequence_length; i++) begin
      /** Generate SPI packets randomly.  */
      `svt_xvm_do_with(req, {transfer_mode == 2'b10;
                             double_transfer_rate_mode == 1'b0;
                             slave_id==local::slave_id;
                             data_frame_size == local::data_frame_size;
                            })

      get_response(rsp);
    end

    `svt_debug("body", "Exiting ...");
  endtask 
endclass

//---------------------------------------------------------------------------------------------
/**
 * Abstract:
 * class spi_std_eeprom_sequence is used to generate stimulus in EEPROM mode on selected slave_id. 
 * 
 * Execution phase: main_phase
 * Sequencer: Can be used with svt_spi_agent transaction sequencer
 */
class spi_std_eeprom_sequence extends spi_std_base_sequence;

  /* bit width for Instruction frame */ 
  rand int unsigned instruction_frame_size = 8;

  /* bit width for Address frame */ 
  rand int unsigned address_frame_size = 2;

  /* Data word count */ 
  rand int unsigned data_frame_size = 8;

  /** Object utility macro */
  `svt_xvm_object_utils(spi_std_eeprom_sequence)

  /**
   * This macro is used to declare a variable p_sequencer whose type is
   * svt_spi_transaction_sequencer 
   */
  `svt_xvm_declare_p_sequencer(svt_spi_transaction_sequencer)

  /** Class constructor */
  function new(string name="spi_std_eeprom_sequence");
    super.new(name);
  endfunction 

  /** Body of Sequence */
  virtual task body();

    svt_configuration cfg;
    p_sequencer.get_cfg(cfg);

    if(!$cast(spi_cfg,cfg))
      `svt_fatal("body","Unable to cast the configuration to svt_spi_configuration class");
  
    `svt_debug("body", "Entered ...");

    for(int i = 0; i < sequence_length; i++) begin
      /** Generate SPI packets randomly.  */
      `svt_xvm_do_with(req, {slave_id                  == local::slave_id;
                             transfer_mode             == 2'b11;
                             double_transfer_rate_mode == 0;
                             instruction_frame_size    == local::instruction_frame_size;
                             address_frame_size        == local::address_frame_size;
                             data_frame_size           == local::data_frame_size;
                            })

      get_response(rsp);
    end

    `svt_debug("body", "Exiting ...");
  endtask 
endclass

//---------------------------------------------------------------------------------------------
/**
 * Abstract:
 * class spi_std_txonly_sequence is used to generate the stimulus in Tx only mode 
 * with selected slave_id.
 * 
 * Execution phase: main_phase
 * Sequencer: Can be used with svt_spi_agent transaction sequencer
 */
class spi_std_txonly_sequence extends spi_std_base_sequence;
   
  /* Data word count */ 
  rand int unsigned data_frame_size = 1;

  /** Object utility macro */
  `svt_xvm_object_utils(spi_std_txonly_sequence)

  /**
   * This macro is used to declare a variable p_sequencer whose type is
   * svt_spi_transaction_sequencer 
   */
  `svt_xvm_declare_p_sequencer(svt_spi_transaction_sequencer)

  /** Class constructor */
  function new(string name="spi_std_txonly_sequence");
    super.new(name);
  endfunction 
   
  /** Body of Sequence */
  virtual task body();

    svt_configuration cfg;
    p_sequencer.get_cfg(cfg);

    if(!$cast(spi_cfg,cfg))
      `svt_fatal("body","Unable to cast the configuration to svt_spi_configuration class");
  
    `svt_debug("body", "Entered ...");

    for(int i = 0; i < sequence_length; i++) begin
      /** Generate SPI packets randomly. Transfer Mode = 00 (TX only)  */
      `svt_xvm_do_with(req, {
                             slave_id                 ==local::slave_id;
                             transfer_mode            ==2'b00;
                             double_transfer_rate_mode==0;
                             data_frame_size == local::data_frame_size;
                            })

      get_response(rsp);
    end

    `svt_debug("body", "Exiting ...");
  endtask 
endclass

//---------------------------------------------------------------------------------------------
/**
 * Abstract:
 * class spi_std_rxonly_sequence is used to generate trigger the device to operate in 
 * Rx only mode with selected slave id.
 * 
 * Execution phase: main_phase
 * Sequencer: Can be used with svt_spi_agent transaction sequencer
 */
class spi_std_rxonly_sequence extends spi_std_base_sequence;
   
  /* Data word count */ 
  rand int unsigned data_frame_size = 1;

  /** Object utility macro */
  `svt_xvm_object_utils(spi_std_rxonly_sequence)

  /**
   * This macro is used to declare a variable p_sequencer whose type is
   * svt_spi_transaction_sequencer 
   */
  `svt_xvm_declare_p_sequencer(svt_spi_transaction_sequencer)

  /** Class constructor */
  function new(string name="spi_std_rxonly_sequence");
    super.new(name);
  endfunction 
   
  /** Body of Sequence */
  virtual task body();

    svt_configuration cfg;
    p_sequencer.get_cfg(cfg);

    if(!$cast(spi_cfg,cfg))
      `svt_fatal("body","Unable to cast the configuration to svt_spi_configuration class");
  
    `svt_debug("body", "Entered ...");

    for(int i = 0; i < sequence_length; i++) begin
      /** Generate SPI packets randomly.  */
      `svt_xvm_do_with(req, {
                             slave_id                 ==local::slave_id;
                             transfer_mode            ==2'b01;
                             double_transfer_rate_mode==0;
                             data_frame_size == local::data_frame_size;
                            })

      get_response(rsp);
    end

    `svt_debug("body", "Exiting ...");
  endtask 
endclass

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
class spi_std_directed_sequence extends spi_std_base_sequence; 
  
  svt_spi_transaction tx_xact;

  /** Object utility macro */
  `svt_xvm_object_utils(spi_std_directed_sequence)

  /** 
   * This macro is used to declare a variable p_sequencer whose type is
   * svt_spi_transaction_sequencer
   */
  `svt_xvm_declare_p_sequencer(svt_spi_transaction_sequencer)

  /** Class constructor */
  function new (string name = "spi_std_directed_sequence");
    super.new(name);
  endfunction : new

  virtual task body();

    svt_configuration cfg;
    p_sequencer.get_cfg(cfg);

    if(!$cast(spi_cfg,cfg))
      `svt_fatal("body","unable to cast the configuration to svt_spi_configuration class");
  
    `svt_debug("body", "Entered ...");

    /** Create instance of svt_spi_transaction class. */
    `svt_xvm_create(tx_xact)  

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
    `svt_xvm_send(tx_xact)  

    get_response(rsp);

    `svt_debug("body", "Exiting ...");
  endtask : body

endclass : spi_std_directed_sequence 

/**
 * This directed sequence generates the transaction with pause enable and pause <br/>
 * duration set to generate error scenario for violating sclk period check. <br/>
 */
//--------------------------------------------------------------------------------------------------
// spi_std_directed_sclk_pause_sequence
//--------------------------------------------------------------------------------------------------
class spi_std_directed_sclk_pause_sequence extends spi_std_base_sequence; 
  
  /** Declaring xact handle */
  svt_spi_transaction tx_xact;

  rand bit[7:0] data = 8'h5A;

  /** object utility macro */
  `svt_xvm_object_utils(spi_std_directed_sclk_pause_sequence)

  /** 
   * This macro is used to declare a variable p_sequencer whose type is
   * svt_spi_transaction_sequencer
   */
  `svt_xvm_declare_p_sequencer(svt_spi_transaction_sequencer)

  /** Class constructor */
  function new (string name = "spi_std_directed_sclk_pause_sequence");
    super.new(name);
  endfunction : new
  
  virtual task body();
    int success;
    svt_configuration cfg;
    p_sequencer.get_cfg(cfg);

    if(!$cast(spi_cfg,cfg))
      `svt_fatal("body","unable to cast the configuration to svt_spi_configuration class");
  
    `svt_debug("body", "Entered ...");

    /** Create instance of svt_spi_transaction class. */
    `svt_xvm_create(tx_xact)  

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
      tx_xact.data[i] = data; // directed data frame
    end 
    /** Inject the directed transaction in the output stream of SPI sequencer.*/
    `svt_xvm_send(tx_xact)  

    get_response(rsp);

    `svt_debug("body", "Exiting ...");
  endtask : body

endclass : spi_std_directed_sclk_pause_sequence

`endif //SVT_SPI_STD_SEQUENCE_COLLECTION_SV

