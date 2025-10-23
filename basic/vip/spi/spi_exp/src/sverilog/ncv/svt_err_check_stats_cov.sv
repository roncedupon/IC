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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
NIqaD2wLkuaDSs0d3RefyqUopXB/m/oC1OLwgL1Bn7AHeC3bN6IAh6l15lnfWHBp
KSwP+Wy8gonBxNvQsjxsgf0dSbCGJbaIPYtmiX+I9g5I4/zFSA1WAIwhTJD5CTGX
5sGp5KkIygMyHjjCD01TQm6IlG3l24jP7/IB+iwiJu4WsSbCJCpkBw==
//pragma protect end_key_block
//pragma protect digest_block
JePK7x7DvPSoeUrgwpYfJ19Tn7g=
//pragma protect end_digest_block
//pragma protect data_block
iu7K5vmSozhAIrZqvW20yLhPtYMsbRsWaJ2xd42zrsAtUGA1jWzl9ESpm4viYYTc
JDovqoR8z6KPER4cd3N7KJ8NsbnvwlO1jmhPHaebqcsNUmD2fqSBTtI3TUhlZ/uo
nz5oHISWzyaJf1Gu9RA6ABsqMkjopSpFBCDX5Q2Jq3x9bFUPsmHFhW6DM60n3EfB
vsTAowE9ziD6T8dh3vteaN9ZrJrk9LtXAKx9NvZEcuGJKq1m/qA/6rlke+mKJEkW
GLKLG45cR/TuDRgNm207tepn8LpDQahFBaxukGnsEEFa59E6WqEKEEcWwQjtZfv8
xW5FK1Ly0dVDeGxoMJsCz/4bvp7RUxE/zTtU8D/1Skqcy2ID6blbiEZQZrfMWQZM
dxTXQoPCRCWgkkNS38oLK5FuBTsBcd8IURnPIAxaDFEgKIwFKoLFQLI5gdG2DPPW
GTTDTMWVpvgX9zmzndcoZaNK1tPLUo/85OBE8xkoigqwNYdIRe0sIt/WaJyt4CZi
5HvZn7/23KtsCVg9WgkEP/g4rKmt/ZR9UVrkqakwh7/zw45fvT1jPU3gIh9htLqL
w0HfYrzifhZURanMKj3ZwcDFr/2MCa4oIuI4soXIwi1ryftodZFrvk7oHjPzCArc
WJWaRok4GhXamTbD+M4F+7i8TFF54TgvpIfdQd02nR6MWe3KR3tiF3cUn84KDMKr
pHNn5Z9lHiM1bIY/YBSbXba7fsnlMXHoxscMIwXTe8w/RVjk/6KT6yHK8VFBxsx8
O/agsdNQNox0ScW+gNPpyJKIEybTTdFUMxB6UWPHD4yI2jKOgrabxOLJaVRFr2Gv
xQV/HhBxkou91LpDSx1j92vqnw28AwenIu8yR21/3Zn8b/lG+cBFykbrBOnj5hQA
mFJe4x3C3tQPQMuxxCzelpX8/n93nl7mK0SzUv6Gaauc5O/MC4lZ+AoOAat9S3zW
Fpo4CfvJ05WJp78U/9wt8A5ZxLFpgi2XCE0fYIN/m3qwhqFW++JpvKOn5fJmkUT3
QlAnAGftH+VpyT5yeWUqykQpBau+HGKRW1UHN9UTpSF3EEKWPA3i4W+vXuUKNt2D
SqDMksExPZ4AtJDitnYEFc9AqnGIWJH2MONbXvdmpGTRzxRsEoBHKhVB/HTKqhg7
7C5jOkWKQ1BMN+6soDLzt0rytd4ryqSNuVFR5ffXsiUVsuLOMFaNcnk86tGJUUpl
b6+U+uH5ypFpPqPzfp/H1F/HZCX6iq6PkUofr4TaKweMFH4yKkQXlFL6zGcdrkEE
Z5e8LdkKgav9Zn1U0iOK6DXr3MyFqQlND+iGUFDDCjuLo3PR+gQxgQQFG7Ayvxh6
tb7qOjNo9Kv+t+U3l/1+wtrGPwMbX31I3HfL4rcLun/6cP30JxGNUSASl+LoZHNy
TzJAmLQXQ2yMr8Cga7qXzG96ELrAo3V/ww7ftNtfwMrCh43QNVmBixcwgXk4OHOH
yoUfjfP6egpCZe7ZxCKkCU0vbGEb+/Cz1dXrmB1/w1ZggX+qIzmQ/TyMdLBQu/0g
F2TD/Gqt2aNtVOx7dEVaXel7RDdDXlWm6gmejDyRXugoiKkyfYWugJqH9X8MMZCG
/3iU8c1endsxqvaPyyeygWJgZ3EVevL42KjZAAwt3QKFyPqVKh5XG8PZp3aZeBvN
wtrPiKy0kT6QkEH/KxpooM4vg/9ykYID0+YpYT7zhF8JoJttApPPI2GrV3r6bNiM
TglSIL59bI8wnydMxnJ8N6+GDa+bgVDb+YaDYPOOYjx3YoiZiLqbt7mYHk9fY+5i
6Oto99xMPqqPBJwv4VRpJrMMN1FeGy6e/MrlRzHBDhc2nF8qk3Vx7zpgv2BUpzRk
7BXX6y/TH1gEOB82KUiHK1IXn/i866R+E3Gckub8/dw+Qz7I2CRp+lu8jYnZZ2Eq
DP0nmFRDA6Q7CGsICByoMNLZS4UzmskiDIdURjgeQzz43/JJfF2iRRqoeF6s+7i8
BZFYw6gvNh1WV2vedbwDis8hOtorgaCDw2fKz06QDORa+j+nJjiWIA1KQ60LtIzm
sj5Y7GBfTQjZJTQBwGjslofuXNXeyE5PmMOqShjHHbUBa6MbE4Zcy8i1hDSUBwoH
4/CfxK7E4pbVpaAccv74ROLhStSK63iYX/a/UOG4I/fxAjpUvmxBBnpgK/DDFv73
RbS3hCfFbjQvPuMCblEXBc2ipf9sGLU634VN4Eiax4MEcE83t8uMu3TiFaq5z4VD
e5CUCHgXsEdXn9oX+JGzzPs3Gu3VR8zwmKAXgBVItQp4TSdvm8wYcbHK/dVWEoRp
Ds/iZazaBFaP93yl8dapRm9+awQNzcgAnXm8UgzmERGdYLTA3qSHcTEO/ZGMuBlD
PgKk1nubUc77ky9iVqoDH3ImUGosJnhzWxCQHNoM4uBrukJDmkEvgX1TitHGtl/S
narqCsHrZkM9iHFd86tyket/R1eOJAF3XlyopLzlpBSgeKyixJHh5UdoJoE9qZNx
Xac4z3hacFlJHUN6ctfPaBEF+jpqf4rExCmFkj2eO2M2hYGkYnB62g7QcT0sRlwg
PfPZBlzDO5nykSFoQEIS7lPlN911Q/9k6p8H4yWQ0zprtso68ArpWLd9QEGmu73X
xw9EJk5zV2xNkH1teUlOn4NFuCNNIoeecg2qgq4fHZpEBEsYFF23x2vk0JI3b6YN
Fo4YU0RCsTt3wUEsb7N3Q6Wo3hk2GCR/rR0y7GujNA5qicUYw7/3/cMw6YOUSe+Y
fKzjaLI5fvvw5TE2gGSdsly+q9/KYkBxw7sAgsm0YqbdeV4wGs8RIpqDPPn4W/I3
7UVwyDGrKkJlKbkaDA0Slkg7VUcx6v4Duq3xqiPNU4D4OV0WQbjY+b5WMkEbp1Um
Rxrv/d5ivzwStC1ExTgNID35g0PZ5ZVxQqkD9g0Fvfao5XSl7bPaYoYZ8vKhhsKy
/O+QC6HSt3XjBNEK2oG9+R6Y94VBRZZSI2yuzUOitOPOxe08eTLciylG6gM01B30
e8C72g37wspBO+XWl2xjTAUbwxxt0r+icN1st1/0iwoG9sNReDVpslIiGbDqLd2X
/WZfXs5BmZVkKppDYQ7g+qfGH1GgodipB3xWwbK/83fFLochlS9hSl5SXxOZ3odE
MEij5IFLV812iWRTEdPfBo7MAF3ufE+nVhfwg8Ra7v+8Yrn8qWedX0VC1BrpgUoD
VEYHtALC2c5K8uh753uXrdX54RIL4s4gxjTNVGjVpjIcFke7O+Gh4NW/uPUyW1e9
cyLBgG8vvj+2vh1Xrk95kEVYu1LBwTTZo4zgjnFS9fGHMINQC09q8m9Jcd8BMMQT
R92pYSz/w38mD2GoZosQq75EMvj49qbNpdLp3G3KwyDhNRVv+UL34tU2L3bUjOh6
Hqws8VGLmRNzESRBJCBMKI+BxNFwkKes8rzBLgI4nIP5zNGoj3KDs6Ls7vMQcret
KMXVcTPVDRgI4GQhnQ5xUFAou00hKn57dJLgEbjbdJ7WlkHnQdWoYYBw1k4TAFmh
6BrjGTUFaeNsyBPpAVwU0NOcW72qTGi44YHRSCfxj3kpbumBJrBcCxdVrKpRjhyH
2MaD6RAsd58S2isru80oXg+xk9OBmkLdK0dwundvIp7TQAeIVgEpJpmWv2oQ0z6R
n7qiRqLOcAAA76IZ1SSzh4c30qcYOZqrl6LiDhyc3JHMpbYGR9SyKll4IkbjDGhF
NXwYFvXBbx+NAUkmB9Px0oZEu8+IHli2zkq7gEK7/wTEKkFVvu6RyQDmShTJsTNe
fp61dQ815oKG+IBcHlZqbiia60ojFdZBscA+B0exQrdrdUWlXYuZ48xXh0+BzwFT
s1Se5G1L/ESMVVMGkLgkR0WRZiMmAg6SahKV3alVlo49O3+ci7lXe9D4PriQC4oa
pk1PyUKDdmNb9Opxm9ByYhuntrgNZeDiW5lf4l40D+colHl/8UkpM210dX+AsP8C
Ens1A4kpPSe0pWm8+MzLGS9ZcxYq7w3KwQxS+qCKhXQVXQEK2gARYOMvLmO6/A6c
enpXGCxkUQPLTaq9UlpNU2jCodJlCGF3XXLEu4oju+8VbR8KEr8YlD33lpAwwK/y
S4T8r9d8oZ9LF8HbUczwMBMjrZmIl95LTMFcxkSNwI5svLX8DJYD3mu0xT/Dxjvj
xvesaM2HTL5Ou+7Sb9WS7l1AnetSbE9835tLtJZIAU9mQ6NfVM92ugh8yRj1/JR9
OTdEvmnlb6YYlkEmflWfsM1TbMpGRN2tQkp5nRMPABJw1uJRslJp/2fvpE67Ouxb
anKn2am7+eS0IXF+ybYdNMFxqUxUOSHeGGTcKWJicfyeIKgI2vk09XblM5nd4/Hn
QGM3Ph8EX0cxg3/raDXDL2OgizXEqCnHFJcB8zqq1dEUIELen4Q3fOjZ1S0nLgDv
uBIj7ozAoWlyfIHWBvShNyURIGNzveqY4Ne2wgTy4mibE5hylffQq4d9UBkrNjFO
bGuHE0Obfzubic8WZ3yTBxK1gwGSF/L32Z0/kQ57Iboz2eJdaoNebJYwrLOwHQ2x
qw6XZH2rcq8GGHcI2nT3d/t8RotDODv+Gl6z8OdnXbdvny7sEjvmNV1r8LZpUMva
52Rte+BGH/qhu2x9pYZm3Vck1h7fENlXfb1T4ppdP47OlHaP/vzH7pFW9kTA67de
qM5W4WNgCz7MEAHnhqs3gfP5kr/hSyEjKW/If12GCk8=
//pragma protect end_data_block
//pragma protect digest_block
OMZZiaHUbIJD4NHIscSOcG9g5Ds=
//pragma protect end_digest_block
//pragma protect end_protected
`endif // GUARD_SVT_ERR_CHECK_STATS_COV_SV
