//=======================================================================
// COPYRIGHT (C) 2008-2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_TRANSACTION_REPORT_SV
`define GUARD_SVT_TRANSACTION_REPORT_SV

`ifdef SVT_VMM_TECHNOLOGY
 `define SVT_TRANSACTION_REPORT_TYPE svt_transaction_report
`else
 `define SVT_TRANSACTION_REPORT_TYPE svt_sequence_item_report
`endif

// =============================================================================
/**
 * This class provides testbenches a transaction mechanism for reporting transactions.
 * It reports summary information for individual transactions that are in progress and 
 * accumulates information into a summary report.
 */
`ifndef SVT_OVM_TECHNOLOGY
class `SVT_TRANSACTION_REPORT_TYPE;
`else
// Must be an ovm_object so it can be passed via the set_config() API.
class `SVT_TRANSACTION_REPORT_TYPE extends ovm_object;
   `ovm_object_utils(`SVT_TRANSACTION_REPORT_TYPE)
`endif

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
CxDjV+zSILROkMxub59J3Jd0p85ta6wvQIHBBz5l9X+XJLI7XS3blqQfl0+YiDCs
NYMGVDNP9sddilB2hIfN1f3XXzCMafQbKrohjhSqedo9YsBcnPLOUf4YCHx+zGEp
io6W2o37TkStalXbT7pAzRgN5f91kOAFV86VgXBElJw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 523       )
LROx9uX7VQIeKiQvmTYq/vFTvZcWxvwN6AYnKBmhc2TAhMGYFWErOY4aAUsXT+9K
EcTsyMV9IGp+dY0JmiZLrcGnzoiPpqD+38AP2yPYJpMiYG4UAJk1Cx7IjjWJ6ex9
gIXepX/XPGoGXLw2FYYghQ2b3AwcfCZ2dgF9C29sqoMEAuYzLuDRnTAFV+EiwWnA
a3H78suY+opbe4VbWeDIRitVZ3tpHUbn+ecixDJfowWoMrAVUfLGxeBslBiqVBah
zTu2xKCp6sjoRULRWDrTYmECfFupnRm/Me+Ejwc/enKAt9WGqQ1Gs/MGUvB3hbWj
0MItp2ImVh5mvWUnJemJWekpWfyF4pRCT26kA7pxpcWMxN6wvXrda7Qy6X2rh4Lm
Of474KHjY4q5+4Yadjt6RtCH2se23gPP/kBe1AJ4R/D/+OBcFvI6WCxv6AauFeup
IFmWJ7DIn7o+xP7jjhrpnftQ7xDKzdobwmyHaAf2/1iG7+mHFlWYkVaX2YsZMrpp
4FkRHSPorPFDiajNlY1SS3rDSoZgBpkoYdk8ZXWsaTiQwoUhLWtpR8hkBvu0uwM7
CgffW2fcPsfmNDANmTVOCqn9B0qVNQAE6wPIZEIUijIBs9+glHxUdZOpY/Txef60
0odYdTTw+00IMZwcFQrYYWwhEU9r50dyVbDsYuo2Hr7tLb/0d2tZm3ms3Z6pwtoM
`pragma protect end_protected

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Shared log object that can be used for messaging, normally just used for warning/error/fatal messaging. */
  protected static vmm_log log = new("svt_transaction_report", "class");
