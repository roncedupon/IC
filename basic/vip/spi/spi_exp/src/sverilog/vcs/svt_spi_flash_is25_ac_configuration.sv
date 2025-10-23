
`ifndef GUARD_SVT_SPI_FLASH_IS25_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_IS25_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * ISSI IS25 device family in SDR/DDR mode.
 */
class svt_spi_flash_is25_ac_configuration extends svt_configuration;

  // ****************************************************************************
  // Local Data
  // ****************************************************************************
`ifdef SVT_SVDOC_CC
  /** Workaround for SVDOC CC circular references */
  int cfg;
`else
  /** This is a handler to the SPI memory config object */
  svt_spi_mem_configuration cfg;
  /** This is a handler to the SPI mode reg config object */
  svt_spi_mem_mode_register_configuration mode_register_cfg;
`endif

  /**
   * Initial value for all the timings which indicates that parameter was not
   * loaded from the catalog
   */
  real initial_time = -5000; // must be smallest then all timing

  /**
   * Minimum Clock high pulse width durtaion.
   */ 
  real tCKH_ns[];

  /**
   * Minimum Clock Low pulse width durtaion.
   */ 
  real tCKL_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command (SPI) command
   */ 
  real tCKH_Fast_Read_SPI_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command (QPI) command
   */ 
  real tCKH_Fast_Read_QPI_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Dual Output command 
   */ 
  real tCKH_Fast_Read_DUAL_OUTPUT_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Dual IO command 
   */ 
  real tCKH_Fast_Read_DUAL_IO_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ QUAD Output command 
   */ 
  real tCKH_Fast_Read_QUAD_OUTPUT_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ QUAD IO command 
   */ 
  real tCKH_Fast_Read_QUAD_IO_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ DTR (SPI) command 
   */ 
  real tCKH_Fast_Read_DTR_SPI_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ DTR (QPI) command 
   */ 
  real tCKH_Fast_Read_DTR_QPI_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ DUAL IO DTR command 
   */ 
  real tCKH_Fast_Read_DUAL_IO_DTR_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ QUAD IO DTR command 
   */ 
  real tCKH_Fast_Read_QUAD_IO_DTR_ns[];

  /**
   * Minimum Duration in ns for which Slave Select must be deasserted in
   * between Two Instruction sequence 
   */ 
  real tCEH_ns[];

  /**
   * CS# Active Setup time
   */ 
  real tCS_ns = initial_time;

  /**
   * CS# Active Hold time
   */ 
  real tCH_ns = initial_time;

  /**
   * CS# Active Maximum Hold time
   */ 
  real tCH_max_ns[];

  /**
   * Data in Setup time
   */
  real tDS_ns[] ;

  /**
   * Data in Hold time
   */
  real tDH_ns[];

  /**
   * Clock low to Output Valid.
   */
  real tV_ns = initial_time;

  /**
   * Output Disable time
   */ 
  real tDIS_ns = initial_time;

  /**
   * HOLD Active Setup time
   */
  real tHLCH_ns = initial_time;

  /**
   * HOLD Active Hold time
   */
  real tCHHH_ns = initial_time;

  /**
   * Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_ns     = initial_time;

  /**
   * Min Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_min_ns = initial_time;

  /**
   * Max Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_max_ns = initial_time;

  /**
   * HOLD Non Active Setup time
   */
  real tHHCH_ns = initial_time;

  /**
   * HOLD Non Active Hold time
   */
  real tCHHL_ns = initial_time;

  /**
   * Minimum delay between Hold assert to Output Invalid
   */ 
  real hold_assert_to_output_invalid_min_ns = initial_time;

  /**
   * Maximum delay between Hold assert to Output Invalid
   */ 
  real hold_assert_to_output_invalid_max_ns = initial_time;

  /**
   * Delay between Hold assert to Output Invalid
   */ 
  real hold_assert_to_output_invalid_ns = initial_time;

  /**
   * Minimum delay between Hold de-assert to Output Valid
   */ 
  real hold_deassert_to_output_valid_min_ns = initial_time;

  /**
   * Maximum delay between Hold de-assert to Output Valid
   */ 
  real hold_deassert_to_output_valid_max_ns = initial_time;
  
  /**
   * Delay between Hold de-assert to Output Valid
   */ 
  real hold_deassert_to_output_valid_ns = initial_time;

  //----------------------------------------------------------------------------
  // Type Definitions
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------
  `ifndef SVT_SVDOC_CC
    /**
     * A helper class that can generate random values for non-integral properties
     * 
     * @verification_attr
     */
    svt_randomize_assistant rand_assist;
  `endif

  /** Assign refernce of spi_mem_configuration object */
  extern virtual function void set_timing_cfg(svt_spi_mem_configuration cfg);

  /** Randomize all timing parameters in between declared range */
  extern virtual function void set_timing_params();

  /** Calculates Random Timing Parameter value for #hold_assert_to_output_invalid_ns */
  extern virtual function void randomize_hold_assert_to_output_invalid_ns();

  /** Calculates Random Timing Parameter value for #hold_deassert_to_output_valid_ns */
  extern virtual function void randomize_hold_deassert_to_output_valid_ns();

  /** Randomize tW timing parameter in between declared range*/
  extern virtual function void randomize_output_disable_time_ns();

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Constraints
  //----------------------------------------------------------------------------

  /**
   * Valid ranges constraints insure that the configuration settings are supported
   * by the spi components.
   */
  constraint valid_ranges {
  }

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_spi_flash_is25_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_is25_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_is25_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_is25_ac_configuration)
 
  //----------------------------------------------------------------------------
  /**
   * Method to turn static config param randomization on/off as a block.
   *
   * @param on_off Indicates whether rand_mode for static fields should be enabled (1)
   * or disabled (0).
   */
  extern virtual function int static_rand_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   *
   * @param on_off Indicates whether constraint_mode for reasonable constraints
   * should be enabled (1) or disabled (0).
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);
   
  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_is25_ac_configuration.
   */
  extern virtual function vmm_data do_allocate();
`endif

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data(`SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

  // ---------------------------------------------------------------------------
  /**
   * Hook called after the automated display routine finishes.  This is extended by
   * this class to print only protocol kind relevant fields
   */
`ifndef SVT_VMM_TECHNOLOGY
  extern function void do_print(`SVT_XVM(printer) printer);
`else  
  /**
   * User extendable hook which is called immediately after svt_shorthand_psdisplay().
   * This is extended by this class to print only protocol kind relevant fields
   */
  extern virtual function string svt_shorthand_psdisplay_hook(string prefix);
`endif

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
 
  //----------------------------------------------------------------------------
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

  //----------------------------------------------------------------------------
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
  //extern virtual function int get_clk_parameter_index(svt_spi_types::flash_command_enum flash_command);
  

  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_flash_is25_ac_configuration)
  `vmm_class_factory(svt_spi_flash_is25_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
2_FJD/ESe.1G#KN7S=;CIU?A0cKS9ZTH,B92a#06@0BLB6/SA]g55)[aH9148U]K
a)Mb6?9T]\.MU>f;X@E#--eR1[7-1;/+b\1C?ZfP>7C(Yf1bL5H.ASJ<>LK6YOM>
J#P^2g[ca[Y:I9b^U6]CL1SD,&=5fZ8^g5L4&NA7GNY/>TbW_7S;<=JRGcMKWT,>
?A.M=-I,&OPG,_NdD&9)XL>0_4=R518DIKX#\X3LC65]0LE+3b_&C.-RbUFf4/\A
V6fN,XM[f5)/D_6/=EYP6?@5<7aY&b_8.IL]X6X99ROff[<,>LU@TV<JGHY;gb,V
+@)]Xfc#HdEJ2O]YQ@RcdJBf8:&Z/.cZfS6,/KP?K[\CU-D/_^3+BfB:^<3GHF,5
9_3D9?(T-_bVL;;(Qa+]V^g?C)[-e\Le8#^][AK<>Hc<Lfbd-YD^+8;FS\dY.c2>
_Y1Z6AAPP>a5f.[&_0BAbL#(=89Q47SVEL<F_6J.O]L5QL.P1b0+EVV+5F>G&bN-
O]]G,(CB47,\JSgMB&I?/A2UDE,=1&E&MW/?OKXJZIR)PgUS_/A3E<;PAW.3<+5^
56&>/=775O<7.K8BCc3(Q;]gdHRfPL:TS[7;G^:c+)d.JKA)3Zd3\-6@XZbP(T7Z
aCKGR0a9F3dP-?U=c;Z?.J29JNJ7.WRMA@H@0)1:DTGZ-RB(Q;.#+NF4=^F;PCP1
HH7YW__:T/0b]^\79:5-O0V^B\T(6U(/3KJd65<cN::a(aDCe:U4KBZCM=6JNf57Q$
`endprotected


