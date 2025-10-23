
`ifndef GUARD_SVT_SPI_FLASH_S25FL_DDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_S25FL_DDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;
// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Spansion S25FL family in DDR mode.
 */
class svt_spi_flash_s25fl_ddr_ac_configuration extends svt_configuration;

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
  real tCH_ns = initial_time;

  /**
   * Minimum Clock Low pulse width durtaion.
   */ 
  real tCL_ns = initial_time;

  /**
   * Minimum Duration in ns for which Slave Select must be deasserted in
   * between Two Instruction sequence 
   */ 
  real tCS_ns = initial_time;

  /**
   * CS# Active Setup time
   */ 
  real tCSS_ns = initial_time;

  /**
   * CS# Active Hold time
   */ 
  real tCSH_ns = initial_time;

  /**
   * CS# Active Maximum Hold time
   */ 
  real tCSH_max_ns[];

  /**
   * Data in Setup time
   */
  real tSU_ns = initial_time;

  /**
   * Data in Hold time
   */
  real tHD_ns = initial_time;

  /**
   * Clock low to Output Valid.
   */
  real tV_ns = initial_time;

  /**
   * Output Disable time
   */ 
  real tDIS_ns = initial_time;


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
  `svt_vmm_data_new(svt_spi_flash_s25fl_ddr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_s25fl_ddr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_s25fl_ddr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_s25fl_ddr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_s25fl_ddr_ac_configuration.
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
  `vmm_typename(svt_spi_flash_s25fl_ddr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_s25fl_ddr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
(>_b9B\J9XD-VKW/OS7AIJI[]fEE@&QC7LBaTZ77gNEVZ5C[-M,.6)b&CNN8G(0X
eGD12(c=K&Y8<3.)Y;#,DLS]V.BAFU>cSQMS:8,BQ[?7g6RV,/=e(OMO5NKJD0;]
1]/eK0bKB&.1Vdg7Fe9gec4[6f^P)5RX8J=NFG?83G_aZ?KdXb.H>TD^7^eg_A)?
Yg2.,WU)991f&<K1fP;g@U@7@^?TA69IE&MBP/@<;LQPJNQ>7adD2a&g)3.BADAU
b=]PO]VJ6QMB)VVPMQ-@NXXdfL^g<[89c]78,#4+-SeT0KLF?).(,EO]CbgI[X<5
feR3471216SaK65G:=(<L#S(YAW&eMLc.PKG2NV=e[3>R,VW.XC&,<+(a<GD05_=
VMbKS:(_TLB)0dD,HD^fJg(Sf/^JfN/](ULfOCPE70\SgBN<P_S+BA3MV^OVgIT\
8H,d3NO,E8+JT80K+Ba\+bI-OL<Td#/c)aL(de\9F>O=YBV3.F\+4S<e?dGL^U67
3R>S<_@7L[)-@A?>TOTY&]I@LJ,P(<6bJV_1EPE/aB;==K.0S-d4BZN4_b&5@<;I
@IdJYUC:S.B>D1Q@&-W46#M&TYU(;?UI8^QfJ32EAa(JEB--@]/+:TCF5/,>0/[]
@&7KLP=Pg5&-BAd<eTR;,.VKFP)6Q#DPB1Dee6Q]:,#?\#(;:_(;aJI\_&XLPM]C
ZT[K>.BZ=g8(1K47&;FaP4^)2e)FG?#=?S0\GG<T2>Reg,<FRb9=0GHHAB[#<GDH
d?KQC(f#e(+gWFG,ILO3#-^)5$
`endprotected


//vcs_vip_protect
`protected
d/@9[Qf(EVB86KDG6Z&]A=H=RXbTX+COG-g4H<g=U-Cf^6SF4If#/(5O._fR_S:1
Mc5C./G2\M=_7aPU)+dIZ#;^AL@;4>d=g=-G(TaFbc1Y0a#SbffJL;PM9K605D[6
#Xb-f<)<AeOR;e_>R]40YN35TOO#e-1,g\?GCQUJ>^LK]84Z]QN@\V&9QJ4fg?#L
\SCb;Ra0#=bb177<5ODdU6(_O6M902K-;.BBAK(bSMbRT^K>-RNA&9a=1ffX#)B+
K0agAMHd3(6A8IY<Y7XE@8?R>6MQ]B0E?Tg9,G?ge.?TW7<>NC^fdWO5C<a#=(+[
/;5BbF(a6M4OX#a+-N46a>+KPFQ:Xc1[,S_W=T6\4Q)fIR0W#]&<P6Da8Y-.YQ=G
TIJ_?5\_RbW8Z2^?;/aVKg3d5Y,#d/+8)b(dLQ\Xe0ecK,HJHTIY:G)d12XeM4K,
E;V,>3R49ND//PT/GI;PKe-AQD1I/-.>\Z1;@AVV)b)ed01KZ=PC0YAS9Ma0C(-g
8J#F_NI+1M>1AB&gD,G5>1Gec1V=S6/Q:1aPPNg5?,DTP.??U2gS)GO&BD/ZGM03
RMD,I,MO]Q6CeRKd4I<a)3^Ad#V#IQ+fTJP_\8f>f<JFRf9(>IK@a#HC?X7f#)E+
<JO8;CC9[EL]J?9BXG&+-JV+:D<(S8:4W^ECS:P.30\U?[+@g&c7VU:&S1c<EaLV
R8cId>EMg[M):Z@Gc##B\(;5e\QgJBZ<gf>W/JD2EE(6=,9+gEX-QTFY4OF_K0\Y
HF]TYWK?OM&DL/L:<E);_,_[[8H>EL.M6-GQAOA#-X9GCYO1<d?ZOPc]54)P&d:L
_\Tb?/F?IQ730VAgB\>a6C^eT<SE1HN8J+^&&F(Q\36Z5N_)VRGE7-b6)?B&;,\;
Lc5=M)B186[@6HAG03LK):N]RGg3.-Y^?AEcIP]XSbI\W<;07d/9.5BON^I2]MD/
8Y^0T:SAC@K<1=Ag9HR6dU06=^/_Kb7RHT0.=YMF7?SR<AQaeWaY4]U<UPeU&8O3
VXOcK][J#<g<24VF+K9HAL\QWTcVU.:7OPB7=E9e[Q.]7^g3-[G6MP7V2d6YW#/\
2IfU7SdD0L5D&3aTMReaQ8Bb2TL>,AZ73\gAN^6;0GS@M0B+O?>KR9/)=>N07O9e
&TF0BE4]/ad+AK=B^KY+:Md8VQ=J5@FU/W1YZ1C<eMM9-TOU1]@6M2f@GP7WGK4^
U(=IC:(2I,MUY5CgC/;4U9#Rgc/[RDWbZK^b[BV-.)ZR[P_S?cYGR(X:R09_\IAA
_JZeIYb^Ag2?.CF?#)X6+01\F7]9EFR1e(g:cN(1E6AOgF[RM.A3aPR6V2??#d/c
H\_WF-_3K/VfV-OC0(=/QP#QF&9-D)Y,CMAY@&c[M1(>+?9&XC#ceRJRaK2XP(fg
(N:@C,(5VB<LU)40QL2bd3b=KRg/J//Ba>HeDK(V?1R(Y.I<B5)Y,Q9gY-7P)Ba]
TT2:^\WQR4.c4ZG1b.R@f;+5HOcaW?/1^@/)?K)H6=D?OfX\EJ/=3HG-_,?N=a,/
:a[QZQQQHGV77M7SB9/58Z#OOId/4(>=BaMPIbX-\=8G<8G0#2&6I>?KD?Z8=+<g
DTBQ^)+bJgV)S,^a/:MBK:cYBJHB.?^+QBSbdS=?CT],DU[DUNPfET,BOMdGSBgW
+=7Y^c677dQABHACYH\Y?55+GQXR/[;38K#E9da/PF44,)gLgQ9>@6<aVYaP:FZR
J7@6dD#JFRPa_Z1EHKL<ZAe\ZF/8VJdJ;.+3=6OX99HRISW[^<MLg_]?:g^Q#3/=
?EJ7K+72BEb#M)Tdc@1#)]c2Dge-TfD8,c=/1@UJ,,HC^-L(+M[J+Jgba<W/#;U&
3FY@eBA<AENO]cc3^eNXBB^-JSb>T(F;#X2X>@B>]a,dRfb[bD-B&6PcVg?VPF2L
-&0RE;B]MXHI5UI;1\C=<2<1P.ID<Z4)J6AO>UVZC5QX&1UARP]L[C.:&T2W2ZSD
BML4A_.^-eUM>65_<&dQ]G-\\.7QTVR>&W1J[8@e6-<R,1>M^2/>&6g3;=XOCJG?
W<D[4a1Q^62a;L9SHAJQU&#K5#PB@gQSH6DKE8_@-/\UXUT>_&N_+&f4FO^?RXX(
(WWeY=,X^TTWdQ[LCK973XfR.<Df7I[\NVV\<6N0Zc6734Z0H7YFNNgAfNU5-2b5
:+B7eVRg6-FQBS6(IN:J?)QDdf8K84S4eDS)KEI(O8eNHA4eRbG-a7b_<GWAUV+O
SadVA)f(fdd2M0fI=aOE8(YfL^95@,^=0eVP;P;28S=^b&gc/OQgCJQ:(CLNgbW;
J^#3+B/KT8M+9.fggY)W[::G2]OPVbBU,?FR?Ud.;R4f5BdL6>.N;MJ^OcBa8b-S
+XPaE1\Z,D[V;GD8/E?3C9SBaDQc8L8S[&81#OXZ9AW)^(]W#TZUBDM8HK^0,@\G
(R5<3ESTSL--PKKST?O4].)Z\:W/_+=:d/MgXQb2CGb?Q8fY.,0D_)(W)Z6GBgc6
79UMeKBg^-FdcM#KaTAT^-.]W[HK>:8(UQ<FZZ59U-[#Lg4SfQGOWM>b\CQa>H>f
4EVYNLWZTgYJ.Cc,cQ,F[aUXF\RSgN+CV2;YKR1EB&F1N:1(W:\U6;-=EHU[LcgG
e30/Oc6SW>93-^5=PC51/:X1@WeO9:c5S3#N)aG-6)XN)81;5PZaA1O+,6-fSeFI
_eXYL@PCE;e;Y-5#P4Z)P;b_SO(WR^50DVNCb6^@Ua,cIY;a1beV^GA26g4:IK52
8gG&5EF;L?.&5g/;I/b7:>6#>/LF09-,3&W7PG;<+6@aAQ_+Q:K-6(W>/;(LT5.?
\<)N8&c6+J2>0^X:fgZ\?_/I(8UT[V<J#AOJ-2R<5NEf<CUNWXW.c-Y,-SbJ25(F
MXZUN3Ve&A30W30Q1Q..&](E@_G&H1F5Y>/O.5U>2SY+_V_9cKDD[PS#cD[YVNKK
&K=1.eN7B/GJ8TVPF7<ZWD5#a);>6AMC]e&6Xd?_-f54SH=BS1BW[^S1BTU3]?((
[\Y06:f<9N(C&<J,R-f3F(7(2,VC9YVR#P9GdW9Q:#[\7PSCR48D3Y1[#@TC=E\<
9(T=B5KR22cBf&BcUH@5?2TE-_YI[(IPSV=E9EH00/H7^=?dCdc>D\MYgfYc60QO
7?5,&[eA8Of]I+,=68RHNZEZY+Q0IQF4[1.c@;gdAFPa4[KK?<]=OE=CHG@=F^G.
gL\1N)7#/2;H@g9L5>D\V]PRJ2:N[-9c66/Y&F.9JFHO9^LdHQLgOYU:>:gUL42;
ENFRS5^-,8.;D-N<2&8XD5./&J4LG/FA>f/9]5@d,:6IN7).WBG.aT97L6H?HM6)
RDO/WSZTGGPEX9GC2_,-9B:_]0^20D/5=3f6<+C,)W2M7F//aE7UL<-[0NJ0?cG:
56>^e0#>^6KV[_2U1;>0ZV\]9)OfM@VQ7d+-Kg0[1U-_,Z0V@6eTX&2^#CX,,2GB
/JUGEAc(YQ5XfPH:7gTS&eLdL,Q,?=@L>9&86f5<;&K8R:^C(EXW,P05DS&+e[5=
Ea&D[1B)SWI(YO7)5L2X\3UedQd<_,8]FPGZ<P?D8ec_+(#5d#b\4Fd5NMd6\-D[
C=(PaN1T-HJJbb7gcCXd+T0\bK)=7-7Y.1a689R\86Nc+^d7Vg?+a6PM+KAY3H9I
:C;&MRg#3.Z@W4b1e8-SJgIARJXRT2H?NA-25?5[E;ZL&:F;LQP8A0<EfW]EST]f
Z\NF&D]^RH#^PE7bV;QM97f?6B2>I-FV0^WeGJ4FIW8d5-Xe3J:<,N_;ded@&ECb
e?L/Z0X4&;/B.,cgfTCX79VC?HEO5<2[fVK(gHK^f=^_K#M]#:[311Ia@BIeU75T
3P,R^^T<DA^0\g(,A^=[-^YANW:[JG9S>Sd5(FJUG-9@2E-ILEgJ>E5HU^\>/g#M
QQ#P2CVb[dE>3ff-e_7YEUV9@WUJNg4f9)EAK6/_fG(#5MUOFU+f;VH/c.ICV/A.
33e4(D_X0MTWPL7:[V2?21ZF&fR+=UQBW0@?AH]<S;_]DCE,?+V^U1&/NB,(DPY3
-KdO1LSB;/<G.G^c4BT93c3\>&3Pb):UJGO(^^G,?,]<aSF[<1>GT42VKMfNV;Vc
a]:[g2dNIJ2F-d&#QMRYcZb15C@=9Z@58Y_G>fU(NLC77V-V/1PDb54eYb(B#N\[
3Se1A]P79XA)9#ae,7\#K]SfYg\L4e_e6V2H^H4Zg+_F8[(LP@fDWCUc(HS5N,0J
6CQ.3ARU;6WJg75#NR;=3&646KdG-WZ[PYLd,W8;VcDC#7KJH0\8NG:_4P(bQWgU
&[_.ZX[e&.bB1=Y]/O6:.e&=c.5>ZH]XXNf7\),+-N\Y,THgfF\8ScR/@&2^a[LK
_&aeaWLPb0&a/><FLXeE>bZH;MgK338+(^OYc,W.Y--E-/_aZYB(_=CGJ4.d4/D<
,O69QabG8T+[ZL8]5.BLLd4;2^;W#J?-0:]e.7&5I3:W0M&A+geBDV9;F&)6g]4=
B1HJe?@P&](OH+DO=V^,LP(ZI/^>W9L0M=K,AMC,8U]ea_:Bc^?(=NAdcW91V1,\
-cF\CH&;U(&e8HJM#M58Ge@J48M5^IZS?7(G^0+Vdf\7Tfc2U&KI^F]EQ:H5]d,M
WD32F:;P2=6P[#NYP=8T0+?KD<[&9[O;D[@8XJ3XTF3eMS#H<5\)84NMZ3B[Ig\d
/W\M\GT^_Pf&G_;e597YGVI_BMb;,2+a\;1X;3YPe)B=b@e0._Dc=@]:SL5E@<e5
U79NXI5RWQ0]5Pb0.HL6/91CWY:Z._ad)DL4Dd,[DNc8[dNbdU2XRB)TdRNR4SD3
3X+HZT]@AI[A25_KDE?Qc7[3)U+H?a7E=M3LAF4;]ZIKV8BT02UO22SW8fE_53f]
48,EO0VIXgMP+#\6ZBU1D1e6c&CXGca5)P3E#H5bUBXIV)e4,GX5Fd8NO1_T]RI\
ONO3DBB^H\UP#J>P@Mf^2ag#(E=G<\VB+5(IT^(Cg#^D[GFS/M&HXe4cE+1T[\?-
R?d,C<<S:1f;a2/.&.F)e58[\gVCR=1I8Yg-^5\385ARPdI.gIQ\eF]<^^I0;IU\
>+[Pd?SIE6BFG8fVD_e3>]?]I,<5VY+Fag:@:MP5R_AT>A@JPdDV3?8RV+-.T_OT
@ASRbP05ZF<ZaMfe@5,(P7^dXFK&/88b+U,-T&7JIP\b\+H+WAF1GIecJU\LR5TY
WGZ#+3I..#^e3.cGZL#e_&;ACR#,3U8QRfRZ-:Q].c4/_0U<R8A#]:O.6+3KK2#F
MdP#;eU_L2PET_egNN[>A+QH3TIXA_7PQ/1U21[X2Q2UF<OgPHM\Be67N^3Bg5cX
-V/-_cBO(ce9>;JE:T/d+WeNB^;Y@W]gEW+]T<^S;<25?aSH>#FT,=7Ug;1\e0/H
I&O-2H0d43WLBF.U]9TY3ZO,TF\a/M+]4M_^JCIc^,FR=2@[<#>N_d\O2DX#NS)/
9/A,Bb4IDR=+J^.&;7B^R1KLQbO_\PK4g,G7R-U7;]d]_=#0OaNIWQC)DK1I:_(Z
eMTa#TcfR(D2b8R_BcOE7OT]1P(AXKYNUdA^:TS7437f;84J?@LbZ,GJ7A9@.D2M
+K,8dYIH(b(AUT#\eH_:U.DT]@(Vd81N?MI9<OIb]^E@]2<3/M3TPHF?]J_@M8K8
F\9;\Z;2d@2J-5P@SJMAb39+JN(VX2+X68c=LCJ__Q-@+H<->.6C>Q,We<>1FFG/
5F0<cZ.GH2:YFZ2>C9)Y(K-290(;fT54(CDU6OZL?O3=9DQDfacHfAL1Y@1PJ?\,
G6]M@GeAV_gC3#(][Wg;?<G#@f_[DHU6ZNL+F8?2G-WR##Y0&22PS[F3^J.egg_c
ZZ=O\.8:YN0</7_48SBd3?NQ_J#gbC5+Pd&M_]AW5,#>LW2aC3-(M1[Q?@^K[WX(
ZY\5T5_^Z<e)\7T(?[-9J/5Z>aJ?R/FF#+,g17Jg<HR5eWc2O\:D#<_@7:2XUH+^
L6a.>Q_>J&a7I1H<US.^;0T-[E&(/Kb^@d<g#?W?:cg5#[V)fULD>=^KLb(J/;8)
W@#XT:LRL(__?UOT\f^[@@A]6O=g:;1HegL:fV5NBA@@K]Q03A&4BHFGRa7N2I?8
T>B-D,ML;3L5I<b4LW.Z8?NI]5)BVX@GIMTN3.LMU&QC[H:I.6T63cO@RRGEBf?F
3:.F?P7c1g5GPe&+#IMLVe7Pb+e<c7#21=#IIaO[,([HLXSHaLB(B2GW#5)<Q25R
f5,RRW(;^<O>W;e?TPKWX4[aR4P[I)L<.U=Y:5SOe_R>H4[f&bb(d:A&#g)GA_eD
[+SN=^f/,fPPf2^]08a>C1#g5aCLf4KAEM:Y7VG6F/;GM5HXCA;(+YC.,a-=^:b9
NF<7+8-Y=0(gR&3^@PK(T1CR^]GQVf-KV-f;DTU.XFaVXe6>8dXI2c],,:]R)@P>
c-K;SYF-5]e?JeaQ4/<K,Dc_L(<M[<f73G<SQbV=D3.]I-J4R5b(IR9S\[fZefK1
Yc4(9Kd3LL3J\&cb?O]fgM[^78@WK&:.EU0K\B+e@Q=NGWVBeC\fC[Y;PJ>[).b-
M.WRV=][2#/ZK\=95])BV)8gaL8c2.8bA-Ga&[K?-1-]c=KD]ZWPHIaIFcZ8,[:,
2HTQ?a(/dX5W?3#BPO&^J+#?a]0R#>IPB:->Mb:23CEHL)8d#e3GWbKD:\:;b\&J
=(JK=@SDZfE/2VSW]A-8,]?UAW5fV5P]G:A/^DU#TKNZ@F/=ZASe,JZIFB:3Z>f.
//6WZcN5JFQAW;(JBc@;Y]M7WgZ^eU4Q-LFQ8f)\AE6+A:RA=L6\TRf-(;bU[220
/aJQWS#a1XXN1(OF)Od0gfU<_g2<dd<+/IZbS#>75PYDNe3HZ:_6A/a-&5K8Qd81
EKLZZHS31daL9BD?XLe.b1Ib&V+8NTM,V[@P5-g,.9+=)0?^2_/BFF0Je:Z>0ZK.
U[PWBK.:9([D3Ubb=8M4W6;3E)XG7?.J)Z[>NRbH>gLBX?e6_4G6K,0HQ1dI:B51
f)Sf=GB>Le5+VPPP9DQ/W7SMQf9@Cb69EY9O4J[U#Be3F29D8EOV6Q0V2b4@gTV?
L7\&SB+1RL[USg.MH?#5Fgb3dT@Qg;V?DY9.9GB]7(@?>U]WRVAJ]8Z?3QeV1J,-
a]8@HJB>ae7H&B&C?W5Y?7LYIJKHdC\G.c\2(-?V2M&;15+V9dbMX_;DQBE?bEY6
e&1IH[6:?2>b.gG@R_gc)<2-T,_3SO_Vf1<>3,V)23T9JO3PMK0(QC>aCWSKfgb[
-V<KJUUXQQ]#c)17P[^WGJ.@2_acGY<^R3-+Q7UV<HdLg^Ece3^,47FaGRe+f653
CgMJ6\I5?-WXJ=f9SX<HI]T(J&Ia(BF/QU8aQ;8,B@YVN=>59g:J9,/HBe<=_SR)
6HNGe:g-X-O76_]E=?6HSM8+BWcX;B;SM98DB]2#]d9M4T;6.:S0&M>+D4=J/(21
J:eCdeVC(_WW^;;dP=F2C>TX?8dd>+X&;Jf(/(Dg&81D4Q5:cLg&&.09QNNE20M#
\E6Oe=XRKd-+Pf^ZR&+QT8f+5K<BJ:RfLK>-6W_PT_HN8SB0@C#HAR&#cf&(5C&M
]Z=(Y5,CIL8)BI\74baNG=T8>Q4@O/N57DZEG&3Q4><,C[-,7OA9?+ZIBZJ)4]2g
4RX]Ad9U&CF_0[SP+a<N(KHPR__I0E@@F7V^5TP-GXF#+9=NJSFUPW)-5(--+)6b
=0JLbECfa^05E:+B;UK@?.+JB,&G+=N+RgJW5ATT7;eS+C-R+@3G39Q-I#W,>LYI
4+<LZea@<C)]30PbGU8PB(CH(0EGE(R2Hf[=E_/FggI.1LK]C#=W;-./e]Q>GT)J
J<./dd6+H0(cPKI6bR7@SBOKIWN2I:.BI>WbTPN[S93.>#N>E;3Q6B#S/=2+[\OK
H2=NQ/3CSS)/+aB@V802W13V4KH\O,:g-Ld/#Fc0]9E\&7F3g@HQ?=JgMVcK:Q[(
IB_)e+L)/A&5bd3gAYe2c8SYA]@2INDcT3KZ&FU0VgQ6]1OgFD_L68#f)aM?W2bb
E=WaR8C[(N:(Sc7ZIJY3WX)b)Zb,P1Q5IZZA#_\]+H_1NHTL,)>+KJM)\fUYQbOS
S3-3cLGLV40___cb,^USQE^8KK@35C&+A:3c(d-JU.d0A_JG69=Q,-IV8^=9O^=X
T@GUe3#8M^:/M6P,X,<?Q24S1<&@9TG[)?W_0VM]VSP]O4<G.6dP6>]O4)de4Q;^
XY3.V<UYK1+H85>2X6f0\^7NVSA3<??YeTaFc\.(4#W]P;+_+,,(ec:PZITP)43S
>KTCF^/[(JY23A;7Yc]?:O,IU<KG0^]3b)JA2QB59O02(NQOQ2^]P]]g\a(HP&[a
RbOMfa,3/_;c#M2Fb#W=U?\FF0;a:g9J^QY=1VgPTVJ;Q100\ZTDWY2]1BB0B+c+
LNBR1&7U1EQF,PA:<R[7EVVE.V:)>;EK#)@N]SW\.U8-?JK/D<:C?(T.IT6bD[_)
)f]20(NY0=P:D3)F3a:V3dG7af-C7H2:O^3b/Z<V;AQ^]8#HEdQ<Ef)@^(\.B=QD
_B[(>_K:_6=UG;;5<I@<EJ@@LTcgQA:R3cI>ASL-A]J7WR\]R(SG1e,684?H#X2>
8)/)dF3Q#L)L5S3NI_39Ze.(c3eH8F2fJ)T(.;#cK7GLZ(FK2>C-J3O_G\Y[.477
d(+QI?Q?&^5dF[_</MK3CSCL_f+72R4g#FeN4D:f5f76HP>+NQ47gKE/_Q#-896A
,Oaf3f?G4^I87b&f,)ZeL,_XC]Rb?-[TWNd6)2dC-?^Z.B>9BE]SMLZ.WU@L@N&S
^C=b#@/cF7_R-c_f-MYM8&75LWVb@^&-S+9aE4[=Xa.&,5Z+#J#V]/H,c:R&LG9<
B@:_[4U-#eB#?IBGf>63gW0,GCa?<^U6Xfa>eQI\c^K_@/GKIMC-QT3gXdLVNc0K
#dR\:T9W<8/?53P:,c#C+bR:O=WS\NT&7=X[D0f&C)gb&:Rd0E8]H1&M;b2Xe)Y<
&(HGGS7,gDQ&,T82+>]IW6-Yd:gI#]([.RbA-8#2H7)a4.Dd4ZKfbMg--\3MdC9=
R_RLW;KKgS6@A46-AL89H&&63G]WgQ&>QEDJZZ463=O_OY,O@a7TTG<QG#JE4,PE
[5HWN<E#@K\d\I)JLZ,AXdV5DA+b?39KfHY_4R7;[HFC4Z&K,0-5+MLW8,ZLHIfO
R5U]GJ27]..D=D_<fC\@FJ)SHH(Ha7H937F[ce45\BAG<S,=+&@@fPF@ZR7UI3)H
+d#YIg1EEPTS5/<[C)eP=)(;B>8.HcOLR&(P8YX)d5XM01V08?a[@FGQCW#PbMQQ
,9OGeB,8a1SEG-@MMU+#Wb^LN7Rd@@I3\+cKc&QRc4aOV<T+e965fYf5cGS+F]9(
JGeJ.X(UI>+;7_gZ+/OJNJS5H+;[LX]\S=?:/TD2K^W8B>.JVZR#NF8d/bUG#R&#
MTXH@,OHJ8K(,EB-YdXgGfAg;HQGaTJ25MHY+<64F=bL[M,KbAXOO1IX_UAZKPOd
F<+aQ]O;AO0E++;VB3/,D(7S^^^>KX&B)3Pg0eaV\=16304#a/;I&&CAHAA^c^e7
OP28FD6f]QZ48b8X1]>WZ9f;_L&/Z:XRZFAK;Q[V^bd]=[O&47+.K^>eb7U?J5ID
N_2)@4[LYX@&gcaF6_M?SZW)F8a7<43?_aK7RBP-J5&XE?HebgDbOML7G>REEbH2
H6Z<+X95YBKQ,#)..BKN>aTG<@G6U#E9^WFN4a9J&2DNAa0C-_[VE2[N4F^G_faW
^W-?#X8.ZgaQJ=2?K:IY:>X[Z&JW5K_?FABMAGGH<\UY5aK,F^U0g)B+Zd;NJNc1
92V9ba?Eb@#MXTIUKB-UN<8a>c[fH#W]bK<U/JCgBT[a<7Jeg@^;U&9?A]VL>FIF
bB,6QOIS,ESXB&&,4=J/MW0[4MdD^J#.V4OR4B/=Pa9\ASS/6E]ceBJ+U3MJWMI(
UWfADN9-DJ-L<bI#RR,VMRg.DF[L&5BaD9DYW?(bY.:+:V#fa<ERA9NRV83^Z1Z4
B9>OZbabUZ2<8=BK-Q>H6G.fL_LQG].)LgdM0^0,=E/D3BZA.bXL-E[9MgA_J+.D
gNb?G8#M5.eBRRbBTABY6<.?=-+CF-4\LM8.Ng:\>6RWCfZ)9[8Y0LR;9D\W-eQP
I6JYJ2PbJ@Vc?eWWN)>D>DEP=G1^e<5MNAQ?XO5VS:9g7:J;0+3WP.7Z4._.)IM7
,MJ-U[40XdFg8J5N9AZ+;b:1Y3^bO(ObAOfd_a=B#37)\0&L&VbH([)dffR1^0PB
0@V:Pc=Y1\[ZJZfIbFQFDafPY9-=)dP.L#EXLEgD4OIYc_UgE.?NG_]/+;^UR]7<
SU2GJMNIPa=##.\a4LA8IAVQ_g>AZ-MCYBG-=4-C9Z+eUJ?I&?e)_SVYH1^+7&Qc
/Y9aL_@;[R1)MD-,=G\IaZB+IH=9)KSeZ,QI>;&3Hf9&AcD2=gLT;.^3L&KT7\+9
8\70&U61G\=S4[-]Q+C+W)-\;\H8\#+0+Rf>GYSRMf&X,XWf);fb;,JN?&?H]BNX
/V(1EB5GBI5K_55[\-gJ\:_UI<gE_QCfH;(?QdG)X3&1gU\efJ6HgO]-E;1X[K9#
X(E1ba->:aaQ^EVcH5:3)3<<-5-:#UIO,G(4V9:@C0:A3BX:K(#RU0M<G1@Z+e\F
?U9T/cQdZ\N=fI^0^/7&fPb7V9G6&&VL8I272L^^+XQ@;&P_aWWQGG&WVaAQ=f.?
_5V8LCY4]UcbCMJ0#F/WD\(EFMOO5LJX?MbB-<,<,(+bS:,:7VVDU5C)ADQ8;f6P
Ud>BaUO-O&XdJf[3&96-.?Q]RJ&#NK3g=B/?7H;SH+FB@dX\U9bE]GR4OGA_.0g4
:bAAZO^I]&4]72RVJ6SVQ?dZ,[.CGgU>=36POSdA@;E:LdSHV&2<[aa\MeW)?:[2
C:)AH&1R0]IQ=DB1&.=UJbf1]ICdaX_57LAXbJMN00[cb5D&L,_.5dD(0381=GY2
K0IY9C_bO.>ST+&BU)Ma@KO4a99)0cWYQe+F-3<+>RC?,H\>bF;@V66\FT4LAEd?
Y=D3]0MH1@bVI&7.fcL,g]INBad#TQLg&BM=_dcQCcGfG@NMa=H\10Oa<O]?_5\a
QQ0=Ub=M]@[/]I(dSM1XUZFY76YQ[cK&A5d3Hb;TBDKeaATT>F\D-gdK?-W?)N,2
[9.PLg@N-g0f#Zgd&SN<Z9g[Yg\-)(N;,OB7??)ZcT1FQ:DADG6@B^c8_eW<-A=G
))E:f0@A/5HN,b<C>X4Rg2S&;V\E[KZ19L2-cDD\4b?L<EW[@5LX<HNM&>XIXU(\
B2R]Y-2H.FQL]#L(/f>b=H5X;E6PdA8^-QK=D?AHa?L3;#)gWWJL1KLB3Z]:X/6<
dB<SVc>2fCH6Y:2M-266YQRHJ-(&2,IRF9(#0IL3:\T/,[NHXB(]K_=PLKSaSGU,
0Q]2\V5+>YK^Ff-WdQ+1?A2C]00&#7b3OWQ2CDJ]ec-767b<Vd)6N451J#]1ddS?
GZKIU)e^<G.J&g#AbM4H:/;Q^b?]-a:>Beg2L7B7VTIX?,4\8=[;:E(eSB>HF[&e
9PZ:-da4R?X/EE33XJc8d_OY.b6WGG?CAII[f0],,F.ABUTf0_26RK^69gTS.LVE
c;J+\^];2a&Oa>dM/<7MK3PF2&7L\7TP1:\CO>5:VNbTFKPSO?BbRNP6M^,cGd4g
<N233Z4gL/@+6UZ[PC^Q&Ea5\V/SSR,dYX475>L8T+G5W^fLT\]DX;PYDHO=WC:=
5\\96JI5HTF[[d=d:bNEgF0IJ&KAZbM^.ZcL4JJ81RRLRX5&&<F?W-ge)_WVe>A5
&>df)O#3a/3@,+f6,LOHDAS7]C:[_F_C.GS0,3;8P]DA91_P7HK65KO@O-#C<OQO
bHa7KWB_\0a3HIEgJ7O3D+/,9@]H3SdT8M#aQ6>bNX(A,(GF38Y6=,7V[2?@F:&Z
bLN5C))fde;MeQTP6Ld@5c^dQD3c_0@_(P]?YDUffJ1FUeg#X/^1JgGHF^\Hdb2b
\146Ld&(4HUQ_ZRf>:]G0()[S5AC:d[e2bAL/@_G]FA6_gf63&MAeC[+J+,#22Oc
?YMCgJ+W[-T?H(X^?;3&0.eD)>[[Z;YVb4CMe7:gPbH+U_,H&UR&>A+Q:U,0&)WB
8.428LG[<.I>.9TZ2?(+Ma;=TU)+JO3b-+NC4)4]0d+T\]fd#ec1;V=4J4bM-9IM
GbW2>L@K^a\IX)CB165RKCA\-0cMf2G[]Ia;4N<Q)5fT8BR6a.3__@e7W25-6gUc
-_C10e>:E>H=BI,1&S<=?M+1-<SEPaG?UgQ;V^M6CZNX3+bYGBHb(A5B/KS3>gfA
_IYXZ_]G]WV]9Z>X=P;.9e9IGC\5N5X;LB(Ng]54DCRYU4c/SDc;aWT61^?NRdU4
Eb?+?Y:Hc^###\Y<I=.4W]],LVZVSQ(A]B[DF_^Z5Y\Og>^96FY9V;g1,dJZ0.fX
1S7D+FSI1AL?b>DVX7N>2ZM_K4=F(U566+]QSN@eJN@^Q6I^(:5<\BeNb/-7YbfC
?<LE85JGZ;4=\=BBCe0_8cK(RIZ8(]F#eV?gN#3=PgTZ?@3T7K9#YSE+IR3OSP5^
6,S^;,e?JUeg-SQY/,EV\PgD2&;V?]_?^_,dL+:=J66&:/-5N8:5FGVA\JH:I_>a
.#YF_17N@(QWUZN80EG8HZ7XE>4d=g0,.Bf3.6adDHKNAZ@3dP?EM8_I/Q>I)6cY
SW^@G^CUaT@B\4JB5Q?e3g/eEe]3+RJ=CeY_-TC]KX;A1UKMQSI#[I>A0?<AR1_D
#-LZ(#>;V?L\TQW,\QT)@B@11?I4>JAaYJ5]@N_T;L3Ag9La?,;1>0>P\SDR<\=:
(=<Mb7]-6_]S>/B2V.dSZ_PY1,2g]6,1b3=S9\?O\0AQN8<c>KL-Rg_fGK^M=D>-
VQb1JcNbPLR/g:J]ZKR@BY7]C3+QBH#[f,>R(&/YU(dgV9D4(d[_TRZJ:RMH-T[#
\6+=X.LZOXE9,dbdE3g,68T],2bR&P_#4&16MM;8Dc\/K76^;MdfJD1N\d1N_@<b
IbOHA]f4:ZB-N_3/XF@(:-125^F2PaOHRb&S7gVXb6RK3++gObV,-NF5L.I[-<g3
Qb,cW0eR3GJ4G]8e_9[(\]cA3;I7^4>7bIbRZF[\&FCFfNf]O+-XN8g[SZ+DT:=Q
d3(>UW_026E8/\fTRIgRJa]^d-Wg&>#c/V6)[<<98LY(5f5&X\6Y/&#^VcU=;@2[
>eaS68Zdab.gfYVJ_7BLSGcS+cIfK5Y2DTJOb.IC9&1NN(a4V:/b]]>/2C[?-e1=
;Bde,ZQGVa2>;<9ZGb_UG_ULM\d_g1NfLJY(&d1e0R?A[]YM(L.cag7g[/AKZMK2
Q.a=bKERZ-EfXTg>@?]ecAEUDfXf,P^)PA_\9YNYM[Zc)L[^.EEe71X(afC8eD4C
<P[+P?#_,44][C)SOc#\ZC8c21\B:&ZNB)\EUGM1/>D,2]DIH,3AKe+0]<]>dQb[
S:cPL>(c?Q7WT2HZ^LY+M2fDR&8>;.5Eg@6NW4L0])=Pg,G/g^45>A^GH[GVVVBT
\TVa^]S4+Y[;IW6#?\[)&ISZ]TULI&R6)&LH-RYH1<C\0=dSR9Kc9JM;1d7bN;(+
A2X=58_d0bZ):WOXW7LFVF)EB[Wb0Fb-\6C_V&\,dZd7(1L.W]:a?9D=B+e>e\+O
a5N8.0:HAZTAL2C+S0QB[fg0_IH^&#KKRb8K7dE-aQU]M)L]U&<WEL+QM?:0;K,.
L3P(H?4K?E:^Lg?4,;6FKT#Z[4JE6/,4.Y:ZBL&A]&,L/3>CZX6&X\EO+aMVQR]\
8BTM#,]?^Y=CIbBV_J7gA<BA]:LRR+[KM,c,QYB:BaU5;#;993bJ==NP:_f9[f4T
K#F@&.gTc^8c-MMcJ\,=bg;N=g@eY3T@?.g4XY^9MA5&[&a5fDW6G>\05I\O4L9^
HX@W#N7G9Y:0e\;9H[.eFBQCOUd+3-B0VQPN2F<0T_R<OLa=S]1B<VaN(:e70=2:
+gED[[,:N)+OQ:58U-)KY3:9AWE<#YECG)1e\5HfN<=;IYD;ET9BBUH=@#7:I-S9
;VQgLN@K_g.XbE+L1@^Q7FTSY;(W)+JQ(Nc-#6&Ce\Ge8Q2b9LB?]]RJa6>C7;=E
QNX/aD-2;YcQPW\_1\_3Q#VdD]&,HgW[?AL5Y1)+:G;0#_;W_D(cd(@UE+O[NTUg
I+IZYPPADf&[YGJ]G<^/@QJ.\__I=,RKW\e_UceDHfTHR^I5A=aa<E8I8MEBJfSb
(D23M39eIH^G=eb)->>[#DUIZL/MZF+Q.WTaTA>1U/KS13;-.AR:d\YDS1+#KTU[
NLD_&=7+SRB@C^J;g.Gd.IWeOKKIA<2Qc^P76&RI2AeQG<H;ZVFX]eaB<^Ha)>5;
ABfe)TFg]aO(;^?3ZCcRb+/K8X./8V>2IN5]Q50JLT7<+_,X=f7c>:c.+BXXVS=H
c2/PC,=]K^83BgUYI>VGG=0c5?0.K8J@2D9X.7TbR<N-\MI.],.XYK4.-74&S<>Z
39EE6=+FeAeHQH3CN-_-G(>JAbSFI#ca:IQMR^&aXFA0LU(C-@f39N\).0B0f>3a
58THe(-.MC+GNOcV;KQ[1fLR<HB6ZA6IC.Wd;ZK=1;d.UW)g,)I@ITB-5aD6NN2B
A1fSY9O2A:5LUIZ1dQf)N#bP8=&f6W5.]RGF/K(]3L&BLEcD/,K#.MBRRH-,T:?W
4X?(CJ1L<#Ka1VbVad0U1(9cPQ>>bRH6_6WHcFW]?Icf)^WB+9d[6V827eS.OZKX
A/XMRF#0\=^4(OV<@;-@52I2Fb^3M;cLD@WLJOcYQB1e#)^@N?W#G.M)a3_]<AVM
Y:HUNbg2)eI#&V#3=:5dOE-c,.ZC/f@D8&A;SJGUSNRH2V4I7DfYNe;Z-]#PWe34
T5Yf;TES9K.4b[GF>B=UNXG5@E5_3MRPT<T#/9ZJdA8(=d->&9<SN8?&6,BL][4&
A85OI@4VP-\P.Z@(K9O)Q]aA:Z(2)K;P@5(2^a]^(88_D2ZM[RX&,-dFTJBgILW6
B3UMTcRSY<@G)\S=_50f>gO3),<ESSb\0^a=aK?f^PZ[GE+?(P:\^7^3eUYI40eK
GU#SJT]X;A&[KOFC&T]\2R[5-1#\W=YB@)6#OZS8KG?/0\4O8J-0cd\J.0IbVN4L
T/Oa[gHSd#\.,b7U@Q_K2?OVe66X/V:)A6F>YU<6dKbE8YcUT\HK8++4_>D<@]F3
Lb-9c,@U\]D(#Z[9_Y0fL^KD=,/fH7\AH\7+56;ZSe]&[&9^M]Lg9./+7@IWf4GK
CF/aM7_[+^KcI++_c/M0(IM;fUA#>>Y7CYe?:HYE6U,,[cA[ZNG112.R/,a2M^?M
H]ZYS?e7EgTTN3-_31JeK(>1E:QDD@3GT@(D/9WLS^9&D3()-.NYS]//-48?_(\&
V@Jg&e@7fQBR(g1/M,\BN>C#aVQ/6S;7C,d)\e>e_/XFI<<ASa:aB#TgI4b3gT->
Rf]^Q>Y-&0RCMR=V.F_5S8aOOP[Vf:J.bV:EaaA:L;LUH3X\:cV]H@2:E=_LR<gE
6J8gY\:(._5YRg>F,P_S0X)J(:K9egS]]SdC&/,fNOT=[PS@Ua2b?@R4]Z1eFGb1
]T4V+E??L<E<H=WDF7:B->@P[AT?LP^EPcL6?S_;W2<e02;7<_?NZ)5cM10=dRL:
#<UD-&.dCB[@dVE<:;:08G>UNHO5\S0[@Y1)6\A60J3AHM>,[CEUMB_G-d#fLBfR
,O&M8dP:,Nd(c?C)EO9R1PK^RPF&-3^:fFALPUZ#6H#N#&8JJQYC5EK7.V<,Xg<^
)=H@La@K]#;(N5QbdVYP26V-R8-G(gdPF:>LNIENZ>XEBY<R\Qc]Ka5B1D6g\)=&
(FQ=?KR3dR^WKB<1I)Ic3358>dG01f;,7=1/Icf6E26IIX3;d>gS7W<c/ZF>Z5CP
-d<e;3b.c1#UR&c=ZUO0K;gQD/dL<<D.>Y4I27[O2gEHd730DO7[gb:HF#P)9.\c
)Q\,;b6cBD.UMEB/ZLS,7E?-M]&&X7NXLG88aFa:/>:79Md5BB2d25\?\>V>9@SN
TZ>3D,@db;EBX#))a7M24>N5L_H.+O0@6D@SLD^_Z(C6)+CMCg&,Z1TUA=aOLFXX
NbCQF3cbcfN=a=71HX<XRAY-9(ad\28eERX07AfdY2_GJU_9a:+PafN6-QV2Pc=g
Wa;a15EVE-V#VL:4QA.AM\&=RY5H??Y<^7F49\fYI6GRa_3B^N#gR^VD2>ZQUaSP
-a7GSP3N=4>DBgaBd.Sf2ZT[@U\:=,&+U<]\]9_?_KTW:\^M/UBZS9&0>J6<D_E?
W@HLL;<)3:a4^/2LPZX+XO@N->T[L#eSQ3WTD_2g3EJWf_UTf7c>M-1YGG@5MF7W
f^LNF=M6Ca;,TJ^1.2c)cT4-0fVR_)Z,?DV4B8H/R9dW?B(e:3M2UJ32E2A;./]H
>92_7R8L_EFD=R_b4Z)>@649981GG9^W3F)-9Rd^XbdfS;eb^)U]YP;S=X_>:c\1
BZf6U^fbV(L99[P>a:eSF;NZ6WXW#;-403B)ed8_A_1Q@f[(6W-He].M_L,BN(C#
0^P0RMKKgY;HJ:=T_4[:HB>K)L8J#=(E\IR@CF]8DT+-^ZgUJTR/<&\M3S8CXQW=
_FC/.&OF2=)C?eVTXe?8gSI0Cg4XI^_Tb-Ze)U;]^#&BV^]bNN;(+BVIKK5,IOSF
L:4_Cf@bMKD.#dJ]/PWPOd3d6+MDA327I]>VHW^Zbb)B=U_0eZI&gLb:7;^)=RT\
08]^=7GPA9KJK>_5T]20V5UJR0dF@C7=aZ#FbcRQT#)>?O^3\K:_+5=M5]Jb6??_
C37]W57;-2I[;3<ZJ5QEHUT)2S_#B7(7JAS64/gMCJ>6EGO<N04-_D7@a7Y:6<4I
54H>W6Kf/SMIaF=&S7aSAfYL&+\[7fQDE1Y=a@2-O)7O&Mc\10DN7DX(Xdd9:ME?
f.41K7+\&2V;&/(Ng)<92WQR?g<GCU)3W(8)2/UBXVBFOGO@@SN]^.=(Z63=P[PA
d6ecF:U./);IB3Mc7PC==fKASc((3B2Ge)VF]6J3V(g,J,4JBCg_/(g8IJZZNcX)
5RV@S&BbCccW8JL]E3QKgFcW+b:./DXFZ7dM3,_^^[?.IYg9P:1ILG>LS:JN0EBL
E1P[U\M^2J?^/RMeD3G)<5dK#BTLF7QcG^83?V_.?F)M;M-UXfW0+G4MY:XfCUG@
TA+e(D;<RS7d7E#W=I3].edYCN?e476+de73d,@8+(Bd(1AXDC>FLX\c8fM4d8?M
+N>&R9YGQ>L[8^NP9TS]:bO##?M>#VXMNdH/,-_Z4#56,8TE@.9)(1D&Ea;Z_-\K
6XB(9R72@RHC-b&dFA+e=<_PH+[Z\SaP&A7<Vg-[6U)H@=+bE>@G.16IGL@AOLC7
RA9O37_>=WXGH\6a#63+9L(U(=_97B<1T_WWbKL8AeNS3e46-LA_8F_S@e3AAMNS
3>QYWNKCHES-f7McBW=Kd[/Z3QH<7(JdL^Waf2eKJUfTS98\a3;bbL^/0?ER&3;\
YAg=:R(CL.?8P^T01?V@S,@]7K_8cETU^;>=SMH/TZH\B.&>JN(G5W:\YF3V7O[9
A^&RZ=gcF1X[XMRcfTU.=EO9DWEI#9f?/WDA@T^,C4K^;[(fg=^-gZMF/)<7Y[,6
KRLQ,Q^dC:3F-HbNP2-P2O+-E=H,dSE;^:IX)E>N0P00VC,ZIdgafO9N#YVRORga
5M0IZUL-(6XUW+\Ob\AA<;=/Y]\2SE#f+edR_X5FJePTHJ+)YBLA<9.^S?&HH?gg
HcH40f-ZSI&)b+<:bTQLZ^>-95DI15TIRJH?-1P9b0&#;f&1)Bc7)gHgbPI@62I3
caG9T0(2]6]XJCA;0XG6=.WCNVP1^-]TdKDIQ/Kaa5::0Y)eBQM9J@#SOW:;861=
#_WR,9\LIX5A5IBe80^IWEMEg;#5e=VCYLUCaQXHEM)(@YfVgWf4]d.LD7@0Xa#7
=WeV6M2G06G<;+8PXCFL;9KOXQK1]&:T,B6/[GZ)2B0IG5\&P2cW0MbV9R^:T+IJ
I\VJY7aNR+NFJ8Z/8,F4[[GJDQc2JTGCbb@9MBYGDR;=]eT#9.&gW2JGD&6F:QQ8
BIU)DJ:)3W3_SC8AK^GLgYNJJERJ4RW?0PbO<b&L2)Y@L1N&RccK[\,D?.JMCAN5
^gZ=F_0a_^W(/R;@TdFQ0=DZRVER<=0XaP7e;RB&NQJI)#I].d\-5?2bcX<6590V
1KRI,2bIKGD9Mc/gT\1deD)>@b(g?Ne__&3,^;J&W13K#,SA),SNW.&#Z=^7V^K2
LT>P8YJ#GJ0Q;\O<LJR_W(.PNgUV)1/=9.X3ff;>IaZ1<8@()8:^YJMH&L@F>2C(
eb,H2bDcdX.4FN^A1EVXdZJ7_487ePOB##\K2R:@(L@@cI.JS-18NQGc.(U[(,fF
d[RAIB@c_BU0ffWI#bROa[9:3Z]a@##f9F,YI\(3S;8ebe-YYb==T0TB3\G><@/=
UAMKE0H1L>;<;J?&0U9e;_G[-A_FX?C,/YE9MR,E9445(f/3MY/FO4D/HW6HK;#/
U1AaPTQSB(F/8<LT(PDJ@:UJ_H6XDN&SANQ2]GJTN2GcD7,3S=1A-UKM_7c^YN+\
IKdE?_-<#+HVMf&AC5JF&:#a-ZG3A<L4^)>/UN9,U+?;RPZ5.4bePL?Q=4)_g5T[
GQ_>,.IIRdTZ?C#O:b9eAFF-@c1726cAASa,F\+a&4NOE_->]?]8B&(CI/5K&J\<
M0R<@\)3K+ddR.-Tc[aSMfWL@3Zd0[FO.SAM(c,_\VML7=C,1JPTX.6:2?X8_>L:
M;dgKRR^:Zad)cW4bNFT7NTdP;g7,=LPEeBA^/ZG<TDU\IC7&&Nc2]EBT?8WICAJ
<A9MXO01H>JUFB4HK;_BSEcZMaCDc_4S@/P<8-8YA?\D<bXU79a[cNe+GD]66V5G
6N_,5>=WN6eXN]=]V8;::8])CNfD<7YF<F,4Q,6.X+BP_20E/1c2B/YW0(]\)BY#
W,JOb,YJQR.XN0N&BXQ:EF:Yg0WgGJZ#[c(2152D)KXP)7B>f1@P0TZd-<KB?Ug>
9;CG-_28[NY&K^4Y@g):S7?S-g<B&>&PGPBW?+bP,?Q/L=T_)DW):TWfV><XPQO;
]#L<fd(CcB>F+SBM/MdcJ_XD2g6Xd<]eJeb:KUGg3+]dA:&URVeL(35.FL2-ZX0#
c.^LC5<AbW_/ACD2J,M7_AW8W0#EN0P?31LeA#8G:,EI?(OcFbY^HgeW<PI,>-UA
V9E]+QB1\G@961P@??;=Z/FX(SG#(c9A?;)=U/)F(ZbCX=;d2?PaE0ELB7f+M38F
-^+#gYB:0eGZQ6C6J;RS^=4/JP].^]VbI3T3)JS8TeZ-b519#<aTRe8EdefN5+=.
GUff5O)&\4=COIBW5SYKOcM7)_b1QZY.4FdIc+.3G.[^GTH0JCfRN43J]9I1#+dg
Y@LIK<,_356b:ILDL:4HD=YK\1E43cXT?#\7@E2=GT(YJ62]Z:dFL>)PH,<g:11g
X[QO^DeZV>I77__CAYEMK5V/)FV;?F#C;\/RWK0F(LN::eV0Mb=JHbPXB&\<5.]7
I>5Y5^I&)VZI43X=#=,OVNZ5=7YgL)#:fL7;>:dDe)+K1>IF4U(\69@O071e\Q@T
.W>4T7A#.A[RHdb(EaOVQ>:81EYVG68NI8],K4T<AQ-bK;0NH.eTEcgF.L][(O6:
)HABXH5_?H()LG(,7,P8fB/9A+ba?CBb]P[10Cg1WJWIL(aDUNEG;-N#d#/d9.Z=
U]feIZbBFa9OV:Y01+)4MGYO\]9^9B9TL+Q#RJcGGNbb2@D:6IgJgNfQB+U?Egd&
]WB(2F=\].R[O3AQ>If=c&EB:9RA)/^;1R.1[G31-Y@CAL,9>08[1V8.#H(.BEfL
X-GO4L/d(:cN]Y75cc1C\D7C(D63eMfPZ?9T1b:aCQ5e3:MG/BeHJ/9<@&[T_BQU
FSc/ZIGB4&ZD/W/<=bV(;U/-Z:B#<<a9e]H0O2U.a2?PH9E<fF->BW+AI/802F35
3-cLV-#4eDC<48dVgUaGg1^<N[(2LFYBS9?]Zg:f7f8X=f_^VaH,SK4dS.F\fJg,
8?C=X5?)^Yg[857aP/;WRfdUIDMS6FI);7-fNS,E#_+WUI\N;\OH;SU-#U,2,@@g
],/9X;X&c\f/)c7aG5CBH5FC;d0&D4a/bf0#&7gUKD.84@3gE=6Oe\3+3<T,55WW
\WbF8E7A;8g;],=1/S[8RecX3=MMV.3&HKBR&\gL8-VLM_#W)G95EJf?;O_&EfEH
N6MSNCK;AI+:6.b1^4e.G2Wc1b1(UdMgRfgF#.-N.-5H2d)>77]f:O4KBD3?5L:Z
S]#OWUY#F^g(^L)(1Za=Gg#W_)N#+D-S)SCKS8)8=X]:CK/YUTcWe,:TCQC=&4CG
LQ>dCBg-MM>DNWG]g4@8<P9>Q:\CYV?;\7I/@S_/EHCg).W#GE+L58+QBCKT,+2>
N=Qe[_6fPW(.Y75-caX,PZ.(=T_f]XJ;_5-Pf&@TTJI:FWQ7C25=A2f#K=L-B8//
PDS>0F/2_Q7]#V0G@SW>]+:D6g5f+>X>T]?(A@Q<T,?ADgTb):L#BY=A9g^69fdf
d#E)>Ne;O=B?QcY77EdVMRfL8HLEf;3,6?=./D6&Q]CaKc#8L1P[S.APILAe8R7C
MY<H&=a&aN_aLYTXE?Y=MEZ,3.RJ&6aT+&.=.cS)FMcOW3cV\(X=S5S>Me#9&Z28
ICNa+K.+Q1+(EHDN5Y3:ce0Q6))W]3(M7,D+Mf9UO_R2S+g,]CYA?2Q^L=DUF6^c
2K#bDU?&Q2+0MJ^GY_eaN]WPK)N/H[6_B#R25G-f5XS?IWZDDZ67^Y_MCND:UgdY
<HDC)]&MQY56QL=^9<b-\FLbdI^Z#Gd3LHO[J39>(U7cGYd_Rb/c&4LH;0&+A;<E
UG?bD)aOAC8>gEXUOK6g+&ZW?cUWTE@db=N),[,C[T3:aDH:6K/EMUaP3OEA^F>\
_&(ZS#I3P:^?A:R//Fdc0\E&^Q,CgFRb[(92e^#0PaQ?,_J5Fa/32gBa/@eJ@1[I
P=_?^AMOMDSV]#C:e0Y:cQ(?c=GDNQ(;[:Ff@>8PU?M7UA(Xa^,S<\4#?4YfdRc9
?D99Q]4/+K05[@&d6Gf-9Vg81<>V-@C__=V1Z2(c2(3\LR-Td,6;TgINTU+B#_;c
,KD9Q?)7QX/_&93L\?e/b9T:S-dLd(<@,+JQc1Qg&_@@dZ-?TSbAe4T:SLO0[R^:
#[.>]SDBf,,7HY)[\G?cdTIL4WKSRDY4NKY7SY9/HFcI7ccY\HU?V/D0EdWFUf#@
OaOYJ?4Y_[?&ed#3)5\;=SV:[cOcON;fLeDNJFHbN>H7?QAJKdbJ^cf+-@/6+EV[
e)PUAMP.>.0B(OJ(3,+e=1FH^D0@>#N.>X?3cDdJ>\b5QG,U,I4;9W]PAG50S=PN
8S@Gf-FE>X9<3f,B0++G4ecaa-)?^_W3&;Y[3R_335_3V>PA8B/dV)\BeEQB3W[&
S,>Ca>3F.I(Q9@@7JUC#6WR+4?O2ETbGZa(gFc62[c[75Y>JOQ9F>F4b/VeZ(-P0
E#ZU8EP[YYN2F8GZHANDE0L.b&#T_6[K2CIKJM.\DHR<=eYMB/N+^2V:b+V_;.AA
ANP33Cc1UQ;#1+ZcL)ePdH1g]cba(<e=FcG].<+<MTY)[;O4RfC?_f@/fD:Y^T?;
gN0E7ASAY#W?MJNcT665G\Y7dgWBRQ\XA-RW[\JAZ>^.OPM&R<cE_X(=@.O5O,aP
6aT-[>BHK#/?]7^+MZPL;4X3T)FL#e.B-88c<:FH#.Aa^^^?QBZ@CH]V.g#:/dVM
IEa7@>E#eE?;J?eW0Z)b\7/<RO.@DIE7DJe,?f&77Jc:,ZO-K+I+GKYW_CeeESX+
fKV1e=d]BF_F8)+<(BYK21N0&2PD&5a,cZX(S>_I1C@dCBBHZKVQ)X\TfKA;Q\N]
+9G>[W2F:>b=:@DM6RCc5f5MHG(0/6<3/@[M0-MA=DW9]GYf,VB<-0L<1Sc+8>Z^
\D0V?-]L91LEN3^G;:7_XB2&Hd/>M^L8eA?=4?9S[fa:eI135SAea40Z(e&5[AMB
If74ZU)E@78^X:CE^KAc@,O>>Ne^(ddO;&72SU6[9RD,ZK:b#+B-c0T4(MI)BNTQ
>Q10PWOL#BO4,@ReM?8ZV;aB9+CFgYgcaX_B5\_M^Ha#3?(6\J,aJ=\TU_)(aFMf
#:dTYSM@GX?F57&>G&CNSE\#5^#OS_//CDYY6Q&Q;77KfTY-LMYf0TbM:H6ES5N\
E?S35N8deQ]4FRK8#EN7[.L1MeX-<d)V<LgS9gP7U(T3^ITI_SaD6c?-/980+>de
,[X=.VI^-K.8>6;E#SQQANMg<#He#&>-0#\OL=DAa-dfQ[B_X-=L6Gce/I);4XD@
/D?_ZV)IECUWPUVcEZ-UZ.@<(@#+eH;UC2\,[DJ9<Jg1EI1_?H>Dg-<,c]?c>V-[
d>+KW(UUD[N,cT;48GVS4R7>_Kba35Z28573b_e.Y6#C:J^FHf\V,8J/IB635M<Z
X#72dL3U6-]5PfJ<b6YRL+M-)<O;AN=^cEfO.Dfg)AV0<aJ_KSE@ccDU9M<Nc&,V
6<=89+GG=\O-a).OgEU?,#c,Yd1DdV]?AQRfQR2Y6@e+TTSQID-1?5J_W]bGW;b2
&&I(5M6]\QDXGTF2\g-V4,V#AVA3J>C77ZOR9V)>W>&D_B?,V2G6SP<K\.FN=SWa
=8A\(G\\T#Ce\G_:U)S3<6Q&P?aC00R[B@70We_4);U#3SYVYIJ(:PR_0FY@c5;M
gZCM]Y#,B[KK)<D1_3AC)J85NY:I9&Y;e-dM(^3IG>(\2,<f9ID3^d)B5b9+3H>K
f0He3-g6b=AT<MaM&G39^N<g&QC9;FG6<\RR=F.;T2A?,<g5G8^AcN_P+QUb=E3F
fM7&O-UFT?JZ<>SN5K\IYDIF_7D<&:+]HK006M&)8ZYPO(._;\C/O7:cK6Y\<aa&
D/5X>JT,2g6\G2.IYF+_W9=L;N<>f58FMf8b^EVWD&U,XJKUHA?AMAVCY/.A_N\@
YJ461IM0Db-OR<dFI6JP5)Y-[N<T_gBN.>Z;d.7PA\I(EKSXCSaSPGA^(UBF1<,3
7N0N067LNX>H=]^,8>G>2.:?JV@:+RaQ=J,<gJ(U&2ZMFSV:7e&BUE&[@0P?^f8]
_894C)5ME/MNUUOV(KD0+ZCJZDW&5e]ReAXb>^D1bg&MZZGG16/+JGgGQB?b8])^
>A?a/9.N]\-dZ>T_7a776f/+R5#^6[W,D):2W6Y?edOT=?c>RL6+.(]@Bc?TFXR&
8f#NAB+c>.PfJ(Q.<KI._)DMfH/.4[5)-7fT?6C-/</0(N4Y]1#b;Y?C2&UA5K_8
5<RL+M4<IB6/E(+9SH7;=#4&@+A(b2N:0f@O=9K7&?R0Bga82Y9c54];>cNd/S/e
1+\^d\P@BO3N?Y9R>D:(Fc4S21eN2J0)C>WG^T@YM0MOb6C\&NFVMb7@&@JI?^@(
UY,-/[KA(I48J2QA9/46^1[:X(2YV/67Z3Aa^8#Y7YE^Y);)dU(HW,,OBB#/KA,<
>J>0IJ-ff;Z+5S-GP6I9S@(0U5V0YgL68.GD_ZM)O:fI]A\X#G4Z-;<Z<@F=gg:3
2>-DdD\.I+9dJc4G(W<>e_Y86W^GJWeS2<VVRI(R9TbO@A^7M1)A()#Wb0g=[C7>
4(3E+_Y2a,-DMOHAQWR,O>Fb(;SL3f(g977/a[+\U4?S^U,/@3dag()?I[N)FUJH
Vg(Y>+gJ3A6=3J+XI2-8FW-=J6ac)2V?&OG=gK[TU2-/):<c+>;0XRc6?DMXE,Q1
?dY)7Tg;eRBaJA+,W]aA+W/Sb/WON>8?Z2YX^CMIN(^D5\KQQ7Vaa^LfO[I]/aZB
6^\c^bcW<405&f#QZPc+4&<5Nc&1VJMCJRVA1eK(_e#/:S-eRB8-7S]C,SY5DY4A
+DdKW]QW3P=ZdF_(ZUDZEg/J9K,+\&f&[c=5Be&@=^f;M:D,d\6&279&C+M0(P^1
Ygdd@:#>NZ+JAeEZ?A6d(K>#b=NCHITNa4X/;g1S(OOZ@@FGZQXBB_CIHN@-_:^6
D\?N23g#71#MTe3RKK^(Q#5cGSa\/\WG5FM]3LJ93dL7#8S33UJ=>72M,V+\\5bF
7K@,JZ,C=D\M,,PDXeZ6C=9&[Y]P/:ZdcFKC1a:=^XU9OHLJ=PJN.cLLb7J6U.-)
gY@F087PeNAa+#aY4N90_N7HNTcf>HV[&+MHJ3Gf,EBd2NaB5VD;(E5F(:W/8)[4
PGHSVccSYWC6FbGa.TKGWF660B84>SVNV0K?bQJ=8?fB0[F,EIXgX?]]\ZcRZA+T
3.@V<ULEO[K:U_Q[F(]L?QOY,-J\083+-[d12@_deUE:6&F](MN2Q^g\Hg0QSWOA
Y(4[T;)cD#gI(PWG3[C#2.7ZR,/9_31RN&>)eGC+C3SM[TOA:)I_U7S]P7LQ(3RA
1A9GED_@edD-X9#ZdRVUfe5U-9XS6Q/MT<O1YeUQK^Xb-Y(S,FLG&^D-ZOgM2cZ=
Q#/IU/^<@.5#KMdE.&:PQ-=NM.F,?KNcCGbOVa8_@0?^ZD+=,TBO24=bN9_ZN2gR
H#__?+)U[a]W8V&W94YO>Hb5_aEe)DbT(^cLYC9aECP1?W?34d==+&>gU4JI&;V_
:7EO[42CI-899,4eA_(ONbb52$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_S25FL_DDR_AC_CONFIGURATION_SV
