
`ifndef GUARD_SVT_SPI_TXRX_UVM_SV
`define GUARD_SVT_SPI_TXRX_UVM_SV

typedef class svt_spi_txrx_callback;
typedef class svt_spi_txrx_cb_exec;
typedef class svt_spi_txrx;

`svt_xvm_typedef_cb(svt_spi_txrx,svt_spi_txrx_callback,svt_spi_txrx_callback_pool);

// =============================================================================
/**
 * Defines the SPI TxRx Driver, used to process
 * traffic in the TX and RX directions.
 *
 * For the TX direction it gets SPI Transaction from input TLM port, process it 
 * and send it to the bus.
 * 
 * For the RX direction it reassembles SPI Transaction from the bus and
 * then delivers it to the upstream layer via output TLM port.
 */
class svt_spi_txrx extends svt_driver#(svt_spi_transaction);

  `svt_xvm_register_cb(svt_spi_txrx, svt_spi_txrx_callback)

  // ****************************************************************************
  // Properties
  // ****************************************************************************

  /**
   * RX Upstream TLM Put Port
   *
   * Provides a mechanism for sending SPI Transaction that can be recognized by the
   * Upper Layer. 
   * The handle to the SPI Transaction TLM put port can be set or
   * obtained through the driver's public member #rx_xact_out_port
   */
  svt_debug_opts_blocking_put_port #(svt_spi_transaction) rx_xact_out_port;

  /**
   * RX Upstream TLM Peek port.
   *
   * Provides a mechanism for external components to retrieve SPI Transactions 
   * from the TxRx. These should only be used when
   * the TxRx is the top layer in the stack. The handle to this
   * port can be set or obtained through the driver's
   * public member #rx_xact_peek_port.
   */
  `SVT_DEBUG_OPTS_IMP_PORT(blocking_peek,svt_spi_transaction,svt_spi_txrx) rx_xact_peek_port;

  /**
   * Blocking get port implementation, transporting REQ-type instances. It is named with
   * the _port suffix to match the seq_item_port inherited from the base class.
   */
  `SVT_DEBUG_OPTS_IMP_PORT(blocking_get,svt_mem_transaction,svt_spi_txrx) req_item_port;
 
  /**
  * Port to obtain the response packet of svt_mem_transaction type from
  * mem_sequencer
  */
  `SVT_XVM(seq_item_pull_port)#(svt_mem_transaction, svt_mem_transaction) mem_seq_item_port;

  /**
   * Port to obtain svt_spi_service object. */
  `SVT_XVM(seq_item_pull_port) #(svt_spi_service) service_item_port;

  //////////
  // Events
  //////////

/** @cond PRIVATE */
  /** Event triggered when the SPI Transaction is first initiated (TX) or recognized (RX). */
  `SVT_XVM(event) EVENT_TRANSACTION_STARTED;

  /** Event triggered when the SPI Transaction is completed. */
  `SVT_XVM(event) EVENT_TRANSACTION_ENDED;
/** @endcond */

  /** Event triggered when the SPI Transaction is first initiated (TX) */
  `SVT_XVM(event) EVENT_TRANSACTION_STARTED_TX;

  /** Event triggered when the SPI Transaction is completed at TX */
  `SVT_XVM(event) EVENT_TRANSACTION_ENDED_TX;

  /** Event triggered when the SPI Transaction is first recognized (RX) */
  `SVT_XVM(event) EVENT_TRANSACTION_STARTED_RX;

  /** Event triggered when the SPI Transaction is completed at RX */
  `SVT_XVM(event) EVENT_TRANSACTION_ENDED_RX;

