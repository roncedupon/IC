//=======================================================================
// COPYRIGHT (C) 2012-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_RANDOMIZE_ASSISTANT_SV
`define GUARD_SVT_RANDOMIZE_ASSISTANT_SV

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(R-2020.12,svt_defines)

// =============================================================================
/**
 * This class provides randomization capabilities for properties that the
 * SystemVerilog language does not currently support.
 * 
 * This class currently supports the following properties:
 * 
 * - real values distributed within a provided range.  The value returned
 *   from the call to get_rand_range_real() is controlled by the 
 * .
 */
class svt_randomize_assistant;

  /** Singleton instance */
  local static svt_randomize_assistant singleton;

`ifdef SVT_VMM_TECHNOLOGY
  /** VMM log instance */
  static vmm_log log = new("svt_randomize_assistant", "VMM Log Object");
`else
  /** UVM Reporter instance */
  static `SVT_XVM(report_object) reporter = `SVT_XVM(root)::get();
`endif

//svt_vcs_lic_vip_protect
`protected
Q&0N1,703\EYM3gb8eBLe/U2Q9fAfR3NNJ_CbQGaI;]ZQ\BOGaOe7(dYd6#4=Y(#
DOV=L;/db4Ne,Z5L9/M,[\)ODMGYLKaf,,Ua)?+EM4?NU0NV&W&C9OX>0MXV[HcU
Z3Z7M@F21IgPT-4Lf(D_,TGO2(G(IHd>\YN-:#/+4_Va;O<]&.3)f4CX-HULK91(
)NW<ZV0/Md--U7,Ve;(IVIBM(I[[E6JQ;@]E<+3^0L388?a?]3c,.8,BRXO2G81V
<;ZH)Y7cJ);39NFAO,^4NSPCV3I7^ggM8G9Q=X1Hc-]<2P-/K7,J4<-X4U++I4AE
;(=cDI-/>JBMA.<fF?:-BRd8891=VdcP);;MKE1<(::\D8,/OR274Q&<e29C0E\@
024=LAJFff+W,Ec(\[N<Lg)U@9=<#g9=c7+Q]K5a71&XTK#5G0X6A\J6)Y7@3@Wc
Ag0_Q(B^SM_[>Od/GP_+c4?H)N)V+D&d[M.DK+W,[/c;1N=J;.d\Ed=(NJT/S@BI
DaT)(25)7=SUGC7Lb#,W4e5-OW46SRK>S?W[<+=fR-J.13@,X8WT^&^B>X\JEd6g
X2:9M02?f&:5Q>bLEIe_38P9CPF?gdQ2WKC[S-_A7R>IbE8V2[FBZ,edN3O1>.Lg
;Y:#fUgHSI=OZN/2_6-1Z;8>OeP0f@ae]=MYQ&6SRWDER-BW69J=N1JI\5X_V(N\
HN,>7X<^;gdKTOJ:8=bIU<95JZ59N,)g/:=-DA^SG-Z[Cg^\gI4<DASeBV9(TCD<
Xd;-X^]=@C:KQ=fY4L3SdOe/-eeC.S<AYKR-KE-MJdA]I5M_SG<[K&/ZK^YK7<W&
W=(5g]d<?W-GLD-gY<1b80fOZdX4((+@<a7LDR4WBP4d-C,@>V9&.>VLK/Y[e<5U
.QO7SQeY9-<D4cK[bA?DVa,Qg&XW=S<E<K4aFYNYI&K7^\L.RFg3;1a41O=C7,P^U$
`endprotected


  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** Constructor */
  extern /** local **/ function new();

  /** Singleton accessor method */
  extern static function svt_randomize_assistant get();

  //----------------------------------------------------------------------------
  /**
   * Sets the distribution control for this class.  These values are used by the
   * get_rand_range_real() method.
   * 
   * @param max Percent chance that the returned value will result in the maximum value
   * 
   * @param min Percent chance that the returned value will result in the minimum value
   * 
   * @param mid Percent chance that the returned value will result in a value that is
   * in the approximate midpoint between the min and max value.
   */
  extern function void set_range_weight(int unsigned max = 33, int unsigned min = 33, int unsigned mid = 25);

  //----------------------------------------------------------------------------
  /**
   * Returns a 'real' value that falls between the provided values.  The weightings
   * applied to the returned value can be set using set_range_weight().
   * 
   * @param min_value Lower bound for the range
   * 
   * @param max_value Upper bound for the range
   */
  extern function real get_rand_range_real(real min_value, real max_value);

