
`ifndef GUARD_SVT_SPI_TXRX_MONITOR_VMM_SV
`define GUARD_SVT_SPI_TXRX_MONITOR_VMM_SV

typedef class svt_spi_txrx_monitor_callback;
typedef class svt_spi_txrx_monitor_cb_exec;

// =============================================================================
/**
 * Temporary class definition used to enable VMM based compilation of the layer.
 */
class svt_spi_txrx_monitor extends svt_xactor;

  //////////
  // Events
  //////////

/** @cond PRIVATE */
  /** Event triggered when the SPI Transaction is first initiated (TX) or recognized (RX). */
  int EVENT_TRANSACTION_STARTED;

  /** Event triggered when the SPI Transaction is completed. */
  int EVENT_TRANSACTION_ENDED;
/** @endcond */

  /** Event triggered when the SPI Transaction is first initiated (TX) */
  int EVENT_TRANSACTION_STARTED_TX;

  /** Event triggered when the SPI Transaction is completed at TX */
  int EVENT_TRANSACTION_ENDED_TX;

  /** Event triggered when the SPI Transaction is first recognized (RX) */
  int EVENT_TRANSACTION_STARTED_RX;

  /** Event triggered when the SPI Transaction is completed at RX */
  int EVENT_TRANSACTION_ENDED_RX;

  /** Event triggered when one beat has been Sampled/Transmitted at SPI Interface */
  int EVENT_BEAT_ENDED;

  /** Event triggered when the POWER UP Sequence is completed . */
  int EVENT_POWER_UP_SEQUENCE_COMPLETED;

  /** Event triggered when the POWER DOWN Sequence is completed . */
  int EVENT_POWER_DOWN_SEQUENCE_COMPLETED;

/** @cond PRIVATE */
  /** Event triggered when the EMPSPI Negotiation is completed . */
  int EVENT_EMPSPI_NEGOTIATION_COMPLETED;
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
/** @endcond */

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transactor instance.
   */
  extern function new();

  // ---------------------------------------------------------------------------
  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
FRwDYvzTIw0HG2AWCtXXr16RlBG1xGGRMUcb7CsthBNRb4euGJkD4RAuzD3kSID1
qmF1khQ9jUik72PmXaoefYn1UvwntFb2l/lc11mUV5ktJ8bZg7kuBewtzA9L3ao8
NARxarHAYJKyjUFHM5NmrdR76Rnr1G6/5g4IfzwBnqizhujvxVlAGQ==
//pragma protect end_key_block
//pragma protect digest_block
wjXu2cxg04B61Hy2OWYIrPgvrJw=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
zXZOTyc7CXGNYbNFSVpiU9OUa0o=
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
   * Called by the component when a SPI Transaction has just been started at TX..
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
   * Called by the component when a SPI Transaction has just been started at RX..
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

/** @endcond */

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ghr5ZDGHKkaGlao/X9v4CjmM+MGsSszWzc3DRhnSu0T5JbmUYRoZ1aubFK5LsLfP
N0uwTylKDCClSwUhFWsYMRr0r9ikZM4hJMgbgcR4Y3FHbK9e6hxKOhHVjE0fk/Qo
kFhkSww7SpWztwMh82RQo/hm6w0DosrkkUr1tPv3o8XFlZWaz1sSWg==
//pragma protect end_key_block
//pragma protect digest_block
Ph+dxAzlBFX9O5+O8LynbR6vUcg=
//pragma protect end_digest_block
//pragma protect data_block
pejuI5ZsVnnL3ZiGpEBTIrV9oJ8kLcYv9lwWVtP8eEEjBS1x8d0UKFX79i7R2IQk
h8ZrIxkcLppbCY5CDdWNoF1p6AEHAg6agqoplp0uKkUXYIFbh4wL7SmKTTeZ57Rd
Mh24oeI0jmfwgmyvmcFRKhVOzPgzRJwH6lmrUjtQaNn7pH+NGf9a4iiLK8/xLGMU
t673aNYCPPt8nbKfvRNBqSCpWL7vpkachS/h6mt5bGV/SHeLegHaHij1BI+zhLZ8
UmMUWO338/MUjXIg/O+g9/PpdSsuFbbesNlGwDXVbp/f6afwEXU/kjh32xzsK+4z
cbwSz1tRyx2qSNRO/ck88BzlYHWIIflhOo9yJwQmhPrHg7WfsPCBoSW1496GVE2L
KAx6j3lGblYrcaH/bP66YbKc9PsYcnT2dS4HIEogz2oVDoL/qcrfvJ07FnIY3e/N
QPXHuy4Fkbz+WYsSCTqCgjeCu0PJkmi4/HJxeAWe6NqeGBYsadHA0PeL8r1JKF3y
cID4umBXFyM5cx98vpVg2dALkEvYbpckgiIsLJJdrnSygCX8pPgSYG5NDv4mbntS
Qe8IosmZaai3DT3BeWQY6rRgMme+VfjsJdsdVi8esRE=
//pragma protect end_data_block
//pragma protect digest_block
ubhnqgYqCA5ovLGXoy2ymh1+v/Q=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
LETMwDrvAdPoYD3a7ouTjb5AEKhdPpadEdhPS2fVyAku/85EglRwMrLECfGw/Hlo
VVhFP8QdxwNMGUOTceG5mi0B1tVNl9qyVbgKZRbH5JsEySwE6kG6UFqluH2DRUuJ
HCPBWydWWYGtPnntGPvVbOFnjiuRWH4nOB1eCzALquReoRXarGU2IQ==
//pragma protect end_key_block
//pragma protect digest_block
G7LupKQqs9ppqvXAncBpMAP2RA8=
//pragma protect end_digest_block
//pragma protect data_block
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
JxyZqCGJrELeO0m8nSO+Aw==
//pragma protect end_data_block
//pragma protect digest_block
2A47TsjyHAtp/g464787nT4eS+0=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_MONITOR_VMM_SV

