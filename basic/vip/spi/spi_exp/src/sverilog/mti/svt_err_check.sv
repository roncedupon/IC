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

`ifndef GUARD_SVT_ERR_CHECK_SV
`define GUARD_SVT_ERR_CHECK_SV

`ifndef SVT_VMM_TECHNOLOGY
//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Yu7sP3/HZTYoPaV5lE71sUL2nb2Aiy7Vj2neFWy3YIiDzkgTZdSCkYDyw1V2r/Py
ArMY3ENgM+Ct2JbYiplVviiILPYRz3ImjX/FFPJzAlUa4AATuaIAOafCPlvlUBzg
NWpORYqZ+kZSRDiOCkNGcI0zSq85PitHIPCxx2+AfQs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 168       )
edaN6ku0URcYPR/dI/F+ULsYx+cja8YIMY4+r/9QKcY7fRpg5B0g0vIi1IfxidXY
8MOcSpR3lUtggtOl+yYKudFdHrNxwFX+0Cb6VwYymh+c/rmDOoDHhKF9gshd8/T2
X96x9oDqVsHO69b10HDKB5UMANmM6GZ+LaZnCEbh6b/f+rrJ50McdIfvBhqQetI3
r+O9vl8E7kZDx3/BaHaRCue1WM5FfPP4PAmN+xRTnwg=
`pragma protect end_protected
typedef class svt_non_abstract_report_object;
`endif

/** Macro that can be used to execute a check, but allows for the deferral of the formatting of 'failmsg' */
`ifdef __SVDOC__
// SVDOC seems to have an issue with the using a non-numeric optional argument. The enum and the corresponding constant
// (i.e., SVT_ERROR_FAIL_EFFECT) both result in a failure. So just use value associated with SVT_ERROR_FAIL_EFFECT.
`define SVT_ERR_CHECK_EXECUTE(errchk,chkstats,testpass,failmsg,faileffect=5) \
  if (testpass) errchk.pass(chkstats); \
  else errchk.fail(chkstats,failmsg,faileffect);
`else
`define SVT_ERR_CHECK_EXECUTE(errchk,chkstats,testpass,failmsg,faileffect=svt_err_check_stats::ERROR) \
  if (testpass) errchk.pass(chkstats); \
  else errchk.fail(chkstats,failmsg,faileffect);
`endif

`define SVT_ERR_CHECK_EXECUTE_STATS(errchk,chkstats,testpass,failmsg="") \
  `SVT_ERR_CHECK_EXECUTE(errchk,chkstats,testpass,failmsg,svt_err_check_stats::DEFAULT)

// =============================================================================
/**
 * Error Check Class - Tracks error checks performed
 * by a transactor. An object of this class is instantiated in the <b>svt_xactor</b>
 * class (the <b>m_o_err_chk</b> member of that class). Error checks performed by the
 * transactor are registered to this class, and statistic collection objects for them
 * are stored in the <b>checks[$]</b> queue of this class.
 */
