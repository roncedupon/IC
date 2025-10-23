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

`ifndef GUARD_SVT_DATA_QUEUE_ITER_SV
`define GUARD_SVT_DATA_QUEUE_ITER_SV

`ifdef SVT_VMM_TECHNOLOGY
 `define SVT_DATA_QUEUE_TYPE svt_data_queue
 `define SVT_DATA_QUEUE_ITER_TYPE svt_data_queue_iter
 `define SVT_DATA_QUEUE_ITER_NOTIFY_TYPE svt_notify
 `define SVT_DATA_QUEUE_ITER_NOTIFY notify
`else
 `define SVT_DATA_QUEUE_TYPE svt_sequence_item_base_queue
 `define SVT_DATA_QUEUE_ITER_TYPE svt_sequence_item_base_queue_iter
 `define SVT_DATA_QUEUE_ITER_NOTIFY_TYPE svt_event_pool
 `define SVT_DATA_QUEUE_ITER_NOTIFY event_pool
`endif

// =============================================================================
/**
 * Container class used to enable queue sharing between iterators.
 */
class `SVT_DATA_QUEUE_TYPE;

  `SVT_DATA_TYPE data[$];

  function int size(); size = data.size(); endfunction
  function void push_back(`SVT_DATA_TYPE new_data); data.push_back(new_data); endfunction

endclass

// =============================================================================
/**
 * Iterators that can be used to iterate over a queue of `SVT_DATA_TYPE instances. This
 * iterator actually includes the queue of objects to be iterated on in addition
 * to the iterator.
 */
class `SVT_DATA_QUEUE_ITER_TYPE extends `SVT_DATA_ITER_TYPE;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  /**
   * This enumeration indicates the type of queue change that has occurred and
   * that must be accounted for.
   */
  typedef enum {
    FRONT_ADD,      /**< Indicates data instances were added to the front */
    FRONT_DELETE,   /**< Indicates data instances were deleted from the front */
    BACK_ADD,       /**< Indicates data instances were added to the back */
    BACK_DELETE     /**< Indicates data instances were deleted from the back */
  } change_type_enum;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** The queue the iterator is scanning. */
  `SVT_DATA_QUEUE_TYPE                  iter_q;

  /** Event triggered when the Queue is changed. */
`ifdef SVT_VMM_TECHNOLOGY
  int EVENT_Q_CHANGED;
`else
  `SVT_XVM(event) EVENT_Q_CHANGED;
`endif

  // ****************************************************************************
  // Protected Data
  // ****************************************************************************

  /** `SVT_DATA_QUEUE_ITER_NOTIFY_TYPE instance that can be shared between iterators. */
  protected `SVT_DATA_QUEUE_ITER_NOTIFY_TYPE            `SVT_DATA_QUEUE_ITER_NOTIFY;

  /** Current iterator position. */
  protected int                   curr_ix = -1;

  /** Current data instance, used to re-align if there is a change to the queue. */
  protected `SVT_DATA_TYPE              curr_data = null;

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the `SVT_DATA_QUEUE_ITER_TYPE class.
   *
   * @param iter_q The queue to be scanned.
   *
   * @param `SVT_DATA_QUEUE_ITER_NOTIFY `SVT_DATA_QUEUE_ITER_NOTIFY instance used to indicate events such as EVENT_Q_CHANGED.
   *
   * @param log||reporter Used to replace the default message report object.
   */
`ifdef SVT_VMM_TECHNOLOGY
  extern function new(`SVT_DATA_QUEUE_TYPE iter_q = null, `SVT_DATA_QUEUE_ITER_NOTIFY_TYPE `SVT_DATA_QUEUE_ITER_NOTIFY = null, vmm_log log = null);
