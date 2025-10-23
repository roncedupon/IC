
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
L8ay71h0BMSQt3n3OUoWdomvfAJGe7aPOwZ06SsZzzcJN6Cc0jRba9v6d1fAzEjW
x+MFtaNlK+DmubjSDvKt3tZ8AJDBSqbVz9f5oEP4xFGx3HTmDoNvs7HGd23qSA6w
ccuS6IlA4/VfFkVKsj8uSW4alnR1jnVm/Ql5OVuUKZc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1388      )
eZusZBF2EkXixFH3I6BxwcQ7SUr/R57AM+Gr3Pf/BEBovAvWvGrp7K24pZqGjPkf
VKJgVooQz3wPmSVzmeYWKPwtXyHL4Rjz6oo7c1fOnsf0uO+jTx4rzQdyXWJ30/Y9
i4nxRb3sDgWgUakSqZQFRdB8So925ljEIcuS5PAogeUKpzZluXx8292z04ZsoEhK
yrPYr7NKTCLWqtN5GGCMipxUgsmAzfRsYQ22DxEmiEiht520RIS2CbkkPRTArmnn
+ash+hF6JwcSiqOoQqjE2/kZBJE7Y+v8YjFg7yBGcvAvj4pDGvS/TpoFRbO4wgDz
9lcUaeSm80qoKDpWhY2VOJKpQGi/0q/JPUATlm+PnUZMNvs+4S6RGbX7anDeVWXU
bhgap88oCLFD8IQzAvZhV0Jlp1kLnaXGKDw0KJ/aykkRIqDSVYgpg9S/gj9+zZv1
faWlPm03KsQzvPVmxd5mAxl4xy9BB73WVdWcLLNg1hNICEqsKQZkPVIKKHYXqPjL
iDd6yMD9R5VgYj5BrbvVRlSK2k6ivrj1KScJV4PrCfP+F+Y2wSjg+LgeO5s1WIsH
ov0nQYL1zCxmEUop/4iiXIor4v7SQRCCvgI4xmUFihS+MyLpmt/C+zgHXI5XPTVe
ipBggXpPke7MJv6fB1y6Rl/4BrsgXv3LFJXa7SF7DdXTiY5s6v0qf2BDbsFFPQ4o
W9oHO5qtdDQOOnF/U6p8xM6sPR8lfvCWoCHYho54kdLoXfv3l5tkuiINMGWocj2l
0d03QCqVmt7ho4dPAu1agw/U9Nbwtft55ZhLXQqzvQn7saf/+Ike1oh9oBpzoDrN
yCNdKBQT0fuOhIajWPQq1uDAPFncMtIXpuDOG9md12Xu2ELJUgC/hlFbyRQalXZq
vDiNpaQQOfzQTE6bIJEE0QUHIlM7jFEX8cVD7+U2xQz7N+/aEDftiRW6iRaWKq4E
+pWOIw/v6tcBrjkDVrWmuanFB80bCZ3s8xijMZo01IRTxl1ZjC/eQ6Z17YJUZQWV
KIM77aC10CaYXEb/lFCgmp51LhFYPH7nt4A294P3RVwfbWBJmgJrJO07qNAEY3ol
7jc9jApTgz9lKWengSIo4i3/lhgzajOuHFHhhqmnXbTWhZqkijV8R9eNlCZMiojU
HOSUkB6q8MluSwn0pVjTxbmtODNbkuGG3Si8iJz2PZxsL18bMlkqC8aixcCH4A5G
2F45RZDdsZYnvicqNw1Jmx38c6LPnIL/7BDaBMgxxb0ZbmzpMYhWrSn5bJAGpyMH
hFJAxcLqlLNFOTbQ2jgFFpl2BTvNNHnVNNPYnrEvLJ1v4/JEse6y2TBmBE40bg+l
KNZlx6Q1LPWPkPvkz1Hs757aO5juA8M+WJBab0naHJlTZJbSGdeDtSvwEWNiV9B4
iQN4wZnFNewPGxVG2D1/0V9NOLYR11qy3BOtG1THfSDsOsnUo1qwBQ3mA7MsFTKc
Jj9umQM25B5NdpaTv8GKZP35qVHi7YWbZkD7mu2pZdBOxa+I2aDjRB3EoZXU6QfO
VyimEsvRu1dyK4ErDphY8NKqEnu/27wBwnbuPpMsx6vY3zLcdCJP1VW44SJIAzFb
vDqeout8pOaahBLlKyYtoJp6iBx3u6azgMVsgwm4AnWZ1or20tMYZRJPTCjYRvN1
/Wv1CUNsENAxPKSeGS+VgY7IbmyT6jefi9YEU06wub0oclniypz8SgMKoDZWUpKS
RNlejOaeyEn/xXLnMzzKpwW/Av5Wl5QZcpa4kCBrSGikVd39vfcdoBBUa4PPZ5ju
fqjftX4wJ6iTK6NFK4RUFE3ewKovrBWOveUqh/VeK4YmQrUQylc8CZ517TXAPbF9
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
FsxoPuHF+B68KDU3nNiRi3nBXbNpDIJwh8K1N8Bddkt5pR0C5LY0rShUWgISx0uR
zgerd8rmssG+/Y6Tuy1M8QQJ8SuTuG6pkG1ipyRLJY0+gVGvzjf2DA7R+BxwYQdb
FeC9FC+DPYuHE8NCsVv9Ptth4h5boWWTPL641PD/23Q=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1687      )
HbvIelttL7p/+boDUFC8FPW8VI8ly/vABsbuYwBH35I2D/FUxOlQrXC1dF+XGUor
0SVrKhSattUgJk3ab1nrFqYBTkYwEQMbEh9G3BC3/mWqwN4Bn/s/Forb53V8NFqi
rbAtSDAo8X4T2HbDflpWas6jB33y1l14gEBqZo8hanxnjX7aMJON7aeYTdLYcvo3
ANI42pdrQ2/IfJ75DqyJiRwRAcO8eJvuT7EEBE4/Q5dP2V8PuiONlUWmeOCgdrf1
yD+5xKy2Hgjq4uTM7i19tj37EmW12qJ6aKnHUvybAB0q5/XTMrI4NCjmC1zhg/sK
ISziJuLABeKgm0/Qts7Qp5miCUtp2/+mB78DxmMopqssK98vQuWsDY7czU9Ej2IL
cLMfzLymj1CB/VhzCJ7A9A==
`pragma protect end_protected

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
YcKhOIn28x5VvM8wpP+dQXjZ6v3nRP0+B60cdhBcSSKR8tbZBw/huuAFFlrkkaAd
VFpWcKKus18XkqDTPOuLeA5upyHNZX189JRPQfXSi7QfFwarA+XxQfrISiqk8Ui9
umI0Rp4fSupx+gLcFmhPR3l+CkNeu7yAD9M7F42vpHE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6337      )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_MONITOR_VMM_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
c5GxuQQKmcZsHvgNLoVAsKzlBlCeu675MOdbgu8DGHMLjlG9rUG3TIKIuvTCJ3Xc
MZ1D8LFUL0OvKku9VzEMrtVN/BGWP9jazfBncrLtJYUlO9Tkf6/nBL9a6jfn1j+1
qj7O9PDW1zV/oYMsu8Vgo7u4RefAU18hxQehjlzzH/I=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6420      )
Coqh/+J7xJ+6Zki/WKbdWFsRVyGSZYmM6tB4ilR4Ol/eiNdaIUJvh+fNfnK9VYdE
PIOuwelTV2YuOF5us6NTDAhIPNoM80OcuuJc7RGfZIoFPFxMIDEA6WTCSIPqiXI2
`pragma protect end_protected
