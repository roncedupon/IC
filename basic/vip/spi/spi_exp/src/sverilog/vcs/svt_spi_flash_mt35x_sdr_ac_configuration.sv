
`ifndef GUARD_SVT_SPI_FLASH_MT35X_SDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MT35X_SDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Micron MT35X device family in SDR mode.
 */
class svt_spi_flash_mt35x_sdr_ac_configuration extends svt_configuration;

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
  real tCH_ns[];

  /**
   * Minimum Clock Low pulse width durtaion.
   */ 
  real tCL_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command (SPI) command
   */ 
  real tCH_Fast_Read_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Octal Output command 
   */ 
  real tCH_Fast_Read_OCTAL_OUTPUT_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Octal IO command 
   */ 
  real tCH_Fast_Read_OCTAL_IO_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command (SPI) command
   */ 
  real tCH_4byte_Fast_Read_ns[];

  /**
   * Minimum Clock High/Low pulse time for 4 byte Fast READ Octal Output command 
   */ 
  real tCH_4byte_Fast_Read_OCTAL_OUTPUT_ns[];

  /**
   * Minimum Clock High/Low pulse time for 4 byte Fast READ Octal IO command 
   */ 
  real tCH_4byte_Fast_Read_OCTAL_IO_ns[];

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
  `svt_vmm_data_new(svt_spi_flash_mt35x_sdr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_mt35x_sdr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mt35x_sdr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mt35x_sdr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_mt35x_sdr_ac_configuration.
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
  `vmm_typename(svt_spi_flash_mt35x_sdr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mt35x_sdr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
W[B.?#)8(83H=_CR06,?S>Y,MR#&9X;?,D3gVU^4GYdFM1H5JGQ8/)d?IA2CPXG5
0KU3]&2X1<Q1AZ\M<de=[.d]0K3U@C7^cb&.>:GVRLa5#9UV4E(N12cfAER\6?fW
cOCPFR>:b::d;/b1]=9EC,(eN,8=NZW89^&LT9&_A-,P=Y(\86X6McSX2Xa7GgfV
KN5\eV31&EDe&<g?]2PD.OCL2?SBgD@g<9GQg,&3agNP4[)/SJ^5dU1#7&ddL9&W
0Z,=&2Y/.P,)^-Sc)1gU:UbIXgS,g,^d@IIXR1R^]#.O;)@>/@,7J;BK95cDC3>&
.]4WRfQ<cGUJW&aM?Cb(9L^7#PJ#d/8R.^/W([)XK;?_7@UEN([.PNQ7G&G#AbY,
1BJ?Y+KHfM3aFcWY;TOY+HP\]f,^U&(D3Z0a4cXE:#K.DP[g,Z[])_E]:,d7,MQH
fPefK1V&8/C7eP(c@H?EJO/IbK;2VJSQMeM&&@N8N55/,N/Df^V3MICDMD=b9>RB
45__80VS/c5TGU>a,)e]P4F@AY_G9<@CHTZ+MS^9Bb<URdK#<PGU<)CD17eH(Qf-
>FJ<cJ0<\:20cKI:[;L.OB()AQW3^J85C:9CN)UCG+ES?KfXgKI_J4\Z&(G/LbSU
PBg#Yb.3GZ#61K#SC8KU53aHI+c=.B=/M_2SIVcGVSPI<WUA8bL\]UE(,f^ff8=1
\G<_;KQ&&^g\+-MID(FYB#<>7fKP_9Vg_:N7dZBS/;5Df]Z_4I\49V2:<7SfZPA\
@JD::2?>N,ge+1Y4NS5JbD<>5$
`endprotected


//vcs_vip_protect
`protected
gN67AZFggE)IC4(@=?Y,aE2Mc2CRE/3OMEMXb#=7)-dMLaA-4L283(?K]?V<-C3F
(6IQ&Ff9MB36X4VSB5VJe?fc.UM.7M5,b@(DgIUS4\:2:H?FD2^[#0+UKG)/4>JU
R=,cUcOCMGH.#=Z-ZYdBQB:AL6HBPE#9dTabY=55,;92,bL)eSVLgF;KF./M5XYC
12eIdD#b3>@7X(C?c4DV];e<NZA&a^U]5Y.-Ke&0,fNDe&cd5V:O2::L^@+dND2)
DMYb##eM7aTc-\8RdeOE/;827c[OUX;QN3W@E]&OV&3Q#Ta\<gKSX4(dO.ML/a/3
I@(5,XH5\@2^?W.WU+O[BPLRDIWfVAP6[54AJZEFcVIZ)&L4#&I]d,W0?eBYf>ZR
G(ZX5b>b53G^YO(5Nd19\N_,0-d[;c7)>TBQ=9.Qa#NRJ=bJN#<^F&LCLDb??N,>
9b5])7g4HNbHUdfHX<SB\>L>TKRS1.0^_3&N6g:7S=[W^]e@:DEN[)V>DN.S,#MI
K;Dd#J5J5\DJUKf\8O+AaIP=MWPTF?.LF9_c2<[Z]E\(fVAG-7D,4>EUP3E3_Z3T
A87KR2Z>8[.fA4F?Nd[P@9S#N_,L/:0K/8I=7M<OgV=E0.5C1&(A0-b>L+SWgF=#
4I)F020>,=b)R(8P=^8B5N:M@(M>2FM(&>BEX^9SIgKMC8?[4:QFOCJJeYc,Q2aP
>2c_e]ZRA+SR2/9X^V,a0eg#&:+F]LQL=[1/A1/+a=9d5AZ_S(YM#RCRCd1d6,K9
c<a3YeT\]=8-,c+BLa<dZI<ZKdI:FbUVOCb8G+#3@#5V+#\I9dBf1-96SY/(^Da5
)4TA-?fS7NX\#G]6JEJYUU<VbNFH<Cf+0_O8ebdNPgUXG]XSb5NaB&7a41#4g,ND
4<_[B_O[:Xa89=8=eUSSK@)=6UNVE\8ZS(.9C-W\K)g&VBG#U^L9ZDc3_U^WUDZ]
9N^,I31&S2TWIPd-Z/;Z7&0Z8RUe?.Z1KT))1IXCO??Ta1La-FDN4I2W27)e?Wd\
S6-_J2K(OOc0RU/92Y>1F]LHP(_7R[H9.@R^7V3Y<9?M8KdPVU3HZg59)?J=aNcD
c3)46KNQCEFPRST:#R__Z[08-2g<e1cJAR/P,HD#_SX<E8QXYHd,^#58ePIgcZ)7
_B?M:AGKdePa=e(K2M\gZgd67(JK0RL4]0@-EO<KEZJ\cQT4aO=SDc5);<D/3RZ,
UE=^=IN\8^P493MOAH-=N?eQIBCSJQ+1/8/Y7,e6bKQ^4EDU<-8eZ3Z<RTB>&B_T
4b,CXDb.[+&\5Ka5&T4C1:J<01NGd;Xf)^25_Va5Xb(1[=PX7DM(C3\Q1CSR#T?d
Q2XeYAF7.XE+aC88VJ:-2DGd@;6?L3fO=.0XH<G]2C36&?de-CNT9R5I(U<EDE^N
\,LDgbMH^@1A([+7X9MeG_QS^E+@>7JRLd@O2,&7e:E:&@g)A4L#@+5V3=-deS93
aQ<I_8670YE2(T)ODDHI<LI2UeTI/dE-a7\\2H_P&4<NL/#Ub2cP)LB]??0P:+?Y
APNZT=NJ9Ta9)=Hd;=W#V[W;?R;N+;F]>,fH6YX-6)g9ZN;8DEc0][0-.=gB_((:
]>NGB\M\eMMF5W9PE1d_7WQW4J;P>O@-2LW4gg+;&XMaI+3W0[2O=a<LdUSO35\.
OR73GOdPe>+@LYbX]564;>3GDeW)\(CO4>aHRDO-2)7\3bZV8<XOfB[Ad+&3AFLc
DU@g/>=.B2E?Pa=fGaW@+_e03?-_:e/aJbbB(M_3QcgNE@8]DFL[9HdLAda:c<17
&X_H+X#Lb]Kd4UBC:IAgQSegGYAfWI[;PA,_0L:<IAJG.X(@TJ2f:<2?Qg>8[JP1
NPQCKSJOa)FWg[#eROZgL,AN7/]15aS_1>f@;QbEBgZ6?8-D7_-5M-OLA=F(Je#g
\73872NFcQ9CGGGP+0,?J[45XaQM59gZc>Y1\&5fT&4g].,:6eU&VTF&fYe.^O8,
(,W<\3L\#cg);T#26F.b8&W\Q/_,1T.(PM[Kb7AFPG:Z?5c=[?^6dKg:4bH<_ZN(
[bfONKDOYLNJ2^PRfJ+.H^(,N^M&B>aZBF,=9dG.Nf?K;/@c4#LaKgbP7gGFPf?^
(Lf-49</I1Af]V4L4<:>91P;IAY1-cg9UF4dS=?8<_UHYII\YP#041RI1QC-<>=A
O\2.U5aT&K;.T=[(50g9U/.;-)OaV[=,9)=>07E.3Nd;f2GFN,X0#,?C.(_K_Z3b
?^5@FE0VH&W#XZCS0?D@LCU6GCZ4c\B&&W0U(g&g/c0[2/-T+M(8F;3I/PI>-J/B
-(4JWCF(C5^A4Q3C[8A:(FWI<MI,>3;a+CgNQ:\7c\(=2=9+HHMSL_,b-D)C/)5<
Bg\cQ.=?8fF8g)SC#-E_@U?abaZVSO-NF?[;Ne?>E)D6.#;AfYL[]0250,-OUA9E
EOZ-M2gS4]=\U2UcA\B-@,I@.(;##fAg7)dGT)f1_?[M3>f.Rgd?Z@K<)[:bF#X3
(SV#)J\M_#)eCc,ZGDf4a7K3\-33==D:,D6VbD0M;fH2g4KB?^XV9O3_N5UX<L4B
2,1)d=9]_7=VXaED5LW:C..gAOT#V->GY5&bgF3WB=;X56[B@M?OVUR7LYab1]09
]fZLd6&/+eQZa<e].a:b&S6RWe_JT@76_ND_T#,fK:8eH<>&/1H:VW2fAO-24]D(
:.VT9]R9:+W&3;J+@U4Z:16+_H671=/LJ[&P?Ec1NaV6A(WCeY+T:N7=J7PH6D<b
1I7@;X8].(Zg+IXCC)KKGW6Xa+/KLK(/(aE9Z.\ND)Hf^+0)f]\7CNZeZcL>4P:>
4c_Z6W^NXQ<Bd@d.>\7W_QHNeR<f0F<QCQHI3877#^gB@5T:B?dR(8\gM-K)H/XR
.#^LfFM]<\F(W-PJ-ER-,e?4W6M5d;[EQd?_B=+B2?291a\B=FR=fE8PZX[,7Ya1
S+WK3+FV;=]@,#bBb)F1G[3::SIJ4D(bEF&_J9.a,-N-<+])@4\GO:3W<^/WGC9]
A?7F@>1a-81E\Rf>f]6.2BCN>L_5N^#Te\G=eB;MUIMTID5M5ZQGGKK?+V@1:2T^
X]LCQ>.5.5[1&X?f_dea)IEA#<,?E5d#A_,WPNdaAS8GI4@N5=@/K@;a&aPN0\_T
EFR52BIHCEb:d@;FY(4[S6FI6-_RAgHI9#27/)J>C^9cc70N=F=G[JW4-(]L==Eg
[7JR5R8[L-DM6VH&MJGU?.UBY95A2N.Q.?Z7PY,[c64+7=-(+e]-aFNdM(dcG5OJ
B?aP-2RaCFP40-0-A)XIM&(_KEH?XEY7.Kc^Q[/Xf)66_C.f4PX,2+5G8,(W<Q\?
#aFebNb(,FVXT=SAL>_W:>gQTZ^LUeASc9D4c7SG<#/V@V:_+I(aC2O-^-bNEaf_
XX:WJ2I-LO.8CRYGa3QG#MNdL5C<a<e9bOaHFfN&;3CLXDCKY?3L.LeV;+V5XWd.
Y9-4:e4J?97VB<VOE+A]ROWAd;\\SCP)N,]BRO1W/(QZEC=6KW13fW07[LH>]^G#
Ee8E@UXOE_T;I^H8BHFbZCM4fU)E1,NJ2,DQK<&G_gG5U4X3;Ge5P=c.a3QTIJSJ
P3AJAIVHMU:;>7Y>g=a+:326+&Z6X&XSNN[/gL[Q];)@H:^;a,[c/9M\A=ZZ0<HQ
,@0^2Z:DLD)YbF6+cKa(L[1J99-]MDT\L7&5V)@-AUO-Y&bE^KGRQf;,/U7F1C2d
>GZ>L8d^c]D7[6dd@./PCOUP]X1:FMS)@E<1&2CQ:c2_><CQG_E#N3>>VIL=B)R9
WT4WKd-:Dg5,G--=[0I3F2@[KKZE0OQJ>9cOLOB/WEKE1A+GVgTYfMM2Fg1ScMc[
V&;IeGGXS:bE,\Ue4<#X^_;bW\NK>)8gL2<2=(V6\MJ:1-4E1:ccPLR2LD8=A7Zg
HYA<da6^1Pd9>4f(a_#K1&Gc;>U]&GLVD7;[cB31SPA?]JKP3_[?Kf8?1YVM<1+[
48ZaYZ0Lc4#@d-X-GA_D/3e6g;.9ff]N<NM+Q7KQB-XfRN1T&7dPJ+>VQ;I417D+
CHM.Te6<2;.EPM:C1CJ:eE.#?>(E9?b5bNF)#NF0(WgTbT5HC8UFe#)g:Qg,/4YT
JP.\D.&#9X>]Q#^<Ee.BS7(O=d:IZZJ;N6BAJg\6L#Rc-OcJW32C@T^W1eOK6NOU
e#Q@JV_0YL2]I4PT:fZ#IH@96Ke#&Yg5QK2)^DV<7Jg+?D&:XeK:<Q@0<T.+a0eN
eYXPG?I5,N):RYde0-#.K^?&-+J].SY3#DF^<#F]Uac#M;]<;QU9WZKWE8U)[J5c
T]Jc20N;gQYG[0g^c-C_[<dN]1=cWWROJ+@XcQ/aeLTT1E>0_KYY>3_Z:3^>Pc/S
+WXX>4O(9f^[Y+NZ7N=S[AJDD2/dc,eQ/<YNe\#K<0.^D_H9&,N:W7TJ0I<\&.)6
7=+1/Y&DHOO,T6f.T^/g>V<?acJ;4d-]f3E/M[Sef>C6A<G9g3(;ZBX=Z[DZ]_Z=
&&Y7BB?RTD5B?E?[OL^L_2b.FVCC1I@^5fMdFB.0E7\HU[XcgMcfMGG-WTF;E3U1
4b=\EY8DCLGG_dAF-:aN,<(F4N8R([?^><7\8UYZ+MITb+E:Jg6&d8gDV>TAbHRg
DSg6?3I6eP/,?8V&N;@N\f)aa:M=I\/e:^DZ6.:B<a@@P3KacSf\;C3[O3-gBE3Q
a1aE)R2eOS&e&cRg\DC8J4<d]&0[ca]8]/P<E5^g(R894e_dFMD6R)/6@M6eFEBK
SFYLN4&d^,gF0RESfWPFOJ0WT.>JH8[a_e+V4KI6_&;8U:G+7=8\600G8W\CUZWV
^;E(,A2C:^Tc6g+g+&92f1&UIB_;_Pb/b_LYEJJ:BHZBPQ/,QOUP52HeGa)dCc9+
.8FTI5Y70c2[7(VG/ZJ5P8W0,E<FD/3f(@cWWeE(Q>W0>BFP&Hb1M8:X3P]Rdgd#
LNf(ZXF@(<&8H4?\M15b7W-YHB/PE9+MHR[,a88V5e1V[9,CBeb_7LdK(gWV2#Q;
#37)V[4J&fH7g/:_@6e:&.#S(.4c0fO.]Y9[5C/ZB?XP@WJ,Y?J&DK4WTHc3g75Y
O,)=W4?98OPPL#aXb2=03#-:HW1<PIQJ>-6/bBe0>TTF14Ne.RQ;+9Lg6NYS@<)#
X=]X3d2fKOWaJ3g^H5&TM,587=J/7;=?G.Y;FB^YK=SVfZ]HA[SKUB3Gga@,E9f[
DJK&^Gd#a0GV7Q&cGV6,_/=+:T]abMSM#32S8RE4H:]LZ5F6b4e6I[EESbe3?3B6
NIfBTZg3.A:D]HGD3d4I&b>4&e5+)P0:gSVd)PUG&=dd.L./<829FP79g-CG0CbW
aCX7a610/R,WG6ZeQL?PL>+e?d#[KU@?+I5FHC5OQB>Z+ed#2C@gKS1WfY#><(0G
3#F1MA(UL8B9>fD_7Y>2+c=/.,K<8G,9<Dg+)C-bDWffDccLV(@U=;^VA?#9K2@b
_@PO)W-f(]_TbWU\P_Y:CSH(U+>f[^TOR_#U9K228A3,+(19KD3V>WY,d7;X5XdL
,GM#^93Z0N9;1&0/e(&I2K&,gNCG4gGHT/-UdcWO[:-FP+7,N9?6BSW==_?fHEGb
QXNE<a#<-_&;[,Ec.G3MEgAFXD@J\.]-.f^25KE#)MJBaDc8,cY>H1/_J;dKX[gC
DM#.UN\B,(Q-W,dZA>YB?+F-dQ:SD1C_Ke7XP.)E17TPFZV,/E-TS;?a?])bg]X=
;E_ELS5ER8M)LH)K\P?W89VG<AQZIUVO@EbT3Q;591MO@YegIbJ3ZXbB8//0HMe_
IabDV30fd>O<_2ZPW..[LEdSD@Y4<D?aXZN^3W#V&PB+bQ9f\DbP_X^=HN]e&R^=
@T]PIdYMB&SX=CIXU45YZV^4M.[ZMdA0>aW:,c-USZ;)JVgbB4Wc69a?-[@TPQ1@
@H.OCXO1EV^fXGYR8U2;Kb<&<_NMOe1A76;3+4L?ONDDNGgDMS5)WHWP?MO-\GSF
PbcLIYQ=4eM0/[8C(d?X)BI1/B27IgC,L7-V4;L=1JOVFX]KEP:X5^:>gd.\d]-Z
KaJ.4E5HBWc1cFYNUg]DPU3@6R7_SU6MW]BCH9ag+QOI=1;f[66_(@b-[-Q0Z^f-
\KXPW44,A^TUS]-eTM-OP(7@>9N69#J)EQ/;V;9OKfBD+PeQW/L]ECQUPcIF>8d+
Y1562Q7IcaCDLT?bMB)F0K)KJC>>3<=5OO@PPXg?5/Qea2+HG94T+#;X1._OUaSg
fC0JOQ:W.>YL+IAOec@7bfU9X-5)_23PYDIcA,dA:=C;L^Q3;LA=+d9_[JI?IT6H
HUD]gE)\OL4Rgb>b2I#EgDH2:##[J/^M\EIg&7/?3,T#F2F@\I.JdP#FKT),2&0.
&^&I;MWFO)A:5TAad98I8@)bE;H_#R6B?76,-A_0Gb;0M8RH&b5SMAbG/Y,:I9S[
:E#7aY&3@WA>ZcH@QJP\NPEC<H+.YX5UdR)]CTc,0bS-c#L.9QHe+R4PQL@Y5dg0
QG3LJ-DT(bYA.]59#I-7HJ0g-=[^<?CIBX:JfVK1E\&agA9#bcU;.>>d:<.,IPO3
1^SC>F</BCaK;I)<]Y>IHgZ1cQWd>#R.5c1f9P;FGPfQU#G,N_;C2VPXd?Kg,IGU
M7+MZfMb=\KU^;TP1J>N/SIKDXI]1_E4Eg2H3CP#b8KNS-55X&LYZ>DVPNI+LR5W
K;.GYII5QM\_79f?Nc6?68;1U)\N1.H@MH&^g)(HH25;:ML2Re7aaG6,4/QB4ZBG
aIfU&I]C:U1d?]Y]];FLB:<M1<T4Q8VcacI)P]#(CCJ=JHQXQe-eRGSQ)98Id0EK
S<OVTFG+KC)>4<2+_LIF;QN1S8Z1KYSMSWI5G_4U4Ec]A3-@T\V@URc8GUJ>_X)>
A_CV7\.SY0:a^TR2Pa##W:=c9]aQg=QGKZXCCN<cO/&(7cU@BCPDGM0RI\5VeQ^I
ZF/&Z)_=.MfE7Y[(f_>JgY7IM23#Z&I^Ud=7TcG5aU^@92?S[&/=PV;3cfT0IRM8
0DaJCUQc)(R2_FS>432K.)(BRa-3#;aPX0UR\6ISb2+J6d:N-GIbC./3-;[JPN9L
g^NJ8[b;>;?\8[77dA0<2-#=Z]^baCgY\GK,2[Q#_@b45M+,=V[X&#IO\)\\&f)@
CL^8Y&J#_F.W:d4+<<P=37F9^^[)+7<f35aA<&?O\Oc+a8,fS6X_IGG45U2M4Te=
_X\,G2FN\UW45gET^0W7BG1Ga5dBG^E>=<\.2]T@F(@S3f6MM[4@Bgb&>N^HY,E=
WNWIMMA]OZ:aBB>2B:6V&4_7Y#bVIO,YW24S\U=.fdNQA]-^F?)L)G0GX7Y\TDH7
f5ZE3BFS9CHVbJQ<Q?FD<PG,85XGM:JL2_\-/SRSGU+XL7GHL(\M<R&A2PgV;L/Z
?)ad[R=JP4-8+-4RW5bBEEB]6OYg\=](-^3d^;g&5=;K;]IK<VX^&ddHgGMd#D^:
<WA&+#^=:2g?(QUA-a+<EL3-SaW:@&NR#B3A(7I(M8O?K]RXcbEU=6T)>A^bTeHV
<8WVBU_SPXaPK)V]Q6;#@Xdd+LcYZTSQ-C.:PI3#@;UZ[;8?:eJ_(X4KB^Z]aX3/
(?2?,)[eDKHI(H-?O/cROH=Va8LLd=DZ;3Ya]fQE;FA6fGfW#3L3]<:#+J7a+;X;
eAG:ID-Mb;K-FCWU(J&J]P5RZOgUDOH<(>QP;YKA\aZ0+K(#e+T.(V_O]_N>ZE>W
DBV7:ZP@;<\BK&OY9=X/SQPC6/.;?2.UTOKbY7(8)_2W5Y<HQ9-#U[SPS7;N3B]S
K@P&CO&Z.N[;=;WHQcA]Z0YdbIABEIF3Q>9:#A/Zf:g]@0,6#]_W,\#TW?2a&\-T
fFH+@D#ED8Y:Be0C>D1#Zf10-dWN95c>#LD3D&>?L^2=TUGfAYbM2B_Q?S\L0T\M
cC\Z<XY[-]@QHfZ-d=3=S<(P1DBJ315=+9A;C8)B&Z\#_(\6QaQ:TdV@+dU8);4B
(+[[KM->9[_@_+=:+.E7VIUK#WZ:Gf0:]DTW60_UT9,G>3L3?Z)\:eTUdL>:DcEA
#(WKR[Q\0BB1FWHG.(OdHAbW>;U,]6<g/RM7fBg131U,AQC#F#Q->+BOPJH[aPQN
1JHAWd7;SF(;8J(/(\^SI0:0d+TaR<P0f6,^OdBd#T_L[7[Nc8eQYMfdYRfc@<(2
BfI61?W;7Ja4E17e;XOdAI@6Z-).\XG:+(P.WMUO:L(,a:W/dgFEf_-d,#[#0[L)
<deJ5ZAHS+^L1&a8\XVMYNa9d7,aN1HQY@1(b8&VWS4aO:V-/5a#EXUSHbc6Z0Z:
U/>^ZbJeDB/=M]^,Mc(:AM;^2VE+_VCNfcV\I1^_\Q]&6B,=QX/R+TWcCZ?^Z)]T
9(]eAY(,A8D]5QeX[F4?CS@fJ]8JWKeEK7\)Y[0WcL7A]1E^2bA_+XeT@NQbG6VP
ad6R7Yb=00W<3fd[J1]KGX-WJI-^DWV#X#4a2OQfZb+^<g6^TWDKU.&^aVA88+;D
-TK;K9+[N&S)SQ?V92M1-cT_F)[d397L,_X:HgFg4HY>=M>f:(3G;N)KSXbb#a]?
g<a][AL@-V)7C;JNA74<0/3Z6_O^R44d?ZeX?:>+4IIUL.98R)ZALS>XRNN?67T_
OTbS+V8X4H<0+;FG#T0fX7_<B/KD=BAJd)O:WB&0(8G2V?e;W#^UdRC\,31.8^bF
?Sb\VBX+^J:)O37?0=aMgP[U^CY@<^=PP3D(#09YFDg<MYN=T\ZAgVAP37I0]4^_
9Vd0eP6GNE#IE[HeaOA&g5^#gT3ZJa;J-P,MRRc?DfNWc2VK0P_O.IBJ?&4DGSBH
PSQ^L;Kc5[3W(?#TCFC^2][/?ZWaf+fFH.7VaQH]\6C>,\Z:Rdg3>-55c;<c#cdW
@O)\Y)/Q2Jf@6_49L@P:>?7(?a/J;RG]X3S76GI+(XJSRC;3GF_D<A1AfW2]=A50
9TS@J0_;TG#[gWIgBd@3U5WM3M6fb-5]>Y4)V=Vc<[YD#S@AH(aE7?FKdc:+=e.C
=d1]Yafg/3d9CPL;5cAb8/01=;^,2Ib436<Q#HKR?f<?STX(_DTScK-D&A#@G,O(
/b2?+-I[0ZeHOb^GJC/U_X0gb#+,IM(/8FgC9GJFV^a542,O/ba7a?#1@\0a\c;\
R35^]U+g3-9aBAQ8R2R?eK8cCJ2ZI#2g5_3[QR:1>)@_O(.^U@>>2PK6_,KJCTL1
#XdTP35M#>@QX6\DPVeNP\<4R#+^TOSLe__\B3TX@JUfK-Q&_[;&GI8:N(_(YEbC
S+=g/_=6MWTb)6:3WZ3cYJVS[X,W80-PI_5&+\O.L4LbYec6gSJ?ScFS.[8bMgQM
5fI[)^eAf#,8N/\1XT=bGJX\0&B,.[aB9C.Ide2f/8J]7Gda@4D-VYLPPVQ)/5.-
_AQ,88M8NAFHO]dTG?)Q:B?c+@+Y+548?2K4#-XSBB]>VHZM6Z/(E/K?gO&IL20O
58.@1:=9)K29(;:gD5+;^N,=1X@_8_9PdT638[;Q).6-Rg(bQ<+I@bDYRQM=E3X=
Y;UR8;C2b7c-G)>I7RcVH<>^@RW;g<T-:V1O3U:G+)+I&D-^MY#Q?XO,H74fIE=g
KULdS5BLR\01((#J&P?D,SKC(DGPUZ=AGXXP(9F&#PI=/Vc,8FF@g]fIKGHbKY7Z
UV@[5O&#d/[X3bT=SXUf9G:OBb7Hg0)#AdW74?T_e#V,B+F=4X[ET4U05MGS_,46
dF?S;WZ(\Ff[,D]5./S0R5U^FO8^;Z^b3b(IVTS;Q51E;N^LUX8;8FfeR0Fa1V4A
Wa:VPeC,A#-QS\C-2BCG,Q2@JEQB.:QX\^N>)-/geRR43fT^4KDc[=4SM4>G?1,.
FVLf+fHPa[Zg>9YPNP5CLK^4<Z)S5DV2<9-1/=SegCGDLKb+UK>-@I2?G8B]VMd0
f5JC<c,-g:/S(_#DHD6YR49GSVIPDB^Y/G=0aRZ(#1Eg@fC4U-ISZ/)JJONO>XIH
[BJUHR</<01GTE[C[a_B3DOTC=\e63M5&F[<&8[K;D@dT<SM<CYWV(DfADUUIPF?
b@E]4_J-#95TT:VB[6XHZRS[Q&VY>GdDeVcS(C]ALb;gRcRaFE_]12_C<L53R+9f
/g?#E&ZbRI<O1BMUfBdO:fJe,bWC<7G8M;9X+4S4XEg-G.ROZd=:bVG<,^]&ROP>
[GC,]dEXZJTVJ(_I^>8B^4J&]Z)0f0/;\N)SX8P?NTL@(#1+RSR(a9cD&_-Z)\:8
3\]=FYTHXAO;-C;?20G;#HCPR7]N2g5V/KQL]>)^QC-1^d<WTCCJCdON#4>ESSXe
3J[N\WY88C;(3#SBK.N,E^TQ>>=42<-@-aI&KC=QG5DK=6e;/5FWH\[,](0]DGbe
6O..><)]7QYa48<#9\?V3fQ_c=H[5,]O^N9&;0+#PH-P;+-U68,ZS/\bb3,MCcEY
I@QBdd5#KM2OMF6^T,(\737BEQQQJc+C?WO=8N(_VO2[+eLZ:fGNNGEgQ[]cUeSO
;)VcX,N[#6-?AGM3WRLFG.?U@(BWM]PVSMWFQ=Z^3UMVPd[eDF[ZV]f_Ra&A,&FA
:S(TI#RB&&e;ZZb>)W/XY>bUUQZf6F1]#7eM0g;1N2N1(#MIa.0-#EZ<5g-Rc@-K
PB8W+U5SYeVNE(@ed]YYKD4c9,2W;62,_(NbIFaLbB0,d]T?]YOK0NgB&V#MTHQJ
0/;2=4b>VY\:NF=[J[_Q#+0O=OABKK[CbOWS4^e>\YK0F-4Sa-,,->>f<@DW-C24
QJ_##8^-924M&>A#_??^Q+B95T0WP4SJ)LGe4WNJ69gf;\>N?fDg07N[9C/B6J)H
YY>,eFX9UdX4.=\bE=)4H7M)9a\NQ2)P7Y66Y&&]J7PZ:CQ][Y@LXO3DN:+.65]D
,@6a^./bX;[Nf;(UY71A[K;1A#YH,2?LLP9c1/^HPYNT3L?DN72EKPeJ+\9CT6W>
F;@X.D1,)K<HY\44N5ITZT@?#MZ/[@UV9eU.CYEc(RUN]&;C#Y82)8+?afA<5_5;
C&e.Db[]#>I+7gL-dB6^LD981@?1QH]&&>a-:]=BN0G,2,Q;RZ(RT0@aN(]Pc),P
?fOW2L0Bb[24-gA2P#>U,@7;_J;E1M^8(JZ6=TE:d+/L_(Of-Aa\^R69OGeG^?ee
[a0+6&d^(a;?VQ10a(HV6_^V+/,W^Wd6-Gg.Le;GL1:0=H_c.+R?ATKEYYbDOB4M
W[KNGZ[QLOeSg6ECQS;fY>CH1<?ZZKg>H]@?0O@5H<4OcQVK@ZNQ.J^30Qbfc/5Y
a&(#1,##KIf^X(:]=>\K;+R1/>1B9:0Hg3H.>_U_PMeQT&EV)I,R#P,JCF=PfY&Z
]c+TL^Ib4;G-@>6d5D5fDMS&7e\.T(b([VR9+Y2@:T4Y#7CJF)#/]J/6>C:18;,Y
=?,=3#dIN&/,]^M=dCEZc&_+HGF6M7aY49D)3Xd0g(WKQ)dMA88H6d^=)MGG,B5#
&0USS#3(&?^Hc+A>Z70caTgSG[Q()/TR(ESbUU[RZMBZP?R2;ME]]6&Q#48M<&DW
WD^/9=TKQJ>0V2cfb4&EBB5@8+?;[A.W_0a+b_BP5g32FTZ@Nf;ODJKNZdO)@\)d
Q48:6+N5B8MYf2)/5+HU4,3#4_d(>OVd<0UZG1(FeA;:TYXbE3L\?_;,4R9d#:/,
WCCd]VWV+?+OMZNQ-RW?C0EKbYPS#],N>ec<X/5_dNLJYGEdXJ-MOCG7NcfC9H=<
;_TGL+)aU&SR2J<LG(Q)8;QdH?K4O&+X&\^+J]WG[<(H0OP_P2aURB44Q>K.7FB>
7;TJ)_cN3VN5aKe+-?)T=W#<F:T5EGY_/&=ebJY,NKTN7I]b_8<@X^\4/:B9H0Oa
6H#H96DT(G75;8b)OU)[e&1Rd=cZPf8X6]:LZe/W@H.ed:+X]&WY#9L.NPTI[[c?
D#GZbY&;E6XDXHKTFKA4c7?gSEY>^.:e+ALGDCXZ;+K-Jb4e@,C6,&R8,IU]eOac
R4U][RdV,29FCC;]8g4g)B.E9LB)<R7c:ELJHcd_aWe(^;R1f9Hfb]62D_6X&FJJ
4B0/.?_c29##5EF:;]:cF><U4_VXBL4CJ3W2KN^1>5++0;#aX);CT]d(U;\+(D=>
IV_W09fT)]KB5(Bc;WYIWO=K(VOa>?GOJ+,UPS(cPQ,gV.,a9#<^\P.QF+0?O<^?
B7:7f5LOO<DT<)[2dg.(7g8PDR6#@@5/U)V_VUUS?Z4ACC12(8[_QJ2IURTG8==E
,O#Z4IZ3-W85]U3?M6BOW<KMK788C\U_VV?TR.530PJ#/BE3-P,cC]VfQPV0d90-
^:_Z[9=^A[S:>_KO_UC@=M>4+Y6B1LU1&G3A6+NaPW:cbT0;?(((E\CJ2<E8IVN4
A^b6OG23#d2dK4-94_BM&:\U->LgSHMV,EU_Q7N\CJ)W)gDQ/F29ddHS\&_ed:-)
YeL^cV]A9F(]@9LXPSMZ@#<MVQc5\9d=7[L[G.Xa#6+3/5CK4+1Q[F6Q[H76R+NK
^HgELCac^]Q74>B@Rb&@^JV/.J5FV4eO]-#WW@R,.))K?Z+[3<[F:b9aE=&d4/NR
^A/+L]V:cI>T2<1_JT9=(LMb/&dFLYO&Z,YXb]UUS;(GOTBV?>KL.T=gKICXDABA
5IAGXJb.JG6D)STJ<KC5ED:;.E,FXW6Eaa79ObBgFf@McLD_(3f8L^JgY66S0L;b
.HI,?&<H4\V&N.2(L&&;EQ8_TW[(\)+:V+5JPd00HW&>\?Z6PDef>g;\VIW7:LWY
-:3T6X6MLD\Q8LU;e2@_;FfP;Ga.GJc>X?2Lb.0=.0>B[C?Ef)+LMBVed;@#LL<&
7>1@cTMg>[5SLfD[A:KG]a;T/G<XZIWa]bJP#7Mc<FQc+YMGaJVbG9&FeXMR(<6=
2,20f_OB]3GVFd0CPYBSa0JPFT6_f5<<I,3:d\ORE&2Q>(UD\:853f1=C@d+(3eV
IgXCBC=OeDH4HB2d\>YfVMLL1T1@393D@7d<.HVIZI6M3&d)JJ4,<A2-+bR9J=S,
.30U\B-?Ff/;0,V@6?A2\;)Fe75<L8T<,3e7&AJ/I?gfA<<DDGJHKcbZeSf&UO.b
I/+fQ6@b-?QEU]7366/dOaM33;EK_cO&_RGXa-E/M;1g7E3N,.30c5Mf1[<.LDBB
.K4M3-189NbbEP9SQM/^Ce99^g0c=ET[c3K./-K7cP-1BD6&H^Z]BG52I4;c:,+6
GTT1eT7>Nb7_0S)>WBDKTRY).Q-T6\J2fFgPSP])DOBXcaC_(/W&2JBAPZ6PV:D5
9@Ac2;6Kcb@gfIO+IL;I1OY:]G#HN^BQ-,]KfeCX6;;T)=#^a+IL1D-<MdQ3J2R(
4a1,5])O-8>AC/?-MJOU.aSIMYH\Ff[6Oe59=JQV,1Ua2<3B[^gBN<g;f)FX@]-,
=6./AVKLKU9RN>QK(2bad,L4YO7-C4J+&?]907I\5(^3WP,Tb?8Od4#,?X_#8N19
QNL?W@JEDM88ZDVQL6G42[JSE_2K6g8fUJKTKU4RBCDLa3FL:Y=_II9RKfeL:37E
4)7RC1BgFa.R]1[+(DB;PV[=IYJ+)^EXFC<_&)^(Q5^FCGDGH[)8TQU7Z_8AB4e&
3YB9_G)NYG1D(\6GOG5;PE/?fBFdCDB..Wf,_5-GUg4<R^#[Q=])+cSINbgY,(]=
;RXA47\5DgIP?T[dYRI6fKV+&G)D,4c?[OFI/33JK<W/5F+-HdJ[99EN1UM^I4IH
L5)@:F;8]eeTHP>_XX\UZ00Ig76X@&QQ)U#BP(C7(^5([EZ]7&b+&[,4e(c<NE\a
Z33WQ>H3U[9@F[LWb[<K+CJO29^T?eaWOGPgI(QMYb7\3KO)3JVS=HP0<6VC(g3N
E__<0,];@:GTB)fbCad+M3<EXI)8Y.L&G&D3UWdZ+&<W0?9C\LZfDLY0?[DCM>6@
0_C/?O+5/6;6IfC,143[G@2UaM2;/?g]3@EV9Q[L?b7[68aXI3,A,H/d9<W^@C[a
Y)(Q;:F0/DMfbDK<^B/b5WLQbEFMB_<ZK)7BMb)R(I&Q1V6dIdSAEQ)IU/@_<^J_
4c2:S.fGSXVecL#3:VO:&-YO]G_T1WJ30BKOV/L]13TG2JMS3Ua;Se1)+UTJP4JP
g1VfT2Ubf-gJO\1+XfP^OT<QEeE@0@)W\&^)EOGHY>/eUeL_Z#R:13g9M.)_:[c2
J=)V@FDG365Q@T:E?A/?PL.4[HDM\,GQM>XR>)fF8K]E&BYO083f[[/^8f.7V4_c
e0T4CS7f,4.fJdG2a1F5/Ta>&X^fSZR7^gHA&#ZY<,&^M67@M&UIPg0>SZfN7GN9
#_CEBPA.O)c[cS^Ab&1N/J12XZgL38Bb/1WgO]eFW-9Of8X:X,<AW.eAZ&-0U2?g
g=603eYe[>>9a\H6;>?Y(-AZK6Y@=R;@a-=I7DG)1c5ZRY2Z6ULVJQ5e>,-E_Z]R
?HWSY+^_@TN4E&-g^D0Ag+O?&\I(A<U^J(P;d+8R6T(?VNg)PHXO=@P>;K4#g4LU
.<A_VKOD[C-Mg@0XQfe>XPN,eP7W&FHZaGP&EKA1QLVC[&;^6c(aTG0X,_ODPSB4
03G8<0eH+e][@2-ZP)Z+L@?DMA=M(Y9867N1?0<Je=;4L@b@RDV2>I-=9FQ\)6VH
Y+L]O;f@[ae6[,>.eGMIBIN=>c4MXRLEDeY78@/GPH#BBbYVM4O^#ADI_2JII:J2
OTf9<aaIYK<@/(AF]bLM>dW9[FW<Bb5/]5M_/DYgY)]=3I?+O+^5-/E:FH4ePWU4
Kf7W@1CZCB8S=)<D7,WVfBWdBN.:g=7Q3UB,I^FL:6R[4GNNa==\=ZbT7e3Fe[aR
59#Fd[b[Jg9ZaW,;[K>QF,a58M]dGC&]UV5)RB&I\U+XU([G\LL>VW0KP&(Q+cc^
b-<]8OK]R4SE2?J#V;+.BR/.0<c+@]FSSaJXK6RR0c36#K5J3W[QeUGX?f5?]6EG
/Ia0++\-c=IVMa-KU/J,+BWA&75Q4:.@,SW(+a0bG)eF-U/C]V730<Q^g<@#KL=3
4Z./4M57V<0S(E,/Rfgb=<1g<(J:2K3&1[.K(F?f]I+Tc@4V,XdeR,ICg-&NI8&c
9_MMA8\gI<Aee9T<-(<cDbBLaQLZUM8e(7a:>PAfZc&68G8^YSX+;0]?N:fIbb2f
[?ebWf^/9@8LgO_O.WFRONeITCQGROea?+g:VZP:1/Ug^H=6YH5+E,:WG04c\BPL
[Y._G&KbW.Gca3U<Z+;ZaDQ)QSTWf7QC>E.##eN)-gc,)M6c6E)b3)E[1@Bb?gXJ
P#F3V\-G1)YO1e;5-G^Qf9SHD2Y[G6R(0RW7E)(H)gWg>JJ,#5L\A.<QW0PD2BMK
WfC#AJRI8,K9AR4g?4K0ebc/B6&E=W?3c9g)].?#DbRHQI@PKPF39M.E6\[38&:8
SN(5.BBMXZ_YV12JM5.9fBX@YPBg?:X1;+\HAM99D+A28J5+Y,,JJbBXC<MWL>ML
SC>PU7b9YV)M_f(R4\U?5UgXE(<C?5G[VQR3AHX>Wa>W\9X3ZbSb,XaAXGQPOM4K
P#dOSSSSeYCVC)VXH3-^U\MV/.c.)0f/.[K)TLNf,f4f2g]M>)ZI\E/7;DT5(^3G
1a<8PRI8J&BDE@4KX3_D,56=<H:KFP+)H?5:IYg@A)92UJHBFFKD[+L^XN5e^:bG
[UPINN,GWP;)OTXfdNK4?g.4J5UJFa0GX;c>P&QH+80MD4bZ5e-cE?Q3LM<HML\I
<2GSN]Sb:d<b<5_AMESHJZ)cR:15N2#=D-4c^NR)[<0Q/a@&<OMRF+.a\5W+^=d8
)DDOQROcJ31Y5eLOKWcLSP,0gOKX@(W).J&Ad9fK88(T6PO;/af?K?)[\7QPNd5M
1;T-C@_<B[f^4,CH0B1+D3[9T_:DDC]#EKSc8^.1PA)30P[.LWL86V=fJVU#XD4(
F\OYE.SfdF6WQ8-A>N+S(^]TMEK/-91FX/R;73TH@K@:H>GLW7#d,]_6)W]c5JMg
H,(+W9XWR_;dTJ[MffDf:VSY=JJ,5WMB/33cXEb(c)QW__\2G43C-E=dXR8\PFga
C.=S),BHbcGf2Nd9(IS[,YBg&?B=@V5TeE4G7/=CVAJZR2^RR(=[TUH,NYG1?^8)
<eVR/8OG_@8WDe[XQZUS]T=MeH.A:R7T?(.<-A3@C)>/d9Zd.H_,#Fg9W<AN123f
TAP>9ab^.^-11TWR#DFfT_Z2#EY--,LG_1,<O6@<fO;U6<&RbUP79&.HC)\c^Mg^
3IO3aJBX)=bI8>QU6^g,^W8e;#R-eP&]d]#>e94QF8<c:7XWa7O1^CQH&0PJaUM2
bTMTS/?R^N[fYEf6b9XP0>4DG3BDW[-e2)aPM+WWRO#QO\].?<1>9/e>IF+]g)W3
(^L+9:fGc>1faN8EKPe/6:GTWH0E,;\a_aGfP(I<M^e5D7;89,K@_XI&>-XceUOg
Lg#<b,9SBC&)F@;5g[SI5V34OT]<?X72O6T2Kc)O^)T1V4e19+^][K]?_NG@YBUZ
CT@)c&?8&EZ?UYa,MR;7,ZP(;1Q\#2P2bX30^R<c;1)L>]:4MbafJ(cfe<J:]ZIH
e\G&,122_[?\HNH-<Y@D^cXP#@L]5V/7<(;+Q9SFC_C(9&PC@3D[1Gc>S_4BO26[
CMQb_HE<NbW[=dKNGJ^Udg4LWNP=Q>O0M?:#fW9NO\7EfF7PRBTX>6PBf[BW#TF/
IAb:PLBN+I;AD#URBWLf4Rf0,EJW#[RG)[HJ,6Ce,FYYST7R]>\A=&@)>56)C,30
F8&dJFW)E__B7IU;VTS(\KB+PFVE+C5Y/6.&f4S1SB#YgX(;,QaLBQeWSR25HFGX
f,e4YHP1(4Md(;N1Bedf1G7cU=ZZKb90Y\.-L5241W&):7FNa/e_+OUPY-,FF_\Q
D90A_9-IWVc>.(d1S^9Z036HL@PRJ3<U>DW2Q9gg?:ePdK9D+9ZT=:K+[,.(;DfD
BGLD[&Ha+ICg0U=DN#O>A9^_KceOV2\[X7GS-)g@O7[K,f6d^;GL=L\<,fI.0+Y[
<^JRROR9R;DCIfWQ:c&9Q6?93Y8RXD#P/10+E)68#/,@<B6H7L/9+64.c-Z>QWYf
@+I_[_4P.B6bU8gN)I/;VW1)^^S?U^V;,d9C4W,Z<PZJD:f_)KFQI]1QYQ9[:Z,.
D/615b-]X5Z],_=Xd__4#]TH.QXOdQ00<ZQSJAE>>6.G-F9Sf3g#ZOQ+FFA.C:7.
WC.OGP>gN]>CJ7\2f4NF;TI:eMeTS=;HLTT&7g-fP:^=g[9eKU1O35b:X=KNb?TY
[S+\[Ub;3I1FTTd3?S&SSf7.He[I\O1C16Y5Aa-9a;Eg=GYQJ9fSHM/&-P8=P<@I
:WC24A>R+XI0YX>.P5;MM?:N[.TU]GBWNL[SF9_1#d([9_/Y6+7MOXS=c1d8I[a0
5+I22:N[37Uf?EP><@6UJFJ<d)aS6#:2Z1Q_AK-eI2JJeK@V08PMGKg]\b7ec56F
e^>M+@V/H>^&=B)aMK4@PBP.O:CbdSR.O3MF]2b3/DBE;H<fb;ON0@-/F(gLO.Ef
]A<S/<?fX0U2FES+KLJ[\O,cc</9Y6WT6@8/8W<8G.767Lc-<a2FK6+P<d#VA?M>
5#YGO?LSBf>IAMV((]=f#RW14e\7cL0eK/Sa>9WH\fG-.LXeY>3GDIT.E+T4=M=U
\NR=7Q]UK8VK-f4cR&dHF&J[LddM>-[K3PF-X&+>?\IQ40L6eHDY#]-F<X:fT4Od
X9,,;,>:<9Y:[M<EJY7Qe??RC)NENaBQ+4B6^]fSFRNM1;DeU0d)YXb^UQg\Q3B=
EU.)8\7I0(LSP&0WVR81MW_6T^VN[[B\J0J.UU#<2O^I1;\F^T21CK0-AUZW3B\I
#(9cS(dfX1#4(X+R3-9\P)=>+\:Cc-P-9T.>Va^@)bO3@&57740I8(A1gb4C/cDV
FZ_A:#7TK_5(&OMCS3N_66[U@SY3H^5H)^_;b>:V?Ha,/JQ-3UI<U)e]6&#@ZZcK
JE73cd3OV2Cf+F0Sa.E4B(M36]:39X_J?6H?JT/)4EHaEK(FXDC;K07fH^0QN(NT
<_+cBf8Yb>FD^C>+L(P9ZCB4LBWe?S&eVCOV-N:G<NO1J,@P/N+Ja.BI,a+K+:7>
e/g<_.A@G#;\IG86V,&dXMcISOT;R5@?0,R&c@(5^Qg&e3DcK)UJNc<TB)a&2cB7
Q[,H1[9;C;1L/2OM8W?E&Vd\&T(745.=/0WOC<X0YXSeJ.9556>0G0:/:2//[?H=
X#CaQEE=ZF=2,,;5\40fUa1H4_0dEKP[K+&:Y,SHE68_9TcP>&QT?3K_W-eBTKE6
U0B=^M@?\dH1L#d,[^6K,A-8P?02KLR,&BLM)H1Gf(P8K:]/;ab<V(O-,2KEB\CU
9ID-L+B/^1Be1FU/08G+Tf2FZ.SPOJ;+a=E3/e-KCI\F01U1<7:TPENA&=1K?#@e
M3^Gb41e,B,6XAd]b/RLGK<G/0,]4V;V;J7E4OVa(M2=FdLQU2IdPbWaM^58N]-:
PeUcW,,(&YQE\YP66B>)e=^[ST(.#K--/)9[39-L)N)_.ZdSJ\2g14aO61OXQYP/
^EGZW240?WO]DFYRH&C5M.N4W^B&JR]:Y,CV.)W62,03[5:[XN]K6-IF<45f03YQ
ZBdB9B0.X.da0Ag4U[MF1Ke]=aW>\F4>88\,MDWQ3XY;_C2O+g,BDR,-&0S1X0/B
:,YG=d_=Yc#N9MT(ST;Ef:Q>c&PD_U=Q6]eMXe8+<A)cU]\OaXPe[.a5VQ6Y&e=S
Q:CNYL8B1fQV>ce.D\bA(:NMObI)SQ.UE.0aPUAa/8R=be&M?UaCFMUI9[M?VP[C
SfJ48M,bcKHX+_cZE;5MR8.^I6D@X&[25c,F(e?X2WcWA_D1:G\69K:+b^)6=4c,
5Y29CcD8da\(WG/gf@SFW(:e(?(b3A1^fOXK6]YMT.3?deST,?>bB29R-ZfdKKgb
,3/GF/BM[c2bdLCZ.Z9F)-O#417d_I/@I7S:8e.F4W<gY/fMe<@X4^fDc9OdT)B0
W^(.)(0:SdC[><M195Y<eZ@;Q:N2a-RbXP?VL;)D^@L.0?2=((\IS1N<03&eD7Bg
-FTCRQ=49I>?5g)+Y8eO=TS.@]:W_e,SgD^^bS5R/)P/8g(<dUN7)AY2T01]UGU6
A<VVP>c>#G-GVf,S@f0+WPa=7T=;6O5G1Z/P+gbA+6a4E70\.3:7bXJN(2[LQHV0
:(DA)-;?;gLJ\Y?:-1fL7Ld_:T)FMQ)7JgK&4NZX+8DD-QH9N:;+RALgK+;I5,BV
WW=:.3??;-PMB17aW:DaOA:(F3QM67a#61=BCa:g=g,TAP5[IEEKB,W<;<L-4::J
E^04+Y8=c)4.VTALQ.b7T(I+2KQ&#eV+B[LKQF?;Y\aQ90<00H0:./Q(@A8L9YCd
IW+7P-\(LV-bS8^-O#()Sd6=8,AcK(A;]XPdIF^OJ(]9+\&:aEUZE:31/S+)RU\E
?eDb4YVHXZ6@2EE_AZCTC+^6>f3]:ab6?Re5=eT=QS]L3;F&5&X5\[Ua?VSaO,__
9Z33dTDc1WZLaN,8(f848M-I^fXG6AIUA#=LZ<J/g4IEO,5N;Bf3BBfB3TG027;M
6./[7UQdgDP=:M+,TT+]#6\^GZ/6.\cB)WIUO2OU/7<@:)^1V6DM5(W4WPACA0(E
1US.8IcC^P:+Cb5U3-\_[g@/Q.2[CO3R[/5LC2g/U7eLJ?)cIQ9Zg82Z[6KB.b:N
;)RF^=W>L.Fc3af(4JMbEa)D6H=^93/7V1S;CMZYQE3ARM6>e(5/g-HJgZ[JaQZ,
5&TV3g3:eF>WD-R/<1+<J(NX/((dg):JP3ZL?S;)):aU?H/O9M9-L4=4D_9_BSUf
bJY55X?&\JA,g;KGQ9RC2=_(aN\W1PH417D_5F:3>,.K7GXO@.Zb[IE=QCGDG,K.
OeZ\DE-g(ZYT5L-(,Ue]<2OKFU@_HA=gYb+@781_/,/&=VLQXDZ,&<1b1V.3C2U#
>=>:Cc3UL(7.=X1>FP#GTL)@;fQ,<FVTg<IQAZ/;JL_0C2:WI?SC=DMcC9&M>37?
I#+^OW?>2:c)V&/X7C]6.-W(;I5Ca#8.]]G..V#58H)IH8C8+beARA>2EIXID=>#
@BI,Y3GA_f?TTECRJZK@D01PP)^+6:d\2KTR<S2CQ0C/VEG9\KfF?2^\V0+R.8b_
&:VM4@MLGcNXSBH3489&U5)#V^B<g^&8O-W7RAU;-FS--c-6O4ZNS6P#>AI#XG2W
#N^R-_4c1S7_g;X_7A(:R:U-K9c3I<?c1X:AK#9UFQ#e-SPZ5?,6=()EW?Sb9-<Y
;54_V.F<@MU,E\UK4R?QF3KS[[U=5MV.DCBbD+@8FTgEddG1b<-\J1890K-EdW&J
7;VJI4\dB+R2B4N]G#26/?3(@#IQc(&^3-acW.X5+O?+_a-,c@?NX40B,4g>JXR^
J=^/\aRMVMMHSA<8B2QAOe-?e\Zd-cTM>O8JA#B>A]c)HNDK_9+4SE^ce6@KNH<g
9aJD;IYeCU.2b\^X]91P@TVP=3K^8H85\<@[5IB71-C/#AC]gZ\CgS4+Z-OP<.bJ
RY96NJ5@>05XGa#T9GAR11\1=MQI3-.]3B0a2bb[ML6cKG/4>GeE=[3)YK(+?EDQ
(]J#ce.PDV_0BU\5J=F4aK-,J.T-_^A84<M/^76gYUZb=TYF-O=dSbYK,,bE6QQG
X6H0(.4O;a\Da9W>aYUbY972]C:fT=1,1]8\QKF@6?cf.(3UFX+^+Yg0L3Q9(;^A
SE1Z:a0-6;A\C-#@NT837Tdb]6?CDETYG(@ED-GdN#f??-dC_31;.,eC]SU_RV6/
J3\3GKMCO:DRL.&_1-57QFD<>UYb#;8O5?<6V5]06N8=&Tc<+F.;[8O.Q3)Y1S;7
8W0a9/9->+e-Z4)89_I#&.YeX0+4/OD;9H17bEUG>MaK(>\X4a[19/FTaALA1[f&
UP:W]W(f6G\T1KcY28P5,W<6]\VNIY794UF,P_2cTcb1TS>MdK\?ZT-(7ESQDcTF
2PfINL/^.aJNIaP(cS-MdEb/\@J)-6IcF(,#=WA)7(gO2CUM4ZaZOV>O^=8S]a8G
f^>^X_]^6]26b-B&Gf58C?#F)#7EI(Za?Eb03KI-L(aX:EJGf+fe@@&c>8Ld>_:-
Q86dVM;S<FYX,C@4--&@EH:9+XXAK^)4U<UXWR,:CF7HY+)PR_Z.^/cQ(+3CW)#:
+YZ]\1Y.,>NG0ZVge=KgUP4MT?0--J]JCegYA9DfSH\)fEd\ZN41[266SJLZ<.e_
D=a1^e1R8C<C\PaDGP#-9bEBYOU\BIP1T<Oe2]6=[I9ZVcRK#=DA\E\]E\</<b:1
O-FBJYXPdEdZ&f:JA./-CQ25BVEFgWGcC;1KF1NGZR\XV7)-L#cM871Dbf+,RZ/9
OJD(IL)G96FN)LPJJ@V[65KXV)>LLQ-]-[fVf5WL(FAH:Wg+8dFY31Q;(&CXd?SI
X=c@.LUeEJ5^UD,2YM,KBJ6F3Nd.COX_Pfe]?5<JGQ)gYRZYb59Eb0YA>IRfH1DY
fYH7E?Z]EP6]fd\6QRS?QJCX0\ebe/W2R@7_M__d=c)/[BF[9R.\]@J\=9L1<?#>
BC3&)8>8-&L4H8[^\c#eFJ]7a(34D,[g7KHF[.;S60P?ZRE])2D28>2]LQ,b?f<+
,U[?W7,1Q_IdHCcI7;4FW6M-UGF.dWK#O>eU3#;Y\U0>7<V/D9UgQNPII#9KgRNH
)7KR#Q)+N@0@5ZDWCcR#@TRU&<1-aPCC;5gCJca2HYYbWVQ^)Z@?OFbgZg,ZR<U6
N;fY;:2,&?E&4])P-GMfRQTbVCBgH427@9R4^?<3Vc#@4b(4_H\c\&VXOcN78A&=
?6UFgP20-d?:]3+\DJ.<WPC?NfI[?_+<_;XL<\B:4=X4A+[f7/e5CI-U^NEDW,14
<eW5DJZ9N8G]V-?HQ9Jg8Hb@UIGEda_:&R6WgUg?TCM,8cA30&Z:d+.NF8@cFM;6
Xd#6X[)15YgBI4/MJ25O20VGX+SY\=829egJ/fI]495P@bQ:6N;Mb[D+Qd-<L8B_
[=GAg\d<.b+W(SM@H<:Ca@IFI_eY6gP_<6JW]\gcJ07+\B&O>Fc]T2GB.2T+Y:X.
FP8+ZC1DAeBISRB^/K0d5+QXK>e]L=Y[5ZPQT&;b]E+KTHf114YN5Y1WWAWK=YR>
;HDf#2Fg7@Q6Ad_Q7cQ^/]QP<Gf&;#5<@Y-/VD<+deZP/DO9IB-<Y4_d7N4Y6&7Y
aKeQOT#+_[F=PB\RA_3.UH]f)ESPDWG7#aB@GDeVgb:).3PARO(b]a\g/K,[N)L,
4[gb[G?dYEa9[64g_:9NXVCNICCCJ1aL[AC8K-O+)&>H[65TWKS+XRDfC?N&3UX+
0=C?[T:+IFKN2J4M\NWF5FD\4LPW444VVD=#EW&dc0DZ#eKK(K&FG@01W,1UUM/H
L?;dAUg_9b(SQ:PI+E+Sg@M8M\6OT@\QT1:(YRLJ./R][.LZNC?4d8[.g(8VMMLD
)Z[PbOc1N8ZHKf4b/M4?Y#F]7A/Y.(.Rg?K,54DIL\5L;A6#?UOXN>T<IN95=LJN
0H<<;eeV5CdZA0VMgQd)T:cEW^:#_TCK6e]RK[_VGFc-LT3\9>,#YbW(WZ39Ya;Y
8H)^;JO?;\Wc@&3J6?fQN-2J@CZ=E#P>Je\.V-S0&;ECWcU&B2MO0GJ2[&;Z<^LE
@IANP6(FaHK?N0=,>F5[a>JRI;gEB06dBV60_;TC1Z(#SL0YKQ#_]H\I[XWT5U@C
N?2OHR;Q<8S8@e5/#^D[TE>62EbO25HYU?EGZW<Nd)\B<Y;GI_BZ@:Ud;FcVgN.@
\>4S&?[M[M((\bFUTK6L@b36M^a7R)]UR[Vf58((>[+[.HXX788\BF5g<f[GG<5e
9=X65-?J[gb+@MK_7Q,/U3DE7S^RGf6P:+UGJI53LGE11dd\,=K:T8_)\K9TD=SM
O_#+G#^Hb_V1^51(Y)7?]YS:I@2=(QY8XD.OfB\Y\_2G01YV3HS/X,KOZbTRgSP<
C1\Z09>LfOCd^DE/H;[RD087F+LUJ-]9VDWaZ3e7JENRb7ZOR/2Zf0#P2TUU/:<H
bS\Y_e9EI104UML(e7CT#.YDV+&d-LI3=0DA0aeB12a8YG)ESdQ2/>M(/P9aY:@R
]NOcaQ@4,<C1?4(ZYT=N]=FW=6A&+.J)Z:T57LPeF,OTf2N^E_PUU:2JI-86GAE<
_Nd<6KdT8;8L>-?;Q07=/@PcRG79U=^gIV]Mf#\c@Q9@2[]R=5CDcb+\,3H>8+7B
V6.gJU&YBT\)DRA]J/P[2TLA=ZOO_UBYOEG#[eCM/D+&PDRK\K_];Z;J3>EADH5\
TVR-I3>4B8e5>M&:M>ATaRf>O<TT)OV:#-5,T\;,I^V=JQ=6TN?YD\1gR5([NZ:C
Q9MJW8Jbf1PC-W_b@ZHC^&@c/#(&c:Ea7?V2\/DBFGd_QG5:RE>CT.G3\X^;+4SF
[+ASC/D\/IT4c#AR,+^bY1X95SC?VTJCCa<VBUDQ4,@52[1(@&:8g0R?Z<?3Jb.L
[+4V<3df4_\GNA;+O7J6\#.35DXKeWA><\#,@b:=(8H#_ff\=]&c_>]0C>DcI8^d
Yd#L9PDa&CQ8^T]e3fPV.C4.cG@RKb#6=ONOaJadA=BS.YRXfF?LVJIP)QaL\/&,
3.e>[fTcdA@2>WBZaX\&41O4Z5G^a?.@I&cXc[#5B1eER5?Z/M8AVH;CCJ-I.-)?
.AI?C)082(\a3&;M(Jc]ZP_>67C+cSC&)+MGDD(L+LSXW:fQd=Q5U2]Y054Y)ZF(
JaM-AH6H-Wd>P4YX=^I?^dVCYc:CR2ED9\X:P0L/b6ZdN38I7&Q=\g//Y35gNTEB
-K9(Q.C;NWW=P.#YU_A86RJ+Z.ccLIJ@WLZT<bLge\[Je5./T8#/@M\Z.c/c6FY6
5eS.BZ>e+1XH_a8RfEcdX@G6M++gVX>;GRYY#L^C>c^,XR#J/bd5?2F]([N_4W,:
H&;bG<_8I[?S.XbH9TA17-0SU.1[M]BfC&NO0\7[3;+U\-1IQ(5OQ_6G+/^O^:J7
:?VJ5OKJ2c_-44\aE)8Q,CEO@J\P@_/^IVG_]2eeg2SYK:d[AN]AJVaf_VLY&?OY
@g_0,KZG5NELACYQ<#[2^6152\Wg0;>Nd)D,51[\7C]LUOcJE05F=]3&DDFO^f.<
G5#R70HR?46[:WWSgf>\f1S647g@R;(N&=dD>;FUCYEW+IWe,]VcW)a+Oe#9#fZ1
^L1GSDge7X@&>7aNP2(H;(.0(1G<TGFH8^FfLg?^#Vef]gHWF1dLZPFb\MW6IceM
Yc[23<IVf+9fX\>7,BN9FU&:BN?F+.0H4)cHG\<LVFKM4GF1I6F+#++/79(73RMY
d(XP,:ccW<HW>e0JU)c&8+7;3YV-&TfA,5D&;Mga+BA#7AdX&51/4FJ[.G2A4E&Q
8?[[[>;=Ob343S-d]..@g\U6)2E/c_5G]:7/N4WCH7WR,7/+^1_9,;W3>:3N-aCW
[_:F3V[DEZD^)6#I:(92<O>eWN>#LW3/=O;I46MMGc-[(@;RF[MRL:?HFb=(-,Le
Z,AFAG#(TCV9W6\(VI\4>[>FK]D232;f0B@_Z5K\<JbB8,K[D.^)B;RJ@d?6JdU?
ING,9OE8[Ac[KN/aD#^gQbGZ/9FW7SAYQ-g:EZO&^5K9eP4:VgN[fH^JE:2?_HO3
c_KI_cPaddA#g)T])96aVO;>Z[H)U;I?IJ.<I]LgUfb,M+;6D&c)12@-I=Yf@#4(
#1>\(g#3Z.4BTT4^3.TS1HbF\15:M^)MeC@=41,gD]O1#2(Be9#QQ[c>b)R:TE-b
2]gUJMdCS8aYT3#FB0K&T(_8RPGT@VZYb8\8^K4Db#Pg=D9=>CQ^5ND=UXc?b0)L
1([Vc<OI.0,3XO,4(b0PBGB#<fOdcRH^&]8Tg?ge5N0D=PV7@1^XBPS:M,5L=O/+
fHVbL1\.Tb[0]R&-&]\1:U6/8R\G2=W2O66/Na_@EC&Q0fY,Zc=J2-VO[:a&#Sg[
QL._bcQ](bLG&bOfeYHORD<N/39gV\2=cO])C(g+He(EYgS>QfM7X<N+@GSMC;+?
4VR)_^Ib&E=EC3Ib+ND]+F+,cBS+f6d-9b8D_1G.4e2,@Ib_E_fN-4e6d)=_b3D:
])\g,H@GUV;@O-SJd/DgD^W@eF6O\V;OUFcJCP43..2I577Z5-<5]TF8a>P@[dV3
1V]>b10.:_R63cGY91P0W^S^SGc]LA/,>.4>PSR:I4TNe^59GV0W6\e7?3/B?3>C
MF;eAW<BS5.AX#ZRd-OBBRg4B5];gA.R(_>3V<g9D4/FC>ZM18A7H1faeT,)LMFL
-FMW<<4I6CW#f_@X9I_7:0H@\9T(9b6eD>&f+3g<#S1IMQ0]=D_b8U]2C/Ra]4T<
QJ(bX0=3K((7gYC4:ZWJUX(Yd<^C]A&eE]AW5OA0PV+H81OJbGGM_43]45>Jc>g7
f]+&-P7KN<fY_IDO#G\8@=5+fa/AaO/dY.6FE_P05[/@J/HD/4V+<TZ/>7#8R_OR
7P#VY9a&S^RJ[Ug_GKXIURY32,K7=0UYF9I0fK?4>YYROaYZa03TFX]K/V4UBUGK
27?#7^F08FWUOJ<0EHH;]WI9&]9#J./07R;F,-(68V/[&5WK3cNG.\BO<e,;1DV3
dZ>G]P^B#G:^U^MWE0d>\(:gf9\S)f^P-U=J+]K66GA0[QKSg/M8^G;[fO7STb#^
S(M89TZEF7UC,g:HWQ,-5;9cXJSH<)-_]RG7?84T?/6C37?]T\MWRHSKZ.QPJH7Y
KDYOWN<X4&,G</)/f>ZQ(_O+gb5TM8B&dW<I0\1H:8&RN-BN50:.6EN<OI,5&aZ>
\=7526\QU.F<cJ6[1V\9^F<47B)a1T^.3:g\f-M^a1cg[@acJ<.V:g0Ced808X&O
0+57&R;cg4ag&GMCDQ#]6YG,:&#>UUGSOB-1e(^H=7B(bY&:/3@33IZ[QOD]I<7(
OA,dGXEQ?20^\;/G.:F>WG1#VLM51Pa.#8_VS+-7[CQY>G?J-30;Z[0\;&F;KHW<
W>.CHAD;f0-dI=Hfe&\];4&1#.a])d\PMX7bW:7@O^64PXR,EWC#FRg4&a&<L8-@
(_<(a<AObHc;T9__6OR<COZO[#^208U-9Q7d[I,Z7[d4:TMQ6O&SeTeDf=4)CN1O
:T]8(CUKJ?^<@6I\#/<3&1I:-Q&=bV^AW0c]&LXD\CTSBbB@c?cU5Z6HYU^>71^X
69S/XWD4MTd\S7=-C7YJVg5HHPNc^1[N-TD;TW&3J4=EVPHRRVBSM[H4F-aF[gDG
LPK.9MO;>0;A&Dd(A2L9(JJ)^C(8g5E9.]09faKN./N[QU\[cP<-&;V94:>gG5:F
XE#?((7O;eF/DKMa@C-/J;C7CA@T_8/&KcCQVc?SQ5:,aVAIR;12]37F-A2,+7A+
>BHU>Z80CVI5RSDIfgK=IbQe_;EgZb8f>O&=QM^_Gg.b]XNPFT/=N?_N<e29(@D[
9PIO)S1:EJ_bYOdZ-4H(V8KI]\_P#._O\ZW(^RIIRWMX(7^Z]cF;VbJ(A@R/L.bH
?;EW+AFCFUE;VI51AZ?2U0E4Nb&fB<FR[+cQ1P56@NdP-5S)#]I>^MBe-^9NQ_88
ce<P8FHIBZD5>C@]1e_T:8GE^Z^0,]^TVc3c=Q35;8J52&23H[5;?+ePT1O6JaaF
:^?.,LZf.63)L=WK@ggEOBTAEH9^SB<f9&&TD/:cWTg&9b_e=3?#@^VRH35LK#</
:#5>:YH\IeRBP=FEW6B^BUbE[^Z6EEUB5c\@7P^)>L#2Pb=DZDK3SbZd3@97,U\;
NK2]K9=,C/.<H_=.,#g,W1GIbE0PN[[,gXgI2(]DAY+La#@F;70JIO>P?\J>,e]?
27HP5&bJ#X37K#bM3]c,.\IeFP(^c,?b1/]a4W?U&e_;L/b^FIB502[--d&J>5P0
^SgXS:>LA=R+eJTCJH(G<8.EeQ^R@<SA[]S8F>Pb0<&G:.\I(4f_X\a5cDG/C)25
4_.0ScVL#;^@ZL[\QQfa&[]4;E&08U+a:,a=M[Q@4(U-BdgOV?O.4YWeGESNX^U9
#GOP0dU-)3\g#a,4:D0CL)CYOB/64H8F8.,#4gOZ<]>,d2aILBSdC;5b0[1/DOG:
PT]cOWP?DA75,YbCg<;.FLb^g?[CG?g2g_W]3&SV)(?#XOD\ROZE)aD2=eU6gX&^
QHYJ/M:K>#9<E(\8,UL,L743K3K711(CTB[EE+ZL9GNRL+C5;/CQ7<8(>)_SQ;\4
3(a/daD)<0^GHc6AY13=?5;dLQXT#b)DN/Z7bQ89&+NO9#:d/<]0UANeQ:NP-b5M
<R3V,6PM7]LfbPUbYOQ2Z/8d_AJ[b#ea#g8()KJS-VE+;0::PH73)=B-LW4S+faY
<_G9c<[OM0@MI18)XM5=:_O;#-I8_]1W(EE5Y3+I_V@G1:QHW<[#FQPc&X_M,[D0
=D0Y8JHV5>B;a(VQ>+X<f8<]RC177T[HFb^:5g],=/dR=JcTF=(bdeL1+B81dB5S
CQHT[#<XcKX_ObF9g?NAFReb?]#E-bU9&BBU&8Eg059496fa\H49)d5GVH.NcD=+
&[5J9#(><]>;X@(QI;&].>F[7dVa;+f5bKR#L<8OOW-\N?^(/&=Q#Y.A=WK.V4?4
\H\OC[b<ULD+Tae-F/LBbT&4KT8H1)a5V4d4(FR?_FR@7U/=SE1bDG&R+=5225&4
@9LG#06SENFeXIX?VYE6c-f4C#C>5gc_AEg2?N]E;9=e.R>]I00]LJ\7]-g=V^.b
b8gFd)1>,8GBB)X2GQf:TX0d+Xb3/R^ZRUDVB#BBV?R-FF#LOMfG99?N@F_2R2Oe
FKSXb2>C;\95a#g(F9K#2eT6RU/14J>YB:DeZ2G8FD-gGKH><Qg;?L@G#(XF)B#Y
UT9GVU1]3E?=c[R_B[f8823.37f69C0)UI4I1(.U_#<C-[MRAP^#?,FB,D^7Z,D<
?2Y4)D395AcIe1OYRcGT=RQH5cU6.[QEHeKb:,T:I8VFEe:]U([C7BO?bXGR&R=-
CGXU+VY,aY>W=MTV(G(=eNTcc_OR/CZKD,g1KO-MP\EgQ/9#UZE<;0774=5QAV6.
dGb8LV-W0)=LI79.b^YLR32MAN\I^7E^@EHU\\XNVALgPIKG\+O@BQ=BQ@N5\6W,
f,eE2eP]3>eU:-E[0^BLC(LN#-F,NQ3;2E3G7>>@Td]+ODdM4a-cN<^Ec,P#Z(&9
g0WK1FFUU+3NaC,Fd;V@9G(gICWQ5[LF>5==0:DPJJ?a=[3(#,f#c?_>O]W:F8L]
YT>@V998I-GNRH,C7egYdCJ]C]M(H7>][?Xe]CXTR?428PXbP:RCDX<N2D1FAM\,
95BOEU2+TcWBYN.-&M8dCdP&WTaC^YONG:&AgBPJW5GS&b2]A?,@)^I:(:0DN[[@
ASI>CP&.4J#?TS[aWADZTU0JHI.G0^.TF/]2g_K4J7R2U+Cd2PYP2D\29=M<b\CD
7/I;DDZ6INW(HCES\5P;BZ>.gX3f_P9IT2GIG_X#Q&4HUR>#?D4/#)SfZ0OK32I0
G48TPZVbO^S7=&O66d;gW<^0/KSgaB)a(<WYB7])]1LNEI+@JYaXgIV=CTY,B\9Q
TZ<a;,b0)B&W,U12I4BB3=&0&28?[Rc<5^^XHQ2=fW3e9VDA0V][3;F<\YfacaNE
A,#f?O@CIB7,0e[@YPa]ETFK6GKPG^OF0ZN@WIJcaJa^L84H=\;SEICXA_21M1V\
g7^aU8#JeT4P[]dJ44T7-D>b:#_]\d_W&TILVDf&Q&(CA<;803?&S;<Y7cU.,@Z?
X==3FU4H](FN)OK.2T0\(,HG/PccA@S;fB2dE+dSRX@GJ0>5WUgMATR\Cf<D3c14
B,SP[P6ZPKU43\9Q9R3\CD[B<K9c3f+JD;gM?):@S_9_C#Z@LQQ/ZRaYQeH[SgJ<
LF?CEKFXVX5IfKC-E-We5&R\c7(OQ8,Q2cAOdgI/X]ZfT?b+LM7>-agDLf.:B:gQ
]EQ+#IW:Y62N+S3d+;&(?Cb.I)L_(6B?)a.G\_cc04a#ZF:CbbK\dg9\^6K#2a3G
>cO\I6bYH&eed=_8^QRGM,1JIcWGETbZdfEMLLN#>bNTQD.CQJde(;I[0KJJ[SNg
?[ZORU^&V0T.K(#SC->D7XPcTEgH]V<8;KZMJL?N0f0S)Lcb:NE)g_R,c]E^80GB
4XRKB8Cgc=WFGFM;^3b&19^;UJSJg8B>g7/XEX;Kdc(/0=-GHc.Ce9D^X:P<g?4W
:1HUF0(Y,e:cC<)]@0a]E0?Eg=cCQ<R8G)CD,\>BZJM,KJ\DJ+^L&:<K7DdBWCLS
2F<TMBMAVK7:M4Faa==M,56-X&bL1SfcH5A5G,#Q1))G-;Y&1_0+0ZODAF9_57;+
A671DD,ZU:S&L5:,^>/&]JQQ0DRFgCD[&N2(7(X=4Q^c&:eR/88U&2E_cXEB<R(>
Sf(Z+S@b&FC>DTBRd@7L5;&S0F/T3TbW#FfXKZ_X6[0X5^LDF^M<R-3A]#NL.K_U
Q9JO4XL.>=Z</\SgI]7WN-+#f5LYeODPHJN,ME&C<Bg/=7O+ZBF.<fW#J-JK]#TY
a8A<c;F.3->Jf\V(MTbC_V+SC.:,Y.09[.f78-WURBb]7H\R.0c]Ha#IWa=W<-I)
ESf2WZZ3TQ>QL:1JX<59B?@68-8#V=R\@X8N?+=dbe9L.CA,Qb3^4@4B7e#@Td>I
7>dUA++XU]=VTaZ]]V]3D&c48>@.^b[^6[FAQQ#F+>7C,,+B<Z;,-]963QDL[0[[
fAGYag\6L3^48;5N1@;>.]Nd_89U=)1;SN-I0?1-BW9T@L4EMMWbJc@WHUW9_./=
0:N5g6dF/8M3WM@?:Z^1XK3BXAgWWEeO3?98/dEG<ZAJO6O:Z0OMO@]J]?MO.RJ.
99M&2Y@G+(85/F>OD?ONMDW=BD+Xe)7ZgL^Y0]+S)-Ga628+>Q+8e>P@+#=Ddgf/
X#OU0+,K&6&;f3a29^#]?K2>:\@0(C2X;2K41&e6dLZL+:2+R3dYFSM^aObYJ9Y)
-@PS_.1cgc;N;D[Z#]J&-T6CG<TML>CPcQ)R]\>\+/WD6XF:W.-#O1^;_UdQUCf&
L9g8c-D[N\b9.d[)A?<+P0f@?48b.9R2RH2+F7b9bEC-FC:dc80(<\8Lb07U?b^V
>LH0M\H(3aT5\:0E)3X1Tb1X?4]RD:#]D=2g3\9<2C;K_VHVX:>WfN47FAC<VY@2
0PJ_Da8GMX&A=2#X?c5eOZ3?=9&QQHV]E<>FcN,_Z+)VWL:@WS)JGW4JH?c,8)[Y
VT<DDZ&Ke?7c)SF9;@ODK=3NF0@BV[N7:1K9W_U>0DY.T[9X(S2?U:,LgU:/LUSP
>;V]\e\)IX7P#9=AcK]_@,(>7b]]?6-+3YVg@^(9fYdW6JKIF/2U_B?7B_HR(Qc3
5EE&C5/Sd+<@=8CC6I4\VIXJ>TN39a3VYfU\,TcPX/0+B_cZ3&7Y0bJSQ/<#T?GE
06\VC@f0721^/eO_dOZUAc^KA61,_cg<M.T.11eC^8N#X\63Td.YGPOBO]Y(L-(]
Cg6THIUa?>&@7@&9-DSC>e0X3/Z86DWW5^LcD,E&Z1LZIKZ[IODf20e11dIc,OA_
LXY#1#F2YEaM@B?/N,;d&[eW8g5OfL<Z&6_7DC]&-2=-\-M22Dbd>HC>38:+Tf+O
6W-RB>fU-28O]EGdQFMAb2VO+L:b:?3a2Qc=\]0=Tf(f^fAf^][X,Pc?f9^+.)4S
WD9_/-Hg(J^bIWFCBL[M>1UALK.EBe53FCecB7aJ_22KMU&IL/+,Q3V8SUa,QFe:
6#\&9>Z4=&V,-K[ICW=,T@DV5X-.dPTZQR5F)=-c1H97;7#dGH7P9K?+:bH5_(.&
5PW6P1B#\YFf:U?\B#E8KF)/^T?<)L#a9FV>>91Z1MSKST?F+H-&KK73Mc)P-.WO
[E0FA@ZJ+X&b5f\:M444N6Mf3#_#DUFAaAe2fRL\@J5Z(/+LaWY4YZIdB-F[IEH0
@@fO=3&V<OF3fE]7,JJH^2:Xb/.+aNYMB&AT7-.9(-P)4U9AR(SHF:2=gg<.@f(0
NXHG<8d/7Z&::^<K?9f(&#C(X.TU+,I]JOP#,(BH7]X/74c:_5R(UdX:JQ;GZgMc
[W:&=?Me5^g93^Pa5.80#^9g\e])J#(MNN^MBJ8NDNA#;;?-Y@FX5&fA4W]PRHGT
>.f;GgZE73[Wa9:X=,/#2&DDec>G@5W@X[@<dMI#/XHCbLP1^c237@Q_IXVSCc=U
FQ<WK.9gUfF<>65(Bf_;<(][,QW+GX\3C_62T_JP2;<YMX@@b]L_\15bLgI.FY3?
8._7L#TK=NB.IP==N50M@Vc139Id45D+?]e(Y,AZ4(E.;Z=R+Kb-DF8B-&JZ:E^N
dcb8^V^^JSD=WBT@KWN_F3,g;+M01)J)bc,Ce(e_(+#,.4JBA/CL]/I5)Q1N09EO
VJ@O/I,Y6-804SOH8K)>=e?7Uge^\.,fDT+4WNEM#Wb,#L;GXVW#7Z2R8LS+:7/3
V62U<-3#cLA^5Tg?(P_aA_I;K4Re+OB7OLLHYLJR(]:G#7e2dFOAbEL^ZTS9Cc0I
D[EXc32a<O4ZW)[,<-Kg4WO.,/Z_9KWdH17>d:C6:Z0XO=9C3A=57VL&5(]b4UBF
^=-e@Y=bg67OZ4W>-6^7?)b(fAQZK,//<,GRXeV4^[CU_WdKUQ_D7:WTVE4^Z\IH
GS@G1?8e\.W,bXZD3,SP&g1W-]&Z4FE,\cM,fHI/40U8OS\NJA^,+Ub(6g<&5KFE
<-.+O0SY30egHSS@A=+\^>YIc/#6J,_1^Tc=/B5(A#G^X)fSJ77/6\459)40:eMb
\9^V=TAN32BBP&L<:X,#S,<#O9AcZYW-Ea3B2U>6&;2?GfD(V43#8X_DdF:)Y1^D
^bgJ]^c?P/cOdgI,I1c^fEfG;9\-I-QcfC2Y[e^DMJB6EU3XFI6f\L[Ce/T;\WZa
3@LD;cJSeL\RE/\5=LMRDIX)aU>_3CPa)a-,^g+^c/?<SP(2Y>UTZ7AN&>5@Ge>_
TgL0^Y:H@2,fc:G<QD,?6\8cdKC=;UHB,;+Ga-9\f();1NSFNVGac]::N7C_5.60
L-N:\YYS30B?UgC81[b)FW./)egg_#@_YKDdX,;9/C&M1KYE3gT4?_dgGc@KI9[/
a&4T-XW8G5#JTZe=+>ED.,&H-,RKJ?;A)WTP>C[P9Y4<X7Fd8N9&Lf<\6?=JSLHE
9;,,H]KIOA7UfU#7&2^0NR&M-ZA<(L_GU+B2FSXaG?PObQC.2G9>8.:OI:d2FRC\
W+K#KI+bI:EY\T<5;1WOL9Kf?-Zf8Z[5aQ?E[4N@29\fER&[2eb(g,,^YR\ceL37
U=R0/S\9C?_7^P>2SXbKZHLUb-I0-2;5UIELW.a(Wbe/:I.0D?Ca?[(TfWJc(FK+
633GSL[9NK=C.7D>OW8T6/03gXP4b=MAUAQg[?3+a8N8YGa<\Hfc,BS&bQY,3Z8P
R6@W3Z,Qb<aAd&80OE0A80/Y3^9-/6f/-STdRg@H6K6SH8B+C0a/f6>DUN)4D?c4
^LOHR1RJd&X8:LE<:,Va^6ND^K?):VeGQXSS@?0DXT\4F3V@FK@Z>8fDgY_[6ZVe
46?X546DPgCZ3:/f7OG,Z9G:A^YO&0X()g/WU5DV=HWRUXW[AFa?-]B7<D=8)5DG
=(9C[?1E6=_\\044G-J4d5SC29X5;]A4O^f1(4>.;fPc@6DR]R5<A>:deQ^PQ(@(
Zg8#OfAAbc(E)TLa[QJG.g<_H-@<fOL^,B:3L4P.2gbFSPNV7W)2F90-R.],\>CQ
23(IfTO=G==a@Q#@@BH#QEf,-G5d\(H+,3B[AgV+3^>Fb-)g?5cIJQZO.A//V08@
IWX;DHDQ-c#UY0DZ0cPND.TRM@G_P?,F3Z:R]IMJ:Q342L,eDE6IE?:.MSC6^O79
XL1<6b-1G/NaAJ[:LT;.3_+5\7(^AKa2NYL9@0.@^PDcVedFV10:-7)eLa[-1bUZ
IM-I?UX,dfc=/,[JYY6FRSG\]PX6=e[UD#_W,Vf@e>W8?K-72C+]f247</MgFK-e
JV0^aT:EI3=C564?5&UCFfF2cL,CE/_1CAR<X=?YLWUK29ACK&95QTEI0OOCAD,g
?2cfY\[dV/eXY\#gVTENeUR&OXdec^,1W\aHV.aTb3T.FG;;Bc#e=^UI<2YKUM8.
&g&@)WY26e0e0SXH4V)>\_DWMbV#974S.aK1A2g:X?5<A1(U<^K0<O#:?/=R#0IS
1,c.5GE8N#DdJIW(5_CR1^QD8DA,N?O[Q<-b^b5J18KU-.fE,He8W=<[<-dDJ7fY
_CE#P7<:KG[I]?Y)2SSfRMR+_U=<&.-5-K^YKI<+IVS(>N@Bb),QX,gR?Y:@.^a.
g_gW(<9(S<08ILcRD6X(C#)A0&6TCd#VW6_E:d7KDL6R^FH++beQIBM^C[W9[8df
^/.NXCgbNZAdPY317T;FI8>5fOPFE&DgUT-[G-(,2):_eAYB>V8(#bB?973OIHTX
M\dY[?.V+XZdG(3XE&4O;C-W9Z@dCEJ@K3:Bc1VAKOA1&13ddSc/772SaF5F8B[e
WTIFJM2YDa43afR-Pfgc7=CIM#>HF;6<;>O&(1IafVDO+P,C@5FG@M#SO_YFU2SF
@1>AL09<Oe\H&M_0=7HU(3cgYcR.Wa[37Z@BA26&NZMZ^J-<ETE[&[S3BRFaRHAF
7:8=GS6L)=P,_RQIDTQ;O5JW+.\2,..PMgHQ-MVP/0C#L=^\SK\)BJ94IP5VfAQa
Q83c0IYA_Wd=8IE=QP_S+Q#LO[F9:&XVQ)M6&06IGC<PTf0CG@@CJN?++T:J\BVJ
T:X?)A5ADW.HFV[E\fd&P,5IP_O4^GGZgHQPZf9e7P3;d3IP=NS:YLY+NM9:SNSX
e9;\cOe;IT)cO)VeJ\8P/a_7bLFM3]aHH>8MK#>#-AdXRUGDbQ>(eW>>P+AUQ9?D
94f?7g7aWM_BN.C_2D.SfaJaJ;OK0a3d+CS5fLHa]@5UQ,/#=U4Q#[fYgA;9FeH6
e:e?c53T(R)UAH[X6M@,S[?:KI4aH?YNE.d<[1HK8UZOPNVeF86B-^fU.7WAXQ07
f&VYdBB+YNWUL0HE+&0C+NO@_@[J9J<cf9RY[QDK;5:#d135-\JC7FG?(B[>/(+7
1,7A7I4cgW]4LL]MX-.D[<O@8$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_MT35X_SDR_AC_CONFIGURATION_SV
