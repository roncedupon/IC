
`ifndef GUARD_SVT_SPI_FLASH_MT35X_DDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MT35X_DDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;
// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Micron MT35X device family in DDR mode.
 */
class svt_spi_flash_mt35x_ddr_ac_configuration extends svt_configuration;

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
   * Minimum Clock High/Low pulse time for Fast READ Octal Output command 
   */ 
  real tCH_Fast_Read_DDR_OCTAL_OUTPUT_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Octal IO command 
   */ 
  real tCH_4byte_Fast_Read_DDR_OCTAL_IO_ns[];

  /**
   * Minimum Clock High/Low pulse time for Protocol Mode "OCTAL_IO_DTR"
   */ 
  real tCH_OCTAL_DDR_ns[];

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
  `svt_vmm_data_new(svt_spi_flash_mt35x_ddr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_mt35x_ddr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mt35x_ddr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mt35x_ddr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_mt35x_ddr_ac_configuration.
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
  `vmm_typename(svt_spi_flash_mt35x_ddr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mt35x_ddr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
>Fa1,I(83A1OA,]B:\269,C@K+1D:^\M^(:U8eME_U13X>C\QagB/))MA<\V>J#0
68bB]B[LE^8(Y&<#ZU8V&a<&MK\3M@Y6GBZ4/@(Z_[1Z/N81&)I)K?>EaXX&&T1G
M__ZWSEeN2F01VTEDGXUTPEUa;A?CDQ4=6&4=T[BTDFQX[SR@Y@L_e&J=8A/<3NS
MVU,?,#Z]G3^6@10G)bZ2NM#Jfe8_-Qb,\B)?Z>gcF-F6c/KP-I]0PDV8FVMF,K0
&TPdZI)&+@[?DS(R&(d+^:@C-43Ed/>1J@31X?4;C6NY4JF+N=O4=UW\Td\/DKcN
W.e(@&Sbb-UfMY#D,(?F2]?T)c2LNeZOg\7b,Z,MM2KdLXQ?N;<Q,dB?4G0aA&6X
#2855<.,Cd<2<P3\06U:\@3Y?&/f)#[6/6EG+VJ13&LWTWH#8]N,aQ2UgMI;8AWe
DHIZR(d9SY)>JDBQ6d;<E9B4\IXZT>^#B^@D+3IME?J7:NWUN#Z0(YI^]-gH_:8]
KA;03#I@a1PT6M910:b1K54K)52BRMXddFVTD0&7C@Z9ID#[&O&c+VYGH\8GFYWN
Rdf]@#EUd>R(PD]V?.4I[E.@N^P#I_X^E.:/LIgNX>_FWWgOBD8RJaE&._d#Q)U5
H]MDS(T[X?S;D)^+UT>C[L?=)=:]]R-Ua8^85E:>.P75d6-\TB/>^:A3\P]0-dFg
V34I65<g,8#];Q(cT5gET&[:TJ_H^gCV5&[^PcU.&UPXJOd>O5]<5aC^dR4NJ8eW
;f;40<aWU]LYN40+\Q=cDV[:5$
`endprotected


//vcs_vip_protect
`protected
1JTdY6;88C5>XNUcI+BcJTd=.B6:_10:0WD/7DefHLe2N[b&3+:M5(Q-].TG:&AC
7,KCJ(+/TRN^QB,6ffLb60XHAYNU)@=QOJ1<OUcc1f+OeBXN33<T540SUFc6]L,I
M1KD00ge]67bgB]9V-WCW6-5&]Bf;9L<<NbbPJS]NVK]\Q8#OQJ_SW(\>=KA=B<H
1Od[7TLXbEIUK=\<86=c#8C//,H&]6S;0K3Pb?AB5f?&I<X[gJ;aH;>f]d=:OA;9
<]DOP-/HREHYC:d\OAVLHX1]/K6]9^-E3(d@[Rc#S4>:YT;Bc9FMFgRfXF5FBNea
_31)#1C)C7<H1#a6#T6VdT#9HKdeG8V2#b;)^VbgMOBC)QPVgf?><?WSXM9Fg4gS
5;.&73EF:Tf9UVT)Z,K;\a_R&]V#?AT:<88N-@&#=U5C-c/0LSU6495_7]X2S=HL
4GL7V#,\05JR\=N:-5W+>7&4+CE,eI[0B>+FXROM8N,ZW<V5Qb5/7;5,0=6;MOVd
Td-V]Xag8EeGE4Q8V\-E_W;,>6CXYH)A(#X(EC^Ic<[KK_c^cbEa&C75G-L3Z#2\
)b:ZSO=B/I-VW3<+U9^&+5BC2@VZJ[.@d6B/<>NEb#HMQWS(d[gTd@g/X?SF?M92
QTFe/f#X2Xe.8SeE]Z:-C^BL.LDH3-8.FP0LF]+73+<@[=&7g^5;68c[B_\A<c8?
[;9&-[W.\>-OP[OD9&5cPZYEP\Y7c3I7f;^aNb4^G6H1H&4J<#4F]8BdV?&XGIZW
SESH8&X,R]-\P&/O9BA[U1IQ)(L6A&JTDQKbd;3f3X0f=1D#baOfQEcZebS)FXP#
PZU5K,W:T4Sa@cT:9FYG,FTSX=A_L]87VEa(_gZCW<4EY:^:IUSANRe[91<?)R]>
eAK6f/6E-eZ-2&0+b<Nf1-a<eSLe&H>=EYWOD&-#Q1H3f#\K?,\O,f45VAA@Afa8
@5368V1#=c[^#IP\ab1GGT1,(AV#FVH6+,dM0_CHHW8H+(-C-13?2A8V(OM@c.LW
:83GRNT);[ZZ[6CZ5aF3XM;9(bMIPd-=U)V8V./#_0I0g]YC3#ZUeMQRV#;Y-faM
W_HBeE><CJ[Y\R622HL5N9_/((&#GC<aKAEOWV(CA]cP^1_3R6+U=_@7TgAIM#EW
+@=cXbE=CCM7c\-.BVF.?GF48/J3T/:Gf6G?BXD?CD_BIOgcVX;CICa3EN<;K^C/
\=g]#d=8,<G5,NJ&Z:df.eP[Uca:.U-f)I[:?<RU6Z93B@VJdO)d^/]]?&KBR:QQ
d@#4YW59-=VLL9G6\^JAQK>:U,0R/39:P90(2Z:=GH-Bb)61?gg8[/a]dDIREU:]
)CXW\(3/T=UHF;KIY[GKA^d))T1#X.ED)]b/Le7#A].NYIC#U?=)_@R(C5V?;-)7
>,[;Fdc.P[M5,094Z[DGS3I<(_&g>+W5JNBJ8g\;RFZ1f.bO&4b(YY=fFD<[YV+#
9Z@HPAEf/@<F5<7BEc;]&2[=OF?@Kcb^b4-=J?:FZOLS9K3G)&T:@TU:5=,].Z,J
Re(X@=QOP>)PW))AKPC,/?6>Ca.D&0cDDJB,G)aXcYOOYW5\<Q]MJY4_UDN;=(BB
d2NWR:K:O];b&9QN\Gg.2X21^@IZc5<MP&7CQ19(.=N<Ea^?53_4RR\1^3Y:e7Ib
^EI#D19G#Q&CHE3-H/12\/HND@RU]#7BL8Z9,@<QM:a_VVD:TX+.&/HDCV;MTM<?
#]W^TMRS.FL@g[\E2Tc(IY8D^<Z_:@;R\L\WPa07D[7L6,#NdRS)McTdON&N#-HA
YZ+>,I&.M?;/J,W<WU-S6a2;5c1<KSKV\0f5=^dSD.<cAIDX9c<5EQPUaJHe7bgg
KR]VD4MB6MKe7]-LbT9CX\:DY[9,e]Jg5F5-G\A//==Y+,]O:QVQTV3GK<T<^bcG
7U\AD@\(_4\V?>G1N#SgO1b]5E-)3O[\8)WLSO:A1#QZ&f+VS;HB#dC_6YWS7OVf
;fC;fU&L_NNG@(8S&+<?a&X_.FV+_)P1BHFGKX?T+TN3F9/F?>OPK^2DZTV89S.a
+f6AaQNX>9Q-^7WcT31EZ-g0E1^QUXNef&TZ._A/JOWIb),SI#U6>5:2gTX8=TeL
.185GT_=(be@6d/MZSgBd9#9@PRN-E\@d>:ZXZ+WMU=G\X_Q7(.-c,<=TbVGRJJT
5YHeA82-JA(U@E6;)AbN@f&?_>5Oc?0,c:cTX;(Ig&--T3/7MW[VICG.c=<3._(D
1F[Y_Xb#-Y9<^^C24Oa/1/e#b-K)6L=gg2V5F^^-cB0cG^).K4#L5\cZ54BaE9DO
]Y^YWD9NH4&^(4ccO<9>#82X/9&(Y3AYNEMMBJ#MDAUUUS/fUYRJ:gU-@MbACFe2
c]-#R&XG5332S2\5++1C5g0UWD6I_J#5_MKNV]IQ1_U6;Ce4VU-(H=[0.?FA5Vc?
7@@@Sa?/V3<.70Q>a)W5>N_3c1^1JIKR@IAVKW<T:ZVJ:a.gY=U..9RBP-]?8<a+
>G7<bRKgMf4U=g6MTEO?[&S\--34Q^^9Z>EU8;-XefZ+8,67g@_5\ET>XT4:(AR)
bA52DJRK_>C3Ja\f3HE-^d?a1W]+P5\93a=BH.LdSR-U=;T?KGYcZbOe]L/#/T.L
)gbI#f]c45(O^2g21UA\SJD\95#(;<,E/V9_Uf=Y1.6I[ZIUT_>MO3M7fZE@9d+(
7AQ4.c#=EK+N^_@G>XY<@_P;.+)93gIQTaJN1=8@QAMbN2eO#3.EC,.PbUK?^4gG
W5]_GC08SYHY&fJ[^I6bV<.G4g-W5cf#QKGRAP2gbY&E/(QXIM=OA^D:<G4#@PcG
b/41D:deI#>Q_NHDe-;5ITE.1KgQ@UC.LLZTR#R93:57S/=K6QU6,#S3SBA0<LY]
_(2<Xe,F80IWBJ#5+8H2-?[O/[3c)SdIZ.U1I4ZTM?T>[H&7^<G6\8L\_NNDVQB5
&bCU-5_MNUA0&>0N3HO/S(U<@6E4+RcW0/;NOF2J;eT>1JWbYgG>W_66Y^M5>?a3
0,0a6PGda7f;0ESDV:L+L;e#e&Ka#ZK-8B(=XTJ3D3Y&A1+W6Y?PJ:X?H+aSZDET
]O;N?^RffaM1f?K@NCX,f.R6<EC0)DKIF8@6VfOg7cg&=LCJ(.A#XMD4PK@;1-eS
g=7f7J:2K#D+/6-22,:[e</JFHa]:PeN3O3>G)N#^E+<KLM9e.:JV0OeKMN9>R,C
IZ#GgGK3QC:CfdG8B8RF^.eKZD?AK=aL:761XTT]#B6NS0>)^b1f1QEGX#RRWRcB
E</J8Q(2L5U#ecGZ5Sa?7#1c[,[^A;IGgM:(fO,:K^.X((YK#dN\_/F0,ASYF@F5
<GG.<-G0D_NUD(8ga.X(\Qb5J80?J_M+&N3ePa;Y8b&TLI)JgK3/[=4+Y\D^24f+
;R9Ag\Ne@U_^T?O\+95U9KV7\.YQ(Q[+?5UUMXQ7S>U<@7X+)-K:4cNCW4JX=\FP
64-UFTP]7+e:dJ/,TD_?/TH_cA7>5J)&W_8fOVNU]POK2C)T+SFUDdd[:SbX]==A
>aXGWX#;>Z?]47df@OT0?(E8EF:4e&\>.fG5aXR0gY#e,28B.a([YQ6f:K>V:4)3
6I,RG=6#fIg>O.U91EP<Vd<[OaZ<O&;?:Z&)9<1Y/0D-FV7YdG,C]Fc&BM(2?:@M
Yb=8g25K^?V?[GNcFX^5]e#ZW8K\P8VB\9SW:I8_OC7ND18^^_Q<0XE8B9B/+P@>
6EW><],0S7B-fI#-1cW/5&3K])T&]D)=b]=(fRS2A0E3G4=D]6DK)8.D+IXgUR@+
P0a&JZE8^YE1bA4;:#(/S(MGNN14[SgM#SFdF>gT,)?&bc:1S,AO[(Q)SA4@Y-NV
(F)?FdT\IZ+K>;+#^[dR\C4HC5&6)g#]7VS3#^9U_(WO;\cH2\0W+Z8gIE_\VC,/
M6(E\TI.C(G5DFbgd/Vb&UICG/PXPT_TD?-7<d<edLIe.\7&^1&d#,P]d@XcM\LO
5AAYDLVKW\:.OaZGE2SRQF)0Va(CIYH_G,8K04A<RE(/OR>^##1G#(NMag3;Z<D#
<IcT[A5/9eES6VAOcN0(/M@SJ.N9QAGd20.gI^#^E;6A:O(G6(Ld(RfKWeC#AgQ9
G]/3G#@HA:a;E&-U+6Ug,&0DeHbPCE;PXKDDg>AD#GDC)C=BBd2NbM2gF4d\NHP=
D=FJS#)[>b;7I<B9>LZGb5C]LUYDfTYAXKT\cUO4T&<2QB/\\N=8/^Z/Xa[_A,]3
7_/E]5:O,dRfX>I/b3CWKD=4HNgY9M=[_E<(UG)EdAF\)1^6,L0+PPUUNL/QZ+@K
>:TZ<Me7[3,PbF+1DM7d^YE&J5^7ec1B(OX--DOGAYVdBCN9P1/VV@UE=a[V#Vc=
.<98T@KWP&[M1^(Lg92GO&+6X:/,+G/HRUO_2\LJ&RNTCP#>Ca10:@1_,9Y)\CXH
0K60dbOI(WCY[Z9TXY/<]CF+LAW=P.X_W:_JfZDMfIGBA&YZS[2aLSR00McD8<HY
PBdEE4==@?@L?<f/ZSPX53YV@GOTL0>FYOe7=a>V5R\:ER,O+=MI@.5_(B1[5U(O
UBJX[cOXVWM@B\fZ<U?HQf0KdD]C@S1ECONOccGc_TU?67EW:WbZ+]88^S?9S:Y+
e(LbRV&7)&<+;EF2g86,_=?6d2JEBf^0]07e:+^9cbC.F3+6<+#[]GPSF,7>EXHa
J_(,;3MU(G9(B>\A[HOB6fe:&8.8G3T_#J+1/c;];]IS\\SaY2D?4ePMFU>8]gWD
5)&G7bCR0aIfX?L;e))M7@I+=H5NDeXdC3_(SD[7S7FaLA0#4&7B.\B4:3>X)4HZ
=84?U9Uaf7\U->5J50\N7X(KWfSA/4Yd62?K8O6@dJVKf]K?a)5HH[[Q1LLDC+QH
O[gK__<LJdR1HfLAOQPE^8IFNLfHTcMV;bLS&^B<T_/;2UF[(b47]MGO@@20)V_&
9X+A-ZG7PYXQ7ZbXaST)caA0OG4@SB[LD6e#KP/C;UGP:[8N3&:]01aeL]((8=1A
Y8UD\HO4WI.ZcC]]00c<\?+^eCd;@0Q,I_KF+#EN\/+ZVaS8C:=fYYgE1eUY9cX[
b4G&H+10EU,<XB:\@gL\>@W2?gSZb4eT,6MOM1Q[P^B;0C[1_9LSN0<J&Ka8@N0G
?/RVNSO1\cM;d\/Nf[[THM)6P#JF<9>)4aa/fE8Ye<5>MZ:F6RR@DF53,,^gPe:]
a=1[bJ8_AI,#F,g04MKKXFI93Q&^gZG45Y(&eQb/4QcVe9,B&_F?:Xc&3Y#+4IfP
L@c4=SB)5B<\B8Ve6AD+1/HSG7<[fC5^UTOKYD@Id[]g:5L?99c9c0?fCMec9CZ>
LJMIBLbH\?GXDP=0:a.9L2.</9]VY<@gBREb1UBLadE(bG2P?X]E):UKA5b<gLEG
ECVe&DCa4>F\D/6XUYdbYE>(HgOOC]C3QUR\S<;Jb;NRd\T1b#cPGVI-38=8Le)X
D/-=X4C>YE79DT9?EIcHaCFB]J\,X.(aJ2<<c]T-ZA_M;VQ2A+WCKA,-A2RW:^b3
T,2D3R:8L3e1b(=@dfgRWR<N[..<:G[BNMD)A)ZKY^HW3VCQG<gcJ7_cC1O<UW)_
;PUQ6\+/6&(1:Eb2KgT8W^KEb)(7#cUZ7(:)RA30SL+Z(X0NB&BF1-[>\6-&=8@+
L^J:H]Zb__VO<+S8^N^Y#Z_Fc1E7cOcf):NG-D^28KY-<<>2?BBGc6E;KK+aQUKX
J6#PYPE&ZIT;[]gIO?5gAAe+TG(I<)>PO:G?Q@&^0N[,P6;3)+FMM)R6fXe,KaS=
9&A\M.&1MZS^()6JC\9G^Qc[9#F:^b?f>7D7^2QKSSbU;=-\KK-+5U-?Z1&@=Q)T
C>ecDNFDJ>8]X9]#J#,dDVeDDM@CHKadYg:-\\\]JXf0NW9VBC2;XbFS0H^fDMJ@
TY3A2NV.P^<_71AJH>MfAOdW^)6B=2T-ZK?<=K)6I9bD-A_-C)e6]QN2c:XI6+5F
(9cbT8_b-]\W#O+_2VdDB4M86^bCWJ:K6Z#NG,N1-NG^B+4:e<+Q6O;=WTT_]GG^
<V(Q;^Ub71U^0C<N1\G1fW,DB?_S5,e,[g=Vg>0PD.a,+=T47(fSS->:fdR@H]&F
2][U\]#9G8=c6BS4]/<(d(.Xf#@R_G2_UMB[/H_F0=,1)I-T8,L&TKJ-8S)4-=]8
IHL,MR4gB?0+G+#]JCM3Q@:OKX>40[G1RD5g2B]RceUGbXV_,?J17[V8&JY-P_U;
4M_@]G)[E4O.fg2O,fgHg0)5]6YH#\#\L2#(7.+@O&]:e15Y@FUTN4BC;F[#ERgQ
&SO,DP/&LC/eOA^P21.-[7+6H9\H9I]LVSA8&dd4K0<3F0Q:bK3,NDQ_B?3(YHg;
#;WdRNP<H\RT?Re2:G11KA=a0OM(SFEd70UdJI[c-8>4VL,6X4;Q<WP_f88DJQdf
65:>T4:,1Lf4,PTX-;<]EA9]11O;2HSg=7K-KCZ-(WFCC)cKY-0Y,PHB4:RdNQ86
P:/58K[CR&LL&e:=gfAYec96(&fWK=ZCQg]eU7;XegB]NV>^,Z.V(5dX5O]#5DKg
ZATY8(/LHMc8ag_M:JY)0Qa=SL8WY4C[e=<fL6E]](;;gKF4CIV,eb]6<;71^XIV
V>1=3/LOZ;#>?5DcPc;>WCg-OQ:c#4_b/WD.[A.FP=_IJ_6WA.6XXRC.dZVC8S+.
dD6F=#.;&F4=D>IT5gNN+R3fSa4TM,]CKAZaPG;e=<3JH+;8<:G:Y/G4DU&=O6VZ
-1)AI+>/QJO&Z?3dG1KV7/P#K3dNFY?+LZ(AM>BL[2OLN0e[a+Q,>@_IaLf(K;Ga
0=<e&N7->6SEDX<>8eM&Lc/b\XbINV4,-L?XTPHN1F=ZRf_C;=#_L2[\)NRTR8QV
GRRWD[UAO584b8JHJTQ]DD>\KVAEDcF]N0e?>V.;2SJNO8#bC7fW0VVDRa;X3(\+
FI1e1<8XI(3d]6<G;4;Vd4VZ@Ef_4K2M#[OJEF+[:cGDeT0A6d>[H[1B\c5.2@T^
3?).=X[60(fHN1D++WUHb-A=4O=PQgS)Q+<9V?.f0MGL0dWB);FZbERFU,Y.=XUL
3>I9eQEN(X2<=7IaV:Cd#<U2HAJ8M+GGP+E,<9&SF_4VE-0X382V5&O8J3R[EJXO
/+\YC^^BYWV1_SeM3KD[5\V=HY>QZOS3GdN[Q?_#H9@3AG\[#8F:IPd-].A7[T0^
O5+T6V-f1+S^+cUcIFR^+\STeDAV/.8B8F<QMW5HL[TA^G^&4fYQ3F,eDcRaP1;^
CA(NF6W;+T+F(UXMGd9@OI]V9O7-CM[,4C@+FWWGRdM8fOU]/G?BeIe.BRG.L[@c
2Jf4BN7=bBedU=W;8c(GINdb\Y]1/@<WL3-B82\H1@,UI2Z-3^dI7]KQGgF]<&LT
B6N^4D4BV_.2F69]06/b)/A\fUJ^&1CM])Z:8bQ:+bUY9_T=64(e_eZH:-TN#T4-
P;T@aAc+B3L[N]Y1\)NeNOS=b^?bbE]XKC403,>N[2VL@>]R(aAPUIHcTT&_+F;f
N;N&/:@<a_?3HGL?(GM>X.&0c+AcC]EWZIP+)]S-NY6/d(1:;3U5bKX.WKgFCa>F
JBg,\>P71bC<>2&)\2Z(#9L#[70KcLIaf(d-IX;53,>b2&)U)WN=H#Q@);fd\bMg
YAe:I+?_D&@2<f)JABCEaFdG-OL9@W=OVF]<1TKQ8;QM6IK)[(YUF:358\)C^\LX
+ALM)R+@_?(@D/\cP:G8\122.&I3U56Hf@[;U_=fR:>BXKV6eZQ<VK2Z(A[7QZ;L
M8,5gU3T/d1Q<B662]]9KC_U>032A@53/EK&KERd&ZQ7-T^(c\b8F8eaW_Odgdg?
ZKgO>?gYU#;1T-WWP6]C-K]DH-)[]W3;4L^-W8W#83#^=KD9+g2;[:f=#S#L.ABE
MTV;@Y=ABB_O6@-??9M)LT^X3RI&6?>[FC&^R]MJB7Nf6b1MB\5E-ZWC==#fZ))@
g7RMKU:S92;PZfX(\RZSE\X/-H<)+&N?gV#Q;>+AaY)<)38+HRVZ2Q5)S3MMJ2MU
5\eDaU3fb:P)39#f\&B7E-?;QS2E<^cQT7@^I)]6E8XS3-)LHb[-EART:c_d#J-T
(@\9aR?))D\TD2YN#P^^#+NTg0QC.&Re;bg1abQ^86D=SX/VHdU1_B(-U_0/VTH?
RQ63U+L;]93d#Fg_gUELNY;LH5Z1FP#UKR,Nd1?@^?N[V:YKQR-[:Z&GGAL&+SG2
[7&Z(:,1TT&2K&aI5\B17e[KZH.3T&WUSR7S=BRA03OWbNFGc[0=]8G5:K6GB=[2
E;.TMP_^db3>IYXe/AZd?7M2[TS6[-ZCH2Ta[E#8\QeL=-9g4Q,&VJZWPKY9\Td:
D#H9Q[YN[>0>#8gg33A7T2<C_g-W=@J3f;[]1dOQST03A9HOJ6Yb5P?ea^XD+Cb5
eS4U;3)+6F?5cZNa.E9127^G>Q1D\-]cM<XL)bA>aRMD5#,FdBSOUD=JPC)U2Pg4
D[D.gcPH)LYA5:eUWO<cH6@g6VASSXY.IL?P=aWS-J0a^NWJ,<[HK4@;T\.aN6,:
AFKEWL]<HB,5DHcW:g_TR46Ga(->_aH9F=7Q>agfa4I0;21J:VLEaa6GP,a-KSJ@
Og(&0^1M\^CaUI>N,W4?_Ra-1c-^P]:>MHO6OY8:L_+O79#O]dXD_1C7[,V?W7<7
0SXBPb+3fPd;8a2_2,?)2<G(^;RMd=<\IgeA\U1#^^^[bSKC(NAX3(14O^V&D7(;
0c;dL;\.4\;^@R_W8bKMI@WYa]e8G8gU=QQX4d@2:#PQNZ-#91@FTB3c4>/CU=-V
_:\#_JOVf9UEaLFX8EYRJBYXa<^K75:^H3F506,=+/5#1Z=f6:KaBOC)(U#(0M(^
>4[X#EbZ#@QPH.+B,#+B>:.3d0OgO_K6U[/8BC25#<HOY(,QYI8gU[7M.[>[:@EV
LES<B.0eXY7BC]Qg8L6&Qea.9ZNGVZ?C(Bb_#T[RSS49LUAQD;W3W/,,SVG&XLfD
C\dQVL+O5aF9\<d;NT]PIPR\c7.(f+5b=U8XHFcfT&U6D)JU\A-73[N^7_e[.)X)
bWRKX7Tb^LI]5_)f[NdCACLV,AY=_,MHH)7,7/[NEAH1RW.<E1G\GHY-?Z&5Z9YI
V:[Ef88O#JF.8efB7KIH\-AK5MCIU1M-g>06B[D(W)K0YR5PY^PU8^B2<8Q7)<:V
?,ZQ/f=K#G=&eR,&=+d4LH<_/V[c1?:0_\e8Mg78@Y2bX;156F\F+Bd^^A59,=5>
FX@fX9@.YG6+d@G3dWN.UI>YQV2&_1)bFY[L2PHFbNb/Y=7<;>c4GgQaMR^Kf]T]
ZTY3d70<NK6&NR@Zb7N\0a3b#M-5/B4g)?H5TS.baU1WL=81&E1#&,X;LQ+gWVNH
1XJ@@-\O?#W.eGE\=LEg-\R4>[<994CG<;1/d49SVZ)11VLJ22?_X3;RF9<.86>\
NbMdAIf@ROB\ANJ&?ED0a9b&[#NJT2^(H-[C;>G8BB0S^4\&5/M6f8-<PQUIXg1Y
;7-fRCK=^O3[cV=)=]7/BaGWc6=#T.X>ggb[Yc,6L@6_X0<Q6Jf_[+Ea^3EWGea.
<UMEea(E,2\[<,GGL8?3WfTJaQf&DFe;E7bbg&@dL89?B12#+2JE0O<0AMGN3;NK
354/_HI9[Xd[+E=?@;_)XWO7Ad2GE&D<;b)UG,?9L6d2M7Hg>Y.(DLW=S[#W<;-0
GB<\f02L-J)@K^;DaTg\:9RZ3Y[=+3)+S\GKV_779D<9\NOTWQ5G@OWORcTSgdZU
X[ZW4]?X1UXWIT/Ye,YZ^I062MYQU=9^X/6.P.>_7e1fA<8,aCK>J)0[[L,\<0N>
V:,JP_)&KWGEEHeO(#V;gSHZ8a]dZ4+S><aC_HWR8.#WC4:CV9L_W7#F,gSDDBJc
?Vf/H(=V:FU3_<Z@49-BC2f47Q7cV\4Fg6e;/eNTAE3Q^gM_<X\BKF2b:AFT#SCK
XcR#<_-;R3;GR++=(9L;DS.0a7@;Gf8S_+K7I<+B]7C3f>X.9YUR6Q4ATG=8/aAO
\gECK,M+5RHU)7e<OM)e-&Uf?OZ6S,Y9?&XDWJRGF0g09[(gN?07MH?/c=/M_=^=
FVOX[+&JZabc_R28=QOP+B._TUO<3bV7f,IEQZMG1I,6Q0FM7g<G8X&:OI[&DN]e
49?3NU?/VTdLZ1,^H[dI@Qd-I4f=247,;7T2^Y&4RFU[4]GQI)R<A/6S0K?5LXWO
#.G47R<fT20:Q6=+0T)AKER6^63,&Pd><DNL]5d/5eT7T7MD&)c7^Tfgdc.YI]T1
WdfKd]<Gg&5Q4DMaVReAPXGaBBPfO@.OS@CH#ROF-0<6PV^#)TA)EMWZ)B)T#H.H
eM.QDI;MG4>BJ?#^g8,J)5A+N-LM44:,Ig.3QP-;:U(,FNFV+BU31XEg;WdAC=6U
7c44C=KU7]RJPf2>#SU:#V4A._EU+;HOCATbHK0Y(SO^,8)NN?U1+=+U0dARXK3J
8fF-^QHH?ab_1YJ@d1#,LDVGJTUYE^\PdgU@5@,dL+4E>EEa&QY)b+<WK8X[SNG^
g.#W(b>2))3Dg=;.4P]7c=T1?IPL;B]U\?O[?G]A.</VCM_^2],Y<HO-B=Y#W]Yg
0O4]+DgIIJ4K&:(7.OFPI\NAX8PdD.;,BU12]+ETCT;0>+X9&b#_2G1L-CBG\<Xf
E@3&gdB4H@a(=S5ZUW2=ceXK\^FUeddOFLe-^cceWG5^V&[;1-RK6G]JRHCa,LKA
ge_T8eaEC-KJa;1^-RRfQ]8M6N.0>MW@f?:\c4bO,MbD-;3H]2d[52L:dMSbP6/S
S.c@aUD?U]:67bP[X421;M#W;SA=DL?A/>>Xb3FA7A@e^HUUcZPH[XG@KdROLJ^2
UH5>=R/J_]M?PgDX<.b<_@M1/CY/H/AcA7?J,XG35Z+D@;V7)TECb[HdE-G^)8;L
J[PB6&PKf4YF+f[A.BE:J9,?@O+a7-=1Q2D91Tea-N_Z0(>C&7fQS;TX15-_B;+;
=gOFPW>Sc9(c]H0WM[4N,G9[D3CQ>.E[0]\)MP#:)-IaDDWJ)>[JH5e:4.(JX1>A
)@fe@LND=0?dC-[.eBU]eW\+6Y75b08#LXIMS+-MA4V3gS.]F=NN0^8Q2L(VX+MJ
Ua@[2G]b8A4K-=XAU[@BJVH3aYKcf^e1]^LROA<dQEeMg;GgML7H#JMVEI)J_NG5
SYJKUPF0K;KA.^X0d.>_QgT>IL6@/^0>S=WE6g#fZ5R7bNccfBS0:D)7A@OIgQdd
Y_:(L6L#K=aX^W)UeALbLMb=]LNFbKOaN;R(V:eK8RPBWQ(L>1M810J=QJa1Y1;U
PZ1C>R>R@<bD2<YCa(UNK__7-EGbF6.H(TM1@9MQ2c\.[,PPY8-M@aW7#LT)78-)
WKYFC#>T8TGXXK/W;<C\-YQeX>1WK=R4G091>PL3(-\:I:fE+gQRdD^]H1?9>d(#
_R=7X;a8B)D8G8/E(+:<1=>f\,4;)E4OP/,\V>7+DJ7VH>Q(agXVX[)2NCVUZ[LK
D02JQdKBaA6(e/M5QQ-T7\1QZFZ\50]U5ba0W1RFFU5d^0PV=aK6TdALUL98:I2Y
^V)9,1SUP\aUAb1=0R;f9JB1c/f_^9ER.0JNZN&M9^S?L7)4,/X[=XSNHGNcGG]@
PeJYPU^dG@Da9@11;&VKcE(=K]J3XR>087SAJU[@&Ye&#BT\e\OIbPDH(S:1_\,P
)OJIY,C\Q(,6&S8C<F1LI0IQ_-[O8=[>GgM<^37IM)75[GB)-T/9N=@Y7;-eB[ZL
=-S9Y_G:WM,456DXfR^K^M:Na2VVE.MMWC&SNJdUc2g7Z\c9V>.UH7)[bD1fXGNW
31<::&>\GYO-OX.,bZY[#<Kg94\Y5TBa>W#/ENAO291Wb(Ja1a</9M>Q8+&FWSDX
^M;1;_0.V]Hc8;PM:9,E9ZUbLLN8@>+7MB^..D&7K&bG<Z(RTc9bVKRb)58+D6>\
/(d1HeTH;bMe>EH3OLQ=M_VgN6cTaBYA>V)G@Z0ZE-(=3ZOf]Ya/^Vd;,f]L=Ka.
L]D>Y299ZW7@dBcQ4adKK0^@LXLL8PfV,_/7C=I:-<Wd9a>5MA?gZ-7G\5)&Tb4c
08F(JNgd60_?cPGVY6QGC73Q:?F1;)AX,<cb)D5=434ZU,aPa2])K>XUN9OXKLV3
bdY4CAN_JIJf4[L>D+Ra7(X1N[W/6352.++#X]CKCNF^Ug2>&3RX.:7RMM=>=U]P
)?0R\=?OLSeW)M,IF.>,2?N7ZZOeJLW96AMHNH,EfAP&Z0<[_QVGK,7S;,Cg0WRO
]HQAH[)C26>4O@Y@5H3?[1BfB9K^,6FX6H4[TE?)7U(a:9):N2F?\26;)KT/I;S,
EZY1C3ZfG-^Pb7#>Db1af^D31Z?OY_/=MI<4L5UBQZKDB3]I,8P6gaM9ET;eS@6G
=A9G5]<+9L+F_BQ6PgV5d5:77adeZ9aZ&(#]C]&H#4[1JSLW\Jg-Aa#R[Re_1T,\
0G^@R]W=QQ?=@0W9V:X3_bAB3bC85[f/]3#\IM/YX5/#B/V(GBJK66M1KMfa:T-B
.\=Z[/6DZD3<]W,DT&d(Z+<2VH.4[0KcAI3f2B)^P1f0=96QGRSCRaVe)3#3eI=a
O,6E-Ge[-S+=U@\0>^UJK^QW2EFSBH[Y4Q<?3IVSQSKX.XHBK=<ODNOgWYE@9Z[C
DLEE+(X8BX(Z?bNPd/I.3T@f#=4RGBW&->2f#CYRg.X4KWe71gW4#d+[3#:O^eZ3
Y&KTd8dOFZIS(H+:V^-^=1L[S1=/-W2=MNF5>\[FF5TFS^X\[/:AKSW:<@]N5TJ3
c/;U<@@Ea1@\Y0,(>2)=KOOHBX-0fBMCZ(VQ&2=3[)?XO=2OI?W]\<._Qf9SM&;8
)7G,LCWFF.JSA42N4ZC8^.HR&&]5_B)eP@]N:&?b:73\L7]:cS^H=dG=B-K6.V>R
#,+7/EA+C6S@3?XA[J[7CI,>LJ5gc\8B00XS;BFAT?WP?OF#78JX.3@,2de08#R9
Z_61DIDgacaRK3P&;<+.W/WcDCINf@9+7B^+ZeMRagE860FRUA28,fJ9/:-Q=g(L
4F5P0dP>]6OM2e#:&,51NH,1YM>(CDT/<X=(7(e8C,0@d9HbdP(eD<L-WeTRB+4@
Kd;Jf+e5?AK=L4Tf52^7?-X_<OPGHb:FG>g:=Q\A,CXdX7cO?7]_5-R\8OM=/7+(
W<VeHJM5?\J1O>SV)\9:CaRTJ7)M,F^WGgf>T]1\MP\:J+#PXY3BHSEgPL_):&4O
O@<N[a\RN.F)P1K(&cQ?7b@adL:/;P@WZW;@fc8W8BG&(FYYYY@)e>BN)3D+aR?#
T+-@@I-6RK?a+eJ<Fa0+_eP0:=NJ,DID3[7]\3:<B6e0I(+?C(]1]d1896>c&Z[#
3:]I-NJ;4H?U+f;KAYD19.9WLc#fXY=4E&>11CB4)-ICI4YI-d@(;Bca@4c1aO45
U4M6=WPTefPSPcCYQ&0O,&fD0(df:>XG&gGUB+27_Z[FZ;T:IaS/be(Nf7=Z+#==
/ZaLY7I:7Z1dW2A\&&EZ)/0)1f[MKO^0W^XS8(=WL,:7-4(OYQaGPe[=U.8LASb#
0:6()g&K89W+RRBd_63G>SY(\E)0PIG<&<?dD;LH@9L[&OT7W?1c\ICA)/#1Xd^f
(7)LS^aWG0-(e;5=[(H>57HP:L@G(7\A?LPQ^<[>c2IcDS-L-Y2JdJJ;7?4R08EP
3BU?N4)f5g(S)B<QE(4gO#D]0LS2cGH5O;_FVOMEQ^/4N[[WDXg(\caHd1DP^@1\
fK6X46?=+7H#b8abLf8M(Y^>S-R]@L1cGW,#DU#0Y(W1a<D+22cMZb(9,dC8HI)b
Hd222^);eLK.BUWAL)G\\c2D>@OM^2Z]LEEX9X2aZ\]++X[AV?A3RZO9D#DBVU+)
M5JV-9\9aRZg?-_ILeOcBBO7QS^/YN@I6P7N7LN)F?Hg@7\B1dIJ#2.RL4?1/JG4
T/E.U/Kg>H-,D,@f>F.LV=#.3e8,#QeRE>BP:)=N7OGA&=E^2ON:BLDgZUP9<aTE
Q_=fZV@L[J0e/MYdP3SXUE:W<1d-6]XAXd)HZ07gC?DO4ILcYE8/@/Lc+:,,VZX)
/K+4K)NFL>15@PacF[ZM>\H7:(XN=4:#[\gA=cB&+J6g)g\N2H>C10dBSDGI2[EM
?<e>2&^@gUU(dbbIdP2c3SZ2d3:V:O2UZ8G<PMO&R]cO@Z]R3BdKR=9YA@fD:@._
6eP_2DC5,PD2(gXOH;-CE.Tg1[[d?g1\;.Z1NXP6/_E_a=FHDPT5L^3EA2d24;:K
S_?4R4<dD..f>#C3e>)UM1BA9:Yga&3/df>@^7/8,X[.;:1,;b+T[S60\G=cd<@e
3@44dO\0::/B^T2\b0N0T^5cC3;AUX:(ARG)Q=9b\&PDSf[F-A>J10G-6R:3BT6#
VR?7,]BJ_.IHE-&>HYcA[8#GVM^^g-.8TOD,>-Eea\^V8>57fC&.?64DM83?M6@@
M.[Gf54O:AP_;9>Q[Yc,?]>bHd;^d<:e-.dSWQ^RB9R+[RE72Xb4_L6<JC\DeBWa
6:3]PZa_@@&<OV1KEB.I]OGIQA=LPHN)/VOd?7PR\:=HU),695Z]2a<4CYMAYg[D
@?<^0>Y6:FD@52<8:TGU08g#@W0X8KM&\Q<;g6a+EKb::<7]\6BB0QIKHO_#Meb5
,M5@bgY;.g>F[NMc/P/cYSX-b]eMQ,:D_BD^_g+-4#a1KNS^5Bc\Y9W^1)48@dJ;
S/?2_&^6=J44/f&dX.&SaZO:MgfD:LG@MWYJa<QL57ZCDPY1e/15WK=P9_^=F^]#
7TVMJ@IOK+-cK52Y4ZJU1<I9LRWFA8E7./WQ9DSg,FLJ.BMU1d)fU[/(9gd.GT5+
^5Ag\I+^#VfGTB-CU+=5<Vd(d@(G\W#/G.d&;RSK9bggg>\T:DJ<<UTIFeGg29=9
=?R#MB#.C.>P8.XSHQ>=fLX/LeJU=Q/0O[aQ65X]^@_2+LL-CU,C(gD8f@-(4NA5
]-b/Q078c@A)?1@g#-#[W\R1X2X>,/YcbZKZE(S))#7B9Nb;B+YNbcXSPFPS<B,[
)YOFcYJ8ccI/d37__5f#OLBHE304_bY1KL_\L:K;1MSQ]M[MS[(,@+<#.,6cYS]=
P,?7]>JB5&>cMSfM]/YV@\ODf5dMQ0:A64QMgBgL(HVI&@AdY7?a:VfdUCLF5+63
_b;(6U]DT:2;6VT6UG&A^V/5fE6HF_ME^+5N[EM=DUW;gTdIBPgLJQY>UI0:2:WC
A,5J0R0FK+4fYc6>-dCF452Gc/B]W<(A+8]B.H,c]7Z.dJ/baMg,0;[+QF[SUZ8J
0WO\ML?I&\+R10<[776WR^GeNSRATWJ95Z)Xd1[[9ZX9E>I=VLJ9,C)@M[cI0B)D
MJ.N8FIJ2330S#T9T,a05Zf@62@&A0U7UMRdIJ=e&c[LEOg^JI>O,F38IfXTD&W]
CWZ<PF1LS,LHZM]B#eEeB;^GUc2Y;Z]?6@5[9BG21^KB5Y[V],Y;(U:_OZ:Z42^)
30<9JIZ1fSc[6W[HEcYSQb7H;7JbL;(:#+;&Z(?Af#,8.@O8S+D\B0_Qg[/Y\5OX
8QQCB<?a8O?P1T_3/B&F)_8?8Sc>M,YG76SNF7,9QLZY>b>VgRT14?;P<gbAFNDV
O8P.Z0@BN4VC83(+0&-8@8ce6=H&AO>gCS;9PC[]&P+(/),TUST]T2JDH[^5Fda<
,T@H=OHKA;I]PG5b8)BgZeaRc8P;g(V+P/JP,F8(,Y4f+WgG5878aQVINYcbJ&d,
YeHMJ.]L)AHBM#A:]Y&(TXd(V,D#O;@V?\,P)GW9)C^EQ)JTcTVQ[(9AH4WSdDR&
T8/#A(R-OZc13]a?G,2V^9?N@Z1b:0;4SDZDc(d8TaT+dW<7Ng19=LcB=;-9]AMX
J2/U173[D^WSR98T]1KB7)S4O7Y:7\a2VXN89c/;^?K#+OFZa5J7_WS+PKfFW,Rb
gI@?C:V@OOEbC:<8<(,&E.>5;-_^g:LdCO,[X58YI@J=VZ0K=-7>QAgWd)W_:V=M
eM83b];T\IWPQcd+(HF9TC28?(BEX3N4>cX:GY,.=bU8J#>W?P+=IUG>^b,.,38I
._GC;B\b<QJa?+8,?XgK4)+&]2^I1GRA#[_PED:Yf1XE7:6g4ZI-L#5J9ZL8SVfd
V+@W(5MC#^7.F.BPIAZVZ8+;O(\E.,UI?B;JcZBKIa81dQ)W4V^;@\b7E2F2SZNg
_e6(7=[Q;<\2(K&](2,<5_b3858BDFeD\C36R+[ef7R2X5Z-QF&@355.5QHec\0F
;OY#,8+R:dYA[CG([?W9T]gB^dJT0ZT&.9Y[R#Wg#5b3=U)AR,#Z\4;G-fOC/;1L
=(28>(-PJ.E4QQP7Q:>4)D:Obef5SYWH4dL.TJITIAN++;M@:?[M0,7BCI0HNN[5
c82[HK1&)6Xe+B4Nb4ZgP93YY<eSTHaDV[a)?;DP&c4#LNggY=>bU=WNG3BB0;DS
=JFU41e#G#NGY>R_)[H:960G>BKAMb_)=L6-Y;<SWSX4LBBC4^/T<?5V#B?:HHb-
6J2Se[-;K5,D-dU^dN6EeMLR5C>FV.\/&@(1R^a8G7;2L/7.8:2/C#>aR)=ZSP1M
NWY.])BZg?2?B<\1>#b8a<b<DSg?I5f8(U3.@?]a<G-Z\.K+HKcdP+6\8R0e/VLB
WUY-:K(;Z\TW[F5EA=ZaQ)BF0<57NbNJ?SPRIM=c@5F,IeYg:3=ZI1,LUYC,;cbL
2Z9F/ae>)c,Me<aGPYB),gP1]26/X28X]e\V0O^;U2IP-6(+W_U82)KP^V?S&Y[]
:)d/FM:-1-YV2MX#7?AaNJI6RV91GXdc3g#2C/YXG9W]#2164YW2,T9FbSY7gR#U
6Z.?\0A[;Z-#H,Y0Y&58_8cK53;a<3..Pc=CBYgZY>Z=7cXS<;\1aCL=J@eF2g2)
H1[GPUU5OC:69VGGd3aJ+AUBD(4[9#9@C&#eT#(5&HCdVV<PQ;GG;Tf^KLUKA(Ge
e[2-QM.cE+MWfQO.C?CMIYRI,1a93,2O=C.N6Y,>&+9#@ZG>6]1>e(fEYc>1V:?R
eOC[Z]8Y7)MB1JF=,dG7QMD_/SI:1edLg.A_:HK6U?4@&?Jg>&N3^Wf9L#,:DNMH
XO\V&>[gfTT861,JJM=Z.L-/TH73;PK29KUTKS,4[-1HFRRG_:dN:Hf:[#SH/6]<
D70>3I/BZdI+g.W/&E@F38Ifa6:R4d;NP5&@1[B:YA4)&Z4@KWaDA9@3.H;E;N9V
/(-MJKYBEW4Jbg_I>?=A;[aTS8)P@^[D]5\JS2IOC?VH6\dL(7;C-?<2RD5&>FC,
:T[:(,5/AXdc3UV87L=AHb?FCJP)5b7Q&X]&=/eU/29M<9URGdY:,5E3ZH1OKJ,K
VNA>IB)U=8\[SCD^d4B??Pd,;F.-.IAKYb._.cF.7Ne^#ZW&3[.-^_;Ve:EbTHg&
fCBGD>Q(d@^]TAd^6CS]c(gg>5J3(dI9d:;F5a]1:3>1PIUOQ,?]^I)JLI@3<33X
G:?g[MI:Q0G+PAK>>K-5J3S0_&aX3PD:0Y=PB(CM+TYM/\D1DMe8R(3-;T_J\I<I
Hg.f)10D<X17U3I(VEK,C3dK\^VPY&geRE&@/74LaBd0MA8e/+\SK78_G14F4]/N
+/::U:UTDMZaW;XaLR=>2]?e#<WER17GHPTQP(FRH6C<.L,S.aW^]>J\HB.L.P\5
B?aR(F-cH,P.HIO+5CSb_a]cfC@c0Q-_B-aC<SE9>_2Hf2(a[1C(Gb0=SY4W)Ka3
J8\G=5U[RI.PSV;R])W_55V,CMKOG;@RBaLHMMSa?]X8,fgE,HVa:IZN-9aN[C]f
..U0QB<[)b4bBLF@E.JE9YKG@^7.\VSAVH.=df/W&(=EdHX9R]R(BD.3L9c8JVF9
16_N@Y7gZ>),31<W4ERW-(,8.4=9.-#V?gPW:5J&RPe@M@(\.5IFJP(Q[T:1&P2N
Z(L5aOBcC\]c\=VT:/=QMZ1^2B:]PLR4V;d&_Uc]YId,GEUG._KU6+YNZQH3@^a,
=.6XYZ5/L#-[ECJFV.:TE8[Zfg0PP3Q6X=()7NZ=1M0T(/\e/KCN(>UeJQ<PZ:eU
.O,7:F=WQ,QTL>YM_9Z\AC91>Qe].[QLXX[4[b18fA?-.e(#;&e,8f0H&.-g4c3,
[Y/1W4/C;S-36YN:@IW9Da]2VHZIS>3].Y-XeX:[C#YT:aZA_#QdRa]3^5a1,[OT
-QUZ)cBH6OeQ-^gaE&?Age<\Y/MK.Ba]Ic?\,\46(>a:c,-YAXS]M=PAg)+(+),/
042UW03[8CF6)YbS0^(49/-KW7Q?-C4JMeR0VV;;Z8cf+4cLK:abOJA+Vb;30AZa
UE[gbaZRKQ;[V>71JITA9]--SNggM3N2PcNTA3WG)+0P;.g#gI.6a8SObA8];b>)
DReaK)LVR0O,40E\CXC#X3FM3<6beGGB&N^=3c,T0DCTe-gOM/cOUW.]BH,)6G8,
5+726-M^ML]QOH[+A@#_0X8J=]-0^>dHX=?OX(B481)IN]=Z2L[4fCR1J#IaS>OG
_WZ1cf7P0agZQ_2WMCB7aefG&82=&;^598SW7OT6b9BX33VT&HUa<456SZ,./@E?
E)?D4+^ZZg_2U;)^e](-A78.a&SI?3U8UPM5Z)_&]BHIQZXaT9?#fEc?-_-]DPWc
B#\>KPfAP+\_IHc9-)-&I:4@0AgT^YGK36F9>M&ggc^55884bD]P)&-W>g:^<]+N
d?\:V<40NEM&2ZM8^A1L=L?=P45-ZBO^-9(67WR+CG0,f#9,gd7H6Q:KBG-3<F4F
1ZWA/6abdeTN)M^M+1g<@&BbMCdeHe[K/9[<A1[(&&g2W:bO#QNedQJPLNLH3J;]
QUN<4]J?FKW++.:&#^,g;YT;M#[cMT9@g#cW>,4(L08;XX]L=0XX3bN;Z&;7M0;,
<?:,2)^ZR>R)0+aOZ\R8Ze.&;>Cd\B5:)f9HJ&C0/T]^L&03<>@Y:0+.Q-4J:Z]E
2ObO?;Dg+5[MYda>>\A,,9?)VU>@:YT83^Z>gDM;J[c^/SYEM+]R.dR#]#(9IP#&
,]C-=UObR6;C9g1O#<?5:8&J>IPCHT4K@dIPM?Q1YQU_2NRIN]HfPOO])+SSNb)g
&gRf6.C=D:dS\FbC7W5N8FPJ=8D]27R)(aGGH173,Ic,CPC)^72#C0,TNf>>5+=D
_KOLaG+71Vf[SQS:S^>/]GZS/43<.W0Q:Obf9,#[Qc0YbTH3.f8WRJCDQfS85LL.
CTDe/>d:PK)0(DC=]5TFI,R>GG?=e[^V\@SfE210eB0(/O.8a(\BN_PJeXU)^EOL
5c29F5)f\11Q#;IOI_\T&]((@aAQ4(#IQ1Ig28P9Z))[eCAL@)C(B:>>e,L[Y:=J
>gEIAKM6ON]fHZDFC&G@7SdMaBe5be901LZdSbLaf]H.G6@KTDS>OK.39QfC/:?e
WLcCdVL0&1,32>BSG7ATHWR(f\a]E=#?@U_d<?5\C^Vd^@^&GX^U-b03VHERK)3>
UN:-PJ=-M83U3C;JS1AO(#W@30Y?6S2@,dPcFAWS?CA\0&<3Jg6=f&HMSC4U8b85
UXU,[:CJ/\GVR;=Z2+F=@:=M/VeD/+<//Og]>OXWQWHY;S1_f#&Fb]]N]A7\19D;
64;@G]G_#g;24f)V;;OF[?MNbTF;.gVLNX_&E3VP[9]37CfcU^Rc;)cD+]S9a_D3
NfD(U;CD3I)YZY9A3,F?=.@O2cR,U,_WcTR10B[,\\\,AP,E=HN3/8)5f>F0XcXf
e-L4QSG-K&X5_DK62/?O3+N.I+RTN30+N+H_NAf0QCA\;C_1HPN;fQ5@E8N_MS@W
CCM<a2\)-HC@O2:C41B_OW8\,U,XK,Q09UaS1;=-DQ5]J1#)4&.XLIgGg-e/7;B[
PUTY\09c#R/HTd2L)ge[0.=ZX.P\#A7X,.RU)NR[bRT]&T)Df[]/RMIJMI,H8Q(M
cV;a#L@6a9Na=_PE^7G.O^DQ([,H,9ESDHeMMX:(?.59SSKTSUA&[.:/A;D;SK:W
5@N?9HDGJ.Tb4[+_ZHbWS>(fNM^/E-.#[G)-WG.^PZN2H_F8A>/-UX4,Me?QG[\@
RCRTJb8#U&A5@E(7@0T19C80?24V9?fae-:,]cAYO./)K+LG:a#=41XPTa6_;c:5
B>b3=bIbSb&V-Qd.X3CMGV8a3_X2,P[aUgAVZ.YO>Z&C033-+GW&=Na.HMaK^BMI
;PF[FSW@e9\#5aRAP,/X#EU^#dbFI-J;?dSU_S)U+5]+NW&/5,#2A0]E.X><LD5?
H)c[^Z3[,c\,SEPf_Qe@YH</:HEEICKH5dI8HZE^,(ESZ_Y9Sb>,(P/=a/C,&Yb8
]_.8HDMP3TTVO1_,b]AKXVY=,O?]M>A[VgMP>Rf.g4@[I7R_9VL/[:fID6CW,9.V
WCB7Ub-)8WbP2(?^TQNU0E&_L,c)+=H98,0Q6U674+.E.AC+D(\=C.7b3J&1ZPKS
6@6YW7QZREJ&(>.&9M79R/+FYXFa:<DTOIdM@P3T)KZ1?6<a,;SG2d:fdd8EeKH+
ECS&eAb0V/T)T8RY&a>8JcFD=_aPOOaD\BdM72\e;[GG[TaYR92VKK/4JGeW^Q=&
)\7)4[W^LT43P]4JF.b,\O(&:1411GDZ:[T&^L:]1V_MP\C#9CE?X:V[@\&_d:49
4c^FK#W,9d5:EXEY(H6U\ZK))2@)(A@R?P(0EEc]9-ed[&,c9-BRcO2@8Q:4e>Ef
\aXG\FN0g=482MaSTY?+254_\#WG[8RD;g&A=g1::^=G3]gILM,S:fN]S1H.dHgH
PXc8&b9:gU]fK3;MJXZBH,2ecXb9A]&F-X.>CR-7-O?=Z)^],/X:T3(bM#6BO<GM
X7=2DS8d,0V6dDI6R;a6E^fJ:-K,5,9>WgFT9AU4.F(/\c3NFI8HH^;==F#-=4B/
PYNeEWM-R.Y8U#WOJVJ47WbHb=MI(03;_YG8@@:abc[[BIN28JOCEE/E0g,d/@,?
aA#U&_,6WAV<#G;?.TH2F&2-/M>B&MJ8KcfI9DZ?=CVQU=HD&A2=IOa:1#)XS351
W.F58<b]:5@A[0\dFMFV>M^&3NETCU0(g,\/2EZYaO>^e\;Z6C7C-e^[Z\,V./S&
)dGFT?;BIgZNdf?VV&++(7)Aaf8]0FWS506Y-<g&)9EI<LD40ba>Z4\&OA+5@4&=
U4g-C;ZYJ@aK2g3L5FVQQ6aZYaN=Q/-LGEW/=UZJ)Gg5H^+bNgNNPUFXKAIII0\)
9#?L>)DdB:fCJU)/f,G?FbS.<ONc8)MMN4?IM=R2=d-MTFOFL9KKB;8dbT:;8]NJ
@9f<@ECdJX/+c^[bRKM/@C+GD5RRRAU@.ObT,<=388W4#9+N#I<KgP@+1)&c+;GG
X\&AG&6+?a1D9DH^ME2CJN/;,87^@RBTeEN)d?=+40b#(#1@AO.+4bM=Z7fLLeY>
@^R7F3X1/;TJ>&b1d@1P+.F^4SV6cS7=&/e#[0>^;L&c4BIPSTffHI+_ST-)B2Y6
0S6]9]N([Z9M/GJ[_1gN:>S4@P>6:eb6PE4/8DPD#FHJ)@\W[,9\8Z6E_&SJJQfT
ef8c.MM-\]X3:VIU\aGGB/W1].(13\0Cd:cQ\>;[OB8/KC71N:&4_9_?L&LOcf;Z
OSdQJC+U7F_<SYX?<DRf2X(+:7<#d8Y(VO<S.9(cVJcI)+Bc_CZ9.IOBEe&K,G]M
4YF3X\KAQ&0&)JHOa]?Q6BgOE0MNLZ6N>4F0LE[=C(4Y,#a^-&d&e87VF\d1<:^g
3HE_+.=^+ZbQ[,ZKQUO-B2<[7#V_KL\U-U?f2HgF3D8)46bT.Z_66^LF&D23G?N)
DMH\=cBPgE+&AJDTD6(8?)\HB_#<9NJ,G&@9g0ODdU2>1]f_,YZLU>/XYfY>c=FB
[K@)e;OZ4T>:Y7#B[c?.1B+WIB==9;XDO?cT@RDIfNPf5+6QX)9KKNV4cg.,7E_,
2FJ#FHE1-,JgOWKN[22cGO70-8+\-;8MOM062BIHgGKV,L)38(9=1ge_>QJ0ZZ4A
4I5;1EK,3f.aLaQ)X5GT^7IDcWCS[#Mg;d;J9-(H.8=17+IFc<0/SGAJ:FY>SbM]
MGO17W9JP&].&L+G8(V)#RV8(XFH9=cLc9?^I\E9)b@Q(2##Z\JfCe8KWED-0H1,
KYNCHQ,T#EeaW&JK])CA1c<bD\-^dfJ\WOO9[@Z7@Scd3Q5SC78MAgOY.+D>?8K3
D>AF1M,OeHCN>+eT#O;+\KS9IaGNaJ9D&[7>(/JO)3^F)&:Ig=Sg??84)XHLNEb4
??);KfFV8Z[1PgZU0;-g:&UC18YX0f@]>AS9==ER;]gGL9V:MH]W3WKc@R6QBT5Q
c;2=6YLNU5TN=80&Qa=/F\2&7g.OGLbfM<#[E7eG6A><]C7AYD.BLM?D3J+Z/-5H
68ZKYE@,NEXb0^]aC>0Pe:]=?;A<SZI_-X?S[C9-K:LKT)O4,O#;KLI[[[3.)G:6
[&N]XXPL)R^-UfCcJ1<,;G9MK@7^VcI,W64_]0KAgbH0[4KA:M;6QbY3c3e@@2GN
A4\0X^N]LWCZ5HWR96AI1X7J84.=@]:G[bXHH0bb?:\)\TZ2;YdGR@[KSQZG=G)C
BX3Q8GeG7bZCGS/Z-NOdf]J-3GMSMZ7I-6@b3WD&?/_0O?[JPL,LLSaBW:LNg_P?
FZRQ]N?TF2UZ&I5PWDeVbF&K<04Ra(PRT,aL/85(X6+TCdYRcdfPMY=5<3<SA_LV
;Z1[c[P>Bee6RK3)_K^cf^Vd,>,,O_5JKA>d5-.@5aFg>N0(1d.=V\d;3LGeKV.<
(RPEA/-G7e;Sfc<Ja8UK)D\@GNNAJdga@8A\RYIZX_c7N3DII@W2+PD8W;T)e<([
_gU+RJ7BZQ8+d\[6:)TH>-]FA-3EPQ&M@edEdWbF-<IWZ=C?,#+55&:N<K]UEIJ>
AFL+U31/F<d:XN4R?LU8M=g0aKF9aI?&d><8)Scf):]S:K+2YgK?KcdIc\2W5>_5
X30P(2@F251YK_7CH[&6U:<QI>?<Be:5g>Z6M&U7;VK/\,]25IVN#WO:N]4/BLZC
FMYNe=HYA^<H372X(ff@JDHLa.G:=e.CE\-U55?0J+GcY.F2MRQ3Q.0JF^>>AU)\
:;>fOHEB6b^T#_d[X&57UA?.@F>I5NX6?eWPPPCL_XC[(>\-B9^AD@8Bc&K]79Y8
EC(^Y6348]C3M<_<fAKC?8&+49V=VCXaGWgcab##0)8(,5Z\/N_TaNP6RFQCWB#8
42Lf@P_@C>-S)#H_(AY&XJ.Q02Z.b,U6I;;]7L\4UB[-ZaQc\L(G39cGCfA\Lg^.
9#BCE?PcQ/3-_VM,<IM#0/OY=X<V^dGI)d8gZc7ET[JgZeg)B\fEgZIO,YKHNI+)
b#?2BAGe\/Z1]K-+d<+LGG,117EeKg=N9[H5]T1Y/:97>T2eU13^_&)3NXCOF\5E
P5N06^+=1HCG@]8C\QMPc]gc[V9V)2@NP3-T=HDV^Y&H9(?_1UaSUfU]I@6.YJ2)
MXD/Qb(e0Me<4:E+7C4_c<_]g.2AJ6-YdUH.JZ+].KQ-X=@UTQ3[2)-SA7O3JG+T
ReW>eKX(dN0Td>@70Z2D.BFV=8GF>CM=GgG_Y#1DO\;e&ZBaG\C8XI[#12U2g1/B
Kc1_]#D]:/7-0]bF=0cE.3#=3M+bdWQ<5+)#13.L24.>[[FELaFX&cDE+/W\9ZXa
cW1Fe_4)A<7ag(NM?.(RT6?23<AZ3AZaG6MDO3a&QdZ-(35?^0.4S14>@4Q/;:F1
=2a3VCa;:4,G0dSgfSLZW^aYB:5TT52d;[PcU<cb=ECH7De\Za/0EPS9RcM[Of,W
d85#YeM?fD9LbL:W]#fe,PbBXG5,G,2I_1TXO1;8#^#TQHW=<J]65J\+^B0-e+Mb
)f-&YE6A0<[1E:]J[U3A#YR;bb6SP>]KTa,4Sc_cL]T]G]AQ4+?S7T/g]IZJg_9V
Y+2fQaL2U/3=TOdYFT1-<X+0W,Y^5gM@O\?DJV0#aeN698:<e;5K)A^/3GHUD6cW
deb6#.<QQ([.YY(ad.-P=(A+><NX;#0O\c[1WI^8;JNC[^&H1SdR;>HOa)bCV[Z8
O_9)]AE>\ZN\V12HO+A4bOZ,(#KAe\Eb&L@AQ&;gEKY>+)GT>F+Y63Je)1&XdV\B
D>.4;7?)I.WcKQ?3RLAMeM(f\dg378N>-L1K7<KM[N\G&4:cY@H<Z</B?QM,gV07
YU\-&5A<#dE&]aC_eLA/347fA[L1MH(NSLUI42g.,#\ZMcD-c?<6CCYA/T3WZRWb
D4P)aIa=9A[2\]eVW4&;[/YL\5D)eVXK,(f):>\A;9KI0EX8;N:L-Q&NJAHaD&X+
FSFeRE624M(]?W#K+RDBSFU\[TR61^E&G(aV[22.N02G-^cX&E7cPS+X_=Q]PHb3
FSD>.dC:a>,>/X?QQ\>K;[#B6-8PFDN,KgYEf[Y,Q<6&UL/fg^YZ=;4?FfbXLQCR
2LKM^;ES>gCf22R)/V)1cGS7LT^6QM[R3@0b,=+UMVfPQ,]-)R9)=1Zf,XaN5]R,
F70G/L(D<AdBZ<aaVaTQ]^=BTMMc(+2V/+U-\GLC<?e&.a3fTfA\^aeHMH/_bRU<
O)2N063OFdL)7[/gG8=Og>.-^c3G35>O=Tf4PXF+9Ub5JBAZ3<a+^F.<SVKAEDI4
bYF4:.f[g(I(fU(IcfcLP=Y2[3@c&1W0E>+OY(K0-TP_2JFLY8+,5_VJ?(ae)@AH
Q/U&&fdCKYOD]GPAHV+//)+<<e@#L[8E4_XKc(R8Q1&4I.=YLTU_5N&gE+LNWe-2
8J=V[:,CJRS@5G#/\B=gWZR9^1dR5NbSA7M940TPBc+(M^f4Ye^YS37.VZ,eg#6L
0#G0bbN]La9eMfP^eTS?SVSBVSU+HVQV@_(D@JE#gKCUBNE8MBXKgP(cKc;GVTM@
Pf:1X\aa#g[MD+@FCZ(N/KG,-ZHD&I=Dee/111W3,R_:(+275XBZBJP^gCYZaT52
9Z<T;gW>BeGIJ&+CXTd0>\(KdDW]5+:7(H@3/2QW4;G_VfK8.76[8VSNfgbTWG=O
SVe<E(&;<DO0AY;>F,P4JcB5-)e)W/6.W[a;VS.+UcK#2[0=G,g:+.Z:]f<M+I/<
0b/6]T:#P]9E?1=:bDUJ^gOe;DU^4XFbd7_gCRP5242b]D9W_T]^8U_^]BC):BZZ
X_=LC:^O,Edd-I72]Q.3\c@aa5U&5M,P<HSS=aD_+8P/9^c=G4Z6-0:43#[X5L)#
dC#KfQNI81e=3#^c4Td]@@AA.O=^RH3ZHDP@<SXZB+9&6Z3:YWgf:U8cOHVYQS5B
J=M+=HQB1>TQ(U^S_<OY>Z4H&R41SaDNa[SPG/f^LZRE?(D>@2KUN<9fZP#CV7;Z
dT:\DI0_E=<=Kb<+Xe@9C_G<^LO;2,5+[7L=;f_5J.1;CMG@a7;^JP(Lg72Aa^L6
=68[c2e91#;)+\]T9@^IMYYS&H@9#UQS)W^W5b0D[RH+4GURC4V0T>_,0G-d;X+&
/dX(E5#OP6N0P?L2&22R^343E.@O);1QV:N4#E>d.=:Q;-^#CY_.]bAaX(d^]U&N
+&^-H00He^X6Q]_a3I@VDV><W0+9V.)/I:&E\f>\ZK-FN2J9Y<>d[J+Pc;G6ZW]4
=b>=X,.#9M(gfBVcc+HaOV_SQS.:\,2AE-HJPdYZAT()25@XfaI3FfSQ@,BJ<)UG
aU]?MaBHaSV?HYPdX:S@XIVM>fNKKJM/;M()1>cWNf0>M2>+0BTLXEO@FKDB0c36
1;M^]X];f>0G3AU8IX;SL:VAf_gaLT,J_?c8:_06-cH/Sd:4dI-.@XeK?8#3-40I
M8)SOJe@4LBK6PA7V>HC^5S<J(;2L>BfZ#@6EVYULP-VEdgT]Z-3PK_>-WHH2>X3
,Q+V=Q:EX:8B+ac4XT]VG7IfWK@eDYH4(QEB,cYI?QJY2ICc=aedQ:01&:[ba#EN
gT6Bg1a#601;\XPOZ&\3?X;-76;PJaQL#e&_V+c1e(_;5,SdL4OA0U>2b\-KbVW[
YZQ=X>J8(Q4&K_S[D:9EP;BdY?6S^/#M18P3;6G?;V>\<G0bY/L50A]bCd4HZ@QH
Q74D6;4);COA?M/(5)20W6T<b0[616?PJ56Mdd4_0H#Oee\<SD0<>8U[c#N;BcW.
X(SN9D,4PW.gNG:XJWY4QY,.O.6Z(gC\R@5K22?9fVG<0@#9X;O\Vgd5gZ75F4Z1
e)Ad<JF.MaEQ&=65_c;)XX=:;BTgTT(+UeW>gV&A^632N^MP6KT+XL,UOD6/+PSB
NH1/O4_XH?JFg0(_1H<6#I19\<aP<@]g8^S^?7V2K0<>994J2JWL9-=RZ&eU)>XC
O+M-ccPeX=Paff5XNGLBX+E.?/7gBAQUe&FVA)>^K?Ge_2I3D9N;)G/]a1@UF=,Q
Le?<>QcAQ)9RKK?RM0f.6?/:RJ49,CKLDg<0B[6;^[6G>?^NXL]9098C/Ybb<53,
8A1OJ9,XcDW_O=-\\?@>+5<GT[XHG;6/Oe^FP<C/CZFe10[R/@;.F\]<BbNa>EY<
8L.M4NaaE^Y#3eDQ\c^98AQPU?1)PJe<270TBdNWBcUV(G\>54<4)=FKbUC4=(F6
+RAFR=(--RRVT4>?F(V;#VO3MQ//OK<<B,8b@A\QAJ=170acB:[a(5_?=2KML,5-
9AK5/ZY6d?1L3;NZ_Y8ED1KDaV3g8V5D]\_=a6J5,a)S-H.@\dBZ6,Z,>DK6(ER[
])>UHV:TN5<X84d,H0=b;IO\W=8OR0M<18?C;G#12<:55fT(76=gLH^d=ADDDY_N
\]ZC=/L&WeYZQ0)7>@P]bH-JR@[NK<(=NP4a>1\;9ZWMXgRXH0U3ge#Y>SKP]N:K
PK\VA)gAA99&2bbX)4&\:?9IJaCBO@T?386H&P^Z)<;[?=-XM_M_\UZ_PVS1\QER
KSW07V#W3<L0CB4(>ABB-[X5RVA2fI9g[cP2>Z,X?F=&T1Q[Q&U,&F]>JMQT]]C8
4UK>O\0\26[,6BV@/\S;^4T8(VQC[,gT3HR95@KSFMVP82+RXf7+](FF+,6Fg3\=
&g7II#:LA,L+K<=X:;^_U8UW+)cg0<7^d_YE1<=I,><e4UMMe@^=Qg<:FKd&=,F]
dLS^J;R]QZKTV[35)H/6M(f./0;;[afZTG]<dWQBLeO[fbb<M8/RI&f?=6QELURc
&>&V<U6[8#NBNCF#,a<MNN@(gV@d8P<gY,:VAgC.ZHO6@)6FCF:[a&AS_?4JfMHA
6WS26NCA20M[Nc6?/D:Y/0LIZb1d_?(IW4eBSAC/1HS^](98-)H[?=3ORO\HF4HG
.=;U&fWIb04:]LH&E[T_C7#EE2]a]Ea4F[7FJ/Y9K-M4R:NUcYR+.6gg1ad(J#dN
>T&ed4dc&H7H#IaB<<&=@e[dVN.TV.VCGVV<S65=:KbI.:O7RX#)#c+(a5+V)+9]
KRD-Y-CA<>801W<Ka45IdgSPRd8607XeU[A<T^/>^A=7&K\f384#dBI?7Q^dGE80
?49@#SVbW,5GALK<])^-cFN^R@B@26TPRZfC@\W6Z@/A7N_M3&8XI,-&LHW51)&<
5/.d__ga,ESX8a&<\+@QVDN#G[IU=@G[e&/.)&#G9fWR8S+Z84O.\Y9]68I3@WUd
R;UZ?W.>@Jc4L009SWYR+V0ga8>NA/L9TNP#EX@&WUGI\02W59-/dZH9V](CA1-O
\QD\MO/Y-X[[TT?K\7^9YXgIgM?B)E8PM?HHZ3D[<#YAW@-Eb(9N+^ZY#/UKFD0]
>B>L:b/aP)7Nc;)SG8eR2?9D1/?4\UA\EI9/DUIg6HfA(cAY)H&d89KEU7^+KD#1
YC?K4SG>Y#GZ\L)9V[1Ce9C1D4_VA^1M);=g@MVf/c:L6:ZU/X;];T:<4?aO#M=(
D8g&M(bUT0bDP_Z2&_P,.@QRBBJ[.(6PBGO.-2E[>fV699BW@E5UKSG1+H2J31VL
VE4-^7UdHBC;018C^OfXJ;]OX]?a9A105UELT;@^X6KJG/4;b@X(RgD^4&A1XY^S
3]SX4IGKAe33^UBDYgX?8aO:S(\/d?JJ1Y2CT#B.F2FE:_gB)8<XF7HUF)<,FULc
aWePETa>7)=,Z+Pg0UJF/d>AT1XEKW.Db276-VHIc_Fc0WXT1R2IO,TBK,3b2EU(
1?6--+dU3_T3A1B7^)-M^AN<-3T:ASZ7XfHHN^C)0EFfeY<?R/ONVeLHNH[:K131
#NGJ,5O.Mg0^BLabR1bf+P6+<eERR5d5cB2G4EZdJ&7PbdO#-b?JeWG8R:7eP9CM
FObc>BS71TM85[+UBS-O.cG7&55]f#eY1Jg<.NDD7YLHPA4#I05D6#EJBFWSgXZ3
1<UJY7M;7f83LY]bKG:[]^](W<5B=ZK,fCA+NYH\2-Zg7>NV3X_3g#1H#gV\f&38
W?c&6Z-6Nd,MFJQ,YfLI#96(ZVVKSR><bPE]<<DS,Z-08+SZc5LS]&E=X(.fQ+\O
ED)]cN>F#EO<c=;4R2[?f_<-Ab#a(EB_e^_gdCFET017_-He/F8ZbOCO<7dZ;P=V
PEAgc@+RRK63P6;0MfST0&6[:.D^E)e4^N5b2Da>eVK+>ZWNK)_.=3=b6]]4dN_5
MZb0dO3=K;(\<]BbQ9a0TN/:,9-0bRN\IJT^0Pf,,FN4:V\Mf\-HGVVG?.HUg1a@
M<)-Q7KL:?VMQ2I7W80+HQD.RX/15Y0D(<agVGbA(D?>>BTJN5G]C@cJC)M(1)Q=
XVZeL93E<)>JMd?JYJ1W0)S6b/8_<5D[^A.Je_QB&+6O&5#.Q;8AD+[^;@2fPSA0
F.@^;H,Z#7FS9Z76Sc&1K4[F59GYF\\C]J5c2LXLR:aC#1,GaX,QS8YeK_5PCX9]
URE[?>ZPeV:A+2#A3X5JJOLT_U,-NS2OQg(5QZ-I)K0-?_?[EdIF7=?((L/FYNf5
;C7@d[EX=^AI^-&Qa.W=G7@IQQS)(?WO;RWfeK[ZT]^g;aEa?J9T,ZeAFEdC79O^
aeg3S(WWC;0V-+_@KSP]QG>&JYT-094Da5#9ZF8EZeBH3IaMTAfg2T>)8<A3C+M>
(QYgURe^N0CC-BF/BQ_R\B(;_)&#>JVJK\VcDeEVTKNMF7\&V.Y[3[(e:-_;ELY5
2?&aL8SSM9f57/+RBP6]MU#;\I.>FYb8@H^?c,If?W-5,;Q8:QGUIK[>PcCE:P:Y
AD2);_/O@C/BBM]EZM_0?G+7=XP9VNG4aP</:.cPaN+<KFGQ4.\[K_FV+cL;+;,A
P3aC>;M:UNaFZ=[V[W@D)F;9OM&5cd^UP]=M19(I8TdA.8AZ,0fcW0O3JTII>>b-
E+T[dN5P/XQ3WL.d34Ce1_WJda[B<[+];$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_MT35X_DDR_AC_CONFIGURATION_SV
