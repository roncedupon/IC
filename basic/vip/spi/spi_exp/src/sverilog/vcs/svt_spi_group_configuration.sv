
`ifndef GUARD_SVT_SPI_AGENT_CONFIGURATION_SV
`define GUARD_SVT_SPI_AGENT_CONFIGURATION_SV 

`include "svt_spi_defines.svi"

`ifdef SVT_VMM_TECHNOLOGY
`define SVT_SPI_AGENT_CONFIGURATION_TYPE svt_spi_group_configuration
`else
`define SVT_SPI_AGENT_CONFIGURATION_TYPE svt_spi_agent_configuration
`endif

typedef class svt_spi_system_configuration;

// =============================================================================
/**
 * This class contains details about the spi `SVT_SPI_AGENT_CONFIGURATION_TYPE configuration.
 */
class `SVT_SPI_AGENT_CONFIGURATION_TYPE extends svt_spi_configuration;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Bit indicating whether the VIP is to be used in Active or Passive mode */
  bit is_active = 1'b1;

  /** Bit indicating whether an Active VIP should include monitor capabilities */
  bit enable_monitor = 1;

  /** SPI enable_txrx_chk bit enables protocol checking*/
  bit enable_txrx_chk = 1'b1;

  /** SPI enable_txrx_cov bit enables functional coverage */
  bit enable_txrx_cov = 1'b0;

  /** SPI enable_checks_cov bit enables coverage for protocol checking */
  bit enable_checks_cov = 1'b0;

  /** SPI enable_txrx_xml_gen bit enables xml generation for annotating functional coverage */
  bit enable_txrx_xml_gen = 1'b0;

  /**
  * Determines in which format the file should write the transaction data.
  * A value 0 indicates XML format, 1 indicates FSDB and 2 indicates both XML and FSDB.
  */
  svt_xml_writer::format_type_enum pa_format_type = svt_xml_writer::FSDB;

  /** SPI enable_exceptions bit */
  bit enable_exceptions = 1'b0;

  /** SPI enable_txrx_reporting int, indicating operation enable and depth. */
  int enable_txrx_reporting = 1'b0;

  /** SPI enable_txrx_tracing int, indicating operation enable and depth. */
  int enable_txrx_tracing = 1'b0;
  
  /**
   * This field is effective when #enable_txrx_cov is enabled for SPI Flash mode. <br/>
   * It is used to select supported flash part numbers whose coverage object shall be created.<br/>
   * Coverage bins of loaded part number will be populated in a particular simulation. <br/>
   * Simulation run with different part numbers selected can be accumulated to check the verification completeness. <br/>
   * For example : <br/>
   * enable_spi_flash_catalog_coverage["N25Q_1Gb_3V_65nm"] = 1, creates the Coverage
   * object for N25Q_1Gb_3V_65nm device. <br/>
   * Similarly coverage can be enabled/disabled for multiple supported part numbers. <br/>
   * Please refer to catalog for list of supported part numbers. <br/>
   * If a SOC supports Two part numbers lets say N25Q_1Gb_3V_65nm & N25Q_512Mb_3V_65nm. <br/>
   * We must enable this array for two supported part numbers. <br/>
   * Simulation run with diffent part number can be merged for verification closure. <br/>
   * If this array is empty then by default coveage object for only selected part <br/>
   * number will be created when #enable_txrx_cov is enabled.
   */ 
  bit enable_spi_flash_catalog_coverage[string];
  
  /**
   * Reference to the system configuration object.
   */
  svt_spi_system_configuration sys_cfg;

  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------

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
  `svt_vmm_data_new(`SVT_SPI_AGENT_CONFIGURATION_TYPE)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate 
   * argument values to the parent class.
   *
   * @param log VMM log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the configuration.
   */
  extern function new(string name = `SVT_DATA_UTIL_ARG_TO_STRING(`SVT_SPI_AGENT_CONFIGURATION_TYPE));
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(`SVT_SPI_AGENT_CONFIGURATION_TYPE)
    `svt_field_aa_int_string(enable_spi_flash_catalog_coverage, `SVT_ALL_ON)
    `svt_field_object(sys_cfg,`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE, `SVT_HOW_REF)
  `svt_data_member_end(`SVT_SPI_AGENT_CONFIGURATION_TYPE)
   
  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type `SVT_SPI_AGENT_CONFIGURATION_TYPE.
   */
  extern virtual function vmm_data do_allocate();
`endif

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data(`SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind.
   * Differences are placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`endif

  //----------------------------------------------------------------------------
  /**
   * Does a basic validation of this configuration object.
   *
   * @param silent bit indicating whether failures should result in warning messages.
   * @param kind This int indicates the type of is_avalid check to attempt. 
   */ 
  extern virtual function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

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
  extern virtual function bit encode_prop_val( string prop_name,
                                               string prop_val_string,
                                               ref bit [1023:0] prop_val,
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
  extern virtual function bit decode_prop_val( string prop_name,
                                               bit [1023:0] prop_val,
                                               ref string prop_val_string,
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

`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * This method returns the maximum packer bytes value required by SPI. This is
   * checked against `SVT_XVM(MAX_PACKER_BYTES) to make sure the specified setting is
   * sufficient for SPI.
   */
  extern virtual function int get_packer_max_bytes_required();
`endif
  /**
   * Assigns SPI interface to this configuration.
   *
   * @param vif Interface for the SPI agent. 
   */
  extern function void set_spi_if(svt_spi_vif vif);

  // ---------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(`SVT_SPI_AGENT_CONFIGURATION_TYPE)
  `vmm_class_factory(`SVT_SPI_AGENT_CONFIGURATION_TYPE)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
