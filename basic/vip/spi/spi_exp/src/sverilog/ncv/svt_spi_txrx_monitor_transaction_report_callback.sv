
`ifndef GUARD_SVT_SPI_TXRX_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
`define GUARD_SVT_SPI_TXRX_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
 
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
3efd+9VzQrIDPU9XjMfAZaoZ8IhbSzv9GGbkM7aaltg/oJHzcBPfRcVVzKJwrSKV
Nt1gTf5N30UAvCqWifBnUpiaSMUnghzUp2C/LSBu/LkA1q00PVzQuBhla36QFah+
Hi2OArUj8qiXDqwNg+Zbbi1RkxuJAjucTzxiMPt5RWDpOn/WMJtsbw==
//pragma protect end_key_block
//pragma protect digest_block
lauZdMUlhWKmkZCTnlUNfMofCWA=
//pragma protect end_digest_block
//pragma protect data_block
jsEBigNtvjmeOeO3aBeyq+a6x1W3QNHyEaHGT0+xmfmgev+2GSr9EjqaBKHDc1Z/
blIEzyIsrla/faR1URwnqGUMZ4oFHlFrEHF5NMo7hnkJB0biB5xF3+otN9nbvc+h
NfYgA88YunB+CsJa4NxxL7HbOgZeq1H1kuwWO4pCA9QWW/H+sv20Y0Vp7JRP0KFc
qas8yA05NB8T3NywceuObyzDbJWaYOOA/xzBgXkm69PXYZY9MA3360eUxKh+rR8+
YjKTzuNvLiot28IQL02ovE2rbV2lBzWhm/K6JEvpfUkCEMbh7QKHMWE2w5WVA8lZ
UzPalOHNxAv3DmV0tE5gD6MlgkPpt/EJE9iPggyCGhr+T1p576LUdx5hvpdJR+kx
6DB+kQ3Wy3JGvbZxvWBcSfwy2wexyk4wIvqmx6jRtFOCA6VqSjNAe5MOX1So8dN+
/vJG9THQAamGjI4ecZXT1KmzSWsoj1Ak2FO39nfdGIjxy1+WwPIO7MMbhfgPcgo3
qRkqaI++H58UggFzzfNYM2ARAm8TZPvtzl9WKi1lwGoTrE3lcbmYCYSmzntAVpxT
fR8HJ/D8p/tYAOlRB5vXmxuFnNQ0lxOyq1TJeec55RThmVQfDCTSphh6NuS3vraz
pubz9zEYeBRJnUyR10lqnmk9C1eIUo2iG6i8ReryXUSPX/IVnrmemkJyN8O0tAJ/
0NkL6l5t6a6uhsOc5V3gTI9IY8mrp/VUcBFFPOjkSUUqHHHneJ1xRuzWU26lMuCA
K0j5EKw3ONKSC2LxxirG2nGN3eZ407z9kW/1XHRcohIWwHs+HwmfxBL1dvjCyp4F
5AGL2UEVOd4FA3Wek7KNtXxjRwP5F3o5TKdOCI6IOMQ=
//pragma protect end_data_block
//pragma protect digest_block
gklX9LhvRs0j4dVg9T+wFjS2OPw=
//pragma protect end_digest_block
//pragma protect end_protected

// =============================================================================
/**
 * This callback class is used to generate SPI Transaction summary information
 * relative to the svt_spi_txrx_monitor component. Transactions are reported
 * on as they occur, for inclusion in the log.
 */
