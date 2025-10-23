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

`ifndef GUARD_SVT_PATTERN_DATA_CARRIER_SV
`define GUARD_SVT_PATTERN_DATA_CARRIER_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * The svt_pattern_data carrier is used to gather up properties so that they can
 * be acted upon as a group. 
 */
class svt_pattern_data_carrier extends `SVT_DATA_TYPE;

  // ****************************************************************************
  // GeneralTypes
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** The properties which have been stored in the carrier. */
  svt_pattern_data contents[$];

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_data)
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_pattern_data_carrier class.
   *
   * @param log A vmm_log object reference used to replace the default internal logger.
   * @param field_desc Shorthand description of the fields to be created in the carrier.
   */
  extern function new(vmm_log log = null, svt_pattern_data::create_struct field_desc[$] = '{});
`else
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_pattern_data_carrier class.
   *
   * @param name Instance name for this object
   * @param field_desc Shorthand description of the fields to be created in the carrier.
   */
  extern function new(string name = "svt_pattern_data_carrier_inst", svt_pattern_data::create_struct field_desc[$] = '{});
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_pattern_data_carrier)
  `svt_data_member_end(svt_pattern_data_carrier)

  // ---------------------------------------------------------------------------
  /** Returns the name of this class, or a class derived from this class. */
  extern virtual function string get_class_name();
  
  // ---------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow command
   * code to retrieve the value of a single named property of a data class derived from this
   * class. If the <b>prop_name</b> argument does not match a property of the class, or if the
   * <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1', with the value of the <b>prop_val</b>
   * argument assigned to the value of the specified property. However, If the property is a
   * sub-object, a reference to it is assigned to the <b>data_obj</b> (ref) argument.
   * In that case, the <b>prop_val</b> argument is meaningless. The component will then
   * store the data object reference in its temporary data object array,
   * and return a handle to its location as the <b>prop_val</b> argument of the <b>get_data_prop</b>
   * task of the component. The command testbench code must then use <i>that</i>
   * handle to access the properties of the sub-object.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val A <i>ref</i> argument used to return the current value of the property,
   * expressed as a 1024 bit quantity. When returning a string value each character
   * requires 8 bits so returned strings must be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @param data_obj If the property is not a sub-object, this argument is assigned to
   * <i>null</i>. If the property is a sub-object, a reference to it is assigned to
   * this (ref) argument. In that case, the <b>prop_val</b> argument is meaningless.
   * The component will then store the data object reference in its temporary data object array,
   * and return a handle to its location as the <b>prop_val</b> argument of the <b>get_data_prop</b>
   * task of the component. The command testbench code must then use <i>that</i>
   * handle to access the properties of the sub-object.
   * @return A single bit representing whether or not a valid property was retrieved.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow
   * command code to set the value of a single named property of a data class derived from
   * this class. This method cannot be used to set the value of a sub-object, since sub-object
   * construction is taken care of automatically by the command interface. If the <b>prop_name</b>
   * argument does not match a property of the class, or it matches a sub-object of the class,
   * or if the <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1'.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val The value to assign to the property, expressed as a 1024 bit quantity.
   * When assigning a string value each character requires 8 bits so assigned strings must
   * be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @return A single bit representing whether or not a valid property was set.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  // ---------------------------------------------------------------------------
  /**
   * Method to assign multiple values to the corresponding named properties included
   * in the carrier.
   *
   * @param prop_desc Shorthand description of the fields to be modified.
   * @return A single bit representing whether or not the indicated properties were set successfully.
   */
   extern virtual function bit set_multiple_prop_vals(svt_pattern_data::get_set_struct prop_desc[$]);

  // ---------------------------------------------------------------------------
  /**
   * This method allows clients to assign an object to a single named property included
   * in the carrier's contents.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_obj The object to assign to the property, expressed as `SVT_DATA_TYPE instance.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @return A single bit representing whether or not a valid property was set.
   */
  extern virtual function bit set_prop_object(string prop_name, `SVT_DATA_TYPE prop_obj, int array_ix);

  // ---------------------------------------------------------------------------
  /**
   * Since for do_allocate_pattern this class simply returns its own contents
   * field the expectation is that this will be processing a pattern made up of the
   * original carrier contents. Implying that it already has the values.
   *
   * If a simple check validates this to be the case, this method basically just
   * returns as the values are already contained in contents.
   *
   * If the check indicates there are differences with contents then this
   * implementation simply calls the super to let it load up the values.
   *
   * @param pttrn Pattern to be loaded from the data object.
   *
   * @return Success (1) or failure (0) of the get operation.
   */
  extern virtual function bit get_prop_val_via_pattern(ref svt_pattern pttrn);

  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  // ---------------------------------------------------------------------------
  /**
   * This method modifies the object with the provided updates and then writes
   * the resulting property values associated with the data object to an
   * FSDB file.
   * 
   * @param inst_name The full instance path of the component that is writing the object to FSDB
   * @param parent_object_uid Unique ID of the parent object
   * @param update_desc Shorthand description of the primitive fields to be updated in the carrier.
   *
   * @return Indicates success (1) or failure (0) of the save.
   */
  extern virtual function bit update_save_prop_vals_to_fsdb(string inst_name,
                                                     string parent_object_uid = "",
                                                     svt_pattern_data::get_set_struct update_desc[$] = '{});

  // ****************************************************************************
  // Pattern/Prop Utilities
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
   * @param array_ix Index associated with the value when the value is in an array.
   *
   * @param typ Type portion of the new name/value pair.
   */
  extern virtual function void add_prop(string name, bit [1023:0] value = 0, int array_ix = 0,
                                        svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * Method to add multiple new name/value pairs to the current set of name/value pairs
   * included in the pattern.
   *
   * @param field_desc Shorthand description of the fields to be created in the carrier.
   */
  extern virtual function void add_multiple_props(svt_pattern_data::create_struct field_desc[$]);

  // ---------------------------------------------------------------------------
  /**
   * Utility method for adding simple supplemental data to an individual property.
   *
   * @param prop_name Name of the property that is to get the supplemental data.
   * @param name Name portion of the new name/value pair.
   * @param value Value portion of the new name/value pair.
   * @param typ Type portion of the new name/value pair.
   */
  extern virtual function void add_supp_data(string prop_name, string name, bit [1023:0] value, svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * Utility method for accessing supplemental data on an individual property.
   *
   * @param prop_name Name of the property to be accessed.
   * @param name Name of the supplemental data whose value is to be retrieved.
   * @param value Retrieved value.
   * @return Indicates whether the named supplemental data was found (1) or not found (0). This also indicates whether the 'value' is valid.
   */
  extern virtual function bit get_supp_data_value(string prop_name, string name, ref bit [1023:0] value);

  // ---------------------------------------------------------------------------
  /**
   * Utility method for adding string supplemental data to an individual property.
   *
   * @param prop_name Name of the property that is to get the supplemental data.
   * @param name Name portion of the new name/value pair.
   * @param value Supplemental string value.
   */
  extern virtual function void add_supp_string(string prop_name, string name, string value);

  // ---------------------------------------------------------------------------
endclass
/** @endcond */

// =============================================================================

//svt_vcs_lic_vip_protect
`protected
S=.0-8P-TWV\EFN&e&a5O7;VfSH^M/Mc[077P9O>bW5:AEK&a:2B1(b_=JdY1W3+
OU@25NcZ]Bd1dPW^4?GRZ8;fP/</U^H)\gbBJAS@9\A)3DLOGZK5-e&S+3]4PG6I
cg_-;#IVOg:ebN@KG(LDPX\Y=6B=Z4P;cHM#f.:0O15)fFG>J:+EGX^WUXV<,M]d
@LeA8[c</g44B38Ief1IPe;,^W@a-G?CSMaTLO1eY,A@@,L4F&Q([6<_DUFOA?W8
GEC>-KDD]BMQb3(]/L]WMC0T2?-;5RZ#M4M-X+cDQAR;;\G2(MV&8a.G#.^db@.#
AR],>Wb7=:J]Md?>cF]FTFc751.8>aFc?R>.>?Cg/gHA6J62-LTC7^[(UWcaEfJ?
KF2JS21_213J;83ZLPVKAA>=JUfE,]6>[,Se(T),eM(7?64=.T[N;;A59S&U<N6^
&9[e-AC-LDPc,9U1d&V0)=C,Wf;c2BI?<AbI]+LO1AVUd_-+7L.3(Q=c=6,TRJcY
8df^X=\L?3-e)I)//PX-FY2B;F7ZF]0I^ILVc:\O=PO5>+QG76:F:CS:@GJ1/W8R
O.\7?U67#P6.).+RFIgM+&9Q,I=?==W>:]gRg^H><K)2Z1ZY6QOF^JRC4X3G@=@c
^d3fHY0;\g&BKeSV>AC5D(INE(#e,g)F4H3^0BRUe+6UW1<=@J&-eVc26&B])E&[
OI#Z@V=+4_+XPM#E</I#161QfA0gV@UL/0fRX#LZKQN?N(>ZJBV@3N[XW(a2:POO
TGgM4__ac>3Cc>=1HDZc2D1c4I?-HK/FY]]<2VG.>MO8\)-\&=+d^KJW;Wg=:XcY
b[1>\;HI-[I0A8^Q\=?/a=Ng4FE6)g7M&SBPE7\_3;F;E:TY5_\QH,\:Q.3b54+U
]eCMBfM(&;LGJ\/+TA3c0=JUUDbce#2VLc-58723;]B5>Y##gMLAY<]0AdEQ_L#\
ge6?G@&=(gBF^>D.N0ND>W+T8^L>D/RPDP8;TRCI6M41J_44YM@]=bHY01-UQ(0M
UURLdH:g_378]b8\?S>O;(F-Y?Qe2)+(#g]b])gJ/K,@6QKDSVANH]C#S=8@A\B;
6_8=HfKaWI>dAHI@]1\/4c(/-PXHI1>d_a<e<J,(g(Z-D,+D):7X[#);0^W_#I6R
gOJ=AWAaO&(2H.BIT(G:?3V[8I8D5YZ5RR0+C0cHMH.T<B]T_O0Kf</Z90[D-0a-
)GIM,1L5Cb#BS/L5?/8R5ISTMKZ_3ePd-P#[34e+0;5_Re;,SbeZS\W_1RIU09Y#
&eIMXIU)-d^TLOG6BQ0T_BERB?>V;B.6G;,.a/(-g:c,FWV1QQ]O0Pc>gG)5C;&?
WW)aFZ]6V7Q)N:]3#)+SD/,#J6HICERL#W3)1\WMNF@D:HI,F]F[/57_PA<[R+dY
GO8bSAfEUf^aCb+T(AHe&a:d(LG-(,^/c(+M#36+<d&I<QA@Z5@^H7V7>&XTKYYS
[##Sd?7g1[GLd.K9G<O<+b;7Q4PXRb2\Jb\>+,g]8P@\QB:@R1:?I3A2Z+OM3+\A
bGfT-/PS8;F<e6MKSQ0e&\XBgF)UEeC<UDdH4LQ-0/LH8(9EU233MMA)GCdVLO5]
Q.b9/Qaf<U4d++fNM]X]N@2A?7D@Q_dHSQX?CL9K^+QR?MP1Re,4:D:[5>D=2XOU
(E&D\R5IEAW.KS^g(@F0;,H6Fdde)V2<9aWaGS#/P:IP#<W2B6]^MHUO-N(a9GG[
5L]T./V;.D4.]11K5^RcL>2^aR]?gIgY>]#20@.2_eg7fC-\]LMU\3T45c9A[_,L
1b&XBcP23gF.5A^N.BJ@RTfT8NOb-Y&7,669.TfNT-3B)C318P<;0&V5C;e..9XL
dGePfJFAAGI<Q\R4X7W:EeECI+gPc]8W(7f-SGQ_J3ePQZ9TX21T]87ZZNYS=&d<
b6,#aWdVfZ77#I/VDgGCeOeZ&J/]Q:GX<YEF\K7>VHU1daW),B[VO@X@R5ZaIAA@
2PA?5L\.bC5:;362VJRY>f;?^F2^EYZ-TXLLW\+V>::bORTL-Q1-)+M:;6[==_I/
:8-O]@?BSO\KS9+EOd7^cH6Y-B;]W1&eQH6U;@RU_2OJ9FM8-f=@eL6SVEOg0=],
\Y-M:D>>-6UB[1QeXdCG@1_=A6<;06YdE,/88\>.e1=,8eHHW\c)LR+KL/R9>XW7
<eZ<I1[EF-8g-01Ka0DAZ8#DQ2\2N9,-b<;^L2SC(#Uc,B=N28R@XId448MM+K2Z
N4&R_R]RE3,GVbDHIRS=HHC8X2HDO\5:]B95aaC-9&S:Zd;U/WF7D/^1BR,Y33<D
@-)=_)&cFcObO#eBFVC:7B]CI,ZS9cTV\N3>4K+M@S)/eTLb-J^55)SaaQY4C##E
QD0YVZLY75H8Ee]=?,I1,W6]Q_ZM>1XYB;&@LSa2GRH<S\Wa<bJ6\,>cG\U@H4a/
gP+7M:=,adA622g?]F\6#QJZ)@T#S-HfAT/FT>=5c30\.A[_CK,)Cd&U4b:gCFPB
A&]c]c=2L50NI7W.eV^BTeZ-\79T/4a(>-^bVDDT:]HE6@fN<DOGcC7YW\ETTY8a
N&2&GHCN=6,1FK)[\dNMNSC]IIc\^-5Ocg&#ALIX@bdP\7D_6HaD[R6O3V6ZH:4,
RP3;T9+Kd9NG><W-,;:9b.b3fY-\Qf0IVE+N3;[OU>I32fe=_/20K:c5<:V0[9eS
HO-fbbT3Pe4Veg>XPB5@Y5<ACKdVJaI<,?L\4V<6Z?1D[>3H/9eKbUA;\WJ=MF,M
c(cS>PHQ2NGFP5f5=D)A6&N3?98GY3bfaH[Gg<(9)Ne]2?>):&IRY/OIFgK^>0NB
T6SH-0C6M&?P;TQCSO-Ba.G8Le[#1P-X0XI=Y)3OQ;4^;bg^<R@5<(=:)F#X_[U,
8g>Ig-B?@ZG;T56[1HW/@0/\L@[8C41=&RZXOfQ/Z#RON)L>B\F:H0_de99gf+@d
2cMZ871JZMCOc0&3+U?[8(dCgWa<:404A)6J\)WeUM#94?Sa^bRCed&BR;fB<S;2
.BS_&YQ.F)PM1BAd>ES<K05R:(W96_6;gHa&c&20-[LCUY^XVI623@7bY]fdPPTG
^P0;.bDEfU/gWMGC/._4&:Q<6gcgdMUY2N^IdV^<\-+TGIY>77UXHfWSg#GR;IV(
=KgAPf(-DIRf8\3BTcEE6M2GLA)b7TJDec;d#W[,dXYTM=I=<c+C\](Jg^f>A+AM
bZBBG8Y:R0b9ZB(PW]ZcSPMEBGKf],=SMgeGc#+VGeVFC^?]L/H30&eb)+dcgR?#
FHa7#0cRQ.S@@&-]<1>U4(CCNF@2^PM6==T739Z1\(WD)V3XI_=]F+;eRGE-B3dS
&T+]IYM=YG4.EO#eL2QfJ7&#8)#=0,JPLV^7>0L?J(#GU)6R/CI#cL)R94Z:@[_,
))/#I^WG#8G&Q.EGDA8DT,W5[gfbee0^3A9/9P7bER8NJa).ULGJ8X0ND.?2TDU7
(4.0NOf]XKFEP\.<8.I/eX5K7](c_5V:W<W,TFI_+D<\]LMb+2Y:(P__3=<92VUE
A:>@2,gD=OTP#@[a<3XTIEUCM8+K\0<cgERA_@ADf5/UfX#=Hd34C-.gBKdacO8O
D9\+VX:A3;gfMe+gX?Q#:&7cTH>G<Ka-WA-+=[4R3L^V2K^aA\QFD_Y8@YABI#5Q
4K9W+LCcdKHH60K2\\.dEN?4#K<a7^\]aZ<5NMgBZgJ2=+RfCAXG?Y0/;.\IaZTf
GY)eLACIMd^(HJ,J/,&B5R+>H/Pb&TV9RFObQJfZ-+9d&N/GMEL;JKfYc,MB?+#R
:Q)&GET._WDTH8QU[W-CCT7K0Q(c(S/EXN+17U6H0KgK6Z_2Y<?bb\N\OCKUU3RV
H9TDVHG&+Xg^aO(A/ZDa_(7/.a@Pe)&;=SFIWK;D(A>Z->V:Ig\GO@[9Ud6MNZdS
THKJ3G#c6CTfPGVAc.eE<eJO32+YZ>6AZRW6O(TfcJ7/4(9CSB,4\:efVS+-1d)B
G^++,??D#+-dV1C)>.N00Je)MB:=22VI6Z:b^BES-?-A])5a>-62_04MD4PFE/He
LXS@4+)Ga+9/)?fO&3,L2TXEO/RI,5-BA#_.\VI:B;5ad)JUS83M>60EaL6&?QMQ
_Q>6]\+_O]QfdD?EGV25U)X0]??@>6fT@-5I2L-W(3)=+>DVa+eGcLH.5R<60,d\
HYdg)N(;0_Oa4Ka.c)ZTa?2TZ-eCQ291X]MPD&e>@_4ZH9\S4>;2H^\4V#JDCRQI
?IPDY^H+O7Ig42>:8<bgN.[3WIY5DNg3ec5P&/9de@X+;8:,dE.)deI-XHK0B?E<
EggAXLX-L2?0A/YP/]N0bO2+4)f:49A<c2)D<:Cf=8=PR#B=\HHD/;/-)_Y(dH<Y
\4,JA:K5#B04Z1@F[g))HHCJ:<5=[[BC>,[-LRS,6>P]AReU-.\5;XFDWe#g_aZ@
L4\TE/fU9gFUXGZB1<^b(]f+=/5<F10=:2MOJQ?3:093gT<[9/\V4_9[Y8?dH,HA
\BI[R^YJa..F5G/^1YIQR_J4(Y(d/,T9>VII6]fGNX5I><4,U#8?Z(,+a<bAa>>E
>:b(CUcL\cN0d//f2+[HRdCadTMRe/P0MQ^e88M7eLXLbI;](N1(4EP3G5>YBU2T
@BfL#I&g0g/)-+R,GY(DU-AA(#[2eb01=:<,9Y)BBd3G<^bACYZ@.7@AJ,=M#UEK
dbf2WcQP6YZ:O@?]XT9BbL)3<F^f;V1N.F)R-)XXN?1^bO?]R.&<0Ea?Xe#Z@>>+
_KNHR&<06g8RV1ME/T+&[Qg+EQ.8X09MVeOLV<7fFRK:N7YU2aBQGeJ-&NT&-8E:
(]#T[:g?2W&VK2Mf/#DaC:H;ddKH]GD3Y_EG/9ScJEO=^f)GFQcMUE\M(c@MO?B/
9^W.O\W/S#ULV+.,C<07C8-2:]9,_4MZ<DGXFcI9aU(?>1Z8G/ZEUZU#\f2QUI03
3,bI-O=>>aEFHQ=0d-:HE:TUEFAD&Mg9,H)@M(+K2XN:?CV?6FRT50:fEd7_JN.8
Ec<13b.NCRUOPOfVO(ZB;@QC:HU.H<^5J&RZHO&NLU])>@cSPTGD@&)f>^FV^GfN
?#e,\c57&W(.LbCB,VLe#5&TfK)e19A3[XWNEaGC&^<.FaJO?Y,@GGf8(K&.WZ@#
)L_B&DKPL5cbDJgb:LN^S#3g4?P^XAK#UO26^=ID^g-,M,F4B\Wf25-]YdYH)DU^
,O0(^ab3b:dM[&ddALR(6OR---?Re,&M5NF_;)H57^+.8]94GAdM(K/I&RL5R=H)
c>]&@IWJ0))V024Y[76d)JAH<@J)_9Z=cY(M:]e?O,4^cDT[H;_.f=7&2(CTIHb&
6@9Y3>2gG8L<L^YWL5\PCB6aZ,^8F)GWUGTS;/=N01-eC@3fE;ACEX/3@8bB&Z(\
X\XYZ=2P+Ce#M,7+Ta;/ZTA@Q.aG6M@AA=a3,QF9B6R@Q\@E(c3ZKDXG6NfB_DZ(
(DL2RB2CRF[)]-aO7g,EI:RZ_QS=.J+3).[;[#:T4;>c.K6K;+a^KDBEY8S95()S
>JBKcFZANIb74)M_McH1fAS@P@>RZO7XWI._8gSUG[a7R81>EfORDT;B6f<.gU7e
fWCTWdO+;agMV.:9UELeG\=H9X:_5/<e=Ve]::GA]1I;.f4]J\+DCZ_H3[_I>^]<
P>.IU>:dN0\BM@MJDJ2d8=C>+TOegE/AEE40BNN.)NAS<d]f]2T@<_cI?K,V&:6d
Q4ee2HcEY7[G):5O0#?dR(/<g..\bg5fW/:)c7.J>02^;#NDIJTRK5S7==QV=8#=
Nd/8FR>JUN#XNLX/-_IT_PATV5-USc/:VR6YOZ)[>>TXB^@.3O_A,28dgc-;0NVf
XQ;YJTG0@?d#WE)X\2XdC+P^3XXU2XP.\]XbFaOD@(8YNcR>2&Q7dQCfMc,9=[Ue
I(&-B(T;<dX@.W/#ZB:Sa65-830PX-]fXB]LM?S@bd<cV#(4HPKNY(e_=#<3_BZG
a8DG1@;3>KGWg:ZC7EOg?2:Dg#P.CdYY5(G9)]2V5g)==D^L3(Ue>6eQ=WC6(g3)
E)YAcD3,/]#^=X,_RZIA:^Og;([_CEeI0;28S/9602E2N[E^&J+8&7bM?XdDI=@D
#KCE6a=_US^fA399TR^W5V>,&fK,]Bb83_4bS?H9(,eeG7U7NCGg7e=IVGL_LdHV
&(#^]-?0\B>gLB@fH<6@;b9>bbgfCLZ3<BCcf,G1N@X59NMVB2UfOQRb@DGWMLW2
J8&b=VR?aWUC^YBVPC<,^_Bb9VT3[SNf^4c8/9f>O_P0_J#>[Wg-/MX(]5NcebD>
F;T-57LRL1)OZBYbPgg\H2XcS#2aF>H6T4aZ7EJgR0T\C?:XW/5Ne@+X>1fCA?29
N-SZM&U;^D8e@U9TNOJY&?Z0^##X,]?3U[>4<Kfa?^X-b<=?BHeS]Q;:LdK,e339
;H<H?,/ZYIdH<A5]85P>Y99<dQ)e.dG)Eb6Z4VVXY6+Ogf]cF.2d&a5ZT^UgD_XZ
)QNB]R.Ye=+M+f)Zge14TD1\+&JPa78DHW[^/OEb9df.b?RIRe\\V&QOBdMDI3UI
W+?X_K4+(_I:3H6G[=P3N&X2\/UZ5<A\eg)7C#3ZgU5>).cJ3U242O61O0JL2F.E
9?3&X840ROLGN.]8YD7,;eZ]EN383=5Hag07PdQ8WY,OZ#,VM):bebZBaF0&Z-)+
Y<,4N8(7VKZH[?[BO@9/7HIWX[?MZ2X<3IE6^]1B_=5/cT-83gK6O[b/K2;FS7R^
GdH#6K7LOGG([LFNWZ4\-OXZ-_Q0]a/HNIS#&:18@b-XS-I4#NT[9E8(dM\fYAcd
C:W,3?1JK5KIK>AT[U@0@#E?H,).acb8M6W9f^7<b/RU59ZUa4@(XDbT/:/>eP<P
#)>>dU5WRN34gd583N/L+Y;A2Kc+9CF#6.8Y28TEaH3@KZbLb.,b5DV<INR))K[I
cV\DG5T77HF:WU=H+2c?L6,=fdG23bPQW[=@>:BJT3_[1B4_cY)2F0EfEK3.bEK(
Fa]+Uc0+O2d1W+]6TOQE=,2OD=e2aJ69HVDPZcI#GDa_-P?(Zf1WaG?;V664F5R:
Vb#EOGR,/A,T84:B9D=NK-))O#FW[9&M=B1,6OUSFgPJODcG3<@4D\[O:A4?&Z_R
aM(&b-QST1N(N:]T;;BNMH<178-P5/PU&F3JK2>;eUNDNF;b[A:6ID-F1CB(MZKg
\gIZ:cKfGYKJPK85@@)4ZZT^DbUM6ATF3V6;A6ZLFJ4;UFC>e\WaASc1GOg2>L/=
Q)S/BO,.J[8;\@/TVM,/4(UGTfX&eNTB<Y)-T/X]U^1cDRE;CUOSA7,?<ZF->Y9T
SI;fcF\((G\NCf=F(8<RbSSBdV[JZKFU_Eb#ZHW;]O,@fYC_I>\L,=:58<U1HWSb
Y8=JGHbbfUWNYKTdL2OX_#(X+5J,TXf7=8(ZU_P,=9e-5Df8/1R4Yc05(@;;72CC
\ecZb2JBES<fR#S30=EPF;XGUM8b=?fM&AR,?cTQgYXf:T1HV<GQb8/8+?Y94<]<
4Rg0R5?]^T8E1OEXMVPRe)7SOGQX<R(a;H#W,393cQc8f4&6:HRVIBG9.CK3HI^9
_aD@JAH8^Icg3D.LS-51B-?:3V^=7NL7+5Z1(>[9#.X9445QeG8Mb4=LT]eIF;0B
TE+/)1@S9@8#Y\)PY1#-@F:WWfJEMTfGa#4AV]PFca1;gT;_fM>,<@f)@A;Aa:]\
CKb4<=HbNcaO&J346;4@LAE9.NPB)+B#6[,=Z,)P0JTbY9WgDTIUOW920_9Q:fLY
U5[)7EY7P<1<bDWLb.GSN8I;DNC16HX8P^_XD35IJcI&Obf];Mgc0)]OL>>:UZBJ
5#D-^TDNH(E6fYb&^&6BG66E0]Ng]VSN&I/2X2J(0Yc0/-@N@VQb20[ddPC=9]Q4
If)JXS0c<b&^MEd@/@F/d3B/]9CABXcR3/d]7#K.cVQ6d#JC?IK.QQGPUcI3YPVg
_N2gJ^[+Nd2@SJe7&WYC_F>^b<NHLTPPGHI)>g_345ALS@5.S^92WVR^/)[/N9#5
OPN[F7?LSU)T>3J8g\)+)5+:G&2?dL_JVA>WSL:B;AGW.1>^9OT_H:0B-=L&AG(7
L2H,\d-AK5[@77:U_IVY@91G\+X\)96Ng2>Gd&DaeMF9HCLA)09=L0Z\a_P:JM<3
c7eWa3ZMC4=WQ1YGgcU^<fSCQc1I+YPU^.T>B=bcXM]Kf8QWG-[O6XY1Zc^f^8VQ
:O@>AK9NO\9)ORY=fL39NbW;R>6bS4&UFD-9:SOa_3P_Nc28e)d<=9_U3=7^/Z#>
#K+SNQ\E>8[[R;N/dVbSC6-L3;S+99EFg/1+eaFE[]V?@YT]]IO^YfDIeOBBJV67
H:VBN,79:O+0Cf^bZ(2;S,5W9eg_dbT&Y4bD+?,MYA/(+94d;J57O5Z@)^.eE,GN
N/?-)S8#U+SBbG\>eQ;7TVE4;@,Se2JC)Z?g1V^e,(_X^@^>BOCL,4-@#Q;aRXdR
;H9S82RMO1LN1d5[7)#8\Z_b,Z-<K=-DFD@a9Q^2PIB5K1C6<)f+=X6f]NMD^;f]
OAgg9D9fd3;V+6MZ\Z;&[EdXI>E9MZ=ZJG\fR0OS;.Q5bI4A<K6A#)P]>#6ZP21c
QVL9:=f@]e,.g;&Ife87dBYYd)c+]W\FBZ=IZ703?b;\L=C&3;&Veg(&7CcM<d#d
3OPcc.H@MSN6F3&[FYUB^@YWWA_\D6+TNGRH7U+NY<1O-;TKO11C[Ugg^\(-E_KC
>d39#a:LI^YCXP<&6d++H6HCd2=L5?W^L@_Rg7O#[-Ce=(5\C&a)fc^e=@F^UQc_
W1bE1=fTM\AXPFB2.QT-W9Z]#==Y/H]Jeffd1U_PZDS@6_+c3+aFL3X^8K[YSPRW
BQE-B33g56Q<\e8EY8;8:[0^M_J9N\YWUGMZZUG@,6,V89,FH#3#&&N)W5aQR38?
PG<WBTSd[?8Bf#_04#eS0R6(]4M](KC0C3g(:JK?(PD,Ve;C[Y#4&@^DVE0J&\Y-
A=@SfTa<=3#68=3+cTM@&0/[[9ZXdC:b:Rb^aJ6FY9C5)=Ff]OZ_(JXM;H1=d.(B
PS94H,gA&M<S[Q/eOTPbgS=OU&)?8/NPW;a&Y4=H@1QW.K_(Z(I17\Bg)<TN&)8X
9Z?Q>PE7/(ZY,,K>U?P;MVRFd<#M]++ZBM;\g&]aG&_1\7DHG-S\NJS-V6Cf^Kf]
bPI#HTOf[G&LH,Sc5:K45.FFICccDKdS8CVH1.3,cO/<&7B^FH;Z.cY5=Y<<\T-U
7([a6+>_O^9O<edUY6M@I[?aF@+bD\<(TZ;0W@OUOQ?]W/H>E]c,VGAWB,.1FM9H
1_2V;^UdfQCfLH+(e6LbI>/@)f)G=Kf)dADW<UPSF0NS6^2BSa2J_5>_IHO#@6a&
b3M]X7f@EQXfQ.JRDPK?5^&>DMe2@dK<=+WSUW,J&.)(N?/@^=J5JY^c>3fX428&
Db<F]=HA=QW>@Gg<W,13B9#],-OIO=D>O=C6ER+c/#YI3gc=X>A--f<19,<P:7^1
;Z\V2ETQ?[<6N4Md?#EH.TFDVdTf9.0H&5X?AZ9BaH.ecOIb:/&C^fR/e=;2VE,[
5+MZHJLfSF1)VeYcVgZe^Lc4cLF]Ea.B1=eX]M<AMJS^DF4f9]:e]SgA[I:@W1cR
NNLM5BSVOdaaT]&+FDXE/X3:gPSP/\.X<ZfT_g1E6)CBdX?eVcDMD7&(&beWR=F[
<1MS??O0M<;CGdKEf<=4N3aRTg?PcCG+TUK74ZUD3-gfFEDK8.^cbDY7AFL6Gb69
I?_9U:1W5MfFCH>VP8,E\Q^1\9Ag7>8L)[\cE=(+5?YW\3NB62V41]>/8<LJ^a?8
0(J_\9;eEFH<F_:E)>gV:;.D_BdB)La^CR=-MOI2VLYG1UK2;II6AB03LF<_e3e6
B,ERK7c[cB@c#d[\,aPARO#ECSI2PC_>a7^MC=7;CGY9N.Rgc;L8STZPH(,C@K9[
YB4QFVJ/Xb6a/NF0+9Cg,:Ta04AZ4=2^Q?D(YK#fWQ>egOfLEQ0N\VZAY,0=-X\1
b3J-?3fb?=X=<O_POe,WH:0M#,CDN3=fROMWBcC.C_YgV=9Q4,-FdX\(=NS,Je8T
GY?+W#.=RbP1b/-Z=3<2Ng2?bQ:9MTPG9-M&)^P/Ve0?ZDQ=[2F[b31&[=R:)<;A
\Y-K](IMD.eUDaA(M7-74BKHHJZ@&b\[&1ST<(Y@Q7B.>]07C-]edIHB?=>PC056
<f3:Y7-VVM/USIKE9DFc8VE(ZZbS[=]Af#_Q>BbE+VTIgdYWcV695NC141Vf)cCY
NTRgS&Jgf)C/dG@GVS\70W+N8&Y)X6EN<:S3d9;S^>a246S=IGNcL4GB3=OF8g\F
HLGD;XfXLE&\W:91@QWbE-CPPeZ[JfLDL@]V5O07Tad#@26ZTN?0EN)/-FB_2IL6
-#6I(Vd)2gZe\G3gWg]XaeV088M47D^-=/EYPXRXd454AYM(+?7dJX8fa9SFEG5@
V&OOdM8U0g(M>:aWX]7@gWC>8&4=Q9A-?E4/JBBL_0M/\G=)EGE:=[a-2P@27\VX
O6OB\XC<:dG8a+>L,SUM.)?&bg;)96=?18[94D:-YD/(07\T#,9+-FRa..RH5PT+
2T,MTJ@L(\/PW89DSaBcW,MM=7(&0&8fB,?[Q,I]CKCe0Bga])P])X6f.@-9Wbb2
NSQF01FX[G;.M0)/]=U7@LJ,OPA.+KE#CHRYf#@Q.GBH/B0NONEc)f-@IY4dFbB9
1dSgZCQVO-K_O[gf?e7<3f\C-[/=FYXYW\=&a1]>DY7R6Y39^R-TI>g@CA>Z8;9]
OS#?Q]?O\]?GU:XeW7W-T1ZB@e9V\D+((80@RMC3I/;P//Rf]12E>&GEHU9;XDd2
5X&,LO^_X?_3:\CE(\F5:FR?R2JHAY:/d3FeB?83/?R0\_<UT32=Ud<L)-GKM-O.
IM5_SCK1AUAN#.60LF2MbC5#/A)7)<BUO@91XD=_dZB4&;eYNb4-O8MU,GeBGR[1
7=a3339Bg&Z(]Z0):A4A-d8?FC8IbUDP.P8GS:ebXI:B;A2Xd,B^:,9=SJX2-Y\3
598]1eXRZ]MZZQLDZd&VK+Y4(WFa]FG._e3U0.5SCM47)+\BLge<7,dA@^YL/a19
+JK3X[eS4VYND@dfc1H47JD+/QH<f5V;L6-.JeC#:g]FFCJ;c0Vd_)6:8Y/WdC##
:A5Q/;;45S75:XfI0T\M<X2]+/K:XFX-73,d(SfGQUMeJdcUSF&<b:VJ:==;A#\.
?810>OO;6B[9X7JE38Gb?#e71fZIMCQI75G/(FcCKU?)g9A9>&(W=B)54D+[.:ID
)_R-P[.\da?A[:bbK1bSXB2@:9#RQ7[Pe1KDV[=#A#)8[)<6aPI07]b/O36P/YbZ
=0K>S=DTCOR#e]07,fP5L4I9\&ILJ7<C@cQNDN-A)XagN(6d9[7B-fO=A3/+3M6X
TIO/X5\fd#&RB\.GB3T+TPGeL?FJ^43Tb2+2>._X?JT84G8f_0JT)J&CcO,+M[T=
K?3]^;EaV&a3+XbZB<CO^X;aSXd]>=@LB&C.HA0RL&/.eTdBJ)[dG5d>2>3@D;Y4
D.@+>@3S>a_I49N.]eC_J8)X?c.gfFD)2XHZ(cJ3)PfO^2+_I@P1C6.K([?[/M32
<dc<bc4/Y3.NJ1VFXCDTQ._d]2JS4CGCVLXJ1;Z;#\Y3a+<N4g#/+,c?U7;4#8Wc
Wfc<H-BVRJRO(?F/^&Z7=d(=D(Od]ZU99_@eL4+UM2+5\RD:Z(b\C[\[O8(_1H:B
d&A(De:2-ZN6#@d^(UGdKBE>R\)DHf]X1eIS2-C@];@0.^SC0g&ISb:I,Y+;<)a=
a;;E=A8a1Xc97F/H\XbAD07ZP2\F)XI56\U>:I6I>,&_-a&Ve?WCeKO1g0V8&#Y(
d@fWTPPR)]XLdUR,YZR;3,&cJ\Rd)IVWEZ=YTG=SPEU;&LTS,W4SO-F<CQB).:>_
UF+Wd_I)(&g?)33+gecR/C=IHE:Y3e9IKSA6+P0H0/I9d[(V4>JKa2UA9dDN)STA
W371+JJP:UBBE6]6=2924bG^9;QHC.;#:Xd=3TH[7G\A9IUIf&6MAXJSE.GCX?f&
^X\3I1EdY,O5JRR<L1?P1;BQEN;YE,=VAcF_A[eC9>dRK7C_Ng#+=@R1+PT0R78\
g8cdY08R?8bOU#9\<5=1TPS=Z8c^f]=?O<d^ZCFL/813?-EWI<WRVf>5Q\ZVN2Xf
9e>HHNc&)&Tc+-XA19-#4Y@Tf,85Oe(-fI@ME4bTGCf=X5W^-LFEH/_9,]9bS-+1
(a&KBMcRIOC4e-&F#7OBY<HN:SL);/C=#:/H1/eF^5#]M=ZHE#PSFeO(C,5M0VQR
Ag;<C?LEA.&70GJ^gOa1N2dUOX>HVKgd)YKE>9)dY_9YIZJ^,E.R).<0f+D<_H.d
+OX9AK3#X224,6_Cc59Kd=DOeB.SYK[H&HUdV>C+TW6QS5fP2b1LcaM=Kdd;PY]?
JSW,K&:bNUE:?Bb[7f2#O\FB@D>a-DeM1EU1EQ;BB>+8ZIe4.+QX61Q5>YLe;DR9
#@8bKb^V7<398-(.X\B8;_@6Xf^L74EaX_I0YLPUf2\Q]LK#ND)@LJQ<6<G<===.
4VSb1A9KP:/ReHF#4](5^D4.I<XRI)+2H<CJG_0MIGFN.PX8dV\;Q-6FH@J#2>4W
QSV^ad53/E:BXD&eTAL/&P_Xf6W&;BJ))MY];A1SaK-&0(&#_ET6[[<c5N^X#c9)
R++4>\Z82OO+bdJ.bPT.[eS:]K2^23S@U1Dc37X=c,<P2P#Q^PDNI1McYd0Z^dQB
BU.e8;,#(6/(]],9BeDd+)>AA:)]NX&;09dA#_;..K1/Ud2\MW2S(J5+9^cK[IYN
^P:UW5\fR28V3VDGb[ef,=/9#AG\K)UC1BfRb<eYQ_a5]g8BW2&HX#[geeeM:W0R
VDbD_L^)BbZ1@.E.DMEIJ)V9RK_-O)@H3/Rf(BU_:9N:OEG(WKg[2^NN#8cZ]W+A
:&c4:;5.H^7/D7/>aO>+XE,G+LE75_E:S._#AUa)DR1<J&bN9K5IL7ROcYdHJ#1K
U]@C?2.UFY\U=Wf_/;T::HLDRC2&GHR;ARHUb>9dINQccS\[Vg(YQg#R44.J@1<;
X2V+WNf3fLYS75+9ccXLV[[,4MIW75C:Q9/Vf[OHda>aY,[SRSd>59d)HRK)QHg[
YaUYHJed>\2f6#6+&](.-L@IV80\g5<6)2]#Ka\;1@,:R[-_+O#DN#aNe]dVbCE-
8J[]3cO(JMFO^R:3:;J-Y@IO\(0Fa2STZ^VC3V#1eBLP)P<fK\(<CYQ8T^VVOT[?
\<,LO]=9>LWYaW:(RC+:IG_:7,IG#@ea/Ka8=WJ[VG=#aKXFe#F+A\.eIMc19?47
1R2]PUfE)&.I(63)8:CJ/,DU+=L,8G&V6^WDRd2I>c?WIKLa8;/^eb?]8+D#3E/4
H[8G>A<V5ZCP#:9W>,,KUVZT[^Ac-U#1C>BFEA0(T?0cMF?ZcdUcI[aVPba_1;&A
H6H+;+=R6VZ&[0]=V0dIIZ^CJ5.[#+e0<<]dZcN;dSB:LLS63dA3-90F_0;[V]@(
aX2HB,D-P7,cWB?1P&LL->>[a^8HYU[&<J+J9TN\6a7SE3>3I#WD<RG&J,49YTca
^YGUCKgT,+]^bX0f0YYY8a41()E1H2GU\C_e4@KcKDAQQ_/;/&X?DDC]8,P1:g0g
PU<PH)EGaMO=Z5Tg/KI18:>dDJe#7+]VKRCA8(3.Y\e9c0F7,2)GUB7&ZV6#?]2O
4(RJJ)=+4WLSANPbU45#1,7XYZAN12(-9TS[bX9D+CCDLe8(8C78f>d=U8)VgK(I
6&YU&KOe;fSU#5OcCLZ59H6]7bR_J4#/<R#KY\bb5)PG(LfU3&9I\UEc0#]DB4eN
]a-GVc/__;H5+1+:5XLOO^BTC+,:.8(c9U3./GP^Rcc3,fgTM=GfK6HJX3(B,5VH
R56\?IT6+WISSG)LAcJ\,T\>cO23((Q3ZHU=GRQCb3,O7\GeU(;XG4EXf=59TO5A
f[2.OONdB(9@7f1B#IQSO+/K1#f9.W^Ff)J47]PW8ECHI<aEEZJ(58H0[2^DFOXZ
LD+,S32Z+@A)#J)Q2SZCLa2V;8b3gST(MY:S[[HJ&3c&2CQ/WKbZBaNPB#Y5BOYN
e/g(d_[:OPQ32<L<9QP]:M<5LNN?_62]J-X&?7S<7Ob&F/7gO7H5-1:8MI>[EA-D
HWP?HIFc(Q-d+H50MG;-D0,c\DKTJ+WA-#Ga/[I>.J^0;@O72]W\C8/PE;(NEK#P
OT5+4QMWAM3Y(U(Y.cL+-A^Bb,F1.IZ-9N<EW7]HfJHUAPWaN79R0EB[WW?W?DId
5<:KfM;(Gab7_=Qa(UI(.Y[3WRL=4_D@Ib-CWFO-^f)UDRfQ3B=BV>1571a4R;dN
Xf)=g=7I/7^7LUc@J1<C,TY4O=R]>2A]gL@Qb6R?A(799N+:&F:aU?2AM^/,6afT
eQ7cY>B,I=V0)?B604KgP?SbN9bRdMI,gC.f<\8XKI7N2#;0Z6<?K6O9:2;TM^]B
K:+DK-DYe40K53<R8W;bAC.f>b921CP(.,YcH,:Ja[6+W7UY4Z(@+AH70PC20gZB
>eUDeaZ639:c9J9O<.I&R<VcJ-+_O;a<0[<<P(2=KV0I]GM+-=>;E.IPKb3(g>/-
N]ROM8Pd-1;AUM7,bQ(N][[B_RCQC0MTGF?,Te-H^;=PMW9HEIP>FSKEGN<fc7:Q
OO<.C=1V3S:C1d/@),AX&CQ#WX0]U1f)5FO5N/&U-g\\UCH_?a#f]Z1<KdU3E0B3
L-;BWTJb-)+&5)JL+312;6H+gD#bc>?ASO5bL&6WTD=\MCW9;72Y^:-#/59-M65A
LUI1&HWI=TT4]/7gX?]3+>3bK6G2HVX;+\:1dS,KO-+@EWegQITW:HZ5M9D0>cZ:
X(Y&U[W.B9B3(gU8YHO](9?3-GR=4:&G:<3T3Z,:@()9S8(9(cZ^O&/142Y\A@Q^
PQV2<JWD,?R&]/?JOX+>_^V)NL6&&NX(#fbIL8V<bNO_Q_XOVC:5OUOMZT)UDK6<
d<)(3dbDJN6GPYK],6FWH6D5g0L&\-H+73:.Y1HY9>cJa)HPHJ7?OPY#IZ80=)=>
P[ZOHJ+&NGY)XBbS444?7DgT<,)U=L)]CaS7\43+[CO094M)(WQ0S,#;g3)@.@G0
?g&e,LcYCN9:ZaNACVOcGD5gCd5IO,UO[_=a##16:;fKNS,-BG]GT[JEY:<C9(.]
7d:YCd-<;H,YM#<8&D.-SGYS1=U#c)(f=.7))I4MQ/d;ff1G[TU3J#0J0I3e57_Y
35V?3Sb:7()_1K=OEXdb0MW,#6:UCO]Jb];5aL7ATO55X4_66JF+e<-RNNbK5M1.
:J6LKB9C)>R=e+e=5K:C#D,H^?_:6_Z.T=MA78._\Ug9WP/gI./4dc?Gd/>BZg>c
2&?d0=30DVENf3.EM5051K5X._Y<@^H8HgQa4SaAM_9=WQ+HI2dfVOJIP,H#_RFQ
b^)?d3OYLbMZ3Of,]Cfb7J+P@P6\LCWB+6&#9I,<,:VFQa6Uc;HK9QaRU]98R+WH
M6MZ9<CcfXe/7TSN<>JQWK+P7$
`endprotected


`endif // GUARD_SVT_PATTERN_DATA_CARRIER_SV