(a6&A6KP+R7eJb#_8a9\2J5=M>V+:@DF^^=/NF=?7S1Z@<9DU(T7,)-fI=f7E0FC
&#AT#23c;Y(DTd]+Pg)\L8KB41Pe7Q7M)Y@Jfe7.J_]QQ:,])-M[:92J5Hff/fQZ
9J1gVeW)=0U[dEdRA/4+b,?\_>,9]QUU4Za\E\VB[.aG:((JH(AOf63PL]WR;P#\
6]df^;:fd_R1cM#1[.?[I/=(8E(-OTe;RCWdBPPe4@faY&_-R)9?ZR(>E[RHF+WB
MeR-I_.4YU>4@a5a7_O^CV\J)ReZ#;R.V1KP48;<a&T?fRDT[>gc^<6R&6[GD8\E
VEJZ?\]7L0<?HAJ:VP:(?JUGgRG0,RQG+I2.3X)HX]]fLOYURYFA\]T8c24g)1La
XWG)Z>&R2N11W.&X&.8V?,9BP7>@J2;,I]WA(P84[6:1WO:A2gc1C&5:7)d1UEgf
LG&XgeXUB6cBES=REY,7P.DA/95I5LcZfMe22EY+W3JQO?Q:0Q#?RaA0fcVa4N\H
LOO2&a@@;#H0)I#EU6b^#C,a16-Q^<BE)b2Pg_840&U,g,cCb\?-3X+^/eVZBG^>
#85?-aRggB60-$
`endprotected


//vcs_vip_protect
`protected
0g\A8J4XH0IaD+G6CB2<>7Ndg6./b<L3S:#0:H)N7cfCNAMWV+Ia,(b.VU;8S)I^
eRCTHQ:/[&+3Z-.eOAX<OF5A]a)N3/De3=#a>X8,#+9JGD^D3L^8QIH2,E)d(9?B
CEb7_EUa76fbF2E@=^,IRD/)76UI1L=3=IZ0Wf_DHZAWf0H1gT>=\?O@EVMCfL]4
D(Y4U5G<XRBf-7Z2HJB6@NV(0SK(:IMF<e\ZK[,M[/4<QU/&6eb2.=).9G1N2U9S
YeFa>#T=X:..AXLY=H_S,RHH)b+OJb]+cTT3&OW70e?GEbW,Za[;CRDV7LYT3XIC
aa06KBPYf=d^@EQTF;-),&_P2C#XIRQ<_E]T7V6)-L<f^db:VM-.A7Y\,>BAg3-C
?1V[3KR[D5Z40&g.A+Kg=K;)CY;\=cbNQH8&/P,@^UL\cQ3^1@G=@OWB:@K_KCK?
X:UWY&F^?@VPH5UHfQ7G8P\.[>B?;91+C1R=@g.FWJa4?7-EIB2^.]+cY9K7;R<Z
\97=fUNRDeYb^2:T&YR,32JQ5?]J5g4+8_MPGL@/FN0b<:IJ4(MfB9f_eOORL]/B
(9;:BdD<Xa8K(.f120HYENaVfeU,Ua4RQJ=7&4a?:.0cY\+6=H:-g@TX7GW=&1K8
T1<Q[\&CP?(B2@V6>D8I36F/5g99<RKRY\A-,Re,>5+X-K,cR-<68G8,W&G>8bCN
cd9(CgYK#b@@>9#CR)@4>WSf6S^)-,8[-Q,?YH[aH71E^;0D&V2<_e<fN75+Xc&U
G#,&.ee/?f0,[5<I6ESZSMC,0)\+QZKSTVK(.X_dXbeG>Z55EaNRTIB-E0B-8U7M
MS6\F:JQ@@0#-7+OGa9[IcF=S[.CT\EF0)RB5:(9P479\@-8AXW]D]fA(OD/I@IO
e-.O=WZN?Q5NY+2XHRZ28^R:?+E9H2<\++Qb,E#U[2LK.09-a#33]e\K/b,_[.-Y
]4(,XL\2B^&4ETbD-@@9#J+V-fG&^VKBN(2M[G<VK\B>:H/d/_,4H0T?)_Q=QDg3
5-ZHJUObF#2@/gaH;F^MfKM8NdL(W:=],+H:B[OH-97+,IV7H6#?K/3bdK8K8&+U
&bWZ[C-P@F-^=+L(?49F7gLgAL_TW@X7AS8^O3O_=S+&/F9@>8)?2URK\<-Q#)DJ
3-4g2(2?3ON.)N4WbT(1_e\XYc2S3[N\77/]H.T\:L87/[ZPK)gX=8F\U?//R0ND
NKJ8A2&CcUC,\3bBLdNCP;I>::UZU;g2L[>gB_?IB,Jb.Bg?6-47fX\B40Y6X@\f
_K9[8>1Jd>/;RU7/3]=_N[gJC;P7GKcY7NT^DIY4AI8<J:dgB6BP3T?J8cQQYQQU
W<UOCGS+;>O3^Q7Y1V-B1UBD\bT12?YW+ED;S#7d+>#9]]0S7dLWKaOM</KJN:UY
4,6B=J\\[:V(;:XHG:Q@<\<X0&N@P58?^\9]T=:82-.YeXPKM-#>FMC8DGH/a93L
ZV2gRa6XebZ<]KSHI4@=ZcQeFF,R34XQIB6+1fH)H[NRb5];=E&0TN<_FeaR:X@F
Y&TaI#.BNR-EHGR=8O5>JdFU;dKc^](RcO/5b5#4\fV4B/15N4OY.@Z4He87(Y11
eH0P/aR@J+.fS<1VIMKK.I=?/GIAA=6f&MI?/)UWMe.(dUEe^]-E\Q2X)N1#>T^X
&5e.V3CIK>R5e>JX@\/Ce#N76CBQID/:bLV3IKJC=[)X8Q,54RP3f^Tg[WX0[M78
aH.[L/,aIJ=,(e28=cZ^;6NJNR9eNe8M6K:]]V9YLQFcWdX0JLUJ&]FK-[@f<3WJ
5fNROYVG#B&4G,;Q3D(NM>8ab_d?WH=O6R5&[@fX]Bb?#:/CI<-MR07(?)LIKSH7
]]G;_AJ?DTKJ?D[RA,eW>0J7D,G&2.&R)PU#XZC94S&7?c9N@2#,Z+?[F_C(0Y#6
GbbO_<+(b2ZJEcKMd3Mg^MFN0/\\>>&5f1@W)N8.-efZT5=U.MUaT4BKX[6f>fcC
/?^)a\6XJB@IW^+<U>9)H.gUC:M-\0B?\=+3\Bgc?/g86?:#.\OI-0#cXb=YJ<=Q
6YYZ_V0GYL/ZdTU]VP:gEYYf2J^GD2SGPC,EU5^8N-I=WJ4:b6H8:SR[QYUZc89Q
^J=TO)[57EDJAg]=8P_De5^_,2CE)(eb&#ZZS9B^M7-L3GU:+TI&-1FKAag2J#K]
<BHdXV31&\c8&M)-;Vc:3,<AC[/+(>_;NH-QP8JJC.Q?BK&]^NKA)_3R-2P[KZ)S
Hd);c&XL5G213N]c7cGbaYPMIF>Qf(U;:C4YKdQKER5dY-26M^f;f<R4D99HbfUX
.F4eOQ--)e+>FQ9L)U4\D?cGEA+IfT,@3E?3Iae=V5>XaZ6HN2Z\bg-MMWf&bVg]
H??BI,@+X7_>TaK(C[/>>2R98aT+7S@?YT5^gP\8;1&aQ5NV8#?O1HVb<SF:,]c^
ERId<ROKI6Lc4gOc^:&DB6G/eU</Pd^\gKT9LJLWE0^(E[U1/O=1W[^&32LdPcf&
FM9703S@L>d9Dg2=GL3Db7LO(FYId3:c:eYWg3+<Qg9Y[Qf\4:3J:;I8GGAVJZN0
J0^?@aFY86>FB\7F9LL,OCBOgG)HYE?909#,FJQ_2dTEg]28IYC17\)R&)ePd0&6
ACU@6]gZ#CN96AAOE]4A[SP]JH&c5D\-e/?#^;^Hf.-Ff0JPPGR;1e[.4?W9,;,c
bHSf=;TCIN7:(?RN:XgU#P@_FdHaL\4@I/M-V5#))-D>9&I^P?KBD-&))S=f@4.E
8VcH+/X+eNF[CAIH0&#1]-^Z>79\G)5aX#:C(GSZIJFL,#P]0\O(4A/2J8aP5b0a
OH3A4P<Ie&>(&IRc-LWK,2HE/O\@00J4aQ]PNG8)0T73eL.4-c1;8fR[]H2ZPQU\
X&fc[./HSTF.F>=gK51D[]_&1RZ)8,EN5Fb(F09?FAYF\^/]S[Wb?@QfTbB^Z4Ba
)9-GY]0)Je^S/)@Q)9?08J=/PA3eSYR;GU4A[/+#@><^5S\X+U]eC2X,]],:@(7-
M<U>T<Mgd[_D88@6I1HbZ;F;RX&N;F5\;.B4cVNJ@;T36SPFKK#a<eWcK6aH>5WQ
A_-7c+_Cf>)T@G?:)JDJcGVFUdLAQM0^Z7gVP,,/b,IQ#Z<?6-^HXB_W,6>3ecW#
<6M+(0X?Y\cf\2Q?\833@.8M+QZ_&e++371\[Ag(XO/86IRM,,-FUf.K/NG@D\g2
_T2<Eba9^H8+V/K1&B.:BaJZN79TWO&CNL>^U-]G\MI:5@]WaW00g?S?6E2_d[10
LJ3-64&P0aA7Ha;C2b7-,A@^,E1QMO?BTD<PG8UUeN#,GP][+baNaM^L2>+^-8.[
NEUEL^NAFW^f_04LEdRZ29+eP(\6YN4DM?1dfVfXX_;/(K8HX3,))9cGQK+D-E^a
O)a1RH2Y:#VV5U@U/0H>1#,X=_]Y=X\FKZV]gAW];WTJPY856c6cb../J;O+8Q2&
+[5ZbfS3J4]>CabX47FSYd/O7&6I&X7-a8V1BPd&?/=:&K\@HD;g(S]9E09(AeZ[
D+A#K]9B(R\;6e:T\(K:R-F)?[BIZM+=8XO_fE=42+b/\b\aMBG=BM6Rg8?#Y[E8
+^c39+)JY3K@-8>>3>B]M2S\-&NE2Z:g:-YDR:cR:R<VDc:2&Z5<B\dCgUJVVXJ^
O+X4Rf=P-TG_@E7P3b=J>-V1c.I-4)Ff:0>HMNWZNP#=4&GZ<bVZU<,Ubb[9VCP-
KS]E;V1]-2TF:@D[S(J>g77J45d05+bB#;>/E/QEU@VcNbe(D.R?5C8.&6fG\KT^
g321(^:Z5RT=K37<:?T/:?+M9.T\HB536H]EIUa3ffC=LIc&J(Fc#6:V)&DE_PN:
M+(E^8.MKE-\8QX3\b0E&38ff:-VUbLT9L17(cBc^D0(UcHWO?Z.ecSdXQB7YGYJ
2(X#O<G+.M=c4C7Bca=I-]PaFe80FJQUD#DTIfX:X&3bX>,-cOK0>,b<\4P&Q;EB
KZOcM;M1W&SC-M5G1d^TT+-F&;S._EWEg2=>X2Q(\dC&/cf20Y[4(X+MR65=CG?[
YfY:1Y.a_>E@NT>&1G4&#[98?=Ud/RHD?dQbD@88<[G\7<bUId2/,.RM4D=9VDOb
REC&,[#@g<CAHbf6X8<]LOHY7^W?=P=LW-K[N.X/b:O?^3.PN.9R09)/5a;+[O#S
3G.OV_93G=@Z#VJ341M(-#U(,D8]L&&V+9].c=96.86^QQ&E]]<99E_gYA5BbDNf
7/#;SXYXXOF:]^-:T]5+3fFWBP^>6=\T3+3\(^<Y6R^F:9(cH43ANMGSfQJ\d2O2
+TaeB8edb1>@=WD6D>VTHfA2dbT.T3Qb&Z#D:MW6MK;:^YH6+R4Ad0^d#T=&M#7@
6A[JH7J0O[+L<KcBVOSKV.MBS_d:ca&d]LI<_XL/AZ)H,0VQ[UUf/&:4;_f#D]2R
KbI?eZ\Q\;0cYUBD.;W-/>5PHLG77fbMPb8JG@b&6L<FP[1DeGY3dAFX(-2#BS[N
0cdYYT(P8RW:_&fcS1O=Zc?X@&YfUL5)c#1<e+Pd2A+eZ/H44J?XX^6a5.aJUa.B
..Mdf:KO9g67N1:7eH11&D7OHa/:UXX3b,d.8N8gK#E^(W(2D?&>5U6H((@(9\=I
KM,_W(T?<ATT#Y--YU/O.,6UI[WJ_RY77):59#Nd@X=.PeNDP,+CVA(+B(SMT61\
>=^MQU2IXd>Y9-e,Lg;g_[P7&U+7;L,;2W9g[5,acObX<E&&G)J0Y=9HZ)e8U26c
7U-_\8/1W/.NGYFVN9?7:-\M4dWPbL/,#_^W>O@>;TLBR(DCMOS#]8b,;b,)8E4T
0DCCe(Z,O.A#+D50V1e>8))+T&);XUdMV&S+>T6F/)8JW?JTS2#;YOB7TcWUGEBU
@RNZC0WFMMf?#8ZC-3Jf\DH/-gc99g91Jf@L2R>2;<)=\9ANR^ZB@VU/;K++NWML
_5R:S-beE:D@&AMDf2R-\G4Y7dLgad>\PRGWFd.Z_?@,0HA8Q];dQbg6_<YA)?J#
L3P[^P,V;L6XZSA9(dAXQF[0g4UJJ]+cT;QgDCg;/e\aRc;FS,e1+\,M.P/<U:aT
,><]>^M_V\=.//R8W1DX^EdgEaVFVBP]\Cg(>]9b(A[+?HUO_G&,Ye:.T9c8KVM=
U8GYg7+<4UY1Zd&=O;KOE>.K-a0MEa@#fE/N.^Wa3AH[89:HE69K84?DIa;b#g[f
IHdZ+V.6GWG/)UFL/ER^3Pa?(3K&-9\UJ>DGJ&AdLZSXb=ZH>W++6^)Ne;(391&7
70L>MfHPPK0gA9/5:IP0[W)^S^g+AQT4@gV8Z,9/EE4XF/TT93.CK;2gR3gH114T
B>b\f(bX0gPN0^Wd?(c1c=HKMP,,6R#96D;G4HK@#Y9?ZE;)U\=?)=5LPWJ(-\7G
D/,;-]dI^N)8Jg<Ae\8--bf=1a2<##FL]C^M@OU4FZNDS1),Vb/0)YA/:V#G_fRf
77S5<ZHZag8GCZZR]/WXTDU]&dH6gPBd[HZRHJUQ<QWLM++S=2VM_P30HAL?:W&F
H+^-/8[29,4-I/HcA9YdK)gT0,<UA;^RHG]_RN]gR-_gR+@e,T3T/aOH=cU6RC_D
g2<M#Q^B+5)5g?0EfW@ST.E;bZ),+2C.f8FHQ),H(N.V7#M<:3>Z@)&;,N^R-@+8
9dI8?G@(ga2[fW?DGUM?5U\d)Q57T2Ya8KP8-b?cB8/;KA^39BI.BA-?8W&bc9/#
K;Tg==Jf\ZbIMe\N:1XXX9bb:[7P[6IT+<+&PC_HP)QZYN-c/\W3Sd(GK,Vb+L2O
-L;GNPN_Y[K5T-.?@bJ_cZ.+@CY-e7#?f15BNPV@@VRYFU4-7,FBY9X]9&,Z77-b
R#6_O/T1?]a]c^#U@MV(JT/@4HZI5DPFW](@VTXc/f]2Q+W@+ZIRTDN,-HdFE;-B
/N2:ES+7R@4Z3e]UefG=#&<e;2V]^RdaA[2FE;5>_Cd>a-#2TW2B+a6J4O>[+2G.
bUTYZKNg3X^N@.Td/7DA6SMY:NDOd,YI:V:a](FN>Y2=6<b;99,De3G)=<5J^Q<8
#O^+ecB/W&-SWM/HOd&Aa)dD71X,H@LLOe_OXFe@]OJI.JP#9T=B]Sd=RVgELC@4
UbA87?A1S)U=>VMG5Pg0\<_,27gcGN>RLUZfBe7)g.@S\G@dNPY4_OE)I1gRFX?_
ee?,KGO^RK[Z_6U@)P7EYZg.1R@97U2?CB5<]+8;.SS;O2&JX)>?IM0FGee2JQRZ
#8\G>K-3H&[15Z?D=ZC\[1W#U^d2C.f.+fO+d(KP.H<><T,5cQFA:^Q]da0YE0--
@=MISb3f,@P&U1(0g_KLEdOJ<fa;+/W7\/Ec5H\?cLLf.;4XC?aIN)7/CNX/-D>D
M/S4I-WS]1).aLV5bTXPB<VMb;EK:fHZ)c;f?\&g48?&)+[5D9:]U4_)#aROA1>E
MaOHeafT&G6LY0GKCS6;3D/:[2-69CT<_U(@/&,VJZXQ4__C0J)_80TSY]2#NBZI
:S9W,(EaPO?ZZ?_2ES4^7I5Y=6^?O0<f&.S@<=eV&aGe]c,;+R9C(.:JPL]b,9PA
,Ec@f[XTde_-)+B;fL:6(Q2.R,F3QU\NA;41YQNNG9/+-J59I=?B^cAXUIO&]#;O
QD</5:aW9&;H4Z8(@R5D(S?#e9IP43C_Z_Kb?]OOBWfF)e-V<HLJYH_H&(DZQJg,
N.NK7HU(14=Z9acSC;6:FC]]Y)SA#NbU0A[(^>d1dH])T6:eW.1.S3@F/:DgQ]W=
DLBZ]Vf8^Gf3,O]D,K74MRJT;+&?+Ee6SS&A5).TV&gEW\]K^)3e>O&D+U?Y.JNR
4M?[6(/83W^@]>O2d-ZF0U[284EbZ<34F#WB-1C?A51(X?^&5&dE<=2\M:XSR7TY
QCS&1J2M[93La;BU7+-Z4A)O^@&V9eJJ>GY+BA5M=d@&:=GXX2VMaD]\1USJd6)J
bH_V;BA+XBBSI:K3-Z(I^9+31/NDQ[X)bNHg5BT3_26]\2_cYY\A<N;LKC,Vf(PG
d=I5R.7CMaT4f7H?f-^1&L<5:0NTeNG&fH6U?bMN;&F&JJJ69DBbO1UJ)HU&N13_
f)I5:>BWWZ=\E#Ifa]+4=G<75K0Q,H]?<DSWN^.;XV:OC,SddZ=GQ_G&29DMMc8=
WT[SdeJ6\^eD&[K-5LdJe399ZLB[1)+eGWE4_IVfHFVW\W,3M>4AW8^(ESXQQU#S
?J<J4L\3I_cUXEC^)eD28Y]0AXOHSPLe(Z?>=7O)\/cfX5F98C(gcE_N?,3,>#;I
W1E9;8a-(L>Na[?b@^PH726FUMU]/)ae2C&E00VUFad3&UWNg#A?74I1&Cc7#)>D
64NR3=K-8\_a\0MRQ77QcRfD29S)RA5XP1\I)M&],^=KS0T+0T81L[-K.K&R]MS<
>g/OG)JSURJCC)f]96cN=U0JKP&@<ae)-0e?>P5)T6F6c<([+W[EEC1b@A6@/-P:
)<1.@L_#Y_<[B\d+E9P)GJSAH1c1)EJd=+GWVWX(.=ZED2;TE.K&P=Eb_SO40dM3
f+9?fe:X&BWFSGb^NI\,D@W]?.RQT_4=f565X(8-A[5(D=0,a<5BV#>^]F[1HAb@
M(1-7Kd[J:=N>B6GOVRO--).=FM#/fUO:3GUD;7KZLf0YZ;(ROa[Ee:Y:3I6A+\[
gY4+,GFCgP>0J4#IAe,3S9)4,>44]]CcU-f\SPT78e&LFHG_agbSKW,&(HGN4QN2
A.W)QdP7[,\Oa0V\B3\OPY5.=9VB,4(7_W_E5:@ffRKdW>aOV6R\5<NS@FYF8..7
bOCG/2db2_[a:COaeSe0[.MUR[]CGMWB/C<Md8Y[QP[.<#O3c[NXXg.bVDXO^T6J
]Id&42PTSPO7.^#3W#4BfbEAXb:ZCg7eI79I7TPN/]c2BF?&6\^&/U#aRgfAaTPH
KAeRaNA3:_aR]Z8KO<>O;,Me^RV00UDM]>Oe#(6D[-AB7]+_2H[18H\W:8#;JbT#
F+ca?6#<,XSUCP7T&A6MgeJ\C</;5XA2-J>fGM<c=)8TW<.(VZ9RggHB0=+^0eeg
5b3E2)9#Q>O767Wc+<7S)UQ/UK?[NdS#@Rb94fQbHgS>I]NWESKbYLICD:OX0T;J
eeT@TE<OY;#B39Yd^RbLY0AOP09[O(e.BY^fTLSZ>N6XC].Wa,F(MfdF/f.O7e<d
H/\,T>O_-A>.P,-V4fFEY3R/aDE(_8Z+1>(+(,&?II1I0&cH=X_(KSSTTT&]<5O8
V_e&\PI>JGH1)bgRI[Sa+2\CNZ)_C(FQ9##S2HKG/3b@_XGT[e4g]<QT++;-G+c?
8RT#>8(:>XP0a07.\gA:SHA;/,_VT:^D^I25)1DL@PX-9J-//L0dD:dL[Q8\CWT-
]H/W(9M7U)JI^Kb,@@QaZ<AG;\T8PVK6GA#WNASX:d,.=8[1_R8VXQCT](]C=AEH
fXd_4ga+PUOH\ef]]eSZdKXcPb(R7gIA1N\5D4ZB/WPS/c.--&Q&YdC0<D7&D&C,
I=U>R/E0\4/FOHL)&,#LDf&WT04CZd_WUd/M=<R0-=LeOA3&U@:-&B.FeQ6O=6.d
b^7O^D@1.YCAJAbX;I5WEb89M@&K/8NK0aLIB7P#[9SccM(ba]<LD:gD<7V&V+7V
fQ\0bd(@:1/V&D=d=]S_P8I0CLPH0-.eFT3WEbLDD)bG@]#W5RR:&A9b<>O5@H_R
S28M>_JLe3[/TWX_ZU\+e.I3R8L9fCA]cSf-9ONGEJR72\Ia.>B;)L+_dE0Q,B<(
JFO:NaI/@/).H4>\dZ;1&._@R;0f=IRKaO\8/F?/G-OIg/@4W8TWF92QGGV91X\-
+ZFM_@b--0]A)>7Z)[b5)BP1):Z9a<G>V0THX(a8,\a1Z=TL]aV0<>6(WU.U[b1C
KJJ^FeOQ0;;-0YP+MHNRZGO\Y4D_Xbd8N3&gcE[A451MR^[2-NS&4=0;KJU36Y-]
NEWc2IR<>OU#NVZ7>:4K\3(b/>Jd2Rf8M69^+]K/1+#VH[GCTIdD.DNT-+7L;?5-
3C^1@4c9<2C93WVD)=PL[c+-^U6Sf0fH[8O9\2e;4M7HNG,e:?S45@CI527P[S@V
&V=^U&dK)_;NRdL_HU,5^gZ&[+/_McdH((a5S#+@#[6(fV2>-e.6;UZUD7:.WM=L
O/Y@./]F:/3@Ke..c8Z)0#WJ]9P/cN+)J,e8gR42gP?D3gU;+F#CH8&f+8E4B[I9
9S39)_\/>;23LPB<d0d>&K:,,C]H^[0Lc@PZT(DAeDNUUJ(]<:6E-GaJ(,/H(MRe
2F(R-KALH9eUX(/NQ\&HK&c/QW2c5;+4e\JTS\H<E(X/VO[<=AOdTZQ>>)LDG@7E
9&f+?]O[MOP-Rc+G-_JR>dHD8B]Ibd7a<@Q8I2-N)W:#B1<b=caTeV-aIRQU.U=O
8Y5BL6-2X?&BS2F^S<=;(bA1_-&.=JJ>T[Q6NN+9+.G9fWRQM1YMS/#)VBJ>OB]L
&Lc)b/?39?MJM:gGJbb.;4;=4:eH4+/PeaX.JbMG[Q#PaF?V2dVI1=7G_AN&fIA/
7-6ITBC\>5B?7B/a=c3Wg_F5fY;)+C64e@ZKZ@V3d<3GG1RP;^@4dY_\M3eF@+EP
>&7/Q?Ag^gf@SP/JVK#/>@;2BF-LOF0f_9dE:?fAA-J+6[G<cJ;Y.JIXR^1EJ--E
C7#&&XG6/V2>;EG8U<4(TF7/XNJ@49U&A_^<8O^&DNU+LF3g;65/MSD[J6JdA;3P
Ig_\+bXd=PP>)F>+0:Zc]-VA1Z.JWfF4aFdE+]MY3.3PHCB51I#--=T9>B]BN=2K
d?]\Tf9D<Q>S,PF@3O=c[^=(^@;(+]?3K@90da_C\8FXNJZ>96OT;Je?6>J5=[L5
EKQc6WF+527.LJR-;<^2V81Pb;EB)V]Z]K\8;OQa()U]:/7Dc^WP-2C6PIb4Q,+^
A?:0,V2<>^T^D7^)AT1HZ40>/=>F8Hc@E3+YEcHI[I][4SL:G7\NNQF-f8L>CV#R
5OfG,d](?:+YVReg[;I3K(RIA76Ib^-d?]c?=fSLLPHMUHb9aNKG+KLI.U,2PB+V
RCdM6\AO?7b+?\RQ<1A]GfYO-?;#>W:FdP\YP[VDQAPXNQ2f:S/Q6CTB.4W>X)3c
Vc1J3MY8A6A.9+.RM\b/2/1)8&Z56b1ZVDZPN2DVQ;2]4bNWdOS6XaEDN^Seeb8g
J(K?-Nb?4KU49YQ_bXX<_JCe+WcdL8O1U]GEe7^@=#[HcG(VR3O#[2Jb_G]Dc=SQ
EC1a:=S&)NTR/<cNZK=/CGECYHZ>9]WM8daRB828<3_PVUb?Ag&ZaYCaP,bJad7Z
g1>K(gaK[[))9aW2JUS7NXD>89G)/@E4I578O#-U32[:9KI1@,dBY]c=0K2H^aF+
8D17/##B+b/0d2A3N71,QFF.@2D.@_3WJgbYcaO(0[RD0.Maa>O3W_^;T\\VESYN
[6THR#^FOY3B/>F)ZN.&;7DN]K?TGaV1),HU;+cZ?@M-/EGgeV@NbVGU?86/..;H
V5dQ-e6HI-XPa.R,DM3LO##Ye</F&._?0ZcS/;(E1BYL=CF;:VbN&+FA+&KP?3_?
aDa^dN\8#&Y[Y?=;aV#G9V<=3#WJ]dPXQXDC8;#77X;/M:/16#e+JAaK\f4X/)EL
))W_<[/1125G\0G?ad/6:.H,,#9Jb(Va4YF>A#dM_1P(VNcWA^0,>2;\bb0XXJME
1;Kdg6[cP?Y3?TW14+]R[^EP>QEXA9)+GaQcSbH9f(fHaT>a.)IXJMc#6?4SN3TH
fcZ@.QT7c&gKbcE6#<b):,P2=6BT]C)\_NQ??a8)UdAOZJMf\&F[W[BEY+.f5>9F
SEY<=OJaf/@^A<WW?TG81G>B1#U+V3K:1V[,EG.@Uc<U:8#=3GZ]19E+<4/,>QXb
Wff?WaQ3PO>KD99S?SXSPe@#D+(;41G[7XPGS4]WMb^,5AKCRW(=+1[(eXL\aLEZ
0V?B;CW;\)eMK7O.:58L+1(KNAD1ER-+)fUKW?Z=b[]cYHRY<9U7eaF,eO.2C69<
&g#-^cED?,PGBb85ggOMX+-fLG@Qf)f9R,U5=ff]XJ:MZ][H&Y?e-c79V9Q,cM9]
QXbLb++-e6.bECQ63.[TXA5)@ff>7J=+EX7J_27dKe-&f16RfBb#S9bZ/Nc(a_/#
cO/2=e\NRFI7c.X#28J77@7H8AU4/:/S+,a=YLG5VE(:P[@=]MIcCg[<;V7\_cFI
Y&0KTW.O5_[caVX2R?CC3#bYcBM&,@PM:27c:I8\0E)0EY)AaJ4d:0Hc=R:;#\cL
3IW+=G5RBN>_<+C.)KO:2YW,?1=PSC1UM4[@bV7=&f,\<D\:H[5\<I-_aVP><6+_
gTe+e;)<(9I4#D[R4QF--&/eQUV>BR[\GK0dgH^N3/C77M3_;=1&=3[2-/E^&W>3
.A[UFJ1-=YP^B[3>a?#=KJ\28HD4C?3N7NAg-(RBI=g>A@bUf&68?]?OG35_H+#?
MY_1gFXg/#e-O]I>I4C,30?\Pc,G(I:&0C1g7,7FMKIc[RJLb.NFW^P+Q)I(=/OD
&8Ee)QF.ET#VA:f&4/1H.805A(HS47M7IPLX=#BHK)0Z/c21<4-Z28#QSd8ed54\
6b4gDdE-B4+\OU)8E?LWK8TDBf4afP906C+:]B)..)]7>Z[NY=c2015Z9@P=:LU6
b<:I]EebSO]<,IZ-F5?GTSZT0dYcM_cB57/b\[&N9DD8?8E#aPKHHeS,7b9-@ND-
DF:(#U+Z(4VW(>eaW]@513@fN?V#GK=bLV)2a\YG7^M9,4;C56,96gDTP&EAc3NM
KISOX;cV3JAb9;6cG,R3g,gL1S+S?V.eHQRMAX2:1:MC;9/KY)@XOff_Fe6U@E)6
gbJ3MX_MR+R@b&1fLB@+Y[H(8NVD5bY.b>+<],-3EA._fG9g7bF<1R<:Y)#aFU1V
?I+NZCY-^eK,PW]020S)7QW>P,)_)821WL>N],#3_cC_OEYJ;5>3D(/,ecA(H5;O
@f28=WE,7acZ:I&B_^KF1_O7PPQa]+;C(e)VR^]BQ\/X#Y\f0\ZaeKO3N)1cFK]I
4gO-#;+0aeMZ9-/E5(.?RVY4_G4KI_5>/cYg2K(B=R0Z=cV\^-NaeRN@T6,MLf)O
S&=KWJI.ZCEHL+5d56c?2UNVIKAKdf>VPK[[ZV).9T#4^?YIFIT=e8<G\>K;9MCR
8E[g+:O-3H<I\7AE]N/S+HKL?/7&__gO82Z=EG&A;:1/Nc[YMMHG6VH3]++5a;5H
&aW/_+gOZW]YKHELJ/#DL@eY]dO]N<UP-<^QGT[/Q5.72O45+VS9]R7T6&->O7eZ
;_/U=GG>:7>bP5bE)W<HI,Y?9\TPA:WHX=]Y9_MT46G/<<]ca;;6e6EN_H.Scc](
?/[;Q,>6W+5,#g(58NS/^I-VM#,7M?ePNYV(<0eQgBUf0.=X6<T&MFN_TZ\01(7[
>;OHJUdc.PA#d:P7ED4JaaT[gAf89D\ABBJ4c1>KUW<-.L8Bggg7G<W[YYgcFR;R
g==(_C?NGZG\V3aBgR=/+C.XK[QSQKV_IIFL8^.fR_0OE89.A61-P_RVGR(.Nc7+
3UR67R)4PFB0/&UQ39GI6?:0D\SYL9D681ZCN@C7Y&(TV&^@QS0gg:G5f;AE81#S
7BEI6GPNG7,6NbX?JVWgLH34LAOef?O=_be[]K^>(<&5&=QOK^WYSd_eRFd7,eVB
LddXYD]S71WQQdfZJ&.\Ka0NRFQIC4I:A[HUQFMLf^2T(W\Ob1D@>I1&L+2@=H]N
JK5JZ/;\T,GQ96J:9A<^]]9<RAb(\J+U=QJ]AQD]/QVLKeU.WZWb(Z_[LCG8\.ad
KAGBdH-2cg32:.Z5^>;:P.=^.eEZO99-XM?7[fM<bB@GBKWKgWL#c/HID6,G>LMA
]GE>E[)\-LMZW]f5X&II8\^[aI>6X<>fWQZIW_fWM3_CO7ITaWGDJgLgRX.D88dB
P:\UWTR3^.a_#AfS?fMa/6T:5L0Z1B_Y^[^1N=/?_LVbZMU;@99g5Ug]BRc4^\;J
[b\F\3IZ9XO/4]?ggNc2Pf.EK)=KNVA675@7VC\O0,@1VJAZ#>J6e7b<=]6d>LaP
gS&M+I3<JX2)&IRJ[Xa0@7.BN]6NC7/Y.f:WC.D@\.>T#ZK<-)=ddf-OJ@0Uc+FW
):T0O5d5Q)>G>ZQQ(S])7a(S):^bN^:D#,f#)B28E51R5WCBROc0B(.=7QF,YXLK
S[gg&dUH@RBM<+LDcMe.)2Pe2)2WJSg,NRK@_1\=MUK<R6KOLcf5bQM)&XK9L0BJ
:RWQ^DHNJ.?YE;R)9=)HcO@)e[^#/4PMRBQ-3HDR2XJXF<]H;Oc@^5beEFBY3Vb\
2U5R&^8)7>W/^S56UagU/KbBYbIT96CX92\Qe\E>-TZ24A31P<:K?_7d>Lc5bOQ:
_2BZ0ZETNFQZRB.I\F0-Ca9+>K6g.\U(6A\B\5U8SX.)Q#4L.&fGf.aIP5+HDGSO
M9MQM3c.JO88_FTJBQ1]2=Y6aEff>2Z7)]+cZQ_-7d45SQbD1Md\?);@eR@[V6D2
VV@T?Z4#C)4D+.:[5Q,SRPO9=O,3OfG:JU4^D&52W)c5Kb36[?^.B8V[6-a.DYBR
T;K(,K:_cVGO<G;\ZZ(]#Z&=3T5SdeTRf98O?M_X]d0^0L_cU\6ANO7+&?QM;=T8
19W^ZBgDXc?33g(QJ@Qf@?NTKMT#+)&&e_F^>\MZ,P.GB]Ob7SMXYCWgJHSXYP4I
2_Z1<-IJ0KM+@C_Ca8FG@c5Z]]?_]b5O>I,R-.SYg-X/._S[Hcc<1D?6a>CZ=?3V
0<]IVUgXe_=:YQK?@O>B,BB_]f7==]=KB#WMJY8;=&XdABfJeF<66WeXN#10Z_AO
aNUbB,a[LW1+g0AN6LPbBEYB+GGJ?,YNW<5KbSa0?gc-<(BQT_ZCc>1@_/5[AM>d
A5>K,:&C@K6:d)PR;XSO?D:+F&34SE05eG,fO(;B;/I]_//U2#LO&W^V6gH/U?F=
(_KaE?ZK1Af3,,bI75?F:PeL;R_E3NF6;^.?G4?90?eP=V_6aNJ.-HPT8PK><GdB
[XKQ0&1-D@.<&dOcWb3.8f9ARH&3eeB6KcF@HP6]?BG_eD8GSUO07B_eA[S?<&?:
YWRcI.-BS4SO#D&a>dESVJY51L#<<<A?P#Df2b^-,G=9(=g:cgY9-K;3d&U6<aT;
H]a?U]=((=>K;3]Z0-FCdN5+)bA^WPIYX@43;Cgf_=DL?/I=)cEa7eR_>Oe-M>,;
Pg;(NRS)5_NAAV]L@761W8SC_W[M[)-O[3Eb1JW7Y?I-HTa635U=<5]:_c8J0JU4
NE+G+YU6I]0=KC<7\:H8?4G_4fF4aSFEcM\FLQc.M\->04dNRc^d@)5g8+La)74N
@<AM-8.NEO0fF7@Q7G\[_9#5.L33<99cVT=QQFX&<K&7RWW5+/AO=Z#:fNVCT_9>
>#FZWJgP=(eL52V@Fb;AKe6[NC&#Q#RZ.KE+ZWacBH9I)(-[TD_W80)gW,<<?G:.
.5ed@MN2YI;>N=^O\Q>Z2_.[?W>V=<=\3:1D^aW6]M_SIC-)4?U0V=G?gfP^/^f:
_L#9<N=C3BAD\#M[RTHMR@A7eM4dKT;@W;_0#WAG3S_DCT/+@WW378UO21R8+495
L.)g3bb=QKa?0>UV<>6YA0V^(NdO?f>35G)_C9RRd)/J\>b/faNe2;g42fRDdE7&
baGHAQ6Kd7IQUg#63G[EdWN]O+<;&(dH;7:L\,5(C)FQ0[#17?g[@b1>R6IKOeXQ
DeQ#UZ7TR03CV50ec9=5-]X)(,ffGaaD&T=9:Pc5;,<4-]I4cbS)a\5]>V2IUW;6
REF\2)0#VG:8SIMY#OY_g>eSbWKf(#.DY]BX_EIXGJND20AHB@(9Q)cbgE>.YMC.
.KX(c<DWc>Y@R^VWfU9+9Y23(^R?]:X-36I,dMd&8,4)ePIL0QPLX4d[.,DIDd<[
A:>/\4,D@1K-Q\(#cHMb,>fB3OgUZ;FBT05Y7+a3V<M>H:KWY6A5S34K6I232Z:,
<KBKAI)W4^GW4O3^J_+.])4Ke@(1CKD7FIGY:9@)&Kf<XH&1^\f,A<M-]G<U7\(D
O<KQ1#K,I/>54,;8IKBH3T&GRR6F&O@8TC??=:9VOg5B<P)80Z</Yb)3;bd<LE=:
//VMIJ;BSIYGS?#NEeTe]-H;OKb/FU-1JS/PTE?5ZCVcG?Q=/QV=E.N3Y6\aEd&D
Zc3608?Y.(IR3H]9d8a_,=,Ob\5NW?L[UZ@1<dUNL&@<R1S=2f:@(-bD]UIZ),=U
)0)cC6L8GJc+9-Q?6NJ6R5c0G@^W/5.6.214F,>D3@cGB&;Y[g,1FXJ]cM_9dfB+
[<eJM+A7>-]=QQfI<>a-_ZJ.-\Qe-(\IIaJ;+aL,<SJ<(EDH?FDGGTZ#.)YMF]BP
A9aU&-cEVgD-5_J9#Xd?1M]-UT5.\8Q]N;PA?#IXR+1N25O,LYA+-.1X_^=1]:A(
Se<0>&<.YDT>5M1eZ_,X^5-Icg^./<O67Db0@,1MS(5HOEQJ48EZFO[2c&RIgSUV
c-?7,H7WM+L;ZTUG=K4QKKQJGOKDg552A>Da^:Lb1f=\0;>KVe4D^8;3F1K8d[3Y
E>(L#JX3]#9F\TE+)UG7T2IDML6:IJbVQCW^ERP:+1)D-Wc?X\WR20&/#/[d=1Q5
5V6&0K?BWHDb2&4Z=T2]D\,/5PLK2e<#QVR,bN-C/.fR@-?5&7K\#a\Oce<bGe.W
dVOW@1WHLXML6+]YVBfWI)^M];7]=WML612EW56D<I>4F:1,&&SOU_Z_V78P8QWd
b3<Pf,?fO4/+V^@FcY[#]GR3fM:890ZATV.U_ILR:,BQT^,(QGHKIe^>_M0A35Q=
W6:X.OLJJ^\<[b8H1fD9cM,U45CHU]YEc+1<e?1b,FBW94TWP^/M^U^+6W.J[@Zb
E?GAPZWA5KA[2Dd.Ad5TeU2eX0g=2GdZ#WQC[59U,K(S5Q3O)4&?0AXa9f=@XFP@
+M?ePEIA<eQ@)F4D]#&[cA317Z1IF<YLC@L/g1[<H?5LHI+.-#7+;)?\R6^\?cU.
;O>,I0AVJ-9.YO_3@K=R</b-8V:+<[/+ZgS&&@9N?Y(H,W;LSB+>f9+dC.-4a)64
_44X@QT0>eO[\&gF9>9Y8TH9SHFEZQHSB[TFROC,Mc81U[RRDEX,N?&QW.cG26eY
Q]J_ZX_#0@eLH3R62UT,PK8>/4US2@#HD:_ECNcI#M=EeB5:d=eUK/>RXGG0_3-\
&f-XN8P=Q?YaN[]gG6\b<+WQ9Wf9^Lb,^U6V6;_,Jb,I.ZBXVO,;+BCC.f>#QC>6
L)]3(ZB=1W>c;/]:?[,aUXGdME^9W?V@3f)c3;M^N#D6?1MR64.2be9X>&?3@U=H
J?d?J\:94P&61PNTZcd<+.=L(QL/GR>QZ5#\G+a.IX@c]MJZU+5:O@PVdILDM6Ma
]-=[4Jg0)S[dC+)F@87=S7)?K^6[H^RRRUUB<Ga4LNL<Q?D^T>R-7&K]Q>19V?c3
H=c.<e:,587,Ag\VCKT02M1=@FNCVY&H>H7RNd:IPKg,>YY+<.,eY:@fQZ^YF_EI
[MA+0Sf(=+M\eRL6L/BN&E1F=S2Ke0PC]MNOJfB1aK+)8DTDO&7/L,2g[MGR\]ZQ
K80AFFF/Sd1#4/I4Y&4K&WdU(2Q9;3XbCSB+g7/UD\d<IeP5#5;87IgM\c&0P1WP
-eII[WS>U1^H)HK7G0f0L>YcAQe@f4dL6;b7g86f\bc08_e_#NT;eYA>PU8Oa;O\
L>]G&bUdgN9f12E>#6gdGX1E@UEFA/LS7WL7COIgD0#;PYI]ILGSD/EV2S>XPg\d
@&7Mc2-]5_JNC(bQ30U(\6N1[;\AX<cTT50N<LQ[K)aN3R2,>bCfTIY@],I0T<O?
0X?L^YX);a:<_C+Wag[(Sd\EL8TPeH=AEEf/HX8f,.dQZP079\F1<\U6&\a8W)</
5Y6KN5?^QY[D32AIA)NJ=SEY0^U=P_2(agT9<:2eS:67RT@#<HF+Pg?\\M9WW3&<
E7_g0ac)eWAc8[19bOe9AeRc8aaSgRR#TDGfKJM_0a:3@_2/CH90C;]J>54R7(\0
1E#ZaKAV>^A/X4;2B8Z8+7#I,01gXHTO).?6d&JD2<-cb^C]Zc-KaEP=QZE[8X,5
S2#_<7:Y9(]>cY8e\XQUeMBX=BMgO7Nd5(_4M1+4[W@8XP6_8EP:g):32W4<W&eP
44?5[73?+OTKf;D->X@9[9K7W&f[8RSTP1[;X83UeaLa<_,+[X+2a7L__#:#KJXH
IfC_bL2<(Ia[0Y[6Z;8Q;bdG;L>4^.F7[9]=AF8MLc,7ENMg8#>Z?DNYWS+_U7V3
OZ5I.HKMVVEQ#,WY(LUf0I_6Y?D8)9J\7^@S&SeZNe4XV05G_g<M0fX6.NH.&SKW
X)TKbY-g^#J:Z/YQA.AB/eIL#EKYcTX_@H.R7QFWCbbRdc7B:MK\ad=aY2-+C6gV
:J_K??1=,8<MD(X5G4M>\FE0^3RJ[/\aT+B0fDJ.Ff)f0&MD(\c^ZYBMR.R\Z[F5
,9,g23TcfeB4EJD<NUV1f>GA,Ld-WSO#.TH2c=B39I5g^)\ceF+)W^9bM20<?&Kf
FCE]7S=_d6(3(]8]-K8BM#.((\/A2FWG:ReL?&=H^_#X#J(K976(7fZ:YQF#\\Y&
6GS2)+Ea?>ZAN_a^UG2Y&]cLYeT5O:=NXHVQ>J\XO\_ZI=6B,;IRFf]EL#ON[O3O
21^.#OJfO]IIa1MEL58F8?gCd&LV@[Sc66L25Z]0K@?QMI:5++>[:PeY@R&9V&^E
aMW/?cFC?AC-/NID@)R#E&egg:BWcbS3HUH0DA2D38(\:5XG]cE^1K#YYEb#4E84
7X&6A1(62FFL^T7=93cK1K&e<UO-2DL=X8)61e0:6XdCa:0)fA\,>Y6O+Dg]fYB?
F4\\AN8CP1E(U:M0A]+THEW0V(2ea1X_TbSfgE4dH33cL\S]S6K6;UPWGcAfRaN?
H]&Q.>f4)KS-+>]HSe;/&dA[:Tc9MG/?RR:O3F#d9N-OG6BBN/-G@,X6^[TZgf=f
-=3_A[[T0.&BP2(6c2[SMbI-(<4O==?WU3E02L.+OIK_T;DV?;/#&6\fEB[N:5/6
f66T-:.)YXOG@E)bC4GX]:IIZ\)bZdJZ:3-b7Qc,3<Gf)Y)Z+Rc#ET4Y0^)g&_G@
E0CWK)6-6K5SZO>G<8/gAY7O::<^c=[)D>FQ\6MA:-02>e[1,8@^74EH-A/MSL<Y
DPW\,bM9=SMJ=^MV5gdc:-2Nd<E>R0dbd&C&WKF)dPZ#e^<J5)=8<>0GeLBMX92@
R_C:,deS-C:RF8C40[_[)e<][W:G7V#D)5Q?e&U7c-85NT2N[<8Cc7g;TYS,AW^g
#;K,W/bbW=H:_8&E40Y)3[1_;V6+4<3:g:RKEPM/cJRLD?+]WF3RJ5gK@;(\4^<7
TI33N+-\T9[G2ZS-f1@,#L@/PNZR9:X9,U+VeWgDG#,cXG0,eWL3Z:E0fA8aNd(e
+/JcC#(@\Q7LP[Bb&8D>W1O&6PL>b[;F:X^ALFH>;,QV<8SP.IDAJF;]@7Gab<H#
BGG-H<cV5@RGVEE/)AA[U4+4VHRUFJYd>3^QAe0cGabV(\/@5cYHQ(=fV<X[->d+
1HZ:V8+(+IH=f(Ge7_V=TC95D[A(0Nd1NC5:3Ocf1+Hf>A(eSLg-]1OMg(0S_ZXb
bRRVJ,aI2G/W^VESF^Q(-CWfgF5/>U]4S4NV=Y7<KJW@R?LP[OV-O.RQf@:1:&_[
:g#HE+SGEN..HI#X<O+:/2bZM]7,,Df0_0Q.SW52KL&c7fFY.N[c^+4]FT=2@ZQ7
&]5]e/L.0DJHL]O<Ta48S91fE3<4g1Z#_7=bAg0bX,[4KERY(8708<W2:;4GNbSO
3;c^/PGG:09&dYA<.0R-ID:FUV-I_V(/:KJE[LT]QDWN1B8)UX8T>NT@eF@HFC[d
,6Sf_DI:B(b0Jb44]G4e@I<d8I?60eb5g5QbCa7e?0/D[+DZa@.N92cKdCf<b05P
+-4Wb#9YDBLT#RL=(Of+E7P-XJ0^bVfNN?KLR7Q)d+RCA2VZWFfFG?T838XF&BL3
VLa:6A0M65Ia1>2ZQZN+Vc<M?cF=&&__QF8=6@C@NS0[HD>E]7Z97P&(U\3c]TF;
SOK]I91Fc1gg?K+MB(20DAd,\4O-[F;;?T30V;]UK+;ge/=\&+8\4?JC->1PZR5Z
EU+gLK8J2:5@S>UK(:\XF.U_JB>[;HA45Bf.9_EA0@TA/CBWFWafSOSYK/F.0Jf9
+CP=VWS=9?=W1DS#7Q&C0:(OD(S3#ARRTJ<2@AW>D\4F1GV;HY?FYAbD)-=?-N93
VC#;a:dP#f3aL@f722^-8HSN5ZP#GR<45+>Z^Y<)FIAW@GWFbC^0#:Id\;?bW[d&
A^>/?CS6#X58_@>4N0#d7?XS(X(3,;DcI@A^KgC\>2];_?8Va/YAH+[PREFW#Oeg
HaO<RNf=-8?2#LCO2KZ_;^I+22Aa)ZB[0XHf,S89TMK;f8fX:bbA8RM>N=8:_ZdZ
R]e;M9N2;(eF>R+A@3G9a?5NeWP^6Fce=)@Gf&P?IK9RdSO2Y<b\G#TKH:#V,D65
IEg63DF]^Y?JC_)6D:7>#8fRc&=LF7TXd4>(QI/dU[[ZUB=3ZF=&3\C8:dWO(e]L
I^[XUBL3Hd3aL+c@QOCI9dF=Hb7>cH:?3f]-L<H,>-0,ESW=XV#(SX^L2SE&9>>2
3((U:RG4g64+Q\;3]DfA4TOSV,VGd0,eG.#7EBFQGOI5=A=EKb580XMHW;<>aO4X
@7?R[Je>5W]1/Y]cTe36c7,2027IVY=;+@61UVA>@K<D07C.bKYcU)VcI&7FM178
8ZRDeC53UD+@WL(BbMO)V<2dP;#6Y]EUMB1,e+HXC/[a^O8eH;Ca5?)^_d@I8[Yb
6ba.7IUV]P\?F\^N:8Bf@T>bA2aVP563d8Z\&8V6C7/[IDMFFRT#/_RH9C&;L:Y8
1KA\0dBW8#;/:ZMLV?--H4D0?M[.JXCR:S:WBKF;JE5H?Rb4]SWcYI6:30ATZ&dU
d(<^X[WB2g<^QBD:8f]81OPd#[C25&gIXIZ.Y6>7;.0@XQ9e\&UA8<f<<)AB7Tec
cGWIE)_Dg_9@cEB@9Le+&=@@AXWfTXbGAb_c-9)_LDP\#fJb\,c^]992IJD>:0/-
MeHODa2CRLMI(2?CS@YUM0U#eH]JD\QXB[((7DZb(UM4V2cJ\-I4NNRO5@3BIZ,b
]QEB-47T+<+FQ5WV^&?:;+]]4_9B=:K)_=4BXS)\M_R?LT<R?0ZV+eAgF[?+<9cg
WFaIT,<.Ng.cN?ENPWN(?C=I@>2?A67FHX6D,SeS]MdQ.>@^?G-E+6AgL$
`endprotected


`endif // GUARD_SVT_SPI_AGENT_CONFIGURATION_SV

