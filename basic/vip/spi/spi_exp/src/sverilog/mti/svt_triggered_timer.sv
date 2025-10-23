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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
hqvhpL2J2OuRFgRFaZzDNZXcSa3hV4e/F8+PBTWa+gHATBVzMWqb5Ki2fdHLhHxj
KtmyYWtJjBegye+ZZLq5Sj6mW/XB6CWb2fqO2SVFwkYsh1v0p0ZnAossbiTPmMyo
NFyGi3BrvZ4pw3WJhXGpHoq8anCdV8I6Cg/DO4jJ+Ek=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1743      )
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
Q+u02EAWTarBiq57oApM4w==
`pragma protect end_protected

`endif // GUARD_SVT_TRIGGERED_TIMER_SV

















`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
iF5bkSzWJPhiznNRAkjMSUkc10n0tD109eEVDyVnBYfkbowrIAsXCR+NjeXAhgbU
KkMD2ZuaBhnm/JiupmcGX2Pw150kAn5AaclvsT+tC6MTad7gdAYh8vbjm/zMv4f8
PfbczupQwvtuCCnaeUDp2ocBGU7YeH0aTy7umKgPEXU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1826      )
i5gxOImjEahKtkwqy9bOW7OKfGIq54iCuti3xbs8HO/81Nip1QO7BRiqdaUJsIl9
+CZjZhrdJT0aIizYOhGIJQIbAUiJPEUwMHv+oL0kLxr1ngSXpkICoHDqecU8LLju
`pragma protect end_protected
