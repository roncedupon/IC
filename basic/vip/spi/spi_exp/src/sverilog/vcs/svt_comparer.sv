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

`ifndef GUARD_SVT_COMPARER_SV
`define GUARD_SVT_COMPARER_SV

`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(R-2020.12,svt_defines)

// =============================================================================
/**
 * Used to extend the basic `SVT_XVM(comparer) abilities for use with SVT based VIP.
 */
class svt_comparer extends `SVT_XVM(comparer);

  // GeneralTypes
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * Special kind which can be used by clients to convey kind information beyond
   * that provided by the base `SVT_XVM(comparer)::physical and `SVT_XVM(comparer)::abstract
   * flags. Setting to -1 (the default) results in the compare type being
   * completely defined by `SVT_XVM(comparer)::physical and `SVT_XVM(comparer)::abstract.
   */
  int special_kind = -1;

`ifdef SVT_UVM_1800_2_2017_OR_HIGHER
  /**
   * Added property which was removed in the IEEE 1800.2 release
   */
  bit physical = 1;

  /**
   * Added property which was removed in the IEEE 1800.2 release
   */
  bit abstract = 1;
`endif

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_comparer class.
   *
   * @param special_kind Initial value for the special_kind field.
   * @param physical Used to initialize the physical field in the comparer.
   * @param abstract Used to initialize the abstract field in the comparer.
   */
  extern function new(int special_kind, bit physical = 1, bit abstract = 0);

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Method to obtain a calculated kind value based on the special_kind setting
   * as well as the `SVT_XVM(comparer)::physical and `SVT_XVM(comparer)::abstract settings.
   *
   * @return Calculated kind value.
   */
  extern virtual function int get_kind();

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
[/g[VcXD7;3>ZJP[W+W3g+L9I3TIeUI;G;KJT5cePTPFF6I_aeX)-(RGMgT622WZ
TAdfd/T:F2B03.,bT2><R#M5@c?+KE8eb4_B^N\Y71[\GK4e;P9R9OKU#TQ:3CPP
NI3UA,MGAMZB^07B7cK]I94+_YbJDeK4_G,Z#7c35IUg@I[+S:TC;?P>JYI3##).
07OR50O[S1\Q?/Y(?HG@OPeG;-\2cJ#=I<YZ-\S9BU)J]ST92\ZB#=T[Wb/B@WH^
8f&Z(,CVG2^3Sg:a)I[e_[Z^@.YP8bO(7=N-Y4&XC<d.Oca62]VAd&?/eTMY:?aW
\EgF(a4e<d<NOGY2J@NFUMcTH:&2TVK]9bK;M[>E8^fIYW#PV,UC\THZ/+LB6/2+
?3QFKS&G4)b;K<:+Hg/aJ,4-dUEHVA;HPGQ0>_?cL9@N6W?M63<)O8X<]BO9=bKb
TIUG3M;<WL=+U;+)>K:d2EE17?Bbf/<fNdb]<7g-T?EO:e_+X.T+A35E4E_TOgI=
0<<)O2\.\?9[cg1I&D1b[LPM1(2dN7:U/OD\fB9I#?[(IR,B9I_f[XH;16M0B[/_
SDO^R2VG_._2(YB(aN#(>:GcN;.U(D\KP(&90cU#2c65]#&ca>,]9ISTM8/AKUJK
DJEW5cI66A69&F;d7Z@0J2H[Gb6LN3W]8R-bg)<\USJ0aN?D_\+0THP49LS+>a9U
IG46ULUZVOKPa1UVC\7YY)L;f^J1Y75NG>?(,JX^YR_PdPdQeT:W\\5XEY5AMYK4
?8RcXR8H2M=C6#SM<J:/fGNfY[H130ee2f]c:KCMSSHMLc^&QY/=.NZ/II/_WRFV
E03UDPP3,@7^0@U0_CY2g_8F0=L.MdN.H9XF]^:Fc^--3Hc\@#TEQ+X;&c(U9Z_L
b93aI_P51La3cK#QK^O3(;_O45L+;@a89>CP:S_Bec3,MZ:a)_VfHJN52L]4Y:]^
J:A[6dW+(S6N#ICHeHQ+(NJJN91QgSVH1/[JD2G76?Vc=),0OYM>LW3H60[9QGY9
^1-Ue0QN.LP;:69_FK<bI_YXBGLPPTW+NcMR^6RI/>CVGf,M@=g.94:IT<=KeV/+
dSeLMf\J=9+WI=WVJ\Ifd&>C.M:&A(?@Ab8/dM(-N]]Ua3NODCab6c0ZcR=4+[)+
89+aU7^<8\dVg0#6OI+?K2;ZcI3fgb)FAEc+2c0[9Z@OC+M4+4_>/@#W8G(KSX3M
J/I:7GE7QPDaZ::0g(dQ)PD=LO-:/\gNA7#01TMVeD0CPS72NTe<b0V4;0GBEe59
d:SY3/98E6L4b/2..]J+X/:2ISNaG^>VOGYX;K>gbgAA/CJMU0UT)4YO[fd\b:W-
V+QV=T>f-77ZC#_OB@b0Z3\GeRLJKEZNV?(e\AF8IR4^_(;UR?(8ege]N?:>RG^+
FIGOC[=6UB9[(CPCRK^;:,&LC&^#[)#3.H@eZ2P(YB:C\Z_e_<H-cg0J;_2K^5VQ
++L3f<;@8&\-S5M_HSe1ODFR(#M4K.(ZVWS,ZJMM>cc-c>g6?b3&6/Ob]US0S#[V
2</f0a7L3#W^2;Re-[>(Me:HSN9K:TDVM4XIE\L4,##_97[4UMfEbV1\X/:b(dfD
DeTAH(_VK/(aDO?]O2dGX6<Oe)P>XV^RY+_V[g.COX64J,2_N,<;W5?e&VR8@9e=
5&WV4MPMACSKTK7>W8WWcFR_TPfS0WONI]0PbJ1;KYgOG(0;K/f\@Y^:\Q[2X+TI
@>a\)O&XN5_b??0M3+(H/d/NOY/:.=8VZFIRd.ZXKKWV9O0(@^?:0HW[[I#g)<51
+DNKa+6TfVHS6g1F?(R_d.V-\-+KII_V\;EK<AXI)O?H=Z-YBa>CRNNKUPHV:aEL
aE[2fH^62C:4)U?GG:\#I6(cWUP.^\M-3O5YCa38Q=E7b>?;/Y/T6W<<GMcYOH.f
:/&8C9F11U<;S\>:.CY1NeD5XVcd#(\Z;7A6ON+HKdE+>5\0QZ<C+II?[\9_<DaR
OUKO0]^:6cY;(2=QN8S=Bag3?R^?\U=Y-)M;[6B;?.8DO+c4e2Z9;VI?N$
`endprotected


`endif // GUARD_SVT_COMPARER_SV
