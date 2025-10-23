
`ifndef GUARD_SVT_SPI_NAND_FLASH_DATA_CACHE_REGISTER_SV
`define GUARD_SVT_SPI_NAND_FLASH_DATA_CACHE_REGISTER_SV 

`include "svt_spi_defines.svi"

// =============================================================================
/**
 *  This is SPI NAND Flash Data Cache class. This holds Cache and Data
 *  registers of NAND Slave device.This is instantiated inside shared_status
 *  object for Selected NAND Flash device. 
 */
class svt_spi_nand_flash_data_cache_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** 
   * SPI NAND Flash Data Register
   * This buffer holds the Data read from Memory Core
   * ECC operation is calculated on this data, corrected and then pass on to
   * #nand_cache_register (Cache Register)
   */ 
  svt_spi_types::word nand_data_register;

  /** SPI NAND Flash cache Register*/
  svt_spi_types::word nand_cache_register;
  
  /** Valid bit for corresponding byte location in #nand_cache_register. */
  bit valid_nand_cache_register [];

  /** SPI NAND FLASH cache Register address. */
  bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] nand_data_page_address;

  /** SPI NAND FLASH cache Register address. */
  bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] nand_cache_page_address;

  /** Specifies the Partition Index Updated by Program Load/Program Load
   * Random Data
   * program.
   */ 
  bit [`SVT_SPI_MAX_PAGE_PROGRAM_PARTITION-1:0] cache_page_program_partition_access;

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
  `svt_vmm_data_new(svt_spi_nand_flash_data_cache_register)
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
  extern function new(string name = "svt_spi_nand_flash_data_cache_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_nand_flash_data_cache_register)
  `svt_data_member_end(svt_spi_nand_flash_data_cache_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_nand_flash_data_cache_register.
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
  `vmm_typename(svt_spi_nand_flash_data_cache_register)
  `vmm_class_factory(svt_spi_nand_flash_data_cache_register)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
Q#M?M0=YUb+;JVFDbP=RM:b6KR\HddD2_N2c.b@/;D:eY^2HHZE(+)AFQF)\91;V
eSb.)b:_ENG4Xf>\WTL#4&4S-#OXbC/J\+JFaTga]-,+6._)6#cdf\ZT-7JRZR)]
#ec-NLRYZ^I(H3>FABRY;+6BDF0F_/KJ96b#=I6g[?cD__T-0R/XHdYG.d&-IFJ=
cG,9df0-/GHAS[BD<87GWe;KT?Ybd4V5\UcaEa:&CUcP51GUEW+bDS&\YX&)8(bM
579PR[\[eTVa\(QU+M_-=\D<FHRb==0f49_Z\NQ_c4-W@T^2D-7MOW;7F<1D@;8#
eT=-@;Dc@[7?5IcIKgIH.5#T@U_Oc3PBP9KVXAEP:+2f2A/4COR?H___)f8ODg?f
9O2E-e@ZL<-_]0AIYU^-2Y=eK_b[JS+;=^eK3dHX60KI:/.Q,BfO&M)2AY^JF(3=
:P3Od;.K7HX\N21>88#McZERZ>Mgc#AYAT\<-\FCK,BDSB=+21NVH\Y.Fa(G5NR8
S3E6;]+N99b#D]ZY-P3Sb3QO9JEZP^COB:W7CePE.,Dg-(3[,T6CM[@_0\3db(a7
#8&OLA_Fe:MR&>MgT<,CZ8J[PW=f8e<XF/<447)O0:&I[_THHH<QIL_VE&,KYRXV
F8_K_F#31:J2J,7Y:aKQJ9:9HN=LXDYY3]eT^FV##d/>+Y+BNAg,0QP#>P24#T^b
VK+=_QDG]B:2/$
`endprotected

   
//vcs_vip_protect
`protected
GKGefe?R):5/fbAG&)^=DYS:3KBcXKE=b&c=P]+P4KQ.ULZdH(L:0(/>SM/3Tb#^
\#G@-)128ceg10Y6R+&gGHGbWY?CeKX<DH4CR,;(]1e\aN_G61a76_;7+QJ&aPe8
@HHSTg9W73B2Q<\IFcf)YGK0RC:-V>R&bIY<&P#IdbRg)VfB1).24XW.JQ<3b-S4
Q\,RGIM>=[+f^H60cbLH@e)AS_<K[B8DObe?7T=HHB._95c?&U\J@H[(N4=UG>\N
9.ZD)#_CHS5HII_7>:gRS0[/<AJLVeJ0F.e1g(?H.M\4f,[(.MXadJ29,Hc@EB&I
;>S[N8GJ5?b:Z-EVgIH<BdYMFU7a>I,;M:=;+W)]AEC8-?5#,&N6NR+VG7<@L&K/
SDB&YHAeM?EA_GT[Fe/XMCN9=4E(M.R6G^1aFVDc8feSVT60G5\G)WY#QcC^d_W8
6QO9=>(QTH#P\e=AO1:^6RRCU63P_UURO4](1OA&H]96c<a,>R;c,)(0DF#O,SUV
?K-DO_87;feXUURB/ePU4KFR1C9AZVB+KA@GK=3-H57N.W;<GBTI@E3HAH0.RDGU
?ZAd+=\aQaCY@<O&T7BaUe0IUBECKU&0?,Y1ILfNI&V^W:6M,c,;],[5cVNCX,D=
F+6=[.ReYEbR6RK2YQOCLH3H9(X9WA4-4/R?M,28,O+F?PReO8LS33?E65IF=L>0
1Y98Y/H1T&TbU19(VU/X#?\Z8.\LIQD0#B-W:JZ[^N5/ZH/7,ZP>?V7=?J:06J6c
=P5M[gB(W^3b&4(^X^LH\R+g+_M0+J?1\CHRAAVd05J^G4Z]Pa+gF6?=+f/E@6D,
&5DR2CR5GG44EJ6V(U@96.4)S_)1=DIVV[5/C;?2OD@NQ1?#NM4E&B;>3>7CA1]S
QB?ZdQ.1(g=VWJ\O,]V1HWO5G^VME=3Ba?CLU[O27<OM3?/)S[55-X_>Y)<[P<K9
?=SSDYWC;Kd<gTL0&@MCZ56_g_LAecFIT7C;aY(#;L2S#[O&0G/,]M&Qf3TGO7[c
^&/^_0DZ@(=W(9gYc03AP6.;T.5KVPb<2LbOU#XSgG:X1_=C.4e,?)-G2T4RdeOX
P#Gf;PCD;PWTL4c(bg^GJ+ORL8RX@#KDJ1KNKGJg,&Xb?e;dNF9.L0(^b.G40)_&
/<76/a2g.51R\0/)1g#EfGYBL3BFfZUb?S<P(gN/8U+RfZT[3Te[NSf5>@IQE-\<
405VbcR+,<I:Xa#73945,4NKR&ZLU<G.85&:BIY4Bc?Na8>A<bVc(g&5ZJdC3&bb
23./[LKL&Q#M@cGGS6ed@Hb,A6O9G88g3_Xb7#^Ub5WLQJ3??-L)33[]@?bX+Pe6
]fK&0?4f=[K.L)0AK^;O>8,?6_L,ST.dD@8-]@A6c,(8:VX7W?K0#4T0ZMC<:ZIE
#?\SO66E#ZSD1T,HC+-KH9>,9?:Jg?ERN_BI?V;^[R9=E-3g/e03CV2?=9-,)0QA
VO#=]G\:;[:70\C,;HQ</(6\9f0ST^c):J0JR58K7]e/8LCZTOeg-.bZR;cE9fFK
X^a_f4?Qf923R.@gR0,S;3?-PeB0CT386J3>,787#Wg#EYAF=DbC-7VRWRMM3fYX
Z]5bH1<Y72GG>)1Z;\-XA4H?EG++/^=gUL[+4I6L_ZP?O(?SQG/CR5K+E]B+/3H]
c(=e);dID8W/1IRM@245W.HTOP^+?K+56ZAK?-U48II&=&5KBC?ULBM#;gN,US,Y
0^NU#SNX?URA9@0N5+S_^98=:CBCH_12+E&@.49;f7[R/NTWBCMG=VLU8OBcC]T]
G\MW>d[F-7Ae&3JAcLRPee>+.L-3K?VHgVDM6TI[+c>#>3-2RUYA@ZMD,+=Bd.f[
R/@5>c=?c:ZFMDPT>e-7RfLU.Yf9PLXM@X7970N?@ZB]R603bU;DY2+gR9(0@N0R
,efCICT<fc?ZZ\0AcK09&(a7X(HB5,)]b_7GFJC7FaFg.McP&CPP=<MH6O9>=Q_2
S[])W25S^#6K&5?M#9G7#&VGAFDN(G><07ZAZQZNA.UJER(&8BT,/A1.:Dc1/1SE
+JD#Ob&e)6U:@@E;\BXCQ@/a>>0ae+X3^e0:U(<,SeI,?eAPJ:Ae2;S\#]gQ:S,N
\U#eL&2E^[H@]U\IM2S;\f@\>+IHBQS5W6YS/T/N_I-0@/e(_K(a.+JS-DE+]e)&
ZD0)R7@e,_458:64<)VCZZDH=HE\R.</GU7\a&Rg:MPP]Rg^KaEDEGJF10^+#T6T
XVc6:@f1T^f592-=N0,@^1b)gb#=:P#TTPJ;<aSG.KEP&1^4aBLIBbS_6H^5:QB,
L#@TDJT+5&gI8_,?Hc/5E>-\DbZM9]W<dKZdQ,NS8]\#3a==,g-Bg91>@_?O1XF3
PC[;T98ND_Lb-YFJIF29LK95I3eHG^]aVM.^b(<@cS92aL^a_Y_5U4C41S4V(9W?
JNG7B-G2?;87R<_2e>Vd4+aQ_>]Z(D=,8K7=4#DI6^P_CcBSQJP_IM?e1@]bN]8E
I+#-A9#[\&Q47EE:K-6(C[2+./I=ZU8?;L:37GP(95cdYQO9?cBCf<Y.I>Q=L:+U
]Y9/ePHL=)GAf5LX>GJ5NIIZd<fSf=HcTPOR_CeC]G-EW<>SV:dOSB;-;_1(@GH+
686FA/dL+gRY:8+POPGXCX/=UQ9T/QF[<=O[SG<E,a)B5A_FWF@OD[:5O1dC0VRa
cR/]NQOFULQO6-M/8+e:e+74^HOf(e3FOG.TP05\c9d>9AF,-:e4P325O+E^J7]\
B_EYE20,9VJRg(19eAdVDEf6eF?#aC4FP8)c./[+dBAR4=B5+GF.I,7COf(B_>[=
JdKNDU,,\ZFfAI4H4ZX:Z;-_>=)E)Ug3T>=U]5WBL7e.Q:5P9>6_VMU9=fORYfa/
F89d2D]G[5[TM8UR#I7W4X8[BQc7[/RX_8L[.ALGP3/6&#ESFEg?0B=YUI7?I.[N
=3V=#T,,#H61:E_K6BB;:VSK&)/_;&([6YR_>E3[d;\V0gGdMNFUK>,bF&:0GQLS
?.C3N_=XGD5D/O04J(6Y\-]-H45g>e6bM@D&C;V?F,^3,UOc(RP83)Nf7,#CTb7X
5_67[]cOPNHAdK6d31e=;4TYd(@6?F6K\K=#>7N6Fdd10BH#a.I[UH,Ta/^/S[J7
)DW@3S+9Bg,LZ,V[UQS]?TaL#I:B?J>gg2M;6aNH,:K:cK1N]c-D4QDXOGOE0\UG
HLVfMD0g0?;M()0S]@QGX,)26#=L?,0K7[H:>1M8BQ<A\N#8ZQ9/\ObHBN1_K]:E
JF7SLGec^38#e\?=?Z(L1Tb91c1E;.N)@<E16TWMb9/c+2V2Yf.BS+QfJb?OSFA=
Fa7bGRVHgH2(X)U9daI).#Tc&V=MTN;6>G(3BN:NM_HKHLUO\Q7BN/,A:5.F/W()
NP#K&?eef<YH\A6eV<).;OB1S,)Q\c&<dB+Z<@NX#O[4TSYXKYeVRDKO,/IRCO>a
XcK&M,40F^<REZ+0NT#RVMILECF+=V-WUWBL;@1e[<_;4/L2^=a-.YABS5&PSTJ]
C9@G+R5FD2)ZQOZH[<dJ(FR5N=Fc5X<f863@/@O>BQ6a0#-M14AA;A06A6(M,\2?
IGB=M-1XDcE>^GZTCRH./P)P.-]XO(Z/#K1(]BUe,N-V:@ER[=cAU-d@3M]H_:7M
1c\eRg<B[gO1(OEgT]9La41:)B0B7g_W2[^AgWSHU6Dda#</YVMC]eaA#Q-9EJI]
:9GcQMU+g-T16Nc30WKP_8>L_g+7Va>eB5&]4.?P@ICI],gXS9>b;5<Zc]E,PXZT
2CK<cSUT/F3?5c\Heb0N4aIJTf[C6,]+/P[G0@;,P6=\JAP=BWDR[_[6HPN;#.OC
D18;g=;07>48\6GT7B01Ab(LbO;@dH]>He,\]bT^KL9W=@[g7\83NKdfdO/54>FD
>4T.>N&Xe\5cfT]H1KI7MDECRYEg14-eAU(GC>.dU;c/\7OAMXgM3.fZ<@XA^b8f
;D_bANEd9RRN,(F\6AR<+dP=@6F8PY&HX&f?dX2+[+<IG4;)Z.33/6<G^aFMO&W4
AaF\2/)O<0?\c60@\ea61G.V##;Z7B7.TSV[I#4fVT3e?#0+@AX7(VW\,Ff\bL(E
E7F0TPXYdc_EBd^N9LRd(\ceZH7N#6)/gJ3/7Dd:,RfF#eB^X[@:&G<V?1.#(Z0K
WO-?cBDDG^07H:5[7E6[PO8,gSD]O]XJWZQ=?f;Vc=ZY\b&d#K#RAXD/:U//H=Ye
=S3-TEZ)c0)(\F;;6gA^&/0N0+=TeQURG?X6I]?3KO.8,_W>&IXB[D)QZY@?EgU-
bUWD92F\[HE6DZ0-+W4S1D_Q6<I=YI3DcW894BZMRW@>)]eMAP>\@>STW@ZRYK/X
JK1BGAM)#^;JKGc66)<MRFJf(\:cJg+2F36^@J<PEZ==<#S.J(Q)]>91;g&3/QX-
/=RHQ?7<04OLCYSLW7M+C0(E/^S)H]I>)?5L_c#A;eA[87U@3A<9).K(RbcVX>P7
@H<dCfM,AO^/4Xd0C.#1I;Z?.5=>2&,A[2JK-3+F@_GL5W0FP:TRg[5&3B+]aD,0
0>I&O9=H3O_[Y9>I2E@>,VKE(C(Z9#)/?R,2<7bE-E;D@8)_c:<a49@V2>;5DXY7
UE[GZGDD+JPO.\6DLL;9C0P65deBL]S,HHgI-=.G^[8Y18E,@=5e1>(ef\d8\aPT
?>9&g/L#a\>:06H?;AWM&E&\R2^RYHcN<gJ#gbdP3(;GSHK,3C7RK1d)e,A5(5@L
>b[ED2F;95d5\=._2@WI>?#[-\?JG]FZ]K\2+aUbS^2eARTJdVeK#H7,gE@7KD]T
[=@5GHe047Q\]O?WHBCeF7=FRVb_S.Y7<?2aEEU?Z10L&+b?0gPBd(4TSY=/<f22
^/f6f@OH+2[E7\c;+.U]7XABRf\AHJZL+KgME4ORF=#.a,8a416=)0HH-AVT^fdS
:b@IOegE&DgCKE<AT\(;]UgH::>Dg):UBJRb<#ER6G,b3a(,4c[1RMS;S-0KCE._
fTedN6f>Y@DM47AY]<.-)6D61c_9>MDL4U;W4<@]MT<J6;#dL:>7L77]186c[)]d
/_0>\MB2>b3O:;+\eN@L]\1__Y?W#_F<));YH,^CVaK_J2,B562[WH]B)D9W.7b(
8DKQ^8YcF;V:RZ51EZcVJ<RID5SV)GgIe5f0a8.V93XU+U:fUbZ)V]bdVSZ]_?g_
-N_,Q0(b8>O>F/5]-<g=.;8>\IW(KK_DK6e&UIbegPcLd,WP1H3N,++:(T=<g;Ma
5LL:_/c4TL7SE\da><P3D+>#_;3:2@HF+G&\bA^ea6b3A66J/^ZHe,LHJMHR(GaZ
4ZP@&>CdXYFe<F5L80c5]>BQ=]RD<6=3G&a7gBKV]<SY=MCMA<[XU#BJD@(/J>]_
egR^0&<-7WQG&[597IDb5Lf@])VG&J&Hd&+US-)F#9W)Tfe_^/O7CJ=ZH@Y=ZYVc
/G5>2@=_OfGD0;Z));RbZf&:H88CR^/;Q/T/,+;<a^<\)AD?3(&OC[NQ,e:WMIGI
T8RQd@7MKbfdQG=>eJVd^MZcC@HfO5PIOaG:E&)?.DTV^&@D^e)(D^U+,F\+DA<Q
@c0KN,..0#X;O[a9@<RDD(O:g&eKNg?D#?8=ED<d4>=bJ.9(8D4D)#fU&IL<2&@,
&IA;eE<@K2ECDcM\VY1)Q;#daC4d+Z0SaR?8#8W+)OXOYT&-28TL9(^UcLAYEE=;
^G/cdAWCWXdB#:@@E4@GZ2HV7gD0,R/,Fd-gdAU3H/d6A>(;[@(]R)]M?K\3e:,5
8O[\^=36C_BdEe<fMQ&9TN(gI3Q3;CcU_59]B##AS9=58M-)ZFRYZ(I49;Q=@YKb
ccMH6E_W/7Vb7YNIfA9d:C_0_:a3;@>9]Y_UIHgARV\3f9(gG(O7:Ya(8-c;\Z?6
f=6QdcbZD2A25VME\#X(0SND8GU]>e@FUIN/MVLa/eE;6+E<FUF#c?/3>_a9&[H7
_7d-NJLc49K,a0\dA4gHN8]bX@9Qd_ZNS./g73WLL?^G)R7K.@+),d+XY/Ig\2Z;
XV7?J7a=FGN4HZ&06ZD.Ld>HdSFW.2.?5T=&07bZUY68Z,#YS5gG1f_Wg&3.;E\e
MW+NPHY_6),Jd=cdgdZ2F=eCL^A]43g=9C#ER7_4W4C5YBTH4P@eZ=T9,55)V=0e
@b#eS-&ZPd=S9&G3dDb=OaGUPC_dLHC=;:#4/=ZfW?;a6e_>/5@<88V]^S:P\Z\b
E1(#-[(;\RD:Q>M5/?<41NGeCN<+/YD]8E?,/5PC/_\]2TMH1^7EQ/.Y\#67d,AS
06:<+&O&2VR_cg9D4=f^0\VF[8E/#0O([\#<f:3KZNWFYfSGfVT#6W/?dg.9S=&\
&GM]Y>Cb+:.LG#P8eV92WI+SL+(^O2SZT4YEO@aZE@BRKP25]D^T##feR\gGTZ#>
=3;U4Wb5+T7CJHZ)F6SEXBSSa)U([?^=^7-a;A2JTT0C&d=:ZN1QOL#N)EBR7O.W
NZT\LB?Q=K]#8Y]/[-PA08RW\,T)GYA;11EdA_1c&g5VI36E2XG4U/H/>;\bGIX+
&S<#\[7?)JE7.BL6>=UB)W^6VMB19V5^Y8FZ/g#6QTgE(Y,,JL;MfGQNYb\V]JJ@
a+WNY\dLJ^cW>@)_ZVc:]ea^K[,X-YSg4;E3AG20WW?1R(@_:-F/@>;8@Q8D^PdO
7NP.NCJM<MOG_9D+1HQ-B/CJO7dJM,f8Y3#,,3-Q#S/?+KS<-R@e]gX[E&[]HF5L
(XI\+X.2<\SIaMKg)GK698M.+Ea-9P(cTc2)#7,&bEH48KM62=eRZAbV.R#]]dC0
g;YfP.g=c/e,HfF<F+_-(?5J4.I<;,GVX:8,V,)V4/^IGV1af4/P..Z8/(]4gN5c
/HW0(/RZSYAFPWf35#7bCXUgQLAEZZ4ZbRB\Z97L>?e@bX)2B+>77#@R8gJW)Z<8
-VES1GM^3JL/PU0-L;)2Tg2YB#?Ea8//PM0H<;b7cR.Z,=GTd/].c2A]<(c,#ATL
f[7MM.>ELAcDV4,N7QDR[H8c28c2bcb^dFf3<AANY,EH62+aX.bKCP:8B=/F&fIA
:]0Oc9=(:POBOb+bKF>+W2Z9K+/[;g<A]<N.La;3N#=8bH[)XRfObF_7M9\9MeET
0d_BbLed\dK2[./f:d<?@;-=SKG-@W?O6?:@c@eC[,+54/:6_/-gR4aYX\Rf-H^e
@AA@NF8VA4,M.#]WY-#=57^O6:]Ub.<Cg.A8;:fE=f8>7H?8ICNPO^6OZ4/<_I=C
,+SW)EV??7,DOS=^/S)YI:9XIV9Tb(PdAZQg@8Q1XJ>OO91Z^9=UW-LLf#\XC2??
=6/VIZTeSTTa916D:IT;D4b:9,/&f;]c9UPSB/bO4E[?GXN:dVO_04ES(J\(>B7Q
I3I9Pg\G.V#Y>5LCI_W>d;K,QD,]2N^JF>eIHg4F2eLD)f#[2cJ,G/K=C9W1P/XK
F7;=SP)EN;>]J?<<P0@#BCa5U^HRS>=W5A)(<.f;+TE0F.OHT1]CL^QPdPMB08:(
8BY2G5K8X#cEC3F[P#F0SO^ZIRFAZR&]dKLJ)D_>/G)UQL)dReY>EVD0DP](B5=R
MUKM>f7X\7a-Ad[/6]R:U:Uf4?(5Z#&M\,XBH4(b^K_A16c,7:9OccPf6YXcf>3S
CT]8@H8A2J5)5:53OAM9HcSC(@VMK>#J8gVS8@43DgOFM&1YOZfNNHZVI.6B>:3L
Jg6(:^Nb0.;VIQ/CV10EUOHeM)aNL]Z+B+8&MU.29UI/OKCC=OC_8>C2W?b;,9P6
@ZMf;0Ia3:;Q>?:SKBFeR7+aICVdK#BN-TP?._c0bXD41d9JE,VY\6IR;FeM5]2E
cX13=2V)SP7XA,5bfeQW\QIY;KL9:a#C@ggK]7<Qg<MPeCT?,[XB)a^;faJ&3WKC
,_CJ)K^0E_e9+O/-WPUT0>(ZJG)F2T7cQBUVF@B4:X,.C]Z>ZgSVX@[f&OZ.c7Ie
U3@XOT_bK)-,J?3V.=IA2<?^KR8G<K^0L2>8EI.,5,g^.()\V>2S<LK@JU>QK3ZU
Dd2G)_T&XdI+b>MEF3\L.Z\I8^>S6GY_f4S=JCIKgQ:AV0c\YD)bLWB#,F.9_1=T
e1L=XbN+gBNO_Ag&[]Z(b2H<ZLaKF@W+dd@<:^F1-\0CBF++)V?YJGELa1c+2RHI
AYca+CGb/a\]]N,AAQD3;3UL+<2NW.?BY<I[MIc-E&1Fc:9.AL3Eb;>W/=fPYG@O
]DTJSI2H4BP3RORPfXU,=SF)TIAbQCDRMdP/XXP=+MQDE0#]A&7bUHZE15eK+96J
e5);6e8Dg<H(b:Hc),U5fH,B2&JgZU]9e:B0fU#6(<.?W,fc_5aB-:aO)eDJdDRT
#3<5+ABbIZP.[.S9-fLR8KC)Q\=3;Kc1Y0UbKA?fK)6H=Y8BLWGU#0&MR)NHYRb@
]8X/\C1g5QF+gDNS;I.7N0<ec3A0@@e@E8.;cNb8FO&704[WV:\=H;9A(.d_9g#5
Xfa3/E6Z>9Rg2_e082@SCg+Q5D+PLKg6E+^70cN))1_1#8ZD2GYJFfILgZ>ag0W:
U]HCHL>fN[eA+HfH6__eFBegF]TgU\I.)8QeZL:NYcO4Xb[[O=<:72=FGYRN3N9S
D2GC6DEJM0T.=9^0YDT_3fLMT8g>.S@@RWNeQfg2F>,gfK;+)9cS>9b5LaC:Y7?8
:aS:9e@5@AP;+/^R7R@1S1Wg[b4<d/))K1PI[1-_4=&e4Q3WR1Db+5g:HR4H30MX
31=\D0b9gM@NH.G8+Xd;#G<_RgK-GTJB)/g5(3MFRFX42^NHEYB9-ZF;);2\OXG6
dV1PeN6=b3?]8S.TfU;=6,fXZKH:#7T_a(BC.2QRM3:Y4-c1=1:VD\LKGf_E->gd
WcCI,Rd\FNF5J>WA^=[(e.-N(CKJI:\8JZQ>5S=LDZF)(7N[(b5[5?R(L]2F8X3V
:Q[GgW>TSSO:a5UdSC4L)RLI>f>Xe[14#bfZGf(ZbJe4/X.#(SUCHV[^F:1]6IW:
/-ZEY7F@GXJ6\LV)>?Y?4D3/=BcM)LJVO?X)ge13+f9/7KT2cJH=Bf#W&AQHgN2d
B;T[+4DH4\^JF35,SQP0_7UQQ?5d>D:@#+,DP8GLK>JYHF4+[eS;>CI(^>\HTf8/
_dg/I6>DO-C)_TW=X8URZf0;5@L2>048Ka],b\g9PWV_V?JOJ,WB8:M;(\SNM/9^
bfO2\M@##-[55-9GTbeB7eEMXBUS,F(73JZc63d?+[TF.H-P<37N3&Q8.T:7XZU5
^a>c9YZFM@BbBJcEHTEfQ.,G1;a0>-bGAPBaG;Xd_)X;YN[7V:Xga&+;CY:[dXOb
ZQCX44QF?d?EF1VB=QDXLX&WOCXSZBKR]U<:>J\K2BO+2<Ef/MDeLU.]aL&W8;)J
fTCS6MAMR/3,9ON[;NUg7YQ7IR&,82EA8<J0D5YDSB,3O+?b736G>BY+792_SId4
6D,\;?&F8XXQLY[Rbb(XH+9;#6;@0#.FJU:5\6T@S:]HE9_]6[b8g>HB&P[6-d03
W(Q8;=&/[._2RZVCSIH6N^V,4DQ?+]f@,5304dcGePe+Z8AgL:4[HcG8NHaAD;^[
EcNL53I5:Q^:R7^YTcMec:Xd+#JS/&@8CgX((aVA#.FG.EB8bB#.506;OCCRc@RR
Q0@0dZB=D1e=ZBYT^KWE.e9OE8DS&NI5MEfJ^&?=1Vde7eRSU@2^NJCJc098G-3\
MNG9MbZ^D.X7IZWTYWR?aJ6^d<CY:5+b0JV.bH[KVP::.Ze@FAH2/QO)d4dWCVd:
WL\QZfd;IG_Y^/?MFM+CMf2_Na?,14\QV>J_V\eU]-7&Ae;AQ\Z1\K5=&f,gON>A
:2Mg@&#\5@NDV0U12K6^#X1OMQ6:ZXO)5[R8U5]E4g1CL8:6]@AR_P1&GPXCJWH[
#8+Ke@0eR>ZI@NEb4F6IG=VPUe;WE#RMX][D0O,L/PQH</1]SM?#?CKKPN38Q3YA
<fQ7[&&(5/D,ADD/H#>W?g,L?C0#?I@a3S<PATVgfON)1^4K(]K9VaZO9(_)7<XE
I8C-?8?9,D1I4#)5#(U.:3(:-fc/YPf=f-YC(VD7a\ZS7V^,CNPRG-7#9WXE^DAH
&HYSZB#<@;<G1f+KC5<-+6Xa(L??Ib^+0>YHgY3W;XE-E:Y>D3#OfA78De1;UPB1
DIa,.YI)M?4X0NY0(2^/U))2d]P28e82;QBWZB^f]YM^d[aM1W8(>?O1gY6VDeDJ
a/PKQ:KaY=I_RUZ^TJ4MK@0[NAc#(4fWOS78?cfL/VBFY3.gMEPA<HGd<;NXT#X4
?>A(ZNc;55>3cV?=\K1da/YXY?-#87F#5>XT?9H-8^;7RH-F_6]f^5JI,4Qg:<8Q
UG)6-3KH(c1G;H9_E]Q42>E]\A]?KN;e^^FXB<=+9NG/A;XN5;^:eZ\K:>00=e6P
V6Q,)1C>HKTc_32IB===\D\LGOSWT.A/a\,G(PLWHHSYTDfPcc\\#9)(60+P-8NC
W/JXF#+@_HO8K-+1LA7>+K9d5,[6#C;]W\+/F8aJ<Q2RGG=U9?+gTFJ[?G4Q29;1
?9=FJ3W.CE@MS#SLI/F^4VBaQ0)Z&SR)[8f&eMVT/3O4U=WN33V-d35\@9AO+-IR
PS/6Z]:O;5:Wg&N&1WUH]Z]^GH.CPX>dJ+MPZGDdQ?a(0KJAQe-3>/JRKAD-7b0>
aPDPHa&B29153<4Jf5C_KF]Vb?JS[9SdZaWYgKCCTQQL(&GG/S&7+_,II2aQV[Q6
dE5:[X>ad@=;6A@^?[K_[RKJE>].7#9IbU2d?<GAID5O382M,Bg\WQJG4GM#+/=K
2&U(GQK5g.@8_Z[ASSLKP/M/4>W2>d#ROb;-TRIc9d/Ub;A=M0.LYQf64gBDQU)5
4Q?M0-Y3UB,2>4S.UNSN.)dUNUc4TN.Jc<ZM2XRMDM^cX-NX#W<\8MIN)RbW7H1V
W;6UVZ<OX0T].#\PMPVKJC4I<UI6]_?W7,3B_P?M\[3:H3,e39^T-(BL;899)-Gf
6GRJ+-D4G2#ZK;:I[_0)F&K=4?BTfYG_#e=T)2?:3@#8fgQA)G=\5f_/U_MYEP&d
f):L[#cWVea=)GMQ&AI:T2Gg#7GN>UPJ?#04^&be3fCLb7_=E^?1UJJ(J-6^)TH@
/[bSbd^1CZG1O(6TNTcO(RHKVF@f/VB(TA<+4YP1=[)[LS[b&>=+&HA[,]Ve:(2.
]f4IE0_e4XP?.P<8<MYZaG)<0@ga^3_-Y7>:KV5P>TW:A8N\_ON2@fC7ROL/DP/O
Y5JQ86UTLT_Z_3@^a>^LQ[A8C8-H^0f#Fgg&B\&+=I0Q;=5Oa5M@3eZG.8XW(J5)
WEC81)P:44E\HcM/JG+=T-5&:fERHTD0K.XPcXM^O&1WJ/^JLV>4fS6Y2d[4Qd9Y
VXX=,ce/ccI>=O9,^T^YVD2,,U4CTRQG1CgX#4(:EL+fUc?,/fKG0[2S4bXIQEEd
,#=:b?YOGLa;-8Tb3]ZQVX[&6(T_OP9O+#_c8)5a.SO@\O(49=BDOfAG;6DZ]DXU
<[B,2W9MG:N9P43J^</?J1d5>g);KgaKI#-0:CAIbVUOR/G.O]=N/<3RG_W0=TE2
BQ,]TdcIM_Z.Z(R/PU1^EH#0Q7/_:)74(-FY>K)Y,CTQX.4N0>/HB[1D@ZQ?^4BG
<XFBaXSZV.C,1#3cGJ--5<EL_T8,=,a##J,RMYJS45Yga4^XRK\e8KebY?7fJ[W]
JX;RT9KZY>dB3)Z.R0fAL2.LNT/gG?YY978#7?WJD^70FT&LD@N\3N.N7SO+6L.W
,Jf;Z@=5f\B9a@.#YKR0e]<38#O/0[Scd\bIT83X^dGg;@OS3X4+/79LYND6g]c3
9d5?7/C^X,deC1<L?-)FIc,N#Wb3MFcbBfNQ_0Q0B&fRJB#+M8K.>(?#.>_Q6?[>
4W^@g-USPTD-G)@5[]VI#F1MgSAHGf+(YYLU_YMF:PW[^9#H^:gE;>D#bS#fGAPb
G6RZWG)(F-)RUKUN8<R+GEQBdg4b?SI1=<B#5\/.0(d>8-b[F5NEZ?S9=gG;=C#^
IDW+W,DbK>KW9-6)K?91S2^?\]3VAJC\_H;F\a=]fKSI^&2O>BDb]7IdGTW_K;N=
24VT/Ie37gOe5]7QFW)?9\]5?,GKcAf=>WF2fHV3(02XDWdH7)FbKYf,MaUQdA.?
.H_6g7D5bHP<NM>F]LD&#9+DBROaF@,4L<^g?0\0,gUY0>fc(9BRR177EQ5b/#c_
e&&^A0PAc0<(6G(QP@Sc:RE^8-\WPBD3&T0@EdQPJ[4.[]U<BcKSPR.]5ONC?5f#
\SY\W[.A/)?FD=B<77Be(AX.P^Q=[66(4>?4Kd059W^FP]T#/[5;/dGNU6e,I>@7
D?Z(>@F,96WXQ0E-E:#H6<eBUG,M.(LHH,<IVfN#6QH:R@HT30B#H/7Y_#_eVG+3
/NJ:G_IaVXF?^2G_Nf(R>G4TUP>2O3[fRJU7dAdSd(LI9S?9D@aNVFL\C4X_\RA2
O0M;X_RAUf=6fCS2)P/BHMT:SY/_]G[Saab1-,[^\Agd=P3)#FQHcMVC9dBNKV[T
@d=K3Z,Mf^/;&5)IBEPg6;04a8M96]7)K-E>CP7<WRL6F<LGb_N&PVT/5e6[..FX
8V6P^FP)FC;3R,+#Z4E6,<Z#a,.JLPMM\aJ()BCb34Ue<VOdIIGYH9DAOd6<,S6b
M,Z[a-,dcO@e^1a,U?4>eD<6KSX1B-.f_#:F;Y9#M=AT]C9KU[QLaYRK8cR5c?DB
a5U2+H+;6,Yf/0aL71N;2RVWL6#>?U][1DJZfGc<a,._HL=[^9MUS@>F2+U:aKA)
ZR[]CWW5B_0]41a>Oc/>N5J^e2eD)FXUR^f/G?6MUT4I8#B-fe.8fTB(T4?T]\1Y
R[#&ce]NKI^B,\F((#+OYP@H8U.S0Q?-9XN8Nc@,I-RALOU.eO@ZZ@E2OOg@\,]1
FK>JXF;aJT>0Udb:\L&^,F2@TPbJbCO34[P_AL8&7_7>FF<B>1S>S(^c3K2TZCMX
Z/GZ4fB5e3K[3Z3.T<>JB#=2dgaP;Z<=cX_1J=d#AZL@VB1._;U__b.E<IX(WZQa
=MTO2<.:cWWOM4H1&IUY@AET1]=@W0M+[:M30RULOZCG+KcECK)CeFRC_/NI,.(8
=G]eUT#S-6_.Cg(<MB?EA?T@+#@<6=A<bb&@6KO\cSa97F>.#BS:#EI(?Pf6/9#B
>??CA;R9:S(S=YK:FCNM0S8Af&1H75-8)N,@U2M,3gA#W[^5FF@UAZ0+FFUcX]B&
N=6=#\VR87Y>:O:0T:+@:6<[5JGPg^95(=KbF6-+TfNB?)];V>=T>=b_4fZ;8Q-A
Y+9R(#YS63.BR\^>.\W^2]4],LD>#X:D\A9H;T:FdSgCNDWA^Dc1?,4HX@cZD;;/
;Q]+:MB3NV4<9,JZ.J(Zg79@K-;I)9/;b15.U@21;@.:-RgT3<Yf[#X2ETYZ##L?
Z]-Q8aa#](=c,:CU#^<U;(+@]0-)W87.]YdK-_L9=)N=L_ECBaL4?7ca5WALgEZ6
4(W#1T^T<?g-5/ZMW:=0:bCYJ7T[2C?.fTI>=7:S[5O@d.9bg)60d+Dbc[HED8_N
5]A/,eC^^bV7d?f;/OK#Ba<9e)g&<d9,//a]9W88@^@>_9(LDe.fgJfZ\#g+<b1X
K3#e<>@^>D>D]eUVQ3F8g@aG2bTg@?Z\cG<N<6KHET[//\]eS@J&@5>FUS.e4ZbN
ZI>S,3-5[-FFS62Z&,<DKa^-9e)4T71KXX/D[fO=K2ZgUcF;)0UIa1@KCQ=F;7@7
cKcY>\=Tf&ZDbQ]Y0C)<)ZDQ>e1&/];=b\A;bC(Y97W9:ZA&-\SgZT&+<_@W8ETa
f[@;)?cN+2N;#KHOTc1aDF\C3eO7JFR_0JY)H=5ObWH,g2&2eC=N/6CSd(g4MR)C
AdLBV^@d2?H9Rg<C8:5VK1#7HI=](cO:>Ka^HG?1M71g28W0(_]M]ZRVT,97a7#C
eGYCS+3fG0G=)_U5:Lg5@ROQJ;1b8M]LGLIAFa2=U/3f<-7H>_4?>Yb,@-F4)(,9
FFMK;IC=##gOg&9,fb0-/f_L.[^LI)0UYIKQG+_M]S>fD$
`endprotected


`endif // GUARD_SVT_SPI_NAND_FLASH_DATA_CACHE_REGISTER_SV

