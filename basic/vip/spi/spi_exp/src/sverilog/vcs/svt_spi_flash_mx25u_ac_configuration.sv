
`ifndef GUARD_SVT_SPI_FLASH_MX25U_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MX25U_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Macronix MX25U device family.
 */
class svt_spi_flash_mx25u_ac_configuration extends svt_configuration;

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
   * Minimum Clock High pulse width duration.
   */ 
  real tCH_ns[];

  /**
   * Minimum Clock Low pulse width duration.
   */ 
  real tCL_ns[];

  /**
   * Minimum Clock period/Highest Freq support.
   */ 
  real tCLK_ns[];

  /**
   * Minimum Clock period/Highest Freq support for Fast READ Command (SPI) command
   */ 
  real tCLK_Fast_Read_ns[];

  /**
   * Minimum Clock period/Highest Freq support for Fast READ Dual Output command 
   */ 
  real tCLK_Fast_Read_DUAL_OUTPUT_ns[];

  /**
   * Minimum Clock period/Highest Freq support for Fast READ Dual IO command 
   */ 
  real tCLK_Fast_Read_DUAL_IO_ns[];

  /**
   * Minimum Clock period/Highest Freq support for Fast READ QUAD Output command 
   */ 
  real tCLK_Fast_Read_QUAD_OUTPUT_ns[];

  /**
   * Minimum Clock period/Highest Freq support for Fast READ QUAD IO command 
   */ 
  real tCLK_Fast_Read_QUAD_IO_ns[];

  /**
   * Minimum Clock period/Highest Freq support for AUTOBOOT 
   */ 
  real tCLK_AutoBoot_ns[];

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
  `svt_vmm_data_new(svt_spi_flash_mx25u_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_mx25u_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mx25u_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mx25u_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_mx25u_ac_configuration.
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
  `vmm_typename(svt_spi_flash_mx25u_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mx25u_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
]B]PfZ:VICc<I,D:9WI[YY89KfDXU?9NI_@NeeK9NQPTIQR.RAcg5)+C;Z[bZLL1
F#:cXCSFd@>>AALGP8^@I+;fYKY[&N.0EUaX6TX;6HIcIGZ3]fJYd9/18HD[0+[L
N2-;FFU:1Z->;T-GP_FA(VC6@B<@aX#,T>-OIC\I3\[(^\7#SJ<Z-H;C)5bDD(NM
Ld?#FgML\.bf>>H/AM)NSVgH[#T\+=R17fEX2H+:ded0?<\5\9J3IKdOVH@B<+Db
ME:V)9]J.=ETH/gMM2(2DWc[1Y?BM-5BYHfJ,_&2Z/[fX60/BZ9TSWfO]5LNAL/]
O6NL=EZ=<IcaB1;0DcWd2ZO7)9&c6^0X@(L65M4-;cH#;AMF.XJZ>^/9X#H8NB.f
eC0.6Ga@UO_WG(WBS/6@^;<&[3@G1K0c)3bFGd;UFO5bP60_X@gV7Z>4LQJ#eH8f
B?WZ/@52f)\Rc1UYZX9[VgSgX^W65I4W2B1(:b?:T&KXJ8aJKVH>QB+&OD,SEbb3
2C?.Q;?-(E.CXLS,AON5HH8fc=:M:<TK=YO0>I[8S(dK@.YMQT;8H(VdEHA)HURS
Z1BPS.H[687aY)3\(U_U)T>8L>G>Cb?5cD8Z_3bN4KJ)SAE?/MafId:C8L@+)Y)B
A2S5LT)M:]LA=2I[,aEKWcTBG7)#RBLK,\M4TWE4MF:BL&J=3aYb.@W-6J;/04]J
#b=8:1CQ3[<E@VS)<aOM)A,9B(-VX6bIR+]cJI)OF1)D7HKD-PYGD,,);41=?#/YU$
`endprotected


//vcs_vip_protect
`protected
[ED2g+?FVXK5CYUX?&>W=RGQbQSP5Q3T0+eF;dJ)R-g4.87QZ/ZD-(a#)Db6J2KT
J\?S,O_8R.[dC=A\R,VXBW6KTY5OYM[f=>RNV2N5,QJLWLQKIMdb0#7G+/0\YP:S
RAQ].M4aB:1d9bVGVJ8\b7_J<7T^BNM&^BQ\F41=J6#^H:&DB/Z=(<eW<d+Z7M1d
>X7g2#W:(fJKPTOCWfQWCEW5=Ug?<7,JHD+B\6ZC,_END@If:&Q89<f;B7C9g<./
D_f)HR_\V(L>+->FWERB?1<?c&EL:@c3H=8e+&]G0J[^LTC,O3e&3g1T/A>NBNLg
Q@\BcV\X1O1)I[>DZ?+T=d(aX1H\aZ68_CN#MR\??V/.c+&J/ERUN?#_&?Re#M/C
8XN3ZJdAaZMFbMX6MW8eF5T_eS+LGHGXC@[#]MC6I84\R6&Y1GgD;/T)X1#;[X)+
MG@]<2TFL?;Y,/G&^d);g\UWa=K.g[6UV-R]1ERZIC8],UH+d0?=Lg^6&A+(a2OV
[<;.PR^/7E<R=#Qc#;N0bK6aPDPS<5ER:G=_X8Q\M0D<eOPCJ/@bI9bTI]Zf:gU5
Y1(-Q\0_\<1#2:P/>#_V5:5?f)#bXCZ_Mg-Z8YZ<)<E,[[@#__.+@FN#[-UHF6ed
dK3g_K1VeF(<G;0,Z:N@A<^Fb))=X]M46ER?_b9@<[CU2N/G:B)B>2=?BeYd(De1
/=6bb2Z>eP7\L?MHJ6+X/H0=]_Gf6JAePb(EC.A?NUJ^?F1SABN>:2eC\Dg(#R?-
WQYG=,407JT;W/Pd)^W]>D4UDK+=:83;NQV#F[:X#M^::XUDQA.P[UaDKFKcaOe:
>B<JY8e5+ffO+<2PTY6N?d5?1bSJ>YBFHIA]XbB,W50SWX._2e#H<SJLC+,63dbL
OfODM^;(M3APT_^C(5@ZSTLCO0bCQRa_6_K^+QF4&e;/HE>[9W27^Z-:ELN8P.G#
9((<fBV^C[U6d6D0?c^FfMZ5#=^J6T>E+C5eIDM<::S==dVZg)IRZQU)D(F3f^>?
b7PXP#5WDH+/?;/^G4K,8>[0^@8K\d>-1VT93&/Z86GPGe3WTZ#0@3J&NN]-^6V_
GK/3dNGKM=eE/:VUL>1^&[BT?(0CSL99\F>(1BeE]BH+d9C2Q1^S4RcJCHBA32GY
(d;2K\LZYX>J0Be-=3#R9d[6f(+?<]YYVd#Ka=_&e&>Y@a1cLRANb&CK@&OPQ_f:
;ce+;3#6R>GIF3X+H97O+Y69)b27;V:a#R-(8?I?b>8E-5\3Lb?gO(S6ga\9(5QQ
<c<5RW0V=L7;bf#D0;W4&d>EHH[[LCU^+#^K_YfNHP0FbY=5NQO2+e#Cb@bG?S.4
g=.FgAegL79M<c8M+6RC(O,WHO=Md:?<BcO5b#J9g0H-3+-6-:3Ya@edZ>)<E7A0
/3SJfC?(2Xa[)\]K6Q4G[+#?H:9R#Ge;URCOMG14MLDHB=fOc^,NLJa#M)L>0Sa1
FBM#/:./K7F<\7e<KM0M9CG[0E/&_I4C5^_NZE?]P?VN(@Lba+\B#2gfU>KD(DL=
7)C]XQH/2RSdD5A&,A4L0+^HJ@(W9E1;:3:dY[4:_F&94[4LT/>3THL3N_3[,&#(
36-[SeJgWBfGWBFfSQSW\3<06T<95D#0F]PZcHa-8/9.4,beP_KU\XTHI(CUK<f0
KZZBRWA_dJe+I2\g6^bQg3Q\EAMb-_.PNV5&]0BQ.=JK^8O#c5VGe(Pd#5KS=fPa
RFPeZUM2L=3QRHC_3E4DD]@&V/B06=6):K3.g6JUZcc,30Z^5]2+PCS+e6dN^aTN
@+A]]d?Sg@QY(9Q@#gc6X[LUfAG6dRJPJ8C8N=C9]^<K^GCGBZZZDSg5a?1V/^;R
Zd\(Eg#\6UEFJUJHdceeYDZ3:a&Jg77=d(WG[&IU[T;[gA/3:7I2&eHWaPDG/f(3
_M5cCBdR?2HF=Q-,.c[aL#6H8RB@K=Ke0J52Z;_Q3E(^B4O:Z&g21UM2ICd@T^NQ
1B0eK[Jfa#Z#Z3_<=Z^+B3cN(7/I6gK.MJf)?Lgg#&EJAdLd]CUbE95J/Y8cYa9-
#6T38ZI&@@;YA)ZdbM[RM1dMBGSSNe1DeCW-Q<8Q##?<C4->6(9HSbgM10;6;SG;
2;PXDS@;O?S]S?a)G9CbB4REgM2O#78ZU>[A5QO>=,&A>ST,3-)E[MOZ:3AY0E,\
8gW0Wf<5N#/7DMCE)GeBSId72TdXe-[1=;?&G8G,4.#2A;7deR_F22,/E/^/YE4<
.A70ZSTgdWQ#b2-UCce):M\>Q9#5,UALYFL8H\Y77PSFb/<CL7INcF^XcD=g4B#6
5G@YTK)1^-:MbLMf&Q4WN=<W)^>W9JBE[#)]WQebXXX>NMgNa7S.<ee3WHF_2CJ4
^\.ID?gdO#PFLD\d;GC<5bV=ZadBH?TT;aEW+6Y\[^@7OUO+fLb3W0NgKV1H_\9)
WQc6a+]I6;\CR;d61F=MM3ELKfR@6^(RcMBFAF::cOU&IbeU1IB=0dNT:A-+0\1R
<GXa4G+D(0VSR+aHeH/Y=\()<A\ee?d4E4E>18ePCCVg]\V,&V@Y&&aWA.7eGfZN
M<8=Ra?g5=,K&7AO#]2=_X<>TD)FN=#Yb?NL/,S>04TPWF#:B<_G6.C4M<AU\ZEF
4D@7#IcPMdAe5Y9]XC(5<@V4@@QLQdN]f15[M0DBN7dff4PF<E<_)3:7YS&MW3&W
LB1dS/]]POCR=WUNYYG=+e1/RYR.O9D3D^6>H\;/4I>((Xc[EY=P9PNbH92;/e<K
4[6&Yd9KYDC<dQMg(9&BE2GW(Z+bR]-HC[R?G=5&NY0fJN6QT6E72C[COOO@OD4T
7&P>]/YU_4;W+aSCD]BE&_;72&Jb)/1:W/dV@L6H>HLgJbRH3[+X=g#2a0.V362\
@I#d@#dK\Q0.QO\R?4Vf?0ACDeEd]e;L]MP^,W91L^VHB6G)-a(YeHg@W=VQW^&H
d7+>MFA3.?P+eb3=d3,M.:C=:ZYNb\T^SI@B&)U59;0(Kc@Q0XSaaWZ6(PO[A^bD
B1FE^9>3#d=dK+T+#ODf>UTP7:;XfCR7R+;(e=;[dIBOC@4#B8Q/7FZH9^(R#>RQ
gcERLS2Q,G#AfFBH20^01<JLG]3D3TbPWDDAHA_beC?YS9Q=bURdb)EP^I6:>1&=
G]\9+KZ1(^=RcJ9#:B^b64MMLB0V_4=Q>X0@c_V,C)e5AD)WH,BD]9D<[#gVcJQ)
RaI4>2NHdH>S#\=/SSU?KJca5O2RW>?PL1\_;;=gRS<C@D93>EQb,;WbG8.HH5,S
&GF09D8E^LY,[#4VgLV[_I3VPM=OOWFGG0=AF#:FON[\]LENTD?4,7G=_Ha>TQJR
.e=_W-6Mc,7S36(<#XedYS9\R/A/BF(4[\F83BHJ+^#:5<(S:Q@fgQ3B3-/=5T4\
BWVD<:([(LAI;\C[4K0]08,579S^RVH_#JM<b.3=9B#F.+MQ07eHa<YKZRVV+T01
QPd5QeL\a_JaPO1C6R@?_HU-Jga/&bfW(,J7Z7Md[AU42a;gBd?)7Fg(]W-80UR;
04&>2BQdgc>@XCaEf&A)=ZAS]+CF^UPK(]OQ,gGG=eNLQ3WCPfc+\?BZcC>K_DU_
34gKE4I8UbMKGUV[WBHeF3/S9MLZM9#L+0/CMN1SC6)+E7VRGdSF0J=:F^U\a5LT
(3DS,Y<]adf@=/a5957NJX_9Z0Nb)LE,P:48UX\9YOG=?\_Sa\51F#c5>(E-_2R<
S4aES[32?:D]\AF/=/]0E1N=X5S>GN&U32H<7U0\V)/4QPQ7E@+cNE5K4Z)@RUE.
3QM3F\.c>bMPNLG\&.L+KQL:SJ;bVBc\7KR;Z9XG]B\c.#-OW]W&,TddY8f^56:,
)?1]3M.C\R61ddY_82^>Hb^,#)(T06:cRLN=3DYd8=>VfZ4R[40YXQfV3>UJT2?8
6cF@>SH4?AD.50OZ0+IC[<SCJ7d>,c;b6VGQFfU#,&5+8d(5f[d8T^K;=)5RKRbZ
HJ,I4>-gV=-dQ#7NZ2[F@)c(8G2&RO?_4Ke/M9Ub;92;16FJ4D])9V<aUf^W@_3=
&54;(ENMZ2L-LPd=NMA699+)fA#>BQR8\6^_;aabQ4KD,A>Q<O52M<Z3N;85^AV;
6[dJUGQAE#S]d^8JIF]S_M2F(-RGf[C#U_9>)PWW2c;4N8E8@P5<:_M:\2F.#W/C
B>9>;X7FSL5JS0W7=2<[>9Zd2_dD<L.-AK3>JGU6U6I;gW/A0#N^b7Ub-gFL_^S<
PgDVa^C24[R2B&TVSMR)O4:I._9\,U/gN&)[PfLO<3.PUMR/[_a]^=4EdO/\(4M?
g[3?WLdU-4G=R8S#8FGZF(H?7?WYUPL>NP/Cc<D1A9V1ef?[N;@JCe8.gfPb,4_8
()Q]/?,6RMUW_Mg?C=(2[FSf[J\KG4T,N2@=Kc:37,OIG9GML1<S0R98=QMY&L[2
KJTfI8D1>21DW4.8;4e@+ba+>&MVg8f:9P#QXRN,VY6>3.&+8/AH-HI,^>Hf=e&F
/Q+WbU7JK.7#YHGd[DM<6c:K>80fUXf;2[ZafL[DNca/MGE>&\#B4Z>WUF0>)c_^
,LKPFDR;EIg(bHY;c]^ObgA#6eOJW^F+_==,aPGT;7?#),WafMDV>#a=.6+8M:(W
;JRGEHVCY61LA[O<c<:NMb+HWTLIc>IQ5>H6VB6S/6L[>bE1N.EV3g,aA[]]7?>9
N1LaXF2<8:<+12G3KI605CNa]PgAX+2^3\B=NCLEgbFGc[?/E71.>_5\F\&;F-T;
gT/4c8O>RYeGG.>W<8/F]+<_&NKW>4,c-U:&RL5cLJD0>DU,QD-@5=X&dUI/&RVd
K<#7WEcX85@J;,=aXV@MD+X=0V-B>PV,28bS([)QQY&3QQQO(a<Wg(=(eeY^?]]?
;C.M/XFDI.Qg1OLJU>)/FK=&)E@<U:6T:LLMX/:\eR+]Z3M#CV/1O,gY8d(+fgTN
Pb0-RE(&WGI632(E9b&S[KKF^&)OS9E2E\H\OMZE7A&>Sa0eZ:?e+^RZA8R^Qe(@
RZC:&F\Y5X/]JL9@U9@S?2N^4<RO-G3g9#80<gT>QYZ4L^aL5.#S^_?K.S^2XM25
8e8<EB__VS]L4LWDVRP+Rd+,^TA1T)1XT_.=.Nb>KJ<?gLa7BB,:adA;WST4g9KH
^LIEEB=1__>K=8YX)8DT^>;&\YfdN@(LPaIOHKR3&COAX05<df&M];O#_(A/@<MQ
C?&83Ja-7>Y^SR+Q9<Ue-_Ba[g)Q.5_SCVK(.-H[LW1Y+55IZ/0<@B2#c^,XBN(&
>,S0c80TGK7c8eQA9U;>Q.^@RMO+fHMNO1;N#2g#dAI//I&PQHJD3Y(,.IY2P)M_
I\6^.]YY^_fX@&_6,-UW&6,L@9g<0GLQ:?OV]NfDWGJY=S=-8Sg)gY,bO>3SKYbE
QS1F89?LGU+=;RFAG?,eNO9Qd3\1JEe=8:R0J)M3Df[GQ=^@7W^;#HD1<4dF6&a9
2CWF(IdaZPN(D.S29R;26f/>-FK;@T)7T0)0VR[&.5&E21B55\gCSW<7eH-3&1D<
:;4-W3^6Cbbf?fD#L/2(K7(4F+J^LdN;V6),_;^=R3@>6X<_-0\M?A&<3WI)L;B3
d_#P1I+9U(277H5/IdVOg8)RBJKE^gX[&J>ZS?95)C,1Q\a=R1R?T=Z?V\&Na[T^
.SLDZL8>HN0OV(R+(DT)ZE(/()9/_0#O44If+SEZ+[J2=-\32+F)93XfFO=V?<M)
]ONCDaLP)>DAdW#1MD[.5ZZ6f/+c[c6SbUD^(-1#c<G@I6O7YIU0^]\X-/N#PWcK
VVR3H(g?&ReAg<bgcG4EX4TeT+6)S>55T(g)S-FTA>e,?0C3?2L?1\Y2;WCUJY?@
DY_KS(d6</gR(CMKU4MTO>U1)5-BNP>V]@f/d3>72S;d<5KM^M+d:7Kga51&e;cZ
aOJ->M+[^R#eTVKe@XV)-&/Mg<c1I#bab(Y:5#b4,bRT&:;NJ2\Y;VXPUG15-MOK
A1Bf0;^3>1g)(:(8E,_:^de>T2TB(JW02K:&R6YeabS4AP.b>f96H&Z>bVf@NQWe
\cI<0LIaM.+,>Q_9X#Hc_&]g;=RPQ<_T2gR3G9CMJ,#2?cQDP:BY66ZR2<\26)fZ
a2-a;d(4@#6c^REALN1ZP67-@01(0D]V3R)-FY]LSFKD=7;c/6..EY7Ae@3,HNT,
^94@_.FX>HR.-d9A@=)E^:X8I4)J/4gPF#U,ce[?KHRc8ES+KBdXQVL,Ra:EN53S
Y/EXM/G-.bPK[LSHeP5E;UY@H3D_2]PTI[=I7a?_Z8-+9676b)RaVC81PV;5dS+7
g71SdP+B@#/UJM,25P4c#VTPeZZ#NgL69;B,+eC0S&CS]c-aC<1)URW01gF.[aWO
[GcMc]A[[M:Yf8A#4T1R-]&+e?5gH&-876E)7Zg3H:ZX3(\0^JDVOCf8R(eK?5Qc
(G-&F;8+HBd8BQD:gEAQ^WU8bV.&W_AQg^FE7@1_>4B)12@eTed/7;DWaBELK>G(
L/1CH2)aKVA43[H.2&0>9DeQd#_.<c6+9P,I8C[C,]AW3CPbDHI7S:D(@2_7IL3P
4XO)GVCODa:028dUD,Ce#G+BHIK5JLWEQ54=-/OTQJ-P]P9NJEg\\OD32#d(NBKC
,b,M[ACTUXK5e3+c(YB/Q3dP^cX:I[Y>?O8NYHaA@CWTAIPgIN6#9IJDR/9Y(4H:
V+A(W&#Y_QF&\VZO-1D/LP1QaV2UA_6eZ)-U]=7R;dXL;.2#CB,Q>/5IP5LSY,N1
DF&+^WJZ5O6->#288A./)S8:_>BZ&g8ZcX>PKQ.P>3L^C05_^:Mf457V8G4e6,/E
d&?G1J9V;6^.O__JMTEPQH(UM<0?=Q&7H9[K;,;>cABS2eY8M58F;#9\6IPP+78b
8a80b1G\S.YCIOT#Z4Bg:?^-;VBEIAPN:AcC8F@2V22PZ\eO,/K0SMbBJO,C\+g0
BDD>^5PaLR]#<);OCGHCB#,,PfJMV+d1AXK<KYg<SeE+eFd@XDOX2(E8:82e/?C4
1(][6MY))].d5b.N;f>cO5TgKaCLVQX@gIDC-geXQ@40W[NF_6I3Y1]#eBO=8Q_6
)P54@-6<N&bbfSJ52LgO^\)@HF2PaW]Ba(H<5,L@&M]@AUZI+FK..aABCSLJ.aDW
/c0Y5D^4?<IdFH0g80]Cg4+S8SPfKcV3V^64\+@(C,>;D1+C<I:ALd+U6Z1?cP5O
[0N3SXY;?_5EB+AE0WfMd,2A7\d2].@F&)S:)_7/6A&e;N,QKJZYd&2]4K&W-6U&
-^69:Pa5RXL/4KT+,&7gF4UB=Z2LQ2Q=W;/;2^8IC\<W,F6bJCYD<R62Y#gY\W1E
WN>-]VOeKWa0f@46Ng4VYe2IgDP/#cgCV]L5K.VOJ5YNJ[>@BZ-DXF+Y0,J+f.JM
EIS)AIZEaE7;bJ3AJ[RJX<g<RAeQ-#NVcN:cLA7+Bg,?5dPFgL9D.U,:M6Ra>aL@
V?:THX2X.8AJC&cN#6L@&TaD;=+=&LF^J(ONK]Xg(4GO/>3c#e[bINM)VA9Y@Y<F
F\E/X,G-&e-7TD7;VCICAZ9UM3D9(P]4J==E=W(6&.WK;9N=+3ROX=a.691E?5ga
c\0Y_L(K<(O\@E.<8Pd1S1OA0Iab=R&@^S/bF?8?79:DeT)5?>\KQ9]MX^R0-N<5
7).,7ZKf_dPfUUI5?=RO6?ECIfaO]/gfDeRIc,Q+,d64_(Tb@+.UTdUbQO7FQUFQ
6?g8,O5?Q)G@]_IGA#:1DGKN=)1D-FgST^X;@.=#Xe]EgK]B,-#.B)6]^:=f.QDH
WO)[7>SYYc<>9BY1dXJMPB_+XQ7\,;\Fbe8<Qb6aV\=I[H::RWL;HJ)_?B7dOUJc
MGfN-V4Vfe)P.G6f0Y45]572:[(+9XYY^/P]S\M[YFfH9^H>O=L;\V0gR3NP3(?c
dAeg49SV\U6U_Yb;F_I@_ReL&(c9(Q-G_DGOMC8d+1Yc8\bFFR1,/5]JU5^[LVXS
;P0P&C3)PA2L1[:7.[_WII(<@C(3@0Y>\65T28;#_1@8I09:70&4QT+a#.bF-Ndb
P5,>O0dG,DCA>Ga8eABS2OC;17-?50CTcZ69(AHdM>TD;F/7+c,D.gQg)eGTQ:[)
AQQ^&.N&ODQ(L^WN1PPXOTK=9a95HZ_[N+0SX16I>G)E,H&@KUSXVH=1GKBM2-7M
W;EK,F-E]+8a/.U_2UY->afbP1NV.&.C1,6E3A]/30PX2+.Q]RSFZ#OEA3c^E0F2
dD#M6B[G/OC):^OIAc3@Q[>&RK&&)W7O1)YfP(GHL9P,Q4<3.;=1aYIfPJHHQHN^
0M#FYJIUMKNR6V0/;]bUP95)05;:B<W:V5/M\RU>J.5IV(&\3)6VCf&T./YO:;-F
I4e6X9M4&HCKP\<=<L12W.@;U,R#c\@\M+MOSA&BZ?1[Y)He=F2M@+DV\TD)d?Ce
@@/g.\+YU^_P9D=D<8fE60bdG@RWFM9?#+_,IV5:5T:ggfNN;YAGQT_Va3Db#Tb1
CDCUGbHD\ER(FP=LDEFC<d3FLa3>8)ReNCSJCfB43&@+#8G?>+=_:fOW?MAc6+J,
Mf<)Ff@G4_HgP-[M9=Y6C@1F3/,6\>^?HK9IT_<>E@^M=Xdb3-_b?9JfAMZYAYLP
VTOdSH5]QM)>d]eP0)XZGX\W6F1OR]W_a2P=1/;^G[>&Ue7=0UTcEJ?OB7RDAbdY
Y[JgGH.fNcQeSI&RP]d1S51.RR#[<KMG8T/MG4QcROHTU)WPW5Ye,.LYA819(Qc?
HS7YK)GG82OLW;[KNRf@NWe-4.S7YHg49X3,K)T8fg2gYd[gO]F:_UF&Q\c\DAXH
f(HD=DFC@.&f)((()D]CgaF:6366<F#7^#2a@Z\UH\[-_?5NVdd7Y2E8LTP,[BG_
G,P,7XUMeSgM&1H;9Y+a4+ICMY_AQg<2a05>:NHY^;9X#@[.MNeYb,gS]JX;VFQ[
Y@P/KH=OAX^N7@C;+XQ.26WZ#P^SGNQ_2b/?[D1e39c=I8c5g2+1-d1_W^gGf-P/
H=E@f,SE.#::eP=cLWbZ?WCeW7FC607F;\S6F;-(Ig\2a>Qc_gSZ<[=7OS9bDYSM
@M@72J\/]XH@R5TPL,[YfM5U:([f5fL@#)+BQ::[S/a:IXLC,G[DQPA&+[<.W3X)
YH4:.XAAa45B_PKe,F0+\S+9a=(]5a^3e@2Na8]HISF>,B?<CKK9_6ZRgGg?_&Ed
f?7B0KMC7N2H4E6/fN-5G80#YQAGN?VR(NGU+<)BEIdMYg2EAcY?E7FA1d&dOIJ3
,c>6^U,;DC)=U?I2FQcN>bNH.C<-=ZGE7g-CMW&MK5C[Lg&Y>:9Q]_>EN<LI5>J;
7bVICA9P6)@Y,73&F0#D<J\VBS2XgB2M?&e=K)1U4QN;198Y&>NOINC?ag3SEG&0
?.C\?:K4fc_-&=HDHI8^J;F)S;cd58,TQ(ceB)+cE^R^==S/X,DSXa?_MH(W3FBO
^T@(J>g618\TMg(N//[?.5FR:,W<dF0JeZL1YXNUXG#VL@F;\#KW+492/(fLE]J@
-^0(<\b_(,F+2<g5/C0IOa0ABFQWEGKXEc904@OA\#W]4(E^NQT.?22aG52H4fbU
>_1.]+gCGM]E4##L]>9)G3gP88d@::Yc1MS@g1R)6f4K@BfU&F:9^R/PfZ)C</),
@O+=&/JaPO42+_eC=>TT.d)@=5+\;BAb&5?@K01:P.XS1V=EXeX?]@(8XFWW)S#=
>\Y0CLUS8Z,I9L#Q.O=YA)a.[HF]]3SEWB2bF+:[=D8R[S+]E9;R]IMKNTAFAI+Z
J8#51.=gX+6VSK)^[gKU_EFLc^[1L9#JR.#YZIZ<:T,TD@JY^#443b=(0I[V-QDU
5X+P9]=e\K.5/@XUT;=6QN2B\=+:WQd#HGW8>(M;.8PJY-(>dWZ8#AQa<a=g)5GF
bA,:gg^S,G/JG^^U,1RW?8_3/R]6Le481::BZb2A1M.2_NIfQ>MJRQF;Q-c.^BR]
76\NdN&-cIM01e&a\fNU8J:9#ZOYHIAONN(#E(A&U[5<ML5c@O#1(_2fgM<_-E(A
R.]RMD-P[H(b+FM6+(GR2^YYd,>J[:2?3AMO(^b]3bE&:U&,:?cY=L0GeaQbQ^W5
5aT6J:F8_b58a#3]f.)#)6O.AWbeb:LL.6_CTS<b0,IaHYH#V3DCHT,X:XO86XD\
;AUgJ^YT851,O8+P@+<Y71TYRO+Ub#R([O\C=8&,X,(],QU<bB]5\[V/&,DN.XLd
]2+=C6Y\;J,?-EZcGY0[TI?(Q&;=?_]ZNX=@Y5Ib.F4<e2:Q;JD\/M61S3H6gLP4
?3@E&f(cg.WQK45TJ.9OR8OGQ+\I53>80;O#5Vcd[SM]S>5#H8-g,C,^^(X>54N[
R_;_[0_D<9K9D(+5DUWA;19IQ3--(]\L^J(CIc:YLS7PFB,Z)R[SNVRd]/FVM);L
:_J@6ZL(M1>>cE1BGWBQWS)@WU5<^4fER@e8JW=16&>+NBC_X@]70-AR-fJd2gb+
5NMUcR.VMY#_ZF)^@AKIcT_<cb\;R<H2NG:HA(RA6dfFC);5Oa.V3QWW,0\;KASQ
2P.^95Y8G6N;=@W&<4]CWRb^X.&G[EK-X:T0S?#7(_:YBb4.NBf:I#@=Og4RNR##
W#;c>aI.bdc36d5;W:7,K12\S\7^F3U_#T5NVeJ^^N5@GZ5gMSQg^(19Wa.gEGcC
a-?2QX0G7f<HagOdT]?f?)LVU=fN@D6,AYNYC<5WU+)#@eD189/5/KDB;^-RXMd4
(S)\Fc8R8JN&O4-(0?CXD01(Y.:MTEW^a3,bF(D3bT\a1>_@/d>]33?C+c<#B+X:
^IbW)\N+QEMMQDW?.31CFgSIaFR^U&VIY<W^b6A7fefB=N9OQW,=<5Wb&_FB-/OP
c_R0BE8SP:3KZIM5/AO[N.=X@]EE3U@3b9[INMDW_:R/AbGf;c&<)8E+f<N_fgfA
-gJS6D/,DW:g;M7DR0/+A)/RE(--.LKL\dP,\XS1-D0eX(2=\3#5d@](IFB1IDHR
DQRU-DJ-3PB@(=&eJ(^B<V:=_BZRECNI9DTMDF-PECH>QU3gGfAC\=/31;-P;UV-
+^J7G91[(bSNO4N7&R7bYM-dLcC,5S^HFAa)[1QG+>UXY^#_^)UgcNQUTKOC2Ha1
2.LN__MHX8=8bLJ28JbdE5U15TIaX?b3H]L+aXgF-a;F)A#UQF=g&&,1M.6Za;YW
gGP[5VHZa8<#,^J5S7[A\d2G2fa=F)=K1O#M+;;S^0#@+6MYDAU0bO<=_OW3,@4P
D;3NUEK-8C37HZG=,F9.^N(\I^OHWOO)MZ[NUg8F-Ia:[cQ[WHY8V[I@d(:_SD/<
;YLcKEU[J?9J4ZeVA,64&@64Dc(+7fA8Z9G9+S0=Q^e[[<:48=HAd,TV]8MU^35J
KacM#WCE9NYC_?&g9@J.Y0f[-?][c&K(\U&)^QS483:AG\R<+1aX(23CKbS@\V3f
.<2B=-,&e+Z:FDFLIJ#0\F&d<0@XFe_4Fb9-3P]Ve^XXIP/FID+ZSXR(F/^Xd/#I
Q_B_ED:Z\;fS>46S>dAK@.2_b6L879cf5>_ZAcH#T#RO^)WBG3<QCN,]K,agGSDZ
[e;#5=YV(R;5\B5g_J(@][D0Y\JG(<^.[?PK;9]-SQg4cQPdbF6TM1A:JH8=#W?_
T_aSLYD+9f2+\)21NT]a1N(6,Cd^Z:):(FLIKL/^RY9@>.=&>+ZQJUe#Va9F26X(
W50)PR^=(YPJggQ\0\fa\9VPV_TXB,)\&J^J]B(Nf^E]Vg?Ee-89R(D#1a\4I7V?
;8>ZI(W@ERW4;VZ#]OPBV(4V80[6WJ;IFGNP5IDJAe;eXI47f>)Z5g6FK7cNZ]RC
&23+R3HcXa+KQQJQ-/##>^\RbCe[6aN.,?AAE18\[7Q3^3WYFA9#,.)K3K75O5#R
R)NFaFT]4JSJDAXgg2S#N:M6TUC,WPWKFDYEIK,/<BW>?6I-^b7K]HV<@YVWSg?N
YOfB>ZP1c?>KR[/<?U[>?9+&W1IHVA5X)dS6dMeZJS2/BALZ(3:QPY-Q,bS2I\ER
Fa(0g>Zg^HI=2ET#E>[#Zd?&8<3=6+4V-c&T4#4DDN-8;A2CO\3[;ZH8]SSAgMA&
Cfa9AbcN&,J1H^Z/ETB8>Q1:I<;84DV=<Y4YQ5YBc8PEQ]Y78>^F1I&a,_g=+Z)+
de(>[VU\R]=G)=[#E9,=_A2Mc8F?Q6+&6DOYZ]YF9AF6^0EeP\_HN4;MD65MA[]C
P@9VRPXMeWS:,<N;g/AH;[X\fdAc\>I)Q#SNZS+@]5A2&V;W@@GQ3eDd83,HHE6(
?VMdZ3M0OQS;LF=G[W,S&(GXb.M#5E<Ee8.96&7B.Ze_A0IRKXQDYI-[ZA6L_:0J
gDIAKf\D<AL8LEd\dT5?-0<3K967TWM^a_C1_]Z.@6R?Oec/I/7K:dgG5-GQeEZ)
PfC/dJJcPW>,YQ2:?9]KC/G6SgS0C#ScV7V)X;,Y9_5N^:?+PfP[eO2cBMg9YBV[
_3I\&H6PI;2JZ:SDLGK3=K9GOJ-_\EbgZOZ0#R<?.?O9&g@V<&9+Va/KdQ1A\#P6
X]@VW?CR,(S<DU6f[>3[0Y)bY>]<;8V-eM/GW;#+#LA3[b5UPI7.M7QU<\2-bc6:
:S/2A?C1/^DcfSBAMY&G4QMK^9C+ZK+DVNFZ2.M[5Q7#6,KK/YRKV8LYJ(6N(/B;
18PY3]@(gAIgC1E16RM.>4HF91)7SW<+fYU6\I7bH3LGcWEcBe]+2+f?=XEd3#g\
YIcH9L,F:K8[SacFL6+2de^FaFCECLgPD?5eSG1Xc0HWM@L4AVV\,HEY1I?6OP5R
X]4_#>B-B-/26R)D]OU:#MWFBf<?78IZL^CZJae&]&JccB)GRELg@c@Y[R<N@AE3
^K34d,a?cdc12FENBNFeEc1Rae_K+X1MUeF:P_;09,E[-(XfcWQWFIXYLX0WfY=]
4=XeWQS47K.<;D?80bS)D(B?V.34+g]W&HFW+8VWMf2ME#I#^IgRHIIHJ8b/+P#)
2(/#(/M_Y50:>K5/\N(d8L5X-3K\QcM^e\-AK5Fc9-=0<H&8?#)OW[SGf_I3e8#+
6AS>7A4AF,:YN.\5R)@\1./&LcJN0U\0Cf=IAXD.@a283F8_I)4DQ6GOd</P+9EV
3_5@B^d^)(.#DfU>;=cVCQ)bOg0^_R+?P02fN38dA6[X^BWU\4fK>c64F[fTUaKG
=W#1ZdAJCTIV2:?_B=OL];:7dIHE]S;XUXX/HWDSX;(-M5ebZYf?;g3N<f3JK1c+
S\3>a-7QeC[(W440F?>_gG1P)RV8GJc1/SCf1(3J3.WE;BeAa^&cEAD6dATSX\>K
P+[X<B#P/Z4),.Z_7PF:=5d:gPf2OZH(PUd#@>[/AO8f1OK+JL?7MBY;;De(R1@W
,g]HM(C^PE=[8:\f7FS74OK[[].[C@PF.ZE3BD^C)NL=U\LOR;C?;gS;R^]MG4UA
^>[OI@6U]C,(e[WX@M3,A1S5aV,.&Jf&2A]aH@L#7^d0CD:NbEC>37fM9ZQ3_e/#
)9VO^B>+c62f/YFBLA25FRUMH4EWI9c_(:S,G.25U7B1f#)MM)?Dca0J1EJ@ZG-T
F#1U3H634HP1-N4X0d3?KS#+aM;LM:bc0MSF7#Pd[Z>+aSK8@6HA0QV64QDDFAe1
P&WH,_79TV-7KLQ^_3ca8UL]dW5A>dXT\77,G+#+OcDTZC_P;bHPYTIILIS-CPcM
P0T(e8\>d41(cC+@A8F.K\6+UPFZCBfdIFfO)d79U?FB1K]IK]a_FXgZGO7_B_D[
P9EP;:F,7)a\<3+FSd/OaLQb7+8X<3LUdF_BD#_:=a9ZTEU4eF+Nc32V5XEd=E\V
(QYLd)-;,4L2A@/8\_SU^49?c-3G@JG4XaIK4Ua,]Y;:A,3JSDRJ?c+1/.<^^LQc
#cQJ9M+f/MQ519E-g@3W=8@\I>X2f>=AFEM&^>B?1Wa?-b9XHeP>d5]^W&>^_?49
7^+VG>M#=QC)\7+_K6W0Y/bUT.WT:&OP7E?3.FX:XXL_N72RU(d<B1IWeg9eA(A)
H_7:X#/V&_=6#GOf=AKKK:P?.Y]=LCf]@\c:>2#T)6a[G,^3cX91a5LaKcD<5_EU
cLOR8;;B?dCY,\C+5^[9FG8a&WV@9&[gL/WA.TY\KKdGGFcI/QO(]0C4eg&9YJDe
?(<-c76J23c3dVc6+^+e@f2[I:V^]N1BEN71baKX3):CW,=.D\,&WOUcGLECU:Af
a#b;U:c&].fQc#7,ZXe2;LPJ=(\T2[Id&1)#>cD:HLD[#/7_0K>\;[C66&JO#&fB
=TeYM>e-_;W0-QS9BZ>T6<[@SAd^dB+GUba>W7]&7fd7V:RERIUX;1Bac67<?0N.
LVDa\NR/9:\#D\,?F/gZF]#<;d3WeeDf6^ZP0OZ87H2,g#8#9A4[7D]XOH6LG[E4
E<TO5T2TaOeP-3cC[>MeCZ>5G:[73?f1dJN8<C40DG3CX5[7(88^fRdeU0-C]F5>
@d:^<_[RX43TA+aPS^@4Q[1DL.(KRLZZUPY=gIdFfFF-gLJ/7BTf>YJ&=[@7Z9Ga
gZP(F<TP&@ZL/SO=GHf2T2>Z[82b>=FMCZ7+WMP?XM1Td5(30R?PO5W(NA/.18?L
ALOZ1&S-W\6K+W/W.Q#:\d[LR93\f5Y^;1:?L9UKc7dJM,L#SMP5[P7e>;PL1+Y4
D:P>QU]B+V.[0CQ3(L4W_MN]U[]4>.Z;/M>XW2;/CZW2MT)8eQZPQ)31Wf,=-.HX
6DAM)WNgb.^5I58;]@.^HLB<GRL0]g6-?+8NFd6F:I27J/CRdC8Z?W1bSJY+\<(/
gX#,TQcCVEK&[;^[?8ITM)Q+^-.M#c2&7ECU.1J[&CU.\Z^1UK3R95NTZ5e/TNXb
/4HOF768Ybd\8;7Q(I]_-W4H@HUSB_^g5HP(deLZgX3465,7^BO3f4/<,I]XX05f
<0.-PcaNCd5Y)K:D8>F(EZ469@Q<Z2NCNB<HPY]PQ5A^/AbKTSCSf6=7O9Zb-75b
0?J]1AF&N?P4Na&ZC^YIfA=)SPU6I:dE0cDd>a2T^@Eg--)3SOAP>B:5d+A/YKQ2
F_5&G6+TVM<dV/FY6D00W_QYQ[T_<X8<&WH(Q-P(IBU56JG)SeF):=\G>-&Kb#SR
&G//a;6#42)TTUP@^BLg=>,G]-:d>b/1)B(JX)C1bR+Cdb/>6(0TH[OaQ_RAcH73
BKSUW9R\CIRg@aP]S^-_7_d2\6.7[3^@d-f:6#[TbBO_9R<2LgfE6\<K4U<2\:cP
c.\WE8T[I#S#2dC0;_Aa@Pb80/H1X+-:gXD)a0&3e1R&44bPQA&g\IP_9-;^)07Q
e0Z1ZYT4ZF5V>6B;_>Y<XB:=/b?W#&4EY-G1EJNc&D63>I/8ea4XT\D?_2DM/;ML
9M/Zg:WMTJ>C=F8;31Z^4H)e2A,QP<ceLL/?9.QZN\X7cTFeEAcXOI8N+dEBKX[J
,Re3R?34,B9V^?1EO-K?NENU[Y&L5>9=e[RG85eP6;<6(MU)(ae,AJXGKMA2dgd/
eAW<;6RB?XG:T904BC.=TQV6&Z/HcNHW,1@5+B->e_7_-a]B]S_-R)@7_ZWAB5.6
F]])TaYQS]FZS+Y47NWYKHBB?9e0N2,79K\\D+(3/+Z.QD)b40O&(8HBUB@2(2;Z
<QJ6gRZYNG<9K[Hd2PX]OD7-ccN@3Y@(LfWgGH5QY_U;+HfP6B0]V5X6:C11/gZ.
>a/^OS2]f^B75I(9=QRANJ)fBeSf=<J&(ZdaE+C4V?S6RB9F65Q,&A,AW0CH<f<Y
QaZV9I.S0KT05VP5N@)dZ;a>0J3c127\C(/(EG-N,\E]P#T6_<+IF?78_XaM5A[F
@C-69HJC#NL4<CUA<N<7c.G;f,J&1]Y/dH1[P^a0_[S,3E;F5^PgPX,AIBT3B4S(
/B52=DINXY0Q#3[E9?,^b,A0?aUg5S+Y?^66dJ@\?B8=dJdcOEY<WCT/YTJfE/-Z
ZFNRZMeEB@2E8L^;^[AZT=>OBf(VE3K[?E)T6/^2+:\UM4><I(bBfcKNF@Q=Z[WH
OI?RFSg=beA6_2Y4G/6YdVg71[-P;+3T=_Nf.>/)SM@@/J_0T72@M3_O7S35aM_Y
,S?=W>BK,V^+-VUfad2,8M/_44WLa#6(V>_#7=?Ra\-2TUJP\T\#8F+SWZ;O,&&Z
PA2,eGB+,4:H8N<0G&GdYC91E@L+,P6?Hf1HP31/ZA2HE)Aa-_Q?e+PFR063IcQR
Mf=?HUI>L@^TUA:cTUTd8##BgLMa?FTTI-A.a:VE#]>+G]E9A,/3/0.aTIEU1b=P
?JNG8;Y2>b81+45BWEP.(=@WHgVZ6;8Z^dCa3M9?@.LE3(&L,]J<SBgF=8>F-dRK
N1Ve\X5,aY;e,KbY5P<-HBDO1E>AEX&+Z=e;J-47bL;(H-_Wf:3g=HQZ5^V-IfeO
05NfZ;e[,I?-<3XUM5)1-]U@RO4V,EVBc79D#7XXJLD.8L6DaR3+L&7A\aHCF2OE
-9Y9D8X)+S34F)2W7#;GV&a13/,f)?cBNMe,JTdGZ\CLFbS6]QZ@N@.H\NZS,ab2
Q(aR[O,(43+f=JXR#W^G+25B+a&#0Hga=bb9F10)F@?c2:(R,]+4/;^D[)3g>Y(d
AHC3Y_WZHJ.GF;d<#9SU8R09L\WP[E/X8H0<Y0Gd:V\LeVb+D]1#9FgR80X#&<]:
#SC4[.MUA(Q]4X4:J3KHCWSL(Yg(b\044]_J^QVK[^3MLPB(K<@Iaf<D+(8.7>J<
(QG+0IS,W1Q@gF/^Z,]cQ+#@1;Da0&UX1R1BSAOd><4LG?^.Se+TeG_M?C()BdZ#
H\RNaP?@2.cFIKWbc</OAg0-<B/;Ud>YD#:[,TCL<ZW\;edJO^7/<?BPcDT:T:XV
H&J2=@FSceTffgeB45\4(1TZ>Bd-S0X2MMD.NX]a_?C_PMRMO6FZ3DQJ)M13UYPH
<N_?9_P;B6FB2I0U,0PaT[L?&P7PX?;<7\_<aeV/\+^=,Lg0R]]538\gd9VY?4S+
ag4HC(<_]6.W[AI4<O=;NQN=2SJ/1V:V\Y66V1ZEYdPIB_JP)YbCLC)e-WRUVFUD
^g1[66Oe?H=ISf\4(V?B[82AP9f:(_2;Xe(&=Q.5KCOaf42IG?3^0#R_^L#=#D;W
:]J_5/f2B]dSgWbe1H(Y:[D+,&YQ3-g1K>4V[Z5Gf&1\Se\NW\cf6P^]H<<<T<]4
T-99-MGB<K.9Y,B=&e+T2\;Q7TLOFI#>)D#:Q<J(gK[A&(<9JBPfJeg(Qg+\Q<K&
?1ffUT&Pc4NE+;dcEJMRaX>H(SQ:b^L&YF,;e/@<0,:SFIN/b;7/]fWUN3UPDZG;
;K3AIUI4EfJaR>+KXIE?@;?^HZ-;G^@)1<+@PO]a7S\bIeX(]f>#7UQ[:[4_\S72
a4gP136B#7&E\^D0/H>7#QC4C.N3f]FW?S^:deg5Y&>>9<bC&L]WXb@4>K<<.^M?
&>.c;2V3@0YZF(2+H\M5Z(1)5.I,5)FAV;R.AY<@51NdXgEU?NX/5A^F,1,6SDeL
RaOS:FC-S)+#b&D4479_#6\5VFET:@M;2P\HUVU9VNB3W_cMb-EO.HQ=,SLgfD6T
>Zf/T+^8H<dcTf.N\Y.4(0X(0-.;UTDI1P[BaTbX&Qd[I+,.7QNN48B&IS^a?V64
81D<S_).HU9IOYK5(0QV@OP8HaE(JQIWdG4[?9ETM\6U[6-6-<5PBB)AJe,aM]ZS
?K-JNe9<JaI7dPAA=5/(a2b:OMa0HT/U9+03G=Xa,G-;ENMLJ<8d]#..<TO<3.]7
[;\f8GEZ=I6VMFX::)\C^1(_0SJ&_CQ:PQb)a#6afJW(5:T\6V&.5M&eb<96g^Na
B:.L>P:4J+d^5=HLTg+.QDg_[?d+gPPc:\Y6Y0DQMZ.\]^#>[\<E\#3+YbD7,887
:V#aY+4]?UM/5cNR-/Q^;a=1>\59;_,EX8:GN:04[Q/7Z(_Z/I,76B2cJ25?e)AZ
#I-JJ\Rf,P64+#)\V0O>Cc>2WRTI\H6B?,.&KfHVHegM?N/_H#IP/L8dR/SVQDg2
L]SG&gcGc]dZAf&FR,M2\9SXbF(e@O#,]N)\F5(cdc]TQ>:a)FI6&>YCJ]:?L=QX
N?JCVT65X>^]0?[4Q9Rg4&(+_E(S4.^0[)g<3]UIF01XJKO#A9ZR5=N(fU8C\(+W
SbNf9JEM/F]#RZ<L52N;6=TBWaY\B?ME16_]a1R^I@/D-YRWcMNZPN(2>,d=dc?A
MbT)TfVF&94.=W4?;>S@+W(A?0TK-043NJbY;Xe)Q\-KM_TUAAcgc1MQ6&Q:YLE<
aTb1AM063TH==2.@J.&H_&4U\7>P7HCQ/YEc]IDZ=AODX;5#F3@0GH:HH-CH3KTN
Yg,D)YXM.2M((B6;J^<#AS>?@-73\eH^##I/<&;#B4-J0S2+eQbD@?&V-PW5fHJR
=YOW-N[T_#C+(VIT(><e0ML+GR(HT:WV;6cZ<e)Ib)&=[6FI4TFee4=Z0H898eY>
IUQcK^@3dZ/4_5_+)[b4HJT((QgLd23Z0FOP13Ta2dc4FA3-LF_,8=d3(RVO\SLL
JAg&N=VPG+10de:3KgP#9.R-<2XER15K7[V9e]RdZ;QECEK_:9R_@);4;CB43=/?
aZLXUYBSZKeU<,dR=ANBM\E3K1?Ud)5dX@75;QLS@8IPDcQ2B>T&+R\.RIA(OV>f
A6)J0:O5JV]eaZafO<\5Q50-MGdOT,7&<MU-<M0C,)cQ-S\27YR_gQCb>3#Vd.9(
g9b]Yf?@<ND#IO_RB=UDb,R^54OS_+51?W0BGaW8HgK@CDX3_PEYZ@3DO[5H=gK,
9;0AR^V)ADOCL3M)\GCBObdTgEGU#&V[1eeOBW,5G9_:;0\R+2,<=KPIgSIHU6eV
XX+A.J62>7/C/1P@EBHHOa(ZFS,0;3WUJ4(VZ<77f+)b=?;-3S(-V_Q;CJ50BE2b
F_Vf@B3\c.aF5aEdQ&M\5.E6JKfaO<5=<9(fZFdeO;;ec]#O_]g^D30F1TJfBT5:
ZX<5?^&2SYE;#::ZQeJL;2Ve]^7Z\3^RNPVb.T)-:gX[4&P+GX1/e(.A>3V=1XPf
b1LW#3JBS@#Vd]CQB1W=Ed/@QS>#20Oed.;)aAGIW:#\PYV_,XA1Q@d96&S>77Ce
<#3#W,ge9/[:\T93>RUVfe8dMdR2f.D^e-I](.b[M\Sgcae?1(F<aI3,BRCM)G)d
^??I+Z)PMe1.gb<_<0DMWCSV9-d94d6=f-5U9N2Y[IaIF8E@D#>H@gf0_ZYc0^]@
Kb-:]Q/KMPN26AFe=eUVQCV0,6&4L>1LYeW)OY#(,W)K^GJ0Z^)MXZgDL5)bON&E
)#36F4629ab?UH6[S@F7=QJ8V>JL)a32[e4Ob&]a.-Yb.8CV=>5#Q/ZPBAV<5Z@3
M:AD3QR7A)->O=#ZMSZ#d-F#[Ce5;V8bT0:7ffUZ>Le1C(EeA,X.#LM)PDc.A/5J
X5edR=VFe\WE>E/2O]1^g,YaGQ9&QW79/:]-2VgFgXC+E1;TT:XWcN:8YMH],GPc
J^=(J6-Yg4>+J&&OW.@BKD0APS5@,>57.2da-NV+:/]V7aYDI?MN9dcD9aHX@f-8
ELdd/OR#TXCIWHf=aJ3Cd;9KM::KEX:VHB)Y(GFB2.Cd9D/BdU#S>Fab#2N]eKI8
4UONeO\=.HR#(>4_>\GEEWRC^P,);N5N@>BE^T.R;cRa[I_B_/_+?^Z)R\L2bWA,
2YeW<?GTX8f6EAG;(4XS,J2S>I#.]>Wc=)_eC?CDa\GEBSC@e.[B_?#K7[f:QUY9
DE27O6,\#Te;W:@-G[(1<R_PGDI(c:VT;dNMOge[[KLRAV?aBL2&JfL0]g2ONR>_
R?L;9a8>CA073QC\K7;?O:W/EWOT<&;BNS2-(T.)(DT.JKI&&C<1,-#HIe1LNUYM
XV\3_Z:e^:-QLe.gPMO_6\6@Q>\,3CPaN44<^fW@?:;#<884,HfB^W50fXE;K\&L
[(&Db_)_6P]<RT[::^SccCa71RGAQce?QKgJ;&2B.1@=&.SK]F/fC9JgA;afNZ+X
<aRVEHO,;Z..94HZZVcgMGa7OJ6cRX=W+MI[M,.R7_MgL_ZOI/7SC=McK)bO6._/
L@9ATgR##:(=-=>U0DXTY)b&\[:^T8<O9)I&T[JGS^ZfSS;&aU7cZQ&Z>D28Qc0-
dV45AecBbK+^M5d3?HN]_G[\EA?0;R#LW(LQO(V,cb=\74M<6@USXKR(=H>gd65R
JO,J6)O8,R3&(@FdZ;(cHWKP>-/04@.6-J=eSD^eKWG4T6^24Xf=29,WF5SYI1B^
(eT-19O6ZaA3,3T2L6LX,A;ECP>+d?B3bXb6f(S1YHZF]6@U97A;b5K5@I)]Ae,D
[G@E;Q4;6;6T[XC^,@QQ_e>TD\ac<HX3FJU9L;MOTT3AQa<c[V@9cEaBCbaZJII=
A1<dbJ]Z^e,+dVW1:]/-CZSTU&g>74:/N:/KG2Y+#^_^LbQSU>_F7H94FQ/\WNW-
48[,9/GKgI5OK3;_-:;84?PVMXdAdU8NRCG9H8[1\99bU:7S,9VA\gZ7T<eW3V];
I^RLgeW5RY&?B^LE#L,[]R<77.6Z,>VC6XdB,34VEE;BaO:\FcX3[KJX=65.P)9.
T35H#d?UcW6SdU;A((0dZH4G@QVJP0Z44#UZ3E<>V0LFd:3B>OBI0Q-^EZWD&D-1
6U2<4)QV64^<5MJa-0(9LCE2U.IA>&TRPVG9=LJF@&:1SJ>T(BCB4g&1/DOW_X2#
dAHGa+g6EYICPG)\O[e9f=dd?/;=\4T24FNN_;G6=;4]g.b+878c:W:dCBG1][.2
W0^N0)gBcUJW)E3/DQc>JGV6.=#+ZJU7]e3>7]/AdgCD>ER/Ob#GJ91BK478YGBT
,N_e#R:DAV^ZeHcA:I+5L[\US@b?9;A8a#F#;6+(/]@gcQ/S.XO@VJ6LC?NEa^95
V_5ZHBS+X?27e4]CKUX((\QKe1cOY:ZJV1c=^^IP(;WW=+BO?LMPXEKH//5F4GQI
)7BRL#],fB[O0-(P65I<IF94KB:4Kf]G-?2AP?55COVP<Q+PT4^6YYY.F3f1W>98
3T\]P32Z,0KEGA#:cDaY535dM7f[)_7:AOgIYSD8eUVR2a?^>65TC[dA#[c,9]WI
HH8gJB+XP##g&B.P5,PR\X>X+dcHb]&:ZAdIVUZTE7,TLJM76WWLO)P0O4JGR[:R
L#CI3^)DH1\;F#caDR70ALa]S3>]XG+/#e/@@W7=,@.L.E(@a@BFUL[bE68H\<5\
#7PD^O>^1Jg3R[c7H@VdRW6V:f<gHgb@GL,?Z<VS/LdMUCR9PA]3(;30RKF)A;O.
\W&KV.@F#_UV5IPKF8+,Y_\:?/dQbPL&.I=H\gBUC(_E]H3KHL?[D5=NLM@7)OL8
(6beEUWTd/1W?HV>g;C5/Ob8PG4RA4M=&db(][#WPIb?5B),2B\&2N/NYR39Q_/L
cJ:Z/<:Y6_M;][0dfH@2N>d=,f(BaE)KLZJD3\61Dd5.0CYdSfgba[3-T:3XW-BF
[H;V774Q=.c8E54Y6X&.C:/CaI.RgHc85ZJE)33L)\5:TBP5TG,dd-K=_0MJ2WX.
R75,/&T+#=L))N_97J6&Mg&/MKW<B_Fb(XJNTI<I1>5+Y4QeLT(_Ba<[GQ]9C2@@
<;KC\\55QNHP,1e^V46<-#(U[9:2J36=][SD6gAFE5&FED&bU8fI0-AEL@(]d9M9
+9G6:GER\,GN^K03IB8=@VFCZZQB6T>>KN5:eZ-]288G?)&J1[(fAICA4:B,E?S:
DAC(I<G2@S2^9J+CVRX]PJ663faBE,dT5-[[C6g8<B4dCE9GUK]+<N<Y\GNP=Kg]
c(P)96:)6>A53cXTL#4(Oeg6WJ=X[ADb?5dEUQ^B0-K09<adYO.8X?J>@M&]ZF4M
^M)I?\WA=>_2Q0,7-c<BB#5)QGNS@\FG24fS@JLg@R&94)Ufe/:g[)8?F(CVf<8E
H]RfZI_b@8>5W=K;WZ4f\@A:\9FR/c0D]P6][50f/5\:6;7RY5^CQMSUU+U&fL,;
U:YCZ\Me7IIgS1XHcbAGZ;O/BCI<f>H5[@RT[\2)N.P2_PecRX\NXGZM[KPU971-
-BH?;@G+DS:B@0_\8\6-4Z;)-&5E36b1&[^HX+d>2:;Pc.L4[3E>J^?/&9]@2@a?
WQP)L=HJ,7L;CJ9H^b3GFKNa^2D9DUeF]2#\WaA?9T]TD.;KXDQ7f,B9S<_Y3-X;
NS16C(f;[>dGXC_XH/GfP9PWK]fYPb.fV>a-FABL5BJA=ecfcZIS?<R<d0W:Jg=6
>F)9X.:-dZ>DR/c5FLgCNcFa8TX8>c:I-agR(]O>fCA[8]?e<RS6c=O7[/a;=bBR
EX&VT__P&S/L+6<O+AY.?V5P97)9;OUB>&f;c@0LY/<PT&J+fP6GKe=)O#X8MZ,&
RF((<S[.&CN</WFNM,;GeMa\<(E+^HHQ?E+](4L,DPWIQ7>N0fPR?ATA95?R)BP]
O-fa4I^f)^70AV?EN_F+#<@O_X3Z=2a[&<.&+;63_LYOaF;RT,A3JR\N399V.27[
aIT@K2-0=7VZ+?FY+5V#_8O6/bW10-[TJ7S]<<\4T@ETO<N2=7KC98U_^0BFC\>L
#G7I>M]AK:N3gMP6a\5E4\NXTc8a-46AKE2NE8F;[U-[f]R<&:UJ3/BI<;N7=GYF
)08:O-.NfR+b57^20@+M;e98[8S(U_/ba^Z02.,2/:XM1[6(T/.c)Jc7Tc\IRPX4
f]=c>H-=_B):)e^F]X/3OAdVLGV0L9GY),Be<<de;Pb@M7=.ZNVcJ=>V(5K?&gL)
(&/,gd-;4.4(LYe+SSIa4=0PB;^P.9Y?;M_fd:]LQeT4]ZMRH<2PD>P,b#[3&Af4
=7P,g]f@24Daa\L_[EY?C/Z[d[]C3D-5a+GBSBM0/MB1]K4TQ]W4W=/<;P+-T+g_
ZA]=^<aCY&e?5U6<[DOFcL+:3+,8/3f4Q5POJ#Ne\M_f.e#CV+/^,#ECb6@P7aZQ
[D=\(a_=ZG8aF#8C@\fON3RKePd:2.V8Seb.aMRbP=Xg8\5)<^B=8\TX,Z4NG?>5
5SQEOTMR\Q[Df<b_-dT6P.3bF_-XDY?P.V)-\+HcRS778+H3f-=aR/[J^f+5?PB]
H@0Qa_6a\bG^K@.Gdg;^FcNd?NY^:\YFJe[bS9Ue/IW<.?]U<V7-#+U:b-?MI<SL
cFMCKK[=B=Q+S7_0O><FC99=B,[c,NO1\9c-XW?BN??SW1Y&#0=L8:>CfH>d0A&f
@7G-0PO3H0H)eaGZG</X]6/?a[Y?C)6O>LS@DdC>H\H2[DfJ86A6.Kbd)]\&_a_U
O35bebfI/ZZ;WI)cGb8<=M)7^XYT,)4O=2K#JSbDPUNZ1.d:=XJSIRHO3?WIeeSd
B&<.]4e7(CAO6:b<,dZC#)3::fEU+bFY:?OM3&B;Y(D)_KdbQ0D(AWd2RYZ&\^CP
<a4ZRa#VTdMeRM+OC2_>=@W:3c-74b2bOR6M62<ILFJc0&&6,&=9US72g]IM1@]/
,4C0)(83J9TLKI2Qb<Z#Q;1.&f-;#VFFG6dR;\MME#OOB=EMK&K;1Xd-C#;/\SPO
[F(O\f=F(Z,WXX3ge3>X.B/;WB^6fT,)PBf;NTPceKB^>3RHD;CK_Jb\TeE^Q_61
?;DZ[<,Ja=8@.JRWaT6D_]eGZP7G:.Z#4Me8T#W5:XX]]S2]BOb;(+<.BIX&S[gD
UN[Y_SHM&1Z]KO\_1L&U<6WB#[F+=;L4f/B15E756]/\7[[GFdgU3S379\c:G@5L
)E^]M>;ZX,W&RbK_JS8c-C<OfDZeQG]D^+IT&EeF#IGXc1,BVU(NOJDS:NB/dBU4
.Vg@C@B(c^^7:YFDV0;-NbSc>2gL6OSV8_-YcMKd.QAL<M.PRc?:EHg=3B^CeVdZ
:,VW-N;DV5C/1O(@PERO54^G]d[Z(SE2c4@fQZGQV&=f^7T,/8,ZgMC\.IL>F#:[
):g;^R5e(cPH5KdDaO,@Z&bZEg)<L1YDg2:SeaS\E.COZMTZY:)_aQ2ae#8,8GW4
H6A,5YK;R0C_7LNEe.VGMW8RMG#QH2TE/O20S<FZ82L&T7OR?E8N,IPR((/--?8g
);J5TfB2S#eK2>6;3@bE0?7\=U)33cQ@8A[##>6]8H:MH-^R<[2)^-IQdWV\,7]<
+QecWZCY)SLCKEaJ_LI8B;YC.09DCPO:R]R1\7R8[JR]bQ8YB;OE,-:B/ET>a1J(
<0;ZEgXR_G&eI)d+E;0_.dH@PR:]:2J:/:?J9X)UZ>\9/]3;g2#LSD^.ZZ>@1,Za
W27a&]>&1:SCU\gSGPN<GbMC2V6AH20UDS>@.H8=DZ1=0O97:.2+-LED^7DJ1_-)
H[=b=[D++.WW1?&O1@)^T[/S[ZSd.#Ie&X7E7cWbG8TD#JCA5Y^&-8F(U1gD99H+
1Ge-_2F5LA8@D=KFD-c_E@W(.GASYR=cUBN][XA1Qfa0Y_&=BJ?5(I@?1[8GdM06
5/f2dM-Z4\/@ec4?J?,]Y<KV.T;2S(Q?X?AP<GT]&f1Y7;WFLL)Q0(OCGC=6Te9.
^<XJ894NHFdgY3:TSVRfT.U<ec\\84d2U/c-UQP_?JeE:2AV=@Q7GSI6Y:[1Ag+(
X1Y@7F780bdA?+[LX:D9OLLLZf+AO<):#:gHId5.B>>L5-)GDY-5JGX=58@d?UO;
:^O:f@RU.]<:)R;36aEBHF@1184/\e\O7MBS(MI/C4QWS-?0G4gENZ:=6]&E1G/[
[8ZM8YF29=HT9D:@OFLD[<>KTAfe\:XY9YG>&9b>-A=a29Q>JD<2AP<eBV5.+T/S
dSUV&3d2+>O?IT4M^08)3gf,G[C?F>[OM4CF65S),BUT)#cM;6^Q#(+Vc>b1@KV@
f-VU3W^/=+LbAG<H&BT^QIC2M.U<gH/6;^G9aGb+3#-N=+([B9b&^Zfg;11S,E1]
4\BF;B)YL)(9bYW^3V1Qb]_-#[NXY-7G>:&Y_I6Z@RVaXd_cWU8_O9EA9^fXgTc2
VAMOS?Z<D?^P.G5MM=JPee\R]M,2Q5R(@bD,(AA@XQ0MYF[/S&a[g#M(RJbfAZ5a
5J^3([/T8#BV3SZb73&NP^X<<:e:g11C1ffF;Wa3:fYVZJ1WI/P=4@HVd2-dMAgF
DO5W3)2HDJ=e>[]8]N7gbBcbIa4T,3NX@0.N#2g2,S54eY&#L4R1N2fgS0+<,CB<
I#=bfT9025U>4@Aa?C>JMb#AbeX<2B#C<b0bI\F?;H_KTXR__g:S9+5BNQKU^F-,
--U^:YdJ./C-d:DQ^[X/3NKgaD+e7E.Bc#ZFdgDY[F>N2I7Lc])ab4HUBBJO)OI)
>HBUQU3],,[WGa8N)ca:3T:3]Z_BG2H_;#Y:TXg4US84=g9Ua^@Q&7T)0Kf::12]
>ZS8W0@NOVV:7+3<U1BAeL5/#^6UfZ^61<J[eRP)QK_(#]Xg__43V9gGU;R0=C1N
gXS8[Y[(K+:XBA7N3[1@4],0&,MBg5/FD9-2c_D?Q7;:TTC>+Z,a0U)NX[g+;D2B
\O5.K4IVDU5@GTb5\8E8GbZN];R.K@GM7LMAfLAZ9.3>P]8KcfU4TI<=31c:R1G2
[F9/PY5-;;;,Nd##8#LObJ6C2ZB@#7?ET7fK^W0@3#_YLM8XgDT^^e1AW]U9):B&
cU-E8cU@IO)V@2K<A?4g^]Ig]A#)UJRMQ).Z79-7J;<#\<eS(BZ:XT;\[f+5_)[f
))UX7JCWBX?@Mb>&#:gfNZ8H+eaXJVRS+<)/:JQ6O)M:gX^C.)CFcL=#->TVZE^C
Gd\M_HS,]=E_PY7[YMCH:JV<GLfX12G?Zc(Z[\bJ>Na^W3b>830@>?(W<C^/Rb0b
U5+d+d_VO]f6bI7&GM@G[3GNS04[5KL?^7^(.JB#,NEW.J&L>S4-b6X;YW5BTa(M
TEgB.G</63KHEH>g_M/+3Z8,[^]SBCOE3R/,FY23GYf]3/I:)GEF@&aeOV04^d&C
.U_J93GU>S,)]WX)]MROP.+K2Sg)0:^#7@,([G38T\J03S]5LADdU.NDB3LNaNK(
g)M==IEE>Q@5ZG[BC#.<1(NH9T?)1M<]g\DJa:4Q.CA]HP].QN_V1V6TJOW[>G9,
/1)dNac[.De=T7U4:+P52;K52KfZ2\bc,#4Ig28VQEESP)@Qe<H)NYJ;bPeCc.#)
RQ#D<?)b(QC#89d.M2&eLV6_\W#O#?(H(Pa:MX)EPdAeeL4G-SB9(/303e8ZB2Q_
\H,.dK<gH5&EcE3<.ULg6:1UKO[TDPa82F:DI^EROXaN&6<eJ]7<gKZ4&97DZ0K(
)M-Y_W,+BR06bf5dRNdQaFT;E8:V7L>N8IP\P?V/CGS#fMW(TFOHF)^bR:L.dHaB
AR<E29M,Q&E+,/,IH[/aLC]RVP&W7d/)<3Y+1_JX9\HX@TA:9N5dU:Z/L,8JX\&\
ag):3K=_Y6-H2DC8Tg&IOTA2^X9+#M3_[cG<cA),AI(WHV(ca3]XX6/R8U8?dUFD
LL)7#Y4V0bNS5DKd77,6(_A/Ta4SS4UcaB9D)-N</[BdXc_a+2R<-:g7gPLT^/1,
S=UI7P9(K<d]_B-BMe\9:456\KPM+B;D&b)+RARCDSF]gE8fO[Q1WGdg)P&9)JEA
-?<SOP?e_.#Oe(,#eBM-+DMAfX#&Sd^XENa#Z-&^+^H6M5-L<B[Ee35BT:##A_&\
:FFS]3IRS>37fO8KLOcYD9c0Vb>BE.Kd,F>\I&fCVDTY:fG+fC[dGb;0SVZXbKQN
.XHU\b&C>Ja_G/87RX2@E(YebZBT0Z?C1/OD)0(b81>=Q>;5Z&SgeK&L6?[<K=6=
UVHJQeK?3[DW.f#;YOM+2-\G^LSMM_Y#11,7(>S3M.a:aVIR6<XANTSa.f?.A.5;
).R9I-aB,Q5WXb<@F.eWEEBf/SfK>_Bd0a4[fN/IBId7Q.MOGRf,f)9]@0cS.a_6
E@).Y9)4QFRB6I-_^b-0;)YcFDeR>aAg+HdY#Q8?=g<IddJ:58\0OZe,(:P[7T+8
+LUWJe4>4I:RO,F-]gb/?PM^S&4(&\<NGM/_g<QXa7/Q\(C0J,f)OM[BSBgXQ#:B
TAWW?0d\:+6D.WM9QF8FK_+\YcF60:U[FI0_Q#/O.U;aMf:&4_&5BM,G.2:H>4HB
bbUJd;+Y;4FTL,8RVT0XA@2bDbH2ICLU0EL7OGAfeNWK+D:D/3^7&LW2UL7.K2S>
U&9VJ85XI?R,#@-1SXD3+Cf=TC^B-P>MH2<J7+3,R<8MId-NH@Uf(WFH0)(g6eNY
^]KE@fG>J526C9QD\<9TY9IZ(>R>C&cGGAC;58_af^>X<fc;,)\EF?_cI9X,<IEa
K_BH6XHQYB1YIZIW_BfORPXY1=TF3Jb_LUI1I3b5c8XFNWH,U=F2U-6JP0^LP@&g
bUEK4@>(O\SWd-N2V+M6<AS>^deLJKBgd6Ld-gMHQ/Gg:d)WPQeYAf1XYQf6#6A\
:[TbL<^=&W@LJ@+T6I3Ga.C;W^;62<,J-e?9CWIST#J7<:7)d\A:&=_gNR<eQDdO
c>LL9MH3OeXCUa9OO>FgYE@fQ<dR#2_(0QW.V6Y\L-6M2#K.[\@K?U+He__J^R<M
AaY=L_JEaL./Bgg-aH;29,K#8Jf70,EK1<@CAe\SK)0;8Zc7S?0T(2F:&<_e0U?H
Gf[fW/E=G@T6S[;[X/g3T6&0P7+;L8_),+1)HVQV+PcW@ePOYeR\UR0LYX[0=3P(
?Q<7_:KDH9:8O_EQ2B@9TE(WJEF6(S7+T1DL_W/?YC\SZ04_^<#0a,EI/8-KMW,L
I>gP0P0=69N5f11O8@cZRI;+5T#9N33:8N,#PE[WBS#A:25(gMUc.NN?)/<\6R-&
eW]/]HQ&0?^7N#54NQgR8Sd44=&c0_>a3M5C,X\I5)5(fgZ;SW)e7GC_;\D_]R\;
9c(,T<;SR[[(H,P8C,I<.2T-&.LIA[g,6<W^^VWf<bCF/Y+Y.D5<2M:-)]=M;O^0
fa@L;\V<W)aJ\-HV^[bMNd2YM5aDD9^C<-]HLFN17J3OS[[7/+(Z?4A,R@4[g+^X
TF@=V:-,_g=&Q2L@TA:8U\ZZ3798=OA>caBLD6J)L4^)NDF]KD7e,G;)D;Z0(57Y
O-ZD2VC:@W4;4UCJFB<=O[6R\X+0b\G\R77Kc0e5H0:34.3]WDLg0[DXY(MA<>KU
(+(Nf&/0(TAAZ23JQg/W0]?Ke5>&FYgNdcNCOdf,>^e;GC_Y>JG(]4VbQVM9AGWW
3I?+0\1ZH;AA-W41]g04VQ/8:8S<c&V0/4XGYSR\+9.+@e]YTKKAV[(OA86]#<aE
LV>[W1]0^XVUSZ(4,6dEGSL)Lf\Q_c&4H\P>2PceXC(6)NP-Sd]ODQ@c3(?N3ZU^
M23VV,Y/=e5M,:;641BOe;8F7QW#9cgN/Z69OBAXb]:bd#M5+^,T.6F2PcI#>e/&
0]F1<VSbK7.])-(1N,QN99RSJWBZ4=cYg1<@CX>f_-g]@6<.#]UE;=KfgJC,5@7/
Xf4AWK]8T9;dJX,?ON7gRKA0(UceRa&9QFLG/>LEfBXO#cIEW[8H_WV5S6c(.3[P
EY?Y;FPK:aBMF6.^6>3HHY#?<Y+,06;8c2[JJ2eG+@;3X3U^WG@HD&10QG:6f9>_
_>-1,/C:[c-4U/@,<e57I98Ia9L-d<R=<43gYd:DI?AUVZ):0,Q71VB+8>LHKYG[
QW)L(XAE->9KD6G4,,Q+Kg/JLH)=6Tf0U5V@8BHXXV/GQOU2J;g]aNI59Ff#^VG;
4G=CP;I^<:d?+H#Z981cS=Re.f,RI&OUU_4G?0WA69)NC0W\9b-c^Qa#FJ\1WL]4
FTVV\8c=9CBQ6^,;QDYWA;1.Y./?e8QH,/J0O+XC_,X^3e0?LYT#_4O5C_cK=&[<
DBG+]);_RLc>>Q5S_3MK89V@e)P)=85I-[Gd7)=^baKDM;99X_[dI0L#P(b^:];8
fQT)&IH;(0>;KG^X8)O?OSI4<9O=AHFSR3X8<7Q;^e&&4O<98]CW&POZH?Z-gdXa
3>LUYb0^:@CW@aE0f8<gdS/.2?TaW):1U(@JLKJ2Y</SHY>0cA#\3RBPgbKI]c.3
8PAeF19)H0>A^[d9T4<;MLOYU4FT+?cASVM1&CRI\F+[DHNC\d)7@4]Na#C7J>O=
D2IC-^V[EW-I&\_[&UX&f=BRe3#&aeSLB9?F3-SW[c.2+THXg[E9O9<HLVg\5NAA
NAA#O9dC/#>8>FBLWDT,U.B;8VC/?=c1JZPC3KF@Zd9EA:6LBWEMC9PLLFed#+X.
U[&^\837KD5g0bMS[H59Y.](c&g&Q4DO&P.&F7;F3:]<?XE0Q?[acd#&D.3&La33
gRgZ/VGL..]g=-:YDH)0W#2EWMT>Y>=CaYX/&UdN>a=DaN.[CV3Q3XD8PVc7]=]=
75>,bcA6JCG-JIQ3Xe)UMT4eB?\49\d=E-)&3\HWXH=@AO?H#=XaQJ7WGMa@N5K2
c8S_YVBdc;\NGA(S+@AeZSC>/2ab>2HbA?e&0]E28=bGI<?OTR=)X/(,OC\V=1e=
EO>L2]3FKXg5)<1c4SUX)+c:8f8UgVUQL=]86U[512AZJSA@D>ET^Y&UG@;OQ.V2
J6>6S5W(?&9NHP0R;g0S+.7g5?M+f2=@J3R/2^YWWKEJH#68J[:7RZ;LGcbXV5+_
ZGA-LdYN25@;NQDga]6^a+;#3(fMLI6S76_9G\E(HG)]V&O)&(U_\/LARF-/?_&P
a3^g8S+0V9RMf5]A@GG1VO;>6H1CGaK\21e^K5c>;[3O^SVe5(OAFXHY^cH2EF5a
?.\.,3fLP?::2]K2]-+MXR7+6PfQ-MLQ,P[25E6G=CGR3P.H9_NO9UZ3ZZY&eO[X
WMBN\-Y#=>M\UY3=7L?7BJgN)C5>UFagD7F8(0=CgCcQ<bE+c5<606P]NP]B(LV@
gV,O-EA,]GXG7E7=Y/I3-CQIV26;[H&\233Ka_^dVK&EfNRea9.V&.@=MMBcI5X2
J9EGQY3;LRCdMJg)NL=8g<5&\AOG)B[eYZ4)V_8d?Wg#3\IS0ca<VGNg++Qf@52f
)8(^d,N8Ga:U5R-XPR&0f2PU79421(DVIHO_#JbdYZJe6dQ-Q]GX.9[AI1>CVa_2
6^aC=,6\:S4M<+Xd3)D1a,26FXRf>^.)?.R_CB;EcW5]+]JK3G00KXe;U>SeVXF>
6WUEdCc28dfZQ=cTg.FfX-_[2(M@JU?>](1)fNF]<PIIQB6_3b4H-;X4J/N0Y[8H
K3@32Rg<3SS9VKF59?95SOJIV06S:I&]#<HA#U[+#1)e;(-6DLFU:GT64BQJ8[C@
X_<RLWJR2N47?(.5_7,Q.WF/O)Pg9]&GN^J_ZN>,bb5g=ad\aMVL]2RRQ?Q_E6UK
2@3S\dHe9W73+e,8BfS6#L,JH?(0VB96KFD_Acc:GHAA)_7/J9e7Y7<5BNWTV[TD
)P@FG;IG\A/G2[d7+O0MCGOK,,@@SDFQSVH+#aEJA;V?A3->>5LE:0RU)aR)8+f:
:edR#MKId;JRf?f@PAdN;6/HKN5;E/PQWgd=,B&<=fI2]8[M^Xaab3:?2GBa@26Y
4f@0=T>a2d#D&0ffC/4??WKc0OQAQ.X<W95Q8<43K8F/fQ?68>4cZ\ZTY(8?Q/aG
\P)9_DQ-4IO71?PVZfgK:?.d?1+L(-/MRZ6fbJ]aAAWJ+&2MaO&Y=^WAf_8G_Q\(
O9E4dEe_9<TXJF6YcUdB>K-7T<TgY5R5]@N?A@?3I6R?_,MPDcV.2U>7b_HP,VJK
[C3AP_f.R#<>-2J8VF-WC;d-\a?I@SB0=[dSVP37R1T.,\E(U4&_=XU-R;gNL8[@
WIZ-X4CXZBH-?S2J.AHBVMN=I_V:.@EPN)6M1bea:);_ac_TLC)V_G/IgI&RL-,K
dNL1(JgQ8K=AR8FOG,K7PBd7YN1S8.M=Pd_EI95e<Ye8g5G<;9SLOC4=BX9Z1^SZ
EE,K0T@KR8?Y[?1_F0&R/>R5RGRN4RNC13>B8+<T7//I5M^HD7BGOF2G<W=/7G?K
>7R6#Tcea\JD]CD_&:RZ43:>&:X9Je@SIa)EB\&V0Z47-Lc^AX=1Qa2+BGFX.=;M
X^6XA3Ua)-b,=U15;8STMYZ7WVHFR@JPFQQd(CF\3aUOL.P&b>:,0HG1BKSdK1bc
#4E20gN)a_TW^LN<JU6V9c?Nfd1G>C+YR4]bAZd&JAYY#aXJ&G@T2;2=FYET7YHT
EedJG3C6IA=U0?^+U25e&DdM8NH)^;H>:>f\:HX5B#3>a,T#:AbPBN+;F^JS)f?f
aTI>@<7)7I^ULaX)+&bV1A,,4bA+I(bDR/1gH;(d(Ac2YMf4H4P8(F?E+Ef1.cab
6EEeV#bEdN&cJ+b;>EfVDVL<4KcTZU6LPS_(&>X;)OVffc06[6?g:82g9<QB>T8e
dWVV_QZD8<E:9Ib1gO>9V--D7L)EGCA=NN[e/8gH;66?(LDaUaCaA3+#E[[X\0SG
DQK?XE7M<;5JL/T5ZPKYeGK>MdA?[<5)5#?3Z/(EQHQ#UR(JZTS149DMXGK0:RcZ
-M)Q21V;42CD;(CbQ9N3X2BbaTE\XA,UfG0..]MaG?_\D0e@]=,e9Fb\\2\LJ4Ud
UCeFMGTOe[ea<A<YLK>-DWD?[815]d65S?O.UX6XfI\5Rbb(Je^&Hf\KV?T6&POI
ea<2)(A2@+.KIc4c16,;Ne3YYTX2cL+OBc=aKe>(d_-La5(D;dO2R0g(^cd94dTU
8fD3X;LHH>/ZcVFgKV_QHE+XNcNd8;)PA_CaEH#L].UT82&LG.\I\8>>Ug&T6fX6
g4eDW<(<V9aNgb]JG9/&;g1fMUP?#>ND\^c8@eTT3YGUdF#b7;8fK)GU86(?+=8]
A\,^gee3=-5_H7KY(7I[SDAT>C1g&9S,OMN5;XbTH9)-\BJd,e107J/IHTcV5UG,
Q2S0dFL)2f)81>3VW(g,L[PRZJMc^@]+fK--&@4TW[adTE7NC4e@7TR]M8LKYXZL
(Y\OBYH#5fG;G55H/#?F+6GS\g=4I6Z0?g3VdaP:BW?gPXC-bCKM>O_;P=a^MS\1
HGc8VAE]d+V_#&^#(Z8EBYgIU@;-\X]e?.),Q4^YW9V?0F+3ES\\-@@8c[TOg.E-
^+fNdEaG&U+(Q6AW_A;[3D0Y^>fAdK]c/P64CIE0.Q.9e;DQBDIAe+]7d.+2B]-)
#C]5G]>8e@D75(@e>ZAc()_=21CYWD.(+=3D?dXZB[c.BLKMR4T>B4?TL?/DLX;f
e.8C1LEgb\@ZGL16UZZMX19CU])W&g<]B-:4b3dQ,Cb?.)2NJ+?1C;/2FWWY3N7]
JLV>>;9)gWbTY,;NC@&6E^[&6bQ0BD:YcXPJLMeS^L7a&-4;T-[9.44O/GfS06OO
DRMZ0ZGYdBIb?(8UT_fXb_=)f;eRYSH[[CYU9c#\Y8[g,f=<6DXS3=:^P_E,(T=5
20\+56LCc]95eKLR#TWPc7V_fO7:=:Y#:Tb9OHfSMLD[YHE53eL4XRDb0U+OI0UA
[_RdR^=76&P]SH^gX>EWOY:g#/cc>,DX[HD_I->L@YCI9TLK8</gB6F7SBWFA@#B
^[Fg=)S&B\Pa2[a\D7A,D(e/9.KFV(\?,T.J8@Udg2]BJcY^7@:>A\@Og4)WZZ]H
B,dcFWSN??7THD_/ENU]@X&We;+g]a)F#@\D@4(1=6^8:);^55_J[aGKY6L&R(IY
YOWL1DP-4BSa101BWZW@[UTTMPB4RXZ&@&(;778J/LL<PdRPE&f+O=EOadJKNLD<
R/GfBI027B\QGQ^G)VI]<R#e0NM#GB>:K,#4W=9X;HS4HKd(J/-NRHa?V\H<Wbc:
^ELA2=3U+=/1[\#5c)dfHE7_.)TbW#dTX-cA?O+LK#0:^PET,Q<fHHCY2AA8fU#R
S,Kfe9[533WA\GJMT>&S.a83?N>YbC(RI+0K-DT\]YF_X-6YVd?SLJNP-TF8JU02
(\I0HP97c,Ig3NSS7XA-WJ38MOHNGBP]QR-BGE5@X8PKYHWUKNCe5=^dKACEK-ZV
,K8O0B\DF/W&[U:O3?SMI[QG13bg(O1&-OM,40g1Z#--QRZg.bTSNH)[645^#)3/
_e8L(.X=[?<R/;KJ/&;BbA)C.M])g2GZC8gFTbW:eXD&<f[D3B444cf35SUP\=>W
+T2;1Xgd-R\:QHYNdT#ae#)7?&8,<K@M5aH#LUdR+;)8J#U1Y\[^L\L?c8IF4<M+
Og>(a]YAIBQ6PeB3HUd9RGG5.(VLYG@OLC6TVW[:;15P1U6XEWYB7_<2MF3&JOg7
]__YE>-:[W3/1dcJF/0EN9G5G+=+EgY1GFLf7+Sc#A>)Cdf?WAZ<J?I/^5T9OAL[
,Q@R+[TN4>4)7gQ4KTJ>EAWNN8SBWW<:7e9YH&5T5Sb(PEg+4V]52e=9aDHYg6QA
)@1JS_U+K,>Wcd5.H#GaT6aFA#>7,Vf.G:QQgD+739cUJ74W9/7GRFD@b&^]:O@@
;HE6GRcT]+KBLY.@3N>:7+Wd:QBKNY_H_fIUQ<>QbZWV>/ged@(?ga)0>)6W)XZM
Rf8@L:3-NNR6b&@OTaU]bH:-<+__V]\J((E2X3(Cb&6bCA7b3DA>V;#@/d5J&PS.
e+O432f\SI3<UFE?89[R//DeZ=#.bCN05^QaP+(FFB2eVb]10K@[R>NTIN4aKU=@
BO3TUM48YZGWId,AaJ8B)1DG#6B7KH5c]a]J.(cPC9N+H_@)VDVe.c,F,PM5NC5F
#c91<ZJM)GXI7YW09(#3gbB,;>FEYL;[JIf<:a<<?K\7K)?H^3?&DV\C84&_fE.9
^HY_=6V;_e1W7d9f7T&@WV7V<bQ\^3;5\#G0gILF)L>fTTXEd]d_AIUcY]8_J&.G
QH>fGWg2\8K__Y^@W<Ad3[K[)6g>c>\XS7CUcO^d)]9S;>16REfE?PY0<I<_ANQ7
?P17<VcQ4B6#.D94\?\)ab(TSH;ZOXgW#0?4__85/JSQTg-b[R5N#U/88L\9@AD<
\;?9e,HZ[2QOQ6./N#6fF.Y6@[Q=6[,31N7N#>T_-LOfc?6/eLVZSZLZRZL7ddI[
=81I_?P:X1-YFEDQcXfQ[-J/e,d3bZLcA08#J,<d&U\DJc2V1ZK7/CRJ<9L8_/CA
(57?(EG(/5D3[Z[@f>X4.80IX>@)&&X_/FS5d[.2&/5DC$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_MX25U_AC_CONFIGURATION_SV
