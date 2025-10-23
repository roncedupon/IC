
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
CsQc3PT/qhSJlbPibTx9l+pwxFyp0dpT3K0OJrzUWOnoa6Z1p5rxdRwh9NyOxZxd
StVe1fIT5VFFLt3xEkRd57Lz0p9gu59m7bGiPwAmfTLp3tK+4EmpGWjU4ib3ZxA+
p04OabJzrCUvi+SLiJ6mqt4k8RNJh0+B0HCwZ++WpONl7732PniG/w==
//pragma protect end_key_block
//pragma protect digest_block
3RjkJu+Wq+KGpclCuGv5CS/yOHQ=
//pragma protect end_digest_block
//pragma protect data_block
qeldcrjuKWrNe7Ja3+akvWo6pLyvtU3zMfLx73aRwfQNaJAKfZXVcXpLmGTrz1+l
VKIftjQlEhAwoJvHpCrE2JsqqMen6hIzPN3HFWTSoeMubG63dHXtb9vHOuKdzl6Y
Q34chVqtk/tFUnHlj+YrP9+JBUFyrX6dVu9XqLtgz1MAEK8FVkGI+F0nHQxl09Ay
C1E/82rdkk6Ow3FZpEb4Op1S7w5Vp4k/O5JO/rutaH1+mFg7GQtWX+fA0n0paImm
WeuY2Y7vGE/WRNRWGiQV342/0GwXN88XcvLlq6IUyQj3Xj6SU6wcF9zGGtSfo/jn
fASdgyrpSQ+eKOR8l9Aw/OTOMUKd/oiqDPgJ5CTnjt8DV7VbUa4aXIG3k7PkhGbl
J7ks/NzZ1N/JZs0LkJbcaUDQzzczsn9LsJ9VQkhqwhTY0S90PO78whzcq5VLS5dY
byuhReo6kgP6vxGEcMBS2c4irIZAuzcnJiu5V0z4DVfwqQ9BlEqC53D0uAuS0TdJ
ixjraXcV2EhZ60q0TDy+STPjNrRGY0WOvf14pg//z/IlXbNX9gpIez7ElpUhYjvS
5rTHtpcD+8xPbWN9MO5I+0Oe2cKqFlRyzprYOUcA4y6+qSDXrFX0NjTsnKU2i4zp
FSzFIZfsPxWH+bw4UA8dteP+rnmUiDB2XHvlKUhuH+0IpeN5eFLqMIyVrwWhOKCb
6QGgH5Dn/ETzlWMlLJXMuOXHxfpiBEsLNgaQ/8sG1WNpv9tuYL+FjBvj6UmaQwnN
f9ojGDcvQT5EASIo0FO/ag==
//pragma protect end_data_block
//pragma protect digest_block
gF4c+UvMlP8jkMBVS/JJFUON868=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Nfhn3kda0g5+Dw1ePEzI66TCJUv7L46lxBx2fgnhXWmXz0RMXmCcz1x5t8yvmpOC
sPM3215LZFTI3tULDFjmiVDWCIZkovWLfOkN+7WeCunn5vImtk/6+UN97WgbCrxn
JWX+KalplzYBTw44e09Tu06RxMeguZAk/9q6cjn7GCiWU7zcPbZFeg==
//pragma protect end_key_block
//pragma protect digest_block
9V6kQKHCWu+UtStpYLvdf97AmJY=
//pragma protect end_digest_block
//pragma protect data_block
mK8lEu/DrnpvmuYiGwXRurhCq+mk7LDkkOGFAsR2VtjNyFKXqVzWZxA2DBkBfmFz
nzC6ePx4R5CuV0VfY1w9xImZ3MH6+5tdlp1JwT7oLjju9XMyj9NSUQdz8sxx8zW2
KO0sQae4exbn3F1RvTNFMeBiI3RD0+uHSAOvXfZLRN8OJ3XBrqwW8e5lDiYlyxJ+
Mz4EJ1+xORLZmzNp+suoMvegJGBmKl3igmqU6v5yHEKK3EMZVdUKqkZAEpkL0gs9
ya3fPPYrRkMThwHDidQp5qweW4qUpeth/XUQnR2d6E+POpaYrLDLkd4dM3svx2ug
aCSBqMSBzX/f6ofEUkstzXVx5dy8Pt3+6jsIzLm8pX5tHJ4OraIN2njVCVYZ+YH7
Xxh4pZFYX4lKqp7BFiXGwnORUvntErzhJsLJyk6xlkMmvs6c1z5Hr3EVe+zT4mkm
b74aJdl65srEDl1UG01RrqP1abzp9zMWLEwaANGdE3uzJrzNp8b4uAyVy0SFrixI
N1w+0/fjfEOuuwJdlqLX9Ey0XfkPo1BOmTIuDaBxLf+20N5J70PipWkxin3QF4eW
ZW6+f+B6d/gDY+T2XbJ3hkFQF45mHeqj1fHss7ARL+adpQWvD6lmOS2z1XjxVo+Y
KKRxISFGKfFfWjG/vD00EBLICMbhc8nLl5OvaBUYj8oAgYtE8FSKcYTE9xqN3+D+
DcvGkrSBPe18HhM0DuMD/wd49HJ/HWMLE4f+Gd/pV0S5Hi6+v5la5JfiYH+h45kG
NF483xIDPg6fxwQ3VeFNVR+WiWgX83/kyoN/gvHiGxbiAlWDdAjsfQaDdWdRBzYU
8cSiG9wxbkGPzhfomNN/M3vlBnawIWekntahRTugIYCyuk6oeDnbNZ7YEshh/Fx0
FxuZV30ZPtYroKbnpKaDBXZJy682dij6LwyW7DpqfoY=
//pragma protect end_data_block
//pragma protect digest_block
UngzyKZqdjZ7fehGZidllUVxK9M=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_MONITOR_DEF_COV_DATA_CALLBACK_SV
