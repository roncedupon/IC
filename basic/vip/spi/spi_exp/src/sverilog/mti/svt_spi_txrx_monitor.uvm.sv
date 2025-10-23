
`ifndef GUARD_SVT_SPI_TXRX_MONITOR_UVM_SV
`define GUARD_SVT_SPI_TXRX_MONITOR_UVM_SV
typedef class svt_spi_txrx_monitor;
typedef class svt_spi_txrx_monitor_callback;
typedef class svt_spi_txrx_monitor_cb_exec;

`svt_xvm_typedef_cb(svt_spi_txrx_monitor,svt_spi_txrx_monitor_callback,svt_spi_txrx_monitor_callback_pool);

// =============================================================================
/**
 * Defines the SPI TxRx Monitor, used to access
 * traffic in the TX and RX directions.
 *
 * All transaction, regardless of TX or RX direction, come from the same
 * source. In an 'active' situation the source is the driver, which is
 * processing the data up and down the stack. In the 'passive' situation
 * the TX and RX traffic comes in from the analysis ports coming in from
 * the lower stream layer
 */
class svt_spi_txrx_monitor extends svt_monitor #(`SVT_XVM(sequence_item));

  `svt_xvm_register_cb(svt_spi_txrx_monitor, svt_spi_txrx_monitor_callback)

  // ****************************************************************************
  // Properties
  // ****************************************************************************
  /**
   * RX SPI Transaction TLM Analysis port for Monitor.
   *
   * Provides a mechanism for retrieving RX SPI Transaction recognized by TxRx
   * Layer. The handle to the SPI Transaction TLM analysis port can be set or
   * obtained through the monitor's public member #rx_xact_observed_port.
   * Used in passive or active mode.
   */
  `SVT_DEBUG_OPTS_IMP_PORT(analysis,svt_spi_transaction,svt_spi_txrx_monitor) rx_xact_observed_port;

  /**
   * TX SPI Transaction TLM Analysis port for Monitor.
   *
   * Provides a mechanism for retrieving TX SPI Transaction recognized by TxRx
   * Layer. The handle to the SPI Transaction TLM analysis port can be set or
   * obtained through the monitor's public member #tx_xact_observed_port.
   * Used in passive or active mode.
   */
  `SVT_DEBUG_OPTS_IMP_PORT(analysis,svt_spi_transaction,svt_spi_txrx_monitor) tx_xact_observed_port;

  /**
   * Blocking get port implementation, transporting REQ-type instances. It is named with
   * the _port suffix to match the seq_item_port inherited from the base class.
   */
  `SVT_DEBUG_OPTS_IMP_PORT(blocking_get,svt_mem_transaction,svt_spi_txrx_monitor) req_item_port;
 
  /**
  * Port to obtain the response packet of svt_mem_transaction type from
  * mem_sequencer
  */
  `SVT_XVM(seq_item_pull_port)#(svt_mem_transaction, svt_mem_transaction) mem_seq_item_port;

  //////////
  // Events
  //////////

/** @cond PRIVATE */
  /** Event triggered when the transaction is first initiated (TX) or recognized (RX). */
  `SVT_XVM(event) EVENT_TRANSACTION_STARTED;

  /** Event triggered when the transaction is completed. */
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

  /** Event triggered when one beat has been Sampled/Transmitted at SPI Interface */
  `SVT_XVM(event) EVENT_BEAT_ENDED;

  /** Event triggered when the POWER UP Sequence is completed . */
  `SVT_XVM(event) EVENT_POWER_UP_SEQUENCE_COMPLETED;

  /** Event triggered when the POWER DOWN Sequence is completed . */
  `SVT_XVM(event) EVENT_POWER_DOWN_SEQUENCE_COMPLETED;

/** @cond PRIVATE */
  /** Event triggered when the EMPSPI Negotiation is completed . */
  `SVT_XVM(event) EVENT_EMPSPI_NEGOTIATION_COMPLETED;
