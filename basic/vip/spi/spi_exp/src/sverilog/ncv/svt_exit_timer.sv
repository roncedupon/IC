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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
+Cs3zEIsfEfWvG705Nqo6BjGAbhIDJvjkP7IXmf7m+UiljJQZNBis2o7eGdPdGyp
ihzroYP+NA9XiOCGODuQX+jkCQiHqqXsV7qHsFWIn2b5CSFfKHJ3QA5X5y1rLtso
LgvwMcc5Qsc//O/38EeHV/hVUp3b5ZWA6hDaY0rxDijjGPRTxYNrZA==
//pragma protect end_key_block
//pragma protect digest_block
28oEcYHSyYKqVwgUl6b5KOu8KcA=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
Gw0sY21+mG6ZHEG3LUxBIsMbKFA=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_EXIT_TIMER_SV
