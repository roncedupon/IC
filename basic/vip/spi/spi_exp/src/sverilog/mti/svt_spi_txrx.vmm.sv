
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
n0zdAq93QgDAPQGZZpPilNg3nfFJzodW17y861d0+pYgV3pvAcEiWv99NafONE3X
J31DIoeZad0qrWWXr9XxFAGiCB7ycMx2Hagf68jecEPBtLhll4hmbZmR/G3wVgg/
sux1RZYNwbd66ZoS3LUOhskXca6qTr9dYy0lEaWEODE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 283       )
aO1Kum1eVO5DrrNsHqEtYqeBiK8mvId67UigwUJmfilsu/VdINJSpAPb0zDc/TRv
M9+YE46a6fYqa+NhqOaTD4UbtiqF0kBSv36JFImZxF9/jBvb5kZMFOzlfNBq8oeR
chHbTMCHdIJn4tcUUFY+kbeTOmMiEqFVXKe1qnorXkVLYQkDHaLZTndQiWdZBUX7
f/Zhm+RvB5yGO+YTwhCrpOpkv9vq9Pb4pGmS05pzeUf/JzF2mEUoU+JYmxcotbhT
zT3nRrEFnqDIupDh9GitlWMDwMxYuYu3xbWjqJ0LZLsk3MbPNcg/3I5IKZUq2r/J
1NuzhiEUoD/TGBKamm1op3Dz+1tCfPdv72UgXyW8O37qj6KJOBS9kHHSSvUwiMTg
`pragma protect end_protected

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ecSZHst5GmmiJVsKp2s8CSgMFAnZtnFKEc//4StDsmobcU2lyatdR7Lp2KfhX1Zp
ELIPZILmmMZ5sPV0wkeyPl4oWz+eL1PqLYaVmo/NlIDiZcHK2GB8MBm/+9iRM6RX
5fFLwa6iRLoepjrHGeD1cJ+eamwFRBCrJ1zD0EQnp1o=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2453      )
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
6NYuoJOUKOVAw5aU/RnNIg==
`pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_VMM_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
fhC8YvPJTENBijTY3jxWxiKlUg6qDcNWifopj0p3CW6OVuuKucqxACLsNvP/1JFs
xgPnlChocW2DxR7P+fjqHyZwjWCWzwVreg0A0M+XFltfew28NHp1JgTjhSf9VtR0
LWeIMPBfiX+EpUptokaHB0AWNo4BXZ843vLX1aoNzwI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2536      )
nlYdNa6nqfqW5xYbsLkXqpXR8+0bMnl8GMxFyI465g8vx1LJrx/KeoF/YShI2kDL
cn8RE5NJMiEwtCyW5dryokPvbCyRgsYlphcVDsPgVqnhRflRIhX5yZJI6QQKgOW9
`pragma protect end_protected