class svt_spi_txrx_monitor_transaction_report_callback extends svt_spi_txrx_monitor_callback;
    
  // ****************************************************************************
  // Data
  // ****************************************************************************

  /** The system SPI Transaction report object that we are contributing to. */
  `SVT_TRANSACTION_REPORT_TYPE sys_xact_report;

  /** The localized report object that we optionally contribute to. */
  `SVT_TRANSACTION_REPORT_TYPE local_xact_report;

  /** Indicates whether reporting to the log is enabled */
  local bit enable_log_report = 1;

  /** Indicates whether reporting to file is enabled */
  local bit enable_file_report = 1;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  // ----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Creates a new instance of this class, with a reference to the SPI Transaction report.
   * 
   * @param sys_xact_report Transaction report we are contributing to.
   * @param enable_log_report Indicates whether reporting to a log should be enabled.
   * @param enable_file_report Indicates whether reporting to a file should be enabled.
   * @param enable_local_summaries Indicates whether the callbacks should create localized summaries.
   */
  extern function new(`SVT_TRANSACTION_REPORT_TYPE sys_xact_report,
                      bit enable_log_report,
                      bit enable_file_report,
                      bit enable_local_summaries = 1);
`else
  /**
   * Creates a new instance of this class, with a reference to the SPI Transaction report.
   * 
   * @param sys_xact_report Transaction report we are contributing to.
   * @param enable_log_report Indicates whether reporting to a log should be enabled.
   * @param enable_file_report Indicates whether reporting to a file should be enabled.
   * @param enable_local_summaries Indicates whether the callbacks should create localized summaries.
   * @param name Instance name.
   */
  extern function new(`SVT_TRANSACTION_REPORT_TYPE sys_xact_report,
                      bit enable_log_report,
                      bit enable_file_report,
                      bit enable_local_summaries = 1,
                      string name = "svt_spi_txrx_monitor_transaction_report_callback");
`endif

  //----------------------------------------------------------------------------
  /** Returns this class name as a string. */
  virtual function string `SVT_DATA_GET_OBJECT_TYPENAME();
    return "svt_spi_txrx_monitor_transaction_report_callback";
  endfunction
  
  // ---------------------------------------------------------------------------
  /** Builds the data summary based on SPI Transaction activity */
  extern virtual function void transaction_ended(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact);

  // ---------------------------------------------------------------------------
  /** Builds the data summary based on SPI Transaction activity on TX side */
  extern virtual function void transaction_ended_tx(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact);

  // ---------------------------------------------------------------------------
  /** Builds the data summary based on SPI Transaction activity on RX side */
  extern virtual function void transaction_ended_rx(svt_spi_txrx_monitor txrx_mon, svt_spi_transaction xact);

  // ---------------------------------------------------------------------------
  /** Return the current report in a string for use by the caller. */
  extern virtual function string psdisplay_summary();

  // ---------------------------------------------------------------------------
  /** Clear the currently stored summaries. */
  extern virtual function void clear_summary();

  // ---------------------------------------------------------------------------
  /** Utility which produces trace short display and verbose full display of SPI Transaction. */
  extern virtual function void report_xact(svt_spi_txrx_monitor mon, 
                                           string method_name, 
                                           string report_src, 
                                           svt_spi_transaction xact);

  // ---------------------------------------------------------------------------
  /**
   * Controls the implementation display depth for a SPI Transaction summary log and/or
   * file group.
   *
   * @param mon Component reporting the SPI Transaction. Used to identify log and file group names.
   * @param impl_display_depth New implementation display depth. Can be set to any
   * any non-negative value. 
   * @param modify_system Indicates whether this change is applicable to the system reporting.
   * @param modify_local Indicates whether this change is applicable to the local reporting.
   * @param modify_log Indicates whether this change is applicable to the log reporting.
   * @param modify_file Indicates whether this change is applicable to the file reporting.
   */
  extern virtual function void set_impl_display_depth(
    svt_spi_txrx_monitor mon,
    int impl_display_depth,
    bit modify_system, bit modify_local, bit modify_log, bit modify_file);

  // ---------------------------------------------------------------------------
  /**
   * Controls the trace display depth for a SPI Transaction summary log and/or
   * file group.
   *
   * @param mon Component reporting the SPI Transaction. Used to identify log and file group names.
   * @param trace_display_depth New trace display depth. Can be set to any
   * non-negative value. 
   * @param modify_system Indicates whether this change is applicable to the system reporting.
   * @param modify_local Indicates whether this change is applicable to the local reporting.
   * @param modify_log Indicates whether this change is applicable to the log reporting.
   * @param modify_file Indicates whether this change is applicable to the file reporting.
   */
  extern virtual function void set_trace_display_depth(
    svt_spi_txrx_monitor mon,
    int trace_display_depth,
    bit modify_system, bit modify_local, bit modify_log, bit modify_file);

endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
DTVdxIbFo3rYnPn9zhVll+/eGfxYeUjcWmHbMewmaIS4wdZ7xY22CuiqQN/Yi15N
H8XNuPrIh0fyv7Nw1lYzw0KaT+6+Ty5AqHT/ocPRP+TDEbXa3DVRy0uyV1FfyiQ8
7BRMJEZpvxUY51fme0GMCGwRi4kZgshJOsKuuX7xVkRmPYojJyFIJg==
//pragma protect end_key_block
//pragma protect digest_block
+HnAMa9E+QWRs47uwlUcJgUCr7I=
//pragma protect end_digest_block
//pragma protect data_block
3W5isBFG3PVM9KMAYh4wAnga7p2UeK+6B6a2/tBG5XuGISm+jqhnsr7t5+pk9VqO
uBzXLQGOLCqLQr12We97iPS7wlXfdOZEUQUgf9t09kl04sm9X2jp5ZnG35p7TieP
mKvZmdrq7LPbzh9lERWgqerQnbtSkvOZ7iLYBoG4dOZ5wJwCQaQNlYQYzv1MEAhr
qi4b9uJR7u8x8bLE1uQDPK3G+BE7BnjjQUR14i994ihoU/99bBL2UdqaSUUWtEtJ
JbdkoRP9b5IPereIpQCsdmGsaeBoRVD4CQUulY6kEBCtGiC8pdBaL5YIv24bxlf7
XnxypmDYtfJb4X8Yt9pLgbL5GRgIHzgOKB3YtOibDU1tFl5RceOj/gduUhqerlsh
hsvRR8QS9R/DK2vxxlNBUBnFTu/C1KfWHnWbtm13eZRBvhtcrCjd7p29/YGZH4Yn
elrCwFIxJru1tzs7FBYGt9gOd6EyiOM956Un4919N9/Xg0/DlLimzrtf23lDye1s
qTqV3o5Ca5/YRzDGx/a+FtGT+tl1zKfC9EyVEKH7RwnioPObl4jE+lZs6qOg3wNc
Ek3YXjooHcjAmM7ACY4q+Psq417zwdehacgJjmH5ho0PMwFpwJ9aC8DipR4qeWHN
YTlbGg6UMscOq1tj5jhkZ1ns59YJZrHlpOZvnTL0p2THaaQ+YyyeX/LGwE/GKqkT
YJv/0qg/cj5ZquhQK89/i7lrc+aUOjPOdQLat6vpA4j1j3yrd+1jmliMpnyvoKrQ
JRgWOOiUM/iOnMlUQRXqkdlX4C1B8t2U1RWFEjklYq4l4HahQ44O9B+YYC18gX5C
ymhYLy9n7WQIA/B+fdSq2H2t65XJjh935X+aQsRKfOQtIpntE8MRiMXqZ6eT654h
5WgAZ6zN7i3T7rOBuXI67QGQ143j5JS60up+wkFmkNEsGl2lGonXPi1riY/xeXwC
790g2hgDnMhpv5othstyHtlG3ukRThUbUlQucg3fgAlqIF+1NBdNzxwjF/vV6MWL
Tyi/4VXYApwrgh8PAxaNRBAn7RIgp0zygo4kkV7Rv/AHjPpEXGdurvl3QCwkFTlV
ooDZunvljmHzXuHmCsVnA3TBq3Er6ACf4xoOhyMhvlXCS5TQbzQz0lFznecGt6aT
1GyooEoK/zlfOYiiaqLNZeejASKhpMDcQutTSp+WHoAI0S7sHxepIpQHBPFLqYwq
uGGJyPxx0Ghz9INT3QnBB8eNb+PQELrunXe62OpMC20WNow4fYPIwWGqscgJM5ou
/ex2Lkiu43BpSjRopOO/zaqr6nRvPZzB23K6euG9MkmUFtkUNrDwU7SSt3glixXr
jf0UBlU1NuL4mpXMhgEO3EDzrh8+XPrDs4zX5RlJgAnIg5doOjOA21fr5y+3fuSb
8hA9IYa8p2PTkAAuuHI1+61PVCCV9LtJz9BjPp2ysY45XPzmU5OwZ2hAkwADxh/P
sZ0Ffq+U3SN+XVD3THqQpz8fHf0U1553yMqFYAjCXe8hkkm585uvAfOQ8fPAwGBy

//pragma protect end_data_block
//pragma protect digest_block
TRMcE8JBUSDkedZK81GRULaCORQ=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
KQUhOWZGqoCrylj47ZxOq6HeYWdvtlaGVtdbrE/JSLxL4SaZbxrnckn92e8g2XHO
AmvBo/xtZt0WD367cYW0knn6wDES39nPPjb9uFi2bAPttf4QoeylmyJNv8M+g8+A
wWW5+VCXaWi4tIvDad25+xWRBdsZuZrACl3DzVMSTpG13VJk238QcA==
//pragma protect end_key_block
//pragma protect digest_block
iWPLnNKu3yzmkQTCP6HLj3El8/Y=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
NxgFun3yRbtAFp4Fzz1bsirieto=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
