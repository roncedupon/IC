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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
jq1lXPX/iLLaJDWA1GrNVkOfvmxBOrAJCyDjXtoO9/ZvgyEwVwwt/zreBFpdTtH7
DUefw50Oy3dr2D4MfBTj9usQYgT+8YZEH1pSIvGBTpUwTFrG/sfxC8SF6o0SGI9h
U0MWHlvCdcjjT22B0uiuQpbbqQkr8dxo/1Q5jNmcanoZdBN7FZnk8w==
//pragma protect end_key_block
//pragma protect digest_block
ODVaBWU+KRCCrY7qxG9X2zYJ24U=
//pragma protect end_digest_block
//pragma protect data_block
kZHFsyQJ9ZjPJJtGnOfN5LSwglOmkyW6DjYzLojfrZoI86dmxZlDPJ+rgusVAMRe
T/9iHs78dwf/KASp/kl63bi7pf+gBT0krd/pFiOaKs7zG8j6uxsSGzwfSB18l4U/
fA+V/mlOqRjJFrBvZdv4poX3BrwWvKbSS79OPuXnsHxfHvF6iYUxLSqrTY9rEskn
LtOdsCzTGEOh944xdtjqOoS1uCJAM+8bOWrVo2oCjSNS6nE1SfUWm7sAERYjZdMT
P75iwXPG63JlNKRjYw4xMAZoroIgJYhvPbVEGVDg1SDXy5IR/HzAYvAP651nO3ii
yaCjoNGaeEgxhKvNy+5s2Q8ZTvXhiz8eVEEy2rNXWjA02X1mzqUnZah0IYNBAp9Z
tcczfy03uzILVwAOtcQ3XKE+WR4NAIkLws5UcEPnx9BSwhDTha3fY7OU7YgSdDK2
W1+2rQZ6bPlT+6wBljE3JUZ7tHeWREOJ5khE/pgnMbHOPdG2jiOg9dEVtiI7PAYa
KK4NqgghTxYLLPLYiOiDLlwLeqYhYHVu2LYKgYUC3z9EvcEpRvKtS+NFMDMsTvrJ
Nk5r9F4beJWT+QCGwKsn07ry+iZXz+C2Ve77y+hlTP1U4HaEbr06t4+k9EoBQ5Mw
MsrBnZensqdYycAbyN/PM1nRFE+03Nuppqjwx53zkhCIhHoAq3YZK7l3wLZQSdR3
LZRxZpunE9wi0CYp7pIl5nsTZNkFmwgXvhToxFVahE6SDiD/BhuEYZDQxTnVj9Mh
cfb9Lp50LCEscqZIuVniJlfzz4SvBGA7KUPUg6DjpJIxSjGfPlKRZnNpQbIK33Ak
8bjWvSuAH0DNHiA/ePGXoN4ZRkluyL+oOZ/eEHwa4O1NQrSX4qgJZzenYukFBpz+
j0+c6YGIV/8G1NM1xm9PkQ==
//pragma protect end_data_block
//pragma protect digest_block
UkDDdzOBau+0Q6EJEBAHFC6ikKk=
//pragma protect end_digest_block
//pragma protect end_protected

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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
gWFnFUByi/lAsjH0PnZSgnxdrZIpfzu/eu57ZOCR66JfhxpfHXaAmkD3gzRiW2ux
6lykWVz4pudXp9x4+rkXpTjTXkI5rJxE+DW7TM+oO4mDwXVhCKbPmuw+qF5tsSao
POFwOr/CW+up5JJrnGUpWT6jEy1bgiwuUy2ML9joJDOm6JOWoHt+1w==
//pragma protect end_key_block
//pragma protect digest_block
sl7+fkKJV/jiX2dZEewRhwC1laI=
//pragma protect end_digest_block
//pragma protect data_block
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
sE+g2DC+NzQrZQ+PDsyAwg==
//pragma protect end_data_block
//pragma protect digest_block
jHck1NYHlIQCFMEov92PQ5KotRs=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_TRANSACTION_REPORT_SV

