endclass: svt_randomize_assistant

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
c3D=95/6gK6_^=/?L7APeMGWOK+HQ>>D//L<N9=<,1@+X(?FSK-[+(]&D5,C;]Qb
CI_N(;TFSRKg:ff@Y8e]cdD?4=Vc20b.BHe&I+@a^W:,Q[Pe^d20EO85FDYDBT@X
7R.Jb(-7X\+^K1F,KDCRL9DV^JX-98[:TaWC5ZXfOQ2U\>/2:L+L[NH2dH?FP7?8
Z())^Z#?.9d4-&RVEQ#M]Y5K]gHg3dJ>Yf9KNDM+6^?R.<aTCb6/;Tg:>YPA-,[M
D4aT0A]E[BHL1>[d20--TNXWUae.=JRF,bA2#WX@I1cd-J=_OWSZGQd<6a6GU\Pd
dP;\Pe[FY(W(B_S2#>EA(GO]+MP-P;RBD?@&gT1QX2g\0?1:?;O/>aQ5<6TL6IR+
)0]#(M^&:MF(MB0,cJ]dcS2_6VMbe+#>,IbQM>/Q@?gHR+3,Q5/UBWZc2D2]:+6,
:4025FN9>)0>V2[R#N^TKM4U>Lf<[G?-+@@?IY3BfM,X/2_0?PD:TV;eTTbK,NG)
a,Y>H9X1>C).=/NPQ>E0L&W+8Z;ZOYfENFU)F\05aXfYfPf3abPg&(f(DVf67]07
eOZ^@U18>\02^659>6NL1RYJ&W?_ACZI,B=OT38<^Y@Y51I:)YI&GWTQ\F88dU5W
NOM3eFEgV0E1U=MYa3a)^6>-JLMD]V6X+3(>M:9H7#N9XbZ)=&?YO,]TR>+BXV&,
Zg(,>D<a0^4HE;SE>1)0(Y6V-WTXg,/aPU>?Md^,Md[0EZeT3,ID9&1Vd3?J9GXV
?>0a:[M.8XC/L>PWJ8I@5,cR>L?2-H1>1TU9OMVgegVXK^eMJe,HB#2Qa++:[88)
TF[\=D8Na?:.a@42.#S/BZK)YZ#&F-Gd,=V=FAg.b?D?NUP8&WZ]4.&/OKNU5.NJ
2^-#/:?132NP<1ffG_\H40gW5&L)6HJX9@@.dVUO1[0C)T.F>S:ST.\L6V)f@dR6
_V3^JX-G\\,dR3YcL2Y;<ZSQ<B^(?AQ4f6[1C7]_(K3fbDL,4K-Y-ZO2@g:fTV#@
,YIJ8(e4<_79[Y&LEKTQQ>^0CQ/<P]RJ,.6RGZ6Y3=..Ma#\\K/BaEL2g,4.HJ0\
W\dd&)2R]=0b0+cU#V6=EPd=QH3eFef#SbCI]F+73fYEa<FCEVOY6+aZ2:]K.QK1
1P)B-T3#d:2NKf)bK+?8;X7f&-B>HdZ2cFGa2)[F>#fB:7.:QF6N9.??)U?d6F?&
A7GTB5BTRL#8>]Cb7#34;K<RT[@L<T5;#8;3C2CPFS)YV:#@C1-.,A0^BQe&&HAT
]2>JFFSCA&eNXRgW;UbPf9T3MYH]=L46<P4B?HYDDEG9?=Q@G@WI#QDD/E;^VNee
W]OTg?-RB8L[2Ld10/,@fNc)1QF\U#K;F^M5Ia]e17KM;3e4aDA(8dO(I4GP],]#
V5\eP?(P0HU]N,1>8G@.+2?+,7[f)cfC&b<U1d8\UQAN,&WQM9196;b]9M[[(?V:
?2DLHI^_KLT<LFNYE5.>EdY.2Mf=]g#2N-]_,-IIKA?;Pa/,7]IDgQ<;G5MA@7dE
.D&Fg,_3Z;b&>RW\e1:9OKcPH^[BA[:DO^faa8VdBB3U)0TF3]eR(#cT3=MVS0YW
a4bf_EHR6LKODHU/O=@baR2d;WMQHR:c]:a>\SgBA,9]#:(^?;(EL3^J6+?X=+3.
:+f7RJB4:8^S.4N:YcSIV@bNK.>)R#M4D4#),M>1?LT(/?d<X([G4D/O(b1VGIDb
KWY,X0HRYYD?J4gKeWT]L]_(;WS3aGf->7c+8Z0,J,&5-VBZT4+Q:&<8;[/T(e(-
]+VB9\)W&GgO#b/G,#CN]/QJ00\VR=6<9AZRa/8C3X3D/Z?C>@d&c.3(A77aCT.S
_@JW>=Z^O]HUg)AN(e#e4,1gCGI,&5_?_Ic1b[NeW7I+R:F.?#]10;fB;,(B+g[4
@A/F/?G3WMKEeYE)fLZO]-^MRNN2bX6eY6MX3e+3gEP+D$
`endprotected


`endif // GUARD_SVT_RANDOMIZE_ASSISTANT_SV
