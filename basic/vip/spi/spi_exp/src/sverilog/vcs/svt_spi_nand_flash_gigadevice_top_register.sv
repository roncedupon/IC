
`ifndef GUARD_SVT_SPI_NAND_FLASH_GIGADEVICE_TOP_REGISTER_SV
`define GUARD_SVT_SPI_NAND_FLASH_GIGADEVICE_TOP_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP GigaDevice top register class.
 */
class svt_spi_nand_flash_gigadevice_top_register extends svt_status;

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
  bit [2:0] block_protect = 3'b0;

  /**  
   * Determines whether the protected memory area defined by the block protect <br/>
   * bits starts from the top or bottom of the memory array. <br/>
   * 0 : Top Blocks Protected <br/>
   * 1 : Bottom Blocks Protected 
   */
  bit invert_protect = 1'b0;

  /**
   * This is used to reverse the Protection set. <br/>
   * if set to 1, previous array protection set by #block_protect and #invert_protect will be reversed.
   */
  bit complement_protect = 1'b0;

  /** SPI Feature Register. */

  /** 
   * OTP space can be protected after Programming it by setting #otp_protection to 1. <br/>
   * The OTP space cannot be erased and after it has been protected. <br/>
   * it cannot be programmed again.
   */
  bit otp_protection = 1'b0;

  /** Configures the device to program OTP locations if #otp_protection has not been enabled */
  bit otp_enable = 1'b0;

  /** Configures the device into ECC operation */
  bit ecc_enable = 1'b0;

  /** Configures the device Bad Block Inhibit operation */
  bit bad_block_inhibit = 1'b0;

  /** 
   * Configures the device into QUAD IO operation. <br/> 
   * 1 : Quad IO Selected   <br/>
   * 0 : Extended or Dual IO Selected
   */
  bit quad_enable = 1'b0;

  /** SPI Status Register. */

  /**
   * ECCS provides ECC status as follows: <br/>
   * 00b = No bit errors were detected during the previous read algorithm. <br/>
   * 01b = bit error was detected and corrected, error bit number = 1~7 <br/>
   * 10b = bit error was detected and not corrected <br/>
   * 11b = bit error was detected and corrected, error bit number = 8 <br/>
   * ECCS is set to 00b either following a RESET, or at the beginning of the READ. <br/>
   * It is then updated after the device completes a valid READ operation. <br/>
   * ECCS is invalid if #ecc_enable is disabled
   */
  bit [1:0] ecc_status = 1'b0;

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

  bit [1:0] driver_register_bits;

  /**
   * ECCSE provides ECC status Error when ECC Status is 2'b10 as follows: <br/>
   * 01b = bit error <=4 were detected and corrected <br/>
   * 01b = bit error =5  were detected and corrected <br/>
   * 10b = bit error =6  were detected and corrected <br/>
   * 11b = bit error =7  were detected and corrected <br/>
   * ECCSE is set to 00b either following a RESET, or at the beginning of the READ. <br/>
   * It is then updated after the device completes a valid READ operation. <br/>
   * ECCSE is invalid if #ecc_enable is disabled
   */ 
  bit [1:0] ecc_status_error;

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
  `svt_vmm_data_new(svt_spi_nand_flash_gigadevice_top_register)
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
  extern function new(string name = "svt_spi_nand_flash_gigadevice_top_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_nand_flash_gigadevice_top_register)
  `svt_data_member_end(svt_spi_nand_flash_gigadevice_top_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_nand_flash_gigadevice_top_register.
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
  `vmm_typename(svt_spi_nand_flash_gigadevice_top_register)
  `vmm_class_factory(svt_spi_nand_flash_gigadevice_top_register)
`endif

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Protection Register */
  extern virtual function bit [7:0] get_gigadevice_protection_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Feature Register */
  extern virtual function bit [7:0] get_gigadevice_feature_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_gigadevice_status_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Feature Register 2*/
  extern virtual function bit [7:0] get_gigadevice_feature_register_2();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register 2*/
  extern virtual function bit [7:0] get_gigadevice_status_register_2();

  // ---------------------------------------------------------------------------
  /** This method retrieves the value of a single named property of a data class */
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of a single named property of a data class */
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Protection Register */
  extern virtual function void set_gigadevice_protection_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Feature Register */
  extern virtual function void set_gigadevice_feature_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Status Register */
  extern virtual function void set_gigadevice_status_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Feature Register 2*/
  extern virtual function void set_gigadevice_feature_register_2( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Status Register 2*/
  extern virtual function void set_gigadevice_status_register_2( bit [7:0] reg_val);

endclass

// =============================================================================

`protected
_RY>]1MKYWcQ\VSUS[VX>;UbMB,TSQ^_fS90JgOF0aHLDI8&=]=I1)^U<VQDBGc1
B]P#KfJKB]+d]V;@KbI0bP(a_VJ[)Y1[<1:WE1>a-7(OR:^6,YNK99#HDV1H\3PY
?W^FXF,aYJaS<DbbNL.VJ.,H)5X3A&bLYcV5Q:ZUO,MTfPT),&O9ec5XNJNS)>OS
Y?d>^@D[D;IBW^@94J4FI4gN40+R6]?-((2OM/U_^/7LY9-5\#RA&A_d_UdM9:d]
JdbVA@_ADTIEY_XWB@PM@P=cP_USWf6;DSHZ8_^a7BfJ;1,&DPW=c[LZK@c;@ZLF
+5\b=BZb,a.KOAfdO#^:VCVJZF<ggA/a8-g8]eL9VMFK/-D2We>/]4Y#@]c_5[Z@
@dIV3D:f>f9?T)YgaGV#G979HDQ@_A]MPAW0-&SV_TU0<5,FI19?XKJY@YJadFbT
8_bGLY_@J9D-.QYIg^7LBV1bNM&;-+A3.,B2@PR2e_EL595Y7c35><eT^6#ff0I\
9eCYEV300=aG#Ag5LYe.K3aRS<7=.<,BFgC2E+BSI0a(BT(gR30CAH:[(f#_2XJG
^]@OV=,7<+=KY^e?/3):FGA5&d7B@FUQPg4+?/S1C8HRNVDNMUA<E9],IZaNT-dS
cWZ7:4O)(<XQEB6425)QKZ1UaB&\1Zb>3M70-I5K[=RY4UUFW3)W,LX,=b<^C]YZ
/\,I]G]0SUB^0J2C\?[AN45=OY-1\T.@<$
`endprotected

   
//vcs_vip_protect
`protected
+&N9fSS3WU>;1,NaVJFa6EFfZ2_.D4#dTaMM=<,HcDfeEU&bcG(F5(G(#^)GIXFe
;ea2;HQ<6@\Ebg//@#,<#KL(ZM_DPO;Q6+d57S)f5+^E0]@]20eE3,c@\7OQ.IT;
Z012[KgF&=?V+43&+;_DX_[1&NME3Jc]M7E-.XE,dRS18CF9;A2XUFF5ABf/b1/,
ZP38L4=MP_HCRWbY<=^7YE+dT8dFV]Z89H.)8A,Z@_WI<Cb>/]G+^g4V\N.e-^e2
Sf=^4/ZfL-d4CLULSae/\UOG?G-+5QBP602d68P(,2&Y;?723UF>U=,Y4baARI78
=QZT38L-:1H:9K^Y\@])&R.^+>Y8_S\J/OM/^1P-?F:DLZ2CVG125/KG\R>J+@0<
CI[:^.3+\03[&D+9bX<<E(9F[,a,UdWWI2/J8bC-OaY[Ze;9FB8##VMbCOf(D]/e
V)(#BR#DbN[X^dE3RBUN,Q=)?D8Y#d^+a1\C;_.3O4?HUD[B8Lf[B.,N4+TDC#BX
J]A/ND9>ZCCUF\KaU_GU_UWD&8Q[FQJY-^B2/4NQeI9NZO#FM_d.7,+7c+/6QbEY
M27@7EI=]N=.2C8+V10GJVA_]dO_>Zbd<))Q<>U,+a#LI8,W6NU2cM2NXP&=Le+@
K[I::UH#49.]9B-C)@a4H?9&E\aA>;V#ERWHcfbKdDEK+1fB]SbILE=b(b\bd28(
NCRE3(,UM_d]&AFM\19[^65NM2+X[KGgE800<^-;FPWWO.ddW5UX[bF#UWFg5W.e
<8Gc;C6R:&B]@)+\/1f^?T@[TYCNRH0b_\Tf186(LW3((^/W6MY@3?OG1b&-I&K0
2J\0VO85cFEf&;R\T##JFcgAU&XgQ&LY47DOPdNaZd[O?>IX3<^9d\AN&3__DcOC
6>1Wg=H0U65XX1^#4)H)WQ>S,L6&MaD[EH\#)M<#G;PBaVJO9;80&4+US:B,^;N#
[ZKY.JA=0@fU&F4,0P<UVZP?@D/-IgPf(HC&caFf7MEF#>Q74H8R:_WIPZ).X:-^
L+DbFe&8O-W)2+g5(+U:bI^=2=OQ\)F8[WVNS0X<1NHOZI@K@5R2eT(@C)_fSf/I
71Y9dIZF:?\Za<G72LR.c#@BF1d>XE[.;KTLVB@<V@f6Oa-V7U\JdJ</Sae@[P:M
d3(EI]A2IKXEW<&Ab[aS5N0>X8NL(\Md>ccV#93bZH#0ZCS6e_6##9?=RJ9^<=1W
MK29]c[Y2\gJTPaD51V&V2.Pbe5aS[;?SWbC,81RdcC<R/R;>B&fU3[QKCR\7V9S
T;U44(9e?OaQ2T92Y]E5cVc@C+:&27=CID-f2_Z;Fga\W\X(bYG@ES5feZ6GLdA&
60,Jd,B0Qg>dT@eD7=_ZY\I&]Fb&#BH#)WH526=Qe@>[Hg>)J&/50BT&C1g+Y9@A
+@+H7&^3=Ta#LbYBSB@\0HbOcX+?6b,de512#+C6@77IMDV92W[F-SURV0abbRD;
I8J77bX9:@XDCY3.A2OD\X#Z1eI&^E(-9KTfTS;aYO4?#GUS<dZ)NJ[85B,^_@7X
R]3<Ia/[Rb]_AE7S;MD0O,?5B6N5?_b-MYE3GNWG_IJ_]9EB(60Dg3dHDE833PQU
_;Ecc8]/_1,W44fa]fg[XPAM#UKK^Z>6RUC_3M:3@?V&?^@:5;U)B@E(_@NLR8Tc
JA=FR?8O=.@NGY9)CQ123eHDb+K1fd+2]E<BOaSZ.OQYFJ.Aa48<V.&]EED5^UI\
\&0K+e+\90Fa(]VaFTZ.8a9.Bg]8]1KQYW??aIK8P(^-0X<W9TKXIO?D_]:_)O[.
+;2FQDYY(/(I7GF[\;?:.Q]SM9NPINRfY7.3T24g_DPf[NC1Q1-G1Q:]NLRT+1;d
7;L,J[[dX4e2HHc=f/;aB/9;SU)1.EC<?&4Cc=6#+UKeZ0.YA46a=JFW3bB7GJVX
NE3IO1)3[44//SGDGgF3V_R.S;JS.Y]D,Lc=,7WDEM_11g]cYP<eCSe0+BReH01U
I7bOd)@\[_S,fH2/R(O]-5[2-aP_RXV9FY(L5Q0.\9SUfDK(8I@/dfLc-P)RS/]<
FR1]g#S7+.Y3dY@c5Z((CMOO(3(24@M;94RgAdPN\__D#+e\A,/32CA@B&\f+W\d
[BB).=7(SB8gSIS@H9JS4=Ta83C8T<?dE/XXBB4SF[ZCeM#H8J2/VNY[/^-ZOd+L
Lc>1f(D9#9@&>U<1H-P.C1bFJ+L75;a3cJaZYb_EW(_H#LTO\@H4HQ[<Q>gI<A\A
_P@D5Z9+Ve:d<0B^UD5Q:Cb-8gO[<M\>2BTTWg0\WWf7G7@Ge<PEGf]fU[/1EGc&
NOB,[9;1d[gKc>ZGU9a8NU8_C9/EW3^0UNKJUV:XHO\Z_OY37R2@8R2L>N\O/_7e
?R9+Z92T\UH[^96Y4]DHI9B()8T2QM>#,3_[@Vf&9ZYPP2Hda7(9Q450ZTeb.3f+
415>F:Qa(AHBAH9A7=-D+HIaU=[Z?^H)7932Y8:TW8>6?0_-XA6^X.[8a&bE:&Wa
GOc#UTb->WQ^7dW[A0^_W1(NJ.#0IafN/3=,<4+.^N<LgS6;17FH8/(5]B7)M0Wd
>;13\IH9G<VD(+;ed^6(Vd;KYY#0P;TUQ0;3I)Qd35Ia6/V@d0_R<.KQZc&3Pg6;
)S:&P,L(R9,?S2YLF4[MJD.ZL?bBPYUV04;^E10M=XLCfP;dQ]0KaCfP[U_TQ\A_
+ed69RFTXgQ0f;7AXHPHYI6>&ZgF6M1^07H&aLNA&R#a-G8cK&c:4dGRVHP/.@Xa
(ef7]:aYBdYSOQ>a1K&1+)Q>+HV/-G<P/3I53:4K>44.f;ECKFH[Z0,Xa;#UaEGR
,L4+UN@NSV8W7bM58QJ\V)KeI&R8Y##MfVU2-3JH,]a\b?(49F_bcBKZ<Z;@BQL6
5WOC=L<aX@4&0X-36=HY-(G\Y)Odb<UR>[GH2W;WZ)8?1CRRQ?9^TbF72Ua4PG7&
VDJL;IR=QAB=R:_?20&AG82<U3QN-a,;YA6M>+MedYV?&AWD,L<ZTWc2WB9?>[DI
P#ZBe23S3FX.)a64[F=6AfebcM3T853</ZRLEN6c)<&O]YGP&fGHJLU3Q^F<L0)-
DS39D)Z=+cITGP2G2bWe:HJ\;\P(6AK[QC)?F5Z[KDa<gW79(ZZ6RB_?;gSW9XaZ
R/_=^9\&ba2[.O#E7NE8SP@FLOP9PK]RHOT(f;:P)gcD(8YK(V9VBaBfDIa(SNC.
/O=:5>?MV2]5)gd.IFOV&O>C4[\U4V8M<fKbc)Q5NJDHaCI6LXD0gd@LA;7WLX+P
A75EBIP/_KW<G+:J]K8R>UEB:6bJ(?&8/(/Af:Y/SSWdUEWMFMb=aLD_Y&W_J;I2
MF_,_M#\0He-bVYFA>:1F[OS@Y6fea1Q[V]XVGLY[\C(d[f7f>g+C#=LBJK2I>B:
MMFdYYYg_HcP;Gb(C8&)DF^1.7W++#QXg9a?T+3UP]F7D6.JSF&VFUBK#-#9L,/1
\(QOd_MA7PQUT7&_^&L#1bS-W(9BXWGP)N99c=a:+)UO^=gQ_V(9;),B)<Bg9479
7ATXMe7HXML2H,7E-:/8-XVa9Jag+]UX^d;g=e_MM&T[D&C>#)ge_@_b0:O+>TLX
2G>TS5H@ZgTgVK.:F5Y_+(M8.VbB&X5X=TG?1BNFZQ0Z?ITf9R12,NG\O3J_dWA]
C3QR/7:RDFPcT:]<fga7+V(#/MGPV&@5a/P1PS]3SW7f8TQ0-&FI+g95V_A>MR2I
J45d=XZR&.1Gg1/F,e>_C]QgA.0@8T6Q7R^bYE:MTNJ+?eG9+#)?c^.];1dG0/)O
<Q<U-Ac@7c)K<S3eR;J<](UF9NBV0f3@N?.3)J)=[@R^:?-?82N]KZALE.gN,8/+
H^f=.YXcI/@VOe[B=.aV)XW@24ac/M-De&dTME[5+JMeL)F:II<LQAQL<8KZ8b0)
cB3##d8Sg.K8^\)^36<M^1L&=6I:[86G[:^cJO;19U(f>).c9^EYd=A+6HF1,\UR
O@Yee1\>RVFfgT8?ZS3YN)<R[X;VOK&GKKB?;?1?.5ea_gb](B)/##(e3O@2=-Xc
N7HJ[P86]EX&S>g:L>DBW1Z/4W=^Rg14TXTW-]><1(YQ)fWHW&cQ;gUSOHB[:E(_
+b=9J+5+CGZ/>=;;&W@4W:0_D3KOM=P4?/,P)0W5NA<&@+_\BY.YNIB1T0a(<Y?^
d43?L9Qc=:;M9f@@R4;^.aMX\,8bR:Yg<W,D):FQC9J+.]cL^=YOA)4]g0+U@_He
eDR4@K+S=J?QR&?)_D+dOeCI[?=Af,(6Bc5#dK&V@9(AZFHaM_fTNa0NZ(::U,Ia
WIV/>/#,e^1bb;)[4J/_[4dZ/9)KD]S,fgWc(e(/Z@>J5LH.OfI[UMa4(PG[541>
PZZX[WQ/ZKfR(I^X>M4YPFCH8,E6cH4/NbecZLB_)[/K.Y<V;9bU.DE?V>9+([-Y
..+VT2HG7..[BF0M&@@BY7)R]&bM=GC)Sf>@G2N&L.3=_<5-;+]N13K(T6ZS_D3(
UTO60[IHM(]Db8(F^f;fQ#0eOFZ@a+TZgcJMa\3R1Ud.<Y]::1H?2V8@UT95;d0E
\^Q)JXT:)_10WP2(1<D6FIO+CW,3Q(XU2RbE;(]B(DPA<+aWWJ+a/gGIRObe8:P]
PGVcCM@QC@VU?UCRaI&]95K=+-<_9g0&HL;ZYLg#;@7H1?c6f7-&CJ&&4[(PCEdf
&9+S]g5g9H2>Pf2T6MK0F2#HW/=f?2JCF#QS^AXY7dR560XUWd)0G#B/7-Z_?-#.
Ia>PLX1WM>DW8f9HL&SbA.N:HS?J(IF\3_O0Z4>FYL](?B#>5+gU+I_0bJJda=)7
e)>1?M9f4.&\3Gb<K5^MGLE&0?-b_JO.HF5c)?(>W^d.6#G8&[fKEWKG:92cAFB0
HBfOY]J2UDN;9BJH&EQ+MQ3gBU[O)_V>EL9Z4]0=6.a(DR,RggVXMAY]X&S=,T:?
BJ/_J5AAV=]05G6<90IIc/ga2f2T/GZ4E\]V8A5+_M6#08)VZ\E>8/S7QRB.QX]&
Ac.&,_T9[]=BbAR\\(W&DCPOKSY#5T^3X&OA\1^WJdBT_&L=TYfD>4KK??L6Lc7e
11O]D5cSFU9GYIYM;bR86V>=4)6.G:gY1U:OaC0(:(Dg=ab,FJW;_T.6]YdGRD2(
P,:UX&P/.KCNGDQO\/S[@)F_bNe\baON?0gM)AVaU@=HC=]Y8cX-d9^5aM-5RXT5
U\gg]^]R+YWV<.;f7WS2<37S2;MfCHLTbH4R//@#]B(6O37-V4X)(_,I8\+A@.-8
)JFGa02M0T32I4X4..?]SA8PNJE<]CMAYRbEbb5[dKLTNSf0KL)>f0]A-XeV5b#a
f\?GYW]EJdU6;MM2bB[B>4SGXXc\^]6ASD,U#4c)Y0d4aHE>TeT=C=8[fJC@J&JD
9;NeJRV@[.\3(6]#FNeOXd>).>/CfB7I<BJD.[6GgL1@+:fNVL<J7X\;c;(U0./_
/>CX<MRXH5_K85NT+3+RVEX@;<a1gO6P75K(E]N#ceeA;a5XPG;#NEHHE?(_IRQX
(5)/DW1.aG\P>MR2d&TT]=R#Dg]=\XT[;aBEfP](@ec>Y>a9@<eGK6AT1d(,dJf_
./WK.<NfPQFNV+K>95I=F2Qe7UI[G.^E;T3P94S:#^#-)-\a+QR?T8=\[IeXgD_a
3[G)7^?JP50f],b:4eUZ?8QJf#CQ\HK=P-J8bBe]Zb)G(-X&.EMP^_1Iac7a\\+2
DKY0@Gd[/).F=TIH<Q5WP5VE1f&0AJ)@HgJ.-,A-TJ?gN2C>QQQ&=V[I0e3HJVTE
#>@[J9B\],TI@&f?&A\dSA0[1U]9POZ5@PL5I457KP@P4S4@ZW;F38]V&##4fVE7
eJ>_(3SM_3,T6-.Y#LK+@4]3&70(]-UYabc.<\/FFA3Y^?V.f-@K+Q\CJb4GY=/_
b+0Y]YYeG3Q.7?FfDB8-9b/PSFB3@+5#Z#_NTZS&_ZG79f3M@]F1O),UO+PA4G;>
JS2<I4T4eOZ+6KJOPGO91V4UDY25X0f@J)AC)R(&P(_aN^_J.^28F<-:Q&NDWDXY
<GM&c6HUS3<2NY+Q]EfCV8R_8VW83YLMWU_L3X14C,JVg2Q03H[eVD+YM+F[&BX#
^WC]a(JZJ01<0&QPF@.Q[BZ(<:\\/^fJF(.SMF<].Q>,0BJYK3#N^:J@5L:\I+F,
SY8TV)VdP>JOPa\dXGf^]>3ZU>HY)ZaJR@EGPJd:6?\4dJ,edcfM@Gb&=<_e;@=4
0#@LcXUF3gE\7[Af^J_BV]R>49Z(\R(+/FFNUCI59G1U=[>e5VYX&NgR+]d]Q,>c
_)CF+&AGXTF[GHAg/[4R+aP?/.WSDcCf:BUI&[0)M0)HBLLH&LcaC?0gbM^?cIJY
=_dMP=;\@f27Z3fG^B_8@TccV#\KGG(_K@MRHD^Sc_75^CC?-0HNJ<d3?:VR1VXE
VAHTF=AX<:=2YUUC)LI1K]KdO4D4=9bU:LK=Y/;J5Y,IM;VFF,[6?R16/@5b/@g&
+C1/U)>LEMX+@b4QUNP+\9Hg;@EQFC\8T1O&X6PfHR=9G?AE]6Oc0.X0Tf,.daXe
gOE:(\IXe.^J^O3L34?C&=X51R:OAPfVS+/4KBUf(5BPg0MUO[&J(I@#ZU.be,(a
>B_3AZ0N@2-\824BLQaE1ORM+JS>[c,\a2fX[7;H\SZRF\..2Fa0bZ)4e6g#/;=b
+aUB&M^+dQU^QYM90@e[MF[@ZCG9@@#N0P(_)e:5ZG4cX38,G\N/IK?7<>@@#U6?
U.#RM2M]75Q\BUM0S-7a_e_RfV@[:>LZ;_56Y)434J;6b^/A]76BbKOB)1+0>+TA
]-dbHNg@V>2?f=4.E,5_B4IQNR@aUDU6aVYZ.8W-C&E]-;7c1?EJU_]1(Q/?U48N
_##/[447BT0XPP.M[WLQ:I_..DQ[UJ/K[NFN);ALK2I+I(5DU>0C1CgQYTOMKYT8
[C=X0OF7^3eV_^TXa>Lb+0.LB\?Pe+^JIH=f#\D_==C]M#U]_:EQ=+GA^H#;K(CX
cYKP\9QTb(;8D#O6ZK5<+Y38J0CU/c46f-T.MNc2K(;H/?cZcA/;4F4]e^G55g6a
H]P;=E5P8ACR,<(S63KAZ:;ZKE17_=SM/c1f;5=^U?dCSF\K]B)\4&M2=YH1;;4g
@))2D=8(DAY;RfQ30FTEBN>O]OR673f6UfX7OWF:?#Yb:-\3Q&+8E99^AH-BO4-^
@@7<<WI5Z5V?EFPa,X6::C7DSF,C2f5=T<K1R&,>cTcDS3]^VPB2V6^[6E:@9Kd1
F2T@Y[/EP1Gd&e?bfSG9MS1gNA-,7TZeZJ?7ZW8F?@<KI#G8a2RRCC#ZQKZR/R1c
&L=Z-e(^(97&,#NBJd./.-a?Z?W5#:f]L?Xd+E(AN8Ne3]B[g5)Wd93LGRXAE1)S
[W\:OOXTQ);3L<YK\:QWZLJB9ZTFGPKDW_W30Cg]DJ/KOI4YZ@>Y;\6HLA?_]7DF
0N(<P@J)8Ud#53dKd,CIf9()K(K?7YE;UT_<C3,AX<W(EeA5[RLcTaQ&J;6)+^:F
8a+Q?W(&fLK^&F,VX-ODgQSI)9&LH-Ae[db\#Ag<ARE-03D51.F</2gM[Lce._3[
\@@e?-D3UeBcLD)KY14SEKAR3)\bY)P?0fAg0ZXIU&/O&ZP#T?XDG8d[@+L/4d(>
L.05N_<6\,-?0>fTT6B<OPC7TU&1P_G(GUS:2S\1Hd>E,(<TH_3.gJB,e?;b#aG2
GC3VYSK(&[MXN;dFZFfOIba0&CfA:7V1ZDY>McEbDa93/>A5]8?_-_cW-_NJgOB]
[?Z6U>7B@]PN_g./K-044_7?[SL)dbN<Y93bK-IPJeFJS]c7eB=+H#;Y^g+_]-U+
:-UDFTGf1b:,N.5\C,f^Y[@LV>QD]H;8>Nb/SbRZ.DO9-QEVF9)0cWKR8W\\WLfL
9+@.N-<VPIYRTa86^].UVBYf4N(+I-\2A&/84S;Qd;[_6=1f7?f&PbFD,EGD4)#;
9>bL)5BZ/VZV>:P&>B;B)XZ(W,\L9,HIg5SEC.9RS9O.1+7I4@0ZK\=U\(@VSZ4=
F/U=Z^^<M>TGZQ&c72IS7EbD+?T_I3gQcL=N9#MX[-Q5B71L8>190QY:PXAF7g#<
3AC<WP4gJI5S]DR^WF(=F#(a#J=5E;2A]);&M@7Kc3T<KM3^95cXNDBgVP<#NPG4
4A[\/M2@63D#.Q3?b]GK2,9c<0&c4H8:KXO3>9a7>d0-[=0[Odd4__2Y0F@F^-1L
OB/0^eeD9TU>BXMPH8R?AV.A._+L\/_M,B1H->5d7-LKI/.aC@Y(1RM7A8?[E/Y1
+aWeZ)X,a1D5E]CU70EUQa#@U1UVgJ3Bd-X5A<6-7RM.UYP7R?ITf-0#LMQ[Y\NZ
VIg>(Q>)LPeBI]E:4T7[RMV?f=BFd>4H@V7&c^DN\S@@MDHLgBaJ:OX0,^8F0--L
=HYC2TYPGI7MS=DVATVb&c.J\O6E@V)+4?W(T(ZaIA_Z6E@R0d^N?QaIO[,F?K7[
<+c4VG6Ef7H/XV,=8X-GK[\+?\G^7RebQZ6CZW3[(1AD26:O.4#4gTVD1_:U^-Af
(B<-a)@Pc<aXW7-[N0WJ6a)[T2H/R<b:CM_;>e&1W?77V-@A.8)OM4U<C<>aJ4#B
A^+6XH+<C\.#+76e6C4D+=X@@ZR))cH+0f8@HUFAX,6U^]Z2CeO#GVeU-TX]a3V@
F5)1OXFB\P0PLOa\bH6:BHYYBBF^I<Db,)SP#OGfZ?;f.N2HS6,R:,OPUd\#L9?[
[aUEX8JR3XS1Y8aE_Ce]2;f7R]GS?@Ne?MX;)^3b:&eS5&25C\bc(@a@]X?OU+d9
UESS&UR>a[Rb)[Y_dS[D(]Q>b,CUVV\M7@F9c0<O;W)SFZEPHIWPULfM#^Z9ER9N
L.@?d7@5,/B>B0fbJ1a2ST)LQ.MP[dS45-]>=bG/Z:#0McA2fUb-gFM(3#VLBaE#
^PS,5K+7M3?R(:^c5+2HSdT1R8]7\Ae^TB531[ggK@:X0KF>E5.gXPMW-X\(-UZ7
K0V7;7+[Lb).3753RWN0][Ib]2GK;]=46OU+O?F06=L.^^R9AC^.f,I26]TZN)@I
1J-#J?<TB@)gB3^eZU/TgS7OT@FGTN/,BT5I#H+NLeNC4ST&JIZ_4(NO0C8d#WQR
ZZ_HACZLf[=N[KeM6^+_;]SDM2NAVf+:D;&c#ES@d;V=NU#EO+SWW6BLaS4K^a>.
g&.A.<PO5;\KLga&e:RHD<X<_-A=>J0I=?Md)[N58XgH,b(#eK)I,Q0G>RP8KKR2
#(=cD>]8S@UR15T98gA;]fKOAfO:MWMEcH@_J3L>9+.1F5^E_<W?3D87EfG35DYQ
.[O</.CY@CSRB[G0=UWHWeg3>(X?K8>e,L(e]R@[[I&5A79I7BV235[:2.4-deJd
2<9OF9^b85GNf1FN2^ab738S#:,1?]/-&/:9HA_GH.?R(5<Mf83\NN>1Z6<#16(f
/3-45BC;7X/O-KZ^7#,LWL4W5H[;,<.g<=_+e^2g1g74d^Ucc1.M2O?]FP7G[<Xg
>c^[/P;b&F;497K\4IQA\bYRGHJb@T<Q5\IG)#RT4L52SL>c8LB>M3T:C;V<W>4G
PHcb?d1:JK9TC.6(O[D6&0eSFS(bZ@ab#^A9U9^<)g6Ef0E?a4b(RJ-C.Ta(Abc>
E5b_&?U:#0gG8QQDICEWO(GI68?K;9UYXNIf5TR=9N+XD&WQB]4>Q<FQY2]c;T5N
PCN;R[VXXE;B72gC5G&_4XHDPFT+PRd;QCXR>^8=/_3P:eJA=UDV:4]bN0,;=:8Q
H^bM1A0<K3Vaf;-g<S\?B.7XJDI[;DO]Aa8RT2HX89eb/[1eSMG(I:H;:IY&dAcY
/1[Z(0NdfS_e+S,NIEc_MS&T(f_4C,5b#,7)44\Z@D)O-(GK?::f(HE,_Xa\1W1-
>cAS7Q8O_WAENI^dS>VUa8)W#-,Da+GN&EMegBDKFSKaW[M7PgX3A19e(ML?7gGg
6Pa3cD+W83Y;;e(^1,P13LEK\8[E_>TMLQPI]Ha&>+(^Z6#AP4FbKP[K_0VL7PCA
1,,1GBK8GGQc_BF/O>.,Nb+g>BT#),&M_>&,0LIKHNeE?^d0)5#.FWfJZT.N=1XD
82U4[RC(@8R(3OV.ZA3K[_f<e/I>Z:f4G)ORT(2YVYAKag2)._0+F:;#[&+(aMG5
@.e/XdA3_(SU&NP^?cOc/KPd;dd6a^.0?0-YDH+<F]7);#.F0PISEDHP]N,eAd(L
;B,8,QMM-<H]>0=JZ8cXCQSP.HbfaF/(0T#7Cbg-HfeA=QD3UW6.f^I-J1VH;9H1
=?fS1]W[=O#99B#C^@@3&>5I9V]7Mc?ge\B7Y\RMUZ39-8DNI?/BL9THL;>Wa.f0
\FeU\.91CY8NY,MKHIeD3O[KQG.X:7JWb(NM5#O4?L-P_cXIAS\7I1I#8@NO:24E
+2[=X0>&NOV:4KIL7\TN?gQ=):c\]X7(0cAe8K#JB/-IaPC:JL&SMVK(;:,R,3f6
,P.-6ME9,2/\B.T32A@_3,=eeDeKN(#9EE1a;8XdE.b9aH:NS(9CIg7Z75GL/7I3
-,PI_QE0eHS<=VT8#QP)^/HV]K+R&>fE_9<@A)XZTP1,<Peg2b69.7a&_^:F+1YC
;#(NfXX4M6.OY>9N.Q?I:>Y4a4]N^(\fa#,\7S2A\P2=#.R;bdcJZ79dP9H#&EC;
Q7H+0c)IX0E&@R?FC5d&bEbGfWdJ-c:ARg9B8,1R[aa5&JaR_)QbJA,W+1f=E#]b
Q.E>6/>Sf:(F=LRJX5EY\b_-IH+3?g\],^Z=EWf=IK4e&LYX&W>^8f\;/^?@(NB;
[]Y;-[M:aQOAOce&+=a58U[J2M/N&<OGM/TAgG-/#5L(^3cBB\>Q.2T]=KSU&.TY
D>#GAMU^.f_6<[DT89g\1dVY41Z26R-KQ#=T-W@b2fNTDbRSZVO&Beb6WL<5V_db
I1;04C[96C(SU&4JIKbY]/RQ&beS@AK?b[PYO)/W\a57Kf/c-0-eO]fIL^7U3WIZ
A8H(PLE)IXMQ87QEb2+.PgEF1V?#Q04TIJYeF<c\_L^V0RIBK24]D.)]8^I=gB\E
;e-3M+?2(gC/DRDJS,a^ba1TH&HA7_25[NUZHW9gdTM-[KDeMT#e2Jd8,D+MC-0.
fA\Z+SbL_DR8L=Xa[A=I5FXV5M](,)=HaGR9ZeU0;<aHIMUKYTa>KK=6UggZSZJK
?aGcZa_^MTAbP<\YU)SWED]8F8aVL+>367FCKN#--ZR\=bE<W5<cL6SXc4?81\MQ
AZ1JV5W_g,P>ZPU9GaI#&e_.N3Q7U1Y9OW<O3M5@IgE,gJ0:\:#Kaa4UT8FbKU5,
(3#,0;@7Kg-&#Y:XgB]R[O+TB6+3G0F#8XSPV]><UU:H3\bV@<)>FH@cQO>QI8EX
fJ\-\&CH@LCe.KNS(-VKCc/9Sf??A;,[(,a>T8+[XD73ES#P3Jc>@=+3UM)[5H42
bf_g.X@)JC=^WED)O&gY70=\:-Y[DFZ@P\0[VW.7C0?Td(:Z94?(IcQ6FQ3FYUf(
=7g/XCE,M15?BRK\2D[M=U@N5A.RaLX>TDY?gYLHKDIBR-f0?(0=8E-1Ib;]Q0P4
]Z,\d[]/9A.IBHI-(N6QR<T3#Ze)c>Q\^^7VB#9MGKUA>H74V[c+#PPC>8LN9XB?
+>KW(c=1fG<5>R_T,87,5GP7V;#RAT\,c99.NL2..4K\Q;FXD&087:L^R<A2556Z
;/_2O:c5#IGI?U2C_2)FcCF-,-QVcL3/QPY?\3///dC6a3H(EdWEb8cU^Yd74TWX
Ac3?P]TOYRKC?G_61Z(A&IfID@bCLE&g]>VOaJ^;5NIbV.C20P:R-K62GJYfS,_T
]@@G+5[fQf-9\)>_(7<X&E+T_=(a>OGL#_]aUYBA]MW3f,O6a_J=B:g3?bSB++FX
UF?bI+VaH0HP#f&E4S)QFD=6BF?^(eM3WPF\0?#97?=6OD)W.OBL8XI3^g0-E@4U
+A4^CTEWS<I;.Q\d2g#[F8GW92ac[?[Y/(<1+YZZ3/E62Vc3TFPVg92aDbEQK?.I
[VL\CVBR5>HFD2I+M&J<L5d]B9XX4>S0?C3.62.4^Rb7=X@\Q=>a9O4RT]?NJ+&e
cS:U7NWO1,OG)-N?+PC\5J>DXAF/D(-3M,LVPcM8+8C#]M^B990e(C?RX]=aaEaB
XG+[?#QQBdDJ6T/5#=e5G0P,LE\7P2BC/9FG#cId9Bb)aW6JOJ#_\SN<^I(0ETTV
6WZP_2VaM87c(3Te\.#V0E2K2_[5I=X?VgZRA6C5&N>,XYaW36Wc1Va[WDJaXaa&
9f[ZFNCB>26c[GTfP8.Y7TGPQ9XD/PJFHMQY>,,IgQ5Y2SF9_5KR&6>C2SO#NGQ?
R7-#UMX9L(62LF2QT@7b)a/_,7cZ\7>Ea8;JK1I:PSd9Eebf_>W1G-:gWPT.[cd7
2MFKUMLB7A21TcT<KC,CLQ@9f/5O+EW_SOCLW(_N@Z?\>ZB//((TO:eB.05<@VOS
0O0U0Y&TI5EOS@cJ5d;\=3\_W\H]Vb;&?FV5CEL7:_M68)^>Tc[2eGdCUJ678U;:
-.HPE(E]7b1JUb#VeIbQfW78[aR-,I1,J]#Ga2;W=C7,6d&;LR_<<<?P/gS)E_8F
8\8g_S4TGB]UJ@_7T+F&M@<-])V_5NZA5]#6eRI(?e?+&5=O[f,4)DN_OfR?DQLV
0HbBdM4&SE8]a,^a=T7#ZHSP/^XNf<2W:F9(:S;2d^3/A],.a1.C5>_R)NI]cHJ_
Ya5/JC[[[(LS<:Oa_-<+c<H3&-?F<05>@d+Z8>eS[Z]TK1f?TebQX2I3G7=AS<9b
&Kd#Y?.<8>:<=#L6_#W5#4/BKQI.)NOY9Jf=LT,QUDdY^=->N_YY@N36ZV<f^0e,
#?=[+9I-ER3P8[;&6CP,>I+[aW/CePR+?Wde>6aUVa[Z48//e,1dF38N>.[gGWXd
1JMRR>1LL=SFI[NTN]>(9a?=?Q8gZc+:dF&DBD3>PXFCAH95?,ScJa#b[)\R_c25
dBKf>H2V=V)ZW#5B+_g8MgWV-_^SZF^OSYg\IUHQR/D011^Nd^>OY7M^b9?+/A?F
ceCL[CM8#D11eUQ9L=cICSIM-L]^Cc71R5.C,V]3LP7aOFQe(EXb.8[A;2.(=?Nb
]PSWf<@49DGg?4;0),Ge?38,&>JL:I_#R]ISJ<2<)^<>X2=(^=L_b^>g\+9Y_PJX
C1I;T5Vb2N1fV7>,H5f:HG-5ZMB.=+MSDA/)DR@8fXY8[HU\TcP_O38BX:WD+_VG
60#SLdIHZM1EF(U66,=G]I9\.Cf0[_d]A([FSU6=IRKbW5-KB.0+?])94CG64,gU
?FaK=4.T3B?f2X6G60Q#NPg>C@cAXTCN@GaAQXGMI.UIN:WOR9db&a1=1;S5RgV;
0DV8=D#AW36T/P9/60&/5QM_MKWL+[(?P=@Cg5.d]O[_L02#&?L-,BLQ9b=fN<#T
)0J,67>Z,GS[^&H6+#>Q&EafY(;bP66RCf?D.Q5AfBM(PcL977<4MQ5G_URND@5X
=@9c&V./FI6#3I-Z8&&FCKJcU:VB;E<bCW520g>b3d?,KC4)V8.KRT47H.,NUTSX
#B#_bIN:9V^Vf0ZI/7#K,9F@:e(<4\;)??T?(c1Y)FB<IOZ3#KO?<^2@B>30AV)c
UI5Y#bQ;W1ZLa4Q5A.d03H]M,6K2@VU[,>0(>&W(H/BPCVF,+f@afH56R[1?.=_>
&_[_7:XYFSbJ^GSabTPJ9g_3c5O+>8H#(dJF=/Ha7S^R[TK=B7+LdM2TH9Qd0T(I
H\8MgTA2Y5<9#1OE1Zd7.D?1A;[YP=H@a+GCSY3EIA?K1KI&MQf4HOWf+9^+3K@=
&3[F=A,9WdU[X/C-XW7VDBRJ/3B.N;]RgL,26=3/:UF8IY3Afb^-/;YZ,8Ae>[4C
EX[939#>AS0J-IY>,CMeV/+G1S+)W3N2?2<(4YB<d/CAFXCDMBF?@GW,7XU8?AWP
UB;HO^6@:1JdD@4ON<M5:Y,^:8E&a/FAeSEE_>LYC;S8Q:VR&ML^0#-b-4&R\O=T
.&g56fPRIJ\I=]7S#5Sa;e.2Rf)0/AO<4575H?S#R86<<13P[c?W2U4?D8XKQXP3
H[SH-(YU_bK(-V(g)_a_KHZLb,;2OH_,bccD\G.^O24_HQ,gJbIa]#;J.MAc1eA/
[4E3ae79+.[#)&ADV7SOQ:+2I\.PI;6YCc?\YV5[QcLOgYf83#KJeG6>0N&T)aeR
#9+##[A.(#gM;+UJS2JVIG7(EfTKD#f4;8YJ1S_)df>[THI<3C.O-6]G?ZN.AFgR
MA,GTK4>)42TCD+OQ_.XKI21/Q6Ja,SDbI8[Q,EOdNg6<>UDac26VgZD:W;.cLE@
S]5G#-&#HO+2L48P,XZ\?73;0S+8Y4(9HM/IW_EP0&-PB,^DTU^R-+UP/.+BKJU<
U86FPJEK)d#&Dc40=V+aa[W=QL>M2_+efIS\SH>U],J^@-&/bFXZH0_N[DVSeCVX
ABDYSH&;8_-R/5Y03fbEOXS=JYBOb\U?gE=AXX53DKcZdX2O^^7Z83KT\8PQ_P8)
_J3&RZ5PLVU_:E[WbW@eUJO[ZN>XG\[.XE\@e.P&Qf9F&-[:,f;MObZ#<:7H[Pc8
)EXC2cCR6S<;_?45JIb\A1X<PU=B>UTcN)K5gC#.2c7D761aN>AHK8Z_T9=bKGY@
R\)>]GOC#JGJUN^X,=Pg:T2&G_6M+CfA^T=8gg4-+2f0#>(80YGeL39=[\MM0:^W
:S6U&#SUK@K0V:KKJ98>f(RRcF(Ag(;//>Y\^NR;6R0\B2Uf7]CgICAG7L9SD.M#
fC=(BV#3G@T.VKRX3M9M<38M@AR[Eea@.][5/Z?XMb4](1A>II:/BZM,9:9?KW9&
.&d,8NBO0_KUd2;^NX_@3=.B=,9K_>#Y1Y)_RB^,Y^L^+@Z-33^9E_4Z7U/&caJT
6K@-dC?Q4T;c<F>:TV[0d;dPV,2&@c^;MQU0FZOcaXZW#S6.^B]0[FLGQ+cb?C;B
VJTR&W7)(+D-6&QE63fNFd>]C0BM]=EV6N1TSPEaYVEW.R8V8A0W;X2(DRb?C#<P
b78d,ZB9TK1:<-95)Ic0+,fJ6DMT=<K.\1Q@?O[e>5BZ>&bF:3QQ>H6YRSXXU3C;
I:PHNE([d8N>fdXF6Q4?L#B(/FbOA6P_F<_G^B1[f?a/9_(Y0b6MMB(WW6G[;5U\
=Z.P1],ZU.[NB_1/eGJFHCG8H/gbR17GNH@Da^9d7cM95/?EgS39<#F++Fd:_M8C
\F>7NX,=F:=HWEIOPD<B:Y951@ZZNA/^?L=g:7_PDQCQc1\WdM^f^.F7@VI5PBcK
PJf3P/_;T(LPfB&CIY[e_EPG6[X>XJ:Y_(e&?2L#J<P7^5RGQ4CA;#a>T5Jg=[,S
4;1@SK<=1[6,DH3eOOf8VHVFJ-B4bTeTWV)\.(<79U8J[(O7a/>T8.U3,5F5SZ?F
NNE48/:/KMK_WYe9JgR.]G(.dR:UR_#>4X=4F=&PKZ#S3S^c(^RS8&9;W<AR<8,B
2(/UXO4?>H]2_14)34N[2SfMa_Z5K:X2O+/\MNB50[Ieg5>+L1b-d)3Q5/6@)@5&
=5g=3-Y2UNSF09-<XVY=+\2.C;/EN^\OW:7[LGDZ@B7F-Ga75c-#cMPYID3P2c0V
:?^VUA(-RE/#[aOWG@E.V;cOAD0#-B8I_cR)WeS/=&6XeI)dN#EEb]J-D72c)3MI
=X2[B1-IL_RJD95fBJ)E=.aYb;[T8[I2f5[J<_&Gf1/>TeG/2GTSA)aE^bPG1KV6
bH.^VW-&\E86QX&Ia[6-AG\,)4,c-VGRRg0J/(f_H#BDMd^3;=,M51Lb>1BIY]JY
G(c<9LLd73@__@VT5P/@?RUE?]FRUNeLX5:Y[,0T-.>].IRJZ,;.1#>?O\;D98ce
Z6P9Z;?A(M#N6:b2=b)XYK.6GQJ/#WZeCAUU6?5e,6#e^S^#L>a_V9f15EZbLJAU
38AZ7@_H^_)+PJ<gOAcUD@H7-;4^#3]FdB+TEgR[BN\YNeZ0KD??@2]545WHN?Q:
9dI^:8g6>AT-S33W8\^U2,],5.7A&a,HX(GdK2ZS>7CJ[LAc2F8_F[(9,@HeZ->b
-O=MK[dN=?e58PMJ;+7XU#WM1(Rd=a]R6QO+_3K:fF9ZV0QZ6GLGP0H)Ma7U/fTX
?ce-+_5[)_ONaeVI,/G?g9W4\K>IeA(B>;K:ZgcLA>WKL&KJ=5<(?/f4C?[B@TL/
T:X(Ndg+BJ:-ec3(1FVR&_]LQOJ3KJW-I@UTIP[KPNc)X-dLXF@M]3OO<3FP/cA3
#HOd#7RW?/]NS]D,_fGbIJ6TB<\@K;_C(d7(LK\^BbPZXB_)EW7^bXPP[_JR(I5Y
RYVP7__TD,-^b.0:>,+PDR7Q@b;86)LCd)GbTg8</P6QI_WJM[,F9_JbDJYC,-76
@EJQCEE_;^Q3cWbLGJIRQ+6Pg2/B=#L<bV3-OdX,+EN#eC[>JJ/A+P.O=,B1+M<9
c33bBRK[K@?d#_=4(AR[6BQ/[^-846]--04^d0]G3=S,>@9FZ[]C/J=8LA-)L+RE
&Je\N2f-VOH#-71.S8bTb(9?8[?[<L77[\3FKQG:^T2QRO/fDNX^fB7:dfcU3+49
ZUZ0TD77O0/+[d=V]Jb2,c1CL,0)^O<S+OWXI&c4gW>7gJ1f#<f4b7Y._2[RD8(2
P.)O..CR=:+_9^6L95c=&R4G4ZQ,a[(BED\SWYQ_I)I946-#C]8(JLQK;YKV:AgO
SIJ3A>\Ud<)R<#,GC0J9aWc@(#Sbc@@;O9)LRX97:DUS:]1&BYVLL;dLQWPE3gJA
ePPM^g.CJN8;7g.0+/7),<M@^OII\@Mfc&CH6cd,<W]-RJ@K^aI3+/3aQB\7->@-
a3EfRNAg(SR<fSRWM#JGPAJ,]S3,-AWZX+XVGI)Y,3J-^c)G+B@fa:E8Yb>B[V<C
K]ZS:OTC/8/R,d?FgSWK&H7bDHC1@><2@EcB5^DKF/C.gN9Rg\>M=P3e_G1IT&WJ
5KO7OgD8d@d-VQ9<bAc+7]aB8AGgV2BL^/0gJ8FT2QKcLU?&V-a_&FW8,6@U91GJ
K7?Z^Q0232E[:c??DeZCZ^FQV9._M<;.C6)N&G>85VdDK(G^>_FNFU=3YMKCF+fD
<\=(4d=gL:M,>@B;HC1BUcbg[;<^(FMP#=^.,c\DFUdQ.7CeBc=@]aHH])aOH]7C
7b>#@FgA)d;@P>c3#bSHK2UAMM+E@<:PbT4MMfI<&f0Ec>BC;.Q,/ZIC\&DGJD:-
30_ag8@^b12DBE:_C-],HEC5&T)1=F?\U=9Dc)EJ#Q18f9Pb+\AV_921@;&1G)A0
#cUaZHELM(KbAH#^+6(6X&ZdAY.F:HT[XMa)@D46@K_,5O<TbOb.&;9ggMM=g01Z
dR\9[O14ES?U,L.)S2.G9D?=-0Sa-L80&JX::?J]aOH,H0d+,+=AXQ#0ZPg5a2WP
4-S/_gLd_>L87/b8Nb1=V?Ae3Kc?gC=K^MTVD)S=C/?g5DL?9,B1gZQ]L:@L/R;,
_B)R0]U?06[fV^fPL.Ze&#AE,<UeB-bBD]H(+K4BS^B:9a;CAOF-/#G(D_^M/eed
6_^WJYS)6Cc>c#W@_<,_0JgHa;PRF6EJF^BEeTC(O\<-S5?JdL,X3--8Y;@W<=eb
NPH]D.T>e0J[@]:PXE&:>gQP@5QaD\4P5cP#HOX]>/?A1;@EQ<[80OM3IMAg^Z2\
2#56W>7=,B91PQ/O/=31SQYI5G2BDP4L<=Nd:9H5F58U-eVM\:6Xf0cYQ@_(ECHK
e@PIE&^URgWNXa_X[faH/IfZ[^,S2]5GM##^@OA,PVMDBP(.(=0;QY)IV9dI=@c0
+3AY&B/R<8Fc)/7]aDC7[1[P[0a5BRE2AANJYG&ZaYJfdd=G0F2_T/TM4>O_+Z.f
;EV/J]3NN1=1gXC\)8YHQF@D2K&?<-Z46;^VF<NQRS8F@8M@Z(]+E3b6f79aS/Y_
dZA)ERb]5EFed]C^Lbc;fIKMAR^&WZ9>T;21+\8Z0Y_A(3=BMaR9e465?agI[LN2
aK-4e6=9C_10aa#/:L?Z8bHX?]Y72.-+Z/YGe[G-BEgE<=JVEP;Z_cOa=FY#9IU)
P:P#]GMWbbbXdY)>:N#KG^Lg^((Z+@BM<K=YHHfZQa(,aRP#,Q.4-2J:C4\SP\_,
fKM@^@3]#(><g7FC1>eTcDQ:N33Jd(bU=5b\gENU8,&5O-_8^bb-8<-K,5V\Og<S
.N&WPKCMU.Eec]#JB@/+U^Y/YOIGZ++=S.7]Z7aWVS2L\C5-Z^X.TP\R[c:^C?dK
e6Sf3eZ8F=VXN9(O(,C:R]:X4K=E>=#)Ff>9X/N4LB=F,)B7d-[T-UPQ[BJCH-?U
;bda;0Z./Y13HW>#CeDCA<&MJ>QJ1_L?0c5WJ7]+L_HWZXP@O<BSe,J,D5.1FX9e
EP>Hb#^_?\gW[9>@Y]BaE,(8b.446UCBc\1Q.cdV:2&dF#/&=B>\?AYP-AI3QAUA
;66]F#)FC,cN,9)&:3O)7-g>F#5Qg5DgEB-;,Q=;Ge;>Vc2F>@[&;V]0HO;7207M
]Z2B4KY;)K6C;SbE>OF@Z8a@>ISc)VfC???WdBR<X>Re>9&DaRVQUS5+9]U>)J5C
G9BW3PYF((97GKYIMAR6Bd<Ra,SSBaVGC@/>;#SLY5PGE0GS+W<.=d]V2)QCSEa,
[+J=B7O)3Z([-?2>UYWE6AIL3KNVUZ]-a(eG;8/+&f=#+f=O&M:N?3/X8DK.UJ#^
];(c7;TVR8#4Q]:98.:B>e@RDffF98ZHdDYVH,5TQ,c(H(U@<CCG&g7G#4LF[.=\
JeQLb)X,[1EfEf@cIQI.04Rb+3(V1.T[(H-a35@>&@G_HF\UIP#\Q<C9SY6IVQ(V
OT+0^cV^M.6;2+gPe[K20.=H8I:Z]K\-2B/e-_9L+\_&=f)DW4,7bK:YI;VeFG;U
.N\7:LY5?C8LZ4\E6,gZ=P8;\4Q/YCLK\?gN^>.aN4g:N9N9&T42+b<:D:e9\V\X
_4Y[LHH.6g240<O.=Za_\CZ1b.-16^;TgM3;Q+S()_O7Q(g7-f+U+-3eE<\@]SM?
37dSJfF^^F<Y+-CT/Z?85fC?_;TD:bG\07HQPB4/+WSfY0Q:9Tcc@Z1e^#S>,/2Z
C;8^-M]]V+A[,#0N/&?YH+>Q+0#eJ?O7+BDFJ66CZ+03D+aVPB3.7E_faf=7B&d7
0\25>NfD60=SLL]a=X=5EJC+)J05B,T6Ef::HCBC,T90;&6D_d[8RLbg.<.4KgI,
C#e\OOUUR@_U-PYdOO:g^QW-eWD>H32,>AJDcYFKS<UD/S^dK;b>(B9FdbB?#3,<
=(65]cKgR5De[;(43\V^?5-_.Na:W&b7O0O4O-8)<Rb:Me;]eYE@g5ABF?3UBE86
8^:1O:IR:0#VTJ3bRQPSP+M_1GI.RLA1V;S_Q6[B8S<;]\):7NJB_JdX#&UE.CM?
]U#A\(_]F(,O@3HfUCY]@+>\B_:B>-C@Y?cEW2LOQ-3NF]\fc\4J3P./)]8]=[#B
2\a,^VM^G;@K:,KLE9@?6?bMgRJ]+c1LG>8V402V[UC9E7#d4Ig1_&0^OVYR\/Cf
f6V.3K0TaLgI,Z&X,#G1VQ.NBZaS3bNB)WWB05KB9#?Z^LOU8#UY8A95IAYWcfX^
A7>CM]X:CbGT,J-CEJca5=/_,GLX)O]\83Td(2[B5AK/JJSI>-4:6]d-;J4E@#(2
6N)[/V6WAS[IPLN<a)P74J&8E>,d<#?XQEB^R(RHG\59R(CS[)MLD4CEN:VC[23;
^#6Zf)d52E1Q9<+&DK@;+gXDW^IG1Y]1?T1<#\JEeSMb?_2)(B8?@L@?cW5_47e/
<IYGd710KYHN,9TO];B-I,dOef?)D12BdK3K3e-4Z)-=1>^L=Zd34<XN&UY]S^M=
X>E]]8MaDLbM56+BH7gc_[KQ34?7BEQJ1G<#P8e[4:5A;C4g2-8/8J0K+,_:@^&@
K]TG9F[S^V<cG4\(_VV_=gL<MVfK34fI^;Zb3MO&GMZ2&X:PRP_bDe4/c7DIT&cL
@0Z(M.SWc-GI;A,?2C;U.VLH]/9)H=bG2DW0#\Kc9FQd;].JfMb7F#28\..52W7T
-4YZQ]aR\+K_?4QFBfG=8/M>g+CAR15Z5XCf[3\@@K_15e<DZ?3e<8Zg/H]#[d4,
Tb?\HUC6T/Sb3;(-.2/ed,HT)YB.R<>HO2d&@#I:B5FU=:D_ZA@9>6XV3BL_[Re[
FPcU;;..K0L(G;AP\1>CX0OUGUc4OF=M+.cdfEff&[/VG20TMd+)KOU,Mc^>Z7;H
-6E(<H)>2PF#QA8E7b.JHb^BJEA3]>aad@]gIJc6OS/(8fT,.-7NeU6,W+)W.f56
e@:eS)U9TYDdE[L;^FIeP2&R)d]&A3QAaM,aC8^BF\[g#gG#-=U2C8FfF;8A>-]C
X=b2-E8]c)&3O8B5R&?(AW]E[>P=:1;C42K?L?1\g(Wc4:[GGTL#FcC2KOIL(4:6
UXcB;RG;MNCQJ3[ECQMSF57=E1I2PZ]RSAWRBbNG/7TLM;^cY.c6>9<8(#U7g\+f
&)5BJ(c2((5^KHXb.2(F;CBFU^?O@BHB.79UP.F4/,3=FOc#T6HT?XS)T0M5&<KH
R/52?7dTQg0>[?/VTUb24ANc6.811,I>/3=V#U6BFNHaL+VK0/WQV[2QbfIGc4@P
?Q_aVd^K49@G.]GIXdcLcGa=L&Q9;WYd[EK=+@Y208)+L0UKT)ND9c+JA3_=#WP@
D-GG,?^V^E0J&W\J55fg)S39LT_[(dReLH?U3&eQ;@:=.261KZ@aPYf(_BQCSVE=
fe]>Ndb1ggI)X]CTDRXZ[5TNC0>@6>ZV:&N4dQE+,FN/=C-SSYVN7-9U=#9U:P]H
ZE+9_b+11PR/6gfY7Z+:]Z<ZL+WSbSg2ag;IH5&.a(2D6R>(C7]b^L>X)\;R1BOF
:A3(R24[]Ra.&X+[+Ae^_B5a/e.UM1S#[d.9HG^+B^a//&HXV=e1XO8bXe1\b]9E
FaKOf8Nc62gXgAP07)2E#_^SO1S3&WcT8V>GYd8B^<45EeaKQ&KYSL+/5K[#BB=W
+V)aZZJSFM36LFd3X\RbQ.9(4^4>gaI:)aH(Y#2S8=:W:1d64UgJ,;S7a7B,@_/U
B>HbQeLaWdS=N<HbaYH06#fUQU<BPcG#.9AE#53HV(NCW<U)OC;JVM_Y8,cEV^+O
Df4T2SQ(GHP/8#OIG9Yf-^LCQ,;BaZW)]2:S\0g6[TMO#DB)(#45]a)EO?-=C;^O
31?LK1L7PG(=L:_:E&A0G1Mb7#/HIc>31FR.6e;F:G/IJ971-4HTac]6cW+5J[cH
WF#/E]8?C#I;?V<88@0R0eGNVbBLOa/1V2CSYAb?[JW[Ned0]&beC&B(ZRO-0V3A
dHZ]@5#4PS(#)aGWLE;;T]9-M&[=cg8FM7,AN3SZ=bfJePXSIJ:24M44RTE2>]aJ
QfT,OedfdXFW5(:2LM@SYQ8/aaNK@?gYZ=7#&TD0.]?5^\g)fEM6@,@4(]ZBX9?<
&gW;ac=<@<A_(LEKIFQ+ZDQUUFd3FINX9K=1__bB>HMc+OJ>5#?IYdCcD(R]caE&
5MO04Q.U2AA#a;X^2;?EDL<cCa^D87I3f_T0:0_/e2>&#IU,G3S)@db<@X.P5AV+
#J2HIBLV7A.BfAAS)^24WAMeJ)5P6NK0,=+bS:,S/Z)KE]c^GG(LARfRGLF+,,:M
5dVOL(YVS,(c6N<bPDf]8>2Q?JZ<SaZ-bYg(ZS(6C<XfVZF&b7d8+?I=V0D++bED
]d2IWZCPGRZ@<JOWO==eK=\EKNK?@QUB294P(+eAM<,W&O:bG]1<2,+cX-(U:HUa
@Y?(P/c8cLBdOEFfZ)Tb5+Q#dR,1Xg(>C3/.-O2Y[a<N3XHd9\0O#YL,V;Jd[AC8
.TQ&=NS1+dc#d#L1G;08QA_:1>aEJR[Q?YZ^a.L#&,Q/?UG0M[B)(7:P=fG6_Z9L
]7\F:ZPNZ@1K-eW0,M]@LbgO=eZ#V<1<BY]G:d>&0A_M8U;Q\?&25c[-8^?BH2AD
@HH>U\0T2-X.7WSUI2V]6]#:^4F#3bDB4C/MU];M:P:THYL_P&^R:5^IJgZ@eV=#
B3OM02H(c9A-=734F30+_@837D;6\XK[TN.)[T?P)J.O=S#GcB@F_-,R/.S8J0,W
:?f^YEED?0,V2QSE-VKLUX@-D1:b8,.+?)N[9T2eXKdJ35I,,Z7CP#5CX:UL[ZMH
47Ld;X&_aPb;T<0c^&d22aT8P#3ecU&D[ac:2_T)H<#Ncfdfa@Q0>]/<<)g\;H\@
P?c]DR7)Zc)0M;/=/5E_3@5VP4=+JB=HFF]9:AD=\(T#7J8/eNMUQ)fUNG4,GRB.
8^-X]X/5T&-DVIXfY2/Y51M.VNC.4)7dR)MZdAbLg+^L^N@^OgU1?8/Rd#V@5+3H
>?=;_R+ZD5D6@D541V[@68gX:B(DUFX+B;/dVT1&8KTL7cAe;V#YfRea\bFZ&)&c
MK#IbJ^GG&I@0T,Ug82H5-[bKSX,J9QZ.Vd2E3UN(fVbG7]Q>GDV-Kb.\[V:A;V(
^OC(>:c63G-FZ8?AP28&<T?BD3K#C6)JYE=,;b+C;N+(O[aR&(Xe><&A(YSAYe[?
Q^E&3)IMRe9#cbHO/YA1cI#)H94+R+);fLE+NI12.#a7B1cf/L=K^U/1e86\=4.P
FZ)OeLK@>K:8OAWWBS-9]LTL54Ee>2YJ[POF<;P)#_K16VRLN?ZAXPcaWSB53bgL
.SG^J_<_=XUUG9bI),5?VR&[CD:_YTD#EQ/QVH8^G>PPC8N5XBL9)@F+^3K_39+I
J7;9[b\LbURFNNLF1V?VIPW8V@]&+.GZ0S\d90OMIEU2Ue[Q(.[<=(A.f]+d/O&-
bG8-PDED/8?.0HP0[LQ1R:^,<fJ0PUBP8d71NE0-.K,-GZ2OE@]XMO+X#N&;a-+=
T#^#7^&4[(&\bUMWScPEI9I71da54^(C<G]S\&ZO)#0\UCDVRcaLH^ca6T1J2F8C
R5b)?#3U:^QBHD._I6EJI;TcOd7Y;\6P2&XBcB(=<a2HW(6:I4-14,G3Q=CF<+Z5
c[PMC0;(fcSZ&CYeEMUC/].NgY5H-R^J:(9/(c19KG#c:(>Q(\0ggDHX<#Wa<#bO
D)-2DK?-gM4C)/ReK:bLOb_^&QMG4\^(-RE0(dDKVV-D0PRTcRg/1Y4W#IGF]Y7:
<IEWVD5HBH,M7]:R>^GI]/cEH?04:RV\D#X4-X0P&10Q)&17eSWH=fKdSbVKJdDW
:7R_>HE/KS8e92?L7V_J[b[N)^Q]B:LGN9=/;@FRE:DLd=9RP2U/CPfNB896[73Z
4NN=/bgUGBK8)+C6aGPBDR=UHPV7g5I1\6A,[?&58eC:7a);a@aS7,>+_XDeI6S;
FS3NBX+a#6b,,I;QXSCXeQI#3W7HADP/Ad1PJ(J1=VU&:c#];.D,V6\d07GMFK2<
@d&2Q(.BcN^.M><NcC8YXOO5aUFfT^1fcV.\Ad+/E\^(_/RTP[e_\FG(FD<FG0Td
d#TcT^U37G5\LJeZZ7<SU)VWMZFB&K7EQC^IB4Y-a-A(A$
`endprotected


`endif // GUARD_SVT_SPI_NAND_FLASH_GIGADEVICE_TOP_REGISTER_SV

