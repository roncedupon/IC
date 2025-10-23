
`ifndef GUARD_SVT_SPI_NOR_FLASH_DATA_CACHE_REGISTER_SV
`define GUARD_SVT_SPI_NOR_FLASH_DATA_CACHE_REGISTER_SV 

`include "svt_spi_defines.svi"

// =============================================================================
/**
 *  This is SPI NOR Flash Data Cache class. This holds Cache and Data
 *  registers of NOR Slave device.This is instantiated inside shared_status
 *  object for Selected NOR Flash device. 
 */
class svt_spi_nor_flash_data_cache_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** 
   * SPI NOR Flash Data Register
   * This buffer holds the Data read from Memory Core
   * ECC operation is calculated on this data, corrected and then pass on to
   * #nor_cache_register (Cache Register)
   */ 
  svt_spi_types::word nor_data_register;

  /** SPI NOR Flash cache Register*/
  svt_spi_types::word nor_cache_register;
  
  /** Valid bit for corresponding byte location in #nor_cache_register. */
  bit valid_nor_cache_register [];

  /** SPI NOR FLASH cache Register address. */
  bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] nor_cache_page_address;

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
  `svt_vmm_data_new(svt_spi_nor_flash_data_cache_register)
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
  extern function new(string name = "svt_spi_nor_flash_data_cache_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_nor_flash_data_cache_register)
  `svt_data_member_end(svt_spi_nor_flash_data_cache_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_nor_flash_data_cache_register.
   */
  extern virtual function vmm_data do_allocate();
`endif

  //----------------------------------------------------------------------------
  /**
   * Method to make sure that all of the notifications have been configured properly
   */
  extern function bit check_configure();

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
  `vmm_typename(svt_spi_nor_flash_data_cache_register)
  `vmm_class_factory(svt_spi_nor_flash_data_cache_register)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
_Z:#^YBdf7V]P,(P&+4DHQH32TPBS(GS^<bda6B\.^J1?9X#<=.W0)d.(_f:D:OY
JV-e(cZ>Q@_J=S&(\<bIE,UH^eaH(>UMf\b+P9&YE;[P,XbXPa<M[c3OZ\P[)Y(P
9&Z;?(aKKVFT^&,VKYI+-HX(>7bF,X>S-]4UfVc3Z1D2<5FOB5P?FBAcM9Jd8P7.
(.1ANHG=LNO3CXE57SW3L[c:AKY@6(NNC:K/5HOb/cJ>]-H+?Z.gH-GCS0d84:TO
+/-/-F=/e9EF?X\DO(R(2\Vf5SH797J-g?P,5(Ag.?\Z#bH:#c&4ITA^G>WfJPYI
?8FGX2^SH\8&SgIP(;2QCc>\]c2[<b@a(f[AH5DL7^13<3?K+XbA7(N0Y4.c9LR/
>3)OD>-AMP7N<@FQOD/?^<bB]YHZK^A\R^(?54NHY\P5]/3)+e+=eP,D@CH/=TG8
XA1501.8Q6;1]UdId)d:9DXU,\,MX5.Nc?A^91K,S9A]>a/^TF7^Pb3J60BLH665
67-ZMe.d?eEeP=1Lc6@1I:2^97791,2_PO6SOD=LX^63,eTV77dF)KDT_F?]#D+X
eJNHd+c/NC>eL:,KPG9dU()=)WFT_0_e:R?)ZgN+)8g(N/<KK_\T;L72UQ5T2_05
:A)=KG4?AALX+HO:dO7NefZ;0>gGW.AA75MPAOHD7&N&e)5]N?X.+=WHR_RS@O3X
(0:_5/eDY^.X+$
`endprotected

   
//vcs_vip_protect
`protected
/#^cbHTeW,HXPE]3V8R)96d_P?>X+ENSTJDQ([W8_KSGIAGcOH[>7(d8RU5bMVB^
KG7QeKG<QGC,PH.4=]S3GIAYHC+,FE^;7FHHJZFT)7fQ=?EQU=B7=A]K8MI:Zg_L
[QR(K]K[2A_I1c7\KQf9@2LYE[2&;E.\Q_H0Vc<a?G8CL?NVbfc[Ag^I^OP^F#4C
6+&CADNI.^1/(VCg0WP&fcf\9[18+DDV+c9AT4]:E3Q]>QNA[A<1G\-cR=D^QIC9
;B55/]AI[d+=RB@C5bK<&g?<(6EQK,:&.<cVJ-3<?WA6&HW>M=4&._&fcBL2S.CZ
A<,gPZL(2;E4=3PY9PTYJ;[+&.6<@1aYMeI.;Y]W,bYR+aZ4EY)3J]b&^N8<_?U2
#<KG]2_H?1+#=J)WB_]cc6;,Q^JOL&F>CB.2ZD8YQMJV9HA)9,Pa1(8RZKF2#\<K
10MFIMI&?6gMHY6^6&@>d-,,]DS0(2JMb:=;NAL+L58(Z?Qe2-8&@>^JTaU\2]7C
<S08>+33=[V5ML->W=<QHI?1HI+;8M7>\_)B03c^_^WC@f:+5VH)I>FZ/SAW53\I
.YC7D;2<&824AM4bZ)FI(<<PSPJWT2]<0&#UUTZDV:]HUb&(56_M14_KIO5O;E7>
H1\AT95O..aW3?>2]5E(gLNE&3_I1PLCf?5de?>1<V8VP3PJ6((::GIc0/U:I@=E
IO()I6S9F\W6[dY^6Kg)=Lf2FaCPe.7+[-CEYUdLKeS]Wa018G/R1_=D5eQ(BU[R
ZA53(V=IF6ZG@If10_(ScQ9P2J^=#ea)=J-D6P^aVJ(6,1aUHT^[]1gSP+a\E]@T
6<;CSLcIFV60C[d0A45;IZ06)>.=U+d8Hb6;,9R/F/0)QDIEKE2)dI3cWR02X7^,
]^cDGcLEMLI)QS#:+5YQ91aXZD>f_MN9]e8AM?e\7[C)6J:E65:0#W+[eYaeW)4^
PCIV(;eZ1/SF;^9YVfCUU.7?g;O<1(R/097<29X-5B;V8]DM(<JSTSJU)/>d)WY[
U4,DdDe0-\5I6Y6PUAdP?KV0=gRXJ&I\Cb;=1>Q,YF[g^DA7cA4,89Q?F7@G.2-2
U]AI61]GC[DPW,-N>U^2;^Z3MC(#f--Z/:XcbA^g:N0E[HC=dF)fW0#I;Pc<&)>(
@HAY_.Z9@F;&Ca<Ug2KY@A6^3UCadYKaTdgDV3\0:BE_AcA<[KD.1HfO@CL<BU2,
.8f?A<U<bDLd7eH^^82cGAWR;++SX7Kf#9ZOI;CD0>g/]5BS5DD-]ZQcC/X3L&(6
;3HS9dD).g2LYYS6#W_a@V[7MM1Z=GYWWLU(U#b/_FT-eLKa4P1Q1-Q-I2@\aM?1
BNf+39f:G8WIe1IW^JTcN\KgCddQ,M^6I\)DOJ\J5TX_?YbaWbP<J7Q9\/Sb557=
],N6bGR.#B?H.-[e]A5Nc)20BI].-Cg&>8G[VNP#=MNON(>29=&_PDQ2a-W^B5?Z
T80^cdW87YU]2@T0?2=&^LR(>I#^fI,9f@:.3Y/4XJE<3]6997:IQ5.7C6KGXcE1
ZZLVS]Q[7L4@/bE.+3aM7136@K@@)<X/-_A5_F9cFLE<M)&\Q173_F&a@fgM7GV0
/b+Pe(R3K9LI0T852W7.Td_M^TaOEM>FaN=X6U)TSRP6PX03O,&<bBS)^I8CS[VT
QAg5E>Q3.ZSQI)=>_ER5@D^ML4f8))Ra,-/WABOHG]GdL0<V;\6LTL2.b5WFB/_T
ccdfQ&J^T&?.bc)J,@\TU_O&Z0dXNMG]EdXEM/8K_SUN[<)H-0]?Z?#QY5_1]YOA
+&c_f)OfEeKZGW)[X&8&:P?d1QVM&/9VWdH8BJFCHWAd.\P^KV.Q7^9f2^/Fg3+b
deK/R?Y/XIPfa+0X8^99cW9D-D+\.86VW;BR2(UbKS.P\6+(f=UbICG3,Kd:H2[5
LcD2U\:-P1K/F)Lg(_9Qg^AW(d#Df](cYX(MKNW^)#6ZffJSL]UB/HcFQN?]\A,S
3aS-)3@b#d[VO0X7BH#N=4)9>LJ)+G1gd#5U]VG.\=,L[5.B4GDGN8a0D3=:2/?X
6,_:GNR;5>Z((HXVaPL+FO#E5EO;Q^QNH]8>_,1CQM&]+]>HR7dVXb[FXaK;^e[P
eZ;e:C_gA:VO07gc@^U565e#cQ8EV#X>L[9[0_gG8I^GcA2EU)fA@@H&dQa#M7H^
JO>_GM=V:PT4CFOJWg1P^9J5CE\_;E>7MQV#&]MXC.LF8SaZ526c2IK)Y,=@-I]d
?U#6Sa3&Nd?a17ENBYMOEM6.?4^>Kf)PN-LV-ZT4QS(d6@UNGC@S4g&#6:g/_T3F
^fLQL9WcWgC2b0<NM8@\7F(DFe9C#,^?R=\R)\4=fJ-C<,UdBAMGL@=f4EfQFVdZ
P_b@b/2/[<B(=1T2fMVCQd<FO0KD+T2O.ff+8;^NR-7Z91OV:<,_4/;<19GGUC[X
==W:3S=Ef;]3f[O)MK7c4)+bac14?cK#VefG\C]H)-.X3a@6\5c3gO#f)CgQ:Z+_
XM_+@eZ:^c:)/2T;fDY5aX1fS2HR;cG;6c&JY#^ISE#:Tdb99N>cRWQ.:(VFZJC3
8fEbdJQXFCMI(Sg9K@TRX;H1&W?//5_J--8@\>S(CdPf10T2>CfMCBZ/5BQJHP+\
=1MC5[f;9;KZR5?QMLW-aVP3I9F&c&b/WI-]/T?8-20+Ef?Ud<dO<a\[Kc?^VK3^
_>D+)#gMH00@J;7Qde5/8P;?1]?W93bJ_L@YO-YR.8U-X8W^X[VFeGUH0?Z=MO@A
8eV]L-7bW[/@;SD#bb2aJfLSXK:G[EbHGW:)f@LJ,E4P6HAPb0FLA40;6I+/Tc9W
1e)U</_W1?0\eC<9QL2F9;+R,.P3Ec=FFeHe@P;NIL+1,ZU7MEY1;:.</]A)EeO;
QRaZW;^:#Q9WU<Ed@K[Ae_(a+d3Ja0^8M,eAI_<e)a3AZ&3MN+@CW^Q?1ECHKNJA
G)2>/#6>g:KdFO#HU,2Z/Zc&14[^I6N(V-:NS<<>T?..+Jb]E/FYS.Ra3QQU,/PT
=\0EF.<T+A)+V:XY\Z9:P-1RJS;Y63G74cHY/Q=,V5X63A<Pa_N6<@_.;:d<9KTX
OC;;d[Ff^/0DfH4]<R<+7@,8)C[[2Z+Zd\H_VWL7E?FRMd5V4PMV:X_KTXN(O/60
MafJD)7S[,4Ie9Q[1KP-N);TWd,cC..1X+84=Z@dOO+6-V_;DNXbT7aRKe\+]65.
:G#(-OJ].3aEd3N,RHD_MVdUO9F0eGUMG1:3^30=PeG7N_d(_Z+6(I[cU=K-7(^1
-5aJ]GMC.dIM6cU5Wgd])B\@PD_4G_OMcOQ)McEcS?@BW\MSV.V<.XQT^4b6fN7[
H[IM(U(>O7?U^@&B]@7/g2614EKVL4eRE,OZ6_37b0Lc=[Id<c)A#eW42eW_\a[:
b-TN^8>QB&7:#fVgK^;Hg;)XK]]_6/RHF^_4V6MQB;54;R=OW8:8b#Kb07&@X&,)
\E0#M.QG9gXCa3HCcM[e8NG<.9]c60c(Cd+_E65D;ZbOZ6FTa#7.aQ0D^?5@,+#E
eE/&fWH>A\RYD7VOWV],EE:(.;;B@/0SYD5/5)3I#YK6:/F2aZcXgP?,GXKX9GU#
XTX=E;0G)Mf?VNa66?7V^?K1)VY13_K2;O^5:-(BgYdI3YT[<bX[YG]9c=UM^#W;
OT?DTLY<d+,&W,;H:0(PF5DO#aOI5fEXOYG@&4+\V^T_S?Ee3Qb.\W\M2DLU3-dM
fK0/,D>P][+/@]:^a#FdD\<b/T0EQE?_ND+Hg7:13HCNg^_()9b^67HPe0XTRK&9
;M=Sge]R;0&A@,?<TA41aI&+I9NS4XP-3=9SW@]AETIZ(<,=]E\fW+F_1V,[ZV1_
38Q]D5KUM(P)#^S&bf^?d<-V:F0?ZINL#ceFO+&9O:2e5]9aDK2SW@^V^A?K9KO/
:TI()H^34=6eUabR\4:CQ?-9dP:H7QDUO.@=bJ]>R_V3.b&/U9g0-&>/PK9<RMVG
gefgP,II1GGU/H]>?2#CM>GXM;^P0G/,/[22?&/W\:YB4>?P[FNTC55X=J.QR-[+
PLB)M=B:;e2a@;8?CST:W1?^e=,Z_:=\KSL7L+DY^??JBZ<V0]ePVQJ26-]<\<J8
)dCHBGDT7O7QcbWJAU<He@V)C8Va.(D4>1&_HVb(FODP#32^;1_Eg#8eO(b18]3A
](cFCAKQQY(/.M/36eKN1V#EA_JSM5N.Wb.5W6<Q6^^dVU@3eEZOH5SHK3B>B8M@
0RLT+C]^,1YVggV=e<QR,9NF[X&@gYCRe6?0@[KLRNLGLR4#bIeR;,09S7V^5.>V
T11[JV&YCEFV0=c@SE1V]16FIA:2WJ_OBH;<]>(C3QJRI]L&d;^.FXBUa0)>K+9A
2OF-_;,I&W?-IJPS^QW#/A>S[B[(D)[dS@N^Zc?dDX_?.c)ba5A7DK[83YMD,D9S
?93VUQHPR^+&99A+<HX9[de[2bJO-Va+]6;)<bPdTENa^R>?JE>;dK=M;,#YCRZL
T=2\^BO^)81&FOd-R4O5UQ@G.&.UU\FK=7IY_e7E)-37fbbNe^8L\J37cKA;>c[Z
]RC;?:.?\ZO>THOT:ffKXV5QW(_D?g,VS?/GORZG/YK]\\,+[YaDXMTMVLI6X9MN
&aR[+YGQ<NY9=<8_a)K2;Md63:V8YTNDF2(e[1f&^LS0Y9+Z-FC/T^7:UKPEH;.G
Gb[KTR0/M1f.R^bB+8_T,dZ&X&MMD)6^\)aZeO^^(gC?80)4WM;b1QgK+S4gQ06R
Y6fdJ?.6Q_XT+VRM#deaN,ES&=fUJMP0VFCDd-e?dKV=)X:=gMI+FG3e&#RbKOd\
L67@K[P_83?1[]Z[\bMa;Pc]97gN,=R4(\X4^VAW;6O^8aHHVYT>f,C-T8Yd7c]3
-[)6M<@=E9]EVVH16]+(Ke0Z&X_PYM?>#[)8SU>:ZH9\I\UdDT0_9>E7=B>RKX(]
]HYNJG@FeDdO4VLU&I5,JM_+Y;d_]-+K)L55agN<SV,A15DR?+=B5^S8CY4R;4S-
YO,H98CN;,#gQ[(&g^P::gcZG?^,Jg5.R;17MQV(SR+@S-F=>bb3FW73L[a)M,]L
7<_9?BR[0,;?C80C@[>PR8;BG&cNTCA[(0S]HLCL[E@17SEf\[]IQC)[8d2&RG5)
NESfH9U<ZO2Z,P^&T.M>B6&a;NU-5H.9(_]O2;HJ41P[>J#?.Y7MN#5f,g#c[cDC
/V\LC9-YPC<SS_1<KG(V^<S#3UTKXDR#(HZZ8P&W2YQ6#E&&U83T/.g3[=EV&Z5Q
DgAdSY0WKV.1fBJa5_FL0\I,CKQ=0,(B2<-a3YYA+N>SHHXY/QPbKAKL&Abb+?5O
#E-URf0Z:/Z54M>C]2a1[L3g@RV7GVF2gbg[_A2b]\K_5/\,5=]/?IX)[Z+0V\Sa
=7F_WbA4^Q:>UM[MZE<8#(B^ZUV^I:g5=X@=&(97A/;LX.VGUP[gGOBZ3,-HS_FJ
KDbGI,RcN[31Fg[UeH,J#-01&,b60dCH:<SDa;AW(:C&R3;bFLCFW0D#K\<S-TMH
9=6@VfG]B@HF@W?gWKCEQHH-#\:K7Y>V5gT3G29/^GJZdc3\LDdTaM_P?U4K#bP:
A;Z[IQUZS?&WHA-TPXXO47\>2.B,+LP(3.615d&06MM#gUFRGNIc8&#aNGDgAIgH
.PfARK)@TJaQCP0^b=_)/OM<GP-e8>:M<W8f1+?.V=7=J<]WW:-AWg0\GN([RGD2
-5)&8d,L0#B.LfOe&eP6@Lf955U[_BT-KVFg.U3&C-5WTg+aH&<->@-L@c3:N8]:
a0#4bKE9G?JF[gXBZWc2fAZMT&&cEB7ONG+O,YOW5&4gQ+QG,)2/0e>1b,1C19J<
510LQN(17:W>EMBd.(bbf#g-LA1_a93g@8Z6)X1BbYGOHQ[UQ-X(99(-&Z00MI:I
HM8d#2,W6Q_8F8PN)W&FQ27+)B;)NVU:AL79\EXG3\[2T;,E#IS]_Z5(L2>7IS;f
Hb2QYU(dGAfLKJJf5B88/#0_-BG^:+:X)N\E/cV)9)U7LROU:gWgQ1gC(\PEa-=+
PBR9GL8A7QY;fW8?R<6\D[@>V5M[?\2&4>F4ML2E=Ze&]J47MR[#:FC(dRA_ZTG]
4>We?7Y;8Q8BB:EN(PU?,_/7&W79(35NYQ/+TD:-Xb-^ec2>@<K6bKe34CP9]/<I
WTCC5=[YBd+4&BWE]eH@fAFAGac9QR#?@cd6J97_^=4e9/F.QU9J;W]VOagXL?-.
)8.[^4RELM0QZ;2UBfc3[:VHB(.Af(&PYbJZ:NKfgK2+^FJI4V[0X3d,dR-[;5Za
M4+@L0Q)NZ>5cXf6a7f],1X]LHYgN(UOM5a:@\(+O8@a6Q26>L<1:S5X[A7,?ddP
,)RBHQd,M\U)PN1e(AGNQ15;URg6>IK9JVFJ3QDeCH2TGS9DI=;/:\_=eM2\R:JN
^6GG<\B.D:BTPV?E2\8Pc2g<_@@bJAM),U;Wb:R#W]2/?^7^:RCY,49e(c3T@aW8
17JS/]@d\P6e\e6M\AfD@^M&1N&_)67G<(b>071NJ6(a#WTTK_5-0NXfdAEXL1@c
\d.G[LA:CF[+[T/I^V?=HX\DEF2W9fNV80)8C?5@d?JJ__<gb=J+:7BZ\J[ffX-?
W@cSJb6WX/&.(+L22)<>EO^3D_&72/+B+G<X,FbTA^\c/NI)-e]EX)f:g4WTZ-R/
E1:aQN1(ZQ:3gCJ1J[PK\MJ-\Ea.QIX/LE(<0&L)L1L27ZY=f,,>5b4@3c4D?.Mf
]c(>EX=(Me/3T,LUD@:c[c0HMU:5HP9=bK[--,[1=DN\0-eP6gGL<:3JbEI5b^#3
PceU#UT=SE8LF9FCg9U((VU/NOCD#77M)5:5#9[AD;gb3H&>]feGBB:bY&NTDUg+
#G(d5Fg\736LWe8ARc[=9Mf1\SX4LJ:5e,H2;U>MVAR/33DDc/]M2EV_)C.PLb]a
:F2XZ,[Mf1ICTP=C5V@1<;SM.J43_e6=MJQZ>>cZ1</:>O,JD_(:I>:6CP4#N2ZS
<5KT&RYLW0A0B491Y);)MSX?8<5S4[CTI\8f@35JW--V1D/\aEfJFe)23&2Da,UW
T5,5-#W2\8=5fX_N_39^?UL-O>\]3HY;Bc(=@8SN@bGc>IQS;:>b<=<f5?@Y8/S,
a-3c,=?8>DKL@Z&HX(1?a:]I5/YB5X9V<237-#IcK-AA<;5B7f;Z;4U=_/e+OO:S
^SK(FJE;Z.gUMN#a6]9Wa:a3_B-18@:OMIE37Z=./LPg;I:#Sd:)?G.De@a\4OVJ
,1.W\Oc8+;0A_a.EH_;O/W<U(a=R]0b;[\Jb(dA\#5QJ#4O)ZXGAJ8J.(9;8GHZ7
&?.W+g@1S3>O<\K8d>YL3J1XQB03<QPF6P=MadF^(93YPA9SCJW5@BBbaS3Y.g=/
YXMRI8#J+>)e8PU6O1U<TJ,E<Lg\K8a92JBbPfG5[CEE?0<05C3G7PW4I<_/.I;U
^\^;1eCN#DT:?J&>#0F^MV8,Y1G6Q5dC8ILg&UI#S#1)e=b7,Veb8WLP;BTIQc<3
<SC,BIbB?b_)[6/XIIaP2O[TdGc,TM@X]B4=>dD>@?G:XG1gOM-G2A41&_bPUYN(
&S1M:]7.Rg#C+SKgf>+K7;4,MV4J8_C+4aJ+fP^Y[A+eS;VLRJVPHXOG,(1DP+TR
LVC18R7=Q2>\e,,ZXg3.aL>#dJ?TZ9:=1JXYS7WQ-/QANC[:GG;\ME;&8\P[ae&W
HE\aQ_<<F]a-)9fSZ9H2SZR7@3[bB8HU>,^K4Q]P3\94KG#L3_cJZe._&ICZT11;
[^0Za_=6dO_5<=SQb_HMYQ34J2e;bfG)SOG&1@6:d]d\LL2+;]S]8:B<#NdD(3B;
;,BQ1Taf.LB,\RYT\0G8a_KE55[SU1:/(74fQ;2303^_3V1VdZRG18cW/GC,_\=^
gb\,YZE^gCD\78Y:>AI1-EZZIfH=cA;U(G=8;32JMe)KZ,\,:MP.9R</X4(4(5T0
^5WZ,:@>MOFK0>3ddVDd#-([/0c<7IO@]0F4_5N<c)W3?9bCM8S8)9:D8cY6gg2^
2?CfPDKH//0?)f]6aPC,778_0.V>6.PBY-;SBZ0RDR.Bf,#&K>LZ+>PU0fW0Vgd3
Y28ZX5d2gO<d#_QIb=>+eZL?()R(?EB[LH?EA<c11RBZd]U:IH6)MaOYQ<,6\&gf
dWLS.3X:_20#NOQfD+D56E&;N3DE1,>J9VCBBVga<[_\BaHd1R(B:0SeL5:1NZT^
+AH:DZ/WO)>;0V)=0BRUZ=70AE9gH,CD32:T0c(+8C@4T8ONRRB2_<TM)0YJ2BKK
F:,IF(3bO,HK-(Za^R8[.#]RCMA8d)<K9G.J,V+Mad?&,#bNcZ#\1@FSNYMK:B<V
4A_\Ze2+91gDR;9G+98(I620<:DY=AIO[Ta=YV(QKYY^La<]SC38:OO2I4gPDFP\
?#B6IgYBF8A&M)_Q&D/]APS0SRGZPA_DG6_?.QOZ<Ea+9\G9Z-[>P,Dfd)&+YA@:
-LJ0J&L]2:>SLIRe?.+#[TG8.)88FVXAQY[OPMb)c[DHK[#RP<KM>dTc-^T2c#8]
)b0UV#=YZA5O0cPM\_H/1RHe))A<=PD&H1.Q+f.3?964+VSd,-,:M:@2?1b>De\P
ETLA?FDZ\SeQ(e6)P\4_A0J7b43ZUS^,T_^db3]Q57=Hc]YKf#XLYMGd7_=Q1G)L
b41/DN,^AJPJaBbH#JMOcG25SJ]DeU.WZG<:7A:b=5+E[JT5+5LUBd2_5J4ggBQ?
f;76Zgc0+g@Z8;f4HJ/H)^U19=UIB-a[T/?[D,)>+4>aH[NfE^@dX@@XQdCYVZZ]
6L_d<OU=UCb]dWe4QP&UX94EGIcE.R2Q;.^dg4CYYW0gg3eV,ZMZI/OB<]FJ+)c1
)85#FW@?(=P;(Q.(&5#6F..&&KV3I182-9)]+37+S#0WI3V[/M&9?+Jd\A2N=^aW
U03Q9<5\@4g8:Q;<eYU=bF;@.OaX/G)A,12/G9,1F;:(M3^3-f)ES6#9SQS[f2AF
+,&eMd77S76]KIV7V\BVJWUB?Oc(P_/7W.5b3d:aX)RU?7:P]g#\Pf:./<e1RC+-
BX<WLXW7@S(]aaWXE=>Q<X/&TM[9[M_IJYgC#45&&WU_-\5R>I[N56VQSA]+QXf;
E#IKYXaOC,8BAY__H=,[&C]-:I1+Ye>@_>?&&0KG6^0[U^P#&#BLH,_;Q5WO44D?
:<b)N>//_2,e<e2/PP2B.1EGCFe2DV5R5\cP45?Y_DF/D(BU4W2gZRWK;B-_[Cgf
UCAS[]48T3V<[?WbIJMF<5Hd;>FG,dUYBa6#=La;PAXfdC&O[P57[Ra7\6UO;b/G
/O/N\4ET\c1QY77&ZPG[+N2Z^LC?+D?<AF[]RF:ZOI0+8GDT-_SZPVTNK\GC<8R:
RVEgL>X28O?J77_?W)52@g4X:CU9=(1C21XPDId&6LN+(8(A>6fZH+U>5M<F4b9,
eEZ8e()-Z._:#1L)J[?Y8;>2SS8Ga/XX=>PDdFETe@,(_[62UL4(d@XZdM1HY<a#
J#b4>;O@3HHOfK2)7W70]/7cHcAbR<]9;Ig?R:9Y?5[CX7BF)I@LZWQCA83J#/bN
>#,N/XYbWBP]MSK?-59Db70IA3NTH^4@\X5</MZ500C7E@eFeKM4Ba>bJM-KLGPE
8&X6N)@\-ULBe?g_&\/W]K,&eP-&-^^)5#I<(E0Re0ZLOU.YMT;Aa39.2SR?/GeW
:>M28])#HKcP-S&ab_L0dB#ONDD^A>QR;Y9KKBZ,=^/_^&F6Y]D=E483OX17XW#[
G)NKRR2YVSY3Ve>U(WF^J:R8J:9-\H1V<@TN8&+c&)LIc3U-08:<P>#F4R?c(1=7
0?8T<K0e2eQ1G7fOXJ>V[9CAc7^+T,WNFVM10d27>d:5@c@M:L/^d_->:)]]U#;I
L9T>-[Y;=_Y2a@Og5^OPV^.F\cC]:EX5&-=90QK66H:aV3_MBL.G(E#gQN:=Ia)2
^K?+AbCgc,F_6<=:2g-@a:,fAMDU&LYY_6FUG&7CTPU)OUb4CbdN>&#H&:OZbCSO
@]=+@Y9A-T9G1>1PUO_)JF4?g/5NK)cT6+).Hdf7+WS1fb\?<X)<1>6Sge&Ac)TB
a611-#QD;OTbYg[)?W8=>Yb05X)[DF4gP7#C8aFIB2G7W/SR@.gIZL0GE8f984B0
B.:MW;^R##A#SePKKV9f(T4&f2YZdge3JD\\,W@3G2Ig(O-e\^AJVKE03F>QFH8J
6f5^D\TD_-NTYVQ1H7^ZWM\-JV5D?47eX9YOgN?@S\&>\F)EgEbZ#a\XGP?KKg>E
<Cg=L^&[-KILLZ2N4,FIef8bKHU+:KZ3-KFL>IYQH]87/IbVdT.X-#7;:KAPGW=Q
fWKY2U398X\?c,J,9N_aRa#=[(@U:H.C(Pf+P.eI7BI38Gg:F?93(1O@+?.d=\;7
PG+\A06?-^:/]LKZEG5)\gN6E2g.Nea#NEC,OeCLAS\21GdKGe<TVGW=d6^ETW2-
+NMR:E,50QKRU.+b<M2]\/4850aDVH:BO92:Z<NAC#Ca)YAV(baOW;U=a<T)U-VO
EFF4/5MLFI_870_]g6+_(f0&LC(.DV85/N].K-AV+L>]fU>48+eS&3<gECVa?48@
@;aY6Vf[YM/dc(9>b<5AL0OgGOM^JAI#-9P0SSY0:NRI:J5E.&-W:4)U^KK^LccZ
#^B+RACB9dNgL/:8)TPO<XIQ<X)J4</PU<W27Ta9#&<KNM)cHS=[K9K[^RW8#<<@
H>-PeXF1Z/BWbC,KD#Af[@POOa7[4TH<B)&d2/?ZB4>=OQe@8F,O[W,_f.bY<4SW
FgF]&_6DNS&\)dZ(E:E#8;,Z[F?S/SfIQcc45JWX&HgX=FI3[#_6W<WeL8?aY]>&
6G(2C8OPIW5_GAdd(Y9YgC@BL3]93WBbHEeb<?(GcP5G<,4J(2OEZVcG4cZA42aO
6RJYN\J72S2:<LGK-A1HdKH)DE=&?Z&aRYI/aXa?9a8(Dc-W,1])#)^KQE)bg<(e
UHDJ.GM(TK<T.S@_WQfWMGKY=97_GAWV,(;(ePJL2NB25ZC,g?9+;=OMN9Z;Z5a_
IbV5VGeaA[R#W5d<L;Na>5)ZA]:S0T+AaR=6Q.KRAQ+\a_?;[V(cD2=ISX><HOUV
\59e]7d_E^A&(a]7R:Pg;Tfe0\DgSF@0#ERH=79186+K]KBE+)PVXLc(<OQc&Y]J
gD=d+NI_82_ZWY._2U9Z:PES31&(\bM:W\5,X>aQOSMEC.:3B5NSS-A7b7#f5>g8
^3,H4a^dAO:8BMZXW@[>c@O]/;>7OHU>=,Q]Re7BN(]:6(0IH#<90JP[H(;-5+_a
8EYG;+WIYf[\4,d@3JZEM+.^AWDN?a+\65R>MHV6\T(:7O5gR01J>1NQ+Af^b3L(
_^C2#2_.N5>?deeK24IT@159.GCO+(7+C-O&B:K/X,:3IV3_.0V+HO6D:CHLg=4F
&-3SV+O?H4cB4C-AZ8_=KSG7;DIMH2^HXTBc9&-WQ9G/GMUT7.67_NAb4D7NH1Z3
F,a2E<&>(Kd#Nee6C1U3R;(bS4L=F.Xb]U2[&F5N#[FLWR@8g3+&,2;8F#HU=,<M
CV+J/SeeH\;5ECOO[=H)WU95M#A2bfA[[4KWKYU-GDR3.+;-9Q58;dX[.#7]FFM6
FVb#M-B#?://W:cMZD]ST<<>D]UJAf(eTdL5&4F#X-L3PX&/J:@SeF(ZJb=0\a>]
5?6:fM^0,PGHNP.=7I4adUGTUC\;aZ6=SH6EfD2D\TGZ3:,71#ZeI=(BW3_9J#Ib
(7T0c1/gM;\TO_@>T7R,Y;5;\42_@)9f5M&Wg^^WK86(TJ9@N0A1ZZHgDKWA9XO+
cb1LR=&XB/=E99aK77FIRMXbb>B8_)6.NdE+6UcU#a+K7.IM)51(K--aJ=/ABH,b
^J&O)c0[d5cfAR\fWGf(U)38XH8H&J3PP=fDR:-@\0@YI?5MaB&[ca29WD;RNS6[
8Cb<0<T58B2#8PE[_UZQg:S6^[FcV@HY9<N#K#.8H)1WALL.L(Z(,RGNN?dB9YfY
b^T/dEa)&5+S8B<@QD8E@A\&DI3YAHUc.A=/\HWcS-SO#/<>NEc[99M=c&LgN.]Q
+Q9ZPd6e,M+3I;E#A2DTI\X4SL&)FRgI_gJ7OT6SRS[^/Z,0^1Ade7;bQ+I<.J:D
e;I^1FX9EA3A#XWeV\_I1H7QS4JGX5Aaa2M29>_G.=L(32SO5\-21/FI<IYb29eK
B6>;AHeN2P9@PQTTTBQPAS]H-K.5MdbE<e=>3>bPNfGS8K_/7FcLYTRScAX;5W#b
3P7,K;#U0+9ZU2S3+3;,><UWc,K:W3QN6CYHT(8Wb;[dDfPK>fJA7VeEXGP]_6>/
=f])AU]K#F=R]DgQWF.1@<;]99?W:,CA>X5__<+F_O5@0-\HR,=QR.]XBRd)cE;(
+aKW#M@0>X+fSeM.I7FaN]2dc;ec)>5#R5BBM#A0;-;:bG2I,],?G/3a39H8KfEM
M.9,bF-OCe)KR-5KeC]-53.FI0c^_5#_B,&LF8ba4&P\^@f[[GE/0^H#.DPY(5Z5
_S:QQ^/]fIg./THC#KTXLg3F^8bbKB.G<3-Ba/.T)R&=W;fI;</-,]aNF_<2,[5:
ET8ZNS+WaJGB3<X;E1]P6OYU+NeVW(4)9B64OY68Q;B]T>P@Z6JJ8,X]31b5JYTV
0K9:Z@I&AKH\A\WG&S+1>=V@X.(;7dXg+c5b>P_.+E@O)?8:P7.bY<8R#U+ZO5F+
]Q-Q,ID>LNGA\#Scc+HTd7L2/,_-e:OX=AG@64dYS0Kf7NTf2a()fD74L.FT-Z9K
4V=]00QdLWH30&GSGe7G:04E/XA>D6LTZcM11N#db0e#:1\_VJUODO_#[2_GP+/K
[(B/aC+E?87SGOWd_c4C;2fE)=YRDbLR#[Pgg_c434RB6IRH#KFb@7,#7PYe7#.I
6HXE3>:GPUJ;0^P6\gQ>T&+\(8:;UC/9S8e^HG?9J7ag9gC9<aJ^fc,:I[>H1dT5
YfN4TWRf)<PFJWO#d?Z_6>c>df?;?/&?a#dOEGWA<][W69cD5-R0YXGM6QF1:@b)
P7=F(7ScASM7/H0.?d1a>7cC6NXe[d)VC)/a1^_b.2Z8b8MX_4Y6f80Z(0U<89G&
#<UHfV4J.d:7X.7fZDO3De.K\Zd]M62A<?KX^b9H_fg=4g7P44GPYgVdNT&51ON2
PV@)g1PZWNS;G1.&::)OR7&2?5e30f/J1W&T4)eH=5;1U9WPeIV#1NagL8><95D[
S6_OD2I7-#H]]B4-f86>Qa9\a8IXJB<^^d&S)QCE&&NMXG^Nc8c/KC082eE&XZKO
K)1_FF4fBd@XPcJ[D^=.Q46Q7GZC=VUgJD;]gccbN>U\dJCgO:N??(>-XRd64#,J
cW7dOVaL(2Y.WfbBJG?L0T9a:YI:dCV04>OZe/b1TbX\cZ?UD9OY?@F\CMJNUIX.
2D@JJ#(CcX/PUcXPGLS)aF2L/bB2.SB4<PH-07b@0LRfF;KM9/H5UTH.:TW2Fc2:
C[Ke99X90Q)M&d8GB_:S^VA^Z-._]F.G&[+e;Z@W\.^LG6B/?FL,[Y>G>c:gG#HV
)eT5/>]AIf,,26RX4?B\>f-.aLUg](1:/@c7e(.Q1\G8@1/2)J\@@2Q3;DbA5QE@
OL.OX_bY-:U?TH^JZQ#ae1M_=ORD.G?@7BN>FQI1AD#FI(#8Nb75U.[g,7YfZ]M9
)[4F054(>0E=<]_#g7Yg+PA66Na91&.a(136a78;cK:#^aS4RR&_W=bEDM=[+K/>
f.?M5/YD.F#ZT;4dLTg6FcC>9>E0K3,g/DOeW?cCU-V9MK+<W@42@U(MUZ9TgTgg
Q,8c\091/T9P]R&aXf6+[^]+T67JI,I-+1G;P_G\^METZVc9&,c.eLMU+>PaA?/a
#eDBE9)fGcaVWU?X@(/Sa39-G6#)@W=P(3VQMCg,dPRAPUH@_[V49G6:1EZ/-6AT
H1XNBY[a>M]/H5K&OED-7>^::(M4:2]:WU:fYc/09.V1US-A<^Ha,fbW+0^F,^E4
00bQ+3cc-#=.B,&IA;L6[\]5gE0>,0G2Q2Y-BA)Ea86b)4TMZ3Q\f7V?,5=LLc;#
KP?6eMPQ^eX8F\J@.@B7QUOdVM)G&KW[#?eA@e=4)673a58A7D=R_W8T[=XKED>6
YOR,42B]bV_9B>=?BdO<ZQRea\\@+g,\QFDf#GO<^D;Q_]^>CdBPf8&]U#M>Y_77
7X48Ye/-DaW3b/^GM4HPFT8dPg(\^9(?LQP]^(c2+12K[3@O0)?AL#@RT4WC4N]D
Ra[ZeAb:6HKAFDdc(^=gD#fNc:ZKBGM86L@g0EX,.0EV/&>JI5AcAHeH>L;,5>AB
TXCc,MU[UZ[R1?W[#\R4\\FAO7b#bFX2T:N24L+4)5G,#>(I3BU#&ZCVEf?#,2:\
OM(_W6^SA#,9628]12&O(TB:GfLWH<c?I;F6B^1I]N5FOeOW8\2HU/19a?4,L:K#
XP7N,D5V5;TQ;,TB\LXDcbIg?B28ZV+\?:Ue0Ia3bDEGbc]KP+Qc/J^P<]@;,4:_
c-(W\?3@3941gPBb##+KSJV2NTZ1N^JU)^QBDg8Yb2=KJ<;ZRYe3/26N<9;_#b;K
>c0e@RC2O^5abW+Zcg_@Zb.P6Q_KEaLUWMM_=M;g[@a[PB<):55B-X>C@L;\<FY#
D3KB=B#S:bOa7PO5d6E+GHg6A:8X(@FgG-81XQ.3W:R>^MW]BP1@BNA)88I04U3I
F(3)aA,QLc=,8>3<8G(ESX0\Z1:;VaR&YPL00;N=Z@[ZYg>cEVDW-W^gAYa]O]<9
;O.+N1>SC-I41TH=>GD15UZa53VX1AK36J46(/7;+Z;\ZDO6YXM8Y9Ze[F5X,G[(
()_#U5-LdBdMeXVH8XCSMX_H;CXd&;L-Med-;[QN58>1e/.8Z(C/G&].UdMbX,5N
4a_SQ9T-F?@>LSgV2XXE=0Bb@VOP.8cg7HCW<K<#,#CI69@bB6:JZR?FeH(.9WY4
#)5NgO\3K)SJ4XMGKH,H8G\8Ye676f)Se@#T//eKfTGAS.c?MN2CXG8>Ud2f@(H^
Y,U4PSN.6Y<P4,(DE#_c)a/.6@Wa>NZ5T[da@,(_MBEG#&GTK\)PG9ENS[3(^LS_
(S?^QW1])WMOCb3-MdKQfFXD-4;[Hf@<4K<IZ387Z/H&_D)@IP@1]H4^WbB.M1g[
-I]4/TSe,P-+Gc[2-79U#MI5A8L(-(C8S638)/:]0Q1]]9&(K^a#998ZeJA]]9BE
9<gd[/HXEH1#J^8TRNdbVO;9@?PP?5^XWE6VS<V/:Wcdg2_4GCBF>6/0M/RLR-7@
UgG=S/_7O4SMg0##4d9#=XfXXL;9ReX.97,gEMWOEL-cEJ#X1(ZZ@H3;3EBB5XU0
^H3BMUMSB.RECPK[8HQQO?#=Nd-dG0QA)&E@:La^Ad<LaQJ2MBG;L(#4(3#Z04W;
RLZOQ\4>fQXRE+HO#ZBLA,Ug^cgf]68_PF/<c-:eaPFG=TN=-Y5+06L+:6/XV>L-
PS^)QEA?a\OAE\)7XKR36eb(T9[f8?K#01T<C2&OBM-VZ8Z[.UdKd1Z9MO=W(RRW
:&)deC9X^W.KWR43eU/(WBVW/Uf?HBF?5fWFP<gJ_9.DEZ,;4H.c+UKTN(P:\,Q=
SJ?-<c<G@d?W7ROR[(S2cD#R=@7DQO.b)#S0LA@cCQ4TS;&K3]ZK/VW0HXa-QCC+
+U63c@dF0=P.aPe:R7T?&VLKeXf270OBW@OE^5V7K9=K_GQ5&?+K/+W0N$
`endprotected


`endif // GUARD_SVT_SPI_NOR_FLASH_DATA_CACHE_REGISTER_SV

