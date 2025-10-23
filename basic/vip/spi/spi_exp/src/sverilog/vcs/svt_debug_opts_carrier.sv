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

`ifndef GUARD_SVT_DEBUG_OPTS_CARRIER_SV
`define GUARD_SVT_DEBUG_OPTS_CARRIER_SV

// SVDOC unable to refer to class scoped structs
`ifndef __SVDOC__
/**
 * This macro needs to be called within the cb_exec method for each
 * callback supported by the VIP to support 'before' callback
 * execution logging.  The macro should be called before the callback
 * methods are executed.
 * 
 * All arguments except for cbname are optional.
 * 
 * cbname -- Name of the callback method
 * fields -- Queue of svt_pattern_data::create_struct elements
 * objtypes -- Queue of object type names which must be presented in the argument order
 * objvals -- Queue of object references which must be presented in the argument order
 * primvals - Queue of primitive values which must be presented in the argument order
 */
`define SVT_DEBUG_OPTS_CARRIER_PRE_CB(cbname,fields='{},objtypes='{},objvals='{},primvals='{}) \
  svt_debug_opts_carrier pdc = null; \
  svt_debug_opts_carrier post_cb_pdc = null; \
  bit debug_enabled_w_user_cb = 0; \
  current_method_triggered_counter[`SVT_DATA_UTIL_ARG_TO_STRING(cbname)] = (current_method_triggered_counter[`SVT_DATA_UTIL_ARG_TO_STRING(cbname)])+1; \
  if (is_debug_enabled() \
`ifdef SVT_DEBUG_OPTS_ENABLE_CALLBACK_PLAYBACK \
    || svt_debug_opts::get_enable_callback_playback() \
`endif \
  ) begin \
    debug_enabled_w_user_cb = has_user_cb(); \
    if (debug_enabled_w_user_cb || svt_debug_opts::has_force_cb_save_to_fsdb_type(`SVT_DATA_UTIL_ARG_TO_STRING(cbname), objtypes) || svt_debug_opts::get_enable_callback_playback()) begin \
`ifdef SVT_VMM_TECHNOLOGY \
      pdc = new(null, get_debug_opts_full_name(), fields, objtypes, objvals, primvals); \
`else \
      pdc = new(`SVT_DATA_UTIL_ARG_TO_STRING(cbname), get_debug_opts_full_name(), fields, objtypes, objvals, primvals); \
      pdc.add_prop("uid_count",current_method_triggered_counter[`SVT_DATA_UTIL_ARG_TO_STRING(cbname)],0, svt_pattern_data::INT); \
`endif \
      if (!svt_debug_opts::get_enable_callback_playback()) begin \
        void'(pdc.update_save_prop_vals_to_fsdb({get_debug_opts_full_name(), ".", `SVT_DATA_UTIL_ARG_TO_STRING(cbname), ".before"})); \
      end \
    end \
  end

/**
 * This macro needs to be called within the cb_exec method for each
 * callback supported by the VIP to support 'after' callback
 * execution logging.  The macro should be called after the callback
 * methods are executed.
 * 
 * All arguments except for cbname are optional.
 * 
 * cbname -- Name of the callback method
 * primprops -- Queue of svt_pattern_data::get_set_struct elements
 * primvals -- Concatenation of every ref argument of the callback
 */
`define SVT_DEBUG_OPTS_CARRIER_POST_CB(cbname,primprops='{},primvals=default_lhs) \
`ifdef SVT_DEBUG_OPTS_ENABLE_CALLBACK_PLAYBACK \
  if (svt_debug_opts::get_enable_callback_playback()) begin \
    if (pdc != null) begin \
      post_cb_pdc = pdc.update_object_prop_vals({get_debug_opts_full_name(), ".", `SVT_DATA_UTIL_ARG_TO_STRING(cbname)}, current_method_triggered_counter[`SVT_DATA_UTIL_ARG_TO_STRING(cbname)]); \
      if (post_cb_pdc != null) begin \
        bit[1023:0] val; \
        if (post_cb_pdc.get_primitive_vals(pdc, primprops, val)) begin \
          bit[1023:0] default_lhs; \
          primvals = val; \
        end \
      end \
    end \
  end \
  else if (debug_enabled_w_user_cb) \
`else \
  if (debug_enabled_w_user_cb) \
`endif \
    void'(pdc.update_save_prop_vals_to_fsdb({get_debug_opts_full_name(), ".", `SVT_DATA_UTIL_ARG_TO_STRING(cbname), ".after"}, ,primprops));

/**
 * This macro can be used by internal cb_exec methods to resolve some design issues
 * that block logging and playback.  This macro can be used to record internal events
 * that the VIP recognizes, but which aren't made available to the testbench through
 * an existing callback.
 * 
 * All arguments except for cbname are optional.
 * 
 * cbname -- Name of the callback method
 * fields -- Queue of svt_pattern_data::create_struct elements
 * objtypes -- Queue of object type names which must be presented in the argument order
 * objvals -- Queue of object references which must be presented in the argument order
 * primvals_pre - Queue of primitive values which must be presented in the argument order
 * primprops -- Queue of svt_pattern_data::get_set_struct elements
 * primvals_post -- Concatenation of every ref argument of the callback
 */
`define SVT_DEBUG_OPTS_CARRIER_INTERNAL_EVENT(cbname,fields='{},objtypes='{},objvals='{},primvals_pre='{},primprops='{},primvals_post=default_lhs) \
 `SVT_DEBUG_OPTS_CARRIER_PRE_CB(cbname,fields,objtypes,objvals,primvals_pre); \
 `SVT_DEBUG_OPTS_CARRIER_POST_CB(cbname,primprops,primvals_post)
`endif

/**
 * This macro needs to be called by all classes that do callback
 * logging in order to support logging. It should be called within
 * the class declaration, so that the method is available
 * to all cb_exec methods which are implemented within the class.
 *
 * T -- The component type that the callbacks are registered with.
 * CB -- The callback type that is registered with the component.
 * compinst -- The component instance which the callbacks will be
 * directed through, and which contains a valid 'is_user_cb' (i.e.,
 * typically inherited from the SVT component classes) implementation.
 */
`define SVT_DEBUG_OPTS_CARRIER_CB_UTIL(T,CB,compinst) \
  int current_method_triggered_counter[string]; \
 \
  function bit has_user_cb(); \
`ifdef SVT_VMM_TECHNOLOGY \
    for (int i = 0; (!has_user_cb && (i < compinst.callbacks.size())); i++) begin \
      svt_xactor_callback svt_cb; \
      if ($cast(svt_cb, compinst.callbacks[i])) \
        has_user_cb = compinst.is_user_cb(svt_cb.get_name()); \
      else \
        /* Its not a SNPS callback, so must be a user callback. */ \
        has_user_cb = 1; \
    end \
`elsif SVT_UVM_TECHNOLOGY \
    uvm_callback_iter#(T, CB) cb_iter = new(compinst); \
    CB cb = cb_iter.first(); \
    has_user_cb = 0; \
    while (!has_user_cb && (cb != null)) begin \
      has_user_cb = compinst.is_user_cb(cb.get_type_name()); \
      cb = cb_iter.next(); \
    end \
`elsif SVT_OVM_TECHNOLOGY \
    ovm_callbacks#(T, CB) cbs = ovm_callbacks #(T,CB)::get_global_cbs(); \
    ovm_queue#(CB) cbq = cbs.get(compinst); \
    has_user_cb = 0; \
    for (int i = 0; !has_user_cb && (cbq != null) && (i < cbq.size()); i++) begin \
      CB cb = cbq.get(i); \
      has_user_cb = compinst.is_user_cb(cb.get_type_name()); \
    end \
`endif \
  endfunction \
 \
  function string get_debug_opts_full_name(); \
    get_debug_opts_full_name = compinst.`SVT_DATA_GET_OBJECT_HIERNAME(); \
  endfunction \
 \
  function bit is_debug_enabled(); \
    is_debug_enabled = compinst.get_is_debug_enabled(); \
  endfunction

/** @cond SV_ONLY */
// =============================================================================
/**
 * The svt_debug_opts_carrier is used to intercept and manage whether the baseline
 * pattern data carrier functionality is actually utilized. 
 */
class svt_debug_opts_carrier extends svt_pattern_data_carrier;

  // ****************************************************************************
  // GeneralTypes
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_data)
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_debug_opts_carrier class.
   *              This should only ever be called if debug_opts have been enabled.
   *              This is enforced by the SVT_DEBUG_OPTS_CARRIER_PRE_CB macro,
   *              so clients are strongly advised to use that macro to create
   *              instances of this object.
   *
   * @param log A vmm_log object reference used to replace the default internal logger.
   * @param host_inst_name Instance name to check against
   * @param field_desc Shorthand description of the fields to be created in the carrier.
   * @param obj_class_type Class type values which must be provided (in order) for all of the object fields
   * provided in the field_desc.
   */
  extern function new(vmm_log log = null, string host_inst_name = "",
                      svt_pattern_data::create_struct field_desc[$] = '{}, string obj_class_type[$] = '{},
                      `SVT_DATA_TYPE prop_obj[$] = '{}, bit [1023:0] prop_val[$] = '{});
`else
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_debug_opts_carrier class.
   *              This should only ever be called if debug_opts have been enabled.
   *              This is enforced by the SVT_DEBUG_OPTS_CARRIER_PRE_CB macro,
   *              so clients are strongly advised to use that macro to create
   *              instances of this object.
   *
   * @param name Instance name for this object
   * @param host_inst_name Instance name to check against
   * @param field_desc Shorthand description of the fields to be created in the carrier.
   * @param prop_obj Object to assign to the OBJECT properties, expressed as `SVT_DATA_TYPE instances.
   * @param prop_val Values to assign to the primitive property, expressed as a 1024 bit quantities.
   */
  extern function new(string name = "svt_debug_opts_carrier_inst", string host_inst_name = "",
                      svt_pattern_data::create_struct field_desc[$] = '{}, string obj_class_type[$] = '{},
                      `SVT_DATA_TYPE prop_obj[$] = '{}, bit [1023:0] prop_val[$] = '{});
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_debug_opts_carrier)
  `svt_data_member_end(svt_debug_opts_carrier)

  // ---------------------------------------------------------------------------
  /** Returns the name of this class, or a class derived from this class. */
  extern virtual function string get_class_name();
  
  // ---------------------------------------------------------------------------
  /**
   * Method to assign multiple values to the corresponding named properties included
   * in the carrier.
   *
   * @param prop_desc Shorthand description of the fields to be modified.
   * @return A single bit representing whether or not the indicated properties were set successfully.
   */
   extern virtual function bit set_multiple_prop_vals(svt_pattern_data::get_set_struct prop_desc[$]);

  // ---------------------------------------------------------------------------
  /**
   * This method modifies the object with the provided updates and then writes
   * the resulting property values associated with the data object to an
   * FSDB file. This implementation is mainly here to intercept the request and
   * pass it along or discard it, depending on whether debug opts are enabled.
   * 
   * @param inst_name The full instance path of the component that is writing the object to FSDB
   * @param parent_object_uid Unique ID of the parent object
   * @param update_desc Shorthand description of the primitive fields to be updated in the carrier.
   *
   * @return Indicates success (1) or failure (0) of the save.
   */
  extern virtual function bit update_save_prop_vals_to_fsdb(string inst_name,
                                                     string parent_object_uid = "",
                                                     svt_pattern_data::get_set_struct update_desc[$] = '{});

  // ****************************************************************************
  // Pattern/Prop Utilities
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Method to add a new name/value pair to the current set of name/value pairs
   * included in the pattern.
   *
   * @param name Name portion of the new name/value pair.
   *
   * @param value Value portion of the new name/value pair.
   *
   * @param array_ix Index associated with the value when the value is in an array.
   *
   * @param typ Type portion of the new name/value pair.
   */
  extern virtual function void add_prop(string name, bit [1023:0] value = 0, int array_ix = 0,
                                        svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

`ifdef SVT_DEBUG_OPTS_ENABLE_CALLBACK_PLAYBACK
  // ---------------------------------------------------------------------------
  /**
   * Used during playback, this method is used to update any object references
   * with the data that is recorded after a callback executes.  The callback is
   * uniquely identified using the full hiearchical path.
   *
   * @param cb_name Full path to the callback that is being played back.
   * @param counter_playback Count of <cb_name><_cb_exec> task triggered in playback
   */
  extern function svt_debug_opts_carrier update_object_prop_vals(string cb_name, int counter_playback);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Used during playback, this method is used to update ref arguments on callbacks.
   * The pattern data carrier object that is recorded prior to callback execution
   * must be supplied because the pattern data carrier object that is obtained
   * post-callback execution are string values, and so the original property type
   * is not available in the post-execution pattern data carrier object.
   * 
   * @param pdc Pattern data carrier object recorded prior to callback execution
   * @param name Property name to be obtained
   * @param size Number of bits needed to encode the return value
   */
  extern function bit[1023:0] get_primitive_val(svt_debug_opts_carrier pdc, string name, output int size);

  /**
   * Returns a queue of prop_val elements 
   */
  extern function bit get_primitive_vals(svt_debug_opts_carrier pdc, svt_pattern_data::get_set_struct prim_props[$] = '{}, output bit[1023:0] prim_vals);

  // ---------------------------------------------------------------------------
endclass
/** @endcond */

// =============================================================================

`protected
EfC.H?[1O5Ub:A2)DUH8OaU:1?(A_:[G..aOdaD;(>R9c,X&VW#<3)<2:6)S:Fa?
](08<eE:1E.WOW4[IN+&_BP(U3@FcO=-FPE@D[?NJA@PWeTNg5]CZcW>)Wee/-M6
N.,=@?WE/[\?f[d?.c#F):N7QOYTUYfM=M6E::+3YCJV6?V4[JT(@=KdL@^62T9e
;VK@Sd^KKOMV_P-]cE>?M#gHI5,AgCJDPK_?EKC@C+<.ZCb<12?<7F-[==CNA9K[
IJ[5Z)a^O=JfSAH_TcM2QCNJK5]F=PJJUC4^4J#&G]/WCRPE;2_L)bd.^KPE1gJ?
:V3F0S6+;[&B6F#52X,ef]/T>\&=XTJ5IF8_a3MAbSO83D.UeY9#HN2:<KbF.?><
Y]GZK0:e-[P=bB3B#(_=<.ILMHL<S_+LH4?Y/2C4->c[AW\7.EBYO)DI>CeMRQ(-
#S41HcbVL8SATEG5(+))UJWV+DQ+:^.N1GB<&KXHAA3#f;4PR0?E&9DZ#?NBG;LT
W,Q8U&,O4[Ibf+a^U,&7Y;7cOK=GbIC4&3^;DfO;aS)0]f675@d1f#e/<YTU[NXA
<dc=/6F?=>QVABe^NWDe#>Z^\8&EP=PCA6>fIPE[]-^UaU_(aC&[;dQC&J4F?#=Y
5Y^<^@ga+,=_O6eU4-)4[]PV85g5L^PZ,V>6eC(4A<WHfCV;3+-V-4gBO?O0a(/W
RI8IM:d^VA6,,-]F6V(F606PA0@H&J[T341<N31;g/N;?M+<e@cE#0;GJ-P<fUK[
YXD2JJ,6[aU4YO+RR-J98NIbA/B,8FN^DQG8(;(L/I2:,]G>]g/7O63N9g(N2V,d
V<:I8L0_1McAMfJT[PTa0bZB>e@G7]bdVHRUT]+Q0UF7KRY(^PRKMQF&L8DSYF8:
+Ka)<I3@.]6#-YQ&NW+Kf<<a^BZ1YMfgY=V33WC8LR/(HY<eAg\9)_M6Ig/,EW6)
_XWDd3><CA@&,14>M4RB9\ORQ2UYR0gEP6JR<GQ6;A?VB<L/S71B_AVbK@OO-N^Y
CdE9+a=F8PaA#[GbG+H[QSK]3bJ/gS8VX>H7[70>)P<:/0Pf3NT./P/)d]0a1_=_
)(WdF36<6#aOcFJ5>M-LaGE)M&0RQ_5RSR,8\YIS^?GN&FVQ(@]#^GW_R^CRF0I&
X-eZe4NAdZ(eV?OXgTVUEMZCeKX5D&T?T5XV]<He@Q]TT1K7bd]CQOgGf>4IL4K8
V9.@5&\+G3\7JE+98W&2gSFcP=c4>B]FD^A@4Db:aY:cF:HB55LKUK#0(@[3gG-H
P(5/dP(M&8Q&^H100feB3AgS8<JH#WgSNEI81Ra>&KGRCT[cd,Y/=+=MH4N9SN:9
/DE5^UCGd(3X@PN63gCIOQ3;@.cOEWUI^+-,Y2A0Ua[/5JV&;PS.8eOJ+&O/+B\.
8Kg0=)\W&+AQaeV?SS9.@Q)W:9WNf@9bK2\R(@YBA,R9f=9^99Ia^dJ2@aE-(RCV
Q5a;HQFEY<N)a+I1Q4+2(e:8RN^9WZgbeSBId>\9)+?g,9e;_V4<Bb_,0B<Z0/MP
[P82W4HOGZ]#S:\^U1ab9YfTF=0NL1OMZ<12_K:N>.UA#HAXRaRRSFGV,_Cb8X[U
Z=^AU5+BU<JF70Cc7XOO60PK>W?0T;d@Q7)aNZ\E[DXUDRCPf2WGUM4\@e>R@]CZ
AOJc[B;CV?)U<_gg1C#7GaT6ba1:Cc5c_286,d74FU5[Qc6eY4,]+^Y>OZF3X==R
D1W?3/J(KV\]3e<CNfZZ0^09b2Q=_WC==3P@W6I53PY:Cb0DQ_P0LeP_Vg&SIUQE
a:/DcB:LgDe0\OdW]9IWGaP)<GLO+W[J1_NfYKb)eENO:Q8Y(<[S4W6\-NC99#?e
R:COMA3>e9\WPS@(AO3dgeVS7C_K_&f6a&\-V+Z9D3LP_\Y)M>_\=E;3gLHW\\F;
bLT6fP_\^F0CQ3>TcL39#Q2cbOX/3<K)R:&X5,PAb6QPML=_OO?0;,.+7_&?-]-+
MWK_?I<SDJ1<(7>a1SaAEH3G8UL1N==4;7GS+GYTgTD&6Q_6@_bK3_X,c-SP+VbT
W-QMH7;AEJRAROYN+O\E(?bXH&L]FNL/YPaWHBR9C3KLE>GY^J2>PPVCTG-V#4]:
0>)Ef&R&b]dD<)Z7[2WQA#ARJURP[3J)-LN^\_\&#52=BDWM3=)C:CVSD;@MBX:T
1QYDE)OE(-N6JG)e@LDd=XQGGf#CG@>@df1);DI[UUG:RfX.LU#I&Pf5.RKMg=cI
;JMf4V]-c_0WHTdK?;ZMX(F;\O#M2E0F)+^M3[=ID?+K+YU9OX@(a[OZR8,EF&IV
?,95Z<A:MRC+W7@#.1[;579d08B9Y>V2:_efB?]=a-3]K<fd^&eg)+(^Eg+Jd,e@
5,c)cG@_>,DZ23&R+E<?e4[]3X&+??3R?-HIR,dZNH1BJbeb(C7L,8OFL@b7:;F6
O>P7&<T[F\O?Mg5QV8I,)S1RF1e^1L?L2c,4FG7AOTZ9(&>IP=;E8C8VbA_dO\Ff
Y0#3.+5[0eV?Q-1@XJRYSQK<Pd&G\>6fW+IACgDRS:3O?K2?3HT,Z]2MEb4JJV,V
FDY&N>YP3[X+W)VMZHG8^DUWR-A6-+O^ZTU1OXTg_.\9.Ba-DQKD6NJFd=EL\+7I
3[OQW9I@M+R<047<#a6.WN_O#bG2,>\fXfd5V>;9M;^WCU6eLfH<BM<C--N4NI:F
/S1PB]:^WVT<G)G+8>-WAKXC+EY-aV_g1\RK=eAAE3B468Ia7/H1[F>JV3bN>#e)
2e0E.G<B/#(A@[LO3YQ:5JP7b-NZOJ:#RQ/d2-:a-\Q8e5C&VEbMTLQ@-HY=FVQ7
L(ONR4:0d]:1M@KQg29VMOB:g+X4(Q7(R6MBBVEgY=&VbS@8g)/_)0b5T?8/,JN?
=fE^/KH696@S,#WPKWY9VI269<YV&T).#K<[=3SMGF[&D(]BW(H-=dD(2DUfV_6^
cYCPFT<-dWg/QW>5[KS(T(;T2A/84B&0M69YSL<9[Fe11Hd1--dO#Gb6O&V[4VN#
^6@79YFU<](c<K>0PFf6cB/&K/#MfdP)dH=<814e5[^M2IP0?]^/\SfSLa\2Z8FB
LadV1HbT6N,AMMJ5NAV/2f6([#?;65-e@Wb?O@>3:W5/B<(;M@+Q?-46JPT>+@CX
Z0IGJ_YdJP;d#J:3#GRNP\,T)7<U^5VWS8?b#eb/A_)VT>A/Y[384I[TW=94[IWD
K]E50EG?#0]<B:BZD8,=TW]a_)AS.=VX::R6=4S.<\dS=]/GU.#[0TCQ,U_XXf>Q
(f-XJS((=3A\+6AbY^a1C:YZQULDILSLSDW&ARPY3?S#:Yb&;E+,NY:cBO&dKbQE
)O5[@d^N4+>BKX1>1SH?.VM[dRV?[<_JM.P4Tg+AdPB4M_^1=e1J4#H(>a?-PbJ&
L>)G[OUWUZffOISC_M7@&a\gF^]YXAb9D,MDT_<+?d?cFRbPWgfdP/__)@CXaAJH
DgZ#[/W1]:>YB\AaQ:dEZ.gN+I8YYR:M@XA(Y5CMLfE.&P_BbJ]M9-fF2J^JA5Mf
]d:@WO]95#\Rf=;c1[E(Y][Vb:aJ)1=WTG@L1AgAN0Sc@2)U+VNQZ#,5cV\&9=]@
KI1G<RAS1b75A0@)9)<X0OGV__05>-OAL82[gJV([=(.5\b#J3Kc@WBg,4OJ=AZ8
C,N>U::YR^Kg+eBTVHC>E+F^+J2EYI//A6>U17D(\Eg?fQU:R+6eFQH/^d>OR9f9
-F_M4OcS1A8GHNK[>=@J&Af^4\N#8Z1ZHG2#FYIQV&###UU.&gO=<d\_dOFNWZNR
.(6:K>=fG0ON>]gU^[We[=[>Vf8,<.1<ff[@))/KaYN+;<(e80M@DC&[;JfI3E\.
Zc5HHUf<LS.5O)=:CbIA_WM[W-UH6dHO(0K6&Y:&gFc=A_?=T)QJ)g0aQ[)E(9Tg
-eG/#aHXSI))d:>b(-Y@S+K.W-Q^=./OC>3/Me(E21ef+./O.)B+.UdbC)M)f.4<
RWH4(6)C-LLWM)0X#2G:_QSU02TaH23H,SU8F^9#G\9eR4YH,<aPGXF[9V1.Z9>#
C-=3^>@[c+0CO_^-0U[&E9+cdDcK)LVFXP2eQ##K+F,Z1&&]ce0RE55PCBN8IH6E
[55BJC=gV1_]Zb[d9d(OXTRDO@IVS\R^Bg7/a/+W5&3:?\:3>PMI4]?(7<\#GPMT
]>RQRd&W:L>VDTgKEg,5fc9SU0VO]G=51K_0^aI;EYN<fSEMRTB<O.gP@J1;fG^>
SB7SOSRb__RbHbDD1A,BIRJ4Qb^FaTa?C,)X[^JVEI+I(2A(R#4,P5TB=c-W>([b
Q.X[K+C@L3\3</<S=^aUTV,F<W-07/dK^:+-75OY92gLUcRFEN<cdXJ(cW4M^+Ba
eV)P4>+FQEbNUF/+3a;Kf5-8F.g122-WOf(?UDAL4MefKb:DD:1-cFDI0;6C@2ED
Jb/c:8>J1#]E>5JR5=f(F4QO-g1c4LMNOD,2W01eJ[<5_=O_aM8=Vd/2:cMeA2)e
TZY^/14\:0d#eU#4T=X>c/S((+5SfPKdY/I,C4_G>SU8bD;U6]C).\2J#@47RXB)
&aa+Oa0,B2GE,][OTaG\+?U_AET&_dQDBFFGPT^^V;S.0&e#OUN(.I2]>N-BXUEV
RV)BN:KY+#a7GdTQWR&.[99>MYB>XW56+U<5ATDP>[Va2[b2C:#\OR1@O6TBY@4>
P&)^J.QO<<aS\6K3;aDe+9_;XKP?f?+K3a>[/U.._/:8,#C,U&/DAF-e?.-b;1eT
\#42)ZO3e@5I9N>AbaB8B+OV)UEg(U2c2:QLBX^V5KKO+_aK9\eaC<FW?,V=.PUQ
X7bbR/1ScB]/.&1OZNb:2#;.DN/2CNWJTXC>E[4bHNfRf:KFZ6FJWP@[2H\FM]]T
_Z8^0)&[TB=\YP&^?<F&&:MDL8Gf_f5-\>?@dC.Z=.X9KP+MNGNJX/_.eMA?(?:5
B-aKc=.W-8)W#aJ3OHKSXX#,-cM1IcW\7<ZW&LGJ#+]1ReQP]PAdDE0)3.I6QNX#
C)3:C)@ZJd-B\^0>V8]OcG;9EWX@CN4+fB^MV\c(Q.g&a#P\;[D@OQ9^I]CQWDO=
RR1,;MU_EJQb^,,L7U2L3<,;[<&H90+0AZ0E1#UJa[PPH2RZ@,851(VN65JI8b/?
<&-]WHa:3LO]4XD83JS8HAW-\26FG7K(eUX+OE\(,+5/G@,-#fI1C)3(T_I#7D1?
4?e-fE7UKf1[V&=0:)-F7;c1PaXS;50#3A/f]^7gVVL0V;.@D1EcPg<D2/^dX/@,
T[RCCab@Y+ac#M3_5]AaQdS43dDPSM3cG8/5]W.@4T&A56HPG^WcG7bE/=O<W9<C
M@_D@d;bd#(_NAH?CYEagbLDafbGR.+b+2H>WaT.f&QR_2\OH&C,@0.2T0@Nde[J
O0NKaAD;0_5/,470(GIdTPZHV(Q28Lf_6:T>K_ZEQPD036.>;addg/=/N2R0,aR4
?37^56J#-Y;cbI:GW59IAPc,S2V&,T2aOMbS5cGP[XPL3==2ES&JKTW6TE&7_?]G
JDeEL7-MVf6:D);+b0?>EIf0SQbgT-L.V7a+.C5<2WC]6I65\R<[H-KYK?H9f;JV
6-/Q0GYCZ9:RA]Y,TN#&#E6N>GZeF]?[>6,&X-c#g8IPT\Y&U5SV#<6@K&f_U9Z<
-;S,8=gR=&/QeCU/54a8b7Y\XB+ZA)Tb/76]TIJ/5aE^bL->U5[1RacIF]2^?)b3
MZgP.>[?]@A]EW,#a6E=AUDa15<bML4b/WANEXbVY.f,979_QOgL9gP+)I=XE=CW
-JW8M)U6^UJ@.[1+AE]68KS:,O(T+c8)RRK>f_<E.3gcaf^^3G30H\Z(1=ZEPgHM
D)O64:TgVET9LeHTT-NBX<,IeS.2f7K;D+T]Hf3_JZ<\,M&Q43&YN(?]IO4LVE+L
CHWT<:[@#LP2.,1:?g5T,Xg:L+?JHU-W4[>1,^aT=0/CN5<T&_8X]/a&F#W9EB9&
:EH&3F/ND[O(=@YW74d><gY4QE;Y;DL6ZT94,4I8SKE80&YfMVBD48L&#2,B5d2f
I7^KQH;5U,2#d5CgVd(]=,R&\T>#R<XH\4B^?ZUNW8L6EP=@aHD3<_C/We1b6KVc
If).9I8,>2MOJN1D@CcFF-UW_dIf9=XL[VONQ\aG_8&]LLd8&MJVZ#XZfCgJ#XU/
ZL0Ac_:@E<(c,:21+Sa,QU)4Oa+PIGONQ/f&,7S(R/E3-g]dQ4b@5]72]3^\74/]
@MId92\1)#\H^M&.1.);#CO/5&PLZY[fc,MG/d.DP1.G0+89^.ggS3EI6JA4,RaF
PDXY143R(bJ>L_M&:).0=3Id9O6FgQ0V719(6KfC;6U<&\0D^QGM]@4BKfRb.e:_
;#:J),e@0.:RQA]\4973VGKSGM@6JcAV8\f-#\VJ[P@^TgR)X:Q#DI830.ee+D<T
_Gg#Z2@BVMSD2R89M7;_D[X_SUdUdG+SS;E^+5&IYOC3[.[,RDfL]K.0HCdMY^AP
0PC:8KL[9390Z07\JEJ&QSB?OQ^FG>?0b^#YI8@c]X22Y@d;9/UW//2KA0DHQPW&
A/dgUa38(fU_82=XQ_R(DA?8&M-26e=W.&0?XOE+P1.Lb?-F2-1bE#)V6:XMG:g_
;TE2B6;GD\#V\E,bDDRcMOF#:b>,?Z(fOO\<GKWI8-O4G2,3CKM-b7U93\dZ#8IR
&M1ZL,1KIOTG?1W?PTND>?\W:FC8BPTSB.KZNOATg]9X@<N#,ICTSEGY\d4,E6PD
,-76^)80F,R?MYT_;bM24V2_db]C5b^[ed7XK@/PT.G3gULE]U@RE?4@-R17LLf0
@]>F6^6V.=7=O&GY,]7#B[:?LS5XN[LMPC\SFT\1dIBg=_(X@3OgJ4:A_(C->f33
#_NZQ/<.5-aDgRg;3C?U+]X#1EYP)9eOKH@ObPJ4g,,X,^&J#W)),>c&_8bT@B<e
HfRb-W<R2K),ZZG^O+Fa4c-RI97K@IH2^U?>3b(NJP8d?,CeIZ=KHH5PR+Kb#D9F
>+G.YN900<_9)B+(:^-8(-&@)PKEYZ7(YM>4D_<#Z&(:X)X0eE-aL^LDf8OP9V/E
Gg0Z\)N4?1+D?F?W2Z5Bf8?W@U]N8)7\E>,8B?3]8TdPFUX1)9d;@D7&BX=P5b,H
_]_9G:+--eBYWd/bT2OLKZ87E(BIeX&/G05d).V&GNO\4+39@X[P(]DAUV3U,\<f
dD>g#2AIfK^MO432+XY\UR<HCHaH4Te44UBg7MYedMBYL4e^)dQ@LJd],dcV3Fa[
DB<e3X0PF=ZM>5)U>KE1RO_E9=[#O/W&TNEN-#T@+Q20<+,7S?&/+9287PF:WZaU
+\&_^FWT6U+]::,&d-dA?R0Q4D&&=>R9)>1\EP_&@+gN+Y@ZCA9SF>VbDF>_eP@,
dYHMIESV9DB7]S_cYM<fcNH&NQ7KK7#GHE&B3-P\))_9PS281[;B3O>;WA\>2>V4
Z:=_>UNXge_#&6>PG-d4HIFD6RW0.DK(WB6O35NZ@AdN^1L]3&fP0DVWD:g1<7Q,
N4?@[?AgX6:-#P4:.a>XOB<CYX1.d_3_A^R41([R(gRG8-1b_F0L/=V=3,N+,@8/
4L-f,IUMP9@B<Z[e_CR]dA#eaW;c,:O=)QB4\>d+8Td(9(a/M3XZac)W_CF,>W(:
XVMJCS<KS3Ma)g1gW.AUC_bFgLC=AXJ#T0(^Y_@Lcd/9bL&:1]UKWX6cL87cNAKP
;a@a9>86^A_K<T<_\O2,K7-C]W7gY3ZBc)1\=Z])SZA-_Z8P]WPSL:d+=)3@G[V/
<C7d@U0f9PRUTgY&.Mg#N)/2I9PB;A&LW#f8<A\f1-gN6,CES1WP>LD05[AJ=gRC
Pc95OYLSa0LJ(8Q#G2#1fga[4R&9N;15_Hbe0)[3?2]/C(fZAC>K\J^Sb4b]DQV3
B_XHU-ZC16cMLLf-(;>D5:g7;ALg.?UaG32g0LX)S-.G>D6^/DL75,AIb?2cV8Q&
K^:NX(2C#LVSKEg_0\#+K(QM\A-2f9e\gb?5Ba:b)7e8[\_KN3INK-5;25fFLVHE
.;)O1FRV:)(ZB?Wgd)OcdP7(C(CP,I\EaAd(We+WX77_U?eG#dHRcS<X#X_(^OCH
.NA)fLG.f6D]>f[<6[>\N,8W6UNX&;7)Q&N4T5f1/SF)K+,&]efc_fN/R1P0/d6E
GbW<0.+R,3d33<C?/TO[W,-^Q1VVdUg>_]EUZe>ET-U=a6-bEW<?a\S4fU]&[#LQ
77Ic[\&PK2-Vg2&L-\U;&H)aYfG)Q;P&ON0BD@PS^.Z03I6A;6750D<L:8.S,e0I
W[XHZ?6b&1-@(61De1-JP1L0=EM4(:+Q.AbAZ2G-caX3W:IQOO93eAQCY,#\;C4B
SU7e@,31Mc&_A[5XWOSGUI#I/<;/a&5e4-^OM-=e0TI8,B(?1&g@8WgcCLfgXDW;
MUQT/\BKT4WBOa7Q.3?fD17HC\STO/6MED)F@X/8@#c/c_#6XC_W.1dDdM)+[OS0
F?.[5_6NUHZb(\2[_]#?b.3?5ZU8LME+1=B86@Q.IIG&\G0&J5T?]gf@)O&5b197
^+]8a9LT@GCFW;].588&7.:.Z@+E^&O=Z29+6]6=f?dW,2G>>R[<_#/9K+#9dCG;
A9=?O+]^<b5&W<D#]AF(g4;+J=HF:N9Q7U3F>T]UB1_#AdU#c,-\,>ccN(1]H\C8
5^KTBMa]UO.X,3WCN,JCQ4;G;f245&caQ6DZ<O4O8GAA=D5_:+<S+]caM9JH9>A^
e_fFcf7;THY2O7>fN4\ZY;_##SXZQd0D9MU]X<c<R70c=8RF)6/NP_Cd?4-3O=+L
fHdKQ(C_@B?FC/De5E]e\92aJ<V6)=]+aQ6ZHVKNe+\X=C/Z\Z2DL6JggW4/Y#]F
32T[c\^CDQ(C323G>4@F3UDW[c,:H<^L76R;0--SfgXcQHEQ53ge.Y,BS.)Q6GO9
J\gBT]G?U+FFe;A;/=/ARU28b.NNHe3Wb7+e=+BQQL:FTGGW^39@\;MNId^.<::P
Y<\H3,)QI[0LgZ1\(W,bRgC;cB)_?EP6#GYcf+d\M_.M@JHb8Ke1[T)TC\I7<=g;
=@6:(g[gRdH.&8Z+H;U4#4UH;d\N93SPBLA;8e3a>BbCCSfe)1X9&XQ]EJ_]_^=V
HNe@P^;BMRf;,3H<M:0&^-If/S&,#LdQZH^83Z=c?W@W-3DN5Jag+DKWM0AcFA_4
=W+dVO83#LWf:9?22Fd5:V_2<&IUB2RZ&AVbe-9)fS+@N>(5f9MYO+e0-TdTa1,_
VOad#=-[.BZ6eg@PWVBM:bE@]e(0Bf[.=9DHBBe?ZNg^FXLDHUCER0O;\OZ#NK?T
f-VSGXBVTEO0AT3=D-E-9#bD)U\ZVQN,>R_:,EP6O85b6ZGZda1BMK]J,.=G>YI,
[1?#?V\#dSFCAESQ)S10a[6K?&Fb3<f#B#XC@P\M.--[fB-)IH7)0HE[:BBZPH=G
W-Sc8d.gJNDf16d5H6)S#Y2cO0M/MeaDZ)<JS/9P,1V(+29,J84W9A#Z>Le<&1Y[
=DGSa22+M8=]W?eG;[>2KL=VXaZ<H[3e3BLPCT_@bgJde0f3R6DI1/K4Yc7GL:K;
6Z8)+:(3O<.LSJM0D[K?@W(b&Rg<M8e<B9VJ&?a[46S(aQW+Y:GU[06G,\9ZXG?Z
K;C[R^bBI&MFcT@/-Z/b2;D7OLI8g_#8QR7=Q81K9cNOHd6.\]eS90DBE,L91WS3
_g3)=eKBA4MdZLH>:7&(:YAJ7f-SC1Q8cWK0B^T48-a)?bT:P=gFG0M_GQSfA>E.
,9TDeNg&2_dQ3EQ:ZC>0,Pbe^EQLQ9E+H_Oe0eP=9E_^)I/+CGgM2R5E3BNR?HHc
@=TR:TK2Lcb;8N^XZ7D:?GZV3@B5K2INfN;0DWSY@67MGS#265.XVU@C_&A[8g^T
;]_,2b7Bg=1E7A&<0,_/d#IA[E;Y0RBg8;LOK/GB3QLO4?Bdc79(Y1K&b/C_/K5F
UHTNHB^e=,b35,f7LO=ddS[@CS-7f&[^#P<X2d[D\V^fDH5,YLQSg81H6d.8_2\V
4C>2@/<#]DCE\0#OGB@1H+B:<7ZEF:fUSHG3_Z>FOR^bdB/=D3=e\W0STV(e.)C3
e(6Z<>bRT>0^BTDdZ9<6K[dRMR[F,<_NS</[O4/?:P3<W;SdU(#e2;WFH(G9[&83
[--4X(4@U0-S<EPOOF,0EH<5B/cIa].eJ/?;TP9F_4TX\6(,&HJVfVGA4CY8D;U5
eJG;#RAHM>0K(W,:(IU,4Sgc2[FgWE:DKQV9Y6.+LgW#_eD]d6EcE@RNWYbW7@5X
&4TFHc@S(PE\0[;A;,VX.)VfOTH-8[dIFM<<.PLcg;I26S-+NV:WO@fCZH]X?ebW
>&DfJI7B5_=e;4aK<4+2]VWVJ^0JOT1AfK&TLB]>WKA\S0aGQ/W?0,[I<8S^BP3W
@1/,P<]PV/7TH=UHA,XK1#Qd3Vdf9VJJA<R+GMUCSKVMVL#Jdg[0CH8#+&_R,\U#
=A?;I[a7C>7Tg20dB+bYHW#\Ge(-A-1WFK&4FB0_R>J1Y+\62/T&GLY9EFXQC<Oa
\Y5#FI<VPeQ-8W@XW\\AeMB8O;,GLfJ7WgWCX5AcKV.-G?0A6]e/6CfLY=J#TY;J
40(WD>Tg+?NDU3Egdg2Y5[)>632bg,XD-e.8E<K[#7FY(MJI0Z4MCc=VLbe&HY3W
.FFY8PBb(e<G.PeOPS:J0gNXaMNPPOD4W)0U\cR,#2A8c:#<R@4J.=QLJ>L=GbDg
;T<T:?(>#W3N1-Ya3S4.A#&d;+dLL0;E0Gd^1:JRBE0ZDORMZb14]U5YN6b7K&91
DB>6I-V1d[gHd.W).SZP7H]#f]BeTXfI&UVS9g2g9]+SL1/9b])2[GWfZcIBLZY6
-3>MVJKS=XY2+<UZ-9I)6.U.a<6WaJ)dT7+O7HgIJ6P.4MMA#;_,OHA/;.g6g&;Q
fW\7DQK4a,BcL5.F30-)?4H2aYOIH@JIF@X:WS(L3[DGKaV>I[7;Z_9M;gg4331@
G:J9P3I/10=TQ?;O+#AaJaG?Sb;=]gNIf:CJ64O[aR:+^O>AGP./Bb;U0HP)I,WS
ECI=2d(B:)eL?ZZ].7Ygf&g/MPOc2a9\A5]dNH)C=^8b<MJK(ZcX89:IYJ.YXfB;
7R5P.;g;+N2g?)-V=][?T,DDS(I+F/1^V0P2(d#=_,Y,/JEHIXT\131C)Ue4;Y#b
@?SMN0\R,I/Yf+LG[CKcKDB+4T8##^3Yg^\Z#?R2dFc8?D2CT#/9U;<(^RQ5((<8
H\FFL)1&bgeD,8B3eb+SVE?EV@IOeNf6X<\T[S3I40ZR2f?.I6>5VUT@c.@5_d#H
W;1B\W)/_S2W&,L=d+?^8(CXCY<K,B0=6-bH?:):>5;W=ALQ&.#1607[X&Z_#TAV
.W3N9A[X#)LII)5]bOgF#?bO/f^D):-78MP]+.gA(@c+F#69+^CK?gbF,^QNR-I0
gE:5H50<N&E8OT-1\dU9>+78J6@_@:D-AI_84I/aB=_3)X<?SfCLO6;3F:[YH3[>
,.2Q_:\OJZ.PD_X:;gg=#ZINc2+PV+5XM:b.JU[I4NHcRT2;G,3O?[;3P$
`endprotected


`endif // GUARD_SVT_DEBUG_OPTS_CARRIER_SV
