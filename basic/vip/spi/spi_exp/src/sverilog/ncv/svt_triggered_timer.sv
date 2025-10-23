//=======================================================================
// COPYRIGHT (C) 2010-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_TRIGGERED_TIMER_SV
`define GUARD_SVT_TRIGGERED_TIMER_SV

// =============================================================================
/**
 * This class implements a timer which can be shared between processes, and
 * which does not need to be started or stopped from within permanent processes.
 * This timer is extended from svt_timer and otherwise implements the same
 * basic feature set as the svt_timer.
 */
class svt_triggered_timer extends svt_timer;

  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************

  /**
   * Specifies fuse duration, as provided by most recent start_timer call.
   */
  local real trigger_positive_fuse_value = -1;

  /**
   * Indicates whether a fuse_length of zero should be interpreted as an immediate (0)
   * or infinite (1) timeout request, as provided by most recent start_timer call.
   */
  local bit trigger_zero_is_infinite = 1;

  /**
   * String that describes the reason for the start as provided by the most recent
   * start_timer call. Used to indicate the start reason in the start messages.
   */
  local string trigger_reason = "";

  /**
   * When set to 1, allow a restart if the timer is already active. Provided by
   * the most recent start_timer call.
   */
  local bit trigger_allow_restart = 0;

  /**
   * Notification event used to indicate that a start has been requested.
   */
  local event start_requested;

  /**
   * Notification event used to kill this instance.
   */
  local event kill_requested;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Creates a new instance of this class.
   *
   * @param inst The name of the timer instance, for its logger.
   * @param check Provides access to a checker package to track the success/failure
   * of the timer.
   * @param log An vmm_log object reference used to replace the default internal
   * logger.
   */
  extern function new(string suite_name, string inst, svt_err_check check = null, vmm_log log = null);
`else
  /**
   * Creates a new instance of this class.
   *
   * @param inst The name of the timer instance, for its logger.
   * @param check Provides access to a checker package to track the success/failure
   * of the timer.
   * @param reporter An component through which messages are routed
   */
  extern function new(string suite_name, string inst, svt_err_check check = null, `SVT_XVM(report_object) reporter = null);
`endif
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
  //----------------------------------------------------------------------------
  /**
   * Function to kill the timer. Insures that all of the internal processes are stopped.
   */
  extern virtual function void kill_timer();

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ZhFd1TW7GbTsYbJAKimDieDESU/aXqSNFqNMBtZZmZojh12nDiuSfy2qnvf4QB2Z
216HbSF7jpNsHl9ZCQp3o86k6pc4Da8GnFs6KPf+CC01jkOyRpWhEwIP2NgZoLWb
aq6ajVQphVdianMeHPnO0Rf2h59WdIGGfjWYgIo4JZlveIq3ZvaVBg==
//pragma protect end_key_block
//pragma protect digest_block
KvJzuc7Wwoa9c9/IZw0HVhnKo54=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
dtrl+9Wh8bwW0e9efTZFWvYZc1Y=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_TRIGGERED_TIMER_SV

















