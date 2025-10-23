//=======================================================================
// COPYRIGHT (C) 2012-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_ERR_CHECK_STATS_COV_SV
`define GUARD_SVT_ERR_CHECK_STATS_COV_SV

/**
 * This macro declares a class by the name <suiteprefix>_err_check_stats_cov_<statsname>.
 * 'suiteprefix' should be the suite prefix (e.g., 'svt_pcie') or a more specific component
 * prefix (e.g., 'svt_pcie_tl'). 'statsname' should to the check_id_str value assigned to
 * the stats instance by the developer.
 *
 * The resulting class is extended from the svt_err_check_stats_cov.sv class.
 *
 * This class includes its own base class covergroup definition, as well as "allocate",
 * "copy", "sample_status", and "set_unique_id" methods, which pertain to the "status" covergroup.
 *
 * It relies on an additional "override" strategy which involves a call to
 * svt_err_check_stats::register_cov_override. This call establishes an object wrapper for the 
 * svt_err_check_stats_cov class extension so that it can be used to create the new class type
 * coverage is added to the svt_err_check_stats instance.
 * 
 * Usage of the "override" method:
 *
 * 1. User creates the svt_err_check_stats class instance. 
 * 2. Calls the "register_check" method for the check.
 * 3. Call the svt_err_check_stats::register_cov_override method with an object wrapper for the svt_err_check_stats_cov class
 *    instance which provides the overide.
 *
 * Note that the override should normally be done by using the SVT_ERR_CHECK_STATS_COV_PREFIX_EXTENDED_CLASS_OVERRIDE
 * macro. 
 */
`define SVT_ERR_CHECK_STATS_COV_PREFIX_EXTENDED_CLASS_DECL(suiteprefix,statsname) \
    /** Class declaration of error check stats coverage instance for the protocol check statsname */ \
    class suiteprefix``_err_check_stats_cov_``statsname extends svt_err_check_stats_cov; \
