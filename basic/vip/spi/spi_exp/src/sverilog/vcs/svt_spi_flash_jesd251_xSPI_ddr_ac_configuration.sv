
`ifndef GUARD_SVT_SPI_FLASH_JESD251_XSPI_DDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_JESD251_XSPI_DDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;
// =============================================================================
/**
 * This is the AC Characteristics Timing Check Class for xSPI Flash based 
 * Adesto JESD251 device family in DDR mode.
 */
class svt_spi_flash_jesd251_xSPI_ddr_ac_configuration extends svt_configuration;

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

  /** Minimum Clock high pulse width duration. */ 
  real tCH_ns;

  /** Minimum Clock Low pulse width duration. */ 
  real tCL_ns;

  /** Minimum Clock high pulse width duration. */ 
  real tPeriod_ns;

  /**
   * Minimum Duration in ns for which Slave Select must be deasserted in
   * between Two Instruction sequence 
   */
  real tCSH_ns[];

  /** CS# Low Active Setup time */ 
  real tCSLCKH_ns = initial_time;

  /** CS# High Non Active Hold time */ 
  real tCSHCKH_ns = initial_time;

  /** CS# Low Active Hold time */ 
  real tCKLCSH_ns = initial_time;

  /** CS# High Not Active Setup time */ 
  real tCKLCSL_ns = initial_time;

  /** Data in Setup time  */
  real tISU_ns = initial_time;

  /** Data in Hold time   */
  real tIH_ns = initial_time;

  /** Output Disable time */ 
  real tDIS_ns = initial_time;

  /** WP# Setup time */
  real tWPS_ns = initial_time;

  /** WP# Hold time */ 
  real tWPH_ns = initial_time;

  /** Output Disable time to drive MOSI/MISO ports to be tri-stated after this time */ 
  real output_disable_time_ns     = initial_time;

  /** Min Output Disable time to drive MOSI/MISO ports to be tri-stated after this time */ 
  real output_disable_time_min_ns = initial_time;

  /** Max Output Disable time to drive MOSI/MISO ports to be tri-stated after this time */ 
  real output_disable_time_max_ns = initial_time;

  /** DS output active time from CLK */
  real tCSLDSL_ns = initial_time;

  /** DS output inactive time from CLK */
  real tDSLCSH_ns = initial_time;

  /** CS High to DS tristate */
  real tCSHDST_ns = initial_time;

  /** DS tristate to CS low */
  real tDSTCSL_ns = initial_time;

  /** DQS to CLK delay */
  real tDSMPW_ns = initial_time;

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
  `svt_vmm_data_new(svt_spi_flash_jesd251_xSPI_ddr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_jesd251_xSPI_ddr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_jesd251_xSPI_ddr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_jesd251_xSPI_ddr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_jesd251_xSPI_ddr_ac_configuration.
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
  

  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_flash_jesd251_xSPI_ddr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_jesd251_xSPI_ddr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
c3^@WIT3I[HPafPXB2^e3CI8c5TgdG))EK5ff3#(H-bYYB\Kd+CN.)=AS#G7Y\aX
XNTM/_J(6N<?4d0X,#2)Z[FJNAKU+5PDC\]4Oa:KU[9G6HTED69Z>;(\58YDR-d[
CD@CHS2]TDHP\BRB9UdC=E9ef\E2B4ZVZ>/T;gR<H90U@TRb:9,0E-02A9OG@;#4
8/G&;]V@:X8WY47LJdg;/[G=SIg\gEY/ggW5RC(CXG)af\>I:;6X,;=-LcXI23#d
^;+\c:gcOD4L5(A5G[[]D\;b#0+V\N,M)WR?=K_>@?R:@:ZT<]Fag3TN8YT>K(.@
YO<6ADQaBK6:NAJEDfX)gRbR?BV8e_G\-VW4>bJV,#&,-BIJ),ZQ9J.=?c].ebaZ
Sc79USf8ZUFCG.-g0QIKWge+gG^[>^4Zb,:c0O/HVBEB1:Q;Q1<OBR;H#EO6BY\a
]6APa_e4^)D@^F7LA;Jd&fX^_cJ)BF=&U6:R6Q118<RE98c?R5HOV@K>SW1F\W\\
=-J>W.5I3-1@gPWXe,.94I4/OV+H,\d\6\2e?F60W7LX/&0D?DVB?^,Q7\[UVaFA
O5=DXa(5(M:0e^dY6bcT;Lg[,KR:FK+ROYZc8W9/:_ZgeM(LCRc@0@WV)]gG0gP#
dVBJ2-?V3</dgVLR2eATS[\1K?EC^)gD1FI8e+eeg)C]b/764:>EP_>(9MFa5^R.
?2VM.CJ9R/0V_c;#B\IPBV>JYGag);N>.a8KP=-eY#Kg@6HL0;,Z9OBI.e6]UUPe
[fH2=CbU,VOeDA_@RRBUJeIL5Q,<2<@53M;A+U77g]&?NSfKXQH-?4N[96Nb@7G1Q$
`endprotected


//vcs_vip_protect
`protected
QAS6.Z4VRQGR#&<JZ&A4>E^B_f>XYWF-71=L^@1EX/cPZRYfT0dg5(ALK3CcO?_Y
#78TB49#[D\_YO]1@:8TD.IWL:IDI)?\XGb6?Q.:RR4H3U&:PIEd^:XaF\]B6#IJ
BNO\6CBUg+OYN98f3ETC.3ge7ea\V^&+\Sc[K:\GN<g77VSBP_F9RZbQ/QaY)BJR
^_bHa?abZgX>704Ag/&O;X<7K:N9T:7K6&-(>+ELBdZMCBN#;7-Y;;0DDg9fIN8d
Hf<DZ-Q/7WL-M+B-O-&XOS@IT;gQ<RB[]&A]XJ/beX:a2B7_+^S.fZ_F(X;e:=4M
f1D4B\U<;P6D3:#eY75OL&.7^///3FfJZ>X&/(^#&TJ1ZHMe70W>a&T5ag8EJcD<
IFTZXfA3D?D?_<\]VG)ZCHJU/9F9:+LK]=O3X/8K&<^TBHX-]H,-PL+>E&<<1\Ob
d:^DABb5.VZ+R>NC8V2)aEQQeGe\IT:c@S/7gY+SI15T<-1LfK_.G1N#-<+F76Zf
NaEUXDeYZ0XF-W.D]1)[F1fQb693b7U.05RJP>9F]IC<AJY7PH2NUM@PfcXI310^
OLWa3([6aMegB=M^<]E\b=9HTL:P.T(\UOMO\a5.a@WWLGJ6@).<5ZJ.F>,674;C
[K.,BAO0F[dI)F:QMaW06H-NV,=#)eMEfLNWHW-GWCW>f:3e-TIQ1REcW:6\DPDI
8:KL>9:Y[0SZ93)abWT-84A#<)RMCO3b3-4-XP-DWX1ad8M9DS&FC6?CTAA_8>&_
f-,H7ZggG2cb8F]<HH3OP+=.QT2NS@+^;C6+6>6E09aA>K<.YSeRWIK5RBbR3-(I
LgX68JL&^2B_U=CF2.YCR?a[BLMM;]M8,Q1fAe,\),J##BN61&AAG@;D?KHW1Vc=
.7BB5[M/YS8-R-(,HJYMN3CG)8=W)9>18,LF-..c0_PS?F,#1F#U241WR^AdI\Ma
G)9PGCY4B4cdgD=M2MA&#F;MfKF+8/3TL;10XZSOBWbZbH&ONKaHdNAYb#2_g0Z\
>=^C@RGPPLX:9VQQWLfC\EaFgH3^97Y[0SBSCe0NF5JHU6+T6[/aCAVd[4_PZK0U
)^I,2>2Cf;P/[bK+?U#L?gV6(;9IB4L3--]GH8@R,^?25[[ddQGQa/8d5P(baHQ7
_ZBe.+2?1eT(=<DT?LC5@501gGBa/dc22M,P4@D4;Ge^Vg(/b;@-[KbK,fb[OO?@
E43O-eI-^C6P>?3M.3aC<I7:C4CFV?[(TcfP).3:L<;8QOg]RI#A[S1(6GR.G_4c
X#8ZH4EdPWN.N^:N1XBW=.ZKHF?]g0YLLA0))U1F?;VY6,K7J&/35[&ZEDL9>TeW
PYE@0_QB<W[/7]U2],0Ae]2BT7&FH^_-]=M>=:IAfNdJ^6@d+O[X[<]<Qc,S^M(M
b.R22?]<,#)f/^:5]#CCDgeaX\]e_S.)L-W8UEZcaTFMA5\.N(cI,/;D+50_b;=V
1ND0/G3CP?1/?\VcXCC(7:_1c]:b)fgUX.L\57+LI=.W;b;a[RM4-]TBMTL[,9RS
=e>&5,fQ;D71aIHKKZ=d,;g:gX:f^CXa9H<7;-CE^7:.WgYXE4gD;PT3T_RgG03V
C<>JXX&CITSg,67_7&KWe/J<bAQ?AH6QVg:N13fV#AR_)DN<1.+.W0_3g9VR-fc6
?HXdS0aeeH\9OX2(ZcBM2J=dL265T18c1BWL<3GYI7[[=Y0VN..Z>S]TX@<HHU@R
,Of,HSYGV8He+;L<W1bQQU:5+V-YbI:;V2>\DD9fVJG;JBSV_]D\OR+R-D\Q(5^@
8[gaA<_ZM<<\1>&I5^>JD1T-WgH_\16(P4M@gX15Z/T5-2PDeJS_/dcPP1DYZXMH
SG13IPAI+,99KK_f8E5+2SaT#R5AP]a&/G8,^#DA62^O9/;a527]]c.WL^TB^D(&
V&?d^^1J>LEQ,)B)XL@3)Q9EO)fBDfJYCY3RPSM6E+a[aK1Nc(:;S++WT,/)758L
,5[[#]N>3[YORIgA](]4O<1Q=YV7-Ac\_U^&D_gE(a0BaZMe4)N^GRG9H2([dW)U
8?FJ<+Q3.+7Y+HM?;ZgfE01<I//]<L=7KdH8.:T[g5)RNKa+6+JgY82DM7:T0^gG
E8.>cfXJOd+QKOY4U:BB_Da^gdag]=50VO?GHc)(dNB\Tc&21B\#\AOSEC?&(Nc@
V;PO/^_/;YXQXg1bg^654(ZU63e4^?[B3JeDE.FQ-<>7N45GEX_._6_Wd<<[dR[I
H6<XJB/eg)^?F9b0O;;VI8<LQgNZ[C^)4<&YSI,-_E^QaI-_8#G_G2La<a[9]<(-
A(W>V5/<gLbUSKBT/L7N7+>ED2/P^5QcF<BIB;G#((S?eZ)(abS\dCGVQ2VDJfC2
,LN.c/5Q/WQB,RPD7D[=KbJ#^@U,AUXJ(_D/FQ3SL;X>JOB50eYbcaa=-ceZY0?2
<8R()H76f7#&R>9=JgK^g54TK]ZO9ga^@F6Q[<]+0<0(@a(BVGSbGLO(W,ZKV/\P
O,KW)gc&IYXGa]@+H<b+E-BO5)3NOMDXV)F1]KMUd?UMca@^IbeYRE#P)IHaD8)7
PBgJL80bFcT,e.dd+RZc5#23K(F.Q[1QI\d):6HO3QVIdA5aVAa=3:#IDFC-0#&E
.FNT;/-6QKM8WTUfG]f=b&+@f5.:\LM0V6#a52?=TE>cb/RPc@g>[KQ-HEQa&I.Z
OUE5GQQT6#L8V_(83aM?B3G(/@TH+b#8O:/<28d..#//1_]-6@cO2]QF#e>;.=_X
(292F;YT=PYP;,&5<V&2&OU::&Me=E_J[9_2.20:PNGd6PYXbcE^(<]W5>0ZF=L#
/]A]6=4?J/(2G&LQS[/@<a-?0^gTbX-8T/3YBgd?aNLVEWBd?R7HP::FD\E,ETH=
2VaH--8f)3L>f,UP(Ja3_N\:?+>VRe\4R,/21Y1bVT_P]@>Qb(,C:-E4UNd/.DYU
UM4_5ONKGVAJUW)C/A-[]1d&7LQG(2Q&HN,VO0F@Kd>=NSXXG53LH1YG0GHZ6G/^
aV:D&(\P&3DT449.JE#W6c,3E\)C)?0dMMWFZU?^=WDQ11e];RWV)gdWX+ESFKI[
8BRcU)1U:D?CDgQ;bO_9O0F+O6=7c,./^YX[B26A7#XdNG<ICLbBb82_WFJ0&T=F
f-07)B06TOK-.0&;QcRX16eKCBE,Y(,:cRJIY(/I9LKIYRW_L++cL4<THGBg#;8e
:2?0(74RVG29/f2dDR=U&BD[&/TJfO8a\Y4MEM55^\R]1((>DX8S/[<(e..^,T#Q
K;=:<E1O>G2?@5\CT9)_/.f:DQM:/b?-NZZ=-+,0g>&+_?@)LT<3NAPGS[I?B)OO
;_JI^c7d<4MXd&\54_@)VACd0XgcKUU#V,\UHGHIPacZ>.=IeHEI@YGR:GR/&AUF
F>:B=\HaV/eeY+C,R/P5a/(e@K?.fIV6L&5V4^4;VFaNfL=;]B]NHKcYFP4@A_S1
O\7[=eaPZaffJ66L;W?K_gUZSM6&+1;Yb7L@A5(CaSe:VXUS_X@&dMGa+McDW1;R
#60D=-4fN:[>,(ECB87Y7B@ZGeC57;6J8AR4(K#:BD?#IC^d0f@L,EZK_(WgWE]P
,QS[gGb/ge-]58cB;)6ZPBHfbAAGdcSO#CK-13>BEO^<52#HUCa8(]_f0A8DWW:4
URc\_OA^;C9b2RKA1#@SZ8^NBTZYXW(-2YR=(@XI2(G5@@59<G+Pg;LVg),)^SL<
a4M#+e+6QGMBd_#1cRU5Q=UWG^C5D2CLMKCfGY[XaA.+C:Y+2B9W/B@R:M.M(UOH
I^3E)FD,ea&)[?->gc.&RU?A\If]Q(0NLB;9QNM[@O<K-Y/UV_<6\Z#:?/+4GX#=
#D+<b2JcS9]GW>+.c@4X=Ad?<K_H>2,;fW=S0]g^134cAAePa=RQDP7,<:0d@U@E
0R(9L@[,_Y3PTH#(Y)LVJ<,;6V9+7H8<JBIXbU/g9>V)@2W^3#>/:(^-AX9/T8S0
WCX\Ob\QSM;\/V0<D_:-SPVb\ecR?;;)ea9&I;LYa=CH35\PPEO--<eL+?)HX8XZ
?U[-]^YS82AS(M6GZ+HRd[A0D,DCAa5]\,4^c<XG:7[M@NDCITSZ(c+I_B1?S1_?
:H4ZG15>@5+K9G2Q3[Ea]YM:8S=.bX>Xd)4@Q)4\<TDUYXKg5+])1b]QbG72P<8)
^8;YQ:Cf7&JR;(>^4dAU_0.>=SI1KCXeL2@9#g<H)\VJ?c]+6_OQd@TCg>0J-]T8
]fBPHJd+^\7N?S(4NX[B\L+T_b1D\@ZNFO\)-D2:7Q0:Q[+GQJXgCQge@I)&W/ZS
R,^L24=[K_J_<F4QNGc)fF6S=7L#:#VNI4^98+T=WM7ef^b0#KC9>I4#IRHRD9O<
Z\N_U;:-7I,14Pe&<.671GV]g6+&>=/+Z2QS0_>g-G@)QbE?T.KeRd\Xad3XN&V^
-?MW@<fASTaP/&4W/72]@BAG_LNJ]JcI.[2b6)AP631bL<;;c;#bg).f7g.?NX5g
CANZ\b(ZWd4ZR9Wb&4X+c2T0:-GEY/J8(ORJ-:bZI6482Z<a5_82D;THSF+)87:L
(I+&WX:V8a-<>PQY?d066G@KB67M+R&FPcCMC1:UaA&T_?8;Wa;2HEfH@NID1BEJ
X1\D^@O-gXC#WUJQL4Q8=P_M\DT=.5B5(0I#F8TB2f.[F1DJ+<NM-;C2O-_Q:F4-
=VOO5bQ@&CT+BM>72&YcOg<^(8V^HIJKH)5S^CSY1?>+KY+#2[<C21?YI([c)2>S
_N)L7;RIX]WU)H?@81e.A,#eV4)QI3]I-C3Hd65W/-CEcC4IB&WSPJf0URC483:O
A>7=_&+2a+1-gIU:<)M,7K;>65J#Hd//ZDQME.Lb-GbGJTd)]RXM:=MgYE3TE\e]
H(\(Db\XF4H-?E(V0GNPW\g:Q0aN(G06Y_CZNWf.6F1ac\BTL-5CC=V)ESf;baKV
@L+5^;A]N4Qb;C8)3DKBPL(g:?_+,<A3fJEMd8ZAR?8H^M_IALMW&b6=JG0;5&7W
+I7&+XL>;/A#94?d;HNe@M;[b;GE[E9N/F\L\Ue(9(NM+P-9_(ZeVD#04;[1a1WU
:?:I4aX9Y]VeA5a>=<-BZU3<7U\Q,<QMKI?IY&6;H&FV1O5?:?U<MNEaN,USK?aJ
9&EU(+HTbQ9380YL>Z.;a:<YcN,<D^\OeH2VFQSg?<?Q_5c7/2DV,c&T>LWc834?
=/1N_e5>.9;D32C,AQ]NcGPHO+9YB6TKeK=EDg^=(/WEB1d5YM8T.0\6]HX,1S0.
TRXQR_))6-V)B#A)4TN0[gA;BK;)/0&DY(N4BF,8ORA8>K:\96f/UE0L2g00_E9R
@]RA8/T(.TaG]?XWAGNE>WO/GgL;YGHL79KWMeQ,DF>#c6?9cgV;eRcJcLUAb;g>
F#E,/(]3VI+;gWJMP9YYfc#9NEc6>6Q3Z4X\<#6W(I7b1?34Ed(KV824UN3Z,AC]
0>TUeTNHGaJF^X#aHa\]=-H1G_EHD:2aF3./Z[R:8K)#+W9O5Rb-YL.@;9YH:dAF
JCDK=QFT/?R:+T#X2IOC5.bS)Y^^ZNL2]M:R2_<P4;4cJ57Q@Z_\DC,\5]GW;X(<
RLfUCGD[1^FDU]P<7YVBQObGNZ(_M+3aJ1K8G9BB:X-F6.CB752;=[__THNfJ3OY
O?#@f.0-EefC1)&_A6&UI6Te2<:?)ZO7c;T3ZM^@D],)8A2VMRO,?S^#Zf/:@CNS
f9EHK+5HT9G#SeV07?]ZM2/(E4YZQ@d3OVDJA)@U?FVS/4;8=bE&eF/<U06Nf9/]
6.#0,a.KPDLOdB&7KY5,4&+?Z6@6II/PHSgZ+<<W]cN,45V93e6]P#LI09-d7I]:
]_JfW?+d>S+ND6Xdb^^B^?]94XXH&/;O];eNM2CP<aEMYa)M?bC4-81BC7L3>Lg=
<9?-6#CFK+4(]^SEVH^6LV4EeTY/ZUFC^,1-9Y4ZfFLP.?gX]bX=QRWb\:M>XgT3
@,0(dQB;Xf;Ye;7]&IG120R9CIMKgJeJPgT5W>:PV?g_8,>>dM3A?g^T-7GY:J5b
I:/<7cX7KC6S:KNa/\94gYZaaQM@4N\d(/.^HXP5H(8O1Nf53BSBU0Kdcga05-E@
Udd6W@+:9Q_(e--3ZY,O#6TRJ:-74)[+JI0EM\c.9_aJ#3eK38RXF=BYV=[=9^L0
IC1E4/<)N-W@E+=:;J-9+DTObd;OI=_LU)EBS8;ATDOWOG/=#JLN.)IZ\.^ANb;D
)788\.HbDSCE<5S;#&9KTEdHa\3Uc:X@-+^7[)TKGSK^QXY16f_I?9V^9[NLY^>G
^9N]X[<S.FHV7@T]Jg.d5/GCBb?=ZGTQd9fL4\\2>BZ?PQS=E]\.^Y35bRg70H(^
0QM.BM(Q,ZDPNJJ,a5P;/E^J4[@QKW.X)[9RO1CJH;DI)M0Rc>_cK0A31LE4W^,g
&&HLS.b--R20I9PbSV&S-YC@:/egR17I?@C(DA<<[:E(2(2P)SQ(2P;@1b/<&01Z
7c)d+PY;2KU,SDBNI/7@C<Y+ANVG+I(,L@Ig9LTG.F+UY0]McI1OD.WQR:[E6+@5
LP=Z)d@XEKJcCN1OW+?URZ2TX)+OL5M.)QZT#aUA&+_Jbg\UD#a)d[D<]H\>1>XL
&W0O_U#Z1AIeL>Y30.#cGNN+I^G.IWMX=T]IQLf6D#FTR/CLDKQbMB6C\Z+-RQ>Y
]EZLScH&KQT@+=L5:K6-&AT@Z72J/G^&]H8=-GJQJJ,Jg5cdU#[4=A)Vg;FSS3]b
P/JO/]AAB[;=HIPa1U]1190):&G#cCBS+cbBb<gdB3]f.GAK,\B^?GcNWE>3ZUW<
>Fe1[3#>:(/)92OYC7)QL52DE</(7fGO9MHKJX<P<^,2VaJ1WTMaFdV=0Q=#\)e@
fVXb,eM@J?+Cd8g0E.,[RJWB2]R4b/)e6NQD(&b0Rg1\52<Q82g<5GAaT,(c8+_&
-8YK>g+CWX1Ygc?BCdF[GMT;bUC/>84WYF)VgQ,<66SeKKKVE/)TAU8dBR(SS?TR
;XXH8<2(_U1&&@SLYZ64#UU3RHd),JJ9()TCC:0ENgZW2+TF/LA]T?R3)F[47T]X
Eg+8E,gZebfLd?T2L,+2(H0EJC6efW11]bFbVA#H&Xfe(g7GP/3[H:.B/LY-.0#X
2ON\QX(8U8XS;P:H[e]/ASf_1_I_,:L[0>1bWZbWeQBRPaX:]I9(Q+eBOAFb?9K)
DDe/6)E_dE-):RFH^863<OeXD>4-GI4UI-ZINa.Z\e1]++:Q-#1YBO^T,8YbRJ-I
O+C:QFO^05IdH5:a:U8<:FEH_6b=PT>Y89=X1,fB,7GN?_MALG]aGW:U1(;)GYP0
E?&eDd-]Sa0.U/XMU_)MgH(O#^.cf;=ZVAD0X>=Q78NZBGHDeGTQY.4?B>_0>J2:
7Dc&]5DLPgc=@>ZORKMI01?f\VE6UZO[32-#:>;;\ZOTR^21[a6(^V<_+,b@YF8d
(#bg7-.5]&0Q])JdV.PcG/]WTEFcKGHQ=I1/G7VFb2.7gM=F\^LRL:QIZS0Y#@S6
WKca&FL2KgEFCaaJ(-LW_7bX^V^TGUA/415(JU49\ZBRFGNX=N,cQ#JEPJYdB)Pc
\:7MBcC-:]#eCI<\(cYL.-AF,-c16#96)Bg4;6UV;E[,/:[T;:#L^(PG>M>AKV+=
-0Q^QCAV3/__e(eV_bFLNV:Xg3\J=g:VAHDbBC)F>NeW+P02\V\#L4>5&T+N8XIO
e>?#DCH)1C8B_FPU<<_5&c=2]8A67_FDP3HN3MELZJ?F>B/A[M:IE7b-TM?OWW+X
),7\DSQLUc0)7/V/]H&2[gbXA\d0+31LRNeCY6?<bHD??9b9Y_]?,1JW\OWL3[T_
f8)c#NIDKRG7V^AX2d=e@.41XCHD#W+Q[N<))[\;D0:@3>EJ0AU:a0-)YWB(4C62
ETaD6JI&Kc4g_F1E@WG\68Lf(=P4^IbE3K(U.0:PcY:&:MD0B_28Yb0c_3(H^KAM
Tgfc0I3?7/8O[fK7+)=0N96U:5V&\D(N5?8#L@2_HQQP2]-//Q1Y&0R_T.MSU63X
_I30cQ^7_&.8D/[[JNaOC=BCBYEX8E3DDD9a136=N\P/LK/#4[Sa94bePEX7Eb[;
PYSD@9&+8>J8]ES>7T2/+LVE.\562S[AJHW43b=9<[:gZ6=RbW,>G)0g6TQP^cLA
KOEJGM4BcG-f4b5)H?3d[ZafRD?>5G=c071IbFN+TH)=T[]V=\KWMdXP&8a>I(Q6
b]D+55/fUMH>^J/]2G4KFMa;:4S04/;L;dOg.af>-dWdLcV>cC;#<b8BM-7UEgFN
_&K7-fccfR>A,K+67DMI2A[V,bF;F_+If\a^g]Gg24TB+.E77NXgR0Z._2a-Y^OO
gcH4)PZ:VXJK#V2HLWb]ZB3WQS5^D]TX0-dBN4<BQRE/6cF&GENF,e(f3ce_?;:W
/8gMcg4+)DHe60XS)RB41Z,P&G3gZ[&X32T77^,=\A=2EFIP=)5>UU_X5(5W58,2
@[CFfV.S)?G,Zf;O5JSM2JWP:Q(CJTRD.PQA/CCBfP-N&RJ;dO^B85MPG)eAL3@)
\.cbLHd4?Le9Q(F0Uc9BVP.1JJ1Ja9J^H0UbEJa/KHVbIW4:><_PNEUAMUdg57F>
9@/4Q8XX8f=eS4A6V:]f8ZR35BE4(#DD@Y:]gHgA:0<_ANTd3SJHa]7E-:O4O.R@
[M>2>]^JDW\KTP(@I#0<)L;=^;V2;VM80<eQ/4TX)(X3.ZYI/a<8:;+W&:H0fP,f
DJCN8H@S=8N<7e=#CEd5Q>e_F/VF.D]HfS44Mg(XbRL.:=3D<==-E(N@#g8O=:85
IfZU=>cE:#NA&R:?(ZF9:</K9Y?=W/RXg5BHcJb-C44AW4c/#1-)2HNf;VVL?-6Y
WCFKUVT500,(M:0FGMJHB_6R>FGF=KO((IXf>Sb(.&L[)ZNE7^8C)[ZIWcC/W]3[
QZH@F:g?.MT80?8-bT\^e0QD=:X\gg,ZV14<8?3#f1S+c,N,=J1Y9a=Y3bF2RUGT
b9C&8gJ6IJ+0,&X94W:&2YQbgH466/7f2QBP0WJ1\YI+4=WP<-P8a=6JW5\;3eNQ
T4XJ\(1^?KCKYdRIKQ/D0(Td0R3V#cE@RRGbeb_\/Z_H8>6#<P:7>_;_F.Q\B9BF
M/cfcZKgGe\@3aVOQ6@9W&3R]dZ>_[2OH=2O]NFN.K97K[T],_\f03;;+O8fI/BK
6.__JP4;_8R4HS=c7HTT&d&d3ec9d0W;)JY86CUNSZ2MD8]ZR-0ec22R:RMW]2:+
U-(Y3>?.:8]&&9f)<FFH_9+QT.>2g>5;?5WSfafQ;PAXR)B;bBUfbF9BJX4;(F:1
feX5Q,[7:/EcF+#=Ye6IM@E83)f)1baK=+:>AZ\NUYg#cR,1J>_75)Pg>5O7S@T?
@V<,:81(aA4K3J4>FDT\9\9[]T6+b,WXfbU+T?Z;(V<L53192Xf6gZN)KTc/MS_6
fDPIH[Hf7CWV2]4#cOIX4e_D-O^XJ--B+cT\3D8<N2&XXG5R;3KPSV+ER3fAUb/&
2BFJ3A\F_;6eF-b2Q]N]_^FDD/=c.3M::#J??75OO])@(M>J8-SbWR)V4AG&2gZ_
[b<\e+2PgK;;.Q^R+Y:Z&g)^/]^dZO295U?[P/L@K9WECJ<dY?L8\T8FgA.XZLB,
NbG6IF:USIX\H2,;A.RF1#N1QZ]88)D8N:AWaSV/:0C_TP/Ce)UF72JD@6):d;R[
83>;A(9,PH3aCV=[X]\LL6@E-.H_]C888LGC_+L]&B?<:8M\2FZL]>b^DP6KXQXc
)\Y5#_53UcY;;dWJ;&A:5NJM><b>R?>aJb^OY31,X@@.@+V/(DN8L^#&U7[V>IQ;
>L.0MC>9^2J15GI<ZW3X\::g+Y4eA8Lb^?Cc4.(#78Y08H?=^NQgI8+BU99)c7-H
G&ES4d>QWFeF)0/D;A^MI@(e\R6/<.Q<f+XFe\O./^VRg42@FHEIPMbVA&K0[8Q7
,5E.7F;JYc^9R6.+])@[F6_0f=V3ZGAD/-g=(U0;Ga^MI)LT-H1#3\dE0,P^HRM.
ZfS9L,d]\?2d.R,ND(53[DaN7e;\()eK5:ZG0B@906LF99(a(Y9a8g,dOF>Ja#S6
SB.QPafHQ\UQ.)/DY?:R;ZSgZ79<#d,ZY4-&f3OD\aMfM=O)C4L1@Ig\KQgX118C
]2AdB-g2\WMe(Ib,a&]IAW5C;L@U;Tb]<JdSgRPf.+bY2OZRJ<a?;U&O8Z[fW1Q_
&bF_JDcM<VMLKM#Ie#3YfM?Y74HG=F<@1Pg<E80OB<4WRD?8#4-EB;^>ZJ6IfU]_
VO>29Xe.[VPe=Ye[@L->[THR2Q29UZJHRW/GR#T)aV-W?PM9-\XbS/\#/R?NF2Xa
^]^M;<7Ua_I3(,X<B;51PGJK5aB<^aRD.68)&Td2>;)5e(MKJ#OL9@XGPgE&Te2C
7@ZM5R:+5RQ^Wd0H(][[VMF\gO?7W_V;Mb2NZKNZ._7aI356ZTYbc,Q-e(Fe2bDB
9c^85.P>:B=baJ5;(0VX;#^;@Sc+6LSb0?J<HE.FCT\2aBGDE@bWZUDgY#F+L=G6
M.O?ZNeM^#LT?X\W/A1e)cYgDK_)==ba4O&]+,D.WZ_MX0F#R?EZ=#GAI:N2a1ZV
>6HD36cD]5]YG;)7PS.)66N7-e2-WD32SF_&-HBPgO2];<=@;J0<ORQ7-39b;W7[
3T5fWS0D^H_?Z[WX74@NU87QTScgNN:A287He6?(C(_&GPVb>.2^7(SdQGT#6EO1
6)Q]H4DGP]KND8)HDILIfI;\.PZWBJW2U9;5<_8aSX2&g0#1g[TAb./_7H&[Jf(L
E8VVP#6Yae9L\-B9K5F67Q=R<Md5(#LP6b)+>SFII?gI5ANa#=L19-^3/bX+.35<
&c7]^bCRYTSD9EQeXcX6^Uc&_W7>AY?BTa787ReB^,6XYf(;9:-&dSfTa.YE)C72
.QVN70E(ALZR^1F:T<&__]6-fN,bAS7KBX06-.VX9aA70g_&V62SRa+YaCJF<<MR
Z/^AC7G8CA?,2HHFX+,VWS1L(A^bE(8X9Y0.Ed&L25EDW1F[9W#3KVXSA=J/4)^P
S<YfHJ=ES@KERdNPP6ae^2DVC87/=AJLG(B[CWKO);ZC01&K2JWZ,C;]>?,NVBA^
RTZMP6_)S_NWL4>=X@gcL.e-TA1?APJ@\KY#9G/MP7(a^CfK:VB5L\?>3M:RE#,G
eRRa#+H\WPffZ),7_@^#//ccG1]?3]23^J@,/^b?5(FWK#C>D&JBLN:66^b;>P<c
-5SJ>ZNEX33PQP0(UM:UOYJ8#/0aZ)_(I,7MW&6G&e[=LUPHW:EBQEgPD^K780+B
F^=2_4S9)(IIdd5;NJYITQIXGZQ3GWG(ASO0,6R]=^<LOFUR<^@Q(PA\M+cOG<\c
YSRVbMed_E=b8)aR<P@>1KG/><[KV0<g,XG&GAB@^:CY72,?C3c/2bLRI.OgIf:/
/X8FJ0gIM8@NOZXA[\XBBHNfgN=3+X-/E\c0DTOZR[5@VcCV_P9?a;:.M+9..RUd
E=&5MR1P#.9B@(b^.4eL8X<>F\4-P:FNN?W3dM;GQDO45IT0KV@9@L((:[+4KM_R
82BQ/AdK:2-aH>O1QC4TDKDLcfT)-:1/8Y#Y;QT6+PNTDK;Bb3Z>WU\Y2gV/HN[#
&\WKDBE_DfUCIQf^;KWUagJ,K)fGd=_^-#[S#(OA&\Z>44873BIS):^8R7.9EcSS
TSM&(K#<RZYR&bH>;[8;a\a(Idc5BOY,I,.P7F7>9#J=1H<QO5Y,T+I\Q@g[(3U\
gI#<;gdRXYF533\)<YJ@e-a7QD&2JI&JI)5?\Y85d@YTcD?Y1NIYKE<.SUQ4\\V0
QBI,8M0]P5]V)Z<fY,/VX\NW_N/PRNO8Vb(+a;[QbB-B>EOUZQ7@^-eU/0HR5M01
UFfXa]\E;CQ5f5IUCb:]W:bNE;C=/?-F7]\,_I#EfF9MA8dKO;V_QQ1g:,XDg4Y0
.aY9&&Q/7B_L:54,F=[?WU8#FQM+IC41_M_,TGP3JH<Vcf-2;,ANMTWJeaX=.LM_
=4]&UD6<DG?OL3+8S4OeN,f\a3TdY9@8I?T@S7IG..3-aRZ@QP=TXUG4.YOfE@@d
ILLa)fWGO),LV2R_)&46B=9#)?,4K.W6QC[e4#=+;:/Cf_P\J6]P=)aB^:@)]a6f
GGWHdASB>)DFfV8&,fHW]E[U8+Ka3/1HZgV;MP84>;aYNb?Kb^A-TD;^OMgXgUWG
_e#5_</\/f)J-Pf=RX26338ZDQ>\:7^DSP#ONTZQfOAd]Ma^.91FO3>^]S6LNJ96
EdOEL+5S4(:\e5:eEc5#?Nc#JT,cDD^PMb[(F5:@W6VD,d?3F5&PI<eMK7K(FQ(#
CZ&XD3P?&7f-OaK#1V#N4dE1f<-(/7T64PRg_M^&3&Kb&f,#UKXQe2YT0+IN].1F
[#(gbXJVSg_8Cca2R(7<@@c/]ed\L\HIF2S.\]S;[Z6Gg/P4^X=HHZ&.P4U&bSZc
WAAS4KgY#:54O9W.MP8IOW1GGWI66&O.C;Y?;:_,2TUVMQ-cP9>-)AZH1aIV#FJ&
CT)d#16J-]H>;DET/=F@;0H]WIY:^)D48R7P#8<4,EX>7eS=,8/#:I(:92B/dECc
)R3,D;c8[F([X#RY1O#.8f70H+(KU\/2WDbOYW].49Of,K)3d63TUecfJBK@9f1^
I>;]>6bL(\@IV?6H=)gS7HMS/]_KO9YI>0:?S<d])/V3Y(P(;g^D.bYb[e7=YdFb
b.CY[F3G<Q3\EW&f:?-77MH5[.DTM3\XB4]-MY>(V=;.d<S\d&b_VAfD()EU6DAJ
;K2>d]:^b;II<]5e>I?YBLDS)M55T.fP-OB4[2@U)baKaV_^O4I0C,,3&DDK>9cL
4:(GHc#@+\?d6Me6.R+f,X+0X17@\V;<_YV#@PNI:R7Q)9[-[;B1N93Z22,ad\KA
=fC2X.\6\Y@BgEO4]]87S((:X=ZU6J=G.YL/7e^1;GXeHPF,4-5C=,9D]VP_.[X:
:RLO^;;b^dXY+P,.gUOU(V8OPHZTF1b10e6)R=3B/0D?=68IOJPFSK^.IeG[;M.=
=?WZ0LO-N)P]-6?J)ab3/>Z.0+I,&);X-UD38AJc\N:Y>M/O1#<27T<<CO)FGKf;
&=8^9Y9G808L)&\/F\T)HM6TE)0_&c<7dL(L8Yae8X^V\:1Y.\9:^<O:<LTDE1e7
J@UCaVN0@#P)50PfD^C\OCD(]f,Y(&Z=;O,Y^C?LDTg<L^KSRC58DQM5fIa_[\F5
f&b6C.9W;N0.>+3(c.)?\)Z:J2\9M;2W=R)?09BP<)PL?VN9[P2[eR0P<5A5W=)5
U:._EW_eCRgZJQ/A,S+P^.D4\)6,=.;3ZF.=a[f6Z);5Cb0YKMI2CGOB22DEK,Je
(<;U;[aK:Q\9^Y.J9P@1.9QaK>,44JV+(gbXN/a]Fd[U_4E#F<aE2Xf\gNG2EJ._
_7L<B.=]70OYB&QHSRa2bV@1=1<^56:9BV2(W#Eg9CUeHK#UTZLN9BQ7g03^:e_Y
c5VD&NX\A:BHaJJ1a;KL/.d#PZSES<\(d;Nf;dP\I;X?_Vg)D7BZ0GDe30F;?_L_
-bOPH4WVV(<_S@GO7P&>\(_MG(ReM(F>+d).XcI^8d#])b(R,=X:a)4MY5a,/R@O
+@&ZR<;FM\aYH.#L[eHb_<f(W/E[>TP7e9M+OH^c_=WWg);R3E=Y_:#NYOd^=g1T
Y2^/=f=Vc..,0E_B/=gD@>1=#00cH3GC75\044O9=]g1^#f35+,WZIa>2FPgeT67
e2=[>ID_b\;.JB6L=57fAZBBTA@a&3_R-b[WV?\&M2,IX?LMaLGMOQ>RR8](EI=M
B?2Zeg<\1X&aP;.<^aC<Xf^d.9g?RVMBOKWH2@&fdE4Z>^#2c8B<^6Y<N2CGB&c?
<VIbaBfg,(4(2_8JTQ@WQMV1PI)U;TC)A-fWRQ:dfWH)@8I\/<CRK+@I)19Wfd9>
I7fI.9(UYFELbT2.@V>8?[<F/g+W)YfGaTYc3)X45Rf\,[&D:/QGW.=9-b#2cXNf
C5:X;?X<e8]Y4Y&RIDP(2Hfe.eA)J/GL:Ag&gFf/D0GX0V/1Xd_f<J-Y25OFGZBX
.4gJ7R:X3MJ(g\-O:f2.[TPC>dW9K2PI&=cH(=V[-4UIKQ&F24X\@CWHbF9J^@VQ
;bO&B1]HNL3<\=K0./^c^H./XCJ#1Y@bCaX,BK;;Kd&8L]E8R\2+G#MI@98FXC2>
b]@W/2MA//fQO6WRT,SW?=7f0[9F9:;NV9E<W98D(.E>36EDRQ(6=dXF=M.0(-6X
D11>5)\K_C0GfAD?gK]JUT78]P)8dJH6?g9@YPd3Rb1F+dL9/(AAd?/+[f4X,Q9+
8/XV=&Y5XJ^JbSUaC-BL]e\H\/>XEg,fC4_&N60R.<T]BdDM:IbS@Ua,L)5&ED41
b?F^],a[;LX^J(OPcT)O<.UJQ8;(R,UVQ]WcMLH8OgYe(O:f^A+1cUO92O<WI7b?
B10Xc(-MAT[_R);[^3UL_L.UA0b#906(b_6;OVAQ?ce-UR]-EK:&?d];-2GC_MDQ
/ASUEMbdG8@Q,V6?J0d+M,E?18fS>UZ+?3FcSZgHRB_)/U\0=MX9,aC3VO](WI+Q
#X]bYSX;,IZ-PGB.ORX[4F=TX\(&.5S4#aGQ(c>\Q8[U^53LQ-;18T=D-Z>.S_G<
81N7#TZC064d].dC)K9Q\-441(7B;-XQ-)gWHRD;@ZPV#?D@^-UcFS@WC-.8#F]4
N8b8d.f;(a:Rb;200L3UEHgG24JQN_GYS;C=@RI:)Ce6RP#_A(_W,_FY+YNbXW[Q
>PA@e/KND2S^#N[GLB>LY/FFRIIV.T1d_VfaM@N01>19OXc#7SWeM0Tg8A+FHS6P
^a06;XH>5_B-/U4(gN^<:1?QOJAE9UfQDM0E<UVR-LW(Q0RGYTTJgQ10Z#L49_11
N[0^2Ne4C?&Y>MO)?5/N1)[W&BV)0^VQ;UFD;J,J<.3)&89^ESF9gT)?7>03BQdX
+cTeM4f7#=D(PaE<+@9J+44C9@3=RH,+VM]8d>215c@AG)G<>/-Te:g57Ca@X/K8
T2TH,UK#+bV/a>X&-HK?S\^0@G22._;eV1<>\YgK:IRAY124He(C?YL8b&.Ad(<,
;DNGgM]Z#+9U8fcdH.F^.2BCPILNX]0be\JYK113J\<W):SN&WTe>E;C7];aJebP
:,g]?g0QbDT.cVW/2,1GHDH:SVS7Q38A7>K,0-<HG/2=PJf@<?@ZJQb:44cOK6Vf
JX>(<)J;E;Q>IX@+WQG0TZRPMGa6+RH1[Id]]AUg64==Y83/DFge/=F2fTKT/Jg)
gL>8Rfe#8bUS-.2V1-5e=HO4V;1_)C(Pfe&U7DK2=f[ME00ZT4,];B>Pe<@Y/UJ2
;93-FN85fD.c#LF6T&U8C9<?L,A&^MLV,]C0O2-ZDLPG\FW08.[04J.Za2?Yf)/9
C+?c4D6WF]D[]F0BU7JF4OV,cfg1g<1S^+\^0;/#D7MLAcO<2GU0YMY>[>WN:N#_
8#g_M5J(K:J5_@VJLf]9_G9SY2HV4R-RUTZ,P#8KFDQf6f=FVcY&VZ0g6BC>=QF=
SAB1;SP?&Z:,+G/HC29<.17)=Y=?[D-Q6T@>B=L>U9R4fD3X)8GL.<c[7BeF?[^1
cF_7T&F,;4/4:,<DQH4:cC_bI3C4RFM(fB#\7_G_(c+WJTH3SbgS6:SLg@9Hg[a]
?HgVVA^#;)C&0dFP+5C.A8W.ZfZ?[8Z3[AG;\VO_70MB01&-8Rf;gYA#P\V0.Zd@
6)5OTU<MBO27T]P@@NKLZM7f9,IdPA]@42>-T/g#R_HccZ50g\b3#>C)Td6XeTFb
T^DgOBL\]]/GI_I)@#;Nb@BP]N3=;E94.IWE@&_RB82:;MB@CQ4I+<58VB4eN?L6
=<B&AR\GT#G6;_RVRWY8cR@24LPRYH+.EIdSA#[DBTbRKXHHP]b&A>TOBCD(A)U&
fV,@2:]DV//V8#KF7,;4X_?2Be2X^^907^Ne+-DWD#[;VY9=AY=MPFA1d]9C116[
9(W7d>LL@)@3(e^:NAK:P7AYd,;0X5HQX31<BE5-8U7JL4]\TgXE6DcMSM&9L_1a
C/-cIR;^+SaM,fP,&?2KQG^adML-S9O4K1dQDSCXJ<\\XKOFMgNd<EBWPZ#7gf5G
WH2a1HLe.,U)f2?^Z-eP&K/RT.:&de_:J(ebV2RAE\(#g^Y(A3?)5@O;fVT1D:D[
V6e2GFZdBJ;/3K+dZ?GfSTcDZ4EN2#2]Z<6cg:NaJN?fO<OF/gcb4/6TFb1LY0V\
\:;_708@L0^+>,Z\R;W\a1g,M5SUYM3DeFT6?T/U=^-a)W7]=UVc.:NR1#:Wd4)9
<b@&SD.?;D[\9;.5]\1XVZ]HP<4g5VMB>UbC/7cTE\;(IM76-.-]W<(0B^QT/G)S
QAI0XIKU@W1/:-HVc;#1_DGQJ?Q+P=WS=@Wc)V[F:3)Xc=9NgVF0#E#WJF#>?O/U
=H[N&B2,SX#HfG1R00CM4AA9^)VDKK^28cQYaR_)M@&H)F2=\)WR&;bRFFQRKUD@
7(0GDA9,83fTJ?.\=f:aB\#?QN:aN;9>N)9[&/=5+^QcRD>/VF9[g4.Mf;)PG2C3
-U6?L)UPX5AQ+XU.9)M)W)HXO6[[:M1de@0O<;S7OV,U;3D(R8KXEQ95HB_49U:+
3]5:5F#<8cY^-JC+(]PKg=G273NX(@@;gc;#cZT#H[B5Kg6G>Yd,)=CK2CMFf-=1
ZZMDXFU,T@6NN^e6I]_+LLTgcaA59SAb^V,eSb=;FC+-W.EC<87:EBd1\c<&L7X?
18J8U<Q3_fQ>dXd)?6&\>OG@HD<NUD+ZbPX=:&>H8UUF(X[?A/NE6BS^?]LD?N):
]7@@K6-47:FNAgDIZ@_JQ[2JB6=8<+@G/9cP8KO7U+1AcEdDXWP^4Q^O^W?3_Y)O
?DB8FZUIgO\&8=IF3^O+141d6d/9\.7L3dM[aKNEH5BNX80R.]fb_6OR9cgX=;Ke
f8c_L8.)0B2GTRJP2;#7Q_2#b3&(+M\#EJ#geZD(fX\d]FJP8N1(^M6^bU.1fPLI
I5X)M]/>C1FJ+8TdZU8b;6Q7d^:A0fPfP5OMP;V)S2T1FR@@+O,cR02H=MW[E@_P
APB[?IdcYfV[I/:A3U+R:/,65?6F3OfKHfV[0a.[Z11gJ60JOC\FBQgZ^VABbT7f
V_/<=[+09fOQJb3)bZ5PBU@#0_TD<@g[Y>A>N2N_E9)cBa[#(FTNGC;F.YeZRJ8F
+=Y8TE2cB(<+MSG^6+fB[<R6275:EWdVSb]9F;MDOO?1V-\(&]@^^--e(8[R1D:?
d^B[Z:\ELJW)aL81&CF\CGZ/54^E)3cC3YE@)e<;BCKQ=C:Q@f[<,DLYa<5:A0ZK
K.T&_;3#I)X<f)>MD=T+):,6B&SG[?+(BA+?T-CEC1\31dXLRGRZcE\&LH/6M9:g
[XTf_;fW?8[AZM)IIN8B3;>f_T^e)CAI(KX_/^><:56bf+)0U_Y:,88?@OcU6E,U
a,TL)5ZKJ.-.Jc=N3B<22M.,Y\g/Q5#8I-;XBg-2+8Q;QD7(MG;SdBaJY@EDZcd&
^UCY&AQA;M:TEe_b..A:4_O&P53QB@Q.5:b]Wg1I?W;F#>V@L+PZZSQ?U1;W:LV_
?7V^Da6TB4dPQ//6=CEV3dG5)JV1/O<BA<=Z<G&;)6gCKRag=\B5.A.OCg=>8DD9
Sf4+@e/YOeM:Y>76QcMJS>1S=UDD2@?F[1.Xd]B;I39PQG2[^3A+Y2_;;=c?b9#Y
(UXd_:CgOSW@_bU(-)NQKF38PKI\DaVc82]T4,V4C#Y;#bA]-ELPI#PU/^3PXEU1
WVd&?geAF&]HIReIA4FW-Fg(9)P(a]c2,WO^I?Y8;PcR/=90c4eOOD\C/\[Rf\].
5V+D#(1@\R=3bJgHaXYQCRbJ>4He/:&cg>Ng(T=H18U[CM&ab/9XM@[CS>20N]I(
2HL15<LC[M>QXK+QEB9<N[7J&0e,7_Ba\1YP8_47P+EFfD7V#X4RK@)eB#>NJ&dD
7LTID_OZ.b46ER/@C\9=59273+0AB0X&(8X2W;MG\MgL,4f6.\6]1gZ>;:8YcT;:
gcY>\OLCCJ9?6;C+MSEBL-LfFN(UgaWR[M@(bWa_?JN+VI/@;-fZC-\=6UKG3I:=
XYW=+,9U\KgKg3+?HU0<ZBf5g-#(=Kc&],WA=-=H7U>fU1Pa1b-,_0W;@&5B:/H+
ZA6=ZQe^+Z_1d)SF9]&V6;g\JZ46B+QD2WTEU^5b>_-=T8-FCbSN]RZ;6C)d#BP\
5-V6,fBZa)d,c@)/aUFUae;Pee-]b.)OW&SR>bMG52A4;&#P(.KAd]ZZ]2:OAF=Z
Q5+37<Nb?])g]JR7>JR4#9g93FE-<W^E;-;Qa^((][FYVEg0_X7N&+O8?.Q_b.\P
OYL_TZ#Q/4=XS&c</[UGTKT(A2IE^9Y<IDGUK-S/a7>(T0@E8b5dV6cdR+Z06FCU
e8[:IcPCKfdU82)P6eASVU,.b?>F;8LdQSTMEAKA#a5#BVg?XU=,W<>:11N89=8N
@QV8cYL_g;:3A_27A)HZ.A0H[/cVNG:7S6V^c8ZFa12Ud-Z1HAH4A]_bZf#=&^I<
@]M\&WT.RT^>.,@-fT2BXZR2L,4KeZ5N[9Ug3M7=,>5Ib#6cPW]e01PO=Ne6([fC
[/6Z.[YY)HCUX@.Z0D_OZF9-dSTeVR_KTFU8<5&Z_:1H=65c0/32&[6+#I0[g@#+
,@3ER^66/Y5fF#XaS1]N0f3_J0&+9J^Q-?KZcOH):fO\V/4ALP74P]CIgeC/d-=(
U]J+/=<Y@BH#CKVMbP:9I;SY)=e[bOBU@?EGI6LONEC9(CXeMULEc1R8),0WJI#<
U[>ZD549+-=MRF30g^bd^O8:?8&\Qe<2GC8X2E=6G,P31d<Acb9A7X/YAISafdJ1
2[-W\Te01RZ?6Y&_#CaS^:<Ufa#6Y[@8?4K.L;.cb^I(Vc>G17IZ#;C(@H;A8f>E
8]QAQgFM>YXBI=0#MB&NcdJ@dYYM\S__HW,9MBWF+9AEG7<830-M2V4G>2Z:;V6e
W4\dDQ&IJLC//;7:,&SM.:-BE6BQUG8XaHF\YAUd6LgF(RWRIC2f;7A6eEKDIW(H
f4&XfN+V,5gc6e.[8[6>gQdM^gC:.@9/;9G2(8cO15YG9Z:1_LFGXfEg8b8Fa;c4
#OCLfGG1#3Y>;>#)EJV4OCL^TZBDGC?IF:;2e^W.#NR@72MQR=XLKEaCN-,[B]:M
,J7Xdc12=_(1-^4H=-a,g[0;/)fUQL>O]Td52:XN:)BMQ3.(_4a^273+JZB,GZaM
Q?\4:B8WTbN3<bKOPUd.1\.,EJO):EGg&<G5Jc?Q;A;?fRTN2+)/M(W<MBHGL^/4
8C_:Q_URcM)C+)4DL3ZVA[FO1J,=#]9_5/>:7#d\g(&B5)W#CHd00VW/1g)c0NP,
MWb-cI8c@?OSP\/S_J#J>3+;H,ZD3U3A\aE7+=e\2aYaKA/:P)SOfJ)=99^CW:V3
(IF@\(0;KQdUF_MJU++Lg2<fZ/P#b@9QFO9GH,H839SG9(13:@JXfMHHFBSA?<Y8
946C,c8<TOcg+\,7aBaM6;+8DCIN7+@II5E[@14c<L99P.@,/;RAT^B>@BELA9<:
Rac74Xb[TZ?KKeFb8<G2>O\3SP17gES&H<eHH+(d>ECUZP&T5VVb]YaGC-Tb=ZOG
?5E,aS(AbT07KQ;cISAgS1<^=6DPJGCX9aJR;6R?ZCP,eH4H\ZdF;SUfL<O0H+;9
d1D)f9TTcIQ#IB26:ZGO&7#SG512La@874&CTcV=1(47MgW9Sd<F;?.]-T?=NCKQ
cY1+J7YX\4fSD/,?+V+bdP/4=.Ja61.&(L33O065G653KAd0b,3AFPa<gN6d-A_0
UAR@G04R(<D\@,5R55:DY^M&>IKec#PK.)bV<H0:K:;7&9H+9W-8f],?PMUT+QZ6
d(^dZKOR+KJ<]3c,QE5^_?[3c-FM_C:JI5VFZZe_H<4\[fKYYbXSC;f]CMJ_]>\E
I35LgAC6TaF.A8(=I=<TB[PC.0BTeM]8A2>H;[eVV2CL<G_)f<Z9^O=MRFNFR6+#
A@6PE7dTN)LdZ]#1,;<a70?86G(@Xd:)1R(^aJGFc<=8JKcc0N9bV)bU-a49=a,F
T[@HM^V\=-bVBK^J52YcE72^6.Jg,3]CJ;?-6?>L95c<E[[YL:(H]DSZ8JN7D3S+
eXM1W-@2=AY7\dHD=LG=^J?FA3MF^V=SE-J@67ZB(bf<FDO.]?d#CP43_g;b?f56
^W@Og_Y1-##NGBDOQ@]-V3Td:(CT5TbebF:4I3_4Icc&gR?Q2A&);F/0^CecZY>)
Z9?JJ:SP2;;]4SG+P7D#f^B[9BeQ.[?3&ZP^P\[MdCF3.d)KbeN\,G,I;[KPRH.:
T[)_a^#Y/(A+>_YI1UB>bSM9.XA[Uc0]cL)\;ZLA30WJIM:1EXB2P0SP.G,=#Cf,
e_aQY[H3WE9e]C76-CAAe<Z1,P[_3@+TKMc8P?WgH@e9/:-J&0C@_SF942fVJ75T
W2PD\4DK8M^N#[LbC_)08/a=W28U9]P^EMWM=X_WaW&[UVE]AG)4#AG0eWK6I/+X
TVN#/)@&PJFcG(6+C^6Z;84YZ^bC=D?<4=(;<6Ldc3.SaR^e]^0L8.KOH+\[6D96
ME#E5B4(+@06-=e<ePN32ZfC@g&aRc(<G\A7Ig94A5H>;9eQB15d67>Q-gW)fXG_
a[M/4e,@<[N=ROIILT-Y:fG+KA7BZ->ADb:EECb0NdK\0f0CE=cC=129NY<6Q\0D
C@#?)92Od\^V19d1_>NgSXE+3Z(UBT8X.6bQLLMG/\@Ld-+SJDS4S@.->\,BIJ\e
.TE/VGPF(?UF/cV(.GZaMN[GeW=J)cCHcM>8UE.@O:/?6G[XfQR:Yc56@;CbOFMC
_bKb3^NI<Pe^5dY[T68geLJKb?b3^\(ZTdK<TM@]^fMQOHM&R>/E^_aY5(TQ=5F=
GDLb#_I\^:e@L.Fd+VOK>5@#\V9U>YWR_(_\311&MY4PV?c62CS.?2HYQgUW0VN-
03bY7^/F&QdDP=^bIJKZH3<?c7#-5-@C0&+9X2PTeF]&WBW4G096O+4.JL,X#b\&
I>I1,6R(cA?O.+^He;+2766JNTCI\71>.Q7LQTS9UE@eag#K5_6.aXL8:aOBe3AT
=#fI59FOST-\9)X-b]b_6S0ND.LK0+6HYcfW@UZ?\fF3a:.Hgc+P)MWXS=2G/Q80
6>DRd48\bagN/2O?7>d)gYb7/eAdQJ4Y3&g5g,-O8&=T^@7Kde@E@=UBZO1TgVT3
0Y6HcB+/SdN?6d0Z.E)\\:Z#]Y8)Z1_^J:18gHaKER&F#d</cB#++ZBDNbM,D]K-
_D0aaN1?(daXNKMC?UV#bL6RIdVMSGZ)RM1<8-9;aLR]\cJIN:.\A#[-8GXQg/YI
SE5YU<CD:8E?P.-_);=0IXIZ4-[2J#W8:]9P\BT6@-=.5BG_aLHSH[>d7T-1SN39
[a+)8FgOZ51a.eGD1,+H#>8^SX1de1PRbFETL1+VZ/R2aa()O?\/&KS#&DD5Z3#X
&<SY]AWc#^.a=].NSe//:6B0EQ@?+7676CE<XaR/#Tdc\6Og_B7d<XLYfX>,J>UH
+D@dK<)2^?RA:7YdXN>26?3]O\C0.,PE:PG>_\VYE4H2GF]9NP0f(41&LQ\5KW49
c@:1VF3S_Y>fRe2[[CM.a\bMJU;U7:b0J7U#&fZ8PMJ\H(?d53ZAA/VAS@1Y.O?c
KbdS2(dUSQ/[8bCK9YUJR[CgNN\33OgAA[W6[HO4/\eNTeQL-#[)8X;GCg(gF-<,
/YC]M&BT@6B^5gB0RQ@@.Z;TDHA?:.-HH?JVf9P9=0)DAY+RJF12+9(O_#We37MB
7R--e]54>GF5U#VUD8&045VMafEWJcOQ&-ZB8Vd@21Za3UP;A@-;]d&^5JE=XZCG
Ke)D+NA7(V:MSa9Ia&9E::)G8]ZL5CH\?\PCKV:fS(S7/aF\W5+]f;;:Ud?GLVf5
cbC2,\K4I+&b/EC_d4O6;,;Wc)FMd<?>>C]>eD)d1<LaQIQ(93<#5=I0WeS4F3dH
<?IOV&[F?g3M.S1#<ZKgR&<E7ECE4FB)/&Q^NaG_4PORDZeV9DP;;OEVHbESVZE@
QW;C>ID.;SSaE[B\3D.\;bfR9<Y[(;Be7d@5QE?C7>UV28L]IJOV_HP+@d+WXdFM
NPR91\E+a_17>7B[TUKQKJ[W0((Z]].DKRgO&<NWcTbgQLe1^J?36#VZ1Q2+NV#6
(eeCZ19e;[fg&<SL=c)gSAA(?5./>;6^#S(-DWVJ)ZA^e@=+=gM,aB+bK6.[eS;g
gTK)U_0Ab[M2TO;A)dS<N-fUS]eB(1+ga>Ib<?b4WVT/>S:0WI^:1C9e<4^:d3K,
[(X1YaeQdVN,0I#DA+^S7?CTILYO)(IJ=ZF94,@H\N8eVbNO.g#MXLMR+3S=gdUD
bSe^9)S5\C_<#]6LH?47bbgKN&dN&f:5^BCSJKX1@[);-?gZ/Ib:Peb6\[G,;NU^
#c0>]F6.CPI:&Gc5O[4>&5T-?2b92#L9[7RC9?7BTAaS9)Ia7gbA/90KLDUdJ+;P
e@[<[WcF3WWPR&DS)7=Bbd@?:1SbS<RUVFdaa0N6g>a1UfXCS[>0N.L)M:@];C/8
a2\K8W]SZ,ggRMF-Kc1Z:B8gMY^#/)8;0VUDDSS[DTZMUMHf>4UB(X9O0d77D:2N
]_LZC&dP8BYe005&4L5O@V3@NNVDO;(-=K</=KIP,IWf5+DMcKE9-cF+7:_/+WWI
A&HM+@XZEE#53I^5b=T)&^D&E+EQ2]T8JYe0?dAZ@EeCa-28K#e21DEKBH:-\\;X
Me>R[fM]TR3YLg0_KSQ(JMYL/e5UQHJZQ4(J@Hb91<K-6c4W^L/T/fT6gKdN_I5M
RVHKFa]YF>S/:/G^TVOfM(VS?-25S/c[:DBK)S<^,6?<K2KWCK(@GQ:AZWX_VB7g
\FULVeeQH)GZ=E3,73HCd#4[TCWOCS5;M;R\IQXf=A_6M)H^8aW)(:K/?XE^_aa;
,RP?VQcX_Hec9OILA&eV-:LS0\YcCGBMe(MK-GH?,eZ\UKAF_<)ag=CP0:U#@RWg
KP5ee+?9,@9(P_bKT19B(F)XgA8GUIF9;g?1S(A=17a)?g/7.H0(&-QBbe?[d6()
5/PRI(HZ>_,3-E4_#2,5dG=4_Va;T=X]_^HH)J5XPR2WLa.^g_GVXS\OE-FB]^Ge
)Q\SD?V_1bQ;f0Lfd-KAS5H:@PT7(]:6<34=D4O7V]d[+S7N_-\#/gB=FRTN\])E
F=cZAKFK8]U96d.X2YIVP9f5C[<dZ:S2^[]0V.0B^<=O:/P#0+N#XGJ2#Z)D>-8#
@G1W+4@KO@^P1N+HYQG;U+QZ^VKcCRAUIe+R>g\7/6BQUa]XcJYfO2;H[R.U_BU:
KTdd2g-8C[eVA7Q;V6d?9eJd+>WB(QUT-?:6?JS;5S-,3N6V6J9,+6U5\5FA<UdT
NGONg0QIcEF)-1]UPBd6aW9NN+CMf+aVAB:\Fg5:MD#DJT@:N-U8I;LI]bW=@caE
/&Kf\1eEf/J38eZ\;G^L>5T&<0K&PS<G)a,O^(L5MXd(_I@MSKL(DBa5N=_4bUCB
@5QE/e][=EWKKa><PG#KA_<b;f@SKEKGdfSAX^O<O.V[5S#13ZgDQga22Q\#_<JQ
@3MLEAA7KG<ZOY(Hg9Z/1:O>-@;DgI7T#NfRD\NOA#5FCSB/@:gf;f[ScW?b,b^Z
PU&X4YI15&7BJJB;dIWXSJKQ;JWSPMWe;-^2=/GYU?8:Q47[7ZgeVOID]9X?<0Zg
9F50I\//6SH<+I(Mc^D4c,GF]=ED]^.,/WV/,1bCL6##@K(-)9-(<W5[EGYRN@FT
O+PZCR.FcaJAf>?UAEGQ7L9UX[CcaMa#?3P#cAD#6TDa>[\9gMBXBT\HS+dHCa;-
B]WbKV,&QV&DE-:ZIL5)A-Ig+^<JZ[53L3[#0K1+4^67gDK&I-6H12&HS#IMR&Y3
HM>8\f^MJG@&&]d?Z1ef>^J+>fH=b<^H.<.SR_a9NJ(-Gc>0=GPS^9AVRLPFECA;
/#FV_E?ZUPgI]+=DF=g<:-C#U5X4NL4e8=)\cEd8<>D^UMM/Q=.S-D=(+@g3HMY4
TVb.@JYQfd07:5d.]dfHZKAX:CM;@SM/D.Z7gAXc=U>@a@?.((_]UH/R=ZWRGDOX
)0<B0B#;Le4I,]Q,I<4dI>D[Z650DDBYH&dWYO^GKRAR0&FRU:WU]S>23Q[-b2C-
4([Y30U\&?(]+8ORXV&)<</,cfO1I.=3LOAT>9U[Z&<P3MA8?:D>HM3?\,S>8QKV
F4^3HYWfQ=K4RGF1F)+X/L+<I+&F7RO3;:L1S[C5Jg&Zf>D8NX=fF-TK<K(@BG?@
5N3:HFE-S\>X,Fc3ISG]C=b+/[J1H9[6(C-S80,bfW)OER<LOQ]1&Oa?c-9#Ac@T
TR:e+A.XHP/+BY,+C3;KL,IG:?>QV&,AdWc&TQKVS4Y,f]KO:C?QQCeF.bacE&gH
b]ZR;P-#,,YOMO^JD1bVGd)G0PGOgg<FF:1eP,9>83_Yc+MOHRJO>S[c<_H(1WW6
EDDWd3]:]3-E3gF@3?PI2Z)S>d9/FJX2A:dfX](EI:_Y1[A-8.M(S=N^:g]IM0/S
WJO52)2,cJT@QN1+/cSJ&>1<<OEVC&=^^:?9D^PId9Y)8T(Q\ZL5O^BJ&E6+,Q>,
6/.7aJYZO&JQ->&#A&UK0GB2)[9ANbM_IcZ)W9]G9cb[aU2_7P-\0c5cX3JgE8US
6YM:fY#XXB@C=R<ZbR3]V6DP,X67](FF+:SX#QfYSR^]cDaM=8_+#1(9]9P9XFY8
URJGO0bX?J4X_cXJ3C1U)0,FN=VJW/BVWZ2.c>GS27CcEEP^Fc#N)HX-;^7_V@5<
(RH[_H1+?gI66L^ZL)[S05E59#O9V[A_JB36DBDYWg@dP(:4f.9GbJ]Q@J?PWW[7
B_#KI=UOI&@8PX((>676;#]<bc<,MX6;JHN4ND+Y:<1L[=#c<>JKdJCa0++]H.E[
65Z-d4@KJKD+8GZcGH?7IZ.KYNUaE7?DRdSKC-L=-LKb6ONCWAF?E^0Tcc4OB-X3
2BM]K3HG=6._3H0+1X,T[ggKdF_Ka]>X.+:YZB=Db<)7?e;[U:QFc+4gX14:C9F<
.Vc_Q6NG9N09[.[I=DZ)2:KLUb)-#<L[NBC02(OU<ET0TR6KFISSa;bDZ]0W].--
P+WV6NJ/0M3IJSBCf-6,5Qde^L7f76?;<AK[3D@=YVeP_.E]^BN5E/2fR>c:ab_.
aC,=+A+6/ff)fHE>Mc&FaJ1+gFUF==M[IG;0^9#A25T7/XGHE(K0bLH]0_R&;U6#
91S&;QP7\,R5BJ;PW_^>30\FFLEYc;EFQ_#D[@W>&IbVX&2#-g0@=#:6>KRS=dN<
D,FDX6O90/B7Gab(^\W].FeGWI3(G2<K>133.19+W]SQ2/SK:g@S6ZaC#R[4=L+1
9H<RU?YNV<1?dL&-.GDAE4dI#bc3G0Ve0+1.5JS:R4ZM(f1T+CS(</D=>HdgKJ]Y
DM0?JJ76MAY_7#T^-WX(\U2S,XO51->fD/b.LND)7#e\V:.BI>JLC9T@T0K&Ra1E
#(G/aH06CO]QVXS_K:aZA#^XQG<TC@V;+B7H=OWUEFM\L[TMaMS[Q]D1@_LQEY5V
IYNfJ0ZgZ.9._C<SH>)/JXc3F:&1?A1Zb.G5:=dAc1dFbW&+6-@U.fQ9HT^87?+W
Ya/=BXgI@@0[Q_NXef^@(/aZ,BEKBQNPEFZUfFJ>2DB)e)L<TdA9a3)XC0eIE@_g
JL5K;G;9Vd?6/<TdFX&gX4?bDYM&.ad+S-H3BKWY/&8d_f&8Ea<>GUGS4eK6(KdL
fVIU-,Mb)I?HX3P_ZKd:MB69IEZ3WESO+T@[S]A31d1F>71N5_Wb5.QA5bO_RaAN
)1Gd=cSY#QeGD&b2P@:YXH;YG:AS-_H#]9ObQ#>:H#E2IN2?f9;cPF9g0JWMD@7.
DfQBVT5)]6I<=G(:_#Z-a(f2?V.8Q2I<N,K9bIY[62fc_1R7TC1?N0aa-\)@,KSC
5F1BOH^KJXG@]eG<5Z,(1-)/#?#1W^SeXe;eQV[@#:eBeY(TaTP\0TUHJ(SON;eW
EFH^(8W3P)[PCf]de\#0Zg1cA[&O&beXMZ\,GRL:U:#@#(.X4Y^EGfYQA)HTc-K,
Z]?/QW]\fP#g5Y:>E),]#;MEPM-VW#COUga,Wd7BFRf4>&V]\5eYM79RT99AQ4RS
(99f5_@ZX>I.)@^&L?0]HNB0CfRD6a4U&;>MdGT:CbKMRe7c/35Fc2S7,KL5R)[_
R#_S84+gT]L<4GGP[9^DSF4b4DL+Y,:6F3cKa^>@VSB/_@H?P0P^.>)L8-_P1=YW
N47CdG.QO9Na0EP2JB&=CLC>+OS=)MKNOTT:4c\E:Bg-VSd9_OE3J,Y]VJWS=KHK
R-Mf2\#L4I0?_P#KR:4D+aB6FbM:c&2Z_W.0DL?NTeXYS0=:@2fS=XM)G2W6cb8E
W-MC(fLHOC.-0YdSa[K)?=(b0f&Z/7SPBH_DDT>FRY+MFJ/\S5I?BS2;FZS0>#1a
c[&H&3fY)L\PI;=7gG1g(f-c(>,5NQdQaU1IRd540ME)-_J97@5b,OLJO.C]1Y.\
X.d?X[:7X<\F\:.e>,8^;.1W0+^:J,4;][GQ5)Of3b[d<@2ed/Ic6L\WbW@C-c.9
bU/G0[4<34>eD[/L6C=eSPS7-8E+<FDUQ44H@^KGG.2bCbFO45f)3E+Q5e_U5UK9
N=XWE^F]30U84=Z)MB,<53.012Kd2<3Kc>^(V#B.f,FW3,F>ILJfZ#5Xe>]Y5P[Q
@IJPL0VK(RVN3WHcE75T<.#S1&AN?FC\#19O;;8dE\=V.>C_>3]\RYX2[)Q#&D.2
2R@EKc5^YPLFdT7)3FeT-T]F/?U99OaVS9f=?d2MEXLRPDaJR=4gN+g6Q01O8A@X
K7+fUTfETQ@@U&^+,#dgRKe1ADAE\-&5FY9K=FE0QU_T58d4JSa8-#4K7RD-LD3<
Qf3V?GX2+(BBcEcC2?O5]]dDN8J\aL-@-AA.3N9Qa1__;;<EV-?K9B@V,:fa@.7V
4R>6O+?M-f.[79(fePW:9A6SXXH#696@YT=e//=@=_ONA<Id?S1]T4)fFDGMfR/X
N;PXAJ@3c3SC(@(/8+A[_OC//#8a,?TN[gLH4+?(&Q2\#1(LVN5E#M:K:BT3VS1X
=\7,:,:5e&#SB>6TYKL/Z>3Md><gbYbdN1TKVFX5\<=6(?GLE=RSSAA7U,TQI4:]
NK0GW1G3P7T@f7#-^]CB]J:G+c-#>?S&FQ+U)0JV>N94^8bM=#1EN]^AeVd<ERXc
:SWafcUJ]KHa<KaM6_I2BZB:XBe#3bE]=.JY&<O[VeTZ\M[1Sg\c7G0?\C2BTEG?
bP8+F9M#[.,X(>\]./K:?:af^_2UcXFQ,V)_9<=Tg\S<ZbPD<&[U,T7a].91MbU]
LLMG1IA6.LZH&8WRY7=[5USXER=C[MB)NBY&;OQ<S\O@>[.aEQcIdBTJBW&eT]0O
2>[&.Q6[8QgRE,?fM32W3.T=N&N^+SDQQV)W@DJ\CR?.BJV/0Z:(:gb&?I5;LGcd
JBXbf(L5De[f(R.YOGRd:L,2\WCRbN,T]1BOXaYf]_6[8e(,79;[f1Q+Q,O:NJ1;
S9>T/CB6b#M&H+UIS)b1V:<f68(;2RA=W63eI?LgQa>)@/4?.W2X,30^]@2ca=L]
G7Acc>>3E=MQREXeX_UH9GGA;<ae#+OL;QL9.?8UZ:7/SKb]DA),JZee;aP]_(Ud
f6<J9N1BI1b;CSRg@2JUO^970DA7,I;5.MGQKQO(.E:FJ[Y_L4EF>SCJAH1HNMW-
E[H3(cO2BDM76:+8(Od8:C<b@K,G8[R\BGVC\4>_(E(>V_NUG\&A0E68VD6eNaQe
=07,V9L#.>+^/bSdLI5EMg#PR7>7)^VTDReRYBg_fc3RPFEN:;S@JRbJ^YTaR3YN
ZKg?Y(+=4J[Z_H1BUg9J0.1B??]4FX&J=A7+Q&O/=E;D]FJ\<Tc4Q,#A.NdHa<5\
Y[Q+1E97_6//3-(EDKJa4RNXUL7@bH78KDdJ9APAU<bI&NG/]a3\^H05D,U-7c)=
]6V_Y\WZe1J<Dg^)4cBI1L\[S[gR2Z1N6FYPW#\1=A@cC=&Ja(G+K,<O7FQOCMEf
G=#B.9K[G7LWdb8=HCVA#8g7]CBU/\#-NQ<C41>A+NPR]4MMIbe88+W8I(2L,_Zd
dC#g=^@0f+7[\^a+dggJ[+Vd[3)Ea7MA,^25(^2ZaeBMFH>_.D@A]N4-;e-^RC#2
I:]gKBeRX;:-FR4CU-KVT1Sgbc4P\dW\Fe]0M@P(IG\2a6B<+KW+^=_?8&XESS[?
.=I-bA1Gca:@&YO&@c4X70>gb&U&/??)T3[IG7+4]PY@_f9c\RUX79@,-3RZ[H,^
HP[Kd,dL#Z(M&DB[gbYLd+HX4,LfZ^0=4#6\DH1.K8TE7TCM&EO,\.?<D[(g,HcV
J_BV8_Y)DJNS:9724Ng#94P.,]UUCNeK-8e=a^)cAeNC<f?W[Kd1^6,7g=d,7P@2
YIOc4Z#aAZfUN:5G(FVE<@/g;MCE&b3_[-[YYeNRFLYY0Y\gZQBEW6Q\6T54KcKZ
8C<ZALL:]/X;)RP=C0/cNc[;a0a6>1@^d-G8F]VeM/[J44H>C^#K[/Q=&.eRg-<b
+98A]<;J[ZZ2SD;cF-(DHGRVNA#ZQSS)T[]7:?H&F(NGV:6DI9f35WRa^7D=6:c^
GN1=0JJOa\b(=8DFJ4g0;7-ET5H4(_=bgE4DSX4)F8K,bgY:U/Mc,JEEY9B,=-X)
UAR0;gMN:W7-;R_74gT(g:4AS5(\1V7[FF.8&K(5K)a:Tg&0fTWB:U4FBa[7JD#/
OQ2B,e@BRa+O-cQTM9\E__c<?K1B1b#FDI/O54b9V1Ye2@@5_3>c@(08e2B,WU:.
___>62DO-4+Vb_Dd4e-KB[5cCZ11Y-71CF+;Vd1d>^?Z2A\,34cLPS/R?./ecIH]
c)KW39FRJH6KE/g@W8)BR+2=0ZHbY2&_fe5)&)G1RACBc<FLTg;HDc(;UZ[4g;,=
Lg/DBS6c)N2)370=73a+XUE^R2UJ_&FD4&+W0+<#&1C2:V&XU^^4>-,3gKAO2PXF
::>@)5a+)<N.GZAaT=1@26O\F2cKC5:bAGHRN.?\<_./^+^G1QdgK:^@LgecW?&6
LTHGZ3CRD+)Rf#Ya;5K@A^c1#+P_M..0Y)_+2UB/aH8P=ZNcC>E/\L#DHU4OF)2Z
Y7GOcR4-bU-)>@cB-710.P-;0JLXPOP6(:8#0Wb_gO9Xc1)SQc\Y6bgKg0K6]LV;
2R>UgUR>WL?4f9U&QHa^L[,cQ+f9Jc:D;_5^-;a?/4a_>cVT_L66>]aKLQCcNEFQ
JeA[Ya8AC8Ne9THbX_>39@30bX/VF2&+&0;#Uc.RQb>:;559FKM,?.-aa=9QFeF0
:VA9e(<#(92UWSJ9>QaU8eTK4F)Y/6cQe3@(M3XKQ&fFE4[80^B;)KHd:\=ZRQ6/
KP.E(<\bVT848+L<,(>1,AQABcVJd&a?6Laf9WJ//fIU+)\4#-I^IEL]?4WEOAO<
eZEQUUFd#4]DR>-EWJSf&E=?X>I:7>D/[JJ1BTX9,>3#E6YfZX<V\<eF\W[5f]X7
aZNZS]Td3]17d(_6L^2?3[1FN=G?V0E#gf:61AN3K:(MTHC&3CUEBQ8>479.27QX
I&XA_(-BPd(#7E@[g,b_-?fH7D?D0/4KDe4#@VTNY<(aHWGPDEM/F.7,1g9;RU7C
S[G?aDe4d_N-)a9+=>GP,._Vf;PX1.MPe-B0.+X;0X_PEXXM^;2PYYVf:a0ZE403
fcUb0/fM=2eb(&CB1\T5J0bS1g^)QFAa9d#GHQ@IXU+(TYML2-T)Q:LbH\J&GKE=
[7XCU6_8L+<O6a9\>/).?JO/;Ag[&U#bQT;NA+BD;J2Y=P<T1PCDdQC8ME<7._D&
YJg.bfD[K_4<9=]baM)+e1,)T3@,9KW^5DF4KY)EGTZ;P.U;WCa+<6K[-X.X[.GYV$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_JESD251_XSPI_DDR_AC_CONFIGURATION_SV
