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

`ifndef GUARD_SVT_GPIO_DRIVER_COMMON_SV
`define GUARD_SVT_GPIO_DRIVER_COMMON_SV

/** @cond PRIVATE */
typedef class svt_gpio_driver;
typedef class svt_gpio_driver_callback;

class svt_gpio_driver_common;

  svt_gpio_driver driver;
  `SVT_XVM(report_object) reporter;
//svt_vcs_lic_vip_protect
`protected
X)A\B7b5=b.\,?HD\#de?b@WI\3C2/]02>5d,.61TD=9U.bf<5(F2(AO0/:KC+3b
GG+g[=)O+S4-=-:;M?/2MTI\HQ9G?f9,Q,8R+-aX]bP>XJ=&\Ic0SKKc48[)5S/R
AO.Qe2dZ?M)<2/5cD.bTWB@d3X\8->,H#17:S&8Q]&R>E$
`endprotected


  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Agent configuration */
  protected svt_gpio_configuration m_cfg;
  
`ifdef GUARD_SVT_VIP_GPIO_IF_SVI
  /** VIP virtual interface */
  protected svt_gpio_vif m_vif;
`endif

  // ****************************************************************************
  // TIMERS
  // ****************************************************************************

  int unsigned n_iclk_since_dut_reset;
  int unsigned n_iclk_since_dut_unreset;
  int unsigned n_iclk_since_last_interrupt;

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /**
   * CONSTRUCTOR: Create a new instance of this class
   * 
   * @param cfg Required argument used to set (copy data into) cfg.
   * @param xactor Transactor instance that encapsulates this common class
   */
  extern function new (svt_gpio_configuration cfg, svt_xactor xactor);
`else
  /**
   * CONSTRUCTOR: Create a new transactor instance
   * 
   * @param cfg Required argument used to set (copy data into) cfg.
   * @param driver that encapsulates this common class
   */
  extern function new (svt_gpio_configuration cfg, svt_gpio_driver driver);
