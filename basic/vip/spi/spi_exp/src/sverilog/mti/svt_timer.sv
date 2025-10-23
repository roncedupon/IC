//=======================================================================
// COPYRIGHT (C) 2007-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_TIMER_SV
`define GUARD_SVT_TIMER_SV

`ifndef SVT_VMM_TECHNOLOGY
typedef class svt_non_abstract_report_object;
`endif

/**
 * Macro used to check the is_on state for a notification event in the current methodology.
 */
`define SVT_TIMER_EVENT_IS_ON(timername,eventname) \
`ifdef SVT_VMM_TECHNOLOGY \
  (timername.notify.is_on(timername.eventname)) \
`else \
  (timername.eventname.is_on()) \
`endif

/** Macro used to wait for a notification event in the current methodology */
`define SVT_TIMER_WAIT_FOR(timername,evname) \
`ifdef SVT_VMM_TECHNOLOGY \
  timername.notify.wait_for(timername.evname); \
`else \
  timername.evname.wait_trigger(); \
`endif

/** Macro used to wait for an 'on' notification event in the current methodology */
`define SVT_TIMER_WAIT_FOR_ON(timername,evname) \
`ifdef SVT_VMM_TECHNOLOGY \
  timername.notify.wait_for(timername.evname); \
`else \
  timername.evname.wait_on(); \
`endif

/** Macro used to wait for an 'off' a notification event in the current methodology */
`define SVT_TIMER_WAIT_FOR_OFF(timername,evname) \
`ifdef SVT_VMM_TECHNOLOGY \
  timername.notify.wait_for_off(timername.evname); \
`else \
  timername.evname.wait_off(); \
`endif

// =============================================================================
/**
 * This class provides basic timer capabilities. The client uses this
 * timer to watch for a timeout, after which a notification is generated.
 * If the specified activities occur before the timeout expiry,
 * the client can avoid the timeout by stopping the timer.
 *
 * The timer also accepts an optional svt_err_check object at construction. If
 * provided, this check instance is used to register a timeout check and to
 * flag successes and failures relative to the timeout check. 
 *
 * The timer is started by calling start_timer with timeout value. The timer is
 * started immediately, and allowed to run until the timer expires or the timer
 * is stopped.
 *
 * Once the timer has been stopped or has expired, the timer stops execution.
 * In the total absence of activity, the timer will not indicate a timeout condition.
 * The timer must be restarted by a new call to start_timer(), or by a call to
 * restart_timer().
 */
class svt_timer;

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Pre-defined notification event used to indicate whether the timer is
   * active. The event is an ON_OFF event.
   */
  int STARTED;
  /**
   * Pre-defined notification event used to indicate that the timer has
   * been stopped. The event is an ON_OFF event and is reset whenever
   * the timer is restarted.
   */
  int STOPPED;
  /**
   * Pre-defined notification event used to indicate that the timer has
   * expired. The event is an ON_OFF event and is reset whenever the
   * timer is restarted.
   */
  int EXPIRED;
  /**
   * Pre-defined notification event used to indicating a timeout event.
   * The event is a ONE_SHOT event. A message is also issued, with the
   * severity of the message controlled by the timeout_sev data field.
   */
  int TIMEOUT;

  /** Public data member which can be modified to change the severity of the timeout message */
  vmm_log::severities_e timeout_sev = vmm_log::WARNING_SEV;

  /** Log instance may be passed in via constructor. */
  vmm_log log;

  /** Notify used by the timer. */
  vmm_notify notify;
`else
  /**
   * Event used to indicate whether the timer is active. The event is an
   * ON_OFF event.
   */
  `SVT_XVM(event) STARTED;
  /**
   * Event used to indicate that the timer has been stopped. The event is an
   * ON_OFF event and is reset whenever the timer is restarted.
   */
  `SVT_XVM(event) STOPPED;
  /**
   * Event used to indicate that the timer has expired. The event is an ON_OFF
   * event and is reset whenever the timer is restarted.
   */
  `SVT_XVM(event) EXPIRED;
  /**
   * Event used to indicating a timeout event.  The event is a ONE_SHOT event.
   * A message is also issued, with the severity of the message controlled by the
   * timeout_sev data field.
   */
  `SVT_XVM(event) TIMEOUT;

  /**
   * Public data member which can be modified to change the verbosity of the timeout
   * message. Defaults to the verbosity corresponding to a 'warning' or 'note' message.
   */
  `SVT_XVM(verbosity) timeout_verb = `SVT_XVM_UC(MEDIUM);

  /**
   * Public data member which can be modified to change the severity of the timeout
   * message when timeout_verb is MEDIUM (i.e., when the timeout message is a
   * 'warning' or 'note' message. Defaults to the severity corresponding to a 'warning'
   * message.
   */
  `SVT_XVM(severity) timeout_sev = `SVT_XVM_UC(WARNING);

  /**
   * Component through which messages are routed.
   */
  `SVT_XVM(report_object) reporter;
`endif

  /**
   * Identifies the product suite with which a derivative class is associated. Can be accessed
   * through 'get_suite_name()', but cannot be altered after object creation.
   */
  protected string  suite_name = "";
  
  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
