
`ifndef GUARD_SVT_SPI_NAND_FLASH_MICRON_TOP_REGISTER_SV
`define GUARD_SVT_SPI_NAND_FLASH_MICRON_TOP_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP Micron NAND Flash top register class.
 */
class svt_spi_nand_flash_micron_top_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** SPI Protection Register. */

  /** Used for enabling the function of Write Protect Pin (W#).*/
  bit block_write_disable = 1'b1;

  /**  
   * Defines memory to be software protected against PROGRAM or ERASE operations. When one or <br/>
   * more block protect bits is set to 1, a designated memory <br/>
   * area is protected from PROGRAM and ERASE operations.
   */
  bit [3:0] block_protect = 3'b0;

  /**
   * Top Bottom control bit used to control the Range of protected blocks.
   */ 
  bit top_bottom = 1'b0;

  /**
   * Control bit that Specifies whenther Write Protect/Hold feature is
   * enabled.
   */
  bit disable_write_protect_hold = 1'b0;

  /** 
   * OTP space can be protected after Programming it by setting #otp_protection to 1. <br/>
   * The OTP space cannot be erased and after it has been protected. <br/>
   * it cannot be programmed again.
   */
  bit otp_protection = 1'b0;

  /** Configures the device to program OTP locations if #otp_protection has not been enabled */
  bit otp_enable = 1'b0;
 
  /**
   * Configures Mode of operation/Region to access (NAND or NOR Read MOde, OTP/Parameter/Uniqueue ID). <br/>
   * CFG2 CFG1 CFG0 State <br/>
   * 0     0     0 Normal operation <br/>
   * 0     1     0 Access OTP area/Parameter/Unique ID <br/>
   * 1     1     0 Access to OTP data protection bit to lock OTP area <br/>
   * 1     0     1 Access to SPI NOR read protocol enable mode <br/>
   * 1     1     1 Access to permanent block lock protection disable mode <br/>
   */ 
  bit [2:0] cfg = 3'h0;

  /**
   * Device Lock Tight <br/>
   * Specifies Whether Block Protection State can be modified through <br/>
   * Register Write command. <br/>
   */
  bit device_lock_tight = 1'b0; 

  /** Configures the device into ECC operation */
  bit ecc_enable = 1'b0;

  /**
   * Specifiy whether Read Page Cache Random command is in progress.
   */ 
  bit crbsy = 1'b0;

  /**
   * For 'B' Generation based Devices like MT29F2G01ABBGDSF, MT29F2G01ABBGDWB <br/>
   *  0 0 0 No errors <br/>
   *  0 0 1 1-3 bit errors detected and corrected <br/>
   *  0 1 0 Bit errors greater than 8 bits detected and not corrected <br/>
   *  0 1 1 4-6 bit errors detected and corrected. Indicates data refreshment might be taken <br/>
   *  1 0 1 7-8 bit errors detected and corrected. Indicates data refreshment must be taken to guarantee data retention <br/>
   *  Others Reserved <br/>
   *
   * For 'A' Generation based Devices like MT29F1G01AAADD <br/>
   * ECCS provides ECC status as follows: <br/>
   * 00b = No bit errors were detected during the previous read algorithm. <br/>
   * 01b = bit error was detected and corrected, error bit number = 1~7 <br/>
   * 10b = bit error was detected and not corrected <br/>
   * 11b = bit error was detected and corrected, error bit number = 8 <br/>
   * ECCS is set to 00b either following a RESET, or at the beginning of the READ. <br/>
   * It is then updated after the device completes a valid READ operation. <br/>
   * ECCS is invalid if #ecc_enable is disabled
   */
  bit [2:0] ecc_status = 3'h0;

  /** 
   * Indicates if Program Error has occured. <br/>
   * 1 : Error Occured
   * 0 : No Error
   */
  bit program_fail = 1'b0;

  /** 
   * Indicates if Erase Error has occured. <br/>
   * 1 : Error Occured
   * 0 : No Error
   */
  bit erase_fail = 1'b0;

  /**  
   * Write Enable Latch indicates if the device is Write Enabled. <br/> 
   * This bit defaults to ‘0’ (disabled) on power-up. <br/>
   * 1 : Write Enabled   <br/>
   * 0 : Write Disabled
   */
  bit write_enable_latch = 1'b0;

  /**  
   * Indicates the ready status of device to perform a memory access. <br/>
   */
  bit operation_in_progress = 1'b0;  
  
  /**
   * Die Select
   */ 
  bit DS0 = 1'b0;

  /** SPI Agent configuration handle */
`ifdef SVT_VMM_TECHNOLOGY
  svt_spi_group_configuration spi_agent_cfg;
`else
  svt_spi_agent_configuration spi_agent_cfg;
