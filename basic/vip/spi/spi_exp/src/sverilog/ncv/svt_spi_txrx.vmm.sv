
`ifndef GUARD_SVT_SPI_TXRX_VMM_SV
`define GUARD_SVT_SPI_TXRX_VMM_SV

typedef class svt_spi_txrx_callback;

// =============================================================================
/**
 * Temporary class definition used to enable VMM based compilation of the layer.
 */
class svt_spi_txrx extends svt_xactor;

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

/** @cond PRIVATE */
  /** Event triggered when the EMPSPI Negotiation is completed . */
  int EVENT_EMPSPI_NEGOTIATION_COMPLETED;
/** @endcond */

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transactor instance.
   */
  extern function new();

  //----------------------------------------------------------------------------
  /**
   * Called by the component after pulling a SPI Transaction
   * out of its input channel, but before acting on the SPI Transaction in any way.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument that, if set by the user's implementation,
   * causes the component to discard the svt_spi_transaction descriptor without further action.
   */
  extern virtual function void post_transaction_in_get(svt_spi_transaction xact, ref bit drop);

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

/** @cond PRIVATE */

  // ****************************************************************************
  // Methods used to trigger callbacks and client accessible methods at important processing points
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Called by the component after pulling a SPI Transaction out of its
   * SPI Transaction input, but before acting on the SPI Transaction in any way.
   *
   * This method issues the <i>post_transaction_in_get</i>
   * callback using the svt_do_obj_callbacks macro, as well as the
   * <i>post_transaction_in_get</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument that, if set by the user's implementation,
   * causes the component to discard the transaction descriptor without further action.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task post_transaction_in_get_cb_exec(svt_spi_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Called by the component after recognizing a SPI Transaction, just prior to
   * placing the SPI Transaction in the output.
   *
   * This method issues the <i>pre_transaction_out_put</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>pre_transaction_out_put</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument that, if set by the user's implementation,
   * causes the component to discard the svt_spi_transaction descriptor without further action.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task pre_transaction_out_put_cb_exec(svt_spi_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Called by the component after recognizing a SPI Transaction, just prior to
   * placing the SPI Transaction in the output.
   *
   * This method issues the <i>transaction_out_cov</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_out_cov</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */
  extern virtual task transaction_out_cov_cb_exec(svt_spi_transaction xact);

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
   * Called by the component when a SPI Transaction has just been ended at TX..
   *
   * This method issues the <i>SPI Transaction_ended</i> callback using the
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
   * Called by the component when a SPI Transaction has just been ended at RX..
   *
   * This method issues the <i>SPI Transaction_ended</i> callback using the
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
/PsA1AgauY8qJlj59wMiEZNvAcu3r8rx/GwaRfvth4RKY2XcFJoGE3F2B6D99Mzm
b+BaGPhumN2+Ax1QrwhKE3uKL4zfQnkN6t3QBwDYwgMq74WUS/AJwkqzaaItPEhh
jBqjjC/Ldx76EVnmHS8KJe757sHboHdFwFPcztxL0706aAA2gPEoTw==
//pragma protect end_key_block
//pragma protect digest_block
2ib6p7CseEhv+2Hjw9E1EGIrneI=
//pragma protect end_digest_block
//pragma protect data_block
0zobYhog7WigTV2jgQEXKmeo5vQAJcwuY9FylggxPwyUw8hiNI0IOeI/McQbp1jx
yCtkvRtnLu7ZFLVCyyGIZLnQXiue7izXrcRv1Af4EpL5WSiilRKxov0dfEj4Q9T6
C84vXZMqgWF/1c7l/dNTg/XzDzpWsjf0IAeYBqzINgptZUdB183szxe+CypV7CMT
L9snWK9zIA+juuP2s9SsKifaJz/D8SPWYUUIsTn66I0vcdAaHd7os7oT5ngY9j4Q
HK3HStn9emqH0eEK50FQj4RVKYhwmoXAGDoPOS1sTpvP1uRaHJvN/+9PD4YitNOF
pd9qmmboKPH/9cnWDoVT7JTZfXf0jhTNTf3GFvOLWFS10ddsed7yB1PR5WqV/8BB
qehdXOy3JDoDfwL8vj9TumrmaqtQY/HDeKWrBHi+UNzpeZgs2mfw4fSfIdJm/ds8
qEMPfRepVp4bRNzOweNqCVe0Mv6DuLw+VMEyOFeaIUFrvTDQSWWdmVUg2wtXZVOV
JGE4PV3UYGuftbF8HHBbtaDyw0v2wX+I+m6wEwXUO2LBcBgN/pvDMPMxymvw2NTW
7VMlafKlZKWwTrAp3zMkLQ==
//pragma protect end_data_block
//pragma protect digest_block
WnQIiI/bd70ecgNreEEFFyzDZLk=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
vftW/L8muf1Vjok4Ne4rO75Whm99znoZol5JKmm5f++pHGkkeKUTgwRvnU6BHsDs
G5O8xwykpgvmKVe4D0f+SfnMjMpl/teJ/3uuGV5YhTJ+xCBwweoG39h28lBXBFQr
30mRIlgyCjgYjHtPbpw+oj4D2dlMZyLBD4gkmC8JAufQwzISuhltJQ==
//pragma protect end_key_block
//pragma protect digest_block
spSZkepS5lyFW8bXrRHheFZRReA=
//pragma protect end_digest_block
//pragma protect data_block
+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
//pragma protect end_data_block
//pragma protect digest_block
EVtXySt1GSU8kE/hDK05DfLOX1U=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_VMM_SV

