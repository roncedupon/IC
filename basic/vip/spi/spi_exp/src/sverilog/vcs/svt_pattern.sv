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

`ifndef GUARD_SVT_PATTERN_SV
`define GUARD_SVT_PATTERN_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * Simple data object for describing patterns as name/value pairs along with
 * match characteristics. In addition to the name/value information this includes
 *  - match_min and match_max
 *    - Used to define whether the match should repeat
 *    - Typical matches:
 *      - If match_min == 1 and match_max == 1 then the match must occur once and
 *        only once
 *      - If match_min == 0 and match == n for some positive n then the match
 *        is expected to occur for "up to n" contiguous instances.
 *      .
 *    .
 *  - positive_match (pattern_data)
 *    - Stored with each name/value pair this indicates whether the individual
 *      name/value pair defines a match or mismatch request.
 *    .
 *  - positive_match (pattern)
 *    - Stored with the pattern, indicating whether the overall pattern defines
 *      a match or mismatch request.
 *    .
 *  - gap_pattern
 *    - Patterns can sometimes need to describe non-contiguous sequences. In
 *      these situations the non-contiguous nature of the match must be
 *      described by defining the gaps between the desired match elements.
 *      Each gap is itself stored as a pattern, but with the gap_pattern flag
 *      set. When set to true the pattern is used to do the match, but is not
 *      stored in the match results.
 *    .
 *  .
 */
class svt_pattern;

  // ****************************************************************************
  // GeneralTypes
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** Pattern contents, consisting of multiple name/value pairs, stored as a svt_pattern_data. */
  svt_pattern_data contents[$];

  /** The minimum number of times this pattern must match. */
  int match_min = 1;

  /** The maximum number of times this pattern must match. */
  int match_max = 1;

  /** Indicates whether this is part of the basic pattern or part of a gap within the pattern. */
  bit gap_pattern = 0;

  /**
   * Indicates whether the pattern should be the same as (positive_match = 1)
   * or different from (positive_match = 0) the actual svt_data values when the
   * pattern match occurs.
   */
  bit positive_match = 1;

  /**
   * Flag that indicates that the pattern values have been populated.
   */
  bit populated = 0;

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_pattern class.
   *
   * @param gap_pattern Indicates if this is part of the pattern or a gap within the pattern.
   *
   * @param match_min The minimum number of times this pattern must match.
   *
   * @param match_max The maximum number of times this pattern must match.
   *
   * @param positive_match Indicates whether entire pattern match (positive_match == 1) or
   * mismatch (positive_match == 0) is desired.
   */
  extern function new(bit gap_pattern = 0, int match_min = 1, int match_max = 1, bit positive_match = 1);

  // ---------------------------------------------------------------------------
  /**
   * Displays the contents of the object to a string. Each line of the
   * generated output is preceded by <i>prefix</i>.
   *
   * @param prefix String which specifies a prefix to put at the beginning of
   * each line of output.
   */
  extern virtual function string psdisplay(string prefix = "");
  
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of same type.
   *
   * @return Returns a newly allocated svt_pattern instance.
   */
  extern virtual function svt_pattern allocate ();

  // ---------------------------------------------------------------------------
  /**
   * Copies the object into to, allocating if necessay.
   *
   * @param to svt_pattern object is the destination of the copy. If not provided,
   * copy method will use the allocate() method to create an object of the
   * necessary type.
   */
  extern virtual function svt_pattern copy(svt_pattern to = null);
  
  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Method to add a new name/value pair to the current set of name/value pairs
   * included in the pattern.
   *
   * @param name Name portion of the new name/value pair.
   *
   * @param value Value portion of the new name/value pair.
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
  extern virtual function void add_prop(string name, bit [1023:0] value, int array_ix = 0, bit positive_match = 1, svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF,
                                        string owner = "", svt_pattern_data::display_control_enum display_control = svt_pattern_data::REL_DISP,
                                        svt_pattern_data::how_enum display_how = svt_pattern_data::REF, svt_pattern_data::how_enum ownership_how = svt_pattern_data::DEEP);

  // ---------------------------------------------------------------------------
  /**
   * Specialized method for adding an bit name/value pair to the current set of name/value pairs
   * included in the pattern.
   *
   * @param name Name portion of the new name/value pair.
   * @param value Value portion of the new name/value pair.
   */
  extern virtual function void add_bit_prop(string name, bit value);

  // ---------------------------------------------------------------------------
  /**
   * Specialized method for adding an bitvec name/value pair to the current set of name/value pairs
   * included in the pattern.
   *
   * @param name Name portion of the new name/value pair.
   * @param value Value portion of the new name/value pair.
   * @param field_width Field bit width used by common data class operations. 0 indicates "not set".
   */
  extern virtual function void add_bitvec_prop(string name, bit [1023:0] value, int unsigned field_width = 0);

  // ---------------------------------------------------------------------------
  /**
   * Specialized method for adding an int name/value pair to the current set of name/value pairs
   * included in the pattern.
   *
   * @param name Name portion of the new name/value pair.
   * @param value Value portion of the new name/value pair.
   */
  extern virtual function void add_int_prop(string name, int value);

  // ---------------------------------------------------------------------------
  /**
   * Specialized method for adding a real name/value pair to the current set of name/value pairs
   * included in the pattern.
   *
   * @param name Name portion of the new name/value pair.
   * @param value Value portion of the new name/value pair.
   */
  extern virtual function void add_real_prop(string name, real value);

  // ---------------------------------------------------------------------------
  /**
   * Specialized method for adding a realtime name/value pair to the current set of name/value pairs
   * included in the pattern.
   *
   * @param name Name portion of the new name/value pair.
   * @param value Value portion of the new name/value pair.
   */
  extern virtual function void add_realtime_prop(string name, realtime value);

  // ---------------------------------------------------------------------------
  /**
   * Specialized method for adding a time name/value pair to the current set of name/value pairs
   * included in the pattern.
   *
   * @param name Name portion of the new name/value pair.
   * @param value Value portion of the new name/value pair.
   */
  extern virtual function void add_time_prop(string name, time value);

  // ---------------------------------------------------------------------------
  /**
   * Specialized method for adding a string name/value pair to the current set of name/value pairs
   * included in the pattern.
   *
   * @param name Name portion of the new name/value pair.
   * @param value Value portion of the new name/value pair.
   */
  extern virtual function void add_string_prop(string name, string value);

  // ---------------------------------------------------------------------------
  /**
   * Method to add a new name/value pair to the current set of name/value pairs
   * included in the pattern specifically for adding information about display
   * properties.
   *
   * @param name Name portion of the new attribute.
   * @param title Title portion of the attribute.
   * @param width Witdh of the attribute.
   *
   * @param alignment Type portion of the new name/value pair.
   */
  extern virtual function void add_disp_prop(string name, string title, int width, 
                                             svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF,
                                             svt_pattern_data::align_enum alignment = svt_pattern_data::LEFT);

  // ---------------------------------------------------------------------------
  /**
   * Method to copy an existing property data instance and add it to this pattern.
   *
   * @param src_pttrn Source pattern to be used to find the desired property data.
   * @param name Indicates the name of the property data instance to be found.
   *
   * @return Indicates success (1) or failure (0) of the add.
   */
  extern virtual function bit add_prop_copy(svt_pattern src_pttrn, string name);

  // ---------------------------------------------------------------------------
  /**
   * Method to copy an existing property data instance and add it to this pattern,
   * but with a new value.
   *
   * @param src_pttrn Source pattern to be used to find the desired property data.
   * @param name Indicates the name of the property data instance to be found.
   * @param value Value to be placed in the property data.
   *
   * @return Indicates success (1) or failure (0) of the add.
   */
  extern virtual function bit add_prop_copy_w_value(svt_pattern src_pttrn, string name, bit [1023:0] value);

  // ---------------------------------------------------------------------------
  /**
   * Utility method provided to simplify trimming a pattern down based on a
   * specific keyword.
   *
   * @param keyword The keyword to look for.
   * @param keyword_match Indicates whether the elements left in the pattern
   * should be those that match (1) or do not match (0) the keyword.
   */
  extern virtual function void keyword_filter(string keyword, bit keyword_match);

  // ---------------------------------------------------------------------------
  /**
   * Finds the indicated pattern data.
   *
   * @param name Name attribute of the pattern data element to find.
   *
   * @return Requested pattern data instance.
   */
  extern virtual function svt_pattern_data find_pattern_data(string name);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a real. Only valid if the field is of type REAL.
   *
   * @param name Name attribute of the pattern data element to access.
   * @param array_ix Index into value when value is an array.
   *
   * @return The real value.
   */
  extern virtual function real get_real_val(string name, int array_ix = 0);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a realtime. Only valid if the field is of type REALTIME.
   *
   * @param name Name attribute of the pattern data element to access.
   * @param array_ix Index into value when value is an array.
   *
   * @return The real value.
   */
  extern virtual function realtime get_realtime_val(string name, int array_ix = 0);

  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a string. Only valid if the field is of type STRING.
   *
   * @param name Name attribute of the pattern data element to access.
   * @param array_ix Index into value when value is an array.
   *
   * @return The string value.
   */
  extern virtual function string get_string_val(string name, int array_ix = 0);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a bit vector. Valid for fields which are not of
   * type OBJECT or GRAPHIC.
   *
   * @param name Name attribute of the pattern data element to access.
   * @param array_ix Index into value when value is an array.
   *
   * @return The bit vector value.
   */
  extern virtual function bit [1023:0] get_any_val(string name, int array_ix = 0);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a real field value. Only valid if the field is of type REAL.
   *
   * @param name Name attribute of the pattern data element to access.
   * @param array_ix Index into value when value is an array.
   * @param value The real value.
   */
  extern virtual function void set_real_val(string name, int array_ix = 0, real value);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a realtime field value. Only valid if the field is of type REALTIME.
   *
   * @param name Name attribute of the pattern data element to access.
   * @param array_ix Index into value when value is an array.
   * @param value The realtime value.
   */
  extern virtual function void set_realtime_val(string name, int array_ix = 0, realtime value);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a string field value. Only valid if the field is of type STRING.
   *
   * @param name Name attribute of the pattern data element to access.
   * @param array_ix Index into value when value is an array.
   * @param value The string value.
   */
  extern virtual function void set_string_val(string name, int array_ix = 0, string value);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a field value using a bit vector. Only valid if the fields which are not of
   * type OBJECT or GRAPHIC.
   *
   * @param name Name attribute of the pattern data element to access.
   * @param array_ix Index into value when value is an array.
   * @param value The bit vector value.
   */
  extern virtual function void set_any_val(string name, int array_ix = 0, bit [1023:0] value);
  
  // ---------------------------------------------------------------------------
