//=======================================================================
// COPYRIGHT (C) 2009-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_EXIT_TIMER_SV
`define GUARD_SVT_EXIT_TIMER_SV

//svt_vipdk_exclude
`ifndef SVT_VMM_TECHNOLOGY
  typedef class svt_voter;
`endif

//svt_vipdk_end_exclude
// =============================================================================
/**
 * This class is provides a timer which also acts as a consensus voter which
 * can force simulation exit when the timer value is reached.
 */
class svt_exit_timer extends svt_timer;

  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************

  /**
   * Voter class registered with the consensus class that is passed into the
   * constructor.
   */
//svt_vipdk_exclude
`ifdef SVT_VMM_TECHNOLOGY
//svt_vipdk_end_exclude
  local vmm_voter voter;
//svt_vipdk_exclude
`else
  local svt_voter voter;
`endif
//svt_vipdk_end_exclude

  /**
   * Name associated with the timeout value. Used in message display.
   */
  local string timeout_name = "";

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Methods
  // ****************************************************************************

//svt_vipdk_exclude
`ifdef SVT_VMM_TECHNOLOGY
//svt_vipdk_end_exclude
  //----------------------------------------------------------------------------
  /**
   * Creates a new instance of this class.
   *
   * @param inst The name of the timer instance, for its logger.
   * @param timeout_name The name associated with the timeout value used with this timer.
   * @param check Provides access to a checker package to track the success/failure
   * of the timer.
   * @param voter Voter which the 'exit' is indicated to.
   * @param log An vmm_log object reference used to replace the default internal
   * logger.
   */
  extern function new(string suite_name, string inst, string timeout_name, svt_err_check check = null, vmm_voter voter, vmm_log log = null);
//svt_vipdk_exclude
`else
  /**
   * Creates a new instance of this class.
   *
   * @param inst The name of the timer instance, for its logger.
   * @param timeout_name The name associated with the timeout value used with this timer.
   * @param check Provides access to a checker package to track the success/failure
   * of the timer.
   * @param voter Voter which the 'exit' is indicated to.
   * @param reporter An component through which messages are routed
   */
  extern function new(string suite_name, string inst, string timeout_name, svt_err_check check = null, svt_voter voter, `SVT_XVM(report_object) reporter = null);
`endif
//svt_vipdk_end_exclude

  //----------------------------------------------------------------------------
  /**
   * Start the timer, setting up a timeout based on positive_fuse_value. If timer is
   * already active and allow_restart is 1 then the positive_fuse_value and
   * zero_is_infinite fields are used to update the state of the timer and then a
   * restart is initiated. If timer is already active and allow_restart is 0 then a
   * warning is generated and the timer is not restarted.
   * @param positive_fuse_value The timeout time, interpreted by the do_delay()
   * method.
   * @param reason String that describes the reason for the start, and which is used to
   * indicate the start reason in the start messages.
   * @param zero_is_infinite Indicates whether a positive_fuse_value of zero should
   * be interpreted as an immediate (0) or infinite (1) timeout request.
   * @param allow_restart When set to 1, allow a restart if the timer is already active.
   */
  extern virtual function void start_timer(real positive_fuse_value, string reason = "", bit zero_is_infinite = 1, bit allow_restart = 0);

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
mHChNJkOc96zwLcmUTGKRk2S1BypWKrLTCTO+IwirtMwCjGsrSW64mXtnQTqPc7+
ozPrOjCfxCDWRENmaJusAwOMidbelczLu0BKWG/fS4fEiMShAy3f22RLFcfFLGrl
ZswK77ldKd6DbQFryjBkX6LA+Ngd+letSEohBeSG39M=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2895      )
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
mea6zovUz7sb4Fe4soPEBQ==
`pragma protect end_protected

`endif // GUARD_SVT_EXIT_TIMER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lDEyji2TTRNw8SMEkuZHFO8LG1sLBcYl5sBiHFClSFWOpVwjTY6EiAAWTXD5XCjv
ejQEe7Vwx+PTv2UMJq681NHwAEFx4gqq4kcdDUzCSKP26TQlPJaz2Y3+mW/i3R0u
PCmMtEMMF8E9gmaqS7vXqvRCA9m1PkSmXN7uXgxaAwU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2978      )
Ea5+60nj/KY1D2ggX1laJJ8en5yk7s7Fd5mvcBQjEpiB+/w7Pl271Ij8fmRbgvod
uT9W49MjtcIq2JY4Bi/bhbBEj+BSOT5TbbIIkud4pky3xdV26QHXcRJhsNKCeiPl
`pragma protect end_protected
