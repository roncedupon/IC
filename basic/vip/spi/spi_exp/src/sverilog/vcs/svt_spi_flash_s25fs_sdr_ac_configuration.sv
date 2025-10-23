
`ifndef GUARD_SVT_SPI_FLASH_S25FS_SDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_S25FS_SDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Spansion S25FS family in SDR mode.
 */
class svt_spi_flash_s25fs_sdr_ac_configuration extends svt_configuration;

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
  real tCH_Fast_Read_SPI_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command (DUAL I/O) command
   */ 
  real tCH_Fast_Read_DUAL_IO_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command (QUAD I/O) command
   */ 
  real tCH_Fast_Read_QUAD_IO_ns[];

  /**
   * Minimum Duration in ns for which Slave Select must be deasserted in
   * between Two Instruction sequence 
   */ 
  real tCS_ns[];

  /**
   * CS# Active Setup time
   */ 
  real tCSS_ns = initial_time;

  /**
   * CS# Active Hold time
   */ 
  real tCSH_ns = initial_time;

  /**
   * Data in Setup time
   */
  real tSU_ns = initial_time;

  /**
   * Data in Hold time
   */
  real tHD_ns = initial_time;

  /**
   * Output Disable time
   */ 
  real tDIS_ns[];

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
  real output_disable_time_ns[];

  /**
   * Min Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_min_ns[];

  /**
   * Max Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_max_ns[];

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
  `svt_vmm_data_new(svt_spi_flash_s25fs_sdr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_s25fs_sdr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_s25fs_sdr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_s25fs_sdr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_s25fs_sdr_ac_configuration.
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
  `vmm_typename(svt_spi_flash_s25fs_sdr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_s25fs_sdr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
<fFc(5eZT(cJD6XJ/YgVFIJHMP:VY<A;V5eHO:JfNYeTdHQ4<HO)2):5,P&5K=KV
b6X^[LY;D6R^)+W^U:LSg<D\a(,.T]S=/2/.d#c5dW+,BD,#..=/L398ZdY2PDKZ
L&O5UC2NY8[=SSM^1\f?d2V4I=QYXH2+&^T9KDI_H5V?_#281gES.@#;e9PO)Q(?
9@/FB#a9(?E;41P70MPB45#P@:3^CIM=7dA&d0cJ9^a0&5/baQX,2[E:QY#@(?K3
>SYH;)R[^Cc(S1P>M_9E@9f<H3eg),,N.O00[8BR]cNMQAN,:?@Z,QF1CG2N(DYN
]P(MS7E:@><,@AUI:ge6a_P5WU+@&aSXO.+<LY2adR4&3Q29C8U/5&+05Y;cV4-c
SbYIVg)L<;@N-/;ca^IXQKgWADGeBK9L#ED]f[JR)d6\\WPfCgKb<-Z@:NT/3:S4
=gd^b2;]+)e.[8]@K6V4cLEPGK(:.a];YRURGN,R<g^;gZXQdHDc@(@)]]\^8BZ[
c=A=Fd_W>^eP-Q3HK_fb/W64/62((bTJXA#<5:_4S_4;=8STPXeN>fcW;M/gM4Y2
O(O<5gA[\]#/<^R;/gg1,Za6UC3>2IR5OQc[;.GaKOJT[[8-]3^aO5.X0)YeI&PG
f5FJ<bIT?Ef6/,Qa:KNO;#+-+@HWFP3cDE5&YHK;V\3[gO3bd+1IFL+SW)FNf]@d
R#@X#Y3/E\4/-AIBKVHTLY^g\>>dUDbB\/Q#J<_9#.Ce0\)XgPd5F\#KL5_2L^gU
60f)B_ae63S-Hd72KFGO\@^g5$
`endprotected


//vcs_vip_protect
`protected
MG;6F@;0CJ6?(>eaM<VPRDHX1+,\2I2-KVZ/7b/Q&QV4aCPR(?7D2(Pa@:dO-a@.
CV.=.YNO@94U(##[=bT\E\Be+a,B=:G^1;(MAR(>-SgN:/CcT@98]YT>::(_-\gS
G8N)DX4B)gA[?-0BB6A(B;,?_&C]9[P^c#b\^+#K)]2_>]7/;73Se&??8-T4+0[I
73GFCL<Hg@Dc.?.>(DBE@E7C#\&BD0P+F1VE97A3)TOP.1CP82(b//TFC@T#aO-E
JW<IN/d+gW<E_Zg3d[b3W@Zaf@GT&(OQJ-9c_6BOG+?Z:X)U-P67NAHFKC(gM6aZ
UU7-[M@C-HUNTKRa>FQ?@\_,3R4I&3CZPX)W^./R/;<V?EJ+R>1J&PW@LO.Q,\E4
O2E7/(OQ;DD6Kf[YgN+5FEc[&7B?Nd_(BBE?KPf.6^?4>?V4)4^/b3d77KYgVJbA
Tc<DEH156K6&3@_R7JNRFf\Z1dTO=T#:G2DFR)CQ&QfY(^DbaI=2P+Ya,A87J?X[
-B/JS7GISN6.S0?+^Lb)AbV+Z?ed.R4M.=?-5dY@H3W#5T@gFYUBPK+LU=?G_+e+
AD0+:;)566/C4O_G?H2L93#?,3K9[YP-;-(Dc]IKN1aWREE5\/HYga;G,]-RU#Gb
]?\L<eg3\-X=;3OCCAf<95e3,^JF.<5?RN;CDf25Ae=a[U[WNQ;[0E9+5(^WJYP@
F;^>/RC+f+5T\ARLR/(bEfLBDM>1].4Lc7KJ(3LQB==M@MOL<eB65gLEGR^C:8@(
2&AJKD:&J<;dc0W/Fe\3L-c;bBJ+8VUK478>.64VKfCE>Z55a62e=6ZcTSE;97[>
,<@#J2Y-\RD6gN;@0@8e4?8dHTT<VHF)L_ZOccf2WI00PL4^>.>dSX;DM2TS^2W7
=QWVESSK@SD\P+5_/dIGQ@/WZ8g@CGfKb8-8D@:H;AdP8f6T4)0HCZH:O[+L=RK<
ZZH:;(M8FY+Q=EZ=B(Wg19ULQM9gPA.J7O6;T)LPASa/,PQe>ZY\64U?8^adL0bX
+8EDe)aOE/Wa9>BSNF(a7GX1JKXQ@?^b=.CH41+CDTKI983QN)ONgUUKgEI,QC5^
a=B^/3\VY)9.,^PPA[1aW9:eK@,O3AI_d:H<fZDHX_)@DdX6U\R>Q\;FC144)</b
?\7SX2FJ+U9TJaDYC)MY_9I+;TI]90-Xa-3@D69dV58O3FC0D+P8[+:gY7(3VH,D
)Mf<bd3Z\11&+NVD6>-SH@_4_cF7LID2@5XKV&7[/E+V8]]HT+\S8<@eEW[\3Bb_
:HJ8MDBXCM[L5?fGE1N.\<0=]7Z@OWEP)AVUSIZ9b=+#AS-O_ZHfbe;J310c\gd#
(/a3(K[TJ>SFgcH4WA31.d/I>P/1H+6dZ]f1/#]F98+U4#^=Xa<<=MDSS&QYVRH-
4E@R-J.IfH:MJ1\aL,^3f\ca;39)S3TNB&+&@HS9N]__JHObRcI85&4/3(XfgIPM
;6QaE4IDgR3XTGJP>4e)6IJ:)#<55Ze5N@&@[C@O3IR[e3;\U/3<aR2aZ5SA3YHU
+<UB6>K]@3gKC90WYKXG.^:Kb&g+T_>5KRJ3>T;UQ>HPP\M<I.6SU6R#RE+#;WKf
^d&GOeeE\/KR82H_T2&M:))7TaY\ANS3G^CBEDW9#K]2<]J#L&R#WXQ].34&:eVG
cIRCWg&._-1\.9J&IBSFXeb/.<H3fOS&-+KDY3)Q6#8Z3L5]Q\MF;Z<,7b5+[WF<
V1eKZ35\-[TX^<SK]X(bCKLO2Z,K\LO:1/LCK0DKG\b3ef8_L4R>,_,dCb=5-;cc
XdAUP#CeCDI_K9e+R&>=X@QI^bZ[@DPXU5GFc?Ub>VVb&OI+5UV))T@Z7La6TFIA
Ad],1A(SKCf/[e,cB@0-KBEVHFEQb[QSg&-TE:PO-WF-4D(b4f6b;&Td_3c]Q\BL
82CX=090/c(5YAaKfFJ9B?F\V)Y@N_\8<;BJ4=\F.@c2OFFX5IG^5HQ;=WOg@^<M
8_OI7:3WX1DaCD_BZ,Q#,EU1Bd@&I6RE1>.?@-SE=(#3bV/7C+P-19dBSV^d_97@
T8_QJ0A-J72].(Yg)R5<QM3aP39KT:E72L8H:&W.WGd<D7<Z2B.7AW411TAF(aGB
a,L#c3eMCU+OE#5=K,.C1=I(HZTc&2>DWU^0GO^2Y3_]&+PI+S(cO5HM@&^P8IYL
2gQP?VdQ4^2-BfFCX..@#\2@0)&8XCaaT]0KM=\QARfO&=;^0;<0^&SI:ZH/?K>a
UBZ3#S1eSYZVb5#O@N4DT^/T<Te]9\a9>NW]c>;5bG<bE.AYQ>,<M9fPH;8+8H)T
d&5M6N;\P5&Nb&eB##V@=8G_JdO9FR#:3+SV(TE@IcG7=(=^TIg9\CAT8CNI9#0O
:]AI.ZgdN=[2.3DET(=8?B+-QQXY.+=TJ2@3[/cGTH+935E[Qd&<TUGa^T&BF:9P
ZLfVVd7Nb6?R0af2ce/BS7AA_M#3A,4&ENB[0TZN)b#RIQ\WB]):7KZf3a2E]aW=
YYBCQV01#dKB:[KK>D]R?ER+L\=dd&SNMAJb)?FL_HSKc2;NZZ7\cHZHS82W(Be[
aIV^G<bS3E5T^(_KD4f:QW4-3dL46&\XV5>#>L9,bI3,C&c;0YO3&)1BP/<(0)/,
:5gJ-0d#W=:-HPJF2D/]HR[aTGFJF7L:20#<B=gdWdQaL]ZT[/9,eQS0,/B(Y<R(
cd7e+M;4;ScNg<T7eFeJ^7S)[;Y)&0XO8,?=g\?S+C7=#)=M>RXH6@/6(^SUD0eD
JCD2FK(f[VU&JWPOdZ[bf4LEf7]3KFDA5K5[6J2+:9gENQ;G_#J+9_]V6G\9=:X8
Qb;R]59c[SaF(2g6NWN@;+VfIZQXRN>4<fC[V:(\(Z[-?E7/9FN^,QEN=E+[9V5+
]J^V7TA,ZeFQ(8KS&G]24_^4I0M==>J]5CY1(QdKK^aaDBf^Y]HCZK)((\fB57f7
ADBYJ,(V)<AQHC,NHTA75_<;L58^9R:fL5<S]3-4WK2BgHQ&#\4JW6VbM=2fd+]>
#bD?R?@KCa#0fgJ7J]:R+40WY&,DcQLbJa,R[ETU^e@#B#26@b;(e)d_>dP:FI=@
Z_baYS+cAT8\^#-G\&/40?BHK1<9LU_c=e4aQG1Z&MN4=^eA#NQ3fAWb,dQ)0<.9
=+:Y+Q3(H@_E1FE5BUS&IcI_[HMPD#_LHTIDJMe4gHXJNL&=K1[RHX.XKH\?V\MF
[8Bd+e@I-b-?<R:H#A8[P\\-VNM5>XPT<M(-&P3-X+\HUB^L=&V,+ePTMWYQS.ZN
E\QD19f2SMJ>3:MaQ-PZAFJ,/dNEgJXFY#2^</AQ53NYNVOKeE]>Ve(5E0^I-504
.g8-0AX]e74Y+eI>F7&ffO6L+J)A?R=F-HX(I:g_NYGdZ0KI7f=+@NQ0L#70XH=E
a^KCI7K;G2J4JE&,_AA]B^UB-S(JI<;?D1fQKd2RM)FEJC8(BEC@(9H1G](CED4?
/-K9YRY1/dT;W._Q@NEa4\R4X@Z-J6C+TYR\_WI)3KF,cBP/9W#^1;69aFG)?)/>
.DX=3A([[LZ-W8,H_5FdI6O&AX-EcJ6#6a6=O?177cH3Pf;[<D.fL,S1bc\aITW=
0)<cT0F^XB>FM69IX.X6FJ9\]T[E=[9(/7e2N0]5A;<>:^NYXW7_/aV<a[PZVL]X
Z+BdZLOOXf\bcT(W>P=+OULB1M&]3\Sa?S<,Nb;Md2W^_UN^V];<BbD.XGM6)]39
NNaW5gc?-F]YAB]_JGac)c^[/gJfaPA7QAJJV?.IKe;&ZRTIeW?:WAKD<c;92,=e
RF_,;Sc1&gL-Q1?VC2PDLZ+a/UdTWOE^/V[dQR&OK@_:LE5gfJ]b]L?1V+?F>T:;
c7e1:Z;Xe:PQ21;5U^)OJL,C?^+QS#>EYHASILVP++/J^EZ8FRFeB1RC4N.V/bZg
91@:9CK/:L(T1R+2Hf(HHa_G>RKH4G][c-[T.B2QXdP^L<2XYN+.VIMW?[YVQ/bN
263b),:\I:9XTNYbbKZBE.N0<Z(G(AS]=1P?C.Z(4S(:F?b0)^R\,(K<K//9BZS-
67W:G,H,SYe^dGQ^FgO;OS0QIDa6-]6FYG0f;5D3=9DM)\][#&K/Y:80G.3R3DHZ
dF?eBT]2GLeINAbK:G]I0e.1Z;LIdZ8g<+Uc[J?N^A#T@Qcf+E<FP1.Bf0T60^/W
bgeFNEAc1,/\TV4Gf)+SQ^ZS6daW,IUMV3[>?9)3(>ZQD/IHY4<I.CKd)OE_(B.R
^I5c78^M1YK7WD3PF4EefDV>]?Y62JX\_B@0IY]H^((.K0T7#N2CS/@._9e-.\@?
^I?8RA^99UFF3X88GNK1),94G@W1gc;(4I:076d5]][PU<Jafe+0J-_Z#13VJ4a_
P3OY;A;5c2-,AJ/.FD#V-30f735O-Pd2F&Q[g(-)5V;+=1XZ,POeL<W6/7Q&dY<M
.Hd?.PQ4(@XYAU.Y_[6W^LKTcB(aIT\D7T8XR,\OXS2@,Z#bA>FHC5Z(KXA,LJg8
Z42_2AfJHfNS>RgOe;-=IE7bWf^?GFQR.d-c1YY+c->^>A\L)5CQF4DV:bSDJ&4a
J=6MJTG1]W.OY=)@X:M8,(T4bBd#D(1_4JZ<I46PUJc.G\YeMV\:&L_J9IFaG:.U
Q_LWF2^M#11^X@4>LaWE_P1++4HR2^PAc+00C3-/C5dOAEAc/3HdNfA<OKD11=-<
6GN/Z8862Q4YQU^74+7OHZCW4cR+#a1JNLYS230W991EEXMJaK2?50/Xf,7RD)ZW
2-0g7<c8#ORE\HEM/MX5-3f>7dZADgBF;R8gC\1]IB@05=(&<MYPV64&C3N@X:XF
J_DW33;5#BdP57\IPNU37?A=Z=PZQUg)d@e)-JX2<@/I>D3>Z[,.&;N4F(B87c\(
H<JBR44ZbdfS84QL2?KF>g1TAW2<>0?X3W;g@M117K(T?GaS?HR01IgYeT<Y5c=?
T=(DA=2)2#e4VN@e9GX.SYO2HR<Y_W8[6aXG?H;#J-E81S=2-/5^K&OKO(50^/OJ
V]e3E.YZ/?,fEBKR8.<T+6bYgU/1N/MVM^1/#Na[b>8a:3[9:\1._4YWZGH_RF.A
bc]5Q?]#c/]A[#.d,=6I7/Ud_dDFJ(N\#C4Z.Od72_?LTHU3H4D-W.0a8Y1S<;fM
\F1J#=](IT_)IDdEIcA4:eF7aUT-#.JKBd9BQ:YbMN(6-K\;@7J<)-5^Z1ET=#OQ
ce/e:]]M/P))O-fEV+ZI7g\SF2\3aCeU=.-^(KS]71Fb+e\C3dR<MfSbW;<O+AD6
>5]F52U#+.e]-DKWYV&H5aSDKXEa0dJJX_F=6A\-)XI]\dF:dDS3Ze3+c4a]W]+b
^4dc3#PU[O.9URPO6VgX).FOPYW9TKG#(93TK\FU7HTCH207eS3@)RKM_2d80^,-
Of,S@HR\T8Z@b.XM>Vf5cIII;0\@D)F9]^)_VX;_>fPg5X=^RFfRI5FH8Jc<]2gY
edESM/M_R27N?2Y3GRc51GA;VadE)E,XO,PK[A2U)<UPRSC8VSV5ccE^\[L:<=1P
A+?7OLC(JSCUSM+0Xcf99V9#^aO?ffc&-5][U,X21&Y#U61cXJOGSI1aW=8T)DZf
EP#:K<U]8Fe5](MX\PL.:>&>E/c5(J;4=a:?&I5)efaU6U_bS;Bf[?.Z@4[M[KaT
b_03]_5aB15ZQ;V9D;\.AJ=&R)JT:4fY4L=FP)N(DK[-+@c0#(\ePAc_fH7E0EE2
>SfT6C5A8E8<>K-:\KSOeBc4>?\75?F-]<XAJB[;]V,fe?W_KWE-E#-M;R1KFB-;
OYAP],T=N>@GBN/PN4D#]Y>3NU3UHgXSELGADT=.7:-P5LEA[#>)V]0].eRG:\O5
7W?(Z_dN+bb^VaGF,M_3=gb3RWA76QJJ411[2\X&)^,&cBPUD5:KBTLcIHGDY+]<
-,_7Z30]>,R[:b5g>LC?A,a97f?W:ZNFM-FaOdU\Z[Y;5e6fMb.;=A&TdUXJ1>eO
14NEQW3c@P0A-IU6OCU)1+K(N18NX4FGUIN.MMAVRM/Y]DLb#0Z)/dabgX&5g6c.
bdbGNN4QA.g55gf.3-F-Q,G4/5=6c891A=V9(2#\>aT^3Sa?8M=+DW@:3J)X+O2J
cV<(4<f^#B\[@N(c4XAR0#HI/.KB_K2Q?;O(7+_9T0X2]Yb>cb6<[FZ=C5W(BDMc
15a[]:7UR\ZaH?[.IOBJ#USMCP(f_Q?EM5R12_CfUJQIKTQ#Af[XQ9b=M9>:YB4O
=/EO,DWf=ZeZ>3LKSTcf:a51N.AK:9WVA/(CX?C+fDOA<]0OYgF<f9X&8.#TL(SR
Y-8JZP31C6(.,4TQB@VPUY>8O8PYWYPd>Ib+aaHY811Sa<[,M<AgEe0WfU>AH74^
K)F00&OgD1@,B2N.V<QNY(AU_I<^[A-UgfB5Z12e?4_TUBVJV+8Ed6GM1)H]KgLZ
@G_DMYAMK<5ZT]6:,Uf@_AaT<AbIDQN3)<CN+=0>V1W=dKNC^T7NcC6Y58aJ^:@W
;A,D;=8dZa.Y,+[6N7HL.#U-[)@]Q#Y(OM_eFC(2.8g)d_YC(Q-7Ia]f-2-,>SGb
6U?W]@S5:Z.?6cIB4d8_R1WJ#J,XTf=<Q:U_,/dG5&QHS[_[;8EAJIL.56VGCC>&
\e)8NYd^@C9,\d/eBKT>T[I2BA?ZXNJ(_RWL/-VaQ)EV?XY;:bW50&R1A)U&\a3C
EZ.61B;fgPdXCA=6bPY4B[XZ#g#(KH/4_YR2GbUHBdLQ)gYTGBaOg]=gaO[3f#&(
,Nd^0M+P:d7RbWTU@1e1c6,C-N@AaB(EA5U;D)A]D6@g[^)CYDQ?edd4U_\G2VI_
3.cOcKVa1Nc9J#>aLaOgL-,K3/)_Bc]4GA,Y:Bf8)];\,K]=\c23d/3@^RGL6V@8
/LAYZE7?AP70)6:ZD;<f6&X\W7OR31#K5;41)b_RMI-G-?^M8C-_1^ED.UfVgFV9
a[+J3&Ya#0,eZFZ/#=Z)<2F_M#2]LG]V/F24TbU)2M:I#N=CcOBUWZRRXD>M+A;[
Gf##O.<JIg;4NA;eR3eJbZ#d]Z#(EU,F,Y;?3,AV\a\/IfM<g8-EX2Rf#K#UMJ1>
<GU:/J@e&0XR#dca5E8IWF33-g_W48PG.e>/KZ>3&UE72+=-ObQWW;G#8\\2VO>G
U7bb#&(J42c:e47a0[U<dI52,fD_-Z]3CUf@>88ZW\;@QFR<5^e2&5JX[B&DXC)9
:-R2(HHO95A=FASbg)6QH=H>HFERA9+PZ,QLW_F:L^NA(a1a_6ZO;I)cLOI(E\7A
)0PF-9JC(<;/Ge2T^K8;N+W#E4TaAJU:6\BTTWY\#dM[2XH]CUE(Eg_<#B;VI&^N
CGQ9=5eG)HHA:P81K3KU-?=O/YeUAa0^YEg=^3/(:Ic@--e9.dA\8=)-^7V^34aQ
QIEOV.g[Z;F>UeNRSHI^9_#V\^+JbWN<;H;dW.>;SIV\@G))UdOR@.W(X:5]TdT?
;//fO7?TAUfVEQQdTTA#NR_GU@+L;=#>Occ)&DV82]_1G.a1AF#O#)E8/,H_UE3&
:1Ig^A.3)(8K>@9L?;&I;UBY(d=37+)5[gab3NI6O,(A,_bAb>-]HA&;/&2]PB9K
B-?0G@X^7]V2/>K3ZOW\3\Gg2UY+^f[a/_L+K@#CWKR5FT,DY^d/[b;[BR(KO1AR
-V4+XQC</3DaQb=3_MADBAa0eYAJ)_F&eZ#QE+gP)6X45,gJ62R3#DAM3SJ;&a\4
AbKYa,&29(R+R1C5\fF7M,#P(E<D=0(VSJC,;gT>ON0_/LZ3HSW2Rb3]H?XG:>QG
5gdQ-Z?3[TcSLBD7aUWe=GaI&-1A^9a@KgIa9JcH0Q=1KDYc+<EMFdI_X0fL#a\M
#HD5<C&K6212?d]B7A):6LJ26AG0/[QEA)C5_:_:HR_IIRENMU6QUL5-HPKYV84?
W.]U0JVa7A<Q<75I]V2EQ[gX#6#AJ)<W:++<Ld/>D\a_ZV-ZVXK-3;Z+OYD\IJ9\
>^_/RP,e+?[HGCKF)b?T_@]Dcf\NR]&BAMG2IcdTgb++0d[9,#A799XGPNSF17YO
dZ<T^F=L1,[_/g]d?(:FOZ^U#_@3_+:P91VKRF?LR#gf,]&40[M3>)FNF6X2POQ.
&WM)KQ#/R_cZ_-2OS0F/N0).e/fUG&[9#G4LPK@dJ.\:]E3,Z;)Yd@+-F6Y-X?>G
g)16R[(SfV9?G2K/@cUDb,XJX0Ad&^?)@2g2L&.C_b,-V[=,JKEIOJ,]8gJ:7S@e
XW0U6K^J(?YLZ2A)e25?E_YKa#0dA2?BKc(_Y]=7KfL=R8VYB_XALfC6#>([ZXDT
3S2;)@7UV4d+JS=&Y?QbaVM#:M@?TQ]<\NdGWK?TK#CfGO[<UbA;QYLU.L>C=70f
+cYPH4_DY>C/e>T=,8VbG,(,-Rg5a(G^(CP)8?)Vc9L40a:AJ1A@M&G8LcYI6.,a
Q\e&FcTA@-RC5QD3TJ0NXZNgX\H4RKM)Z<Df9.A1\1g4aU/=L[H\g4:c0[=FH+K)
;A49RBS/SDfbD)cbb?Sb@D4;?8,7Ig@84YFY2X8LQNR7IW55:gd>AKK8bZZFP#CP
#fZ90QXQXSF45I>6f>6E0T6GgCe\OZ8]EgHN/(&OBcK0+13S)V#aH.B(.YUf[(F=
ea>Q&8SA\6N#O&G/,bc\=JA\20gO/5?JCP+S^6BS1CZ>#c?A2TU&TQE(JeUacd\]
[2.DY;19D>>:?M[cOGK77=VC-4c(Rb_O/(=UaM:K-U5._,FMS\I+M^:7<K-?8J^E
dg>,HHS4^@<=(a>e_92@S&M@L?Q;_Y?O0.Z,Cf3V,PI>SYZeA./^I:0L[#,&FZ^/
c)SACW=]5<_#7D?W&aG6_FOgA9M7<V,B\#Z&71edc9_=[e(6,PNMU5;>:7MTO6Ld
ARaOdga^-a#:4H/Oe1W35Qg23(/EU;ea;X]c&D,9/<:.>U[WQ1,0-;Z>DA6OW0RK
(0c,?-6FS(bKURZIZ-#)b,TMf[d\]/AYZMLHHK5#OLM?Xb[G\&P:KN^P-&]L-Pe0
;M/OL\d7ODLF\&9a:6WeG8,]7.-1#VCC](H]QITDZ<9L&IPS\[GL85C&2]c/-Fd6
\Bf\AL57a:9@;MO-^3Yd_]&V)B#2?+7_e8=Yd:[K@P#_YaKH>P>C_AJB>BIgTJ;X
NQW(=gY#]@Ce=YXVV1J))[Y2..N2@1CgfP5P)<-_U4#>3)MO/#),UPg102#][Gd^
(Q5@BE>g,dOaP]EWZ@dT8C(DI<5bb=OIKZ@S]2DS.+\cYH8HH,@G/,TX1QEcR;6R
eZfPAa)4N[W<cDB=?LYCOa-1NI/F=e-\^,CV(bK=[^[PXC69Q@#R:=_BZ7,08)LP
5[T8C9)8A8^HaCAR-]I6ZK?GE,=^G)HfC9/f69A)IQU[_:=D8?53HU\^^S?GfUQ=
F?E=HL@?LaGM-1fGW67<9EO.VcEPU?aWX&(KYfb(]^?9^HTWJd<;#fTP92Zf=S+C
W=JJ.X=.Ea8BcO&&<]6dW&3)L4G&QCA?Mdc[e.9LP/C5:QdfWG=L,/b:Og>-F9BH
@-TB-M2:ZB#S]9)RFea2ZP.IGVOAPa#cY/EM,UO-0ENK;/:R9WWgSZ,fd>_S3>A^
-9]P+cF<.10aK]T=FJT8451P<,WV,^V&MIE-JEZ5^gf.?65#L[IJWgbb9XIf8GcG
3Vg/#0IBe;\2C7gc46,6MC-fPF4YJfIV7YM/23S5RMJ,WL:(M:&2(R@U6P:\^UdO
IQJX,3<ENF?gE8;=<eQ&&UKa<g1aSIV2);FB)WeR[,CT0V74,AC1G7f<=Q9<@B+F
)TD#&[4G&0)Rd^C+>9C/H(E&&L4N2QK,C^L5U7M2b61)4<Mc#M?@Q9e3g6G]#J5\
EQ1gaIeTe9PL+1a<J,b\+afOa;DRN94R]aO5G^]#eT@ZL?9eUfPTW7@K1_1-])Pg
DWc>I2@Z43<8bC_,7CTaYADWJ</R58_d#E7XQJ4;ggFEe\a53fZU2OD72&c6C1d7
<\F)bD6YPGP/C.D=\RQ4gR4V34,4WNA@0fQ04./<+B3g=KMZVDZH7:6W3MCE__QU
=QQC,M;A.f23?^N1.0)XKWb]ZI.Yb#>KR>dLY>XN>Id=0Q-V077M]QNPMeJ_+fd(
^.1N^=5FB/=W?P,3S2&0YN0??=Z=.)Pe4b9#/KY6H9FI5TJc.L.NeDNBXe=AdfFc
TP1G)G5.]NFA9OPG)Y;/B,<64FdCBU#5NOL^^e2bOG(3fO4[A.S1N,9MD/6+bQN<
g4N,9gc>LSVKCEW0+YZC=b-g90,RIT?<CA,cFQ8fW,(7A83/@TDTVRTR7QD3#PdB
TEFHbXJWRP/LQT^1YT&3WLM>//]5GFW=]>Y6b4.GcFf[<O/13;>SFD2_fDC;Yg@G
+O)GQXP-:;T[/5WMBLY?<;RF^J]bGO3MOD0bfV2&2G=W_Rg2.Q^<Y>#d)LDKF>Q=
<H>1L[\GF#_J-L,MECJ@],7.SAZf=_AQ#.X7859FEE&AC1NB1=1fGaU&:W4A#\JS
:-,Ee3KY^Q-5#D7=<HIOCaU<+->+CSbE3P<2I)JA(SBABOY&@C@WcYF/c))A>L^D
I4)3-K:IFS^6#Hf8EOa^<&XTP]eaO,L8DEY?.U-\fD,Y^1GUF[+;[YL;=AQVBYSD
P^08VIBX:CHO+P<Lf[4IKIKL&H=DS945CbKE26C6G24a1?EC;Y?EW/^:0ff6IEL=
-MH#KO.NG.A_d+9\4=M\g?A4IbTPMdbI>WK-P5RWCb.]<<8N@dd1Gb<[EIYe#X\W
T0cD3Lg11c:TU:7\+)<BF4+gOX>Vec;0-J9C1]9F9+85.1FN7HIDAEG]G&f2HLKK
&:./Q_B,CFE_3(_B(3U(N049=5CXEL9IA63bK_5YgSX\<<S&5UZ<7T=e;;DCBY/5
?<_,CJ(:[P&=W)Pd12?b23@.-654H&<I6H:22S3QLO@3-Y-ca2G3EgGX<,&dUNNe
U.:..Af,F\U@K8=^b+K.;W51&JgK+)].5.Sc?MFB,WHJ0K(3,g-4S;9<C)<.06b[
W/C5?0Z,9Q&(7e5[QF^57\AGS.F)&+^<-M1bcEOKD)LI<>@B?V4D1[UXa4(6TTGI
.gd39UQf2Fc=>[A=[TRW&9Q_HT8@/E4c8Hc/KD8IIcLE:c[)HeQLE??5B/VK#K:>
0BR?@RO1>)ZWMMf=\R^C16OT^3[>a#I?aS:A37F(;-K,?>[ZX9V=FU;G\0Vg-XHE
/M8Y2:MbB;900VXJ#aNA^KN=8+8X6cU)QF:U+?b,BOK-a@LC[fS/NeOLU(EW;:5X
1V3C/aJa&dJIP.EXDfM=]IeL@>a-\X5,K_b/dcT-J+e4J+V)RIXBXW7:0>\J(fW7
/ee0[:g:aRP[XT4G_I_)T.JQY8]XMJC48WH#,CT1)U0Y#]A,+NURdI0&CCCBPH]d
&LYQ7)ZCG-7:fWTURC&.&^C.VZ^(XaCN^ABC>1<(=-V_BX^5P.b^D^R[e1KA=U_O
gd/L+CV=@J/8EDWI)9[3KX.-HALD3_UF[.[+05L@C0Jd.&9G9GY@<\N<Lg8QCBSH
P@I@dFGE)WHC\Sa4L=<Wb[,L2QFVdFEDb@S@8E(<YGcc8ccb\Od0J&1e)eV,]0^f
=:J:Q/CLGJbPV?OAPJKMGLU6gFKP3c)b@6f2S>gJ?NO/3/7FYDEc\4J@73CY6T1,
b<FW.QNJEgGZa,8ce=.=N/40gHeOZ_GSe=7?)2FaRQE?:57L#)S^SaMfddPURLW(
4_9S=V8gRH,&aXQ[-=SYT;dP1caKO+WW7]^7aT/7NORXA(ZK-fIK:>#&c+1MK?a@
f-C82\MYQ>1)I_O@VBLY8D8=eDN1]L;:;&bd<)[\E>#:FdaI>fZ,^C-08OS&E.8f
5;F&VHMI=M^HSPZ+PODL2U^a(]>M[F;A?V\[a1Kg0ENAY(Z)V0dBL.c##eWCV>S^
^[\dQO>8@H(GXXO#EJHZ(AbA)fBN>L@JEP67,,W(fa0bWec29:Y9,+0<:&B<\H;4
9-a)5O=/Y=?1T?J&3Pb#LDK^/:P0Xa8\XEfc8a7<^b82]V[P@aR5[JE9KY@>@g?/
Q,38>E,277dV+GNbfT7CLOVJX/RdTS?.\9/b>#NKDP;EA(?LVKP):X<MebR0.LDP
J]eAZ3aeV\dP+>M=#KD^\F&YZAN^OK_CLe,AZBg29\cTY]KSFC#1E[>YP69R,XgX
N0::^#?I@[;8;VSaBfdH_6D,eAC1[Y[:\a;b4NfB9HeUU5S@LBOYZcF?[]0-KY1^
_VaK3)f)V42Z?eLf9,Z^eFg?\#,@1&LWJ\O[\bV9)gZ2_TPaSJ73MUf3N=S@4OO]
Y.EJM<9SLg/27;:F9?]M7GV,dddB<XUZd,(Fe=H3=)NKd,dCL)gGR9J95G#C/eR:
,N>;M8G3F.LS4(WET1]TF:fOaG4Rd#,O[/f0.Wa]HWVEdN=:M3EI,3-V4EUQ,geE
X1[_2]EK0#-aPH;6?OTfaEEC/&XaT6<(A39I>D0DMe4e#4b[A]Ze9bP#9KI9>e3T
](ZDHC4.R5b<#[(:6(4JMU-g61.A7Q#?4WMZ:J:ZC:^<L+F3EBF7dFB=5]eY@1IG
:XCQ572eg8gP9Q6KFb+^&Zd==I+c?&JbO4_EUF2I&^;[W/8+(24^R?Sf3W.>Y3M7
AK\9RED-66eQIPA27WRN@A?=^B/>0F#HF9DM0I>4#&dE.8XWA:UOeYC&dZ?5D6Fb
b]CF@1?fKW6N\gaAa7#;6cT9_WGF-e.>45cbMcfYUZXZ7P3WZ&IX3-&H,Q]U(gA6
1)GaW47M.+\8fMV15BI-1cSS5QH]>U)a42W;C0D7F0BRY/=6BFKILL35OQ7#-+bF
2]ZI.)@;93Kf@03cVfUFNF+fIgEO>1E]IH]4E+(Y>D_=X0a@>?U9aMQ;[^FI+@4J
825HHeH[HYQ^Bd?B^RF^#8@e_2,\A3:73#/\-29DX:fgg&1P05/_aM6&R]3LA)Z/
#dY)I^E&gZX2TGa,>7Ze65L^5gF)Eeg1\eTG;C_e^9f\\ZUC_/BOO&EJ)>/=X71:
EAHMJ/BZ)>D]W5Hb02\[aGPZ&_3KIEA1,4bU0=(=>(M9JOc2C)e:4U))KeRF8:8+
5U4&UM@1Ld)K<ggSLZU[bJDM?)<5>R6QG\[9HcC72dO0M^6<91G;^;XW]7Q?Af)O
Y\W:3QSQP\X=KX^IJ5JP\O3>DZ305_]Uf)F6TCP.[C_JO^CE(M+S;C>CV6:[0MRI
Z/,-&?G8g+<0(&C^<.+9KCcg]g50=MY77W=Y=L-KM&?LRC>f1[;]DG</I5<\Q<+F
@)<,N@Ag6SX/:EU_IC6fAa/;d0=JZ)&f?#,+H:F65:gH?S>I?QIO_?Z?;LCbW[fR
&MKBXb[<3;32J:5\SgJ73MBYLLF]dU6g?JX5X@b\C(FU=g-H[#?I9B2<58Q-?BHX
-e)/2#WMP-Ic^/<G=PI+g5_MQ3_H.?=.P/K30D=PI^H1(,7R]HbO0;WEU&>>Lc?9
U<[N?MRc/-?D;eK?2e5\H=]VZNF1LP36WUOR[];,;LN<>.OJ&L95HN)&<H0@NMU;
;O\Q)?+Xd,0(ZCRM5.RRGdgK,e@OcH:IKc2>^+=1gTO181Z=b:>J2[&2J^cNd(3?
B=c:S;.]UN>g)-KE5@_&LY105+VJ\VN2T^WS./#Kc-bHSD,0.:_D,X_eLQ,AR[9T
?-=J2b,B@c(-Geb^8a)AZ1@T3,JA)[DT^HYTWP_>XH:g9AK(?^M7AVLWdecK82#B
TFHVS+R0)IGfOUUFdAY(M;,H;6Q#cYgT5SXHCD+[a:#aY4-0-7UD;X/XG0[C=N&9
<?^)9?SW^/6KDY[;LE>??O3AO3]T]TLOCAd<85b))de7.e^XAgf2L_:IcEVC-eJM
DO&@acdGL<&Dea>T\e5.c)MMEgSDSIE#<Hc0VZ\>;\]6,Zc2<;RB4,eFf&H^6NZ>
Y)-3YL;ZYPV#KN2Z4M=@_a:7RC0(PW&LBZbBFCR@V&4I2X,4g:Qf@S:=U2=X7La;
d0IdN7)>C\L[]IT-439-NCQS6@Z^O=1IDV4cfL[&Ab2X=,?c1UbU[ca3@Fg23^-[
OI:Wed)>D\eN7/-=5d)Y(::I[@;dg^Bf#[\=Z4dSFU+C\W\#Ge2V<<25M]/USW39
BTZScC3A>H9NDH(HGe@.>N)G_c2;#+@K@Cb^7,=N.:&g5[D0]GNU<b&WX9-TWEZI
Q(M[N)/I)WR@5fbHc64</M?2Q7SYZ4XU([]=J?SEb:-^L8,T8S+P6Y<]f0FU4J)]
.B<Y,DB--f7AgQOWP9??&>5T\GLBVJ3F3e]cX:EHSR(Y\,8_A9UBeIWT2;@?c?A3
F0HN]@I\7@.:RC_0#N5f.1.WG5J;0J1[AD>g9\.b8SW.c_B.]4.1NTKZTY4DK.O-
9;>g&191O]V[ZQVV#\TTBIBK1:M.I0<E<c^->H\g2d_ODZ+]#\T6f2K(\9907Y4_
_Af[2TA1#R<C<J2;])E3UO;6]8e&eIHS;2_2f9S3Pc[N+6U7^@.;.cJ4V:cF83Cf
QBB7Z-/5\C#f<.Z[eOT6T=gKEcf#M\&?UM;Gf(TUEE,CF?=RS5@YM+XCe<?.95_U
=:f5gE?H#OO;53g^CSEO98V(@=bD6L:EHS3bE30_BfI>BT=AOf6M:NJ)bX,d)f^N
:5^R&;6\AgZH[00[eT3d1.90VM9=PY]48QKROGc1[48FZ]d\Ca-Q/H[,F,923,;H
FM?&)3Z8?&>]1)?Yf/Yf22D3,66:W.gBJ6>IHI7.6L#eV).H.SNcYW.BWNY>+VS?
W=Db#W,HON40[4dAGR0N(2K[8@YI7KOVN/QM<=8BPD;_C8]NWB>X]4N2AI3a&T]N
32@U=X]#PY8C&JK(5=8)c2ZLP?WO[/_.a/1U::M>c3NRd2>e?V&I0=#SFeV[Ac:7
D21VOJG6?<cLH7,_QIb2\.HS\=1#\)4[IbNT\:f2.1\8SSZbWJOIPfDf<-ET_EGb
a@_Q_f2QdAg)\9E:0d.R@&e8dg,1_QeNgB1?f>>P_7TWS7NG77a\IZ.<ME4L6<f,
U4fP0P9NJ[R;[U_5]PZL7Y6e?M/@5d<V#5BGP2e.#gXY<dU)<C@A(^38Kd,PXK#7
OHMIO@+2+?^S_A0K(L_+EA_(^d#^KO/8bTJ#g2B5#c@S&/MJHL)O3S,KB.8WH@X&
FRO(1WbGSM5__7)8([E6SEd[2JL8#S]gP2^;33g,5B^H/V/SZ?dPA2+8^B4AN=NI
f>-Ja<1M+_ED6+E;V:9=:/3J429@NKAO;P[)F+a&O>4NMENC+&L1HB=[U74CQ-5?
-_D&=>A;b-UMI]+Kd5d5PNN>\b(OM9&<MDV)4RL]7-BOX/9<QIa7Y4BF=A#4UUaO
_KgaF_g885I8H2+?IMSA@B#HSXaQU9M4&WF?9AgfB)a[9>)7<=ZQ6;d_)(#O44FC
T##_[,S=;b-(SM@W_@^/^_9LdcH,:\AAcf2[ACHKB:AN0C=Ue.>__H1)_0H#PZOH
&UP:IT#\XVY7XYUa6S8#XW8F?4FeT_7X/a5,UY(f(3O2[:S#_GPXZ\J#OVITU\VQ
[236J0L0dd63GS.\/XPKd8PVKL8I6RT+g?E(U.F2>SbDGFH1FC-C0:2_Y[X)KU^S
BT&5N9db@[[QB/D4WCP352RN=MUIY1.,_b\PcbIIFYV&\)6A,51<dga\ePX6Z]_O
LT12Dc4@cM0bR=c?&OT->bI>MHU0Z=VTCPJU5^:UU&bg?+Z-?.@/_HPHEC6L^0gT
2.X?;g<ZMG7?RNa]N,P^P1?,;BIfEP+c2FJS:bF_J)87UL\Q_[2PWFOGL32e81=&
a-C7])W_D/?JdN8F3D095@Ib/F::5@WMZY:<^>+7O@Rd4R&2<[I^c/8=BSI2a]B8
Ad4=CaTJQJEP#GD3cb^X_79b)f?a+P\TP0HK-6(?WX0SF?ZIZe,E06B6^]M-ECH=
^c(LN0CZd2)=8:H\^aY<_g2\(Z7O5^01[^)Kb8=8K@#Z[Z6>9S#[;P\d\C-]6^\J
4K>VVgLL_OORM4_J#UdS[=E0])#L+[^76PX+SP(2&)0FF3c=1.;>,cSF<V=WP&&g
-^B[cHTGVg?S=>\==dJW(dFCJY1/WBIUARNHUOILZ[,(&&f2&,eB6Abe\)dBV#F@
#9ROUU-4Z9<39;WW\;[>87Q(=B+=I=JaOK,_4B_.+C@@Me^:9<R3)3b;g7SKB1;.
841a=L.;Y71ERbH=cE/T<DCEM.>,1WZgS<==M)\^:d;]<T2LbMSGG9W2dQ2QA[>O
+9R+=gb#:1-WD/C/31.SdB:Zee0+C@IYW3YO;c-5DQ281)f4H1P?SZeXeZL6@4R#
SPVKd[fU7R\&).0[e_M?[L;1I3M./(&SbgcJ9G0&EQ0#ZW\ZecII\UYNPN:,5eY.
T>GOZT4c;8:A5-8UC87A2Q2[K<:3)<@\dKgg1L7=c\O>FCA6/NEX1(c@ZPK.a[fC
Z)->AX8<-7MH+Ja_<JO]\d+e;X@dWB@J:=^Fa+CS(5M#I@H9g[:M\AN?VTf0D5_<
L)JQfe0WEdL,]b]Be]Dec]\1G7E3FDUOaY[+.(/?2NQFCS^(XOMJUE?TL#2L(<G1
3fD=_,+O[#^5PG7eZ@6OS.L>cScWRRAX@@1>\=Pg/d;f?OAX4A^4BNc>B8c87+0O
T9GSSU3MFe^22f@QQRW=,##,GO.]-eC:eZO[V,9UaJa=21;(&K+?QVB[2]:V^eUe
P#[4^1H,-Ud4LN=;]VQ&:6+H6?ffY_NVYAP6;3_28#W=@fR^eC]a6FTN]X9].H,4
cI0A#QIGPL+5aJT=+FXLe2>]8C2BIS_=GX@2[Kg)>=\cf\MW5PbUg<==Y)/2,F0=
G>\>>/.X-fQeBdUSJ]gD.HJXS\UW2/fbae+IF:783@Pe1.:YS:.;>#1e>.9XQ1M,
aD\aXa/:5,JW9P3A1G1NfW8AT=-#+^.X[)A#6Lf&P=M@NX<0B7W2LI,CF_bSY>>H
QC?Dg=NPXWBFX.&??9:>HJ9I8SY8L3,OTd+77XSV;g[PXc<XP@e8G^WK;JX,&&<#
b,PH)ZNe];VV>5UAPZe4FQ#SMb,7[4Va-:U7&B52OgRE+Ae;KC.cLUMPI#^E0fDX
K=0/#A0:RQ[?U+K;EW#a-07Q9^O3><LG4]K7?8IS6G6d]W4/4X03EaZ<A;1@cXJ&
:Z,3.&(eP4>4-=4Q@RD-W^[\=^cL>7=f=W-dMFDA<8L.M93FEfeLa<gYB)eKL6L(
gaTV;b:S(,_Bg1C5(NOC+A+NaS#3I6Qa2M&8B-=K@8S3X<61QOe4YBgfe3;EX>+Q
28b<NA,WV,e\5TQ3Q6^W+KY<EdDFeTMB)FU<#OI^dQTbD,]<CV^4KcOF;Oa:KTdG
B\LW?D10TAf:T(9G&gZBHV&9=WQB0R;MPCHbM4CY6P:bDV@^K)8I)bQP:8SN[KbU
=:XW0LePWg851=KQGUA)W)/.g0Yg8&cYP&bK0gZU#1)a;@P@)5gI]OPWH8Nd<a<1
<.H;14@:U^#@1^<X7N@dAOM\U_5M/SG;+DLCd?Q?e32QP]B5T[-M(7^FEMf=.cB=
X[ST<2QA7HNKJ>F6C&^0.=bV3M@d7_]_dX<-@S;eX&82M?SL1]EFWJ/Y+/Q+H.Ed
[QK?2C3\HYU0E1dSM4+CbTcUMObKF<b6?.5&95V^AgI_F,dYb+DM2U0GCdT&Naa3
QcE/GfA1^I;:>bc1]DJ#g(NVc\CX]bdPNO75BHRK5eS6a@NR]/476:1eUOXT.)_V
F0,VX,gG.S[_<EE80(0dRdC145E;WGP#fe1\\<31b,4\d+S#bQ8CH>P6-&E?^e(e
4T0:ZHAGMAHRN0/Tg\D)ML1[(5K1g:U4J#C@@ACX:##gNMaQbAC7T_[,/M\&NK_6
,DM5.SKHeJ-F#7+WIAK(E.XgF.ZeA:YFUaEJPU[<-T4EDY_3,1b[<AZBU5&0+9CA
1ST@3SS>44#Eb:RQ&GaM6#-?S3cX_1J@UfeQH#EHLNX5?E_XC5G?>3^7N5aJ]D5B
FU?+RB],EXEBdHdYUIO-MW3QYE4/g_00,7I7K]]C7GHO=ERCfA?dHS_O?(0Q^N2[
@/)[,1bW#..WBA>Pd4BK&V@1e)I@eQHGbK=acScLYM;-+97D@,,:FAfWFC#\2XY5
1,?C&NS[(&GLLI;14SJbec<Za.Ha?X(:#C(_&R06Tg2FUdC<_6gZ6(V9ZX0e.NWE
#==IA3NU6[0XSD4b=-+2-61CU:.ZL-J<,[:&:VG?F5:RLMIfHQYP1S]g-PAc9UT@
d,)C<<>O,A[L:E(A\B&0Q8gaC>-@0_bKMaIa>fQS+6.M^-[cV7(SISPYX;R64&+a
BR=8U]e.XHaW3/9^P3](>0P;?4D0SVAU,LV?RVBJ9JM;;JCRKOKC1cM.[#WL[6B5
\IfQOEZ<<U44e-1JaW:TJQCcaaY>f=f2;d?HT@aec,?cAb.+13O[MN:_c?@<W.2P
Ic4e3d-f;K/^f<?S<2Q&Yd+XHKN<N>802+gV]dTF,P^9A.F@A_Y28G\)[ZI)d)Ya
&2Kf3<N.?_6)e6A1=O(EDT6SeBebD7g?6U[(86TGJKU#,F3B[+cA,H.PA@<PGg[#
5W7Q+FUE6e<F)(>Obfe8Z/GZXSK>N@3K29OG]YVCRSNL&8]GQ3G36>)R4)d8D3/7
(N9g#fY05\ca;(2<ePb93:JF++D05T^6+g;QNY<^EOZ:WX:Y)/MT-U>/c:9&6F#7
dTEPM<gY4eYM/(]_W?dd=VW3f4^VTZ/g3J3UD<C&d7\UZRg:d]T(\RMO==7Ja,IQ
4df9Ub<QYfNZB01OXHI?U_Ue&T96b0H9^Q>P:28<bM?<_9/<d59PN_WF\f+,B@QV
7MS2N]98CI7?F[e_&MK1]cgOC=SU_\EHNZ3#L1c??VW6KLL<WD^LFE98K^L2d51]
bCNS&/Q1f9LP@<OY1RS[+-LK8+A#)00OK95JK5OEM/&6J(cO42N\K&7?-AXT=WPW
f[+47:I\b9-Pg^UX>=bdgV8:bYUKSJB=VW5K.B7)8HDeHKg]b>dcZbY>TV,b>SAA
(CeZg6^DHaR]?NM#^Qd]83gHH[\]TS8CT@4/6>UECgD(K@c]R5(X6OQE1-3e=XW?
;6>.&.JA_SHFE=T5]]BR?S>\45/)DBPg[<a0b.^2eP+86<D2;f@4FT;S[d^8-)<,
X6:[7://;AER:U3O:L\ba_UDK0GH[Z=#V_eUVH08b@9g>3O98U5I?EEbXXRb..N.
L0_f5^(b3<UTdSO4(MP\3<PK8:6&#V_G2K[V-O&3)CEWNOQEF^1(PF8C_369B6Mf
B2L=7?E^UI6VfLMB+?N<(Q6Q8VOWP)O[Tg:@0^^MSVPJgED@e_I/<_Y&V_J;3?6b
+-PW>Q,SdgQB3NVG@dRUH+ZA@<_@@+Bf3GU9__7Jcb^UFS^TK:-G-QCXZ6E^<H<F
,GKMH8-YP?be(^9:D<2H-4ZD.d:gBa<<gaZK-93L>:C_=/QM=eJE_>EG=4f^dM@6
#U7V53K6GJ8d.&(Dd5fR9gEeE;]S3RMb4;5MUVe+Pa_W1#VgS]?IH;.UTO:J=MMR
ZFJbKS]Z.^T\>ZcABgPbcCE]=_5BgQ/7:,_OS@eZ@>H[ZMW[@)]3IQ=0)KD60NNR
0@<:S@/9;>aF#g4X3&8S.JPPcH(g(f(XI[QN_XNZEY9=gGMF<13U@K2WbaIbE#E0
:/[U;>dPQ\O(8N_P^5cO_de,:N)YE_V<83FV)U]APWf6f-MLG1f):F[\[.HNIKc-
F5/MM66IdPI\g35@30@cfA+e,8(.AWBFC3#(#SHG\g[RR7XL_Vf3V\6(GB9:-9NK
4WGJfK=gQQ+LK<2g[b4LdV&7#U3Ya2.^,<fG2_=BK_C-AgHA==C[M<0N=8W3DU5@
T5E@7)4B3;=C_e1B.;ce2^c2O847EB9.:D\L1>]:OH\]ePT>G^aG64N>L3+-U;R(
a4Ea/W#_=L4N2JggaTcD,G]ACDD#\YF3V;4Yec[;>BV<e3MKLUJ8eP=IU:[<DVV;
0\a3Lb4;TGde8+Tb/0FYE,;?BF:LIESLC(8#SAf1(20SVREa9TS,>+Z.A/V&CN=K
\2W/>cV7TF:D.]FVUHJ+&J;NCLL4YYaR#(2XI,MWWNR&>L\<e?VK_Ld&L7&,78+A
^WZ5G=^GOea/#,Q&3B-_8KR3F\W2W.QEIfE=RMe#bE[^Ie90I2X#B<0Q>F:JTe4P
T9<H_PB^3FC.JFg_AX)L\GI42T5RC:c:<\&3]W<R52#E^I/2;HQ]d/@e/Z)CRF(=
B6X^#VZXa;,G,A,6RQEUdH1d-S<.FfEEY85_YUI1OWE5BKE2RW4d^d@8;7,?_-Ba
;d<:MC3\P\7@H3[7P@KAD1LD=a05F)C(4.a_SKN[M860BCU1:]0gZRc@(=?QN.QS
DIXf-Z43WJ;=QSXQ6:>NcC@71XDXDb4d09cfIVDSe61G[@)LY)(D3/XGL;:Y70+@
2>B4-/N>5T#Qd,97U=)HE&?QI#EK1WTggeNcfN+e)Q6@8JMPD8^OO4N:#0\>_1?F
I#?9M<gH0FS[BYZIH]+G5-R+feR/OQP4EE74UP6Nd[\JdX+@WH#HPOA9VE[.AV(W
)MdDb)3J4L#e(Lb00]^1C/aLH-@?ED^4^]g?]:9FA?&G5DX,J3;]JL3/.d[:N5E+
0<F43)QNN<bd6LGSB?.2JWK#:Eb;<,]P.Z:/#\Hg]33#7=N]NdcgUUgMJ.6a>>;;
GWGaNGTe\SUe(<;BJ=ROAHe@9ad<^F(97O1E^OK-?1EQ]?#4LDbXN<O@L^=J+OPN
Fg,8[WbOQ:]TL,A6L,]A1NAPFVbeJN/EBHB1/La5K3:/bbHe>]0^(;-4.;P7&&YC
(b\g.[e@BO[A?559XA\ZWN.ZM]S9NC)-WG=;99@:D6RJ>AF5Z;M/ggV0VP,0:5:U
A/:@K/S?L1G#Uc(L&&b6EE#C_)b,+:F?);Ia)^FU:MY1E-ZQ5QW+NAObBTO,Bf]b
H=:B+V_3MUD<dQ,[@M#PHZ&ff83]X4L>HX0OO4a+dN/,UKO0\-c4KD1FIM-95>6b
,-W@?H9EP^A=a(/ER@<H?[4I(5WN#WQ2:#=#@2b^B+T;<_[#2]4[P92RT2&fXg^4
2/)4e?bgKPB)WT)BR7J8aaKDe4@b.:@Be-QNIY=0HD6=:VI^SV8K\4[,E-\>.5aY
\_\CCA9_75?ff,VKI\#d9Nd.X^105Od^dI.[1<<];3eO6\bN+Z^eG>3B.Hb1]?^^
R6GBBI&\,6)FOZQfCOFUa==+8JW:F-TbCC05-/D-Y9N):;McJQ4YQUA&DA[[g-0?
1DTYL;P^cLV_IP.ebfBf++-2+.eN_?ZXKR4ac0L(Wb6NYW)g<e@.bM[g0UEgDV6Y
L3QURL7(CCQP@Q.AJP)#Bd1ZTd.#^9NNVP8XQ)45Z(L<Q7&,c:5_[b?Ig0LdB>0+
9Y0?\2:])CB]]Z&8=9IXVNZS+bYO+_ePY-]?RLG1:J86D>AF.#1NY/+RNK[OR;Ug
7X,NWeE=_)]a^=d)]2QHd:3:1G#)W</FWc=5&b&SR<MF1b\I<QYCWVM)7(L64D4&
?2#@W\,UE\?PN2F)+/6ZXXCYI)S#VHP^;dU9UUI)V>9JK8c>V1MGgba()CUO\Z-B
ZdB(Ja;CG^;I)BfBW:GdC?:P@]cUO.aJ#)Q[KLgZ=(4@:E^PdMQQM4+;QG&L>Z5B
-fW97P8.9OKU41TEW9dd-+#QK^&#\+KK4LWACW\Q1b^45L7c>YQ#B,?.(VR+E=DE
b/SX.5UCM1S(@1;^U0TcNT<dJ]5d\V(>#MHU2G\5TU)5=T-55J8U;/dCZ:bB3IHW
._.T_@>76TTE#IPaW?daa=@8dZV]ZTEa[(DMR/>PQe:c292[P\DW<?9f8XV.TPC1
[]+VSfUP]#A6bP@YOf1=IZQV<;6a^I-U,^^DJ-C4TAJ@6W4aZ:;J@D#gf(&+?F]H
cX-[M9>1R0MJAM,=@de+PG2K-PSdA=D5C3MH8[AeD:P3<(ASXH8>g=M5?3B[<Q-S
XK^g?9G#)P&H?a>P5--Kd:#>g>H#<+VYB=SPc7]5X@FKA?bLK<5R_@O]a-S<9O-a
YX@a>dC6R9]PZ6P[A-;I@Uf7NfPPfQT\Q10[C/>FP/ZA63[^Y+21)W__P>[c2;T3
QTD;@]b9@6H0-8(I\ZbM8IB^JAR7A2A9R@).ZO_6B[?9b6a73g[B+SF#H38c/NZN
+=)JaU@DXS]2TA_K8=-f\O,=#N0=G/cB?:eK#:4,90NPO.&FU[OW75;\K\4(+]@;
(ED1NFU?T@gSDfDb,LP>RVLZUFE#@[D24c&Z#D_-F9DC5/d?.9E9_CIWI\LbbB0,
:ZN2[E-S>gD2eb;JT5K(&N35O\Zg-.,&+ZHRaWVJ?0_Ig\gHVQdg^OK]O(.P:[C)
\]?.DgZ2ed\QgFH4bVSf^cY8XeSgV;J?DJb.U7A48EH7+G.0121XVE)ba,-PF^;L
2PZZ7@XA,MQ70N85]\c[g\VdNbPUQQY.aUBJK]+#:ED9:+\,;c1^NU+@TTW93V#2
EO@;U,OA:1U>HbA7g3M[a6RYOC)2-_YF3/@CN/.Je/-JG.#eDEUY-TCDI.]:D/F+
IACUfY#Y&c(V.#YG47DYG_WG4#VV5FE+774]bX<LPL=_TNZ[PF4U63LR2G8#FPY4
@#PG3&)a7:(]:Z?/_[dPA/ffZ\F8G;5-SJ.0^WJP5P^4AT^J\9\:+EH79+89R/&@
7_-ET;C]6MC:OPaQ@S+L4;]RFf&HTSHN:M2#Z18YTS,:FNIV=AP5,1HIb:2>E7A.
3_;?WEHN/[GYKA<<Z([XOgg3P)a6ZFNaOGOQ\0)>H#H+a/3=S)KOZOWbFb3JJbYG
TIL/gaP8AP-1IcHORL?V_6YBF@+V6E5VF&]:ePJM]=4\]e0c>3.CDEfPd4HJe[dT
#CHP^2D6:^N\L&ST84WEGcQb8aKcJ<C@?HEEEU2X/C,LXS;6WL=B3H(;aQCI?O,M
cf+Fb),MC--O>?MEHX93&FH@S0_Ff-)/>K.P[/PHTY\L^NgEA9aW3)(aPHH,_QD/
gE;b^OgLJaR;8d+.6GC,[Z]dAbD_J9\9B;A<00H&03aHaD30.Qf&&:?KU(2;PFH9
_g-=?J[:/QI()[3[4D296=Z]IZK2#LH_S\TIMcR4V=YJA?Q0cWbJ0&+;OUb#U@51
4TF<-X:+^:H-5aB,4CS&D#aRFHEHTMD&LP8XAS\B^Z7YQ/EbbT2+4O;D4:c?K/4C
>R#H]0QF_gXDIT\>S#E:4gDO3DW1fL@AC)HB,SeR]F2ZEQA&@.4]ZB2-cZ0C,[Qd
_THd-])UUOHe&bWg#]Q84].aN8_TZ&&S4JX\]GU4J#L&S.:a,Hc;f->-?c5PMIa0
/H0.M#G43YFK\efR:Q:N0IEUfb@,=9-;VO>C^V-Je2aVIMNEdH-PgF?T5#PG>NGQ
(7[K#.V\XD(K;FC7XXP_acFM>[A2]a]2[2DfcWdZ<=R0Q2Od.P(0eL1M<V-A&-AS
gL,AYY]3J5HV\6G=8Zg#gFI8a]194K^<-O&LM]Q&&7&6=g0S>JYfZ4X6E-\&VZ6#
&-.BO=_YO3M<SdA<R6]EIJ;B#BB:@MCMef_]F4bDO2e)>L;O2-L7@43]\a5K]OCM
_2\FT,:^8PK1KY4a8-4]9Q6C=DQF:[>MR#^9eQK\PL)FcPWU<6\M<P[DNfL>(N^\
<4XI_T0XFZ2?HCfYH2ecW,@.<d_G-6B?/EDbJ/,FH4_Z_GVA:58>>7D@14FOag#G
,E;_O.;bPeX42G&Z#,P:J/H)I<6f&=JL(;FdVa]G--TDPMU9_7X(gGJ5@,\X2W?8
gfC^HSVgJ&8GV&+FN[^@C-DS/^GJ@O7,6d0;6.US)Z+H=,0T.HN5R+IB/CUJEf]?
.[5MgM@dA.654)E_-:Y6c#HY/0-.Y])#GP2.59,#I9aeaW[R,_N/09AF5ZKQ59Kd
SKYR7?+&3P,XN[Q8)PDDS\=:.=f]UI[3+8N(Ic92A>.IaLTR&aNL[fAHPbN/N8/L
.NE+89SV#ef@^[QS0c&V[]ag?O<dVN+Z4ObVZW_:X6)g5MHL.YS-]A9EOF=dDDQU
RQOcX/YT[IB]4Y@ZK^O]Ec.ZQ2KQgDZ3eK1J+R+RgN(MCfV+S)aIZZ6L;Tc7\RPE
T&&0e-_Mf(4g?)b?c7[4N<a<RRgHQJK&)#Z[LcP<5G<):QDBeI@,Q06T>#GBE#Ca
.XGf(B)V@EQ-XBN>3>JY:[1?0TIg?ZJB4E_QIDc^4\EH^aJI67)QVKF^6Ie@)NVO
;QM@Y578LF]RTM/;_U5S<)46X>.VNd\XbL>?XP=A9M-9@Bb<_B9.=L\)2O1D,F>B
5^eWZ\>afYG,EI6Y9R4U9RG0P(RTHa=:Y+S^HH^5;C<S18.J#Z17FN>7W=M&K;47
8g)KbaB+gZ>F23ecXG\N&14;)Pc&_TYM1;b6K3Y#7>d.>X9Q<f3d\Q?O.7(BM=be
,1MX]9PcXF&LAWfS^dYZAbHdbDQA>(D@YK,2?F-2gAI^1P:\71321QG2K<fCQ8[N
JW>5:V>798?-&I9FLOGELE?dX/CQ(&@VXSXL0EC>\d/+>TDL>:&)_)9T-a]QJ=16
cPa95Z@<O]C]Q3P:UCf3GLQ<>c^+M=XXcQ?&>B0W#7F3R(##1c5NZPFTTJELGaPH
[3Ie>.T30K+QT2>,N5:Dc(OgBAdZSCRYEJ>NYF->6^6MY;LH(AKW(TA-@;U(Sc7#
]E(ESeKBLb[NQdLEVDTfELdR+H0_#eZ6cZ&BHA867Z2CH@QO1?-3O9#TD4fSe-[F
X4.5CSCg]R_\P72d)CGW.12@E;JZ^ZVDVR=GcMM>g_2+_F[W(W>:X,>,/ML(HFPV
MIP>>d719^D)Sd;Q69K</B(B@[Sd#MgG,JX:8_&cJZEQ@e&651\K<58?PfH;=)&_
@5]^6=2Zc4Bce0JZ;L8a/@D)0ZA?Q.I^\-H,@5=LN_d=BLd3C6:Z]g?(_@ES2fR@
2+;d/X_ggaAR6WYcZ2:KB[=(7^SWYOGWKFIAD(VFVJ5>7&O9H#.Y2YeDLHZAE425
]/<V1/c4eP/@1=81RT:XB(@X6ggNKb4BT7PTcH<0[<750dOZ(M6]RK[&4d:FW8[8
R]4)L,CYa_#>D#Ua?aV782()UJU>\@5gSL()^1K#T#;[M,JY6bZU2Rb]A9&MbKUc
HUG.HGO&Md,._9G3O(JVBf33)30@U^P82WCRQYYWXV^N7/ObW+BRHVeY:bA2SZ\6
:5@J2V,GM=eV..11:5]\20@?WBG-UO>Cf&4\8eWf:?L@U;OTNgY)c,M:V.]CN(b5
+7T\Vf\e4MKc3LWb7F?D#9gLIDI&-5OX8N/(-De+PcBe@[UP9;NH:B_&]>LC6E&6
<O(H./g&:Vedg#L:X8V2/.5TK5=102@QBS2Rf+MUI\Y#8LO/50?bac?M@YcYEXEU
EIJB3A]#ST;;N]+DbOX@F8,LNWcP8<C3JIS9]B2E]b?+XL<28M#:R9V->[Rc>.E>
eEdE0U>L8\QF23dJ[FbO5d)^?.(O-JOVAG@5HOG&dPX3^e>K8JU<9OR1)9;cc2dd
bZ,\O0c.XSJ3FQD)A(3fHX>9Z:Z>15T6S]]BO:#Ya=/S,\E,]Z,^H?gc&&P;)=2a
g/8Sc#VbA[_6P45bF6FZ.07[7WA[TH[?b&]<O&1^:((2-J,Q#66I^gX&DcKKMJDI
[J@D8I]>-W@RA0PB4]\/-VA+[gW[=f+],+BWXJHe@1)O+c^feU34J)(-0C/4M[D4
DYB<M)cLM8(bU2I-7<;ba5R^M.HYFKV-CM>>NFBc,O=ge,?Sd#91]_]3f,)S1E4F
9]I80bF<e3B1[8QHB3\LWFA^J,RMD\0A7E,Qfcc5M=-54F)XfK1<Y:WK1d\_NbU&
C)P5/Q;]TG)G+^W>:8/OQL(a&6L>I/M[],JAb9N](-MSJ\9@>D&WP>XG+]Uf7[O7
G)FYQ&PeJY]UYeJ.@W8PR;N+WW:V/G@^g31GYSCG<XBeMWUSB21MK-8Pcee[]8OM
1]a2P1U^D\^L[R5I5^@A4BAJA]XM>c9O;P:QB;X&+MC0?,EbB/?f\HD>7&V2gG^N
+234MDaL=]/O-V\HE3QQJGG&3LX+0>X40b2IEX_.JB6WLXTf/>^I@Ba[XFK^4#<=
US_(YAA9R3S-PGPYBgV(=JS@P3+X3^@04T+C?)^,JP)g-e<96[:-E@>TV@+8HQTa
.1W57E9]Y[N9YegYZDBSV3]Xd.ea4(K7>/#EWB/<<-RSZ=+<)OFE(->PTP]J07=]
N6bI@XTR;;=M+(S<3=FB9HB/CPX^JPgZXfWged<&+9aS:.-V7)OP/1@fQeBTYRa0
S5&OFKf5Ub@,;cMbOG^=#Q_:;OG#:fZe>?ACa)\>dZF3IH#O4&Q/CGQ75;BXb7[3
W(a>IZ=D6&O.>GHS^1a&]J+U]M;;>R64+[S<KUVagcE(YF7D[X:)f@_S],L(&YQ<
-a#IdYa[CFU,?:-KFAg]-T=b.\Q_\W:Db\7aIY<]_P:L1<E?XcDP;.<W6_A72d?a
P6)^Y]MTgOOg^G.Kc?PQb@5N7bHUYd91K<F>?P&/I=/BD.BOH=WPb&G=&\R>R</d
,166[9f+TI,O_H9O96N7>^0T:)V\CU^AWCdBB(;UBK]7ONPARR_GbM:gQP];fUZK
gDT.[Ye7L\7>5I>06]\(c>Bc+#EHcM_f08&1.-FU:bQCY09/b/JU=C1/WILf<SN&
-/Kf?TW-g-301bFVCLb701+F=dTG@SA&X-[0E<5<\^VD-Y9Wa,N,5SgF;Q<d\R5I
Fee>VHXA?g7ZZPL/F6XaPa)SV3OLN<?H;N.]2FN:T[Y.=BB_)6+e:-0<b&)P^AEO
#>[aU^UeQ<J&;gcE>+M)@NM\fOV-<.S,UY-d_:EFKILbW\_+eO<O^<5SV6bdIW;C
LG\]+7<]<UVGRA:JN#J-85VTP:=+KeWg&I\C2L-[5GX=\NAH]),E_;)(/858R+CL
W=IG7_9FK5e;2e^Z-QZ?R\X[Yf;)YKL9JX&?J<D]O5We3F4>,CB&;7[,F)=TKZAa
XZLe4<e5#90Ufe/[D)9\^gbE<HbC+CC>8ED]C=^1gLg(71H3/N8aE@RZ8>^=&-MW
KM,b5c1N02RaKC6b&G>Pa@4K>)\?T4(<OL&EL)-UX[\<GP9Q96gJ?B@-#2MCK+77
C4eKDBIYVSE@YCBf&_+L:C8=\,(M)S1ZAW9Db:TOQNfP.RB9OFYLb70F2LTC)P,@
U\Q-M&]SBP8c3_H?YQ(0[6P=#(3UU,KdQCd21.c+eVgG(D:P_G9SBa-88Y,-bL.g
9+:..AL840G>eK]JeE&P@_)P#=N=<=3.51^#QOQUK\/WPW?2;Y.]WX>T]C/7DRbP
Xad^GIWV+BDPW5_=,;Z&:[44+];&YVCT5P_RW]bb?Sa#N+H<6JE<K2b(V:V=9HGJ
U8g<Hb@J3GH76D&aMYZE.f4BfCW#IGIR=DB]WC\Na058cY@gA?aD&Ld0WW8RFAL[
A>1[F9)U2T^X:Ib[XVR2g68<0C9K2UHLR,@?(f7X6X1<:A.F?3?06aJHJLQdF:Ga
VBH)bH09?Z<)ZV,C[.48IdeWD_-8U+THNNF@<91GfB;8:I9TU5SYUQ:<6_Fa2NT=
?((K2F@JRXc5VFZS@S:PYAR04(L>3<QDAcA\QM.IAJ6G_F9[P3F2c_V(ZfZE_70b
/:J7LTBH_BZ<IN\U>5e?1PRK(Me\\WLMYaB@;G8(/[G#)F\O=.RSf=]28N5K&beg
V[O<QU-ZQDgIBN[.dgPYNC)=A>fC2O+._X8TK+S7(9XWO6HS,]cBf5HLYN1_(UE=
gcU=QJ/Y4C.ebAO0@g=fg<<AVe;^=:?eEDY0H[YbM)\4RWa<-&adMd\48P2FMZTK
A]L47RW7T#GJ5I-OK[D:K<2#ggFP08R<GgJWVWPZIAdAF)^&g(^#OAJa2X=9ZZCb
.0Re?&[AFa):bd=(8>X@=@Abc-W35YJ#;W4VW8)L.VLDDLN+OL_0+3b_APfILOWW
=JF>)[]./0RB?SH]CF:#LX+fPZUf=O)ZJZ#,f)&eJgNdJ<JP]1c(IU)LI5KM9MP)
YG,TaJ]5]CbNWc_B9[Z/A8DQP9/:-:XU/8WNK:Cb,R6=WAN#2K=&+[S)[;C>DNAA
X5OF,/S&c^g:8SO4.J.0=7H5S6H9I[E0(KEP1Y\5K:3EVK/g-3L>\9Z3T)5_DO/J
LKGQ+B@6]RY1_0OZDGd-F#\bRUD-@,5F;,<d_:F,@3R(b-9;0gW]=Jg89XE92,[9
&&M(^054@A<9,/ee@Q3eO@3666WT)<I+;PFK?/A-NB/c3bN>S>P;36P2AV6QP+]>
[OF=U(VK.ONZ1J^30;Y655NIYa#:EM44?cKECG6ZMN9]cD+Y6YXb,I_Y:c20&NI/
PMf\(P^B[\2N07I_]+GWF9,AUA?W&6LY-9]0gcbdZV=58;4CbJfVQG<2K<IJM-TX
D>SFQ]K)_J=:ZRR6XYJR&55d]=GIV@<c-Zaf=OB?4^W>[D34I),T^YEZgXF.a)Z3
/5Yb&:AT<GQQJ@P->R;\RF7-<g)D+#ELPCeGK[/-e9/]LPb@;/Ld8MaLf^)S;.P.
58)1=63Y2X>N\36ST=GK2gCJI[/3?(2d(E&W00JM#&&,TA5WL0=FJc_8Z&II\51N
-9X_AYQ-K@N+VdJ\;CH=caDR9M:LX\N;IOVQ&O-64P-^U3&@H/I<fR;PAJQHC((?
X,1WbAg^TLB^+=39H-DPPMU#JCSc:D25ZW]2#b:L93:eT3N8ab?6_W3=0XX3XB?W
[?JLdcWB\N6WN2[&YC:6+bc>4eH_6a@H2/.GUR6Zc?G/IbE:cd;FBMR6OQ)BeaHb
4-23O88cND9WdDERadU0F&N?4-CN,YTCKeV;)_ZfHZ3H]dWQF&F&1cF:KZLR5C2(
aKKPfU^V9TaMFE-Id?BcMEGJge.Z=,d5/,8G>8R:R9JKGB3d3S#df\Y\2]/\WbgN
a=;8E;2U^CS5>A&5-PC@\<Q@AB7-ES@U4/5:VG]RNT>,^?Nd<8HF<./D)^8Df<7-
A8,M=3.DL_)._)+#W(NJ>5bF64ENV^4VN/FeSV5LT#gJ1@K#CQ[=;aDS+=6b8P&J
QAK;;,K@(OG-IR&9,+>DR<\S/5d)Y?2VaP)FNd;EOa(&d^C8UDTU0a>VfggHEF&^
.J#=BU:;LU#<MOCRG:g1,e.5-LHdc<S.])RJ?g7\YR;PFI2(1_f=X/O2V7LO8fA1
C.T3:5,NA@I_BH#R@C>M_#D2AXcgFOI(38O2^c8U9ac)a(\9KRF@Q.a[A_0-9PKJ
MST<?8)R,5bF@FcPJLaXUDZ-@B.>;RLcNRQ6d6P_^+NC<?N6Q.Ib9]LUD-@]K-CP
6>g,VHg<V89:_S;g0)O>)-].;78cV;L4(4P0;1^)-I<@,:SDQ^27Y46@&C6)g]:;
Y_X6YNa;=aTTXQ(/4fY-+6C?AC+D_?)>Y6U2:dcUF4AG5D/DaU79@V7f=)f_@11L
N_Rd>;B;e@T,^8_6=Y7#E3KMTF=_-b)&7YMODY2M&d0_(WNHB@5E.K^)[fIJc;Z[
V[fcPH/KbSfU(TJID?WW7c_]>]TF-9PQXSd-@#gO[,U]ERE8ZGYRJK.,3J:6H:]5
?.7_1ROLPM)3@-4M,IgZaWgP].b=DB3+CYV7G.N2dJ?5F->I0NDULWQPS@0>?,,:
eOA0353XW1MGd<R:@g,&#1WQ_@<O1\/:+cLA@4=H&WV1fO9ST7d&BB-GS=Oa00,J
41M;_3)P&;MaS/C]\:V+HG^BU6S+0aXeZEW:4+9\AZWZfeYbXP@fWE2^8ZV4,E:4
@1:7Id:&d3T0C9Ld:^3\CfR3&F+?aRSLa7O.3X;@=IELA(IKCdBIdM,HF(;Vc?WT
[6SS,VGX=9.?a(^IC@CU@1d+NeTU#GCf.DY[L1+R?Ee@:/MX703PB5O+947;X_#N
KeB^RD-GZP1:XPe)PIfT5c_Q_>7a#F5XRa;PG^D.#.M.@KT31g(8#ZTe:_>Q;W?^
0E_CN5J.VGe;L1C(D#9eUC#RU8\fRRK^53?&c07Jf9PL<#ZSA\R3/]E(AGDJM_GX
9AQ1K7MaJ,e:^bCNa,XEgT&<eXCGSI&d0._MBZ.9]_6VFa-KBcBE+O_b[EZ1fZX/
]::H<RPe(6\A.Ud5F6K-QKHE>R-S]B;GW,+TWEAE;,,5S7,P;U78Jb)UNJdTZ^R[
9RY0/7BVK^Y_,16+15Pc_2FGbBL_Y8?I_GG7A9I)E8>L>fC#)DgO6g,^K]3[2;W4
=:0ESd,a4X#2RYK<SHgSMVKgAW@I-6(R#(3.O(F6>&BbSZ=F:LY/U>51)c^d9ZP)
LY^f8V&I467bA/_@^8H:+#1V[^:_PI:/PP=-bL:Lc_8(6XVT5A>6GT;ZbCE)BCac
42?&]dKUS(fb?1G+M);T+b#Sf=cUN]W#+#PaGBSOSFB0]GT6Z.G?c]=9LV)1ADgD
+M28QgQVM1;&aD]14PM5PA81/2CPGA6-F)>4VUI/;C77D\N&J:bD0ZSaW<[,;GY:
R^=Ic>)<de)Y.;H3RSU&J[_\HY=P.)2&OJ+8f+7XNWfZ[IYKJNcaV]+B7BGFFK#c
6JCAg^aP=(bC_:.928dbK1ZE^Qe[X8d0E8.T/(30A[W\)IfV:N:PE6Q6MXP7;fIc
N\N9U^b@M-#M[):##-IB_c=IJGe&_4L#M>V3c/E3+E&:7/LHYWdQXDAg8KEO_GO&
3/BL8?d(A]V&,O/P\1?g_aWDaGYR&P#>e2)2XTJ3H9NK?[KO=855C/ZK@NcKHf)B
_UG)BZ:4-gL=G\QbG54VB6&_cTVD7]O4OAK_6VLXN:EH]M/1>Z/YF2>F=dRcdX>N
B845A[I8Fa_0[396\QH-FI0IgK,=S:@RRU)d-#[[4US=d:5S/OI;@+g8U2cUM@S)
WcW,9J^(I[G-XLWCD6Jc)gAe<YMcIX<SU2&c7@+A/=4H8\HRAK(-56f]_g@4O[<,
@ODT+J3H5+g>,5MMPJ(gbR+4_bEf(WDBJ]gcKGT-]N4gG8XMBS5dOSIM@?bcS0,H
5AM-YT&L.=][W8gTea7dW2FS0d_[DWMQb__3^JDQU;_(BCae4-0OGY#&a5#DUK[@
:@R9XFg\CRNC4I9FXX6Ef36S^Q5PF2A[V_JC(c8<>c?Qe2#WE8D?a\8AYZ=SFF?a
DbHPMdfaVQgb4,@07#4[C=0E3W+:](8X_K^QK-R>KXV/<(UQfRUZa(KbR&Eae:\T
_E/Y/L<(:dW>Y<87:/FDFP8BAb^?WXK+\S40X^CZFH?]EN+CSb55#KJeBagLa),L
7SaaeJI6S1J9fGXAAQW36bN@1b]]6V>Q3f&QSX?U9,Kdbd2>XH)6N-LKb3UGWW[Y
Ud6bD)V^4:[TJEWRZ2_[g6R[2d^7+M).^]&EPEM/=N-H]SY/G(00]SN57I+7=P:-
cg3T^3GGfMUU2Xf/dP1U752^Q]O6^.KgNP-=&F:#+T;W4I^WI;?6R8<)IH]=gJDZ
U+,Mc(/[c)D4W191.U.<\9[7_HE@:+.ZGFXYV+==4&741[,OcHN.GTW89K+MCKE&
Y)^>=X]=Z,1Rb7+OHTZ_>>dMHR&a_cM;8G9[F?fS]\YKAL&;2,V0:0)JJ8I?.aXU
NabQ9HP=OEH/,_KYC)T)@fbC;,)KceD&8BIWK5:dA5/KG$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_S25FS_SDR_AC_CONFIGURATION_SV
