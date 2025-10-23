
`ifndef GUARD_SVT_SPI_FLASH_MX25L_PARALLEL_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MX25L_PARALLEL_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Macronix MX25L device family in Parallel mode.
 */
class svt_spi_flash_mx25l_parallel_ac_configuration extends svt_configuration;

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
  real tCH_ns = initial_time;

  /**
   * Minimum Clock Low pulse width duration.
   */ 
  real tCL_ns = initial_time;

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

  /** Calculates Random Timing Parameter value for #hold_assert_to_output_invalid_ns */
  extern virtual function void randomize_hold_assert_to_output_invalid_ns();

  /** Calculates Random Timing Parameter value for #hold_deassert_to_output_valid_ns */
  extern virtual function void randomize_hold_deassert_to_output_valid_ns();

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
  `svt_vmm_data_new(svt_spi_flash_mx25l_parallel_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_mx25l_parallel_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mx25l_parallel_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mx25l_parallel_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_mx25l_parallel_ac_configuration.
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
  `vmm_typename(svt_spi_flash_mx25l_parallel_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mx25l_parallel_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
[>RMCNcP&d2N1-DEOd3)L#HF052<42K[=b2\A^c)&>-]EE:@QGO4+)WI,&ST8&K4
081[D>ZK4TaHA&B#JEXg#Ad4;-,-Y=RT&JN7f5fgC)9OA)64I?dIA^ZbT3:c9\2B
Sb<E_#.]b&Cb]_:(/.?.S^.@)_,/ccMR(RKZe8CR;:=HcXOCW6C1+\[JIT&>G\2F
4)=G;bbc>deIU\G9O_eLW9[Q<K>E2bF;47+@g4gD=U2U1?:Ic+&FRS<9aVAV>#,Z
TD/E;.@ge?SS-d2<;4]:C335M#&&Af).Pf,)J]K@ACGDZ@MM^MZT9@E)WFLc-;JI
TARCXE,94]&R(8e7@U633bJ)5562E+6g)-AaG79df>BIGR??Ta7:2&Z,77\3QK0R
:1ZcEP6.+K4V2\PN6G/-S\N\D\80b,ZON=529\c+1+J_cTeR-FHS\gH.F7a@G8(Y
e4CM0GHTU6E0F8@Y<TCXXJ\B5aVD.8E9C>LdJJE95<\C1Q6A-X\UGV=0_@5Q-81e
.@.>-][&>(dE5?AP@eL:cA.:]<fe90R&X69U;1+D3N#HG.D@:MC;1@bWW6PPccb/
N[D]58;5Q72#bCGg[9-)_E=:87JLEA5^(bV7cgdRFB=(OW4aC\&;bbX8C;XcA[g<
If6a7g/bb@fVf#cRF^K.67[#6>#)],Zf_4g-TJ>;c2;Fa8P5^a.D=1SG7;Y^:cZQ
Af4/CG&?Z+gMfB&42PP2162)-K2Ac2GBS8IQ@0O_d5C+8J=??:R\]C;L30CJYc^d
_^cg4H:3TQ^7<[W0]gO[;aD.QWAC<JMJ6c,7f=(A/[8R@ZQN1&OH=S;LI$
`endprotected


//vcs_vip_protect
`protected
aNJIS]dF3F/&1@Oeb@d82;c8:ZabU^EQ/?F;[)G^a5SCTJ/)&e+d((S_)A+[2P=V
WgJF:E?<d4DRX2a?]PcI[;YU([>J27J\R)NPS;.6WGY0Og3HJgYJ\]Z,)0R6=?56
fEW;J5_?4-?g_QO3aCT+Va\;9:FFb(DN7VAKgNaUVT.+Mg8Z21ZA_aTgN(.dFW46
>-FQS.?3(T-/>E?gUS5=DPWNbSWZ/+[QHTF;97S:SQQG^>AcSO/^3DXD94A2=XOW
Wg2C5Z_/_//+@#a5.;KeZaTe[3KPYNfTa&AL@?HT9SgdB\a);VS^&HF^O#A4,9_W
AC>:Se8g5NOU_E.^3SWD8^CJe^IJF]P[(a=4GP<,V4B_NK(3KTIFL.De/O)(OB2Z
L#O96HB3FH,VbI91HUf0++AAHRP\MW202P[acSJaP-S#8eOUca_3^aH&O]dYD8e7
=KBC_^0PB\J]SL3Jg_OTN\SVFK29.-&,(MC:A^SJKG^6NR^.3P-EcG8##ZWJ9B<H
_2eI>L.L=>5]\\gY:G8.2Ze7(3EK<2:GIG@E6a56&B@(STNA@O.G^BN=H&9?9O)0
WS1];3]FT?cQHf\F.Hfe:Q.V>K&Yc2R=&;4J4NA<?K9&BI8PW;GSZ@GQ&DM=G4^S
^^IL4Yg,#0XgeW_()>/(+YAOW9S#\19GO.aZAb:ESUb@D/H:dT17<=K<?Dc;BTd0
7T&b0L5DK9C_BC9#P6d6GEKKcDRf@:(?[6NOe)&eD;b6A:D&V]./JAJ4^M96#cXK
3FH7+P#-=H.MdMN5331Wd]UQ[Oe2?TBA4X<XU&c+W,[>a+c.Y=NN73ZK7XHf6)fL
K,9BN/=4fEY)&ZXH(,N+0?BW4I[,9[H.a/(dKF^MUYQTODI=VJS5<_WCE]=(IJ4\
SP_SZ0Df\<4:4C:+3b1D&(?_gFH\;.NQZ60DCN4?W&cF8\UZR2__;(bDBCIIAZ=3
#aE,+J_\7\+^WHUg0ON<a60[[D)XL3S>>FV\&HE=RUfOH+[;+f.F-ADg[Ha<#LA9
S6daDKX->_@A1S/A#L#.[Rd>#O+]_.[(49d@G(8S^bG#cL[6.<aA+IRQNHQJE+;@
_MeH:S5QO2a1&&T9g?U#2B/>.>K5Yb\a(SUV\2;\eRg[&BZ-ZJ>eXJPee/T6gAN#
MQ\f3.]BTNBH+]ND=Y2O[^K2F?]TaSf:LbB)(,J3S;<]D]K?MO.2HUc8<f=WBQ(K
H=b^KH<2dCFH@dV#ZKLZ<95CT_0UeW>IN]e2F1\_P)bT1\^M.S3L&fK(Me/-H4OT
1IYgJY</E^Ea_fT>)8NKdG<N44K;F[60TfJ&+,U<3[H:S/^56[<7g+9,WWG6HJ+e
RP,#>#8g_GM3L-4=1;9+^fZ(W20#a>:6D@+8\9[HSXSXHCcB/H^M12)R77e\&B7B
H,I7QP>KC(G9gJ3,(X?L\#-6eD2T7[4[3d60GZ@K]3GQXa9=SN4gc(AN0G65)<G.
RZQW<,d/b[/6ZV/7bJ:7e\V:a-?]YW:f3JE3EQ125^cMO.8^;=&#=:N?FYg:QNVE
[LN2DP\[FSNf??7>,ESSJU<,87gH1<SZ9<3cQB:+3@?F,]R455]^)Y-@^8/GZU:e
)H/(RE(,RQ/,J,W(I;ad,Q2@7)dQ?,C</J^]X2ML-WDd\NL#MZcQ,\gQM]08Z:KY
>(:+;g6a2HdZFd/dHA+LeCLBO87cLOCf>f6VRV\UDI<I05(VXOWaLA39BWU^&@XV
0Nd,&.?_0cb3aObN0VS[@LVAF1?;20TSZ??8YULPIDVa1Ya?gEUB6W@(beX5ZHOg
<F@0>PM=AZ3e5#c#cN/,]I<]6e)(70#TM53F#ZW9JO@6=GYgc_1>?.?96W)R75?[
@_M6bSH^Z,,K=(8;fNaQ7XT22JJX[ZgW4XGFQXc;/<W8J.3N+L&L44DL(6?ZS8XH
Q_T:EX9\.eXP9STKb)I>2-;P&b/_&K,EM,c/MG-1PA=Z6\(3U6&=_/3U))[Z+D19
9=.^L87614_ZL7C,0L.O;.O0D(CXX[IJEV7##B@Bb7?PHCQI3&V^>?RR2;eSKDP4
JZ:RGgX+-AHALfX/,5K>9-e\.(P2::S+Z&1.[JeVTM?NH9-B0Wb_<JK&.?VbF&?(
FJe?CfF;/G>M)S=R@-O@HNMZ>4d#=PfL:9cb8ES,XQ.=-9^_2-d2H&9#-ZO7AGIe
UZ,L\a0@M#bK)fO3_BU)g2@d_87QI\Z9#H>53;\>Rc8O-5=Y&=eW8FaY(1?8L[.O
I.3]11S\01c.Z\:813cRSN/XO1bX.>8NG]GAK9B(CbaG<HT\Z-dZ.\9>eRVSD&\f
Y8562HRV+EG,bH2L08OI)L/L=J03C7JL-bYeQB]fg-#K:C-J3<_+D/YS>+d7Id<K
aZ5FP:5N[)Z,5_IQ<25?ba2HP23-&,C^#=JdgWT?JdF?0e?9E^9Y><O[.6F)SMFf
MP)5L9F:C-UfTJ-1Ba^f=6I0d\;cbD>L-BG90(,)0:C[/DW9V<g>:92<JSPBg.FG
AMV7RA1N(&Dg;#B9,f_Q?:(P&1+bCC+PbA,9JZRRf,2[aM0_WB\CT:^-^F3^NV##
7[dZ-#^@=&S&71<d\K+@>K?TX#OO_FH.Cd=XX]6d1KES)R:WQg[UMIZONMXV.FR.
PgT9I>e-3MJ4PaQN_c&=X9c5:R3EE4B1#(Oe]^29bVQPPI^Ab?WL<(J7>@F\UGEf
L,a.<X86[.Q2#I,)6Sa=]_,,TONb7JRQRc\(W>R#89Mc]J@33-F>2^21\[+_9ff\
5a=^Gd@_@4I\HKI\39CZ[cJJd<V:gefB8+;.HaW(QEE]PHNb)RR:<CT-ST&=FCS+
KceVT(#\Eb.N7Z_,;&#]edXUQFMWQE5T,<]I?/;XGb3\:32@XAWL<TCZZ7:JF,E8
8>b4Wf15:5E>,W;cCPbd][g/g6K9FX9(.9G-QF;1>(X8Bbe+>G?17&:b;>e>c4-&
G4)0&=H#\fLC[VK3CF1YIU+\36I&VL8--,8W0/d<36S^fDT[-ZbcYA^,;KL2GHIB
=AgL:7Q\P)Y1.C1#3cPS>P[6(#0NGZ.\bUfT_fcF/VV+U:JgHLJ[6WI4DK^7544-
ROCd-#7365(<3cOTSYA)Of@WNKDHf4+6=.@A<0#,0ZZ1^DJ\WW\7dF7(8XFfXb,B
YL#BW5C]]@Y3F#N;N9_)B^UO)f7=4PBdJ>OQc:;/I8DO^./^bJ@3SUSb-B/YXVM?
4V2M#KTF=1PX&^.6/6[^8XYa8?5H[ODK:bQIO99A:?A4.K?=TI[&d&=f]L89fEOS
Meb];5,Y/cJ1I?^_IX\f[bE,dgQ,0TR_.@;GW5=bbb8567=(ILgE7.ZRS&+W=f?X
L7g<W;H)36fc]MCYTCL)SfZ_FLAA6BRB;#-;b+TTPOYOB?\G_GbAV-Yb[U.CW<gA
4RJP@9=Rb1)d5OJAWK#KH,O&,cbfQ(?HQV(H-Q^.e]0:GYT5(W8FU2A[c=(&S9(Z
IV=@F,+7(+CB35=6URNEF-d1ZP<V\=cA:6-;?:5QG.b>]UP/KIa,ARR,dgW-3G)L
I75^W7bRH\=3#SFACT)8#K6O)gD4X?/Q[@b7I3)4:4J>P(]C9UI:X?<,[09[_B0G
O(eP00TFY6E<-dX]=P-?R\5Q0f,N=)#Y[+RE,W]C=]bK46<0/Mb(>/^-3ZLY@Y\<
d4_eY/V5@EZc-O7-W39\ELJ]-)?2@(d32#M@9#a>[:aJ+1L<[0MH(,6bS<1E(g6<
6YbG#2GS8E+A;7ULT[H93VG:WdU2Y:.Yf0Z)<\;dI<Ze0W#65gb:3<UB\&\YBS].
2.4_&G0Y8bW4-9;9VfaEH5QT^(:(T1Yg]B>@cG0T40RPA4].>JBUML4\<[b)?J#M
SEKD7GZU4)CYEJ&fM>)31gA9+T-,.c.gKT0?35Wd,SAd1_G1bZF0-M?[=/_1R>a_
ML#IA0L0_?LAV^)Z>FZgPCSZEd)G/F=f,P^-bdeJ537XZb@4J?W\e@NTc34>YHML
Id(:Td+DMAeNVL?^a8\gQ5PZFbV0Q(fJ9EE[GEC/\#FV_6DL]0e9)MKAMJ,9<30W
Eag78-]B\b(#[;eJT5_9RUUI\M,AHF0-D7aS+]UXT7ZR&H/H)E4^5:WB/U8Y@0e4
Hd/)8483O/S7><PM-afLHb.B4_X1Q,UM2/L@^EX1N9J^)[CLT<;PO&KF;(R?<CC4
RQH&[E8)eXG\PZ&KAJ<cC7;]Q]DK,dFabU@0BVIaEAPQ=;]0B=<WW9\F&\VUR>F2
5DbcE7,CC37aF-S69D5,KPbcJfa#Q.QNS7VVM5P_RAT&bKE_cQ0A697D]7PY5@W>
C?VK4131V\\WYfbeb^0fBP6.BC4^?)N_3YTO?><W#FfDCH[IOGM=R:ZU#?SM3]=2
)0OZ.O)KH0<WE_\Ac&L=bT@<OV^a4Pae))MT+=.E1.D=?eFdg//P/)G5gTb^,e,Q
e-4,ge+F>?=7>DagVgg>7AG]N&6\f\G\G2C,B<;?e<Ve+62\]#;:FUN1<O\6]g83
C.24TD17(8\:M?(Z=f2gad3G51.U[FTeQS]71^e-99=JScG1W]fe-?+5\K@XK@/E
<?7TJN2B)Z6[5<^,dN:])ME;EW[\>L\P9GP;L:9Oc_,54R/42Eb>A1OX+Z[d<H>a
Y=)6Lcg1/Y2:VDRZ;Fc2Q?)VWLGJ.G?)@E]\_Y]K93X@L0RA00d-9d;7@0DP=bEH
FH>g1bGYO+.C;JdBD49Z6YON..IWM,(T(UCfG&9d[_;E]4#X;3bJ[Q,dH9Ice\9B
<#Ga^gK[[A60-D(J3&KMX:?C(U>+A>N4?-/23E&d4\b(/V)U[Yb+(OH,;D^<LOWE
g?4G5&>/a+QLZ(/[)(B[XIP5?U6+TT2g??=cHEO;/1PQLVS-VBQWRS.XVH8H)N)Z
Ne:R()D)f(R81[TBJ+0Ig3X:a5Q3[&N)F+AGENJ@U&YO>>[&OP7B?J^=?Jg#RV2^
X\5:]9\L\Q10XCR+dDFdEESDPMKIa/R2FcI:XA1QQ]\ZAe.>4\0[&9X\d8f@RV-A
S@Bg8B51KUCVc>9\[J:U95=Tg)7aPa]FM-29\=33_,:3O4:-H&X^fGN(FCHP<\g)
]]Za[PW0eR0]=4F3cC<H\Sa\SF02-(L:K=_ZDKfRP.8D5C.:b=&&S_5eFL@N5-Na
BLCWQ.=F#Pf71Q@FFE:abNJ<]0&TZ,5\K8Y:2(Q8+@>Oa<8NEGa]O+-BcIBbdaZ8
A@N4F4-gdIM?._JeMRbRcHe-V;6#,KAGP@L,JE&cV;WO.((JQ.GZG]WM.de)^b)/
BHUCA1M?:KJVEONddIB3>Q1J1GG3V4:>T/\2&,;I2IX2?#KO;JF7#:#MBc;W=U2d
ZEKcG1G8QC&0e@C+Q&c?[+PR,KOGTVd<:AS7ee_dXcWV\OO(0cW4/\f5]7^IJN8?
PGL[]0>c>e=IF)K)TC[.G9N<<-4gW)&[,ZX2.I5Z9),@I8>Te+D_IVE>MO3O)+O-
>7QW3cRDPK,D/CGY.8M((IS#GaR)N.U8V(PN0\Bc50&)S1(eRf@B.]HJQGU#++fC
R@Q(&gVDS4EMQ?+?Ba;O?8GdQaeKGW)66A/F]MW+-RL2QY<KD1@S9?>H+f5cG()#
]S7aMJT+,H4ILeX38OD,;N5Pf@FWT<A[\B2Z@ZEJ.E59F<X.?O7-8P52HAYBR)[Y
B4;UQG:Mc+)_gCKQFcM/4_d[GJ7=+.ba;LUTgWPI=f6g)5&+5PYgGOeYU_,c[P^D
T)17IOE=MZIHc(QGG2);aD#XB._LCA_Bf40]\Y:[gEOBRS1O#XLX)\d<K_bfE=3F
>bEbMc0DPB3+g+A.)NM1b/A(3-CMD:I(1^c4.()d5L/_8/eBU(8\G3OD)Y8V)Y1O
Jd0#/->Yb@2[MY4f)e0,E+S1W-DM<7d1?=29/MCVO12A^a6V.&>cSK:,)W:QfR>[
Z??a\+PA48_B2)MAX?.e7A.XV+f@@#FR0H1A5I2US[,V5T_2:0<M_HXQC?;C?WGJ
K;e6@PB#323MbdJbSg:gg&SKO3AXR77E,(+]-;3>fbC]7+8T0ID/a7.&21aGe/RT
?00e48J=&#[S(1PUS[0]EU0M<[1T-69e?+P(^e,Cc\B[805I5e7GEJ.-8YbH6=-Y
;U@N(0.<QQHD:G/X2gZ/3@,G(Uf#DZ:ga<U7-?VF93A#K=+G.b9\&6RKRU\W-F@Q
b/d:g8aG\@D[Z^dPV8^+I]1D;g?b>fgVfA)ZMRD_/=1=4dUQNT<QH]ALcMLKKd?.
V-1-.:39:C5e/VaCW=aKd5K75(=28_)^faP2MKUN)G2:SYQ=UH80Z].&6_cg=#:@
f?_D-=X6)^TZ\g:I2geYE5aa_b<=6,3?9EB20O:+LN^FHN&HQ9_cO^S-KZ\a]GCf
FOS?IM3PLE;G9QAKFAWPU(CR]G]>OLX/WU8=/B9N]ecc.;]GB6WT?cNVZ71I0?_d
_PDIdE&;Ye\aOWQGC>ZG2/QE:=2<_S_;:d7L/0?7YPOVZJ94T6MX:KC]0_00:M:A
cL2;L>VZ#49:1NC(+V5X:\PNK9;804WS(fc4:#Xd5N9ecDe-(b]TK1H8U/PH?dQV
1>BYa@VIAV;fYR[JW^6W)2@3GaHSAC71\DHC6A<XPPHT[9H[,=S;U+8)1]XY/T\L
FgUFZHI+O:J(>>HUD]PZK]SD,Hg.FN;>>_BM4CYCDW=+,():GA5R2)M0(gWL?(d>
>ag#O&MR6.N5G2T;eH^W)g(-A&B)cBSd;]:2\c>?ge^VWJH=,HgM#W(e+9:,&bLI
4e?KMcfeALV#?M/DY441(f?X@V9[E[]_5A@OJ]^W0eaWd944\Q5U>V)ZNF2G=2Ea
=^fHb3JH<d5a.ZA6B9(+&@=cdeCF#T0db??QHMZZ.Kf^A,)2@aD2,CNO>+ZPD_,A
+N@YFLE8E:D5]7^MgT;\Q[-AOegU[&&JZb0VaAPGQ60Y.@-)Jd-6Wa[I&OMV6;6W
MY1>-6>X.U.a7I.:0,ef)YSbZ;;SCU<IT7C73_]T?XZ>+I>5@b&XKH&=9-LD.XU#
^6gc6N?;KXNZE@V4A?&U3H(E2GEcO;1_8?RH(@c_R0^bS64,#&RTNE7)Q40MM<JJ
\L/WNaBbM<(9a,48NOW#B94S:+DQN01ELO6\.@;&1YD97f]c=51W?e?Uc3ZY.?K9
CP2TZIdPKUV#M[d+72Z27Zb+9c3-<WFbbVJcdf(DR]H-47#P@VYZ9(N7Z:Kd+T&f
]RI)8RO-Ac<BL.65NaGS2d3f_YC+e<Wc@JQ&517E(eOG6Hb:;3U5M4,)+K(Da/:b
K[f2Z0g0JfV/Wb\+.&g-#cE8]+c,KEE3=P[@CXF4K>A40PK4#_8U2?>P:@.5MI.(
27EZ@74b1D]XXF6AK)d-HB<-SK74&Y,8)=16.HfLL]UT@PX#QJ,O<5e,1F@YB-]#
\EaDXaRKMa5OS<OBgMSea\14,MX,DVT)-H/3?L0Q4#.:e#V#@dOba@;L:@C4UP:E
FQ2#5/4PUQ^6f<3]g=@H)OVSWd5g/e-bdfKR6QI4-OR9UdCU<^IZ_E0TMB_f9Hb)
1_0I#@dA&2-#GR6WK0c2SE_<,YR<T6JO8?D^d6:4QGEc1e^<EI#ML[H,Z,2BY\4F
I]QA#>#7e,WNa)QUE<.J^Id_3c<AD76PBH=Z,&:2WE202+_H@OXJ85AT4VV\ZEg=
^Y+(SU@D118)&;8+ST@7ES2,SEPLBERTbEH=a_>J:5X7&8d<DO@IF#3<,Y[HaZU@
;NJ+;O(\0I\C6N\<aQ,95aZ?6>,^[#\-cE#N,GfC:M;Y/L45L_;D^KT]^OC:E&.+
A\d.Sgb(dFTGLK(<R/4gZ@eH[#V](#E-.IIaKgL5O1Cc^bX9c>[8Y_1C)261TH>&
RZ,1ec/HL\@8BYTD/97X\)/SgXcgGZ0LSW5HbI8M5DU]_T0Ea+YQb8-Y:O5ELY4[
<;ObPC0ZA+L/ZDJ-HQCb_KMX.;g4\CXD<D?/HeV8,UKg2B;0KP<01@aGKYASCc<V
&:Eg1A99(,@@1.c:/^A?M>cF<5E(83I,eg-X&Y,ZWIUM44,&,Ng);\+6GBFC3Xb)
,+JHSDMB/d49LY4?IO^Q4FUdW98NPZ,4(6NS]G?D>PVe?)ab>/]2HYJV/U9[?[PN
?6Z7dRXUYEVPY5K_>]QCW&A:X&(BX@AGX14f)CW-@E2I,A>)Wf,70e0.XMU.,f-0
4@caR_N8_N[L#@D(KOU@GOQ3.?F=MIE^,]<=XF:QOFfTMF3[:?9\G,(@9&GAS<A7
.)Ff:+A/BU9g#9HG(JQ6V4Rf(M=E;DVE;\aaK31MX:d@VbR1b#Zb#76b:CEdM,W>
TSK\Le\]<.8ffdC4?=#5+8/f:K]A^0+M@5&b7?A[)9gb:7_M;d07@3CXJ9A,RbNH
1L8-K?aIZf@Z#0Z4e2M(-,K-6M=J;K@SD8H7.RS9=3<@9CdZFJW3][DOd^a_WD<F
GI;/9+G3Yc<g\6a+Sf8G;Y:B_)REFe?bg/I2T4#RH1CEJGY840.?8>9B/B\5@4>a
gabf+,ZJ\gfEd^9_O<RH6c1,H+_\-.+DcOJ&YI](7\)7d\:_)@aHID@,0dRYZ>09
R@80Qa3aP)f/0#[GX\#aO-FA6&b?VR0WNH0(+H5,T]2]Fb1.;HRfM)\8_L&P\0&5
^LZ#(XM4W5)=J><MdW?0g?,D(A@c-A\ME@LDe?Q)+;C9K]FD//IEKEf9(,4PF+,\
g&Z51NU87&KZ=9Q&Eb2XJMK#Y7J3)fAgVDeF9HdDO)c>X\?RH\ZdfJO&LU-?PW]C
[LdV+A0,9V7,M#5T4?&2gW@U01Z6NGC.+[@(S&)=0g3)\L=SB&L9Je5.e,MV&RTZ
=-Z<<4Pg#T7W<0=UR<(S.>?;#[T^(7Q&F,R;CJd95&^EZINV_8EG[-LQ&/DZZ(W8
c<9Vg5a,fg2:c;[YBE019=CAOZO6R-OYQ@A&/D:R8K#M7;6+A]3/@^I^/03JC]Ma
_0O5]5ME3:[Ad5IB<S7e?(QOdS?J]9P95WLD,O]/5XTE?]Ud)Y;BE9WH4:e;dOH\
_ND4.:EI#eSK3VE,5F&O)3<L<?.^NVb.+@TN=81gE]64Kdg#YN,I\R?@aW1OK:ZF
G8^]fI.9gB>5WT=54=_C(]d4Y;_:;)6I&=D+gQ+9<ZKPF\,/=6_=>5AHGI\I6;;N
<4.PFPAg]dRFBK]e0a=R)>,acgZ@#9gZ:LeI1-Qef)9F:=Z64EGb=W+;IYX)g,_6
\L<V0>#Kc0UW)W(H>N&;ZBB+8MW=EFPGG=dcG4I[Qf3MMM\V_PRf2^<@P2>Pd0Ya
^(#=O^E:S/#eXV,<?d&U/R)-R^ZbSHD@c9\(b3]0#BP2Nf:C34QSUDZ9FBKL\C_V
L+DObAI6C[N?=.KWG,)@L_&YZ6(:\Mf6)U@&#V68U+\3IMUgR2c&I=R(g=GYT/X>
\[:-=c^?\MYT=Q[F_4^>D>\:/IC[Dbc-#gQF>b[=d3S.N23;L)(3dK5/3:Z[[^8/
aUQDWR]6I6B4>AM+dI1b8<=XJGA7E<&5BMK04P0]Q&,W\NZG=(&dIg810-U-9A7=
:.NW1EaI<-3)c)dF/9R:2?<V/,LP:9/;K:MfG0\eN:a\_NO9U-C,/fZZPQ6L)X]C
+JC/EWY?5[(;9^N0^MJ3>0@BgFW?\0egAF[2,-<[S),.SF+bgHG.g-Y4?7HJZR&N
+#/5SfI_O&UVVV>=N2K+-Xa4MYdVFMF&E+9MCTH:@fg>M)[PUBGE05.T)CHLSe3C
5>D:3_AOEZT2#P?VV:51?6eX=#<b^.@-J\&aE>LPb=-#H_30f5Y0U:ADZ_H6:dBW
6=HE71\BLN&=2Ta=<e:aKN+J2D<))M+JBXKP.\_I7@DGXMLBeA.9GJD:;aN-9O;]
=C1<E,2WgdPe&Fd[S(L4E_eA>ab.XD9Z@e8Q6M\+J(9RB2M6[[@C3ZcHTMUOYLNK
=g>-PPHRQV2SXEED[FXW,U=[^<)/C=0g9.e+Q&,8_16f/W/74[Y-V1BLQ#M89YJ?
#1:&86XCOW[,f46S&3UVg:U=KU:[e[DePH9b6>^C(OL5_A#UUN.aU0@3&d5Y]ANR
+gU-c^)A&^(6#5@F=f4?R6/1cg-JL/GTee&#g&N.;T<56<+GKIU]:,-C&JeeaE(Y
B+&F>2a^21;Z:H,\<[=L&_DcBXLdbY4DQ&B_>L?NIZBCeBPcB^c]Sc;NQ]AdaI:T
/RJH@JSR6.ZN;5e<EIJO=KQ0;-17?N&FRbNA3U/:48fJgOQ>?72F5UPEMS@bf9f[
RH>ZY=D[KZ2JT]G;DG759=Q&O5DC=\0.L>K_E+9/&UVJMUA@H5:V.1L59e/5YadQ
783:61P0>@HeY((QI&W.^GF:9:\@:)3>DH3>80f1JfQ&;:d2>GP))gY6?R6UIYH,
XWcR1<J8[_@\]=;IKQLT<>BRWT_a]3HV\A>4PA9(\ecIKgX5^NY0B@^PYHR/=9bg
Y4Q17#B+O6166<feD\+dY6PIe2<BAB&E/\Y+?0_bPa<76_bH-)<L4Ce7GBDb^&c,
gO+Z&6B:bXRU_Xe8<;>@TcM0H)LF3EcYVa-cK8DXV^ZESc0S_M9Y[VVCc\VcKZ5M
bB<[+A@d9;,W/S/FJD5UD^f+KV8Ag[1HKDLWB\b3X?YMJ?[fe7LC]:?.XbOI5+MH
N8=,>2XcVZ@F^fY?Y;JFQeUfS&YPZG4UUT-f,f:YbcMQ5@O-2UJd3W?G[;9K@[&_
CYWSaT>^A?>8-<7TO-EedR/QA&NK;7AL[8FRc=&e0Id]E?4AOFSOPE^5ZfAVeAK5
8Dc@[A-3H/L=B-?Ra(?CK-762d/GA[+LN]/2OBY:TM<A\JKZI9Dd5L\aPAH4Sg95
O=IGI\>]^-VaBCf_24WI5],:5dDAQK+7NLCdb;07fH9]-B1S=X-5HQ1?EL9eP?-[
_c1LIeD-2O[:[7M5/Z_/J5H<?^[\4VEV=^LfMU6U@.B?)OaeV/-+MC=#d^LXU\7L
GZ?Vg4Y;YWGI,0/<dJ<+IRCcPM-(K+]=#B(4#(-T7d4ZG)L:^T.E;6[25aX[I3&Y
:8b07+9^A.=Q3JX^b_K/@3JFb2(F,Sg3H:896]MHU>Y[fD=5?Z=,(Q,fXXEQ&EGY
&HI7C57^;)94BU],^T9H\ZS10W^-GPg40A\N,4ESOg#=a^P</TJUgS,G1d\[9c.#
-?>R])?adFfa=XcX(a_fJX^<2.S]ECJ=RIN<9+?+(?RBVC8e>.RVHG0/bJB1@SZ#
&+X?3)PI<G>60C4+@AB,35\5W;.140P2&3EO=E[J_\?0R0DJKg,1+FOMUJSF8)fD
,W6-@^W,>_V?L_>cA;L_7R7/T49DZUQ>-@e8-=b=aMEfI8)S<SM[70QQ<99^7e<J
=ce]9)E1Ba_bFZFP\?Q7UF5X^HKL1(ECJ6[^ABGUUd2B7O^7NgUZ5Qf+E,A.S0@K
M>2aEZ4Q6FKT0/.HKXY0MA?(f+5;Ae9JcENJ)3P-/4;4/+?EHdg]CC?cU1WVe/8f
V6QDb5Z;S[U,3V(WSR/_9<.=Lbge)bQU\3YcXO.bZ0>g/6KeOL\HW/X+HCNTQ7CK
)5-D6.J??K@+bZ@F:N[;F+ZcA-LW0bg)<#S<Ngb?^_.4A,HB;#;dY^MaYJ^D9K27
H5<[5IN8#R4)26.eXLaEGO+LdT[YNMUF_AN491#_C7;RLGQ0\\&/558EMR,TO7:L
/a@QB8&bJ\CD-9T?K3g<=cK-\^G97ICVUJ]>Kg3F27=bXFDZde0EZF\<\4T@1(0.
2E61/KX)-&.OD,W]GOeQG?.g:5/)gH4&_g9[a+96J&4X48<DSA5,G+UDf)CXF,P=
<@2G/K1/AR7-OJ-0M4:ALOW6UPDe9ff-?AcDJ36OaE>H@bH;=J:(/HSMf,f(O_,5
Bd5L9EWLUPdI4+/\HV/WO(Lb=2@WFE?+ZP8AW[NBU91Y.>KG1B73]eX,PW2Y+4@&
<NZQM-G;+<0VM#a2K+=YHbLDa4OgW:]UR:[V^Q/7I>AGQ-d1GbJ1a38[K]\_+9&K
g[,G7SM21)G[\fC0NTB0QV^[LFOK#g7+48b-V<6,#&4Cca/69^Z&ON-V1)ZU4\KS
+,ZG#NA,4]XTa^(?I/[X)1O^QBf6PfO:YZ=L]LX,4HUSF)PQGBZ;\b0e>#WE6[7B
C=03<P_?[&g54cM_?dAgZ@X70-(7V89:F#Ifd;0PD1\[aGFO)D>V<C>1cYP,g^21
7.<&T)0YE)J-Z]&L/bQ\8]Q41UR5)2ZgBUYMVR,4+AVJ4B535M:9&0QVKg]P<Z=S
3X.3K3e@@/&1[.4;0U=E9OY(Aae\G6^eM<2b=2F0YAgK&Q8<TUFF)LE(SWGEQJc)
eb.0J34J.ga,0#&,&D^H,Ye.@MM#6eg_Wc(gOLQ[.g)e(0ZP]DP4R(V@O7W;:6<2
fIXZVbGW)C-aZ.GI8=G4[TD3BBa)T4eb,Q@IJ_4832_=1,)73VGd1e4>4X)9F?\4
M:dLXH-L^0H]U])Hd8=41#X+Ed>S8FSB3:Y-@;HY_,UCC_DaXTC-d=XK;L)3+7\&
HZ[b9OU2fT5D.[PZ:faEHBP5F8;(VIL0O<88E8g_/+<3D03_J<=5@INf@^#CMO28
bUNgK0/f)CM##.JLa^3AEZ[&3;G0LJXR9O??(cC5fd<.PIQFYCHNYRc3g@d6;GP@
W7)GM,S6^IU+R[/5=;I2_<c/cK:\eMfbYAM[-<ANZN[gNN^&+C#ESDQ+&WD_gJ>T
#8TOEJNFOYSHK#ReeVac==.:>?FU[0.K,)ZKT[C<.O2\eaBJ1:@B8?<JYK,Z32XD
W\86ga[fR5-_+5AgfW_J=@&e=N7I8CTDDU&/a1#HJda-,dagg9JBK@6H7N8D0+G0
T:7#G?^ZR[#Cb:WW4d-AZ@C@-AO2O@?dV6=Z+,(F\fXT=YRBA0[BCdC,Z<W)KCL]
Qac^7f#6+MEf=:2N7]bS+f-(01B8J+-cP:6T9A@e,c[J&@dL#Qae?L36^-\_7.a^
]ba<L7+#6Y]7+.H-H^b,<WVYM<-fPK5<Q[@WV\&NVSaaG#GU20+[BUfNM_+G(+M/
f1\@F?9(7_-)Y/+O#+;SYVYagd.fTDQ=&Bb4^XC;VDQW8g4G&KOY0cd46>8\FO)Q
HY[W#.eDIBG&aaMEA#^5+c8.=7Y@b6@.f+aA9418S(SW9YdfS;f(0M+(Y^JO-a1O
:_ec>@@9@0?U[HXLb?P\L[&BfG9fZ[9H3_V8F5[V-3?2@HcY;V1A8(A\:X0,:S&U
CUZ<g=e.DP+BJOBe1_M]7&@Z1R25YP+4]0KN6cSU/WYZZV--DWNaO2aD3JPIFMKT
N9b\Y/Z=H[^CcfQ+JF(RMCAB.)A,fI:,e)-W50g<A74P0cQ:/?@^UV:fLRe9?9RX
c3a:gGH_VK(Lg54^.Rb5AHY[Ka2[EM:BHB6R<JRf9,c/9X>,a\8VFg7H:ZcbTFH]
HaO5W:#C0U53.<Y;XP_,P]=^-S\<0V.Y<4.MD;VP55?QU?B9[^+VH:aa48WZ3<QH
UcN8D6IMSE^ZP)Q#7Y4=6\CAC1+YQ_Y<01Mc+cK+GO75e4eXG,BH_.K:F2L066be
W4OITO3DeSE2)@+S_@S;A@VY2ROG>9TU3\5G1Z/2C/OJE\7C3ceRZC-QNIN^[RU6
M@7UOTU&1U9-S948<,bD(\1TK-&29g,]FI4PD+/VPJRS(P0a[UBb#9>F7a14NGK9
7ZLPL+Y9?(JfJ]5UL9M7eEJP&AbZQMCYb6LeQXO&HfgQL@P-I8W9a=3TZ+>aT5</
aQSG:HPE6c2,2J?;^KRdH2F><dU_R,F]2Y=AdBUd:->T9)_B8Qgf_S/aaF+e;BQS
8b91.,,Xb>VGS5f._+:HZ3=95/G#0PX^;bg=]QP0T7C,#WgNdR)faCV;dDB;fG&?
[Q16QVR^)+=NVL0Rc?]#5Z8I<8ZU)OQ7eW;2XbC;Ic]BWT#Q7YUCA;C/Tg9.I?A8
QAJSZ2^O;2+ge#ECbX9BCEA,<KUf&)&\R24LH6X>=;:@5IV&QXb6Mc\gR2J=R,[@
6eX1YS]L0/DYb@J,.LD-gBP<&d/SL91F7_M;>]XcdPDY8_^_9a,\>/Y&HeX?].NE
/&^\WG\RNafO/Ue&5ZK5XU@=XT^IVR/E/a?3RJ2J.R:-fVDI7@<-SAbRJQX,D(\#
+8@6ZSDCf[9W1W74=@bZ-(>Y;a+(&F[.?aPVf?)&JJK#d,QVM7X[B>2&4ee/B)()
W,Xg0[X9c_<O@;(HR<1-#E)9S?d6.;MQcZ;P)DIPEeGZ^Z8-;(]Y>.[:\D0ZX+.6
E<^UNY7<7#(EI&g5BeDCc]C^(a>S9Y+RLb?2G,Z6PEdE3O5]NAgYD<C3b@-.a^4E
&VZg-K\E66.bgBO[cPALYM]1#7J<)JTF)+WYAfJT9:gTYV#X7Qg,^_XG+BJbb-,^
/M@2>FICa<OU@bVf&4#,CJP4UHUM4R7@TA:C@L@LC6@^?b6d7LI0Z9C[__6:M9/_
c7\B8YgXS)Q\G?]0A[2Y/H.#(Da?L^CCMWe(]L/<P/.#_:?]FGE+;=]:eG4<@d^Y
d8291,b?RGZFGMQ#AT7>03PNeMH>W+1WTbMGT><_B1\^_EX:eegU4)63EHD=DeNM
aDLV8(&<eXO2?;^ZJ2Y/W;?CO(.V5bTG\VWHQY]+XY5+7Y5N&A86A2,:f2_RfB=8
8a(Q@P@]V4ge]2&V^Id5UIC;1V1X1@g[/3.S@8;>P;N7FG\OJ_HU]\DAC4QAbR=X
=eCC6JT6H+P2&DS&5X.\I.b-7C0Eb:O,>V+CK_;9a4VX]RLGf;_7R8G=1#SEPgTV
,V[=P-d[Pa1.[NCN<I9HLBf][_3YT.M^<T8[A39VB?a7AZ74\7KC5[4gUdd4XU,6
YT=C2XaaF.;g&53)=_+Q?W4c,)f61I8N2J+NMNDKVV(_;<E/ZGIGQgMEYVF&=;C_
HUKDLM]JLJ[A6\=EH/c7()A8La[)QdR,\NB1./@K:J0-5V0AbfL1LRdR)#e.2XZ.
H154[KURX>dJCgPE:JZdOFQ;R07JP0,d/>PG8e_P(+6E^JR-E>^26PXIJ0B60_,L
_GPY_FP6TRXU\#[KOUI^Xd,8@=Yed]2V9:FJFG=YD+d;;Q=OQB4&R)NdK_2cYCAP
?&IfUYgH-7-#QKM,91-9A,^+g1QcT.M^QKQ2\XFWOf)NBS]7.LaK]VcU<UeG.I,+
Q8D,OW>A\]1f502C.0@=\CHW0X5_G#T<VQFZ72S-0WZL2DfN0d),?P;0[O-CaHc<
H8HQ1W:NKNVX^Q+B=OUZ^.g7dH)YZY[5J.0eScZXWeG&ReDRF1:3\7@_;?-W_E&e
+-dVOJ.JGY1H;eTT+^/6BU?SD-=gT]3=IHVP)T,RC3a2CW;g2E6_d/^:@-2+/>W]
LD\K+U:<2.\_JTU1;a#;:c^M8^>Na&5#&H7G\K35U/?g?=8:c-[dfYV@=O?3<5\?
?Q7b1#D])^XHMY8V0SNT1J?=4&?eg[@a;1UBeD(ZC/TQ>)<?<a5J::HFL))[^QW,
<\;5OAC]dKRD+LS2;5BMO@<Zd&PAWe(EEdWZ=MCH5ZK;WSO?-U9WRAQP012fI]2f
JJ6@3,&@T;^+VUFcQ3a.,Y\KIf3HN;^5/d]U49<K,Za2]&IQ+6VCD,B<)=Z04dRR
ef=6P^H=[9;3IR,;I]U7T-(Y7,a8+=7a;?&eX\^]K,;(c:&,C(\gE1KQ@W=INOAK
6_COP5#cW+->IA8gb:Ke^<OW4gb()_+(/=[\dXR<F31M5YY74/EY=Y9/d)I[2-2Z
XG/.^W\.YcddIe2f^]]?eWMQ3N?EUaf+30BS\D=P49f7<SZN<B(.2TY;U\L1XW@:
QG3OVgUQgWO(aU,C<G9Iec@c8W&LDT7^,+Kag7Z24Y-\YE#U6@R:?bX2;B3TE1O4
,D>c53;:VNNDRf3<HMU_U\Rd\W4-<-2ECU&@N^Y/JGV+?5E=6QR0>BH<+=,/M9D5
OG2LDL_bFS4MS;H:\T:^PYT;BUV+OL#41\f-6O10Q(;+U)>.?.6GCHE3H6M9f]_=
bO><4b97@I6D5FZCV,5\KH=TO2[eW1Q0IG>D5H)[bb.---(#JRAC5C7D@CfU<SbQ
@XJ/A7/Sg8CZQX^<X-GV\-Q&:;O,ZG0U0HUELF2FQI2/2W=,?:09VK)a7cb.Z98d
NWcB]?<UPP2888g;Y5E@KD,/&20L=e==aDfIV(2U[RVXY3>;0Fd.OYT;\\FBIB?6
N4T60D)H2H6ZX7e/LD5gJD;P,P-T5@KW?SMZI)DY2,eVU]f.QYX4Q^9_@OE74E/W
Ibe+@J,S6&J^QL1-_;KO.DP#dB&c[;?R8KO.fY\J;TO@e2]0]@96,\,NB)[J4#>g
A_N#4\[5JE08:NIUd,4c@[Q-Z)c)NU)EL_;;eUU_:31P1cPQ#ZE2fg,8Ze9,gIQE
W?SAReWaTR=8\B/+>?3J6K80e3cZ^I]80YSARd(N0HBQ.Y>Ag_[;D]R38>8S6O(Q
TB_K,dCS+Rg(7#4-4dL04IMW;=XUT;9fN&N?deX^\cS&8#1e>3B[>IR)D[g\080)
K:UV.g4H2eR4>EZD:G^#7?3L.J?YTc7VULa,/8.Z-Q@V3f[9@QC0)Oe^Ob1P(JZ,
Q@D2C-RDPNBN,UW\J[a,?faG..O-JZO7)OOOLP#K(4<Z+HFU4SG3Z8-Ga^N-g.]#
dXN[BQ#dd&^N3a/UY6>XLYab-72T\Sg5\)0RV)Z;CdH49^C4Sb71E3c1NbND;49T
cB6YT[]JX@#FSCG6.1CU81^7.L,_daF2\\=P7)>@^W=JP6O6:/-E]bd>8[8T[L6f
;IXY\CUK@J.UgX@I(8\:Y:dKM.L]C?N/Xe7c]4+Z>\W^Z1,Cd0b05I@@Y(Y@.@UV
[bD??&LV7W-T+.0NJ+R.<F_Qg6ME904_?&Z:Y@d?A:=J9P\eF:;FWEXe&9[aVd?R
#e=FbZ,OQC;dg:IR++LMTfLVE1Ac0/,/L-gW<K)GEH+K0JNRRVX-)Fc&ZG?HGTN<
4@TF=2aI,cE-beK^Ha46e3:T9[9.@(OSZf&OMd_/F3HT=\UR3G#Y#?_NcDW9VC;_
-CNIGM=7\g[bg^f3S:EZg<UN^b3[^Q?_#fOa\gb&TR:+L_Ua0T(7&Z\=BCC<Bf6c
>ZQgW2:bY4L2,;):N1V1/P:N<FJ3)H44E-?3b9OOQ0\P1,R-5ab>+4dQ=/9J^,J9
R-(4+HE=_\CUY/WO5R?WFdRA[C4e1#eY0O=CW_Z=&B#:23KO.4:HdE3<:Q31(\7b
fM&#UHW5e66B\f&aeH,caLGU>FM4Db#U>,Z-IQ-:Y#V8Ga8#8<GCH>a[(6A#;-RL
Rde_H8;=I>77Z.;3QYEAUM892T08#W^[BE+PcC)7@D>J?=7#]RDI5#g#JFBEcJ^P
\Y6[S5L-7&&@2:GPKJ+c@2L->G6QS_#-Q(bXa\#_.HP>@LH^BgL1f8P6O^<>ZUL2
S:;W=4/3]53P9e[FY08&1?#G]]H+6V,GMAP7<U3gQQ,@Z/)E\RP7T^B?11;+\6<8
&U-B0LG1&Q[\;#0N8=.^ObB]8aLZeb)EXP-XgX(#7d8RV,@+R+#4\@.RAZ1APVe1
@E.cMO:GTeS??fL^3<?JC(K&e[HXT3^IYe(O1&b:fW=PH:G7^BaGO3#<)K,>>SNK
_]EL)VNeH9Q-g9+Tf+UGJ:^+N&Y17:[WKe:ZP351W,)).4AgP?+,_+TP6U[CO4^=
2]YTFZfVfTAA06\9\WK^K&A0dA>C<TE\D1SdRS;MP#+#Cd.McW,a^bb=LU6GU)K?
ZH)2]Q:D^78de(\IML^\)g\8Q),)X0;,b&2++^Ne/+cBQGOLHgAQX415M?EO2BMT
02V3D.+N<cGW+=+DcEOgVTcf)@NI;=VL+.C?f4UOZ,C4gXB0LIbB?_+#X+T\e3W+
,7EfFNB?gfI(>[<K,,NOU=&FZVgL[c@H2_P7,Og+U]Ne?LVUde0YgLTR8[\D,H?,
dQDL^[1VfD[SAHAL&.1231YPb]R]e9+F@L+]JV)]R1YJNI#T,d(d4-(YXBVXgc\G
IRGT&3B0aV(R#=JOdY0EX23,(@7Wb48+7e\NYCOd1S7/]7WC3O^K]UZTD3;#/Y3N
MgSI:00MJ7:OHWLW@U]B8C5)/\1M1V&XP&.(;0J2/Q1^b=,f69a;69-,-X:6)TdC
b:#bKKdaG>TG\#=_U1AG>=4#O)SK,STMQ@17fPOc(MUQ/NI9OdM(>BXI-CBRBMRT
VeO:H7?f5Q0_OcETgIZ5R+0RG^5:Z\[1e[,-(B8+f.=SGHEX96>Sdb<1D-_JH^^Q
C<M>E9c8HG,\ag?Md?4B;Y#;;8eIcQE.G]KE9C;/.QU#QK8eD]_R]8S.d.]NeZ4a
6\I52J>-4X99B&L.K^ZA(bKG30JUDd1)FbQ<>8V9=ER=YVDfOX.A?4UMBSVLSKI:
Y&V):;_B1#g^;?FDO]73^T2OE&XJb&M<0^6.g7FLfC]:.+F@OBDc^BY8eH3=UWIX
I2&]M_-c9Z1-#YRKERZ[T<fGT3O-c)fgPcE\#XRIQ/U[:dQdWN:N[BIcVB5>^3WV
_dM2ND05_eC#OY&0<aH\YK9M^X[Y6<?Qf)BDJDHd1/JAXSJ#41S(:90\/V5M+G\J
)@S@U0c#aU33a?2+A@2VK1,KXFFR:@BL?[[/\O<fSLC[_eaEM.;V4R1bM5-SQ0dG
SZ?9(+YDWQE[DOE_]8D:T(W:W[d)=ceE.GG+,?L(X:dDI9+.7K3e?ZD@,8#]I;])
N^7>8<e\c4UYK=SJ6TL1_/@cSOE^O>)46N)AQgd6>2IC<[M6#+6:ae\DXQLbQU>W
VZZ?fSU6HQF&@G<N9Aa.f,;/D)gI,3MDQ@BAbQ_0@[41;cJ]JWW\6B.F.+NddG]5
H&8^B)A5,/N4(ScYGbZB&KbE6W4>[[E4K4PZY/fP(]HK(CO3\W.T+\M8PM2>A]@X
eGOEJb)R9NU_eYO-3GgaNY/\+d3:T:FF<-Ue@98WYb9ZA9Fc7\-7HDce\(]AFaJF
HJRP6GXf0Td0D-H\Pab^BYPTL9FBQ1:\^F;GcAV=13PYJ0]QQbf5<6-)Yf74.cc2
582efYJdT=;4O.#FWUdWaQ^,=^[VT7F1F.bWL3ZLNP5A_;^QABS:4D)4bQ,@:&P5
OH5[W<&FGV&P:<\Z,M/<<&fZ2KPTHIY&#d:g=YZ09=e=g?Ocg/H.ME&1C_?C\/?[
E03a?9]89G]HSES4O:N2M5<D=K(_/3_@_CWD?XIIN--[;Rb9+2]e-27Hdf5:)4XJ
?\Uag<_W\:)UD#7R(8KVFY-:Q>1&Jg&D5>c)cFF8WB^Q.DS>7aD3+\bQ.D_TX8Q#
A>-T(&G&964/6cX8\3<9+cC&;-6E[^KTG]5K]BKe<D#7CD>g[FCQ@P0bWaD.;J@:
#I4a[[:eUS6F\XS5X^F2&W;8GP]]ASE_&AM^-S_<>N8905>eS/dY2[@EgYW:BB.&
&RcRg2J+DM8W;JU,2F:[-65)>5_7,41),cd8&OMA\?2A7D0+d_SK)e5)f,[CXGKG
2Y2?g??fABcIJP^A#+AQATOU?-&gPaZ-Y=1@N-/G<b\X)^?BbAF^N^4f#fNA+QBW
2XFDS^;Z4\<IQS3fbSUDZ=O&4[57ER)aL>J<Qb?T?0&HZ^315+G>Y/#X1RFMPccZ
c.&[;a;RMaG(C&8P(?6[A67F-&P00=;]@g=;^-AN.aT.ad^b=(^IJO[C0NIU:@?T
?3>7J:86eR.+adbYTHc:-AZ,a__QUI4@A)IR9S1&=@9Jg4L6IbAPF:829eG640=7
-H22W/6#>RAQ./^AMU54@[WQ)PB;<I&5^22GR<40N&]Y5]C>B]eDCPLG=I7OY_Ma
W3VLfA4M=cZHV,9,&-b;1Dg0U2>((DRS&bPS4BAH5PE#F,:_fcKUH[C#AXQg3(9[
CXWW+agNZCC_J?g,?IP2\#-FgM(PW+/,\H+7Lcb_gS=.U==GIG,^#HB=aJ9FW;^R
a(Rd>7UX#5C-[T<;.LQ?7\aJ<27]KQ4FL1)[^)BDY<@Q.f<g9]P4QI8Qc+b_)L2V
J76V91.T]cO;YE=A&F80/f9gU[T]_d(:7\bg5\c#<<cW02Be9F5EcX)>4P#c_9TK
9FD,a_)B2G(HR,>I&&I</g5)2^_Ae:M8Z.<2eKN\9GWBGL+<Q@J-U,EZ>T[+PHBV
NB6DX/17(SXd_1,,TN243I&##\J79W]_@KQDT^(5ac9YKd@@.Z4b+(\Y8LY0AKeO
V7e,6eZN3Ia?=.A,4dV.?@fL7[90WQJ@B6BV3TH2A=O?DZ4K.I--@I=8E36;D8^B
/dea?<,MCDGHQ9ZJ3IaND1JE3GW,6CD,-B@A==T+@ScV\N9OB4C59d)+?XDaLRI)
Z.XCTV9S>FN^(5EBaCD..b#J^K6(2B+c??48+J).L:+CgEXOUKSY26J&ff9Me4UN
adCVAS15?#A8faFd7Db:^?NHL@WS-<[6Dg1WN3B3V\++@PTHeU9>^K<AZO?eKR&0
ed#cYR,^_/Uc=#E)d8LKGO+^BA3YL_e[CcPVKC/GXaefL(,6cddEC7[MS4_<6@W#
71I;Od.OGLGO:]&K>-+-7F>]UKIKX:-;&XGXQ@2MBMD0@Y6@F_fI:gLA61,IPQIO
^e-KJ)0AP;CJE@H8+5VYOF=X6a^]^QOY&]1/R#53M:f[W&M0e<4HUVe6>.9b-)7<
b^_:#NUKVMeFf\#.8(/ed6ECCA3-R4X#,bXK/a-P1dbgN0Qd?4+&+.YN<ENV&+I1
f(;/>,7+5.(f):c,W(b:W_WM1I@M[B(Kc[:H6d[WQ:N9K:2RY^FSR<F]MC,#<e^B
<g:V9ILTZ+XXF@Z,;46b0PFb#SY)9JI8O;G#D<6:R5^8FH-I.TY<J[UW5?XbK6VJ
g7I4F@NfF=\YO9-V)U.?2.P2ce\8ESQ<b_g@,#+N[(DYF<J1BH5XFbd7MZW7>Qf1
dR)Md;O.E,dJ/afI9S(:LDHB+KfPEE_.^FXM>7Ga4<f/(-O[Q=J@gQJ,C+?M)J\/
H_[Y9E5ND&b1-^9#JES;)DXdQD0EF.<XC0GZ^LOXMZeJ&_baEOW0OQ/.41Tb1CAG
#_YG>=,&C9IQ=JDRPE;5UBGUe>>LJ\PJ5EWg,;Tc.LF@R-,g#?G&SFBI;V5;;IG.
fE4)b=,#f;:J;B=;DFM6Y7W>I65J=L.J>HHE3IQG6)5EaQ+>/6?W?ZCMXFYPV0VR
bH9A]7dgX\^EQC?P#/&>U?Y.IBU@8EYOC1^HQ)<7A4M+fHXPG.4>7F&UUDf:1g6+
FcP@@b3IH3>GcKORE#PKG]\a]FbcVS^T5VT2^9;5WP97G+W.CF>NO\e]])d\bGJ9
N/-gYZ2b?:8O9=D)1^#/77J=X6ZYBZ6MHV6gddQbHHY4c3HL:3R4:=>=LR^?)[Og
#_9.YK822;\?:;3[=cgF:@->JQVS/7Q=GI#/G4#H53A/c@,6Hf3ET57)Tc4UI)NF
,7_f1UaM9@[,82_&DBE3c47V>K5N[+#A.A3YcB\g@D]D>JWU[a1eVg<Z>=HA<eeY
KT.8(Tf,SRF.8IR@PB,/&IJH?ag;f15]#V&-4dFM.?2a(QV?-2>:ZL2RG[YJCF=;
J_:N&g4D8R?^O31I&bG9g+4XUJ3HM\(>U#c8f8Q(1Y3@WE&]G-ELXe.UKcIYJ;bW
9OcDW-\B-[_FJac0_H9)GMINAVeFBC<3JgMDgP^a\/:CRQ#5[a]_]:U&(d\_)&(1
SF+,O?;^@PRdE?Wc9EgDE=A6+>[S^>eE#gYUOS+::Sb;O]&;.e3GQ8#N\=0g7@-:
Y1]_acKb.XJ^TbHTR,@c.SG&Ub8NI_VJJa73DWCb5?B4;XdcM+S_JGTXO(_6ZDJ(
@56)@PQ;2Mg3U85P+c@O?4JXd;REMJ/S&32V\:C>ZGW#(QI(G^)KTALQAZ[(eY.(
_[,CL]V2J#<S=+<@#-g69_Vb,#LDWa=:AKTT3@#U,(?7c7F]aNL,XZ72ea[_G^==
^2DSYAU#:[aRUPSZMM<X1C+6U#ae.62L:CCYcJVSU_,dcL?@I;B1>>FP:P3fWD3;
;QgENfc81/CbOK]3<-aQX;.@>e=11_T:RCREP3LGFW(cO4fdZ.SQ6KHaQ_&+63@Y
L)K#@6Ec>S0cR<]D+CaE9]8WGDYT:GSV@M@N9,1F3[\PU^.>4<aOUCV3:cdA<H>X
gNHD^G@X;c1\N_WPSW>,AQd+ORN]SKEVN<2>+=<_K(D,2^EM]OUe5M2GX<MG9df5
^T95/;X_G_:0&YVA39.J-CB53.0;W7dW_,;FdP5.P2^=Gd;\K?6Y)KN<&>>Uc&?a
aeR-+\.P_5b2-2a@^ZAcg\1@;PeZ9>K:B+[(d1O02VOZ.S?D&K=b/[BMDGLW(I<\
)7Y/^##H6<PXbRd6S8/]3ZN;ZZVb.G+@68CKXXCQRD7PcbTG9B2Sg+E^g,3ONO&c
80O(cfT@>4]>>.2UW&1?^MZYgX3(fRb4\fUV?XZ7cV795HJDSRWY?RI#86@8]0(X
)M<]0a&g-[_QFUd(>;1=S(Ja<S6(d)c[E0?^,4&ST5?3#^TU]EY\@<dcgORZQ_7/
^W2Q<T4.?#\EX(G^H7)aaQ(1S6..E.#<V(0PEgfPZ>9^@&D7W:<dHYT:@>@_&aF-
-V(AYX5Y>_/D+40[DNRCM\A4.BKZVN,9AD&YOMOMF;;>3ABE^\Iac82GWa&Q9V2U
IZ&D6W(Ae6?]X>?;aGF4^@<P31[54OUA7KfW]-.@\B/;9d-6IAgZLKHF]Z]458K\
(aCK<:a\/PWeaI.UA<Y5d#0.X(A9e+]#Q==c9+d5e5S7>I&8[S,I=;9J;Y[=+4KI
]E];+N5f3B-=ZePULVWI1=YFI(3,Ld;4W,^=;VJ=9N9JHWJIT4ef[3U;Y1N1X-fT
bJ8ELD,,EY18(\7WcS6HaD4_eB=dgQ#+1)I.X^a2)(BWCEQc^>Q#Q7/fF2/e8>Ie
XNK^YBLW-a)#693R9DVH3cdJ1[g)&=D]1=-QA@5V#1V&K@eS[]MW,GXV0121G7IC
[/DXg6PTFUNDR(P/&3_AAa6-d1KbVbPJ.<F7#DBYbDBX0=),GMAbZc5X&U45BVg7
.=>9D(J.>V<8eO#0YZ9/_X^H5deS<LM^^?+::3\L:5De/:SVN2X]\?ggIY(J8\ga
<CCNB<EU>(@5M0E(8+B\ZNUC852Q;AOTdd_<W3>--QXTf;T;IZG3;9AFKG?#FYNK
La?>e3Z2e@e#0?GC;NB].FTY@O#T;e9OAO:^SMA/P<>]g>&/1//=[IF2:Ae@EVYg
/EB.bP0#QDOKHJ)5M39;]S,VPc^=BO=7ZU6a<V)[9:->T,J21Laf:]R@U<(/B7&/
51&7R;:@]c/=&T&b^^HB;g(95JK4[^3Ceg3a<7VG+GOa+:Nc2[=aU+.D&AV[ZDGA
NME4D/&?IU1aG=]d+\,<I_Z]8^)]3&:3(aY:29[.TR9fYNAY@6B9.FFPSF?#9Q/>
D=,142G?B<5)K8+#Z@;3V1[-K(Y?CBQ(QWODOY/8Hf\>C=4D;])&WUW;cJF&7^,/
B_R\9S]JQO-CC<HV-@4J#3YJ/KV(I0Q8a/YMEEY29#Ef#,fAUb^/:R#1@Oa01d8V
2.;8Y^)6EZVBc<da:J,?C0,.EN<:FYNX74P(QBea39baCRdP65c_CUA/D8F5(&B-
:Q=N0+W^U>B(=;5^.(SUU)6R5ERYF_ELGgA,Y1#<7[>(?KTR../geWVacIJDc>HI
Z_&1YIg](_Lg4Y\M@LHVXTUF8X/O(EPWWPY>9P,EIf#M>Z;[>VX=2/SPC-ZZ-B?^
>HfB4PC>;d87;7+2^F:QfGL>RKF.BX19AA?.HeS7J0,@<0@GQ=6=R;FSWA7Fd4bU
(9^G,UO_;1gIfU3CMV3b?I?KfX]C:]UMW6)+PAL=N>2?b>J&<TfE.bdT_K#WUGZN
4)+ST)ddgYbQ,,P1V_3?cO@RdE.@@F_T9W9Y(AMY.L&GMS;#GQ_K/V&\.=GA[PAg
b:<HR@feXJ<4UB[&]8.d>FPPM.-RQcBGI/+c2ADJK[dNZ-1(4JffUNT?N\,ge0#)
N@RKI&E((2PKS72&bHA_bbV8ZNJfW&UTbR;Bf)EQEV[Q(a4Y;^^N?5HHO@M51XcF
/ZQ-@/;=eT_V0T@Y\Z^;;J?Pa&I9@GA[T/PWULP5f2]#]7/2^Y:<5)Te\eeR\UZ;
.HTWOS[LPBO=7ONf+V25<P[YTe62#]bJMFG)I[d#(C#]?bZ63TL#=.=^&ILE/(U^
@S1\3]@P^Z7X2e9?<W;g]WF@31,AX+a0I]U5a?-Yg@Za8..1McIDR4(B>9HR^5H_
2H&:MH9QQ4.K/BfS)#FNH]67_bc7]Fc#CMQK2:KWI4,HL7#622@LN4C5;7;-fXf.
4^SBd8DZbL-C;J3^F89@B-eTHgaaa3abaIJeK5>2>)g-&-2@J2B=FBDYa+;-(ZC+
6]IALcgDMJgG4eY>KM,V;8)Tb,1)Q(D?L5SSgCMY028aGK<_Sf0E.XX(<^<UeG&H
AMcE3=bVQfObJ:2b)ZJcd2L-gTeKFQ47ANcaG[cI.]._HD6BD)6LU3+8WaY9LWM#
VIV00]Z:bff:=NU7?=(O6PbW<+Gb3)I5-2Pgc\I^C=]e^Q/9P;RSP@4#7=E45R.a
Y[:<DX&:VZK7/V0\_1fJBSS(3HX1LJXXD.5RRZI.Y>aQ[_K3WQV5-/@.M.V7Ee@G
&U#Ag>FMNJ<U:Kg4.#CWP]=G].Jc@-Qc/4<ba;V5K=QL/V_H]@SF0JQeDJ_Za,<R
TaG;f\08W4;[&Ib;46ZO>(Jc,;^-2QX,Y.F^eNI0CY_O:.SU&.DbW6GH7X)+#eR&
_0gOZAYR_P+:eEIZG18C3Z,)_Z7YBZ7]YP,WGG6BO&J=\0CT30#=02;e@YfG_S4&
UKV(c?7-J\],8HO7gAWS,[\G>29BTU:SP3Q5VE,a,+c>)964QT8[>2=.BUL+P?^]
91+<=_&&ZYP,CL;?WNOU5IH,YM@1@e\BK;I4@F3/16\(@;Y6g:>-d0_F?U908GM7
2]3XEP2UXf,?<7^QgEOc55Wd+0eP,HT?641]C)]OTB/ee6L#-;@fKfVfLW1.M0,]
83A[/[A<K0a9R7O:GGMD?W=V1#LQ[a><ZT&ga^&;LX7#.#2U0M\cNB8_3P(Z/I+)
_>f@9],1A1bF#4VAF]XN>+d(dQ8BE5W6=X2^+MUV<NJH/_><c^D<3O;M;^,<\][6
Y>O7M,<C=NZ?AR;],,6I9EGOEZ&:DM6(#fE[V8T#86Be=gG+3_e5(4>&IcWTD?B/
OW<YNNdBWV:dDb\cX(-6bI]S.Id8aV/&=bC8C9@>8RTKYS^VN)B2>f1?A.PAE?2(
L]EYeE67L7)^EU2X19J2IZLXO#?90C&;d0dB>O0gS^bQg1;--M5=G?K,H7/<R:N-
]AD]C[;T^6#NM2GB+gG-dEcb#BU0Wc0PZ/R2)(g0Q:[8>RZ^dJ+bgZ1[IJV/M6&Q
#0bEJ>0c@8PZfRa4JRd#4AI8aa7UUF/9Y<\]6edA6D#I-\;4EC?HcaKX&fc_Y#WJ
_&AC6Y4@cZ>bH-d1J0:JLXJb[F9<G/X=d>Vg/G10F5gJD_K:ccK/Q__8dbRMA&30
?GV\1,7]>a_K1R;6_5&c@C#VC#WRR8AAg>JYL&\d^LD8EV;KN-+X>BBVKRd.>S4d
ZF\=Q+gEGLa/NVUT^ARdL-SVL<Ua.dG,JA[fR>+)Yc?@GEGKFT<231R3LI1QGCL>
B8<Ng<:-NXG]>Da3PE-1V4W/bRD_8PJb6U=[R?/+J^599JUSNTD\2L(Df-FAO0;&
?3D3Ka.;K5\1aQ4A0+(2R:TC(84Of8[J]QG1EZUN<8GPW><Y-W+NTZ,d&d\Ff81@
[[cMJ;b+IE]]df.bT]1Q[^+H^5gSOe>9aU6WbSRdg-UH9-U3A&0W\>8cFCCdNT9X
Y[;Wb0XO&UJT</bMd<)CS3YHZaX=9-/b+)AFbOeP\N^d3T0+5=]ST3[2-9eKgX;P
,(ec2M<DY(/-/fcF/T4YS06_XNIdB8dBEN/S[c,F)O+0Q+3ea:-\@Cdc[<#:G&G5
g<J3CO3PIQK<V=1,N8fFX4bG^\#_dEVeN2a36/Oc67aBL0M<ZLTH]Sc@TGO0+EA4
>-32fg-F@)14KbbL0E?&-<;I^8R6BT1d9=gbcKJV^3F?3;D,1eN-2cWO@L3d?-]-
abZ9[MbaSM2T>V5\B8[gI<,aKaCb#N6YWX@A)g6N3N2D^39>2f?+ILFGba:T:>_G
);IW-GMLP-I8_@&F5?F54HGCN[31c(7XI98<e8[<JX)[\;437+fIc-1+]ZS66.\]
OLZDL11eRW=9I8FN#U+/-9F:(F352d;?c@X1[I._=?0T8ER2;FSQS:#A3\f?E5LP
,P^@PBPg:d<#(Q?D9^[S-/RKHRdG-@@\O<?@G2(+8CbK342gD^3d,b35D9TKUe)g
JX>fP;NdK@,UV6I@24F=,J^g)K2eb-1Af#HDSMD^5=BCgfYH66J8^[bbeP>7Sa,\
aD\a<5+QI2cB0Q]NJ&?gS.Me^d2<1aV_S3M;7I3LD#?U,f(b01D_E=<3AO(]f8gS
VBGC_&CV+7c+eVXNQ+]GfWcECYH>\H#bZ(A+L8Sd\Q][B3[,NI3L4K6<@\,&IHea
/eB?WD+EHRELU^/@=&^X4G5@=S?^+5,;97QT#2e?JM2MSFV6K?PfS?R+F/B0.6[e
3-+Z<.&9gIg12H+<DJL:2)7),IKGMf<A;,;N5G:OWJGHX)7Z=FGc3ACJ.2,P;f:9
&U=]<&J8[,Y;17dN#^TE_N+&KQEc@2R(YfRD,WNZM-TB>98XRG\&F33bR=^82Z;6
M;\D=QAf^QN\\LZOc=[:6I9DV?PP7SQaIKZOX88Od/>U/WMg,O@d2gV8Y2dVdE^4
08H_Sa3c2.XT3T)?I1TV3OI46;:PDA7_(>3Jg+WM?3^,Wbe;3VgR663-#8Q[0f/&
5:F1DPB>AXf).XdQ7aC1K4N^]P90#X]K]eeBdOVBKO;;D&/@9.S.1GFb=?IZ8X5O
SdfWG-J=@2(#-Y@L;CQRBd&_F#UB#3[[0977FR@^<ALgGIRRT0S/-S^dLX68]g-2
b&14_^,^7H,PG>)6X2fP(?d\K>^c3#T@WTF<G7SYIfY2a9I<P^NIdDZ(4GV39CHT
Y9-SK_Q6:D/]2(de/=9S/:K.@CH^I9[[XSL1YML;\)>IdMd[B24<Ma0NH,fK/W;G
1_IbL5CRQ&YMXaVc4/&a47\bD.M-W&(7(5d5/f3f=?U9GfR?/03a@?W]a#POXP;,
D;ZAA4Fe8WXVI;7bN19.;.;gGX&6Y<<J4T<EWGBHI;f9A;;bVe6GBH5<_bKK;gHg
dFc>B@eM88:VOHC^0aC_X?TM&-0?bV+2e&+0G>6TLb=>JYI4#070T^cgVE[C@D;e
F9G6EP#>dJ-83ceAC.N))?909\-NU#=:d>+S[b?bU45QHJ3C??Y?fI(cTRHC[0(g
Id.P8c](U2W;5N)(=DL]74PAdL9#Ha&9:a+G?;TM2c0f>W[#IIeN;?R<4+=Eg57,
d,,#Z(O:NTd/FWb<H,8Zb1+2G[b2Z/^3CA:HgSKJ0T2bJ0=22CD2I+6M+H<O;eLU
e;BcOEO#.<;)bL=Z77V>>@+AI6_?c9g-I\gGe2>A0:SKcdb/)#_aU7=OS#Cb=[>^
Mg,7fT@Q?R82g.f:,[e?-HCAI,TT9QX:DFf#G?XXHdE2DGfX1c.gceK3&^0AWZFF
&EaX5(VUeTS/KKK/2(N9_=;2^MSg49bT_fLLOR_GV^<29Z+G.G&V1KcC89-3cCb?
SR1P>&gZY=HZ64?89X]&YRED8+[A]WSOace8S<BbNdgZ)BF,@01SA)&FO+X?KUcB
1b&8aTeL71?<(,,4+]4CA3FCIA[Md&@O(7XK;aQ8.@KAWFfU?PC+1-SK7.f[M,L5
DYZ3f447LWY&S47>-Q+:E0g1Gc/]->f#(b3AZSCH)NZg[>VO#.TZb]LZeX)8Lc_,
ZI=7.NG.P79)WaVXU=C<&P5=J^YR6K9V.M)NBF=N@,39AdXY4@K6-<:5491g&P(Y
N[8dTE44ZQ3T<\2=L>9DYHZc6:TYGT29Fc>+-/I,20RgX=#f(ggc/B.]9aRf:Y16
@NC3d..e9G\3:Qd8EbX:AIaS\#V&FK;AGGR]dL0K4G2BW)SYa<LIU2>3_LZ,7IO2
OKCL(d7J,1VG2\R63H9__BM3)QM/_cSdVLa7/&S9ZVC]D(&_0_PJ5#:;+3;WM?K:
@7-DR1LfA:aDGUEI^?&(c:+79(LF&ST.@4X5f2>F6Od,-+43+eV]&@=5YM]Y.b5M
TDIL8C(G6VG4JRf&VU<;dZ[eFVJZWHcSXY\Yg/86cV(C=3M0b1OP_;[DAS)C6ea0
/@\@EZ]Z&gg1-b@R5=]W]e?0e>O[>/:,PS_5&IeTUf+N0G_/O&Fgb_<TgSBL[eL4
0;3_6D4/]8:YIQ^,6S#BP@5fN0>b[Z1?DT;T[5,<KG[7LZ9MfXFKJ)Q+Q.Q+YKN[
1FP,6g(_J54/Q>TR?CM[da74cV2A>&0)GVDYYX+BD-N-0>7(?Pg5/.D?V+PJOS?/
77]HOF>Sd?e>OE[@>eRE<6RQX#)3@BPOA5R4^_Y_EdTM+LEE;>Ic1)8@X@8C:S>4
Of/GaV,<7P^?I]RQEc/\\&G:#5AJK+##E@D6)K(/c]T@&A3ae)F\aZdZeF&AAW:+
e#6[@YWe>J]+?4eMVdc-.7LA]_7=K4Ef9.]aML@SRa&+D7WLEC8LdHL.RHG1;f2F
f)d\Da?@\Fc;a(2FG5\9ge9]V_KWg&\2Yb4RWOMNK/:4^=J)(f01GUE)V^<UBf.7
UL?Y&]Ig.7BK)b\>(FE@;b.UK0ReH.@.ZAE3YFAXZ,?3,W1IfNUe\UMOEKg^O(K)
dA>V1Z2Z#bWVFMAZ#S>Y7[K0<2YGRcL-OXNGV7EBaPI01XPTE)WNZQV#B56>UJNE
c+&MbC+]#X2aZORd+QRYgQ3S;P2OHIQ=:2UT<0_Y>?OgV&>S?\+HMBYe5bY[1.=N
;64HaT)24?S[A1,a+YC?a5?2&UZ5[3gMeGd_FJC>ED=ED@]#BD?c?6J&6]QcEU^G
9SaOc851A&8d&=)fe]:S4L2HD?6af(\SYGLZ5VYSUQINBQJbU@LVHFH&b>Q,53,D
G9R=g]HeC.LZ&7=cfK)PH8_3IgS-&Lb1F5WM(dF.^IC13A?>d[-/9LT4SK4@ZcO4
148f@ERQRP_GAGLM00@gL.]TO8M+8NJgW(gcL)\caUMWQO2C9@^IYR(1IcY3-O)\
-,g,87GGOXb[8H>AWYOVNF/\+=,=BdA,?MfI5JFFQ.Rfff05aYQAQ+W0)JW]UEQE
5e0Fe35LI86WGB.)7a\6MVPMZ?(98N<0?64@VaO;?9WXX8]eg,IEX@.E1)LO>]O=
.@9YNL(\eI<G6ZO?N53O<LGGMeeb?IB7D>>RVb]S-QC@aP0f2;BD+O;@(A-dOSAe
M0DDg.3<B,&cBN?4aC-J8AID/fC_e]H@+QGa&O];@[K1RJ?CU.eWcb2+RL1<&GIJ
F3S#.#RH>G/_BV8Vf(DFc_>J,RP,PI-Q>/S:@RfRb@_+?D^J#f?CTK66L9Vc8>#O
U(P3+d9PJZ>[#D[S.Q]8D6[28A>R8[S^ad?c70F>^HS#NC2UJM?Z_7;=&KP2,T_#
F9QD&HKXe?O+OcHP>ZD1[2ZC^(D[5]d3R&STb:gC05cR7.Z^f2K+bLY?d6</N_N6
?Cf@K/_FKK93[G2R5OHT3=]U=3FH8dF8:1YWMgR3\,-ff0XNg;_O8?a4<\=B.E=5
&S1XS\(c9cJ5E@3,FNgTP+M=[N4S,XX8YK^6/,T+\<d1Fb.VQ#I)RCVRK5aSDDGG
/MP4OZ-D[<6WJ-JU@@XE>GAA=.VY5\^>Re4Fb0YJ<(X(?JKIHOWG85aGQ#@DXb-E
:O.<3H6g-\X4PD6(+ee2^;d>=E9#K+8H.)_]?28gNEaVcGNA-]/#S604fB4OVdOA
2]..YfCb9RCQJ&V;SW8GO.(8+US-&//KQ\9N7(<GYF[V]#gCN)IQKAKIJ]]RGL/)
3;Q8H@:U5Q.B+0#c20GDfAbT<)f:e1+?fR_&?bTAgTQ5JW>GS<PRNS/H279cM(D#
aPSR64ZC)1EH)9^:-2BQ#V9DdMIe#9@BD_g9f5LeV7f\c#P>gFL3We9V89S)0W?5
SS-?2U35LSb#F2#fD,YHC.J08;N6ecJ5X/CZ@=BG&V5X7#/KS>(Zb8TZQD=f=JHO
K)K^(Q@B9;MX--0d:OVN;f5R]>)RAPEI?NP3^9bLg+Ce.Z9a:0Z?-S@#.L;OKYXZ
7V5JNY5E@IHCZZaE+UcOda8-_KE1MbgNRXFZ\W(X9Q,.a)2,&:EC7OT.=Oa(_Y:S
1#2\Wc];]H+Q.@)M(e@,f/&+C1W[M]+WN65f1-/-WJ=<ZF1UMDR8HMHH.GJGPB^d
8;56>A4.DW#2+&+bB?I;0Bgc(;Hc5_1,dHgdEW.G,,JZVXW4TGWb<DCU>C[7d3\g
27X[<WBKcPGgPYNdR>Z<3c>A2-F0G7QKNG<b^Q#D[O3aKLKQ\S9)eL4MC/2(-.//
dG\[X2C/D^]43<=3=W@#1^_.(KS8]99bf76V.AMZ;dMIR-U6QX^5gJ/;2K)4@UO?
H9K@gaaS0IZ,BBRa-2RR.[e>OEKCF45X:X@?)&,1+X?G)074BT@6/Pg>\R?\/d79
e[&7LEV>I9^90Y35fg)ZdDW7.4<=LQF<AMfIf9fA=U\DB[9f?XTPZ4X[-5;J2FZc
<F;YZX<2=S=Q@(fT/YUU,O8R-7/J<1cNCf<[c4PP790V[VAQ8PWJXM2;</19W+4]
S/+NTeIC;H)^.Z_YGBZ8B6H4>/+.H\G<M564_GEHF)KeVG<\;LW;:OFV:XfD=?Gd
FPd#a(<-E,]/0c1O+dCGNab0cbG):4)N<eM?GKb9-cJ=?f(LCT<9V8GI(ESFG#J;
Q&54]A1_6PBFB_72)FLDF[Y91YO2=a2^2_ZMMZFCXOb4.O)T1c2eF2PN0J@I9+?2
N=TI0AdFf4O,<WZ61Ec&J0a,0/\&V4P<d963(JPP8Yg3#AHW^AIN]ND>+QBdH)K)
bD6R@/Pa4WPTFEB18De#U4MK>XJW3?.M\<_4A9D?,:BL3>+fRgSLgD34ZgMGR7M&
\:SH/+?39DSe)TdO3H,G#:9Xf4E=AWHSg/)3PR6Y]U8bZ1L(?f(g[XQ<[Ob4R6;&
M@7g;(>A1LbMCEZ85N\fNg(<^b1c8UC+?TA-B^(+.=/#P0+\OBWU8a.]b]9O7A21
S:56#ZcAgNJW\Q=M7c@1@8R2=&WTg8ZId.VB.T/E8H>X\@1>4&1RJ[<GIIG0COO\
TI2WUJW\#BQ.^0:^--\DA_<B?g,DSa/gbEc(4:bWWIZJ<564,Y61.,4F^+aM7D&4
:4Q]T@f@]<EC:HO\[[><,7DT;(/Wfe/f\JIaDH;)9/4>399ZZ>]D5F?Q;#(#WYHY
=I0c3=64K2?CKLFfS_CN)0MC8>VB?EVU(E#L\T&Z^b>N>_92+:O)9cG)8/[.E0dY
H,a[7YBaFgF(KE8_XKgX0^aM+5fbV7-8\;]FH[POH0&:3DQ/EBcDO)X.]63IIC1c
cZ][5RGg(T?D;[JU2]@DN35:gLbe#9,6g<S7Bg6;#D;POb;fMYVZ\5Rd/07-#+\a
J.Q7E5LKKfM0L9=Pc?ZgL^75T#Z@gTQfJdKN#P:Q\EO[XUdP4b.?DcDB7a2-f.[F
S;_K9e@DAX>_SL.)91e9GYNIb8.59BI9<Q@.=X\9gbUVS.aR0d#.G]LbEg(/-F7?
B&P8;6LZR-XH)W[>(ffWSM<+#O,fO^HZ>^<I@1S#+d/Z<O;7Yc)8e60;#::<A57Z
8Z)(H4:=N4#a/6JV1Q/Q&W@2==MGAaRI2O;:BWW:.=#=6__e;fV/EW4)[EdD>5T>
#Z<\SL:QGVH.gVA[b2fVX_:04CTQLF9Ve2X2VLdgNCFT(F.C&G#dN]2(93X4^M7,
&5Xd>EJ((GU=X/DOJFc=8gGR7a@3LYA:A;:1M)T+7TSOA,JLebWXCL]8),=M.Lf)
@:4e_I<;<gHg=@4BZSCV-beU1&Q.c5c?9=>]0Q_](]M)QJ?]A4eOc<aW@&TH,O:-
J32MY@67#B1>LF\D+3)5F#-Ha,X5_C7&<CGZS>;UD-:JPdTMQHI;7[abDO6451Sf
SG/=U&=3A(DVfUBHJH@-S-3_Og/ZC&U)XB_WNR98073POG?=[6PM#-e9]S-d>3c<
CE[COgH/G+-0?ECSY5N^89O1eOVT&T@2\CGT8.6gPO[=I;_efNTEP2@A0.OBEg^,
7W;QDSW[8QZU/EABeg[XU6(MR)(dYFY6g(]DU8.I#(HN8W]&G&gAOJ1#Z3+S<HJ8
ePPQfHcXP>V+VHLS-3\)4G5C9-F,/?.8FJ&/XeNSTVK(W^4K/H6\:L_M8d(?FV=d
3[VR_\>Q9(&G&,eZEeZ6?]<CH&CS10UX)K-eIRd=^X=GU&<_FW;fgH.#fO)Qg_,@
S54/RKD=KMLFUOV@M9QM)(cS&U@DUP62DGSSE9Eb-OJ2X3K=JeVcO4L(Z>PX&(5R
1g7X\:HfT+CXe+UM/O8[]<=^__A0CcH7>F,X4#E13>)_U(VPT60T-0G,8eO[>edG
AXc@OY]GY+5P,b;.<Tef^M\B5GMUEN1=&]Z(feX7N])_=>EXX@93[@7=dL<G.MfE
ZcbO6<gQ@<:aDPNS?cfW;M1Q<B)OeKB&dX&>efF1-g/#^7;_E\,CB&/GMe>F,aaR
>ZO9L@I\,YE@IGb-DTU@fQ7BXKN5=d2eJI5D@YAR<AXPXf^0JEL)]YQ>5ZC^dU[c
dd4W-#-eGI<58=V(Bc_EAIUN^&9+,9A?0NI_B(E,,?e<4:09\UFfX8HQ;MTFL8F3
:d6b4A;a:LG7#e;27N5gD;82V)[>eWH=D3U_XZ^=#NaS&MWGa2(-\PE[b:>Y;0EB
c>;+^GQ=D4&T<:,&V7gAP<5B\T53G93AE8EKN9_d4M8;;D34Z;AKZJF?LJ,a7Qf5
5:Y1J>+VT1E?ND5\69:@T7&8K-8gD0.S[_DaB\@06VZTNZ#d_(c[S2fK:d.)>?OJ
W2d#C]bY2SHH)2>CAeE9d>4GPFG\d;/S<J=:\>FIB?2RbZE@U[61VcQU82^U^QJ(
eA<_L:?;1-J8-K]AbHI^K(>T8_&B6]QWV]L5IQC[GD-^@Y/DT,XaFRUgKcJW^Z\5
#E47454LR=&<Ad/[Z@41g(#2aGYXYg+<8+d#1Ta7,7?ODI=[KBZ\.X.D4fR59dFB
+b3BP1IPG./LdK+9]PHb4.0g9g@MfVH:cR##WS,SH>PJ[?&eW13[Ua4HFB(2Uda9
#;>?;3FJLCFJK6=MOR6@^F99OGTGMV)Rf-7E4>FYWMW:af6QF43;[?/F2NB.5OXK
EDRN>a\J>_?^@CJ)I^feGe3B[\/?KEb:XP\-UA9)WMCPCa\Bd?(=e<UV]W^-Z9;M
<&dV?4SPgR>NWOc^c8-11c#gcfBJA28eJ6P6:NNb_We1aP96GAGfK5;1-Uf:/bE&
#0JBa2TOTN2A@0&G@@#0_;e<gXN6N\PUM7V/I-.RL9?CI?+]?Q6659CB):bX,e-:
aM=Tf8ff1HDLdHP0g2ILF/XMQB7=@H1a(cA]0dc?_We&+_D.dS2G0f@c[/@I,bZR
:;8ALe5U7,eLd6M4J1bM#-,)aa2N>46SPLTTLI2;+<LSeReU:/&]B#,KT?3[VYCU
;Be_S<?BK(A<D_3,8b<X<&9P/d^S=M//6:^4M\;CX>a&NVG.N?K3GG2ZN6_M8RNH
H&O=H5Q,gFI-6WN4.XF;_16ReF#T<LV>):VJAA-]V2_69-1c4+T,/#3dVJQ9.]I0
&>,N?dF\7C,+=?7Z\IWRDDPGEC_11Nd;X@KaN+:0eVA\CVaKaB3=/>3dJ$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_MX25L_PARALLEL_AC_CONFIGURATION_SV
