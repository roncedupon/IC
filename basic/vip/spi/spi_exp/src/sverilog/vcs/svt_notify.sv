//=======================================================================
// COPYRIGHT (C) 2008-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_NOTIFY_SV
`define GUARD_SVT_NOTIFY_SV

/**
 * This macro can be used to configure a basic notification, independent of the
 * base technology.
 */
`define SVT_NOTIFY_CONFIGURE(methodname,stateclass,notifyname,notifykind) \
  if (stateclass.notifyname == 0) begin \
    stateclass.notifyname = stateclass.notify.configure(, notifykind); \
  end else begin \
    `svt_fatal(`SVT_DATA_UTIL_ARG_TO_STRING(methodname), $sformatf("Attempted to configure notify '%0s' twice. Unable to continue.", `SVT_DATA_UTIL_ARG_TO_STRING(notifyname))); \
  end

`ifdef SVT_VMM_TECHNOLOGY
`define SVT_NOTIFY_BASE_TYPE vmm_notify
`else
`define SVT_NOTIFY_BASE_TYPE svt_notify
`endif

// =============================================================================
/**
 * Base class for a shared notification service that may be needed by some
 * protocol suites.  An example of where this may be used would be in
 * a layered protocol, where timing information between the protocol layers
 * needs to be communicated.
 */
`ifdef SVT_VMM_TECHNOLOGY
class svt_notify extends vmm_notify;
`else
class svt_notify;
`endif

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

`ifndef SVT_VMM_TECHNOLOGY
   /**
    * Enum used to provide compatibility layer for supporting vmm_notify notify types in UVM/OVM.
    */
   typedef enum int {ONE_SHOT = 2,
                     BLAST    = 3,
                     ON_OFF   = 5
                     } sync_e;

   /**
    * Enum used to provide compatibility layer for supporting vmm_notify reset types in UVM/OVM.
    */
   typedef enum bit {SOFT,
                     HARD} reset_e;
`endif

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

`ifndef SVT_VMM_TECHNOLOGY
  /** SVT message macros route messages through this reference */
  `SVT_XVM(report_object) reporter;
`endif

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  /**
   * Array used to map from notification string to the associated notify ID.
   */
  local int notification_map[string];

//svt_vipdk_exclude
  local int notification_associated_skip_file[int];
  local int notification_skip_next[int];

//svt_vipdk_end_exclude
`ifndef SVT_VMM_TECHNOLOGY
  /**
   * The event pool that provides and manages the actual UVM/OVM events.
   */
  local `SVT_XVM(event_pool) event_pool = null;

  /**
   * Array which can be used to VMM style sync events to UVM/OVM 'wait' calls.
   */
  local sync_e sync_map[int];

  /**
   * Variable used to support automatic generation of unique notification IDs.
   * Initialized to 1_000_000 reserving all prior IDs for use by client.
   */
   local int last_notification_id = 1000000;
`endif

  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_notify class, passing the
   * appropriate argument values to the <b>vmm_notify</b> parent class.
   *
   * @param log An vmm_log object reference used to replace the default internal
   * logger. The class extension that calls super.new() should pass a reference
   * to its own <i>static</i> log instance.
   * @param suite_name A String that identifies the product suite to which the
   * transaction object belongs.
   */
  extern function new(vmm_log log, string suite_name);
`else
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_notify class.
   *
   * @param reporter Reporter object to route messages through.
   * 
   * @param suite_name Passed in to identify the model suite.
   * 
   * @param event_pool
   */
  extern function new(`SVT_XVM(report_object) reporter, string suite_name, `SVT_XVM(event_pool) event_pool = null);
`endif

//svt_vcs_lic_vip_protect
`protected
V1S75E&M-9C?=a.AO<b7LWLF&?T&GVK152L_a8W5De<+G._c6P7@1(AK+9VE]GD&
HXCZ^WcR?Vd7@S)#38TB=?\8\/6baYSO\:-&KFV,C\]cC(_9;W4g2M_M8UNKF_1:
PJ<.d:SDR?\?XIRU_d)6X14-^I:e7548eZ=FP1:))@^R-E?Wa:JUf=SQ4ad_^-(U
X0cebK\S.:A(\fZ92R-E#96K:Z>>(./@)K,UO+UdEC:aC(-WfE[TD;^gPUMSR:91
e.[#,^GRT\+,X.C,59Z6^dd7VK](b>1aR/<L:JGZE;XY#d(@:@2;SCE[KXfIb3+1
B^)0C+VD:1Ccb5G@Ea=>7N6?63?b.bGSLN2?L0YT7/7XdHN2]^E52Bf>I/7+f9VX
U]-N],;JCO-5+b/EG6LER4^X^J-9cPNdTa7dDK)/_?RV:g^9\&?1#VN3?S^<E4M]
0S&K7N<Y[@431WYXNRbIDLGfM&J2dM1N00WSJ_=.S+aC3d19MbD[bbT4.H@N3B^f
/.eJWF,D,I6f.>:]GNGL?=-;SW^6eF;7(]YYC]74bb&GFB6V:bZN?/;f#Y7B7?f5
J\4X0MP[RTaN]H=\GTZeFSc;aLG#EK;[04e0T.U^(LZ[8fN\)WKGSO.b+PH3b2.7
Fc.VSW][eH21V]-3I1C3C.@IVUEIc_N+<OEOgaK/5a_.2(A-U;=>GVT:^ZGZY]5d
?W5L.5NCZ.>&KgL4V+)..SgbdRAWPX[P?0>d1Ec8=a(.]:+J)JYJDI<L?_MVU6[T
#01Uc,N./Q52&//gZA:IA)=#[3<WW5YL>B[=:b\];d5d5?Vd-B<0B=.5YfLN[fUH
Y(L6/#M/=\2UGK2&E[BI1W/(_K,ZKKg)1#aB=8.?3d\AX8NW42RYb8a2]@>=?/\3
;If:VfVDfP-Me(3^DV:;\,+UfgJ3AQ:JHJ?-aJegP[4&+Ua9-<4;<MF?H-QS&XR.
#AQ?B8O]Lf(&Q2E1LIfXMZVUY/CX[<>S/F\8+b8AWYH>-WCV9J#a;LGcZKRfQ\g5
&0[>8#72;>F=OF,QJ6/&ee7>,L&78LBB/AVWM>28_\W>E$
`endprotected


`ifndef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Method used to configure a notification in the style associated with VMM.
   * Used to provide VMM style notification capabilities in UVM/OVM.
   */
  extern virtual function int configure(int notification_id = -1, sync_e sync = ONE_SHOT);

  //----------------------------------------------------------------------------
  /**
   * Method used to configure a notification in the style associated with VMM,
   * while associating the notification to a specific UVM/OVM event. Used to provide
   * VMM style notification capabilities in UVM/OVM, tied to well known specific UVM/OVM
   * events.
   */
  extern virtual function int configure_event_notify(int notification_id = -1, sync_e sync = ONE_SHOT, `SVT_XVM(event) xvm_ev = null);

  //----------------------------------------------------------------------------
  /**
   * Method used to check whether the indicated notification has been configured.
   */
  extern virtual function int is_configured(int notification_id);

  //----------------------------------------------------------------------------
  /**
   * Method used to identify whether the indification notification is currently on.
   */
  extern virtual function bit is_on(int notification_id);

  //----------------------------------------------------------------------------
  /**
   * Method used to wait for the indicate notification to go to OFF.
   */
  extern virtual task wait_for_off(int notification_id);

  //----------------------------------------------------------------------------
  /**
   * Method used to get the `SVT_XVM(object) associated with the indicated notification.
   */
   extern virtual function `SVT_DATA_BASE_TYPE status(int notification_id);

  //----------------------------------------------------------------------------
  /**
   * Method used to trigger a notification event.
   */
  extern virtual function void indicate(int notification_id,
                           `SVT_XVM(object) status = null);

  //----------------------------------------------------------------------------
  /**
   * Method used to reset an edge event.
   */
  extern virtual function void reset(int notification_id = -1, reset_e rst_typ = HARD);
`endif

  //----------------------------------------------------------------------------
  /**
   * Method used to configure a notification and to establish a string identifier
   * which can be used to obtain the numeric identifier for the notification.
   */
  extern virtual function int configure_named_notify( string name, int notification_id = -1, sync_e sync = ONE_SHOT, int skip_file = 0);

  //----------------------------------------------------------------------------
  /**
   * Gets the notification Id associated with the indicated name, as specified
   * via a previous call to configure_named_notify.
   *
   * @param name Name associated with the notification.
   *
   * @return Notification ID which can be used to access the named notification.
   */
  extern virtual function int get_notification_id(string name);

  //----------------------------------------------------------------------------
  /**
   * Gets the name associated with the indicated notification ID, as specified
   * via a previous call to configure_named_notify.
   *
   * @param notification_id ID associated with the notification.
   *
   * @return Notification name which has been specified.
   */
  extern virtual function string get_notification_name(int notification_id);

//svt_vipdk_exclude
  //----------------------------------------------------------------------------
  /**
   * Internal method used to log notifications.
   */
  extern function void log_to_logger(int log_file_id, bit notifications_described, svt_logger logger);

  //----------------------------------------------------------------------------
  /**
   * Internal method used to log notifications.
   */
  extern function void mcd_skip_next(int notification_id, int log_file_id);

//svt_vipdk_end_exclude
  // ---------------------------------------------------------------------------
endclass

//svt_vcs_lic_vip_protect
`protected
/^=<..,)DY4]SebK(2_T#T(LG;H,CX@E#:Q4IW1P;Y56YUdFGXV<3(/D@-9;fXd;
AKd@^f;S<+D&/aHM]KCdEQWYMPSd5dJ\7=[)EeX205.5\ZUb9I(O4T,WUZ4fg#F/
H56,NU1a1\(&42K.+62M_20\[^9+G3Vd\)PFU[b1#ZKPB7604YI,@I^QHCF^1ZHC
,NAGS)&F]-cQE:93)f:/SM8:Z)c(=MK,)O@+A?;LQ^7M,Z9?LMWXcJKOL\[J(9DP
d1<1a2ZS[+MLbDKKN0X9]G?UI/R]?NgI\ZG#9.,X&Y+JZDMc9DQ5;?IMIB9Le(E2
@Wfe>>dPPJ2-)a7CE4&M@>IT\C2f-1AQ8]=C&);+7-5A#Ffb[]^Q9I]S0GQP(_f^
6<WAH(\Lg@NMC5FeFM]23,6b0ZU,QZ,)]6.@b9c2823-1)gC=7BAd7XIUJeH0<PU
,ZL)MbI=1V@d/-R??dGE,>X8GH_MB2H#+UO1C69:6dH>GS/P><>]P))B4aIJ:dD+
beG,FH+Df.QDdSJg,Yc\-ONK);(C1U-96\WDQH3HE@RO9W]9#BCY(CQV7@KZLO@+
F/e7R]<FY2Q@>Q03?f5d^E1@U];Fe57edV,K\SfQM&Wg\((20L1E4]GKL+[8-7L[
UCR/1OIP\H[eH-4QPM,81G&J5YWfQF>)_A5A8+J[?4(0KJ4e5KB.N?L8cRF676Mf
+04A6&1++W\36/V(9EX?8WMf[R<c::)C85D1YMWNZ6e#e35S[SO0eO+g:H-:YTPW
RAe-^?,4UMF7X+HVYMAFXLQ0K=U4CY/ID4P90C:D)8[<\dV)e5PZXUHR\\bXULcR
OU>ULEGP:-481GQZ).MG/+\:Yc<^=ZDES<?^?d<dT?C&aT.301Je_O4#4N4\9=HY
BKcI[=J&Y5\WO3:+(/H5;/(9ag/8Y4.^cG=#1b&DL8WH02-K,^5/>Yg@?UO@?>,)
VQ4>/D@cBP)EX2F+6&7]F#>BRdASZ3N67P7D7cP>9V=OAW0_[R&FI6d>-D<;A8d\
WDa5N1.@Gc<7-[QW,\IV4EX\_dDO:7H>)dKg#-RcX#9.7PbTFVK[BIaVLd-L3+Te
^G7@9BN^3cLY)>&S8)&fG4g<2cM5d.fWN)2\?>9fFQ0g#IQ22>W[-e06+4+^f/)3
6dNe6PN_6<7:);[8dg76,IAHe=P8cGB@A9#[-e3HO9e2TE:#57G,\3cFb]4IP@R;
d.&CFL6@T,.C+8&?7CfYPE,TDN3N)1C/?Q=>E99.V_\aR#ebY90OG7XbXR+Yc(9,
XcCg)3bHa?Y3G/[5C<=&VED[)6:]6c7JJTIO50O<3c5M789^)b.)J5DD3A06ES?)
)NBDeG]_R8P0+AGU-JG?S1-5]:P>Sgb+a8P1#/0gI9;g4<_M6&[E]AMeS+4?;&Z,
=(=(A2gVO4?<>gK6?G7(4^\9XH)E5QS->L3>b=J-#8JSXUK6#6Ngcc]?JYW-72SC
>\QFN?HP.\30e7YZ4GKF\eO^XZ2f?+?,WN/eQ4a7GWR4+#(=/>2GAR6Na]8YHNAR
/02-@0.^J#)+(.>FORQT]>U?KC2,]JY#AW04Q7\Q6-6F.f2ef5#GA6BGGDHU=)B\
B8Q=)BE,1]:]5=?@D5I50G:A-2:5KgMO)BPZIXX+W\eA6P]JgP<M4a+9;F/)9@JW
PTEFUXD3@T_=.0M;_SJ8;Y=Lc4)5OZWR89\;0)V-H\(3]bDN4H>Z2Ic:<5ZCY;>4
M,_)95XV229_8\>?5WTI,:6e6\:]:9F3]@WBPP=-/1?H6B#gCX:LDT9=#;[Y6[50
D=1=GERc9/>&fIfN(.(??Te:DO;#=68b7/c)[9eWZ,3Z+RI]TDFGg43H8+,a+IEY
_V>\#1B]X>^Ae#1VR:+e&O0M&[X;Va6V-8[AIUf)GSg<+8+Tb&Y\aR(VMHD[?S\b
LQ5;DMU<?fCOKfYe[@\=B3:]N,[#J?^6,S0dX(II@NJI>M/gA=b)E^M_[=CHTQJ.
YOfa#)AF;>Nc6f2<XSECcC0[^:;.Q8(/P(gE?F^/gOGO5a-A[V4]8JbF\^6,S#L,
/ZN;8>8,2&[YF.J0,8Y4JX\,a.XDW.6)=WA5EDC<]@.C\#Y>g=;.Z42<51gOARIL
\M)ge^Q:WgW.S4#GX\HWZd&^,:?Eac9LE>S6,T2(G(DR9gP\:8J9@]RP=3bCXNNL
.BWS;K5CfI3KdP=G0NQ87J<J0:>2DB&(BYM_)X5IP5fX+26EA107b_Z0UC>G,&;9
\g6>L[HK:DO8Z(<D3YVc,8&WW\J3QX4YQL-;-1DHY)Q2L4BCHE&7A2=VDBDgAM<2
E;C]414KgUd)b6U1-NO)3^#/^Re/P\b\AJJ[-RP@?=B]QdXY0Y9MT&4,/^a[\HUK
Z2(G6XJ,<2YKYC4f-LUF75L]L2&#9aNM=9Q:<]\\&1]<N#cc#F5_,OfS4:_Z8@AB
e]MK<7X0=<F27,DYUg^^S?BMBLB:c\/60NQJDCGH0@\@EK],NI(+]SDfFH<[N[03
+I=&_,&U3;\HXU_D<CIWa\2-UNaF6V]:S]Cgec41>5#bFS:,::Eg_K6,RPeRIW+f
V/HMS>H(/7H8Ag#?JUdU2?9Yd90cfTDI)Ob._d>/>X<[W;c_d,XKJfaF(H25@?;/
D^4O9??NO^Q[>0W(CW#FW&=Rb?HPRZLJJ)KC_ec<Z+OCbP0a1U2BK>V[cI:E=>I?
(2#TR70S^,)ZQF9e^=-W<D2XR3600M?e[/T7X5?8A:YN;@>;/H=FT/Md2#]-THS6
F80,aQa-2@^9bD4?HA)SBB_eZKaae+2UWG3:&[e5fYaXegfHcU2]AOZP-T-L)Y]L
FW9@2B[=(WX6+dNE-d^S5;&;.WK[3JcS=7]]E0e2FC0f,)+YW^5@94/Y@OI[0[8#
R1[@A]W42F@,>&^88)9[Mf3)]/:A(^8:)5TdcY,@37_5@e>T^b2<4>@C1_\HDYE=
T?A#00:=J^Y?5VP&VC\b(2cfI5D_8.0QCb+5)5.(-Y6&[a87J+L_Z\e72)OP@+PA
e_CM_MJ1P5Pcc,+Y:?1]32BN.&63,)2NI79OI)eV::DGXA/]\(L(:C9a8&K0aZZF
4&XPg0HITAP/+SJN=6]cGGILVaX4M,:P(8O<LBD0NfOSHM,P#fAUC+T4<_Z4:O__
CC;A:=Hg8J1)fdfCWO<T+_<LZ=,Z.J-?UWfTU&c2Q^Wc+W[NI_]UV_,JV)RJ<0cU
M6BULW2:\;;HVXMYV^W6g=H[>,J/,L:L3Dbc.:G,J2b^+b9S4AfKE24\MA[67FD@
Z4JE3c0+JZ&@[FDWK<L>12:WZ)#:=/+&H7g^>]BZT-Wa3EV4DMV\::K:4Y>9\D/F
O#QGS=9bQT)DK((#CR^=P8:@V38(dTJSL(S<=5R9eN4X>3<d-E5\-HN,>P,=17,0
7O&O/<gJb;A3TH&3^PE_=\?R79?,;G(fb6HI&HcbI8#Y[-eI^^6T/aNMgP-\P.gA
\I\37A+2[b66#cgbNSO,K]7CMKfH85WWDd--PS:P,eBGff@c<IQB.@/aMbCV?A?0
FD<5\ZJ[[:AQ:Z5^W3_B+;e-4YZa]V(QaP);-1=(>,?e5+^e)P:J.(F4#Q9F6[N-
1OI7C)Zg7G,[(CgSV>79Jf0[?AN;a#33P@c/ZeW:Z=:]]LVG4U^E/C:V0>IN]BL6
4g?_2+bW<OaMH((7+c6#R4_7Z.&UB+:]Vc@fOg>+>A,T9DeL:0#Z8K-VW8Q)\O-c
]L[Ma0C=++6,1@3TUM&=@ggX>7??0Mdb7\E(R.-]YC-/_Og@>f]ZL@LHcOaLZ#^e
V+M\;feNbgD0L^HG45BObMM0baNF+[a+I>]#5P)K77>#CD=3-CeP>gM+)GIX]9R,
R0<g@AK5YV89/-512>0ZBL-]PW:,.\4>Df[cd5[<8-GN-I8e.ac@5W338?f4];_Z
2,LUCFFVQdCcb3/3A2().F><8,=N=P[0f\Z>#:X\aZcfg46&0Z45Mfg^P9G_7G=0
ed69#<C&EdGI,V7]0cbNKPO@ON&N7?B]6I<)bHBBT<8<B(<,]94JBb#)WO/f0VX:
F,.ZLII34LJ\&^O@a&/XT#M0@dbgSZ]LFH4ce^FcZ=cZD6N-YKfRM=UZOCc2C9WW
,F.(2R6DbZ-FI](/5WWNg.#XI;/@\9HW5UQW9MSH_V&_?FC\.c01/[gc<VX+(W&V
.34aMR(23/?]^5/1Q:^E.L7B,SYM4;9E:BL(,/WMCT\Y0D:5Sg_0EL>1O&4ffZ(U
(D15_,4),bMaQ/>:@HEU+(AR;8IEE3UHC#SbeETD0IUZVe,fFS#TUHb#P5a1EPO)
B#8T6gcID/<>e0D+3)0g^,B2TS@:b:MgePV6IYQK+@:7M<E-LCMaCE>JB4Y3JM#)
dO/]=/\DVXe=<6+^<^6&ZX9:G+AD.f.TZ(XO9RR/^#MOFbN>M;2O097(0e2#?NM8
\RL/?LX.AH\5OTC+I0Kb)_6]A)b^d+[c9Pd@^_[EA@1J2B13QZQPA\d=FI[I6V3f
]WdWYYK7);LSW068LQPWe]Jc2G7B[LfIW,-0dQcO:9YR)ZSe@d^b6DNUP2;SZ9M.
,ag[fYY(<I29P/c_[^^<.>c&8:eN[EM2[)bcD^.>S&1GbQ@42UgC8/agZZ7[#QEV
S&[5f<6<F@M]f^J/G4IcLM&?HRPWfdU#?d?M&6a7)J4-YJdBc3Q1_+L7)KCA)?d.
HU;)P45E9LC]?B+ZfW\;cH#]E<Eb5Z_MB=W9?(WW](:[]OL(5R.:Rf]f_HM:#6gc
@Wg32^9O],V>72]BHA6E3]JYO@c<J=?IOA5J_SeG<IUB^Q1#[ZGL-JCEY32=T/)#
X7QZVX/c9#A(YX&eBTSfWRLKY?A)/[bFeE&^1):1(#263XYDSB<]&G4GE13TCgB6
H(^(>]KIdfSWG=QCKgc7f[:b>e^QdX<(X5&EQCNE2T:06VI#fYWUJ>(I0B6(T#N_
-0LdDH2O9B8;^T9dN,CS/1B7V\dUEP9BB.We6HS^>H)d>9\:)//eRG\Z8.NE.+dY
)?e^9?.P)ebI9E]TKID)9U8[54@H.=2Nc?1b;I/QQJO@)T_11F8-&9QV<]c[I<^9
;NNOdC?BIG\/]VQ9?H0#,,.HBeP-2e4e>gKT,bAYWA21K)&6>G.VY,Y>L-FUYHPf
dfW&OJP(WIG>#e>T:>V0(^#=BS_[b9E.3D@&@]5K;C[Ja#SXXZUET+5)e=2X,=E/
HF:/6)7JaL[1@:+1<R]cFZeE6#UYee?6M6YX\X3fSHeA<^\SbO>f:OaHeG>;ZT,e
9SDFTJ#b9WJW@\cNY6Cee=(D_X7b/6#a25d=5BL)UK2E]AI.N((AGGVL+(=dXK3R
P8&F1+d1De@fV4UZUR\>fJT2C\HSb=WN-f7_^7Q.<fdLIMf/YYg9F]SaHTL&WUc&
Kd<2a9<8@EYEaR+?;)U<(Ab0UC^@#dYM_7baA<7g)/M_Y<SA?Q4)/XZM^#gaF7\/
I_K.CE,Sg3Y9NP(7D;BCJA]+f==LG<L5F\J4?CT5_a7J_>Q1[>O^TaAQ&bTUC7e/
+OFT/5/[CI#;EELKaeH+7ZKR/FZAEV7@6YJ#b:I<f;<7_4_g07/Wd8C6?,1D9]ba
\E,K<8I(_e_)LL7>]H_B^bX>eB-S/E0@E&\=@\=?KR524gO,0SVACB<R>MD,H.-d
H8;(0AaY,C/1ag)PCb8.(\-eUX\;CG4SGO9TJTQQF0R+^22gS;Q)a.8R1@40(X#_
E6fD#gdO1#-g>N3X[HITc)+.)8b0I_6GIQLS\?gH7V[R?>N7]1400_eT&RV1]SS?
c8A:Bd&EMV[V[&3X+F5g;^\6GCG1H3FV-.H]8;-L/B+8;Yba374,dgDYK)NI32OS
5X;9\dH#_4?@HfAZAD/;I.93M8e3=/K0#BZZ<HF=3gJgb71TQe@DWaK+7^DXXbCa
?H=YC7-Aee-R9O_P60.E4>H++1OS5AUgY+PF7g]\L2YG=I,^+R-R;N50fg?&V1^d
9WB^<F8LLLG^<M<G[;GG1XAV,-M7MYA&BZIKa84/+MK;8A\64P_+,ADT]RFHfe1E
WbZEC+Hc;7Pd=N3FA&g6a3<70TV0:;YNF>/)#3<8I_@@JeD1_e8ZSESZd7gS8?4#
T(+I^H8UUL^7]3T[-+^CF0ZdLGTgM:[:X<53e_2I,#^B7RD2.#e(cd+]UV0\Uaga
VM1WR?FT<M/H[,g1+F>921U-O&g2Z/GO2da>f)L.(g(LYHY?@P=&&8geQ#]IMOc#
MaaK@)[AZW4:&63B#&U\P;e+0/NBN3I:#VeJ;W;S@M^UG>#=Z/gMLCLC5_f-If<F
(U>W1E;FTDSJ-(:.,U.+Wc^K8G&f2LA9Z//Ia.#-(9E27OX_?TR_IMYJ2LZ/6QW:
cPbQVeRM?S^Y7.aFYN+C.UG<]P/2?5+Wa<I_2GY,K?FT\XH5:I,-]R,d5[(=O]6A
:UYN;J_#OW9/22aWf)DJSS>=P4,;Q-I9G3P2F,_DSa0Id+IU+R2a(23V>X[6=V^3
Rfd[^@Ua\EB9C&fP1^^B&39:Wc_;KVfS+#dR6SY0+((aZ<]:BHKQCe&Kb2JV-X87
BGAA:,,Y3;NGFYg>E5DDgTV=ACHg/JfF@^11Uf=J/A7ZA,)dDN(<D.EL1<0-cCI1
VQV<bIJV<5JTST-FPLXLIWaJMUbb21U)C>CaU=_2>,J##+7,Db7TAd>WBNO[.,8e
HObadTI:a7YYC:GGT,-4U:Z:.<;]S]I3.LC>bZ[5XfZFH3Y89<Z)O0]2K.M4b@Y?
\#X<<aBAHBQP58.)>1W1-PeD-5&/VE]+dN,bS@XMc,3HZVbBfDg^ESc0QDO.>5.]
4B74SK#8MgI)af9(POXYTW=O^SBd042MVNE?F5SB/=4<<Nf+dLX9^Q6;@?><Q\[Y
?G1;[U<fQ<_?(f]]cMB)1g\,,^F9_#OHR1RI@.d]-N<+3/8[?<Ue#LY3H:H@ee7b
&,DUEC@@V)L--T?N[VdLg,cA/RR[E&9BE;)d[e^SGI#G0&@A9OIV2K+Kc@4=Y&4X
HY[P])#5YY?7QAU=dC>L#gI_6IZcT/=0F(]6NJ-P?a=,^0Mg37K-VQW@M?S_+V3(
HQMK9-BYU?_[Y(NF8FCGL]>&&=Gg1c85]<VQ+6LV2H?F@9&E:JQ)L+A4P-C_0OB4
0U;(CTZZRVJ-(2[4[cD/I=I+A-?bVOI1B+1;SNRBYcH:EK>E<BOgM5X0O+\4<6IO
JHYA8,Y7aUAaP=N]e&Q=T_OS6)g#<[1cS)K8STYW_3b\Rd-d+&RM;P]5bTZ_NHSZ
b8?\US_J(Q[\+:.__R9VOTfOb3&G1Y?YC?eY>41a3eE_@@)gK-#eL4Y8=#0g\/TR
<TaSYG;-1+C1-#gUFW+P5F?aBPT21YIEZ;UL.fWFWF9UO#De4MGS4P8E>]>(6J[:
b+3Y#Ee[EGN>BKSU@aTW7\^dRTIZP-55@4&4^aNAW]32^6g[@9VB\.K,&721H]]P
gaSY-/+HLR.SG\EgKRB0)QE+;+\TM=\c))RJ)D6dVX0/FHVCK/V8;G03+\3WP\Wd
R0T2fY1H80Y;\6PR=0H7<Cc]<V,P1786V7:XP;f^aAKgZ1f[ObcQ:K7SFbNF0gbR
WBGB9:<),a7^)<,g2dCR>VcA\+N^,P,DKP/_eR+N@JL.bK:_fQHg&F#c&R&,-d7P
>SPe&NE]?,&DDR-QI7R.A9@G-&AFS,;-7N@S;AGY)c7^+O,06A65+ZM9b5DDdTZ,
Pe,:H#OIDE:DUPdb-Y_d_QZFPE(++7#)?IDfO80@,Y:=T-cLS,2[NJ+-He,MeA1N
]@5ZdH1YHH,Rg)ge41-#LVJW;b8<HcKL_]&LJc7]8)6JF0M<@7]Y[&39)&\<SMXK
SPUd^YF74W&I0P9C:9\R_F>Hgg4XKc<FHNR^T:1=#-JBWBd5;_a#WL<>N#UJMf1<
8aYRH1[_46g=/2+2RQ0D3DN/Q)VfNdR33-V&RA_-)[X/1#9)fRI]3eCb/@4+M^cZ
X/HU:e(f[#8&>eY\NX_8U@2X53=SCfR,G2](44KX<X>FU\D,gFZV(9&BWD+25#)L
O<6J7#7K:8((5W6\/,GQ&L3K_6A#E^K[(d-R(dZX0_-X2^AABR?>d/=g6.f+HVV>
/)3D_3/:0S)RT6J\gHM9d3\=M7d/&R7OV88H;=09<Z[\Y_F)Y[fa_,LBHL?DUZ,a
_OWCYA=bE?9=aM_JfV@O.#B6V28JFb=B=X[(AJM:ZN+BUg^OI\3-a=7f.g6L45@B
1;+#^,P6\:c85.XA13)R_4&XeV-c[3L)IOV;[=Raa8GJ,-ZB?C+7Ae?[K6b_&aP@
BEZLEFgcFE+[J;/7a6RdLR4cfC]]PZ]:ZWYCK3CFD.e?A==(;6GQ+F3F]c(?CK)A
MeHb,WXSIO],YGQ#NaEV?A=:GPS:[WfT\c#NFLC+S]TKaCCDcJ9aK#5;WMC_De2A
H/(^/g;N+4d^ZFF5+XG:U6E#)(OU<?(O09BR=],b;;6E3@ZRJ073_,_(-bTU&HFY
=6Nd^5&/(ZWJT1aXW@Wd2M-P<T,IR-/.M<;HZUX?X(^/LZ\K=7K6:cT5VbNIe#D,
GO=PdQCTd2]0U42Id.A@UVebTB96VV\bZNIRKB7Xf2B)OUT:#eVgeL)U\8;[D<PA
CDfX^7B,\0C[=+=?JSW#_Z_WBA).GK\F=<(UDFE@7J]Bf+gM1@;9@5KW#5AT#<<T
V]HWaH=XdE.@-Z1&;KbA=V^&.M^[a6P#A.dII68I9P>#CfP_(R9#<>/6U[8[?6a6
FZdaQ[-EY)b\FcJ>V4CK+H7D.RG>,-ae]1SXSO_(\e:=U?^&S4g.(NMZMI[8T2aE
8W\S+f3ZQ_1Y&->dg4D9dX&C5Y>GfTT&UVI4><dfEFFg>QUdC)[T>dc2?;2QHDb[
c?I5-,_=I?#KWUe15.@NM#Q7+W#F_CA[QcR<dV;BXNE&3B.f3_TD2bZb>3#=;5F^
KOf8cO3)&W9#KLbU]:_YJS7@[86MP?0a?[FVZRTTO51LI23?:?fDbO+:L-:@ILfA
+(72?&9HTPUA(DTb-UB5LN)DWHb\<cD[S4RG8B^>ZE(PWfZ(,Y,M:9Rc@?MLCL63
>bE/<;8eM:E>;S,9WCJS#_S)+Y#O2.bO#g)<S_AO?gfcgLSVK)(WMcCa]IWM15a]
Dd?d^5fQ@2XPTOb63,+-:G+VL0:8Z8E:W_?X4J#)Hd->JU;)+-Cd_5J66,GL&9:G
77\K[?)H)g-6],+[RH/cg]Zf78[E_ELffgF>-@SD,a^^,WSS_OADUG0QMOV=?[<V
R[-E4>eB+&BV.4Ac[#?D&KV\9&\O@>SE5+WW,0=2dcH[g0g#Ed=CK1K2MfYUP6fP
bgON8L_c0eC8T/^(T\M0UIM[QJ_6/5#cCO-R./@AY1JRaNdO#?>a2WI^bgWeO/[/
,84/C#H7eM\,5T8Y5Rd2Y?WQHPX0BI-ZULM?c.>H,A8QXKfK@6fR@F&8e6.e5P72
CTE_+,e,1[@@IUd1>SJfXOf58DA0-=P06>TIG:&ZJ&Rd;IU5FbAEaV]&J8]J_.SY
@dD-Dc1J(.f8d2:eBA>G.=SY5.a+06Acd>___6\ITKB.)BdMA8f(\ICBZd&?dB>X
]V2#eQFf-Mf8,81.eSFAC9ac]EUc]1aAGb\??[d-/GG]:WW<(6P((03H>S7/T5Ed
,LOB;0+?)&.S:KUJWGXX:0QdWJ0P[7]W4FeC2fTDIE]T<d=B_7F,Ic63b7R3.L-7
FcSN^fCM/#ITWRfL\B^\ISR8HZ#\(HgJ\Q_d((45Xd:Y>&LU^@HDY3fJ6OY[-Mg0
(Q:,V);aX>eL[<FT#>:,f+fg/Nf_b+9+Sa>QbU#40@WW;R::.9^.Mae@,fP_(.#0
CC0@f_^IS,?:7\,GSb+ee;;=bN[O6Y9=S3MFbSN81U5],79Y[?GZ]91NC?/c_#6H
gC2c#Vf-M//;Uc0c<6_FNF2NJAO^f^YfZJSf^X#VU62fTPITMcd3LHS?J9Ra;KS.
G9a8L.cQdUbIJLUD)LU<.CL>)c)FL^KKBcc-2:C4I)cG[^N7>H_K5We1TP5#(3&3
gQ>L:bA5.&5#.Ia32;a6L_LR0D16e2\GAdfZg9@?<fTR1dd]>a/b@0O,11_]AF62
B)],J\FY(O2:.9./VX,/Tg(>Nc@527-6d2?(MC2g:c=7WcaY;^/6TFJVL0<?V->X
5ScaRUec=5PDf+4_KQ5Dc#>@(H3[&4aF4DeNIb7gRLBJGQMNWc;LNW0DU1L4&,LZ
FWTF:&G2EJ-Zd8&@<a2?P[2bG.Q8Jd=W1^7^(e?-W1=>=Zc;a;O-D;X@._KVXQ0-
/_QGWY<\;L0K#I/1=4c(_\:,Z^7:)f\^C^@+eBb0VOL-7P5NDUfe&F>@W@a=TE,P
[H#OFR&&Q8>gdWHY)?(D1RWI(d-2-+L>)0^6JI#W[?]&H]OS8:93UL(X1@:CSS/Q
O>LEH.f?^6ObQF>\1QSR.<KdW.>>=aMSJf^1ZWe#C2YO[RVAMUM3-e8@fCL+^AD<
Ce=U5-G852X5T?1&ggD8AJbW(\:2MPaZ38)A1,0f<X&c_-e?@BP_.E+9(WUe24D[
)0US+_GF/?/2,;6?+R8T:+7>PDL4^age7^aT7Wg;\?:)3F:HCa7g>f]IIKQbeZ\P
,&NS3<9/^T9Icf9JJ[ObdV4bRV_<(H_>.Nab(YE&KW^@?4__DX50_D0=R2#II9>R
Hd/bWT2TN0T,OLCcGB-@-ZX\&VQGSV3Db@gD+TS1D:0#-:?A),[EHWJY\E&2)dUQ
=(L?IJO[=#M5J3>bK5\B5GXNK6X?EE?NH#ZKH@M-_PeCgDKBTF&/2WOG[=P)FefK
LP&.C,5-B9^;c#a0eJ]OT9\F(QTcZM#a6DM</B6_V@OgXb7Y8gdb6YQF^-e&=R7.
:8(ZBfg^1#DK;X3;R+B0?=VAH7ENNBLV<SB&#=U02@H@AKR+#4](e/cA:BWJSX>W
Z?\(<HL<f3QNGRd@UL/4gAI2A5^>P-LX?ce)XfH<Z)&/^?RKJeR7KO@&ObVZg;)>
#49.P0g<>3NB?45e;RRA4(3Z-TbO/gPYd=cgESO(Z5gB2&E#5Xc?5F1_P+N>.2e[
@N[1E+_Sf71K0K3)4?7e-LI5:eN;7TgKQ1cFHJE\F4J&[Ha+X-S+Se5eY<LO\.U3
Y&77<UO>=B>F9Rb,)@b:LV/NL;\<>(X+^d=dD#/37a.^7dI,\f3cFGE/B#C4W:aF
=fF6CJWZXe&0gD4,N_0^eYdBBgT1c.D@AWb1cH]KBH?=T>JR/N(/cENW-NQJNH.c
9X4U=EO\cJ1>d,V_.Z.ZAQA-dXF?6<MZ1aM?YJQ/&)0S9HSXP,f^e\=bgd[PZ[;=
>)9=UdUWfV&1A^,=P,92E[#=-9[fF7ZbCG6feF\cH<)L0Z02Gb#)e2Nc9ed0\(gJ
;_)Z1-L@;UGQH6KCZUGAZQ8E?IdMR_H_^HRMY>HBSf,NI;Q^\=E]^F(dRQMO.Qag
W6KA=Mc\\W;E_eZdE9&H(GNN@#^[JW/fRaZV7_^@\;OT#JBeDfM:1W<?P3OOH_&8
dB+_V&RQ@aSK)3<ccU#N#6MYX?]gSR\G2V3O&#a49@^aY/([NbD[:UX#W@Z>3Z;.
b:&P&)66DX6UWBYB#RE;-ZN-V]1@-W\9LAWO)T8^_6,=b&YER?7RgUcRM6+7X9;-
X:9)LBKK0@,L&I4(U9gPR5Q\>a6G@8_dCLTK9=>cWD\-1X(FRS?Uf+g/,OV,cc<e
9-:]dfO:R.2O=3c;;UR)a(>\SdTZ=X3Vb&,RfT+X.8gI(+9/-d7,K]9D5C,Md0NV
Z<Yd0E]U@KM37F3]EHE8G/HTZ?\BfTe.L_3ebe4Lf4;BY9f(@_)21EHPQ][)K\DF
2<-Q2WD+3OHXL3ZbgJ@>BA+0#K?eXS?=)0+CG:1/Q@)9fdb12G]aK_67149I(a,-
6;\BOF35IQD4b0+@VUGM;319e1L&d_F74a<\GKT^=\0d9+Jb)Q53We4ZK[/)5_+5
eBKW0?Bf)dEB>c.\8OXIg,^=ed+)M;C9^O+:EH.-GCIagF5FbX018,B/7//J[aZO
D=0(RgQ&KJ:X?BNNMZBH<e69R2<.D>K2;M:Y).1,c\@:=5FX,@_?L=/b;55+73@F
<bba4BaW]<M;d[RFZW4QTS7OH4+?BE1La43DV4f.RDG8OB4=5BBcZG^[dF\Y3D.6
.2Oe?,IJ_O[=be3W/EEE0GB7]NL5USG,J,HL^fa>B4:4g@#7(PF4+.YC]VBI6Vd=
IP,+WF)gFNU@P#NTf\UCd?ATL[eWF3UY8&#WF>Q]3W/IRC@/_ZWNBN2^&ENW]A5B
8JNE3V\ELORN.P+-##RNBY?c[U5QC@RY\+9-30OeI),f-)Y^,0Eb#XCC=7J[aZ8Z
I91=S&gYeUGV2]>59YdB1dC)V2e]++3S,RO6Q_>&]HP)[9..,VDMF))c]VJ;b[BF
;[>;_>dKM^HCPcO3=b9XHK\N=Jg>cc.eYgVIX9FTGVf&S^/[5)HR5;@13OOT?0#1
>+Y)DOL1G6(aAZ(&Qg_b#B:E)gT25\BfC,0J/GFVP6X4\c&6)+3a?bU3g)UAAB(R
=[5S+2BQ+<XECJY:-_:?IHSP+Z<dD=H;8HYa#XCUH3(U\XC0\639aYN=[0GVBGAL
KK9JY#985b0fWe,T<8;#NGZU@D\(2BN7^9VL,VPZ<PWO7H68We(V<@GE^X+dBUQ]
F;_2/dA?(YdA-1DYUO:7<OeDQf;MFLLA=\S#2#]6AFWPCNVa;SfS;CL^SN1-VSUT
(#2CP@4&e&g;H5IVD][<\#X0R8c.-9@e/S,S<9WW7Z9De,6+f@<]G6I^NAC3S0CN
;4-WJc1.P3WID&D\IOc0DEf.P8\g?dJBVeM>E2YR&fJ1C_QICQK6(3BTJaMZ=R:2
N&D1(K@04^(A4B3E--&&,e>5GF;Z[5B^S&\,8JBfQYRR8+]Gba0\d6&TE:7<U2I8
CX[)(c,]Pg4+&^F<2O\UUeA^KR8TDVc,6)?H/=+eM@V<QS-//c21QVeZb^O^@<3)
TQ]Q.5)AR3[;.#C.Va^TSGGc8;&a3>PCKN:-G8JN5B@[H=RL;QL+WGZ5\+-f/8Yf
9D.R/J#Ne9db:G0P/U02H?=\UAO4NK@QCQS-SB_X]K-NEIS]/;GNZ?/F70OSZNIS
NDQI\^\1^VP(<2VZ8\,)1REQKLOc.U_d89(_FR3SB<\P8OYd4ddA-A-RE\#LATcY
HKGI]D(,e>V#LL>Lg>#X&Xba6=42+?P@RaYU#TXUa0NT2#DbG^-cNbX3d]ad,21/
fAfX?edRb5S[Kb0PLBdO]+@9J&^DPC:ccRR^^b@5\bL_2=D:-KZ0cBNMTgLA80\S
Y/(^e,SdC&J\?1T@FG_d25C[Z,VH<2T_DSC+HWQRAff97IN:B367]1>)LYYOag/1
0HFU<06_/g=BWe.eM86O()D;0FXee:15WFN/MQG9U=TIO/3U/<UeP6Q>N6.?10:6
#aBL#(d.VR?d;I@+H2XDLC1W2N;/ZFFWOc+afV#OSB7:+DRQ;B4EA2WR(^H[=-.d
@?]6RXaA/L@\d/BTb2)&[Oc9EZ-O?][gZa/U]YBQA9N@AaNPS1PZD-3YV^8g?@1e
O6)I15W3AI;JMc4f^OT-S7,2g=&RgZYT#6\f/g3VbSA4DU3<N627E5),4Y(KK.EG
2b((KdfJD37PORK)a<RE#I0OVc]O\)H<^U4[_NE?,.A:RAH>NU,RAVY+Rgb/:#9&
\aOcgTUMNV,0.D5_VD1-\-06AQZTU^>+4RQ=[+FX<X7:a.C5Mc.0NUH\[A?@P[Bf
W1Q1YcI0/><8_FH/6]4dPb[9Q):F5QFE+Z:<C+>c8e;50K-]HNW54M/&(CK)FE4-
LH[&B><c@d)OC#@;,?3.g=a5T<<_JK2Z=IK?8;NC11U_K4ON[=5H26LL/\OLW,AD
-&,<B-YACXd<59b-E.6g7DZ-cGP?S:WXQ2_RRS19.X1QU36;/1,c</fLXZeQR]8L
dS+K0->XZ,@&QK5dSP@)VdE(7,OYG2[fNBO@a;J;^CF;=.Q+O[d?NO/+Hf8fXO]T
X_<#@aD,2J2fB-,_Y,/VC:YIO__@6?eSPG\)):[YLWLJL-g26XE:JFP1)/VZS0SU
Y;^XMWW9H>2]<@-:;7WXUTO(&5DU;#PJW_<4H6.=^-OAN]5W24^@cOFUBU+W5(I(
a+Xf2]@T&0-7ADJ/<S+8(3aVf,:XNIb;#WRa?;@+&,UJ^TO-K?,BJ#MJF&-d<I)@
WYFd&5]IedFLg-2S9KOdQS@AMaE^Sd<0)@NbDI.P,#4VfG()QHL(dYQe_8>eE1G1
H8L6-#V#KSAH]JEF(gK\MA>a=OI?VNAEdBA4DM2_OQcD#(Ze(-#(NFUBGUVbJUE&
0WOPQA:d0P\CBb62CLI_(;M[A</gZ:#b<B/^df[T-?#c<K_3Af_&QV8U1#D>Ig1Z
J9.&6[4T#75:2JYZIXLf<7(OJ[&e;Xa4>LNU=DaJF@a>TK7f:M/[WfN74Qeb,fUQ
5O-=>_J=]F^0^V^/JJab(Q^@U6ROT>4YgG<bBPS7G;29BQ\)Q7FZ#3>a>G_^NDYa
Q?5g,?@dRCNWQI8cY\OgDbGD(3JgIL/eK].T^@AcM9P&4NM[B6=(]<3P4P9,NLKZ
:O33<+-B8e/&Y;.VNSdFFD^:B39LRH6VdJ8,8N7Ie=BFCIB2]LGO?S_a5M17D)a3
[DbLG)+70UK9?1:0W-a4:aH.\,0DOQ:\0]V6?0=D=b,082G-eFZ2T0YCgX1b6W2+
_&EDFWM9-Cd]01HYW.-+^_KA8:&/#VH]cMY^f)g/1A/E=V_;2b5\)M3gIe7;KdC>
(Z6M1[IX;[61\IY9A2-A1Z59&FeL&5+L;O1_cL6982P(a2fJ=2KQ]]&2^\F)672)
gUFAUO02&f(<FM=XP#_NHNI\C\VO+8M>00X]@/46>(,5J\QF.MAc21:WLe6AH0]2
=?9&D)=<BYe6=I:R<R[(0T3e9Ng;Y0B[NL+^DL_Fa^.GK@W^HG_WS]EOS:-AbRG?
#[;F5@VV^(+U4;R_bgE4W)C0dBQf56aEKEBe55@=/IAXRIXXXBB8T._9d>I,Ma^E
;JX/f5?/I0:Q</JPd;W\4W4A;Z,+1:RZ6K8fPg_<\-0<K6K2cFEaGIHP6;L61NGb
YXg+aF7F<N[.e/;2))1(.<O,^U^ObXaJ[1[]NfDeQUVU_]23<2-<=S+VLb+dYN1M
@)e07I5BF?_1ab).W3NJ.1DGbeCC4e;55V[)\[@V[CB4BG>W2>LPSWIB;N4;BfS<
\@gQI+6R],)G,U_CM]fN8O1<G>Q?6H7LBXd=)K])4NbSJK]+//^]H/VQPDa.:81-
ZE.+0dWVX-X]LU3QfP9F=Qc[QEYcT4D<8R.Kc_>34DQP/VEb=f+5GS3181987M?T
VV8[BW&b[2>CCUUJJ,&.-01[)adE?#^gf7/G4,2f<0\D/ST4:.@N_7V,(D?LF#=E
25N6FO=T\c;18CW1GQ:P(O116^F<)fBLEDD[4;(UAW^WSS.-:SKRAag7QUJ0V3gY
&eE5SU=T3KWY2U0dN5^4CK8c1?XJ:B9<+-g4NV2,M=AEWA1XO4bT=M0<^#.6c<)=
C7?>6M)?1N9J/\UZT:Ube=^SU6LG)ReK34-I?a]7YN8YJ^-\?D+,?1UO=5^XQS3\
ZF=M0-F7e4.+.-AgWZGb[IYJ:Ge;KK223>M@+9EH8TD]d3U3JG<R9^IHU98NMNP#
5Y+Y\IYP+M9Q]aVS9WFd5\VO2F@2#DIH0<+K_,[\A[fPO\:XJ1.9c>]LcHIZe#IV
EDI8(gb_J><,(+EQ+:FQ)c@>#5BZ/;]II#O8K^PcA[R):a].9P@2MDT+Y+FB1JYQ
^OEMd+ITA\A5TQ8>@ZL3@\5YEM516NZ/9e\TgAZE(J@S_E&0H(NW[55W.Qe;(XM9
5\MKD?VC6=OE>W?O-YLOJ/JZ@IcN/FPP?T42)d=R8XGAcYY:dIQdQSP5(,AOU6Bg
):dDfc#UY_gRQ(@CCQXPMf8UGK1\00=RF15N7:-)ad-HKMI3].f7a,5VNcU4+fZZ
;;D]H20[GK:=g;L<S-KH?4^Kb@1.\4L?0.3<3J\_MZUUS?CP3/fG+;3<fa]<?Ob2
;0cR2Ze-)\W]Y&GLW]\(B(9?YV]B-Z08]R,e[=#VB.5WG7H6USKB[IOI9+N&UMG\
9U.,??-[:^V?]cfL#XRG(&.^79(KLQLX4>&6[C[a>bW@cTS#=O#>,JB.D[VTHDd&
].c(VLZ6-5aB,RZd)77UTG]&B(W5IUY;]2X#.cd?ec?:(W5Ib4-Q7aa+5Q1b>1@:
B1&LGQZe^Eb[QNeOH)0:-b0ZI2,?X6=HXGfS\A)L>L)Rd9WF0Y_[\VQBEYF/:3R/
3T:ALG=B(MW\VBY_=OW9D<JPY)Ze&Y26e8BTIJR@@6D?U45-5U>7=DU4WbBaC\8#
g31F3J?P85#5VA:CPD/I[(?gD=\9-)CXWGV40,4CLSU+_AG:VPT[D^LORC===RS5
.A,,Ra(e+g^f>B:AHAe>CV=6J==,=>UdceJTC\#(ZO1CL\3Mf58N<bSM7]P\IUPX
T_;8d[T=4#\9>Q_-JD?-bAO^O94#RNG-=H([gSK;<+]4RM+\@fdY@b;.8EW^8]^Z
d,>QD=5^;>Z]IdB4KcV=ae=WJ/30C.[&ZG7aA_Q)YcSf_>:EDN)(,+EgFJ)=_Q@C
)bHF3Dd4gMD6.Z[X?9M4#N#:]2fAT-RI=OI3b-.HG[5gPY^:V25S2OGaSC)GS:=4
;L&A4=SU.d2H?K+>/)^[a+;3XA]]eIZVX,XXE/.Y><a62_O#G6b6eAcbcCWU=[1A
b@g0c@6Qc.FX+7BBC020DISIZ(GR4I83>^B7AV[C5(+3d(1?b</>g>3]9&PYUQUO
LWdG]7L);(HLf668J+8X..\[\D\cT+LSIF0LUV,\C_^IW7Nc4b<+)1&9T6=dgC9O
X?cJC9g>HG/>gC:g]U>_PGTA3[?D0V&\e<YdJU@8WTE:19\<L2aB5R_Y?90]7J01
93[\NI;+7\79bDb:f?e-0\[DZ-_AC)[>B=Z\c?L5a1.L^5VN99LTf\&9Kb]e3Jd6
48f3D1)Z=G9X@[5E+eIU@b^>BY;Y&@4NMfY_-#]-(/XNLf=K_CXNBKceSeBVDN2&
(2:4I9c<5-&JPC>TP6/T0<XGaB7E<Y[S?:.TMGf3H55+3V)[ZaG,DDc>U<IOb58E
bQ6#5Z1eTZMKBOc3_474:aB1@G,)OT]CK6L6_c+KJ9-(1I];Wa4G@R,AcdQ\D0KH
8S0=?]=3g.^UCa&DDRJGg2]]SE;PT&LQ;aL9HHB5YCA(RaNbcfGO6B3T.dY@HfPa
aEMbB1O4E(#9ZMHF3-?@EB8;,+.^g\#(LU\LG[Y=^Z1/:-1[-IN/X5b0MB.=EK>N
PEcOHG-B?VdPcCIAF&bD5JgeEBLS4^:1L=L1B#b\6^.g14JO?RTd_d5gcYT74a-(
=7NRPM6>K1<.1cS/e_(VG\2N3C^P&0a,WRI>C1;GeYe/B]XbKY^6L6>ZKXL\+ME5
_+YLgT)c7N)?CQ[a>B9@\K?#Cf)IG?MDg6S(IP:W?G(Rc_R0LLPI<,HW;^TbRc#H
8HVK,>E=\Q5da>X5:IUNJ<\cU2TA?S;e,e0(Fe[6-e8(^S_5,46C^4.3H(6=D:B]
>(>IgH>UcMT#AB^d5W:A<U^R#T&OEA&4d]=>)+a[0[7YWS4]7fP?ZVREH4fU0R;2
b@0F;/+Md^9cOV,))eQ7D]NAa^_1Te2TLWb4^1[YJ)2ef4_Ac>1cGZAY<EMSYIEd
]g+eI<5):J5[MAO)B19J).F>Y=^Je19KDD#X(dE-_b]#&P=JP4SDa5)(>?aEGVMO
LZZ\WC#_>BZW(T?&>:Z=b)a4IPYZ.3@H6^b6M<W66C?b^>?:+4KaUYfHLgH7<[TA
(g<-B5DYW_NANB]e\,13X/LT\6a\?.6#YO[9W#IJ(UK_eHeS6@LE1fZZdWDa.b)S
I,=VDgdKL[S5)f=6WSL>e]IL;V#VYE088Q6&8R@2W;Re.A-F&b+PYJbL=f?B4NBQ
H+;]>_,E(5F]fLFeW&g<f/dN^4#_LcOQ/c6U+&=9MSZE4A7-QdUEgULDPNB+T06+
Y]ZDJ]S@B7IZBDU5MWO-Z=@)1ZW;Z5BH)?#H:(;PRH,3U,:^R#HDaee&b2FRW+g,
c8\#@1.XL4T9:,g53a;]g.OSRJJGbMUP0OA5KG:Z<VKT+IgIa8:]0^JWSO]fAM6)
W#5O=P8H#9&dMB_g1:[f09bf:\Uc&:=Y0EDF6JO_2(MX\TMQOJ]6,f;<a&F;PEAf
aW&a_2=HB]cCB5,UJ+MBg7O-KK6(cdK\8>=UT>N[^g/#d.QaZ2[DX.=GS_K8QW9&
]HU9C=D1W&RfL;aE3R#\J_RZb#8]A9\a@?4<A/cT4<2e^DCXZeb0+XYZB]@f@-YB
A_#f]PB7TP\B\JBZG68;@&Q3#:K+]g2A2OAO4bOR<DL)T=1,F/3YLR[1deG>CX4;
AKR^(H#b(B-VNJ:(/C1-;ZU>#PX0CV+]<R)cA1<Cab=:-WX(QKMMV1\dS^0/(.EJ
NKGM1=_eUXgY?X^5/4\82N(69Y:.N.c>b.S]gQ(1B9]eYHHW8ZJ5^21WN2&[edK;
>DMF\b5+/-5I@\>]2553aR[^#M?XY/R6X0/T]6^g)NNM>)3;:J0]VH,G]X1agX+,
4=RUaW@ITMT&P1L&/A.F5^g@2:RDJ?bE^b3O?AV@,#)3/GX<BAM9E,]R>KTW.NeS
Q2GN4=R4#XTYMBN.a0G&d??:c;GV2N3-Z9\Y^7LV^V-W)[b^WAF&0,H,]5KEX1.?
c&VX,<gbg5A]LRS@MHg[XSI.WN_+A.;)(gbEg\QdW#PH-3]1;Z&@Q4V&#THf(SI0
aCRPQ#fTW4LTB7-c[@RReX>O,+c=\ZPO1)D_CYQfc#-bfV?9H3VITdbDGfEZ(LQV
6;(1c9S0?C\I9-fT24AS\7d+Y8RK_+c6Q7W2Yfc>W/&4\B92,[-<R0Ug;I8)[gd=
aT]JPBbQ\^Z/:]E0Q99@M)Hdc4b@T)=)_He2W>>QD(c/G5S/[O@2I73Gc(.AX)[?
ZM[d^:^R0#1]B4&CT7SU;b/Y;^FDTFDd\d\#^fc42[OL0O6\J-Ad:LP:[e0G+[8H
+:&Oe-\C8(S]?BgA3-_24KPga7.e63aZB3e++(LBS[5:@.:&Sdb65Qg(FW^>I.^@
+V1H8;,:=^NOSJ]SJGJEZ=>=\_QM566P0.7,fMAdY;1/J4dd>D3JLWbNg2&K6eN(
3FPFP\EBLVFLH0F.UE@\F]WYA0NH_D8gJ@b:2Y.0=;?\g25-+^U#.IL3^E/X<.?b
f=3\\WC&[@Ig-4NYE>(I4c,3ZWA7I>DgQ(]#T)Z@?T)(\S@&VYL@6T]@C-eAJ5W\
f+QfB-aFcG&d<]&@;2SYU[+0G0S@5gCPBUTU?<&XbOGBCZIAC-\\\cVa:<5eP9-6
2#cfIA)ge<^.ZF>1a1-8Y?2bFKCb\MBeEG[6ORX,2V[^&4MfBZ/2a-##Fd:9WTg<
?1S;KW8f+7eR@54f,9Z>W\?A\Ya+BMZ7A-48eATQ)P<DZT5OOE2P]6GLOA<7FbM<
_<2_E^[Z?S+Cc;+?LSS<@)BD-]c^OCagU;=HR3<\daV6]<BJK9\ND@&=T;AT:OKT
WaSM+/NLQ=#O\)_S9L(2;0RAMMPAD<:Rf:.GX:XJ]FI\-=164ML.#@BaHag]CRQE
N2QT62==Pa0f\&A5Ub)7;0):[3[07825Y+@AC.J[2dFSU^BQH9?<\bZ587,BD/EK
P+[VgD)Rg2bKR.Ybf?.@JLC&.XHaSa-UfWLSO>&Y=FBXCZ?C2#R\f38X,(#N7[W:
<)0SfR)#MLBWKcREX^g>fMT-:>]ZFN2R-Z:-.DVdQ[6=6#P6KE80bJH3Rc\MQc6)
TZ5KV]DNC_F/=_FU1@CZ;\6d/IU#&^\&DRJMI6=__<#,bg1B+<U_=dWPK,6/0WUH
>db#FSg,I^\L1[21AeD@4,IE_\M-6YdC/_f6FB?Y2QZ]9Wec&e4B:+NdOGYY(g7Y
@YF-3<:XY?-E0<UJ^/,L[3c&<M;.VZg[H^5/J(9_.J?(6KGC?aOMfM2)(?O[UVIR
W@cMT>Jb:(e&7Q.Q(7EY02NS+EX@E/XM7=dd[FO5,E4)#]BIC^XA(M/-JGM&[Xb(
_:f1g&cS1F\#DI5,CD/_#6NDcEZ_(RY;0+64T0Y<=;?6M89C./QfHWAP7D8,@c&1
]cT5.)3eJDP/G84)=S<1,+H/DDP>[1.dL<,+B_OdfTAcN3+I_FS=YKB-/-.1ag,H
=\SX0]ICAQ3;G>dW#&S[\aB[:+IQE2MB^2LL05]1-R1R9U#-SGg>4a=?PZU<<f=6
D96_3^L/P5;+:JK=HZ)5#M(]^,>TW;5;0M\2[,:/YW_a7[>]NK6We@=@fGb.C[aL
9KX1,D\A/dRQQVcGc;RJ)/bH53d)#YU-4PM0@\<A7=XA+DQ]OJ@cJe1UW]>G8Z[]
Oae;2F[9E#/Jb.\aB[4TcA6b-UGE@DdZF&:02E7;4SDO9J&c\B?>GLD_M>de2MQ=
CU=+2#,6a7R1W/>_V6CfX<_g#=&egVWB2I(Ag<1g6L2XWb.M(88X6>R&c#FH,XaB
=F3Z/(c83MbH\4Pa]X#&eN-OY);K9)X7,2>]a.4D<D4/I8ZW.L4;3O&)#_KNcZ.6
COH[M0=K1W<H^aYJU?7G2_ABT&T+7+08+GB1UPMHRR(<dc=:c?+OI:(^Wdg9,K7J
;2M@2WDKMNZ?\8eB77T496\[-7D7]aE2XYEH_W_5^ZGVbP1>,RKV9@C+4CK>UVOY
E/<ML0;TLQ&HON=/WM9^&?.7Q@/T_ga8(6S5[2R^P-O;>+/g4,#;/&)UQg_4X118
aZ\&+(/3-eA=0P&-)]Rg^B^H>X[g?2]T8/]]0RH-ME^M89>:S<#_DNV7NK[CddTS
aV@5X#KUC4\WEQ204gQ?81?b=Ce:EW#7Ma=RJ._EOUTadSA6Ee+\a52[]YS)+QD,
EYR)7fSTTJ_WF9Q:/E]f5@S5J5)G>O\A0aU@G_#g6fZ<c[2X:HZ:[KD08\V&b<#e
+fU)J^/I^WI+Y]JM(.Ded6JY=CA&PJ-<7W^JXCE[?&)U]>K2/#6T[Y6(^FOT^H+<
;A(F^b+(S&[PWUZVLXAD&48MK306[V_00]5Y_ZR>cPLJ27fd?=O>PIO5#,DcS]W2
O0RF2b&c).[./31;EM^E>YHT=IVBQZUFaO]g19IWe]bWAfD0NI>HA^:F>04DKFDZ
O#J-W,>gSf6RG/e/Vd^]@V+\NKe8;81HbARP4B7YC?58^O8E],DW#.PKN)0:5eHZ
2dAY:3Y3<[857eecafDO#_)=/_2W0S7]E6K>&RSCf,+MaW-a&GJeJ3ZFQ0g+:.SP
)b0E?1PU7#:S-aVB_R]=P8Hf;b4#HB,?U8\7g,GWQ0GgI)QXaK3;/6R<@T;XY0+E
3fMCbFbQS,R0W;@Z0d@T7gQ\:W:<:_HeD[JB3]\@#Rc#<_LBA=^E.=D?A0dTBR>f
76;9g0ZM;89ZBU]7DKe[(ObF&\A<J3MWSFFO^8>GDT<IW>)L[KEKOU]WC74GVB&G
1<.857++2-b-9^&CS\\U6P>)_2@]dOWK.?42:&PM_Vf?/2N8(V?YQ,_B<D@?#DT6
f7HKJ)dNge/)cC5M5#cP7^<7V,??7T(1=L2;16)<A+D+T=G#5+^:bF?1UD:#7+f_
0>]ggO4)LB@.^)[DfT]a?g3R?gB7SFcE]7.c.C\I4.MXg6P<C[B.QVA/RL,]FU=_
a:&_0:V]_RK(+F:e,Y4(c-XcTK6DPe6cI-B(#geWP_LYE(gL=Q\>UHC+17d=aY.g
[2XR_@[Ld,?&6EZVf9^\d\#de/+M9P)6@b^_K9LHDK@0CRZNU:\)aZ+-?C[RO49I
JfBc>5&#2:7A[M(MHa-AMa:CE7&^WU\TBCN=G.dK+K&Qf[?g8X\CFa^,D>dMcRb?
@<(1.,@gH#[9A#A[]FcbXWWR++PgWOL)Ub&C<3U/23Q)S7C6,6aTU0[]D7(^J33\
c6HU.Z91L7A=cDgGKd,A<<.>cbFAV@aL7G8f<TQdceV6)dZ:J=\V=<B1UL7#;-b.
e-g6&FCHdK\LXVGdd?_T/4C&Q&b<e]&R_ZMe7O_(2cF,F[-P6FBL-?e\FIW(>=2#
,Cf<A/gY.:[>B/Z62#QGd-^#\PD[B[K;]3R.e:X3a/=K)7;+_/=GZ&S3VFZC@S&U
?+[-dP5C]9274S&[-UP#OWbgFe+I5\e#\VS>LF;IVC146&48>QROgQgc<a-ZB-&-
b4V>>Q1ICJ2eEXMXI8@(0#PGDGQ?;8\GWUF\T5F+J_8/ZY20bEbK<YN@NJ]Ha5JM
F@E&98]KAc:eGKPU+4#(<ZD+]>HD(Bf)I/5&>=S0NJB=X^T6XfWa2[PBB^+8?6DT
;M6fB\cAUS1TW[=1=Ma1>a+HCdWV8[29YfBHWbFHHQC=c-Q>NW/+&bY16_HJ1:(P
g8PaWKS<(RXLMKMIUNQ9#>0/\8?bS6[[D\IK&@f3\B56.A_((LFZZ9\JG2cKEgB5
:@\f[<\_J/@Z^+<S4e-gO/2,@,)3X[15)6c/fF>=PH:?<1Y\P/UT(-Y4+./FWDY0
@=B:@Q+,[69)Q5b/b3R:bMab1_Kg838a4L493U7-Ca[\,=7eMT&EP:2<Xaa8X]R)
;D1\W?f&CgRX=6cD\\DDAS+ETa/C^ITSAaH^.(TD.JE71fMWE@[#G<_fa/BcIWX(
55PG3N-d8O\DRXRJ,#V7bCd&G&OIKcX3O85?:/;E3d_PUZ,_[@V+(V+@DUDX>6>5
(/-K6a\Q[CE=OI&Ic_2#N_XB:6;8G[d?,-8&)Xe4UEc7\Q<FO<d9cR+H4.Y>NLg8
8@&e5[G(/XY2aBbB6P5c)Vdd-K3=I\E^]1M<7Y?+Q>b=)LS;#E-\/#XPBEcDIO1G
3a2:QZC[#YbRN,b2gS8SZMDLRK?aQ?@XY8GdXF=cIRLX^G3;d:QP&,Xg6dV:5Y8_
3UH<2X)[V&a-@7TP1<Y6-S.>2<16;]H.M4]\B,08LQT^LQF&IcC/E@SEJGXM&CB^
Rc@2T))Q7WSEW)e1>d?V9=ZE9LR)^XYaA?fV1,G&G2Vf:=e;_O&I#D(4Eede<gWg
7O3fF3\EWHPC-bcc4-)Q5D=/d.&Ue^Mcec<0D+b1>2GR6QXgXA.Q5Y\6#&C3OR=f
e@\=-[bKTIS8YXf2BS[b>BXL70S64O&PfZ&gC7c^Q;1:Cc0cQHMH[:@3)Z>+@+D]
G_8fa^<UM>1gX9geI/4Q^]M>4RK.NGR+ebCY?Q1\E]Lg1FHg7U-HJ?:,8PBF=M1F
>MRA.?VP]?/37Af+V=d]3N1:XB[&X7&K@#GS6Y^59aIWR[QJFVB_K5U0]d4RMb9#
-+\#FD>>=&3f2XR9,R8L[PUADD7.B/M4^A::TRW\E0VB-YC824d?07]:=YA0+T6H
Y0U3OKLPOXKBFDHaFCHE?5M(c+;YJQ^X@XQY@C\VLV>R+8[XaJ&O;:JJ].?(2=N<
GeU(5>M-]K(G\]AT/4WE9SEFQ\W#72,V5[^4&U&&_fS2U-U+>YBg;bG8/>VN&NdO
e_O,3D^SQbJY;b69FTL)(WGFb,_=e,deLKG/<OfDdR@GBRD9J:U6_R__:-]^RbZ@
1gGU9f800]2aILNDA#5N&AAD21Q:gU9=C@O?EX(@bIbHIY0N-([U^>VB7SSaYa_/
;+>4+.]a2H.@K,1YY1EQ/7W519+0T5(Y5&;(eLE<<W:)>#@CdQX.N5VBL$
`endprotected


`endif // GUARD_SVT_NOTIFY_SV
