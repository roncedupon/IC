
`ifndef GUARD_SVT_SPI_TXRX_CB_EXEC_SV
`define GUARD_SVT_SPI_TXRX_CB_EXEC_SV

/** @cond PRIVATE */

typedef class svt_spi_txrx;

// =============================================================================
/**
 * SPI TxRx callback execution class which implements 
 * the cb_exec methods supported by the TxRx component.
 */
class svt_spi_txrx_cb_exec extends svt_spi_txrx_cb_exec_common;

  // ****************************************************************************
  // Properties
  // ****************************************************************************

  /**
   * txrx component which implements the callback methods.
   */
  local svt_spi_txrx txrx;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Class constructor:
   *
   * @param txrx The component supported by this instance.
   */
  extern function new(svt_spi_txrx txrx);
  
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
   * causes the component to discard the transaction descriptor without further action.
   */
  extern virtual task post_seq_item_get_cb_exec(svt_spi_transaction xact, ref bit drop);

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
  extern virtual task pre_transaction_out_put_cb_exec(svt_spi_transaction xact, ref bit drop);

  //----------------------------------------------------------------------------
  /**
   * Called by the component after recognizing a SPI Transaction, just prior to
   * placing the SPI Transaction in the output.
   *
   * This method issues the <i>transaction_out_cov</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_out_cov</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual task transaction_out_cov_cb_exec(svt_spi_transaction xact);

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
  extern virtual task transaction_started_cb_exec_tx(svt_spi_transaction xact);

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
  extern virtual task transaction_started_cb_exec_rx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been ended at TX.
   *
   * This method issues the <i>SPI Transaction_ended</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_ended</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual task transaction_ended_cb_exec_tx(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when a SPI Transaction has just been ended at RX.
   *
   * This method issues the <i>SPI Transaction_ended</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_ended</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual task transaction_ended_cb_exec_rx(svt_spi_transaction xact);

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
  extern virtual task load_tx_fifo_cb_exec(svt_spi_transaction xact);

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
yYr25dxjqJRuT47LJSqYkVovf5My1ifJkyNGWI64Ao1iF2FVMTYziwnE0ihthycl
nqZaSG/RnyOXoHXk2MJP5s8fKicm+3qxeYBko5CbYcs5kibzRiXgKVypD235b+6V
zsvY/R6T8PTNzDC6K8ojkkV1DFZOmSAI7X2GoHwOLQEMTew2ypZHKg==
//pragma protect end_key_block
//pragma protect digest_block
VmrQMeu9tC5VZrs09ZGrZFXpVIk=
//pragma protect end_digest_block
//pragma protect data_block
F64LjB/GbzK+PbtKULvnBag+ca9eqUdUKVkAEqBSp8htLzFtpMk//NJLM0V/vmmL
peBdsBjvYFFGWMQh/17UWE5l/d12nyDNJFLK9h8m5rNO+/grpw4rWL5EgAhEw5Ac
/9DdbalFntH5Af5Dfms2ruXxq9WMvGCKNB9YjsOVFbApbZwdD6iSwRgMVo5da0jG
O6d4xosstrXzLz/b0+nvM8xgTkDoBaP25wtWKSyxx8cXSLnmpxM1DllDuIZU49MJ
Nx4WGAHv5spm1u6PW7LTeGEbdG/hZhQsTDbMRavdVoTjKJMzw1dHdg1jHDrahr1V
uZHZGBZUdkCqrtC38rn45qy2nWimIyVwjRAKuHPn/DOWsyJdV5v0Mxor2oEF3jyp
YuduvuCIFE5BSOO0FZbtyTU9JuUtmMj1PtLmoCqTC/vD/2pMZXLJW7T8wnmLo8GI
AZPUNr+ZITL/ElyuPZZUjkQdp8GOm5fSEYv2Ez1EqRXxqp79d95gBu8yHfo/3u0/

//pragma protect end_data_block
//pragma protect digest_block
hBc1f1SKbZsNah0JcXetmGTbc+U=
//pragma protect end_digest_block
//pragma protect end_protected

endclass

/** @endcond */

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
X7pp7ISMVUEhOBTFfLPUKZK/xUChP/UUd0V9XpzeImK/MO6LUl91Ir+GngFvgMxX
ltM21GUUj27waOIKB2yZ8RjI3HL5jjI+fQHYSDhT6ySpcmZUT/ygEVrDK99vTqSj
osMPOjb0doNGKjxc0uGK6cPjXEBRCePFvVCfRFGaOa9HGPHVcoLRYQ==
//pragma protect end_key_block
//pragma protect digest_block
vKsE78G9RKKF3Uz5d2aV1UtDbiw=
//pragma protect end_digest_block
//pragma protect data_block
kL4Tnpvp6gdB4Nc0IcZ8BDDEpi18EJ7p+HZDCE5sdBoAVouVmFrO+9wjl7MOPGw6
v2esswmowChi/GJSPgfaqkx9h1HlL9q/TIngEDjtaj0ED9nzacwX9EOmV2C2mI1U
BFp/a+ia/JdiMIhgD3txlgREoyh1PTSv5csvSSVj3BY1Ctroh+kkKjTsIeODsa6/
aNz6UFSZI8uv2s3ITJ1vj2pE0Mw6PQPvZjljIdEAsV4kb2p/OS/JxvzB4HgaY1Yl
peKKPvak+g9NlCLe/C5f+qad5j5CBhWUtgi58eNIlOLpeZsrqDQditly8FvQDjF+
5ht9lrlw64ec0ayYWi9KSFlECNrFBfYGKtz82ULzMahUktetVLCTBu9TKv0XBDGu
ybEPuv2oayPnBLp8DTZRcsmfDV+aVk6QcQ4GEjttIUzVHp3HxBkH9EvYiAsiNJTR
rlLineY0KuymwKY2+JJaX3lkLcH14LPIs3iyXeVBxrwmEOZEoxHcJX9C1SF2oc4B
E5zv7gng+nLpUhAe6hHkSs8rHIpTuA4PZ0jRcANJD+VORV2MaLhji7BLyAa49+1y
BzQBrpaR3/AMaubtTOx48jhNieP173WyQ27mwhMPS6E=
//pragma protect end_data_block
//pragma protect digest_block
GkwWyp0BMoash17ieCzd9/rhmnU=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
pg/+HW56lStOvMzytyEm35iHk6A/G78reLk5RZGXR3qwGFoHSKjNl/z1Au4bEeyo
ycHu5d7psybEeTuB6MqinKaZXWqaiuCDHpwinLODdiXLDQjCEWsiIch8GCQGfBvA
l2vX4pGYcC1pWYG59ouGXH4PF4zB7uBH+wMd5VnXfFSmgkIOsB5VLg==
//pragma protect end_key_block
//pragma protect digest_block
yyiZtvb+iosnC2EXa2jCyvXhGvc=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
PGNYNFN5AJBJa5kMRPv1e2An6iw=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_CB_EXEC_SV
