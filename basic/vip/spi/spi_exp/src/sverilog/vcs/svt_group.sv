//=======================================================================
// COPYRIGHT (C) 2011-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_GROUP_SV
`define GUARD_SVT_GROUP_SV

// Only compile the svt_group if VMM 1.2 features are enabled
`ifndef SVT_PRE_VMM_12

//svt_vcs_lic_vip_protect
`protected
bUgTMUd,H#eaecT-^H>FM2#a145LIJ8bL6HYLO<2aU[38)(&B]]R5(8SCBX):#ca
0@D82dM7N#D_eTf/023BM?>I_4I-BJ9M07U:JbI/4b\aE&\;dOQ@D==e&3:JP\NN
+]aBZ<@V74UB#b6;AKC3C[>((K,QQT<UIZ:V<KNPb_UNT]dNe^?g3_04@-P)/IH?
Q7S];>]_.56;0\>8S\A)2ac=M@2YU=T4G)fIW[&B)SI0,GIO&b?dI_UWDA>^SWYI
&JJ;.5\#c9?K_bQP[T/92;c=8$
`endprotected


// =============================================================================
/**
 * Class that provides the basic infrastructure common to all SVT groups which
 * are based on vmm_group.
 */
virtual class svt_group extends vmm_group;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * Shared log instance used for internally generated data objects.
   */
  vmm_log data_log;

  /**
   * DUT Error Check infrastructure object <b>shared</b> by the group transactors.
   */
  svt_err_check err_check = null;

  /**
   * Determines if a transaction summary should be generated in the report_ph() task.
   */
  int intermediate_report = 1;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

//svt_vcs_lic_vip_protect
`protected
HM>9]ZgN@11]@fC0200H6Lecd(A9-gVILR/9cRg37LFYf?ZFN(c>4(6/db>6,Ba4
^;]X60b\-\4CdcH8d==PPCN=AM^P0^X<VC.--)BMCG_4eD@g<E/)dSeBC#.EeDFZ
1eG<]N+\_+RP>I>_H)PQ@KaHL<BVc(L8FBQ)JFH-[+Z512N4UD:KDOdY7dOeT-);
QSCIbHFPX_ES?IHd3/bL/F\,T?@;^g//;aCLU?eA?]O;3=4d2I.?U5&7#VAX[(b8
M@6bQC9dSA2285/g=X<1E1/;FZN/Y=WTQ(Kf(34<Z(e<NN)Ma;JKT?Lc+F6;b,V_
?L39/+X&fJHE2RXS+#@RE1]DgCXYccZ_R\.]QVK\F_14RXPg(92]e,<4EG(I/B&H
aT+9OC8V:VJaSV(T-b5JD92IUf9HbGRd;P^9^)/D0E-eG;IJ9-c\N9E)2=A-OaI<
TgZ[\A77+X6T?SZIed&;5?:M8Z?ZZ=NP9IEJ\A\X-T@=C(06f:&A?1H/J=dN[W8a
g+3f\VF(U:<M-SAg=DWXd=XCA&+(K2=F>TE=VQffSYC17B;g47a[8_FaUB2>bc<O
1[J[.#Nb5d(LCDF&7D/5\;1&FL8<I>O3WWL;?0:=F;B3.GYfGR0F8J+.fH0MYE2M
a#91cGI1K8^N\e):IV?MFL.1(e@7B&TT>S@Cb:b<3DFZRI3Wb#P(7C=U/=,_^Ag:
0(HBMQ-AX,Xc5(R81g3^Y,=KS-cM2<+ANacW6aN;[87@)[L.X2\L04[-=PO2J)b?
T:0b?ddW@.393J1#ef,_/IS:/Z)c3N3N75E:S)8YdELgf7>B<Y9<2/4E.N,SRd<a
N.#e=PU,61/RPb0&@.4PV#D/><d=c6?.(&Ha=ZU)5_RF@f2C,/HU;+:3FC9bfXUP
ES92,2)]U>NOB,UGR4Q?8b160:9dE7KBN65BCTKd_YfZVEZf<AK(2(#Z85QZcHTF
J\?d3R@bd5g(H7<;R#&5FPD/RRMJO>(JXPYDGK?Bg5VdQIZ,)EKPg-R@E&F^fe>e
CSd#RK<P_FB-<;J5Y-PK/WFI^\f6e/fH_XNCg?UCA-Hc.6BR2D<S2c/cg7b6G]RD
X266V]Z5d[::VR1#_SdaOPOALG909fecF(^)?;@R/LE94g7[I7V67E@JE@aT4De>
829RW,@VBO.+&A^3-G&f0I[9cMcDdW7HGTS.]&ZDA0SbEWR4HA:<U5K@;(TDJ45a
L(ON+?MCcV?)Y)Y)e;de_2UI[3W5AJ5KY<<B&GBR5U,5,^&TGc>?DMKIG^IGBI:H
dfR\RMGIdYJ-daLRR&0d_N;O[X:6DdU>5[Hg@TVE7Y4&DH#)J17JN@U<KFGLW2_Y
fL^g_^)7C(&U()WGRIU,E<1D(K;00+.ZZ6TR5HK.9CVB6WPA3_O-QaJ>VHeX+I-5
?3ZGKL\].4aQg3T5=M33+Lc5W<Ag^37<K60ATbGW+9XG]@&:OQ\(;+P9,7aY3J3g
Ee03A,.e52H@KR8MLbSWK9c54$
`endprotected


  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new group instance, passing the appropriate argument
   * values to the vmm_group parent class.
   *
   * @param suite_name Identifies the product suite to which the group object belongs.
   *
   * @param name Name assigned to this group.
   *
   * @param inst Name assigned to this group instance.
   *
   * @param parent Parent class of this group.
   */
  extern function new(string suite_name,
                      string name = "", 
                      string inst = "",
                      vmm_object parent = null);

  // ---------------------------------------------------------------------------
  /** Returns the name associated with this group. */
  extern virtual function string get_name();

  // ---------------------------------------------------------------------------
  /** Returns the instance name associated with this group. */
  extern virtual function string get_instance();

  // ---------------------------------------------------------------------------
  /**
   * Sets the instance name associated with this group.
   *
   * @param inst The new instance name to be associated with this group.
   */
  extern virtual function void set_instance(string inst);

`ifdef SVT_VMM_TECHNOLOGY
`ifndef SVT_PRE_VMM_12
  // ---------------------------------------------------------------------------
  /**
   * Sets the parent object for this group.
   *
   * @param parent The new parent for the group.
   */
  extern virtual function void set_parent_object(vmm_object parent);
`endif
`endif

//svt_vcs_lic_vip_protect
`protected
3^L80PI@6:4@9>3@HHV/RX?17O<AT9/PO?)e7MB])X@SeC,MP9D]1(V8_;7e<Bg=
GZ^@-816DKbZ-e;[6]9G[ZAH]?MH<]_H0<cNbg#ePP[9@#O\_M7)=\XIRY]/KDdd
BK==Pe_<OS[?2L5Y\E-CYN(eK<;a2fAb,c5LQA/;=/[+aJ[<TS=)P3\&T:&1KZ.4
U.OKR<J[.@b-7U[5:+^-FWNg>[#RANYZ9P/cU]3BVYFRTVZ4c6D2F04-7ebZ_-[0
A;/+f^CIODEY:SJRe(ZD8\a\HCEG1JAUI\K<XV,..-fZHXHUXI8cAg6PXQ_(1D=1
KGU&1DILF6HRSV&gAXM+W7a#Rd>\]3KcY8,P,<PY+6<5M_)FG,N(CW2-9=fT]]2@
+N:#[^?S)9-0]<5O9;U?3#6,G#HQb::55S#G)P#((E,].Q4H5S(@R>3,&K7]E5I[
F[[IFbY8\U<B[MQ<<,O-48b/34)O;O[:&c&#_W)a?6d16RC5THCJRM3,I$
`endprotected


  // ---------------------------------------------------------------------------
  /** Returns the model suite name associated with an object. */
  extern virtual function string get_suite_name();

`protected
aQW>P.PM=VDX_IY1;?H_J-[2KQ?J8V<8/fOF5d)E;8OH8<EAdeLE))M\.Jd<S@(/
^B-<75[:G9@P;ScZQH[P.[JTPW[/PgTVdZV3BBgB\&_F+Y6A4K^Q[HQ),<J_:5#R
@CUN=S2\g&cP/$
`endprotected

  
  //----------------------------------------------------------------------------
  /**
   * Updates the group configuration with data from the supplied object.
   * This method always results in a call to reconfigure() for the transactors.
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a copy of the group's configuration object, including the
   * current configuration settings. If cfg is null, creates configuration object
   * of appropriate type.
   */
  extern virtual function void get_group_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the argument
   * into the configuration object stored in the group. Used internally
   * by reconfigure; not to be called directly.
   */
  extern virtual protected function void change_static_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the argument
   * into the configuration object stored in the group. Used internally
   * by reconfigure; not to be called directly.
   */
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the configuration
   * object stored in the group into the argument. If cfg is null,
   * creates config object of appropriate type. Used internally by get_group_cfg;
   * not to be called directly.
   */
  virtual protected function void get_static_cfg(ref svt_configuration cfg);
`ifdef SVT_MULTI_SIM_EMPTY_METHOD_FLAGGED_AS_UNIMP
    int dummy = 0;
`endif
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the configuration
   * object stored in the group into the argument. If cfg is null,
   * creates configuration object of appropriate type. Used internally by get_group_cfg;
   * not to be called directly.
   */
  virtual protected function void get_dynamic_cfg(ref svt_configuration cfg);
