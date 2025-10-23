
`ifndef GUARD_SVT_SPI_FLASH_MR10Q_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MR10Q_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Everspin MR10Q family in SDR mode.
 */
class svt_spi_flash_mr10q_ac_configuration extends svt_configuration;

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

  /** Minimum Clock high pulse width durtaion.  */ 
  real tCH_ns[];

  /** Minimum Clock Low pulse width durtaion.   */ 
  real tCL_ns[];

  /** Minimum Duration in ns for which Slave Select must be deasserted in between Two Instruction sequence */ 
  real tCS_ns[];

  /** Minimum Clock Low pulse width duration. */
  real tPeriod_ns[];

  /** CS# Active Setup time  */ 
  real tCSS_ns = initial_time;

  /** CS# Active Hold time   */ 
  real tCSH_ns = initial_time;

  /** Data in Setup time   */
  real tSU_ns = initial_time;

  /** Data in Hold time   */
  real tH_ns = initial_time;

  /** Output Disable time   */ 
  real tDIS_ns = initial_time;

  /** WP# Setup time   */
  real tWPS_ns = initial_time;

  /** WP# Hold time   */ 
  real tWPH_ns = initial_time;

  /** HOLD Active/Non Active Setup time   */
  real tHD_ns = initial_time;

  /** HOLD Active/Non Active Hold time   */
  real tCD_ns = initial_time;

  /** Output Disable time to drive MOSI/MISO ports to be tri-stated after this time   */ 
  real output_disable_time_ns     = initial_time;

  /** Min Output Disable time to drive MOSI/MISO ports to be tri-stated after this time   */ 
  real output_disable_time_min_ns = initial_time;

  /** Max Output Disable time to drive MOSI/MISO ports to be tri-stated after this time   */ 
  real output_disable_time_max_ns = initial_time;

  /** Minimum delay between Hold assert to Output Invalid   */ 
  real hold_assert_to_output_invalid_min_ns = initial_time;

  /** Maximum delay between Hold assert to Output Invalid   */ 
  real hold_assert_to_output_invalid_max_ns = initial_time;

  /** Delay between Hold assert to Output Invalid   */ 
  real hold_assert_to_output_invalid_ns = initial_time;

  /** Minimum delay between Hold de-assert to Output Valid   */ 
  real hold_deassert_to_output_valid_min_ns = initial_time;

  /** Maximum delay between Hold de-assert to Output Valid   */ 
  real hold_deassert_to_output_valid_max_ns = initial_time;
  
  /** Delay between Hold de-assert to Output Valid   */ 
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

  ///** Assign refernce of svt_spi_mem_mode_register_configuration object */
  //extern virtual function void set_timing_mr_cfg(svt_spi_mem_mode_register_configuration mr_cfg);

  /** Randomize all timing parameters in between declared range */
  extern virtual function void set_timing_params();

  /** Calculates Random Timing Parameter value for #hold_assert_to_output_invalid_ns */
  extern virtual function void randomize_hold_assert_to_output_invalid_ns();

  /** Calculates Random Timing Parameter value for #hold_deassert_to_output_valid_ns */
  extern virtual function void randomize_hold_deassert_to_output_valid_ns();

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
  `svt_vmm_data_new(svt_spi_flash_mr10q_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_mr10q_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mr10q_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mr10q_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_mr10q_ac_configuration.
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
  extern virtual function int get_clk_parameter_index(svt_spi_types::flash_command_enum flash_command);
  

  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_flash_mr10q_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mr10q_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
LD?CM#M(C7eQ62NT,XBZ#>FK?W30^F=J\0)RC1;YE((;M5O_#^F?4)<4a(,MFZA+
64D1N7/TA1XFXbZaMFX\/P:1I?]=@W)_GJ1S=^2^FKG7LDdIW9S]SbDgG\:P&4(E
]@WaUNH_8dV8R,dEaYUEb0f?D/?Eg20^:PPE1U+0UYf8Ja0ZIM_Y5FX7d494Xd?6
K9(ad.T^Hg00G:MF5A,8g0GM];+D[/_]NCU=bdS;)K<eJ:@aT;7]37(f<OL<)7+J
OF=M/aFGQ+ND?QG&5VPXUMf.9H<:/#)3R-A-VYf:[IY@S3f=GK^<Jf=@6[1QK1N8
^/Y;]W(+D^2#)&d>Ee\(T;5;MO_<<&gaD_54SC<+@S)d#LF7HOK.f5cH=/((HER3
R<-^+=-He:de#[-HKE[MeVVF6[RPO.@,8V23ZK&:=?->\31K0g2VA2\#RBaa:=HH
Z5,BBK7TJYJM#S_/O/1GZH17bDK(Hd2eH0NIF0:0]SL/>[&S<Y-:TW.daP>e@S#Q
-\-BKc;I^a5&N,&bJE#FZW+2>->:2D7QfEAK;_HA,@UW7B.ea#dd+5>C4&6[94#7
V@^,eD\a;778T(3YEO_2<B34Dc(<dDeNIAXUSKVd[cGOOWXb73cW2dRQc7Cf>72.
.C/?2FRFb-3)Q#>E>4SF__^WH61NS=2QeAHDWQ7M.>.X9L:H7<=)53Na<KRI#CBQ
<=.P0@E>.39Sa7;/>;;;0YBb4Y>X1(L[?FZCPZ;0Od&C8++.4()V+Da?C-[+FJLHU$
`endprotected


//vcs_vip_protect
`protected
]7H##bYN?U:KIO#^UA^]H95:CGaEL,6ZJ77]@\(7[_QPA)#CeK.=&(<J:)T@2]dM
2QT;C;2CQ&A_Bb6G.8.^S.3:Z.O=YWIS,/6ES/cYX)(.9(U+fe;X+L.?=46]VEDG
(J&\>=D6^JdD8S5]7Q?^4BJ6(HV[EbB&EOC03\,U2XCAX&gPB>6T;AKD9_#A3bLA
WNOe]F0Ye]7Zc9Ba\feg(8;CZeUCedI=f-TF#7+,e4:4CDZCV0N/SbP7E\Xc5.cf
EW2T=)Zc>_DV++XBafdgG^T4Z?+H.NK<]VXAMEJU-@.,WW6[>++B?L(F8K5/g37;
=W[Z(c9U:G3SAL#8K-1,>]XOf&HfD5+\\L.,)C&F?FO\MHcW]9F8Q5\cM)[LJ@X3
+>@fc(I/7(Fa&Z+#3<J\U8cG_EdSGK<::C9GT;:W>4B(S4?c]IdZ79@C+RTQL9NW
;J\P-HS1MW-Y0ZgEK^(5/.,XeeHU;c<[ZEVZfV#THK-;&<gVD]T@<M+^<D3?G,_&
IH]44_)CH2+=eCP7MGPE7VbSGQ5KU_0.W)Q9T]V/0V4)OdOR>D-FDW_4MgG?DDS]
F\,L<@JPCH9_aQ.;6ZGCA--5f&&E@QdK<KHKc8S&D[\INf6=W)5HcPQd5=?)65b9
<(-@5]T5SgXQQfY3GMD7;+<+MfZSA;ZgeE#aJ<_gM\5(f@>B&]SQb&G)7<_g8N\E
.I+#\B0L^D_-:.W2]=>2^_BS4b(X8c>VX[0@(^fbc&NE3UDDE>g;SYa?b.g^V9Ne
RKS;[XRfD9_&9ZBg12eL_CFBGR&9O41[/7IH:cJd((ODdUULC4;9ZY@QfPIH6^BO
g[@E-O]gaCM#6C=1_^:7#38EM^c2J7G<LA+AB3EC;ccXfM\D,)R,5X[MX8c?1<=F
Je<[?#>3J89SY-X;b>=G7;.N^+?ABMLHAN)DPK7X4[</WYO&^DeaZL/?Vbe?&GOP
;Qe((64Q4;C:K9cf5=N659_<B3T1,)<WF]b-VU_PCEZKA:aA@PMZ>\d3[A\I6>\b
DJ#7?9,59(<HCg-.#fV\ZaUO12/0e9.f;VZ#(;;70BU,]gO&41c(cc_9O.O=Z5B\
b8?AdZeYKX<d+#fbM<dBA;9,g=QIGD#fRECfE^V0HGbVZ9eSC#_,9&GIF#aX,5^P
e6.E>R4YJX0]bIeSgaVHKHK+2K_J#O11ReSa14e_G?<@BT+L//BSP,Pf6fQLLbXG
-6FW923BC0I[+)8?+I=;Z0PMB3cb]J[?_;Vc/EDD:9<.P((@(Lb=BWd5>CK>R:HV
<#cIbbXYL<LcUF>1IfK;+1aa+c4QDJYM2#W>P8E>3;(R@\PA_M3\[EVfHL;Qe:O_
A)8\H76e)f#AUMGJ//ER9ML_1S7d4Y6;W3?XQc(8&TKA-g/G4PdQS?;3G]8+Bcgc
3CF7XVS-YZg<?\7H\82HJ1P?2>C30[@YbH9_[<gDg6gS2U^UQ72=TWL4&]eY8b#V
c^L5BW1=?6/98cF,_/B]@,MddePF]X0Y.7Q5K9<H9QOWA#JNeX2e(Ze5_A=+,=R-
6O[@_]LQEC0a<UYRG]gCDf\g&\(Sf+\NW;&_ZX\e_5>J1-<S0UL,R82KVYQ3>cXb
>N/#M>_IR-M0X[VK(B>AbQ[TQA>MBG>=&&a9I82A/ESK^/<eM8OLW.6RP3e:g5b#
WIR5NHZZ-:,I<.BRN]ZC#dV5E5N0LcY-EbO=G()#9eTe]QHL85;?#/8b(\5H@Dc/
RP\7.).GN^Q2Z8=SP46)B\M1<FbM@8K]WPTcb(#T8IEGA\e:PbQfb#Q^9T@g&0.R
N3D,b&)D9U+0+].aUWNZN[ZVeR@VHa=Tf@NSTR2aP-A6ML-bW\D)dPXZ7[0M&8IW
ZN[U5c3)E<,]]Tef[B4TNCRZC8+O2].^Ef1N\WQEd7_X(3f>AZ-5FHM-YNEO[Ua_
a#Y[1CF=fUSJgg.2g=L1/XZA8[L>/D<?]>eD9(KE>]A:ZcFL8;ML3#^WT=HgfdX3
b^c1(P9836(E24@KdA.//^XY3F=DPeSP\HSI2W:4G2AF?2+-GLegc6a/3W_JMR-8
Wb7^1_b39g>.?:?H)C.:(IH5:GOEF:=?V0P]AN1#C/0Zb)8=dD)79B;3[#MP7=FE
VUgRLQ)LG/bVA\H&[,NHZJg#<J+#G@R9;3S\<89#K9?A6P8FUR1AI.]E1+aYdAdO
^;WZJg[V_L>[5,F#/<X\2)+FF2RgP.95K;XbWC6E^IFJ(Q(C0\#dFCXX_Z:Af#9B
I805HQ2fZ_2F4YeFW7X7.X=R@g_(eUdDa.2ERR4<91[]9(Q3T?_fNT;<4[\87Y8_
(J9+a<SHSZ>-51c\f<E,E->8>2Z^dWF=GRH>/+NZfG2=#P^,]de2GabCS@b\)\YS
g73:99>/^F,b(BU5Q0,2VJU?246;XLf3H#KI9B>VJbM/83+TL4^.;,?B)R<QQ@94
9U5Ib&Hf,_Ua@@-5c1_)N[W(/cL259VS#fE]&U)YW.5+^.K5X4MZ.8]V\fHXf48>
;aYJS3GX-ZYcJ<>1)\<QZZR+gVC&S4(,7J6G?9?EG;,8T0WJO^3-b_Uf.>6U/(-c
0I9a8L/I>:#?ACF8ZZ-AL\^Y/e2(eJ8,=.V+G33E1LOTHe034gce]-#9[&:=D>VV
RL)U#?aC2HZU^5&/AA@DN=W[/Od>6E(gX(37Y[F7J@&<CK38S@A5W-SBSV:7)MRQ
,dbEXYTfGgT1^(<\5U[IK0C[/1-0]egV:cXA62Z3#4&PZT&eD,EX1^Z1?=]RaT:9
2^c^:W7Vg?W7X=Q+BR(18b:UT,8@gb0)7&G[MQ4UVU>MYL/6TYX9A+1&ZX&[aS&3
9WF;-3Z-b@-BEaQBc)Q\.PeKCND86eLDSXW)(LR&1QbecMaC..eFW+dU=X)IgN\]
,?+c-d\DZ?BKbLIc/F,WaI:T_8EDa08,QBRDAgK#TWZ09UY952-+#fd[N@Z4^?g7
dQdLRPaXYA>NKf2;dP.1;J8G1HZCFf\R>8L@;\0:[-I9DI.RZGFaS9DBSf+A_U85
YDTbIKZRPf_;+@XS,e24cb>M,K;SLWV:Z?_4L<I];g_PQ#aZGL&\gg5We5;NE_\a
e/bg^Tea_;J@&4^7.SU::gF+=R-[L&<#+T:#^@Ee:H9F5182>D+GgY6Cc]C;3E/&
>4f[]<#WP,[+;;P\&73b9//cULEUcPN<Sgd9+T^7[RFE8W7NR(a>O(aL)I39D)^Y
?[+2G8]?STMZG?J<b;<;-S]OM[Q7+3#FO+QA,U#^RQX3L3d,C-A]SXSL@7O#C60>
1?HH>U?9O)=f[\Y:#12_)OCY8I2]O6;TG>BF<.BfUfF^G)Q27#F/I>U.eOZI7ZgT
@BM/QW(SC(3&YRF(a[f;INgOTL@)E[57.IUFTF.B4@+bXP/G&?fGB=#3-,&,Uf&[
K2>+(,P/EG+-NU#JJ+SY=CQNB9+I]Y3,&?(YG::]BL:f,/f@3I3BNAVNY,P;4Nb)
D&<fEEf;^#F@IZGTP5LNQb4,>;6KGQCe#P[5;f(5:].<MTKEO[O8&1@^Q;7)K\I0
E6D@HD/YO>Mg<)HP1HQ=8V:L.WN-C-N^b?@HPDBLM]CJ&MIEcT>6ND0f#DcG+L:#
A62)HV=[F#gR4,TV27\E]LaJ63]?T,OJXA+G/\]4JaG6dQZD#/8f\HFNb7;#bbL>
6L0.P8AVKOdcRD\G/MXY69D#TZ^Ye;c]GV]]?0-\dYK:(-J6XW<f>G\^&A,A-039
N10)f?Q3QLA\1^W[IUN#WLCK6I^bW4eCZ5]^:6\b-2YX1ZTH:\7<Gbf.B60>)0Fb
Qf<L=K?.LTCe/1;0ZI<)TG5g]]5be0g48I&RG+[80Q(2+7KMZWBJ:7HSMEB<fBB^
NgX<K_O)FA?6E,UBL0F_QYQ]<aDeV0,B2D#dTd)(b45S_;N84EbdM,ZR2Y4=g8WH
bL/3)DU4(1NS1PYSf[\b/1C^Ee90S3Eg74G@T09]H(MY:VD0F\bPdI_:^59C?_ZZ
BeC_DBY/32UFf(b:Ud_F785J&XP8WYGPcb6eEQgM+]C?Jg(&EBYP,/A8MX+:F..U
g@)WTYJ/@#KT3g)R7b,?1TDN[If19[d3_T)-^&eT5\.5_2[ENLYO,MJ,J,-2GH2;
O[N&1EB+UN[Se.2S]JQ\fef4\QWD3PR[Z668eQN936M,(6fVH^#X4E-:W2T1LIW7
U(2_1dAaYSQ>IUU=2YULVeQWYSH8[2;HGLZ-dDc_[4Yc4T+^9@#/3MdCf))\>(SC
F(6<@YS+)fF4&(e,9/<]TJ95]1X3ZeV)2A(SAU_?UAGG(E43QG^\8A/K9eE3gC\G
[aRSJ9:C1^=aK07;,^Ac(\4gL-/+,^;J8;#6Y)AN<&^fS>U:K[@b.&/PI,\9CD(c
>DRY1+ZVZFX-DY^VgYAR9fTC,T:IB0e/_Bg>0N.R2.2_7@\PGbG8XTg^#cNX,c5<
M268(TS[ZJ\16gHe<0FC<YA^HPF,()e^dX-SM^U\/:MAI@X5_/O+>I[=^WQOJD<I
5ITaa63gQ1817I5eMdJ>3]VQQ^H2YcZEQ=>);G.#F-8MUK2bFdG&,EbRU\Be+d:f
.RY,0Vg/,F:<FAOFeF^-KNLP>(0F3D4OB^&9#,BWeAWf.a]OYZJ2T;O:>HJMU7TI
0UP.J)1gcdBgP\bRJ9ag&4VFSgSXIGYCHC]:O&[2MH0a/JIX/D,DO\-INE,UP)bP
c<WQfdcRXU#O6cH&LP-C\R:UU<-fRU2O8&L1C.?9=)2XU051OPX=[,RbS,g=ObQE
KgM2^@6..T:=R[\fQ)dL-fMN^4f8_,c4:a(+#0@Q/Gb5(&#Rc^C\KUZ+b&aFS>BF
D,3^:LE41BRW=;Y:2g:[f:U-_#>)G=^Q@#05N#]NENAKI7S4@3-R[Ve[U.RD]TBF
LN#(GW;Fd:);WOf[[]a#cMBfdR]M\\HO2\;I96@C+bK#a24>(^E?XfY466NGKD2_
STg1I,b&SZ]Aa.B#-d0-RN+e[PX0/7Ga+SR?Q&c(3g4<XC+cS9JWESWbG5Q_dM47
,;e\E?WGfSU::QP[T^#9AFWWWF<B9#Z^Z]ge@Q5(bZ3V+f1RL58g>UHOc0E[U1FU
XfY/7]54G-CSP[8+E\Se-(,dagOY0L##+7)=Ue]9ACA[>(P(g<>RbYJP7.Vc/b<W
S<,[09=Zgc@cYfb[:L,4aP]4ZANZb-=fG/-&f6.KFRAL]1>AK-+H)C,7&@->.M6J
3:)UAcE&US=Zg07TPVJ4IX,7eg20fFcT<B,_&\3gdc+E(@B5#F]//A6fU-??gF1]
2dLb5JJ-RaA1[^?3>>a63aTbNZ8Ie_=703EU,.3aV[Z.;#V/C?AWUKO4A>bcUHO^
<A66&a:?bDfBR2<QM[P\)RH]T=;cL5J^7Va6K3ET,34C@F=TV?;f5U<(5L.V5P8(
(Y7F\2()MH)8U1I,S<M(29Z.1-29])D7]MVeJVT=J:Ggc<cM5N,FP,@+MM<XS14]
]c>_\+?/WW/?_[D22C-+eVgCWM^3C-M-ZE#IKe\Q]P8\UF2O>@VJ5Y@47:eUd(cT
V>YCK+LNRP;F=-)H-:f3@cgdSOGN73&/W7ZZ5^B5cKg#F\P5&._H93Og9)LfH>W[
[.92Nd],0AM4>aJ\]/F?Ac\&\0Y^\b)DD6e>6X<QZ9IaTEM?d(:N:e&d59TI?\BL
P60PR[(R0C2VGWKH1163753C#N2+X^0DB;K?QSX=Bga.I&@JU&=Y1-cLIcfY8)7F
[OMZdDY2#OWJ->T7=?cF,9?Z^bIK[1@]0&54-+)ZQ6a)LD+7HCGOa,IbXaLfRWgU
b&IB0QAb.c3^4Q[0LfX]=afUK0TebWYLQ<RP+&7KE4GIBJ]6)U?=X>2<aG8]^HFV
Y;]H,E+TM>##8U=95N5SW]+0+a=KAfV6-B\+17L\<WQJ/16;#P4C3TA8=<;8;D/J
c,fUL/5TJ#0T&g7QI^aRJW5EFF7>(4&4;IdO06HC?W]\VC3=:^N?RCI)PP?D(S;#
(=;Y,I;-EWZB5=T<a^L7OD(0>e11:M-RO,.17\4-?b^JX-4E@Q+;\5)PKWG6aQX#
+U?J@[03OWJ&\e\O\\#3UQgJK@YIJ]Pc6N4<ZVT)3(3=.W\dG;?)16@DN&gZ^-PU
NL#:GRe>OH&g#O<MZU:](M\C5V>PWVRFHUCJ7QH\+6N&P16Cc,O#TE>bZ45b?KJB
1ag8eQ?PYDeb988X./&Nf>R@\fbC;P;=]?OIQ9AVI_bH+IHdIF=\H\]6#\W,Z-M+
W]QMQaTe)A@2LC3>YR007SRKSd<]LA6QGI)C2=@\\@J7J<U+)WJ)8OfWR,,b>.4[
bg_\B@:T(a:eb&^K&QH[QC1KN(?DE3?;T->6GJ;.3<aeT^/aH?MX^@eVCc?,>W<A
4^aFA.W#&#R@J.7TXR?,QJ0NOg\bJd4XgQV^=N:RWZ2>4.g7\I7<>,_)Ed2bVYeg
YF2f)?TLT,E^IF),fXF-NX^SKB/&aK5[;LL+>/5P+&G-KTdATQ:8^+?+)<7AMY:3
e-(9OI94OKSY.51X:2Z;?AB5._7C18SKK.#\9KY=97B2Icg[[gFRJ[9KL+#)-)--
6BSUYH+.7/FC.8AH638,P:A;aeQ7eE=fSLA^NU=7E/NbYa9O]@YdLXVH+#@?60cM
.W4b17ZY\C8?Q:(==SEMTYH0Q0K-;:1[(\9)0:R/f(89aJNU2[B/SO7.E9[f[[cC
9GWdQ[GX\?;X,(eYI.Q_4Ag:R<-T^6Mca#9=V11V5#6;b29G[SK8(C:W;d0>^Vd(
W.ZW;AK;,:gHg#7+<TR&QP;QWS1TaXcO.H7QKKEcSXF-,4&&aH=L/3E//RSSJI[1
.?=DEW:/VEA.-bVZ(gG?Kd\:Y6P?)a;O,7V)72XD/b8R]7V,Jg^3G72D];0?YPbJ
baZSgCU1L)MX6D>:#N]BacbMLRF9D#[;U>EY;KD[_5bG0,86X7T5FU9eJ?\(#;^[
--R&O:1-A;,2.6VFE@I^_9bP+0]=DOX,(a.8I_P-5&DWN\QC5^U,7S>,W.N.B?GT
3FFSLbF665S&>LVQ4V5>?)3Ved2W_=;7/\O@9e@27II>QNa1Z0+5@[gW[\a1X<?(
3[_Q?.3?7+P5adN]b..Ff/R(QJE#G0I55(J=MZ0L]_CV3H&VWJJDW&79e///@@W0
_cdTDb&a@S&11BeNY.a18I@b(.O&P(/0^Z+c8K?<<:A9C--,W\GC?=I,@T4g5f1:
LGT9,K\PQF/ObeXZM6EE^3^19.LY7B;4^T,/g<PV2C&g.&Ma_F&&cM;QJ?a#;ebR
2L01CMU28W-cFaV9QR_\>4:BS)Y,:M-?V5?)b]4]Td=</2Y]3Z(,A,X)5KD.P9Ue
#&OROJ5F)T&MR_VZ_;5a:18?W[.]_T9:0f@6<0D;6FX5OL4@gR<(_d,L=ITWI65K
McGD.W:=;BeSGG=^M0&)Wg(#KbKa&(:=S<H6QJU#3V?H7FJ3eQ;OBfC+8,/]NVfa
@Z_:8D]SMc)WSf5Hg9_MS^007e8e6)89WV#L&O1?IQ#cE2EDO;OE2R0&?b[HfQ:V
/F-J)K9Q;J76@V.HB#KA4&9gG,X;?+4#&(0TaBW7FX:d0ee/D5_-A-dEVa,,C:T0
c/Za:L)O>a62e-<]f6C67PH@C1CTCYY.+-ff@gGe=4/PTaW9J^fQNNe<<E/O+:Se
N4UbV3f62V\gT>B[CN4(J+>cKA&gJ:VXCD/FKM83PMOI?7.F].(;RPV0d<<DJD/L
5BZTb(^U#K5fN\,G;PRTMWW:TYB0+[D1?-3U:=BW1a05LgV&aY#]@D;]1_a1A>Xb
G-+GBP,4#&ae4=cF_dLZO-4Ye,O>;D^IWcH;+(DPF<&>Jf]:NRVI>HZ?=[2;f:A3
<ef2<A(^-^PVWe9EE(]bAgc._b?JYKICW0ZCSe?/]-PdB/JeQ9aKbQVBc&(YC+d5
:TII?I-0eAQ356^e[&4DK7D<VO\GdP1H[5QPU1:+?b+]:GLU.GG(YW8/7.FgOB5.
Ie&J6#LGJ?:Q#D.,T/X+O=J5^H6&[E4Q;e\SZ2?\HH)e,]1G/HO;6;FJ_EP8bcUD
#4fV)&7B4C[C/gHIZ>B\V0e0g;3;?.J-IbJbJDCE.FR,92U-:ZMF+&A8#0\=/3C6
NR>W46IX#;g+E0@QU)KBL6RcId=^OO7K.4^+8IUC&9^+d.5QO)LJ:,[FK?0Y[1:@
F_2OOA83.G(T[eV6V7>C1XK104UaKK2GD0V[ZSBATH2XZ(L=eO84e,(1R#<<],RM
>bd,D.f-aIXL&@a?],3;@8CfaOWLe^^62AN\8@ebZOa+Cg]O2f1g^2U.B]0]a&Pf
4ZGHX6NH2KSWeIR08&06_;3VCaKCeJ=-aASdDf6Ig-bHC_V[)D&MY[\HDIMF<]aL
<=P&S(]K4b7:cJGBc0M&RI.7R#a)@c467WgcZX<605_eVTdbCWfV2C4A,a+(?fSM
>(2MFg>D<H@7H=G/)2ZUO/(?,6G46a.AaX@(G(TK^FAKQJMP]SaT)QOVHgcENLHf
J75:>NeR0fI7DW:>C@VPD6RH]<2H^PZK7H_Fc&K18^]RF[JgDQJe.-]0::e#[(]1
:,0,K1YE/<]=OV0^L>:_W(7cEHdEJ7A_0-B5c00ffCOa)^dHD=(6ZED2BfSIPScH
>:eJ,;K[OCY@ecD5GPJT<TNdZ=_LTTON-?f[9EaZ[.Q/YL74BG?PM)/200W5(4d/
=+(Q,gg21?HT>36J9g9]FV7.9@/c?+YSTJ_TWV6(Dd#\Q_3?O&4?8.G=_05aMOVa
e[e.PW,KDP^=W535Z67:BgYBEQdODC.O_A27\-_c17-S35:Z@YW,O[b_?-T9gUAY
2]1#QFeG:JbO-NQf-QM@dCD_2Ja+.HD>RGL]?Q0^K#09ILf3HSS35;\U35-7>D7N
&[#:/O1:Rff4])3)]A3E74]VQA>Xe=;)\G?\45D[[S[&F/0B:aRfF:V98f&]O>4/
LCB6)[8_GE9N4F\H7a>N_>M0W#P?DF-AT;aZ9J>=LE3AWIS67Agc^+/4bb+fAHIU
8G]fY:]V&:W^Cd;.NB[&@NQ1U:GD;#V<(^\QQD=(Ld.,Y4S-4ZYb1#>X+FP4.B_e
KD3)YJ^W[28>O2Zc5]_UG[C^+B#B^8+B.3K>:L&\^YN4GIF[#Fe)51ED(HM87^;D
ZQH06QK6[\ga?Bf0CUW@(6?_87K?>gK?Jgc=?[IL8[1FBaOUCQ#.D>7#g39R(MT:
DIKbeQ>3a5MKHEWD(4g6ED(JfS^f/9&;JE<Og:+9?<OU4T>))dL^1?;GTZ<TcO?6
A_X(J=CLKL55V8M-IR<5]eGC02KeAYQMVN6NM)].FKA8TRVb[P-f#@I_c(VW1d#9
Z4a6DO=79ON+([[OKaN7\)OHS_6MSVMPHW59EV[bd69b/(:,V(H\]^GMANT/^(.)
[?866L,9/8/;1PgFTMbL&?Dd+4,8FL0^799I<1#[d^QB)I@4(GFe;?^95&(+Y9UW
16TcbF)1A3[(Mb_#BdMPQ/Y?=0&7RCO?-I.&C+CFDN7^3.FWC:(@??g2><(ES5X]
SGGXB?KAQfMR+-PdHaX-<aRYRb:6.(b4>&V(^gD..c^ObM<>[d@Z8O7#;]+0NKS7
>:]B42[/[_.-aBM/1,de+VaVHf^HVEKD4Q,27Df2&S,:^WGg-W;B/]/N<.VBQ2,b
XK7NXWd_9WP(#HT>G^LE-(V.0K(;J-1?.)_AUWc9WBgJ8A]Wg9B/LEDJ1&Z292?7
X1[Z:4A5@Xgc,_fST(<&Z@@GfX_K_gZ4\TT6Q:D4+9EO?HT]_X:bKH(SGa-BO6K4
eZ@AD0M787O2JgRcMI(QM4-TR#&B?fPP^A1;d[4+GJfK:I[?/];f+a13+S>_@KML
M[&#^WQD>LQ2c9,_V82=R5SX3>]=-.BSS]_1\fI=E?(HKP<5c)ZOI_L<+TYENC+H
VQ>X+^@[H@)PfDQ[ONSU;DIc(A#B4F:63>cR=R[ff<3XVSB,gR-bU/I0MBdX@6J#
2F&[WD:#7PVCTSaQ@g4\AR7+5DLZTNV>M7FF1CbRQLA(WJJeS?[fH<9Q4JT)a44c
FbN&D]N>g37B#]3K;?9ESX0)B28^V>UA(^8\H]?([N&JK(\ed:3)@SCVG4Z8?LW0
gd8,>b[)N&N/L&?a;C4V7VWN1B_P@4>03676S5YI8V).-(^MI9XARK?F\.d5:8f=
V#X\[b=)c8,1?I8\W3UbfT6;7<:<.<@VBT4OAPUDYOYeT^M]?S?Pd^CY.3RfI)E6
625g8TE=1+KgY[<dYVFL1D>L<<L\<Wa7aF(4\#ZG56^dICI>)H;>ILaPf]GZ0)]/
aLTE?_G.O[SG/0<BJI,>GDH,e\BFCTBSXQ827d@GRaD?<#dDG]C>82YO8\I<@EE3
d)<MBJ=/(b_V[()=NcT4E@/ES;.g/U5P-<:NIX]HH.R.YM--8=54c;O@QQ5]TV8+
+0OX4#_a.P1^+>;aTW=V8A\-g1PC3/K2S[;.=PA:7R_><90EM^XTd\NMO7LN=9d&
,6e/UL2(I;]K=45T=Y;(dU^QM7U?CF4A3e6A]]&K&2O5DOPH&-;P#1Beg;gBQBP7
f^?JNXO5A9I^JY\FHFU4:T#(KUa_U_RQ=&V6,#=H6:JY-;R9c9cB^N])VQ+?Q54c
,Ga,0T.<M\FHT8XC]gEgfTLY??M.3aGUZP:;dR300b;EcaB;&+05K=LQY2b<IDd>
gT&),ba+6A&g\NZ+Z4_)H6UF1CB459e9=?<8F.-/#MR3-?6?9KAY0@QdU3#SaCA;
2;@@)DM@UPb<FI>@;N]??1G>3;>>298-+8N64gFa[S1:RX+ZF5b5P#>USS2OabGK
X]IJ8HN+C_eb+86W35@M6:,c2OMd69E(UD&4HTQ0&<]4<E&P>QKXUc@\>.Q_=XaD
fR5P6dGW,70OWK6<[89c&RGN#Z#.NJD#@_4P?@e+F_05@c]c&7R^]H4?]O1d2>IM
+BE6XGXDX6U+TTIO+/1V:8bb_KIGWb2IV0Z5UF-f0/P)Y4W]b<OD[EIFRPPT5UWY
48(KZDH_Y-?P&f@@=:4HX=e9cQK-T5N[OXCTFd4A60,G5QA93EI\^W&JEW+G?N7W
#K/=fReC5QWFBT)6[Ne?33f=M+GcD96XTW65F.54SK=YNB/DL9>/O&?,#a&gW^;>
d]:##ad+]C)OPWM8O&9gT7_[Hc=9#32S&3@4/fZ>S<be-Y^A>(DWAJZC<482c?9P
<OX7+/2Xb>43HH(V3/PC;I96]FNDVX;E\DW;U)#KQgW_1>?#A2+GEXLU6/32fIR4
)@-b)<<f>G(_9,05SSGS:/?<3>]_]^+Y;GT#FY443Z(CZBPbW4aK>-1PP&]<dYCf
5@65;EbTT](@<b>OQ,&2JP.>5E<[a71-eLVW6PQW2JG137&121_Z/M;?AbCQXcJQ
d2H;J(G&PA4=8?]TEf+H5PA4f/baedDYV3F^>B4+S1VUZ#\=:@fab/U>/).a>gdf
Q/E,>./+]D&/IIX7S)_]D\R)e<WRTYbdTLGb=]BV7:7NL7G?;^KKa4VQ#=-S3V7)
6QMV@M:R7eAFU74VZ(-TLKd2_VBS0@6L^#4:_WCc+;<1N^\,,)aL8[^,95ZBd>U,
7>ZN//f<QVZcFF=\_:Ja^2-T-E[@d]9LLO=?HcW[->LLd<a)cFeMK4T9SG-_,e=M
+f25IO[+&:#3.O)HK.+@7.]UXH1Sa.CDcJ?61@7&ZPN[\_D=?J-=-Wf:ABVK.;ac
C(.YR2K].)?IR0KSBC4IA,KS]MaB]+/R4Y/+=2N[^V)aDMWM2#6&3?U;c-;)V(bB
[WO4L>ZbP4^a86T@4Xa:,YZQQVC/:SO821[0E^a?T9;d.PL0(d+]H(0eUb4JZ6R3
<>V(5f,?W&P0>+AF<;&H=V@=?b6;SO;aaR#RI#O[N=.W0d>=OXEQVQSNN0\:S\C8
]_[75H#Md>dW2aL<+6dU0,)QS-2ZD146.J)7b,9QW]#-EeX42(ZK8Zb[NU=GQCZG
KEC(WJ3M])?7dQ^C1I+@aPT25OFTMFX]ZOf+Y0\HC>HVH\18;K&eCe_3A5=d-H0=
A0^KgY]H)8dQfE8a;NVC4a0/^IR_#(=S-b4U5JARIR6U_I_VA?>.+]5U]_a?@ee@
e8:L8aZ2a-Ncg?J0L1S+QI[@;-W95_ID5=<eg19RQ(8^RFU=W3;U-/7<M3J-9SOO
FJP#3MP\P^39[V>>TIHbNdZL0-F1GdSYAE@^;2D4)C^BfTB>E>-]af)EgaP3G@3Y
Z?:X?VGE_YPJ:\gPQ5,9J^DJI+/&U71cHLb(b1a6H5V/\a1E>dITRe?G=>eG=dC9
V4eJd.OOTOVZ_80&ZKfEPaT8b]ERTS=,G]P(I6A4aP?G=F[>P5=7/VKJ(O?ZAA<N
Z/@QGCS/\g>=?42Va-U;U/GF7(<a[HV_:>CG/T\AN[<fgD)?A<SSR:=]=3URTIL9
R\,IdA)?4O87,:4]3WcLH+<f9d^>361JZYee#+<T>B?;_[8BgIY5G]a+.ZaZO,YI
M[9HL0QV:5cJ)g7IS6K]/<YO8e;=NS._QW\@f21;ZGf^&c09Q;.,8cLg1]EcV3H)
(]83>a6PK5R:9\9@<64g)IX;+<NV>1.gW4_0D5W[Q>B_3OcN9^SYKD.^,YB&UL=Y
^I0;\E0U_Z&9\M?@5LFE6B<_ROUb-D9+&)g_)</E3cMJ1BIgZ1HNV+-aCXO=UCeS
(4)DR71S8,g@f)+.#M1f9cJNNJD:.T_WVa>Q]>N<@0.R8LOY>f:8S\bQJ-#G;+7X
Ad+CS^B)^]N[WN+>b+_K07[KTL:S((^=,]UXc_9.@(N1O/+&ETEGTZ:b<QbXHPVb
C/dedN&Q0OE31^4-UfP\O:Pb1?B,A,M3D+,6F/6M&/e/fK&U/?A9Y[-UG5>F2=c/
b^_<?V+H?IS8K3BME<[8e?YL<5MGbJgC,H7GL\Uc(5P7g;Z56A6WZ]LS=3-);b5e
:6Z.C:_87F1F+H\0&)XEBR3C1)d4_U-OQ/:W#DFb?83T@/U8AB@STM+[<b:^G10a
PIH<4N(GM4=c^<G7UeQ9WX6J+eBVKP&CO?,NX;+UJNa.M5VX22:+cV5:&M#5-+5\
.W#U))/+<7A>HL#bI]@Y^bX6VE:3[aIAOOAXFG<<N1UZSB5dFAXJ:P-QQ,4/Q@ZN
8O^Qb3bf8@&:-G]?>UF,AN@P08V-U-\]4.ATUd+I<cQ1+R5-NX_U#KUK2ZafV<ZX
Bb9/-_cE6&b).4_,Vg[Y2V10A?GORKS?8V#&<eI-S1E0ZM&;E.BW<GcW.NN>WRW7
=8Rc1-8M,4eWHS\4:REOgI>Qa4B,DYAf[0=2OP/O=:2MP\2UWI,20?5[<;UeS@b_
@@&W0a>2^f1bTa-&5E?T&;T_;HP0-2-Y)MAM/?(^XJ[+:7G,d:)X@S-;0PU^+],(
>NC&/4cTEXJ7G9BPDC)IBN\Uf(F8JGLb>O8\#W_81<\Bd(aNV)^N<,<YKECB;NTG
.:QAL,?aF>WDJ[3aP,XV:If8baCJ-@+8Ng.--ULE?3TT9P[0(e(46XJ\L2C&R9&:
ED1P>9H-f;A(_2TDY]K_WF;g_b_d/Q+]+,K]+f6#AK&)(_FZ):BdHIP^XN-9@J&T
[N:.\YKU#K8EH(]^B3XIY<>^f,d\+&RU.<#_aRLKH7;X3T;KJQ,KPV8S..C?:8ag
bd1-72O48U7I-WIAU@VE-ONe(<b83YLA8dHA8,-13YMA,U54CE[_K:U,.DO[EZK4
<@.>Z_16-5=)E,F#@X/16aS4C(6JO@7(P#XI5>1()aRJU5W@[UFRA^Q)@=aeaU0,
:Z6f01A/X-Vf4RPPJPEDO6FNN_<L,g?6ZSYZXbTKR;B)6?d[IIG/8O:_4#c@Y.EZ
6FP#009D=:;TWc]\Wgc(/K]7U#ZU+RIAO_K8--eb&S&;>[:&JLAe5VWK]\77(/e&
c3WcZO^7;4)K>P_[&?G[UWdEZ,N&5SV-<2@<HXLVWM4>VVgPeK&17HA^)VC36;WG
9SV4?FMU1b//dLHM\Kf?7N,0Dd-^Kf?Ya6+1bL1PY9JY3GfcOT^484V26T02P&UH
fO;=2_M8@@IZ@V?,YJ3/@bL4&9g(MLH48KP.2Og11#c]YWV;:DRIU5S3D[=>Q_PG
1=_-DL-8f;OXdPO+2&F44S.Z7>>CI<K7Ug8]1RSS,D#\X14BKFY8S(5IOR5?N-bO
C\QX,C#YDUP>1((Eae:Id)KF]gf][ZY33[V,P(XLB_>>F6bc@XRgc7(S8W^[P/]<
;]fO=[c,[V\-<6MC)NBE51f65>WZ;^Z4L6c[RB_KL<4SNSSHNJBTIL_bUQ;0;5Re
3.e2bYX27Q</<BCO2C]dT\cIPFf8bCQ>L^GeQa+L8UEW?D.&RD-ed]/2:>.+>5bM
V1/;JSJg29M.XOaZ>#:?F7C]bN/=AU2G2\W4^^@Y<fLD.9YW#;>H.(8RbPP^bgeZ
N]+^e[Z83@fedYDAB)dS\Tg=?CgKIaUV>V;/ec4_-cegc0FU/HJGU11aX4LT80D[
=B^3U;JE3?.9<4\L[=7=#V]6f:?d_,&6MI^KT-D1+[MTaX0HGQMa^&<[<N)(1^Hf
6OTce3]11Z]ZKDg^?9<=EI]d9Y-O^.)4WR;#e_MLg+>CG.Ef\d#@QDKVB/Ve+LN[
Y4O/&cS+a4:<gERZf-+=S@XV7>Q9<B0-.JL.<@6W5-RX,TN?2G/I@,Bbe?Lb^O8G
X)<@232IHe37Of^C3T-_(NX,VOI2eXSAA<1DK?G>T).XgYVeK^O5CIGbSa9#ecZF
C\J+JA(W6cM#W.>QdT6^\,?1c<Ie)cD@2E((WRJI8<6Z0\&=c].&D3Kd^OK7]a?R
->[=?5T[(0D:d4YeT6>adCK/bS_-X5P[BOSgT>?2)5TO(0XG4](F220UdG\G]=T@
R/MDb<_@Y8_O;(/5g0B1_GL>6c=+3]I5O6X3H45][ONDUd;W:\._XGMGPfGK:)XT
-I?-)DR,eFKWS4c,C(Vd8(XPMZZXe]ZR#D\B/Zg>cUaZ\E1.dZgJ:Q3Q&F_a0;>,
g<T(:/&H9G<A2?2gCP(>X66.YfeR<46eSDXUHLQXg@f\fI4Q#?HU^P&T3R7FcP\U
TReHY;GR+;<#ROc4:VYO>[T2e=V6IK#@M-=B9W@&2ZS(&fKV?./WE<H]YG#<BQ\=
IH:9<6Y2S\6egT3D@-G7g/bX0bV9#.(OIH-S)]<fW)8#Ma7D1FM(23_;FK8W1M+:
UcK/ONO\JI3<70.KA^dMd:&PRXRG,,O5bCIF4+8,O=7V9=#1^.>M?K+X0+#P8bAS
c13A,_9b8_(-_FMKCJP\T7/+T03@ID/<.?,C1<6&YFN_P:HP50gYHf4]V:J4&9cN
4B_-0\Me]^?#Qc9a,+]F@H9@Qc3>SI.#L=MIWQ)@_)W=Y2ZKI[MR:]Be#?O.5BFZ
.)HC.d29&:[JZ0T#\D?8SfX/c7LgHBT/cF,EgMED:aWQOSZDJ@<-#/L3DGQa+XbO
eAYCZ)5K034cJKY+&,Q8#;2c[C(cGM36+Y6F;;BO(>2EbNRNEC#BfDaf2#c366_]
W4Y2+S)Cca+BXMfUHR2bP+MBR(OESXT]R=PNZU\T-e-GPG]T3>0JN)B&3XU,M?RR
<:EFZ(#PE9?J.X9O#,6.QBA^RD8_Y<3a;_WJ0I>Sg,Y_TEYb1aIFZ,-5^8VTWE=?
Aa;BL7?IZEgJ,X]M7H5V.Yg.TgWXSS(YdEH#(OJ-?7=9Y-PX&Q>afW50-7XTOD6,
Gg7.U.)^fd3:W\f0\<fbe-1<HL<P:BB-0N,3R_8SM2g_:WI&+F+_3Z&>IH/TD_];
^TREU83_3[IA.[5[RGb4?aSfS\)EW?YX0&>N1ND9?@473>T0^_Z?7WF52Ac=W;cZ
D+gWcVa7J]FfeUYPNK0I?Wc/^?]8AdUH[:c[1]/=)aYIP#?[@],Pd.)?1+DP5GQ(
I7.+:b/&]SUBNfZ45@/a6HLA#)-VVdL[NIW17&U^X26IF>Q:L67\]GX[[F3dC0_4
OLR&+K#7_CSJP@<PZO10:LF2/R2I>+b^<&OAUTG<P1B14/f7@3Ze#MP[[/bC@&[A
X&PI>B4YQUKV_TUH0HG5[7c&[CA>>T^dGVT#N2\d@-REU96USA]VHP9QI5JN99]Q
g&gE-&.+G?(=N?;NJXJ_eKV44G&XLa#\16DcJ[3MdE&2(?R:/RODJKbK71&\?7/W
>fe82ZUc0+.#Jd?.FIL7HBP;/M(MU=,(Hb.C&5ZN-aHTGNX5CCIF4ddNRW5_/L;F
#9f,#4]cK2V)M5#CeM^>Y#@8QZ<Pc)&1[e9fM/7I@V7U55)=d?+T:&T_&gA5H,1:
&#\.N0\b@[(FH](U:N4fPaQ2D85d:VdC0TX(5\-.<N+GD7f)G83:,5g@O7MF]:(K
2&2N\f#30g-0fRI::7QLKL(&-;QM<)CY5CMR73ZD=1<4aZZ;O9DJ[Z18D65a:,>_
6ZNe996772\QZ)?f3(WUH7@=VA-?LS209]39a=R6Y^-ON#IDY[^<2ZH;(cWOJgL3
=F56^(Z[J6.(KY:MS>>OT[+Pg-V?VS:Xa-(ZSF0CL274VaA2_N(f/[B6.Qe5X\;D
&gHgbZ-]&L:c([YX8;KBA.PWdP2=T,?#Z\QDHJ2A4D.Q\POC<#gRH[:+Cf)WfP38
NGCBU:7fO[D5g87dA7>e,]dRX=;)I]T&9=4+..[7L<=6?8\?S\@,EH4f4K-gO0.:
?FDfV)b^)32IZW^aBZ4cA(Ud412b0LC-A\A.GT\f_KZO[X<&RcAZ8Q&.IGADJJK+
fIbQ2,SU7Mc)f3,9<gM?R:JT#gCUWL5YY7N.@RI8#U^=^XH3a:D^F=2-3DGF;97<
1>>c?EJ^C1>6a@D&gcY#IaSgR(:BY+]#&TX(gAZRObRUB.H1<H^GPK^G8DE,BeC^
\&aZ_7U5:dP/\?F+=a/7d&X)5L&^dBRZZW5X90XIKHP:AHW0KUR<2PbMHc5.Ca26
HeR]>OXD\f:@KCZWI22[?P>[APPE\R]]U+AgMLAAS6<V10_A<HD6TZ+6;/QVF036
4f/2,;Qf]#6_SE7#CGCeNKP<&DB[^TOWde?f5NF_Ib^&HX5?@FLH.Qa,^B3#0gJ\
8U4/HacDJ=;G/\Q@.WP^ME76.eN/3_0cbJ:=J\;RDAC\KL2e0C;bP:ZGPI[O&aJN
]1a5aJ-;T8@1XD2X177ZcN+)d+/PIW0TGG0g=d98Q4ZMKGNH.N#U22E,H=D,Y/MH
N5WCB=Q:TC/c\;<?aKdY9d[>g;A4C4PE>V5#eZN:UbU@Q_JJXLU6Q<8XS^I6=;>S
-O_c-6;G4[;(,-CQ1(B.?;J1Y#@\1?MgfM,8H[RVV4e4M=^D#1I/]++RI6YZU6>#
.>IgXEgL1ER5H;@\^c/7K2W4gL//PG/0P(Nf2\cGYLN),\D&5E(0#B_c2/GXcN#E
6aaTF[&0+:E#IRXD>OV+?Z;_E8+&OGg3:/A=#GP+4>b^)^TKLeb9N9,N>(CU,c1Q
fK=f3\49b[3bJd,<0RLMI59:YfSDT5:<#:PEHM7-NNJ>M:+K6XK,c3cQ<C&O)SF]
(C--66P#\R5#M=MPVA-S_@.6)A_C9>.E^PF1LF9aFa78W[],d4Ag?35[Uf:;,<)1
,M=TPJbH+[GDJ8.6&LSJB&2I2PIYI?0e[Y#7d/+E\=fMeHf@8MQMQ.BOeGEG)=&)
WfXUD;Vf&1P1OH8]8DI-IS#CS,d7>?CX#>@6&G7M5=(Ne)UJRZgEA0<5V3d?.g.I
+2A[N_cgSZK8W1KQ]X07;>AA3FY,Sg<7OA^C5KNIbc#VV/0-D=DPXE[_Z4L:/GeU
UDDS(;3(c&SR))K@_N5&TXGa8cb@YHH0aN,4,M#eC?dS93RZW=25_)c+(MD0e&36
bPBCb<TKJ0;MHIG0.YIAER_N+UHcN4N4SJ]B>\#PB&2G,WcM:/]aV^X?ICH6^ca#
c+Z;^+V:>HGX--dA_L/f+IZUOIY4@FdN5Z#/&g>__JFRQZf6a5TY+.3_S))NAS[Q
,J&O--D:MBH#ZQ-AXB=<[F5b]S/UBF=@d^HA+V>VP9MBP[a/;c,[XfF1SM(^5JD<
C0A#(>cK_7X&C8MIBFBM^,]gO:/L-JeXAeSY9>0#HODDdD(:/.C_[\(^/.@RgCIF
<B<8<cMF?61=IC0Gb9>OUZa:-QE3T0AQ(-J.1Q_^O(<ZBbXfZA@J71dP>Q0?/LVY
\>[E1M\6I?WHM03D;X=Y/XOZ1YD6)MDSe7e-/>=GgTVUe+CPZW+K#GJZH^CW2K:;
cIf0Z#+S(8eGB[:TF]gKZ.M)7=&6>>SY?>=AV4\UQaCS\.AP;BMWEI6][YK&7=EZ
3]-gFTY:._WX&1)S9+PX#_T1DBgJQ+_US_^JEC>R1F3-0V755A5E^X98&:93H09&
W]3g0#C=F2@/=H&F@V5b#ZRg+bX(WXLO5H,&2K1JXB5G^@X]?^507;^>Q_J[JbUR
K-cF?M61OT&g^Dfc#/&CHTJ)N0M=UC]X4IB,&SE5[>T&O0A7:A?74S_g23/-<>D2
FP8a[NBaU+FI3+4&O<NNCAFfGAgO[W4[c/<>,U_0^X+g&EL?JdgJ2f[4MJVg>@SN
3=_V#7GX;.5+91+YY@RH_[3?7V/f_IG6XRNNed6XE[H)TT[B[6<XI2f:G\2Y+JK[
7fd.)(.VS0:3DbZ=2IW+\(@^I9(99,8A@=Qe[gX^ggXSb4agVZS,<,83,JXPNDCB
E_9PD&Q.F>#gEY^U8D&0,\#UZb;:PbMP?cMB.#)&>>GbT58\eA;d9?BX5b.V1?:^
YaU&3J3YL3;,@W5V)3I_F=E;\DX:Y/c,/(bKK]([9NNJU,d.28N/XA2[&O2&^9Ye
d7e31?2.:27<)dG\g-^aW@UZMX]BM)A1;db54dU6E-@ZRVG:@A9b2@-8]a9D1Q:F
CM[F6\(K-<0N?7..U1a[J<]HBD0ADO>N=VTDJ)QH,WL7I:?_\C__eVeN;5ML_ZI+
9C-FTY#_IM/WX-cK:F,B6aKQ#(THBc7bY99)ePNBa:0F>:,OgB&@\fMZV0SM@O=:
\L7U?N>b<-R,1N5B]@P^S^7G++I3UM&51OF4f&b6;RV:Y##EUWX\^3aV^fGFO9TU
-9(2NF.Q4,_f-d1)+R?;Vg6^aY7^391Pg71RE_cbFHa@/Oaa-[6]-<d^1T78cF.^
bZO]ff:V=80:9]>>:V:OTKP_+5<NS=@951WJb#YNY2WKW<C[QF[O0<+P+8_0\-8U
FB#,T5TYJ,E^D,Z8#@g5WI/+[(e=(5O/S=,cg^4X8da0,dIT.G?@;+D14DW2QG,A
,S>S9NZSeNgFa,2(O4&_RF<>90cY42O.>fFK5P-ecBG7#=9(\8JF.DTgc5GAVUX#
B7H(/KMSW2SKI]B:G\a9Y9d]<,#0_8@UF7K><?ZL<T>ffF4[7bBO[T?2+?0\8HXM
V^KUM;)8eL/E=J=X8AeF#3BVG)=A&RMY8J??d^8&CdH#g9]dNFK>5#@G5K3FfOW#
R,@:#AFDD8D=U>7LE+\eJScF9+U/9HMJU;dVEa;R736KY+A&9e+RaR&ce7M<1V@)
Y0GP)KTQ(RVXMJW-)Vf33DO+UeX>):4WTQ#b[9Gc4/)3=:W:.OTW2+9B+fBY/8)]
.>/R-bZ[_HH3E;#O=b_gT+KA\>@2379M1a=1XB&B&dd0g[f37C\+T@S7/DD&S#N/
;OBWgFd)?&X+f1EDXSQ]F34D_bW_IDYb]5A^__T1fagCTSTVX&9KFG442\HU-D:5
U;&3P?G\(]1HT8\-J3?&J)[5N-?fJ+7&g-SP4E<N?MIQQ@P&-+COV(FS:e?#2>1.
<e_dFG?UX?)=>O(30]3BdcV?\Xd4d40JgYf)&-#MZTE6YKEU<I?-UR7UVf3K-22P
.c+6&B<fg-Z(d>R0N5d?b:VdE3NXb0.T&/a>>4GXGRa\CVgRD^S==W6K)Z/WPe.:
SP@N#AeG+;#^L1#;<56>>7-^#d@O^S\?b@1@V,SS(4,S;7YeVYFA\af]f=9g.K);
\G[1C==&0JJ@PJcf/F[8UPH&c//7AY0W4UTaGCggRZ(M^eN(@NMd2N>(e<F[&#OL
5KHdIJ;W^KQLf+#^.Q?CF?U&[bY6a&LX<D2_N]g,d9#JZfOO7G^&).@I4;W=/gC7
Ua.LQ[JR9-WU#?.7A&QJ1:Nb<LbAT4,H(g#@P,T&d+?V9=A]G__(+2.Ue:&573HB
:UJGA,&AW6]+N_E8+JBc_PP7#IVR0;<&5>M1&dG,CRC-X@XLX=_\b2b0<[1<<QE=
C2]S]:<HZaEb<FY.g2c<WGPZM1:7)=C3UU[2d2KZ^;.P(7LY(Q#8FD?e7fZ52J@&
@efMD^ENY0,gFL6V.dTU8J]&aV9Z.DGHFQ0,??YV)@Nee]?3-c;bBP8H:2]_A7T=
2-7Yc_a4P9=/-X0QbSPS:G/[?QGR]U??)K0F1H7E?[Se:19]R3g48-UdRLa:<B[c
A_W=>,1OCZ(XBZMAd,WH>OZI37@C]?Q\gNHa/=I@FZAD,:6QPBCLGZ5>/L_WgZ_/
@_EZ,-UH:BGcU(E^<+=PYb0J=VV)=:ESLT0Y_&f?S#cLUb2cb26F\H-S^-Q.D_Sg
b05TX(ILWLZ.&G<+GR&d&Kb16XX?A;UY980?U\DDBffAE_9;eU]N28\\FP50E[SJ
R_G3:QXfAUdOV)I@Y:-7JJg-5+-KNV\CMD(Z=BY>MO[F]2[G0fJ2LYWQKPZ18H18
44-FB0@KUE<3YbG][7ZVI1(cg6UE5Wg.AZ-IH;;@#W.W=Z3=54^RNTY]9S3<aA0J
c8Q,BB,0DS/0gF@>R+,,US20NdK7S;PH]_Gaf?/Hc&HOf1;WSOQeT;NMe2R60=6&
f(_FCEM_A1B9F3(fYH>1@H=>U6XD:(8.[8Dd-gP1Q:/=;<Kc&A9\V;]E185S#:G2
+McW^XC^Ze+WPRX:>Lg_C#be6=QRK,b0==\RV-E7YLgO:.a,<f0EI\63eT4;+B_P
UeXe4J[bbIQXRgRb:c4\ZCJ7)H0NI1A8VeA^20^ZJ7Wc3EY8_E8]P-Z>CdfR2IKY
<cK8BK-VRN#5([HBCOaR^C,;Q;4;G80>0Gf:LA7U,IEHBA5NRUSD;.1H5d4H:[4H
#S-(b=ZB@IU>YX#0YFIbQKH@M]bT/\MR_:,4gOR[)fE1^H:8HBQKbD2>_@^,+-cY
AJJfRT)0S:2EA5VWSbKK4T;B-EDSI=^1dL807aPc34ZCBBQ;]8NLDY99J:]6@XL+
MKS9._38C1<F6)\Qe1:A6-]b#:0T)(;3@D@<,5?f:(;5g22FZg/Z-59ZM7+D\I4#
.W=>S=G7bUD3M(PfC@16F@A(50-2AYOCX>SdGaT-:A+3R?CI,c(W+-DQ8FUV.[J8
NKE#gS^B@92#9B>RDeCg:<Z:M<JXd_cY]9P>N;80N\WC+1X:5]O;.E^4?O65V.XY
0W+V+#]QE;.-7CA\_NTcf9^b>e#O?OO3FGd]A_0T?(e>IB?\2e\<SFdWH8.7[F_5
T-TNQgWT-Ma/ALUQPF(N8(U&L@/c7R4M)&5;[6/FI&+;ZUZ&WHHR@fUWd7X\@7c9
^c.B)0CPeeURdFV2fN1fQM0;]ecgeM>/\,R/BUAZa,If1X]07GJ]g9EDJaB?DW[5
5M<RFT&6AOLPU=bW2@d.V/><&L[0FM0Y&WQ:-/f&_^BHH/0H:/QX7T]C6.A\/63.
U9YT8M@fAbR:&@U#/322U:FC)>IN&29L,1JALM0BC&Xf-gPZW.feWY+4J+_Wb]>]
>aV8[Mg_=&8JQNKN-?)O7O]6a_VRKe7[28.,.7e7cV?gPBb/(/^PeE<:gc#d(VQ,
fa9a/UXY=fJ-4fCV>>=J_+:0RJ[?HY82[F4FT[&[4\3e8.TKEAMMKZSB.0ZQ2c9:
\?.2X5P)2@TX0aW\_0aV8fO<RZ>H&F8LVLYC#)/E19(<?R#:2><W3;CM6M;+MWM,
R0J.3[Gf=DS4PbaJN.G8^O)W[0>YRQ];<^.S4<GL,BFAAPF[D<LbF&7T6D2]^<F2
4,<Z5bNL5b^Q_Q_;66JHA:@Me[cQD471LJX))0=\[SW#1^L^8M&R]F##G</F;L:O
H?2dAM@_edGE(G373T>38A66XE^b.d^&@JGX929W0d@5WaR8L)^-e;7)\Y-,LJ(C
&5AMMB/I:VFO166&@N@&S_G-g<QA#H);fgY2Gdg8@&BCb^\D96N>K^2N08MX[.(J
I3V]a7XeAUQ[^0H\^cE5b)B1R5d7E?eRUggL)e2SSS/+AIMgaX7(bJTPeggR&d/L
Q;BV7(,VWbSeeZ)GL8X8aS>R;T]Q@QKFRBLWC1+PKM/</;>X++^2@IdZ:EVSaUI1
Uf7F63A-7WKT\/CN.4XGT)QOAXMb:IHcZ\?[1Se+3F>=@VaLGZeb,/#RC,^6dgAE
1\If)@G2:R+V#<HD;L^Wg=Ka4dL[C?-?eKFJ4+I1f#=cQd8NK<ec&)]^@0RcP)0;
6&X&O;eO.b[38Ef[7>QN@QBb+2V&)V;NS)5KSZC3UaLe7c;=MF_.F)D1]:.BH2^9
WgMN]O[G]QY8/2e+KP)fWL3B&=26+DL14\@/PK1G\#-&G9ce7B2#V^.9\RL0)(gC
7CbGEc6>4E11.9b31GbB3f6O^6eR;0,(]<.bL(E,2fUG4a8\5UV5[WY\]N\:YcKJ
_4/14Q3S08^@4T/F=&.8fO>#g[7OVU]f^G-MfZ&?e6N4B2V]5XWf19N3.)Ig)L7g
6+J;,O2A)5<f..W<D\:Ga1B>@_/Pb\T5^0Cag5bJeI<H39bZ9O]@gWZGL185;Q4H
@3J+J8+D-93I2BXF3Y]M@Z8.]2L0eY5?/.L>,6?.J^H?TU?)Nbd?[@K#(4IWG1S.
6(TMdH4HE-K&W0Ig4PcbP/]WDTZD/HQYcAY55,4^.(855S6LVIIU@5KPd9TJ^f--
:WIaTYeQ\XaOB_8OPK.^>@(MR-5>gA>G,YWe&;QJ(?13K[Fg>8++IK8II6&;]1cD
(0NR?dZg(YHU\W_4+00;0e368a_aDEDU,:+@G\\\@8GTY)aU[E5.#.8V?&QO\A;_
&MU8H&>J:N>L17JE_@?+T;1F,S5B3c\BV;R#LV8ZL_DOC7NMRb^I[?ZUcI(Ab]b6
DL@;,&^Ed<Sc5-Q0f,X/OW\QB8D^<.:#;:DMW\_8J_<?TINJSZX&RQ^15;T9?[>,
^/)f=,:N6,YKGB;3CE>IKC1_RJSVE/;[1>)[L<SIKMNN<U/V?[(3Ug78(TO2CB(7
L89BeJ==.4/LNI7^5bM(;1POBK/)>HRRF\]L.,b,TEcb9_6eM+fP@7ZF0H8aO\0=
\J,5&64<MQ)Za^8e;/BA?=L]Y.6g=+=?[&VgGe@Qf6EFU3FJe/QUEe:I:W(d8U.@
\??8]e\P3d>RAU3H5L-2]\b>YJC^=>_CP</E^0Q;K+C;UMeF]+],R0)PF>JK:8E1
_Ye2#\Ta6+LITL@0MVOZd@^5AAH^PT9</)g=BP[dRSRgK^\aX=<?DQAOI#@SVA[R
K>-fF4O\)7Z;=GRaUWU9dgE[Y;d\/+O1g>3]JeLX,Y6G2bK#?Z):PM.?^[S<dH]9
L;3\f^VcNAJXMES;F,&(LM>U_PNSGDg?C(^OR)eb),#(.+1.gS0N^&bZG0K1ZdX2
cK<)3^;D]g]V/F/aS)G2-2X\J^SM2SCSIN;,fd?f&QC4&gJ/2E=QTI+g:e/E9Z<M
UZbPgXU+/4U&Hf/68)XdJ/-DS5&6Nc36<W,22,a/a1(])7U[\.9YBaZEPRdf:2]V
7]IG;e[2#Y_W_NXc9L[LESaAWPQ9>T:#[Y=Oa[=O+=#DZUJ@eZcU+\.9V<DQ>H0f
6BIf]\)5A6TVKZFTV4\H,Z@H2(F_@Bf7XH\A/Y0fAA)+APLP)>##@_C3BOB/-I)Q
W^)S[7bb?2PEA/N]deeg2dEYaD\8N4XA5?HO9B7VSM9[d)G0.RKfB09[<^[MB_gX
][gH;YGJMZFd2_gC@1>=H[^UGV)42NTUFXC+EMa0Q4HIfV6;FR@9(&/_W:(B)BB#
]1<]UPP[D(<d=SPU5HG,]LO[SSUBb6M5[UJ4&S]T_A.G.\:KbAcBf(>5(S>&XeSH
H,.b\IHN35A2dcGAUQdQg@:^:b(QQ.[b2f#TJR+=9USR^.)EXD;H&b&GQ5ROC&ON
M<A,BZ=;4A=,/bDVV9eHNEeKEb[;Z)8Sg)LU5JFd40P50T9aTNUZ+eWgLJ(5)#,V
#Vd(:87H+E13QaS-=:[JTI&OPOdB0K+-Q2183e5d@RC4e8V?bJ<IY=BQPK(EF9\2
ZLHb00=g#AcAfQPC(fAQdJ;g7Y&3G#ZbL(<E^=e&XBcKW>>G;DQdBB\3R4C@NUR:
;1/>1G8=58eAF8XQ>-N3g<<OV3,6e?(0Je^W9XK3(4Y/UE(OO;MKO@Kg&SE.RW&S
\OZV\13:.]U0=c(A-e&I(D2e1DGZ[O<)c2UOc.QKHZ:W+<8&K,dJIaE.3XG2\LZb
JcYINd_Td68(T2Gb>(=7\SDE](/+RPK#]1?@^<K:62-)K=WNFG@>67M)W=Z;4+R3
M\NY_;=^R1<.d5L(c/@(_W:;8FQg_e>Z;ZM?eXH267\ZaNK-<B.8?]29NBc(])>#
Z71^^SL<e8KWI=YVR<F68S[W=]AL;K;D0<7-0>?9=8SRBI70eX7-Y_VU(D#(ZGBW
Mf=?YU0C9g310RTH\3>5N_g0_ORB()T;-0WFc7AbaGNZS^Y\DKM6D))5QXZ@-7J9
BC0Jb:ZW#_DN,,<-WH;Uceg)631a/L?Y,dBPe/1+;@4^:2_cbCNPMd-.4aH]ef3,
#C^^?fHKc84JK-9GDUG@LK+H??c-;7AWNPH&Q)PS/5@JKCZ&FRXQ)FP+P^?DAPBH
TAcO1,#.3NKH(eRBZgf,)M@bOO>N.1<J8K>a5NO<Z;4K(.3Id+db9P,3WT#C\+MP
fH4JLJ>I^#?DFNJ2V3?)J5^S]eFCPBKFS-KC:CR7ZbdeJD</LVA9E;#CGJS,\].X
,KWYdNc)@10.COO4eE2;-/?8-2b<D37U@[K66EFaKAfeA2P3V][NIF:\07&,CED1
.<_EFRde0OdUR;G]/:;=:eAbY[XG6Scb)B&1CUST-6>a<X0YCOOND/KOVL0F/4:D
W11T02RbGST:J>CR9#-0H_B[I(?L+=QR)EG..CcW8SCcUcD_<.f_H71ab)/8]c[9
8&H]K3GUDC/JE4Ua&e<VVY^S#\<7O@:;f91c8b9Q<..T4g[A-Vd;b</AT+8_fdS4
C19HJJ+P2#,0G2Y(@,a7X3NF,FVE9)=)K125GKfC0bc(0B)/6V8(7fb057dgIR;d
-fOE.0ZgWX6^Eg>4RY3\<:f34J1FgEMY^A2U7GHCF-R53D3<V/0Z&HC?F3aD+2B<
0MG?bQ8/[0=3e=#]B).R+,(ZBLED&,f/?M\5&315T(A/SJ3S4)1aa&fUGV28]34(
BIWZ&L])P+#2Lg[K[A?b(]W?]GQ)e:d9A4#PG=1>cR^IH0QPTU>()Y5d<#=WGfZ3
5]-\fWe+\L0:6([](\,LfR4TD,<.1)V=9::K6.d06:W^b<:?c8V6WO1BcC:Ya764
VBCbf[fNYc#Yd>.+YD5aH2-R8Y7>JEB(&CFRaM&W7^:LJQC08^Z:CQ-KXWbMVO8#
FV/Y)-L)XC-U62:c8J[X3N1Ya=+JW]F3T0@0DPcFf)EO)>Sa9O5-\342g;GeL^Y.
NIP[5H&37M(SC<\4d7//#/IDN8YF(gbX2;^\Q(aCI_.]@?&71d#dP&4FaB#PH=_[
Q_X(EM()T#DO+@HMA9W4V-^eC.E>9QV/+EKZVJ@-PR)D9,3L#N>TK6.b\1\A1]7H
BK^^Ee<J(W:H4P0d-38,([41&2F3<FQ<HQe,6:\dIOM5F0A5,H8S[P\?cAIO1eOf
5H/&#)X>)6((@W&1B7OOY:X,c\3..gUd,2-F8.]D<M.J84PGfFDDK((Kf>YZ:)e4
^6dD\=B6=/]FB,U3VS+8SSE-M>aW)S3Td@W)UU>XX<E&>c;Pb1-Z5JGQQCd51])B
/(HBIC^fJ,UIPAPM_V=D^;bBIMgYY29YU;-TJ-O#P@I3T2:QEf&GCM.69_(6c^&H
OGA^fS,SVd(-=dWCfG0.7HGCa2PV&\?g#YE]_:,-5P;?@ZO8U1W,C\VDPRPV,dAN
6B1)c<bMF+:1a]&f7PV8;NUS>>:WS>b^ZW);<?[4\WTCXEO,:F1X?IE0e-5f>1<b
gFbG>VY<L4R3P)63WdF9X:Y31gJgD+I5S_G==L1-+KEOU-[0cI3]E1)EF<8L>6/(
(XFKQS9?&XDNQE4>B+RM7P(O(]C95PTP7-U@/^;SR6c5>?2cCL;P17R8d8=>+)E:
1BIbU?P9F[P1GB0[EO(D9MRQ-VXc9A-S,7D6Da:Rf6]5_;_RK):ETP\5P]QQKJ+X
T+Y,H_7TERNT>836R#^Wab^)<CK?1#+f[;+.B6TF=;a>Q0Za(6a^/;5>XOacec=Y
2DfZZS/T;157d]f4AB5&e5FaB#NJ[QM19d?R8dE:YS[G/Ag,)V2;,JNaF;VR:[WK
,M>::Z?&Aa+?9YVRe]?=A7-9RZ)MNR;72d5_\bU=91_:^0Z,SdK8cP)OeHTc9++)
UeXUdZ(G,J2CQd1]NHN))^7A]6c3(MfbP;GF[bC@3,6/P<5EB<:-C-cP1d1G0eWB
FX/^GHWeMOR09-9^g/F?IMUfE(5RE>(><V;?JOY=ZA2H2d@/FW\^=OXOHUY)YE<I
P4(@H(&:,KRSe5Z@P5G@HU]+5YC0M4/)@,U)d6Y8#MJ[N#MEN,THM=\#P3=2XUSN
R118agB,d+XYB,b5\f4FWAge0)RV3=#;ZQG^@<bc2Z7Q6]H/Y(eE6ZQ=S,C2?PO-
?8WUC&/#(I_4N-P^QFO=8EO\g-A#5?+HLBNLA/SW\cU+60M+?[K[F.^CLR80HWBX
,c#;YNAWZ)PUPS],[D,D.aUf;C\52/O[.O6W4VJW2-8Y5M9VEE9:f])6KGNXNY.,
0P\-JZ(fgNNSSMZf0c?db/Bd5\<0-QEL(gQ@^0dH,A&@a@:2&fW<JR)ZGJKR2Eg?
bZd0[X2H96DPKOBR;FQ@eYWHc-^UCYa&+S:>,G;gAM5aCK92P5PJ@/@ZaE1I;\HH
a=_R+82#17.bVdX1X@4]#5BQ\P+,df>7V21(41FK1KeE/GYLbEJ_@6KGC0RFLLWJ
0@&EKPE&.]YY;FNL/4b8[SE&fcRXRgLXF0S42<CD6KJW7aJD>7R/E44Z<0^;fOVG
a)S-JWR(])SG(P,-aD62@OS?8cL5AIYARJ:>:]U_=#0T-^;9P##TIfU9&[b-=20B
.9-62e/:OU(#+.&=B_&R)e.g:L__#K=26?ZZc347(f[XVCYDc<M(gL&c&N,9&76I
-ee9--X84KdD])W6CDT+[9KA6HOR2Y(F=G6&bZ7GOQ#(+T08Q1(A-+eN07L3J<DO
4A9J/2J1HEXbdT5A/@U)=E5+aM362Uf75ODUXN9+gYQ<f&YF#T:(eG&[E0T&b^R.
?7:C54\+5e1#XUHcUb.#^e>TBQWX_O=>@W-_;I19#bK@ED[(OgQ]AX(_=>D[<WHa
Gc<^L+G.:,2-=8TYWa;Pe7)Y\KIX2GREQX0896IZF<:Z-J:-_a-L6dcFO64#>-X@
5?::^ZK+(d,7.?JA0[E]7[@)SJQ1];YYI^;2P;)65_ebX6)bb4/FN=/#O0)7-/PO
B1c__1CI>c.##FJ4&)NX+D9bHI&.d)X4]a)/F]O1gRL+ZF,(Ua]R>RY1#2R<+KT]
-]Q3Y;8(0&g0_EKXcW<QH?#R[);Mc]3/[RORLSO;SHC/dGX32);&AM0f61cDVM2O
d?NIDaNbD9.Fd29_aFB3U:9IB(9SgNa^dMde;2=gC\C39D=+8ZJX5=2Q2e=X7d2O
B>4/gJQbA(geJ7QX>G#?6\L)gb/8EBZ3DDb[CEg42Z+FCDDN8[TUBOf8.Z^TKbMP
\#>Ge,N\>P&0.>dgV&/Kd(d9[d.S&e9T\Z\bJ)BaM:VMCPfd1JTLFf8.b^D6U-Ug
).+43Lg7abO/ZFD/CO>WZ^\)0=51L(>8RD9AfQdbU^Lc#NE#\1V]1\40;G2cK1aP
OGH.Ua9,L5-bM(I0QX>7ZDCVFf)7Va,a(REb-\;Y#3d3P),(B3TQ[0]F#1#Fa9f8
#/(4SH)cE]XFZ[ZRaSb46XEMOX=a-dK>,0Q#X>EG>(97&g;=83Vc90M^;65E(I&(
<##NVJYcPLM]GK3->SL?#\>Yc3XVgcTB+46HF#P;S_D.E@XW]FE5V6^Ae>4B_fJL
R[F/e&CW2DC\a4SFVT+Zc7Kg5>BY48YUQ:T#==ZRC#e<c736f9?\T/(\44e3)W0;
H7d,B<XG4eEDb=@ZbPP/]ZUCF.N4=L,DL@c3#_6PPL-Yf;a(SZQR4gMN7_URKY?H
DC+#I1_),<ZcBCJ0,\-c-:5-3R/?>Y]S[^PM2YTJ3FR(ULUC?488QF^b)>0<K&L^
U<:GdOY\>@^QNdF/_+05E#8;,IXAO^&0(]#M8dTdK4[ZABTP-RMaeS5)O72OTY<:
1-VQGUe^RC8)BRa=5L?[<4Fg\B3HLa&Ac\,SB[BYA6?B2;;a@d-ffYKR>J4gQODY
&UM[LafD/;ZPgfOY6.#@gB_a:aVGcCDW?eBM/];d+<ZXc[A)YXV4TO86I(+6>]^<
XIU1^[HA/9(]0UaSES,V??+DeW3QfR=:4>20HW[/APUAG2TX>4A8W2IQKM1QIAb-
<O_J&b,+;PZb>=2ASQ/=:8?[7Rc63G^7U.Q><Zf0C9<CFVM9&P26X:F]aPRKB83T
]]2gPK[(;CAd-ag3-G)#.6PedLHH<<PWeW]NKf2BO&AY0]QDD.>+,Y-+</Oa8#PV
:AWJPF&[55f73]JBNfe-WKJ/GaIGc_Y<^4&aQY3?\9MV5QeO)WVB937@MHJIaET)
F8VS:P;Hb6=NBDa8,&;+&\PR9\,ff2?Q7;fZDUPce6M#PJ+Y9H5#>eBEDBYQO7P&
BBc&R(aZ?1NKQU(^+YIOQSXe3<ASaWHbWTOGL/@SfGB5A\IIUD1HfXGMROY7EP(2
ZfC3\XG#BDe</Q/G=I\];XYd+f1,N];RGOTf3g(=[^7L/>L-B_fAZ0_FY)Q=4\df
R71OEJ][MJETFH>9TVG.K>#,N;ECK]4@@GURHRP[+5<;.(XDCHLUCNFeQZXU-EQb
Cfd[gSHU,^+KWbR[d75K+H/dEACbd2F4S@B&bQ95@_\4_VLMWIfcX<eCS-HRTeG+
BWN[BcGM>FR>(;^>bQQf,PPc,a@Z):W>BBOFUT3L#X(f-D7HTFJVI8J@,4_D?+HU
(==eHeb^Ac.4>a1edU_DM<L=\4YG+aNZ=H[DG/[;DOH)VYYBI[B&I<dC[W3]QKV0
0/-4_E<)4fO_VbR.6dQGe=D@G376\GCOI[Y1.-T5/Pb76&AC\^ed:>T)+e2()F2e
^43?AA0RKT8L_AOT2-c&TbQ;3;;gG01)OMc/?&@35V]Cf?UfQ6+SJ-(.5a[<]\L^
Pa^M3LOY^g9)cW/PB,OV\Cb\?)\QFF_+gX#@L[KL0Z&3QcD(g:LbGB];RO;RX4U#
C>J4K:L6#aYV,+K;J;/DecN0_OEIOM,+YY-N)-S@gFX#4d0?cH-/?CcBZDZX#\A@
AGKB^#]Z[X<,9W\X,D-&Q[\O2Q#,A+1d?M2YO0DX]FV+HY7c@9ZDZ9XFeVLJ903I
C<V#MG<&6Q0,I<U9N]QA&S@f2_L:.7b7U36+MP^N=\\R9V2M5dZMJ:61<DJ0R]YM
Eb-R6?.<+(VFf&3#A5[a[2((MSBU)-9)b#aRDD6NM_G&gW\>[;dHJAA3P](>KZH>
V1A#a^V)&_Z9UY-c>L4@)3UHDN6VESF3[f<E;/e3[GSQZdYW\aB[NV;.L4@G>)=N
#A0[HQ/TL70<A#OT.\fKb(bF3gP8J,]c;/IAL#^0Q5Z@R,6,HVM),eR76g&N56,=
?LQK,TJBKg]P<?J)5cH\+_J40?_dK2U[XS:372J+c;XLJ_eD3\PUg1^Fd.Q:1K-g
&TgM1A>QJQ_fCCg.Qa3>3I:U9P#aaDZ47M+1U\6+9@(4-;c;,<AP>]D<>\2Y8,,b
)\62=JSM))A5L5-.)cecf/>?TdVYE,^6>9?\&&#Lc_NPC6?+<7RM\10_U8aI>_IV
#])\?JbQ2)O:3F3:?H0cV<W3F><=NBZUX9eBO(a?g\VE_((55C.ME83Z_Ud.<H)\
./)4=Cb??-fKXVcM)BV]gE+)PT?:[a[L[NWQ,#&[I)dPgQgMC6&.DYFaYGUSE+ST
A][QQ<41?^5a4\56TK5YS4Fb4R6[f^d@9N0FF\(Bg7a>X#2+-VY42ILND9[:_#Bf
[^1K=UFHE;TA@;@ND<7W4YDYe\#-5Z+/c;H,2eX1Y#@c=1CHgISfY\Wa\.Ma#;)]
25V=G3<6F?ML+\_7I([=Ke)XHK=/c7QdL7XV5LJGa>7Oc-C,GDH<YA1<NRE=MRg6
Cf[H8BMY+=N?LB<,;,<M(cGW8(C:AceBA+IBX@M1N87:L87P0QRNOB2A24^AbJ(S
]3#T(8QFcUOU5JBfdSc>c39TaNA[eO]D;[a-1T:1^@22]2<Ka6L6LN0XeSK,g8I)
>E<f[Z@Z\X@7DA92?@WJNBQX</)d?.^R_cJ^bC\5&:aQ]?\&/@2MIF&N,&:);344
-TF\P)S@KcG5^+##gKA@:FG[C+KXc7/Q<?SG2J+.d2)[EF#9K5AA?,M+A,]Tb-C;
=5(6((1\4VI,/ARZ9ULG+]Ac#5/DA])(R+:5V3;LX.dBQ@;>AJ0<:X98MS^U)Q=C
4G4GI&_=3;Ygf]d[E_&_d?AB8@b.^?.,@H;H0]8.6_N##6C:XUI:\&8DHJPKZ53)
++M#Q;BB=-:JT?d6Xa&??-BDS&>PMTJ[?dCB@)+=Z14]QUF.A5,::c#af&UP^FTK
=26g1-aA5]>UZd2WZ\g51OX7bU^H+2Ya6AZ0B<=:\FDdXFB>;3P:EV@LR:##ZVF2
&;_e_e1D^A2#.UB#S<c@Q?Kg0J([Q</NfM5O4GPLL<?XC[#N.\AX_.-B,IAVE[;#
/P?7?H)Z[.^bH/VDFHbOcZ68M9<=<3\.=[I<N(A;eLLNZLM]8d+4.0JNVX06JUH,
eYL&V9V.eCT11:bO>5_N]U2TWZfNBD_JR4S/_6:G&e+_g[@JcZKb,]HO-VSLe]KU
DaARWU(4VO=Keb,JOc_EgIGANPLXU&b&2ODg.[B^>5g6K9J)5>R=&K\1fRWD<IHU
RAB]Y^#QQ]#Pf6D_J,e+PI.1@0W:T^eFK/@]a90,ZEA(JE+[0KI[\J]A0Q:.3.7O
5<9CLWa6L-,<-):([c;FHgI;LT_IA<BM)M1C8]=IXOIeU@gKBYM@47EbD^#L[//?
[U&K=#51O,_V^C0Q(Z22>WNIF?9=>e>4F6DZMJcX8@JBGM7((TNP\OPBOINORB^Y
:CQ:2S;)K]>3;-YT/7>ZD^-VJc45QC4+U^@_&Q1@e43W3_fMC6Uc=a(8K&IZAf=7
/.V[#77PSe1</0[1=,JO\KV>G]X:]M)Oc_E7=R7ZeM2A&1U]8eMPH1((ASTO325A
7:#&[R@G)]?EQ@MZN]AO@:aCTKV9V)dUPJ-CM;L5\M-;D#-^bJS5S=Q@L&@PY,0M
RH:R3_fWVd@K+J6R7)>G8B<&K]^&KCZY8IF0cKgZN\EB<J[gMU&1e7J#a-RFMH5b
bC>(ZK=?8_-U;A7.,<a8N=J<5J4B()?>Nd])31c6B:TDN,.GbK(L&c6P,HCfcJ[0
#dcL@Oe/eCZY4#//BKX>;E,cddfEO]L:Tf8a@=9STPXgO;(#\@@Y,#4f-@e/^ST@
aHe9Md>B22g,7cX&5K8)eQgb@Q24:(:<30aV@[PT4@;[QTaJbd+ZP)P@1#K-2KF<
#c:=^;H72(CdNN+YUKgc7I?#DRb+bC6[Ba;@]/A3SAY?E,[0E?^S9:<FSN+-A)bH
J:;e/=WWI#JbA8EYYA5@P>@M6F07eYJ,:&]ZBW+d>IOgb\=LbdbaE2@#P#?/48O=
IG_W0P?MH2eCg)B6P9/L/-fE8ED4HF?QeUWJ4^;?dHY89DISTJ2KQQF5?CUUbfH^
ff#M]eRA#VaDN:-&[U46ML#HK_A:&K@6dB8gKM#\3cFG>bX8<VJ+fDE6R.3b+@9N
^N_V=aUW0(\\;>[?E98LUXBH-8N[aX=-fWV^CK>>e0GbUUIg;\Z3.f94Z6]OB#c=
8Xd?>/fW^NH+NDeXGaMLC-5/1X=C74=\D.W&aKDR@S0O8b9E^9N?6)6GX2V(S+L2
GfTQdO-I[6+(gEP\6\3Wb0:Tb9JNEa+86I9,A9I-&Z_f([(D>&Kc:^R[\Dg5?2B_
,;16&0X=-T,-:A?>b3QS]cIW>:I&7=6@X8c@&e+FGQ&\7<6>+\#+G:77bXfa=aEG
M=)??WO6Z?d?Ue,DaQe083S8Y9VH?ZARXI-:]b#10,8K;;2FF2[_B2SQ=N<.@FdO
ER2UKZ_ZAg0D:GMD<SCZc[?@X;-Y-RU?5+@66)9MG/P:)d0U(F?N)R9AT];,2()O
_-HG(T=:SSGP\_>]0K)XN-((ED+;Qge8UYe_6-7A9]cH-9(c5,LILT(7;7D+NFGU
LI-A_-T.KL8O[.I(VKQ;==+>aDYAS.3a9._F:5+_EJC.+QJf4ZZeQ2K0IJJ/TI(;
@4_:V#VfL;_;ME9,e_C7J#J2UCB;f0e].afW,#7V=UY;_R1>A1/_NBWI(IEJ(@<;
E2=40=S(2V6bVRDeOXXc2AJUIeJ)ZX0\TP4a79261V<.\ST^HDcA:M@)EK;OV]+N
d1Vdgd@UNfE)7V#<SH/H/--T^.P@eD(0fSbRf/G18K;g/9Kc]86]-.cd>^U,21<#
]RcJ6I]W9LFUILCUM3[g64gS_],M/DT.J1fB1B\M4gT:5W)fa:CGa19-11g-+7^+
:/&?.2A,K5],+BF>8eQV,e,2TafXgN7Ab_FBI#LQ5<b;6GU)e1E2#:OfaRJ(J.KI
]<V-@G3L_J<ND@RT-cFcCdR[bRFPQOSE/-\Y(\//185Na6gcZ6IOH.GVGT6^HX.G
JY;KDZ&GAU0A@7Kc?-B)HH2Fb]UI#gK/@X/4PXBQ?Y:N-Z5)+E3:H9M;eB7NCU>?
[8XM>[0+R;aFM7N_9V4;Oab)QFUG.EC0?aGXf=IDdfd<Q]@dbTa7LR-+ZeE9<8<N
(?)OZ,,df]MV#I:OdE6^BAQU6>9g20G(YB?HeR.,6S@ER1AS8;SR3,J3-L4=ZJ<d
@DGV:Q)?(16DW:K[#S_=dF6ee9[]a@>56_=GaHeJ/^G+I9a=.DfRTA^\8V(C#c+L
B<I7J)S\<KL#+.MW:D#7gAU+4J159I62LY]:(#Pef@-:deIE88A2<g.eWCKZ>0<3
]6?GQ+4?M5Y_.YbSIP6AL]#NW9?La;,6N&TI#TRJ\D:/QI-TSXHL&Kd57e\HR,/6
Z?d&^\[IR&+9\RK(&Q/,T[J?9[)dQULb6Fc7:d5FMWR6AYQ<+)ROU4:R@R]YA];K
/9bVQW]d9+FF99CYH-DeJO7/&#=BBTEI@JP:OG5T;O)5/XbVgSd-++8S?cX3+U,0
2T//N7@N.A?>N)d@AMeJS^(cG#f)1FE3KZ]^Y=))?:YR?^QZgJVP@W2e\.]/=E<@
g>^gEK/S7\T<ZDAPNBP<]B/=-\2TG9QZ<,?UX)A8<5HXf&F@g<P>-dI.Q8/#2eTE
7]N(XfQ4.\F7=E?V4TU[TTHaYUIO:_QHUH__+ZJ41GK@_f7ALH/JZd5I;gSNVP-b
:)aVO]54F1K04J3M+^Nc4e.O#-?72?_RHHO^B;#<74SBPYJ,.D)9<^#,B54DK>2d
KNPb+59DY>HDUGOWcZNa^3>BM/Q8A,/,/=6?3:B7:P]PA)XScRgY>\)g,#g;<,Uf
^2:QI;);/5OQ:?/?,]EX?+WB<2J.faf,H4IF50-K;OU.OZ_L]<fHB[:+V2Y+=dF7
J0@bNB8P,gVb34DN[MQ+c?>8MA7:PKJe2?_YM+2Kb.7f?PGd[&bY)d7N/DgCH0=g
d1J1V#gU(5[6ab=AHCZBfJHMN#VI-L_F8@,8.2WQUK9PDO,?<F5R5;58?0d?]X>?
VYM#<AR@d@&L810O(\CD3@C3f684<#5X5@e[&Q=0YVVYH4=^bIT8EC6-SP]2a3RV
aKV=a+g<4JQ59#TE8C]R1e8#F1>Bg\Y7YA[:dKSHJIM23FS[93.cJ=eF6(a479gX
O\Y,=ZUIS1KUEX)M-4USMPY5Fc_]dfD[<06OI[</Q(C26+0H2U6TT\aHI-NN.cHS
AeBFgD8Q;^WNW^+>>3[WI,]9_UD#6]a/9;+<1bL;GI<AL6#eNEc-B<a/Q_JL?1.f
S_JV5:5/)ggP_&S;T(f:T0]3W#cF?@0f6dYZ[>(5OY7Q;1fa>?LD(]HM@DI@;8=N
)@#CQ6FCbZ:@?R7bUF3960b_T&g&MTBEOfad>MNHAO4E@bX#dBJf@S3&V<5A]<O&
.O6YC[K]&cZSYDFX#@fc]EA_cW,NUG>Wb[DIF1.5YN-;.@BBO6I<3Fa2L]@=V3>F
-D-N^W?.#5TfWC^Ra]+C9SF#<XaYQeE=K>[&CR6ENU+FPHCY#NM(@)-^7a0Tf/#Q
cZ7_A](&6D01UL6)2V>(9fP:7E>:\WH@]/,.A5VM7U4NAb>LGUc_[DDZC4SF]:WG
[9S;dH7R[.<00Hf[=b@P0f+#-da3UE)d8,LJ5d1+4B)TPOGBTOAJ=9aV87Y:B&FW
&&AX559_@>[.C&>ZB]Wf=.MgGF0&8U[4aLX[0\#/6EC_[&D?MaLT2X9PF4)^+(K?
)Yc79R)e[Tc,a7/.0M?_\4A-KN8g\JV]VJb.gP1\d^ZX(2H?:[;Bgc7<>.G-ZNQQ
-XP7_fcf(6b>2=W\d7Nc#\a+f>5CQ^eg=/+?\>1,3^(_8R1+?)TNFZ2[YY)(8(NV
#d5P&dPG)2&U/.PDWSSNcd[P+<4ZQ-/bGO=ALVe[7Z-T<0Ea[I[L.RLcA#b_)A43
.UVJZ\g1-V=gR9PJWMF_ESZc^;e.<eVff00:W8?ag.dMRF0NN5331SV9I3_\2A/Q
bXf,ag(2M22gdTJ_S8dY;bREd0:^/e(-/:T2(Ad>/Q,#+TfB6QWRE[aa[+7Y+G-,
J5#TPFNPGUJd?W)8(cg-]eO1K]951f<3?E&M8\MHTCa:1@G:fT.&6;?#+bfE^C/G
6C(c^D(XX4KffYHJ#DD__/HQ4g?#g[94FDO(d3R[T.?(H-eb-JZ_H;QYRfB_9&OH
EWL/9=KM.=26Ldb)UK6JcS80KZ:.UTZ[AIE7=a_4C_1H1eF40ZW7LfXW@T]=>LEG
VP9R/L0@Ld7LcSRWOWX,@<g+>)9CJ=X](F9N;<3@7FZfS,gAU#T?<]^<NK?fd7_\
7d\Oa/IT\V2&KM##E:YP@DJIX)D5(YBK?W6]O;+WdLfRPEeB?a?#a5,R.02Kf56^
)-CKHGcFA@XG[=]_NQ;7bAfSB[TS&S6U8QeCe,d?BK4ERP19V@7dC@b<U,XG#A4Y
+A/W&^73E1]]2C)._VFD<B@#Y_g>If<8AH8DbL&&&CD8/\\+0S(CQMZa9YSDOV[[
c1E=W6APd?[gD70/EBYI>f&O.b(W=?Y1M,.DPeK[gM=X/f9LVUGAZ+#B#X8fJAb8
_IY5FgP7D03IXC6U474O<,-^\)2K.957CR^&b:[f?=/]8JF<:ZND_]>S_AW,cdg3
VZ-a+.L5BKf\4Y/(/N4]BPcU](C<-0KfV>fOF<GaGf@c?E.Z>WA9BN2;M<a8O__X
#4SE/f:Id_e=DWHbcWe<NJ[c^<I80R;]JBa7O4f0:JF)gF[A.-/I@+Y)U2ZLI5B-
[>FU:[3R8=+1f/2McJ9K<CR7NZQQ_#=\9VT><[H#S&J_LF[ge9@\NX2(-T;>K5aL
4&0>C15X66=2N\G15I)VUa-<J-/Zb0ag[Nc9dP;fU2-FC]RJ4B2a6^SI;gT[LXEg
=LeG=H/.<XD(UR6a\32/5@A7ZASW&N1LgaF3>S5>f;Z>T7)N=SDHTX(VcL\Y-N-F
b2N0gE[dCOC1U6FgYSDGH6N_,P<K\XdS^RgF_T^4>ES7F9Y8&gc,>C_/9e[WFMN2
C7>g4e?PGV,]UV=(5&bd#.6\OK3?G[X7W2K5K^+-Nf&]2.Mfe0[8/=\DL06MMX?Z
E8T;,W[H.3U9XgS?S?#.g#^##94=T3#QW2Kcd=)+cH]G?eXK?XVQ3?_M@,a8[ZJ_
ccdb72S\,7,EQ[#<>#SYS0/@\Y68e+:Cd]eJKS^F=7C(>#4;VI)1L\UQZL+0/,gP
>96_1)?M61B2F+>_MCd@R4UQ_I--;/K(JQN&C;]:T=(^/Be7J=E7+Q7AR,LC<MQI
?G2;/A@C6XCB[MaYL3fS)460;2:(9;H/5=B:VS^@Q6F\7@5L9bbMEXFD>@O2)T\>
0XBQPD-F24E<6F^7C^a.UW^PHJ:P@^cN0.^.\@#--:;8A4#Z6#g@f[>S;3&a?HA4
N^YNgM=GR)/(B6G6[YT4b,800D_Ga_DVG&G7dRf(c,+&UF8]8AVWX\&7YS1]T9KX
Mb_T5.g5HPX/4b_F6fFfQ^\2Eee43U&OR1edH)F]N/NCO1L7HMbC40JF;1Z3Jba>
B,._9JW/_Cc<X)^PQf.Y2Rf,N5WO2(88+36>[dZcO\HZJ5KL[M>Q;VX==Jf3/XWV
Q.=SXKJ?26/f[W1L2OF66\K,.a0IX@AXbC#Q<APe,Q+86443\;;V?(PbeF];c=6]
-R#<?cAG-.[2d_]/KePMT.T0J60].>/:/XBLbP:HZgC_eBKMcIDN#_-fHP;HCc?Y
JA489&86FdE<I@Dd0#H_PDK&\C;MSIO@5&bEDYZJfN[)7T1C=V\^2&_HA6)d1+;-
\Q\G+[>X>HP?\DC@S;@2@#?H&aGAF89dLXd-_9^4c#YN(M6bBVXT)ZGbH3^S)+cN
ZZI<0Ha5Wf1bT]X3UN7Nd:2;.E3WbTe49.4N:>c)951ELVCHIaVFZgB(+/8:XBHb
F;TX67A6UY/09Q-cKSY\9:].He?W5/)84-3^_d<3JO5IN6W;C(RG(4.^+.7+8^Qg
52+(6?^8H05gZTIF3C1O_MJ/(:]A)UW2=<>O.ZOWBMQ6YA:+3H<c=UEN?>_KK+3:
XI+\/]S.O69U[c+Z)#8-d)0R5c2[^\M:FFC.>^KJH@bT]SGH9YB6RW,US\6bE;2a
(UZ2YQ9c,DK1H=][:_H_2E/17[M.?@UN&6UASRU[M?gQfPYadCd[RV=\X[6+>0I.
;A5b<T0)@fgWUG/0?.5TLM)Da+U3-IB<\)K\f=bO@?7,&EFJ4W>Eg@P_;PJE77cT
c].DN[,2L7a5NB52)V^Xf7Qge>@_>XHb_(5DPK7dB-S=@YY0E?Q1Z#O_0@(U5F1e
(cS_c712c\b^-6A3K/W3=&]dGCP#DdJNa.T6EIYD(b27P;EOQ-ZUU/;K.>&3KX2,
<gRM_PYAH]YdMK@F08BUM])V\<.YW9>7REXJ\,L60UY#RX?EV;D5A+YJM)XPWb18
EY?4VP3[M<C3YHXD5\GE\]1J[6KAe?&?HET#);2^@cbG<&ZQX\:W;\?=ZfK2=ag>
FDL4b1^)2WD(?X=/:F(S2d<eV^L9(6W8K7.&5S(+dK..3[/JJ5c2eJS+CKS:6^J-
QQB(9O+6Dba):CRY:6eVNd;SFg^JLfA9GQNKQNDSOICbT-a;=I3XBJfB-).:=-Y#
(dZ4e.S+-A\,Q4M@/UY94[\/7Kbb1@A3,Vg;O.&+;&AZ6-WRH9M4/J(_6..+Qgga
SDZedCGNc=a\LB@9DdNQ11(XM?RA,U-ZI.7aL38\9J3J=7R/@OIB&U^TVK^&c8.I
+8IT_O31<.EgE&.NQ;X@]GLIX2<a;-1a5SI]1BCdOd2a[Pd1;X)CZ(<H>=<S<A#V
#:?9YEFJ_?\ZfI<X].</8Y)dQKfF@cB.X;J.d\g[P=]Q>/[[NMZ5H_8@G^<@YW\?
#bSY#(_F=e4\PbEg&0\5N0YI(W2QKcO:/f,]^cP&;^2KJ=Ae5<:YN]eMc:Bd,VSG
HUF09Y@e5a.8_a?6[YCN^6UPE^(]fD[Zfa9c+N?AONfF:[P/aU7_J<f-7Z=2fEe(
KB1UfN)PONK;#_1MO)=+7>:?XSE8+:FA8M+&LF;5d@9T=/Y3KYfZN]/eH9DY&T?L
J<3E,025M4AI4CYfJGLTUKdS/+_=&>MUB]NW7=<]&UJ-BGQI=MN;Sd[,NM5I16fb
E+6?@>-HaCY[0:;M19=-X+Q]F]&KQ85UF5FH=PGWKfQ4c+;bYIW5XaRK];T0#[D.
,.I3ZbF1,20U8ACd\S\WS;ag?5cC^M7e/&T\F7JOHN6RW=c0B/)C6[,[313>)-3;
OUZC_KSX76-:=DFfbGW96(=D0Q4<^cL?)2+6P.,H9Y#U7\UE:Q+GI\b1/\R9Def_
CS?/5D&Q?RK;R8(bQH^UWYCH/WMO9a^[gCbA]e573G)bRZI^_G.LIc:KH4RIM&F_
3SEMT3a+E0A0,=@e1V@-f1XLPdG]Ua.>bBPJ4[87Y(Lb=C7RBEEMK]CYF5+g:UYN
NgB[ZA)_YTJef?:d0+^L.4PHC882-J7[4P2E7#<eLE++)Ba6c@281?X1JE#=Y.6\
JF=:C=PQ>ZQ7QRC^fJ:)5OH-TGcOPLP99&[G;Q>61e.Z/,9c6?JF;[gH^ZaQM-^1
?M=^+FMUI),[,/]RFY0/\IeSE)J&[=-f0[:YOAfNf6?\/f.+0/^C9>5Re1]a>N,#
BA,D[M&A(<3_/aV]2C5eFBD>VT+L,&;0BbM<89]@.RQS99d\UdAWeI;()PUVT8Z)
bY9+(/eT5O3ecXY>\H9A,c@3^beU)30CaH:EZLcf;M-UTCM<>(b9G2U_NQW;DfeI
X2a]]^X+8>SZfJ2TT7;-YKX4G+^KbGd-5+6(^N_TSJ2UXM.[2SVb5;6+W)LC/SJS
aI<J<.65:^1X,N>9b+A?&@/KNJ:P/#-(VIR:O28bE7\G9H(aX.T)D8#@830cJ+QC
1?99,/6g<e1.,P#XT<_LU.<NAFO-J)fJ@SbLPK,VYGe0cZ>[NDBAeI#[DENLBO?L
G<^COPI6DA5EWBS>_XRUH_UeDA)?;aa3]VZ2IM^9)dRd1_HD+#&Y,H.G#C9XXK4X
X]3H4YIO^N]@FL4E)AT4?ZdaSD1ZG^RD;VPHL+97=eP_eEZ2H11C==Y:f[9JYd44
S(8Y2FE68UY8gP?M,=bT@EX#>H^CX]<S30V2&IS_gbF7bgA@[LU#FeS[)b)U55AD
aY]+@VEN^gL^?-+5PSR3_(+f<e8ZAWTE6MV:6T@&cJ./1U]g0a^U;S8U3Ag-_)f-
?MGY@Ne>_dJS@3^_@YP4&U\:g3[8IO?R[,25D_7M@QA4;6.&5Nd+FOZ+gc-S=ZQ,
=,N=fE9N7I/TTN)I1N2a)=)&J<_4f()#)6(<\Qe,\9[U\ZWf&#Pa-OK=<,A?97#_
YV-g1QbSd/]1CHX58T^A?9)-)K/&=fRd/010\SE>@55I]eGFQQ=e)5DFHCK\b9(6
#ebKN,aXP+3b1]463&<),\Q(f5AF@+Z2+Of17]SMOA_LDcJH#9MELRc]c&M4Z/W+
>ANN^gH\?fY?DXTFeB[(gb@^]#QTUBS9JMB;e[@.F^9T20Vc,N>XR\=RX(V,=;d+
6R9+]a2D.dFXIcI4,V40bUNE8<?;TVR-REUUNVO?IUAaKH[ZCBfLP4=TS?V#3J6+
g,(HN<5#DE)::;\<b2#]VFIOLbD-.[7K?3CI_^[(0+WEC.#5?&&RVWV0X?1.WgNF
K?2JT6MIbGf-6&XF(3bAMbQeN#8:.Sb7.TKb<A:]_S&^(GV3gBPMI^+eMY/<T&,X
N,3/E[)\0dG)Q,+bOBOe154\ILGC4;Z\=ATTZdOJQB0U[(95g^P=/#\fW>OId6H>
/UC3Tb8Ag+XOJV:g;Pff>&9aT#+]?TeMgTegb?<?d-,.-^TOO@.fCK)G9_5XG1g&
,B+SH/c9?MWb)-g0S0PHARLH2fb1-2ZM6Qce^2Hg0WI8X.1K]L,?Y36]KLJ/0EA8
7R+eZIKC./1YKOS0FZKdGb6:feY<.,e=IFeT2_6NDTE2<T:SS]b1>_I&A92YXeO/
(4?/gXBC(RIH50WNSLZY+J.+8#=C78>YIf<LZ+acWfcDLY>?@^T/g@XcS?&@Y.L,
_?=e?/KL^VBDYW]QXbSO>(GZIg6=#]6APFeP8G/-Y4MQO[U_3fC:?bB/b0MXd+@2
ZfNOVcaXBS\X]]T+6a2_\aR^HgE,3/90WFFJfEeZ764YaF[ObHOB)HcE.#;5CGYJ
HRf#D)(@.Y(Q))]J7J0E+(&L4I0./LJP5AZ]S91+6TIVM+\8Od?GG&2>eVcCRI1f
UD+?,+YI?-K7/:;64[/6F)6PDLY6E4+GX60f/&6S1NP]5^@60:M9/1MAeIcMOU2W
VB1bZ<F<^#H6030Q=^WU-85DCCd)HFOHBgTU\C<<4)(G<YE+_VG]&\7D/;dHG20]
<FEF_8Xc/-(X\15MPeN)M>f.BSF#7FJ,5^09[\;E4I:2U><BRaeBBc8SRMK1/(:.
D?E#G,g[S<.4_-]Cd[97=Zf.1$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_MR10Q_AC_CONFIGURATION_SV
