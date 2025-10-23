//=======================================================================
// COPYRIGHT (C) 2010-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_EVENT_POOL_SV
`define GUARD_SVT_EVENT_POOL_SV

// =============================================================================
/**
 * Base class for a shared event pool resource.  This is used in the design
 * of the Verilog CMD interface.  This may also be used in layered protocols
 * where timing information between the protocol layers needs to be communicated.
 */
class svt_event_pool extends `SVT_XVM(event_pool);
   
  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  /** SVT message macros route messages through this reference */
  `SVT_XVM(report_object) reporter;

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  local int event_associated_skip_file[string];
  local int event_skip_next[string];
  local bit event_is_on_off[string];

  local bit add_ev_flag;

  // ****************************************************************************
  // Private Data Properties
  // ****************************************************************************

//svt_vcs_lic_vip_protect
`protected
P.E^@Q5NO[\fd-_.1#5;cI4Z@8]KeA1<Y/+BcEE,2H@;gVR-&9MV0(gc7T^0ef@=
WV4(_+L99MA[Gg>31BAeRRLJX>AY;T<EHTg5EZg\Tb@<f64#M=H<Va9#U4.f&RXN
#R<IMEM,/:VSg&>0Wg_SRMX2I,Kd3)\[G&ARS4E;ZGE7c\#5^&5O84<V2GL7KV_2
8U(KR[7+NC2^5MZ>dXD?Y3dUIEV51CJ@^5X3-:Z9TR.U)[144-JIVHYL\W&R9M^J
=P_dI.^g;]O^^EO[c.KC:cR:M)W.90W/?6R.9:=:/<FQ#BI9NS_b+(...7UgWJ1+
?O_JV7/MCP0S]7)?XMBJ.]L,XJ]C.H;AS[HCg/RYaFb^dgVJ)Of5gQF627[19SN;
HN7LYX9X;>-N[?fFN20GS0YSc6\5+Pf;Z]H;??W@eNO_27,P7-B\F374Q]-0728^
9=PHcCZ[^P:b<^ARfQcfeA?=B(?>)U.OWY4deK?=(5]f+a7f<8,7_BRb?&:d96G^
)B],#=\[\Z9]F8R#T>&Z.<AaQ:F#<N#YC-<Od<6(-#+MgcQJS3#<XNM5;Y,>?a^4
LgfJ--#SE7Y9G090dXBK;N8^@;f^O4<Pf:0D49E@HR=1W>]c4PN/g2P]60&9M3L.
C[/Qc^8O&UU>RU=8X&Ha0_@4d]C_5&4=fCBOgcN^(:FA[@VeHDF.@d](73S/\WLf
S,QaZ?&g9T]B4f>A59:Y1G0;NA4K[bU+<(\/P)(8cD3YIFNLV>IJP^1]JSF5XJB3
CY7;AF&AC-JeI:GX9gUM08F__RcDK2f-_TZcYIebGM8^:W1+^-#AS<LNSX.E8\>[
P/&)B<_g>^OOH\,@bKI2Gg#g#\FM7<I5V]cdTM#cU;#\U\_->aBcc2:NL(LE4C94
4\[H\F3F72E<<#T[^??=KY@X/@V(]EN8T+bKACXL3#)XE@A/N.^O<(,W)LYa@HI\
4e+8;S@5?eJLQ6fbNT+VZ@e?I5<+Kg=I0TST6:5bT7bU+M?-aR1>D5JR2R4O??CT
M]DWYBLGM3C+98=45EKS5SY]D@<.;)IV\]eHT)^)B#_VGT6;)TML8Le6EXeMa6.g
cQ,b1&AdP5=[>T.8#M0Jgb;G0/DfH-B+QDLV)GT9U372-V_=E[YP7>RR8]#U.OK8
H]DD0FL[O5V<>@AHd=LEW1EK<:]5G4\+QeN<a4UFORd[.37+^4Rc5[M,TY9.;Lf2
1?(OK575Dc0P.ZT_ZbL>a\:T>W]>U],STJ1-(MV=LGGJ2L?BYJ=-&:,<g.@e-#@F
ZLXJ]43K-U<8UAd#XISJgYP:P4aefgNGfV;J_=bW/[b6[cJe;W6(07OYSBebS>8Z
&/2c[1e+f/+VGCIW5?H1+EJNPgWC?9426<Q8]=<E#K]:8099Z#TgbF(CFfSS38-U
2X4Wf;^+.4DH34DSYC#gP?&\:C,8.S,BSP0PGK.d<O)CMRCG(ZAZ.8X7/+O#<I[O
?,S,_U@eZ\0HM582E54Zc]LBD^7:OQ[IScGOET3^N\/OV(0OB(1,9&,[LDa-X?gA
26Sc/M)VZNbBM=;R<#:17e:g<^-QI7R:4>6<URHTE;H+TAZ:1F6>871a+g.c2ND/
#/OYL8(2g@/KQX,)WU/M.(eTYFB?=2<E3,847^@5R?3H4gKFS)8<dg39]1MW;=<9
G(Lc8g<^#7@bX\?>]#=3g#F,V[0_.;G:MFD#O75NaX2eYU^CI),[#TVT._ZJ99O;
d0NO:TC2ZOY#-<?VJ<]Q^fU;:6=LZAf<KHD4F[^+:UA4H_XO]:12OY1#\<@.R)P?
#^EVgMf,Z?XG7JXAQ3XTQZSEY,]):3(#?X@GL_<8P0G1BEL+J-_D+7[[YF=/aPQV
b.0D:[9gCSCWA:K>LS,645,QG;^VPeT_T9HNf-fI+ecBF,5U18=:]ge06[4[9?Td
P1M07H8M_HV6V[Hb/SX7+XH_A.E1Ka&2BPDfM:=39]LBdY\)g:<gCY/MQG>ZX8Df
1WZU8EeU?N8_M#UOUE-.QC[(d/MRF^M79;@_c0I3F#=2YgE/_:90.M>ZT[Bf<KWe
6g\8KK]&NYg#N>KS9#WaI;EMc@<RH0R_-<@GU2PBgY&fDQM4GPWR^3NDEYT]>IaL
g9b]&Rd98f)7-0ZM/;:5+772Y?++ZY7+7]B&XE&TENZ--HB5Z]Y3B_aW^IO\c/U;
W[6^6#A96ePJ-L@9B-=S_CX9O>,]:_.4)A8,+d09RVXeSL0YR5=1W4)&F6(59[ff
V<..-3Af:W2,\D2I7X3H\P#FO;VL3^+fP,2g=+^,8>PG/05O+#9bPA>2B.=DE-KT
OV?JH7gfQ^X6AWQ^Z<bD15_?9^W22F8#B(S]e]ea6(APSUBIT3S\Ha=G1=2G)X;9
0.D0U\,UVX1ecX]f^OX/KRU4OC45JMG+bb7C=5ML8KIBLC]D^]-=JC..<(^T[>=H
cJRFKO<)2XUAXRF?J#<KPGLA>Ff.8>Z(8:HY=8^,<[X+RHaXJ-Jce/eUZZ/7[B8Z
7->9+4PH0T_dL-C\]_fQc5Z646&L.=,N=a-M;:&;I_L[HV5KJ,5KP4ANA3;(BX^4
d_AO-gZS\I8.P68H+(eIF&1,=NK_DI-EXOAA0>:,DKQ\4ZK1F??,0,?aZ_JZeU>_
-_3^3R9F/A\YT//#U(HeKNRA&e0Q.W3#T_-;b9F]dAg4\OT8_OfM^V13bJD9M#gG
/D8Q=MY5_Xg/U87084]8S>UdS/MLG,M5?2I@Vb]?D;Ze5d@L.3NaEK9S;fT@b6>M
B+ML^f8;4f-CS(g/0TWdOM3gY\M(2GMf:AC1U_CO>FH2>]8D9B[,=Z2EGRLV7+#I
:X&&Ab\N(DDG>ATR#,;PPUfKB^UMa;\2SHQ^MJaFU6MM[A+f[\aUR3Ddd.6#F-.K
/\-9#<R?d>bJ26G-PU=bK<X.J__P)b?SPAa[9<D6WY3&:WcI<H15VG]/R\&&Y-E#
T+L4&LVM]^J6M&06CARY<EP4a;<[K&.:2g9:&_;cSeZd-T^C6C&=4U[b2X7-W=S\
KQb&b0SVK2:-@faJ>>e+:\.A2SDCK]-9U?Kf:Q2b]]UOET\^C/28,e,ALP=O,0/>
I?#NU5;/5;\R5a;YW:eVdAIfHT^c#NH>g_YQCGcN)\2Hb0YTU+LKb]T.f/^cT7Z3
-NMF351MJ(GTX?SYd>6?eT^F(PNI^c036+UBgD=3@=IH-SU8)DB]B2/-L6c_P]KT
HgeLD#),8C>1e0.f^I953:+N1a\0QD)/V#M3a2Y2;W1RS+T?aDHQ(4R;W@F8H_4a
A<.R)Z0Y;RW>/G_I&^,Y+A7SfLFfELE7H6.<VT=X@d]Z5PYA;>,5WaWTE0K9ZJ+4
&fY]g_3L=@SPW2?)#26f-:6AdP=/f9Eg6L[-^DaKS^3U578I?P^-@e#3d=BP_:fH
_B>/BJ?aOS;OcCD+4;+a<a8Wd6Y<)RW&]-YL(49aYf3[CSMUa\DdH/[gIKMIS7gK
Ua#:aYXgPUHXgg<Of8<VZ.U5A0O[/MU]V]>51E7e(F>QI_12)59)d#N@H&ST&;G5
^IEBUF.ed_X>\)1>O1MATaGYP7:e,76Xf&;5aN\DI]_DP:\e-b1+eB6K/DR6f)N9
^:Wd,8Vc/-=&W_#JC<89GSa,V+]90TD_>KG#M2a1cX[U+dgPC[RF>:)gLQK+S8:V
&2/]\Y0a3]gV]WaZT]\/4@cK=-Ec?gT_a/LVJL&X@AHTT>02=B+[V-10<&I_AJ6-
6ZQ]L,\DLb?&C==c8Y>PU+)?C&XIOc&KPdR.NB<Z;[@,MMEIOGf@L>BRX.;VbgGT
+=Ved<N,U[K-RN1<SO9Y#3/@P.=He1&+.HY)>GODKQRc8=PY/=6O5>P]<H]ATU]#
T&@cFa/,(O0Z(KKEPMgC?EJ/A1AR;:N?cHRe0YU-@11(4C<ULfcIE,L;b<]HF/:3
6#E=&MP[cX?4g>-HCWQG#\3.e0b-dZ#HE,7ObeBY,MQ^RL&)Q-1S.ITG55DWe5/D
E@BB:GU[WbPPfA=T&3@A)10cf46cMZ&(A?LI,\66#O]c53Te.^ObgFB9,Kc=M/;?
&a18=Kb.])]Y3?Q/]==&/AZSL>^C@.S[(LZZE)J^0+^Oc&L95ST7YgC6JJ4^GI#K
3DOEaM8E@.PGF&J3VI,&c8=.[EBK,^?:?EDD(>Bb:Kf0fc#a>+=3>?be#XPZ.Nb8
<_I.VZ]VFGFPAaF-51X9@^J?+.Y(c=<>gJQHcLO;fJ\CTe:gJ\CQY0T?aI8;;;=Z
15.>^b?8QcEQV(FcXLaG@]<XcPfBc6LWb.1NL14b;^U?#5+#GYEgUcWa6.#,L54V
(0+IB63O<-\b=B-HNB;FR]]e08;1M7&g9?.eQK.(c,NUAMI_GJ]IFY:XK6+C@<0Q
69a3F.C@D>e)-Sfc:9\J/P/10>AIV=[Y7NcQA/^X&^FBO#&^5HC2AY(?[G&[;\I=
1RbW]C=5L5H,Ee+C.c65]_0JV:\OGWF<@/#^GMffJ)3BHG5Z@1^FTF^]+O::5:a&
1E2JE-C@-L0gBR_#]g.2?_PUPZeAP>HMA4@2.BJ=\aE\UD8[4V])VM8L6be:5_]c
AgFY[TB,:O&IFK>E]-d9EF^H[7f?/CT[0RR1HR>C;;E@LKg)FBHDgIC97N0^]-UD
\3&\/\I@J(W8:fE#ZMR0Q=d]M0#EALeP\NCD3g#+G]HW/PJ0\fT7Va\^6KDBC29.
X&\>3^+IcNB?RV;b4O68Ccc6UXD(3P/dbQXPR,=FF(</7<(cBY05FG0c)1GfT.[c
VZ4&c753/\\#/=5/0YPQ:CQ4/F)<.E/?M;GZGX0V_d8fXfc:2PK_=OB.XUG<3WR&
-\He5-F3Wd\][^6[=?D4UPS\JJSe#c)UOI<a)3?^B=J6S\E=9^.1E1#-HYW18ZK/
E\eU72>1^[+f#La#,XRB180FBV/e?KV0d0CAZGa](Ge/I,5AE>RBg;0V]TZg38NA
=>/9A+,e7L4D]47GD7:e0^C4-9H4F?,&:=fU8>PGb1d(_g3ZTbeI_EBT<K=G_A?3
7eb24)b79PJ8f6N#DeaLR)Y8;WPZK3_A-M9PX^3L1W8B(2#H<:3.5R,TB3^C_c?O
OT3)LRWW3-.HB,\OBW^c8AfG55(E+?^,J4?bQ+RM5,QTJ5P<9,/2eZ\d[Q,Xfff;
L3>_9>BZVa<LfT8H^JX+/e<YSO(-W^e1e[_fW90;dMF[g\b=L/OB^+7Xe^X)-KG9
:4HD8+/>Y^1^eLdGA_abf]RX7UE=+IIL&X]cgS@H[9X)ECS)O^/9GQGA<ce?J([8
I:EQSXZ3c#c@(gPQH.Q=@]I3^Q>A]>O?DFg>CA]&e\8,Rg5[;HW&ga+LgB+GRMU&
X2KR^f:f@6<JbN^..Z]YP/09Q)9T/W\??.QT,:-WE28a?Q+4@^T/#4T5^cdMEUI6
0DD66P.=,d_J.$
`endprotected


endclass: svt_event_pool

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
DF(P.g0DGU-<;)LY4-+/M)D3S.--B3T,W-@aE6?:6KN-8T/V1CYB3(&K:,.OB2/+
7dB]DG:>:O<=7aCT7WO\LYI=H=0>-JDU8>ZSS<c.:f]\fC=L+6A]cfe0USE+H,ZJ
YK.K4ON#3HGgDee@B33V4Y3gU,X,0S9g8.WBORgO3U5_>FQI<_C][?\0LAU?TD-8
@STLdMR;OUfR/?Y<g0U@IaQMBS2A2T]=G]I8;R/XYN?PY(+(Q3N;fD+Y8f/VW2WK
3DGHRHd=CEYZG_JfKS-4NS2.+fX?]#E4?2ZJC^e4eN?ZKQ4V27I@><eR9U)\O9_N
Q@5Db(LHQ9<8.MA:_:YVSUEb:MG+(?bBX@<9[8=N;ZT4dH5M1d4C3X+0S3)1UAT4
S;\\1NUY:&46:(dGXMX(]=]&U0HZZDfS)fa9gKFMIW;YJ2222L/CVgKQPC9_ZCQG
X<.1336+2][eaV)OJZQ?QH),-IO(K&LPc9N4D)7-)Ocd]b0;0a),)VdCHY3Z0X]X
+Nf@>&6K3F6N/R7Q\PdX;NKUbCbaR_9feJg6)Se<GHKN=&NMQf:,3,&a>4fS5;N&
(I<@1NI)JFO:F<CBN891d-#eWA943g3>:b7R#&f0YH:0[=B@FbbS6[X.T=bR;B6Y
P3SI9ZZ+_=K=J9/EZ7\SX#;:,;^)=[A@8GH69(T[gB<P0cE/+ZUMGaa3@9AVSLc4
BP:\c&IW@W@(;@g\BAO]:^CX)T[2J\+d\Ed;bM_Y1_)T(<JaZ>27GY;QGV#,G>PN
PdXAeT\CYEbCPIgA)H1>WDQ[Q^7R=_A:Z\2a7+,A1H(T:.D=^<0,A93bVMJGY.2F
.+f44M#6=BU^R_.:c;@2+/aIX9]3U?M]5YU(XIL]W4I3K3T4GZXA01Y#7DIFQ(J4
6TX+fAH2QUe##g^D]992fKM=9_D5V]^=g:;EQ@89/a>OQ&#c7ZaGN(T3B0;E0QIX
5YWW^C:R?<E[H-U76HNe,8bPa^TYZ]E@E#=QcCR[J.c^3AN=1784aS2EXGCb:bO#
Y(0Kf;g\Q>>7U]1#e0LMJ?Z>A\5]&@MDH5^2d?/D4E9Z?L^F73eYE8CUL#Q3[KfP
3>aA+dcdDZ\YO\b<2]P44GYZ1?g5-G@_GG>O&\Fa^agL_GZ2\_@OK>DV;b5-#-RC
DSgS:JX&M0eVR:Tc>93_c]9+B#RG(0>/5,#YbJ.M4OGCQSd5=(BO6S-HDN/>3HQO
1K>bK(#&\2>AZ0_L3bMHEF_A-2L->#]dc/.f/HaWa>[2P];9C))(?;.@V:OM<F>M
82Ob/S\e_Gf_AMU8A;,EK7R/I4N+OOVbV_8WJ^HVXYdf63@Ae3^fI.HQP)>];U,<
R@83dKg(#Dd\VD-Y)d<\M52Y[)2RF#f9c=c;Y^1UaQCgTARGY?7(=CdB6c_MQ>U#
)c)DCR.e<8QcfS/2075&MQ@;P8c5BC1JP<gVL#=I(:I#DVReeCbb@AC]C[&3)^XO
N:C8SRM:+KZM.7Y]GDVbF\,:_e20.IB-9UULH3Xc>M1OB3U5>,J\DEXgQK[d0OCI
Z:FKb-ACWRdL67Z0KS7O)dXGF.0cPHaE(7Cg)4b;N=19.LG[4d@0>bX\YE+U0aLO
Jb8(:6>16eJ=9TU=2gPE,W\Q8NeB3gHgXb2\2J,\06\,Q34(<NC#eE8LggHdB[<a
T8@4Pd]B#L2eaD.fB/:TL4ba6;)MK,Z<.TV3,a_\8Z2J+MFgbJJ,QLIO\eFWE#^+
>bBQOO:Y<6WGf>d0@S?&W?6V;##W5a_eSaQ^#PbT1S@7URXJY=N_9B/J/aY^G<_Z
]1:+f^T/b2;<C],FT;0+Vc_eV5PQ:2F/:NKBYF:Lb)\/KG5KagR,9]0Y<#d7,XDI
cR67;QZ6[E75[RLgFC9Y/9U7UURT&PN&VM:40F86LaBd\L_H.JJb_7cL20Vf?ZZE
)WT#(+E(KF>:7K#MMb8/W<ZYCU,45):=&)^O1/-_0N;0W-ABA.d#Qgb8OQTSYb0G
S5P_CYNRfZHQJ>]0D;G]TE#RCfbOO9(3DQ3/W453S5^)&fgI2I=00\/[S&+GKN<+
Tf8MJ=Hg5S1/O8?KB+63LRZ>faS<)/PE44RYdVe1VK^?@R>e.OP/)^g+4KKgK2]W
BfZUWV6P-^L3@A5+QcS>SMOIO?93[[5c9,;4RR,]//_e^5ZP+3+.3^Z52G1Q^-EU
XdYE4N&@&6bQZ]G+<1RLR#ELNUX6UY-MM^\@f+WM_NXb&&2/NfZFIIM=F[]7,MWf
C8RWDYN[2#W(R(PM3.]\2=N7OE:HFB91.#ca#-a#bdGgWNM2=0?3..XE8[JA4[C0
S(ZT[;S6Y1#5IYR^^+=D/&:fWH<&:Gc/5N.I3>53?62\Rd8:O(V-d0.++dITcUE.
9?g.aMQWMH\T2L^:&M^6N8)?]T898-U0&g;\?6OM^9@R&T=KMJdA\-C9WA&DH+3c
UX@/fc2&Zb>MZW6R:=K3J=,WNN-+Uf68APGAM_QV-P9@\H/(;P:R#^YfHSeBfaS?
S_-:(RM-gM)T/LS?C;BVU#6e\?JY#F?gQMUe1.U/gL&9A(5RDeIIcBN5HM7Xf8TR
(B5-&SWS#(/U8>Ta.NYW+(I9B3AP/D@,>(>ICg@@8cgBN^3@@_c\-bb8V79R(\I+
S6GKAC\RS[EMB^U.PGa/:UICDMfF.R;.Q95UUY)AgW&]E@@)#>P#HE84/8C2TE-P
1+=[_^?EJ\A@(;YC/9/<Ld9Dg1C2IPf;)\C(g&-WX+e#(,a(C)J2adW^(0If\YDI
(MFBEQ=97ISZbL>/MY-XG<7]--J,^N];;0\=+=C7G,INC/QE#UE^2#Vg3[GMcHUR
c=]<<J&1dNHSeMdHB0_11cRWQ\:BC5DAAZdSc[:0XE\INfZD;UCW0FU3:-;+PHS-
7-?12USg?8I]g)[a>]62IT6JQXa<2]WB49EEQ[H=);I4V)@.Pa8=+F3JK4X&BFMF
LZ5II.EF_eJU<8#G8E\34LQRJ#QIgWK]\6PG7\7XZ_;>_<,T>2#_O@H#Y^=U7E0f
]5XH&ML:J=W[[5JS<bGc&U4D-/O(ZbDbE.g]f&E[VEbZ6,\1^,VT]eWCJbED]D&P
>Ue#2daS,N90VMg.?[93\H\d]W]V/H8J4KC-->&RLUJTC[+R6X]PLKK1JG6DfPDH
?c=IQcKg-ee>Yaa&01f]#[g\ggH@DCG7B(U4QaO560Aa?F>WSZDEU+3,+H7b80VF
=-=^d+8K;B4\6B-a:9JbHJc\O.#<FC)77e+4=5^><e-A;P-JI-[3=IQ8UDC=O^]+
:<@7II3RDcT3O\FN-3\U.N)1ME\D_DM+11[1@MSDaI/E(eY=PH?dZS1Ka=HSNPA7
991RMRQF]().7V3+Ld?)Le5a<6WTP-G/8Q3]ID=3LK0+_)f]<dbb.^ZGR(=(T_bN
=_-AMULP/@]U6Vg9KXLdJ34=6]>C&UIT6/b[EJX,4W]PX9dJeJGVDdT(cge#[E+T
[G=ND7gN_=B6<]VS>EbAX2Pe)NcP4IcM.SFI6/\7ZG0;)G=);_;?>3?eNHY9Lg9#
?O\I28E5_<&&)d6_TZ8OX&cHF8BIfX<^6T((T?9B987YcA56<[aN@Qee7)=PS>(d
O.P\a<?dN\8eQ+U]L9CcJIR+6(fVDg]gS2T=V=a2FF=KP?F.+e,EQ7>(7aeOO,-;
BZ&aF(_UW\.;d0@EH^9HdR)HPD)0f:O5IU5RgDO4^I5[:9g75Q(<D/8-R-/]cR[+
8gMB1(Gf7cSOO/XGD>5NKVG(S+:DAI_E@92M+WAH.=H@-dTO(.+)^A#4f?HS+5PU
<:b[KFHO<OZR>9<833BB->^:5g5aGBL43K\a(L8;EJ5b<f9A5.L@EdBf#6bH32+Y
+]>9SQ4&[>9&fCJJ\ZCV2A3B;.9M+c8X6@L1ANa5O7aS=cLTf--65JAf.@(?HDC1
>\):AVec_BV+V[#fFTFM]MT6DU:W0Kd+HV#./XBZT>:cF,g,HeM[_aRA^&1GV:\U
,6DfGX0.UNW^Y11<96D2/84&E;)PHeIP5F?OC5<;E1Q[P<)K5cE-8>PLe/1:5ZeF
G;RHDDVTY)cg_dTK1>>Pc5MCcM]KQOQD+gFKAb]2=-UGgHVSgQ^\=95N0[W-PJcS
D^MLZ?=R\.Q?bR40T?9:0DE6#D94U-.3+O:S[AGFROT/:GLO2cXV>(1?R1ZSO+87
:ML9+_W=YH_&(a]8#c.g#AGe[>XR9_02LWGA:L,<a_LVDEH?DDR&E&@1&#FEH75Z
_(QLRX//TE8J78>:Z0VQTSA,bA<d\ERM&ONVeQbH^,FeE=&a)Gb<SG2O9U\KFf7\
MG(?.UHP2Ce90Rf=/5^I<[?>N[\=bGP>9c^PYZf)/1)g.AMc4\)Xf_FV[#\5:R&C
Y[E-VNef&]J=[:9M\J]_A.IWT7N56:W/.U:^=<ZNK5e<ebU;.XXFf(UP05+^TAf-
]#?_.g/:&QM3]VQ.KJM\-N>\7Rca-STcKW>#;f&@^D[a1)YL>KdOLV[f#W?W8NAG
TZ=S97DP3VWQII]>C8f;3U&7J>C48NNf?/HVI^G_(-[]38:?O,OEffOe/0GA=8C9
)B>(0(Q(].(g^9?B=8X=f2P.P><[.?D\E1^]W(N=L/<.UWfY]T20.[4];:<+B.#>
Fc2\Df^d:.F2IY5N,#_[QMR;gW>@.VJ>Y0<NI8]KAK&8K&cS@:026;da3C<JU)KP
AMF+eOHF0P8d]&HD=DcCHHeL===f4A(1b+D32,=dcd^]GOKVR0fcfRP;I21N?HbB
U4?g-9U?D]0BG^NA^F)@WM>Yb;]Ag/8^A/E6g8OeI+Cc1XdJ4<KZ^aNEM;P_:UNC
(O74+cgVJFMR09CHC\BEMI)DO(V2dZ>OZe&N:<\U2+a2MK@gA4YKR=3-4Eg5.6HK
ec2_W(,_):S\Eddb=)>SACcP@XKK2D0)+?GZ2RC5S:VfBXYO9,g(K&4B<+N,-;AO
Zd7-HGW@8AC??-^<PCZ6>+K4>/WSE\P,J8@ca@bH30VOc+HI:6.@B&?6-#@N34a,
6?d^]ebKKFUN^A1P<8_VCFaYXKDIcT72@.VO,]Ed;-D\:E[9JSOTBELOL.)YK?(L
ACe,];g\3L<\EDEZc/aSbW^I;/:6S.F.A[;,]LeJBGTaVG5R?=C;NGY5/=H^2A->
NGAI.I9)<\G1#\K1LAJCM9Ee1#&]@DP&WI1+f875dKT?1c_8;CZ>eb6>F:;G@QQf
CY<85]0^B@^3D>#.(A?8Od#_Y<4])=_2_dC5M2D[Eg7M;/)I^DLP_--HFGBFUeAW
HFE4Sc(CQ>e2B4ZKb12GCYIAJ^04T,\]M.&Z<g:OK/7HZ5AAP/]<bH:VGc1Ja86.
ZBVa[.;-4F\<LJJ<QP\CEB4)K1T;@TY.D@A>O,2LN.G[EaW6]WRR1c]WSf[M0+2+
10\/E>RV(1.(\A9[>/\J0(@E:SV1YAXQGOQ3?WP)5?-C1B?8IHDSN/ZdE4_SX>6Z
F=gdTGDKLb6)1WeV-fBPT@\(=P\QdP7X-MW]_)(D-?QFQ4J+;[,aZQ\A?8S=#]d^
SGRI[\gSZPVO#(D@/Ed>0V)6A\Y0A@CV#VUU]08DK+dc,N\\2JAZ21VIO]RH2.cI
YZ3L<_+3E31?/H[I#0fK81<4NI=<4@TAb/PbXX=C:/SDV/g.B^98K1A-]#05\^H\
^bZSP:YVH<-O8=9HCc9<+9f]Q]c_Q=7566f&#&,e.+G&DB.Yg#_b@\TDaS0V@(\e
2:F&?X#AN-&cYP)MP,DCSUN7):d5>CN3fKW]K]Q/d^Y7UVHIWLK53c=Q;7QZ1UL_
5G26+\-?5@1F?dA\BS8]]CKL:^+J2Q#(&L)5bC-ABLeR_RBD03F=D)Y)-M)THBO0
HB]B_f?(E^RSRN_=L>_E;c=^0AI^K4&AP]<?EIeA-cGQ9.(>W2)RZ^BgGYQ)>GEK
1g]T_#D7LE4=O57_dM;3Y>H@g05&P#4MR:8<2EWNKYF[EdGQORW\#JZdObSb+L_#
M]0\W\XVQ[f\d<JV;f<8Oa7MGb=QaPP.Y/7,=5YV)g\K4(,3362E\@EHN7LId]W2
J^Y7O\DX38dNc;K2G09#gW<P[NF@+gEK;)[GVdC\-<eR<ReIgeX2_07<=,;IWA]>
25&5:TB3QEQBYUaHE5;],E=17-NPG_8dH@FX2BBC(PZ3Q.a46=/5T.DF_N69]9O-
c5,c,REc>T#G#LH(0#5Y9He,\TQK5e:bdg;2?IQR&QA^<I7J@3_OT54bWTN:,;&G
8&EYR6J)&@>30Z\LgfXX+Z@c;AM?B<.5;[V:6(HaVRA2F&M83b>0YI>>&E?(4Y5#
#=&HDF)C2-_]Vb;ID_FN5cf^QAeOD2=\@UG&1:GXYH8:VL#V6T=D)f</++F_8](O
\F@9N8X9:8(IES/I\VbQ^GgT3I5bQ44V]=JI1]XBPIMF/I@^22AE&A0F8(:N@T?<
][#BFA&&8gV26&bIT9)Oc.N-\UgU[b+_6@MG:.\<#(K)Q[Q>UaDF8Bf=R(>L;PD9
A7WfJ,B,d=>_a^1;02f,:0\K/)61c,E?R/X<E):&90I\T6\&O,/];Y3&]Y((Q0eJ
7(A.L0S/V>d2H7#YC\V:.B\\A-7O#8S3GQJOT)AB(^;#RRK)B],:;OF.KP#NBPM9
2,(WVbN,ae0XH)3f^;gHXJQO;_,Y)A]2>F:Hb>F)BMa436ORf9eH;1+4+:JHOA@(
YK;4:9^5GO_<VVSX,3=]FI?5-+Tbc<92DSOAU^M-LN\Z@,)50@f\=U3[X[H_1aYS
gONF,1631AHIFX/I5Fc#US4H6C(abQb0ZAQ6N+d)\OF;Y(WZ;;P(WgRfM[>K\Md2
W4[Hc93I[H\bfaKZY_CNV#/\?9QH48;(XL#GTY3_)E2[\8@:<V)DMMAYFEY-70UC
1TEIg@GH&JG1E:.Yb8Nf(VMAGGLOQbB@\WJ?[J4<.b;>-YfNN@fUg-YENaPH(B6[
?6aA4[g(1O&[2=LB1),RV+K;>=4WGd4c_<=O_O(Q6K5QgA]6Q\>B-VO#1LgVRTOc
c+T=7XVI<.OTWIObZ?=-[--Ua(HX7AA@TCMg0HEIb[WY1O8=HROfMYbC8EE9)0@[
Q9AZPc#W:D)A5Y^BCMZJ>,2-X?P8T\;PZS3Za;G;V^?W+\2.JMe+F1D9Bc.ERC<2
AYCD#86:4_&]F-bKP(fcVU+\Rf1XC>ZF=\B4C3cZgd>^b4EX/P]G&HW-Q?3_OT9,
#:HeV(3]bO7cb29]c##)L2/9^9EE7I-/YR#OH-d)V0B+X,IP4_HFC>&4NT3_]f60
#6:8)_9-[53f6516OSU4U]?a(J7#;XI\)F6)ID[XL\.P\(:&^HZZWM;V:Jg<EfX>
Y0H-_-H+e^&ZD7bN.1O2JJgae\<ZI5RJCdOWV87<eU-4\bB05I1UBcdC\6J[7WRV
D<.N,f0U8Q?4;X3^=^dEELEP8R+PC#IVf1D5D#d.LT2CS9H6&J55KBND[9L29\8R
[C62I;JBb^3)WP.C,6D;ZDC^Q+-D1^\HE^EC:83]WP)>+=aOZg=D)]Q6^##f<<H[
U-K^f-G=-&M25993f.&>a3=7E&5(6^K+ARCXC@FFF2.=#61LXMZSDJ&=b)6XQU.O
J3E6JADX:+GMZ8Z0M0)6CUT#]J-g5RD1=+<NgU@Aeb,.[)4@S]@:5;A(0USJ1AL)
+/FI(ZZ&aEf@K7c-)M6Zd-]GPU86Z<R0,AG_G&JBIbIJFROEM2[?MJN/b&PJQ,F1
R6&#ecQ9eZ]bf/5Y0@8W2-f/[+\Lg:cAAHEAQZ&/-+A2YR>6X7UY(8bgF^(C;1OV
F;;,b&^7)<65fL(,Z#)Lb#M64T+2^4W-=&&G8O[SKNP.YfZ[_OX9#g9W<eS<VO(B
KF=(A+/9f,[IDHCCY.\+.G,X:?ZWFPVaFO;./2@OG?VT/Q)GJ_/,f/E;?_#BaQGB
_RJ9BZAcTY@\ObVZCaAS8S1a@K>Jec.a[d?W=FM9-Y>H(M29PEe65;A?RU?^Q\^;
,LGX:-&7)bfX@4LN=]5AMY7_b-()OJ)RIHeB([5^^aOc)H_/;62GeYA?J$
`endprotected


`endif // GUARD_SVT_EVENT_POOL_SV
