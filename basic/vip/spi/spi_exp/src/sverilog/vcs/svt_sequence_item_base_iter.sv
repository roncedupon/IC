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

`ifndef GUARD_SVT_DATA_ITER_SV
`define GUARD_SVT_DATA_ITER_SV

`ifdef SVT_VMM_TECHNOLOGY
 `define SVT_DATA_ITER_TYPE svt_data_iter
`else
 `define SVT_DATA_ITER_TYPE svt_sequence_item_base_iter
`endif

typedef class `SVT_DATA_TYPE;
typedef class `SVT_DATA_ITER_TYPE;

// =============================================================================
/**
 * Virtual base class which defines the iterator interface for iterating over
 * data collectoins.
 */
virtual class `SVT_DATA_ITER_TYPE;

  // ****************************************************************************
  // GeneralTypes
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Internal Data
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Log used by this class. */
  vmm_log log;
`else
  /** Reporter used by this class. */
  `SVT_XVM(report_object) reporter;
`endif

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the `SVT_DATA_ITER_TYPE class.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(vmm_log log);
`else
  extern function new(`SVT_XVM(report_object) reporter);
`endif

  // ---------------------------------------------------------------------------
  /** Check and load verbosity */
  `SVT_UVM_FGP_LOCK
  extern function void svt_check_and_load_verbosity();

  // ---------------------------------------------------------------------------
  /** Reset the iterator. */
  virtual function void reset();
  endfunction

  // ---------------------------------------------------------------------------
  /**
   * Allocate a new instance of the iterator, setting it up to iterate on the
   * same object in the same fashion. This should be used to create a duplicate
   * iterator on the same object, in the 'reset' position. The copy() method
   * should be used to get a duplicate iterator setup at the exact same iterator
   * position.
   */
  virtual function `SVT_DATA_ITER_TYPE allocate();
    allocate = null;
  endfunction

  // ---------------------------------------------------------------------------
  /**
   * Copy the iterator, putting the new iterator at the same position. The
   * default implementation uses the 'get_data()' method on the original
   * iterator along with the 'find()' method on the new iterator to align
   * the two iterators. As such it could be a costly operation. This may,
   * however, be the only reasonable option for some iterators.
   */
  extern virtual function `SVT_DATA_ITER_TYPE copy();

  // ---------------------------------------------------------------------------
  /** Move to the first element in the collection. */
  virtual function bit first();
    first = 0;
  endfunction

  // ---------------------------------------------------------------------------
  /** Evaluate whether the iterator is positioned on an element. */
  virtual function bit is_ok();
    is_ok = 0;
  endfunction

  // ---------------------------------------------------------------------------
  /** Move to the next element. */
  virtual function bit next();
    next = 0;
  endfunction

  // ---------------------------------------------------------------------------
  /**
   * Move to the next element, but only if there is a next element. If no next
   * element exists (e.g., because the iterator is already on the last element)
   * then the iterator will wait here until a new element is placed at the end
   * of the list. The default implementation generates a fatal error as some
   * iterators may not implement this method.
   */
  extern virtual task wait_for_next();

  // ---------------------------------------------------------------------------
  /** Move to the last element. */
  virtual function bit last();
    last = 0;
  endfunction

  // ---------------------------------------------------------------------------
  /** Move to the previous element. */
  virtual function bit prev();
    prev = 0;
  endfunction

  // ---------------------------------------------------------------------------
  /**
   * Move to the previous element, but only if there is a previous element. If no
   * previous element exists (e.g., because the iterator is already on the first
   * element)  then the iterator will wait here until a new element is placed at
   * the front of the list. The default implementation generates a fatal error as
   * some iterators may not implement this method.
   */
  extern virtual task wait_for_prev();

  // ---------------------------------------------------------------------------
  /**
   * Get the number of elements. The default implementation does a full scan
   * in order to get the overall length. As such it could be a costly operation.
   * This may, however, be the only reasonable option for some iterators.
   */
  extern virtual function int length();

  // ---------------------------------------------------------------------------
  /**
   * Get the current postion within the overall length. The default implementation
   * scans from the start to the current position in order to calculate the
   * position. As such it could be a costly operation. This may, however, be the
   * only reasonable option for some iterators.
   */
  extern virtual function int pos();

  // ---------------------------------------------------------------------------
  /**
   * Move the iterator forward (using 'next') or backward (using 'prev') to find
   * the indicated data object. If it moves to the end without finding the
   * data object then the iterator is left in the invalid state.
   *
   * @param data The data to move to.
   *
   * @param find_forward If set to 0 uses prev to find the data object. If set
   * to 1 uses next to find the data object.
   *
   * @return Indicates success (1) or failure (0) of the find.
   */
  extern virtual function bit find(`SVT_DATA_TYPE data, bit find_forward = 1);

  // ---------------------------------------------------------------------------
  /** Access the `SVT_DATA_TYPE object at the current position. */
  virtual function `SVT_DATA_TYPE get_data();
    get_data = null;
  endfunction

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /** Returns this class' name as a string. */
  extern virtual function string get_type_name();
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
B/]/-O,aWEEMMIYLc792[T.&7+;VFOD=&VD/&e==,TG]CR).]F5b)(bK1d1\U.\b
80W53R]aGL:G&D_g2P6PWN^\:\PUQ#cB&+@W8IE4L3FD-f5&]5JRM0[GbE6Jc>:O
MB[f(IJ_J)GV8(=?XT1\:A[JeG.,#\<@;6EbM5KTN[-],3PG]]-gQX>e-TH;\A?G
[-&D<ZX-EPZ2\3ScM605N(Q_MD1-@KR>@3:L6(W_>:\4@E<P?RCLL>GYG\.UDQ[A
+RGW)F,(RaO?^Q^LLQ7/M@4(FCe.Cc>gVL=0-_B74LH-Ub_]7H;.U1:+9BK<[X7Z
3gJAK]\A;.gM,bU7?@I_,cN7g)QQe;DcK#)S5Te:O(<&0B#bP<\=eM8;2:-]B^#3
>c-a)Y8(VdEBI(G@.4H9IJ.HQB-@K#MG(+0,-YJ97+4Dae]>e9=fI/XVNg>00R.W
5a/XcLBGb.4_DAc/_FYT_e,g_&QVD#(:e8CY-]8F^LDeW,TTTI+a.ZS6cbY1I(:U
be5g-e8\bX=D5@?EIOad_&Y0HL92/.8.Cb/g@NIg>[aO0R/+SM;Y\d\Obgga1DUZ
b[/=11=AOg;35_;/XYg3R_>>AT@TG_YgJcZ7Q\YO2Q.\VYKU^>C;fPg27_Tf;cC1
U;WBVW&^SZScPJKTCb&HP8b+FI#(K4.,G/R3@G9LE0[]E.T/bObd^6.fWd51bTcA
5G5L[?dL=I(:VK2.:(Pe-e;_cLD0BR3<Q,Ba+T>^dJaXE+@Z)Mf8>;/fe/I8Z,,X
cgZf7B.N8Cfc65PC[-1;4X29;NQd56aWKEQaRWV#Na8<bXMKU9S[e1NM_DB7C.#)
HYB3FUPGU,7c6RTFVY@4SNe4>#1AUO6V\7bYUT)OPcQ?>f(gd4ccd,b\]TA/FJ+d
fL1cUI<WJEYaF)DC5<3D:1aJ&(@gE+@&/<A=1LJ<1SDNE.X_UgA/^c;CW(RO4)c.
(D#(c0[YU_W]EJce7e&H9OcP@SG>gMK3JFdRe(Q4_gZ30Q@cMdG.b+O_QTgLdIFX
RQ>d@T3HUIZ?28G@WGF-#_+UC7D>HLPA3=ZOT2N7(5@4B\)L7,GgZ]/^JP>3.;4e
O3U=,OEEO@Wfe1Ka&ZT[N7L2Q6=AS,+09##JZ(F>X+Y22Z)dC9VNYXY]g?O>P5f-
:F;D>U&1g?HXQ584f8Z6d+fE16(57@=A>H9ITHI?T6e=g0+.&aKWbf?M:>aTN\/T
=d;_>/44#_^80?gXIg<S@I4Dac>//b1[M(=:a//-GF1N-8_:3a#VLEH@T9<J><S/
A[K3Q&+E;4@7O\-1=e]<eY&++IdSfG)5=6I:A-Tg42f#TX]g;?]_b(G(,HE>94BA
FQP8D_J,,L=>UV=TYgbG51:>@MbGYVR_TO=(80GfO\()QPA0G5(+STSV9?]WE0cQ
XEIV1OFNPYO#d1:=gU3C48eP;f:Od8A44?FU(HK9HF&5Y_VQU?(6<41\D;=AbIe]
-]V6WST/7/4@]dZSFEVBgB1cY6]R;Jf>N8ELYMZ>VH(IQ;J1N_LWQC=YLfg4?8.>
65&BMfKM[79WPI;_5fHQWYD4NSMOIRe<B3R[\,MabDL4V_CecZ_)8O#PA]:P(<gE
PNf(Ag_K#V]<b>:1fEJFe9A3?1;9S:E(GU1f@Tf@+6E00b.Y@DWcZRE6Ia=[+a3d
&5A4+g2[M6LcL;XF^C(+G#7]9Y;0.6=DScMB,N?PP9A1+gab/^;.CWLQP^R&X6YB
d:NI=]=8W]U7G1]FS\&5JA8#?S[C9e2-6eTa^PUM0^gMg&=ZT#-VERA2([9T]R#4
0@Zb]Md,_N-&S&[WFRNb0bbB4H/#L_)0T2Z]g-1SdFdOYJ=^2dU6D],G3-LV@BY[
1g;H9>_&>O^.>:E(FT-)ROC))BF_0V+WN5QZWJRBFJV#eg3b_P+>e+3^gET/6<9a
T::cTa.)+:c(A>I]ePP1/PaNW58]]ZN^VUL4Uf8,6e1A0Bd0\>R3=2c9,L3?JB(R
/T>6E)JAg\443IH[fVdI4#<&<WgU5XN>fJF0HUL3+)+JS-/=TODg]DW\QVWB(J9&
SBb,A+LZ2\ZF0QF5_gY3WTgD[K-?^;#W_2O&I=2a^9\OV[6=RTHZR?+8\]cFHCH;
T<QXcPK=Q&\R5;IT7gVEV?;?F&LB8M,8^EY^13c,FQ?SPM5Gcd:3X#7-gP(N_5=(
CL?gR;3\g7FVc@WYWPb(K\HVd<9TcCV8bJ285^V/P(E5TII&W>&NO]86DbSBBf-T
6E;3?)ee]E6NB&+J[<XK/D[WM^:Y5<#VdU;\Z,Y&>A?:gG=^.7c)+6bbE.b4Na>(
(0H9>1#FW\ZG<Y9Z5Ia,H_KVFOg<16KIAY)-X><GO[A]V+BPRP>dFU81^P/eN-Qb
B[M,Vb=X9-Gb_^H>YH3&g\R_1DVX=55gA2LYd&<3+Q#/68U[\-P9bSc_HbIN]SL&
PRR7C1/47;_0dG0H9A3Mg2gLVCA,OR&gC6I5g2(\&R&6ZFCL1X[.T.PV1#;J=Ke]
BMfDg-[G6cECQ6:94XR,9gY:I)b=XgTeK,d@e[S1=AS>DbeQ6/U1JJ@?-_[4Y+N3
L13]aP(1EY,R1>;:T68]XS._9TE550)<[bN/:OcfGgCLRS).590dQODC<K92)g1\
b+OE7YWGLHf._Tf^UM=]Y7Gg(,2EJ2,?JIII1V-X9/,/GD,aZ)9#698S2YOdL:,C
?7G>U8G/\)I-/=V5TJBOV[gZ<<T6]72NB_a/GQWFCH(aJ4.FV?(B0>JB05([2<[:
U7+Yg/[L6.P@4NDMV(MMF0+Q4Z@G^4]9@19d\6@/Y71G-.^-:T6:IdD([:(L;NM@
8XU;F&,O<gbB70M)f5]fd-Q&SHcg/4aI;H3=MATZ67,8d2<)NLVBg-J><^J[)B@e
?;L+)]bRfMJe8979)]=fWJHVFFXA(O]ECHa):R+?>.Q7ffGQ6TX=D4C7&,V-:-0]
f^Q,P(bD)QH2^b4^BEdf9R12+_VQ[K,Vb5E/P:MfJ(YdB8A&M:I/L/C]07>[8@eR
6Fce]ZE5KN;9fM5EB\^N;CO:(R.aB9/R_UM<eH0F1TAV)X-ag3b5L^DK]YRdB:.?
L-=(KI:2YZf;K1MJfg+NWM-TL[gFO7F/HHGWG1<gT+<JN1N6NXbV>a(GCf?eL\a^
8f8=_E<(G\7A6_Y?B>\U)Lge<Y7b2->XG&Oa6)g?6Yc,?@ZMP\GDH@<5Y2bf.E_d
(dT[/DEL\Z(;T@2.A90CTb>H6/67XfDC4N9SIUB8b7_P66LQHc(CWaU>A]\S;_S/
T^N3L3@H<F@&a9;5@37M/<d0dE@,ea2E&Q<HA,bA8LRTaL\;dXN]21J+^b,[Q;+6
^(L>4<RKg@F2&5([NX;)=WX8RV2bIU#1Xg0\/O8N@BTTJa+QU2L>J@gePSD^F9IJ
Ja9DB6^MYg-R5f=HB/(S()G2^IH12Z+=,M)./++G9XeICF;&LHU2@_<NF)#9?C)G
B\eZ-\ZW?g;_,7EP:Y7b&GY48IR<U8A#ST(3Jg&[.8&A..=:IG64cO>KaFAf3TXA
/?\;OGW&;ZI4g-M2=,NPaNIaG\U=;_<\bJ8BaV.7>-T-/]884X@-#4-E8B,@SQe6
T-\I@=#-G=[8bJd,B6PTP_7_BC29G][F)ZX=)\(_==d2ad2O894.(:\&E;:9CK93
1_AS)-_+B<g]3>/&eJ,H,4MMgHbWG_^C4B)&bR9&g,7g3P]<Z2K#_dDOHbS?Z&NZ
_E+R2P2;/]H]WXHgO(0H5Be;-C1fJ<U4:.b)?TJ1@g_-Q7K[I&a5:,WB]<A<.R>S
_O][]d6HUC0IY+HIDFP70]L]HVSJOGF2Z2,:DDcR+3-U(.02a8eL]aLQ@TQP_+Jf
OR<./RQWTN_K#):eU/O2N6AG/Q-I9EVDXUeV]T826Lb^d4I&Q\,2Q9UH<S7ffK,1
Y5OVDOCFY\d0MEGM7M;0X62(J,7DH#0S3CN3PR?Q2V9:209_+]X>b6\7&cd3V)gX
\WZc(.24T84OaAN7B/9BV&P5aaFGMM.@<R[ET^=I#D\(+QK^VBLW90E\\dQ[<?6Z
^A?a3PJB<L&9Z?^BdL71LH>O2EP[Qg@D)F8Zf+4Q6MI+N_T:I<T3_<K]N@2dHOW-
dP98P.g1<d.MO(fS>R,E6[VUd3PJX0a.Ue+bE\T)9((Jd#972fF)fYa)RGQGM<^)
]&\&Tg3>&F8_OG99Q\ILW,1V_.N3F5R(WR3FGP#8&5<)[\H#RJ^Z(AC,W)F6&EB,
Q&3UEc5NEZZI:HI]3N+1]ZBP+.F3Feb=I7\JNP5V:TYI(WK0B1BD0D@W=_F7F;\>
.+6gWO@.S^eaI0],GK#]>[P8,Z6)&Z?JeSf^AC[Z[bV[AUF-6MaUX639gSS;0/N=
BI<67D_VGHN.]+QUaAVfMf>bIg4JZ@R1G)EU_F.0M+90eYXJ0e[J\1NS<dg&dA\c
<1(9ff.0L3[aBd8[OR.PM7bEC=.H=EFO67\3&ZLd9bd<8HLKb/M/A>cXFYc[P[e]
,Y2DD[O,F?cUVF<3J3]FV-1MK7MWIUH-\?AUASDKI&GI34cA)M;2f)-PPW:CIO]8
F&LS^W@Dd[2I,>[D<V_GWJc7U;caPD==#D-?,e=dc_gV\R+QR;+2\3J>[=],8(ZY
YbA7E/(CEZb4F,B/\CN10-_5_=&dWed4&2U\-5P<<8PJTg\\32E/cZdc3SfF,LO>
\^4+IF]3)\HF8.Xf7:fGO=/5Z?PG_#WJ^a\bgc5]G6.&YT-@B]1OJ/?8G==8.B3U
R,_+@2XXB0@FT=^HKE>&gXFH/\V[036#BZ,\9cN3=&#K:4T7/c=#0]J1a4A&6d4[
46DZ<-:KW?Db6f/N&9X[+bWAYB)JB.#^#R?2.V1AdSH1T;KG-gHIQ2LT>-/;5g_L
=DEda^FF)B@D]/d/?K2Bc@LJPXWQ,G:DKT7VAUJ5]7N:g?B;K#FV_771K)6e&H?N
I8-4;0dRe-S+d3<JEXb,6GR.3WN3@:?ZD;V&a_]RSY?d>fH4;^(06,SILR[C9GS?
X^C7\)@;HcP<S;2:(>PK5L0H)D>27f1(FPIXGJWK?gWE^LZQ=33W6-]]g0A\5.eB
GaTK\P^[\-]Q^F)@C+fg.QB4S^#Te50bAQ[6<M(G>)YO#,S84fYC1GW,3,NLdB7d
=,HI9ec:^&L<LLOINNeT=]<TJZ/=L,,EKV2X5[DYJ-+a+^KY##-(aCW,L$
`endprotected


`endif // GUARD_SVT_DATA_ITER_SV
