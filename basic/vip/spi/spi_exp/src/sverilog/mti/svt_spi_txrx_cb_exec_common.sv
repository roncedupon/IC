
`ifndef GUARD_SVT_SPI_TXRX_CB_EXEC_COMMON_SV
`define GUARD_SVT_SPI_TXRX_CB_EXEC_COMMON_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
hTlJSR6FN/RO4DoiG+IHx5GwGEARiypgvPWHU0v6nCiNVozamFSWo0bMtnK1ZOIC
DntI/bEAfEM9uhXsev7taod4MkQYFmAnh8fRureI/zk73VR2xI+4HjXLPlSpQBJz
1OhBrMv8ttoV6kYbymYmGYW7dMAySadxILdmGA6Exi4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 450       )
8cN6XcxjFeUUGR57ktxisIocVr44TJCt8f/PqRv9rYwDHncR5UomqmCYCVPtrf9Z
0U6Zl2EXUaip17sPTDAT8c93ep6NpfVVi8NVIH7OqZv1YPPKZoe0Ra0C+aBsNO8F
WTIvCQYYzGceUdzBYyL2XNBqmwwQGASpuc7WvIqsQh+L5emutsLs2p+1E8/9kHII
rri8DBiB0BORpMqyl3elMf+SICJ5A29FFXWEgJkdRQoI2LTMYlTQbQtzjlaC9x4W
8RYEMAyJ6O4ng11RqpXIJkYWezKPPopVKga4WqiT5Aped7AXPbH1x3Z/LLlUu5Q6
i7EvK/Ls/7n1IqjxbVd4cpWP6xhMwr61GnjjGQM88MTAogugxt/IGlZRSJz2FoAn
a9k2cRAd8tXYn1ntxV5+YCMHVyOHk1d6TVcXP7SEhjBkcbmzLY09jhAs9OuiJWsO
fhV1qpXxOAjFDBS0aa9oX413HQnfKAlPY/HUCVkydUvQ8uSg+Uw2qkfu+iIDPLMm
gntJExo6eAE/6BjL9J/N1H8rQuRT0aAKbvv+30sbVLI/0A3NdEeFbjFQ9Pkvxffq
EuOGtabZbdk13VF5BZac2irLDnQugMURLbpA9ihnw+Q=
`pragma protect end_protected

// =============================================================================
/**
 * SPI TxRx callback execution class defines the cb_exec methods supported
 * by the TxRx component.
 */
virtual class svt_spi_txrx_cb_exec_common;

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
   * causes the component to discard the svt_spi_transaction descriptor without further action.
   */
  virtual task post_seq_item_get_cb_exec(svt_spi_transaction xact, ref bit drop);
  endtask

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
  virtual task pre_transaction_out_put_cb_exec(svt_spi_transaction xact, ref bit drop);
  endtask

  //----------------------------------------------------------------------------
  /**
   * Called by the component after placing the SPI Transaction in the output.
   *
   * This method issues the <i>transaction_out_cov</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_out_cov</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  virtual task transaction_out_cov_cb_exec(svt_spi_transaction xact);
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
  virtual task load_tx_fifo_cb_exec(svt_spi_transaction xact);
  endtask
endclass

/** @endcond */

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Vz9FetUcd6S/YwOqwhYxlB1N9sHZYW0sh7k1toYlgQARW45mdJMAvUTKlydtoEaz
qkP4a1jOiHY8a09m7U4lgj5/0ti0Mb8jaK3G+Qw5Qq02kUptsNfcar9LlPhNFXAL
1rJQUl97jPH+kmuSr8eudEkea1q9KmHoiMTF73xpFSE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 787       )
riBQ1PGIoAlgn6rOsQX23miM+Y76TJ3o4Q6X62ZtPKNLn3DlEwsTB0IjBhx9ex1a
dec9/kYIWtpB8Pu5T5SCl/CvP1U0rzYVENYZRtwiisFKqRj0/Bazx7TU6CNLukWp
fMd20hAr6d1A/iZixygpXS5KVTwCBjvUviKfnQkPLJC1yEZA4ESd5MnqEPrlup6x
nSM5FYtYM+Vt0S5VJdj9xbEzLO2kCvX6EYVcRVWZhbF046pXZDRXWuyCu9Dbs6so
If5d602d+PZeoJ0znkN82r7ewoQBDI+fjEH/k5pPArfnypBwSh0ckCWBB89LhwtY
DrjTFvmflh81SFwXNZhz8n62ZBJIzZ3ERYqyXWKS35WQWJdQftf4Nfpb/Co/jYB2
QFWWxnAW927Hkb0APd9VwyNt7I01jrbg8MI6KZ0SMJk44VS80ZKxATUy2i0Mi5Uq
sOxPLqvuJJXlFgRiY5IBfQ==
`pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_CB_EXEC_COMMON_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
DCLp5AkBmzLcOrzLeaQHAu+p0n9MhyX1A5Gjo/5OidVlpSpBJNrGNJd0hc/qBADA
YSHA86TqZbKXchrAvvPEiNk5ZXdzlApI1NQYDuDHC/JMoYreVxwlRkXRWKxYxahW
6tEdATAguoGsj3EiVKYsDijZM8FNNuMat7tNr09CY34=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 870       )
R2fsKKD8OOP7Qu3r8P8/tHppFxCSFzH73r4/ahoXQjSyp1COXQPos4A0Myn6z9O/
n593w1XsO5fkP/aEXYpNoQ3R5OSTqd2m+N8yVYipX1AkaijlDBK6WAljRljjgy52
`pragma protect end_protected
