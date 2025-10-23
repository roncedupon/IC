
`ifndef GUARD_SVT_SPI_FLASH_MT25Q_SDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MT25Q_SDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Micron MT25Q device family in SDR mode.
 */
class svt_spi_flash_mt25q_sdr_ac_configuration extends svt_configuration;

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
   * Minimum Clock high pulse width duration.
   */ 
  real tCH_ns[];

  /**
   * Minimum Clock Low pulse width duration.
   */ 
  real tCL_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command (SPI) command
   */ 
  real tCH_Fast_Read_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Octal Output command 
   */ 
  real tCH_Fast_Read_DUAL_OUTPUT_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Octal IO command 
   */ 
  real tCH_Fast_Read_DUAL_IO_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command (SPI) command
   */ 
  real tCH_Fast_Read_QUAD_OUTPUT_ns[];

  /**
   * Minimum Clock High/Low pulse time for 4 byte Fast READ Octal Output command 
   */ 
  real tCH_Fast_Read_QUAD_IO_ns[];

  /**
   * Minimum Duration in ns for which Slave Select must be deasserted in
   * between Two Instruction sequence 
   */ 
  real tSHSL_ns[];

  /**
   * CS# Active Setup time
   */ 
  real tSLCH_ns = initial_time;

  /**
   * CS# Not Active Hold time
   */ 
  real tCHSL_ns = initial_time;

  /**
   * CS# Active Hold time
   */ 
  real tCHSH_ns = initial_time;

  /**
   * CS# Not Active Setup time
   */ 
  real tSHCH_ns = initial_time;

  /**
   * Data in Setup time
   */
  real tDVCH_ns = initial_time;

  /**
   * Data in Hold time
   */
  real tCHDX_ns = initial_time;

  /**
   * Output Disable time
   */ 
  real tSHQZ_ns = initial_time;

  /**
   * WP# Setup time
   */
  real tWHSL_ns = initial_time;

  /**
   * WP# Hold time
   */ 
  real tSHWL_ns = initial_time;

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
   * HOLD Active Setup time
   */
  real tHLCH_ns = initial_time;

  /**
   * HOLD Active Hold time
   */
  real tCHHH_ns = initial_time;

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

  ///** Assign refernce of spi_mem_configuration object */
  extern virtual function void set_timing_cfg(svt_spi_mem_configuration cfg);

  /** Randomize all timing parameters in between declared range */
  extern virtual function void set_timing_params();

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
  `svt_vmm_data_new(svt_spi_flash_mt25q_sdr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_mt25q_sdr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mt25q_sdr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mt25q_sdr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_mt25q_sdr_ac_configuration.
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
//  extern virtual function int get_clk_parameter_index(svt_spi_types::flash_command_enum flash_command);
  

  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_flash_mt25q_sdr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mt25q_sdr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
@]2=WPB;_?U2_ad/fYU\_E#/P[e_^>AgE>RbRY=H6I^>C:2HgBSA2)eEZcW2JW5&
_A9NOGM2_Kca??)[03dg9Y08O(D)YAd&a;?Q9:KE[RHd,)BXI6^H;.PJN6_4W1P?
1e?VSI#WN;@aK=/6RV4X3K5<:S_d6)U>;DEECNKbc;bIEQ5e-94M>&1WOCMgLb@8
C7A8HfP)JP82F2L1+TB3V9Ob0dKMd,UcB\D8,NCbQcc&/M0@]BKM5UB[?><S:E-<
Ldf5;QI17K-fP(7gd)\US+X6c83M/Df_LRO[/(FMPKcd/eTE^)UDD\;&3?fMZWbL
Sd=^EUYDPE71e;-LC?]d825a4KS2S./a.6+R?^Q-;.K<Qb@EB-ZCf5T[;5(U:eHZ
a+K^<AdY3Q#P=[KYV-V#.eRIY2D+K+/V<fQ;;EPAbd7S=0F@P8^f0QI0]?XB87XT
59/T1?HM8C4DPTSUaVEW<Y;?LU@4HS.?(gc/428GN>ZXC,U5gPP<7ES&TB[Y\WB+
WODTO\OE9ZS[a.YYS>,c72G_VJ@f:FOdD?A<7@-dBDZRT^=gQgSbA\H,.:-AQ8J0
f;,92ZE@;M4Q/B+f;5eNLS@X\AKaLA;\=K:e;[cJ.7SB+4(\#Y6dLLHIC1=S5KH7
+e0I8.R?UMDXLS.KZLVX>(3W;FB\.(L[8A?N9FZ7UPX8a0>>?]49&7?6H.V1[,N]
@99+=NS4)ALO-\9[F8#&LPUCg^&+X9G(cQ<;(N#F1&A;?T?RYSN+;2(O1(4KI.L?
#_M\]AfEf8[W>D_OHaG5LOUC5$
`endprotected


//vcs_vip_protect
`protected
V+Rg>aOcF&L&#ND?).ed3a,_^2WdAUKbP2FP,=6])>KX\.[59PL04()8-,/4Q((8
.XJ.gBFO;JOL]GYZO5b[1KL#J,7PR)a\3b88,2WY;9fW(VHH#X)UBgEF)#.W<DRd
LM1E57cH4L-6X+e2U/g/>Y29O,I8H?7VcFPVLQb\==BD0B2ZTO6<9BF:fW&GfHI=
SJ=-2#XI-Z61=#YZ0&f]W2b>2)3NaA2S+\V\J=_>3f?2B&cP#A<J;OS/QX2:[ND.
].-HG=7dEeDeKa#_;PfD4gQM->;aI;[WK0P#&#O_DEXM9[7V8Cga&)[>L2D7BS1T
a[U+9B,+FT@=\:[WP8(f]?[#d;1J(5,62J#+5HHZO:>9=Cc)WbPNB6L33=(]RVYW
<+4HU3RI=HAYC,g)_=6>9?<_6\Ne)WaQ\:W8cD#a(>25MZ:,3SM:SQ5Ybb:\YJFd
0E7C+H&W550NH;6394#>>aI,^.K&JU8_>:L/&O;MI.c=)T=H/AIA@f91D;1.eIML
K78HE\^e;F6+b@QK]\KQD-(PZJY#\V>8g8T5a];YeR.ZKGH&/VMBB7Ue/#&XLQ:D
5:9D8BN6RN8IB@D:U/NWIO/dAa2bN8PG]\S,0U-@-6OfQNg)>Z-0G\.4O\[DB\-G
2A5KEQ?K(1g,R2M&@51J3)O][#]Y>ED@P8ST#U-NBZBTJ7BIMRXUQ<;gf62R=:g/
4<Z\#CG[-BaM._DYJYE18<^3)EPA\g/4+MS:g5RK71aK2b,--VCDP?_5K)KC6gV;
/[V7D@2c8@cZRg04W4AP/(;?(/Xa,(W:IL?B\QTI;8D.NN&7#\TE/T3;gbfdZA=D
TLd(F#4?AXTGZYI_OePA<LTf6CWQA1NV7dW,T[O+9_,<[ULD-APS6bPN+TXD7_\d
8JMS0LBa_1RM^AV=2gU<B@8)[P/PdEeAK00\CE)1CK5f6K^7IUG,aDe(;WfKQO)3
RT\MVY2.4-C:cf4#^@63d5?654]7K\KZ8S+NdM?1P<MFX]HZB.Xb7cJL_Q?MQ-XX
E8d@+=,fB2#@W\CS/E)XXD16/5+RS28]@Z,C_6S=2W]68_T9\;LA;F)OfM=M^2a(
MG\7]2[R4&Z_<cI#?.Q-?K0ZC_K9[T0E^cC,O76>E4>#DBc[P\.7GJ8Td@YUdKO;
>8Z0c3,@+>eG&@2U#:Kg0;dQf:gCR<e([7&LJa0V;E4WP<[@V7GM-@7VgJ@X4=8=
f0V&H0WX)K+/g>0/0=;Z.a0W,)(P]H&JKTZCJRUX(&I7:1&&F\9f#fO-13H=ebN4
TVA6<Y^B3?WM(eX<V:R)[]A>0+H.a7.[g5@W4bXf^_O?SI)NUS,M6)gTF@B?,SY@
DUa&[6Y,VY^M?)\?[8]-KE+J0=^BTI4bKGZ/LFSNTGYJC^aC7S2=)EX<C-dKEbC_
>:R-AU\E<Tg^A>fNUI=gGU.(FNAGVd=O@bf2&cEM:6R8/.M\S&YGS40:[=[Q-^BX
#f9@[0IM@1:WCF1JW\MNN_?2@EDX0II]Z=W]b<JIU1<V\[f,\FfTCgGVWJ\&=TR6
UHZ_I/GL5gQKdG:?Ag88gNG/]\)IH?[7B31#6//5MX2YBfYbW1W3B4)b):PP8]S7
0a\R\T4([</b#E_[dce-3dEXD6WXK]/>cgHER1.=)QD@VH6ba[+HeG)Ib0VCW8cD
V@J6I^:@dH/2^UP9^5gB=9Vda/9:^QZ1;L^1X1[f,P>5C#N3QJ5L?2\dZPW-XHJ9
8>,bO?J9[)1R<dHN2]\RE1Q+<6@e7;0]BUVg6^d2b]@OBMXN>R_Pe79L2Rdd^V7U
(ScX[13+LIYTJa.8/MM^GOF1F=M.fO)a_;^5gV8Q5dLc&XTf^(b1=5,QP3]Y3PSQ
AMASF=@90f\7/WAMbD2-4:5?bU6#U=I_K=)X2L(/#0@SSKVYSD_eb[a(Z];KbK^]
3374HV>24=ZQ6a0VG5Ja=CX.^&)=2W@Y>YCAV1+MQEfC6Igf.KVA?ES_(:@eIa5^
)[Q+aR[_3OQE.BTDPWRYO@f9c4bc-)=C#>QWB-_>FX&7;TV(3YWV+?^A6N-1Jb?:
cKX^3/9bZ6_<T:5PaL2;/CR=_dbPBJ=+Oc(0a);,Q[224eAAT<<F7XfFKUb#H\J8
=2LR_6G@5P)Jg<N&./31][f8b)d],N84[@(\J3G.gaeSV8a6E;Bd3d8fB;(@@)KA
KU&@8FXH+)2I,3f;249EB2SW5(^VV3@Z1CP?X\_b&JU(^^,-5\@DRc,\])<&e+\+
[+44NN+#&QC;BeE1Zgb@UWY]GR4b=fB[a39P\6PT@>U8N3D/B<Yd7B)cgGB<^I:D
F]IO8+S?3BC4=AgLU(]+7#ffY8E,fUG4.-\3M?KAfO)KM)e)<\AYb1KS3c<P=dc7
7H.RdJbRZeXT>SX<I-?/IJS8;55-.ETbF;8eDcD.aH_\.#BXKZTKI.5KZSZRS=VI
.ED:H+#]COYJ;Y,8M-5Y-;\6EZ^R;MC;X@(NKO8C,X2Bc4:JM4Y8MQC=6>DV-9^8
?8[B4VdLe7aZca3]\f\,C(-fbWbe@8:SVJ3Nf\8E_,Z6UYN\^Ed^LK=#RNGT^S0U
Z=BGLG@]N(R3Ubf:EXU<UW;^b#_CNbR8#\#1,8b5)M<VH?b@N;UO##d5V?-A-K#@
VO9Yag9defCHL1ZGSfSXVV<a5BDRb#4ce5PB(H.6[[NS0Dg8^DHg:g^T9Y@a<L^L
]([=>RFag@FeJ&(eSbCA@1La0AAA>ZAT7(W>IK./@H[H)(_&);Qf/2gL?>TOK9HC
7[+:B)(U_RUC7[e()A><&<@MBT9-A4;L6aNMO(WI/RK1_LScBgDOYd^(W<(^;OWd
C]Wga]JL_RM?>0[:R5Z)]]Pa;KfM\F3D/E:Fg\JHbd#_(XdXUR;:=^[,M.5c11Y:
YDb3Z(ff/5@4L^6[R5SQL@TLU.6OZN(\,cJWXK\,bKC=JMK&&O3\6NCQE@&&Y4S:
bAZg]4Gdf=P84c^.EJJJO:NHe&V6,XTW64,d?DY#-G?Le_gHW6U8#.\6P/OA\[1+
dXBde1ZIg9_PfKC?HU\@8>bAY&7XYd[D8ZeV_TRK]Tgb3812:)1fD-a.0e:c2Q,?
XdY1Y+I)M:b3IF+[\(A_[S7+R,D2JfRf^5+D]28W@M0,QV>DV4a(Q95XOLR)7cK&
G0N14g39V7&T8+1?d.684&46[6IBYI&PBJeVDD_A\SKE0(D[c<#_/N.Vbe@AZc9O
<CZega?F/cNWO?8J554=LP/ca>6D^ONE&eJQ\LC&Q3C4H3&-YbPO(2;V:59G+_a3
:Q#GKbH&41_@DF_U[S-bO)FXK\=(=8?0(7]\5.#X#N_2?U[DP.d^;/5N-d?=,<9B
:^ZDFVF0X-]-d&:-YT\&HKDQ(IS)ObW:d-(?//CC/YO&+?_QQW^@QX5BEfaEMLD(
LKC._N,#DdY>B2RYQda9e7-f_]N-NDg=L=PBe1W0L4>H<_4-,1C_SXL8/>&9USB/
<_FS&^Ab#^;>@68?1X#=:\66d,CM1Vc8UT4:W]6#6H4P+V><cU5@-d\\;Q338X<1
<YbX;=&>fHP9R2_66ec_L?HFB=R,9LRT=9M+BQI4Y]W4R4(GPU+b1+&314P[JXR6
EVTQ,>_<D527KVRdCTc)P6=A8.C_1B;<X?2T#FDGba8^9ACK&7dD@;_&c#NYED0&
@,U]Sd\9GBeXF/<FJ7f]_,=_PWV\\E_CDZB2B8,#]K;QD_UbG1gT2fTT>FKX;XJ+
R^<XYR6I]15T9KT<T(:50K<M#<II3=b3c=Zg]6H-b:,VY&87([S@#@Fg3:(4gOE1
/3UKbZ?0Ub2(e?8eSE?R3>MS98<?Q5FH2dUa]\65bT_MYKK7UYQfBEGU7K;:DLQ:
;I:GKgS_.45.JG[e2V+Qb@W2,3><b:^YQ7GK5aO:(0&)S5DcAX--8)=^:+A-P5cJ
5W:@g2ae[c,]_a=]YXUN\5aP>,.a^4X.L(80=-?X,E^GY-61gO\&RV4Fa.[:3QAB
-?W+5-CV+F9UAf9#SVa=J6ff]A+^(H)I,2gGV<(CR?J1T;N2LdY,PAJ_L.^<Wc_Z
1B>?_8Uef[XOIf=0B5Id/B6PH#eM(.>MVA[_QcI=,(E/UUG:bR(Q>K]&RQB)FEAc
M.^XR^_d>G0OBb8Ag_[/CLR2LG.ILJ/B6A3WaY1:.3C#+_SP\==F=bMfEdW,;gY)
RC,+IP9,B>49OKBWcASSUDBbOffSOMX.e26eXd1O&>Pb1@G]TA2b7M=L-8FCeY\,
KGRCO:70DA.9R_I2)Y1@cOT@[U,0)+WE;1O:S&X+YQ#ZWDIH161@ETQI0L#1-8@R
#cf9Y?ab(K)VfRL2#dW+9-EMD4NYCbIS#83UU@KEA[.66.;Ea<A1+UEGefC?gbH4
W5<EVY@gc=a?;Y8(&1S0fP+^0^f=M-KIfg;EUC]b3,]WWQK0GB@C@G.I@4/TN/D8
dG\^Yb.RR6E+@-Cg663GgOWc:Z5DPFXV?0DHJKP/0>+W8Ae7:&(-6#9Cc#c0eS=K
NB,ML9:f\:AfB9=O27CQMHJPYQB<@B2LC<#&76d3]AH:TLaH5X,eL)>)?GJb7]2I
UY);P\YQ=2_/0#?G,1A(4-/0R@J8<85LC]4&R<EgZY\+0&aW>[Z-<_SS9/T:+#6W
]bYf[VB)D4]3+A&@86<1_0^g.4LK9??P]=Y4WReMUd/K-Z3N3Z7R^^8NX-S7LPQ:
RQIM-)bS-.e<AM4<c0FLg1.S,<JIOb2ad+>aLNY@a#J3^0@--G6Q?+Q/#8T2;PS3
b7=c93+JREd)c8VS]=WYAL=J48W1Mgf.V6UH^1EQG.\WK8J:/EeU>Ff/JQbZ/N<J
AEV2,L1+f[gO>.4/(e.>^Rb[>IG&J^/2I<Q\aT,+>#E\U+US7aN=FW<J<\a;Z1Me
6^AD-8R^O]Ubdf6[;A#;F3O.bfM1X(995R@P&AJ9LH_\faR9ae1,J6Z?SK9]A6V9
]c2X5#[KVSFdD79+d(b4f#UQGTV^T,da_9aU_L/?[59Z-aIH0AESQe;^RVX2Df05
A6d(D6/I76VRW)Y2HaF:6CBSEHO21P8_M4]RM.SU^3c1P>O?PB9Ff@V5O<A>YY>E
035ZGaA:;<dR>dbO.(N_G]P.dUM97T#<H#b.D(B=_Vc^ER.=-KZ&\1RUG[W-\4RH
IVMZLDBD^4AWE@),@/f.FKdAA)NTCe#)eHd@F[Q0_f(MR,_77aa^.>7g]=CW;.V?
:a3@_EeH@0;1BD<OZI+db(C-U14<IXHHc#UK;#?J2<1BTb68=ZLRLe\Q(NV@K]=7
>&4+/5<^E&=0^3fdYG1H?>#.K;;:)K;&ceKQ?NB;O)b66Y.^d0;dND?SgSA50<aZ
9bFL36S#WMB;.5\88QP@VII]AYc1H9JQ>]PQ)Kg[fU>I36)FE(DfBZB^^Y5XR3Za
b-FeNXW:+]A5B-C#?K:HVWfFXP=(\,969-YF8Ce-YBQ-JG,,AI,T-[-YFQD1VXZ-
f].DTF0f@RNZQ)U?X=.;K>SLT1ARLfBV+5VO/)c&S?K7Z0^)T)b>4TSI]cS;e[BS
#)#Q81NPKZS>DDDIHT-CW9[-\7O5L4KZMd=_1WT80ITaR>)RD=0^(NcA,<(-03VC
HTJ&[AY/dWeAf&WJ9@>28APOg5+FA(F=-MLWTRC2F]b5)S/XMPI/-PD:AJ7&2E-d
^beIB:J.fdXHd>RT.RK2)9+_UGOBZ@+?K<-T7.A,2<H),(7>6I1R5A7]M4U2NU9-
QE_[[f^.U7D\#13>N1P@+Uf[A0Hf4.c39V-?./d_729?Z1-H1]b&<d<J1FMa1>CQ
27#B0,_IW/ZYLM<,R:#<fc_-38O4a\@e8b+5E0.,FI),>XPZc,@aUedNb[BfgD(Y
CC6+S8+HT]N;>?G5:PI&,[:Q2Y]6<G)HVTT]Kg+gP=a#Y,_:(VVX+#QP)#dS)OO#
=REKDA^9&aU](TFb_4KacFe<CSGN/CFNE-=JP=58GP((bGeKRe_,LR;JIRO,6HOf
);>ZBJEeC1VDJRc9ccKfNLKgb_TM-5BLX-FTP3Gc1?CbF/=>A3bK6HN;PP2#M]J]
W6ML-+QAPY.XF=CC_aV+(IdDY+KN#N/&(QV[^dd0Q>e^>&6\=OTC6@CA?WgWSf)O
KdMd1cVMW:09@^9?7HfIdI-//03d>9RK,NRMJ@(64aM7L+=gKP2Q4:<UU3=^^4W-
aKXPP70+Yc^gV/VCMY_GS_GCM7ZDK3gK>-bUM??ISYHGM90?/C7eBZd#]GT)0:XV
]+4EO&NcXe/JP:[N3?AJ,SC@37d,B9#-6N1VB.Z4KeZP8VRdTGb]V0?M_KD3G&Q-
_OC4A-T>52:>c(_G1)e:_bO0A>&TAeNZ6]P<NeRW7QN)<g#4H3bD>5E<La\MbHMe
]:C=<S+S,I\IV(eL>Sc93_BCfQ1FGVG[+M&^=8bRg7;)&8BMd?Rd5BHEUH:fUJ3]
S<ZWJaN9RM)?ZKcF]T<#=+W&F=)^5+RK:H4LYgG@4I8&U7O3&1A5+:bba\=NC<]b
IYg7)Z_(11MfB@_1CK(LUONc,C\C1eFPgFMJe3>8eS:^T(Y-McfP4d=)VPfL6&bS
E/^1H&.,YKe>De8B]Q:F\<6J_?3J/G_e9=UMDW4G;b.>e+9ZL-Zd,:\83OE3PEgQ
YWB2M:\=QPDA-X+D>B@a+;8bI[,C#B;ZB\O;,9HbP4)N3EU\]eFeN4+J-PI&OB7(
?4IC5)ASQb\DFQ:]AR[Y_DX3bOL+:SX78.X6_>c5BH-d1e)S^Q77QX3J41-+ZGU)
7eTU8,,2T(-e]W)HP7@Ve,@Ka:0@c5T7]I=AZB?>6W:M[3cAYX5-cLN6fG0TUWX_
/EVC?&?=-&.\[)BaFLXRRLC1e68.OD@A:,Y:fc4+&NTT:G,44Z\RgVMg3c:B4&Nd
0aD@?#4SbR=+MLNWMVc@VGeeRHR+/;F]&8O1:.B13Ib^D&>g0_X>aCb[GVNHeb<c
<EeY3Yd6/F:fRE(#?N?WgK4>H8N-T;\#9U(]efILFTdcZd.bZ>X=JL@fJ5@&cCX5
Fe7dUfY^)HKYga2<3b]3>eSOR5d.-dGE>6[bZX2R;UZ2cZ&eY^K6[Q/J;\f_E)g,
eOIaR5DS)P?N\XY#aTSM^,@^aM?-7(Q(3DB-?#X;9&b&4CS8Tf#6/I>L_4R0N(4_
X]&JU49I9/DeUW00B-7.C4gWQ&;NCCaH/P(S>NMLg_)(OLD+)^fFBJS=d].2NOKW
e<Jf[RH;]6VZ(Q,;aZd86R4DI=0J^T,_XG\;4(WEFZ#c-,D8>f7O6&M7LY7YDQQU
8.;]-CVC^+.QW7Q7F@A>5-LQ@b^b6A7+(BdW-X-:IG,KK2@B5M7BfHd:?bO4.E^e
[KWQSV,_E;@9WW&?NJ9+R)a)BP0Z-D\E;[Ab9bN@NG4)_TF?Q0fB1./A:[5THI[a
fTFCSW.K0aCX-#XVAI#^]>P0N+LB57C06?V9QM7aBRaPGR9,MM6da2@P/bUV9?X(
1/B2/[0:4A@WOAbN>;+Y4<E_J3CYZ>#+;?H(JP6+@2YV.<P,K\WB=HMHd+g5MVD<
?c6A#(++Cb7/0WfL^-)3@EOPVXF-SaV8/c&E&]U;#^+0&\@af[T#?402TY7OAgcY
@]&De2?JX.W,X3P:KM/L/>2+&W:JE@^@,M:6Df8_S@;K(N#<>99L#YVT#Q<gVe2H
XXW8eEE?B<eAF-EGY;_R-.W-\]794:G-3Y8d:bf-E(eMW_K@.&M5AQQ1J.Ed;0O)
S1W\f@F>QC,(aC:eFEBaW[NfD\<8]7e<6a+VOMgXP:6H+1I.F@1d24,9)MLdWB^D
+OE3AH1CIOY/b2EW7XWBCWA_<;WA^c;aLFZa?^:89NddbeZF7eY;9DB;5X3g<ITE
S9^dB+bS[&#^F--Pg75>.ZcQS+_5?-+R)HKd=E2[Sa?3><U>Qf@NI?L&,1]K[0?<
g4R9eP-@24cKO1Cf,JEF\1.[XfbV4M1g@6fM>V4IFZN=[<58#0e3g0WFD=_KSL4&
d&BE^Ga8[RDQAe>3+TV8fT;VH=YFgb)NCV=RXQcXa-/IOJF14<[?VRWfE8X4&f7?
>.+#>#aUWE/@R]UBY)3FE-]DZ:Q&#2Q1b??_;M<3Zef6E[6L[#ED+O9Ae:4CD+:D
T&+XW(c]T(KQR85bIY1(DVN7&=BM;e[:<CTBM^@WG+]]_WIdA+Xa+)JM7FgY4(J)
c917dBWS^HWERbWO^IOaH@&7^?-BQFH0M)9Ib]>[<ZGA[\@f@X9^WNXKX3HV.fbM
7PK(C4d-YK@ISV7G1XPSH5fK#]\L0Ndg;E4<dVRe]9E,f^dURZLgaKca#-3cK-:&
=bP-:A=-W;_=[Ff=YB2^==2Lb1TeOR0Q.3:cJA.U3+dcY>OD)Q5VA5-@@.Y74U9I
B#Q@^-[T5P,0577ZT;H989MPNbT)#QGO@G6-0KeU)6?<ZTCJb2?3A=#KF[Z)+=_O
1gJ.e[#gHcWI<Z+)/M=YZ]a/VZ_N,.\]0;f2f223HG-:?<^eaFIAJY[HgcN-Gg/9
+JVX8E]X&g@D\_ES]WQ&@967FE-VM+\OaW?a-gM6e20>6]4YB^H]@/J-EXG)>X<e
b71:C7AOMK2/EXV?<:-KT,d=<5Z;B)^O@REI#=U9?0TY=KdS:APCOc,gN:<_X0G(
AC>H>?((DE^V\R99P<O+1,<I3@#K[_GY?_[>)PfI\9#O+YaYCZ>/2MVK6--5SY]U
MA\^c=4eW+39[W4:LOVG@K^:N1QBEA==f5W<U.,XBN,^FRbLMD&La9</L[P)[+SP
QD6dWb7X>&I@9a_+>6g,5a/\#JMV?-,fW]D2Y+33:@U=AC:_3M1O.#<LJU,1[MFf
X/[,0-OXXA8B:ce<_fR^EZ>?^DM2YPBMe>WM8>8:0g:6^^fT&#Ida=Z[89=e@6)J
3L-WLSF&FBXa4Rb&EHWZJW7QN)]8X?SYE/C\:;3>1-6dM@&cA@PB]8V7K[2c=<<&
LXSfZS51ReB_C\37^cffAO<,&&P&5E9X68g(aa##V4e0?WC.Xf=c\5S:f)#d?B#P
O-1WKcC4P#NdHM?JeJS);A]cI\+M#\OOVd_cFH.9L8<D[[#Sb1I64+XP\7=1AGS7
G:LPDUD>?NGDKE,aRCCOWG9b?UBOF<[LHKe1V,b,S,cAL?WGEWLOJ.OA?(Y[&<5:
#9]URY8UH>gP:<MZ>7B,70PXX_RV[J\PU8/[g_gC=PE,d0b=C,U2.PJ;IgK)L./A
2>>efZf(>P]FN;/O]cS]:DaaVOUJXD.#B/ad]4/B-[[g7-Z8aTVVf<^PY[0_ZI=U
e+#<\6Y[VEg67-aZ8JB+6g]AbN;->R_TMcJ]CRB=C8P@+bB_:bLK09JS6P,/Y>.U
D,Y\H,/J+</fR/JdKX@CN#3HX2G;TC;^RY,J[2KAEAg]--YVE3IfX?2fOUS\E]6U
YVKb>W[7AP(a\\D)c>R.=9;^C_?5YTd3NSCAeZWb7-HU,_J(23)8YPeP(GL7bP6d
OW7@7A:Qe(TU#1/Rg^+9N^]0;D&\3^XD-/JSQ.9.b)+c[#9O7b;JSN3(Ab+P=,[O
\2J<6PMfcE5?C^-&FXc+DM0L5@07V,E@7F4?;3IKT\1E&);4B4H:2>eA53fS\@V]
I??H?4L(L;>AE77XM)AgQ<G&J(MbfBDg5Qd?]0=<Y?/6g6;4\3VR@GcTJWdRBR+R
UBfAST\#FECFgKH5IM&VXK-Ae\8XREcb?S&,Q>@KMQ^,dL0RHVeg\W97(XPbZZa4
Q+S^fCO]5+2HDF?I?KJ;X:XV,/dXNf7(N,RP5[/M?[^^aNO_+c/K-&_MGQ=;ONKA
4<Ld0IO[F5E83R;FQeVW5R=^/WPCd#OAgG[2\cZLXAF&:>WNPZ.B:?U[eG#V]QV;
^FDHd=U,&I1(.3ZK>3&[FN&f2b6af\B0(E_<^F9Ld-eH0TR#@4a_X3H3f;#YV=\7
OeM^4QNQ@E1G6CA6RJdQI8@N0W-H.00e1b+([fB+90YgYg0XS(,/<6KVHaEP_M]c
BS\)1a;g52f3d>_=ZV;SEW>Z\(30S\<J5-af^]5M&Dc083@aXHU[C/O[)=@@Cb2g
X;aN/&B<HNNec=:/YKAO&MMZ?8KM-Q:Y#4WH&7+^5(OYV[BY4:90:CY1YE#CUP;T
2cB7&=&@;VSEJ3N\SLZ_gd>KOba#6Se_:N/Yf=#SVCW.N#[^O5]:L.eWgS0HN-Ig
.O3eNS3I&7,/0ddS@,9KJO#A8PX[f,WWHI,3V/dg;2/Be4X-Of1KP6T6<QV&g^B<
<1<HQK8<fg-UCG4R]-A;3._^F-F34LMD36YeTLY_6cV=KRA>4:#,^0fG^fgA4N=9
75acIcR;^BPS04A8OI2K1:EW^M-?4Y]L4>dQ-J^Q]R);WWfABFf45eHL[g:VM-d4
J8_&1Ib(^Y,3LP[d939DN3;(a4<C[D9BT=>:(b^L(f1OJ38d&@KBO9AGaXFYJ=Yb
]:F/dGA6eEBOef66PMX1M4C3f8D+@Tf]>b&7D/<ET479T1gKOAVL2HF-@OfC/Z,D
_&ZUR2M)8(?<1V>@[70GO4]U+I)JbF&7d&/+b>,C>=N<G^HK7W)HA-W\H=c#@0Rf
VK>33T8fe[DUPEFM8bVcL4JP@XT]X(55UB7]0#=3\QU=P/5#[YL92T<C<[-@:AHQ
Y1EQ,.Cd,fPJQK&24GCZ2?VC?>.^N1]FZV=1KbegZ&G9T_.O4U+B1M<FG&:GWf/F
-gK4-@E+>\3>3JPTHK5;EMPGgPLM2CZC[M&95EB;HG_V(<27@]@QeZ(-:cd^S+gI
L4=>aSD[&4EDHZ?cJ3[H_:VRERNW2\YG8^BHB.;IG[2E(g;+c6\@]E-HZ>+POSc;
C[&U+U#.N)e.gPB>E;<(,b4[gFA10cK[W1@.[L?c]P3K3.Hb;W)=Zb\O-9+U9c3<
[1EbHD_C[=e:B34S1>LcQWM6I^DccM1CJ[^X=/I088Y(NPE5S;=&(9_TfC1Ge1&[
<TUAX/KL5E_4Ke>-@HN)]QMLYR[?.65bEJV7Gb8/c)</cK9)@(4+[XW:AH:H__]I
C];W?YJ6K.a<@JUU0\H9fK7bH+L9fERG;HQ^Z5]a:0F\CUfLDUH@STdg&7>)ZL1&
\,eR:N6?,3BJ)Y-c_Ug@-D:f_(PDf59e&KdNVUc-2]PN48C@K3EU+Ze&cQXRL;SQ
#Kb-4E.B=fE_]:Z3[UB(5g+FE6g(SBI>K#f6Gb-8Da>O->FE<=>cPc-2TdQ64^Od
0#&PF]29@8Z?PJ91SL0PIS>&ERI\KFU[Y,?N7KRLFB&1V<5ZR70GZ/F&7Nf9X(cI
G4R(LdOC9<PBT;BWBNPBbV\HbZ:KA&YcRF@P0C[:<-3>:/.d\?A[QO4=\)Z+#GKd
S/<9:/(S=We?^6DYN_aAETJfH>6SdY_J9cDS/d>Yg3<A4HPa8DQ54^99#)Eg+fCG
^-IU^2U7KgE9Wd)XVO\2fC#T,IfCA5]:>V(,<3gg[b+b[fKLK7)@5--[A]gc\NZ1
#A[eWOJMLHI?>DXM;7cTGgG^>W+@[#@IT1aZb;0014RA4L;Z5W;-5/_?X4@N7-4W
YH<,1fW^\_>fXT-GJ+753:O)>#PTJL;]UB7LJ-PgcL2[-0\>8g&]&\XVfId2?6;-
/:V81ZVeY<]dE.65#._R&/7AK7:-L]E>1./S/FU[.-\G4fT?,5C_S1GPA]^:QG;d
KR-RP/Xd4b4@TH,RXRc.):^NK#PWb_b8?D9&=F?B[K48?Yb-J-KUKa4DZVDER7FA
C9<b/R1P[f:Ea#b+S0F[?(G13QUQ.U2?F_?;E<8,6.0X^UA)KSVG7)Y(0T:dYG)Y
BJA&S)FKP,I#3;_YePW:>9(80;1L-I=<Ug<R8NPVLbfDG-@:NQ4X>+O;_<,(UWeS
gXRA)Xa(3G?6&:H[.IE>L@HD\JCKdOIV80A=Q/.g1H4LLLJH^R8):]Y3RFNQJ@.X
J[#aQ7)0Q3;CY@a)-9;Jef1?bE+Ta/B>=D\HP7C/[U266GE#XF#O,YV>M+T[VJ@6
ba:SB)2BN6:\]<BKP3(UERaI?K4cBK]LBWYeL41SX(Z)=0gKRT3I^0BX&C;c56fa
0IYB65]fca&IfUEdPN?S0[7&0ZE:QDJY;H3cF<7XE?\[T#(]#9e+dN^PAEQ,/bgR
:\)Pa]92.V@-gfA8X6Y+EIN&a+BW<.@L+YLK@g/W)^N(,J@7^MY/V;@#.QY7TKQH
FDC(Ec.AST?=U^U<R9)gd3^cEZ/<-#R1HW6)SP>2,XAG@)==X,RMB0)\fUFT<+M6
WE,TdGdTTA/QbAc=BNP9aW=OZ_G8ggaQ.b13GI)gPQ0MEXS^Q(@2A2))RBcAW01X
\(?>)S7MK(]0Yg>-^bL5^TcE?)QFI#)aBG(VE/_/?0NOP#PKH;Uf4=:/,5[,J)/#
S=0EggDJK\1ZJc:_FS=GC^WC[dF.W-\aXN05ECd08)),HK_/UN/W,T[-2E=c0],&
Fc]Q&)&Q.;a#)e=IBWVV99@<0^RRB#<P]&V/:M6:?W8BbUSTPA/_A6[Y<49fbZ).
7H8NQ5Z_F43-90I(QHZ^6F:[V@PbX7MQgNgE5&gD+X/.Sa6C2f7V.^>2UR^/0K1(
6XA(O;N2(1[/=e\^?[CA+MAFMPRBf.)3:He1P9Lb/_U-K)b7bNQb<#_;1&^SS/N^
HR.(LJMA582eO-<&1TB]I.ge>U/DB+[bVT3G1KME-dg=T\+BK4WOSO51O<;_7,33
W3Q35.#ObJ8?VecB:LE2RK6P4]311_c-P-gR4?C,e2b0;.fXJL-R7dC[JU-)4a&B
;(_8JF=6&5RF5>UK?4[g)5DI,fC-fgQVd^eH<Ed7F:#S3+,(K.E9_TKUZd-FB^UQ
g;CNFfW.E4(0+R#6P;,LY6g>U8HAPWZ_]9UH_+bNId.+=LWHNN:c/6O-4fd^K<,V
JM)EU9-HH]FZ<=TUKNI:Y7Yb86e8\&^0e4HY/d5EL;NdD&)G\)-]^L^Mb2P[5DVT
EG)NLTb[0CM[g.ID3gUWg&e6/1RfdPb\O3WQ.>TfMQ-5(LWO2V,J<:F22g0OO#N@
<K/UGON#9WQb/CCVDO>SK_&5a[1=;>AG4U(_RS69edG?Fe,a.#[2XO0XWa9+5_B/
O:3M4<7GIBAdc^[Y)/a8_(Y1L7(9<<1aK:&fMRIK_.N6LL+)&2)RE4fWcf+6F.QI
_;97S8XXg;.5eX+.Y=BZTPESd1eUY:]<J;-_A9Zb,\Y,fSN6/Y2#KGUJ7AY\7U>I
9c/KF<a:5a9T-FWA/99A.e<=P9Ba]WJ=B>P0fW&A^dU@G>Q4[+(UbK21-3X2S^73
&2#[7/G8g(IP.#=.NS&/<(A<J+5S;>gfX(^P2bJB=?81:]8H=BO([5)BBPRNLW0P
,_.<@3,^BD0)E^7=NLaI+9=D#\UafRB7#AE4,Q)/LF\.0=+QWIDL@;1<75E>>W[2
X=3OBBZZ?K@N,&_WF9XdW)+GF332@(N6<ISbSO;0K1>P.;(d\OCEH7MR7DAM3Z)B
#N&6^@&c^@;gI>)P&6HBX\UXSF,HHg6#\D#I)DfLgSP94,E<FN/\Q.E3U[6.c:Kg
Ia&UDVX3#<(;;K]>F2[=C0]P.g5)_ZU4/I\MS.1GN&+,5b?ES5K9dJdZ@JVIHc_Q
Y8-5AMZ0YIA@AJ+68>S;DJVAb6gD=U,Xb4^QSd954HQG549P)0JNZ[J;VXDT6Z7R
MI1Q4S,ZV<agg[<Ig:3A2.c7>7YaZ3M&P_D2bbVf[/C;]8dMG,C+5Ag3e0:3QB38
CEP/-WW[_<NE[RMLfQV0=<\;H16BZ0TH.W3YWEbgT/KDa:V>YED7[4XC./-e&cI6
:)7S_Y[XT&3ILJfOML]Q&K84C/O.,R.<O^9P+^Fe<?GR@90B9e,M[1Y[EO>Sg>^<
bL4SXKC/[,1,]&e2UJ>MHI,1OZHJ-\J1XNU;8HIF,./4J:X(?WDV@UcIKLY.G_f8
L\V80=QR_VU-Q:E[E83RE19N3-[B,eTCb8FG4[ROEcf;??1MWFHE:6fGe)6W=7//
--?3N>R1=\BbZ9[/OA]INT(.A11>V@-.+UE#+53+>@4=Wbg7N5B///6ED^-HK]&P
]<:Y[;M_+dRN:=E7Pf#M+.E#H:KPS=78ge0Cf_VL9@bF1C7<G<\H+0-,29V9cRY@
.f;0&7P2N/C[7[@S)>4PP(ACPWKLeE-]LWYI>QRG,a/D8>:,M(@M,_R>e5P.J4^L
_A:EB+Z@a6X:#4^==K;(S(A3<a@V3>=#b@NBMbGEGGg820.\<aY57gS,7,2[fP7M
H@4B?3&,#0d(E,\)Fe4V(4@/QRE&0;e21@9WfVF>K.TRa6FMbSZdDd8,Vg/4:XVY
D<4/7W,^(_-3Fg<O\Bf[@ADQaP_+&3=QVbTWgX3Db^BO>(OEF78D_A_/\X08eeB.
SR[TJ]UM1^C\WDZ<)KY/5-CZS;Hfa@7,WB_f(fG<H6U\>?VCA>(_67BF.X@]L:bT
WB?N&gP2RE,M)gAYTCMG_)QS\U8NeMDE>ME9P13LGH2c&_MePO4U/R(M0-0KcH]L
CXX(4WO,(QO@1W0a>L8#9f:1.B3F)J_BGIINW^D[NOB\HI5Mg#83[R.&dZY.V##F
FCWT6_]5&Mbb6+1/>;,)E_A6C73<6O/I+9G>Z9IVgY9GHD\JI&:VW0(0\OYN/3a<
7=JX@7)K1g6(R[be[._N=f&C]C&KC3_f-#Xf7T6L8c-NEPY=K5R8N)+@Pf>g1^aI
X4VCgSf0<#D]Q4,KM+G3M\2A03O-F:I.1/K0?-A(+D?]B,)5NH);3,&@Kd,fW--<
IPWM03Y^UG4V=]UYQSa;440/QF3c8T/B-&eD2D408[N,8<AdNa/199P^gX?-V[e_
baZ3J7Lc17@/;>DHC3F+FWd.^,#-g16M3+:e:&CQV9ac)X37^2@6G^]]#UA88Q,C
OA5OaZX39+QP89GL<LcMOGOZZ[.ZA1P0-d4/+XCY)A2H)@Td\JVbMY:D&Ha1:IFD
\<5J]?E9B;\fH8GH8BBFV7<HbdcW;+a(D[BT[E9)Qb6[>3&\P4A7g5R>9/L&-fG.
#&P_CYWcJ<#K<]U(cgW?0QMM[=K\HK)bXgHT#B2Ae^GW6P7V8?bOEcc[I+/_\87U
.gH[#WZKW^>]_EJe0K&\NK&IY1]cPFa=c3P@PVGW+31C6GH=GE/,fL5Ke8#e,ZdJ
7/C[<_(:#5[P[c26F6dgNQ\(U@O>ZK65gTbDUJ[WWNF?g2+?>#5/FQ;B3,:4A>#M
WCb-ZV><Vf:,gQ0AR547:?b51)+,T=?3U.J8e9;5QgTB((M]&>+K9E;Y>5+@^@E>
=[=70d#_YJ8a(O]SPNV\O=WedD&[2A.>/^?X8MJHBA.]IB1b-]D3TS&QJ1?K7^fF
RB27S_1)A.Gb.a-TS<:c)&@)+VRMLa43TQ.\B&Le.9YG2BVNCRB82@2#<?U<E?1E
BL^7]^aeLH\;6R>dP,7/+;:N6_-LXQDR+[)/CC)EVW(+KS+e6/J,aUeVa)C;D<AS
Q9,Sf_gYU\VKT<71Lf6bG&](c2Ig-)(3N=G5,YdOL2AK6#Z(#F_LX4S(-/NaX3L0
CZ;O&#CY3AC670_:==gCLYKR:M2<(GbIaA?F;-Pg/1CG>D_Ie(NO82K5A46Y>:L]
+cfdSTe_c^I^cJN9M&YV/68P<f2^&7HA\4-U8#^#4=fdVTeHGegNE43H51g=F&::
Xf^YO/7MM&A6&>&+B+=WCGAFR@?@_8gK16:O;XMe)?3?FS/S5#dZDT:BgHH3RYVG
01VHd?JE-SZA)(1(f2=cd;@34@8ZG/W&RKHcXED@@:9]0Y06eQVd<a_A8^,K^IX#
J.,a&F2f<;OZLPWTU>X&FCJN\W\7S:+aTC5;=4Z)EI]-[SJPQ6KI-FU4ZY@3,HKY
\DO5V/dHXGK194FV@KWY>9FNHc;+V2EH\4R.B7=b[c[M0GG9NgN0LLPZUbGeE4O^
?McR2O<&(?bUYF2BMd]5Z&>V@QC#gC.2fNT=Q)SU_1.;:g\d)>,H&RGT/921G0>b
PX66HS9Y^/4W^@S(bb,:0fCS1LVL3/\?6ZF#(F(aDV@\1A40c)YMc,QaQKC2_:^\
4.(c<Q0PLQ2bSE5(4[=AVO8>_HFa&)>WAT_[:&PH5EHEI(;&.(1We3_J\U0[KYV1
<Ig]#]EYZ6EHab9ZPL=JQERI3QYX:H,B:cW_,4(JZb1c>-^;:Z87?b]]&QLZa6)8
H>6Gg[4O>=N]_4_G/8DUYS.J7TYKg9:#W(((g)V#R,OZ\#X#G.L+3bD2;-NLSJ<>
SPN1WdBF4eZ;IIY5]<BXG0K<#Y,f=3]BFf5-7Z0M9,M#d9/WH9L]7U#8+EVN09/9
Ed4-f@fGS\:cJRgS.3#8><&FICDA<#OW-A(dB-CS/9)#T.2.-/1Ff37GV1D/8-Y-
aEeD7-3M?NL(ebaNYJ9#_\K_K41)+Lf0CU,V)LDGGf7g[TG5M5HVa;HE?9UM<e>#
&J]_2>D&H@B4J/Y.e(LOYGI)YZ9dcQQU71UHL\SYRY\;MZT;aQ;6FOZ1/<PA287=
AN-9JW;KUO97ZQaSUYK)/EUIE(I7C<_KdC,&./M@FK4O5:V@GVXAQaWSO.e3NLbe
]gdE,3)@(I?C1Zg69f#^1))+&W]QNE?f[VI0FaEK<f3?<=.dL=Q^[1NREa9C55I[
=^KH6Y>)0+?-5U;F9]@GXE?3_V<E[<Kd)\8\BcXTL^<cVfO[0-@@9?L?T7K5?W)4
LU5dCXL4Y[R,G>WESE8S(:5Q5eV_J8LgURVPBZODVWRWVRW6308RL@eEET#T,L/>
WS?3P5Y/1:T?eBe5DYS6;^#[f,>_U3^__V0Z;DYF(R(DZ^>9OYBU)P&?V#fFHYDD
e<H?D5D#]NQ+d)WUMIbSO+Q.SZKS4K\.CKb[C1+ZGXEa7U=H.MPR7+9XDW/\P&G(
.7Xd)IV#)e#;e8),TUC:X78U]WKYcHRI:@a&H=Y0QA^4>g2W4:g=J+]57<g&WKHD
99VR+eA51W0-:DYaGPgF2=1;aNGJF9;SX[01S>97?9V0HCB_7VI>eL.F2?3NT,Fc
#aTFdORHUKZPO(1LA:dNDIXQ+7)\(>LOQ2E>Y^C3.)9-C5J\B-,_&/MK/2YQCHCT
X\V54&VN(NSV=]9P&3PY-ZPgF\/^]U?)d7G1&?d&O3PR53:W=]:g#(Q3AF?F##dL
c/E3LSVW9dS@JH/=YRB_OB9GB15H+7QCLALRP0Ie7fP,H3f1dJ>f=1W\.(bKX55T
A;Pf,V0T_g1ONN[8LCI2bP-Q=#a4Y1]19.?KX:bRW#NT91XR>EWF[,1@g.c)c&@.
0PA9AVW5\c=U<eX6DbbEb>D9Fge4=Y):ScY-PR/?II@SS>LR/0PCc.Hb>>W(,+EL
^+e4]8Y>J.UO?RTK)4U6cFC7FDY&ATO)[5Q\\/5[^(G1#cJY)WL<&DEGg+H4cM-3
=f3#deXa/Xe0)3G87.74a4\Mg6DTW^BCEDZ(?_Xf[(-]DT,F^8(:6Zg,4]0(<7@V
;J&KZ0(8XCeMUI(QUFFQ@LgPUe6Je9T,Q1_a9R_A)I[#4f-RD.Y86M^eM,;=R4b8
XP<\OeQb7Y\U401EC4/.6#O5+f&]-f?B:LM,g82@]VE;+.41+F50U_\3A54GgU5A
]F3cc\_)BDYCL2f[7.&EWI:,BWZRY3=.[-FfE/MT@5?CTfA60TPE>NGCA^bNceO9
N2.7Q&AK)P<A[YMBB^b+\P415\<^<AI]<H;\BN\#FEY;>#G)A[\4Hf8//B)[U9cP
WZ9f.5/B/&3^6BgZ2IR;O3?<ER2P6YC9=DU5S6(cB-9g:+U+F)VU0a/Uf3.BU6^V
K-BX?S?^K.OGK/.&FY2IU&/C@P@#fdHUbg;II,+O+U@7YeZGc^&AZZ0R6HRO3c@M
:Idc3:f>(RabXX(V+GLD-6L?LOaCM\+TNAI#?II9[2c5--ccM;WOTUO6<INV2V/a
8eFZ^P,.N[)KMA.#>_E^\OFBS>S0T[0gD0600bUE7P3=,EY?)8U<DT+VIcg@A_-0
0GYfX9:IJV:D46,#T22N&MD#ePOC,UZY@=&4W;B4_7g2^;#UJWcQ^@69,9=2DcY(
55(6GL<D/2_Q:ERF2:9cJ0VQ\cWE<C<YNR]SES13X9V5;)0;@E-:ZC7da5<RGb_+
(/(0S+U9,62ZfA4:2+P\f(gP:2.QS)6&^M+JW3SH@N\B(C2B)[=G04C,+3B1AEJg
<YdJ2_(J5f;1(77>SP60P?/<,SBLJCGM@G[#[@@.\Q:,]<DM&JM#1G#4VAg<U3/3
-T-PUQ3;IG2K)?,EFOB5,POZZ<5B.41ZPHR++@&/63=>b1Tc(:[Yc;FAW5:-7T6=
fT3AGMa@[0aNW>Y)5XI0DQ[23++)^)g_Q+Y6.ObeB0ER<cd-.L+]bN>5B:4Q6YMC
H+\&PTD6@V>DMSbN.;NbA(F,YeL;.R08LgE^d+e\IJ>S1G=_T92fUK<7eQ??@&F>
>&R?<QQ>Q@#;fNN)(;Ib9AT(=EA(V]f6R]C1QZ?06_Z6:N60/#7/064La5T#MAdZ
_0>XE#MeS=J(cO+:UB=\&?aZ[,=SDK;cOD8\+eDVQa::9=\=gDG7g3,D8gUA=O1+
<H]8EWe1@]^-b>IUUfE[T4V?U<B69EI?-<O#cY/3E9WV+LU]fP(7/I^9XX2@JF6@
J/392SJZW+4+]2RVYC3KRdF+20ES//D\Ec^<8OeL>#&4P4@aHd0XK8/d,>@BA9,D
KUV2832_>2ffBKNY,S/9/e@8_Y<?V&CY1J.PLOR,-NMJO/)\LLe_^HX^F2\6OC[H
g4;U><C98fK/W]Q&Wbag:GS9B@?ZQ/?&F&;Q#@15e#cPH.8J[,OgQCA\+#.=&HC&
g1-AQS[8\bOd6Y2L/J4bCdC@AQg+\AF:^>Ucb_D&Z6#CcF)^-JXEWQNKQ\B=7,&H
4gAc-WUV>8YWQ2:G<<=;[U=cGQP/FZT(]GKP3.UKU2,=-@>,V\VVZ7_ISdJ>bg..
Zc/-Xa8TGN4KaX;QfSgHWPT8H64-R65<_f-,ZCN>T_@5)]E./D#8DeLSUY&VX:\E
T[,@WKHE7L:X.2_bd11/]RbJd.\C:ZQ+DTBPW#2?A\HL+:(#1QA?[F3ZS[9[Eb>X
fGeVVO;B=JGHZ\^IeNXAaHcN\/[5+P3_\3MN7[]Y/V_9O5;A1:<&@1:Be^DD1J9Q
GND6Qf#3I0IPf>6gXS^;O6@(3J/#VV[BQ8ac:&^aY0AJa1T^A(6+D0.,8@NWBS?6
3UAW><LQ9E32=-Rg=0g5]fL3GAM:O^^AUH^@7B>AJ+\3g.PPISLY.,9I)HF)eBMQ
4A0GR3Fgb)Be/8YL8:5;R_e&1+[@M]\7#-fZ;CFD+BE(U/(e2>3P7.EKQ3OX(M+f
gH)/.>IS0WSB7)9-;1K+f6<[QZH\#dc_,\BHbfQGe:X2VG>eU-@6FD[C]3LD[#MW
-JVfe.;R\FAC(KV:a9>VY1RATA#SLgXOQF;=9.DNIF\7DY8Ug56C4a?Z\0E#O4:1
YEYQ85g<ZJOVPWB5dXGEQQ8UI<F(CWGDEOC&3PcdaL??.R-=N7(BA+9T&BcR@H6S
&=Ve)J>T_1[Z=7#ZKbO9d):IB[Y[?Q:BcP4ZWK9&J7AI:a=U-e_N-AW<(P#:(K?1
\\fNefLU0.]@([TO8f+2XFCf=C&:7V&0FEVcRY+gGIRD.Y[0S4@3_X<&>VT4Gg\^
4U#JgZLAe4aZ[E=Z=89PdJTBRE<:UG.dcPKXgIc->3E-3I)S1=c=#28L&^:c-^I&
F:SX/<2DMR(@L)A#4;(LQ6R]:OE)b/J=H-=-gNPXb.M1H:0-YgF,E6]EA/KP;0I-
bH^=0CBFfHEUO</>+08D@<D.\,(-4\+PT1O4Lg=6G(L[V<6/KgGFIfC#6\dP+1.E
g_IV=OK6_>56Hb7M#X2+-1aDX3\#d;(+Z;Z(-eV001S0CZ2SdO:_[@dd.?Lf)D:B
2JXIB/8YbZJ6;Iec.;2O48DGTa/7W9gKEN=;F7eZL4]PWZ?,=)DQDSD7a]Qe]PEX
JHS/8f[<LXGR@FUX#KFe>a:<^-7OgaaMNH(?R;+Z\,@:/bCNZ]Z)0ZFP1b>08^,2
7B;XOH/]<6RbT\^GFFC?3G__W>eHF-[V]W<Mg[=LRP#VC3Wcf:.+3:)?TD>(e=P-
4DG^a5G0HRCIM_RX,0a]K,=+U8^3g0QR.VG9J,=2X@JG>N@g7U#e34R/eE66a=;A
Y-.T1Y7GL21-2IEAcFWRA+BL6X9F8.b;TC_<>]ET<;1a)-c]-SD8A;T>O(G4c3dA
Bc8IHLI.;Q])H_U7?TV:R00L43D6e_;D;C[\J?fZ?4XI@T^9(-<gRXD0Dcb2e_76
<^RD7XI(ST-XLf9_4gJfPBR=J3U(][GLba4H)bF_.3NV(X,>[f#/UUP#<K,9>4Zc
YfS@?>FA.D2C8E/N<X)Q.TYFJ\;cX]T3<IWI]./M1S6J]Z9=]K),](J=BBX:6JXP
E:JK:F\8cJ@QdZ8<L+a47IL((N\gEIAfb+;+9DJA7WJO6gYJ9VIXcSbT(H9Q7g]_
=aJP,N?L):1:5G5#Rd6,bc6eJ-:N&&PQYXJ1E+S7\g@g1;E.=I+ZNSTHQ9R:a_c5
/Q+fR^^F3Q.WNb7Vd?_JA5K@-L&&((88@9I9MJA+QV(DOa0MRDXEOC\M2MPC77Q]
0A?>G3D-0H;g&G,[Y85;S9/08a3,5]IL31aTO+gA@@cQETD&L(;EKHCJE=EeeceP
W6D/XgdSeE.&)fCH,F6EKB5H&EA/HBO34=S<PX8^7.>#732f1->9+??:AcXC40Z_
I+&5^5=9XXA<=(C1=M1J>2:KL8.[bDL[HI,-6N&[I)H1^U)b(=O@\9Ld>WZ#](Qa
VZBTY9[BgWAF?T+S?B108f>Xe.V?ZL)+G5d83Q(V/6.4^@5]27>Z,2PZMI@dgY&(
-.H,>24=SI5S296UZ6H=RAX=daL2Mb3<L5F=:T@)1;(bME6]<>@PNE5d0RJG3eLJ
I81^e/^ZUg(](U>(K.7:UZDE]>:3(+:[QOD.Rg\M;C7Te<;G[Xc0CG(b/0^LLc+4
f3=.DO33+FV^BXXYOF:&>6B<C,Sa;H3WES_L,NOD7+U+<Q#4DJZacD0M.553V96,
-1<,\g\94AV_f7<-:\SF/>SLNP?<DNH([;-fKJ0a,#/8F3:cVFWUAa2C(L//HACc
gbDW@)5FQeJZ-A.V]84?C?D92?,1bIP9BA5]Q0N)HXK0ZK&EMbB\Q,:7A3UG<H.[
AeRCRc[=9+We2c^/VF+4Md^(^.1M\J9(gSKd4GH5A&.YD)\><fUH6d\L:Z1C\W2W
^KOER9]J_ZJGDRH@U?#GH^Td_,/1GgE3LKXMJCe1d(^3/1VQUS(W.5\W@gXMbJ0Q
[B^aLIS7ID1GH@N[[X[IPb(g2a#]U(G.]VE(eOJ#9JHc,eC.Rg0?g(YF+Ocf@\Kd
[)(gYIK=6SD(_R/G<OO_#HD[+FRUXF3&8)>,Y=4Q0:^K0#6M9VQ[^Yb0>7C>b>7N
G4^I.4f=BbcLJc,CGgETDPEc8cB/R)6fQ_U=@ZCTEQS,Df&IRd&5]61E[4XSFb:\
PV<J@N/_#:ZJ+OcF^):XIX0-A?1b4AAK(-E3M(6b6TT&E1@GfP=DBO@]GdP^fYb#
J5=U@5(LU#aXaCVG&U(TU=\g-KWQ]+,_LWRb7U=WA=]5<<TZaV[Qa+QR@6>G4C8K
.?R<\O7S<;@;0d&a9b0ZKGAIXG7^KAA.c\S]KO^&P3Z\;X>;N;X8S,A0=&OQR)\O
<eG6W4\aNGc4G2c2=4##6\#@#PEcIbgR2,VZ0]O>HN&JCGS[+bE_/57\ZCQAd.a3
1bXP16L7HK#b;HaG2[RMA&,QL,WH0A/c00#]^]dN8OE.K8Q=BVAC+2324Sg@PVdH
K@YLMVA-OWP\:XVK13#J4,::YPB&O&bMQ25#6K?<&R?AK&&[P/9U2OEDL,5HGDAF
BNgSKUe#6A1NMU8J27]GJ0dW^@e8/N[V^ZS5CD:/D<RP&EIc/W[+TRJ?KX#aGF;_
<6c>)-K]CF11W60TR;\UF2&HO=;OV8.CJFe;@T]VBD))A=?U=8_@f50M]dL#b=:S
DeU0Q[EMbG8cB7>UA&A:=2^gRAR3c:D3-?Q<A3MD3dEb9Z1:9+T<OE6Y-UYfeR\0
>6;?HD@T0gceSS@6<&Y7,cSAW[.1M_KVE&.=KKE-\bVBIT2:.XLac?AETG=4NQ5:
)((<9)7W^^PY1f>Wd@eLL463aAQ/MM0Q28dQ79XP(Wab19=551DIFP1ETS-A82K@
J&96J]RLI<>dbN?0#WA_eI:^#L\JbA_4&_,FDG_F\g9<HS?c-HJ8bEX+fc.[XCFD
J^A]4YR<c?Q)SJWLeVBde(LGMg:6?Ka1C)>)U]8]KFf0]NgMQc@_UO?#;ZD,FE^]
5R_40IOd-f0XaOL#)63)e+:\OCQZT39R7-@(]N&Na@3\M@A.(EfSZfeN[c^(MeZ8
XcA4_N8TCb2[^;47);be6X5^cUPG]gZLOfdT9+9B1LcZP3B=X#<;&B&eI6Ec;Z-,
4Lfe7GCF5W4:M@H=?OgG-&+:N\Y)g7>.1.eX\+WIK?K4+Z+AS44D@Xa0b-BNQHZP
a6]?Q+[=_U8J/aZUcY#d#U1Y@fbE@>P4=HLR:P8/LbK,7_Y[@=3QTHHQ2:HNc:+f
?X<_VdOF3,db6:fSGJTYS]LA7[03)<0\6?23PC-J(VJ&?DePULH?+,[O8e/3e2#P
-DMJf1\S7NIC\9HfW(BN2LV(;U)FDU4R9701e(CYC6g8<X.>JI&J,fRJ1).S-^a0
//BD_gH6(\;YC[2;=5LW,:L80[b(>5DAU@b@/YIY8g[.KCH=Uc[#A0LF-C=ZDTU<
B48A[F@A^Pa_<[HO#f0Q_Mc?BJEWQ(DaJT51BbC\O;ffgIe:EUgM]6g\5^65]-J#
7BO40J(]VaXD[Me;+6dC@O3b]WW+N:EFFVK0Y_.C/0A8f24PU:gFLF8)Z344AG1=
gW73T0]ZNC[Ce@^Z&C12f_],@\Pc24H67<I7[IZ[I1690F<VQ/\ePaU4gSS.6BHA
W_8eNN&;5K#?U8J?0Va[]M>d8[;X4[89aCOF;F^OfPI0;R-&TSP6fRagRc&TMb#K
[=McM0?(0-]We_E8YW\^)M;W,&[^6C/,/f0+.#30YW=W1DO6MY/cPX1\M3,7P5;5
U95_f/FCg[68[_-YG)^5B;2=<?;;3NT2HB6,9dF3U=6CA..aKJ#cgY6a6.Gc5.ZE
8-<f3\VF/6cJd3gY^T5g>5B.0[4\a]=/)FfE0>&65MMHCH@0NcJFJ;2MS#^S45MW
c:JIH7,3WNDXJ&>T&2V<0[_-P8#DKYK_Y/99aF7gX#4JMHd?<33E^K3E0E2>\Ud]
Oc[M-BREUf4ERE>BaJ3<I/_.QE[;We9QI25eAe&O<F=gd1TLeXe00UPK1:g=_+gU
R8W3c,8bV&ICVSV54XU,f/)8b.V#-4>I8a7CaK@e7fY6/=5)HYY4/^f9AYG.#U;O
QT45\d]PV-H]3W/#K97#Y.a#EGHaW#>#6?.+@Y=_0<H-5dL2<1&RO>E-Dd(VIRMd
&IIRB&U>2EHJe/MLB>/,&d^K3[0f/,5a:D@gT@)24MCI#D<G?,6/\8<ND2@4=[K4
O[U1D(>J3TfY+14&+ED(EOTa)L:;&[UAe\V+Y-LbTZH2.\-=Z=?:/NeBO\+/Q7A-
6U+#78[W7S=A@FI^NM/U.AMb.X^3_JQZ+H,g0_<Q?C)/^>P(:?SMRQH^M3H>#1=X
-.CAEY^OY,EeGL^La>YMaW;..^-Y=/IW:[RMO20Vb<Y#3cc;I<QZRC>>(#f+a6@4
2b9>?gVg,/.@A2@WNPQ5X(P,82fP+TWR:40-_cd;@C75gFVX/EL0>O\HgIcFKWYK
)SIC^24VFI@R#M:d]3K+89bAJ<ZQE):&EdKL;cVGgY6@]/Ee;F=;.&cX8+AZ:K./
B;XAfL(AVA(EQB)_aP>b?dW=8VB)aQ2Z8ZV6dDAS.J3(J[ZQINOdT9g9HU\8ABPe
ONDa3;Z:d95<E(27a=\RAc(#aU=UE#a;A>VYHG9N+GXg<YX&d>cKVWKYB@30>Y]f
T9.EA7J.QE+7;@O]0)A;&E_@bA/6XNG6b_(W7LIf_0gL5OD[NGUTQT8VbbSJcY06
-OBBH+egMBJ-Lc79Ma5YVK[\WD-WH</?;L#+YU;^T((LT_K3P=5CU,B./CN?^^M\
JfbM/+<X1S1_A5_>TMI9=6S6Rd&XIQRGWOK,./T3^AbbSX?Q(&e1LMg650E>V&P3
CUNS<bATP8O82[bKY)LIaWIKBFW8RW;</M+I+ceK1Qe)?XO318P8TS=ZZ+fWN3/P
6\\B[KJJFYIa5Z_D)KfW(JU9Y10LLLPQEfSH&S3R+GbK>&#[480gbAHJ:f/^)?BP
3H34#F8W&[,>e2f:40Md#SI(P=QDQAW;:QN39AR\fHC;A#M#4gHD_XBdG0U4CGg@
=PP)cg#bE#Sg3F.BFJIFIQFg=9b#(=)QddcRgXFbV?FR0f=[8fJ<e.9g1g>.I3[\
X?6RL?U65]:#EM??d@0RS9Z]KVASAEf1&/a48;UZfO9&]D_H(YSBf4HOD1R(^6CE
-;=#?GM6X:@AM63ZHO,6g;,XS)L>E>a7JU\bUFYP#4JHL&WFM1,9;J-@5X<ceSLP
RcX(+TETP^b_;62cJeJK28/4CMf,7bQ;VM-]EU,G_C:(ND+aQM&TV4ddJ=(4b2g@
3RPS^]QbN>&IcHcE=67Qa&0+(eS[??+O#ERH@EO&AW50b#HXVH:&^<ZK\1UXS@^3
c<Je4:cR)_<be+;]HXMdb5QI)>gZU<W[FB4,)XOC@WD&Wbd/?<VDd_:@T[2V-?^2
LPF#2+][+D4e11O51Sc@_TF]?/8#O_OReTca:=NdR)Z7>=VBg->GI^C8W6+3;5&+
eDDHRcE@@dVeM,ZbW/A<&)-ffOL]4.M>]XJ?cH?/)0c#gUF@-Z^,Z2S()9V&VP9g
OE1(YF)0^?Eg#--JQ)M&]#TAYL4OZ4R8U<INfGUX7fHYM^;b3P.V>-NPI)I6>S[:
CT#2,]^Ecf8187BWIGW:8\f4gM=Ce?/;L<f^RDf_7B<+;QXU^MbIA:SV42O0T78,
I1aS:_[15]f0PB?f3A4=JNAUL7GM(&gJ/0dVQ^4[P-G0C;I2D:[MDb1MAMB#M3)/
SX2ZRYXY2DD_cE8FDQ,]?)->GRSM3TQ[[OW)5EHNYB<Yf6EV&<5?[]^0V<Z)NC)g
<BZ-RY#>JOURf5c2bSDa\;(QW\?d=XP)AG?Nb6Lg,14:4,\\_IK78aQ0NSSPg3E#
48#b-\FISM6PB]JD=OEYZCE<P?VA1@G>]B)XSJED\]FfN>M1^A;YTT:QCB_E&VQS
AKF.WT:DQ+K^da#3N1U5GY1\e+6JVWe\-Q2WJH;=V9CEJ9XAaP8)H+&.6,,>:[BM
^?=?7R#(WNe.JFC26BYT;D6];PN/3Q<0,4YKaI&/#YZ5)5a9AYGT)ade2;B)1KI0
OL-8A_9?_1N\H73JF-Ie+ZaK6R7cg04G0MfI/6>e@-=\QH.]3W=/4;+-1GKbP[f1
Pa8FIZR;3KBXcZ^]MBffK<dMcD0:O5XY3N3OSK0VNR\f_F6O10C&ZK:W]G=1/=e@
_NR0X.JF)c)&GKf=+8P46MaM,V/>9dQ4CZ,J.gTN&[=A.S./6Jbf-6:b^D2(R5MS
OAN6+C&&7cDJOb3CY\:FE#=Cd1:LdXX\LM&83A0>B;T81D0Y.@--63N=YdLRMI^c
(Q)16H=.94K;6J8K(Y&X,/gF.C/_;52=JMNQJgV(PPbGP?WG9Af<IJ>37H^+>WX;
dKN(FdGN:^@4D-+I])eQCf<3UCf\NXYFd,Q:d-V94@L6C&S;RMK[c?9LO7Q=1=HU
R1FMMeU>:fVYG4HgO1(CaaG6A&F3^(P9&6K5f6:-J8B4(40QH7SVa]Z1UV]\I@>>
VF>MWeRG9g<=R0a@E9/<V1X?2aO@.H.JKeF,N0P]5X</#-G@Y?Za9)CY6+AC4A7[
:AV.]Q7KT@QC7.NP;edRfQ3(&V7(eT:W8VJ<[W4e^@-M3D2HO#cAg#=+Y:V?A(cH
g1d&IX)+53[-=#C:K9(>7=VL)I>-T<D]9&[]M\CYRK;-IBLX]gB6JB#9)UI6/;WL
W_<V;YZ?S0faE)^?bDQ4.Y]G9HOdPEVH/P9WW4127-5:bcY,JTE8D83I4K+7ROG7
U&P75Ee)[N(gD>-.Fb;956-L5a)T3]_/;3V1AeB#,J<KVM(W0T8KJG-S2&SEeOg/
Xg++,0O7#C>dA955834&&D&H582DJDTG)MBQY]+#;gQ7A\:(V:S40BH)(IKdd.KO
L#3G_6O;+_^7WR);(2g__O1J/#U7?dDS@8M+9^@4GLA32D@Vd=a8a0^E<4JTFQcg
O&H\\A9[[e>FH2IM3J#SDG7A76&@YMe.LHfTPc\I.KcY\LP=VFJ6,SA#1b)0>[@@
NL=fV(Y=^Nd&C)#b(095YF7f[NFcI?g_[ZPHfXCCgO;BcI,5ZG7.61MEWWF]dUQV
a^+A3WN;+QafHePPSY5a2^TbdTebg=Z)d;=fDf/UWc,;CPOR_Y@DZ<XKN[,dfB#S
)^dQ7WEHVPNI<(2)(]0ZB_ffXXR;?JNLT:gYIX&U_?KJGV?&.5G-PG;)^JNG4&f:
KCQ;=3-]&Q;1I#SO+Se<Ke?5I-aPPHZE=2d]1LXQ5^\@=:#AJVB#.>.,;MWI(aS_
Be.W:>^E=L2(Lb(a9^-+81-O<QKPaB3a#+.cKeDAC?3US2F3E/4:LNCAH3(&gJ=_
<bEcGY+g7/WH;GZ&@0/W_8WH5b\Z:182?9B\AN8)bQ+S@e-Z\1ANYR?-LMK#1c.4
6O2eUe][F#JgDB9e(1S:<EB1_(3HaJ&N#1B8Oe7+-VSW]dX.WN,/(QfNg)Z<B>RZ
/404(K:S?+IU&:+FO<BK[N/7(K>9]KY)eT8)HSOCA6dJd6.^^C8-C/eWG4J\JXL/
NCaD=BV3P)1<5VE+C@&9_bOUC\+<YYZ<2AH_@WcK>>OX7R1GQ1W1GaA<#7/^0GJX
c[F8]:]LU,<ZD9GgdOVRJB&3NGCUP1H</=XbO(EKAGQ9BN)\1_BSeS3.R15[K>[,
18XbXNH+dB0;;Nc&d123)5^Z.d8Q#V3eK.OZK30^HTPJcEb64eX/ZNWd/A5Bc>0J
;Z:2YJ#<_<LADQ^;>E2fY\YXQ05FO=GJI<WQ8JN4OW4>NN-H#E+ABQIc?EFFO@KJ
LSF4,7RW>M3:<Q91^K8=WBMfP8L(?CK^[WMaP=K5SMY?cH<90&<GD2aUgNT;1b))
3;=BU#]DXXVa@5P>:E6&:GA5&d@VW4V<8JD\=6C+N^[fQ^?=U+/QU,QCK,#3RbAg
P/N62e8A6^2@7fBa4+5^S5N\2W]a?PH>\)E+&X<K6S,,P@EbG25f2;Z44F(HSBMK
R97UPNSB7^)39H2\3;(HOICO;LNQ4T<Y?4KUN?;X+708VZ7.\N8#[PLI5CKH;#<V
[OZXe1&W3X]Ve:Q&C&/V,dGf&f6J/5fKK1f]2de<WVG\gV+]e;W^V(g=b0(,P;Fd
ETM/I:/ND]bEb:,S:II6Y9e+TH8BF@2[V5H5\8Xa_\.8BH=&AU(0J2e^FSeJYMBb
D?:O0P/Gc96^4GS]&a4df]-K@^b/E;6#)/U,#\)8-)<,S(4)G^9><\d-_&e15T^)
[<;&:4XH;-/Qc7MGKfV?Q)AUP]/^d(e-FY0N5J&M_F5/5NCYM3gQ#f+J3VFJ<7?W
a4#c3/WG2a:a<R-[\4JF-fC28<Y8&5GR]aF7+\[eIDTa[1AXP6U-eJJ(>^FI_>cM
#R+:>#WL@a((=0QFdcWNR0Sb2Zf_F1<:N70Gg)&c><0(_cB92N8C4E3/]UbF/>F1
>;HT2<4aQZ?cQ[:Q4f)bSIT(>Vgf92H8T0Rg+/PaWTc-Ad1b3cC2750&MV:MO8Z7
K5g1_bIX_Y1,c&7FY?6+;R+7d2.J5NfW(8<cWgG=ZeHZg</T^7UQ8^I=)NA4RD0-
\OKadLe4a2@2DIQ3be-]/-(]3.X)8YSRb?0JQYK+e&[J@),GO-2>Z-T3@1((Bf).
-:cWP2bEA-)B&U^9e6JH==&^0\+/3Z]AN4&@P1=<=[d2PfEVHG?,LRTZY;<7#=^P
AZA9Aa+dF3bGN+P>]2<J00@T7S.&&#+2DT_AGb@R7GV2,HP1-)?a<LZ^@6<>KV0N
=8gKALQaKK/#5(CH?0?1-GRO3]-YYDN._+K6?b.H7A(1e:.^PecS9YBF>RVUgT;B
@YBWBIOV-]Z.Qc>(7^)99EEb13BGGeaAGWLg:N]Y/CL1.3Rf<N(Oc(FRWQ8+3O\Q
CU-W\;U]N#8WaXENd]?gXd1VE.GEHUO2P28H=S<+a(g.d)SS&0c^]JSD2_\3HC?E
DgF<Ae=+?SC==\e7MKSUN<N1B@CR2ed,Z,K3b0K&F6gPX[AFYW/f]b:0@2+?4Pb8
MI8M+a-[@ABaa^SS)@UI/UAHOWW6N(#D?)N1#8e?+d6T@;<UTXeN+@^#bOAOEaLT
b,S#@<G4F?ZX/TS2HV]U4-e8NC/WE.C>I:Z;K.8-DF->3QRf@QgCQ:-Q,bB3e^(2
_cI+./HMf@5,>L)\YB,_#\6>cS=(^B.QH#Y(=;?:X[+[GB1&d:S.-bM,R(N;OGXe
,M7g)gP+fFYK_9VfQGZ=J#YY.&Rf1D^M?P6f#.-IHK[&RP^:7.[//1KcWZ[,7B5D
Z]FF]:TUHU+CNT.XP4LR+6F0+N(?bbB<I6KJP,R6HD(XI^S)VAP4\<c+00P-CM-,
+(;?Ee[@1HUB(+XCVC@HeDZ4MVD23+5>,WI[+SB=(R3G=N)[aE>/dTX7C[2f(+PA
fF5L0C7P>V(<ECdTE07?B\4,23C2\E)dA&Q,]0TD&R1V)I0M<Y^fQL20gD+OKU#K
U,@^EZ(1<[3DRA;F,SO5Z8@P4;.H;d-J5X+(T&N3T<=Y7/G6PaWfFb15EKJ@L>4_
U5<gT<N7gP66/fC&O#:Q468AH^),Y1C>C=(JZa5/P_O4.;Y<)RN\1]S9dD63K7W&
EJZR23_JFf#;):Q084EEY(]#IUT?_[X2/=Y\8G&gN;bIZ3?IAcI)WY0a+aZ^.D=P
cV=TFZ2dAVQMe+Ic2FQ5IcENKW:fZ-.;2G8)c8;/;@a4]XFUT<YSc2/5TWgTUHRZ
7VZ6L#CG5M(N8EJ7=bce#A\;2_-7gY]>g#ZE;S>O_:^1;-;MfH+_;ePe8ZLaML8W
4^K+EMG[60g\A[?.gH7eJJ6eQS&-g=e\]@Ma)<ZNU#(B[8YU440=18-K4TIe/DA9
>ea]LHRCf=<CV#&EHP_]6-#GQ^ZgLPU:.1?1M/TBL84MIf6D5d1@ZC#-L,1Za7<:
VQUCNX+KFUY@-H7K0^BK[[a;ESOd02RK,1>^,WK+RRGUP]G7gLGUQ)A-&9U0>S+8
X7#@_1X\@9g4LU9QYRQW=>8K0W^7SSV^DD[]D1,AG=LSg:U0T^Q[W^NTDa7P@gY2
G6<<21PIAA5(3Z-PV?.36Cc&3.X-:@0/V4Ie?1EXaF:W@>dg#>FF9A[_\aVX_-?0
D/9IPF?6+()d^01?0,PT:TTb2Q)-WOHfFgAPE?d9AZ.DEC3?I].4?@7H-SA3PI3?
4RYgXH+Z-R#2QJA[.:DdeVVRJdUQ<#X,D&J->(-:&G@8/QdBBQgUO^2(AfDP(72(
_P@0Lc0/ITeUS=&I_,TZbH3d+.[ZA2UV><RO=GB+KcdT72Y)T7M2.#]0]1_48)TF
.A;7DT@E;dSL#d=.IXc,a&,1DeM/0:fdAKKL-cFCR\DYSUe1e4;16_VGQUE?Ec=W
B?B(a+SHY4:X7a9MJ2&Zc.F\G/<I,?4,5[3S4V:dN,)Yf6gcdEI:CQY;GX]X\Ld6
N4\-D=W4J]c@6P5b:>],YMb73=><Xa&;aC<7:[@O/CI-/[2G.Lg\>[968c4]3Q0C
3)7?&e<&<^59M1bbK9QZU-3bL)eU37D66:._UVVaX9K(&=E_-=O7IM2I<&M26Md)
GKaQac39C_2&LD6+6#We&UO1g?b/,bSYUTA4F?XY\=f6#SeI]ePJNVKb-TcM\-SN
^M.?Q7>=(<e^6V/F7I&^<^8M;27?3]dI#&ED-#TR3CW)#dcb.O/<:T,5/UNSOJg^
P/GD2H)F+eN6W7RCX3/S#Q1(#N<d+gJNgBa;_g\Cg2>O#,1,d46JR50Z64FIbbPc
FJaU<(=g6Hc;Z2#E2@^)03((F23;gdZ7O;N:TXKZfD_[9S^CB=?1A4)RH=CNMG7&
<77>G59=deUKc7IdKSZ&d7/C(<4#3gCV]L&HZe.1b;>T>X(+Y5&\7Rg1WJ7/(9\H
_0B#P+X:>QH7Y,^QW.9^,3].624TCP,&U+O0aY79CHLCaWH:ZN,fJ8+g+Y\LO4:,
VTHe7J>QVe;f,(=#>;3PSHI7cX7G1>_+0+e8ETESMB#c@T=&R:RY(ALV()X,4PM0
[Uc+WMgP=:+&bH:4NE-F#5WQ/@FOK>P0?540AbFBb\d?93U49R8Sa7(0&5T.MJZ=
fA4&?YFfKg+d57LEH,J\=L-SZd_=)Q3.A[cSW/M0YUC#.gC49TP0T1[dSa#:(@-D
d[P-R1D(+N@5755GbffH,f#3]4;F[6;>9AJE:]a1X,]fD?P&2]/I.F^+gf;NXCH\
QD,#<C.K/.23CP2U.cD2]TI_+ObE6(C,VL0gLTf7.[?GXHKK80Y+F+K)>WR(D_(B
D5:a4W5/A)ag9-@)E(b(@c=&\82PdG9[0)5a9GJ;b3aZa;6-L1H;1SRD:FC^U2,N
d=(QX5K?39#-QC/1,\1NL6_DgO^F;b1#=B5a6dK/,UC,KY;HK+Z__J#94bI7)T,T
+I+5F,0PEa+,+/?c4=VaCIPU/HLLU(?)f[@)bYHaH[AQU01<.M]<B?B/:Z>315_f
C;Q2FIJBS<,8a_I:T[eJT11FM###?>0:H<-]f/C<F\H4.9Z]W,880-/QKWS)M]VO
:F[U\F;4WbK^6^XZGCC7WF_JKT.IN3ZaD<gaK6J0QO^B.)LB[M[MT0@H]M#b4OHY
_?B/P9Q9V6eG(9+OGYU^36:7Zf^]VF+5G->)G,PP#+IPF8U=<fWOKb:fWJL.^XQ[
ea4<\Rd^+cSe)3H0AP5(_(Qf&#QK.G7\LT<C_1=3?:BL;/1f-ITURW2?Lba@\\]X
YgL&&^c@JH3^E+W_2?UBQ))NM0a2N.?6)H9.L#(7QO^GQ>J=<W,-UJF>._6Ce1;M
HNKab-C[bBMTe[]&D7.?8?c:70\V_PJ<A^7Bc?4EB@T[-\eXB9\,V\NT4=1:+F2>
>\9&c\RB&\MPf.B-)f:gHMWg=UgJ-eeMc^eHJdb))E@E1<P,CXQ=#]E_aIUU>C-8
U:_C&IC7A,1(d4VR4R2P5.X:VEPcWQ_aCIA2N5<_ZP5_B#Z61;O&M4&AZT9K^e][
DeM7)-MLBSPWYGVB4C77Z@R=)(fD7L&\@[X=&8]4SO74QX4P+2^-2>;gOKKFIfR[
\JKagE716eU>;8-@ZDN_:_IagS#Q2cHJH5eWT88LK2_A>I5debWS5;\I0ffc9/#0
.b00#@R_R&1V8X,PH:>E62:X((,_Z\+?Tf2?eH&?]2#a0V,#Xa[G1VO-D9G<JN@/
e;D.K6WM^.VAdc:J3EP+J6]#f:EHILZgY@71gEAC\@<NJO&bAD>I-]0RIfS5(2(0
X9ZQ.O9Z]W7VX2YM&N\\?dV,WNBILTK?R?EF\^Fc?)\,Tb;bX.BO4L+PH9Re-W0a
UX0(AUYYGYg639=^Z)26<=9-d(F(8-LYFQ/>3Jd[/,.d=&V7P[+NL;>gHG(0\&JJ
TW3gc7T(HVZZ<d,Y7#9c:a,7I1<UH290#:X=?3dcV@9\GXFJ(E.Fe;fANMOc8/8K
Y^;^PG?(YQH@+=&8&/72(@R1;^FK26Z1QeCb76R8&WNEa#Z&98[;X>a_6<+U[/H6
g4I-63F(b12.^7OK>.?Y+(=S8?/4gSPQ8?3ggCN\.1b+J=ZS75:3B1MZ3b<cFcYU
.=<XYEa8JG0\976X2TKO_C,O0.O5-4fC+]/,?PC:8_\EW\\A03LZJDD_A&8]X8DA
)6U7W9A\[/b,:+.Sc5TXHY[+P-TW\bf1Mf,48BWV5GeVZ>T0K77JC2JMTeCAA@_2
[]6]4Yf6Z/<),MX]_g&CH(J?W-@?:2AP)bVI@8#I]fR9DKe^VWcQY[cE[2M37bXY
XHV)JL-VI#>HP47M1O\#X1QVAVL\[@]D0<JHG\0c@356?@H._22X;G4F)DAO5VTB
-Td-3YE:>Z,P[=G=1V2VR[?Abe<S(861DgGSgB7bSf+Bd7UAQ(W0+;=X#Q)N+P&<
VbOc1(11NNT(a1gH[F9)Q53ZD6Og-<MY6,DBN\:.B)(JU.;/FSV2c&R,7>@/8>0d
@FX24:UDP0YYPb3]f]QM3S>dG==NUE59:+VB?Q3Jf)]@c\JL&E>)BR23GH2^I[51
N9^S0-]A[YK?JI&^U0[eD6?acDGY\?A4,)3UW@\H<.A>F@U#3^Wadc2CdMV+2W,\
O@.bdQH[FZgE8d6XE9BEXQ5gTCaC/b5?SR+7=0X=944d(@.Q]bTc:T05gLBE]AR5
2VB<AOLgB^]bS?KT35e-[</K;PJQ;]2O:1aTFPP3<S0E#d3P@_be>HW2,L]YX;L0
1YINZgMV6_J#M>77ZB1EP<R21FcSSJEOXW=2L3a#<,[b(DRL2^0Ae4CNIP42035a
2cF;?S28&@/?,fGE_=ZD]MOC(GFQC,<U[Z8@@X/O>HG7=g^RUfQXJS[Oa6(dSV(G
RU_UIW^^]R^1>@&UQFNW5/E\L(GaFgYZ(]+CefSV[R/XKMJgE6F_&01O/TW2#dY<
FbL&,GA@83(IJa#^d\?=)^I\VgS0X1/(_M[>dT#Z/[/0dQC(6:Ff-JaY2XFV1TXZ
\JZO&e+cMH^AcKOA[(8#.]L@^dK=K^,N5YH\G27NEFNSG?TH6FX]G@<.(FHTaKBV
.ZW1G-/1a;KBVV=?_XT9^B\SH\6<<EDU,e6U,1>C17R/ePV:>6cZU]GR/H)be[)I
>gI\F#3AA\X\XIK:g@,=cKACSBf.TA^MgMXU/XOV+O5)0Pa(@VF0U.EAYd0+8\XQ
6JfV//L<bCe@QS>a6_Fb(K2TH3\.)RSWY&>(5)T.^IBEZBY2HV<+(:715V)Q005d
FVZ2P,]QNE3KBI17agfV#@VI&R9f3D@C/5a7]J4S.]#)fRG&F@b[(WYU4EU\QJ3Y
]B?L9[+,gX;F,]WL]EJfbK&cA;K(YQ7R2c^Wd3B8Y5S@Q<T)6ee?Dc#Ed9;D4\_R
/,RS_UB]).M<@0>2f>B6;eZ+/)ES#KU13JVSF;@3RN=J2+La1CeF3aIA1;.XHZf:
T9f_9&8Fc,OCLTL3\R.SPX//@+3cRb1J]8RGD=LN\Lb#0SWDWSf^\T2Obf6H)<:<
]PN8N<UTc,\P>1_g5T:gCFZHf.P(bW+YDRe=AbaVWNd1&Z9B0XUaUPK3<T-ffG0L
H^_5FMC+VRK/(TPTe,2).):WBb1\_@RX:e#IUPLK5KHeUXEg71@3+Rd31GR2FUIg
9d=Ta+Ed>PQ^eCcSRGT5:6)U0<EDRI,X#,Xa7UAg^R73Bdc#:?R0f\06,F98DEP.
A;VL;D89)fdHL16Y&1L^@ZB3fQQSF.,S=a;_aHAU,VH#WS-D71=A21M=@C?Z4JSY
.IJA^H>#UB:&SbPWa9\\,@.8,TD0()LML7XDZ;cNWe3F@U4g&JdaX]1S-ZZ&a\8F
JEZ.eDDXRN280,bK.[?f-U?B<)3&MXf.UKYT?A\>)=H\G2<f->\751<)d)F>SW^?
7^[Q[&;-<;a9,N@L,IBeC\0,CO.2)I_B-1aGKE)9S,X)1a0T4@9B)73EB50&9[J8
>_(7^)CY&5@2:R6-/47NLZ#>\&?X8@W4E0dDb=fAf1gd?[Vd25\HV9.[e?X+J;]F
:5<,e?;dF^5=&-K0-DZMdD>Fg5T8eZ5QNCNG[c+Q9g\3Lg0=^@#5F#&18@eJS\JI
UGI\K6QD?HB7FVFBa2f(B>,?O-RKD5/6L,0PXVX=;79Uae6T3]e>)+^Q7-2=dbdG
E)U\+;DYZ8,G4NV#\fd6O9/CVbG(.](YO@Q:c(VSV/RYHc=IS@NQSXI;/6:@f<Ub
XL7QR1Kca]?BZIV@c_0_U1S];_-WOU<+SEd@=QbIF82XFR[^[ZU:P#?eX:QZD@b#
Se7C+T2:P5VWIW+NMES7\12_d;X,S,AbZ-<gRGaZ,SF[de[V0g+B2Zf+FW9Qa+f2
U^F)\]-8==Y,ZAB(I.+\#2cObC+]08/@A6@\XFaFf)[#S<MU>^&<?.D:,Q3_\f+R
8)U(gfEe]/N@A;I6Q]&R3WaY:g:WGQcVQ@]K0R0^F[_\f<V,;RNLOB]P@f(7dSRC
5/K\__b&MC3FP>BGUVSTG115<I5fF3J>cY[+OaO91Z2;4MG.Q:>C<_X0U)\&1GAJ
]Z[G&SCF)Q\\W>0NObSc)\@Y?e;aD_6LcKX&a5W[ZIL&GI+@6.aL^6c,)W,+fd<.
1QMTMDE#B:(ITIT3KAQO[PK1gaCJR&g;;MI0\Q>,WgYR1VAf#9O2?3>(,VE@g:f5
FRPPU?eD=VIBaALFJQS#>EEZc:Q2;_G^6)7V3X-WfUZe<IWGX=J/=[9gG7L1R2#b
HAeY:_EC/>6dg-4A[)]3,GR-4L)?DSUC0O\+RYAXDVDEWCZG(_1=fP&VVZ3c/>&d
ITc<M,E?O:JHb_f=P:J_G>:dH=NL,7;\XATM+L;cPc7<T_KdS[WH?.^:AVK_XEKM
)WaD^]2[807\X[SeeD4E/()e2SZ]HeL2^b_3JCC=S?D<TZ[DV,3XZSC.?IE,>2(+
)#9U-3/MIPV77Ye2c;<T4R7aYUU[1QE,8EeK1;C6V/JW+&-Z47YFf[4c7A6ZAPO.
VI?a?QRX[M-d/fXA7P7J+K\aaS1Df,Y/IB;62Ic-EBWC]?Qd_].bcVTT\Pe,.K-g
-DO9N^EB]75JJF>M3DPPfLb^/>.\W;I..(=T,TAFW_3<R==0MaPgCPKB[:JUC3(H
d9_?\0@):D<[@(eSN?2G/D2IEc-&,HW^bR#)A1]OAW_-,[G<]8dWHFJ:T21#8P/.
:gf^R_E_cT/eS8RE-YN\g7gSM0@ZKA/<YH-?;GH<_[Z3=BHI6Kdfdf\9KK;2L75P
/[>Pc];I-GZ;7ccgM;B?7-bXa4Z4?2T<,;LIXR+<K]([U@58P;.[76,R)X=a2G\E
:-8a^VO1]1)L(\4Ne^0AI(416W#57fOKd;+3L23]@J2)C)c)Rd:f5V.;b^V/&Z3J
KfP;9JJaCHa:-.Z-P&>Md_6(fC;8D@DC\:.1S\9;GgR>_<CNH.aG-^b=1F5eAI=+
d6cH\Wf][PH?[6d1X<db><9L/5QVS@3KMcZGd^5=4WX4:5:[LFgIgbg(#fdaKXV\
Me#5;a/-JK_gXW-V[@4cH>.\P[M#+N5]D1<GcGM#?WNUJa;-I:=EU;?O69R0?@?)
f@,O=f[;K3(=]ZX)CV,,If1-YT#,[dG6K2AZEZ)Lg&51e=3YQ@dT5Y5f/cU6FW&N
]-J7DA0f7<I&R[TO&ACR2ZT-(T<1BaJg_3N:aW]L]R/O^L)L@IIddP#>6\e)6S+J
XbT\4LLB9@Af3Mg.@fPG:XL;]_#1;\f1X;R8#6T#KZ^R7&3N/5(&Z\R^Y^>3#1V@
+PHYZ>;DPQV\[\0)];;#eK4G6Q1+K1O=?FLCX:bFLLY\J#QMbTe4.#,<LM_-/M2e
7,c@?EWXOM_R4_YZZJR4g.YX/N1ICBdRZZ&QC&/O/@fLOMFd,?fK+Y-M6DX:0P6^
^8Xf\N05^d(.<\^3:.?QF7E@@^V_3R-<1V#3<[YS4HN/d(1YPGd\DO^UB5>O9<@Z
g0H?DbW[fb4)2E<4G7(5:/0-F5KC4,A#ebA@OaHO9V_4<@?.L+\=:fCc2e39]7W.
c_6DSD<VN\EaS&Ng>K(6T_5G3M/[_N]&;.>\cZ5-OaCRW0XeP9S]#Z@)<QWPN)?b
,6#PD^3GeYB,ZH]6XSA+3cL@4gAOG46V_E:;Wab_KE[]6OHG^O==eAeIa.4ME@M9
TNY[D1W_HbBJ1RZJHJP,D(RcYLL=N?(\N&L\38\e];V4P2L\4J8+ZBSfF?W(M>73
BfCWEWU__H=P3?8@@[@GWZLSC5B@_c\)H<X/?PL);N&2XIS?EB8VE:@&&T^D1QT0
:<(1>_bO.L,Q<&Q)17/5Nc=L[092W9ag#/(;a6G:1Q4J2E@3OROB<c7I]55e,W(L
;PO50_AZ0VdeY5^&0_9N=,e^M4(dG;a1C_c<a.^6bE#@S+3T#VJABKcPFS]43G/4
)8+G&DWKS^#Q-;25:VbW4>@ADP2EJ]S,W/-CC0G1M>F)8_39)55F/3;/cNT-gV(P
I>9b0/a(A:QJT]Y@5K0A(bF&MELS#cC3QGQ5;ZPGGF,6QXEE4IN?_3-edJ@\]CbQ
(M-^L4/CY#DM.@Y<)QGD2<6\T:=O5,VM:ZH-<gI^0\VN(?M5c9.R+9(5J&:g805F
:NKOCNU9#gOT31Q:AA[0G7>XJcB.4>U7C8+SN19e_VK@0fb[H^MdVKQOT4U=RJ>Z
Xd<2\7(gVeS?C#G#bD^KT?X/9\;<gWF#]\387OK1E]Ga>TWf,FNS.2/f6^HS-J:N
)=:-<cbC8MCc/H_cZVBGd-H>].0ME5PS>TO]3b?MGV#D\HEb,UB_QA.C\<fSg(AD
>>VF&VJCPS32dc<O+U\Q8>f)_>S0(df\D/,VELdX>bRP:Ee0D7eDcc9ZUFZQ=F+P
E6Kgf?H_UT_eIf62LMA<b;5V4&eXIVMY/=RYbVJVQ@_N,L2:2SAV=^V9+1\@435,
Z,S)+TGQCNV]0+XW_0ENBdUI\,Q&3F7+5VI8FU2GQ_@RM.0X;45fH7N,VO;T<21F
IDURFGSHe&2fEA:8O^&C)Z04Z]c:\1LE?//=ccH1A&M0e7K.M\,2bXBE6S]7B69W
@2fNf0B=Vd&7EJfU:V(RC=\dV/>,]KKH5.M&)==8?E+)HU07EV:P,0N4F<UNAK@E
X.CGFNF>#eD5&]UQbV/e[Z_cRa5L-)<Jfc05<\,a]J]:Wb,Yf_GG9^NJHJMg+OEX
(S]/6]WI(;GNX^dHbJK77S)-ZB4)6;2W;FZ3R9G^)cP<6NG//MA-=(@>K5>?]_LW
K:7A)_C[;C)MZRM9T\C&0,<d?#Z2IAY=:&Ya2>I.d#eGN=eW&e,<6+c<7;WMD2_.
>?g9?B5^MX6NR=VN-d_f8(0-@8W&e>2b^?=.7B@Y<MOW7.+b_),FW1d2E\gc4D9-
B0#-Z24D,aL-UHbP0Y/?8V6>PeCcXTDQ4HKGESfGC#JYH4BBeERdaLBEGB:X5./7
VP6@6d>fH7\@1C)Q9I#aU)3eL9I4=WI4442>==JDF^fe867JU1,:;J3^27aXGG:2
eAI<S^P/(KP982[SDH[PJCT/#HAGWg_1#)7^-M=:AJ;dUbSRMB,WbL@AdAQ7FLP(
A0gGdPO71.LA@5N;34Gd[\)FUOM^&1>S;W2+KXCLV(^cTVCYS+e7(,YJLQA3SY7;
VO<4JgQ.6S.YGV-;<^a11Rg8;NUdT4Y5+Z,XPEL\UT^JI7@eXCQLUMC70A-J<_JF
aPK4WFJF<Z?Y\^]9((Tb7&(e<WIR;T[>A3T2\;ecLBJ=)W@O[P0(7A6CXD+LbG01
Y=@<ZQHQ2.&VgNDdKIIR\H0O5F_Fb9Ld[E^agbFE?LY83S?O_^9/?4.\KZfQ95C@
X=>,@/[A[XNHRd<:PWEI85J)aDILBcHfTdT<d;NAZ_75A=LME5_0cccd4KMQ<U#K
68OEeWHGK]CA0[Qeg[+b4a3_,38CO68^VQ#WQgK64E#:RX:Ib8A@-@A1+ZZI=78:
[2/7BJ84gQ)?WZ1A]#d1T.-(T9e.Y<\__7>[+Z6KC(##fA4d>C@B^#I(R>T?MDY3
Pff:U>IR:VcC>5g_:KX@R..^;CGg>SS81K-J@L[K4JJ0WSZOeFfEDFbg6@UJ,Df-
]+3-QTRcND-5[,XR7J):[g?Mb^BB^KEgb9T2B@e>KJGEJ]AgW(9W]QDSd-3d4:a=
?>N_QW?SG\])GEARCPB/M35YP#Z_T>NaHVUE]L(>NHgWSVNB98O@5KA]CfO[8&C;
G=6<=_^?agDI.O[77E(>U(O,<S#6)T]&dDbY<)O96I_Y02P;1.MWIPDV/U54<]4<
J)[]8FBX<>bWIKb.6(bK0Q@24aWRdFT5[]RA4U<]bH^W@[<eLG2g,ZO/YWEAb,9L
&H4d&dN-HcZY<aU.(=Qd(HXg6Hcg8e^B(^O;@3&C?&B2>\VK]B<[FS>R_)2OW?V<
V7L7e2fd+DD;J2MgBP=(MW;e6QZ.PSTeMFEEQ:9NDg>H-;(]DL/LHc,cU39A[,DU
N:J^W#<>6XL_BQGJ,3G7M?H:#^X4-Bdab(7[=RJK?RWV+e4)/3?^,R;9FG.5F,>f
)>UVJK.SfAP3));KMY-@3MKD9)3;?+<AR23fT66Z37bGYO1dFY/Beb>SM;F&_+cX
d0=C+<@=A:GTP&:^#3PJ]EF9?@\0AER:b08g[1)=V/-IJQa-(GJUe9C__Qba[AGE
gg,C_TJ[g1ME2A4KN7>G,/dYJ/6-JCD@5NEDb?W^1YW1DaV1WII(f[IbP][IFS<;
7gW4Y2\61[BgM0.EWZ=[0+fZ,WGfSC^5?+AKdFFNI938GB>W1PY7=GP77QHHQRB@
ffgA=W[,Y2f=\0CK@X^bEY]:0I6Ne+;EagD+&JMTWbQ(2&)+f_FB:XNU;D2\T_VF
43>K6fP.^33<EYJJOGb@HMHRZd(dYPINRQ2NfaWC&<Pace.\Xe87#<-2IG:U4ME-
U)Q>aaG?(cYeY_IBC+XFNQW8IVc.HKT+?_OWF5\(LAS::87N>F4I^M\Nc92:ZB76
fff8O9,D;=.[E1MJfG]T2eE-]\aG&26cO:.(F-6><31S-)aV9^\gYa/#+>A0+W5@
\H)OH537&SeS9_DAaY;8[b76P<(Pb,R6<JZG-)ge)Pf1EVe7e;#W>D(e,HZ0AG9^
g(R\_f98DO_P&</2c:fE;\Had21Ub<#(IH=9N?CMBdOa4b.1\.><\f(HT/0Sb047
U1UK7P-:;YaMMFJ434SECUcCB3]J(JISYE@TfTb,aC]+BQ8I8@]0B/PQV7MSNWf/
\.IHd2,;)ZQ]-H^P<ON[]_IU#\fNbU=CG.DF0]@M>K6aAU)\9E20ADF.75290CHT
cXSJ2dDLP5Z::gKTQW6^W7gE4][,d4f_3R9NQMW3FW1N8]29:J1ccZ[aSF/_1L-d
a;F.EY;:a@K/+ZeAG0[=6XJV2MO;<X.#?$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_MT25Q_SDR_AC_CONFIGURATION_SV
