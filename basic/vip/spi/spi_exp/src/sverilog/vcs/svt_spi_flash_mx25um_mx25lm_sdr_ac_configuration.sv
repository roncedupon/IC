
`ifndef GUARD_SVT_SPI_FLASH_MX25UM_MX25LM_SDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MX25UM_MX25LM_SDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Macronix MX25UM/MX25LM device family in SDR mode.
 */
class svt_spi_flash_mx25um_mx25lm_sdr_ac_configuration extends svt_configuration;

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
  real tCH_OCTAL_Read_ns[];

  /**
   * Minimum Duration in ns for which Slave Select must be deasserted in
   * between Two Instruction sequence 
   */ 
  real tSHSL_ns[];

  /**
   * Data in Setup time
   */
  real tDVCH_ns[];

  /**
   * Data in Hold time
   */
  real tCHDX_ns[];

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
  `svt_vmm_data_new(svt_spi_flash_mx25um_mx25lm_sdr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_mx25um_mx25lm_sdr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mx25um_mx25lm_sdr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mx25um_mx25lm_sdr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_mx25um_mx25lm_sdr_ac_configuration.
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
  `vmm_typename(svt_spi_flash_mx25um_mx25lm_sdr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mx25um_mx25lm_sdr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
P,ET47<9?<e8>3C-W=KIDL5/);#ZAN<EXN3;BM\Ogd1Q;c4]K46F4)VBA?,d5#O1
)G<2fg8&+>-gd)f8e)QS-_=D)10V\8E=J\R6#:3??1Dd3EJX[c?6Ae0ZJZ0<-(d-
D<g[L/;\]:\YO^;8])9P_S+@+E)9Q^4X(AHMB#OdO^Na.?]&OQf;U5f2N?#VNSU\
VPNP9aBY)8bJa_IC2fJMND.;A#R8I->F0U.g2d(\/TR-0[SbYF.G=c:]fd/ACgg@
_aQ&cN2LB9H^Xb:5:;O9@(\\dOaR5OLE6[;APZ<K76C2(Gd68G@\c>-D<57#0T.f
dAYNf:(W8&c>d:?_D0#A/GG,J6>7P\f9.F?TY(]/#R7c;Xe@\,HM08IU(&L,//MK
?JC:+Zb&O\A)G2d7Mc-f&65LQa)_Ad;^3(6T(LN.>a5K/DYKF/AP;((V-J)6=?O-
C/(ZRGe<LV,5.C8P>VNC8;CEG,4?]c.3+0P?XWPU0gNE:e(&cI[gbd9eU=1ELU&J
JJC:_[>+0@\][C^4VU_O&,bV/]UCFQBH].LWKM+32YRcgd^VM6,,S/3gbgcM)LKX
REDH_7Q\1:>.>0+-F@Ia0/WV6R9TKO0_X+2R1fVZ5fg<B^1-;K3+IJ-SJKV,1P0/
gZ[HebRXU9f/IfU/VS?;^BG(H8f]DIBdDL?L/WGZ&=@]I\KP4K4>E&E8\b^&4)+-
\3NMN9PS49N.SW#4?Fc:0e[\cE7gHHeV)BKU@>0E96S=?4BSBe,b<,#SS-4=Z^=,
?U5.7A1WJNgII]/Cg,-6T2A-4LE^;;?BccY)G#g;dRI\H#)EL<FRFZOAVX]EPUC6U$
`endprotected


//vcs_vip_protect
`protected
[5:CT95LB9<GSFR;[,N<7>7E,<:&;:LW?TbZ[OZB&Y3(@;Z\?1)+4(/M1^43R2JA
,N5Z[de78QE]]b/[WSfCW3<8^4:[:8+^LK#U:dN^L/S0[,bWJX\9B_&4H\dN2cI>
F<Q2L)@0E&:.\HY68GcJBWW+fg-Af>&IB=&M5-d?I:P02e5R#MBIV9eVC0cAOI^\
CB?<41:D?&LCI<fO<M@?3M[OUD<=3#4#A.@\ON+G?Kf7E4&.97GeFf9?#L3VRK_&
.E#5,(f_LY&R0FP2,K3@Wd[+NF7SHBI<f\UDX@1_aM<Z&eJP9cRf,=50M7HJ7H.6
eFV\S;5<H3:FX9O,Y\aF^^DbCASIKM-;e23OW24],]fNT_MDa8SZfMAIX3Z\V2RM
>1b<WDg7[8^[BK)I8QNcO^KH7._VXRZ_cD31fW>,_\#N.L0W(9W:I\L.3KODbQU\
>bRF2<1bcU_=BNb@Ge;8)L:+VJ,VQYB-P]<GYD_@7<C)7]L+.?ZI9:\K+\W9X?:T
Y<c?e?3T5RI)2U?5#L5JB[:P^c;B?B)^3)B/+,bR.TKW(A-&1/=@=NO)V\(20eHS
7fg);L1AMF86da?(_BcP9G8+2^1T?SK9=MTLWG50[=,84(b@Y7RCU#3\@,2_5AY0
4[WV\0HfcfM]AM_\QC>Qe[d6+0WFe_\cD>F@]LB],ccF,?[+Z#WG4I+^MRM50N/5
#X8F2O7RR7=XT.S[e(W_PM8,(HSd7bF=;5##I^4X?[PSeDDHS^Z0P72\gIT/,L44
]b[\g\;J[c;H?R9;67c5(1R9e,R9+Hg>N=MMD-@,M>7c60/@F@P25Z,NDE66&Ef7
6VNH04Zg74+bX40OH4<fH86P4#.H9M991Oe=&RM[(fG?8(Z]-[A.d?HUbNDC5S>R
;I\\<8YSAI,+_f2)11(M63f6&C26(Z?V&gX?>Id@3MN>PGA:ZIOaed1:&_Kdc3Z(
:<b8V#<cb3/2E8PDW7E,(N7\86:g?,F^FOcge?6Hf,\,,;:9eVaW25;(Bag^&gfT
Z@<FL8GUT94PfR1>_V#,9M@M4387.2J\+cU^2d2SgY=8)_TWCFNQM9/g[K5OgWJG
2;[O4NJB-209fD,?C@:W@M@EA9OW<Y=RG9>0;_9\8cWcR4M7BAaIM9W;dCgJT_c0
=J5@?gYZFK-]VT@T##-]J\A2(a<GIJ?G;UN-WIR;A7A.CBZ,Da#LC:S//2BaGD[2
ZT&N=&WdY\a/U<NNbb/L@e)3A@JV0=:.-V(gJ);GYO)_f6^2^10(;/RUYd+cU3=A
61A]OE;QY(@Ac.6,4?eM-d8AcYY#c)?ZSS2S-Bd)(FMa(6_Oe?&2G9f_4a8[\/U8
N_[OI:X1&XLcOJbA4>[,(VH_L5^b#,Pc#60(TOVLI_]DQ]fW/T]A81(#ST@2_8:S
+B?LY(d/9I?CPE8<D>\7cbJcIE?,RHH\NaPBbMCgU@WddFd?Z^\MN?c1V-eJBIM(
,VT1Oef+N)D+e)4PWdB9X;YS4S3c;AA42X@a6LL&,46HW4.8JAX:?cdbTZd^>cFB
6\#S0.T,\XT)P)MLbQ,WND0DTT6M.Z=C=:=J^8A]H+GHXPU0Xc,aX3#@2;95=HFV
gfDdH\]gaOD8,1dTBL#;J#[aQdC7ZdbLW;0CM9Qb01QEcXJQ>Y(OWEXa6g5Q9=;c
][0+4AfdUOg@>f9C[:PDW/()E><^F8RSFPO.c@A7EY^^:1d3,T=L]1W@FO?1ZF\6
QHJ)V2a[ZZc/2+WX+gTPV,Xcg3fJ[U;A1W3e0WN7=b_U:KW)NV2?8^c@G6\bVc_H
bbY+82V8OO2]9#Ja8B<b&/9(1KW?\#EQeR.1V-ZfP:KC]4(/;1=E<S9RcDNd&FG[
H+N:I185]E[#dYSCVd.&7+c[);NGdN-6M&@ZW(2Kc9ab;g56D<IUD5G&/GG?ec>A
O_\A-A\3I5^\,&>P_>)^JB2OgfMH;RO=?MHX59JHMO>TT)5>7^X[,]OM8XgN](D/
O??5gg_H>TQ1PSX-<Va;_4\NIK-H,-E2G0AF+PeNPLFb^g5+>aMU,EZVdg7((AD-
dCXTKIELJe>K3c-@0E,dV5Qe\0ABaJ#J4T(<&UB)H7c]>M#&?]&afcNI&DX/0^Cb
d_XCP+(H#-XCQ,I6@XLEXVQ7:)8dVeZR\1-4=?=LXAfa#-L86Lf>[1):O4XaS(P&
AaCDK1P#P4^;aEMO7K)eU#gI27ZVe/e8UgeF2.&#LB5\G>&/.^JH@T:<;e4BYPSd
E4C(&^Z-(3N;21D1QG^>aaN4:OF8-K/\1&M6(e0[IK65W-=2RF&N3.b6A<\9>=Z2
#IAa&-;FAZ79H-QOWAVRE3)KK^RT3I(ON6bRP:&JO1Na@O)_dRdUZ\UJ-1B>F<X-
Y:==:7GdE8.;ef_F[:_7T.d,a+Aebc_aATVHTb#GIX9Df5_#-M?\I?)+]G&;_8CL
XbJ<1O:+W3;&1D?e6=NZD6=L<,5#e70+>cZfW;b:MI^FfE;Q82L;eF[NYdU]#T-W
gJWF_Q#bAdS1(J#FP<3E\WX[,eE0f6&&8;\)4,0[97QOd;D]f@#O);C;g1(22V5O
7Z_PW^QTNUW[7JJD/,R<@?+=0,P;d<M-WBP\bDC?gY@Yd]R&4P8+6QBf6ZF@N&]#
-,bK;^60W6^27?.WaGZDQ3:0:=<Q#>YJUGK9,]e2(L,VB9(?0XDR_T7CMV@H#OPW
Kg)J&W]D1;>W)B)=4()Zf/L>)(Af.97H>JWS;K=BaA:<D_N5A_BDP=PSXN(E3]&C
:dB7^CDWAWaLN+3+gUK1G.2/e;(&X@W/W[aI,Z@K32]GeP^)]c(6?3+QFULH6;-,
P5QUIP0fH<22>6_L+?>ORYFI=FSE)F=;d#JG-\U]IQF/GH[Qe)@JLU]XUHJdU@_g
WM.@YKdLcSY7NB:@\/G[2VXSef7XGXG/cd.SEEZT<+K,baQ;/2=C7Q7e;7RaDW2O
\g<B/fTfOZ@0T/H9e[@fNBGH&PY(DR7SfRI3T+:EHHWQ0V\d;/P:(U).aG,@UMF+
<?KOKXAQ02e[@0E-,XVZ.#51>dMBP47E8ca^6,0dAZ9[gbUNT;ZF+A^?X_LF=1N]
5<aPA#RgNYK)c&/W3.N1/R<N=6ZIeL(\DC)ZGI[cN]g4YR40)-0GFaZI49\@&C?d
>=4>f4[L]V<F/YKULZfegRZ)@<gC7dV3XJLdc6<GWRH@bM4AW(:,&BOf@cH.5)2-
GZQW@SC=([A1,?20Z<cV\ba;+UTO/eLL.S+V#PG0=YTe;d75>AF&4VQ0e[H;O:[4
AQg]]&#a8><4=C_fABCfR/f9\3.TZ:]/bNf@(XVd(D#555U[-1#?_ABJ?:]X#313
^VZ1+L\f85e?3U_V+5;TT;-?GJ)Y=6&O9-R(>BV71Xc8J+aXeO70<L5?3H+PNbYf
F<dObU2bG=;?1L^04+_V[bR0N(3AMfQT#-S,g;eKHM&a^?-#J1BZ.>](DZ1QMdP_
_O-_1J8ET28R[QR]b;W3JLcS]I6QP?a<,TL])ab#g;W0G6bG7J.C.^/-3\^S4Tf^
][,,g]LTgX.9O4(0Eae@I-MT6-.-L+W&JOJa1=6FD9EMdOH3f)P/Y40?+\1WOeG.
?fVeZ<I?>XMBMb-)R>QRFa7Z>a8b?#75U)cQ=QOURAH<]4We;[7VOR.P.F5@<Bca
E\:9F9;@7(B,[6@,O<Ce]c3<N_2eW9S8PACP@4A7<[+A(;W,d[UD4aNU?1)0[^T)
7JO\NVXgFNP[Me.I./C]]H5RPR;??c&CEZ+298T;DGV^=6O(g(5faSS.c753U7B4
.M)0cRKL\ga6:))4D^EMD=^K4VO<g50RgRWEeeL=RL.9#5)_TYLG5\[2K0/6[2&9
=<>8f:b.aO0\WM22;=QH+C1ALQZ@?\C(QU+AR)F31N?fI3B9(:N,N:UNT]FRfc.e
U^J1QbIJHBfX]a@V[/-Ng2d0DX8ScBT^B9W4-#e)f-5/@CT^&3f<FC_H/bXEW2&E
HMaHL9c,<;H?8DRP7].96NCB/,#1&X[geRI1>B6@<IL2.7&_QA/C,/gHYb9<LFH[
RC=,dVXH8ZZT,5FRT[JW^ZZW/N6M+R=^]5/\W<<-[8F[1CV\NI<e:6WEH[C7d=)4
IN.?FI)aPUND,G_-VC>FL?Ec2_EH:P)A0V&a_?C.-WOCDV[<&eN5B-bPJ9ST1LHB
(DW(U]e.B.#cfL-QZ+I<76?+?Z95G9Pa>.<BTUA?GP&g4)?NSKFYcCX^T)?3SQ^5
b1V;4?\U4EO:L6dT0:;4#4&H9-JSMXKb/5Z-a^P-ZNg&fc/[3.0:R/L,VQK8[#UG
]0MML#c/6RS-?6)G]2&11SQ&KC@#GW?dO2=^Q^XZT\PMXgT6M]_TORT8K<VR26UD
L8=f0-PCB,PY_H++_KYZ95OGZZUZOa.BW^\+];AT77@5dM:DVd>WCa]B&eDY5]?S
_9EP4^@@&dMgdJ>KDc26MY#Ne7N==?<?X1]+^@@XOZf-/T5g+]I0D[6TL9EQXWJ?
8=c5CLM^@J9@/K#&;.H\>2BPdY\A7b-OQ4BB@^0fWgR^^X#b4#2\#O-K)gQ1Yb_H
I63E#;4aI@VHAK;N_;#/Z]\L:P#RGa\,_FU20ed,\/N<_M\TR,VLP9.IG<Z([[N#
OQI[e&@<f6Kgg;IARa23Jb61A.Q.agEfAf;9\Lf@\5@7d^O-8)ZTX.+MX4NO2cL5
aLVC[BYX5]PUW8PP4]0&Z9E3@f[&JF-^J\I,7<fg.J8FP,]IMD(FS<3DX;eY+7bC
?FGFQQYf6bRCS9@G?RGKR=&ZX7aN&Z&68Eb]FZBEb[4.\LX@D55)^Jf#Xf8#^P6d
V7+I)I2&]XD2N;)Q>d,a]=@FO,>GKNFT^9XH4>+&@\XZ;S0)BaR\/7C[2cK_79dC
EJU.FH2O_QAUMZH)aS+R-fGf67,=_WD>d8L2b1.gVe(D[7=[]Q(8&dB/F)K9aHaU
_bA+B0Zbc1X2\S[0O61I\F/eF;AYZgbI&-Mf,_2[23K&<G>5I],5KP+;fIUPJWef
HQIX(UfS\L][KB/J-FQY?&Ag?&IAZ,,eAcVRDG=6H^0=bJ(f(WO82</T?6T[A-Wd
+J=NKQ9Y+^+;ZGW,0)PQ08USXZ[:#fFB=8Q)4R_K)?\7BY[0b^HE7V\UVV8Md&DM
5OCEIQ&FJ-WbX3\eZG,67J=-b9F@C3;2@3I,Y8VV.3507+KQ/X=P/d1:AQQd,V5&
<-AB#NUd\I9,V@5&3O:>WAXM8QN3)QY7fNbZZZ9IOc7QWSE[Q.?]=HJI565A1.-3
fW>//=I_4Pa+=ZWXDVc7<_XUP?<:QNU1,<]dg8A@a/cPP,I>X-Of\38FF3GFTSO:
NKSVS1MaOR?:46>R<3A(\Y<\[T&;5+WL6IefJ^^_DZ;Z&V=NOB(ETNRUT4YcZ;b[
f\f?:gWCf_L#CJJ,?Zd(KSXZ)3]6>a<K^g1T:,?(L^M@ULCQ8MZ4W?J25?1&4O40
+RLI4J+)#[A^E^:/JLR&MA1]@GCTB8?TQ47g14+B=Fe//_TN12>B@OF+,V&V9cS@
D7KA9F8OVZe6L_1X)fT/c/O?:3TDCRCS=dZ-a080GOdJNRI^W38:AA58_77RQV<>
&ZX)G=6\)/7g6=(5O+Q6AZZ/UY=d1914#LF32cF.O6::a-;O(6LLNN<,f3Z7ZC?;
Q9HgMR..P4^RD/>UK+#2VTC0O3?UeD,\<-E_C2@P[FC?NM2/g#S]9Pg:78Se4?-G
)H3/b,?g71],C&GMSRT.?GDI(aBO>>c/\0GaDKNA#dCEb^c1\+Ic&J(_VAcI_8AR
>5A[KMgDO?&c)2M)9.^\8:Yg=;8,PW+K8ZJfdg8\J=_G)c@K+U=)+IV?QaAdYdfW
gHY5[Ia>+I1^:D(-&6FG=TS9IIM?KTE4<S\SNBNFB/-OZ8^)U=XRVTa\0.>Z1f+P
/,KW^DGd&AKCcRA5H,5J6#BQFMU11HT>R75(MI?2A4D(?E94_=92QL1.?(GZ6=LC
YOY68]CR4U)EGKD[J5:3?>C0N1K&\Q5J9dMC3\7BJ0.=YGOQ,IVO=_#CST^/;-8c
Y=?U]5]dLTG\VVW2?FY@)&LS@80VIUAZEe\P_f)Y4,Wd3P_);/((-2R67:5T62RW
[5c3:OEBA_^G_V)])?IEZQMI?+.DX&I@L?,JSV&2NFGEWd1JfAJ5I=DR9B>2@20c
-UcWbT5C89&5DX+EFS/3.IS\8>KO;M?BTegDN(9^3c<VZN#[)gFC]1V3W.S<Gg.8
DAD(R>7&>6g9>:06dPS7BI5UJ/2KM2^gOS0X#]8/A+\&&K@gcR3_9UWPB.DKE@NZ
I0;dI6eM82P33fLff\0\+>D]CH-<PTG\0deb+D&YRe@O,)XX?GNd1ReAU6#F,a_N
Y<D7#3)E2\=g>Y=00DZGWL6C1gZ3.O:IEOe4NYCN#SCIO(\:[gG+;NH?N[47,3A3
?6I1G^AJa+TMcbc7)2HQ+:?JPdCcK&E?+@64;[5aLJI=5Q_&X]RGU2R0CTYc-2E_
6O@T9\6T<dMXL+IPUO@&/?0d:eBST=[A[04eM&^-B1ZcVUO1:J1(T3JVBW[PQOQ3
P9MF-QAc,@66f0>YQ<=8.5]\4?YEG=T1e#63=>1VA:d4[YLGS.?,-,@92NC2<#S#
B7^IQ([I6M3NWaATb;:R3(c14gX3VI3[,9WfZg54<[#J/a.T^-X2VT22)?=W=G]0
8d35O/&?M#_e0_I]FDJXcLb5G/V((H8<V8]?C/Y@VPc]4c,g;DgMe4GQFVc[^V[;
=R7>ES/cK.bbTZAQWbWQ=9D7S>P6RDUb_Q(J950;VeW4?_NL2DTAO)?cgC,deM-=
7=;.KZ<4??UI.Jgd#EF5):J^TP^d>X5Q>Q7SPR7Ae.11VVR]YTQ8,IJ[DP<8>g,.
@XOcBDfUEZN<=:-Z>EYPU^5#_+[W>DfeLV=#9gg)Q+f2AQFE:Y\BX2/HVO&Ze]Gc
-IJC&cJ;ZMO8J(:?_c)JIC0/S,bfVc3R9+_URFO?ScVc>2CI8<D([SU(Ic8Df+)B
CV;e^2M)R]bE3_QEB[fcR]K;_T.dgCV7b&cH1[?<8U,+I-((V^-^/@1/757S5>Zc
Oc+BGH=Q:VOBb0B4NCV4bF0JSddW;.dDcY18Z/eC=289E<9\_H>M^5RCY2bW\f8>
8E5Td8XUCC9^>EID)WUZE84Z;JUTPCH1]A<PPL8,Z04_EV0?_E@A-:BRe].fLWd<
<G8-76ZK85(G=QCH2,6I<U1R526Z2+6S3UG&1W[7?KXC.+EFe3\]F62>]SbUfcb@
MS1:f,TV#L-gg2aba]S?+L01?U<HfG#S[]2?+3?9O>7FcIM]DE:K.?^0<XO=40=,
SeCQM_U(cYP[_;3fKWO15<]A+_]3_R)];9_(<3;L&eY=TeK\gXO6Za6/D-^FA50L
957M#VG/H+^=XcV>geAS5I/B#W_2:aK-LFF^:@^L@f)AWBBIAS2L(9K-5S3_agU-
5W>FC.U(e6=[&O,^I_])\eWW-HBJe\:R>.^_[abP9TFe1MKQ6I@e9HZB+6((KBV^
FTH],-/:XD\eZKcF_P4GJ9:WHKA8)(AY0,VHYM^^-IAQa.9cN8(05;G/cQDTH2OK
?4aJ#PDX3V,_]7a&B:6@f:AL295/FYGN#RL7DN-,N94TM#/8XRPSVW9T/P3LZG:I
MJII,Y;]C>T-GX?40_83C(?8,BT)\_QU;0F4#XC0MHgU;(#d8\FN]7VOJ3;>AQMH
C5&TINa/(a@.8C=#,_=VZ<Y#=)3CFUXBE9\H\:XF0<6/VAa:.B5K>)SGAdS:RG1A
7I(G.SMF4gPJ:A9#=P;)^APE=;PGV8L6,8NN0U0UZBE:H[Q#J(FJbb:[@a41SB-g
&e]X)G95L:2H8AI^/^&La]a:4&<UDARGUBRL;M/=[^g\Pe0d\D01R7>f.R=dXf,g
M)cP[22aJIR0X7FfccXA40e.4_0edTX<:RTc);ZO():+),_UcBa@#2W/2#N=,+C:
N;Q]8SH<=W@Yd\@2FX]\17A].9c:cgbI,bL1V9@L(G\]IZ/_^\J94G>LM17,J-F+
>[>2HFTEN\M#;;#;;47DHU^OTeC_O=RW7IUNWb<:HQaNZEc\23K.[XVJ:b>)^6[5
@:bdG&-8)+YQ5IL+GW^@0YXH_P:AD0\I.AJ4&bceYeB>TAEcQV55>LMb60+[_M?^
N<HS@SCP)f(FKDQ0Z:a[5?Bc/^6Q,WKg.^H)MP:(g;GQ]2L+F+RQQP]5M3W^X#O)
J.c;c6Y<=;bN1)5&@F0aT?Y;_3J;T),,W5SQDVX_/;\a2&:_(^>:Td1ZL33TPU).
4LaDQI=g9?-QSe;LJTQ?TS;2fdJHF>G73BS]dOMWE(M3&B>+\@J/6RFX?BZJE>_G
Ga(=,\Ue-9.^8V>Y&1Y_)CfA:OR,7<)e]?S7S3S&R#:eCS@BECe>CJdXD&Q=.EB:
Z)^/4+U]J0^INV6D@UWJJ.2W(3QZ@=K@[YFU2TPD6aSaVb(M./,P?=C8?-??I03:
8fESH])\?(-(_P4(+gZ(/17H]433IZ5<LG)P4E5E\&SC520?R]S90#5LC&C[LdW,
F>G)^U)/Y?SRF:+1/<,QLZ&M5^OS[EPOfGPZgN6[95d4P?X60J2+\e7#U0[W/4+I
EW<@OYIP<Jf\SJY.SR/.^RX97XEIZKg+?O9G#\Z)9DCV:H-2##ccY.L@;fYKQ=fQ
T#,=+_E/<e)CXd)?H43e1SXTQBRU@c:\@98HT=THF8#[1;MJ;f@_\cV7?e;/[f[5
0gZZ0YWEF,BW/M]].,B/A;C]d6F4]-RGNM5_.]VG0K<\IM\J:3g=CBC[CZK:Pc2T
6)\,D@:[U,MdYHN56fRB;dUGB/@B)CJRMRWg>g.=82eM=G8(+/I<#cN52gC,,HNg
/9?dO<S.Ce7;7aHCJb25#SWAd6[1a]XG;P0KQM8Q3HV-E4JF=5^78GQ@[aIRaTU>
2[=RFEZU\cMF?[1</,/L&OVEWD?8[e,\<PIB]YB&XO>U@6)1R#-Pf@QWe](5II&-
.)M=;ZGJ;.bFFUX]C5GQ4&Qg]@&P7;]EOI+KU^T0\=N9fAJTX,OFIXJOIRK;K0[f
_@G<U>+&.J4H0U^UYS^M1P=B(VG9]>Lf@f)8Z_O[)768-BcP7T+AL5\W&8&RbIFU
N[DF5F<@&G<?1<+8C(<Re88_f^^A:M#aD66@CW6/-[,<NRKI-@CA#9DIcXT7?<3Z
;__,Pe1#RI_=@aN=_0.(\>eLE<L,[gF&NbQS42WF6)Id#V#2S&)MMZW[0S&b2TNS
5KBdV;e+2[.KBDQ67ZJIcRIGE<F+=#3+TJaB+gd51@_F3_@L]<6175V@?P1[#,8=
/\ACYZ2b]6,C<aD9P2V/IA+IGXBdE7[F@0<HAF^M6AIKN[ffE\PZbOE&-?[-N6e=
4T#bT&7\3@1N,_6?N-/6I8^-?JfFARTfGM)@/KBF1>(VfKGJgK;.e2SC.1_]:WVB
[[?f#F8G3#E1GT><=\cT6OX>IGUY9BZWTLS41?Jf;eVGTe#_1,7BPZ8,N=CQ:e>5
@K<<\9L.T\)I#@O0b?)58^6GI\;H,M@70Z&^SM<S30>E/,E_^BQ<1Me3G4P><P/8
=UcREHT)&?R_8=]Q\7>=G]]f-9\RZUgJ\&/=)T9H0(IL4MNX4&EQSNUT=#JTQQee
^)I,GQ9MAYJ8[3Y>/f@KO/Cg-M]#CKXPgPOYZNUSA?EX6<5>9H=]Zd;P]&,4)R+]
7V4D8.MY_LOH[gV7(7BTM\I)NE=#GD3[93[SD^D+80IQ+24DD,MQ?@T-HTgX8UK,
3SMcH1T,4JD4IAPfFB)_.H(?R2EY7RXGO&KV9bZ&A1fLSG;cV(9AV)a6(B)4=1E=
[.\,g^3e4&g+M[G<Z_gd3D&fa[I0V/&:9XKGBZDBG88V\](X(Wc18gdU,^B#1LOU
3fPGIR09B>V^1GH&KYW=VPT#&2._1Ve+fT(PX2N,CFCBC#B#31R1Yc<Z\ZN,&#a3
L5HO32Pa/^JG0-X^HIdNI+Sb[F[F;Q_-L3c4Da/6YMWOQ1;+0],:L=T1g8Q0^NdU
U0A]^HfQI75IOP-UR7)0:65WI86<O8dX1,QGRK^PXNCQ(g2-W@@\91BDbD)>K\51
1_/IXeJT.E^Yg_3^:VS.g@gWFDR(e(M=Y^H&EW_JX3D0CMQHQBY\_I+1C&PdO]_3
f;Q4Zf,fa24G3f#eTc)D,/<8YI=N<f3:FK;2EcB5a<TX,^,:&6KC?E?L-0(I](&\
#L>3f^[4T6dH2.JFDO+9c(89@@/=>ZZSJ716g/HYDZ^FXK2eE;.&O5^EcI-:90S^
Y/;OFB[9;80M]F-g[Y3X8QCZ2YUA5R^O:;&N.K]Q3?N4J76EAbGTT,?WQ(]..;QV
-5,/3T)RPN5J^V#be.;<<NPTX>/O0fZJ(@-J6b/JAEad6@4e1aD;_cQ==]X=0_f;
-B6ddX&))Hc,eU:1@bDV9eL=.dXg;&E_WY=Xgf]PDdRa4bH?<gP(>eL\:?6>e:-G
5U?@IA0GE(d@L13HT9<VQ,H7:7+Cb5BaF5^X>WEbDRVI5A6EFV]SdD>Y2DOb6cZf
T-K8>HE4YgSXP^]JHC,JA\1KSPXC.<L&MJN8fXE\:NE:>4UQTd74>_?W3L[^+:a?
=Y&TF\8B#Q)#=36_8O&@Y\I?YcBM:CMO);D^,E1eGV)UO<D=e<#4?J<\.DXeW8HN
?d&V-J0T_JPRSC#5ALM]#QY-d0-E<7DVb55IDbZ3[ZgE>W^G#CHW,#[b8:Y;2+XD
C+9FAP(_31FDYG:(DHHN&A=\IJdE/_S+E^AN.M<&G1@1;GB35\XX#JS=+_9G@GED
aP4K)-;M2D-W0^f0efG2g6>4JQ)>1E(<X#CLC+)@;0O3W-N++a<^?fa\,+^gfea1
b.0af(HaMY,4K18/J:K>b8YZE2M(F?dX(N3POcX),(f+cPJb=;,9?EZ&K6b3&I#?
aV(<^8M/OW_Yd4N7QE0(+D@@XdCe,a>e<&C90#RW+d18A0(+#/bA>-;YB<D>-:-Z
XUS5I1,TQ#7[QDXagRU7#+_Rc^BK@>B7d45/d>:-0(TfOP>T15_7OK5[=gBK[T(-
&2:DTdJ^?_6G)d8HX#bFK7)]<:PYCAX,4]IHM<)\.V9R?UdERGRf7D2Qf]U1<I3#
T8?D&PF56S_USLP^2-eAKbcdg:YcfREY]1F^58=0.f4=#[X)P59@RU9I0+5a6@.(
W>d)6Eb3@/)0^^M&SC.F;fZ5;N?[M65()/f=()g3g2F0,U\QP/9\U72#<OHVP,H\
[>]gLU153BB/f<gAOQ5?8CUOVUTUAQ.EY6S/Q)0NX@,4He:&4>DD2^cb/^^\O0HS
^]BLGHZ-__bG24=E:KJ?_;ePEFDacK@>L]B0)7L=A5@eVVbID#L>;-Y=_D^=]C9-
<[@^@;KO:R5&aGg/SHMAU@)TWM8(dRJ/db5QY&ZZ,(V(Y=MX8+a33>D,,ELcU;X+
K8<F[KF1SUc(ad:e]P@2:3?;]K[=YeMIHY75T[JOH7YEO=TLg+3P08>A4)0fbg\6
ZZ<=O[[/5((OU/NAJQ.[e:Vb?<5H:Z(Bc7b3WODa::7=#CX7[7\EF#=@JD9=JGO2
7,EO)Ce(3OQ1F\86&2J#g^-\_5.YWb3(S7aTGKeZge+)cg\^#3:Fd1_dK8H8QW+G
ZK;U:_?F+@],fW0K\2Y\+UB\+FB&@9[3EHJf3)[DdbRf5P,DC;,,Fg^BKU4T/:-V
e4M#ZMQYZ)9gW7,a):g[3#B,PQ@-,)]bf.WdNfJSA]>FPb#]HVJNJEW/]3g#9T3V
@0U:SeA9+#FN3b/0U\SL._<g+>fNT26dLOD:1)E<U,Kdd,VAf]H4f\0.5A@)P=]#
7K&Q+@E\7EQ.bP#4\#G8:8YJ-:ZMAW?2CD.F>b-^g2dI=FT=\2/OPRDC\^:9g1GZ
JOaUZ8.,^95HeGFgR2LB8[0OVU&bAP35U13UP^HLX:.RU_#A9&J#P0WT+Q#3?Z)+
^/=W)#X>@K?DXHFHKbVC+VdM]FIZA]\aZ/FaG;afW_QO:aYd((Zd.g\3,LELVg>/
95d]A;+@(::NX.B?CWG]=E04&YFFD8S5<8X>IQ/ASGc81dT5?d9?0#b<CNMF^7W7
cNT00Q]Y#<eOea]5:_P^P@:N(W^M]ReUJ(=]a:V_5O(\1(VN/McN6&,G:EB=3:]U
fA>:#4-X6[DP\QL(>bB>V<8?&(U9ONF@YS4=4@G\=580#c;T6g,U7Y0PT,B.F5?A
UeE;)0O<a]H0VcfdUFSENX,_gW4;-H>SAfCJe^0.UL^[VC0Uc4,PP5b4(DKYF+d&
.([,&ID[@P8[^H8K7Q,cH-a,3DX.c0,1b6]ZVW<X<K7:L-QF;5BB.^DW.6Tf9abZ
WFJ4SNf;Bb)fFcWdN/R@,7.);1.>(]3=EA-&BbH[KETQ?:PU@:N8=/LFB\I)bJJ,
QXb>\/E3VR-0+=7d8_:\a3[CGDP<G&4>[P>4F9]9/dW^d&Y8AS90VNRLLg?_\B-f
1+@L?18^g>FPf,<LN#6&@b..R1fO7(]N6XN>g[(&#K&UU:/f/7e6F_F1cg,4WHag
gV-XA0H#IVHac][PF[=BU0gYQ^3YG(S?@FRJ?X_dV&7GRXcM4?+DMZ-;.dNQc+OU
e]XQ,8dESEZ[HcP-.,5T#Q+5^&RYK(-5:9/ANZ-W4U4C)Ag_JV3[UW),-6b_NG+6
D<,]C]eY37-&2^MLO+O\/b[Kb<A+P11L@PHIIK9@SNX@[4KM=)SIda]ER)KLVC:_
R+\b(eMVWL&6[7,R^Z9bV(0NW&UETAa19-/e9EOHBI00SUAfF?HUE3/7d8@,4Q4?
PYcMO[aKLLZUO8@T;,828BVbDHd5OPN[ZXfcKO(Q0-_7QfA),XV08DYOIJUPF8TC
@]O;T<6ETe;81Q^[U81NLR@c^9X/Bg/_f6^Y([7MgZCS6[)CGE86&P)eRb[<0)OA
OHIgCV?:bDOXB^<Lb?^#fR;ZI>YQ]DLGPNK&]DR(0E?.5Y.dJ49M]GLM+fb=R8=(
Z/aG=FM0\EW4.eJ735b(IL>eRB7]bg[eEd<Z5BKcIY^&-?7cWA#ALdG(?UO8J3C,
OIX>UIO;>]>TE6&SL2-S=L^dGGZ2_Y65M5cd,U[LUYTAZcQN4MH#&B]F:&UJ?GO6
:M?Y+5)cQ)-OTFg(:YN0XRJGYHQX<-BCM/JdY\H<@;=f^AU=>B=2MC3LJ_4NH#GH
U.aS)9D:DH\[R3T[DG+5HG+f)U=\g;&O=F2VKE0DZ00]OF-W]UY4]RS3V[)\07.g
Q[P7[OG>aa+CH=_9PO^V,F5g+QUY6Yf^AUbNTLGW1=:d.eA_K0.bW3QH^b:I6a3@
IPX>NfT,@W#RG=G3df)>c9?@DIR<K1(4(aRE4IKIaL<Ue#R)9<;0EE7b/@LIRd12
^7@YSd6K>\5+Y0ZP7^T(.AJ^I[CaWVWG\/-TSBU8LNQS\AT;cER9.CYW-fd85QD<
B?H9#S8_+C9c(d?Xb1[M/8I>gC4E/e:D1WKDeD.f]De+3\0,HBY?.8cWdZEHAdA7
Na3HL&b4a=gD,beQZ]dBd#/b&Pf\1+g>)2Cb.Mg0:Ce&eWR<31_[>0F&[gH1C1CQ
RaObRO;.[#Q?H0[cW9/(cSV?I=)3[(EZQ;5@JXRH[bbOE5U\3K54JAGIT^78>9U,
ca0R&>UR3EDYA0+SaFG2_+c-:fKH4;16MSgM,e6TIdKaQ[W9E4V,a.LffZ?0(906
<NCK0-6]3A1O4U<XVI0E.D46_V+T\)cC/6D;W)&BDV#eUe</:G_TQL7UDV\QUcH6
SeG)@a#R<+PX989Ugf-5K5XTaS7SD(/a4^JQD/HebEMW6#[L,U]8+?W8:0P=>W,&
&^ULcLM(_gUHHI/g</D^TIMTO)61-9E,ED-0GI\H8W/QM0#5A+W2Q4),c^-\G?H1
QaM@Bd)1f&2F>WMaN>0gXHN7Dg3CS_?6[7b.7WCPP5bSM?Q?2G0@VRf.4Kd6VUK=
)3H3/8B7MS<^Vg1_YVf6UCOJ1PPEZ((4Z>>Z\FL,N2Vd#-?-T>e>N?\g3LLBRJ6\
<4eQ(<896>F&gL/HP,eR,UeU^G#bX.6(/#M(f&Q]d1-dDTg_U(IVVAYVF7,_9-KK
3W5@U\P/KDQ\6C?&QCM+EZ5HMK>Zf8)(PRBF#[bLd8AYa+0=aD?bE9<[G^acW;=e
Gb+=QZbF=I;]7cc3g]=@J1g)Cb\+eVNMNO)&S8XT5>HOWDJOGTcJ>R)R:=,6K/&/
#SPUFG>6:/YHH^I&ceUL48,SBc/FGLA0B<Q0(+.dQMAY1Ca+.:J>0Ge=4?^+A4K1
17e8d3T4\U2cV23C2P#EXc#N9B\.2_]9?_SHE7A:Q.206UGbfTF0XD,5&;);7Z82
_R(dJSaSN\20^8SP[GY2]Y/.DO?egB3^S0YfDdZ1#/2G++ZQ:(gI-BEMJ#0f2DN@
[<d?Y\@7+V\0Gdf,GA-MLH;#ZdcP;gA^/BdbF,JWf\G#.d&HB\g]I65M+77N#(HL
4Xge@&Y>OXe7Q[gBJY_2OSQ4VU>B/BWS7+F-AZ0U-65L1L.LY5Pb?Z<HfS0Jg9cV
-OCCb[C-];U/?GB6WB9bBK#eTJBD]6,AE#LFH:7.C#4[<YWddZfIA:+((Z9E0We#
Y_R7++gag[I4;fU@F:@7&/)J/0T1.WHJ/=Oe4b>JXUPK;?.5ee?IIJ_@O=g:MF:8
_3fA3;b/DDa44=c0IS#1>L_<A7G(1SQ)cKfKA+-ESQ0aOX#)W(^2BRaJ@:BObR&@
e98O&T:)0&94V>Y24cLcI6N3+OgfQfJ9YC2A&FP45(UC[(@KDQQ_4;7f3KIV,);=
>Ed2V9)N-9??GY]K?.1c>Pd_a42)((D])U5_\<5WJ;8Qab94G\6+PVWPT)&#.]JC
AV2N7)c=UVbND?SM,HL@WdIfcdWC6OHWKJ2dWWA=c<7B;c3S;-77?CPH_d/eJ@>C
Pc_(XZUJ(<WI4ba9TBVfBE3N8\6(7?H#8AXSgMcSdg]/fa;I.ZMC:O@K2P_JH9/=
4U:F#U,e8Q4gR.TSSG;@]cRTG49N5e#Z8,>deJ8Lb1\29Y3[,DES6LP)XMAWe;aX
N))_PSQGX<QEd19Bg6a\A5eR=.9&b/_7c_aI&cDA8ZYP?XJfT_PHgfMEME71II_;
8>BYP>a3#]T&3^AdJDOI89>R\JRGI7aLKT/9AG^9O3?7K3QX0[2@+Z:E/\F-LD=H
+8c-&3<+BR_8R4:;Ga,5XBBX&JDMJ6g_da5JJdB<cI+ZI,I\-+[(;LgOVF<RMI;R
^Ed5]<8cg,[ce6WZMV\X-Jg_\7GcUc.,=\A\;RB.TLO<_M?#7KRY2K(5LNG=52HQ
OY3]e&(8AD&21;OU(=R42fAQ^0AYOC)I&U7_#S/XP8S?AgWBTNMKA+:@IBDQC5+R
?2.,8d9A,gg[2VCeWPZD8DK2T8R<E>D^DU]EGXC@AC/(cAO86)3gH:C/,@+b-f;f
0V1X\XAGc<[,###dEZ=FRB:CIQ+@EFCC]]cMM;Ie0:?Q9@Gd977N7KUS>Cc2A-^b
f&1PRV7Aa_HITPGf89^(L7d43RKV9T6>_,4A?;G\DE3dI2AB1BUOB##U+ST#_4cV
aRMFKORP,UHXd-??35#[6\NI.f98XL@JJC?.1+LV2.),<^HUcDMgBWT0?T^P9Gga
PVX/J@cd^dcF^\..c0PWTQ,Y27gSd08X7F5<?19R]\gIGMOf1^4EPVZ7@HO8#)05
X.C6W,Za/BXE^<Eb9B5P>QUV=Eg;0ST&DP^Y54.L/fb#YT&[a^BU4[bOH5J1]010
D5NPFP3eLeP_FTbYW.d]d+?F77(dIR-fa\Xe:]E@5#@W)<:PdO5eI>C/NdPSO2:1
:19Pe4W:=@=M.35d?.L8Q:^bKLW3:BH&_&=B\^-1F>W1&b3OLe;]))5/U@TPe_bU
c/.c#8<eHX,Y6.#5W)V5T:]::Q3fI/N=JY[+IDVAfaO9XDE3cGfFYG&#_=3fe#Pd
I\W^44?LK;(<XJYQ0]GfBQTAFOX,Q56S<]/OfF=3.V-1E2PI7D6DSaHV2UPTQL/6
E-[>W6BE54N=7936/ZF&U8Zd+YKM3^gJNV08Ba[,=HJ#4;H-cbB3d@6(XY6PCEG.
2W+&:V7^K.\._=Z6WCN.DB/:a)TYbUGKH0A4KZ=[_S81#Lf2\FOE;=.^6<f&IN2\
0C7<7L&SVL+Q7TeR31+:+<8d0D87Ae>O[g3:K/cVB(U<==_=VP\P57+<4[HeN@X>
2SW+V>3A41P_B6D]LE]US.5>]O5JW&g58.])DbN#>2-BK,4H^.c3HYeW[_:Z3O_J
?\3J:fO=(+L<-1J8CAZ;68a^e.I?fCXT3BXf)SgJ;8#ELf^a:D:#:=[J3K:Da9-2
07ad1f;1LV+F=>.7aOIb5P9=GDY+Z--gMQS.)IT?b<LEa:,f+NQJ6f2H>FT=ADPT
E_#?4O3[]FDPOU8eFY:YM[3UMW21&9X#8FVO4?<<@S\(I,;_<;_V4Q4ZCJVg/)9N
_KE?ceH@fHeDD#OJ:?dDbH\WF:64EFE]f,bc4eKC\f@8@6d7PK7A;A3#Ffd?XCK4
(59MdeA05QaF1GP2_:cTAaGLT.U-437B=YUG>K:P90CP/G.&HgCWP3I(U808PHe3
G5AIGc.S/<Lg&GR(GZ/4@1a>2NKVDfc<GB<A-9/-M[KHSJ,O3?)B1:B9<V4B&D-K
7#EL<P0I+7g4NPO<EE2g8]2,@Ca\K>8L=DEf7ZYNOB=A<\BW_)^F0JJOT.-I;-E=
5A@5.;2<@):?FIVLQFSM,bGWK,U^6F@35#E?4M6O=CASYF)M;AV:P911#>&XUT8Z
[+7Y].YFT:=#)HVQE#7B_:1-V=Od;C2NX&:/<\H^R)8_D[ScDI4^<)gC;P4Gd4[D
HRK2O#(2.5#;U2cE/GOA-c#?#D.2AMQ9,8VbQZae.[JVVV^XV3QPQ#CSC@c/L;R_
^/-J6FB_H]fQCT0-d(F1R0.ZJ8&D,H9JTW:A0VA&DU@JgJeG;V^4&(?9U6W2,\)?
@+4b92-W@ZOW_KWUZCMfJ,cL\@OZT(YV0@-[1PWE.9a,U4#ULME=JT3/@I2E-Wd9
.9MEPI&F\fe;b4g:^VbN8PO]T+9B&&LVZ0cA2TC.aX0:+Z&1#SW\F3X8g1c7@_:0
9=)YAe:SZ]KD<f_1Y3,gbGBe#L&Y?P^PLcI22X-0A\):Z2S\T0P0OCG9TE.fP&-3
P>_9.GLb.A1]53,>C<6DcTHY6d3_W,W;Xaf([U>-1GgL;Wg-<DDP<g=6HA2E@KcE
>J#E:)Q/S=JOabU:\D?V8_09C8\=C(1?1X\?Rg,_B:a0.W\]<;5[f7YJ]M[)#4UY
[a1T]=F;0(I]F08;)5I(+\N]RSGW.>Y<:VV#I3)IQ:TLQ1X_c0b(SLMeJ@Og]f@8
F9A]<2[V\<0ObE3N(E7[<=O)LQQY<CT=U9>:CYc18OS>B].X9fFPdDBd>;O<O317
Z3&>+X-W&fecM.]Fc)JTRHHe[OJa>YZHHS<T4fH4=R^;C-2W#NA7T:OVSD^&M1_8
(B6dV@67X4H9/9@.:I&]4Z\_Nc_?-3b[PcFX]1ee.<@/Lf3fZZf0<1OE--GP#6#f
;273fDHZU=R,>?8dU4&-4H8)=?;cH(IWOY@X+ADZd=8f01XM9_Q_-378?M:4e<@]
GU<R[9)XTgA(WV4G7PaXOeRT@/><eNGHKe;]P?-#1U7B?3ARU>EYe(?RRWe@>_dF
_-.?8CH6OeT_]]N;.f_+..^K5_25BR5G[1I+5:JD9U4OJ)5M(:53W/\LUf:/G-@D
;5GW1U\#^IQRX7;HPf>-FU1#IEV&QeaDc)8.LAdd]5J8_QUYZ,^YSa@g6+8C)(JE
=O.g>7M7VgdYNRDU80I/;J?JR=(K1ee98?M[@MC;<CVTT2+=&:ZF0SC4;M-#?KaF
\<[3e>S2-#H0ZZX4&YVCIg^H)3JQI2;N8\E1]W)E.E3EReE^USDc_/S\QV>&Q4+8
+@dL)_aTXGBETQS;9J586KEf^:dMd@G:aCCX.@&Q1P1B::4V3W1H2H:Db].XOcKD
bD)4dM+dBJ.dH\^K5)2VH4_PbEI-gW4I1WVCbN)Y.Y\OSc#Z/J^aGQ^g0@((#=#_
[=RK,R_f=;eS^L2=>IIVL<6[/ga^078>LVMYV,Bf<@_40-8\+Bdc3D7JAR6LE[bf
(gf92ZA5;2ZDW+NageM;2=^/5CWXZ7^(bJJ7X;#/PTY6>1d:O?FYG[N7>(,bQd7?
[Ra7gd\E2>[W+_3NZZ<VY0>gFC)#1WQ=E:WbZ4O,>b=,=+5FAQa@@g):9cb0);Ud
[3.O6OAEIbGJBS7b.CL/<#>M:8S+52CRZJ;I3QAJD0&E)8^a0.,5>M&d?\a)#:D-
^gEXX_6[7@_?-NNPU+<A7NI=EFe/DUMPQ85VX#&/aYaXO6Z,Zg=<-cgN-YWC84E,
,2ZZ-+0A5e>\>&SK4g\&g2-XDgMWV:dUaNU]aIVE7.(W4H5eQ]]gX])7<P_Mc_KI
E3&Ac/[O=ZWFA@VT-a,SNcf)WMM.@-b,3M:I5S1U7[]UQNHe7(-XYJK\ZROQ#1(S
6_-<O2&c:+9,C?V@H59gZEb;^+\4++?GTZVc]+Z1<bYY[)L9QO)2-F,-;/b#&1CB
H)bK=V=2/f.e^SJaEe-]SB51LgE8H7)DA2.K6JMQ6DP^YX4EK81g++:eJKQM5C-8
Va5)?,;J5:KgVNK+[=@:JWWbJ.,L?77EINS,OMQ2:afDc[[^c[1BM^Y19OE<&E6&
#bVIN?0>L4UGXH1cR@P>.;6=/c6B)EHC?-81?62_04)KU/#]J?8:dE2PT2cCC?6d
I0\JR7Z>M/)Z.J?cL@DFD7B[HZ/H)aI^44F0gJ2J-S14E_bG0cBSH\Tg943)M)0B
:L[7W,@#ZY_G#@XR#=BU6UN2GM^CV8\C(J-_>^9g_J/YR;GDfdc,OM1J2aQ;dP2K
;X4_\0X0#Ab<)DJ5<NDE>Ub[b#T3./H6g]=fbVFY\-Udf[Z7f==FU)RWeVV>J-Gf
:9&A0ZfMH(R0NW&P0eI/T,86^S[e8Q^5?#0\+M.0O2;:L\dKY4Fd9=)_NL7dD-aU
>Xb2S-D]/\fU1<M]&CM=0.dRADZM2(-=NZPN.J\_FE8D+69L=cH.=aVaQE1G0&(3
1.43)\Gfa<KS+@SMNI=V5XU@/+PAL(_)Fd,b43VMYaS_W_<9R0ce>5]-\0(TOd8-
Xe1fN_fG)DRE<;@.)[Bf5809Q<F2SO^5dG;#\F)]7<c0>P;)Y5[[+AK[3E/03KOO
=;@ZgCI(>c)3O)ST1T#_J==Z3&-CHK8C\DFA_EccW+NE_Fe?I]4DZ1E(+N;-,T27
P@P-4QT&R:VRN[B_>+gVZ2.J2/^+e?.YB@9g[S\.Zb5SQOGUU/bc+?:OL5(W;b?(
_9W2LE89I=3VYH+]gNgDX/0UF^AL;SJM37DSc0SLS.EFNF98b?^cZG@\+\g5BW81
g>E3#OQdI42&A7M8c-^DO@><Ebd,_;fHKE3)#4Y7b\)BO0I4Z79B);g0gH3TY,/3
[AY>aK@ZV6@Y\FX]1LIK?\=L\cPF(:0.P7gNUE7)STS@8:H23>C]SUM^fEOM;;U2
63@XIXB,K\-[,;,]U@<6T4?NJ=+Z]>#]CD]\5Uc6:5RLJf55X-V]:D,1G8#XQ1SU
A7C\fX+(]4SR0UKID(7DL=#:#LXeBX7_ZEZA?36d]S.6MGFf0f./P;A]8[-40dFd
[:TVT4W]d5fR(WI1>^N(Z-:4XB4R;:##dK?4G\C03-gG+L/84BEOWR-6YXI_fNWQ
QETXAZ<F)#L3TXP^M[@^>:fSUJfgT+O^Q2K,U&)ZL#PWBgCf:bR33PIR<):NBM7-
GI@581;9f;0c5/Ad;E&b7Q@-RKTILN2@NM-ODOg-_,9L^;ZgbRLAAT^7-_H9QS(O
+1]c4cR@U2#1Z>_:)5eQ2H+@)38Q?LGbb075(e7S;YG&).eLCBg371?0,[RU.AX,
+WCb_MXNEU4a=]bZ7e3[J:YYEfHfT_^09H-]_QI<PIW=NQYA:SM1T<9FVU.O3,a5
Ja?(.UH;@FJg/K>&f)KH4IV@/STL/@[IUX57\WN-+Zd/DS\_80d?\897O9=T>cd-
e-YeNET4G4A[M#dI+4:7XBeW3XPLa+eU;D?>aOM7Hf[EIRXQLXS.&)F.?AK#F<6/
0Ng@8UP7egKaKS=I+],dTGQ+3Eg0LKL&)<NK8AUc9,X;;<\##fWHW6BD&FMHAYD#
Ag6L<]N<XEVZeBa8>H.SQ8)fRTXb6_2)HMfW@:;ZH>KI5A@ZAJfW.0,O4BMSe\I:
C5)C>#KdK(gM^ME5R82aa\a3_1-L-_&7[87L,O]>3>e>R9@D-[S\F_D7.S#YYK2e
.@/b,Mc.]POY/Cd)\AVJ[UId,2.HbHUX3JZ<ZCY@1D<K16eLdHBV;MB9D4IcI^,+
7Z#QSPA(eQW9^G]\H8VNg1f4,Hg+2L,=b#2A:+Q=:2&ed0TL1bI-?)O:V5HgT5=U
\FRA8[.,+K4-#3:D?M0)IOQD9S@f2C5^=D_(C#/F]G@V>F<68Eb.#^E]@<cF[<Pf
9QN-SZg)Q7VgR&Lbf_OG?.;9gg?^5d4&M1(a@>)e1,U3]8XJ]XD3:0F]N1XBK6]d
TH]=B6afSGOWW(<7<2ZEPcgP5Ad8O_LJSE]Pbg;B\52#4XU)T[8fC#J+2UF2/[:;
,AC=fL/FT8U#E^f&77--_J1YOL7b9O.RIZXd3^fPI,X2VN6[O43)HcIb=gA@<1]?
(Nb=\a#CcY6fH/N:+@c,^8]3V_BR+NQ^#4CT?(eU=\=P)\@EdMG(5OIU5e,P)IIc
UUF9/_DR1C-N1QB,]PNHYQ([5f[96#D3IS>(P0VVZ3_7->._[XQLUFH-db^aEU4F
CD:)WF@9;J-&fHHDOQJ7Jc#bE(9X@P=X&)#Q^TWf5\e9B:#<R42Z&.?O47<S]X(Y
;[-G>;]40O)g93-_9OYef0H-1];_11AQRRTY.6?_M0Q.cEeV>^DJ42K>T-,;]JAB
(YS^A<IPMZ-[6GK;_<^QU@29bQ^3N+_2fSDL,09AH,9NQ3]dcAd\L5^1I.g2L,^D
,bbXFU_#U(7V?FPaLg6NC1TR_2/,_#A_e1AAa&NP)IPN;U?Y-CdZ>IF9UNR@H=gZ
/RLK2](Z-5ICd0>ZV:5)\#X1-S\Aa8LYL.LV77-1_W-/(3,YbbQU,FP@8H/D-)+Z
/XL;Q0?A@RJLF3Od^CINV)fADcC-?dfeWe?>ce.&d7:D@KfU.<43c#]VHeWG()CW
/R@?WHB/->+2_#XJ_b6U+F]eD>YgW-5&9(K[M.C7.J=b#Y/LcP09#@5(.@WTNQ,Y
(eeIUQ#T3OG<23Z5?Be^RZGZg[e6;K]IfX)XUD5GHdJB^4T6Ng[-5&(92FB>9JL+
=&3@a]]IM2]G/X70;G.CLKf@:GT:_1b1=IRH,OSZ_MT8Qc4Y<?H2I>a7YXXI/-Te
G2Rc\GF&LB=3d2b<bQV>GI[)fX0bL6EgL0JN=^Wf]8ga=>A<JfT-1Va=?KQS6+5]
8A>OB(=Pe:&FgFZVL?CK&E&[e_(aeS&>:LZDU<E2Q_b\2_LO\J9F:e1)(e1/^_8M
_dZAK;;)UX5)3cB8Y-?8Z#J>_eYcLQ)b>[2K;1X#PUE&==1Z^T44MO3Sc4E7CK=[
5H)g6da:O&V;FeI<c@RcI84-GH56ZAc(B<F7YfK5H3:N1K@CJc4HOQ^7dY^Ge:9b
(?Pg\ecQ^85>-<dGP1O+O.0JD<SbB<bW4KNU_C#HIdL9@UVE^eFWgN:SXL@bO/VK
bK.A&gfcJJ6_PVc=b/aN#+6K0K762d<6YOA+?W[c_f.\?P-<BR?KB0+NB/85e?-S
BNZdOdVe9CVWNe0egU0<2Zg3BH.Vd>WbIVYY(+3@1=>LbcKMcLGJPX=fV7A/6YaF
H8T[4D.59)=g>BSI&U[ZJ])/OcNICgR_/7Oe.[&.NOT@=a_IF;;D=a(7c]AAM8Uf
[W7fc&eGC;I5^@WJ+84@N;C]GY@A0J3Na]4LW170IH-gCKf>O[J<YWg5JF<6+0<T
RQ6;:c?#KVPPR#+KbT8,#<+.87@aAX<fH:AafPQ]RPA:gaBQ<+gLL&6J([AA\<bY
Lc@EUU:<IYTf>a3+P=P_,Ea,-:076c_eNPHNKge?3#UA:,-I8,X8M@IYJM#gTT9G
^9^D\&BPEZ?f[E+XURC31WVf(<,H<-&W&V(_S)Cb4_C>&@0L\+.PN4\/7;8^/S/V
&(Z=FN,Z;(M]F&+D<XZL+-)3C_M3Q4P:;YA3_K5)GC&c\(Y9@LSK-GNW35RTR^H&
TA@8SW6T5O+7P;:P?^6PY1.aVVIMPBf)f/D&X0b(:>DbHM8T6.ITA>,dACJ#>GCP
b?#:bUKLaALVE;beJB)CCaU?[R5U@Z/)SZB(<43Ng10&1S?e&aH9-A6X\aWWS]60
ZR7d6>WaZ[S@0MR4UdfCeY]HY/LgM+>:U]cD[#@?1L,WD\#_J>#.LJ3-2R_GgKYF
EXFYUX?;PDSDFO<^8#9K.J1=KdT6MRQ=^dX6SWC]#?bMR4G4#OWRFRNNAc?AA=bT
&f466=HI2RG4b;JRUB?-D:D(<C2T++DA=0-Dd2U_T?_47PWaB,BROU?UgWYPdd0E
e4c0@>2,5W9fQJWX75M,/B(D.OL+U.\Q^I6fLg#NWdbB-?,J07\P[<NKDP)_ULLS
N[Q#HB#LG#+dX&N98F,=-f74ZRVA24#JRW]d-8B[2PGA=P6)^f<:9^Za7>Ob6SIN
/=>BG(0Q>+PJWZCa(I5BP=UVX[;]DG/217e;<@N<H9HZFK)R&6O):R>?D35OJ0.8
HDVB+<e&L>=B<L\5KU>]7\O.FD,/eGLDKH98/4/Y,:Y:4AOH6P[=7-8S+7/[-INJ
Qb;LVLG\DaAECBgXaK05&8-5=8PfeM+NQADd>3WG&__O3KA)L=dTO-O<441M=J?M
GT-c.TbJ>ETH]KG_9DK+1OU#PCVc<PQfIJRAALf+-W4<V?0AagN?W1C:5I9J7U6V
a)Eg7=:5=@3dQP8a[?5FV@AN3a4+YMU.=AXT;KfHK82F^VO//,F(e@^IT1&gGXH]
cafcb4S+I\YH?FEU>IFJAD]N?ee1)JdLa2U\B.XGHbI5DU#3LZeRfgH@WPE[18+G
@4IM_(8aCA[<72SQ]702DF>+56DQ5?LSEJL#27SKb)cOAQMe?IHc\97Y,<.LS5W-
>?>,Z[@0@>GIG@>LYM_BGL\)HF_4(NHV#DACe2g,J,J[WBa1A\[]T7<&Kd-0[eCX
0-1fJ-NNb&CO>d3VaPbB>[Q+DVc;@6I<<dEKXMG-SG+++b&cf,IRg5=W6[+F0LDY
B,OR&8](aWV8aU.P(R2.Z:#JSNM42TRg,c;\K7[Ug,XP5ZP4c&WBM.0IbV]QB9>V
TDJ7>),G/@PO1=@89PUFQ][R=Q0>DJ3QD[1OBF3GP;3#7/6c5_.VbP0X.=d6&&#f
3[5_]OfDf<XQ0#V.[I0,9)NPGSg^,RI.&5]e7__/1+J_^?g(e2Y3]US,#^-\-LOC
aQPa>PJ1QX@?QQ>SRC3.ZU66+S?@31\-gS@;bdA)/b4F:F),/3EOLFN4VIX\d#1g
d/J+;QRJ8QUK91+,1LQ3VaK3&)(LR8<gYD@/?@Mb26dTI]+(>(QfSH&(12[LZ3JS
f.\)1aJIMB@RN&9,NJH1b&R=)7Q7bTXJ@]QcZ),CW;99)S0\Q:M=3@C:F@VDJa)a
1bIRTPBYVR&Sgg;EBD(#Y(@T-DCc)343gQFX41,0c4T149@/:AU_F/GJZ>#C<_+<
#WZM>OVUE&1<bG&3S\AP#<G-0UadLcT391[R7IK9Q=DT&g>YA.K:48E5dB-@L?Y[
(Z9RP8N<f3<L.Ec:<d/bYWT4,6KM13ad6GS9QcFU8eVN#Q[f4?Pd@HW9@6VI:RQ:
HSdI@g<]/dJ=N;I@eS1IaV79dI1aP:][8,9W-\>+=U<AGYAOGRAPKX8W\_QdRf5,
NeT0+1S00&.F)VH(KAL\SZ>dUA?_[:TEVX9H;dXe)e]6KO(]C35Ag:?#Wd6YMFa8
)F(W6bHLNb72>,8T8<EK2ZR^[(U5bX@ae-^fR=g-E\NeTa4]Ue);C6fb+V9T?=LF
9<Q43AD]a65([WbeaP9PGIP4cRT2H2D8&<VHgUa.7TKbS0]EI_X]RaFDOL:^ffC)
A_D>;a5eHJEDFNHbaeS0CUR#f^3F6436KN@XZ^X-5<6=bU2-ac@-^c-75=70O[\2
0U3+<NZZF;Ka?EF+X4SbS)-I>>JObZgC5Z,_=(e7]:6#8XWSSXC-UZ71:0<dYF>^
_DK&U@CN)#cJf^eJGILcNDeT@Aa[,HU(5O,?Y]P5LTGE)7Z(U/UK4bCO+CUSX6RG
SadJFH?:7MA5=I_75YIANbaG^Y<XF_c^:#26GUX3P>J+36eC?gK,OKYa>)0HH#;N
(DC7Fd]/OEPC_5_9VIW7/gKSbg@?E/WT-5Cc7dOAUcbeSeOJ2\B4\H&c4NcDNS@L
E(38P+:d0:2:DZFU09f#ODdD4f_A;0O8=1QCKCeSIQR,FF4#P^>)BBgWS5XQ(bO4
;0^+KdM^^SNb]Vg::KE4^LJSF<+?Q)&ef+6Df2Y9O_Q6VWFScc[Q,f+#e\5bgV/Q
G&^H:^LTeUK=J+bBM1#Y<Ic]K1bD&]<Z60=H1NHO]N;:O(/LI(WO4Kg(;HH#I.g+
AE,?BgdOL4;c[PCaX4Q6QO_M0_&_4=f/0]aOEAgcI6L]9_0BL#0IXY.GeX:LEIQO
c+4G/c5M>1RVa>(^ZINALST4-D:]DWdgfW?34cI4EX3=6))^VU\7X4NH9g46KcE1
S0>EUAME423)DLd7PTXZ2,W>Q/-\WN;d5\7Td@<5fVVM=_\_c7I50_/L#-gVR4XX
?85[?X/A280ARK2XQ[[[84)U-UHBG6Q#/EaUF:O6\HJNQM8a6]C,::.>./gEde,[
F3ITU&g[[KAXe-^f)Y31M=5gU4D=ZW?IRdTCP(dWT2N9F9@68C]:Q9MgAXM][GE1
KNL(BY#g<C(POD@E@ZcH#S0?H.8Leb](9D^gcMWV<D+O,^&g1F#^a2&HA)>)ASTA
&W-O8@45?2XU#E\:PDCe_0G(UDZ8a/=+ZP;7JWVQ;^5#<GeHD@^\:+e):#4/fK#5
8OK:PY;QfM0Af4a1Z/67\+GY_B4ZVbZ[V<eIg-H1gG/:e5F]T.KJ<XF4f26De3\Q
dC@CJH,Wc#cB+5=b:C-DGPN.aa.48MbP.M;Xa^#eW]EddfIN6G.)UO0>;YI[:?-\
22^@P6GALSL[-acKA_8-7[d8)X_99/Ld9];bPKYNdL:_7E.5d,K#12AE1#]EYC]#
JQ/IF(5S:bHQMLDF=D?6[\-ST46WI>FFc+L\,c5)fJ+\R)=c.fNf:>6fE:6:,.[<
-8?geZ1T6Y7DgWCdc[FHYB-+Heba^:;#ND3R@HB,9\UZY+OY?/a_PC1X658^(3O?
QSHFaD=-(e<GGDHe>8K2WS3d<2]J?4QEB14YZ,aI7;31>PNN5LFaMcO3;U,D.1GX
?X9,eZ<8>-7T28^O9>V496e4C#S?=:,S/7XXgE&1S+<.@8-L-;SS_R<,c(;8<H8)
\+]:b6<aN?)BQ5R@)?F[MHO^b;@b.77@2GRK#?O5bN0@6L#_:W41X@=S,<YF6\+@
(g\;EU8<<V3aN#fB[<RRg<,G7X+/#BBQ\WJ,bBS=TK&]<BX/Q=;@e^C1Q=X4PDKB
A4AGCEL]Y)38[W,d-bB#QWE;===(^WW=gST,2;F;#Ac:./^<,OPbB0,&+]MNRJ22
1K<B2=[#FY3I+N\26-XgC-1(Z9T#RVQKX_(WcUZ2,/6<E+9R:=GA+5>A9VCIbEMZ
.9TBKD0=R.+=>6:U6F16=,JHP=PDf.STMP1R(bagMAXO^2DQ#OF3SV#eB?9RHNQK
G0Yd8&;WQ?F-]R-38S_F1_8?7<aX^.;&=M:2&5VP/A^NNDe#KK0K9(:ZY2VC;aV1
(.KMEKT8EYID-=&Q@;_W,L(aS=baQ?2fOL^a<8eNE:5dB&Q9DO-+1JDbaE>NK=0W
,,V9\G9[O/37g1f,GR?W/PQA#3?(/ZQMfR#SB+1@VGg52b4E\F=-(]>[e(SgN0_f
#ERGPH]\G-1Z6W;(73@[(KD<+HU;bLZV+J&e11d(>MST<eD^UU/JDCO@?H0+)U^C
b</I2L9cE;:S\-2&;[?()/_E\E7f;5eNa7M84]&g365=S2:bKd0XRO?<@-c2\9KH
)U0E[E#O:1ZCGdNCO18W:R,c_SQWS#LMKRABEP5=V4L?=>E^&AS.\^A>/(Q;^+0A
YfPCN0@<cNYW^M?bYAZHV:)eVS931SV2,^:+1BQ=]U=bIC@<(EcB<OM<0&U_8KC\
V9ZL&K]>ZXOKE4<KEcZ0#@E[9AI8)#^8P,Uc@.IW/#X6EP65YCG^1WE&\;Z@\(Gc
F?_1S&D?Y(N(M7J#-2TJV71:g.KHY_0Ka4J7E[10-Q3)0::(gVcB,>]-T-OL1PK&
JBL,E:GY_-eZKaF-_(G3:9HaN>VS@?Q>DbF,?,UKZ-+N5a<\XdAOgc?SVR)>(&2Z
/./M#&dH3@]T9)&d,dT-B?fEIV/I],)H-0d?H#CRc8,5C#P:5OF:YHY,C?/cL(+6
QcND+IZ[Y^Zd/c8g\.Cc4?1OGUN>&4^GC7V@Z8X(0FR+SKL?^HK);/,A1K#;3#T+
>,VTEIab?(cW-WB@=#2cNdP67A5R+^JY]Uc^9W9d7B21>()#]IT\O\\Bef((Od;@
_[YaX;d/45+^XZc^.-43:SQ4SV]aN]1S</Qd-F/#<f&c9-d2IK0]J]>TP).0,4Zf
ZH-G]WaTF<M_G+K3OS,7cg[&^-7V38g8NM=-JcJN^RWBZJ:.M\J\bb+@.9K]Ma5D
TH#^WI]HWJge^Y66,fNM9edLF5/N=2<e[^6_.J,)W^_Q-@T)F^dTP:QMVGe+CdCC
\UT+<a\W[eR@ZD.&#V00(H;A+CD3NMMIUV8AafTcJPcb9.F/.V4(JHc(.;T\(4>T
ZO(5<35Z5M</KD_KS2d5Pc7-F3,:<CN;/YY-8QX0X@aRHDZLI:>9SZD5_2_9WbYK
_/fI7&1KX)BRA)Y5E(0Qe^>/(@Dg\[7CdOJeQ?U?<#cJ,27YY;7FI25N(XgX:8K4
B(TaDU<^80#?I/H>=IGWG(0+W7,JeO2#4VM\W2eGfg)0cCD<.9M>8)-?YD)<^YP=
CP26LV.9@d]P,>Z(5MCNV2b03.=79013O0cR@61N+^Jd@..?I\YP&2Ca,]e@Rc,R
I^,>\-H<&WWK:+aRXU;(DL0P0<9O8W)>a=[1d+517g+:\?:O81ZD9,Q[5TYMF(dg
X9AH40IT=,Q(#e^V5;>=[K.DLb7,LSQY@3&P?C:/A3IM97gXJ];DG/N?;3Id^NHg
K)50-06RQL(-:Q,P^SN8<;EF]_.g?DFAD(&DH.DA2;9.e15=5f].71N(YEe?QgcD
.a?4gGN<\59F2d]#VQ54FaZ+.9FF+,P>]WX(C/L;\f7TZ8Ye?4Q[EQ^>P57#:-a]
0Zc-TM[70>WF/9905VMPX3P(QQ<GN<:]?&8B-J5dF/(O;cM#=--<AB<0F/04_YG@
Ob4W,gJ.P@KF/$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_MX25UM_MX25LM_SDR_AC_CONFIGURATION_SV
