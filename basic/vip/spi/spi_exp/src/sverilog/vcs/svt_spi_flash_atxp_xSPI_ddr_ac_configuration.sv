
`ifndef GUARD_SVT_SPI_FLASH_ATXP_XSPI_DDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_ATXP_XSPI_DDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;
// =============================================================================
/**
 * This is the AC Characteristics Timing Check Class for xSPI Flash based 
 * Adesto ATXP device family in DDR mode.
 */
class svt_spi_flash_atxp_xSPI_ddr_ac_configuration extends svt_configuration;

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
  real tCH_ns;

  /**
   * Minimum Clock Low pulse width duration.
   */ 
  real tCL_ns;

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command in Quad DTR Protocol
   */ 
  real tPeriod_Fast_Read_QUAD_DTR_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command in Octal DTR Protocol
   */ 
  real tPeriod_Fast_Read_OCTAL_DTR_ns[];

  /**
   * Minimum Clock High/Low pulse time for Burst Read with Wrap command in Quad DTR Protocol
   */ 
  real tPeriod_Burst_Read_QUAD_DTR_ns[];

  /**
   * Minimum Clock High/Low pulse time for Burst Read with Wrap command in OCTAL DTR Protocol
   */ 
  real tPeriod_Burst_Read_OCTAL_DTR_ns[];

  /**
   * Minimum Clock high pulse width duration.
   */ 
  real tPeriod_ns;

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
   * CS# Hugh Not Active Setup time
   */ 
  real tCSh_ns[];

  /**
   * Data in Setup time
   */
  real tISU_ns = initial_time;

  /**
   * Data in Hold time
   */
  real tIH_ns = initial_time;

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
   * DQS to CLK delay
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
  `svt_vmm_data_new(svt_spi_flash_atxp_xSPI_ddr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_atxp_xSPI_ddr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_atxp_xSPI_ddr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_atxp_xSPI_ddr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_atxp_xSPI_ddr_ac_configuration.
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
  `vmm_typename(svt_spi_flash_atxp_xSPI_ddr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_atxp_xSPI_ddr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
,5f\Cd>F?C/V<(gbDg6A3QP:4]-YKdCJ0P(a.McXe(M0.dH2cb&1+)5MR43[+L\C
a(/;I#+:599]/TB45>^@CEdT3N)TMQY-0CG7V[^.YVMM=P][3Qc+H>4XHdMD)c&g
G_AVL@Z]FG+^.6;;WCb&,e<Q6FJ+ePfPZ@8S=-bKZDWE1VCTe&B)_XI3>;L(f9[=
I+22MfA(_/aa,<W<G<,0Pa]K^,=JMEc3HW(:a_ZS0NOD#[BgHC>gT@cb1J\&C@c_
E]De:F=1W\RARFU6WcHRBJd)N@LY-\>&36B<YHE>LZ4dZ3P]J+V3JYV)I42H\\,M
?6-S]Y#X?=BFVfK.A\Z;I323&gS(@(,C55<F=OL)30(T^^>A;0GS6L-_0BF-g4D[
VX1/g/9C212W0G@^29J@683FC/VQdW]V@W8RY5>?gK(IB/[+I/f((U&S2D0PPgB.
R(K3X)R&CD\FKUb2>Jc8+ID#YH]V1G00;a;I_MU>)B@NXE@T,,<B\)[&+X?AE_/D
S;<X+2>Z:2bcD+b<=ACSK+bRAM[A_5N?[;3RE_WG.&B@2U9XM(IW)MBZR5U4TV4]
5KK59)VId.\^NO(FZVKKfZBX4OX#S0(dCRK\HQ<37dG_OY(FD0)fWCO_&/M71=gE
faJ7\T3M?MRa8#F6_1,GX_I^FTb\,<Pd3:B2##:#072([X?[_eE<S3B>YC527<74
8/@;YQT<VA(:,=IDcf;J\MVK)g#HIH]Xc)OBP_DK/GS4L+e/a18>V6>&JN:X(C1_
K7A.aOf=DT^K^@-W^A[2\L0D\]WVWD=0<<e?F]&<OCc4E$
`endprotected


//vcs_vip_protect
`protected
P=@J&.X+@g2c<(X]aXWC=]F1>G&>B.<K0TGVEG&JUa[DVSSe_Yb&((MP)+>>:E2\
8=>6VXENJ>&LBF?bBI(\>S9)9O@;XIY;POcQ=,)-K5HaPC>P43CE)SL^0YB@8LKe
I;GW7>=L:KDdJfD7&..Q=K(I2WW,V8ZCHJ+<geVdAUM]-U,5)H0^?2JN0\WWKT@K
Y:T#>-A:aY#+.>a#BE?T8:.<bfY>AgH6F+O/2d<F]JI1;&\Ue[Lb,Q2]+7.B4ZRL
B2W&+/7QBGHKZabT.4??:9W4Q+YW1.BZ)C[<H=XA.2bBJSWU5<0B>N=;T51:^N@G
WWG[#HgH>6&FC>C4a^gXL\OUT2T+6O\Wa3ZJ^O,)(S([,cXd0.GO-:(EV7A;7;8F
+g(eDFATOfVff[>58N<BXbaa;,7ZU>B#W#BI@UgJH7Q>LGAB?:8A:[ZI/d8OS_U&
+<M2\,Md>O0b-0YU82EZb+P0\\2AUF0Qfb2/&+R2]VD.Tb&c4<N0>[\Z0HO?e,WU
aE+B<?(I@d?_YH63/d3c0[HSV>,BB8_&PH-W3Rbg#HdAS#0I&H7D>;GM<cQ+agO.
J&gbb)@#Z@D>66R=HXR2F)OPW@TMO(TR:R.JX=d0bH(Q+fF;@0IFcGPee9;[?Bc=
K)_McNG<8NX/._5=d5a^3\0JU:J_;2H)V[dMI)fP#f137_8NDH0.dRX;4c@+c26@
8HOX?SZOO5L7@:(MLSb5c75Qb;/XTSI>+J[2U[_8F9]>c-GQ3R\#006P3+1=88=;
.@WQfV[ffU-bUC^JRWUO[MY./g-BFd73HXV]1[1^b-X4Mf/S,9/;B71c<#-Z7V_R
K60:2F.)ALfD^LF3,2BeKH@TNVPGe##f^@XRTS(;W@Rf[)R@WG(-bNP35+3c8=D&
?.3aNSSQ8=.?M>\W=-ZS;GY4N3SK(P,YTcWbJeOBS=F>T+3BIB/[^9\Y+A,KAR7H
FM0B:WV.g\<>]^0BX#9Aa0A+cXEE[TAa1K0&g_eZ#?E:S;[F&)F-J0;MDK9DC<H)
K5d5(?FfZ8b-/I6@eWI>.39-Pb?:F.-..-eC\6-T<ACe1A@9W9U_HM?#.2gCc>Yg
2V-TeSRR&fQNB<Kd^2E#76abU=>]>B=7=AFg^7EHL8C[_<Jd20J#K3)X&^_?_;,c
Rd8Z(+GGe,^\M<K^(I>Ae,d]\6_WXU8&2ZS<IB6NgFP_[Q>[aD@;VBF&1-K_d=+7
0g_9eeeVX]HOBEFI^?+8&9^S:XXY4[#7?Bb:/.[ZcQ]7G=/F)O:+\fKA.J;)YBA/
Y#LPOT7-#42LfCL567d(Q\7UU&6E1_2)C&;AX)9/P,^)a7+6R#1)?_#]WIeBDcS:
;:_/FX+QOQ4\T8#<LX7H//H)+&U[e79L(6,e+fbJR8?cJ?L[Q=K-O9>KI[\KBLZH
YD]f4X8d?Q(9E4^;QYG4cB2VG6ZUB;DER]]KW_4G[>O0:KW=:@T>7L5XTU&T943b
Va.DM##(VTWH3OE>Z:PKG=ES,&#VBPOGEAa3dQeXHOD1=^Ig#^&TgK?##]5<2&^e
N&H<8+.>SX)M/I1HJY+F?TNe>+6S=?Z/X^<b6#Z9Q0_)@_a3ZIg9O3IOUI=>fJ]D
-JKIgH,Hf4aX,9&)4H.YZLW]G^7)]g_U:+/+=M4_#abEXaa1BaKA1SXTA@3Z_:>C
Zc5EALY9^RR100A=)@5)PV^A+.d8d<#dX<9]d<I>3@+-2Y/b5V.1L@/I^;[=f\N1
T2&I2\ZIY,I_YTEgVU)(Mb,,D8>>^TCY-b@eRQQ/IHXa1-MEL0N&+DIH6UTQeRM\
5OHKU]R=#5AXb6CeU4Q1c1I/9[H&ZYC;<++aC+c5V\(T+YaK9WR_4cC\17eHZ)ZZ
Q]F#DLN3E/=fR>-e>d6,2):M7;)K-ZR2Be>/INbF&7&X0b).#;RL5>4PIM,g6<MJ
:\)>7J5&BYN19_O78CXS^+6^bD&,02(2X_7V_,5>]YHb5)[?KC(6aKUcEeW:]/MT
2#2^C4.d0DOW?-<N#a&[#)3JB3[HI,J\.B:>1XFKT;6(+-SSES&=-\8H1[I;7D.I
1[Q(E@5Q#Meaf#EYWB[L)9&CU=c>36fD:S^C\&5Ya0)/3e2:6)5QBX:BW.D^eBa1
^O=3U_P6JQ7L8O<&:Be+@L0/eU^YN>X[Ob=4>].)F?#P^eg?XgY77\Re0UAJ.C,(
1/=1U?fHAJb+?g.a^BgVMgD1HS6gE-MLJIXS.0c+gA.6M>)@CTa7F/T>,A\VR<cG
FSNS958fZ28]_X438OZ7</EFZWI(C\9A<eQ7NU9]AXB1CES1B;^?WX=5#M^4d(HQ
^20[g)Q4A[L59@H2/fabbG2D#C)W00g;IR63:KC?P]XSa:GI@\+YBQ;2B91EBZGF
C)8&++WNbc^(D5FT6Q<CZM^4<#XNG5M8cH\T9OdSg6GXBZX2IZR\3HI7b4[@(?:^
B:7P5U^0AcMg])50=NB;CbZ(CFGgQO;-6GQZPgCdg7^A0]ecRf\?H1?2G46V#&J_
\c/+WGd^_S>(,EV[J&/LgI,2Gf;U+eZV>SP644YF]Y[RK@[)F]N;=0X+27)^dO2M
N=>-,A;\SKGB-P\cPK>f03K7.d=QRcYWJA[^f1O7Gag:NDCY;1&Q1\,VeVE(=6A@
8>YeT-:3ED+G+:LYTWPX)b\dTUK1I6@bc,6^T?PIJ&aJ=gOF[LaYK)3Ie0WE,MdG
8I,F4fXC-E]XEB\@.=11.4;dc#Saa^c?.=XE87N#=>_#-19/A^bQ./Tc2?:89P?E
#H;-:T1VA<RF4@3WWQG@fR0]MT8L-@KSO[_LZ[&_H@6#/>CWT[?HS1.UZa^-?dSU
J4\6]54^M-;-&BV,Yb\XV4V=ZKRT6.+e9U:+\)gS5PTR.U13:2;D<DbE;GT9U;?.
_?g]cEQWELeD&[?IQ91#AIV9#M_4bBY=5X11#HG[eAV(WX\S;-WA\1GdagYUFF,X
#B-;?GTWb_W5:b]C_3-:G2\.2UWT)AMHgfW(H]8G]PPS7Hd1J/;I45M+U@\BU\c,
3X6ZZAJXb[P.cbUHQM]f4[2;/@cAg:cfS_^eW.Lf:b#g751Y@YU?)W2J,(0,L6+Z
_1UMeZ[E:SVGMW.96Y:=&G,\d.QXPB(T2E76[V92&9e0C>&P<C7>Me>FFcKJU#(7
J]J[g@a_K/O]SH4fW?)CdI\+)0,LZSYP62RE9.USaNV16BXP<fCWagO+V@KV\RL^
RC0c1V#(E_;C(XEIf2cONcgKA[d\)D>fAA[K:6XFg&W;#-EVH>[I)S<HV/M3gZ2S
DDRZOb82RHVO(XZA&Yg8+Ta2=gf6T\C-NM430I9W74,U/Ca6]Xe>Ia&:VP:-3Y&@
7SRCN\E19Z<>5CgH4V-f4f-DYGULfEVWg=L^27T#/C[gUb>b9fT3I_gN9W\>56cP
:\XY224Z=2K5T5@&_(++G0&2F128&I8KZ@DF.6ZNS=&EG3_(Z#.2N3Wa_0dQ4I.5
_Ad_L_,2c=?Z(Kf]_3QK;#d:a3ODZ/@?.(2@6C<^^_(-&:cO7I2LIED,g<1K^gX0
6IT&MbZ5=I)^\4T>8?3J3<(\eE-C3fMN3[AC+CcgVA._(8UGfeecI>ePX0QNKF_H
6N)^<SAPJ,Ib\PPE;<\R,MgHZ^,\J0B3D4-PN57H)G&UbgEL:F5TFJa+8@#ZE9T]
I=BW&7cT?F#f<DUTgXN)_g4C)<:@R9VNU>0;M#UX+P59(.>MC5ARLQ4XI9(+3,3.
bSeR@CKSA2@H\XI752;@\\3KN[.QW+(4O;DA@/L\QO@[5]Z6U?NRVF^4077H(NC6
R16N,(c-C[d^E8+BUJX?8<b3LJ.FBc3UFDH[7gebXM\N);aCdHZ7bEgb@T[/2RRD
A/X?J:dHL5^dU/5]EIE3J9@F67C#FHGPfFK=PYgR)/LQ^F<W&_,@L=K6(]&>,HGM
Ib,:G^T/b\?UQ7CU]I@^[=_O@5S6,9NDeV&McR[IA_]FY5cOK(cH&>66,(+)J_JY
Ke1T<):Z>&NW>(?BP^^Uc;DT,c\^a;)a5=Yb8V;M@fgb/X(dF@;Z=R_H_(6N0:8@
G9@7N0<a8P;,=9;P&^c;.,BNE6>8VQ4R2IL]O4R2//<;bNGI6C,,d+7=d-ZF9:&.
DO\eRJ9(H8PC/e7GV)MUW5ZQTAGfWZY3X4bA7c3;4e>>QB@?-b&]:AZQgS7Y-bRd
TR22H<YHL4:I<W-H5<G<M@gg[89U<H##.&5JF5(Y7,H0)<g@DQECI2G6CD3)P7gQ
O_B8HTFcfdNT,RG;&IdT_\PQ+YNQ8T5GZ#JP72;T=[b?CJ73B+RQ0CL1WUN#37\G
_L7SQ:_g>#^F);\f#Z)P/3&UWe[@1;c,(Q^^P+7-0J9eUb^31;?X0PBXd;G,>^AC
&^SH))#]FC0Lb7J+c;>&Q(]RMRLcA9P[4MAc-=;A-^XXOf[IA39D@V].M;d@W#P3
B?)EJXQ8TL-Z^7\8JJCX?ZQE^/]F43bAC[SPX>6eVXN@<=db12.Mb)\P@,J-=bX\
B3eQZUI01#,1R+O@=d22^I4ATB-FUe+Zd2b<.d.QNSZSYY3S4eB229Z>D5^P6>9/
PaH(8OcAVJa((Z(+<#E=X^[Ke.Y79.GBO6VCcbK9GeG/)JWFI7HZQG(H#5-^g;=X
F6/(QK^cS7RffeW9R4QL9QQ6;JF.f6M988LFRB9bCU^&OLOO.VV7ZA_#\K0U-I6J
/R?:0W?K9Vg)E<&:-I4,XST<8POVDB&S22L<D^S;+@&@DdL&2H9.RO\V2^;+XJ6K
?.DIZ701,R,E(E;0A/-CY:]^cF56Re[4F)dW<]EgL0@)L+[9J2e.0,:;N1DGfUdY
A4Qa6BcAKTGEGQE=1ed#ALgYgBL@>@9d)REBTS.[8I/c@X8>X)8d,U2KMbCWJ/c,
fE>Q.)#\-WB\]8UcFH+J9#gY-a+PWgXNH]HgL9cIRUKdfV(A\K4WN\6f5QY[8.-+
<;>[Tgg7>I5@J:[-#EEUP)DFO_eb@TNM6Ucc@I?JV@J8C(O0.BLbO&a:[O(IKf^C
gU[Z8-@d^;XSYZG\;K:/6Y1Q50]M2J4FL9YZQ:Yf)OUeNV>7=-PX3^\)=@XXd9A8
ZBCIE/P(K?>87CE^Z]]-=(A&-cQbS]@aDG8Y(ZPH0^Q:WCeT^fN7P@TAZE;YR5>O
&>?D&G^],Ee^a>&]c_;c=0L\&N&f4T-]M6FXU7.03:E1TG0TD9g?45dX87IIQZVN
O1;UU+34ZF>_KMMJ#/V(0)g2@a,e(be;Q3@^N_5GMW:#-&OE0=af0TeUOa=6U1B-
O2PNW7-7@g^M/+C1+G&3&<8P/C/=CG4D\f3e3S0SJ3g#[4G-QPe]e671M1J0dX^[
8(I-?&B(<(6:_XLXK(&:JBR2T2TH0H,0aY(>LL1eT]M>gXdV9:bXEC+01E9Sga-G
Z&=]5:Jf\KDf2<@U?-5fG#V#]SI<4DEb+)bG>WI&2^=E@JD2(d3;8af,QF<D:TAF
@1O)-QWdCB/CC913[cM+Z>H0]_Z4aW99J9cP]7Fb,JL>H6@aIe?)Ve2Y]/KPJ#Z?
YKQWRJUTYg+46dGa]5A2^<Y;ASGJg+bYU5JLb@6Q=7d]SXGc8_ZN=/gM?PE#E#0D
TBPLC3IC79G?N##/QPV2FDRe07@UET4eNE>4U5J&gMbaQ)CZJg_Va[AfNG5N2[1a
N1SOXWQP<9d]XEZ80aHSMeR3D3G2Y:8PVW3JHeI17V>DW#fB]VdE:;9SAg96TI-A
YPa-Q&gWgNAAZ&#Y;.=ZBeL^J^Tf(M8B-XZO[9cYG3RLH.(f:9OJ7bVJ@:FDH&dN
O(5O40(2)^U=5FJGbK#M[6[]c@V]M/>SUc-@b&VMNT)+@/GKe-T]T](&faR2W+g>
5(JQ(e_d&LAG5#BU_.&DW-[@/G^/CYGSCK<3>329?[.I:XTe49S-3)Z)SfB=>3TM
H-+[UCa8-23-N?OK3\K(ceH;;J(d#MFRg#;,/OXV>1@GJQ1L#e+&,SB3_D-<b(a_
Q>M7fe[TgU6Uf9/9+S1_^dQ5O7>E44CMZ5a,SU>\=QRZ^V2U4Mfg/1+AMV.gO&2-
B.X0f-CO][[#3ZQEC]aSKRSC8^b+;QX2We(IbSD6Z-7N[,>6KT/CH>,.4@9fa>84
G2MeGBZ7/VB1M91^>>;ARA>WX]>XL^HPX[U;HZ&dJb7XV9Z5(F]5L8&UDDKW>\DL
+OIS#I:&7_,XOTcV5N?LS_g?ISSVO??0E;--<FPI#=#2L_0OAaTcad@#B00#,M9[
A(a4XJB_;/A.PWZ=dN3)a6fPbPLEU]?R/K_3/\8^ID2aGeG6#1UYKI#)a/=E8LL^
(?2;5C[EI;JQU]Tf]VPCJU[JO)/Hb#U\4.^b4<92LBf.3N-O#&5b_45T17WGXQ7f
TNH1E8gC;^a\=DKC)_9f-3(7./Q?PA=6FJUXKa1KQW:)#:W@YR<[RcfI[gf0NTF-
K_[dPIE6:YHD(@d\FS8?Z4eBN7X?QW[>9/F<#eO@U9(W2Q>VD3,GcebSFXVJNB-#
U@_dKg2,7K7WQaJcIKZg)T/g(25I@;&D(IR7(b8_8aP6>TZd;S@&)Q;>\.@-Xb(&
1a=70P1\-233O-K8QE:E2U82\C<aT@Q)ggDf/<_Y@:]^bI5d_R9#Y6:KaA;G\6Tf
Ea-]^X7X&^-T>Fc22<>P[R9caF[e,:4NJ6.9QfWXRQ=0(WDaT(^X-eR6;;1+Lf^)
AP@@f1Yg\#ZIJeXF=F<aE=.T)MRV=XJ=0>R8JE-?D0Je,1[K[3)7+YP)V.4)<Uf^
VN-2Tcb004Q-M#7#;\2XO]a3(0G>N.]H2G4SW9fa,0Jc)PH-@Nf:&L\6M9XddN=>
NUX(]VaR+QQIf[F63/0E3U#V&>44]gPF51bC]KBJU/JQ2cAWDMASITU+Y.20+eeZ
LVJ#bE=7X;06\RS8e?T#N^e(U6(\#V4?,8@LPP4MRa5cUCF:fD5X.LE-g1,aZCLK
4M<F&KCMV,(I.>NB?88JT8LR+3S\8FG317)4=\:GBBH(GV4.1EO&ebHJbC&0b-6^
OYEgGJ=9NQ0(/FHO9-7R;SSEQJ98=V_48?bfL:d1Y[3./KCG#,C;DN\.+\;X?F&=
0GG+O[><CbDR7VHXaM\#,ND[XdL?.WKb5IQ130P02:X,8J?3BG&-5[+fc/@3ZC/R
V00c)=OULVOWg&I6J9R(B>fX,CYEP>]L4#-@^#KdR_F\I,4gQ_CKA63U//3I+J:L
LC>1:IME2[CJAGB8/-ddWJK9f0S&,2(LLS?XI6,TBBC[3Fad??#_aX4Qd,;eg;#8
_H7=C2+_^=FRB=W,@F-5V^K5ed7Z(.9=4&W?VI<:R5/OQa)H30-0]0_Lgd&Rc5T6
#,+ga?:20c>g@[1FdOEG.NKfFO7@#GR1^e+1UO>1)S,dG6gJMTK1RdBV<BUYYU&N
7,GeGWM8X&KDSa6VJ24deTRR31H+]06YESL^c0KAeJLS/D6B0]55&dI_7/V/@a6Z
W>g>Eb[A=R+.:cX1?MFLUYbHf4=c^T4RM)g+><^2=#W<0d:Q?2(7KCEDSX4/.MgK
^_D?dQU_)a;3+Y+KKM<10>W^<HF&;8RGUJ(2>Jd95B+S&<M?#E6/BA155<^e-f>(
RDb8^RcQFYJNK4-2KZ\=+.^[EZ-cU[,7X0B05Se,K:._F9J6WBS&73W=acDd)_U3
H_;ZOM\4@gc>9eGA^NQB6)/dAWEdEJeW(a^Ac]MfDdP3;QG&8b[60&#a&gce/CVd
2cIEN^3Zd.7>QRX^5,N1)4OeTH)>^[fcKd@J<_O5P>b@74@abH?H9c,1T)A]b/13
Y77=,^^a2\Y+3JV#[&UU(BMc5/2\S5T<P,Cf7[cY_5@3-GAD>eIdN=gF975\WJBH
EQ;I^VEYSZP(D\&6SUGa_ZFbSg+#4UG6M(0(-ERIFG#.L]4@]>e\L&0-Z@eULaUR
\PH+bOec?1D,=QA+:)?F5f_d1BfMa]-TY]+bg?c9BS.I;/<.9UX4:JT?&S,P>^cY
>dKSXXG]<ML\P<4@1Y,>AUQ[OZMg_Pf0Se+<HH/6M3Q9;7+b))=-]QZ4TM=9O?Z:
Z7_f-85eG?IP@5P]b:]@GNH6ca>fUb7;2^_Q&KL\+XaY)A@RPCQS31P>4+JeG)RR
=@XTGP)9b<R^IH>KbG42(a/EccUfGC,eK-(D9-S4FYL0[H/b_4E8&IGZBZP1g72O
M&NBMY:;P.g@GX^QXNO-M#7F^KT&1J@+(+de2P1.RgIA@@4U.\O\Ed_&/.1>C[9&
5H1IRQA<KC+G.^E#DYBJ.)4MMdC:FFZLSXC]J<WWRQ:G2PDD^9aLVWbY?70#c>#M
UQZ-3:0;G?[QSMd#DP[,g_[Y?3Rf@,LE7KQIA.)YEa5_S,#<MW#EQTHZ_PBC0829
03IB36R08KNJYT0?aS>EGa.Y/TIVA(QJ[)ZA0a<[aB<3+dWaIHaa[@WK4F5\S&Q-
B69>5NYZ:62;VSR^^cL]UOb11Z)T&7A5]ROM<&LJf^W_PL\ABK3B^<#<b4])WfD>
?d&LLL1+4e5B7/g,::9),S1N[P6&+RK]Pb;[2dK:#BKM-SS1f,QO?0WD6U;e4I_Z
eNf?RK1U69b.MgKX>#0M7;ba7ZAQYT20&/K7c&/X0SVg8N]F.JA^]@,Y^),_=]8Q
9NCf@+OPa69?c&Ce;R7;.KV;Q#&]\3&a7d;ZdF&1/06WJbAI4F(_&=Kd0+&eQ\.g
eN5c1A[L1+F190)3K4ME^-H1[(<D1AFHX#PUYU]VN-Q;YKN@:NA:M=&T/Z16QTPF
EJcFe5DU6(dAS+PGJ;-2L.LV:97TTXF&MMCS7:X;VWD8bF#2@<5@]3HZ[9T=5c:8
UdL1C+]ZU;WPQ2/Rb<X7a]UNO&RNY=FPY4LN8Jd+I=W8Q_9A=9>G8Z1>1G?/:F+d
9Cd5VV8Wf)Ce6PZ^<20B)<0c?OM,ND=2C4BXH;aNg6+Ra&6KfcBB6Z7K2DBT0#W4
E#Z#-e@fa@T4UKP9EMP&5-P.4g@D?([IY#:2V:PK=I\OQT9Y-B_>ee;IN#RASfD6
:J@bH+8>B?bL/+BK,=I:c2?6((CCfQOZHVMDBgOgSNI,^,](IHR^I?U2f<A#?^:F
K;/QRK)71+SM8,^I\a(VMC0T+1)9bV+XCLIcgPDRBUF1Ta_^\T:8YG+N>ZS6]eHg
=4@8Q:NQ[8b2=bHa3WbN+EWWcbXe.c@WV_bBe?Z52IW4gUIM4Md&M\93[Sd\[F,+
-SUZb2Lg&^D<W^Q(7G=0]RT0d[97afa[QZ65+02Zag8\^0g#I9Xf4\W4VQ>TdT3[
@ZSDCPXW=:/1=ed>D/\WD#&U2e&NA+d,X,N.HQ<=<Z>AUTc40]ZZVb_gLY1&<CKI
A,8?BD.D[;XSHI)KUd(C[Qd3R&>BYWQ:,KT+EO<AWXI+QTa77Kf;W2\9P;(YP2<Z
Q)Xa5#)GWY/P?2;GF^Ze@HXZ\<5EC]9)_S+CC[KQ[X_/@/@5QT)K\dL:4VI@daJ.
S4/OK?b&:Wg^ARM<.RNF^XLEJ32Z21;M7VFRTH&QP??V.0DcQTKF&;V@NUL@e][Q
]\O-:geS>AOaFV(G+DgJK(+@RP5E,2;eDC.IDSE8[\879WTD)S3ZUB3\eW+3>d@J
IYV-L:YZW])=S,f2\I/-E^KXB3&1UX5gd&W=70A[E>Z=3ZLdXIW<Q(MLf+HUf1K8
5_+Y)VBF9?g-#(CJHAJO4/HCEg>X&_Ia?EE;F]LIH#GH(ELF)<aJJ)UG-?AKg.8(
2.BX;1/d&Y?d^gS&0L]J<((I&6@I\cfHN326CS[:QJ2),@6B/G6bGE75c1D,[cU0
PcD?5@b+EVK&)[,>Ode)4-(2Cb..cPfC+7,M,_H5^CYP@-&eEY#IVeSL^LQ<&faV
Y-g<63&L+R/69C.\@PeKd7V]<QR?QEO?SC/gd;NA.Ta-Sf_eF8.IL0Ke7Q[3S(d3
F^:THaBf[gaF.@Sc24#5,56ZY90H9KM;OVg?G7@LJ&,@LgR&-cSL?dOgEIK-Ee&2
:YTH/KL>7fYS8fP@9#3&e>KQ0?P?B1<JSce.YFaa0WGdJaESRCG2UCKQ+.HLQ2-)
DUGf8:9)ec@C+65AeJ+;]efQ>[YDP@BD8c4HP6J,#MA^M\1/9c&H,FK\^T<OT-gW
L_M@EDY<B-VD3UfMNG;(O0^-P=WK.AW9&?X-,4(Z;]J&Qe?FH09IVE&X0/I\b=,K
L3P]O[gE)85AT()e38[L@@4f5:+R:AWcWN>J<&f1)C5d>I>)#4YD.-TFE)7I</=5
8JQVM.K]>&T,+9bJGf,US#+R(ea7ZZ4E1KE:YPTHM5SI&7@/XZ=8C/3\JHP2472H
C1S-.WA.0E3<0L2Fd>2Se\Y\aA??J0Xb[Q>W+HRZD4AA-=/P-OEJ=4)d4E=&V9bU
Yb5JO1.,R[aZ8B^S?295+a)-VeXNO>&c4bW.Yf90aB>)gNK#:Va-ObBW0I2:PT4.
3BWGG:E\f@;;2e=eF].bf;\^\[US(1OJJ2_GST:1#XBb#JdDb,A98.^R#=^gd&Hg
B.=,S.=/-faWF#;1\WI13<\U8_>#9I&Te;<SSH=)V#<K?7NK1T4bAZACg81g4K..
/A9GAD94</=]T>g=H-g=F0COYY\#^>)<^&?P.;a4f_5\HH],@O.KO/,M]+]7(SWB
c=-ENWc02ObN8=<;^f5J,K=^;)R@\Q?M;@:/=+1<;6EV(S1:b>_ENRa/a[0]X4]W
Q]T+C.F:)F.bOX;&&bf@23/SD8U&L)2TJ4I4KMSfg72(1QU@C<^<ad+OD-7EH>&+
]=NQ6<62gd)]JLS&K+U9K:_I(:A88b3>]@1<)CNd2W]#.O?(73/W7G@-F\\8JF#I
IcIILe8)g]E;JJVGG,GA:^Xc-(3&Y_B08D#ZI=YY.SST_-^Z=aEc9W5^U&E4YPaL
e]R55WW:f0^=A29BA8eE&FEYE/335-H&EaQE^\2S=e9eI^Rf?a8.M<XSVC;d^9I/
4@CV@PXSAJTCGB<f_]9E:SW+=MW@,(;DV5YNN.7Q\7#EC4@\S8CFb&AB7Ba_W;Xd
1bD(T6=@1FVF+\8bA+?bAZI#/UFA,39S1(c.2dHT,V]^9H.RVWcBYgB5+7,9XME9
WKUF(dbf4aK^5-HL#]0_7VTeT)7)#J.OR4[.#@DfF)Q[&B73).[Q&V<-H+VXSPS^
@8EB(;O^ZV3=./DK4T+B2OJ4,/_IENVYPU+HWc_N6U-F;<CTR8^0IgSA[@F/T[;U
&f@ZTW/^8Y4d\?_U1H-K[\V>R(GF4,<,15,f<V;FPbX^(;(NcRJ2I:^Ub</d;4;e
H\Lb&Wc4\,P9EX4,Fdb5CNg;+3:bJdRP?N]cTKg>2N#[Aa+LcU(8XV<IYM:8eZNT
H?],QX[2g_RHYV6eDE12M_=D3DJ^>#J_JSBc&7bX?DM/QRK/UV?A53PMBZf_YC]0
N_bVR6Cg3Z9eE,c@H?.4KNH]K)?BUW04)?FEBV^0QDGKQ0gdfS7;0cB7PUZ\ESVL
RH9(F?W@50bd[aHC>Vgb\LD\A0Y=/>1b+P27]0BV/1=6^UH)X]R>B=Db4KORgM=G
b<(DU0Yd:V2a^ac]V0@Og@>3]:V>(6=ZF?=.2I-,&#&JJ9U/c:<aZBH&[efXcb8P
O,>CBW2N_<Ie1:[]9R&/:P),..64#LJ3PM&4IZ.(2^[(4CY9_LVFHPDRV)O7P_);
JNeS7+VddIV,a[GZdTR6S2:d7+b)F3])faH&G>cJc6Q5d,Z0VE>>VLb+cG)>;bgJ
4I,fS+O<<eT(d\ZbS;b]BV?-OB8G5]A^JXD.(#,:4F;5@@^P7CS9aZ)XdT7aTF^@
dAgWCed5N==-=EY<UANa,)f?4J)OXCBS6WO^XXK/;67L8L]G]1<;N9G0#0];.<Z:
XgW1JD#NWb0)_+);]\Ud,(X(I1KVd:6V0B3F5D#B-]#\4#D+/I#DGg3:C6(?7IKO
G.S[LH5&G8G?.Jg;g&b+),7cD-=Eg]1L54GeF1]@P+@5]cTG5b;CTc?Jc.[B6^4L
I[1,HHEW[EOL^K&-&B&NYaSTX-QgVgL4dTX4=V5M&DSf>@58/KCN#=c&/HB>OU9,
61JY]SXA>1LMLWUI097HMb>H/Za@)4P/D)4.)K--9F+4)H,?,gF)-4bV@_aTbB=b
X:;IJVc,c>Ab=bG#UTE\GN-NcR=J=aA.LG7X(BIN@edf\W\-8-A=dEV<Q_bc;cIS
8Y)WgDEZ]WaGX@gQ06fZgbe[F\MagEbQTJ+IJR6]g=<1?YEWM^FI?c65;:CEI4eJ
D2W)5^31b43dU0R0^>N04[[dYH&0:)Q@g+3707==XZ[(B^115BTf(X3cB#UJUM8B
RU\[-L&=53@XLLBba9^_a_1SJ<5II&ERKCNfD3/GP+20RW)M694E[L9O>>=T85QQ
A;f293OEea(2WDO2P^Z-cXg<=<:,VR@1Td76Rg79(\^g_E7Z=/O>V[)4_2_WIV#>
<a8+LTfZ_UVA\V\V?M4T:>2H[)A>&OX/7O3MC([Y.4,f.L\84T.2a/c09NZ,A>2_
P0H84\/VA6+N?KcDT68gV^N=43g2ERXFBU+9QPd70:=+<fS.JbBTVO\a5We(a>e;
+]LD[&2JZZ/YTA/eO2#F#I]aP\GS>&,<;17?g8\M.()(&U;>UM&=_-DJ26&T]LQ5
.G3V>MN?g8&U&K.;P(SZ5c-E6,8<gT_=:gC3.Gf=Rbe5[=b]eVH=?FY8WQ+WdJ0>
=b;6F1ER?.?+acH@fg@>YRaR7beK@]3,AHe;B.[JVCG-@@,Q@.NI\2<568R1,^Z_
D\4]d)If_:#5#&eM7b\EDYe]>_\aLN:;BMc.a+S;[cgS?H3Vc6=_g6&AG4^b;^<:
1YMX[+HbB.4A=O/=0-OeAX1YLZ8cTJZ-c8WDa#aa7YeFSICHA(TIN)gZO6N<.a@+
(AWJ-0SNUBD441bg+B=gNQ)]VXM-P&4X8^-@DSGN_UZY2(1YP9OX&O>Z..T:/aJ)
NZ1c.:)P<fHZa1LTR>^GH0PJY];/UMBXAS[13AIb^<G14\\bIab)=NN_/gdagG<:
(-J]<Hag#NUR/0f4f<_2a6\cdZP+@)<R))&OZ+gY8&T,=LTG@fXPV?eM[/.GfSKP
/b^A,Cc@[PRGWMYK:aB+bb:f[0@O+4a3P;>5]_<4b=g?F@TU+Tb[@O:Qb:5@Z],C
_ZaDMP/(5Tcbfe]WKSY+D+50>/7))E>/68S6Od2S&ASS6<D_P?CZE:@,-IUTPf[.
Ub?Q;2JJHf<+I4//IJRIQZg=I/.-^)(2K[2.=&b7cgY]T++:),;./<W9G5]TeW<G
NVW.H5@+#UBOB/Q#J4#S4,4G30-Nf-#Cd?([)c+6^;fRE\Ig:?O)D;(I@\=QH\OL
BH,,_@IF#Q[U),[PQ_TWY-a73@BA^9Z,1eGY,K5PZ/55/F2OHQEJ;>f@C(5U81L@
#^e/@76SLU/V4TJDLe0c#@O>>eOU(V>6U27VPfV]9HKY:L.B+&gBe;+GXZS5@DgY
^DE(aLMVXUBOG)e?Z,7RR99VA_ZNG>6Q?=d2A[K29Gg:f=Q,OOEHH@;dbW8JKe))
)F_Qc4f8NTB(PMY51LeaW^4dW2YG6eU:\I+B4Ab:b&X&^RJC[UO@MYeX_^LCc+=<
921eTg4BXZLO.N&HI1)@2BJORIPV<B\KWDf8CJbIgL7+#O9&M?NgLb_T(1#/;[O8
YEIV8UJGB(g=bOA)f)Ua03HS&,2Y_XA;=^CP9[eLUJFg-#B7a>_UM4F87c9E4cB2
IVWcLa.6I81SI<V.N_Q5aTZ=RE/\X8fKIE?E=P2<0H6ebOFb;.W;Mg3_3T\BaPPL
c/I_B@38TTP^1@B-g)KK,gPWRWQ[-J=(2.OV]@^/GBb&a(e5(=^>55&6CJ?2N+0)
#Q,.OHd&SgX/f4?UfgP4L9P:CW:)bWW+AZ@F-/Y7D1\V<C.X3@b\9b-N?75?-b0;
JNS1;7#XGO-MKY0J\M)J7#K.L39d?5:34LFRCUb6M@g;[?[<@CGDUQZB^12ADD\1
;BT1IE#[W4Y#X79&T-.(L@<0,UFc2R].+6B-5SI(Aa@3c,6D#9F:LP4)5WV9,+dP
A3R??gU,-+Yfe^:aJ,,9O5CeC2cJ]6[;-Q<.1f\PPZ)1c0]4[5[=)QK#6bbCScJC
IRY##2eWOP^:TL(H3YdWeJ&7CILdUJ<#KUWGa@4\(66,N<7fF7c016,,0EZ>Xa8U
@WUH@.6)K/K>A5^1WXSW<85GC_,[9EbFabS1<==4^[;ePZOK:SJQH,#+AfV]MTNC
F9:J_G=\K7DJ@#XCB)#LK54_TDUK=0g1I+L-0?:?=#E\3f-Z:0J_GE>6^H]#&fW]
b=R[0FHd^1L]AGbN?59<6T.)+BY2?7?A[_0.7\B9#VB[?7f5#@<5P95=aW2_MeHT
KXb<&eZ>;;M?=eJ&2fLcB#=eF>A2?PI,<Xb[LB.^-Y=g+I14cVLCAK/Q-JMSe&/G
->YBC5M=29@\[e]JdN^5\XDR_aXfT)NMG[K)2f@VSPNL^#=IdV-]G6B:[T-bE3<[
X4XK]RN1,]8>0OJ[5Q&e0ROQ8DGM20<aPQM=\&DgY:;I^^\(EC\QS>Q)E(#.?ccW
X@2S7H6->4MXbGg6f23AH(3IF0&G66)M+FNOVX>QUS2D4gSEfW52\?9EfLQMbN0=
X-;UBeIB2M>4a??#T3BRa.V^-[8Df144gF[8?9M:d:\4SVK/e[_g)-K2c9[?14G4
7LQ-a#CW-Z-fR3];<T(\N@/]?SEcK(?;SPb)_R,=X7cRSLHP6RPXD+&8W_=&G,eN
6Db_:HB0QKa<2#IF54dWUF[YM4Y[TLS-M68QJ<+0XETa1SQW#9<Ma\:7]#>GNbcX
SBVP-<f5d-E:+7&\:4&T=HWSZA,_#ES+SW^b1,eB77F0gEaTDWE7OQ2S.U_GBFZ5
Wc^2A>/(7B7;g08M7(E]7MQ@d,MDQB-a:b(\D.K^-K+BBNQ.Oc]E=[9f2<?4g<:)
Ke)Eaeb:0,cZ=3H1,F:T3Xg(5C@aAde?f&(UHR6.d=c@VZY>RP=6LABR48bbCKP7
dW+\(Z>bK2D8\6<?]_Nb>SV>dIC3_>7([<IUGc3^70F[/,gPO8QRc5J^8U<M(_eC
3bQU>\#/9/66[E_UKdcFeV?L:3O)89[6L._><FCNZcbc62^gVY@3.46b=5=AP:)F
CI-WKRTfJ^/DU/RafIc@Y3O^YZVTAGe.6S:fd59UD,9<Z/7PTRcgV3,GVV&gXC8/
CQQ#VYA,Dabd\(7>90PG#K:g2]0)Z/DTY7):=O.L^cC4H6f0(>aHK:#2D[Jc,RA4
L/&f;ES&LOJHVR#>b)-;>V64LIf4/T3OQWLdDJgK3?c)Ge=<VY_#N\DRE+,?=dE8
9MJQZ0[[^B<ZJ+Ee(]?]eXR8A/B/bKaJMUK6eV-/)GDQ<f]QGTWV5CH&Z+Id,?95
NV>7EB^Y@8AJ<.C^b.b\-;)I(C1RRA&4-))@=HKMdSTN?@YBF]&B=>[\&TO--6#9
C^#C6Mg0FMEa,6;?OBXV#NWY#WL.6Rf1VX;FfAXJ>0,^4E,I6S<)8SL=R@Z_EP,L
1>JB4/#[N6a+[d49(KIQ=eYY:-EReU5NZD]CT0&=]G8Xb_)S@;+@K4I^\aS>Cc5/
7cgQSHX6Cf2.L3);^Wc;,==])WU^gN0,2gB5&^\T?cPX^C]4[:HBe0V)JGY9Y2NM
T6Y[DKEHD?U/cPBH-E-(4<U^g>5FTAXGbNA4B7:T:M0c,LE<+7QT39^e?eaKQ:XY
-6THSceXPI3Y3g>c[T:KLU\4+5^\-]T.4@EeZR2d^=[+:[II98cJJ_g#CT_A-;0^
ce+f&PR3U0eS/V9Y=5DbPI5T?dbMKDcR.][STbPL6.1g[&SG6T97+8RcY#I\<RBC
Ee_CY.29Y=KcgGTcL.=Vg7B=c2/,/9fJ_<SIU?S=Z99,BA<P&AH;-e(2LEEfYF/4
Q<aCA?+H14A.9E-8ZLVZG:9>P@0V-S+Ce)^B_EG6Q5NY;:.1,LPJQAT/:c<)9P#M
[GC(UB@&-cZ/K+]Nb6BO5BZT?V8RNf_&BS=9R[2,>:H?[Sd:@5TR[OV(E9DdVWM/
G.[K73cTEa]gQL^@1[W7R7@F.c)J#ZRaO_FF,cO(FdAH[a&KBE[>G1=P/4#4E:6e
ZS?FJ?0L./XP<.CLW,d;[ZbE.5_?R2&>;.XP)RT20g9M++Y(#XN=c[eZWS,Y6H8-
3^[Y80CV&I0g@DS<GWPL/7\-YCNN:-[2T6J1L16;I1L)86]OP\&Dg1e^7FCG7)W6
3D_?#S>CU8D\#E=2(F;>a\8Ze@O)K=;0^D939^[2J3[O@?(EX1J57Y@E8]\508B-
BNPHR-f3f[\,8b-d>NK@gb;Q:_H^eUfSIUKJ9-[2cZLPQ&K6UV6#B97DRB>Ee_^-
=\9<QLJZ14@NC=Y.bB?-,A1UdPIK25=MKPQ7YI_]@[#0SC6TZ^9bSQcQI56EE,MH
K5)1Pb#0Hf_=edJDG3.9OCN(K_#-_&42<F[(IeYX?>4aO:)NWSUV&+VY<7G57PE3
@ZQ/^b;0R-CL6)aM2>ZdT4B5UKR)78Tg74e\AdBKBePR.4#c6?:)gE4LWbR=^<:/
8MV-fQIVR(TBfgf>W8[LXeGBD=22GY]G7YdE\65L\R)WJ@A:Vf3GM2\39;0.b7EH
C?VMc:OD)4:Q5,.9(</_&2,&;4@gYPO:Y-;\3:b7&gd[;4KGGRc\,/>,;.[/(>R/
L8&FacV^fN87:GfK5FG9g@^L0PU^eA@PB(R+1V-JaaVg]?CFYU8bKTQC5gUG^B_4
9,Y?YNWRZ@_[B+KP)W?2@G+JU:+=1:=_Oe^S>_g#JDSZWRbd6X]KV;<0NPQZTYPU
7A:2IaDZ2M<3f;X&M\G(-A##XCW27.E9D_C12fYAKF=24ZP7-&TEI^]cW;=?XK1f
9+f<Z4EMELCPS.3g=+>abY>-\T<U4aJ=JcUfT?DcS0fU<[;Ta+(Q4WO</P8]NP(c
F#BJHGO+d]5>6?-?#+VD]<F8,8[@C/&M)I#Y7.[YO@:I3_XHH\,JZc11>U0CW)NZ
QVCT)bU3(D)[[I[XTac+_:^,_EQB_5\LF)C.HH_BaJ98Gbc^-7(&\.&6d]4>RF9R
2BXN)Wc-OUH^9S?7D^&&#5+aM<:O@f_f#+A\e__MMC1XXD6NI?++9?.O4>I\H2).
?[Ud]=IdC=9f+V6W/C1gO9U:==XNS16[Z?Y29E8;=L-VYXZLTg,>\V>3<U:gb.)K
c>bK7[8Jf14a1-/ZaGVIZRX_6^aPd@Y<^KU6ZR=b<@\7JNbOFb\f]DXUdUV5YVHC
&(3aHG>[K=GW5Y)/Xg.5\\7^g2<+P:g;RH12X6PAQU0+CUg[e1N.cag,1B6&H\>]
ML3OTPEL7bf\N#/J^fd;748[\#R/<NVa]>JJa?5+N,,36^+C.,H3XV/6K[&W,H#V
g>O:d6^]6e^\ZeKV4YWB&HGK4a8_WC#Y<G;KY3A_JUC0KUOQb)JcQFF0=58UQ<9#
@L\2I:ZUZ)/@#[e2_e<aCU?<4U?HTG\U9/_<?@<TIJMYP)1+b.-X2VAZPfPFWIEe
PaOFI..\N:-#ZXA2E4:[,3(?9:.fJI59WDg4PE\>gC9#6SECe:bR,.75Q>99@bB@
BL4SO0_<ARF0:PPS/eB]IM.dPEHUfK<aQ0[[WA)3I:VXSUW?We/gA,]PCI4LCc.&
,a:7XRf<WS?Id6L\/[,#8,O>a5,L=B<(?g5)G.\gU@Z/Pf(H?/1eWU/SY;J9//Pg
PYG/FD]Ia,+9:VK.#4:0M2f:a:)32A9d?SZ-FX[.J-]2IZ.+\F_XXa.:67GIA-1T
)4BINTQ&YU;gVJVXE9L14-7:C[fW[VH[QD>8+HJ^fRE98=QeY];G0c6f>c^I<M==
0TbX4&T8I.#XUd/RT9EE-0LG0eDX8TLDVYd>eVc]f/-OWCfHDR@B=cZX#Vc7D1/K
^LJDQ?9&3::L?>3[FUG6Xa#M3Q,;67OdO&OTJV6#aHO-MVcaf.=]6NQQXQ\Y_1#1
@\KYK^NZfJ<MaPLA,NR>@AGER71f+gZ^M9aHeMZ^&U=M,G[,W&(X/2>a5?3Q]U(T
1(H?JUI@#ee:A<R[Og.H&JE<@]CXUdH((-\,:TF9?(I6-&8(4T<E@/g0HggS<GQJ
Vaa44=[<BU4C+(]Me-HKWIQM=CUee.>N-0fX7E1YN1NgJ)0PcD8EeG7?>P7G?Dc3
e1WFS?AE(5GF<J<-NC,KSM9gJTXX@CKb&>3P?PU^@D5H\?;UTGGET:_ABg01)I3F
IC(Z8383eXJ;Sb<A:[gMeL)c#8IQYZH-?4,SLS8=#@MV^]Ac^#@a,F+YZ<.6@LaU
;,MQ.gX,22V<?9NF2[H)/8;g^+<K2:)W=X)D,@cO<.RH-EY/HXUb^R2g36DLX]1W
:.1L8VIRCQ:8DL=BHe+H0]#dY)OZ&@08I@S.-7XB6ZP]&3L&Z790aXA/HE?)Fd=T
K)<eb[W7)gW=0fY3HLRGeg?5EAdZMOXN+.9H?>_7VJGT+V?)W)_2.\B&FUU)b,Yc
3(-A<F:X-J<V(579C,I()T?F2S#R+>1gAK&/<^Te;A)B\/>Z?5\0RFR,9EQ1FXEf
M5>@22JcYODc<TMMY&H\(N88)L>gG,5D3IW_Rg3HUHSfOa?G<-IR#XZ4][ACN?>4
GZX(Q/KV25GG39F,?67>(F2J9@f66O2CDS/:Gf4bJBCfM@FSQAbP#-W#0&@ea+-#
FFUG8B_Q9VHaK[S[O\HIJe48-6B;fLSN>U3He5\f\?gd@WA1:Gg7GF(^,CRE8Y=>
EX\_f\&b0ZaMZ\JM-=d3-@T]IKZdT>e8FDe^,S()YOaI0QL[\,GYI+[D:.#,G-A9
W:=6C.)[-09UR:3R5VITff,&,MAaeP;5K1T#[bLb1?0NS=a<I)9KI:K&La>4PFLS
([\L/Ea(+>JaHVR2A#RIJ#/g&;fg7D859\_6ZWYe/:^)9YbWeX+.d6/XV@fHd^;\
E1H^+9G_+3TG1-3L]]#;WT8WV)YY_P:@)SU-GKVKb3^4dTHed<2+KTA,NQZgC5MT
+/H\H:X;TgHJ7./C>O>B>IT3.0;UDUdR>g]IR(:\OO555GEY;+]JdY(1^cV@:#F7
c^ICS[e]>+W]O:R66Q?/a)IZ@<W-3)6+aBWCNR9W(NE2\Af)G&M)>9E<)#9T2fVY
:<NOLIbGY=D]FT8-=KY2E\JJ@+:c/0<IRCQ#TZ0&-RYSY+5=gB^(;>8[dXdJ8,0e
8LaECKW&1C2]eH,WRGI6X=G=g#9)0VMB>)(>3E=JJ6R?BeOPL\(Y@INf(;[@c/-&
X^VE<2gAOW\J/c2e+=\:A<KK-V@/4AaGMW5H,eKa+T7)31fYYGf<IbX,JJ>;OY/V
[C6Sc<W0SC3#AXHK5MPc(^CV&N0ND,L44A<QSUQV[E(KM@875KaXL?#[ZG:D6DUK
>./,?FWg1EWRS]><75/L^6Rb/)>H9d)\<2Y&3bMP0bDY]C;()GT#dB15fCL62P(:
#g)(#W@\K)3H@_a=Ag&L^N2.8#-aTeN7M(_1#7X]-MF7&fNdNbT@a0f<3H)VRaM[
F,YIRGYO>N9=G9fT--/EMR\EbU1dLE[00[R,PR].+#Q>>XU([J9>9>LKW]7MMd46
>>Z;:4#ZUK-N#ZUgfEEN50?6V?<LRfVVE+WRa_;6ZVMEYPSP15H@U4[ZC/9:1ZB(
1cE[86ZG1JIPM^[J86FgT[[Ee;M(NZ=?]ZV^bY9ZP:<843]5)2AIL,KY@F72LdL9
?/@F@eVPUIY<TPTfX<^(#ZB[feJVOQTC8,AJY+?gXD4YL+gJWf[g=PWYMbTSPOLf
+FZKEZR6&P(WU[4e-X:-K_Z=F4\;UQB6CdYTcN[;[SD^8bM<@V(0-,O@#;5SWS3\
:84&Z#H?@7J^c+,PN/5,+bd+OS5F]35=3OIP^NGcHgEBD^+HT0F<V<N94N<,QRE#
,@BK&;F0?BSK_+--LK/9N9/B1[6SS_>>.UWH/AX&HEJHW:&.Z)GU40]2S^7GF:MR
fKULI^N9OP.2K-PY3C#EIQ+^I^RV9QZ+6L/:a00=<aZ]#1Re_>#0-eUBSW:TDTbc
6IZ4.EO<cM](Y\gf;PO-98VeLfV+.36gMT\5[JJZ;/^+@CC6&T1K12HY79K;)c8^
L,]Q?(RAC)(1:-.K[W_E].IHaYQC1F.>1OH-8^ZL5TOR8Za(aBSG^&aY58_I^A2L
aNR38KY1Q/VQF)N^BAeB1Lb0(=<:B2Zg7CY-3I(P,K/De9K>Ga[D<OJHG6<<>CU6
eWN]26XNVB7/]8J(Rb2(G^Z?SDTTH](G\cYe+&\Y@9<KZ8TaEXCAQ0XcJe]=,F2?
::L#@EKPH4D\5WQC>WVPZ@fSEWZ1/&VGKG[(1)eTX\R(>X@MN,KY5<<+.:>J;U=R
&?1a7Q+=Lfcb1O-=6^:CE&f)g&<U_A,-HSK/^B(#DBLbF;bR;(NG>K_0,F;(D+;]
QdP..N0C>b3;7TWI\LA#/R41TJ?Fe:Dc1DI3e/;:S3e-)1_D<\]cJ;H4IX&#[2-3
SI(I_SY7:?MdT.=72(ENPQ9WP2EPB1.;QJSCT.RWa?\D)51/?dC;<1_LfC;1)GN>
/2>db7gMaO&Qd]/]d@^bVUJV>eb2#D:80N[I));D\^e=WLS,-RX9:cYAZ/a<4X#5
Zg,Qabe&,F@_<8^X[3dKSb8Je2D)B-[)3X=<V?_-022R@;>FB/PO\bJdL2V2^B,U
eTXO/D05<bJ,e_EDAMdF5?2_(@5De0>cdP3f+^25f@PCR_<J@Qg)/]SKL,Pf_O0D
?7J>8e)).X&Q1\YEM4UU5C<=08&DDaQ8CbGF<,>;d;[]J&./(^f&[cMe(Y3e4<Xd
C:2\LOI7V8We7^GFT>654B^[F3,\/V),JM0N[aNM@>>VF,:>H?0bG;UL:VMM@#4O
/]>&LS^e5H7SIMg:6])(cYLS?8bH_+2Cg#M6-WE?#-=+Og/_WaI9B@>([4YUM5H3
WV+:LL/OV>8[^[4GEI<;#ZV_P.)A8036\(dH[S[Y/>[KX^?HBP<X&+IF-]&b]R-f
3)F,JF_^#1H9-W^e(M0+Q7(#21:<2PXa>AF-cPeD:C,M=T;b2Y>0bOMJ(VUY@8Q2
II]aFR8FI]<XRR1]c)HRTV>IbP07;-LEDMW/P..)IEV2fO7+SXKD=E\KC/1LZ9@D
N5fG=K[_)6<;IU\7<DDR<8N2e0RAH(+1T<09YQS#JfI@INZ+A3;,<;8f.=NJJXE@
=c8IGQ<c-8dgIDZ8NYV6S5NLE1B<L?,,Yaa1;=8NVE\Ud0PTW_S3#Q+]=I<7=0JF
QU(?:H\W5C]F,B^2gM[-_F1JG92O;(<L4C3N)(_b/c/2/>Ha0FN:c&3=N^d+>5)1
Z7AHEKda^T6^SSL,L^B-0a>e2E.2__4EH4)Pc,584GUNeH=-&;GNB.VW9I,#^Zf7
R_fD,H7EN+^I];](YcV5ZII?:b-5DH[LDd0G83:dSY(0,\TGB?HT-LP.GXG@AZ9I
^(gd?P,?+613[G<]ST)5bUAc3R;>#_TF]62>1OIWCP6gE@eD9.RQA.Z.^4=?)\#d
/2YY]WC#f(MDdCSY/8JZ,[LaM#cE1Q9,<UI9?/g:Gb]dUC/]],R-OD,]XYJg8/bQ
ZbP:W[>(^bK)+#KIEPJB0:6]TM:JG]YLNG.O?JIcP;UU^TDFD,,]BB_PZ&ebgK.-
^JBPgJe.VV[KbfR_U0+F-B8b\1LR<8&<^L^9KM8c88)28I+7=;e2\C<,D42YWceJ
-E\D-P#UNDRS\M5@_)?1PE:GGA[;:3-5A8?>I/XaMVgM+=9Z(X.(/ca/.G^c^bAd
Sg:_^YEJ)f_]A+X-dMN,H;^&+Zd/QALNbSV@5A(;T#@)J<R8EH1R^[=.^eL6K;87
g:2,Nga^f6A6/GPRbgTKZO]aH0&M^/L5#bPdD^cb#H3D4BDW:IKAZ:MBB2:HA4&K
+=NYK(HJ]0_gb,^<([(Oa5H.YN4Y2CJ-6KZS6^Lg8&^N(Y(;X&Z8S@\COeKU=cdI
#@=OAQWcXF#ed/MW;=/A^VcD=.PMX/GeA\9>?)X\IE1a=b(@(:A+V\M(3>UH9#^F
O:V461@<MV1XN>2I&&f(49N<5[Q^U[ILG3X+1c)6OD75<ANDW#+UPWZ7g42a@0Ve
U(1&3_Nbd^\-BV.G^6:@0K>[1Xe7TN,eVM]B@bg)D..T.dA.?V@]e3<G_gCc&O,I
FaP89+2RP?UO,9.37O2&:R]Z\QY6O0F3XS:2C-&S#b3/;7e6Z\1<_:?\?0I.eXgG
>A^):H4_&3+A4(RPfIOF/4JVBZG?Oc6-a>S.SQU&J2-4A9-Rd/;D,\>FbP5BLOa^
\?<6[)RD]7KTK4f4)4Xa(69G6LQ=2-/0cMG55X-LLJRa?)>c?D38?)=fWKYL#T02
+(MGYF9[<M/+L##8[fXJ3>L/A+(C85QR_;+\S^I=5HDCW>K3B;CES+NGHb\fL&,0
:WXX._B2)Ee[>/_fM-(2S:dER/V.dIJRR6W@Q[UG>=2cf>DS^g)Fb+:14TZ=6N#3
9\XCU=<b^.>(M>;f)81a@)C8S?5YBN^XDP=JBUY/JMJ;\7I#.1cPc44G(D_;RB5+
3GaRTP,613<<XdCP<XZ)bAe-6:+L2(Mf_Z0P,?_#aegO]DJ:-;>\1FBAeW9#a0?[
(?>_G/#LT,F^?XTdPH&3H=&;S^WY?=OZcY(IQLMUc2[-.EU412Ed,^#9b<<^fUG@
?<<4M)N;>g3AVOUJAP9aPHMA.e@Yg+=D)Y^KRJ],7Pb6)b_bWC2>P=#2U(2Q+:X)
/;)OgQL8HaPE[F@T]a0eDF5,bcZAFI><)TZD/X\W2fd]KXJcBFJ<B52<W)6,BU<>
^7=)Nc[G)T=5gFdOG_QV@HA/_HMcgM97\+L:=1/2]+#RS;>X?B:W4X[T>O]UHSD;
OFLUSTc1.58B><IV&H8RP5+0UIA3>d7#=RG3H)+Wab/=_-\d6?bUZ]PZWUOc;3I_
AaOcIK&.M>U2c1]D/O2fdGbR#7<;GKMLBS41JgMQK98U-3.[_^JE2XJ[&9BV4eD0
,]/&6[N)N-Y2bKW\9I-[+-Fd1Nb63c3+dV,KZW:MBS:5AObgFgS+Z;G;Qg;<\g1F
0UPHCT+<AQJS_^P9J2Q-GO@2/Y/+BMb,L<AQ&IU<g5QIWE3PS&],@)HaC1NR;gG[
=Y,./S0dAR:K0_>2LAZ>S3HM<FZ8.7UaFPHc-AW0_/MaKAFQ2Y;TB9;Z7g9<&76D
c3Lca[HeIHW8(KK(BN0LYXVYQGZb\TDBW-&-[2X.LZ9O<d<PW9.3;5Pf/?B#>B?.
KG-0<gU;YE(\f@L7e15YUD00[C:)\,;a4ZJSC6:]/[4+;Q0g?UUAa#P<])4cHC(.
?N6e3+GKJW[O>Q#&OC/L#_&H9_X_g3&G8CX)>ObBda@Z4aLCg>4PgG[?(;A.B]DA
/c:=^@eMF;e9XbN&K)TR<&3#KVO^5EB)TUCZ#5fEGf4B0?NdfF?f[]W49D/#L&;0
dQ6DVC-+HK=@E>c?_26K4YIMUd7cfH(XX@?^[X&&.>/SbNEXGf<+g0/I:)Obg7IQ
(5+Y^AUN+J7WVV7Kd4-[-^S+PK1;\YEPG/5<_>^d_eCdc>-+];.UTMaGBKNYNG+8
dT@JT=H?[PVdM_)[b@cYU-bR/9L4==4]EH;+7_9a2,+]/QR-L(;G...e&\\EB]\T
P2MRM+^,EI)]Je2+DDJ\+QD]NaC[FV_RH<#e(^+=FVSNC/OQ@&c;+5@=I8dP?<c[
,Rd&@ER4:WVf>Q#5GV2+I+6R<E)>^9:g0ER<](WKC0bOO.:WcP8/D3(#[&Ad)9TK
M6Q8DW81-KeFR-I7ac=@g\6TV,g]A9ZNQ2d1S74Z/.&V1WP\_.Q_W-MRMNOTX/?=
/?L[4+SR#N,>5N6@=@C(8C5aH>SVe]<W4:bb\11ISQL#/N@6/8G_FFO0DIdIPKgd
X5Oa3cdXU30#//c?K.GJ-U=Kd3()+.<BEeY6A>K.e=f+AAA,U@b]fdGO@Ee0Za,Z
c@1#]G6UgD-#KYgefd@T2f6_cO.4&LEO<gG,]5<NgeW2OKC]1/]@,\D6TVbcIcI&
YM(Z6-cCRc/FK_cES;_=I.[P6)aSC\IfVSR:GI(YcOFP?3JE9Q6:LN.H-+dM+7=S
ML9bN[b9ecL2B_:2BYC7bXfg#FOA;Uc[Ia/;L^6a[LTNYVB7L))/:=M,()27&Xa-
+2+Ie?,_9+/EOI^#PF^^DXG_RTGRUdY&X)8LV@VWI=->LfW7f49_1QJGaSK_PAEI
8M94C:5V=(WG&N\6X[&AHJDaaAOT>?aM#K2N^PNJPH)V)dW9=_1/G=6FDeNG;5\a
M)QLU5I:ZHb;M(fK^8BTA]-WAaAS(+Vd:2(R>ALf9LFB.@LI?:dF8L^MD>-;7IE2
P8F\fHE@AfE;LUTQM6XBQS2]=a3];NA]N(@Ta2V#VHd9\Pd6C>.49Y0P^-LVYf;/
6<THJTL>1KSI/aI6YBM)c;c33(M>\OdH^/0=M<W9/320;))H;C:,dL#3JX8Q@d4E
0FXBI](Z&39L^_g5QL;;B/B0E,I+(bbe(g]f6ONP_b16EC.6\Y>Y;Yf.-DLcMK<2
AJgR3TXNMf_E.WU]c#8QQY>f(_@+IL6\L167>T1Y[&5[X,L40:(,=8ILY&[)ZPXD
A]SbaBY/>fVRRg)f]/@dSSgFIW-VXEf<,S=@422bc,G8L8WXDGWQJ2[9^b@?ZJ.2
TY&/OdPRKfUcI=B[)=0=X__<<Mb;P>9-cQLFf&ZAebb0a]f,-,S7Z:S+XH&W9+P7
<FbZ>QJ\UV^1V)K8-,M.EcGFVHEX,1&=?P4Ia;cTSUX.YNLfF&-3<L+#\KS^XOR5
-VRELM;_05V8\(WdcW#]9W#CL)?D#?7LCN8_-,EB&]fF6Te8-eX+^TD7B:EO\(Vc
f&+0aG\I7Y\K=bea_aYg8/e0JeA1W15>B[P@;9)M9>fc_2^A6SJ,b^a\(Z\^(0>+
8?U1N>Pa[X(Ff1I?@7S8&>0D=)_M,LG_bHM/9&06/,/=bGSG+Y_#+JL&J&T4/Igg
(E[,bPd^3+fD,UX86bRN>?gR+66.R/<Q41T?XBO\L4c4c\7^0MU(&:b-\PP5#\^H
R8;aI_,7ZBc+?IO+SPZ8Aa3T(cUW-EJRdUE>5@#gD528CA;5Yc_B=/I3/@fb?D)J
=Y[dA9OJD#&)(Va4@7>(U[&VSVJDc#+:TVe(-b3ZHJ+d<egf&T\aH^;S]B9b.)H<
.M\bcD/]6WX4]\L2TWYfGNfRba7/W5]@943?@/(O[Z_C;0@Z>L]^.[/+<JMVgaNZ
D1NG9CW7F74\7(YD@AdBG#_CM[12DC:_@-J^4Y4J\BC:21Q><?X+Q5#aV/;<Pg4B
VSM=N]7T]U.;#PNDCbLHO+.DRYed:Gb8HQ;UK1>DHY/d+d-01YG<#+g:Bc/Y0/^6
c(-+E^F,IL>.:YB9YQ0)ZUgN])dG[&[>TK)CXeH#?Z_O?d+5U=PA,XFe&S)0c?LL
<A,_JZOgYRb@P(>N=WDJU2:R3@BR_NJ+?R@B>L&R#RGG>_d1?^4H==]:9U3OIgB[
+)&V1[A/CF41J?[<D][?g+eCFLV#KHDL<:Sb:bGFC/W#YWe[UT^.e50J<9R03RK=
.XN9.B>a3N\A[cIc+dVJ4I4-/GbV_9#HV8Ua2V7E\?(5X,U3IB8gPIASOcD=Q3;e
\bS98T-99HF0.>@=Of(CdbZ[;deeRX@K<1TZ)1?TTe7]+Lf^X>=E7AGS,S-@\a9P
];7Be460]BH@SO9c0^F#CA6Y?bb,WLKW:E,]PK9]H7=Mf=GgD&V6Z]SNQ:[A;2(0
>:X[gcKJ1QC32VUN7Y2aKC&@;HBg7b.MJDY;&0c6bXY=RVCR;<NAcV([.Qf[<(Bd
g.WVeAGLg/RK@?2583H8f<fB2c[FA2cBY0I&?.LPE37TUM;9SdN>9YXR)HBdO3E?
6_XIXVHKPPSdcg1^0a5_0NZ/]^?edEJb)R.)I]=;.IVO->3+KYPDK/1)V/c-;B6H
-2R8?(K72aE2d]4/XTZA9HX<KZ/5<XTV_:0^O+.DG&ga>FcDg4I5+g#?=DJ4YEOA
LB,V.3J0]5S1<D]1?ePbW]B#O85Lg]@MaLA21:3#FU8g8aS<M-K2<3F;=I0EKeS2
Y;:TL)5A(_GNW@,W4-4?GDSHX)KZMOPKC<A]D5(\fTdN-CMd3ME6?UISbCZE58?B
A_^.Z;,Wg^2=R8C3RW,VaAISG]f#F]J\=Q:(S;1/g[0PR0)ga3_:ZN^aF_UHEVe\
eP<;N5_<UaA2@PeT4cZ_.:L)b8EB3NOB=>4SMeMc;-bCaM1=F80(BW5?NT)@_9-&
R.3g@J8:Dg4;bdT(3/M?2J/XD#RTcbI/9cFdK\._6J(H5/A/\<HY3>S5a=J=5E5C
f,N+Cc68R-=BCH]7[e.&I>Gec2KH.(B.+@R/cJ(HA//X#X/R8M6eJ1fV2LE6UM&U
E&a?CeF-Q+T5GbCDCOE(&/)]17O^^g)d<[8BIf[^=K=?(;e6ANF88M08O<GWZCCb
7-LME7D^[4dI-b-cCY@Zb=<DCg:PZeA_=#M2FOIR(?,PAec=WO7N::LVL[CZgCDg
PRSNS@UCWbM2,8+?H+K&(cc/PU^&,PI#0.OLfe>fTV>>6@4B)KI;6KU-##OO7a+I
2R.?R_K<f@RUYB_.73K9(8CLA:CK31GXBX?S+Tb8M6P[8FOQFc-0PSQ16+^7@c53
g-7CTf(PU]X)g-Z+5I70>YEWX]VS(L+<1aC4>O>>FHe;;5T>M]H2YD40J/PK_9ZW
:D_2,IXD9@=I.NYQ[7LWDF&>T:T;;FHa6@03HeMc[7[JKQ#7I2-]?O>DC\_1-X;P
+0AGFIA>QG1,;34Z.?<(6>[[(BN;F.eg@g#Lf6[1b&DGfg;_C4<L<PFV]+4#W?M6
a1M;PE-B=f.4KXM0>R76/ZP?,f:02:CQ[A7>BAC89S@2HV4B?V:YNAMMX=J?1NO3
D[(.=fY&/O09^dEN.@X:ffScY<C)5eE>B1[J92SZ=fe/7fV2UY<TE0U@9AS#I15R
2f14Pccg1a#0\/+g<Q7]SWFKT;Vad^fR78#I0>>.(DH9\]Y\\7MLd<.1UOg7a^&>
aU4U0\ZN#70^e69T/-Y;N7ZSG27VTNRH_<-:b3N+)[/_Edc^O#U?=,5_@((/GS8Z
BE=_^N+PV5bS9d4NC+@d)XP#POae+X#9f:fG]J<K4K0JR5d5]&/K:G>Me6Z\9]fc
+B:&)J>H)F>I@NX?Fa0J:E)5_14O)5PZc[RbO.NJ.7ZA)OUVPdNJ5VN@:DUb[3HX
PQIQA<Xg6bL&TX8\fHU\>?ITK;9;J-+<3K<;8b+OR4R2[;MMX&5gT0]VRQYX5eDS
(@WN:3<B5SgK4:EC1IFZ@^-a0gF.-ZP]_9VZ8+eOH.^)Y+7]-R\-I3>GB_Qa>R6f
^XM:121AX>dI7FP6.,HD;CgR-=>+aV>AZOUDJA<..WJM(aURP9L<,d1O-2=?1dYM
ggCR\FUZ7,.Rg4KJ]eK2DJ>)A&aN67FHS/TR<3\d-d-S5AN^=JS)Z^;N&Ud&P4WF
N7_.A5OTZ[JSXb;<EC5&Q(6IRG6.Y#DRO]Q<D>G7IQ^OG/+T3ZU&CMU^+YE:XeGQ
b?McMX:6+<IXQE+QDKJ.G0_.+gEQ&]^5KOf9=0Y4-EJ_Ja\OID220>M(,b(bI4TO
gQL\)cZKcM+K>0Af/4d<FF09,K6JHL2+b-&;9WA;H>0:PG_@9.-XG6B,6K1J5+4X
+^a>J3cKS@5R>XU_@8DJaMg=NOM(Yd_]?efSZQ.N@)d1W\/.)gV)BJ;K6^DGVd)7
?8(;Q3K878]f@1MT^^G,)))[>BDA509@2HgYNZ;60dg,#4<;]J5N>5_?:eWSR7+W
e/4JcKK]QgY@37UICY+NRd=IaK[FV8:/baCe0FfM+D.R_N:\>U+R.?Y+_C,I;adD
1@HND5ZSOVcKW+Fc^:[XGR[.^cH42^bX^@g+I1b0g\V;d<J?H1aPT>K5X22e=,6H
-^C5^9EfBD<YcQ.RGX+6ZK:6]1D)1e>XBV(0?[C[c&6X?<Kd96+^RSdgY0Q31gEK
KY)gQ^QTV8Sae:G0HG=HF_A@c38]S^<_5R(#A_=0ZBO7FY:d>D9BX;NbVa<3DYJT
3,XT&cS>V80]LHMY8.<^H<:./#0\R-#c\#(93(Xc[SV^EARHCae+S]1aH]8MF+dK
a6]L=8E@E.743>Bbf)2P@gBa:BKQTC0Q,BT@++G(Y2GC-KA&03E&JebEK4\<4Y:;
-M98ac#-R(WA:CZ==@N82b68-Z#g(_/O>cBTWW>3G?AZ&ZN8QaAC7>]67#16=a4?
KaS>dNaD]E4b992CJbc&YOc&)bVc_cWfL+?/8]?2\JPC+99Y#d?@\^;1CZ&&^_6_
5#Q\cL=UB.2NaR9c5Z]c8;/.<Kc0+27Z:50[AK3L#[ONVQO,X4P8Q72S\O8f&K,;
2?&f90VeP^YcKC;C6APdP0)#V_<Z8H7>-Xeg7<=&KSD^X#?b^)8S9FXUKGYT\<Lb
.<HS07K@N4]CV9aY.WI5^_+)Y@^\/c^bJ6@:Y;F#)f<?7<ENGV[?^+d:3ZO#bcR?
L?>[UV@e=\ZW6e(),&6d9K9EaHM+?(6YHY19_<C3bZRI2#bRCb,Sac=C,B2&A2C6
C?97K>Q+#U;3^LPZg;c-E;4&06/-LYX=;P@:T;>.Lg+_>.VXI>##9F\cWN9E67EX
Obc0KaS_V_/F8/<[\UfEPOeTYSFM3M\ZM)G6[1JY;68]XT[MG?/e_BA9>+)YTW3Q
6@98@g,4IFQG(4T-F](gRdSdSC\,,E.&92,P[Q0<PSZgUUQcG);K8#LeEN)R_VbN
)<E^MPJ>6R_b.7L1V&8\=&VNH:D3I)IM/=b?7N0H9?+EH,1O(f.c+(,;>GEaF>MK
60ZFbB;d(#9@]Kc5Cc[U+>P)-He7(:V.FSG9J6H[(BNW@c[?IT.:QMNZ;^Y-S]L2
YY_5BNA+TLCFFE,:]YVX@I7(86<#;#Rb:4[?G-3]8ebD:HcNO2.e=N[:9Be5RRUZ
=A>F@gFDV9d79T=SLC>ZcfGZ)f[Q,TJ=E45N5YO>;KB-L=gDBV-aZXFPDVeE_Y51
;0cWd0bec_R,4Q5H?SOaCQQ6VH^.^25/C(&/X1^eN.>JB(>5,eQ>&Z^a.]3=>E=e
#d4(3;2N02c(>4@5Kf1cf1X.-3D92=C))<3E/)+P2+DDTaeb]/(f2)RX@^Z98CYe
\[<+:fd>8^RbVL9-6?NFaO?P;Q@]-V7BY1E:dD+F2?6IR;U0@2>f#1XOK^?LH^-Y
>)LI:g?G_75100K:2I(AJO&]R<-fIO,7G2f?6DQ9E+59^F44YNQNI8AUW?^=??HU
:E_6\L__2=GPY3;eZV+0Oc8=_>gdO#TYP>L#>\OXW@?M&b=Rc:&AV88]9>eVVf?Q
7K/2P\KEd&OX4(g]e3.W49(T[9f#[;,HT6AbK)I1-,Q)5#/Y>(#@K;a#V/J_eGS.
#;Be+Qd\2OJ9+#RKbMCATRNNOK1&EL+E5G,Q6H74_00HZ1UAAZXV1LWVLD@NL^4K
\(WZ:@00_F>;2Z<X21)MT2a_N0X5H.#cDgNDEb.G_6(L?D=ZW6\]g()RSXA+<SB9
B9)\2-[RQ+Q5;C5IJc6J5]AG#QMQF0D@+f:54INca+UPQ9-I/A^9dR][F[OL06L;
6;+\MJ5G-L1R^Q6::>fc5SKMH05CKLVQ]S29+CM:VW&U/?XI-TK]3B4(G4BCE7fL
/2gM4:7QH8e6J^W]d/;Q4@:Q)BI@S,WRESf3:XF&D[0)3KFKO47<REGg+83>T,_8
@Z#3UO)W:?<?U_?LEWZ9;;4O@[^B1UZF?dX4+<A_?#0a>e6WP;&LR8^eX>J=83]0
/(F,\K-gQYP/\gA&DZ[[861AB6((^.5a<YYP/9>Qd6@,L&(3fgN.HQ?Pa,>O,GFe
(e(>7=/C-/aMF#[XM_L<a/.ef>6d8AdKTg5/,@cIA+IFCTa-@/[#2,I[.[YTQLZE
eSK_.+K<T94?\38U49d_Zb[JYZfK@=R&1g+,/B3cQV[G2ecB_1Vd@S)E2=_30755
#.V2,FDR=#_-_]=Jg)gbK/EOJ=SS4Ng+M6<3:-4&g#ZVc6C&]>(4WC\QK#d#(M1S
/IMS,]BBa&,V@OHfJEWL?><FWfc/Y5J]O55@)]<9+T,P\d<0\V92U(3-;+?,:RA5
1]L?/T-U9_-?O#9V#<E/#I]/J4_1-EMKg3\WDY,F,8C&-D)I@[<OeP-NAg7E+@gA
a/>aPBZ+#EV0D58+]7JYT#>Q_ON>=B0=Lf:^M[Tgc@?-X@XdIU>a9OD4/\:H2ND,
DU0453bKGIXA:Q;Y-?++TXIW;</D<[R@8WAMfZ8.DL>^<SP^I^?\<<e_Ad_fI0O.
M,D3bE]2bc&F#1OX?.>fW&.-C]e-[=.9M;>Y;X.<.:)F9,(/dS9Pe:/Y416RD,++
ABA9S[1Id2R13C3PM);\3<WD=AB+LGOT]VOB6L2MPA@,>c3+Y/M(V;C5F3GF2J1Q
)<.O9,^.9JUV/7M8HE07eJMRaD6GX]d26LV/KTJ\7a8,O?A6TM6?2<6(I]bS/W7D
>\7XPAe3&aeNC57+3=-bU1cG0-FJf<>#JD7,GO,Y4+PWGbQ_\^d)Jg0,bI42g8bX
=K?U8N;)@<\/&c,#/ANRU4CYcX;ZAg+a86g>S,(Pg0XT<P3>K#7UdBZ@V3a=YUd>
;CO7V6J0HN6f#(4DCV:I#.QgQ^RR5T@S.BL&HE]b71dXJMaLAH<-R3X@3cN\JNeY
P?9I5BWT#U3Z2T:ed[NU4>+O:<8aTBDF13GT<f2I@]F5R<<@DU2aI5Z\-=e]7J^+
C97K<+NL;Ke74FX@#F.a<Q9B^VW6b6)D;RL22+F:bYW6E1JR:H5]QLGQ/fO/=^^/
M)^E-CE-0)fP,TR+UZf2RG]fP&d7Xee=MXQ2DaE;ePJ<fHHEVYYZa<G=/71+^SPJ
6C<#&c0@.HLI,AS^f_eS(c\=QOQ]Uf=8?XH[/^HGfOU)Z<)7EW<H<,3]5Wfd.G+M
STC0C3<8b4#28<fGON&1TX\RTcE##,N(0K:)UXK6.cQU)38BP?6,[dD=-PGK8(P0
ELf_+K20?:)P=g,I,AM6:ITbR<S7I;[L:BY5P4V5T4Q4;=G0a09>X-]0_3(>Y-a=
BZ_eA@^gf5)E@gAGdA&A/bD=4VGK2Q[8;312e6cPD?Z8_-J,6Ze3?a.]2YAgL=LK
X&Ka;V4^Q)/fDM?b?[/.LRZ<[V_?S#c@<S5R-f&2W2c4X#^BKc[=U#H#D[.fLJG=
N,NYA;HBL33acQ3;Ee</6-8S7UV^+KK1Z[<+@SScX>Y<,\DRS_M>]5Y0QTfMIGDT
\Z;F+18g:Ig=@A3\E#H]Y=/YT#Y.PRd6:f5>AW6WXO3?&01PH_#W):F0&a/e<VAB
R87c?,)c7;F#K[d,?UMeDA4<@Idd]EJC=[QZ.ILLPBf]S431&&3f//P)?V^U(Q?P
FS+HP.8TCLVg2d\CX4<N)@^R\JX_VWDU@)/]XA_6[d&1R0E5?0[OY^NRd481]HS@
IA9IK_F3S6ST<8ZF?D+H@?@]S_f>Vb+\HaL8eDQbVOgY0C4J-0d>Y<g=A4M\F@9E
+OH.:#>8;R,82S-80XK.63D1(V?F4_8IM3M[_6JT7S-K5a[UHM?MRON5//c5=<:@
BQ:[K5]:+=.WA&TL@/[V/\D,I@J)-EN):^_C:MDD)b#@?T_Q#G@4G5=:_Y.CG,RI
9\9f8O,SJO_&WTN,MQcNX<RHKUR:<4IbcVF-fg,L;\)dg^@=3a,e-X+BfY&VNF8?
;:@RF4ZX]#7RfEV;>-SbQaFA;g7gd</]6H+.RBcM9XMcF/,RdA=7)Z(Bb;,PW<49
:1JVHeX1WIUZ4_fPA3^BP4T)@03\O)9R\/J3cOO65Q)?3Ce0I3@3&L\DWHG:d/5;
FY6HLd9J-fM=J[O[XA]8&]G,g1]2N&M47J&(U[fO[+DIOTA;]<SAP-I,OIYb6OEH
;=RL1@e_g37\951T._)I/^>Z<&a_ROZXP)IMV8VR_b?-@X#IVII#?Q@7A/ADJE+.
W5VHX:^SbLaR>LTYgS:LFaI,LeA0+LbPb2;.cR6PW9Y_KbcU4IWC>f(=)C&JVeEA
cN_:.[6A,Z-<7&EBdQ?70J[QHR\]UaT^4&8.N;S+KJWa.^;b790P1IL-_9cC5>Kd
YAX]IabX50,(NFVFYI[+:6=W2M#<)L@;]H/+VCN@CbS2dEBU79-P-KLI5Z7R>?,Y
VO5(P)OXSCETY);#>5E0CRDH\eXTcbQM3L][\BG]@KgfXDcGHcW\+J2Z,66EYeeJ
85gGYbGc?6,U2@>3\&<Ocg[#fB.HD)MF+LRLUZ4USB0dO(-EW0[fNEL0J46YfY_V
]ZcZX1.S?R?;T7.5JUTZcWRK3]gK,Cf.HQ#2_0K2\8R:M[P5H)dQJdGaL^YJ+5\6
?P54\,O8dgGFRWPV\M^Kb_;YNc^##G0IF.9[J[#+8aH+-:8Q\]fa>X,\?VT6,P8F
[daKL=E4N&8)W>#;e.?.AXW:C]+U0[,&6?I/(I5#LTQaP:(a9cfC)@SgL4\-<X#b
V=eZ+bIE[+Y4G::[(;<:0bX8#3P1YV#g&,1@Ea(VU0\^KRS0]TYX.ZI5:VL5U1L+
HK:\A^/>_Y[c./Y9D>V#::(A.Nd[ATU#+Q5_WDG<5_OX(=[[SAMM)8g3?MV.)K=9
77gPWM2I6J-IOQQ2#)ST5D>&H7DdWS5RQRF/GHH\^6SI:+;5^(#2_?1bLa@,e;Y^
;D&DONX(Y8R01HFC&&V9-)V(YY69GUF8D^IC9<M=BQ[eH#9XEQAN5c(LeGQO_<42
N3Uf@D+E]\@a,[46[(@SH9W\3TM5C@K&S2=EIFPgE/+/,3G1NWfIA7OX?_OI,?/O
LRH9Q0&^(cR77eb>D>EHIJ]<FCfN,1\d][;0XJE314#;W,Y7>_4HdX2GaUQTW265
8U(2_e7#e6PgUM#1g+8T\-g)&.+:6a3CY.,]&+H8MbAE7XR2GAF@eIK.V8W@RJ_f
V)NWO[>.3NLbc<0+dVOfK[>)_5OE:=>[V]X8CK^Q27=R4:U(DS>\>2,=O+aY:B[8
H)D<gd0cY,f7JL+,9(Y0Y]e\.I])JV#,?5R+.(M>LWg7aZ[,AZQcV0+VDS3B]X8@
<3R>TA<S5Cd-e52<SRL9S<_^gHLJGUd=&WBY)]SCLT:[-=e[VS+-G.)19b82(VLA
2&0\:2-ZT+fDAR]V304@>V\_?^^e>U&&)^LL(4)gU#,B]ZEE_dZ;353DK,:;+I++
V91A_eJUd4IUg]P71M&W>C^V(UDCeO6UcHUg:/SRH.7H1Y7TXLc[CIf9GL]W.?9+
X.\\&@E;JfA4S2MF]3(#:DXAe\0.gJ,>VR?FR3]?NOLZeRbT>Y^_C0=PV\.,<[I-
<^[L>3>V=bF:JbO(;/d4e:-V\5HE=.?:Q:TX6:QE_&#V\gcg8)15J[22<7B;N/0]
AM,A^>DA8ICP]Y2g>6gRRF1-L)<1Z+Z)\_[;96A>PLBS?g6S0[J)+A,XZ,OOWWa2
HXB0:)?S+Z#8a/g#?&Y7)J.2)=d=0c</6#-9&<#_(UZT0KHX+J0</b+_=fK-;(KC
LOeO9WM-Q7M].FRC@SD16)UZUS<\LG(J5SEO<,F#=>LFec<Q6-3&7BbJ/Z<RA3[_
e]5=IR8KYcF<WQ)3dJcLUZ+1/G]@=S\-]1JF>Jg7WAM3M/YF@fA-ACUDe5D1X;dd
S&eYdg9Z6?02bZ@A&^>XX16&fBUBb3O=ZEZR\7#UOdF7P/MgCH:4edKJE)E-?,,9
_9(ca_g.S]cfRE4L\IDNQ^db8fZ&b?Y#:<KDU_X(L9\QG8^Df+cKLJBb0X;B&gbR
JY0P18ZG#g[f;+=^;[2//A7CJ2U=Ng#^CR.XXJ/<O]NfQ#]V=5gN0[@I1T?Q74_W
B)H@2S:3CO2YTNV<ATa0^2-IBe&18M/Y)<g)HY-ccH8_]V1>5PY?TcRGU3R@\D;R
C]87AJ-a:)a3?2f9F[9.WaN1\:UJWXD;]/S_;F/&=fR_V]A@/_F\g]_V8&GN8S>#
YF7971:d382>>cB.gEZ7AWfTB?ZRJ/BaPSHAf&fROM/dc:.I4A]_bb9MT_#J268-
=OR66GCV/AdP9U]Rff^K5e_V=PQ9CBYMFVP(],-6RU>+/cL&=I?W^gOIObFKB2[8
&V#gCFN9_@a[;df)7D]e+BEK\IZ+/NeGTRE&24U>#PWRD8#Ua+81dGQR(DJT([2E
E#RAePR]&;fdC92^JbQ51ZEJcD5D<>J=,M([4D9_&S_9=L22CM\ASMb)>&NUcM,9
JB-OAB2-L:gcAI22=-;aeRURZ\\KG8a,9HU&B_X(:UD76:=fV0-I0^S&Xd;,fOYK
M9R]3Pa<1T[bf4OH9.c:L.<OP)EWWM\J?=U\+?@JJ:#RV5;d<H@DY(R^#[La1__5
gA@1E#3/W_)(<DN3bC2@KV&[(>,(S8B/C1Wf1cP0)<[-4gN4TU4[ZZ_2MLY7#]a5
P(U7?B;5X>#6/[@14&EKK>BV14@:ETbMTC\=@Y>4M\,gFCY:6NYLWgI?]/C^T(>N
_V^HLCL7R^Y3)MUb:4M5b_FOK0,[R+Bc-]L[FMUV/Y8R:?LILSTBN(4M.)APb:1\
4+\_a[@KNa.^T)W;-7H^+@DWUaPf<(QR1?4H>40_>dVD1G#(VPYAU#@De7&aa10I
=S/P[I@U&e^@@-3XObff]J7\X,_4RdI+?XT.Mc)^TS)0_>5cR,0J6&PaYaGZXJ)B
WC8,Le38=eF6,7,_dLGR?FHUV(FT9a,6&ff7fVQ007T,?L.UYFT35-,W+D?EHN]E
[(]_@.\JdW;B<_\7C7c3Q1&fUJ+f=(NH]e@&T#<@+\]L3<=;Z-?[d&dF4F3Q9:f/
OfG)0X]YX#),Ab^g8NI>7CXJ94DD0ID@KD&;(TePNKg4)<W<3Q@8H22HFbJECW#[
g8N41N-1[+_+E:(GX07;,=Ga=/-2L+P@13Y15<bY;&7d]WV/^JQ\@\BFD#fdbY+]
1V\O_6@TB&@BC.YYM2TI(?7QD-bHdZ\2/\(CBCLPHNXS\Pf?<R;CW5Qa8aR9e_W;
0F[^Z7RbCO,RKLX1dTH#)N?QB7gB>fXT#/;a,8b=&R0Mg\a\QVAUXW4Fd\:[T3g6
bd,-_A25P_<RE&9IGf-P/e9?_RPPLf7geON>fXg6dCKW4RDd0<agI=F1OZJ)\-dY
](@ZW)eSb\g?Iga(D59R[/N?Yd\,BY4)b;6NNPg,^f>F/C6?U9a09[_)6_W(d@Mc
@;\?A[Og34CJZ6e]I/V=]/]X#I9/.N7,Se6f:e8CVL)#VQfFIAS6VgVKgHD.eZN6
=L_;b]A4Y>ML1R7_=bcB.56=N<c-S+SY#,K_cSAS_S[B[AQ>BgFGVeO:6;#KL1_G
5)GcJ3J@eL?,78X<[;9&X(@LX-(,GS4?S@SV94:UUUF4cIYE4X3<<<9:.UeA\^W&
3W?:dT@ZIW\/;GX/Z0bJTLTAe4HSQ9ASSQI__NdcB.IC>A8<)(_&/F9-C=TXT]UR
C)c[,gfCLaLR<AA@&\V][I:VV@N668GF]N0YY=FcMZ-M_U1JDD>M?g9-N$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_ATXP_XSPI_DDR_AC_CONFIGURATION_SV
