
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
lQIDmcemEtCQRAu71gxIoSVQGJuOHxWk972Lc0UmOhmcY7PB6HGvvdlcHykKVnlL
zTSuz++pjE8TBLKymbO/I7ljOQDKreDrWIhlo9Pl213tuqD7/r7wMUAH2g0tZWus
NpL4CfBHIPc4VTJPj3UTSPciKNKkPuWZYKj4SfHsnDjKqosB3ozuQQ==
//pragma protect end_key_block
//pragma protect digest_block
fSxwZ0yKfBCAcr56liUUoHxqwIQ=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
GP3J2UGgumjfzSw44uYaYrfZqB8=
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
C0xXp6SMqSZeY41PqTG5I/liOSGZGbzNp/EOKJIxJ0LJ/4Nt+cDkuqyalQ4ZnsLv
YCoIeslfGQ6kw9/Gc1NYdaroZxvJUPv7Aa7inUZ4sXOwiu5cEnOasD5WduYGvHx3
Nq1WHpDEz2jvyAPulFLlr2GfPKNtyrZm4BpBXO7p3GLgmg2qz2xgFw==
//pragma protect end_key_block
//pragma protect digest_block
Z9YS3QcumPVDdy/RNRFcwheH/D4=
//pragma protect end_digest_block
//pragma protect data_block
GIsBtgqv1XtSrs/rBxqe8wao/eilVhoNJNIwsPGRJ5qGOetP2FIMfXWrGY/8yqtH
LMLsEgXFq4PjvuyfYlr/eR2uuSBAHLs2YOfJb/MlvOOcbdV68b8MHmXagUZwV5nm
sy9E4UI2g3GPmlQZrcf8vigw5Dmmrkd29SD9Mz6ak4qHLbQRBUoRyJ1YksPETwr0
8WJQfFTYdkDDfTPSUM2UzCpHTrBsGOCYW091h31dsJdpsEAOIgBG+8ScuWv7Fu/g
davBHoe5wx+mQs1jqmLmWSrPjrSZF+2EzBc1eNmVUDNhNAJEsrNMFfyrxpKmTAg4
A5D2WVca+mL3jHWH8mg89PKQv6h2GXa4+hFkoGoPx5Cfl/0OB97R23Nq6OewwEVH
o4r/l+gCLZp3DEejh3Zw8KV4xUyM+SrAem3sKXuhxuzkgCfVpHp2F6e4V0yZH/SH
sgEG2zDfHK0v4dlVm6q1qwd6IzQWAoYQho6TgYJP2GVk+h/kmdY9SL62u33mgGJb
GGYI76bI1DcBxyLRnc8742t49UcGsrGEK6Z8/znHucrKAMbG7xDYCEfe/RHZr80A
OpRaxMTITyv1YU6zWkiq87sIqu4QNC/ly/Cly9KIfmECpZjNyoqJbVyAspAgf0P5
6c6EKOTLnf22j1NHNm9VMxDTT1oOq7yk+MPcEyWrQ98TGuBF/C7gJnfrqVHheDlz
T11bAR458bHfaB1RDMz+ja2D/55x+rKMqa0joG7Hmk008DcZNsH/dlUsuUIPSUWh
6ZjJWRq4cQFCpjXa9BpPXmrb1hmirVuTgIt91bDD5cFyeUsLJsy/7kOxLNp4kI6w
V7UIOghyG2qVGfEpcsR2Bw==
//pragma protect end_data_block
//pragma protect digest_block
PyDXg+DADBhXdKcy5+x20qoce0w=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
4hcAhuqXw1EE0tdWSFcoZXjlCFOtk5u3GYENC5zEoZK7StI3ZCbiOvlc8ewE7NM5
XYUqllsu5i71d1KZwkSkDMq+7ZhbnI5MDdLtzZWg7XH+vkIHvGBLfk82MHYbU6sd
exYGokHp7LYISak7mERFFlWScctFzozvaiq2lbJ1nYY7OZWPrZH7Hg==
//pragma protect end_key_block
//pragma protect digest_block
x62m1EaIdXUPYHWs8ALnFojOB4g=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
mGA0xw+GJ7bYeWJcARdKmADOaAs=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_MONITOR_UVM_SV
