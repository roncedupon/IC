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

`ifndef GUARD_SVT_SEQUENCE_SV
`define GUARD_SVT_SEQUENCE_SV

typedef class svt_sequence;

// =============================================================================
/**
 * Class that provides the basic infrastructure common to all SVT sequences.
 */
virtual class svt_sequence #(type REQ=`SVT_XVM(sequence_item),
                             type RSP=REQ) extends `SVT_XVM(sequence)#(REQ,RSP);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /**
   * A flag that enables automatic objection management.  If this is set to 1 in
   * an extended sequence class then an objection will be raised when the
   * pre_body() is called and dropped when the post_body() method is called.
   * Can be set explicitley or via a bit-type configuration entry named
   * "<seq-type-name>.manage_objection" or implicitly by setting the sequencer
   * manage_objection value to something other than the sequencer default value
   * of 1.
   *
   * For backwards compatibility reasons the sequence default value is '0' while
   * the sequencer default value is '1'. So by default the sequencer will manage
   * objections, but the sequence will not.
   *
   * This does not, however, reflect what happens if any client VIP or testbench
   * sets the manage_objection value on the sequence or the sequencer.
   *
   * If the manage_objection value is set locally, then it replaces the default.
   * It can, however, be overridden by configuration settings.
   *
   * If a manage_objection value is provided for the sequence in the configuration
   * then it will replace the locally specified value.
   *
   * If a manage_objection value is provided for the sequencer in the configuration
   * and there was not a manage_objection value provided for the sequence in the
   * configuration then the sequencer setting will replace the locally specified
   * value. 
   *
   * If a non-default value (i.e., 0) is set on the sequencer, it will be propagated
   * into the configuration to be accessed by the sequence. This will force the
   * manage_objection value of '0' for all svt_sequence sequences on the sequencer.
   * This will have no impact on sequences which have a manage_objection value
   * provided for them in the configuration, but should override the manage_objection
   * value in all other situations.
   */
  bit manage_objection = 0;

  /** All messages originating from data objects are routed through this reporter  */
  static `SVT_XVM(report_object) reporter = `SVT_XVM(root)::get();

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /**
   * Identifies the product suite with which a derivative class is associated. Can be
   * accessed through 'get_suite_name()', but cannot be altered after object creation.
   */
/** @cond SV_ONLY */
  protected string  suite_name = "";
/** @endcond */

`protected
Ia2>9-2)QO=B+Ig&I<B42<-9UcNV>NZ\X:FJ^QSR;O>B,<7+Jb(a0)R#a/f:7;:>
.&6W=T(-E1[,BJAI37YH>XC]=,A[Ue&94J\BPTF[.WR-\9Q)2KW8PgR#O$
`endprotected


  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /** CONSTRUCTOR: Create a new SVT sequence object */
  extern function new (string name = "svt_sequence", string suite_name="");

//svt_vcs_lic_vip_protect
`protected
#a+bFa).=.[3bNT]09;L)0&AAKTLBDY5U;_4#L1F3bdBNK4ACR:>6(P3LJ#F\-gH
,)VNEV6d-KGRG?,dU=?-D:Z&-,36D.ACGQfc^I^bfQ^OTg<-EaIXU&#)g9VdUIF7
=BAK&,GFY21QX(9L=M:[SAc.XE>>f:.+VOcZ:NR.Q/b3eEdeAf25,DJ52WU+#6M6
K]B9gKFO/IS.[#]ccPa.dF_9\RET,52]H;8QI,G,ZN=+Ea&VD,ID)M>M407U8>#4
5XU_f>GR-Ye>^WCX<\edG:b/1+5C\Z65bN4YV@Y9bO6F&1X=fROU\]@<J;(WX6Fg
b<2bP70Y3)K9VO+]6d1YVIA1F&2<<X=CeZX_9@^DZ+HB6()+\H:TQK62HH2e9EW;
QQ7g/?dc0a?Sd(Sb6B2C1J<GHR:/JMII:#]DP1(;=[EUG?A+Y)O62,Ib4],[_J+b
V?/[4/4[5RX(8PBDI-X?I6VeG:5WN#WL7;?7SGP6/5P.0IM6+X\E2NIbI$
`endprotected


  // ---------------------------------------------------------------------------
  /** Returns the model suite name associated with an object. */
  extern virtual function string get_suite_name();

`protected
_\PN+X0K?Y\[cB[d>#UP/JJM3e-O5CZ7SN<.G,@,[J6H=KB(,4RS5)FIO@>6F)_X
<W^&A6Db_NJ(Hb2_^>Xc.dbS0QJ\QOfYPI=?F^d^8Bg;cG^U,3LbJQ@P5]Ra3;bL
[?TQ(;4HS;b8=8@?\1:5>ZbS1$
`endprotected

  
  // ---------------------------------------------------------------------------
  /**
   * Returns the phase name that this sequence is executing in. If the sequence
   * is not configured as the default sequence for a phase then this method
   * returns a null string.  This can be used to retrieve information from the
   * configuration database like this:
   * 
   * void'(`SVT_XVM(config_db) #(int unsigned)::get(m_sequencer, 
   *                                          get_phase_name(),
   *                                          "default_sequence.sequence_length",
   *                                          sequence_length));
   * 
   */
  extern function string get_phase_name();

  // ---------------------------------------------------------------------------
  /**
   * Raise the objection for the current run-time phase
   */
  extern function void raise_phase_objection();

  // ---------------------------------------------------------------------------
  /**
   * Drop the previously-raised objection for the run-time phase
   */
  extern function void drop_phase_objection();

  // ---------------------------------------------------------------------------
  /** callback implementation to raise an objection */
  extern virtual task pre_body();

  // ---------------------------------------------------------------------------
  /** callback implementation to drop an objection */
  extern virtual task post_body();

//svt_vcs_lic_vip_protect
`protected
@Q>)b0;e4L;cPH#<ZKC2N/1(DOZ-3=7KB^Oa^+OX@[86U=QQ78O;)(;FME^#WNe(
#g)IK01R/WX47a>10G_RDdTTMaM/g2Q4#:N&0cRT]OgW(BU(?1YH@?\N)TMF6e18
/&<JGPfZ[_?d[a7EW&[UFK_94T+4d#R[_dNUZ\-Nc4],Uc(&0g>371H(IYVaT4#@
X9=<Z<+-5GH2a9<N;A26RESU>IHb(H48VJ:1Vb._ZH50A/@3Cg/\WH4/;;5,a@P4
^FO5F,c/]B:);bd<9049b)ZUXN>?DS5,D/&F>NOfO6]+YE6>F)-4+Pe@F1Q)B>5U
01ZHIgeMBI<I:=C,:YSb07-DW9448OU\RSgVg0E>S.E9>acE#Wa(O:6e#PSd(C9P
D/NDQ#R@:M#=5J,NY(@[.0g6B=6[g=C(LJD516PIe4HbM+Y,Sf+5&KW891#,4K6R
f/K7H);Ba3\g.=NH-[I/a:^BH)A/>b,_=fYFY\442H63?.G6.C-7Y4,U2[7K/MLB
d^G]aB-J-MCHU:60aZ)/+;+fX(K2=cF<3X/C#d+:NNS4PXcc5^+<YD@#I/P=,See
e9L._EJO=&cK4Y-Ue4<L=AFJ7O[L5BHCMYF.VGG2CM63AUGRGP7QK.]9YJ^<@^V?
I@)MCZG,CAEV\ZEVW3Y\P_JbUK@UW[M(HUa7L06B/0YRSK]B;/TK),+e-T;X,6aT
R9Y2NYAQV8T=K#S13fR^?ge^USBd;R9,U(f,Ze;+WM=.0RS,0XL_SIRQWO3I6a<@
QLg>=?,5Gf@b8XbQ_=IS6G_DA+;P]C)&Wb_^3)g0X<USA;-=I_3S<HA1,JNHf?C+
UA^(IHD:=1^H)#7X11>>3F&EH)]ECN^2Ga<9Ue0E9f35<:9W3aD:\[A1N$
`endprotected


`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Obtains the starting_phase property from the uvm_sequence_base class.
   */
  extern function uvm_phase svt_get_starting_phase();
`endif
    
  // ---------------------------------------------------------------------------
  /**
   * Determines if this sequence can reasonably be expected to function correctly
   * on the supplied cfg object.
   * 
   * @param cfg The svt_configuration to examine for supportability.
   * @param silent Indicates whether issues with the configuration should be reported.
   *
   * @return Returns '1' if sequence is supported by the configuration, '0' otherwise.
   */
  extern virtual function bit is_supported(svt_configuration cfg, bit silent = 0);

`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Utility method to get the do_not_randomize value for the sequence.
   *
   * @return The current do_not_randomize setting.
   */
  extern virtual function bit get_do_not_randomize();
`endif

`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Utility method used to start a sequence based on the provided priority.
   *
   * @param parent_sequence Containing sequence which is executing this sequence.
   * @param set_priority The priority provided to the sequencer for this sequence.
   */
  extern virtual task priority_start(`SVT_XVM(sequence_base) parent_sequence = null, int set_priority = -1);

  // ---------------------------------------------------------------------------
  /**
   * Utility method used to finish a sequence based on the provided priority.
   *
   * @param parent_sequence Containing sequence which is executing this sequence.
   * @param set_priority The priority provided to the sequencer for this sequence.
   */
  extern virtual task priority_finish(`SVT_XVM(sequence_base) parent_sequence = null, int set_priority = -1);
`endif

  // =============================================================================

`ifdef SVT_OVM_TECHNOLOGY
  local ovm_objection m_raised;
`endif
endclass


`protected
WW8D(KN^+dQO9/X7;_KC]B3\S3@OIYJb37fW5.KTf.4-4NV+0[>[3)0K>Xg.G3@8
JKKQ0-CT->@A>TUMa^af<C[=?&7K^[4P_9eFKc1eHK]15J6VP=Z;cX/cO\,89;G_
TOg_0I24[LG);GZ&>TQe.3W?Ef/Jf0_N4-ZANC;.O@9<0,dP(^KW.G9acA2;3^EB
]54E95VS-BA8VcE?^D<G\D^.PZ-XaY4BL++gGM:<]-cUM>;)TUG;HRL29:#Cb>;:
6K1@Z9X>LN#ZgTE6HP#9(6&EBZ,b[=VaM[9f,1B,a\@G1]S;10WWc3eeGe=88:L0
T;\1DGXW;G7-)379dVc+I;M9VLCY0M.-#U.1[cff2;8Zg9)C)CKZ-32[b>\W6NY;
GP&<4N>gP)0=WG9IS6#E9]H^B,77Ze?V]K8HMBASTbKY[\NQL(XRN87UfQLC,]2<
<LGP<^VFZ3G\6J/JeLB3gFdVDWM=^<S-6\3G+2/,NZJX8KQN6W2B0C5Z?G8I8K;b
\U^/GFf+89a_YK?-MRb>(4@/131_,X-(3aaJF<GVg8>S=_X9Z;@A(La6g88YZb05
MfKO,<bJP52g7A6\6WEf7R\WO?YW<eV@O3&5BTEQNX9S4XJPNA7RW,:FD+E[E#1g
AOP7@0+ZHaf;f(fK/8T71D6_^/.E=LF=cZEIe2Y_<&7,g3YZ+dfI).D:f.VGLVZ\
A<J@TGb?_OQY(_]R?3MAEK9d9Dd6RKNdKDO+2N7d)M=8:Q^YXG<0M#JcTJdee.N9
S/g?Bg.fDX2D7T85DZM/2G,gQP#I+B<NY[D>73FT=(<bOK@?B8bdD+L_Ad-@]&.T
\e5M7HA_RK5)5)Y25GN#)H3BU=3L+96c(dHdO;B[86D7L@T1MJcLeJHMVAS/g2O0
^K?VE+U;H_eL<UM)1MW-RH,//:,0:6^)<$
`endprotected


//svt_vcs_lic_vip_protect
`protected
QU)X0TTHSM?/27PSDbV]g1OOH7IQd&&Y2MYXVRd0Zb/eC,KMd0@f3(62:F0a,:9H
(de7I6cQBF.J>+9=[f>0;<6)<[IMUXYIcKABI/RU7)7++^3BJ?@a.^,b>73##BIc
dGTQbFT]BP8PSb#+\:A+&X<IBdVVBAK&5?MH[&:U=B#NK_V+>)KOe0G,.B\V\=)@
AE=RLQ-eBNJ_(_G:&K(99gK(ET2aS([)=,>H\5B]J4GNeQ5Q6I5[c-8?&Ee/K70f
W^d//G)>eAQ4-@e8Q.M2G3&/FG@/^3c3cE[NH=_D@L2^:GLW.g-O1RgfLC57^Taa
2=Zc7L_&a]K]-2<a/^FF1L\b<=bLb[ZbZ54]T2:/@f6MJ-M.;@9>2Xee(&<Td8G/
:WWeZ23OO6G6:-I\PD4@HaKQB)f(C?<]_//^=/.0DRU1R/C<^+;_+N>J^H3a(R?2
1T01<e:FHLRDFGT=BS?TJQ,TbUD.E62T>71D8W>F]I#_(&Ze>X_IO-5V5U,T5:08
R30CFf3(PK+&OgN7\24,=D.2DcbE#d?,,&B/THMTaH:L[48_@F;RLD9JJ(\OXfZP
K7+R6e2RN>8.Mc\aDY?6-GPg5Y>Qd:/O_7^ZA27?)@X#GO=;]gTKWaMD6[=Q/#&Z
9GW2X_fM4MgXdMM/SeBN-#1M^[ce+KIg>76dC/--97C_?c[IT0>7XFO<L?<2gde7
C)MJN0RI7_2CD6+#QV7G(V.\:=7f8GH^B+(cQJM2Z]B+e@D6aL6KWL?;aKf2DDb8
@LB&JASWJcDST,8IY1[JdQLEXV,G>]R.gDJXfXMZ00e-MKBf5.A_BWQOEKK32+/G
Gb@^8)ad2/D([1OL<UKGT7TQ0Q?V<OB_IS+D?SGP):1g.Fc6b3egG^c@TX]SS(DB
+9I38a<<,BC(3XLG1(F^P&B>0MX]-<:X;831Hc4&S@:))[+N,M[D]d^\D#V58>A>
+Qe9PE,NDNY&]aZL?^c>YY^S/JG71;5Ea\cd_;2^[Y,bL0gR>@:B7(WG6-d:(O7V
598D)Z0d6E&X-NgBf#bK+7SfA<a[MFA)2N24T)f+57BE9AUf+-c5gA+Ue@:Le=&.
N.<,b28I.AHcZRg5XJLV]KR5#T_=:=#U_:89gW.L&c&&BM<&a#9ZSEH#HRg^a,.X
P97>6V(;4YLH\-PO)F1(:F#8C,9CNE+S9Y#3Va/)9G>1eD^@JCG11BU0U^1AK[(N
[],N=49OCG77E?[?VWSQgeU@1^MIY69UcI5a35/(W]DME^-N=5[LeZgU:)P\aJBI
QA#gR(4W;FUa7]RU&57Eb/IE1fT_)OS[B:99+f9YCUIR7VG<CgYeA4J=M<SG]<-<
1bd(B@KQOZf0_]5V];KAZCcH=X)\#:7IDa\GPNLV3M4a1/(RB)MHdH1DTXT))TAU
.622T,B9_^.YQ?S);#,:g:Y5N\M3)V&8UD>J-56]?QPY2?eDc4)0MO#Ib^#/e73Y
PR.BP&=]VX+6-cEN=Q^f_UVD;(4:Y8-c8NSG/,AYP::bIYL.f4WX<XI+#N7ECGR&
EH\L_47XgWfMAHBWTAL^J#Zd5[>96Gc]I]+/FI.A_;aNbc7bDT9EK[9Y30Z)90+/
BL8V>&OCE:0Rc6bggWR>d.F:eZ+&[YfJedE+d5/^=:HgD-\XWQK3T81I>Mf9.RH)
K\G6L>/]G.P>?;Y1@d\\\?EMU=.PC/4HaYT[bQQ]9\79GTX2D2K4F&R&XLLUKW.[
)eb>d8)PXfFMY-Z:2Bf]aZNTa+bN&:AaZaGODCfX[^cE<(69bUCU0OA=<NKX>V#6
L/ff\I4F_f7dVPFH6-e3B2153I?E&Q(cL;2aK63RdXY;[(aP^R97OHcgFG^2\a:(
[-N?WW=\01:B@/?)R8T/<L</K^7NHb@<,3[)]IC/W<[FJbbZg\e[_#bdOPRU8-g;
4UZNXfda4F+9MX@Z=DI:a,5/fQP7\[F/9a/JBYf7@:I9N#AR^7HfQ-?f\Zb78C-#
a#)0;Vf2<dUC5YTf/4U\UY?4cA9a;XATB8M?QTSc(8\L&8DMZ;DT>BAUg0ae=PTP
beG,&<FccT,+SR)@&a1KGXS]#UD83aNK82\YMFPde/LcC6<>C(T_4eT8@HZUV(SF
Y&F\&3LF\9E2#@+S)X72;@fR50/HM1)_,5U<^ebY9ag[@fJ8CgLX&5[gR@NZ<KDH
:2/3#fKN0eP.>d?/F+W\B(LVE#BZJf,WW?A8Z_2R[P?[&5OULRL7bdc2-bC)H=GR
XG<<&1U8/)JNF#-C>+Y,<g0IUE\>V\?49=9T7H93##2X,5@[WbPK.8U2TMH=A\&#
U5NbU83MMZ0RCG1TJ;W/G&O.RTY/:3.R6J2UV6JcR_)VfC@=Ug1/@=R>J(QA@\d.
)CA50ATVH\_@#BY(2LN#fIPf.AH[_,V;]:8e[_,Z=1\Q.S89FDZ^R;<P48=T76ZK
Y:<9fe5QIDI(V:E/6,I78M^a:CDRLH>I6cd-8V]@/\;V4OTHOE#_);Q9C>545W=:
CT:D>\HM++NE5D00K2__bFX[OJ^a\6,;8bJ=.5;?AAd,YY--\c()I481gTT80.,_
_gB<WJVR4TTDR,)E/We7a-<D5XI=6<cYJ.A@HY<&4I[_)LLeQVacB\SB]<B5;6U/
93P90(Y+Y_@35_R/GQ0S\8@-Z2UX^\FB7c\EgVf(:@cWVH<#U9AgC,B3)fFMT+XA
4[@@762[+BA:6fV[aee.aKW9K4&:.REU-^1L?d?=>778(ED)&PT?+]&V(Ke(_g(K
7g_c]D-I8)7.LPc,^]\@D7:df<WPFDN\_76_=96FF;L-_TS]O1H(WJfAHNA(Z5HZ
eWX/CQbK3C>\1O>fR+=G>\F=9Z+RD\<U2J[:^d@+#/bBO>KW4Q#&F[T-?RCf-_.?
KA1@g]^/Je/T6K_XP[g=[OLV+f/<)K7N3411J^E6g#I?g_)/3&T:H>\P5<<=0[Mc
H]U=(GINS()S3(f<@S77d83YRRc;.b-?S66/_TeVV(5+Y+;XAKA_<7[=f3<82.?d
1aOL)b4+?[>&.N[9R-@d6MUd@3:Ze7F\2G-(e8?HVaXKf-_ZC8A&)RQN)\,V2IFK
2UR=R&ZD<3e-P2N50?GWPgaO@K?:P44fT(G?=M.1dV2+W(BIC<CU=f\KN91M@;+G
^7<8+TOcA_]6?bH>_c,>cK/H\dZUT^#PVedUU=J578LTe0aW6@WS=TfYFOG[a0g?
ZD=W_)+Ac,\dM^)#QAM<:LVWO==LZ31UVUUN5RQE+DcU38&)bFf#[(TD3(^e&4XJ
^8NgG]cR#@HX(?\S2F9c\\0;R,8A9GBdID5./ZJU22L6Q?RSYNfZ^\OYf9Z.#M6e
#U2.D:ON\HJ5cR0YeQ;MTRUaT<Kb[e^<T3BgccF)[,I;PBM3eN,gVf-MM)g28.OY
Zc/Zf/D+>dHPPJfFX?^^Ka6WPXUKG1Rb8&HXDSZ9b4Q4P5<4VY9)gL>/L0PP<W?F
S>(SV;\=gHJPB)8>J1O6-LXgH1?gAb<-A#B2H27\N03,c6b:#G;TdLM@8.e\bDUc
M4I[R<.f;43BD]DRcf&#]+eOSWA:?Q@gKWGa4KA9_WKGDcKcK;OH.a(38C50L7e7
.<L/\;+[YdL3Y2[X.P7A]ZN.FB+:_VId.3<Gb+L2E<&AJLAZ=A:-=R\X;b.5B8RL
9#=^Q9(cVA@+L@?bV8I8SFe<1g)c4V21AG)N/Vgf)/NUPf9g&T3cC+ZY#A>TP+D0
U\9#Pg.\YLH48/RKH>;L]TV[#T456N/B9Y@/S^LTQIX[gWZBb^#=J6=6/SH\a=-U
aBU[B+f_48SVA2g]bSO>PKLQbTI72>NV_O2TaY3_A;^RQRQNC0dA7fc,NH.6Z6_(
b5Gcf]fTE<J90&T2[3&_1UEMZPBc6PUW.AeNXQZ&9IDCDB7T)KdO-1T()e)Sf-JG
8O99FA\M0N.BZ(Z?0:Gf11U&TP0bA:/3ZWN;=,\A>A9UVYg;c/Z5GP]fEN8d3S53
_[DNPU-Y3T6c9#NS6@#/9UTS)e4aW2Q#b1&0A#&Ug7RDX5FdX2LB)U,NYMagEJg(
NOU\KdYQaPQb].Fc7GG&NV,M(I,RTKH7FR76YGN]GKSe#-UI(_XCKTC-2B.c2)T4
[^Nc-@)GaQG9Na0b@=f=IXX?2KYU2R7T:2B(\S+F/eQ32?#cb+W1M.UTB-2WQeHC
(3Ye9\8KdO[#6J5<=[K[S8(6\GYFM<90J@>BS6eW=gH\b]ZC#\,ZGH:ELBHD,1T=
-BfQ0c7-cV&+>e/EO@.HN3XWYWMVN^[cd(5fbb;6eWD0^]Hdb?4g>ab>c.R/<[>1
Be>Ec-6[fWg^[C7QIb3CC-^U5SLA6Edb,>;,O8T4?Cb4c8)0G1_K9eH-Yb,VG^)0
/,NTN,.QJR5I,1&ZYO^afP5WNJE/:N<JeMD@B;R)?6A8]D>;9]EB(I(EW]CM[,=T
Q47dX_M-E-(1FSF3=C.EK#CXUGKGV26C.WO>VZ<UbFMDMOaX;eOFZ=Z=Y)Ab#e(8
e@]S>=H=.QCJe/MAVc46U+W&@+#AA_@O)#JQK=d25[YS[R1@E2PBDNTO-gf>IWCE
HWL85G2_1;0JY@Uf.8]81?_K.fMbMfHAd?DOdMIP<+(D=\D_N7G6dX?3TBOGdOK7
[1+<YO,L0SA;?TC(29VHWGb]BN4ETFHS8FA-e>&TZ8B<)F-L&3cNW]VHF:5NX)S(
O7C.=Z(HW\L:3N:>:,+(7+U(bE#FQO:bS7JWdVI+XU&c;B(@5MYI8UKQf>;/1\@-
CNb<c3EJ<D)\CHBeT7S4ZXVB+[=LD+-.-=438-CV0#\P:6NBe_fCYU40QV[_<4W_
^f.,+KeaHDMCNQMgPM_;HPfPQ]RS6=aE0?M#]R(&K_1-Pa;0V2Y/OW@>>5e>Q1=K
fR>2<cFYIYK<g&>1)H,=C?KH<_1_TB><06@e:W0GNZ<A\:E/+Vga]X7Z,7Ue.=EE
71SaVTYB@+2/(4I9K]Z(ZH(dV96D0UX-Q^#0)Eefb-3_<[2<34/G0geK.U\IHKD0
UFf).LDYf358f,3-LFZ+-GSA(D.Ld2-K@2[Zae;4[)>C2L=WS=J/^AbE[+8>[A]C
:WQ_gAg^4/eJ2.b;FZ8e#N]HfA^22NILM,Q<XL+10dJI.V--7C8O4Q4=GF6H5B0V
UD5gQHE>0NA34G==K4<NgR8Tf<CRf4U;)H,c,MP&c2&SU>/TVKD=g3aH\b#18(UE
Z1YFEOZ&Nd5CJ#dGC+8:QFM(\66459+0+0=0+EcgVF?SdAcKATXO9HNB84^a3MeF
PF_#b#&gE^HYJVa4&GDN8ZWM12&EVN?gLVdXP>,dHE?].WL75]HIV:EDbLaTI,Ac
TPg<3M(S/E7>,Qg+DGe&J97<_?QV0WRaDG[TUKS#&aY83Y>Hb=V1ZJUX1@S_O_,7
S+3_A5RY7]>0)IDI=U0/0_d?MU8ZA6?,_G62D+R.,_aFKF-XY..0FVV^S7cA6Z8O
E:IGUG/_RV3eQHS>46a&aK@Jb[#b\.GXPaC_a4KP]QA.gGZ5DFA,aBb=6V>dY7KR
1d06;I,L>+JSEGVgFg;1dMICG_T3>b?J\7@c,3e_(=JY,6R;?=1(S7-P_[A]/7^>
50>d<[P[0Yb:dSeHZ?a#N3R(^_]]HE+)>-WOZO(<AREWb_:#TU](/cb;RaE(f:F\
[V46cb6KIP#M]0#>)aCG^#LACYJU?(AXfCfE,)RI;[5-WSCQ?O;7ZV.4PNSCH>IJ
PGB9IfG.1-ADCa]O5C]eY)W[g17+=K>WU/B#Y:)F&F=HeBP+D=+Z?UaKEd.:aD66
LZ.g)FQg-H#X;5:?+2(7+NP5B^4&g5(FDLKADIZ,+CMU=b6W5O^DK^9H_b&)A_G8
/W&La6I5C[QX<DJDg=,98I:P+OF4W>.DA?;PJdFTd]R,1A?R<HfE0]P5(@(;(SO2
T65g^QYB5B9J(.HgQR0<D@1JA\U<)[K5-d5MY.AL8Ad=YP2:bdQag4fP>L\<)#Lb
.g3GVE?>B51XNBSC3(9N86;/TQ=:,/]Pe/NTc;?;OX0a&SWCdA2@VIMW0#[8>;^d
>,B,-_VLX#2g[[;D[F=UDZe(2I\0(]c6/VAPOXI9J1:e8.@G:c7AZ_(#9<Q-_W(g
5.:[e79E9_cH:D[QMY>FQb.bE8,HeTZKNfg4.f@&C]W71+_0dU&\R/I@)1.=>;M+
RM>W30>HeMAaV:VWVT&>PXb@Y13&20beD<S3RX7US6D<^H;;bN<6>\VYOf+=AS8a
-))\YBL?(<(VH^K^7cRH7;U-4O,U.CJO4g#<PBMJP@HUW[/Y[K9fe+fd+[F5f_?4
SadE/ZaGK,W-#/RVea?&DXa[?)69]30X-ZLc[fP)9^<8_<f7I;9SYaI2Za]:.-1d
#HS<RJdWOQ/5dCG6&fVM/U&O&fI1b1Ud4OcLH((O8,aSBE[47eI\+aV(Q//FXb:c
TZW<a#Q?K&VPe3/d=U\]?:,2:Y)\H,QC<:8R8f4f):K]S+-.KHHa]535)R9N,4WI
98O+47KHPR/.dNAg9&/dH;AA(Ld=/@FZ0BW0&VecJAO6&809>H<5X3_KW1KbSc>g
ffS,RBg;4?@B]&856R:32^)ANe,E]=K/(OM)>]=:G>f>Z0J6.^B_YP)&AM??]Ngb
]U1BV_CF8a_G;-W5/e:/K\+JD[]>2]T-9=YUT\5Ff3OM<6-Pd_bYdM+_:B7EPAR0
f^SYGKS:<_4.PVY7A4T.4-caSMF#9&PD=$
`endprotected


`endif // GUARD_SVT_SEQUENCE_SV
