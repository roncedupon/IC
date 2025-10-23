//=======================================================================
// COPYRIGHT (C) 2015-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_DEBUG_OPTS_SV
`define GUARD_SVT_DEBUG_OPTS_SV

// -------------------------------------------------------------------------
// SVT Debug constants
// -------------------------------------------------------------------------
`define SVT_DEBUG_OPTS_FILENAME "svt_debug.out"
`define SVT_DEBUG_OPTS_TRANSCRIPT_FILENAME "svt_debug.transcript"

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(R-2020.12,svt_defines)

`include `SVT_SOURCE_MAP_LIB_SRC_SVI(R-2020.12,svt_data_util)

`ifndef SVT_VMM_TECHNOLOGY
typedef class svt_non_abstract_report_object;
`endif

typedef class svt_debug_opts_carrier;

// =============================================================================
/**
 * The svt_debug_opts class is a singleton class that contains the automated
 * debug options requested by users.  Options are provided through the use of
 * runtime plusarg +svt_debug_opts are used to control the behavior of this feature.
 * 
 * The +svt_debug_opts plusarg accepts a string value with the following format:
 * inst:<string>,type:<string>,feature:<string>,start_time:<longint>,end_time:<longint>,verbosity:<string>
 * 
 * - inst Instance name of the VIP to apply the debug options to.  Regular expressions
 *   can be used to identify multiple VIP instances.  If no value is supplied then the
 *   debug options are applied to all VIP instances.
 * 
 * - type Class type to apply the debug options to.
 * 
 * - feature Sub-feature name to apply the debug options to.  Regular expressions
 *   can be used to identify multiple features.  Suites must define which features to
 *   enable through this option, and implement the controls necessary to honor this.
 * 
 * - start_time Time when the debug verbosity settings are applied.  The time supplied
 *   is in terms of the timescale that the VIP is compiled in.  If no value is supplied
 *   then the debug verbosity is not removed and remains in effect until the end of the
 *   simulation.
 * 
 * - end_time Time when the debug verbosity settings are removed.  The time supplied
 *   is in terms of the timescale that the VIP is compiled in.  If no value is supplied
 *   then the debug verbosity remains in effect until the end of the simulation.
 * 
 * - verbosity Verbosity setting that is applied at the start_time.
 * .
 */
class svt_debug_opts;

  /**
   * Struct to represent debug properties that have been enabled through the auto-debug
   * infrastructure.
   */
  typedef struct {
    string package_name;
    string timeunit_value;
  } package_timeunit_struct;

  /**
   * Struct to represent phase names and start times
   */
  typedef struct {
    string name;
    realtime value;
  } phase_start_time_struct;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Static log instance */
  static vmm_log log = new("svt_debug_opts", "Log for svt_debug_opts");
`else
  /** All messages routed through `SVT_XVM(top) */
  `SVT_XVM(report_object) reporter = svt_non_abstract_report_object::create_non_abstract_report_object("svt_debug_opts_reporter");
`endif

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
B4C/BLPrhFPQBg+7Z8W5ndXmKEKrh+FCIsdZFon5Az0CUiWQrXuAf+GYlgQS6PlI
pkkzsai0jz+UbGskQozMoTm+owvnR99XiN4teCCTRNU1W4yzq0Rk4zvzx64QWSVU
ZZMkLBFKFJEVH4EmN2MVR+syQd4p60Q9Z+8zTsW8NQHuxQuFl/Xx8g==
//pragma protect end_key_block
//pragma protect digest_block
1/PDM4w6X7F5Kv71TOaE3HmjaIg=
//pragma protect end_digest_block
//pragma protect data_block
yW0sE3ldRyINd9peHnHGG2h3X64zt91bP083jiwSI4knzSfzJmceLkAZh1prwAKY
F0N/1mAVU6vuIVnZ5Glz6wrMUrCl8OjqfZFL+SoJASIQjVYZVcPlH9qOHuN5Imjw
7YQp489FaJKVv2ekBEt62fbLW1lG+L4J11m/su9elmVgDuYfUUFDLlkyTV+FU3Nu
U6xkRMgC3LEnZVOoxIkFQ0ld5eOJD9AyOsfP8fDOs7aL34SIHqoTMt8LIJLOF2rQ
Dq+BN1BDV2TyxUiCaNq+AhnBVCuArWqWtDVtyKYevCAVboin16tT2Y98UCqNMw/H
HrPfUJGwR6OX8msNTcB+TjvhDM+6Fbyq0vPiB7QzHtkvlFMUTg7BoXuy2m/fH7A5
nldsuYCAcdsTw9H12CK5ZQMglxE2u1RbQNrZ+hT8eKgtc8ay+bAQlB2jRePJ2LZ2
apSVPf+r2k53y+c4h+0cJA3tWBL41lqnLTFp1TpBPqIPdGlCKniubeThRFmhdpNA
TuvWEOMPqOlvwXWsFcPrCQ==
//pragma protect end_data_block
//pragma protect digest_block
A9SM38ElPURhfKnJCqg1fgb1l7k=
//pragma protect end_digest_block
//pragma protect end_protected

  // ****************************************************************************
  // Internal Data
  // ****************************************************************************

  /** Flag that gets set if the +svt_debug_opts switch is supplied */
  local bit enable_debug = 0;

  /** Singleton handle */
  static local svt_debug_opts m_inst = new();

  /** The string supplied via the +svt_debug_opts runtime switch */
  local string plusarg_value;

  /** The string supplied via the +svt_debug_opts_force_cb_types runtime switch */
  local string force_cb_types_plusarg_value;

  /** Instance name supplied via the +svt_debug_opts runtime switch */
  local string plusarg_inst = `SVT_DATA_UTIL_UNSPECIFIED;

  /** Instance name supplied via the +svt_debug_opts runtime switch */
  local string plusarg_type = `SVT_DATA_UTIL_UNSPECIFIED;

  /** Optional feature name supplied via the +svt_debug_opts runtime switch */
  local string plusarg_feature = `SVT_DATA_UTIL_UNSPECIFIED;

  /** Optional start time supplied via the +svt_debug_opts runtime switch */
  local longint plusarg_start_time = 0;

  /** Optional end time supplied via the +svt_debug_opts runtime switch */
  local longint plusarg_end_time = -1;

  /** Optional verbosity supplied via the +svt_debug_opts runtime switch */
`ifndef SVT_VMM_TECHNOLOGY
  local int plusarg_verbosity = `SVT_XVM_UC(HIGH);
`else
  local int plusarg_verbosity = vmm_log::DEBUG_SEV;
