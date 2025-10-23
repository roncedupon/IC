
`ifndef GUARD_SVT_SPI_TXRX_CB_EXEC_COMMON_SV
`define GUARD_SVT_SPI_TXRX_CB_EXEC_COMMON_SV

`protected
]80-(DKQF0gN0M)AR-;f\Rb,_\f+UX[CT8SA3c\N9R#8:V+YTK#21)b/-Y(A9VR;
\M@0BS)(;1Y7GEY#)TCRGe/Q0e:Q?X)3P.e9a=.6=5XI=J6P-e;2PeP6DUFMe\e=
,>:Qg:SL]<Kga^9_aaUOb4W^N=0@.b6D4;6;6_4L^N_4?f>=T<01J<>6DC]a6.TD
e31fMS^0W&.N^KWV,0JAW#\Ccg5L276?;g_FYX<U]G&3W(K1K=::,)).@,8]33e_
/Y/+UM_-aI+UWLN&-T4Tda4@37BJYMC-XN)3beJQ:(T_Ac:L=AEDK=D:ZZUZ&WCS
D)OW6K]d:GS=&JCTBJGcBW&c123&H>G8P&)MgKYM1M+f@):#V,^=GDgc?L&<_W/(
K-d8T/FBY@YgFC_c85DbT#D0a.=D?d9SY#5Yd0;A54IA9/;VHS>GI.+V+9=^I,gS
Q5b&F^&=-GYG2M-FI=2\-#Da(@cf#79V=8]g<,Y[c2I#7bE,R&4ga5;3bb\Bb=XL
U4NeP/d&FdO>JC/c[fRVMVDa5$
`endprotected


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

`protected
V7a;[^VZ\J#W3P@KJ5+gA&Oe#XA;3^Z4>dJ4F<7^OO7cJQ,GW&20()S?b4#@M4a(
B^^IdXMFFQ#E1DF/EdLb5fS3?(4S\&5A19:4A_T-.IX6G?:VE&0d\ZVO+OPW:VRN
A@C-#UgL?bX(&/1g>C^0eAS36$
`endprotected


`endif // GUARD_SVT_SPI_TXRX_CB_EXEC_COMMON_SV
