//=======================================================================
// COPYRIGHT (C) 2015 SYNOPSYS INC.
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

`ifndef GUARD_SVT_DEBUG_OPTS_PORT_SV
`define GUARD_SVT_DEBUG_OPTS_PORT_SV

`protected
^W?W_/OBM)?f7I>D7\gU?H.GUONbP2=CFeMY4gSbA<(;PUTf.S2[/)A]IS4]NATc
=b.&86)/d+]+>fIV/a;ON-@LV4dOMO(KaQ):E6@3Q58HZ&O7YL382cE:2H-f?aa8
<B5,6U_E=2<.9>1Mb1Q)^VMV@MS)@#JE@3&@JE^(.0/=?(cVN/N5Pd60>5CMX[,0
\JNU^P3^P5/]YL41L2+G?83^=D9UMFUDJVLJ+1H[N/02?B3_QcD.]C=/,LRE<g0\
EZ.TSOb_geTbOM)Yf0W&546VA/608LGad5]XZD9.7aJR+MX<FW-0,E]JSSK2,]/)
]&/JHTL841O7Q@;P[31#[@f]+3H?:a.a.cD74M<A^.O^SUgc]&-A[BW1O@JYg\8S
NW&W_Jg<bAg,PJf#1YR(QKYA?b[?C??Q)H>Nb7Na:>8X;eJ660?AE5TT4_U+38f^
bag[f0&8T^W7M-ODV:BBM\N-^==1V0/LDg@OeY6WbNZ72KfU0DJ&20N&W]-Y@T<Z
+&@,D[8f-Bb(8.@d@NbRN-IM+d:M,Q9Za2N[:(6[BS>XP#.VK-:VK,bKGRL57F?a
g+-NXEDg:64I(EQR;W)BcZU^0bVN]d4(+RUC5)#S&^f8?b2>DeeeR-5++@CDfC+c
WD;bbKY15,]ZZc8-7D8[1R6C?T\@#^@^60aRGONV_0)8[J;-4@AD:=^NAd]_HcQC
.Pa4;f,D>S_P9^6F[>BO7;(a8cIT?:.gQ[?96cN&AT[McIN+X3<L=EHH/;\(&=L(
GZb:^TI&Y^/fY)9EYA@:LGGP5YC6=DS[O+HZ+Ugf40:P;=0aJE>,Qe[gHL0E96Cg
d=D/)=6<5@?Fe]0H136FXOJVIG@10@O,XO8U)+f(2&2Idef:;eRd[a4SKLN#<K:1
>VR73:J#:HBF2=P\eW==BdNY[(U_,&Q;(?DOJGKT^?&L=#<2fC_X?e)XO<7g@KB<
[c9)ELCMS]A?@PHR\C@U30Rg<8gA)1a/18ND=Z?AAe\:(+YdfJ]]^gZ-X+0aEZKS
2K]8T:ea/UXHCZAc?L&gHY:ALg#:<4YI+Q-]d6FEY(9=]D</6X_L#Ec;J<Z=NSD<
]VL/MUg]Df9MMLZAM><&agdbQ_c@-J/Gc.RS3a^P\:BPR,5L#EIA/^)e4C448D84
/>-a)d6F[E1JK+.\48S@?S<DU(4PMWgfa6]U_>;N4S@@L&X(=8AQWNFM+@,(B3QF
0Y6d]])/]1X=&[dZg)4TI5X6=Z1Tg2bJELG7^-+SO7a]J@/?0#,c_=@U?)He.(/B
N+(f>09&JA^YYbTKQcZQE&W3&30_R:@-O&4B2NLBfX&#8FIIN6d]95(JG-@C6Y-7
=W#VFWE-2D7:\gP^?Q.)L:(/FcX.MaE^<^(SH)14XEfC5@D&Peae>/^2N<eO33(Y
YRTI?LZ-HA?gF\aL>]49GJMH9&eIbgFcFM&,UJ@GH]BCD$
`endprotected


class svt_debug_opts_blocking_put_port#(type T=int) extends `SVT_XVM(blocking_put_port)#(T);
`protected
9D(J#VNf8,3D,e?0c]R^^d\?7^-7B=<OB3g[d(?GCca_K=7bWc^&()0bg]eKgSa?
0Z.dU5P)7R-3(b:]0A.a^[UAYWJ-,WM9CEc7D\IC]E3&F>K]8e_7_;&Oad.Ra_fe
O5SL<)<AFN964U8f9f^_5-f0aVcUT25ZS&H?8VTH,Q8G5G4R/7TM^NM;C[WbT\06
MQ+1/5RM.NFJcR2Pb(-cG,T&Z^<TfECJ;$
`endprotected

endclass