`else
  /** Shared report object that can be used for messaging, normally just used for warning/error/fatal messaging. */
  protected static `SVT_XVM(report_object) reporter = `SVT_XVM(root)::get();
`endif
  
  /**
   * Used to store the tabular summary of null group (i.e., summary_group = "")
   * transactions as seen by all of the chosen transactors and monitors.  This
   * feature uses the `SVT_TRANSACTION_TYPE::psdisplay_short() method to create this
   * report. This is the one summary stored directly in this transaction report
   * instance. Grouped transactions are stored in their own `SVT_TRANSACTION_REPORT_TYPE
   * objects, inside the grouped_xact_summary array.
   */
  protected string                   null_group_xact_summary[$] ;

  /**
   * Used to build up additional labeled tabular summaries of transactions as seen
   * by all of the chosen transactors and monitors.  This feature uses the
   * `SVT_TRANSACTION_TYPE::psdisplay_short() method to create this report. These
   * contained transaction report objects are not provided with labels, and are
   * simply used to manage the strings that go with the labels.
   */
  protected `SVT_TRANSACTION_REPORT_TYPE   group_xact_summary[string] ;

  /**
   * File handles used to create a trace of transactions as seen by all
   * of the chosen transactors and monitors to an individual file. The
   * trace feature uses the `SVT_TRANSACTION_TYPE::psdisplay_short() method to
   * create the individual trace entries.
   */
  protected int                      trace_file[string] ;

  /**
   * File names for the trace files, indexed by the group value. If mapping
   * does not exist for a specific group, then the filename defaults to
   * the name of the group.
   */
  protected string                   trace_filename[string] ;

  /**
   * Indicates whether the header for the trace is present (1) or absent (0).
   */
  protected bit                      trace_header_present[string] ;

  /**
   * Controls the depth of the implementaion display for the the null
   * group. Defaults to 0, but can be set to include implementation
   * display to any non-negative depth. Updated via set_impl_display_depth().
   */
  protected int                      null_group_impl_display_depth ;

  /**
   * Controls the depth of the implementaion display for the the indicated
   * summary group. Defaults to 0, but can be set to include implementation
   * display to any non-negative depth. Updated via set_impl_display_depth().
   */
  protected int                      summary_impl_display_depth[string] ;

  /**
   * Controls the depth of the implementaion display for the the indicated
   * file group. Defaults to 0, but can be set to include implementation
   * display to any non-negative depth. Updated via set_impl_display_depth().
   */
  protected int                      file_impl_display_depth[string] ;

  /**
   * Controls the depth of the trace display for the the null group.
   * Defaults to 0, but can be set to include trace display
   * to any non-negative depth. Updated via set_trace_display_depth().
   */
  protected int                      null_group_trace_display_depth ;

  /**
   * Controls the depth of the trace display for the the indicated summary
   * group. Defaults to 0, but can be set to include trace display
   * to any non-negative depth. Updated via set_trace_display_depth().
   */
  protected int                      summary_trace_display_depth[string] ;

  /**
   * Controls the depth of the trace display for the the indicated file
   * group. Defaults to 0, but can be set to include trace display
   * to any non-negative depth. Updated via set_trace_display_depth().
   */
  protected int                      file_trace_display_depth[string] ;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Creates a new instance of this class.
   *
   * @param suite_name The name of the VIP suite.
   */
  extern function new(string suite_name = "");

  // ---------------------------------------------------------------------------
  /**
   * Create an individual transaction summary, with a header if requested.
   *
   * @param xact Transaction to be displayed.
   * @param reporter Identifies the client reporting the transaction, for inclusion in the message.
   * @param with_header Indicates whether the transaction display should be preceded by a header.
   */
  extern static function string psdisplay_xact(`SVT_TRANSACTION_TYPE xact, string reporter, bit with_header);

  // ---------------------------------------------------------------------------
  /**
   * Create an transaction summary for a queue of transactions.
   *
   * @param xacts Transactions to be displayed.
   * @param reporter Identifies the client reporting the transactions, for inclusion in the message.
   * @param with_header Indicates whether the transaction display should be preceded by a header.
   */
  extern virtual function string psdisplay_xact_queue(`SVT_TRANSACTION_TYPE xacts[$], string reporter, bit with_header);

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Create an transaction summary for a transaction channel.
   *
   * @param chan Channel containing the transactions to be displayed.
   * @param reporter Identifies the client reporting the transactions, for inclusion in the message.
   * @param with_header Indicates whether the transaction display should be preceded by a header.
   */
  extern virtual function string psdisplay_xact_chan(vmm_channel chan, string reporter, bit with_header);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Generate the appropriate report data for the provided tranaction, placing it
   * in a combined report for later access.
   *
   * @param xact Transaction that is to be added to the report.
   * @param reporter The object that is reporting this transaction.
   * @param summary_group Optional group that allows for the creation of multiple distinct summary reports.
   * @param file_group Optional group that allows for the creation of multiple distinct file reports.
   */
  extern virtual function void record_xact(`SVT_TRANSACTION_TYPE xact, string reporter, string summary_group = "", string file_group = "");

  // ---------------------------------------------------------------------------
  /**
   * Method to record the implementation queue for a transaction
   *
   * @param xact Transaction whose implementation is to be added to the report.
   * @param prefix String placed at the beginning of each new entry.
   * @param reporter The object that is reporting this transaction.
   * @param file Indicates whether this is going to file, and if so to which file. 0 indicates no file.
   * @param depth Implementation hierarchy display depth.
   */
  extern protected function void record_xact_impl(`SVT_TRANSACTION_TYPE xact, string prefix, string reporter, int file, int depth);

  // ---------------------------------------------------------------------------
  /**
   * Method to record the trace queue for a transaction
   *
   * @param xact Transaction whose trace is to be added to the report.
   * @param prefix String placed at the beginning of each new entry.
   * @param reporter The object that is reporting this transaction.
   * @param file Indicates whether this is going to file, and if so to which file. 0 indicates no file.
   * @param depth Trace hierarchy display depth.
   */
  extern protected function void record_xact_trace(`SVT_TRANSACTION_TYPE xact, string prefix, string reporter, int file, int depth);

  // ---------------------------------------------------------------------------
  /**
   * Method to record a message in the file associated with file_group.
   *
   * @param msg The message to be reported.
   * @param file_group Group that identifies the destination file report for the message.
   */
  extern virtual function void record_message(string msg, string file_group);

  // ---------------------------------------------------------------------------
  /** Method to rollup the contents of null_group_xact_summary into a single string */
  extern virtual function string psdisplay_null_group_summary();

  // ---------------------------------------------------------------------------
  /** Return the current report in a string for use by the caller. */
  extern virtual function string psdisplay_summary();

  // ---------------------------------------------------------------------------
  /** Clear the currently stored summary report. */
  extern virtual function void clear_summary();

  // ---------------------------------------------------------------------------
  /**
   * Controls the implementation display depth for a transaction summary and/or
   * file group.
   *
   * @param impl_display_depth New implementation display depth. Can be set to any
   * any non-negative value. 
   * @param summary_group Summary group this setting is to apply to. If not set,
   * and file_group is not set, then applies to the null group.
   * @param file_group File group this setting is to apply to. If not set, and
   * summary_group is not set, then applies to the null group.
   */
  extern virtual function void set_impl_display_depth(
    int impl_display_depth, string summary_group = "", string file_group = "");

  // ---------------------------------------------------------------------------
  /**
   * Controls the trace display depth for a transaction summary and/or
   * file group.
   *
   * @param trace_display_depth New trace display depth. Can be set to any
   * non-negative value. 
   * @param summary_group Summary group this setting is to apply to. If not set,
   * and file_group is not set, then applies to the null group.
   * @param file_group File group this setting is to apply to. If not set, and
   * summary_group is not set, then applies to the null group.
   */
  extern virtual function void set_trace_display_depth(
    int trace_display_depth, string summary_group = "", string file_group = "");

  // ---------------------------------------------------------------------------
  /** Used to set the trace_header_present value for a file group. */
  extern virtual function void set_trace_header_present(string file_group, bit trace_header_present_val);

  // ---------------------------------------------------------------------------
  /**
   * Method to retrieve the filename for the indicated file group. If no
   * filename has been specified for the file group, then the original
   * file_group argument is returned. The filename returned by this method
   * is the filename that will be used to setup the output file when the first
   * call is made to record_xact() for the file group.
   *
   * @param file_group File group whose filename is being retrieved.
   * @return String that corresponds to the filename associated with file_group.
   */
  extern virtual function string get_filename(string file_group);

  // ---------------------------------------------------------------------------
  /**
   * Method to set the filename for the indicated file group. Note that if the file has
   * already been opened then the filename will not be associated with the file group.
   *
   * This basically means the filename must be setup prior to the first call to
   * record_xact() for the file group.
   *
   * @param file_group File group whose filename is being defined.
   * @param filename Filename that is to be used for the file group output.
   * @return Indicates the success (1) or failure (0) of the operation.
   */
  extern virtual function bit set_filename(string file_group, string filename);

  // ---------------------------------------------------------------------------
  /**
   * Method which can be used if there is only one file group being handled by
   * the reporter to set the filename associated with that file group. Note that
   * if the file has already been opened then the filename will not be associated
   * with the file group.
   *
   * This basically means the filename must be setup prior to the first call to
   * record_xact() for the file group.
   *
   * @param filename Filename that is to be used for the file group output.
   * @return Indicates the success (1) or failure (0) of the operation.
   */
  extern virtual function bit set_lone_filename(string filename);

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
dvBmIIeUhrEKB8IZB8BDJmygIb9vAcqxqW11j++1oWzYnjUhtjkHHJpzJxrv5Yaz
vot7znGGhIk4v/1Xvl8V5orY40LK0SehJwLwmHMOmTDy0VHXJ7XI4NRYvj1/x8uC
7a14aJwC6DF3I70fEj7Egk3ZZuXh7aKQk4EYAdTZnhw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 21301     )
tpdlEWxMAGNMyBqF66MiPzOGdlUte8NuDC60CJZH8xPd5PuzVPuXZSvtR7DMrtw5
8JPaoroIe9mF+oygiRQfgNSxVuXzQrW3Qa/sL6xWwhs3PwltxY1giX/u5HWBQXGW
0I0M56k6skR/V3AbslRz+hQKklq18bSNVLQEHrsiTE/wr9c5topsaTFUeNQ0rAZm
RN7+Sv3blEptV/A/Pb5Pjy/ILhF00Bl3EoKfwNDA692wNw23cFnJo6bwNempkz1D
/VzdKMEPz9tOe1HKOSlQlfzPNSuhRP/xmJoB7pEK6aA3PbbiWKk2n2y+vU0V5IhF
Rov6AnNgSNGaPCqs6WHtcECa/d4/fFHTi9j1AsDWI6ZOjD+GN3od98GgFvq8YtM4
eqJWs1wk57HRw6H41DSkzCL+GLljqvqchh/DaE6c/NOpLIR3UU1ZNN/xvE6az9aF
MDENod+CNs2I1SAldAhSHICVXSN4JFfHsslu6XllMe0zadn5o/uatPjKNeGwPOep
e7JLIVfP5O2Cpq6i0Ol+Lnb6yV8i9ZZPNTc2mSz8mjEbxrYAoQ5dmCpmRpsRu3GJ
K72xnnlX5Chcsim7IkiYttd2ObkLfwI2yXIrsHfVKl7fRbCbbJ2X8m0qMC1+Xbeh
9RzbeCd77y2DZqX26AQLmUhu75AF6yYtmZhv3Wfrjd4uahCyJlVDG8SkAWaEqGhZ
yqWSvjJtTBr0tN0ohH777lXvD21Fidt0oiOoBfxhAD5ibESBgnXkYBu/0e64iDEx
bhfPPOAHLmV8KoWvVjpBX/rLvb152lfmytgHI7zjEmCTXfPXPPpPCwLmLvmNd0L8
JmqqcukU8Fp+5ctHCn8xEpJyDmVIj8R8aq66Cw8tg82m8bIXsC3QWxcsw2lnRIR7
MJnm0RyXpwbg5sK6l+JYiTu6cp8e58dtdRDEDBbkCtr/5Wu2C9YtloBXGyCrCdut
/Wp4Mg+ABo6QnLN9LMtPxyzpW5MTuUYA7hIsXR8S48B/NIVkxByseOs9xWW0l9cT
v6WsRmhiCaUxcZYecDzjRGo5Esn4lWY7V/yn3VBRT1+PrnBGmMTTG9dktppqw+ke
cU1Dm8kvge0wMuay1uqeOtEQvjlpCfCUBXIMrJDZkY729XKuDj5pME9VZrECCrHA
aJwpSaUL1sgLAgmaQaKT/Jq0Xa9AijbnCEf65nz/4tLOd+lMB/JgqbjVf1Ms1Tyx
IKJNR41Kfj6rXkaiG8oiRGo2wkpdE+McQAHnB6GZ9ebipyNz+L8kLCIl1AMMXtPn
FJaWS2D/lz1nGmrjYpM2vN+uc7OPwVbmpKCDUhgKmBETKU574KIOpYd3BqQCAbU+
DlExZPJJfVutGIe85HvOsDgpjWu9XfoLQB4sQMYcZD8REFD3UnmwF0xxXxxnMKsb
IXv7ORCYtyaI6ODZ+Ohw8svHiuIb7DbEIqgLg8lO3xaodCcGb9RwcM15tjuRna2Z
06YkwwJDH8aoGtcQHgRY7xMbsuMgYXc7ENa6ubJodXm8wjYOs8/wYkcu+xpCp9v5
CMHcBri+VcNbKB6nvCYfs1U2fkuXS9f+5AmunpqdANi3fKd84sQwODNXmCt+5Da0
73XuHslbCPAWWMrMUcrKULAY4/Tf9k0WhgKd8mWKU5UFKbQIUzBsCjcpXGFvwPAV
M2pk/3P1MaNVq6AXKFYrNQHrIRpBRIEAYy1RNUbPVRaGxN550kuWk60JdJaJSYuV
Oj4jlj6Ewp8mIqQ00DgUkGqzEcLbKthwdTDYa1ruz0icm9B5aNGpjBYTfcB1xMFP
J5wDUk4wQk94AsFrl8x4uStRL8wb9Sfn8g9G9ulbxPSgIM0dQ/FDOxgE4GuaT1ID
pFsnH1aZxRZU8j7hyTf9G6UT3iyruCM8O/aheiLNFPYRfAgqCzD5puxXFTrlGuWP
awlFr+Vo3Jt2xr3UamRrCuPrVkoXcbU4ifUezQmfieGNDwxXOKzRwfMB/32qzf5U
rx5X2tPFx3JFjGPcXyUe40hFDyicFwZsLrGawQOXU/NaZMxcw6xCb00UYWnpPUOi
JVvEbTJqeIgi8Y2O8HDu4aW1JgDP5o63sB3wDI5SQDz0RcxCKOty2GBUkQZSpyUG
P0O4/q6ojAd3xgIwjsV+b5RXZKJJ1a0TgOgM7KW8wxT0FPapqpadkolQDnWgRNzA
0GZFbPL3mS7VxNeg3s8hLP8N/XSGaR9dPHOT2jJlfDHONG0zsrSOBXSmk0TjPlHg
nlltwKcj6YL7eQnDNzxkPGF2OIjS0YNYGOzme77po0kl5zUOjj1uL544IWRriMu4
gFTr/vf11fq78m8Dbhfom1Ic4eGs7KURorDQc9mepFWu8f43TF0CMBJIV062Shxe
Vu+2hQURTJG5X0MJBjqOxWcJXgTCBfH4/X5uvoduBF+cmTn5eHOevWSP7kZKgRN1
vwf3hdVHSuMTR6pWnI8lfbJubRX8r6G4vAMERKi05KXa0W9trprhskL/0MYp+QQq
ASlusrmlWATEIDKs3Rl5YL5w5+AX8LzKBrNfD3ZFYx9NMEfgBUFN2vue+mXPuhol
uh91Rsg9M3M1btVTsMky13zJAReW32hSxfHqXYyvRO5OfNeZ+QfJoH+1pFx+/1ak
vgolvl/QINy9ZOc825j6etiM9EhWGhYCbk4e6wnxWsmBGuk5gcN6Rya5eoRWH7+E
a2BpZ4EP7YdRSjhC4FyVODUcUIwwX8cYkxPLLM4wnEhzsArcs4LqHXjhuR0mBhbB
kXBinBJjLgZ7dqRzv7b5AN2tIrYK3SUKQaVTeKRui7mqYgrnyI6iNRKS03Q6xNSx
EXlUmEQhHmvG2Aj4LvACLh99HeRB0fO4ljQNau9pRbqOpKzJQWm7qwQ4hIVrgY5L
krMCmInI/M05DtTRM7m6jIsguBiWSUClzTyweP99bri04XUwtuHA0dkO8MGVSLZk
F0m+J5bSkZM/cGTUNNkzPZdcqDYRWWcxdMBV+tBIuIu+uKAzVyBOHVFi7OBw5l6p
V70t7MAzK+kyhQWCmk5UEK0QLHtRXGNhdgHDD3SVXx88uLvI7wOx0zcHfSLB1/M2
dlOotaEWbepCbmeWvJr7zq0ieRSKtap0oHhOb2akRqTyTrVWwdXW78/aZiLUkhwP
V8xro46jxafBQ21nbVZZED55Fm5Izh60ZRTQvdCFyqUJ+AijgVoB9JqDF5LwzbYg
a2KMOrql7ueeKfblv3Q9Vxfh7awzzEEQsUaDBEYgV5IkOQovedFBh81zrSF3irHI
o044RUWNrAu4YU6kGZuqm+QigMLtSRBs/MMA9VrZYZite57Xp17knI46x6gJ9WUF
KuLbLq9SCNN8ytxO314JMA0V7GgJyEs7CoSDgiwSu4aMQ6kpxKPfAQI1YI9gJxca
+TFPPFwbvIgxzfYvHP4pTd7BDkScpdv9RkulNde+aZhXAVK9Ui/5LN2D1as7Ac+X
E3uex4TOqSNRcVLDHgMqNPI0edLuXsEQaWM1Rct4rZk6qzyxQhwfla5De8HskceR
NfI1mPIBR9xlDT3AEif/2pzgiSNWfnhObEhqI8TZ+uEGkrqVWffj0eqyTMV+ouqk
hlv+0L0GyXpQsdtl+nKw5ewYHY1/GsLvLb449WQgD8pcF1bQn3PhcPaiV6TnKTMz
Ht5LI1qIiu0LV8Re+f20xpMIcwwwsm+5zXBHPcbpKawP0Mru6rsxAkqw93qaJcma
Mh75gOXi1il3uhLYMTIp5EhzMh33qa+IMQeD+c163Pl/B8s9vFJYNbJx+UQOaxrj
ll1NJriRy5mhGqQ+N7e8m7hJurKyAfX+q0j97X1QOKwR/hsGiAD1DnjgmxGa19R0
mzJq362QwmUXI8/CctUjXJkeoATmWF7aR4tBpYWHEUfZk3PIIjypyPynSn8DCMeT
jVryh8VdbrldDSVuDe9UNmM2qc0qre7XfyTNC01/J262hU2kpag7a9C5d7PXSHKR
gfgP2peU637R+cJUw406ayNN6wz5dsAAzFHmKj1NYepq4ouBVOMrmFfudvL4jveg
N9xZPnUU7Y3JIxyWxcrPftzdxNdtumr4DDILmsxAr1a1AHg4U9B/INAava7JqELh
0kB6AOa/pyzlGuIwfeDO0dmSKHNDqiLKUs/A5Sv483DVFPGRjNzwO8M0dBzHok8v
0m5+pSUR1LKWYD5VbrOzUXUqwdbns0XUJDaroOBHrNl+F+FbQ39jb9UsUrzyuFyL
2wO2NwQQoOGjBUHAwPFSxlX+Ba6O0upYJUHqJYhY0HOI7SRfPCqgizhy/oSywNb+
TFBl3FnmyXeUp6jjBDO9lEvatAH4dM3/bfOq084Ahu2ZYhjJwPwFI36IdJA6zcOV
1qvj/48KeyxKDjDYB3yH6x0gMfvkN6Yg10qADK00s5lXyqqKH9gdwRiSvhrNMXrV
yPx9AoPw/STPvzaIWt0l+iuYmD0brIikw7OfZbM4PikgmhqimaX8f3CC80P/untq
MD9D6PA6flGbgCg1ijY0bqNczJuFwcfmv02+MQCat2V3HyIrmJq+DFrBixj4RK+C
9z7MXQ0nKnwT9xLD2ThroeqdO5DGdvRQFsvSBP2rcXe6m1gKdMiSFuX7M62r6Uw+
74MJE2bL/2RN5Q/AC4QI0Iwb7aL5wYQAaOGdT/4w9cLKDyjInwmdcxEVSqjJHnke
EQqKcp8SHMdP1Gdsi3d6waLxCTTjtzN2YSZYm2sw68EG9FiNlJeRDpLGiuJc87tP
6qCutfLkjFBPT93uhJ8PfVP3MhGZhrKh/oN+eLVuRzkIaMGTr+7P4cEPITQmHMdz
9Bk/biCM4P2bYtTs+cjSx/gvITKGkEfyoEJJylZAKIM/O4KhaoGZ3575Gz//Egw3
Oe5sK/y/1NAm8SF4qdyJgzWOuajn7V4L4T5BRajZLwRc+URtcxOoX2MnvNa9iyqg
Q72oGzG9dyfd3PPW/34CiVNgVSrCcHIttHDfvJdXcZsz0T6edVxebm8HFi/pW9s2
P7cDGE4GPZg2z+Lk+LUiCgKKAbXQY70bOAY1MHVhf26ia8pkwmjzGnfbwRR8JeQS
OgwCgJRjr2z6ScziRBOJHcZVLp5vbdIMD41vVjVYgwfYOjumabJGXqUg4aeZAXEU
Ic70SWtXCimFTNZqAgcTPQqQlJijwAKN73MdvrOnXj1o+iblT31VVibOKcPzMObx
UccxZ5XrVtioT0fZqwrc4Tq10OGBGqmeIhRw2Ve6I4LvV1PC87KoO+oyGv08g5lZ
bZugaG4ruRSyGD8G2LAkWMkGBAw+IGfGQDF9kHQzJf4MfQnXDqmCiVHi0pLGCcb/
mPC43ie7F0dWiC9NwKXbfhTZ37mwHEprrWpAGdkhQZp/YlRkW1Zcoe/J0WqKzawd
nVspAGwbPPZNy2v3BrXtUR3doK0jecIdKUF/o5gGgWPFxfe0lR3OlPHkSFiASmbE
sCbFAniuAssAOq7qiRG2r7arPUTIpAwe80CWmkP2eLsikD5tJ0jXmsNpbpgJo8+Z
tK3mqMKV3EFMvdd1N/G5DISytNrSS65G4c2imjuALM4MTHOR32qmQTYpHwiu1MOs
xBV3ZVLPrdSL4p5cGJERdgu8PgptHd7qIehmlFtyMIGVsPQ2VSPxfr7CbY/wDeKX
evmANaG27DzuNuQSWc0DVX6y3UzFwkm3SsBQQLAWU0A6xztzJwYv+XhSz/TpQRUj
FfJmkqkvb7Zbco6u2/cKyak5ZBHIsHQq6SrzwHQ3Mb1Yv+PB+zEE0aWQG7dCpttE
F4+F1Dlskr3F5UqIzOfBsbd8Ld9mfr1P2FY+UQlKxfmix9GkpGpYJENIRf4pBmPW
QKgOMDfX9OB4FtG2eQl8AR+nfTCygzpnI7ZbR8Y8zI/Zdgmby6+IoQgqR0L8oWac
Hb9XTsiD5n+nZTofTq6q75lWYnmrOLihd+WvlRCp9Q0x03LAGudBU7oHXNnEV52l
Z0KNbsxJT6THXBfvX/CrxJF29/Fvz4GzYZ4tFXQY3HzpqDakCLVg6KDluFEl2+cG
7t3POxuSHrTdDdBGAyBYG6/N4yfznxwDSGERO5fPrp+tdEMpqM88iGbhqJ8CKhEN
UAPIWhXEH68hSEA2alAtrqIa9frbsvImi1h7BsXxjAqTHGnrFMkEP0duM30fjwDM
tCldQs6/3XvUgIDrO+P9/Q5VW/yA7u78uiDsT//hlCrWkr/gmainbtp+XWuRgD7D
SbV0eejUIUvbWFmKmKD2TMLFIW59PgPxH47/TXHesoIZP5SU2qD1NYv5u9s5vxA0
WZFdv2m3PMYBth/x6oCXBMlmVqLjpbhg1X2qmd/4QiiMQ/0m0G7neJNDPMJ5PS7M
OHNerDjQmrOhOPyK8Atf35p9kn76/hdNeHJJCJ8qH9J+t41kP4ND/b/QHIdJQ3wE
HaQP5CrFs4id4W7vazKIVoZMu2cBLBpwSIlIVUmTpF/ptChSF3ewAg7TWhpk8Mnb
BEya51CgnspKwZTD44ijA8nY+KIAZ90XPEnDzWewgitiiXgwhyGS8P6iMWJTW2KE
Vg3UrHp9xehGa0E7sz/zAKvJL9O9uVWKAPVYKVM5cfAL4Y4s5QSE3R5Q8L9H8i4O
RxeQ1eqnDRRtDzUx7sLDrwqoQQd8p/QI8UInOSfv9cdsNFAs8HvyS74wEZeXVnXR
F9qOH4skQCZrwMV/cb+uR24JzaLKTMFgBaqC0tKzvLWJgQyBuvqu8NVyww7MunRp
SjAyx7L/7jjrXh+U72wxdz6Yh/bvii0p2v79Sju9J5/e5yMd4lpc5Hevs4vyhXbg
9Vv3yr7ZkudG2PsFbDg0wH8K8g39sFid+1Y4/8vqrlWBEkbr3lbVqp9/Fxqob54m
DpIksBaP6fVoaZbADoL01Incrvs/LQUMzNYntEAOghxgNtchnvum5lrHt1ZqcSgL
Yw0yxVeYHdc/KdvkkgAVMWm3gY0Iz5V8UVTifNFsDD1SlM4Ohx6LaEZ5fEiuoAcl
aulwE5Pnc2Vcv4G36A4r1kbY6XJHD1L7GlsOc2Nc0Kt3DHC5L7EvwajULKAcNl63
5SIGE9Y+cISycE9Oqv0EqNrFBItvEPopkuS7kNIjHtEIHSLz45IsguWsqT3puq7N
BjL/XfkvsuAUmn4+JF9UxRrEYTrIWQuuLUW5/4BBHhS5lJbeIFWe5DkUbUPJgC/t
oLsn3ky+0xezOHwcJd2O2aDrk81rShJ5JNqptjwiERgQm13+OD3FNEdMurCbI6sG
wkCFJL17baEnUxWEmo49t4/IBlIz5ci90yxRqQ6tinVlJ1VJh734uxGCI4U1YtM5
xkXLII9z/3PnlpTU2zEcTXBT6IHRHRGo+TLR7inoeVgbgIuWb2ogRwgP9LU1obaP
Vik1v5KzMO889hWKXYv+mhb+nUooeaT0m9GT0Ri5279UsJ7c7h5i4AadPcunX1rr
nMpZGwh8mvziyLHWzMcLMi3Pe59bT0oNKa42daSi+T5Ilqafe/BnWhGkuoN/Hq+T
JECWqldtr3BETBwsZv/mJVmGjP8OXnbOvxoRTuqkXPIgzDkxMUaV6zKokOgQhvj3
wvHGYZ4Gca0wI8BS2Ncy+6kYQ1RBqbGVlFIzbxC+S4uh5LOiicF9a+T1lkA2G9LD
CrXfMejMGn0rLnPBnSAiAQH05BcwsPeXXJfy548enhPss0nwWMajaEMKY0ibjDJX
7fwpF3uro+bKlQ4EVnU4FwWhP4oV/J8js9h4xxRBYxuorFNpHHj0O6AAwJrOmKeP
8OchmYAES8V9wsTl3Kr9C/kngk5ujqD03V1jrlOm31Zv5M6G9koDOskyi7K+VE5t
jKRODmmGCH/f1ULEL29MU5ku9W0uXFnmXZ0sDWFDAae3ClmvJm9lRgxWenHWDE2Z
gXPK2uBomMLwsVLfuxRWuUYdcxcphE7/wTYIyRq09r28BRefpXtifmy6ugz6w3Uf
wdWMZkjuCrkqjNE7b2SD2VNefIsF/bRaktZBpsXnJFgFXwJ+jrCdPjzqUmOCbtHY
8iV2bJWiTfm+CgnYjbApMY12QsDI/8R+w/SnqjKDB2AcQWqQxzHXMAT+4AvvCR7s
lfVyJpFeqUABpjNKSIThAPH+RdrTgxXf7hHIRJXHpMpYnSh0z7xxDcFi+AyWf/0a
dnytuhZuzonsrRUfO+nVhOHLJmdSXp4f+KBxuLurxpoYVDKKmtXZSuzQ/Suw/nqZ
9qmkXBL2y5stgcujtZ+OToCXcwR8Cwhg+ybLVeceFh77+buFhY4zhbpog2RhfRLa
RvjR5cdi2vizY64aBzYZmQM4KeEhXiuUlt7w+x+rdSFzVs8liYfmiFIsh5LD3JG+
ONRVQPVHvQkRWJ2ydUZom86AyTgdjEzWd7NTaidUyIMGZ5lYEM0Gq0qfxObovB8p
t4hDROh0w+T621ABezZcL2Ii8Vgv/H+PfHRhuuBnRLHEoUOcm/EFiTdveS6pNjC4
zpCL8dzBWM9kIjxgCEup2UJeL1hOy03qg6GLvcgYaBFGzQeRLsDzfQpbGYnzuQIU
59qik9ME/kjac3e6CvBL1OxceJr4SCaK8ZIZmTIOOd/Xkgw2YHReg1G1GYiRujgv
/s8+2i+W244kvhyQuTv/laQsoNe+q3j6nGDQtrrS0ULDc3K+Ny2+AMRmyMR/yv/J
qNMZlLXGprZgFGQgKkzHecTb+tELWL6caeNZFbY5KDCZVch5Na5Xt3SlYYIeBDIK
ODS0mWfIa7nQEQyY411vSinut3AjGNuqeoDYpXcVr+XmfJkveRVKeppeiX6VN+Zk
qTHf8u82PQQDaVPtep3nsQi+Z3k4GyRmmt6cIp9ldiYQGpX7C4zwi4+IQCaompFl
xylgcGHPJMG/MFg7lXOZkGYt/28X4zhDFor/4b5jWnZB2dX1cmOAASuvM5szudd7
bQRCmZziK1BvpUNR4V70O9HjAPoOg2wv0o2/HecRj7PAVsWy0DRbrz4lFDBiHL1w
z/QpA8I7HjvgmfDLsEPewUmQTGhgmoPfpGJae+QjX+Pj6ESfaSSk9NyRL1VnMPRT
8c86aE1Up1BEQt8u9c95a79zR8KJysJX3uL1vXDulYtQEsbCfQQltgrN5Z5UhTIx
/VgqqWQ6TAnjBintV4xZsBBln+1hqwPFDmmHUD74ZNDSWdM3kyEYdXO8RVFIK/Td
nohLjqVka93yOzay24VovgcJHbzlvAL0NHxvGcik6mV+hUgMk5alqO2J/hf/riCC
lJOHGa1KllyaO2JS2L7/zdEPw2mu/7MJB1giop9NwvlueUU3H8mZQUETlv5JapnU
FXAkxnq4OvGj/UldwJq118zQvXZSuBWG1RqJOLvEZqw3ZeucgCahZcs0aLBu5BDR
mKX1rgxEO4g5YnYiKivbbbf/sycyV+F1C3Z71AvuDfUcrMRWu8T6F+BpRdS0LbeZ
rMAsWSGAEuhCn2EN8eWmXMEvJy9Z2dGuLPvLZ0eJbOoxi0UHCJrAPAXvcP4WuxlB
60BusaqD2LFiYADpTSxrPx5PUWvMcLBfQaC3oriPLwkbdKT+9QT9a7uU9QRa+/F7
EZNdandMjJTZAjM5KFtcBWly82bPZf5zZyP6YXpCSMXWLaVuvasFTZc3eFe9HQKS
6c+zD3YEUuyEkMQevOL84NS7/EAi/NFBSpo8DQvEFBaEfIBdpwxbA/ZzJXlPvU8S
TyKgJpwmdlg1SdT/aeQjTG/zCQEG9sWItlT0CWYf2pY+SGcirBqWj8lnAg35nfwY
ywK0V6a6Alyf5hpK7jWChPTIJJmhViBVAjpXvrTAH3mgzvRnQRK1yQG65yBUL9xW
8w8RkaIpX/NUtgOZmRviV3pG196FRlZ7T+PNXDYZ7YcCl9EnQMSgLk5FAaQg9wb7
u3al9NR+za5K8Kn7S4L5jCqSHcL0nrW0q7ZiLbboxMnhMVFaLXOSBQ11aH7415JK
zgihWSRfkzukDsWJx2Yva7QJ1g+STIsms6D9GqUt3gJlNUd8x/Ntd82Ecd0ULM7z
JAYzS3EaS7cCcpUpw2dqY1T0XmyJIm1mPwpVf8epmollx5PnpNyrY7maF6U7WLpA
c3f8xZjIOOFxhPFOt1/33MSrU87WNV+KHhNTURkSVELai7NXpnX4b4cw/7Z4lEqb
jaEgN7I+BUzzumFkL96Swrq4kDrA0Oz/lVsSUxtyb9HYLNWMPO4srBke5/TkxToF
twWM8zK+w2C/er4PPjaSGLPf5fFgofZgXPRVswIgj48j+Ss2tcQaoxqDkx65uupj
ETBjyWAFFzrB62phWDDY0KAB566tgzqZ/W60p8GV+3LrfikTZzQBIml8dxCTVm+7
sbTBDkXzFQF4p3d/eCpv3OXcSd2erPiV/DTG+s73gh98wq7P0kHRsYDeoJmIxBGt
XF55zVkS6qNbhyO4Ot/TqE/UpY770eWguI2V8oAeCpi25lH6nm3rYjfkiGxpvzYu
CHw9zNT1I5qU6BWlPnt/X5xNAFqru/VJKHggvLpOHGrd5JmNa2BLUk3oZEDek8Rc
kp3Fv1BmNAQdMz3ooRidKwoTZPON033IbkxbAWKRgVwt155FLYma+L3q2QAf3/4f
PT0p8scERCdAR66QrRQxt9KQWUU3Iw2EtvdUeZr650GF0fX7NKu/kf8vk9oxnCf3
ey/wa1VroB+bApeRmBFk3Rya34wWUHUcGCiTzmu1Gq6WzqVTBx4EA4yP8tH2zZCf
iWNw4yEfPTFgzMvwielq48msn05E9whFIZWxD+fDcmq7oEM3BT3Rz2CQ1iu083jC
c393Bbd1BX3/WxAe2H7Wr4UgJKJEpW2Gw6KlpIqA2A1GZgVB2/iRnSs1nIP8B+L7
qT+MAHmmhLPE4rnKTPTcMdM4upp8PNSXddrzWT4qh5K0Sg+TpuKbCUj+UX1G0PAP
jQcIEqT6n20nXocsnbd1O5N1yAPYFIiBymgMsGwaQWBzHtElE1r00w5cgOiT+z7n
hcT1iYW8VBz/MAmmOgNmbc1tXY8kRdPu/Top5CQhXbkrgYF/mf6jdNcAIpkdw9JC
Smd0DbXFpvKytOTAaeH0emzQazEkRnacRLRO/rBgH/nU0+A+3EkxWgCFpo66mT/m
FUfWF2XRyOxhHNN0mG8f5dZkx53iDKA14npQ6AZDqKC8T27GKnCmOMEDkMFM3NTX
jqxgL5lpgu8F0lcKZBo2NSDp7A4Rf3/8wf757KBBqd70OLhuXB6xKoryvmrL1qVw
FQvoPwOf1G90FS/ziymqLPR0JIc5u5dNXtM197tmFDmtjYNUOK5bGak2IQw6IX5p
+MMFD6kdHKbDuWDpJy4NKuPbJ+r3QGwva8yLD4rwAy8NBE8LIOQqsignAMqhe9Wb
r8+Yarqeoh3h56MjWaygo4s+LSx5cusHHI3Mz7THFaqh6LxAKUNhcy6/nnOROrLa
gzh+qwbrwkza8xo3RmiVuz4Xp8hl1vHxVELjABKgKulgcaaAcDHjWmNnySSdegac
0phRn5fcIj8JFJxxXMkYOBdj/C/7r5qMvx+K/aLd384CMbUK2ilqdrVEV+MzNBu3
gjAVddgFW/iKcsatEbPcQtzdXAstjFLEFX6zn4JEipalV+BgU2J3woFfJwae55v4
x/jR7NG0yN7rwJF3mONyKLsTD8nEhtAGUbpou1ciPUJnj8cYdIII/Mf9/hQkNVMl
G7bQ+RY4RGf/wAjcJIAO3Rotq8AdwbTd19y9qkf10/TAkW8I99ovzUWDv8clORak
4KUQgq+zBcdZ1y6mczaZ/QgeDEqh7oqUsfPEacYf3kB/HC7nxl5BE7OeulOB7eto
2ZsRA+wmzs1UOZA2kKDuWUM4KGCt3Z8EvJxlvWSqjxp5sZUF5s2oonrL6mt/SAD3
CTWv4w/SlKWsCRu5NgEHnVRQ0rwcrScCjdjRZ6T68SKIeXQLf0S6CUy2phGrFZhY
ZTIKMDrhDryIzYsk4eqMCDqbCALdN36yIUvXSIbDXHFJjatT19bbFkDnLJ0Id8Jl
ztpLJ7EaQCpiWkGEPG4hinsfKLOI6vBS2YXUj1hAPVFrjG5jfpXdVjVjoNzFgOBW
64LmJgGk3KBnm5PaE+F6iS8Ph4NQL9oKIjfok7JVK7/jSOAhItqeqXXJF6IQmnDj
zo4rEFAks4FpmmUUJo/1xwhl83Tsk3et9abu5y5cp4Mf2J7wAp9gQQWAm9CwFg4Z
lS7kW5jNcOj5J+GhbCOjxjhsKH0wW5vIsZzIo62BaN48xfqcdV9Fxjj6Si7q1k4m
9QSYvOgQ7OhEYEJ+UO7BsYWlZrLtGqte3G4iSUCTH4IDGeGEVrPHUFnNwbDnnoeM
N9jQ0fJyz0vaKc9XhiROYv15RPtmGEVCWEDU05/VTzG6DqTnEcqVgsnU0u4I4Jz7
tJTttgCPShmS7049c6Y21fNxye9G9EIWEWHQ7yot4wBZwOqc+CjsJrYChVs/KxxW
hPYz+CWJnmNSIGJsqBKdo1DYA7KRttrRbr57mH706b6kvwM861qtKihg6nbeltkY
yOa8EXMLZy9TNhQuQwhuFHvaOrRIQqpFlfwqYTPxVBxAKSVWo28ebhHeg/MUj+Pn
xeUMK9YXYrW2VIcc+wzkOTGKJ5hiK/qXlpJUEvJ2lXIAj/N+1PNcomwujjVbMawR
WhM1DvLO0l8nB0Q3d6TOIBuDI85PFufqLqw2Ewcd7IillP31/hlQxRB9KMdJiYD8
nwOxCRpvlY/NrlfeOZjBe/tLvyURp/7H76HCQxwuneusgFhmtlwgGvRSqWaIbdRM
SWbCv1iiUifLw+HJ76SWU5wl1auOhHbw3QdKIR9B2H+ngFNfj3dw24OlkiMRZHwM
gUloa76TEYzvpV/4mXYf1f9jh3fLq61duV0TbhKNecYeghb+k5DsR+8z+B25QLKj
qUiJAkitGh/KfwmoTVSizurSTtlKWNId2hXY0fK6fXoQ9VGcjAIUQ+WifAwVJVn7
yWEp4fGwEPGIw1LWqj3/UxAoqYi6M98FsKZpYwM2aRrh1700LAe8cFdpz8QcsYEy
kRwZxvoo0K3HggV+WiSDyrJCvmF5r60Sts/bWSZWBjHjXz5NA+BXVu4exalJE2Xt
v+phKtPizOab7nzPLQhyULfAkVz0aDBZLYw6p0jfJe2OZrDBVlT/+vuZ3vP6gOjI
nShhAYc7mK6g1UtrTgbSkfgpTKiRxgMsUi3N2f4JgvhKtJEztnj9el1WVVOlNgZk
cxKxd5GIuGRt3l5NtNhvEg+6MVkXdNOflAX0nh+p4/MinFILy5OKg4PbBCnIDQhV
SWaGy2IyHB2r9Z+UOrrgja0nBncVJOLviZMucK/98B7n6YeVj2atBYQL6cpWlAZX
M4lVwNDFFCVz4hqqnT1RNnZzElXRDqye4xthYbnvQBQJ2rzxpKyk0FcWjqShvaYq
jXzQTvpeUIE+DBW/uQ42hVruTuhEBg0FinsbpN2Kh/ArSTCpyjsw72s6poxUk43e
L1L1dBKY7WOcaDjuzMA10zXe3zw7BKBESrRPTrySVSVhHs4yEwi1WaFnCFUtqnC6
qUjDGaTKxJ8zX7Fstcpuvn6ZtPpRYavTAoSF0j+GdVccZ2nsFC/DvrJeXY94gf6n
CogMB7QVGXdkCZzsZd3VoCvUzGCIrHmDya+8G0RniymDtd2vC8U2YAZQCxMmqSqG
Wbv7ba2QZLo6i0dKvayMABqCg/ZHgozXuk5Al7HrzMCDXdWHDhAr1pOgX2rc1D1n
JVon+1Mwv49aoLuVPIIBQIg7eDWsn2uKXrKyiGE14jok4eN7SyYNygGZg96IyI9K
MV4JXug0X9KMQRPW9C1fFa+0ofQO71+LJODaIvbCPjpe6vNxy+TemK5wGZF9VOEv
MoI8vLRCXHA/aaSB8OuUEEdtGPaqUSwq1mF+ug6YHLXAgsMEX0cBjOVhmWnYPKjt
sEd5UOq7EsA1HeVvpYVPlcg2cGdJhTTy8gDmz3rCNQ75YUkQOAt5R0bbjo9RzCWE
fYQY9WTwMj2s6pOOOg+LLxX0Y+P+6fZQSK2p8pG6Y4n936eD3yv4zx91X3zT6mIn
M4HXxwrEhvILmNvuaR3tm2EefNQgPQziryW40ZBA9iXSIGajKUsEn2wyL5m9Qk5n
R2TWuhqi1G60LN4KmBnU3LroxV3K0Dcn57SqmM8MDZLK/1wH2R2ubNrCbA5GFa0h
hq/aNNIQEGoccduXd0heE55N+91+z/kGEVuLyMoJFrXE6q25kYQgLQrzZTQ/Bt0S
A7M72531OKHkopT3nJLdwPCLcG3lW5ztSzFrMFo4d4f7kjiKutR0dSlImfSXw45F
2ubrfozZR2zPoFRtikfv3yPt4ZVZfp6SfzUQrjSBmqU0fUSmlSEaiaD8wicmgby/
FW1ujWQ5QjnbWD1fUalPtOMsKHrs8GJ2BH7ximVDkynjwW0RcHv8TJ+s33HqrLeh
dEmPTNyIc8BaZ3gIbj0rIkMvU22BT8hf+a+34pHWOIAUALnL1G+zlr3+Ad0X/ZCR
gVKMqrdX+C94oshGICaAlJe69irTKgWPcVmlrbn7QqWK7yEnQTxjhgr+SjYKyyyX
u63p+3DAHkl53zumpS7T5q8zyLyEZnweUxbxwPNEAe31meRUjLP0Ssn6RDARSzoz
bsvDxifHNbzl3PBzRhIcC763XKxVpZd0dLExuy7UrtT+SqWYevv6vsv5yy1noFGM
5BFTb718SwR8R/8PsUYem3sGE67wU5VpCGj7SlZcWl4LucpUe3ZrgRS2BfP6OVps
99jE8Ax14Bd4U86wKc6QdcrFnKDpEBWO5lC50WXd6+CEGWqgOyX4fK8MBnE8EyKy
fvYQOgaU0nLO7+4c0qX4aeUGZ6W+CRos61tOEliMTTV53QKLqrb2hLH3dID8Bqh1
N/gdbrIGadBnFs3FNpya7XxxnZRgu/povr+jyD3ee5BOgLYfyHo7tyCPsFt0dke3
tQ10FyPugm4DSNpOTuhzuBQpIf1pa4R9ii4i+A55Tgp+cmeCGuQZBXy9axPy/p+p
YgsJednzO019xz5zMei4vcZl5MAg735Aki4L3NYb1ta3q0XJr9fOCrIib2iuoPWp
xu2VYx4R2BV494GLGcIQBb+Jx3VCwXhZ17e+0DJ8ENfaJ/jMY7m3umdRt15JVLQh
qbeZ5sacpjDK+dwq1TYagNtaA7GJkNk9i2V0NSms39zb7QboW3r4X6Ry0zhQZL02
5IqyQT7/7vVG8dOvF2VaiYImMFxH0sldinuu+A5qpLIDAJvHukbWxi/eFf0jKqP/
Hmq8sGNcY0iTzyfXhl6AHRWvGNHDd+1Wa6+rURRAgDFI+kyCWfkKCo44nyFS4U6S
vqqWzcEUPlT5Xkdn0I0ZNXBhT6eM8EC3NYSl4h5d7NHu898NnawCAxlYBxOtJrVB
paRP7B/fssX03qnLcngS0ly9q4b+6jx0CLeqL7G8ZvdRNTu1XIZhsr5yBtTAOdQo
zIVYn4sTyfhfI6PzuvAsbj/xEfmpBEoXnijgnEpqp8lWNUKpB0a0bIom2fbSDsYC
KPmmoft8LbJX/ECPV3vsygWTlnvq1M/huxdpaXhuKOvITHO/5x3aSiFENTamaRHn
2ExVZ2BS2FGaNNvH6S96b8fU1CLrs+ekmOdXsexYZgTbViVFiT47XoKe3f0X6FSC
17I5fNfNzb7rwsAw7aB7au14kgZ6DW1Z+tS+XdEjgbI9ksKIVvitOXqthVgtcdUc
GUqe7Pq1tRCc84Yddav+h1xOFCmkEWxcPU8KaJutS8D02b2Er1YwnZx5T6pVXOyW
v1HRxv6yUXER1Fhk8LANRCiKSkcUUXZUDpWSszbfvFKiYejMSc6wlFPRzNmel2qv
netbqIvOmjIfWfBf48QQGdglBTPqz3D2/nfrdhL3In17SSwzD8JZcbqdz2N3cKO2
hJhKBArXKHHXgYXzuMrzrIffNY3TCaNXWftETUxSAJkXOOi9AK47cfe+yhDF6NxJ
YTlECZ/7mC0W6UFKUvg+RV6KBJdAaNVqZxajOLcrkGazxsN1kRLJwihkeToZuayZ
x9XTEb1wgOK3OhNSP/V0B0AO8cQoNULgbMozWunp4b/6Sl0OF3KbzGbZ0hN4Cqe3
AMlU/xBLrRQzjV92LCQXYuKf8TlMUNSoY9Nya5cyUfbApXzBegdhROwYjAVGgnBx
AY60ZKry/5dLF7mwraCyEsyhfvWCcNbY+PT1JIiIWEy+hufE4148nuWyrLBye61b
2wWUPCyX85Cri3Mh4k6HDWHjpuugYre6f6i3TEvliB/aVnJ4yhTvhLMguyvCNIh/
OlmxfcHAY3slx2ia77v+DOvjoMWB3ssNnEphOnQctIRQuEzgUBB2d7mRGs9M14gb
jK0+GikrkbxiPYHdOl6OFdDOwxbphNBg9lOuWq0Stl9Rcq7iXhZMEkE6LhIO5dQi
+5g6U4lVIJ0i+H4Fg+d3OS/XpPqsJ2aJqnr8Lrd4HnrGIN5EnI8M3wPkPWB5Xi9L
/tU2kBnakzrvDvimGbqpovV+BphJGm6L8q64UbKb8zV19RKjkaXK57/L8Hlbit8E
g+f1ezW6WqxTcdJub8PmTNKNCIdM4e9gDO4PVE/bwOSaBcFHGZCCFrO5kjhX4IAU
2FPEgibDP+w/8y07Vt06HFt4qfoDktnLWqqqJziHcWJ/mwWKKGEJhiBIFxRbERnm
EqGAtzWPJwHlordHeGL84zQnar+54iiVL90JkjNemrSCN/WAqW41/VHNw7/V+UJ1
ObNu7vYt14nwGPzOQl/oF9VQPu4VmhCLoQoj0kGnLW/cRXdqRJ0dBL6dixUzQD87
Ft1cM1LYOFHTfdMGesrZTDE3vRA7yZA2aOrTiEqYCIK9MLfArIo5lOCwc3aLgKT1
xYDgSEjdtuhexws2V3/XyYCXdQ0aEoQml9s9nf14IGLLM8WxSyd1wr6EGNRBB+dK
IjuNWDJzKBXoZJ7MNKpPJOJ+g8QdeiSORb+gwRq3D1dXui7l9/6GyZmRupKG2mT9
fOdSW48u6e6+oOXpyusMn6YaxUQ8q2yyttucvwRcd7XGOCFlMdYzgTvA6n7zqyCq
TUUsLjZZuVs0b4YBssddKqvBIGB964lksV+9+aqzmLbx/b0IIDcBnYf82QuQz0cu
rrfU0uovIEZRm+rkWDRIeA0hNSe1pY1bhOpbn5iEos72WrrL/6x7WdkRO7GVKwCN
0o0EjZ2XmP1qCcgGxMKkP0pd1bq9GISzroOF2vkwrnkeyrD3MuA19rSuKKlv7qp4
fmucc6snojGhnpSWonb5UfQpqSeJesorj/if7ii9lC/2TdPqbHg24FP8ZSr418oA
jdoASl8CP0fDGAHsrFy4SwJf8CtAZ73VJZDAlv/UOpccz7DOh740ZKX3yPJHTyzx
SFTr4nXRJFpOMpU2MDrFOnTgTXYy8TdHWYc0miYNvwsksfK1NTxdRZg9S2DRSs00
fFXB1KH+TGDJ7zjRu2lzMO0THb1MI+fn7ACAKT5isK9rZAhPvqENM1/nBaNkaj7r
z3mlgrtxYk/hqFV23f9H6mZnYMc2PIB0J8oRmsRkIj0jCvD03njp6NOa7zQoTi6C
yosUr8Pako/UrQZYR4SqMolelM9Q/8MnLX31iYTrVWOxuDBAOUL7HJYzBV1MFobo
hc2/THzLGBoIYC2wXAtrB62KvMMaWV7oNVyISc17hLVW1EOMJCWA9/3eSliJ/fgD
XGxGHxgL7Clui0Al9mwh1JZoROUMhiYhUxSg6ka2yK4ZsH2GaDMmapxGc3iMacr6
NrKs1IALasb97tGVrSiAuL0Y9zNlxhXEfx8I3/Ur6zIOGl4xsRPczVhn6C3LfAY5
NEFJ8l3lE9nJDK2Se5dVUi15AIXxNy5Bir82+w39ScvsQcDGJdbptgEQknLhqzjk
/gEV9nudtVK9Jsw7ExPX+RcFNHGdZKeTAxbGbikC8DgCI+Ux3D0hapnIieKSickC
C1ALuICBbbh4V3ItlBhjYfcH1lfGGS0+iFIQYaFoH+6zKzxNM9e25gC4RcKutM7U
dJNuhQ4vFfEv0bo/nSkVgOdkfZa6nMX0adyHK3vLl4Gs99S3zP3FiVTmw+klLOGl
9QWBGVpbz+2TnWoHajaMI0AB1xL02CDHUANmNGbzJFrlDixksVWop7s3h/DGCwFf
OqEjWKwNvStQxcX7pMUl+fGWViLT0OfDLj3HSDxDbXfKoKSw6a8FRXNM8pOxI+zu
+b/SgmRnh1VKdsEyl6AaJUUMHkNAAoN6dasohh+nRhmSUKT/kNpodqgzDMISIU19
qB35tAoVv6addQzRqWuhJb6DsLgwTlF0o7oS+OI7t2lJj6Lcx0f6cEMAAYd5aVrh
y7CWSBg1ClmgnD/8fasFN6tj/E7INSDQVlTHqLJo+ng7BArPE4O94ualrNtRGa0Y
NrgUHvJGAy9FHjGcXObXePxVPe/Kh0fad/dWcfeSmPZmB/l2RCE2dqt5820CXPJB
SZBhYl35H7xgyRKBk2bwJw64fUxVmz4pNst77prxyeeyrNQSIL4xCRzh5xCy5/8i
oIvncFIBlyhxpgSWUxXDyXiGZytf3+Em4nhRxY0XZoTugKfCpjwU1uk4vBzshKAe
cd/Q+Vh5nMRkblG+9Xwtpu2wIchAX9/mee+Iqjy9tkanxKMbvudZzOR4ACfmAj1x
3Wra93sF2UhyVd8XIAj2m8mn/V1g4LNmWuKLMC6TepVaWWi5fSZe5m2GV713/78d
c/lgy5ZBaxRL8F6cbdNJxWNytXnxVjkxTHFcKQYl9/YupgOmZG08yMkHF6OUT0Du
ECxTEH9Hz9MfXUq5vADNWEY1uo46dIKpcHfNtxhgh3eiUjFb7IocLqSB3mH2cYEU
08oZ6w4k+FZAMPVnQCm0ef00mGPaQZnKHEFTbHQvVTppy8DHYyXBjpT8fEQ5fpwv
oPTAixCWX4SlQ+JUGXsOK+LNCNyK7DNTwdkM3DSt43fxyY75hNfUXczW3VUwmZmy
dxDOcbrdZI9FmTPdO00yEj8iuYYfRAxEaGjJnvO4Z2L41LPuwKhcJuMQu7ilHK3q
odKkpWjbZcyRpsJwm80JFVy3Ag947e0DXbpPlWWfEBlKlyIvpjexxg8n/8l5zFeX
ltyLsla7J5zqYPzOZhO6bny79KW70+ZEUFPgMwb7OtzQy0hxh0XRiwmrRT5nc4x/
EHb3zRUOhG2hMHrp6e/2x14PsinaVbAVk5lgxAxl7yYsoAFLXMQTv3JtbkjcbPIT
H6evpQzW3wtqw+iu4ZOeFcir5XXcpiou1PghjAta4y+mi1afUQDpeO4L5dvKqeto
Tro4RgRYV46F2xRIgbZY8wQIZAPtzGISs0+kY31gVXBY+ER6okBailR076ySAESV
uurk7IgUNtIIpTaOR/eyILvIL5zHTtlzNiJxEz4mnsVv4wbnM+OUqHem5xw5eKU1
/vjqU8buwJOf5nBzXTTVPcr9vcvJZBuOv/ypcZK3BCplceSxb5Xu9AWWTt/o0AOy
zgEUTU4mCiDzmgK/DFy4MEjcfvgnXJufnxIw40Vmjyw9ECvfdcRBVl0KP9zgRAN9
AYTChMdMQ8fWTi9gDmsNMggNXLEdSVw3lWjR59to4o4OELedcqiU3pG28ZzD9pkx
3uETfidvT0EU0FWpBiX3Gts9IbKVc/xPkebitHSHo8GXK8KhWMiWlQDR0qZGHZj1
ehY4rAadI/VVtdJadDCRMn8YE6E0t8HtEp6wJD/aWJq6LKOwQsJMfuJhVRC+Px5v
6rwcPTKsIt6AEeU21ODI67fAZc2XWHLog9Uwq7kGRfE/fbjJmfUKblar7P2iR6Zd
Tlm8hEx5ZMMDOVCMlgTxEoxWXrHIqMa4biR6ycrNkzRiyp8Qeb2e23XoNJypA1EJ
R3OxTXcTMsV22iHsHbooSr4sY3H+kzW8gQTDOdBCZvVwICNNuFXeQCWpSwu1Mx3X
IGOy/GENbQeM5fqCeOeHvwRGA81fE595zkDbAM49HE/dmmQFUr+scVTLFF6PboN+
ABVWXz19mdLoe4/BCTCaMc6GAxZGNgLCSoRqsnbC2Xw6a/VkP1NDD1iES9/QXUgM
zj8vY0My6b6TV6yCV7C5jtN2hWsTH0Dwle7w7z7buLqf3dkEuTQ6mFf/B4AqJ27d
1aaAaU4ZlhIlppmQ6Ash8bfx7rKQqHCybYys2yjIlqGNLHEZ4t7X3+7NzYG8Mgrg
OA6OXZeGtNkneYCac2V6SN6b54C/pBbeNAG3fQh5cdQe4Sz86g9d2tGpG8sZXH3I
yf6j2Bf4FQUIUdl9vaDTxG1z5GtrERPLfLRE96h+f5MCLmlPxawSu7E4Mz21C7N7
n6qd0kxel4ckMFyA7EyIWKD9hZFKU8S0G7PzWdpXXO2bUTno3UHZrRzcU1b3piG4
IPLiXCzv74KsxdTbN+coxAhntvwzKr/xSaKP9zr2XIffF6ANXqyYA8kOLery7WRW
sXj9vrGAbLQcxI9VFW1MmCmNENJe5wP3nCrmksnRJ39ucjv8nBr7YUtD0+lUg+zq
XIjiBJ+OYe9fIhJNIyXQeJTFK7YD0dIrcYC9UVhe0ZpV6G0kHHCDusRY9iHl39BK
i817Hg/uDJB0Q2X78U7EAx69lft/YY9xKybcUeKIF+RWSGsT+L+zSArG9BcRCYId
a1V5zMTDr7TeW8BdCyL4veYijRAP/pxSKtm/xKk/9trCob8d7758fsNEbpDNh0EH
jJbLDUBdw0Prgx59jIlY0XjSe7hplKs1puqn4DAvrhMUEVSca5Bu8UYPrhDv+yJh
ND1joVZZymp9TZQ0Uwvtje+Hr7mdZ8aDmUvP7mb2z1IrAU8AwdYFPl4wYGrRpXsb
osGjSMsZ1SlEQ6wlDrIJpr+/2Hg6rcbCj3CtMkPbcK8PxGH2ZQc8+YaOYzRmEBpx
o3NQzdq57J9MxzUVTM8HJPn4bi+M0R9EUO9wdTNCxY1ZWeqHqV5GJxibzcbf5Gmm
h6qF5g8RTkwPW9m54ouD88qEBLvPKTfIJkFz3UyamYmnGDHsmgInlA8X5OGPwWnU
5gGnsqPjDPGboqgnTXSaXjnEKJ68U4TI6p6e8ta0iHSKGk55GUK8Tswkb+TJ2aOy
hUo5gHeWzSg80eQ3nE1YWJI8AgrYO8sIqYraPRbC9MYGet3/6N0BZqVG3f1sjLx/
ktKNnyMpCTsytIaDmhx8GyrL6pmBBpoW98vD/OoRdoRdnNJcKGxxp21jSXRlWe0z
Mzg4E3CXKBQW/pfCApzY/NG81wyIxKqQjFIFrnhkWdel6PzoSXzoZmDwdgMyAJ29
rzm9lXSYYt+MpnfnSb1LTKFv/6PAQpZkPbBIRBtvfWZzLgZKM+9KAvbHqErlvTZc
1rQUCvi+fHy7qZj4ekv74zZMYhzQtwopewVUy7dfat/OkXH3mfM4lU+1w+wXGHrU
IxQU9AnVqRnFAR77kY+6QJyqNc95ev5WR0/wmeFpnYoFxKkdZ0aMvTbJVcEMQ608
MzNJQQfqMLtElowfGjfofw0tLFumKpuaHfzkPP/DLtzdJ2EwqrNFhEmAWknyw0K1
VdqPyIz5WHVHp7TAojfJyUpSQ29FELo+csxN+U2UDcGOb5oibQPCIjNWrH1Zrwtq
0w+nNjuyHFI/w08N5AJnnFKmAvEKbtv82Z4jgryPfFqOqF1ufJCFJKlHr6n1gwFE
akSe5j82X2osw61GWgYQVl9eD27hzUay23SXwy/AX/jJZxpqUqbEICG8sznIP3Mg
uwiV7lOCHZnnZDDD5KnurkOEuTbMfE1aOLnE4Lgh2q4Z+pt1ha6oy3BYSq/yTMfI
JHUcM7irdRysHyX3CFwZjEqp0xWCypNF411xyqcVmqMeM4Kxgs6y+wEIkCzoHZ05
xYtfXcKkzreu219w9tQ0Le+23ALeeKiePMKLDxVLxHn5VhzulWypxX2+OEaXBxfS
TVjLKINLxH9wjP4q1HftjYLQhFYOolOiKg1T3fFHQAx5Z5gtgd7tvh8rrDB35JYI
C/xvVsXQu97U1IkA/Bi3AIp75Nz4NCPpk/z4yGiW9U58z0pKOzmuPPFM/FhhaGjv
Yvbir7RHgZKlN2M18WrZSAv466HEabfDkYQ/9wFZCDOzfxZCHylrr/g80U3f4NNY
J6jV7CwgrKwYudUvNndzKAzVek0WeqZ3Dsvs107qT1mY1wmsY6wwOlPswDwEyyQF
xBC2jsrzcA7llffhnxZ0a5YnfMT/uDYO3nopcPFBlIjPVhlWxPQgcjjMAQbpgCqy
CPUHdsVRw1RsND1IFQ+9CqCjEmQ3gB/JQtalfou0FV/BvwFSXLQQ9n4bvvoH8ttw
8IigiyF+ETKIHRSVJ5czjAxl0FF+smkKicPvA1McmdaAJVf8f4LqrIxEw8eyNCwF
CV9NnuCiaHgQWsnxdjqfdYynkBpGoYM+fVjHXWS7yAmpxkXO9wpjcb/TSvRQMLWY
HNRrm3+d1D0wlJipUXn4+FrB7BAz6d07xFPnD7T7IF879KeGnBhNtKNfMfL3d4W4
4KmS0/ONYmkdSs3sMzQg8QPL5Tm72d5EQ9fdw1sMrA6WfnO7NYA4CzwBKgrz/gwa
4EdjIwdgw5cS5+EmvhWaWSxePdz4oRcEBe5TlxD0xp3CydC1ODdPNXzMH4lh6u8A
vdHV4Bcrm/zZAPk2N503/7x7YDAX+xReBpQgRZTMRuiJMmepz/V/SvHsdxAKuSkK
VkMFZ8mNGlyCjxiUP9X5J2o7QI9D3sEQ0uVLr8y6c+ws0pcR3NAQAgucTYO0IGsv
8Z0FcHc8+t78xHigqhL6NGI0JhaYdeOlxXNUb9W6+uXOQsG404s/cZC6x3Uuynls
5BuFgS9p2DnyAeuBW8cCurg0pUwEdZXrl1ajttqS4FegK1QNSsiaavdD6h9rU8W5
osaU1vvCQz/YeznlFhP5NZ3btPl/WKkbQnF2fYHfXZxXySQVlU+b7OP6Wjh9PU8E
z6N3EGYiBxCSGrUO5gAikE73gcapQ+5+ecO9LGJO6iFoXNzClwWEgWW2oIZbD6Rx
EjMtLBiqpvj6rIynftl8CYMp+JNUErVptATt5XVW4A5/dmQqXoyexiVXl6dzuPEX
NE+qSGjsvSBAZvEIfe3f1qzK9eNRppq6nFeAhIJgLH/bKRAMbeC8zmhTBte0a9Vs
HqsGGSbTPteXyOkLXmYP4nIIsadbJ4eUoDz1XEO2hFwi2FLY5R6z5SOYTkZ+Ibgb
5yPT1SoBW32spGaqUdLw84IxUXpTGJYtQcB71KBw4KfeKNI2IwMGEKMvtHrbVI3f
yPucbqEJ2+6m/O0Nq40gum7QZSVLavRITDKIhZybBUbAJdGnLJIF9PQl7hxcT1+e
dN4C/eg47lg8TxdMhadL51eQMJ4rFpif5tIUZkGrYHTT/M/PnM6QNuoTo58FEnLa
qFuaVPwePA8g17fN4ubKG0C8ogOLgTRo4vfRj7VH7DEDf9ASvZaRy12zPvzr8sEv
VAJ5SvpglTrJM1/I5cl7Pxb0naQZ+ZC4xFU2QLakhqdWgdMrxCNcvtKA1c7ksIAQ
mXJ416trr50vfJ84Qybr+HYyZ+/ZW3UZTT78dzHwSofiLYGy5Y+qbp9Ylw+UIA4H
tTmFogP3jAVkXYCCzGtWpQKNaPwGh22jAbgBEUGtQQ5eivpAKEWFJ4WVzwyTl2qE
L3iBPczEEqRicwA0u2C2/JnDUXzC7OcCNdcbyBBGvpa2MbTgpLB6ziSQBS4HQCBV
GYJvtDp446RRzHiZ6tVf/BkIF49bFZsBi1JJaWhrUle3JGecLUx5g+ZSpw8jtWZi
RVAwTl7L22gxQwZ9TZRrrHVwKC/AKqmmfURDnuugmv2BY4jCetAsTQTaRuB4DN1l
TS0Vt9cGSbrMvK1xXEjSuE7t9gdZA7ielkTU2OI9SFmyZd+/Q+5QJ0wBq2F6w3Gu
Ppc4yWDLehu7ZUo7Ut+AwQdnqKCUR9vnx0vNOOg9iBba6E2APU34q1WTAECVEgyd
CvUj+tg1laixhzIrMTwy+q2Nrxvhrd9/AvH0ug4UlbfEBHTQUQ38wTqI2Fjd2guP
m8HfZsJQ2Ebf4G9b9nhgJP30r+XgEjHgTuj+HM01M+GibAaoMZBk5kB6cD7skaSZ
GAtB1Bf2XMDJMnmr5csEyGQFSsQfmySVweDcjBxSKD9n/AFXgbtKvlLRolqBa25G
jfHMWq8KsDmeogHOk/XFd9b+jUp4CWAAWbxe2E9OyEIxm98oGMLJvfSi9OTK4WaP
tREMRcDpAZ8gmxPIuidCI3RfcGg2TvzTrhzrbNOd3HiwvQS4Fy0NgR5bFPXPdSCB
lyDfmo3kHzumlD3nxtaFbXo3bwkIeY7FctiaXE5lHasFdq95nA8ROu9+nutxl2l6
QPA6XXyseERJlyjmyJ4NAxlEpLEoee5sPme2iih6TOQNNkqPVjd551JHDn5SKBCw
Fl+mpDGQEzBrNKy5xT2ssI21kUt/xcFjLTIUsuEPY1ChqNj/PFgNoHDGXRkFAvSg
4/GVqix0yyT7w8edAAFpwI7vccfsSezdOoc8Gx6rNVRPWMRkD+x+1W9H1DZrTtQs
EGxsFiUFLZ2n8uIDY6tI+27c76xKSTV00KQPA/o/ync4QW7KX16CiCt5EiMeMpfa
qtp4vPpH4Ar0P1gqpJn1x6JkObhHU26pPSCK1ezASjDZmTj25PTNdcYtgdJQ7IYj
X2WREfiXtXaDxf9LrpgvsM6oOPYDvq4zVl4ZM0aWW8XeLqC4Pc76rXOlHkvt9eee
okVvuRY01tX4SU4JXGhIruVCTnKdfRuClFD+aZNdGA9roYxjbuj0AY9ruk4iaSOr
HusKfCGQMvTKAiDuELpAWSPo+rubF55UAAnbhszOMjU3/xlRPgQmUQ6XfDkijvGW
N0mj0HyZvl5IRcdv2GjbtT79HRgMY+S8425PfRQ4WVvjjf2xM0aB12iSMTuiwKuO
8sbttDUgQzuUsK/+TVUfkWmrZbYQqX1u9QoUtj7vKEtFLhFxHhZvzF2I1uOEb70V
YGkskYU5wFV/Jh1Vj4PgbKZvSvWzw6RIHgsc/hRqyvs1DnYA7RAQm9tEA7YGXtUx
Wz63VMqPMt7/gn57vzJHM2fbvvjyO2mlWBxalYlEXT/i9NJj7USyvWvo4G8RdWJX
C2PtjXR62jQc3gCHpYj2ZumVhwE85753yIWp3qp1+4YanOJe1QbPNEVdZOFg0AZz
wA0D8k6foASJcWbykZ99D4EoBXCEw9VSd8gzqw46YouBu5UAooCiEjAl3Opd4JRW
TXPp49HZzTCOMUp4ykT561raO6rV9qcRJMbnudShxOni8aiDZYnHmDVUy1EC2G7/
AnrlGfLC9+/+dln5jwQ1U1gQ7xXgBssoTFKqlwpaiRzmNNFnFoC/1ij3UHbkkpt5
ZJzLKPAvEBIHL6wpwcV7M44t45eBQhaxl3GrgHWGneMMav4WTtYT4+q8h+ufYXSW
HsA5DEi/n1/EOemQ55dE4xWT5yPHdIqwJhbh6AE1WfJTdMXvKLSrJIsh8fym9fOx
UwixxVEj3+uXmAHxPuPTnLFd/C0iM+8aVaccJBdNEZ7MZLOErcw9zZVnpu5LNeOH
Ei8ANnJx7K4BBflOGCrUS1kdFM3HUGokH7vBP4xVIpVYUwZJtkhbuMdjiCz8svdy
b7WWHSTc1WOYCkzGf+w1BIvEMUmXQVSsC7IBX1kaNXPAM8iXX1JZb/50s3PsGcvc
a47pAsTPWFzK+HnVXiouYZmkzxfISs0kG4BTuiYxI8GrtcmcJM8UMKI46b3oIeik
PcZi1AM5ZUzfz/drL7P+mCbQsLlhO1Ii5zf3J0YDrtE125Q6nyLcBFePvkvajibk
EEi0Qx1DduMiZz7DogJtOLOm3OBjp6KjjsOaFL2wtVQ/nqAM6pWVrsptptfQrGoe
6qHvz+OuUL4QwJWJDdxWrHmSfi60pYAu5SiaRx40R0myjtdsdtmv6zpi/x1OncwI
19QN5Z8nt2dkX7g5jPdtCWd5wDpd4dMef7Gz9Oov6d9pLojzzyCRrf5u6xevPfQw
ymWBa/3trJQZBQcH19C6+6Sc9AxisYz5s2XSVnjXFogRZOip5ZrADE+AC989bixa
CvExsnYD8M13ToZEK83rdBKwC6r8+bUml+CE0/ThMSs1/ltLYCX1j4FXni8yKPPK
2dA0wkD9DgMGq5F9vWPG7nf23dfjqo4dTj/yLqfWtD7dFKZUlYTg+AaW2VVTSrbL
3S22b1Vs3WaIbwAWYeY9u9CncicVjXgFcsHMpX8BUFeZKPdmXihsbzjcJC6kzf//
eC2Dm6scRprmhgF4//LkrrFYLnhe7uVK8UD2do6Q08k/AOHDU3iqUnelUaeWjAyU
EzV7xOWKgeYxrICOFFpTdDbEVYI/IlSON4Ma7M7J4LXbdkFHKCTzQryBVJAAy5sA
h8C0d/A73XWAwP7O1kQHdFVS4uUF0/C4HzJlPtG8VPTjYZOsyE5TxMxjcuWvspkV
diNHvtdiwMD9WBEl5xohabsCi4LdWmNqP3SbZceu0sRYPxMEoxkVzlyDUPnZWdl+
xHSkTlQ0PIUYbOetyhnCzEfuxk4xK38H0LYzu69ZeLlxcaYxjwRqQPkiCL9wXYNt
BNaYPiOJEeqgAS8PibN4d6Yt3tsSuZ8O7HNl3uEnuNgl6OJ9kJtfHHJCcCCskyrP
t+YGRgfCx1r8Gw2xBVJ3dPcNpjcw6hY5thYgh3UhYtQ06b84aUw16KNTC6ton7VZ
p4WSBT+ATO/AC5ipfFxj1vKkp6zJLpCW4+EPOvGBLpMSjGyMozfgYmdNPS7+wmx/
0uPvXDBw1rreA3vWJKU+GoxX0Ej/uBLTKEYPoUof0ZPT4gGSP0pbtTT9IKQjjfy9
ODjaqPX53dAksPbPMpM83tmfsOOFFJK729MiJqQ2qPZquRhZUpRgZ0Yy3USuOIrS
NNKyqUPZOSb+LGO8JKyaqZZk0cnsPnOcAPR2cOs2+FXSOxwRaYPbdZ5Yih0yMZ2S
r1YGw4x3asaAiqOhLaZsiuUBHdL+0b0AeStll+MjG4TopeIdEHWhKcXHp40fBqw/
yBLEBYUYXo89w8FDe0rsA3oeKe4iwd0yexAI6+gjnXckGkUy7W0OAkyraT/uVnYZ
L/usyxMXsqCULPavq29QO+11f4n5x9hL977aN+FLOSFy4+KF8eN1Wk57cwCOzMP5
QsQXoS1GnUNOKK2e9i+YTqzSZ7QTpsBMUXxyfgdlDeVbExm0W0xfmlB9G1sCXCZC
GmicY19t11VAlB5QF/M7bace0nw/kje430G6y0ZM/V3ITzFy2NuBXZ5XPZaf0juL
cVdoLI7HWIwmhciGVEOf9l2ciQi+p8iYUmmZd1VP1niZFZCeeTd0tTK08VPKaw7W
FQYV8tKSTFEx1UY5wzU2O6aaL38HO039Jzp7Zg4P82LCmFoabvdHDW0zcrHsNkvN
DflkWYf/zq6unbyKu6ktfTSyReuu26jO8fRzEiKAM9/iuJucZD7QqSE7vUyGCaw7
yv1i/73MRzX/9n+tjrvXbAVZtlSs2DHHqM2IK9aMRqMq2SA0QXwVzbrovXX4jgvq
pVVC4H2aLuP284fcYhQuJmesZwmzzkNxM5jBAT0MtC9wKopjRs2IzYqG3laX/o9V
+DUCXN52GdPI1x9p4cj1t8o2ggahHBastOUq1ARWR17ABXnmbVVlmx5TrzNL+RIo
wXCpia3Faxur3j9kMmLRtBw1qiLQTUNMeLMTfemOo4JBit9FmSNcBhAyyeM73CC7
`pragma protect end_protected

`endif // GUARD_SVT_TRANSACTION_REPORT_SV

















`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
PkjIPT9c0HJyea9fSqnKuai1zHfQ0ro+OHlXRQ0JYueNdIaEBokUpsSzBCayDJOB
L75Xe2BVEU/MYBrFdSlYU3ccqsNbDWyjWxeuCRaorB6Rav7wc/Vv4CuExXPmHu8w
FZEJw1CI5djUgjVJ2lD3s7gRirS4Rqjur8UfF5jEMVg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 21384     )
j/T/3R1m5zKwrNvK/Bci8ULAxvJyTCFmdPTOrbiQU5nQVSAalszJnwmLM1AKbisn
/+trZkrCFV5ZEZ9J2ZAjkUqFKV+vgbAUrsLq6jKb0ht+P3JkRxEUE7E4LmCyY6Fg
`pragma protect end_protected
