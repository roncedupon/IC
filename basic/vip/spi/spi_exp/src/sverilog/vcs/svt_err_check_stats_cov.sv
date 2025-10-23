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
`protected
(4FYA\dD7GU(R3WL=PT=7I-G#VF5BFY1INRW3bZLYg9SVE=FZS=^/(T]M:<JfO\O
]173J>a]4QM0/SMYWV5X;20S7V]@DgKX_LaIUbc>)JYdKAgZIMS<4dJ^\J>bd^[J
=N9R?N_/K1(R5>?V5#CIR\M#=1=bdM(M8]JbC0YbcD:W,@NF_?Wg1LD0F;fMbc9V
+GI^0806fe0AQ[?3>,2d>QbHIL1aTV\PCSbaND4(CH+Q5=_QN-]=B]PLQ2E8,WW@
7CLXXJ0W5<1BRC;6YJB3AQeCLF);@P<ge.\^U/7Bfgf)4O]gR(U07_(1-:Q61(UX
+Q_d=007D5Q?^d_I\MA==1VKG/#OL;<(Lg^5O^TS)^WXVR(&O\5^QIbX2UEBS./#
=1D+_P>T4E5e1)=cS_,55GVIT4UQY/>:d,cNP2Cc,+2R30P58b9^8e93+8g7F->+
<UZH3VP&ZV3;NUI(ZgR4H#ARXZb(E5OWIegBSa51;F-WV9&gQ8E)07Gg7YSIfWY;
12b9PC7FL>V^/-\(HO9/AYV/3:(,a+>S]X@b_.^>0WBFWJL[G#?Jb7Qa5Y;D\AAd
(CF@+3B^_DI?Fc^9CG_^P@5?D(#+JQgbC>B>5P@U@EAEWcVEQgb]<dd.)Q/5L4KR
>N3a70RIC-WS7;5P-0d2[;<gU7Z5gWCSK@]D#7=EM5:f4=5RN0\<YY3JAH1YHW(,
X;C-S-.111187<cC^.AaXEE:<3A1+T-)aNIN_bL8=MgELW6HZA>S.^O>I2PCCMe2
b--HCIgNM=Q23?.^NP&D-]JE5KJg06M7C].bFOcIRQ;I<CE)3<_I.#:.4:@MG(_(
N.>[E>&^V\YC39A^2A^/,@@..B:?g3,U1XV4deU-6Ng42@<<edK.bGDFccC7)<T,
H08DfSW[&f;F(?M[F3H3VBCV,FZ/,Y2P/C^A@EB\;cbAZZ];?Z/bPb&Tg[L5HScf
A;8bC[E:9b4+L?__Y7Z[8B;D&+.;PDK,]<@3:bP\Db5E#eX]XeX+S1,daM<ZP_OO
L2_0>5,/BCLV[UITAbKCBEWV>H7E]J@g\V[JQcB;S)+aPDd@7NLFQ>)Z3ZeD/?:-
MJEL2QKYVg\cbD_I4H6:T[+XaR<#0?RDBU>ZYC7C[/8DOJg&;fa)URY@19]gLfbg
+JM8P3WM6Cd_4,=_OP(\TUdFOULLS6/A,b-K,HIbC[Yc7I-R^FW/PC/g0dG9GVJ#
3a5g>M5HRN<M9Y2(Xf^]:eYa&>D2c]C\f8ATd:\eCZ(]c?@cSEPG>=&9M>YJ]I[O
(,XG=,9C6(1NM+^NAG]PIPT=4[b<J&6+RD?>TY;:N0d.0+eQ5QRL?<[?YKe[#g^M
C<INUa3ST&>4bD@H1ZaWbADL>;S<VS9Lc,Y&2/M]g4\,U7MD6OMG_gcBZY&P#1GN
L[QIGf^dA^b^):62X@\/=JbHX8AFb9AVgb8Hb-/3UO/F\AGR]D8:JBbAY\.=P_Z[
B033^/>A<8SaBI;+H_=gAIIcE.;e[KS1&Q1Tf(-Wc64/LXcaV/HB)V-a)-#1/R<<
I+8d?63E941V@INN4Q,PAR3&5YE4^F?d1g?Lec8eX(<J#/+97e@AGI6fW(e\a^Y3
K9SV2YA)WLRPE0P(4W^;>#3SKf^_Q1XSZB<__FR/L#.QD[T.E;FC8=[b-#4DZF?R
A7OMB?:+W^@MP.-^f6V+</I383(,ca>=Z2FdK49QGN04AB,4e.(:AeT#)6#N0Qe)
3d\C\dSB8IHL]X=JN9SA:9U&@-MVP],B4gLGSVE_&dV1d#?(LK+V.HQ^c1FQGVWW
b-L3/f(&BQ8XD)d&>cdBcb86+]ad?G/D&gBVSB&J2U_3OZ^DWKX==L;-LRWTL5C=
Q9^L7a-3V,fJB/9JeO3S4PLUDAV/eX52:H,ZU-U[,@HC:bA1NA^X>^9K/:3UBOP+
eRR,]3T<BOO&GS<1J8C<#FX/L=(MN(W:?3M0L2@[:@e1K^:QCE<UM#gLeP0ZOZ[)
4LB;Z=)I),>O<2N+<5+2V[#CXS>.g]?L6+9G10g;aST,=\.E7LM]1fH+-IY)+ZE?
<B21/#JQ)C=&7]WLe\e,gPgBDE>C-+FQ\+</ME2L6IKb#8&2Z/7RNV6+L^[BXFT&
bIF-2#-@1edD_ScKe8cLcC;O0N8)S2AeO9^.]Ef)<7:KMIA@=[bQ3-GKB)]Gd+fe
)1Q8DO]K^N3Cb:[DQ[C)E_BS]@5JR_H+8T]eB(YBGd_V10Va];738S0b\OO/c7&I
AJ&0?^^?EbG(A2[[]-PPA;geWJK[M888XSPM/MK7N0:U6..BH/HGH0aXDY^Y;cK7
&Ub6=a.:#A9dN<D=XNcL+gX(La&c.WM6^LMNMELSQFGLZDIZ,@3a,TFX)A:G=;U5
c^g5cd-R=AL#VSD&TGEP(gAd&aKU2fSR[Ede<EA8[ZffB=Uf[57,E8U&7</E1B>Y
Q8[O[T+c=7bA20]0<.+^,e3&Y]Q]SJ,c+)Mf##fO;RO3J#Af36[dST<JMYVf9K?Y
O)P/-WG+B+&L)TJMG-_RW/)#@a_((1;KLKL=3e+S#8&be^3S@#\e\^S:1dA7A=,;
a-,Y^8_..6CG\f&d(BfF\:(ITQP.\U9(WJdNU//]W^cbDN7WJ\P8QMc6C.P0=Vc&
b/Y.\@A0:MfW8e^?f2][TTcZ6O5gP#<N2ODFH:MgT(E2D]4(_#e>>HBaH8-:;_\O
.,4\PfZ2@.Q9bQC1UC]J_3\-(D,/:0JSAI3N#AN,&8.+7K1X^/?A9]]?52\M2HbH
)2J#F<\A/KDA1F1JIHa8>EPBSG;^[F3:.>X>Y)DP@U(6[0+9X[2H6gHaEADUMQbE
JD^E3<]Ug#3<Mf4N,dMAL<cQ11G?0[=/>PT85BOJ2\>^Z=<)[G1:Q/P(=[Cd8Y9/
A9bMa6\A(/-8(2P0WWdI7K46&f/.;3?5NA07<U:]MdEd=W)XFN.RaJ_^(6OD>P><
,B@\d_\2V&(W[Ig7Z9+HU?0[5+NR;CaZfOU[,7\9NZY)XR(,>(?\E_b2e+DAOXCB
@8-+K3HC9)234.3KNB=)RZ=fAZ4:Q10774&a.62PGJ(.[UDc?\5XP1<4O(<.:afP
.DDM<()8&CH1Zf_IRa\MEK;(@6;4g0aZ1#gJ;^@&CW\5Q8SN3Y0.6R8X-AQ7d6e\
^WI2##8IaI+V=(PY?#e,6#18Q\:-/-c>e,QQ:Zb91?CID[c>:T>80_gd0X?VV7TI
B:H@=OKD[\F2?G>AbA(,g6JV(G:T=6Q2a/b0JUK(163,V4(-&X]BKT6_MPQ\K/P5
JP=LIHP^PW2?aUL/f:b9a4c3BZ/\377A(2_MCR5ERPJ^\dF:MZ.\#/14P:-LWbdP
4F>>d4GEV+0RgM/gB1BATDO2]bC)#Q#0PYRJ)_5Q2M0fO)/WRBd9D,^^=/DB+SgQ
XX8/-WaWd<V4NfE(T5gL2Q.6Z1,KdKJ?g#LKXf>D,;HA:Ug.>3f<UY:UNYC,c=GO
LLBCQ&/B=/[;V9U6^ZQGe4KaLWb^?C,LDID:dS#/5IHZWHE[X63.:+.VP970Ne;&
1#R9JWf0QbFOcT7:BMKU40IP@gC(UA\Q[FW>,_=RS1f\VH=)aL_@3B_NH+D2H+QH
RVgd(4=I&>Xc+f,12()ZSE#L;-ObVg=QX)cK_00JF=>:Kf.TA+:+Bg#.D=5RLdKZ
&S,=3>>5B#58\XC@;B^]=aO8T7<>LT]XU&C\@a:f737E8XE\#UHbVOd\CIS@>a#b
7c7&MZDdV1JC-O[V:HUBVXO?O<UM4J@d0b<NK?T=<gMd\PS7:50][R&]b?8MG0G)
YC=A_-a-\PdBB01IH^b[WAEAP9V&5A\8Fe<2P3=I?5<@7W<_:7K5,3E63BN<V/8Z
HHP[BTI>S<,:J1;1d\C.=&&W3#=OV,bH)HM3^5Y(__aB<QGMGMN/K8WcO3a4Q#)M
<=@>161/6L01=fV+fE8aG5N5MGQGK(;C3O+I2X&:WDg0M(JE#BEMMcV:d3Da&g1Q
Z@#MSW#<\U-TI87cE(b6N0>G#a33F@0R?+[Q.7</713=ac6gEe.7K(B,X^E79#S9
)E\+dQ_VHbU/\5feDLXIaUHU:O1QTM8GNL3FF;g,#Y)<+2<b;-7-E=&^HV);]cQ6
619,XRG.L_.A0#THc<:#GRbO>BP?M1^U_g@;CdB<GK_F@?aKRGG[U?>O)BgCDEP^
QOOVJX\?Z4:c#Z/FgPgRIAE/7-OXQ/N8O-NaALR8(0\f)+1.OJ2\1I[,-ED^:eTH
52-PSM\Oa(HAY1\[gR-)e-:2W]LE];9GOLL0GR)85bT-SB:/R6FM=#JS\:KEgM5[
@P<C))fTXc:CUAA(694)E(3^fQ^R77YT?A\BM9?]J&gE;8\YJbA.,]?LGg8)>O2?
W=B6@g565I;YT/)YgC:77^SP^P^=2eAgTb/MHY(9U^eT3O((ObdH=&f1W/UVEcIM
8)JZT(CI:=[Q]5L+OL-EGeSP5$
`endprotected

`endif // GUARD_SVT_ERR_CHECK_STATS_COV_SV
