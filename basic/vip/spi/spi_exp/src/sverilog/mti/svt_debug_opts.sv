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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
YyXiwCOsucAZlaew8c3Y5J1zMCHZNGO1EI48eJh2EHXpA3PmyJFZwv5rcbFtNKLo
0z31s29kSRufyapiEkmgAPzV5jLtTFfeDTcWlvHWAMVGWvPMPSJiGmmJZsTORb56
x+GsMkHp1LQmqPa5LOIfEsHSw2EAjBw9ae95HjAK9es=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 232       )
OQqLh4raEKcXcerVFk+7mFGHmdWxBdO3lZ+29BfK8jbu/ohEaTqf+wruw2pMPZMA
WJojWsZh77MXr4/vIQ0USz+T+YKtumybgkfYhU2o/zW9wtIIabpFwzpPg+pFwK47
KvsVTISLGHLtcbzsW5JFfcdIy0Oyz76qX7DyOItoh0yBVWI6iQzflqHfcfLS3PwI
pROChs11BTA/O3s7OYYt85+3GC+vYzo5PbQvJpNFAiK7AOm1SKzxwEV+5hJqFYPc
q6ye9V49h3DuaF/Hdprfr8iawin8JeOKcFQRP9eqgXz5XQQmvq0wgs8rwRbfy7cE
`pragma protect end_protected

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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
mPEE9FgbOBHWM+JggYSd1dM/7mt16Ni6AqgCRrCG5efe+N6TS1QOdzClpDlKj2iZ
279AdPeUEFnCvS9WSi0ME/ozi/1nxrYxA2DIOnw9VbkQrdfh2RYYrBwe14McuPXV
Y2qcI6zM/f4x6JDhcSZO+3DctKZHB4N6Q6z9kaqHbn8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 611       )
VmQI+H15/UG3ez7nq7AFWhYhDtYFC7UPSj+N9CdZYcTGXzJhrv7bu2D+T59BIJ7A
4wd3T+z3co4/YCjS5m0/e/CIjLDpP7L09HVIFjMPzmx4kjCBXe7oV1h81DkQbtwj
XC1X0GlVOb8fEE/DeGggiXtu6SBTjELi9RZBJbEAuUPnJA2dtkvQ91hakMAyjTol
ScCrOQPlYRUAEaTmBKBf7GFKEW7iZxteRw2LGL8pO7RYCFpSMn9do/XggVuUNp88
fh3OZ0Z+kuAtdZ0YY7g5TvvFz7N56EQOj8lGZD4nLX/hh29XqpCJey2Jo31/+kac
shBJG0qkzeu+BWGXOUPDsQN84Y8qhiboJB/eB51pnNqGmu0RgMfbUHuFgNkhTYUa
BE3uV09Kxm0DF4hPtRi7hHmPlDSW2GYopjEuGXR5q2MFB69WHPGZlo8wX6AoAJ60
Ti0f4i9Sq+7mSLW9TO6A63VEEpPF4RVMpM9DCP9kypfzUj7XS0L586vZJ+4HrG/g
`pragma protect end_protected

endclass: svt_debug_opts

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
OtYJxp2X7w5G7T6S2tlfJJvjPGIsOILL9NZFplLFgkPi9aDxCvdD9abWeX63qCsC
cC4mjXXuYzIJqWCgZEmZeO7oxniDJcMm/pEfNkxDhi3AIAvfE709waHLQwV6Qk8B
hnyfZRrB2LCo5EmOoxG8cUSA1n984+W+cusRvlT/Z9U=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 29367     )
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
LUq3EMGOB58K135n6ocvzg==
`pragma protect end_protected

`endif // GUARD_SVT_DEBUG_OPTS_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
as6C8dZH17jo0TZt3B29SHV1W0PvIkQdQ5JbvOeMhadYoPJoSW/+VnTvBqSA+hAT
KWf3k4Mml+mOV3O5zY54PdSUGWRA8KkxrpIHDt5HAfJ3omgSGf6LKhALYb5m9Zj8
HkFuepXmvfr/ALUCpBM2p4VHX+QDxLR2oLBzNEbbEPY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 29450     )
fdNBYfe0bNgy+utWOQrybALOBjs8v8iVyluutriYXG+pI/Nd5msaLeGwqkPVpYAK
3Rj3gkpg+NVkKAr3iWJAI2v1rfTTESI1llzKIoXJsX538p6Bp2jIvmMswL8KTcbC
`pragma protect end_protected