`else
  extern function new(`SVT_DATA_QUEUE_TYPE iter_q = null, `SVT_DATA_QUEUE_ITER_NOTIFY_TYPE `SVT_DATA_QUEUE_ITER_NOTIFY = null, `SVT_XVM(report_object) reporter = null);
`endif

  // ---------------------------------------------------------------------------
  /** Reset the iterator. */
  extern virtual function void reset();

  // ---------------------------------------------------------------------------
  /**
   * Allocate a new instance of the iterator. The client must use copy to create
   * a duplicate iterator working on the same information initialized to the
   * same position.
   */
  extern virtual function `SVT_DATA_ITER_TYPE allocate();

  // ---------------------------------------------------------------------------
  /**
   * Copy the iterator, putting the new iterator at the same position.
   */
  extern virtual function `SVT_DATA_ITER_TYPE copy();

  // ---------------------------------------------------------------------------
  /** Move to the first element in the collection. */
  extern virtual function bit first();

  // ---------------------------------------------------------------------------
  /** Evaluate whether the iterator is positioned on an element. */
  extern virtual function bit is_ok();

  // ---------------------------------------------------------------------------
  /** Move to the next element. */
  extern virtual function bit next();

  // ---------------------------------------------------------------------------
  /**
   * Move to the next element, but only if there is a next element. If no next
   * element exists (e.g., because the iterator is already on the last element)
   * then the iterator will wait here until a new element is placed at the end
   * of the list.
   */
  extern virtual task wait_for_next();

  // ---------------------------------------------------------------------------
  /** Move to the last element. */
  extern virtual function bit last();

  // ---------------------------------------------------------------------------
  /** Move to the previous element. */
  extern virtual function bit prev();

  // ---------------------------------------------------------------------------
  /**
   * Move to the previous element, but only if there is a previous element. If no
   * previous element exists (e.g., because the iterator is already on the first
   * element)  then the iterator will wait here until a new element is placed at
   * the front of the list.
   */
  extern virtual task wait_for_prev();

  // ---------------------------------------------------------------------------
  /**
   * Get the number of elements.
   */
  extern virtual function int length();

  // ---------------------------------------------------------------------------
  /**
   * Get the current postion within the overall length.
   */
  extern virtual function int pos();

  // ---------------------------------------------------------------------------
  /** Access the `SVT_DATA_TYPE object at the current position. */
  extern virtual function `SVT_DATA_TYPE get_data();

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Initializes the iterator using the provided information.
   *
   * @param iter_q Queue containing the `SVT_DATA_TYPE instances to be
   * iterated upon.
   *
   * @param `SVT_DATA_QUEUE_ITER_NOTIFY `SVT_DATA_QUEUE_ITER_NOTIFY_TYPE instance, possibly shared.
   *
   * @param curr_ix This positions the top level iterator at this index.
   */
  extern virtual function void initialize(`SVT_DATA_QUEUE_TYPE iter_q = null, `SVT_DATA_QUEUE_ITER_NOTIFY_TYPE `SVT_DATA_QUEUE_ITER_NOTIFY = null, int curr_ix = -1);

  // ---------------------------------------------------------------------------
  /**
   * Initializes the `SVT_DATA_QUEUE_ITER_NOTIFY using the provided instance, or creates a new one
   * if possible.
   *
   * @param `SVT_DATA_QUEUE_ITER_NOTIFY `SVT_DATA_QUEUE_ITER_NOTIFY_TYPE instance, possibly shared.
   */
  extern virtual function void initialize_notify(`SVT_DATA_QUEUE_ITER_NOTIFY_TYPE `SVT_DATA_QUEUE_ITER_NOTIFY = null);

  // ---------------------------------------------------------------------------
  /**
   * Called when the queue changes so the iterator can re-align itself
   * and see if any waits can now proceed.
   *
   * @param change_type The type of queue change which occurred.
   */
  extern virtual function void queue_changed(change_type_enum change_type = BACK_ADD);

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
94W(X]<@>5R,8KZE+\]?499fGQ-MgW2D:V\1O)XBCG<g)+#;;7Qe0(&S)W]HN..Y
K8DU;8)<6ZF0SWTBHPXg<Z95VCT2:bBPbSfVHb1F1[P81g#9.XG=>>bdJ)Q-:7/P
-4\<1\GbH]&\FS)BaKS?c(f6FP&UIeAaaW\ISJaT,5^S6[(UVF4U9E6Mg/CAVIb1
UMG/C)eb>E7NSVEC2a^T->KMVU0+/EB,^Q<DFe,+2R,T97UG>5g2^9#FXb2bEC84
<c>):eQ2YXdAN-OUJ12FDG3<McHc:1(E7/:H?Ba3C4F^8+(#SHXedO1Jg^9I+@0g
/X+b03NWCT=Wag3QV=HJ(cQcI1I4Y7;@Y32<@8J@e6aTKL>EM^_4F,WWf9,5E/CE
)08DBEG)J#/QF]IT^c/X+/U9B4b^B<,DD;HR9/(HM?X<9,WB@4=U[:FabdGc2G7#
0@+)R/MEVZ#dafDG-A<CZ[Rdb=G_aBBEP+QY08:/e-Ff9G,+R?V=2T2_Y]g4U3g+
GJX?fC92+D>6D0SX=<KdA65+6TX4;OV7(DScL#42U0V3aM]@G13B(Le[LBKWABc;
3^6.e:S9-Z8QT1I<V1;>Rf:IZ\@A7LC,.A=U/4_g(>[\D]K/);26[MOR.f=T@8b(
?._7(>YFDgcWfM_-Yb?0fKa@Q?dgAI8e_&6DaeJY2_T]F,7@@a3,2K5QZ0V:e.J&
>C[=6:LK>;]?<>_Ba-IcDHM_Q4JRA.If\J9@V?+//&?6@e1cPS9V^5LKP]J+eZ6B
eX#>M54PIN?Y;EfUOR=NeY+gOJd^.]g0&G+80.X>I&3@b?JC4M;c6AA:Nc1-VY/W
[:;=M2>A,4:>G4PUXI>#e5F(<fJRS-B1V^LTV5f:Q;KIWPARNAE8:VFE+S1>SL+^
0;[FRNBQR6GR6fC+c=f:]ZF=F8Wg0e@(R@<W6/B_:.DOdD3:6I\#c0CI,B2=c&.1
fL6BSE8WY1]IdDY5S#aVIR[1HT9I98beNHSND\2OKZD.:+ACJ1d?1P6KK.JH/TBG
@)5dU60\4(G)KNX,R,,VYaP8]f0^#&]\,V]J(H+M1Z]E\[_1^TW+,S<T&4:799O;
,@:>J79X#36J>NR>;777aR/Pf4FF<=)2&&@JW)c\4<[J<@;<<Z>P8TDG.E;Sgb3c
<D&WEQIbSCT8TPR_f_g(H3eIdWRZ11TcUU;XVHFC2YKQ72@2d.TEgKKM1X,:Fg+E
](9cGW@cKb0UCEXTM/R#?2G7?215I0\NL8cWC?7BZ<M>;#6f@(gEU9/9@_<.e:7e
MNA)C6LP/(T9NWdf;0T.0W)WPKMQ,#LYV3A>U#=ZV6/-[fc+ZeK8FI:YLW>UAJgQ
Y.UQ26L=eVM(C(Qe#dDQaH&.F8U8_-7ONG@S6KMe:PJ4=@S+IO)SNMI:@fY7gC&Z
>KBCQHR&(DDCILD/(FNI&A)9[Q9QaXT)C2W)LS>L:e8AMZ;afH&_#FQ/T59R9Qf^
;OY-M+e@Q-f?PVg5Lb,[L6gAgCLPJG:B4=8+eL#DNQ6[?XEI?eG6T)[Y+K4E1468
&&GK5XCWS)2SJR(d9<+A;,WJW65->VPC48@>Sg9CZX^?0Z_QGF<)A6.e]A)WHYKL
J(<]N6Q,PgM\_d06EE5G1^?C/gL0YIcJWAPO@70PTN(U=)MT2Ee<EaVKBJ9bK]=a
>Be?-.R-JP-b=D3OVTXQWg&;P:.^1EQEDIcHN9OD?-Q=C[G[V93X>48]?E=BGO64
KAQf6P1=+NgR1^DN5+ZP=]9NV8aTFF,JLGL;\+1DDF4CaW01()+Ce]BC]UaXJb7G
8W559NI)dF>#IIUaX/2Q1XWf69>8+409URY6VeC[<8XAa]fcHFI5aWM@H-/8b_W(
=HYI[2Y[YF?KLK/)P9T/GT&.3JKE_(c?OSPC4/.E1T+0L9QF5#:-FI@PA9(<>&O4
]EdF-a;Ze;bI8,>?AZ62Rf^9-URW>=3RW@K)E<H0CUL2d_@5K[KAd3fTGFE&0J?b
?62GBNe#-BJ8BFG1d8@MT^c/0([O3Q(OfPM[WeUf4L7N_GDWZZ08XTRUd3)Z?;\2
?;L)dbVY2[+&.#6?^//C2PW=3ggD0N6QVgHI^_?/\>10Y8UZ_3LD7IN,e&UcfI+/
#0U.&,[,@9\)g0;aCQ]bWg<W.;fD/-\=&<259\4CaHcdf)Y+gZQ_d3\#1aWVNf[\
)Z@N+.f0FB=GR/J:)OfN_VM_fQb0e?-9NDM7Qcg?UZCA0WZEL#<DXE^\^6LWXF0V
g3BV#e+8?[MMB5H(\-bO13ce\AD3>5MILX@U;d)OZ,R:BXW\6GaT^25&TC#VH-?g
KY=Y<#C7d\(gDS&dU_8(a82,V])L20IZ6L[8@g;Y?;OQb7_XM+S=VF(Ge[SQc/&8
WJ&Cb^<A<I_BE5238E0\&[0^d-^_7ZFW8fUHG^5F7dVT=<ab:WLO9AQ-g]Udec0R
,184-bRb^G@CEM0LEKA==@f+N=#MDU=>7N4NH@,2<6)gK8c/+\\<>&d2J.HM&U)C
:,_X6.b2b[4_FDPCW-^36GTY);Z70gBCIFf0Yc9:bNYUa#D((3FM>^:@S.U+K]UM
EOAF&WfYCQ\1N,aT/bd0M[YC(<@_H9SSIeD^,Q]5W2N[,5<,[2TWeH<-G3H.C:?-
]K4X28]8HbAX3V=N4DM3LF6;)RT,CK^#9^TX,GPOYT9D[.7.g=KGLJ8.DA6RDB5Y
/48NO-;8P/Yc505N8<W89Ld4>Y13(bg<b@7GK3A=_QgB+?LM=@J9I#9A?O;gONK_
GdLa>5W)J)d(;L#:.9&.25#3,6)OZD8(=?g2R6PCP.c8AH9V7A\WbK@H_Mc8g[JD
K39EB);]\C8=UC\=KK9fDa/0F..8:?#fDb6f4(/AD6_Ic-e71)YB#BR)O(DFIYT-
]fad(TVeFLg64^gGCT>fTPDT4/7(#)YJFA/R9FE_QM7PX^NNU-:fL1GE9[GZVdc?
;V@<1CRE/J-&L)e^^/@65C@A>X0N[@C.+53_=d45&N8Q5fSN1L?:1&ATYg5V[851
9W3YKCDQ?.3-:-c.E2I5O2#2d9/F(gC]b#:,G((@WgLK;,)>),#W.FZVV0cR6Y:E
LF?B,3P/5/;WSf?1@2VNf[^R;]2P,M.S[2ZG0Ia3:L7>W0RZMS\U-gVYC-3;O-T-
_@CHEK4d6\?XaU]-@C\QOZSAJE_](Ec(7Z9E]fg6[+<S\A2MY?(=A)2,.4e=2J\T
A:R\O2[QG=N.1LX2c=:KX\0Edd4>D7K7D0AEW5&HG8F;WCd?^bLc;T/VHKV\+Z1a
T)+_]dEV\<e3(^UbB4G&#WM6C^+S934.;.dP>[aVR+?ICX<S5OC^1Z9-F=?NE\a7
#Og+)^?0X7L8\ZT[DJ+gQ)Ad&^1fA8Z.P0O8EGKQUNcP?T?/&4_IOKO=&AOBTO\L
X73^eMd38#4.-f70NLRRP2fVEFb;Sd?#YKg&#/f7<)_W1=U]BYcBXY9)?6=@>5Xf
,QQf;c_N\T+QH.OWXZVOTR@EF#VF9Mf^RgO_R]e-N59KJbc-1g1_DTI<9+f:RO3S
R[>N@>T>dQ#;+XD[H=49.=TI]P[NH4VNP=Uge2GS2#+S_R6,I;+PgHOe#Y93T-8I
2O^2PSOFPdQM.N81PM(/f.Xg5RF([VCOD2U>Y,4+=:f\BaH&:NR2ILg5O_.Xa1KC
,\29=&N;2ZcTC&PHF^fJ/F+4:[[K[ND.5M#7U6/4&<<7Y9=fTM6[8S[L^Sd([f+.
T,9@Q=bg.c@BGCg[gV++MGMWGTcDLL6/1@WMC8:]g@PK^dMG=8I1_@5U\(D@TLKX
=2\DUFEI0]3Fb@<Y\ZOH(Q1\L:;/:CRa,eZ7&+#g-XZ=C@I#T>g)aZT\dfde?.W^
J95,_2<;<+X_0]I\=]\54E22HLF;>PP&<AME=;3d?]^V026b(<a<5O5SS@JD.P+,
[?;e,>M(?eK3EKN[-BOEAFT@8@WY#9/PSJ.4SL+Sf.D1#Z&8_P[PUI?S&U5#A/eU
c>HR84+N<C9>e7[#gO[^,3)YG_:W:TddTGX#a2J:E9G\Nf,SN+?-HK-,:/4(>_M4
AXX@6#fA1L,MVH_-Y^L:AO?HDE22AD4g?YFaSA^FEIEP-&K\cL2V-b9ZJf4>X\3Q
<VM47\.4HSR;<-)V#G-D6;CHGKa01XG/X?JRWW)S1)05S/7f2B=-[HG<T5[f.PC(
F&\4f676:)#YN46ePa[8:?&;VeagZ=F,@^5_B5,>G6D].eGX&D^fFg03+Na3-egA
0?0LSW5fF_9^F#0[@0fP\MTRVXZ4]V8UMb]885bJTG_&Vb:_K4I9Jb_.Z7,,Q4If
+8?3S,c\Zg/5E0UZb/;4W\]Bc&X/;(&]Ne1L;ME=3?gO_9F=U0H34--N5B87LaSb
J9fJP\0?OY&VG0,PU#cP6,ae\eD@#>(HceBd5P<4A7:LR=<Efe&.QCCIfgD6/]=N
SA7/dY6@e+F2Zf-V/W#/M#U#?HdVO@)@I<@CKUUQKXHQ#&NGRTL4OX7R8H7NT]6Y
+??-M86age.bI]2>bZ0QL=YCLR1;Nb:3L>1MGN17DeH>gUe46fT.J+bQ&e=5WX>W
UN2C?<?.SIb6NaYN&aOGTbTI#\4^?f\+W<KD8;\d5@IYe>&WX99SAQ7(PW<MgT0b
QE?E,Y6IB[J74WZP8P>T_(f(P?Mc(fDW-]H4GF>e+9EGJ?\<DK.&M#E,AUaba@(Q
KAAJ/U#JT?.I8FW\71^e<1O]FA156HP+)9W:-PLCFcI9H_FV1:W#KHX6Y=LeMd3Y
CQ-<XRdU9_f0:F/01ND(c4;9b4gCH^_KTa>M?aCTd>(E3-eEM8d#W)]O0RIGAUVe
V5PH@[2aRSFK_\_+B?ZUHGfAI=d@Ca2bY(:ITe1A[17-US[FN8R;a&S2TH46>(2P
OA85?OX=):JTG4&GgWf(.&bRg:CZHP#JLdUfC^_HXKa_&#Y#?>3XA7aO4g=S7cfa
RH-O^QeC_T[F31H+U1T)MJT@H7Qc[4L^J0=,Z+/B7bQfG,0Q04C=821KDN98Kfb8
LTQ:M44dVSP=DfG_EY_cDK\STPI#0FIBA1DGQfJ(DD4RJ94b<+Vd=NdW2+TR/dVd
)=4;>ER_M:I:3]b;V:IH_UXNJcG<I;T?gDQEGYFe0IJ34-V,O^LgN6FDQg1cG@)@
M&JA5==d<>Z4G_c8/1R.4^L-Jc7^[;,K:Y^bC73-0J#PN>UK37cY4?RGd;dN57L6
7#+M?_PE8E-)(YF0:R_ZLd9+76a+<>bL5-a.Z\DV1V4A2.(9;c0GFYL&,]4OX,F9
13O#\\TgQK#@GXFV_XW_;@S(IVWRS4<4B.LdgV]3A<3&6;a),4aE[@C9LA]RB\_F
0=99MSZ:QAWI&Zaa^6#U@+e,OVfSF_E01M2F4d:6(dM9EGSD,ZK?A[R@^J&e6F-\
I9@?.ZZSBI4)06GCW[9R@Ac:Cf=g_d-_5^4EUCVII;&A+BQc]RQ9B5#F1X8<B]9E
[:/3/FG,XS41/F>U/0^)FC2_&4]+g=-f-S0?W@OJSMB\AO#]T24]5/d;\,9=@;Yg
_DUQSM>eS^9gD-Oe(I9bG86]d@g)M00Q_9>Q)@E0.-:E,(B1B\\UMG1]e=2KDYg-
:D#GHg5Y//4ZP74K_f\IWaD8T#(C#6M<&TWgG>=?ggRU4P\;&,cfN</9]DZ2.IN\
?XR[a121J1c_A-4P=b<@YVEUE+eK)45N+T88WB.eB@B5OESQNTWHK=6PeRcDZAT<
0UIBa\YA?;8[R0:IX6(aK_E@fdF3+T4_6)e_I4,455IBZM,,aX8=<QK8L#-dGH45
(+b^dFI621W^35S#BQ746+8X:ER#DD&15S?[OF(2<K1^C6+1)QBgGMF;#<,JcafX
II:>)1E71-C9\g4Y+NdNQBH^fMO8,UCW4WBDA4-^DCb@RN+:,aX/<TdRVUI?27N^
Hb]DS>/Q>KO\TPMM[ZJIF_cUMagBH0HV@F,+H@_b)#eIF./a-@[-9C9HUe<\P9KP
5F,I0HR0EF)H/C796D_;O33Q,?;U;A7L4,GXB)P4I-a[(P[G,S2O,<DdK:NTg)JC
_<;T-VI.,5W0U0LH;@#UP1.]DMMQ&4Eb@,Hf\-aCNHY7WCX7U/<60BOKFJ3^aG[-
5T#TL#E_2/KSb1WP-T:8BN@PP1K@Z#]WO2/AS9LTU/b85(DE9g_);Cc_^/MH0b[-
dde&2@d/U)+2/,OQQ&e<)#;3P?C&H60LRCU5=&>A<(_)/7Jb678V<<^WRU>[L.2)
?VXQTA>E4KA#7C75NI(:/1(GfTJa8@J[8ZBH+MXIS_=@0PeV;_4V7R74<?eCOeB,
Y7\QAQU^>FGI@3-eL=N6Q=NXO80)\XC0Df.b)\-H41MLd0QTdP[3FK:>-)<e&L+W
@8G39H@PXECH;LfX6fGIUU7@J,QH1ODSB_-<QMgQ+8GPV706bOW(KO6#NQCN/5VE
R.bGTBD.(D<7B2V<6:FG<GJL_[O#PZC96^Z==G6&+Z<7C6A_#]+.+D-(9?]/D(9T
J.8B-AIQ5/>(QA75R0LQV^58_6If-QB2De0<DDHNF>TPVdE2DY10ab6]BE5eBN&N
+6\A::TFP>UD[5EEQE92\MEGDOb(c4N&MZ[:Q\UKIE#4\&1Y<1D-=^]ILOc<X2#J
L5f5-^@X;<e(@QEH71MLGcBFM<-I>/d2UF6FbOfTcX6;#<IU=d;]BMNdFP0XW#Sc
ZQ09&FT+:H=GCK7YHbPM#[,24>><G#[&E8&C2cVBefH-U;C&U)V<KMfF9\7++&4B
-H0W:2A0@>=LP]TN_I3dbD-J[ZA0DC^5V3fV-]JT1;Sf\.66gW2\<\T^@eA.VE;H
[S6.\.)\C@4RHO8H2YVY5CCS[JVITCIbZ4F=WR@);[\2(cM:G[R&):R=8^]XL]A[
M(bb)<0Y^/;;ZAC>#XJK)#bcW?f&E0,6.\IB8cV5fA;6]GNKXRVY@N>J:-YQ9dX\
(^Cge^8PLM25I]U@60Q8.A\.I;HM9Fg?DE=<SXK>Q^GYA(We4C?_:O2c?Ua\[]:.
TG86CW?443/?.=ZN-5-J&U\.YKG5ZeK?B#DNHA8HLWU@b36\=8_>X8OMaHO.4&VA
]H;XBc\\O5T3&bQd)?>Ba2D,D+1_=d7A59ZA_2(L?:Qg?T=Q?G/Ab4&?FQD./eR+
@QfXN3S.af-8<b08^8aJYFUOT;-YE6TB\UDN<(DY[T]R?SI.HIEMdf@cBH1;<CHY
_AXc:1.1P7YC:-@(I+TTQZc)(71R<.S/?+UA3f::&9aN>M(FHN];WVWJH9R8()4I
X_YLg1OA:9H\1:K0UJWO3>:bT@/7D_,\ULd?S>@&R[a3__.@ab6P3XMMeKB=;b3:
>M,Bd;.dZF(&0>5Uf)ID06;OeWPYYdgNS72fB_d1NJ_fW(6:0H];EN1@YK9?0.2#
X,W^\FA@dF,+ac:=e[U\;X,5O:,:M:7?42-eL@D5BK#<#N+7).18#b(GYYRFI+-2
fI/d,BAZK]M3M0JXOI<PH2QUZB^Cc^RS<>2<95L>E]C@>56U[HL>84Hc\3_(:6ZZ
+,HIWI9EZCgMZ&FSA:f-0a56CV/);d/dAe1cR&HZ>bDSH)D/@W^=9:.1;H[G^^(8
OgH.H5a3#XeJ9ZX&dWc-QU],,Q^b#bSa-W0@HT>67:,62_MGX?X/A/7U4DPB-3aE
JcRHGP)CH\(:8X9R,LHGA_WdET7/](YD0Y-&BRD=I,XJIG6SD5Q<9AeIEUXaAGb>
J+/?G+MdT)X=gU&;(N)^K4M^gYHD71CaMbI4a?E9Eb[If=_0603M,K\TA2>6TF-e
]-+<DV+V/?R4?/e)E]VO;(VSI&>Fe<]:U_fFU77[]RD_U2V(MKO&JD,L2XTCP>?[
@,L1)B&=]I06C/EMT@S]5S/_U+UfK&X_aHQ->a=.IKaF/ET_If<eBT8#3\L7M?VE
Ug:KZF.UHZb/THcL6Y>I<KW?QIXV:UPJJV+#SSJ87D,bDM#cU:9O4\E6/KG-d(;K
.W(d@T8:\/^S-H3<S(XYa)IgPd2MKOcHg4K?dFH:T2;C3K;A4KZ#)ND59;.-0HEA
6a9V_64^B9b;ZUUJM,f,J7gI)1dJ0]S&<_N1e9_(AV&ZV\\U,(7Z[MCH,8C;^-eU
dcdA>@DGWN3)&.52&_823K=XB6^00QePI&GG#(<5J=c)-=1cHBD8FB0QLF#g0DaB
dafC_AL7#R2=5YNf][c?M_(+Q6@AKP&T])b>Z[LZ&TW]:7C=&2[080L..^9<Y[E6
ZG&?A&Ma2a4C,C9_AfL1g3.Qc89T)^BIZRF@<&gHN\_Z#B.Y@H7FC[0_,(K\-ddR
B2PUWKQdOFbLQ&eOI>;M;HbOTHUd\/V0/?dW=Cd#RgTA^,cGB&Q@N.:+&0Ca2GYa
NK_TdMQP>:O[Ob_cbN1QG&b^bTgT=U4ZGR?U\6W[d[SIDeU8Gg2.?,<^6Rfb/R]7
d3.0QDFQGG/]F(g[(WQT+?D;BJ\;_^QJ(=ag59]b;+EQ#Rg+e3NeGdP:d/3L3JdB
ag&#V7CQFT?6)W<FRP52[.@YMD,V^_:U5WcYCY,Ib:1Sg9GPWa@L3S8QRLKG[:BG
&dYV+N2@J</2@,D2-]ILYgUQg)#H#HFML=CU]8W@_+-KZFWc:W_A0aI=UC;B9J6T
-]@a_Z0739JJ1LVN8d0##?DYMafJ)9F_a72_,0Q^bJ^&:<e745^:78e4-(Z5X^I;
YI+TgG5][8BE83W=@/0[g0T[2A(OgEfF^Ad1PLD(?S,1)SbN,M0D(X.,?Wae<2UM
)FD5N8?)O]AcOL_g=e_T@9DDA#@N5]23KIT[JbP7U<ZN@)Bd<6,N>?2-4(7b68VZ
dd7X,F=]IK^,VCF?H.L0E-A/YZW/DgLLGfGD\).cL5O2Yd+CFJbSCYLM(?S982Tc
BeNO?<G-@M2F\PCKa+=A1TSYQ3JbYa?X^d1AX-FD<APaR9=C4N6F@NY,IK,[HXdf
1LE^FbQ(AZQYY5VIT8WJa^bK?X3MLT5-/+fKD=f,IZ[GW>-c0\]b9VE4[X&)<]S-
;#V@\Ia&dW)KJb&ET>/@C2]8:Bfb.-eBbA?-U\XcDaB[J7.4)cI:_FgTA^)[]:X&
.5/A9F&Z>)74e47GFK4+O:2_7cb8b\Z.\4JD;?+LPc)bW_9#A?=6R1Z\#RYBL81W
@Pd9H->MKWaTa]2Z(OV,0F?E16M;42B.g80.FS.Z,/RRYLIO8ZJ8G#I:d(d@,89]
a(]]^@@U0+P&+Q4T>[4LX[@caBeW;65B@T#.QT]<&3Bdd=@1gIfcNg-baI/H<,&^
\Z8;B?QH-F&bW#g98g48L@1Oc6c87ZUNM+[W^P>K/2ab97RQSLW.ESR)#)+2c518
FUNGORMG\f47.V/gN=dGc>cO@e_Xe=,[(00aV=\)HFX>a@E>1aELc8.H#WR,SP7A
&)30HC8EQ73U0EST#XR<eA2##P^UFP>g:?FcCe)T,FM_@XV37H7,&@W0:OBS/R[;
?OVFO5KMbcdR>MO9+XFRgD+HbVS+SWM>)SQ7^[^G?GU>@X&6+6-bgD;EcIO5de.<
8@@_C-EB/D[DID;:DU&U-]f+VeT8.Q)Wg?E]MfL6@[<0],.TO<YS.G1g.6D([OF+
+_KTaN_feK?3(SDfZa2DQcIOf.HC9N;1X_RTH]6U80BZY1&\I.;DQKB+B^X?SDND
d(;.d[RMed<LeY<_#8O]5/\RJa-gOfKROe^19aFS5&9bL9V6\,[;dAJ&fV5J22f+
6/CA8(I#Q+/[=UDVH:SX3SI>W0ZMAK>KSYRg(:O&Y+2V;)NeAQOg;Jc#fSDaFPNB
UPATOB?39;=\/:/J[C:a0=;#B/M)#R8N)g#]]_A>T]1MN1+-O;+:Ae0V_.WX#3Sb
ZC&</SIAA8Z#5952TJOgg=#&+KbGEYbQ_GFBOZ->OV7fJdeC7_>Z]bfT(&/:F[D<
Kb)GSEEC;1d<IeMd2E@SaUD3PK:AJQN>#CS#;)@1P@9(LD,B&cO:@W:K?8:+3&Fb
MN&.04PZdJ]5H_FMHUB+KS&H-@]TODFDX/#^VOY4)_JIUU45A]d98=gTM@CJ(YT?
UTXEgH8-:\/@#3<2XTQH6_fU[>E8DHIB:3C/LaRSEcB2e,:AU@SL7O.=B8@=^#P;
.IM)LSK:U+-D2K6K.c(V?F>dQ1/AY6Nbddf[Qd_60@5V5J.4<MfJ,J(RdKIPRD+U
IE6#&<K>(f=gY5>[aKAb9eJX[X,d/-XFd^EA<Y;T^cX56S7)5;+)>:c97<_Z,Re3
#6K8T55^cEZLWEEa=[BGA[[S/e]aRLK--MZLF\D=&BQN2NPb\#P/eEJE0OM=_LZH
HG2,2)KXaTQ/BM<=gIK)[dA::0B<S65]FSMCD:a&R\eFb0&OYG)C9[R>gYJ)>OE^
c.IX@M45TI)>P@(48OPPd1076XCUA_[Z7PDdQ;5@]P,D7be^I=67FM/FE3]C:2d1
c@R.KG[FUIBA09L#6;PKAgNB5)R;&d:?,LA&T/[&7V?MWOLeER^f2>:VE<33b.5&
1g[TXW&-&WS;:]0Q,OAO?SSHQJ32Y=\[F],eZZJ[24P-K=E,LB1.d6?/LA+590(^
W/Y1IDA@J]@DBYM\#AH1O#/<gGNRANCZN+)0ULQ7\?G(,1,8Sc>6WFT.\fP\eQ8U
Zc.=R>2R]3#9VUDAYR<?03B++NBY7_1N87;I#N>_[dC8<a2:+6\GX\UVT/BVK&dg
3Z7a]ZQKK^6.a6-G2?/=+O)Q@N>6QWFTdC-fHI;68N3Y7^;=VXY1bV#^.3f2,XLE
D^d_>EE>JB6YQC^.&/1F^5dO;WF\UL60&TUeeN9P4(U2V0MKb6G<W<#f1G6?O0WO
^6/2TK(-a5F+Bf?NaNHH^Kg@Mg\S>bJa+cK#LQ3HX4f<XE(KT+?X)c(D<#)/IdTY
MMS)=9,SL8ddWMTL505Qca8X7OC6\DBELGHL4c>BbQ[-XYI:e_]L2H=&fFUDTFd@
TN;-F-KSEN+;DEMBSA\6[@fc3-5:GXc^>KG\]==K20F)dZ.gAUag&K8(fK;,G)f(
_=O+(:I/;V&7U>c_Z]2S#691)=bbM(QgKG\CC16I?^/D[:(eZF.OV=CKS?A+(O<W
(Y:]56BC9[KGCf:6Z)T>9W&I?0\fbIXS,L]X,8>0B.UOdK#PS.#RV/WPJ=^b;S^9
fP4)9L.#,02Y_A.#UC4^A,:;MgL\J3F8:>YWQCIP0eA[T\&\eNc?(8OQUQKed,]1
g1Q^JaF/+6>&3J92LY99,;K9cb?2]=_\.51^VETM49B^T>g>LFJ6O3^3QKV;^GZO
dMVY6-0(,.g.SN)W9dJJ)M)/N&gfg30(#Y\H0=f8PH&8?NFKD(__W)H;OZ-R<VTU
SCc9;C4UaS0KAD\a6RB;<F5AR>[XT7e=IH^7W\b4G4>=Y>Uf?>=NT+gQ6U51-)BR
bYdF,P(V8#35ZE(cG:@(EcPO,]>FU:#;^C3:#SBTe&99#/\)AO8aN3(]L2[]V>=3
]-8/25g-=c4^9:Y[)T]Kg(7:=2JO)c+g#e15@#(&9-J2##\^?Q_(Z,HdV(<Z9&.O
b7K2N<DP(-2Y&=T:B+P.0dMB]RFgZD1g:V3HL^e2HC8LP5dM3]_#[(CG7LdNWXbZ
LXIV(P3JO+><3MGG-S6@bRA=XCEg@bKI]Fb-Od;1_2gA(;BdWSBb>F:MFH@C]:8g
AU69X;NH4MYQJU;7(,f>gcQ>[TL?:8dR[V?Gd#LRXAWGI=.fKJ0bfA_>bXN#2-G#
4/C]QRV0cZI)Zg,Y+\,\(PXG<<H>L1(C8a@H-CRH(-f^d51K)^>:AX\1:?A3S<[-
ZKf5Y7UP&@&@3M\5VR<1gXffLTV>B^G-Wa1T)YBDYZaGZdC/K]DMBRK0Y[UX>;9V
M0]@1(EbCVO?INA;E8A?P\e5=QLf\GF4OD(/f(_KOCHJA+c9[c:F?<gCX2U?;Xa)
1gcTINU?>R-DV_J[3#^aV5I72M)&dM;[TI/d4dHaO_+aK))=A4U;HR\]e^g2b0fg
0UBeVTZ0?Ye]Tf+YG>J&8V];)&1\\\[@\.Z:-DaN86=E/SM2TWDYdR<^>/g,BF])
_b+A]P/05):/5YFag,X16GFV,W>0:;Vd:<K>b^caC)S-RHCP:9cI9D>TdVKfAR0R
1[4G&Za[/BYG[a1:SQ+6U:^9,,HX6PYVB[S2Wb/8SX?/-QN.K>f>gc79&gb6c6)P
-T>MP9N8;HE@Z[+#6+1FM30[KF(E8Ff04==(b_Z7H_#Q1:5gadQ/K0#&bbX?ZAbH
+]5A)#>Q-YLXO2D@-ITK(35];a3XB9EKGa<U>IP7:Y87^J.MX&:f/L]Md8N;9Y_a
,,YQVGRS(84Y=ePB,[;#H;1@I9UG:1EY-N:;@91[b6;].)(Z@ZH=-<PY/4e7\HQ^
S9<H.<,B])I_B,g(DA=^XG:V>cc^:F4[B=N9GgZBLd==[QeYR0,::=^B&3@.g?:I
?L9/>Z53a]8EF@3<O<XVYCfeEd4HaFeKSHX6JIF3&/>,9@<L#CX+eMCeQC&7LJBT
<f#5PY+8[G.T3J]8Eaab:_--Y2-a;X&Ld^3[5@abN&#;QdF58&d2G9A/P2&7G3+#
3M\@@BOJBKNE]3KSa<58Q]I4Qf[f3bWIG.dQNZXCK#/GK5S9GAcd(e#cg/@ZYM7a
Rf7.cO[7d.J>^50012E^:&3;6;f[3\4R4C.XLc0MQf_X)[,E#U=4H0O;5VL7bbAb
OK;,fFI/GMNAM[XR6H.Zc5.EW(4fQd,23V?)A1EJdHZBKCG)]IX,HBN_X0FUYE#.
+3W6)]Y<U8_V[\cD8YdG-72N_dX:HHg&TQA6,_[H;Ag\JLf8-@6#M:?NIDCN17<C
8Y,M()V(8M4)V>WO:Y9,=+d/6ac#aK[8OW>;([A=C^SU?W4\601\=P81[64=RD-:
V2([Rag1-d&4_H_:eT.ZN<FCIgD&5=]=:L?R;.EVa^_gA?NH\OFIN8;,GYfVX72b
5\]K>,gV@WXF/#-ea-2>#RVOXACd=08O7U;W_MRW^)AOUKb^J.EO^Y-^881V3R)K
+]4YZRYeX6Rd7G7Ef14]OJZC&/&:g/>Z\ONG./,4aW]G3?C#e\0;((UeGMF56LS2
8ILe/e(0<_7e<M?@;eE05c/\V4ccBN)(\[E0_0^CJT(@9ZY:LQ9RXQ#U+LTQ\0B/
O)KPe5T<)<\Cfeg9D._+IRJ22)4](,Fa0#,_E#9E&K-[eD1[XC2A]YODK>PgF5e(
T6Z^(#F,Y3dOQ/Gb1/MW)cC1:G5,TQ6\2[fM5Dc8]2U3ebg#C79(,DAc]69ELZ((
gS/H[H(]Q)Xg:ISMQX\Q<6Y;>O90HJ1;K6g)[3fgR\./Mf)C-/e\[?(9R=<X=,.X
P]<&R#.2\Ue<_JI;^&D(]B@WO^OPD]<d5VcLa^C,0P-Vg/C]LE4W@;S:\(fE4UP1
K&P6@DNI:N/>GWf_a4-XJ^=IGZA@3(Q]H2bd/[G=fPI=.N0b_ea=1RXF34K9L8NY
>Dd:Bag_7C/:Ce>BC]:>/(#U08B3JIC,cb,a9CgDBBGc:HYPbV?Q;e.f5T-R3>a-
,+D8FMD)VX_eE[@0911HBaL9CU4L/H+Z=C[[\1Q]1X]U?@d=g9V,6@3ZSF;(YUfV
?.LV.W=SPNTF&JeNDGCA-NL@?B8V8YG;5\??b>YI6dCG&Q2^S>[5R8e4@>R5-W2_
G-,0J^_DKD\_AJZ+AMM56TT@f[JKNZ=,b.0HEL1.ULOfS;8N6AO]>@>A(_,ZZ.AL
0>>K:C59GB2C>&bF)ATAI4T.L/&_f])4P]F_P/N.QNe=gVN1VA_@>:&g@3;EP6M0
<2afM1N24E<ZAN.UJ28,eE.YFdT?P9@(N,3e;aI_J_[/Q2cdF\<NJL>+N?Z#XRL1
S>/QPKUF1.LT+/&0CKI;0)Z>E@_]^.T(C7XQ0H6\O;RYX/E3B^\WMg@WP&&?:gOU
7&J3GaLbQ-B8WE^5f81eXQCLf,A+=-+2KM).&_]TVQM8[^Pg[WRFDf\@Z1ce_VKK
GC)PPR2^:_3N_0@LRG7g)CK5@QPR&YJ?c+fg[DFT-S)J?fYT_6QI&eZ7I3Z9(KQe
N.d8_;gJOFe#80^\M5F-0_-VW78Ng&b#BS)=@(:CA6.]-=;J&CG+.=0=]CR^3O-&
>,:cZ&9M2J#?@U=eW\]IdW)@6<65?dUe]=C7;Te5b;<=,+J<DI@B@>GMOePT4PRd
-<cFDCC;[bfL4Qd(U+AdfIOZ\cDT1;Q=95W=UJ=;c?KC&?KF[JP#Ga.\>[4K-9a^
T?B@gIF3@?;K78=451J<5fC=[LEFC:aO.a]Y/3K3G9PR3AcI[f)d:=F]1KcAA7G2
=B(#7&Dd=U;GD5Bb1[=RB^G\AJNe),9FY5ER/<(TONZc@FXM+M7ES_fS\&=^<OUU
4IQ9C5SMPX\MU0#.F-JK@@G[)P-/ZLZKCUPG\:7\^P^QZI>2FR-.c9dL]6_5\TVZ
H@@;+a;d&<EZ7O:?,,)ZUDVU_[D=#>WYQ#)eXHJT1ZCICI<MXFTG;2:a)+F[bJ6?
Ng_\5e_M5e5/X:[-U>bWY3cI/S73B;LCR?M))WL2621^80AO9<6,77bAB5JaXSMS
gfNJ85>5F9[T@cbRVbTG@0SP2388D)\00f7IbL=/7K^Tb]2g\/HfQ>/EP:09W>N<
Bg[0@FW@S9^=[,?U,cRC6c<>=G661&4DQFJANX)c?=(&H;GZQ=1-MVQd3LcB;JU2
gbHHPG#7^P;DH+1-I^_-^2G#T-?=LH?</b;.f:9Lg=5Idf^E50AfHe>Y(RL/9e4-
gOfe5Q6.<,f]Wg]>5Wdb/:d_R.[g@IIcA-ICGK3#6/V_Q_QdZ9T+6Ya^Q7?O=@<P
&]S<T272]fgI&0Y\9WNe>?S<&M;f63_Z2Tb#U&gKQeG-7XJ)RT1+>JNPW-a,YA0,
W0QH9;gJ)-Y]&<MS(]P9cQ2-283WZ]A>4EUaS=J\FFQ\]<F5]-cKUQDM;O<V9(:R
0)g7/c1^VPRJ:E3cJ-FfWBGNR=3F[GS]/-L.P6U.?d19:1ZMdV/@6YVFM<KW<S#M
UB,Q3HbSWeFW,GF;CZY0B_7<OU1N]LB\?NOTJ&F1^/)6+K9J1TPc\X72g55b(5N.
<A@6)Ed==RI.bJHE#TbFHF1@[DQ@ce(G/#P/cDg8b10I^.L#f2BAG5dJ?cT/>MgR
)Ta<W6)WNA&]6F8=ee94B^e_]L)^GKMd+S-VSQ<C5#BTMF3?Pee.N\@A79-V[18K
CVIVRXCIe\d4F[0bDDd9:HEefVN(.^K/2CDNOf;..CgCF9UT0<(M_-T61Z4@B)Ua
<IX)W=bYJ(?6>>SI091(af?6L\BLZ-P2e=RR(eEVZ9B>I[fK/TcODaR3Abg:>QU#
f5<5]UIF[2d][_<f)Z?_.R5^I0<C_f?M03;.@RX,1fdP6Z)?>(ZXaK\,3R@26,]8
2L>ANR7A@LOKV_ALZ>FgM,4INe/[I:&NOb/N]^a/62RG0L,QF8Rb^-0f8CDJPeg0
89eDW1ORgBMTVGIM8W;2P:P,JM.8[QP@,+Iec5d,,:Lc10bPS#)d6=I(9aUKX6(3
LOf._Y-b@&NV=W4=eC=+7B.@Z_Q0d<Z9,@^HGS=2<9^^X-.[Ve8T-8^J:OAAO+LK
7(TWCb-.aI+2_N8L4O6+JD,UMBF=_TBAM03/@N6.6Y#AEc6DV/,L6\WV@\/H;1^S
O\<3)?9G:g>).LP1U[a#>2<R.Y>W3_e,&L&/6VNYO2Vg:\3S/1XdY>GLY[I61=-;
[,Z&9(GMX3]C+/?H>M=360I3EK<A=YG>9b1O+P26gX<MMXcV8A\/Dd6#L_d4;4R1
f1>:8d<J/^0S3J6D]35BUE&C4ZH@J2012&IY6=92V+]EcbMJ-c73R=IbfLKA5->Q
&4^c/(eS7V4U=^N0:Z_N@I93M/XE>F3gH32Z=CfEa[aFK#g4CC&RZIXA.HCe#NU>
Da7<H,<^D]1;IX_1bMWW3J[_[RaMbY3I7@9\?4B/&,II;<;L:0-G_^U^R@6G<<^W
/eIJ(RL_[(ZB,6S@KNZ.[dM4<X009.T^E.D5TC&E]8)<^gZ[U[34SV9O:_gQQY3,
@#&Y7a/4fg-)N&Q.>>c=O=H-K<Qb,0SOFZG/O0/g@deQ81V?:4cf-,E=cZ@S=6JQ
HAe&\:&TGQU)DQLTQ=KcQHCT7<Id\=2)H4,8JBAN9]3Q1AbS[P0P.C3799O:YbcK
B]Mf^_fD5B=A-ad8K:#>;E=N^34IT>=G^MHeE;b]KA)KAQ9ae+G\8(&c&Dg_?@@V
@>+]8&VI,2YS\^43)]dJUD9Dg>]3U)1#8L\&(.,##>f:9N(F.6[>.C:X\)<?>9EG
R#Ce7)b+KE>-_DfJY<M+T.fUJcB-Ab1cO]R&]a@AC?E6QMaSg[-)8]-6ZY@>SLMK
gdCafSVeNcI2VR=dQYV>7]]TVC0fZ5C6&AHS\?-VM-V6dBA+^_<+:E^&/,,Z#2)4
@EaMO68DJ1?e\<eL6-[&3S<)D_@+TV2,(;[c>)2_b;ZU90.NT]JP.]9dWc?N./=f
4BL;.\+\8:B7A<ce.Q>]DP-fL=b@HXJO6X.IA8-@HE7cg_ZBO9E8_7LF03GMT;_a
:.FAFTVa]=0dWNWdLY&CA0bR&7OAEB+=4GX9:O#[>)4U?UfDW#7>gE))/CNaS5Bb
Q?B5C06.,564.ASG#JDN/>XM\E5UKK8GHVL86+X>G9bT^PG-&.3H&PP09Q?]@7IP
66<^bg0]Ffe1Q?fJI3>&PQI(b@HCUDgYdY9a8VD:-7cRbD+<CCFH6+bGGK?,5&G6
a7CAeB.1N\@2f/(c+UCQdEN=^K1J1[a5)3?H\Xe\#L;T/:f>f;,>ZXV8\&CVfRC9
@@^\<MMGPD4_E2A[<bF<:RK86])?C4ZMPNLM5Q_MY;A4D66WK4/5e?\(-H@,PSX[
@gJ\_?NLO?]UVCDP]/;=8fEK[f:CgFB?,CI_If.LDUHI)4OK0NE0XHA#AN_b5OJ3
/gSV))FeGF^A/URHbg6=0c>C1#+Kf3869gM@>N;c4-ZBTT+Z?6UF:aTUJ<VWE>(P
/G&5AfM2Hg/cJTG7AF-/.e^>T4Q@a&1KFfOSHX-.#29TR,@UQ]1a8:UQf):b3c87
1-F1Z(OUe/?VVMddFgZ7ZS;X<QQ0)YWR+[[R>g?g7:83+b+=5)9.988MRI1f9^?:
aCfQ)G\W^1N31g:)PFe8NFe6,CQVW[J_^EVPI,CK256WW_6W]_#W]ec-T@Ff]U-\
33cD-YPcWZXd0[/MeW2KAS_517@XFDS75V>YKg>(Lb+_3aP,NLKge[f3W4QZ)b80
:TeKa)cOW+X2gP(8_@ATDP1+ZPQ:BFX#R_D.H#O(Z74b18\SQ/P9fQfEBfKG9YJ,
XR?PbS:aJD]OKZ+X.1g.F(CYBfQ2)C83NV^:TG4YC5G-Nb.3?(0E>:HgC@g(K:Pg
KTI?3?#6VS0eE0_3RV?R>7K@4B-4U6=B2G.S\-W([VRVg71JT6g:X-IC>=KSIbDZ
@G]/4PP-D9=c^g.C=fN^SNY,F#PJD\HPM16f55YO]V\Z^2Fd^UGa:-2&Q[Z)HWK#
N1I#:NKQ)Z[]61JaHYJ:\;DDAC8YC8GAe;D)a5#P5\/B/DP(1+D?DYGJ5L&Xg6;X
41<1M?K0&2@RX@74U<I?E?cScX3fUIQI+C3GYXc]=c@E^1.4-P[^Q24)ZI&>M:5\
7;U9DR[:4ER_<4_Q.V(<V@)E+DH.#(RVXH;A9P)?c4HCT4(dNNA6<52:KO&SG7Q5
K\ZL4.F7L=Ag16#TdNa)6g#C[G)Ig4F#D3G:CeW(Xb2YWR[[3gBE)C.T&/.12=F?
2<4T0]\#OG:a8M.Z^#UYFJTfbbJ=/(d.5;Kc&I0&,Qdd8^b4ebABAf?-XY+Uc>ZW
WNLgD\M8T0>CM7EQ\OMSO^S1+&fOCa8745N=DZ-]JM[XE?CLdP&BFb0I8#d++\O0
HBTB+:8R0R&@PGH15bCGV<5<0TC<QB8<)N-])?@D9RC=G^f5#_ZQ9O0;XGR4H(5X
<00\=?<W+-^3G9.J6;JH1NfL[<08UTK@[dg(.3,/-0IHJ)e=Yg?AP7c<?&fd.)V,
10g_ePgR:#220(8geYGQ=KWZEgLA9=YHP7HgYEYX4YX7aXOe47H_e-GDM#c-a]Z3
[(W10/SgB#8(Fb]e\Kc12?RWO+]1NSO\F=NU]Y1:Zb.IV7e[a))SD\^+5LPSY&8^
1c3XVU70c4@3XPS7aQ^UaY0TE.92-EIKDA+B@bPXg><1P=QQW_;6WaH&G^-^D.f3
Z1O0MTf&1,EaO9J7Hb;8dR^cBG+6NQ1,C2EIFUDO5E2BVcd,DUE\SVQd=ad]K5.a
;/T&8L)G9-S1CVPQBMGQ#2Re^6U(&XX-+EJJG=EVR#1AQV#7+.gZ@;2d76QUG(S8
PP);]GZTKR4IGT,+:<gP&A-S;^RS^VeJTTZO-<Fb#?LSe(FD<RX.,[7/Y=(V<dd8
)7BJN&?a[<W3+.#(e/SgcPAX614S7-CS_S8&ZTIf#)9=\T_d;+g@dJ?PQJRRYBAO
UcV53JVU&9QJe=_?dH#EX99b6D#T3fENFYZ/Rf29]1EFaba4G)ESHIMd.&a<;PYF
3GRf2;&gPVOQ[(N(K4\1\+d\(HIXVFLA]+N;AC5<90+5/0,V[TfMC5Y-OHH:bOe-
5U]9X_7;<W&D9b/+d,8(MAC/Q<6QQJY8J70CP>XF9-;<Ggf+E5LBgTO;&RJI+aA;
4#Q\AFWR9S-P:^U-;7ZD8B[OC3K0LXIQKK<]EC&8@#?06^EF=DZFTV2B_0GW_gH=
GZd/0,g3gf?\-V;5W9H3ABR>,:Z,TeNX:);#K\?Y@MNf1,+.#=8IQ,:0PF5+PIdF
N1ZTB>VKaB33Xg.9/H9LWVLHRB[-AC22eNXZW1P8(RG<?OA?;]>N0O0?1OK\DG_g
]6_5T8f[^X@+/YP<6-^?50Da60)CL)LP8bGe44-)&-_91K]+2Q>RXHbd+^\V7,:=
,:)7GAG<Jc&O.NHcaD72JX7+=33C#GfLNERM&5#J2a5abN8Zf3:(QZg<KA5LIULR
0RP;d4+-1DFJ4]GZ87AHB^,Y\4c/ZN\;VZ^J-V49]cMO1[3=]^/XA/7(d4&<a_XL
>B),MgLMa/)<b.5^])5>(]A^[gc432<[g0bAC4Q32D^WK+C0<H#M;Ae\aC),YW[d
gbH&RB_\A_I<=.AC>=_1:a+;BI:(KMR-2]-bEcFC;KgW;KGeJ<&8-\NRF+=JLL:#
YF-f/+J0VBW\@ST&1X&fI1OZ8O1F?;IY=DG/U]J93;dE8,DBa(3UV<H#X1@S^QXL
[ZeB\JP8DeIdKdYY_P7^=GeX+N&-)5-SE@:4[EX/<_ILBf3FLK;QDXP=CVef+Z:U
VQ[\DS3YH,=P<&+2-PA\(.[#0;DV(E][6U/Df@B6dF?D8_XRRfd2U3@Ug32JA;7_
5H\?-2Zf:S21S,8Gc\O:PZ&<I;9GPW?^6PdEFa(>LA6R5S>]JFIHS]fF]AA-^1@N
GaNgf_A==Y^Mb,/#^AU+5B(#.\SKJ-X2,g\f;>33&9<N^4N#VCMeGfcHfaJM/(3[
J.//.Q&V?)Fe<J5:M9(>@Y)P_dIL?@=VQ4,L+<W8-&ZN0DR2QdeEF^;81+RB_dCH
Wb-(4.@])C6S7J3OLH8RJ-Z^aeg8Xb3?TCaA+WDQ/[OC3=#=G>Q@L,(LRN4;&&#g
4ZWbB-[E&NdaTda&Ebdd[0^R.Q&_M[F>NKf3bEQ1OSfCH$
`endprotected


`endif // GUARD_SVT_DATA_QUEUE_ITER_SV