do6xb9WpleMI7qqZcb9+aBgy6mRWe0r6986SpkC3W9Qj9SjP/skzve7jzgqm0Mv2
VvLUy+YqryAs3c+L4i/5KV0GYqrqg5+lVa+0pdymKXfir8Uj+bzwc9/FqL6FM34H
42UP3M66laVRlySJpgz5oa0p6e7aBnG8+ttMfnzbgaA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2555      )
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
SVbJXgAqQCuLl42yUfOj5g==
`pragma protect end_protected

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Creates a new instance of this class.
   *
   * @param suite_name A String that identifies the product suite to which the
   * transaction object belongs.
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
   * @param suite_name A String that identifies the product suite to which the
   * transaction object belongs.
   * @param inst The name of the timer instance, for its logger.
   * @param check Provides access to a checker package to track the success/failure
   * of the timer.
   * @param reporter A component through which messages are routed
   */
  extern function new(string suite_name, string inst, svt_err_check check = null, `SVT_XVM(report_object) reporter = null);
`endif

  // ---------------------------------------------------------------------------
  /** Resets the contents of the object. */
  extern function void reset();

  // ---------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  /**
   * Initialize the contents with the provided objects.
   *
   * @param check Provides access to a checker package to track the success/failure
   * of the timer.
   * @param log An vmm_log object reference used to replace the default internal
   * logger.
   */
  extern function void init(svt_err_check check = null, vmm_log log = null);
`else
  /**
   * Initialize the contents with the provided objects.
   *
   * @param check Provides access to a checker package to track the success/failure
   * of the timer.
   * @param reporter A component through which messages are routed
   */
  extern function void init(svt_err_check check = null, `SVT_XVM(report_object) reporter = null);
`endif

  // ---------------------------------------------------------------------------
  /** Returns the suite name associated with the timer. */
  extern virtual function string get_suite_name();
  
  // ---------------------------------------------------------------------------
  /** Sets the instance name of this object. */
  extern virtual function void set_instance(string inst);

  // ---------------------------------------------------------------------------
  /** Returns the instance name of this object. */
  extern virtual function string get_instance();

  // ---------------------------------------------------------------------------
  /** Returns the current fuse_length. */
  extern virtual function real get_fuse_length();

  // ---------------------------------------------------------------------------
  /** If the timer is active, returns the current start time. Otherwise returns 0. */
  extern virtual function real get_start_time();

  // ---------------------------------------------------------------------------
  /** If the timer is active, returns the current stop time. Otherwise returns 0. */
  extern virtual function real get_stop_time();

  // ---------------------------------------------------------------------------
  /**
   * If the timer is active, returns the time delta between the current time and
   * the start time. Otherwise returns 0.
   */
  extern virtual function real get_expired_time();

  // ---------------------------------------------------------------------------
  /**
   * If the timer is active, returns the time delta between the current time and
   * the expected stop time. Otherwise returns 0.
   */
  extern virtual function real get_remaining_time();

  // ---------------------------------------------------------------------------
  /**
   * As the SVT library may be accessed by multiple VIP and testbench clients,
   * possibly with timescale settings which differ from each other and/or
   * which differ from the SVT timescale, the svt_timer includes a scaling
   * factor to convert from the client timescale to the SVT timescale.
   *
   * This method sets the scaling factor for time literal logic. All clients that
   * use svt_timer instances must call this method with a value of '1ns' before
   * using these timers. This calibrates the timers so that they can convert client
   * provided time literal values (i.e., interpreted using the client timescale)
   * into values consistent with the timescale being used by the SVT package.
   */
  extern function void calibrate(longint client_ns);

  //----------------------------------------------------------------------------
  /**
   * Watch out for the EXPIRED or STOPPED indication.
   *
   * @param timed_out Indicates whether the method is returning due to a timeout (1)
   * or due to the timer being stopped (0).
   */
  extern virtual task wait_for_timeout(output bit timed_out);

  //----------------------------------------------------------------------------
  /** Method to track a timeout forever, flagging timeouts if and when they occur. */
  extern virtual task track_timeout_forever();

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
   * Start the timer, setting up a timeout based on positive_fuse_value. For this
   * timer, a positive_fuse_value of 0 results in an infinite timeout.
   * @param positive_fuse_value The timeout time, interpreted by the do_delay()
   * method.
   * @param reason String that describes the reason for the start, and which is used to
   * indicate the start reason in the start messages.
   */
  extern virtual function void start_infinite_timer(real positive_fuse_value, string reason = "");

  //----------------------------------------------------------------------------
  /**
   * Start the timer, setting up a timeout based on positive_fuse_value. For this
   * timer, a positive_fuse_value of 0 results in an immediate timeout.
   * @param positive_fuse_value The timeout time, interpreted by the do_delay()
   * method.
   * @param reason String that describes the reason for the start, and which is used to
   * indicate the start reason in the start messages.
   */
  extern virtual function void start_finite_timer(real positive_fuse_value, string reason = "");

  //----------------------------------------------------------------------------
  /**
   * Retart the timer, using the current fuse_length, as specified by the most recent call
   * to any of the start_timer methods.
   * @param reason String that describes the reason for the restart, and which is used to
   * indicate the restart reason in the restart messages.
   */
  extern virtual function void restart_timer(string reason = "");

  //----------------------------------------------------------------------------
  /**
   * Stop the timer.
   * @param reason String that describes the reason for the stop, and which is used to
   * indicate the stop reason in the stop messages.
   */
  extern virtual function void stop_timer(string reason = "");

  //----------------------------------------------------------------------------
  /**
   * Method which actually implements the delay. By default implemented to just do a time unit based celay.
   * Extended classes could override this method to implement cycle or other types of delays.
   */
  extern virtual task do_delay(real delay_value);

  //----------------------------------------------------------------------------
  /** Block for fuse_length time delay */
  extern virtual protected task main(bit zero_is_infinite);

  // ---------------------------------------------------------------------------
  /** Returns 1 if timer is running, 0 otherwise */
  extern function bit is_active();

  // ---------------------------------------------------------------------------
  /**
   * Set the message verbosity associated with timer timeout. This method takes
   * care of the methodology specific severity settings.
   *
   * @param sev The severity level to be established.
   */
  extern function void set_timeout_sev(svt_types::severity_enum sev);

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
nYoVQ2RMjFVxMh1RuFGj7NARl3ymOUlBqQLheqRSlJfQluoKUQhe7MLnK1oCIlaf
48CBekW3/xANPoDiFYT8Q19aN6V7sK8Dr/KklTUXr5exOgVEIvZYcP5cHaKVRwQ7
upRJXBPzek8O3Y6QqTIQJ4PCqgBKPoTndTRXLvF8foQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 23330     )
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
`pragma protect end_protected

`endif // GUARD_SVT_TIMER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QplSubf2LgAvpJzSNRjB0QDGL2KgS2gQOH+ddmz4XY9nKkYAQar0rFClf9nBZ0VG
D1UuJkzdF67Ik2OYq0eg9EjmvLOlePI+fS9orh6E+0Ge1egunUIr4WNMZU3cFVVq
Ng82tIpEMkHChvH+WCP4MrFv9MP2dE3R64nPncZNkM8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 23413     )
vaW8DGI6mKWr42vHNse3pBpKlVShY4nrgNvvWlg32UKKZXehb3UnS2CyiwKAv2jZ
lip/dqFNuQS7YffPgfePLSwgQQRxJEaxTgv8UeNgNCGAJcFxl3/7IvagX0da3MjA
`pragma protect end_protected
