
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ORcT4/lrD1qtdZbKdPJhX8DgGnnlvKW4F/8vcnX5ZlgF/M9AN0fDcpXnw7gc5C+g
rAGwJETxwXwzftGdgAjeDQz8o70xvCk5TwQmG+aI69GXVv4HxX5Lu7TiEzJ6GbUm
Rv+ifn7UXmg42QMu15zcfl8NbvwfgtNZgXo/HPfHv8s=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 538       )
a/xMdKIqNv9k3zWOpnzF0Ev62M41NudeioHOmoIDKRj/5E4/c0Yc3Pc5rH+omGDM
+lMu1XB/38TqMzlk9oER10tj0yDZM3jdEKWz2UcHs6ENaoMLMDDTB+aIsq00jBLu
fOWkpy5J9mgqHQUrp6YHRqUSDfQoVGeq3piyOLsPZ33UKTqi39/y1W8wROZRFlDU
A6jQrf6mDgN/G6fjKHEILNHSPxawjLH3LNpiaqr0QbD0hBanHibHlAtX/t192Tfb
F5GGIm/JQFIOfx2dVPW8581Do4Wb8455nKoT63VP0cn/WfnZ/hYVNZQbKIxCGKWS
ozoauGACn1uaQJKt3gwKH9+u0pGfRRsTtVaAIxiPwCkQjfuCm17cSKtTY01gkuym
tTPKws92nXqTLZE/pFx6/VkjyWStuCeghU6HYvNwVwJKNp0m+FmIr/F60TSe+cA4
8Kfp88tEcsX9OusPmus5TdwwD0cbh4Oif7ozFxIb9yJs6mIHVtV1Bc9kTfo4dzs5
r7lhzf5o97rbL/3PCzHrj+yB3azWXxq5UKF+w5WgAE/7QARQncj1llx7x7ia8MO+
MFNkpwehMNEVQbbMMRD730BxfhLQ/cabramHdra62LxpBQMZQJ1jyCYKorUvuRDu
1BWvXX6v52odekbWPkFX8h8XTPe9EcEtpMrZwR1qMYlv1ewOJy8K7RIB2YJyKX5E
HH52t3SvT7ih2kHYky44Xg==
`pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_CALLBACK_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
pCsNvmTdT9tm4iSGoGpvZyoKNz1G5srX14lIk9YeIP/sEuownXd1B24bv2LBlQkU
FKhNMSTtuMJv1/8I6xyx0mLE6YLfVbcrPHGBTh4mS1+EsEpGrEyl2AIPCnfvyGyI
DcSn/wV9elw0Tg4gAYvuHn2YNxI8iy72M3DuOtvlDjA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 621       )
wHVz/8/74kUwqse0FcajY+5ZPZH+pvK8C/hZwb/Eu59vWflP+OsIJmQXJ5nTpCu/
ouSC74gtJdqzEWBSZhmnusJwEpr258B9UzxOenrlqFe+5VQoJ3n73wt5yIr36fe5
`pragma protect end_protected
