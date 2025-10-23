
`ifndef GUARD_SVT_SPI_TXRX_MONITOR_CB_EXEC_COMMON_SV
`define GUARD_SVT_SPI_TXRX_MONITOR_CB_EXEC_COMMON_SV

/** @cond PRIVATE */

// =============================================================================
/**
 * SPI TxRx Monitor callback execution class defines the cb_exec methods supported
 * by the TxRx Monitor component.
 */
virtual class svt_spi_txrx_monitor_cb_exec_common;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Class constructor:
   */
  extern function new();
  
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
  virtual task pre_transaction_observed_put_cb_exec(svt_spi_transaction xact, ref bit drop);
  endtask

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
  virtual task transaction_observed_cov_cb_exec(svt_spi_transaction xact);
  endtask

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
  virtual task transaction_started_cb_exec_tx(svt_spi_transaction xact);
  endtask

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
  virtual task transaction_started_cb_exec_rx(svt_spi_transaction xact);
  endtask

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
  virtual task transaction_ended_cb_exec_tx(svt_spi_transaction xact);
  endtask

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
  virtual task transaction_ended_cb_exec_rx(svt_spi_transaction xact);
  endtask

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
   */
  virtual task beat_ended_cb_exec(svt_spi_transaction xact);
  endtask

  //----------------------------------------------------------------------------
  /**
   * Called by the component when Power UP Sequence steps has been completed
   * at device.
   */  
  virtual task power_up_sequence_completed();
  endtask

  //----------------------------------------------------------------------------
  /**
   * Called by the component when Power Down Sequence steps has been completed
   * at device.
   */  
  virtual task power_down_sequence_completed();
  endtask
endclass

/** @endcond */

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
aBSJehRbUAX0p5ANl9uFk1QS+NlO6z1OoJZSQoHuNLOgWITFPTsYSYG4o/ZH6072
IylbGw6qQss2VD/hzyLe7GAss5KRe2IVHsXxPM3+y2XLKv2IH8KNYGRYldzIuO4F
0DoFKE4CVp0LrgQdoJ1UBE08Znpd97EWFv/FE/LVUjo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 345       )
UFYQIsf6P91sn3FP0sb8AUZ/PjQe+vH1oRfwXLC1gTDjjl6PwIM4iSZAm0FY1ufq
QAYZ362MWWfLa7Qro81q5IkWcuPIytdlY1VD9u/25Sbj15+mkqorLRnfxTX9/CEd
4nP0J9Qls94c/gTb+y1cTJjpeqSJCsqnCdoM+LAKePZQtOfkT9x0HfENo76rsaPf
A/YgtLGtZyTzaomBd4AcCj91qxPwuyN2LO7HITxa1uzzB+ZOFsrZgVL7KXygIJNU
lbTpzqZVV6xktiUbPlgYF1hN+WC9tvMaSEHVE19GH7Yvt7fB1aB6twZk0OQ1QmKb
p3ldwXJhehlwcwtKFyjdol9hxt+ZULD3F9Luz/2ULxkuKz6QKHdgP9dc+lvx5yOI
nGiJuYKHXqVnUj/r2LoD2Ui1Gy1D5qtWftxRM6VsGjiHOwf887LbMFhv0aj4k+Rn
xS8dy1KUesFsauWn2u4vBA==
`pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_MONITOR_CB_EXEC_COMMON_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
g+kOXbuv+h+lAfIGCzdWsPIvEP/STMU737Q00v2mmOhNZB5T+Ywcsjv3vqncxIT+
KPTs6coAsOMmfESCjP1P5HdLPWfWer0CTQcqem5eUTRpdaiu79r+MiR5FuVqPyFO
znfhlqYytxl36hnDxt5dLrspfAE75DAeGxxwUTEx31E=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 428       )
XSB1EAGCPBsQ+jRl9n9rpT9cVwdkYl/dM+D6ZeJcHNFTq2EHe37kaX5JNYtGYMId
1NmhygbMBeD4/dgoyj/K92LMNuhGHJbGBPuVA4lUgZ32dAT+N5zEYaHzZRfwiqvD
`pragma protect end_protected
