//=======================================================================
// COPYRIGHT (C) 2015-2016 SYNOPSYS INC.
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

`ifndef GUARD_SVT_DEBUG_OPTS_IMP_PORT_SV
`define GUARD_SVT_DEBUG_OPTS_IMP_PORT_SV

// =============================================================================
// This file defines ports which are used to help intercept and record sequence
// items as they are going through a publicly accessible component port.
// =============================================================================

/**
 * Macro used to create simple imp ports. Used when there is just one imp port of
 * the given type on a component and suffixes are not necessary.
 */
`define SVT_DEBUG_OPTS_IMP_PORT(PTYPE,T,IMP) \
  svt_debug_opts_``PTYPE``_imp_port#(T, IMP, `SVT_XVM(PTYPE``_imp)#(T, IMP))

/**
 * Macro used to create imp ports for exports with suffixes. Used when there are multiple
 * imp ports of the same type on a component and the suffix is used to differentiate them.
 */
`define SVT_DEBUG_OPTS_IMP_PORT_SFX(PTYPE,SFX,T,IMP) \
  svt_debug_opts_``PTYPE``_imp_port#(T, IMP, `SVT_XVM(PTYPE``_imp``SFX)#(T, IMP))

/**
 * Macro used to define the common fields in the imp port intercept objects.
 */
