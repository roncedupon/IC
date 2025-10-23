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

`ifndef GUARD_SVT_STATUS_SV
`define GUARD_SVT_STATUS_SV

`include `SVT_SOURCE_MAP_LIB_SRC_SVI(R-2020.12,svt_data_util)

/**
 * This base macro can be used to configure a basic notify, as supported by
 * the underlying technology, avoiding redundant configuration of the notify. This macro
 * must be supplied with all pertinent info, including an indication of the
 * notify type.
 */
`define SVT_STATUS_NOTIFY_CONFIGURE_BASE(methodname,stateclass,notifyname,notifykind) \
`ifdef SVT_VMM_TECHNOLOGY \
  if (stateclass.notifyname == 0) begin \
    stateclass.notifyname = stateclass.notify.configure(, notifykind); \
`else \
  if (stateclass.notifyname == null) begin \
    `SVT_XVM(event_pool) event_pool = stateclass.get_event_pool(); \
    stateclass.notifyname = event_pool.get(`SVT_DATA_UTIL_ARG_TO_STRING(notifyname)); \
`endif \
  end else begin \
    `svt_fatal(`SVT_DATA_UTIL_ARG_TO_STRING(methodname), $sformatf("Attempted to configure notify '%0s' twice. Unable to continue.", `SVT_DATA_UTIL_ARG_TO_STRING(notifyname))); \
  end

/**
 * This macro can be used to configure a basic notify, as supported by
 * vmm_notify, avoiding redundant configuration of the notify. This
 * macro assumes the client desires an ON/OFF notify.
 */
`define SVT_STATUS_NOTIFY_CONFIGURE(methodname,stateclass,notifyname) \
  `SVT_STATUS_NOTIFY_CONFIGURE_BASE(methodname,stateclass,notifyname,svt_notify::ON_OFF)

`ifdef SVT_VMM_TECHNOLOGY
/**
 * This macro can be used to configure a named notify, as supported by
 * svt_notify, avoiding redundant configuration of the notify.
 */
`else
/**
 * This macro can be used to configure a named notify, as supported by
 * `SVT_XVM(event_pool), avoiding redundant configuration of the notify.
 */
`endif
`define SVT_STATUS_NOTIFY_CONFIGURE_NAMED_NOTIFY_BASE(methodname,stateclass,notifyname,notifykind) \
`ifdef SVT_VMM_TECHNOLOGY \
  if (stateclass.notifyname == 0) begin \
`ifdef SVT_MULTI_SIM_LOCAL_STATIC_VARIABLE_WITH_INITIALIZER_REQUIRES_STATIC_KEYWORD \
    svt_notify typed_notify ; \
    typed_notify = stateclass.get_notify(); \
`else  \
    svt_notify typed_notify = stateclass.get_notify(); \
`endif \
    stateclass.notifyname = typed_notify.configure_named_notify(`SVT_DATA_UTIL_ARG_TO_STRING(notifyname), , notifykind); \
`else \
  if (stateclass.notifyname == null) begin \
    `SVT_XVM(event_pool) event_pool = stateclass.get_event_pool(); \
    stateclass.notifyname = event_pool.get(`SVT_DATA_UTIL_ARG_TO_STRING(notifyname)); \
`endif \
  end else begin \
    `svt_fatal(`SVT_DATA_UTIL_ARG_TO_STRING(methodname), $sformatf("Attempted to configure notify '%0s' twice. Unable to continue.", `SVT_DATA_UTIL_ARG_TO_STRING(notifyname))); \
  end

`ifdef SVT_VMM_TECHNOLOGY
/**
 * This macro can be used to configure a named notify, as supported by
 * svt_notify, avoiding redundant configuration of the notify. This
 * macro assumes the client desires an ON/OFF notify.
 */
`else
/**
 * This macro can be used to configure a named notify, as supported by
 * `SVT_XVM(event_pool), avoiding redundant configuration of the notify. This
 * macro assumes the client desires an ON/OFF notify.
 */
`endif
`define SVT_STATUS_NOTIFY_CONFIGURE_NAMED_NOTIFY(methodname,stateclass,notifyname) \
  `SVT_STATUS_NOTIFY_CONFIGURE_NAMED_NOTIFY_BASE(methodname,stateclass,notifyname,svt_notify::ON_OFF)


/**
 * This macro can be used to check whether a notification event has been configured.
 */
`define SVT_STATUS_EVENT_CHECK(funcname,evowner,evname) \
  if (`SVT_STATUS_EVENT_IS_EMPTY(evowner,evname)) begin \
    `svt_error(`SVT_DATA_UTIL_ARG_TO_STRING(funcname), $sformatf("Notify '%0s' has not been configured. Unable to continue.", `SVT_DATA_UTIL_ARG_TO_STRING(evname))); \
    funcname = 0; \
  end

/**
 * This macro can be used to check whether a notification event has been configured.
 * NOTE: This is kept around for backwards compatibility -- classes should be moving to SVT_STATUS_EVENT_CHECK.
 */
`define SVT_STATUS_NOTIFY_CHECK(funcname,evname) \
  `SVT_STATUS_EVENT_CHECK(funcname,this,evname)

/** Macro used to signal a notification event for the current methodology */
`define SVT_STATUS_TRIGGER_EVENT(evowner,evname) \
  `svt_trigger_event(evowner,evname)

/** Macro used to signal a notification event and corresponding data for the current methodology */
`define SVT_STATUS_TRIGGER_DATA_EVENT(evowner,evname,evdata) \
  `svt_trigger_data_event(evowner,evname,evdata)

/** Macro used to signal a notification event and corresponding data for the current methodology, but with a 'copy' of the original data */
`define SVT_STATUS_TRIGGER_COPY_DATA_EVENT(evowner,evname,evdata) \
  `svt_trigger_copy_data_event(evowner,evname,evdata)

/**
 * Macro used to check the is_on state for a notification event in the current methodology.
 */
`define SVT_STATUS_EVENT_IS_ON(evowner,evname) \
  `svt_event_is_on(evowner,evname)

/** Macro used to wait for a notification event in the current methodology */
`define SVT_STATUS_WAIT_FOR_TRIGGER(evowner,evname) \
  `svt_wait_event_trigger(evowner,evname)

/** Macro used to wait for an 'on' notification event in the current methodology */
`define SVT_STATUS_WAIT_FOR_ON(evowner,evname) \
  `svt_wait_event_on(evowner,evname)

/** Macro used to wait for an 'off' a notification event in the current methodology */
`define SVT_STATUS_WAIT_FOR_OFF(evowner,evname) \
  `svt_wait_event_off(evowner,evname)

/** Macro used to use the event status accessor function for the current methodology to retrieve the status for a notification event */
`define SVT_STATUS_EVENT_STATUS(evowner,evname) \
  `svt_event_status(evowner,evname)

/** Macro used to get the notification event status */
`define SVT_STATUS_GET_EVENT_STATUS(evowner,evname,evstatus) \
  `svt_get_event_status(evowner,evname,evstatus)

/** Macro used to reset a notification event in the current methodology */
`define SVT_STATUS_RESET_EVENT(evowner,evname) \
  `svt_reset_event(evowner,evname)

//svt_vcs_lic_vip_protect
`protected
&TNRFKbbWIdTTF5^FWY\Z#fXWO;[<>TaOXfcN5XIPI/\IUg.NFHJ&(,a^F[RU:RP
8(Kg/RLNfS3#0QL?BA7_[g1MT)<ce>GU],;7b#5DeMg66;)WBP3@716)1a6G^M]=
@M_52K/bDQeTJME,;^.K5+#0_#gOTCD0a<<@A.c-0PJ98BK_QIcU]f>\H_2.f@RL
+F54L5#XWO372^:+>.29.c:S_HD:EWI7@,_3g6MTIf,a)UMMG@dccR4A/L06D8QJ
.Zf<3a/^:aD#QC7A,RFT1Fd@0LQ<cL])1L@6?-6VC4)DH^@ADWP1AT;b2Q[dH<c-
eD30(]6EfBTe?a0a\\c/IZ=:=6ZO_9#cE)D?/5&)QR-HV9.&L)c(e+SHGQfPD=&P
X-g+Ad?3.7ND&BSbNZF:50LO[3\?d3bSJeX6,gQ@/G7LT-L<1Y=1R5(R)LB^XFd6
?B_3TK5B=?g.1JJd@g0)\@2XD-9,<(XWVE6X#SNVgH58>,^&TMU/4B\:<Fb]PMQ.
YDPfJfMKK?HA#?M+]cS:OXSMDL7Lf],K->2f?aEH:O6Yc0]9/e+HU&,:\Ig?dIUM
TG49\CO43^&]gQR.R9Z_[^e0,P.K734=K@71g.YY_B)?V8aFg+Y&MCKQ8<?eTJb+
S=21[8G1880a9^)A3?17(D2OadA(5H(;RYW.9V758#9b(b5K\I6SZW..[Cg&1YJW
.4=W2b?gcJAWP\8Bb=^dLaJEda[-#^7&aV9b703077:OG7PU0_RSOJ82W_)d&A],
JfD5e9\Ec&&e>+D8dVX8EO8J<[&#a2[f#gS+G@RB6KeU9e/]D4,-Z9QX6I^P^NV>
eLMX4]gNZ[VQ_;DN\RI?(,6;,\?Hf@fgDaK9_N@O;JU-8[Q^0HE?_e0:/=LeTKLU
BD1VZFKHC2<Va&]0(?69a_39MZ6Y<W3N6VcFKMEfbdU^<;+.F@&-a8]U>T46NDYL
NE/02^bEM6[XdM>&Q2^(bbYf[YA_TCJBW3/@b<Eae?<I>KTDfP8VYHY_Q+;_aE4IU$
`endprotected


// =============================================================================
/**
 * Base class for all SVT model status data descriptor objects. As functionality
 * commonly needed for status of SVT models is defined, it will be implemented
 * (or at least prototyped) in this class.
 */
class svt_status extends `SVT_DATA_TYPE;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * Used to report the Instance Name of a transactor to this
   * status object is for. The value is set by the transactor to match the 
   * Instance Name given the transactor by the transactor configuration object.
   * 
   */
  string inst = `SVT_UNSET_INST_NAME;

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_status)
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_status class, in addition
   * to replacing the built-in vmm_notify with an extended svt_notify which
   * includes the same base features.
   *
   * @param log An vmm_log object reference used to replace the default internal
   * logger. The class extension that calls super.new() should pass a reference
   * to its own <i>static</i> log instance.
   * @param suite_name A String that identifies the product suite to which the
   * status object belongs.
   */
  extern function new(vmm_log log = null, string suite_name = "");
