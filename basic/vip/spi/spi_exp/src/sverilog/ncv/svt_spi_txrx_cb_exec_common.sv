
`ifndef GUARD_SVT_SPI_TXRX_CB_EXEC_COMMON_SV
`define GUARD_SVT_SPI_TXRX_CB_EXEC_COMMON_SV

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
SDV3ldpoSYfvorheHY040efC9cH56aC9jPZ+UzNUNHEXcPTyVe4gueA1SMDVfIfH
pPzsHxCth5a/KTtVtjG4HqnbKIGnlvIVFNjd6Ed76OsTKin5Wd09tSs6Hj0bInfZ
tx72wyD6STA4onHJkYeI3B8IBouwGV/Ii9j4ZYOYg5s5xq8GkOGDKw==
//pragma protect end_key_block
//pragma protect digest_block
6JmnQa9260nBc0H7a+Tjoazj9MY=
//pragma protect end_digest_block
//pragma protect data_block
EuoQi00XmZQyb7c+graj2XCRDO8X0Wc6sZzSMFSby72fsQmS5+GtQa07rKpIR7ye
hPDPAQHxh0b1sMJDp0Q9Pnanz7D4m/fzIJtNIo4oe+ariYlfDSEuKSvEDWOhFru5
on9ULJVodK5Nxe7nAaKTv/c/T7LBKwslDiyi2RuDV4w4jrJ/Gi38m0Sn8u126Kfl
C2H/toEk+SaGpQbVZg6opFAxaJfQBaRMTbuUsc8rcx/KJES9oG5nJO1bTWtyFctG
7PH1lDZv+O96Am6YyRfa7OoilX+vUrpTH3yJwbYL/06Ufb88sb56Pvhr0dlwXbo1
rJVEh9wcdzZa0fLUJtxL00xVWwHx73rmHKbvGRN5nJOJuoYABQiSZ07uCfifrkQf
dAocHeXMlueX2v0Cgo/H3XjVCLxonwDWRo7pCAiidj13833IP1ekAwvB6oZQb+2R
Iw1JMjeaEKtVfDBCqg/eyx62QzbX193t/RfnGq8S4iZRKbfkItMjqEfQLjPJo2Fk
vLrQtAtlQNtUjeFSFReY6Qq9j0+wv1GzCFIFXz5GfduK67BCn944YYgbRODjbLhi
8PBbkWP4bzc4rJvpErV+waqpTbJWG8MjJJRuKnxuULph/sL82lqA0ewKE04wPzxn
luTJzspxetOkIZM01+9p15Jn0xw3IzfDxu/mrnRYd4b1Q0ZxXvz5R2M/wWKK9Z6J
EsMMQejPD+hwAJ2XZcrSG9R1GDBx3gsbtw1V19D0vV7tIfTdpqj2IWGhH+9qDnEI
vS3Y0EaMYhiySVjxw2KoQNnaH8yWMTkLiVW0jqr7OMu9YVvqf1tWaGaT/b/ArtYu

//pragma protect end_data_block
//pragma protect digest_block
sC/8gts3092ZL6WzcMvuoY2BcJQ=
//pragma protect end_digest_block
//pragma protect end_protected

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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
VaBQ2SesUJnnmqRYlbRsqotXqNj+NwzaPzGpJMZWO6pOypoUlVifeegnjxH2LOIS
r55D557w3KLXOIfkvHAVZeDYOg/hSRs+CcH4ATXzhyTScqHLNfB7Gmnm76Sy7yMY
bC6riTjlBm3VNQDGRZYeSo5AIV/4/Y2rHjkFK4CBNRIPP3pc7S7NTQ==
//pragma protect end_key_block
//pragma protect digest_block
Ut4yMzq77NI93U12XgD5xGkvqec=
//pragma protect end_digest_block
//pragma protect data_block
TGBkXz4SBqADcCbDDYrns8PuzlpHsBL8TVJi18v19Y+ZHZq3WqFzpXl1UFJoT8Rp
mJrwiLRL//xqqjf2o1XUwASH7cZJg9uDebUUyWM1H0UbcGZ7LvCmxxRT5o5+OBoj
OsQu9coI+DHyeB7sM4245q3uoViVTZ1KqkTUc05jOGFjY0ni34F9hvd1OHC73WS7
ipu2l0OL/v1UbW5syUTdt7kIdE2gG1jTF3y1DIpDDsFKrnhmAP+ZJCoiNnv1e5j0
sA904DFxRcVMAlTlyF9xiJSqcKl1NwW2/hhNn8gaYPwJZePysuvtPtTrpAUrJQxl
rIvpQRYLYKLfi+xilN12Q1095nQGLWA4sOg0GIv9+4EHkmIgVx4AIjIqNU6FlJ9D
Spjp8ocpNPxnICdSbowku+OWMrV/nYIPorTbRHOuMP+V19Z5fGvAeVFa4xCqihXy
woXqLCzFD+11QeH5n8NFgklCXkmhz7ba3+CckXcxOuZK8wyWihq4OaaajP8y7Vkq
at/4vzvNYaIHuW5pAvtwnFqJJpx0xImveZ+tauV6xftXz4KN3sLtAF6g+BhYIkt8
Bb5GzIozdYazXHUYhVWopzroukxVhxCyd2xGRQ7ocHFAx901TOhzfsafgoj78JLf
gdrTP/B/hoP2GWbbni9lXAj6hKbCRfd14Fw+HgT9pVc=
//pragma protect end_data_block
//pragma protect digest_block
56wmoPuI1+TQfLYm0zPhHdJrk88=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_CB_EXEC_COMMON_SV
