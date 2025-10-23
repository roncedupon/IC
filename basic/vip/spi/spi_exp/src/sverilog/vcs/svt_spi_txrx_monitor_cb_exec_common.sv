
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

`protected
ZS00NfPM#.\B#aV8e=)J8-gB:M23@+(BZ\_=c_Fg?ZOF@JMT.E1(4);FADQFVfUD
K11?\YX@Q;39DK7Y0+KUY1:@Y/Zbe=?8aZE8c5ZdQ/=[>c9=eTLSB.Z?5DL:fWCg
:dNad>=FCd#D[)<5L6_@f,NeFQWfbT#(>$
`endprotected


`endif // GUARD_SVT_SPI_TXRX_MONITOR_CB_EXEC_COMMON_SV
