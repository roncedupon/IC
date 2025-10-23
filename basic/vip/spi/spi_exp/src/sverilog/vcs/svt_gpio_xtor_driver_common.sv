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

`ifndef GUARD_SVT_GPIO_XTOR_DRIVER_COMMON_SV
`define GUARD_SVT_GPIO_XTOR_DRIVER_COMMON_SV

import "DPI-C" context function chandle svt_reset_gpio__get(string path);

import "DPI-C" context task svt_reset_gpio__configure(input chandle           api,
                                                      input byte    unsigned  min_iclk_dut_reset,
                                                      input byte    unsigned  min_iclk_reset_to_reset,
                                                      input longint unsigned  enable_GPi_interrupt_on_fall,
                                                      input longint unsigned  enable_GPi_interrupt_on_rise);
  
import "DPI-C" context task svt_reset_gpio__drive_xact(input chandle          api,
                                                       input byte    unsigned cmd,
                                                       inout longint unsigned data,
                                                       input longint unsigned enabled,
                                                       input int     unsigned delay);
  
class svt_gpio_xtor_driver_common extends svt_gpio_driver_common;

  // ***************************************************************************
  // TYPE DEFINITIONS FOR THIS CLASS
  // ***************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  /** Reference to the C API if using the synthesizable VIP */
  protected chandle m_C_api;

  /** 
   * Static associative array of references to instances of this driver 
   * class, where each reference is a back-reference from the associated C++ API 
   * instance for the corresponding synthesizable BFM module instance.
   */
  static svt_gpio_xtor_driver_common back_reference [chandle];

  // ****************************************************************************
  // TIMERS
  // ****************************************************************************

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

  /**
   * CONSTRUCTOR: Create a new transactor instance
   * 
   * @param cfg Required argument used to set (copy data into) cfg.
   *
   * @param reporter UVM report object used for messaging
   */
  extern function new (svt_gpio_configuration cfg, svt_gpio_driver driver);

  /** Called when a new configuration is applied to the VIP */
  extern virtual function void reconfigure(svt_configuration cfg);

  /** Main thread */
  extern virtual task run_phase();

  /** Initialize output signals */
  extern virtual task initialize();

  /** Drive the specified transaction on the interface */
  extern virtual task drive_xact(svt_gpio_transaction tr);

  /** Eventually called by the C API::interrupt() callback */
  extern static function void route_interrupt(chandle          Capi,
                                              longint unsigned data,
                                              longint unsigned enabled,
                                              int     unsigned delay);

  extern virtual function void interrupt(longint unsigned data,
                                         longint unsigned enabled,
                                         int     unsigned delay);


endclass
/** @endcond */