`ifdef SVT_VMM_TECHNOLOGY \
`ifndef SVT_PRE_VMM_12 \
    `vmm_typename(suiteprefix``_err_check_stats_cov_``statsname) \
`endif \
`endif \
  \
`ifndef SVT_ERR_CHECK_STATS_COV_EXCLUDE_STATUS_CG \
    covergroup status; \
      option.per_instance = 1; \
      option.goal = 100; \
      pass : coverpoint status_bit iff (enable_pass_cov) { \
        bins pass = {1}; \
`ifdef SVT_MULTI_SIM_IGNORE_BINS \
`ifndef SVT_ERR_CHECK_STATS_COV_DISABLE_IGNORE_BINS \
        ignore_bins pass_i = {(enable_pass_cov == 1'b0) ? 1'b1 : 1'b0}; \
`endif \
`else \
        ignore_bins pass_i = {1} iff (!enable_pass_cov); \
`endif \
      } \
      fail : coverpoint !status_bit iff (enable_fail_cov) { \
        bins fail = {1}; \
`ifdef SVT_MULTI_SIM_IGNORE_BINS \
`ifndef SVT_ERR_CHECK_STATS_COV_DISABLE_IGNORE_BINS \
        ignore_bins fail_i = {(enable_fail_cov == 1'b0) ? 1'b1 : 1'b0}; \
`endif \
`else \
        ignore_bins fail_i = {1} iff (!enable_fail_cov); \
`endif \
      } \
    endgroup \
`endif \
  \
    extern function new(string name = ""); \
`ifndef SVT_VMM_TECHNOLOGY \
    `svt_xvm_object_utils(suiteprefix``_err_check_stats_cov_``statsname) \
`endif \
  \
`ifdef SVT_VMM_TECHNOLOGY \
`ifndef SVT_PRE_VMM_12 \
    extern virtual function suiteprefix``_err_check_stats_cov_``statsname allocate(); \
  \
    extern virtual function suiteprefix``_err_check_stats_cov_``statsname copy(); \
`endif \
`endif \
  \
    extern virtual function void sample_status(bit status_bit, string message = ""); \
  \
    extern virtual function void set_unique_id(string unique_id); \
  \
    extern static function void override(string inst_path); \
  \
    extern static function void direct_override(svt_err_check_stats stats); \
`ifdef SVT_VMM_TECHNOLOGY \
`ifndef SVT_PRE_VMM_12 \
    `vmm_class_factory(suiteprefix``_err_check_stats_cov_``statsname) \
`endif \
`endif \
  endclass \
  \
  function suiteprefix``_err_check_stats_cov_``statsname::new(string name = ""); \
    super.new(name, 0); \
    /* If client has disabled pass/fail coverage, then don't create the covergroup */ \
    if ((svt_err_check_stats_cov::initial_enable_pass_cov != 0) || (svt_err_check_stats_cov::initial_enable_fail_cov != 0)) begin \
`ifndef SVT_ERR_CHECK_STATS_COV_EXCLUDE_STATUS_CG \
      status = new(); \
`ifdef SVT_ERR_CHECK_STATS_COV_DISABLE_IGNORE_BINS \
      /* NOTE: Some older versions of Incisive (i.e., prior to 12.10.005) require the goal to */ \
      /*       be a constant if it is set in the covergroup definition. So set it here instead. */ \
      status.option.goal = 50*(enable_pass_cov+enable_fail_cov); \
`endif \
`endif \
`ifndef SVT_MULTI_SIM_COVERAGE_IFF_SHAPING \
      shape_cov(); \
`endif \
    end \
  \
  endfunction \
  \
`ifdef SVT_VMM_TECHNOLOGY \
`ifndef SVT_PRE_VMM_12 \
  function suiteprefix``_err_check_stats_cov_``statsname suiteprefix``_err_check_stats_cov_``statsname::allocate(); \
    allocate = new(this.get_object_name()); \
  endfunction \
  \
  function suiteprefix``_err_check_stats_cov_``statsname suiteprefix``_err_check_stats_cov_``statsname::copy(); \
    copy = new(this.get_object_name()); \
    copy.set_enable_pass_cov(this.enable_pass_cov); \
    copy.set_enable_fail_cov(this.enable_fail_cov); \
  endfunction \
  \
`endif \
`endif \
  \
  function void suiteprefix``_err_check_stats_cov_``statsname::sample_status(bit status_bit, string message = ""); \
    this.status_bit = status_bit; \
`ifndef SVT_ERR_CHECK_STATS_COV_EXCLUDE_STATUS_CG \
    status.sample(); \
`endif \
  endfunction \
  \
  function void suiteprefix``_err_check_stats_cov_``statsname::set_unique_id(string unique_id); \
`ifndef SVT_ERR_CHECK_STATS_COV_EXCLUDE_STATUS_CG \
    /* Make sure the unique_id doesn't have any spaces in it -- otherwise get warnings */ \
    `SVT_DATA_UTIL_REPLACE_PATTERN(unique_id," ", "_"); \
    status.set_inst_name({unique_id,"_status"}); \
`endif \
  endfunction \
  \
  function void suiteprefix``_err_check_stats_cov_``statsname::override(string inst_path); \
`ifdef SVT_VMM_TECHNOLOGY \
`ifndef SVT_PRE_VMM_12 \
    /* Set initial pass/fail cov values to 0, since VMM is going to create a dummy instance and we don't want a dummy covergroup */ \
    svt_err_check_stats_cov::initial_enable_pass_cov = 0; \
    svt_err_check_stats_cov::initial_enable_fail_cov = 0; \
    svt_err_check_stats_cov::override_with_new(inst_path, suiteprefix``_err_check_stats_cov_``statsname::this_type(),shared_log); \
    svt_err_check_stats_cov::override_with_copy(inst_path, suiteprefix``_err_check_stats_cov_``statsname::this_type(),shared_log); \
    /* Restore the initial pass/fail cov values to their favored defaults */ \
    svt_err_check_stats_cov::initial_enable_pass_cov = 0; \
    svt_err_check_stats_cov::initial_enable_fail_cov = 1; \
`endif \
`else \
    svt_err_check_stats_cov::type_id::set_inst_override(suiteprefix``_err_check_stats_cov_``statsname::get_type(),inst_path); \
`endif \
  endfunction \
  \
  function void suiteprefix``_err_check_stats_cov_``statsname::direct_override(svt_err_check_stats stats); \
`ifdef SVT_VMM_TECHNOLOGY \
`ifndef SVT_PRE_VMM_12 \
    suiteprefix``_err_check_stats_cov_``statsname factory = null; \
    /* Set initial pass/fail cov values to 0, since VMM is going to create a dummy instance and we don't want a dummy covergroup */ \
    svt_err_check_stats_cov::initial_enable_pass_cov = 0; \
    svt_err_check_stats_cov::initial_enable_fail_cov = 0; \
    factory = new(); \
    stats.register_cov_override(factory); \
    /* Restore the initial pass/fail cov values to their favored defaults */ \
    svt_err_check_stats_cov::initial_enable_pass_cov = 0; \
    svt_err_check_stats_cov::initial_enable_fail_cov = 1; \
`endif \
`else \
    stats.register_cov_override(suiteprefix``_err_check_stats_cov_``statsname::get_type()); \
`endif \
  endfunction

/**
 * This macro is provided for backwards compatibility. Clients should now use the
 * SVT_ERR_CHECK_STATS_COV_PREFIX_EXTENDED_CLASS_DECL macro to avoid class name conflicts.
 */
`define SVT_ERR_CHECK_STATS_COV_EXTENDED_CLASS_DECL(statsname) \
  `SVT_ERR_CHECK_STATS_COV_PREFIX_EXTENDED_CLASS_DECL(svt,statsname)

/**
 * Macro that can be used to setup the class override for a specific svt_err_check_stats
 * class instance, identified by statsname, to use the corredponding coverage class defined
 * using the SVT_ERR_CHECK_STATS_COV_PREFIX_EXTENDED_CLASS_DECL macro. Note that this macro
 * relies on the statsname being used for both the 'check_id_str' provided to the original
 * svt_err_check_stats constructor, as well as the name given to the svt_err_check_stats
 * instance in the local scope.
 */
`define SVT_ERR_CHECK_STATS_COV_PREFIX_EXTENDED_CLASS_OVERRIDE(suiteprefix,statsname) \
  suiteprefix``_err_check_stats_cov_``statsname::direct_override(statsname);

/**
 * This macro is provided for backwards compatibility. Clients should now use the
 * SVT_ERR_CHECK_STATS_COV_PREFIX_EXTENDED_CLASS_OVERRIDE macro to avoid class name conflicts.
 */
`define SVT_ERR_CHECK_STATS_COV_EXTENDED_CLASS_OVERRIDE(statsname) \
  `SVT_ERR_CHECK_STATS_COV_PREFIX_EXTENDED_CLASS_OVERRIDE(svt,statsname)

/** @cond SV_ONLY */
// =============================================================================

/**
 * This class defines the covergroup for the svt_err_check_stats instance. 
 */

`ifdef SVT_VMM_TECHNOLOGY
`ifdef SVT_PRE_VMM_12
class svt_err_check_stats_cov;
`else
class svt_err_check_stats_cov extends vmm_object;
`endif
`else
class svt_err_check_stats_cov extends `SVT_XVM(object);
`endif

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Value used to initialize the enable_fail_cov field when the next cov instance is created. */
  static bit initial_enable_fail_cov = 1;

  /** Value used to initialize the enable_pass_cov field when the next cov instance is created. */
  static bit initial_enable_pass_cov = 0;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /** The value being covered */
  protected bit status_bit;

  /** Enables the "fail" bins of the status covergroup */
  protected bit enable_fail_cov = svt_err_check_stats_cov::initial_enable_fail_cov;

  /** Enables the "pass" bins of the status covergroup */
  protected bit enable_pass_cov = svt_err_check_stats_cov::initial_enable_pass_cov;

`ifdef SVT_VMM_TECHNOLOGY
`ifndef SVT_PRE_VMM_12
  /** Shared log for use across all svt_err_check_stats_cov classes. */
  static vmm_log shared_log = new("svt_err_check_stats_cov", "class");
`endif
`endif

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************

`ifdef SVT_MULTI_SIM_COVERGROUP_NULL_CHECK
  /** Indicates whether the status covergroup was created */
  local bit status_created = 0;
`endif

  // ****************************************************************************
  // Coverage Groups
  // ****************************************************************************

  /** 
   * Covergroup which would indicate the pass and fail hits for a particular svt_err_check_stats.
   */
  covergroup status;
    option.per_instance = 1;
    option.goal = 100;
    pass : coverpoint status_bit iff (enable_pass_cov) {
      bins pass = {1};
`ifdef SVT_MULTI_SIM_IGNORE_BINS
`ifndef SVT_ERR_CHECK_STATS_COV_DISABLE_IGNORE_BINS
      ignore_bins pass_i = {(enable_pass_cov == 1'b0) ? 1'b1 : 1'b0};
`endif
`else
      ignore_bins pass_i = {1} iff (!enable_pass_cov);
`endif
    }
    fail : coverpoint !status_bit iff (enable_fail_cov) {
      bins fail = {1};
`ifdef SVT_MULTI_SIM_IGNORE_BINS
`ifndef SVT_ERR_CHECK_STATS_COV_DISABLE_IGNORE_BINS
      ignore_bins fail_i = {(enable_fail_cov == 1'b0) ? 1'b1 : 1'b0};
`endif
`else
      ignore_bins fail_i = {1} iff (!enable_fail_cov);
`endif
    }
  endgroup

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_err_check_stats_cov class.
   *
   * @param name name given to this instance.
   * @param enable_covergroup Qualifier whether to create the covergroup or not.
   */
  extern function new(string name = "", bit enable_covergroup = 1);

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************

`ifndef SVT_VMM_TECHNOLOGY
  `svt_xvm_object_utils(svt_err_check_stats_cov)
`endif

`ifdef SVT_VMM_TECHNOLOGY
`ifndef SVT_PRE_VMM_12
  // ---------------------------------------------------------------------------
  /**
   * Method to allocate a new svt_err_check_stats_cov instance.
   * Needed to support the vmm_object factory subsystem.
   */
  extern virtual function svt_err_check_stats_cov allocate();

  // ---------------------------------------------------------------------------
  /**
   * Method to allocate a new svt_err_check_stats_cov instance.
   * Needed to support the vmm_object factory subsystem.
   */
  extern virtual function svt_err_check_stats_cov copy();
`endif
`endif

  // ---------------------------------------------------------------------------
  /**
   * Method to update the sample value for the covergroup.
   *
   * It sets the "status_bit" field. 
   * It calls the sample method for the "status" covergroup if the "status" covergroup 
   * has been created. 
   *
   * @param status_bit Sampling bit for the covergroup.
   * @param message Optional string which may be used in extended classes to differentiate
   * 'fail' cases. Ignored by the base class implementation.
   */
  extern virtual function void sample_status(bit status_bit, string message = "");  

  // ---------------------------------------------------------------------------
  /**
   * Sets the "enable_pass_cov" bit for the "status" covergroup. 
   *
   * @param enable_pass_cov Bit indicating to enable "pass" bins  
   * 
   */
  extern virtual function void set_enable_pass_cov(bit enable_pass_cov);

  // ---------------------------------------------------------------------------
  /**
   * Sets the "enable_fail_cov" bit for the "status" covergroup. 
   *
   * @param enable_fail_cov Bit indicating to enable "fail" bins  
   * 
   */
  extern virtual function void set_enable_fail_cov(bit enable_fail_cov);

`ifndef SVT_MULTI_SIM_COVERAGE_IFF_SHAPING
  extern virtual function void shape_cov();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Method to set the instance name for any covergroup contained in this class, 
   * based on the unique_id provided as a representation of the associated check. 
   *
   * It sets the instance of the "status" covergroup to {unique_id,"_status"} if the 
   * "status" covergroup has been created.
   *
   * @param unique_id Unique identifier for the covergroup.
   */
  extern virtual function void set_unique_id(string unique_id);  

`ifdef SVT_VMM_TECHNOLOGY 
`ifndef SVT_PRE_VMM_12
  `vmm_class_factory(svt_err_check_stats_cov)
`endif
`endif

endclass

/** @endcond */
//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Mi2e6XwHqXDFpX8UkX0jyDV5r/N2gLQ/mi5m4jcNz1e+bbqdAvkZA72wZ4BQN1zY
JFyRcNCygocXWnU3JtVHQ7BT2mYhkmC/FCr2QGmcdsMB0e+Uevtxq/6BkX711w/P
06u+B7RAwqAgN+Aw+1XgARSrfysdS5nXrSzzBhzqhzU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3359      )
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
`pragma protect end_protected
`endif // GUARD_SVT_ERR_CHECK_STATS_COV_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
cSrEgkKp+t018AWQAi4FLd68txWO5ET21Kxzq74pvlPze/FyuuuTCnLfP2ekCVg9
LrfAcuFQidOyd+Y6HfcFg5jFyWzS3bosM0wM+kfvmGyd99ujPl1QqlRyK36DS+gt
IWVpsCagjx4urOg02jF9Sr8UdkLhJ3bZ+XKVUuEJ9gA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3442      )
bv3LeSrf4v5dNOyAZDw600i+2eH+GVe+XimroDH6Nfek8UDANB2Qr6a59C616N+Y
oZrTDguMDwjvUImLFUWamnVcOKo+ctoIamvLQr7YqGg8R3ZvN3ROOFg39DqI2eJT
`pragma protect end_protected
