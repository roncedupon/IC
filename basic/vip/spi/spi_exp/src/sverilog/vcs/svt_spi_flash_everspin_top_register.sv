
`ifndef GUARD_SVT_SPI_FLASH_EVERSPIN_TOP_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_EVERSPIN_TOP_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP everspin top register class.
 */
class svt_spi_flash_everspin_top_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** SPI Status Register. */

  /** Used for enabling the function of Write Protect Pin (W#).*/
  bit status_write_disable = 1'b1;

  /** 
   * Configures the device into QUAD IO operation. <br/> 
   * 1 : Quad IO Selected   <br/>
   * 0 : Extended or Dual IO Selected
   */
  bit quad_mode_enable = 1'b0;  

  /**  
   * Defines memory to be software protected against PROGRAM or ERASE operations. When one or <br/>
   * more block protect bits is set to 1, a designated memory <br/>
   * area is protected from PROGRAM and ERASE operations.
   */
  bit [1:0] block_protect = 2'b0;

  /**  
   * Write Enable Latch indicates if the device is Write Enabled. <br/> 
   * This bit defaults to ‘0’ (disabled) on power-up. <br/>
   * 1 : Write Enabled   <br/>
   * 0 : Write Disabled
   */
  bit write_enable_latch = 1'b0;

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_spi_flash_everspin_top_register)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new status instance, passing the appropriate 
   * argument values to the parent class.
   *
   * @param log VMM log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new status instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the status.
   */
  extern function new(string name = "svt_spi_flash_everspin_top_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_everspin_top_register)
  `svt_data_member_end(svt_spi_flash_everspin_top_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_everspin_top_register.
   */
  extern virtual function vmm_data do_allocate();
`endif

  //----------------------------------------------------------------------------
  /**
   * Does a basic validation of this status object.
   *
   * @param silent bit indicating whether failures should result in warning messages.
   * @param kind This int indicates the type of is_avalid check to attempt. 
   */ 
  extern virtual function bit do_is_valid(bit silent = 1, int kind = RELEVANT);


`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Pack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_pack(`SVT_XVM(packer) packer);

  // ---------------------------------------------------------------------------
  /**
   * Unpack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_unpack(`SVT_XVM(packer) packer);
`endif

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

  //----------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow command
   * code to retrieve the value of a single named property of a data class derived from this
   * class. If the <b>prop_name</b> argument does not match a property of the class, or if the
   * <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1', with the value of the <b>prop_val</b>
   * argument assigned to the value of the specified property. However, If the property is a
   * sub-object, a reference to it is assigned to the <b>data_obj</b> (ref) argument.
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

  //----------------------------------------------------------------------------
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
   * Simple utility used to convert string property value representation into its
   * equivalent 'bit [1023:0]' property value representation. Extended to support
   * encoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort.
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit encode_prop_val(string prop_name, string prop_val_string, ref bit [1023:0] prop_val,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * Simple utility used to convert 'bit [1023:0]' property value representation
   * into its equivalent string property value representation. Extended to support
   * decoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort.
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit decode_prop_val(string prop_name, bit [1023:0] prop_val, ref string prop_val_string,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  //----------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  // ---------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_flash_everspin_top_register)
  `vmm_class_factory(svt_spi_flash_everspin_top_register)
`endif

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_everspin_status_register();

  // ---------------------------------------------------------------------------
  /** This method retrieves the value of a single named property of a data class */
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of a single named property of a data class */
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Status Register */
  extern virtual function void set_everspin_status_register( bit [7:0] reg_val);

endclass

// =============================================================================

`protected
H,JgX9P<6\0ga=+De\IM^/A;+0bM-5,9GbCX;Nd4)JH9bb+d\c^0&)b?CSU_=7\9
EZ8ZQbJE\F:[,L]3g6M/[M5H52VG:Va.gf184:gF9&HHY.#N^FOQ@PG@<VCL\K-V
gg_84/7ec5HeMeGa468?AA;4T:WY[E7GA[N]XO&?TDVH=NeX3ESTI_.43c?&I&]\
RHF(FFFG)[e\SAQDU<Y^>[Za+b10P;eD99.4[_LUFD,(I>/YV?OE54SZeI,b(IZJ
TgG4_Y20a#4]>bTJBfd\&+QI>NG;3fP&NAR90b?<[/S,.0JSD9^0J1:/I?MS#H]<
S:+-AObU&\(O0<U\9-#bN=G+Wcfb;1&&H;DM.&BG/b85Vd<?-/V6+=1=>aJC>F<a
2U^K,;HHTgcJ16bPG3J9AY16TJ)a:3/B@T)5)M<KX>1CJ,466;^6Z6Y9JO7I?C(5
L&MDbROCH]2cO3[UHI)bI_WFU_Ye&^LVcA;WR,K([PU<0LY-RDZG50Ied-#f-gH<
>_17G18VDL(1.8X+YO&HT^;5@bATU(WE::74HR8^P)#:G4\QS1L[Yc4[KI6P[e=[
X;[?\b4@/:;6^Ic<RB:f>(A[.>gRgQH+\,9A>ca.[(LK>&ZFPgUg^HBKb76;G+Eg
FCTEfCB>?YLV:3H=J#Y^.g8XQW83<>R@)+(]0\KBT_Q3T]9&]:c;NABKP$
`endprotected

   
//vcs_vip_protect
`protected
V<TL-T[<FaRP-1OKa<0S/U(9(U7^c(DWZ?0D^7?8+H<5/:=@P<)L)(GbL&[&CTH(
PVA^6ZaL^OY3;WE/)?f]VXP)bQ5G5\Y=5>:;NKO=R8KYCD)):6^?(gD-77:0IdCV
OA^Bgf[W\@8I2DRW)g0V&2D>1PKRV1\H]CSEIgGCgBBU5\ed,_#A:-D#]\;VA(gU
a>\_K,D?,4.<K4U+:ag84g?0E-[YV6_^R,OgadKB6dC46:7cTT2Q1W>KRcRDd5d-
.YSQIKe)f#U-PTNVCCCB+OIU[#KAGA9]gLL[\^0/AM+]FeCaa&<9=/-gYN&^-.5-
AL^HX9I@XDW?CC_M:3./aHG+b(2Y@gN>7:ER:OH;6a;/=<U/+Ig.WCY;[fY2-aG6
/UAH7#&SV;6ELC76>93V<GYJJY2AOXA0=13@TF1SGBW/G+UPfW=<[f_A=#TUae:<
]S(a5Y#4YZ801P1b2=\;;&=&+;76#CY\BSZRMP6d1O2MeIXb9;UN]cN>&+c;dJW;
6Z-(O.MTNG7QS35&da7@X/J6MeMX38,_@[Wd.,N],Y+[)Wg[QRYL2G,S^LCK6?#8
EQB0B]27:]U/9Eg/U-DDHFg_)-be5[.>:c0Af():VcVL^(VRDZELIHX63@eC5BLP
W8C.3d1Z@:LXN)gC]NeY2UL2.@_W55d[V2N#4.aEP-M8BIU^PTZ]faMVY>0AY/)Z
]VgXO_P7NY^c#e;CQ1<c4F@?@[BK)_S+N^@C[S??+)eV.dUIYa>;aN;B8\QVE/^F
K.C151<UJU\N&2G_e26]]+75XJ7#A&#HUfDZLT_(<0K^Q<Q7^-EbS-/B7T]HTI39
L+79\8I2P>SJ8gE/=_Y(QCE@<<TB@ZZU@15Ff8N2OUG23U1Gb+A@g;Q9X>-&W/_R
OQ1N]f:K9)(376f9LaD=T^,+?AcX07M=^&VM#A+9T[&AIg++CG\#IcIWa8>\3\c5
LR[,@Jd;2OH^Q>A[Uc8I^#?JGCXV<+V]71g&fJ(@\a7TUKO;07M?HI=CV59Ea0BB
_d[[Mcb9&+LZ[NKR;F+RXc;QT>d63D#f-.;B.J83S8MLGAL9;CYPA56NOa@&fGRO
\70<@.\2+2[K&<KH9@faH+A,ZL/e,CfY4B/BKEK]?KAGM<cS8JfOS33E^+9G_+b=
DM#CAL2G,aD;@77J_JBeD+LQX6&4KGP\EM:@+&WWPS)(^A?)\MO-&QK0XBPWQ3PL
L_;<]f<[0RK4RVJXa/U<Z0ZQF^S^KZ3geU6#<LG6ILc<^_fQ[aAALfR.9]F0CH?X
:UMQ1/Sa/g=>BF=\U5fW@4E-TA@fN8/K1Qa=6b(5,W-G&#]+L;RY.?,7.-B_G>#6
CBU5[P6:5Ub[DP#Z+1O-aeT&0@R]#W9b:bG+Ve)f82Aa+U.-,18P/-OW,cUfD1\X
H,S7:=NGe\aQ,=6Q:D?-#7V=HC.D9C=5a#Y4]WLD#fSW&2R]a#(-3AAR3e;(>RUd
P3b,5a5_8ZXZdf@JF54^3ZaD2366-&DX?fZVP>^URB[CO)+WDA,TPH8@c(=C4^S5
WcV.<[E,[2)KbF[G=fP#29)P^Ff_K<MFYe:dJQaOP.cMI7Z4[J5I7NYI=LFfNUOK
>N:\G;=@3HfTFC:S-UD9Ig#7/<N<L>V_U3aE3gR9?LTN_-:NP:Y[LQYZ\1)Z#2e]
f@(/7edZY0_RA3MV=I?9aM&F]bH=@W98O/(aQHN=_,9a&QW6_H^KT&9Q)S2F#V#T
7WK,F@@(8C1Dg)eBAb7Ja=/+EW.=ZAT=#+ad(C/4T@dL,KP&5LKag@Te7:(:.IW]
<-JO3-]FRP+M2H\OPI]YS_.7f#VH-c\Wb4]ES&cTNdBB4<B4L]bH^C#CNd^TTc@F
KVUXBSZ1;T+FTf>>IF3Jg?78GNfB_#M8O87.cI)<CPEf-g26e&K:TZF1<=B(-:d1
8VVB.bBU)QE-(RY5Z;UUc\=Me_1J#R,_4c+9MgC_ZL,EHHHFLO1Af4O+b1[B#=JQ
QQR=S[K3c=@[&.N>JK3@JL)<g(Ge3RMcKeQ;J4]49-Z9QJY?<C.M[eO&5WW\fgdB
.Za;Q&gS>YTb8N=8OHea6Z&H=fV.7YP4?F3dCAZVPR5F;,ZVI(-C76d8^KJIg[=c
LEOTd>d:27N2a8W(JWZP;),LI_^e)XJ(dgTV6VfeH+4ULG_(/B-)g_>V19/XVB:@
L.1EK5d[[CRG20a8F[d&_Oa6G/)<.W\QT76#AJ,NIPd(<K>,Ba6RG9X4Fb:TDPYB
]UW=//8&PE9+J?;CaYcbfMC60@2?c#dg0H/2Gbd=OTefSbD6WL<C+0TS#^gB;(/#
a;P/BX(fZYf44-aV.+NK,KBaK/c+\F4NWaHHOUMdNHG++f#WY7Xb5J(&I-cH:6B#
]MW]5;#F>eWY(]R=<F2bNJa[2DD1@[&M_9]Z:;JM..STT4?JMUfLOHSA?;:LT+YQ
R2Scg1PWJM26E1X-?OdX^aL):@:&NHH1QDT8_f)_U-?9P47A-dE6?7D86Gg?TA_\
#/.&2M>6ZIF#)e&;:0G[K=CE)Kd@L6GG=EgV1NFDULDgDL,)aKa8QR<TTHaXT\C]
R.6)H04X7@,,/MQOfaDU1WO3Q>V&F#Z.2.7Vg4/.JEA[DeV.9dUO^d8B<SOPbea]
GJI_30V2J6N)?IfQG,^=Gg(D_?8Zcb,#?D+P#6+CB#(3H-75FD2DDLWY5+.J]D)W
7QPK_6)b5XK:6&9>gF-]f55HMQdYGDcM_M7bIW;VBY#a3&NG+D>06?fS+(UM\^MJ
RWGI9@,A@:1WJ^FWS),TQ.CCN5=6b8Z>Oe0&c:CPTf.R<TfUYXc=7:&1F\a)_6QB
VG-RJa1QOY#c[#bMHcHc#+L0-V&G0F@]\I9RJCUF?R[<>6,UaMN,.D(/Q)EdDcaQ
g8]GP=d/U.\eb^d#f0O^U.HD_\I(SXE(8_e;f^7M(F+),3[O)RIfb-1?MAKV;.7E
EL;>&TgKNQC\_,@FQCL_cFBeN&G@:R6ZT6_-K4_:62W_4060^>U;+HF@TI(He93;
.db8S+3H:Y)76@-K:RcC+@V@9:NK&=KOR,^H-:_998WX+YJD8@[W&K&@]eC0&.6f
.FeW:-\GVA(4DP.ODI-\D,f2GJKE#L-K)GSLJA,7QdZ4MG[>5-.5ZGQQZOe3#C^5
QPJ[B0;aT?U-;\:C1F:Fe)Q(NHD:aN[\/c+7XILM?9O<aS4U\ELVe^T1cEI4Sa2;
L[:]&DVVQS,0?IZSSR7e3fdI#:P9f^HD_Z7:HUX.L>a78KAS(UA+9L0ZSWHQN1\T
0RAL?/PCPFIb#YZ:YQP?_=M#XSd_HgPG5BCTg3f=^4BROZ?V,\Wb@eg4)D+D.I<@
T2c>6HB5SMOMDePd\P^HMQOg815f@>-60FeT@LZOZ^29OY<2^:8ZA@RFS@;.&WDI
5;3B]Dg-K]f)&+Y@cdZ#HURg]34YPNc6N)HOe:7[We]W)^df)8Jf5KO0PU+X[-e5
PW:KNI6GKBJ@PIM./91J);RN#Z64R/@S0[F30dK8NB;/f^7:7[<C9e&3A@Weged>
I]Y91/-@;/-.AK.1Y577b40:Fa@<OMR^BE3L/[b;__:CL)@#Y7R]I=@]0O4a(dCM
O9aTNLKQg8c8gH>\^06HAE_JOF<;\,_0YC^ED\XOOYBU=+GP96W_LeQc_.CeUdU.
C/<6VG)F(+O-^-f?^^7-b9X3371Zf3gF3(DJO_1U0Q+fZ^6Z>(EY:3Ug)T2fAZIU
\82KT5S[-F.CWZN2LPV#IgD8D0=+a/(,DFBNI:)WB58<UZeMON?A-[+H.JJf^HeY
N?Z)XLf7g__c_TBggd:D(CCMXdY;#96>1>+0,7gS-SDY+dJ\U)Q+&K=KDc7-;R,3
1&ZX7J=S:7[_VB0E.6,b)P4.7[(H(51:;//39)A\,YCPfNM&_N-<;(C>/VW)[gQX
:e=S+,1/e_#UPEd5Jc<,PV3>G?/<60:47E/3OJ/BGR?0=/7]1V?JY4d8Me^SOM:K
Y/d=K5.#UdJ/:2,-<LVg<T5Qc>]cLc&W<9=/1dI5_LRBDPK[eT:()1WXFBWFSB7S
6.e>PZe<a@c@\:=#0PKEf[=G,W#,@=-FF[7S71-Oc?ZP]1\\<6OT08faIKPD&2dH
Z0EBA^S,=V8H;N\3(8M>3(C/A)CA4G<Qb_@(VSa@e5NX<J///XPIJ576e-/:PM#1
fRB6_:+Yc6Afee;A_C=+,YR7&X-7A)TaQMQ.CLgD=XMgfIVJ&VPeGD_DgY<,ReVe
8eeU,6M5F1YF1d_Q^,:T)O@)B:2JeW).D<AfH.DTAL)ZC=_a^E#dHDE5PRY:RC6;
d8c0\,X4Q;ag.1EggXD#S1=a8UDYPMPgL\gLL57G7K39RAKd=g+GE(DTNdNaL9XR
Gg0N,e,ffF4QY;H,&UMgUDHO/KZ/Z;FS/H2(+YHgY([&09<<?8O.<NJ>HHV8gG?)
eQ-a/VgRbgB&#7gVeZM-8,E8WLf^-&+P:da4;BEE\EFJNT?++-\QO+O_Q#ReB9DI
9;d1aE^6fSLF:Y_1O;G7LAIK?X@(:IdaLO,K9L1YJ[WSd(V4R8A?fcDC]fT#c?Z6
HK.C4T1P\8;dMQW65WASL_ITgZ3,d/]e-=.gUU><61&OaaM3,R@4F_CE/<@BC>:G
7<#8P)W_f/K&O]X)#(L]DZRR83gEcgK#C2X\RI@L[&(D;P<C(g_/T?:CPPO=f/IG
Ld2Wce>ECR(JLWU\TT3DPQQCK61MRce\^>&Y.0./b=6IeTfT\ZgZTa5D>GYCI]ad
0HH+e8<\^BCg0ERb496,MFbG1:15MYO8f[eLJG;H@\eQcGD^>\)C^[.Y-<e]A-/c
b7+cC=\d8A(L3&2]be78SO;ZMK/@Fd_?=f(5g>[0<X&49_&5bbT2,F/b^a74,IJ<
EO-aX?SUca:M0,19\PHA7<0L27)B_MS?VL(;A2b:)Hb\K(fQaURX<1Y9-aISafM\
Kd4PT_<D]/QgX::e2fKD.Sg@Cb1))HVA<B[CKRJG:)0>>,Z;gg>K_I[:2M3\2D4>
NBREU(&LM1LI5&[W8bMMae4e?IIM,8KI6^,+0AAF=Dg22#S()Ic]O&WTT+_Da04Q
FOI8O7Uc+Ac<e]Z]bae^BH;?@GH&aRg(^8>H+VH^aD.U+5#<]],ZJF\HS:7-F6E)
KMD6R?fN,G?ccP2I==If:X0)0)WFJVZSa,LX_gKN\7:YLE(:gY>2@5M;X+5-IYKJ
aGdPe#QA,C162OdCaX4&cFBZ7,.Udf3.GOD>,I++1ec.J(2NIaW#V+Y?/VQdXQb1
SXUE]K6C8HKI(dF]T^1Y,DK#E1(f^EGePX6@DVTeY@NcWN8VLb?3DL10C_V>[Rfc
K/^K_WCJgI+X&gdS&R_G8U;_LJeOHO_3KU:Q.-]528gLgT-VCeXFB(5Q=4N#B_99
5_QRQ;DR_@8V;.6C]W?_Q>S<NR[FN#&?2e00T?K^XUD>0cfMbcb#D,>)&7\(RVWS
Q]Ga/E7K-9BYK4aTIS^6<MJI3:V>MdGV#g0F/=Z.VORA<1S799#ZZE]d^6^G)[/A
6ENRa+BO;00V^+eNP_NGe)Ka#&K(94a-ZQeD^KQ>ADeNHPMUV,8>IF+QV<\TVB?6
UGFe[CKLKC;Z)5CPb_[^USEK^1^g_fXb7:9?OF[QQJJd[L.^3B94Lfd/)7KFd56S
&Ec9T<=>1Pd;DNS+\<.+7^P6;WC:69V@0:&=89c/S5EN:e^7Ua&]NB3<6(@6W)P>
JFg)FAZE1ZKC,=;+((X_LZL>=2cB5AO8:S8F7\\SK3\2d3.D[AD5cR?(DSJgZAPS
IcMZf7H3?-&[a)(2:[84WC]MWUHL:[E0gJLMK:/8IVGW2FU7Aa:LNY[B55]#.>[)
T>P\\U]C_5T7&T)eUJa2g5<J4/?HJO_eZ)^gf-,Z\5QJ@_c,D?]PHJ],7T5d[9.]
V4GE;Agg[O^L[]Q7BFD&KWFU4\3SIcS<2(VfF\<18I4Mf=;YQeYcFEX1VINO:a=b
b7dB.[U,;]9#dVf[c)TfQ)dH](F(@[bWN4@ZeIaOfD0cI=[_8]=@(VOMfe#_W:W9
VXf-@,./BZ34S0ScN)^_6,0NY1>f?(MMM0ab:6]PQ#N](XaMNfTQJ8IRg90?)]Fb
((]Jc9YG0T[@;&?TJTO8:Y@CH)HV(\HDR-3;X\E^9;UA,^Y-J;5FD\;]5L>HYE.W
fD)YVW@\dd/eKBA22?f1+U>XIMQW3;5Qf4\\]JD\S_dD5_YM-46+CC:-1\72NJ,9
H)Ne[5e_cZ7VG[.SWHW<UT1IK<.1_O7#:1_^6U,T)POXE0\D,Fa=eTg1T8C/g[\\
fJ\GU8M?7e.6a1T0FXVMb#8&\:JH7_1?^Z+[1d1K47<T[)U:-&f<cE+>(eA?VKET
=8DgLLTNSYA^d0;M=_2D7bX^[K82^3&6d&VRJ3IUN.?8,H-LJ&4>TH?E,KT1/&JQ
Sf8Q[C6?/)?;>-,AI,_4PZdF4-FbJ903N2PfHgW+KY8>@-VDKD;&gQe2>>L-#dNK
J&DXVc;U/[2@E[AYCOXbX@1eL09e,8b3@F3g0=[)LW+#YW@8R90S[<d:(g?b1:A[
7+Q,e.KU>d?D>B-9MffBeVXLC5E&TRK8S[37P[3CM#HSHc.\0UUdfBA64198C1c7
eK(8#.RE_@8dM+[g[BQC\F->Vc^ZK11H)-27Yd5SQ4-V#5?0e.D(DW]&-(GNO8>V
U@PI[@F1Y:7/N]b9;Y8WeMLQ48-Vd.^N9,9Ddde4<.(X60B)N+J4&]e>78CaEY_N
2W,>GDV-4F9/[_#dY?&F0/HK<SA1cG09A=>DgH>7R31_JKM7H@37&K8NP_?-SRcG
E>.>^)1d.8=db5L3WTUGE>(O-1=4,XgPZ4QL=PVdJ/AFJW)>OGOHVZCS(:,F(>.1
eMTfSJKU>?O@W6XEK+<U+N/AP[N0\TJ^YA->^=TdZ]Y:a@0YE?g9^#+dKUeS<YJI
1E51<U7:H:5U_dIg\^_;PQY,0BAE3G^gOP-c:GR^M\_9(<CALeF+E]30IBd?W/#;
T]^dSS@a^:-Za8ZPdf,_FIA82125R5&>Y.)OdCf,/(;7TMWN6,1N>W#)F-<6a.,)
;6Y_\MLI5B\L#(S-WPXg[?;[@HJ)WK2YgUSA\HQD]WggQ5M/34M)Ud9bAVL60]e/
8K(W^>8FOX2))E/X/K@a&7b<0\1\7/NaCPT;,f>4?&_Tb]47=GB4E?IH-KNS4T[O
EG)3]/6c;<8TbH8PKN)ZQa?SVF@],[JF30dFZcXgc+7E7].)O?JdO;H^.@ND;IH>
K/dD0&TA)(:];X19a-9YUJ0/=3XDT.B&_0-P&V]<9a4;E3^271G;3K4DR;B7QeZb
cg09-S&E6\L9(../;H?G4TPSR)2#;>eJM??L\HPcgRC,_E.77GS_V&E_3a0O\I,I
A]fR.Je^JaB:[-;YQE-0\C;?Rd-ONe,-P;OVN+.EN)cAd]f:XO>F6Q>Y9[-(>LT,
76)QW?L#>_OGO8Uc8Ja?_Zf@AWaRG1DdXB0/Y[:1L^YZ_6e2&Xe[W7KE0dbC.W_Y
(e:=VagBBSbL\<+<=[99cXeJ_P.XT,JK&6E@-#N/D-Se\/V\@2QG<EKdS\g.fSAT
SaJ^,;#d@_U=;L&^a)8/Y>\+RYNgH.])P]-1ON[W_>T)4RAc)8N3d7ZY_HE2GX.4
G_87=HB7N&b56T&bJ:ga1de+&=GSD=POCRFee]Q9f#M&.HV/0/[TAb]e,6I,O4>O
3c/[<R#/cKX6Q\Nf,5<9/FG&WN/e&2&CQ<HAbF8eLJ)I9PYTEWYOSUbG3/b+LURb
]PXB1e8<]K60LK21-<cc,.Cba7=RWFF[PX.2@U()L7f]>&#11bNQ/2FC2#.6,B08
2,P6G&;L>@7Q=bCHScbO]Z^eSDIWH[V&8E6^c)L.B3+QLIE/7YO@U;.W](96T,7+
S(d/(J_NB\6=<NJ#A+#/:c8H8G/57.9Gb:ONGeag/MMJWH>.TAg;V^P38RT5Ae<g
DODZI(;DL;1\D^X\:1A.S&)aTRFZW0X-@&22&@0L?Z\9)1,fE2@d5_CfBW]6EJ8;
V21I)8TeW6-fTV13cE;P;02W_[&A.6<aZJa.4gR.&,e.3[R25DM[PJJD]F9L^H^(
@^=)>T^ZA+N6[3\45WF+9&dfM);-);/YT>ANg:ZUg8QH&U+Nea=1-)K?5Y>egAAE
aH+YA=BB2P.b@ONcef@/B+:E;eGX)68@>0B+2G3<c#=9e@8WQ4?+g62P=UG02L(c
>BeQRTM,H,O4Q-C\6@Ma98-VB?O3)][9_<IO(M?^-MT_IYc>=9\:5bW=22GB/a&1
YD>0R7Q.U6<g4-eT+3WJb9Qb>(K9-]aI^F2I=M@O.\::GFZ/4M7)b.LT0\93/67\
75U:Y<O3I/gd41/c1Dc(L<64UUB-+4_T/EHgXTbg3[XH>V:SEYd_GHQ>YN[^9^YN
g6-fZ;5<>AI4+RN6Y1/2VaB=+IS4cY6aE8\&Z:0BDV[A/9;?:K0X<CD6E(_3D_3N
Sb1-(_??>T-POeQg@+Sa?E-P+3IA_Q^3#3GN^-ZS9:Z23E<f<?\[N,/=:Q\HeL--
McNWa9a:G#N8TUU6:IM@]\4J,1HKA8Q&g08Da\+5Ze-79)SP\/(cTeROgdD+E(K_
\FHSdD.^d&2K;6.#IOV)e-[26HB^T1-SCMV)5/f#gT1,HCT<9_1S7+A:^TR2IFXG
HDaN\W1D_44X1D:D2>(\cD#Z\PTEcPH_<8f\QU<9E4/#V=N,:?U57Kg3W8XJK.Xg
Y>EQ(D78dG5c[fA\:73^?BJgfEM6+^,C5[KV+I^KP0/U6ZWSBF6)WGa56^Vb-6>C
^E0#Ed.P.)CaNdU2dRY5KW?W+_Y0]O.&U[6a^Z#?53=a)B@ENUZg.667dc:D[(-5
fE;=1.cQ9[)T\D\L.eA\T0+5YaY@ICA[0JeHEHOcd)9IcFAUIaF=I2A0.P+?[98I
cXY/\BD5D&#K+K,?QOOARP6dBc,V0dEYHJTgd76gZJHM:4/SFDX^eP->G6.CJdO>
W&;EF/-dYT&BA5K,)bS:g7.F05M(\/@@/\C[?5(QW\YH@eJfC5]IgDKS^?<QD>L+
CdOPe:1EZDU\.@83<8:6D8e7;M39_5OGHdIJ()B\SAFH^dK:e@+U2IFP(bHY.MD5
c6?+ANFUKfGG,[<EFNHLY^R^TM./C&<CUL&3C,2;R^d=BC4E9T^69,b+D8\>Ia[4
F&:P+\dfZL&6OD?B:;JAJ/82#T(2/(H1CZV[J2S;4M,@CfPV9DX0_GW=GG#:O<Z5
gbgbW463+&U.GW9GM3VCcYc^,\^-R2.=?L<2gcaN_Y@ILcCL]SgN+FWGY&5gRV\D
-ZFeF[ZCI0Y+5X8<YbRZN^FE4(W:bH8eL\Wg\2?.M.0G5geG[ZH<Z0C,.U]K+GAX
HVRX?0@:Z[CL4e3L^<FFXI<=];+ZCNBf>LQgF3)=/ALSYN/@K[Kgb[1GA#Q5VBOW
Hf39,(+7.R&RD>L=OQYI[A<J1/E<^b#24Pf_64aG6>HA9EB:,-Pa7\:Z/67Kd@8M
/(gK3D&e96/39Z8.M;HVb=Rc_/T\:.J^NJ<_DgCN/_/0bLVC-WdR]1QVY^SQD+QE
US\+/I=V\c=_0(?H6<Qa:dHZJYWQfO;TLcM.&RC@C=[+H=_O4+ATN?eRS3,;-g\0
+2EN^69C+^J#9[V/TQ4_=I-\@>3,cCCJ:W#5ZNdP0](J-]V&D7>.YRcW@V56HT.-
<ZE&If.26D.83B.?:?ADH3g=6/WH74/,YLc?A9@/=P)O5,L@1Z.#gSE21_1YNP)4
6)\dPBX8GMOTZ.]CcL2:(FO[(@HZRU<XBXY83,C@=QY6MD0L)A/^g)CO#FYL(U++
IE.Y&)Ff,@45/PH@Y7:8gP+_QAdbSQbJIa4P4JeNA(4P];Maf&cc1WaV/GM1KKFR
b.I-DKT@/_X8[[[&1@67cJHFT(Z75RG36@b:\g(A@<:@a)-^[Xg5SC:N\AL[L)A8
faG4O:L&X7ND4;KbM;5]P?;.._@+YM_J=?LaH]>B(C/PPEU_=-dMA^WDV&c_)\M#
:+V)A=\c+aVM=&ZY^>aAH_Y)5GM1Of^ge\<#(3?SRI_><APUGV>f<aWeb&OcEQ9c
>^\QBZH0U&5Rb5RURPP;+C#K6+EE;OMHSbf0b:V@MG3,NB?2(A[:CAJEf5U^9@b3
OFL]<,aLfLe(UXS1Q#G<O5R-R--?3_;[+Rg,O2PaG.\G+<)3ee3)>0[#JGUJ)&7?
U/[#0GK/P#N26Z+PA2U8@]eR?Y&;MQLgf2@dHBLJP5e1:<0A84_>;Z9K>,Df.5G@
cEe+F=^Sd17[SN8^L4/Jc@Y=GA+;0HdS2WF(PO@4J8d7d5BZ(V]O66ZIe=M,MK:V
:D/A<3Q-#I#BYZWB][b3IP3cWd?0/8&HUc](^)#ATV9EUP[cg7L(-E[/(1FF&MO@
Y@#4PSMM(ZJdf)__T?6)O:3]fAHN?b(<[b/f4[9,5Z&&]OD]-PC.M<Y[6Y0?aZKK
bd+XTJIJ^=A#aVO.88&c2MP6Z4#:YQDYfOLF-2=SC4MT[,-FQ_dW;;SLCOJ9RGKU
]\.eCGM#.2Q;HAC46/b,d?d#^(f+BFXI_e7I]cKRTJ\AKM)a;+L=.4K:DU?<_6P9
c)>4;c+MVZaYgb&U4,R5JaKX=QVeScO(\T-f_e#@>S.=^Z<EgVSJ6[;1=916L:MG
EEV_]EdP,ARDa,JY&>b^[_f;2Vg;IfBa-JJ]NK\+e;bB]LB/B]3OcH>QgG:T>)NA
9DZ)AG@P^8fVbe<_XDG[PN#=D6I2I+f3PHH[V#_eV+RIKDFI:Ga=HX#1gf6E[<[g
\TN?1?&\?&7DC.UM1[W1Q39);JW/_I0dd&LHUYGaR[1P2acb=UOa23c=BKd)90B&
?OJY8[_^.E\4JB.0F>ZPUU-PG>9<27IWgT]Rc()VDB[C;@4-3OC&)P4&5/H?34-(
YT.8LaR9DBfDR#GZ6XRUBP7Q::/ZYgOGMW6=A(<^\Kb^Ff-O2USC1NF\@f:5Z0S.
1(a9:f5Tf?M5S.(:gLA&)2dO5RE(<Z-RZgAaI(&WJKV30+RJc1QF,2-U8U4MR-4C
gL,91L-#;B&f1dYOSGcHLfLL(CFb8BQR1C8Q_DH4P.T3M^-&1e5XaS@\D6Fb+73C
-RGN[fc;LW=ROHP1+VOQZ5A,UD;;:9;J4;HTSJ;X)gf,V@8\MX^N]cPS8gHS;K[,
I<,eb4__9O3;N5GASS&#E_FJ-?2U#P=ZVJY1af8[6J<dENYb0-R\GQA6-e5\S<@S
(Z-(PXH4fL[70;/.E1:)?M:]A.MG4<Z_2+M&],AU]RF:YGZ-.VFY^fVN.RX[bSc?
bEgAS1e[:_c&4AFZ_f<C1M##^JK<:F0c1_^].YBWdMcb1MD7H]?UVR&A0=K;YG9.
K-PE^?aU.QIg;HOg6dO-7CgE,TaX^g1\&WRM>?+&@cR3T168f>,V.2>fA24M2VY-
.,a<P>:._F^f?J^R8Q-WUa&19USKA@eg)PdE3Y#LL3[ZM8(e3CH0TG[AbHPb];K;
(:5;?K:)Q\H?A;YcDaF.I.O]TV2d8#8P_e?&]DG(7-5T<AZfMN)7^Y39ES-2gJd=
)Uf[/bP:V^:3SZc@B#AO1X-N4];FV#F\O#T:3G?08a>/@-d7aAE(:O0c1^231(fE
AUH+SJ;U<J?0>:8C[/=4;B,6#+EIIY.:d\QH\0SXF#L<b#?Xa(J.D?V7^Sf4ZNfZ
R7b[>O(R96(T#N2]CX?#Y+NS5L44OCe2RV@O0gYIOAJ#4d7\a1YH,;Y[=;@:8<5K
W=;d?EF)W=R7\5#S5<FCfU2#_Z+ZSfVVR;cW_BFU/?6[_1K1.;>HZ>9_L<9\Ia3A
febc.eEE1;.gZ0K#<C45O)?EecCR0P:0+L?S@DS==M]QJYbTXfFNWd7X?bR).@?]
f-a8#8)eLL^C9/MB#(W_&QaSaXV?Ddf3QQ8fTDIAO.QI/a>JfWZTRZ5f),e9cA&^
P+1X]a@,F&GZ\\>9(/2IJV0HfCIJ+B+L0K:&:We5THSH11G0/fM[:c1^RH.STZN3
@a)B5FTSWDfKC9I79APUV=ZF:CP0fJ;8C)/#21I:HC./#23X1aJ-XaUH.^1^dQH<
Z;KS,eJ\cYdKR+=&<gV_?>;W1<3c?^=XLNVOfg[&NTb/gYW;b;1,:=E>M?MB@c;N
Z6E_J__;-H&X[f^E6:,3Z^=9NR8OH^DHF/\d+^7_^T(^T&CL:5[0d4_[\HEWGT_9
D1:#.?c+\M<G7T@UUK#QT.+b7QG2JEe@RG<Gg2GE5/4/>1c2Hb7)HT^\#e]]IV3,
&#[WRMaCMf]QP7QPU:D#XFSV=eb#AH2NW6];J/8>3<L?f;2Q<;aa#MOJEGCK@#@G
PS>GI.34QPQ19Z_0_SW20[9H<;4<Q(Id=6G;38Q\RD^]4=>2XMg??)Y^=8,[Q@\I
KEY.Q]NdEF)g7OQ3C<LcP^07ESXE_=Q^4RPN4H7AWX>YGIF+7J@7dL7O0dE)>B,(
N#CcKJ>DV1DTB4^+/[UFe:#2N]UKg(eA<24.Jf?>gQNa\+PPVM2S4S#Rb\_6:XA-
\>2C8/dAL?KG.8FH7V6+7_1H]K_fZQH.-_GK;+a9f_&B6WX@#6IJ,D3/QY=>W:SN
\a:[]c@dE9A3UK2^CF?7RfKc2B.DHH<g,c#BN9<bBG\CWZ,5>[bSN+M;+d_):0H;
c)5G>R3Q0FK3X4=RZc/5/L,,MC=_@CL04@NYO\M/ENgR@MQC6DS7\ZEb04K48;&A
c7G.3\X3I(8L^3HM7L3@\)P[?6M2GcG6@[II5/Q7JAU,]cLIT?fK_V<:Z9K].4_9
<Z?_N[K=W5=/Z<7G5(RNB^QZ;XW?eQeBM(E59.GI>9OZ@=<)MCE+Y/>c#48dG3b+
EVedUc:AQ\;PML,4T:N]f1?::BLWaR]#8=D-JY6:CAG,LCa:78J>&72\ZQ-K,]5/
HW8/(28fcWMcRe\/^GcZD>cSRXgYAESFgG@=W@.V[P9YQ5I9dW_K2S,-VU70^KP3
:&+Z5#cRX+(:G0?K8Dc+L03E(Nd9QdKBFPFf)X.@KcebPQ]O]LWX_^ZUO=9SJC^(
&+4,OIFP(D[<4\L(<58@Sd4B</,G@JP5S[.&AWI=O5)5EWDURJ#_1?B&(@KZ,aLS
_/ZD8Q5\?57QMSV.Ngf9aP:RM.-<J_H8bF>@<@CW,K-Kf@H(ODF&Rd5bgSC@-UDF
5SX1Xd=d2=fgF\Z)[>:@bEZBPa@^KJHIU6LN9O:K<C/HW\[eZ5K02?_I40f+ZH:3
:TU5,-)R312VJJe4Ed#/A;Z6]:9M4=;V\ZYL^3<1Tee&R]6GdMf<(VU4b[LITRQ9
45I3O[fBB(Z?dNfD,B2ZT?]J+g_DJOE\SOHITS:&C#JTd(U)B,E#Hb/09OS]=@_7
M8-+Ob(NMf-?5f8P-RQc>I73#SI]eH&],<=#WO)1C7([KVI&R]X6795<OAd7cG4+
Zee43Q][IF^_63PZPUcC/\^#9J&[FD(/<W>>b&WS3L81#8H22TUFDXbH@#-ec@.3
c8NG;EfNg&9+<95ecT2\O]Q<9#DNO90C\I+d;R?<09/JBe04eC.)#P4cUV[Bf5a6
M;b]_+SUa3M:QEga;^K7Q5gR7.]BH\.CaW&^Ia3QJOB;Tc?^92f:.:8G.)dQK7Vg
4896C?6^8E17fZL_5AP?WDLeEXE8&-TYU(^K2JU\EbL7#1M_Pb0YI>:dY+Be;6a9
((PN&)H8fG.NKUZ414L,]N]IPa]cQdHJ57/cKX0;Z#(Ra#[M8<1-AQ0LTE;P3fR7
W(=]Nde/U3V:#d.M(V?.<MdAN6LN0#>X2cE@\-YW1E#_Ke->,/+VNSCI.)8=8),H
.1B<&fcMFXB3JHH/DS8/E1)-KPDcY3C/C>^Z)D,AN5)7He@Ce6,Ib8^PTM=SdK6K
ccA<\[+K7;_?\,5K6L<-EP^?&+(][ZE97@)aFJCS.24^0\fb>4?@XU;6>-^C;c-+
&BGe?UFD8bg--e:eYJZ/QgBO76>R.(#f<JA,,MbJL9:a9TM05IZ\G7-\;U\T359K
gVH;XNPMeFdD?#+/(1=?2R2[^,K,M3bVS-]5T3(aBeO1^>eYgB532aaW<f:M[1.]
IJb=gYd\^YI#1/\J8@5TeJ/HHe?a4e=<(Jg>f+S?-,BgHUAR=JY90GP5]1+[9@C2
3BZ+@[XN<U,3a\.2OH:W9BOT^^9e3\V[3)VVRJ.Xg;VVW=FUCTH^+P05?abU[];Q
HKQS]DeI>3RS^Z)653:gG-+dJ:.X[D0+8<(7[fKWf;X)JS6Rc,A3cVKYHOUeI[1/
gQ1b#_Q\#@3CcD6],>RS=I7D<<JgTLNV+0U=2H7G+7E9D:eDbAJ]4<Obe+\PB1;O
A-?Fa31Z?NCA]CbY:KZO<M-H4a:WY(SZ7#UWTCfgH:F>9Z^7[)Wb.YP<8_0K3]=#
JZO3;;_GJB47,1XeZ/N:(R#..Z)\A)9]RH0,#;F=1#N=U0F;@8#Ze9819-:9+AFP
2RfU23NMZbR\,2XNX<)XaQ0G4QQDb##c\Z:+=/[:&aY^78MEbO>+WaAYaR?1-b?VT$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_EVERSPIN_TOP_REGISTER_SV