`endif

  /** Verbosity value saved before the auto-debug features modify this. */
  local int original_verbosity = -1;

  /** File handle for logging auto-debug information */
  local int out_fh;

  /**
   * File handle for logging VIP transcript data when auto-debug is enabled.  Each VIP that
   * is enabled for debug will route all messages into this file.
   */
  local int transcript_fh;

  /**
   * Storage array for debug characteristics associated with each SVT VIP in the simulation
   */
  local svt_debug_vip_descriptor vip_descr[string];

  /**
   * Storage queue for pre-formatted header information
   */
  local string header[$];

  /**
   * Storage queue for timeunits associated with each package
   */
  local package_timeunit_struct package_timeunit[$];

  /**
   * Storage queue for the start time for each phase
   */
  local phase_start_time_struct phase_start_time[$];

  /**
   * Flag which indicates that the header has been logged in the
   * `SVT_DEBUG_OPTS_FILENAME.  The header section of the file contains simulator and
   * simulation mode information, VIP version information, and package timeunits.
   */
  local bit log_global_settings_done = 0;

  /**
   * Flag which indicates that VIP instance data has been logged in the
   * `SVT_DEBUG_OPTS_FILENAME file. Each VIP intance is recorded, along with whether
   * it is enabled for debug.  All VIP instances that are enabled for debug also list
   * every configuration property that is modified to enable debug features.
   */
  local bit log_instance_info_done = 0;

  /**
   * Flag which indicates that final information has been logged in the
   * `SVT_DEBUG_OPTS_FILENAME file. This section displays the start time of every phase.
   */
  local bit log_phase_times_done = 0;

  /**
   * List of object types which have been identified as types whose callbacks should
   * be force saved to fsdb when debug_opts enabled.
   */
  static local int force_cb_save_to_fsdb_type[string];

  /**
   * Flag to determine if callback execution should proceed for an individual callback
   */
  local bit is_playback_callback_available[string];

  /**
   * Mailbox to hold pattern data carrier objects associated with callbacks which are
   * used during playback.  The associative array is indexed by a string value
   * representing the callback name.  The callback name supplied is qualified with the
   * full path to the component that owns it, and so it is guaranteed to be unique.
   */
  local mailbox#(svt_debug_opts_carrier) callback_pdc[string];

  /**
   * associative array to hold pattern data carrier objects associated with callbacks
   * which are received from mailbox but values are not updated in the task 
   * update_object_prop_vals in svt_debug_opts_carrier. the associative array is 
   * indexed by a string value representing the callback name.  the callback name 
   * supplied is qualified with the full path to the component that owns it, and so
   * it is guaranteed to be unique.
   */
  svt_debug_opts_carrier playback_callback_intermediate_data_carrier[string];

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the data class.
   * 
   * Note: Should not be called directly.  Clients should instead call the static
   *       get() method to obtain a handle to the singleton.
   */
  extern function new();

  // ---------------------------------------------------------------------------
  /**
   * Obtain a handle to the singleton instance.
   * 
   * @return handle to the svt_debug_opts singleton instance
   */
  extern static function svt_debug_opts get();

  // ---------------------------------------------------------------------------
  /**
   * Obtains the plusarg value supplied via +svt_debug_opts and parses this into
   * internal control properties.
   */
  extern function void parse_plusarg();

  // ---------------------------------------------------------------------------
  /**
   * Obtains the debug_opts plusarg values supplied via keywords other than
   * +svt_debug_opts, as adjuncts to the +svt_debug_opts options. Only executed
   * if debug_opts have been enabled.
   */
  extern function void parse_secondary_plusargs();

  // ---------------------------------------------------------------------------
  /** 
   * Routine that tests whether the supplied instance name or type name matches the
   * values supplied through the +svt_debug_opts plusarg.  This method returns 0
   * if the supplied inst_name is a sub-component of a component that has been enabled
   * for debug.  The #is_parent_debug_enabled() method can be used to determine if
   * this condition was true.
   * 
   * This method also populates the #vip_descr storage array with the status of this
   * VIP instance.
   *
   * If empty inst_name and type_name values are provided this method returns the
   * an indication of whether debug is enabled for anything in the system.
   *
   * @param inst_name Instance name to check against
   * @param type_name Type name to check against
   * @return 1 if the supplied instance name was enabled for debug
   */
  extern function bit is_debug_enabled(string inst_name, string type_name);

  // ---------------------------------------------------------------------------
  /** 
   * Routine that returns true if the supplied instance name refers to a component
   * that is a sub-component of a component that has been enabled for debug.
   * 
   * @param inst_name Instance name to check against
   * @return 1 if the supplied instance name is a sub-component of a debug enabled component
   */
  extern function bit is_parent_debug_enabled(string inst_name);

  // ---------------------------------------------------------------------------
  /** 
   * Splits the leaf path from the top level instance if the component is enabled
   * for debug.
   * 
   * @param leaf_inst Full path name of a sub-component
   * @param top_level_inst Full path of the top-level component is returned
   * @param leaf_path Leaf path from the top level component is returned
   * @return 1 if the component is a sub-component of a debug enabled component.
   */
  extern function bit split_leaf_path_from_top_level(string leaf_inst, output string top_level_inst, output string leaf_path);

  // ---------------------------------------------------------------------------
  /** 
   * Marks the VIP descriptor entry for this instance as a top level component.
   * 
   * @param inst_name Instance name to update
   */
  extern function void set_top_level_component(string inst_name);

