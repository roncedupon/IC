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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
l/iE5ecO3Rb0WkHGZqlmNmBs3hbK2lsolm7I2aipSTYUIwM9o59EOp1BnC9EyvEw
WShOV2twN9pBKE0zwBEI726rHwzxQFX9n5/uZWTTeMtJaDR3OD3k9oBUoKBpT0hd
m8Mqdqh/ibJeyQ7sJUAk3Qs2y043NFKWUtbkHZS3ShR7OFRRkTV56w==
//pragma protect end_key_block
//pragma protect digest_block
J3V5XFwLCWcg/hSquyIxQIZP0V0=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
WOczQTbbEWT2TTBzjAVqdMJAu+k=
//pragma protect end_digest_block
//pragma protect end_protected

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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
6ktTlQ6AYSv0olZvmEWj0mFszt52XWfopgJACc5p79Rr3h6ugNm9hmMLC0lGJulw
qYw559ujdm+6LMbsDjhWhf0E02wzArqTA/8C3Pa1liSs62BvtDsHSsX8qJE724kb
GHanFAJDqlnk6UR1Q6TT4e74HW85QZenpcxRCt0iHpy3mUE5shGHoQ==
//pragma protect end_key_block
//pragma protect digest_block
LIhHyCEADFVHggVnvu++QsQIwsY=
//pragma protect end_digest_block
//pragma protect data_block
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
G2NvY1UKINiRQPrbsGkJyQ==
//pragma protect end_data_block
//pragma protect digest_block
bT9tE6LVCLoQvJBCYTk9uwh7wIo=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_TIMER_SV
