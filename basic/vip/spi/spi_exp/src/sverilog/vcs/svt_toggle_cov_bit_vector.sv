//=======================================================================
// COPYRIGHT (C) 2015-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_TOGGLE_COV_BIT_VECTOR_SV
`define GUARD_SVT_TOGGLE_COV_BIT_VECTOR_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * Class used to support toggle coverage for multi-bit buses. Provides this
 * support by bundling together multiple individual svt_toggle_cov_bit instances.
 */
class svt_toggle_cov_bit_vector#(int SIZE = 64);

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** Coverage instances for the individual bits. */
  svt_toggle_cov_bit cov_bit[SIZE]; 

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
/** @cond SV_ONLY */
  /** Built-in shared log instance that will be used to report issues. */
  static vmm_log log = new("svt_toggle_cov_bit_vector", "Common log for svt_toggle_cov_bit_vector");
/** @endcond */
`else
  /** Route all messages originating from toggle cov objects through `SVT_XVM(top). */
  static `SVT_XVM(report_object) reporter = `SVT_XVM(root)::get();
`endif

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_toggle_cov_bit_vector class.
   *
   * @param name The name for the cover bit vector, used as the prefix for the cov_bit covergroups.
   * @param actual_size The actual number of bits that are to be covered.
   */
  extern function new(string name, int unsigned actual_size = SIZE);

  //----------------------------------------------------------------------------
  /**
   * Provide a new bit_val to be recognized and sampled.
   *
   * @param bit_val The new value associated with the bit.
   * @param ix The index of the bit to be covered.
   */
  extern function void bit_cov(bit bit_val, int ix = 0);

  // ---------------------------------------------------------------------------
endclass
/** @endcond */

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
gcFX0Y2OJa_#0&0^I4G9<_KYEL;YGea^&-^V;Z02>1(bZJ]>0GG,1(RE;[^b;,TE
.cCDH&,>KZ)&BS5-6_)2)FLPB4@c2^LDdS2eD[c[\cBYb__N2EgXTV4(7&WM]:eK
(_MD?:3VIfD.]]c2&aUG_W4?@]_XS3XF#cS)(^5LL5=]g__9E@,1UUR(#b6MBH/:
4J0Rc(?fX6N1cXFDe8X+(3PW[cU7AZAF^@KXCG&fDc.FR:MNVF<X=W6.\EL)X+/d
ZHbG8UP317N]6]U_=0(73\J<)]DW_\gYGd7.74RQ]eWP:b1E0@fKTK[1?e4\5gUM
W4aDZ@)08SY6DBM,b16:C>Tf/#L.#3_H;/aA.c;T-KWP]7f7::FC+Y^Z?#V/[+b?
FR1Xd;e]GN?eY>dc2DBX@,c:+g;P-@)C3R=<M(@M]-&6<>HdYU.VGT#/(5M\g]CW
(?9/VE32/e-.==2S\EK59U:gdHF7YeSCKRWKcegfSQ4_[B7[RY#aaI[34b0SF2+4
S46YRff[R5\aL#L>;ZTN/@c@QELGM8c?FUe/dZD\4H.1GMQG\LaC^Dg]PFJ:FgHa
OgA<]Q(^NUGE;d3MUZ(&ObK9I;S+=dA/(dLP@NDE(QVTED,@F?G.&-V?\)GUXJ,,
C?<<8^&HF=F0+de9_c?>W@:ULFYD5)DW4Q1ffg6^;TB@f:,01S3@bXcI,K6&),32
WIUR)9d[O#27W8/Q\911NFZAZX9gLF/bgJc9\NZ&XI6)]G=d@c=#1/@6J/TEWE_]
aeOK,4=CM7#/;gJN;H]=33BDKXN];4.IU+F52UIN=-7MV7gIVWM^X_JAZR7cD^e.
SdMJ22/3db(CQXFZX^XQ#<9@gYP[A:V+YRf)dX3:+PBBgH>G7_[B+?UfXWLL#7=g
AT(NMd#G/JZR@M7F?P=3eI7g18_RH5+fe9S8+<DdOg[-eY75ITc.5;PF<N2#D>PK
&-eX\J6Of7:b5>b7#3aX18C9]gb#8aA#QXR\<f8KC9g@a98KSQc;?=dC?EfR1gX]
<_?CgXXU-A)d[_dKO+;U+CNIG]fK\@Y1717O10:[_ZB]VX7;I?BI,,]PbQgPe>5:
SacE[U:X@a://a/3KU>)LRW=V6ZV52f@SQK@X((<K\^?a,_Z1O:_>9?[g\c@<L,=
)M[,L1>@af/IZ+_@E-,@H]C.e,;_VaaI?eg6H\MY_^J^/d8LTY[Y[ZCHWf&BYHZK
f@)4.N.;e4</6:\#CD(NK#<A/6Y>>E]MR_3K3U:X78=--E)MWa&-<6;fU15ZERbK
Xf<H_ad2T)7T(WA8_&0U+M?DEBDaTF.FE&O<c1FA.C&52O:6RCfbD,\IH[M_JA13
fO:ZG:a):^:4AfX1POG?U=K+(\QD5g?B=+OC6N#5/f5W)Z@+G-@]VgM^.UcNfS0M
N0++J5](/9P,fX)J&BRJ5bJL;-45;PHLT>,X[=Xd^=6gCGB:ZZIC5KEVB:2/0;f4
J/;MV^V6D_^a_.:F^I+7Jc1Y:aIA9[EH_Z-Xf.-fTUILO@OV:1ZC29X89g?I,(I3
(K3ee^69.e5SCC=</2IY&E_6,58]^[?>GK3[0/+RZ)CM;Z.]7O)Lbb<W-/D5eD+1
K6<?d_eZd5)2dd-egEXO,Zec5X)LW^T1=e5.JWa:[cD&6+?QUAe/JZbA6F3DC.Ec
WdWf/W7\FHLd\J3E7c]cT,]gD9]/dJN1P0VW2=XNcX7+e#E.Og-[[2NIMN^/U]bZ
T\Qe4=]<ad+c3[6K:;HfWQa>gS1[SFLJ1L,MUD7KJdB8aSZQ?eE<1=09PU[RBHWB
bGSCTe1)f@VGY:C55,EQRfA#J0[?IXXG\&a218#VTYSAIQE_H)QTJ4++0Y>F>g1I
<NS2.&e9FfER6T7#Z\PY5e00MP1dT<Z+?/(VE>A47d1H+J#ZG?X?J;^8X@3JGAJP
c5QD]b@/#e(8]?^:Jd.]\?g7N/@g61XPD@?,8O0TBS0GSe-0Q.d]+MT.Fe3aM0N3
BI8/38R@SPC/aJM:32//D9YL>^94J0fgW4QZWL)UP[(V_Z2&(U>Hg@[Hd[7dBCM:
B+71W;/Lda);MXR5:VfM6,XHd7V3XMcI#J=-3dg2->P^H8HgFT5]1&AQf_+T>RO#
,\K:gM]Y[QS0VC83\HF9b5S@MKb.1.F,NQXJ8E9F\Dg,0<V8C/^MC?QS<,AG59T.
MbLQI;2^dU)fK4/@BO]gD-1BO.:Fa?_gb9IX8N&KL27YM^TI[Ceg&3b@2C]B&Jb4
NABAe@I)1f^MGeVK^&A]T?9BW]d4(T&3Z74U[J+461EUR0E#4VA/g#/Lfd0gYW\a
47+JDR-ag=M:>C^3+^IG4/+d<U4N2GZ\a)Z<,W?(A5RF1RbCd/0LaS)RLE^Y?(8.
H,gAb_:J@M_fNIN#gGRNaQTNEMNaG52D^=Hb>9YcBNFOFe1+b9FcG:CIE2M>A+>I
XJHe#\Y6(]eJ)=J\&>B.[SD?X,;Y.S&_cVMPg44EJZ9[0E\S<U)@[7C4MX_?+HA#
Lb(74NHcJgKcH/-AXY.?+FF4LPHYX:4M:JFREIc3AT,VdZL,HLY(W7M,=W2H1YL9
:bHa^TW9SeQ6>+4]=AQS4)=5Z@@-DP95<USa58WJ,\db<:SP+EHQH8-E6;;N_Y:5
+a1W5RV,Q2R48e;R[d2_MdU@[C4PI)K2<VVB6@a8_W6,\M8Rb6ZP;T(eQ0Kdc51/
F:X(DYbc2e6N\]U>-#5KCLZ#J\>=-df1VF+NN9;\3Pg\d]^>G.7c_dgT2.bKaS5\
3R\gYeEGP93bQ?J1KaM3]Z^VBE0HZ[NBe0V+WGG-Ng728[G0]W(HdZ)C1Q&B[JG:
U<XY)SDT<:4b.$
`endprotected


`endif // GUARD_SVT_TOGGLE_COV_BIT_VECTOR_SV