class svt_err_check extends `SVT_DATA_TYPE;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * Indicates whether this svt_err_check instance is dynamic, and should therefore
   * be destroyed and reconstructed when the associated transactor is restarted.
   */
  bit dynamic_checks = 0;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** Queue that stores statistics for registered checks.  */
  protected svt_err_check_stats checks[$];

  /**
   * Queue that stores the registered error checking instances, used to
   * build a hierarchy of svt_err_check instances.
   */
  protected svt_err_check registered_err_check[$];

  /** A string that identifies this class. */
  protected string err_check_name;
  
`ifndef SVT_VMM_TECHNOLOGY
  /**
   * SVT message macros route messages through this reference. This overrides the shared
   * svt_sequence_item_base reporter.
   */
  protected `SVT_XVM(report_object) reporter;

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
XQmlYL+hNehsm6H6L4knxGJCoYleSTy/nCrmg4bScx2hdH+FHRdWHGFIW3JUzr2V
bQOb6skYEozqBpAUYEBTdE2Z6VQz6eHqdkcjCpaYk/ozvrplS7XXaHY+qjY5lj/p
kW7RE8kQzM9R33jKR0a8yxYNNw8lD+0vb0OVSY9DbKA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 404       )
K56DO3bgz4fv02OQLfEDckhHhw56vEqcbfTuYhikgi2Izbsq710za9Vj/C4/muAc
r143C2PkmeoRLWAkDOIFqNAwllJeLcmGNIH/r76fTL0luKbZm/9JPMTgAatDs9Jb
kVj2eW3ODbtZxYw3Q3AVVNkwkoxbpz7o73Hk4LX2HMpjYQS9Ra99AKSN4JmH+A/o
Q1KHauoLE5by4RnvYK+eRxEjPgWdx+UeD8OuajDeRNc+P3+TpVR26bezLBh4+SKY
JhiksWl4niSBs4H0iMwcvaW5w0J0wcbLhLMwel2bBtiedbYeU7m5BCc94eKBOnyA
`pragma protect end_protected
`endif

  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************

  /** Automatic filter activation count to be applied to all checks. */
  local int filter_all_after_count = 0;
  
  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_err_check)
  /**
   * CONSTRUCTOR: Create a new svt_err_check instance.
   *
   * @param suite_name Passed in to identify the model suite for licensing.
   *
   * @param err_check_name A string that identifies this particular
   *                       svt_err_check instance.
   * 
   * @param log Optional log object for routing messages.
   */
  extern function new(string suite_name = "", string err_check_name = "", vmm_log log = null);
`else
  /**
   * CONSTRUCTOR: Create a new svt_err_check instance.
   *
   * @param suite_name Passed in to identify the model suite for licensing.
   *
   * @param err_check_name A string that identifies this particular
   *                       svt_err_check instance.
   * 
   * @param reporter Optional reporter object for routing messages.
   */
  extern function new(string suite_name = "", string err_check_name = "", `SVT_XVM(report_object) reporter = null);
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_err_check)
  `svt_data_member_end(svt_err_check)

  // ---------------------------------------------------------------------------
  /**
   * Creates a new <i>registered</i> check.
   * After this method is called, the unique check description is stored for future reference.
   * Calling this method multiple times with the same <b>description</b> argument has no
   * further effect (i.e. the existing registration stays intact, and a new one is not created).
   *
   * @param description Describes (briefly) a unique check performed by a transactor.
   * @param reference (Optional) Text to reference protocol spec requirement associated with the check.
   * @param default_fail_effect (Optional: Default = ERROR) Sets the default handling of a failed check.
   * @param filter_after_count (Optional) Sets the number of fails before automatic filtering is applied.
   * @return A handle to the check constructed to implement the check indicated by the description.
   */
  extern virtual function svt_err_check_stats register(string description,
                            input string reference = "",
                            svt_err_check_stats::fail_effect_enum default_fail_effect = svt_err_check_stats::ERROR,
                            int filter_after_count = 0 );

  // ---------------------------------------------------------------------------
  /**
   * Registers an svt_err_check_stats instance with this class.
   *
   * @param new_err_check_stats The svt_err_check_stats to register.
   */
  extern virtual function void register_err_check_stats(svt_err_check_stats new_err_check_stats);

  // ---------------------------------------------------------------------------
  /**
   * DEPRECATED -- USE 'register_err_check_stats'
   */
  extern virtual function void register_check( svt_err_check_stats check_stats );

  // ---------------------------------------------------------------------------
  /**
   * Unregisters an svt_err_check_stats instance previously registered with this class.
   *
   * @param err_check_stats The svt_err_check_stats to unregister.
   * @param silent Indicates whether an error should be generated if the check cannot be found.
   */
  extern virtual function void unregister_err_check_stats(svt_err_check_stats err_check_stats, bit silent = 1 );

  // ---------------------------------------------------------------------------
  /**
   * DEPRECATED -- USE 'unregister_err_check_stats'
   */
  extern virtual function void unregister_check( svt_err_check_stats check_stats, bit silent = 1 );

  // ---------------------------------------------------------------------------
  /**
   * Registers an svt_err_check instance with this class.
   *
   * @param new_err_check The svt_err_check to register.
   */
  extern function void register_err_check( svt_err_check new_err_check );

  // ---------------------------------------------------------------------------
  /**
   * Clears out the dynamic svt_err_check instances registered with this class.
   */
  extern function void clear_dynamic_err_checks();

  // ---------------------------------------------------------------------------
  /**
   * This method is called to enable a check. This allows the svt_err_check
   * class to start any threads needed to perform this check.
   *
   * This method must be implemented by the derived svt_err_check class.
   *
   * @param check_stats The registered check to enable.
   */
  extern virtual function void enable_check(svt_err_check_stats check_stats);
  
  // ---------------------------------------------------------------------------
  /**
   * Enables checks that match specified group and sub-group criteria.  Checks
   * that are already enabled will not be effected and will not be included in
   * the count that is returned.
   *
   * @param enable_group      Regular expression string used to search for groups associated
   *                          with the checks to enable. The empty string can be used
   *                          to do a wildcard match against all group values.
   *
   * @param enable_sub_group  Regular expression string used to search for sub-groups associated
   *                          with the checks to enable. The empty string can be used to
   *                          do a wildcard match against all sub-group values.
   * 
   * @param enable_unique_id  Regular expression string used to search for the unique_id associated
   *                          with the checks to find.  The empty string can be used
   *                          to do a wildcard match against all unique_id values.
   *
   * @return                  The number of checks that were enabled.
   */
  extern virtual function int enable_checks(string enable_group = "",
                                            string enable_sub_group = "",
                                            string enable_unique_id = "" );
  
  // ---------------------------------------------------------------------------
  /**
   * This method is called to disable a check. This allows the svt_err_check
   * class to stop check-related threads that are currently running.
   *
   * This method must be implemented by the derived svt_err_check class.
   *
   * @param check_stats The registered check to disable.
   */
  extern virtual function void disable_check(svt_err_check_stats check_stats);
  
  // ---------------------------------------------------------------------------
  /**
   * Disables checks that match specified group and sub-group criteria.  Checks
   * that are already disabled will not be effected and will not be included in
   * the count that is returned.
   *
   * @param disable_group     Regular expression string used to search for groups associated
   *                          with the checks to disable. The empty string can be used
   *                          to do a wildcard match against all group values.
   *
   * @param disable_sub_group Regular expression string used to search for sub-groups associated
   *                          with the checks to disable. The empty string can be used to
   *                          do a wildcard match against all sub-group values.
   *
   * @param disable_unique_id Regular expression string used to search for the unique_id associated
   *                          with the checks to find.  The empty string can be used
   *                          to do a wildcard match against all unique_id values.
   *
   * @return                  The number of checks that were disabled.
   */
  extern virtual function int disable_checks(string disable_group = "",
                                             string disable_sub_group = "",
                                             string disable_unique_id = "" );

  // ---------------------------------------------------------------------------
  /**
   * Modifies the default handling in the event of 'pass' of checks that match
   * specified group and sub-group criteria. Checks that already have the indicated
   * default handling will not be effected and will not be included in the count that
   * is returned.
   *
   * @param pass_effect_group
   *                          Regular expression string used to search for groups associated
   *                          with the checks to modify. The empty string can be used
   *                          to do a wildcard match against all group values.
   *
   * @param pass_effect_sub_group
   *                          Regular expression string used to search for sub-groups associated
   *                          with the checks to modify. The empty string can be used to
   *                          do a wildcard match against all sub-group values.
   * 
   * @param new_default_pass_effect The new pass effect.
   *
   * @param pass_effect_unique_id
   *                          Regular expression string used to search for the unique_id associated
   *                          with the checks to find.  The empty string can be used
   *                          to do a wildcard match against all unique_id values.
   *
   * @return                  The number of checks that were modified.
   */
  extern virtual function int set_default_pass_effects(string pass_effect_group = "",
                                                       string pass_effect_sub_group = "",
                                                       svt_err_check_stats::fail_effect_enum new_default_pass_effect,
                                                       string pass_effect_unique_id = "" );


  // ---------------------------------------------------------------------------
  /**
   * Modifies the default handling in the event of 'fail' of checks that match
   * specified group and sub-group criteria. Checks that already have the indicated
   * default handling will not be effected and will not be included in the count that
   * is returned.
   *
   * @param fail_effect_group
   *                          Regular expression string used to search for groups associated
   *                          with the checks to modify. The empty string can be used
   *                          to do a wildcard match against all group values.
   *
   * @param fail_effect_sub_group
   *                          Regular expression string used to search for sub-groups associated
   *                          with the checks to modify. The empty string can be used to
   *                          do a wildcard match against all sub-group values.
   * 
   * @param new_default_fail_effect The new fail effect.
   *
   * @param fail_effect_unique_id
   *                          Regular expression string used to search for the unique_id associated
   *                          with the checks to find.  The empty string can be used
   *                          to do a wildcard match against all unique_id values.
   *
   * @return                  The number of checks that were modified.
   */
  extern virtual function int set_default_fail_effects(string fail_effect_group = "",
                                                       string fail_effect_sub_group = "",
                                                       svt_err_check_stats::fail_effect_enum new_default_fail_effect,
                                                       string fail_effect_unique_id = "" );

  // ---------------------------------------------------------------------------
  /**
   * Add covergroups for all registered checks that match the specified group and
   * sub-group criteria utilizing the provided pass/fail settings.
   *
   * @param enable_cov_group      Regular expression used to search for groups associated
   *                              with the checks to cover.  The empty string can be used
   *                              to do a wildcard match against all group values.
   *
   * @param enable_cov_sub_group  Regular expression used to search for sub-groups associated
   *                              with the checks to cover.  The empty string can be used to
   *                              do a wildcard match against all sub-group values.
   *
   * @param enable_pass_cov       Enables the "pass" bins on all of the the check coverage
   *                              instances.
   *
   * @param enable_fail_cov       Enables the "fail" bins on all of the the check coverage
   *                              instances.
   *
   * @return                      The number of checks that were enabled for coverage.
   */
  extern virtual function int enable_checks_cov( string enable_cov_group = "",
                                                 string enable_cov_sub_group = "",
                                                 bit enable_pass_cov = 0,
                                                 bit enable_fail_cov = 1);

  // ---------------------------------------------------------------------------
  /**
   * Deletes the coverage for the checks that match specified group and sub-group criteria.
   *
   * @param disable_cov_group     Regular expression used to search for groups for coverage
   *                              deletion.  The empty string can be used to do a wildcard
   *                              match against all group values.
   *
   * @param disable_cov_sub_group Regular expression used to search for sub-groups for coverage
   *                              deletion.  The empty string can be used to do a wildcard
   *                              match against all sub-group values.
   *
   * @return                      The number of checks that were disabled for coverage.
   */
  extern virtual function int disable_checks_cov(string disable_cov_group = "",
                                                 string disable_cov_sub_group = "");

  // ---------------------------------------------------------------------------
  /**
   * Enables the "pass" bins of the "status" covergroup associated with the all the registered checks.
   * This method would set the "enable_pass_cov" bit of the coverage class, if coverage is enabled on the 
   * checks identified by the group and sub_group. If coverage is disabled, it would 
   * not set the "enable_pass_cov" bit.
   *  
   * @param set_pass_cov_group      The group associated with the checks for coverage.
   *
   * @param set_pass_cov_sub_group  The sub-group associated with the checks for coverage.
   *                                If no sub-group is specified, all registered checks
   *                                associated with the specified group will have coverage
   *                                bins "pass" added to them.
   *
   * @param enable_pass_cov         Bit indicates, whether the "pass" bins are enabled or disabled.
   *                                Default value is '1' which enables the "pass" bins by default.    
   */
  extern virtual function void set_checks_cov_pass(string set_pass_cov_group, 
                                                   string set_pass_cov_sub_group = "",
                                                   bit enable_pass_cov = 1); 

  // ---------------------------------------------------------------------------
  /**
   * Enables the "fail" bins of the "status" covergroup associated with the all the registered checks.
   * This method would set the "enable_fail_cov" bit of the coverage class, if coverage is enabled on the 
   * checks identified by the group and sub_group. If coverage is disabled, it would 
   * not set the "enable_fail_cov" bit.
   * 
   * @param set_fail_cov_group      The group associated with the checks for coverage.
   *
   * @param set_fail_cov_sub_group  The sub-group associated with the checks for coverage.
   *                                If no sub-group is specified, all registered checks
   *                                associated with the specified group will have coverage
   *                                bins "fail" added to them.
   *
   * @param enable_fail_cov         Bit indicates, whether the "fail" bins are enabled or disabled.
   *                                Default value is '1' which enables the "fail" bins by default.    
   */
  extern virtual function void set_checks_cov_fail(string set_fail_cov_group, 
                                                   string set_fail_cov_sub_group = "",
                                                   bit enable_fail_cov = 1);

  // ---------------------------------------------------------------------------
  /**
   * Returns a registered check, given a unique string which identifies
   * the check.
   *
   * @param unique_id The identifier of the check to retrieve. This is
   * based on how the check was constructed, using the check_id_str or
   * the description as its unique identifier. The check_id_str is given
   * precedence over the description.
   *
   * @return The registered check, or null if the check wasn't found.
   */
  extern virtual function svt_err_check_stats find( string unique_id );
  
  // ---------------------------------------------------------------------------
  /**
   * Looks for the indicated check, returning a bit indicating whether
   * it was found.
   *
   * @param check_stats The check to look for.
   *
   * @return Indication of whether the check was found (1) or not found (0).
   */
  extern virtual function bit find_check( svt_err_check_stats check_stats );
  
  // ---------------------------------------------------------------------------
  /**
   * Finds checks that match specified group, sub-group, and unique_id criteria.
   *
   * @param find_group      Regular expression string used to search for groups associated with
   *                        the checks to find.  The empty string can be used to do
   *                        a wildcard match against all group values.
   *
   * @param find_sub_group  Regular expression string used to search for sub-groups associated
   *                        with the checks to find.  The empty string can be used
   *                        to do a wildcard match against all sub-group values.
   *
   * @param found_checks    A queue that stores the checks that were found as
   *                        a result of the find operation.
   *
   * @param find_unique_id  Regular expression string used to search for the unique_id associated
   *                        with the checks to find.  The empty string can be used
   *                        to do a wildcard match against all unique_id values.
   */
  extern virtual function void find_checks(string find_group = "",
                                           string find_sub_group = "",
                                           ref svt_err_check_stats found_checks[$],
                                           input string find_unique_id = "" );

  // ---------------------------------------------------------------------------
  /**
   * Called by transactor to execute a DUT Error Check with a default severity
   * of ERROR.
   *
   * @param check_stats Handle to the check being executed
   * @param test_pass Represents the outcome of the check (PASS = 1, FAIL = 0).
   * @param fail_msg (Optional) Contains more data about a check that failed.
   * @param fail_effect (Optional: Default=ERROR) Determines how a failure should be counted
   * (as IGNORE, WARNING, ERROR, EXPECTED, or DEFAULT).
   * @param filename Optional argument identifying the source file for the message.
   * @param line Optional argument identifying the source line number for the message. 
   */
  extern function void execute(svt_err_check_stats check_stats,
                               bit test_pass,
                               string fail_msg = "",
                               svt_err_check_stats::fail_effect_enum fail_effect = svt_err_check_stats::ERROR,
                               string filename = "", int line = 0);

  // ---------------------------------------------------------------------------
  /**
   * Called by transactor to execute a DUT Error Check with the configured default
   * severity for the svt_err_check_stats instance.
   *
   * @param check_stats Handle to the check being executed
   * @param test_pass Represents the outcome of the check (PASS = 1, FAIL = 0).
   * @param fail_msg (Optional) Contains more data about a check that failed.
   */
  extern function void execute_stats(svt_err_check_stats check_stats,
                                     bit test_pass,
                                     string fail_msg = "");

  // ---------------------------------------------------------------------------
  /** 
   * Returns a string with the name of the svt_err_check instance. 
   *
   * @return the name of the svt_err_check instance.
   */
  extern function string get_err_check_name();
  
  // ---------------------------------------------------------------------------
  /**
   * Returns a handle to the svt_err_check_stats class object that contains
   * the statistics associated with the given unique_id.
   *
   * @param unique_id The identifier of the svt_err_check_stats instance to
   * retrieve. This is based on how the check was constructed, using the check_id_str
   * or the description as its unique identifier. When doing the match the
   * check_id_str value in the svt_err_check_stats object is given
   * precedence over the description in the object.
   * @param silent Indicates whether a failure to find the svt_err_check_stats instance
   * should result in an error.
   */
  extern function svt_err_check_stats get_err_check_stats(string unique_id, bit silent = 0);

  // ---------------------------------------------------------------------------
  /**
   * DEPRECATED -- USE 'get_err_check_stats'
   */
  extern function svt_err_check_stats get_check_stats(string unique_id);

  // ---------------------------------------------------------------------------
  /**
   * Returns a handle to the svt_err_check class object that has the indicated
   * name value.
   *
   * @param err_check_name The identifier of the check to retrieve.
   * @param silent Indicates whether a failure to find the svt_err_check_stats instance
   * should result in an error.
   */
  extern function svt_err_check get_err_check(string err_check_name, bit silent = 0);

  // ---------------------------------------------------------------------------
  /**
   * Registers a PASSED check with this class.
   * If the verbosity of this class's log object is TRACE or higher,
   * this method produce slog output indicating the name of the check,
   * and the fact that it has PASSED.
   *
   * @param check_stats The check performed by a transactor.
   * @param filename Optional argument identifying the source file for the message.
   * @param line Optional argument identifying the source line number for the message. 
   */
  extern function void pass(svt_err_check_stats check_stats,
                            string filename = "", int line = 0);
  // ---------------------------------------------------------------------------
  /**
   * Registers a FAILED check with this class.
   * As long as the error has not been filtered, this method produces log
   * output with the description of the check, and the fact that it has FAILED,
   * and what the corresponding failure effect is.
   *
   * @param check_stats Check performed by a transactor.
   * @param fail_msg (Optional) Additional output that will be printed along with
   * the basic failure message.
   * @param fail_effect (Optional: Default=ERROR) Determines how a failure should be counted
   * (as IGNORE, WARNING, ERROR, EXPECTED, or DEFAULT).
   * @param filename Optional argument identifying the source file for the message.
   * @param line Optional argument identifying the source line number for the message. 
   */
  extern function void fail(svt_err_check_stats check_stats, string fail_msg = "",
                   svt_err_check_stats::fail_effect_enum fail_effect = svt_err_check_stats::ERROR,
                   string filename = "", int line = 0);
`ifndef SVT_VMM_TECHNOLOGY
  /** Method insures the catcher has been setup. */
  extern function void check_catcher_exists();
  // ---------------------------------------------------------------------------
  /** Method which deletes the catcher if it is no longer needed. */
  extern function void check_catcher_needed();
`endif
  // ---------------------------------------------------------------------------
  /**
   * Filters out a specified error. The argument
   * specifies the error using the same ID with which it is registered.
   *
   * @param check_stats Check performed by a transactor.
   * @return An int handle to the filter rule just created (used to later <i>unfilter</i> the error).
   */
  extern function int filter_error(svt_err_check_stats check_stats);
  // ---------------------------------------------------------------------------
  /**
   * Removes a <i>filter</i> previously set for a specified error.
   * The argument specifies the filter rule handle that was returned when the filter was set.
   *
   * @param filter_id (Optional) An int handle to the filter rule (as returned by <b>filter_error()</b>).
   * If this argument is not supplied, or the default -1 value is specified, <b>all</b> error check failure
   * message filter rules will be removed.
   */
  extern function void unfilter_error(int filter_id = -1);
  // ---------------------------------------------------------------------------
  /**
   * Activates or modifies automatic error message filtering, after
   * a specified number of failures for a given check (or all checks).
   *
   * @param threshold Specifies the allowed number of FAIL messages, before filtering is activated.
   * @param check_stats (Optional) Specifies the check to be filtered (null => all checks).
   */
  extern function void filter_after_n_fails(int threshold, svt_err_check_stats check_stats = null);
  // ---------------------------------------------------------------------------
  /**
   * Reports information about checks.
   *
   * @param checks         The checks to be reported on, or null for all  
   *                       checks that are registered with this class.
   *
   * @param omit_disabled  If this flag is set, checks that are disabled   
   *                       are skipped.
   *
   * @param prefix         The prefix string for all output.
   */
  extern function void report_check_info(svt_err_check_stats checks[$],
                                 bit omit_disabled = 1,
                                 string prefix = "    ");
  
  // ---------------------------------------------------------------------------
  /**
   * Reports the current stats for checks.
   *
   * @param checks            The checks to be reported on, or null for all 
   *                          checks that are registered with this class.
   *
   * @param prefix            The prefix string for all output.
   *
   * @param omit_unexercised  If this flag is set, checks that have not been
   *                          exercised are skipped.
   */
  extern virtual function void report_check_stats(svt_err_check_stats checks[$],
                                  bit omit_unexercised = 1,
                                  string prefix = "    ");
  
  // ---------------------------------------------------------------------------
  /**
   * Reports information about all registered checks.
   *
   * @param prefix  The prefix string for all output.
   *
   * @param include_initial_header If this flag is set and top level report header is included.
   *
   * @param include_intermediate_header If this flag is set an intermediate header for this set of checks is included.
   *
   * @param omit_disabled If this flag is set, checks that are disabled are skipped.
   */
  extern virtual function void report_all_check_info(string prefix = "    ",
                                     bit include_initial_header = 0,
                                     bit include_intermediate_header = 1,
                                     bit omit_disabled = 1);
  
  // ---------------------------------------------------------------------------
  /**
   * Formats the current stats for all registered checks so that they can be reported.
   *
   * @param prefix  The prefix string for all output.
   *
   * @param include_initial_header If this flag is set and top level report header is included.
   *
   * @param include_intermediate_header If this flag is set an intermediate header for this set of checks is included.
   *
   * @param omit_unexercised If this flag is set, checks that have not been
   *                         exercised are skipped.
   */
  extern virtual function string psdisplay_all_check_stats( string prefix, 
                                            bit include_initial_header,
                                            bit include_intermediate_header,
                                            bit omit_unexercised );

  // ---------------------------------------------------------------------------
  /**
   * Reports the current stats for all registered checks.
   *
   * @param prefix  The prefix string for all output.
   *
   * @param include_initial_header If this flag is set and top level report header is included.
   *
   * @param include_intermediate_header If this flag is set an intermediate header for this set of checks is included.
   *
   * @param omit_unexercised If this flag is set, checks that have not been
   *                         exercised are skipped.
   */
  extern virtual function void report_all_check_stats(string prefix = "    ",
                                      bit include_initial_header = 0,
                                      bit include_intermediate_header = 1,
                                      bit omit_unexercised = 1);
  
  // ---------------------------------------------------------------------------
  /**
   * Reports (to transcript) the current stats for all tracked errors.
   *
   * @param prefix  Prefix string for all output.
   */
  extern virtual function void report(string prefix = "    ");

  // ---------------------------------------------------------------------------
  /** Returns a string that provides the basic check msg (check info plus fail_msg, if provided). */
  extern function string get_check_msg(svt_err_check_stats check_stats, string fail_msg = "");

  // ---------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow command
   * code to retrieve the value of a single named property of a data class derived from this
   * class. If the <b>prop_name</b> argument does not match a property of the class, or if the
   * <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1', with the value of the <b>prop_val</b>
   * argument assigned to the value of the specified property. However, If the property is a
   * sub-object, a reference to it is assigned to the <b>data_obj</b> (ref) argument.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val A <i>ref</i> argument used to return the current value of the property,
   * expressed as a 1024 bit quantity. When returning a string value each character
   * requires 8 bits so returned strings must be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @param data_obj If the property is not a sub-object, this argument is assigned to
   * <i>null</i>. If the property is a sub-object, a reference to it is assigned to
   * this (ref) argument. In that case, the <b>prop_val</b> argument is meaningless.
   * The transactor will then store the data object reference in its temporary data object array,
   * and return a handle to its location as the <b>prop_val</b> argument of the <b>get_data_prop</b>
   * task of the component. The command testbench code must then use <i>that</i>
   * handle to access the properties of the sub-object.
   * @return A single bit representing whether or not a valid property was retrieved.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow
   * command code to set the value of a single named property of a data class derived from
   * this class. This method cannot be used to set the value of a sub-object, since sub-object
   * consruction is taken care of automatically by the command interface. If the <b>prop_name</b>
   * argument does not match a property of the class, or it matches a sub-object of the class,
   * or if the <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1'.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val The value to assign to the property, expressed as a 1024 bit quantity.
   * When assigning a string value each character requires 8 bits so assigned strings must
   * be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @return A single bit representing whether or not a valid property was set.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Basic report objects aren't included in the component hierarchy and
   * therefore don't respond well to verbosity modifications. I.e., verbosity
   * modifications travel the component hierarchy, and miss anything which isn't
   * in it. To deal with this we provide an easy mechanism for providing a component
   * report object.
   *
   * @param comp_reporter The new component report object.
   * @param force_override Indicates whether the setting of the reporter should be
   * forced, even if the svt_err_check instance already has a component reporter. 
   * 
   */
  extern virtual function void set_component_reporter(`SVT_XVM(component) comp_reporter, bit force_override = 0);
`endif

  // ---------------------------------------------------------------------------
endclass

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JuYCdSDG1EZ1GKRdzwb3L0csVKMZNAb3iSSO9ZtMbeQVVtvFc0yQswyT6L72ZTtN
d0l2F64+wwS1l+ki/lCErWBOuzfzQKjUCrkVlLXgAkswcEFasSGA4vvl1CemVcsz
J+x3KebZXNChr+40DZSOB0hDCx1v80d/yiYi1MsYxqs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 48893     )
+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
7Mv0uE3d/DMIFejNUBBT0g==
`pragma protect end_protected

`endif // GUARD_SVT_ERR_CHECK_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
baFtcVOIKWM7MNtLE2URBrWvRTzj2BUMDLyJkcE33lEeiEceBpL3q/HOBEnte7hK
u9eJsON2GfkOO2QaYQ/83qsbsPJhs9szJD3uw3WGDWzMyOy9pm2IgyZjtHTfLFmw
Dg0kY2S/K6fnsDu3GiWPin/lM6cAVS3QTortEREufLw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 48976     )
PWnaFUXOmbAXUc4N0xz8V4yPUBIUn9JUpJ43EygaBAIPhxd5/3nYt9Q2PNPqaiAT
msgs7OcSjPpV/MXQ/rDo32T7YXkLTrYeMEP/vi7b5vdUtIL/TdGn8F4vXlMteK3v
`pragma protect end_protected