/** @cond PRIVATE */
  /** Event triggered when the EMPSPI Negotiation is completed . */
  `SVT_XVM(event) EVENT_EMPSPI_NEGOTIATION_COMPLETED;
/** @endcond */

/** @cond PRIVATE */

  /**
   * Response packet from mem_sequencer
   */
  svt_mem_transaction mem_rsp;

  /**
   * Mailbox used to hand request objects received from the item_req method to
   * the get method implementation.
   */
  local mailbox#(svt_mem_transaction) req_mbox;

  /** System configuration handle */
  local svt_spi_configuration cfg;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_spi_configuration cfg_snapshot;

  /** Shared status object which allows components (which each reference the same object) to communicate state changes. */
  local svt_spi_status shared_status;

  /** Methodology independent driver for the Transmit-Receive features. */
  svt_spi_txrx_active_common common;

  /** Methodology independent callback container for the Transmit-Receive features. */
  svt_spi_txrx_cb_exec cb_exec;
  
  /** Peek Transaction */
  local svt_spi_transaction rx_peek_xact = null;

/** @endcond */

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_spi_txrx)
    `svt_xvm_field_object(cfg, `SVT_XVM_ALL_ON | `SVT_XVM_REFERENCE)
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Class constructor:
   *
   * @param name The name of this instance.  Used to construct the hierarchy.
   *
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new(string name = "svt_spi_txrx", `SVT_XVM(component) parent = null);
  
  //----------------------------------------------------------------------------
  /** Build Phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
`endif
  //----------------------------------------------------------------------------
  /** Connect Phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void connect_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void connect();
`endif

  //----------------------------------------------------------------------------
  /** Run Phase */
`ifdef SVT_UVM_TECHNOLOGY
  extern task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern task run();
`endif

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

//vcs_lic_vip_protect  
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
krwhRx8373eaTx0Y+mgZvKDEfSBF7aA2ietu1UZmMWPe8zBEA3UDtw/9vwtsrf/T
sG6YtDILtziukCspmtq6SBqcIki7xrAJ9eSpq+0WNiGvPSXYFBVRf17+ev4BFZeC
F3zWKwu26Tg1i6ZpJHFT5dmPrGrhMxWpgNs2IhDtQSQ16Xw2jS/N5w==
//pragma protect end_key_block
//pragma protect digest_block
GYSwFV7B64z+eR9IMwOYcbxldrA=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
QE2LgG4l8eEDcjI0b7O4KAPNoGY=
//pragma protect end_digest_block
//pragma protect end_protected

  //----------------------------------------------------------------------------
  /**
   * This task gets svt_spi_transaction sequence item from the sequencer and make it available
   * to the common driver.
   */
  extern task consume_from_seq_item_port();

  //----------------------------------------------------------------------------
  /**
   * This task gets svt_spi_service sequence item from the service sequencer and execute it in the common driver.
   */
  extern task consume_service_request();

  //----------------------------------------------------------------------------
  /**
   * Called by the component after pulling a SPI Transaction descriptor
   * out of its TLM sequence port, but before acting on the SPI Transaction in any way.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument that, if set by the user's implementation,
   * causes the component to discard the svt_spi_transaction descriptor without further action.
   */
  extern virtual function void post_seq_item_get(svt_spi_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Called by the component after recognizing a SPI Transaction, just prior to
   * placing the SPI Transaction in the output.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument that, if set by the user's implementation,
   * causes the component to discard the svt_spi_transaction descriptor without further action.
   */
  extern virtual function void pre_transaction_out_put(svt_spi_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Called by the component after placing the SPI Transaction in the output.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_out_cov(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been started at TX.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_started_tx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been started at RX.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_started_rx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been ended at Tx Path.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_ended_tx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been ended at Rx Path.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_ended_rx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has finished tranmsitting its last data bit over SPI lane(s).
   * This is used to update the data content dynamically while current transaction is in progress.
   * In Master Mode, additional clocks will be generated to transmit the new data bits.
   * Data driving to remain as it is.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest. <br/>
   * This callback is currently supported for SPI-Bus mode only. 
   * Only svt_spi_transaction::data and svt_spi_transaction::data_frame_size fields are expected to be updated by User for this callback.
   */
  extern virtual function void load_tx_fifo(svt_spi_transaction xact);

//vcs_lic_vip_protect  
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Pe+m3vLf0s8LBZizLvfehc/Oj8JDwaj/RP2nEIdvNmecEOC4h5lQOLRhaKp65ONn
Xqz9/56uSzdR7Zt+OTLg8YoxbJyEZxXS6I6aQ7KKDBdA2wTMNOVxZqXVfYmLKp0L
Ik6OZCwvi6PcDiuU7pSInUqkPjDGPWfK38xnn1Ug1g2exNJcgRiUtA==
//pragma protect end_key_block
//pragma protect digest_block
1dL3M1Kh/bCgauqkgv73xlVHo6E=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
XoOzWZhG11jhdPONN8uuhrUimwI=
//pragma protect end_digest_block
//pragma protect end_protected

endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
nJvP6AWvHqA2fhCyyQxNkeQ0CuUnYVeqws7X42bi3TSxzhzuiRLN1SgTKRAUrYEz
E95EnUxHh+OuZXR2YedbNmDtwQ/1wJtEnhFkUpNlizv0bYDfZfaWKcXE6Q+8eesY
rT9riZqDu1VEuwUDwnTcHGMsCBC8AQGC6p7FDqxpbbXBlTsuKqE3yQ==
//pragma protect end_key_block
//pragma protect digest_block
ZTEvHid2FgPLQ+g29efFlcwu75I=
//pragma protect end_digest_block
//pragma protect data_block
2ofcO55kd8Ki41NnmyhwdH3306jq34BUqEJOp+hhosrAyNy3XJWkdR3GhHCFzro6
l2yO+Yg5btMhUfx9DSI4+6rS0V0CzYMsheIjNmF5RVhttOl4P2pWBxKGTMp+LOAe
TjMlmGn6Su7QyORX6bsgs+qYfvNyQTbuK5V6PKZGBWkDIZE+6vaT41qi8guTk9BV
dfeTFlX7jTiESkZz4sHLLrwwe7NI/oOa1xTAx/1w19+pgpuUV0axgO28kMq2JnvN
8YOJAKv0srEgSwqFaVKHzrczHtEx9L1F4BHzYHng2q8PYspyosq7tzWSwgxmdYK2
HZMWz9N5SVHVPgmneW+TTb4Cs17wUjswA3C9/laOVih1AEfsjOGay5TWnHmwh+c3
DXZAev5mMckH5nLtHuUuvUQKVcb2vEoYMBj6jm6L87qxcSj9ENmXm/hBrcC6ffxz
0kNY/av6iLo1wUeKnLEnzTtJSx+IY/ukd0hw+erxf/VxjnE2PX+MGYRhjiuKYl1b
K1497Rcl04t/A2Iz2RBvnnbJ2lHNeRmohGYM0hUk1x0JRwrvqFJd1eXikeZ1lfcM
9tQuFsOcocygX1bTq6aKdDQycrZB6Zk39JVFObbHB3Ul25cXy9acXYsR5v2ByShV
dtU7vUahvWRYBQ7yyyuDMWoKXsqw7MfguMXhLmqI07RF+pG0PF+597o8hBI12FUj
/ejTgubPfZTpGYROkZhNia3YLZxmW+opBLW6XO7usjfWdDaSfuZrI7c7l0cDmUbv
aDAYz8Vt80q3BaVnCI0sqim9Y3sSkn87cGZwdOH6/1UDNwogeS6l2nN4kJQlJkwH

//pragma protect end_data_block
//pragma protect digest_block
V0OeYl5i/4e8xSbVYdmJYb2dR5g=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_lic_vip_protect  
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
meNmiYVKObYMt6Q5KwZ17bJtm4RJrL29GjNuY1kZo8eXqFYXjq2UZCmO0EW9l5Kl
AyyripmDa9W80Iw/0lbglYL3e5038773M6U30RVgAePzjZNz8RBDHTMtCoRcMGtv
8xDg5hQex8IRUQexT5sqq8EuuufRNfcmv+bhzNCAZc8agLJpa8CL0A==
//pragma protect end_key_block
//pragma protect digest_block
+CEEXp8r9zF6SUsmFYdq+AWu5Ic=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
O+m5lUgebDJuSgK90z1kTsX9pWg=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_UVM_SV
