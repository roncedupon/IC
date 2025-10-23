
`ifndef GUARD_SVT_SPI_FLASH_W25Q_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_W25Q_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Winbond W25Q device family in SDR/DDR mode.
 */
class svt_spi_flash_w25q_ac_configuration extends svt_configuration;

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
  `svt_vmm_data_new(svt_spi_flash_w25q_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_w25q_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_w25q_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_w25q_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_w25q_ac_configuration.
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
  `vmm_typename(svt_spi_flash_w25q_ac_configuration)
  `vmm_class_factory(svt_spi_flash_w25q_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
O<gVP1YbZ.\eb:=:>ED96e,1E\M)@a:QLO&[cK;3F?gQI=6W4[AY.)H-S_eI<1aM
V_-J=@WTJMJ\Z68@>UCPgF\0I&Zf9W6@]dFbUd+?^Q/@H8_Lg8WcQ@8.:C.&a=c,
/<:F<U1?a9-Sc\b/\Bb//M<>^ac12#V8ZdQ:[Ze@[MV)6(1e4E)N\#-XCBBF5S3=
8TA:=&.^UaHV5TAI0C2BNOCW)8Id.d-+]CLT1^^P6JA#Hb<@84E\==<TG450U(bQ
_[,,W:Z8N>#+e^DWBD_+WKW+MT;RJ:Y:+J\bAO#NG-MHENb(<9Xg8;@Ff(]8#I9,
f[g>2b/_LH?XQ5/N,/Kgf/aJeWPg?C,V/FR-OFf]FPN30B]Z\:&@HT,+T<7;AT=1
LR,eKA,TRL/-Z3RW9#\0^bN;T^TN@)W)FgTWH3<4Y;Jcd[3&GDK7L<P)ZSFe^NSc
F#b#FANR9@)&V,^B@#3PT]2DI/^S6[PI0)::3M3T5O?<K0ePM5GNNZ?K#d<^;IOE
b=<ag..4g67>S@RY+/A-g22eMcWb2IA,?5dDc0-?-Q/:7SBZ^gfJ[aN2=IO>N300
B>\N[61LeJ7QZZ0QC7J]9PGJ1YWHUPQ:_MLI5J+>9-]fBH9512>(0N18/\46YNK\
71,7FL<#O850eEF#+VB71C</-P:8C>;+MT#RR2SS0QdM(Q2aeX<B-75Q+8UbIFH3
VK&b+^4fJQHTP)7V7+Ug62G14&]?-O0=>a_BP.^\CcG,,aLE8TLDONc&>L^+4c9cQ$
`endprotected


//vcs_vip_protect
`protected
LJ\e&27,5>DF=SWYT^-&?@S)GD;6F4_UC9WR5Z_K9>L=:03#I6:a,(eX93\\[43G
<V-7[[KC#+HMU&P5I@^]D9F6?^cSQEI>P.80Y&LF1D7HM(dNF5V<)[HMO8-XKY-]
[<OWD2[D]Z6:]X]8EDgBAN_GN4EE#-ZKFJ57]T9g:-_/Z&7)F7C++:><^eZ:7a@\
gJ^R^HNVHB^(G-dEKBE)526^e7W9_(KQVJ:O>.FQgCCf]4KEQ7)NDUL+<^5RHMA_
B[K=T5H&J,H^18[#UPbVD1LBc+M5B-K6/5(f:YWTgBf/4Od7QWR@:K-54A<XPd2Z
SF/fJ@6P3f?)Cf/2?T[2KMTV?DgW\)2I+IE4:@dd)d<A1;NCY<Q5O?EE>)?Ag?EZ
U&RT&[TDcK9O/QLP-ZW9&b6(bYOY)D-6=PaQ&>+EV8VF1<ZNAWO[0D.)IC-Y,Y:#
&0Z]B/fMbPF\_^DEYBBBAaGSZGWS&I5-ORS_^P_8=]Y:<S91B-(FgH=G^&S&eM5b
BQM<LPOf[O_R8;1V1.)^gC8#G]1:W9@H:5=YWDYAAYET?dDXR1MU0IbUA_+H@#)L
>A<g.V.LU&8ObOGI#c/7e2D2)F:#H(4C<0RG\QDY&7Y&+ZG@[HCfLf&W;GgG9E@T
7M+L&dfF[>@E:2>C4,L,XG\1;71D?G3=56Ka39(T@<=CCCJfH<+f_Ja3<F,?&fIe
)JRL=VQB7]A66\BTU)^4Z-?#L;ZF^U96XK[U?O=[RcILUIccTcS2&8PU4C7XT&]U
C#YfK[=ee^V=GcN\Rf<1XMZXIF\[HHQ03L@;7PR1X,0MDT^<=UO35U<E8IM&IE(1
2_]MSCT^+KeSGK@?@>M:L?OWc?<E4eK?-#ad(;A\)[N/YOZ@-aJUE]HgUL6J4=<O
W?DgDN5?N,-2GK#M;dPQ&gF<@=PNK\J38eSEA/>aM:(TZYKQ::3=bWc[4F35ZdHd
A:3/2Nd8JV8FHI<;JcJU-QB;^bHB>M=\<TOYF7<]YX0<+X/2g/.f;04UGCQ1]B+2
#BHD<[SEVC.EQ0EKK=4a8A]A(MK=I3OT2@M[/;-dZc12[Sc-B6>d:aN>aX_O2Y#O
eF^I3OgBK>M,G?UB].W3FM[8(>G?2>Wd(4UHRR@24]IHD<X55K+5></9(E=<MRbd
1.;:=+)Oe11FXe+;+JO,e3T=\LZX26b1K=+&-Af#[B?>Z?W<6XIafcVL\A5)Cd,N
Z(fTU)S1^&#BXSb7b)8^1Nf65X@H-C]MC7b[YY)PC/]E:G4WSS^+&X/[aV]Y4EDE
9;I]V@0BTQZ)5.<#K6/:]_HN/\ZQ;K<X5:\D:+Ca5899[QKe)@#OFB<8[??,/\Z^
BNT&KLU]5J)1\)0)UEecDd+CS@&WKERPAL56Q<H+&AJe55<ALFXUdb:^3M=eP>]M
6Q-2NO5c-VALeT?+YOEeVP13/b16;:.R7RR4Q#4KJT(4BXa(\TR#SW)(dJZA=1N9
4=0,LHB@@B)7Da7[KP,9>4.L<?#?6;R^@92?g;.4?fKcH()PZ^8bO@C.)b@8EW+.
G1f6DAdaFMH??8d[5-XJag1#&>/#_eE?,8D8g[Wa=bPa:^B)Jg)75D[7[eYdJDJ&
GdH,P]:>gdE4.7e8f#B?g_EO?WGg+TcDdFW,MH=T=RP#W-.&=0XXPbXCZVe+efHC
gW+WP.)SVKVQ\ZD^(<AWXZC)P(<(>\T#9W^MH?WD;a;PDf3GC:cH#9^JcBE]ZG,c
BLX6Fb\/dU;D(HCN9&I?44M3^UA&I4Nc)MVB6G3K7-bJ<CIgd4=1C-X0?IQ:0OBI
)U&W]bM@AC)eV9LfDBb5D+Q@Z.3eU_Q)^Q77TZ^<_?JU(24Mgg5P1=e88(eXL?@7
J4K?e2d5?a&IJ40.2&Ca69UabZf1NO@Mb6)WVKa@F),57a39?5;CJ)-=-ID0;6eA
Z?8J+1#R;daO_LQ^d8J5a0;[)eJB7L_6f1P>?#^dG#,L\f>gOgd3-<e99/.>I4A?
)]IaOS4P&1LLRC+TV<.aJRXF8&.8a+<MdMfW0AB<RQSRHJ[UWaFK;DLN:>a:N,2&
eP5T\EdF05a.<XMU_UCSOWf]d[;SG7[>+Q.:OULQ#,g&.D_XW^8;&^VM(^EWY][0
M8,;PZ>5,3G?+_JK?9QYX#YEI]5[OAKS((G;NE(_;O2H6H:7OAHR-^g7J,0G3.fE
b:TMeWTK<=P0N^fY&#38JPY;8PU1fJ6Ka(MDE(Ic?.;CG^58VFXeH8&,X9Lg9VE-
?&a#9DM6O=W#)8<M66AEEF^Y1cf_ZFe&Wf^cJa_TYY-d>_+c#?P7-O,8.T#,PTB,
dT+[eKAMHf-a_Z)_(:PgCV..)G,=8#>f=25ZZ/0cMR(LTd)84_(.?d3AP<Qaa59A
+E/CNc#K:)a5HUH41d.>CV8G_(N@M4=-Q+#F-E9CeD7-GF7+RY,0>_a5#.4&gZ#(
J#9^TJS@KBgFW7DI9.T@=]9](&5NgM?e#.fDU=>)Q0AWDM4:^6A_FYY]7CCC8GSQ
PY.<aF)-=XI/3MHD.KYNNF<.NJ+0EUOf<c_V;@_PAXT3O9M(8]>XIU;J(&0&J((E
gQ#3MPNUUfT>5M_0DP^5VJ,F3[AN/T4^8G@MV1&=a@[[;V8fZQa+5<Laf3d/ML9G
7@?XIdLJ<O8X7;@daS,^dU()43],]QbQJZa5Qed>.74#]Rd5EV^3L4-F6/OWIUR4
+/XL&fA5G:2D@>c5,[6=4c=[.9U70]^gYR8<2Ra;RM-\^-UbbF3Dc74c7AC=/ggC
P[W(J1&EI@U0P:ZSHBa]eBb=ePPH@@I?cKN+ZA.a-L//5P^-OM.\-#L4SQaQ)EPd
d/-:>SdK:;@bQEc+318#fM.KS>K\ESOHHf.:3R<-@(<P8F4PO>T.WTRHK?9;]V@[
&<5CI+Scf_VgQ>UF0A?);SOCgM/NHB8LB60aT#bc[H<57a&BE_YQ@?LG>)GM=-+A
d)[[>SddJW@GI(XfE.Sc=_0/O+O9^&:]24<;F^]0e7NF/MSgZ7[R9,\:.5aY8gD6
:JK2cC:4:X;@<?HQd4.GcEfgP5Q[E\X)91ADaAY_>IC?N;J\S&R3a[f8JUC?dLM0
^>B.--Ma21PZEgD];g:YJ]gM+F-^-Z,>EcIF_^CT7\a<DgdS0&.GS:G=fPMIfYY7
)2?+WC8LXBee[;gfZK8SEM]AE-HJ(G8WLA.]E)W;(gfKU4+cUbN?L#6-H2MU^KHM
JMVLY5,\8b_Z_GbKG_B+]QdZ^9:^/YS,<7Ff@H9/&1a3\CVTL/1:F^U()Hg2d:Ja
5^V=g:PQ/5)])V:0Q[)NA35/9K,Le-_CKc@@JNT.H]>4e7M.^Y63KZ.ag&QUJ0W9
(Q?CH)O4,]\Y^ZgO+bVBQK6VVe+KV7BfM^E<K?c>HacWBW^fTSB9<R#66g<?QK00
g0]K73^+RPP[65>TTWU:AQeb:W=77C\g]?.55d;cI0/,d)3Lf&OE=BB#e<T+]<UD
2+JbLf^-N<K^LIY?d0)^.@@fe@C8,GQJPQ,T,e2cTEP2MM56GbCQ7g-OH0QGc2D2
O5fFLcW;:[4fbZ4L6NZ(+H,CZ47/CP9Ta2M?8)[A?X2[=-)^cJ6<<XRe8@V4@KH)
@VM8A+CSCEfCJCSeWNF,,gHT[FGR&NA@ELF@RX@8S:3?eA[BDNVDAc+e>aZJ<S18
FPV)YEB0Ba?.FBTgYbA_I/(>=,1/^8CJc\KNLG.M&G+:3d>P]QL>PO\Lc5+8P#@I
d9JY3^T)_?+ZX<63[[]gSYCdf>LH^d7Y,\9&5fd6SdX;GX;9;X0+8GdFJ(R(PE;a
/Z,CG)>I-^1EE@:LTeH+gDNdT@cPV)DM2K3;f7H\cP-a(e-N&P+=;fBT92_68=dU
OgMNTC.@?>@)F,<Fa/+)g<-;[KU;.^M\8#,X1W[I..g=g\DgAJG.^AZ:_;\G<V[9
DF1U13fdZS<B0+0gK[4cG.K@f3=6Y\.ZW\==+CIZT@gdI99Kd-5[Lg?,#</g6^\F
2WHODef);\HgSE]G-WS<:&>aIA3c9IM>c;[B80g=4JP=(Q.(M31^b0AH0^O/P#bQ
8S99J=[6@/H8,S-Pf+,dZ9.bMdc^3e[-G_>4OLdEYXQF:MR-CZJMY973--9O6&>M
7:3;1X[f#H)61(5<a7]3?2=]#\:0E:2g2MIX-/6PF_0/X843,FTATJCYF=a6YQ<I
dDRf/3W\@HJ&Z)F)Y1)D)(45R4T=#PGQVH7cdSI[6C>MWG&Xb]?;ZFTe/C^Ve=&#
S&ZR24Y7(7)Z#IX#9b2fVB49FTfD2aS:VLZ8D@.V844MQb1]2gY6^RU0be4.+-69
7,eHEKb&)=L-&YHX.U)Q;be\#7-VQ+9c9a+ASQ2MF=XO:D#SFY20DEb\VQDF[W)\
e[WHeX[FQY?_<RELc/O,L5QH(QOK&SU<2+0[LR+K>O3U8FSOD-68B<J;H=)/UK3.
PNE)Z:aBRS,_<7dX,J)MYBV@Qcc9=GW6bL5-K@/A3R?,b8/<RAJKe_dNT>-N&dT6
LN8==_D@_AS_AZg/PUK?Re5?:ccJ)O>V6AIdGU&@)DWa2BWF<-e2N2EYU@,\@+X9
=HKV#HO#<C,C1W19(4:1CLD>&(TL@d\3=(Q_3(B@-5&(&A7PZD;.)N:JN^;<M1B<
#A3\<]VJSeg,SBG0--<@HE5JMeB604NaI.]5V0VGVHLV;JRF,7@DfW5OA5ODAGO)
VD/a@.2g9+U:ALf&YR5;UfZG5GISaC?L[(?NaTTRTR9Y56+16gS,bd>Y4bd5Sf9b
090bN&NfA@.FQ.2ef@(SAHN3]G99<,gYBNaYQ72N&E@.XZ^8c)0_?B=O9MN>5CBA
@c@^_&e4[Ag#WRU7XSF?D6c-/f>MZfGcG9KG1WdFdY.MMQ]&6RJGGRL1-]-dU626
5YX::3]g6LVZW.b9<0[4):-JI@:_D52f/90b.Le1R6T7.?CRYHHDNHa5(6V@+6HM
P\4TKV6b?),P0)#<SE.B#g;Iadg<)9.KTG&QUH#GDQY5JG67Z8[\7A:0QI<:V#S=
HRTXV#+U:3PC_>1/&O@e)6-B8SAQA;NeS[(AU]-BJ[O+6/a5?6Q3X]>3LBb2E2^L
24FGLW,O8TRI(.JH90TFJ-L?bBVA.S5NJ2]Z0PcceWPB2>5Pa8LeN-dTEQ13ZA6Q
cIGJM<1Q8GQD6f:Xc;=dM33?+(AE@0E2/7&PD[L)=M>;5D^AR(fG]=bS5L;C0WW0
43M&^1JVZPK08=>G3=>N?+A7:N[9Y#g.AM5+_>Q^S#IOS(3U->?NWPVU(U+5VQFF
@O0V<V:a7CQRXA#N?M8_XAfLL3+[0=F(<K_5dS2[BZX<Q3XFWH+.>HS>>?H,\HgP
b(W=IJeGV+QH?Yd_@Le)N@1F,ZW#U(1eZ^bQU;PTQT>VH@WT/^S7e(e5MUS(9KP=
?H]18#V/^7T0+F,M[O<48\CF[#]?>7f7MHBBM-@UB1M?&QgSVQ:=R@_HaG>\a2=1
0O=(6Z_L];OZ<E/:B>3)\aS,Z0B._7T6)4eL_9@0>B,L?C;E:W]WAM3a.T^-=bg8
ed+RY#C5W],<8>Ef8E1QFHO,@KB0[N)<#af/Pf51=7H\EeMWbUMB<D0^a]<2U3?L
/gI-d4.106-a#b87^AeQ6aFDLOa#>Z6SLDK&(Z5=_3@F_-2GK9^HU@6JDRKX;M6Z
M+[<5c;_&G/II9KcQQH7H_5UEUR;MJ=&OQ[MX>0?4B6PBU1OeW^eM[QGR)57SZYW
/IJVLF=12#4(ZI:_fOB]W@5N+5Y)Yb)TOW/.<cTc)\>5R:S;]T]BEBc517ODdMT>
</2F9#F=R&Ydb_K+Z)+_37.L=B71D<4_Q#Jc/;NQ/eN,>G_aa7(=e\]eNF&Vd8/;
:?=b]c&cU\b9T8b?XA#dB\K&/-.g\9UKceMVNUb5J7_ZQg4XU1=Ge=?]VPD6gP6=
<<bVU_EF5S?#=-c#E8SBSZG\:IRa?1N=6.X#+B1^dB4G#ZTB?Cc>CRgL4H\#;@\M
gJY#G_Ug2KZD8)A[-PP[?M-)WVR3X>)abXO03]W/b<eX:-(a;3ECDYb>W\U(ZN\O
@HX77Fea2c\[P3_B,^fLSF_+-?cXH^JCI=fC[9BeA(AKZ>Q-W^[J#7fG[Ga6g?[g
dGN2E-(e3+5UT>B0Qa>ANPL-c)EGa-[:/FNd26Q#HVO,+W+-[2D&IB[7T[=W1=JH
BD-c_@OX(DVGcAOU8;&(Y3+bQOb1QARb\2JeO3?A4CB[;e((;F++CP@f-&XHMA#D
RfU2O,ReYgb9DPOMQfVVd<cWT:^3JG.64^=<0,UKM<4dA)fcWH4W1QHRHf@-4]LC
\OBVGbOd(OgCLLG)Aa]]a-^6;[QI.>c,57];(1=L.988W/eP8#Sff]3=gF8P&01G
]W->H(17C>a0H:JA_=P:Qc^dIfeY:)JU0D8(KX(LZ1+(1\a3C_<5JMeAU:<--X^:
;Q2,a5YH)&R(]J:fF>;f)4g_6c[ACI_B6(#?-b=4WD.I:OSP#6U9/?]M_(#O5eV_
[.?d;G+9R589-UT\-^A]R:BXAJL])/fOdV]FX#F@TaYOc3^_K-:NEb:4K\\Z&4E;
N?E8<9\5Ha]R.d@NJ<.DXALS(gb>NUWCI7,IR(OVW:&AH@:SQ@8HM>_-@[O8IYR[
)/I5fe8Jc15M)DL?I#&X.B(FG]@PLK@LbOE;adKOd:.@cIKY6PGHESXYJ]E=1Qaa
aS8:=\P71#(D/JC4<.-PCQ-CEe\W_2S<9TdM8[Sb(3cZe6HcN,]:GTAb-FI#4.ET
SA80XRVd9(3ccbedFbO]AY2?HL?SRBJK+L/B/0-S/V&6;QR3?+DZ7C)\7.,QRR<V
_VaLG>R>c@.XTB4<,BQ&c#+3&>(/C7(JR.QaVAGB@faZI[c)7eYYGM+J_],Q5L?]
XP@^^I;TaS3]NHAV7:(4<D0\ZH7[O^bH=.(TKZ_^3_7bWQ1+&E;c,gHS9;<=AXOb
7W;R/bbGZ-[D:.gVA649H3P)3E-VP>P8=IL/4J/c9HTW,3QXESJQ=[d2^I.X^M.K
6.a0.IQ_CK=-H/37TEM_SSXA6E>Z#EJRMR.Tbcc8>eVU]Jg3MLe_PFLDVf&=+QFd
134f\P2?RU.1Pe1(_3g>&/;]?_PLg,fZWC,?c2=b(Q9FD.T5JDSX-&EM493IKG+X
F\/QgMGeA,]6@<I>dG.-_B@SYZgA1ID6T7_<O\B=\HXNEX-0eEI@UDQ>N9XC()]M
K=M?,:^XgO5FgJ41.J8Pe,d\F[+G+U[)<,95gOe4ZY3Ec/@N=MeDce1/>5.(E(GU
U:6ZLfS#UF.bT5PQV;C##D;_(LKW^TQORA_CX#.^H0]>>BJ,+Le(\-fB_c:E(<6P
:d\)7<<IBIa3N5#9NcO#0=U:K+Ge-Z2a_O>Id/>fCR0X[_X=G;e]KEIB4[>TWGb@
8>5dO4Q\9PHII2IC:/9XSK1\LTd>E7fHFFAdd61>_^.\AS>/.dOID_+b<V3.V_3J
A=6P+\&CZI1[UB@GV+c::+eE1R1e4AK9=5\ZQB@^83:/0EQ5b\ZBUaW.YK>L#RbT
)FRY4:U5@-cHI:@-N=WE\[<<#IK(\@9BU>FDgHL_X3_@2&8^fJUKG-Ee1d0<SCW_
S:bJX>]0dcd.B8PE37+=YD/V6<FcMO=??74^^:7Z5L)9D.g&Q)[8(FC>WVWA=1-I
TEI?bZcTJ^Y8O)H+TE/[U\NcCc#AOJEB+cE_9HHa]6d)1CdV4,c2YP-[>S,YE1ZF
71N+N9(TZ4aW2Nc3&&^Z=CTeg-I+]^\FOT/KQS(MX(X=^FTZW:4H]C3?:<DN4FN;
F@(;Ug:dY@fU/YMc_E_TN2g].f6[K]T<B1]WRRTV(\?>P@B@;EaQU\F6dd\3#TAd
/)Z3PfDJHgI;2B4RY0;Fa<(\^CL<,:F^80_JF^1->R1gZ/Z3AO]Z8PA7cA8/aM#<
V@X4-6GCDBER8UZ((QC5\dGE(:-2?4\gT,eWV(Zc&cC8e/@1@#[gW7X<H44P2)<C
[5N_S?<<4OHQe>EB;H&+W3N/L<>K#6e(62Z3L5C,>,bSK9L&&#a,;&^SB7[9MCO/
4\I7,-\@]OG?2H),]8)2O:_X\,6K@O3VH_NF5:K>JIY([+H>EeZLWURe0b<b[28(
1<N]?V]X>):ed=Na8^RB#?Z65N.2DI-gd72(9<:I\/eDV0J^dB<).Q?TVNe>L#2H
Tb(Ac9?SY)#4R&2C)VQ^B>99:B;5)JH5RM1/f3[g^:MSXC0)?\6H&^?6EAGUfM/Q
95J8H\35TP\b#JF)TPABV?8cAQT?F1JX=fb2d(Q9AN2TY]9.:g7d-EDcT<EJ;F[:
A)+_+.WW5G88KIG:D[HW5OFV)#Gd4#Q+SSFI3._9K0d3MKN[4L\HOM4AJOIX\G<]
U47:+TG:TBB#)b4V+g3d2/fF1]L>43C)VLe68e4Z7#+5KRA0;aHYE;AGAf]?UG,d
E^A&gR2UKBQMD3:_ODK#RH6NAUeV/N:/(7)GLN([&;M,f4GX23)Z]IfHE=4+9@W)
D;gcTSb]8-5Q;7_2FX#MdWJcU:Y>V5V@&09>(,g<\^<,9fVN;@OEd4ga6fJ3a,/>
\4ES6;=:4bfeIQf9-F<8H9DM4P5cHFKX76ZW;J;:)7gHSNS2Cd\B>AO\VBaIGF_K
1CL47OFfT\OcRWM_U)>a4:GP=L:SF36E68&77;43?>XX^M8+JGL8U])(3c(VP3C-
TWJ<4.D(M+3+:X1d;9M&<IRN3[6/E6cAJ5;;HSV;&Led&&#D/d&FcCU\1dfM1:6]
Xf;c?XJ=VHDAY:EN1Fb0F;-7>2SRCNeaA7PO9C:-]dSEa]_,SN5C/T3;UKT1_480
R^)gE:&7DURKXYG5Pd_b@a[c[d.VT7Pg2IXUUX#)&V6[FfTS)c1>@SIRHX6]fR=3
SYT0YcWV(V\QWLA92B[e^ANU6:Z>FGY^P=Q#K&(ZQR?,G&cXUY-E]FW]U9_O,<:0
:MOGF_2T1XAKZcJGJ,T+?_^?3QaWba+;EZD?B1LI]c?;+2ed]Bf;7<KA@B@Ob;+D
4347_a&/4R&#+c);GXI@<<2^>R?G.UcF,U;6]?&6\.P?;5^=fc?[,J(/8PObY&&J
XSA75>]9Hc57T#Y+;b>O-\g+HGJ=f79?^f<MdT&-[6[\:+]+[S<Y>LERe<S&4W/C
IXB?@35O.CSOH>?;ZI4L6EMD+DMS,Jg&2b+J=Wf+3W;L-_B<g.Y4H=3E>]KdS<,=
R4)a,G[V;bF8\[97&f?Q8^OFUE#YVUI_;0:N2ZYEdaLW5.KTT64dLVI/c:@6L#&J
,VFcg6Ya;JT;S]:\8>PPE[WKE)S+2J^Y03g\.V#RXBWVBg,RS:W;H;(W6d6I7)VG
e87&O(dJQK&\e,]U0Z<HbNEM=V>H23]d[;_B;bd\SNU5aB@]/=7_>R?49e\7GefZ
6:gYX-Uf1^0.<&bGGHIYOT&Y=2-#L9SX(1V54\1FB>3gdd/9NOKQQ2e],c]1ZM-/
-::X-+-1-ONFUb9)PaN2TI@5S7PVU=U-f:fWHPTPNc)DJY<SSD-ASOEH/H(U(._Q
A,/@O.aT^JfKR.<P4J.4>SY=TQ=85I<K=;.(C-A#P[^0\eD&M_b?@V0EIO,Tb?&,
5/CCA\aTCgRL;J4&H,_6W\8^3<,[T<QQN-BD7#g6f-S,?G79CIF?.^?\E68CA?ZZ
B)M11,+L9)TgLH_W]-,V?6Y,Y,:E:4TUBNL8-/]BEOa5#MN5[VaGOE\)1&7+\e,+
0a39(VaU.?^7(aJK:OOSLK7UJgHKBaXC0LG,I<0S@-7M#-bPL@M#BVI>HF65-YYT
g7FXcLOe;\.X(/:]A9f>/G72XRNb>LBT]2QO88G?JNBKeLdF97]<cd]D3D5>;KD2
=L=Q5cX^CLC_.DFB<C^LQbNQS40;-<S,CIGBB(9Z5?\V@b:>C+^d4N4bW25Z#N=e
NDabE3FQ9BF,?+W[Y8aXKZg72-)-VQB>Hd>2^3gO7+ML6NQFY8>X(6G:?^F^<(/&
9<2B4?8@ONDX+[LE]0(D;OD53d4I.3[>;eH35H1XI5LTK_&d:Xbg7PZZ@CEO(2;G
,0(N4.U1]]8EgbH^a>3g6dg=QW7YM&ZL@=[9bJ\U&XX3Bd(1egK2]6eU4UX(@e86
PB[/,48,UHMdYYRG-U.[[e_R.-D6aVJJ6X&5P;&2MS7UWLLMG=R-Y.:\Yb+P&R_U
.\?JNF?,f;1(2JB+bYEJFH8H6/(?-VEH#KbV;d2W?dT3AR]3LaB.M\e,+2;;3OEg
:4I0ZHIH]>6XU=N5WF8DQe:@EY5JgN0JJ2AeLe0X;b-#W0H:#U6#VT<HBY=\d#Qe
^H/D#ID]9]_d7,<T;abA53:?+=89cF76\M(4fK]2#E_VJ37\#a<UD8=A@#SUNg,f
A^8@f7(YX#6ND.f]Q+QR/([#b#]@HPE4,,2212e/eN1BBX]K;P;Bd3.#T58cKG@@
JS(MD5@_Z;IC0GDJ0##PMZ_[\J=R,W95;?F0,c?G)8BNC6=R_U]LC(9c8#-dJGd.
=&SXV@[363O3UR[,Ab4Y#C88-A74OX)+eX#W;K7)&f-]A@Y,L.KIV_g]JgGOD#BF
Q6a=8H7)M;JH14WY#I08>^HY(W(@5Z1:]\?<O;86EU?W.Y7fHZ51E&>_YX7J;2[6
/Q3BB[Yc;@fTR5:O7-E:3Q=5DY<)]#E3Wf/0&T_N]FgC9/]((;;B+e;1+?4;)V\&
[)3e4Ud7fGeGB.caKT5C7I[aU?U8.(8DQ6eV]8^<E<KFd+,S1aQb;S(bda[D7I#(
X>#TOX6AL\5?eZ)bDc[X]2Z9PVY#-Mc_IWP+TT8,6.&;fH3)<8?2/+8@7V.Q7T4e
f];94ba6XGCO-Y3W4=,E3BC_YR45e<Z0,7A(3SAE6AW604&O;YDWCNF-A2PO\Y5F
MDc83Q#6^0[JO\Be]SF)AR=5X-dTO?Z9@cCJed25SMgB&R6/,I:/#1F5>F,eTRN0
,7]/2;8B[]+KN[??bbR-<_#>c+X6A/CK4[VP>cf<]g61ZCVDH9Pe-JP1P5d\K<HX
,J?91K]Z\7,RdJ<C(C/fcEY5U,&#A8PcCIOc@H5-=]6eX)(^1M5933_1UR8cdTBU
#e3=9FUO#OILA9Q9TP2eATTfV]Ve4ZQC)[918)^ZS.<@+H+g,E\YPU6NMTA&>aOU
\H&(3-CE6T0F:^,:3gX+Z?#Jg7BJACGXGe7d-SYY5[@P3.+P(Wf=Fd^^U?ZL,\^f
O&R1f)+-V3\1(?3LZK;77N.b^,89I\2@33)26Sd9C&UTV&<eXJM;PY[GE.>JQ8#.
#LL#B0ca)-b>BY,(ZbKTQB7UN;a0->&C]3CV7S4b9&/@IIXdYa<R3C8E5b=_dR:O
7#,J4Ad&)\?[5-d#^OcT=]I^g3FFCUG;W#T;R<[S\DR#=^;?WB_bPegNcB#bcRSZ
.<VR:Ca0\,:2_L9PRZ(TCS>@[:DeeQad^-@,1_bOE:9+.Y3\)8:_aYd,2ROLgV\E
#]dZ)KFE_OK)8g&:/E6IRe20BdAMe^IQ2ZdeMINE=^S=<g]D-H/T3BE:2<108aHQ
+#CB=,F-T:Q_UCF&f\g03ZBEX>TPHC,GMAWDEXFY;;VU3:eZ?_UUXd)V6e,3#Z0>
9]>4F:].#O14/D(6C)OV+4QH&7QdNC[/a+]J(Y=ZKB/O.54aXbZ4f.HFKZM50U#=
]J2_Q7PgA,HAGSRW.68c1Q?^ACE+BAYg?5.DA3B@eX\<&,\XESY6WR=[Z8M0()]&
;BDgC4:N?R\Z-0eJ;PC?b9:;CWcS1<aE@XTB2B2,6<\OXfFH3GID)(D8aPIU_0(b
>b>=KC3=1PP]0?GG[UN^?F/8^_/1;Sbb?ZK<\/]MQ=\^eUGY^HQXbQ0-/:M1D-61
&<>2b=3HPa[W=P&aTH04=A9,:gCZ^T[[Kf4egAD/ZM#PZdYO:N?CEDe#aeLF]-8[
bXSXGAc++>a@b9@V35dN(/7J#3@OWC,))[CM)2HS9fHBV5KWA5Zfe4?HO?\7=OU<
UPFMJ^XYEI>FF^0]aR]==gU&(ZQE-G;\CKd]SI^/,E0/CX43_;X=4^:V_bP)68E@
dF?X0LT3Q\0ZS5_2Z2T,P.YaZ8g)+?,N=QcO<PL:Pgc;,?4D<IS8^AL=RP7Q8QD(
335^.YBM0cWe^d1B^:YIg&WD-Q-fCI#P?b7,M:<G<D8C=R=U.Ng65KIcRMQJc6TQ
YZVDZE7#O0939@EL<&TPH8dQ;0PX:5g)QX.D6\89S)_FNGPP.3X6P9-f6S:L7bEH
:F=\0PQ8B<:4Y3Eb>.bE)Kf^SN6C?&0XX-6dbgC/F)[PKHRdZDd5?6b[S\SV3;#^
\BU;g(+=&#S/H_A4,U.e01bCCXBW50H6&8^D2:[789#EH4//eYA_5#?cHc<E<]N(
,MT(.f?1CP4]?]#Xdff_fPgZMM;6P(&==>N33.gDLgG/8?.Ac7BMLSfXT=G/>1)b
[N+10QRT1c(b52WKMLQ5VZ5ZHF;N5G?-&VUU-1g=NfZYbO5_92a9B-)?N3_^[#K:
e:)=JcggSb=^OIO],@:7U[K3LV>e-PD\Q?=]LWQF-RX62,eBF\E59C[](V./KY>U
Ld@cN[VA8.GM.\]Hd/W(>6SGe4.Z7^NXI9=Q5O3_&-QL],EYC(]9&V>Ua6FV=TW3
a+gL,I=O6-+).V#d8\#<\D+2_<ONR=+U^L&LgU(Q3Q?@U6<7R90KJ3aZ(=?:C[^B
a]5Pe=;H5X1WO#d6Z.RDV)c?^=WT,MY?I8G6&YJg3U:,2J+[2/g=fTBB1@I_3+Hc
YBK>bLQ4-4KR>#eWB69a1R7c9O^W8ELL-(T[.7A(T/1BN=SbT<8E^NUgP7:30I:E
9J[DR]>_BZ0//L,-/&F7CBfLX]8(f;0HGd@H<ZLLW_V,KR>E5(Sd1eRT1,E3dcdH
[C&.D,YG]IE(AKUZBG_44cUT^M(&dN18QBLQZ@YVZ)0XD^ge.6@O0V(HZ?KR=;-S
^&2,9\?4U13B:I_]b+=ZZgbJT\1Z+LBLW?FY@c8^2JVG(4&8UK^-./(9U:(ZZ];(
O?MG5NQ.SYKD3S[83UdZLI-H.F)9?g9KFQ^[d+3[O?@f)NCgOPOM/_Ug-#@60U9?
GJV;B#W4O+[;SKI6?V=7GT)3Q^PY2W]M,<.+_c?\,B9YE-+8gXA8&&R==3B0IV^S
\,77@=?#d>PXZ?^FZX?Mc.E6-;Pc=P=,K[^?08#M8B^YD^VT94YHROL&<N94S3CR
4QZSL^^?\K[aR>(&JL\eg27_@\2C:OCc6O.]RJ0R&1?>@YY7DXAaS\E/dO0c_ZQH
:Lf-1G#NRG.YYZUDIF,_==6gBdJO8<WESEf.XB<gZ6KM7/g[d(-@4+&R0ESIX>Ae
@ERZ=(J&LSC#]45,E4+A/f6cJ(0L#U;=aJRVEQg.4gT[;<[9/->NE[[&A,)V&HFe
6EbO0a3adSAJK5-Wf,M5W(KYa_[X@fI_UEOg078VD5fe?Zf?N47F:e<6Z0(XQ;1O
)6J0[6=<fZ3.=(0>Z1[.B)CDOE4H-CE,.1,IZPaba^QdQMReX6KE(P#;<Y:bHH1Y
7C5AN3U=OE:0=D>.?F])=<=_FL80U[FLP>\B/Z4S185NXg<AEbD1g2H86+35g9\e
B6a2e7Y.0g4<3V&.T6[#aZ]G6\BdH)TANUUa/P9CAFHc#@AB.8]C0b#KIQK[_J^V
&5K=.):3C@f__V<GJ?bF8E;b&,^PHK0cT9FR8;b&:R=H8<?c)<>7[X,P::,645=0
_\cKCHNY+XebQ#UWY;GI6GID6\B8=A,H&+1=#=L<56D8\g]4>b;(ZBD;M5NC(FB,
b/F65]814&<7Z@d9H;KZL2XgH8M2a:YgDGL+/M[+17ENXCE9Y,_HXU-bdXWPN5bG
fN&3d82IXQ_WA8P3S0,9E?]MYX/[A@I<f7Qf_(;1TP@R0:52g3^\DAb4.N?^N2@^
,e.UA4e<eS/[R/N0HXcYKe#SL4&:DJG=UXf^9CgD0K:XY74WQU@gS,;P8LV;LN\G
9U/-,;W7;fA_PI@NGLHC4^KEFbKQ:WWa?[UgM_ZSQ+I;T43[CZ65FHXNF,\)\SRV
[M=^Z2N4..8W)VPIcY[8/[@@1)WD,VEVc8_NT@UcMdRM?>-IZ]3DWDag[T[:X-aF
a4KI1_]2\M#d73OLN_b621P27CQgBIYMAd3+/P#WMYPLH/<(&e&B6Y251G.aAa#T
(@]NR9UZ(YNX8NO<6EUgDe:^T&0<?_;He\V46+_;Mg_K.);RA;8cbb<DUV9PF3<S
(_9FK()GA\K<4d0[/g<PXDWbf]O\&2#>g&/E:3#P3K5CMJ-W1N6PKWP@8;Gef)K,
eC&_C/.MRNA:[Wc:g;Z<NDVV/12_1\B80MOZJZE@a>H;g(XR(3OA2?7]-=ES-:_f
Kd3T>@768ADWPc9=>W;A_&Wd4cT&eEK2@4QS/Q3EJG:\^,09;J;C#ee^7[R#\O)e
&#U7F0(ZA4-#]eg#SH^(7.BF,M2WK3N#7(QRF/ED>fY@Z4:>C#+)OHF=@eTQ_LZ2
P26NH78:Sa-_2-?1Nga(DDJeddI>O5OPV>RQ4/Y0H@>;VO^M1WDd<_/4,V-^+(91
:JcA3<)Yde@B[a,)AH<WFg>0TaZ6f,GNg(3O,^O0\R46I@CaeU.:E-gR]4,gLW3S
+B+QEVgN/UTUAACZ>:^<]W9CC(9P(dLFN,5g.4;BV4WW?[N@MN+g254[0#3aK<W)
_HaPc7Vff?JC//BgaG6;IF-D34-7T#aTX3)IE8T-Z/7cDL:,2-/1OfZef?._D:#4
=5]OA8a]4;M\\#\1e(bHPCb2_gQ2G1+7QbC?e,YRf^0D4HRLe5NZZNG-F7F>_S.3
A,b-HRFIWb,SQDg(H6AZ-N=ET@<_@DS&:P&\3dM+^Y^ZI/<2X[F_RfR[8,:fc=5S
&b<7/UfL,)B<KH.CBMISL<(9(WYK+)#Z>WBKG&RL^OK?R:Xa)\QXB:La<V7=B&_&
IS^XH-X?eIY)aV/&,_(1EM>d7dfO_8F@,bEA/D\N63+ZeUZ:EER_;T]L5(9WI]FA
3QSI&-TES=)TYXA/QXb(1^^/OTKVR1#+))J73XRRRY<\4N.>fTH]>cd33]KM<.H,
NWa7X3=He(=?9cdb9A7XXL=6R_KT2JMBI?Jd6b]13GgQB]<cbY/1>NPE6BOV9?46
40R<>]8?E/2TKa\@&Xg3DIT:B^M5?NFZ&B-;UO0PJZUB?4),=B1.,SG2.<Y[IND\
(AI9]e.OI)-f<C@Gb>6UcWa44&I8)YZLg57>f>Y;LDX.>8\U8A^/.PKIdG^N;021
&0SUAA\062bM+9E]8X[8b?.5Ig4).MMa8O>,#2.Pb:6fCQB8e:U\AB.c/X+-&EIK
1c-G5C9:X/\a;-M8A?ISTbEg(481&B2b]L5AGVYKSJ8/D^KBV/#/COcS&#.XYFGL
>85bCVH>#\OGIA0eCJ+N7F)d>1SH1#(G6;cH;7U:Z:^We-I3KS<O-3F\--5CCa>G
P)CP@&7A:BHdJf4#W&,CB0UL;>\-LCLG.FJ53D=c9^d4S#;,ABOP_KEI2P/@M7H0
D6+R4X#aQ:WfdD<V,[M+@:2&7cAD8-H>B^KFO3Q8^L;4CcbfHCUa^EA=^A4-K1O)
?#Xd-:AWMa.g-fg^Q_=:-9F#AYDfA^>g1e,1Rgc#6RYL>d<Z6]J<_[73TER6B?91
[.]9>SZL565Re/f&5Q3PT7WA4R/@QDPQ4F/a6>F\ET0B#TS7Ng>=OALfXMY.b-JT
WY@5DTD]LLHAVE&=:/[?EO@f2=FFBLf=?;YL<JLE(dDe84QcQ:IcVI+S6#VC+W+8
ZCD[F;^>dJRN9EH;[A^06/beE96dBJ3XJQ:MXV/bcOHQ)&gIPg+UT#1\M3RTW5<(
PN?.4O^J2g&IG&cUEQ6gR\C/3TJ)NAV_/A6L7JGd=?EBNV-JW-1,32EdPIVNE#19
WO[0<1&@DaU/CLQX7NR)G\76?Y1#dD=#G62OGH9>Yba:05TPHH,9P^8,A4V;dX&3
<69UAU@V&;#7,9e@Q-O^68-<Q(@A\HZC1JNBa3f_Le[deGM1/XH2,8Q/)_1f3c-d
&68&T4_,0UT0(7+XVWS:/E]_2O-NP4@Na2ZUH=7S04C:=^)_\e^U7;(\(;S40Z)K
.IRJN\4ON7<R+d>JMQV;R>5Z5PNZ,G/a]:6PIN@21HH>,PQXXA;UL/=,8fEWI,]U
ba>+.Y6.^9PU\bT[^^gYIY\e3aWM7?+]^=EVe.=5dEcRGFBN4Md:06;@2XH+<&VZ
+[8)N<XSOQ\1GU&7,A,.[TRJW#013[V9/=KK]67@.Ib6R=3bK87DgEHH7:3)FdbF
ONWK/QL8,SR,WG]673>ZUUQM\,8QVG_/;04VcWPYL-5+J;=,-<^C6YWK?:34<S2U
NE?C]/Ca>IRT372/=RC5BJTO_/@UU]+.<@?RG.C^Gd6BC\,5V7.fN(2S2f8L[cJL
ee(>2]+8IP>+Qf6.af]eVE6@FXK(P9JKX7d]NPI[8(FGUY>H,]@OGWWW/V>3N+&Q
HAQgKMIQ02bOYC)&cc^L:VRBTb(g)f?,MU.?g&NS(NQMX,2a11@W9a&78))>SOXY
fXWP:N836b7H0V.-W7fgaO8WHT_T<AZX^009fb/WdO8f]b\2(Q493IYLMDSISBd&
X<#cAY(H;^g;VaVN4&^:_RAb??VZfV(AKD2d#@QdUaCOa2LZ8C@.UL358DWd#6HH
Z9=FTQNa>7U0NPc>5Ja[TOAOI(5^#PB1&MdT8#XA:/aY^V:/@MfY#:Z8HBP.IJcQ
cHBT3If+GA>b&ZTBd_;6MTX^M7EA2QGY\CL,\50YDV6_Q-N9UMBb&?=ICV3P^U<=
QI#O2/833\3I8+KV>CU8QZ;B8a0Oda26H6-;g_C\^F;K0:W:3-(a:Kb-5?;?3-4^
AcHDS[:>U\+EDUUSeWQJd5+gP2F;T#R=9]P.,b/XeWS9?^NR(G6dd\XYE3&>d_eU
A@M\f/P:XMVH-OZcYW_<IK0=QdUZ:=27F3^YJ:Y)?YG,@5Z/CNRc1R-Z-.=Ag)_=
..3IHX+9Z@,DV1N7O[c[:??1P<92a=F/Qb4U16d;I>\R85_Y].PdAb[]J::a9&gM
3<SY:^SYFe)=-73XB0;#@BXX\f<39]+[EO:K/##HX[c<@(/O?/4Rb_D;0)Y5\JC[
J:/-7/:(190\U9Eef)\7ZeI;M)D3#&)ff.Bf@ZaL@<+.^8:>fUe_))TV[.U-YE>A
(RSE>cWG^J0EV;Y#eR#93#CY1/XM&PE+Kb^U1&I:e:/,/,O8U7LC\OA>QD0W1UY\
(=HaQ\MYG.<3C@<1<7/0FGLUSOMMbR#30)<W1\L9Q4<BYF>JE(:c/T8-R:(LdDC.
_FX,E4_YR<RH-SCD2=@NZK6SQaN>QTcA]f42Y/9P]T(._:>UBUWC,A7&9M8/WZ46
BFB@TO?ZcMYgCdS<8_U+.;CI2JYF4I#NKK2N#eC,S52fB&MR-]&>3]<3RUf0g)=a
,2,?5NgQA\FaJF&B1N,[edN-L&fEMF5Tg3B5@+W4SP3_gX#Z==_3B@[&1MSb.-V&
UIDN_a&:T,2b>9Z<09Q&dPA?@#b\)X9L)gA-_O,Hb)?909U/<-(CZ>e4X9#=?#S(
4/@e^+4/Q^2Q?;T>#Tf;V,_43RC@Eff#ZX>(ZW85S^<PN<-H:[DWd(LA0H;fF9/d
+I/]5<d4H;GR6<g84G6KV@G=>P3R0c?1CNA9X3SZZ9IMYLOc^JFLc72g4\5S5FS3
^(d^>b[egQK7M6L45AJS59&Y@S6g+OIa/eTXGFV;bc.[COeI,gW<f3F^P(5_S=8\
T87./@1-7C1)C/D3:.6\Hf#e]_\^->Qa\f=LJ=RceX&dCF.&8dg,W+be=&AVQ]TR
A+3IH:GJdgaX/-7Y(9=FQ9WQPbbYXO_1L)X6HaE>gXH4@B_N?GG\BM=5ef3g,([?
^-572-VK[V#<=bHX;\(>4\Z)6:&T?4PW/V],1L7GFHDL3e6e2NW,fCDSGb.>LZKB
&VY_A_E;]^>X5SH]?K;OeQU_X-a#Z9/Y]/#^[Gf79VLVWgM#91#(.++\1Nc1.]9)
d82@<R)74><dTJZf&@&e7[#ZX6:O?[DH&^NWEGc<@O.O;U@F2I:-XEI<M[)B(J(E
OBIS/@cL/R/I76Y0^(6+AQ\4e:JT]:bccURV&@\.7DN/-BPUZ+-?JA0(c0gOXLGb
BHG?3_d\=<.bR,.D#\=g(NSS+HCfPfD<0fScb)5=>-+<Y&GWE/DfXJUN,<>CL^RK
96[N)>U57P1\BWfSTV7JNH8e2N1N\L,WS6+2]5?]bFRX@LWC[W@>^fEK@f9=)-gX
C@+[e_\C0]QG#OBLH)Ha9Jc[bF9efRVZW5E\c]-I;>UU\J[Q3UJ:a#;LIT]H6[J=
XIZ?Q#JE7[ZLIES\WQ4#Z8W##V[K;9[<\D;FE[N2Vf&R/,I596:,U+>eZg/W.<>Y
/9Mf0)&cb,,+aF(=Q&f^YE/a(9CG4J]-WWH8:&&.G.b?8__e>P<,XO,#9GR/aH\b
:3>(ZTVg&Z][6bB+50;[J4H,@5OJKSaAdSTLI(1.f(<I)bePc?3SS]&Aa@4KW]52
[2/G/D741&Jdf#2b[[T[0g=Q^H\gIf]RII947:EW6V9EdM.,A#.OLV]DeBG;#?94
L)\)B@:J]CT5cAEF=?^(]\MB?PRb(6Kc[&0\JAEZM,VM^^AeDDPgf9>a^M7\E/ZR
dGb]VbVaKR@/,&_SFcZZ5?VgB,@Z;D,Hb2F/9J\2S+Cg@:P_=2]dY9K^.P2O3>45
5</S#^&XD/XHAW-NN881613=?Z):X/,]>5G[((HZE7g+BO>P]&CXdR>FYUHbQ=[Z
K@7Cd-Nd8._M#ZDN:C=++IJXNO&?f&J06\c@@/20.WIH19D\HgLX@S[cX4V50I/D
&-4D37+PLdaH5c)fF8XA2gMRca&3/,IMOPVOKY8Z5UVORC1W^P=NE-998>KF\TMa
273fdYENDMV:g-R_C/>LBeHB^@C0F.F?)<XcL16<=YWJ,+fcEe=Q)B-AI57?M)T,
T2aU9AU[RbZ-#bGKU7bN_cY/-;D4Ugg[9FF+Y/Y(b+QY\XJ0^5AL90/:BgWHT4&6
2WI1_gT()b_5==VU\T;HT<]NSKMeDG51SS2SZDd]c/c]5RTb42e[@]24aT[BSPJW
1cXWMV+>X448^b4Ndg,E1D6;;;K4QD^MF:8D9X,O6SS=e(F353D@-2F:(0E92GF]
(P/+G;<Kb_9I#&dfOLH]6B5_g)G]FLRV]7d4Y;YF,CDF^_cJJ-^:L]OX9@JQFNV.
=Sde71?#S#&K;\==9bOPK(1aVSd?(NM&4;M<:1)@Z_2+G<1H?L>VEIW5.1ZA9E2F
@\gT[RdNf;gE&AK0LecC\Qd84BULH^6,T-84LU,#\QEQ&.0HTWd\?(>-U:,;a?,<
V,<1\QaM\P^<RH8HOB8A#YI65.e8[GSSL/D(,_#;ZY4&dRQLMDde1>eAD7]CLT?7
Z__EO.343:ZC-g+W]QOV?MC6D4BI314f\X9(@UDVA2HIC_,#Y,-VW_A6EdS[]\FH
&FF&1[UUY^@.a,Te3;V,-)3a4I59XdR-FV7M3UH]DK4O_F.?I(M<R0/c+HBO9g4H
gADfG\=Z^@\@:U]M5BB&CCK@0W:^&BX9WII]N9OM@_OCd>RBJ:LO?ALRM:28eJW=
K/d<0D4)4-53Z3K\?FOPXR:W?^0GLNbd_25_11[89RfRa9--(-+[@V^O26<QA.5b
bSB0;LSEIK.G1b[PUE[VIUgd_b0Z+5I4GH-X_1Z/6&@TCa[1\6afZ^NN\7OJfCMT
]/9PW9Ka\CU+&])(@W,,89[Z\_I^T&IgP=<)_GF.N8PPGAbQQ,K)c?b9=6:SV;eR
f]G-WLWZU#8&b5:QVA((AA=e9SOaZ4Oc=#JXUK.T8-NX3L6Z#X[CY:B2C70#D9A.
W]+(:EB;Vf6dO7NWWcZV.+C@6?gdgA3/>V=HIQ?aVHQ[fJ0UT81LU-f^7]bN6J_2
G\K5((>;JeRPD1\]1c&fN5R5#W(3ab8XO+^ET-bO2T-&P80V8N:@\(K<+K)1C</4
FI[U+fb/\IQeP4g)EERQ#c:2f#6cg/CZIP;EaeN/QH96dA+=.WZC1-;KC,F84G[F
OL>?R9E(R;:(bN)I02gOdBMCQ+UVdR12TDd9M.W[e(A-]IUXDSTKK8CC.2<T;KV6
T4V5b0adY@/FQ,2I<_K(0Y)W6/VQ_E>A8NZ>WRREa-&GKF&6f)RJ[BaW19aEM,ga
MJXISWg>Z>9V.K(:)f@(d2Tb8cQ@V-9CBRJPF[M<f[Ob;B:3JIV(1K1E;R.#Aa0M
&6TB]X1_4XN0?(VJ9,R,c6H7PdGH_e206.Q+RCB:(4:O#VF/T5OOOgEALX;..@S,
BOO>^gOS+Ba)E_.AM#]FL&Z7CaQ.D[&)),IgPV7eI,)cGYfS]UR/cUQWE7QV,)TX
FFE9PGY#.,-\L6E1K[@OQ_^BNX^,\eU)J]\187CLT&.4K,gc<ca?b^5Jc=0JBG+C
8=GcQJ:WLYa;+??2Vfd\eUGU7B.5^H^E_bTS7SR?N4K^dCH(2UI\9Z1eYPWD/?Cd
;6TURd.#90R3L>E#+dEZC3V.Ve3(B<BR=K0BU1OSI#V1ORW)W;/)G<XIf[8[f=O^
cQ227BW(M4DYgfH1#QS?P/ZbXZBT&2cO9bMF\(K<e&8aGOJ.JQ>H/_f6.7,gOaC<
^=BUC7[e6b[UB8\24J.6(Bd[e^1FEgYI\HQ<O2<]-=EIMJUAFVI0-R2<,Y1>#I(T
6H-.+4aeaHYSLJ@,EOXY\<9]-:Rg7dEUC&7)>RFD1+YQP]SgR5+gJ^E9e6-ZU6<,
=gWEODDc;Y1#Y3>;7]XY,U-9ZU:;NN[4JZdE0aXe.64U25+D9,[/3IK=7.&:/Y<J
8-f)]Z5b>V0PRd]RK<>J0cUB2e:Feg:LDAf0O#-3<e,>L8)b15gS-HY#?Y.D95Z3
D39_HVGH-bO2;>5^a53d1+Sg,=Y5<,@cfQGQAI^C-bD=BV]V2a_G.YM(,Y_^5-VP
/<dcEOHQ@T;[M@d0^Z_5KO&&Q^)D#IeaC6<X;KSWNRH1[MgR(\>?TZE&6f_+E13c
@eRMF#>c,F2U+V4Qg<#P(4.Ug@]T7Pb531fg.&Ib@cc^>1E6_JO((MGALI-9U;JE
Id4##4]Z\c6O3G-&gPdXC=KC/0V+5<aM.>_3Of):f/>8MTG>FSQW2KXE_f6da4c.
@&.L\3G>V]:P:VSC1EZ+4^9B,BR<PO>&?NH6[;OO:(H<NUACa/?7HIfF^D@_2R<_
L=STc473.ce)?OEa?[SK&9EV&>3BMP_69_g8_4PTH9E/Q?;=6fR\>bU^M9K,G\cN
8KA:^Ab3KOFF72))@;S[C#AS7K6(0^0>XO]5X[aD,7L6G(RT=R+1>Wb6)?.PNP^H
ORfa61#]E=g4<BMFPc>)H&KaS)Rf7fN+J3N6;>L^--5H&.Dc(Z0MZMUHUCZOECSI
H#ETg25S11<>A=3X^T-93AaPETgOW_&c][>W^R?A,P2NHOfQ&0Y2fbH85Fc6M2Id
T9aXX,(W;+cT7O91MISHXa?X><9MeSCCI9Rg24KZTN&gERC4E/PZ[NHXNP_,_/]E
R,&dW)CNB#-73;Gb+.LcSe/#VCO=GMUH35JDQS-:N<9(XQ@PMTW,1cWg@0I]+)P<
/^3+Y74+Y=Z6_:KOJ,YI4FIfP>68e@8R<ETH2dDQX+=Hf)4H;1V(+(4Td376QAM?
^b6g.>8==/9/f<J4-QV6#W-_ZE@,V6f,-H=K(,JEN:1G,P<9:DKJ6QX(RY?-DE4J
G\RAVCQTVYR=T.3?>M2PP4;:MG0]B0Y#/Y0>2+_F,\?g^U6dBfLCcW0J.=dU8VH-
3/5\@PZ7#RPP@[[:caWOeb8E<D,SN.NBRfV^?c-/E+\LJTLBe/T4C1@5GLC_[4Fe
6e[J5ZHH\O,2C-#6-/2/XJ;=.(Q@G^AX>JHY[J,Mb?63K@I(<5e>\9Ma=LU,9)(4
?U>XQ@P^gFM3:,Fg@.JC[/WH[C1K4a/&5+0&DSMZPM9H3dT_1BYA;a>K8G91.:C&
L2C6N<2LNAWC>AKJ.X6K==D4gMb8;#dM3gGZ(F<_K/);+K/-cfPCQfd=S8+DE=,A
#&1:(>52-@097TOeV5F3fL3RF+=R_4W<SJG>B)9A;:eW8B7QPU;:,SMCe)+@R-OS
+R=)9CLd5RaY&cJTH>IT;c+/M/-[D=Q2:4B?,,e#>R:<\OK2,,M\Qe+fb0OH&#:6
d_/KU8=MXU.5aBE4f&_DV^M7K:V+]f4=U;g/53,67G;AGG[O>56YRRL8QS(7^ES^
_a0,+P=_K/:>0D:^^=^9)&8-0dbB^H#92A+5A9SUTd60-],A_0cF-d,YdJ]N3/^9
UOb#?_GZO:L3BeV^]e)9V2E9Pf5GLc^2+Da?F3R4S#>+(>MD8JO9=KaI[(b>+a=8
MCA:(1TS:(@d)_G11>V=1>7.0Nf=0=0BHH+,YW;Z;0UIT.QY>_)WHeO?EZJfN8#=
<J@<VHY7.5f1QYOMW;YII<NX]fQ&>L_R)HAea+Vg[L1XRaGf=bYR0a7TGI[4,5I^
F;:FEAM^X7@A,JCdI/PRH?YBEZU<4e:=>UeV,E.07c-cZ-H-CCJZ4Q+c=1RFW19M
bIEe(DHG<\fGEV1;OJ9?>da/LI[X8(&KI-6OK&ZXg^Hc47JWR^dF:\<HJGR_QV<f
A;Mc_]C\\;?Rgb,P[0LSS/g8e]+8-+9)K9BN^YHc=0#QEN(OaH3f1eAg=@==4S7c
&R6Y-^e1(gTQ1;\IYM)KV<.I).5/(@&eP[X#7b#g^\g)>e4Gg9^,:]@g2b316;Q<
NHY_@<<GRaDUDX5<:.LR<<A=?K\WB1?eQ,HNCU#B,YRV5B&La8@+QUg=.Q3:XH;O
+@F4gLDNH1FB1Z_AgW:)T-.>\0Zb9E#[M<OQSVFX\?:]2d.I3OWe4\=>I_8cR^(I
:+Oge>?fbV,7=\8)&V;;#?5d=#VXBB2RG0)37<ZP(AJR8/B@+)d032W_F,bc9d/;
\((^HE]7^Za?a^W&L(dXZS\B;0JUSUg(O8\=@XcQ0Xc5WbYXcNCLVX;+_g07a_f<
JL_7\IKbPGP5M<2CZ,.WGb6A=JKBMCcGDE1\SQCdSe3)Yf0#,)bL7E[[OFfB/&4M
gA[:EITT14L,R=TYZERQXF1HWaA<fYFSQ@BA#@E,C?db8WBfZXG2.B(Q\HNgT#(O
H/:eDFMcUVHSfIaIUFW7RU^edG8cU(@A\8STCOKLJe&FBLg+(:df(SM^d-E:OfZ.
_N=?OR,>.P]8UB:]4_9Cd8B;OaDYPHBEbHV5ZJCQ:f4H@O5Z/A&[G,WbNWF5,Nc)
<5:fX[aJ_?ZN^?G+O9MO#XQ6FG.KM4?Y=^J8B;N:&F_]II=:9-e.(Ve>NdSI-<A^
]g<LI,:^H#H5IGI252C,:&=fY?,\fBf+N8/@^[Q;(VO<UGe#BY(6SSD)=.HNZER^
B?Z?V2W#NU-6^V\=D@NP[gb#VeOS5Y1)UQT=K7WXE<,3Z3<0#/[L/cb&VYG-AFg_
P1A&NZ]XZ.\7Fb_\C3fd^#=5_YLJ?(\AM&XLeQ7I/Q^>T@PVgb?FbaV3<?Bcdf0+
Y(L&P\V/<gMgd(5.]LQ#N#A-\K4/P@#A+KY^=L319N1;V):3P#gOJW?_A;VN=NIN
?7K)NPWA5FW@,]E8_7RbY&Q.^PO?5C@-3JI8S2N1<_=Ab,>D=[:56;RVAE#cW[KJ
>cIB)=R@>fXFXJU:T7H5Y.G@,.eX//GEQLPfVX:c7BL0d&ST;].4M3/-.).aM70L
1:B)DU+5Z)/ZSg26-N;](\>T1K_^\0G&;]g:GL7]f>L[H1a,_ERGNC96>4)OK&:L
H-W;d<bF-dcgH]3AfdD@Y@G+8)H8L_Y;(-?#P6_\G61?&7AX8ODV[BQKbUG3_C9D
/T?TDVU<@?JB.Q49.==6][S(degP9b[\RaM?I3;#CS>=VTBMEKD=,XD]B02:QS=_
gc09&.:N1QDW=^I3dF;/+L6BM4)A3,4YaJ\MI-gTXPeYW7PV^OQ3>BHfZ6=AF4e]
P>(Q;;]RcLKR27ETV\B4EUag)f<TS965e2O]]O=YRO(Ng/D94dOXCKM+;L<C3&Rb
ND8O:G3fNc85MAc<MBDa,J^3FJE-02Eb>[_8Pa,0B74S@Z5DB-\^Hf&:4L[+4W\3
O>\FO.Yc5^c=,?Da43Z<;9U4L)9>O;1N61R[MaZI#/HEL[5)+9_3_YOYIS4FTKFU
IADBa)=;:J8]AH:8C]eIF-C;91L>c6FZW]/:KL9RT>W4-NJ3]4R.]4ZD3/A>M5V4
0X81BNaL>N&PYLWUMPRJ[Q3\0L0)OO8--O:6?EN=#8E@<?@]JY15F/H:?DZG[Q&7
;B?TOQZ;+\9/3:G-Q49QUQQ&aT[K8N3&MSR+Fg=EWH#BQf339;102G&ZC^&bPI-U
MRcB&5XVI97;Y)U^b\SZ4EN?X_+JE19Od.9RZ;g6..\+BfdL6GWbBFS3[ac;==1M
7S:\X69F>Vfe=U(-C+II3Q+9(.5fVcOW8G[PE;]<e_WL/2&[W<#2Z>V3BX]OYE2X
Reg/EC5\=N/K8W_HTBgdEW)7[eX6O1MUA70c<QEE.[#A8)@5EgN+\7BEFYeG.e</
\FOZGad<Y;_b>:)BT&JM5R+_cZ^gc]V)Peg3;\eV-27Q1+Y5()/(??31>7<[aX5>
ZK:/DVL0R=f;L:U7YJ=8)P;2S91-73;BG.VfYY\9_W=V(/F>,8?(gI)+245>6<X\
]+51SWFgN.]8[YaXUeL@Q>R^R5)PS9W.Y;SX51/3UZ+&EaZ/HW=f7U)+I$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_W25Q_AC_CONFIGURATION_SV
