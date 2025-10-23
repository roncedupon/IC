
`ifndef GUARD_SVT_SPI_FLASH_SPANSION_NONVOLATILE_CONFIGURATION_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_SPANSION_NONVOLATILE_CONFIGURATION_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP spansion Nonvolatile configuration register class.
 *  This maintains the copy of Non Volatile fields that can be stored/reload based
 *  on requirement.
 */
class svt_spi_flash_spansion_nonvolatile_configuration_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------
  /** SPI Status Register 1. */
  /** Used for enabling the function of Write Protect Pin (W#).*/
  bit status_write_disable = 1'b0;

  /**  
   * Defines memory to be software protected against PROGRAM or ERASE operations. When one or <br/>
   * more block protect bits is set to 1, a designated memory <br/>
   * area is protected from PROGRAM and ERASE operations.
   */
  bit [2:0] block_protect = 3'b0;

  /** SPI Configuration Register 1. */
  /**  
   * Determines whether the protected memory area defined by the block protect <br/>
   * bits starts from the top or bottom of the memory array.
   */
  bit top_bottom_protection = 1'b0;

  /**  
   * Determines whether the BP bits defined in #block_protect are volatile or non volatile <br/>
   * 1 : Volatile   <br/>
   * 0 : Non Volatile
   */
  bit block_protect_non_volatile = 1'b0;

  /**  
   * Configures Parameter Sectors location <br/>
   * 1 = 4-kB physical sectors at top, (high address).
   * 0 = 4-kB physical sectors at bottom, (low address).
   */ 
  bit top_bottom_parameter_sector = 1'b0;

  /** 
   * Configures the device into QUAD IO operation. <br/> 
   * 1 : Quad IO Selected   <br/>
   * 0 : Extended or Dual IO Selected
   */
  bit quad_data_width = 1'b0;

  /** SPI Configuration Register 2. */
  /** 
   * Indicates whether 3-byte or 4-byte address mode is enabled <br/>
   * 1 : 4-byte (32-bits) addressing required from command. <br/>
   * 0 : 3-byte (24-bits) addressing from command + Bank Address <br/>
   * This also depicts address_length for S25FS_S device families.
   */
  bit extended_address_enable = 1'b0;

  /** Used to enable the QPI Feature  */
  bit qpi_enable = 1'b0;

  /** Used to enable Reset on IO3 Feature  */
  bit io3_reset = 1'b0;

  /** Used to configure the Read Latency values */
  bit [3:0] read_latency = 4'h8;

  /** SPI Configuration Register 3. */
  /** Used to enable the Blank Check Feature  */
  bit blank_check_enable = 1'b0;

  /** 
   * Used to enable the Page Buffer Wrap <br/>
   * 0 : 256 Bytes Wrap <br/>
   * 1 : 512 Byte Wrap
   */
  bit page_buffer_wrap = 1'b0;

  /** 
   * Used to enable the Erase 4kB command. <br/>
   * 0 : 4-kB Erase enabled (Hybrid Sector Architecture). <br/>
   * 1 : 4-kB Erase disabled (Uniform Sector Architecture). <br/>
   */
  bit enable_hybrid_sector_arch_n = 1'b0;

  /** 
   * Used to Select 30h Opcode for eitjer CLSR or Resume command. <br/>
   * 0 : 30h is clear status command. <br/>
   * 1 : 30h is Erase or Program Resume command
   */
  bit enable_30h_as_resume_command = 1'b0;

  /** 
   * Used to configure Block Erase Size  
   * 0 : 64-kB Erase
   * 1 : 256-kB Erase
   * */
  bit block_erase_size = 1'b0;

  /** 
   * Used to Enable the Legacy Soft reset Command. <br/>
   * 0 : F0h Software Reset is disabled <br/>
   * 1 : F0h Software Reset is enabled
   */
  bit enable_legacy_software_reset = 1'b0;

  /** SPI Configuration Register 4. */
  /** Output Driver Strength */
  bit [2:0] output_impedence = 3'b0;
 
  /** Used to enable the Wrap Feature  */
  bit wrap_enable_n = 1'b0;

  /** Used to enable the Wrap Length <br/>
   * 00 = 8-byte wrap   <br/>
   * 01 = 16-byte wrap  <br/>
   * 10 = 32-byte wrap  <br/>
   * 11 = 64-byte wrap
   */
  bit [1:0] wrap_length = 2'b00;

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
  `svt_vmm_data_new(svt_spi_flash_spansion_nonvolatile_configuration_register)
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
  extern function new(string name = "svt_spi_flash_spansion_nonvolatile_configuration_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_spansion_nonvolatile_configuration_register)
  `svt_data_member_end(svt_spi_flash_spansion_nonvolatile_configuration_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_spansion_nonvolatile_configuration_register.
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
  `vmm_typename(svt_spi_flash_spansion_nonvolatile_configuration_register)
  `vmm_class_factory(svt_spi_flash_spansion_nonvolatile_configuration_register)
`endif

  // ---------------------------------------------------------------------------
  /** This method retrieves the value of a single named property of a data class */
  extern virtual function bit [1023:0] get_reg_field(string prop_name_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of a single named property of a data class */
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);

  // -----------------------------------------------------------------------------------
  /** This method returns the value to current Non Volatile Status Register */
  extern virtual function bit [7:0] get_spansion_status_register_1_non_volatile();

  // -----------------------------------------------------------------------------------
  /** This method returns the value to current Non Volatile Configuration Register */
  extern virtual function bit [7:0] get_spansion_configuration_register_non_volatile();

  // -----------------------------------------------------------------------------------
  /** This method returns the value to current Non Volatile Configuration Register 2 */
  extern virtual function bit [7:0] get_spansion_configuration_register_2_non_volatile();

  // -----------------------------------------------------------------------------------
  /** This method returns the value to current Non Volatile Configuration Register 3 */
  extern virtual function bit [7:0] get_spansion_configuration_register_3_non_volatile();

  // -----------------------------------------------------------------------------------
  /** This method returns the value to current Non Volatile Configuration Register 4 */
  extern virtual function bit [7:0] get_spansion_configuration_register_4_non_volatile();

endclass

// =============================================================================

`protected
C3VW==J;4S[JJQ?_e-WX-+3]R+99BDXT/a]XgbBLD28,@L,J3.WM-)/AA>30@.6:
JNOI1[d\:^A.VT:VHI+99X?QH\X.[_#WY3b>CAY)Z5+<fC]L[0K?N6@e[V>/_T<V
>QLf?Nc6KR_N^#Z)5:AXebaT:Y8RQR_\\4K7<KYW)a88TIIa1CfI8)E6H0_7]ZC6
P?[IR>DC)g,PE-..Se+]4=L.bB0[A.)_H?_aGdZ7.9\IdJ+@R73EV.Y:.?O\I,Y:
2cEBZ[.Xfa:95XFc<P9?e./I_D_A2^c>@O&R+7MQ5R/G@2[5Q?6UF(VRMcKCB-HJ
_6AV#_E_d<E8I0H0DGPO;\>]-NcSOVGVQf6Y#QOT=\DB:Wa[26&9O_T>F#FFge#K
T=D4GGQdg[UX?:LeK\;G594aVK4@?#;_6[#BNCfIRQU_IZcF?27g,ZBNZ=.N:8##
M@-I],MV3R=KT?bb_1@c<+D5?d<dB&FQ;bGQb;35@;]>#0@?8(+1c=C?F8@bGSQS
+@[E6+0\3?G>EZDWD4Xd38[E]]3fM.CW,^D\MD5A;#T,:?8C\YLYB+VJCOcD>VJ,
d/GI2V56JLGV[9L1KcCSTNLb>=bWYIW<JND3/Mee.;DOU]1V.>./=2D1&.TW+.CB
]TM0GSA)TXY4e2)<;K0<\ECegXR8g#U9,bC]0TD>AVaYI;c9>==eXD5-U]#)4D-E
)C()&<)N2:&Y/Od(0W7E&S/-DMA<d9C>SX[9,eN][&;/dKP+,XTcd+Q24,/,JHTb
e@3+e@.^N918<MD^H?_P\Q7EC@O@Kf72:8=Y;N8d_S@/H$
`endprotected

   
//vcs_vip_protect
`protected
ZS7=3YdXMA.0bNFI^3OT/_T:]/QW(11^GIE(IQL6-b&H5Ce=-bE82(+27@6Y;+-E
Y/DGdN<Y.@5-&e^EH,]1\5ML&C,Sb[?U)N(&3e+XgY4+0CC.MT?G\0\eV^M>D:IK
AO>N2>g+9_A,?72YaY4_g])=D?KKc@=P=4.?OB>JA/F7O<b/dR<e03;#C70I?UK;
RQ/4EXCY5]+_AV9:];e?+G5)YKEBU6b^):BAEL[>,W43R,/ZULBU-I,0_&#^bD-\
f@IecAa(cTdN>N^00g5_&eUeX4PO?V.1JAYHIYQ_2CUUX>f^e\D\2VL:SA9+[__<
c5MZG9ePY/#R+H&:<[A-5X?G#7B:.YZV@?&^F,;/d:e=:3-N>MeV7.N5ZK0)RFXO
?YL2PP-J&GP_2<:#9PUG&ZKDfO[?@S@M\N[V,;,0DH(/4#Q/@\34DS@8QE1aM:X(
H^#eDKHN43Q38^PdZ.@B?fZ]>=O&]7#KZg+_NTg3,<5J@PLOLIZ:bO_bG]C4@.O:
VL6UEFC-4;gaaE/QaA]WBN.(EI,195#5_g(8[@.)N>@?gWbDEf;DG=0@84bXDIZ(
JJQb5W.8KI^VEK;Yd[aVK,-FPTUM^27a]P=W:W<,8I177a#T-V68UUA[=QFW.>55
>;5b53AJV5S8fGEZ8A/U3N_V:(CId#ZAg)1+-IZ#&,bLIK0.ege_(=eO=0-I6S.c
RM[0d?X>a5(N-1G9@:.[f1(HL=UH;J1KP:b>N[UOR1+0M#eP1_JM16b^B\gP03Qe
d&&G]a),CD\\;;9Q7HCgda4Qg10IL5,125UY/C08/8:H<)SEKO-<9a)N2eaTXQN3
ZSYY#9.cDXdPQI7Ufe)cMV:Ecgc\Z-M/6e)&C:/(KKW(Q&)VB8;=cR2H_E5c.QN]
,g&GRO(W]WO;VgO5F?,)VD;[WNB@gTH99=Q^4<&A6eVHd<fd)1&F3TXc?HaVbA@3
7Me&+Q^ONZ7O->34>((HG^A<,4:FT@2@[B>eWV8(=9MdQ54Z.-X#3_CIY+)?19:M
MQFM&>1gJ?3>6A+8Q;^<KVY>@/8QfI.;(@JEc01TBc^.E?>5:I#ZA4>S6ffA&K5I
H.XP;cg06U[</F.&J54YSHRKf1_S=0JLa:R25V/KT8.HD>ILb-M4=2DN&M?>cP46
/:4=9JQZLb.ac&#g.<5Q8>A/(>(D4>.R&)O(ec>(QG<DgI82S^,D+ff<MNN&(O4>
[@5FK^NZ4X0:(,0db)?MO+^#N.P5&VZV0I^g+-=P5N6G-HRL7Z;1G?-agXB2AG00
:/(g<BcYU46cSX0E4N3V[E/LB4-Q#gU2e-a.Z&X18bH-:b@]?S=6HFQD(I(]6#3-
VZ:1O,KE:NPHVP+S8^gDG,,[NOL@]W4>_35Q1g^S,2TQ]:;H78RND]?&QTG2E>cX
c8W4V.=,K4Q5:[]2g/,_4)/95:0&UCGO.\74JC36+83@MYKIG.JET)CMQ9AE0WV#
>NfMbTR1U_g+-UX8d_YQ-2bWb=IAe[LS+dg;)S3HN^=TL5,G>6(H-A?++0+J>7::
NRe0>A7DMB.0g7e0ZZ7=O^6[RMd(WfdBTPPR)cHG]URbI+UT-81S+7\_aKOU@.(1
521]b(N\WVb?=:b@V8CT<(;:M5B;Oe2[S5be6FKfZUH^D)[3B[(GB[>>+gLED^&g
G1&PIC_Z?53./URYgJF8cTH5DcC)-+EH12d#TW]^aN,=:NT^1If](]D^/HLa8BU7
(+P9#0LJIfaWLXWH4?Z,a<;XEQ/E43MI4B2,22?1I><WU+BTRO.a0=K>Z0\IPZW]
V8[+2[FJS5]R,5M_MY9bR38(^WGFSNSX<&-Q7aK<(AWF&g/F>^E6?+C/?NgC978E
7EHXPINP5e7V,Qd=a=;6HC\6>WNI]dVS:Zee,8\/3EQXK^64J^?a/3]B^<LZ^[EW
UJ\Y98?<X:/M^3aZV<4c#S<[PV6DV;\C<81?Wg[4&]_P_EbM0)eV,agD:/CGggV#
+F6N5[_>IDcREP=cP+fTY_FgeY5=5VS_7db>VLTH5X6RGK?P7#M1HN#XF=V@J1ZB
V2O2+,5+:dY7aOg^?2Q,-+.9E?R@K,ge\D7[O3<]NgJ2;^:MR89\7[0cW6=(?Oe7
R,c=S/adbOYJLMYULaAWRVGRbLDN)]G.KdT7?.]Hf/Y>1dDga)e+8S>M@Z;SaeX0
REDP>EMUUW5ZAf[9T=&Y1baV)[(D5F:Z_7N<0<?aeK&dC>_Z.QJI-;F2)__>KB^7
6BZ?A;0T((J/ePPE6J])&[0(dH0JFJc#S46[UeI3_a=V:f/#T9MZ6?S7A&?YPcPT
THS5Rgg&<9\7J2a#F(VIT[(QPQYDY2;)+A.J(T5UE&_fUF0OD=EM3ID/&5YY6](f
KL6G43K@QZS9PV&2&CUYM(aQ0\Z^-7BGc1Q4HX+<d@R)>PL(ZW90JF/WWb#OSQ2&
F=HS58XYM>5GCb:e)+(SfM[S6M==O\#aXC&RO06O0D<]--LV+LLCXdba^5[#J,]S
A/5U#6Fba]IFBgSXG;d]WI,/<d&-_Z<\&=<1Ca689=O-XNO.VN8=GaW;M[E1^0NR
KWSa?EGLLVYdNf],&BAFHCKc&3WRA#2]Oa1Vd8,E&O@8:R&Ed7@-#4#eI1;:Hab-
?[0F/?aaeUEM_)]>X=Ib4.4F.+=00EXbeW0>YKVg5,-UZU:E76Y?2UGebYVXSN;E
LQeA?<XBZR]bUFW]K[^[dH[Lb_d\9\+^XC^24#Ig8R^B]<P1F=28VZ/(e:,&_(E\
AB/\/]<)<6(43W4N1@Y6^/:O_,^+aYZT9>X-C(+dBCH34T_U]Gb,#4V#)(#=W<H4
CF[#:Y2:BDd,5N]/IYcUM-8JW/&2X68(1RVNffA2B[PBUeEe@CYX8>MJ5C:.S5V]
SS4^0J4N\>9-C9OG]0A0#PE&S65AI-XBCOd2W8MYOTX6@B8#XT=;ce:e8/bb>F=X
TS;=4X=DaR;#^-Of):Kag&OK-TfH&Fa+)W?=bS-^f+=SGbXM1+g9S)1;46&_YYHZ
HC.M0S@:fg_aBUG9T:VZYHNNbXa50ND<I-MEY/GB;<Q-C^L:<IB(\a/AI8-/FfT[
138\@9<UIOSd>DKZHO:V.?0^LAP)eGgAEFMdM:VI(6P1(V6T)SOeeC&NY<3UR)f[
S-d<H9+G/4X?<\C8a\(eV(MX503=U0BQF:eIg72(]L0<)Oe26M?PSMWR+&3&-<P]
SE3.4)Fff^:9b7[M;19TZ0L5^\G]JWU/H>Y_R-@WQ)AP+_GZ>2W-5;2BE#a7;>5T
YcPA<g6]\g&UF#KZM67R,4TY=2dJXABR^(+^\D>Vc(_9b1PV87#d50<L/Pe^6Gc\
GW41I</>N)[6VT6d<B4e61-C7[7b<.J;GZ@f+^<Ya5QU#J52?\N&I4:^,#:<TgP,
GOK@3^(54PBecKT0B>S@QL8M5S_B,/U69[]2H]M+_2C>=11I]&VAZOJ>BUcb9P]S
?</GU/MH_Pa[N(#6I@)#DP.e)0>W5C#O/CC:@/JY7H?=3C,TNZO-1^UeHd&V9&E,
gM=@K,+6H?AaW]CCY)-Uc5^22c^b3^(]N0A84EB8]/cZ+8c3T\FS-/<;\JG6_<,W
Y9)eJ[CW1b#BWC+X3AX^1<_?-cA=VbU\@CK8FIC<M@U#G=SM/L0[,L^NA2Y;_^e>
FU^KUMH_?cdMSCFP@bB]-86/87E,dRU/@a/fg[V@B/G35,3Z8D&dH>V,9EJK[^+E
Q\#f4NG01.ARTK]bD8CQ,KG<Ud7+/<G7f/5V1Q4A-g3+PZT-c1AV(aFC8WNBO2N-
S:W/a<[XcCQBIeBU^O^=UHBIfU>(<aS@86FaDcHVA71J>.=/U[;HNO:4R1)DCOE^
f(W#)CcZT1&;5RZ<8+(3,Qf[<@S[8a/F<^#DP:918JeRF&0?1e6dFT1?+.@dceE@
D;6^>Wd\]\RR0,-Y01U>W=1VgUZfL6T3119MQZ1L6AULB^O:+cF.Y0:M/@6R@?ZD
JPN5&K)X1L<dFK;]gAG,;^7Y[?9,Hf8]#4@K:4<B^O:Y&>=KFAR[I9g>=E(D:@F;
&a1=,d3a5B[f-CVMe0Y3/Te?)J&_XY79a.f,L=Q9<#O+VXT]e>cTce(QNgS>&QY1
JV2AMgHO\4TT<#8=gTKC)Wc:UH>J\UN9/N7[7TeMD3=NPFSe>[_;UP<#KM(K+#2W
W=:A9gP6Q^OfF\I(Y87NYLSH5NBEPNNP:@3MWT:NA^,JQC.RRT1,5.ZLeCdfd8(1
\<876e4D/Bg7DNKPI\HgV-5N6/MG&@eLbf85C^e6EcgGg/JI&WRb5a:J//K(&30,
S<&3Q?@<SSP=8WCIRXS1U[FB7K,^P@e6@@NDNXT\D7PQ(0=]O..3O_KSK7B682P5
8L-;CW+7H<eSI,_G.6gYU&K2?f<D45gROQ):(EQH-TX6,FVd-IZ\PE()QUWJA:>H
WcU]YQIJPU/>&F/C.NW4^8(<1&4QcC8f.[H[L#Y_O=DL6J_4+1N)?N[dIUQ=cS^H
A-C([C=M1_RH:#/7X:)Y1VI&=&8f3^HUdA]S#HL:6M_W#ZQ5<M#5,P+g@XV&eQ?7
D2<?8XFF39Q1H<K=:SMePgT5CH_LOY[ReUa&TEegC=W=EWfg;BY8M[DM?Dc(Sb&T
eD#@1JOW[I5#Wc,=RXbWY.(/JXJ&\f+T&Y\5AcVE7FER3LG/)/_eV?:=TJ/O(8Z1
U^D(1C<D>8HGZ\LIQ7][6OR,N,.IQMM(^LcFSWK[,VdB4f/L>TV<R]>@.aNd-]ML
C;HRO6DX-e.H_1OdZF;RVOCd<V)P<fWQ@_;9&][=0g(]B_D:Z8F\.e:a](7UbNZZ
c]W\=6[)dRK\N#(BWH>)9ILXQ9ZEEG;4A.d5#)PGDI76<\gJ>>\8#a+\Q<Hb@#EA
9;Q7^6.Y76c+50TBQdGcB6K(XVTZCY?N1Y+[LYLfKJ#@^a#6#+J:5ObR19+9FHQ-
ZU,TId-F,OdSCN:d/T>,)KaY]RHP;X53I./Q\.VKB;G\,Q;K7eYg)5U]])1YM#TN
C?[.:Ac56UaKO_e)(K;?\6()FdWXM_I7M>:KX]2PXPVS?S=W\<#(9?^PB)49=^[@
gaR5Cb]S9bE9GPLHZ>a3b=D?)2D+^a)JWMea#&429,8YCeI^+D\:J=dN961<1?Z?
,]bFEPgFLK0^F).+I3gR.>8_e2SLAN1\\VHA:1(R&_g_gfAXU^T?:59KTU+S;-#e
YJFRL<>P+:WY\1/=<]Eg,D^Y<2g,GH]DQGLVaZe4UfLHF[d8dW]C\(f[[V];PIX.
,FUTf;QCX4,THU0:RKWJUUDP)eX,5Z[QM(W_d-;_^f[.J?_XKPN,SI_JVJ0<<WMM
&Xec1(:<.AEO()5@LY/@QU),##OZI1?0,0?_]P5@(MXG54a)\>2\^7;?EMP17L+>
K;]?06N)?CB8FLdNO.ZQGR58?/Y2-(FT>UT77L0]aS.4QV[9O)R>a&GdBZZ<+X=W
BYd\\GMM=24RaJHL/KLb49PBZdc.4fJGY]]W[FQ58aRZR0]_(.\\_e7H)dG]c:AT
g^_@28eCa-T#5I;<\>I3L:)PXfa<3H?JJ-9P:>9AVa:_ZHQ+E2K8C&cBa>@OU>,9
/Ze/[I\^H?;<POAIO7d;fbIQCaE_Q0C/D2f:#P22<7cGI^TX#.NTc/2EPH.NWS:@
AE+Mc&W()J>G-VL)39@;XQ3c=CKS=gD:&\Ja-FN-=8@32C]@2]2eUJbA]0O2J>(P
IJ,W_:UXE&KNPI#_d@?f:^R+CC6X?+]WXKP/<_X@BD^:4,T9VY+3AF_a8T3d=<>J
aSU3,W,8X<cQY@;F/SO\38JfB\T8P@A[Wb=24X;<PA[P->>HV-I-H-aJ9^W<AaF,
=I077WD+L&79G:f@WJ=\U:)QNW3R0e)e0\)cgZQV:_NGN,03/6\M))86R\Uea9V0
HHCR_55B@&C&DJ)9TKQaMLNTbZbHC;^g#DWa;B:+b^[,#UJcg3&?U0cWU[2;fW:R
+-251R^5^Z/KRbZL6Q#b@SD4b5S>7[GcQI#-7UUe1K@Y<[.3Bd@C]H8@.7Cf2,cg
R3+ZC)XEKI+8\C6/ZBV9N5+9>Cb.86f_W8cg3F0^TJW@E/f,f609W]C#VT@6e@YD
0;Q:eQG&:=G]QV[L8X60KDQ-<VY8>C\0RGE[N=<5P+,3S<#g6H&ZH;1(dKcbSYH5
c1Y=Q4QCF?2V;&N8VEN&.)#+0E]-cE2)M^fP(VOSJdD<A+T6@.&#5JOQ1)KQ+@H;
NTS#:0/9e/ZHJ98C1Yg^5XWI@W73GV]OcU;AXI8B]ZbQIR9_/BAWC>/:]QNa,W\8
VWPJ9L)-PH)^_ZD1,T#KYZW<NN+S6Y7^c&@;H#HI=,cg^NB?MYB]g3^NYDX\IUQa
,-eERgPJL_,bd];6[ZAJ:>\^_0a+PA_cGb:+W+@adNG)DRMcD0&3Z(&]/CYNI80Q
K6eY07;a1V]8W:e5DJ;ES/L4V0B,c#d2K-^PF@6I\<L)bA:XZSX^.K=Zf-MJX?30
P8]dM#cb(+NbDP4P/.EU4Web>=++CA^HC8E<8S\CAeG[E)a[##ERbeF:TBQ?ZCcE
JSgUbQ6]Ia[KK?>2-g)WUU;BP>9/Z-C=a^GcI\5^>&61>TDfEWNGX3b#N0/8Z8#X
R47UgN<4bF4E,T(aH;;?=g_CIZM)L9>U4g5STeK/O@/,AgD7]TR:aC_NFaA:W[/W
_[ea=3Ca8VOID#5PQ=KG,GZ#eHJHYMC5<&U>GKMCU)#)ST[9a#D6)NVZ\77([QZ&
LU1QGc6/VP_(>:a>JDM&LU3&HG1OFdbfA?>&0VfMbU+UCZ:,;PgRb/U-<,:S5f]Y
^WCQ)4)FS;BU)R)<799&:gU,+PIYE06R:6e^&+@(CY=12O&?L9_+d+04NgJ+21]R
@P:5&Dd2&<Yd#O]Y=#b]a@IP4#XT]K(TaA+70HbJFUM-WC#0K<-eg/?ZBE>AHS1:
UI@2(PefAc-O@e/P_,_\8V+JG5,_eL&\dRBaG#.TEd0+=4YBCM?T?;8(NgB<AU:b
:P;.__JK.G[Z3I2I8WICO^(.ScH-W)[/Tb\aRc#b97EKgbUL2DJ4E[JNZ6&R\#DH
A,?F&V6Y&[C>(cB93Ea44KeX(NENLT&DKNJI-9@VK#ZHQ6QS:W3.(G95_R[[eND4
=T8\F4-LPAX8;DQT-1F-7FFG=Pa/[L#G)EKbPU8D--P;.52c9T08HDI;?+DEH.g;
58YEOT\YJRN?8bP)_^&;H3;).O6]?M(_&CGF4EDMN3(Fe9bU8=QU#=BQUTEga^b\
(V6a\/<,O]+,3\c>4KW,-PPX[CNNSD9638+,>2,1P6:2=T)>NdBARV03W)#-^0DI
,WZQaDDXOFI]IY=Ba;3d^@cbSJ)CO3f,ZEgadW=010_?2;>3S7=73SA7B_L_^,(<
g&Ia]V4#E1edV;)QdZKJS+d.bLY>>C5=?R#,8gb3)0\&YU7V+C(7@I8KVUQ[E]A0
3SDGZU(9QI8F#a_ELL#8FT/-Q09c(E@.N5I0,MYFE,-dT)?;f/S^EYd>G.R[bY)(
6/QWcLc,<E&d^Z<2IIS[BMVGKeQQN,2?d?@CQCESI@=^9L/:^X.]5/E79J?:KBgR
&f#<S6&K8N_[C02:&T<XT(S4M)ZVBO[F=C.L7VDH=>OeR_/B4YGdJ=8\Z<^IAg;f
M)HUO<MA0E>XP-WGU(T]:YR=#_:0YC(#[T&b,U]FG-9Z/.CF]87G_^d5SM-FV8Ec
-44Y9?JWR./40W;fNRQf7=4_LS2XCLE(.cRN55C59c>MMVSbg2CS4<]FA[^8bcR\
Q7JS6Q;^0)M\g/T0PB.FA\7I#X56YEB&5DJ>EZ2FQV&NA,MG7Kb7Z)U=CbEC?,T8
GgSY],9c1PddB5NK64/FS6f_a@\Gd,T(baF;QTO(SFR/V7fSI34J@UbeZXC(2WUY
d:?]F-=L#N3<YL0c_,MW7QO]b2WH+f4BePOXL]U0g@KJB]:-:YTaU-;1V_+gB35b
9VbNANLL35?\dbeFH5NQ#XK++9BIDG1@8+8=OJc1Q9d:2:>>Z&WNH7K6d15KNSG?
Uc4-H:f2_EONID9-gVR)AJ8[U#37]UcZ)07U>&2XNY&cR?)+@aaJM(G73?C9OWG^
1C@Y[aC<Qg3LT+T5@<1<c1^PR@aGea-T&6G\I01FgbLR0bXET4b^Of[F0Z=T1=()
7[-0UH.4HCR-b[4:?K_K@LCHM]YM8=AK+;YGQ12B7b516N/\_SR>M@SK[9HcVN/d
GY/QVSRf4YIH02cKUZdU65LK[eBOU=W7(1YTU#]cS[C2Z,PFIfZ@S2XK#_d-5]a:
XgUeNH79KgdReL9#;AQLHZ[IPKR?g2d.JUK:N_S>;F)]OeUb+S.1-Z<Z9QP8[XJS
.)1cM3PeD<U^2.L&;9E0)Z0SAc_D)WbU8QFgVL)V8R&[8.9/GC<-[6BD4bA3/.YY
P-V.^@K9/DbFXX1gDVF^U7Ed;d-1&=[AQ/?4U@[#9NPX#VG3^Y1P(\\Za3Q38P][
TBcMcRJTWGa;O^2X#c5f>[]W1V6V]<([)I6c:).6If/7,SO75(3Ha,a0,L^+ZIf?
BFgaIfAeEgO?SKRc@F]JR;(f7#d&2SK.1Ad:Y_XBVHHL^VYU1SM7?@0V9[Oe_2&A
^4-5ggEg87/X0c;:fb2,JfZa,4cgfFJ^U)5gZbOf=fdWHbdX4K>)[cMKTF@_78W7
P)P//[Z[.Z6S12Fc77_^e^80=5e6SGa.D2EXRZ[8L/(=0(;#Tg/Z(T-_3R,<XST;
]EK=)./NH)1,R5>7ZEC+JEMV7aO^#=,&9D&O,NE(WP^)IaFJ0//W,fK5aBWQ@71J
;EYG)/MDIBZ8VQaS@H_]PYL5[_;Y1B2H1fL+U@OA(OcZ]FF?cBI5)?SfeP\D6JP>
>dGIc59eCJa_O9Z6Hb[>@CXdeNSPeD9dC;<W\I773UX4&J?)7?XXS9+A8LY[9KE,
cD#QLL](WE&@8\]>14D[+O667F^2a=_IC/gfabc)><^H_]XRea(O?E27Ud[-e+CS
e@L1[-\P??)Q_96K:Ja;1g[e+=g3757IT0LD6Oa?1<PUac5+7/;IR//4R25O[\5:
8/?Z?RAD?ebH_KPJ.@^^bf.2616=U_8B+g),EUT[F,,DZC/&GJ>bI\[L#JNY)_>&
;/-A)b.8U725)#G#_Cg+_a:2NI&+D>[GW9bb4K;c4L#=N7RT0,]A8g#D>V46.Q:-
e0\NLQYIJ8^^,4WL[+O5MD]FFS>#_O@(/Yc_G45R]0B6?6#_)f0>24DR9607/5cW
AC^D#:7g>@7\]]?,I>JX.Z<SA16UWIObJ/H_f:O@Z1ba+:b(6]HG>PJP^&DQBYNW
E9THM2.=RABg9F5DCEW6E-ML>:ZI93RH@\C4WgO=3W&MSCKb;:7LJ^BR4cG9+<cf
?&S/g;R@:(+OR2cNL2;J:UYdAI^+ZgXc9<\5a5</g\-8;X)5LEXV_WK,XI@_(B1Q
+F>dMAWXC4,&(gYIZb^SJ>?M<FN/N1RU6B(K-SZb?73HCBO2(4+@fGe2RTbY@3^O
3=AFI0[9M,_#_(/;2,B>ZX5;\M>>H;-J?<4d.:@Z;XScF6:?YH#_@VF8]36PG&Y^
F3WOM5/<.e^K70,(?K_UOd6T3R1=#V9VQX;TceQZ-8=\)08eYT2=gLWGI&/:G8;M
I.]@?KF?P;:Z^BM7EH9(<SHWAVC0^cYDD8AYJ,IgP-(3&BBc3Q)fd9f#T<&)=?B1
RR]#9LgA/M\I7c[dFEMX_a85+GWRBEfd>:<O10[Q/LJe?I>@S-W1)bfg=L8g@Pc,
g^9aT6ZP#+N_gK0FDNI9Le.^N-^\(YPN_.5T=@RUVdIdg=MdD8&=\K>Wfbe#gGYB
#=E;\2XE?Nc5N]KCM:fLT_8C-MFNUcFPH9J/3B4Z0=7#IY12[\_eOF=+\WY=\aVU
E8S/@P@4PK.D;GYG72A;7cKC6CJJVHF<^(bW=DJ4C0egFA)O<]1.IX3He-:^74P\
F)/9^(I_4?BVEM/RaW1TX[(9IY#/d;4LP/PbDT+OeN<gNg,H=T94/2RC;.[5@\@Q
&8e1#]>&F\2&dQ8XEI]/1Gf]G3a2fc>^7D6F;/+1-TGa1Pca1b3]@/?6JOJETY:Y
Qg&0af&BA?BI?YDRMEO=I43Db=VOCI56I+,Q3(bYV2AMK^]:KLT<7J[]5;Q:893F
/].RL1Ue1;G-S@e9D0f-f\#,X?BO9=aCNDKQWHKF980W0^aTN<4DFB.b(9LT>A7Y
->JW<]O5#U5TA#<MK7=7WAL,8I>3gA>-^fK7KSGB/5XBBN>ETgBbNKgBAb1Hd>VG
VX)>Pa@>165C]1-..S)W5<-Y7H8M.?^/\fJX28)UB9RKCbH5a)bTBgP2+(YSd/U8
S(?-ZO-8d.__c4:]MY[LPdDbJa&0dM]dTC3MC+OW^O^B4K8NTZ6I@+(7_CT]e6XV
CK,&Ee6:JRU<O]-BbNaf/BefB_Q/V_==Ma6V,e(]cb9A?ZX2VPX\@2N+T>F4P8I]
)[)/7Dg2F(fV-fXUdI5K/IbBg[K6LIC<JYbTFd:45@0-.;W:T=/K3\-)-DPG^-#N
E3FLf2-G5NK9UE=;@S&T>CUBS];(6IbKe#e)d.;6g>?;X6G1??)^=)\G,g[DIJ=3
b]F2A>;.[FYVE?b]7g9?L[e7OF?GRH;#:_@N:Sb^Y4D@U&Z\Gaa9R,+^1g#2^W0W
7bg<P,[QYe#143^[;F1J^H3NGE/g&ZQMUXbD57(cDMa@Nd>+>@[9W2B1+NODKQZ?
U0d-<LM5>;Yd?0aE#>H_BV<gR4;2BY-.3(+@TH2I_6J4N,]M5g,N2@2N50gS2.Q[
1H[R<D4Q:++X);,_6Y68PKO.22ST0.+A(078VX9NQf[A.d;;RC3H_IICM3L<[QY7
G;FCF=eJ#a4BRVOeeB-Ac?\/U@75EHN_OY\M,/HbcI?]I9-E914?RLMOf1G:N0],
N<KY<CR;0D,(6YYeXBf@7UK7;&Q1<MR&3O]N(fW;dT^M[43#[&^OJX9[]#5ESWY:
V((d<E-=:)\ROQ+fJOY(Q&HR=eE?_P9PIg>4UaV7LOg+,8^VW/],:0Y;RLa]>2C-
^44[QYWd[N4LCD@;5dE>W;.gF:X<QB?U/#HS#Ke-7B=KD]_O:BQ-Af;EZUGKa1#Z
,8;>J,Ce87Bc6]Hc:WFLV(4F3)[W4_0^(+S2TZY[fG]T.FgdYJ_6=KdY_6J.X;2F
a9GfdF\d+84]YK[R7XH,_a91R.KFfFTeX:;N]7[DDB4fY(_#-C(I6fHNVC,_4PLb
5N#/GEKMA/MUU9f+&@-c=<CJ^IK)VKT[4:89I:C&8;dCeI.Tcg-9^9TESTG&8D9D
(JD6414(-4IE)A=^(\YK-/]?ZTW;cE&+#B+V8DN5=2eI/UZP=AI-bU/<>V#36^14
U?]dSDRAfVHU-K)?Xd8#].a?C3YbR-]&,3OS#)E+F9b8#-IH]?@08HW)F1e<,2gS
KR&_Ed1HFEe:X/U^DH^+SKXR6K:(abccX;#VTc&e3\aMJM)7b@&WA^K)#;)3)Jb;
\:;-C#WWJG\O>Z\^>YTbFd)aK>8f\6E3e>g-/^_b;/QN+a:R9aeD&D.Kc,D(W5^f
YNL[DCCWf6@^N?U#39BJ)9Y0+;+GM+M+Kd1P0>G^)b0F-:8eRf=FVN;57X01(VB4
153c03:.3>M3\7B&B1PbRL[C+>\[)L2)VY[Z#P0&FBQ5]?^;e/M-[U/D30D/LJB<
-\dF@Y917P5YTTVWf59#BOACS?5V#A4E<aJNSEG#VF8dWNg=JE\#\XIdV-Rf[/,X
O^]C8_.La;><;02]5,?43^Y,5.\_VC1_K7VEY7#ULc/DCW,\E;<NC#XUL0-B9_N9
;344S5#^]a\\:5?WN<K3QdE_X[163;:?X/FM/#+[QVGQ[OZ0&?\3c][;2QN-;MV3
KKeW@DEURUF8Ec:C?]><UJALT-[9@:@:U3[d+eD)ZM-/RQ3NS>23XAAF)[9#SR6<
\APK0;-T-_QE]cRN2S3PMJ.^8KHCd3+a<#+B4+gc#D+HGRdg7]e-/4]OLOQKKN81
AKQ(X.EXG_(+9&,e9I1FK6-4/[:[ZS+eNR8ZfJ+345cAO8\<;^RTbc:3PSEWVW;_
&>VFg@GXRQWGV=-WA.d)IV+9RO@U+Sf?[A;]=P\_F,^I,LQ-IAe/0JTOPWa\H>?X
c_G^7?ABZM_HRP?DT[G^D?Q)@KZE_3F@O7=A41EC^CU#:CVf9I71^<F:Y/fab=GM
&KYQE13>=g>0NA.2#C[H<C,5;[+;K&gWB(eIP-1OX8g@^2#@L@O?HVZ&7A?EWWH_
4HZ8++SfG#.J2D2CMg,K8WM#GD(4CXLQe_XEf5UOTMg-B<fYN[1Mb^ef>X,T,D=J
K(7E-/Q31E54Y&KEQUC4MDS0ZBP>-:H/AK.Z=I+78_A_d@N+#@J<=AFdM0-B14A1
?X:cR7]<RSVCe#f:8#JgEJ+e0&/e]]/6X,>9ED:+C_0;(+[JC82[eTMaeV\eE0e=
.H/fVL866(O9RG)=e6V9<TH70&G+F7NQB16_M8I/.9,(5=/N>eVf(=fLB3]P24M=
,XH1f&8(S-^?OLTI001_PJeRIe,.]Y8dR.8e@LR08DB@?0&B#Me2X/XC4WV2MNN3
QVd<LXa/]_X:@L0T#L1[Z?I84@BG>7TI-Ub9F?.8[F^@(FDNH0P7R1:_c(U<Q&.[
4:_W8RCC1b-BA[YKBDYSf8\+@T31:-4Q?G1/X6X/&F\IHOI@NHf3UOZ>_YNZ>YSZ
T[f<B2S-=6c?R:F9H)X&4D<(#/BD>6Q/DN/S7MVE:DEJ-ML^Ee6PQ)NR9/)P(Z1>
[;J+Uc/;@OJ,<&-a;2@,:DZC-Y&7=TYW;d\1Eb7ZU4)H4AXJ(;dd+,g3B,4B4aFO
Ge.,;.[EG.F83V8)/@VVAZ<Ja3UNQBGOB/cJ-40_20@5;1=NX^>cF+b4/?V>A9:[
[D;8A5X)&.A3f;5d8[dG?6E(I(H<36Qf<3cP6eYIUF7=XO,W<g/A2MH(0O,_-)(V
MJ)Wb_P&6OF8AP\0/g=FGCF<K067^dQ&dQ4@J070-#bG7[6+EX>3FJa[PU@<31C0
bU8:acHGT(-[1gN\?aX.E.g^UE=[KP@WV^=8eL#=Ff/8Mce(&:8JTOC\VH<ZJH5:
c&5<?SNZD7;)M(W@PORfDFAXX=U8_6,[_FPY)KK9<>cZI?L)5MU<R\Y4/@51+C4B
GRU&-43+A7H9FgK/YdcSFU(aI3&H1PQS#A6#JV4Ma(@&L&<QeC]8EJ9+NNfAZCPI
a42OcSRKOLg3dSG:,fJ_b_H.GJ]\bWK^7[\f-,:C)Y(@,(GZ3W/9YRP,32Z1bgC>
\B0.<bSRcW6d(6a=L5Aa]U\R]2\\H\gI+</S#,IO9LFV?TEg=.K\:)<B0WT;fR-Y
D;Ec4)4X[\::dD<Ye=V^Y2X&F(cDEFNAcSCK\bgA-dbaKVIVS1P8Nd,f;f#>@Jbg
_OH@JV8eZ943O/N8#_Z0-S?+E,<^:&2P,fGD874&V3YV>C2.+fKK9)BUde\.N.+G
L[7I2(G<dJX/DaaFH3c(IO5bfDU)XTDe:@&M_HJZ-4Y+McJTFCUX3-;B/1UD0D5;
d=-fdDO(;&a<33W\MUeI90>GaBQSTKa@M,.XLLO,F=]]&[KK/N-7,(0SE6g;dZ;<
Ig62M(HS^Hag[@+eBT?3FP2LGJSDW(#<(,&+>F]^VUbR?E?C_/aGE3ZePeEZ13UY
N(a,c^8;C7G>7>eb#=IC&QWB#M.RU,.Q5J:>N?6dfG=C(,E[9.]#a>\^Ub1Uae8-
b/,C-Y_-3gLZ_P#D5A&/O?3-14,)&TV?BCFE4,QA#A_]@#[(,G?VPQYefEdDC1/-
e8gD.0NF=FJ5<R/a20\gK6-OHOW7f##Y)E]0d.gg0Q^#Ng2eGY4>=0FW?:JVWeB2
J-1fdH+df=dgMIaH&TQ,>((XX:_8Z8c3gDR=+08:X#+(E,dN44D@^YD)X?3-Z:MG
&O]gd-1QVV@/_aF8DVg412B_]EEUg@U./#0C?aTG7J@^AU4+I(BT1?E+>:H)a,<C
MHISD<C=0I(<DN]U?6=ZIOM2EcPNZ_(e)?D,P^_ee79>L3+0>++1W@=Z&H1PZEV/
0Y&ZZ9>G-S.01F;7Q:^WEH3V\07#UYFH=H8J8Wd.JQT_DR-6&[:cPY/a8A6LS0[_
.C=IIc[,@Se=H6>DU0T=DYFXQ7X<a1_KSPZYIY=@\T^@..-[[Xe)-Vb)JY#L5>76
B9c[gT#K:T4VA-6<3Z85LK@#deeLE@YFMbAMV:.[HD?(aV>:WAf9J\NTU35A0M3T
BLD[S&X+7TGaW4,:9cT2b_-TeAc\7SSbA2P:IfJ]10DeWg6-=J)1HPfO-3#U_OVe
()?HB-2#B(F:e;&gD^c(XEMABYRM6L.@K/RSUE\5=@-K=MX?a0GNJTfZ\_2e)@bM
L._2FIb,E6P1SRS2f:WFf2C)W@+bS87?BE,(aH9<+,]^;Z_5YTE2V17-Xe8(dBT2
NUS=)D2U>aI\2>T)TO>:7@S^c#7]C,)M\W+:]OIP/Z=>VW6#O3&)V+2F?^9.N,3[
.W98NFc:T&H\PGfab#P,\R46_c1-=:^75T(5Maag4aCJYCGGO]8O.X[]-WOX1[8&
0Z]>F(R,J#99FI104E@Q06S#1/M1Dd&TTN#S44Q]dX/;1MZG-V#--NBNgE(g]7G;
3dd<?DB_9SKK-9>1Xb(1+13(Ng,;WXEIC+&EX;AIAg57H(6]-)7U\cR#Z0^\8a<A
A-aE>)+cbU]\W,_)LP=11EM&Z?&_NE=3f?;aJbc3e?8fMA/4[\9_J2;_,^\e\N,3
@+?+gYD2ZL6HMV:=Cg8NC)L(8PM3YUMPT3(;WV=aEd9g]/fXG=ZC-Tf(g:[PLa)T
,@D>e7GgXQ8O-+A?-EUU9f;LdB+=7c6DXD94RP2)A,<O8=F&TcV6A/.c4_ZMVR?Y
Vf&TM@>f#fDOX=[8XYG-1<eV4T0XAgL2;H,^)VHL4P4G<04RT4A/c<;[=\(OMb>a
VD2,cA;78@?+74G)^(1d(UT+#(M/NgNRd[:)cQW23a))1T)3_O2dKST>Z&VL,F,;
aWBNGBFI\c6&c6>)B:e)b8_V<IaCRU.QEIbFIVG^,6QJ][]b_bf+ZKZXX?eZ=?&2
+9694-.Fc,:4M83VYS/YF(Cf:<Hf5</(OaVVM19G3L8(2#FC<E<;.03>7B2^8b@\
.8SH3e,c5K+>+7\e^bO@CLM;7=e[<0A61BWbb_<WcM;)g(UIJI&&ZE(>bGHL#2CP
XRe7Te/?a<E7D=MBD3[#4:I8g9/Y06BNL2[EY<f#(NY30PF_]#58;F5IfIO=6B:W
_X<M.?KE7;]B@g]b\987)>5VcPgD-_A):bE@@YTX][,5P5PT)A:P7C6d5Rc1&@/A
-^SLD6KX(AgTU1UGK4DPPPd\2O]H/>@_QDG;I5:9=<WIQV)1bUZ[>N6-#=ZQXHcL
g>\e:MVFZ&></A73F;<EO89Bb9>D2X#,D^dB=fY]9&)M+:PBdZI#.9AVEeQCA(6E
#WBU9b/Y.,/87.<_d_MbHQ6WZDKS<Je:=66[=)+XL7&RL^:O0;Md]/UB.b8+DbJ+
80NC2DXAMBac>TZ0]?e&;,P@NAIO(CW)-4ZRad>M6Z=VT@F98S\WQB#dVCJTgMVP
?PbdGGfNN)SU\NLM]&K:DVQ[b^Hg<JTQXNH7QL1.#-]J(SS?>JYVD5]BTH:YSNC]
/c]\E[O5RIJK&efXM56@BM379-3S-PO[(035S2E2Me&LCdTBGK<7^K9DSJ_S8S<:
/>a,1>=Y1Cf3ROSGQUV6&F8X5.4]8RZAURDf17,6[WfIcWcKda_.]fF(I,]36/@g
T>02WCK>W6B313f.I.#SBXX]OI#UKS3XBXVV,,d8g?aE#DcH8AgdEKRX>a;13<8Y
[=f#G<_.XI5)XVWbZ(0SCM38@c-^HINN4046+COM^_^]6SHfBG=/<MFKCe+?(&PR
]GI/B=O2?3Q&,KEU0H>,SH&aI<,2334O&67D1,0R[5XWaCc.@]X)/0.Ec_O=//AT
8[0?9.?[JbF+4F#TDd-^7/P5/LcY&/;:(C.:EW60-I2B_5CW)L[0H+,]8B_eKJVe
NgKD1GF_OKX2@R?dLCH>F9Y^8Y]/_QU.b.DXQ)eH7)B[c,W-^JTga+;_HX5<;6,W
)8_YDPa-.)[?32EFST=&6,SWEf].0J;]BH+1OAJR_-Xc3a8V@Q)W(g<;CS<c7JK0
4c9F@HH-;&?IO5SF49PCdN>L1>:@]YZAM96:6YWV)S,Y2I2^[Xf]L\#4d+]Ke1P;
Q,9PG8b(&U?3HY3?4;I#4M8^.Ee+;Ad?c-6CC0[+,(Yg5Dd+4EQXQ>WUP\TO48>H
)N62FL[R33FS761F&60HaC/_c323dXRQ7\cO/VPPF]cJ1@B.4dA#J/dH>7PS;_OW
?7&?HH><).B&Pd[F_7dJHZ)VBKfQ/b<^AG:(OeB.=b[Z5b(P_D/(;Mf-JK;a0CBB
cYf\_WW3,EU&aZedJbaCBR<@)A?ccgGYJbQD^3S=LSW/fa0K[(SM?DG5MZK07aGL
>KSB.TCL(<SJ?8C_Gd&d]#_2@-9:99fX4XSP?:cQG+[0ER(dLH5.)ZG5UC3TbXR^
.\^NgeWY\(+,R_&DD^C9__[:-fD+ED6U=O9@F<g_,\+P7Y^/cEHe+HCgf&e^Ab+1
7KP6gfa-][^MaF^,>5V8\c7=#^V^C]C-;V->ad=CGMJA?;:U\g52e;94&[YR_J65
1T\?#fc7f>;ZM</T#A^DX)+ZX52<gUB&XMJ2gBd7]/6H.ecU0QbIKCRgR(&X&CPZ
;VBbWfd,(c8PRB9eY.7L7=7d-T1]gSK1@VGD3?SMO8bXY@,AD,4VU>NV=5#KbK?B
VXQ;<PaPKQ]-,<;FTWQ7=DX1T?aLc^Y-Y_E.2:N=<PV952Rc1?Z:I<A2PR(:N(T0
^\B;+gAB4_5&A_38X4<85(b-Y?O@-G>X;+KXf>Y(JcBJ^]?P8-YPU(#CBGS2>Q[W
E(cLMFLGY@LU9FPHQCK#ZU=UO?Z^O0QK-01W&)P),]NDSeCL41KHC+c_bK[UgT)[
@9/T[@-S=/S-)XREZ>H)d1If]>AV7H5_M#C0_,WPV6/dV[CULdYF90)R]G&TB&:9
V5<<(FTK(BdG]1=\Z)81W<#&-D0&5bT>D_<:UI/@Z,ILJJQ^6S/gbX1=DT6#I[+Z
(Ae+?3.5Z7geES)>L=63LfBS>)5MZLW+)XOa@.-(.g:Y>A<,4DQQ6K2AMUX/PY_0
_0-]1,KLWY6g:(-L0?-]6V?J)201dHJ\\V0(\@e.OH)Q7[-R_Z-R<?a(Kd._MHC.
ZdYX7a-\OD7RFA3G+H0)>E2WBZTERHCXT7Uf_)US,c>T?.a9OI1b0@dD_+2,7]1?
@PY9DW-cC](,K^dKU^<T>FKec/f(T>dc[-LIdY#gUC@&:8F;CK&)ZII3[J&.>a[A
]__KR/5\5Jd+6_@I/;D(KM+@GMNX>O-+I+OfS\3;N/6OV<fW8#\:M>.TEK-+ZOcP
V>TUMEKWEJ/[KOI-3AF5:P:g>a#ZJR+UY4O(29JC;,fLEc5^18J-A2;f8,LNZB&d
geTG3bB4HPDgff2#Gc05Kf,dc1Ef5VNc1>?MANGRQDG_;Fe]L/aCOT37,EW)1dQ&
(YN#+9I-TJ7T:_D187L>GYT.QcfPXR)]OcNLQ9?BH(d;2_g>;c+Y6_Q_b.&g+=,Y
bdOebL>,4g9-fWC8VH2=N,=TK,+gC&<1?eI@+:NYMOaHLcD;aa6JTf7I&c>ROD/Y
J=BdP@dGXgZPH\8A;5b)R:AZG=)MB5cZ5._/:5@,]J:#YTd@P-7L_<)H(V9-IbIO
J8]=Z;&:TF4/U0(^LMc@KAKF)T.1I\#Z@QE(R)c?(507b>I\B;R__DGNQ[)^2LTW
F^ZYbK3JSZ^/+(.>JE-1A2<\R+1=@87^a_4+BB&Y#/??H(?KCA4bA?PT\/+&8_b0
[d7EP10OV4+<2(dV7R]VC-F=NF3Y=Y\Qf340OM9&:JNS(55FZ]K5:SAL.2=2M?eD
,5JgIW6e=BQHVRL9_?5;JU=Q4/UYP\6D_J(a;Q8)YI,VX:A/H>R@H#MUF^BF?dLF
g[ZEMW&>PE8DW_-LFK&C;d,Ze+#E:Z:c;@c[O?6Y6ff199A\VV4Yff:FEN-6)f:=
01<<,/WH\H\f=#:M[8GIgNfGO8)F5UN7]XUf++FU)/WD7.?0>ZZ)Fc?3JLSHL)[>
1EbZ9^FH4MDXB7TW0I>E9aEXeBS(+eWY32MTWdK,WVULK6O_c^eO340a=HCX0XUC
KgSP+>5(E)=f#aZ+/f,O:>cPU(N@D12cNEP@5@\[5/Z]ba;Hc^20c13[KS&A5<Ef
a:^a&.@Q]TG&=DD\VQP_S;CUac_(.(S^HMPC_Y/d&Q&B157J_:[X-#PUcP8#BGeF
[8ZYX]K@Aab>eR)PU9U0U)_G21J(BIPHY=^+MH(>4cR.UVKOK,7fSEZ0G#/E?Cd#
N=HcV0LF]NdQ)5KZ2X4M28Y7]<\JU,gKeB0@=+;XLHf9G;,I13O9f6:5\9OT5Sb:
X7ab<,FUZP2?[@G0/?R6OL\BV(X4JENHCC)4eO=_AdI9Jb73NdH5Ed>/-Z@R_VSN
?c#JJF2#/AG)1NZ#EOJ8c#KRXVJd.2ZPL\KI)1I/(Yd&XXCfRdK3X+Gf+QZ;d#0d
MF=0eQ#(^a021<ED;QK6FAG;353a(I)(-b&AH1F6ae+<LEg;H8,>dZT>,9COY=>\
a=L]X+Oe-b?AM7AN&319T<D4G55B=2K0<\EBaK>&J7ZJ7,(7cC8aSa_LE-)?c.0,
+@G74=5Z3ff5<24_[:XJ0P,7\[14_\)F):W@IeC&EUC/Q^#3E_(@feM\0H(/fFOL
NEJbO?&.[UL_Z_+ea_6OHZ8PXe6E.>V)<W=22I&a_>VW36\^NVdg@Y:KOP840gMU
Pb/Eg?^NDG4Vb2P?_S#BC-P@3?;0cWO@-a;]_U&9B<_NU;BcW@aX9=\:\MeX3TTG
7,T[;^:)D.H7Aag4M7QgI[TH4fV>cg&]HHX34PK_D;WW_M/&16&6VMOU#Xg_>4D1
LGO@:/bf=1SOAc+XeP[4IR=MbFE\X^]gS+3E7d.6L9ONQWY^IXSPY@M/gBcG)S&X
[MJ/;]2HGY7<WH#JHdMKQ)IGc]+3PKf;3@.8R#?CSW4fdGdNQ=V2UY:59fW#VYB5
Jd@9E9gP_.bCG);[1[75];J>BKLd7377]g<G:,+#gb1N9X<>8?gIg#U14B3#(I)S
RcN?K\,0d+&:R:R,_W>3[&:c8H^A&(4d@ZI>D\5F_PA.cY-@edW0L5d^O0R?W9IM
3J9DVJb3>fUfaHXKYEE+Qd[V?I\g)4F@Mcc&&R#/)IP?2GQT(BE^;^5O]0.f>dU)
/-5Z[@6J&199J0&(18Vc6Q1+f/24f(FJd.Ue_dV,cC0EbdB4f]=3,HWN>\38OB&)
VYUX/)55b)-F.M-D+TZI8V9Hc]C@c9?^#b=1@5B9CE6b;@IP7S1(=&BfASS39@KR
=F.Z+:K4dfa;MN;</I&<T>bUW/]@N,=]6?7Rd3L(>P1(U68RHFP_JX\>@J0fV,HY
&6e2T\^J6C/;c<0)K0T.J=)6&G1,993WI]WVba5N)e[YR,27/(L>_\4bB>P:9,b^
FfdK;064gQ1&\UUb&a8ZE7?b7(P50-POH3]B]ZE4c6.J#+gdKPS\^;U;&4O^_#RQ
/#\YEVOEZOE8Y(.GP-Y@aO.?3/a938ebKD.UJ/>TY(QPF4J,f8f>#WCgeVf&<0Q:
N8++R1))-BQG+1N:4_SgMXPN_I@XYMS#Ef27H)3>;BWXPU58KWaDe/M8<K]=EV1S
g-):HTPBXL?Hf#b0UaS;(.FL8;=SYedD.<A[6FF)5NPJ4UP5V-R3RS^W[YZ49I7C
\_)U9)^BdSBR/bZJXWV[96JU\[-:DOb#)g.\Z0X5,BA3Ne?#U\<YWP]f3-E/,4V9
46B3ePD(XOE]^@7Tb5-52CJ([;U5S-P.WgIBUf?MNNDeE)<9J(5=H)[MK.Kb9RFg
SZ_1-4FE5G28C<85gBMSg.GeA[SCYJZY0SOGMIO075G=C](]([=e[L2)MaZ@,>MO
7bOfeN:BF7Cf-g-6K,#X[A:YBQ2Bg@[VHAB@.Q)X\?,g>#f(&S4+RTaWg;5UZZ]_
]L1@Cc9J[UgLA\8-bE/VIBP)YaF\K,=eQ4;-9e.cL#BbM&Q.K(dK7)DS>bc<L9)P
3&NTP@44JaegeB-MHE=:0/Z,[4<S;1<W)aQ3[/897TC]EEOZeaU+d/#fZ\eCHZX.
H#E/2Y]D.Zd4,fQ/,+JO<\C-_#-P28K61_>>4W+67WE@U9caEf62M0AZ[#P+:f#/
\>^aQX,Y<FNJ99c3EQJB@eM>KQ]b?fEWCH)LeJ9(G7BF[/Y?aUU@Rb930HW:bXJ+
b:MUF<+HWZ0VL:-3^\E#0;?:F?M)G0;?Q3D_ASTf-V&8/Ide_)g\c[U=1\>c8P-L
90AZY2Ab8K,K2)OCKVC5O(R:/V#?5:)1]^))C2R-U<K@(TJL56LgL:/L@g,8E+^J
LHfW0F]1Rg1Bg-6WcJ>>JNPG#@^TB:Z:,#:GTN&>=3IcXYKb4#aLG#ePBPa]GKHE
JegW7;_3fLbL:1]RgJT3O/Q0DZGPERPB38ON4F&@/4IX:I.Be5([HA(K,#H<<G21
?6@:2=9R2=_KFY=-OC/WcFM/9&9#)=>E4WE(5@M^1M7J:F]P6RK(E&bD3^<fd0d&
?IFW]>449E]M@B7:2H)]BKJFQ.PAC&PS64;QRD[5[d0??I;ER0>YN]]V<#3dP5=[
JL@MfHFO<WgF[9H6[0MJ3>6_OU2Yfe[Y)P_&A;&Wg-BH4+IC[<K,+S7I8;R&LIfK
U8.gPS.aL1;P(gZ^4H9YeR_bU:J)Pe6#Td]/W;Q&^X4<geY0Ve>Qd(Ad]P;S5b>=
+:[:G+_J2LL<K+3]LPOVM+JRVIM;XWCHc[VWR^V.82EYg,LU7M7P<acY00UQT4Q_
KXQgY@dRX:Za,-7V/7b7e#LTe8\)gO0f[PL:OQdWd#)0Jf<:<aYeBfdO9\QZdb0X
DM;C(J#7A9Bg@N>.c\5_[(5/d]2E:V@ST2[SZ.Z1:H(AP9WJ:^R:Y;F2fPA)PHSV
+J<M2N(a(VO=W0RMJ[Z3LcfcDXS(]cYW-[<IW2>T9/0[X;6OR)1CeNG.3VP&U&4a
8<79:gc5W.XU:O2(TAC,V&b4[,=PIaOVP<SXAS2b[B&EBG(/9?)c7-a58Xb8D\e7
0b2Yf@.L_MMD\IdQ;;Deb[FE8e:JCAIKPS^JMa\1@9OdUG.&@V:6]PA<<CB^T[&5
Q_Rd6Ed\#I24>PB&a#C5,NVKFNTPbW:Q@MG7#P^b#WUG@Z^Y/H^33=^+]L8LQZHL
X-M<;JVFcI]G@;O_X&=-aE(J[WE.:EBDWg5Wec[LY4WbAQIec-H)#M/ZW7bHW11&
7Sc2?@KcfQ>@Ec4(MW\G>2/&D,2gd6JPa#K;;=>EO#)PX8?IgTP13+g2ZX_+RUOY
e@P7(P)E+4TAf9-#B78PT8gHWM@(PME9Q-6IH<AcG3)eO^DHReC56S:3O,JaP0&#
3ca1OWgUU,&6<\;[NOVAQI>gI7[\eTIdBVC:5?#6aB=,)Z/J\]K,5Yf\1N/YQZ06
[=R^21>MSR\IWXJILCcX4S-EQOaKGL.;&B]YH3c>Fa-A\_G]aPfNb^;N6:XdKA4Z
N\G8f0CK7W3>CW9aM>>O_V65/P]ae4aH+/eSVP68Gc5e>&:4+2A,IPYQ-6.@4S?5
L3d1b5&WOU>TIE24&Cc]QXHCEUSNPWOfXF]#T:6TFQL4b;N98#\b,=LHKM#.(+D@
WQ24HHZb5L7BE/70=N,\?#JO.2IXAeEZSZ8Ue4J48<C:R6ZegI7b]>858-ZQ/,CY
X^1BBV?fe@KBZ@,IP2RgM5YOPNYI38bFXROBJHRN.6#_#cI>-2SED0],K,D255[5
Na-&5UB9S0/97;HabP(aY#<dRH&;AH6_Hb>MA+7@9c2+EWLI1?3J)_/g82K&2\)Q
^0^1faS?GM)7MA8-?MC0O-R<UTF)e5XMfV&N>4A:PX<+M_5?dR-ffFI.G@A1^6f0
R#@NQQb1E-+1c,2cX?DDM(M<E?H\2@GaPfa\B8[:67U:Y6_.V.FRH\(1>Zc42B4g
e6LPgV<W:9Eg\5TJZf0&/U)G=;O4@M:K?B=TKBKJ5TUJ07aCgZ4;W>Zd1S6@+M>f
)P;@2PPSMf]B::8?KcOA,(,B]PIVONJF])FZd7Q-WI7aWC+Y,CgH<(9d[_\\(SV1
AL=V[&Q-?(_b+]g=P^=SK@=dI8<+US+V]953#?G+_AJgO:e0@#:f7,c3CT;P)PJ;
\_&2BR7WDB)Z57U-^Jf,4)@T#;a&Y8^O9[(,;L;+;E2WHI[/MI(g+?1/cPb6/.T1
c;DZ=-HE+[H@D]4VJdf@]e_KC&+@:aQX)Y5Y#W?R62@)0@CB0NUFZB?ag#N@QLUR
2V#b:PZ-_NcJAa&XJ[aQb0.X5Nf/_4T;1dP/2Gf:W.[-;b0OE3-)VcU+^:U0#d)G
:^/24-MI>RMg#JO3D2EcWY^7_KA[MQJ6a[a.VEVB)Q75f9.SORUdC++_,OeC_KD_
X-5JJSF4gY\@gd:_J.FFLEX7?XAWIOF+]72W&RCeO-<&:+Ob=EXcWJ@/:&[,OS=V
Y\7J_V&9X:L<0GDa&.c]OXM[@Z].c<(:FBC]PCPI,):360M/+&L/ET?@_X@Z#16f
-0ZU-?B#P=c\C5P)?fCb28Z5)[RFK4U;-g_95K/E?4.XaAC19O6E(=[>b[V#?.YB
7ZG-PfFP_C:\M^^V8;\N90ZeK,S[[dBKVH+(FRQ:8IF?2G/Nd.dM/-MB)g37T@WL
Mb5YP@3PVM0@X#]O.9gDN6L#IAgNU#K@:>9PL/NZ42--U>bLN7Q)CKf?)\:-E15Q
C:&\)M&3.g#Q9@>5&IJ8\c7Ed-GRT]^=WR\PRZa\YZaD?+>e4O7JY+g0-fYA^:<2
?#(e1MI85,LAPXfA9dP8]<cQPF)Ua)WO,2d5Uc9&-e4HY7M:Eg]ID2V/1Vd:=:9R
RB>JJDM7eUMCA3?KMD_b2I)dNL6/G[0.IX,+DG.G)>;Aa5XLcS#Y?GgU2+T?GM>6
G&_+LM^(Ea=Y,?1ALK-A[<NbWaFV\CBQDDSF^<8#:c)?U_]9DPCIK&ER:&^=I+HT
G++T^\AQg?5112_\,=)L&b+ZPeW8TIcN4?>/WA&I@@BCf<TOd251H>MIRIb/Q0\.
Id\H=e@DH]BXRW//S/RE97)7HI]cV8I3PGAC,9D.7J_)I&V&T[6LW[C<EK<L&[5<
d)X_;\/72F7;Z&QVU>PCIKTbI#^?=JcB\cg[gZS^#]A0+&U:PJ[V1DeR:O1\ZAAN
;2[,0?.E\T/Q-HXgJD#bS[E#BZ=X>f#P4LWB=aYWgC5HYFfgg?d?UDKdSJ+LJ;AF
V[2P?OER6#GX^F[O@T&#^<LF4K]e6^R1HKTaV[a@b=@L/>?O80=T8VK&DA2@IM7X
c,<B;TK6Te=:^NNEe&AE(/9UQ4Ld1f:eR<R[&Q&d[_D4DI4JT.:4F__E8H.g[a-R
=.PcI7b+d^:@Zd/YI\/N]GO97I_L7^<J>).]#9:3/ffD5)+L1YDRDUa.IeJRFb.d
N[2;Fc=GN]&Rb\=;G/[71E@O@T.+U=eIZFLD_V_,4?VPKID:1J(N?(SXU&dLgVZc
U4V3a/,RE;UId:JS_b46@@19DH>@d+Ca4aX27GOWV(T:]L4@Z_5E-[2g0MM3?.WK
O5=2dQ\Q3P<@2^OV>-_@1C_GIRW64E6Q\O).1:fd^1^VC&A/Z7).7-_0Qc+4@I53
LQ296RNM0>5^9#BK?HZ;@4f&NI:#We[-DYB::8WXJK-J_L6JP078>Me].>B+-b@.
\;O+CN^c(_@69]NX#?cYOaJ2[K2YG<LfPT?E>\Q?EF]+bOYY#fJAcCJ@Qc)@,^UR
Q0^&ABRfQ>M8AK^[cGf4H?R69U6D\E^<IgVXb&HSIeOPW/;_;CB.ALQZB_PU2bNJ
S&Z7K\2<?3&VFQC;51XG6=?T^-+B1GS0:MXI(INP_=ZW.c.Cb4efM(\0S&9,0e[@
HYO<GbDM59b05[H(J=+(-,8A=3;5^GSX9$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_SPANSION_NONVOLATILE_CONFIGURATION_REGISTER_SV