// -----------------------------------------------------------------------------
//svt_vcs_lic_vip_protect
`protected
fCZV7<.8M>UT50JAD,)KQO6JN\.?\<.@U=AJcf_/J1,@+IF&F>d?1(DHTBGI(e/W
/R)0=C10aMKAVC-.+Y]9RJ4F+3f&W--5A^STRK?Y_X+gUE5Vg7+I+.D=>K.UQJ&B
2-0,T&8FXeI1F32UcM[)_B;SbeIHV2+58/3##Z1EVC:9Gg7F2[++C70\>O9A2f6Y
e^@ZG-R,;[O&).@0ZG=UY42;cReeS3dV\E3<VN8>2PZ2O?]NS:8:f,VM_N?7gZa5
TG\1(OI190W@09MA&OTgge7A9dD#YHWP;.ZU-OL:_9^R<:QY+8JF2U.STOgL36)&
XP7]_ePECP;)XRC6)>J/V6dfTYS<4&===OX5L3<aMA7<FSH5K8gG3[&N>T32R1Rc
\/d^JL:GY/g[2DeG.TM)G9U_/7>FP8&TN@.TPSXW^;P^5H<=@YKW_]c+;Y<M4Z/N
,@VCCRVb>NBX_I-7&CVf]#eZ,c8a(M=\f\??@WNTTSd=HgH->V;.f3QFa.-NF__b
NZ0:489B??#JL]O&SA:_Cc-W^Jg[S]U?6>+0a>?Z?0(aKgf+d&#^=Zd-9=ZA+(L(
2Y:d<T?DXCGA\V-<<f,W0WQ>2=F3Gg#G1/EVMB[g9<[1^V4eI-Q2I^_#.(6FRSHD
#E>\ECc9E-?3DA5DEE8-ZS1G2X+<WD9X<5POWS]IBVG_S-(3d,F.P+5-:Ae=;_(B
:G]WWEX1b0Dg+_2e]](Of@US9CJF6WK=WE2NA0<I7&-=)J0WA2Pad82;)&Sfd/0\
8>>8ER=ZLFVRb[F?T_Q,(>DYgdPfa=7XVPKCWR&9;_B(6XVY<Ac45I9/U4HcE(\#
.,2_<L^EDO+=6_Nd^5W[@G^c&A,F9fI8Z^f8+=)0/]NdR3.0O.L5a[J;_FM@2;H8
PJ#?W23EX9e\Ke<g5bF,,&0+#>-9]+45Oa#e:PS:Y[+PDT&ABNSR-0GFIF)\/_K3
^cH1(-_Z(9T7B>QVX99fG7T1@XcAJcR[LA.4T45#A)4@da24BR&21;SJ14_<T#4X
BOP#3IIBDS\\OT6P0SMYP)E(+GX,E9^T_,AI:C]3O8?fIJ0Yf<g&,9aA#9;D&R@@
-deb;Ye)M=?7TJQ#:W]E;,3K6>TUd8\\Xd;S\&\N:TaK^.\TV_dM.55BII963A,7
f[=[We1Z\)[&?^]X;Ve_7X1A:=VUaQ&KMdFQK_CC_0[JD<&4FeV/&KSY6_eRF7VV
fAa1GZeWN\U-PC1#9.HEQ7dE[\,6[\]gG53egN>abWD5DUXU?Mb;TfeabcX7d(cP
5W+gL-K@E#_c,DP=,?)TZ=S2Q)K#R@S1YRAM=Cc8G84OQ-:+)agdcU:R;2U3,C/Z
]00/T^8:NK9&D@6#LV+)cN#>;2@B2TfH+cYNd8/5(Uc5GfG8582a0-D@N1>b7)2U
QK2IT#DPWYU4_8G24[TD_.,])3/9=?GgQaY[Q;Y:LF(E7/NWV1NdK?C1FVL@:GH?
,7AF)f:>X=]MG#-fgaL9F]X^SAJ2K^IP:ES/468Q^4[DOA]^gd0GY]I9=_1^VDY_
>XTMbbPQ=<]de]XA[&a1ebQ-1B]cS<VVgRQ9J3PUZa(EU#R:d00E?Ob=VC>P\F=7
[_8_):^32TbGBULbLU,C&9N2>DQXFXA6AeRV7b;KJRRN3QR&062&#+@E:VZ^@R@D
]GM&;U7UMQ.V=IJdEC<c9dA&bTH]UTI0H5GFcF.C1M9K2IJV]+8LC;FX+C,HKOK;
]74MeBA/2e0A>[&dN<QUa8\_;>ESY-g:&g<#\RA9.#C5FXc4511^>dXgUgAeGgD8
?/&Z5JHG+RC0B)63\O>9OC-9;1,(]69R-RLd2(FcUK@D9BBO_\Vd._1aAJ#1a8<>
9W9YNXQ^)K,DILTU+fGYN><=:;)(@;T4PKRFA)-Ogg]^/^YeQ(5aT+S)5UE1--05
I-4.#f5H4YIWE5E_A)>31UTA10d:T_b<XUPOg6.XP&>E1H,WXAbOLKS]M,PXfU99
g@T7<+IN8,MIX.gK25eg>TN9YK4A6eUQ(G(a/@ZNaS(79=1a.GX:be2P1C<^L@WO
HHI^b+YN4Rc9Z77GW5e?<6:7+^(IKFaaY?aIKEF+&4CbDdYM]54T++XAK<A>=I,R
2TKJ8K:HSeHBCUAe>LX_5,Y920DL80.O[8A2[dO16=6QT861(XcY.ecHPFVKW(69
UAGL8A+-fK_KTE?aAU9,C1B\^J3eXfI+Lg\dTJ\NC8QYD()eJf=Sg_MF-fV+Y_G^
aNZG]@^UcWab&?5_\AM4W=Zc8#&f#-RO]V:?<.A>#80R4f/N+6638\@7UTL/2RNO
GZ5f>+.-BXgK6D1EDC88g1ER>4>QR39BaKASPNJN\=[;N:=H0:Oeg#SBF[GN7(Wg
:FY+WA9>dDPSaM?VM_]O2Rf)[#>I[8gHfI948g@]V&+b\WXYVHG^+CD^ZfMTU.T^
3J<7@>a#HbN504=X/1)<\\Z^d5SZXd^>7E+L:_MBc31LHgMQSI<\NBF#PP5CBCH9
6_JSJ)\29XY^N_VO@(A<.>IPW\@1;>GBQbY5&.(TVC+b4Qf5]2^Q)V#P2&NQDO+:
@#CV1f2cb_MIHO2;_FI4aW;T-Q3H-]0\IJ\?PK9]ZU@]/Vd;QNQ:e&c=SdBD=gfX
;,c38MN6BR/M@T=5DDOU9Q97S(c?PZ-E]V(:0fG,EM_7W-(#/R6=:[7<;\aU:BWE
fLP@SH,OK+7AFBdU=baG@0UA\=S6K<2SeV/^9BCZB+K5U9TX].a5VSRE&9cB+MBH
LPbFeDV=,f#-<,?5Qg2LS=Q.c8L;AJ(AX\D^<>0,A/]64f2R,EGHHGC=P)8Y/?/=
QQIHaZAK=9FT<)6B?EW5UNXd6AR?_AWa@/AFd?+#aCWcg7c]<b498JB&8SP5W@NO
WEQR+Yb..TB5PU^=#+M.Z.>#O6+U2W23QTMDW+X>J]CP&\)fe+LX?1T.DG=9ZC5/
TDI5TB1\8?gW;S9.MK1ULH;_W^)g=ge8XCf.81;a=R+K1Y6:B>=+J]M7LF@ZB/9M
8JUUJ7ACCVD?X;,V?2?]M[A0UA0CIc_MAOP_N#WT.fESf:?NI45.KG&(d<7+4/4(
4I6M_RK5S-cML[1&,@MJ<7ZX-59ANYE[F;U[Z5MM3-:U\_eDV1G:fKZLK^LGC2c6
c;ZI[0[V_6@H-5,)H[HKDK4P,;Q^;B^-gaGPGB4a#0_JaFLSEK5O[<A4d60Q2C/?
b^2SHe-G[NgCYg:c1V10W7O7X5K#cI.30^g?/BH0;PT/)3OUfbHU+17Ng-a/cPd-
D6^XD20N?U6_A9\NMOG-J4OI7=^g[GPL(dE6I/+C8fP<:]HNLPd8H5.9SDe^X>MI
D^T.5fbH1(bHeE37&LBUg+_KSG3SUcQLJXba>eEG9^gGFO\-?Z:bg#]M31_)E/AF
<P?F(393:R0G\73X79-)<YYVHA&LOFMd[-Ye08[P?;I0/<,JL^N(d&H+9:-?HB;D
<;c8ZN<_N<6<5X.9YDT9615QY?@52<PFN4PGX;E5;#@F,e:G5Jg<60F&UgQg&c<c
d1@=cH2dN-Q=(GE_#58NV=UIKB&WaUD.+Mbc0c_a(([Y^aaaFJS\RBCO<4QV<Y(.
D9UQ(XXK:_&.(P&6/(AU;ce-FeCEG5aaCY.K?#QR#;Q,._E?^cX6OI&[>-TT=-41
;JTVJQYU;_@GgR5T6DEX:a#VK6,3,KZLK+Hdd+)_MK)E+:Cg@b&-O>Igd+UE,+D[
NRM\DE0D@c#Q4Jf^5-EIGc9cV5G)1Df,1Y8P-<_):KEE3-A\48O<+,9:&dK3<W9c
-&N]W7M_/&\1NdEW^fc^E7MYVFAg#B^&=8T?,3T+RVL8aQ0D@YaBNB(U9V(b[[HY
U-^+GDKR6M247.e2?[Y(<:?@0U=?c#+L:d89GZdWeMDT)O,Bf5N0)=HX=MJZ2&W8
M_M@WZ&13\P]Mgag/C4_39\Z7UcJ5f+76[[65EC6,]c/420Y1.>>O7HAOcGT4ND<
ISgJVKC(TId08](2NE8#&=K.52\-380_BbC^R@UIFTY-\N\^-=20a#J>,e@:OGCe
FIK:CQ7dgN5[I7N+A6:D5Q^\^7U)bTf?SB<9UU=#CUGJ)F?^ABa>E:]#[H9C<b/_
YO#0:ZBH7JPMgcaWFd-fHQX)e55WG^\[7^N9)(a(GBA^cNE>)HHeZ^V/=H99&M2/
889S\DRBL-Q(N@cXR,M</U<MaUc:Ne:M+]6&eR0g1EB6\Lc5V@b??KAaUF7SCS_)
1<]d8WPDcT9]cN(;>LVJ_PGX?1&/[94F8TBS;?8:K59@<A_0?RZN6,8GNa#H(3+K
H[_QDXcV>VTVQYUW#E0:?9f2)@VAJU0A4E,+3:1^dC3KTb_NFH8AYgaDGb#E&ZRS
9^>7=b>&N5F\8#\cRNP5b/@N^g--.3B_.9?2A20QBddC+=Z(8-HEFM[;\&FLK[c)
F>ZfCD^66A)/67a.&L4DH;6f?=Y7cD+eQUfR40SRP.)?7FEc+]Hgg48aYP:I=@Te
HMQS@CB1gYWA&7\-2a9>^1S0@d2S.9M=#c97WLc4_gf\g8fe:ZTVK,@1GWHc_BEN
6EK(7Zd7+]\0dAQ8Wge.INFaaG:IB^7g?>#4G@M.87Uf\V^+FQ:@LPAZV?8+5bL0
1b#H^85[CLG<6&S_UUdCGI[;)>SP1WK6=4)77#.>V?\dfKY0W>11=#KA6L#(c./3
a,?HAc&J-]a]X1BZC+AM8G9YI&(CJ3EGG^aMPg:E&e-:)BAGGP?DL6U;F4^cV/AR
HP^Jb.7eAI+C^#P.>?[/9@Kc#gYPT9aIRZa@_OJN3EV=3V]22,J9?-_04-]&G37;
S<5Z-I]2QHaB)6EXF?<DCeFgQPG2C)Y:Y3LR_C1T71CFba\GI9#?O7&(a_Z9ZZDf
;5FH<F6)e&bgXWD>gDLB[1YV,C9B)^\QE_&/5EM&f9[>Z48)2W[e<3+agN0GMFC<
bC&Y0)D3\1:)#J:G5TbUg(,gTO:-<0[[ga1+>A+,?>>UPeL_\NH=8M7SH_MV+#TG
.D4L2[8]NAP_].bZWDg@9Z282V1#]2-P.,9G1,QXA561.5H7:QW;<=?&^P45a92=
\Y+SQY-<a#W8+55:GAWaL4Y0).8U.#ZKdI+[(+(RAKE@W.db/YT(P#5a&^eKO7B)
TGdJ0]0b1RU)a8=1HF#J]g_6(3?dTJ&ZcE?9X_P4116^P0&.fAUWe.e0;IcZ@N#+
1F.Q8gcZI<9[e,7JH+4#WV5-2]b(GE1L&6cI_^_ad)eB,#\BA>Ce(JPL)U,9X3F&
B,7\Q5P\cAIdaZaQ565S1V(+DVgJTc9?X9UZB+/CfIbAY\/C@@Va)J4<T-R?R=H-
P:OMREeISD;B#dE68f>F\e8N<VVd&b;HFQN1[NaK++(>>MXW26[52(_U@Yg5/e(B
8\96FZ1J[VOE)P,]9)5AAb#+e9e0A(BS075:1/5b=X^UC41)?cg=g2Rc1;PCIdVb
]Y#V\I7J+)0Lc/fcS=\0T0C31[gW8a3#_Z:0g1XUV[F/&Wb3V&dV^Eb@,O)K:0-d
E/P2KK<_NNY(.W=/FKHM#J;D,&X(/)Z2aNb)YU[/:d2R8]XZId?4Wc96?M3#9-DG
WI2bNZO2HW<]2I7>GG[R0H3[2BI9GK#b7WGd(M^7fEH4aaRI>#[T6COM1D[gg_7)
H\;WTS6:H,0&c:5f#X&KeRWB;H#=E29EKfNMV+K+J5aY4C_a/PSXHQVa@IK?-cB=
9<;9@W6;gHZX.7c8:(T[G\_]gPaK3#B6R@4RG#ZU7O+J8g(-f;I@bcV?QQS1U:9+
DH/FVZ7B&;aWf6&QD.+GNT_g.60IW6P?fZA2JN@agJ1>D4XETH(KK9^B@&MEJE9Z
?XKb7dMHFMTFZRA#.IHFA)ZYd2I+Z5CH>\DLH6Q:A)2J2[SPED3EVd#K=O7>K+8c
/TeOMV=11LH&+>,0?;Q,=^;\a/#S8B][b-G<?;?R6@&=/\&,a.D#,(Xa&eCU+[Y&V$
`endprotected


`endif