`define SVT_DEBUG_OPTS_IMP_PORT_INTERCEPT_DECL(PTYPE,IMP,ETYPE) \
  /** Object used to intercept and log sequence items going through the report when enabled. */ \
  local svt_debug_opts_intercept_``PTYPE#(T,IMP,ETYPE) m_intercept;

`protected
cL&8X70+KX1Z#5]36^FO1))1F1,TdI^E;D^0QR.LA=C==\K#-^Z+0)^RN6S/N\S0
2]V<aQ2S:Hb7aJE8T9@U?5&dMD;QG\NR(#ZUX-PH0C?64V)8d5A..O0cR[.W=[MX
OfEP37a9BLW_-V=R;K1f&#U>;A<eF,dZX?-fZGWFc9gEa_d6(N2Xa=J(D2[_F@Td
V@LKYd58].d-a,-]eL+L?BDf0WU.De:,DN.^.EH7:bT<N\.1[P_H;c]g.R-XgQC;
)6TY0>I\U\b1LS]04Z#IdJK7]JE>cg5CfBQO(NJ>3P^e5?EOF7#;;f@bC2@9Ub0R
fAT9/2@R2HSA^C1/]N5AR47c7gVEK^@99$
`endprotected


class svt_debug_opts_blocking_put_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(blocking_put_port)#(T);
`protected
1fBXdNS4;6c_Q4CegWX,#Fbad\2J_O6?M9C+&A7VNHJc8)\49P:d0)),WJX\DN6V
I,06XV;.__7[-V[#d&6ZAd348R\Q?1KQaKOA,9<?HD5N46,+fI?^V_W,>:65T/BP
B1:1]AC^Q+:U;],HgM(^/L)NbZc?O=V:[2)a4GJ>;@_B/LQP4?a>&X?I+R:7/+8Y
R<E1;[Eg)C/]c(@[S;TE_@)N3$
`endprotected

endclass

/** This class extends the nonblocking_put port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_nonblocking_put_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(nonblocking_put_port)#(T);
`protected
g7_eaIGIH0;H>B;UN/Z_gQFQ;I5Fa1ZHG4;8Pg#G^UAgQgKR.&>,0).?#\51OS^N
=Q^DW^6eBAD=g@(_]12BE[>9D=O.V_1K,;2<JTOZ20OGID0&Y36@C7g?d(2e=NZ/
WKIcV?EJDFOU?Y6^+1;47Kd01Z77/bbUZa]Ld1]:=dC=)AYHGN9#M[a7UJY#45_g
5JNdNA];abb36WRHKV?2Wbd06$
`endprotected

endclass

/** This class extends the put port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_put_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(put_port)#(T);
`protected
>G<Ya+YFM2&^PKQWZ)>-VIaCSSJ/EVP65-DB)507DZE0.,1.\^@S+).<-U/RUZPL
Y-aZ_^<C..6-C>3(OF18e7PWFK(Z(A@C338bIb?NC[<^SY9<R.Z^(ADB5FNf0Xbd
X;-IUZeROEB\He->/A7E0,IPWOUO]8<eV<-N9HDfZ/KAUfM:/7KPE-C&9M)aabe=
W?Q_S:(Hg3^\*$
`endprotected

endclass

/** This class extends the blocking_get port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_blocking_get_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(blocking_get_port)#(T);
`protected
e6)DD5\Y-[.2+c99K1+U5VNdGWVFMCTLbV@RFA2:4de+;e/2)RRN,).bD27dN_eJ
MZ(R>2(QDY[5N3X=JRCKWQY\[/C;_-1(5.77/V03/aQ^G,@PG2YdJ3[ZU//O>>D-
KH>@cab/+\b<KACN?A7AYUY^f&#=Kf_0[>A15/>1=T]Pc]WWE>\>5SOZ<_S<8&a7
C3<EFTPGcJeJ#)32<#Nb9HY^3$
`endprotected

endclass

/** This class extends the nonblocking_get port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_nonblocking_get_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(nonblocking_get_port)#(T);
`protected
[LM-]BZG&[X<5G5F+Y2[d=2F\abQ5KZVBEceL@ZbPaDV8A:DNC1V-)0TO^a]WQ5(
^6bbc2Rf901gR6[;9PA)?W2OLAfKA<N/=3#;RTc/5RgW<72?L4O.7XZR,a\g(R7+
/U14:f+3E@/#)a.d/BTRS>;S-B&UJ^3WbD,H.8V_[&d+&D?Z4+WDCY)1HK5#59-T
R?O7&C_<:4;CON]=.aUY3>;S6$
`endprotected

endclass

/** This class extends the get port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_get_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(get_port)#(T);
`protected
\f4#g9WR3[5N/BF@a:?e\^H[3JMDf(eLHT[EOIDQ?I#IH?#Te95N()/e/-A;L)8\
=::XM8>a8f\2b-W3?_?f\>51Od@:\(0).WC0@&:6LPG66A>U0d@/VH[=JQ\YdV+:
74#7DU1Q\g\^e,.YadN@4/95A)g:J;Z,G7@M:I1(0=F&U\Pe>aF1Ag6GR+V[PRT6
;5_bFdX9H7F^*$
`endprotected

endclass

/** This class extends the blocking_peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_blocking_peek_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(blocking_peek_port)#(T);
`protected
0UQ1Je_/D\b0=9dL.cE->S_=&-d&DKN1UGRID[SX-N(H:3_:f_4c0)ZPVgU,E,?c
E/cfD1=:bb4W\-b=MKF^:d(-J<^gVEDO()T)g0@P.eMAP&<)G2F2FAe_b^X_gW6^
9RfFNf6WJ9V]T+cVEDH5\Z\VQN3>;:U(6DNU.;0:7Q:7,VZS1;<(7CJgZg(M++6&
#+\TQN0T_3.T7aN<P8+7<^\V4$
`endprotected

endclass

/** This class extends the nonblocking_peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_nonblocking_peek_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(nonblocking_peek_port)#(T);
`protected
Ob+I9g51,Wd/e&7Z\Y]949[g^H/HQ4J;6[HgP_L?5Z8ADS75F9,X5)aBGbR7O3c&
e@&\ANNX:XT/K19?<e&.>(K.R1dc>B?Z]XEKWA(;8)^,W&H(Q8<KT&^e3D4>/FAP
2?,5KfPGHc=cB(4Z(;AEPXARBSXgb=\R,D-de&/QUC(S2a(2IZ>;O7W,=g_R?O&(
+>K:2SgBE>QK,6LJ.9O>0SAR7$
`endprotected

endclass

/** This class extends the peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_peek_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(peek_port)#(T);
`protected
C^A68\UCdFT4Fb8WP9)TV)O)NWR#NbZZT<TEFK^?MLb1Q4XTTT:)5)E&U8U&LcWQ
09I,3.Ue^2DCA.1e#Sd&T:N=FEFG1aW#<S,T;d)YRZ_GeIfQMgG#e,Mcb/&GFabI
KNES0OR-LTBR)abHcFX,HHaQX1EID#)BP[+YR4\RN5B[aVZb-fE;Ya,E+UG&(X6c
7_cEOJ=NPY:R+$
`endprotected

endclass

/** This class extends the blocking_get_peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_blocking_get_peek_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(blocking_get_peek_port)#(T);
`protected
1gS/cd^=S.KXe)7ODAZNC3G4NL]WL=>4g>MaS@HOf)a,0#D=:O1]2)^@RV73f;BQ
g\.+1;.G?B?B_5+C1?@A\+@J22d_?FfJB(HYa8\1H/3S2ZBD3D4Z9Lc_G&L2RT.4
96;V&d0CdC=&&_2I8ReE:4e4^D4;M(PA?,BWMOYdWWB=TKP#)MQ6U0/VTIf&X9#0
W>A8dE(V+))>/aee.7?DJ:e48$
`endprotected

endclass

/** This class extends the nonblocking_get_peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_nonblocking_get_peek_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(nonblocking_get_peek_port)#(T);
`protected
J+?:dWBL7[(Ac;)#Wb)<@(<L6FS@[N[5EfHER0[^2Y8X_VGZ(VdM.)4W1<-X>O-,
[D9_N6K0ZNBWD?#f/DY=)&-[dgD[=5WQDH37I7-SWCe]SRQ>2TLCUa<V]g,0>H>\
Ce_+;[E(H0>=BUV5B4&#6/ZdJVI#(3;OSFgA6M&W;_S^,TV^KH,W-0W@6A--#4C?
aFK.K=><^DBd&?JgFgGS\N2]0_EA.eXE;$
`endprotected

endclass

/** This class extends the get_peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_get_peek_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(get_peek_port)#(T);
`protected
bf+f@(RMR8d+f45]4&f0N^5Nbc7GQRQRY@eWB1L\[4[K+H<Ea:E4+)2XI=4V.D)c
Jaf>+P@G,05>RVUgTeVWfeRK\dLffA<]Lc73cc@HH.\W-)b3bQSgS<VHGT_4[aR\
O>A;[J=)X_1-(;g+_R+4;DO&HFY;)E45E5G)ZM2(KR?WU[Ug?7>#c518VU_)EO0K
]LGfSV0O#7+-/$
`endprotected

endclass

/** This class extends the analysis port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_analysis_imp_port#(type T=int, type IMP=int, type ETYPE=int) extends `SVT_XVM(analysis_port)#(T);
`protected
CY)/)-c,BBDX1b/<dU;&S+78^HT7.+3ADZGLeHbM0DQ13N\fg-L8+)J4ZE8H:G;V
#@8f?D:D]:LS<^UY<a84RE>7cM\C;+.U=HI+X-AAM\)a<+&9cP>W)1P-X0+I6^Q(
X1[R]N6V:6VQ^_RfcCIeePSY3gGG]E.;JRJGUSW6S=Y13TYFg^&>AQTeX5FDI,<;
MJa).JZd^7g=/=-;^^>c;+&RL/[.b6/)L98:,74b2](W?TEGY.I,C/0R&9XDSE78
AKF/^1],X,L]ab><MY2BT8&OI11\YNAR9#KTD;1X]P),)1WD(R0PH5346\H1G;.,
CA^GS5>05\_Q?c;a@Ib:(6H3[Y0VO9+aA5(XPN78]V&,F$
`endprotected

endclass

`endif // GUARD_SVT_DEBUG_OPTS_IMP_PORT_SV
