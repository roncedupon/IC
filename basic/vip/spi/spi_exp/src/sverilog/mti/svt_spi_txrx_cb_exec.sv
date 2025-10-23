
`ifndef GUARD_SVT_SPI_TXRX_CB_EXEC_SV
`define GUARD_SVT_SPI_TXRX_CB_EXEC_SV

/** @cond PRIVATE */

typedef class svt_spi_txrx;

// =============================================================================
/**
 * SPI TxRx callback execution class which implements 
 * the cb_exec methods supported by the TxRx component.
 */
class svt_spi_txrx_cb_exec extends svt_spi_txrx_cb_exec_common;

  // ****************************************************************************
  // Properties
  // ****************************************************************************

  /**
   * txrx component which implements the callback methods.
   */
  local svt_spi_txrx txrx;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Class constructor:
   *
   * @param txrx The component supported by this instance.
   */
  extern function new(svt_spi_txrx txrx);
  
  // ****************************************************************************
  // Methods used to trigger callbacks and client accessible methods at important processing points
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Called by the component after pulling a SPI Transaction out of its
   * SPI Transaction input, but before acting on the SPI Transaction in any way.
   *
   * This method issues the <i>`SVT_SPI_TXRX_CB_EXEC_COMMON_POST_CB_NAME</i>
   * callback using the svt_do_obj_callbacks macro, as well as the
   * <i>`SVT_SPI_TXRX_CB_EXEC_COMMON_POST_CB_NAME</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument that, if set by the user's implementation,
   * causes the component to discard the transaction descriptor without further action.
   */
  extern virtual task post_seq_item_get_cb_exec(svt_spi_transaction xact, ref bit drop);

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
   */
  extern virtual task transaction_out_cov_cb_exec(svt_spi_transaction xact);

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
   * This method issues the <i>SPI Transaction_ended</i> callback using the
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
   * This method issues the <i>SPI Transaction_ended</i> callback using the
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
   * Called by the component when a SPI Transaction has finished tranmsitting its last data bit over SPI lane(s).
   * This is used to update the data content dynamically while current transaction is in progress.
   * In Master Mode, additional clocks will be generated to transmit the new data bits.
   * Data driving to remain as it is.
   *
   * This method issues the <i>SPI Transaction_ended</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_ended</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * This callback is currently supported for SPI-Bus mode only. 
   * Only svt_spi_transaction::data and svt_spi_transaction::data_frame_size fields are expected to be updated by User for this callback.
   *
   * <b>NOTE:</b> Any extension of this method must return in 0 simulation time.
   */  
  extern virtual task load_tx_fifo_cb_exec(svt_spi_transaction xact);

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
aMMtO2/ainV+kw27TRXtu1FC/3VXc3NhDpflYIcz1lzvrLGhiUbCeEHhhNCDKOLa
yOfA/OUyXK+5OKMgSmDqo8bqNruZvc+zfPUx7zzgHupjFTusYr9edja4B++HMS9s
hQZCvRiYzKRmaazM7d8wE092AjAIy12PaxlbKvkjPEQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 209       )
KWe3CdtsHLrGvJB5JWG5LIP/GQqGD4o+QYujR7wniiTbpSmUasEL7p3Q9ONM3pUD
Sfc+C/5ZbPqZb68R/fY/Y4IHVHycRjz+lwlUznSw8B35UL3GzDoG/jbsjI+s8r1o
FNq0xQI4cqeJkiyjwYmDK8b2RpwPHLwO+NjhTW/ezrcwP9HN4dni+9oUDdofv8ix
48kfn4pLzk3/n7TZZkgV83buaiz7BBDr8M0wBplAGHZtQQnBO4ax4wHkbRkJbAZW
0q+JLfdovXbqrobTlrmliiGl8LuTCzCAw4bDDnyo0Ig=
`pragma protect end_protected

endclass

/** @endcond */

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
YYHvM3kKc6DP9WG7eKLp4xqcTvTuVNdqYXQC0BDKK8UwM8E0bGAeo7FLEbwaWrbv
OhbqNUmQNBjAuzVfVPl1r2pFh3Prpoy+6Nxvw08gHKlMpUtMnMKIdEwFPknx0lbh
fNV+XRZ0kWDtRXcKfJt6GINgZb4wDZ7+G1sr/fKnGX8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 508       )
qwMC4QZQjp5Y/8zHNdirbAxChsDT81BQjZAuy4FKzxTsz34XwltXygaKieI1JCX6
g+qLhV1zjlMwYeDL1/QCk6GiJEJq9g/vldEi2M7zGGqvBi6MRqc8lDZnuGGDPPAs
i2EWXrfF2bPlar9R6WkMx15lof/rp1J3HLb9+MOpS41AKKSA1lzyAJ5ovu4n1TKu
HDGpb74yTKataRHPsotfVxKPsbqfKMRotbDoSZvXuPMQAYaqmmcU/VWcUpY6u6ot
xsCgxgXi9CDJbHQD9KD44G2B9ENjUIcrvVNupUTF3MtNK7hiztktRg+M/C2mQ+J8
XhkXwGxsH2xn07dWHJLmVHsPn3hGrDSrOQmBlbTl3LRhZnWfCevByCWu/R6NJISi
41ZmnqBPRH9wLyAbOBj+8w==
`pragma protect end_protected

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
n5T9qFUkm9AfcASP4Jv7y10QqxWxonFdq8q/Jfoebp0NGaDpXBGo3xE0CiFMqCwf
8xTjCK9mCXWhK07oGNa3OkTvH3LDHq59Hrinq/T2z2PVbuNi1wCT7h1bGufPYYbN
x+F92kwgDORnlTAhtFK5pG6AL3Au2XBDGjhNItJc7ic=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6004      )
+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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_CB_EXEC_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
WzoqgFNswVVGbqtCuiZct4oEk4LEE1Xch0fBlgt1c/hD4X1vR2Z92HGbRhSO34AB
iXYPgSLdeRoG4dKEFHJNNdXK9pqRl1KFebFHLF7sygAuU9OSKbGKjH9TnyHsm9fs
NfQGoLITAL6vuGfG++WAtTWE34fBgNOplHM3Uax6gWc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 6087      )
vRQsBOh76iS01su5FZbXMz8N6tq2uy67s1wfIcibgcXZqHDpMCEyi2M148aiviS3
X8TrsI04Jufxt1lElMkH307DNZ/zLuloUtD6c1hwbSFfeN1c3XeLJXlPfVvvKkGm
`pragma protect end_protected
