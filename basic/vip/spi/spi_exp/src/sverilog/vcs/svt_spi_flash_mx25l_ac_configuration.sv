
`ifndef GUARD_SVT_SPI_FLASH_MX25L_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MX25L_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Macronix MX25L device family in Serial mode.
 */
class svt_spi_flash_mx25l_ac_configuration extends svt_configuration;

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
  `svt_vmm_data_new(svt_spi_flash_mx25l_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_mx25l_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mx25l_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mx25l_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_mx25l_ac_configuration.
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
  `vmm_typename(svt_spi_flash_mx25l_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mx25l_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
W=J-;:X@N[<W8@HC3T7]&P@X&U7]d/N6^;NgJ@bWMHHM8-YJ&VZC-)g@a\RN?R9d
7:Zd5Y\I6YCSfE<^2KRU=3T5(:04K2HIK]c8FYG-=aZH2LTI0)(3I.;Pc)_F.:c0
C7SI+<AS8Na#-OV-1?Y\Q#:SIQ1.aSS[Y&QHSe;87B5M(@4XPV+2[AOWSJI#ZD6,
SLgS0E6>P<SS/J-]LAOD1<=QF^7^.H=@^14XZDWO)GSSBN=H8[Q\HT#f+?+?45DF
ALX&+7b0V^/WKRCPE],&-=:1gJV1AH8?_X1Q_,1ATFP@Y7\N>XK8CM3DG&[L/(.]
bKXLb-088,-B9Q@7_D/a5NOabXFHL5JW_Z)^9&-cV.:@fPOJEJ)SbMLT38+K#dC>
WI<DOCIb0cW0NUf^5C/0ceb\D=#a?S(BYc\(XB5H2?=e-?ORO2R(V;)f^S=4Z;C/
KHCGUf5@56MH\[[UV6/1A)8a.0;)6Z@#MVH^aH4O0.Ac;g]O^KZ,fb-759IIY^B>
KC#>X]]RX(OYZS0cg7DMCE:6:72(5;8HM?K<PNR1+ON4W.7fE5I-PHaJ;Bd]4?:b
TSS3)O[K#\?8YPT1f:13F[&c)N_RFHF,BedD^09Y/JJ)[<)aS)>Yc7[YcHC^#fL+
EZ.XDH\NK9AcIB@K#K<ZTfdd_H)FD=YLY9ECZ5P@?\_ADJFXM0RJST9Q3&:.-eWa
?LV,5@T^T;&^g/@cL3C:\V[(-dHTE6[<7&)8@<TAgM+@IM12/8QT0HA&A7ffQZd=U$
`endprotected


//vcs_vip_protect
`protected
c&BYVK(cKb4?2DW8>27533G;_M3a)EMaX[BKAB+[=?PL/g/-9F7e-(NcSaX1;.bP
&T]50/(3T+PVS1F\F7_W;e]@.#=W7V<#cKI<]CFO<;HQLeC(M+2N:c>D2<EU=RFb
HX^)b?fY8CU5694ZIH(PaWA5\ZD&AP#26SNOS=K2BCOQL0J3/-I#JeE1B6O/2Z,Q
4^U8+H-LD(<^3e&D/:M5:Nf4B<56[G9^)beAN2U:g1E1b=O>S\]G,bKB4V0\R+6T
\?5?b(TOHe6fJU]F?^bX48_JF\EH^2[bRZEeDAIdVF]PGU3#L<Z;dcNHc6]V=U@]
&O#(_]DbdGLXQF6;TY;5(C,LM@3ST+_YU=#30LTL_QP&Z>b\(1@@]<(F\-E;:VNO
:RcK49?GUJ>VU8AP0-;[@2N5.a683e24UY2D2VOV9[bY=bTTA/:,,FWHW0a[FPBE
cKLAOA/Ed0<_E6[\RbR\@JDe##_a7]Z\)PKd7ZOGHRTX7VaRG8VR++Lb-EBbLF#<
W#-J:#(cCII?;)VIFAe2;FS1X[/QDQ?fb74SVF5LR^E9@PTCR?=XYH/f:\:N<_DZ
28Y^<M)[2:TN5LP/^W:)ZB;&S4?d_2&EDZ/RM:_2WSDG[IMJe(gBQb3V_HN1,3f)
SLQ6g8R=7O-,Y?XG7Gd[;3(<PX5LJ8DZVdOAPDT;\6T@,##UZ,A5KNUa0H5=/#?)
E?G7f;a(K]Nf\FbaJ:GFb&M>ZQZ61^2e#X[K&<I2?\g]BDXTCfMVAJ3=6V2C,5Y5
3+;N&&I>d)XCY]W6b8SX6@=0=05F=:8b5aLaE[_LYX\\E/DFMa4\5SUX?-_JVbE;
@50fMHQT;/LZO=GNec[b]ZK]f<fdZY.;^aIO@50ZaN]T-TM+MDVQ5W.8S,>CT?6W
bL.P6D+BS1&Cc3Ca;=bOO7e)^gXW_NZ+CadfU^f:g2aMKQX2e,?7IAc1PN(&0T9L
.f9)QeKKG8560UFJ2Y58GYL-7+GVI[JU9YSNa>A-O#YSD\Qc+R4(5e-f0bKW,5&T
B+IES8U/cW8J5T2(>H\9d5_HI>0&J_;A:+(,W/?N^-;gD8eF@SUgJ\af^.Nf5OF(
1^G.BI@e59;baRIc>I,b#93-eH8WAD&N9-)&_<(-Sc?DAHX\Yd8L.&3VQN^#:43C
AbEbfED?Y.)9@)#a2aHfXI8MG[<:VEAgNbZ2NTT:eTI>]@.Q)fU9IQ+-A:GF&9T2
;:9^FLQ_[Q0bPJc\J(gca.6+g(Yf&Va/1gKLCP^(^.>_3I^U[>:@PD9E:WJE9@a6
YR\g8XB#IXN=MKg<>YSQ=GXO84=T/;HF9)W;G2H\FG@JT=BYIZR+2.XZ51HB)IU@
M5W=U=II7N9c-042K]@JAY,6K_@8LAI)L#A8a?M3#HJ_XAU,[M(GGLXZYJ&\(BF&
#P\3+9:eQ+](SPLXBA6#VfU=:9_9KQTD#Y.B,S5W,Ob9#)225fcZ(QW:+5TI>R=&
]A-J6b9GgP=[DcUc\B5LG69OgRIcZ&_T0\,+=e8K>LCgNOBK9J.;A<\D?K;eF1#Q
P[VX:3,WB@=DA7QN&gaP(0W:#gKTc\_<D&MVOP7(LH4LTKS?\CVN2VRW[317a)U/
Xg(/FW?E#,&+7OCRDDa=PQW2Kg\Xb_a79eV7_HU[P@U7d6C.N]GDBJ+-OI2gBM(S
^&R,SR?C+DZ6G(4Hag<<+)@ON?V>B<F.&WcF:Oab/?TGM444^SZ89K+cJ\JW2;1/
1aKOgLN_I8.]ZHAeG.7Wf.9@cK5Ff2]3^2@cfNW.]e;LD57BCg/M+Be-Ve/NZ4,K
UUCYI>NgSb##WHFdI30_#)gCVe,9+(=1=>:1N(\R-KVa[W5<MD+&fD^\:/eICFDd
2#L>WKEM)\&cP)S45YeJN)O+C0U,XAcX8B0Od6Y]7;[N5)T(:5eMZ-DK\Gc6(c9T
?M3dE@LbagXFf<-&74DcAPg+CSX_2:&&FA9RM5.M0[b#K8)?JIbX@I6XfD[&AOg1
B)X#@CEEVg6HKRTLV/+c2deTf9D7#\U/0&IIM]BPPE]()W3Q0#5(K7MbUKZ])D@4
62IHgCBGX3\FQ.03L9\1+a3J]#HT;V<^I)_@TUYB#::C(?<C=:^XQ?N(IN<D0[4A
dSYIAbOMW^ZWG)WP)JM,]/c+)@Vd6AK?Z#^WFg;(>&eK]E>_/\HD9<OQ&B(:\@.5
9\E4O7F5GbCPKa<XN]0CM+F^-X;Z>H.7L?H)bV:QOLOQHA#E(;&VJZaNbS/4-HRU
e5^7NCD0MA5L(2Wb^(7MT=M.6;dA,K^Z\)&??L=I_+S9B)0M:-HZTa4IgQC/Sf<g
[&aW=]cHLBU5dTJX49BYd1/CAWC2:e,>O23)G65N0DD58,V6,)B>:>1Be9\0?IJ?
+QFAb?@Q;2:G[+(Z_c-X[9Z(b7A/H=XUFM_UI/SV[+B]XAgQ^Za8(=V:(#DQF=a,
M;(A0LE\Y>@O(#ZW3PL2@W3P[c\E>8U9&_T=G60]SY__NZf,Re>S1QK9<ZU-PM?Z
/S1ZYL]^V^T+9eFJ+B=S98UKAQ[()HUZ544ag>W72QLf;6NBT@Y[#ULCKSU1Z4.D
R64Ge\#Z:\BL&1IFE^bJW-(:84]D9bD^eN\0,TXMcR[AT<EYDMO_0:QCW2DA,HZ4
c;TagW6/B>4U-?&AIYA4RVf<&04_;dbG?]3Hf1K7.11\Z7-P&6)OHGfb.REAcTPV
NJ6&08.O9e:??eW.N#\^LYUR(CLHEgb^6-a+PAG<M0VA.d7N1]:.DNDD(E?U]PaS
-geVUKE0e.PHP>RA)4ZBY-eAYMN(D^@+,@)3B(-CXIX3Tb8_(H,/2V\?QHNM-YQA
=1N)]2I<?WO2c[CI+4^(Ee4^2LNE#6M+].7VZ+_FI@1gFgeGGaU[RQN0=G^AKAYb
O:T6BBd#;A/FL?e(KMQ9K+9g(1(D)4#E0V9f]d9DJGJ,&B.eB&3?d4D5@T:^dUe)
c[gB#NMMWg].QcRWH_dRf@OW-W/B@ZFa3Kf3,@GW>KbE[[P,AG;N6Q3+VGR=eQg5
D[AH#F21_F1(/\#5.N&DRZ1\/@GRN&EEVMN<:c4VZI,MdM4K5[ZNB&d?ES2C7bBP
U?5\^;FDaLB,U&N?GQaRa,54B64ZZ,HA;A@+Z&6P<423EI]SVaEERAV[dQ@2A7TY
Rda=OEe]PTE[/9^0K55YYL&\BDIL=->70(\;/b/7ZHK_P&.P3]DT>:=@G4ecER,S
@dPHf49CQ;2/Pb?d>Q#a,fFed<3FZ&aIWc.\Q=4O,E#[O_/6,C7ZK0g+?/F\M8K;
M@4&(SbS/^OcATOKeU6B>P;8]:.-H+WZMYE;JR9b5dcee<L1PfPZB8+ZecPTd56c
5gH/Ed^;W4a8>5ROJC.LW=>X9_U8gOP7MRAaF-@,1+[K^:ZOe.+AG4PBb72)_2(F
HT4^[:5)5]SGSU#ZPN-<;4]9#^db?;TBa9T>(LcEM;Z;@F(8PPc[[KDQ_I,20fD_
CN<18aU8B]8-Ff4?@^DV+23GG_G=S^8gB.P^,^S7\P.aAI4&cf07[9Gg(2:X_X.8
&)]WXJQ,BIgVX\H#[9=aD3J3C<V9XG+Ub^IfP-XPK)VRC3]>+-I\+<c3L@52X;U:
?JO-7,J/1JL7PRR\ZB9eG^>ZG)2bQTL#7&:<=_=]9Gd>B<3EP,+K-/5/(9L&FJ6X
W]J:Q^[ZHK.>BCF#SO:D-^^P1gg.\=J^8.(_0-?cL;D+/D+;R69f.6b7BS7#]b;0
dHSaUZ-b\,<,D3:6UQ.8XCa?)NPO3RcS+ZeN]e#BZc)Q\aO5UK;^,-06O<U0MFeY
ZPQ7R.?RGJ4YBRLfHR/.FR2S&SH0:UD.JT0GcRc4R6beD;P_F2Q<;U6P_,R8E\Uf
DMHY15UX^W6:Kf9S<;V+e#=1[&ZB(B5e7X#H?_aK^+V/a#6\CR5B?=_aIPACFCGE
U_/V6<K?B/&(QL71L\J)4?d1XD(VS19F+,5]VOI_9?f7>0FHfW4/T^>J@)6LX(_V
[YCgcO7K)H;O0^SJKf&Uf>T@f.V];G@&e&9IK4YJ>?&=#GZbLE4[ZgRddPH0MC4O
@PY:@g6D018&W/9dVa.8(I_g^N8g3[97X6Ve+aa.(K;L<#Td[WGgQ;Wa;MUI]6S@
I4246^B0[LZMcT^1&]W@,=)6#)@GF9:a2/L)^>L,:0F^]24S5e.?1VFaOF.WE^VX
CZ.e5YZSLD\>\2e6H(1La+1fMR&86L)aYTM(SAK&AfOfP,XXd.@.bcJ],KYMK/D8
cUE_&3,^<eE91E61D5DCYfeRM(b2W?),d+#1GY(T6^&)2e8g<_ANc.GcBQ9:W25.
\\D-+f[I:)YL@:54E[6R<_3.C/OO9.Cdb5(fHFY/;dbGVZ9F#]\Y\#SPWPVI]XHg
1J4DXGF-CV0aS@8)ba?dcTcBBP9>TX,<a-:OBPaL5gFG<:5+Q1)&NUcY=_fB6[8?
eeTd-g=C(\EF?JZN@6g\:5/-OO(1CMd8MD7XX9UIUO^e,+Ca(G-P:KF=fHE[2/PP
;H;;J5/)1AB9f1fEES3KM3,N4QPKBBCGdTV;61AKYM9FN???O7A^Zd>:_dbOF>&=
-eF+^_/BI?\?\f^W?V3B)QT^?=8Wg:WbRb37[>g#IagKUJO(],AU?BEdKLcHPO+3
(4;U((>HBS./\;.B9&=:8?a7U&UcV,Q74>6(XcCB/g39-OO:5]D+bOC8ID#Tc8@e
DW;b&Q8,>cV7PWMCVZJ3BC;(&Fd:b;Zb(]@SHR047&faO6XU,fE.M-=P=:,CE1a5
?>TR\TW5VK_&dOIX=8IKNG0=@)N9@dbM9ReIJHf2&d5[JM+L8;1LTOg&/AeEVP#K
[=gV@0Ggg6D=Sf0.MC\3VO3UfEdM6?I7#Ke,)<NJ5&R+KM^FMGWO07(7Z3Fcb/fU
2-X9eKP34e/=cfEYe]ZJ0cO+_HRXV.V7H)U&>+VP9,6BV5T7TGL@a@aY;@[+9E-Z
=K,;>I/HC;E&1]]M;b8=-SZIeGgVEa(Q_T_^9C5,f-:Bd@U@(59(>^Q6+^S)bGKP
N/N9.<3JRcaf_c-d9&(N>-fR\]K.+5d,dCe[K6,Z^CbM:F+08MZWEIC637>B^0X^
NUeGf^HEYcY?O6#X8^:5&[:^e<IJ:e,Z.\(c0+G)G(]K]YII^3F7,TT+NTR8])-3
-^S7d.2EE[@9]15F#>^e&R,^SVC&):B>1MIGWF&DI72L<a?=g?1-7.&MdN\B^@dT
[ag&2HX0K(2P+I+FOPB=fPHJdZ648SgR_A2#>1I_ff^>;]\\XX?C;O<K>L[1c<>0
=Z#&#:XZ+VB8Kg-9e/N<,2.1HUVQD+dSLN7]>P7:#-):(]>>\3I0-R.e_;@[SBYV
FN?5cGd3;;g;fR+[Rb1D8W-&.#CWgaUJUBPZASd:]Lg^J.f43eBPAZa,96cA:>aY
.c_c9_<LD,+><SOT@],WeY<_/JH]25b#IbI]0AaJWDZfb+)K\,4OD>)Z2-@Sf/#/
_TP5AG#X[gI>US/?6.e@0#TcaF+7HA4bYCZJe=-_]F]KU]#C2JP1fDM<+9GE/(aB
1J\YY<>)=Pb2HFB?^+?:/(21LE/N;?^)S5Q^^B=ZJ?/d3,P)2_,Z1D2-]\>_R_-F
Ygd8<P>,9>J;4&X\:f@\R1SgBR_4fBM.PT@a.9?(a&I#M1^Z5P.S&/971,))A:Tc
1]131C3HMgE(UUcTY(FO>ZO\AX)>U6WW1SB4A.+YEM]fUg[E_+C831eg<8,+a9P9
eN&XeKE5aT_BMTT)[^Q2=/ZScd9:A?:FM[W<c4@5XU0T\+^<M]:3L2SK>U[1AC(J
7#/C0b\.fgY@:L@J\=R9A8f7]ad#,=J-G6.)B_EU1.?^S9X?H^BR.NE-_M:_<RJV
AN5OGDb/,+W>RVbHQ<b;5KdB:6aBOS)BLJ)WC8CAV.]EGTB9BON\AYG+>OgaW7@;
#)Bf#I]7FFbV85A9J&G[03^8Gf[+\KF_\68YL+T,/ML2C=-,COZ;OP8J#0M(MW_J
JcUZ2[B#V99-(:YFMOM^G=e,6^;SE?c7@2.6[D4Qa0T:WOL+P2<.=cUMJ-DAE_KS
T7D17fI(e\E.N\(MeA:11U&a1f.2baO/1DT0=^JWP6ZBQ=(NRcb+ed&>(f&]2\+/
DMgMK0;Kg;EUY3?)HTg>IJ0JIB_OJPb/d3\1-=FZ^WaB[H;(b.C>.:>M(WS:+Kc0
:A\5b&SMX5_EaDbO03KR.f+/+0.WTL66->(7fYVLfK-9f4S5PbUZ_W0\VbbBI>L,
gAEE)W,NBM\Ea3^M+f(_QJDEeMDe;3ZH=OMO8CPQIWW8@&I+B8=e=&4f<gFMb<LP
0Rc2fd0fWKZ,gfY/,]BR><(b6,[:8D#TaKOc(0gfB6VBYL/Id/+VDE;F+gXa;5].
C?#?6?S[A?\VC7?6#0DdgFV#BZdU:50Z,Y3)X^.J6W4-TU?IWL6<.D4S]6Kgf&#9
g\HKH/H#ZaI_U,6K,>X47MRXYa<#HC,@8RR3>IYZ]eEO,U]D>C8)T8D_+,JY4@?\
LY78MP^.Q&e\M:WR8.OJg,/aW^,0:YGFVd.=gD9)XU:OfF23XGB+T\P):SFUB.6b
Ze[baNRN5^D705H.+KSBb7,[C(W]W^/RVU:Y9MNWYV=<S/>K@)d&02;N;#\7GHPI
E)0J?))b.g72.M:/IR4E;5D77;5V>&Y)B5XYI.Y=,+]_,4K1;B7e<@Tc<1aZC1F)
I_:/_Na?B&T5J>TQP+=LTVQ)49bSZ5VYgEc2C;U1>C6]CH7L?M#_e76L/94\c@MI
@f+GQBFEO/+SH?)\N@@DFZW;(DI@F4c4^4cS@<eE^UDcI=X.MK5[4ZA>>S4W+?D6
eaRZ),Q-J;Y@AB9\(JP+/K^IBa/P,d2HFYUVOFG/(<&E(4@0HO@,8Ec:AE@6_Pf1
-+)/[>d7#2-d;6)CBYWKED1Pb9[8EeCcg4^@W9:+L.KW_D+8::-\N_3&G;;YY/=M
FK?OL<dR/&D=Pa-(D7X?1=Q+eCY&J/QKRZ=LU?43?E.Z/[AYaL\D&f=:c^e(@ECJ
9e95S;]2-2>5COUL-+RCWI.#M>0D93&@;ge2Z=G[VZ9/Q<Rg9Z/XUeZG[ZN.2g:\
O+b)B[CeX1:)91Pg8P\2b7CW,]9K/1Lc/3[+LBN0#XI,EXIc78WWFF1dD.Ze(<#.
IY6SXScg;94-dOHAG1JR\CIBAF<8=:W,X,91dA,A;AWIZ].ZGSJ;U#JfYDLFL2<+
O<O-]B51SJ.YBDNK-2bffc-=#B10<[5^cEd1F7L(O_/T\#U0E&GTBRQT&<DPD_OX
:EMJC\WHe(JV<CY52+L#a<=<[?08H294NDT<VeR(B9,SFc?9^SFL4S[IC@_7aVJA
VVdFL&:7dbK;JZXO=&cU2=GDWH0S]c?QHC]5#]^R6>064G_X0[9ET+e2b[AK)D.c
4aOEKX9+6J,_<3fD5)8PQNbE-L>&b:UA^1H#R>8R2/WFQPdXILQd]c<<&U[7G16L
2@;DbP+OC=bQ4ZeLNUS_:LJaJ2=2AFNM&4PFdWHJBT&3H<=:bFS>]e8I6)4&(C3/
QSX:2(^,FK;-9Qd72Y<\09V:?&WSc[2e5EE:B\^LG7.N<792Z\C\G349X5,F[e;/
01F=fPOW8WKg:Z734=_X2IH8-HA-7Nf8.YF,56Q\+D5cC]eS[8>CV_;PC61:Y-Bf
5bY/<T;Nb:dQc.c):U0Pd[?IP6KE@^\&5_&K^&KY+3]cf@2T[E#9,W-aVEF\@/R:
[<7=_AQ/B3FA[ROM^\15/1f.Wc_d4&bC/<W#P+H9<8:c7;,LA.D^<\YZJeFW@f.S
(X5^W7_^a@4SFa(aN;+=[ZS[+N7d0?S_53V/H/T;H;J>NcSNOBT3935[#/^J_6>9
0.eFKS&?7]M4ZV+(N?gVBIAcOCYaYK@OVT2HQV[f)B[.HbAeLQ<d.];4ZDe_MG.<
#(Sa[WDHLQPP]dG?dP\8[4b,P;2B2-R-#29>M2S3e31BVI;VM?N&&(fI](R]79E\
)&(\32a>@9db&I).4ge(>L=-aBUI@0(BeNc>@HCZ@/UZaTT.Q6HY057N&40PfYg-
U)c5Pd^5T[/ac5^K?3fT.(Z<B7R6N>W[6B7aBbZ8O.@@#=V,d@+O;da02P95+I(D
Lf(BfG,GX-R=S9Ad+D/37SPTSdbE>DGT3+1ZK6Y>]Y-KL7PbM17.9?Zf[VFP.BcL
9Z,FG@@Sa2gI8#+Eag:@MEL=.d=EFGSUF?3E-?7DUZQR>2>8V,bbE:0>(BYM7bW2
^bSP@ITP_;IGe6H_P3c037GQAJ&SdCS2UWZaT7I>cOP/MF@WA+Q]PZ<Jd_JJ;#d.
B+SP=HV+KP<?U2=U(:+bS#\XE+T<CNIK@QX8D6^D&8OJ;+GR9]L?6YHe>G;<g2G]
7JfS-:?RbHH8De7Y:X@AXI+N)Z(P6QAY[&V5e9JDU@6VHY\BLV+dY19,#>.CC-Aa
]<+5+76TA2U0VI>E\56X3c:A/Q\,V<0]^e+JHaT]U,72]+&eX4P&GNU_2LRgc@,H
f=8;83a6,EbO(:JWUF_S?;KDHYK4OWNBS#4)P:@3N#W]^CD35>5[YQO1c5Q[SHZb
P62.W0#49Ked;S,DZ1_::KJBI57XGUD)&&0[3M)(F17IU9H3g>F4=_FX9^cQ3QHK
F5a(@:TYaa@21NB/R4E6.6ALZR/(^XWVH&FJaP&KLMf&#:1;WLRY4bZ;+^9WQ@+H
MIF&gg8J,0M9..<(L5Qd:^Y^a<(W#\gM]6BcSd[b,0e@JH=NK[;\O5/412-7-c2L
:6@AfN4W+7IW3D2R=[(U7^[Ub(3F2bcOMTYHcJ;PbLY<A4Q>c,2(VeR5I8a(83TS
-Q=^WCX3XK=J?R^[2SUR9\HZEbY8N,G&Y+151(aT6fW0f&;C\eVRSeOIW-2H\U#(
O(B1Va,+8-7G:Vd]gF66//gP7)W4=H&LK#>]IX4;)EX4McF^f.GNZ65@^9aJ7\Sd
-OROM]5E=2^]/fF/B/L(9#4==(QPUFU[2Z.L>L@QJefO+.<5-P4+-(dBe4b5835)
B,+R,8=4BC_AfQ;-cPQ&&f(+SY[8UM;Ea]2P&RDZ1G.2(3-:QD\DT_fVJ=_QeR_8
CYXA=4EE>G8GBc:N_O_e;#-F--KUC(g9d+##9&+Qb@P/\YH@8?B#XSBd132#,UcJ
[6@..aAB..SMf68fg0+HGC2S<egaBI=Y]>(#LXVBB^e<W]DFf;\gHHK4J,c=K-X9
B[@2-);g#MdR8f0RL/g@P__^acUUbgWTQ,((]W813@LDad(MUAL]0Y>SR8,X@9Oc
1Cb_RHQ2F6MB>K>b+?TX,LAL:g@ABQ::RR-ACM3:D#<)/V[?GN[XJc#C7YEJENOT
N<B5H&MJG0?O522S0QWc90KF295eWCOED_a=A)L2bL0;]/PX\HGea_#@.ZCKQB>?
XVD;89OFJBWcUO=dBM(G][0eCHLI[a_Q/GY>>L=gRF?PQLF0;GA1B2?fL^VPJL<?
Q-IdcU[HgZ5(D)\=5:NPK-Q<U^7Y;39I/46b9QDPOO;&=JaP?_2Z</;]6+NM+B[3
Y9CdcB?#L=1QY]CH5_U3J)MAFTgPc;.6Rgc4B56I])U(beU.0g<9#8=Cb_9fe&^d
G5(M&8/VAV6E:=gL[7L6>LUcaTBc7KRI\YG4+#d;V:#>^H@O<P^Ye#N5HQ7#H#4J
S7DEB2eNOZ8ECf=&T)c>V:UMT:E1?AR]eMXJ5G-8I1@385M33JO>Y&L+EE(\e@dP
W,93eN&H7)dJ5]1F];=ScI?\;TF.fBZ14PK6c[QdRXD)3I.(eZ=7R0D>(KdIX>fe
S1WPTT/KQ#0QQC5+M,(&D6P/:E\1ge)Q:/Ecg4-1@V/=FB_fQT>d-N)7Z.B#M\8Q
E0IS0a0EOV7B:Z#LAZ]M(3C,f==\F(P:QH<3W<-9TdaA(>Edg1R9]OT2V2DN_854
H_+;=BMWJ=^HTUHX5Q,(O<@Md4V#R?2#]6-Fb<KTO\[XV(g</=117M,R0Jb]X_5R
B\CAe9YK6<Sb<D^O_CcZ7HSN@^^;CQ-VO78JO.UeQO&U\LUY_/gGNU/K;B;MLY>U
;;O_7;T??7/\g4WHAC>AKDdeTSSDPc^#T6N32GOZGH(OR+2)P8K:ITf01TOE[?,0
79L#X,2c#8_fc@Q(?\5/0LQ#2&)5<CV_bgG1SS9)^+BRH\?+X9S@bVa8Mb3Ff\,R
>XT_d4^06YR/fQ.Tf3D-W:e&5?dd,_cY8/07(9&BXe/A#6X2KF4Pg9\)=1RDE6bG
J88DK;c@7++a)?LTScB>M:Y65X214J)H#C(ZKFNL?_<e]VM<P4GM+)e7e#7g,K[Z
.IdHCVL1E;.X/b)gAEfO8c5K5/62>XFFVVF:9R=#Q?[0\YPSA_TF1YEXN=W#IY&5
EM?=1/C3Q;d#>>4ZG:P=Cf7O,2-5LYI8Zf?SD4b0,8b52DcAJ<J<@OeLZ\Ng/,,F
C;<CI.AXb4?<@)=XD,dab>PJ0=FV[X1?M5M_]L<CQ48BOcENF)U;D(,7IHb3BD@P
<e#Nd(bL1#=XD:8:GRAPdF#VYRLPO1N4^,]aW],/JTe=e(U;.3aU,HSe?N&a;GV6
]X(9(W(6=^_MaS0;ZgNKE^UAP74SIUV[MeIPG_@/?GE?]CUT^7?(V/Z9Cd<RO43V
I/<d]ZbB_M^/5.@Y7URHVDG->WB3B@Qa_V@W,bMb=//EbU+;6U.(5fgG\LGO-30S
DEBAbXEEN4><W62R^B=8gYgAdZ7C_<4]H#0FNP#BBf>1Q(@(3eZcWR9gVIBK_\Ya
<>L2Y6:QD]9(=O:FR2Fe#QX6&+(4\0OU4;U_H6H;@3637#eD__)?M3H]6N\e7Kc6
<GI107FP.BF,3356EDXXSA:B7d>Tb2T/?(K]e4BR]G^[/)N?Y/N_3KbS>9^S]BE9
Y6c+NI3;M94JXF(Q?43?9#&H2<K5FW@AL8g?4)J6gDBW0E+^]XVEA4-a[-93M#^/
Y/fHd(H+c1b2aQQB)e=X3T6/U^]0DT97_AU^c@@eP3:1SAccL;6T721F[+JPF((L
3Z86&5:>c)3Q]1NBH,fS-KZFa-JDYb^aDJ8N1?+;M6F7MFIC/0^61.;SJ?A,gRP<
(Yb_Y?6&&-9V=_(<WU+>,&J1CLb],LFI@g8]If^KRHS&BM2:T974aVNg)(C+Q0;&
0eg:M2D4cS8FU=S\[BWQ0/QNW.4>J4)JHHX,3V^.#XU7#DQ]\+\^WDE+0[f(-IT=
,2fR2^2IW?_)L^3)3[K#aT0P=_EeYbYLU=O_af,:+RNT]I?d(G^FAIdE)GX>?KbX
SA+A_FU(.[6,e&DdYP9LLC_b7E9+R>^[(RQBa;R:U4\]d4g@CW0_+P+YAMKLD)^9
L5_JY\C<>IgIVDNcJOTTE6W]b2,)EFg=NMV<][^#d71XO&fV.NeG/Ac;AAS4R_OZ
g6<H5LYGB\#-4Q1B\P4H1YMXGcR-:Xd1^#1TeS,Ef-/bb>&TAb&])+,IVT#)V(N_
5+1?F,0C4_b(b=]8HMC]4#5]fOY3O@7=4B\F#C_#1D)4@-BH3-1_ILCIC3;gPC^8
;W;HYDZH7OVL<HIO8=1YP-JM=8S\\TGFgG(Gc7AIc9M<P(L)L=[=K,cQ7c<1+3/^
G=L>c4Jf<1ILG7GS+bHLdFENW>eT2@U-K:PE8_UWXS-O2JDWR@1G8R=T)PSfI?f3
XfX;EA_E2E6EH[J&?EUeQ0dBceDEH9DdZ)N^/9(:Hd,M]@g>6=C@Y-f[U:c_LLPR
<8.=)dbBdOYHa_L21Z7S.ef[#gCbPPJD;RL&:SAe8,2Q3[\/1\Dg?)F9WU]]TK0T
aFFJCX(F3\QEYR?Y]D@cOJD&E)?fTZcJa@+T5fg)G@Sd;bU:B<H,LSX+fK9e>S(9
e;5\<I+A860F:)0[>^1AdaI?TO7IG[62?:cF(H-SP5KfPI&gg)P6=]U5=XG2D+-0
dR_9SNHP-[K^AUQ/.X2#842:>M/a,P<.DO1UMNDF9CR8>@5(>9GS=W^X>TFN1TDT
J)/2JDH[Z1a@9GGFNg]&_DEg;;S.eB>7_A@(LW6VJc;Y8W3?f4]=-DD1ZbQ:6?K[
QScCA^g\-d3>.=]McS,b8[4beMZ:cVA;6DNGS4S_Bc4R\fYXTMOROb=4Z&bb6(39
g.gO=J#>1DJ+H2CcO/f&<;Nd<URWR8J[?W0Lc_Kf?DT[(?b-Q2Q;e5/f#O_AGS1b
5\VE?0D?(&(B)H\/g4bVaCVXJfX?S+]>Gd[2Lc3W>H=aJg(=>>_:9]UMN+EgUY50
[_JbRY:BU(DOW0G)C<7UaIP3X,;cS/7WdgBP\S^VC=KYRQS]P-fN/#b[IN)cCJYN
6I^WS<+JH[S)O@>X3Wb;Oe3H37<LTL\GL,=.U0=1VaNS1X()EO>d:cd;[VX-b]#:
EPC7J]:;XP4)4G.d]5OQK;]]=Y:&1d)OR_3[57).F+F-B:Tf,5WLd+.6A8JR/7_W
gLF/Yf.?7&e\C7QIU>#JCFabT)3<HLH-5XG)bW<KW?Z39CTKL65e<AFO>EA_RU..
RH--N@(I^1J2\IS7X\V2aWbb@V/d&T.&F)#32Fb,1dOAdNdX-D;BYEEDW=:8M:XV
dR:2fA<J^&RQ/ZVJ()+YHfO[T_M,W<RUI/=B&b2E5LF]H:&DW8J,S@-dG/0,cN:2
g/;V58MTUI=f]VG(KPUD#.d>SdJ&S\<N\,#/_2(U2TLBG]T>]&(6]HHOH<a(4eI7
E^H+7#497QIDf?R8VJ?N>-=LLG?V)4]N;+b7E@FM;#=O?_;ZGC_WV(FX2PX-P&_b
6:0ZCeJJIM1QTgY74AF,H)OK:I8Ob>S]T?/+.CKZN]KA=#dLR^]a&X/6Qf]D:-9/
UL8ded87WCBQ&BQJ)(3FQ@4TDUc.-.A5g,0ZD.P:NB8^Qe3FUSHILX?1ZMc#&>6O
//LM+O+PG:AfM.]+,FY(U39<+J/G4WT9c2>:1\CSg1a-(9GZC/4WC/-MR7OBOT06
.6;.KCL(gL#W<6K#]=>f<NJZQ6#Z?S4<QB(@ZHH&.(Ba\bM1X=dc?ZDMEFJN_RL=
B([:B6KE/=9^2Z_(C0?0KNO.+RB2L+c:DG7FVLc1CGJ7,Nf&<_,K]HOAg/@4)2?-
W(KPF7)9WX-6P81/R082@9F3)HdLdRS]-3ML22V[@#>.gHBR.3N,DEW9dIZ[/BVB
PCK@RcF4cFYS_P96\H10^7XLHI8YT-6/BQMTZ)KC._66?2-VeWH#SSU&a-RMG_.C
S<[U5:QL^^@A1Ag_\Ff0]5;D)=_01W[e^DZY2RbK,6>.HU6J#41X?5BWAH<:WKaP
V;32>AgS3[/(H0)WDM#8BO0R-UPB.]&9^eYTNX)Bc5DHPL@K(HJ=a&&.<d<2+^Hf
A>LF2LBY@aPg>E:YA23B),^=B_[E,&\0_>SbV/3<JT]eL<OQ2X^/c(H-/TS]PW[M
G<T=1^GO[JBO:E;7,:Q;IAGN+eOY6fYOe4[L/X-NR5eOTW6(O?DU^Bc+>F[#<f;/
E?F[DgKS\VD..X(<S/[)KD_]2PaaC9QOI&]<\#;POVZ^TY+HL&b,dA;T#]]1).RD
R(DG]f3d+91H6UVN<Mb5f<)7\:9BYM4Ab0EXFe(,eC85<3KWNX2db3<9EaD5L.KZ
V&?UEJ;D4/H:D(C-#<ZD46M._C6PX<cW0#?T94JZ2Q^[[/BD>fDXAH4.@EZ<fBeL
b^U1f3IdfRMHOB,KDH[7#,NeK]fL:>;WF050&d;&Bf&V)ZdBS&A#4)099)+FfVKZ
1c/&41D>gb6]JB(A,ZG?=M#YA&9E,CKL<6O_?016=BbBR:D9eX@&>[F2MPQ,^OP>
@,L@T4A@_>QF+]._XU5-FW/47gNO0LUgc7eN1S:LASH3KaB4:1R6KB4cb;CU=9X]
W2]ZQbLEFSYa\\_DAI.^W.N_G1OC<1CU8HbV:5T:1Pf2gGN)g1^Y+N1D,]G+-.f&
(OKD]G=f,12,EH>X449#Y3AcT))Wg8SgBN4]3SFP_1DaD3IA_WO@9SNGc9<Y6d2c
FF[ENbRZ9UT?1Y?F>b?O)B>+Vg=1Ig;H5Ya:I/Z)T(9bZ6@O74ga;-PaV#(7\IN2
1TA\P#a#R<JCGX^+<3C^2-8&1Z:=U:,V_Z-WbK]5R6MF/D3Y.=f+ODQ&4eKeD#f;
F?D&1d2(I@K=F_a\DbST[W<\>.G/(@G=E;9CcPWDRR7e^C6->E^24bEFTJHD?=U-
8d?a_1126IGW.#)0\O+@F@1QPEaP(-OE,^c=^8?eY<SF<.L3QFR,>[ZCYT8b\(;.
a9N>=BCN?/NCdGR\0EfAYM\..._1:2#U5A]eA0_J#]WWAP4e)>gEX#PN:3/09a8K
S_.GCa(XFU#9H2/;Ee&dV\0RDS44a>PPI:DE_U<L1)SJ?dc^KaJPM2_/H9D6<E]Z
2;2T5<CDg>))J<d5B,Z;4e<@4K.?U2;3N>\P(N.bJ5G&eD]7W&@86#ceTYECD84>
ODG[<KFG[J^Igf1[/eAPcCYO,02)(ML/UU#Yg74+<V;cI0UUa[36<EOP13J<;8,b
DY;Bg3NJLe(IHZ25,cK-4AOH9WH_J2ER@X/[XRS5E[?M(F&3g(-&bJU7@8:^0+CF
U_8F84#P-29]4]gc?9M7:)W1)@F2/IZUe=));>Ad-X1HZGK:S^Pc3<)B<BBf^73Y
X4V(B^6>eaP[QE:WQF3;Uf33BFJG5]1HZKTLMGT-/7(N-8_[N.d.0H^4\EHT3#MM
UXYX5,bJd)F0eAG3S=T]ZeVK_M:/3G8^UD05=-,7P;P37.eM8GNN>6:(<3Be]I8J
eVL,MQ/D9+D5K./14CefR76[9MfaUVP5bX_2=6IG@4NV:?)fT0P])Ng3?Z=XE#K<
LWF&9_W+14dg,4>(\>UTZdW]2D]RWO.6B(&:Y]DAOK#Cf?R))[9WTASFTTgX>@-X
_;-(f&L&)&/IPcdf\)OB]BYdX>63J@PHN8&,K7D-LQER67>#CgK<E7K&\b2+85/<
53gD?49f2BdM#F.&>],HKD0e3RQ;#b,>;>FNfFRZHFY6IDAc7-&A2KL.dcC:57W_
J<7]#TB,,7TJHW+CXNDgFK\fBADXUF60+RHf569Qe0(B9V;Wa/?)06Ned/P]0&RF
YZO6ZBR.(JT3/?(WB.FV0SB_.aAZ#I?QX5[]D\P;@(<.HC+eFGK2Le.F/_]^8eR:
#<O814aY^Y,HZ.2Y9g8+<=]8CSHK=FIJ6,Q2(b.g3D\^3@\?1\-[RWYA?LQdCa@@
U[]^@f7U]K69J3;-Z.+TBN[c3SO+L#gBGK8?6A2cDP]1AVQ>5L58>7ffIaf.K>71
<C6UJNSKd&E:&<b_(/dOb8GY]?Z8A[gS?YcI/J+Zgg3M@J4aFM0X_>WUZc+;8d/,
N1gNCO9@1J4J1]D2J[]D,:f@&^7[F/4EBO;\F4D9cg-_SWCQ?I;H;.[<;e[3?K.5
OR@WfX]0U3LF>QSH[LdJ2E84J]\^OXHNcKL#d<)-/e>^N<c4C>E_IZ330]C7M38H
Ud.<9=-7VDU?YM77-abJ6\>1JYRMe9[6OP6)F>5,VL4ZDcD>IXY.27,Ig]^#OZA3
[1QOYQ14^^b7-<?b4gMT)I1Dec0\ODQa4CNfcP]D4Me#H&K_XEL5MB)L;L-eWMMW
6eFGZO6>=AHF?S1ZSNQ[:S)_R<]G8:d=0_BI#L2V6_[07G09TG.K#cG][?BK7E5a
,a7P@gc=#,30a8g\cBJ9]._@/1OKPZ[&cMR?<(E34@ZJcKQ6>[(Qd65PeC,/\K[U
V)L:=][Q>Q@DdK+:&7LR2=Uc)Q;IBaA:WI..g9XB=6+SH#g=_A+A\cN=)QF(2)DP
[0g5[)MPHD;I9,cA>R,KNJVU#PXB#6b8RD[VZ7eE(S(+W^2D<PZW=^ZbGI7)]CIC
b#E]_[\6DCNHTDK(X#8\V+Q2Ka1O,M45_-?S?G/+ZHQH-<3M0Q^J?H:;-9K7.#Lc
?WH?eW_Ia-<FENT:(b@-g.-4FN>^VVL1&9]E7/1[RA5\>g13M7d)[<4].RR7@/Q_
?Q)=]P84-7^4E?E(0:?JT\c;E+1M\cJ=@0IaN5.XF6;caF98\?NL9_FU=9.HD^[c
H_F?_5??U6-<J\Z&a\ZeZcBVGbMQ8H2aIXOcOP5&^4\(4<LZ(XWB.GOf2b;J:)@B
)4S=:CccR:IPP&0SR-DPNWe>9^Ue4E4;\\+/JN[\]8_e):B77VA=^C>X=fG#^1P5
../a:.cL_-9?c#\,V-@R>aY6?20_4AGO/N7#._E=E_f_A_f_6.gA1N285IECWR,T
S,&:NIYd\J=41/C5_H=#ULO\,?gXF]2+G;TY#7.82&7FT:.R+,ECA.<8H0,1)Da@
@LC\cB\_,VN:<gR]95WB8=H_(C@ed#b8G5P/0]5^H=3N(.#0V\,CV&1g3^_I8YJJ
/Z08D6#;B^aWW.+<J+4#^FV[,F]A<WMb)G#2Bd^T/gEPGD5UK.W@Wf3GTX6EA8+.
#\\DeL;N;J#70)Q93)<+F-/d.#W]<ESV)[IO3HW5R-R0M=1a9<7Z8^OIWK0c;V8_
VL8@A:L2Z[;QK,4<BbM=_/Q&9^)f(WeXXPc;-NcV.XeX(5KD0_70(:(-0F^D.1O#
-6V1e;Ya1V;MV)<87LJ@W>Y5_NCA0XHaT)>7c@\.\784M5^[4,XVe(D0,?c2.(GY
URK;:HPdC&C3KUfK=^\]5+])Fcd-9Dce=DI:aYa/L&b<Pb/)Z&URJ^G27/DI.;N]
C:M@A:6.+5f2_I.CQ^N80VF0NA#fa&SFJ,4UCE_eE/=66&>\@OLM@Z&H:KLQ>+UD
CSP^CQa;Q7&Z4[7B-17P;NU71+N=1VQ#&H(<?\;D8dMPVGIJW=(>gaG&DTacWVVK
5&Y?1a-._1&ET],RV_##eHMNB&+HeH^dJQ6;?P,8U3^<S[b]g2]GT]9=Q&?\O:1G
e)76aO,0U,b5Gf<dVbPUK]@?C?B8VdJ]TaK2H@X30(#)WNe]EQc_3^0GSA?08_)L
ea3+FC5HZ[-?BT&B[1TINSHL=+3P<FB6Q7gaBL1,7T@Bdd)(X8GCQRK7KE8#cNU7
2H^eg^N5>8gEeGZD);_=e.YFN743X\ML29^9BK5T^9bP.Rf]:VBUb>[K3JF@WJV+
Q:<7,.;Q92M>M&\Ad<\POPc:.+>2SfVPd_=X)3J2EYeFaZ=L)M\3P)e-.^eWVQ2-
=WL&RFSIQZUE(UJ.?Kef,BeP(WC@(AI.a2+U4@/N#YL74>UZ8;/7R?-SG3eZ2Q9T
f1#SFD[L2?EIE?\:L3a((CdGF/]GZ\)Lf=;g#FXeG=W,++>Q>.XQdeZH=^JDAg7f
HJM32@M:K0UTMYGLO\8fd]SP.fdIJZ#dT7L+TE-#DE<a]:1]7>/1-RN(4A+Ub12B
FEY+DV^EF+M4c5_N8J70&ZP7E.-,HO51[+b^+[TK5Tb@gZ<9>M\FR/2<#0QgR/J(
gU8]2TH+eL\FAJUN<TL=]RY-8>3Idb9?@W]D]g6O9OF63eVfg5c^T8bM6EH6C5UN
X=g-HI.6KVS_##FM73)822-T;Q?9Fa<?.+,-d-0^;Lab.]:/3T_@3-&a@+.fNeP8
2CfUGgB]DdMIcAa+Ge)\W(C.dALIC+>ZbQ?a_5#<?57,WMc?<@()^YdI;A+TIN7K
K/8O1T2de[8dN_=g(?Q0HT<(Ma/R8d8U4fW[@>PD(]K?(C3IW<Z(4ZV_bY@a0>F\
90&61L9gG7A_;R0#<U#R0=;T?G-@cICKZb)[CQM6J28b]1DWA1B_M>&/T-3KJYL[
#4B(N)a6[W/Xc><^5]fRSdD[,&<XMQ9\g3(Ycc,DJLSTBd;K1?^dUd-?CF90dGW,
Q1QG-eZDeE@=R-7?96&\YH7D6&F(X-=I1>WQS7X=PND(PV&PT#Cf#RP,N5M>NDGe
KAa?D+b;#3#g?O3Z[,aB5A^\aJHR-8390T(<OL0LOP5<^T5,)]\N6Mb1?^M>4BAZ
19.?4JS^MPgMKZGDU]\3fe?FB4W5.2BG>;7LNG\Q-UGT[8[TRbPC[W\U>eZO^b+@
ZdV-=a=(<S0&JE>0Gc9E54O0-2;F2@2VH0e^IKJaVAa4N_APgMdCI3WN:=5_X#5#
ZB2>1LIA0E:+NK23XIdQLA:Ug.(5?#6_&J^g6F?:3:#5VcQGYC?Y521E<7]4=,0B
YQM\8&V#],EK^_^1562IFG=@BeR..B6;/ZD]@Q07E:0L3H,eed<OL+@[ZW>(?MH6
)B2YUCW//GId)#U65=JXV27_9=R7+8JcCM#LS;G+>/=()R\(7d,?;B/05S0ZLcEO
9eNb+QdSbQ8KUSH)D?+>OZWVWIK55U-&f])[6K412e/8IPTJWcS57E/UedS^/d6?
2Fg-YXZH2LBHV5>0\:7RWD@)9d\HZET9f-6dC=\218Ub(>O7_S9@@WKQO7FQ@@a\
S@_<L8_\#MTCef[0;5X3<:3O3>3\&AV708[]]Va6Id&+OYAa/PKC?]=efI_#5^cR
BM>gM8&J#:0PE:^gOO@OV+/=@LY:WcScH8IMeLD2:#bc_3C1=W:JcJ1SId>):LWb
9Z7:+fV+5U2Y2dS#VLa/c(KU&\,aPZ9:#ER464e4Kf),ES#c(ff@Z\R-XKT;ISWU
9)#bMD[TDCcd<YT?-&Ig&J&_F?YTa-]QEU#[QUE^=eY;/d&[8/;MYg^GUPcO-4PJ
-bF\Z2?EM,b:6H,d+a>J0VVNe?V,Y905#C5R#OXT7/I:KIfGS682KCD((fQD5=d;
+_CE0+J&e4H>D;b[AgIQT-eaBHOgN++L+F2fKcO\6/I>]e4<[I]K81gQ>G&/8aDL
D^@<[Ye1;HN?XSPQHE)gfCcUIKS-M6.[aGPa#E@TM#eF5a=e4daWSVNf;7A38D2E
C/;=17YV9d1#^Yd+<1(aeE<)J6d6HA=c8;B?H.:(W0NV9@=5YBY1\^(dD<_TY:Y)
0EC?3S6^#IY3>+;LE.g+e.?QC[JG6K_WQdLNH,ZV9cfN9;V]6F#,&(2YUYMUY)QX
I51F/(f4MKaX&/J/^RH5Lc;\/6<b6S^.-1B?4N99g.Z6=>TR[Pf;HM&cC[g;eV0I
)ZaGe/-MZ.g\W6fS@N9dOO>H=ZIZPNN??gMHA^g[V?-K07?+TX1=#G_I8T?gN?=T
+&SYC(HF;IQ6O4JS_B::0(KD<13Z=]<2=BFOWNO,.?K4558?a^;5ZLX8XeJb=^NI
M:e,M18S^1HR0/2&9d]4Q/&^5G0G5GA;a)R4J;765fH,#5=6/e[OJIKLOK<ER3Kb
KD-b\B)QVSR\ZHK6YL#eBA:O#MY:V_,=V[(fGGge7J@KT4R\W65A809TgL93QPQ6
]aLgZ\^A=D6HI(KLMe@R9Q,.LB<&WVDD/VRHU[-X35OGaH\K]^>)e3]WB;KFde3Y
?(#32e95<9SfJZV/]F1O0eDP9E9=f.S0#Jg/=]ZWSDg@W(9Df(@&Eb,[/?Q?7<-X
^1[;8I/O3\>GP-Sc?.9Uc<-TS:\SV&]#=6)>>fG\_X?PWXZ8I19F#E7/MP;TU[3O
SNNKWHB/J)(PgRA9\&A-;(P--#EP>>eVRT/bN0I5KO:(?3.GV7MQU:LG<3Q3JgCT
DGBbY7bEI[:_T^\I/N-?,H/YT.(ISDE59Qae-W(f^T6.J57D+Kcc@MN,SUXC5I<F
A^9-3.YH/E--^7a8F#;6Wf)>[#\(b3=b+b+\bU^3F90ZR2;>c@gA(>BB]JIRbA7C
G>MS0H-0fA\\f86=a93&I>58Ad(MH.\a[>3;)eJ@0LG79M@I<3?-H382SSVKGbVS
:g]M>5R4d2aIPf0I)7EIDR\DIR>B@5TLOe@b=Y\0\9<bMf0eG/+.;^?_]-U,=8(g
V.\_9Cf1,?S9Z#TAbISCV-4RGY(?K=QJ^L6B#=X;->a5c;TZW+AQC4a&M88:<8>D
9FJ;]ZAZYBeCf8\a1fA##e;70S]R0FNU?-G6:LJ)8D-B#<2-O5c<dSgFOf(?c1/K
6(B6fPMGQ7ZVKV2CM9ON:Q6,^Web+7f797^_<MLU^5Q\]S>^=:;CI\aXU9OLD\--
C#>K3Hg#_e09JU+[IV<M^CdS]KVd7Q<6G(1(M,38&&YKTP/b++<f>YXbeFQCW)O9
T;(eW[d(D-Gbe?CUGX8OcZRB]E1G+HY6T:8NaZ[.Eg]D>_@Y94g0CY\GZC8e]\[b
KT/80#&a&2]VHZHALRW]=_g?/OP3g\G-==DT9N=C;)-8W4\Ie(1_#b/4O+=)XR)1
5)1?5N1;EDDKR:PfY_8<@FN4H+/WKGPT\SD4NT,C,b(4?We-L@__f2Mc+(gK8WRb
?0a70U#,+P+92GdM^c[9088^I3?6K)KKbK?2JBSO;YBYMV-+dM.L54eQAA5?Se4)
54YWU3^)R9/N7e5J0):ETVQX1@9@g0gCEBVFfT6EMU8LbTR\ILRZbFJ5+Bb^4H#M
a=bH[=65adf?G@Pb.AY5-U3b_gV.6U;4W?d4[:f^452XKB>G/d)Gadf6Ea0/Q=40
<(,#;W-W5A\aM^;QAVZ,/STJNE8#d/fH][\.@>0:.@AaHc+C=LRZC]_ZX=<X,g@H
T,RQU(gJf>^Z.TPcb48:J<3QcC?D_[6=Ga:>@XS]]H()/#V?H5Z6Zg&ZHfP0g87L
6Ib9eeXKVQ[AHSKA@:\POS8IAEbX0>7ISK)-O[S_<?+B42(KJKCeV0dNe.-+19R^
BQ#RdXaaOJK(<?7],O1@d08P:>W]?=],V;RUge?^)^_[Y3eR:)FG>HZUF@23V&g;
4PGa(_2)RCa51g)2DAEaY&;f+[PVY.77K+<fB_12@#/6^fQcAT+I>.M\<Z<S&0N=
2_FFEBC<M;g[f\66TXf&C[(SSXQ-&^5,>Y^QI#Hbc1QE5F418]a,\U[e9R7b)WPC
5U\G(T;4F]]=6P)QUF6Y\5LdGg[-SKN3V2_d/7>b1@B3]gfJA],P(#(DK=8H2E3X
,O[<OQ03g0&5Ud/\)]C<CGDa9NGRX_E5>W\1\,[B663;](48B\Y\^H)1+N0aedZ,
Q^+<C+Bb,RM3TE-Hd@CQb6bAL6T&N?MA0c?<L98(188K&J\UcF<>KFK&;)RIb/>I
[aCfE@g.4[0+c9_?86[S9W>>44TR6b+<)Ub@f?6=CT\XN;VeGEe@<cI3R\604C]T
beDK+U9<8[X83_/GbGHa39TZQ@+L0FB;4e.KW#eF3^&?#QK[_8K772O?OZ1d-H[V
Le5[+BOAbUP.+(BQS=-G4f_ZN0-TX5<G\Uc_+[__#Lg8ZJg)CS_7,]B3,/<4I-PU
E4eYV37HV=))HMc64R3FWCJEII.^63D&FO+,FeIF&fU7&M=,Re8eZeDWP/[D-3@f
JYeRZdYd?Abeb]1)R@d-f[dOH_G&FeeU@)5UDV=#f0NMFIIDDO7..33C/HA/BKRD
Pb-KM2.VB/H]R\dd7W+,L39g_@X^^C[b-:_((.^)\J3=R+?.L:9WAI\bH;A&ET&Z
S<bVMOMSXXdH7I0>KJ(KL(C<\8R^.-f?BKI=>4/.1]#^X;gGI,NU-\b&Qg[\RGc&
b0X/^?OM&K2@:,GQ1D78T\J@R6G#<FR;Y@GSDGQL(9:Ad;<D@De7>.P2,g=YR&:O
AB=,7:C/WI3Y^C49#KKfC01R1<b1Q?@2d(>8UMM7HJVHMbMZMN_P/fKZE]VU(0XV
0DI5gVBS].BH0OF]95?>B]?@I>;O-K(^6U8+P1(#3W5&X?\cYdY?g-._)]25:]LO
:(J(#.;&MFIdBXH)4(5Z@^7PMFQKX[-&.U:]b<_NH<@+0Fe)[]bX)TL=/UX]E/]K
0:/=E#X_-P/PLH[G@^YF]S;bFRX_](ac3,45#7:f<#H0&7CPS[SY685I9QN&U9fM
VETXbR)RW7)TdQ(>/ZDf<+2bA5cM<V2SXa:E<3[C6WPHQL^[4L5-5_W3_K7)6[fa
+5H2N)6)@c.D-C/UAKK&[3ET];;4ND_WU(89(.9APcA&>;PRH:I#cA<cLJVPb0Fb
UXgVXFM05e#T:\>GX?9OH/f=Af;.bP1fN).4bHfd>-Y9Ug0SdG)cPQ7I6?D(5JMG
IS\=UQQ#2VKGSQ_1QS(JYDX4Pc3FF\-&]A7CU<Af1E+PXa4F\@WT,gHEfGD.G0]Y
gHX,QSY++XD<.5Wc.6_gTXD1VL0_-3RYR4Q(BLG:PW.078(8SUXa\MF&0.^FQ1G0
+bQZfY,H?CHf2W@6S@[W@_:XN?DHE-W<Yg2AD2U-9UF<?5Z]&D7>]/ORPQ27#51-
LgHN<c:AXHV+g62CdS(PHc<Z:gO];BWdV;.LZ+>^7=##\<8D.@@T5AdTSc:J6?Q1
eUK1_EcU@?;c&fM=MMPFd+=_(MHe^d2+5[.,BF)GPYSO-KMLB=WN<[8e#:QZ#T:a
:Z7_dSXTV[<OQ>(?4<39YN;Qa;NK0/>S@JGLR#)5RFIEBfX9,1GMP;AM^V-Y.cU3
>235Q4J/^_0ZZTe-#dA^02,[PTb;Re3T.&+93_J1gAEB]CSE744]O@3U1a_U3KEI
a_1GU/F5SXDQQQO]1(.\2:B&.?Z;QD/Z_HWI(8egQOKA:\?,P>B?ZYgQ+dO,A#Od
2fV;,(H]=E1O&0[b61E#fA(3==OJD[Qagf7b=(62(48Oc-02SN-Ba8H:M[4K@]=M
DO4MD)#S(F7+D<DK7O17&)2;/P;eF+6_&fONZZZ\IM]_D0<;.WE<)((bV6cN,[S7
\<d]W(O#>&V=TDYG^FV<)DbYX=/HI55X5),)d\L.6<>P^;A:J1DT@JV>;4-#Yc2O
S9+)eN]C5I.F\-?bE7.[TfZKI,T^#cg,=W)\d)B>WPBWb/U3BK2RHL6)3bW06?.^
P[]9MXbZF<O./Y?Y6>UZSH0F&O:L3^EUC:(?T1=E?[g?=W-0I1#2CB8HdMC+<H5Y
7(aYY0?F@U[ZGLRd1gUH.,=ccQNDK&AE?EdX,f9ffJ3Z]3CL1_WH#;1TXEa8G0B)
NLNEL1NJYJ9_1^^O\-?Cf?L/:A:8;URfM#f<R6M;1;G=C1;^H[H&_.H6&#X\3)?@
=5@>B_Xa.b=FCbFYNV9U(6=OG8WR<AI.FJUg^>X]0,9PV+K7F)LJ5_2FA[Y1D+:C
_b=6EA];0/Sf&43Se=+^g32/&O=-W[C&_G4;WTLZH&HIT\CL+(T[NT;?INTb(9<)
7f\.H2YSU(.E^&9e+eU+A:TVUZ=Vd5:AMKRAN?#JM_YdG+bE;1XOVC2?R@42YG7C
W:W6HYB<)12G)\AS4L/_@^-cVQMgeVQ]g9^WW)?UV6d#?K5\[:2a4[eV-0O&CQX/
X4&BC+3IZH^C6D+a@5b_U90;:FFRPFTAMJU@]>0OQ88,:B:Ic9[_>TS&\D>@fPV]
;d-bJ@>#@dWa<..B/<DaV\Q3X_SX6Z<^J=6TTK6aH?;@-BQH/?FI69F2XHMe=8YZ
X^L)HM9Q97Ng1<X91:K@7IJIbV_EQCCQ_ZE1SfBV\4fe\B.JG@>62DT1=)YDN0Hb
O<&9#V]CX(X5AbLITZAN7BW>;N/e.CDOHGIX1cA2NEF<OJ2?/g#D>+aa)4F;b2UV
I=dF75GN0aPLBV.@18J(-\7T,;@&\2<@f>3e4.^]<E^_&I3IS>a.Eb<]E20/=P77
#,(D[\UF#&M/,AY,gC9@,9X,eW^A=N^,8=<<e:bMAC.KXVP9=b-BU(0a&/MGPZ>Z
3N/M\5D(#P4/BabI[e?H0&0^3C9D,#L<DfF&,Zd?)>OOcS3&>\MWRCF\QTAR+aX/
B#KX,A#-/I8gD20=U#+<1PaC12P2F4[fDC0^SZOb^&L+5A2?T370#K,-_=[X(+(I
4B?5IJ5.=WJQOS;DSM=\:cQ5R_U_KU)AB5Q;EI68c3ea?LKQQ?H:Vg7^B]ePAO+9
3f;7^:T-?S<B)>0@QBWe?N9+V,5KR.)6a:\@((AT.C&E4>D\EGW0d@R<g0(W.9_&
g+7c=U<24H@_0LJ6QX,O>ZGQ3L+ZP43+IPf,a9QDF4=[7,)>[J^/3g5(gKPOR5TY
QYMSeW0\7cd+9b^73?NF:2MKgNW>eXgW08,3d8E()2@/]L.;)M(I50UJT6-:f@Y\
V\8G::gNU-7fW:e8FXZDOQCM:&_:E]L-\6.9Cc()6DfdKa.:/-Ag>-+1BYVG7Xb1
XNFdM<0-^_JU+8&-]>d-BMH-:1B5X8^cV?<gOES3C&5?LFI5,6/X>P_Y<M^Q5g(N
+7^[E@;KD1/_PB6\&0RY3A9P4:9M[>g>Ae^Z?T9[fTJT83SFT1=HD8KC0?LWYb((
-EP)QF/g(bWH(-J>NPZ+8D/d@M[UN+Dc,@LEc?cRSXbE\O^,&^<aHY=EX8G4_(5X
F_B0<]8TV2VHGdNa>3NDROX,^,gSW?;FI\/1,-T(]LDB:G+_#RXIJR;e,L.29)]5
FbHEY/IRK^)&@/3-<0TGHDZ&_JYWQb9)W2-J;&d\VCD[EYM,)_,@9^We,.;M.f?R
EXVIe7?Zb;VN(8UI(J;:eg0>Q(2O9+fce4A,N[CL58<MeMbM]DbU58E^_]U5OZV4
@8e2OMd>#3D3U^-J_>E]eNLAX@:EHCa]YDFVA\9A8:VP.BDLaMM=L@;g+?P3#0F4
1b,D?1O4P]&@f__72/d.Y5(HMRUcQ&)7d[)(DbWc4)J<=>_)1[<L4?2E?N</[.;-
(BHX.V_O4=E@H4HVVMg61EJC?)OIYcTaceSO(K_H_B)D1fc681RE5>@W:]\SeS;/
1&1=.dCcf->MBUYVUg;#>B?AF&e1.d?5OG[E?eT&O1gbg@ggD(K:/0HHL@+cO,84
S@N(ffJ9XLFI>Q.Mb#5VT=M7^=K941O<IQfOER#SD3&NFK&>OZaJQ:7@U))SZfL_
.674LgZYCcfK(A]=fb]3;H;H3J@:MWUf6P-)XLNIQd4BR9Bc<?.+(Jf5RV3G.R>A
;8]B)O;MKZ(0@GR72bNQ@ZV&/]6H;Te2FS]5DZCZE6[>^ID5V+cUFPQOXV[18=&C
e+8fcQL^);?4I^PD^T^52ee3^C_2]WU2,IQ2(EO<8eNVF(68NOA9(:.RRH8-OI\B
fSL/2VgJE(\JRd(^?KUTO?fg>c8ccX]b,),3<Q:B>0DcSEZ,?:3Z=7e)<5&@#K6E
7\E:dU32Bb=7].-DZJ5E>21_>B/4SZKXc#W:FJZ0P7&6D5HSQP?7Y/&eSYIZIR3e
c,_20CTI)PFC;GC3c4QLW@WbD?R7MA[(b7;9PDIY]+80+:fIY<Y9I_9\1QF_?g_3
eC24X]0ADXWIA4b+2V0f@dL&Y7?ZM0>3aK^&8+0I_X:[QM,Q?&gLfP8AIA>eN=2F
=.=QVPf)PDf3>:-V7HOFJJ0ZV,<E1>06a@2F+O:L&6KK6-6BgI5:+EK_([dVX<@6
^&]cRQ;)UH#I=):Rb<0O)WO;/.A93N&0<T@W3W(>FMUSc]F_-]HH?WfZ,S+fHSWS
#AQcUA2@_YSNZ;3_G:O)][CZSJX@Y,/aAP;DeGV.O=-1ga=I\,>a7<=6P.#3I6(.
Ofd;DS]&0D?:K+\b0@AXb&)6faBd<g=X><N>[Z=#GEf.d.FY2L[d\<Hd4X<L8fBB
BZ9PG94C&ZBINN,+P][(#0;&NZ=Fe.JCQ.&ZDE2.[68F#J-cIcV,(<=#08]C-^9W
<+64[AQH^K901#9;LBGaC<T_#1a6^ASG4\#e-c_>c]F1RTSD\JPPXB;@;^eccbDB
+Pf7)9CO]>Hd/ODKY\[cRZQWM[7U?b]SOK:]4^)a2+KYE(:LdTdYZ?3+8CF3?Z5?
.<-DFZ]CJFQ[.cEXbC=PTe3b[0\]4U-TdS/a9&@bK/c77/HeIP@:@Qca.)^KHaHT
3,]]MYFTCZ-L#JFgXD5J--SO_MDW8MZSDFFEQaW=]B;<[<51]O\Rf,Y1ZRdTFA<=
fa/3MKN&,0<Y#ef=?dMV4U8A/XL\-O^>G;6(-@+C\aQJ-:HO:W:YH>DX6&K@[(2,
U#9>ISQ0)=5N&C@S/=2_52PG1M9)#&Jd4WV[2&V[0?Bf/0aII/.5470H62gMORU:
0U=FJ&<&PR,CRCW?f,1YC[ad()6bYVLcO9GPVY3Z0Y5^bYDH3[cbJP+T3,BQX.gV
>2JE#)3AS[G?gg6\TA:=&(ff8KFS2S;;R:Z8Y^NSY]c=/fc87G^0YS;9:,[P&#8d
B/76c5-V6T^C7PMPaD5)U#46gWfB+g)#&<NXY8?C=VOWH<AX.^5CP\^VP,8:aGRN
WaQDb4.3;c<1\6@cNK692D[LT61VIVe,5;ICQV)F,ICCW.L6Q\8<]8PCC_g[(dcJ
,^F-(CYRZ2L0G?M]?5aN,[AN.f0P5+G&]Bd?g9;@?S,&?0<=NCe16V1QTTK4V\.F
U\UN,M,=RRUg7_A.;4U0+4-RKX^O:B96P)N/JZfJf,fd_/IC=<[a^KdIT;Y6ge_d
:81-SUCN=6NUDN@]D#2LgXQF0D</M\2<)J7E7S[D&8cG+,+7c_03B=4AS9;O9@Nd
1&FeE/fS\Hc9);2S2D&+4+f9C_ccZ7;N0aXO;1Y.1GA,QWDSL7[5-.G^GW/gW3=L
0^2(_+0J)-:Z+1Q5JDc\RNZZ8YZ1W2d,,GgQ52EUSeV1H4BXYO;QCWQHF/7ZSGdK
Ja/?HRF+,_N_7<4WH6M_>0[RMW.<cbBa<XA<;GYD>5dPX&PN^JBM)dd.43-#[T7?
+,XRaMV:72FAU2FWF?.;1C.DK#9e51Z;OJF=V4)a7Fc9Pe\MOB-;Qd=965Y(S0/U
g]0CZP2:GXe)[+=03\)aVWdVDM,,O1A\.[NY\bUW:F[MJNE5a/+16YZAdL=V@;MV
H9F=WdQ3>.QbU<YDT[RE\)ONgV4=V4N+T285=X^\-#4]ATB[6HXUWcA89a\NDH#f
ZH3L,>C0NI\@281G,&\46PTRgXA=2&;[aJ\c\Y_\/^1&]W:]bOcgH2=_U9]#@\Z7
/YEH+IE@9OY#ZG3K-bH8:<_g>Y7R/+BQ3?6#f<#S+1;F+?0[Y)F(=POZ>(b/X)\\
C:8(N,@bEE[4_DTc,9.#U]d)DRDe,gITEJ\<O4CU]4FJ:<7Ea1Y#OdSg]<Qg<UT@
Mb3:TNA8EK&@c@CVPJ#E]/W.)c@fc).7L44\/J[XQ>^CcM0\\=[Hb0KHIX2B>c+^
-[J64bWWGH8C4,91:QWeb+)6=_=.KHSZNVLEQa5>[aO7R5V0NMVgJ,Q_1,DJe_=.
55OCcG0J>DD><MZ^+_FF@ASCCaS)-D;998/QM_0#^EY7]LSeV#N]a7&FUf@f235D
=JNYB924<6GR_-@9dP1C4,W+),)1461BAD44+bD6NN]Y>@N;FCK:WFea&2<Yg4f\
?a<-fgT<20<ZB8:@OMU0I5D;2PI^1/U2CDTJUFE^f^P4bHN>R2D(JA19[P3;J3-9
?6b>#<#P,>.M;#Z[\(22.4DA1eN>#44R/7//[\.H0@]N-)#SPY\a@FXZ2?C6)aG?
Se_\VOH8]D>Y>41W]]7^N<GNJ(<+R6<baT#6&LLIa+BGJaO,6EOW<(,A#9Y@H80)
W_b#b->M;dV\3HN]1;)KFPQEbI:Q:#<OH^CWDB2+8G55@\K605_K]0;ggOg1S?-)
PEc=FX&,W6cXa@4&ZP(bFTMTG?&X174(@;=WD&<1H<ME4GS)H?D_95VY&^NDKDfe
Q(5,</=Q3YRW^)L>-8QO]0U),U=+a5>f.C9@DW[]aDW4AEN5Lc6R#Ae;;)=.1]8^
J<P_=+:K-.Q]fOEZL_g9+P<V@N-b:5Tb=N_5TTKcMS=>^^/Z9ZPRYd52[D2a)gI1
@M.d49=+J34e+OFQVXTFRG[M33&L^IUDA63X)@]XQc_-d_D(1?3Id56\0SYNMG@Y
?IA#FaTUGb1dI?bW=gUNfR0ebRG?AU/_SYU_fVc9W/J/L8JbE2T94d(E\cNDCG<<
4DH:L04Q:J.HM#5?Y3KR:c4BcH>S8^)I)IX_.fa8E#?-b2CS_BI3VAdf_2VQbF=+
L]-,C3ffPOR3^H5QXS9CD25:;G9&T.(&+T8&96a6Qg,dNRVGU0,NQ)DR)U#f)ONA
\fBgS#[_5PRQ<U+CZ^DQVW;b=XcIPIe;34Yg\LU:&\NC1:0.\::Q8[d.Qe5)T81D
)I7/2]OG?>94B>117J3+L64E1UD=#8\8QDPQ+N:cHBfVbcf7[Td/cf1f,I-d-BT]
;bIR<cJe,g=e=5?V)c9YC9:@YY,f;EYCJWO77K4H\>O+D[EMC(;e=d3O8TGD:9a)
a8.2.G]@)>+9+LON<[K-R?:MS7-++RZCK6ZA0[b]d]7V4DGL83A>UHM>KgS];/L5
E)agDe5<9#_g8H+.D;DWa[?^fHW]TV^)b,=_>\]59X6,5QR7GQAY&cV()G6;@HU:
^P/_A9@cS==A&3/0&;gCSZ@QHe&B2_cJYM.S?B=5TTP8a:8>,WDU1+UDA),&(5Ya
&OQdDXPTe7XWKJW0D8aT/96++gQGV]I#U5B_cdO?46JgZT/55Q;D-LLK-\AQ4bBO
Cg)6Z:[ZR7D>8e#6ZH\UVaA,LOY>&&65+b8?dE,T&-\d>L#:T#(AAHXcF0W-K.?(
:eJXaJ3R9#W3Mb-GNeP/@TH2,M/.?ND7L/.4\:O4CC9a(-H=HP,1(0f\Y@bZZ[FM
MW@3=Y3\D5G;#)cT.MHcN\WF?e&f6#6WK<QgeW4f-\A_88,-:OI)\4YDOBIUPH+g
P1YUQ5\R>(,A3d(.-fb&@:XXVZ:EZ<KR@F^?<@0JfDX)Y>1eG<7[6SZH.95QOd\b
K=>d+@3,_M_L>f8I:;4XDFLJ.fE^6MYaFB?@-=fLNEF-NEg3(LRdJBT(aGO](Mf@
.:H1CF\=\Y4CEL;FUSTNV[G9@>5LB,UJ/,U7?a3)#ce,(GCTfN_eJ^/[Y-@W&Q3O
L(96g5a]REKT,P4#><356=8QR-L4HJd-dB^g<dOG9>)U&_</9\71J>I)&J5e6c[9
@;DCg,QSK&0&89?HSEI\6,/=?WTBEbVe8HLF@eJ,L+YRD#R&JeZG-ae]X-89eU#\
QZ3L.U=R-_-]c2Nb0)Y+XQe;dP[XUf_H&5TgU#(\Y-:5U=>+N-Zg1_CU&VO-L+-B
/BS2SOYdMGGB2:=QG8FD]:AL8.AX>.BYc@+MY+gDY&;^VW01=IJF?E>fT@f])-If
P/GHGH:>ZR+8T4,G-6<D<+XAD&7.T8V<EH4725Yg3X-E9N7WC(_b4092+.63BgDf
QH?32004gY23]A?;b22?UX:R/_UZ]4>()P/KJ/,=UP@AU\KBU0UM17TVKBFcSf6O
YcYO)RHad960I6IKa(]O#G.IJ-DNeHc[L[S1&BUP>8&2ND5U4;b;6a:@34(4EZ.(
JM^/H>W4-HIf6/G^\3P8P@&M8C[G>61(KI-CWaDT:R.-FY3\8+&>b#UF.@E_42#L
f635-^(N+/_BG/\SdRE/7:;2??cQbefL214#ZK3d@&XQ3+IXNHE4DC&C<HI40]fC
GE+PUd+FGb=2XP7A6(<+=6]PVJ/2+80/5XSfD&Xba/5Fd[&UPU(9.P0F._PNO9<K
3UQQcS;&Qf[O#G750_+<EagcN+c8?Y.X/(?H]+&0@31g-.c[,(C<Jg2NY\+GB3/_
B0)J=8AFQ9eX5=5)P8gfI(E7&K;fVU6\93OF=NcA-+,7C(&\X\#(QT]KU9D3DHBe
c7;fTg+=VT&J])9&bI)Fd/1:7E=3Hd8O;/O[4I7O+E?@KEWc=BXRF=HA5:&>QOaR
FJHaJX/>4-)Y3V7#U.AAE7M1DKM//+/,aNCU?f991@A23dIbO)\M/Y\\d)g[b/39
M/_CJO,+DY0QGQ0_LJ,&H.?7E1dZ]gFSNQ@1HL0\676O5983_H2JA\gYaUJG.gLN
]=77^/DB[6+9\WX5K<.@7(?R/2@C4P2IaB@KOIE/Fa@d43R+4S5bXJ(Y8He5=4?M
X3Z5JE@VGf?]21^T^\:f&Y&<4UR59\383a[Ad=8X;K+IL(8T5O514;UGb]bJd^?J
eSR&e4N0T@.Q)9&?#H1+X0A8)XT).f:.7/V]c5P-(L]JY5/1+D=cg@4&-BfA.b-_
V5I3P;>3\.5LB5f.8P5.a_:-Z&3EY.B8W:ggLMKE6b,E5c<fC/c_0VS<OI8-c&:C
VUOc7D/Fa/bJ7[WAOTP:K@>aV@;9Kga,.2>OT9\,f930#GgDM(BE:Xc,&C(6S)K<
/=JF(T-,[96_/#NV2@=\M@=)MGY83&,E==B6.dG@\e=:U+.EMOU/H<:#(PN^J2_]
RBEQ[M^&FYOVf^996R,U^2b2DAA[UD^)I-;aRg]SdQ?VK1K+BeT:4_7,gIgW+aC]
:NEXQME(@ITW744]/fIQJ)XQM(VOFYHe[D-M[+S.^e;<UE)d52YHa-0DS\6/L4P7
e4>G0(D>:T752_gL?;/&^X^Z=OZ<?c6@)04@>9F)f/2.V1PVbQG9Z_dV2;_C9J]U
OS-:_Vg:85WZDe2\05cNe.Zg:.3+U(/[(bNLP,\7@8_TeUK53gd)7-:-.)2FZN1E
PX?g[V0QA2\R[>T31MZ1O]=3gNJV69RIgXBaE./L_7d8TK=1JQJ<IX#&a4#Mg@Y2
PWA:CD7f.@:5EbFQZU,Q](PH@:YZRAcJF.PZB0<K4IT+eb<\bDNC[F0:U(T?NGKc
6&B03?UOZ=gc.bETTe2\U3=:0)=c-I)P.<]55,[;c]S>\cY>ge>YY,ZJ>[NMJPBJ
P9J0X5NX#_7d>[U.FI<=[L+RFDH>0TC);6G.L^23Z/O9^A8B(6d<0VQR0&eN]b9^
4C2d;1b;?gBO3QMZ4;EYT^-K2W,7Z_DU+G87IU913<Jf5;Ed,P;00HV\^_>gP0VP
ab2:#R8,:01aG\@2FKG86+51Ob+X0DT]34Ef\A+R2cS4Z,.RWbGW:AZS]3)[Y&P]
.Z0&cIf;UJ.FN(]=4,V^-KJ9E5TFWb@S#6cM4H/KN;^Q:fY^/0[TN2#M10/VG@_c
Gf&&DT2[DN-\V(B9#aYKST,D:F,:ZB;VQQ,GZc,&7.#=:L@OL-)Ob@L9Q71.^=Ig
Ib=fD[BW=&&f&4aZ::T;d-Je:Rb5-#9F9+[7+:9fR,R@b=F\\YY3N+NLNHPJ4]F,
2T,5U@HJU.7G3?g\/.18cMI.CR2dK#&L&1TAT1:UdX2:VPTA02eHQ)2XEQJD>eW\
Z[G6;DXGX>F>Z6_ecK6/>6f55]aRGR@94b;EN3TfgPHOS_89:P4:K9L&^0M6++[@
8GcPaTTc;AZ.;BCJ_/6Zg=AcWZ7Q5S?S7P_\L1^G,#:/DG;d((aB+>1AIE(>]Ed<
+Qda(@5(3:e]L:;(DY566gg@\>f0BB7^+4U\/6CB5Q7GA63dG):>3.#P9:Y4ITCH
>?G?JQ/.3aN6V^<1^f.K>.RQP3(HR1LWVWY:J0.6EL;I5=dK&QWC(430aTSTJ5^<
[J[YGc2eVT<X<#g^68TZD?P&W;&@C)4:fIKc:AHC5M(U7Fab,Y?1A]2MOA;D#TG.
(O5)>ePHSWJeDP8@Ib)@f+JPC&\<&2DfY_3JSZ)2DNP(Q.Z@&8^#_[&Y-9gKS#&-
:1:;--D/?#T)?<&V)&^I2NQ#Ve(YON[4L:2Te-X-/JQ3D&c/L8FY4.O5X:f/JGV_
A]&AZB.@^JK.=Ea@T][f/Nc-Mc+)b6gfE5dgeHIOeMUV4)ZV/>+&Q8AULLXK;3RU
ZP;HMKa8-VVPP7Q=G<WH@\FY#EJH=SbE>_8_5-WXNA>gORZ3:EURGG4E[3H/Z16g
L21AA5A8aTNHd6HQdE9b=fdZ\#:;;];JW?/=gg76QDR8(bDEe.ZLD8WWNAX\8USQ
d.S7VJCEID_&(/5><CF)_C:2:g90,X(gEb-LC)]X/fDQOYXRK5_ES#FQYId1#3G0
QD@g&V1QbRT^D,]:K0^1^T(Ead\?M3;=#M@b:2PCWW;]TcIa91D#0#_,3BUdIEUE
E#FVBd;P/3Yc+D\3E@7O[1P=>@E<5]GaReI:#/\>YBXPf0#(_]#dQ.&M>TEMJ]WV
YTQ4MP:g&4(EENcZMSZ&?N7b)3]/S178-75Y_4-WB-ZMfe7_RN0@#]CDLY5H+;JZ
1BOWW^R/32SV;WY.SgZX\NX[B5aS]:SQTQCN-29-S(89@N6)Qc;#\0]IX^9b1fJ(
<]\74W:VA[bU.g8_cB<_GKaGJfA<>Q@+5<(4.8UEID&4Qd8]8(G(:O62QER/RIa6
gGY?AT^K&CG0B[d14K8#OB-Z5RUZ&LA58)7R^_=c3-J/I0f#UG(.e(dCfD?-aXOc
4=,Kg>N++/PaUSG8CE=0LSaS;7c6L6@T.UK1410_00QT7PA/Qa?(8E\.-@7;Bb^S
8W46FP@M7gTgf<4.<#=M+,1c>=3DITe-7\;A+^0aFK3d5<fUCN9TGUCP.>\-+CN+
eV,C,#d@Zb-BR8J65ZVeMW1,Q(-G#7P^E59_#eAK=5c=3<9B6_C7[aQ9&OQdQ+G9
A?C\66BOAC==3UA[fdXcJaYcEGe9DBU6>11e8]R>?0F<L2gNC&S?YZXF\6//S-2A
B06e2O.P8KgNC/\SDfaXb#[#<@[-0\:WZAR\\f]+RPKX;Z/(Me62K;8ZA9RWB:H:
Nd_M>O^@.dNEP;6X51^XXWM(ENZg1=((2MbVga9SEDe8>+K4-/&6=Jc:RBXPNRbG
]e4SUNFdGZLY2K=H?5>8-fEL[P&NPaH.+KWE;PM^,.A/<OQ]gcT6F@(,>D-#fEI0
_b9f,AM_+CYT/P)Y):;:CQ,8H)2[XYTJS+X^[K86>._P:c@Qb0QUN9:D/K[X>&Cc
U&Y2Rd8?W]NJXR4X2Wg[X5VZWb-M>M#[NXf&G?[X2P?EL+3;#ZIK9L9+Xaa-GHKN
A.<ZI.Qd4_^^_S3;2(O<J/R4LN<<MKSHF;5_Je]CV=a2EY4U]-XSb\^:1M7Zf@,#
5L>JEFWCW6PgML]\R0:^C@3I)XI)N=K&SOO5Ze6YY4+UA2e-S4Xc=4+K@,(C.]X]
?A\DbXTXDO5=PF(P3RPZJ9GaX+#MEI);#b(UcYIc1]:?H:)HbDUGScQICW=7e\eM
(7KTI0T>#W@QZ)f95^>IJD)<:8=N;a8E?;I&4N4g[OZ]E?/XM&9@C9)UfFDUN+g0
2T<\X,DG:-V==T&/DJVS_E/<GX<3;<8]),)e;-Q3[bLI0ANCO3L1I+O2MfRg_eE8
K-F;U19ZQc6g-7fY^P--g_Y++;)2_Y;NOL-1V/\W4:b2LZZXG6YLI(_0R?5[TDWY
3aP]?#ScBCWA7D7J1A[]5gXfJ3E^f+(TWe^NR2;-;+cf]?I00@I52Rg(X-F.D_OU
^CO,D2WD++P5V#b=PGO[[A#dDY_&f(#K.3@W575.c8@Y(;KJ2aW=bbNcbY8<dNcK
Z:f[>37,AUV>?aDcE;D,L[.8dOE_0=R1\D.6Oea<K;PWS5CH=2U#+fJH,;,,_@dS
O]>3GHWVf<e6V1+<U:>c1B5?&.Z)@V22A39Xc2>J,0@_SQUb,;eTJ?IDRBA+,b3Z
=@Zf\@c)2#80FH@D:SVcW-:fG\.2<_UXc)=+K]J70aGOeWV/]f.f:=;@?4Q;K-]b
IOX2O[Z4X6ea<7#L9;LbQQ;0cI)RU)OCcY>DC]XD&S_&A]Yf@EKAFQW7EIac<7SJ
..60K1F5Z3H2(S6S_,KaC8/\&P6XK-N8H.8VU.444D-.bV;adZH\U:FH0[.B77g?
.YZ_<JW3X9)R;OUJ_1f\DL^#9-cC4<CFeY,d7UB=3CGg3[.UT+8_K8,Y9bSf<X\K
)X;.[PT>fPEO>T425\c5[\.>^6a=0.V&aeG.9TMN#4Hf9#FTXM\X3[OLFI#,]W3=
4;_R\RZRS)M1X2<[&@cH94@-L2Y0(#EfBb?8_D^Ee.@@Rf<SG/4R(U,,eMgabdFA
T#2:_NEH=N/IY>2F39=94LAPYJbV=,()d?46/YQA.cYH><JN<IS^I<4K;g]b^=^M
</_-6-HP2W/6a:\YW0971JX]9)eQ:Tf<]40./1Gb-X[39VJF5@EHZ6gX2T_Gb&NE
,09??CJTL3.RRH#N(H;NP(;3T9N5JQNYEYMQTH6RH7#c]CPaZ:XaABG?Kg7ZEVB5
1)42e@SFLFgI9a4YB,gK7Vf&@X3+BJ\1&,UfPRa<fW3;40Eg<7L>86Wc06P0PUPF
Gga1;@+4S\(,I.?&J/8Rf(M6EZZ<eM+&]WJFX11PD5W7?6G.F7&5+CN1]I>8;QKF
NHPc=-7f2+#E\c_=&=+gJ.dgN,Q-g&QWgdTNdQ-YPdR5DD97GFMLAYT09QZXRJ;?
BFU</2KK@52#I+G3(N8M,-WD4KESR7PR/W]fN<TGKf]RAN\?[,?//P#)eKB&QRSP
f7N?B<1[H-@UR)^_,\I#I_PeMDFPI.-I?$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_MX25L_AC_CONFIGURATION_SV
