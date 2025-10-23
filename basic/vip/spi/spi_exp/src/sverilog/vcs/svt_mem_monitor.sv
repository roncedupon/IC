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

`ifndef GUARD_SVT_MEM_MONITOR_SV
`define GUARD_SVT_MEM_MONITOR_SV

//typedef class svt_mem_monitor_callback;

// =============================================================================
/**
 * Class that provides the basic infrastructure common to all SVT MEM UVM/OVM monitors.
 */
virtual class svt_mem_monitor#(type REQ=svt_mem_transaction) extends svt_monitor#(REQ);

  //`svt_xvm_register_cb(svt_mem_monitor#(REQ), svt_mem_monitor_callback)

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
/** @cond PRIVATE */
  /** Monitor Configuration */
  local svt_mem_configuration cfg = null;

 /** Monitor Configuration snapshot */
  protected svt_mem_configuration cfg_snapshot = null;

/** @endcond */

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new monitor instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name
   * 
   * @param parent Handle to the hierarchical parent
   * 
   * @param suite_name Identifies the product suite to which the monitor object belongs.
   */
  extern function new(string name, `SVT_XVM(component) parent, string suite_name="svt_mem_monitor");

  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY
  /** UVM build phase */
  extern virtual function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

`ifdef SVT_UVM_TECHNOLOGY
  /** UVM run phase */
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  /** OVM run phase */
  extern virtual task run();
`endif

  //----------------------------------------------------------------------------
  /**
   * Updates the monitor's configuration with data from the supplied object.
   * This method always results in a call to change_dynamic_cfg(). If the monitor
   * has not been started calling this method also results in a call to
   * change_static_cfg().
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a copy of the monitor's configuration object, including the
   * current configuration settings. If cfg is null, creates configuration object
   * of appropriate type.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the argument
   * into the configuration object stored in the monitor. Used internally
   * by reconfigure; not to be called directly.
   */
  extern virtual protected function void change_static_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the argument
   * into the configuration object stored in the monitor. Used internally
   * by reconfigure; not to be called directly.
   */
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the configuration
   * object stored in the monitor into the argument. If cfg is null,
   * creates config object of appropriate type. Used internally by get_cfg;
   * not to be called directly.
   */
  virtual protected function void get_static_cfg(ref svt_configuration cfg);
`ifdef SVT_MULTI_SIM_EMPTY_METHOD_FLAGGED_AS_UNIMP
    int dummy = 0;
`endif
  endfunction : get_static_cfg

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the configuration
   * object stored in the monitor into the argument. If cfg is null,
   * creates configuration object of appropriate type. Used internally by get_cfg;
   * not to be called directly.
   */
  virtual protected function void get_dynamic_cfg(ref svt_configuration cfg);
`ifdef SVT_MULTI_SIM_EMPTY_METHOD_FLAGGED_AS_UNIMP
    int dummy = 0;
`endif
  endfunction : get_dynamic_cfg

`protected
N34R?78IBK1CegeK_)15@Q2?]:UFAd8O?Z8BK;<694Y:#[0FD#]U4)8FI;:O]GbX
f1?T7PMO>,(C0$
`endprotected


  // ---------------------------------------------------------------------------
endclass


// =============================================================================

`protected
CfN/NTfFN.4cW<36[I@L#7T>Ua(N\AX^[^+.=EJ)\5Z7gd\8UG4E-)a>7GBTR+Q@
4B-HKE1dD9#<=FX(TNY58]EIKbC(:#O<K?FdX7D,B>C?1Lba7JW>J4,I+[Ca^\3f
R<cH4d]BGQX,<:]))E[:+=H+DCX/_WeXH])VQ[dY8:\]^;[XF(EBXHUf#AYaTLd9
D;#?3;:(^H^@[,0--1d8O6;^>>G=H)O.Z[\FLP2)?f0FIJ,LQaVC-QN.Q/9b[M<@
bNF^J]SDJK.@/$
`endprotected

// -----------------------------------------------------------------------------

//svt_vcs_lic_vip_protect
`protected
f/B)ba@3KSB2#b7T6cC+#.-W&@B:,KR4a_0MXL47=e_3\5cUNJce5(8V1:32O<:6
LT7J<LFYDL7/CDJQJ4L#D6]^PBEE/9g]^fMg1>FMRcSJf<Be37QRZS.[6=)U<Md1
BGJ6(9<].OeUYL]O@H1AACfK6cH^dDAGFL8]U6JbT0[@TRWNC=gZ]_00_N-8@f]0
Y?cIP\:Y]D2P?=4WXUXd2=7IRX\<P330@\-JB,GAQ6>3S:)WOX7Z2JC]/,,EBJ?7
N>+?a_e.E-C)BH&Zb^c:0@beUY4,9W/4>^]./3]25b+EJ5>fDV12=XMS+VdBS[cO
aJ^B:gg_4Z4Ma7BUON[4fM+JAE>&Y[K9gXA2#CZL\BD4[Cb=YQHVLD^e?KLD1gS;
<G_C()g;L9&&=<T9X:=c.-0H9LR-?3&LSD?f+0g3b+>?VEd#YGZ#U.QbW<)B>-.H
JGc/TM0GObEF0d&b+K=23EQN?0E6@LI4I=cS?Qe,OJ^T>a\_7K^N@]fW/N9/;?,b
.8\&&gM\f_3CQEPHMcA)AK0,;2J)^RDC_Z<(_H3d8?F@5_/ATW\S8P[+\1M^c[L]
KF1_cUd#Q_)^FJ;4SQGGIaS6RCS[c,]ed6T[6G6TQ(WObT8;;TAW:B?AY?e1UVcE
_HG&__,U#FCQB#5+J.096HaGIDVZ@=(YA6BMC<:T>:B,:TXN+PFOH6)V][&FUJ12
);OO&g(^]3#C4_5MeeL5QTQ9ZNV__4OOX074aV1IfW2T3.ZC<EOZ5&a:D/;SfXd4
3P/NMUf>LY]9^dK6eR;VE:2A;>82:L5E^MT&N-E>SW&CGJ3L1Yf90,;BKc,K.4/c
WH-C8Sg4N@Oa14@W]^F<Z2[U)F3PYV^):.eC:)][DeZD/PE>.>1aOC-9G97P7fAR
Zg=]e@(20g3<dQP>e5CL#7=#NR:)S:f^AMH9aT)WSS(^^VXI-geQ^WD@?GQ#?S1^
1d]GVXVLd_X19MbZVV:C^<;a4S[L70=S;9PcgHP^e1H0TdYX\4ID0G[2?A8PX)8a
XS(]]ZOEX+QXSK.^UbWcB]2bWOF]8Z;,_M),/@OLXSN)^e7@gVcPU:9YHTEEK8aZ
H?;4>7BZ?fD4(&1fd,Q>Ed.D\<IJ?@OOC;O3CP4XO8=9#N<-a\gN^P5^58M5Y>b&
YBe@T+FR718e:EXMge&Q&a+^MOLd^;f<UP)b,/7CS331aD1KDLP;CaH>E.EK10V9
:Z^RVTZT&^&HSS^?8JMSA1/6198R;-68^H=X-9^(++5:^L7=Y+,.+Z>U;49-UJc?
ZEI^-:59dUY1DZB2/#I[cL]@@X?;0IY\U3>FF]U=_-]<4E/KNAO,)Q=AU.Y+I.FB
9DUb<<)D19(P@)7g>NP0a(.WOb=1Z[JX>&Qc,YOD03B>:,P<1>HD:]/C\?Q2\aP4
R&_K@QLUN.(YO_@Va6>/Z;FV,gLa&[cBgCWaD3#SW^(Nb=Xa/\cUH/;9>cF[]@fT
R5#+\@\7f2]C>=13\8T-3]-=S\;7cW8:57K6N8)[^EG6LLSU=E=B?&4)7abK7:0[
JT(a=T;<0(6g]:?#UTU3(FXI:HQ,G=T47d@c-e2_@V#,C(;#:@\4=1D+.W/Z)?Y_
GGE&,@<f0N:gPe^Ke8]e[\;Y]:afC&FHI+C2XB:#4T:&P2GT7D;M8+>YVg@^eXg\
F5Ocac+S8ZYR]?6Ec=/1D\ELAJPda\_a)>85>K&g;R@5G5YZC6?&I4IN]8G63a.P
E-JQC<8FW78,@OSCKA-bab_XEZ_@,J]XP5YAc_A3>JB#.JR.T#:b&],(&(ZYTYSK
Hde_@E\IDO4P;TQ=TTF>?VAHX)-QX\7K9(+_GL7&@Hc9YTC_e5gV:&>fd)SX<TbU
0?5YV4[>[9RPHEK[7O&]5C.7E/a)8^->B,\3IH<-BS5I3b=2BcCW>UE;S(,B=Md2
:KRJVCE8K]<)_WPT9<(IT^_X(PaAHO#.R:]K=Wg;FJEO3a/,2@7R7S3&9QGI-^]T
@D2RAX)4B_H3N1L-TG^_3C5+3,+1Bc1FB(3Q\NMZ#/?XGQd;7E&16ECf_g1U]#(L
eRJK7Ie85Yc.D6PQXC,1I^SAHfeae&SA?1C^Z3-4W&_RJ.YdP0#/W[PDIK+(d2],
F<4-:.)gX[E[40#?2-]<15E+FF-K3>IKW\:S_>O(GBWZe5EDeMPZGfQGeI1C&DD^
;Fc_,<:/UYH.[He/)(EZf8WG<7-^FCTg?D6>T^#7;<O0NfQQbIPV46FdZP1@.6c#
AMG:ZdYDf-J#9)Lf-R(5]c1bO8QE67cS;^,O3ab>D+Xgb)HBQ<X50^IIc#/7=IUV
/=FDa1#B7E<HN@HNgb0R\B)\af#(([^gRMI//FG=IOY(bBNYE/NB5d-U1CF1<(g\
92WRRBGD0_X5T1@WE@=+5JRB/YDY,_]>ZFc/7-9M_O-ROZ?I[WUc0+\aZEE#^KBb
B6=bV<MDFDQ_/B]Kdg[_G4I\H9L4E_;6U[5N&7,::ML:ZNKA6)/f:_1FD7LVAAX7
=_B3eOPSCLK)cDg0NA[5NT1[))Z_1#U\/(F2ML=X:.4.bEUB57U-Da&&9Y14O6bP
;W+#\__.4YJTUWSfaBa#JO,#\TWYH89ES^[VVP_0eH1^J(T6H[CaDSfdV6R+E3_Z
E_4[H58H#YK@B-VN2G(,dS\?,;cVBL_F\(.FMcJK>:DPT(4PU)MbMWN[->)ee7Q_
M@5K4c(cd4YbR\E,\e]PAR-GcN>?X.2KH3)ZHFNX5LEdN:QV0NV6;LA(>Hf&Q^D/
Q;0U;H,G=F<.EEDJ[QIQ:FWAIMI:aaW1VD+CBO^/,J.\5IDFP_:R=)9=&0HN(5(=
2/URa4fd5]B42O-?J=.(6?:N@R+ROaF,R.QGCT;4R[=,R.9MU_57Sb1cHeV9/R/J
QPC7QGL)-Ba+M)9eSG.B=2?;VYY&<D4,KX,81#;XFLJGC.KB64K9]D>]<EFR>RAb
Y.>9O>7WZ:2-U:3R@2e]+8Gc>(c&:K<QgIG_UJWDT5V#5eK9Ce8^D2C5M(Nf3/gf
W@41)@<JXPGDc:b>cYAdOAL\(K<6+@0A9W_1)a2ME0M3U5.R0U#N[QRJKIeFQOHE
LIT=ZQ9WU8N4@gY\K@LDacP]LM+O+]Dc@EW\?8;#=ZFbDNL63515&_eac_]O9A;Q
P[gg3CeK7Y;0G]_Ca[eWV1aG]:cP2_YeQQfR6SD3T75edH8ZFA?JC#@U-Zfb4BWf
COI0,,8Q+Ed4&N8\S9E>+0W+RZI/&V\Y/d+[Q5])S0(_&a&e\><_5Z<^HPP9[MQ8
OR:4+;1]=Ob>V/1Q^4XM0c2;0QV]NRI.E;]+<_O3:L/O:TR7YAN@?BYCOW@C_[ET
[X,N/R,=IMLaO(N5#?U]JH42,SF]\A@e[[1SAYU.(ZgAHC11CIPa]5EGG.Y2_#[N
O@43b5<fIKT\NXeDO^ZX9Qf_5M>:H9O,56a)(+=:D&AY[6AXKZZ2\NL]B3).Y#LK
EONE=S/UA+G5b\9M50U6VBLAa28)Q<+C9&QLP;?1b3D:SV@UgJOP?gbbP>Y-&XcJ
D^/[O)eg,HQ:E#EK^X^56H(YEIJ;<9)6:R?0@0OdB.,:B$
`endprotected


`endif // GUARD_SVT_MEM_MONITOR_SV