/** @endcond */

/** @cond PRIVATE */
  /** System configuration handle */
  local svt_spi_configuration cfg;

  /** Configuration object copy to be used in set/get operations. */
  protected svt_spi_configuration cfg_snapshot;

  /** Shared status object which allows components (which each reference the same object) to communicate state changes. */
  local svt_spi_status shared_status;

  /** Handle to an abstract common class. This class is extended in two different 
   *  classes to implement shared functions between the driver and monitor (in active mode) 
   *  or monitor only functions (in passive mode). The containing agent class will construct 
   *  the correct extended common class and assign that to this monitor.
   **/
  svt_spi_txrx_common common;

  /** Technology independent support for the Transmit-Receive features. */
  svt_spi_txrx_monitor_cb_exec cb_exec;

  /**
   * Response packet from mem_sequencer
   */
  svt_mem_transaction mem_rsp;

  /**
   * Mailbox used to hand request objects received from the item_req method to
   * the get method implementation.
   */
  local mailbox#(svt_mem_transaction) req_mbox;

/** @endcond */

  // ****************************************************************************
  // Field Macros
  // ****************************************************************************

  `svt_xvm_component_utils_begin(svt_spi_txrx_monitor)
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
  extern function new(string name = "svt_spi_txrx_monitor", `SVT_XVM(component) parent = null);

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

  // ****************************************************************************
  // Configuration Access Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

