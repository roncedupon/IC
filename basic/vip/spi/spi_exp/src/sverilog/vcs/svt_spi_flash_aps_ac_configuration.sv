
`ifndef GUARD_SVT_SPI_FLASH_APS_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_APS_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * APMEMORY APS/APS_OB device family in DDR mode.
 */
class svt_spi_flash_aps_ac_configuration extends svt_configuration;

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

  /** Minimum Clock high pulse width duration.  */ 
  real tCH_ns[];

  /** Minimum Clock Low pulse width duration.  */ 
  real tCL_ns[];

  /** Maximum Clock high pulse width duration. */ 
  real tCH_max_ns[];

  /** Maximum Clock Low pulse width duration. */ 
  real tCL_max_ns[];

  /** Minimum Clock period/Highest Freq support.  */ 
  real tCLK_ns[];

  /** Minimum Clock high pulse width duration in terms of sclk.  */ 
  real tCH_min_duty_cycle = initial_time;

  /** Maximum Clock high pulse width duration in terms of sclk.  */ 
  real tCH_max_duty_cycle = initial_time;

  /** Minimum Clock low pulse width duration in terms of sclk.  */ 
  real tCL_min_duty_cycle = initial_time;

  /** Maximum Clock low pulse width duration in terms of sclk.  */ 
  real tCL_max_duty_cycle = initial_time;

  /** Minimum Duration in ns for which Slave Select must be deasserted in between Two Instruction sequence */
  real tCPH_ns = initial_time;

  /** Minimum CE# Low pulse width */ 
  real tCEM_min_sclk = initial_time;

  /** Maximum CE# Low pulse width */ 
  real tCEM_max_ns[];

  /** CE# Active Setup time */ 
  real tCSP_ns = initial_time;

  /** CE# Active Hold time  */ 
  real tCHD_ns = initial_time;

  /** CE# Active Hold time for Enter Half Sleep command */ 
  real tCHD_HS_ns = initial_time;

  /** Data in Setup time. */
  real tSP_ns = initial_time;

  /** Data in Hold time  */ 
  real tHD_ns = initial_time;

  /** Chip disable to DQ/DQS output high‐Z */ 
  real tHZ_ns = initial_time;

  /** Output Disable time to drive MOSI/MISO ports to be tri-stated after this time */ 
  real output_disable_time_ns = initial_time;

  /** Min Output Disable time to drive MOSI/MISO ports to be tri-stated after this time */ 
  real output_disable_time_min_ns = initial_time;

  /** Max Output Disable time to drive MOSI/MISO ports to be tri-stated after this time */ 
  real output_disable_time_max_ns = initial_time;

  /** Minimum Read Cycle */
  real tReadCycle_ns = initial_time;

  /** Minimum Write Cycle */
  real tWriteCycle_ns = initial_time;

  /** Minimum Half Sleep Power Up Duration */
  real tHSPU_us = initial_time;

  /** Minimum Half Sleep Duration */
  real tHS_us = initial_time;

  /** Half Sleep Exit CE# low set up time  */
  real tXHS_us = initial_time;

  /** Half Sleep Exit CE# low pulsewidth */
  real tXPHS_ns[] ;

  /** Minimum Half Sleep Exit CE# low pulsewidth */
  real tXPHS_min_ns[] ;

  /** Maximum Half Sleep Exit CE# low pulsewidth */
  real tXPHS_max_ns[];

  /** Minimum Deep Power Power Up Duration */
  real tDPDp_us = initial_time;

  /** Minimum Deep Power Duration */
  real tDPD_us = initial_time;

  /** Deep Power Exit CE# low set up time  */
  real tXDPD_us = initial_time;

  /** Deep Power Exit CE# low pulsewidth */
  real tXPDPD_ns = initial_time;

  /** Minimum Row Boundary Crossing Wait Time */
  real tRBXwait_min_ns = initial_time;

  /** Maximum Row Boundary Crossing Wait Time */
  real tRBXwait_max_ns = initial_time;

  /** Row Boundary Crossing Wait Time */
  real tRBXwait_ns = initial_time;

  /** DQS output access time from CLK */
  real tDQSCK_ns = initial_time;

  /** DM Setup time. */
  real tDS_ns = initial_time;

  /** DM Hold time. */
  real tDH_ns = initial_time;

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

  /** Randomize tRBXwait timing parameter in between declared range*/
  extern virtual function void randomize_output_disable_time_ns();

  /** Randomize tXPS timing parameter in between declared range*/
  extern virtual function void randomize_tXPHS_ns();

  /** Randomize tRBXwait timing parameter in between declared range*/
  extern virtual function void randomize_tRBXwait_ns();

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
  `svt_vmm_data_new(svt_spi_flash_aps_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_aps_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_aps_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_aps_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_aps_ac_configuration.
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
  `vmm_typename(svt_spi_flash_aps_ac_configuration)
  `vmm_class_factory(svt_spi_flash_aps_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
P@@&YS->>S3G5_1+X@D>+/<RH0LTcSQ8[@_SPKF7V4,f_2TK0R-f0)c5@g<PJ=Bb
R&EN^8M]X8PK)caBbY.g/.TJ\Yb&Fc=E#4Yf\,#15G<KR<Gfd?<gGcW/7A22/OE>
2bd@Ge</^1H?Wd0:Tc^^2gR(Q>M+;KIRb6EITUZbF-_89Mf@6\aC]BL#4>#@?S5<
VcE:>BPND..Q\?99P(WKP)V7]eUc@CPQZM0-4+)_b=edKgB.c6X.cf=&M/,S-1BQ
d4a(a#&2?8826c&VVCTfbgd4ReX,S6L/JK18<G:DN\[<4,GHdD?5A7(-X/^BG00>
_g.\LgD;N>WRQFW0]Ed/))Lb8eb/8DUDD3L,bTMT^YU]aYRM56DOYE\>g+&F@AU@
+PBGMfa\?9:IHWH=AXfB]DQX=8[25YY@)UJVTf4ZTH,I+;NeU1OX6AC)BTBAV+>X
,D=DWQ4QDU.-b-5@L4:5aZB5V@.._?A0b+OMX1Sa2^^M55<[VXD3HZY(O3?R>]2E
2:@?Z=/#5C,U9;HP)>2PRQ^(((?F]?N[KeZOa\?T&_\&D3LE8c9>9-cFL7MN\JD5
GO(1e\>HeQ42O.69&Md__@7P:-@[Rc-BF\e_U5UBg>aEeFE_]E+MS0ZS=W3a?;)O
;_HOV5c9;P1AH)C6\VI^.?F1@R/+@da<De<F=f1WQGd,YYX;0D6I?#3QgQd/0g2:
=g=7a28(DTEMV2PH=(1N#<JHZI.D3=DB]/9(4g+3XfO>F7-H8M7R/:3QM$
`endprotected


//vcs_vip_protect
`protected
F8ef\Y9gfG/eYL1CYZ<52?T#T>2eYA0#bN/3P5CM]/@Sd5AZCNdP1(J(;+=;)8Sg
ZW(We5ZfQ=e@-4Z#EPX3SgJ:KSg(5\]0_TNfaQOaO009JWL_C)HKg[[,JTa2Yg7&
B\gVd<ee?g#S^04IG.DH2<242G0_XH:3H?MV1CAGMg7D-OL]KZADF3/3c[Y5.\G\
CG48N/4Vd=LVC0>S5c]feAQ9g&EL6cEE]H3,9WO:Z@XWdSCcZc/a),Z5\JA81W)S
7DI.A>7#Xf\(URbNV5VT;OaDDUP\;X)RKgaMLdKM>N]+CE4a0I5N3Sb>-e[_QbXJ
_+fdb+PFLXeNd&.WR<bH#7SG5RR5#&5-9YS5D(ZGY4[4e;-WO\5/&)65)S0G+XEJ
.((M0dF2^c7/3,B2S&PN/Ag8WLV;UY_C6d[QPWY+eg+T<gGI6Ff@+=)cN(L.8L,_
T:\X+aIOY+B09(cJ;MSSM0:(JaTLB(6WCGV^Fc7]RJGe=A<g\_HOM.;(f8#<KI>,
5=KA>39O+5VQFD@B=U+4b7BPT69VVUHP3aA27S3Y0I[1CSGHUeKX&-^R(7GPc#R=
KdH,)6gZF9Gd4<Y3LG)BHfSbSa;0W[DTCQ.Mb;SA@<40aZ)#^J8gVI(9RKZd-.0G
5^YYXX;F:B[eS2+(7(2f[D5Ra=Y6#G)AK,@+D,89>)a\Re0;509Q()-c9L19+#N\
9S8):bBC1RI18G2Eg8?@<0T:.EA\\ASP3B1-C^7R5/G6.5FNAIQ-T4G[<W).Ze,G
IQbW?cW]OYT>4:&VJbQRa<[Wbg7,I1+GURc_B#,<7<KUR-T3^O^;B7\c]O-I]ZW(
W3Wg]fKW?PeP&.W#]C-H?BNJTA^=#WS@2L[?99ATYG8VR7308N05_QKO#ba1N:b]
OH]2[F/dSBA5/b3G/#1#U8+K7GHg-Wa\1WP[J3^?E5,4Mbe3GOabc680T;#a0YW@
N-TJ7@OBcV-X[=0=?XY+gO+VT5(c9d59,?E2AK#V;+;YCNc-J9Z-8NafbGUF;C[.
GV@1Z0#PW.K[</@)6K[+1#>gg9JO-QXdU_fF2^2W)X8W,]>f\6843f0F11=OecM.
WQGSE&;8B5SF7H_a\2GMGa+X?+?BWO-L<a,aQV9=dE2b(SBDAQ\-;2@TE_I(Y5f]
7@Z2gBRaM]IU5f</gb^S@OcZJb-K>(YDH=b?>=H-WGgP@&IdXY5&D-Va-+E>6S:H
W#9YK/HK/OeaEg/]?<_25^K))5>-,D[:(S(8F??-5<B2L(&(X)X3QBBHNId#E\XE
/RUP-ec6D;MNGAd^Z:EVBORKaS]Yf@Y#\QN[.JC)#)+Z24bYSZ8/[2QAF+_S8[32
UT<];2L)T12BF62=UN4]RY&a004G]ea#YM,b5,bO.&8BOR30GbHNA-eaIR^.4e<+
\3#:UK)]C4^6@,G_5[g&LQP^OP&9-/G_SE+/&),]G[^C@BV]T<FP_O@M15Ub()BX
(O^H75VTd>^SYd.GEgNET^4]a=.B8G,?=S=,,/5>8R414T<N]#^aeRc[JZ&&Xff>
G2QL1gRBFR/ARHY/AHOM9I,;9AP\RIID(^[^f@G4LOg1O(5K;8bEe[E:c-c1U3)Z
eVe_eAUYBQ>(IT^[\2-?f3EKP[H+P0X:U]bPUU]4aA/eL;>-.?X(Y]MC5Wc</^Yb
O6)65dR/]BMD:DK#[#AaQ\aFR>3F7Y&L;<_E@76:_UFQf\ADH8)\E#(_IOD.5Z_@
8+5B(Xf+\bW0_XP+W(O111VBOG_a,ISXDP>LTdC3c^6L5\(Ad;_QI\@#?_7cZ?+D
PU]E[S1R:-=Z<KJ.8.2fH/;ZR;^<4Z4@MUGIbLJb>#&QW5IPM[0e<[YSL4b/GD1K
PG/Y>eUKQP6C0;OS#5?^9-6>2Y,0a_fP9VBX#SCQ-bIO7aIeO(/=S^-6B#5CAXN5
/]9aAOF7+UC#@QG/58?dZ;\EE]@7VWN+>AeJ^L1_5RL2@U6PgWW>XT8e)9SQZ1V4
?0;6cbL2&[ag<P#1QHc68_f0V,F_c4BaET?)OY@\I=fMH]=EHe39(<K\;0\JH8Af
Q3(6P-/6XETC[N:T&e2V8g=S<K3&/(ZHL8Re+X(&<6dJM.e(,9OT]X6PQ2cCD_\+
9N,adX0#0YJW)E.?POc78A[J._L=HD:F+>]ZUU9][(PA52S4b7d2(d=QA2RI_\?D
@gETJO;.43J]?7=<4g+&aaJaK#,+1Z#M\24NaZ[.CJE8[g0^Nf1<L7:aZ;)C.HM:
\d:WO_6b)DUV<34_3\f^I@2>:N;>gDNdb11(E1Od=^CI+N]/0f>aAEI5>.+^acQR
b,Q(7)4Tf_+M]IU#(^<DP8#L)SUV(#BB;N@D-2=gZHCS2>5^+7=;[M5T1]RfUe;[
)7Q?=Xdd[/1TLH0K&HR7>Eg-#)_:K=cU5Ef7PcgYZQMCX)N9)J^fJ6T_b))@#QdT
A63@HNW<UH]#)./_R:fe0+/Z,b4FH]DeG^F6K(d#f+?:H>C.2HUYDTAR7V(ZT_=O
7KK,DBDK1>Q8(@e-PAEX/7QN^a)Kb8\]V1a-UfSd3>1@SSS@>Z^Ag/EAA_C?Y:XZ
/0.^[[E23&DW?aV^)(>\YV_,a<M(AfU,5,fT#[=P6HeU>3UE/R[-Z)<f=HEL-/>a
HCWB;^TSK<PZM<.\6=K>3\M5?09@=,fV].\3#ecOYKOb<3/F4>e=19DL)66FJ=-]
7c@H48afU+81(K24&][e-8I/P4b(50LL7g-;>e6aD4Q1#NGBYd69)QM^/cGYFG\:
6^BBY-Bff4fD0BA=aUD1cd&&M1U#(gX)TAe6J@T3e#U84WSC(3[>OCRAf??#,Y&Y
,V46DQ[=O/U[5+#]YJMJG1J0BZMD=,aOb9dZ#L.WS/\b>;_<ZI_c<,_,UPC:RCe?
+TWT05AI4(9e#dDBJN+LXcXHMPL2I+g>B@OJO>#>UO0DU9=Q:70YHaR4QHTCbf_S
Sg_X=8V-P;a(Nfc2.KC@TFM]a,&F\f7Y/]g(B\YRT^gI&M@H);8W,>DKgV[LPZgZ
<L-UYW;6Ze=5f<UK_N2C;)Gg:^SF:<SfL+-CW0Gb>6<[AVSPd:f(L.3#+TgCG85+
:8O+\I0ICcfP2Ld9#LIZ\dPgNc+5.3>M@/EAUN&eJ[UaSN-A8PZQ3T/>-:L25AUg
fS6Af#1CR=D,NgRR;>BQPGg+PFObXO4W52DV1DMV5B?\/+4KRBIS/P.#S5J4a1a6
E8J#E1&OgdN+K0B_XSF>#O?6#bdX>0RCCDRc2^(B4=1KH6Pe)&8PPLbO?fXf]WMO
SK-X^HFH@7Q+_eTT_C/\1<\\04[.8LOS:g1@&P8TVPZbZ6FM8KTG\;@PXgI?,c?L
98DN)0LW,;YF\\>:&]I(SQ(58&e2GYZFEG(F#X+SL8@?)W,]Y18.4;RRDBaBRKMR
DL<Z\@c/G@<TQ&_V>?7MLc46<_b2cZ]LW\FXgaTCg=7N]WN:1#P^1R@I6A^BIHFJ
e,K-fGDba&<fD+?:==agW7a++R=VcA25GRb_HbfS@>g7RUbC[3_LUGVXg/;U48FQ
/&a?+;_5Id:N0,NOCMA<8P,#.(>M4E/MU#OZVF;V?HI9aJX;>^BZ<K5TW:-O5;@G
aBJZ6-^H0I2><<+cPW4G:a,6c^#EYO;TA32gW)LfcH(J;38)-S0A<P#<WU->UDc8
fG\)V<\5-]^8POYCQSUTC&U?X4O?Cda@7.J,F&X=XV8TH.VX?;KXQ^YB6?38_SBC
EYI8SM>;D<+0fe/F;U_()F>OF,5c(dAg(COTCZY9:\bE>?3#LZdUOSN@^H(JLWJ:
C9I6VTdZ14^e.QUNdCW3[Fd[YBVR+UGB>RF(:HL_15eC&a:2OcI+IVE#0;g=QScA
>BbAc539Ab=/XE;K;e##C>LgZ]86_If&0>Q#ACP&(,HO/J]K2\[R^9H^XNBH>[Nb
_-WR2\>-cCY6dHeM4V/(&L3/f:N(<G3ZRf3C2PdeJ1G#IDT)^Oa8aINc_RT7R)L5
E:eX50X/3;GDIMP9PH@Y0D-,9S)4&_c:N]CSNb:R2HUQ^&,gc9[aPM&)7dC_Z_PZ
6@afY)K=(X:A5]?;0dOK-;VHM+ZE@>Y1AFR68NE,0-Hf7e8]G>0WFN]_F_:E.U8F
NN3HS@.dJfP^:<>+Wf2V?OZK:dcMcM).@?T1d:YVO_SXS:5,:>(@FGU\IX#&a+^]
U@KJZR@1LZU-Q_c&\@_8[fEd+^Y]1P+#ce6(0>d[]JQ#PDZ]@Wb2HHAXI-;L6=1[
56KWDFTW+RR;UB#1\^(FNPNSJ9f+-6fYCM+@bL3dbg2/B8Ef]NC8ND@?M?\V3RTe
4]_aJ4I7MDD,;C_L1IbgS=H&09#Y6gSd+[cY_g6gR,c#^\beJK\aQaf@O7&1+G#G
]Y.KL#/Y]?:SL3OX;PgF1L]+BdA.fd]9g[)YXdD)Xdc)(FgG&\A4ZLP,XZIZ18#[
bVJ(M=^ZUB^S/a-0VPN6-:-5Y9R2U)RZ&,-cJ;f)0K)&fEbce8REeM3AZTJbYdAV
aa@Y?)IAFb?YW2BD.5PP)b;(0A6;E4TDM[?&G8bWRC;c4^,_&S=9L61&Yc#d#MGV
-WVYDP3Z,Q\,aZY5L\64\3_ecINR#gP<LQ3A,PV?S8UI>=2-/RWb8AV8<>P36M7#
g<eTC.20#SDgIea=(3V-R)XS[_-@.TKA1?.dV>M:N)O=b8A3dG;aG:b5FPPddg[<
T2MOUCg,GN@MD2CN,SP3.-F>A?(F^>/]L0YGScGB>PaIBO/D)9[_\N+.GK0L6Hg]
g</63dBTGbK5Z.^L1[:\a#,P<W))eLOJXNOPD_#,.OGS#/=DI:.J8A+[T7+L/XfG
:Z5?P.E@ABMFTOP1OP_GA/78VBISGI0I+Q\GQW1/N_8227?M=M+<1PM<(UCSe,+D
0PDdHS)eW9aQcE]NP0BW6\(+.0fM_YU8&ENa-:2SGP:5D5]+4>]&aF6<+7G?L?NP
5^D3\-@JYB)C.]f5J)])M_QD[WCb_L^Z;f)04S(W.?Z5DbDP?C6J<4KM:E5/d=1d
@.-e@.,K\4;O@2T,#1F9(]NVDP>@Q=IV^5EOZeALd?5N98MbeGgd4OM431N]f,\-
+(cdGU4]eFUWH3<QS,6F-3@0C>dK7N_;ZLO-?FK+]\3a6XI\9<]#d6Q&b7)f98MJ
f+D=2,f#,H,.^QTU[;a<YcZ(VDSGWCPYFCF;W9\>4+(J@<>IM<COOSJ&d:T>4aO-
_&5@3W\;dL76TMcCIaNSc1c(Z/-[@9Z80UaN3ZbJ([(1IDWB>HTb&SJ9c:+H8S69
0V(gK>IAd-V=RS2=1U.\5F^a6572F+=PR\^#cb->08Wd3L>)^.,JT8WF.Dg[LZPD
7/cG)889S;eV9O>L.V)CB?<=fNQ>B(,KIdM,7C?A&W-VT)[II1/(80O1M-G8MQ?g
,+)#./\dNb^G;M^<[VcdW+E9CAN?G@&L;/:B_?B[cK5[]F_NV&;>_>c(EH?Y\a<)
=5)G+dX3G/F7@PK:S18&dd#D[8LXg;83XJ<HQ60XWG:4)KNEL+P4-)(/6EKSeB_<
N:M9E[4EYK-T=&6WHQfD@@]BH;Q=g[IaIC=HS\MaE@+@7]4,>SB4CVR;I_Kf]PJ<
F7QFY..[9<:aZ>5XJ4VR@S_)V\[/-C<6Z.)Y5BdT>eL=5&QOKXC75BFLFEC+M=F^
>RFf.?BY_NMS0,T+KTYHBfbTS9Se+>bHC^AI^bXQe.G?=@b,T25,<OdAbDUcX@JQ
M33IU18V?H92)e6^1&GM05Nb]e920DVKF:B8+[R\[2[[,dgO5#OJXGD1KUA3RUDC
M/J7]FQ^RWY6L3I:)R84Gc.-2X6Ra27@MEF>)I854aJYC,)U<_N),A]6AL[cM,1@
HM@P9g4,&IQ_<g2S-#>..GEULLE]YJ71f#f,VW386EXb8S?e^_7G_Hc,R;#f0=YN
B+edZ#I0M7A5+E]#I5UV?+8O:e7-2<HC1bP3XZ;<)\97+Vb<fU\@.V-BKWFFKQbK
(JVaIYPRaS^N5a[#<T60P3@:#D1)62@(@S871Dg\(_Y:WXN@=C?DDLaaCGFdd.:]
Q]__LVILJA?FIa_O-;X[\5V+?A9Q6WS;d?0=-dC;2G@+f(]3+OU5[7RbAJNe0=&.
=MfbEPP(YN5&3A-f)IC)#L])&,UCKKRdI;L0IA13MO-@QX3E.Mf9af#Rf?/Q9A\+
D@LeX4bNf-JL?N6L5(.E?3U,>OD-FXf074#I?5UL]\?3V[---1B3N1BW2INYT1H7
e>FAfEa@f:.O.e:+M<dT/N(_[E\Ge1YEH>ac#=&,,D0S=H<CeP2,;?Lf.b;ED<9.
RcV[K@?6.^5\X4AXKNNQ/)RLWZ.RaK(-Gg2_._&.4X&g:],_/U(XadTGW0-D;/32
Cf)Z\\gNK+FTQ<1@eOegf)DY@fNUPB._++2&)N,\W5&P(G]cNO4.gc\)8_#3eKN_
BGDRV-]gCeSD)bC_^+&=0;1D/KZAF-KBHa8c]MR^]WC6^[+T7T+b<1ac-#E59c<8
9ceFb;WS[ZUFMDMPeH01(A;^dVHafeCR?aCCMbfX:WW[X6<A:gN82eZ29Q#+?AWQ
T=Y+SWL^VL/L4P9@_7R6f@[\RG8+45M)8)Ge1URGLDAdF47cLd56FP07+;^:T-9F
R-J;>TA+@1-VBM]C=2cbYD3I4X0AYM@+e1dP^Dbe#^6dXGWfKR)D_1Q=,ET\2(<A
<ENH8U]R9Y0<:S3H^AdJ]OVMLBZ)f&L3HO7G0F/#\4<B)9^g&G+ATX&1a-?:XCGI
LC7;V?CL0+I33VH53+5@ILA].,4P;0FN/T6L]XWEQD;@S&/G>A-IIgb3[H7(Y?7c
Pa/eOO=0:@Q7g&<CX[PSNP=Vge(200S@T_cKKf<W6)H5@6b<(.g5RK31WS-E1,a]
&8Q\eZ9R=eIMZ::7-A:gNf(WRS[Def4=PfG-XI#IZd,TJ3>(:XRN1>V_C=W(:8^D
]RURBgb)#K)OggRI/[-7WMd@3[Ce1E@gB<G2C1T(M56WAONeH8Q_QMY7)c.\EcJ/
J4ZEZbDR<^UON+X67ffg:=^-NCf+7N3(gMOX__GTRLA2794QTCTY26-+ec(SQ4.P
7#9.eQ=4FRMDBYJ.8/^A8>J4AOM.OLCUe9+Q#G<FII2J:BQMc,5F0C8N-e_Yc.=g
ZYcd.?ZEF5\@O\AVMKME8^.c?UOKbHQMS_/J79S-3He\1/VYZLQ>B\+>45LTA#AX
JM4=H?/D6RCA@+)T/)>>9<R=8E8H>2(L\g^/S:?;(3?:8P6]]CeX)P[0b=@FZ(L;
WX?b3S&SX/g\MKAaVdD&#b65:>AA8aOJZR_)HQV]&PTP\KZ;[g4WJ3HbbPKN)g/[
RVOR2XQ#d@NS2U]/N=GRZ0G9JW4Of9NVLA-)eQW.a[eIGU2<O4;g7JX3&eTZ\A::
6SM_#3+bIceE+1@CB,NE-[dTT?5.G.ddW1^fO1QZ.aF_6K=9U5J9P]G-UUPUD)KR
>N7;L6eJO;^WTW[0^.C(G.g=P@,Z;E7bPWO^]=c8?0MU:#2d869CI>P,:LZ6:3L^
:\YFgbFFDMKN\O.\5R&9M[TWJ?c_DGMN]edF\?LBFTCOT[Z789D-cW43_35f@NCf
?_Wd6DT42^O21J=KR0A)=f\DcY&a_68aNB7PHgF.6^DO<fW?@45H:+=f-#W&89--
X>B2(MGeV@eCg@_C?^3SH@VE=(4.+IJ<_H6F?IIH-O3c3Y]KD;aUPab^#_8a:/6U
g+E>\>99<I2.M44@,cb8@cM(PPU:P@a:VIEf\@_;AH\:M+QP61^5#F#A=176b96&
.]gOMX/-eO4I#:^Y+VHI/Q@CEg-#ed24UZZe4LZe@[#7=;A@Y9V73BGaefKQZMNN
E<e^eX>UJNZ@8EON0#R/]XF@MN;aS37RUPJ7[XQ?,cfK+EYC:0];6OM_8K#SPCX&
0]>O18NY50SFYYKLTOK:6.RRMfWGJ=&0O8Y)5#,4NU^BRZ<AS&B7H#<OH\JfNJ\S
e81)TLA5A.]HB0YXMSf]gdJA\\=1W3<d9Q]?&(Z,B5aU#>N5H#;/[DaNc7a^?<4\
2_^8.Y,33@4(8OX>#I0&^8Vb\F#N84]KKaX]4_C>Z\I9@B4XdZ<J:ED(>I?Y._9\
NdFGZJMU./c2A.\U\R+7FGUU\1c1a:PL_Q1Z0E0VWM0[^=,;F<53IA=AQ0]#W9g0
[a]XPY;8N88:GdYBS8>cU,86@[W]^N38IQ=:[7<Ged#P)fAb>?UDR5(:2+,((E\P
<(4;Q:Z&@ED/37)HH(BADAeR4#b&H3;(B\^.5.@2G1V^FOb&J]WBF#g[bFR8PURa
WE)BSSc1TA>.?W]?#/=Aa/BF+)e95fS:];-1^J,2;U&GCA5SD,LDC\R()LbI[.3]
W60CAE0=E)9HZdI9WG,5-Y6@Y20d7:d[P\C/C9U_XFP/^CTM\f_Bc-9,]WVF8&LE
R,Q=J^U=>,0@]S#JIeXd;9DA5=&N<)F-\03]79W\C-EK6^Rgf&X32@3[f\S=BT1-
\5JC>Ug_/00Z3?21GN9;W25:+HY\K1-(,+g4>4HGN9MWVIH8+I;=>S.d/NOIbT[L
O?8S;JLXT^Z<<#--?f#COZReTbJDLMG:0H9K[b@g:Ta;;3>C7+=;+cK#+EGAe/UU
fZ7V80,BSc6#7SF:6O)<_F&,&Z^a(PfH9a;ULFK^ND:4WLMLGaR93Q<54a_R5]12
=<S<-W3BZA_EQW(FUEE]1TFJF\/)ZTG/+0fWJ]_5V04<Z.7X&RRDD>4WV3YP?g(.
<Mc),ZIP(142V#LG#C>UJ3;V>PDZQ(:@I2)U<G8)=BKG&F#D:F;ca1.-fO1[[#XS
5F>9J]TD@#H7CEa,@)b9I<V_gRGH)+KG?\8gD;Y(g]?F?LY[R:?E\=)NJ>9_4D;+
KJ&=G5>M3,#8,1Q^02F2[7T9S]0SDeN)WO[g/#.6U9YQa^>(V,9_8)<N:eO1NQd-
5+2(Q9.XD4f_:S[6P)..0F]]+(O?,g)ISLaeCZR3RV3<T&XQ,H+(CFDRgO1-,651
FE)_c&?_7BBDf]@XG0F22d#a,0@:JMLY?5>W4TJY1UL-e>ED3XL6MCf6a,S23f[\
2<\;PPEB[XP+:KOEU.IF)cW)?3_7^?H1-(_<[O:E&Z2U#X(#V;bafK=U,9B<K]W;
b>+[WQ]-.cD5@7KB#K),5[N[]f6ETeX?,64)=aE2#FB3g5<I,g3;/Md[=d(7XF\4
SP3Ub,d+;f-23+5@3;?CX:O]GO87YEB(g4UF@Gb1RNB\@SDF6aVPV8/-.a@?(P;>
^E,e>;GfCcZ0E5QOG3bP8^a?@5,f:T(OIK22=.RCeR>>d63#cHR(S92c@a<IF0T<
g<gKSBF<f=N;PP=CTFca0Aed0\];ULbcDX.C1<BGP_JN#B^P=D;O&4=Sb)_3X3P=
9Qc?cWJHXD;S#P)fDJFO6eU9K&NI(c3W=12NV0@XI:X0:\H2@Q>WBKdVIY^ONa75
UMF-R?^-?3KO=eD\bd4Uc7&-7]NKa)(gSfMVeOdSeA4;+0d,.W&(IT[]Lg38A;[:
Ta>A2d@>?G2AA.2dbB]3=a.CTMLTC[,1TJ+.COV2+dcVG.f#VB;faKgI6\FWfC/-
;TFNa63Mdf]P;bI;GN2gaT0=a;/T:9^K=3/@ZB7^@_f6;f:]UbACO&0M?3eN(2R\
-2Fb&5-=<DTAcbe&6E^0K;/XZ_42+?_YS?8))bN+BVT;K4^U7=<-..]I(Ua6W=Q_
M]VZ4U\N.COZF\ZFcX0=UQ\H@5/.N)fc?YONVBeY-TL_VE&f.E[N+^5\,0E8NO-N
bc:S6:eL.&@]91@I2KJdCO1g]D\f7cOa1M<(3S<4Y?@-?TM[J8_7XF/1&A@bA.X[
^Z]XL9()V_;ZF7M@[-J7U_K95,HT[;Ye)YB#8CG\@SC7a#@PecR=12N9((G8Y:X/
AW7Pb4M&&L)>U6#Z&-DB5+_ffBF.b)ZMYN0MIP6-<-H5G5#fQ859:]CPQ>LX:^bF
U\VX:T0XNK-4U2]FY:2]b)>g:aBgXS]?dd[_S]53G[//=Q9FJDA-D9N_fQ-W/&GN
3/YMO5@(B)?DFe(1PI[8J;0fW)8O#O&(BSe)d.>;NONGU[M2I-#7AL=TbQ4f3c=(
JV,5/:6f_f;]O0D2#Q7XA4MGRW28PVS\TIUd<<Z;--PM+QLLA.?EHVWM:>2EP43X
:36GGK.:J@J1Rgd6OYb5.KW_fXbEa2-#XI7B:J\aXUI04?J#LB&5Pbc<Q@g[9,6\
Va.c37VE_3DfQA_,GdAZ9YYLXYC0N(E+ZY1:;)C^Rb:(7e.<PZ,:K4DB.J-ALZM^
_@(ACYX-?+O5E)O()QbSH;;gfY^P.=J,MDf=-HS?g-:?U+;UZ5H;#/Zc,U(EXLOe
PO5V3;6c&AZW+?#gf;=&&#8@ID9)C,-Q9:43WOO=Zc.#<(R+CY>Q[TFIcK6[03WR
:,c(TdI8B:O)ddS]H@=K9)B0BY;5Y,d&S6.gX88+f?(\?5A@.M<O\XC@d_6ON5KV
cZ7L5V:NDYW.\WIICV9d&<W>&GYRCXfYLDRTA26TC2N99+BD:;28YfM<YZEM\-58
2/(d-Z([9V1NfK5)F2IC#e0M;GABHd@g[cHVSYG=@P;LXFf/?05V2a4?Q):D>f6W
)RNO.MLWPR-cZ#9c&K+Ad.:MFC5(69@XMGO52+5_NGIOAZ;]?QRAZ91YEO<N@QQZ
B1PHJ>9GCCQEaDgg8Y1LZSI7^3HR5eH?8dK13[BY7N>_WgXH0<.U;&bb>5IW;4f(
a:V0E-X2CX)fX\4ICU9OK&I4,MEZ?d.[_270&5fIJ);KO];DS.7V/2]@=G\\VgJW
_)#GWQ6#F1fNE@DB=GgQUUA&()fQ#d/FgcDJ)6CT6HcYWZN/[:=HL+1)g.J.\4WX
]B)G.G+3[B6R;6;)b9gM#^M/(BN=E)ZWdadE@->]3Y6_].CWR47Uea0c#03R-0L.
](P5ATTJgQRFN(4P(1Y>g(T0+F&#[ILVg^8V@<f,WYO,aE80P[DeTGM\Ha_cfDZJ
0U?d18[c\WG/.:L@cIR2D37c0O_J@9afW:_bV#XQ9MSFMfeOG_ZT\=T+ZAJ\PFSN
.Q-=:e[<[LUgP(B0R^EXL[\TeB>BZ-9bTA54G[fX;<#5U[(#dQSQBK1c,)b;A+38
Ae;QHgRHRH4]c=Q7A\OX7HP_b0RE7+;]CCPXG@QI?(:WI/.<:^5?,W(.\[0(??[R
E\:VZbB/SLa&XO<@5JWK@_GT?T#T[D6gHaW<N5F7EHQN^bQ#]S48Yc[_0IZIS?^/
>_>g_C+a&@&1,7SV8>Qg>-S4\PCgK;aA:DSSW?;a4(9_O.#[J_Z?[&.:V.1WSg:(
>&f</[TI9DVFO04Qb[I50?>U59be_B3H8R>fD;+:BK@.\K:VVC=.=/^RSgRMa]Q[
3D]?QI9\^O8Z?e_-<@0OBI6TPGP90LD+VJ/]d(g[A(/47;3-;YW,1SZ)=8M;DG>;
@G/>,QN>BS=4g)K;]ZaN4=+:B0aeT)\=G.<&+2)FX\&aM5<?BGQ_8IaVWB2R76dI
9EYaa8?VEc1:)[7^6O[FXEX9VCO()Fb:Z(FSPUcg8SOLS?Y@7dZ+>1ENGb<d=a)G
\Q+#;2\3MMeDV60\QZ?0SR,YG6?],00.,E?JcIE)SI4@>]W^2PM:a(78f7=TKUN-
[+7YF@A66S=N+-1&U3U=0Q_J<NZ7gZ,8X6(ZZ]5TbM5;Vf[W5;9I8_#^]QB42M?[
(IGY(>F@,OR;)U-UZ+bdYfRWS,De8f:8YA/XB]2-9dV2g77O3<e?b)df\]SL_^1H
e]D].KW#]Q28SKY&DZDcQ&(bV0;Hb42[^AF\0(-TfQU,N.3P<HgQ[71(D4/2JC-Y
>?^.<9ZSd[C/3b.RY<gO>5Q>2c^W0W:V>V-Vd<)M7_V99c5+X)(W\VbgVD,@6Q)/
dR/YL3.\,:f(A:/Y@e5Egc4Jb0[5>VX8HB8#R0TSE4IMN-9LLJ]MBfHD<5+9/c]@
D^G<g)bKf0QH)4FWVXO0QE5JcRBYAB&NPbY]XVS1S>,DFgAQ,1@)CI_5(#75Y)5d
02QagATV9;.La^I8N-253aC#?AaVHA8S+:#J<>JL2\gK[2:GP54N\Jb2>c#:JeF&
6;_[LI@52RU\K>9a1;HeNCJ@DdI;;Z\?#_^\6>BCCbg#@BG]CU2\;32?g7\Ef;5+
@2Y<2-4&HY?)R;,E^/9:K#Q1b?EA#b>P),^UP8]MF2Q13X:5-cKD1JN,8Nd#94N1
8)YZaQ7=9D.ceO8Gf2c6O]CG7+Q;=c=PK:&4D72V/WMCd/O2:VJ]S_1&Zc>beeKG
4Y=A1O4&1<OIO8A=)AO)EFT-:^d:=1KGD3#2g3_0N)_Y?cOM:;Pe_QM&5H3JcZL_
6(JdFHd\b)@4N^]/f<ddJSd5EY04@OW7g;/6+LKQ(MCN\Wf4Pd2M#e<)O,<>]B8.
:TW@+.^D7HaL.S8]g/U2FeA=BF_1J3]bZE2IDB^La?dO,GT,PcM=bH1A#DS9\^[D
]JU-VEJA#:QA,T;/D2N^8E=585([1=)Tg8Y-+9\#gKM>HV>f(.A<J=CK6/]?=ETC
U5=GaBS)BL#=F6I?IY1IL-9OaD&X<4<Y>CURAOMR?U:6BHZf4SSLKM4_R1/P@&(Q
EE644&3G-P][,=e(ETQOM&_>BP4M.>6@.[OD]N]CYIXC4;Q3,+[A\#<_<@cP.Z4P
ACfLP>f-JA:E9gLbR>2.;?G?Q.M\]c,dCf;60d:@15.18:R)A\6_&9?L>IB4N(=L
UU@#DKW60fT&>&<MZG\2aI7A+2-SP,c,\P^;9_eHPCf(@?cKb0X\?,.bA\BM[7HT
e,OG^,P@-=MV[)9Oae;LCI.^7SPJ#f>XGM<Bg)ZQ4\@6SFU/eFX4-bM=b+1O0]9:
:<G/B9/;V^95;:>5c5Df,<LLOW4OE+)eM9@AI+@Md]XP@81S5^V^A[O&dbSE:a;5
5L>&E_;?6?7&L42&T]X_80g?[a]=O<4)3L&C3RAf#X//ZWP94:AE1G,dT(4Ld4;c
A.eCeCW/fHY+=HJV>FdW-U@HG8Ga^RX9)e8T3[_F9=WW>5WbI\Z])08]SN4E^W6+
4RggA+a]852,?T+WdA)6^\CG8M09^2)Q.K,P-VXAE#P&5cLeT:6G#+BYdWC23MFX
>NRX:UDTe/F&?T(>LY12-6>JG[DV6GgbT1?(8-]Y#+O19W<RaF1)g=Re7^Y^a_<S
9,+GKY0Y^LJa]\gD0MKAMB3M3>I?H9cTSGB0gF&A+1SXW1-:(VCSI1ZC.C9(gA(2
ZY&H-A;#OP-a>U]<9V0:1Xg/7cE]7c+(TRT,9;1N5T:6Ve:Q@:]e<OJQQ-(-8FYE
>6IDN+0c:eH@&&c7H-:,WgMI=NTABdXgeXO1PgX/DJ?]<)_5>gfgI,6=S,(3^dJK
;MXdK+J>L.YK19FNEVT]KE7e:D)^71.?.M\6T/9N1BN\A,M@W)I4VRN;3Y<)_7E<
UU2TGCS;0]AWeMD-]@Xa;P[,QQOEe,Q]O[D;S[a>74L-5&7^Y@]MKa>8]HgL@egQ
HP+(.&]c\9616<-H#8C#gDb&eU<UB,f(c^S5<&bFZd)Oa5IK)E5A2?GJg/T82DG6
McbN2:Fdb5>.bBBfNZ&>g++_1+36D3?0#)+g7@NPVGcQa<279S&D)?Q=[G#JBgI:
D?e2A;7CYZ(,QA@7&&WOdTfUA7/5JOW@AU\R-JSU->9Y+c9=#18g+-;<>=U:>[^3
)Xc.Z[/YXS+VUbQaCgD9HEa<5HP=<ccF?NI]c7O\?&;^2)]4AC2-_1,,[OZ.,@BG
92cNUc8WIRCLa7?N)eZI2Z(4cd^[(BH,XQNX-45&8-PY8F2,B^[/;A7G)@W1Q>YV
D7<J8IB9]QJ6_=Z-LA&7,f?^O,G<(Y6df<2=)aW]?P/H++6eBg6NR.;^-?WSXH_M
fH(?0BBDJA=;:b@0-aCHVG;a:\3PH+N&6R=6]E8B?@#_+?>,82Y,[V_#BaLcRQ#X
L\.-Y:L&+HQ>):cHTR.=I19]=Ja]D3@FM&Jg1gN5OX-VT>NKfBP=4;275GPf1a,-
\[;[-FO\cf#H:UgSULP91/bKAFTL,g2N_=8G;(7)f2W&HHS[M0BY4]A5RSFe>2eO
d;)]_9H)Oc6.PF=64LL3#&SB(;0J,Ug^4Y&^](Z#cHNEJ7f@?/^FVNf^K@&#fZ1W
CZ:2WQT)_1FP,KGM8a.EKOTef6Hb]b<,U#S4S2O2UD@/(8/=HZ(g2V?N:@4Hc9.8
M?ML<+FC=bZ2LF_/@0(J)V3L@9eI302B9IYb5X4J6_3b/OH/.@+TA6SUV&BURQ\d
7OM04T.>7dL:F#FTPG[@S]ATgXQDL[WA:c--M#gNV/6NP1^+E#U::FP0)5b2^>3a
I]Nc>938EOSOEDc97K#DI]9e@55D8J]1@Y#A415OM]Ca[U+./WHTJAUQP,[H_.)K
@dc]+8\0FJ<6LB9R3L=WY53WgS.8APa),@I,<S@@9/(;bM40#98269ZX(<V?)>=K
Y2[ML_]=G6V+G+/E32@<X7d<Pd8=a/Z,D_2fCY?-gEfUXIG\b>N250f4Q7a_MS30
cN0UAZYB)/PHL07Z1<[VP5W142&&+_6)@P>2&.VAG(UHH##G]UIXJE?=IE.@a+U;
S57MM.>9SQa-P;ZRSMNReQOMe^.3JdBNKFYe,M1-JKgf>FD,LMa3>b[-=YVgUT?6
3@[,VPPS8e=UWSCH]INPP9@5Hc]1B.9.G36cFT(W)[QCH;DTA96NWIBH@T,R;/Y]
;?.4W/4U(1KJ21^cA/<B.7gSLcZSY<S#faUEA6U.REa5LCd#(Ggg._>D+4VSDaIY
P//;^T,3)=I=)N.K+??a@FZE:eIZTAC8(;[50.W3De;DC<#IHH.\dY=50KK+;dY=
a:>f(3Q#1IV:GUWILS\FJ:3L@+<R75]BE&ZX<&\W92+PYV>>d_eL4\-6ZFgV<aLI
6^#-IA>.^J4A)[)a=8LV^A:)O^&1^O8N-\C3aY-fUK9f&TP4J_9g\1G?=^gP\a_\
@g]?YLP2>XF8KQ,EJX5C(B:)Xb5J&:^)HeY#;agP3d&0I:G7Kd)JAU8C_VETIAJ[
W.9QXaK28Ic:WTL^d/8IH\SOLW53e+MILO;^V7\N&8Wb/B5HO((Ra6^+RbfL_8/e
0:+05/\[@9)[_PEW-/c>2L;[FVD\X3]Td133;Id]4P#ZU3H?OPcCO@eFA#LAO]^Z
H9fRQQ6^>6]e#[F</&f^H+C0PX\,=AJ=,4G.SOb@cW@dd9D9L;e7CfF;-PRc9\S>
>]QIS;^b+BN._.?2^-cELDN;fH&_XR@I0DKFR7XGQ,;/0+79P8MR;@61[LBF6A(4
A]Z/(I1[=^B(=b^X<ZITJ/2[d&ZXbY._R)[]&aDI6W;6ESP[S&G4YRXXF>HRQ_a.
J11CDG1M^QHQ@BBFVFKGc)#FXO++WG:\AK3(3:cLEGa(?E,(gOCaHE6P3_.8Q>7D
8HC//QP[V8P4X-#6fa0BcB=K7a8Z;e3>aUL)a@TgK@JV9N2GG#Eg>Z\>\1FZ_7a_
+VHGPXe,.W@#]Af#-K:3\.1O/582Ha=HHSU_,/eER-A@&XTB]@KLTVM]\W\2NWV]
_.QH3U&ECC,C[\UZ==:3RRHc3/f2O>62BG@d1MM9JMADXW>:d=ILX?+eeb9RI)/f
6Z2J6Q5;)9(:906<I56.;BLBDeA,H>0\dUWXQ:eRWHL^=^80E3AD<[+53Y-;C\KV
T8e3LASAGaD_HHgV9Cc4D.</TfPHU17E(^F&-e(<gZR7WMY92PIG)O;[/3=P6ALZ
T:+/DSKQFXG-P@NH1I1Y(P(>RI(\MS8VMJTXYYRV;/9G(NOG\98YXPLdC;P1MdUK
?b&,_YU;Y5&[-,f]6M_Z+SN^TM=IeI)>-M8[<P+Qa5\UDCVH1R5[&e@7(E2cB>d2
DB:5A>=c;W.N963dEbK=YIBFI,:^FF\:2e.QX-_23MT]aTM3c)OgG2^2A#7Z406I
.57SOO>c<Pe3L47def.F;bB^c@&eYaK=T#FFO9/152=.KIZ\a;:--ED#=RYL#PV3
(.)A;II:^R_JXA@f6#I.ZQ8E/9bf?6]V\FX3Pe=V&QMN0MNVKN2V1ML14EQdO;aJ
OA&g.JGcQT0<dO<O_I7/+66Q_gHCa-gO>aGS?5V#RJ9:/93E]\Q?cg68ZWe)T#7V
+WCe\fF^-c-cD6R14&-2F2&J;Ia#gfTZ.Xb:JgL,&W7)]@2PUC/4Be&J,G>=e4C=
;?<2T\U+;46H?W3614g=>SOK#3dP++7\BJN/I);\eNSaQcQC=A_)Rd_#Z;##6OE^
D.1Rd28R<gM6bWUP)AY7U-)He8fGSc<.>(+^,8D0caI97URAMB:@b1VE:2AXA7TL
6>cL5>dU7MGX^&d)^<X<M/HPG=cI?AD<f_cNZN:]_#C)/Q]H)P035=Le@0QZeY[L
SRF^Z\Sd16#4(=:9)Q_D/(AG:Be7X+06NeX\8O9DNNX.ZK<ZO)HNJ-9a3c21MC:9
;S3CF>9c3Fea-KRD_dM3.@B<U?XP[cf_Ife;#REO+I0gN_0SI-gOTCBQHWBH-UW<
DT9I;SKBZP3E_J:YP-ON^3;4/+IX#ePI3Sf)^Qg70[PD^89^H83\ZY8-RO9IY(6.
.O<.@@bUVMU&0[#/U+TBCZK]8a_P?Q2(\W:S3O(GLZ9V(Hd4?W>R/,F?F3_49D@9
f&OW)K<86BdC)]&ZO-6eG2==-9A&<HL5LFX)4ZcW5A+ZO<I[3.:&5,8]UP(>U6\\
IVSS]R=?<Ed-I(D@&X)>UNdOg9_J&J>^#+a0\1CK\M:/0I13b9CFI_#V&((5#RB2
=^=CBVfbL3?WO7HPIT^<6e\C?Zf(ZT?d/>PU@]:0[G06L&GL)AXMMeM(06U5XYYH
JWVeQc(D9M@A4.??gE2A]]PQ?>X0fF0:gCe68gS@<d;<?;.b[.Wd,,(?7XeRGXG<
N]^4>_X&YVZ]@XLRA=]](,1TE&\IK_:efe&8Y=L1RG5JgQe-Xb1D)1Qd^N1Q+:AN
)N6E:G/HG^GJ7+9IJa-2_dQ1gFT_e9-[@[@.;=W=PK&K\Q=AGX?KO;(/e_UXH)ef
Kad^I_FdEEG8E#BYCM7CaUA5=OF-9=QaLG(Eg6?,SMDdb8b7I;:LYW(M4DMB.Xb[
>)HJIRaf&MH4:R;Y8e[I5B]:K-#O7bX7b#3X?#:LR1<).&0HR&TM_f=20:J8B3]3
dA\\(NMD_)DY6I:OAFUPMQYF>+4K14.d9G/DLd;>]>.d^K0(g2De.[Q1DTE9/=+Y
/S>[.DV;YeH-DJI14Ya/ac[_(7ZX716^<.6\I6[:CF1#V6b&:e?WV)U@-MK,#W-F
T50Y8Y<:/Tg6[5X.e+g;KTOR)IFRWI4UBLS6WN(1W3-(;=^-Jfa=f/9]FYKNUGe>
#AK<<F<Y;^0YTTCMLZ^A@LB_C_L=+90K[C.1+OKEg;U5[B@I3:242&O,7J\Q@H:)
(fFX\,,ME2+TY[;)_b:3&[&SgDadH[VN]-9_-OC<F8f.bY2D2_ca:(&:4)SZ<?0,
U;8;Lb0QE3Ed\2JcL-=#Y_KFI]F+:+7NZZCLVPf>&8EFXd.8Z-WC=BOWR#?M@&.(
4\LeA]8\3WW@;C6gIYYfI##AZXU>G-J1EE\DQH5SbLSUM-3@>.6S2A[VBU#HFXfI
>QD27>3?a7ZR<20J#eSIK]^a-FK3JX[QJ<:b)(M6\GO:B<AJ[XEB38J-Q,E:.0O0
H8OBg2M9>fW^Zd5(egTT7.R8Y75>Q_,QL,acC7bQ2J]d.(M3W\K9T6b^2OA?.M&M
.JFSAII1<WWWaQI@8W[g09C>L\f)Tb[g/6Dfb1@dB(=B7g();B0gO2XPD3]>A@89
P@??d\cGQ5&PFHHH1\W7&SAVGXZ=?_C?G2:3]DS;L17TU&Q[Pf/Ma?B56&a_A[P@
O:g.>)=J72_@IK5C,7C,]9bA=[UC7dK@^G3+2=?;P7X;5;aT,BLdP_&&+#+4Y[[1
KgfVT-1UNL,G-Y8ADV=1>E5Q\@K_7U3SH(d^QOJJQB+F;fQeW+BS3WU@0#N5B#(A
Q,4?IfS<O5c\[GLX#QQGC;ZE;IUDM/RId,@7?\P2ZWYNdP<0<Ka^S12AU>Y;S7+2
.&T\Q1BN&>fUU1(A(4JUDg(FSGc_@ER=adGN3d1Z=f;)^]&]CF[bJ]a);8?<(]V+
\NbC/2;HP&WN&-CO?+T[e5P6Z],V-=A19HXZ45COYZSffaT&EdMXL7:+BKQF\?+1
c+Fb;I-aGX;)D2<(@[]c?NVa>WQ>/eA62G[2c^GgT+24HF7Va>B,FAf3OOR&\H&0
?=E[Qd4d&N6G87,X+&J6\d99(N=6LgKgQARAg>\#^UTXS\W)2))+I6=WZ2a>^]H6
b)X0Q&PIBU1:4=0C5<?ZD3VW/WF2C(Yb+g911MDX0Q/Z\^Zd4Q5L,Md9P)F<7/XS
/Dg1GR;KM[5X2YKOgC?@Ec4CJRFO4-,/<d(R3TE5NQcZR4Z>TZ9O0G3\W1F[KFgN
R;A+[ND;FaC&([4]FUfM9WLdb7cK0?.??G=S?F5ZaV+Sc^3\YC70@HK0g)6VUfII
G^N^W)=M,37^]0P\MfSE-\U<2dOR;#9PB/:V8O(U\;Ea<BEP;EBL6b,JZ6;P)5f<
[XbVLS:L>bZ#FTY1_6(=<7U+TILbaga=5E:;@F>O9T\O0FO?bLME#H3I2dW^S?^\
R)WH#IgQDcH8U7\G>?Q/cgQVH<J]=KZ:K&YS6UADd/S@E=:?M;Dd7IM7CH/gS65]
#OJ.CSac58Q>+?:LT0T/O[-SO8RSe:XGF3L^AbYCUZU+0Z_#JeOA@CP]:^_c<L/d
/cS\M648K6af#3>SMd1@T/dTbgSYZE2T-3+FA/a]\UB/PAgI\?N3_DcOAPBcf0Z(
&e&3;RBU0eKa;gJa>2>]7/.WJ4AJ@d]DeWcg?G3A-/P?=LbH@:2EOJ_\(F9062aA
OI&SA:M:AWg?2^/?HAWe=Y:a41ED)(]g#SVN[N;SKgd-,F8BI&&U=Cb;78T([[fa
+YGAJB6#0@(g=[f_I^W17R:Z@2W;TR+_(N7f,>Cef=_9\L>7_#?+\KE69R___BcS
ZG5<R5?T#=&R0I&PaBV[FN\64@\S>ABL:_([081W?8gE/356:_J8W)a>P)E5^3K:
COT7E@7\V[)SSZH^8[\7N^>31,&PT9_03Zca:=L,;f>fQ74+IIa+gE^;,=,>DN]]
fKbdC-8S/.HNW1BAE[J9]-G5SYZF1^NfD9&e602-=JZIBX.IH[8CCOUD,-TgUa.:
GW0-VU2f_<IE@]#20-Lg(=>2&?@[E_;2KcNIJW^6TG?:(X_f8YBC?H=MaKI)H4@Y
4/:g4,RddBeXV(;[G43DS.]6&>UYXR\Q9Dg_>3^d5GW\2G0g<FDT8-C9;K#;[M2I
FFE_0/R79SOc<,6d3L/,A(CR3H]).?<3+EB)#a/UOLQ-IdK@K&6g)3V@]aE^)M)g
HQQGg]a59(c-#Gd]6NL)UeC2#GQQ/P#KKI.ZLbFc;[KAUS:3SJg00YRI5_(IdYLX
+EUUH,()g6EV\#5AKZ;9-C?_fJ-aWQKI)d[Y&dDLKFG=3eeFa0/]b3KUcCHMC<bQ
0&7_(d>dg=:T8REY/?[6HdB#W_4WaII(7AFRGC4UIIHN.#P)(Q@f9<IY?ba:N<^4
:[>D<gE<2b@6.)]>3?g-75N>LJ[.9bA_Ee\KC685JEOf[Z9/;8/Y<_Q>+)(Q-Q_,
UUF_+AfJ3I5_)gJSb0\b>K=OF:X.HU^V6/U1PH<PfMg/(+c)Q+A4WR)T_@\-5C=W
/M8-g=B9F5;A_7a]L_4@I4=&^E>UME\VB-NObI176aQ9NcI5GY\&8N@gFFQFb1B<
E0cb4?-@&eLS41JWOF7:+5;#]1N.X^I[a+=D.,S^1HJ._gAa[<c-b0eB2FSSRK[Z
SU7;2>gJV)If3&f+Q)D/T-PO\WN<e)#E,:?RHMV3DU+E@WXWD#2UBP9^)]<4G4=+
M./T>-SX3IZ#e:CNVQ-2\WGJFWCDb_eC0UDK#aY1fLeRf+;&JR+=1LH27^<9?2/9
Z,X?SRd>T9gN3DdX^UIL(J_?+a7d]B-[5CJX3E>5bfX)bHWK.K?IVV0K99#0/&[(
<?YbgLZ#aCA(A_[KDUQ?ASaGSP57X-Dc2IRdZ/,;XV\RP/Z/;M-Q8R)ZNO_1BVbD
^:eaXJ(<NCIFB;PKcC5=MfZX[f.=MD>RY7fI&E]d?EAUJ&(AU+5.5Me/&<bKM<:H
)=de0LB5^VM]=J6P(R\9((VV]@<QI;MJ<(Lb:F_D>GJ46.&@6Hc:Q@.H)DAZ:a)^
B#RSAe#/7bB_,L@LM],eEF88GW)8c[=:L7TPP93/0]Yd3P.-8YE,,:UJ6LEe.KTQ
57_HI#>[T5dE5>NV#A:a@X#CgVS0f7[DBO:TS_U7(F=(Q7Ygd&7g-NH7->7#_fab
#5d]J4ZF5-I5Dg[b4>_B;-W\U/??FX>+GZ#QWeI]XCbB_Xa&c&PUM,.,L8=AeD@0
4gN(9>IZ6PD]JfJR=:Z^Xf)BL3&/6Y51_89>FS&gb,0Z4L(L6I/#PaYGL)#5<>1X
=Zg/U64<(3gU:cQY^2LEgI[[=^\g-77LRLYFLG;=+_NcDc-fR7GF?IVWU#LJ)8R)
aHGHJ:FBbINBGGJ?5aC;RJOc.]HObI030bA&D&NO(Z?\,Kb5VMUfO_CfL3FZU^.a
7W91<)4bB\<JY)87R+Z>KR.CgNZL+\/FI^8&]&T?)W=T^ER5]J0PN:cIRg[@eBdd
b7aB#L&&L25JdB]4V^\dH/MW,TAP/1JNS6))VIX><U[U#a[Pd=K<M9A[5(P-&(_6
L/=d4VdJP.(/ZU[cHW,-&@:UaPVRA;YJ6d?,WV8V>>=EbGIX.Q.4YDHC,WMR:BS+
-#2aK&@L0>E^Ie^&TVVWg(3(D1ODaF<\V]3d&W8^e[SCBPZSDg[>0+Y>F.3+U8A2
f^9;CX&QHDQU]\-5/K+gC?Y8O5^VB[PeD[0]X#.<EI;&FA-4C(D(;L+E?4>+T&e5
eQJ87\LVRDAX>VH[XG#]<E^cQH-^dAH6BLY6MM>e;.-dU5&5F0)GZ6?LJEKLW1EV
d6OA)Ae[1e1NLIGW98BPXC<d[>;NJ-3R-CaR\T@.N;>Y92N;,AHFM4X&bS@G74V7
]^f_c\U/D9YZ8YDJAbYL>8J1F4R<)B0M#BIeb+9=K1^b9R1M7J[L8a[;@DLAK<B(
@1O>3e(.\5KaS7:)^H)e5IRW+4:K@UL.2&UcSGELPZ/I8)d9aNbE_b\^+][A[WC(
)fcVW1)H8RD#AKDFL@J:Z&(<N0&Y1F1#21=WB+ZW.2#9S2J(Tb9O-#7\C_NA(e7E
1SL+R^gRA-EF0e6L98+e>U7fL#YEK3e_J<\(T[6P_YOc[Ug,a:@KWA:-H_dN_Y&&
_6ZdW3=a,CMEBB03ZZ]>=3cV:6Y<N^J3Rb#R#:YB(GHR1NHZI.?Ga/__CQ:JU5Za
XYVDMYWB(?J@<3G-X@XUB=9M,a\CRKT0TW_J].DPBd^15=_N)PQ^VR_;LUETYY;4
2::,_DN&#LJDgAZQ+(AY9cN@DML-M._=eM.L.F5/RLF>]/gU;V8CURJZ4L>eCUIe
d8HU9.KEKGEg_\<2efZU4U?/WCA;P5@7;I;Lg1;2bSY_:UWBS)Jb(/,SX=71&QU^
H.PY0TSD/Y8856@(\F[O6d,OQZ4:H,dD\e.0(&a+U_7#W]B)LU]O^5JM8P1>6&O-
==gVNX&F>LN)S=&fQ->-FVN>Q3W4_O_/,M>+9&G_c81X^I</NM+[e_WcI6YV7MI^
^SN2STX(b9@3E(fKT[/2^Xa,b:?f9c:Bd_:#W5Wc07L&H]=PBS;B3S5f;d066L-2
HX3PH)<dRTSQ<,ceg]W>PDU=GHTFT3X?cVCd(C;AWZPH<gaQSNeCQU#;LM;9fL.>
#C0&R2K+LDG4dcIZ6JG@PbF6FA/(d#)?A(=NZ9W=/)IUF>7HGPOKZQE\U8#ZY.4;
.=^f<dPZ)@WG:Zf=U5_?HMRV>G.D_FB1FDU)7QMXV^H:KbTaES5LMaV@TcW.6f#S
CecP[d1dff?CG]D7Q?DVB,1?b2ePb\ST(cAJGR#fXL)Q1-JPf2Z:bg<Y3.83(2eX
@=^)O\B@W.F(V4gM;@XCX1#;^gDR?O1@5-JGA4T3gKOP]5,?.M+H[+&f/X=Q-dSL
KQcVe-@,+Jc:g9IY89[R5E=S7H@ef5^D_RM+C30O>.cEd/TZ[VB8KT0WC98C6J(4
_H9a1e\O0]24Q.^J>FgX:L>QZJ^e4TB@XUHSd(//;MP5>)Z;P/LGMMMU5P8g(bIC
\-OMceB:3W2F23]>WTG?,8UdRb(;Q;ODCQ5J6^fKL^DJe:f/2;gT=23F]S),0.cT
1#;.<>8O<2X/PYM9TU-W-M=^_cFFTXRcM_W\@\PGAJSb3C78&:2(e4ANZG<[4W=]
(H+IE@d1M)QF6J7f@]g+8&-f=]#.8:SP,;H)@7c\P_N+<Q-^/0>\[8IRg(gEF[D#
(Ld]>f(a<R@<g=)?&A4g8X^_^;b(FEOYNEP;OD/[eR@eBHV]0(8^>8U64N7MS)3E
.V#.M0JIO(QcANP/<[gO,=Z?8S-[e_aY9#R^b_E+PG-7Ue1YN-YV13B/Y?I;0,e6
eI2MB.GIc<L[N(X>dd;KF53]GV63-+XFB(&L<6+eF8KR6E0NJee=Xa.Y<.TSMYDf
R:b=5Yd,181\IEF/TAVGeT0ST9+ca/b[\F/2_d,U1U,_;67F_I9e5&<];3Y5&]c#
[T.,DNN]9C_?(]a68fGB_g)5&#,?&(\=<#TW)D(9eCdB_3(_:-V6[M^_YgT4;[7Q
BDL1CM<TT3GVO.gQ#dVF(]]SC]\-0^LRH5D:d2JIbA#@T]FaeB&E75[C7F^W+8VD
NXO3;?K/7dM_U+Ag-:ZILe:TQ6UE(T)EEC]SVaNC=DUWRK48Ig,Z2U5TH3J64]M2
,@CDBB7AB&],[=6VX/[4/R.?8D(gdO54]L0JEb_bUaP&,.QKSOfB&=4TNUg78R,)
1&b]1(36Z3]\JI_RI/1)ddM40@/_>X5NG32]M2GS/T^O[,Y6E1\\[/C5>9ZXdTDY
b:7Da[Z3K2\_FF97cfD=MKe;ITRgg#L_&R=RP#:B\9c3=)SPYWR2EgUH(O6de#DN
;ZW7KYBIIWI^QX@\[M.RD2JcR[Q>W7:-A.=8K+/6c\bZdJ\Ld\M/@YU84(.-5S/I
_1B[7?+0KR?gN/W0/,S8,+De,>8cN1EWCOQVbb;N=e94EAa?&ETL[I)DIb46ZZ5c
\>0RVK]P:?JJ0N#KW(AIS@_/XOH8dRDWbAA6BC25(OF?I8Y&Q\IE+&3<X6EI>CY]
/XG^H#NZL4L^60Y+]g[W<=3V[c^eO;<LW?&,FL5Z9MFS2OG79)MLX\1]8Y8g+fY0
&++Q3)X-CLNC(.W&cEdY>JBeG+(D#^#2UHIY++#PJ1[6OX<FBEa_.)9?<d>fIS+#
=O(9HZ)bT0EM:bf#]a]dWUgM^ZTV6;.bO3B^?LQ_Zb2eN@YKQ9B+IKJa;L=MI6,B
_SHNIfWdZUU95ZS;&5S=3_#7RJMFRX5BO:Tb@U?Z;HV54/(dJ_5c-NaJTg-UVddY
T:VN@9?8J.6),:<IR?S3cHYM)F9_Y^LFdZTII?cASUe\#(@S>-32I,,Te)<<HB@E
<.HE>4\:7c7;KR.d]YZU9#Cd)50BP<UL7ZN9^CQg:P9^LKEcASX+[K)4X=W2K]H;
?SDN,4>GeB\2GE^eZJJVF1\;FU_WK=4f9H)BZ#NP>,KLg:FYcWH99MKTOLQ3AT.g
:IY7_H&MLSgbK.2PEKI,7IX0&O(VE0[<G.(<]=JIXA2[-I_>ZK:9S+/0+V]H@@Qb
4f_K)PJcP2U.9(S0SMVN;RW(L6Be,+[GDC3.POB4:_<4#(XeOQ\@Q)@LI1L(QJ31
Mc\JfH2@KIU7)H9:]cT42g2WA/9K0(A4LPBfHbcJ^P..[0<&(LdT+gAE#,BTVE6,
c[D8M@[./-GMR2J&f-3=@VGCEQMRK#20P^SbJY?9K4Q5e+()DG==NWKE+2BE-)O0
/RfYJ0KI3OI^3d@,9CC<_Q&\_dO,(.7MQ,O1I1gJ1b>,]1&8@.B=TD:#)]K[C]W1
U[G_75W:B]6&9>_XZ0W@gfd.FEX>0Z&V,65dIZ0gS6Yd3=)5E5+Xf37cT7Q)0dD)
C-]=B;[6?D;bIe<F(aC_I4QDY7+-FZDA2eYDH;Q;QL^2CScDA)5G]0?IDH450ZaF
Z--CfcL[b]Y,H&Cga6;TJe:>.0EK>KMcKUI_CN+12\Q#9A?e;+R5VA(8QY24OVGO
ODQfRFI2gHMb4(][Z9CbT+5b#QW.dIWe]F@]]a<[>eRHATS08?4K8dXA7+WIa>W6
/#1AdRP[?=O>c)CR:IBV<)=-Qec1TV_VCDd4RZAHD&HLU.Jd0FA^@(cG?X\c&c^T
gK>.N&dD46RgOY9VTE53;53dID;N,&KEJYE0,88>V,_AR4TDL/Z3M_cIGX@0O0P&
PU2RUG&ebD,-3C9?Mg[R>8AX9+Z>E79MK=4M9Gfd&+R&P3UGERW1dGVU5PE-Z<-;
-+AQH_Y2C)Q>ad.<eEKN[3H+#Ug5Je71#6PT9G[Z<])1(\dRFY^[7#.f5<@A0]D6
acLJ;5ZPF8?9/BHYU>cO@-OLF]I>(7Z\af@C0..g20=5e6T,EN[O_#+Oe_cKL#BP
F:cN)..S><4_BEH#,G##AB@#Bb9)3\S:e:T,ZEd#,M.AKP)_K+GH&ggZV6JM=HNG
8Q];O[I1I^N4OOHS:Z1:(5Ta<:1B]-U/F08cHG\GdK><##VcH_^BE\B3f0)>?<:f
[Qg4(g&TLBS9(f2?be7-5#9GE5NY+YRJI)EBa?PZXH7<Y&^56X<HcRE1+\B-;E^?
d[3O2A<JEb5UTcRb]JM29#e&]8E.8@8\BX)-F<(9cR-+=I+NJd>(YD0&b__9#IX2
&]:b\;gPaE)U&CY^a+3<,?g?TWSED5AT;Of=NWg#H_:5Y9+(99CBS5e(bJ?f\CXF
.C[FfHZRMZ/RTf)IU(-GT[d]]FFYDbSW_ZF,FOUG^U]73g20,HK^MH>d7a0/2G9O
+E[CKVdfU30ZG4S,FZO>WC0,Ha#KMC,P#J0M:T-d-=2HA_^I7JcH,adeFDP/FGB1
_M.+GUGRT7gWQ04Oc631P8cJ;_E_dCfBZeI>9>^1+/Y9>/I=bPNX@^TLfYM#_Nfe
9LOJZB2)BZ_BWQ]+Oag8cC<5)bR)4_JSUf;IS@3BVTA-GZ,bV33TIW@I+@^0V.Xd
K1aYR7=e_NOP-G-LLY/2)K#4GWcQ+4;d82SI&CHO&)GI;H6N_dbY1_#8<aVN@A\\
I>.ZQ4S\a\FaN,d(D;b<CbVB-fH)JW9E):?,?cV5/^J2Pb^RRUNH_9X+)8B=L78c
;M\K.d=E7+0\Le=?SMKPV;17cd:EIdKagF5_3Q0NZ][YB;+(DTQ(&^8W8J80,X[Q
P4<g&e0/>7e\JW5OQU5=#Nd36\eF1AW[,V\BU8:C0Qb-Z][@a=R3#6Q@]FJ1\BX8
+4^HBOSVLB=JHAd/AM>54X+gH37VP9NHO,^I2L:<JW)NG[2RLWQ71>C::PD@AbUG
,N@]P9C^Q;b8KMce\98?SAEGZO6.Ca>O=TVVVD>70,24(-SbPFL7K[_PK1:IN&#H
NLZ]#-ZZH)ER(+VK^)N(JOdZJ62\eK.#7d#//X)GYg@_C&&.S=5dA>YM87\Y&>?0
JQ5NU1/GZY/>5dbFWePFMcAYgX</A5_]Ib.TZ7:aH3GbA8H3PK2V>,D2[^AIDfN>
:7(E3a=3HKL8]R14)B=bF3YOYbVS>dgIP..8+9PII&AD-A3SZCeICNR,>eQ]ONKa
f2@K2U[>GD,J]dZNKVg=?DDXb@;8FU^ebY&eX_L(O<:DI5B)XCHVEHafe?62c4F(
b(R3-F7MY9-#QTVFcdBG0#(KJW_TV21;.E.]g?,UES6@9<WbH;6a6P#b9G]NY.1N
ZO09ABPa7dRZfQICLT:cW&fT,(=44<5:0:N6]\P[TOSE+Z)F.7SO9c2SL)aO4D1T
Q1:?;C3IYETIJ1^4L&eUBC:QZY[B?;/?1#EcdVRBG(R6CL6B)OB>\]C\Z6,U4VD4
-L76D\#(&FV3L:TV_<JC@PT_EVU60I&Yc4O,.U8^L177eCgC2eC(TL6eIGQR3G5?
P\P:2E:-)^YEX:g;-<^ZF=CZN=;dc8+EW\1?N^)6RQCH9cdCCC^JQS,W;ERBZ#MO
+Cd4#,MB..Jb/51AJZ0:CQ?14;QFQ--Y0-]K6)S8H#.^Sbe[.T5W;dWB&\BU<]+&
2HXOYe5:c-fUX#YLC<NH0UGW]AZ>>RX+\g2)_Y88Sf9FfO1=T50D6fFU\-:fYM5]
OU?b1EP3A+(7(Db]-.N;;Q];&C8cY):0-c[8]f=KY0O<&^DfJ==]KD0HQ@C@GM+a
@A88UeTT-R99DIW#-#Yg4>)9cO;\<MZW)VUWT:R@GB-d&e,\Fd]bLYE5E0C78Y);
>?J^L4ESg4H8YH^-G;L7O#G2>[3dC_D/EXT0OTOK06bTE?RU38KDP/E=Kf@C#DA0
?X4B=?cbFaQ>FXT&EIMZJ>_fT3SCc\4\>/aeI#)0)&=3B]VN[>#5;X2Q:,Y6.ZFR
3IL8J-9d:AKI6K>Y+=,cN;SKa=<>b\9O\+7f>YgZbI+4A([?O:fJJNPN][Q#6)/A
IagFR)2:@255Z6,PL,13OORN-F/<]Z8&X(-@WgJEbK@AW8A3Bg_#9_:OVe1X_H(e
#3G)9eZ,[-,V5MN&d67L[;I0IHO:IRG\ZYTZGME6fb(=dOFaN6MKY<,;N^W+P#4K
N6LP(cL/P_,XfV6;Fb+#IG2b;UW?NT/H#[-+<A7/C[dN@g]BB:JW:<>=-A]QX/_.
GfEIW@AEaC9HJAKf+I>V?a\_=<d/JKK?a-A-g2.R7DN&@\>)\M]-1VCd^:E1U#XV
2Ug\JXPDA,eg?&#U3.VKM)LD,F3c1HW[>/6AdY\SRB2:bD+d8:(^OG,FP#^7N4PS
T8ONHI69FMG>J)++NNZJ7?F:Y(G0^,J5K#_ZN#QHWd8L;_^F:WBfBCN\ERZ/,1EX
]CA<8Tb[[9WH.\@#]C1/dMO[PC7c;1g5]WVAUGLP1Y\.V>,,<HFAabRcKI^M?CW7
49P=/Q+=[QDVaac,b^[J/Q#+GR?Q6()WaJ&0C1#N++g2(88#D.CF=9Z(V,eZ4P-&
@C=XUBf-<&_]JY[>e9;G#CF9YOC^:d(Nb=dPH,(/+6F7>3.B9&ba]HfC)g,^f,+f
^)89M:,)--.0W[P/SD(8](Ng\N5\R5Y#be/F7.C(gU<PH_0AHG+X9RRJ]?b8f)?Z
KK@E5P.#3YRFW2[9BV9[g,5Y^&>]T00XB#2+G6R#fW\)TDNbGFE?f>GE?M,X(65;
2^IZ?MXaOY,@?3HaL<C-b[B7M#:N=#8Og(XcY6f;b)T.ceSKgb.Wd7ZM8X-Adb7c
S)HOJR,8I5EFB\9bbW<5?9a;J=,.9];SfLX2MO(#b0@D&(OO:&B@2cYU,V#+^KV>
=.K7@Nef+2?HDGY^LL-^KbaPF?Nc9OX_F)DgKVG;WdM9C5LHT&7+X=O96FYgBK,c
@_\,\^]/f6P9Q#,)A-99CeIQI]=V]B#2g+B198?^Y8@aMJ,/M;T:40Q;J8e)bVIN
P35&T>2f[FM42I#8::]Z5gWAVPMI1.]Hb_N:g+.Z/+eSe4#NSQJZ,+CIT&\Ca,Q+
,Y)PWa@.Q.f?T=Hc&Z,a&XXYGfEUa78HKg^<,_0U(B:A[F2e9@F#)IRTR)V\d&X?
GF(b2;3a^:(6R5PCDFZ-:QET.62YbS=1<VY7G8E.<O380M55EPbPB3Jb#S5c,&Z_
H(=J7;X-MO;H]g(LD>7HT+>W7+7?5G,d&P8.e<)Y.CO0H8&Y7-_f(6a7-<X-.4Z#
@U>(OHOY2/c>L\5L:E<d+Ma,397+W:cTYR4[Ta,9gJa,F.FJ>GM3cc8>4[a1F]/H
]I^8f./BO\U6E(dSRBPBaL1IbU<#81,2/+T7#dC)?aPMQM0L_NeZ8YEL^,AcSJ2J
/WE\&]DM<[E[BV#+O0Y?:.f1g?Q-@d4P#TCYBIUaZN4\88,#g>>]FTLeRK4aHI@U
#DI2FD-R4gD4M0SE.F84:GB)CK63^LdaEQ)IG-&<#Z5_4Y>9Bb29:3E:2QK:1NRY
0ASF==fKQ:JOWV11^G(,(@gaM^<^cUKX2/KB[@JL^+_T?V8<3R-LB]?+A;Ef/B@J
^<S_8<W8A-dR6bGOR,a[@/)D-3,C?OB@)c^/\=g=&A2M2W7(1^VcV^9e^=:T-E[G
A(Fab&CAI^?I=:80<ELO]MSc4F;T:g._FY-T5<?PP=MePe^_eLa+5NM\EeTa\Ua.
QA@_D632Q3(1ISOdQ_S\HK^^^=SF.D8PI19FL.SU&4:?#[I<JQX^[21\M5UD=]#3
;Vae?8()NfGP-YK2R9L&^G[;987M<<XCT+61cK>C,F:EcA&O3a]Q=4##+N/0NC2F
1V\(+^-d1dJR62DNBVb2E,daOc+W4+/>C>XPS;A+^UD<bSQR><.F;aK/>Z/:5HbN
4E#TLU^A<:cE_5(6/;Bb(R>K@ZOJ168b,29=8]+CI-;JgD5fLbIY/<G3^9e>J(+Y
46dG5f?)P,EBcS2S-)@,+S1?fR;fURD)4(,#JJ4ZbHGGKBb=AYMT8:11.[C-Kdd9
2@Y^+KI4-6HC@SEUVb.74>aTORSOP0aKM5@PcL:^L5TAY&Q=2<=bfDZ:PH=QX[K3
-KZMD.Ag-D,^[2Ea-H5QOSE\=3S19Ce,G2bO68)\;FTg>.+RG.>e98cD=_YV6VVS
O>cFJa=;I7VFe7gDDXdQLCHYdbM9#bLT4WDB+a?UG[ON)_;5&Z8.6I8#@(>5#1T0
aAE5WQ4d_0(H:c08>X521+P>Bc4@bTZ7LP_IJRY4<9>+#7MGc61]WFg>HPGPcN7V
Cc3d#:P#Y@/NF9d&E4ZK^RDQ,fJWH=gKP3cI6+f4VG@#6#Y-DPLY6_R?WN=EF:2&
Sb0NfFZ(bD8:L1#6Ldb)MGZ-]0JIfI0a;Z4fY)?VD&eL(dbIA#(O7X8U0S::85dO
+c_Xe&PR<TXF9B&MZd5G_ae@G@AL5](e/K3&849.Z-N3&ZTK[Id(VYYMF@@N_PG^
1BIY?^7<5,+28N)#0//Ze00>8327Obc)EM;9/EX71\Uae)2Ha.BQ=QGaGU+3)/:V
^ac6)=KAJZJ7K1O<EA<H>F[=T(U^gcc_U21DbY5?FQY_:/D.R(V63-3LE<<d5)@[
>9_TePO0T[_)K,,:S]g=Y3SN?L+4E&LdQ.)#&H-3_S3G6_5:G]F7#(WDRWC0[-/X
7CTL[[N3\:^+AM-a(IZfd)&72d<?M;APMOE^7ZXe7DOU_e_>:B5F.T0OY+@0)AY>
9(.:SX[ZQLFJ,MdR(9(243TC:YI.EC7994U6?])X@;.54&<,@O2P9ZIf(1Gg\5X[
FG-aKcPKL@_Nc_/3@9]f)[YeX/:>_>6cAD[&F9d1];SKGZE8?(P^=)7Y4E^&IV59
+U(?56PB)3@QbE>4YDKZBa]NL]9#V=2KRBU0C4VDWG8J/?fS)WI9(_R,+eQ0gL-c
b<-K.dK-;7W@YSIYUL><+6<]L\c&_;-bZ<=b1D#SSdU81X_9e?\L/Q6B]BEgWZ2]
Ta?3.0ZbIK@BA<#.D2M7-)DeD0P2gLFRSY,B5.6_=X=B^SCa,31Z)ABU[aB4S9[R
.d=K=9;f4IL5P/345Y(OSQOBE++Zb1bPVMG-?A+?H,[F)+S2a_WTF#3Vg,?DRRMG
GcT&)/9]ZbWO^/D<U+_1AC16)CYf)]8f2d=F/Mf[7P2:AeL)c?\_bSY+:YJDY5)=
?,COD>S6KMWAf(E(2aTGM=A2_PN,5(Y08CRXfUV:g_U:O58S2J<HO6a/P[:M=\f7
=eJ1^L2>ZA)&_WE-6eA4QQ]gV8<g3,H2L8^UL(e,\2Oced2(U]Qg@L[SC6@&NQA@
]4A)>D2RSZA)=WKGVH9YPZ)gBJ#A03ORC&5-#aQ+__UQ=6JLca6A4eG/f=N@8.?R
3=7>T9P,[I]?BWF9Fa)QM@>cLE#-?d55Z_,dTB2B++7&+XD6AIC:V<Y5(bQ[3CbD
a4Jg9UYeM>PB9C1A,7=P&FF#bbTTP/Y59J.1<c.Z9U3IP<=,\N9><QdcHOZ(@=/M
P=AIGc7+U4?L,C76CQ)GOP,gHVM.Y>2D4@.gV<O6P]F=[K]>SYHHB]O.UX,&5W(9
S<K02Z.<_CH<N/TJQPXS:(WS4AdPH),b>KAQUE,cOMCK#^a_/UW#LT8?D+R@F/9Q
Se:6FU>AICG9FQdg>/gPV0-B>fdQ8SX9:?GS5,)MIW-H7P&[UD@\^HK@.Q;RA3ef
UbLOcI#1MC#R,-Hcg6fY#-cVf6Va0;9^c\]GG6X@4Qb\8@B#SIc4AZH5JR?IVWU]
gAPAO4[;eFG>K5_4&;:&2e](3TE2W1^R.g,gJT2QbJ9J[DX8=fDb0W@@)3&98_I;
TV\O,8a8)XE7O\cWSg&L@5<T.;;f<2I&Z_UI91K]#Q&Ad=1NZbO2TGNDd_f^_.L-
LZW[ZTS(;J2TggceM31cM<SFO9#.TDBTd>d:Z/4)PM9d<?7=NR)2b)cE7N7&FE3C
3.(;D9,?0(-;^:KBeZ_HI3G&#.FCdH8HQX55T8fB=W)]e4;])?N?CV(ZJC?(31+[
H[DP7S6Cb;^8D(KQVb@/f6&Ge#NP[8O\?(-MK(IR?:R3_+[2^eHTPW;DU/gUQX[Q
SDY^ISYeUQM\\DSM9-=/^CcT@+[JHK,BXWbH5TZ]37.&[acBD/L(UI0A[bNK-4GO
)b1&Va^^]g4@IU#]H+c2YNU^[.<UQ+?KCH.<@G[([L5^BG-9)+bOT=T.FY?bPd\5
(,6[6PB?.\g3AU#IN@?VK9fSbg.a3BBNM#2fgUb6RMM=V]LM=M<WdBLOLZYLFA2:
?dK[X-2Rc1GJF)W?dJIb#6\<Lc/NFUD2a\/,5VN@Tf?(/,^1GVbFgSESP;a;]ZJB
HTfV\5_&7-Y[egTM9IQX]6(ONKJbR^ZUT.g7_BH]=CE^:P,W/fc)0=c@W8</MZ\]
e6=S5K\d]^HLF<&S20[&@UDO&Y:GXVK8&+Q.;Rc2J1DAAN\gQGBb.aB7I]?@[6NL
8X=P>HQ736&VRdfBPWUZ3RGF,DGH9IWVL^;\H,+9bINd5b+3\B0aM#@-02&4_0bV
N?QMR>=SZeC]33E(BT:IRS^F(:9L\@4aK#^I&+aTVD[LZGI(8@HN1IMF2\A^P/2B
,fG<?\Q6Be3eBea(CFa>eMU._Hb:[2ZSYS?;.C^^HZWUa+a).cRVW\(X]c#/OHH@
+fc;6e<MPN?POSMX,JV(31Nd1f(CW.Ne)-8ED\AAA(O?JGP)>U:??:fC:68+U&>5
-<=I,GQKH3)N2U0JaRSaH>D+g1aD5-a6MH9[B-RBJ(ecXMD\8MEPcQ:cf6<._Q<a
]bF0<Y0[]W0UdRUbG]LbBQ-<<:8gU^1dE]RYRL\D(HeQU:UgbD#,e;aIJNM/V;<Q
f0K^0K(Z&QOSR.91=)9MdQT=,g?O]E9?\dH(dZ]a[CTUI6M?C\R:LO0/\TW.7NM@
Q)Me:2e7TBC47g2(7M883=]=M]KAQP-QS=CC=TabZ_L3V9YH[Fd8ZMFSZBO<-7W)
FdF,JXLCC0b<Y2.C1V?)^B>H(e1B+\JIT\,@-^D/aJ&)13E\f<U04QgYU@4/f:MJ
B?&cA45TN>bCB4(3P:-TOXTF3.GcCP4,a^Xd^VZ?^W(,,PZ4C8BG<]&7M)/E[IeX
=T<):4:]aRK@:.OL-^0+5(c^:_&,7Lec8?X9Z(:?6C+(QZ&1::Ifb@g,BNTK1bZ+
]-d1=>GK<IO#Ka1^&#5#_?a&U?S2e0fE^\F_^N7LZf2]L8#;,fbEM@bf_JKgM-A:
V1JRATCXX0]@f#@K/<G;N:f=8^BTI&?Y>bY1(N\g4I@LgZaP/5?0N;,;D0@4^<,8
]a?SSd^A=CYFHA/6?Tc&ZQ1;b.#0YFK;EKLM74+b1,UV4_4fUO_:\S-7GML+KD@5
a[Jc=90/b>BL>/:f6ITadFO]Z0-#RT/>.^NU0E,F<O<Z><Q<)X]RS,=DNJCV9\(b
C0DcUEO#>PV/Hf]P=GESEaaOcd8>3)Bg0.0PF4&b#+^>0F(=#7DAJ/CK)OT8dfY8
52_[QE@L\<CU8>Q7-M<77D+F?E3I8,T]\BR2A_XA(6?3S)Lg7eGLPMC#DY3Q)C,9
:8E.1>\gMQ>QI+4^SEU4TAM[86=Z<Q\#a7K89_-U?\[+T^-:?b8Z^1SVA?3D5(<C
O=[1LDfHOAe;O<ZUHd<9c)a_eHQM_@L7D#QB5;FA4I4#gcZUI\^ZTZ5NA4MJ?4@C
)=-1]bBQNUBPGAUCBP<>Y#8?Y4IKF&+EcW;[#]K2482WH8>MO+d#-bE;QWOZ?/YF
X<8YE3M>4)]8Tc]PF](.6,PgY?0;&f<=;RKg2+:c<Tf3#gMW+;KTf,:U+Q@[;.g4
U1)DB63\U4[VWI@0^V+Oe#HQa(-8g>G56P6864QBJ98a3/;SRAO.RU8,ODLBF2QM
bQ[VDebO7M./7=eC+dSFT6)UNLY+/\G59O8F3#U\)fCd\F6^W;PNL/ZM\HMH-6\N
L:,Jb,B8#gT?:+FE.&]A(,AQ=BM>..3+Q6(O05OR+KX@6A9gHda9+Y,CP,#U\Q>2
ASL:^MA5]\8[bRN^8^2Be5fDIY;DA:WeZ9EGW^@gWU+\HY;S<GWAU@NPN(::6cOY
<K<8d[+[GKE).6TDN,.?@/P46X5,;.B-@O)_H)#EQLU&E[c:Q>&&c=&##>Ec<J,&
S/K;63.KFB/M0ZfHNBEMWG2>bJcKULY6E7(866XYQI()a7J1ALQgeS7).R5\<fHg
V5CE>7C3/QeARYM1e)fGVPJ+7377ZDVHT)cRU/e&W.bMFTA)\KG)]IV?PZ7N1&N.
0<3TT<KT6T&KaX@X3\O8S-[M26RV,1P)@PMc^D&UX.0(P@aY)Te31#d7aB;4^65I
E=2FS?:F/a(RJ0d/cg=N2X1-3T_?\95=Q6\WfY&,cK2KY>++fBWSccb]C;MVF;W,
N8E7A=4SI;3G(7.\ND7?&T\?a1O9=^06b,-HLSR6?>GD.EVKERQF?RK-c-IRX&&e
QEWJWeS@,cB<BESLESHe27-==3Y=_3d&-L3c35ZU;<PTVN:fM7g+5D)cd>O7T=-X
=?f9e6E]=:RbAPDAB>^H+88G-JQ__2T<58b,@2Z&a17E2,4HX]L1a^X=cT#Y#4.M
G7LESeE1XF;N1;#9\8#aB<(Z>GXIf<DD3K\@DE4Q?dbW9;-1OO;K7:G@[HBY36;M
:L8dNI;:bFFNN&aV=#>d:TcE5Gb=U=gTbJ20\W9<+.^+&VMRKWd#S^9d>C\9FK[b
273b+EXOg@COSc1gON+R_fV7HV]V)^[3(7,Z-(2VX6G>5Q6+;WC^K?BZ^-dbA@MS
FOLIX:aP7DZH@g@a1MD73=-=>>aWT:=],<.217?+2f(5S0L+g:;b3FaOWZdSJL26
eTOSP3.;54d(HK=;7JBQV<]A1F.6,@E)99)+@V49_S7F:[OQ:#f:QLR+HL/e.bd(
?ACa\Y75&b,U99E+<S]FgA^1J7I^LLJ4Q7\Q<ZT47Yf+(aa\M1OQYR>d>+WXG5I]
-c@B.)dX+O#\[\^5+cO=H>V<(B(,DYU&f+O2,0J0/#I>gJR2DC7P3LIJEc2_Q=2H
<ODN>VR8<99R^YD/@[d,&b^)(G\U[1)<aIF/bL=XUGY(O+N5aRURWE7FG6DG?/2S
]Q#=G&g&G4eB[g-17?/UJ\+fNT43+f.:JI5NH_IGI.B8de3cJ2^>K8>7V)FH-4UP
]+4M]5QN(_QU[LBPIb)@:gSG9R>JAO8-[W6N;f2MVJQ=L)ZU-_KH<,bBeIWK5cBH
N4LX)PdFNTd91T?e7MV.L:0ZU,2d6L7a1RXOA1XCIaV./U)CHR)M(c0-)BRZU(CF
]bMI\PKA4CIc_+Uf7UG.@#\J(Z1,W]N-O#I0AYVG;?FNP//0R0]3]=<EISQ4SId.
BdAKcK^F+UUU)g5Q[9H;2_/[gL,#dD449MJ@(6?c[FB,])SRH?N<WA3EcR#(U?[G
R(B+?=G-MQZJF\=7cNgXXUJ@];B]/&KR;:_B^70^/\52P=C40UfF3ULb9gK^H7FT
A>SUbEf&8Z,3?):NPK^-);K[b_WAWJIVJ#BF9;<eC.RRFT735&VJXSN)f9N\;a,B
S=bOX1(.>-0-E-.V]EK^YNUa3Y\ZIJA6V7aBS-+)MfM2XKa?@_91ScL48F2P)f:>
QG3J:TYd3U?>g3eWUUSDKg+-\/\-SJB\74JIH1JXT[.0#dXC_\:c7G\8F@<4]b@-
bGDFY7<(>W\H\5O-Vd6D1/_L.3P=G6\]?<bLFd_>-P/dUZWQ)=#O#R0[H^QG9BB^
\^7S=?1ZEP)c;G4UW:>(aGF81PG2gO[A(6[c&7JDLULWfZ._M=N;9=c800C]g4TY
E&E+1+D9N+R]EZ<Q)CZG:6^9\K.cD<PXUe<bSD]]OL;=KTdH()<6);_#Y0G73RHU
>/Cc23gd8WE(SLH^8Gb+KJ4<bCQ,f^HMaPK4\FC+9]V^7&H^AdeI/dHK)VNO2>gJ
L2:9-KV2,CGX@ZE>be]PKHe1.@OH.H5Q5fd0(QZ7-81CE2.,D^X=X8W79]6CS>WU
KI-DRaQ[2aH#+050K_EAFC>I@F,^I.\,3(=>74GJ)@?N0F([bI#Ob\JNg=Xc4=MP
1F>-O]eN,G50DCg.\UED=<_eF:6QZKX^MOPb?6g<7E#]D_#7+73[X(2e5\+a5_20
Q-JICHfRdQa<2.[ZN57dT9gT;#RY#dPZEC.#[;NNff8FI7(&[PF:?DC]9#dbWQ/^
feMTBQJ1^U0B8F4<K&RNG3YQ.#Kf3JCR-7dP;S\Ze-b31Y.A)N6O-@X7=EG^aY<Y
9F2,BKTFg+P0V27#A,+G-)DKL@f2].AJ^8\0Bd65cRg@?X+b=_>)_02d;XKa?CC7
;a0&\L82Wa/^;dU/2I():)J&c<Z2(/Yb>6FGdDNKOGK@J@F_01B((-OM#APURbYX
,/B3<gWQ/?LOgN9gG1S.7XH_)WfP.cEQUZM(8_XXWA-[=\T[V-UU_A)4?(eKAc45
S]K\gLaNC):71690]BCS(:<^D0U31+)3/+O,-@e10TYgCeLN(b@98D1DVO^P=5:7
@LZfJXUBOR##R:MP;(.-F:&W05GJ+g)M.?3;.d:@?eZTG+UaGOJ@8C;;1(@VK7SD
8.PS^TF#VU>2EPeY&=GN7ZEK=TO,g/[?R#7=^D/&7HV^G55f<;=D]A@aW>Qb849c
=0]5U;f)RUVTMFK3MF+O9a6_.,W]WLS.LDW^FB._XfF0f5<OBeb3=XF?9Y:TD+IX
;2(9BD=//^SBUHAg+Y&]<198F981a,2ABG&KZdB0S37F?_VTP<d&34=W692f^YNA
Vc#gQB>5KAc<@A.]_9Q.XJQ:KC/<eE/Z3/g/FH_:CX5RU_4,:VCX3@\T.ISUDX0P
P=fDI]e[A69I8<DU-K1bBXA4NRO\X(ZDA&;([f<:A/OCR_HU3@_Ad91c>^eWYDT7
@f)9d(1JX,YM):O_/e#QTe\48=bf)_90A]858QD^;MC_VM?_S6=>)72?I,7KUWef
Gd85I\E^7U);R((4aW(XG?2_.E,S9WN&B4NbVJSZg),;0S6F3e=+?fH#ac0)<P7;
((PX^U<NYRWVPHNf#=Ke7G9(O#=DLF^0IK/[6WIcb9G9SIQK+g.2G,TW]Te3/ZKU
\XS=I,P6b43142AB((+2Ef[@SHQD<JF0+?J91TVX]e7[f->D:4MgGNB@aL\AR61U
_,X.PK_AX9=&FJA5b1Pc,OK6YWb7/FSX(]A9A/P09W-J<7@WF<)+^>00<(EK;>^<
/V@\g3bL9SRSHYE,)5BT:gBT:N17f^O9-<NG/N0,\A#B3P+C6bQ,K28REP)QF,G0
Y_\MCX_5cU=P3:efU\\dKGWYU8)Y)^)9IEg\GQ(/?B<Y3:dJ1/:C[?QB[@R8RIf^
&L4-7]Qa>LEBGbgJ3QZFD(\.>JF\7E>XW9JH;P/^\&F/?0JF_DP(>GKP=7-fQ\+=
1<NHAQ&g&SPX_@.Wc/agO,a7Z.+8KfQ_+0eaXOR88]TVa.;\<ee3==eT#,@T./T7
TH3Q-:3BEANWH2H1#JGMZcAOE@Zc0S+?[+PZ2d+3:R7,XffOR;1=LF;H+Q?<P+TA
cOU[-R0)X+S=,bNc2K@&?Dg/?JgAT.U4=8<W?P,4UL<S4,OE1.9=Ed>7=]\?XKaS
4@,U4#:&FZV:]L+CTe4I(e2+66[G34VZP[VdU(7T/.T1B)+S5OGeZBKFU.069=WK
77^_VKfNIWU&e=;gD@+W#RIID(HU=-;9]GI[Vb?8ZM=LaNJ+UR&[\NLOIU[QH4)a
AQJ_[N&13K&cNRU5\d+=VXGV=a/7d3&E3FcDFEa9)d[&C:7I#]++W>236A5KOMR9
Y9MN&D&329D&\4;Kb,_N>c]47WLb=L46T+3HCXbV;bcaf&:1Hc#XcZ<<XAeb#[a7
YDGA45aGfB&6P1@#,4+@G0M_.9GDdHf1R;f6\+]5.T^GM7&ccbGAX\YSe[LN?<#7
4bM)6]I07MFES3OR9-B#3Z7T.JRT,_?[G#W=SW;;G>]O2=<6C(EF@::5&Pb<4C+U
R/Q&3GH19^:aG]4+M)X;KKa0<R,O=XLPgU)6VJ(D_LTY#?JScX]=D/H4=&E72X5>
IH1P2>P6.:e4bD-J:B0[^R>^eBD87@(eeMNEY0L&dU/5&#e/TbF>GPPC5S-PXJR<
YB2gCZNddV9b6>)/CQc>R;Yc6.@F\W[?[R[:Q>U9B9N3geM7[>=c#>ONOM6;gN,?
NB5-.-V:GVI93/.:H:TBI0O[82M#[&e3c(L)M5+]DH<HX/3O6).G4V8Ad/C\6a7]
&;_#1;8FV5^]+D?:@WIg3EFE=;V;7E1?>.Td,8X7bPYcZM<UN3O>a@eY>XQY@A6b
c/@,+e7+aX.YNP@-#(G][N-&(/[;H6&.:5+D?Xd7Y=f3HI7IQc7UPcG#e],VJE&Z
3RRS^Nf#6\e)8=9JOP&\c:-#UB.K<#/Pa#S[)2VHZ;aG-e.Kf&<CXE)YS#U7N>7f
6c:e2f:GXQ_\)CTR/RG)TUSQ/.BC.A;S2VZISOURI-[F[P\,Re,-Yc<+EaF#&_/b
KeA7LM/[c8G2HSB,BR0DQCe&W&L1?2[L6fY0S5+HZR4XF\/a-103(@4<#\8>R0N7
E[7b6,74cL@7[1K+3T[fdX\5FGVJ1G)IKBc9=)ED19_FXYK0.Z:<789E[3;O)/9D
2d)dJZJXNG&dTA&80Qb2?3E389AP2,/CeJ9dLZ5\CQ?8^LW]eb6^2MQgM7f@J./L
O9QSO7.)DZV,gX-?5K<@+R18g3FcTMQ_cDUH^0V0;Q^)#(eR?_J14;:+)&L,T48:
=ZTge0YJ?58+QO>V0G5TYg=2<b7PT.1G6X3DgI+;3@HPTH(3XBQfS+DFSP.4b:[8
143WNdU#P.[PG@:Hd@AV/])A-H,_7Pc_EfI#:d8C27UYL/d[YaFDZ6[MaV7G@GQ)
6NMX:(+?#QRb^+PTN@)gQ^\JLB9+RM6GVZFeCFa_Ib1SS.DB;4J=H,[^<F#1TeNQ
TfYK/)I(O0a5ZJe.:[WUEOF9+V<09D:1C9OC3N/9]:Td)DaJcD[W:S+1bWY>IVLW
9VNB3IN^T]7B&=K,>P_PHW2IWc>W:Ec2UUL1KeHa-c#]dO:[Ae\@KSP##(eW?PFJ
7:YCA(&?V3EcO-Z+=]:BWQG5FD2d86UF[NDZ(@@FF4:@Kf5c4-@K)<ISG<3YUP;C
UP/M@?S=?:C]=)Z+P1<;a6L,OHb&.-+Y0,M[gB#.AGFIIT][/86^d^@].gM_3gF\
R-(>a:__4\O0.>4]&#<GQAT[4W>;De+,DV56=FSKOK_-V[39:I0@ETg\GF]@7?X4
SZ-_Y_::V_Y@#a[DXLaZa/GBfX\aPP/_@WNQ0Ad7L#d0]N9,.P?B[Y1GLd=gc1)L
F>#EY5Q8]25KGRaF)UdB^:B2Z60B3/RB(8ZOP1_@?6/OIFYf0Ud7EQ\5JK)DSG_#
0]R&JaL5<XP_2[ag91#3&PZeFeCJO79P@_]/FQ<_SHcHceL6cBe<]gC^P+dCGAJ2
@dTQ@=]C^D1(.XZgc-1#R@Z=>E=5LHfZE)_V-3N54P?U-eP9Db:.HP7UY\e@2M-9
J_\F?S26+)=5<PPe(,Hd)7]);]H)Z=39;6KXI.-J-<;9dP+S+bS#=O&&\_[d(+/F
U9@BG9]@9M)WJA&P7/LG<T/8-W-dAGa=K_ZR=\;QNT)^=:H4_(VNc)6SRZ\PBECB
.3X)VG.C]f)VVO7&/MU#5Pe@M4ZG(6TPf>V@]NTL0RATB=_Lg5;f<ZLUHPN>4bOg
V5=13cKX9EFLZ5WMW-Y8\bM+\/]02W^]D1+ZEOLY5:OCN.-PO=(Gd8,(I7;/=1-9
I<dJEI2#3X;9g]?NNV.b._FFB;]@K&+2)Z+IT8f@>>D.\@R.<N2eccZJ1[AdPc?/
]N2I\[OS.9[df^dH3T8d4H];afPFVb\&Q@aZN1A6;0gYA,>ZMHNM&^+D@Fggge5U
eT=P]]gG[d8?3/ABVAa,>^O>]3V()f#SMY#4XS+KPT^g)<53^3a&=Z3e^+OdK,)f
a5XDYWCK8C<[)#7O2G2MO>Yc1Ea3Ld9MF+cL48VOb=QfaN>-A;I=TC(eD&L7=cUG
DLV]SIYB\S>7X;HH_,?;2Da102Ne(bR,9ZF7&1&Kd8?4_..U)M/JER8;Se_,-_T<
\D;N@=U@P.19g#KAX@SJU2.@@EdUW/Db<UQ(@AJ@\8AJ^Y<<>D6L:69)RfN(b[;]
XgIf#bRgX3C07H3O&=B[RG(7)S3/b)Bc(.Z+,L^P+eJNI41B/\22M.T+V_HGI42:
M>8G^6(SRSed9Pb;M>V#ZP@(@5IZO6I3OZ=Pe_aJbWE]CNeJ0CSQ+/SA,2a<O-:I
?cIWgS(^43)MVR+X@@X(.S3b3VgO:,A928[#&^J>+3V,04HGL&Y7A#\b2G5BMP?-
(9X\3FeH>S\8bZI\adLA:g1=EdZR]X,Ea5cdOZ,?EbDbN9CVYDFP8P>E3#TJgS/a
BE)/K9DSNH7:0d2P)SIFK#XR>[OeB+JOBU08(JdK[_8TSDXV2aDVfTLF@D1[<HE.
8Wdb?9N1]OBWcH4&CIP,M[A4YKI6d.DN>=]]9F&0-<SZY<347>T]fSLM]1eXZWMM
>EN:SM;eBC2PeW/\[GH-<>K+VUQZW)LEb4#=C8&H7#;BD+ccd8Ae&QbQC[-98[=d
@/X?9O-TV@eR20(CVaPR25WIXc7XVc]]6/D7TNE&N/P9ZB67QVZGVIN(b&,08f)Z
;,Y<[T7Uf>Y<-:DKLE2SOI3[5EK8QE0^DW:IE>;MI;X8-D(MeCD_.b.bK-3V6CY.
IF,Tg1=Z,?W#8ZZR],0De8],MOQ.)Q:3X9GV\dO?5Yd:-#_-F/Y7fE3>bP)27U[Q
T5OPgJW2,\,<D9d=O)Q4?\Z)V3aVM\aR&YHOR-P@OE)M>4NeK685UD1fN.,1_L&P
TeLO-3[CH#]]ddG<_(8R#(:QUf,8K(W,9L\/]D)fN#J.NGIfVFA7=F4dLf[Q/:V/
PK1NTG]OC#RBT1W1.1ERMEQ_F.24E8e3.#I@A\U;5/f.1)VPTCQ-?.dDb2@f.>3R
M,PLODPf@>1N9(BN)L62WJP@&0Q=+cFc0/HE&S4M;\F,4YA(aA:^:SVWI:#\WI9R
ZC+T(SX8NS:.(E?gDRP]E?;f@VS1B/_DI@E/)FJLc8A+IeV=@2Jc8.-QfCA?_[#)
SRb3;UB1Q3)T?;5_\1-9N+J&IB+JKcUC1F:O\YJ:-0:ADaR_Z]]4JK<KZ?.53VfV
=+W2Kc9UI1@20&&cZD68D>9C_:QH\gfg_I-RW>4<:B64=BR/VX0H2c/#[1>TFHRS
=81Ve,^HY<&0B0Ng0:Q(Of<7PK.(ZXCgZ3L=QP(IaeE[O>9ZFJ<G<ILDf22ZIa<H
NZ58>S,MbEE1cfA6gR<[+AZ-Y=Q3VMP?_9#A?TYWCRPWf,T,C<fXOa3e)Z_^aK00
R(/[#&1D,-W^f:)0D3_J0U[M;:0S:7G>dZaSc9<Od3_)Z.3SO-c+>BaGS=NXFK/X
TKX\YDIY9]U@)3QJ<+DUS]1743&B8713X9L@:<L0bf;cd3L+MDfW36114&DGX5+M
U?LQ79(NUQ@WeJ7b_+[QCW>D4@E9-^&_^4Q?><@NIE>:5+g=B>&KA](Mg_Hc#L\6
FH_ObC[P4;67VF)@fP40]2B;FcVB,H3c-;WB)W;DcJ]O)?_C2F8J?Y/(LG6EK4:?
PYR=,>d7HUD0.I\/>]2OATNa^Wa?YW^?VJY[#TD@T3+baCMGF0>RFCS[/b7VSEZS
ff@CS^:H&0-OBC\[_XD_,8&KY+fI2H^:Z(1O.^YO1&HDNLJ8#P\:LaL8KEcbDZ_Y
@S2@=J:21:+I#)J[T^917C2,>_<QH8a#_)[HdZR<3#)SYP04]3MI0Q<L)0eU_.Ag
20/@<g0)@AC3=9X59e]FQ+WK+.KSH>6:<:Y&e(V@#N+LJcG3,Z<>51^,57@2OXNP
AWK:>VDHC)\1Be9\d,]_^<_+IHJ(/#O&FJ(_-a]C[MWa/Nc[1P[FJ<a0c,2L>afH
&\=&/eYYUAT7[^AW/)Y=>76#.HCaLYGea&bDKeJgH<geQL;-;SOOJ,FODMCD\.DO
eT5:fLYB_/c7/],f6R-e_7U)M@KCYW+,Da0VPYB1/E7/X[(EHfPZ):INLB/>f)+8
E8@6O-E_1K](Z0K[.gKDU2VHCb2#Z^AMU4^@Jg?4\DXMG-NXgD5OX=IBA2,UO^aE
01Eg-09W<6[(E[W&fDc=]5;_>3BL+;5.9JU<49-a7?DY3/N0>8[Y0WA#\87JK(K1
a6#_O92X#3Pf81JgBXHB<P#YUVP0+<GK,8;[Z_X<EgWLCT;QEF><WWgF6<<)c&[R
.=)T4FA4STAY@]dQX0BEYg3g-1L=K3Y<LE_)<W-bWgbL46^:=Ib^D&O8UO9PVT#L
4e);7.?GT-)bR;\4b<WZ+C>B;@)gfCgeG-NJIV<(dR=&-@<G+WMg]VF0DY59IL>Y
S#dZPgFRf=J#eCec4O[I4E+c>P(24G?9b\E_/47V62:>&e(2&>N5KB1H^33fDO:B
_/6I7?@C=;N;3dL1f?D,F>M,_#(F(V0T)2^2X=XP:[RbO]TX0TL;#X^=4=8)6@N+
I7//M=RWYFX3Ab_RXTaW(JfbN8<73L<:D>eeX.@N5<fLSOdg>HV6KTZIU^C_OH/>
4Bb(Ma8\-RUfT6K4K^a?aZ2/:U5:92AdX>4Y0;XE^AcYY+0S_#;JMUQ;LKT.+A\,
YJ9b->W#GLZ(/=Q+H<MCI[,R.=Z[7cI=?XMgBB]OV)E&MH5a?;IH?0<T&2862+W0
P^L6Y:T6&:IU=;(8)b[>AeRM&]g,V7Q>GH//KWGKV#YM#EMgAfdeJF8g1+1&6QQ:
fX(:5AR[#_H6e8aW9R\N,H@>69W7/e]X(_^CEOA7RdFbPIGB+@#JKJ/IZ&-Kg/QE
VN)V@e@a\6+BWFT(eP:3;a4&?+R>JO9=NQe(P#e(=J407D_3<fS]2Ce+/6&3M+(2
DIW)T,:/7)&[@c(.0IfCGDQUS,F\DK_?:H-J1F+OGf4SgVg(UcR&HEH83J38J:,]
MDg8S?QTX=6T)3Z3FM-@eH#?8)GS,Kae>$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_APS_AC_CONFIGURATION_SV
