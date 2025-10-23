
`ifndef GUARD_SVT_SPI_TXRX_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
`define GUARD_SVT_SPI_TXRX_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
 
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Q2WUlAU+PHAcAtzloTEEqbxk78NnabS+i0TgyVlN9uvFlV22JX1yA6rmEuKvN8F7
kKGaqpc33NQ5+JU8/npbidCDWnxwEQ8DgNQ5WdIoQ+z1ker0dwxVHYJ16zWSNjUU
ucNYwL8053ltgvGRqenWMxU3THZJu/b9Lgd80Hr4sLo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 486       )
P2dIZsSqT3JtZf+xFbh1LnCcvOsENxnbfw8E8C+H2iB/lOjj+wr1PloJU2+fw47s
oDi67Q2nWYwIozPWcFinTDIiuaHGxg27ExxlyALecHQVI2HcURg96exus+2CXRf0
BDU/eK6cjHZQIju3I2AjVzyL7gvFptLLz+UWfNM//b6UJXNGsJ6Tb5nNNji7nnwK
YYgdLVue62N8RaUY/DKOpGpRkh9y3qa91E+y/ME37uncyVryNNn16Fisv9mpS2xh
bf8SvRaEoIyTCh0tMW7ouTNTiTPyvDLMmQFyl9WKyp/rniiJxfJpXGKOx3XrjnvF
yFnk4dHL/+tX7Jx7sr7pcYuzMpk2QbfG3JIqrPhGw49pF5FjftwlqaetmQWKliBr
JwNBWk4tvigssRBdyRJEToo1/p89x6Jg570QUVlFZZSZ3BiwrOKvXGaVWrsVgv0T
8Te4Q4K2vgHwIuV+mKh+tP/af8bs/VkylTUF3+J0bBGxHjeTbjYnxj7hvDWeTnNp
OFL89ek04FInZP4d2bi/5t7m9vQ4gL+1rQzmF061eibappZxkfwj4uvt3x8j5ajG
nnKyPjzQFc69Gz54jByraeEseMy3wRm1j8oj6kC2qmvjBKujjxFs7qBGrdgO9MLY
REjonRCIYb5mgFDnvLU7cQ==
`pragma protect end_protected

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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Huc7hVdKDGCHf3qFY/MRzL3GcUqqUE9UhbPUs8JEysOZCwRGix0aQ+H5/cUxkYKQ
sRSRW6dSrwksNeCOczmJpTCQRbjD7+/kq7js+z5kPm9B8OEkj0y6v3LB+2NqbXY2
m9fNmsEgq4mo8vekfZ4Nx3FRIZEXvVdy0qEjg2stcQI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1459      )
+i7YKtgehtq79Uxn9YWKlDQFOVpi2OzGWynsm1G4AEly4RJHvOe8qck0g9nMM/iz
z67fbBJDeyGyJD7EAuhUQ8k+ge0OKDXdr2ZpcFehzuvfjwJJU+QAUZzN2QhZf58j
FQHPf6BU7AOvVKXHerACrE+gTbwkGvUJ5C7n/18LM6eCMTV6+BJ5mSw0R/U2Dynb
aWRbWo5UrjNonYzkKNjdEyJcfPHoxFxuiLGXTfbv9PM860nOX8KHQycee3L1uDYC
T+sMiLs9Bu1gWGX0yA6scNg3TLxC8LhfBxqRz6+B4FF76mdcyHWFt8GD+xWZRHPj
MeOzDB49kQ8J+WSTE0noKUclYI7qkqOfhgGUGjl/kW68TvN9IvM98vPg0VXCaP0R
AdCzdvi3mdr7lYt593WMALCxcsjJI2KaLY5T32hLHDAx10pRcbOmJWiVWDIloCZ8
GZwiBv1yGliH6XNdkNjHpONu/cIUgYv52uO+4GB3riLruQJ/twlTL3aGcrUoC0ss
F8nebqE0+PAnYv86KBsNLfVIGwTOYdTxjk6ouMe44D0jLnmrAax2CPhY1DEL3LN8
0Oa9GOj8udjr9uhzZiCuryNxLGqeQxlxNx6SYlLxiGmY/SJrn3s7SdTwbnxN/IYO
ktdG7dxdVpli6I3CrLbWOW8sXS+F+cVgPsD7HaoxYziUUnWPB6H1JFVLa4NCgdzM
QayfDRRBdvvsQXQC4TzORA7enTMZIod51t2gWvD0oFKZulJ3FGq7KX2uG1ynA0dX
zAs7Xe3Q5kO/HBF9dmTlZFn313yCwHU9hwwuyo+As3y8tnx0t2JGj7i30ZjNL+aj
CxnsN88zIhfmWjXe4V+U+NZLr89mChD9f5FZwhA8jbr5Wg62+ysTiVA91duUQ4wg
caZW6yBgGARs4Wokpb+GkrBXl/aPA1nCjCNldIaDjofoQ7c4S0s0g5qYZtO4eJIA
+Hf0UwjlF+osksHT2XBefmFWj8+4zGyrkAH7O9RxkNZ2v9vZQZd6VnVp+BLpDIrF
UU6JXps3PMJsFnkZT+yYv990yLsKROXhmlyfHgImie5Dtb/a26tc18YGgD+Zm5oO
MObC+CulpcajfuIpUn82OsS+ghliFzkaft+yLtdABz2oO1xNY1DGzqf0ZF1AC3gx
Q8ZLkORx71cGAMHF+fR+7l05ezVz/+22FWovrdrxvo96fh8aZUYEuLM6go0FI5yR
VmdlklwFab6xcRe/lKRH3yFysKMYjCoIQoY/8rk70hSRd6k9nu+oLwJzZkxpfB5J
27VfH3RaYXYHQOuemDTuQw==
`pragma protect end_protected

//vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
eh+yuB68x3nTmquF0+kyzJgQVpPSdGOZg+sBpn1szpWSph/PKwC1miC+7H9THFFZ
jHK8Zo4TlMRK0gK09cOC/HE6VburbMzPR6hB3a3tKu7ckPM6WOVQrroTglReE9Md
fjeAY/s9UihixsJjXi8OgGs560l1Ly1hsdGBZQBbZK0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9088      )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_TXRX_MONITOR_TRANSACTION_REPORT_CALLBACK_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
AszTNqPhUO6GAojhEbE4HgGDEQ3BLym8sv9BpcaXq38PGyi2Hn/KM4eD2fXwASEm
70aoPEQKm/JXMabN5EuGmhvQU8QZYe6pa6TAnlPa0XQuM8nUqmBy8Z7ddO4XBXOT
ct8TlSCN9ugfXC8VKgPm5PD2L4ZwfNyBKVxlW8NRI3k=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 9171      )
pvEHPCrywR6N8Hpk5IbFy9lmO1SdERYoKdLoNEWARYhSsaH0rRIJTs68YmpbyYd4
s65blXVpR4kf0FQ5iO9gay+BDEoIzK1pOwPX+KSgyNVBOCtCtwuzfNmwvC+2rZM7
`pragma protect end_protected