//vcs_lic_vip_protect  
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QRuehwZIOwy4T2IKyQ6EkqeqdBYqNpme+XcrvxUBYShvdSi02LL10vlh0ahZrGgv
PvMOdVDmoZ0Y6jtwT1/TvNbZlUcIHK1waoWT4aolP5T+n3zCyrF/b/GXxRSy2lox
JJlfUSE6o3BvJu59j3NL2bINkCSD6/dtmUzu1k0VfsY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3456      )
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
GDNL7ncdPdN3fJOMUxl5Ig==
`pragma protect end_protected

  //----------------------------------------------------------------------------
  /**
   * Called by the component after recognizing a SPI Transaction, just prior to
   * placing the SPI Transaction in the output.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument that, if set by the user's callback implementation,
   * causes the component to discard the svt_spi_transaction descriptor without further action.
   */
  extern virtual function void pre_transaction_observed_put(svt_spi_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Called by the component to allow the testbench to collect functional
   * coverage information from a SPI Transaction that it just received. This is called by
   * the component immediately before placing the SPI Transaction into the output.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_observed_cov(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been started at
   * Tx port.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_started_tx(svt_spi_transaction xact);
  
  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been started at
   * Rx port.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_started_rx(svt_spi_transaction xact);
  
  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been ended at Tx
   * port.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_ended_tx(svt_spi_transaction xact);
    
  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been ended at Rx
   * port.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void transaction_ended_rx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a Beat has been Ended(Sampled/Transmitted) at SPI Interface.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual function void beat_ended(svt_spi_transaction xact);

/** @cond PRIVATE */

  // ****************************************************************************
  // Methods used to trigger callbacks and client accessible methods at important processing points
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Called by the component after recognizing a SPI Transaction, just prior to
   * placing the SPI Transaction in the output.
   *
   * This method issues the <i>pre_transaction_observed_put</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>pre_transaction_observed_put</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument that, if set by the user's callback implementation,
   * causes the component to discard the svt_spi_transaction descriptor without further action.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task pre_transaction_observed_put_cb_exec(svt_spi_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Called by the component to allow the testbench to collect functional
   * coverage information from a SPI Transaction that it just received. This is called by
   * the component immediately before placing the SPI Transaction into the output.
   *
   * This method issues the <i>transaction_observed_cov</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_observed_cov</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task transaction_observed_cov_cb_exec(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been started at TX.
   *
   * This method issues the <i>transaction_started</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_started</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task transaction_started_cb_exec_tx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been started at RX.
   *
   * This method issues the <i>transaction_started</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_started</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task transaction_started_cb_exec_rx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been ended at TX.
   *
   * This method issues the <i>transaction_ended</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_ended</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task transaction_ended_cb_exec_tx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been ended at RX.
   *
   * This method issues the <i>transaction_ended</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_ended</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task transaction_ended_cb_exec_rx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a Beat has been Ended(Sampled/Transmitted) at SPI Interface.
   *
   * This method issues the <i>transaction_ended</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_ended</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task beat_ended_cb_exec(svt_spi_transaction xact);

/** @endcond */

endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
bvH8M03NovwqGdf6dpZhunxmUG5ukpuz0NO/N8nUULIfYBeYAFmWuxxv9aPZ3CPw
LeK+KWqFTX4q37rLiFYzdv1QEWXq/22VuPtVE8XF6RSXzjElqwYJk4ssq1TbqHpe
nY0roaQOqEMBJ6GV+2x9xWELHc2opR0UWTkynLd8egc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3921      )
69M+S5QMREJ/OwP/6wbX3mxQGbLBYZWaaQsVcWZWlRCAWliP6T7A61mW7HfTRV2t
BLf6l426BxFViSh8U8xYjWDqDHSz2nclR12weGj85T0v4F/HTxzlvT8sSZ/9CXAk
JdN3urMb1De84yz7pOvxCEur6tlG4s2a0Ko35MJyvfO85nklA+pm9kf0vHZ70c2W
uKKid1KBn4kVxxQrqUTH1aNpqVKgaAjm52lHPKcDDiwAftQKm0VGGaz2jx2hXUog
OlitT8johtsXyJA826Uyno3+u4iWBsoBGngan1pEDz9ZQKxfG/HGW+DH9lW2LYK+
j/lfHTXs7rePOaqdzyJH5+OO9QB8XCIuzKQVnxdZZ6RpI4YOKquC780nyUssbQYi
D7JCUTu+LSO/j23d1eFwp65QClJv8IMX8gDxtj86lqhBySSorHoOKaQx6QUGRp1p
J0dfIV0lvH3A15cIFWl51pmbIwA5pFufWIcrY7L7o/YdFDi5YSHG8HF0MMV+xJMq
BRQThsypd/iYupueszFMeSlE8Om2XRAjBXKLeLFCl3ijYyHDBVOrjRbeU+2X2PS3
Hxy5EFQiBFYlslM4MA4JwA54mv91TAUB4Nxn0by1fwyd7fBPRNNdlXDX4AvYutzG
`pragma protect end_protected

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
G7cr3BH1d6sk1sRkPQp1r2Hw0sKs2tKUxf/2F9eYip770UwHdaD2ln0w+3u8lhPZ
QEKWzXsH+5YtLMT44k36SndbPOeoGNRsJUdLSv8R+lTo6XP9WL7fF4sy3loP0GnJ
+FmnE+5RsklyWxUGANAMBJN0aqdfQ0FSFGpCz0W22zo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 17436     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_MONITOR_UVM_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ld4ELq2OgXk+oALGQWPwkG/fvEdFgZTXFJimiu1iATgZVSdkDELCHnrMWqzeDzep
GZfv23yxL0dZZTgBSs4cL1GFT+OFva9nMuoJywjrX15loPcOpEmWKlWruY/zY8rJ
waWu4thIbN6+Ute/Ek1+wIFT7T+EuVlP43lKJFRMHJo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 17519     )
ESUmkb70+fnzsKRHBFJGRiNW77JBeeImVYEG/zEtZla4uxfn275ZunYeEwXeBd1g
PF/Jt1NXbeVE/LvM73CHSCJ8t8nX1I4SgYn/3aWra1W4bXnIRecPwql3v5IU+Thn
`pragma protect end_protected
