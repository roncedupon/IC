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

`ifndef GUARD_SVT_OBJECT_PATTERN_DATA_SV
`define GUARD_SVT_OBJECT_PATTERN_DATA_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * Data object that stores an individual name/value pair, where the value is
 * an `SVT_DATA_TYPE instance.
 */
class svt_object_pattern_data extends svt_compound_pattern_data;

  // ****************************************************************************
  // GeneralTypes
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  /** The object stored with this pattern data instance. */
  `SVT_DATA_TYPE obj;

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_object_pattern_data class.
   *
   * @param name The pattern data name.
   *
   * @param obj The pattern data object.
   *
   * @param array_ix Index associated with the object when the object is in an array.
   *
   * @param positive_match Indicates whether match (positive_match == 1) or
   * mismatch (positive_match == 0) is desired.
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
  extern function new(string name, `SVT_DATA_TYPE obj, int array_ix = 0, int positive_match = 1, string owner = "",
                      display_control_enum display_control = REL_DISP, how_enum display_how = REF, how_enum ownership_how = DEEP);

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

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
  
endclass
/** @endcond */

// =============================================================================

`protected
(T0/.c560\cONbEW^^CNZ^EDBY>X\4/O@\D8a926IcdE>gQ.Ke(+()a,+_XECENa
20^;[=\,0#BS@58VUaG7SET92e>(0923?1d<ZU@<_&?>#Jc5ZHdHd\4Wa1<(D/HA
EX;KeI+[T44^I.Uc1GB8R8b4</[?=D5Bg=N/eHQL[8MN]b[,R1#CLQ=9ZAa/ZW)5
)7LFg@P0W6JWW:FVDM9_@+[4<4[[93Lc#B8];MdZe7KG:V[18(^2GIO6-_]KK@C\
:37aX7[cZSRI,(e7[Kfg4d];>+-FK#C8OQOR+R0N?cT/\D_^1YM=\?,LafDS,]GL
AFbY<cA)BHBCU0H4])582[QG#fReA>;KcY7L>gHO:X]Pe37Z>;6eNX=\J:Q6bSJf
/Wa,L]PDKP4]_8)1T/I&#2-/X:deXO//>B)#7McAH-][(R;1,@_67bWSUWI)8SW4
SgRPS<+AZ9.]3&Y<D0>VDZG4(PU:NTQ;FU=VLaI5YA,.dM)Q+#Y<]0P.M,GOOHC6
YK[9^LWF1@,P8MY\C-38fI\:a2+&O)))dK=2(F]f6C=J:5b3aM9]J0]49FG+BT5)
(B<b@QEMMXQMR.39<VRUQdXa<THI><,0PC?BHY-eZ]X.C[Oc9fL/cP&)IT5(LQ?M
<Od6-bBK;&HbA,Pde5B_.P.g66Cc:;?<NfA#SN[4?QI:EZG:AA(fL75aaQ(^c=OO
6;=(=:G:a42IAC[8+U8G6)8QZ9)6TAT/=\5Q4d]U(P,d&X4]IA?=LUD13OV-DVH&
B/^E3:?\SFDb0N8g4N<SM48)\-+1E2?[X/.\R75Jg]L5285W\Q(/fBZ/9UMMD>BS
<A#&2^=d;24OEd[R=R^+9B#_4]SUPX]g/JF>0dON4M\14]J<T_)C2DT3DOOag/5=
D/=fP0_AOBO4639TODA>;UfWQHXR6B?>.2988XO4<Qb6(FC)[d=<[-]K-@:O1[XH
R\bFKB(E-dA&;Cf<V;fQUA=&^HHH&C&=Y66QB2>8>gHZ).686+MX(\gO@Xb+1d=&
6c0KNRZ[eB9,HZ62R_;W)/]<CX?8+FKAf]O5H_SfgcSYL:R>>.\e]3R:g3gQ8=SF
4]8SK/-CO:3MQa&6&-a:9\I]S&K;]MP.^_U2OF@NBR?B5ZN?Y:T>MSQ)/g=&?eWQ
CJf2+JX:S@Z.(#_L0-_dVYHI0=Z<Q8X,IZ^3/c7GP4^d_V.G7O/eF+geWN4/NDT;
I119>;0:44.AA(51JE\2O_5N;F,Y6Af1.(K-e,c-[FH&4;PfF\G;F/YJ?_VA<[=:
U>^T829QF9YcHO2H;J2:Se.F:@MSO=74-Yb+O,KI2@(1F2c5@IaHW+:#YJ^K^=.0
OXNSFgeS17A2P>FdA6e:LGd0)Hc1(Z1QT;XHU]<1UO:6WC0CYQWP]_fa9WOFC&Ag
G_OP\<PJMZPD]UD-.ME[c>LZdU+KV>PBf7_]=QZ]H7g9L9_SbNX2O4;#EGaZ@?D\
+3=J@/@=f7MKf<4D#a,<P@OGEP:72=1U@XJX>GK5)NXB]/3).(B<+4INV[(aPOb8
8VNfL?eN\\LJ9-K5P#;OdJBJEKI\eGA-G/ZW/BX,ZFUDdNCS1-IIRa8H?]c?@?0a
R#N@&9TgcP4U.N=PLQKQbV@,9VL7-7N[_PX#L#46(Z(Ad,A+d7@09:W6DXX]d;aD
C^_#5<e4@b)X31,3ENU6,Zg@/>N>=ODA,PcN8>KN?I=9X#4dD1T=-Z1Cd<Jf2Z,0
Qf0<.YcA;]Ge2a5K:Y->&=X^7;(E:39]8G)<G67fW:6ASPb4cAK1T428_H6ZQ7OD
TeO,FfZ?-JYHYII\3XH:#eL2R<e3X<D1&@dTO#G20OeW\L7R-34RgaeL6F>N><9<
\C;d]#b4&X<HGD:B_).gRgH]TI\gU=>@97Z#OffVaZc5A7]Y+U?GXg??d,K=?>S+
P3#GF>]1AXWOcUb534VB@aRE5R?Q70^WHI)fW@+PMD(V@)A)#bfa)bZAVX=dbd1#
gY&=G?[80;C/2X4.14eA)P]fR^VZC6/Vc<6SV(^)SI/7<EegSA/3g/HZ4bZ09KYd
<ZS7@d<X]5@(?614Z]H96#NR,Sa@USX7:H1-7Y::8:0:fgN=3d(-7MNZAUEPOUXS
))cPIH86<,(gJ++W:ZD<TWO&Q;):X]:#<W#7B+(NYZ58gU(Y-,b3>(g\[W\4N[f+
5-OM4[23[,@7;K\ae]E4<7#\3\AE@4f<=@f<<]C12]7CWF4dc1D<&O>KBNF6,Q0+
d9TC[Tb65RWDeIMRf+c\>0gR9g+6<57Db>JVT#f7dA6R#H,D[IabLV>UX])gWQKW
U-(3F6;BYUTS[e)LN&e4>cI>6SC@AUXO6CeT\66@f<S&V<V1PJQ6<L>UK$
`endprotected


`endif // GUARD_SVT_OBJECT_PATTERN_DATA_SV