`endif  
   
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
  `svt_vmm_data_new(svt_spi_nand_flash_micron_top_register)
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
  extern function new(string name = "svt_spi_nand_flash_micron_top_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_nand_flash_micron_top_register)
  `svt_data_member_end(svt_spi_nand_flash_micron_top_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_nand_flash_micron_top_register.
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
  `vmm_typename(svt_spi_nand_flash_micron_top_register)
  `vmm_class_factory(svt_spi_nand_flash_micron_top_register)
`endif

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Protection Register */
  extern virtual function bit [7:0] get_micron_protection_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current FeatureRegister */
  extern virtual function bit [7:0] get_micron_feature_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_micron_status_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_micron_die_select_register();

  // ---------------------------------------------------------------------------
  /** This method retrieves the value of a single named property of a data class */
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of a single named property of a data class */
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Protection Register */
  extern virtual function void set_micron_protection_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Feature Register */
  extern virtual function void set_micron_feature_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Status Register */
  extern virtual function void set_micron_status_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of Die Select Register */
  extern virtual function void set_micron_die_select_register(bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the Agent configuration object handle */
  extern virtual function void set_cfg(svt_configuration cfg);

endclass

// =============================================================================

`protected
[41O_F.V6K;L.=0>#2c?5U@9&]ES+=CLP2\;64(ITE>+KNYQG/-T/)Y9:Jc4e#OM
I,#,>ATNO=IdY.<gDe,^2V]+[76:9acgR_LL&V/N4S?a+gN[(\H@=d6OBL-BU#-d
eIFe&-YIcaDeB@53[DF]S-,)KJM\<?eeIT(Ica-1:a\)->b#]c)Yd\bJf-XYAL+I
)(._?.JZYaW,d:F,M)\(71EE)dA]0@(LP,SGeGUZ5gWc]A=(74b64bK(b&98T^@Q
D[g?G&Jd_^S(:15FYY?0QKJ/CZ/7F;ZD.I]2IO91H/F.MdM1-^e07K\.7KS6MAeH
[L3PdV^OE8<d,B#gRaJ&+FY7fUd[ZI)&1[G=a=0(;Y+Y?O:6JJ0_>)6MW@6Rc87:
;K9NVNTeDLK@-D=D4F&AX6L+BW05DXCM2bY><\Efc,ITd(_1ZFNYJ:<@SE=2#5N]
^ZSX>_P\g<C5:^HCV)5RK<Kf/J&?SW]H@S1UU,N68A.IQ-WX8.LN.<\WT4CR-HTA
2cEgU61PJ)f7c8N2?I@V-2RIWT5)0&GbN5GaN96K\6=7C-6KU.H[AV#;OMeB9N23
PEg4AYdK>>TR^A/<e7Y^4R<bZH.B0L88D:]YN95fad3:8OCOf9)>T6+8?:#La?3^
UH-&L^a3/+=e0RW<aH2b<>1.d9aOD[b\f0&3,F[J3R45f-ITc9E^3+ADbd5f3T(e
;WZ5I?+2K+/e,$
`endprotected

   
//vcs_vip_protect
`protected
-dda=S0Ia&[8DR-8T2J)cIJ#]N3<CX>,E)_f]5WN&[gF/-F=O&\5.(SVTV]8NV>Y
J\I[2ZDb#@bBRNJ1bVJcaEgCe]K]HBcBE:2WI//<X@&ANU5eU71L3()4&SEV@b9e
2)UGV:Z=3/bbP/[7;eKY6bKNe0gCa1Gb7U50OT@>+&#HP_R)KP\WffQeI=Kccf_D
-#g\@(PDVc>d1[^RE?J?JAG6K<YGK9O1HAEK?T\G-<8LVVM)(BPfG,U61J=W57BF
41I1WRAX/.&,_fX>4MTe5N]Cb5)^8APJF42777WLU==?P[9]Rfb2OR<dZDGg9-F2
_eBJ?<:[33WUCD0(HL)R@]Y\#f6M3RRcSJUBV=)KaS/];ZbZRcF46d=))RA&a/()
Sfc78^cR-+RW7?7Q4Y/PK?IT&Gf>.^E6Q6[Ya^9@RKVLV-^@S#,F/0Q&(P;=D8X>
=P?f[,QU6/f^M<,Q^]JaP:Q3GX?SRg7<:LAA)X4(.F3S&0#(M<&^^b4d;<0:]RK.
:G17+/TP_,=a(&M+b6cYO\gfR-&1U;B4fOX&2LGNIL<-)33=H(42bf/NO#.Q5Z/e
,N^dO7@R;HG<_8BV=JSI?db85?a^-61Bg)(Q1?b]_;6KNB;&.9I=1L;9J>3R5U.Q
/-9/5M62)GR4B&KaeaHPZ(][)/a6fc](Cd4RGcNUYgEH6;FWPHIK#+HYN3E4+U^B
S9XWCY#N9;eNBGCLF>G@Q8[^<X?&=6UaB#,B<EY?fQ0ZVVO>)eJ=J2f1&f.e,^I?
0^HI8_N=I5F_0HXaU7^C@_3W.V7:P;:OY?/(/:2--cY73R7>^cF\Z-9#.XHN+_Vc
]]6L.=_#T_G?[@C=1/7:7[VFX,NV,9;=OS^?dg+?D+)gG(Yg7?4ag.&3FE06-_U3
EC?96;JdJLQ7).Pf&fY8#c/86Q=C,M<L&g]W=V+Y^fgN5\RGNbV.J7XWRW81#ZM)
F#TJ2:=bXd(c(b3ZWcP#^]6^BGb7?Xd?f6?;V^SZ^Q@=UJeSRd7K>VLO@6c/G1YG
e3KX5HPH=J3gUTMcT6K-g2\(=U\2B-J[#@2UE#-M2J#FV);+C6W51DG2YBU=6,)f
XI7]7Y5YG<H,15B8Q:I_NJ-52Vc:TDSB3@[O9KW(T+e/Q-6M>APWDAb^/C>OI<UP
9QT4DJg?c_dNcbcWc>L,2Nd8VN\e;eNCS(Q+\[R@G1T^P)-=B;:634Yg-D.dS@#f
T,=FSa;4Nab@beNDNX9B#G2EYd:GX@4M-dOEAdYLTgM2NDg[&3Ka\c8b.9XR>;g=
78aZ2d<?@gb7\+;B+CULTR6V#aE>G\6)=X:5R_L0R4CPH&L8T.MNJW/9A,bg<^[P
Ge0JQbM^G44cca+J5[H_8EE13OVBAgNI\BE(IOfJI\/&8W@c;KNOa7)3NA,dUD[Q
PC@#G.(d<=0UFG-=H.fO@4HHCP9^HOBH):42KQS9_AML4]ZS6V=>_Z&RE<B<-[Cd
+;OIaGKU6I6_:A[b>?,Y42Fc@9ND?B8bFE2J.)dN(/TMIYf0c_J:V_>@<YT(FQ#Z
OKg5<6(Q1SKeAV9/\V:N4:S&MV5;WXB?c2P=c#AbbcRL8AEYJKP^;H_(K^W_DR:2
g;^U4LAaN7)K:?:c=RTeaaXYDc@;DNOeF1+&O^(UHU[NCOFONLO3QbZb6G:cYESM
_VJ_[/X96S05#7VLN3>]-:&>73MXabW&-MbH+a[Uc1=9+4YSR0SK1BJFA(=-7@>G
T[VA9g,WWfC+4S1dQBc)73\D(S__XY_O)Z?GL#E1e(,[6<OE2)])g_0++c1J9c70
J,<<+e^B.M(5AC_S0GCb8E-FGLE,L/_PeG8Z68?W2UJZ_-#82;^Q#QG>)fc8Dd.@
X9M9O>LZ5JETef35;gSD+Mf_Q.;U7F_+]Z7?Q@9c3CMcafXb,@NIVDK8U,OS9)7E
-;7cJ4\YdNa1Kca<g6EG]YYK.DWS)gBB]^\_PR[ALP8ZL(:N>WL]<4f6&-H=QT?\
;9=8\Xc#dQ?WOAO<(/2^f]V+,NPNN[f/HJeg@Z<9&-]LXT9H;YZ7Tc>27MfA1AdL
<27fDJL2KS3.^9.-,=HTTMO/I,\L\1-3PR2_VLa>e:;J\G+9eYdZZ-\<c)SD?fY,
Qa><Q89bS^5W?IcQ?<fGQ1OLXE5SS(/Nb&c-(])^IU0^1W7-E<#.8:a+6P#@P\@;
>aPW5,4d^I/0IfD8V<W3Z9/4(TZgdOC//)<dL\b4G4Ag[(4\N,J&ORUA9f,2ECAd
\F)CV>F@DJ8RCW9bb1@XK#eSW<WFZ&D1f1/\<-KL-^,+.SgU6FCdV^PcB(_)L4JU
gF:3DUd.=@O5T&,K&4YWc&7&Jf2:bg7:PIINg63L7)c^60\@AP5Q_XLZ\DG<:[8g
9e7FUU4VLg]^cO#+86:_]<1O>0Y#ceD6=Be4:3,C_^PP?[aZ(D/UAaJ&-R-;cW#K
bK69;bH?+ZT.\?^d<1=cJdeSB7UPfU^A>E4:EAN0KfZZ4YcD23._W\\C7Q(F>\>_
L[7V5G/D\eNM9g70N3[-<F3YG7PF_\Wg35^V#UY7OHdWZ<c=W\C;925#AM6D5?da
bP/EB;2C59f?8RDBML(S40\O3ZDfeHa(:R_\G6A?d&SYV0F(K;=GH?):KRNJ5+)Y
g:gd(&>b+OSYKW[:VI=(_-+&-gS8B6]]AV[0<>8e:<.KN(NT[V#-Y8631OdK3M9+
[c[Q#107g2&5M<>OZSRa+BTG>4L[M\JY\E3=.[/A7cEd+-JWRfDX^R=&-++GNG,^
bI[)^1Q2Y3)aKL7VT\LJ<6[>?1XO:C)35K?PLHb,:L8=MZ?0:::Z3W3]g<77SBgT
C3aGO@#]5VI<FJCX,HAC:K5;)O+aV<@_>VI)_J-b)W,PCZQ).X\KeO6=2TKaV0\F
IgV6#3aF5V^)QVbHD1bC\gPE_J_Q#c_eQ63)Ee9V[cC\_+++5c0)5ZYcG_<Z1_Pd
[4,]Q]g\C^CP5d8Z8ecY?8BR&[^Y&1>_@_TZOIER[NIfE4YK?5:._9+HbDP3?,0[
_9@<\N&FLc8;/>b_4:N#H4.2Q/T4[[R_f\8(=,R+7@609aR<eH/Eb.\JKb#+C2S<
_J9V0KR7dgBZJTd39-;g59cI;^O)?OUdL8A^g?1[+]3+E].W^&MX\DeEH\@TH=EO
:P]/Z-,:?_DA:E?+O4D(A>:8F),\6_gfAX5Ha#.0>GTKW4HQV8_OKA=[K>ZKZP\?
E^(:V9=cD=^A01FT0.(N><FZ-U(;[5?<ZP9cc^+HfNIMR/f2Y9;[?5N\D#\:K)4e
d-ad-+_])KY)X+;4^Nea37Z;:JO,OI8fd/<SN&?[G3B&ccR&3GDV8TP>W-g(UJ)D
9e63a&Wc[,-ZAHH2bYC\UZeaRa=0T1=DKQ6<+N;Z4:N0#I8aI^GSD[-70b@8,89G
0PdZ?W8I]56AdAPce6:<?2(06Z(+E]_2e/T;?;ZHe/cE=b^H_-L<gK9FP=;(QN0,
5]&=HPQKI]76P_&O1^#79HBA2@)LgY,O=P(W><Ja+ZKMZC^>G@WfH/\;XSPH#@5^
aHMV_gRde#<X2ESB#D,9;A\D:96[[D]6&f:(cG?38Z)f0(ge5]Z@OSG/.YAZK3S2
R0[0FCU(BU\X/5Z(5V];E-YE)cb:+>/G02gMPW\,L0L(59AK)XVF<9b-M8cOA(V&
L#E5MV:HEADCCJJQAD5]?dO.3<SO3G.WOYEJB8]MG#Y.#\=3EcSVA1XSQ<Wa]g7f
2X-Z):HKH:TGNc:1__0Rc2H:T)gcZX=LA;)Eg-^)eBI,J)^4BGggS[\;4FQBeP&,
Y7\-&F.)Y9KLG;059_H334N\LV@<2_KG9I0EEgIZ1&0;73^&#4_))^=\>BT4DR4=
-.aIA8-CPOKK4T^gT7I,\HHad[3BE01\;?)ae#<^:Tdb]C>AMEBEV&SL(/@_5&A=
;3ORZJ;K>fRO\F/#>RF#[2GY:EN[+^JJbc3XR92bYVRW@;Y-d75M^AQ-?c\Jg1c+
aCcM?<#2JLa-SaTPX2);?3[8CCK@5aAf?164JX]b.&bbaPZ/G^#P-<K(\U@b]ZeX
VbSGNTMcJdL<)QFU8e#/cR7^P-U9PM/9d\LYE34;ef/5e:-<F@fMU1bVAg9K5FQX
2&7K00O(IZ-XWb],=KD\Q4VFe6&Y:IB_.gI#KVbg=_+V)=GK[-8XH/N?O_ZQ9XMC
bNF?[.)AP34;I&NUKTR1?B1D04AgG^TN6#geb;3J+8<Xc-Q<\=&(.)Xf0OTQ&>O/
1g?HK.CeaTc_23Q77ddQe:8?)f[7.=RNJcCFFg(I@3M37B\5]FK4^B+8\>]]J[A\
DML-:V#1P\C,Ke/0eN/EFcI]:[/.7HRLF>(GQG]+]AEb)TMZ_0f#F)AT8CfS^d>,
G7bU?68OKfHbB[:&8X8R&2K??gOgV73HJ/^1?ES4DK6YMCTN6JI#+B+;aQd<OZ][
2T2;63H7]DegfPLJCf)\0N>Ka6KX9f6;S#B89>W&-XXE3<f-#V\?Cd>@.La:E,J#
C,G>,T9?VNe7LDAS:]B;]4ZW+,dH^J-3:AH>V8,9-W66\>MM;>gf(VB;-D)Y=8H:
GRHQ#ZOB@++F@A#OLE+LK1a3e/.>FOSOa(GI3f7USJF\R-?.9g#STYbA+D@4CT4L
)F6@^7\;[(QIe#M(-^Af#:VNba;:\945<W@F\B16MHZ/IR3?G83Fd&RSL.Z8@RPT
G^UX#(D#:0PC]LL0]V=Me2FOe_(3M>0Xb.3MMQR):VD\=\H60F,2@727T:(5Ld?>
BQOS^P/Y.\ID-DI6[PcC#N\/=>=;A6SO9\GP?)W?GO8<Z1./RSWS?]<HdIX1ZHg2
8#P6P-)cFDYfSdg<Z5S,BPFWF\)K1QPPbG<\O^QVCd0KE2Q;@4-BDZ)Xf(-M0[A,
f@J3J@@:\J_>4#TLIU=>G.;eBbPbF?4H[FYGQWJ=FVW&I]9@&Z/Xe55:?2(5?07N
9Y9?S#V3FCLAd#H[:K&B7bZK+c;V_AYcS?gO2bH_)/.5LK2@3dI)aP;R,N6TTB;J
g-d\O9&]<TJEH@21>)^TH++UdV5T6)XXg#@OE9^=T5MUH^A+0Z?[_,c9d1^^T,(@
5M3])gIN/LC=PbYTC1P4^.e7GY-M-3eUOTK^/]gH^)b\-]>YXNL050HdY]K/:bBe
+Ce:Z;6UJI/Qg.A(IdE0N]f5<UC3H^&RZQdc[)4G.47AWeQgZ886)=a)Y-IFWX?W
;eWHRAQM)-TH\IR9[A3)L29\bOMET8ceQK]0>#]C;Z@5^ISfOcUc+ZW-MJQQNDG[
XN/E9W/QA,_/VR[#dff4]D/g;dMeY79-UM3C=g:\VI2PGVQPA:bU.^?;+^0S1\;&
e14Y/D]M+Vffe3?3715R>AcHWX>#B@QP4Ef:DO]B6(5AbEKRAEX9UZ0[YO:EabW1
1Z]e0\]\]8MaG:H31Ca+a,VZJ]c&(:bg/O=6^<3-_[>0CWI+fOfEeAV3L(D&:YU,
^(V?BLd<7,U=Q75N;3Y,F95<>]S-aERA@T<<5D#8;YMbAU5B)D)S(P-S<-<O?K6c
Q^T,,X,/82.^FE(&/R[63#DEdPHFABT(?Za.4>7:gL@/R]Da>Q+E@^=M[FC]C_XN
M,46YY9_Y7F6U#93Gg>]aA7XE1M1DRHYWeIZK#_4GK;OAOe,=?T3AP4=T@M-LW1b
+REZ7\TDgJF/1E5SGESgX3A^GI#1=ff?BcJ9>b90_?GN<H<L.0XJ>ZBN.+:5>f?Z
a5@Uf0@]0T/QUD;W>>8QE09&2D8TJZa+\E@FTYU<7_)7K+:2QIa:[?WOdG@GOS=-
H#-,b2UcZ/DP9gEa0?A3E:-#abJ;-((W:FZG/&dB8MUV0LN3W6V\PFTQQY-EC+Oe
(g#U[Ja?8X<^-MG.@V#+e3R@I,K\&GON:;=XFa/:&TgVJY>=L]\/Af&BA/bDXC-E
S>#?+=R5+::PE/N4.MU39<bK795X/W(+BdcCTf^((_WSaQf?05Mb]RJ6O-^Y.XJG
\Q)-9XB\W;C>Z;b8?;RD21ONSWS&,3-=98-^HgYeYE+-Cg,(.E]9[P-=(1J6VQ>e
bUC;V@N1)KCT__a]=AV4-Sa6U#5gHX]S2.W2Y3]418W8^RJScB2]0&F&Da89E7[9
OY>E@X[e5A<WK19B^)Q=;9X1bF(9HC_1Gd2GSe>[8d8[(g\UfPSbKK^+)_PF5Z8S
=_b\f192IXC[><d<K]X-IY</8=X#GKM3GS=7Y>;?bO-:;8]A(b^Uca^S)Q&GTL(G
342S?^8O\9=[P<:Va=CH=7,IW?>KQ9dRQJ:[YUMgW1=@ND:9BcYD604P^N?KceR>
WLf0S0&PDTeLHM7>cM?1J^=KfU_>WB;PUU9L_S(31BB=RPa2(aQ<@G_F]6,FQB]@
:D(:R[WJR)?F&Xd6_-I35G7#JI/S,HK61d#MUN2<=7B,E.IACce?YI\CMe.1,=4D
abGR9[=O-?;JGO<>1HQ9UZOgfK>36NA<aHXZ;;U1X#9E]BUQA5;8DbSMPK&[NYY3
NISCT<afVK(8df-;K6:0,3@E>&4Q<TS(O5T<+1PFCTT<EDd]eW-G,\.;I@G8WG1d
,>b?5/MV2H#.c4B0;d=,HV+<_A]>OVSTL((R3fb/<P##HMgCf(L0&.VJ)Y:/.GXf
5DI+KYcGId3+7H3W)MC,e_^4\8eM&@@PM0K[LNSJ5Lf#\O5b,D(ab7Q;cI?9V2#S
gUHZ=0D=FWW001I:Zb9fb.5]&L^9E5g?J,J11<BT^H+(HEQ;]F)2^d<g?PTB:S<a
/QC(#-;;^+7WM-T&2:/6AWa:9Egd#)_C-J0g#G6-d7<G7,7da4cA:S5<J0J<?W)3
].,AB[]OR9;A5E);:IXAA+cWO2P2)4d:TR)UOO?7[)Yeb<59NA5+)RWXFHW8T\&R
Jf28]COS2(NH6TQZSf2#(/f&U7,eRP+=.gF\a#EQ2aQFEXE&ZN7fHR@/&=-O(MC+
&&V?,4LB\D5-U7&[SMN6Hf?W/G@f4aA1A1>?+HD;36T.HVb_71EHAV4DI)OgO@YI
bCbF&&\/[,,CYH460[dN:@4\\eKCZG/f^L0,AU,f:YGDdMWPdJA3Qc8McJE;:@4F
:O,d&P936bBgL<)]:M,_:#?=d>>U_80;=TH]DKP=^6-Z?bWeIaP9=E6W9#0?4W;T
^,-KQUL\CG+4YWb[ERdJCTG51S,0K]Y^4IUcGN\EMg2=4I@5U3K/E_aWMDI#1.\(
cFV&-Y-.f/W:1,M[9O&>)BUbU>\cVJeD-=g=ZYH3<(-=;=X^dMZ&gLSCJ1_dA4IK
)S^^W7VZ4M.\B[P3[E0[5N)O.]G:>B,@,1<fG.AE1J2;EQcBOeGe^.TaR+>C+O8c
d)Oa)(3B:&PRE0#:-R&();FfASOW(RC+9+cEa71]aZ]IZX^H:4)ffE@)#\0\.\EC
IJ,IgHVK-D94Yc&/gfP8J=RJ6E:H15GaedD_6B]\e7=b,9Pa#^V6&UJZN608YWH5
ZAIVGXe]O8@MVO]3Lf[CS?K6F2CCRB(,\[eM?:JX@=QY=O?==^;0N,EB>YQ.TMT>
/<6FLQ6XM(>bAI?_^f-PW4;V&7?6?b8I4.&4aI4E#3[(6JQ^L.R6AR8f.-><VF3\
18=Od9GI>KEC^,X.->E,,IgXP&(1/X7ad4N>\Cd6Mf6c4?g,?[d4\R]1W/G(9<c3
<b\]Fg0.>DS_D9(Z;W:_Ac\PR(VE4CEfRR@<4,J;Je^ZUJe2#7-5C9;e#+_gZDV>
_B&#A^0DQe[,?<QT&_4()LJ;T-W^7PX4=0B0Ag4<f1A4He,4QVV;16;dMKJI;GE&
#36L#>6RUH^.dT_PVDA3LFOcNT)9g>:+KG;BNF(IEbR^bWMObR<A22WV8/?UHCC6
E&_H;TA7?\YG+[G,8K-1:7>>?>^>C[_V,7?L5+DGM2SPI5E2H2G6JJTJ2Uc#aAJY
>3P>Q>K\Zc2,9<6+BQW=HFD8+<48(5()0\<g#>THL#Q=2VM8R5-]4X[aA>c;1PNP
Z]0(aXJXf8W<3N0]d2FbM4>ga5WCTKZca7N3[E[8O8NZOE7bF^)&a5;>7WA,563M
7c_)O4V.Q3-\Q.f:3LC57FB/VQ=W)D0-.#QFD[_D@(-Z]NUbF[][f0S@3e@YI_dG
O]=_\)ad^H@8Jg8VMNG?K00.4Jd3g5aa<OZ0ZS@30,De_A2JPYb8#&]d:B83IKG6
YJPTeJ/fY21@93_38K6cKFJQ#>=5[,5:WIEBFK,Q<)5B)S]E\bFCNA<(AH8.QIM3
;G>;=W533<R#MC7a:_@JHXff2Ia]01\V2egbedR(HE@De&FC)G?;R4?]#?/-Jb_K
79OD3[(+Y4/KQIWX2W(aN_K7,/6V(^_)ORcad9Nb7>dYcYRabab4fCc9D:^2PVU@
:7EBRPcSdc.ZUW4I_M\e<MUQ&aX9g.DZAB41U=c?57d\RK_FY4)09+([,BNQ;N?1
S4,Y/T5e0RW(@C1#]]V@C5#44DH=]A<f_>bO<<8GJa?TAF/>BW_SN)^I>aSPV[WS
/[RQDB9a6CTLRU@U5-T/;Z&OV315IS)b9dR:FZH-&C=27QUg30A0T:BIgL:))VZ2
^/KI&86IAKTR40(2N_.T^1&07NFH6d0-dTD^c2(ZVT6_7]^[95dcAIe/].HA\].=
,G@Bc[BM>gdVZ;AMA7Z/BfHN44C.YSD>gPCC-.I(Rgd\VG+-&EL]<TccIRL9SK=&
.RS@XF[QS;OYGW9\05XDPZC<QC9NAN3QS53O=-A7<TRN[0<^b)S7./<e&U/Ne?/<
fO[YY?dfDQ/5JMbW/\^fb+#H4Ie_2La&ST;]-QIPE0]BV-8]1_:P1@1N9F;>G5M9
R2V-.([=F.;1Y4gM7-@[(P@,(L07R0bE8Y(3><b.2=#JV.IZ<>XbSVD5)X^^@&G?
Q&&NcUK>O08J6B+Wb_8^Z[_]\_1C,J5>;E713&PR]d6OJVQ0:bB<@,S8GXIQFgR_
YG#YPLH9;8W0X:(Y_4a/7#V0R8AMG<;>UeVC[)0I5J-2DTS<8_f,AZ:Q\^]V_E&&
>Ef0M?UcaZK)-02IB>d;A(L81XfQEU6KTeH4I0M?:&4;F&[>:4,QR]BM7>6HD@,L
X]fLC#]5QTB8?\HeU?K6<V/SHY(eZTKH#:?0Q_[3-/)SdFd+NUZ#g1&CdcM8)52D
;\+I.Z4.-8<^fH1)CK&,P2/)8UJ&PTXD3S#SfSGU-g_-=5S@>X[O8UM\S3_4R=S,
cg;,^M5]].+(eN]CP<)B?&6Y&B<YJ^O7UL2a2XRUZW\8=?=T6Fe_(1_>YU5XE#cb
V;G08:D?9U#[fX:+Q?>:.Zb]_6)DVIXY;A[H/gCSN/69JG.#R1CAcEGZ0VLLc/?Z
L8<M[>b(=O/DD+9.5.,fcEF=@Da3,BD#+Gc91?#N;O@:8IbQd-g#M7-3T<-N&6ZQ
B^fN<UfDH9-0JTc8f4PTK9J^JObPK.YAD)G@J92M)2Z8MH;XVC2PLVU<2)Y\GSU@
2AOT<L44,&ENZ28:bbeVgM9A\FKMM9P??.2+.c&e(aLAL_?YHS8MAP))TF;+I.(5
T+GD0b^P@:#BK5G6[N]R6VTDL,60?EC1^\2&F1X+&624+[0Z<&:LDEWGP[Q4-^3)
#e_+Z&XeEa6@0WgB+_3LQ7G\0)S#;F=Y[,XY_F@UB327e];Vb4.d8:AAS1>-4M5e
\+]2OM324XFO@_H\?ISFNfD]CYW?X?ZV6M54MASQ,XeT/L:9N)HZ4WSOO@UU(U?2
GAUZeU6O<,&Ue>)\fa?I6N5E9/.D/Q:]FM\M=+fB[M=_B66K>f-6]Id?]-5VQZOD
,ZUG]R,)-b,2cJg.BJbKg3,ZDO<PCD4d@IbG_>B.D9F^P8Z#2QfU?2-]cATAAW5I
AN:U:;6Re@PG1OFBI]>ECJ7b_[>Q\XIC.gKcf6Z0^ZE/NPUJKO9SLeJBWf)X[^35
(d,cJ.?b,+\)S(O.PM_,0-L0<<RaJ2+.^H</<)4cO3LbHWB,-&QbAG/?TJ/V7b&]
QE5&AQ=05[RL+;.d-A<>)/4-0O@?#X&e^ZY;0O>4&XW=11MbMbT\Z8Q6Ye9;L6TQ
XJ(c<DLN3KS?ZEg#^K.;;WPB[<1E34#bG#P+E&<@^7>DC.[@S#T.a\\cFJXA]QBP
OQBf2_,:C>99FNaAB8IDJag\S4^D>R6\IOIG,9NFSTW<Q6KS0]S#8=D=W6ML5A+L
Z,aeZ_8T91H6(E2P^&XC98[R/5bN>ga6[FCA2\<@)E+&I:.f3f.2PF@60eBWVJ2=
1Re)DNb8Q;3^K.O[N>NJ>cQ+Z,AL]IY#6N<6-Ye5>f7MB=I0F.CBRDJW96TJJ923
TJX(MIU?aE25\L:CF[EOCZ:-C/MccHTcAA.VR\=E)5?;Z<N59;VL365OFfg5-gB)
\>ga7B2>6K5>Rg+@/ICU,F/fS\bQH=E[,AK^@g/IfDaP3AL)[_=[,BeU1+EP1e5e
>N3],HaJ5VbQg7MLO<&TPK1.#;.9;#CS,^75CeWF0fT[^B=\G>,fc1RF80eU67_)
-NE^=&1]-;Y?B505O.=CIQ?1:(K7=]35:[FI]0[CaDG\#^J4OG1JJ:EU6T<GJRTd
<P#,_(4.Q_]\J(T/9f#4323@:W\fS>4)=_O]2CQRSbK^,a(/=F_)EWH7Q>(ATA@=
LRY/1Ed8R@LBJT\U1-DK&57b/VS[gAR-^FR0_^+H;IWfBX[53H9eHc2K\-T4^(28
?M)6@c)-Ee(<B1-GQ5c1K;=&<=WPK-ddN2[d](4<)Jb0\HCHE:,-+YO7bY#[UdRG
cG4c\b/(MR\PP&ObgAI]G/=42V\^^(:g03P^gBBV=QD/?+X<FXfTMU=N2L,UB#C.
V2X0LV&cfT-a6[;.2NfY1[=XIg(C\QA[>\@:4<&-a\>g;(5K-<P]bbUJPK=KTg#^
&Y&ZgUGSQ.?&X,g1>^DPHC7>CQYG>YE#BY45TPd/9ebKA9YB>5(POCJaW8]UcMe#
^IV_9a5:YM&;N2b9MJ/Q\HdT4_HG?CBZ@7+/A+<XM9cH26I_G&IEc[X];a053X;a
V8M[@\3+>f5d<:S;=,4P0UJ@0b2Ldb>72-<0@<?MHJ0/]K((@=d;#,?NOM;\2fP@
?M]4S:0b>B,a\K#Z6Y.,+B3f96>fN)<CR#1bB:A^>c\DaJ8&4McKS\Pg807F1.LA
4c?4EDK^Q(\B;>M<Ya:;?#d<&MQHE0O6F5(1R>Q0Hbg[QA]-Qc)aF52:172.&Gd+
@@1fIXC_;gEc4BDXXX\0=P,I<KcbWIL3V90ZcbO3B@Q[c6fdb>BU.5PGV)d7=/6-
>bMZU75T/A(D:7FRC(J0X_8MG2>UUF@J\#8=,cLY1A,@^F\=FdRG(&&fSb,XN-BX
H?&-gB#U9.Q(]^U_\AF@>9N\+;2DU5ZT.]+6+DO71)M20ZdITGb>8SW2]X0LG7UQ
/C[U?7_41LZD_D)<cK-+,R^];/+dU^)><?-MJ7__d5We1N8IV:,=XZ#X]P@[[/(8
;Gb(0a^2McGfP]W2e6->XfR)EXW8dCY[\(#Pe.7dEa#?6I4,,#IY0cATSOe,W/B>
64-SP7c;(#]&;cOg>=UB:8Q.9@-ZY_2@aG99>N?S,<Edb]P(O/X0g6=bJ,+)[)ef
U@P@;TP:2J^5^:6@LbBCVeO<)&d\ONJ9:d^6V6ZPQ2f[B8,1GPUPJU\NV_R_NDY(
>Q9LaHN+S8@EBV;UF<Y&9\XE-@SC+?\))-+EbK4<(^IT.3_R.JCcDYWO2d&_LC5e
N+G1d^/@#d[>,aCe.HQPTBO;C;\9];dd:S7V/C]H(XbJfR:&d@.=>R5LP)CWCAM8
5f97V,5.60C[LS;3FgU?Q][dJ6(4P\;=OfVN.L)dU4d]BK5fJOB-_E=Z@66Q\C&>
_#.2B:&Y+Yg]YZ7.bd?G:@-6^LDN8X7IWY.IL1I/@VOC8C-,b63;RH]NGePP4U1W
Pg=Z9C&=L(EX[W6#V1M_=;b]927BJ=KBIFH6,+2\4g<UE8g8&0\,/T@F6g5@e-4J
M7E(@K,=2UNW4(,UdP19?8472])#-Y]<F4M--?:P<Ib^M\8P\:4+V=T<:A:[d[-c
\K7BMVMcXC\CM7+5]@WJ-_JL\NYCdUK,fXY;e[FH-d#T2Z=A;S&CX:07LHX_>_=E
0_cKXb)LU^/\X;;(D,2=?(FSY:-aSCEbA[6fPb\f)M^5Kbg5YJV]&@I]04XFdP3#
(Z?(HTKd_P=.0##(E^F[V.;eV9F(\)]g2/#KPD3T:6bc>1#AE3dJ@^fVM.06176?
./Te0aZF&?Gf.N,Q/=Z_(KgPA(-W>e^_:g9&>d0)0G452DQBN@ZH12_ZYCc<+;20
[:YSRf,2.T3:+eD1IPbeHUN@8<B9a[@_a.(UF#1;LK\dd4-7QTUDJdc8LT@6(7?7
ffaP5E,+5A62)<QG+[(H/2d^FQ(^bdY@)+K&=:EZb69;[[MXPO0I:FXTXN:2TbJQ
C?(\gKW0TTHDYJU&?ABX0(_H:6V^2T)Eb5B()H4_aCKBD+Y.515R&IKb.Ng^,OQE
Q12-R+,23[?e7@<)1U[WG+Z:PG.Y49/[,Y<<Q8cfTS28=EO&g]5[A@8faTO>e>9b
W=WRL#3=^@@Z9N9eSUI8Q0:8CF;bE,A)4d1F.B;LaN.A6gL&I9gb9/6dg0,P?VC:
&#T0Q@8]?6Zf4;7CU[_AAa;07-?8=c-BL]G4f02IHZ]F1OJ8b]KJ832#MLMa9?E.
JCKafbTba,6//:TSKC6+R8NS8=S1:M?16#RbQb#F6Y;=\,c=c^KRP9Q@I9UV:995
&4D)3@X)/d_:gEdcB).+6dCLA8[?Me3Zc4e)G49WEa4NNM&Q;Tb\)7M@=]#XTabY
9Z>--IR8:V3[RV;[(gf+>=[ABMF-3GQdd@/bJeO/YC=5-9Y\P&);+F)M/<gIP7N[
2@W2-,6TIRaFATa]NE?e4Z#;\]P).FIWKf<&ffNRW@&/>)F[>_dD9[BQ@S9Zg)aV
SK=(DO)+42Bg8ab?.P>\K/8/2/g4@Yf[RU#[GN2#d\9AGg5C-3J)0X=SEZF<;),6
BdX.N7HS<?]gV8NU[_AcE9MW)C-(eMGF#S<O.;]&R/\Q#P.\<V;.OT/f1K95;<K8
I.F+-W.+V=@[X2JaNZYKK,L[S](SETDe:5/[8=VSQ+-[UGE)1I>>Rg_^PD@K>J^/
+5Ud,D5#JLb\ETRMKRP2)8RJ5ZM+afI#Jfe-99<JN,,b4O.N>KQ5VS9FS8DDT7NX
9Z#0[[2]9P@7^I\V4QIa3S+6H2B+7^0)eVIHPW2@1)01(LN<F,QaIQBV1;95TQUN
6?])6>@\^&:/]FbI5d7SZgM.D^K3#/CVeE+^-V=gPWULB@BY99.cQ/P[^:cRXdGC
^HQJ+62eX)XH7P89(U/Iac&BaXZLV/([M-6ZY3II8;5XYI(e9GDI1[.3FV3KWC>7
eaW/<SQ5.4M:Wb\eF<ME>)_CRMGKaJb<NP=VC^7bDA:)0^Z35L7#1MF.,U6J@6Z<
_eTEg4P)aNaaaOILS>[Z<K9J,/5O\\a.fb3C8b<e<4-e2UaITTb@ED^##Q)6C3KI
D&FG;]Wd,J_#\\PB.LF9HB6^HXeJVDU2Z8#<XH@;7A>^^O\ML:>3\D.e3S(_^>d:
G<J]W7b/Z#)BPW0gCM^-(5,/Y[W(BW+]MCB+>]C2RZH3(@]E=aO2.5-]a&7S2Z(Q
Lf(Y&=G&C\gPC4>ED<Q(T;f,6>Z)4K:H24IP7KMJ#Y&=@:_-7U9&G2F&?Y9fQLb8
4-NdC/V#)b7<P^YZ6^UHI<G5b-JJR7S:GCN)ZZY-_d6AOKU^?>A-4\PH]TM?UaG6
d<IY;Z0]dZBYI^;L,-WeTV63Dg&RKS+RY5a446<@FAM8N7W5ZTG2<7?P12UC,<;-
9<?]9)eFe9_F+IaBD[DaBK-5&0P#B-8(=bc-MZR&R[]QR=I5ZI]BJ;?YJIN;0RAN
6J.AHKB.I&=UOTdHG^_#g&RAB;U5O6<</2:E1HD]MJdL_.PNcce(\:]#8M?I^_YM
KC0ZJYYAY<<XSQY6V@TY5f+a0;W,);C12e=3&YD0Z/8FKRXCg+5/4#+AEcFP<:aF
;f8:S_45X_=MDa,Y>>&_+e(7B[<])<ISA&BWFC[6,e<3gg0YBge(0::3;C5GeNCZ
^R)+7-;0,-SPcQ@f5T___RZXCSTFcB,H\O9c3]Q:?fafA2Qc>?)D[7<>@REWRA@N
-#F00,@g:Kb/GA=AIVL)CF<C@QHTa]#B.L,^L<)B]EeH89TgGTJ5:g;RE,=(+eE_
eA674UUS&fDX:B6dAH^+@D+K0;OSf8<+(6Z=bPYB(K+TPAf-&5JIK=CYdb83/QDB
1SO61Y6f:a4R(;EEg.EPfO/)#7e.9UcTPB)aAG3?aOI_HQPb7Z1K:C95VA/H2f5b
J4)HRRL_.E-EDcgO]+XN<OcC__E^WP-F+MSCWZHdH.=/L1\+/GG8Y:Z(NBH/\WGN
W2gPZF.5SeNb>H=>G9M-BQE_T8X.>Bb^Z<\KdK:SSH^EG.9H3.34E:3VG/S<-MF1
HFg3VBGIPSR]5Q&JSU-4-Y)ZE:9=Y9a;7\N0H=Z?C>@]@Y_<+:\Z::]&CM-\Wb()
@2L9Y#<\(@[Nf8.ga>^@-?6[)JRPS7AZAc:EL4L4BQ,fWY3^[KC24fC(+Q.MQ;A4
BQ<0ORD3:S>:gT#)Q0a@+]&_7D(de<DO+X&G_S8+:\)>^Y:0+BLaKU\O-aFbL-TY
I=M:WaJ(2V.D7e0Ad1N6W.SAH2\8BG<Q)\_,JOR\^UO[2:M04B:<U-MDEM3H0[QA
>cO&\TD)05/DTG8H,]I6?PB0<<;(OYg]1T^+:,#A)e:Y^3VSdA-VU:8GVd^V]2F^
UZU04+<@L-X[=eC>=Z97ac?/4b]aO/aLON_aFb+PSTEa?=V61VOBe@&N33#F&-ZR
F5T[<c[;HK2:-5d=Z)&X>C#?,82-Z1^H4,/JMNTP6DU^;MVFNA<3VA_1L2D_T#G5
4#_ePYCJWM-G)/Kg@\ME4caZH;0e0f-Y(_/>]b8a#EJK&1>BZ]VfTB+O<ZQ\;7N[
_<Ob.aK.I7S;#7DGbW^EI&K@+Yc<F#BE?/7@FO46,A.RTIWc3RGW=V+F@g:a5P,H
SL&WM;,R2Y;[B/;@;b0CedG&gSfP6HUD#]#BXW+c1:a]SM[2EXQ[NO5d.I1^?U6H
gF7fS6g3C^L(dT#5fXZQE?#\<RSX^XbIB)T/O@0W-TfD<T=+c7YSPc>PXeee:V+8
;ff9BJ#gRI<b[/e>-7^&1-P\<],ec0OUZL8&-_UFb,7ZJ\M@T=&EMRgBAS76J\HT
SbU_.(1E)@8Mb/\#g;Da8/E.E(Ad0GU#7--YPObV9B;E,XF//<L\5X4E2\KQ&^U9
GG1CSfDYaHfc[.(_W4#d)2)Qce?[6C)]9A^(L1[KJ?U<\GF\eT?9NRbR-)Q:R;.O
[feT/VQ\4;FMMYK81OM1>=T^:3?(\gEMUB[45<TK(Y8>A2LdU0[fC@8B<>WG?+.N
EFOAGOKSJY>]c3IcX-6fB-#_<_:;cUdWKD4M\9dUAa(-;G&e_X5)@VIX0\7QKDE0
H:dASG#;Fg;Kc[&.^4K@#bQQ[?cD1B:T4I[b]c@3<XC8?;c,R7BBLF>^XODcF4E@
WMJHH6]65YB6ICfP)cI&Q&)H\1+1GgS8T>QMC&0:A??.ZRU#RH,\;8SJ+R#R:6NL
/@S&;QF02WO-4__RW<812cHB2@UQ8I)93>76dTO&>^_Q0QAOW@G0G(4+,.]NF6XO
^5ag)\5OOX/.V<)AH(CI5;:e9VHfUV/7#ZOEXSZK2?RTTG;9#CHA?b+V-eSJ[V9)
O/e,:-B(a;CB6gab,H1#,^A>=RFTP>)TNR/ZW=ZXJRJ;E-cDV8dPHg=eY^_<g]=V
)afAeH#)7.2V1&cWIUM:F6]=]-OOGP&[L3@B@I#b<0_J,UcT(<\bF=0O\5Z04T\B
dX-/e&+V(NcMFKC28fC87<I8^=?B&33DeB;=T1]d(;Z9aL\K+@bORfWa?gMB<)>L
XQ[J9^O9^H411I8/Z8T0^FAB]G(34RU:#RaXAA,e_HH_f+[PE1P<e8B43deS(+1T
EH/Ng0/:,DaPXe)d88NV+<cc9+P_T#EUDS/KUU8R0/JIX5VXcd,<+^A(^HJH>/K)
2J,NaXXgRNV0g;eD_,L)N>_cID^J8B^bHZY58]Eb\/R/:<&OcB0#)_TNS\(V_e/?
8gLF)aaHdbIaY&aVcJ;:db&a(&^_\b[W3J(/FRg0(V(YYYN:e)][=2P_V@bGfKRB
c^?O[YIHJ/_EdX[-5QeZ[R@C&@^IPTc[AM^RYY,AaD0NPIV:=;MKbD(-dXBLb,>S
V45,=fMW[QT?[eS</=4RO2@CSCT](N734BOEeHUML9MHK0SObK9bED1-:0L[OC_:
9)95=K2=aPJc[[4\g?\Re.8YHN9;@N94[Q=(>IY&7eWB9D50Na#T.Tf;6bBW\UND
3WgC]_50N^XU],HD_KOPHPN5U#M#TgU+A2,R99U_Wdc=9/S+E;ce[4_I+b7(:;/6
G2BBS&56F&JRA@QQC5,.7JEVf-)N?_>[M>+bJf:)6RN.T2_BU]QfFd7,1/LGJPcd
HaDN?>eJDM/:T:L7d5KV\@9Z]DRBERDH+#S-D>=eeP(Q4;]3gVIDgY/cP]3gLWfX
6<;IC.;>:Xd+M-=.\Q=V6(_N>S3dF7FXHC_BRL^MGa8W:S2?(VLb9D:6d-4O:F-+
^M8(E074#6VUY-AD5@[C4T6_\XMS8A(#@+gDSHZ1IE3<<9FJdW57]<EDFb>6U_#[
5LCXS4<gB81]&cJS/FaX5PKF@3dAB;GM+X67M0+]TJV:[Q:_G:]Y?9UY2fPT#03.
C2>[Aa2UCJV]M@OUF&fXf:MJM\2U>X.C())bZD0=HHfa\4;.)gU>OEHb)K:4J9Q1
XfA=a=;FIV4D3V5([cD1\c^#+D&>B@3P??=[.H6gYF0.(J5S^0W+G(bNbV?[X^#2
dS=L[,C@\E++@PLJfJ1<WR<(La+.;VH+=/?/\E#ZRZJ(9<WeT]G)C(EUT7c3&U9G
50PKX<;-HaIS6dV]XcO3;\?&Q3&]DM)O4eLf247A]2)aB[3,[GD:QB_Z_:Z#\(I8
Q?P,gV8N5dZAA261T980ZAV=CN_Gd7d\\].T3E8E/<&5IU6]<G82DCV:&@<WUKK4
+&3WNYZ.#_&>.1Y2SMd6/4=0S0I[]NTaQN0a-_6(QJb+HZ/X6;@,&V9RPLU<TY31
EYK3gLWO>c[M?RS;K;AMGIXH+EW\ST2=0(/,]BB+6HJ)2S+J\X2V=D-I,S?aZRX6
WYW37,F)7#KOMF7T\IH-A24\#8,HaG3)Mg^Y98<dY;3gP&3M9UW,A9X_AbUN2;fA
P,SM4Q1#[=f;a.<gO7(4BO7?=I)H6;PH,;FR[,IVcb9&S(\>,W:/S/.N?4MZEe<:
]H4dK#XcHBdb]^0\3[b)b])G6ZI)+P&P204ADfKQ@QT&.0FZW[;578+[]S][YCGf
M?N_=7VURII#\IJ(Z>0J7RAXVedJQWS27)7)MT/IVH6OYaX].0+3/3SY,E:#9B-@
,6=<5FZU3WM=#VRZ#a>ZB=A2NZU<,RINWDKc3-d_\XEfP#7H1eE5;Q<HBRFIU_>,
8>Pfe)eS?W?7ON7^0K^dSACAa?@X)b4)/0e)6M^>CT#01M,,#[?B/_2#/[-Fb0[K
>Jf7TW52KgcS0d6e3OJ/De).=aXFA0fB618M.9UAX2VRDF69,fX6\5W4=A/6LW<M
dNg3NN>R=R&&f.7^JcE7R3g>B??(D<]Q+1-eRZ9IFJ;71&E)D^Z4QJ9(SaGX<,3C
&gF40+(E3fbV&VK,ZY\Zf<[;1A+>K=49#;=Z10V^8GG[G?f4S;>O[J5NPF2TD>HF
6M+D/U/B^LVY5,/Q/#:g4(U3YaO1ZLf[ZJP2?TYW?Ba,f>F&JQ6.?UA2A_=b]bTd
[-9,b/>>\S?CeA&bMM=U&<[VYVfA;1cR)JR9KIXC?;2WYNHg1I:g/?V&4.EQ7?WB
Y,F=4UeJNKL2SaGBE\CVVMIUD?K_dfc(f3MAFW>4:^>ab)/N+?AQ02(@JU+M^JZV
=A[XP&28)+7EZ?C+?.^HT6C-L#402_(U]ZY1#7D6HCGU+B:ObGV1#LH:/B9P5TG?
Y=XfYccC-RPI)^94M^X/eUEf3#2@@O]B[JCGH.[:-Ge.5Qe&bf:Q>>SCFBU?E&;K
df=)ZDZDaXFFAPYf5NL,1[?)(8?5EY#<69O)Qc=ZCY.NZHB]Wc56_X8BJB,1K\#/
KMa>VK#46Y2e_VAW#JA[;YKH3.VVe=6&+0\17,P3PO#-7#>(.H8-R2ANV?&RZSc,
a\&S;C)6Y_-=-bE.Kd4[e7M#5^(IA;=TfL:/WNd&_)SSXXd6OPb\3f,KR_W6QI8:
aX8()Qg0-Ube24WW3D[6cH7KNaE^c@>9<<S@/)^^&SaAaQX?=QE^:]Y?8-)9;,CR
7aOU:W578<Oc;X>-Se,UaY\0^NO<08#:We^IAc<UW3g07H,W:e6aY57efB1E@U+V
#([1SX.@e&WdK\5H]:C9\H6S8]M8Bfd2eR395e,_D80MG&\B(&LWRJO+6GW,J0BX
L3.2QXHDM1BGMd?3eL#2dN6QT3g?f\cKM#,DZ1Y/&&0GffZ/a,VHW2c(CYO^&1HR
6I\M]ege1BJ?UNCdg+>=N7L<0Ce>]9(]]c\^&\,.6RH+RYW^URDAPI]J[c30LgLb
ECO<F?WTM>=.deBX.#d(8#\WaSHN0bDVe8+1c=f:T)ZBR+gO2=TFYM^?;UT@5)[b
L@,R/Hd7M(&PG,3]1\+3D^/Vc7-ZWOWA<4Z&b&LHQ2#Z&IUAK&>Q5&VS=)+2]7&]
6H\QS5V6b)X:d#W2^(Ld6Sa0]RdN(>J4U0@7&6A;6c;VGbKf3+eN=\&:(M^/3&.\
b-8)4FdZGU\eSU?<H0RgAUg8VYRE<WgUH?H4J4:HW8@DAQd/&OXVaE?fL:&9F&b-
(+N.YE)aa.]W@&9H^ULWAf3YXa.S(^):FBL0,R:4P0\JVbAAg9]K>Y4egdS;D((b
56cIR8A&.f,9H>:XMA?T7B;)\>#a?M3]bQICWXN(\0fICH>/C])A[O#RS8FUO[FA
4WF^AYF5aCAC2G]5?>W&PWW,(06Sd:fS_8[Q&EN;X@#P96:J-.^S37d.>d:7KS_B
YDbE=[,KXVL]?\5YV_1Q6LC-OBg.ZD?SY^:6UQJd/=:&R;7DO>1,WUJdJSNb@OIX
+D5FXUY4N,).<b@W__cTHMW>W3O,J5?g?(WE7DI3B[;[4?(U3(_MaSW[3e8WPPe?
dX1aW=6Kee,9B//,T[R?PL&:W=B,C=5#PV&7W3P#6VO:Wb\:cIFV:B2XZ<NC>HcB
X-QFUgE8E_1<)[+D]#24N_4-.#d157FM9af1)Rg[?>:b<AQ_P/IN#3D[3[4.MQQS
PEGL3E>RWg.Xe(F6[H8cG&\&R@^KaX0F(B/JOf^SI-37?XS9eUTOS8)5;^2g4eW7
>NULb.[KQdfF?AQ#WIVSC&OK[+V0EBKJ:827O;HN1YQTQ-]I_V3H)&aO>CU8FAT/
gOK^OUb^fb]B)ONf&dQD3009#//#-cL9XO;ccZd(1c9^I<HJb9=[QF.Sc=)FM^YE
-RN]^VLWdO_+F<D&X@_;-7:+Lf<R1=-L:Lb+<5TKd]9-1JA+CcTXD_O+\LSf/Z8#
).=PBHO4M-4N=?9AG7:ZZA2G[(gUY>SPP8(ANU^Z/FK].<4;7\1FQ\;@WF,#K9:I
KA_F2MUQ(:RYW(cN&PJ?:;S5_3+W\4-b7C1:ecTJAC><#BW\dceAUg&>GXHASZ@P
+&>7SS(STIZ,RC2B=7N1&30QMY<3CNbAHXW/1fbbT+,.1:1\A2]Z#2.LAMR^C;0V
e><LKebVO9FcF+T)NK=#ZHT=DC6GIH725IGZ962bU=/&-]LY[MD(07[+gF)eSPA^
P/(#gD[E[ed9;)g8f?U+IG>6B<C8UCL@TKFFJTf5K]&NP)0fHO/,RK/WZIR^CK9&
NGc:6I+GSCZD3AA8^[G1geY[.PBXC(dRg?@[]W0-L8Q:M+9X#5B:4-QMCX&+S>K8
eFRGH5b//a<FOV</Z00(0QB&Y3)+>IUfg\CUe^B:ML.?D\@W3B+Z1WMd6cD)=;T9
&;g=_Obb=5LH.U7<4d^eC2YJ1SV51BYgZGH/G&TaYY.(-bRT\\?fS5K&V:8\<A<-
\ZM/_.T;IW+&R_]TeR&O.>\\e3P4:#5aY,2VW/?IKYaBba:)c77)-[3^2#D8CG2g
S+LAAB]G5A0+5-7-15V^4YU)AF567GYe/)LT[I,4Kb;3=bH1)6CWH]SfCB&ZKOI)
a;[EB>Z2)/GX2L6>-YD)TJY_Pa.UOR4/05M]bAFQJJ:#EeI:Te@M0^g#,QJ?RV(3
g7O.0W(IDG3XCaE^VB@LVcg/#YIdG/#RX,WaZL0^gQ-_9@C#1.DLM-O+;4R/L5.F
RN?b:X\GKI1,W)(4IHO2adXc.g:M_XI_1#9S.\GagKcC,-?#H:KfS/+K1/T:E69b
dRgJa=ZI)57U@LY@=?#W\GIa[EdRTP[dW,9A5<YC5GH(9IWf3RM(0Z,+F?YM1KDT
Yd2G3HDLe/^bA0f+P\^WA4X-c4.Q;c/&CP0/YS?\MO3-23<5DT_M2a@NV(9_8#R/
MBTESZJ)bS+IeLH72GT5VU(Xd)c\-TPbI(4W6LG(PGReTa&Kc^,H<0aZRWMd8,3<
X(,WIG3eAbfSMcMf]M;V?B0_(930d.30cJ5\M:X65ZD?SP=&T8AD/,R3T5?@8b/?
>ZgRgRA[@ENcO5\^YCD6;K(J\.36@e1@3O.H@QdN+G2WH3KRG=OOc,2;gYWFV&Q[
<e9?B6ZX5>&ZGITI\Ae[GQRaVKNH>ZTNO_Qd8\TD_e,96V8[Y<(F5<ZPPFeE</U2
5E_IPX7aAR\W53#]PMBf9.cDZU<3Wb[(UW;SMY<N;&[fJUDATFb<@U@cKPB58<@<
.22+2.2dO5\A7V]=?C]VXe5\&P[J>J+>&E0b\.@6d_:IHX_+NJU?[HF)EY?K/_6J
GZG.;F6>gYQFA4?F6ZWW3@\+&Fd>R@984:UN#[<_-.UCDU\\SJ)(]::/^HND6+A2
)>G/Z6KL4POAU?Fb0=>NLIa27R4.U@F:718G_AEN6I;VfHV^-(1G,BW4:f+X7U&M
OES@5XMO&,P:Qc0cAb+ML8UaCNe/[V_?.L5<d->2JH3BEE[G>BN&a<d+-TMXf7g;
BGPKCNNgE)HQ#O<2fCG(N^I/S_Ma?G,O>XMY8d6MD1;11<@&O:)OYDJKa..G<Pe,
YWbVH(6S?<L^KWgT0@-_1_:1Yf?+ReGO&AZ?G[aUPY2#IF\WKe1H3Ha>C]66AP.7
EQ-0^O_+TH#7Xa7XU3Eafg^]1OB/=&g[b-2\]H\QIAQT<^:1+-[[7BYL;7e]Y/^H
AX_6V\.X&^T@g_PD+V&_c>GPR\7SJ\#gWcQ:1JFG9:.E[]I<A[bC13ZRbQG1/P]<
f^6?SB2]HV(U?cL(E>Pb^H-+T)L+@1BafdA\G_Z/2f=#Z@d23Ie;-CY/c=AJQ/a)
-(-\>O;B?QYE)V#d[J&L81T5M;18\KHgUPe..f(BfU71[5Q>M/;fb\UKG(GHe3Tf
F+QJ/:Iba(VE#&(+?bR7/ILLT58=(E19\<C2?T/+^FC]Dd8(5<RF^a]ROg2L)8M7
eHgLBO9#^)=^_BF70GS4K6EW:T(2I)=bYd@T#VG],/c0)O39JA/4TT\0F>TVI&N-
[I,L<9D@D6J0a/KA2L)F5D,+XSKDNGG>31B(2;P.FL..LY,4Q:S0ZB#SX?W5bD+1
0ZU(R9[f.G7,S-J0X#>.a^#5EBd])X0X2G[&^U.Tg_L/;4eR&>bLY<e,0HSc#+6A
KRBN??JYRBX45ID2(#HW-.If.P)1IRDf&<E?EEA1D3K)AB8d?4>#4O\.8Wf8<VVR
_.APG_N=_&N#g:-):00Y/1=^&#+GC2;07Rg5<(?/]cWd.RfX;Y#2+:Oe/W+>H8:>
K:Q)X,<.Oa9ObR<\>TBZ<fMI@5OaIeYgfTFB<17a(#Z3&a>6VAT/>,DP0#g3@#H)
D[W[R3;@3[I.aMU_8Q]JNA0/>LGZbN@+7:4P5REV/5LC[=Jf&O+MS-Qg7bbRY7=?
/U091Q:96@14H0ac]Hgd<4G^W41:6NFOeSZWMP>6EC:?\S:LX4NPfTZCOYO?F58J
IUOI,LW,_[4+],>B?NC&b&.gH7=X@@Ob)1Ff8>6#8MDV:@@JUN09A:Y+Z]2WU6D?
+0(J^GBKP=KA^^d=2B9cL>@&b[69=,/_DZF39+TY4/KP,]+YA:,a+.&PRZU)&3QQ
+D=NL^_ELWR2>^RG#XWB6QO&Y@:T)KFBbL]KgCJ;b4V[Lf712LVfP\/g^Tda5XB8
ZCfJ[b-0&Z@Wf&:TFc^<UJQEKf/IY5^/60f_7aCH&CP-X,O&I4f;eR##ECWLR\bE
H\N9bN;c?U:/,>#e6##V#.G#SLM=P0]Je1J0]8H,Z^?D&9Y0G0T4;EH4FZRY3UYd
OHWGc[GL=\ad--&5<8:7S[Y@?83:K+SJ391BM#bIFDJC&Z.3[0N7aRb5Z@cY\KWJ
Y9ZXg#GKI;;RA7WH-_PN\NdLf8#L(^XPLHBM3JgJcMFGS?;0QJJ[S#)fQNGM+S)O
g5+Y@8U_L0]Jb+HSVEU57WcA/&a9.B?:0D?7d2T4+HCZ>83b2GgC@?KVPG6I6NW5
Kc)b5Vb2F-[c(J69:b]TcT3dfX2d#?e;?W?XMEW_AUNgK#KLYL9JP8KVK$
`endprotected


`endif // GUARD_SVT_SPI_NAND_FLASH_MICRON_TOP_REGISTER_SV

