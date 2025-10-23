
`ifndef GUARD_SVT_SPI_TXRX_CALLBACK_SV
`define GUARD_SVT_SPI_TXRX_CALLBACK_SV

typedef class svt_spi_txrx;

// =============================================================================
/**
 * SPI : TxRx callback class
 * defines the component callback methods.
 */
`ifdef SVT_VMM_TECHNOLOGY
class svt_spi_txrx_callback extends svt_xactor_callbacks;
`else
class svt_spi_txrx_callback extends svt_callback;
`endif

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** CONSTRUCTOR: Create a new callback instance */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new();
`else
  extern function new(string name = "svt_spi_txrx_callback");
`endif

  //----------------------------------------------------------------------------
  /** Returns this class name as a string. */
  virtual function string `SVT_DATA_GET_OBJECT_TYPENAME();
    return "svt_spi_txrx_callback";
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Callback issued by the component after pulling a SPI Transaction out of its
   * SPI Transaction input, but before acting on the SPI Transaction in any way.
   *
   * @param txrx A reference to the component object issuing this callback. User's
   * callback implementation can use this to access the public data and/or methods of
   * the component.
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument that, if set by the user's callback implementation,
   * causes the component to discard the svt_spi_transaction descriptor without further action.
   */
`ifdef SVT_VMM_TECHNOLOGY
  virtual function void post_transaction_in_get(svt_spi_txrx txrx, svt_spi_transaction xact, ref bit drop);
`else
  virtual function void post_seq_item_get(svt_spi_txrx txrx, svt_spi_transaction xact, ref bit drop);
`endif
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Callback issued by the component after recognizing a SPI Transaction, just prior to
   * placing the SPI Transaction in the output.
   *
   * @param txrx A reference to the component object issuing this callback.
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument that, if set by the user's callback implementation,
   * causes the component to discard the svt_spi_transaction descriptor without further action.
   */
  virtual function void pre_transaction_out_put(svt_spi_txrx txrx, svt_spi_transaction xact, ref bit drop);
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Callback issued by the component after placing the SPI Transaction in the output. 
   *
   * @param txrx A reference to the component object issuing this callback.
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  virtual function void transaction_out_cov(svt_spi_txrx txrx, svt_spi_transaction xact);
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Callback issued by the component when a SPI Transaction has just been started on tx path.
   *
   * @param txrx A reference to the component object issuing this callback.
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  virtual function void transaction_started_tx(svt_spi_txrx txrx, svt_spi_transaction xact);
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Callback issued by the component when a SPI Transaction has just been started on tx path.
   *
   * @param txrx A reference to the component object issuing this callback.
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  virtual function void transaction_started_rx(svt_spi_txrx txrx, svt_spi_transaction xact);
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Callback issued by the component when a SPI Transaction has just been ended.
   *
   * @param txrx A reference to the component object issuing this callback.
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  virtual function void transaction_ended_tx(svt_spi_txrx txrx, svt_spi_transaction xact);
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Callback issued by the component when a SPI Transaction has just been ended.
   *
   * @param txrx A reference to the component object issuing this callback.
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  virtual function void transaction_ended_rx(svt_spi_txrx txrx, svt_spi_transaction xact);
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has finished tranmsitting its last data bit over SPI lane(s).
   * This is used to update the data content dynamically while current transaction is in progress.
   * In Master Mode, additional clocks will be generated to transmit the new data bits.
   * Data driving to remain as it is.
   *
   * @param txrx A reference to the component object issuing this callback.
   * @param xact A reference to the svt_spi_transaction descriptor object of interest. <br/>
   * This callback is currently supported for SPI-Bus mode only. 
   * Only svt_spi_transaction::data and svt_spi_transaction::data_frame_size fields are expected to be updated by User for this callback.
   */
  virtual function void load_tx_fifo(svt_spi_txrx txrx, svt_spi_transaction xact);
  endfunction
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
koM0Px2GWt7hTuEwqw3TZjdRWQ4APXxYNQ0QooSV6jQJn9TP5yNV1rMx1Jyysoo+
TBRf+kQOSEOhFG7Mq4k3NbNPp8sHl1QQ+tCr3zb52MFAslnPcXlxQca7hFgSWSFz
ecKv462guu4UQGuPkulq4IUzi+Dv4XnuqJnGvBdmnfCi03S1F+bSwA==
//pragma protect end_key_block
//pragma protect digest_block
RxRmhRx4a8HG1qyloXURinjtUWk=
//pragma protect end_digest_block
//pragma protect data_block
SyP7tGEVuadTjVuE1ASJz2Vjt4ltmzgCYvKy/KMjSxNZPLsuvP11ohEubDdOZG4M
odGyTyJLNExirApxqVPl5iJYyLBSoIUl8NUOOgetBSjQnlnjigZTX2g1u5SUrg6o
wqFv6W9jvCcOcwlQMukSUu+gogOuvpdECJtnhHEfOJI3PnmXSw6w305DyMajjm/H
gW6y/MiWj1MTzh7pk1FZYBq881gZoqqK1sCmci8ylu8d6Gr/9bVQkJ737eW/Mr2W
P9/aPGdBq5+TfdB2DwWyDqGpQQmpCIAjKcN3xBlqkEI7M24xVo6Q6HnOauRCNpd5
VAKHoRkd+O596YJosOS0avlEbL5bZUIxv2lqav6gG7VbxoOasD1ygW4r5052PH36
aeO4Ffb5CimrJeC0/zAI5m0OCbgF8AnFlEE8iikTzOwYUhAyHz5q1wcGWHf1pJJT
cCxYKcZMkXpL88MEMcfTLJErQvaa1jM6mZAeiZm5ABD0x0boORBySsd9gCvR24B5
ZWotYMkvTw0aEU8mjjP4pKrALs8DgsZBGuI4d0QeKbz71gpMVic2fjQTvN0pfauP
5JoYEtqPuocxScEnshzviWa1FS5VHEe1aIJdbNAQtB/vFx7PZ2dVRgpFo7XGoD57
aIuyJVt/hagK0Nj3u8atq3I0H36UFUcFpww3Tm6V/ZGqUOtXDuyJbF5m9rlTJR9n
4WSNiwCxjn3nrJT9B0G1mQEcf/tpExGLdEh4Yhz9f1wnQD0WGjIxrKIJEhLT6YXA
/hMhMwwaawb/SZksGFI7Kr0tqvatGgBPtfRKIJ05ieDpz8zzrGHZmjwjHzcIFGg/
7rxY0SnGLdbvoJWlSLSp4LPqBfqEcE1Z60ClImg2zHnysT59xEiZTjgjORuhI4Uj
PjeOstqxtIsGEAWTCVsLQg6PzG9vMZUXBaWqbwlYEII=
//pragma protect end_data_block
//pragma protect digest_block
J9JN/dwHDGMAgOqu5L4cOAVRe6E=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_CALLBACK_SV
