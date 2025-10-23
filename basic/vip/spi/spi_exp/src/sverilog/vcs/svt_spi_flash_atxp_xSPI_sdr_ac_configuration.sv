
`ifndef GUARD_SVT_SPI_FLASH_ATXP_XSPI_SDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_ATXP_XSPI_SDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This is the AC Characteristics Timing Check Class for xSPI Flash based 
 * Adesto ATXP device family in SDR mode.
 */
class svt_spi_flash_atxp_xSPI_sdr_ac_configuration extends svt_configuration;

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
   * Minimum Clock High/Low pulse time for Fast READ Command in Extended SPI Mode
   */ 
  real tPeriod_Fast_Read_SPI_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command in Quad Protocol
   */ 
  real tPeriod_Fast_Read_QUAD_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command in Octal Protocol
   */ 
  real tPeriod_Fast_Read_OCTAL_ns[];

  /**
   * Minimum Clock High/Low pulse time for Burst Read with Wrap command in Quad Protocol
   */ 
  real tPeriod_Burst_Read_QUAD_ns[];

  /**
   * Minimum Clock High/Low pulse time for Burst Read with Wrap command in Octal Protocol
   */ 
  real tPeriod_Burst_Read_OCTAL_ns[];

  /**
   * Minimum Clock Low pulse width duration.
   */ 
  real tPeriod_ns[];

  /**
   * Minimum Duration in ns for which Slave Select must be deasserted in
   * between Two Instruction sequence 
   */ 
  real tCSH_ns[];

  /**
   * CS# Low Active Setup time
   */ 
  real tCSLS_ns[];

  /**
   * CS# High Non Active Hold time
   */ 
  real tCSHS_ns[];

  /**
   * CS# Low Active Hold time
   */ 
  real tCSLH_ns[];

  /**
   * CS# High Not Active Setup time
   */ 
  real tCSh_ns[];

  /**
   * Data in Setup time
   */
  real tDS_ns = initial_time;

  /**
   * Data in Hold time
   */
  real tDH_ns = initial_time;

  /**
   * Output Disable time
   */ 
  real tDIS_ns = initial_time;

  /**
   * WP# Setup time
   */
  real tWPS_ns = initial_time;

  /**
   * WP# Hold time
   */ 
  real tWPH_ns = initial_time;

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

  /** DS output active time from CLK */
  real tCSLDS_ns = initial_time;

  /** DS output inactive time from CLK */
  real tDSLCSH_ns = initial_time;

  /**
   * DQS to CLK delay
   */
  real tRPRE_ns = initial_time;

  /**
   * DQS Pulse Width 
   */
  real tDSMPW_ns = initial_time;

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
  `svt_vmm_data_new(svt_spi_flash_atxp_xSPI_sdr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_atxp_xSPI_sdr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_atxp_xSPI_sdr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_atxp_xSPI_sdr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_atxp_xSPI_sdr_ac_configuration.
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
  `vmm_typename(svt_spi_flash_atxp_xSPI_sdr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_atxp_xSPI_sdr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
fJ.L?8a(Ka.\cDOVKa2B\cVTT+eJ.R)<?9S4W76d9+EYHV0[>U;32)SJLIMT>dIB
SZEW74R_Q&Q6@2Ga7>3Q.2+BM(.2f@8(6UdH4>a8KASV(6e)U8Kg,.#,aI#g#17T
2K0N+&<:&Q2?eeJN]18C))d>b42/Z[]a@/GSW]Q9.F(eV)H0UKQQ&aBGZL0L(><U
7)1;W&.H.F.)[B61FBJ;5K:K=_>+>MXdYLIPNZV\3R\,]d@R=)HLU46,UQ[9:U37
3)P62Me7IZE>HA>c70M+-03NWCg.AgbEUV]OD&JEZ<Y.J<1Q[J]FX6W-08,c6F0&
>I,\[D;Fg7Y\\10.HZda9]XFB<M_<J@9R20Y:#LZR^38]b7CH@E<MeK4KG>.d?J3
aWbfPN&#MM?I8GcT)E0BPgWUK<<YO[7e\Ff&M=,(LN&_7+DH]EM6&#)QR8/IQM9@
VWA7+,1@RE>M98FT#ULTIE^I9Tc([KdQ-^N5X08.A/9VQNX9I-C7c1HD)MF?.bHF
dgMJdSR5QKII;#3CNb&1I]6.B9K.E1^QMLC[EBXVc4V_J8NNWOBRLG6bRM-&HDD@
N9Z32a(R+\PWF3#,QE<?b&SU4064_WBdN[OO25IPb\W15f:AIdU.3KSgaY7V@Cc)
\=GZO2QX^J>@1JNLV8G)YcDK[N\LOVM10/,-S67Y;ARTC+2>X)S1O)SUg_E:OEG<
Q4FXJQP-LUbK?[,4:RIcf3SUI/]b:O4b91-2U04WB(EScKR8P,US#b&fCY/F>TJA
S;;bT]6.[U8KV=_,G5H&\?H/af5L&W]Eedg0b]H:>:/SE$
`endprotected


//vcs_vip_protect
`protected
:cBXA0;YU:f+LOS:&KV7RU5<U/3KL&g71LG\a7C<ZP7LP3CRd^.1&(42RRV#MaD-
Z#6X<(,7NTBC>>.=_G:T.:ZDURQ>Q)JeNX_W-F82X6=-<VJS<A?3)><+1A);S,@:
H+O;D6(>XfZ[JYK))#6O2M6IdFa.IO2DB81X1c,U:/?/6^0@bF/Q\fMOU#R_:[^O
^YfA\9B^Z?#Hg5YWCZ248BF2=.649N:T[P-^W,OL)TT.8=DD9V]PS_A(17@QZ7&=
BA,GGTeL=0J_NH_;ef))aT1>7?KQ.eY^CD5BPb+/W@7RMZ)3(b3#Cg^O[7F2&/.^
cMBQXf)d,b8;gVPbCF\;0N^Rd<I)=Y2c(N3d=[B,6P.H9eCSDa,7A+gEb#41gI5>
&_DPfXS[/1:g6<0/2Z2^<a9Jf3()4AKA]eEEg_\R,,VQU45Ubb<I@N[SIN@YW5PS
b[d/a?Z)^SK^/65/+9_\X]A_fKXB(JgFaHd&Ua^TfMF@OWGc/d2C)#OM)=B#9[[T
cO2C4-:4a-]49O@W_e3@<-c9D-HO-9=_[H4fFA1-eON-cHK90TN0eY4XS:PWbX@?
\.D>F,32VDUV7HN>994X(.M[PQ)5C]>DdNc@fKP\c3E(8:7+b,RCcE<+bGB72cW5
)2C^bG/IM_gL7N-S-IHCM?0XX:U_gWHZ[Q4/CQ7AT,T)f8&XgC)H.;(8LG<:3N00
J0B3I7P.1deC&L[A2-/K6>]Jd3+Q)dW>98f#0=H<1caRR9_7Q,U_]-6BH=U@@,cY
>K_EQ:(e=a[(/BAM2:HGe;?3X4e.:C.c6>8gT,>_Jcd37g?[<)NS<YKP1I=B75+&
cH(,]-3T@,YC@BL\FfTTVUNFI>#0@/^ULSM?YeEUeX><0+/VTM+_=_CWfH9/S<B;
,9(b_/\bAO;#&0#^@9-(I1CO>O(\I-6WBBU=A8MSSGRVZaFA8^OLGd)PLF&UCZ<C
864<2FeYU16a<B#.&3D@=d;L:ZJUP,BMLM\R_YPB/=\UI9TUB4XEOA3Y.\#MQEV^
+^TOO4\?.b6DPFRQXCKMa0QM8\(MT=6f,79Z#W;VKYP0f:^dN2_^EY9;[LUCXSC^
B0Z4IbZ0V:MIQR)b0g:SX9A(4Q&-d,TH+@LQdPBP#D4]^QN8DLc1,LdQVI:D+a)\
Ib0&=E:;3FNL]K+PW<?Y&LJL2WVK^2V6R.BW:S8R/R4P,,X9F8Z/2F/5=?f0ecBK
Z^GSPT\KA7LKe@4O_ZQ(^_b8\?6fHbeb4X#LDV)Z9L>NW#8D6DV6FDMXeS2#9^Fd
eDf:8((9DV9#J4B29.#D8NXPff6GF9c-54[P:f2Bc/f5U9]O.9RaX-<@@TSTX7Q5
[5B+9IMd/\\=5IAc8(?CTSgW:M.L-eCKII?1(9Qd>b^/=6feGUKGdW6JU?G__3-O
a_MV,bRKJZ\^8)<HMNea9IbP;Y5H8dBB@8<bS/@Kf5dKNCG[U<VE\>Fg3F>(/#&T
#ANY-6XCQH_RB55Ced##3gW=OH>&cP^5MeB(g.S\P.<cDM(47BPK3]YLY<A\I:D3
ZT:<J;#MEQW&c#HD2N)&=fWFCXQTc4CL+8-SeZ>_4UNKcUTfd+4:6HUW7R4JCL,7
8RGRc8.U3>QR1LW7GZR1&e^OFO(HGefS4?5KGJ/M&DgfBR?BQ^J0P(,;(f?M&5G\
X];AdRC5J]KF]Sd93CZJHJEZ[eDW#1Q:0HF3)gb85)B18<Uf[;UcIU4PEaH7-a9M
0[D/P]V/G^O6eaSZ4<N4,ZN>c]d3TEEG1(Mad.9)[TUEgLb=AA_.N;.V6B@65\3B
1,#YMZ14A_/MM,-:F?cB&Qf474I.G9+W&4,YK6P2F1EGE+Q<ENZ<e./=EHJF+7.0
,W_<(XPF])B/K.1PcgRCXD(Fd2[/&0efd9^_TH;d/3TFMT;;@a#>]ZWL(9<9)Ra&
YG)U./WL5d9HV7PGM(5Ma1A5.@Y&=dfgU5)D1#d2K7<&L9]=FK=D.9SCfdgTR6;g
AV)PXT\V7,JL=:d^V<LAEK[22(/>589],gC]405Ae23bXN<XV3aID9#M)Ab2f=XZ
b+3+&e2SgE^0,?EZE5d;Z/OC0YICa.Q\?5T7=DfI3R;b:WY8WNC<E<fc<)@gA,Z3
IP7F]1bWM+f2g;+g&1EIJ_N-Z+_7I+Q.DVZMO9a5Y:TUZ5R/Y)OGA<;NdNJI>@NE
c-(d2353@69/O&RFUZXD>bD:+AB+SZ1E;WSW@61#Cb<J.J\WB]e3aS9?&/3V4:=M
S>HS)8dP<(dSV[)T-=[d</BDK]/4-Q[YEeM;c0(;HRJdN:4Z@EM1Vg;b@3T5@:-D
?;eXQd+/:DF@=FVNcIAB;f?EB\,5;c(e;8.bgPJ[UTC&W]3H+#cWgLLT8,df1-d-
MDZ8DRe619dfG8N\J<UD07=D7feKY.<):R_<g4Ma]=>a,DEMA1XZ.WYgT?C#ZfJ=
,G6U#EbO1b>@49Z/.K2/H_2FA6.).UFJ8a3,&[aL[PH=32WZV;3U/9(=<LK@K>M@
6(OA^I-9DEb>:)[O]BDZSN<;2b[6,_TLSY5]Gbb8aJ[H&c9E-T_e:B8]>QfW/&ZM
3?7-e94T(T^?=)U6(>2;_CbB6RBJQA2GBS6gSQa7X?&W8BD2B2YaecRL1H442[eC
2Y+aB:C&eH6+7MS\FU,62X./J/(OE]BF#AQ)J6&M1fBB_@bI^fF<54N9:S7U),IX
LV;V@FTLT.JJTE<0M>a<PY+L>9d]X16F2,FH5)6)3^?[ZT^IBBS>=P(PG+5Vg_BQ
S/#-[JA\FZE5Q^OeL-b6EGV4:f@8dN#FeNgP8#1,YBeEIFH@(2SJcNJ7&:g?\&@=
ZZPQS.6CW>@T/Zb=HA5KW(f5)JH>S&JM3]/BR6+d-:42(9,V)CM[\JS<:4SRZ1BT
>N8()I?d?Q<O/F[]:L/5;U7H@A+\&UC-=\CY8ObQ-78O0P?+H]gWW?FZXO8>GEA;
/9EFCW2B4##E:NZ?ZI^3fZVG^QT=LgGQO=/X>BA6FUXMWDK7e\8_+Bc_P^[MB\UV
2c?C)1bW+@C_,@SD5f<P:T&7/O3ZXM<GRZ1Ke(eQYc81Rc\9@:#a;2T6Vg33g&(=
?X+d>2NNW.=#4GV&eHW83MK:6+,@TccMV,-b92,1WR^L(_R2De9;NVeSYR_)H5^E
A/?AgV\ZBWbZP6->WNc\c/;JY(W=S+V?N_/6D6B<gK1Ub1S[#(g_HEHPH7E)d^bL
c=+Ia<HYOF&PLB,SK[/ZSDRReIXLWdbA[#fL4Z(<\-eH<</Ra/,5FFM^=(A8OTdc
eBTV6BH:UTEWSW^Je>TgB-\fb-Oe7M8PJ5OG0NX1IEbbJ/0BWCGDe3#Z1G46eP[>
Tf)G644QaKKbGU5b8]WKSf/5HQP??UI<:;E()@4,S)?-/gB\IS;DS]F36Q&YKI16
I=KYfd)[fd=G(I]bHTUAK?K?T,C8Z&;gD2XLfIbNNK8YAVfa&#d1M&L<cb#K3&;g
;M=NW]QP1?=OD8R(NR=c60I]Qa8\c0E#XQ&X1H;R/bf8@ER..\,JT^Ic8KG?_^7:
RC>WUN=&ODEb/Re#Y?YbgVGa6c1^(VEAF[R@YcC/6UR07aSH\F0H++FX77[Dg\ZR
ZD?\8P6HS7e.PFCc>L-+CWHW8B/71J8^7,QGbX_B33>S_aYR_)XN\N-cKUK@,-?f
B20>>HDAUBL:08<?07dL6_^G#b5Y.579<,JMdA[f3e_0H]4P];587#@;L^a3)8cV
.b-_3G2)a(_QX(e#7DEaWY+:V(W<L[eG0H(+eCL^RE_<ZEaV]TFQ9dOb6+0c9;92
L2\YOEfR5Y7JG)P@^d#g^P#KZ]d0PZNe=R,?QcZ19C,01/f_a\IL5&>#QT:9H8>U
Nc:a8#\L.Q+Rda]>GN&Q@^U=e0R8>W,1;\K\_+?X_+#5eB=#OQ[?@_\.VV&,&)Yb
GO=7cY9HMX;f9R@b+T5#TGeHAK,&L;Ab>VdV4+O?749C^Cf>-BBV?]U.B.[_LHQI
7aSN&G=D9#D^C9bM0(E?4]e]2-R/.C(GdUbc4bH^O5a3=Vg5SY+U\=e:S_VUD[VJ
1])&Z]f;Vd::NWZ?b>9>[(0:A3f_FF&9Ue80X0Q>)^A3fEXJ\S_^80a,6NQGQB-,
)8d;Q):0S@ENKUS5<4QG)K3YR_X?_dQ#/#VH7M+VdW[#YcD>/(#b5Wg62cg[2:W]
GVK0@K86@8UCNEe#IL=@We-CgR\\baS<d@ZR):g-gW].Pd.K&GC=16.I\<dEU[R4
S#H&8@4eH^.90PFc[[9_eRSL4VN1KKHZ=d.\UbeOE^^YVMR3;W12I&QP0V9#1YEe
>HG^H:Pe#3<.;^J?]<(_-@)3#>5&7H7cLJc9HbbC1NU(Z]eF+TT^):McHeM/?9.U
S-AW)f)OJ4=HOO@LRKa2>_)b]9/LE@MKJW6KZEGYdNU@\Q@;&Q]e7_97BfS5K.-g
U\6PA]\K??[+9C<_Fc-afF:+U<3C.=P&XHB][19C9>7-DY2?NCGRIg5c<6^BEE+g
RZU,H,0CcX1CUFUJX5MVUYY;+C&bOeNY&1SFH7U@#;O&#,#TYJG/bV#/U6@V18->
Tc.Q:P(H&/^N942\e8@>L6[2ZgOeg57H)HbDP]A^(A5DO4ZBE,dBWb&,]cKF=4e#
,Vd3MZ9dV+)R4)Y<BV2RKTI-gJaJNDb-.YK6c5<>(?JFH1gD(S;J[_B0(\_WVIZ;
_THA3Y<Lb)28,)F=0<))/H@E,1UKJ08KFa5[IT44SDARI6IRZMVLSXAB-00BJ1V;
JHY1X,]7<ccQ-(V.\aB?A=N[a@[5]BEQNKNOKf6,F#49I9]Qa>.^?Df=A]A=<IR_
I2/2[LUSP-Ad[GTUGI@Yc9^R[-BfU=U=;fD#P/->dK[AOW&285-0LA6Hd0\.S8;W
I,MJ#.GM1S;C+/=#BZ7YM\9NAYCXb<:,cb3fY[-3(c>]XL8+[f=K3b9)gP9P3LLS
&;PYX+5Cf3H3PD5CB<=2Pd#)[,ATDaL(Sb;T.6=WWM)Y1O#5PZ[LNQ4/WT1\#,b-
eTbAc=&c/QfDNQUW7#A10d;f>\NZ3\]d_c\GNaS8D>3G/a<ObV>McRdY=G\RJLXX
).b_/_HJeC+.;9(AHKW(-7K+c9/ENU_Q=dOTUFXIg,8?U,TRc&UFI(5X)d=@=M60
NaI_ISK)\E?Y[?.Mc9g@L#Oe-N^(fTE95Y?M7Oac@G]XaHFTU/a3WP7ATS6_0NHY
:gS[23T29=LM)<6;O,U7[K5cW>f>2eDf.&(BD_(ff@(MK9#C43(,,gO.eAVg6fM:
b1b#W.]<=.Vf5D91IaARNe&OC>Q>==.VZD2^1-9]XD2b0LRY+ZE<;.EMW8Ve+8/N
M[K08]PR35EaL^>XH)[[P[V(]==1DB&<&OcH^^E:d8BHaCKOYR:acRCgRLSG>^0@
7G=UA6:AYea,<)dW2E9B(+\SE?BM;M,^4V@6TH#\RMIQWf[+bELF]201FBQI3<3H
9A?-2>@.NY>U&N&E(Z\G9KQ=A=_J7\>5Z,EI4BU,>:=.&/4a95[0K1ZU(8H?Z:L>
QJ,EU3T)c?(dGD[)Q^<I19D\:a4VGMGR(ENX[4#MCdO7PZ3832O=7A(PWN^7YGV>
\;)3QF<60fO9&Zb,(S0=eT(g71=.IcFGfTYSU;,8cPf9dW738;1;)^B5RAYD0bM-
4C2_\ZFJRa3R_MO]A(U)N[9=V_#V99WW6E\C@<ONSE?_7fH-EQ^eYdFb(5WR;b6<
_CQ9O<ec-<g=)2,<BbZ4?(X/]f=^?@S/L#JK+\XB;A6\3]_IHW<eNQPE1[^23SbA
<<Wd4WS?VC._G05(80I.+T#=&d\DR>NY\J[T5JW+4YRE9f81D/7ddA(,GQ#LR,Q4
JT>&70+ZMF]HEA89#WMRT-A<\\fG:IB@36[3Q/-f5M:+NCfD/:Od+L8IX<#cK1[:
(A&4F(OOaBR3eDdIB;:8@UIZ,)Y.B;#KU:ZHMV3^1X#O((-_()@J6.5RBGe:C.gA
0X&f2bHVe+XZAg:d/J+8CU=^FeYe3a?LSXAM[<\B=QY-?fTbD5+)^=C_MY0\MP[[
\dfJ#61.[(5>4(/D=CBI)Fa<Z_cG(#SK75_2K[P]5Z=>+25ES@=J[B9^8)TdT-d4
P>FA#WX(B<gc+F8&TUK4FU998ABNZ73TH2>-:C8SWM_^,=:M/PUI4FW9c\V0<=Y-
(74EQ0QOKDQPe7.9K=eR?VW,+8.6Q:aV+49KE?4I2[8^489]b5I2E)^5.Qb6PJ5X
G(TA^;fJVBE#gMgCLJeXebS8R.a8AVF>3Q(d-TSA/.&=C0+fHQY9QP(LSG<&<EHH
^/.>G=D#LR:Se5(N9X.UD.8f]D_GeR01[Z>U^QdWA75J-Q?^W.#KT&a^5+4I&Pc=
;JT)]KDEc.FcefB/RNMIU5ZAf4,=34+WO4PTJP?AV0MB4Ha#U8TdR<@Q28_2a;-8
._;-bJP+QCAA/fC..@S^8N;9F?P5UAHR9bMFXJ(S>K5aZeE#gdU1P-C44eg[e?VB
QHZMG9:YcG0BVWK7#NfS^5R)aeN;1ENZ)gV-+>]5L1d1<<1F_bbZ=3,7M1?0I#WX
I414PFb1_H11Q(c0[G>JGTYDRTR>&)IR>QAT(-XOLb29)^#;f=W)LCO@XU\a(+-1
Jg[:K).G-FB3#9DX-BF#eM(#bHDTKIXH_EL.I3X+OS^XLY[4XK^?,VAZ9@9[Z>Y4
:X:21)TGH8&S9TZVP,:8U=QK.#dTS&IX.K>0MF>8g_0ScG9_&Y).+BQ(bW=]/FMO
BHd_<4(:7C/cU3WPU-TP+P:NfO&^Q8TP=5/7SY]0T]GMGUU6=:CVE:KK;B);?R^G
^375^+g7a#.3&^aU#Ef/4E(Z->]O@ae5]K/M7\2e1G]NY\LaEO(8H+=N\UACO;Z.
a)6fQ7>8XU3UKM_3N+5XYb0?[1>C]Id<1?@\R05;1-bZBW9#O,;Kc+]bL:9N?VYW
4Pe._d2MNU(^bg3O;_GO&\:GIPBZ<6CXU93JXT/AC?f^9H#LP[F2C3(/N93K28f)
V0Xc-Y#f>FeBSOXAI+aZINA&HF6>cB[9R+S:92=<VNb<G2#?-XV(Vd3OPN1A8C.C
4[>J9I@01]f<]=_Ud6@FQKKR/1S#>H+X+\)_;NU&S&I1(3VYCYLC#eRWV6/+Eg6\
_gJAbZ)_]V5)/QM=F=FZbQDG0g-4L&:_)f(.ZS9_IQHUN0-W_T8ccQ[(UIS:9@[3
NM/D7e@PZ6eD8ZTPa)WLB3Y:IS.R>7<(+NWLcTXLe8BLB^&3^?^b+8Y(LA^D#AQE
<FRfd5/5EFZ50_-5C](XR@QLdI3Q?gQTa>JH>I3L>4AY#Wa5NG/UX=Y;]cR6#/B6
Q/WX>4g]gA(2;&0B7H,^32N5DD4WgJHBQ_.bRG_,eS3JOc,;]K#4gUTN2T8<]_F4
U2c(3?[?9-X15g;G/6=[Id^B[3?315(@_];)>NTB0V5\VMU1_K)b#Y.@7f5/M)\2
_X>H@8ETP_2cZ_OOK8,;[VX249QI4UL;GZbEG/eCURaY5XdCbF8WfK\=V5C+cE#Y
R:<Cc_8-)+d40RC:.:3Cd#-Gc#18Ya3NZ7.=4FW;KM<_@KL@Kg#^>BP7^^XT<=:N
.O3AQ(Ld)R?17,DZ#0U9]H:CQZ[@;+8N0J#PE79PH+]6e6]#:d>\@+8K0V/WT5]A
ZZ?/Z@gFZK:f,I[;F]0.(LY#/(],NaJX?4^B>FPKbAYNgDOdG23#UMd;S<6;A++K
U67M@STQ(L\_P,>#OT1=H^._KY0B=7->VK0.]?a71Y=6YI/HSg3(f9W92O#3ORX:
YO4-&^1g8I>M=b?Mb&2(UeJe+&g>MU7bg_KSC&J@9be:9b\09JZM\GJ_W;4H1JFg
GHdVf]0&N1]6=+aXGEMPcbbIeN+PK#dWEbA9@?FW?e#/PRK5<NPCE<+g8b^8_FIA
UX]:F]HTV_EPKP)UXP?/Be@9Ca/UQN5beGYSE+6;C88VVeZ>Ua5Q2X>G9AP\F[3[
]/\KcO^dIE5EK/7XJV=DK_XN?/&#[ZZF64gd:90H>dJ\^UdQTHDC/MH_A)CZY4.T
1JY@BI36?d)f_QI<&70,44Ja#I40Ca3X&GA/e&,^#I5ICJ.>I<Z18JXa.)3DZ\W7
)(#K)fGH_EC4bgeJM7SF(e4RP=aH9C5M#OFKMTBP.HUC&9FJg&JfON_^:0_^0Y4&
M_4:(CW=M_d9SE&KZ6cK&gIW&LS+@+eg,M=8(Dd^fJdf2(RdD86HWZgT<F,Pf3/_
YYc(3&&/JLH7CM)\P[_(6?/1]PPaA@OPR^=TV+_?<SJK>,[0E-6Q9BNB2Y8).)D/
8\(bM.#\HaU/O8Kg[,/A/_OT0Z2gW,/BK+,S0R)@b(K0V<fdf>QV_e-#(I[LSN^>
dJH)TE[?73W[@01Ub&BO3(1C1Y_]<UYdX9KJ0:7>Ed_6,KB.:20L,6HKRD72_J<d
c12H],e:&PR69VW05646&:8IMFN]_O8=BM(ROd_G-a746LYN&OP4TSLF\/4:J8a,
(L0@Lg[>5V+b2YX-E0J)_98QTJVTgK)K23KB+RNM?.>(LX0E#/d<-A]b.Z7XZ,2N
+1>_1,8[5[PKZODZ+=9W7>YL@]Dg<86I:c+<BLHJ<F59E((g\Ug/F>0(gJaQ2QD.
KbB60]^CKM:fG=.NS/+CK<;/Q5eW-;FDKc&0TMd6+C[OUO<JFR>NU(11X@UE9]=b
.-/1LH##;YbNT_,[MR9@-N?+8.C/=:bFe,Q)&HK.Pc()I7]Ac8[,AN5?g)Z+Ka41
K(+LM]OY:X]65(9-9e\Q6#(cdB]2DC666BV8ZB\F,&0fe+T_=8-d-FJ]?@A-^DH<
Q0[1/[Tdb;PR45G+We9)NMfM0382I&OM]<EE2#](^/RN;[G[Q)#VD.CZcX0d?OJF
9W7#.X1c(7-H8fWbPBg&V2eZ,e3PQO+.Uge=&FOMQY<9-ga]7XSV_JM3.KMTF78K
9U@;IN\1.N<0OQ7:WHY7dF#S9N:/ZGBaEK;LWCd,&.BMYKL63A.dWeO9d4eQ?D]O
MYGdL#X?++59A_A>NN#,DQ?VB76\8[E_FDI,8)AOU)cYAgbO\UO3]4.T8&4:57=b
EK4I_7#aT77T?937^a[GJ\>beUA3MHcOAcLB188aOR<(Y<M>MfdMV8BWJ1)4X?7+
M)IK/C49bO8e9b5F=3-8.@a3#U(YB\FKXC0W;/@a+X2E<f<6&.GcI?MQA>3#\EKR
Z-XaO]]Z)EW5.[G3,8;<^J=F]-QEW\gL,DIFYZMXaBVV9b6(H10]P36<bWT&OH6e
CVW,b#&X^bRB7HJLDgc54;e=(5U:bc[8(&L/=B:TWQ1-McE8\3O6Y0-N>8E3S3MG
R.&<#8R1HEd;XFa)7IfAee33c^U4DC(+FCH4O-Z=&b2[YSEG3<(;_J?64)<f>\YE
5[#]XDbd?P0TV4AOACL^FI2Y=1)\,3d-@.R.+?be66ZE>2@<<eeg?1\.Q;Zf^(D.
Y?eZ@N6CNE1V[cO=&^0Q^JfO)Q2C.gJRDXVEGA#Jg(M2:UfH+P+3(MGA1B;Q3(\e
_4:@=U4\caY8b^fbYHQAV>F-:(?4#?ITF&cBfG.?Ha0/BA:C:6IUc[X6U@g&09I:
.R8Ve@.&E7[9#>=?(6L[#=00\5SU0Q@cA?MS)3Z]#39P3XG2Y65^4/?A0Y,:V0,,
ZNHR+/)^0AXE7+GBYWE?:=fE+/cF56dU@PJ#N;b]8(Of,<CXYYbXDWW/PY5DIbMN
#C_-/ULTIR8bXFRYM-\>Tb6QCf+E)HW]T8f#W;SCULRbX6=YV](YG&IIL399I0G;
gW&;76G2adRdR1@dDU]81OPNIJ8PeK:0MALgKX/KOGH0-S98/A8U;2b4?acMYMLe
01N(L@HELK0<@:-afWO3G,@eQSOE4YE_9^#6G_3QE-N2PEGK8;KD0/7-S874+f0&
KV@>?B3N;3Xb0&X3-AH^AC:gD4.OZ1)28OW2C?@Q@47=fTS^UDQVM[P8^G;(2JPI
#ZDGYfBJ6K/ID5?a>J+UAJeI\c)Xc]8_Vg-C,++S(W[M@=2-SO)?WS:]0]9):4O+
>:&,N4,^R>@g@+e6^YTAWYE+:Q^[[efPT.gf[?=Aa/&19ZNdR=b=,9U?^(1_SC4f
=56fA]J8T>XDTQUV[,Q24eH=ZD6NXFLS1@ICP3HKOK#O2N@b^4C3(cON-V<aHQ/Q
.8MZAZCH7BTT=JC#[b(L[TD9H)9Gc\XVX=M,]-(3<#bbSBW0O8U@@71PdE-bHL-e
7GHW#fGM#T?VNE6;T?+2TA<<A#GUN9&?GE3=R^TZ:4_U?[KO4K20[;V4:d(R=?C^
Y:?f>BHDQ)/f>B;U@IR=1Z;Z7#7cP(<58L,4dB9P?38eIA,2_#A3QAT?G^U>\_,8
Y[UC7]e9\;ILK6L1U1A_+V0fN&TAC-^SA,_L,>-6_F.d7<V&HF?#X52,2fJe]R8.
9c,fTNI5Z-54]Y#[JT+gUE\9-f\(d9;RR5;HNgTO[4fUMRf=<]3^@9_@N4GaP(9\
-5OJFBT.:(K][[[31e@7-/adI?,Qa;#;6PbVL^K_MNZ>AC#&:>&+&#Yf.BO&TJW]
g[I)2Bg9.@+R4D^OU<PBXBXHFeY>/A(1ZY?T&bJ,X>88HI2[039WJ^^>;B^ba@ZC
N_7L](ULMJ.9gdJJ)Yf94LQ7M]_I]-DR<ZAB.bQIH5)&D<FBUJ=M..3(2:0^KG=H
9NS>#dVc/g9.JF>@a+bb8bGATNDXWU5P-]>Jg;L>5R=4ORJFBQF\O_]fRM^3K4U-
4K7;0<TF^XNe/TJ<VaQJ1e=DVR+\=e6E=E823=D=a;Kf63bYJ0?]=I;I.6O=#@<2
:7<&)RN.dTOO,[]PM4H,#+[4g/8^X5<H6d<O=32Z2M[#:SMfIG2,^;DIQSe70=2>
CUZ4d4T:YCQQ]aP3L<M@[]=Q_\d-SUM>S>)1T:OJ)+U8XU7+DUeY&<NWf4GZ@98f
:\WY7JY.<Yc13E7b#NR/KUF/7KeMN90Q5SM5e#c+V>GHBJ]LC9<J0Q8/.RQPdG\;
/_fO=+EfbU\(&+RUVc\4]Y/S4>^D<CR/FNaE;_995N[5L_X3Q.PGIN9BRW;^9Pa4
+TF]B_@G8Y<g+DIM#]WF0SV_]?ZP5K+O;C;8X/:OQ#;:@WdB;fHQF;gg6U=TFF&5
\BZZQ#LG)&gU[>UD4:G7g[T:VE)T#bb:]TG(XbGF37bI9M<K&\J<(f;3)E;dg4A7
V/4OYI14d9S))DLZ]>4?/d99,0Ga(cW62=W1U=Y+EQec^26)I[NZ0W<ZJQP\9XRJ
+-Y:-QL5U-E2F#==XMWc@,g86e408JcHaUJ4OQLO=:5(fAGWM8c7P_<?=MP>P0Z2
DPe1.6-gD(YV.YOG]S@3+c,P8K>IV>CYF&T7JVG[gTafM9//2ZR[<9_\cI<YF-6U
^;b+d^UHI9)BTX?;U^(Q,MF)cfE8I/BS4KcAOR1a:#TfY:[3<#d7D@84:Q(Oa4S6
>-gJL8Q1dC4+U620PF]1?E=QZ\-\EBK\##E/c6.bO79cJ>413?PLMSV:_0)&C^^N
:EV6+9X0MSa2<e@cE]..-B9IIM8dL<2(QPSNQ:.I[(gD5ASb0:^0T[-SaVOe92cJ
V-01=>?+1JIfUVRT@ZF_&48-H2U=)CQVIO)CJ9d+7>Q_E@IN7@ETS1Ad9R4W,D./
(@dY0]^DTY(X>Q&B91SQ/+\5E2eMEM\P=S;.&^R/>W](P(DOZ=)2IFHL[INLHD,&
YC6LG.C?9ML4K\-M22@RaC4195g,dWQbZ9;;E]RMO?e<)B5TeRKX=0&LeDdZIC\a
.W=L?6Ic,QBNa<bTQEdC[/NC^A#39126?#aD\CE_-@I>/JI(/\RAY2BZfJHTDc<[
68I22133C.KO4+GB=KUA+)Q(QD3B@Pa:LPg^/7.&?+g_&RXa(:Z5eIYOG-Aa;,D>
TP)cEY//]ag<6cgg=T)O@+&I0:M[c9a+^d?FbZ]ZK[X:O^X0A9P0ac8>38G[YULW
0BP:#UY34eTeQ2-Mb789O:<Cg>_3V1TH1I@L]9aM/GGC[?M^O9)g]A@7PT84\7HT
9]0.?N;4&&V&-P<4QAKZTH/70e9CMcKd]-UI/[6#=RJD\5_ZcG7cNZ]a42-0&,T7
K2TJ/1TO,e9e,4T/cb_+3>8\a2<OKd>3C)7H2[>#-?c[8LJ:MG:ZWPUK>cO)Z>5U
4/Q0Q+KD^#?6+NI_C_6.e0g3W]F45M)2I\(Sb:M-5.N8W>ZcQFEc?f=Y)BW8FTcJ
RQ>EU2\QeY0PWaUEVZXYaf(bZJB.#5/#DdF7c#\?PJ5UF?<)_&=&0B+WT/?Q4F(g
9#?edS^K\-Q_:B?3.D//(BG8:F9V?@b8:;9MEQ.#L2_:P0U@4UBR1ZHde>=,N\K&
aUR]+LDKL#0gO3W&L^TYG;<B4V?6fL_Jg8^H-[K--/E.+:UL(=FFQ/([FbAV01<-
W7/FNNd;(5d3HNKTAcAZf_M[>65CcaBG&/2-,#)A5@?8eGO9BKde_GN#/A15I<d)
#Y^8BF_e]K2BQP5U0fGb=c(P[^ID:3FRc/O\f2+-A:DV[O,M<)MVQ/YT=]8\9_IY
E.=@,^f\VQKe+KbQPJWRGYF]>P8Q?7&VISS=g).&&S^>F4TQ5#5f/PAS4.CPc;1W
KNKfRc<c,O5X&acWY.XI&8WTL0b[J1HBc(9-?Q)8dWBYH3(CFY:;^LRdCW/USaIe
\Ia7#a6O3LVK#CH]N<CDG+JCFa1eN]^G8V):OE3J^VZ]T_QGc0WD[-cg35[B@<X;
J+V4R#GMP_<b^0[f[Q=77feOH94/e).D5+g]?H&eTU+3JV7]8\WXVU,e>7RF9/G#
V_BJATT0D>7MW+>6g.+JRDQI4^eNU,-)2Q+5E2D9B#5Wc&>O6?Q\A^2QDEFX6]9_
G1eW4=GcbS&-SbW49SN,5<LA:g9.e[E;C[6P::DScTNfFA4S3fc8@,gbLZ2PH&OS
<g@b22VZPH+CC[74\X,T[6FT#D#/KgY1#G[PWcP3cXS93>/.d\A#P#M>KS3BC-4/
5bHK+<,@#WfR37X[A9-WIT&bZE35#)P(aO,&2<f1a3VA=D6^.6^;@Y2cCHM59?WP
#bPf6IGNL,DNMS1+TS(3M@gO<YK:ZCgTBA-aOFMO]DLW230-KX@\P4;BW>=\I51P
;M<A^dCQB_XKed_M)Z&eY2)B-\AMTQ.=Jb<;2-(99]8Kb;9GO97<?Q(.#&/8IY#9
CU6HU3TC]V@N8(T3DF3N-[7ZF6IJQ82:[YEA1>8[:UGHY<-Uc:?&A)^L<;Ee2@X+
OO2QJZ00NP_YaXQc91(eL,F,)L[0cM?WcgcH(UP5F28YV)44GNY99.,CDU3ZA1\4
f&,R7]f1_[-UcD-)U.2gYdWHQ6&XXB9TWe@HLNYbV.@J?3DQ,EODG1=UL6U1^W;#
,_aZL(/Q]bV/G@>/AUV,0MU^G;KMG3>d^1R3,G_-NFQA/bHcQ:C6>B)FC,U:)#05
06V0BQ4PLI?>:PM6Sb)ZPXKb0F\@OC250_\F]LR=-[Z9MTEH/:]V-]+.W:(_b.f>
.[PCV,A<P@)7fX/-e(AREcgRXbQNW=J9+2<C-;?dHR-]4;P3VO#G.,T&X2KHO@J+
]fcIR\1dXY,G9YA8^QDIabcCOb0Xc#J](2LE0@b9AV2JR)(cXXNWSXQfN;2RT#JZ
1P(>gLANY0:7FZKM[0&L6aULH6/[YP3A:GbcGX48M<5aVc:05Y>YA#5PCH]O-S@K
CT?W4X6-5F2]fS3L)+6eBZQ6]T;RDIOZAbFaFSg\H&CQ@<HD#728Z-=gB]:aUH26
ePMAAGV1;d5QF6_<O.:?.^LEaPHBEKV]/]cF@(E7\;8@>@G#,_N8221b1Y;1a18P
P,^YBO;O2bZ\U0/2LU]V^Nc&;]Ub/M9XN<f@I5S.OH;@<D=IO-.e>&2JP<@\fc/1
c<D].-X?=_&BZaVIa7Hb@MON42dB@A^<_ED@(U0PEP/Hd.<,U,]P8V;8cE;]I^6+
f^W7CPKW7D;HfLcQ[U+<T-2T>#.P43H6P?PJG?N9;]8^7]VaQd3KU]Tef8)GO=H4
[NCJKS#J-9VA-TEV4gf,REVO(FF.2PFZd8[_cN:b[>BcC78=)f^Nc1R+JD[IA=6<
S7aKKf<,JFD6RV5DO?CZe?Rg+SQR[X[b\UJ#<BABUT.VbTV[GFa_-I0W8?bKA35.
AdSHe/H>,G83]64f/:&e^[N9Z_fBDa<>>PVf=WXESJWKee^G2Q5^S-cZ_W;Y3#/^
:K.][_-K9O2,I:2fPfI>DKUC0]OK)YUR/E&7+Z79a7=d/B/=]FQ+;2KLL7G54SVW
Q+&4VR1G<,I[?-A,\c\NO:Icg,ATBQH\#?a?A<ORK_3Z:\_VZ+RW6+cNfHJD,&2^
/I6X_SROC4<I4]g]^PA+2XX897.7LLWDI),M7<EWV&gX.VQ,TD?&b4O<aTK<0Cc@
JdP53g(S)T\c(e1\<].RTLeKY\dRU-f&CU.Y.EaI3Za47.HA:e/_6/aT<UHD-/eH
5a7bG3+?1Cc?NV+4c#SA=+IGfV75Fd/=I+bWHVd8](M,A9ZH,/(,A/a;VHGBBSR-
Wd.7LD+e6X#B>g@E[ST^I/QSK[HV4S;;-U^]f:EcBF+BWfV2CZ-ZV/F7Vg5,B=.Z
[eR#^\Oeb^I/.A(BETXDSf+QWKO?/Te@@_(PM6?VO]@<eSO(N(-S.0;:7?MaOE@3
Nb5Z(?LXZQ84gJ6?2R3K]O/+QI1)Q[f<:_/f\&bW_)<bOIZS7bAa,JA316+G]?0K
U_H/5,RPAPZL>^NXD#BGK:>35,YAe@&9+Q0/OcX#cg(M;=_[UD656MSMZ/b6CdcJ
Ic7-F+d3].YD7bT;[9e65DOB6E5-N51ZaA)3^]<@QD&2^XHHG-B]>A&_E0+6g#)2
B^J8f(O>,5I/b1T-OddBWgZK0;M>f/&I6:U42CF-GHIFZ-\KQF6L(.265B40VO?<
1eacU@@QdE_A\H6TX?T>S\aX@KL:[d89=RM#c@f4dF2AOe(&A#@Dd&ECFY+dO=,b
2=F,Kf,BB/8010Y3\_,-NPM\SBBUU1UZ_@TH,UcHR.=3.d_@#51?>g)638C71S#=
,5Z&\73U)9?A7?5T8[N)JZ>#gK:/)L<8_6bUN-a?MBYIU]>>\gd\ffL)6/C?^COD
ZgX00Bc+#AH(D+O2/N2T&Z_3\.g:R[?f39C3NAV&_?d@0\HPJ((M;BFS)/M=<.6U
640/Q-(eZR=f.Ug>+.9SNWHW?XObIMPV)C4MbA8Z9QfMa-VAaVVO6@c+W62aRB<U
aK5#6W;[^^B(@0C@@[OF3[VP<+=c2Tc(RFF:R93Nd([KR^W)UDULI?0MJ8IeR,8]
^ON.fHe+eN+KK_MWBe2C-3B0?&<HT@JZe<GIR]fGW46+aDD.FaWO&@7A-2J(\6<5
gA<YQP@+fR\cG>9^CNg0DG=1BRCg?CV;&YH0)+\4[[(H\8Ca17&GI&G?83Rd>;[J
_Q-<F;#g#M0=XU3/Q@^FN&<XG)fZ,)XDcbK#9[V,g770e(A(WY/X3@)[R-EDe4cg
O^.LH@<9@:RK0(MYB3(O&Y>1fH/dd8XK]4+)(YKAA5UKK;BY;HA.[Je^L0+]HI6;
R?E2.Ub>(1K@GYODW\L;3dO.V.U.]1\1@d@TN973ZM]^@T&5VBJ\a3]F86K<,@)E
^ESc_CNO(MUX_L2X-I+WXWDa&ZU>bDeQ^H:V.,=3A#E7]J#2^ZKJMc-dY-/9#<P5
Z\gb3MOVPg^&.S[DgKM;J2IW_]C6KK(g9=NJO5[S=W@:eK7R7^Ib;Zb2JU_9d6XX
9D=<:F]8g7HI-B[=d&bBZcU:7b#ZWZ;CT1L6U:A^?=1]^_)bb._R;G@Mg<PU<W[1
535Qb)K3T(XFVZB#FX5a=b<8881VJFN5A1I-#?:#(-WJNROB]]O^2;gcf](4aC.L
?,PJSQ,>IF9EI&AMKGPLMAHE[DA,.<6HGd3XGK9FePNOYU;^213^+-cQbZU=F@\4
_0C3L8-fJZYQFcU9JDVO3.QUA5gMOK[\d9^9IKNAf6Y8].<AJJbIG=0+CKS?^BC1
56de]HHU1Y]7JD8>3T#NY,DH+Q^fY1+UDWW#PU_]5CP(.8C<O[E))WX8#/7+2FO@
Jf]_IGWY]&]cC#;?XJHTF/TG0G#UECYS<N_ZY7dM_3?#g6&X1LcddgY]7XCZfL-?
E@I1eCEODaA:ELPLJ7W6?:\5NV\GdbdIdW2C+3&E7Xa1575<V)9QBK<VVQMRF)/H
b_R)T.XJSTg:6<SOBZB8S63T;gS6YBQZg_)F=AFGZRM:aG<eaE0&[3XMXdX0Q=2c
4I;_.R?7S5+9@)0,\_(4@#cF>X[dSWA8EO;.gBTFB>J>1fP]3+AIUWFG1DII6.B[
N^Z5cPTN86[?CGJ=:I90F<2gB@_\ISc4Fe2W_O@2(\VFRE6-#fB9_DO-Q#ZK8OSb
F].bKV=YL^.8+DRE5)<AQ1>M83EJ6O>X-#7JS>4+3&IUc0cF:7/_eFaQ@2d509+#
^(_=XUR3<H1LMWdRDK\@+AH\^]28QQ2(Q&A[I?YgZOL).H+&b7NC7d0Q?EI26EA]
(5#]58-+cN5f?fRNgK=0PT<50dd//TDgQWK^,e7c2aLcd.FX>S][U&:WgY1RS?^X
Ia&RXH3KHKM<2]EF0eb3:8J-54OcdPbQ.O/(7T<9X<42DfNYV0QI)&=OR?cKRRbQ
C[S_KB\+[87<GD=_2F&6LBSMWC<W/O\ZBgYBY#B[Yd3^(<^GO+JMYA9CGY\e6L/M
#IRb74H3FAg]+A#5\gP,<8?=M:RWLX)VZWG2^>(LM<A,YfCcE[)Q.&;19@QQ2KDZ
57AJ-2X^bZ=SFGY;H@ZMM:O0-3I2O;7D57d^]P1+T_-8NJ@537?Z:N?&>Dc;B2L5
HP2e2\_)\^P1[GPSf\09_fTP1AL:F]?&G(]^8cWSeRA:/BY>3.Z\/6GfFQPX30BW
7a7fa.OW.9HDV&@IJ(WR[UC1d7@;a6)efES[c))XU0gG#:/;LJ@>-BD1Neb\KbPW
2LU+)/3T;/B-:;NWC1;H-Z54ZKeX3:Q2[[>7>ANcZ7I)M,>YYdPX-M..fgU<Z#V:
:>W2Vf499C>Sc^DO@-gFaIDC?7J4>#d=eb_K5-@,PaZ:B?ddI;4DgQ)1N]K?cWW)
-]0V;+O[:H^>9DA8_\]YNLV2C:4YR_FcT-26SQ\B3._PS_5;ML.Tf[c\L<Y#ROUX
Kc90[(1-C&,;#T>(R3HWCOXc[V.Q1gIOE>C0B93dK.TT2gYdN,1OXD2E5K_G_S.W
d1aaGA8+@b:LMg<ZBS_9;GC[AOZ_HV,([&W\;QTU7#)9:_f0M6?PR@8H)[KGf.VA
Vcg(DHQ>^11b?DSgb>0]7F]82C,_E0aA).8FLS9\[2ecEY3^;R?dHPCPB\\^U:0V
]V3PQ5CBM@H+?H8[O/]Y9G:]PK[T)NdYW-.__V=g4WLJE)Wd\^>Pc[\YH-7WEaKG
09Nb7gE0WFR-LD@)FN22C5-LePeL2#B,O=I?>@g7g2K,=[)>cD^7^9S#4UcOd\S>
#7][f25cG.8D/2/bZQ6NO^]W0g^0]V0]XTF6;e#H[==Aa>-2La+BaGfd9>b/Pf@,
1=#cN(g[]fAAa3A)66B?KLg1e&IbEO_Z/OGC.1a@..,M[;F7G8;=Y(-,ULV&_/7O
=>+GU5>9=e)g/(//31Xg7R_/1KfSNYW#gWNLYBU28>A:L^8NNWg-VF_K@24PZH^N
]Q.ZN[V@]/MZ]2c>2VcAJ(WPRU:=_7dR80@A;CeHNPHcUY?2_=+&A-,)6(O+S-Gc
ZE5;TZYJ<@F;.FKB9)WI<AdSE)F+.VCD#OIBV>:=ZgI]NH7,PL+<f;A,;_1/M7WS
Vf[ESZ@6b]7_QT473B@/TIN]41;4bcV+da.c5gO5K<965Y[Q-Z_=JCTL&RU+#dc_
WJ=3.9g4(O(9C.J4S>eT(5Fdc\L_6-?fGeLULAEQ[+B\?_\:2=TB=b/bZC2Xc<=)
W<Z?d3N9+)4VS_BI<c97G7<MD)fY[IXUE3IeAe6JX\-eM_?(XdQI>(YUR8Y]eYIG
P->,&:[JMNP)?OVOB?NK/&RX+)96EV1&T>B>dOSd5TYT5?KWY,b[\=a>,G1Ff27Q
4.B6=YA/K1C@:E22aJ8,1;0CXS0J_EE),Y>2fcgW_LD7(E79g]YS6721+PTN-HR=
5Ve2>VXb,Z[,BZOFcN,Lf1QS;2598WZZX5BK6U(dO&;gAMd\4B;-QJ/e-TGV:]E<
;4d=10_Me1RULP[BKJ;]06ga(=)JQ-8R0[URf9IBCC)[ZQfY-B7<GAKC4)<UI2YY
2YabQ/ffDFFE6aY,<O4QR</Qf&8MP\MR;5-9-g4=G84+\D-Z\AO/K^<d1CU661M:
F0\R3^L6P1B-)@AB>:?3GB665=-#Y+=UKX1fVE>dQDGZT\/:<JNPddX]]FB80[V^
6f:UcV5-9<S:,UI&2.fPI(.g11EIFd-A<0Cg/G8>6e@UUKObfQd/@cUYe8Iegg(X
^V/PCBUe;f[[K5OZ/:6a/3&R#84O97,_V8TNcE?=:J0^[7MFECVbf-YdYM[QHPfX
7M1gK@KPCIH)b6_)>2;0@,TA)RN(5RG]/ARB&VBB,8GC2IIGJP<K]YPfH<A6WJV<
J3X2RDL\O]O9^8b2aVD@=-Y7D4IT2bNU-&XCC4:?Kb>f.cK3(?@(N,Q87)58,X44
Q(eB6&#5+3a=;A#&69321:Z\eQY(_\P\\dZZSG1-\PGVP.[,_2\./..QOULNad#e
26V865&9Ye^V4WR>=>(QZS?B2CgfHN=0_C7d#T^:X>cUK\GY-?W3LPdCTN]@=D&d
](N#b>5SII:&0[3\Q0]Q3D4[eM4K<7=?1;@^+Dc65KB6-d;V(ge<6SRKJ^R:a4PF
NA:\>=,VCcK;Y4+TUGIeMeV?K\]ePf8XBa805f4;CP7V4Aa;@0B@[95:CUHHA/^E
0LaM3?1^2A[@bHdA?EBeANPJ,9EQcVBIbP+N[6b+FOb-C:cY.c9B4c5dTZ1X01Q^
NPXZIB8\:A(Xc05FRbA_M59._+_+;^8aCAE\0K:B9U62RNcR@KC?;KF63c971,Y/
JKN&AC5dX-M4Jc>CaNTE44TY.GSI^HFNUTdYc/f[;2WS0>7P6/6LP?Z@G45A:O]N
EF_]LRD2g08\UG@c8,cZF4\cW0)]a+=<:-./X,V_.71Y]ScdK9T/WIQ_=WW)IHf)
LG9A7;MZUZe,[LYcc/c5)bb(&P[c>,1^;EX_bf+U:#^0a6ISaFOO@+IZ?&1SBII\
RE+L]^8&?O)27GURCPfa,U>WE,L4T-V[-&4Ge<d.@U#ffVN#B4aPINEWV]];^]bH
4PU0CdEB]CUC(Z:f6[a-7,P9NXa>;G42,N^NHQ@RU3+gBffaDNW+TO??e&M?)4)S
),_f3-0XWc1ET-6KO\B5KKMO,G;7/UO#-:.e[Q5;fGX\9O1A](Y-c4[8ZM0O79^A
I6P51UNZ6@2F39@Q0M:-XDY.(HRKF&+5b]T+S6BW/Kf,ePWU\KIVdX_,;&7A)0X8
[)b54;1E\+61=a^Y]/ORNMX_+F;TI3O7QQXgH>T4MD4P/7:+?RH\&A>/,EcH/JOT
cJ&,+I&8NX<>(0YGK>He7Y,+OPW[N=O?;aI6dVMC4MbIJIB.Jc4[AK?9Bf&Q-aW]
U5+RLaH,#g#eJ,C-b6N?2=HaM1[[EEd63e7=/MG(Lfb3IPa<)XVbP&X_SG;0U+]Z
E?TS/:7-Xc#M#?X@3)],3\FDcbE(egS<9V<D/IcME6WgIJQ:d,6DEP/dD9_a4;]E
[+ID>_/NbCB2b13_M#+IXZD[S2\Q.R6_H2JSAE6=M>NAL]4_a_4CeUBb-H09?M=B
CdKN@W-#0.R)T>);85F0UaPJ5J-8(RZ_+IEg7^T]^#=NO?90&dE0+-3bJ[&EJ77Q
@8-LCUVf@-)fd55J>[)Dc<S/b=J;.cUaABBNYDJI9)\Wa9V)1UA6WILP=1#T8c/3
+C7NV<PLdT5I,&F&5NFM)<5[5AAD5G](^Y/a,OL#g\.@VaV4Z?A04^F@?OBa-#;I
Aa3c#Pe?gFa7PHSE;AWRH2c>A@4[D^c@)T)Mb1(RbM17S\\Y^<gKbZ+CGf=)3[]_
V@=VJ4Z\WG1LE^A8=D\@B8S#0@7Bd/;G0B9.=GLHXNUE_QfG3+1Y599F6@PKc#T@
<2@AU^FdJF=CWTZ&fBe-.fgR^aG&f(;GAMVMYZDO(Z@5gY-/?8Bc,8f-dXAcGV1(
@f?>eL\MKB5(<?R_2X)[1_1N8bY<WNF<:M8IHS)3_FR=:@g__P;Ng=\(@afC9<A,
C,C6VBPUZ32XbeL_7S)&Qe^MQ6E,90Y\If6Kgge^52&SUYO4NC&57)I,aIa&K+OD
)/-,J8Z39#a,X+0K__P<-V;eCWW9e9WEXM92Nf.-/D+F^87c1Ug.)f22MU&aQ-Ng
eV2O)ba9@7OC-F0UP2@Hd><+>QSgDH86W#_NHL:C1&;KQ.0N=1<5A>CIRXd8Y+c9
Ga^CP@S_CB1[Z,AI1V<M\2K8#P4P<>D8J\QAe]aMN)QRK/DEWW\>U>FYMC]FTg(O
f9AN=Q>VbFVN5,K1bF=WC=^UW]REV/MN,cbOS5>7d_8:+=N7=E2X0/Z3WAH]2GBe
YD=S&0ZRX/VQ-)?f,<XNJ]6NFaQec=BV70@E23+U;&<I_W=A3##A@F07.4T)8=#9
[7.HSZBX:;Kf5L76F8ZC(=HLLd.;O6V9b\N4b3ge\3aHNPdXZM_g?/\eI5P,5]+.
)QJ+-[8&\Rf4I6AXI=aJ4W&bY-JXHK0M91TB73-0.X?Z\6:LUa_)b]R7PLF;QMd1
Q=T_07[JJ.d&KH6OGcJJ2]LEX7f/?73#E=-Uf^60NJGW5I1<O0.&6@_KaWCgbR#0
\M;cTWNSN(5\CY+A6\R^D^E]g(67UX38GS803@X9cdIab1Z,HN:TDX07A31g?KL3
E#_cC#U)^BD[6S,OZ;].7^^]fKHI/DLH<>YN^VF=B<.P1c(N;C_KUNA79(D36E_R
@d.<ba(B[QcaCRf&2S_IO1@SW?<2T])W&2H/41e:;OYRf-BC5PCY-.?MLEDbL;Tg
&SK<B-5IZ05g)?R,cE/A3_9VYUNB[AJ>T2A9?YK+)6F^W<N2M[[Y3I1>3af5I)+;
DGH_5SF>bX^U8W+4H>53(Gd^bWH7A[7(aNBaI/fDXY?,I64\L(YSO]PY]_/BP]&9
MMCd#/=^&)]?7@(CbWY/5fY1eQ35-G(,EFg]?SD?(/N9G@d.L>Q@A/S<I<KDS>R.
WX@9Z0=fSY(BVQ):g:0:B>K;f+X?TB.4Q\7/XG3H-&MZERFN8)^R)<eQL06&]XK0
)Y8BII:dINP#f;LefMgUcQ@CeW@2Ra]+>MA#df+9T(@Q>NTN=<Od26NHJZU5^.&7
-8dLI#0E/0IWT&XWe>RM4PK^GWV5T.B0><Dc:CTPQAd[]M6C<6D8e+gGV?]PB_gO
[G\B)+=cHdICL\S5Q(4P?cbF2-e8-Id],AB7V<H0>.T[L2^);PTG4g?;)e/2^3Z8
X28fF5e00cX;3bF-)CH4;CXDI^GXB/0+H9Q]-K-(eISCe(LYb:9QVG;2Vb\f(X\Z
Yd7:WL\(A9,B+A=b-ObKCS<\#T)D;-QcR:3L(Tf#_GYU=]<<J5.<DL+>6TM[8OA#
\>f@^LNW&[Dca8[(\Z&VIZ)(3a1bV;_1d\0JcL==#,5XNHE5MO/-D]>&#QUaS#.T
>BC>-HZ)9JV@56Zc(_C^O+D^T?-24X7^OC[AMS:J)bP)8G9Y^ZJa35;)AeT23IA[
RA68baUTEdW#I2QG.0Ee18U>L/.Z\+4]&\P:PO5#SAU8:7D&,aN=2JA61&8dbL=/
OMWcbG4MRHN^6B4cReH<@0dEG9\\<+2EOa/#TT1+]FE[a,_GBT7H[AVbZ)7M8)1G
/OVOL:L9JG=H/5[a<0/35)MfS;<_g7OYaQJO52C4]6JD(KC,L_9ag0HF[Ig^_QT6
LeH^C[E,KEA8;,4K]LLY?B-6U@8W;,0KSLC/)RES-VF5X.0HI@IgFU]3&1&DO6UZ
3YU-7d]Z7;XQTFMVeB)[NFdE<,eC?LBW?bBX@/1>FMe)2cW.KS:6[Y>eS<c?SFYS
#3XLfB303CV@3.(<;f;VK5d:0>fCc^S_7B0V,EP+F?QTVCG;9<GG?+>6A[RUZR29
T_Z-TC33e21@_4Q+gYQfN3<VW(;g\G\Y5K]QX0E]U2g.f6cRf:5BW#<T:)c7ZL:4
A@g6:@IU+=E0=.)K\_d)IbYUWA]9aUcH0a8JG3e<NC8\\-c]WJ:@,KWR=RHH)KgL
-VY2LT[?0EWSZ@W)O:L>JGa]\+6@UVXV916(b.6T3W82^=N_TXL2M/T]<Zd;bcMS
bUICQ69MS?NV3FDKGZ#Q9gN)f#c#>6_UUCZgcbH18W23X9,D5(Va[(M1g.fOCIG\
7JfHa/aO=f:1JQ8)Z:@99#J4@<Te)M_\G7)TX11_QdWOF9&0(G.+Vc#B-G-UAU-F
9&9.I1[f@;YYG@Y)T#:fF_K7M>74.GYV9P1:@ZKcB.e/HTcLdLL=UN?:&O1e7O)2
G87/^XH.VH&>_]+g76I7/7QKFX+4=;e__T3bKVYP<T7;\-UT5W_3DV(N&Od/b]8Q
89/H++HGL<OKX;>ZQ[16+b^^^,OG]TMW,IWD/NKgVPe)W(1^7CQCaAea[QeG/9aA
,7>e0P,;]GP6#]TS/GS5RF]9fEWQ)&(+E9+OP>.:dT.LA3e71bP42QPT6gB8VQ/e
Rg5P2:7NQ<QGD4#;d?YK]M7;WbB45EUMa#//8efCW<<E+O?CR<>f@+Y>L[_Z6FM@
+GZcPH86da4aC59YD_M.X^GD\Y1g)N_Sd\(=D[::dHg,:2gge9F^HPe]]Z?bZN9a
@1f8N#MZLS&Y]58d4S(1C;N(#Rg=BZEZ)558LE,/Q(=M,&B[7A-/(#A;&fA/9;eI
d[_=#M>HEd^\A8;ZO&\X,(,V6-^[5eZB>-]20.fJ(5C]^C&)(0O94(CFP<dZFI[0
I3Kc?+:A0]MW=66.-4]9.?2-/^?-g<cT]+H_E_G_?X,^##39W(9=\/XD=5)e?^;d
Lb+8@6XDfBC>,C.7+[=#Z[?YH;LAR,K8cFF91&d3(;#Z8SZJG3dDaHYa\)M1O15)
]DGXBI<\.TK0QGWMX94(aaUH>K<3@4c]VNXd[1WS1C&G>K^J=86WS+N?U:8adfHS
Q/^L#4^c+-XDJ]a2d1G[ZcY_\HcafO1+c]7/Q)VN?__@&V^]8J53Af:YEIR&3a7:
gM^_)FX/(>@++1MDO([CDeR=MDfQK@D37aA0UDF[\e+;6B9X]A70S<67V];b,G>1
(<)R.DDIC;81TeG0K.XG#?c#0a2UgRN9TS/H](e5/5:fV(U..:QSTSa?@7N9;aY1
N]5@_6g74K&5NRBN3EC&T?//6&Ddc==]+d&Ed_P)[XST02--VX&]=P9a6MHAH:Y?
/0-7NVgaMBF1ETIAEPEC#a>:B5/7SS?JC9BR:^7WKIb6DT]E_7-HZ.F47\ITYGJd
_]D-?C>><AKP0?V+ZM)BcMPRYN]2>@(<,5SP80fYY1g,I,TK9#++YdDa?FOF\d#&
13H_,H+Se=4XN/?1<ePB9@&DgX5>6c+YIME_).HDFI+08^ST,YXS+?8VMeDe[6X+
F6NU.)HU&:(KU@TX31DVW-2IebM=N50QDV5N9@ML0L3W?@BfWaa;&F84RT#<C#WQ
HF<^/;L[)7VdTRH7+XfNdV.K9QfggRD;g,W,7aD#-Y_aS]fWW1QCTb[.TCBX(dQ(
@,KZ[#gMS7T2=D,J#Q;3\SAcLQO_Qb,_N1UbG1]gHfcc;b(W4^]#SO8G1X3\#D)a
R_&-^.aCAK6)W11&26]I)1b]EGX4=GHC+1]KS[4bWC[/g9VfRCed;7J4D\?Y=BN[
dZ(G:edX6Z<&E&:OR94#H0U_f4:NHVSNc<ZZ/)_@/X2S7Kd;D3Nce,/4#3T?GIFF
XV>f\S];dYECgOTV]0X,V,QbgE34:\e=T;QL@.918;AfVX&ZYE4BaOLUR&[HdC0Q
JZ>?@OS:N&/@?Z:+:ZCfg?ICZ;.^(OQAWZ@A)Tga(CYOHMMDM1O_(Y#42?&RWZ8T
d:ee=.L.4W(N1d?-5I1YX6IggF,5JP#&,X58Lc]Me8F(8PBTTU\7>OZLc/:Lb3gC
BS:<eQ,CHWY)VaA89XeD+.<4._N<<c-..6Y?OH([HRB/0g]^=).B,eFFXFZbfK,b
3P\;C)H/XNFS#R^LfdK]9(FGg,G(X-e[P.ZFANAUTY2^ge&462.-PI.LMOQDNM2N
AGHJ[b3_U[9Mb&[gUNX4g4fW]6-g(RY0O+?US=QHXGP/PB=AccW?^60Q:1I(4X.2
.3CP&SVI/0OPM?R^MMSWSX;K4.]VI?)_:)&R\KJ_D6RO[4dIFD-F]T#.9433fD8E
0Y6Oa5g[C#>Dac9cg(Qd@8gXEI]&7K9L2^fc.PdP4K-V@,(CEM_73IHaS^62O+7b
7FJ<KHfI;^BFbFD[MaD9MQVP2G,:)8^R8Ta1(M_W4EB<Rd^A25aK>JVaGXB?=5\]
4&b6#N/]E\2Rf+E)Bd[88U?\1DKEG:B0bbI[(K^7?a<D0ZQ9]X4R>4FU-dbSH.4^
:V9BY^,VaL2;SeW2^@@bUK-=4FV[a@a3:2+7)27XI@LY@,QS^4A@X5@IDBQZO/cb
]P0Og,@XWK+6g4,US/XD+:UUf3c8=gZ=W\3)]<7DJZ]PGSLL]MeGBF&4Qd6:W(/C
5QO#fKNdfFC1?5&93aZKc\SGZ=-)gbgFNJ70F?121EeAK;_BCfQS8RQeS\+C2Q/_
bMcdgKOZ\@Z,g<ZdUJ(35(<O:C4;)FE(([5(V^&L]g^Ud^/G<fINTf2dA@;92]93
>E1\KABOC8LR#QFd6T2IF^C(IYB)^MRG;aOOaAL,8[bHQWK;ZbBH[MDf)c:73e7/
7f98=dD;;/C15Y>DL/<?,XG/cC3SGDHe5,0eR[4dT6f\IAK_9\V:N.<18O7HNH=Q
5#-@_A1TT>f&Rd&I@gfE9)1V)CODaGPS(Nfg9NaTW?Ua\.V)@\K]Ya:W9GJd]4[V
HH:G8@J;KSeFaf5?:ZWKP-#2G,<CZD90:R)56/I4NCOaQH\R<SYNA#Jb7[614U@>
f1V>I<KUF&Kee2f3;ZU028KdFfN6R6cFY/[_;#7/8C[G/UP,W4Tg/Z@g^fca+(\+
?]b4Q4@U8.DO6>f#G@I-BU9)\^_Qa+gDM30\+FG[P3&4e2<U=H)P98Y0ZSK+(Od)
78K6?\VE2>/AJNA;.\;G-?_51g#Y-)<>Z/?U)fF@DDa6/^9(#E]K??acObY1Hc<f
<Jd7&PUef(eY=]HZf@N(C&2;,;Wf8/?7(d^V6,<PO.+eBMALQ\R1bFQ@K:UYKI4/
7AaDF>8@0SYO@3f7FL?T(OY:#[=cff:=39[:ES)bP=;@d2WU^FG1X0.(SV=Y/@gE
bREHPIRSXf.^5QRHU5@D_2[\K>TKD.WF7Q6J_LEYN[,cZ>_7G;[UY8g0,PZ@58O6
,eEL:->KL?TL(/V2&g9\AP?8;_5OCa3>?/14)>_SAbgMfMDJ+;aTcJ#:ZPF&L#2N
bP[R+JB1)<XaS,=b=RXUUAWMD+GV.R@JgZ]WVHEHKJd-,4[1/R1aJ8&gOcLcH]Kb
+#=BN;0aV)ZF-T>8P:(</DW9aO[SI^@I6L]DF=25K,/gaW,4KM8-(<W-P__K-e3M
4_<9OFc6Y5&=R>@dU#2fI=[8b9Rb2JebS^8:F6BOe,F-&dEPYGF^(63U/bBG.3?H
V]NT.gK]^,2H,_]\KJDP+#(=H3&AF=K2DAa877];O1fXDTAH7KXb-b51&0RXO3<2
8LXgCV^K0M3_:Y_PP1OC\L0<0II@<-CJ#,+fgU#,=112g/=d_+D\QO+,K=/8U#7E
0/FK7Scd&(]1e#2@MY1B=_6KZJ>Y<+J0J+5RaF/?BG@.(E_^6H?;O]@B1QJ:fJA)
=0;4MX=UR,&cW.=Ua#6SB.5XJ4VTeO:SRAE_YC(:C@6@]H>O.5)>NPF#;ANEL75B
[NZ()LF7@^->]>d\BEMG^_,AcbQ&R:N>Y_ZRS5<d-]LaZXE,b7C?7OZ&I,WdEXR>
?^KK]bg^Ee@SATJOfaSGQ_.dOC;Cg6[:]Z@K52+Y6LdLPIXD?45WVA,2]X<_aG:0
[L6Tc^]@a4dZaW0W.^\DY_K.)[VS&fROfNcUWcX-+NC@AU2),A-e4:L^YOK\EH7>
W>f7KWB5^S#KH(X&<)G#;\9>53OEUd\4ZD<3EH[))HaH?Le__HIQ#C<6^XE=,]QN
(bAJQF/b&Q]bP:I@I7>KGfU3&B6D-98:Q84]^:QbCLQGa<@e_9S:SE;=3LR<2Ac>
EW2d.EBXf)/.#KI01ZT4b5ADN=a/f7([G1&AM+Z,2>K7?[]cCQfaS_Z9SS2WVD>V
)fYC+T&X4K<CTTB.UJa=\3XWgG+XL9KH4XR7gF.7_KZH-XTWQeNQCG>-:9OcM^59
P9;BL964A[32cNgD3aCgFU;Dc[7f:SY-7X28bd1D->@MHL3ND_]S;O.cUMJ>>23H
eAYU5,X0BA6LG^8J-]R3-c;R2ZTHUQO.]OE&;dJ#HT/Kg[S4L0,gB(OSRF\aEH.L
E.e,NAgOSbNRQEGP-a.CU^.dK<X=c+G\3XWg5QN[3VFA6TPUGPJb\.Z=D?(gWcHH
9/I5.OF;W1#D@DY(XB5GWc6SM4R,N<9I^>4U,E(1Ng.\V9bJN#O5:-I(V=g>L9#Y
[9T<QZ_7;^<EDT[,(R>/e@9.6NE8F2^Q?SF9M5V/K)aRNGCC,ZbVG<<5LT]Kd3E3
;6O]OCTR2_5ZU0e8F@>Jf7Zc#&OO\YbSGZ]ag#/H1G_::/4K]NGR6?L^\]B++[EO
-)..1M(-/D8M7KFS>#_DCX-WNG/+K^JQ++2+,;/eJeMX#eMN>[#4f[3cVf.MWB>G
W:ELT[D;DV:Kd++V/KG5\##@)\PL<,7=VGYb0FGSG/dSeH0[\,&-#H4dCH3(E)2a
(<a;]aLLSA)^#e3HVK5@M-JL[EFUKNf?LP)2@5V\;eZaZM.74,FB\..-;H5R,6=d
gb3YLB^1WXUJ:->]0>6NNH4HP?b2-,J=_77HBOVI[A1Wdd,.f(W#Qaf:X[;)Z8^B
GB:?dK>7M:FYX_0EQ12H65-gJLXa_D#E.O8)CRCW=d([^VAO<eWV9#e1G.TXg:?e
.(_5#\2c,>7g(^@aY-,)8C?)Qf@[2YA[6RY_[^=SRZ18V_<K=)[[4^-D)aAGO9g:
7(YP>g-4R.?(M:?Qg18-DH--<?U,RF;QUK(?g8N\WM3.BM.b<Zg394L:^6GQC1T7
^\.>=K:?[=E@LSRCO7Db#UZQaN?+R-(,ME6=gD.,\3:>LT+:g?^MfP/fd^-)A)&X
BS-_dP4ZMVMAL(19&M=[X&(GEOf,OT@>U=2+Kf6Dg#]-;QL\K16R@+_]XAC:Q_MV
.C4IRb3,,=,.\Bfb7/1M_[FXBHcRRGD(c[gZ(HaL?D/3_CDQ?IgP9SPK=0L;?bI?
1K=?44.KaW/V>Q4K]XNGM(c/J5_gHSOdYS9O=1)F[PKAS/OI4<2--A[;eg-,5M>C
NUHE5/74OSb../a+&7E:bOT?R[&M&)N\EbHfg>2)7E9=0d;=3Z7^5AW)-18d3>[2
[eC?,])ZfW=R;Ka+RK&=;()+,?M71081CT.G#(<HA54XWB&T+;W5?#aU8VKd6]AE
B6C\IV?7G:?UY/7TabDMgc4dL>JeEb.S<=]@P4O.IL[g?eL:d@51,1LP,Qg#M2eB
X&NP6MTRD_b43-Y4Q0SH]\5N(_@=G^>SL7FFQTL.gfTCX);deT,YfSWeK#YWY&aO
dM9cB1f?WEA#OW6ZYBNJ16BNZ&NA/F#N5AYY\c-Je:H\38IZ.&B,A/U8]#ReZa/^
M8B\6_MPW2Gc5F.DL<Z3_K.PYXKWS_++ec):5Og#g:8KZNTLe==>Xb+SC2JHI]/Z
W\)R;KIT>a9?0(X2?N@F=I81_Fa^gA&&gRJORTG9P76F7RW)<X^1N1MOHH.Tg1(<
(IZZJ.XU_MF<a_5a9-AR]&:HcQ_99&_:Y@[[^V\];U474PPO=89:<^b)_2#Ce2A\
c?M)^NE^I@.J+bf.bU5fI.V.:22bB:,WVZbN4JS/c,@=ABcf-7^S8e^9H)gNg2f,
;@]O0bEUCD<IY=g1..-[KEI.REPC&eG^/_R#(c6JV\DP(O?0RWJ8Y;fMP6@XP(F3
I0?FN.-:3eTZ#+J&1L.D_cM(<>FDPeYU\a3?[^SU6>VZ;TI3LR]F6D@_4SK]F=Td
A2F#4P\X+OWSDZV/G?@?RYS+:b]6e5;GEdJd34e4EE&C4bT5Z<;H^^Z;K&=FCQ,)
/\<\3:LCLebfCZCN3:GWO1T0e&)1b++f&E]Qe^=O2N)[?Z_(AeS8M[,I0Z;.&JAK
77P[=2U<Me=O..#3?L<G5G:G>UC;M5eS-:A3g_.-QZIUO]LB.;P)/72ZAS_e.?2O
-W(4E7&bA@N6IfF(78&]QfWQgR=THcE;.M\6(Z<\4VSe:H+>,K&U&4BU9_3;]cB_
gJ7Ac^S,IdMZ=S\F@JD\8XRLUZ&D^8L\TFUS4d3;+NU=GeH<SMe4]6>bV/WUVG_.
>27AC[S<@(8Q?UgX]_<&M)/;]?..#>A/KU,9VF),G,b>NMPJ3<V+2_\\H1=@Ne1&
DSCaWf(MP0[gS?Lbe(_O:[:?RP+Y[Q9f-E]LDVYaY3+8_ZVb8E14f_.B&(W(J;71
bD+bLRJ3,&e25HNR;-69#TW<cJ44e\P:ON#>:W((dQ5ITcW<_?7.+Gb[\F.:Ldd[
?5H:QHBT5]I^>KUFXCbQ3=/b\A#^E((:J:6_.=d<+=#03W:.[I_T8\I<P?G3E-eP
eLWQ+E<a>PdgXeV):TP6;]7V:/d.O<ebM>>IC?)J3UZBGAMS0^6^OA6\,,#V_TD,
f0eNaa_L-A_HO)5V7)^KF#c]cBKOaLL7(NQSI37<)>14.]5H4b.Z<Zb0_]2\(4V7
V\I>)60^E=VA\Lg_QaZ#d_&a4167^O<YSKWO0#?c_)9)Y]>X;0PG)@RbY.RQc^4-
CX7Q(R[f/e[_X12eBcTAMAcbH[F:6S>bb0W^V(624UGN8-G;VQ_&NZHg<BLJb6e3
4^NM?QdL26/#/G8=:Y1Gd2B]1++)<UH-RX9:#,<fMbHKU.1?4;.];;dK<L67[9cQ
#=[J2BG_I?1IS.K<28[_BO]R(^7PfWb@RD[adPScJHNM+^@Eg2E?)N.dMfE6UT&F
>)YR4[SDaCV47gD=CTUZe5a#WKG[/95VgFc].+^eK,4?OXDPE]=&60@=fODJ0;#X
[24:E;F0\ZAC<1\2)KHUEWI+ffV24V^UN@ITVBG7KbYDee#.Qe_P0LUUE@GbbU,Y
V;1bb8I&)6eF:bLR_=X]&aPC_@X1C+>6C-91=Gg;J9R/d&NMFC3DbWg^2dg6L>(K
#2-VY[>VSXQgMH+BS@JMEWFf-]2LLf#BC&>#a/VP9b/>P;fc@VD,,P=YaX1QF&O+
GEN>0[C@AbLE_/2?)b0X]Z,dMW5e/,d[QF9=b-G6dS61-2&4LVS&9O(9M^_ZaMI4
28A+SA_@DINgW^178JT7aad3H[bdXe.AY[a>;cPf6N/VOC=^1MOSE,DSM&VXQR2Z
Qe/[[#gXQ3^B7UQ)M01:;MFO<KS3&AFQ21b]53(C9?C96HAdHAcLG],/N5&bJVKI
\\8Z^SP+-(.Z.YRI@CG_M31,O0Y+I>QZgFE1FMeKVPg)@==#b)_J+_NIX7fIa@?&
fD&VLOVa(NP\^MT5bF]g:?YE7C1]Z7QE]3AdH0Ndg:#(@MOQFL/AK>(M#:-5L+4Z
-N#c0-O2<6WV@8?cAK5^a94;ES]dU#O4[,&L\LXZN?+7f/fU;[2Y<ef4X;1gZJU6
:_H#(7cMEQ.2M>.M73=O9H=TcLb;&.X9eAP+X7Q--_c,@?]&PP&KP^9T+->8We?C
OP=G5MNcVQKGOdD-(f_e;Z]fcP(WY+#?QTFL4O2HS:b1.&(QEM:R;7dP,HJb5MCI
BADZDf>CFGTEEb/8FV.Q->ZM,@_K76TJ]R,8=f([R7WIO6aVEcadW[>(6:#e5bNP
9Y0X?4cJR/@Kg,S6[M_XA[LF7)CbSM?(XNMY4cWZ6a4WdUF83KJS5II^7AA^Z23L
g==..51AaUR]VRe13=.W&B#V.881(V.?&VGWJ[f&0+)R5B1_Y7QGS#CD92XM377U
_)0_>&6,BQE46a1&eGeF9CBQC@](O]aB)6N/a?cAD3c^;Y<VD1)LJ4<0cK+G^\4O
YNcU1#=2L&>S,68d:XII>VYcc>WQ-I-U/cK1#U,ML9c4Fe\DH0;^4EMeZ](TJCQM
7EFAQ=NSOO1U5&@&EU8IK;YCdS<+dO.A+:8:X1g]g4T6c3&.(cEZBU26G49CZ@-X
QJUQRceL[B+aV.G?9,APBa6:9\7U7WP&H>=IK0-aESg<=^eJIPA#6=?N&FNaT?(_
LRKP9<LQNgAD<;VPaN8.@I^)aCUH_VYa2+IDTaG/H0JZ_JB[OgD4KVAgUP++RacX
GA6?RA7>?,[&bVO5)U[>Ed3<@T;N7\AL>e18d(&>=:ZG_5a;-B/9dRGP;K?J4>[N
NS7BMf).(K)LQTL>TP^Z7X:ca6[JXcMIf6Z7g2e6UT^@9]]FJ,cdZ\_fQLGZ5\I1
#X&eG124Ag>GB&eUMX.?b,G)F_FV9<@Y49.gTcVPWF/@_DWF0?2QU^e\#WW?[-\\
3)^E8FB06ZCKJA;J21::U99Q65F/a8A=D2Ya1F/eJ2[d23HR6M;V9@\Ode=MV)O/
g,[J\:OL<IE]]TQL>c+==4#XbJT8E4RFgU//XW:38^Z4TLW?H=4RSa2:Y6eMF1Jb
>IPYcZ8QBM^CIRW<;NZ0;K&50XCLHCTG]XKMKbI;19;WdJS;@CB7A7^BY5CCS,U6
b@AL[-20:;2@H..=9DQ8Jfe69H@[BM39DYIL=/DK8WG:L)3Ub8Y2&Ga,TDcZX064
D(6ca29da,>(Gb<^DX?S@Qa,._@b@]ZE].GN^UNLZ1_O^ZHZ77D>U.+7)J,YT:Za
-69_Q=eE]ZNM&K[e^Z2fgM^<FFD2e(P-c?ba#CC5J6f=N3?E-UT_ZT8LPC0)VM(S
:2H,gO_CXWKOX.WQ3X6<;?C0FE.L>11Lg_N_FAL,X;N=@BG:K&U&H9OcEIE-7C8>
/24+;Tc::1JGMbAP.(ZU6G=I9&g[NYUNgc#4#=P:J6#Q?F,G8.N46bIG>GM>Q-1M
_M=Z?0cfd]6.R#8F4.6;XOa?6,.[d-ad[4E->f9#):ZN>Y;][B<_:0X<&)L>TY0W
0P)f,3g(XJ)ac#A-K^[6>A5<Z)J>070]#ME:4[-G87V[H[I?TMfdY,:Y;-?Ia(4I
FC#Q/EGDd]eC7_OVAYWG^O-32A]-/,&EU@.;@d/bfYHX##)0XgAR\Sa-D7.P_Qee
6bE>^ga0LW^#32dD6/Q&3>I1JBZ;cNFC,UQ2#]3c;AH3O7[ZZebY-TJR>3f(6XV\
8\)M:N-BQOGIGPP7@Ya(T41H2:R1f]HDRJS<aTgFO4W>I9a<J8347P5:+(@C_QIJ
]DBI9-#d&^.<eV.f)<+6b@Va.A[&IVKcH.,B+<C=K3ZYUHE[e.#c7L0b1O#T(\YK
41P^fDP-_@2(YEYcE6I/=N2.>DSF;<Q5N2-V&=Q_a#F15fFQ#@R/>,C@.TC.#eR3
ZICA5fE:=VOAcKd@8:P^/.6+,^1L>V9WBaI=4b,D33W1^,\Q]^TT_H2ceC6NXQ=b
/gJK_)T-U5bU=M>A)G4\=62FFFbOW^If>.\A..P1eCU#]8B)Q73^Uc1SE#DLEZ\A
Y-QET\5;JgJK40K)HAC(:[ZQ0(WD^/BP;aWY-2&4F4.BH<,+^KXXdM_G<W;#d#8Q
)0&@D3P#3ScY1,:8NUIQe29dHJ4f]]bBA03@->Q@.G-dDYBeSdTQA&a3BB9L\9+0
\Q;H&=LQC_AgZYE#RP6<D/cc=0B,166S-2fd90<7^EJ8T3NZc&687F9\&6@Q1W[0
C7OI@HR8=[TEHDXeZQEHRT[8L+=UbdX[fX8@G0(bHYLV(LO.RX[J#c)JeOf\EG2F
D(^),PFHXO8.3F&aTbd5TWc0_L]@[QWb5feLGEe&>ceQ,H#MSW[a_:IS8bL=/A3+
GVbAH\7?5:=R#6:07GM9[;CYD4cV),&N]SU?TV&2OZ=(SG+@2a0IHe#/?DCQ>1:V
Z?@+N;4/0?4cY3,/)XULd_2:;Ja<@S&K7K5QKVP-.f^aJM&YAO:QR6ES1D-YW,Hg
.PgPV6gbV:S>1;dS,9>V[SJW=9BQ<KL(b>@([gKPf0#+g,;OX]C0W)KB^>6OA/d(
O7Q[fHgcMK6N,/JC]0:g)RZRO\J2@NTEPCUHOZWg^7H_5N@)YN=+L8KW8;8cSF<a
MgJTH2.6SKac:N?Mcb9D6.5@Kd8K-X=S6Rg5?J;I)J/G]IO;K?=620Y0-TW9P=.S
PUJ@RD1\1b#/2^7IYeea<Y>7VP[HLS.LdE_L)N(fMN6KaN.f99@Y0J5MNG&eUH/D
W=0]1T>[T(M>Xc:2>4V;E]^ZRf4Xe1:K-Z8)A\b0aZbN.b[/VEA.4@JaA)#OfMUb
g72A;PX,111M=F)[>P;0^CAY>0ZYVaN5^eeNd6Pc3#B>UL>/Y.4/_W/cW3ZCEgOe
O1Q_BJfX<GC,N1+eOcOS]4+QRMF&H>\+@WaZA>3W^;,/D@;H_<(cQdB<C0g3X+FQ
[3)?_J=>,:Q^b@N:7X:\<//N02gd;X[2\8GbPUNU&B[5MP5,)8_X,\+M)dOSER/P
W58>Gc>Y6SZV)aaSL-:29XJHIIg]^4Y\+SA2FLf]L(Lc#=fT3MQ>D(c)FdK<_)^Q
L-JLM)H3EN_1PdKFW_MD46Rf>a2)OQ2-K26/^1Qc@#FfU.;26YQR@^>.#QLR.c3Z
3F6e&a16#KKcUR29;,X-Q=dW-]YLbL+\3&eBfFa8^4S].He]1L5\U.Ia]DcPJL8d
H]FCL_=5E_b^=7<R7dU;YR#FNTL1R>_[WG[-)AEE,[5O?WATAO>I2Z^E>g#-HAW3
Mf#=.YY/X78@fJ,aS85>RN28c3P4+RJIHNb0DV\D>d<:cD6CR^4;fYV,Ib6.adLT
(BW=+#H+[3BF^(<e8:TP;Gg+D\fU#:c0QJI9(2P6?M6_]W:G[:6F<T_A?Nd5^09;
CJ,f0g:d/4/LEU4_][RZ1C5Od)0RLYdG>=7QUP/8KBb^3(LUJ3HP/-bI=XF_3K[+
(HSQcc=0@=eSH>VT3+a0a?04=dYM4N8JO4>BFgb85EV=(&N&A5]F)^.T5\(P3GD4
RJ9:N]F.,Tf6+SCR19P\0_GHg<+@B0f<N0(V9_I=:??8C^.5-7<U3P>G<1#U.cPT
F01L/5B7U^XB)WO#/NH&0&JD2]4Wg+65#0[We]Cdf\],D46_W[RQPQXYQ/U8,b-[
#YgXB.GBILK793(K,f(\5KKK1=L6=f)8(5&QK@T7O+=UV]CF;&:UO&V(19[gWHET
-S)c[c0.Q]7aGP0]M(@;)L>G=VK/P]Y>KFgMKU&0&&D8\K_S,IC;Rc(:W\(cHf:g
MX#FU9&D@G&MI&eD@B8+6?D;G(g@2MF+5=_QQ,6U63Ja[EXd^NbA;IQK:+(7?0,^
J^Le:O>5Y/>JAR@gR=I\)<8X&66=^T]((0-,VX#WG3+J;a[fFRe[8b>(^eD,-14f
GT=-\7R(=Q7[c6+#,EIQ>6\K59Ve]UQKNDZ7H\fR.QRU;KL1PC5E9>NE_OS&^BHT
d8P.,A6C9HJ:EYDK\=.^_3PdKT?Eg=bH1CVY,+-I2gW2f(?[Ib]AWR,8Z0199[0-
?cDLELS5)LHd:8Hf+F]]>LCDbD4UXQ+#0NZ?7P\@)T]eBX;VR)D_BAbI1M;Y.[E4
SBUB]QSbR4SBX5J,@/X8K_CbUg#^N_#G_Af^^6RCDf<914V-+QKb53U\W,>aYaXe
+A[=7Y3BJ^1CA=,]+g@BL?V_eIBY9:;gC&V4EUX:W-X(+OE/[W1e]22E[S,aHB/3
;6@X:F,7+>#.#HYg=A;J90ZY_.^U4.A5NW](U^U-(DM-[-KQS7B-9SDHFA+6+7)E
@PWT)g\6;bb<T+.eXJ-=),4Qe.g+6U@F/KWQ.GD:f&#YP.c0EJHRXX6_PTcbObd(
@2gJ^a/Zea+QN(PbOQX)>db/_JLEAJ)W\P1,#V+\:&[Z(3&V42?V(6#D_CS9?M#&
6(:-2AZ2HKIMWS5?8V(]X;aLV1,B#IS9c1MgQ-HE</W3;(IK+D=CGA643dJMC.60
P=0)\CZ-M,ILAZ#IPNg&/F-LA^XbV(&c4=R]<,bdW2eTWUf(UdOTW&c>IKB_],L^
g2/NHLTB-(Pc1dJT-5#_6[0+]&<8c-EJYX860^QBNfWDeP,,CbL0)=6\MV9>,YX[
>R/f@Z0\bc+]2MCeQM0D,D8YTLMMMP7UQ+#cUN#M0>H(>c&)XYKc8BaDJ1f66X9@
fe=aMM^9Rg8a>V^=9cL5Y^(/BF6;,R=bLSgE:#I7TLM1VbIfRP-3D)EOU@7N@8_:
<8&GP4.2e2L<NX&Z#BfMX8b/:XU&N-A6f9GJeaYBU&EZ=Q&-TBKRYeL=SY2<XIMP
f_W0I<c6)PbQ+@AM,aM,SI?Q^bL&L+7aJO2&<@^XU)PPM\^CIYO3>KL70X<#A@1/
a>ZJ.+&^4EHa_d6FI1&[a(JK?f1f\\Y]8=U7GT;6ZWL<5UUK4B5-_TRWE<+O^KKg
7Sf=7U4b/2XGg.MWcOR[7Xb=NXCEDc7Q@[=+,BUE55VNK[BRdc3?Dgb3OGa9a7W:
YSMc]^YSf4eDa8=\@+^P>AE)8))@?.C(3J=C#cF.=(^XZ\d2)eF0)]RJYB:f5E#a
b,5XGW71Ta\[\A[[BZg^+Pfa^:07P67KXZ5/<=LB,OHF#bEAb^C(JC2BW().UTZ\
6c&gMU/Y?[AD/g=6LcON46X<6=]B06O8<#0,THRK5)R.LMF+BP/,KU^(>]cOYI]L
<9_3M:QdH)9U(eADeg/.SX-&VU^-=_bPBHCBaG_G;06NY:NZE7^J6(3?_5=c@OG.
J:<C#]=\(H09B7;>,f=#+=N+ULMM-2DfJV,\#^4PO/WMd\(7U]fA.3HK=KK\YeaD
EV?<R]=/6S3.A/\^-Fe3eL1)B5Wc>JV99(.<(6#;Kg]C85D=g)gW3f95<1ZP_)B(
.-dd3,ae+2.GU9Wf4H#D\#AHbGe?A;<a5+a-_U2L27VFW2&#VYCKbGW/-)1WT5\=
#fM5cTB+NY[.^=cTFK8T_AbZ=W+&-_g4\IaBDY>B88Yb#8X)8VQg.AFM&0O6dCD<
\X5)gL_J^6d._g33X97YD8;:+B+</6gbZ(gFFYKN\NY\CgQ([]0V(JTQ3S3X]>[.
KAb(:?@(;\c--:9egc9/VMbEZBBBTF8<3T\[)3LQWEVZR>0S3]e5Nd/>fC_RBcfG
OBcf0_Ba&3#,AXEfTe]HDPO\LUeN5PO9-RETaJVITd])RH<@dN:)8feOL:[#]eML
9b:f=d)_OE<RRF&CA\9S.F6E1S]>?6PaG4VeQffO=WVc?3JG^egdgJ^S_]C=R=F[
b@>E8A.(+C4bd=7-U^VK-XNZGB[>UE-TJYW+^RK6fNS:.7Y?Y\]e4I5V0,QAQYDM
/c0>51(;5e[U?CS+e6C]=2?]ON[+fdP4aSc.PZ95ZN0=,Lf7BBH8]A&Z,.T8P0/W
Sdc]<C8@RWWdF5_0g]9+TFDO3eYU8BNGTAECER5PbTGb>4?I]:I6EMZ6Wgb7&98a
&.B;K,XNN=<):[C]WS;A?A-._Z:=NC_G[;J(;f+#B3F[OXMg]dY_H7]H0X,_P\@V
cG(RI&Kf5=1L.d=<+HgQR26HHYaPVS\J11XDfRG2J5OKL>Y6XG@MQ[7[[,aSg0\@
-3P#Wef@KO+MYVR-40X)3(2<;:bOKdAL0_ZKMR?DUcb^EU2eP+&ZbOZ>d&9gENe@
KRV)+6[,YbD@OBNB-46-C</7#EbYUac0L^0+Bc\)=EBZMMS?&Sg6E[T^+CQG]AX_
]^HH5[??,VMZaOVJ\8S,QZFRP6L8^d[d4;=3+ZGY72Kg7B2=,>Qe\d-cAM>G8MG8
N[+P.YNX8.3cJ_<N>0W<^/8L4=A;d0ELR>8N?.VPcKD#fM95_HRAYEY_@B@=I:fC
ML2]O_]Y\9_BB=OF)MEb3UbG_20ga9C[H]V-_UHaXE:L5=0[U/Ag1KaBCPD1c?b2
S?aJ^RI+#LEbVe+8\TMSQTR\I.eQ&.A=7eWP]4c-7UcY.J47R&WGAX8fTZT2e/bE
V1S60/U+JS@K+^OHID>Q[8I@ZVIaC+6F^7e<Ee+@[HZOQ\HM[L7B?dBXHO13H=D8
gR4.W.?HI?&N4,(\N]d.TC;e)09)L7LQ0?M?[e>=,1)I2ZdDL?Gb#\LG@,3cg@\W
b)JSMI#>2I:;O0)WJ51HFf,0B4e=b+Q-HN_C?cU:5:&49;b3H9-9]D?]eWS-IDOG
<dBD9X,(e5UEG8edFQ_[42bO0-3Cc@JI@\?ZdHEU;T^#NUALM=-PCBT32bN,aMK4
^^K;S^EG1-,&F&RNDWTG(NSYRR38;A,(I,7^V]:c2)C09+XgReUCVT6b>fLc8K2e
5Sg_fMC:/JI0I5:T>929Zc+NJ-eTKUXbP40XZ)N&H2?>L7CO>TV7d?:)..]^GBLI
S0Q#G1ef37R[IWSCMF<86>::D=DTb/#gd.H+He4=O?-A\a\>UPD_d<L(H)f1ZEAT
D[),a&Z:Ba_c+O[W6X#]EcV]PU\HIRV/Y:=)b3,OdT9bC)=,g2Q.D?&J5N^HY,RR
U0a1A=SQ>:14gEW/F]dWGQVK(&5>:Z3gX2N5;=4dX.bQ5<d^9C.0><1(Z51?=O<Y
9(:b3f^<A^4J0C>E0YM_Z2TOOfY@f19QM;6=+.(S9B=a;B_gH3S(_T69(,C=.6WP
@SE#BFId4\45GQC]NA[fcA.#\2&/-]C<EcQVMfW,A7NNV:NQHE\K+c@+TH14EJ1c
=?H\eWO#F4PEJLg-)bC6_=QYJ,16]C]eHUdM00O1ZXSBGQF2>,XTXMU(,,&DFg,.
f9VJ3+F);0AB^D+I<?g\J).T<+QQKL:SbePaR)&+&N9./AV#b\Vc#a[,/fC-DW/K
?W[2GO=.46HdQ[WAZ8H7GF5fc64<)SVU^TT^:_dIf-8FDW.@.Hae/LV-,_C5/9@&
((cILG/eMM1AYWZES:JU17bR.Z_4d,c^d?/K;-.QYUCA6cQXM2)J>8W]NP3NV[fA
9.VB00e&NQdMfW/6^/M@7P_L/fI91@E@c\eUb&aT]7ITafK6+c\_)H6NE>[8O?<<
_3O&VU.FR;7N#5,W5A@eVP<T5Zb[#\,U6eGSW,TGe2]RW&5M1[X+:,9I8,;+#XeZ
fQZK11@C,YO.Y:YH^]PZ?D5dXL;G53M1,G=F11QIeZNb+W?4Gec&W;[H\T#cGVc_
9B4.<.NA3L/788O/6abWYAQ@1R_0?NMUZK]RKS</#W_b+V\#)OaWC:^\)\N5;6EU
OQ&#^b]/RJJ/#KU6,-R]HdNeVRJU3YZX\N=<[TN(aR\CXGB=;/6=b_2B/O5Vc3\K
@+SK1G1EI@7.=fg#PVPF&7b9Jb@9)9)G5U\SR5_Wc2>87QC19WGN]3R,<(S_U.BO
f(67AgUbKNFEd7^SK,0DV<C,Q,7:>B[<3Z#aK9YYIB(1XH/X(4Na\O:(F9@ICb-(
98-JVd[2Y[[IaYM6[1J=&(bD2H&c,OGeVCf_gY_6V(&/cdR@@gW/cBNc3@IO(F]8
edLHE8XW8eYW9+T2(N?X-V:]>;NO=T@<6^DY+=1b(HQ;-I/+M+N<@;4)cUa9L+>Y
1:8c1X3BF_eIZ&R]C@/EEDI;Sg[7.d&F@eI@@VFaMWFTd)SSNe#^bd+Hg#BS_.7V
[1CI:P7E;\Ic,P9)?=D02#Be#dPTI<T5MVTCZ5_N>,ER7F->WY-)dMQ.QH_#K9B3R$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_ATXP_XSPI_SDR_AC_CONFIGURATION_SV
