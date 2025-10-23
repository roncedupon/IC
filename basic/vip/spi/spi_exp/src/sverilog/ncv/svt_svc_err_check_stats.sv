//=======================================================================
// COPYRIGHT (C) 2016-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_SVC_ERR_CHECK_STATS_SV
`define GUARD_SVT_SVC_ERR_CHECK_STATS_SV

// =============================================================================
/**
 * Error Check Statistics Class extension for SVC interface 
 */
class svt_svc_err_check_stats extends svt_err_check_stats;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Handle to associated svc_msg_mgr */
  svt_svc_message_manager svc_msg_mgr;

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_svc_err_check_stats)
`endif

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new svt_err_check_stats instance, passing the appropriate
   *             argument values to the svt_data parent class.
   *
   * @param suite_name Passed in by transactor, to identify the model suite.
   *
   * @param check_id_str Unique string identifier.
   *
   * @param group The group to which the check belongs.
   *
   * @param sub_group The sub-group to which the check belongs.
   *
   * @param description Text description of the check.
   *
   * @param reference (Optional) Text to reference protocol spec requirement
   *        associated with the check.
   *
   * @param default_fail_effect (Optional: Default = ERROR) Sets the default handling
   *        of a failed check.
   *
   * @param filter_after_count (Optional) Sets the number of fails before automatic
   *        filtering is applied.
   *
   * @param is_enabled (Optional) The default enabled setting for the check.
   */
  extern function new(string suite_name="", string check_id_str="",
                      string group="", string sub_group="", string description="",
                      string reference = "", svt_err_check_stats::fail_effect_enum default_fail_effect = svt_err_check_stats::ERROR,
                      int filter_after_count = 0, 
                      bit is_enabled = 1);

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_svc_err_check_stats)
  `svt_data_member_end(svt_svc_err_check_stats)

  // ---------------------------------------------------------------------------
  /** Returns a string giving the name of the class. */
  extern virtual function string get_class_name();

  // ---------------------------------------------------------------------------
  /**
   * Registers a PASSED check with this class. As long as the pass has not been
   * filtered, this method produces log output with information about the check,
   * and the fact that it has PASSED.
   *
   * @param override_pass_effect (Optional: Default=DEFAULT) Allows the pass
   *                             to be overridden for this particular pass.
   *                             Most values correspond to the corresponding message
   *                             levels. The exceptions are
   *                             - IGNORE - No message is generated.
   *                             - EXPECTED - The message is generated as verbose.
   *                             .    
   * @param filename Optional argument identifying the source file for the message.
   * @param line Optional argument identifying the source line number for the message. 
   */
  extern virtual function void register_pass(svt_err_check_stats::fail_effect_enum override_pass_effect = svt_err_check_stats::DEFAULT,
                                             string filename = "", int line = 0);
  
  // ---------------------------------------------------------------------------
  /**
   * Registers a FAILED check with this class.  As long as the failure has not 
   * been filtered, this method produces log output with information about the 
   * check, and the fact that it has FAILED, along with a message (if specified).
   *
   * @param message               (Optional) Additional output that will be 
   *                              printed along with the basic failure message.
   *
   * @param override_fail_effect  (Optional: Default=DEFAULT) Allows the failure
   *                              to be overridden for this particular failure.
   * @param filename Optional argument identifying the source file for the message.
   * @param line Optional argument identifying the source line number for the message. 
   */
  extern virtual function void register_fail(string message = "", 
                                             svt_err_check_stats::fail_effect_enum override_fail_effect = svt_err_check_stats::DEFAULT,
                                             string filename = "", int line = 0);
  // ---------------------------------------------------------------------------
  
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
FYugUQ8G0lLEgrHwr6K9k669MnrN3CZHCgLjqW/DUE4dj/GX9W4faG0VBQhXCD+R
Pv676pKRIRfGLQnhef634clqzUriF52WmGzlPnrBYyN/qyuOA9xmph3Z3k2ECCDg
z5AilNUs5w4X4hoQzKTxHcqnXAxG2DgxzB0Ypc8LQ4xrI9vbSCoH1w==
//pragma protect end_key_block
//pragma protect digest_block
fj6MxHyHHjRy5Ct6adf8zU2x/P0=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
uWJ4gGI4pIBFjnrZyaomqFVTntQ=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SVC_ERR_CHECK_STATS_SV