/** This class extends the nonblocking_put port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_nonblocking_put_port#(type T=int) extends `SVT_XVM(nonblocking_put_port)#(T);
`protected
N3@URO3IK).U3T6,#10;aaL:\,_ELPMM\IBJF--C(D6Fb/Y_@@N9()dSH?-[OQf>
8XF+,&_TWLEbc#(.1N,GSgSCECTAAg0>N^f.D16J<#b8CPVcZV#-]:gZ=cb8JZE)
ABD\WT?-27]]TKEU]b=0=?7C:b(b>4Y0JaJa9ad?/T&+IZ>GaWbb49)4#2YR0V)J
\fE&PTBRg89Mcg.MKYcG57HdYX/61;(R>$
`endprotected

endclass

/** This class extends the put port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_put_port#(type T=int) extends `SVT_XVM(put_port)#(T);
`protected
BQLF^E7^FVO3aE98Z#T?>+KWU91(3VCc[@[g-3Ce]IRAC1>eHJNI0)/-.dgX<:&<
40>SHb#2.DIPfVC0dGaV=M=fDZRN4T7F=]V/C@[=,#-Ca)C=F/9a13,b&3L)7/]b
?WeW:QHHG.,1Y>A[^N<36,N(P-JK_TQfgbG0+A\G]fRJ0((L(QG,de1]Mb2dD;a1
_edW40[)<CRHDPR:@JT1F@N(2$
`endprotected

endclass

/** This class extends the blocking_get port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_blocking_get_port#(type T=int) extends `SVT_XVM(blocking_get_port)#(T);
`protected
R7ZQWaBfR@/QTdJ-M#,CE_Z0-I:Y)=e_UA#^>22_fDO3c^@EZ5a()),,:Ed03_[a
g-\D:J;LT<dF,RHcVFRSL(;T+LM];VH:Ee&-\_IJI>\ec^\S7L_>8>R.BS4-Id)\
[IIB3G92N<MS_4Be)e7DK);bNbA>9,01_^a;PJ3,/@R<0XV(WE2)\HI(a4A85MM)
/ZSYGV7JUOT0ff?#-BYUO(T.Ed=U@bHH;$
`endprotected

endclass

/** This class extends the nonblocking_get port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_nonblocking_get_port#(type T=int) extends `SVT_XVM(nonblocking_get_port)#(T);
`protected
eR-aZM,?,4K)gB31J:O<4DGI1N6QM/OU\3,Q_;cC]4V#.C6&)]/F+)PKXPb3=e=Q
bRaB8.)+^;=1R48feB?<S2QR03\,9-ROPUg5@>aBCZ?>;:D9BZ88FF+[\cgG.,IO
c5?N_)-Y5]TTYPI[L<N#\cL><M#106:(6H5P0gQbd4HA[CZg#[>7+D@H)ReO:I,T
C820-W@D/KB-[40E=/30_^.O?QL6JYY\>$
`endprotected

endclass

/** This class extends the get port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_get_port#(type T=int) extends `SVT_XVM(get_port)#(T);
`protected
RQ+XQFQePVdK0CGEF^S>QM&e)dJ2e<)Y2#RRc)Og4RIZADFG)<5\5)>M-g58?<Y:
F_[1R]DI8[XNU^L(a2PT[BdB@<9+b;6<8T_7&e\/34WQ]42<]W-2#YK<3_(=c<^\
CAD1.@cTI3Z2cB8Sf?<IS0W.7PYE[@XfF_b.^VK34DPQ^?ZY941DHT)f(Zd8XDcI
-VQQE;>-/X7,bgXN6cCcSBW.2$
`endprotected

endclass

/** This class extends the blocking_peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_blocking_peek_port#(type T=int) extends `SVT_XVM(blocking_peek_port)#(T);
`protected
GVP=VFT49N-FV]a,1]K0NU-:5P,6DUMMC:LXUI_JdZ.g_U#WH&FZ3)K&=c?M:+-R
TS<WH&,b+aOQ76/H+TJJRQK2&>0^#XYCcf-EB<D)250V0,&VSK(4d]#bET=(6-\d
VA,T#A4dT(g,)RODB^0f]3_^W?UQ)eO1WPcA&U\UTPZ<ZZ7.(Y@Wa>->d45L^N>.
WG=)Y7I3)^AD[UK_)<eUKZ;NSeI.QK4><$
`endprotected

endclass

/** This class extends the nonblocking_peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_nonblocking_peek_port#(type T=int) extends `SVT_XVM(nonblocking_peek_port)#(T);
`protected
I_-M6I<Y7^?^K#2UVAc]VOI?V_b,.)YNG&TeJOX)_8acg[41J3LQ()N]B\gX6RN9
))Cec+cR:@L&WLf67)5UJa2>c8=M1W62(X#U[gcW(4E#,gJQ5-]T[/5-24K?C+PW
?P(/7P?19BIg+D#597.U.#((&OR=#RgUBKA@cJad9>a7-Dc(QcQ5aYS=1T[ea:WL
L?_P+=W#J8GDg<.9D_>=bR_^IWZeBS-/?$
`endprotected

endclass

/** This class extends the peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_peek_port#(type T=int) extends `SVT_XVM(peek_port)#(T);
`protected
NW\=/OF#ALFQ8O/@FO>D+;<+#<LZYgS@&\F>]K/dY[gEXS-0.I8-2)DD[a,ZR>=.
4FBO^eV62cP([OU>3GOAJZ0Q\5,Yf_1F/321C_Z]D^WKSC0aML.a.eI#aTLIH70:
[RQfHO=,2F7:eH8MC7HBTC@2Q8\+RTd:P>U[[V[aZP0a&>+=C>8FO(<G6=&A(\_8
L:0aUXQSFZ#@G=2VGIf6d>@23$
`endprotected

endclass

/** This class extends the blocking_get_peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_blocking_get_peek_port#(type T=int) extends `SVT_XVM(blocking_get_peek_port)#(T);
`protected
LBd-0)JG1/[Zdaga]][(.8Y2<.Sg?D5B]_/E=REYZWfd@gTBUf82))EF)?:8[>I)
P@I6I\130-<-[)\R[,-(X3MG4]S/TWH=B5==1OJ=K:YbE.?J.JOL/Yg8K6cM?-34
9Z&@Vd2Wed2PTc\SGgY\7?=ZAXZ-2X-YbWb,gKJ7a80>.I1&9&7Y3D]04[5:0?-F
>3J3VVVX)?T]>>PF;@X#d&.e;0O+CZ0a@$
`endprotected

endclass

/** This class extends the nonblocking_get_peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_nonblocking_get_peek_port#(type T=int) extends `SVT_XVM(nonblocking_get_peek_port)#(T);
`protected
Md)ZF]+U<bZgb<JCA.:9(IS:8K@\E&]91H4J>WJ+NW)[>(<CK+(K0)T0LTYAAd9+
.a,>>fIW#K:O)^PGJEA37(B^=4d2IMAZ>T0CI)X//0\<9E2SPAR0S2\5<J9/OVQc
R1\;cgJ[D3c#YfCD/]Y2<&UI=fg+2HG6V/W&d>Q^I45e6#Z9-1U4G0=KI7cD0KF]
dgCDd,VR0G:PM+HW\e=d25BD;D,\b\L46=#)0&2[5>ReC$
`endprotected

endclass

/** This class extends the get_peek port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_get_peek_port#(type T=int) extends `SVT_XVM(get_peek_port)#(T);
`protected
U+72X&FXY3@C^[,ee^[f]G5FP2G]YVXI=]C9O6?J@9NE(P>?eU1T0)RM28H?76gL
=P[dc)/C(Hd0#X_BF0,CH+J9/]0b@b8c_A1.@O5+Kd^-@QbfL#@9@H7.g+bI>&b.
G/6eJ@f4\fF/(Y3GSa7dDPZHEaSSdS0HY?(E:]UZS&W@gcG,\?7V<f1aYGK^=f4L
KTXKNQBM8,K9AR.bL43PDBZH7$
`endprotected

endclass

/** This class extends the analysis port, providing support for intercepting and logging sequence items. */
class svt_debug_opts_analysis_port#(type T=int) extends `SVT_XVM(analysis_port)#(T);
`protected
b6VK>(FI#5_5E9aK7\2/-2\UT>TK9_g5-D6UMZDT-?)5Jb0@=Ja;3)^9NbQCL)[7
_HQ?6>)?_CYI\>\BAg7F-dN[V98WC,,2PDMf+2H5.F.)CT+V/a;L4M/E=OZgW.2T
FDQ:EK\PK\I82-O<#T[]Z0]0Rc-BBUOO@K7IW21@SRE,YOaV]3Y1Lc?N<e7a0;JB
RP8##gL\2U3LH34S8=(3\Cd39e>+69,1=gPFK^EgW86IB_V@[)4#OP4/2)U#GBQD
P_YQCK5/9b+,IUW&@Q2bCRDQ^DI6[(GN?MJLMMAXQ[J+;+@eeWcSSN[XcM4=HJ9;
/&=8VgUHGf.&,=RDM4:D><e=31P18d#^/Vc:MA(8+LA/1DPdf2a0E,._C/0U#^S)
,)AT:W\W5\cS2&@)WaR#.Ie=1$
`endprotected

endclass

`endif // GUARD_SVT_DEBUG_OPTS_PORT_SV
