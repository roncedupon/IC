//=======================================================================
// COPYRIGHT (C) 2009-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_COMPOUND_PATTERN_DATA_SV
`define GUARD_SVT_COMPOUND_PATTERN_DATA_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * Data object for storing an set of name/value pairs.
 */
class svt_compound_pattern_data extends svt_pattern_data;

  // ****************************************************************************
  // GeneralTypes
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** The compound set of pattern data. */
  svt_pattern_data compound_contents[$];

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_compound_pattern_data class.
   *
   * @param name The pattern data name.
   *
   * @param value The pattern data value.
   *
   * @param array_ix Index into value when value is an array.
   *
   * @param positive_match Indicates whether match (positive_match == 1) or
   * mismatch (positive_match == 0) is desired.
   * 
   * @param typ Type portion of the new name/value pair.
   * 
   * @param owner Class name where the property is defined
   * 
   * @param display_control Controls whether the property should be displayed
   * in all RELEVANT display situations, or if it should only be displayed
   * in COMPLETE display situations.
   * 
   * @param display_how Controls whether this pattern is displayed, and if so
   * whether it should be displayed via reference or deep display.
   * 
   * @param ownership_how Indicates what type of relationship exists between this
   * object and the containing object, and therefore how the various operations
   * should function relative to this contained object.
   */
  extern function new(string name, bit [1023:0] value, int array_ix = 0, int positive_match = 1, svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF, string owner = "",
                      display_control_enum display_control = REL_DISP, how_enum display_how = REF, how_enum ownership_how = DEEP);

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Method to add a pattern data instance to the compound pattern data instance.
   *
   * @param pd The pattern data instance to be added.
   */
  extern virtual function void add_pattern_data(svt_pattern_data pd);

  // ---------------------------------------------------------------------------
  /**
   * Method to add multiple pattern data instances to the compound pattern data instance.
   *
   * @param pdq Queue of pattern data instances to be added.
   */
  extern virtual function void add_multiple_pattern_data(svt_pattern_data pdq[$]);

  // ---------------------------------------------------------------------------
  /**
   * Method to delate a pattern data instance, or all pattern data instances, from
   * the compound pattern data instance.
   *
   * @param pd The pattern data instance to be deleted. If null, deletes all pattern
   * data instances.
   */
  extern virtual function void delete_pattern_data(svt_pattern_data pd = null);

  // ---------------------------------------------------------------------------
  /**
   * Extensible method for getting the compound contents.
   */
  extern virtual function void get_compound_contents(ref svt_pattern_data compound_contents[$]);

  // ---------------------------------------------------------------------------
  /**
   * Copies this pattern data instance.
   *
   * @param to Optional copy destination.
   *
   * @return The copy.
   */
  extern virtual function svt_pattern_data copy(svt_pattern_data to = null);
  
  // ---------------------------------------------------------------------------
  /**
   * Returns a simple string description of the pattern.
   *
   * @return The simple string description.
   */
  extern virtual function string psdisplay(string prefix = "");
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a real. Only valid if the field is of type REAL.
   *
   * @param array_ix Index into value array.
   *
   * @return The real value.
   */
  extern virtual function real get_real_array_val(int array_ix);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a realtime. Only valid if the field is of type REALTIME.
   *
   * @param array_ix Index into value array.
   *
   * @return The realtime value.
   */
  extern virtual function realtime get_realtime_array_val(int array_ix);

  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a string. Only valid if the field is of type STRING.
   *
   * @param array_ix Index into value array.
   *
   * @return The string value.
   */
  extern virtual function string get_string_array_val(int array_ix);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a bit vector. Valid for fields which are not of
   * type OBJECT or GRAPHIC.
   *
   * @param array_ix Index into value array.
   *
   * @return The bit vector value.
   */
  extern virtual function bit [1023:0] get_any_array_val(int array_ix);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a real field value. Only valid if the field is of type REAL.
   *
   * @param array_ix Index into value array.
   * @param value The real value.
   */
  extern virtual function void set_real_array_val(int array_ix, real value);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a realtime field value. Only valid if the field is of type REALTIME.
   *
   * @param array_ix Index into value array.
   * @param value The realtime value.
   */
  extern virtual function void set_realtime_array_val(int array_ix, realtime value);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a string field value. Only valid if the field is of type STRING.
   *
   * @param array_ix Index into value array.
   * @param value The string value.
   */
  extern virtual function void set_string_array_val(int array_ix, string value);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a field value using a bit vector. Only valid if the fields which are not of
   * type OBJECT or GRAPHIC.
   *
   * @param array_ix Index into value array.
   * @param value The bit vector value.
   */
  extern virtual function void set_any_array_val(int array_ix, bit [1023:0] value);
  
  // ---------------------------------------------------------------------------
endclass
/** @endcond */

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
T_Ob5,\DEHAVYeO,=9gD20<TMX[>fG60X0fLfKNH2,&HGGCKWIe3-(@H;KPFKfXZ
H)C(Y5/TDV3\UH@eE@Db_c;^XLGY&&g,5gB/=?\HT?=NV(Bb2bZC>-GV(-ZdSX,7
5/f1(daKCPRKG>SZOBY5Rb4VJ_YT[)OdM>5c)82,?QE[Q]b\V.[^TOf3>1UeL6]1
cZM(e^[^#aeVO?T?GW1g<)]#b7BOa4+1#:.I2V[S/J/gU+Q;0^F]_Z5-2cVcL4g-
g09D_XO<I]17a;<).4MQVSEb<ZRgMS6CSVAGO8(+W31EG]2MDKTU^6^U.T/\2Y?d
@+g,Y4K>D#^KX[_c7[PXH>]<1M+?YDFLXOUGV)=PNU:L0N)agDTQLV#WSAMH?Sc4
a1B,CY/QA#aIDB:^CfW5;Q;<RaJRa6[aOH;-)f=9V9#R?I2T?:ZDaAA&^]EcQ<Ef
fZa7G]6MTUP=a8eCBf3-J]c-+J>1cCAIBIe[(DVE9-(+FJ#F+d>:NBaNge/;If^O
18@UZg+/:g,_OMd4-M[ERR2,XX3IAWE7WSA5b3J9K6dG/]W<UTHJH]DW5DC(DI3+
MJR)G?SSgA1I)ZK7P0]\7e]H#D1Fa(94UD_/E1cJ)<U^QS3B1B?:I_/AX_,]UKNS
T6^(0;OJQ,U9W3?4]72W@,Q+bQ8^.^?<EPR2gW&CS11D\5fXHbJ-CCBV[0+?)ZWI
9dN&3;,RR&?>Tc_9O\[[I;6T8=[#aH;a/MO6:?83X\=+(X9V2bV:8(AQ8Q@0c_,\
5:e3Z0&4AJ<&WGA75;4&Z/6\<9cD8M)\HcQf<)Y;;=\<(C@#CS5<c:17E15,DGDZ
8b^_5XIU1A5#HEfD#5VBKYED\-a8\F\VA#(F=;H7XJ1e8E5fR>EaULF;VGH/[HG<
HQJ:7UWcXA4+WP5\K9R&B2@Ve-6P(;2UE_NU31K3L:^Yb<^e?(80=SP4^I.S@DHR
?_70&(8P_IW?#AUF7BYNU:e.A)3T;c@(^e><Q[NFD&KLR;RVK8C&&;:5@9;>XNZX
LAJM=V::e&7Y8)2F]@gB4JKKJ^>+5P9B+D.91LVHT/@CbfGD.b6Q2UX.3Mfb9QRc
[C2N#[K>T.+F+(f-\L,HHB1U)7fVC^aNG(,DL81YfQf,fVO_O^\fZb719Y=8H^=,
T.70a<\U=TA5UZDc0T??B<^K^RL_B-^8\gED#+0f,3LH/]B>CML#eFLD\+MOOcJ\
NW2>fZ2g?=7+QN;9@f#A./\2Z2.Nc,JAd[PL.PK/AdcG19#6IeaI,MRANg)RD)U&
YL0cAe?Z6(Y<QdFU:dZ^QH_3Icb0WWXP_OTQG@9R9XdX>5>_:S[]IK@NT0I>4Hf7
,3@eFOU9UP56QIO=.:D55+F8;0^98ef(VH=+EHgTDg=F,XB+1=:SMQ3GfUONe:4<
ZSWI2G(1E(W:<=#7\U\?.<QX@]8d+6K3X&K;U7d-b63)0FA:Y.@7G>c&P6@O6OSf
^7dg?1Jgfe>=<(E9eL^SY)@31BZGT/T:)?99gS20#b\^BD.&7WR)Y9a?aQ3/EA&&
L^GO#;Xa#TdKJ2@,d]S(EI2^,6H;J2FVb;;#2Y>0E/N5(g)NWcY2DZXP]+R>ge_K
9]1<A[?:SSMMBZ=CDI]eI.e3]/D@1N#&4+I@@,Q^::<RG,4\.@S@#<ZWV9@,J][A
7.Sb>T/4Eb)GdQ.@:8@RNaZGI?cI0@#N<ZLUd-_U;&\^c9c4<2)FE8A,1?64fTN?
G3fR9X(5(E^-OF;]eN^PTVb^-K6^P\F[L99X@R<@ZU91P_g&4c(d_E,cS);+SKH_
L3A.E,]F&cFKL9_DZA8#I&P#3S;LZ+QUYKG.5TBJeOe<K3U?RMLS)b?/LKd21XSA
H(Q]YQ0QgS,bW-5,E:/P)>94gL5a/0A4_Ig/;B<N^aK;/W98U4FHXSBa4:M.P24X
T]Kc:&&M?MM>&9PSYQ01^AFWN][f0:E<(NU;ag^f\g8-E^,J.KRB8DJ]d\?HM?JT
3\=4I2S@JcFA-_:]G^7Y<,Lc_R.Vb#(92SX4g&]6-Z[FV31N[?V+Gf5T(S1.SL=<
G\:QG^0)e2=FMWCda8cQ1aUcdC0-U.0gEHJ2bU.W;86Z[/AeN)?:0[>c3?9QQ9ef
dOa/Dg#Va->.I/ROJ8\J1ecE<VS3+K(W(V)@<6?:X.fSd(PHP3WC1X,4Lc7c]7L7
\;TT7.=]0]12D<JY3COBHg-g+404DA=517MN>#1:3&D-JbTE4EO_[aEd12Y.+aZG
2R@+GR#:RH2SZ92Ve.:V&VPU7aL,fXPP3XGBJ2R7@Y3)ALT#Z_Z&G?H/FVE64d2&
MT5=4Bg(0Ia]Se4R067.]:#HK#>UI_K#P4([W=fW?Z)J^,7DY7;E2:Ha4U?6f.J[
.T@,2IW<RPcgg2g477:5.CGC?Q=3?K[)S:5KR70]<@TA&0Yae4##P=4V-ILeQ-97
Z.FWA?:]W@fTE?]fa[/9He>L3?Lf?D2)>dQfSTZc?LX7<59X?F6C@_^S#4#bA@RL
+-a=<R:AG<(&+Lc.X-\[(e8)J7c->3&=Z79?YKZY)7R-GHfPGFd3b;GW.F9b8U24
(Y)AZNXYYH[DT,bH/M(,>E@<-E?Hf2UL^a94W<c)17#:&]//8Q\Z+28BZ)g^PJL/
S5P52;25QOFc;d+0:F68RJaSU,dZI]d/7OFN[e+=SO^5^3G6OFSF31&G7LN:K&&W
S[dU9P11I#4YbMb<^3PL8JBdK#7;#LTAY^9g1TXe6)fP_cW,Sb0\:=\<3+)MFDC/
g#B;bGf8UfIX>G8KL7\D1GKf@DSX2DLB>6A:@_>a:baQ@(Xd;)\dH.+^Z50KJ5d^
M,<ZWAFLU7=5651R/GM#@KFA?]6/B82/4F^RPf3&P@a0,52:g]2Kc5U[<(ZYMTQ_
U8/Z7+4[A@d]:@#bA\LO>#=<YR;f9K+d9bO/F>-;21M5WUI4=?Pg;8:(J5f^>Q9E
1(GgKR0XE7KL,Y6g_U7-U#8B\0YWVf;;N0([a<Y.4\.GI)N_/e&edM2]@=@<9NeO
&JL5aVJDVLC]4G)?(AKJAEIWO]X4@#VB0eI];(0&Xg(;O467?gd4J6,2PHU\W.ff
:XO@)4BDZ^T/VO?P5,Ie@8YWHY95HC998MZ__EH23?_Jd<:[3I=.gT-D<H6+\-4P
U<P193-[I25<4RVDNb(7e=DVF,9DV;GVHfVG.KWX;\>g>7Z+Y&#B[fZ@;MT[=A[G
?F\90f#X,L#L7NCYQBCETF1PCcB\RG&+:6A,O>UaNWSBA^W97R.#DF_[0GM43gQG
Wf(f>]HJQW2gWX](I9FR)XRd\&KOa[YA=J39f9BG4TZMBJG<2E1dPJXT+/M1)X]/
./C4/^J7HOS+]WNA^;84.^bc#Pa@RW^KE8)5(0:d(X2b3-QCTB9+(01;]=T<SFE]
cF\E,dS24U63^>GEZf\c>\@,,]:(N>RWNV2=M[=cggBTJE67#2TP.HdOg6-8F67F
+-06B)d8JFL_KeT@c,5IO08]-O:@M\aIBV(cg#D5/PS[APDeY[D9M<^Z>#:a3ec^
#@\,5PVM[LgS_L.NG-Q&U:gD&_H?;A>d5-TcQV\AD<U[_cC-X+MUS@;eZGU5f]13
TN8<f[7_Q61,TB_GCb4K&/g,.fb/T-ac+3b.L]V2V/L5[>.N+R8KY5=ESf^KaX(J
K/&U3IA5H?+=<[V:HCHK//6;1b:M),(@ZS0.>+JNXID(&9Y;/T1D5R2#]KLZfJZK
-1>D7RccLH9b[fADNJ#8_aZ;c7)7NT=_G?6,YfWKX@9gHM>-\@_QC=bX:M#BIG#:
V>WcG.BGLAG10af/@@9>2fV+c^A3-(EGVdNU1Y&A7@]VD]5KB@X(bPM><@K3XV0a
5&(Tbg=O@^/9G4PJSO.I,<_fK.FaH^RZ;_DNXLTN&1fA#gC:3-89#LQ-AISTFL\#
R?cXR9_bb1Ta0)O;/>T>=)89bAO0BH.1QGII9S^Z9D?8W(-e\MH._GN7g4CN)Qg^
7#5URFa55L9\22;Z-.M._WV&AeH&&JbQ/;e849;P?U,3dd4-_f1T_4I[#FDg+R0Y
[INY;eS9F;5A+M[A:2T9g:MCVgWVf5K6YIfW]_FYKF?)]:8J=W,G^)GdfF76K]^5
gXNaaNYe&6Z\U#&R(g4WgH3J2M,E_aTAY(_F3Qf.YT:@GI<?,3gYT,4L8WP5cbQ(
:eCX,2SgLHA]Z8O8X<?47[;Y?CQ=AQP^NN=VDBE7^2GcP6f]W=,;Q79bg/T[<4KV
6g82M0VW0P[<VLK9.D])#^@+.K>:\)<@,Z6V6K@<:9U(-Qf-;LGfCRW^^QCf2_8W
4Y7;4E]S5M#^V8T-bZK;Y>[+DagM@P\-@EHfN?7&eb6A\b9F0@,2X47V.O<02@S7
Lf\&bgV/OT7C#DQ9?ON>=C0KW5#e5Z#R4+^ZNH&8>W[[\J[;5)L5F@M]c\L]B>#f
>,Y]cUGU>XK\L8[3_\I(ZXJ5GRGX;b7ceQ1fXN_>6]K1V(+[PQP5#,b3@4JQSR33
JX:=9[PPR:6_IbEJe\43?QbUW2YH2__9-3T0(:_cPIfJC92&78g>JL](:ePOe_D<
Gfd3711.<UfXA3=JHB8b3/CGZ4C(K<;b(GUQT,O?TFH9AJ?cNRYcGZXg[6c8222/
9a+U2FL#.@]<\F_AP74,]QBI&(&)HS+THK_[CTRXSa..)bVRK8I.@Y=a33)&WdAB
f=S37PEG^^V?[SD<_eT1;W5TNOW;:e123Bb+VYaT&0#])PFP4cOL7CE9c5PVRW:W
9Y9LH>f7_5NY-,WBJeXN&^D&/N)GbL\9PQ66=Q(Y;SYFV#440\W,0dO<SJ3<aZHN
d-G7ST9X7X2d]JO;ACFF>YGfYYcg?1[LL\#W=_=LabH=+K:0L>._)QHRGE.-e/=f
YV655gKZM1HFH5;2IH<&P=@1b\>B9;=3FHff(4Q8&-;Xe.T7@B?6G1/^:S7XQ:GP
Q:SA33FD5a_@UfN0aLXc,^<OO)<ZXO6SGXDN4?LLEePd?J<(M_)HUGb=,I7bC>_\
Y:HI>0@Y(RCWZb)<_.DD9]&AKNX?Q3]b&3/I]K>XX;UWA\7^b2fX#YU@Z3X<2HaW
+\G2B(+3I-ABDM]?3&LT67+P@/+FAO;M04)bS.D#ODI#TW(,P35#\WIc^Z-6::-6
K[)BfLA<@QOT:O8CO,2?S#JQ3K87F@VeA8f2(?CJ-E2D9B:9]:IQ=Q<J5b2?fQ82
0PUGRBU696[4c&\DE<2/\[@QDIWN(_g.;D<EcM)(R++IGJNQ2RB8N/-&:?K7V/J)
5fEba0--7?5,B,K;/>CQ?QW0ab)3gE.ISVg-7MV4YMEMEB<9C<]7bEGfMc[Q4.#F
;3V]>X[6#Z4@0:3FRJ63J<E(L<gV:NH-2P_I62g:C(9;c=C/Ng7-IUV]B[9#IJ=&
I7C)[G&_LfF_#/0ZUZ<A1E+N__feE.TWPM,->f)#+8(J,<_/O,f<g3O0PNV#;X9[
/LRB-bM&f2Y?M?K&;<EdeXF3NE4U2#):54.^O?,D?^_BYK<S(P4?]]D8ZI]5BOd@
#@7-+4=3Hb1ZgR87=8<1_DcY@](X)8R_&c:0_NN+)ePMUH?]12^;,DBd>aVL9U96
_Z\/E^5]TI\E9-g1+E/FLXdF_B-Q/H(Jf0EaC](9?DHU-\a>SRFJ1d.HX#=>05\3
J9Qf=RO.94QbYL<(+V7d2;[V>MB_DXa&X@:)cV3G/E54d6K1,S0?NPeXY,;QQ_FT
#9<dCdYV5B;T7I0(+K?TV=TLF+GYO3C@=A6[W53\>fR,>Gb.c52/(IFPVQI34aFZ
b4cDf?)2d(CKXW<6U4QQ[]];4DFSY1E;ZM)R_\CA<ZJI@TB89DA-W:Td[3bBBAR(
>3/[(O4e@g,.Y:4EO.Z8(K/W#1dG^_M1cUUd@c#:L-6F-M[6?eg0?I&C5_<H(6c9
R2cAbI.c)a10#A2;-d75[,;PeR+3&B=J>3W\\O.CUFCBK(R]Z5TC]X,T;c4PB\J&
N?g@PCd^NS1F13O7-RcF5)I<L-:ZY;G)PdcXMPIW^ZNKG=)\-Z/McU=2;Gd=WCDF
A/9d?NHIG_0C(;R3/F--8DdZ7H^ALGb2^E\\0^1(^:/P;4(d&5F?/#+/^EW>T;G#
b=-bd^f87c7I@<F1&[;3gG]Q.fgbT0R[S<A9DId8:N\0LU0YB<K>6JAA?6MMT0ZG
X@5[/12\J;WPR85:=LS7Q4,dP7?N?F//+JfN?G]8L[NU[[f(1^_D8RG5\^6\aVWY
JdVO3,3U4Na&?A\&8bSC6T8=I6/3/1PO):(TUb?3EWZSO/><1fe5f2dAHD90/-Q.
39bfg>6U>3/8\GLMb:#+3);C@28D/F,ULZ8-&gVf]C@CYdC<[OU3496\^\R.R0VU
>N@:G-O([_]4[c\bcXc##:L7;@E+(J+0RFHA/ULJH_#C>N\9-ZD[I42AV&HR4aE^
4O>C.4QA\<<VY:(YFT@b(U=[3<^<H@#E=c\B3&/I@F]HaA(+(/NaP,..R:5^[=eU
/P+/@@5d9DJBRZOO-86aBF=8.HXM]g[96,bK0W4Q[\SLfE[(Y/agDZAG,:gN1H<&
dA:@Z#GR3b:Pa2@8Df37YKQP.3E/0AgCdZ/.b;8Ncb^)8?CY?]-8Kb:&160>^[\#
:Ide\def?#c@7Re^QIPd<MBFVPUR,b8-I1#a<cA):GM.8&:^FH&+e0c,1+P[5&4,
bM,[fMGWe88Y^dCbM=Fb7MQH4?80V1D+-+&<^<dIfHYJ8Id)C(c7cSKg2H?^;8fb
EZS?GVF()G7=:19VNZ[Y?>gK)P.#=E;]-PU6Hd./Of/a9U[/9\H^Jf^7-]<gQ6aM
/9dB[GP^#-J_73XY]Z@4JFeS\c7L1J(/J#;-PYV#;W?0,REd[22]Z?\EB4A<V2TY
LK8LDFJHd&WeA5U#Tda3A4C,@6H3dWF=3E1JD^gZ^PTO=QQ&R@K/X66PS(-O>FB:
DK3ScFJJH;1[:O+8[L2B@1A.1?>;_QLF^FXV_XbB1_fg#4V<XYG:B:W&DP,8I.:b
[,A@?5=/\VO1d6WC=8E:d78Z_X5OK8_-g1&^^4G+KS3#^7KF:P:fRVa#YWb_IG2-
T_3/KB:4J>[MZ+5CW4L4dg1X_0g3(QLPE0+2aCA,(?gaO2?1EWC\_3D+HG2Qf422
+>)K8R0RaW+:>1CWLXPcGMD_J11=;,+6[cMce_>O)2bC4-A)RZ]C=M_3#8/2B>&E
EbFMd6OB2DNYSa7gB<]c+JcQ+:KOJU4Vdg1GD4f_aX>\;9@5+A<;)8PN\4-2g.?G
6XdT+P.(,&Ag&FG0XJF,]E9SD6#=LDOUcE9<-AX?cVSZ@7DV9]&D+C+@3G0@966\
(2DZD-MWeSe0eZ]?HI<Z1B1S_8BgDYcLD[LaR?-@GD-KR+.OeA]:J1MF-UGEaEKI
W/?9<)/.L#2O&Q2NgIB/M;+=NK[X>?,IM/?=EMOZVHEYCbS9@Z#GaSB=>LBJY95^
,5<0T3Og;ScSE)+LPV(8[>S&\R<;S8E#/YG[[/=+K77])(JS,9EY]L6,A7;.b)<S
-L.[K42f7[CPagabLe>Aa?83aAI@IKffX32(@?JN(_8B=)6]M3<6Cc[<?A&?#4&d
c6D_N(X+bB2)dc7-NKegNTEZTM#J&^b8P07A.MR?P,+^=-5>?<255L>1&9eP#GJX
@W?_T,Y]e)27MVeF3ICG5)Q5,H(0SJg4/.6UN3,X)a3Ng=2]]\eHIY94YYP0&-WT
L._]DA3UC8e?E+\/JF)DI2TPVC>1A?06dH?QP(Y=3;OCVR<W1:d7g(bL.Z].VDCC
WSDTPE.cf>F;MYNIZa([KcZRUefg@[e9fYA^SQXDF3+Z/,U6RB^9\O9AbGJ<8)E4
=1f\Sf_ac;<bLK56#>;(6K,;WA_^/<>ab.\RCD:4(+BOc@1W+<@U<EG#MC\W@NCQ
a2G7_?=?<@Wc6:P.1gXc2B08f]0>=_-]KbCc3I2N3=2e/3RCLDa@:#=Q54R_C;QI
_cIO&gB&XCT_=TY=dY0Q_O9CUde]?50IY]:\]AZB797,gKN:(>Q;Q[e\RJ06\FV/
_K\JMW8aM-9U]D+[f?:f1>-X?Xb+0CY4#:6^]U^&#^S9[Y0A.^0R2BQ&fgPJQE6S
CK^a.7VWM;V9FSLJ5ZX),A3WB/H1YJ9)\Je?NPbO;R(U;66-G[?(;S_KD#]N6LZ9
^F&e=fXK5AWAT=2[0CdWQ8^(6F)</6D6TBE9@R:GI;/]>[==LA)PWaaL\CWU7S=L
KQ-<Z0UbG[b3SH0c8UeH_V:HLTH(G9(69F^QH7b;>>0T<D)@@bGPLE]]F,ZO>(&C
FS07aH=2R-.8R:P\/?U?/cYZ0L0BeIG/0WM2VA=<bOD>CbEcME;DA-P0)1N.4^DT
++HSf2EfMg/UMaW&5bAY-e\>CGf_9cD?0eQb)1G1BB18=d6SfPg#08HIbg7Bb]_P
6f/7[1=S@Qe(IXff#.OFNXJPBOOVd6QZ<-B+<@JF6<UQ59]7a>GT4+VUSUD==\&P
&\.QdSHX.@O[51U[-K\M&9/\SFJYac]f]/40U8TZ=#4+CW3Uf+f(G^L5Vf&DQG:/
/,32,VNcU6X,>;HK1Z>ISW.^/^ABXRT+]VV2YcR(?2Y#D,7]ZZ^2[f@(VIB8:e#W
4fGKf:9Y<SUe\gF:_4_7:Nd&MGM2,5I96?]XNA/E.\:&S[Dc@Q@e93;b:g3)(#IG
EL.?[<e]_A0BX>3)=7CEP4MN-NY[Ye2A\R(TE]=8J4BJ@\dS?5GC^3R-L1@UU5;N
_+S.51DbCCSN-V9FA;UZ/74+4^])S;Y[BRB+Y([+PF_g7:B/NN)(\^2MZ9/AV4(T
=S\BR;^4\_8c58U]Q#)5<:5MM0NP.U&DGcI.GXRHI6[)2@K_76;75LS?dU)aBFKP
dTMU.SN<R,?[VT,DE(P2Qf56d?L;UN^BGc_MgID3HLN6[TZR-M)8C;@-GFAQ1JDY
N]J5;PEgbOD<.)M<ebMQgDJ[O)A6d<E]Fe]N;3MO[e7=,Te^[G<2Z9LM/[#SZga?
Baf\b&[DcbG+I@1eP/FZ@b0bdKL4bN+VE[Vf[@;Y=]P@><U:NJBK(gXPLA7\C#5(
eGc^6])L4NN:1b:f((^U):1LD;6^U[N2Y93Y?dcf@Q9aeC60[A<cX0?D=,,LFc3>
E_25GIAC//g9PUI)PeG>DQ_OQeVdNATYVG,PW9K?>1FD6>KU+9R-_K7HEJ49,8-T
b]Pa/GT2)&dOe<O8e5MJTDJHK0D)R4N]FdHBf6Y^+05_+TDZ4CgQCHg2TFI;dgT.
5Z-_54SJ816=<d5#HZa#PaBH-T&/S78Vb[J8LPX2\c(geaR>-S[c9cO>T<-c4JL+
9+KaSJgS(,+db/13N3+)<,+6d,3(2(L0=+T02,WX=^/?6=I,QGf.Wf91,Y_^ZW7R
XX5AC6K8(@ZcJ-LJ1B-ZW?]R?IO\cDXS0]\@,7c^CUc3Xd+3OG)@+W1W,R.K;]9;
2XXfY+3I1/Z@cUG:@C6(@-L./W2L]-B1KN@2JdE>@Z>04OI#N[/DeZ1<?5M>4Mgf
7.?M._.1L<Jea9[b>/?d)eEX20ZP.E@,V8]Rb]2A-9FCP=b1Q2IJeK[U/B+0K1,3
SQ^Y-WU:_e&a2:3DA60/_91FT+XJ:1MK_C1>@\AH7\V90;#@;/JNb_Ic>X4BCD2e
Q[DaK9&(4-&WYZRXK/Y[O_g.WHR;WGfOeSO=_b_4[TN31C&[?]5-]_7fBJcV2/9a
HA9Q&=UE8gUD6f^YPOYgTeM=/)?\CU8_(C4-M7cePd5#M;:GKbGS5(3;GZ/BU^I-
JQeC2,T1ESGaJF7FW^@:SCPT_+WUK(32JFdEI2@;.]c3.LT-3GRE&J=T2R/;eBZR
)M?+N]0FbCWX&,N_(A9b_ZZ5J9(G/L4,W<,7<,9?3K+)-gd33^_U6OA]JJSS>B9#
8Q3BV3C(P0F8/W9.e4LGYV-A9\8UNI/;Ae(:?]e4_MO/>O11]GK?.9f5eVDcC+Y+
+XcNN=_dT6P-P?W-#KD&].-:b\6(T#eZ\)A_)d[eV&T2\CMH>M@JTba@cD;DB7>V
8M0[H)d79PPA14f0fC@O[B_(7BWGZVFRK(cE>eG4c8IJ8D47RZC4DGJ;gc)fX\#0
XNeL^+dMdP3IJUJH>98[1##A4#TU]++1CL(SLW8=D02X94I-#I_A41J;K$
`endprotected


`endif // GUARD_SVT_COMPOUND_PATTERN_DATA_SV
