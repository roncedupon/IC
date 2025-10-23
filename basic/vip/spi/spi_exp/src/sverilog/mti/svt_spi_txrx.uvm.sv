
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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Z/+oY2k+SdemvUlc94AnGvEuJlAoeUrRr2JsvAsptS523HzG2x/RbRa02XUNMdqL
xhVRh5H9xVsvyWD8Od68ydSQB1aNIa6wO6jCszbX4sDrGbRjW8Hob3h1yQSWSfpp
fBesiYRKNsgYjmpCwaZ7pKYkrgbAb8exxYg7tFPywxY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3098      )
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
`pragma protect end_protected

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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
GhCpuddqNpn8esZlP5HkCEHWT0FLyIAvB158epTOjudNBdNYFCv+eWESmz7ThK0X
fuH4qmP13yVVkORD+5iPEvOT/EHOPP1ce6i2bPmhS/A9375hA/488fW8z2vlLnu9
7oVcXLgLpQTUr+jL6XhnhBfCf71UrHKkIJ4PZRj5DfY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10262     )
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
+1kZKRfNCWn/+fPXmtDwgw==
`pragma protect end_protected

endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
aYqLRT9+ZAY1IuoA0glKhPvrTmfowKS4R8yr8aswr/VwyPjJxD8zUyM41BUitxnU
506sQEmLTy/uDKe92iwfezLPk13FnYLWBbZLgSALX4Pv7vzluUW4nBffqv0jyKrX
BsTt+MAGXbWZsbodZYd2OpixZqkMnGIdWr/m3qe8s28=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10715     )
aY6jwPvdEPN6iiSPmXLXK3U3P1vsLvZ+6GIx/h2WK7e3B4XIx9pvh8ha/qj/0+/h
nQrYbraMdJt8760tqEDLp5l2qMjXCqPfyfEWqvPLJywaTbPBxXpPiTNY/WW+/k5E
ri2omYQcMplXa1zdhNs06o1XvdsWnX+ygVmnLV/jMlctj94iaBzu1tOvxaynoQk1
gMjB03bdg6ExsgqE0YsgmCK83yTVhgKf2ZCJq+te3l8OJwuMDElhaD6l9PFE/gaa
H8Qiv2dclZndyjpqlbk6vmrgvH1zhJTad+B3IC3ZBhYa1vwvV8yAIvsn36eucPHY
7BsTXFP2NQo+ZN8Z28+fBdF+qJH1yrH+AQuIKQw8XOC4hZ/dPZo7bE07ziMIFNWW
RpoR5JAX1etPzmjmq5g3raQGJBcn1NAmAi4E9J8hzJK6b6tKf+/MpLNxp8E7Dmed
32FFxy3uIDgtmOJwEgzP6fj0qqC98QPOlZYEtsaNgFRS8+PuPW3X6PgBq1+wZCDI
uIt4ywe0i4s8t6ruk0VvvtDL4w99AbFHpERutSZsXzio6Z0rF1oJRlponKSkr6/Y
vRqhbppUBOiM5plS9+eZomJm4KelHyrjkNNafv94jtY=
`pragma protect end_protected

//vcs_lic_vip_protect  
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
n7+nmxK3g0IB8T72HEdLBDLiYmGNH2dtbayC9LIpmQ3uy47t/Lq4mziHK5kQ9Cob
Z/iYxbrt7u4TFHJ0UtJ2t0F+nB+34UuQfTfkQvoh3cPFBti6gclMDY14IqGUlsyA
DRI4+356TerYbWqIwCatp2mwFN/QUa8HZ8RcQzlcuqQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 25658     )
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
rJ/igAGjEqDuBnIJDztH8Q==
`pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_UVM_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
OaQMFqoT/fhblYaoe3Zn9HfbZ/DxVaaHUzIOJtEMf3t7RYSFk4DtOcmFkVCwypri
i1Y1H6rvqtBxXhNfjRLCM4kzIhfRVXH9xCzTsU2wGPcj6CRdpSBgKsC670/LYy9L
jr6Exk7S5O6gkPMSFQv9N7TBG0SJ6Iw5o/CpFqgq7XI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 25741     )
TEWjOZNn71QFFXHY9i2k8d8iAFVExBMu5gvPIUATj/PHaSQtZj7fnzik3WebNrdk
UpzQqKyWDrr3M63lqVCqEHW29kjxZG38sB6BTob69WfSlXU7diob1zJct30LHS+M
`pragma protect end_protected
