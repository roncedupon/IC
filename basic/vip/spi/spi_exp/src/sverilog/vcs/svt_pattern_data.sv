//=======================================================================
// COPYRIGHT (C) 2009-2015 SYNOPSYS INC.
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

`ifndef GUARD_SVT_PATTERN_DATA_SV
`define GUARD_SVT_PATTERN_DATA_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * Data object that stores an individual name/value pair.
 */
class svt_pattern_data;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  /** Property type lables used when building the pattern data structure. */
  typedef enum {
    UNDEF,      /**< Unknown or undefined data type */
    BIT,        /**< Data corresponds to a bit value */
    BITVEC,     /**< Data corresponds to a bit vector value */
    INT,        /**< Data corresponds to an int value */
    REAL,       /**< Data corresponds to a real value */
    REALTIME,   /**< Data corresponds to a realtime value */
    TIME,       /**< Data corresponds to a time value */
    STRING,     /**< Data corresponds to a string value */
    ENUM,       /**< Data corresponds to an enum value */
    OBJECT,     /**< Data corresponds to an object */
    GRAPHIC     /**< Data corresponds to an graphic element, used for display */
  } type_enum;

  /**
   * Display control used by the automated SVT shorthand display routines
   * to recognize whether an individual field should be displayed as part
   * of the current request.
   */
  typedef enum {
    REL_DISP,  /**< Indicates field display for RELEVANT and COMPLETE display requests */
    COMP_DISP  /**< Indicates field display solely for COMPLETE display requests */
  } display_control_enum;

  /** Depth used for the SVT shorthand routines */
  typedef enum {
    NONE,  /**< Never work with the object reference (e.g., Never display it) */
    REF,   /**< Only work with the object reference (e.g., Only display whether the object is null or not) */
    DEEP   /**< Work with the entire object (e.g., Perform a deep display) or the evaluated (e.g., based on accessing the calculated 'get_<field>_val' value) value */
  } how_enum;

  /** Types of alignment during display */
  typedef enum {
    LEFT,    /**< Left aligned */
    RIGHT,   /**< Right aligned */
    CENTER   /**< Center aligned */
  } align_enum;

  // ****************************************************************************
  // General Types
  // ****************************************************************************

  /**
   * Simple struct that can be used to convey the basic 'create' elements of
   * a pattern_data instance.
   */
  typedef struct {
    string name;
    type_enum typ;
  } create_struct;

  /**
   * Simple struct that can be used to convey the basic 'set' or 'get' elements
   * of a svt_pattern_data instance.
   */
  typedef struct {
    string name;
    bit [1023:0] value;
  } get_set_struct;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** The pattern data name. */
  string name;

  /** The pattern data value. */
  bit [1023:0] value;

  /** The pattern array_ix. */
  int array_ix;

  /** Property type */
  type_enum typ;

  /** Class name where the property is defined */
  string owner;

  /** Display control */
  display_control_enum display_control;

  /** Display depth */
  how_enum display_how;

  /** Object access depth */
  how_enum ownership_how;

  /** Title used in short display. */
  string title;

  /** Alignment used in short display. */
  align_enum alignment;

  /** Width used in short display. */
  int width;

  /** Field bit width used by common data class operations. 0 indicates "not set". */
  int unsigned field_width = 0;

  /** Type string which can be used in enumerated operrations. Empty string indicates "not set". */
  string enum_type = "";

  /**
   * Flag indicating which common data class operations are to be supported
   * automatically for this field. 0 indicates "not set".
   */
  int unsigned supported_methods_flag = 0;

  /**
   * Indicates whether the name/value pairs should be the same as (positive_match = 1)
   * or different from (positive_match = 0) the actual svt_data values when the
   * pattern match occurs.
   */
  bit positive_match = 1;

  /** Additional situational keywords */
  string keywords[$];

  /** Supplemental data about this pattern_data instance, potentially situational. */
  svt_pattern_data supp_data[$];

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_pattern_data class.
   *
   * @param name The pattern data name.
   *
   * @param value The pattern data value.
   *
   * @param array_ix Index associated with the value when the value is in an array.
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
  extern function new(string name, bit [1023:0] value, int array_ix = 0, int positive_match = 1, type_enum typ = UNDEF, string owner = "", display_control_enum display_control = REL_DISP, how_enum display_how = REF, how_enum ownership_how = DEEP);

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

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
   * Method to do the value match, taking into account positive_match.
   *
   * @param match_value The value that should be matched against.
   *
   * @param is_found_value Indicates whether the match_value is real, representing
   * a found value, or if the field could not be found. If is_found_value == 0, then
   * the success of the match relies entirely on whether we are doing a positive
   * or negative match. In this situation a positive match will always return
   * 0, a negative match will always return 1. If is_found_value == 1, then
   * the success of the match relies entirely on whether the match_value compares
   * with this.value.
   *
   * @return Indication of whether the value match passed (1) or failed (0).
   */
  extern virtual function bit match(bit [1023:0] match_value, bit is_found_value);

  // ---------------------------------------------------------------------------
  /**
   * Method to look for a specific keyword in the keyword list.
   *
   * @param keyword The keyword to look for.
   *
   * @return Indication of whether the keyword was found (1) or not (0).
   */
  extern virtual function bit has_keyword(string keyword);

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
   * @return The real value.
   */
  extern virtual function real get_real_val();
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a realtime. Only valid if the field is of type REALTIME.
   *
   * @return The real value.
   */
  extern virtual function realtime get_realtime_val();

  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a time. Only valid if the field is of type TIME.
   *
   * @return The real value.
   */
  extern virtual function time get_time_val();

  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a string. Only valid if the field is of type STRING.
   *
   * @return The string value.
   */
  extern virtual function string get_string_val();
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a bit vector. Valid for fields which are not of
   * type OBJECT or GRAPHIC.
   *
   * @return The bit vector value.
   */
  extern virtual function bit [1023:0] get_any_val();
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a real field value. Only valid if the field is of type REAL.
   *
   * @param value The real value.
   */
  extern virtual function void set_real_val(real value);

  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a real field value. Only valid if the field is of type REALTIME.
   *
   * @param value The real value.
   */
  extern virtual function void set_realtime_val(realtime value);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a string field value. Only valid if the field is of type STRING.
   *
   * @param value The string value.
   */
  extern virtual function void set_string_val(string value);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a field value using a bit vector. Only valid if the fields which are not of
   * type OBJECT or GRAPHIC.
   *
   * @param value The bit vector value.
   */
  extern virtual function void set_any_val(bit [1023:0] value);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for adding simple supplemental data.
   *
   * @param name Name portion of the new name/value pair.
   * @param value Value portion of the new name/value pair.
   * @param typ Type portion of the new name/value pair.
   */
  extern virtual function void add_supp_data(string name, bit [1023:0] value, svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * Utility method for adding string supplemental data to an individual property.
   *
   * @param name Name portion of the new name/value pair.
   * @param value Supplemental string value.
   */
  extern virtual function void add_supp_string(string name, string value);

  // ---------------------------------------------------------------------------
  /**
   * Utility method for accessing supplemental data.
   *
   * @param name Name of the supplemental data whose value is to be retrieved.
   * @param value Retrieved value.
   * @return Indicates whether the named supplemental data was found (1) or not found (0). This also indicates whether the 'value' is valid.
   */
  extern virtual function bit get_supp_data_value(string name, ref bit [1023:0] value);

  // ---------------------------------------------------------------------------
  /**
   * Utility method for accessing supplemental data as a string. Only valid if the supplemental data is of type STRING.
   *
   * @param name Name of the supplemental data whose value is to be retrieved.
   * @param value Retrieved string value.
   * @return Indicates whether named supplemental data of type string was found (1) or not (0).
   */
  extern virtual function bit get_supp_string(string name, ref string value);
  
  // ---------------------------------------------------------------------------
endclass
/** @endcond */

// =============================================================================

`protected
UML0g6bF^O2H4[C/a-\SQ;#DJNBYEL^1DdV):/NH5gN\-QdGgI+1))KPf#ODeJa<
6K/R(,(fHGQKI=Yb3Pa\@[[#7]5&&e8fOXE@R-cL&0J+4b#]::KL3=V,bB]IZf]e
0bHIET5HfbaIQ=:CQdO\Z:QR6=F<fF9-VF:V3b<VTW>6e\9Y8/6?Z_cWVE#P;e^Q
=e?Y&D[FU)4R2RD^VW-^;aC&J:)EO^1@^F@&M?@gL?X<T)B(bVS@cgVNN\I^F+ec
gYI^SAf\EIX=X98FWG<WG:0/\@B_-SHJB)+78AXP7WV,bG_^@:1^QKQ,H4XLKgQZ
GA3=+4>gU,QHQITHB#0Y:8ZM\21;0->LB&-Le9_P8af9O2XI(,IPU-NSegH4TE]b
)V]X3&N(9e<F](3-2Hc&E/95G@G4[>6K3Q]\>AP_<]DKg#G=@CB/:Y,:PD+/5E=W
JXQA;/I_8MPV88/@&#G7A(N-FCNDfFUV62N4&gS[@LcHW8MHTebTI9Oa@B9RU><=
]+Y&A3D[:2(;508@+4dP4J0fA/OVeFU2>A\1D<LOMGA5=CUU#K:OP_Pe3[3@^<4T
B,aK1>;dcMPJg]^:g6e,.(8-;c8[CR,SUY[PWQ7<eQ7_F^=N6S>P)-KXG&4537aV
(YQYB<)6VHD87cEb;P/cYVXU).GL:fZ7E;\K9S(_-/IaNU3G5g-4DW,[T\XEKIKa
99G>(TXgEKFOQ,0MgJXJ+5R>Z-;1Ue2g/LDNEdZ,_HDPMGaSWBa=3aBPJ_]MY7Q2
0@90J6_f,XaBP&Bd9APHNDSb33bHF+36-09cGX1(;7A:;4Y(gJ?AdO<:UXR80N>F
H_BY<U+G^Jc@^3Sa[]R->(BSB]&TYJ_/ec#J2SE-fPb#Y-W?ZeHH?N]PDUdC,Add
E?I.31fWQ@QZD2ad,BHbKJ/2C6LH[O:/^LLGXE=01]7+=)RHaRI,NN\cVKfJb;+^
4RM_F[\M7=B>Cb<5bg&-I]/;;1+KK=VBWQ5\UNR;:-<+60RV[Y+5P0E.;=_8Oe.G
1QGbaRBXIT0IXPP>3^#\V7P:EfY0:7,]W?6\fOd&^:EQ3A=RYV0E9):GO:Z\F_P\
HM>]JL]YJ>)7T;:^P9GO/gBa01gg^>Xad[->W)Q(.JE5C.7L#]#E[&CGT1JEPW>8
?PQIZM,H:FEaR\5Q3eKQX-C;JDYBAO&V,XFTY(3@-&b)3f4]_\O(TL_^1799_-O9
Q&8edG#N+IdX>B-@2.c6Y,=8M-I:M(g^dO)(,9LW=W,21[J@800Udd)?T3?I=6Te
?>B8K+Q=.gN=Ee.:)8-F7.Z5Wd(]UDA_LZ2EfO=Rc<a?>NT<X5HaJ3CL7WIV17MI
=A)=g\CG\<YKAf<AMR4=cGKDV+_.dK,+[b&)A5HL_?Kf(-:Ff=(I[-8C3e;89,:\
MEI/EC.]EB0f6JS4/IfTJF_.1DTEe,X#=&&1HN1Y@UGLW-B@>Z0S=4c\/HM&NO>:
Z)9JF3GR3J;S#+fHfN?C3+1Z(JH6d5MX=B<GIQ1E&S8#N8^cHNR;/1>4>N8H+TIP
O7Vd_C1a5U[DSL_4TCg\,<X];-:dI8N+YPYU8[fABSM9.EP4FL(YdDe8<JWMCDS^
X)&D#^c^N]-=7?2,K_TB),Af\F/TLPOCGS),]:b1d)5[R2L@dF4AF[,OI^NK:_c4
BCL-^:R8&J;5<_5PBO4<@gd/OdgYeN_?#.P7E9;:)1+;H9IC;<+S_IMO.0\aU3,?
f6JOC6La10ZQ_fXJ=1\+=2D>De^W20MS_H\I\.b(a3=+g2WCTIWHf(,PCP?Y/QW@
[4eCAY6#>I@dA41RY?d9-beFQC#BeK.0P9Kg1(@b/+35QgPJagg+;@,K10Z:,0Z&
NdTP@Y>Yf=1P[P2\>5TT-gU]a[WG@>]W?\e4fDTA+DdRG^d:VRXBUN8,A?_@5C22
76>8N4C;?QQQBK,_5[P./IgP8BW?d>LO#XHgMBDJg,2/>2JA_8NXd_T\W)2PWXf#
@F3Y+#+Hc(G3[0S\GgICd9<]).-Y^_0>DO=?2H3RA^a:QZGGgVJR8VP3NLB>f/gV
4e1BP/([)7f:\9]ZN-@8<Y>K9L^7M8)N)7^0)U,SF;DU3,8\86+)4L1X^dXESDR>
5;g>f?E/gT^_<4B411C>>>2CSZW1)I6F_[4#<N6L^KcR&4fA[6RN8QFV60[O.8-U
gH?T^A</fd6cAH85&<WH.ESYDS+NeH^Xa6:QXV_=-8g[dOL6HN1#^;=5U?1.N@KE
8_EDJG):O3Y8GP,R_E<NfQ2[MT+:5WS,7/]9K^66((7B5]:#QZbUH40F(OR&JKQc
,#8-\MT-.GFTU<5d#N;a_Tgf34]gT&QU7W^,bC?E2fMUgC-ZA/=\S>07+(<4(fBT
D:Z+,c[&5VW@&F&YK(bO411(8-49W#[gLT&&0e@ec7;K(U?X_=08\1c-^PH9Q],K
@&3A#3I9=HR?,=gEBC-?X\H[K]P^H60</M/H^8cB_?f2=7-26UJ/D[=KPN+AJM6H
,?F]d@YH;=#(PW-1O?;cNH/P^#13K.1F(EUDfQ_I]R/PF9RAWZfWE+YbB:E#,>MC
J_e\H8Rf7LBPV7OGd&H1cfXZe2?[HGEgd0/ZV9UHT&IFM4,R>eW;E2&DbF@.3\=3
7b+b4\04DYJR+&XD=D5M@f3a#c#\ZBg2&6RCHI.#Pa,OPX]7c9eYGG@A0O_O#M;_
V0#Y5[3^OWF_=.a9-2#c+_?5BNO3(8^U^AbV1^8<8,AYP(<>G,WJK@/Xfb@CB/E8
^]BbcG#H9IEcEgb04+]d=1N)&PSA=O83=bWD5SdL978197DA2QXZ?0YZBYeFF]Qe
YfgP@YWQ-a9-:Q1>2ABS:U[6>?=\M:/:;DS?cCCY-M-@:-0Q3OE1=@Q52/YFR\H.
7BCZRQEQUCJQAI1ZJN/SF5CH_2.:)84Ga@ed^+3:F0].LH]gFN;.,d3\)RR41C28
/0D1JN&d\EJVIT=\IC)1,CW49P_?=2c#:A\D6].58]758,]M[c9?VJ[[aDQ)TCOa
fOE9]KGd[C-eGD.>YfdW;^Eg\E6<@P@E8FHSY4(d&1d:+[&#&]/=Q);PQDUb1:D5
>E[FDdI:127.=+^;Y<4F;@L2cTHD[<K)58><#UB)OJaIY0QE0P9U(31Ha\Q<:7fa
2a:H-+8:<B@ReC-H0(Xef6X-]6.R13_H+a)W80FWCNH+/WJN6H.dcY=SCHM1QGJA
T0_I67ZLVH89Z(@-f9R)?Y6d0/LX)X]J9S,gJ2gfSG_T>LJRN>a.S\7_.2Dc#,JO
DRU9HfETSQ=V/,D4,W.DO&^:Q57S(7=;G+E=R=A-;Tf,KE6YDACJP=DBIQRCNYVf
fF^c=XJeOR-Id&.V]BVFQ,KYDbR[UHB[+#73&O7W7VDH(;9EGV>FebI>aI9?)SN]
g&V)d/;Q^9E&_1R;cXc.57fV]8Ec)4cU0R=;97f/\509J&B[]^BV[::XXY=:X;,W
37IC2^f<_MQS:HH?FOIOU.N.g_d9fX6N;?R9,:f39FYKGR]5JTWLVO[E-=C;T:ME
V-a(P[G9=PENJ#.RWN3K\<][V0CB&PbT1KTd;?3I:Y^UPG;NBO(:7CUMDHFGc7fW
ZV_#>LX-CGdce865c^;c=8+7._4_/>[E/TO+E92g7Y;C<I=+97N4Q@70R#87X2PT
>MZaffVPd:]/4Me7LX+cC52)Sa#B\RAHTRf#cbE?)C6IB-FU&-I=;e2eC5&BY(>T
a1FgAbH:/IEJ0T5Jdb0T_((^gcdW5-#-#[(UP&QfCSPG9;,Z8+7\;M^eAJ>@g;2f
W2)\81U]FLJE@efRR-@DP[WH@fMVAfRPCC=Fa<6;+47^&D[O)ebc4BA/T1e=K/Bf
)8YU._ELC+?9P2a;<K<_#g#9gH4(_\Q/\VTZge9Rf+Hf1c5#:H358W&(>9R<]D9\
OSgY#@U98#5@bVJ?QQbLg#53GYA-?cY#Z?^W;VWYAD<IKFEI6.AQAX7;@-9ISbSA
4SI/J<E&;AH2W\Z+>AVJ?B;T3a7.e[O.4I=77Q5e/_WW8bC&5ZIeJB&QVbU7YG9Z
HT(Y:H?KHVg9EROcNgGTgdF8,29Uf3P]>MDePBA9K.)K__IX.R,-L:f/,,1\Y^D0
@d1(=Lac,6/HAA-FF,_QU=\YMI.e7RNgDSC1II9]V_aQ8I#>7[^XgF^B8b3a\P/7
aC8SE0W2/.A:D<AA7<f(@:NI^.<;X=WWfJX<Z@d)5[@J/7L7J4.5#R3?&[a:@agX
E8BEEVN3/C\>AB:3FT29BS?aD24bJX5fY&.@.WGRg87ZaC7BeTJI6UAO9aLUYT(;
,S?&Cd4+R6aUV0ZBVGT5[@1YK.c_VA(>;/OgQSYPK,P=PR6c:4cQNd@WQ:1,DJ?V
(g+UTOIHE,=OeU&8,2A8E,J/8?6&1?8J[0&.>JZ6CREO@@_R_WSO_T,dYQVeT#-Q
.bQ_((4AWWVQ66A:4@;\8Pc?-#?UJ]d6:bVFA[.,E15.&Y.IDV/0[#UCa4YcM>BD
0B/T]KE.TBFEFY]4GJc4^FA>Re]R;[eQ[T.BUB8VB=;)c?G,[Ff/Y.&XZ7^E0#[L
?H:@@L(+9PaX>cdRT.PWVH\LRJFc,:PY_WfZWL_Q\?3H;a[1,<(GS/&<e,PDDT=L
-&]AT,6GG(^(IcC(.=L]=ZfY7T9QZB9:\7A,GN+S-O[3IO@;_\10W^bM+6&Z(#a-
VT&_g8R637O23O>\E)^c;0DR#YR=+),JVYaL@RS-#P1g^S(P7a(@5-621^C8;RgD
fJ;IQS8b_bVDF2K/38Y3Ucb+Cg^^W/eF;+:OPT97\[[bGB47#d/@aO,F9O2BX40G
+12g5]@VG7]9M.#S]BFL^[e:#1FY2b9)52cA.MDODKT7&P]ef3cUd/&[d&=KgRf?
9Q_FMI0KE1\E6NQCS;T(ZBWT8Ff1JXG)\IJEdR9ff02ff?PLB(IbRF4b17bA?OTV
aXd7.NI]P+<SYW#<FUB-8(,SM\^O?eWFTgH4:@a8eC)/+P\^\-N>=QN]LeHCEV,U
TA_NQUJ^Y=HWBf\U=YM.>_\@]f5N3X#e__?f6)=6d9B/#JC;M4U<YZ78Yc[QOCA>
>b_M0fe94]KAO6M1.._?6I+AFJ0./(^(g9XWOb?]#b\;[PDOO<&E<cIS6&JA)e>3
MfX,/2Cg+5SNX=D9^6S(a#g>5<@Pd)]9M0<D137WOHI];>.\UT5;W,?8_e\-][3O
PLW_EfX@FYI;T2DJR72]V6OUH99V&gT[eX?-Fg\+P(:CbTW5+.E+\NHM\W<7==55
((cB&Qf;&0&D-WRf&[b.+?^J-Je2]MA8#@RURV^FMR2<HB<=7=Rg8WPOA2(,3-\5
HQ[D1(D9.D?/<WC)IG1X+Lf3fKRS;aeVdM3TQ[caEJHc;>9>1U8^<R>:6cTeF(G1
<&?gKP9[;C3gZV5dE=.MQ=gPcR&:(YGAeM;e7d94)R(NN/&35J7AW6GYE0D2N50?
9>]H55L&<4F:3SBeg9dE\=BA5=JF3BgENgISG^_LZO[1BV/>gK7O[;[]G@.G7F7R
]B=-eMJ4_?cW&3@_79Q)/-@?EGG311DM[26=Z.W;J<\V=7=:Oa\5QVV#-_ff83;,
7J]O=W8C3T?I46I6D0?NJ>NX9LYY&K7B+XU\=L&Y::[&)gQad\3>Gc(Z=(d:,D(K
BU5P8W9S4=J4IcC+^\O-CPDeL9BA+>aWM=cY5NeFFH]bRFdZ<_\:U8:0[PO8@6R?
[)G^)0[U:g\CXB9cV8NT7,cE,L+cRe\A_?FVG^X[aSbRV>RdJQ22A89=9J2Sf6G?
0B+,Q-)S\eGK9,c?0S5c[[=_bUMZWH[26L(UE>UH6Z[]YF/#g1O/eF9@f\1]8&UA
8OMZEECRN\BQb@:ReXD735FI7+[Y&4ce-7Q@,167UZFg[(CgD+d/I>F=HgET79&F
UALN[@#P05/WK3dU6;fbXa/Qga8()>GPdI>:Uaf[7JM:dPf/Z#>c1781KUOA7d.d
8X&GgFBbMP>OH2JTAA;C)3eeKXJIQ<4f2FA&KIRN5WS>CELFLRCK@,c7&;\(V5+(
IL9RA\gaY\NF)4S?&SQb+LZBLR]M-_4O,)3P5?[DbAPJeZ<I+e6NES)dQG@9VP3c
^O1+84[(9B<M.MeKgE/Y6-)VZ0K2Z<THP?Tc9,6FY&L/?LT4-ZLS5]9]Q2A_LVE;
B]1FJXIGRQaSZMbO.#YI-J&[0KIHUb^#9>>OaHffXS,(VR=&=4OCVCRae5WLYTG@
cV&/OTU[UCQ+FEJ.\cc^@5[J8OLD@.,49F>+06S(g74CaQ#ND[-.2a>Q57G[?Q#?
ZbJBB24N=5b18-0HB#eV\0A:=;/5?GL9Pb(\N@P?D8AgU6PQX#_R(VF60SFB141B
f]KA7;WW)@A\O1a@fJ8a[(RAQHB]D;L@G8a8Nf,^>/bU+c<gRC;-@b0=-V(M^O^^
gU]&\Z?FV0fZ5T#;<B=ES-L0\;>;PS=O@RNC,F(A)U.#0#COC2GeXCUB5@00>K6B
87-).Z;ABK&.@NVB18JTPN-2<?RAZ[P5A(f28H7UL[8WM;U/=NEf+/U@TY6;LAf0
1[W.3O6>6FFVKVLZPD2LR]BGD3KW]0OD7J9)K3(1U#KOIFIKKB[Ua6a;\Z(655,e
,KMT+5IXd94HAJM@/bH(Y=4@.\B/gW3S1F4CQMH]bHS+c-+_dcHSR?Y[3-^g5d4O
(U_X^YO1f>.08aHB<3GM+N+]W_-g+,GORHB6/DFL[>L?6:T5U)WU6>&ME6.&S12T
>H\+2;B/-N5.NL^A=CbA?+N@POI9cWAbG:C^<Te[W>=1bZ/?]V=@8_,X4PB7R@IQ
8TfegG>/G]#_Zcg]7/9NUIB]Z-53_7C]BA_>Ue)@L2:K3@H>7UZMXCg7?&:5KXFN
>B;WcANLT?Cg^EGV,RJD0SM.JXR?35<G=/))=^6]ACN\eP_K-GDPPHC?BB9R;?6H
:0J>K@d&f7I+V&6a]aD05T,O<T,&24&VS8P>2#NW.F\44?2.>AV_\a#?CgI<+V6;
TaI/BM&bQC57EE:#(OV04Z.4];Y[6>W0#B6BTG1\?<cJP;//#8__:aK8-,A<W/:2
VTcBN:BDF:.cTZB]VfVN0Ea.\#0?,afYf\&8LZFe(><W@.a3=WE0]PK=7YE[YWB&
X2B_)e(1)L-=b2.a?0B;=+e93^_dbb^J0c2RL.@UFfC;NXccNLDHLVfU#O8GD2&a
HcfM?^Q\-gK71EW&<?D&_F-?R;P5R5dZX&2797GMA10+HDT?KK@GTY#9b\<#+d.6
,dg?c@]B[PMN50OW-WAWV</GUa4g^9S>0O2d=B9.6ZAg[O83e[Oa<@P,eT_.7B26
@RcEXT)A]6L<QAJ/M7X1,>a(gX6N6fJ?&J,X,2Yg-ceE<P1d[/P=K9C89eD@T511
&B^LM0QU@b-1H;_0VHcHSL>Z8S<>cE\#B3Td[\B6KeBGHFbg[2<O/Kfe,4WcNJ1f
:51EcL8>c9ZQ;LY;>8IJ(0=.E6M)L3,(&7(KJ0H7X-H=K]+EF)G[W2J69[_G7DSQ
0Z9/e6&g(dIV6@S4O48^-]N5+)[=<DX-/QA:=N79LgGKK0DG&(GODDcL5g8RD+F1
>.]GQ::1WU7HVH8J.8_,.F33QEV=-W8DXd.D8]G2EeW#^@?gE1GX5HIT5d4>(&K^
-=fAPID34R86L)7DJZ>e.M333$
`endprotected


`endif // GUARD_SVT_PATTERN_DATA_SV