`ifdef SVT_FSDB_ENABLE
  // ----------------------------------------------------------------------------
  /**
   * Creates a new svt_vip_writer and sets it up for use by this VIP instance.
   *
   * @param instance_name The name of the instance with which the writer is associated.
   *
   * @param protocol_name The name of the protocol with which the objects being written
   * are associated.
   *
   * @param protocol_version The version of the protocol.
   *
   * @param suite_name The name of the suite with which the protocol is associated.
   * This is only required for suites that support PA-style extension definitions
   * with multiple sub-protocols.
   *
   * @return The svt_vip_writer which has been created and registered with this VIP instance.
   */
  extern function svt_vip_writer create_writer(string instance_name, string protocol_name, string protocol_version, 
                                        string suite_name = "");

  // ---------------------------------------------------------------------------
  /** 
   * Creates an instance of the VIP writer and adds it to the VIP descriptor entry
   * 
   * @param inst_name Instance name to update
   * @param writer Writer class to be set
   */
  extern function void set_writer(string inst_name, svt_vip_writer writer);
`endif

  // ---------------------------------------------------------------------------
  /** 
   * Returns the VIP writer reference for the supplied instance
   * 
   * @param inst_name Instance name to update
   */
  extern function svt_vip_writer get_writer(string inst_name);

  // ---------------------------------------------------------------------------
  /**
   * Routine that tests whether the supplied feature name matches the value
   * supplied through the +svt_debug_opts plusarg.
   * 
   * @param feature Instance name to check against
   * @return 1 if the supplied feature name was matched
   */
  extern function bit is_feature_match(string feature);

  // ---------------------------------------------------------------------------
  /**
   * Obtains the start_time value supplied through the +svt_debug_opts plusarg.
   * 
   * @return Start time value obtained
   */
  extern function longint get_start_time();

  // ---------------------------------------------------------------------------
  /**
   * Obtains the end_time value supplied through the +svt_debug_opts plusarg.
   * 
   * @return End time value obtained
   */
  extern function longint get_end_time();

  // ---------------------------------------------------------------------------
  /**
   * Obtains the verbosity value supplied through the +svt_debug_opts plusarg.
   * 
   * @return Verbosity value obtained
   */
  extern function int get_verbosity();

  /**
   * Obtains the file handle for the transcript file that contains VIP messages.
   * 
   * @return file handle
   */
  extern function int get_transcript_fh();

  // ---------------------------------------------------------------------------
  /**
   * Sets the global reporter to the debug verbosity
   */
  extern function void start_debug_verbosity();

  // ---------------------------------------------------------------------------
  /**
   * Restores the global reporter's original verboisity
   */
  extern function void end_debug_verbosity();

  // ---------------------------------------------------------------------------
  /**
   * Records a line of header information.  The following data is pushed to this method:
   * - Methodology and simulator information
   * - SVT and VIP version information
   * .
   * 
   * @param line Single line of formatted header information
   */
  extern function void record_header_line(string line);

  // ---------------------------------------------------------------------------
  /**
   * Records the timeunits that have been compiled for each package
   * 
   * @param package_name Name of the package for the supplied timeunit value
   * @param timeunit_value Timeunit value for the supplied package name
   */
  extern function void record_package_timeunit(string package_name, string timeunit_value);

  // ---------------------------------------------------------------------------
  /**
   * Stores the debug feature that is enabled through the auto-debug utility
   * 
   * @param inst Instance name that the debug property is associated with
   * @param prop_name Property name being recorded
   * @param prop_val Property value being recorded, expressed as a 1024 bit quantity.
   * @param status Status that indicates whether the feature was succesfully enabled
   */
  extern function void record_debug_property(string inst, string prop_name, bit [1023:0] prop_val, bit status);

  // ---------------------------------------------------------------------------
  /**
   * Records the start time for each phase
   * 
   * @param name Full context for the phase
   */
  extern function void record_phase_start_time(string name);

  // ---------------------------------------------------------------------------
  /** Logs the recorded general header information */
  extern function void log_global_settings();

  // ---------------------------------------------------------------------------
  /** Logs the recorded VIP header information */
  extern function void log_instance_info();

  // ---------------------------------------------------------------------------
  /** Logs the last debug information and closes the file handle */
  extern function void log_phase_times();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * This method can be used in VMM when the main hierarchy has been established and the file handles, etc.,
   * have been propagated, but new log objects are added to the mix. This basically just propagates the settings.
   *
   * @param inst_name Instance name to check against.
   * @param type_name Type name to check against.
   * @param new_log The log object to be updated.
   */
  extern function void propagate_messaging(string inst_name, string type_name, vmm_log new_log);