`endif

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  /** Main thread */
  extern virtual task main();

  /** Initialize driver */
  extern virtual task initialize();

  /** Drive the specified transaction on the interface */
  extern virtual task drive_xact(svt_gpio_transaction tr);

  //***************************************************************

endclass
/** @endcond */

// -----------------------------------------------------------------------------
//svt_vcs_lic_vip_protect
`protected
c;\Y1>KGG5e-<8H<_@c@U<8a=)/e00Y?HV#PD9a[e2AXL,fNAX;,1(EZ=I]UH#2e
80YeG>-TX8Q3CIM@#_<6=UNf^d<eX^A)g^A/BE-GN:_BSddfU_<WfZ4Q3&6DgJX&
=+,<d98R.]HLMYYH?U=\E]SC7V3+,QLXdEOGX]/Kd6d_D\A[Y:S+b@@MN9.:BE05
(&[GV\dG&aVc\6-=:c1<GeA_\>APB=3_TdRHOVF#8_ME/cd))ABF0<HfGM9L(N+6
bI77Ae09>I_bGTA?-8W_dQIJGSeMa2/-]a)OA0W3=66:G4UN8]WJAJ;XHaVOcD>e
Jg=Z?+3TaRQ#eMO-&\EUN-92S1KMDRG+<-;0SaA.7Gc(NO@U>_)TEW&>__\9_9_e
ZWEbJ2c&?C43?QFWJ.Jg0CI7G1,bYB^Z2G&5fgVEOTV17O6L@L]V04L?^e>UO?2&
\TG56+[>F2O6eM?fbO#>4]IE7LMD[(FXN?<O..#)],R7C+6++cK-??]b:TbIN\F^
.Lef.a4GKfI57eC7c?V&(/##[BIgN>cD3O\]MC]DG4\1:IZ=#6B8<A<\RRL)Pg#@
P;F@2RHJ.;.cgL7dd@<=6#4D:[QCAUUGd/B..VPF[\^UO=HF7O^MO/gJC.=G#eDH
)9SBb4/3Wb8X^X7A?D[7\@L/)ISOf[JI4[-_I:--B[T_fCEgOV:#).-PdWW]GSC9
1(IITP/>bZ.<29S66Z,9?6UNaSN1,?GS.8>d#(a-Y])-/2FD3DEa7FfJb2@HOT67
=<;Z+D=SU3_:]g1WQKNJW-cC;CMa].5S/Ib=Z4<FCSaHEbRVWA2WARf\a1f#Z8&c
GXV29>O>]c+9>R=QK]+YI(3e6BaZ1@(T&\EO9C.RK>?\R)O4J6J;>5Z<[QW#X&I:
5cA8J/c:>63/\/G0(EN][B5KU,:cFNQE4]#CUQ61_DaFX++[\1T\BQH)_?124D;g
K-=-dXILN8g58G?fa)7J8,8Af&8cf]#1a27G_QgdGBa;QV1O^0V<7[09gNEgHW_;
FF?DB_/Q#Fd9b\4CY)S42DGJb+9d.=3X62>f+<0b:=]<NCD-If4&L4YG3_&^5)H\
AE@FVS1U>NP&BSdG&gKA9#\9][WRb)^W#/DOcdG,;3V3IT4@bO+]8&QOS(_<X-f2
4O::SU#e\[S]#Ic.Ld21J<V6\L?d3]D?^CF78Z7b.P.IG7f\SJMVF5YU?\^e9DD)
5NYW<090[#9g8)\b=UJLM1@RYe0DQc8YOV8(/L@cZAFbJaO,CgHe2gQ/(T1f;=P7
bg@gI+\SW;>@^/^Q6_1=TBC]V=27+Sf)JcMGJ-N0HeF+IcHAZ4N-[8DNEHD@]TYK
CA#fPJX#_2)Yc\^+G/Q_HL\HTC1S7c/AM03H#.Y8D+\8Q1UN6Y.Kd1_DRKH]M62)
dDS1_0GH7@<8SKPaCQL1V.TOVCf,VP;fe+F?PVY)YYbJ5cU4bKI49F^e:I-N:;Z(
GY:)E23c#3UEbB^/N>\@UI1N<3\SA]05QAFG+#Re#bYCZH=OPW_C(](A2D#TEP_C
;A#6JJB44Gcg+DaFfRZe:=0HXUa<>(M110)D</6IGZVfUa;PWI_^,\CYgK(UgBV?
B7&,Mf+^[,S7+-2(a&4R:Mb8_?6]MHG:L8^1[=5dBQ27DHGAN)<T@ADTdAA,HWK^
22(EcSa&NbQT5DO1NB3P39<(Tb@Z=@bGbbLfG4[ZXCD7g#^WZ9<Z#eNA=RA_273d
O#J&cZ78<c05bI(NOcO8L+N7XCeTJFeO[.C<NLRV(<-2F32Ba4cd@HR46)\eQ]68
A8L?QPT9D#Y7HgR-#>W3F5M(?RcXK]6]eUTF@2L=<d,@5;QD;FQO&2A;;\8Na]#H
\?5#(>:KRR;g1YJS<E.ZH0g/9Z-eW@:ZFD5&c.^.U1Tc#G6WQ/X];5>d/14RF5VA
#L7+gg2YZ<C:M]R^4ER#YX00eOP_00(B4&5gd8H+.J,HbKP#\888,3U/MNK.bX,&
c[cT<8&8Rd&-RGC<BTL6>?];#2^F7=TDad-SXI4VU5D>[@;>/WF.._\S4[We&+HC
?O\MST]N:HF(.B)Q+<D,N\e0/C5/W(SN#?O\^[Xb,>[H9&KJb1c0J/5g&;e\Ya,#
0c9MQ#fO9OF)W8LT[TZ=d]e\c/P=AJ#K-2>1Z-Fc>CJeU1XW_K@@0<Id3VF+OP8S
eAR\WYfNe@52IfNO@@V?7LB?W?S.A9TZWNYWURd@QFGP78?cE0f0YCAH?^cLQ-WJ
CT=H?M;2\>EFf,IGc^Q=8gTSEYI-;2c(;DW4_(2_01)2FBa1@bXH6)Q(Z.)T,0OQ
8ZPAN/HAaJA2J[/f[O+U?]/J33e41=IZ5c5Oa4\EWB2M/:P_60/5VGYQBRY8#.DN
;:QU9AXLYA4,IFM?HGf;=8^1U=4[6&dS7M5V;VP(C6YNFaO#(;=aHM@TLZe)aB[&
20J-LW49XS@>fO,EYG?#aI4>9:5YgeEGA/ZCbB1>;5)PFI,58-,]3<c)L#OP&-NS
MQ?I>RSaGc54?=JL;G9/6B<F(X2f,Haf:?44WXXW4QHaU]E6UH=&SJBfPR#&,cZ+
]G1,Nc+bReX91L8(4S=KDZ[;:ObR,;6XNWb_N(_M1H3cQ)XZ7+.PX/Ab>/8W)#SX
AZIM2A@OB@_@;&/)b9UEP-=\_&R&3D16X2;Ub=R3PJHI2],XBG?8E/,40QY3V6Ye
0BNH9?+fL=/fL1RF:VG31^Q2Q1BW6D3X,[H,0R_57G\9O\#0B(RT#OJBNLK;6TO=
d+;=5gOa4X2+5[.I<:S0UIT+C,A4&^>A,#87>KY\CIW<d/PY7EMf14:741>&/c8.
&LY/<2&;dD>PcP)QJLQSR>GMDL><TF<O;fW&0@..(9:CS8WgTELBG_X?7H6NGK3Q
J)Z1&7]FXX3f0IR;fM/=b,,IO13Rd[.30556/d(QDP5>HLE(=JI[-RfIcKT6P@?c
TE=Z0B(.AFHH3?.a@Wd?=HP0</CK.5[6E:FcOV_g[H=TgL0?d,>K>d#N+;+Tg(AU
09:@]5U?T@b\)8DKR\2:&)QA2Ga13Y2&K:7.Y(0J@#AfW?Y:Z5F[0f79^QD<;/1M
ga(A67C\9PT8eaNR7BBBPUZFAB=Me30Z-J?f:Kf3DLa5IOQ-a<[0LP=D;7Pg5O?6
G+_[YdVI@)PZ03BG@[\@UAQ\MC53?X-?+Qf^-aW>]V<LHTMH7N]YGg]a1D3;>^IV
cEeCc6YJG?#C)_D:=R/W0K.-?1K5+S</ccSV.BNJe:#?B(Y#3I)4@]TD:ae[5>N8
0D<:QTU@))W_dLCeC)7H.#_4A>Y]O-H@T\K48QZQ1P;2ZCDd,J0L))YOUVW^W1V\
RR50ISKBG>1PL+.;U+(0A8S4d(#^&SVQ?97WIQc@Z9)VSETK++@(FG23F9#EX4D,
1_N+D:>/K1-@_DWEa[dDY)3YXKfJWN,,[fJ.?B:>0YS_OU/B57UT57?E0PZ3^cf@
J@;WN?<H0G#X5/)VM5Oc&GRBY&FP&>JN5I[ET=LG+c@07RKcBKN.7V&[Fb-bTW#I
00Z;afgB2EC(XX-0CJ+7-0KY_(OLeda2&bP)R9J7GTPWGKS5>+Q6PCTc9VH5\GS4
SgE^4TN)R;=0_&[L=P.\ZOIA7f8f+<_@FPE9Z/S+(I&da>_RGRcJ[J3^c&PH_)aH
8f=RbfRf]95FfB(]F&8+EMfQHUFWD;9(N1FAB<(D0C=@72TWYXTO0?2,I649?>&U
D.?dYRW9>U;,-9<DY/gA:)2<[Y)[OaG@^fCUKXLbXWbN8Z(4fR=:S&AAMEU?ZS^M
R_L29]^]Hb;9@Nf#YBcXPH))?TbY:,3cU)YW35gdIB]C6UgD>dTQc=+XC)]2GX[+
13@=J4&U??@PRE=Sa7e<CFSK]bJNY2V,d41\fR4XW^b\GGP?TV)QBPH-[)O2b?LR
&;#2@JZc[\Q:=3R^OS]^L?ZF2T:.#_<bF3754]&=\Z=g]+]@+0D&Z[Yfb+9)BDSL
B3YGYLR=B?#]Ga>(KQ@5ULVJ_eKN+eZ^g-IUU>V&]/KLPI)fd1B@ILQV__P:Z<ac
A3?JL:7RRYO<^5ARPUPEB^ZE^aRPcKX(KO1fP5P4c5&bV\ZcLeV,f_C&O7&UM+/f
9D(X+d<63,A:,[(5Y[4b.]<<,>24eZ]NWHYL8MVY95f^P.a,_\(1GZL8)NO]eN6&
1J<C>3gTI^QWHfJV>V4S+0G5e50ACaL#;P)Kd[e/S^>-4ZQ.M;;HgXD.)+1W2&TL
7&[B9CXPeF[544\<3,H<4./IW8TKVfUJ/;7f6g^+[Zd;gWH0F7=@:>g1<0):F)SE
I.QNXP43Lee\fW4FHd_BG[CL/T=[IVVDLTW=#;9d9+:3X:;\;5BCbIcTS;JE^b,.
eUT);<dZbUFP8[Wc8P\LaU.VN29KD\XE0E^J,fY-IM9</5dRY&ONJ1>\Q9EHV1FO
,Va=2FF6?RSG4#FY5AUI;aX3YG(Y\;9-N9dA?+KB0F\,Sda>F9]0SX_:FO+4IAH@
5,3M[9QDS3)Jad-@@=?ba<4_CG:;U.Mb#BK;g#GAaP--+f-UT7<B3Ee[4a)/#02b
dd+c^#a2<_KbH5(,HP;WCM>[X<)K^<C,PXP\HIKEQM3^&@K9KI8J3<1QP)(J55d4
RC?[AOL\CbN2C,@>RM)(aPdZ5&d-/)HCF+OP>Z1d_@<_ee2D-QAadVe)/XTOI45_
P26NY)98RW)H:C6Z?O#eFgX4N>f5@:S-ZcdW3gJ.,_M#O]4KS(E0fI;d8G5gQ87#
VL,gDSVY[&+DHb9P+M>dZ>_AZ-.-730\\\5XRDb3g^A=CM5b8<N0?6M2QT7GU-9M
)UU&-][VDZc[Wg)aQd9^5._E5Y^BRJJQEV8-8g/5Y_<]g.7F3f)IQ\-N<DXa0T.M
SVeV^^\;c/[K\Y8]Uc7a[c)1:&\CUMA:W_7XAI)]]7Q7FUGZ)4TH_YcP:V5;SB:_
LC59<(JTe01X9fT&cTO8S\83XQUF3-OI2/LY8G:F9.TLgC]W:07BD,0AE<V,ORXS
#DYgUXBD;fW[R1.ICT2^75bB4&EdQe@&MQM;IBE9S6TeUD:XXW(X;d9P<L[VE;28
_OOf5(EX(2MK8UVP,,KB&-1>(.6gb>@D?LfLHI07_aFUQZ3G,=KI4CL<=UQG.GEI
d8Cb1(PF+:7ID2:D)1]J_34>9_SDT/,2K.O[Z^+b)?EGR@=UJ2d8]T6:)/MY9Y=A
B(G:\e[_39(0Tda8:F\,aHUIUK8T&L<5cFGc^d6&_(C,RAdX2P,/Q>RU+?Jdb1cB
C[5P;8)QYU8E8S<e=UWPXdN,M34_+<Fc\BNK?FR-7I.<b>UeD:>_\X[g..fY5Ubg
Ib7MFX9J@g7/7S[EHaZe6?6;e_KE9YM1M.;\S@-&AZVGU6D:&G;ADP^(1,X70H<C
<EO\^(?K6<4NGgb9_][.008[PdbK4Kae63a03=F2C(DAQ/,#X6CW^1<)^cCAScU;
)f[,+M8c\CCOT>K7[R>[_<3<,LJNYe]HNNe8f\N[R;[11O;&K3a?JH4=\/JOB/_Z
L4QD@=AM^:P]:&[U8T6-4@>RTL>TVKd4);>O&2(a\6)GaCN=ODEBV@@K>Lf9>(,(
RIA:KUV5]0[VDG,[KRXM@SeX>+?X.A>.Y.C:?bUZ>SEY_^3P@OTYgH\6K#U(S)JF
eY7&^.eF-/[[@?S,X>IMPWT]g/:ROM.-N]OQ0/+X1JV7@3G/,YV6KJ&8@>9=V;GH
R[0DOL4/VZb4:.J-WITZ4IKW6TJXI]R98O,VTff^\4d)^B^0(O@.<21TEJ?9@WbQ
W)FW0#J(a)[aG)0)>,EbXE]NBBBfH=HENce#^F1_2VeKcd#KM&/HS5SB5d.dU[eJ
PRcK8_,0aQH.g<UM6_.QNYS&bTY\C4+<>:=,(59gUb.Y5?cY^O.d040C_,<M[1AG
0V6f3:.X36c&&+F&07XJWFUD_)E9D265NVN3aNUC3._M1CQ#IL\?]U[@J]fDGWdP
5a84/Z+1,&SS5B-QGTPE=.1fRAg0E).@>LBGX8Y5.Q_;R\:J)?)MaBa#UV,:P.OE
-=F?4&dM/\PePNPd2?85C@RS?]bV.Qc:)4@7#S]f#^_#>7,UJ-e499e7CDc(LV:b
UGb93N<<AIAJ+Fd&Zf07Hd<S0,/QSe>b=,XZX[487O<+7PF>2Q:ggTNLef=+D81(
JYFC?;cP9/_T8Gf]c+WU0E1NR^GK-QdSWT&Y;79@J7K?L\(e\G1-F8HU7?M&K-Y0
7CY4IB3f=WP1J+3^<4R@GgK3=34869&;)90<F^LVP\<YE2MWa]&CfgZ9a.SKeZ@8
f85/e=5X,c1A3[H7&X.N&^]dBe&?Z<D8=adJ=Af+g_;G@?#bD(+.9T)(c]28HP4J
H/3aKN3LJ+ZX2/HQ/D>gb^05@>F\PP?YfO?TGH57#(^GRR\8C@@3d>L>)(\+3M85
5e258IbT6YDC9Vcb3>]B@L=.C_>()Y[+;bH9>[Q:DHD]IDT?cV/MX34f>3K@Q70F
97/3>Sb:=6^IMQZC6WSe;I4.C939:IgDHJH-N+?cQ(K/OJba>6=?L\1Tfd7VW+/8
ZP64V&Z^RI^M=EZM8T/GJ2J/f9OaH)J14+?WV39F_8KcHX7(,PfECM4X[/JQb:TE
]P@#;1R]^U@J>gUL:U_8ZZ::-1Gb[_).U+:Y86:eJ?GGdA]W&,2<S^HR:V>3DaUI
1O3g0<+f:XL_c<Yb52dR;<:3eHIGA#XSb?2#>-6;X;,N[D#9=L;93gHRI$
`endprotected


`endif // GUARD_SVT_GPIO_DRIVER_COMMON_SV
