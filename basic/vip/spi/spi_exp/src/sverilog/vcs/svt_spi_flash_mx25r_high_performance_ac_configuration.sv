
`ifndef GUARD_SVT_SPI_FLASH_MX25R_HIGH_PERFORMANCE_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MX25R_HIGH_PERFORMANCE_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Macronix MX25R device family in High Performance mode.
 */
class svt_spi_flash_mx25r_high_performance_ac_configuration extends svt_configuration;

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
  `svt_vmm_data_new(svt_spi_flash_mx25r_high_performance_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_mx25r_high_performance_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mx25r_high_performance_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mx25r_high_performance_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_mx25r_high_performance_ac_configuration.
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
  `vmm_typename(svt_spi_flash_mx25r_high_performance_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mx25r_high_performance_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
J8,:)QJ9DP81H_D;LNDJE.bJ(B5Z2Xb8\YT.T@^.Id@[5aJ;AD9P1)fFVfKaZGQ[
V4<VXT_HRI1C4[XBA5]#aTGeN8adLN1JW4FD\1K\5^d5VQC&FW<[Q^NKLI2M9VLA
ZU&@E1dNN47@LZTO[V)S^)W6c,-&(:CJ)/K.YPN^FOF2<BFQ6cFBOC,@Rd1b<0>4
^F_=6734VWeG4:^H[IIN,e;<FeOH_&[2792BC[^SC>QR2&.<REIYS4d:2>c3b-WT
f5D5R.SRPb+e@3<Y;\]D(#EcM+&;&++@31UR9b&Eec2HOe5-W(2a.H2fB5I:d>/U
&BQ,I&DL<R?#[3=1YRfI29G59Ze>1G7?-W?>TPUUZY6Dc+:2R\e;IZ07\d?P)\H.
(>B_M2]NUb09(UW6-P&QKPM-R[<R@M5?-?#(7.))d@3VY=?c>f+EDMQ#V6];LS#\
0g]E9?-@&SJJf+\[eUQY(4F>g9,Gae8C63[B,L:)JIWV0fX2NN->&,+2?ENaG[cE
:N>>\C;R<D9<eBL6@,>(@a85CB/]K4?(1b-BCE26)(EH(,LQae+-Q30S8(BV_X[L
NgWSOCH019SZ>XVgV8[&^S2FcJ&&Q#\:ZL-O]1dG47f@;Hg13V^/c3Y1U#.1+#aX
&fQQJPVeQ(LS::LcI/.?GJK9O;9&@^[[FX9Y9cJ;L4<^fb2WHGN@EcD#_3XGZPWQ
e8a1OLK>U2[O_HE@<2WY4)eIg(UbVOM(A>HOY9Q&;K\]XF5BNOa#b1]La)7c3@NQ
fIN@I6@WZVJY(M;7Y=G3]\T;E05+UK##EI.\)6=bDbLY/7Cc8eLT1)79LF81=,]&
f076[DLXeZH0<1M&R9CA9]gO7d2)J,[09$
`endprotected


//vcs_vip_protect
`protected
P-?>A#?]7[fMU/bC25^CQ.3P1-VX>/AUJL?9^D^bR8-S9@;JOZLD3(Y2P0e).K+4
\C,(GV]DC8,1MAba37bAFOW8Z<);ED\]f1L2^5BZ,C4OQJ\^Q6NGM8cVI>T#0?Z<
;#-Z:J>_Z(GIJVX.@CN>UbG0K(T,9G2=Y/KBGAf25GSOULVY:D]\&T.8U+7,0BJR
:T@X@?/Cb3fFGGG9\M.D+,(P\(J/4_N^(8=45V5e=1e>d=AM#7g:eL[47(KXPX8?
C3PSG0+)\72KTgZ^(]Sc5J@4/ZJ/I729EHW?,.)=gBM]_D3&S=#P[@PU.PG-C5Gg
d(DE+O/L^R;;2(bL#E,fO/FZN\aNHN_YCILa\a>bYQJJ.N>==7dQb_I4gP+)\-)e
cgCY750#79cH8+eaX/KUZDUc,f,CT-W6+K14OUR60)(JcXKQYI\_H#IVE:6Z-==-
.g4Q8Z02?K7c1,1;9dd1IH-S0c9fE[WfF4@2YGNPIIMEC?@KTGJ#R?M5F#[VXP7a
J7?JIZ.[)T,bVP0dfD&eZd=9=g+1U]8IY1=+2B^/<VM@J69S<71eF\N4XaK>/P=g
TP(=Na^JNJ5Ge/g)X+:8@fJM7GLXRH=6.#PD3D-=11>KJY-=_H6D]Z4-c6b:T(a6
@+,0]dS;NSbJ3b9O(b_O]-2;>&TCa8^2&Z^C1+J58]J#\4J+DgJ(@#^M3_\)#aBF
TZ:K7DEQ\5<W7VD5N0I<^\&TC0YDJO\g_b.gAd,NLC0d[\6c__T.HS#1E:O;P:UE
DbKUcPY9AJaO3,\GV3<(=;->3d&g@AcTQKT.gM\W>OYb;+gJg,P9)]OHR]=A:CeG
-,I\XU4Z0>OGY3SR=.O?#3=N#\QVbK73#>3QH@UI2fNI,-@PHF>I3E+eMVIR:I7H
O=8Xc::_fW4E8:D<D1)HFD?_Acb91UEJ<]b;NA=&&c)=_gf64(=J3:JBSMCQ&^3E
J2M^E2>JML]K;dNPHQ,2Te\[IS3+>,PWO76X<_+.O]aL>T3#(+]@-eZKNA,R8Qg0
)5?#UP]Ye&MGGF)ZGM_[E4eNB>]J0@^<YeEQd(;\EP=+[S]@_VXS=KY&W7XIQXaI
],,63.?cd/12@Q@]_@ZWE8RU33K05VBV?GRcgeJ6T(7/2;RPI;(7LF5_PB^LNHA>
b6Ga]G/H;:Z6S,Tc(<(cGE]NURdX<]Fa3X<=MLASWTBa_eV<b3/,DVBEQ0(+[dJT
+9X:.^(_#_Q,L..>ONJ)34#4DYb7N4/6=C5gcAaNeY6S.4Og4#([52KR0(J2EBfL
eTMag55bDcZT<GJ8/,[TBS1S#OM8)+AA>.\//:ARD7_6H[H^S/H>eceTBZWb6&f\
@U<X:NGP[P@F\cDZABd0UV:]dYfOG8)M][I)XL;L9@ZaCCEeW?#GH\K&W<WIfQ))
c>H5GGZb12=C;BADYA&1Bg7T5GP5_OWN-ac<>L\.A.c4,;TEH]#Dgb180cHX4;Aa
N:L>F?58]dWf\5\Lc?ZEffcM6Nccc]E];6&Ef6g[2\dF(]/U>+@20OVGg?P@:f);
FLMQJ^2Sd,>dQ2,1YH<c:cF0D7,=5(GHX45)JN7HSZ-1IFYZDJN&^@H/M)0-f(Ha
A098Te9+1U=8<8M8S\dEO.+e<8a);_J=EVUafLIGWcXJHY;[GZ.Cac3RM+e-8bIa
R[ZC?19<X,NcIY@+T;WX<0eKEPS0GVK&ec--a3^<PEW&>Nf\I[+b?72XLcD.K/^I
WE5e8RBK[AG^;+KS&=87_7UN1X)4e;QH6b(-TP)1RBPM.=JI,PBSf28-.R_M=^CH
bbI.0/+Q<4QSM.GIPUCDXXf5W\D_#dOOK8N#E[9C/1ZS]:=)OI.>M,=HYFFO8MLW
?SP43d5eJ#PYXe@WD=&ZXe7_YRLI)aJ;2I:]g&N75HKM,N5YcR4BdN(NgP-S8+FT
YeA;-N115_]:2d]eZT>,2FYO6@fe+d+fbA><YdW[?J9:N)3g&?VUHR:9S4G/[694
V\TLOaK<f0df_+g7a,Uc#6G;CbIc78>7M=1]KMP,gVb_\)5L=aaX:6Dg.G^O1>X<
JR@W)Z4#C71K:=BNY6cU^6S81RbW;(BIY8P(NSE[^gP#V1NX\J]O[BXf,,8+.2bg
7f)bU?Se+?SA72G7/d.d5-OD8H\)R-\(WYeW#JY^d6a7V2c5OG@cX+KcQTN6?b/;
0ccWPeQK4:]Hc)BO##VTRg)f5O=,TD>#e\QcbbFKFWAg9GggAA(b=GJC\<60ca:c
GPVR2IOB-4D7)<YA9EEU(?^KG.]c#=&/F?S@&1&Df;Z3EX(&YH-&B2WB<Y&8a\?^
eI3+Uc6c+Y+AR6g+C.??;UR:8?aeFd#:23#bQJY8NMJ7G?J2+<2??eBT18^IDcG^
8O8AUJc6/L^A0YE4T^6T=6_FU\fL=KNR.;0S_3.KO\RJ6Z1&8ECdU?D=0f,UEP3=
6ERB0W?9QJRaIVZ]gZEK/b+889JCZIS#E\DS+@M@FKR-aG:?IfJ#cNV@)/#LfH?]
K@??]2)J.Qd;]J(A#a#E];=U]_JQ+V#^U^3e1cS\eaQ)f_f4VaCI)]eUXQ9CARZ\
OW8WQ)^H(_>WZK3eL+/SD+PPU3Te?@U@0+f[EAHZc5L.2G^bU\6,-K4cJF?&HFNK
[A-?-Vc<Ba_Q-a:F;\L<E&6E8g(C8</3^?#;.2A+J6_EIM2;SXPAI)UJ7FeP50^F
+;=J??V2S?DJbB6@:R_([a[b5bJLR^N]5fWM5IW]ePVQAfF4EBKR1G0\G9fIYA#4
(^@Sd?C\g<fLIEb9XU+UD^4+JDIC]]6aMQBe_H>c3(10#DbYW[Ma<=gK=?dSa#?F
9)_S<Rc?6O+[<R_C?bBXaZ=I[MdSC=LYc7:fg,4.S4BH5CB6]C&(T0(S>aOF2\BR
RXCbA=T6:^C(NT&Z//P7AT<V1&4bKWBH,X@&<K@W18E[P9Q-DBKa&RLfbF:I<;OQ
d:G/O?15R)2cG(SFMe?<A&U;0g-6?]X5-40R/+M,5X_WJN2A-FDTebU(+U.RQY2,
9S@#ZOaWL1#M-B6EI4B&Z.M9a>?YfM2TT.6YTDC-Q(L\gF76a\>0+e1-6Jg3K_/7
A,C4EVVLD(:+?d_IM>.0-TQ9H^,Q[^>NV<.OHg:R.W3P0e.SGI)9Z:CB9Oe5dM1_
NLf4KaX[^_G7(8604D;f;O4Z:.8WC>NLd1=JQU+,&LI3_QfI__e.M?.Q;W[TY-D4
\V5JaEa\b67SNcTcD,,?bH.O(/>9XIP/.9L@SD7VTIc^U(YOfP&d1d)0?+;@cL6A
2Sbb<Y_5RP\]^4QS;HK.b#/LUJ.WY?LY-#[F<-WdS4?QZDXeM.<\:#a^_d3VHQ8I
L;O[(Q8M_#]W:]];\2=JTK^&+NUQd86.8G7X506>UA=-6Sb^@XbJ2dWD+QDD/[-.
+[V8)MKE+#C0E[1GcJ=IGLU&;:Z^,NBfE)#>(SVBOR.0/X0^]:g](A7OR\-]Ae9e
/ACH\?[/F5Hd<2Jd+69_H&@X6+#WYL^?2T[REP@cg87&.VR[SeM=fWA]>6JA^NEe
g\3eEaPKYHg2aMb47b=P-T:5-E1H)<f/ZPLZ@\@Qf5b,+?Zf\XbN0.V;.3?G\B?6
Jg^5TE-@OC:RaaN,O2;5O6_Ha5?LU@d:H(R_E9Wf+0>V+53XIZGRXJ9@+ZI>Geeg
.8Ng;BLF=<DZM3U_>(c=9MZ0aFE^0AU@+8g9\D0:+];L\X2O_7aEV9)\IPO-J5B>
[.B.9&Q-?G/eH=D<R3:<2dKZfFR.J9QWA/UUEVT+0KOLHT-@PJ7SGW6##g2ec0IH
)M&dBT6Y6Ha0J^<BW021Tb2?+FKY6\QMe@BcG\GYZUIa@H9UbV5KFDF(YK/fH<VE
7OU(A&gIS6J;TVK\U:R<#U5O0d5O+eDHYCB1d2-L+>,213^I&ecCK?WK_NbA?]EY
-1Z\Jg2D1;#aZ+4?(M30/8ge-:MVaf#)>&7I&68L2>SMS1&eX@I@IO&YdM);//g&
g;VP:I78-DO5]\/8T?MX@W^76bJ449g4R<G3)H#?Y1B]HN;R#aR.NMa5-YJe)87Z
V02)YY&d?4EJW=19R?aH<ADQ/=3OL,F2f@L,3RCC03\::\Z6UM[)?<QBS=F9c<]F
9T[)Xf@@)b_6F<)fLJGI8)T(OYTc<,@]3GHE\,EVP(^aC4#g?KL=3.>e6?ETD(3:
1^XIT.FG([&]&K#FDOF05B/95H28+2Rf+W?.2a33[IVZ=4>YJd-AW)5OMI0XYK+b
CT:\YR+O/^=D)HOa.KX[dH3?e:JWBBCCPSa)K<YZOO1O^)da@,G[db:M[:,[3.NR
-4cT1LMB8V,_?,O4Be(9:BA([D9d\:;<Y^8VFa)?CR?JTF(>3L?aR/25;:L,VHHK
-C.]YGX=d:53.1RgB>JgZU/-?EZ<]aQ_S.9J[RQ+6D=C?&2R\NUD73R;bgCR>/e;
8[QF:C:QgU9,=35QPOU(:/+8ag.A9Y:U0EX;FX@=KW5[7NH62SJI,VT5-[W@:aFY
\JSE=+e24?)^G_.C=RDKf,/2fJY=dX(5:SPW.^Je_INb\K_;N<]dg5=K79#D[,>@
1PV<//ZNX@aSd):&L)^d+\(]DNXY]AMb?[JP6SK#KaRNCF]Q]_@)TK.?HPbY?E;\
8dLMEO[54)I30NQJbOG7F>eZfVf&UU[_O7Mae<O/W1IedP4.^f#7\-CeUD61OK>H
e3384=1\UBB.Z3#1G/VS#ZVK9+IK@XIa+PB^ORY0)a&VXP(6ERNI3C,1<QB2-0H_
LUM2XQ[+0/O-N_^O?]MY\V)Z>f99S40SCe(,\fGI\Y-TD-Ba(^Q1_@<@,W#XW91c
cfKFd(2RMI]3G1B];_MUCQ0Wg5.-\@8I+?,TYD-aPJNB^3EE6fPP_.8fD8d(7gX?
9#IOG.6cZcZRFMb?N.2YSX<&&7[d\5b7KYP?X]:H19.c#(+LKCD6bOeI.4K3<5Ge
05ZLZgT?W561[K-a@b=2^Z-eFOSO,BY08J]5M<dbLZ6.JT->+I<?0-Q#WVNHQ<ZD
P9HM&0^eWY-J2NAG0&TX:IJaSW#^Z@G<Ad[E+5EE)BO,A)2O4L\JM:?(Uc5Gc_b]
]QQIT>Cd\K4D43_UR#c+^YA[D28@gMYYd?ENW73J7OE(7@LFd([(4bCWG6@4C+d\
&K/E76d)9&b\eAL\9WVI?0O3MIS2VPMZ6(@GO58#N62TAM@4AB01#=^P8dRKge_I
L],aC>F#;b2^WR)LEYgN7fgd,/a&)Z-[\IGD.G\0M7)77B?U@_&S(:\1RQ#g[QPR
@W^CLD]M@LcY3IgW[4b@GZIX:X=SM/GAIb;[8YHBL#86M/6V:I&K-e&-0/F29aMM
K-<V.e?N&/SbWN)/XE>/,\),R+4D&c:@15N67Y(CMSRGNU2-Y9Xd-OVV_BOJBNNA
WWg-1X(_MWSbLd=KYXI?OP/e2#0EGa6N2L8S>\J3,F;KP7E&)M=IV9UWc+]\5H;<
XRF-)IP[._dCJ?DE_g@)--Q=R6U-:Z0:Q.e()7@\EZe-Y8JVF[B8gVQXK6cfNeH.
/eT7C09Sf+(KcC\3O9=.DC&1KWA#K.A7\4CX\eO8[Wg]U+]Mfg=9U(C>GC:76>#4
Xf76K0Y_V(Y_,c(T_W@>[RR1(PR>CeZ+EIV/Z\[(I#HT2^]301DPG61b\OagK(;_
A)J#:VMROJg?-483)/\6IQ^OYR4B1B3TNU=\=WK:dIgb@9+7)-.LD2RT16(AH7>+
_-LR^L7eVU&:N+8Vg=\6,V>1.59VJd?4E\J,ARZ-D#]-9K5H+^ZWE=9gC(D<gcQ^
)b)D,dQ#WJJI6WF0b@D<W2fcCALNBM/+3#/F>PD\5MH;.ScbFM5?>/]>G5^8WVL5
OHQ6PIQbGZG]@aI[ZT3FUDF:TB3FC_XNI@0d1c5MT_3QA\dg[OTF;<YK<^&OV\V:
UIIV]8/[=Ma[2L34FN&K2;5GT:Hg7c:<WfK@RCNXafRKZY^V\DP]Mb(:1&bdZD>\
VfPRNO3U<S;_4fV=455\WU_>@Q1TfW9<cgPg^ET#dN#>.<CV^=76#RdegH9;8ZMD
OPRM2<F/(]#0.X[3@.fT;._C3S;DgRA8-R@V)SR+@f\LK10M/ASdMU7ZHMX?E+IU
cS\-?bA48CaNTA-_=LX&)-E@U1c8eR#4P>dRQ.6#PX4J6JVOM.aVCA^U>\CA5I)>
^F(Z0X4OKY0(BJ_^B<+T/#^H&<bD1<#9Q\X)FfJEfDFW#f[QUK^]2)(9:OLRMRV\
cE-LcE[<OMXV(3dfLWSbS\&7C=URD=EeDIPX7_7(^\BIT6+dg@H6d04<XIV5NJBO
_&-NVHZUTOC=LE0DB3M6VL+ea2#IDc\9S\_I?50Z8)+4O71SC^a:LZ+JHA7@@T38
X+E0SC,LBIKUHJ>-dbG82_HR>d6X3[&=?I#9=U<N14X0Q\dX<_=S67NR?6+63\\E
9GX;BD/P,DSLEE<0a-dF,F.=WK8:HVD:=5LAaIfZ(/5/CDY0bX(cZbT#8d(-11J@
[5d9GC(O<d5QY^7BXF&O(=dL;GaF@.3573.W(+7I[1U:N\aCD\^A4+,<&BV9EB2;
3b-)\F0]H)V0)<^E)0FBA;4W;^1.FI,E7]IPT_5J]NGUD37d@Z+:6N3MZ;7#D,UB
5XND?6C3DH_(_T0&PPJc.G2P=>=D-GYYHg\QPWF37=16d)E8W^N9S2YFNDC+Ya.H
3c;P]S&LRM_&_/\+/)C61Z#R@f&HN:-cPN_Ke:(A[U,Q@N+-5:JUVb,29B+fH,_e
M6(__OBdc4BK@b@W@KWZ@4R>BGC]BQW+A#(U;]aM1Df.#?_MFM<V;N0C;fMgcKc-
b-9d)NP:0+;/G3Va88LX#3G(VbPNOSKK&0:I3<g[b>P^C@&[&cWZ<WQ6;1[Me:NP
;#F^INDd872@g9-GY^KbMUZ:JG3g2Q2[K_??Z[;OTO]O0D&T0R;dSOHdOQDBe\T/
2EY3>b0=&2f315T@Y>fdfH5L[-3NY7JR3FMAaSA6&]L=&\Gg,RF:T6Ce1d^1X59(
R(W+_c\f.GUL-<M5eOIQ.aSa72D#d#I=YJfSCZ&Y4fbOUd(Y[A+(PNX#DL1W3QS4
RMcT@O5)O_Ff\=aCAG?)Z[:8b9#<g9+f08E-/]?G89-MgR:NEA)6UMHE6OS,,C(S
.B-,JbSa(#FQe[A+3ZBc9O]M:P)5Ee>Tc;BZA5P,I2-[3GK4@9;B1?BGY\2>X]<Q
Mb8>NBL(FO(C<XSNPcPc<IOEV9/aV/N8c10N4K:^;/4aB<+L<SW>=[K:QRFK;4R@
EeMZN3Nbc)1?SZ3>9+6<HAWL^d.=9<?(;7:;f?DA[<+b+c-e+UJdL;,D(dTfGH=@
X6fC##KRT;?QG4S0\d)PAK=fOfDZNUQAO0WBQOT?Y:/ab;.=.G=1E1_bX3<N)NTD
Sa2J>(HTd:^L+]OYZc,A0EJbF)E&_EN?WVQVDY6>7]W=XZb\Y:C?/(4I1V>-O>&H
.Z-9afUB]BYPS=CR0;.dJV+G.]>55a>=efgNY;/.f0UVU#URE[KH3_+5.A,E9;,:
Fba3^FST-C9FH=OPJX1;-D;OS]5C[[+W0KW;5U9fD6EK^53-f4@ZS:#g9L4E9>;#
;:@JXgWSc)f@KIRA@+T(:VA8(\QbU=@(/>D8UE?UU#>XgF>7,QcYTMfAK2=^L#/M
4IG+_aCN0,#/<A&VdV]30Q=>_6>MMTKFXa59PH<f)VNa:eedM6OM^L3@c7)FbfS4
5dX^gd(&.,R;3WV0+D8HL@-bUTB:?e,bf1f+eV@,V8U4)cDRGM),EdZa#5f-@Y<?
O\;B5VDT1+I)8[7TZ044g9^KNeD8Ca2-<K/N8PaDP&Ma4=edL0J@?b&ZIWF^QVS9
CQH.EJ2@UUceeD>F\@JX+^RHVB?(fQ=F[?=V\ZgV-BEN);76(FT5\eH-_9\E)#E5
X/?R+6G#T7IQ32K)ZYcP<Pg_\KgG-J@N.0/WS;P5FTgT=e=ccQ7VFUD26fJM7I0/
1A#dc94[0?BQ.]OQU+PP[PQP,_M2Y60N+?(Ac7:@YF&dP+]^Ad@C]2\@S2d6/,N\
UCeb,6SS:Hcf#cUbW4QGVVJ6b:SHQ30Bg6,V7I25(.(O5A?\;1\:[a:cTNb<_,=:
1>c2W,YV>>fEBYHW\YYY=NVVRD;BI2TNV?YI14,R:VLZ+_E6:fRaGeF-?7T_Ta/#
=+&;(35&I@JcfMG#MSQ&A@?GTS;(\E^W/XEO2_c:2_YU2=c&)0SFOLSPfNM=8R8I
#1K-&>(U>E8.>7>/2)2_[_6614HA99WR,aL<W,aUU<M.6L9?Wa//]L^L(JY.+.HR
-Y/&]bP51B&[[5<S]KJf952\&KTJc^H,+WE&R7RFf#44DB02@,4bW=YULb<#-HKd
E2LCCV4XHKC)9NF<Ja/ILILY0e,.[OMDUg>]76O@8(?_b7XT3bGFF@3Ja,d+)^T@
PP^D6/e]311Hd@G]8XAE3R]<]98XXddeU/=6g3UV+0Occ2Z>9(?Ic]9I>G?Hf28&
U05UGBPSQQaYQ5BeW>d??F?]L1^4FN2?56B=><^e&I7[R@9]31Y-LS+:SF,EY9T>
[:G#5T;Z:2N<][DT0__X35c/eWZdBCW#WB4FdE5FL=P(Vc(1B&\MPB(Df^f34aF(
,1SCW,6>^^[Z+>&\Tg,f\aV<)HE0/:14#TLebNGb#g[A19c+RAJV8&AU<3HWe38U
SRW75bLVB+aFg?-a/0R^(F#Pc-Y2e:.,\=\#>F<cIX\8g7g0QX=([B-@2CT@X75)
W]BU>Q9@Lc)^15R\_M8\Y/LcPGAaaH+NYG/ALggJ[R/BACVB(Na-/X)0E2LY>BOE
P(S=_[^GUgQ5ZN7STRX@]5Ka\)WO8^AR-53dJGB>_RUOTcUX8]DV@),;OQ4@<[ea
b2ZA#F#859W@6c>0[a6)P=HOX;COXg@_U\f+aOMfeaFPgD;<0RQeOc#6TRgRRGe0
-8.&_-F[Z9JD&/5a42[8[A\EE@G^E8,9:A_Rf_;(dZ_@fN:=]e4ELS5)aIP5^35C
,0RQ)LW7ZQ8:A1XEE6#MSMG/faH818TZ01[,Hd12U92+F8S#RAXV\L_GcDMa?gL=
,D)MCFEN;fePO6+32eG,9MUD:U#:E4O00](#SYN_N_B.T?VQLJ-HCA]Ve07:V(P<
+WST3<9fGHEO9(;F8d]<[#OY^79gC45B+?RbKWb;@X3Z4Gf#A&>IR.3@d_R&8LF9
>;UV&?L?J7H4B0/fec+J&g@1SE=WCC6YLUf98aV1V)e^^#db\/8K41g6f1FC&CV_
0?(N029Me5.N;WUULE)I+4OE0>H=-Te;Cggg2g8HL2<I,D9H&ZYB^0\=@[H7_eMD
>J4?O8-C&4S>=;_>TY&4-g6dg(S1QEJ7Z=<4\_eB#aTCZN=25;S9XR\K\J,e02P(
U)>I1RC;aFKa]Q5&g-IQA3eeZ7T8ALb)OT>c,D2_:IaCg)_B+V0&g?aG^H_G5)I+
eJ923@RS6d.0[4>XN2a(^[VS>.>#9V5GaU53JVPM4Y+E3F-B]97Sc^I(^K7PXJ(e
gLfcUD:/1_-IgWe;>J^36C\_<?VEW&-COTW^W1<.N#]1Q)QJRE/PS2/0@K.W7[=K
dQ<.A\f?[Y.VB))/M3DE&[/\1.;9aX9BeWFG66=C3#9#4_:>#Sb&G:;([9OLVIG+
HPOf+[XU4_bRK7E,ggZaPfa^O4,E?AVIX:_Xa+:(gZC2=&./]TYBeA?fL]8/6AK@
0G9dK@dZ#;/b&Cba1Mf.Y=SJ?@WL/=ZWB9_6]TdOEWb.GS6ZW2#:P5@e::A@1DOg
NHHR::^<^QJ=J-\Rc9F4<b5720.Q0X<MeH_;=C-.&Eg:NENAPa;cOPcEI.<6\NP2
39<9<&SVA[>Q^bbKeRXc/SSUOKC9Qb7]\C@446DNGZ?C2IUEBVT5<1I6:;RSZYeN
[7(?&(EO2AQ<0HH?41:+bG]de@LIWZd2;-WgZMKWW)6f)W9^c&3WTQS&gH(:O/A#
&I2^XXP[X+WKP=(TRfc(D)ceZBV?#KT#B#.cOf;-5@U,LM\5;B-#5IQX0.E-&,X.
:;@TLS/ABNd&/D<gCM3PPY43F^A43R&DN\1S-b4fQ<963HQKM1E1L<>></P?CVA=
)f:J&D?D:V7HE_aN#:4KTFcDP)E+URX>4T<?g@cAO>W&Y7@8F7IK-<@2eIBd>Bb0
JC#12F^II6?O.TFd:#S8gACS3STN/+=UUIeDZBRX9J,ZKH:BUVadJ#I5DW](5E:X
3^S38[Pe<g&9Ig_QB)]4V/#@F,b)-3EK@MPJC^5fBdZ^b=;gU^ZFHCV<e3)(TGd7
a29<dDXDcZ)_FfA7P]SX,H;R^S&UE,?I>dDLJD=CZ62;Sbf7d-1863^C,LB4c,\T
S;W-aN/1SeXVEfKb2ca_C-#2LTREC/CQ18,)7f3H\VQ4[Jc,N(0Qa@L]+9d,<Q9S
P3_UPY9dL/)V#2e#Fa;0EI3BB^I<b)MK/D.14,f=O/8)?P=5J-0?RCSAWCETE7IO
ge2[];.+7OgHT_ag_UQ;T\P_A01U-/V@-WMg13P#/J,_MTZH>B]_,+RW/ceg0KKQ
d7&<bMA5#\1AHZHO)/(8_E_8WU1&<NZ7J0UWcb6>>C[I]EA1&/c9F<7J2U+)Q:1V
6EL-:d:DYb0O>e0N^P6]C4]QFYVFWeSb\TBN>[RK^F4Uf8UWYH1OdFQK4<O47[?Q
M^749^5J;M98N>P1T\TOP.TPTK2SSD_=cU2\-2)gQK4W//)23D,IVH4ZcCQ3OB]J
AGg..@7>XJSHIgZGE)@,XA;dOH=7D(5gGSP>L/]2N>H/IQ3J2DUF(6JG>(J;Wdf^
5bIZZNS\0M8XQ\?G^#9]Ng^5IBKaeTA\#:S?U[<,Y(#:DO[-VU4L6c<_08L,J:Ma
WDf[-8#A58/3P<&g=TeXPL33W9=)LPN:K[7;bA^?KaY[d>JU)4LGK0#DGP2J?)Qe
3<4.cR^E9>88E/T1c<EE6>E(0N@&RA/6ZO2CS)/;[-]M1LbOFbOILU3P=FH/Q<C@
)0K0.?6Y=T8RPIO5I]EZS&1[d^IAgfXYRRDc;>A0LV\?O-&N4(IDWW7dQO^X(@9:
J9F=(aeRcE4[Z4K=Y>WdP,dC]X-A8<-3_YcDOL@?R8B;+0>OMN&&?LXAa=38N;G7
gKKCAPT;f2O;[IcWH_39[V2cT)b/-TcK0cU&\;JI(VKcHP0.NUcTg-\U57_PFbU)
#;eM+NW>_4ae^(2+[54)\7:f8@cOIfcRVD[gL@#M>>ZGaY(V7K-Mad96e7T1e0F+
MbH&\\=RLQ9_[=ZG3aQdC^7FC(0?;CaFab0LQ:e./,C&]A3[=W99]_^=QaA8Ne0U
@d&2],#,+Q&&_ZgX,G?R./QBZZg>MFQ.@=e1[O_M897JNJeIe^da_AE8Q6]6ND=+
D<8NP(Kbc]?Q0\Ra@7C[CbJ@3T/:_S]6\b=eWK)0OFIW:J5L/^-(M#GU8bc^?G0C
TK@\O5.DNC#02=P=_VEdKbM)I7)(XQ4>Z<?@-++C^9eJ9[E\U&+4(7WW:Q;FR=ZV
VR?5URb0_5aHaW)?-S?0DMO4SZ4(@R+,MNNDY/>^eXe@ULS?JFe:IcZNc5K^+-7)
Y#^O.G:[LKZ#/6O6R&?/AN?PYXWTC1>QJ2)=W8Y/7IWL2_g0L(ZA7gL-999[R53#
&_OVY2#Y<=FIBYbQ&f;;L)A=2UPbT-,+0PKa:g.#-P_EW\^L[f#JJG8PSfS9FB0F
MB/[668g/<7:H=I]I\0K,3YDPf_\bO3b8-NPU,6[fe&2XY_Og.9>QVE[CTJH)<Z4
S0+c<9=YX>B=7<[M9?T<59SbNg\Vf3=4,bd:/#>O_IT&71_Q3@3K0]9^YaJM,O1J
&J5D,YQ2PS(#R2W;&Ya,1/\#&RE/,Y8]+B#fKN6;DS.cfER]dVT;4H[,3Z.CBA8/
aY3J7S)7_,+Y/OAdeB[g^gYZTdG,VSZ6XJ<5.Lab+cE[Yf]IATT,8XR,@<cZ,8A/
dQ1K:LGZ\3]?.N(Yd4,dI2J7IWY60R9aOY1>:)]5E6QcW,-8G?VCANb;ADM3bX5_
B2&)C(dCR^UIMf<b]#A<\N>H=g&fY;;#XM>#8?GLdH5e7R,+[4APe:gL_0gU^_?N
&^0+a5,HFAEF^Y=cKAXMOW\>ENI/Q42O#AL(NLTNcfS<LZcSI1>6&d\eT,:9D_G=
Jee0\?:@Xe-Sb8;I8]<C(RD+0@QRN,ZHZQOIZILEWIYHYaDL62LI0@Xe4RL]Q1;-
&8MSLIb-c(XAY+If&>gWXHS\(5E7?PQUDR]E3gW9a#TP0X<0XGeV@#\JQ>MWX1F\
dAE8e1.=CM]M@#A)U,;,Nd>1Nc5K8)+;SJGJ9g:,6@8IO&DQ\X0YU59AK;?eD]-1
U\8K:C)\Y+CcY4,KJadaAaIa()GbCbK1FJ+-GbD:M/&JK11UWe&RDIb?5Z[Z^N@>
gB-MJFgIT4[>(d59,aM8;g(1_5Y@0J/WJeg+?U00Ig-Ug(-S57_<c)0NVKe)Yb_c
aE+WI6EX1SLg6eTM^e;E5#I/IO[RaD4563H27)M_ASdG(]+..#b.=?ag&e1XI+T.
K@:Y:/DC9-aW,M#B<67L&a_R?(>^1L+;B8ZB/V6)Ag7bBH2g6B17,E1ELc[ceV[N
DK++eF86bg75XBaN\Z3_U0TD:40KB9EdafaPB4J_W>fDC08Sa##\HI44/-eY?_>J
\#Of@V<NefMF&fYD[a<2Z4XGM=X,0NTA-Lb8[W-7N64a6N07O_&<c>V1V&((1VNb
EU:KU;P9WJe:0g&@@)N]X0gf>CT@97?W^-XbIEaW0+)OP>0^]9\E(][;CX7Od4^?
d]M<^3+BF_4ccDdc3Y,G4MKQ?9,>E<W]&>>-],@?gCT]#841/gAR1[E81IF;/+&9
b0ET\?IY&A7_X,#[b<AL5\^6.;6&0NDF:R0QbgFge/.bYJ=;N3bbYQ>d#QWWdO3^
N?#D3_8d7]6FJ9QVY/aVYMS_XJHWTH6b?+5ILZ#BSWHIZYFK^+G9B(V:\G7=B0WQ
7^Ue<d_UgK(V]:Y\8g.3B;/@XU[WT:.^L<:5,,K_7Re=;9.E@;1b3QaC<D1c#If1
RGTCRYVA9=J8SBMf/Q(KVS0K\]84fbH;08&-&b9ZMeFS]RD#dfK^c59f:V:03JDX
e?VV-U]Q@/>KA]CUQa:5)eS5?>X(c&-94O3Q9;([=K9c#XD3+&Wd)-4YeQ<4#6(P
cZ/(L.7U=/W=\1?:D,0G(;Q^#-6b7;].BB6d77,1f3<d4fC-?fQGO/GC;OD&D))J
3EDe43DM=4Q4aV__&CQa/b(]\2H3e:K/#fT8;@.ID3&Ffg6,[Y#+WDLY1Xe=gL+D
G.2f\W2C-)]?V=JC?BCXM&DR6E><&;5S3U9LJ]G_>-c^\AI]^eMER8eb^RM17#9,
g]6W0WYd[Ybc<geQdc/(,=[U_KCaF4)]FL[M=S?O<1-(+3IUEHfBSV.R/<b5431C
8Q[Y6Hf),4V;_RU+K1>UXLJM^g4KK@(a(R.BVZfc1ORFT\IF(,^R.;3MG,-/T>T1
>fK0KYB<5[WC&C#,X+8+7F8?3f_dSTZ_GI;M8Y]VXg_HaQ,T.(9;PG:bcQ^>ZZaN
X\e]TYB74G[_>=S[KE=?-2AY0/5a4CG]8508\&MDef4OM_/ePR?MLCHK((HUZU]<
.4+e@I2K@^(L:I(b_;AH.D9B.01eWgeZ_GE)<=K;:2H+S+;V5[S>.c#cVcRH0?+c
Z-:F1gZ)2[dA6^;IW0E>7Wab?;=35\YZ<E^]g)IE.#XLRN&b-bAbS-MIC2(3&L^A
MaG7&P@)8c&ON+(]a<(8e7PPH;>dXg,\<Q).0EEJ^5aWY0cY.-2Q+9cJY7FN8PYF
QT-]C#/^ZgORf]T9Fda#ZKY\)<O2f&O.@TfJ+X?X43gZ&a?(BW9_@FNEd)c[>WG[
g/XW685.Q6aGFad+<eVK8=/+_BPBf;FC=E3J,BJZ+c@BTV-RU#6E/?Y@46AEe]->
U)?2C#4>f5J6_TF01P@\9QaX&G=Sc]WS0MATE8b,Ja./I+c/<1,0@(+^5.0PX4R]
Zc625G2HN;V47eTgd0aQK=;,dccX9CE7f8f+?Q/9]43LfJ0>BF78;#Bb]IV[YgI<
74N<EE]LD8V>;?0<cRF8V=S2^Q]AV=BB38,7;/K?;ETVM^aU9Nf1ZcUXT#OaMW+T
_T[]][;B0gH&4).C+dT-84Z^e&7b7b.;.5gB8Z6V)JeC.fR;-5,IOA/aERYCHSPR
GWJ(GeBbL;_-&e&QJ4C4502g3-2R]XBY6>DB^&GO,G3,-GDG,,NNRL92E>TVD@ZC
>>\A=0=F?JS_44/^L3VTJZ()NP,(#?RK[KZ[,7ge1L_2)R\&TS7\S?:Rd?:5ED?S
e;)-L1Of91JeMaf>I[JKA9\gg[FJI14R_DYD4_,1/bSVR2U)&WU]3>O@PBHT3<IX
[)_IL(3:N@&RO-0XQ.(a4[?URE?[.Nfg)FM.=Y3GOYD6XR.N)J3ffLKTM];.YVB+
M-84.<<QTAA9VH6#BPgfI#TG,f@&,gG/-CS[bXJG>5&>#,8ZC\3Xa6e>#1).>:-g
>L+-NH7_R.TK>1?NH]=#MR.N=2&@()V74.H\_Ab)4EWc.JcF)V;15YY@T&82B<g?
X_bdS.8.TIK\=+H&PNa-g#R&7^WbRG=5-LI42=[4RQ:613SF@bJ]Bc<D1C\GKd]1
]JQA)PaC4W_1[C2A=>RE]RK,^(fOH)QL:E=g0_+DN-8eQ&ZdZ3egb<G.a>\[2gVD
)NU&DA(JG)MR)-cJIGQ>FO^;O:-TX]=6H_N.X]KU(QcaMF>a#O1-Fc6ZQ;CG.=N2
K^I<Fa/]V53DI\>.-#.HYA.T]/RRHg2A,TP[RD9#L,7/T16:<TQ1NV]73ED>PR4U
Y#-#Nc#.)P^_40PRLF(L4b2>PVga>McIHFLOe2MSF\L<bP>-M=IH[c-7JS-+S4Z0
4V]b_;2[:#GJIZ^3KdTDWH]7CW.)77:5W]5+(BeK/[LN[<-F@./D^I1J8b<&()(6
R-M^YE&I6VT>0WT)1O5]4fa2fWDb4&5P3A5gUgV97S_Va]<:8)8Yd7J/f?JKG+#_
^M^;-.&7-P5RF+Z(-0QPXLbX6-gQ(><a[59WVJa2_RbX]E&TDDP4)S5I1M]87MaE
E4^JLH,#d6Cd_)6aa?PBQaU7FB.\&bU\Z;#<@8^<O6^A9_?D&U/6M<L^(1R,7A.(
<CD\<8G+3KMDM4RA?6-1c7]GO9FL4?XSE,fM-C>\W)7KdR<<E2?R1e]fBGOV4)FW
d/R475\1UNN/\6<b6-?1]AOB)Y5JMV(6_4/dKE#=#FFeQLRfBKUH,]2e7NK?YW(b
?C[XJU/<OS)VNW_39F18W?;?BKg\a]&]?Q\RB?b(XVI:7WC>(MF3@[aHDKD84F]X
(fK#,I]+E\S/b,4<K(O[YO:[671+;(4Ob2D[XJS=_IH[UH9GSQLa1cNT+0B+--0:
PXOKQc/Cce?E/R@9JWg2PT>NS1HZ(F<,3Z0+P^4@_=RNU;EIcAZ:gO5_#R4@.SaJ
2@BR4FF,bBMU39ET^C&-R(_fSd_,7<2]=A-MB/A=g\Q:a3NBZ38S:cG=4W=D&N)6
]f)>B+H2RR3XgLOUJ6<-BeCcddH^3[.\92BOE9WRXYW<ddaZ4&AP#W9Q6X[=C_MR
)H&9-.4a@4;J4H933Q.CDS[YLeT^0RI[_AU2#K.MEdH9:&SJ.57,C,\-bGE;LURI
eS_&-NGASQ6Xd1+O5U<MM\7U=R^KB.e+9_ILYe-RA<SCLBe=bfT[f4)HX6^Q-c51
C5N?KbFOCN.)FS;9[#I4)Id@W\2R)]F1U0J]2/U+H-E7L[@f@Qa,7W\9-<HQ[7U/
QM:=0cGV&&-(XN7/,KgQ1\;Q\3,.=(fQL0B<4EYY;Ob[#[EHfYE;KdMM0C]MbXaP
([;3>YVUK41PA?b+TLgA,:.,P^JV<?77GF_eTB;Z;:REBUd+V>aTI8#G+3Y)#fQ8
RAIO87IQ>4J8b;8S,ca32RQ32W3C.:U(2/Pf]XJ[U:5d_,XId+B&/M3#882FS;[c
S=[\Q8NBP3P::?,0a,2_9-N>E:#.e<(f8(CGKLY7g.&XG/10Rc<,BYUa3e#D)@YA
_b.F7PQVdQNH@N_3,gLA1?721349+Wa[bd4KBE?c1bW]J)gA.;D;>GE#bFVVg9,7
5.&32>PN(TF_LCUA._IYM]9569M@fb=?#@F:)cWG^E-aXBEU:a=JOI#@P(#V1-IM
gAee3OZUd//KI,CS?MCHL^M\U&XFEE94ZYa)JTXZRT\=b&>FaUFJ.>^-9JLC+UQ2
].CMf_?TcG1R6P8N>aUL2.NM3U2QK7SB(?1(:.Z(7[f^B\eON1)6b(cFVE.T&O/]
C>+TaXT+cO09DU.XTTMLDTS8F];YUa7aKdL@CEcNS_bJ#1#5PGeT6V0F7Q,H;fNJ
[ZXG3].\89-2.W<=EB&V3W3\T/,X?ZHPS?<LA[>FOMNKgIcdQV2b>NaEff/TXW9.
43I4a_3U/:5G.OI7[;FDVN;YL=.(W?DR@aWK+F5EX:J[)Z,2Kg-T44D-T=\Tf1(N
Q9_M>aZ)MEAH<XW./Y6cCHb>=gagd2,\J>87G=U8[2KHf8]SZS#HE_U3JOES43GS
EM?/a6J346dI/7L+\<=BO>>:(5?<9AYAd6a/d34c(T+3R(48^<([2;^^[CJ>_abS
4b5.L^47Y@13K5\C/U]:RX;@9.S.QCDDHRaWBO;,C><A\B,ESJ.gH#&#:2XBAN9V
A(1Jd-#eV_FXZT[=JOZ(d:]+JM2)GKO^A0E/DT]NL:9GZOOH6@&LT#L4cUa\#fE:
W=#a]MD;8Q#).K_:@Z;;4VJYRO62&=M98C185Z0C_(dDISC=O:C41FK=7E=K8bLR
CJ2fMPK;,^,@c7>18EQ(aT#8^2fdNGH[3#e@IJWT.A6^.gA+6H;-[Kc#(Q6)5<_D
FgI#M&UMP&>T;723g4&WWcO1#fA8VNK88#;^:b=_JGXY33Z0(79KLIVHEXNMPVbW
2>6)0eHaV7#P\ZSFPJ2GDPY\9G,;R5Q3C#e-I+[2;Q;P#9KKc<8R;\VTGMX^6<_4
B^>=Y[Y83/U9W]f9DBU?6bDfYTUAKOLKPbCG:METWg<V7=^.;@LLa#LYMEHWg91A
/BRPXb>0E)0A\\D\;XDNA9Q]>bLCWXbOKCAK](XcDGZFYf>&>7PPU8Rf4McO#C01
dRR1P^_fN3,;eZc_N-D;0=B]&]9-W9&T&AY(NTY[?,f@WfQM,_?]eE(/Leb>_(?K
.9R[g+cAge63EQ?Tbe3+5VN8A&B8F6#e-;Y#TL4?K5dNI>ZL7,RPYC4[FK1LVZHV
G.YH\IF,8\#5a\:2TPJT,:]O[\QHf3R6MZZ@G?bAP79DS4[_XbGa[=Y239[g^J-R
acNFf93K#G&f5COFMX#TR6P,cYWS[L&6KXNR-Z@;&bY94&;/@7I2[OB)-,#?,Q-A
R=A875MB1W&9-:/MC9D[08+Ha=N);416)PM.YJ1g-G6LS0]9(Fb4CN+?L(\,.5Va
3/bEB;N.ODWV3d_53SSN:3,ge,[)R-bYVL=+\]W]081eM<0Y?gXY;._:D>1/,?CS
B^Mc#3Y@/_YKULW5YA5)f)LZY9gEc>GO0g^\P?AI_5.^e=QC8K]E8F##QZ0=:HgB
^-AfGRT-/),)209X+O?f#?HQ]-@E<^V#U4&;W]UX(77<gE4b/87_;L7+PR-eUO8e
SC<G?Q,F=N1G7#>.)d@;088(=NY.\\<E,c)f-,\6C3C_85@75H-fG)87V(NQcJI=
CCH6(>GS=879EM,[7G7C\0]J7;WY#Z-G#3ebIPaACb:8,da0M:XCI#\E<0QS?#+)
2YcB.>EO)>8Z<E(Y7?2B&ROV:d^G&6b3W:e7b6;C;8Q:MZ)1(IQ?.VdAMHa8AACM
,gSIS-cMM(ZRSS@M:YADBH3&MCNA;M3XD>\I94Q/:5J:U@]23N_]b>VM&O=(NLLL
XeRBQZYOS2PS8_2eN5AAQBDLN#I]N>JH4H4OJ\;;^K7.@GeKeI)PH3GO^M374a?>
NH9\=AdK,L+I8b^#Y1fB?RUF)XeP+Wa\LYM4V3WO,M6OdbMM/C3)N,\1HS0D7X>H
8bF?58X_AL:38,DFL293VfA5d>Z+M>)E(#,.5]_DY8OBK6=4-bMU:FWFQ/R9W^8U
LN^-YgMNY+1O3X0.)^XKc>?:gW5(:ISF0\Y6[8F^C2?]ALB=@YA/RfGgc+OB<A?^
LUV_:4T_2:P&aN82=\^01.cQ-EZKB:V0CaI^0OJ^S[P-U/b((4<JAZf;7(Y]&S4d
,+1U9(Y^2J&&K+HR1d_0JbcJ5QdRIDHC03SZ8Ba3I4QdHS8Id3=)3e,/DT<U\)2Y
MA@0,6X=4/UX69-YS8,HHe&,3GD:<07B\3^CA8GGCIQ/L:ec8@][EF-B/YH_X/[;
aUMM?XBT^X8\eL6U@+ITCS[A/1@,6<CP-IQ.&6gQW@BcO,GL#JRHFe]Dg5@[P7J^
24^Jc(e@UKOCV&=a,;B03/&4A5^8e3Tc+V09S9F2@]K?PEO2<<fQ>5I@TH^\K/CD
9Q;08dc+3LPEdDAZB;bJL^f(DE]JOgBX]Y=F/CK/[:BZBC9a.#g;:7BFK-VV/:)W
(<0X,;BA1YE.e105>5^S(PU-[aOb?^f]N+Udf<aD;Y:/g,-:J3d;T9N->@/2MKVT
<^f[K[N8)OW,Sa01VIQ.]F:8RA(^.Zf-:A-IcA[BLD1W6C@AbK[YJSV5L&LZZd34
eX;VK93cC7&HP.(TbPWEOX?Cg/>MbWgP>20T>J<T:Ded72G4dJ]RcU/e2e@L^g43
KQ_O=+EXHKS9@-Kb?^SQ^8HX>ce;_b/8GLF9SMHA]20X4U0A#[-=8O4gKC=aW8U6
JXR&X.+T2S89QD\P@6Ic9d:ZUDUWbRI8@)BQMfL(P7&:DM79DB2_XGRUUQ0F:gKL
0MQ8eP,;^&7-ER^\/5>]#I?>:BM-Z95=I^;I;(W]TM5\41W>^-cT;/1ZVUY_&B,N
T20Yf0Efc#/<227gZ4M[MJVc:E=/0G/MM7g?W5M\.U]<^(-BTVVAf^8_3FOc^]QN
Yb3Q-9O\9Ee.cY>]O=T=d5QW-B?JA>)7]GD&J<NK)bN22@:V.=T7=cI^MXHcX1&#
Gc:50(YJ.9H1aZ[7B_JEZfe2;H/;]QfMT617VBHL\T58P8\D2@>Z\M52dT8PQa0/
YGT1LP)fQV31aDSB[LS:ZD[\7BI]b&FU^0/CH6df6<YN5;SL/aCPJ&V[AHK;Ud\I
:<=K=NZ7A(W(]DP3G8XE5<f@KLO99,Y9-I=f#DO&7N784gCgOc:8IdE5(2gIO7Sb
V>1dR6Y(>TaTf&eH-QN\?;g+gc=@g16[@5Eg;eKN>Ff.GH3>=?H>g>-+B17_DFW]
Q9=;dg=XaBWS[P?\]>8FO6X4OUAa[b6b_Sf?HL:c;bSHB2N=722(-BSbWUdLa(7Y
AgedFSB8MD[=H2d8ZJH)L:==f&5,E9P6/M&&fLd#&,^Q2bC+(8fAZgLNg5U9g&I8
FUY6-#A>fQ88]=IbaOWB-=E&K5YZ.08\;)(3DUe+(MT[:.HF6OE^P/<7Z4^P;1A\
=-PL#?aSL8Z<S,SJ5TJESIJRR]>7LeCV<8fcQAd:Z@7/DRbdceEN-VT+P+,X-.A_
=<ZGNe1#T0JC5ffadH.[Oe/:1;@Zb[<?5.GdTdWGd8&/DI^a(@&M2\MbbGA2Zaa>
USZ9O1.ZH6S&b(-g)aDM\d>D>\]B+&:A+L(39+b&W[X74PCXMS&Rb?#C0U\<>_YU
>YZD4\?b>)WY:a5JfG/>/(J/1g.@f8QU^\1CI+fM=[P_AT#:B40MP63RJYEg7TA-
2CBH#(+M=W]XL_]1IT/=O:AUdbDN+JcIeEgGH2a,7(AZQ^^YAV/b3N-H2R8g-@I?
8?G7P],RfC<Bd^<5g<38K7fRK4(0f>J@-XVZ&MZ?3<FdNV8TM2[gE_YX0MaT91dB
9Z0#CgN--30gdST&6A6:K+?E6O,L8Q,_8)G<+8T=g(N2C4H(JGJPEIXQ1XadD7,H
\FLX>=C;)&HM6QcZPb<Yfg)8,DT&AXV]#7#&W<HJM?A-U5ZJ?f\RcRY&5-^IIA57
V5_Bc)]Z[T4JcT[5&)>:?C8a[Z45Qd-1aO/bPBWE/2[I?=4CGb&gg54ReI(AVVS5
4?GQTJ8<bQE(5J&b<I</64W6M(K)d.EE^W&965Y-<G2J=CLK)O9)W<0S<>Y#]e-#
YIQ+#0TV;)Q]45<Q(EFVFP:NW#RK6Q=20:2(AXE.05HR]9A2T)-DNfV5@V4c;7dg
VUE]-WDUQO2O@;164#dU4P_CZ03D&bDDRL7gPc2.8+AEA(<G)YX1G_.K0M.(_B&>
cIg,8G?Cf@?.+,2MJHDgc<(<BLgM.E;OADGeH>I^BTN\2TBISSVB0C7.(c^#;Q-G
],\)#)UMB]Bf1dW:SM0(]_6_ER;Q,b\a]=X<dWIC\_A)X64Tg;Ta74,/]OLNEEN6
-A<cEdJ-LEQHEY<DfK_]a>Q?&U>@;EAZ@_E;RZ,0BQ>;GQ=N+_a8@5d@Db,ZZB,Q
.+)Bf\B744Z]9D&]A?=Y,+O4>H@P^:\g+P1^Ig)DPN;RD>=5B[8<UXF6J042:YVD
N1PXcA:;]B?ESGZ_JQ:8AWZLB8J\ITZS5\,^H=3L]?Z#+AG#AICYJMV4E(2#>;,A
R4\WK2,]Z;U\40#B?g73I5>/4=81SY[ZY+:)_a#J3)3Z.GQUgg?];FS0;^aVHfL.
9L\bfSR3S\7>6M@Y[CNb#Ig.]ZN\4K_F(5@A#TaEJ7+QG?:g4WM#=)PH&N\4QRb1
4QMJ+@]GWNTI;DV11>B;NH=SNX>)7UIXW\[7+:CH+JX/KFW=K;LaQe1[TBdFM61)
+I<Y?JO=C2e^Q<LX(:?J=4=9^&0+I&6DX_WD)PQII5DV^gN:J_6S8UA7dN(XLNQY
UNeEa&Ze&F85F>?X=/eb6<AGE(/-3FdS?#g,_B;TQH9VN9=]f3>7MODL>1=6;R>O
AO#()9Gea2>T)W0O<QSB./G]gD8ZL0NEWROM@2ECD9UFe4>BbeB/=Ff3@H^L6KOE
)D);.Y(4[N;S6fa+>03S9S<4ZTHR&[WN-aDNZZE8EJS\).bU6[;^eY00fRC1)^\>
K.CJ-J,;D:S;\NWf=RfY4P2]b0Z>_?TJeK8]:U9=aWL_AV=-CJH\+[2P_I\S5E9T
T<3IWCIb/de,9aU6I\gOR\\AcNHf2NS,a4Y1GgA7[W@,)5=<Gc;R-#S\Wc2^N_8)
#ZQ+1#7+F04T6@XU>S9TE,aW5W8UGSDSL\#;bTE^g1(+.+0?c-AL)F<W8>Cd6<;H
13]V;-54CC0MgJP@,D=\E2H:X]W7CXR@A);I(5ZH@=R5[dWN+P4&6NO_3@3gN2N\
48&KH=1;+:O1cO;D0S=)fT@B5F2[&GJ0)R_:(=/;:^U?5TODV)4TI6/Ke@AHC)g&
5780O5B\]]?@F-Z@-dN10-S0fd#d[5T_WUK8,AcdgVVA9N(P[@-+HgWR;QQ[B^Y+
5f>GA)5_,F^OUV>0F@J\:XZg8\ab(I:NX1;4)Q9F[-OaO?[0J/>#;A8=6XcY@#)B
gI&a4JJ[1Z-TP0,M=c=LMa:CUb9VM+[H)T])QBc9<@[<W0f^g8:[Xf:Z.OS?C6WB
SE,KIHc,eW([50^FCMR(1RRMEdAP:@M)^P0f6<Ff,+TK7aLJ0HY3II?LH>V6,&]\
K4N(2,6JSU7)fY1A+7X3@]XM7^RSKMaV).6(cTFaYN7HDg2VI4ZJdD0_Q(ca/=E&
3.aE?3VLO4B9df7bFP@8^U:U41PLS4e1#,GB#4GfeVc/E8(9.cB-JPMYD</gAL9Y
cWLAb0?4#-<6bLB3@N&d\gC0\DJ::+C3#\RCK:Z59Rf3\H3U[M/KfP_IX\d]VL@O
.TF?K9&_;4:Sd>bE:DY(HAecb1T@<,Eeb_3b#]\X;ID0:3b(.)J8^4Q3UOC^5O7;
5WL5f;XSHeUe.2&.IV1<WZN.94L^bBU\8egbHU<#3+5@>&bcRY#=UAUe;D\R&6RZ
a&2g[UM[<BNPMCMFf,@0&6]7_eI2gEG3_K5QUf1?#\V7RHe9XWCL3DC#eXHd&;g\
M^;0L;+>]g8T4WUK/A64HIcaMSG,:P7+J@C;3M=YNRc\[@811E1]@XdDa/1E?_^W
_aF>;:-C,[<&UUE/EP5^,VJHa\dC7EA#J#EW\^Q52?Z@S\gOC[\2J:45&_bga-?U
b:3W?_34)<BVCQRY,<VU^W4FgA=.]Q\V^P8?g<NI\Pc=WBMZ&?:LA>bOE[2gUEG<
Q9RO.>2DDE&E)-C.1H\1b=eM8YW098?WGCW6X\:?W+9YUc6;2cG?M1^B:9MYM;Vc
9PcZLYT1S22cV>#c;d/LT5EIAP5,H8O#J3d8)1g44e:<LaPYT.V4-&NZ:@K_J[C6
F:<PgCa^bCaaA;92K:b[F@W-A5+(<c,HQdZK/:R/.-^3)a2>VQK,27:D]X9OIG+d
[3eFN0V?0^?2/<E^3_,Ff0a-U+I>A_Af5-#FV)fQe/]4GKDfaE/^Lf]1OK[1WL)@
g]_&V:8CH\,@/SEN,4F7AWFK):f9LfB@PP8II6)@4#NfCgF^Acd2XQ;QXcGe6ZDC
=g7L^#<5Q:@0YB_2;&8bOP^]Q7M234>S(La&cd:O\KP/Ba).I;gHeBbDNf./F)9e
7-4].08]#eB[_-eWPWOf_cX(.A+[c2eXeG_Y=T^65T)W:Q(FOE(CMaX.Ec5J-0(L
ZR.M4dB)X\L9QF4^6fJ^QH,&a=GCK/+[=+Q7b;N8;GcE1YOBH:,Q[NbJb;-N-YeE
]=(EPEC;2b+ZQOF4B<I(fWEGKG3DKS:B57JDWR>J)KI2YPAK[E9@TJN,;FSd2=#@
:ePBZFX>DC;RgB7Y[D<Kf+G-H.b]ZD#=G+<f:?J6Kd1#^W_V[<K5N6;5#T/E<FG:
I-cY-/aGfO]4@G+G^RE6f=,XSCZe/T9#&4\528+:?8.?8cRKSWS9&/P/HX[WM74]
D#=a.15B<>aa:?KbYG=_BON7YK/3f]E\K]\ENE&@NR,:@?[6MbX<D_M1RSX<?KIT
Q3fWf^@VDKVZ+F1&a;d1[Y8=+@CW/DNc3a?G+ZO3)<3&?&=2)SH64^Z]LK@MYf0c
.];2A^C>1Z0.IM:^:JQ],05SL[AJT\+7]a:46_-b:T&dCGO=X:L@QEZ]8\51@bHU
DId@_+=cL1-ZZ1ZHE?&H8;T>>IJ=4JTNK&?>f[gg]d5f+cHI)a(B,1X#3;[c41Y]
]CL3(\#WT\@e+\3_&G@3&[f_gU5W-dWd_[#dJF9c__Y0@[X9Q4OdN\YLONUA)d&P
1cf_-?JR(?G/I.bX><]>,g;d=_B5f^DKDX<-C)Vb>XJVR20X,R7a>/:WBII67.R=
#dVMHXZG,JaV._cR:U_\CV\MHU9Kg@\(dA(G^-)D#C5;<7E6bb(YD#4N_7B&E5(U
KfGC[K&62gZ+,LF-J,^g5e9d@(.<?DJ=YFRTA6<,\WZ)<d5T&#I90G8?)]dTeN,d
DR)WZ9L][C;G18NLQ>LSC/VNCGb2a3C3)2)799>[]]NdB\KU_D^<cS@Q2M/#I<;&
GE513ZT6:+8CS32)?7eL_;LO,R#[aPE1S>:O9=;@I1DAd+8U/F0+[[PE3P7@[46Q
f=W4JQ#cDFEc82IO\)_O37..fP;6;&S_U&V,IdLNR4E16+EP^7@IEDN?_]eFZPBf
(,Uf;E</Z-I=)A7>UQC+(:4TUZ7Y<@2K=QgWLHR8(,4OWgPY8T@TNZ3NP97C8-2#
c[I[6)XBSV^G3;D6FWI#(>-6)@A2.XU220J8=)D<\Q(e,^:0V]M.-/ZS5#EGM_^B
LBH^NH5?;U<\LZ26.>Ab.,6QAPZYC[)aF<#;I#01=YK/N_&N\&7DO07.OQGPL+3P
&?cF2WA,[]2X2E?a6K(Gd:W)/+<K,F:,e[\R3:(ZXA-EMg0cUHS440^EINA,+9A^
J3Q;I7.9>RWCK(;K.M1M-E9D_(.Bb/?Ka9cS#8f\L94[9;D:>JUQaXPMDaGN.8&J
BKZ214ZdW(9?[.WOQ9b0)6aSU7V0K,__]ATB)XW#SD+FGQbJ)<8e8c[3U1AbXG_=
3&3U(@OOZPU.C&g?U<48)V9^2X\:9BDIeRb76(XX>DYdTPgIF<B3gT[&F(cG8DEO
KI-c6aLgU^>R,Ad/#O?&R5gJ;SKMH1DTPC_QK])f?7dgG4^_V26?+_&P>K\Bc5NP
=PQeY,Cd:2+;^&Q.MQ+^gbQ._#)FB?&,:?T[8DVJP21,@X.LXeIG_EIN]cQLZ;;8
-g\.2.E);>T0H0&O74\Fd]Sd5^AX&<S.f1O[)7R)15GASEB>A:L\W58+NWZEfDL[
V<QO;B4/],<f6[Sc=a:SH]C26dHd.(>LKaD0XIC,\>45Z@SXBRCWcX,_gN38NgVO
2:5F-+NPR]@UU5A09f\H_IPW^g-ES0?SHEP>aCg^1OYG#>I0>@NWQNPX6,)[ccJf
>/\Ec[ZL>/9P@Ecd+3\WJQO@\.Xe@<X[WOag/fR;B=S8=@Y:g/94BF9[PJ(e]U=a
+Y9>#,XL)U@JN,WY=.EV,_Hc2_b@F<&L8-_,G)\1+d2XG>]_::@S+dAAg?R\#HP)
K)X>PeZSBUb;\RM4)4<+6@0da_YXC^1LMGB2Q@);VLL+TTVA&O4/4=SO).Q(fJQQ
VU7(gIc\,,V8P=<BZef:90H6+RR^N]H&7c&2FNHF_/182b=#^_U?VL0GBORfXE:Z
B:Z&_Q[<Y1E1YCOHdPB]65N:#XBT#EH\9:C:V=5WD;e.Mb-RcND^@CN8Ja?(:FNb
//&I4IE&.A-:F;2NeSF<d6#-(-bJH,[4W/NG9I;TV/>ca<-GJ^29ZHH>MG5YX9F3
:d8K8Z+98C.6\E3WKDWFYVG^&>VGZ#NGPOa9\&VS8[g3<NHU+9?OL08e4YNC8.&C
MA^V;;K3EN_MUfda#e-.)3X_4=/&B_9Y9+S[)MI,G^O4S])^9dd9U]fW20.5C2?<
J]WDcS=7Z^P.)N6CYH>Q)c+&GVO(+2?VWQ1,W:,U&TG-C#Vd:24F&?=D2cd_dI:H
/;)fP:QT[S\4Q(02BN)fPTM,c1A@ALaVTQ+6f3SF2_JgZe>7c6<):<d7@@>[Q#d\
E+<68-Qd(M()N<>QN&/(CZS_T=YYb9,I7O4feZHB4Oe-E9O8dH\^[4<;7=JP29CT
;>cOR8I7A_g2R=69@ZgV7U^^)Pg&;a;649]4<gS3SNQV:-gQ4WQQ9+^-+?<CQ6fQ
^V1)b<-/M\@bCA+Q>>,(da=<XLY[IEV,-c<F,g9,74R834?@W1^,RL1Q=M+#df]X
U;_<Y-.KH[_7X,K:ZU\,Q/RH+QA2E#;UF<<(U6LFL67F>gc>I<E1-./HJ4JbUR2>
GZMX/1XBO.;&\Q2CPTYc/b[N]QW2g)c&ZR?G<MRX@K0&DS;HIffR<E]ANL6[.d-3
Na2(^CCSZSE+Q-=PHg].BR2Z>W7A;R-6B\9#YM@^ZV7QJET/dNc<E^2M=a7&ZY:8
&)3P6>DIW02O7]FV]d5SYHQ\-Y&?(:1=8^DY&5Dc:@V^\U(Z@1UKU)X<TZg8]g^d
(7J(/E>^]838\+W(H@8.>fAe)Y++M;dIM.1>\C-06MS/F;(dH8#/M)^KP1=Q#bb4
dcC=94db,7Y>R3H_64c(U0f)UUUJ(>bMPR<JWa#>&S(<N]fK;Va9[&,H9C99J&GM
,>e0U-8?3>T?S>#3#8&M3Hd7IDHaO/Y8X&_e=H0&,^4RePbZ=S>5V=c.ePV;J--a
3bc?<TGS]bQA=LYO?,SabCH7,#?gI<,VXfD4=cgHIf90ge^7GOTdJ3):4+_:Zb#]
2aWYX68Y:0K(59Y4P\^UMb8->_L-QeT>)fJ<YZSH0MHDJQ7XE]_;e41I,-8Q\fg)
,)+U./ed+.?+&9RAQB<AL)ZPUE=HU0^5+CdOO5dS1Ia@+NPffd=<c67[_@Dc-.A?
8VWNBWP(c[TfTVD_M-Lc(_Ub-6&-GCDe=V>e@X4SK(bcM6AQ3J/c4JfNP-g4Qc1B
-D\95UQfK?4<CY\+L:[X\^Q@P#X+6<:U0ed=;+c/+Fb(J3eVIQTM<#J/&U3M0,DI
:.<f8@E#Zfd+:W17F@?R7RZ2Q_aII^.g?EUI)_&-P1(>dO>7YVIQV-;N[Pe/&EFY
(]/.2K1]P.6J6=//8@=]([RMKZg=;a#R]aCQTI;(8;b<C[VE:S)d\M8Ie=BWa4R8
3UTBP^29g)V0T\-LU14d<9Z>bf0gF:-BFB6>PceI,PODJI-^9\TN>&P>ZS,dHLEd
GP8NSZ4RQ-1I:dAY6=c]^]Df,IWd/YO]QKdRJ+-9_@c-78H]:>K99J&>65JJ2,\Z
P[e50N9YUAB6I:MG?78BYTfe8FKU/D&]_<-Z.5F4^_bDNdCYPdQ]:KN@0Ua,b>XO
GQ6JV213fE.TB+059@5TcDFa;+e<LXe(LR.US:X>L-+W\F&Oc04[D7e05g;7Y(I-
?2g70Dd2M[RTZD4KCPa;N)+]15Og,aM<39SEN\]dF8e4a\QYL825<)P-.P0\.7<[
>3@WB[2AXd>.N6-H/<=_\_Y]N[EZVc,G/Q[7d(;;fT@(/T^1I/&6X.1HYW8UIb,O
,C0^2Ue]UJ:.MAbVP8#;IcB=(MHK?)RP?G99IM7-H.\32AaY9O_aHMBAY.OOXEZZ
OFOH1Y1&56H1I8]/F/e?D[(@?6)X#^6f6dbSXb(7=MbaRUbaZQW\)V&Q?,1[DI0_
#;\GBfSOAT/De>1KQ5#F2WXSdYYIC8cA=1+II&C=RPZg-^C0?3L>3IacKA[Of[9.
bCUMaQ@0XR/:PIV\3EC)_;>4X2&@BSQOgc6CMKZDPM#+)MVdK>V9/XZfUZ5\>P]=
($
`endprotected


`endif // GUARD_SVT_SPI_FLASH_MX25R_HIGH_PERFORMANCE_AC_CONFIGURATION_SV
