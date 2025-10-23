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

`ifndef GUARD_SVT_LOG_FORMAT_SV
`define GUARD_SVT_LOG_FORMAT_SV

//svt_vcs_lic_vip_protect
`protected
>cHYQ;R;_M(@8H[.DC2d98;?KN<L;LI4T0Z@Q/Y-Uf0_8:QM2YAV,(WCMH1MACA#
K/FEG^27Y7BAA4;RLY3EO1bP?3ZJQ^9e7(cZ)#B1R31DDTGNA&:e-IcU[/g8,(+5
YA,E[8&E)PLZ[A/&:[0<KM=W\VQP#fZ;G,NE>eMAZdSX9HcM;C<@>S.(T/Of@@FS
3c2UYWKAJ2QV[/]&V;gFGNIT4;,g0)T/E\EXgIIKL#P<P1DK(_]RQ/\CNRbD51#Z
R2<8SUM0;U[VN3d&\=XL.IX\\07QdIMF-0Q?Q+CF<38TSa0Y5HDFdQ:a#CD5Jf+Z
\7.4<^=O-Hb18bI>8XH<NEg]F_-NJM+ECATB4+YOT15M?5@F/a0)@dg.]g::S#Ef
9R<^53H_.c479J#a6U=LRNC[R-_#,fTKYd6,gK^21_;YDD1F3A5H[(^d5S;\H7@g
.#8.;6B+bc66T_0O\?XLM]fLA+>QYCSNd(U5dRH7R1SPNK)FY_Z@]USNG</1H)KC
If#A_SCV6L?PZL+KOd].f,SG-^-48FbQKCB;A-#>43WXHKFEOe#^/CT,_9;_aBYB
C<[8#QX6]N9Lc^@XFHV5<)aE4[ee-DN[I[]^7@2Ic<]^>AL7+CgG.efbFgUX7O2c
Pd8R-<^US\TSd2gT&#Z5IQ@g>H;TD&fI\]^b?B4C-(5Y<K+A+&(\ENd,c#C?57@<
8@a:9.Mf\PL<BgXg9HCJTLY[+C,[5H_1A/YOE;>)HcSCd+B?dMTG^:ZDS?R)[RY8
F(e&&@91.WWgBR:,YS>c2-_fR#2?IcEN?ET^<,-6g,<M>b<+1<CA@)cJdFG^]bLK
D:@(8g8II?QEQQd?-.N9-b@3LMb19cRUU1ac(9.B0:Yg^CC#G9DLBN:9a>RMa[_8
7C?Tc_/&>NHBc<NEN4]+(d>2:T,W7PAeag&a/6W^&^GF=c93=9a2(=67df8D46<Y
T/PKSgLZQ(cZ,<WF^aX2N/g0KJF7Q07@A<fNV)dX8VSbQ9Le6LGON3[QJ+V>]:\(
R[2;e5;aJ7#9d:b4<E@@C_SUYLNBX^QP[TIe@c7CSQ>I?R9<QSG_XOdeKU,\WT05
CHC(O1CUcV\,^KK\;]].5S;IEN+A;&F(K=@a[2>]LUDV=\^g7QP&(0SZU35:((U=
,ME+:7Y7\1&Q?EcN=3Z5#WHAGEa8aRK/#]4QVANbZId[)U09E5d7=Z5CIO;N<Zf[
,9[c:\bV(7S:bGY(.fQd@]HA3$
`endprotected


// =============================================================================
// DECLARATIONS & IMPLEMENTATIONS: svt_log_format class
/**
 * This class extension is used by the verification environment to modify the
 * VMM log message format and to add expected error and warning capability to
 * the Pass or Fail calculation.
 * 
 * The message format difference relative to the default vmm_log format is that
 * the first element of each message is the timestamp, which is prefixed by the
 * '@' character. In addition, this modified format supports the ability for the
 * user to choose between the (default) two-line message format, and a
 * single-line message format (which of course results in longer lines. If
 * +single_line_msgs=1 is used on the command line, the custom single-line
 * message format will be used.
 * 
 * There are four accessor methods added to this class to set and get the number
 * of expected errors and warnings. These values, expected_err_cnt and
 * expected_warn_cnt, are used by expected_pass_or_fail() and pass_or_fail()
 * in calculating the Pass or Fail results.
 *
 * The class provides the ability to initialize the expected_err_cnt
 * and expected_warn_cnt values from the command line, via plusargs.
 *
 * If +expected_err_cnt=n is specified on the command line for some integer
 * n, then the expected_err_cnt value is initialized to n. If +expected_warn_cnt=n
 * is specified on the command line for some integer n, then the expected_warn_cnt
 * value is initialized to n.
 *
 * The class also provides an automated mechanism for watching the vmm_log error
 * count and initiating simulator exit if a client specified unexpected_err_cnt_max
 * is exceeded. Note that if used this feature supercedes the vmm
 * stop_after_n_errors feature.
 *
 * The class provides the ability to initialize the unexpected_err_cnt_max
 * value from the command line via plusargs. If +unexpected_err_cnt_max=n is
 * specified on the command line for some integer n, then the
 * +unexpected_err_cnt_max=n value is initialized to n.
 */
