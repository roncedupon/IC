
`ifndef GUARD_SVT_SPI_TXRX_MONITOR_CB_EXEC_SV
`define GUARD_SVT_SPI_TXRX_MONITOR_CB_EXEC_SV

/** @cond PRIVATE */

typedef class svt_spi_txrx_monitor;

// =============================================================================
/**
 * SPI TxRx Monitor callback execution class which implements the cb_exec methods supported
 * by the TxRx Monitor component.
 */
class svt_spi_txrx_monitor_cb_exec extends svt_spi_txrx_monitor_cb_exec_common;

  // ****************************************************************************
  // Properties
  // ****************************************************************************

  /**
   * TxRx monitor which implements the callback methods.
   */
  local svt_spi_txrx_monitor txrx_mon;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Class constructor:
   *
   * @param txrx_mon The component supported by this instance.
   */
  extern function new(svt_spi_txrx_monitor txrx_mon);
  
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
  extern virtual task pre_transaction_observed_put_cb_exec(svt_spi_transaction xact, ref bit drop);

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
  extern virtual task transaction_observed_cov_cb_exec(svt_spi_transaction xact);

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
   * This method issues the <i>transaction_ended</i> callback using the
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
   * This method issues the <i>transaction_ended</i> callback using the
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
   * Called by the component when a Beat has been Ended(Sampled/Transmitted) at SPI Interface
   *
   * This method issues the <i>transaction_ended</i> callback using the
   * svt_do_obj_callbacks macro, as well as the <i>transaction_ended</i> class member.
   * 
   * Overriding implementations in extended classes must ensure that the callbacks
   * get executed correctly.
   *
   * @param xact A reference to the svt_spi_transaction descriptor object of interest.
   */
  extern virtual task beat_ended_cb_exec(svt_spi_transaction xact);

  //----------------------------------------------------------------------------
  /**
   * Called by the component when Power UP Sequence steps has been completed
   * at device.
   */  
  extern virtual task power_up_sequence_completed();

  //----------------------------------------------------------------------------
  /**
   * Called by the component when Power Down Sequence steps has been completed
   * at device.
   */  
  extern virtual task power_down_sequence_completed();

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
fJqsZFq/FM/Eeh5pt+sDjPUDhkye/YgZ/rM10yFFAvSL+j/c76JDCL4GROejNJpe
1LJ7kaCj6+CfHmxhLygyPVelPpKviQKwpYIC9ojn5BJp5pbUHGUx7ntyO1bUnSPy
mVGmVzX+vIgfesMrXsZUINIz8UCKuocS2iojFwB4PCdZ/o8Mvh8AXQ==
//pragma protect end_key_block
//pragma protect digest_block
x17hSZiZ77Y1SyUFQYfqQRj8prU=
//pragma protect end_digest_block
//pragma protect data_block
n9BgW+q+i3r0RrEB2gn4ijawiufNlFR9Q8pBrJ2Z7Yzn3S4EojtU00TWl7YZto1v
WaTqUTPuRuW9P0u6bf6rLEDCi3e2r0kszhqhDxhYyE8mgnZpL8XWay0MFu/TsZal
FEMucPSbyOA9JwPv8PdvJNPgOMqN4ilVeG0KQd2ngxvNrzpzNNlCs//IhajrZZ/F
7WpH+AbrCNymwOcY/k6s/esIrQgBJCRoPVXyR8kMBdEIewzX+ZWQqCuT6oyWRowC
OGL8gpFfJiqtHpI/H3LSfTq6JaJkuHNlCqSLWaNobDVOvlZpIBdWbv0wcDvSrCpZ
KEir0gLtfOJ6h1W2nAxDNhTYAkLu1ZpR6h9PutvL6IVBeYCNtS7CE5qOwmeKZfZ1
Fp8sfg5hQnZ+t8fE9MX/bHLZEyuuKnbCh5zhZIsgjp4JKOHi0RAAajbmQLXValbK
Qw/lDLxQNxUsEXahtJTvu5Asv07AoFoLjCwO0g7HGXlpiSeEkF/fRB7LuLr+ombM
zgXcAhaWTSBNDy3/Uijmlg==
//pragma protect end_data_block
//pragma protect digest_block
4Tn+/duElTVyjG8FqbPeZBcBN+0=
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
Htn/FifmFwPXWWXS6leOqKemfQ2cG9wrvDGmTKHT8M5SZTaUcdhHldiGiSOfA3Bb
EPQGVppv0/5rvd/8Po8wT0dsMojr1ILNFaNzN1hp60WK0YPLWJ7tR/Xls6xOygR+
dci76HCYwZyIT7QWGa+t+vXkgbH9k6WYWUiVPXFcsTGMRbYaqPt6mQ==
//pragma protect end_key_block
//pragma protect digest_block
3Ggw0BjqsbpUcE45N7Sy58Tc6/4=
//pragma protect end_digest_block
//pragma protect data_block
u2Pv1pY4+6ttYQD2qXOkvpe4d1B4L7tdpPDjOZyeuPVcptqbwH2dAcD+frriYxJA
E6CgOKeV6AJQ2/dP0Lm1tWzrbxW0QDqixLw4e8OikSdVw39Kwl3n8pbfkxEgrIOU
zdh7QPqc50igZATb26u8D2CjOaQxS1AlLWIRFEVaAP79fT8UlXLoqrTK58B3SIBo
/lHS/IefUImRxSZ1oapA78S2lX/J9/qjQBmp9GvA6lksTj8gn2GHON+cgsGTWDRe
1YbHMdDFOXkLem0YXwJrJ2rLTN42UrsF7c4KXWmzOU7APdUHu0RgEeOgTdW7xfJ5
UK0CIxCYd0WXCAeHLjqNZ/WcQ5ucI2SGNhZAvZD+1bhuUrJa/4PcZyONVP7efEAt
tgr9CF59oNmqEGo8G5MXif7DmXiuLMyFQP+fmjJuQCZJwPhUFV18bGeWsmQLfqJN
fOnXeSsCCxdKSsBoystwN7WKw/L8Z3TAiSpMgwZVx8eL9XIKSThYofINrJ4hJH/a
U8/iDgXJcIPQbhYiecUEpv96OMRrNxhJImGu8rm1n/l2ey3aQ8+qdY3h2B2sguBz
jQnQ9N+3cj5RZ6sne2nV4guZEFK8LvwXf6iJNeyyiTldMu5vhHStnFsAX0CtiDmu
2arQWtBRF6Dv7dem3gph8Q==
//pragma protect end_data_block
//pragma protect digest_block
SdSnuIcK3WsTJymEFS5ZSJ0BFYw=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
hEmxQJpnfHW+UhZe+ItBJGP8QEMVOFTg++eNUc9t8bOi4W8MBN/uqt3WMmupBXuu
WPPBtCj2ov+jmQZGEHOvrcgGQ9kkPChOwsSXyKRLC/tfQv/lF/qGkXZajlc1gamw
dJGE05m5r9DvPg7c2oB+73lUwKjctx9XKuOq4718bQE7bOmsV73YMw==
//pragma protect end_key_block
//pragma protect digest_block
q4J/THxnTLKd+/F3+GVT9Npv4nE=
//pragma protect end_digest_block
//pragma protect data_block
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
ViJRpgKnMD1kenSQVB5Pig==
//pragma protect end_data_block
//pragma protect digest_block
8ubrv2DXobWhYk6UACHygeI5B28=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_MONITOR_CB_EXEC_SV