`else
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_status class, passing the
   * appropriate argument values to the <b>svt_sequence_item_base</b> parent class.
   *
   * @param name Intance name for this object
   * 
   * @param suite_name A String that identifies the product suite to which the
   * transaction object belongs.
   */
  extern function new(string name = "svt_status_inst", string suite_name = "");
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_status)
  `svt_data_member_end(svt_status)

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Helper method to get a handle to the notify data member, cast to an object
   * of type svt_notify.
   */
  extern virtual function svt_notify get_notify();
`endif

  // ****************************************************************************
  // UVM/OVM/VMM Methods
  // ****************************************************************************

//svt_vcs_lic_vip_protect
`protected
?#1>Ub]DNAAMXPN=U1/:c]&GQ/f-eZN0VS,bD>=L5fe#::0K95a13(IC@ARJ&RGL
cX<d;S3/?2B#g#J3RD\6;X,<)cZU7@I)>P-Cc5>XEU<.Ga+GJ_MeXH4)M^B-093\
@9;&PO/B)J]7AYbF2dXLA7Y7E)K4.N3_eUGg3gQBE:[X0?U[]2(S)9FbY)Ic_6K(
3MPRG5(R3Dc6BQO?CTENO+CH3a_-U^L5@/?)6O(^>YG&ASK39JO@&+F4I?DNYfU6
8S;LS?YaM+@N>U@TXdAIQ=U]U@GS-SGT9ZAfgKBGKR5VC9R+8V.4)KJ_HO.U<=Ag
[B3FS<V[9]6-+5=W[[BO?d^5S)g/F0>cNO8SS7A#-<?G?<0>])TBGad=[G3?RCQd
@QePg@:07\KfdV]Q0JP_7IPQ:\d@A7N<(EO)&]GaB._P?O3,KW601(_CJa6QV&<I
KKLgLe6>cVQ?#1^\]c#-.GZJW=;9T@]H=_5,Q:FOP&E8eYF@A_14D8deG(M0L[#^
6/?;N]=>EK;\1JT<VY@9SZI/6-P/bVK)\Z:-Ja?KN:3X7^V\e->@<fUJ_^GYI?Ce
aKRD_aV>ZGZ9O6\:9ROR^.Zc4>EL\+.@?Vb)@V>05cD],N<=B06&G@1ad\PRY7TJ
(<bS@6@^NLZ+adg4DE(3^J(^[M6#b<<<G65ZQRIJeKP4CLVNOe[bSK4d]fT5#V4d
<WDW-RL-WbB:=ZB&ca73#U,0AgFPEU0F?AP,He8,+C\?6cFR91cKXT=eAJ39G7K7
;WJLHV#6^KV[=Y#2[P^Dg?_DT7dc0Oa@#=(=E?@dI?V5f[M1b5\bII>N6QOacf[:
HC<S7>f_b[#EBcAO48KN]CVe5F+2U4/>W\NQ_L_AY26ReE(M/@RRWLaU.2#f_Iba
+14Fc^.,Y4dDd.eI-48W3cIV&<BbB#gD_2HN14D&:3c.6J8;eR7-gF0FRLLO8@H:
K:<A&(GT:dLT8a).1?HK=A.6VMR35=dK)56N=UgPE79^C&8]5[+7cC>c9]EUc+[(
X:MT1Q<H?;TI^CI(Y4,93cS4+?P.&X.bH^7ggU:]Ff7;Q16V6&&/AX@9LP=5QN_e
Yf/b5e_[0IV?#93f&aF8&23PX)7)]M54;?U8<D6B8]<W(dH:KbH^=XY+I?4\:T5C
RHZN3K6++E:QI#C^.@B;4O@HF[4\7cJQ170fC5X=eeeY+DaGM05>2YYMVW&MaQML
/;8Q8P7]PRY960?M:O?]5WD]N\JC78>DK#+5^LQd<cQbPY;J[?eAB.Ua8O.BBKfa
8g9IKX8JZG<b-KTS:9TZURgF25WPF:L/)KdaZT0H,c2O1e(LGA_K,[_S]Q7dYeZ_
J.PFM,W(SIJ7eBWb(bCYJe0Q4A(9VdG(=CXc=3=[KUV<:0YUb.N;6e,a\/0AQ9Id
@XdX/BW?aP:,W1]CCY:gX=?N(-VA3K5W85;,GKU_a4g@L12W;>g/L,[O4CF^W#eG
)[Y0<BaAZ.:+#:I]]KZL:P7:_[#^/f)2;8SLI]ef3@9gdHf#8\dISe4:[I\<EXN+
0\e1b@/.QA]MOYdS,FUf>?25d#b6O_RMa4f2:eNFb0GR:c]?&Z9^OL7X#Y]eS>V(
K/d^c)A:.C8&H?SRaW8fU7&;B2X-aXM9B,ggQeM7DHHJ#_N>3983U3EeH:f1cV6d
#(L8a,g1G]b]?(OA7JX2Z1dL,].[MaNIBY3^N+]T&gbO^\M-69[Z?F>P&L;;_aNJ
Gb?#GT@a,UQ2/.Z=Q[BgXfYDLQH7N--\WObVA2\.8S<LXdYZ0GI7eW^Y;e<c&,_^
PdW.CKaTDOHHB)F;?Z7A,Og+Q0@5dF.BVZ4(T@Z28@9NY:b@QE9-.bfYO,FJMHDH
I_1Z7Z9PL3A.GZf.Y[?,^R2A-3Z8Ce)gVPQA+26GO6U>\AL;0:fKF^,6(6;:LfRK
@;5)0Q2>,g@X/7BT1#8M@eHTbT:+_Kb0ZZ;>bTfgL:V:8&3Y)?K5b+]/2PK.\g&Y
_]H&7+@gbM]-51fCcYa\H-Z;KNF=OcZb5]-=3BLJ3ERb5.#1g4gAGg37TcfP<UUE
9&,BXG/U\VI640L>,;-B3g#5:g]9RN_ZEL[3Rbf.,4H:4FIfCHA?EFZ+&>E/M=P0
6#E.=\V\]0N0P)13M5^Z4Q-dbGD;Bg-?KcW4d@3EB5VVc7__SY]Rg.7@]087^fN+
8S-bE2MEdMSI/ab@2AY;TXE>7+aIF8V7JA5fMOG=K55gYd[QVfRbWD477gFYLA?A
\S6LdZU1IFc91<F6/,9284a0OHYTKU-c;GdE#E7&2LE[)+[^>b>)L>Ia5_):E(UR
D(g]69;-3DEPP2@(9C;5=DIBGO)d6#>b3^M;44g\f.1FW12V&>PEf]A9TQaUL60V
#</5N[RP7Qc/8B79>DBV,W>1GQ:LZST3R\9FRJW65+Sd]gEg9]^.\7J.HfeR(bA6
]EG41ff\9(T\,9bNf^_;#;L7?5TdM[WPC6aJWe_,_B2d1]9Z>H-Q8MX04cXeSQ=,
_+X5C-:0D+4@(c@\M<d4Z04ObSOJ,R]g<6=Qg&&LT5]=b6FT.^fA4_ZVX1BU)8M7
/B+#V_QE002Z+(+WN+D<1&9X41,U.RX[G3K\9W_;47_V;/L#DSTRN5P2J9V,/&g^
D;Acg<)81PBC55H2FI;,-8;HIcS\:11;<#AgT<;7g^/=_KE]bYKAD6=,H)UK08T8
@f).AbJYg_TcNBJd@SSKcdUW&^e[G<<-ZY:eg1?._L9fFcN09K_><E][)/--?JPd
0,A>gJDf)8E3Z]C,CGZ]<^aSE@Cf]PRS<LYG7.MdXD.S^d/4]?c^#EZZ5D_BKJ5(
[0cC<?>OO<GWZf.T1YVbeI]DQ>)QCD@(ZUCP0&6WOWMT60ePK\L?BAR-[CFb?&:,
;d,>9>5YF#+:a\B3Sb4Tb2J=;3R=f->Y7WGf9^P:b@S3MU0E?JL&GC>,9S0KBHGa
-;E=RD6Q#>ZUdMOS^-d32.CH[Tec7d=?@8d?:LQC7HI9PUbXJ-a#S71-LSBe4S8R
0b,ZKfKD<<A9,/bV2Z=SB4>6-KVfZ0RE@M5#;GXV\LJAaP1@MI?PcMJY=MA4/@\#
UQJ6g\6..Qd;cLY7FG]?</D.dJ?d)<f)T]D[@Q#BNJ\BgK1HS>M,J38[Q/BB<&]c
Q)+\QM2dH(4]0g4?=2VN(\P&?Z.G^>&36U&\81(^GORb49c##2(-Zf@_A@eWN5Ec
:A96JOJAPFO-=:b\HGOfA[I0?gSQM8R3c]gIa[<\]BFJ;>L;&,S@X9@EZC>K):UW
H0fO7Z5fd+:E=?X=](^:6:f[M=Y(Wd(>Z_+Ag\@\b?KaMX;4U<&ZQ]XB<_G=](YU
3dW&HH-?=g8:O229Y,=MHLGGbKK6DVO_W8)N^d;Q?KV^a#.+S0gPU3Z]f[SG+U9B
E-1ZcT\/,S8IF+(cYfO3Gd4?=c&?;&NOfKLLNbKXd2PM_WYf4BV^^b?]&0^<6=9R
:&PT(J6^J?f/;aC@Cb,3W\L<(H)/#\J8@(N=W+=.M21E-T[4Pd?;?ZW_X)C]Afb]
,<^e[C;fJVU@8ccdFQ9]_RV^5UYQXZ7g0X[XEM]2K[EKZ55BR]X-a>cXYYe<D54a
AOI-Ya0_9ZM9)>b@BC>.SHI6BTS9GQ?PN^26MOW<^]g]A;SJ+>Jc22^gDRa+Hg4L
L7THQ,O4(5#=U0/f@89U[Zc/O:8VI7ALBbRf=+2OFU3N.C>(-74&&U7VEb+<:1.,
5V,U(C(eEZ?/7U_33X,NL+3E9T(J6W@d[bS;I)<Hd+e6L.Q,6HIDA8J<ME6=bBWe
N.L_DK9IV4E2/-b&dgP[aW]1NMO->bMB,7e.^(_D^<S+Z6WXU=<7FLd#?:I^K/7X
@(Z<=>)KR3L7#3P,)<KV1]^5,WUSU4_1//.@FU(PCWBSPTK7<<NJ5L2;:eHXVe>>
SB^F+aB;08(g=Y]J-b@3&=)JLBXecK.eJ/1.0OP8-:JULQ+ecVR4CGN?_?5=L/(\
[:(77W,FFYgDaFcFQ&32+>U(9d-cXAHf,#GdC9#9.;:Q^=CD=G8d?FOQg43N[ZUI
EX//=Zg^gWK4YQG>F;034=b.;Ke2R?VQXW[3H96K&J[2G:[Jef=g9<G][2.FIK[&
YS_D]]TaWDGe#\H\0#A8J,+X7>W8=FaGOJbXH37U0]Rf61cc6EK_Y=5S8H+A2_,;
/W;DO7\4\gN1U_3E)WU0a-7BOL4IT_?Nc:_J]7PS.7@g[AQ,[P(fg(<?B85=<1Wg
\LTARKZ@/#+_BA:X[1@[16gYFA+H=G/FJ+@(A/VI&5#;H]e3,@g2.,G]?#:@ISeS
e\.V\eC27;Kd\0(6BTFV+WS_b/9,_).9Q8cRa[1L_f]QYPP-+c#AK#3R51NP4OQK
]Y4/D>U=g+M_BD1eJ<@c:N2^&\.S:\6\(EN>6Cd(77YQ(1USNQCLIBBMfZ@CT(+g
>-MYX1;67/OZ#MQ2K[K&J1Td(BX,54M#RXB7VC,MNI<[XBQ?1\@H8.XTcNOL;#7^
F@/g9?YA;0IH&L-g1HT#T:0WI)N<X+.DYgI4ALWB#eA)924c6X2FWRRSfT#bX;eW
N^V:^@;2.=W/=]&g+RXd:VCg99]&X)LU1<^<J;L90\M9NY3_@+WI[P0eXIWZ:fFe
g#WFQ\/a+cA)A8CW52aK>-FbR9C<?UdY#ZH/2>GLDH^2aeSdG:bb^L,/A:Mcd^N7
e#CFO-,N06O_L23+/>)@g9@R46)5caS]7XX/85dZZ&4c+fRI+OBI=^,b@(5e20/O
g.M4:;G6f<YaXLAZ@dOYK2&g6S]C4?;.bNY2-9g&KAd2W0(.^eca?1C)4)1f68JP
Y3EWC5?+R\1c4a>;P9Je2Jcf=FALMZV4&1IR+:DFZ70X,8WMRQ]O\[=QX:2X^Bd<
\,]3:C=WDKI25MeA((M7Qf1@FEK(/^8V5d2Lc1ecP@/EW&4E[FHaC;A:=9O31>f5
T]>2BG7FWe7AO<]UR++GWe\)@[d2)HM6VYBH]:P#PdAcX)g?H\Qd,eI3K;DXRI6F
R@Q8C0T4bQ8@T,JbbA[2cNJ9HQF7_R+WR./?O4BF5NFS?QW2O4B7;:5d7H>?</L4
]OD2S4.f;(MP:(M:aYCNM\C/&+69+?Wg)]<5F<-OHKWW9?BF2,L11_Q]aD1[GHGC
B-9g-UU(_,3c&OHZBCSOT6Q43?B>NK0BC@/DNXF1AK(]8OYZ]a0Ba[MgM5M3]2B.
O[Ye-W>UQ)Ec3<?HQ1-.YI-X7Q__>GC7&;79feC\>Pa@MD2NQC?E\RP:@)3K[101
T5FASBRE)?)=#B8XgI1_+FCDU[>;2QTIP0NLDU+:dL>?[Hcg#:,:gf>c+2QW0(GG
?f:e6U-GH?_@P]PTOZB3&.aagA-1b];#7ESCf9;&VM1#cRMb(Gd?&(IYcAabLT?7
:]6CC7.C[A2ZSeU#^://4DMcTd]R?&7GD3)P;+b-PEI&gH(V?ECY014H6(6fGJU8
J40;)Q8.dP?dNLabWdS?f2[Z#4MSfAgABfJYQA8/H),^U>V@_J8:#aEIgHNUgT#J
B3H.J&)]c\;((EBJU59J21/gcMYJD;B6@adB].XY]AFWL]8T92F48PWcB@aF;.4;
/_d)NV)I:QWLPc0I-&D/BVK)_U:]?B2F;A?P+)L.CD_OPLOC+_:D[9[1)Ce:IB5[
R801EV4F?_&^&\\cA9_BQ6NgANQURfZU^V@(5C3A><8@I^CbB-O]SFH@5(IRf=OR
8QGVR0M/E:C6WE1A4&JR=4Q7\T@JYIg\T>Cg@O8=d:PP:9RT4U241YC#93M7B^])
K_016<YbVYc1,FA9XSC#[X#,6ABP[Ca)<BRA#J24:HNA4)8dOBb?Ff:<YC<667BU
#X/O=YJPA=06/);QfG:JS4U>3[IK?aZ\\<gS/?AT][c?RC(bd_&WW(#4:G\KbLKT
2Mg\EceZS5\5:e_F[bD8UeZ>T6U[RD>+\5A:U,g/cbYKQMcHc:+UaRZ/+^SM8D<K
O?)[TOT2I/3Qg#_56SIOeH)+RfQQ.OR@5Y3C+cKS2I^C<4^-IY2K9<41P0F:gX(B
A?G6&E]8CULdbZd#L?8@BFD:#LGZ7VAW-+TG8NI(U5[a+I\OYAbe9_=KAdK>KP&Q
gB4+FG>:5+H.dY0(<S9P7=A\[^:,M(9R^[F#)D1T(M(4;242D\Q=&G^FAZQF(+KD
MbE,_44I7(HaEJRZ.<)?Z6V8.8;dNHSLY/aT<\4ffW@T7cAJeA[0+1;=WWETa>Kc
9652^U1XRTa=G=\adVN2JG9^>9E]G:XG[Ud/5,WDJCR/+YR4E-T?Iac8bQV(A==\
3gYf8;M6O._G\@9YeW8HZ]+W>\d6?b-:e]O:_;@Cg/>dW,<Pf3bF5Y)3bJK/<65[
.SM:XG9bUYWT9MA2U5W,A4W,+W(,5@)M#J:E6g]X7WMPPQg1eX0(Y\PIa=W>AKbK
gS=+YGdgDN]D1gUUe:\J\T<R6g^-.#>M@IIT0=KaIGTT/7a8<d4F]c@D4S@3T+7X
YS\H<LF,@<?E]5[XRT3-NIL+PcRJCW-.C@_\U+UYQ4=e,W6OFeGXLK/YSg;C?F-G
NSd/fPJS0g_>9;Q,:)+7CW<>D=e_0@VP>XAY6-?(#5E7#HSLPR?]UK;+Q.-M079B
J9+AB?J44:eP4T]fHGcMLATg+:cT]_Nf2Q.WHX5OBSSF74fM>547Y.5>fcId.Bc8
FLX32ZZL]HUePP(#J@>5=YVZZ6(5@<49(CFJ)=eSZJ([0B,cN-Fa3\9A0]O:aL-:
D&D+=:J&V6ZR[;8(/VZ;MfH#_VE3XS^TG(=S=COA4VR:]T?-2Q<fHK+WZT?U7(1B
FDgg=&./#V^PSH_/1TKNg@E:?,_O@CIQBBPTHF(R(ABEZ3&BgReNI6[M7\EA=aG#
7E&242f?;3,S8P]a(Te9F&4D7:M^D^2]\G-1G+1ZNeEY9R45\befK/:I_GN\N&-E
GcT-8H(Xc_4RQ(HMW+cA/U9_UO\D\\5OSQG6,\1TF(f7=S\&F<(-cR6b?H9c)Y[N
EFWgdS]9&[=&H=X\T3:.e#>7YH,M:;(LNT/6-:d[S[T/9f:K,=7NgScdPA5_]I2W
,2=B(X4Q/?(@?09U?6/SZOX=,^7044VFIKU6\X;.D[X:Q8DXU)BVGJS-TH[44]ba
WeX0F4a\IF/I1C4_TQ4&fP[KeMcU?P#=19/LJYdB=TcSF)KKO.&dd9X6GVb=bGBS
8)bQ0SD4deDN-e\f#E9:36]I&<YPYe1AGfWJXRCS50U@\@JTCaSN6#D(F>E@0RHS
K3@[N?X>].CeZOQN_>eeN1^?<^.W3-369e+]C__LYFbbR+3A]OI=3Xg2#(?Qg+]N
4Pe.]&9R)Xf+5e,.Q#H2.B^?6$
`endprotected


  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
R=L_[=_d#_:4;7BI?[?_-Q8,g.Vd8d[FA?4/Y#^M3D7@c)OSAQY14(W&/XJ@0P3P
+HP7A,8.a#.X_Q^(2/EJ5=NEBI\P,4L[f&ZOBB_>;FI<>SA2?fVW^?F:.G/OAM_b
R>]K]g&VN1VWHK&=;9)e_,JC.LZC,;7>(Q,7RD\0cb1/7,.N1;Y>+K02?FHW<9#9
#5BO#:2>G\-T]?(L,[CDdM49<2W3D\8-a8.&U/FC.a#W?#d+XdY9@N7M]3FYE\bV
]C53L\8DScIeG;.RcJ7YD0U+e/Qb@R.&S@Ze]RBU1#I@\e&;)5/gJ)F8T0^&8CCT
N)Y-+VMS^FEC@3M(>W;?J5Mc8b&6b)8CQIYF0#-I<Y+IY,M=@[KRf3,Q4DQ<Q1RL
Ca@A]H9N/Ea+LZ[G3AHcSZ=23-T^08TIFaR.g-P1X<Sb14KW^;e)+Q1#b3&9WC[+
a1]VY#F/.3ddP6I4Ae@=5TKdgM(+W]GH]]FY4Ka([.cY-H7)cG.QZ\G@)LS)^M#S
>=W\S&fPWa92[3JAe:LF/5XENY7(R@;?P]HZ60gK2X[0U6-@72#2Y,,4(^<8BS4<
_B\7_>Y(Y>9d7Z&(?4&#&5(3BQJ>Y1J)M</WbF\.24XLDK?1:PL)-.\/5EY3.411
EHNQ5?43823dU#5[,@DA;-eg4U>FX9#HN+C586<Q[YL(7^YD&fgZ=/77bYJ5d=VQ
SJXTH&CD7-F3GNC._E=dU#O?KCaK^2:@M.CJZQ>?668g2W@B]D^&_f[IXICLSe&>
:&f+<&41@>A=T^DSYV,cAF^>#JeG13.?V106@M:UM\?,+4>->a_DUaNVbdKV;_49
SKfNfB8Y29SKf_Bc4PI@g^4a[^5Ra9Ga.I,EYB=C&+_N8\P8WcTTW[X\X5]S.d=b
B@ScHN\K_66NJ@RS46_5Z8LHNTG7A^8dUf-E44R37\B7-/+g?ERLGDB/4N_A(#4]
V2cTU(4R-f&GU41g99a]@V7.-\#OYd/@Y##T7&.aTCC#:YGRL]CLD]R8=A?ge^K<
6^&8>/1?.0/?b][bR=F\14DeFAa^)FB?74;_&LES@.3-g_\C8SW7/H1=W6[_DDD?
3NQ;8O],T:IfUcHN)10d@.Y+TXC5VFegCCJAHP.f7gSQAHSC/@Mg8>GY&PE)Q^YH
cX9c6/53ZNRa.H8e2f>0g+cb:2L@5.]^05+\cXNM]beKVV]/?LZ(6c^.7.c@XNK4
<:ee>GB4L_0@Z.=UdD33C8[^1f10B?L)3),SIZ)c-8#QD&3?E\-?II4SKS>V],>(
?>,.GKdaZ1>7(\3d93ZX(U&FKC_<:f@Q&S>NYR:Q(?IZ<88cOAW8-)0cMY,2V71X
K-HM\UfRPM/52cAd:Tb57LFZQXd,cJ6HT_PP9g:0M4-/:1IdcF\TcR<TO_SKc?WF
f+U^+Y]7B5ID-[e<=QaC5):e(KCe7-O=4]QMUfP1NU/WQ1SZ?#QK57A+[_eT?fd:
OE(8B_KfAVL9K=@4:75g--F5\K>+^4BK7\]Q#&3-c&&Y=IUaQ[f:fV8X-\4^ME>W
F9Z>T/5-f^7d>BY0RNeK7#\bJO@:^3L-:&72[:\.)?.TI.cb?2.32<DANB;(gO+S
dW9H_(/M_f5?GZZ(J<c+6Qf(1D:9-5A,@cc39MVTbL-Ld9C/II?8fR]/I)6RgA^8
4GE70[g16@2M4_bK@U<dA#_]d^IZf:ODJH/U\5E.3HH<5.9cL>#CI0Z:\Q>SIXEH
+QA+VEKGLT1/0ZgA3-<IcU;bND_=6,5-P<Hd8G-dA879Hb8F,DbUb=6Ee/OP?-cI
AO=QfD]8EO_:XO/_/>2e4^8]SMP#/:=5XF,44#cK\a3+>CC>XQgLZE-DTOTNJ-CW
T^IHL[?;gJ)?>V;&F+4PYS8^[c8&081]H4Hbe@9-PN3D@L>aY+G@:KKTUV.\MK2B
/4-JcWX>MK?DNE\KD?#?Rgbb0QF8GaBZ;P#LJNE)O<6c;1?TA&KcIT@O=_YeGE7N
5+8;-Y4TE5EEJY+&FO6e[fQ@W.(FMF^F##]Sbd\ZFU?NL<;95_BK[2^g/OaK.[C]
C1KFL[(6Jg=Cg;QCL,__I&O=<1SfIN)/gNgB]F[/OZVID\HF8HDDDV@8R,N^9I,B
7^)/0#ZC^AZ.2D2Q&0TCH0d>9dM9.#OOP^P[0^\F^W1\8ED#4[(c1^g=>2ZE\XM5
NAYf=P_@MZKZ0HLY^FN29:fL-]_;Q@Y@25Y1CBHBg.HWYe(C:L@P9_F3M&C5O9ZJ
:(2AYP)gK.0BW;L#OH+?=ES44G(5]E2NGMdRg)8GYTAbP;T;g0JQCgT_#;?&Y5_F
[6V^\g5+X&;P/#\D:>:<LI5g>:dG^c(eM(W1]&@X12b.X3WIZ(SIM\?PL)<B,MH(
(?H3>Kf;,-(1Be=fE#3K@SAFUZ)fN@^_>ePfP,4e_OaYM;eM#F7-V:>RRZ+J/[0F
_G>bYa&KaI6:[[\M>)&QGN,gd_:JUID5\2e+9dONBQ^.]2X]eN&fQEf&MG8_U\FR
E/>78E6<fZ-DMg4_TBX=)LV5^4fZQ<;1-AU>M3OFd=b2&dP[T=&0Z/3Fa[8(SdX6
V<RaAbc\H3JE;\>_I.D4\WKE/Y\WJ5/0.O,VZI1OdEOV8F.0?EC9Q^+C.-)<W2?T
\,1HXNCCP]@UY>MPW7JQKUfF/V+e(JO/6E?)0YIS#T?KE]H.agXR>]I,W9DVaD68
TBIL=,[Bf#+PWS\9d3;GKW,&-HC/DF)bAdPR+Bb2BE@]>QS?,]Z6D=+N=5Q.W-2/
Af^U7SY]_O,e)CX:e/M:=?gO5VPYQ&RWYDP?eASMI?R.VPg\CCX_>507W@_a]=6>
A#[4DgRQG]R5e/4gQfKgH,^HX]?Wd3fcUMO(>1KDWS0NXW_+G^RDQV:0eGXS:>cW
&1L5MQRfVH(AILNS@;f^g)YgM]G(OGI?4RJR]I@dCfW5\-eDQF/&JPa#C_52d>9e
JO[/3>.c\-+ePD;N&GIWEeN:</cSOeF-YI(NFf\>KT;?0EQ@R>9Ie2b1D=6^JXcE
Je[GNAK_;(f;T#>_9F=5(^J23=afZ4QAdC\=K_?XV=XB(G8=?e\3744ES]29.N&5
-^b67#4V:NSCL(RJY.3GgPEJ6GdKM7]J2QHbJ3MbT-C#-F+gI370=,5B,&U7XPR4
gKTF\_+AE?Kb[\K&3EJ2DT>K_+0OA:Q803c^L:]/JV&G\@,+>bI/6=2FSTcY=f@/
Jg^VCae.8ebFWfY8T&d4e3WBPM&KbKC:IH=[c]UGO+6Qa/MKFe<U,G3K[;XI_5dT
_TH>/K;E-POA=\6E8@BP_I<R9<JF4P?T6/::MH6a7?@EG;-P4;HHUcYb?.NP4GCV
FIKY;8Pa#T__@)HE3&Fd4?>dZ6Q@agDR=K#LgW]CF:Z5#EKUWA+cQ@F#&<1-0DE:
G_;.=dFUM#S\)9O8A;.aT96&3N\W4.<X]T@eLg:[PgAdYJPN/P2_2.fV>Q1b-75e
(V4KXR42/gU.JUZffIZbge2+())-:QYC8&#e+L89E5Eg4+Bg1fTKd)4@.?C-0B?6
=c86;b#:IPSJ:QOZP6H7DN1C7LQ=[+NM8=eeP9g#6Q4@9UPg4Ee9T#QBHJQIS#:;
N2493I-Q1K32WK8O+2R>9Ca(),,e,bHQ1169bbf]LRA&=]E+)KI8HdQ\29J)IE6D
Eg+KeLe4\_0?^P+c,[AF7HCW^F&[)NH^N-Nf6_::dS-?)FXX2FTH-fEWcNdE=P;]
NHW#gC4B23/(#_X7(A3C+?YI8IEYbDU#G^X]e+<Z(KQLEX4YQC:>gD>&;Cc:+;4&
=26JKcBfVVNR.)Kb3.PL0W_0^MX9+Ta&CaA+9UZN3;JbY?.UC57YJFX9A(<^S9R_
6:M@__3MW(A11&dHM==1[JYb@4Lg6XVOUC=GMCO06F,ITGOS(^Q88?2QN4a)3L_5
6Pb^a;@://XE4/3Q8OY_AOcg:>RT<_3&+O>^;7&HE+Me0J[IL^>:@GN0UGFW,5Hc
QB=Id;9#XZ0?8E))NID]<@P]8I=b_\M@WNc0RDOJBRZ-Y3-a&(4aG3ad,1OY<dUN
X3LX2ecI#=4McGQV]QD9,XN#WJEY/M:5VDC)YOc-C]G)&Ae<4dH0Bb6K2RQ)XP.<
S)TQJ_K2+@;,7A-KIRHa2g>OZ01=6a8&G(fZ,ZQ>cL>6OP.8f<DXWS5EOL,=cB?>
:.V?cUJ[66+)deS3D3M/O8DI@NPAE3]7.VbFZV#5?Df;cZH+B]?YB3?5N.R&DA^1
Ta_7/T+_,f62KH]_c,_K6:;497T=g(0Q,3\e]B?>S)4]G5@Ze4&e@(8^HdVT?b(R
[4c,/TMA:V/_[=XaI6;JgRR\HWI5J@dDHA8VPO2+[Yb>K4N?4HZ\-9:=ePffEZgf
.DUd_LC8+H:1075JC>G,0QcY^Y/]RfDe+Q/LV^,R4b.=\4=D\a\>>L-H]M6GMJ-g
)(=E>?AE,&@N<6I<]/MGcI3_[RLgDIAK^/S33NcE_M6,IO^aLU_ac&8Z0;[M3]Gg
b0aK]](]4Gc&AH,R0-O\fEH8aU,2OBYG9H-V7<5^FLS.P-;LfZ)@M6ObODYWP?6V
X9e41RcP/I?;eMgg6@SXN9NdPFc)J@^CU=TZa_2?.e:;ASHSc60>A0(3J\>c2[8c
JNKYf.#\1UFF>B&PF/:?C?2WXVg+Yc6^V\_F0aD8VB19R3J@>YHMG(XB61bWf/)d
+HfWZ.XW)K6MQ].EP>e)WCMFJ_+HHe[\JXIW4YTHBV16L813L?+SI?42:AeRT65M
QRR[ZS24@d-g^3\(JECC]#e4?43.Q=ALF0C;N=BYdQ0Z&WV-/NW>@S9W4N__bECB
@)&HACUHf[8WVX[D5fC9=GdE.XQP[AJ<7(CW\>J@-ACU]O_(1(K=MP&^_H4VeEJ(
cGRB9[?\9[3OEd#89bDOEYeb?5A]CG--AK]+(KeD9dJR(^/G(<=>JQ#BbP/6(AA<
56HdU1\^fNZ60UJa<S716;6Nba9F;<Q4cL1UVW@=LPGG7S\9PW]F-BVeUePY?.8U
#,#YfJAHS4S:2?H:6S;fRTObLK&eBRD,.[f./X_4B,dg&G7f.aG=6/\T_T=^)W0W
QET/)TLX8WIJ]>4WZRATA<@[)_+:S?Za4H^W04_@3=0#GRLg.96O)Ye52I-BDe\1
U-U<&4D7A/X/S-8dR[bQ=&Y3>I0d[g4)0S^H55+\[EC6L9FB#YY6Nf]Rb0:cfXCB
,R&P\,S1cDc)Ze>PJ>A>_bC,4VHe\g,-/c94?H>?e<5QQ-6VUO+PI0Z+2Y_1&PWI
_X9VZ:]-(\[8_.9UP@2K2gY:TS0Pb2A4YgUb.JO@KMF<eUB<UNc#K]_<KeQW[Z2T
d><HP]QH>=\dPfL:^?6:@I#A7^b+b[1B)S^-CZd\+;Y->RdM#D-=XcR[&cQ.>WV7
O1[ggX#T<Pc892Ac2PU2g?gQ)6g,:#_c^+Qg5N9Z\@(ec9GdZ8Xgc4CUN>(?C1O=
>3d?5g[DEI5-3P5=QL_eYAe;RB_c#]@Wf?9BgGT5]6YCOO^-76]&5N<d5ISQA+6)
e:&DECFD9,(2UNaAC2/=/9R&5<@Y.J>_c;&b>DCA3:1>D&F[JAe.a,7.Y5J3UaHP
/ITH]3H?U<Pe0BNf-LJAK+40H6g?JQXEM5_V+.S5dPX9PEI9\J?ge7Y\3Wf9;cNP
8,efA]N<E.<J(QF+JL6[D^Z)a(Jff,O\?_10D-+&b&P(e9RX^Pg;_XU?aU)ZXAd0
a-cI6dG\\^(A>FNRZNcE9_51IP@gR\(bV&Y\d]-^U8@#-?FfJH,X?JeN7]eQCMR_
Hc^VGLJ/B<WgYS+g&M1HFdT8E_1B@_<aEQ]9.X#;E;[:a&Q9?.X&S8(V>336(.-d
\C?@,739;5QH7LE?P9BEO;XUD0-YeHM#Q6-:cV9)1<aN4RdH=UEY94<X6VQ2A:>M
GIV+[e_1IU0=&#>1c>0B2Jac#A7:;Jf,30fb1e5/N#=-(Aa^8HL]>M<R57>#<=,H
1C:]X0Z=8Q;6:49E;3^UcIB8d,.XWG8B:05Zb_g<8S9NH9H)-98URH7[9a>0B+B)
Y6;YM;T@Z1d=b5(a-2ECaVc<b>&:-(53c7LQMH.5?9-+[<b=UWVMdg?1?)a[+_eZ
;>C_a8<JL-;I.1+53EH7aIQW^R;VBB3MW5RRV<^.)4H&<A+aUaQ;/Y8EOS]3BT__
[2/=Y2I;&?Z87[[N\Ub:-W^2T4Y7V3_\J&Oc6TLEYES.99Q+9c8(=H7B#AURg2Lc
.\>7G47gR0=F9F^bL==+?HNf?Z_D0TUc,7^+Y7H&f>bNCB3/ET:+[WBHg;N[>c-&
c=Q))VPf\F4NNEVAU_-Y[#I,b3e6UOGI\fFdQf45gCY<e[54d#?.&CGI&=#S8fa7
<C9/>X<A6:;Q-De1DIQPEW[3.KEY#LE[IM&WEggQCW(M=.C1.c+fR]Z49)7&(7eK
I9Nd4TD1E>1)BE+:A/<Z7YC>V3>H(U=8U;1C1g0@&M.96\#Y:.IO)U3#4#@IV[WC
9]M9P(^daD\B47<JNBY>W6W(3a+2Pg+J_Q;WMO+a#R]6G&5dAdcbb;2OXQRc/&cG
O#^ZP\PP3HGIPG-ba#:US1-]26K8VeK(U0U5gI#;dMa_g_0gfQXP^I/g/3V4L]CR
ANA;g.A:R9UbN7+8\5O5X+L#R/bgJWJaN5)Q/?]/Te56JZSDfGU73;/DCVA)FE]P
W@cK17U2(PdT4\^EH3;G-(Lc7H&I3f9777XMKPgPR)ZO5V0:]D,77RgS8A[&6ZTS
fVB\/=e-RK>?K4^_O@SB7.YVPS0G>1[7+LIK5A0e\(O\JZ+?H?N_)VWd2XQ5#2U/
D;0(.)-XfX55):SZ6C,S\B-,/?Ne4EZeGdR>dN5PZSJ3O1Q16G9<46TG(JYPIcQU
[&Q]A0Ug[F/3?_E1ADTL@2C+L]\c\<,E892GgD5WP\..V/I8C+>>_MW&A)YOFe9<
[=)S^cb@.g@M./I_\IV3N&Z4)(aa.KSGe_^eJ-C=BNMI;bU.J=+?#/1]4cV[d)WH
e5]:7H;]f1;<TV@FgS\U/-GO9UXPZ#VfZD6:_gf_Rd0Le7#WXE:a5eA),0T([<Xc
XPLK46ZVd0<)5/6eN3@8W2JX0g=@.A+2:.XB/ATN1V[MZ9@AC_+/?4-cdeO.?:DT
>FO&U6b=aVaAecAQ(5WP4YP5d\Q==gK_F#g#+FQc/50+,P)QB-6J.X,-3bI^_PL,
&AO&/\&;?::#c+^-_1cFf\KW?6(a,Te\48K^E(T1.X^F#MDN3/g-U6#aXObZ:#.Z
]9Ag>SPGSXdRNWV/HD?.81#N?R/[LZ5f=F)e0-UM5_(^:B:A<WY)#aBS(,AC4)M+
GDJ=2AK9c;^gYeB4Z?G+7g9e#b.RHK0@/a6(B>RV5/^\/:0a@1V199G0ad3ZXGQL
=S,7RgCIdD@dc&F-3N5OLRJ]A;P0\+L6^V#L+6-HNNT-Cc2TZV6[:GHW)\?MR-f.
:DF3T9OE]?EV8/BYGZ0PEC)W#QBY11CfC>3,/+T3-Obb?a3]A)I@5U^(CCQFSU]W
^[M@c,N])ZbW[RFe8>A=gL9\&O8a&@TZ4)PCNX?8d6c(+,E^\7Dd6Q<2G\C_9J=:
VcgFPI:0Z2\MQbS+V.N;7IS@.V(1^[)]X<=(gKcDeG,b8:.(;XX#\H\K7?-M_N0g
_F1b@2+f&T06DZ,ECF=DIR2f06D89]Bf4T#)76ADI-7e4GDL@\Ke5A55IPLcd&XE
V@HPA#IAY]=B1USO,8,;0=1QF#2<1EIX6V9X/FJ>CZgEB6:R7g=Y0RV9S\-bH.>6
XZ8SfY?dI)==71LOX)VfM:_TXYD9^UWU#dIH21#X6EA,RY&5B#U+X-b_CAeW.TAY
BB.a/6;:>g9d8N[BE<\Z[2ZbIIga(E-4+:1@C-1NSTK<H]Y5UKVeW_R,F:1DUR8J
@d;Zc?CK/#fb5U@Kg(;.M]g4[a5&MCgO2,gZR.[C(IOF./<ZDeIPfbX3X#KEa/ZO
HV\-D#XaM;-7UHL@IL-T>/PeXP,XE0XGI,?Hd8DB52bSN\#;&AR51_@?;J0HF/[c
SK]1Re]3?:I_R3G@7,bcSE9Pd.1&CA4c.1]HSO?NVJ<g[gY;/53QET\>&5==RD]A
\;@)6M#FY:fI,#,7Wag&V_-4B<^M?83#R:RQed9L;I)E;H)P+::C-\XRf1,A^N?W
f0^9UdQJ,;C>6&O^\@YEW5]8OP8ANJIPKE3;5WF2[V)46I\5QM,6Z6f0(SH1H3#7
I\+GgN8TJ\d8GOU@>VV#7c4R5#OTABIPf9Cc[.?06L^WQfdA:<^\(E:3.8=^F2gL
CHS07\I8e12_=J31TcG,A^<@PadCG;fZ_HK;]-9(.5N_@W).3Z=@c1,P-+W[L2.8
C6;AS<WU(34\ODLS[KdQf=<7SNT(-H:NSRf?HF0TL]c=Hc;J[CJ4g=c(DCV]NOU.
[11LcAE10GbSL2cL7#c[&4^T_7YEU9)LVXQF?PNLFTNO;Ac\P9g&cCH#RHGS+KRd
N,B0.XE;YK-c7Z>eLG^.Pa.5HSb8L]BLc/c2c&/W-OSPRU)6b-LLYEIE;Nb8-.VX
?)?@XH)Dg/g5f[+6+F_g3+/]UA8[-YG=)bUGYcV,=E&fb4#XfWXMF2AEO?FG]R76
72_L@W8(S:dR(,3;/0e;9fTGV?Ga(.cU059DPW>IQCcOfN<FH\V]9YORfDg)b5cD
.Q35>]D0D;Ad;<WG5T(A/#W@_)[16.&0Q4[Y,d&7.L>H#B&6b]O9PE4b85a,GA[9
gL&TX+cCTaA&QQ[cC0VfeQJd[gUCZT^?=CC_@L<^_3aA.Y^D9M?8GbZ+KM58HG&@
=N<X:/;<01VS22O?9Z6:LU&B#fE-TL<EWT@[C+9(eMDa@]I=)gJ9G]O30\#0:cH9
>79T&_7ZB1JMF\\7(ZXE(U;SZW^ggN7>,N85de1QHR6\XO]4>e:\Dg=aCC^Bc[0O
dC=;a1a:+\GMEF=8.85DJW)X@M/YSTO\<egHVGLV]EBg9:>,OAH@1T5G,L\.BC6H
C6dd\7XVJ1aAFCH&,a76R&Z+\b_g-#3^ZAFZ.2WUYKb3MYaGFAZI6>c1NbTN/NLQ
HUK4KR/TeX802C^D>R,BC.KNAM_1[XgNF4OFb4@6=^c@038PTgA3>KJ]<,.1eQbL
b7<C;A@?&:\]2)bZ-/ZC<^A6_>QI[AR,#^_6U[d;#FbN9c1S);4_\ZS]Nf66A<H^
;.[C,fA5a79O,4:b)5?(7Q-CHDYI8WBb44SLED^/(WX;FW:7G29b0Lf/;Y&+KI]N
Q.G;SK&YSTUg]3QV@g?,,6df5#Rf,O,@6b&9)cAG(0F-]I+7X2CTfTVO+9RNKSK_
_([.8MKT50<CDD7FTU.=PW(.@OaIeFN#.>+=Ae^M^)LC+XPGK2)#f2G;a58QIcgI
fQ6.dYUXG=PK=TcH4-P_G7+a+Z:5KgTIE?S:f0C?5TPL#2VFUNU-\0EaK=S?J>9<
TQ=Ff+cQ@-P0cWb[Z/S[Y>T@#_4eP@/Q&PC7#E?\e#&e-L<.8UNL&1;bIJ7;8Q(_
52YW\W?M-59:g;&S3bOX?-e-[10>.I[P,e6T3bIRS-(LGHVOFe5ad<[)CN&>fZKG
geU#R7_[9UW?=4.,PC&JPUeQ,:73?.ObgB)5X-2=\TN)AS7@W2\:V8+.Y\9,HE72
DFXdfN#aU>D5?_N;/D])J^T9(^DO=^6/T.E-13c/[MdePDf=M1K.?g;ZR6CHPV#]
1862a1<)d-296RX7U<M^P:FO5Gd27a2KcPc(8@/d\IKP7VRB5GK@/&2=H:U<4.(b
aKXY1YP=<LE#<8c8gGaD[5CWPLIF=];O+T/8NHCNVO_5,LE=_,\2]@(dUAHU:C>H
:HP&TN8f@7Y:R&fX;<^0g]G(+1\^W:a8HbXQYS&[IPe?8F891CH7C4JCB\Z03+VL
0.gBV:RMQb,:5>/XDR1M=1X/<0Hdcb5;L,,HUe0RU9>+-RXFEV_H>[81MagT)bIU
#L,PV]g:#-e=0MF#;2DfUR)(2)YF9WQ4#\K6L^bCdYc#]:QOc>W<QVg81\01NS:I
9^D;(#7_8FRG,b?-K<W.C-MAb>#_Mfg84LWY0G#)cC_H@4U<#C>6Xa,TbP3gW?c,
8CPcID#<N:4P@JQ8\[2&/I.:Sg69I+dM^H/f=f(QDbS^]Q0g#cHDDdUF2@(9ABC1
=Q>2/F))aA/7O8K\-AgP+XXa;\PN3U?_SW0Sa736+6E4\JIYgd_a>Y9H9e.g-:BO
<TD1Z-P0WTAJ>_Sf98(3O4.UDQ,f2J7#eGRF/]N/[?V/4P7\^_.HQ?aJ#OeD>/FD
[\M.C6E4>0CQ#;D4+5J)X@SN6;N>X/@b^D75V3OSXL4cTU.ZF<]V\>5-=JAYd/4;
\HYN.4_H)X)<430[AJ)F5K[LVHCE:,DBO,Pa(C(CQ/e:Y8g^2C(QLR+MHHQ(8a6c
EQ)0+4\gfND17#(^I/8B\/O)-GRfOKUEUXDX.)HKQ<7A_9YXb:HP7C+;CH^G>H4f
T#40?5M9Ga^M1g+CNB8OS+2B1.GM58,8#HSOFTOK3[CfADC=-ERfWa_WQ8>_R+>f
-e_AAf13.W0YBc<JU_DaL@_gBAe_=bV)/+^T^XNfa7<2)>(^T8?,^),>4>,3_b(C
3Gg1X08,bJQY+$
`endprotected


`endif // GUARD_SVT_STATUS_SV
