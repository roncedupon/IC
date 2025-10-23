
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ZJB7+Yo1/90oBSHCfwjjTJgw3hgOOrUSwTpXpO9tiR95kSqLrlCN8S8/FcHUUQUD
CavBdUzr/3WHyb+TRcULuqrIzO2OnlQlbmCzqtb0eYURQmrurJMlnF3tqYSbxz2v
gD7hTn35re6Tejz8Whm+vdDvefX26ElrRTBTQl3iXl8LtDwEqbqZyA==
//pragma protect end_key_block
//pragma protect digest_block
MmZXZQsoPNovWsrfp1XqTha6quE=
//pragma protect end_digest_block
//pragma protect data_block
lmCdPxNcbA1hEpRIDPf9+JTuU67N8HTGheprB2bhlhwCPHlnFl9pYsRbcSEERf+m
sQpL4/dtozUOYHMi4dmlTRb/052kOnxsH/bGP1T5aiAbMDFpjZoP0eDvfmzH7tfY
yTW46LqPrKRKJd5Qm3eQ+wK9j757OavOFM5PhmAQOSXbz9BGIljawXX+30XnG9NY
oPFMS4EK8Ui4ZzyYmV3j3D45EW1Id5KE3lXHQiR+GWI8Owd2oLuu+mP6XpQ2vYoq
sJIrZLMcvClZeYe211uTWsPHJlD6SywPkG5KugCcUot94rRmwrhDGZMuFSqMVhbU
3uSBvw5TZz5ynz3fuOV0BGTooJQ5BsK2cQrc0u3y4m+pmRpa5gJe8P0X8xE7AagC
wKXS7Jd7q1ejHGGPDJQgghuyORHIdTIImJIPIqNeDZLah9U/HieXbQ8yiWQFYVJW
Ax+qBSX/eb0XMGsA+yUHqKmxrybpNFM+3Jr4gihPGc9BbiThp+eFYULKgRtl8I+s
8D3R91fZx5yqkaYo/VZwhJIGQ8sJ03rOcqPu8K8XaE6/N/734OEVYGoZKQLmzh15
X/3MeZf5PJjrp4yVfWHHSce1FxraRrqDIubgIPadBrx54d6fYRap79eP0uGI/7Yx
M4Fjs9d8DdEG3dR5PitEe8cyC4gkNaprWV4cgFJM8yU=
//pragma protect end_data_block
//pragma protect digest_block
vBqlMM+UiyfxWF5qnL7GcqUNRfE=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_MONITOR_CB_EXEC_COMMON_SV
