
`ifndef GUARD_UART_RECONFIG_SEQUENCE_UVM_SV
`define GUARD_UART_RECONFIG_SEQUENCE_UVM_SV

/**
 * Abstract:
 * uart_reconfig_sequence demonstrates, the way user can control the subset of 
 * the svt_uart_transaction class. Transaction class members are assigned 
 * values here along with also it is been used inside reconfig_test which provide
 * usecase how user can reconfiure the configuration attributes at run time. 
 * 
 * It demonstrates the creation of transaction, by assigning values to the 
 * transactions rather than randomization, and then transmitted using 
 * `uvm_send. Here One uart packet is sent back-to-back.
 * 
 * For full set of transaction class members and their complete description 
 * refer "Uart Verification IP UVM Class Reference Manual."
 * 
 * Execution phase: main_phase
 * Sequencer: Can be used with both DTE and DCE agent sequencer
 */
class uart_reconfig_sequence extends uvm_sequence #(svt_uart_transaction); 
  
  svt_uart_transaction tx_xact;

  /** Configuration obtained from the sequencer */
  svt_uart_configuration  uart_cfg;

  /** UVM object utility macro */
  `uvm_object_utils(uart_reconfig_sequence)

  /** 
   * This macro is used to declare a variable p_sequencer whose type is
   * svt_uart_transaction_sequencer
   */
  `uvm_declare_p_sequencer(svt_uart_transaction_sequencer)

  /** Class constructor */
  function new (string name = "uart_reconfig_sequence");
    super.new(name);
  endfunction : new

  /** Sequence body() */
  virtual task body();
    svt_configuration get_cfg;
    svt_configuration cfg;
    p_sequencer.get_cfg(cfg);

    if(!$cast(uart_cfg,cfg))
      `uvm_fatal("body","unable to cast the configuration to svt_uart_configuration class");
  
    `uvm_info("body", "Entered ...", UVM_LOW)

    /** Create instance of svt_uart_transaction class. */
    `uvm_create(tx_xact)  

    /** Assigning the fields of Uart Transaction class*/
    tx_xact.packet_count = 5;
    tx_xact.inter_cycle_delay = 100;
    tx_xact.payload = new[tx_xact.packet_count];
 
    /** Inject the directed transaction in the output stream of Uart sequencer.*/
    `uvm_send(tx_xact)  

    /** 
     * Call get_response only if agent configuration attribute,
     * enable_put_response is set 1.
     */
    if(uart_cfg.enable_put_response == 1)
      get_response(rsp);

    `uvm_info("body", "UART PACKET has finished", UVM_LOW)

    `uvm_info("body", "Exiting ...", UVM_LOW)
  endtask : body

endclass : uart_reconfig_sequence 

`endif // GUARD_UART_RECONFIG_SEQUENCE_UVM_SV

