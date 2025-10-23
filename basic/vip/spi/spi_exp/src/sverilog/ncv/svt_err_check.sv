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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
WNk1P2g8F9U5u0YGzZ5i7ygocPdWPUm/34abBdRJ6cNbNBnBTjE6q7gIovQd98k/
lhwNU7tla1ciVLghsAESpaNy0AejwdneAgPiduuo3n4MpZNSN9GbladXZIhfRdst
jKxG/xipFG/A23wiSZ+ezZ5cRsIaV3d4mY1y4yD5G3Sn8hnRIMr1Ug==
//pragma protect end_key_block
//pragma protect digest_block
eQNJyfXezPp75ct2LfmIS3z9nI4=
//pragma protect end_digest_block
//pragma protect data_block
HvJ8rb5tC1UKESNGuqM8ye3hHo7en8gh5hZpzc+sFL2Vyjzut2lcQHNxzmG+8Mok
O/GfjlsMXqgaLJgXiUHKxVoRvNl0DmVma+UuczdgKsm+EWEAo/HcvTj8ipmbBUcw
KlD4dX7d2+eb0ifHPYZzBKfG097kzUGqlWG2XVGXSS1LSSml7ryDGnFIE6jeWX1E
TWiC9W+51SSis3Q/5xH8HtRNPnU9fPS7RPPvOwsjZhKNOiwBRA3n4e6l0CnkZfCG
iSingXSYArneDJOnrwzhVdVuTo6gFGoqrtX21SEWr7faUQtVGJWlBM1HLNnjmDZl
7Y2BXE2HXAugbmNowaY3KoJTYf3ZVe3BjC8yTM0QML0ISjXQFeJJFP2UBJX/jND+
9qnB8ZOv/v75OMG/gaZ88tPIw2j0N8u0aez5VCEUYnZmk4g+HXiBFeHwvVDD6PqS

//pragma protect end_data_block
//pragma protect digest_block
wMKlwRwdZt/YeQqipNtZvE+TgHo=
//pragma protect end_digest_block
//pragma protect end_protected
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
AaFc9m3qsJY0+tpviyRkZZuKkSOqeSoMJbBwn8DRL84afa1KhWIRypgYEQzumTz5
jhW2ngiBCbdLdD6/khoh1xw0SQWsyyGxAj5kqLB8Be8i9Bmmeb+zYgoi3DbRjquH
U/JI70PJeiqX2PXpkjmqARlFFJOP+CVP625cbjtBf/fZbA472B/anw==
//pragma protect end_key_block
//pragma protect digest_block
3jA8bSDArQi8WuUZXetB61vdH0I=
//pragma protect end_digest_block
//pragma protect data_block
BODVSx6T57+KEZ3T9PVOfZvCfA/677/HzjDnw98S2MY16xzABgDkKEjt0UqZCDZW
TgUJ34KB0hO8NlXqIollxcrerJPFUb25akH58M2wpUcndW5SBANwcaZCSWEatFAc
RaD7FcxNs99jMdjltYgJZPOEQzaAYBKyueI8W8itKOlg/JciSHoNk0T/kBI4kaRX
6BqS3qjcoklTdQsXAlp0C7Fll1nOM55eHiaKN9Dl9WJu4DF/KgDK/S8DuzY154ee
SMzFd8ouSZ/IhyWqk9a7S13Bq1atpGbqd5rhCkxZrqc5jpfxHZWcWXUxbcjZxoKA
f8ralsRlqtWw1nt9yq7Hj3N+f2YH2iiepKJ5NmS0e72LbJ0fGYJAy837AW3wJolJ
9u3KuzrysjmyWwQCNC0EWgAYS6++CWerUCKl4XIfgAw9wYZqQWHn2ncCkcKFmAXB
QTqjkoD3u0R+2SL9WFdrW0/7tE+FxHUTQzKgf3xmeBEww4sPSeB/644nrden8x9P
Kd+Ws+Z6rHEkxlRH6UYhsaOb38xjzxWPByqE/b4jThs=
//pragma protect end_data_block
//pragma protect digest_block
SB8s+iXo+C7v6ciLwcGqH51S2mY=
//pragma protect end_digest_block
//pragma protect end_protected
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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
sWlvwwVr1Ilog/iCAa1cPzB+JifyI0y5Z4aP7SyHMUOVXwvs+aOcYMxO1zd6RkOu
vnbSehFgtnn/ayu3NWmDoyixcZd4fFvXs2r5v8w4UEPnD6QwtKVxfBi92mhlOlcW
d4tQ2nIiDHNDw4UHpEEg0CD5CQaQjaoWJQeiXtSipvQEFVzCZEbz9Q==
//pragma protect end_key_block
//pragma protect digest_block
b5cOuJUyqe2EfzA1/n3iDwnRnWc=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
09fw0z3TtnQoKlR0dZU/yuuABY4=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_ERR_CHECK_SV

