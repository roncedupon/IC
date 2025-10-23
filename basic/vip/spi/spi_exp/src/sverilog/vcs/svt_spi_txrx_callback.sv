
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

`protected
4(WI054Z/AY39E17&IH()G;;P@J^?>^NRfJEaQ@d5;Y1V[<dKU_F6)P82E0W1EN&
AgQ+WV?Z>=6B#=ZI[OG\B?GdOd.MOR\H?6[2WY&D>WcgA;;#/cB=BZV;]OT]eI<5
>BcdWe&HIDg->4?Y#SJ]G:-HOBf2=\<2@9Y:+U/S7Bf><AfZaN-^b:DTMPNIV#6a
K[@JM&+JOTB0[U,YOLgGI1BKIa@>LM9Q6#]NF@<8(&gA9e;b-KY:UGf_=9O\;3VB
O9c8D6EaDT.F829TRCe86)c,>=H(O8HU8-#T5bL+5_0dd6)9[6ZdOM05Q]TA#P_Y
K6,[D>H/]TX:^S+CMbO+S2?6#?-?B25#]?7?MJ[Z^?)O\HPS5aF^C0VHe^=D&85a
-4ab@,<.S>Y&DT#(NOPc:L[(S<1+U\+=[WZ1JTd4W>@84,90JEZc[g-bXgXHJ21A
\Tc)KfT?SdM&0$
`endprotected


`endif // GUARD_SVT_SPI_TXRX_CALLBACK_SV