//vcs_vip_protect
`protected
Y1<3/QCE)2X&gBZ1QOb]7DNb@H34I[6f&TG.(#3c\A4=6fILCZ6S/(Ta2D;[R8VB
P4.9&MgfT8/?TXOM;6<9eDV3dXBeT-]OaSTdgVMLH+F?BTTRR::I-NSDf^,47Z2]
9RZ4A6ZT7^Hg.Q+X7+KMV[?/R^R7S@>cZ:;8W9BO/WUNMGJ^c[DP-D4[9XV=SZ[J
c0a36G(4HD;[C9;]f.DUfDM>ASX5:FTOJ6?Yd8?1JL5:5[g5?^V2=6KGB_e8TM8b
#bFCfE=cQ:X-<P8/P44G>@\12#XWM=&U)P<7<0ATOM3\0<cF8.FGFG1&\gB2.Z;8
5<CWQ,TLJGUWJ.J@VQVRAF^fR.^g#)VVB5843Bc^OOBPRE4O+#LL;DBS&2_PTDU)
_-YLVN8d>T:4O<1@W<;LD520f&Y/2]1],Ea9f::CRD7;Cg,/[::282RfH7V=<4#,
>aFCD[NeZR:,E^YV&af]MCT#&;N>,:D1=I4^BFB9]C,6H)7-_7/E7V<e:5ETCgLP
@A^:],d]G@3LXEIA]:LJe-SF@S2daXe^#H]@dVCTO+[SFK,:4UGb6,S912?2EY:]
fL.M]Sb2,V764UYc;1X,eZE#MQD\FAVE5-dSNG0dM1[fW#AK#Fb-PW2Z6@KK(QK+
KF]-=BD4[9[6EZ8C]:=cc>&^PaW36JL,gEPAgIRZcODYHQBU=@Fa4DKKO&?Z9f=d
\/G]3H0V.VZGB5^&1Z&]UI^.I;gOVR_g/N)12bN(Y(ZU]VH7O3[6NH&=NbIML):W
ZMfK&X0D\(<Y21e01>gU4+L]Id5-U<;5&fLfO4=8@NM-gbKL)=1OA1D_7P+R-I^H
S^I15:.CY)PaPKY#Y<9ReRRWR?U9/-&;<M3S+BAbbcK4B63K:eD9eg[Z.42-3IVY
YN:2@dVO0E6E_\WJTS0XY672.4<Q_V<Z^cZ.D)SYO@1/8Y[]_8WUNS<G@<KXR?P.
:L7-1B.RFLS&AX-/b6=FVB^E37\KIH13&bM,=G:2;Q0Be>aSA4fX\Zge\9a0L]HL
IJU3^aFNaU8O>=Ic&516/B#&6_VOS_F.W<2(HN3\GF;b2@J#B(9C&Pb75QgaS8S\
L>#]4MPFU7QA?0H0@(<8=^[7HY#/5.TRScN+RdgRF4<M:eBIb)_9J<=\\3(+NV_O
24gQcd<P>e.3G,12g@gF_NPS+d;7)Ud[K&>:1RMe501H[5d2f3+:HYObH?[I)TJ;
H_)]TF9Z;#c8MZJ1aF>4-PII))(b?Y5]\PDA)KGB-?NNTf[1[fG4?80-_@65^R6V
a11]4]7D/M:WCA/aR7Q)Iag)BRf-D(W_@G.f7=._Q86L5G6#B=A95&VOF<?(MY.:
^+J3E_97cc3b4g0ZQR6f&e16b]\DZ-a.cf<NQ2]Pg<__JAF6C301B]A;?^J<&VUG
/;(6LI1a8]5?/]9?6<:2[<#QXB0](.5Ta6,T#@H4SZV9S9KKZgX,F.(MFCJCAUV<
XX24^<@Ve9\UUg+G^V@2A(U_BJBYO+PPR>+1e:+JIHGW:)PJHKFFEE-JMSZ=<+&[
)Eb<b:YPE&+CKO:eRgSE7&V=+FHbWR0TefO6eX<#)Q#AT;47[HJDG/1NS479AI9,
Vc:5a4Vd??K5f@#c]&&V?I/QCBA)Ib@QI0P,f(LZ?82AI<C2\]74(#g19@SE3,-+
891Yf?bOB&B_U0OHA7aLRQ<If,K)XZ,3?>@1>-VfM2P_H>M2[CYQ=#ca+#8\GXVc
Dbd-d-=IBOa/@EUeZSAWOYTM:G0J0N9B;FSSbW4[=HMX,HHS^HA86XZ97O=J9LS1
@\2NGP/ME\^>Z<eX<6)-XdT5QKgf;(C>M:D1Gba]gJ[MV=g8^=#:dI@1D0DK9KT8
.MU<<T-<(8QF5V=ODR-D)dF[T6XReQI:SY4>L3L&QFfggE6));f&K-J^/-0&(,#(
#fP/YF2PgcUA?0Y(/.0&DM-Z<.-f6<#YB[_M?6&_@?eBdV5aUR(g&<2[NNAIZFB@
A05PV8?KaVIYP\],0F@?Qg/Q5YSVIFG8f/[T7WA>0D<&5MINNMA>AJV80L)Tf;H4
K03YL5WKKDT7M:K&>X7R@cKS5\b:ALZ:]4G-c-W1A)I>@8gI_KKfF4FLBU^c;d6X
8T6A7>GAIfZ?g,B1B0+XP7F3\YACH-AbM.5=FJL;:4)52O=KYNL2+^FPVbZ[GPNT
]RKO]e)JH@IN=6_W747Ib-]O&TA^IK/KA11bQAeYU=gO5Z:<</AN5_1)(?:@fL6E
.C9FNDX,=(#\0?DI;-<b6:DISEN:R@+0@N/,W2EIM1YCC+^YNK@2MIS.L]+Mf<IY
8IfN3@F\DLR=^X1(^Q]Ref^66I[S_P37[<1.;??;V6&7XZ01MSc4=eE5W(bIS]AI
S\Z5D[W<NB(7#.;JL/3PX<X,bE@A-aVd_Xd^Da7##<eRMK-E:_F\aO\0<7BLO^F)
)1N4862&Q3U57/TM-87=E^XFB05K6O\LA)]91OLGVE<g+GX0CB8.<^CN.WK#3BF=
EI7WOI#<\3:V>HEJJ::81/Kb+KS3>,E^WLaOQ18<)HP5H&GVa?5(CA-YPW:H(9.5
fBT[S5C[HgaMT7C:UH?;4?FKM_P[b\eT#>-U@/e=S<7gIH0<AMJNW&S<O+S5W]b\
>_6A+<Rgb^=T=14(>/g#Eb2O9GKc[:^OC:7/.?cW,Ld_I.0fM76\.Y)EV6SLCS0K
Y2aA7QHUJ?P6((f,b)8VW7a44LT[ONIM>FYcQ8c;+YNgfHUJK[(@W4e76bXP6MUE
.6PTV1d[B&TNd:44OZ+==C#B+9d84A^?ZY3+6Y6M6D]7eb)PdHL&=FCbMN:&5U^X
F@5-J69:18UI37#71>MD-7PL]g@@-4AO@>U]R8U=[PKO#?QLGUPf[M4MNd,NEIUZ
H?==-I0be@@68Q<>#N;9/024VYFW;3]f,cRe;)5?0e&+eNHF?-Y\d889>]1N/WC8
&J>P1fAH_dI5J^9,J[18)FZO3TXR6VAA;gZ)#LKL[5F\[?UW_5YMGa1]fg_Lb-[:
/b3^:3M47G/gc3ZL#BK.<a>C+L:FW@FGg\/d0dEASY0E(RdTGMHV<c4:K1^3QYLI
XdR.F24JR.^H_Q=5ff9R)=WDA#N)]VdN+VQUgEY4NA(7[f6R]4T2g60?3.26[BZ]
c4JW0H1XCJ]b33=4Kb>I7T<bG1Y\[E=,^2<6?-S>@<+S<7d8[(06[V/K;a1bK263
eRCM:S[N\^2/4YbH(,N+Kd.A5L\(IUDe=7L)S>U-)>80<;Jc^.fPU+OHH.fB(bJN
/a)b?J,]bF\FJX:G8)?aWGET5V=Kf;@4CQ4)E3FaZ9I4b3IJ>TG5@=_/dW]H6:EH
R0b9e]<L4^+ge#9^WWP+R?698KSW6R1P<<_MT^]JBX,10c0>]1-14^8f-:9R]&9R
a564K#2>^?e\f[LP9NH6I6&8>ac3YTG&D1/,A.OcZ))b@c-c25HH^V6M;P@]L#36
4B\<(B\@K:]UM?ZcFAMXHD[bb\IM4.9R>g)&eK)UT&:K[+0KQS.6;]5aE/6D2J9I
I?H>?=Sg>M:f_P.&bc3^eN6D6//d3.[LdT)M+;&WBgFTeZS4-FZR9BNgS(b5?MNM
8FQ5>?.bf/,:\21?F/M]3bU/N,C#deUS-P&?e)(EI.@&cbO?ZI][J:Kc,C=NI;dA
6.\b+336S\&?;PaT(dU]2fMY>&FZVGZJN_V]f^/@LZ<P?;7QX;2_)c0?QWZ-P^5;
=2f\^L\B,\Ve,6U.XG>dXV)A#eT[V(,JI[+^adKc?:-.>LK;8VS_>K,&,aU)10RK
fCV<<ZgbEY=>6/We?J[1.O4BYd\C;MI/UW1\L)@RMa.4W5XRXH4D3gF8QF2N-cM<
C:bSbMR]gF4c0Q::7[g5V)9RB0I>C5>^GIMU@6=e3B#CdG94BFeBHeP-&>KaL_4K
1-><d(-I0cHDLCG>SXB?<bcK,:9SF_2+#;D^ag[#HY74b@OAO4_U?d<WE,PUDLQ:
P0Xa20Fd:6[aa>Vd)6;bG+Og?g^4/;,86:TVe^MY6VbQAWO2[C_NgVLbEeZ>=8^?
dI)b3e36@KV3+<T@3a:aT1.;@;VM]SbQ)NF<P7XUP1+8@79#2=Fe+38+,;-.GCPQ
J[aa-]-CdK]WEaMJ[;,8WfEfA(WZQ4f,fS,9AC@/aI9)-XO5\J(+NLQ-:c,A67,#
J0(/.>0H8c_YQS<74MOKA(\;WJE/5]SGCFdCV&<0>75_V(bV_R0TCF<=W:A^8I32
e?ae/1<WFBU#]H1MV5;G)Pe#1,VY/936,T9Q^24\02Y>>FMUAN./><Q8C;9^\D[]
L&d2Gf1Q5MMXMMUZG+R9BKBE(7;RSb==<A[L8I6GPXJV43]&J2ZfPR78HA6V?J;P
b@KJ7=;Vfb8:Rf3YMae5SZ)9.N3(eTO/TM#dOYGQfCZ&6^F<YWJL1]XW:5KebU6+
Z5<-D^cd7+EKCJ]cP]E:AeK0F[,R4.3XTO5#GNDfLUKE07<G1F=F=g.MK5M]3@2f
C@M_JW]Y?W5fRb+@bW;fY@\Z/.5fZ[J<UA-FE4.[K=R;T^HUE#gQ7[3(5eR9@BCW
=M2\SgFNcTP:Y]7faJ/71403J:;Fc8K_&_,]4@fbGbZ;@Q<&SZL6&[cILL9/L?#.
5VAb+265](Md:Z.MCZN\\+_UPV,dR/I@]=eM#b[^I?0)PTC4#+JE?>X?I<3R=;U2
f2\YJ^EAXOR7@(I2@bFH,R&;A#LUA]1MDHIDMAK1]\3XQTXT]:<C2X5.1Yb+&4@1
SR)2c@#e7a5G9f3;_:^)A>KU?6B+D\&P_UFF3<QP0I.(a7HEC>6^BP=NDHDYB]XG
+a&Y9P,,NQ7cL.bGWb1=GZ->M)]W.3^TJ7Z)#VLbeK6WOXA8FV;NWP[b48FVXe1T
KC<RSF6C+_2B;3RWXf+>USWbGOE/+QeL[Q)8(-NA&beG+eRL4#3@OP^QcD(Rf+IU
9#1=6I5GNF^I&:/2JD[LfIS.XR@bP/JD-3e0/7XE+X?RW>S9OdcM@Z_PFE\CQeV?
e,B<^,7,]4\V-XV;e[C\7b-C,#1KEf/.+>b[.c]bA5&PLbD;Zf(>LNSe<5/a=Ha1
Pa98_6C0aG/?A[.F0.@PPI]4X>:ZYf?.Q:<?HPHJUYTHBOA8H<0KDZ_>@@e)E_5V
]]KU0Oe;:HMS06I)OQ<3)F;,PY;Yb4?WV(c[B8G)#LCY>ba[_?cP<BG1aPASfPZO
MII03.7P1c97#XY@ALUfD@aV0&)RG-S<Z=E4U\@QH8PX.1SaW_-=O[+=\^/^[5.d
EOe1V/4?>X>+0][8F5N^=5=G.+BE9,14S&]5JF,_F,fZ[@bfg-RUF(1B<Og747cU
3KA@D4,Z8#.D5=c-P[1=.[7]d>]0e9XJ;8YV(9=e[KX8L.K89/0=X>RadCKEZ8,e
417LQeOdHX3/@Y\+4J3[^_]@ZB,K\7f;AaY\G08XK)N-H5V/adAX0^a,ZKg[H6&=
CQb;@gK69-5,a8IH-<gc@de\YG.aBHL9:5W.:TfM;6#B25gSd_;I?7gH>OO(a_6]
_T/4&8fXdOP_e0(Rc5R/5I3+?)KaN]#UI<4I),Q[+d\C(OgCVQA5GNeDW7KdKUZJ
WODdA@B#@f])_e.H1O7\WWQJHGP4TcC;TJLGBP;WPGB^51R&TPQP[P=K57A6E@d]
-O[)J,<LGFf@3<Y928:5>C7BJMPeFTKF6JYT0.>6>6Z#S===_F2&-X#N(7JQ-DJO
B&/C&7.e:6C:JOEI6\UY[(QHJR5eJgeaODa;>MJB7QBLW(W9FM6JU_dgF8eQ@(&c
#2C.L7AH922#7UY5Y,eU&^FL]8(_G&3EE^1=-f3X?B6OL&^BE;^geB\e7fAEJ(PO
-:?=K5RQDTZc]X_f.,eG).<caDX)CK6[?JWL877Kba2(NbFR;U/CGMUALA(=R5\W
:QQQgK]\4beLEM.I@FgBaN_=1S)R9RNKa5dEE#)X3>#&&PMAcPMf;BTdT2#4O]cd
N&YCc-(K(<_N+&T]8e44<Z#C0f@)_;a/0LU>Z1HSF:MXa(P\cM^N[cH51QAAK,^S
&+?+1cG(e&N-<)H(M77#(KC?#0W:g?,d2Ca@O9Q8\0,:(P.P3,#d3K2Uca(\I_RW
MZ84OX8LGcIF>C.2(e+VM,62Y.1V)6^7XU-I8\cMZd+d(SR^P0P/OTV1c0g.YB,#
@_+(1@WOeLWX5<PESH-eDFN?bP=G[bD6Z)FE]g9E2/KJ8fHDG3\7^IB;7)<@P+P^
.<+^WKR&13e5=\cYA,J/ME87(6M=/NZ.>B[E+U@@,+MH25SVYf@fTC)-H?0bbUK0
<_.)XPR(0.fB:e)M+BQ/6-DgHD;7@P&6G.CM+-c;8Y8G:SICOO=JcUVA)QDCY/ZR
3C^L=PT&cJ_a4L-Y\(JITMWC=9/)])GNG^O&SeR1>RENeS7-I8Y^&Z7b-U3+gK:4
d(1@S3TP37&ccP]9[5)g3+Z3)F4AKf010^P/ag0KS==FY)^V?N/[b1FK0P;Da?BU
]H>^<cUH#F6QcDMKNQM2d[->0_<06[1fd7g(dQ51<fY,J<9N1YOP5b+AJG_PS5<d
a6.0D67T9+M),#YH\Bc>X\-(c4-F-aW^Z>eYAM2-Y,L4XAZWF<dg9aJ0X1?[>1X0
?L?<8Y#18W)+bfc&B#TTUUIR:Bd];@X-R.G/^2D\W_X8J]EL.<N>[KbbIdg75ZPT
_6W[1f><A2VIa#XF9>0J4?1L6,Je+gY_]\@]+@Y]9>gF;&Id[AO5&.?G;g,fP)I/
I5F(^4Wg&[d)T8S:S;H:[YI(aYdJd2FcGUZ=8\aRJ+:VP)D+Y[fOBK_R0J,:g262
McLeaE#_+=90bJYf64&9GOIQa@TSX0G=aLZ@1VO>-I>.c@<<,;D6#V:/4BD[C.S=
9c0bZ0-aPB&F<10-0NTAR7,(M+,ZWb?D(?VX>/ggG;V&AY(fA_9Y_/]@L6g+PMF#
2RNCRg0ATKRaLP/CV1=4Z?A-&BZX>T>c&3^#-<O@N>XP]@G(FP35+B/LdZHT3GXK
9B+,I[(7,Z?#A/9E>aRe0Sd2-BD-@<1fINW(a0<?WdX\S+E=/A3[MQ+3Hb0E_CBH
1FSAP>V>eAc712ZFJ<-g.O1+Ie6GJG(b5S)WgEbSH]<dba:\=KB?#Vg17QLf0#>N
;A:W(Y^:,81E?2_HD62CMd-^)NL.d+OY;047a4(;E3W\(LPXDYSGO?=40R,R6<g5
8RO@)2KDHdgf/Da+J313>SHT3>S.=W_-]FN:6;D6Z?/UG.HJJJY=-HY[H09R/MY4
>WKAOJD1\1T69QDc-aE9G8?2=1;\VeVgW_Y7f9S5aX/D<&W#-B)G)d3GSIE20XN/
:2TF<2d,-;P//-fIbRSUMa0?M0,389L8dKO()NBLS>Y)J1L4A&X]gW@HXNQQgD+U
d+BFLQ<=ZS4K6-c=c?\)Y/0RSY9D924W0HBMJYR&b4ZXg/gI)X89X8-(H8<P6<fX
:Hf?]e]77(9L-91/O]D55L+ca,F;4)S8.Q950Q0N^d<[>d4GDTaHKA55F7D[5-4_
#c8aA/TWbB\W5PR>6WfdM\<e>5e/Y@1R7D0()7cL@gDZX@VOc#H(d2FaaLbQ0SNL
IG>4(.]UcKZc=.S?W_GVg^]:&Cbg[G;^7O@\e^[LFaPWTB@]=.F1[2+SKa1+&5LW
T/bS]F_T_cePYC,>#cJ<gEU3eBZaU;BF0^]IWP/-HZ,7-B66cde@A\C(4Z[Qa=N]
McO#V9]A(VE:M,d9(ceU=Y1W>O@OaU@Ag.\B08-^;7BC8=O&<4_#OKCJ9[,)c86C
L02,Q27N=DS]#dWCQ\:^)<ccZ6T=YA:5>QWJNEQ>8AgD>3cf)F,<FETWGB&J6M+P
#2KeY[-4T[:I,:BdD-NfV\6D=<VDKO&B4eMA>PWD>W)&V^0]cg\IF;K#R>Ob1C-Q
]MU\LJPQbb>NT@YGLM)XS_DP>F:8YG99:M(-910ECQUQ,7>Oe1J(6WZZU62.I+VP
XdIX1VXgM>5@PF7f^>])KU5O(]\Ka./K@f9G3\K=eNE,da-XcS2(f<Zf2&V:d\E)
XM3QEgc9Xa[HEMJD-If4#9Zce[K)9,W;:Of0Q,49f;&V366P#9fAS.Ac?SJY?+=Y
_Od_Z;>NFKST>EQL&[OEMH.:H#Y)H5(GA0]QCAYQ)<FUNC_>@^WR5=32S0a.I3=X
+]F@faXN])WR8g<4YMD5OX3-J]5\Fc9ABHB])I-EUKF6HF,+TH/(GD,RU@U3_QMI
280]cW?&)F0eKfB<S0QfB@U^4:IVL:.XQK++SQP12(V3c7K<S\]IN_gUR:#.20>[
ddQ=3DZVF&[?<D^b#\J\DgBfC#=e\RMSJU]?SVYH&g/Z[&aeV98GHXEKUAI>\[8^
TNZVf2E>d,Mc&]]Ad]HLNAGb,P@2;K.\XG=F@X/0ZV8R=?I59]f7@LO<.9\UdUQd
9IA>;MZXDVL>#QbA&0K^fK6;=QLLT3C,1Z>?T#V<UGY#K/5[D8SZFU?+ZG3K7aaX
+1)S,=IaYW7L,.)<aMB_G+,IDPS;7H;WU@6-.0UZB[Q_2^g>D0&E7HYP\00L6O/]
8#?We;0dKf8/Z]f(/a.?0,fd_K66<-4KEDS26S1=6Mb/9-Td3b(ONg->&B4EH)4M
@-L>gV@b:9-MF#BMB)Zd]&6)Uc)ZZ]DE0XgMAgdFETC9V2::]7FfcM;<?.TEd+OT
&RI)E02Z_@GOB:2Ha(c<7fId;2a@=<NI=W=5_-PL8]_F[6a+c8;_d4X?CcKdB?dM
4&>_gAZC9LWa#[,EOLH+6&gaV9)^TMDQ?,)Eg200e56dYf?@@eD1aASMWX13Q4)O
X25acXV>4fOgTY[_#e#0PLgA]4F]<(VB&\M?U4,_1K_)CKQ^19g9H\a.N[+T+2,^
B8IAHV;BI^X]aA85H.d5EC\^+7_WWLJOS6W46Z)De.N4(TYP>8#?BJG^;]5GgZ6A
PN@a\O7:9E7ReB7TFaI<1B3\4MYI)9B=W69GQAW_9Ib@e0HQM-5;\Q:7U2U\,AJb
+_A>/#Z6XHVK-MFNE#<[\3B\;FF\\A,dR9\XS8<UGT,X1A?dNJCN@fJ(F5[9G3PY
6;8LU[4JQ3I^PP(#3F>8Z0XJMXY-H(I7[[g6_.@94O24YO(cS\fK77WdB?4A4//?
Uc^8E/S4244,4D)H.707#_gW_\N[M[5I#9f^CW<,69.61^44>V<L]_8?a?S;79bG
Y#DZ+acdg5+Ld?SH0A)Q0BU5EWL^S>#.0LU5JHLU5=N(X6\Ge5UedB@A^U[\bV=+
aU+SBBC]R2#0AAP#WU<9O^PLXFHJG-EbP_=GffYT\RYY8bB1)/49ZTQ.8Rcb=>;@
.P2.\,e3-3H>&U4@LPN0D(<]?7R(3:c470HHe^Y#6G?KD;#3?,-U0UAH?F-+c=Wb
J)(H>RU8<]-ZVd4J/YQ@&K?[WB@O8(#JWX&//_8DPgD41>\g;T\2fLIH/@E>-W&R
:gc]KKS_@O3H;IdWf:Ce7][4TMY97/3MQ&53OZ)2Z3IN=T0a)^56f1KV6/DI960V
#bD@a9/6eY/;76A,O^gb7Re?S;YY>\7?W^K^Y;^[^0UX;2)gN=#7KS4VM&Z;KY(\
1@e#.Obb9fZ3ERNQbKYZWb&IQe<P<#[@M@b&ZSgFV8(R2fU3^6M?#I25Kag)2)Q#
VI4FFVf=,JN8g?4O434^_5[-GD;B0f.aOZ\S)/G^),NgVe3RR/+G6Ae_7UW\NM6e
4XWV#3,aK<>=3R\aCX(Vg,;EbWgBW(+C<&A&(#JUU((5:E4[K4CR06+/QX(d^<@9
))6E83SVa8c(1CXWV7S7UK^T3&NA+dF_f6R9^dQA_Z8A?fg&F9A))DW6fF?C-37N
ffO0b126[C2@Z>VB#)P+V7&^VXV50CB8FZ4D/6O?.76IbQZ^Lf6^?R9X<O\#4;Z=
[PK#da#+(X4/##+53CB8QGG?=a@;7Q1=AbI4fRJg.bHEY6\PI?DVU-IP8?(7E60E
PSf^_>U@0\+]2Q51<B7\=3/GJ1bWC8ZWg[AK?=<7\P=J64=E8.J-5V(eI=L[gJ>+
:56RJBL3^\<M]YH[XKS]?/XZf]&^8R[bVgV][^M^?ACR039Adb)N=-LFZ5?BU)P\
-?09eg^V\eIS+XB=#g=1<O3_AH-11&4ePaY:aE>;FcTe/4N,dX(&Z6F=VcQFBFb?
.2NDH>gGDg#GDG:5G<aN(N.EB5V5c:3I\<P5[ZZNHbe54PY0OWXR>VA9R<Df#U:^
eWMQLaHGHJ=cTL)&>14I)/2=5K.>d]gCR#?&?OPG@N<C[gWW^<8E021EcCD@L#Q)
gE.a;X4=6@H7ZU/B-N6E:d[&&S7Ha-C:+[GAT<Q:\9P5L<TI8@B,GOS9U<:UQR\c
4=9;>@(PgaE(g^&^=1FgR^20e-/495I?]?62Z6.Yd6,X_>\F+0[J;CCWNN#.+cGa
5RL7a-T+M,0[+N.YGM(A]SWA:#b/T++g1I7)/8QH4.4,0\g^-NDE6?4F]2ZKOfM@
>=8\YcMMHbM-2@]R@SfL.>P,BQ0>4&&4JZB74,F;\\:>BSH1<]M=W^]O5/3I7J;P
c7b8>e=b=))I5:SF:U+S6(_#-3BTeX@43JYJGE6=E^5>.(M:WR-F]H;UY4BZUT_/
X+_f6+,6/\c?3L5K#.2EETe.AIN8/:\GEIX_<ET&5YAIX)&,\_=J:(NG&@6W.JB@
eJW^G;I]bKN,S]c\b-e7E?gMG5K-&5)_=V\ERY1YZ)QF@]Y0)ae\<_cL^H7b?f,2
Yf/+2(O@9]=ULP4T@@[aeS]TbgaQR<#(7d>+C,b5-3++R1@]<\dYCaA<E-]_Ed])
e8[JGM&1\B3,/]WTEQC_PWCgI?=EW\:HQAR3C1MA,J_=)=<;Y3^WA0M[PK3@GR>g
?LQ>L(agf/.^Z_M>FW#Y^75Y.)JUcT3<:3/<KRa?&f4@J<6N97.IK.KL<RS_d/Ab
6Ac/Q+:G]V/FQJO&PP[&[;N<3HMAg1&66B:SQ7D:Kb\KOQ3WYc2ZK)0#UX(RWP^&
G]Q=L[BI,9@#^]U[?Sa#[UXT+[.LXe/H(QIEY/5<&SCN&H#KH[]Y.@f+&]::M=e7
XO\BXW,JK_&;E96Z<H-BYbXI)&;VDYDL=IT.g1MJREPZ@T_e_58Z:F+7HUWMIR3D
e51JFFDc>J;\F2PF<GOQA+[=Y]#P?<0I-SA:[/D+-@M^,C9T/=9YA&PC^a=QX27g
3KfKTfaED@Y3=0E>\KIR,^AB&>[^.K@C1d7E@>Q5-WY>70S]W>UC#E0CaLaB+G?d
\d=R=]X#34K+AL;C[Y>DY(UVS1:P[e_\?g#;(XO/;Lc5[G?3G,<D=_NJ^c9@68S;
P-OCLGFN<S;/#\c4]>O.>B#^K+cIadV4Y9Hgg.aY4.J:2+=9gP]&>Q+g;P[&88PF
Fb;A:cO1R2[H>[4KDL[baUS6DVKRE,NCG[NO=7B_3381PfL?)69THB_[X&<..WHc
cW,NdM(^dY96-edP:@<E+;.P9e/1,eTXFTaCG:DE2KY.?YdC\TFQ:7c9N:XbRX21
A.7c=8KN<\O=WF54;@/Me)D6K_f-&#]66d?1<E^>c\[;4G>?\]@E=B:+K\JJCcP:
=KPHUEU5B/H1Zb&TB05g2?9,4]<RU^PTZ<CICIC<:L.=9J([]<5f@OVag=SN91RQ
TN[MX@Z>8CT,\J90I:Y(P=gCeXc274XYPN6?BMX<:<dY1=P1<L;<S.W78?-Y:J2B
1\PAg9d+49YYQ8aW2C[:L15]M[FOT#]eC]=6Q^P<OTOUE6aWA#2:Tb9f@0H0B2P0
0&/c_,#6^1/=^^^<@#2JL&T>&5Hc<4Cgd=VfL:e(85QOWO4]SKJQD=)6S7I.OD]K
@],d?M4d\@1AWKAI0/c,2J&\.WI1;-Wfc#9W)bVLN.HKP@=RB0M(d-NJPMR2_)ec
QQ]e(<D#1NPAH)2.YdC(IO?1RFEAQ?[9EgFQ\PB_>PV[cE^]Z<2IC,8WRI/6,/_.
DD:#@H;<P)#]3FQDf1^Q^?JW^^G13&AI@Z81.U;&D[;2VE:3B9E/aA1N:28R,dP_
/?QKd/)Y#:R)Ve^7H4d@d&D7K+CZZB6C_,(28cH@]O_1@Z73NaQPSS]b7]^;QYG;
9Ja;Q@P</A6g/QP/T#A-+Cg3BI,HVB<0W<]/_?G=XML7,R@I,7Pa#VF_[M&O<0Y(
&SA?/U;FOS^aDH<T[3=8G<55=7D4eYb,&11cW9P.-<,S&TS)/AJHWK0L,f#-.5+3
4RabU56TfZD6L)eH:5IJJF4H5gZGY1D#5g&(P#B=HEgFETd42F4/3IIRaaHL\W9-
)RNI7>[:06FV?Oa+V)<XG(aE0\D)4c/?DLNN(adfUed2@LOQC:;=@K/=,W<?Lc0b
:?]b--FO<K1,UX]]T#(Nc#[0e0J,8?L\J@aW6dAf.ITB+#9dd2#[XcRWT@.IT?2-
T]TS6.=2Y8WRgQE4Pa<;egAZId3._4\a1#<0<(F:.Y7H(-\\Gc5]O<@gV7K[082/
T]CVb\gM4J,H8Z[dJCa/XHHX,.6J\5>:)aR_?4,B#Tda::[L\EJdX>,f)8ASVIKC
\g<B#8S-1>?/UcLe5eFEQKb(7ZJ,O>:L;W3Y5NAd=-,RSR-A^S_BfC_\S=FEB15a
.G<86:H9dc0+[[_@:bAPE]aN\&,2\XUFI(9U4DbI=+[(@@T(SV#Dad2NY/?>7@]1
b\4f0<PBRO)H1&R#Q4gQ4]_Kb&9ReX&IcEYTbR6JZdd.S3SbH0]>/:O7cO2T0&1D
RT4RUFWeGRK)\&;X=NPHFM4]3,;7(cZcT?eLVXOD;^.>2GRWK7CNdXJ/>eeQ]cF4
aDFXGB<LKbU=[U^Y_UUe/AF9<>/IYG1ML?>5P?)NGE04BdT5(4>].LROc3E4A1g\
E35G&WEM<Q<TBgZeD>KZZ9>JLa;()U^-eO71EFdEK/HW#/C5(U1_b@8\Y]J\f\<]
43OY2/IA4)SWJ@5WSI>Tg-B1?F2?HVOS@)6RV4J_HJ,7F)H,I(BcX(>+c8&e@W?Y
AXJ=-VQ-7#-GG7_FFgTQNF^AG5.VDFg-PX.9+1G+MKD#]_]=\33U9JPGLT.UIP5c
f/a,R6@_1;b4[eBK?3D9>(1J>C(HCeE+=)&N3P=OB_gB-N2Z/[XT]aJVS02b9?>+
2CgcF25KY]<F;6UTXL//2,c@B9>ETB&KOQX/^XD9XIYG)U&K,O@W@SaD218>34;c
Ka#+K:=Z0:6HEL-NMfLYRb#<6U;HcPMN=DfX^&PF-1+NU^I2/VLS9R8.Y1+aLCS(
Ub?+ad>J0=+X4W]4Q^65f16R@50JG/Eb_e3g_&YOWO/K;D4bD)V\e?ZS7eCGYRB;
b@?=.a_=(.;J@.:/2,,g5YWYTR^P([cV?:E3bY4HRB@C+ZCW5?/aL+\:.+/\Oc=T
O2;0LM2Sc<?J&c:3dSGW8ZdALV6S63fHS5#>,A<@DXDNVM+.+:)3DQ?,<&0D(RaD
K_AQBc0K1/f7.X0Kf7[g9T+34L;DV6gS;7/TPb94>XNLC?)DU<?G2PJLI#?N_^;f
Rd=\0/g.3=EdCU@aGF)(HbGfd)X\3e9QUDfF<1c-6SFJHK,F]RRKTcYd(&G0AKY1
#J73)@I?0g9=FQ9WGaTGKZSMU^=9#[:GD-@Z>0LT?N_0-&J2Ia@QJ&^c;(PXdQ]+
gZMU:5PVT8f_1]g7N9DWd:c^#12N+8gC(,=QNXSM?J.(BJ,8.@Y>gLcE+\5H[SD^
?O/RH#<OD,,G8/&)M?:2#0M^XZ\4&GI8WMTgXa(L/&Md)P[U1Ra45WJIS(H.aQ9R
]R(8-JT#9YIBXJED93f[Ha9,I=OI@74H<.g8FAbNDD(L\Q?T<P=/+>_Q8T[(Id2/
@1R;1fBTG4BW/\1aRZF.N=W+B?&Ae\AJK:#LHNL)f#ZBDd-LE0F6aWgT.-YY<?Y8
_ec+PD2E\M71;/DPKe4(#SAA4>)+9ZVVSKaA0F_75FHB-J]?/8QLI2H^8G#-X\[b
K<Q9.V)(@A7;Hb=NK<aW)7,1IIBA<d;#MAOEd@XgW0LVL5;CQ\d2/b?_P-DYMJH(
9(Z=fVCE&cP]Q9>7K8\0[)MK[L[<>43AHgVX\aC-J0\(RfZ&S1=C1?,GO5DRSB65
DXVK+C#/5;1,QZ_^+d#]LZ:\^P_GA#_.;Cc:CO/@QYCSOK7dCS0D5\9gXXJ?BU6^
#K+,M3Be>;=>;F[]R14BU235)aEBFKK=@NHXU336(AEe])5F];[K0>I?>(\W^HaV
L)(\,Xcg7]JE(DUKSW0.4d9KWg]BeW2D#9[>gBC\WR1:XPFY;7RgM0]@L92>@#b_
]&_F;T[b.Y6A,8KYSEa,<ga]56079Rf?LLe81\G8B9Y]ZC8SP_8cNH+5Ya@XFR3-
2_;gDX[>)ULG;8>Rb1JKb3B?:X(SHV6OY_R0SK[8c?<+/Xa>8(A;A7a_+-(Kd?d(
M/GH_@]Q)K\WV>Q662^/M_ca(OQ<YM1>5ZW9P0:4;BU72BSHcZQ3][6UPDG7DAW8
48cPUO.KEeH>6HXH(B)Ff5ZJH^48[WZI6BVP3@;L<G[TCc-0R4WBQ>+/T@W\b:Bg
>;^PPSP^]I7PW9feDI<BEFO#aMW?O<GW@=3)cAAgY/0Oc]?O^Z@,NH?(eS),M0;-
5G0b<g:GbVV\75T4[IPOI]D=G&+0_g/JH/<>edD&9E]c,gOO?[@I:(BY6Og#\WV(
D)@86DT@Jb)9&B59d];G1N?:1)18#8:Y&I9;X[?;41I,UKF<P3,G6eOU6;d/2AO.
<&@036>4=<;FB:_<O4^4fTaQe3=GKFVKT)2RbfOR@_HI<IJ6dLK[M#:FUQULR&K.
^LB[S+_[14c^/_ZeR@=;c,ECULA-af?A8[4^D\9dVCaZ67NfY#9OaIca#+CE3L2R
fC5ENI#eX&=Q(I_CC=S]B9CEYK[GgC^47I.Wb]fc.-LBX^b29A>+S+8Q0MRVcIJK
O?AG19H(N0\DBJK]Y5@+F1288X;?.-(2Q>?_PMXF)WE<RA+->8ZK0P,R:P02MZTL
;7HIBPLGU@FD#929.YE2;O/YNF1JZWWC0;=6BI257_^YCTO5[\NTWa?@=gcGF-:8
I<^S7\N)TLSRD[6dgM4cB(-[^>g:)U2;[Ma#cT>S17XbA>L2(f_<NEL[7)HUL]S4
U<[bbKY3(FAKY/M:;BH)FePU)Y-&C2XdUX?)P<CdUcU\5H2b=+1N/56>8gcUKVW;
e[9ZHdG\0bMNL\(<^NDLcV:_;+GPZ-S?O9HRCf4JGb,^BEB30JGY)]=::IW,+LQN
3#M?LYQQLP-]\B_R8aFMMWa7,L.[^=CLY(3KeNRUP;Bd-\M^XXALgDcH&.W7[OAg
JAJZ1AAQeAK.-#-&0J[X[^.AS+O[UIXf2C?]BA].N1<F(+)eG=9IKeHGL2gR8H\0
7^S.&XH6AeH&F<IR]LCGP?bf.^0C9@UPg+Z;6T0Jb6L<1>850Ve^aPEE1:Q:(#&Y
1FFJSL@7+YAK_4e=<2)D^J5^=07Bb@cT260g),0KW;TLCJ6TgJ.W(_R:>[.8>OUW
@7M<//,d?RPeP.=Z6@3a[&>6K#?RXZ__IF3G[PMSI]HOG<.Od1+cRbX,>GZ8:<>b
HN8P?]])@,-REbMVG>[gOA.\]1[O/VJeESQUX0>=S/&_g4894P8S=\7aagf86(M[
F_WW:=cB_c[GT-76ZI7QM:f_,dNcNO-NE-KTSX\\:C+DG^.-Q(@2-8?.[M[?dBSD
)(fcYZ:]W.R(4df\6b6aCUKF;cK]O<W#<G//LS#G-TZ09MGM8Q7T)Z@bLP0I#7H@
91?_-:TRW:A.)8F/SGW_Z0-&2G(06QQRLY;L3621<&#_1C1ACc3+921Q7@\CJcJI
B&0NWYX^GFQgM#a(&H>GVN@E-VSIX-GJ(,A?Z;X1A050K@#G@5c0ZN-@Md0a&_c9
GgX#c)^\4>E:5UET&MD152R(6/;]TPMB&,a8ILVG@1?/#^Y?;#?BaH/-\WSVYGIW
,2;>BI?(-b;K+&4]]/GF]#EA3N\>/^A4Sb?RRRYXc_HMd;P;DF-O@8FD#?S#^/)^
+Z(H+(e[(T[.cfFUYd>K-R[54/17#?Z(\M>G6G_\aG8>f1GLYTB2)HN,T3O7O4GH
Z-?^G5(<[^6#b[P]_3XeO[&71.EQ-A(0D684+Zad5Z1&M.QVb=cLAKdFCUJ6L5g7
V;^4cX0GSg7@F?2N.Y8BTM;3N1&>8S01RI12C@?B_X;;H6MAUK?Y1Y1L#58T.VEf
A(@ZI;;\C-[6-aegV)d>Ng2<(VV_0OO/GC[//,71H6HS;=9@3UMfFQC=CETQDATZ
fO\bI&D=Cg326>SLaY)#E0P^/PbQc-EV&(DBTZCad7B\P\;a7b_K-c-Ee<Xd&FP0
N(4:5ZSN8H(KT];I2,W;DQ>.QGR^d0.IK3]4WEXUEW,-_8M^HS[Y&Y7K6X(7_&_U
.f)Iffee9KCUFJX,YFWD14aDDbGF/-@G<=>ID<]g[U1LH@J);WFEaUIP7^eY/(OC
K>C=CPV_25VA4b976Z^[+NbTC&fAUZdgGHIc)5O/>.X9#V@gA-A)&@RUXdURVE;0
N;dG:JEVXO#RcOUcI^-2#Qa8<XbgT_40IUUF?WgIfaQR4@B&SRT:==@PH7S^OQ=g
\?JbS2[3;=Sgd_G?B3)ER_63CJL2EaFA_<Fg_be\^[R<_\^-K0EH),A>#?cG27a&
4W/gN/>.-&[D7)b]0O;YG/-O>cJ4+/<g/WD2gSa0ZZ&FE.-Le:<a>M0;bNgKf:_S
AaR\YP.F/Db(TO&MEZYLL[gFQ&IACZ(R:.)W/eKY,3_X-^:^XEScZ-JSX_0O=d7c
<e#YB_..\A=1K6fDZB&GD:U+=?f17OV3ORE7aT8AS:89SZ.AYI)FU?ZQA._5BDfE
g7+ecaJb-bJ^H=g_NNUCbY-+EX)>2O-)+ccP&_Y]7McJ3UJTa5Rb)]N[I1UG)X0(
eKRf11L(&=bEX3/JcKKRW1fED_LW9Z6N(+6,8@d5Y)cQD^->[g5Q@Cd,D^NHb7\O
-\>B,+C?9>WI6ZOQ;a[V-Q[TO+-T&5+gV-Sa_;88F5=-]U\5Xd3#?+F+4/O/K]ae
B78cE-#W[9I&b)K;HA-dA)N@Z,>I#-b=M1cd<De&##&f/+#DG+&,[CTD/cb7N2,L
BYRf2ZB\)7XSMBPCJ9L13.ZZ-O7#6^O+9?N\7,3S^ZOB^V4Hbfb[Egc\32)R,Z&=
[Y+6e\:VO71F<@b-_U90FLYTNRb&-+OPV+JBRac800C=@98@M8Z<da,aA,G3b]4?
c3[]ePI-.Uf1gT/a406dU/G@GZ:?B?]cFBT=>#M#:)01L/LDd>@L#^:)70P,78PR
QJP[#.G\K?EcYK+18]>a;96_=D=1G=a^2(#M5:LDUEHZd.&\4;KKX&d65ag>8S.E
SFeD=(GcI&MEPFJK(B6<:LF(_<S-]HV4RQ3R4.1-V7/fIfb)c,e;7:3RNF@=7/S7
/ULYaUIaD2/4N:E7(K9@/ZO;3)24IB)H?JbJ)KE2(6+c.^&Bc&AdT_7WV.3NK..P
2T]<\U0Jdg.^ZbBQ<;V.VgF6]<3T2/PV(476,([0Gc>IW(:898DeD^>H@6?W&T@0
M6YH_?:[=K4#?HWW^N(T/#2dScC[eX2Z0E3W?YWZ=KfgI1d_>QdL\J_49H(,U;Pg
B=c@.)<TIU,L^N)c9LWb>_A_>L2YdS2&[UDZdK#@Z_\5+C&BBL?ZEALd3MZF1cNC
/^I++7A\9Xg63PJdUCR[(9<JK1-3\K)\T_D#L#LJ^<BL(>@<WT4UT3SEecJ#ZX)/
2VYJP&UAfDS6ON/<D<W),9O-49g38P1TBV7_D_?/B^)5AYLB#XWJe8SUNEW;J.3+
<U:Lc#ML#_B0G6gGM7+Ad6aX,JZb]EZSFQ^MC08f-1P/W,8U4U6LFO0,F[^g6V_#
5>@S4(c+0PbU>F=+NG&=;L4G?33E.Y.5L/OC^<+2=fNWZ1S0@ZNCRHf7V>.A0P84
\;3>Lea/+dP/gNdL+@5,Y,g7&7#/Z5?AecLA6YG[F>;cM9M<3:cEJD0);AWQf3.A
d64gd#Z<d545UK-84VBcP<0+U;9/LZF(LZQ6FI-\P6@f.0GJ21B:/?<:]):SDL/,
>B/(b,-+8f_Hca:80HJPGbfA&_RbR)=06F3^CeYa(Z=c^g^;TQNP6-;1g.(G2OI=
-+]Y;^Q+?LGVfP=&-/91d[R&YdC;-]AX>WI?J3W7LML4a+V6ANVgJ:A:)/IFY@Se
5^R(3cK2Z:D4GZ7D7;LHI,WUW+J[C?HbWc0Na9CaF5E-9S8d/L\U]C(MLN6_>aEd
H11M=dYJ&(a+O3)@H(;>[,HZd2>a_1[I]W<@KEHJ;]U[HZAQ=MWL12)6-DWa+GSA
NCQ_Y<:-(8X8J##IfM6L/DT_1G)>MegAIH5A/,]RH1_;K<3-N4]PZKA^ED=+8Y\2
DWf=J&2C.-.9.K@_:MU5OMW/I&e-/K:VCO90_-Y\//+89SMG1VX+NQM_>/2@O#43
bAWUOS;8[eX>/daX&d>[F8K1(^DQ<FGD=:U/fQZF9G,>AJ\,O>@BEc)X4=0#8/9[
bO3fHBPL@7#[<J^H7UM5-)/+,\IK7J\5A5a[7C6f4IU,Q-\;4N2@]3^59cNXcJW2
#P3d\S1=+P/\g[5IWM:B^OG)B-07Qe>A;#KZ1_OL<H/4]I@YV=0DPC5;<I>:>U<L
C9ScA<+07UBGYd+_E(XVAFaf@O_KgT,O#]_U\;;TLL93LU5#:();VD1&De_LN9&Y
dCHT?3QQ=?b+:2>geNeDRe#T8U#fYF/1\/#d0K/_6R<;<&BV3=#g+6=L9/UGD,UD
P)^g/fB))9,6CCaN#=AX.a]+Y-RgT<]eV5=I^@OP?:Q:_-I.PI28GAQWZF:Z5:6&
1T/dY09Z\=:KW.Xe&F0S7b1C1@E7AaXLeKRL-D9;KOJ^;Y+#+13_+?Q].I3+;K:L
^=+_4ID6;gRGe9/2O;PVRRHB1U:XXO.(OM<.cF1(P:/(H]=aa4>JNe_]e/dNgYfA
g+#-\.Ae-b]_VH_R-D]AO2^OUBH7>49\;#ge9L:R2d;UgIbZ^V&\gdHEYFC(S&dJ
<9be3QMLY5N?>E,PbR<])2=dA-_-3e.;R&KIC?F3CZ17]dfP?8DaaPJUX-5^3<PT
dQDN;He1;_&eAL]Z(\Dg<.8?(&d,DZG.#(ZTA=H;\b?:(:b;XH4EI/MJEOb\-)+c
Y.Y]<CB5XfXAI+409C&IVgNAV59YeZ62+^?G0NYYPgDFT(E#^g5d9@D9;L.ZK+b9
JA_<A\)4RLG[1g0->@V?Z[8YUD&7A.M##\X:F1&&JZ&4=]\XIDD\3VT&IfGRS[L6
HR69^Ya+fG2?Jf>YP-TR0=0)+#6dI8VbfABd24;A:23[#15)S=W08A_]6^YST^7,
Pa4XM<^b;cQ;+5EfM))>?E6XUN<MFB\NNfU[FdZ<)Wg1=:SV43Z]+c)b\H3R&\RT
<EK]#<@@YR?[UZQ&[15.C\ICDN4(VBfA.(W?,&eD9?#ZcWEaHd+)IH@X/a@.:BBG
T<g-MT,C?:2#0/1bYMWggR5X/#,>2K9?Saa\aU04f^c^_C(F9?]DN^[<(NNR>V9V
g:8ef9N2D;2,8.3S\1O#O:NJ_,(1X(7FQBT8aX7R:Kf5H2^8Td<SP1DHD\c)dH.&
fS9YY9,VK.b&@R6D2Q0M@U^B]Sa+@&_LdSQFVTPM.PC&a51?H+(,Qfac?(]?FeA@
VQ=EV7Uc7798UMe,056cK1-YGQUQUPQaFXa)Tc+>Ja&2RB,)9QFTVRM15#E:8=CV
3e_F4g<e]5M1[-LGa/JIcAH0I+(CfM\U-?_gP9eX_Sb6X[95O?0(5WM:&._?SI+.
EW9]#^\/QVTN5V2c]RK.J2E)a:T:9@KSV@7-_bS-]eA1H26SWbeMVJ@.aZa+CIHF
@:YLKH[04)&VgR]gPVR.]4cDE:?)2f]_T>-92&>5-1OW.+SfJc8af3E5).E/SER;
D,QLO^SV5XFG4J2I8FNRa(B20R/Kb?b_.6P^\@+P/S5cHCLdPYW27/4,V6KG@F\<
Hd#SESE8BCN:b)5Q.>U\L^TZWRH@WaV?D,eIS@0f9(/+Q/(4[((TWVG08.b&UL6V
+[A8.YE@M^8BKg+BASEGKB0;46AeM+2F?V\^:?<EHaM59]@5/K0eSf4MJ-5>65<?
+2HP,6=\NTT8Q;>.N<3X;5H:<a4Y@836I)&E1GFYKFSAAVaGS9<---3-(Y2cP1Ja
bF(9_&7N1MRC7BR+\UY2OSHY\HdS].&YAU=&50+:Y^8cWI<&4J3U<73>/cF=O3Y1
dN@H7V@bQF^g]OdCL:NNY0:V=52I&Hb0VQd3^1Qc__QL3,0<ccYYNeP/IVXLXDc,
^P)A/ba,[A^L;[gK/1W@ZN]-Mf+[3KR&6U+8(C(#A6KKT0LW8Z2J_8Q>CL61X<b3
W50M+cgCBAW?Y-0SRIH]_IdE[&BS03T_5:CMb,3+-X)8[F1Tdd9:IbOaIW1_SdbX
3S.\cL@/RO3gfRJb:]2;ge6^):\IZE>b2T@:U&M=feQ4^\2(4RdGD];&c(9g-=,C
g:\1KGdYTZ=4PP3/77NZ;;AEB_E&.Z?fN-]Z/L_&c^2^XC?K;,fU,E)L.:O_=G\.
PU0WS4SV&]>T601dSX?4ecdMeW[1,]HOC3-d=ZPIB[(@;I^CN#&Eec7J&U[>48F^
])KQ6RUfaR3>_dC##Q7:QeLdW[8\0Z)H3M5RDNM4T9XQH>;]HUNR(-E1TXAJN=F1
=N;,TODIS4d^J.2BR3MBX)EO3#AYNX-#FQHg?Z9P4[5A^RY6<V5\/f[1[6#eYYA,
?:S]/Q&ed^28GAU),:/<9B_0OK#CDFQO8EbQ/KN6g/-fXVITJb]A^/O]#4Ka\_X;
.OO9dQ78LHF_;F8<f\YT-e6&efL8--^\Wfbd/O];eFf&Z8<@E:+;[-ZT=1G/_[@>
5eVCX&3^I))RHP-CI9Y:<>@Qg5)T]8eTNY/[V5M=W>RT7Pf^/3_?eZ0b=fD1T3+\
.V4_7-0;f+Y2]T<F(EZ0P([<f\.4Q7GMO>#?]3+?\8^dDJ;#YY96IW<VQ7K12&QJ
3+<<BLSfJHYDeFaREH\XY(9G5XF5e;L>=CO_?4<<YcfJHQg&<TZ#XBDXF7#8PA(3
8bCDJ@eE_g\gcJ9)X6L=L?:(Z;F(+#;HQ=g=#&I4(3eZ()>@KRdVJ8@fR,KE;)/X
&5\Og52W5SY^ST+W?URN(1XgG6dM=499:>2C]Ac_P/48f=ML]DbE)Kb>]73QP#b.
&d:YUN]4&?<HN&8(7L_[EHB_#.bEQ-PSI;\;H\.9bae1]9)C,7Zd7&;T(bd,8;GS
8(_ZPB9SLI2D,868JY2(SO0+JLQ^QWY:LKGY&c#bWe;OC5GEQ^Ff9TYMIH>F8S;1
V]_Wg+RO9.OZJ/YGG[3I?7Cg?fLB[6>e?e(U,8aE4X-OWUgcGI-A+MWR^(3KNC=F
B7NG\^f8OLAgSV0>C73H]SXcYeNUP<_=a#O4QRfd?\=_I^H[13QT.SBJH0;SecR8
J]VAC.)0<&3PD6JJ=,B-+a,S\g07LRZ8@8[IHgL4/MBE-+.;:TTHS=MDLaaC=KAd
=OT,&;NggSd.cTRPGQJF.C@LMOK.9ST(a+5gGI<^AG77]:,U=/1W7-O28PM6W&TZ
50Vd)FE3\,_,T=875T(F@)_-bVZ1WUTFITPOX#&-(_QW&[MLXQX9O=d@eGQ+5C]8
X1NaKbF?=a5;6:1H2()?/L_0Y\:6)0C_(IOHQ\PHSY?B4Qe.C\cKW=cHC[JQbRfE
5EaedX-I5\5(<6BDMS#J#Y:EJVH/23)VT#LFQFE<^YeB(CXE.Pb[Z-1fKCL6@(LB
F,VZ)R-.I\@2+fTLdBFPC@7CY_;,7(D2S2^(a1W.MV4NWG_OgT<V7G;&gDV;28O&
/;Q[\Q@>Z@Sf:B&[P,8Se=39>g3]),ZB_;>=a@6_#]0LCWH^F;_a,G;,71<HA^+U
K_D1C:[4:?<]5G+\?<aOf?5OE#+(>Bffb_,aMDTBf.M<c&gOB&6M^.,B]J.KR3X_
a:Y+]>-O3WFa>)IZ[=\F5AL_)IW-S?e^;0\)<eY98PS(SLXf:U?46D,(?:,.dfWV
#F4]+dWVB1ge2A9fEFQ:E^fO5gVXF&K.436I@4[Mb,NN&XX,=\;9)=/@FB<GVE6#
(WYA8,DAI5Q#H4CWPW#PGT+_MN0..#dQ5+cZ/A?&K79_?_6b2C\Y=>T1&IYa3^UR
N6?d:\E.H0/DF>#O#Y,.7U/KL[,)8Z.YJ=^FddSd&#VUPTZH_aYY_F3f]W]UAMJO
c:fVbH_5D3,11KIV>?SR,-@DRSd@TN&a2(ea88UUH\>0[J@8]4YbM,Ca.M7:P:;2
Xb=4CXLd@BML4IN.,URgS9KgZ_X2_5>3bZGYA,,Ce>bGD=_\e>JEMdO&=HFFJXb[
9DIc>f5QCFE0-C_]/]43[G>7.4d@J?/c\M;7WC(=ccd6S]0H023;IG.ZaYT3A8+R
H]P@CP6W+)MV\=?SYXgD1#D3YDa_1JR8ENZS[W7a=?b^XP3#G+[B>KcU[3K0e&/Q
G_FY760O0Jf@+4OJ@Z))4>5SP7^5_HW_DXNAA]:)d+X<-3P\(=TU4ffKHEV^]Y-,
4dfe@G@Sg\BdU.@b#?gJLVE3\>24MVJ.b]DP(bQADX&^1GCI8TPJe/TQ07de80bQ
J\C(eb8?8K\?KJ7-.CJ69;=]F3_M-2N50[=@E;3#=aWZA)PA.J@ZBBVN+C4;>-?E
L=TIZ=ULc7I;QLKAbTLY+4K8T;_-2gf&:A0;/D64=NJ--7BCF\cJ[,M8C8gg5GTN
MHdL6&1(,]XBGHb28Cad#0DM6&[?@R[@((.,9U(/f71U[^Dc>8)N6b?P58ge1-A:
F=22V1:AI<F603eQD(C3D,.5.[FK#5OXa>38Pf9SW5:G>5VQQ&>I_0;A^+b#/.57
+cZF:II7+F9[[EY-J)K83P:XYH87g5.^-E_G<MVcH1O^_,cDMLcac&K:.XU&#NHR
8-=1H_@cH\Bc<@Y&FD#N0Qe3@B._O7:9SV(,K=]Kf]8;9aVCTc00^N-4:VFZZA0N
3VcM5]^[Ae9U9=5UdHEW&DV)UX=TC9M,EOO<<C:MXJb?2_0=,[VY1TL9,df/^7ZQ
]TJ/CR+_)#MA\:a)R4c0A)>>1f9U&:5[HOV>9AD(ZNKC[K1/[OB].]V;G1YB@)N)
E^:Qa)Laeb#g:,,,R2T-@3d.OI21M>VE1I2:Fg0Q_c?3a\&d>+9,DD2K^(V)OA\7
cg^:CfG(ZN9B1&#LeSG2U3ACC&?MK++OAOL&6)/?&^;^:a:/T6JZcIFF+S^6I#IN
MQSBdYRcSaN:^5:#[:gbGU)A[ZD_.Y[V?0NQ+-Z6;NEKFCbL9gIMZ<_A@T9Y6#9e
L3-XgC#Tb[)bLU4:4Q4J:3.^g2/1@JaC<a:I4QP#\=g0VGR+=@UZ(Za18X=-YDY6
7O<Y<FF@;X1SF=@EaLb?e)-V09U(07d12\N9:\@<(V,F74f=Zg;5>,Rf6W@C@9JM
GGR-gFDLO8:4K^N<DR1c,::;,gBBe)d3WAZA8AZ,A]YeabLJWAW3P#0C6@7#KSW^
:))D:(=^=W]KMYNC5M-EJ/FBc>)MK@<.@fb),bNJN@P;7@FUW[4/+&7&=]:W-6H/
N1f@))QdY9_^N:_]Ob,#EM3/MBUg-8L?I7.fb+)E:LgQ/WXAF.8LTHBb[3[H>Y\f
b=#<P.f&[FgEHG[/e]/fJFXX\Q?3@<YG.(,(6);K&9a<\KAXAd]7HFKcG,OPIY&c
<C2aN)67XPgCHG[17HG#P5X<ZCdb8dI0QW:#44N?>I_ZGWdU-ZHQe#2A8RW:^E;1
&/E]6::aO[\KfV(HS,#BTP/VLG3CF(KH1S9.(84b1RX-B1-aMcG;+9?@^=68GE4D
L_bBTOO,a#MaQa72(MFZbeN)UCd<-<J]VQdBYM6DdSX@Ca9&(@DS6ZX1RaU8,K;(
?9VT[DeQH++<b)ZLK@.a9.c;K#baO6_I1/dVUVTR,ePEZD&:2SIJ+K)#T=W6B+ec
Z3SU8Aba<0QS@DO3\/NS=>]0P\7J=9,/A]JF)=Af]59b3.:F\^N.S<IAcTPc;V6,
47J)0g@8U1T#g\[?[1+WF6C/H,0)E,bf.SG?G@+a>LWN:c9MBMFRRc@R-)1_S<-L
6YBN&2R(b)#U#c(^]K9(D@7877./H7HZ-Y:\[(A>:&TSQFIE<<J7.0UZ94[.Lc\^
(E-;P58[,Y9^cUD0,UN81+S:b_?fTdX]&SB^8HR=E^;&+R)a:-)045[2#5+#?RWQ
W7H-e#W.e3ADBD,7];1M:a-AEZWa[S<.XQEW)/=#^DRLbg4>7d8\PC2aaKC7W0O(
Z:-UdLPf=Ag8S2RC8M6Q>44)YVC.9NBVK8HU\FE&B(N_XQ.MA.,WDaWf\VCK5[gD
/WHa+^)ZN3U09?5?1WgMZXb&@?YY,3fOY8>Z]Y9V,&/JO&)4>;Ye0a+a,&EeMI&#
?b-a-9aX\>4HB0@R8Q>QE+@[Pad[aF=\/C>8\B+L;?R>#.aVP0PC_)cg#TAQ(&cV
GX?OJP,<QXZAX+;LEU71U)HR0<-,PY]#.Eag)\X;N6E))T.G5dd0V2Ff]eD1BND;
,[VULZ1@:H=&72Y9-_fYZ+d5cCQ2&?0:/KN7J@[=V(QYa<C2?_+1J1Q]TB,9[/(S
4RP.@N,,A42ADQB?:S2RK:1+4>JS>fR430=JA/]0;=S]VF0Jg5)I7VO;;O+VN7fV
,,FR?B;^=+@A[Gf3VL+9<6Xb0.6,P7Z/SNU1O)35P(\=-VZ\d@QVX&gc.:2.]C1W
P7)X3G/4.Y]\UcK)A_AT3)bZ/Ega.@K2.1BdF)6V\<X+d_NR<3=(=1Q?K^&D/&US
<LZ^V1G#f>34:e970A(KJ=eOUBGNKB_3Re1:Q8DS8@T>::5WIXR/^bF=&fBC70=Q
b]T/GT;D-6e@O?3Mb8-8XDK\+\/Rd?<ZM34,bF/@&bJ+722>]1ZT[@Wa^5UP8S/3
7?-J=Ta+ZT1;FIb>9Ja]_AB=NSbf@+Jg;Be7[M;@FQe[=QR#C&W\LPCBW_LN@^NX
&OI(gT;GN#c8;@MH9ZfPB\AbND9C0D@O.,#9Aa/VKPZI@Pa&SV>g2+.KegH_5YFY
KQ\W-ZBFNVPQ?YMAEg&7VVaFT0ICUEeRYP7+\MVYL80#<P=(f/(NG@RcOgR\E;QA
Q.LL0@GH[LY0T98U=bO.XLe2W.)CH1NY798ffQF\0FEW(OQQ@bBI_ZF8cA<cK#Tc
M.#Og62.9+>?DeI6FT4(\O/E91<>Y0Q0BK0^c_CALTC/FL]#&9FYCCG#S4bAd2/O
+O.JUEeFJ1O:#X.Q?UB)X:=Cc.Ug6,2/;9QAO_&::4\);V#a3TQ=gU2_NB[dIfUU
cL:G(-X8SFbcG1:5U<)Y:KS<)\\=^59JI<9^bCM>\Z56;f[;>NZ=XOHB@Jf,TGM]
eW+,Z.7UO;a[0CA[c06I=8:YRc6)9E8+V2A7J#5QY]9d@D6cOC\QD<g:^FS.(e\e
DFG_)6+UUcGMN&-4-gaHKa8F)fc)^#I-<LV:2H0&?-VV:S-e^g.Xf_O(ZC:JaKE]
_=H&e9UQ]D[BT,7)T1/X_317Z(S1IB_2N__28gJN.(fA;@<R,JZ1;-LAO1V5X:=U
XaUcS;2AA1fCEWZ)=M1eK9Q&M_111(7Z\ed@)BH,OS@2WIG9g+)4QV+NJbNVFQbO
8cK76-P;)RZ-Q.PT/d9LIR_,;QV&(4ZB)f?f4-<QB@(^:TKVP]2UFJ9.^\DZa#?^
W?D3<25<BgBAH@5#P#VDFZ+AVCBP/3dA4Ng):(S1PL+e9>YR@THVL\ZYa7FZ1O9/
fMJ4ca(eTP>J7PJbZ32].=<7QeMf#GNEf(DQZN?>/_d+J>G?6cS>P>bOb#6F,7O8
270;J3:WUZ.KQ.8O8D<f@</WV#(D_]<FK?_8_[WP&M4b^YB#\Sb&GY33NRYPDWMJ
53#1]+=e:M;FACIb+BXKRK)b_M&YX[;L=3D,E)PRa+P203IUIQX[1eQ-#f>PcR4W
.a,9H:2+6,PSSNVEY,XB<RgL2B(Cc0d4F.5<P^:W#91W;.GgOHB9P=NUc,>>N@UU
M4FA]C](-+LQZffLWGJ?61a_g@C\W1(S[V[LBF@H>F_6D@NY24fGb#VfJ^B@PUT_
Cc,C]5I&JQVGGa3Q@K4EX>\Db/3_UZ7ZI,;[)bFe,W,VVP6NM[\+c2#/:1I)D2)J
9X2A16bVgfEA1JdEKJb2^5<UW891&.IPU]V=P_X?ab<W;0N@N0MFVBLG.>FWJN;D
)aB3Y]c4/GUC)@gQ0W1Hb3Y?\5T#);R-fZ0._VU3DFf81?KD9-A5D\?CRJB^80\P
Q_WdXQHBM7N@1gB;)>58d?&O#B>G8GD@ANASP7I/N_F0YS)65c;E9&g;fXA5]XSL
E<#4]WOXII/bOc217fbeaH<)1(Kc33Y)7c71bGRZ]g<<AUC+5GGLSaI\d]6gSSIc
A323NbL&eQM]_@CFXP5_N8I0V-^0)LLF+&4RB=VTa+UFX6VD+U^E.PfN(6#,d7f^
gJW/JBYdO-gVY_KH=V_g5PPINV7:RICKZL^7[)/OcG-9#++EG(>cL/(D#RR5=3Md
g8<>242\>+<\&?L@2SAIILCQ52OCJeIb.NZN8)1bX)(+L&4bWBX]C)=d>5bb\BaM
Yb3VW5:^L:Hgc#SIec9BE-YcDC&JN_d&DFgdIAP]>@c4\eFB9b4YK+],4\04)85/
8Z#(]ca(50PY\K@a/9eQ[d;HMU?:HI:7P4PB3D?7-)_U<0.9ScH\eDGeTPSea)U#
:V@;W?>A+I[D6[d#::[U)JS6.V>V&T7<.Y^M63eFTJPJNN;Z@^0GZHM<WU.9-+6e
:=^\)3XI2BRN(7WbF5@OB&31-#)9HAAF:QaC?#>cQJ(7A;7<-X6L,QTK7;,cB[+>
\??//gcI(<NQDe?,4A7)Z@fVLH=]UN#d#_H/L-7[I7_(A)J<ggRG,Wg>O&UaNWba
T?=aCWPc5#f^0Ac:A[a7->>>1b_JA(][(:[C/1Y9-KOF4/CbRKCWTSNLY6[agQ_b
MU?=77RTT#5TbC1+JXMW;e<NW[TeHLNU^-89KMfAgR.ScMEW8/3A.BaR?I1JOBY^
)IQD..FPK5P-D)+==><J7DJV2ZdC[^<P.[VcGH:[>ce<YL0-10EUc0Ea15Qa+(&)
cU.f)\AQ9N>\H>0c@-,+\ILFW;_+KM,eH0A86ORWeP&M>,4K9Z_3]6X<HfaP#[).
]4PX<;C3f7C>B[8/ZV1HJ50B7C.>I\eNG33(?9YTLIgR\6HDf4SYe?,P4,Y8?9)e
@6YKLPbYNH0I]11?M4M@MeU2PZPagOe965aYW#6X<9C^E-bg:1^6Ma],8KP=<NJG
&S\#d@1_,g5]#E\<:D#5g#;bIVDW]b1#S9RX?7a9C\TJ&102.]ZVUcL-9bPS08?d
E16T6gL5f<f9T4T6SFQFLZSWUd;(0>R;Zb.1b?W&8\8;<HaGAK[C/aILe\P7Y[MZ
D(:bHf0^[4WaY_dSKg-WOK&GbSL?4UPb^eW.+XKXJG,1SYP=FL0LVG2_I2+TFfQ;
RV8W-=_5&Td7>OI3V&0gD>(Lc+R-J3[:8_CS^K[IfXHD>V,J&b=:fL@6IEL53P9#
/eeAUa?/5&,&VJ16.#YH\GHH>-_8X+X6.8U+)-_ZU2b(FA/6fMP88K/Z#K11EX=,
0:XbO)54N8;?Q<SN6ffN&]QMT#a9&HV2HYe?68a[RZOF-[dC[Z\<Jfc]Jg2X0Qd]
1;5AaBV:1NSP>]HY6<5:^-.>?\Y+I;B##YG0B-(.2/K_-3:4G4YGe;Z@/TO<)dR2
R=I[eb-[2Df\LDJ?;WD0.F]O+.:\S)G(3OO-PfX^eHZ(+a0PdF_4+gCD#KJg7Y._
OEdM=RNE9GL;((O,G58BC3+)c/@,_7,]XM.0H2;]E80WZ+)MK(aVE>WY&SD]7.K[
QRd9/6]5K6C1:V>R<QL1[/>7aYfGL3#ES,IS=#V/3.EL0d#]PRea[UKb>:=X0QP4
;]eA^T20OaGM+]GU=<^cIg<a9P-_9/ga6UddO4^6T?5;R@WY8X?;,5gX;;6S71HY
bR5#OM(@WR^dJIHSP;eL[Y=<DFFUZ>DG8HE99();Qb1V>1ef#^[Y<BJH6#0<XcQ#
5bZfg47,,ES8A<Rf:C[S07]K9@S8+K#gVT+_HWOL+/<:8E\&FPO8THYN:V.BLA2U
0[9;Y/Y[QM-OT_>--2S-+PVBH1c63?NbO)^<N7d;/bH1\[2Ic&73FXA5+^\U#U@_
(GBQPI-E3Y1UN@>5>&3+84;7(Q3<]dL[eAb>dU=a8[WVPP](D9X;)Cb^WM^9a1_f
#KV>5[HRd82Y;3bZR(:dIU(EOYf<cdOELd5]>dYaKa^&EdUGH=g5A6O_JJa8;a:C
/ERX<L;Af4>:,XX=A#6gWQZaD(:IU?J#[I4eL<=5UE=@WH_OHaef/\\:\a@DU#DI
KAUZ=KL56=Bef/\V7S0/LP5dO)&/F)8]bf]<@@bX/3W<=X@G&aYEb@Fb>BL(BP)>
CH(G;GHQ40TR3/b9#P?T(MBJE6/B-Eg;[Rb#&J8ISVE2]U@?U4+9OP16,bb8HV1>
7,J/e#E6],67M/e63S_W)X1UaFITEJGE\fQR3;J([UE;B_ObW4UDO1/BXcMZ@?B)
>?O:,#@<&LN#[_fRTM;\@4cVSLGPH\/8[9F254He(bdJZG3b#+YTB8(&8A74\?CW
:P\WM:(20Tb(>MB=.EO5Sfg07<6,fA-DbM><.#GZ5IKM\,6eg-\f/U4-0S0TTY((
:NZ5,P1U2]PM9@[AeISSK3#:Q)XFMD,\FBbR9Ra#3Z4/?7F]\4:.dH+-/SM^+1</
ZYQ6>d9\5XA0]Q@>DBdX-(-A@HN_YfCaH\)+)+a[/_<aLa6=H+JQafY,@5^MU-(8
E)aN]_=8=?5-#BXHF@0>JgUVWOZKOZV2P<R\,UbXX4>6[#:9b6G5W-S8VMeA2V\2
5=<J:Z5+<69H^EH:;\@TL<BKSXGQJ;8Ig6,]+8[F779M-1NSF]>C/e=eR)L7?+P&
>SQ(=1.gG.JRV\cc-I\=13NQ8ZT1+G;8==))5,#-=+fa\;TO]ZOAGXSfC8O7:+HW
XG)NaO?^A;M\?>;3fd_X95T04)2&4Q@;?]f/P<,MHdDK@)XV^CL=44(/dN5E\&EW
7-6ce&^<_+?Y=#HH@HdA,[/5gOgHI-@F(FdO6B6,TF/3>IWMAA8VY<>gHQ+7Y0Y4
dI0?^6A#4O]=MAeJA2-L:3/MVH7(2Ve9)S5-d=+1:XG&=0b3U\84FZ@7;5Z4.N-X
4(#7+CY>0YJ+L)C>Q=&Fc\>#^a9/LN28Mg>]V^P[/6SS=cW.S3F;,+WWXI&-YU1^
f?NR?;Z?;@DSX&,P#Pg7e?0#+D??MP^B89^eT6I4a?bHHR1=OPWQ\10Aa\B,+(9O
&S&C^U](#=DeS./a(888D_6S;:Y1UL@f;gg4\SN&-?JA9Y:(>B\]?+dV0DePEG_&
Kc5OY51-2#>ZL0eAAM7?U7?N;R]@b:g>+GDSg-Y:20=Nb3T=[UPL)dSR,c-bSe1/
b@Eb-/KH(<AYP?e)<GRY@>Q7fXB2\J4Y9_=8@Q.eP5JH97cc\HOT](&,<cZf0,=)
cEMK)J9_J,8#eUZ3(Q>SWF6<Q;4(fYLRcT;8=e5gg@2Xf8>95COW.LCT]2(DJ20R
Yg_&)g]M:^U3WS0#G)R:eT3KW&#<Y#/7[=;Qb#aWSF],MM\dV/#\?2\O<2;eO@P/
Kd4JWR78/-9<7I5IK^:S3&<2C_6R6A_DW86RGTVT<ZQJ^SH0@^6^>AQ5[M>1Xb29
[9dWB](H\7/1V\JR,e8RDe]_\\(87V@gU^KIP=0X.2d=+1KT/U5/6X[6WbS+SVg/
caZf8-@[20;K[3_;(((N&X([a(I[dY&KR&DYg6ARIZ8O6A.\)6Iag:Q404ff<Y\d
<,a5U;aL2IQ+7L_-R_5,B?2./B[])T[8;8V66a\G?(3G_LB//XbAF<7__LK>aJA_
X^#>#><54]NgKN@eV+F.M#0fWcIH7=8<YR2d#K[YL3)^I.<XRd:&&a&)-\D##^5O
Q8UCG23R(W1_DeG+\:1&4G,R?\.g=>HP:#W?&>?.[=6f:9IcfOTFR]PC@-_:,XX:
?fGV4-ODC_0G>YePg#9C>JQX_NW=2R[GJcJaQJGQPKWV6bS&JMGKGAG(55@fT;J7
bQ=JS/(;F&UT?1B5b5S6F9)DR[/geL@@35BXJCg/Z.=7<F#.51NA3:N4<X79,,#R
2C_D,JA(AT^0E6&#)K:gDa(/R<^A+6PgKH;c384Z\:KVS2N-5BeY3,H4B3].EPM8
B4NF.P+CRED1)\SBVGG&<MAYPeU^@V[0/A#K+T68UQ@Kd-[-3GNLeN(HPF\68UAA
7];4baW6_5;\6SZeL@C:Y(c6aXX-<S\SdgJ0bTfWeL#B1&92C)ZZNKLK+O3V-9+e
U=L=a._RCV,d\/QK^Ag=1_+NbQ.(/1++A0SWHPS^eKJUH)3+[/dWa+<#V.0#^QPM
GI;>M]@gdJ,=IA__>KgcG@OMBgB=_a4gVX;V[E[PZVD0E:&)V.J>-JN<^/Q5+2AM
f33^:1+Q@HJ-Rb);b:e)<N6JO5V]>Y>?.e7U[Z]EQ?Q,d^JgNa)VP1;2P8&:CVHL
_3/9_TL[WMBP,R>0C0.N/-<fW@d,C7@L52.(dQ&3g^16;^19I+(f0,Q:#.fJBX\5
7,cG-I=A#IT:M-7IXF<=QKF:@YAKE>:MGF-CAV)\K[1Wea3f^Y;b0ZN,4(H\+cY=
RP8ALdVU3VgHKX-\eE3++(Qb=#)P@eGO2;YIDE9.,6XfP2J]_-@66b#+G&_R&8a\
c\d]K0]M.fJ)@-CfJ#(R=@T#76-:>55)F-FZ2W=g]R-3KEaf10YA@::4<K?&R]PL
^\Z[]F9+J+@JQ5OZ:C>F:;=O5@J]6U7\7f3RJX\97B^1@41KJKfDg(#ZJ.J:#(E+
-]]ML.TWFCZBZ60@2J?-:<JIC9IJX<98SHRPFTV1;UA2RO6NHEAS>:#?N5P(_+OC
VJOd9++d/2gGbZgU9OS<?T)@/=<THM@g.:Dg-?([Q7UFXdH-VGReROMAM\NIP1TK
0V8(1L4X#I3G[N6XNXQdE2KPV)(_cE4FERd#GQa#LR\ZOI#&;=Ie(R7VP.T<fS\I
]W9BXBBST&2d)A[(,2,=IS3>;FLI5OK9e[OeD@[5-W9+L=I;+1cAU<P\/W&,2D6Z
Y_Qc(OdR(SKDWZeCcO@W^CR/b^Y/\51>CYL[HC.NfW@>:f@#dIP0f[dIGfEF<@K7
3B]>##4N:gJAV.F6/)7#@aMR:OdGf+YX#WgbRS#DJ8a=,YA7(VbfU/KJ&@c(Lc6d
6;-f5:-g6.LU1AX:<D9Sf_DCPDQWOD+[I=1A;[b.H1f8H[:T<D6=VIP4F4057QM/
R<K7S9b#[#H4HgIK_GN&<K[_1JUOD,_<gHG#52Q)JcG-=c<BH-Ycb4[@NF;&@F@J
cXfFeAC]E^-F-T=30K5WDa@=M5:^XB9aF+G]cD7SEM]]A)9&&2K?b&CS=1I/0/ga
GS,CS.L_3@E<Z9fOW&(@4bV^0U-OM#U?)GXP[/W]#0Jg9Eb8ILa[Q\GVRWOYD^#O
3=9A47EO#g2)HXFQAgJ9K?U\SURgd425[Qe87PX/[ab>X@:;08N2fOYC]c[0&#\R
fR\fV.I=Jc<B]HB5WGHC-X+G4MZL(@-PAB=7]FfQ#RE>&6AZEO6ddPGa1\B;RPU:
Q6E?O5,;TR4XXPFS#)Q]S4_B86I1]<;_<,:W47:SRR;Dg]5Ld1=<GLF;&\,LSTg>
.G_:-]P=\&G@G^gfJ(NYU6&S(163+R\=^3aNVI_dKJ&C@DQX7K;XM-XE?T[Uf/30
gU<d<-;bHA)-V:2ZfZ)UT[4A0d[)[#@++9a=4WcV.1f++7V98LG^N6PKQ(RRC6R0
UaPR<)RVB&<L>cb6=BUQ6AD+2Q,]#.VDSL/SN>J3S9+43I)T-GQ5L)=Z#IS;9Xag
4V)eO_W<:/=g,KHBX(X8Z33e]7\@3T#)AZJJQ\._H3B>RV@ZW#BB:WSN#WU_dYAT
H&\S4gTJF3:?AJ<77dK,T@I,Vd76J@RT+3A8c<Nd\JKL8gAK#RST[,W&<<A;5De4
P;9<R)4C(g;ADCJN@f#\M+XcXXJc#M5_cCU)cD9>WU/YCeYI7C01-HK(0-E+X);J
IN9WGf:<::DbcLQ&#/Z4,FggXQ?5=32KfW=ZS+Q/+X@LL3LFB8EGf@;?<_bL79EW
RMEV<8@HJZAV?J_37+X6\Wf;7Ue=+dZ>e+#dP?gdK=X;PEEP\5N[V0(1Q_>5W7B3
<DB+TA)@PJIP[F8R^Z=T1O(>?G#.g6?3VH^33fgAD5E6?#EdITGDWTRO+N.Sf[bA
GOJF-VRWN^B>X@fT7[TQT\A;d?3B2?@#BMaR;==#_AcZHPe^V(]X4HGeULUd/eB9
WF>Y;1)P^ZgG+QN;J(OS<c+62A7\173b[)>0I59H8102,4:YX?4#gYf,PI.PV=.-
_]7>>U5#Q//A0I(DeA+@a72:4_@^:0TgYMJQWH5:7YTJU8;\HA&a.Q0=?-OEb^#?
31ZbPC9,1H<KO\GaUJ.=f5I-Q6V^)2#WGX.V1]6EbR<]+2b_21WB8TWcIR(J65HN
,,bEC/_^\K\)Y@BI=ee\XR/=99O>ERK83C((6T7LeJ9f[+Z\3\,I4aKW5&CL;DI>
-NP9XSU6^6e[bT4^+N<eWO1e)9d@6MXN#6CJP[,]URKaQ.^SA&F//3;P(eb7f/5_
-SaTb1c&JHQO27.F/LNVaEM7F\]1+FXa&\(U=.:^&)CH36#E\fLO?6X_=dP8+L1b
e3SRQ6^9=FLKK]EM[^=R;dL]UZ(#F2RT]NGLD^8K(JHaV@N[?)a0B4<d1LJP.X1?
O<VZ5C)XBI)O<8f8U=CfAP1eP(776+/,SQ^8aK:d7;a.c6>#FeJ9[=A[DDJY#:5,
WH.MZIGZeU5W^.1P7_:@&]-5#@9F8.7AfH8-c.8&>9GD1F>2TJ<V=c);MLfM:S7N
gT^@d8Y<[YQX=,;8HS2VeEF+QEZU3=f#?PQ503Z:Ff9c6GMYIYP[/-<98^DB>d)R
Q^&VH3TA\=;]W@+Ze5.F>[KQ\,GB^.KL[fYN&+T&Bg66C0L[]:I+SM:8]d?8M\_F
Q@dg[(WKMf=P5M8TdLI1H1D3-?P=S4/[&4LSQDZHK8@&eX@1b02f6&g0<U/#S2f^
:7)@#bf@68/-7M61[A.E0f=W<(G#Y^6>US8W&J4f:GFJMa4=?CYX<f;J8_b7+;GY
g-3&J#d))X6AB;ZV26EQ3)(9L@+M+3T>,KQG+)La<<U3DI2=)Xf4f:_,]HQ>.;R=
?B\Ige,EL.HVaVNVNHA3#Gg\dMD&PZfX-MN?XX_TLJ=NGe8F5LYK_FY/;3O,+);N
/A9c&X>)fI;MTc,dU<OfJX>5]>&e6H-Z?7VV0ZW42^=eO^E9dQ]3XXgO[K/bL<RR
f;DV\>>94@ee/#6\=c0ID.Z\7F^;S/=83>2[W8QP@9(RPUVg1?H@#MF<O3Y-9<)N
#e@BX7Y-;G9Fd,J3XJPW[UcCfAZO\+_L+JXESO0f-TSBc,=dEOf3A99aYOW_OG_7
J?W5#61]_YCMgPG;4MA=5\9HKN[/g7;XUI.6BW305UAVNC\BE/V&0FG4BYB</&U=
FK\3YP\Y8D3-D]]#JL,[cW14=dbY/ZR/Q-\^)fM_3)PX@:Z_dTg:N);MNQ8=Q^ce
bQU3Z4.-e0EA:<1L-MPXQfYS6eTFfcEBG93AF4CaW-R7cKG16g>BVK2SA2Na:_9_
/HEG[K_bBHEK-,JQ@OdQc/W:SbQA488P4DSG^&AUX7NCY_PQ/;F49T+ge[=,L5^&
bBU5G2K:IZ-1c?07I0eVRX)AS#E3JEY=)][M@c\9XIMf:B\/9\L[LL:^MLN.d9W1
)]]?:+Z7?HO_Cgc4ecb14L2-T1U#03afPO)#JPGFJ+TH.Rge/Ca(ePF:d(KT^[3E
#g6[2228:(]--b2K49L-K&;@6_ASfb(aY;L<02];9<a[I6NTHFR6O:GTAf82<G.)
A9CVU;C_?bdCBB_N;,;b/Fe?@Ed+8f[.XfAY<;,G3I3B5;Ha:D^5T83N0>@&M6N;
7=[J)X+NXU5IOb38^O58[d(bd5C&3M>2eO9D<6-?92I2.N]KBW3:a],A#,4.A2c-
G<a]&[.AT++TT1502@4Q?^K?B?d6NAP,MKLI-FDSZLa(>d/;ZS+C#ZS6N9ed>)_S
\H1DNVM1J8e9.QLE^/3aA7TH98J;^8JD2I04dSGd,CMEK(&a(@F>#JbE@ggQ>20+
P#A8[:5FH7b<1D+K/_;&,CR1SK)5:R:W]PHGZ[/f)6Y1&L)Y4WM-cWc9@6W<UO,[
cMCdL>gKa0P^=^3gO@+]KZ80,5e0)8^1EDIR_/@?P-\P@7O>YLQH]XC#FF;eOLe&
ZP1&9@(](U71>E_WR;CfP.Mg5EAAV(/Q#Fe.(He?b,-.X4fPKHa:(]<Q7>18aUN=
P59T4AG/O1ZS/A4=;C9a)6.Q3FeS^C7S]a+]N>fC]3K>ga52:.[&;9fTgR]C1<\.
LgQ>^HFc.4_a3VT85?M&^<Kb(Y?9X+E2H?\X;/BU>C8EMV,-b@7IS=\SJYFSN+A2
@L@@(>N6gFS4#@1dGH>(#(@E-,:BbTJM6c65;\@1-GDQM,BV=1Cf)BRC9-[2=YKM
_DeCHGW&^S.HIYA15Y&[R^Z@3=M0)HG52]6=?F:FFS5X9/^MG(L^5W,d7)N5EG#B
46^UZN515@(04PW\TQ.@SICTgWUaDF>KF-IcKXSUZf^V:?M7>WV@M=@4f]gDI-#U
.d&TK.a1M,LA]Q\=4E)#;cEQM&)SGONOR@^&)P)7&JRJ1I\aTXOX_J/9XU;I>22S
1-V>XSd_;+d0OC0;7fc9R=0OP6U/09+g7e3\)R>d=XFZZcM<RS_R1_9\ZG_5We(R
A(I3#V^=Z_]5M[(Q>ZfAB[M&_L@+1f8^ZSbH8L5V.Jc_[0cH=cgbA[YF945,#FK)
MJT>W51#J?4#d\762IW/D@&2E+d:@b9P\@:DVSCY)X>Z3/84[7W]QU]c8;9N9:2K
:5X:19NQ,A+=?MB&?:\aYL2T]dUR=.1aM.=Ff#Jf[(W5/[[H&BKgD\C)O/TMFRAT
eI0A>+.?ePd.XP/;PY49W,;eD0<Bb1eRO0#BEHHP??VRSV<?O0HBD1K7gLP(XT?Z
-=#2:RP2[V#]^F1aPTBPA,d3C;]L3N98XgU23X>6L_EL)O2T()/E+<]CgYfZH2/g
JD6O6FAU.RZ+ggN(Qb#R+Ag]B^)1R&5[[3PEBb+#U]NIIVNaX[VPF9:<F&B9JNH\
V7&))+d+#fg_XT]X:4<>OAQM8(I.V9c)fE?(I_cU8W8/82NQLK1MUXc.[Y[9RUQe
^3g&65R[@DL2+G55B\40S5.c]Xg6#:b?SZ_HXdOW[.PD&dCgV,<WWT.=E.+TO1,Z
,;E#f;#_4]+(e\AUV=F(d_:?Mc-0J8K0aP03>@8;(E;JM,C6E8[O@L/]^_0b+0KR
_;)PA4\0dWLTdCPV4Ob@3QIBNT,>)DfWdP3N=g01<DFgU:/NW.W3T_;H_Y+=e@f;
6D<HH^eP6=d_S6FTFKdHDJ+O=3Lf]g;.<Q@XHH1DQJCF?A5WIfS@:Ze0Q&=J6PD0
+?/:V[a@N4JfGN@JLg/62N.c2?0_;@4:&VM/QY=T1dX/[PVd5<[70-ED2F^]+e:_
.XACQ3KS2=E=:C,Y=]HM=?2gbY6[2K_I-;HF4K^WTW-+>9><<Oc[IZ<[eNHN^>\3
Tg(HHb26:MJ^;2FS>G;&@?.58U//aHU8HSaET#Z,=R^Se>HO74;[L?5(3aN@D/70
V]_YAL3:e8H7E&7BJ9Hc1[[/4MDS2WP:&SP\C]QE5KVA4GAP_?V^MS\/B@CA^1aU
RJAFHU+??]EY.<?W4W&_PY@X,?;U4e[BZX\4(JF(3gHcXbF.=#<[;-(#?2aWSb[O
PNc>XJJX^5,5-P,R]ReDdYG4Q<@QG52Sc@bCMLEP?:N\-SNVF@6F\[2>\9TG@Ng>
=58C0^b5A@N\64Bb-(9,Z+255^)+VZb;d2ga\TYY::+=L>\2g7.=Q]I^Q46G+&IQ
4YDB@e&&+eM<CR&C48E]>f,SBB(Hd3<8^ZG43L.f>\#Dg5LWS:W03-(X9Q\f1C63
<[,^]H8AR[V9U-5XANZIWU>=1eT<R+d-7:M(dMa7:)5EE,#R41Y=,^-#U3gbed=<
FO1H1gDeXSK0IH,NUPDA6aUJfH+UDd3Wd(d+@B/MA\>d22CKEAM=c66f4IZda&#Q
GEYQ2E0a84aJR-T]-(G9.6Tb=.@GU:=FTBT0.gE.74bCCFJ-1DQTG1FT[gQaD+G6
GJF]>:MZ/ZgH;=<)XFd]7D0B6,E,DQN^8G(ceT8K#Hc?>)I6d>21b^F.c)A&<c5O
gbOgO<eX[aJ)3/2]EA4Y+54.Z_Q([[N\+ZePaWG7fHW_H\;G(MaLIM#1\5)?fQ)5
36cKAMfTV,65>/CHIZ90[SNe<c+abO0TE5],RV(KaJcA\?C\Z^YEMGO8:;L</1HZ
Y1(\UN?#Z@\aK<g&^=2M6.aXGE-/d2AeDc,Q)NNb8[+.NRc?B[B+A5Z;IF5G-BEA
0?b4,cag8>a^X#(3ZHV8LGPC6;.,W2H,M?3-NCX\e6>?\DM4_<:&FW:)XOQ&1A;#
PHZW,X-QDG8]P.e[.?COF+:C3I-=W\7c@bCB8CR.R^K?6WMY2TH&OgN5[WdW;(&/
K6^fL>>+B^(==PNd#f/L9ZK_0X+eGLCL)T9R:]/Y40#BQDDf79[@CI+:BYBJD;#J
-K\8-&3QeU?G##NTA9D65G;e+I@_LPJASDRP#?Qd-],4N_S^Q;[N.5HYU?/LXbHE
,Y#GH[a;FK^#G6&MUd#f6V/HP/Y?;fd>LNFV):?0CRAZR#4bR7^8/E58VcVY1U9,
]QO45a.;QE;X3AXd-dXN9OYfFZN#bQ>.(9H=T<4?;>bfG>UdU-U[eJ4RDbC.g+B\
)L]^4bY.:QO:N1G+]D6R+K-B&cETIC4)5<=>UFN.BF)C#[:\dZ5Hc+4[H;G(MU]H
C__+dV^>PRZb6H7M&6KVfD7-I^:f\F3Q,7fP_Bg&CN[:F-gA1]^b0DYDJ==D^QBE
.-9Z74\2G-J)dH72a3LIF8_b0WM_g4g&P?bdR;6Ec+c@(8/=bN(.C0Jf]^XC)P,G
EYO-fU/1F45=3N[&CKQHfc,YQ9V+;@\HO[+e4S)V;/8b.V6N,f\_;@R(7)NU+SE5
Yf/a1)G[/-PMN[=>B^33BV7^SA6bR7S380<TIY>OJF:QIZg)WfASdC461.@&4J3(
Pf.](?3=MadM;-d..HFG+A2GX>,YEX?RaQL[5]4/U?Xag(&GC@[6K^7[=1c?0-KE
2_ZIccTXS9A\gCHF+>-IO[8(Oe^LCI^=f=A:E_2d3NdOF8AYHcd)C=#[HQ6HD/2f
W4SLHG]_HYY;f_ZTU8RHM]Je]J[Fea8>=M/a,AgALdPfQS>P^?Z4K]/=RFgIbBQ]
M=QC2@NAQ8OgUV>Q4Gc\(\gZ/V#0;.SeHY[]Pdc)/PF?)d_1Z@7_L?V0?6XOB7T9
I[K(TLe8N:92/@1Xe.^=AIYAK+44,W]f+>19V2NbJ&0\K-N)2XY2)DQD?B+55bN[
N]Z5+KN-f=bg5)+A&6^d(9g\7@9IR>F#ZTbNMHOF[U++)7TeGGCS?D&d\3X\-Sdg
0#ZMTSO2W\8;3;UTYK8LCC0Kf3-d+T=+>@K-NU>;,VOG94a24K=INWUb9Z9H>T;_
+BDe]Z1=8AN@>:dI<Ab02K.+g)T[40I/[HGGL@K=M;+?37UUP)D_<bJ#D;c[<]DI
7]Je@^8VXd1+SHQR8L->J=1_(]d7\LHdH32I#,(<=W]=4DfA1V2aLJf,R10bJI\d
K7f/LSD&MS37WEg4B_UWH_V-[_Q:.5\&Ob^CbK-6)TCGHfJHe12W:.bUEcEJ6.1P
>fGbcXA5QKDY-))\E8/>J^]7+:4-HZ(JWEX@f#V<.cEE/C#2[N1S#G9))U;YP9D\
b3B4ZLgOM09Q-GLTWEEK.ge+INJA>LPg4?Hd4O2G<S^b[LdFZ1OGb?2JVJ(;2_3+
A#)@(5+()NFHcPK6GReXZQ;;\ZGX+RTAADT[RG_)#fF1gd0-EF:HGM?50PgIA_e(
3?<HSTC.M0Sb3TMYKM>fAB4H/I<f-f+5N&HF_Uc3+69X(=MNZcI7:?&H,9,FB\VL
fL/Cc-R5cJ9X0&ZfT6[+:/K\>I7W141>c^9Te;G:eD.[BS/gBLHFdYMQ[d28W7B_
UYcBJO<1^>2A);7^?\b5^P,OJXSLDE&KfeU/BAS(Y<6TK#ac_R6U[2Z5)):Bg#47
1UT_U]Y-@U@JZAN9a8N)+/fCb^.)F>:cA[U<>4>TMYFBb8O)5B08\UU+)<&V#&7E
G_101e@a&@CZ<RRF\)93WR=5X>AI@JD=)&Fb8G;48S,ES+DQ[QNJ_0L3O2\:=AQg
@191e?dc&3cB7UU8Q2T>5S>05XQ-40Eg64&?:&,21ZB<VGO-LGPeUXIe)+&4T>WY
f[cU=;M=[AAd#3UV#GF/8?XHE1XYZGAQP;&>[dK#FQNJ0DOW/?g9C=/6XYT)^VTW
gW;L.FC(V/83:bUH9;Q6]EK36O@Gg_IA5YMcdaeVLA?Q+?RO0DgQ6IAPN2&CU0M:
bVHR2:WF<LSHdT;+LY#3S:AJ+b(+[05W(c&+0=?X9/L4-C1CWBV8VUM,c\IaL[HG
f@@_0V3QS))G3fV_WV+OSE[8ccg]5KgI2P,3Q&<g(.]CPK=&(:;X.+>LNA^80&1?
(L9U(Z)Z13-IXDe;.c:#6FeF3#C>Z;(^C^@c3\75\^Pf/+>]J+:a5(290:#e(0bK
P,ALc+CQ@b:=GID4K&N)8cD]A]VN,=fH]@S6Fg24bML>^WI(^d_#XU=)8N+S7+dg
T?HK1ZB8;KLbN[##J?[XF+#6b\Z3&KR&@[8,W0Q4GgJd_VU6SBZ./89I4UJcPccV
@D.+JD2gN+^5H(IY\,O\cT/P-XCMD7a?.I5]ecA(T@N\IY/;2LH9(ZF^FbY_Rf;>
VEKa(H^bOgO7ZX-&972P]\M&0M&]3>]MWUA.JM>Zf@La-7K57DC&#eDV;cU/VLZ:
Ke#19Y3E<b04g->f,Fb4AcG=3>AU4DKaNDd8KS)H]J1)RU1d8eaQQ59LX.Pd;^YR
YT&TV5@VWF\/^@7/K.]0gR)A)NEXeV(g7H2\7[12=,RA/U8;TAHOQQ16]UE4PDgG
A9<5(@7=TAZ5Ia&4O5.E:<)Y54IW\GaWMc+S\g70E<_?W>YOc@=(:U<-FF)2c]\C
YX)IRP4H?Nd=cN<d?T=GKL+87IKTZ8+.5LMb..b-[YcJ4;&\P]\M__R^QP6Ef\-B
KTN7G3OOS?04\fa3M:KcU8N/665CW^)L<4)2ED.BJdR9_-[.T^Ma(.Z/cbTU>-0f
NJ-\-)b8.1;=_S868X]O1+^66T(eY[D9BT5^AE9;B]7_eC8GC16b/,4IJZ@6-e-/
3XVMCNBbdVH=?91UAcb=45U2G0Q7?5\P2P#;(eI2L::7b<6IMQ[fI_G7]R[XJ9;A
S=,=91UXQg2GHC;:T:2U?#;,S[UB^PED/>)C1HY#+L[Y#ND1EF1(4\?YKbMX^;S-
IJLI<ZR=N2QZI^MGQFUY#Z,3#]<eSV@C6>TI/(>JA7f^X[G.15]-\)9^5]K8e#Rg
6a?(4,cL#0-D>4XGEH2@[<V8,#bETII/5AKE3R+f:SO\RGFa:YPSP0?]FBGgGHX[
bE#fd[B@6Y-dbU9K2WXV/KagU2@R][:6]VMJ0F.GcR8H8[Cc6F82_Y#NfN^&[O>5
W9)LN)5+Hg:X_b-WB><GT\4DeHcY81S.C0Ic&a9C.(D7Z1V:8f(F#eEdgO:4Cd(^
P4^dZ\IPH<,(-c>4/RH85^7RA2M5,M@>H2:c,1H=982MY&.JJ#?NZId+?LUcIcb=
I1<=RLR\0<J-=f+cS)aG(BaedR[O<NZ<8_L5^V0]P5=d55JI</F8F2<-:WS9Z78/
g>2=^:SMfe4==J,[6RVdG(>.IS(3A;cI/K-.MXX](3JT0V_G@cDIZA:Yg:O90\3=
_[TC9998YdL,b>\5RV^];H.Rg;)c\TX\DVRNGTUcf/a.TV/I1=gE2b][b^^WCO\V
N2^_H5WWH#,I=;=.gU)DE#P)\Q5H&V(T8^&da_LYcLF5gf,2U0K0GLUENT#1.O.M
6+9Sfga)d7]734@-Z/b2NWIb-6P5L6cA\F=AB5=/WHG9[:I\SDZL]Wd+dF)&R_&a
K#>6LT_4YWO)4KA8GNCD#[+HT,69GgPJK&3B23LFLgU(TU1NZ7^GK]0f9d)[\Q6@
<D-:HeATG]OCec:JTST>Z1e+]8E+_QFH>D^GBN<1FR-X<^6d#:]@S5;E)IAbf8N)
?4Y<J)<@7)\gXcLJ,a/cQ[.K=7ELd:L&/?g15.F0HD?A3OG/K]V8J9F>bJP.Nb_b
DWDOUc/FTBIb/NW7LfS.N+WZ.:T5B-;6X(PC07BI\#;CAJN2^:a9TI=QL6Z/:;.G
b5R1O]<BJ?IJ5)OE5[LWDg5:\T)+e32D^>AGPU6KcPVB.C6+eSTEQ9-WM<JG7QOW
3JbR:G78<)0.[CUc<:\,7TWf):d6QdGd.8)L(UE\8<Xe+P1/RfE4=5V/CQQ>,g-\
5JUb0N(5>ecCY?3Z1C0I&_0@Z@7&FD1364a6CGKO<>_&AcdecQdBS=e4ZVM<g@<2
9-DJa(W\T[<3acQ?=1DC0O15_6P@EaH[dNM[C\E7(.Hb?VY)#\6H6]eR\C_bR<,9
UIX#UKKL9+gVa24Ce7-Y.EEZ32?&=J>WZaG+H:LV/Qb>#;&&JY1ffG3MdM2DdLK\
;;PDN1P_P55+cBBR4)MO<fLb;-d9VW+\=TC;>&V<Ye7F_[(33>\QH+d:871C/Da]
b6R8dU=L2B\G;:S\g^KQFE?2:Qg@R+N(7,E/>f6W]cUTP(@Z?K(8F_)TPc7cT>E?
?J7;OY9,J#84LA3E93c@f,PX7O_cOQ3M_EO&6N6;e#N:b,Yc6Qd6A=JB(](3;>G\
Z0^V[_Dc#-(LbG>gg,0H-H.+70PaQ6U55c)N__7K]b21S6;Sg,dUIbM&@>I1d4>2
EXP8eAVGGP_dV35?6/IFd@26XL>30&/8<.fBQNKg5H&8[B+ZB;c/=HKG18O\?(4.
<CE[SbGAA+.J2.(4e@6EIQg.Y)KGMfEZd4-B72N5UX7HSTZ\>ag&5GZ2.5W=PJU=
ZQ]A]DUWAbZg_UY2HFUb1-MH&f_OQ\-@6)#eTZ8<TMc1Bcg@0#C)3gf?].3MO.cb
/612eacd\?5R>]<VPAA5D?^CK7J)QaGW0V&L.UUDJP-+-XP:_]Ha8C8gY5=F^6?,
>(>gH-SUZI/<S]88[S)CD&aK?,NM;ccTdTY(U+W(6dVCS7.0g)64(dFP)ffEcRCM
]UOD63PS:EC?F+^88c5f3F1B1b54OQ_e6>&3Kf=E;&CETaT+O/PCT^D>d)PQD[WB
]-:1T9Xe5O+f=4QQM<+^D\\&]2L&_R1^V6PeKJ&<R,[GOSOK2)a88V0]=>OH(?16
+PRV/123EK:Mf,QAc(RH,d?bYbNFVTK3Le:)//R.&/b^aQ:0E[U5SEV8G\P#HCMM
&f-f#06?^^dY]EB@(II3@GS(6MJ+PETSG>D+#.[1KY27V<;7Y]+VeML+9DG,VR^e
6)@ZJR9+1)](V/[M-Cc+\M+)VRf?Ha+9W:DJ,&X,:4FfB+>.19<IR6H)d7e&^49A
DNI,TI]X^=2La8?bF=dd\XR7YX#cWZ?P7/dV-QE>2^K&@+_[?#PFYI1<g/H3F&KJ
]#bXB9NWcL+ea^36?#FCY^eUBCR:c]=FXDWd,_5cPV0DH=[W:UMO:97OJKfRH+HR
\g--_OEBF[OG(I;;U18M?R(2^.5YP5DdCR\:)dbD_K1/:X80@4MRY4d3G52EG=3,
50((JV_#81YEDZK>-b^+fJIPeA&<FMP+IeIe^\C[QfL@Z<Y#e?;0&)EV/XD;S<26
#4/S@ce/BX?<F74-f08f#e]H\1M-F>XQEbN=I?RO43A>/PBPDHY802<G-ZGQS\-.
WZ3.ZMg02;5VF[L]W?2TN7I=?_Z>5>,=M))KgbNR#5#gTebQ2>)9<4e]85TA]/g_
CD]CF:WEf&[CZ(fe/:ZJ[^Z9)D3e[?g4Se.XOGA?=5NY+aH4?LMgYP,I#GO6B)+3
/geI?@dB_EBf^X/ZBQH7Q[9c.G6R#^HZ@],gL/.?Nc<NHN+#E7D[N8C3]G[G]W\N
Ee-8[^bXY<fD-_-J&B7e7&e1?P;C2I9,OB&L9^/XQ3eL\+TL)eWV=8[TEeAFN64E
V\4Gagc[fB\A/+O&XLK/d,+d#-6Z;Z09=R:+V;YFBA3NXgKg60+=2XCc6dM87/K^
(M.P#[#S=I647I8EIS?bEM72bd./S?BZ[(gL+g(M>G;^ZdT<=:g#V14QJO:cX:QC
L-T<dV:/FO8V_ZIR;LOg(F\gF>C\&L]44P\N/fVA@LB&G>aK.ANQ5DIe)XBY5D_)
3D8U@0,HWf.I(2I)U4<aDa7,\NH/Q/SZIIFJ+)_ddDAR9Cc7V-8^6>E(8WK>f>L0
UWUK1KW_^8DW<S\D-V#MS3e3SJST0SE?2P)OaMS(-,4+52I;]M84N9BO+;#;[g0a
eU2D#ABgJ6)0]Y1,5C4e#NfNQaG8:/H7&JOEbK1SIe0QQY?T(?.V-PdSQ5-0MCP/
He2Rb#I.HA6V_TGO(AL>UY4b2TIa#Qd7>3d??11KVfcgL(5gOOC:<M6U>K8WGV0b
W/@Y)6b@9#[UTM^1JN<Y(f1QK5&_2(LT<XJ)6>\L2_HI/Y_-R1YY_ZA0/1?##fcF
3OK5e2NafZMH]a0bG?,-;DL\3;&e+,>e#LNBaSHLR&f5Z/E^__1Y2T4I^f3&YT_2
6cATN4W)2OP8NEBK@#&8(BH-\RE;DL8IOY15J18M-X25^e7aM8)Z^)^5GKg:Wb?c
#5#Y#UU/7K=@AAgeJd[]->:8?JWP#1,PJ.9]+ZIOdF>eV)]cZ6Q#5)G><W,<G09f
?PH&PFUFUYgGa,QQH1)7@-.X(>Z(FMFd(YfT/LG#S+96TYbE[b&=ASY]TMWHOK2Z
;eF,@e;#:)?W&(YS?2D/eT_45@Ub4dcUBZ_cfVRLfe)Tf1RPR=.^I]EA)/VUO8a5
G984[Z4a1]WM1EE04_2cbK:[WCgZA\7#)F9M)\3W3U/b>>=K?7@3TZS4O>G4H1b6
-6cV\=I3b_Y#S/C=48MJ^g.4\PC5X3#+_OMR,O&<KSBKW9?fPYW.^)&I?\@[33=^
W6aPJ\V-/.O(FFMbI_N/B/DX5=B2&9L[8>/UdQ9E1PJ:RfJf_K.e)HLF#UDTLcY5
9D7+/9&.8+>Y,W4:[#)F^<XV0;D/;_9^K&7UaNgRY^:EVKf[SFA1Z1b]UIRQ>e?\
4:KUIZad@R)#000WKDAQU61A8AC]ea2\H+B>_M_?8B_0TFU>SILC5)JeJ97=+#d\
V7;N^1G;Q^fC6ZA^XbTW/5=N-=IACI;&\O#T0GL_@1)XgB;5cPDaR@-\3S-Y1d7O
+7^a&>;_[;:J5DRcX95T0^>/S36[]<,P-^cL:3b/KSQ]7TV)2Ie-aFNX^W.g_][4
7O\BO32O=]&;PT_c4]246)P1AN5.;3]Na^A>M_Q2b)FOAM5@;d1<Y@=3Y4c>DFNM
>;+c)&LWDHA^JOMcTd^6L922FfO6YQ:I;^?,//(R2.\7(9bKA[V/HU7^@LH]Z7@g
V/<AeIdbM8_]FF51DFd9/^BFaOG5UCIMZ,5O/W_&<Ge4/U+;T>I[ScSSW)T^L4S3
TXM<^E9,8..Y#:+(W@__&];[+W8.U>4H-Fb6a<Ba:FI;E((FMW.&]24BHJNJ-1IC
(:/G(X5/]J&1V<D7^0Y.7)3/0LBX2EeMEKJWDQ7BJ?6C]b_=1\1EF6.b[XZ9<eC1
4:0LXHHHDN+6[[#W0e0\2\MM0QT-1FBcKS.P-:QFa.WPR=J-^5Ia1PN=91\P)#M^
UPa][YC)-;:VM&M/<U&,77IXe^L/fWa<0bFcPgPMLP)1592)c&NWBAX<J-;bM09]
]1WN:.V-HP^\3ddB(V775.SFQ/RgCfMO1@P3QM+82U8)^][2Vd[K-?g:CaY.[_^[
Nf:RH]:V>GM1<^3X.HW0[B(<#fK?22UQcC=,bE,&I>A#=<g/VN^IWf<T+7778UY2
c;fY2=cB),YR@E_J+gQ\+UZKd.2N@]MF(I55GbaWCNT3Y]N<eLM_>5S2S:M41<c:
KOG0?g9Gd>fDT7V4.F/EG,bGd+c[#\+,8QA)F(KSNRc6H,28V,N<6H)X@fZE2(\b
]=HTgZS2Z,G(^-Ed&EKVR+YggN<?NJ5Q]aM>e@b7Dg=46/<,_+0@SY[P/?>,+#e-
O;TOQWQYVeE<RZ5,S2(Ge.S,5=AH4<09YVW,QG)VHfdg2K4f2(2aJXAJ554V_NNZ
[./6DK69J[&9@_R)52fa[K^?9W5WadJ^1\BES^5DWFQ?L.1XPD6PFe[^VY^Cc+Ge
404.]6Tc)EH#cT]B.6QU])0:IVa0aWA&+UB#(KPPEJ<fR<J>PgP)@b4J<)4E4GfX
#=<>Zg,_5OHJ:M^W+.1K&3(ZaP?7GFMCIf8&BCHG0KY&1XfX@(N7TbW\+_^,WDNI
>SN^aZS3UGI<)V?Kc44/:g9JQEVaSfbPEGPNPb8J0b&X+F^\3VeF]]\EV1#71X&(
MZK=c?-da<@;,?TGg(;d=-J7X<8LJDUfK2a0EM_8EJW&ef_]<b?K+/bOMd17_g&N
6;J4.3MLf#]A&8c4:FQ4RRJ_M+P,IgeQ\\QGS18=aBP^L1K^4@?0CJfPDB>G2gaK
FH83bA6TL^fbA_,HL1;K5R0MC(8dfU8]\(5:N08755-(/+F3)YF+M#:TS67c)KET
4NRd7W^=#2SN8[M7H\67#eF[Y1X^OIP7d1Gc.O036#^SR,Zbd#F+]J53V7,fd0Y-
74QObKbTEUc\Fd5<B54SI4fcQ+S8SLIfeJW:VS#IW]B\L/HcfY)f9-2Y#bc=C]=B
LE6I?g.?[.<6\^@A>\Q_WQ+RN7?0<^FJ7HV>=HD1D&,669dRHL?77X0dLS[;IRbA
&.XQ7;J7#1I+@f_-<K0062a?43g.[LQaDfKIeOU7,C0FRBO8TC9)@F(T2H]@0/db
<?Z1T):V>AcS)31WIXMeW0)T0b4/&/E)CW&ZNaaL)Ad=9N_75(c9#??M<.M)8d2=
8bS;^9A=IL#TSAXXP3F:VFA:^DC)#?c^U(fSeI,.^>IFOO^327Dc,U)fRT2[#,da
U#J:@17fGgKMcP@8?PLad9,EKQa=_.O)Z2<dCaVE@fG@eDaYJ?N[e?E&YD+NgD>c
5U+W50c/:7R,[4PUdW?Xc?IOP=g:A.PBBVZ9+H4-EDM<5M99=f;+J1FK^]&/cF9<
8#Eb,R7Ub.J<?&,K0Ug-7BL4CAX5FWReJ;VeT,SOT;;I2cPM<[gc#V/0N^&+&5+7
VHNcP,VTUeHe=;Saf,SJ=+;ZE[BK7bfKCDBG]aF5DD&BMKREa^/NaNa0a2PZ@;)-
#25fKSK#\eK61DC3-GFc.fTGD\U--0DR9&T?PYQ0H1/T5YA(=4OZ1S#+>Y-CU(,(
<LEfaZSRcA[La>()@\>b(>+K03Af3KL29F[J387MQI.<:F47#Bf/_d54=^J4U0D3
C,(d.?P>g)eW6WWSa1VaLBE#\<F)EY:?QEWXg9KX:]X^#S6SX9)6ITbdaV^7C1(;
3:NOI1?cLdH68cg-O^OCJ9@<1BJ]eD6<eE0Q9XR;,AbD5)Hc:;Ld4L:8FbWe3WT9
<,>6#<(Y4^6PR<COB]DF1.dF/6=Rf<D\e>M4dD[Vb@HKV=b&@N#;@cEMM.c5;NP2
]VY-KfG9Y/\C4O](e7dGA:?/E(1g=-SD=>ZILH79VT5;CPOAP89()6_C0Y[3_4Y4
;ecW>@+46R)>[XWJdAC=0UfPY>gE,<,0Y99DJ:R4d&6V/5cNL_?.QU+#@Adc]0:P
CMc8cZ&S],T\G3;7;VYFI#A1&3-+>3LBfE.LT?FT^30\WONR>J)QG14/T154?W.V
-0HeI.9>3?XO:))b5a,]2JIQS8WYfT[=#?_cEaJ,1M^6NBYN1]:W1/;a6[PXUa@+
3[^T:715RFS-,2IbE>H,GdWMaSKT22[V=N,;&@UBfE-@\PAV),aX1D&=9AKg#4[&
70^T+@4#^=#URRLGNN;:&Je>UY\]eYJM_e#XKOZ&FAg#BEd^1dL-,b_6.AddHdJg
bO-7VWb5b>2&9]^5KJ8#G6R-HbOIT)^/_E+-Qd&OTaV:&NW?:=]KTeP3?VCd;9<A
CW<dIRDa_N-1V#-09dR4LSPQ]#^PRACO]C6CVK[GW/TdL,A+33EO5SggG4-e)L@T
Q[d2CE.IfLY6P(51YH=.W[cBe\@1gVIIG3E:bS-QP<DE/a4^8&&H-e[@L3e3/LA4
O^6D]866IP&<:6aQfOfg73;^c]QaOUH4?LF0IXDW20QT[7_F\c.TQ1F_Q&Tf1B/@
3E3\BdRP@CZKfLg+-[(;6cOWFJIA^;dcY),@UM=;d(Wa2L73E8M;Q\9#4]>O2PJ4
DXC]aN#I-eV3eE;(2?PV#J-)9OG:E#XF<&.5bdK/X_:IUX)(\6I,5F4^U<+Q^1,>
dY?JT:IRd@&+E-XCAYcA^J7QEA(dE<Z&LG_@dCe(V][M1=H54g\K4R]_LZ6\1W\g
)V3N7CR5/GHU/+L4MNQ)7D(8-g[c[]5eI78N/0L;:S-=LVg7fI8CAK2b1V\[MIfO
<gY@Z,\UT;K^S3;X(QU+M>Lf.B=SA&W_68D&3GG9<>I;Z1R^3TUZMK9\aKXSdLQ9
LQd.PSY[=?ZBdY.VaY9KF2^)SA).?LT9P\BY.G3,HWSH^QG?eY+]WH[JLZ&DT^C6
1S_FKBf)-]\_=QLC7+WXF(R2+D)8^9&.4?93d+2[>4>[?O.@;E.TNUF7JICDDVgC
(OGIabgB4a@<#OSeH]F]PNTOQFH2dI.KcU:N++DS[gGc-O@_4Tg:](GZJG5C-J@U
Qf[AaXTd?C7Qa\;V0IZGJD4H2G]Z=D2-O_=Q+bB/HK8->N31S0JSX,>57>)B-df/
MJ)T_ba\\Q-JV:R2b6?/Ya6(@[U+U,[c_c4V#BYDW/@(/c1gL#Cdf3D<bS2cM#Id
E3&)JIWNA#bcb2PS,D,A/gP.K1YF3f??:.6GIK#BSFQK3/Qg>f3g7Mg)97KU(,D)
7D0U5;SRa#0K=c^FGA&3C3_&J5NZ.QOOJ[?O_g+eZIJdc]&4M7G/gKTV+<O-BQf.
H5-=6bI_AUH4a4WVPFf+]5(67.^1IJZZ\1[^aW]#B>W56:Y_ZGJ#1SecgQL>(0T7
+BHeQ@&.&].1=0QcdRO+?U;d+9=(V7JK6[FfD9)8b89ZV,fK>X[[GW;7ca[]X;L_
U&)[+GbZ2DSGaXT8B_1S&;B_B@aTcI-2bW,GdGgf[]UQER<,IA4G39=BLJa^L?FK
F-;Z8:+/6,POBC0a?&AgNdE.:1MFe(WG/eFW5^S.6;bELB>U.fC0L]=;6eXQ=)LO
L60TbOd8NP0XS)F6=fTEaaU?S5RMVCK,)82SX7I/)USX5+V)ZQ/FUVFP<-1Db[Q6
Y,RF7LD9Y?)P8VLDf/NU_1+\3fc8)&d.=a>&CL3Ic&,0P</?01a1\,\&Ge4Gb.,@
LVX^R<43JC8O9=c5LQb0.=48C@]b4JJQ)b#23Kad5A)NI5,#U7N-;7\?>-]5IP=2
XHLA7+L[QTNR<Z+LLI,Y?bUAGc^:V/F3:>C=>4;;TT2+&EGB=\d((M;e@7L=:3^>
6ffZO4Ye&?1_1K:1?L)<?HUA7$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_IS25_AC_CONFIGURATION_SV
