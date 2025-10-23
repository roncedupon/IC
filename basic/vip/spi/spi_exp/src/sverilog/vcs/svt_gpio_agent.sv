//=======================================================================
// COPYRIGHT (C) 2016-2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
// The entire notice above must be reproduced on all authorized copies.
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_GPIO_AGENT_SV
`define GUARD_SVT_GPIO_AGENT_SV

// =============================================================================
/** The svt_gpio_agent operates in active mode *ONLY*.
 * The svt_gpio_agent is configured using the
 * #svt_gpio_configuration.  The configuration should be provided to the
 * agent in the build phase of the test using the configuration database, under
 * the name "cfg". 
 * After transactions are completed, the completed
 * sequence item is provided to the #item_observed_port of the agent.
 */
class svt_gpio_agent extends svt_agent;

  // ***************************************************************************
  // Type Definitions
  // ***************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** Proto Driver */
  svt_gpio_driver driver;

  /** Sequencer */
  svt_gpio_sequencer sequencer;

  /** Analysis ports for executed transactions and interrupt requests */
  `SVT_XVM(analysis_port)#(svt_gpio_transaction) item_observed_port;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
/** @cond PRIVATE */
  /** Configuration object copy to be used in set/get operations. */
  protected svt_gpio_configuration cfg_snapshot;
/** @endcond */

  // ****************************************************************************
  // Local Data Properties
  // ****************************************************************************
  /** Configuration object for this agent */
  local svt_gpio_configuration cfg;