class svt_log_format extends vmm_log_format;

  /** Maximum number of 'allowed' fatals for test to still report "Passed". */
  protected int expected_fatal_cnt = 0;

  /** Maximum number of 'allowed' errors for test to still report "Passed". */
  protected int expected_err_cnt = 0;

  /** Maximum number of 'allowed' warnings for test to still report "Passed". */
  protected int expected_warn_cnt = 0;

  /** Maximum number of 'unexpected' errors to be allowed before exit. */
  protected int unexpected_err_cnt_max = 10;

  /** vmm_log that is used by the check_err_cnt_exceeded() method to recognize an error failure. */
  protected vmm_log log = null;

  /**
   * Event to indicate that the expected_err_count has been exceeded and
   * that the simulation should exit. Only supported if watch_expected_err_cnt
   * enabled in the constructor.
   */
  event expected_err_cnt_exceeded;

  // --------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_log_format class.
   *
   */
  extern function new();

  // --------------------------------------------------------------------------
  /**
   * Enables watch of error counts by the svt_log_format instance. Once enabled,
   * class will produce expected_err_cnt_exceeded event if number of errors
   * exceeds (expected_err_cnt + unexpected_err_cnt_max).
   *
   * When this feature is enabled it also bumps up the VMM stop_after_n_errs
   * value to avoid conflicts between the VMM automated exit and this automated
   * exit.
   *
   * @param log vmm_log used by the svt_log_format class to watch the error
   * counts.
   * @param unexpected_err_cnt_max Number of "unexpected" errors that should result
   * in the triggering of the expected_err_cnt_exceeded event. If set to -1 this
   * defers to the current unexpected_err_cnt_max setting, 
   */
  extern virtual function void enable_err_cnt_watch(vmm_log log, int unexpected_err_cnt_max = -1);

  // --------------------------------------------------------------------------
  /**
   * This virtual method is overloaded in this class extension to apply
   * a different format (versus the default format used by vmm_log)
   * to the first line of an output message.
   */
  extern virtual function string format_msg(string name,
                                            string inst,
                                            string msg_typ,
                                            string severity,
`ifdef VMM_LOG_FORMAT_FILE_LINE
                                            string fname,
                                            int    line,
`endif
                                            ref string lines[$]);

  // --------------------------------------------------------------------------
  /**
   * This virtual method is overloaded in this class extension to apply
   * a different format (versus the default format used by vmm_log)
   * to continuation lines of an output message.
   */
  extern virtual function string continue_msg(string name,
                                              string inst,
                                              string msg_typ,
                                              string severity,
`ifdef VMM_LOG_FORMAT_FILE_LINE
                                              string fname,
                                              int    line,
`endif
                                              ref string lines[$]) ;

  // ---------------------------------------------------------------------------
  /**
   * Method used to check whether this message will cause the number of errors
   * to exceed (expected_err_cnt + unexpected_err_cnt_max) has been exceeded.
   * If log != null and this sum has been exceeded the expected_err_cnt_exceeded
   * event is triggered. A client env, subenv, etc., can catch the event to
   * implement an orderly simulation exit.
   */
  extern virtual function void check_err_cnt_exceeded(string severity);

  // ---------------------------------------------------------------------------
  /**
   * This utility method is provided to make it easy to find out out the
   * current pass/fail situation relative to the 'expected' errors and
   * warnings.
   * @return Indicates pass (1) or fail (0) status of the call.
   */
  extern virtual function bit expected_pass_or_fail(int fatals, int errors, int warnings);

  // ---------------------------------------------------------------------------
  /**
   * This virtual method is extended to add the 'expected' error and warning
   * counts into account in Pass or Fail calculations.
   */
  extern virtual function string pass_or_fail(bit    pass,
                                      string name,
                                      string inst,
                                      int    fatals,
                                      int    errors,
                                      int    warnings,
                                      int    dem_errs,
                                      int    dem_warns);

  // ---------------------------------------------------------------------------
  /** Increments the expected error count by the number passed in. */
  extern function void incr_expected_fatal_cnt(int num = 1);

  // ---------------------------------------------------------------------------
  /** Increments the expected error count by the number passed in. */
  extern function void incr_expected_err_cnt(int num = 1);

  // ---------------------------------------------------------------------------
  /** Increments the expected warning count by the number passed in. */
  extern function void incr_expected_warn_cnt(int num = 1);

  // ---------------------------------------------------------------------------
  /** Sets the unexpected error count maximum to new_max. */
  extern function void set_unexpected_err_cnt_max(int new_max);

  // ---------------------------------------------------------------------------
  /** Returns the current expected fatal count (can only be 0 or 1). */
  extern function int get_expected_fatal_cnt();

  // ---------------------------------------------------------------------------
  /** Returns the current expected error count. */
  extern function int get_expected_err_cnt();

  // ---------------------------------------------------------------------------
  /** Returns the current expected warning count. */
  extern function int get_expected_warn_cnt();

  // ---------------------------------------------------------------------------
  /** Returns the current unexpected error count maximum. */
  extern function int get_unexpected_err_cnt_max();

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
T;:R^+=16g1EAaY6UfWACS2K7=5ZedPIH>0R_cK&eZG=EALOFcYN1(-e5:&UcRT^
V3cXAHI)5.ZUXc78WP]bJT(TM7N.I7^K4V[dW<c&M1=(TH6Q_g9D08<#)>Zg\ZA@
bY7<G:D2T^KJ?g,e_:N[^VR35RX.?NBE.HS=-+\4dP:g]BYI6,?>ZSPCF?XL^BFL
I=-JI717?R2NRACgbEKSN^5\0N7LS21Wb4Y:^=JT3]P?^gGMcL]f3TWOD8)(0933
3\7/bR2LQU)3[IMEEA>FJV<T4ZU?8A,/C/FD:J2;E14K_9D.1IX8(2#8E:O0ET=N
GWbMA:2?3#L_#7_AcCeHcI?V4##d#SNP\4e+E)65T3_/VU:d29+03e8,BQPCL;VY
O/8Tf5174WQ<I+TDMB:OY&#>JB2.1&@:NE<[E/cd:fUU)WMVZIKYc:O420#C&@dP
6a#H#DU(76JM>]EFQM.1=M,@S/Pf[_g1OL6=+YSYe^?E2^Ed/YG<<8&]Q.7/7f&,
7US+P;1_ZW0JC85OYUFNJXIgFQB>:Bfe_gUH\B;U^KO8N]^W<V)@N:Z/<7b=L]4(
0:aQL7e1JI:g2e.0HRUG;f:P?I)Z7\Mcb&cb8WFVVaIOLQ=H3/D0PJGe+=GU8MQd
O:N+D@ZE#ab?C@NQO4QKC-0B?UI9V0[<>3AB7gLE.O(6Zf\)DECH;_)2Rb\-5d+Q
(#bN0EGXXQEFC6Ob4+M:,](6=EZ+V./_O^J(-1YLH_B@4WeUCaZg)1TPJObAf5a0
;;]7A)dNIJIfd&.M;>@e&[W3Z05>IL;.Y/gFOPGWVb-0g/(_B5R[RM@<-C#J[)54
W=7?UQ/4Ge:-ZJ(J7Le&9@[#Z/A7@O[T.a.XE;G?0@J>Q[9I_0a):>N>>/X<Te#D
FcQ5PWD+0X3AebXf]U9<OgMD;M6I];:9XSRBd?6CgJIE&29S,_,:VX,6;:H5E6&<
#b3QRZ@Za:/Hc-Hd;?)42.aEaJZ(,C:fH?D;DKPO&M.D:<E/EHUFL(YGg8?g-3F<
/9#V7.5KN=PXN1Z/R?..RJ>+07_Q)A=]R<HA^TJ\/Gce)5-\EH4NJR4e:4<RYcQ0
\dFVBNa.ca6/]6<UdJb\UPW76KT,V6G^B0&E9C/X#Ob6Y5GX=P2a+A-.eaM=8FOg
J@_cZLGE&8\+\dYaBFf3Z#6TH3/KU<)/?60[NH1]\;?<35b9,=T7GL,e#FB)I[ca
E>PANGgEOe3<_eAbGE^Vf9.LgTBQ1.O)aX#.>_PZVd>PV6b\\D.JbYQA38RW#gG&
,H&69:J/FdL@-4Y@CHV-@+O+/:BF&L#d6]T[4dGE,(ZUE<<HJ1&60Z6AL#S^,Q8K
LU;4b9WA:,\8&RAV\VfW\?+=@_;CfYbOH7\<YTbM4QT?IQ=[1[X#g<OSXRU1AU)0
CB^;9f_d<DOX4e[^ZIeCO<^(f@CSBZPU53;>7&R=(R7C3DGAM:,EDggN6,d\VU)-
O+(^0<Ub<4VT1cI6WTLeA7a@Q0;3B#I\CDG=/9,0H8UCIC<Z@8c^5BG7^D21N9?U
g_X2SLb@gQ&dA@g/8SN>EID6A7T=EgdITE3f?P,+c66R>EGLd6Q;6EF04a,1bJ4F
4C9:FAUFT\4-6_9O9AQa_VP1,gNBP6gXW-<?a@-c.9I9+1L/_XKKeHf9_DGQfA0]
[_D&5fU=[PIZH5Y733]AINYJ8G,Y5S0_NWT1I2F=0_(@&<6DULGYXLTE\Of6(1\d
d1TSQZIHR87U_-HV0+8T:eH/g0,=64T+@/&B\VZ>IJ#bN,-.\g2,SbOK/96YD(C7
=R1&T4g6GT#9-@Ne@T7K7D@M]6GV#SP6gB@>bBYP;YQ43IJe62?F&bfO6/5EL;+:
8BR+JSCRb8)RK1LXRa9Y#+NZH97_\HQfZ09OU<>^GC[F5U-?^D/[cVNd8S0[FPP@
0B3+2I],N55&:,L46f2(Q5.:#bHV==0c/L=<;.LR^-dDC38=Q\Y-NF.\+gdZ+.?e
;TP>FL0?5YB.7g46.=:gEdb:-Q1C8C5_cM&1(CdR3TJ?TRPcQ<LbVG/;;HHL@)AE
QVT:,/L,:ZHW>,EB496Y7UdO1gBN#_P^=e,9=;T:7MLe?PQOH7FFZS+E,&1BfAcR
:WF<&cV]K\Sbc&A]/[+=-6V@KUTNOI:+TeOObd9<2X&SDAS\I8[ACJRC2]d5G>23
dTW=TRL091b9-Z6FD;D/RHPeSK/ELf854OT:@bPGL1H;,#1C5S-D4.Y0)?YJ\]A\
C?\;)X<O)b3e+BA?L6dO:b[eTP:R&4-;=E#<[_?5CAVN6/PS\I8\<VM<<a@WS;&C
\ETV3;K\/&8_P=U+O+CMT2R=;CHCFR96?7HMd.HWX&T++OV<BEU_05[2@66+,a;\
2P:c3ILg_S^WA;R;gQMM:T:S^_[/9;PWbN3^,:KCCT@e<#1OdZcBc0)\GI6)+Q0]
1Q&O++^TJ&GcKgS(0&H93>5\;Y1b5//G?AE2)Q329W#T40LND8d+9]^RUc^<<E_L
-E->D7fFKcSAYZR^@U0R3T[GdW^..CG(CMg?eWbRXfPZ5Q)^f^E:LYL/=JSg6V_\
_N-@K26TRBVROcU#-L<<M_=7KT8Gd9>^M@VK;22JNQ9Q;#I=M?Ua-@JVf&.X5AB/
;X5YLJW2DHgfF^be0WUR>G=_5g7PN9;<ABZ@V]a82G3\HE/FQVTH)YRU\G_ACMID
&T79,0/5V177\_0J0[@48>&S/))d,O?MZ[4,3cd.N2b<a;RKPaY5)8FL/:+dSSB9
#DL4e_GZ,_9P6U&=1BG^A+O3Z-9UU2P6KUAO/&^^b<^LT.9CaS:Sc_[UIb9UIVL8
Z9Y30fM16DPCN9?>(CVe4+<61KC#f<[>dW-J23b_<KO=.HGV.?1]M@)BRaJJGXg)
_VIDN0/7ON=G<0<bgI<;E0UYC87M\a>E)3GB=C<\KS+02C-e;UK-MPK>JaOJ)1/E
QJSc82.7=R2;?.V,DJVN&-R9Ca4GFNVDHA7#+2ROBPDET<1^0?T:VWFY/>2N&_a-
eW&g4eeO\KB98]T4f(d2;F1:VUHVag5F4&X&eKO4/RRc9(8RS#J4?9CYaI]-_GI[
#69ML.b-DPV30#6;?8W.WAIF=Q<1I?_FEX>G6gQcFfBY:\.0QV9E&G#Z,/Ne?40\
f+_C@AV_)JTN8cQ(WE/C1N&>/12O?/Zb=1V,>bQ6JCMAg7&+V<:Z_KN^7MT1e9#0
G=+VIP1]2bL3R\(6WJWPRU0Id&0Ngg3>WMSaU/Q>D2TLg^3gD)0F@)dF(JVU_1P>
N]^7LH2^6TDIVOMTL(M4O95DPcI[1?-G#KGb_=U4B2W1]cQM)WdH?4,IH1FZbGY8
]51SW-6LE8CJG#_aZ6_L]2QY@DRR9Nf^855=B/8_ZbPTQ42/R(P4bTP^,+B?UW-e
+:8F,)LVWL=IfO=/Da&6JT::^e\EQO(L2[Cd/W.5H#EUC#^\J@MV>&P:T>_a.(bC
J0O/QC8@4Aa>AY_DU_N@E#+3_/[<dP[1?Y3K@A)TZe.a3GBKIL<\4aGCIc_>b^CA
C=>E7\Xe2.5bI?W3/CbU)@NUc@IZe-[Q>7N-Y^H1bca7SQ/5Cb;&)Be,Z8#YQX6/
4&Nf4AdF?FCGMR4=e=DATY\?^KXZSA5a,&,]9_75QT+&7d^KY.<>V@e,81]1Oc\+
T4?BNG1dA0f2.9;^&#<fH?]#PE&3U9bH\52WfHGU-T253;1DaC()\P01CH(cOM7T
a:d\1\J@]/8c6PYLDWPT&>GC[Xe;c,Q,2Z4^H3g9,Wf2b(DfN)8XJGJX1T/?(4aU
&JWUbd_KT@gI/AYA.aIgc1\b.GeBFVB4Ib7Q0FGT>6F_CY1+,Z1N\7.G.WOa&[DJ
T9M[FM63e:F\(P0g_F,QMTY/56+Ff9g@f6.FI)D\(e7YHAXH;YAL5:@[;Z#K@[:Z
M9?Z9\d?BW:)TJ#0ZA,dJZXCE^TU.YI/M<VSgNC]3dC9UI9M0\86RK&?7X]8Z8-]
,VOZcDN:#(LFbQ^\]R+NF8:RfI)RK^3NLQ6@()>1?-OJH4^eT&)CaP(M?R@[V0UN
@-];#a->,P8M+W;gOEUB>T_3FM;F1GR]7>JUKO<;KI1-\Bg/.X[M:A2Ig_Bd8-^M
\<Z&_2V(=._CQgKXK<A6a;L^gc8I;e-fW/H9-[TLPX0LAAc8\;I-QO/3M6S[^7H#
X^Va1H\2GFX241P+KN-)RFQQ1TACAWR/MG/6bSZEO,KX<#CEBXG@IcG+.N4_NX26
e4^)b&)(=.G\XBE5CPSB5O??O@PEb;N1M3(G:WF3>:Yg-2P&10F7f8Wa#^^Pd@Y=
(@MVf230GHcT-6gb0NQHK\L^1Kb\4.gYW<,J^QV?MTPHMD23cMDd?BA6GeS//O=f
PMUDe:KBbUdeK)6Q4J@caR]1BN9EB4?S8:2CV9.C+N;/LccLdGf>TQeBZT@eL3OI
cG-=&KIUEdRISC9/#;V[DY33X/9M_&\17gK=-+ZDM4&dT;a1S&cb]d3-7U@^?D65
Z1dA(J9=,S:W@Ta;8S[2N?^F9991(>(#Ed<CG1]&C&EJ_PTW4da\<J+Y)4RD_T+8
>UWB^/;&#XXA.LQ/O<];H9EA,]&N9[3+\a7?^aKM)GL(OKS=9gE<W+U,LbT&<00@
TL5DMcW4P/7b2&OdG.NN4VdGV&;VE.>cW.))<OX40:g<6fIP5Y27@R;O.gKaYcT.
HG2RQ@Vc4](9#a>4Mf4fXL&&<CDL1MB5M/9\5+2JG>[?=\MU9E&#E-X550JXOZAX
,WbC-f(Z1F>\BVU&8\eF_>LAE:4^XH15RMYT^N^K#++)<B>#]_.Z&eDdBaYb&,a>
,L7ffH+(bN]U4b#W-L;N]::-7_69eNaJfG.XUNYVN_ZW/D-_gFb0Fgb04a)53E0B
7KdMP9BVf8aGV&(ZG?U,6I9ORb&E.7>NG8<+&UME5E&C]VEO:U.U337[=MN_L+&b
;VeZe[./X(OTS)6T-I]WIEU,?c2Bf0eJPc40[-#80>NcIO74PgC&S>LPU)2gH7V:
QOe[aN/3Q8R>SaVKZ1d5Q]^B^8He>0945W(P@,Xg,K[3;?2AB(&Ug]3S-VW5\Gd>
@6bL/15G[-LE.cZ,O7,>WWCN@O7HX,U3PfL/[d])G/TbO16Z-M:/C>@>Zg0E<^.^
PF)aHPfOa<B()AEER+WYOf@[6#d-VE_^LD9=Y,VQ-[S;?O#WQ>O1d2C_?F.QHD:?
H?@&-LK##CP;<(4(GPQ=+2/#@Q6f8DZFaN&+==gZCU2VC\]VcC8.\#b5]H,S//86
+;J(g_H64.49,d:NWcI>Y[F<:a-9L(@-UKTVg#IbMJO=)0aIb]B(LPfcW)]-UH;K
[[6W7ENc0\g1#bO97+Q[+1J]6?F+.&77N.XS/ETFdQ.7CUPE^7WJeD0GFR8ATYTg
(e1Gd#SF@C&U2WW\^gQP9aJIJd?H<PcSA[YDJG4cddQ1+=Dc92Re[aM\a:;Cg#HT
/+O>;#FZ,#&-S/OQ<=a8[VG/3T3<+2N[T_CFLf=]#f]+c)E[W\bJGEG2MH,:#VN<
91HQ<]L5c#IOPF^EF[WRK?2F[<G134V00=5[MV(6g)ECX^FWKR<9P>X#aaA@G1V?
2CRWb6?MPFEZ/&-c50Y]b+[]AAUSR8Q]&L2).fJSCA]?BXY0e);D^Y?_eOcTXa-H
NUVbf;J?_.&7OAV+)<FGXB\F[TBD[5f5>b5Ac#RU9S9J=<,(.S;WX/1A7GdN\OXI
PCHQPCc0XXggH-L_UO5VU2T4.,@G.=Z#/#F[8^X/,UE;gM#KU\F,+B4\_-1Y]&]]
a71+abU+<JUdDOS5&LHQFZ0W#A\-DAd,HcVS=06eD1KgF_QC&f5J_6ZE>;F.O@58
fX=\PAb;e#&VMbM+PR;ZP.7I:_aeUgIZ^PE2IT7F-8_:WG<Dd->W/OH+IK^]1P-_
c35;f(0dNVQ&C[9?Aa2?3URO=[gH5/W:,T2Rb2(EOPU@ae@-_AAEN8(E2BB=O0bB
:[GM;N\gE.E8B@bFg9^S^gdW7(_Fc/_fHMRNB?TMcIL4-?\fCc]P+HJ3bBXfG4dc
,>7GF1JO4[:ST-WE+_gJa[f:3\4@G=V3cZ)6)OKDX=MW#KBdTP44B-FO?bBW_>XK
2R@9FPNXe=F-9X09<]JO.0QaC+a_]Be^5@.M:+;>\aWC6\F,VI)G^QgB&a@L:W9f
WKg:;^?Z<fT8Aa0-cC-;#Xd0U?e9<YfZabE^TW49ZDD]DS6RHP[O:XS>0X.,+QPT
Q>e#AS#g+)XF^:C&,0Qb:,[C/ATEb5CV?a4/]3?X0ceY.ac@LD<>#aFNHY4,Y.8X
GOC<(@K+L[/Y2-Q50PQYJ:d)M.QTfb)-6EeFBfaS1](X(d4BfSUA^&H/@A5>+0BE
Z.A7bf44-JcVXG9FaA)0DXIVKBQ3QKg_gb&(D9PUXIN&Y9[Wg/OB)f5CWNCTPXdg
N96V=eaET@I[9?^AE#172+LHR-M2Pf3Z//4ND:,-e>bB&AU<<#GV,K@LfXE(D@1G
2=6(/=A>(.X-TTee[b35AOVW3YKV+c^fCH6SONMMHCX-[.-Od-B[\-9U;FV->P,[
cM)>.NJQ(6&GBRAbOTC&Q<V[V4<A)@=7]#WJ1T3WF_4+\H<5ffNI.OJUCRY8/G/d
C<);U9@#YGIS&B^>:OLNVBXUPbD4W<(<WMH?_e-RAUPDONV<aW)-IQ\gKP\VRfYc
bO?_Y@G]?^2&0RH1-;EHP_/eP?eCZO?^6e@L&9FBNJ,99ZQb^+=IQW)1YE=?7#3T
(4N]@R;5=;?+L(/4HLVgEAJgY(O_QJ+TD[?GFFd3(M4[=Q#5>V_FTF<]7W1eD&3&
;5gQ7RGC6A7W/OaQ^&IGPQ?<3/VWLX^eN;Og(TJJ+^#(AbAF\dXL]D3R]_)XWf<&
g+GA=)99E4a.J\I]<G(S6U=KJ>/_S6fFGNaZX0WR._(+6=G;>Q[\7&/#S?P)X0Ka
Y8.1PRG[K._4;>d;LQ+OWMBGf:FY</]@,:f.W<,/#YRTIc\75]V@aA(#PI/ZGY+f
N=f]=AKQEGM,QS/AbC8YA@HF83Y:,UTHGOB>:4VGCGAcTS0_dX\+S44UUH0HZ1eV
P>CT&48LbW@V./FF,73RB0T1?F09-2ZQXQ-^P+S#<4HNeM)CS<MS&3<0f1PHH8f-
?[@JRC;dW5)JW1T[_G>&NU:U8>I_&=f:^e:V(RR3[@O@O/8L6..J=b71PcIP9b;g
f\/MUSDV]@dbe1OK1L]UGM?e/[GT1]47HOY6RF8U8:[=:[Z2O;;2VRf,3gaFd#P<
P=A20>c)@2ea9+H3RC:69#Xf08I(@UZb>2K&HD>A:B[(3B#WA0-S\TH0/&T(b6H9
>dRUX;;&B9(e\-7gb6JTB8aO^):P9Y8e?S^>134&2b.6cTJACa9R)S@=B3],;bI7
f+V3(4IXeFa<1:(cA\NQ\b_(LFfIR(?H2Dd6b>+-bEPKVUb/gKU9&7K?)U,X&HC<
[Q6@+E<^\IE/6I:7DP(f<SEY)&G.QOXb@d^QYLNB>-5&EbB9;Z?gEYB;Y[9c)bc=
][cb9?I=W,UOPcF(K==N<\a0OC-U9.1^DE]g(d;K]+_:EWI7NXPd@2_2+5_+QQ&9
9F.W[[J#6KXSPI.6^+Kg8cI[<Zd2:>YM.<&9[UG:=91WN1gMW=,96.52Ab9b^Y-+
D+gO#FbA&d\C::g.Y>TEL81M2@^)LQ:#B2V)[5&J1_]Fgg437W9Sc1/D4)Wd#+d0
d?5-Y]Zde2&KDP#&PP9NP>61M=?R70H5(<66CC8Ucf?(NCY(+G]HAQBd2ZJNgS>G
E[(J.C(fBgfdC:>&@AYUZ4]CS^EPZ?JN@EVAQ+GXW,7+^UM(FK;\WEZMQFFNLb;0
VTMHGGJUIQVUP08XZ=,H@Lg1^R@eP:M]L;(eS4Q>\UFM5OYCYaZa,=aE]S^dX=Nc
?5@-]L>Yg4aP)#A(ZOYA;(8COKB-))LQG757Be)g(-MPbG3D?M16JZ(dHD_(2D(^
7Gf&2/[BX^TKaR;NRU=&94\_BQT_fUb5+f+Y3;6WZ[f.?E8U)R:?[B5SJ_X<)c#_
E(WY98QRRHb6J)@#KdJC63aAC_A6b;f7Hd#EX\gRZ\eH4-,F1IX\a0/ALPKEW]a3
@[IX7eg7YO(_-V6fC@g544/N4BCQ5H0dS4DdRG85Q0JY&>XECQX9/_>>4=7OOb[7
B)1HWC8+08;KC_4/af-0=OV@>T6eM:0#^F)8-7WE,9U^U8ML2SR5]_69#EX#&3I?
ZMU(Z&8W;,HF;BXGJa:I4(a85e/=f4],H9F&@-/8ZaBP^)[B)P+]ZEdeZB<4;V@1
=@E7+JWWO\&gO1L/7B-U/,H=Q^-@I/HSB5,@cfVBOK.[_8[YD)-E(IGOJ?;NF0WH
6T(V=O=;7)-4DDKEQA\]7U\g69RD97;WE(c:eX8);@bd_&L2NH\R^XKbNbM6+=#J
\TV,<]P9CaD/TJDJa]/cCcaLd]>0P_^:VUIfHURP\AY4,#T_Kde,O&FN>O,0OM?;
/X2XM<5(IOc:AH117g2-L_C98;[#@>X2VV+2RKc2E[WMJ=&4>ddY>I-IN;L(&gX)
-:TF989>]3V-W-8eH<37cE><4I+YY=Rgg[KPH;g7E-M=>0->[8A9)NRX4+8?5U-K
;GVRa?=^R1[)aMC].,Q=B\2/QU&>ENR9&^.eI_T^M(S6WF^/5>?UGAP,:Cc.Je<e
U_/RW,_g):I6<K7\SI8?dGSf.ZH=5(\FVMCZTDI#0(24PPMAZ?^,?)O0]c7KY\Ye
3;AKVR=VW0RHT;=.AM,JTL:(/UA:g?ca3eSZ22R^&<QB)4eT+XLf@3BaR.>M9G9/
V4R&O<&g2HeV>H@R)f-8QcEM<[E&MITLg>\dd/:O3KG_[L)L7c[R_W?0<SH-;SD#
A8+/4Z:>KL5dW7IQNa@5[LQea(=,cWb<ATP4b&J1&#?(;PUG:MAML]fA7\,d0E^9
?5b?1<.LA#T)5<).bT^(Y@_,2\RgO.&XI&K:G1U7b=X3K,<YT4fCCXbO8e3HP:A+
I:AXS#=^Q>72^ZN[#_H\@RVNXLFV3=bd@5(=^Z?+QC3ECaHa,E]SQdac59OCTK9E
DA&<B<.eMeCE+.4@?&aZe?g-RYeCC2)^@3Y&\gaI#a+9]CQHBQ7=4(B-COX=&#Z(
8\9GE)A4#U[MKFRd0XBY.<_U8gE6VSIfcJ/0+S,Ig&(W,AC3.2O-)HT7#A.QK,Y@
_gR1,-\3_2+E&S&SBX;\^G,g2T,gQ?;?LY^MMMd&F=JWJ/83?-eDYc>(6g<]8U0f
fG-F5A0YKE[b3UZb+[9WVX[We+XMbOQ53CgY377VYCWc2cY-J@P-RMX;,4a3J9Jg
f,&K7SBE6K/F\/12.)#<IJV)[00^:^HP#LNfMPAG?>3X02BM[>U85L]>YW#bB<2\
4Q^#DZ]5?b<dL_f/aAPOYOFJHR+7WJde&-Y?]O]N),SU7F8;Qa2I4G53LVQK.b22
9WfQP3C]_bM3F;4J7T[KW8>)V2b=7b,]b;6/R9a?19Y2Q0OMN:2RC?J5ff\ZA+#e
W27+b<5_1O\a^g#cX+B[I:QBU?fb.TV<8SU4=NeG=bDDCRVGB?B<3eQ)U>J\e>ZF
#&\?M+FSgB1W5Y)1&^fUM#LR^M6ULMVcBZ]9CeT<;S#PM#PN+<VKbQ.NII.[]cF5
)<YI;<-9+U#A8\AH9Q<3P>X[=.T[DRD3FF:FE\ca/A0.dZYF#C(US=?KNFCM;OYM
:fOO\[8c0K8-HR-:O:;2?<FV/:8OY6+,I&IWF#_VcDP):R)Q<T0.T[Z,(a]TR34I
<A[F8YW_43#KO]24H(@bLX&)O)W)XR[-)3Z4g2-aUS)AM8g7:6Y3E,?NG8/#RF+]
J7A0:aWWW6+;FeG&Ae3,5>H>:7ZgA&\MKWE,_=>YSFS-0=MK20OZ4=Ra+JKJf5(,
]<ZQcRY4YMM238^:,5A#fT+VV]F^+UWMM9+Ib48Y4&6f17M1Eb\F461GPIKIT<Z/
&:/=a5Bb-S8O0](SF0egW.MeX^<0bFBU5XQ-;K89^GCfV&[-cPc\N?E2_8CGc03@
=e(&.adFX_Z47>^#BCLJ54N4@\=+C::,?=3?A;:-d;IFS_<OU9e_</,Dc2We3AaW
;FfO^JfG\)Jd;V@P\0bYS8dET^BB[HLeXPN8E7\?Lg[5[F9>KK<@#GPVRB5K3FCY
,^1cgA0F8(NP[W_;6]X:8OgY47L73gdcV;IAOQ4NO.UfB4?<OXUW@_4CLATQ\)?5
IY_77&RSL0EBX&DS#@+,Cf@.+3AZ&JR-14Y@(=0,(V&--JX<3deC/<.W+F&-1K)P
5IO&#-(6fJg4fJ1)A1gKBO<>0V(85NMV8_QM9@<3^e6W4[2_[WeSX0=GQTL8TC>W
E2[N[HaL8Mb6KR.GIY;TG(b+M>9\=&RIV2)a=@cZ9EW=-J&-5<4C_U?IRG/EBG1B
IM==,CNF39RI#ALL@HICfF4=9J4WNWQO50[/g81>[9ae>aE)#2-e=X\98fNCX#/<
gB:9;M;aFUHe^^KGPSUe0G_Hc&XN6)V]PW_9#?c@ZR<cMAfAAKg=/gG#^BV)+6a?
7]1YOP&56:Cg?&+)OdgDE4@_WD@FS(,4aPeC7ca5:]==#&T(U\YbaR8&8^MY0/Ef
g;H&XaC>gDB=5>(\Ng3:_V3I6&dSe1,<BXPLL7C.)K//94dce;dJe;A&Z(g;9]0M
5?B^<Z4R4X@f:3^&a<<f,58DcDM[L:a0;]a_\C.c:d_,EK#e(+AY44CCMgZ7_QWQ
5O(WN,9;(a?1#eIABEORG5,IG_g266Q(56.f[@/IP^YS&3]4TC(.K/K5=3U>TQbP
<Yf/R76-2;RN7G6-g]#L.3NWHSON6G>d5)Y861DT#HRa\L;]^<H&B,0@c<94J(:@
Pe>W(KKc3ZI4X2?a=Y(^KCWJ3DQU<?,6E2X.DP,YW8)Y?Te2cfFK.M-I>YUcAHIA
\&C9#RIBLF,H/E[Y6_07Ze/PX8[AM1gHc@J)ZO](;T]ITE8@eSQIWaKR9WJ4=L\\
B<:X:eQ3HDAg/Q_([[WU2>@R#&a))gMaA>_/EV&)NO>1fVZ@;:91bU5S/LceWF1g
g:?N-]&VB8Og318dfH<(6K).[K6DD,[>7La9UccD2FW[^^eJ<@I=[Bf0(>T,4[fO
G]cKAX)b6+O+]f.IN^d_N)55O/5&>aB);/.b#;^/+I>_ZHg]WNeRWTGZ[)R#QQ)R
D,S-\;d\Wd^0HI77fbAESH+b3g60:X@603Ze6)8[Za5D]^-S=&XZ&)&/RI&(3F9J
^3=4c/@HRT8g3W<M4/)T7+-b>5Y076:<@0Z&=+@O&A=T&H6+e[a?NB@<\g;^eSE-
b[S0T_MR4WG.#6TPIbb9fUI>9CaDJ]e/>N-UL_)ObVUN=0DR9FIV]LN2<>1\PSF2
+^56Oa5:Ec6<[#]OA+C]9SeF8eUY:WX(Q@VIb].U5()6=CPM(V=+Y>[NY:.a(g68
7cX98+1B(S+a1@X64OY@2O;PI9&>AS^I#/JU]K-&d24GJ><R2LMB<Bd8X7a\[[WO
E2NV6_SG^9?RU\0FNbW2O#H]#Af<g\>-D)DI-&@-M^<B]:=ZL++(UJRN\beaMaca
6(PV[F\\b++Y>8BU=;;]_CH]2$
`endprotected


`endif // GUARD_SVT_LOG_FORMAT_SV
