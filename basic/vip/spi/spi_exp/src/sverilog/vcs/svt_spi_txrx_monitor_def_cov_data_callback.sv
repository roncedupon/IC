
`ifndef GUARD_SVT_SPI_TXRX_MONITOR_DEF_COV_DATA_CALLBACK_SV
`define GUARD_SVT_SPI_TXRX_MONITOR_DEF_COV_DATA_CALLBACK_SV
 
// =============================================================================
/**
 * Class containing the default coverage callbacks which respond to the component
 * coverage callbacks, constructs data fields based on what is seen in the callbacks,
 * and then triggers coverage events indicating the data is available to be sampled.
 */
class svt_spi_txrx_monitor_def_cov_data_callback extends svt_spi_txrx_monitor_callback;

  // ****************************************************************************
  // Data
  // ****************************************************************************

  /** svt_spi_transaction value, should be sampled when #xact_sample triggered. */
  protected svt_spi_transaction xact = null;

  /** svt_spi_agent_configuration value, should be sampled when #cfg_sample triggered. */
  protected svt_spi_agent_configuration cfg = null;
  
  // ****************************************************************************
  // Sampling Events
  // ****************************************************************************

  /** Event used to trigger transaction coverage. */  
  event xact_sample;

  /** Event used to trigger configuration coverage. */  
  event cfg_sample;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new svt_spi_txrx_monitor_def_cov_data_callback instance.
   */
  extern function new();
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new svt_spi_txrx_monitor_def_cov_data_callback instance.
   *
   * @param name Instance name.
   */
  extern function new(string name = "svt_spi_txrx_monitor_def_cov_data_callback");
`endif

  //----------------------------------------------------------------------------
  /** Returns this class name as a string. */
  virtual function string `SVT_DATA_GET_OBJECT_TYPENAME();
    return "svt_spi_txrx_monitor_def_cov_data_callback";
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
  extern virtual function void transaction_observed_cov(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact);

endclass

// =============================================================================

`protected
Be^#B6f[C82[MG[FLNT=G&6e0G:>[R:XY.8R&BHYZ;9F0]Sf6UZd.)&F^6P1CJQ?
]GVZbQM5/RI@eA+_R3.YIZ_D2ZZGPT#)2G6.5:L3:N=9]<K5gNI<RK457EGVM?<Y
:@O1WB/HPW@B=TL1.?XD?a/0>FCSHND#ZX:6W6NNAcd/=a9T&@NI3@c3;#B5DFVc
S3&I:0EbNcWTY5<IJ]17C1fRV?gEIf:F<e(CZbGeY0a9N>LV7R/3:S+Xe.3-0R#S
gDU/YHPKXbVG:Rg@J63J>cBDVOI@)Y32G.dVa4gFAe@I1S.b8G).KTRP.6?bOC?L
cS34KN]Dg6?=PZI\&cJ?3H//MVAa2d5QSe#+/T7YJYaaMW[?2=2F,X,C9IKCef8L
NJ&\4Lg\,Cf2=\MR^0L6L]N?M11V(N^f@$
`endprotected


//vcs_lic_vip_protect
`protected
6<7N8#^4THK3:5:Q]fL(5[#afG^D-3OE3Q]-IZ?VH1_gZJfc#YRY+(CXIHA<_G44
-SR(8,+9S@Wc/LRQO1PSOISO<)0:#W@=41/F/C&<C(^I\_a>b>dN,O),6?)NE^3C
3e&@-0AeV;UD>MTGfG3:I>F]?4/F^/SWHeX.JUC7R\:KUOe@d;G,K;^^[FFg[MR&
2H)6TE1[Ud#S_b_:E,9c;a)bS.\Egg<d5-B?(CcT=3P7dcMIE#W>=U5UDG5;U345
PRX<FF[KJQ1.PF5fTXMcXIGASJHL5J#R;=9VPEeVEH8UJ;_/:^4>XC75V9Hc<GW;
>^T5&E;E[UWRB0fa98:KRPIaOGd+^0e+HQa7E?/=:6LB55+<f0[W3P/,Mc2?Dc7_
6]Da)Of^:&^d8=O:H9dFTDIC1DSARf1MQ.:STDE9FOZ3OFB9W=TLESdaa9-P3P83
HfE\fge<:_&dg^6EMK^8TRC/=@cW3/EV0L?Z[BDDNZ>DIO,UMH<EU9(?CeWE>=XO
TU@Y#&V9<a(X9B/J0V__9[N?UJ519EX.DGUJUDC:=PF:A?QJ7gADX8RHHB]3F9V1
>gP-^W(T7UIHY4W:CbCZ7S082S\UH5efM.IcOXTJD_ADdDM\W:\NV]NM]bfSe@JT
6@CJ8K+H42Wc>R3,FPWDG5088$
`endprotected


`endif // GUARD_SVT_SPI_TXRX_MONITOR_DEF_COV_DATA_CALLBACK_SV