//svt_vcs_lic_vip_protect
`protected
UdQ8(O(Cd,4a?14-5S2=;1_QE8EV_\LF0QL9HW.@WY=K-75+Ra+U.(9:O?dDFS-:
VUZ;:96SE2S0NgYe)f\.\4C3@9;f7A/]5<Ed_I>VW8aP(V1gEb:@J[AZ=//C-,d4
^;P-1&Ob#f^C@GF^bI;,ddTEab@:-HA(0_Rfc6@Q29J+-B0F4-2Of^GGH725MOD9
/f3\1Sag>a1T)#e4(d,W^4JWDIJZD@XQB)0fg6dcIMRMe&A>&Dac64GGM$
`endprotected


  // ****************************************************************************
  // Field Macros
  // ****************************************************************************
  `svt_xvm_component_utils_begin(svt_gpio_agent)
  `svt_xvm_component_utils_end

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************
  /**
   * CONSTRUCTOR: Create a new agent instance
   * 
   * @param name The name of this instance.  Used to construct the hierarchy.
   * 
   * @param parent The component that contains this intance.  Used to construct
   * the hierarchy.
   */
  extern function new (string name = "svt_gpio_agent", `SVT_XVM(component) parent = null);

  // ---------------------------------------------------------------------------
  /**
   * Build Phase
   * Constructs the #driver and #sequencer components
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void build();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Connect Phase
   * Connects the #driver and #sequencer components.
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void connect_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern function void connect();
`endif

  // ---------------------------------------------------------------------------
  /**
   * Run phase
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual task run();
`endif

  // ---------------------------------------------------------------------------
  /** INHERITED METHODS Implemented in this class. */
  // ---------------------------------------------------------------------------
  /**
   * Updates the agent configuration with data from the supplied object.
   * This method always results in a call to reconfigure() for contained components.
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  // ---------------------------------------------------------------------------
  /** Convenience API */
  // ---------------------------------------------------------------------------

  /** Execute a WRITE transaction on this agent */
  extern virtual task write(svt_gpio_data_t data);

  /** Execute a READ transaction on this agent */
  extern virtual task read(output svt_gpio_data_t rdat);

/** @cond PRIVATE */
  extern function void configure_interface();
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_static_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_static_cfg(ref svt_configuration cfg);
  // ---------------------------------------------------------------------------
  extern virtual protected function void  get_dynamic_cfg(ref svt_configuration cfg);
/** @endcond */

endclass

//svt_vcs_lic_vip_protect
`protected
8K#6&Q59Q/Y#5XHeb/9b4>@LD6YTU<+eUNA#,+-eU<5.=fCA65cf3(PR?3Xb+-.:
g\J5e<9(8EdFHJ6MQbfbB?#]E-(NO/)5)<aa]AS93E=/@1,]D0F@]C4/1T9L?X4W
0]dN.>/(O_@^ac0c-^9)J?CY1^+9_dU:X_XK6:AP?X+KWT<.7VZ@4=.^)SS@1?)+
6J@1(FH\G6NLKSY>,VA976e-BUD-;X4PH\Z^Wg3\faE\N1_R][?YK0UR^1FE>f-f
V6gf@48)5@/-C<5FTJ]PY6PCV(>6OBEN;gTS4C5RHR<4-EfOH.;?Rd4&Qg0,d8[9
@,+b>#SE.PcSaDU4,e0N<790P;T^YCf)G6Bg[[LX=4-OJ.U&QVb[Y5UIHCgbUdgS
V[9>W@bTOO62MFaaNQ9,f[29ZDBac+8b_cR+>7;RX-I&^YYE)Rf[DLC]#]S):Z\N
X9VU8_/g=/?T3<E0J)46L]HP2TJfD(EZ70T#+YDZU;EOEMbAVU8MK7:W;_;]PNeM
],=+D22Zg1YSSF7:^S?I+VFb.=83&Ye[WHaM3WRGNgNCRD?PNdgd.I\S#W1EV&Z_
NSKJbYCYVQ:Ja<FcB>U0;SNcKXLL\_-e0WUZ;_88d^e184ZJ1R_A@23a/3K8S<1?
eKW.;V-6Pc\.RC2AE6,f6MKL+7E7:ESNNJb+WT[J2gDR&A6:OI4=6?b#);FCDJV;
_<ZB9_[H>VZ9\Z>3f04fM52bGVaY&/]>5]9[CI9YA[=HR7#;dTU2NWJ6.d)Tf7.4
]F\b=RZF05TKcL@JU^XBGb?I5:+?MHb>?Z+SXeJ2;QZ2(2U1KBH6BK00cIf&8N&.
fc=RSLJ]C1S:AY(;ZXAD\1M2/KZML;gP4[g:+Q1]NVLGXRHb4+]L6L(5X70YL8O)
EdEV[_.0X:J&=J;?_L_gU//F1[QKO6U=3=1KQGEf[K3McKe.])<Q;fJX4F0fD=;O
0J^[3KS(C:X[^-9^5e:/L:d?=AS#H(+TA-C5>A1QP?Ra^Ya[V6;@2ZY,^>f85;30
</?MG:+E/6T(WJ\D6^Ld.7a6gdO;QD)@9fE7WU,5)5d3[WSRVCN3B[;b.3M@\CQ#
O&1=Y.V0c=Y8#S_]SSKXTUEX61FKb(;T<e2>I6AW89/JbOIB9N6[Fe-)48dZ.JYI
@;f[9F?^d8.d(DX<,Qb/JW#^B+J^90gX(.I?5O;gZ2IK(e:a9>F/^JXW:_#LOJL+
Yg-cQM\Z#?LNYA@4=AO7dPHAR8&c=3^F3E>Zce/@[JNUAD/YNDN8O#Y(?QMDE<+b
WdKJgNE=;AeH[[Z)B,8,H;>SKT4<\A#f+\,f^Q\FM+.)FB?]LfQf>CR+#<R6FAc1
PXcc(_a,#?_,P-J34I=-/&2;:<fCfR4V#RTD\@6_/\@bPYH#PU7BD)Vg\]_G,EI.
QXGUS<.QKN,fd<Y(-;N(@c##CUP6E.a[G5eJ[3XHKXK/fC]a+U.#GUO(?gfgB6d9
UUBD]57/MO6M:/Tg8a(8D(CED?P&,/g[A^E4:>V@eF)@M#)b=OTL033_]gVV6HJf
gN&[B-CS+V@DI<,c]2Y0V0E3WO-,UUMD1]3RM-dLX2;aLU3ZLLcM9RB-^7<&+J=H
(_cD&.Lg]e@[)7IRYY_-@U:0CV&WRL:DRXL&0,:+RL5GLUNP[.#0N;#DU]I>=,XZ
O4&1K)AC9b(Z)aBOAIU73\:bbVNG>fLTZO(\0GD2b)UCP5f:#.1\Ec8@gR53]f?U
f)O?D2ABb=:Y2#FAd/DXaG_@g_E?f8QE5f+bM+1VT5J]SNX_EE<UV7V=\X8E/B.I
6d:Y:=^];GQ_;UO(B3+f4^41GQ,+#V?BcP2A<NLW990Mg7M0_Y3Y\(CBcVTNd?K>
/W-7YPMXFf;.2GgAa[2f713/29a>b[Iea>U7[.F5SdZJ=20P@&fT@e_L&dV+[NOQ
8LdTLATb]^-OYB)<RI43[;P3Hgee-8[:C#5TC>+DL_5+:>,B^UTHOWI)^UgO5Tg9
]_?G)5+gXEJDAWgS5Mfa\Bg#Nb=QY0MRVI.Na[=f&6=gZb?D_F6RV8^+QC_D:Yb2
_O(X+I4[N:+?1>EOH9YT?e#cCJ&f@[_BL(+Wf^XCMOOZ^fJTbZ)0ZQG>-WYCU_2@
1JcQ&H6Z0VPXG2ff^J;LH6\8@K(-O1,M?9SOMV0?Ce[CMHcI=E(FO2R8eTCe16^^
Uae(M]EC_R,__AM,7(D1?QPX\QYPIF.H,<>>1-_MQ<<1?TXWWK+@M7K//a\CP+M;
3EH)I9_aLDD6DYV7SRKaNJb^F/WO5F^Qc>d<1_]GJ@W3VC0:Z1[1aX92c5c2]ZO,
?;:E])GH2UGC@W+7#NQLHGa7(KL971JSe_\&fX\4,+6U2:#/U0_V+6g-V#P=L#/@
1N[b(V;BTA11+V8#Q@<AI=DRd,-&[MD7U/YM.)SaaQ&YA)_EVH8c/6.ca8<=dR@L
Z)-2@K5BIB/)H=L3f22J0[W:80:>\(]b4->;X.eG^@T1#g&cc[Z),VYVV/9WBEcX
.<f[4HY]TbU3eYX=T?K\+E_:L)g;BQ/6J2MQYWOJ=47M61C:8L73M[[JRf(N=4-X
LG?>H]g0)K\H^#K1cVc;R9aRM?8/N(HF..gHdOV@Z]B]9MDI07,VD&3U?]B1[ZX]
OI2KQ6/4RG;3)UUZVKRB;5QcPI,Gdd^WKe&QOMF=8<bT;BCGSd4g2Dd5:\Ha/O/,
5Y3XTV))+O)PC(>L^?)g:BZ6JSKX<@HfL7,>OM)fHc_?]f[Be6OPKM6UWTO<_GPT
<)g(&e;VCc;6DT]Rg[P9=4#T0bEWD=/8SEFgZ_92^>;KVLWKGCDCRD@687&FAJ+&
44c+2RTG=L&O;V2P:X0a^3f;-&6HAQ.((]LYRe3.HZPYfFFC);.=V12_;eXE7Y(0
OCf80/NX5g+Z6Ig=\E)f5SEeaU5UdeP99/ZDYdJ_#[2cF4JNCVXe(gTVA/68;?19
9:(LMKfDXa_-C9<S5LRKG5=AF2POV<.X^IW)U[;]YC(>G?OZ9_4D6.6,LSA1NRSK
<XaDJHE_^Q=?15Cb8BFK.S12:)9YI_/2B1C3GVF;AY\@,CYZRZ2C,0U-+=16I[?X
CAe0G^c\#Da-^MbU:(9]M#fUP/<G@Z-,N<+O@OR?\/).?L_L(<4?HPL6Y8:9Ye2=
CGN3N.<QP--.J_IJcQa9JN#>I_E6?PeVZ0EbE6MS)PJ#UbE8U]O9T@1&TZ\],E#-
_RM0P3CYQ_Vd3@QB8b++K]CIg^MZ8#4F9UKRX&:JU&#<\@;6DI+IQFE6\)=W:3Y_
/fXSdd_]-CQ-S/++[e>a8]]O1LE-21#-W^\/]B/;-UB0&F(Obe4W^T:5_]I)H-gf
R)@038FKHR(DA[<++ISWLQPgPC;,[=P7E_Q#D?8eDfT21^7g\F/Jb4>NWFSX3@:c
Yg#&<2g.M(2^?d,#TK,ae<fP&OgE._^#GL60;2\Y)J+eGG-B0BJT>.?[347.1PY4
#YO(^Xba]N1:8d4CGKELJC\Ea\GP:0)cD.NNH.3e9VCRd+,4GK@a/f0LFX)BUP,W
8d>7T+HR\O?;QB6H.LZVVaC1>G[.-W7-T-g8KZcK47f-(>L4Y7;[>AH^FbBW&];2
6MQNfbKF&3fW_>N2@LZD=K&e\dP7^@VN9J3:,FfF;Y)6[f,475PTH[;-g_IYW<YP
RAA5:6A-,W^+VD2D5CRd3CCUbfK3-J8e#:8&::a-&0]T9c<CLZ-2/NNCKMMC)3;?
e_KU2>5ZP<\Z8PDJ,)9W-SE2D7aN_)7H+W4/ZPQb<^?U1628L@(,,Q#19b?@CHb?
=/IcXcZP+B82-YWB<dJ9[2\TSZ#f0QY2>d>Q@-3)_X5Ue6]dPPMHGJ?_>+Y<=PVT
:[95QTBS[:#S@1.YEI[4\dAH6;R/)4.?)7GNc/89GK(UXd6-E5+01,])-(;+eJ:T
Of67bS0DVRIB-:[\HU:[9?K9,DS_)1AQY/&=Hg5c-,:3B>(dS9Q7eW)D4LV#JbBG
\.#&W7eWQf3-UL5H56Y-@#UL)C=eQUHbJ&)fJ^@.MbD^(Y(#>Y2;^=C?ML>\2MN[
OU?8RGKHHH5U=1c7O3(KA<7AFI0;7)g@](V,E>;2>L\]Q=b:17]/47QO1BHVY)U8
QPGBAb]=RL6;<D]8#_dI#OdV0bS=bGDe;TT/UB\40;U@Cd-JSWD-:AJFM;JJd,:U
,.CL^[>>;IL,c=D/Ugb&YZIXc]fA2SS2^3HaUa+V<1-<MgHQLN&f91]J)6HCf.2>
1#LP3R#=a72]P7XR=bg.2dV\A_gGIeWO0^<C50IaMa2G#]2aZId[HcG&A6S0P@W^
WZ[P7(MZEHOC#9^+GM^G0@D8g#McO&T0\+G,4^1[2fO0@RM\4FZ,=bB?c28YP/BK
,XKHKX@PV+7CaIAP7G:3ccDRYY]N&c3PI8<EFE9>1VF46+We_@cG2X(Gd19O>W:D
6;&c)VT_Z/;cJ/HM1#f4&3_fRK,T4M5EV=&6]H:6(3GTZ0I<.M]+6T5:ZVCZ6@ca
CRV=Xf16=Le-KeZHVc5,1;1-Y@d1YL6A&QTYc<T+5b8SXS<Fbfe]81R/O.@[O5RA
)9DPSF:Z4Wb.R#d,EbSNA.<-FMLOe8gdN2T4Q^MF)gYKUf#+OTHUB27G\G;bMAO8
^H/8:R6X>/BDg0&]I>cN+L2H4-?,b5S3?a^N[B(M5;LfY(@Xa.^D16+V9_f\QSWI
7J3JPc/g\TaPGHGW2#g/F[V&?9]GN<K0@5IFJI3.[9<]0\-\#3-YdX5HgK\KXH/L
:4^B(Y&fAVS^F/7,[12^T@Q@c.NBLL#cP0(VCfR;H-M.(X;#Z:g^8;P[(HVQd5(]
ge@7S]4A0:GaA\1CVM5d7PaBIJE?LMdKYQG-6M?c:;G/3fcgV[-\Y>@OB9)Y^8UN
dbA&2@L(,_R]EK6EJ/MWIP>M[IWVG;I@EKADP,&=SEQb3W>/@08UQ?)e8O>.<_&T
g,#/bg>Lb]VFE_-HIPF=d\;)H,I9I?#QK7QGSd^8gJKRK0CIfAcRKC.5#7d-6OfL
dN\9>H@KgXT5FEWfIOD.X\g\DbP.P5cOOJ\MPI?0fGeVNA+7M=VSQ&F54)5+IF52
RdP+N^8GK_[dU1;UcOC>S>VW2Y(]UQ@5;G1/4S1-#^WK\FegO4&AV3TBJgYO87WY
MSg3bA80ED=Z911(.a,9RW^+M2[7?/8S^3-CS<N2-IGK6G\cJNT6I@NOQ[+TaZ#M
<Re.S.,49[YJ8BKd:4PXW6:^4P;UQd&Lc9[I>1@ZN)H:?M_g#2+4UQHR829#TDLQ
S7OK^1(Ka2#<4\[,2;71[g>TM:IA;UOM&[Q=gD.Q]c+@&.0S_bb?,a&TdOMHd/[\
fPca0@@,FS2HZ8),+U7T,GgXA=)F:9QM1K5I=8.&@WVe@81Z6BA:+.6A6JNFB,3(
S7JS//aFd(f#Ra;5eWF.6A2@[I-6@Z\_R^,Z.000UMYddA5SF,USJ9c(TcPZ4^?4
c@J,KJR+D-TJ3RagFNd]bfe:cYAH#Q>W23#?RP9BCLU>MR[8QV0&9A-D6>@&I2ED
BS)PRZ(]WeKUN0_X635K8MA1:@Jf.7Gb6ee#Jd=EXO#E1ebeLJ,-[WBTOZKR_WD4
.(6LMgXL[?HH<?[0.FR\Y^4.?6VfcWZ:F14EX\P?CJ&I?_AT2]aRFZRIcDeV<0BP
^],,N0A-]?P(J-09e]+](/,E@G9)>K0VA<I?>D[)KCL7a?3Ge]ZL)Z1U8K.K\7;A
;J8DQSc@=^f7_5><L.-:Pd[-+&LCXM@WZQQECG77A(GQE8T0UU#BS=;\/E;7HP:,
59G[.Be^O3NQf_dTI65&dGcMZ8SIY0)9aaQE38fYR]B]HZFV\XeENgB@8&-/&fKb
C?L>3Tg7M?>eN\RB[\Jc8Z[X-c=7.NI2RA)O+3C7W1I9]YfVI;+Y1cQFTfa4H9ND
N]C=0=,\#S;ACccJ#T??=M)TVSN(.-2+H_7,Z\8]5IQ9N.LRW4)(M<300e7WPU)9
LM5XB[(8<4^9:8#SL^9:=NEO)dAFFZ)[4(11@-R.V0Pd>e]VgDI_X[PDe0H.^bU,
S-/IC+B@;_b#IfS#9^SVW)(0QS)(5]+Q42I00=D_bMeK3TBARTCR9#DOAP/\Y^UJ
=SX#F[B(7/A::6=C_YJ@.g[bd)EYN^E6)AUO8Z-HJQ(G_.])#-VUJ>@22.ZWTN1A
g].8R99>.1dfZO)5>FbTBHN=5Pg/O06&:)e6E0WR0+5O4NX=CV\IeQN4dbdN[A#1
+d3Zd<L4(/C4.MFP@U83VFUYSPA]D]f7f&A)-F\1L4#_MI)8U[D3=XX+G:LJ==7(
XCL6,O1(@ZgQ_YB7VJS8K.T-bZfcL;S_;APU)S?=?VPaT\d-QG@)POg:bGZbHSN4
0]#Q)_Y4^;7Je3X?-4IJS-AO\OJD_9P].YUdG7;#5&g9@CLY[eN@Ke,eNEQH5:f6
./1?U/XKD(Z(JCHIZg,3E[?aF4QTLG#@GV,/FgV(G^c(3L\aXCTP?IS^7-M?f?EQ
:9:?CJ?9<DH_V8gQ3\cfaZ=cOa.Qa-G]R6&>;E2A7W;5_O\Ad&);gAb<O:4HFQ[=
>Y8O.YGQ\XbY(\77Ke^DdU,ef5P^C^TZ#QRH_c]d9T2YE6cF@=]O;.\eQ@038:E<
1eSN;X&5E+dX7L1Z)_M6R+ZB_+[HNeZ/D/_;>eH/MD,.7>ZMF_c<@9ce.&PGR:^M
CP,2R?&a252e_=dHCUcO>G_,Qf+X3TgB0ED=@:?)WZbPecIZ]H:2@^gNWI;GbCe(
Fg69J_E58H4c8gdOOB3YHcN:VB+:70GE>W#3\L6K-RO(\<=+a>?I-.aEDFSYWVb:
fg7fF?>1X+:eA0>0g6UBg;]T;I?)[@<X8?L9S;>#X2(A)-8[RB[Z@K)9U_WP9CRH
UY82S\S?[5Q6U.NL\@\eCEAbb=<g)V9adb)c8L0V<I4]4?>N:N[[;_:F&6+g3WH9
=XBD#d@95(2O-S+dKWP-G=C1>Mga;_#)#7/7X60J=Re>89XZPZb3>,7WXAMAfGK5
I7K#?NHFHD#U,0Wbc51K5M;U6=UAa>a_V;H\+3-dH+ELEA,1I.\e=:26YZDN7P6#
1Y4/8FfRPR+bB@U2gb^]AJb]Y)P^[J<^aW-3WZ1f[b/ZTNQ\9d7-OUY?XGU.L]c\
_S1;KDc[G?+OKQ\V4+Tg3;1=a0402<Q^>D+W38NYF/Ke.#e-UHAILBY-<B&WP8&1
RB#03&6\:/8]VHe:\5NSP)ePQ<=[_]Y84K)0;c1?2:?35@g2G2Y15D9P6WN?TJ+a
06^E+@EMX]X_UCc]:84<>Y,[g6cW[>YD)\4:5F2ZIU=T8D3(b=bF2gJc1-,?_,Q(
(F[8IcV+.^@1FH4808QQ\-@QAEYLV3NS-JV;IbLTU<S[Lc=VI1[P94#GTR[c_J\M
bb-2#\JgIg=CWO=/KfFF5W_fORE\+L>D/<AEfD3UDI8_]X8-=JId(a)P7(#H8?L-
,ePK_ca:db-T8a51K/aE[-ZR-(gP7@MI<OUgFMN.aP#XaDNOVTb-FH1,H(f^Z[)N
OKa>M+X^4;LDZI\-K(5RK?Ze#eBgR2L2bN;;ZV(OV+.>_.V1a&dc(ZPXK&62SCf0
V).Z/S4E,^DSGX,]MPI/Q1?@^156,&6B2C2:TZ+PKF=-(c57O9b5TZ(5.5d?RQY\
,&)\Q2S(6GfP0Fd-;OTCV4GOU84]LZ0cf]I54]#G;JA[O+^6\G_]3A9Q#E+TX#:Y
(R:7HNK;5+f9N\YTCg[=<[VSKS-;&(IUOI?GI,M1aO:0_F:0RTceP:4N\^>bM6#D
P3569A5V-HI0U1aIJ:8XPICbQ:cTY-GK\GW^P&CAN1UI6UI3GMO;GAb]T81Ce@K\
HC=(8&IPg>:#b/Ga.^&](GJSB5]Wg,HaNP36,VK4e.=C[b[K&^Z]caRTZ_8OSLZ.
(Y__>,;+S-M==1b)-[^HJ727@83@R.VK\(-K.YF]CXN5cXD6PS9LH1L:\<d0YOCU
K<MG&J&+/2@\eba@QKKX4=<,NL,@0[DN.]]NF5)J1[U3/5Q#X3=J2&H6I?Q>:d&-
<eZ0X5^ceb\YaT^S-B;6+;Y.5<6=g-Q=S#C[Oc,SX+fPVb-@(BKW2B.gCE3S?3>N
=#dDA790UU,g3>3aMffZ\LS^N.1@1(OOK8_&[e];?UIG;9[X42;LFY)P[XZa8>;Z
e_@-&gLV.)KW2#\?S0QD\U@B)?GHI6[[C6Q;M](USOV6@E<M8;5MY-1/YD-7-VWK
>2:^8V22YEc&7ZHTO>H],.SCeDRC5<4^(74KXTTAA@]U8FY_27>88/dUT)^A]HD\
DG&#M_MC]fN_VfS<JM)b<F(\?ZP9M]g+,g;W8X^d<,[[@V=Vg7EAJ8-39TB4Ze<9
8++V.RBe_#37PF#E2#3[TgV<U\VETdI.\Ha=(6GS@C[R.aZXbFaggg.(D43X[V@f
_]3Y=OEJ/N]FC_SJ^M6:Q;OOL,a]0(U]<6[c786MMfBWR]B49LP:ffMHe)X5M7\T
Z-eH>E7ZNX:WRXIF9W;_a.SM>IPe.agaP6F;D90O:TD:1U;G<0SB@9T2B,BO1?C.
#8A-74B,fRP3_I^O#<=8>MZU[RNKURL4?G;_##+?4.2Baeb?VD-O7Y5_c5/)ggV#
OUB0Kc3CSBFZQIR@/41OE5be5RU,6P]KJ_UT7XH3-YWXRV9_:^OCL&\2SO\^Z\59
\5&)Ae.^Y=KKTbGNA&[3NSN2JYc-PM&H=,,6SR5dHK)^)a^]c-J;U)(5e?a75.06
]X2H;PN258]./e7ZPY4PZR3KG^I;e:8.40,8Cb[^Df7/1G,@cL,6f?8HeW\G&>cQ
4JfM-[BI>@?<;#8(N-c8gdV@Y,DBJ],bD8FW8P#.3A2PdBMc?T(^)T+_X(GEe:6P
,32&WK]_UQT7QX9Fc]VfMYc_9_R&(]9W?36Tb2gR;7OW?dQ+C[75+(:(LNXE?>1H
gQ6:(C?CQ/:XdB>LVEI59b:+;fK,1RX:>_JYI=J1C/PP-C4.YJdD+)]0a)MY_C,>
RD)Ag\FXe)2]=4aO1L;a1gS1II/Qf<19>GcY:aADHdMT_YIP]@X?#\^f,ER9/4.-
O;EVUMGO^9P)461I@.L9/K700H2&81A9R.=L[@7&<=A>OL,1.gLG-Z^XSM;L)0(L
^_4+<+d,YG^<.;Z=+XJ54c@\(6B/8B<bJa(e[=cKH;,KW+GV\4;#\PK^)gVS]-D0
T#X]=K33[SKIMZ\ePL[?c<@^L7_OBdF229OTcc_\#M2Ze,<=e=#dM^5_NS-/)._O
>P?>512</B4Df[4]X3&Y\_J.-G&#84)K\WM>1H_e4C.N1-11HB9#4\W_aS]/]d,#
7a22b35T#f[_B9a99(=/1#ZdH/0WJcK(QBeSZS+[O@KV5/g+?OL.P;0[b8-Yd5^-
6HU>eLXOcg@G_:^XRfB=OHZ#_Q_eVP=.62d,a&^M#Q:^aR?#<[#82P;MTB#K)FEB
XgI?.VP2V01:>B&gO(.Tee=O:V[,&#SF.UYII.N+70:9KB&0Me=8c#C;ETD<gc\#
be#)+G)LD^8-D=dBA;2gE+?bHASD^:,/c6M2XC5EH4CUYB+#\a:YP[Z3J9QaJKMc
X58T\0]P;7^#WXF=AfcQc6b,b\c9?HWN1_2XJO:_#W7bWTQV/b+_N.,:L&DJQ@D9
BV>6G.Lc07-V&?3@[/#<I9#5D,J[VGYETg8f2f^b5gb_FG#&PA:CBL,c(2ZRP4H=
BJ?D-O&=-IGF](5RS+c+F>A7OZD=EBW^B;3E-:=GdP4MEAZ7<=5F9HO.Z4-9:Y7:
65BJIU<QTAg:>D;PDaCYZb^UXK9a9#d>+)D;C:NBFT5.&U(0AD1-&gS83S,[:0O?
acf0ZbL[<+9^SBF=L>NcPGeV]gV#>0&?g-A9Jd^Sa&_a1[;XU0&RQ[aSCGCU(YW_
[06T0+WD_,DG8Q#^eGc.4^&Yf_B[PfA/RB6^GKB6C&UU,e.>F3&a?&PVCJ7:e+=.
Scg:Y;Q@97WQLC?O7B-;W:L&7eQPI(-?.eIPZ3=&GG;a@<:9=8d.ESeRZX<27H44
g.M-O82d7+GgPbEV/D=0C36cY8)b/OWdM=Wd8DA_FYg\-&eMX#b\^.W#dDC#GP4<
)6.L;7Zf&L[ON+I,5^f6BKg,AJ58NOEQBcX>W:4ZCWd:L=6&KI8I(XTgc;TUKMJg
#0,@&BOa2H2^-L9^c#HJ;DH.ISB<C7ZHN[=eY,;Je712d/IL=eKB,.7Y2Y,9\>6:
&-bW-E;>\O9JDV6IX@E4G?_;Wa-R[W/2D:]WZ]SEF\@(LGB0D-=W::C7P/:[fB<a
2GAdONMFC3=9C;O?JPQ?NS?9S>?></.2fJM56LO5aKDNW3+(?TNR,BR86E5,<.2P
C<c/6]18;(PcOG/OENMa)fYM(5N/b4?gH6#JJ]D&=>.aeA7L@K-6MMRI.^K&YO^B
A6&B7W8BVcc17Af=2]HB)ZY01QRT?HSGTSM:fZ?e?+OYS[Le/.Q<4c&HbKNF)1R<
3TSWZ,dZb91D6NU=]GVM7<0SSc-MN3g\@ZM+8Z)@1TW]2_5S]\@d+;aOe7E4>IZC
+:ac;@VgH/3HcZa_4(:UUHXT.gESMD2/WH2ZI8-dg;FdA4GX-T@A6><EMb(F/?gE
C7(IcLMC_N,<D[2bQ_^C759Of#G1H^FF^O8NZ(/dXPV(_(6TNJ.WFXLf[N<4/D#E
e?04A-3;QPZ2EI]8&SD]+@@K&fLFXER=4Hc\08B@a<U2XN-gAAbZK3+(&Q9=9<X\
]ZHDT?+<Z:_bW]-+N&(+c&:9MIS016gF=FZ&9fNBE2f,U<E?)><KSUSdL:-c21F&
NN]XU4eZN/&^[.S?QOV:Hf)G29Q^EX^E0A9;(RIK/G#dX8abN/,[-.GRFZ,YTOcT
,);(83]f0T;<E.K^<L8_AUb6eBJEOgXDI9BD4YA(/-,\7FL<1e\Q3=&^,eRV),6-
VVQ1S5WG4_+@E+C173\YIFAQDIMaGH)#9-M2E_^?\(5(-T8cNT[&c/C4.;Q0+&O;
8Id9Z>3aWM,cNO77Jb./2?GPQ(7\M7_[+61M8SC3XFQVV>/EG-f^(+&8PW@BE-,S
7M&04TR9-QZ];&,Wa/P8K;MMdBY\GE02+[IO).?+\G+;QNN@TL+;MRE#5W>e+1NS
HE3Y6/ZGe3U?)1O_SE@N:D)c[N=ALFgN9</cG6/KI\;LIF&?AOcG>7A^@:EgO:>;
BG2>:g04X.,\Cf_3.U^dVf:ZS>?476QK<JM-:7Z((D^I7E<B=e)7bP:-Q5H1K.GS
A/&fY.BNCL>SH]/&:]/Q]1beBQcHY,4&acCgP(8[9cRdfcdAeVW;gfJA8E6:7&eY
S0XFf>;E,CXP.EHWT&J>0T+X8ER>4ZJUGJK/EEX>1[ZL6FdJ-C]:TW:d=_e:@#4c
1>_7MUJCbM+Eg2ageN0B<&HeL#cC)OS0_4UTXE/7d@Y6CdgRe.C(8QU2.NCH)18;
5HIBMD(4HU=4HVJ[?UZ=&9)P3MF23BWQQ#:LO=Ag/GV3ZZ;MgFKHeTXDa7GUB;e/
D6#W4?QFLOA,Q/O^ad<#:>^B/gA.Q0/6DJWQ->^@]>JCDc5Q25+^6(#-BFK0^^f0
ed6TB<@+FMFe[aOU_?+G7YbW>^B^F[VZ30OWFM>]>aLQ7Q0=:,4:LXKW,I?=JOTc
EbX^+]AR=F&R#=@JCFA:C\g233;_540+1GG#_O[c\@PYN+YAQZ:R4.ON5.ZXA+Re
A>Y>6E-(6-CVdM>P16.YF(Q#AY9F]eXfgZQM0-CRI>QX(\,E^a&;HOYFbAKZ\)==
:R_+WS]31<E3F&c[0g9_&9[/5LS53X,WJc88CV?U1W-0\C8Wb1gG9STYN8A0G,g?
#(K-/XT.7/6CD#Y5ZQDg[:;5b_9VFEV4\KA&^E7DC:5-J(>MFeENb0UQ[E2EScZ[
0V/8<9Y08+aO8(KF8RSN[O6ZaYZ[_57/(bL/a/FWD155=H@5\UB=MSFB<FUNFfX6
2Ae7+MCU/N=CKQPC2R=dD+RF)BE[6=O_R\1&PK+O[SS-=OUgVTUWB4]_B036(-^0
<L+PTC4.1Z7,H+?a:4f,U1;:6396=?6<)_=S)^C^O6EKc8S0C[,:1CMTF<1aTUK&
BNg&90FC1bL[fJF#;(LLG3=91HZ]^<<;#+d64:_,ML-V268S#OEIU[a<8,F_Td\B
.RJ\4M;\e.]D_8@Mb0.5@dN?+=O794.[R0G2BBY1Tb0f:D@GU1DW;6gE]gXf7G>9
DRO33JU12eQSBR\@.<R2&?R5/BM8K(+S(?,f+^0BfcTL0F&eOX](NY:K^TPSd-e0
eL(_#\eKeA1>-KcFVdQ,+fe/#3,F3]aR:[;?R(,2Y;6QaJgc@6/GfG9N280L>+1A
e6RZ:92:M0ZHd=XH<;6THF?27>VWW+T\9N>-K0f:DBD4a>Z?e(?2MPLgZA)(5[W,
@^5EZWRM)[&AWHe=>U&Q\6-664RZb0F(e]IC?,Ya5SBME7H6TR55IKJe9;2cMD56
8OPR]d/J3)d@4OZMc;[]]+E/DY^+f>2EF,[JdALKKOTB7Ug/I,<XJC+BTWSJSN&?
f4YHS#,4QQA7NW7[LH#+E1WF+:J0XF(1Vab&396-,XM0.UbgW1XSTM]@#Sdb-g[-
I+@YI=KfN]<_AMKL0-MNB&U[H7X6&.(ebNNL7^c0^QFJd,6/W76M];&C&cX@SdS=
8WJ24JO7/(P&?XV#@/A2?#3XWd2UEL-@_QSW?A)KeT@FW2<^ZA-5\c5H=\3^+IL;
XaX0A=@T^7d^N17B<12<U;@G)EQ7B3aE/QaSU54W(eCEGD>7G/KA@?Z&b7BWbT,R
_6OUc#=?N@NO.=PeZD\?,Q#T@[?].2Z4&]8:C#LUEXgE5>g6Z/PN^^eW>WN5#f53
e;(S:+R531-ZB;\>R(U_DNE35(Eb+(F,V4VLa41?J2?#HE)-^^.5.f<B8WFfNIF,
;IRQ>.F.8CdDDUgDTSU1^DGg&/P(_VI\ccC7/O<R0,Z-)I>US?#bK<3GB=5La1_7
:28/;(]V^\CS92.1Z\;5eR+)e_V,9.f4+\]Tb-+<KPOP8LI1dFRNKfIO2>ef3WZb
eXV1#_,b9YD(_KGD,?Q=W4#J3FTDRE<eeb&H2<d9SM?_\N@,e32]<CGAZV+H2=#b
\=X?X<^.b:L/M&@e@7V\A?I:Z6@Y/O^11->eYLC@ACVUIZCT^GX-7I,#cX3X??U4
2<0;G;ZIMS^+_L^0f-V4_[aPcS,DE1JH+O(3X._,0#,-+8D(R#Y#I9VOe,5fS?;X
2(6S.S@<aDPQCZE&FG66D7@I_9]3ZPP/^NAI^cId&@:f53S47^aNTPSF@C5J2Kgg
NEAIAL-FTf3@4dHdNWH9<MU(7]bWBB9(]R7F>=-J1aYfCV#S]J2=A>?2<2&L5^54
M/SPB50e2Y+c:<aQ:&SbHQ0I]aL4>@=g2.+dTRB7,T/@1>RT=>]=B@1JG>&c]\E<
>#7bd]QHJ=3GRabT<<Z&,(0Y/O/4Ia36&),P/J;0[@Z60BKFE+cWI+@\#gI38S^D
RK@c?Oe?;YS(MG,/gG0X9#4+N9#WVOX4@NG@eRVG(e+/G@ZB8@ac8e5Z=aG9+&20
B96O7O,b+IM.;QL1Z]B\;QZYOT9H2Kc#cCf[cJ=@_ILXUEe_<1K/B@JDN+eWK?,O
ZUIF6OHNENB0+P9P?W+M\+;GU<bB0O>5/9G@U#O9LEUf=O&81E#dbP?EgJK]1T<;
(a@V.K:B6C<(A<WgV:48K7g&+:,G/;Af@$
`endprotected


`endif // GUARD_SVT_GPIO_AGENT_SV

