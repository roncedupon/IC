
`ifndef GUARD_SVT_SPI_TXRX_MONITOR_CB_EXEC_SV
`define GUARD_SVT_SPI_TXRX_MONITOR_CB_EXEC_SV

/** @cond PRIVATE */

typedef class svt_spi_txrx_monitor;

// =============================================================================
/**
 * SPI TxRx Monitor callback execution class which implements the cb_exec methods supported
 * by the TxRx Monitor component.
 */
class svt_spi_txrx_monitor_cb_exec extends svt_spi_txrx_monitor_cb_exec_common;

  // ****************************************************************************
  // Properties
  // ****************************************************************************

  /**
   * TxRx monitor which implements the callback methods.
   */
  local svt_spi_txrx_monitor txrx_mon;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Class constructor:
   *
   * @param txrx_mon The component supported by this instance.
   */
  extern function new(svt_spi_txrx_monitor txrx_mon);
  
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
   */
  extern virtual task transaction_ended_cb_exec_rx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a Beat has been Ended(Sampled/Transmitted) at SPI Interface
   *
   * This method issues the <i>transaction_ended</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_ended</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual task beat_ended_cb_exec(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when Power UP Sequence steps has been completed
   * at device.
   */  
  extern virtual task power_up_sequence_completed();

  //----------------------------------------------------------------------------
  /**
   * Called by the component when Power Down Sequence steps has been completed
   * at device.
   */  
  extern virtual task power_down_sequence_completed();

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
jUyAC33zmbIAPmdmpeS2BS3NX/0iyoiLAh6xNN3rELo/44fZ+dODU8MyV5X7ZM5w
mSr+4rr5sy4jMH+RxDat3OFMJsRgzXY6khNcusLIAXGOOx8qhrzaTKI2lB3+kicO
fBw5EAyaXHzgKIpVflNNvzTJRp8LFCV+b5fdDPrHLII=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 229       )
v8NaW8hIc/06VwGhA0ykEjMAeaURbyYqeRw7qvLCBcoWiDj/1uGwENxKalNM+jlQ
IIwAghWqlrfv+G6LkO6EyC6hWJ+yzDLX8C4x9xC6bf/vX6kG8hLpuW5WYqjyd6z2
GuAc1IDW7uqFTJuMTGTjfjBvXEOPHIMWeXFlEL81+YKvvWcnuxp2DBv02cVCXvby
6Usq28kQeAUDcMp30CrAAiMNdjiD0Mq4yA4xrUwVOH43f6ubJSBkggAhBdLjn7YD
kkEZu3mhBNxyQrTvxcI7xYSs6aQ2rbFMElXjwcF2MkxkXy9zLU4vbwbqf679wdwn
`pragma protect end_protected

endclass

/** @endcond */

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
mbvlyTWXCkMSVJ+D2YvoTwlCGP/KLuJkjiRejNsylhLeT1KBJoOfEs22hp4RFS0T
ZOc4Ur5uzawlHMiJOQ4pLT92yt/yWfHBSm2EqlW3D67Px4c0cpcEWL+Tj3h3Wvl+
YxVXSwDaRB9E9c8AlVGuKH3jBPgGJYBaOlidsyeVtX0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 556       )
VjnViCg9AOwqwEWubpc2lKoEiMqe3abGhk5sauiG/0b4r9PSE+YixrlPx0HLPMoO
EX1oomTW9JvAeokDdnmBZu0d8wIqAWVEds7vYlmBSxXf9U7HbbDjlF1Z/inTo++V
/QUx7aC9RjCt3thc9WyeJfw3DYjBaql7hRtMhHLOhh1HuvgJ7uoSosA1unV5VnAP
Pz0Pj9OhFhltVaP1X3g8qdF69TTHjyvKJ0i3xKx9TrbD7LpQynzHcwszceHh2ta4
TmaFunhttvNe4J7CNxwaK7S3FbRRnymtVkPEKtIpq790SJPm9NjUfsWzHsPTylXw
SnOsKPxtkhbNdUvnIlekKeCeHm7zza9uAbFdtYjpzJhIs4Xe92jmLPAU+jMZNBdq
bJmF6QlKbmqWpvOyqsVrIRiYOO6Oyu5vNM1KPOEuJfIwqh32JO8nIAxg8HBeiQWp
`pragma protect end_protected

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
MlLLH+pdRCqRSs1/mIKRnl3lqKUthEK9u9n2bCyG4S3BjpyHP10V2O3T4GkL6ay2
o5sH/3pG+r2q+NZW1nMvgiYMkgDvrFFEOP37I3tj9aX7jHvD+jZ7cEYpj3EhNOMa
det5E7DhlwA100ZGpltum5172qr6FuOlqEONrhJQuLk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5722      )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_MONITOR_CB_EXEC_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
K7aLkzEsnzKt2u34QZCOQMHglx7GxMxaFu0oGmkgMZ1rN2ihF+f3uDV+ehnN+vNl
YGrZF3JxcLhyTJ+bWYNUIzJZqKaAhtbulSLUF8gTGlXdogw/mLpe4DftG1gP/7Vh
5moO+Bydx/h0o/N+/NmuI9ACH0RSg+flrxenu7IN5pw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5805      )
/+GB99VL6AlqIA9n3vl79LNS84WDvJWj8WPTsPlWO9hojX9DU/YuDpDnYccrRyXE
sTHd4tSZ44tiMhNRH3avCPJAy5p3jXuNP0x5KVAg02WSn14pvWGcn357uAp/OJlb
`pragma protect end_protected