`ifdef SVT_MULTI_SIM_EMPTY_METHOD_FLAGGED_AS_UNIMP
    int dummy = 0;
`endif
  endfunction

  //----------------------------------------------------------------------------
  /**
   * Expected to return a 1 if the supplied configuration object is of the correct
   * type for the group. Extended classes implementing specific groups
   * will provide an extended version of this method and call it directly.
   */
  extern virtual protected function bit is_valid_cfg_type(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Used to identify whether the group has been started. Based on whether the
   * transactors in the group have been started.
   *
   * @return 1 indicates that the group has been started, 0 indicates it has not.
   */
  virtual function bit get_is_started();
    get_is_started = 0;
  endfunction

  // ---------------------------------------------------------------------------
  /**
   * This is not part of the defined VMM GROUP run-flow; this method is added to
   * support a reset in the run-flow so the group can support test loops.  It resets
   * the objects contained in the group. It also clears out transaction
   * summaries and drives signals to hi-Z. If this is a HARD reset this method
   * can also result in the destruction of all of the transactors and channels
   * managed by the group. This is basically used to destroy the group and
   * start fresh in subsequent test loops.
   */
  extern virtual task reset(vmm_env::restart_e kind = vmm_env::FIRM);

  // ---------------------------------------------------------------------------
  /**
   * This is not part of the defined VMM GROUP run-flow; this method is added to
   * destroy the GROUP contents so that it can operate in a test loop.  The main
   * action is to kill the contained component and scenario generator transactors.
   */
  extern virtual function void kill();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual function void gen_config_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Enable automated debug
   */
  extern virtual function void build_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Route transcripts to file and print the header for automated debug
   */
  extern virtual function void configure_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual function void connect_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual function void configure_test_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual function void start_of_sim_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual task disabled_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual task reset_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual task training_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual task config_dut_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual task start_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual function void start_of_test_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual task run_ph();

  // ---------------------------------------------------------------------------
  /** Displays the license features that were used to authorize this suite */
  extern function void display_checked_out_features();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual task shutdown_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual task cleanup_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: If final report (i.e., #intermediate_report = 0) this method calls
   * report_ph() on the #check object.
   */
  extern virtual function void report_ph();

  // ---------------------------------------------------------------------------
  /**
   * VMM Run Flow: Phase tracing for automated debug
   */
  extern virtual function void final_ph();

`protected
fGQA@c]<+42@8Z:AF6Id:7BC+.&F,2B,=ecg+:<gAAGP8@<-)=CG&)fN0A4/><CH
<W5f)[B,CZZH<-.ccCcEV()]TaUC6a+RJeJ)K2,4[6YCS/Y_D)(B<BRfg1DL3>7.
SbFZ0WPb4(LMJ_RC)U3O-L1T+)8@cW[=<SC/?>NE96,[4fe(K4g\.e.edNVYXD&-
PGNe=]H04RCO8+E6VCKfOa5I<U&b=8]1DPe_(f\GAWcfWQf+\3BB@U95<J^MJ+;B
U#5[\UII&)R5^Z-4R,SCCVO8S@]W;318G,&NIEX,Z3\X:RfXaOadf/#^I#>D<;#6W$
`endprotected


  //----------------------------------------------------------------------------
  /**
   * If this component is enabled for debug then this method will record the 
   * supplied timeunit and enable the configuration properties that correspond
   * to debug features.
   * 
   * @param pkg_prefix String prepended to the methodology extension
   * @param timeunit_str String identifying the timeunit for the supplied package
   * @param cfg Configuration object to enable debug features on
   * @param save_cfg Configuration that is to be saved. If 'null', then 'cfg' is saved.
   */
  extern protected function void enable_debug_opts(string pkg_prefix, string timeunit_str, svt_configuration cfg, svt_configuration save_cfg = null);

  //----------------------------------------------------------------------------
  /**
   * Function looks up whether debug is enabled for this component. This mainly acts
   * as a front for svt_debug_opts, caching and reusing the information after the first
   * lookup.
   */
  extern virtual function bit get_is_debug_enabled();

  //----------------------------------------------------------------------------
  /**
   * Function to get the configuration that should be stored for this component
   * when debug_opts have been enabled.
   *
   * @param cfg The configuration that has been supplied to reconfigure.
   * @return The configuration that is to be stored.
   */
  extern virtual function svt_configuration get_debug_opts_cfg(svt_configuration cfg);

endclass

`protected
<G>e<:#C_[Z^>8#1>88fY#/_+aW,Z6V)f\.5;cCO-D9d?O,,1B0D6)#57#/E]^(L
SN-6-M7NTZ#23GT@a_??YZ:XY0U._g<d-5>WLQO2AaMU60/&PCeFWc-@+d]DgSB^
\J/XR#MS-VcW#3;\26Z.:Q03US4>)=/8F#L>),V4)A20G6(&P+eW_UV5b.>4-X.N
.H.JYY+Z653bG5O[:6JH;GbC+9G/@XJ=2.QSM#L,@]?P1,,[G9eD-1G@IA;H97R-
fGKGS1.8X)HU027G:^1(RDM8bANG;3W?Y#=cGX9&JP[KY8@3PUW7MBe_M.ePZ1bN
Ud/O\>1.0=.R<W#YQ]JO/8(UcITBKKICe)ZVA_S2#8b9V;Y[Y9OYP+E[=J[+Z7TD
IcBaSgb1/Z7b]:5#^X;1DVFY@]\.?H?^\8\V.B_HE3R5THM)Yc3;?AU_gDV\D+;#
B65Z.GO?E\:)bPeKE:&HTH.::V)(7#SOGe:_<c:4\;5#3H7]Cd>:O>A1,JBMJHU[
aTRTT2T,6#7#T:UMf_X4XT[I6>T^C(1+O;2M/H6E97T7PY[bB1^eB]:EQTY#+/SK
K8ZLT2<NNbVf<Zc@6Bf+_)5]1G,0dHG>O)7[f,WX+L,L<TF].<I5,,_4_9]A;b(0
Oe@e9,5(@8MB09HW3DL00N;IHb:I?B0=8_BHe1c-K,G9Abg&X7LKE0_FF,gSQ/K5
G9^#AKfeB:)QJOe(c;77FZS[c:P8g[d9=<[&J3J[QEMDRV79>Y,^<,Z;?0T>@)SF
aJa&-68YZFKC045\YE..3/,d,J5WHVJMH+N.K3#1:(BB4JCO>ZIES>b,81aJ?#<I
TYJdE:a\)S/W[.HgMRU1=W\HG>)5/5,E1?Y@=>1[O-1^I9#AJQ<PQ;R_cCE]IL1=
9Sb1J<HGR>a@I;ZF-[1b-_--6e=IQQF>;6[8G?RQU1&c;YCO;U#A6:KT,RB^ba]L
H,fIO[U)]TgSVRB+R[]#3,IEEN=b:95<b&Lf8:JM5-@TMA5>0X<J<P#S<c17904M
]1M>L;eG:KZ.B;:,dA8e,1]OW9Oa)RWE:DOGHMW+.F(6aCO6&I5GZb>M?<CdPKa&
gg.L]]P0/0TTK]Q>LX?5^[9CgMMFI9e32bR>X/>>8fXI9/Ce&a+-f<Ca1(H9[:,C
N2WI<5LMCZb]ZS?L_L[/BD.bT8AAd-]:#632^GAG:B<+_1R65K-0@eH7C<6Y)5RS
=A857I?fB@+aeY7TW7_UJ+[:Ce_[T9+b@RBYA/&_8&@M)VY5&^V242Kfg)_]M],(
D0dd,g3>^Q#ZfE:#8PB7&@\?&WX,6CQ/-H:8C[ZZVgZM#,6.^Q,1O_N?<d_<Bf#(
ed>UL\CBW[1Y<JAM..bCd;ARP6)9gQfVO>J9HD(e>Fa]W;g4UG7V\2GS\8^;cc\K
RBJ9N7IRK9=-3P<2N_/7DaAR4$
`endprotected


//------------------------------------------------------------------------------
//svt_vcs_lic_vip_protect
`protected
L:R)d^HcTb?.0g^ILM9RbT6(VE/OVZ^HKgWO0ELOO(#<W>bMJGf_3(X>^_>NTH&]
Rg2F(]Z_DNO<(1HOKTHP=aE9.QRWVaU2b2Ja9]_BE7^5AR13Xe^-We\g7Z4Z6=09
+;EU.]>P5D4/N4IBEc028W.DHQe.cJL..@FH=JgXBD&VC23WT83<34\eROB51@A=
Sc@c65R5-NSCO>ZX&HY,b?;XGEH(PWP52e4f:HN1Y98=?O7+LK#OgPJ/fV32W-H2
_D<U-EdNaX[L\8b@+QH/4BH]CfDBS;PQ6fVEDg/YNZJgP&Xc(YOS=W-RY\_UX+I]
O76Jb7#-JNc-aeN+=^>DI#RFgEIdT_f5PfL).;+K4,DV.#,S<(_e>KI3\CIA<Z>1
V0@c5@c<T>f@:LYNM?dW@AQAQDE7V,(b/9GE/38Q0NKIa?G0YSg/VA;[5W(g=3Y4
UW055LN>,1Ed[[#]1#ZTAWQF<M5KB:+C9#K#P79GG@MPe250/B^I603bMaf9H1-M
W.d0_7WQ>G7J>YC4C8EA1IR0Bcd-XD5f=4DHOLRed>&Rg9BbgS&_N^26_QOaA,Wc
?-Y7@\Q1B/e@[5=(D^;H,H=ZWVf>b#)T+fW\BAC>aF5:_>6;G^Y?RR[J.P4[J[>/
1CcJSZR6#2O2(f]NX6TV;dCRAEE<\e6a3OLCWJ_agK/&IGN88W_??#3ZTfd(SJMX
\27&NNFYfTTPg@YB[3E/C[M+5,\DNU>MSe2fOS66/eS82:84Yb7>L68L@<#E/BUW
.-PXBXM/QDB)f9J(bR[21CfU8W\QZ[D^DLA5NP?JU;5M:_Z#_^,#cM>&.;<5N)Z3
Q&G\[#V2bP_A@da([-Q#UWOM?EUJ-9):A(@R)TceZ#c_5604BNbT+:&/RT>H+dXU
L\J)91\CM7V>ZZ(T4371]OaOR[3=8bCc#QA4IA6+02S5S-04[F9P6PC?f/ZIL_g5
]S3S0GA?F:PLW+)cg0MKDZ:5cM30?<S.67+8/HD:Gb?fa\CTK9M^S@?0R6OPK.K\
>.@Jc(<dE(U?]02[a#3T9XY4?DX=,1<NUe^ag?e.@e@2@@+#;L:X,L-c\R,IMJ@.
c]L7M-(<+ZEWf>TfM+8F=B4D@2Db5^U0a.a_Ee=^dGS\MO?#3>R+:.J=0J;VdB8.
7gRNNYgf)(P]cG7G,Yb&Ya30Sdb:<7G1&W)U#M6_5EA.K2^[2^#+6cB6L#H[(_4A
ddY0G,,LX4cJS4J(1H4cAJbFBb0\3WU8/aI70+RAA9&\N(4>^&.-1^LOAg;I@S?_
^X&V0X+Q6P+[L=&>TU<^c^QAFC(K[MT7ICg9:/1JOW:PdPPZ,_ee;[TAUR+SZWD&
)\#R\]7BHYD1A=+T(DHdcHQd_P(GH6e?=bN^gXHOg3D27K<Z]B3HH2\@A)f-XDb]
M@&F3)JUU.fE-6Je]0R[R?#DVG(;IV-90.\@&^GF;T5eM<><?8R.Q^W[HEB^E,QK
VFX@ca)X.R]O;\Bf7RSefXbbT:8Vce(@\_>((2AI@SH[/OCfN=?Re)695D?-0G/Y
=?gCAA>Fc#B/Na,+I>B&@[P?J,ZQSH_M@H;\f_^=:<MAH;4TB@Y@]9MOF=1:49]d
UB&I&Cg[U)\UB0(Z&cBMfQ+S?DK@V)K(>>-;J\UFNC#E/MOb+,ID6]N#.VGZb(-b
H&]?JPR6_40bc<E9&/Z;JF_0#>aF+g&\4VDS?7T:_=&Pe5D24-)g\0?beV,GXPU&
O0V@1:F2#E5@D61aA0/1U5/RP=,59\\KW1gY5+?>Q#;&R/B1,+R,ZR3AcC)T=eQ;
:WH/_D:fID85C+Z991P<7@1=]9V4T5B;#F@)1dJ7g,T+G>ZaNYeIG)UU+ZJ4cT=P
7.BFMS)fG^+1/YHQLPV&CGK4MH\HDE6_Z=8Y=4ZR<0GGQK7(<Z@2S.CQ6J6U\@ER
7:_&&V)P==L;00-8f]FK2f0B=D^&e5@0ID>>(Y?-SVTLgE,b_9UgE_W6]+fY=geR
#L/OIZ0YRe3Y&^,1DEGBPS7;d]09c[ZME(:YE9BCdJ[<\J4L]aVBK>-0CVb,bdI(
gYV0CQ_B2+cD=9GIXEVKcQL+dO<f9L:Z4J7]ga-:(:(2V[P<<VKeP\4#PUT\b^I^
=KI)I^Tc;J.,VJKb5UM<7\]^@RNc35ZUZ,^G#4aE&[?f8If+66T5WgW)MT#:O4&3
TY@QEF&4c>KKf4cV)ec-E5-AOHLLfNCXD@(\)ZKR+A(54<?T:H^96VFRGbMbVe>7
X#?\TS_f6@5-X[:3]+:=\DZf2)4BNZIZc6\GE4/@[)=_-_GW>2:&]G4I\4L.caL]
/C4)AV<:(KVF8+>D<UL&<R.KFa,L_3KLg:Z]26_,^F8+=T(67,-=<G-_6Y7<-<.0
RIX+^,2)DKK./EcbZId.a-<X)Nd[>J)ZC;d3K\M+f)MXR61+a4^6+YdOE@6O)[(>
P)&C4F<.eVIC=L^6/gOTF#dGVBB,/7Ub0H7a+I#0F=]WV]a#8\-<+0SB^N66,QcN
A/)45?aY+26G;D+\c.[1da4^A,)_?Ydg01NL<&ZQV](dG,BDZIVETd_cgD;_]WZT
^BD^/2CXCPXf\N>A-@(S8<U;e3d-H<gPN^3Q^Zf5F:QSgTcU^M8J]A]A][VUcXS;
UV-<CTQ@P/[P,7U.G1X3K7QJ=a]_N=_#\1[XQ2(^V^&\P.eM)SXD,W1aJSK,95Q:
\+gQL-b::KdF^WJ/e^U7F]ad79-.UfaK_[7P+=>^?OHG,WO_:^/D]-D>PQD,5_gQ
U_TS^5g2N@e<(dF;UWXGDX[c5A.:J65M;BG9?&HC9BbH3S6V]:,2+AKWWb/5P.UF
^C)W]\,Yb=(C/b:B)CII.PZ,/bM<QTBXB?MW^@I#5:::I8>VdcC8:CCAcfOJ\3P7
>WR#L0N_L\WA\Z>#M^?1P@:]ZaE_WbZgRE&-c4@MbE.a(1VK_2BJ(J1LW.LfgWb_
R2FXW/d0Ob.J3.<g\6+W^_2&718Gd)YWSg_6M8=[)9A=EdgD98E0[HZ[:9=.D\df
JfVPGAY)4R.^]Af2FGbWc=/_2,3aGK]0efPAc)9CW8)UEZ^28V4MT^H@/^=UZ<[@
R>gX058cJ,[,GWYOZ).:HD?132R-GBO+ZW+>SU\<D86+DB_B>JcYaZ5(^,a#.Ne\
X.?(ee/27-.EH(?D;L(_)#LSBa2\Df6ge\6:?adM.bd_/(N3[bHR/TBcB/6(5RE4
g@C6YJ/\cX;I<LWV2Y:#F\/_N12X/OL=QDc:agWaJKaU6=27?]<O0,U^<EL78Z84
.-g+TA(I&T,Cd]T(gF;a@6LMU(ZMSAa,KV_F7;afag@>cF8YP@VUU)1)#+HZ,F#G
7cf[TEH1)T4LL/AafC>SHRO<^Kg/P]V)HKLgaZ]6^U<Y1CRVX_Dc<.G:aE3VC@B?
9;6CJ^VIc0&b3f9)-=K-XC(KAc0,bVHG)5HQ9_b#(>CKCN3?P3EYL7c[9\QZRg]\
TM,3KMbfW_XRV5W/FT:R:FNW+,_UG)B]R@8.0B->05cf(]_Zd0J=H#d^e3A=e\KV
WgM6T_FVW+[LeH;71BfR2U)56]+9bc]3Jeb[&&eV0+U69b;J6>A9PUcM1Z&4:9#f
K)LWAMS_RME,:S<NT\1=Ja+FU]0bZG5]f.36\P#=FAS._ATaVX).-OGT;@>W,\U,
+E-WbcMDWHJM6E[dA_9-9^_HSMU95:/+L+90J;M;)Tb7AWY+K+ONC8VN])^PaYKH
200TbXX&;DO1N/WgCIAV8)4\?^-fS<N]G)Kb00@faDf/AGb#=JFGAJg;>8@2JfFQ
(e=d>MZ=>S9NB[;-V+&^2,N.4b)H8UWKK+3Y6Q\]E9;e/YFeN,^#<ae\+Y3PY0,?
Y:IMN7cd<YV5=K+1FeWa?-?<5;T_,VBJOfT8Z:R9&6^01ZPdaS&8d&E0O,Z?M?QW
>]6Y<+[Wg4N(6>[@_F6LVFW]]:9FDZMDALF)bH9IS(-af#N6cC#-U9d4dHc]E6Dd
,--G7cVN[8eYD5<_T7=REG/[9ZSf@GAf(ObbAc;#0L#\MXMC4#Y^?PMW-H9D&Y5,
=O&dDAE_@5Ha^&LC3#(=6+XUE^:4CZ<7AQ.f6^&.H[\geZP[XP?9+9PPU&O]5<Q/
3dPce-;fN8fF?a8X6KD\Zg,D)g5IV@Y<RJWN4dZ]eYACH_,:Za@=;b461EJfdP_B
H5f1WECG_Z17^8gU0IX.OXU;369OC-fU,>BbK7@PXd.g0QKIWeb(69H[:DY]Y>2]
+0\+A:TEQPN5M5WN[OaKH#Ua&2P;?03B3g:BE^HbIEKbB+4>8J3#V>Re81D9)BQc
NZCKS\X#H[?_U\FGg^[fT07ZdL>F3EM_4gc4D(P+U(>RXZFE9^->d&+?JS=QO?dI
;M^\CZ-FZ@2.A/NL#K0BA^WKNST]+TP3[]=d5\\4,.^V&9a._JRCYC86(D?L5gN)
Yc-0.>MOR:L/V-_CR]#.)T9a2>g2V>9^.)JC>T7TI;+YGg-OW-R;[/1X(g4CRgLK
EI2<6<>.]RX:?V2_7#-B);KCME\BZ(((W/Y7@(H@?QC\#YeI?gQA[3X+-9X[APDS
B]I55=?C]B0GY;bW.Kb[R=b8-(Q-a6a7,SbCZa(6<(6KKf2_U(P&K+F2(&=K>AD=
C7K<ZW4Q5)FC1b\]1(6(OM;d86GOO/=;,IaT(/g4>5?6d9aQNTUPP;#41<4X6dW@
.OMd=G.X&0e@47RV5@2(@_#:^HRL1)AC=<\eI)/\UYc>3^J(=MS(KUVSA\M4+#>A
SC_I_MOLVGPT,77HbJK\W609g6P(-,3Y0d8.WaW-.W4f4@O7X30QN^RL7=-(:)Xd
-0Ee7YTY/(@>H8>3Jed)W^(M81#M-HI3=a_#.H;:aA4b68Z^S]XVI4T2UMD(XU>+
Ud(>Ma_DBS_60=AgO[QYe821DgJ)A9,VPVJ@5UC1Z/;aKgF^&X9gM#+EH@^L/;QU
039Pa:QO/(Zb]bZI(gA^#-F&.aCR)6.:BXZK3I798\d==ZYgD7(Rb4cG-(+dP_2[
<3g)S.9L_5WL^HL\G==dbFAPGQKG<EMMI39:)1&@@9U4,O>G-6?^aV?4)UO9H/9@
L&+:0;3?C92[_DZ3eaNU9/ge<X?\(27RG]]/QG[2<6Mde-4L&ZJ+<K>A^bcW-5\f
c+X&R9KMBC#1A:29Z+Abe=EaUL2_Q5@#1=XJT[R4\E8=Bd&)Dd2eH81JOM2R@A&@
O3c@9X<e#/09IL]B,egZD.BK/(&)S@+4HH&^,(J<,5Pf16g/;c#gSJ194SFB.cHW
TScC0e^6@#4\,5:<>eGH=METCc(]M,+&S5[[J+((H;,AKfMR3^R:AMd+1A>R5;ET
GCO3A&9cJ+E@9P]/KC&dG.9Z,:C<.^5LVa.BD=[gWM7=#1c>\/CO=],9_>4f_H,e
[XE1-1)2F?OB#H+3NO.OP;>WRY;2)Xa9.0,N62DER11R@SO?AEa4Ff)LfA-Ae]G2
?Z;d\WK6M)bJ=HJYPS@7N:.>>[B5/^Hd,6CLZB]aPIbJeZ0YQ0:#\:FI6Z81JO)D
SW9[J#OJTB.SPQd#.V2fN?@YV2-L6YJf\\N0@3#ZH=R.[SQ/8Z1/I3IX8ZXeg#3A
#4Ld70;B1@Dad@K,82/BL>4[[1GPfZ8S^JGNNNB7)PZH]4e)#=)8X5I6#gT4<5N-
CP4:M(^/&LYF9CAQIRSX@f9M<NH8YbgD][@U&cH[5H;(X@,eOVRUK\XW@Pg\6E;Z
JQ_JO)=V?#X#.4?J\0;N2#gBC>C[42P=WRI,;O3M(ZA<).FaO\,563\FBCYe-8YW
c7;W?UQ]Xc,SKJfa7QP&.(QY=^caU.f@+N/K;LQ>TM)85\#-0L@_A0D7#eAf<d;P
)f4XV:b(QO1F<_\=>V?V5UO>9AgQR.>7=TC68WH9]Q4OS0f8R5:>;Y+^B5N)CK,D
(e+;54/5B,Hf6PL0(QfRF8N,PJ9Z[F<RDd85gQ.-fH&L=B4&P&G4#5784fdgI^f+
Cd^2;;7;<DH/&0TFKGJb-fYAZ7P:-N)8305FcP+A6U@f,VC5a#Agf14V->#/Y>P.
APC]+7e]d+:0;N+U]_8XFLLg0ZA=?RP4Zf6_&MZD<FVDJ-W#]7[.\H<cPP=5\EMM
W4+VC0;.e0E:7UK0E0Y:T+&)?ASEP>(1V@CPIIdRH+fU.YWQa[-48OV0O2CKD7@P
JA^O)H4<2DZ9d+8;^:CL1,D,NVE9J8.?-0.Tb#gP.2I\@b.:740:5&SggA\7@+58
f,]gEcOfK=;eHe?f:YDW:S9I0E]YX4E(aTa1NfH5JS8)Q;Sg&)V8HdDY7P=>-dC]
#2&Q6<H2M3(c/H/FDJCU2];=a11]XDNLL-XOLSKYa[&X@a#X,JdIE=<PJ;g\2YZT
XN2T^0REg4B&/b7)c1dT<R;&O;PabGEL-1WFGGGH;BgSa)N-X3NJc0<RENLf)[(;
PUaFN5M@7D^0-O?74\0-@/eB<GC1[+D.5F2d;8:,]fXU3Jd:-WE90,2W4G_12?\M
98Z(+Ac:N9F4V_B4@QVZ@-/:CHG>:.MEQJXe;K7&A^Oc806BA+2XbR1?+,4;Z\:T
5?0ATcUQ1=g[37EU1OIa;Q+BNA1:UP7\T;^U5c#]@2NK7J=M4JMX@J@=LAZ4MgG)
C6O3SdL0)54?a7[;c/0VUN,Ycb[BS[=MS>7YLZPL7M_L\;SS_?^X:6;,f4=ccBTe
MXa@I41<W5QLa#(8,AdIg&5:aZ_P3M(NQPeES^F-FX_9-gV\N70+@UKeFV->@@A9
6a?6eJ7Q#_P0ZR46eF<.LDN4F+Y\b(eHbRY/2-d1RTR.7]\aMX-Q4)Y/[2SIZg&-
d.56fD(,43T^Y>?SF]5B72O-@RTA2[;IPTVM<73JbUPUeNgB8\Q.)A9MY@6L\D+<
CY&g.E.L]7bB^Z9JBX5B9eM0OW<(A_<OTgA;V;F-M7M;Q\X].VE&R7,b]@K,D,OL
5fa0[J?/b-c-_T=:eI^D@e#G?g?cKTc]3CPDD?+K((fU1]9b=D^V8Z967A/M?aN0
;0]^g,N>6^K^]I4[S:GP7]U2ddgD/2d/)E_TN0JIA(1?/^(@5J(eR[aGM6+_52K&
-[7HOYK4L+.bcYYL@[J&6a[N_:@OCHaH,LaNcVD19G:517#6RA<+2CeFc0YR(+ZY
_MeFHO0Rd-\4Q>\?^[O_]b1=1c&@^ZM7BE6::Kg\UU3TO<()H/?7@HN.&,#?L0_d
&JFP^L7J07(&(0?(I,X]AFb4>GZ2S2V88?E+7JW01=L7\#6EeX\E)<R:I/COUWDK
KTDO.A(1Ob806Z#?egC9CLV#3#JL9?PT1LB@LXL(JA\(;-Jg9:.d4L;K]X,McC2g
.MO_,[E,:+3M[1.YK)S[DcSJE1c8+^NfW#=3S>VI.BRBN.PAYIVK<R7+#b8?3MeH
.KZ9V(SE?Q8Qb/c#e:#\Z-8LF.I_]GNUS^5:Y@(-AD8,U;<[2XV:H<Y;&Y7d\K6+
4]9K^a90]OTOeU]C0EbD6/1E5=W6>#/F.+8&;#Z2VKIR#gY6SGPX<_FNO9;a2<QW
-E^(0MZ-(X9O8SYI-b>ZQ^_]<3&?G0^HNLMB[R.S=Xf&VI=KV@KL3dYQ,O9(3^7E
W#?[O?;P+FC&IW,197\1a8eY@0GDN4JP:8-+X,,,X#3GcK3a3c3RQb1G7RH)3<d=
a9R[G=]SMC_8WME?7_DOZ/dIU1(]e06b::2?74,,J0ZCN0Y1V.>VJ[\:KHCJd-&V
T(/7fE5B9>YHLIWdOUDGS@_7VTG+TU-Wf2NS?fA_VOC7_B==_G5,GKP>=O4gB<I5
_6[VY4_#5C&#^64P[[:&BBc?9c/P-2#]).6BZQTeB9?dY7-9UXBDIW@^c)gW517.
P_U+.UK3J;_a2BBM4P^RG_f=)XI-cgK?8D?,VaP0EBY5AJ,,R@Z+M+LgdT0.?GAJ
),T4&1)_.3(HbI_EZL6-2-<P2/YT9UZW98cMKNEDZI5RJUR\e(_42=d-95EJJ0R>
+b5+[8SL)(9?4\,&&(4\G&T]=^fa6Y^(2E\3,](:&UJ7BD=Jc1CFW?b@]6-NQc8#
?;8\::?:VWGBf&S/(fNb_=QKQ[USPV?O)C+,[\S#@EZZF1L??gMefc>M2d;C-fZO
L8TH=G8W&F5VL-@5BXCBGdK>@5ZI<:=7)bI?:a\IB\<3ESYC9SAKT.e.SOXQeJ(Z
0HQV=5P:1aUHgZ1VEMaY2:#JAGV[0F.7;7_\ZN:QC6Ub86S2d/#PQ(;]Fg0?0MK&
DFZb4LcI\KOTT?[W=SJ#(E#UM\^c40A1#>79?<4;7b^ATX1@VXJ@37;&FR:2_2-:
M(_\ZceF(H#EY4f7:>3D;\2S[SP9GV\V[-[Ga/356HYdI)cUW_;?ARa0R&&O@]Za
bbU2W[K:#b@.7cZT2+dYP8TIfdIDU9/9+QPS=G3@:6ZgR[_Dff[2a&Ua7&XaLbeN
/+8^IS#;P_(debF:@TfE[<:MBU)Sd)UT]L:\N&cbdBEM<6_@SM(FYE3^AXX3Oa07
PLH?&8IB:@1XFHZ4#G98Re[[Y0ASZF92_GM)\1Xa\>4A+DR6BJUWNN75TYM](fV_
eT(d/5UPTLV56?dLH-eEWS>eD.K_]FX<c\I29/RD<-&3KLK#2+\1,K_YZ6K)33GN
=_(S8.W25YcdBGQT)L52ZU@0J@+><\g1&,3V@P8UF.ZCa1QgG-K[F_MM7&^JEQ2:
[DgHU3XL;DQdIF\dUA@9<0)X&KL3-eAFZX&e4-gfI7Z_#8THJVIBT.AUJF5X59PL
U-]9DA1AMd<U9VS_-BAPDfI^8fWMRV@M6S66AfJTT1;5LYTT0WeR;(@92\JW+BS,
C9HB7LWa:0JN-=TH5dX[VO7YY9?ba]#F)^7fb467\HD);c+WE]U?PPG=gN6/XG6I
Y]3\c@#Z2eZBCVZ&L(BT/9,AA)a@\S?EJ[JM=UN[BdHZ/C-caKXWF(A0[IV;W@O]
ff,?UX9@/H#U[,VUJPZ#FL]6ZN#T@8;2gL20DSZU8Q^_96@]\aCUf&e]d9N]RR<;
ASL\6[6+D2(ZXU;>C6)42\QZ\ZfWXXX&K4;&c7SXK:bI>U:&W?=.1H:G=):eFFQX
/7SHITUT1(BLU-T-84:K\K:;,[K=A@40KAIb<J8ACD</<a5MaT1JZEJ:X^a9^5FD
4@aTOMCVXV:\8/K-)#R9,0[NgWOVR]BJAN.3g:2Yf&+#eN\-7C#B?@U.JDcKGO4=
R^96E\KKVVI\g6J@U9/Db:B5Y6d(40X&e[)IeCWeST6AZ.<gDHM^(<XCFA,/L/_9
<&fR3e5>f.DMb[ZC?0B4P3@2Y<2b9U&&RJLV6#>>?4Y0<\50AFGT;&-B-IIIb6fS
Q&VN?O5AJB[;2FS\8_AM3,+D>CCO#;USbD\aS3VeK+_0D)JR7J=VU.eZ?N?TQ6?Y
F-1@4f^8IQ<?UeVYcfGYBd0WH<(Z:/[W0dI<G,#f\C^>Ra0:2@aXY7dOMM5:(4<_
He6+3N(VZ39@6?2)-],1(XGMd&ZJgD87E;64+F4V<-3KM:\QL^7F,bcA@0T7H=+1
gIf30+<N;4M+#CBg?eK7:D2MWLXX:=I/LM@X:U3-L6QQ->BGXHfCM(SYK><P^:@T
O3dfd7R.M5:]Qc6E@Y0b^5EQIgX&YKF:d\_6:W=AV32&)7>\???e+fU:2Q=6FX]K
E5]B>)BY,()05D50<\\3UV[?P_))K(:R0Ig56.&W/=N_M=J^fW+U/?Qf=Y+KWZHG
&KI>[->UaZ>A&a_??6N#Xe<2[XXbgaS;[=A>Q6J6.>TYY77g4+>[87;#fVS@cJPR
aL&.SEGWIPKZXg<a/GMa43X//Ua:J>65,/ZK-B^63QF^2\Bc22g74#FH;[8eL1c5
MIdW=)@)\eIAaP@c/?RQBe7ZAOIF7WWfJ_PJZ6OWf0?e&J/WX7,2A5#8_?HB0H97
[F=O2\1HY3//ZCC]+],DJ)#c2,D#\&]6XGKPX:GASPaS:D#J_f2FaE)[WN+,P=,.
X&b,b2+6fH6egF&6-+U;ddgO<cZV14D2K>69R]B7,0Yc.KaRdK=ESPWS1MQc-]8I
MNO&JZG9]S;e#T;]-?&B#UeE]_;JFC>>1;:L)EV5fa[G5&&3CX.:YcMBUC(X<Z?L
KK?cf88D)^BcNT)d_0)4C@\gb3YW/FZP@F0<SWBA,N)^ECcOeA:H?>-b=D7ZgA27
4#NCW7c.dUe0NTRO.\T7NAa-dK0\bBUJ^7+&Eg<=f]TXO+C/[J7ZZ:b5JWKJ,@78
57H,5\5:O/2K]U0:^B>4D#EY\bg\eH^)+@0]09D4S_;.0H4,H-Z\R1Gb8_L^2FXg
Z1+aKf-O58WGR<5e\PAZ13R8?^[g1[LD+7(F7?EAW0RGWE/O0O1>f(TX:(Ka.,8J
DO2Z>DZH:=<>X((W_FceS]gX3PM-FZWa=6)cHO96&]ec)>>FB[V4DY1U13HabB1V
M57ccJdO):&(HdMZX6\GC0Tf/8+<G1a-:Fc(T@D,V&WJcIXVCK8EW[[HSD?2:M/?
FXSW5_)FED?(W&FB.d=J1?Fc^W5bAgBZ._/QK&;1D08cfY5K/P/^SC\XL4R_@f+>
aBS=f5^++PNA@HVAK.<>RbC\^;TK9)CaL&D3]d&9/V4@YeMGQ528XcG#X0+A+-J?
U]d9OPZ]e8,X+P\ZaccO(W2K>5bWBePR5VHW=P@\UAGg\>IG;09S^=NI5I8JR3P5
AAQB5785S#ZGLQ[E)47Z/H644QLVW)A)?&.bF8G2]:b;M.U]Z@SP3Z-1AMNM<]8O
Q7.#+LG#_?dS,C.9XY1/d+_@:?E^.DS1Rg)d:S.4+d.<1\\M>:(B8X1C<4)#2A[K
_/O]K/T)T@LI,8(_+OC=S_QgBS^4C6/^OLK9D_6fY;044VH&6dT?EK].DLM#.B)f
R-P-=E@G&-DAT]T0^@9GEOM-0#>\,R,07g[@X-_IWH^BD[@8cg4CE..[GAB_^O8;
aON[(PC_bNd(;O)G0)aYEEa/e8O61WNPGH18?0dI2_FN(d??KLD-6Dc_+(F1W)DE
e9\13M7(g1a,[g+1]Uc#[SXE/FB+HgCDb2=W:F8_FaXO4KK7CJ1J=eTF.0OV5SWE
ac?bPPQX9_>B0gPJY>6U)a2+<+)[UPXBG6Zd?UG5Z0-1?]g\6(8.2755RO3SeVgO
#C1Z686Q#cZ3GPRM@X,2bA:P4/\Za\+1N91QC8cTO_@,cV=^J@6]+XR:e3gN(EZ(
BHY8:U?5ZE-=dL#WdBQ\;8]A8PN19+Tg^3.A;7YF]8+JH0&XSS47PR..C9d^8Z>C
?#>WC5B^\QK0fY,QH5B]<2\BUO29V6+VcAP38eC/BKZ_J;<K=\@-)P=IbIE4VAbQ
Fg0D+_1R)?a:L,K-?;Ca.e@PVEf=a/I5BIdPGQ/ag5R+P)A42@-AJQ17.6/-H=Wf
IF^)7d]JAWJF\Vf0a:RSW4ASJXfGFg6UEZ@C0XD?]f\J:)>-<(-W?Z9].eA-2O<8
#RF[J@&#QZ<B83Q9P5.bb911)6-X2&[I&A&[EYPdfRGaI/+M,,,,T?,X/4@[T[J_
>dOET?fgOa@M)_)U@U[HK5LF.)[>PXQb53I3K:S_K6L,]?YeXbgCLBBf[b5/5\6H
6DJ\\N;,2.U3-C]1#_>07Z?1P6-5Af@OG4U@@]K_\9X;JaVR]&[PUNLNZHd?5(>-
[E1<T1fL[&Wb68]LX)I7GRPbdIGX+FIEaQcf-0Q2/aNd[HT?XKf_3FEbN/>MSbR.
aL1WWDN8]0-&Ye#]IdNR][;]5bC^5d1QUB2N7,4Q4AIT51G]4XEOc<+Q]fbCXHcd
OMSa-T,B(L.g_DK7\d@/)?=H9G/U@?bf>>e?GS=\E;3e@.(562A?/HSM-#_<d29E
PSM^F;+.g#?_F0))gGE:OU_9eaZ4D]E8/;-_V_@XOOC]7V0U,4eFSe>?&(U_B<OK
Bb\c3S;0.1R:?4R0-C=XMP&_f_=2_13\8d_LaYN5H8(GR4=5:(a\-7]gXJX+7Q>X
aOLM&Oa<9BS)C8V#>SD&3/[aSCa#Q(V06-)30TKZ6[P[JAaV@-G/#Zb4CV&agZde
6e(CgC)gFQ32>\=Gab(B><_bcR@&CE]W>GM(aQ1V-W(SLOIDGAdYXSN6XIB,P0RA
Z&7]=5UOEQ5EgH)L,JFD;OKe#DVYc+U5L@\T&(OSC4(O=)fZbU/YU]O)a61E\189
X9LAK>4XT@FZeQeN,SS&L974aa(7\34HEYB;dM#da3)d;>6AHB@WEKZ;YO[b][5#
)C0-aWLf(C4ZHFZdAAV^EOZJ8YGbA.EXQOdFC2f?HQe<FLZ]AAE_bd_ZbA=[^_bQ
d7W7A,:E>_X;g1#+?#X=\+T3RKbO.4RAQK3=PW,Nd6&.X,V6.^-eg4FOVCL4HX5S
d9PQae_\f(2;7Z76\_=HPJ??9FUZ);I9TGTY81;g-M/NWXJc11.((IA@-U[GQ7eO
5V+=7ZDgYWGU5J=[Yf+BF=bA:KT;MFR-;QC&U2H=fS5T-aI::NRGM;PEZc5;VC.E
H,V.P](XG(>6S3?;SaF?bK6]]RS8010P8-NB2(D?;=__1+?\>\BUcENC&)g\M=ND
9_(bBU]DS1_bA56V\d:gZA\b:b+&:/]AKc+PGP5??G3QGe?39_9d>6cUSF58=#E0
9IQMIM_LGf6^c<>cL<\[RR;F;):X(HTM-41G4-2cS/+1/)]60MgXY>).E+T-5+0Y
Y>Z<0F7JdP\8RE6Z=MOR[)ACOW]A559P>O3BE7JN+RY,dHY^DIU5aJb5)^VHC^f<
1c..V)dKWUc_II>2bL]A)W+bV)E&4Md_HT/2#/1L6F(M]_7<U@2dY</J@W1)0K7M
OF_>C1Jg9U3-GT3O27/>?KZ)C;\:adCZC-<Yd-RW9>RRO.>MVD@dOU.+^_@F[OB1
W4)SY=Q;_V>f@HOUE[5<6[[]HK1f>NQK:T)5XX[W8167^GI8<W+,dX0cUZA((8d?
ZH)RZUL+.6<IHFNOYQg,4J+P:<OA-N86KW(_=U5@Gb0.L6JPZJdD##GUXa>_:7=D
IUL85-@3MG^W;]@<T;1#EH@[=M(-D=e<8MW.[QdB67DP^V.CC<YP]cgDg/#94NI[
#9__AR6d00OV[C4f:acCXY<;@bbOCDYf\f6dU#02-g@3\CRV(<;SJR2\UW62^5@;
3V<QFRIE4dcadETD(/Y1;01U=_b-Bc+2+/aLMRDOJ10RI<<13W(G@WX<GVNTN:(8
Yc8X@aRR=W,(I<ba(d5;/AZ/+];=;]_UX:gZZ/QOJfT9C+0[Q.@cO[=KgKXN8@dX
7CCMAVdTbJ1#?2)4?U/bgd8H)=6PGbNIW9:Mb6fgVOUeUK#YDX-+XfJ8[4?N:M:I
LN6/-A\LaGF\CX5e@L--/PdHW0[]@Xb,ZFRH1bc6;;@_F.0=0HcIAGbOe/2EVBMc
=fX4@19Y8U>T#UMd_M/)g=LLHCV7=@0DXab;aVKL5MIGN<AX_MEKEg21Z.&O7]2=
QWe.Z.fT<f89\DZeR#eVf>;43OG>)J.ML0R<e2^fC^1c?]_][.8AR1eQY(Bc1T<H
.M=]eMZ.:R8(KMHRMM,@^ETSEVI?e:RJT\HV\adfWe7<A6Q3-eKQeU8-\I.76V6N
5H&HTPd([bGKdRFWP+S(:W\>dfc&SYH?^6\VI+VG>^R<I>^UG:@>ET7fKdHS@eVJ
(f)PH4UQ.H)<,T[?\[.(O7YF&KQ_-d#GDbOeXY6@QXVGPHTbE,=N6W/0_MD^<9GR
B\()OC2E+E^@YV-OII3dc+&3\4G0V\d2Y.KO,Z5F._\]e6If.eW=.B4dd7;/>UCX
_2.)JZ;:XU1,G:,gX-3a3YCT?AKG.b_.^.FZGBS8eB])VQ@+6UETCd>gN22)H4:>
8aBLYVbG(\RIBf8\^Q>TWEd^]V1HQ4D@=&#,DHE/FX<gUD(8E:QQ<0NQ]#I)+<cV
K+)D\5(2VZ@9OC1ZZ).C7\cH>#^6B1J_-GS6+^0_+HDT/1]d04G@4#+2ZB18EKg(
KgeXJ.g.eXLG.8@8_^3&3HD4-[a=eVN;F-<HOeE:7R8@C@G>\N@VJ.6L?TN:,-X8
IU)S5;[<S^01^=Wg^M(b4B\V2(G>#=/(Z=N<_@)KfDCGO-)J^^-c.RYT<-S;L=MQ
@]Yg6WD4d1BA[Z3;^HEN[aP8SEFQ]JFRe[ZWSW_DA<+ZA]@F0-BbTQXf3?VC9a9&
g.@@_bW=X1a<aW_H^a,O1<Y-66VcE&XN=8X?K,\]J79NV<+#4Sb\Tfa292H47BKW
=>)^12IQ.;6#dAb?G>R)1.P<K,ILDL+NYVaN\Bd;T#P&QdI<C9HV]/??b4RUN\0(
[XY(&2Q];]^VR2g9+61=9MB>+K0,W24A=HFb>L:.PD=-8SGF]0/G:9:^(DCR91W7
(P_?A#+\5I,4:\P&JHZd.F#eUg9f;@P).&@2IS6^I6577aMOS6e,^::_>^8<I(-D
I)3P\OfMQ6.K46]U<;Tc5K8d+#/d30Ic5Pe/\>XPA-YL=JI>W:/d6Ib5gL6Y<W[@
9?<3:eBY/f\R#&;LHQ6-Z^_.+#5HA_Q<U15_3LSQ:(1W9,@H+#da=R[]PC6=FZAU
2P>=:eAdIcc3AE8c@+M8A[=25?,JV)&<MY#/QdDgT/XA9O#d^G^33W3;2B^WT-O>
=d;C_2KG:L3OR+0X-#33F0=VeO,M>FWX[DLXc@=EWJA(L5?B^b<Z<MR+YSLXN\Q+
S,Je-:cLIF#SL-B1;BZS]5acKeMQ]V?bBgHf#>c76;(aXTFQeG\gQ7LZWI.PUZ<f
6P(]#NTDPZ4_M8)<9=V01IX;N\:@;;8C1E5;(V;5E,4\Q&FY[-7GUSe02GZY4GXM
gZ=\@N5&K@3;;EbOJb6=&=f2TYfVZWHadFA-QCYcb8g-POSa-H&^1PKK^^1ZK@dW
>_K#^Ce=)]1R#T[2GYCNEYG1>1U>XU=.9)(-6[Y8^:g;J.D(g^T:9JVUV>C2RNF#
AE>g-D6:<LV;3A;V>4B@4WgS:.RHU=G6)^>Og7:B+3/=VSX&Q+61P4H60^5fI1Ff
f23&_16^/HL9.Wag/MI3\X44[U+WA0WJddG@JcES8:GI-M<cAZ<Id@2K9[>c9^1_
9&V;0KSV,S-R\g;8&U-K<c-A?R,bDR>0/HYV)B<X62g.W#Z0C1@^M9&Kcd0B(.6M
3ZU.L\PCB8LAJ[2?<2/c\C>eL<=P->(4^4([@_E#=D)MC7J:4Ha\)@Y#Dee27c.4
7QUQ]fCaK0/.fE=QAeOG15^?\fDTDDeW7:[4dB:YNAYI3/;ee]^:4K:+d3.(D;(M
(?/]>2/WaD8T?/C<+\026C\d@AL-^Ce6#c;G7U;OM-P@+FI<a0H<>ca(c7(B1=N.
&S?>9KWTDTK:R=N27/O:L/#b().]a2APKW356-5Y5dTd8:AM3e_6/bbK(F_/3dGG
<,e\d<^[71]=fS2fY),Q7,5e7>#/3_PU59^d=-7dR<29\P3FE0Id?&3g9/5AZFbM
g4a4@#5#d<;GC.:b2?3+6@eE(@1=b.63X[1_Q?c75MTC,1b/(N^2/+(,_/UNN6aV
13+F0:R6N1-7,2L;KDL&@6L?BFJE=&3@)2aeLVa)X/bSH[(JZM<RO9W/Q,U:R][5
/-=3O/UBF53-cE>-G:__#U.cW@-6+9FSHPV5E?U0.)T6@_/W7?9+X<4?(PK1gO>K
aM4O:[J^=?:W_RMYcQ-Q1,(ZL:fCD2>ZQ+=eXT;g2\F;8O&b)0XQE;T<PE6]TQ,<
5]e1EF0PVJb-S?fA.=f=GT][eL/Y7/,+9[QLB6NGMWU/#:Ob-[OML+HNQC2;X8d#
<YeU.^B4TEdc9@;91;9N=Jc2<PLZ<MgW@g5b<4g8#\564.=\J0\U3?g;?DA=UDQX
C9E3.NDcQ8FJ,Y?d(_AKLdYTa)7#(V<.W@fW,\-C=DPb_P7a/;1LKcN>P=\(8#I,
#<Z/P]X^P<7M0T=IZaFCM4?P:d8>22be5PU.Pdbe=3JXGRfaZ,&/+P98YBT/fHSU
636ODQ_5-VLWI1cUD\TYSge4BBV(J/:#-fD_A^US:2S0Ze&Z[B+N-.+&K-:SZU(\
6\96&N>;TF]68JD3C]QF5GBA.4<7B,BX#(M&+>:ZL/b@HC5@a.J>F^Rf\K>9#&V+
91@8bdW+(;F/)AC>EB1T33ZQ?0#UAO]Q8/ZYfKST9J22JCg?bCF0S+J4_]2#=IgQ
a)BJO.c(:WAS59=JS(LR7UfOc<=O[^=P[[)TVZR#_(2a3C8#Ma(I.P(^>Lf&PMRf
ENU#11Y[\FMO=MD>^SYY^-[@d::7Jagb&aMNNd4,_(P^3QLUT3b7LBK\10]Fdd-N
\U@@[[(RY.>(<M<g,CQPSU9J:28[L]/QPUMFef5L5?Yf_FCU(P#0)BJ9K7:@,SR/
2=AJ.Ud-bUD>:>4G]+O+X-HV&@@SC9Gg\(AQU.EdK9)aYY9bdO-:XC?COAA7AG]#
aQ1VQATJ9Id37S]R30E^/Ie/6Q,#5J7&.O^H];Ve9V[W7]F18K<ZUf,XSEG&<@g;
Kd8D,Lc+1+._a4?GG?O=Og@OaZ;S8,&T,#9d:0O&g&J^,MP=ATZ-TAT4_c8F\[TK
RW5&61OSRNeS0D3:2(O?FK5e<_J;g9S[fe1H6=A-VPV_aUSH>O7_3_,NM5=RU78B
=O2C\F]SA]5f@T>H/IJCW,,J]DK8OAM4@__=,8X&B7#a/6)4BE@-d:..OBN9IY=G
gPS,?M)gc3#-U#b1eV]3N71>Xg((20<>ZA6JNdBXUPQC2R98<_<87#].a/+Bg&gQ
MHGWM/4JF=CVMO0FP\SO(&^bbS_5@dSb74U-,AOKQ)^Tg\(P^(-I]>+TO&B#Xd?M
ZS1bT4Wf<-6>K&+OY?HE(+DWWH@,@Y=VK5X-[-)D0ZNL8a/(eSR=R/94Z17G(b#E
R,B^aAK:T<9?Q)&BO^#aZ.Y4HUR-S>9MA&IJ+OB7eF;[Cb#<3R2C@^_[.GRA8aZ)
Q/gSBN9<^3J&feKL@d3EQM9RDO6J[;TF10LRccCU/CG+V0Gf6D_?K71c4B=1VP;[
]VT],4:2XD_R/8-AUG;)E;W=4OgFTUa8/(6>4Af5dP)KIZS7GZS9YdbL<&SI/SeW
U_ZCR+J14H:UeD-J=IC?AN=5M&=;)C^LJKK)a+=NH.bYF@P;]FPVRJ/SBR/:#.B+
\ZcENO(gLLgURJZ2\-e0BOVT-=6A@LC7-]F)1/L_;-,>18B9:f=78)476\U7TOe1
FK[bE+Xg,::G#dW]0_E6QGEUAJFJX4dY=2S-=c&28:c[:U6(4>BO>8@WMIT:Td/2
-XJ)bRRIYVd5LR]ZPPdB:[J>D]P?#gX@S=BG)X84e^@/eGT10#I<\)O?=^22=63?
9/1F<^7K<KVNNF.-[E=Qf&)]_1DFdHR5#.ZZ#P4f.8g[N&C7C>d:3@N?<?GZeYIQ
dQI;J<b/H,T1G<<W/C3EC<FV(?ST)W?gSF:^-DAH6FfCHBb6&2B_QEQF8[PV2BCg
D@N?/(dS\5Y.H^_f]+d>;KEG40Y6Va9e@/N,4Z]P:9.8,:[\Y@3KN<N.eKR0/P_-
Jg=_dVD<Z(8c\H0LZd:22,dS);WU-:YB\[(X6Y_G3[H)G])+H?2OHNFd,Q\cG114
a_^df<HBVB3c-$
`endprotected


`protected
Yg?M>+7]LX\Hg6T+]]T=T<e=fb7/PCN#ZXF5S?e7B4-]4,eYWAI#7)Ba/D8MEXKK
65(c\Ue3BM2N>738+UK66<J<81C=3=143cY8R00[,ICKLW>CS3aY)M1Sc^FI)\W#
I5,-N9eZ<E-0GJD9\Q)^0Y?J7Q[)/19,+SNgDXSddI869-e5\A.g.NYD;F,=H?]c
WYV,)46<4Y1W/&\Y@#R-0I0NL@X7;6:0::7V]2Sf&7W#ZN4_@MbGUdSTX9SafZD3
WNS#6HgUEOEG,+XXS-LeD]=<^G/)I3H1R(5YHb(&bd&-0JL;A+3Y\)4XVgSeGGU6
efK(_)U5OEbBY5cFcJ=FIAL@1#&fY;T;4D6>da?EO#;V/T)Y,\<B.9SZDa-:ELS/
FA]EPK7J.#I2=\Yb5A?:W.CZKD-_>bN3OXXQ=AY>5@/G0/A3LV5QZMOMPH.OK_A@
^&T5Y.]VGL;7G9+S4P0@BbE:V-R^T02G[K.#2-9W_b:JX3@W;/7))O:HMcRJ#,gf
(P1fPVTdTc,&C>R1+[&#C<K.NbQ2cUR6bOOD+UB3fLdZMNHEH([R(N;La-:RfFE7
_MLV_Ec;NO>T?d>40AB#J9Z:-IY5fBS[=e00K9^6HS:XDS7<7SGI_2-:bAIcP&,L
CXBDb+Ve2/^8_ggJ>DMe&XR2F1gNbR^e-BS)5I4Q#PQV^96EI118gKbcDNb[RGMY
1^X+(CR6EW_SESJg9V3[W6SCWf0-Y<TTf9_3WNF8eS&ZdbW;DNS?Jb\0.6FHQE9e
6_A,&/;FXbH?Y5#YU8F6c#;09BQ3(^?fcGfa^c:&4QeY0.gXIRL[dW47VSFWULS/
/AdSWb?f(+.A)F3XfVeMY:HP5cdd/)^]P]X)6?-Hc-VDRN:53X6ZL<_4(AZFM5de
]J27)B(UF.2B(RE(WfXCB.=FN6a]Kc.RcTO4:IO]7G[DC$
`endprotected


//svt_vcs_lic_vip_protect
`protected
02<UR@^>9fV\f7gYTG37Z4:\M22(P@IC19dRC^T5b@7)X@=A=-HL4(44-,S>);#P
VYZ+;\beA;X)UX;LcfPZd>R+&6C#VD^bXFg,AD3:Y@:OW\.K,-aga))JR5\K(8=O
_gZFKf&?,B;,/HNRPY1Id@:g4?1)17a:-Ke[V.b,W1b\XHZ0UH[VG4J?QVR)f(?F
(@4J9gF:;f+C24Gb\QRIgGfcJ3\7>,Ze:Kg>dXGI6\MP?^JO/RCg8#@b>,^<?(bT
KKXQ@5M;XE()O745:J:MIL[(A?(bd7FS=.3XM4:93[4ZT=Se1M#<VF@KOVgc[A<K
#g>_SQ7T3YGWBgUVQ3HSf6F/I9.]eSYSW?-WO>aPZWGb[Ge#ON-SP?E0U(5g2G^T
Y98Id;JI./Tg\]D=TI4:/NENHR/&dOSJ2NZP5OMaU.;d-cdeJ[4)OI?CG[O^L3CO
e>3]K#_V=)]1I3HE:C3XRf[Y@I+9@X>?[OCJ/>g)RUbZAAM_c]+1?.O.-R9>[C>A
)_194_2L#=?NVC=461d(9-H,H.W,CUeOWbTXP/)KU4ZQe^d<@e4BUT;#A]F5=WD3
C:1N(P1Q362b[b]U,@;N0+>^[TW?5VOeHTHGTZHZ1]G1Q\KMC)[@P9V\_^dLY#\)
b5]Y(>6EVZd]IHOf]HL=FO=WO&JRQ4PSgdYLY4W]1P@c(EWPcJa+,@X[O;]./<#H
Q9R-WXJS38XE8SHO3Cg.Nf#U\J]fL.:OAD]9cIDB1NR[[RdXUgW<FS9\bb[g:.AV
95F/Fg&#S_OO::&c1>O+c670C@+U-P;CT(64)&G,18Q=GB9_312-[4e_P5ag4SLW
7_7\+;b(CD>bQcg&0\#0W18J14eT7_a&SX+(&J<ZD7A&=SAW&bDN;XAF+K4FIg-S
T<+3V]b&7LJQ7Ug4DR0AR>\g[6QAEL/TF/K50&ZGbAV6IAf5/N8-KO))MV9dW-DA
YQ&[N,WY=T];Z9J2eUE7I9S28:a-&<UaN>,9YZOLc;cVcGL6GNcCcYE7VB8KDY>G
+>IFHNKWWOb\H=IOM/ZL<gV&N[MbTP[g]IW7<2Y6=4:N+^(4>).6(XVPA<X/#AWI
7:?<V^(Kf,EUb_Q>gJ=4cc]N2?)/eOW\:D;IF#/a4PC0Tf<^N)=)[769JNe\-TC4
Ib8\JT;=Ge:>:B73^SeSL=T>gTN(XTQCZR26>[W8X?U-01S#5U]P\>E,=?fRcMfQ
4D8H_^J.#ZH,e-X:aA)6OL9H\1b@^g[>+F&MKa^EJ:d81=2/RX:&.a1)65a96&TB
W]O9,CN(13@U\QRGg.8)3R[cML4]-2WX#M4+)DOLKY#DK@L_ILcP3OJR&>.0U84>
;3^4Q38J>6;#,:@.-P4W?dg;U@gJabE0BI#0\XY@-,@ZILY/^[NeB#_6N+cFL]=.
c.e)aJP<@9DY75aBdPg@550:LP+2a6;?2-#0_UKHf42ZVfaWOM,Z,<A[2BFId(:b
ZM3V9+>U3F76BZ[420B^?NU<2Gf1#>/\UIX0g4\^QMLPS)R)7-V8UPCFUHIE869Z
&2012IH&^UX1\-4F=DCT\\5CFXFKQ_(8a)(F,\[SScJ@),dOafS=YN\<JRUR08?d
b?#+@Q:=/J]@5T)ZBU)?Q74MLYD33L:LP+A?)FP>+?,5eVLZ1+[KQ20VR#4SWE>W
ZBR(fUdC4S:<\-@4f^D<Ng\/A-;RfSF_LXT#^F>LT7S505+QV)9JO>8-S4geL0T(
NUDK77a__(G,R,=7Mf8\KH>0^09Hf]9-<Q9=c]C1>1;K<3LXM>gSZ)\09J6V?F(M
BAGX5ef-#.LVOG[,]ZGJe^-D-]-.J5aaT5eb0]FFT/(,bRU1.@9:<4(FdIDPZION
.4J0,9Me=5\8_aa,R@Ye.59HSE5VPJ]eAYAMM6c>T.;,B$
`endprotected


`protected
Dad[LQ^=4HJ6T2Fa;@^QR&gLRMEHMYYUUd\@(:/7X#e-6W\5eB/T7)fVd&=M-S@K
S/77a2C?d;+;:Yf9IWZaeVCbDT?>aGZ(S9HVX9+HE9efHZU>EffbO/R.f6U@))HK
EZ1KTP5SOeE2/;PQ^:_7L4C#K4AVeeOJJLHLX_,.Sa5LU+2]>#+KQ;bJ+>FIIT#\
F-WbUI+aQR0H>T.?_QYcCfO4_4+;&P+7g.H90)3XI_\.FD95:FW,;6_((dV8dMK#
LU[Q<6W>F4OV):Z7JC,W0<3R+>:4_]>K3.P83F#;AJXU/Z>B2_&730PY0<J,D32Z
<8cU=&D,g^/;WTUDfAcd#&;J\ONa<GcP41dK9M\<2If/gQd[XdF4YOI?/)OT\K)S
Ag;0S+X)PZ-a8_ED>\N[WW2WbXFEN_;<FA^fE/IbEd0e.:2L]2KC1A_AQ+Q7/6IS
0S^)>TI3G;FP,cY;1HO[<<&W<J+1RN2ZNY6_?[:H]P/T?9AU+SLPL\QBe^4bIU\>
XZ&eREYF:0.&XZ)8HBfM)/;^_J3F?28N^/3K[ROfYLfG,A[PefUFW2X+NGC-W+e/
E_)->:Ba@L4:IU.<:)gT#-L[Ke?-KS_5PL,VFd?GITP+GU>_UfG8H^fRWGcOB\#1
M)<aZ35ANd>e@^+/-IE3JW>^Q<:Y,T[Q]e4YDA-DYMbVK8Ga[D:+3#W>H+4ZG+cC
_g[/Y,9I^0.X2FD:eL/NYe,6b@V3D<Q\\Kd^5bIKC)(P/=^EVC/,Jg/?cBfO><e)
BcGHQ-_-<f,c_XHGQaVZXXf&GX+,;:10bPNGS==0ccg_;7>W+H+EcF1QPdGF)]B.
/@c:,O:/(FBH&5&S7_/^Nc@WMee[ZYGPPZ<7TdW<9\3ZPL:,E)Q1=&>\)#4AUQJ^
cNPZd^/XaE\9WOe&+F#gcaA4<_efDEW+^(G9YR+O66:T,4Ib@g_1DCIJd1bL)cH0
e0?5B,2FG_dge\^>6FaaP.fGa@VLR[:Y4.R,PFbXKb8+fW4a=;/NCd-5<bMA(,R8
D0XO9:2./Mdfc=-S#]:fGSKHGEZ&@@V>#A1W78.APc2LWVB8/<?1]C@LG3V@Nf=K
@?K,9\AT;=XSL6=0=6B:BbdLNHf&QA5#eN>g9Y-U7VdF)XB@&c[f)d0)6LFe2O(U
O;;3+QXSKL9LN7(UD8^g<TL:LG=V[-I><cSEBBZF:,f>::-:P=Aa#67aK9=?EE<)S$
`endprotected


//svt_vcs_lic_vip_protect
`protected
bQ]TKD@:;D>MUYbTd([aP7D5J_?)Y/HgO]I<8B3T7eAP^cT[bSSV6(9^Zd:Q3^H-
c;fOS:YO86A6Y77;M;eEX[b4;:1421PUGa,LSZ95)A6?f1Ng@S<ODZ&VF2R:\a;N
36<J[D+)4;^.Q8:[LaRDK=?;88]NaZL<FFYD=Eb2Oag&L@eBM#FS[B^5XQ[J6[8T
e/:H@2gQ_4D,7[.G7XY+ODYIe++HY8^V@O&O</ZPb+7VH=U1U24(4:_^0-4K/><V
V]6CLA;1S^HSH9)bVL\O5DBdb/XDRD@f+55Me&/HaVF?@@#20,VGRSE];=0->NGG
>Y=;3#<#4gF.=]F0)R,b9LG32/X+#]DH0Ta0DM2NK/N]gb_ZL;aYbNGLRXd5UCVY
_PQc>L(O13<B>1O;@>bX[d^T9Q72@QX[7fMQW_g:@\fM5+[7DR#<9Z#I&HcddDRU
XZ-cgE#RP/eE>YGV2@dd;8^>U^,c1GA]9IC]#F1C&-3I]M.8cG)L/GRf]J_HU;=U
859CabM7GAYI)ZEDDQ5=GSb_cN\E1^@cU>+>6WS)Vd&QYCKgV,3E=NGQF^^(dX;0
2^Aa<\<).I+UUbY^RF_LeT_GQZb2/6_3ca9R5.5eW]BCI;=gXQL89&?E#_.G9g:8
]<8,Q+N@W4d&V89#(70Z_eH6KS.>bJH,_\cVB/,B(27IZEf_,\N_E3<]8eG;@bW;
)7E-34E3.?LK=66eMI)U(_59O1:@<F.))gZ8e.27+\B@Sc6ESDe_AQ3HID1:U]\b
0GORJBVMK(\)CU..E>MH&O#5ICXP=D6+f6D),DM]0]I591AS^;:F>G6.F<Q84gJC
]5;#WfA64IEO+#e6_c9S.^Y@U)>T^)dNbg_(5e?NO[@6^^.dF(?[D4>Y^PX:>?a&
(\4<KPX=&RKUNe&a\QJeNIW(S8;7A#M=._L,3<F<5DQ7TM^=.EL)72&<YJ)PP7E0
(MVTPYfM\[,;g;cX_CA]-,S[=W)/#>g0T5b[=D.g5,+(]3a2M)dGB(1Y)]MD@I\P
6^Z@7I8@Hf.41TR2A,0:_W<F,.)P&#R4A-bLIO42:Q+e;C8>LW9@aCU/R<IP;C?(
Fc?9YP=N06(IM8U54Y>_UYJ+2gR^1:9TXbGULG5Sd,C1J&D#^OXM9?d,)F7Oc>^N
LeCT)Lb93.A0]/2H@U(#Ea:DZ+c..e:ga3TSB\4VRa;V@Xe.A.dcH[e0Q0,YE@0<
V6G62e1^aUYNe7D3?JcS48AL@a0VPN^;5P\:<\d]LFaG[bIPNK_<-M)]=+LQa-KV
&1?G=(VK(YML?Z:,\TU<6[(.89/C+??P&/&\,W]@RH1-B2X_.6]XG2B^;]M8EAON
P:<3&EfIgH<Kcf9KTMbTZ2_-LcX6YbP)cg,0?XJdSEd>/JW/?\=)+R]AP+0WH+ea
YR^<Q/0d9@P6Z&/,/S]S:HUf+^6=KDZML:Y,@>V^-Ge]6UUXJT(>,/3L1Df71X47
SdBg2\dG=T(X)Pgf4:ZR;&(eZH@]C?QLRA.&.76&Kbac\@0ABI]5<@F<[8FBG/X=
UGEg91H/UDFT#HI)-H5W=]/,OUf>HSHNZ#TS]^457Xb\f7=)?&F.0Gg3)R)X_YfU
a4CGXTaZD\0+2+T,IVKNN<A-cAE0E@2JMRb)0bMc[AcXNHLJg/6DNHN;9]2WBL0O
VAJ-fC5:,EgPI0>7D?KebLT-QU0XDP[>>_BP+X\CO?c.:L[:>+#TP<EV:3JG774Q
)-,9F3T=I29fNT5<JRagU0&a-7DX4]?TG]&1_M7>B7Jc8.LO\-4e<V-\JS;C<F;?
Ta#([)XC07Y5)HcaOI[T/X8c?E?F32PCD)6fE:CAcMLFFC(MD[H&HI?B\,V.NYXA
YXCL\>[#]1HABe<+W7&;SA<+PgcJJZ;9NbYFL8D+IIacfGXPJZdfE.YU\<(_K0JI
4A.3e[e@9+C@FN/XQ>GC@/cAYQZ_7XB>ba_EbMF;gWHf@)EU&V_H21N<3,UH3USS
Zc[f.+/R]>c,aFfT6RFV8cfNa81.PL=[aIdJ#E47gY5D?=@.#+]^\I>?4T6G[;9U
GP&)FZ?:.L?Z@0I/3_HWE2Ea?EadcX>U7JI:J5I=W^IS:GQ)ZbOQ,&E7_@-RN@PS
)VPaLT]:>dQ;24T5e.d#ga0?fO)c)V&Qgd0@E_Sd.(J5\C>Z=f=bZP03O7FMM4gA
D.;5-U+HNY50HW+:XRc1[2.J-3#XRAV)UMbT?BK&C-Se16)a+X]-T,/OEC^9[URW
U@1AC-:,Q2FB\7]:#?&G);C1gMb6Wf(Q;P82KEL[2:2>TZdIU#<^E8dV<M+Ua5F,
,M0BZ\,NIXH/+<9\+79KXDAV4>XBC2(1R05,O(>g-Q#:cI-BZ^IR1G&9/6MDG]79
]D[:KJUZ63BLU:A?HdI6agM@H#X]N?(Zg:W/>F,W0-T,g((\SEUaUbS0(47M#0UR
W80]gD)(<]MG<8U(FJTO_=BPA@W=df6RTa^(YG-_4S:-A5FSKRDBT&c1GM0AJd]E
YVC&C=&Y3WWdMfH<@)PCR4#UEZbDg4:0[,/N-N(2Ua2Q)[C4K,\)5F+/J5QWg=O4
9c4-e9f>fPWTUI^b9Of/IZ\)(c:(;<NAY1cI2B(gO.ZeP-=V26NEJ\\<XZ=HSEEc
c@U:D-_XOU^].F7a.N_&13T9\.7+WMdf]e:&TO6IXEc3.dVN#\bC]OOY-&bUS06f
4QJdY1>#:=,GB9K8BCHFZ9GaI\ZW\03@MTFPMAea(WXQ;CgKf6LgSFQNU@@]cgI/
)VA4a#-RM9Y(UR&Of&/3MB?JKQ6NWbK?1&P5)d_C@]Tc\93S[8R9.Fb>_Q(#7.UC
2R\K51B7[VWZ:Ra\TX=_UgB#K.USfTRI_G&H13O,8W,b5/7@^5#?)(;)^TaW0dPL
V#NKZ5ef?A1MQE>O:&G\BP6F//SPO3N<D_\:ag6I#?82#78d_<9Ya8MVRAgG7L[R
3O/YJY=-B.QQ^.7IYJ7@_.R>^E.PdN?cCR[/[(,M?;O65-;&NU06]_2?@-=eN]4J
+QPGY&^LGOUfA,a<741a3IMZE(-W@3=ed2)\W2;D\>afTfN,]If&Pa83,9ZN8#]B
ALNZ&#daa3SI/8G<3@E#JW-f2@Q,c_()@7dcec5O)<2ES8SR<DC4AN4/,GF-Y8S)
(+&R>g#I3+/<+D&+0f9B>?Q2Bc7A-,]e,H8)/-YgM^<ED$
`endprotected


`endif // SVT_PRE_VMM_12

`endif // GUARD_SVT_GROUP_SV