endclass
/** @endcond */

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
A:5=C+.T[Md)Z7&LROSXb#1FCQ.T&^-@98[SL>(OM[<<NPY/J=8N1(-XXFUC07LL
/7WaE8A@ZGPaD_KJ4?0+]:^:cNUI3/eO^=FQ>)9);9]@.-?)3538Z-[eeINCL^B&
TCUPa0(^H;VX:<>?<M:e]B.07B;]dMY3)P8TTZ)CZ(UYPK8c_K+/A@Zda#aX1JZ^
RKE]c<cOf-DI[[EO^fMaf.ON+VR=9VQgP_cP_ee(YW4RM5ef1)OM6e05.M(eSDK#
H\fX;f9\C[9ZC0:.2,:.LSc@>E=^^#3HHU>@@AX\96R[,<K2+K.b-e0/3=?G;L_G
D7)aI.ZU,QCMceA<-_T^9]1:O)M(W_IA1WON8W+OUW8Xe0+6AVc8:<OY5g[:@eN9
#eZ9aP^C_<]YMBC4Rb5,,F+0?/AD>J;GFa-+R@]73Gc<aaQ,IA833@Qf0&C8/+)P
bTOK<2E-F>QcYNV5@F^WY9B(485@96_43@AIJ3]J4[2TBe.f\/JB8N@HA?A8b&?F
7ZB[0S;W)1.WY)GCXRdRHF^\J6AZ+L8gMHeTMJ(O2@.YU&1OW:-e[/Y1_/>4X=Q.
N8>E3<e.3CA0H-daaed?RZ?/C8S,dg@(WF25bJO[d\OVS;FH8#._a++Lg&:9Re^Q
=/M8+>.MgT,MY3ITP3SNC^17DF?eLR[+:,O@).QR@3cM)(L:Ad?H_;VC@&FLN_cM
TW1ZMYcc.Z5I:[\_RNP\#Bd<-\TI#1&(<Z^g0Z](_(,e[<^K1LM&dD66.GN@;U+9
O0_cSL@/eCf0)II4LC-Y\/O9QB[;\:XK/g55:TJ6(>0[3#R-:e&QCP<@L:P@.b=3
140;]B]BX&&-:8__5V<P;c_<0b1gQ>#/5Y=QNE2[LVRg4eM;+Jd;F45g[_1dPe)E
[>SC()\),E^gS4Wf/N;H0+4\LUeF_X0IL0NB->XYcY05+IbZ/T;3@J[Ec;5A;1K<
\XOQT;EcLY]\>AcCO+D39KAFOUN#W6M_/46T3\X;+IL#<4,I/4.cPCZ6g[]-/\LT
XP1Nc9+S.=:8<\3YS\2F>[fE37f6)#]9LN2)LaL4=P144G2+_(9gYFY&>D7ac)QJ
feKVQX[R=R2@N-)+1DZKM4]#X9S(0U3UU.N-K:;J,9<Jaag(\.YN,D[M)GLXW,-N
@DQ<+dI-DW6aaZdRMO?1EUGL2>/bG^BK\9ZF7^O?@C>&Z>;+_=GYT(FEMHXf.,CV
SQV1(4,f8CTRWN[f=1QQF@NCG^M?^bP40R9+GRWd+(?b_C;#U&I>,ORRI/;?<DZ4
9M4G0Y\b@0XaU6]Yb>?R3bG#Df<CHg(d77@fJG-\b2<ffAQDDF?#4-e=Nf#dc+^)
_aW\)/GAF)fA149#Sg3GW6G](Ld1ORG8,9?WZJ.V7,J?_UOf^>\P-I[bBCHdKTIM
e]\a^HQP1#/1N.Q2dbO_bMX.@G1T(;Q^V;Z(?B-/_S4AZI0G[?Z,X3G(8R,\&9/[
?AK6[+,-[cW4]3?,1/&M=NAW9:J?9N0bW(Y^?0KQa005R\SYNSO\E2:TF(FcNP<Z
(8JVTP7d-9^84B?UP^ZZGW2:[VD+[R2g(=fW\XNfM2g)#[I^X_LKaB^X9V4g<1eG
Zfcb)_?,;40ZdfG_VZKJ]_95Y<.@];N6B#@3]W==X41=BLb=[^4II#:(4Z+>]V^X
bUNIa2ZS/CRQaO^bEF^CX:W_CD8Y<.]6\cIDW_aL9//9H(-F6cT:[?G->_E0VPd0
_TSd/)(6.V]bT-[9_)fK0WaHIGgS9#>b&H6WZd,J8H697YD:]91NHPLa8O8@AO_T
T9Y4CCd>QR+XY3,]=O69Qg4c6N__g11L&CGV:G\S@-H?@^IeA[#6OVJS?X#K2K>b
8#91aM[eNf00JCG&e?gAc[0+G#-\LL76M,RP(>XR-L:M\g+R3ca+(bSW#K-fX-(L
#H5+=f=37,4-c.[,H1C@]<0e(g3/VJ(caQc#P4d9D55X74_S3]:N8\g4W2DPE4Tf
RZCUf7;e#3_L+?/3D.ZA:VVQ(N>9gJ)3C9+R)9O:Sb#QIOb2TZOgd,IH9a_@g^1=
X>@UfgHUU;_U.7^.7U,C0cNU[#@,W.HGfE5XH23=?38(9E<9071:-@L=09R?OXJY
V.aJ(RY/HfI/>)Q0R@,[\?P_29[e;]&Tf7aC/+7N_d^E2@).(F_2.O)Y4+ZNOZEg
T6/H5QTUC@I+OFPFJSSX5<^=Bcd0N-2=/K^0-=&@AU5PF:;B@D4LI9^<R-M\dcPM
-R-XFYGS;?I_>R@6GV]0/#3]C[/OW>F_I[RU5I5O@F-E7,7V]DW[]>[8:6=V5KgO
3TZBA,EZ(NW,U.d3?521cOKaU&@7=XADQ2+cA:G8HARGRA4]F]3FDX>O_Q6I-ZX0
2IBMIWg=@]#+CQ8\)Nd6[M7:]P3--fN?DKASDG;bXZ4_0e&e0[<PB>dC#@/06;9L
9XBGKb1_;9].G(PDG9aKe-))6?HF28W>MB9W7f\+aVOTJX7TUag]/:a@NLVdFB_B
#4e#M)]Og..L;10Z<V5K9&BCY>^8]HX.ENEU^L#MH>YO-9XSFAQVT8YEd\bJf;D+
H-V3T1N(eR.f26,8VO=B+:E[E.[>?4\R\Y/;JX#QIWW8&_Ee-HW(eF_N1GMTYR[2
I;)eVWB<FK(>Fa2];Ea-0<&gP?f+<gI0J2Bc9>03gIdW.g1QDN1<IfC(>GeXSVS[
HGAOVXJ&:(^)_UO.e_H:H9N-g?aD^\gAbfG8ZRZ9)MHfW1]b+GfaW(J&<&M&NB-6
\/ZKg&7SE,(#C46^)5RUaUG\&3aSO))=^JE)BaADB;P59cG+BUGcX:36S(G,;<8@
8?_D=,ZgOD-2V;^S]^;,KIQU&0O)A#44P[/SG8A-/N[[L/Nb03Qd=4cd4aDK-&+.
OHdKW^3,0[+DZ[_?CQR/(21bRGdJ6XPQ4bgP&:\<O^K>^2AI+0+319WWNZDQD_&#
V;1LKPVD8)#?GS1@Ud=(HEJ8@Vaf,5OQIOURbXS400MaA#U>L48+@<6-7;9-+Y3,
FK#?[Z#WP,(T+BZdE<N1/1cOR-.aWEa:^#>,ag4deH8UU)HH@6D.]61A1^gRb6_\
>^^2=1R@<\Y#7dSZGU^Q_>BAFAB_VZ>K_Y23L1E(#Z[]J]6WbTOXcG-6I_O<Z7^V
e2XU:ZD[M(g&Ad+a+-J1SWSO\2J[]NcW3?S_fKNT8]b?cH73,X/HXc[HTIM0+g6)
)OPE\b=:&-_4VLMGIOTaHK1RABR>aW<47aQ8XH#0DK\a3RJeR,Q5If@=ZFN,B\,\
fT?:-P6b0Ga4OV)3LE3-C9fabgc0GM44RRbJ2B?T:H?R1cZXDS6Z\5FRf)dT(X)G
41EE&fNH?-=;Z>.a9We3?(BZ7D);^,GJWY.SKPd32M5:TQ84L[d+P&0_:a?BWDRE
[I;&RFAX)N9=XFRM(#76WK9[RSORRQe5BYDg3M;:Ggc,4Kb3Aab)g<<DZf+e+RVN
1P5+9Hd:8a+fX5J[9KRNXMN=fD[eP3Hg5aTU8ZT8,I53R5/Ue1_S;]LS:TCN?)6T
V(V3@-3T-K;M3]cKOeNOX8b^a76U&,_d,g0T)=>I]N51[<QYMd;b0B^/:8HHRA#B
[3V8g=2RW,b?>,O>B,IC:6A[3))GWdH0JH_F7>Ge7d0U+PF1?5T1dR[A1F9e?95V
g+Q+MWAcQNWQEcgbEa2a(Qgc22TS_S-BPI?N##e2O]cU&Z[A5;QUS;U-O^VM#KV<
<+XT&+Ec(2&[#,RX\RGI@JPE1MH)3<K[-#:QQV8PU<>F&3f=_Z<)#8[?J11355,b
RXM7bHUKNEOTP/2=C:6IM/SOS:;AeB#:9OQ_;M4]CP)Je6IO7:_-6D10CIJBWXg0
6;I\YG6SZ,2?@c,\BF@RA:I2K4Hc^LYP\Ng5UY>Tc#gC/aJ?43Z8d:HX1]:[U7\#
8Qf1@;\[VSU([\^a4R@S+2B4R.L#B:E(@@Y=;dI^WVQNYb-aOVD(WJY(Ng?X09aE
^_&&&:M^N)(V]O;F5_)a7a2&A94<^NKBFI>[TZcEgfU/B4KR+fc.1X3UY366X8(b
^:D,(33D.N;eAfDb\?D_(E:cAC6]Uf63gE4Z/BWc<)6(9?c+-YOSeQ_N>XdXTX(/
M7P)H6eUXEJII<SX<d\STOL[)_eE>V>c^8gU:,Z-RX5BBHD@b._fRaM3TEg2^Hf(
1=DO\5Y;?9e6a<FIa^cX063_Ra+5Ug2M=e[EX\/G37Q>8_;bD+WV0EUeOc?4Z-J4
Sb<:-5^ANW_Wb,6Kg0X@92JI:Q\Sa+@+Ma@Q<MJ)U;X,=M8U0XU]?OH6;7O;0#A.
,M77UPL<4+^S5ZcKG,P+1OG)<(?Z6aH7YHAPZF1:?D-N@S#Q38L@W,,3RZ<HVe7\
gR2/eVZ,^]C>UTWGeUOSPU4D/OO/YB<W5<(@9.T6+-E3YJT.+VYJ_RY,Tc7YdYJS
e5.>3NDW47&X7T&SV2;;KFH-W1?6LI][6(e/.9MH_D,O>Ac-F\9b5OQDN(#QZbI#
Of#IM#KMeW(?HL\L&YUDg88JHD\a?/Q1)KN5d&<H-d_>OBA&LK7^V&L&KEK_-<<7
.3&g^(KKe6_>-ICGB<)IM#H=JP-JA-VX+:1=V>[RB-,Bg6P2JSZUDgEaZ9fF8\SW
[&Od3HGWCQ)J_Z=<=0fX1TF-LYF\d:@[A.>E3+-E3PYVX&YJ_:a\Q&1#&-]_7K(Q
adE:Ad:AO8g@94/<Pc#NLTMT,BDV0EFVOJB=YOO\LUE4aVU<]?)-Z2E+W93Y-F&&
e=M0/5Ha\48@\M4.9N8EU^6V^;4_>a56.&[AG;U[.X>D&[bI14&?A<L2,6b9dA[:
G6&_A9&3D:H[@B,d2ELV(DK)W?D[]PT?=^IOK;(&0K+4>9Fba-d<9fa0ReH0c04D
#/D<6^G?><LE+H>Fc7eR3Wc_3\HIVcC_,-E6/\;AWSc_dcN^&]fa(T8Q]VS_.O)]
:L^[5<;PS+N[bYfJRAg<#03IdKS=:M#2:1#0MMIbV6@7XG2DMQ24Eg:CdRYJ)^5H
\?MZOMAGLU[f_I5;e@B?5^2.)FD@7H3E@V86aF+GN8EaYJ)\/b/:9],UN/#]HNSQ
S^OK][V=Z^2+\L5G^WcFZ/d7PNd<=EED_Y9V4C,G;2H1=2,<;b;^-#X:LVfOV,11
>eV4@3aeHDcg0T(;@;7[O]/H849aRa3IA9b[@X,:..JBdX1WeP&93=.Ze<ZK0b4g
PLV0,JdgDB=44c2I5YM6;Z.f+6>:9_^+_f<_43?7L##Q[]KCO[6;V4UWX9D8YfER
N7U=WZNQ&L&g+)YEZIT59MEC]&;_](U<;+fbJ?GF/b](DGC(<S,,AAIg8SG7:1Q8
\?(8Zc3HQC@>Lc=Z7WC,130IPKaR7C[-bN(J]-Z+-EOMQC2=_EFcd+A39#F?0F-b
)ZQcQ@AUeZaPE;gC+b<Uba[DVH6cZ&1&+:U,+M,)6(B518RbY]-__\g:-_S1+H-U
PF7L3/;-_SDK.e<N3^4eTM.?7cP1MD[->:a]1+UG<GZNL.fY#VC985Tb=6V./4g2
LJa=J(RXOZP3:d4#^>cTEBHY)Qa4O=6)Y;B:81JP[1-43#=/Q00\29-.1LX=;LH,
DK.[;5\FIc=[g.05J,37\;[QRea_1I94aG?_(-(AUQB8.UPFT2.<(JO^HN0WBZE-
ce..S,L5UZX;,R&1:dU[fY><0/<K&X7+gRM.V)Pea.,e>=]]F3>3(6DM29gIIaaM
/^4<+/WP+]A.2J,Y);O68GMMGJKb?+NG33I-28/Z.4GAe<.EcK4;A=G_0dEd7CCO
5Z\JPZC.[gg2<EQ.9>A^CL,V8=VMgf.V_(8K4X6G/9c9)T;0J7+b_C44A5#L_F@F
M<EH_b2]T:>&,>AfZ(Da4=WL)9IgV&J)]-]C)F\/dVTEDLOCZ#=\N9OX=N;GX?[8
WTfS8fBZ30:&.d)gc_\1CVAHb\EC.95^Wc&U9==M^5cI3J8\:8HcYZW\4@ZNR=TS
OESZ8]-.1K;NALDN)9AS<S?TG=;Qc&5&(8.502[aD7_;PK,5@U47cC[7]f>XfU20
H,1,Bd+6,\bRY/((=O,;.d])+@-g#CK[O,K_VUg5d;e&&:5/b)SY;gb]eHW9+XEb
1];3d_VZM](>@FY3:a868>C64FAa0KZ45<SdZcGD#JfXL1=2^CA;KAdgT;,_R.AR
LFE6PX9HWNf)<^)OWYYJG,C6VHaY2JZb)LO]6_FS;06@EDLTBdZ34[g4+H#;?gH9
:^:1G0:T>-Q?/B7B=9\cG4_ZWDCc,XXcU[Y:^A/=RTHe[e9OV5IQ64_308>_2,S5
G7,6+0+Y8B+Db0Fd(@46ee)K)[a>?d&8,P[\7ON(./1L&=IYEc7<S^ZXZR(9#.L(
JF-=G(B4X3bc=LMX\_XT\Ib8P8f2DX671YD>>Sg]e,?P]56?dI)#K(9bGT.601/5
;[,?N8N[6C[G[6&cE#>XT]ZOd,7CB)YS>>QeDJM(?;V&#3#B?5WA&?#T^3N+g0\<
I/VORL^EJDZ@gO),(P(PESA,G.Fab3TI#XdST\N[]1d/59)[0N?05<29V;g#8Y9Z
EM)4+:K:.BQJbN?bF;X@L>RG&+P23^L&29>5>]gK;9(J#S60SbO87]J/HZ<CRe;9
PPe=Hf&=cWV^Z1(@b_4,9R3_DY]\K]Y=S&Tf.N#[UeBfL9gC>QEXKeKOWFZ/MSGR
E2_Le2BI[edg5XJ3C<bbB]c+MA>28]b76BQReZZfg:U#URTY_R,2+&/8+&6g<0O4
,.ZME)=[dSSO^LGU0)O>L+XZ^NQQ(SN5e_U5fg]V^=GCW[H&-RQC^F4&66g9(S\R
c;1,G3<)?T8F&(9X_dFA=LW1^MMF^]R@O#9_N:+dT[OJc<B#491J&@.8/K^68]3c
A@0F_QcWZ4K)S;F<JQ=<BCWJ6JU<-MF59]7N>aX]Y=L[)[D_M-^d/Y6A_8Q&EDB(
0N80R87:DN(RW?gg^DLdbY?^G19#aA.U_A7+gcQ\Tc&>R??U6#\H-a37G^QHfDUY
:]3[BdaD:DQMcAIMTM>QfFC/[_fPGVAb>GH)T,BD1R/>^2_dMc^&\7QD-716Sg8O
_GI,_bUKfcG2#6[8KY.4(EV4Z(O^GC_9H4<Ng]HM.a\]ENNc<T&15aU>KaC7)EL^
AA4FD\+HK_[JfN=#\e]WDXOAJ<.H/@<:\8;]f9C?5F;1H-G(g;XQcTa#,gJV9V54
7:K88I4BLXaG)L..gXO@Fe3fI@Id[;6S9.(F#SCE,-=?YWMW@)/X+)W:3bWCZfKH
TLJbN.1O4f3g9W)&3Ig5e-I2Y/SS]I5DHU?ZE?,N4f=KPeX(a?#&1c>3BNF9>.7@
B2]M5TJ+<823HJ;d[4eZ;.4&V2:cG.(7,N[A(VR=cZS\KMQ=YKGJ)FA55Z;A3O)O
O_+:PeJ\aDLIfZQALG0>#>g1gP5Hde=M==A./bUfY.MJ-:.:GZ7;UH]LB9)&NNRA
KV528b^O/_FG<\F1+bH9B2+\UZTH?5a:0]b@(_99@4A(&N)a0S(HI9@PIKX+9DaK
V5@K5N4-NJ4LH^G-NCCQEHY.9Y9OfC5cJ/29BMPV/U/EO0HIL+NL8XEA7ZPU\K[B
U-Y3:CN2Q(H;V4-\RV57##81K0TAfT(0g#Gc9Uacb5Nc+U7?WQLUFN]97d)g[D8<
6TA=;KJ_e.^X]P;Lb).FdI?]E:3J@Za/[QEO;?V;faKA[T-_a94JI=OI#/7N7J0.
3#:G@\VPEKA/G2e]T=G&X\VI0Z0NCH2;0e.Ud[BBX,<0FM#YE9W_f:A?G,RQKOOT
fU9aE3CT?g(\2PPBV#?E-9&[EANcUP3=WR+#8K-H-,g]1eeOaYa0Wg^EYE-I4657
05F]K@e[B<>CLd4R9=;)213QDe8e:PP6,R5(K_2AR.gX8BPGSaK16JV7e?/]F^X2
QK06CPDFW<DEB;e3fD&:fgcRbA&JbHQ<F@dBNce(J69XWKWT/8\QB]XYg]H/(1^Y
KA(,+M7#3]^Sg.-,=/YPB&^]ef/HEF6d_b#:U0S\2-(CCJ2CQR/-8Wc-YW\4J=7E
,]e<1+7TJ&LE9(WG]9D_FOUWd\5+Q3J>8NLRGcfY\P:V?8DVEE/f>&?NEA_31I.e
SK2=1XgB51-gc-X]WLb4#aTS91V2AE5H7;EU<MX][>a08YdNNPfNP\)&U5b4;2_>
M:[@/73^SZDYSY>9:Ve4RL4Y]_/B1dA\,_QfA).MF<PLg,HM.Yce\=6-<6K6N?FF
L/Q8UM@VfHb;;;PY.9Z\C]^K:g9S?OLY#bDP(UG;-T.J)UR3_Y9f)Z\.4c(FfPE,
=7P0,@CXXAJ5gH[1;g@eJa_9Aa?#e7:YV(WW)-R4629KJ#[LTgeZ+U-M=UPT4AS&
Hd041FGLcgWRJG:UU:_b/4RW4\cPcDPgKe:C7Ta_#ENM:+JZPU_F3ACbZQU#Ff3A
M]\AV;SP>3V3#8KI@Q0\&&I.#WAdc#]+J3M2C>>>:#4bd)NGF35^?XBeN?AKDFAU
:W;(Z+[:GQ?D5FN@=A2V7W1<Z\Y1-7Ud3Vfc8a<@O=B4^d550])2)SE8f7TU)OJ4
)[7P,UG)MfQe>2KO9F7K7f4S&;FPUR47VF?Y)]9=XD/BGQ8a(J(^C0H#a6Rg-5?7
9MgJgZ&O(3TX,(B8e4X/EUV5D)b_D7=2:PbW.MO<R3&KM37X#6_L&UUH+I0T\EPC
7d;D8L.T]H>8=KN\EGGIQdRI<]LPI3R2VX;TSXLPE+feV,/AQR:6H0]L_[>F5.TB
TBXd6I(N@#GJF2d=,.0Le9YS2W>)PM.@>(<9F4131BJMOO=TXT(>OZUB):faA[GK
T..8?:4Ce:I+(a3J9\5Gd)(V:BCBF4ce6BXe.JFKNgWW#fF,9_BS;-](#cA7=^JR
O)2ZBL3(79F=D1N#XeWT>(#R_6&R-f^BW-@=18/F79?2&,WBKbCgf2OFO5+>KO:7
4:dHb[?&g^R>UW^(KR/b&,gS;SEJG2e&8dZ:#.^aCQH?@YSgIdEDI3/4,YeU>8J5
A0bgfR?CM)ebK/gYV8#4VR,JG3U<KP5e6KWU+I^GaY5=2e<AE0X30Gb?ecdUGUW/
V]WVFgG5K9Jb@U76TW>GN8K&HZ+6-UC\7^(L4@JK/N8<0_U6XZ0f@Ua/2I[..4T)
WBHMZBW5Da4LUM00cZB\B9\4(bFN5ZLQH.(Ag8745LU)1N2GH_W6>.YXKKK=38bY
;=SDJeB?1TLK>TE,Q38geZ0L&^W)VD)E.8b)9].AG,\:OVFIc/430>U]9HVQN9#2
_\6#003Se,&:2XQ8Q#GK0IA>O7Yd);If)BW:Y.6[EHAf18547Sc-AD4GbUZgEC>4
,X[TU1T<5IO#9EOU8LdN\;U5?RBG;DMZLcgJfT[Q/fDZ+HP_A(\(2WI-YE(7H_9b
132IF+MKSJB#ebG94CVJJP+;>TacN8Z4NV;L\?9)K/6fC0gMQV?D?_@ga8FWKP&[
,a[#-b6H>0RE^O8:,3LC_,EebEX^/fX2S[RK?WKH#\E6SY^2RC4(TO8TPW&44P6L
@81MI_ZE?J\9?DC,+@b:1Vd,3S?2D]ECe9Vca&g^.;-A7]Ig80XdHUeZUY8K<bE9
8Z6If]RA93[4W^dE:)YL&.OHBQVKJbJ0&X9/c[;/.>R:OUE0IHOdaZ&,N&b:CNB8
Q_fD/U/DJePLTb()VX#abFM2?).F)P/.JZ4HJ(+:f2-Z3gCM:;=9HR7R1cNZb:&5
FZ:N;?K=f)5VSK#DR]+OdL8PE5]SBI_N5382FBa(5V;K&9bWP7INOT/?M;0N]&>(
O.:+&CbM3ICAJZ;.P?6CN=GS5S@(<\ZHMCYFQ?0-)>Dc2LWIZMT96([1b/,K<,63
(#edWZ)K@:XO5BQVF/FW,\)^c17&HagWGa0BW0JCWb<PQ&<:PC3d:<:CM>BE15C9
OTJF4=c,7#PPUd4(OE[79C^e@;XV=M4AGda:gGGC@AB6.,#4#gC?V\g1^&619Qd0
P[\9KL9F9E-F3@U^(&FVI3ZH-B1^W2NG,M0_[YcR)#@7CF?:;gHE7+LRXYVV..0a
gD\>W\Z[&bO=722S4AC+,G?M48TL;,C/_^1Q:)M3S9?2Y9Xf61+/S7?S6M<2R7EI
@_LQ\GIN_9W1c=e<d)e;K0d?F/4[J1]NK&I:0R#(6eCH??-)NSf;T=.)F<b6VW)D
94&/&,04XCM^dY<;TM58US+e^0a0V)0:NX<?7S7/-\f,WUY8cBI[2:dWV<5LN=49
XP0EC0>Z/5]-UMEZ/:H6G5L;fZ#2G#H0J9Y+:B6gT@V+?&;e9P;OYKE_KATKPUO]
=DT:X5WC[RQSZ?>Z8)T.^bS5=0]T?]AS;Y]=UG(4QPV2O#MP[U?CWbS0^HZReJ5&
cF,fTT+17N-V6aOTBTI#XaS.0Q;IVLTN^LfK(B+P7V]V.BS(92<3b13JO<6FYP7\
JX?/A27+ed,YZ1E?SV+QFf/9-HB6LI4/d\,b8e:E/8:=gZ6YX,7ULO-6+;RBPMN9
GgaB),XQN&2G^7>G#3YZQ1f4d;N3W&IFb9C>5DKdefU^I,HMB=:K4-QQ/PKCfU<7
5B>eCN2Ud4IJSLY1LMABY>W.VPYZFG9gB->c#=BXPJdQG(;J.MN&2O,IIGgK,.4R
Sf>a-aY,,96QFRT+CR#aUFST]@?U14W:-?Q[Lcc19Z3+YT@3)^(&:CB]&1HV?/;+
Z0+78bL4@NPF=bfZ6##f5d&M_9[b=LMP&1cg#/eR=129PYC=&W0QB9?e?,<?MYgS
OgD>XaSe99=MUYBT60f<Y(de;UKO3>E82522[UMZ)be8<6).MVS.Jg6+dWR;;PXb
VH-J:eU>;VXLZfC\Veb<-WK;US2\&9]f_6a&SEJ1.1]&46Z.8M@T8d591Y3YA:3_
]PbfKI8B83&b289@5D<IC1f5KLVN&W1L2_eL6PKZGN3#gT35I.U#+8ZR/MB:_9JN
.>6d,0,@+6#<24B8=UX\B2C6;QH?.5QP2R_K<Y9/VFa4BW.I=EOYBAXP2c)&5@M5
-F:FcY0KV>bPF<KVd.bSR:J?c:R0H66(9I+OM(7DB2=N4__<Of.]E2HSa(-[?NbX
MIFVD<Zb2,?^dKCc33_1T:PM84#+B0b(R]7#<-<LKPVU;f1GQOgd3YQIBdWgJe+]
C1.-N,W/5Q9Xb-W5QE&UgUQP&c#E/Cd[K;8T@LZgd9T8D_4BYK:QJY7+C.GQO94M
3bF143Ef<9,SI+WO=,RbD.OaB]D/RM7.^2+R=BD)bL0R/N<)RXOW#G^8_RLI\61U
09;_(S</2]G2FG\#6BKMc8?K+&?d[W,PReD_>Ra7fN?[4OP05BgSQ7YYWH2Ie(B0
\)3-:-L,/P\SYRd6HES9,8b;OS;24\RK@.Y7I6/(;144NO;Zb-C>aa8EB0UJH8;.
GE]:dPN;c(_DA7KR_Cb>E2JZeO3Z3WER#J0/#+#Dd3&b6,#=+W/Jf+,OA8.TR8#G
#CVda\c,U#f3g&?)=2+1W]+L^/B:9AOYFQC.,[<PWN#Q=/gIQ4VAbC:eVG3]\F>b
3&=ISF=afg3_VW=G<L/;R7#gZ8,BMNRX>Z20<[PaFE6X&D(]BAFC97>D381faFTf
O0S0SgPQQLXK8:[1cB,bI=Ta/<.]fc)I(0)PYf4ea1E256]617(LbEY:G(Ug_:>J
8RU2Z([8N7A:&9J>+3O(TDBAK/I/(<\PU<2AAPgJ,WcX40_I9dCB#>H(R[HcgTIK
KZ0H1-\YD[>4^B;I0BJ@a,=/0(+[<PGJ)=98_b]=MNKVe&D-XG.G.4\T3(R6A2U1
G6?K,K#L=b4+fMD01Q)?dQadXL+C&>,c&2NE=:2=dNK(<3/<^\>Mc)8D]1.+M,(H
-Re(0SO)N33ZP90USDM7,SJV^fOgGX)09;W/X.DP/).R?[a+JHeKS?-O9]HQMR)f
H:aMf(V].R8b2TH>HLcO&dc&bCG4eL=REJH7e]cYVDg0JBI3O8YfH=N:7R;[/K9M
^69:UCGP-VG2+W-+0gX.?A53?T^N=8D;D(1@\2Ladc]bLObHXf23-L/7F8TC>[WQ
KDUAV:F>[D<.:fccV;U3S11TD([HMNcCQFJ#e2:I?G^F.GO#WHF13cHXRg2d^RKF
Sf@Hd0_f.b^3bS]#dB7A)I_\R:GJR1\?a,H<=PaPc=ZK8]3Q_d[)\2:1?.X^4XJ,
2>+W-G1W.H8AWK^C;J<X(02e6O^HZ4fYB6.SUYC2W^3USOKB^\=_0T:EEaIX8CI>
>7(?f1R>2MU^Bg=B2<?MO\;9+,T=,I)aE\=_^da8_;5C@^;/FGbZTY#fA?M&,N4#
3aTZd^]a3VV;e.-\]_Pc[_J\.<;5A2C:S8&)RI_#O]g-L#Y1U9+d0[g<R-&NDI#g
FZO:5]/UTM[D5CCJAc7R^OgDR;<K@4RC>E.BM>_CP/PW;K[T>eTXY0b&f>D#<V@R
0GVQMMc9?_-a.aOJ;aTRMXZ)c>N/D/J7T)CAO[e3MW<7/#2aOE0&XWE3Y_4^ONB)
@/1DbCU9JdO_ZU0&IH:BHPe>OOMLG@1Ma5+BgIHV)e;fMe^UGGXc-@,;&-[5g@^^
]7g[&NIf;>7K_&CS1Fg5(dSIIX_@2Be978-3\;aYA2JP4A=YWD@R[<OR3HF1)RgX
FaWC8QG_VY^6QP5IA/b;D>.e3]ZM].-Q(>VJ1WGXT2;=X/.A[8L?^&YF&;c,A).A
aaX,cRO1J(DQA#Dc.7).(NX_M[S6&1?DDPJ-W&K-\<#7;<H_F2W+aAF\eFE?0ECH
fC0DbGA<S&S2B+D2Y>Qc?.?BKbI#F&DVgG9:G-Be68b6:BU.d.GQ<c3RS4PQG,VO
8^\.O?;U1bJSg#V@cB-40DP/b#D>5E8eS3+cJZWI4OBF<3T11bYdB(#<<PI0cX84
]+:QF?#OM6-BB(:Af8^,(cFQ>@Cg4=?UXIKPG]<cb&(L/KPY=.?(:,:/7a.P=T46
(GK)V8R0&?)\AbX)D+3L_>T,AU+R[,gD^b8V-&XWH3eVUgSfQ^GI9)/F9>6YC<2P
e4:)P&4KEKQ0M_2+SKP#,/M4e>f;59SRO.O.=6E_^fTZ_MAN/_U352-5BWa#8#dA
\++<7eW><RK#0c@f_[cg>I-MBJR8@9Hb7RFAF]XC0M>.L[CH?9;54,O\FU67CSW#
[bO_29J7_/NF-aRfW;D^CGR<T&WOb@f8c-825cQJb.QW8d-R<^HTg8>7f)/-+Lg0
GCcM0^K6RRE83^V[:WP^4&/QE4gdb?D)]bD2#\cac06cZb@NPDbf)bJg0+>0#V06
UVVPBg<8e.+LU_D_/BM4?#OV&1:DE]&S8^(6VB\MGab&-WKOdTXe5TSJ-4](gKKE
LD5H=;c,KSX<&FHR^8?P[W):,YY^Z:Ug4T#U5,bVc7.H^ZYQSFZ_;SeNgSJ\[JB9
O(T\;I@\VAae>/YaO7[]D,LKGOI]),AgcY\1H.g^L,e7L^BNHMN9N:INa[6OB.XK
g-[E[LL(eBY,8W)I?ONQ]NX349VO,c0ZGNYFe+P;c)76IN90^Kb5HLa?^UeV-WAV
50RAD.eVHg_9TNd0a=4J05eZ\eQ_(F<-,a2=Ub/Uc>A4OBeKA6@OT&V+GDVWR/WS
^54OB+7_>74+0SefAG53e:V(c-O.W?<508?^^,Ufe.[5OEGf;4.1#6UcQGaI^S&^
AC#aE.L,Of;<b?#ZYX3J7K7OV^&4I>(6\@S?d-M+>bK0#:XA2WXID+BY#\U[(5@9
A_74HfgD:J7R;-GFY)97.>9OG(O(a&YZ;,1+.eH/7LT&Y9eH?a&B=d7QY73C/Q1g
VS+/9;g](?>5BDP1)VY0g8Z]8(+1f(df9MW).YJM<K1eQ&,7^YeBgXa4e,BZQ&J_
8=3LV2]8ZKC=LIDUN/Z.=d_&.-J]b>UY@5RB&3:K/bRV7KTJ70F-OA)MTS-KDW=B
W.?IR\+ce(^[g)]S8(/;<?gR-OJg>gX3J.]^(&<]S50E5=aS(bKR=N->d4a)(;(?
P:f?F11YbVfVY7R:6WSeLOK_OGcA])UJVC665#d-U^:0(?]QNX(:M#Z9X>g_&,Z+
361JE<4RPWJGL;g4Kb+:F+F_b;#[XWQC_MAR_1Xb?&2Y9,fPR3CQF#Zg0(<e6I(;
Y3S4aC_9MdSNcN/4WTgSV)f7#R<L@02eSF=7H1\:+bMfE+;+&-;cO;W&3L<>#&]\
B1ZW->1Zg:_5PaP6)/#ZDCGRRYMbEf\I10a_//7e>1:V,T]N-6?Z+ZGNV.E)2,L&
-A1M5X87PcWEFeJOTIQe#03IIc\UPMPCE)]\dTAFRB_I3[6E-g=])/+Ie))NI[>9
?W&24gQ\(6dV)F1a^&WdI=@\J<6R#TVV4@X#Y:P.0O619@[HW<_NS@>\+5[d8.Ca
Ua<<5I+]S?fMQVP&)0c4FSJI3TM)/6&EBQ2Q15<E091D6M)900/Y)2,WB@Fg^,bH
gae@dU^[:N-1.1F)g]>YUCRF[J/&5#K]OVg-^N\ge\f\32EDQX\gc,Z/N+<5Vg;e
F6KeP4NPBf/+E08H?7N+NAW7GONN2dN,C+,OfAKAJ/-[)?X;EQ48L:Q9[PPGEO_P
1BfN8@d#_M5)&KF6_NPRMEac9>.g75L,#3\?Ve0]WIcaXb\#A405GSZ4WaF4=HTB
-TJ]CRNET0K5VF:=H?YdNFQ#_--,4(Eg4JMQ;_7.<_++LJW-<FCc+=#IPLaCYU4S
2c<8-BOL]KFR-EO@+B9^]FAG-^+fXUQY_([,>a.ER6EfAOD,cZ,TNB3VN30LNSB5
<f7I>1)=P,WZ\OfQ:=Y2]=^_K](<:)4W6PN,b=2II#T;YOGf7L0.T^5f>=NGZPAU
?WVGQF7-X0^=EHRR&X].)Zge,LZ2]I[_@.8+B7=ADB=DY@@;gRJ04F_/S1&fU#)5
)&7Z.6XK7I>,&M.#G+XR7cD&Df<VA:&(SP=^<Sc23&R9W@L.Je4(E_b8[-LJ\dTO
YP#1_g1W;Z#7<(C+8EEH>H49<H[PXW<ON(I1M_JSBf:87(57>9+NWJ@f2N+FU?]J
#@[>B.NZF<>K9PZ3QM[<;6A\B#5X1[\C:@NBZ-e6ED,1/0eE:LV7;3;:Nf\B06aR
?EW\];.Eg0/M._.:-1aS+]eK\V6LcND-+gMAD=A,I/DGJIV04VHeJN2->=LFe+K1
-MebRcPTP/?g\K(SDQWaL.Ef,MJZb[cZJ\GASGY7aSI+IaA//30aI45@GE(+:,RM
<UEGJ]bd;I68YK?:5g92L\)E?ACQE&NA4a8=+.P>)(LZHf(XFVXM>VB<MY30aA<X
@@O+KOVQDeK^RZ+E<(ZV6aXF>6W6eOM)^MaIP:[3/6Q51O66JP,YN#2cd4dLY(5\
?.&9<=3\H5L/6<0OZJWUW,+g#Q9ge;.=f@eP\C\S&.GcacBGc6@H<Kc8UTdI:?fE
-.58YB#Kbc5BE8dNGN8O\^LIM^+B4X6O,+]</^;UaDX^=Ag_7OLe0H;fCB.8Q.AP
WKdV_Z2R?gQ+RI-MN?gKX18T3]ZSfI).ZA7P;5VG2RU+7ZATSZFM8;?7Yb&RA>JL
(bB2PRIS+?6CM92@bNU(b+7@I+,FDFO5U94BBJVZ]_9J4HF)9/d+WN_0f+AW=J#^
@+1cb2O\^KY?H:0@YWSQc40N/\/G^3ON>_2QI<4;)Tgf#MV6cXUW[4g2Fg^^+Q9@
2W.8B6)&X][_KIa]QQUGESB5W+H59\@bM]AXM6QJQe)?8,K3ZVE=?;LNZ[]30YWO
gA=.?Ie#VNO<S)TVV6gOMVHLb=NgOCMM>7EB<-R590L5^N?T.BKMC)SYcb[C;CKD
,E_Oe+AP5)Y1)JQ@>Z9+8K-=AZ+:WZPI-[bQA.:P()d\e6D\I?&OD4Q?aVOSDP(F
HO7-R[XI9F\[35V+b5bTJP6=7YDOf/9;g0PaDDIdBb;[_3f=\BGY9Q8S<E1)CBC4
bA+B@7[X3-1)R5FN8]>>dTI9a4:/1D6)0)=gUIBC0cgIf:4A<P,.9_dO0TO2cL/U
7\\Ne6Q(J.R^F1R-<_UcMG<d.IM.6D-&E@<Z7&\;S:8&g6>(C1S.[DL.XL##bQ=Z
)VEe)QMW@V,(>5#c,3K-[?7V7?eL:XV,g\VI7X_F;@#EZVQW7O.;e6:O:Q&.S6e2
gLW(15ZU>(]N?.C(O\]UOf\4)/>Z&.IK/9+./;=6-5X\(Y0INQ4=.EV0JF9\9S(O
eJX>3CK=0LI8g:d>(V,HHO\693ZbfH8-g>JLKB3MZF<4FGV5,2CeT.:J:=KXg_G.
?2ZfL-#49L-9.56VAS,Y^>KNQK&UaP,Yba-fO2U3NND71J&bM]NaOC.T<7Y\aA2I
M7ZLVVZSL(7/K+3^NI=>f33V09UX^I?+Y;<2.I0,8H,CeT\_-9M/,-#D6f^acHRI
a^e53.5PSM5Ze>J\d(6]DdYOfHC6)fE9GT1?EG27?V\b]Hf5[A@[)0GV&Z6b;].F
;MLRQUc\T5PgeP^0gLBE1=D7MX5(1)c+dS>.E?&YeJP6,g3Uf9RcLSUdfQ31CXXH
:9g^R^;\P8WG=cWFLGL4/7S3NXSN)@]RT156B-8d_2+(ec&BOLI4Q#KJAH9;5cO\
c62]a83:fDF]>\:R>5P;PDQA/-#0>>RL+NdR+_V_H9_8Z#\5RAQ);T;+D>T<)UVG
RcQ1[&-4--(MHReOFS=R^UFJ5g7?SAfSW:HT/9=dgag;49O0<5dOQYTP)Cf2a0I7
C3,-&C4+Z?g/8L]4Q=.OL\gUaAMSed.U(4MFS:,e=4:BV3R7,[H9RRMSPYN.Y8JM
ED)HVe44cAOI1XZS+AaUHW.SX@7=f\4F\?VI1GZ,9\:BB$
`endprotected


`endif // GUARD_SVT_PATTERN_SV
