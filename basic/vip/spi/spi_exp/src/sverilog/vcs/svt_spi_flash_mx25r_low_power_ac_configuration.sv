
`ifndef GUARD_SVT_SPI_FLASH_MX25R_LOW_POWER_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MX25R_LOW_POWER_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Macronix MX25R device family in Low Power mode.
 */
class svt_spi_flash_mx25r_low_power_ac_configuration extends svt_configuration;

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
  `svt_vmm_data_new(svt_spi_flash_mx25r_low_power_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_mx25r_low_power_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mx25r_low_power_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mx25r_low_power_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_mx25r_low_power_ac_configuration.
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
  `vmm_typename(svt_spi_flash_mx25r_low_power_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mx25r_low_power_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
-J\IE>O,Q)20b(aPEa5f&U6;33DFJLf[IHO]0G,>b<&,KeH=I4_e1)#KbWXXfTEf
ZHbQ;Z_[XYfQ#,aZ\MCP40V#J8PG=<^MG.^c:HeD6&&1_T\#.+dL5F(]b/8\(I9Q
TAc1];dH?\N0<fFdd3RHND/Z=8KEY-Md_G)<QgS,9W<gVC:4Z4P0CLD_c]?X(#Ua
d>Z2WE9GIIa6RRD)=PDRU+5L,C@,S\BVJND0_8ZCc]\20a2CBde,V/VWI38ZbP08
6RPeA1FB=gONIGREH23X8S@W-BWBH,aSR#.VaF1D2F;W2I3SK0c^_FR)eV475>/Q
Gd8fCG+TFUHdJ5GHC>G_./8G8\&DEKWZBacR9b^XZe_6,#1/:)99[5I1EHBJQM+[
QZg@DJT=4:c7XSAF10JcdIM9+RVD.0DA#N9]N<71cAC<7OW/[TKXcK2[F);9Eca?
1OWHO#NfBQ:FB>&@g_+8@f\f(G5g_==0.]ZF;_3HN>[&-8<_18_XI.46-)Q(>A2R
B?(&O1CW=6TW&3?_Ld-+:dFSWcA#.8@TV0Ud?e=EI8f#DIO)_1O>>JY&/1OH;G)H
9&;1CM#Z5.<0CcX.CGG/QR1a,F##gW_Y[INR^6PL:^I<Wb]88H8\+2IaXY6Q0LZP
Q\D^^9c.N.WAKPd-dI?N&R[<Zb7<<AH?L_SL[WdB?BLQ1T_WE,&cDV5Q3<0(8[O3
9IfUXBJb?LN29H3e&P^(N6#,XA-ZKS\D23^J4\BNT[[gPO7);]^S2fG2K,M7QXK=
STf:L0\0J/8/TdX9]1?&5]9LD]6:<LO/8E+HVJ@\,;M@fS4J>V1U2/G2M$
`endprotected


//vcs_vip_protect
`protected
<gIIBPY12BJeU.1)2DE1dEG+_HGbR2NZAU=J2E&gDBMIGJ+9Fd?U,(^OA09+D9UK
MH+28[Q&M(,RK(LQ1[H,R[+g6]ALaB14^P5NZ-a56RTB_IX:>>M_b7Te])JI86,V
UF2NI.M::7#(G;;@ICJc27ff<<&#RXdb-8cLV\O28RI-I7V_&aO[Z#Q_FR[Oc=+M
T52)^X6:BUc=&=F2P.E?,LAL6N]0\CC(=:?4T6M-1-=>W-2VU83e)Ra=8d4]G<_P
=a(;<(<d2>)R-\X-3RCaE/e#):c(=^a+H&UGSSb)2\GX+V2LGP;C&^B4a6??cAUH
Sb;dgPeD-KR\U5\SIY6E_0[>U>dXQ7a56eH.=)^DYdZ/B:DG1_D<CG,/UHC9A.#Q
-KEU(PT7dH=R=)aI.VE?\QbFN#]P+8-O-7d-@W=#UE:#G=0<]ba):MK4H37&Z0\.
Db@1+M?M+2I2R,ccNV@U9\\69PAG-:,?G1-J]Bdaf(OG+]W@;[R2d+088]3E8&>N
^THML[LM&BCd\X^fOG<]<Cb?D,BZF8QK<FF#J)(.L385f,Z2=a>5\?SM\/H-Yf13
K<6K9V3-W&X<YeD_^&A>,cBWgATXUVH)L+7@N&5AW?=/DGZN=dJ]0D=I=LTN=1=e
e:BD:3]ANZQD(#VYBYGXf>U4JW0>bS#7cQdC9Jbg1J?.O8>Y9-eHM29G/?P^3E57
DFe:#G4H6QA#>DJVXXH;>WNc#e.4H@+A>(Q\FgB[MP7@41_Y,^K],^B#I]Y[](5Y
M7>/;2]&?J],6=0EIaQARVM30c(S)[&O3Y.^5?WId5ZG5Y>,CR;FLIIga/Eb6P&M
OgLS3.5DU+BIO2EFLb8K-gL/UZK?+#W+WXJ?-]DBM_B+VCUVU/OWYT8R&6XP:W[e
BW4+9gI;E>[?C4N]B7H5?VfQH(S\+D\6-M5af4_1<\PYC4#La><b)=9JM8I_-,RK
;^57AK(SZ0VYO3LZZY:9J+K06&E>4:K])5fGZ2N4&Y^e2X&RbHS)XNE-=L7)^gb^
,]&OU@9O+1RE@?BWMVWaGETPKLP:VOD<+9B^CCa^32gJ1),:EB;d=Ca:<1E\bN9&
JYb>J/3D8M&FLQI+[W2?_3>S+A2@)/VMOJL@ROfDLdbDCE5fU/XYT_<NRC7^-==Z
aa9/H<bHM?X:I:[AdcG=?cVY1g\aR#Gad:=3F(1#LCN>&\9-3\ZN-QHe@:LVQ=8R
IbdA;CUd?(PY6Z7>M0g+XI]-NHAY1+YXZ[]U;A)PM6IOI3+KYT8_J+4,/Z\9:R2=
4V#6a(4].)3.Z:V50TY+5Y_2(DMFV@1C4SfDBfS8[>5SgSNeYc@&>T.(465[ZD)0
--2d\2OX^W:<Sc5^ad;aCS4a(4WK>ga6R(&&VU+U8[ONH:]F<8O?e,5Sd4:EXI64
^D.ac,(MJ75ZP=_/ST;Y@Q0c;f14VeY,S->],DYS:]I0]e_:f)f@E&928UNNG@-S
T^B;a2UgLc,XPB[X>3F<W5=GF0BHW/2)+8?d,0X=K._W)MKG_CEH4D#-DW=WHDWJ
YMUdbV>+710c:/A5PZ:RE=&@,&>eVK?@14LHg9)L&H;a,4NSLYJcD6gE[,.\O_g\
K,29)J]DXP5&]P,Td_NNI:S/S[:@?PHb&95H(d\Y[U-NN0,99JYC[B)1@8^b_cN\
[7G2M;@G_L5_+aQSA&=f]67^V]E3/6d@;0[67F7G-/U:HVQJ6XG(fE<f9/8bKI-6
N\Z9[P+&XC[\Z>4BMKH-9_g7][7c2>7QS47E)=,:2KN-VEV=2gB530DU@3MgOHL5
GWda8H\]@V1FEMXU,;T6d8IOY8;Z?Ce)^_B8<1^W\c_>/VE;Fd)(7QgQ>cZ=RNRS
BWfZf3B1:(W_A-1b5B&[+CEU2:<:,.J5KPQYY?&RQV/YfUX5]IbfIX.:)bBMC_Q9
5+a5Jf-NKPT[L1++7)-I7X^29V;,;YMFG/^KGARLg)bSRBKK7,UAeb]09F[ND<,_
D)#bQg<AVI#Ac3WaaJA/D8Y]3/N<PJG/GAXD7bK\F5JMR:Za&5\S^(@L62PQ>3ME
bIH4N]GU-KYdV?:d40WN#^]YgUR4gf?PIK0E4@4&:C(]:<RKALVQ^(E3K&^(9).&
:&N>Y_HW.8^U^^1F32^P-McO83(^aU0H+)BLUM^7(W14,R3J[2/:OBb;bHK,SW0/
KE)KY2NP7@>OU67E8Yd#c6<RR?<P&CFb/+aDP9g+A/87Ne8FMLK:68D\7[[C,Na(
.5LK9L>\:7fY8]=\2\)VUWaFF[4,,<PLJIN9g)\O6YWeYO1.DM[EM9T&9O#W+_,c
H-H<-Z#>C?V59-PPg81ARc/Z4QAM(d-RSF,-,1<a5_:XSfP(dbHIB6KWILT7VaED
/Z_(7g.dKW.:7f\[.)cK=bB^ZC;]Kf-f#3.HL4/[N[.f.@7S9MeRF^#N-aW>dL(S
J/F/cW#YZU.]TMRaI_;O6SQeSAOJYcL@_I02I>T?Ug,bV5L-(DB-\5EWU^.647/M
_(:BJM[\CZWN:\gUAg<D^LIPM7?)<8XL/S0(<VA9X8IJgOP.\E4A,P)Wf#6d#<)5
49L)#XX46PR52@1>F(_7cf7]/]46;:d2/CaW;CWN46)3RZCeZ:WYB5(eeH56;GXO
_(P^=[6?+;ULKb:LZ=MWDLV>O.FbO<ITO:;FBF+?-,RE3SR[40J5,X/1d<:KDLEf
5+3K3CfVgO/0.4]NTHGg8VV7Y(,b-=fD(MFOMAZ,WeebX&TG=FeaQ&4R)BFU^56#
_+T7G>X[O;;](faaEgEK?1gc=d-5DIGL?a@E01[=?,@4LK0;0KM(TH2gP49SZ,ff
fD63\@cL2H5?77dH-0KA@^[WT-1<U&80??K,E8(McWU)FTY<W]bZ)(^2@[HdA61)
K@#5N0gQ&>AVO;DA,1^O@H(<cFE^VQ[Ccd@(Q4ZXQDG@3N63U5N&g8R9bIF7#cLc
cSQF+,7e3Ge1GSK)b\S1Lg,0fd<^^a@.6QRRac>YV;-9<J4E4S>W<5ICVQ+_F<D>
M)+:/b6@XH5(2(+YeRO;&f3P@DOePBa9^)F<Xe2;X(U\=IQ,#4#L88+P\6SHS#2H
:[DZ#5:(cd[P2SJ^UFN8-a([,OGD;R72TGS&Qd&f#ZP.g2>T\a#-XJ.#0XF0J;SJ
&&>Y^,QZ:82G2N^aW/(fD,7<f&XH@,R7&4KF+2.R_A_DK_=5b7UE58Y@=5]eb-[0
]]I(],g+/,_XKRN\+&Y,ULF&&W8VUE^E;#)J:K>:NRUEd\<#ZJ^B+=98/0]PQENQ
S,1^5e^TZFV@S=gWIPX\0dM]]V>X&)ac9HcI+[D7bS(@#F_]aEcSK@]D;4Gf[[4]
@Wd<[cJ/0H&(+1SRCDRW.O;TM[Ka\0a,Z(^?LNOTXb]C-PC3cW^WR+K)9=_6f(+B
L+V=H<;f[456,I/>,KZB[Q1+?M1HC6:T)gWSMA#\agYPVHX1=+a,[/df9=@^HFcP
WJaC8O[c_eSe()_NOd@T57W9>KObd?EP>SIb7_e-g>6dOO+^BM>Y<6P)fUP/(1+2
0J79G@OBJ:#N2X7-_eKGX7._U^S:U^29DCXFMSM1dS,7[GH@[]:3BO;&F-9fT#(7
a2[0fb\aAW3XHN;IReP[05ReR.@&5;Q(IF6L,Be/NAS:IgLCT\K_/<):f+^&75V>
3=N?c3CUS@I/HEgB3J8>K,.,3&GK@)EZXZNbRDfR13.I.OeW=IGFRWG,P&ZO,QaJ
)R_[=/>ZP/RT?V0>De1d;P&3]fK/3e:7R-UfY#8==9^B6cV\2d&BYN.DY<+(:g0;
2fb)59RE+VBc/G:HC:0G(?fEaJIOTYHW1IL3>?:3K+_JKTVGX>&EBbN0cK[R:S3R
8VI0@(4DH-)_<]YD/526K.9,\]_P9MfNg=>5AcQOSJ.XBGSIOHPZ=44S9\6WYEB4
J=3gI@)_eD,<-=2F?gTJYe<gG.g,1_NJK\CB;4@,))bS[eSd,:2S9,bESF=9OC=b
N5PE]a8eC#,4b/]6WTU^Fg\1-D5,,)N(7R3Z=WYd>BTHSXQ.8[@FIRUZg=.bL4Z^
77HWXa\AK<G\TS02=a,Rd+]QKU[]@FJdMgEf-0X]FUWO:FNG(D>J-G.>EfP9:F1A
I2D.,X3I=9I@Mb8;J:<X:D-MAT2g8(/W74<W]LeD166D\cR_Q:3:(:P0eR>LZ1LK
W^6/\U3F21&1RX&K0;=aX:Kg37g1&V;0a,FHRbLCEVZa9S/<B+?Z6?(W5.R:/g+P
(38X#C2T\<+ePb_](&8YCUUSI8UPcR(cX5A;#>7/P=FGXZ_E3VH)adJ8.Q(@N>E[
,Zc8<9E@C-^OU@<(=>b<4?WMO(DGN5dC/AW/e;,P(Wb+.A_Kba1ST->cKF][D,>?
OIDO+H>3?#69a7_e?L880@:46L[_S\H,\/DL3OSJFV=f:Ne1)ZYfXQHV,GfNLccE
VU59T\-EDeKNXA@V:)8QZ0;\+@PQ.;<(RKaa8>]H.3EPCM1fb7_4?17cNP[gO6=O
d.e7#2A9B4))NBg[2L^C&70EeVP1A.9K>CUfdb[^ZZS/74I#PKB4Kd(-I1B^7/4J
[ZUTW@;L_b5>PRNV>OJY08)Z6T/aSGU2MO94JIO0]E2D55I+2231f)Y096NP2SI,
)LQeV++&SX)8c_;eL1Td>S-e.([b_>PV7-a(RR@26JI/S3(JI-a:1&F#:2>G:>NS
MR(]<0>I5J_VaFMS=?_B.JJ)cI;Q@6?25XeT]Y92V1aX8B&9=HKcIH9>gT.QaDd8
[@_N5WDJOd0=(acHHPc<Q/A5f(^(Fb&eL5;Z[[T.[MJS,18;AOb&c0_Pgc<?=+TM
0.AE7I9U4g2K34-GQ)Eb@=1fBX&:VPFT]K\]Q->IV6CHf?0;I#0BI_HET(R<;M2)
BH6,YRD&O5)HC53V=\JB#<;=J@&:P6=7BOC;T/W6F;f0VLKMMK=8P]d1)IEETFAK
6CLd+9\gDW<1ESX8b[8OY&F_W?abGf2DfMff-Y;O4C(@bg?:<5gcI<,-##/6UL2M
+B19=88E,R,)HBU1<+42QYDgb0:IegR?-L=Z)f_QJ)AUZQEADe2g66M.E0K.b[2C
?W])]PbK^CLg@;N1MN5_0JS=A0,<[<\fQ+E_.+U1)c0:\/YFKH.\5d(b5d\-E8QR
;?4DW5)-+_7N5F;OZ<G#?4\JZ@0O;U0G[@Nc@XB6=U./3&2JdXQc0_[UT@a_#5O6
_>6e(0)8\-gX9\0HbLQSMDTZZKa7E[\BG9-0-Q1Y1gFN_==CL?OVBT8Kc;DGe<Vc
(8+=6-8]1+Y2=G@d6,0Zca,1Ta<g:M7Pb?8ZS(([I)ET46UTF=>]/[ZOVX\BG2I=
#]TCF4ID_6[\WO&UNF6X(dF6@QNeSX.#WMI]CD9DK-ZZOQ3M7S+dKTIA#A(M9d]e
#9U0,4_E.HFDEg#?T_JI<.C5M:A+E_fbg)05W)53Ae6F)J:GTETC917&0HSY3?&6
acg^J7dS+[R:Z@[?P\CY/_08BJ;)83-gSA?&c]:+MI3+IFHRUHVH[b8fa)Y83AD-
^Y.2(\P?79F/-fe[RZ9c9cH]DVf<d>55?#_2+P]6UIb?dLc;EIS<_V#Q^QD?B6V8
UJ5(\=#H17C&_c,[-B[>\#.EBg8OeE9V,b+X(2^]I3e90F?OG=SWV[<6;1B8-<\4
/NVCP<2BU??OX,+dFIfTNFX2[Q0KG+^M0]V[Y3=4b6;VSTKNfa0U=\[(4XPGSDY:
eG)N()g/KI+,/R7PCT,Q+<_985OBUC:,.I7NG&Z67D9Y_J0K@,XJ6U<<Y<.,1&E9
IROc#8a#W[<5#0U;KF>Cd]EgR2M[/P;eDX9P5Y:c;&MMO=GWNY1:J76EOaDK@+b8
/<@d(_&=(H_./D4JY)J1de]21f_LYcfG0=AIT/DH/GJ2d9ZDV]/22bFS@E(>@YD;
ZBF,>S^+;1HX=f5@GI#&L0)Q17X4^PC1DHMb]#3YU5@^DY630KISBA,L.K?6?gU6
U^1@E0:=Pb+6=g(EA8@gK4EXJ:Y:-3AaK4]&,1E,e8+)T8.C5Y:3A=WIJM5c[)(L
60]H>?4.\S<##<>[-5BfYF6ERL@SQ3DS+Ia,].R\1X+-0G+Y;XW:(c;cY0dSK@>9
Z5a?-.W+FAR,3<Q&V7],E0I]VWIfUI4gLEO+)ZHH(5T(=JRPd?c#VIB3XFTY2B+G
J=>fG#O.8RDUBXHGS?0g2O+H5A.\@VDFJQ@4YX1[,RUPQ#E?WH)+618M8cQ0392#
=KB.-HEY<;KGZ=+4M2TKAdD6f\]O&QSd<AfCNZ64?(NR7Md&4Z44]40P\L]f;)M]
,3LOPgX_c0:]2=)XK3&?H+R[+X-L-P2:)F;3d+T+<(C\<=)Z;(CgV_U5df5]7SE>
X.P02>8RJ]7F:IU:K7KW@a8HFFR<WJ=LC#/<8]f5-fZ-6:Q4KKCG;ZaEVEH=08NZ
FY<?@91>RE6HH;?R/DFW0Hd3c.N<-c+[G3.TY?@aIYE)3<JB[cABMBB(a7gGLTRA
?:;7D8Z?:/D()^25\AIW]S]=#cOQKNL/_XPeg.@:;8g52J?<JCX-U0G),4U\C=5F
M).X7PIfIN#<7&=a/@X_FZQ)=aLETA1cRdAA0ZND_A1CJ=?QQ8V^/X\#Q:345A@9
c,(HJ<R8bEVX=V^fU,,3Mge+QN9(S@a4+_H?/5W=TZ#7UdgEdQ&c=dOX;._:X,9C
GV?\e^^4\(J@-OOJ2Ub1;2>\/7\.2.Q-F.>AVBFd1]RB5]E0M@#NN5YT&_Z<8H]Q
GWf(A-+fI,g3c9@CO0N#N):=O9SUKVKTS,CE(NO,2^^/TWJR@S6gND:JV_LCb[N3
D&E-DaN>YYe#PS#F6F.V>;?5:7gR:;;X=7&KZ1\GDK(5O6fF#ZF=4[6)f#g9cHXI
X:RMBA<^39=:8.#Q>GgK&Y[\8Q?<01_H_8)MKGaIM16VL\OJ=DW;JF;84^EQV#:&
(LIBA;1RVF/S[2dHH=?a,X@CdZ+X7_>R9FP&(8E8:WWdFcbYCYF--3fD9447eA;X
?[)=6#SNEAO;W<;&YMeUAP,;fB.A&GdcTL752E=@bD2FB++=GU0]:[CCU4R>JOPL
@U.)UKc5cPFJ0RK0;[8e3]WcNNa>4Fd7cR[dV74YFRKc6;Y[7=VQaXX,_6ba4+RF
LP5&,2c@GZNPLUL)FZcD6O:XGSYf<PZf\_=(TYUOR?^78>fFAELU7gL^7\S0-##@
0Ag79(RFI:UQN_RTf^011M85IV-BSZ;_#TN)5)C<EB;RGD2Aa0K<gHLZZW_fV<NY
JQX:\6:\0K-<&/&-SXdHC3=+<H0^Gf))K?^\27g)9BCQeYPbeW6?_,eSS@>3)O,O
647):M)(AAIEY<PUBf;L1eT]X\Ag\(V(MY8[CE486LW#g5R[C:6FHWM+NG6P1D]7
H4:C,#aNaVPFPXT(cW>_(aO[fOP/;JM2MLf(b>E^;>@a0/C++dcBc;g4[8HPZMQ?
;MAc1gUYGFEDb3PSLI[[)e:]\7AKKP;Ieb.:5/X]^UB\BR>;4:cKcGc0/fRWVb+<
D\80VBE:D18_]7U8bI@IHSU;F1?MF2@-1C/0d6Cc_OPdMdB^I>LRe0=CEA^6[&&O
W^e/(LS;>1Z-BDQ90dc=[dYD_?E_T;-??/A-LN-L[3LZY;4<^@a&.JS/[^I-YE4/
A[LPC67afPQ?CR#4PGL:,B_.C9JNZ.AWADf/58ab3ATI@9,@(gPX.[:<\&Re#<62
]_&dF4YeC#&e?;93TGNY0cYF^+.ZQS8#NA&H)VMZRZ?BUF_4=V\P<bY&VbLWFFA?
>V@W:RUaZF,2D>a8/Q,95X4?M#4IB^5CI)+[[?>J&U><=K06H-)&@4]JT@c;+M5?
R68,/PFMPVF-ZJdC)(-HM3H\<UOf-aAX.QW]4D6Yg+JGCO+CbZ^L)&WC,_4]F0/L
\.^(^M9(,KDWSM.&bIX5.QbJ-)SV6Xg7-2^IQ@#LLY&>/VX/?^=#/_M6OME7a[G(
->DB^HQd;JT=([Q#XSYBTGaD3Y,U,2YE=C==(>/;f-\6R9X,Og@)\<,>?X_[e@FV
CAX@Z=6cfHUES2)Q_&4(G4U_96Qa3]BBB0MbJKabIe,PJW>)c^.cPCFZ.7\;&c16
e_+KWbL\/0^UYZU(8W,g1S,=TT+8VTBDFI3J&ZC>9-03S_X<M8;C6b^9_Q<G?bcC
>8NJd+>;<+Ag(C[17LN-CG?]f#T&(>8A[Q(33TTGb8#R6#2-T+g:@O>4-&VA,T8a
(EGSe=77BW/O4U<F?X_S9I9QL<_/,1]Y;c?VJ1(01?7I2X3BJNV+-UKMF@g=T,9_
Q&93QgPPP<V;KJ_C5B1ZE^A\Fd-d;E<&D:IX<F]Ic\195:e./ac_&8DO&[QA8+0=
RO_PVPaX5O8G+4Oe2RbDX4[ea127PE9SM#F8cO]-&0#+aG2,fMD+>@ZRUGJ94YFV
^L7,<20&K-U6VN^?WHJNc1]#ZM:b1-VHeO.P>/0(Z)]FH^P?0_=^]9;OBRUCH4R<
@&FJ55/eCWbLBaQS_C[8?LZN#>\[HSP,TafL2(U.dU45J9/RJ-JVY[H[[&)CQ@)(
UP3MJcL45Y_4A+FVMX44SXbTA-J(EF#>a#\AWc=@DBKB>=C;BY-FX@\/+U78CKM.
GbYd0IN8-?T\T:W41SGOa/GJW63fSdK.UL(SA<YR9aa&]_,.&/GTY#=4,@&f0>b]
P=^cb/OU,<FecP2EU?d+@T^0Nf=5Z=1<:&<=K5/-@2D[dY/AdYQH1ZF65\BB\:[?
UU@Q=&7=DO-XPOT[&eD5a?&W=?.d:^Z6d&T3_EA,RH^\E.H(>I++RVP[\c)&E<\\
:S/[]D1Z<ZYDQ[C4@L:0DAZ))JXbL^[O:UJeNCK4:P80G?Y\]=?)<;2/V>V^(-A+
=cS0Q^B/GQWeWG\L[ca&ga>92/AOVU,[?=N^e3+&DW(#?dDW[Z[#5#f?)ZRcA7bT
](fIaE7dTK4Y9;?-#3U]-_G,N+#ZA64AM#&Qd9Pfe/3YM[4@:.DfU)3>0+O^6H&;
W1NYH-(5V@IdJYMZV-DXE(2e_U33](0]@O?8g;K&MZ8FG.,<0OK15;RXQ-+Z)RR>
+\).B(#<&.RSE>YH3]+.HQG:34E2KY-I<8&X-TR5[Y].C\-.U<L@8?6.ZaDGbBZ:
gC68ZUEgB[2/WgZ#f&RY)+X::D(:c#JOBU+DfF4F\V8A_QT(dMN.^9Q8YE:G.FM/
BB:?CPYb3f8Oe#QbI^[BJ#/DdZNOf#E.;20NX9=agdZJSE;CaAbW?L.G?Y;?YRO^
e<41RLUdf_8K8E=P3&G3bEY<)S45PU0\cNf>V7AbBZgDgCK<N<?2-UBM(<0?6YE&
&SSKF.Gf=08F-DDZ7@BTaXF]b&/6Cd:@Y#;I;CIT#JU0CIEJ1MG;d,@;;cQ)93X<
JV&dGE>Q5H=SPFBH<#_,9)5+X(LgZ)Gg8fN4I6X<S8JZC6,T<1RGC6]=<_.cA_EJ
f5f37-dS+H7QL6N7;@c-<M/85+_[HfcDNL]\d,XM?9b7RcbL2O6G<UJ8GcV@)K=)
8=d/E1CH+NBP/.?@0P0#3g?8Z_1JaBTU##/XA<\SeEW(&1D((8NX8.QcWS8gITG6
J_ZS)J4O/LJ?+)e/3[Hb.AJc<,19f[O/N4E\f)HA=cS;P^QJg8LU3<22:NE3MU8<
W3b#V5g:)SWWG;J90:gQKL\=61&36Kb58X8B<KZY\^JT0)I<^9Dfa0J[J9FMb&>O
<.dU+e4F^P#cWGGWg]@?_)>SgW.NN&SC88NZ<<E(-UUD@WG@K@)?2@E-(<d51O&H
\P5(S9U32I0^LgE9^.^ITNV37V];;Z.D_3\-Q/=W&3.FVccC#,G.LAWN(aVcI+3O
W2/?(\QDYd#,M[8;Je2e1I(g(.43WgQM8f>XAFeW99JP[c&>H-LK(.b]][LU9SHd
G8[1W&X90ZIS=3De4&_68&I5.F]#L=H2H8#PNM\SMZ4fN9Wf7&[QHLafH^D:3?_+
Y1616C+9gFD8PX(ZWAa+=3>0B#S2>4PWfW?I&GGf++ALR.S5XeN&gbENS?Q1F-(b
9:<N/CD:G,;fFRZ?Mbf@2.D)UN+F_+9dP^U_?@WG7;_(H;4^J1ePATE/EMFCV2;P
b1c^H6^BXL0g>XN5.))2fQg@KdO.6>BM-gVXU3:>BTd>:=Q)>=26WM3H3>3N\gYR
PGdded9c\UST6fK+=]OObR\4RV:DSVfG1]D;Y>M(/O#?(5&4NTZNT?:KRG[0E@:T
g:AM5M,:SL/+3Ze=M_-YW?,e/P5OFO=e>B?C9.N^GKOe5\:86CWHEBf23008LUFA
Y[N>DE_:LHaE(I;a=0S?M6&KbBP75]F0Q0^(40a)DV&[>?=O(D&;eB3aD=8XP.Ic
\=RU,KdI^^[E70R<K8PZ,f#-2#RG#3GG->V<-PE-+8E]Qe+6H?_OQHS7;,V.UK(e
7XQ01Zaa)g-HXGA5#G:EPQX7b11e?9P7McIR;[.V<EERQ^1QA;O#_XO94cW8/#=@
>gaYS[?&,K2G-BROD5DUaO_@/^GP(^&>:bJCMaRG?.TG02+)2GC^U4W3[24T(A0(
=,D(?1/MG9YFIY5TY(De,:Z1^#XeJ:Yg0_JdeL@2\U-#3]X>]>ST18Y_R&>_9]\8
DN^VF:dLL_[bBXW8:[<aYAAUM\PE<LKUSP@+f>@;d&F4DQ-2L;7.4J1LDN+#&FH9
<HcgV-(078e/,=MC7O#ZDNaWH4B_Y69Q89<4(H&CLZYZ41F:W9Q<;_Q^6DSa&50[
Wce;KZK-Z75E7G2WTRAE^C0/X2WW5-U[Pg/>=S4.E39IP80<a?8/S=Kd_3PV<13D
80GO:EE&P9f-a+g:J=8=6/J^;?b(cU-_9=-8;HDf0bHR(2R;[/ST\@aY_;0NE8f_
3<5Bc<ZD[VCg2a<,\6#e\I-F6gI55>8UGYd,2XUKO&<?;^2RY2CU-P-DD(T_fE:S
_@0g0TIG9>2LIdKSdD=aJGZd&:S0JPEG>d=0UZO[PG3-1,()bF]N3R<RXV,@T2Ce
-M-).6I/b15NeQI>I0O+8:N?@Cc@P:.#gZZc9C.f&YS6Rc/Z_9^Uf53.9a&#A]J]
OLVHM?G>]_NEP3U\N+Of_]H_XOId^UDgT]Y424UD&\OEc)?Z(#+WEAK1&.b+QgdA
ESV?eNdJWJgO#]NHDFgf?K[E)T<K&YIUY;.-^3C7@P=C;8D+a)7I9d:g&&3c_dSY
+)Ef]Fge@0=OgTU(YC=>F@VB__TN/3QXMc_56GP1eE)gUO7E(,_P\(^0G&_2W)^K
Uf0<X6=R0\(TL1()1;O&X1e5?58^4W[GPa<>&0NSUa,1bUdOD9=PfS\3NA(]gfVd
K?]/6[:=HLOb-A8]EPg3LWbXf?,ZR;3#5LI>YX#YQ42-=C4]QN14=3E9MB0(X9H;
dF047SZ6^J=\(/U=OHFCGOX1F;EC1==I3T?H3&G&MDMZc3E=&9OY:2-H3Q5Rg/T+
77WPQg.C<V+4PQY40=#ROV.)PK[\2FC:\_A<bZ]56-G=JaF[P_5e+1F@S+5\<S<_
ZOQEA--N;[XZOf\V)LOd=:JY_&8>M-aHN#L);^O]2[270PX[ZSP3T@D3d?e#-2YO
W.Mcf/KJG0&3f^4>+be\NE+_a2#f#D\5dV/=G(_C<\f=c2WV2d132;5?>eIC/>7=
SECP2L)\ADE:4Q4^1/&=K>ZS:fCJQ;IN_W/T.@+7I[A97JCN>&DH/).=Z+M+P]dD
O@Za_MW>VH9a-YeXB7a]\?>N]/T=@HPJXA8,32ROBK/[4DL@.B=BefSA&2N[.OF<
U5Jf>Lc_RFVI@#-+N5=NKRgcDLE6&W.I(&^GT4X<.\Y[:Sd.I[BTDQI1=)4XOIe?
>A007I3g/5Kd#31_J]XE.DPZMBHZ.ES2d)X;QWSfZ4LHRf.3VHZY_ZM?EF6_/40L
:AP1,aQA2&F+XI1c6O<Uf[7<V(4(9fA=WTZ<+7?WNFdO=FQIGQ.?]PaA^U>2F@Ae
A9]^V\04FAe1>0&TUT/IPA)SX7SV3U=@HH7V&@BO.<)ceH-P^(UC1VR#c275A+.c
#A)^.;&:57F9QQ<LZ_b/,#\+PMH7b@<@03Nc3@P_<[6>IfATa(CV00I,-33/1HcB
]3BFSN7+LWb.fKW-1\7L?_eO61TL]CdX>,(4)HD?S/-\E\5-L^\0CG63:fFYI6eD
=Z.Wb1\^;D?ZX@5-a3B/RFDeH5JdHPD:a^ddQcLfKFN(M\Ge/24BHeOB7IeD4@[:
7QB14T0N_YQB^3g;4C&b4?;Cd(?RX^N1Q)2Z<PJF\\)dgG/Hg9cc.\Q;?C^#5T3W
B->)TA.-\&_<,EUPMG89:E3OHO[;Z:N_gCN#;V@Rb4I^^OVD>B3MKc\_^)Bg4MQa
G5>MNYXXSZJGZa+CT?7URT[8TUL2N>3Aa<;,BS))_L6]6C5Ib@\5PWBbI3DaXU,W
f:+@7^&H:?5Cc4cZ/R]2ACO,KM]@.d_PR9Y6)8OY(bEgZO0f7G.fV)fD(;-]].ab
0e0-BJ;F@[K2eU&>&e,?_^RX8OZ7ZS0G/VaWbX_X6cK#3We+.fLL5012WEW-T7CO
:#DVYVGZ?V=&DP9G.F:S=[c30WW/\f1J#Y;T[YC4@b&\T@>/A/XKDTec\\?3YT#S
&e]I3cE71[HG:^_db.)LX)0^#JW2Q6#MO+R5T8A=\,+?U/SQN9M+1<PWNf<M5eLd
-:Z?KW_9A;;6,EJE^@c)5c]P144WE:?UCG0+Mb-Pfd=X68M37HPB]SH(5KW1P2a\
P7=)B9,QZ1#YN+:QT6B=A_6,P9N\eD:W^N3&/W\/adbUG8=U-7[9Z\ZPb^Z76EQJ
&bABS\IZ>ZJJOITV),]@#]=7K37,O:)WF\_8CDOc<,gL2AGVI_f^>BGWO[e0a<@<
Q,PZO<X[QAILX3ON5OV+(8F;L;dG.fP:)cK6/1ZK;(FBA_#I)QVf/fd:NMC=OC)2
]QeEHY30B(EM=+6;7B3&f6MJ?8:YcHVacAeG;\,HNKT3=XT51@c,LX05\G>5dP8^
B5MLH-FC_N,]e]>>(f:aZg\XF:OD&:dC2;8F>5PTK#E7F42f)g231L)C/__>0Z)H
EKG_6GOQL):Cf^W[RHXOd4HdOaNL<X)3L2eca4.M<Y7Z.8]RXL?=>5a-TebaO8?@
P?).7#:;7Vb#E5Y+JKO2:DCX#]#R8/?FWIB3PZQd?10K-XE5A?>A14LQ3^B=Q9,c
G<gRUMXf3N:S:V(UT.;BU0bSKVT>I#c2=Hd@NO\+]7)M2Z-:4M?D+/.ODOUB3O-T
.Bd>EX-;:(9UKRQ\g&e9f:+F,YdA]^S6LO38?NeTd4A+8UfFWaD<#@6Nb3I\/FE[
]MI_;]8))_H0d6F1NBMA(gR:D9ME281;FSMc^W>SB-1fMZ@^Z97NDYEZH#984]>@
[[Ka=^+N@(=+(Re.FY<Q1IEaRb]d(I.6TdID]EF+Z)eAB2TRP4SK6EPP:d^9\E48
cB6\M0c\XIY]CI/8SQM)EY&ga8E70NOa0[[+-EMUB0/gUTT[H>SO/Z&J6UBV>;<B
2:b\5C(4\@P.f?F#:51WGd7@##3P61>&DFU+1b1?a]W3-PS4BW7YTFXOZG9V0K#Z
;9??@(RD^[6R2N:(QYDL>Wb)CZIe-3bMd6+P1NN2eWbX>;L^&SG9@V3,+0;MNK6d
1?=9(6cOMKUF>+bHP8PWPc<<>>C0-U_W,PQJ,HfC81PY]a-CY6RGW[,=2]>Ad[E.
7[P^(cPg(F-UD&,:1Z7,3Ic:KC)a_fYc34Z+)/8#^ZdRNPYL/EfKZAN8A08EN-:.
2S:)aa8YM84UPUb-UGZWQYI1.4HMc^cfCYg(B#MK]VCV1R,3,BTOdFWZ(a-]UB/U
7-NG#UV.8;g;.XH?^\F+PIN\RM86f&QPTJBc+MJI0YbN;?eU6#O74_#d#25AM^Lc
+394ef_)2>#J5e4I6K6fQ)+b911R,dT5/E.>V5\YSNRF7H;^[4Y];.==+(-a7Ka7
-E?1YVBgDFFZ]>XT/&0d6TWFJH],+P<M//bJT)B0N#B#F>+VC#E.S[P,N5ZKc+-O
0#D1QR[:=9W\V&,UCE6/HU90P)9M83G-2YQ+^cX8LFRZJ_;[HJgD1a@aAM09@U(c
>[DWQ3,GW\V(Sb06S^,e8:[O4110a]L\X\.FRLNQ28Z-OdQ@aPM)W[MM>>F95N9&
>?eD;9#@[=<0H^?22D(_P,+H-a)5@eQ3[AO.5fa9@eK5?PP3L[Z[#4HLDGZZbR#e
P7:GD[b286;EDS/V[E]]-:8<8TD;16FM,-U?g8I26XLbHEbaMg,&f,We][U,O(IA
IL:c0[2)-NPEG?J12(DM]6S])Q-C^e?8[[+Y-BS6M[@YZd@\&\O.[Sg6eB4W[=X2
IOP=1E:&JUg4_f2P;BFO3Ea\#^&X8@ZNIGQ0-\:g)fME98I[Bf+D[?2b:85;ODO9
;@JDc,P[X7Y..S]&P>&YeMX/C<G60;OB9OMGa[LDfL+J#I9P7FAS&QJS^E7B3^SV
\bE5.cX1UQ8Y.0(BI1\9?fgdO1BG\.[3]VSG#//2Y<eZ@;M-&C/F:(U>47H_UR3b
,.HFC?P3=f89Ldga&V5<_IL@J9[)WF[MUOQJGO7&D5HdCBf.ce&fR?-AWIQ92VPR
;/Gb.=<R2?\=XEF_#Y#.e._SaMRB&9.G+#_Z/DA,+1Y.MH6KM,P=>]WcP<#)_Yg@
S0&A8TZ<S.9fR-\d]PQAW[DY<,d5QEBRA^E+E>3M3]+;]RYSRV@+,-]#5G+?\9.^
eCab;_;8f3NFR;bgMY;eCgQ#/5-49DD,KLK8/bdKQ.FYMdaK.M?<&?g:A0e&]eX>
??JDS@LV>JG;-N<C@(<QRVQ2@O4?H,YcfL<gJ1b@O#\9.L]d9R<0J)KdQY(C-D7-
GH0)5:0<<XcH(FM1@dX)9)HS01)L;WV95O1ZUb3gYcVdO@;,g6RWea=BKNO9cZ8/
Q\GH/<PZf37E663dJ70gFE=J0V:)16Q@PcfSB?ObLT.:CRG#:fW3W1fb\&=e7^b#
JcAD9_/5&>((e.G_/L0^ZSJ<G-=:6//@75D:>/6OT96@P5[IUE.OcVE=8NC.1\(K
_>g[O6OW@9Zbe,3Q+?0M6;:D5eH^L\]]bD][O0dJg^]Jc#_0dP]@3++6FaY4)>YS
8NXGMGDQT:K/I<P.\aS;)Q>5dbd&HE@34^Y]5d#d.NY+e5[0/-gFW9&Z=[M6JPD0
cf)&0TVSD+1&)\JK<KT/N<McSF]/cAPX3aK9XVIY9(b:2&e]<5+-_Y.b=f)VMHH#
&3,77<.92(]ML6d>IcM=R]7_^&5I+\W+PJ1KSH(_\3?6GWX<Q[cN7CM<YHa[E_&4
JS:?N5LeKJ(N;T&FgX_[W\6.d)B_.X8_TH30&/L=)OAef+1PR6_E8cS@CE.JPecN
7B1aNAH=GV88A2d<M45/@WA@@CHLZ4))@fG/cU6?gN7-KXHLTKM(Z37YBM&+8a,F
PLNNSB83cZW507I.2dg-KEEB-VSeY2BF:ab^@O[7F4^,\17<9,LPa-BA=]ZK/1bH
;R8K@?&4X2eW<LY4W>J_MbAA)/Y70\fOK+_eFg(2+AX>M;RA&_8=a:DVR(Q\cI]^
W(/+^Z[Y9O]9HWMLb:ZFP6NR@?QK],e/K,UBc1McQ##L4RW,3]OW(#08M9+?T<fK
_M;ECbTD;S]DR=cC87eD?-:;A1IGPTF#4:SVdVC0;fOfS\WG+]U0;,DG=7##M)4b
f1YeJ6D+OPPC>BbO.&?M=CD?7VeG/fU;@<JXM@R)SC&01KTg9TE[+#^\_<f=A:3a
HDE-M&f[A[YP?BNC8=@7;YT/^V5EF7S?::\FMga3Q;U_VB1Wd-KL(7(4040-6d,_
VL?V2cQS..I7e@bHI8&E_e)2[&EJTfUd6gBTF#WE5=?T,^5=S/I)b(/^VM?(@J>:
Z\0eJF/>1.@N286IGC-AgZ,T,6L1^[HSU1e/_N:I<-2@XX,2A>(94CY_I^fBAHJ1
B[g)@Gb,8L84[HD9B/LKFGK.J?bORE2g+0WA(PN7gNaRH,(M7Fdd)38Vf@WJ,,dc
d>OP]MW+D#A,KB-M8?<FF778].@5(W<6?8-BR7\,)0H4EGZK,/]),a=>MI7X]H^&
2-X715BL&2F6XaS\B)NL6W;;;#T@75OS5:d-R^#_YKX4FR/3O8dZQ2JY(GWMJ5[I
QZJ3>.c+]UFZ\eXcg.=VD@Db^+93/R8,L65PW,L;J\O_Y36W(L>&4L_R).U,-fM8
g_2D(RK,Kgf:QIPOUD^V7IT&0?T\f2VN75(b;4+2GDT11-a>aa9;;Z=E6-RY]edM
g0-]T5c0PZF,<C:5bc0A5FfM3H,T,9[6XWVPC2D)(;F37>I7G9P6ZNB;U#;9,0C5
;H#PU:)F;dG;?2EQT2#fF1C?/g(4YR<BW5+cWPPLIMe1R/^@Ha]cC(d<]c<<+^Me
,PP2@4f+BB0cB>6G]L#6WL8NTQU4IBOB9M0bI2f/A,Gd-7f)R9QDLR86)QHZ.3<9
e,Z.Y;c1d5>17UE+TK4[7f=GQe?d\03[P&,U+Gf.N?_dU&ZJe:gdH?CIJX;9(c;2
ZJQ+C/S\e@K&E-8(0Z9dV2H)OC>2YHF-_4QO[Aa/#A-[QP<IMSH1/O;aARe0\@Ng
bda(6DIbL)^6V0+HLbEe@M(5VABJ,6[751==:Sc#cVL_)BU>49&Db>FAD8)@]/B,
8;cA-G&24U2</X3SD:)X<T\?f+Q-3XI9F,bDgYCQ9YMHa-W<8&LFHL@MAIe21fGc
^W?R-V]\HA\dV6V.,H>A=V>&?M06(gcPY6#<I0BQQFP:6]7TU+]]9>=.U)VgF0+d
8EPA1Pe?>6JS?EDg?RK-RPa]1eABGe92e^AB33eH3;f-]E6:M1FH39B;KCJGdbY8
VcOS5X[7Y6P4&aT6X78YZO<-/,XKJ,-XXV>Rf1NALdBSWG\\FVGfXWRZ=\X&FM2f
^TPGb?=eI6^=bbLd;2SZa\XVBX2(OFO)a=;2agNL5DebPcggDF#WWeF7H2fRdHMV
\\ESff)g#(?Xc_IVQaOA>f;9E7^GaC4Z2P&Fe[eU1;fIW[F:3fTO7I9;Z06fC1b5
C;Xe\X=EcG>\G?FXJ-8GMDQDU9]0HNH[4RQF:L3=UCZ9XPcTQg[SRX&3R64&2.\G
F-BT(<Z5W?C>2=R,5//]#,57b-[9Tc5B2XT2T^2QUR6DP\AOfR]\)0(bFEfRS4+J
Te@CC)K>_02_-WfQ-;gB;>BA)R>Z[ac59:AE4X&JPgYe-C;9\APN><I);?Y&b^S\
O#CBGV\Va5)Z+8gHM87[a++16fb;)KPAU2]WWFVJ,T#2/QP&=-JgD=.#((B:<YRH
=/>(YWHHb+PH3+87QOZQ@#TgF0]94L(HAR=>_5F.BU@EG8Yc&@B;KF5.C9@#@@C+
51FPM@99XP+=g0KdZMI>(+M#W_KA[;.=R@L6>VLT+4<L,GBgZZb4^_e0^cO,?ZFN
PF&Sg9<AF=E&EP<(5BaMW-V,Qe:cL;f@I((DYBMK_+R&1EgC#P;;67A121GIQ=U2
#7O=/OK5NQEA:35g/,cB-eZ2-d6?)eFI9I;3F\2a(];?fe;8a75(@_/:aUE8_G,B
[c=HeR<^H:Z>^1SJ_W]RI&G/TXb+(JMT,YFTZ)_40f_V[c2Nd-_VCac5TH,>b7c1
Rb#c.5K4ad>F2\5^:LPH6ZAc:^G&dP2U/<G-QLKH9_PL\;O,4MO9-1D1GfHe?)^/
R>a+2D@WJRfQ^&eTS@bH5D[,6Qag61R7<cBB&7;7OX2IGOFO3LI<F\_9#>9/4/Wa
F]d+_5M33H):HNZ\;T:A\BW4O:UTC=R/\NQ-9,H>)CB?H9f1]8^G-KWOfLS_>gZC
0A-WY^)F#UR6G2X.\2NU@QTb=(fDQb^YfLeff\g+fL5@>[.7Q#.DK4+&ZE09]LMF
I^I->)7R4dgE/2JfBY_a9FWQ<abQbRZS5DBS0GJ>,63HJ_(e\9G(UK(0^#K6=@\@
XBf?a04P&dUA]6XLJf80=9B;QdfaJ8+f1(5)L2g(7IS36L-7LbQC(,MA^R7QU9>Y
1(D_5CABE#]YQVBFITa45QGT:_0+Q]7FE@bY2Ug@5c)=d)0[8D4dG>PJ33PBT[(3
,d@L=S\c\HX#9RRQa;Ucb1.R]QggT5e3aRe:Yd4[bP=-H)<f[;LR3J1.J3ATNF./
8dURBYD_eN\AEN6^3SceHI:\c@51cV:,[46c^_I?4;:Nd)U<N2RG;_M3KF6QfD<>
EL@:GNV2MO=ZSED]\g.:5UR2B\LEWCeeJaY27R9^E0VNe5Ua=E&Q>P48R#Y)8B7H
_B/Y&Z)E-WY/]A0.T8?<UY3PLf(+61?\[eTX/c1867YV:C?C92:B+bGQ?#ZNJ=bc
2D5LZI3XI@S;H[51R5];S?9eF:gWgP6SE,@^KS6ZVd__ZQTR<&\>V&c0--M3JL,+
+>e>20E5H(X;#W)bL#)7GT)>\<MKWTeB+8J(e+\<PQ\1#?a/&&dNC\@YUME<7Q\b
VeP(AQaI#C\?J(9LX<b^:V&C(SG0MY/QR+HRJLJ\;QDD;Y<BLH0<aT(BA5[;:d6;
d#MNR=OQd-[+7_=,#70L->,.N1J9F&,#4H:(bbY,U-A]3ICKZYg3HE<VS7GH/Q_C
cO_V58[d9/T+d.VQ_JD(8Y(b?f?UYY7CS33S38e-ROX?C/PBMU]PD#.aC,e66X^9
=I6b/@EN>4Y?OcR8PY3[Y1IA5)HE@PX_J3gL/5\]7<IJ&7)0L_0J+7SC(bX[34.;
Z3Cd;A._d,g4&>HQcS0Gfd,<YLL;0f#4N5CF4Y]LAX(@:P.2)YJPaR:661e:Q3>R
8&?NbE>JA<:-+^-6U.&A:8Zc5[IN<eG0@[7;QFQ0eJ-dIRaS@+2&Aga=8>=&Y_U)
.5HgdW7T#KbEf&1(#+)I,L>4B;_P7b_22cJ&4C8?B1-A9feYN4dG_O=AId.2V.QX
d1GY;#/9,cVJ\@Z_AV0:DMX/RI[e_I>D/SQD3<Qc[RXT92;<(US^ARK+FK-[HLMN
,;&[efPDO#cZ?=R[1<\\E_CQ/;bR2XQ[g\IX1Z1/9ag4)#YbYX#PV+)C7_?f182W
;AD)CHDZ]]?S5D&G>XRJ1Yd&e6X93EERK6G>E=;U_O])e.d>N8:;\HZ@R1D&)-YX
?\_(_cT&/-=cVBdfK,24V2;@c>g#6WE\C&bJgb3F_b280DPT;>)<NG42KdJEKBIQ
@GgM=/ELE3IgD&&)YbHS\;,4R:6DU5@.ORgH8FO)fMge+K,,)UD3LYPK,8e\NP=a
_SU]4d>ZMZPaC>d@72g5LTVR;dAP70(TaAd?]14GQbcL6BLMNDW@H]B0cY#E4)KK
0B;\XaKC(;M</Hba/8&C.KA826@X\Gd;.Wb5QN(9S<83N8<)NP#Y1A9_NWR?ac=/
@_3<.f6/@a3]A)5+dEE8#:c#GHU?]_(5R93daK@Te\JOVN][ROL^M\Y\[1_L?-aE
-)D?.>AM42RI^(W/X]3^YYVDQ5J(c6@a1_K[R@@[0-X#O7NPTE5YFD+F@0G-(#,S
M7WJS:FeZYLdCAIG7\0:)acPVH>G<4F-4CK#dU]EDE7;d<P9&6#DL0aDf3c;BMM,
TT&K)(5e?CM=CGdFb>,W4DS<_924M[R+V4#A?g/V,BR9^+N7E8B>RDN+M([5fL1a
:USEGM6X3d<PK]NSK#YQ<PYDE0#RL8&#VE.QXL=XEeg@W0CV_@Y)U(H)Z6?5++?.
]Ce-?&Z0@65a5/aUWR_N:QVg4b=T3=;DdQX[8<02A&N-&^Z_,5X#&=+bQ_<?6KS_
GNd_Y;_HO\<:SOX1_O@;&Iga1,CA(MfPG=SOPG6.9VgA9I+N8RF6/]27b-fLFc9F
#Q?:8_I3aWV-=YO5;Z#@ed061W9XgeVR0#9J73)fSYKL\48?TJS3dZ]AXK./f<1&
PfI/WXg6JgF^NF\&HB_C02T&[R:JE[#;FDa:#Pfc/1fP(98F\RE.(Ke)CMYIfPUY
QV.J5K)F9YLRbPEdLI45STMfTPFf9R31e<?5Z?#gDA2dI\NP8DAXFK?KCc9.=:K/
,9DL,bATeR&P.64]V>5AY)&NF\L9eV9B?f?\-OZb]V:_G4.<5+=MGJYb(QR5gZ?E
a;/3E<+Q.SUD/+dDAc.L8.[UdI;(fb2a,L?C).PE?&_CULG/YI0Vbdac.<Q/)9A8
Q&\E79)3HLS,L6&G#M4c9:KV?TYLf9(Y<PP0D:F5Rg/AT83=PP\KSMYIF5]1IU6A
J#f2TY5d@QBZD;)]EUZGBTbL7YIPNAOBVE=H)c:G<(?e14aZR;Cff+=^HMg)<+aa
99ad5?cb(_0UUdgHdT,]cJ#0HMW1)P-U^0W:.DDAFZ;d5GDdST]@dD=Td1;54,WO
S(6]/@>SL5P@SCG?Ef9J&AS@HX?E/8b6<L?(Yg##5IU@5FS0Y_V]#1^TO;>gB25;
Waa(7;/S=7[M;Sb<TbAH9=]gS#HDUP_AHeK3\H@9#e&X=&FT@9.ES5VVX<#-aJPc
2/#WHaG2,4#+GQ5daA?@LQ)PcT</3KBegb7CPDg4=VeO.Cf,?QZ-d24<_/_6fS2V
@8=,_&QFG7;Lg.>Q(_;6TF;G=F9#[WRLPa=:,b?#N.MYbd#:Z7=N<Q5#e64NVb@L
_A[_+4R<a/HI1FUc/d&&=SIG&cPC:UIK+>O6Od1E\8&K4G9=^8Hf?KSL?W:S(b<e
WP\\N456^a.D1cf.(db>^dW_DSd#6@(a[e:\cS#J]KJE+O>#c@9HId/.[[>LPR3]
,PWRPMM>N&];,EUggb+K[RAa0OYHD[8-1J-T#667@_<9JMa>-1,ddJ:KFTN\>ML/
bdM@>UM>>/eQS<D@RFg-&EH&/-gFC5a1e]=U][e9OFI^gWXM^Jg9<K9M++T^,OP,
<(DF2)IWJTU38HYN]MZKLQ5,7[g#KfJO<9-7eEMO,AC(QV?P[N,=()QAP41)?7-D
^6T6-LB:X)DLY8/(Q]4<P51Vd[0VeEJ<37&N9G-A-W:Waf[,e5/7Y^ca9Q]W4\dA
8LY/]CZDF7PQY4f^F]JJ7]]^C8\T1Z&Z<,Ye]ba^a7Ig9ZHAMCY5#<6=S&?f<,/Q
[9_(+K/g.1+be8]bU2K?c^,&E39=CF,\C[g&,[C;#L.>?c<DT\KNXcZ8U)91U1OP
K,a<7Bc3,;9\<b,W4\SZda5LERf=?K9<OaM+[P5,N_Z4[HCZ7O\DMZO,N.YD0>AF
9T9@CaSEW8JWO&\SYZ]<QHTf6XW05/6SO1AQ]e;L3H;/(e4;YAV[^UbP7R+f?4fI
5+8]HAVK@;<J&:DK)JG>F?3C,4J3HM:OUMA-1c_G^bGA<IBXG]?dB;RL[N27Q2.A
92U:^G^NNNKUQG,0?Z+&;H/0LV-G-.6/?.JEE3eCeQT+2+,.dZVc,(KOK,6P+F0G
ZV<()=518NGg=@RQXL4<EG\#<93QHg;LGJ\g0>Z&LYd1?U.fPPb;Qg?adY??]R3G
Me5&NSH=5gRXW6(=VaH>NIH^Y>07JF;VZd&G:(<BC547F)2RI<AE_5?33,[B(/c:
U@O:f2>+UH+c1C:]_U&EVb-(./XB7fd1]QN,P/-\e_66@DC^1F&XE+-6#_^\MF,a
C/;<@I8B:cbS.,;;CP(8Id@0PISTP60UEAF7\II7K]4JB-c-4)4X#Qf<+G<(3XOS
b=P_HdF/FZ^;f=fG?80@XDOeRPB-ZZ)VA=bSEQV^\eP]Ye>fO+:QLHcHK.I4[=E0
@:N?_#H[X2,NaT1-;:.1V-VY.LBW>B7X\[.8<VV;+Y:dPaI,f>6:5V]YWFa?7O1[
ZP,R]:8UAAa/e&ebET+]3)H^RQTA3@8OZ]\f)E\JdeW(]@AfSIgRg?YQVJM8EULO
CZ&^6HV?4f+)dX7K7f1?aE&G(TN9)d_>gcNXf07^\2:A&83?-S.?H9.7P.<JT&gM
JS&O=N-D<@g@EX)/J0CcDYC4W5SNT;P:;F@;,\g]NO=FEWDA?8ES9U5H?<c;OHRR
PT3.1./Q4HRA),@Xb8>:_]D]W5JE\gF^PS^<K3)U?AG(#G.:?E1;1JM>G6O^_0;4
G_#,XOL#QGCUF>fF+VK\^^_OO^8&K/a(BKA?HMN2V]IAS@#=08XY1@<&P]D_)Z7-
.26JFPaGcIFH:<@J>VJ+GT-^@^&Egb:eECK^0J7Vd9aVO14Ic0J<fD\.OcL:bZW#
T;dY(fJSR=^&C_LN8R1A4VC69IQI6:c82P7-MLAP(]&(3.;Ee&55P+57I/MUeS6I
^RUg#Z0-:=NB9NZ=52G.9A(-J(\->(]O-0+/G>C@5R]G>MNQcMPb,76LX?C6^^]/
8RM@#aZLf]<ZH?.B/H.Y)]09^+5eSbe\NJ08JbNMAc8L:1>&?JUWTbGc8b08U/X8
SK-^f1+EP<^TIP-Z^5]WD/\cDF]W,aU,?.SfLH?dc=,6BG7<89Q4Q]9Y1#B8VO@U
<OX^(54XJd>N#VdLFf9b<9dP887(W\XFJ,0.V^C&aKGV@](<-66113::1&72[(F[
7UAWP8\06UR<QNABIDe,KL(-<SK6Y/L@-&IC<.@T;^]);)JID+JNVLQ_-#Yb:MZY
4_PFEP2G#G]9LaWQ7JDLQ\;4YGY+1(;P/NDfUa47I-])^bNKH>KH&ZXXe)7()SUQ
J7G[PW6-@(>F&5Ce#@1YdHQXVFTf_OSK->@Z8Q)FLTb@D7?:,dC+,D..\TG4DZ6H
e;=F_PZaH/&O#/d06#JBEe:RC.c7,7]OM>cG20Y\.-L>T7M(/0<-K);ag\S,LE<=
HeQ^\C&f\Y3IZG>2(7K)21Na5TO&T.S&SWIB.SH,N?:A(N&5LFZg#.RHNLF+/a9\
V=cAN?=fA]JMFE&GSER&XTQRd9)C^KFd2.Q\(+\V&Rg<e4<GPLa:,)@P<+6Q-RWS
NUM-_Z1ZKG9Y\RadMJb);/A=DH4]b9?NO_RD,IX_C2GZ1IJ<AV2]9/ZTOC6c/f=C
Ye1Rc_<Le82OB<0P]V>b2K28e,gY=KM^CIKKK/[d7eMJTSeU(A\Sc^c250FD^AaS
9M8?+C-<+FFFA7)DMAOI^>\9HcU)ab<4N(bJ#VaGT^d8-T9XFO3NS<(?80V9+aU-
X/QJX&.fGgCPJeKfPQEW?#Oe?H&,B5UBK)]/cHLa?E.9)VR^RXN1Y:IGe?.Y&<_F
:G4&=fDJ/7SN/,KJ<,1dN/e/#cJIL)WLCg5dV17G@XX=-J61Ie33B,TUF:HL5.(S
?U\aeHT9AeZHOOf92g5HO>LIHC20R1>&-MJHI_f)YBQ\HJfTZ5@5;P3WMUX&bP:7
-@a^I\B\?O7[_e[(^98/+H6bPW&3De+T^EdHQEE?KT5PSMHe^^TEV390bW\^6M])
dW^g_gR8]2QWd\4[W7VZc:J3P&f\MbX@1QfIRJ@9_-Q>1bNJTb(Q[M1Z62Xf--<)
;0YDXOCD0,gGQD?Ka286gcGXXZXIM(b&)7(M)0e/eY;A0TAgXgL>7XJ2S3-4B)QL
^C7&SVJ11If+0&4.^U/&+eE5<7dUd<GIe/QbSV?@eX+]M+<C2FVY4O2Q4-eA..01
@5M<Q.LgH=\e;8YS9>X?YOQOGgY9]5.(8V0.AVEAeCVEOH&L4[B#f:ZgHL5gN?<c
2S1O+@2Wa.6]H/=NbT>e_I#>AOK1Fe-D^7KUD]MOQ55WQI2GT4-MW5RfW>S/BT)-
MaGRAXcJg2eJb>;-2cJGKI:<(7;+&RP_ePKYCFTdP--g1/TJ]M.,C^A)(4A5f?C,
,J/TR^Ad8H_?5@bgJ#)O;PGId^a^50,:=TWH&YFM9130EL]M1=c^;#OC02GV?c?V
UV;55J_8=-_c))9LFc1SK;2Mc4@^RC>FW+<Wgc[3A(^K].]G1KZ8))0_J7<&^0:b
HKP#9_9/Y_6+IJ<P.UJ2)2=bN+2U/_B8?,bLT.:dIIY#.5>WAG1Ng2QASF5]68T@
:>;6^9LJ/YGC)\4Rcf5R(OQU9g9:K=IAI>#>3E^=fSAILZ;;+La.6?J-8gZB3dK+
d40TL)3=f\^#@E044^?>5N8](e7=4eQAYacZ\E2_QZL37fAQGL7D3-0H615#^62Y
E[#Y^A8\OJ_G<FA8QgUUB&Q&G+_T4&3-,@GY25Q0;+ZT8^#93,=UYePMa:+f<@+8
a^#P1#^^9V0?&a+:O4)_JS6K=8D3&\O:d>aOUT/VH;XFZD-GG]M=a0)#]9<Yc_;N
e6]-;,)V>,@W#2gH:)d3ROVW_V8=;:B<84]afE]G9/@FTFQQPM1K-+N\WI:Tb.DG
E(#Oab3==H&,NX:6<K(^RV@)e_:7<XNKDK-73[ASZKg];E5@Y.#a_d[[N=O)d^::
/_RZHO34,&S:dVV6XDO)=]e.](,f#MRUN;<_^P5<L=)#XDBJO^QHD4@cfJ)5E<^M
9VPEE7<JEK87e(g_G,^?^a\YPOHX>#SaDWZBIZYSE2H;Q<PC=9Z=9ECB9-M4:9>Q
,EHTQd10,ZKM6I4aeFeQ1d0;g/WA@44ZP_W&AVHKEA@H+-e]]7E9LX(U0fZF_K^1
Q-dED1YCf8gfB]TgP7\0SR/XHPJ+CgEILdJ>[@DcP<a3Q@T:;4>LOLc>B(L+g6FA
cf>?2WQ^FeB1a-dJKSDPHMe^9L/@Dd+L98LZJR,QU]PY2-],_JQT9W.Kb1ZKE\ea
XCIHB/\0bFOXS@#<EG=6:eY#e@PZ43@./FJ/HAV.W:1IXWY/^]V?,Cd/98&]]34S
CO_G<JU88g1b;-VUT?gR^?[;O-&HSO)(G\CEfEd^1(A4\AQ#]X<XPR0ba(QW\6;1
(>K9&d<1#L,A6#2^;RBfa#0c:5Bg@EKG8e8-FP?c?H.Qd-3=WUbLe4W7I3Q4K4,C
-c?>50e;WQ\GN2P=53@]3L#\GE9IDb])&ZC\]fLdO),0M?-fe23W,#6MLaJKcXee
b9Jd42\R-FBge1J@FBL8[\D13)OJ.M=S?DNK?e3KIcM,#I4FSSBDC(:4EU-#(a9L
C7XL[\^.;gEDAPRf0CKgOfR))J8KPD]Zd+>:3RYaRS1c,MXHQ2NNfHY^[R/W[WVA
X/ED#J0SQQQRYgbXC8TIa:bP7QHEc,cN30@I@@JX&(=V,T9fPV?&^(OQd.>;&.:W
P,4aa\MO2>)S#YOa#.aeZKbg1-(3U=VBd+L/9e13_2,<5II&f6TJC&E1+#.a3,99
&^0a7G0RG3KMaT6J,&81/MbZ8UF,=18X-L_.L-XPKV/<RL)13Ha0H[MPIV4^>CLJ
=&M(1VX,B\?0,g,DDUR4YJd70P96_TI2FKQ141BZT);af93G]\VXcS(<X\CO1F?\
C8J+V8-9&GaD,_Yf24LL\B[X><NUc].?W4QZOSO1.D\LUU3ATEPB<O&OF5PPb.Hd
A(28ME_O)5[O(V7MQ#.gBH6X2<GcY0Q@9/^M6GP-L>.GIR.?1ZKKK2\MbBMBM>_-
eMP]??:ML:PCHC[,E>^1+Gag9Y;S69bD-BY4WI=:5N59MUJI#_f5c]5,O>I#U/]O
&WX_cfQLb^:7e3:+U4=(4=<J8KJNF(X11Vab-[Q9<W1Z_WF@JR&+4f60;0[5cgY/
PGS<?+P0/,Z0-^1K@R+0C1S#<1),@I)MfV5eAM]P_H6MfN.^_PA44eS#3b/(7:1(
Wf<dZF=-YX9)7M;)MN&=DX90FdVNa@(bY;;Xe@58VUa#7(-9,&A[4ZdV0(9T843S
_&=-OJ[[&c@cQQ:G[V,aPXP#Q7gUe=cW9c2.XdAcBfCNI7M>LH=1LacDKOX[bd>I
=T-:B8&:-[2(7J1^/F>MAef&+:d?b?T=X6e2Mc_&7C_QC<QIaNd@J,8)@D\PBW.K
T/UBeTGWIK=>gRM?]FaVXN^P,7eCS/;\d\S&Q<E)Lf>4DNG+9><c10#<TaN4/[R<
\>0G;NR2cQL&5+ULCN1FG)9^d&&aeC@JdfFB7U@=f9#IS+QOI,W5:UBUTe^&a-?E
#43b-<+DQ0LOH,#Ig7P#F8@7R[?V8-0/K#A&LC(3g#0A]#P#d7M5_N2BO4UXJKR9
<Z#1^0aP;ERgHKY+4^JJ(g\)-V)@OLc#_83I(J^(BLI[V_C6dHaB1D&^TCED:FSQ
cGAKII7:(XEKU:-6#GBOdSJ;F&Ze#@J2G69L+X[XG6T[M:;(?/&TCH\.CC&IL3NM
=^\F1=>&)CH;;-MgW:E28Wa<P+LGF-[]3<aeGg^5e3f+fA#.:<1K7.\W3P<VRYBJ
YB>:N^Z&Hd2P,LaB:1PTfZYabf,\P8X_X8e3M69@X-W+)Df)?d4EPUK../X3^KOE
4E/e_(-e#J?Y8D&Sdd20(:VCfQBB^6]4C+RM:dBJU1g0+A84ZSXM[9/NNU-bC-6(
&UaUCg1]/DR/_(HIPO:C5eI4QaK@OMDR23[PFFS#D@3+b=-:g^Qd4T@=A6AD814_
FOY^[H[eO7O#,Le_BT3B0DA&^<(41gW+\Cc.Lg^-#V)0[+_\VL,L+\PR[:,Af_R(
4P][=^2B\33RB?GC=<8__F#J_/;BBV+d\9MRc7A02A7V_b2EIQS^-#L2NPP75/-c
-6S.G,+1]7?JN5C)AO/C+Qf3Cg4E2e[B@cBWRJae:@GW12AHR8T>eJdL=aE9?M&?
aO\-XI90^90Ye/=9[2&9-HD-Q[RPaee^\]^AV[a<4;5Se;S6g8+3EgdLM$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_MX25R_LOW_POWER_AC_CONFIGURATION_SV
