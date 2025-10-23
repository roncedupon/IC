
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
qAYHEYOtQvqIXigi1F3oFGhA0TZ99COom8YlinzPGgClOS5j9fcvYgjUpAIQFJvT
ChTi99h3fTY4OFQH9rzVLJtN8UPeH89chAIsMMgtSXmZHXFfY44vHZEmDcc1L8Hm
a6SzNV+CPguFowc1dv08Ii/3PBkog1SRbLtmePSkCKiGmeAqrKtrcQ==
//pragma protect end_key_block
//pragma protect digest_block
Lv10Zy8mUMRpbofLy66o2SJJ6Yw=
//pragma protect end_digest_block
//pragma protect data_block
GJX1yxCy+pq1j62hJCdjmrfxQ06rHf5qEqdjOEFOyqRT7XBa0NK6mok5V4X93rIz
H3NMAXroMjoQ2vzwV55fAQoVWSy5smdAONU12wCn4WLBmcULX6ul/+hL+Sc3berH
Nx5unIWx/x1arQbi3PY/WAXROR3drmfe2AC5f6OrpDRbB1L/c1ASR0r7i2vy7UCO
UnWLR/+KVCDCDHXATF8oHgys10owM6AlGyk1rVnG2yiqWQpYgCr4ZQsg5NcNELXE
KTiDUf1jzS1umky2umJbuBEGE5TuDsONW1+AzIUj1L8DoEuXcRayG1ftW/8W3tQI
Modi/Qwzo7NqFIYwIl73nzw/Jt9kkDjE/F2wnAUMkg85x5qLxmERD+dx9Hl6+2IT
GCFu5VL4lRgmaqPYeWRjxCMYGYHYYrk3fhIRGqJnxM7UtqMfNiwIAvpuvDMKtHNS
FHTceBeoYbDlYVKfKaYyv/oOo3Dvt2D1JKU9cVY7+ZgsRbvDzqYLOkjaFjH6skHX
5tqhkmwMOJbMCiuy5frGlKSpu/fUooX09f5otr5dhP0qpjXKjkAy+Gud1AM8qaxN
j0IdPUfiuPBliQQcUtYBfFngUQShoh1ytWvMo0mEugoMMsU6ofDkqZVIyxVSu5sw
BvebGYCX19eWIGfOHGRBIudSUTz1NrvRaSDFqdy6Cx63ATlsxoLHChA0LTw6qJu0
XuIlGF743Ckh8Ebk7jkAa8l20dLHri6Ik/xSSRCMYA7i0btr7RVPrbAKm6GKgs1l
4VQO/Qy6/7iMsbEJogT5BhvsaPUrdYU8/i6Ibpk1B/DzX8nyYFFOmcz/M5UupyVJ
jwEcK4KBT367sEAf++Wv5fJ9a9hL7eeJmDCZJxPw7a2nfExyyklYX1grs/XBgLOo
DoaAXXX8StuiHL9f+YEf7u8yeFOhHGOv5vzcGeY0bYsa2K82a5lAszhISxTdlKdh
v6/kmWgyjEdhJ2Q2d9csXw==
//pragma protect end_data_block
//pragma protect digest_block
NZWAoYmgO4UFkIRAKKdjv10sZM0=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_MONITOR_CALLBACK_SV