`else
  //----------------------------------------------------------------------------
  /**
   * Used to update the reporter messaging to go to a log file based on the debug_opts verbosity settings.
   *
   * @param set_reporter The report object to be updated with the new verbosity.
   */
  extern function void set_messaging(`SVT_XVM(report_object) set_reporter);

  //----------------------------------------------------------------------------
  /**
   * Used to restore reporter messaging to its original verbosity, and to redirect it to the display.
   *
   * @param restore_reporter The report object to be updated.
   * @param restore_verbosity The verbosity which is to be restored.
   */
  extern function void restore_messaging(`SVT_XVM(report_object) restore_reporter, int restore_verbosity);

  //----------------------------------------------------------------------------
  /**
   * Used to track the debug_opts start/end settings and update the messaging as needed.
   *
   * @param inst_name Instance name to check against.
   * @param type_name Type name to check against.
   * @param track_reporter The report object to be updated at the start and end times.
   * @param original_verbosity Verbosity value saved prior to modification by the auto-debug features.
   * Ignored if the start time has not occurred yet.
   */
  extern function void track_messaging(string inst_name, string type_name, `SVT_XVM(report_object) track_reporter, int original_verbosity);
`endif

  //----------------------------------------------------------------------------
  /**
   * Records various aspects of the VIP in the FSDB as scope attributes
   * 
   * @param inst Hierarchical name to the VIP instance
   * @param if_path Path to the interface instance
   */
  extern function void record_vip_info(string inst, string if_path);

  //----------------------------------------------------------------------------
  /**
   * Function used to add a callback method name or a list of object types to the
   * list of types identified as types whose callbacks should be force saved to
   * fsdb when debug_opts enabled.
   * 
   * @param add_type Callback method name or object type to be force logged
   */
  extern static function void add_force_cb_save_to_fsdb_type(string add_type);

  //----------------------------------------------------------------------------
  /**
   * Function used to see if any of the specified callback method names or object
   * types as callback arguments that have been identified as being needed to be
   * force saved to fsdb when debug_opts enabled.
   * 
   * @param cb_name Callback method name to force logging for
   * @param obj_type Queue of object types to force logging for
   */
  extern static function bit has_force_cb_save_to_fsdb_type(string cb_name, string obj_type[$] = '{});

  //----------------------------------------------------------------------------
  /**
   * Enables callback playback for the supplied callback name.  When playback for
   * a callback is not enabled the get_playback_callback_data_carrier() method will
   * return in zero time with a null reference for the pattern data carrier.
   * 
   * @param cb_name Full path to the callback in question
   */
  extern function void set_is_playback_callback_available(string cb_name);

  //----------------------------------------------------------------------------
  /**
   * Function used to obtain the patten data carrier object associated with a specific
   * callback name.  During playback these values are supplied via the
   * Playback Testbench after being extracted from the FSDB file.
   * 
   * @param cb_name Full path to the callback in question
   */
  extern function svt_debug_opts_carrier get_playback_callback_data_carrier(string cb_name);

  //----------------------------------------------------------------------------
  /**
   * Task used to push the pattern data carrier associated with a specific callback
   * name to the mailbox.  During playback these are are supplied by the Playback
   * Testbench after being extracted from the FSDB file.
   * 
   * @param cb_name Full path to the callback in question
   * @param pdc Pattern Data Carrier object associated with the latest callback execution
   */
  extern task put_playback_callback_data_carrier(string cb_name, svt_debug_opts_carrier pdc);

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
zdd5CUTM2rANoy1f+qpeEU/TtF9CR+ssQgQsgNevWezQ8V3d/5mhPNYAfFFOoufk
KfRxX/1A1H4eRRi9yFVDLVTGTKX6o9Uc/q9ktEP/kw58IxQxAjnhKoBxZVmsypoe
IkA82kUglxCA+4vmsU9C4TOUUChMjVVj8olyHAD18/GXAeEXLc/E+w==
//pragma protect end_key_block
//pragma protect digest_block
rTARJJ27ffoZ/yJTqftJXTQ38VY=
//pragma protect end_digest_block
//pragma protect data_block
HEez74Jfl41OaThY+yCPayWbNrdQ4KjF/2DJa8GHuSRn0TQltXyIkDkRHGbzL8aL
n1Vw0dc0CeAdtw/aetqnthff86IowSBK6Krx6276XVMEfYD+APgxOnpKBI1a4aH+
r+vjfinfa2qqZZpmM287H6Ql2WmyEN3sE2v2xBoYBhSQlVfR+2nS8MeMSqoXlbZC
EVuCnqHPJiye8E2HAyRdOkvH/LLktn8K+ERFu+8nP4Jg3HKy8lIfa3x7pYY6xsO1
Jwy5vEhcgnzmN/4DkWYUXVGqtMQzLqsrh7nXMtYv1DUcztTWZJveK5rCK2tqVQLQ
UOJbuG/x2W1aLPx6WLHbCmgHu3ng6Lk/12ySuO/ZHS+jmmTZIkucBhGf++h3dr5E
TT3qJ497Nozq6QtWk7Ya9G7spttTRIJ1xtfxBmDBFcntptRx1cCk6NUsle437tRr
2CCBVuY+m/lxzy2MqstQTLhBdlrLijBhIw8fXk7DReWVcqAlKoHDbPCJDcrw4DOX
ANa7oj6N7wAoMwSYn7GxI5tXsrpRM1xkD/CwgrJ6JTgt/m58yY3/ARQ3mL4zcj+c
0ymPWw/JZiImF/kmt55HX3vhE5SqLy9OP+JDsnZygg3JYWB2X3MgLT5hQKpLGmfL
TOKzbNEZk3P0cRuuALcKZmNa+XaxV3q7PF/4GuEJa/HgrLnrzRDtco35ol0HWKdY
t9gW2+BtI045LuQ9yXpsYg==
//pragma protect end_data_block
//pragma protect digest_block
fQCcIwKHUWKc4sr6EPjV/VgTqBg=
//pragma protect end_digest_block
//pragma protect end_protected

endclass: svt_debug_opts

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
czoX8lWa4QNbGscsvHMEsTF87bR6S0WFpYg82iOU1Co+jlcXxnrkkmIgNGDbAW8o
DfXZCd9QZc16Gn2dezkLbl54p5LfmvE1Ob/PozOM0ssCPdzlr+WsaqTlA3klmmzq
lUm5aUh5TBi9mayO1/n+ttHR0KmFUg6/QRYCkg8A45gwUWk27uJ0ew==
//pragma protect end_key_block
//pragma protect digest_block
KrG2t6aK3PtTYEF+EUGKur+3mlA=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
wQDMHxa1o7bfYurwNtAupJIgvZI=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_DEBUG_OPTS_SV
