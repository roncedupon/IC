
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
P6EBm248su9eheQH0lpWCNpBZ5pvXi6KketENWL4V0HGfGPRfHHW8L6Db/Iso8m4
eAtuTWq+lPpXTAm67Rcf0FKYKLoCCTuzZJIAZ7WbRnHYRilQony1YxKuFzvcWA3j
h9Pvhwokgqe8yjqrKeBfxPy6Ae2WkS9NC8+UA/z0duIXgQCOazbX/w==
//pragma protect end_key_block
//pragma protect digest_block
g3yVQJljBLIQ+OI5qmabtJgLgQA=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
EuqoFNs+1YTaaA2V7+Eph77NvYg=
//pragma protect end_digest_block
//pragma protect end_protected

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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
NIHY3bvwzPSBHmUPbgWWsGDWjP66wYp89jqNRZcPgFg5FpU1Jxt5JR3clzeI83cc
bBiVE58+L0x+Oyb+SH0R3G/newA8+/1HA159pWo/gFP0vHgmp6eWY9jF5HuTtDU5
BO+adUcK9Q8O9biSk2+ujp2+JlDiRI25yy1v31nx6jr7PqOtHsxYnA==
//pragma protect end_key_block
//pragma protect digest_block
UT2Kp6Yids5YPUQj9ng1Xh9TIXg=
//pragma protect end_digest_block
//pragma protect data_block
2mVP4k4uqaBO8PIjNymqbme90GrByVFSx28zMZCEFahEE0QAJqvzJfx0WqA7WCwN
KOm5VSRd/p1fGKxQVeAZSOHOfF5AiyihtmfeM9cqRx+RO0AtTzp7qXMnPremi9Eo
ltTsKkv2HpPU5UsumWjcyYJaMfS8XIL1gZnVd06GO6bCyXUqrzEUUpghG3BkKIRu
+dsVrF4qDd7i0I6GUDdhVi/EqhSrQXij+X3pI9X7e+8c1FvzvkT56gmABrluTEW0
qw3mLx7xZdefV0SvZqHRFFHqSIo5rTlE93HZfiKfNn45vEaNqllxEa+CqQ+D1bP2
l8Q1xs1wph/mz3EK0VQUSSyNIxka+9YfElHlWzbpXdfs6+vypmZWaBnwV7qWVfXH
UR0YVQjatYI1zuHeVPthUpbTK86+reViuPsHIKiMxwim62uROrHa4K1VI1yxhRkX
YUGJuifHShL2v9ORlvW53OyMBihZqn8ytwS8ADE75Er595PRR+Qr1mgj4bVL59Vz
hmibQtvhyfmI4qg7oEWzqJlSgD5mE+x7M1gxV5lCt1RcxJG6u1XWz24L5AkYgL7O
wXRgGXKdQB/gKffg91SmtKp0mCiKmUMm6SmC6W4iu47MBG5wCQu4suf4IC+bZ4xn
sHR818KVa/FQmEY8xbmPd7c5pyI8g2QqJhdapnVuTGo6Ml78o9APzotN+iHKRZLj
oCtSxnuAq+og6sfhgC38tPN23unMthnte00rwM7lo9ZpxuoCsltIZ1wLGvaRn/Z4
D8qsUXcirlPPAuBxxVFgcfFmQWyaw12YQHQY7je3x1ejZGNafxNuhHbzdweBFFJW
3STLtU1KpxZBJ7Oirn28Zg==
//pragma protect end_data_block
//pragma protect digest_block
OHNHtjQ9/WIQi7YBLHYrQ+Okgp4=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
30PMZrerbNg3B39fTcF8m0m8cSRmFDDGAwq/5/2os0F0v/SBl2Cm+fbqukX8IN2l
rHFFODPHHNbYNAa14DNe3sdhBybRk6s5PcTbUYaeMUiUxEHAL5zwJ7rB+WqsuyVc
CHBtgYunZc6daVwCgYj4oOShY1JOQXmF8/mt4FR0k1V0zDoFMqUh3w==
//pragma protect end_key_block
//pragma protect digest_block
jhYoLjzKRT7/o1C9L4ESzkXBW9w=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
CCEaydMcdnvzAhiu+xin3Vfq70s=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_MONITOR_UVM_SV
