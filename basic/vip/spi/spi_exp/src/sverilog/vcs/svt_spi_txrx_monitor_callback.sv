
`ifndef GUARD_SVT_SPI_TXRX_MONITOR_CALLBACK_SV
`define GUARD_SVT_SPI_TXRX_MONITOR_CALLBACK_SV

typedef class svt_spi_txrx_monitor;

// =============================================================================
/**
 * SPI TxRx Monitor callback class defines the component callback methods.
 */
`ifdef SVT_VMM_TECHNOLOGY
class svt_spi_txrx_monitor_callback extends svt_xactor_callbacks;
`else
class svt_spi_txrx_monitor_callback extends svt_callback;
`endif

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** CONSTRUCTOR: Create a new callback instance */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new();
`else
  extern function new(string name = "svt_spi_txrx_monitor_callback");
`endif

  //----------------------------------------------------------------------------
  /** Returns this class name as a string. */
  virtual function string `SVT_DATA_GET_OBJECT_TYPENAME();
    return "svt_spi_txrx_monitor_callback";
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Callback issued by the component after recognizing a SPI Transaction, just prior to
   * placing the SPI Transaction in the output.
   *
   * @param txrx_mon A reference to the component object issuing this callback.
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   * @param drop A <i>ref</i> argument that, if set by the user's callback implementation,
   * causes the component to discard the svt_spi_transaction descriptor without further action.
   */
  virtual function void pre_transaction_observed_put(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact, ref bit drop);
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Callback issued by the component to allow the testbench to collect functional
   * coverage information from a SPI Transaction that it just received. This is called by
   * the component immediately before placing the SPI Transaction into the output.
   *
   * @param txrx_mon A reference to the component object issuing this callback. User's
   * callback implementation can use this to access the public data and/or methods of
   * the component.
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  virtual function void transaction_observed_cov(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact);
  endfunction
  
  //----------------------------------------------------------------------------
  /**
   * Callback issued by the component when a SPI Transaction has just been started at Tx Port.
   *
   * @param txrx_mon A reference to the component object issuing this callback.
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  virtual function void transaction_started_tx(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact);
  endfunction
  
  //----------------------------------------------------------------------------
  /**
   * Callback issued by the component when a SPI Transaction has just been started at Rx Port.
   *
   * @param txrx_mon A reference to the component object issuing this callback.
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  virtual function void transaction_started_rx(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact);
  endfunction
  
  //----------------------------------------------------------------------------
  /**
   * Callback issued by the component when a SPI Transaction has just been ended at Tx Port.
   *
   * @param txrx_mon A reference to the component object issuing this callback.
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  virtual function void transaction_ended_tx(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact);
  endfunction
    
  //----------------------------------------------------------------------------
  /**
   * Callback issued by the component when a SPI Transaction has just been ended at Rx Port.
   *
   * @param txrx_mon A reference to the component object issuing this callback.
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  virtual function void transaction_ended_rx(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact);
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Callback issued by the component when a Beat has been Ended(Sampled/Transmitted) at SPI Interface.
   *
   * @param txrx_mon A reference to the component object issuing this callback.
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  virtual function void beat_ended(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact);
  endfunction

endclass

// =============================================================================

`protected
X2)+<,\NKGGgIM644@Dg/PD[1<FUNYMVd#))Z,_Z)>Xf7ag@HK#5/)784CMT:B5/
/F:SURTBGPI2O0JLI?AO),d1XdL7eJLUMLbRZOZceP++3^W2V@RL/bE[c+Y:gV5W
]+03Ab&#A=DUAQM^?.?F?9)U#a[33d(A;O3c&,OQ&+bV\^HP3K^K5S3bX/C,Tcf@
cU++6)M>-(Q(#0_W.&bM6gFCKPd?RELMWY:2a2VW=[VDG-13\9V:JFP=7QN=_Cd\
)L<)2\V-(PSb+gD&>B/QM@,-F+<DQYIPTQ-;,g8^[1V+DX;DU[FW)N];[;1<&6T7
CK4&X,JIVJV+YBXTNEcX.NW?a@=>CKWGPWP/>fH-LVC)XKM+@:R2F28LOSeBAf_5
7QL[5AK#Db(HXa:+8K_d?#gcK&4OY.NSXC)P[W@_6#a+,L,FQ7:aK3,28JOZbd()
OM4b^=LW?Y<>.LJMdY^EL5R\M+Dfa,_WVJX@d(RO2CS+H$
`endprotected


`endif // GUARD_SVT_SPI_TXRX_MONITOR_CALLBACK_SV
