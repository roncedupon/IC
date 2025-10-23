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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
VHCcGdKa3IhqKy5XX1WqVkj7srNFLrWP49jm5U3dVubV90ZaX1XGHwhFFyIpWt7d
iHUYjKTtgK+VNbSIzvqFw8k4uyhKD+hHaX9bZByplRCSCHfj26FXsYyLxtCjqMuL
wMKEuhH+zINvgZ8CXZBZqncYG+QRFiAjoBV3nZuauX4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2303      )
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
`pragma protect end_protected

`endif // GUARD_SVT_SVC_ERR_CHECK_STATS_SV


`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
HXWhGX0QaTPfXhja1OZ6ObqKm563SXrbAksI2pBWps/8PMa6OqHDqBvkGhqLUiGo
wHCdNQK/MxGY0pVK/li6JuDBk73S9lfwYywXH4/78YwQAx+K/q4R9MBFfbB1gYKo
K7AESFLxh3K+0NtJYPjZX8CJ2M03a0rVwoNgkbMAqCU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2386      )
g3tvIB7x8P2K+8MTfF2TYgQ9kJXOqCsFIWdL9MM4PjUknF9GvaYrzFC5vhS/CZTk
xk17Pd5hOCmQvvlyQX6zA/vG3NPRNNnyCuTbKcUc3/+Ggjza3fj1tyJH4zoVrIH1
`pragma protect end_protected
