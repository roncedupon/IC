
`ifndef GUARD_SVT_SPI_FLASH_S25FL_SDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_S25FL_SDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Spansion S25FL family in SDR mode.
 */
class svt_spi_flash_s25fl_sdr_ac_configuration extends svt_configuration;

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
   * WP# Setup time
   */
  real tWPS_ns = initial_time;

  /**
   * WP# Hold time
   */ 
  real tWPH_ns = initial_time;

  /**
   * HOLD Active Setup time
   */
  real tHLCH_ns = initial_time;

  /**
   * HOLD Active Hold time
   */
  real tCHHH_ns = initial_time;

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
  `svt_vmm_data_new(svt_spi_flash_s25fl_sdr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_s25fl_sdr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_s25fl_sdr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_s25fl_sdr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_s25fl_sdr_ac_configuration.
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
  `vmm_typename(svt_spi_flash_s25fl_sdr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_s25fl_sdr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
/9@Hd9#DEa:\+>OIWfdcS36KQGLV2N0_5:;5X\05J#\I[PeGYF,g-)c?K\b:/X,G
JFgVQeLcQ&G8,AI]>BU8^?5#6:D5RI:2V-(\?F89)U<e-&>L+=eW;,_&X[8TcgIa
VT,Q?+A)#Uc15cRN3KEcD[#UY(@R80aXP.J:9<=fQE6BeCEM(Q.D/7.S@caPH)LL
0Z<3G[?=?ePT)-Ec9M2)_2]]R=faQgW]8Z1FOI_C/-XR-W0S_:Y=B+S1La?)(W;a
C?N/GDP(BCH/WKH=]:Y.2)M/#RJc,+4(8K&K54XQ)H;@5a^,1^dWS6PJf@XIAY=>
c/&JO)5#.U+MK5ND(VJ[+F7F4P\\.-@[(7fCV&Zc.4J3FY-T7>306I1CG&&Vg,,(
2:(?SVQ(]I+Y[0J\Z#C:M6[VY9U2:1CYFPOSU(c-#@PG+<<9PI=>MX2Vb;XS,MC7
]ec.?DWe+ZO)X)Ed=T\<,8K#eJ4e5MN?4Q8\R=7K0U7TYH2VR+dPOXega<dZ#&1;
<YKI+@aY/QB.<DW\gH5#cC(D/A?2D&e6FL^_(HYOJfQVID?FHLGIFbRP/,RDS@5M
+5.fD4).RV)>cX)6dSbgfW7=1g?>34Se=07)B,7-2(agZE]XF#]8:&;dD<N6XR>2
?aTS+JD&YRC@6;UVE[Ca9S8V1K58XUVM\6U?5\,)BYEG,[3cKK84TGdgb#UCA=;4
dDQB^&\[NJ;]35WQg3;+FORXOK84DE3eO?LQG+aX:?VMd#fPH?LG<YQ4Q_/JP>Mf
/)4P\;96P4O_>5a?<@gTf1RX5$
`endprotected


//vcs_vip_protect
`protected
X^XPa\O3_XHF++6MT7.#+]B<V7ac<(4_W>gW#PV\>0M=,832NRV87(#-HA/4#9bM
fFLgL,(f#,Yb72D[@]cN.I.bZ<7\Qa@YM]a/LGZ=C==S74#;X=_cAS9NYY73Y_P_
DY8cZc@_#54D2_.dS#2ZUZOGe4=JHZ/7^FXd9W;aCS\L4(U[X,RB+P\T-?ELaT@=
+;78/+SFM#H(_?a;VDIdcb6.L<HG\MPG+/eYW,8;<A=J^CJ?dWSJ;VYH]&J9<LFM
P_2Qg9+A^V[]38V:-0,d4^ING6?H>W^C0KFA6]<cX..)._<e-JL&2^@,_0YD.9F_
U_O2[e#,9e,76H5@QLG\/:JV=/V1;GQ444_BHHB3C1YCK\0N/68>g@CM]Y?Z7UR8
f=L(R\_@WW2cI_\I\+/AOdTPSBNZ?\UUX1-]XP8US0OXaL#9LM4f)[Z32CBgZOLE
.;#;[F[F9UCPC3bZ9g]S=5<0<LQXM0IF&6@(F]f;<#V=H#IO/.[/2FRQaO<^a8H.
)]/);0Gg9&;88MP7Q?F>_=4TNE(G,:YF^>C@c]f6CF^9P/R]@@0g9,:/T#g?P7[.
AKA3][^-M(ZM(>1?.R;N-H9^Ga1,3fHD9?6cZ5fadbc=EAHG<-&b7RSLYWR_V^F-
#S).)Ld)WNY_;aM_[UR[49NL,0?M+5<GRg8.&][LVD&Xc>CC<_LB;=d]c7cB(J]e
U6[e#42T3O6Ng,6I5=K\A^\[If_FYH5Ye7_KdV_G7P<ff7FG1GeTV;:R-[cW9E\L
LKCVWg6OJ^<6J#_.RR[1/C:a]ecY,5JW64FZ<2M:@)g2]<5BX,+K<FCW7<V/X@8M
OBF&6I(#[FB/;3;#9a.DRT?O&dXTeF1R/IBe=.SUAIUS:#1GMdGD.&?=V(SJN/cB
O1@B177Q?(8d6JE.bK3K([eYGg9[SMRF8bUC1&I)=;/0Q08;LM8FLU3F:#11U-cb
T06QTHQag@eHVcR:UPSMGd&F,IZVKS8.:G0QY-MS310DF4U><?B[Q]UX_3]aNX&,
]bS4](+T1A?RBSf-ed9g;1F?g]f7cN<1_2YZ.OQg[^JVQ;TdAT.,A3:<G^D1;T-Z
2E0f>>FY8g,I^],63N0W8ZHg,PKP)5.UXc0-P_=>(]X+I4S>0d+K)CTQ3K9L7#BG
@<>Ac&2IJ?-)([U/D.7^beMaG@M24HFYc),VR9\a?a;K<g1NZ?6-cgRL-ZdL12#V
X_X,#(W=fVB#6g0dcLDHUZ7FO<(L;A42fV@1)_;HL_c,,U08?78cb,]&g;aD9T^f
LU:]N+=9\Mb+GSA[WPC<D3?)N@,IGPR_ELQOa1D,UUbP:d]\R_@eI]OffUQCN#.+
IN7^4<>&RCRJ0T[-.UF]V46@PSBA^Q.<@KG/V>)g,c=R,-QR+AeA35?]1+&CQPF?
faL(GVdAVY@C:79d>4R5M7OBHBTOdHHS;=\A_4S;NQSA:M2AZ#EY,6I4(F=WLQ9[
>PY:7VPNT_]Pg59^e:WYB#B0GEAR#RO/Y]G2[=/)&PdZ9g;2?8X>3c(Y0+06RA93
+KU#b^]V)+1eR9H2M[b?.DZ/8>L<(07GeIORLBW]TIP8\.K\5HN>de5DNHQ-6OT=
3cY_f@+<,9YS:MbEX/ZZ56]02f#],^=,T]6T>S<b_Qg>Wf(7cU[aOW.H&.+&UfAB
1AP-,-5e+K/Vee=X?Y@fWDe^d\1GH&68/WI6aQHgJfSZA+?&M/&.\S/A__EaI6G)
JKfQJ\-Ra]A?1]-GK9IHG73C+66TON[>[.[CgYg4XfL@Z^PT;;55=?G[JOWI:;X5
Q^72gPL6cZ00ULe@<>FbKFZ4CSDOfgT7MSWHTH6#TSHAbL0G.O)XTI_ATeMN[MFJ
B\KE(+W-31^b]R+8KcG@?8W6W>7@f+2N+G#NSE#=<[-1gFS3P-J+5/g#1R<#.70H
:=T\7/&O,0BLT9O\[/4gHC:dQL(./f;IBZ#8E)dB>&GCTa0Nb=W_K_Vg70K&H6SX
c?PPG06YPc+#Nf23569_JYLIb]5HPX;B:c&R^VA#C]75Q\/_/g[g2c,W07=QB-Za
RT&(f5UPGCQSJ\_,FR49/H>:^>XdDb)J)bd]H>SATdKJZBHE=6,MD6J>aNa77_Gd
^UG)W)7VaIb]Z,><K#BMaYM:_)d/7.dL+=d/Z&GTb7E/L@JKT8:=@D=H,MEE]U4g
MbU::CUWeXS^6F>9bQAB9V401dfa[O<@.RGV1S[D7L,M:=TUY^I&/T0#M>]:0ZLf
T3c2aIQUT;ZWa_2fFd2\aAd)e?X27V_</If(1=Z>a5/UdIb.DcGa3D^5ZOSR,3#=
(U5e,gDZ3d\@Lb)FDRTd1(ZO>a-UV4PR((N3d^4>ZgIf_I,=YbB6fNN@)KZSScDH
1B?Gb?5.)44abH:O<LI36I=<7D1<Y>gH7=/7AI7&aUCQZ]\V>LU@g;Xa,,@N+X<1
A),P@U<M4G,e@(I<I4>aHOEJ_(6)Ddc;>Na5\UN)&+7\N&::H)9V0U[FN;Y@<]9M
)9;F)HKBe(d&QgM(\:1aL(ef+K<SNVQX4Vd^:@2c<T&]/2F\ERMW>C+)X,H1+GL:
PI0=A3D,3D^-V(C;(W=&\3gK6WLeWLH4>1XC4OAOPUfcW/AFAgZ=+WC?RZ45#6VF
?7T_TbR[YND>KYE,WV-5Y#[-1--#8=+6a7(+2>O&bf\Dg2K8A(L[P@<4M^>1e=4T
OaCM+J91:8&VWEYEMNVa>If;Y[^\B5P>VE-[6Y(Nd;_I.]__JaKI)6&c0+O--eRa
4.[7)aKc_dD8:3<+07]GbO^(15(W_Da-:[Ig)^62fb?+WB3feVR:Qgaf_5/\H5TQ
De)NWUVd\_7HRS&3[_4C;+3RWO]CTN95?_U<0P8SM.fcC+S@,#5,0NSUXF5+1QQ]
M(G<=PTA1:]](1>fP,S1RJO/+XBT1NV,.0FV4<.).LT=/KZa:acJEIL<B5W1PE5.
B_9-dU1PA&eaWZG&8F3QDO_FSd3+VSb=N+KOD^2D6<f&9@^,Yed3-@X:S@b9Mddd
=<I/G1T8/+YJGLB#<G^]XRO]_b8QTD1g_<N#fK_\-aTER=-AQGgCZ<#CVW?A0H2N
e,4Y:3\</Y/R<=A4YOX?HW98]]O\CaGC@Y.:O_D-BZ+gQ;Oe_N^b<a.,U.2;A.O/
G+NE#VfS2@\87GP:c/-O,fW2/TQTT-CTK[QN6efX>@3<?.7YYI)AR+Qde]bg_WA,
F@MT::O;.#T;NNb2J/CIO?LgQ.c=_Q)ZW8bcOWf<5&:<7PD8-3a4Md@EAKVU;)Of
B2>0JdO.J92P,.2+0K9eHU3[5M^,[ZR;YU\ca,<KW\R;3bec6HdXVOg_\?;<?[Z<
@E9S3_R3<]f:NMcI)8H#-dPFg50IdEQ]=@9T<e_)c7HeE2.a_Rf&:?72K]ZY;<1N
Tb?V3>4YUL/,0E>.T^+(AN+OR&]68f2^,4):Q[5EZ@V(8(UP7fIe8fOdBTC9YLH#
546:NB?B()_=5(Z]ZQR#Z.Y(E>GG6ABLH/DPJ5gX407YeWFVF7<3)9f?(C^J/bI4
EZ-:H-;;(2R/NF0Pc60BAO&<d#+4^=Z:=3#?.Y4+.=T,;W+>+>JBS[KGXd?\.OF&
F=.B0J3+)^AMd[_-X-:_B<<eDNW942=6E/(=F&CbJ8R8>?5D[V:DUXPX/..L28VZ
e1#4Q0ae=M(?08HaWH=,2Y+N/cV<FF,CSWQNEWVFYPO#1gTMB79N2)=a[#P7)&/F
>F7V4Y7K/P[:W[+J&5fZ2L]gLLaFgELMU7WND.R&>f&cG.FN[&6E@HbaOMGP59W&
.e[f)//^(#)E&5F<fS_gNdYZgU>DRJ6,[<HSg_VY<K/dRBK#X)MX,GW#0GNTeWT5
M2[BLf&N2YA#SSSASV2]c(dROG7@K,B^+(=FH?\MX?9B&1IOfE)<+S/.e?e5)O3e
1K3f9e>QIeMc]\U<Q3NYL.J,1QGcX1-(CN2X.6WSAIUB8?bK\O[QKaE?9/E\T([3
Q6,;If2dU(9_PJ\B6ae_=8XIJ+gdU_ROe\LaEe@(;W7<Y]c)KL(,:g2^\9,MIX>@
3VWA@JKa^XcdZW2)4J?=SW+]8[46gD>TaB9NR]^D@J_HM^Q=KgY4H;9[MAS)G-<:
6X0/>9X0]XSgPaJ;Kb9DI21KG5:b>1.[KdVB\IA1J=6g)/6=A85fMG:f7B1&WeK&
NZ5)F#aaM@VB1Y=fWf^2^4]d_NH8K2c3D2B31@A7\KIVbMUTeLKOMB7/4S+g=<,V
[XfH>cC7]WdHbK>AKGG<J;>ZSXf+Q(IS#KUO,+?W@?3K(_)M]eZFRF03.?WL]8M_
RKG&D//SgGd[?S1X0>V:JVdSL8EXR\gD[#I2J7[A)e2/YKgO0PAWac-abE)>3(?&
Q2)OY;.YBaN5M,Cbb(.-299eN/-6dJc;E:7fb3/WK1IAGV\K9\T<bWcT6&;__7;L
e[.HU3(K.7[[eP1E);_RUHOR9^ZKM)2F]5F);)_47@ET2/>U.gPRBdJQaaFX^1?0
M=&M>IV@(\8EfHI=SPZG5;=(PVe02_VKU:&IN]3:<05?//Wb&b<2\6H]&CN1M#,2
RFIH_-HLX\WU3OQ,gB-:#@^3R;.de1Rf?G-<b,c3-TQ6WfN0(ZN1KNY3\F&/DIK[
9YJE#@Y_9Cf41432(CS3efF\QNX3KG^KR.QA&cDf.VH>BER>0(KB>BIM3F8[a#.?
075Sg(\[A>=cfRYeI0,<.OdT3^(f;[NP^LB(aDU-H@4DQe,4[X)Ba<[#=>Re;B5T
:C2-<f&=QdHSULa+W1.KQV/@(&1SWFb.@-Y11e;&3:5KPK//BIV0L4QP^cb[VFU/
QI1-f5RFfII\J;f71e(PR0]66N7IGGF(91JN/cS9;&MC:dMU-a[67a\a@?FHeUN,
,?/0TY#GY\[AMR@fdUJFI^0F6LO[aBG^,aW1[R1-()]+RdV>_9D-U.8AbIH9Q#O?
L8ORW^_H2)1E>JIAM_\.A)FLY\7ZO<=Pc6b:XD1SE.fKFTWK&:@(K3X]IKMeKP58
d\(6.V,1+00\.@8\<T+g4(\:._M-[cbg[#X4YH3(M=;7L3CP6aO);TCCBQNM(BK8
2?H0<9O)HG5@KSY]Q@ZG2>Ca1;PE2[DN^Rf.F@gQCWQ]X=XD2dS6.:Z/G<^.8aNL
?5MKB(S:e^F8I?V28LH#S6T=8WB0U5Mb8CN0S4bM>BM4(/OOBHKO)O2281@:;1(D
a<.+T64\?7=AcW4HM2RaD\V7-7He.&;C@^\8C4eSI_6L_@&,N&?JI=47\NHeLA#1
4OcH<>KV<[eVd=WW&Aee7\:R@PHBEg3+VF7A>f[)eSaZLT;&^[F6E9\gT&2\<EY/
FRa7<V\8e+>dG.91/)T+C?SHPg0]Z)8VO_G]5YL=0W4M=GQ0P_da&f-SP(CEaM>4
,?30^d:CW,f=4/T[d)ZFdS;2#cP&HO>;)U=7Y6MQOZe8G(-C;fNU(A6c7H+K5>@Y
_BZ.32SR3FI:[Z[^QR^E/2IKYBG1-NUgFWR56AaO]bfLb++g\X8=(?ITU:R.;2T=
8fV>+?WL;D91fN)?&4F-\P5TCf\=:L7L,K\Af>;7KeTT.;;d1Z:73Y[G^/MVNZbJ
MV+A?3\fWB>dQ#BP^FT_L_,_77]ZQP):F&T[PP6_+#;8X5/&b(#_Sa[39(J4):#V
>DPZ>W.Q9F>PO6NVE4P[WgP9/f[S[IYSJ?,Q[cJaOCX=;bSKU017Q28+X&4K]/dX
@aY-:=.>Z@#7dQ3:O25NCG^&1efdY1d+,G,F8e3C_-31_5[VC?@P_YB\-3<e=#cC
U@ICLJC#\&)7,Gg9EN9HLcTT#00-B22S\1O5O-Z:g@W)+1CBH2U8;R0C^7R01:.Q
LG:McLBNQbE=XT8(CTE7gZDVgX,HR>EUX,aPVOL+dc+0Y<X>69bgY;a^[K#2N,-W
KA\<b]\&8f#S4YU+21>T+.dd;065#]6X)8#ZAfV5DRC@cPK8TGR55KLP_BXVUJWV
F8U1A_bg(ce8WUZ6WfaDBBeZH-9M)U>,HVB4JZX0I=6e<=.XgTCdeZ)cH_0e2GN8
a^Z&]1GN:E9)VWN-eK8#=YQHcWU\#.U;^@LPE#5+dMI::;7\5ULEZ#XYH\cZ=?dW
/?=4\N7G5QSZ:<eWS/WCfC[Na/]=b=F\(UQYFP6WU3:cKH+V#4EbX;d&_?BN)-6;
_5A,7.1)7K:#WUX72;&/20.(@@=5>/=8f8OedA12SJE@<f)UM/I7T[0S=/;e&JX3
C73&3R\X4TH-3WV6TKD?+T(M>E_U]>[+ACCE(-T6K+9V94\7\U&IBJ_e^,JZ06F4
^g4Q<.WWYCXY)McS@&Z9NH:cGbKH)(NCRZ:3c6?aQFMf4RYK+;+\W(#92QHbX-J6
)-^Z(\Qd[?@F8H</a9a=8D.HAe48P[@<4-cf>+QbOV?N4DcD0;X0@,9Z)9R;U&EO
=Gg&.,A6_\#RGb?0L;^68ITK&e^ga.e=c1^W1JK)a)]+1I;0Z,I3.FUBMQ]dUMgL
Y.IC;dD/I9.g4H5YC&9,=LW10072_^;4<#Aa0?g.HXD+/aXN/@I+(16O(KTQX<OU
O62IN^9Cc3Sb\Eb0J<bS#M6g+Y,488;QH1(OX1Z#d,@UeJLB5W0Q;@+2(aK]4O-[
f:\+SBdF7#J-)@)TPfcJ,98HY8e5W6>(4:OVfXe#1&LaP0RMHH5OBdFA+NK,+]&<
,Jg/(^6ZcY;YRL?Z\CR<^>gC-T2+WD3aF?)+P<<;EL+ZOC1]<b?6FC#V/]C<(1)#
M9J-D<a-3M0aPBc?OaX&T;Q-A8\R9HcT7]FbfVX50BEPS0A>DWPW68#>0AF=aH_S
de01F3G9E(fPZ\=P)>2c^5IM,LRS_&d>Vc([9ZI84aDBDF5^C]<f<fbJg(:[Q//1
#\QA:1.P??cV0Z3gf>#B[[/bX:Ke-c.<9HB(C-OBVI<#R+2Da_II^(\C_KF75>9L
^D@cW#>CYY##g5=28c7349PZ8U(0aDEf_CLDPa?W6+#I>E\f)dT;J?@;WBFKF^AG
f^A+8842Qe^(7=44U:8\EKK,;JgdH4E1DB0/#WSdFA(f.RFRN3O<,Xd<a;1KUEFN
KXA-A/Qg\?fOg-T6b^Hb3cH^S[4NW/(?LK;A]ZA2I?/(.QH6;4C9g/?8)DEAHb4d
;:W[6MBTZ+OHWXCXDP[O:\W+@Cae]EEJV[)3DYS:5K^3f\?SB54\I37+2LC_\XQO
Y-GcI&gD:N1Qc&\ER]9fd_HLe\4RaKBcC25T12.-R>YLB:+E/N.:[PJ+W/,SeFZK
GJZ+Z&JD&^fUfJSP3MJdOe1_MdgKN\C@YZd7TJAL>CO2Zf]4LTDI47:=-C?^1A9]
[0;J2:720X_>A_\6O^^KSOZ(XC=gQL#H3VVKGPf7>?2YJ,@S>Tb/X0b9WF9MG;-?
VOC/eLAMA22gBV?-#,+0BJe:#VbTKfQ&_O]R:^)I/+LRLT2#_1N?V8ER7]3#4?c7
b7[)=]FC^.?-H&F>Qg@JSJJM?9)R09K[Ve#_f>KIJ@G.Fd/0@b5ESJ(TO[DeKURa
CNRbZT,Y92AP?4BE]N16cDXIdP:D4.L]TTU6DM28+FE_>)<H73M/3H4=.-(H<UNK
.;U0MY?V#;g2b#aIN_PR3?+PIEC@0>(b:d_=O@/31L8g<Z.c;C@&8fTL[4Qd9=Vf
Y,JT3[g,ZR?:&\8W5OcY1?M.1Z.Q[1P[C;AB^((gO_]/X@O=+DBB0&OPE5K/Vb(I
4e0MeTG6BQ\OZJ\2He=+?4(^3)>K9J<9:1eW4_Y0Q]+<a1_c]K[9Fa\Kb]SEZg@_
N/Sg:,8Q/T?IF_GZ097X,W7/#4V^[@^?X,F>004(&RBX?dCL67cK40/+eUGRC\Z&
eQ#+6EUO32?<UE/YX,?@&;U70#C6F_1/\H7LG:^D+a>Q:[YRBb1#BK.a(DN\Z8e]
)#<e19JXF5OFD/d>RMDQ<gafY0]1A7DO6P2FLMbXA9f9G^J1f46BJ#T]@#7Z4dAD
-:O0YT31?-U?HZ=Ob>.4EX?6G(@@[J?0gV\b;(g#S3=9(?\cWc4U0Q>Bc\S6DU<;
Z7KU\B[[1AJdF_A2/0=<#G__&\U.5dg),eF(-T]N6S2BEbC,]SOH.QU+.WPC;RO1
_O90W2YUJ]JS5?#+2>+aTXf6BNd=WQCHI2VeTB&IUBGYW\e(fCQB4Q2c@\0595P[
C#Z49aWI?-RG=:XK\Qd0ZFa4IA6&Q-.e&0fVJJD/=d&O-:)f>::^4&O30GY@T).d
XG6Zf7_E(]L5T,+_=5GgfBOD+>_Pb5W\#-=0b[M1g,a^Agf6M?^LNf;FD,2SPg\+
[eBZ:KJS<,0#Y^\\aGe=:_<X&B.;+J:&]db#+B]2Yg&;cVJ+WK/PU;.ceFNJR02@
8^C>/c3WZ)V&JR;ag8K7;bd0fbYV8\eIRdJ+>9WC&.9MB6)3FGg80&Z_J7IJ&WR0
Z)e@R=UJ+9BATd[)&AbdNS#?)a(X=d[EJ3314[,O9e13EY/UZ7RBF5?RADNRMa_[
;9/#\J<eIRf<:B5L&1DMO8C^)#.[/25_.A_)52?X4(CV7&NHO@A>P,dFHPTdg_5#
G31M8+RW51^Y6Nf_PGS<;M6g+]RI0acCaNbTSPgbC(9POF#>eb[GXIY7K3HLG/ge
=.2NW/eB]+AP&+fUR7.T)6U-U-)D7_^08a,gU7M3V0eZ2/@J/:JFRUNE?Lb=#EQG
DP&TAF/bXD=,EfaYe#@cFbd=H8EVO9>5Y@XdQ=59YJ,USO.[8-d2]21=AL9eQ&fd
C599IZ)?O#=f]+ES2HZ_fb.N_f8/46>OXN=<_,[UUMf=N@^]::<LF9O7L@b^0TH9
PXd:VM57F,HIC11MT][@:4f(GQ)>^db1#.\+b#.d(@@UFS3Q?9].1g,)(]ScS:]P
N[1GGH+)3C2C<f&I_#^PW5O[@;?g13B6YeeL1G6gPOP>&4]2-O[R-a7V(>2VKKZ[
;O9NcgXH>(W59@^YDXF4)DDV+E-Y&[U&5HeLTED/2HKg92]>0@/^5+9--<(N.[R?
435H[CJ(/cY8WY?Q&FU:9;:J7_6\9G>d;BHXV&_3Y+8^BBU1bO+]a83(/:N&\PgX
+DZEJ8bgdUA?F(-V]H5c^4(@MQCQVH=:6&ZEI38]e8=fLcb0g_FSOD1[QcSVXeD6
\E4Q(>7eYJ<>7CA.cfd&X\fA\F5EWGX34CR(b#F?JU\=2_8OO;(=J(3V_F]4RL=T
C?YXI0VU<?U[20(^5:])_:&(),-_Vg0+,a.>&QZ.F9/[<g0MTd.1VCW4gbH8I;aY
2f;g>Y4R41R(b?Qe&\4Ae6E+WBd&4LYaJWHGBHfRV)J\Z^b(b50/98GV=QMH8K/T
?EO5\M(-L6cgPKNJ_2NEESFb#<F_6H#1_cfRY@6[?BZJ=,a-dI[.VaY?aO2T[45#
I@<M,8EZ3.[]32HgZ520+1+I[)a6d3g?d,GWYR0B2gD53_U,(gUf@cc[a@cQUTbP
Xg;V(V@1C,(;@>VN2_HIS8+.Te+VJH<FA.+IU-S@@7_RQS,^d+G259<GZ>]+3b/P
.dBT?fI=7Y5b=A[bJJ<S9][.8-8D.QbL3-K680a<?V&EQ].C7<6XAg,6J&Ie7:\,
[0)J_Rg>g3M-1eCP>KY23^T,1EEC^bDC?fB@-W@@D-PQCEL^+._e>?A39ZJ9M6DW
)3?dTbGI7QNOSg6a,+W>0aNXJLeB,B^OQIT;6M3XQa<HPXECA.BPHIY^([S>W9<F
F7HH4@7KQC(PffV;e_G;EK?g+Q/bU+VT13/T,_4A-5K)[8FYERGK<N9XLXIK?-,(
V10.^e1FWCX5)]:6\AHT21J,#5aKb?g,K2N:+>.PZZ\]AMN,&W6CHbN[WQNZJL\P
HQ1UMMTBNdeP9Mg,T(;^WZFY27S^BJb67(GSF9AZ(L@;A8RO1.B#f_I5/\bJHdB3
0D[-5C__(2g=887_U3+ZJP4U3XF\e:E5O1,,3\TacV>L:2990gJS-&8,O0;:KYd?
Efg7Y8@IX?#W)fHYY^.e,GF8Y>UD(>DUbPB\7#:T;UY+11\E66XA?O=HBN\;YR9C
:\_Y;3(D7.Id1VSC^JZIG&&#II7bQaU]cUIC9c3Z/:<XCQ(g7ZIKY_>=TL1+9H@T
,3C)dB#Zc&?01Y.\5,]KF<R=TG#gI\5a@FNOMHRPf&4_NL/M/c&>Ld&-2fE-EF4+
(W3e-,NN@_-9U^H2,aEJ07++[f/)ALHgTDRNTGVDR,&K^bH3\c]2X3P<d:c0VL_T
Z-R\8&3eb:);@]GAYMKO;5Q;JWJR&1:Zf2/EEB@5a]G/R4LTW,GCT;+9c#fT+.IV
^D1#JT^AW/48DCUa:6;8f^&Q;A;\TA@YTWL\@_P&(WO0U:?UX.cIZbaA4J8WC?H[
6NaCJ,D&<;T(MM^<]@M,N#>TU^f6>PV>NPV/KI+IMH2Bce7LCLSIFZFX.+[AU5P5
08VQ8SA,[[9:AFgC3(e52fg5ZT72cP@<&Y7W1CZ/A_N(HO=:>9>9R#9KJL/W\YE_
YX98?5d^0P7^=d]f[YaRG=,>005XQJdbZ,1#c;f&]0<_RI4fESAX28:eYQK:Ha,M
b<a_c,G0aL#LC8BNM9@d2Z)MG^[ZT.+YMCYJcgQ>C=T/d86c^gf2e1)0+Ag(CU#\
MDcX]OWNGca6,5Z-d9X+eU&dG_AH-\-Bg;T=&7N__LA)#D/]O@8[(03Q^fK]V7?a
cE<?VT.Y+Kff):JD[#_@M64fYbT,b-]54)R<M=1.,@:U1MKANMT#c9^GGJ+^,?:c
f4e@,G^.gAbSV+UC0PLS\Q-@3.^(.A<?;0?R5WXf#.c>J5&=-5SR-G8DP^B9A0N7
,(H^E2HRB85;ZNb;8\eM/<#[K@CSE6^IZS4#C(c8T64G23]FJ2A0\(^F(TUF]3UL
??WGB2F++O:4T-3F_8U^DYO=/.+6Nf43JKAI&IQ(f[BB+M38L,Z)Pg:BE[9-&[<H
I4P_McK8671^[.6:=N.<CG[aBI(,:C&97?5+J#bB?P,AV#:CEPTEJ3d9D+YQIT+D
EO\?3I(9-?8R)@>E^ZZ^P9WWI_FL.HbDU:?2G/1-&GOM;0UXP.?c?@^Z=J92H>@[
((FISSJ&G2HW\VP]F#T(68HcG[1]M,gO1>,E9SM>\7:1QP]@U@J02]=95>(61bC@
.<MbIf,1(-<0XDA8=F.?e-/UY8DUCO7<&ZgXb>MNR>;FcgM:5EW&eQ(4?;,+#I2F
Q>78Q>8AWP<fK(gO0,>[5L@<UEJQcQFTS0)Y=/cTeeaFWOLD1UgS9;f,VCXKQWfX
GC,aQ#JE:e_5G:L9=Z[VX)bHL74#OcIO?PcJfC=R:FRIMH_I/WUdcNQ0B+Sb=-gV
2Qad=EgPSZ203W=cga&4Ef34J\6C:1H0]U_M#cSDU:;/CE@MD\=IgZ3-&Q#\f#)I
9TO&_PBeP=+c>Xg87[+JCa]M/DS]5:;e<9#E4,FMP&UdT?=?3V&BD&>54ba-@SYQ
WI(2/e,HKe51eEa;NX8(9P^1QYZ2ODM]d#E-.6.:cHBW@Q.+QX<EYF6^0EELH#:L
^6_LQ#a:aO;VK:>ZUdO_:>)3OAG<#Z_0]]@FBO49?^gef=a77;b_\&Rc4[,UM;Q>
3AOIUAGN62T::9K5<J]I^VE7FgbL,L#N:Z8QB)+0FfRe_F@b6@NO@BF\.&O#^-?f
>UFPG\:4R=AZ_HPM5f&O:0=AVDKD.)@)cd<RBV(INS;=25FLJ02d514Y=6QOQ?=4
Q_E:0<49:DX\Q+A62<I&/G9YAI\PdDF96Z0@0SE<91NYH#5c(0P-.d9X>S+O\<O=
LMW(g.[DP-ZDK0.@EUR[#edGAE-3Rca()6U(Kcb:KfB_TK_P0P1aB)_)H4ML&d0S
1))=)@)D]I#\KI(5>dW8VK_YS&H,TY9GC>Ga42TJ9A+4][N4RM^G2([&_cg;f^Q<
/P1M5#;Y0&[(a1fJYCK[]XJ+<bHC.033eVW)2ZJ]<,1G?=BgQM?0eZ/E-b&KY)f&
@WN3?adO/V(T.NfZZ<FHAB[S,Q&R/9+^JcYgeBHOTMfc#T/_:QeDVPgEa#(K/?E-
DJTW;f8>e=3I48ITSbd?2.#U#Q<:ZFJZK[0-AdQbO-C^SL<J\bUS8IPd]J&Of-;D
XL6e/>:H-a&4b6YJ[Qf4+;U?=A(OWUB.DQG_<?I[QT_YPE,54;@_S6eIaa-/:b.,
OPf](0:(Y#]\V&dM-_f1#DLTdOI=b=D:>=addAb<FNP4SbAg/^>50Z,QX8OeO2d5
fM]-GOQ3A(cANCZB<b?=TdOWNPOYIZ?-]Q/M2YPgFP&^LWD8OgZ:GW?:3+?&:@N.
HXR9HV)A)/,41GH,H@=M<4W.^GbZF=D<-+DfPU\1#cf<5K)G]dD5@IME,&4U=#2C
HM7WCHP<7;7SW79K\#PU2KgLL<-5&@<1C3?50Z6V=bbDEcgM[cP:QQHJQSDa7(b5
d[;BL2cD,:+/]R61dfE6ODRb7R\Y82,aMbcBObVHJM<D7^\D,4L)QIQKKe^e77X7
NZ^23-5\#R@VS,9WeIUN:Q]AAeLRgbb]<(/6YQH9NPgE)<E/QULdHdNGI\90BO+I
c3TV^c#PU::_gEHLM>eX=2NWAE+Y/#bKdX\-8Y<#e>Q+ZLI&5(@7ZGa<V_=RHg8g
8[7:>,QJRd5SS^1?@PE<Ya(OcS>:O;=T43XT2._)7DDQ3:X>#,eC(.bO7\6OF-=:
+cOg.a/bPM8c\<\#c[EPedK2O&J#?PDSX[&D2F0I^,O(Y:Wgg_dC:8NTWS5dKEcW
QZY[M;1F9JdI+M_PaPX=QO>)M39QQ1DO&F\,O&(L[(XKCb:DHPVLPd@H+H>E1T.?
a6&V@C(>ffV\]7(]P11H;7>TO&-+73aPae-P5d(?F/b03T^\70.D]\?_P;[5cH/9
JW.U#<C+WFL&>:1MA\Q(;KVeFN>K9YM5DQ(7[<UF>YHISR,&J77>\1P@a6T>QX&H
aa4K3A=D24NK.0XQOg:b7(Z2e8FCB4Aceb:4b)#5g5?gCM\TR\;W1ZaAXd(E;IFT
a7K;NHLB5#>,^WB=X<.8,)JA-\<TJ3)6W\_)\SLfKPe<1Q.#@E<O1Z3]AU9PQ]]E
g+\e>-5VWg8>EML19VU7E)2,V;eG<\+-2Z<+&G^MZ)646[4@[GQW[eE#aU.@f3#Y
NUK;;7/<4:4L8R2?F8N\&[aM_M&=Y@;YcWK7,REHa9RU:8I]US<E7(LXg_&9,VDC
Z7XHKD[aIEUTU&_^3BS0Y5Z@[.J-cKe6OCC4\a_XIXR,^UVLD22d255X&c9XJ8S7
L][ccFb(B>>I(=J;F->G?#Z#c-?KJ?1EK9#2+90#W6=2I)gTZ.X5S<H/O(@G0[+H
U&A3:f&bKP?Q52=S>MWO._0)D;G/F<&:1)fdVOf0)WAV,][,1W]#Y?,FW4Ed><G#
03)&6;72J6QL)S#e/Ke)IY,#:J?fC7)9/:(].U9N4d/]Y.4,5GUHSCBJ/@_ER(04
XM=.O0232T^]R^,A=AJ?^TU+e7-&8A-IgBd)LMVg8Kf?)01H-)S1UG/4UP/C2Na<
4>M0NEH7.Q/W9[QX=O)XT,SJ2AL62;UaBWRS?]Sd/V8,KP9NJfdSW<]YKO65\<C0
JOD)_\fJ;RN?/A^1\)H2K,E+;2IISM]7gS?A_EWW6EFDReH&BUJ#H>gR8B^]>.35
[08CD]^S5d.XPFN(=:YQe&\VWB,dJ0d1.d_26=[ZS_=V^^9XI;,<PeJJFRUbe(MX
2VND6;N[1XIg1ZLF[&?0H^1ZF;=@Z=[KFA/IAE7dXH?1]6V=_L6eWa6PG>FLFff,
JA_5?HMU>@]4=;Zg,_e5I5?(ADLX=8dfYBPLe^=CJ,KTGg90]F2?4,FLG\#;N4XS
a\-40@L?S3DM=1D9N<R=OfgN?>\E0I/0GF+8&>:dIgX6+TG?_0FHc:5fQW2Y2]-?
[)#7EKCd-/0Z.eN_K)\+Q>/@+NS-RI]TcEXcV<H;]\b_.0eCO.6WHEUGf1>N^T=(
8.SD5+1R?I_c3#Ec0#c4Abd>=4XIBbQD^Ecf?Ob0)JNFJN,7B9)Hec@6B7PU:)>D
0299HBfAKT)QG0:gG#DTT<39&8PY]a4e0c2D;E]GbJeGa#S)QR#fAZG8RaBCKDZ)
JQ.dUX<(#@-L>JDXZV[TXSYAVXAGE^AB)W?C&GV5#ZfJT=(IN9JY0>SHA9Q4L<a#
_9L;T_X;e5[cY&Q=9<Yc])+YMR8TIH<PL-3#K^SC08O#1AFOMC9NdIa.:T&F3G2>
O><SK6+N?6DPeEYa+,9@RF3^GACR-PQ+4QdKM;.N&5]U?KEDaJPVZJ9bcZJ7HF\G
Q.U,;2aW@C/+P1dOdL^90Qe_U3)ZXD(C?GcEE3Yc_NdQI.6[];a@cHMNH7dgFCGM
-E3#?g1Z=be@^@V[b>ANNBB5@\JNA4Y8aX&@6BZO1=#cR9EQBe-dFJK[V]>?4I5:
JK;=LcR.G;IAGBOW=Le-YD[,OI7DFa22(:4aHE=N.1f7UgGaJ.:-B3CEUH?QIAb+
)J]#f1[Vg_G/Q^5g=#5]_](E#(d9(dZ^^^UQ<]d51Cb]7O95Eg+=,1<81(Y7-Q]U
a<_?+aabfUZPWFAY)IGWBLM8YZ_GCdJ1<J9P4SWDL:9eKIcLc,0T6&G;YAEFfcg_
CR9]Q+Y>R==7)Z>H#IPO5KNDBf6HNaa3[OEYV4g@bW(+V=?L4E?)9JNIP9IHLK3<
/,U9)8_GUHd?9adITDJ#/[C@N4-VL:?CB^Q-.Xa>/G^:A18ReK>].-HfYAe0.9&I
(P20Y4R&FWH]KIP72;WC6BEacIUSUS.Ma9VYceN,XXBB.^M9=1WN4ZM#./H6T;b1
\-PXM&fZU<d9KGV]+:FXI7BL1WTZ8^bAXO,g:bHA-BZcH_D[;)]<)_HcLUHWca[X
NW^\cd#85<a@OA,dI697AM)JL^^\J#QZFT8H:eA4D(5)&)@;I6RcT#eb-LbV#I<0
]b><^<XGETOO38DCH1+?RK9^KK\:&T9G2I+5\+LR^6PAK--I>;dL6D(&_V^Ob?D1
F^D1;?_8]MH5.9HgU7Ke&eZ^3^<FK426V=a6]:A#JM#fe\,g&;CK^0,XRWIa_HDA
0A1bN80M.3DXdYa-;S85BNM@)gKK&9Q=;(,IVN<eX;YI]X]2I\@^^=@VOdDM3e;W
TKAc1X5NK4B0c\&CQZGGKW<EXS0[_:);B.Le]eVI2_E(g5bB+(;UB7,\,+eQW/9;
?DN@113#1;4HFPTg\\66g@Y.]1d^A.4Z>H\R@T^YMB&J?OD;U(Id^WeGN?PeUS+6
(0[A8)7+Hf.]c5.0S:9(cSNfS=HGM0FP-Yc74@V>O,(S([XXYWAVW]N+,0CEG(c@
eb^B9SLcc:f5((S7FAKKXF;[6VKA[1c\5Nb]RBV[F[[^/BgbUGcJb4YWK@4M-fRV
Wgc6c/]LHG[MT0WEcAa;BTMZO>LU+@3a:9dDg6)K4YeDNVF]I[\7X+B+ISbN]B7F
SfW2d5EN+,84K^UFb===dYB69.7523DQFb4NX9[SGJ:a)/LN(B7R_I8C_DBL8b#2
>+_NR8Z1AbPJ)PYOTaJD>6V88=T9Y&#];/2H?IX,FVNgPT:<&Ba28GIFJ=EIUWYI
3]:XAXRS\.gG#Q-:-Ac;;?fR8<b@D(XY>7UP98/4XIUgIFL8>(&\8[ZPO/<c:6C8
?J]1UKWMH(\Z2/D;#8=fdP51DJL6^2^H:b-^P5IIaFBU3(fI.9L:f2?HIN1.(R&b
B?)5@37G:T@b>URc-HZ)#2\(2&bPZ&?f3A)_N,/NAg_1+A<SOAR#]9.&P=R&QZI-
YA1V#?3OdZNbZ/A1;A;ea\/^YK2-&LQO;X:FQ11_2.^EMZRH8MW&]9DT8_\N6;,<
L)0Z2D[ga_Y-[PMFL4-FCX9O37S37@KV?Tag?g4/,@6[/BWg8e&(WM,<NU&dDeM.
<<@g8\6dA[0fLK3O<R,?V]VA33NM#HAHMG6\>NU_db]\ZD6D_@377-W.R44Y&;Sd
g7&Z_Bb5c.HdL=\MK5,W=)g<,X>ed3YZ5^5[]e?HGUMZED_)6#PRF]a/CWO33#_;
bfbDBY)Nb<2=R+5B,2,F],-FgZF8=464?@-.:5#3S32[2DZM.#PEYEU2)HV_f-==
K)G59M?6EbWSV.g95Z4B76L026F,HH?F[\W+aCCD6\,U,QPDa]cB^5dP.K=0c28=
TWHfI5#46:G90G)PY-\.:ET.5+#SNVb]G_7ABFSa_.6EQ)7RDeA7=d@7)C?CTDZ&
8GHOEQ1Z?G(>_a9J6_(\C0F(HbcCg^=.1LaG\dE?1FU:DQA[BS;]CDf2a))]-0F\
5aS0^aAB^Y7UG/ECY^O79,5P2@K5<V42^#6,BV]/0bX/>MI.,Sf\@]M[6c+=]?VJ
c)9Cg?W&dW26Y.=Na9H8K-W12#D1DI?/<22J8Ke<>(RCCUO\?T/G8^O\)H62]/Gc
UNVc?^]?.USd-\4TS_S&\^#U83a)A]FN>@-,(44N98G8_>SY1\3?N\cWT6=3[FCQ
f72AbKBRLL]@_6QKBg_N/HH.VUO-WeL)8644]eJ<#9OcIYQ]C8bI/VfbeSS+9:dD
(eFZ<8f-,6e^QV=AIc7\NQ:TYG:M]D,]6^3[O)OI2OOHB54GI<R)2;5Y+/PLb9[b
BA/W3L+)RUGHA,6G=ebN^63<g05IB1-]AdA?Z@U\UI7@?+#/XM4Y)H2_]6]JR-.\
6M_PPV3LCZ9R^CcAA1,>T6[8NF[1#=.Ib50g;(;S+g><(^T,>=aA4+H81[J(Q@7_
1BabC_M_J:9I+2]4^W#(@E1EagO=Y)10N,N[.EPc@.gRJ@LENHRRIIg]&B3(+G.@
\?E:3<?d_cW=R7TL\R/PUSBR\=1bC=g&FC975GK)=/DE+O?.PI==ZAga(g@8eb7:
cg.>DB+OXN)JKOD_+eZJ0JMX/\G\O:87<OJ0MENSfDQCQ9?H]?MgM4d&>B[W2a^C
8<2M6,c-J(7GRM57+Bc10=g^^ART?9J][:-QXb9[CKg?41H[4Q+S\9;3^Y40GUeN
RZ0J4>JE8GS4GL0@C/[T;b6;9HMSZ+A5US,_Y]F@D=]X2[/Q&eHVP6)@H<V+E<g(
)@8VQ>[H.dP2_b)fXRDAD1U?<_#+&;AbRVHg0Z\\+X.:1T+F3L\UM^bgC.<dXH,A
TZ&XRA^LQ/7MJ/-LRV8a;T&4Lc^g97A9<#]BEPKb[Ef&Ja7M7F>-#4Q7O)H7-J.?
SB;;dd.,>IJ]?3[9@-.X0L7a39@<>6:d_4Y]@M#[QJZKOF,10Q]0VKZA,+=Z]e#:
Y9/OO#+?TS]V2MA_YWW7<1@Q\=;@N<#@efgKg=G@\>,b2D>[gP_S63J>BC>=2]NU
L3Z;A=:-AQP4O]R2(@0f4JK+2S[N[<aAbJ2BQc:8;2LT87;[gJ\OCb712DTWW+?3
Z^H=Q\5CJJO?c([^OV81fP<aKBO\YPa6fN]Y0PTFNA268\FMg06,Xb=OE1(A<eW^
Yab,_DP^Qg4EH]1N8g(1T5N3YbA_W-4IUKNK?F<DA@D;<e46ISKJfcVV4O][7DG=
c49<+Y66JTe4:^a,9:N40;BH.Wgg>Q(OS/J=4<c/Gf6QKcW?]LO11FH910]c:+Y&
2c.e6T)9,U]Ec,NbdY,GFADG0VXM#S,(Ia+P4RcJ7A\PE@9aV?,#fOE8<N4,E->P
O82\=+IDbH5Z,bXD_)eF0,2Z_(\a-/Ad<>bCX2#]E@N&&^X8RE13f)R<aV^F=GCB
L/g5VdL/SFLU#V\GMbBS6HG3H=<9ObT)[CL83M8N+NIe;d8SRXUdbZ7Jg,[Q:KC<
C]PS/F+_^d2;7G>b:PeJZ4D)f?],KX+06fc>>DBD6YZ,e,^YU3WKF[6_?BJ_4d]^
R2FY>2f(;7#4T/Ge?c[XOW-_,5QWOENPE)05&8;-@4WJW2O=B.JHVUGAZA+ZRgUM
#g3@@<-.?VN[[,bHaS^XaO9B-@K@,JZJ]QCaKI8-:Q&2JEK=MEY6G7#9HQ\bFa\F
+ZVC)U/A8^QBJ)0O<6.L2P]cRQc.cc3G;\?FU/KS)aaBAP)Wd=7YU6D275gZ4)KN
,dPK-]UVF_MY25(\<b@0SE)RW,3eLF1_67/gRc2<QD5]GQ2@W6.OQ)GaIZ]UQ4\&
D7bME?/1Qa6()OE;@_DK+a>+W<JIdD@\3E5MBP7Z\I1O^+J(0G#<SY=O#S9&&+\_
+\.&3cc1C(7@4CI;,]+caI<#[)aX+_Fe.+XB3e\IdE&/Q=4#c9&)BbC,(M_J/UD_
aR+M7]6?P_9J<QNMLJ<-DEVU>9&]QQX80<cG4B#H)2B=JE=K-W,[FM?5g1c&Gc_A
D82HGXVM7+A8V-TK1-LKgD,+\_LH^.B<63W1AM>1Gef(D>PD3+A?a.1^MC/59f^b
W(09X#SX)[LRMP8)_<dS62K&JUQALgId,2Y\D:4-7cCM[[P1g+Y<-)E>IRTA;EdQ
K+gRDFYT#-A@IZ=#AAG;0@(\b-1c]9b8YaDRc6,M+\H,ZWB4bTaXf]P0WE)WBFC.
YZT@;NE_J#LE@AF]^P1gL<1P5EPK^1We,.NWR?T9UHTW.;TQT1NDD>2<]S0SY/,3
P&:_\f/[g/CV6F;F[gT\@B8@^FUd=RX,,]GL&eV_F5N>^3GJ?DYT?/)6O;-J4/e:
Mgb)gZC,LRc^.R1WPUN&O[J8YFHf[18LHL.EW[M:+4=]:R+\WdRQ]+Y;,0+O_d14
18c=UQZ.cf.+5#&<]0(;JI>4K=Y/f9.3@@dZDD_eLB\MH;.06\^Oa@9c]\c\=U,I
LEaP<-ZUUc2=6N1bdG;^)f&2>T#_(:-QP>;gR)^W?@96J[fH[[Fd\:W(>]=<NQW5
3/[A31-X<_P6&0e-N/Y3?1OOM237JN4YZVXN>GGc6\@Z=&S>BWZX+&5f\,:DdE99
:PSQN]8dOA3#<]TaB15ZLO;gTYPDd4AbEe2VKHbKSR)6BJRRSQD@7-7<0+NAUA-9
MIU@V;RRN;P00c6I([d&3e=_#?VR]Dae,W.1EedgK3#7)F1EQa5ZKb)4];/A1B_V
W==g5S&HWKN(dO\O8g?R#LXF@<?TPL\a+=D169,T+0YPK6XHG>-6Z9IcbBd4O3CO
,.]f\[C6?7b1=3PV?DF;^JO-(gMC=SOgD/476]7c8QRXK_Iaa^[K33&D#C7-cLeI
:,=729PUDG1@RJ]TaWG6c&:^&B=gXcA]4U>c]WCYeOG=,fP<<K(^C\H>Lf-IU]V2
OSGT9)4V.1b@egS>&;C4PP2Q<NCUdSG=,gHVL]PL.Y603+J5:1&Yc]@4bLGE]1SC
d-Z>.b;eA3&aC9.9679^I7J+Pe^]_0T9Ne68;_,gT#VIOU#:ODE-g_d<H#;0a/&7
c76Z&P06O;=^,6(WZFS<8J]dN5N98ZZ>6GMYA9]<cgQC8ZZAMHR)=bfI[F1C?/VN
\M90MTa(O0DHb<<bQSF\#H;]W(/81]J8?;c]8:;6O_84Fc0[ZfSW5c37F>LUfIST
>MA(>)AHY)g:JK[7/G\@N(#8<dHJYW3_Nb)VYIaX)W.NfLbX)1H@T/b/cQ525TfI
+UL6a3\HRGE,T-gH+a?gNN+<R9\cI@aO6dF?@@>DJI-+JGM@cFfP;aNIQFEX:7Tf
^)H[E2<&P^=7)S?cZ3\+8-/L-agbP6IFJg2+B^91@TQD=,CY4ZI;DCdT/S]XBI]J
@7O=;RD=0KA.(+Z_LO6YSLYEBF8VEHCbVEU8R]/XF@L;+BGb0)AO4MK6X3:^5_Jc
Fb\\M07dPGeQBR=&VO2^<S&P+1IJFd\ZM.Lf9+BaS50B]#7;X+_1?d&Xc9IcO5C;
:LQ]@[E;fX?0af>DOY0<KDEaHe<D_EdVLVP_U;Le).,.Y<I?&>DTK_UATa)YS6d6
&0BR]R^GYfb03=7.1Q^6Z:?U\K@\]./HO<^B<dM3cE\0OX61GaC:e5Igg,5LeR1E
-I39\#3IZ2[dEe>+-,4-D;B>fW0;cDJYUPD6A_+V/#])DKaJY?,_KHcfHbX;MN;\
M,f_=3Y(&;cBJ;LJgW5)=[,E43RBS2C8+PIbLO]LXQWENb<0QeFOcVEHJLMFP;b\
f;L+^(2MUR<IP)HQ?HI(SAZEDPaNHM045F:I^5ALRE-Vc0:6;Y(DTDKG[&Ec<@+J
YAAHV+^:)(eH]9A9+3cFRI&[#R;0]XCf7Z[cX8@Z/EU306VR=OE;H=G0aFLY2=@#
CE7FEVXU-#7)T\.16JQUJW/KW3.J\.7^V1O494:XT<[=;TOI/df\@MZ^4_bK#NU8
5G\()Y^^Db]aI2,F8e<O2K63<B0Aa?5AK,YG6=)&2+bD>GbO,ZPPgCJ2Sc0Y&4dd
:JP4PKUQ?HMV+()eKeC/98;)961Rc2KWJ_JCG@IDN7<U92^.GJ1<f.AV6(7TH9^Z
K>.B10H_6T)0UA;7\WYAC(0R?J90LMGf_cP2?[aG[/CHLa=S&[Q-;RfV[[FVb#Y/
dR::R(AfT0UfAQVAeD]XKg2Z31SWXW;2DP6)BZ,R0a=VAC<XRRU18-GXT^#d((9(
]:&+43f[5\[65IWN7O3[B\G,458+[XVC.d^967R@=/@>FG#RMX)@7>1:cf6:2L.a
7]FfVX[76c@9@(CD1gSZPD;8YXa/VS0U^VW/UYJ1](bMT7,8?J<F#@I:;4Y1QI/Z
cc;RN99-&a9&Z[bS@KVBEOG+7>cDg[?Z76L>]+>f=fTTD&S4fd,??]L7.d<#;8FS
-]APSM.>PdYP]P_>)>C]]2-T^Y80O\4.TY.6,N#I5=gISH:F+FC(YMBM]D,@A7)V
FaG#YAHFZWG[\1I[W7M+\GW5P]>?-dG-I.Z:gcWH6C+<8_J3##6/W#GXW?b<6MI]
De_GN2Y[R9PV33WB4OJ5BXX:GWf+Yb1c9f@QIBSe7Y_]KY?(.(NaO++Le)(.4W+b
)Qbg)@QJ_+L.,]H>,#N^)b(V/L>8,JLHC;KGGMP@e<aXc1]DLg[=91f.QT-O,>4S
fP4SXWI,SP9;YAcFNO3,[IIZC/7CP1;+C7LSgP-9;a_913RMT]eaOf=.6fW=Se:H
DULY<4L13PL1P4[SUTOR?Y(-He,@0U/E6Sb@K>d1E:-L97)@K^JSV<eIZ^#ff-E?
5g@6c^O]b=:.XKKGdR=gB],4=Q:F:8I?H3eE>S(CTS1RT>OQ>.K>S1&b-a6gV8).
GcW_U+I^76c/UOVB.7a6I#LG>WbSJ0(N6bTL-9gGH8]ZT#WMe]bEFBc5E)[K38b(
;G]X0PX.CO(-eg4:.10c6C057>>8WD\WG4&\:C#d3<]Ia96B8e#[gW5^3Z/@X(5W
>>aWc:/_RLbOR6XVD^EeKeP^EY6]MI.f9KfNV</_/3ZI]/O#4)PMT39#NM^4eP5T
W;<9/G&PT)E-R^.)2GRD=V=7RDMV_9b,0G3_dL[-/];K:eD@]H&dE=CY_JN=2L9K
>NNQ+>PZY+J,DY@=AGJ+e@5fML&d:ecQ+NT_?.cXM3CVF8^UBK?gOI@2LP#1f(#[
8ffP<EWPXe&&JH(OYQ/@#&_R19V@57R4A<,(V.U)WG96eHIV)Y2TT-_7>]JJ^FMT
IMWR,91VGIb9QgfVY8Z892JXWNV]D-XKW=22b&^#cQg(SDII=11ZG#CE\DBM^?8&
XL,-Gf+eAa-cd./51@N]aY;B3acUG);-W-O7Y(JXfNb>bfSaGbHI?F@0P/e:KNSG
7AH7NU7MQREWa_S2TB[D1d@?4TYaYebE<Rf:-A\1b]PU/&A3)<Pd)B:/)d+b38e.
\.C>:#1D>IO1T7f=&U(XY_TW]YA4cfdU38eZ::D,H7Y^#/XGTRPfWF(@9HY[&0N?
?LF(#,:;;S([BW+?<F\b&X</(da[)CRI/\5_L3QKKGO3cATg>28AKG<-.Ud.,fI[
CJ7#GID;.eQKY;2d[/Pgdf>I[N1BDaP29,O0/8EN@587Yd/^-CZ-Vb(5,_2fFGA3
H,7F4:^Z-KJbTFI,53F/T#H&)7FW0c2FSBWF[/.E/C)cL;]Z;#^gH4NMIP?YF=.5
^,g8IT75>@D#VE^0T]BN4G;>9/K5)L/QF((11PA=/^X.W^M^6-U6#6MdJ;c-M\@=
+6\54>TcKTHL;SGN.=^NO&KPO/RK#e4.@+O?.Fe>66#?()S<F5Dg0<SP:5AeDG3]
M6QBB\K0NV4#aB?Xd_622\F1/L#I^G&KYP]Jc,6JJT4EHB>.5+H9eRGa-,_V+JY/
7.;dRS99#6J;H[CCH]CYd)gGK.>;X3<LM<bPQJ\TJA/U3J+^9496Rc2I=+=0#<FC
W-PI?5L)dV8YET<L-MBgLZSHAAJSg7\)T4DPd_^MY;P5L3[[Q2:WX3W5@/I/6G^I
;;+9cc:^4RH8:I.ag2D9J52WY7J60>.c#EI,64C>T[)eND6P<N)Y?8?DA\/aSJg5
.9HdbL\2_XM2:dO&Jc?#FNe\)9g(3B=J&)AeK=c;7gId[8R47,W:+L>Q6+62>#>C
DB7eOebYRM1,C6NMLf]=6JE]d)VXI/&P6<(GK8M1.LMNA-;<[&XSQ1#f[H3=[BR-
\0P9f4>:V2FD2^T\\U6D6.)EG0IGF0RK^+8fZ_c,U1gUN6<AVE1\9-MY34Pg)OD<
+(2]Q66@N6&>YG/aCc_[SGA-45M0D)ceZ(WD(OP;:1^?d2cTLTF7,L&\P/CfA=PQ
@1^D&A9&+E.fKG(gN;;5(.9/-Y@4VTMCgCFZO^A4-I)8)7I)[S6>GTVJaM,Ae.=,
V5V(X_&g(@X-P<6OP&JE^[+G\g6UY)2Tc/3bUW2M1<)@]\gDXe:=HQ58(NO1/fe4
Yg)?b7^H^e1E@5ge>CdPgc0L?Y]XXDYZ7:U;\2cU)EBMUe_NZ60)[E)T;0X6N1TN
?\Mf^@,J#Xf/8+7.:@Fe/0B+46P8\F:),fSf2cE?aYB9dZfM=?DP4]<99Yge&XVT
8JRTfI\X).OSZ,XAP<B<HJD>)LD(L.HAV#D3EO0<e#;6+Qb_fHF5daf4fO]G]f@f
fF#WI7bB<7B9Ka\9d8L&,fI2L=YTFRfNZPfM61I2I+844g=d@R=d&McdI#\6/+_G
J;(]YCW-V8?EG#\N/2#V#d4QZ.=SWScS5HII>>Hea2F>@@?e7>NVN^&^DS>9V-^W
#]/XDL76G]c@<&\/#gBJ-49_D15]U.f,7#=:9.HT<gNA_;L-#.S5CcHIE[#;b<Z2
O1f\Q8+\a&a&B1Gb0B_U/aH30:=_IGASY]^^/-ROba(ID/8C+4A&b>FZI^)DLVef
T\Q3)]?T&D_).]B[[SA;NG7\PcY0#.J:H#=6@\4,=)<V+JYGgg6K><W31g+:3DW(
cXdO,@\0V<0G#@0E(Vf?&&US^eVJ]F\VAEIHT.g,TKUd#E>(_.BA_Q1JH(fb#7HX
\dRKae5/Y?fW3R>&Ke\PFeK9K4bL3fWL;G6aRR?YD<aS6(WKL&SJGQTP+X.VI@PG
=UF(NNZ?8\M(,WMaAf]-.V3]d3IQ_:X5K+d.a5Q-M1<RI1\(EH8GI42f,GO#_[\<
K?-6J<-L)Y22L7(?7DbOG_R-Q2ZS:70.\8>I(\08fLI_MX00?;H)^&9f:N&-eB1g
UP9H9:_.1:,d5E3H9a+72[EW4CEEJ[O(F.HG1\[+0X1AC>]\IW\XR5M86:E8=9&K
#FC-:N9RJS?NQ,NH-0AXAgaYNP4OHPL3BG8.#=W^)ZD3\[=N=^Zab]H\RH#ZJJ#6
T?N2QQ?bda)b_9L_)_7;W>.J>/U@F=PQ^]FaeC5H>#O/MVQW+\Xc:=NNDZeSY_LE
[,Y9d0^8,Y7/>c27SOZTc?aaFW4ed2[;@^4=B8V4fC8E++CWI#_5GAD8?(_QMKcg
IA&&MT)ReIJU6]gHK?6:<C\3:WTZAXTCVVD.L_+S9(DLD-eEP4)AabOBH4516<)H
BP9>KN;/T.&E^V0.C>MV<2T/?7X3TQce0;VS/@0P6@:)JA0YCP1_aOI&)NY<^&C2
5=CE[aPG51HHTb/D,(C#1W6\9>C.+#^3bMS30L\<d[W1:Me)WNRVWAZ7Y?Td7;^2
\)WZgd<9ZL(33U\eKO3_=d8O3<D3V+E],_39Nf^g&=(e+]A&3eX5L/9NgVOQ:XJ=
^#Y1=aZ7VdCGG)^F4W)+ac,P-eEcd,GYL2H5eLD6KUg\=8e)H&^c93]BD826SVU6
ZdQ;/3S:1R@+M:?QHEP3W7g9L?KaaQ_4.2?KWCQfDO5_f(aAM@0<]ROa^P&^/AWI
#e5FB6gQ9bPGUX6C>T.6AcfPEP2,MJS>a\+JNAS)MEE\.U7Ib.-P.[7_bEP48C,g
@f?b0/AG\VFBKAf8HbB5S.IgWfSQ1_&Wa2B=#N<OSO+1;&FNF?^+6(PP581P);bD
S&I&<MR0+OYZ:\2\[)WP]L&Zbeb8UIM([SK#_O37CSQ=dMeKC7RPg8?C7Xc:<G\?
O=9=SfXDfHDVQ>Y7]HEaaACSB&]</;fgFNHBG\GO-a4.?.aMP3C#Wg/AOX[O#gVY
Za:T9T5-8E^KbbV=c,83fDFNHccAA8HAK/D_@2g.@YD;V&[-.U?N>BJ[U9]Y(99:
@?H&@PBB@10=Z7_-fL,RB<C^VE6)H5@O)SP3ZBFDe:?;>ZE#^N7U#>UR-E,>J-5,
6c?Y:GLH,I\(<;(_E.9K^Y8aZW347VI/IF08NaO6/X+ba1.ZF@E-fbX-FC+6EJcV
d,QZb[;<0OL#Qa\](N7?]P[YLZb1(3NIKW;T7OU?I:<GPQN>AIRdQe.;2#@?MYdb
<1@2DaD?LO<3CLf+W+FbS<S]Of/VFNZ-6)(f01;c7:K76H^e6HSF,Z>X14ee3.(+
>J3Y6IO13a;QGLW?M/TG5I>YYXZ^&N8+MbP-f7b1/&\_2bf8HQ?.1bY>?VU^4P^W
[_ISQD6I#[IG[EPcOFAZfc<;?dbHeW[^C<?WSa#IT1aaWLO:Y.R-JUY?6f(-<)^:
?:g]2[Xc.E-c<(^f7c1XUWd>O/baQTdTOYd#6e6a(F(bN1CI[X0]S0,HTBM&.NfD
EGFDEgWU)U4,cDJ=HT<NeS/43_3D3;^9)6--6_dH[B&76JD0ZR3K4&7C5(>,8QAX
XR#Z?#dK9260W6H.a#?HQ/eUO@6FA+@W^?.QgW40SX:2=5dYABEVLV98e9YU^SZN
G4STK8?G,@U75<A;SDI#3PPa[QIG1.D[[eXOKg842?<5I3]^#]=./C>]98G\YYG:
PSc[cH6e:.J@\b3THQ]@1U,?#CCV^gG1Ad@g+9NEEYB34&G2CVGBIId85a?B?JGS
IV^L?4GIfCRJ\cZcZHYCPOR<6@=?9.65ab)K6>[HP\O7gI\IH_GdZ9(DWX3E@>,J
3?fJd4X@2(EI@]V+c0W.\aWC1PI\U\A&Kf_XbH6gN98Rb1YM5YI86:\(De=CZ;T[
X8#V&#TYM+9;<Z?Q=>g7#@S;_T/(bRKL03C_[7]6XNK+a#YN?-PI\3Ha\P[aSgV4
Q>LP1Jfc5Z63<6B(ICd)PL2PYb[Q0G3J#.SY8[19dDY0_@H;<a,^IT>XHR6FH+Dc
0#:O2>B(21XC4;1MN&0IK]9.54RD0Q-L)&OU8](+@?\32[b]#34c3a3>P+IS(&dF
d;Da-f-T@.VKHID9:FY:5>RIW-4@AU6,D[31UA8Tf^KAA5_/Z6Ig[,9J\+SS_A@c
Re\)P,U>:1He>9JB_RW;U?]BP9)dfOead,f@^&2HfSFgX,Ec>-XEF@?;76?+=T+B
Gcg0[VIIK@=K:8J/DNgg2C/]H(4YM5VOD4)5VMC^:#7MN4V@@P/\c[325RK4@R\O
3Gb,Y6dVWSQ\&^\C\Z6;cW@>,<0&(XXYf<S<?SU2?H41;Od^)c&XP@;GZT<(9[;E
44VUa+S135)+27A)WR?MdSS-^^;JdCJ)Rb<=DaDNa4T;&CVW);LDDQ@K\c^[f4Y1
OaCRW&B.EU\J71>/&e/YQ=RaYe-?b+R(R,)8MR38KdRR;S^c_NC7CSE>IP<^,Q@]
TLC9_CB]&6,NV+W.[T7f(>\&dP#aHc7,c&gc,O##Fg&@A5D=Z(FL^+)V5Q[>;SR#
=+HHYJJ<&X:&ZN-Q_Y1c_S>[-Z^.>:=b>e(72GFZ.c[ePe[MC(-5G5<;X_IfaU(T
&G-\_DZRF0>d^1b;YU\a4K81e;HJ@GAIF(&:P(BNWL3UfI61S8HFB:+GEY.C4AZ;
8V8HfOe+;>?YK_5O;M7J9)PODQ?U6NZ8,,)U&)AY.X>G307#1D4)1D9R;M,4A;5>
N16,,4VI5dM5#[C])a2FbDYDR>6]EYZABdN^J.WDT@:+S#5@3?>20RFb@LS,R^O)
b,=E#TH?L//4Fd_83NK^g<#gQ9G=A@;L;GJM7\\^I#=ML:P<5H[d=7K1UFV5T7I(
/#UDB5M1]AL2Qgg)0TV@O]XA,)?ZI1+C>#6(QQQDQW=[WEM4IbeH.:6<])0CSE^)
J\BQXcZTcN5;fI>1-:>J7V5N(O,PGVJ)50W[XdBYSfR_FgHVFZT@UP);9KaeDI.3
.MS4RG3;_;3TPG:D?Ad2..9+g[#[MgeOUg=;SWV.3++5>4&>6b&]J=g7XL1(RQ\f
6Z&8UT)BQ4aWWM-=0GOB<2O_5d1M@7ZTWL+a28LQ)1J&R^Q;+G6;J_gWeP;LRf9P
BUCF>?gN3bSV@d=HK:ODfNH9c3R8WGg0LYJbf[&.=#+:43gcRZ/KWFA>6[&-g0I/
d,-5BeXJBOd4b#?&,+T5[aL\YIRNGSf)EZ@^V=7Q_^S;;aF+cE(2&5VI]:c-LJd-
)a]6LXCO6XFQ/B&)Ya(d#e]/:..KU=Hce5>>fa8]]@&=gYBPYNY/g<]4I7&0^4CU
(HASC4P8^3DG/HeV52+#N5:HWGQ>]d6c7;9f/X&A(_CaT&#?BKC<(eeV6ER_)HeJ
1VVcIO[SVMS=UgAT98Pf81CL\eaKG/_PO+WBfMZ:1<SWZb_CKUMd987UZQ/#Zb\b
/=fJLYLCQTQG#]c<KLZD,(N4G@HAY\8V+bKTIBDe4eU,LU54Cd:Uad9VO-J\K9c+
?,Q/--()AZI9M[LYc\eb>3)9^NZ,aK[\<4_DMcVZ+E9C2(\,MWXZWR]#4\d+S?Hf
&]gOI6U-KUA6ST&4[ZC^[&-OB+,fdT\DH#B]YEH<94X@\N],eQN_&eZX/:daU0dQ
8\JecYI2\G.,>=Y@HVaECPZKe-NNPgKQ_DbPGDU7b4]3NT7&P^WXT;N<^-/)/@QA
H>JZNCLKd?T7KQ>.EeZXA2>F)gQ-ZHb1Z-32a\dB6#MBR].TK93cVBGA;IOA>--;
G8_c#VAO:fM5?6]1+=aKQbG..6S()4YF:@D3BD0eaC_+)3X7[^E<a7ZB^WGQ&g/U
Ibe@7PG9cGe/6<;119V79K87E.7/C=H5Qd09PO8&R29cBO,>D^B0+/@6M2[>G6]I
2(>\,B7[W-JUEMKO4Za?WA<X^C4gX^\O&O<ME7[HT]A/IU?0<WR__V10->I(<UF&
Ff9fce4G0NIUH[,L;<>ceKF5ZBY=G(BcF/T#.J6R5,OQZZ3/WCd+Y<G_R=^2e->E
QVIF]a12Y.d/>UGU<45g&ARM@03;2=7SJWda(^,.,HO.-DDI._@L=GVT;bM,-COJ
<WX#Rad]S?#_Y+VO9e?;DGOHYLF@)a1TaNW>\^d#D0<1,,T3^5@Ofc-9eZUe.8a&
0[^FK_BJY.3W4\.I(L<T0dB(W?HAP-JB/;?VV]K<[a<69CH/_H2GHH)J^Ne<^e+F
\deG?JB\>2^Nf(2Q\g?>DFI-^N3b[AC6C2Q3V5I@T5:()IVZ/<[9ZN9]cUMW6W>/
d3BbIE>VG9=[D<\,+RWdQaWE?=_5@2HFUW,V=6YOb?=:g_1LDL1C,+@&>bP<bMbR
.5G77IdHI=0fFE\IdE;UdIGB)g[?OCd+.S,+,0[<<c;XDgf>\Z:)ea9FN..V@38J
LJg_J#OdTZ^<Q41]J&W(QTB3UTV=dLVTM)dIaPFdNPLbR[[;\5H:G:Cd.Q9=Xe=P
-2T/Q[@]CfM,a[F14,bcHfE_.-NY0Q^5-F^35HC\LOa+M4I):](I.KW]7UK^c3Q5
A6afUDK^H^G/e188<c3G8dL&&:;@;1YdPffd)WD\6O;,8J/>?)TAO8;KD+;IV_S[
](21#+9fX32T6>\a7[5MdYNaHbQ9U0_9/@JaQRQU>SJ_]H&##?UD:^)KL,V4A#3g
IZBEQ-9fbg4O<.XMER\WOg7<SBZ5EF+#[C3U_?#(?#JH[:.A5eSEZ_TC?^I8Cg55
a1Q-Ng=aM2#J=52B[Q90fE:.:&+5)UL#Fg::SXAWWdR23f)C(7MIdX+I2SBFb<)5
&DWT,9R@4;:/O[[OaD_]5@Qd1Z\YPSAUH;P;L[RKf9:G+]VJ41<0U?1g(b^H(CTC
?;bRAdZGLWFJDUDMW2&BL\([MNRRBeB[cWH7BLc(1X=@^I,):DHB[K5:e_Vb(YCB
]F>L\]I>R\I/V7>5=SM3ZLD5<)RCbI70cMg?;/A@GG<-2aHH70^#[D)<bD5=YDbf
Y-7e]A^4ZF<f4M@I#5cbD0XE(_:\9F/0;YaGNAAV628\+7+Z02\#K6CLQQV#gKFG
MAFE^K#72Sd=dCE[f?c0T0a0S;B\;312&f&THG(FLb61WVIZc>dVg,-Zd.(>DR/_
41AgOF#>AD@-OO:J@_Rd@VJT4)0?NP>X=b]TZ^CaB5(g^S/^IQE^)MW9D6Q#aEg)
TEF>[WZ,U<6dJDO8<P0=Wd=G[d7K/WA#65a8:DS1SH>O6P5;GNFTe(._RO/5eW^6
XX]C,H4N;:&Z.F\&D\I[B.;7IW?OaA?]4GB.d+<<2]2Ia,@(c(T(AJ<<<IJOIbJP
.6f3I>>)@H2W=/(&fe0Y;bffKeST_YT>Xc;#/:+T-d+-93SRe48LR#fbb25Ie31K
K)>0BcaDM<W?F]+_AeW\ODg,N_AQ6,-2>2gA+L3GDg<RXD\7HO?Jc2.]YW91:T;>
07c-@MSS3G/=M4W:eA\?T)PI))77J.?f0P^??G\.d<_N8&d;HU8HR>dWE0a?dWO2
SIba:&QZU#2JY^7+1JRIEgIg26(-a]]OS=D^c#-)ZL65^S+fa+R^Q^B97>HQ(U9D
Gbc=B=V]BUTd2];97P-MO(0/#M=_P4NBeH[>Xd8(@@ECD_4QA9PT--.(EP?4#6I<
e&SP[[b;^\Afdf(O@#)fYA-\+LF;,^+H1;9aOUPea8g.NT2e&:7Z4e(^&90@PRZ9
g2RIK5TEDR;&UQZb@#K-V?1JA1[GCTaZ#-_]^AO-EPg8c.]PNBTY?HVD8-,SQ^8I
:W+>G.CB._B:4Z7TV0J1>6-_,?5>K1Eb;<g8WMPF^.J:M<-CC7DXN@C&WMdP&A:U
;Kf3d2RB4SaHWa1>OWgE.#5BJ-11&PGNb:ODI98gP&,^<P^N&+,MCZ>:MgReE;>Q
^0+B<;O?2NX)K@7W?\]:\HVG;JOMY3Y80\e7IM6eL+M_L5SLd[H4>UM)=Oa^B+A#
#dF8^A8Nc&B(\;-Q77P?,7+2^JQeTIVN5N,,XRGe^<TTFR>G2I/,_7LTNa.>IMf?
3TC-0-L&JVQH?_a&O.UG53T[TcM11:W.-[ENZT0#_2QII/XT5PB_(NZaN/K6[--F
\OSeJ331@-RW7IC>ZA//2>f7e@Ya1QW\L0X#E6TSR9MgHDKgUVK)(Y.4:be[=]fL
A#eR=(Ld#_4(#f[JKUU:S5D+IWH-WeQD,J,KdOE\gFS+ec^3OeMMS;^c//B]fL<9
D9:\]61VS,STc=f7@D?=N_ZU1QPT7GFa=KJ[6HP6;J;bceVO+ESNDe2G8V2I=IG=
\JIfd@8MJV+fLU.ZYH=E\WU8G:LF9e5V)07@/&<&P5A]9AN[W=[@K\3eB&P6\4O+
2.bcD?32DPf2QX#Y+0-11fG=-H8&12;[W]?)7+28?6VW8>K?VK0dVAg;_c#EE).c
FbHCfS<-ReICYKU3f>,LbH]LX@3QOa3c0URB-&3KPQ4<8E>T&;)7[R=.5VY7=b31
=4.I<E_:dXCSDA[3B+]\2VG=,X9EIg_0:5bI;cU,+=]937[eW_[O#8J<gG,5SNB(
Ad6W3:[=23/_FDZ]2ccB\G^O]=]WSbc(F<M=BFMFA6E/feQ=PdSYZI?;cEGNYD53
g10+PJ1WfAOH#8T]1VF[HF\Ug3_Y<T(0g[8&b_I,QW7R\Mf9QM:^#Ccd71,CaL65
4)RWdI5^QD-N6EIDI03dE[0T2F155B)[F:=/E:_:+=P#^,d[[S(:0>V1[L+JVK=\
d8;V6>6[?+:-D#<\AXgOFPXfDC+dDW&7II79VM_?_?O:A.X_CC.FY#0Z]3R1#,WS
4X4/e^ZV.=LB9Q-&O,L\\4\H,gJF#T>(?GX3_0Ga4Q6RT5Y7\?,7dXWWI_d95+I>
T([AQ-BE7?bAC)3L,S9+bM2WH[bM3S2b>+ZZL9)M5=L&KOgN/Q7-TLYQY2Z.+cX0
4VZ[F-DEQ?B,74IO^X])EYN,\H\-4=N3/,G(JN66gNCTIW)JR@<9dASMO_Y<?H@F
.EdYV>Z:9[Be-GJ>R5+2e\+#7=-;OE+E4H^1f+Q8/a/@(Ja1e4b3VJRO<f>7+3Kc
2ZB)XL3]b&=2TZ2@KZ4^0.6Tc1-&F9fTYRe:8.7\_FE305VNO97gNMJH2>V:#W+a
3WaCJ7JLG080&8GU8Vc;,Zd7WM-4Ta?3FgS0B/@P3WQKa.#c8&eI&eN,A^-AH^[Z
-8M-2[[@D0;DI8+WGMH-&f^@+:KdZ,GA8eQ0)+.bSH.VB,?fE+B;Z/3O6F/g/Za3
/6U@(6DJ].[d0)ef:ea&g<-8S.,.TV(N,IAA^U[,<Ef4>YL#5O7Za?:2,R3ZA4@&
&SS2C5aROJ,XULT_#Z568[)g4OJ:4-d:V.=bHX5_T3+77A2ZdCf([VM<f/5B_W5<
[P:E[Cc?-OW/bJ8Rdb,FgG_4]&;1IF<a&-?9Bg>,.>G7=D[C6+47YPL<_GI4T5XH
bb5Me7\RW[[c/6;#baK>C@/,0;f\2eGPE2X27]F&>RI+b0=Q>cG26<(RfFNG#fQS
LC791H<<:C6cYM^1>_5Lad#PPA6ZXDgaL&g:,82G=.,R1RD0,X]=,I0f1/1LC7bE
AAN^Vc@1+EDcZK/IDG.-DAS9IbYDSA.@0Z@[@STIB67dFW5bBV3^[T8ZJ4L3a/[7
@TXP(<B-M1a6f=\bBE52A[;GOM2WT8B(-]R;H61ZG30=JSRXdX]&PLL+F6#Z+b8B
[9SH\S#g3fT4JIf,[>ZD^N7M_1gI=QB<=Sb?.+dO.UKQ><3>Pb#)8LJgXV)V\I]9
@CRXTP/V1FWK^H1TUTcZHVLBFSEAXP,;U>TSOBVKU#@1:-+WK8DNFH^^)Y)W,.A7
gUe7/SM]ZU2F\+>.,JB;]FJL59IF4<;Y+V2e+g<T=b_e0a\>MME5M6J6IDY,,17)
>;5OTYQaYG.LM21:b=A&YEN@69XF#d0KD.K5R:gQI7,e1/gK:?SU3[&SKRAZI6J5
5(PP[/BC)JN=2@,A.1a2P2<-/Ud42QART;B#9ELcg-^M2<:W28C2Q&^&RZ+@\I+I
4H[[,36XRLFc(ULDD5827/Q2F9]&Kd(cOFV]2^E:C&,?KN:[,\LQ,#Q9@J:[25+1
AT5EX??gf4[];EDNg\S<CB>RRCd<.79ZFX2GJ>?@]W:;\cEGM6#3Qg/)\LM(aMdd
9I>LT@1-^B+A8H>H=G5,ORG&S:DIT8.;P3G;?U)W3/Y2:S44bW15H+B0b0:F+IO4
L^[[QJO5SYCV9?5F=9fLbCEc//ZU5T++d.QeF<VJa4La[Z2T(#WL2.cg5gf)<Q4J
].XFW@>,VCY4aP@@RZU5YOJD@RLOWVM@0LXf)PBZ1YE3FQS[/3FSNK9V#2]=(CCL
.4_g4D4@V?7MIO@[^W3804O0.9(E6V7GQ;^J=DR&>0JJ)I?N8V0_a(_?2g6Ae79T
d&B=6]I;Ncb,]U4JC<^HE+]:]RHL,f+b;V?YdLZ+a>@WU0+?P8)X432;P#[\CJ2G
=Q^f\[3E2,@K;Y-TWG9ec/B[V:C[HCT30BT),M>ag&#+Za,2YDXSH\QMeGU^X[]&
20C;O8=Uf+17<.P1SVJ_#0>.cX-<W3(/PX<:[8DJ_M.R/=7ZY\[&(CST^.HB)Y(9
R<+/9U.=>)9\1,6?IM(@c@DG3KUCge9X\+NFX45DPX8^,1(0C@DRSB(RNJ6.+\1@
=/[O2+KNGHd=/TR<Xfc>[(/F+]da;E3WA#WO6a/E\/CW#F:GU4)/>RJd[dUQg6W&
SJUDIF#3/A/CJK2(N\[[G>^BC(R6=EUR-)Y^Q6XMd+@3Qb46@>\+KTM.X01C@;K7
Q0X_c3I;VT<+B?4(\4Ia(4e3dD&;WT,+D@469>:>1_e?SWHCW(N8_WO3dcS\e-]4
Q^\@0H]X]_9ZO<ge1#M?^73_K&XMA>,3F5_#^L\/c>=M;Q[+e@aUdS<.5^I=MeeD
WZ&_L4I&5RMEH_-NBT;ab)08Jd.2QY#YSO8<VG=D_Y<NHKcN^4NEY@2U=cWIb&48
Y(^--gO.FY2dO,OZQKeGR_,.T:5gc3dY6AJ-3XIU+<aY?;cPFZ7]4A+f[g<45FJG
WCa1(Te&\bQP-GE\L,<&K@BbgZ<>D]E#W_b_2eVM4HE7QgZdR6_KWe.1/K>=.^T_
5J&@B(.ObNN@I^cQ5e1P[G<=XSQCP=1>B2&4L>VTb3R.aa8#@UCITS?BE;OX\8-8
BZZYeR\2#R2\aT,<6CX#N3Kc.@F8?/a9#\Z_bST1F&,>Uf>IYC[WPZSU[<RW)\Yb
W(ed^#]7<BQ-.T+9MaYcF-cHV<VPg=8X?5H7Q(-N+ATTWNbWGL8+A@&BM3D:M,2B
YI3_2_=R7D=6#LJ<K5&+QITGI]D:B1_HAOeLCS.^D??;A)ZM-?=J[YY]38&;TQ5d
+S[.SR,4=E=K-fDOFNFVX+#WD;3GS5::&\]4gg5/[W<cA51dMH>@LFcReI;0V8]Z
&f0>5d\S9KP3?HDIfZ0HOTC9C2;J=fKARAdO-AZPA4?,7.Ia>:UT1;#KH99b-;=6
G9Q=#Q(1=/+ECZ^H#&63/I^Y>PBd[S44FGSG39)GLT9DNULfNScFabc<:B7cK\Ab
7.8dFWFGZ4X:X+R=c1#LV-YD/B&ZGQUIQ.M(:.<5(UOV8K<)(^RN<#]B1</LdB]e
VJDGbH[LP3H),QP(^+4AZ9]K<5=9[]@/)NYL;>I@=d]DG&cX:9+ggKJI.AE.))f-
3DIE.OOUZ]+-:-DeeB792F)AP&[@5dC#H4aP5@[\g+dd-UB>JE[.<+9>5->6O+BW
GUPQ[QCHS2=JEPFaQA?/LD4V,WdX<P8U9&R-J[bTEbe]fRHDXM+c<F:9#WaMa]g[
EGCP9CIa=JN)aTaG^S+F+[SR;?PR,_-24g1,DOgQD>d2QgKD;]HXBYIBYPWOY#8W
GH-MKP;=&NWQ<@dZOf=)2fEQa_;Z=W^\Je#KX7;ecOASFT:35fZ:b0113#69\F&g
D(ZQE-2I,cS4T]a:WY?T[XSG??c1KT=B6b5DK5U,Z5;R=/?1<Q-U:AYcO4/\^WcN
,HHdXR=+CD(;(,))/A0FEN>D6H5D9OGQ^L2:WR+cGE]URf2Z-?D-^C2WHD8EPAH1
;&;AG9X<G/.S82IL).71/D(\\YV=,G#<-4H4[;YC6CX-4]-U0NKK1gfcL.D:3GTb
g-D/Z8;G/5]Q+aOTD?==<\V&N9g^OTeF_@c75;1Z6[]<YP2]SP6<2UQ@B[g8g7@b
>:Tb)/ILFA[H=-)-]VN2Z.37KS&(gfN86FI,eT=FRA/22/,cHGg<JJW<ge7Df0Z1
\Q@R8P+_,,a7#&,[3;/>#=BS,Lg^&0V>MYc;#b7W?eT4],9U8<VddUH;GGB?#0=f
5WP,-6L+4HZI^U86g2a(eOW([DHG-bM9T:Y-]O7<4_+Xg66;dUUD1P.f2H1\9+_1
I]2>00U,ANdX)_W#/ZR-ZTJ?Uf+=E/DGb.G<K)[bN[bCA[II?(PMVaRO&ODSZcW5
bQ04^Z+c(#W;ScV@Y;(5gEKc5^DZ_00>H9<0f=/E85EGdBg0ge4^3.7NH&#,bASR
YJW<P;XSD((1HE245KJZ14g<DP(;Z5,7eNB#AEOe[@P8gA+=73_K.4G-bf,UdK6:
ZM)LRW66HP7gAM@WW[Q=Z=GIWD2B(T==.e/8QfFAgI#aK4&S#<YPHD>X&3)?XG9>
M^-K)#D.BH<.1^Y,YQIIR<2GQC;K@W[=>I.WZBgKQa2P#\,[5T[8)8J/#[C]Vc+C
68aH1c:OVXYJJVLR@EQfX9:(M@HOY@\8RD^Ug&dc\)PZ;c:>O.IRe4/gc:7V,Y5&
-]@3>]<1I[#;8E^G04V>,@F,N7PO;G(_0D#3a;4WP+g?RWeN^N>\7HU1^D6L&^4W
@B;E<+#Y._CcTW]>;KCeA\H6A-g@H3/3^FUR6R;Lc/Z5PQe#R_>3-1FDGd^a6\B[
^6C?cb4(^>=/7TCVff>N#AOY/0Ub1Cc#Z7K#QHI3X9WZX2eVPcY@1(E^OE^?0FF:
d@bY&2I\;T3d?2?TPf[WP?)^97-->W+9VGFCRG[>Oe<)V?V#]TH3;GFSb[(SW34)
Ce2e=H/e.3Q0L38+F@,7C-@=caY<>(7g0,)P1];g?ND86XB9E\P[EBgXE09Ec@g=
-U@2TV)EcSf,I+K#W0/Ua)H[P&I[2+eIfYWE>YX9e9SQ]33R_85)^d^O^C/6eR3V
GN12\P.2@^YM)UNOI6UG6XO)2)P8FYHcJ\T+;3bNV=N15T8JfTTZdW#2D;H,HZ@E
?T-d->V1/?C(\IFW)(LLNQI0DXcedXc\0CE]W]^I1N<TC_]3.2dBJV0V1Ba_H.B,
G(4&_H49J82/?&G&2;f@>Q2&H/6884PbB5@WQIfIIBK?R^g(gO,GQ^G:G0A[[Pe3
[d)P-b7bTV<O&Q]];TbI:Q1O+gWY?ZYK=9X7\f23^\+-[fYfYU0A8)+9=I6P0IF8
gB=RS?8+\eaL+^?Y8I,A&G_VZN1(f9?;G88dV[JeVR9WAO/B(VOX-ZJcgD(R\=._
AVH7^:K5,>A:HF508aU6[O3XX.A/VSN47:57cOSQT2Md0_-R9/<<_UO=4&(BA&_A
O_=HeAKa<UBA;X9.3:1>5+WBJ?N#\E4Z=L#2[T7-/0+;/M]<Y,]N2#Le#:VNQ7W_
FF-M&HHePVB,NNJY>#&^98P0DHbf5MSR(VT.9S_OY1Eg9BBXM,a.QEcTJC^RV->;
VBV0\_3d=&&I:+2FZg<J6GK,=U&XSd\fXfH&(IW6=Zb3JbKfK-Cc_3^N&8;Q.MWC
a+E\S[BJ6F@\T;e&cUI3ZF1-g+Z<gJ&R.V60^WbF@VME@EaN((c6527AQS>bW6@d
NP?SbQJ+>7YP/?3T0+5](>^W-[PM>)-A@VQ<@6cf4+XOaPc[U.H\\SL4&LJW;aKS
817^SQ9ZUY.bdSMF5(CIL2M-#V>e7?d?3D-PN^g-X-bSK?;@NXUIU0DQ+B3Q4K^=
B][)C/I;T4O0CO#7b=@TdY0C.PQ9+]#BZX:Y4Q>S=FSR[U1=O<C75#)N9e&8^:B1
)MWS9Q304X\;I@(H_)LgP#68agZdd9a#(&?C5L^Z[dd4X:^A]RPH5-3Wg?g?+VI]
bbQ6_19?^[=0Tc^OP.;J7&/Z5A&8aF;9J0S/a?+QZ0,@:,BFU^;9ODJ[U),X.NU,
@:VgW.FgbIdFF-?U:[,BBXBAQRRTX7)Q5MCJDH1[.1gFYG^VN@^3^:=VI1S63LOK
_28ND,g?57d^;Q;BV>I7d)KEY.A;3gc+ES(_)D@,TN24_KK=V[\(J7,TYUgA]YSS
_dJfAQ<2@?<<R@g+Z(eUIHJQJ8>SN9,5)^=2OII:c0]Z1dS5H^AOM<7)4VLX;fNe
]B.AcBU]:YeA,_\1.^L7YS[Cb[0,f<TIB^FdB\0+\1bDUg;?^c;7MD@,G#]\[:f.
R\66B0f/?LDb6.GF9]9TNU,eMN<Gb+gN780]5f+7X3bPMX,Vgf(b.PYOKaAd?#MN
TNDa2]5C3;@.WR<6^UB=><.EXgfBJ.M=)WfP4MBgADL-EFfYZ8)Z7B3[B5caY?AZ
95O(,6RETI:9C?4C--5>3fG[K+9K[Z\)16A<Vf9@Q)+&OEZNBPe#3bV0R\4W2+Cg
S;JP#T<RH>6Da\B8HGO;e^W;eP;C_gc1:&R.[P.Ga[KcDHJNDedSHQNRMR@c0/BC
9^/,_1?\YZQc64Y6_C>J2Rg])O&R=NWPJLGH]_4:FHbc7,gJ(JO<O+]9C#QT\b_<
1bP/R2YB?8BO..@BV:[\D,TJ+(Y#&8DR-?fb.Q+\f3PP1cc1OGN^CIfS<:cBf3dC
e3W47f@>:dZ)c^\&aM8Z316?VO5^)CSP0L^&FEPO1J/1,6+MPd#)XHP-Ve^@Sd_W
(^@((E7XZGT/(?5(QF]C,BF^f(<;PP9ECH=eFI,O3)Y0+I@JU38]^O;Y4#\E)UJ-
a;YH#H6fcRKJ+.,Kd/)6W;@RdZ?=S\T08O36DZdJ=;f(_F_RYLc3YQ-60JXH#9b\
UJ=7JJD97]/QOBP18a;9[S(AW5D+CYaI:?_1^20c8<C[(c60IH7@)#8U<HY<>8/1
/@Q<80F#^XJMBHK_^Ra=_7(BO9:[[AVB5PUH#79H+c5Cd:RRX1Ec6[V=.cUcEb0R
#53Y2Be;2D.FP]C@J7N&QF:eT(cOg;<&]Q3)DXWM-68:3GUF53,bW?E8ABX([[3S
.MeH./1Y9)FNg?)06]bF)\N-GE6,[KHd.ZG<+b8OX@G=-CZ?cP0<K+6-PfBDCMcg
RF_^@EUTZ9</<aP=bX[Kg8cP.4(TX24FFJB12Hg9K1I,]F?gV@DP1d95EXM(7G&=
@c43Y6b[U?5R]_^;fM+cO@EEcd&e;)QHX:KE+Pe_3<P8\ROX3/6^@3_=cBX9>K[M
gORX8d4G(^MYXGR\.M6O5MGac+HPP[8SQ(2gY,>O?d?FdQFNf2GXe_b0]?d#c\@M
]_N6GQY3/<-F90R_bZ=,0F\63=UQOc<TV=J6AUEg7ZBB0-Q<-#?DdO8C]dZT?O3c
5eUH&@bXU7UR)T(/7,d8(-=f^5@(GS=eXa+GGY<Q:)=ZF?f_6R0UUcM]We<\^YH,
c(VI:6IC#8egMFgZE+[Q([SMAMXGPZ+?OY.A1V4K^M<,54-V?H^S8L\1.X/&,87@
\Fb3/._A)C+[3EBNX]KgJb+WVG[+Y0SMe3WPWf>a]4UcJB.<[g[8N10;79LSf&b=
T:4Bb85Cc6O/95(Ocd_NEafQa9:)(XQ2_C(&&Z&b(DI9#1RVHMdBc4JJ&KU2WgO4
T14+5Fa\JbbUBWHSUTHV>M+^OG;<M=AP?NHF>VE:>AeP/U6OQ]U&S3UYQb2]#W#U
+Q.12AEWM3;SI(ZB9#YeMM3R>K>/.Y@I9>/NIT#IPbc;[&E=acSXGA=4LbE=GS27
gI&^?R?EZRV(_<7LM#E4/,eP2b\D6.SN#6T&]9e;RfYKb:N]F:1\TMGO6]&?(T#U
@/-Te@@<E,7.XP,O3=1Y4J#cPWH&]]VR95>cgY3\31KDf4dP>MH,aT-ER(-P;P6U
:Z9)._^3FIG_fJC>Z73NS/^[^UO.)&LXR4fZHdX&C6O9O4MEd?#1cSA@X8HG>R,,
-dQ+,<5aF8YQG_<^K>cPAUP1cG_.dV=P[)B3>MHU;NHBb.N(/TYU0DK\4Y.AP27Z
Cf1.=(dSF\W[d#JaLM7:]5,M]CY;a-[\^SWa;&Y.,:^BZba2PE15N51-[HH/Z3P=
/JOXXGM&832LTMEEA914,>1F.c[:^f@,\@bd&9c;O?QTca,bN05-OedTcPf@-O\,
/SgR(Q#D<aU\@GIBA,.S(4LfO(-2Y2Q^;#WIBEXbAgef[A0c[Y1_>&1_R=G6N]B#
b>>W],LUPIa0/#-VJDYA)<2dfH8NEWV1-EbWB)1BR\?-bN1CcdT\7>=fZ,PF],g\
W40PMeUP^AD5.9]<WM>R#6W9VZ;3CUE1DT>_dAgcQRV8A3B84SJ2L:@#@U@Tc,=\
_CYGKNY8(PcC:V+aV;--K?.)W?[0PTN.cFJ\a[E=c+/]&-Q<<:^HS]4[3SLAC#P^
T#C:BbK;)095.U@O[\R2d33<(+4=0OB,bFeSMVc#.PAJ;@N+(L4@bQ)C_\\A4@)D
;F2DEBFK-c&.(G;AUC\;PV/,bfL>/P-KN,d6XdaRE3TWW7())A?>,3g.R.Q&NeG&
f>]d\0WYg3X;(:GC-54\8X>3(.XO,/Z^0C5DMZ4LQaFZGM.2--S_SZJaZIcgSHC(
HA^/7[R=dMWRV@,d4^KH_CD+]GFFc/L\B7=CcY:[AN:(];/^3<b>I:f/@#2[6XXL
<IB65A>?93gAJBHJ)VW<=K#^5DH6_;]#X7P6KQ^Y9]-@-)T/9>2.dY^bbY?0g-L(
VRW]^g6K5cFBPD2@Y/98,/aH>ESKM4BM78-W^Obc]5W^A>2:F)8BU1UFQ[eD6OB:
RNMW8/.B[5EG<-G\S&#<G2(Q1&@1J6__4JZ@X1;&^FA3#fK@JDP<:FILQ?>8YK.X
3N[WAC\8&P@A1J\>X1:g^f,5N\==T-,9:d)/<0a7]_^]c]UR]-6WSI&,Eg1gJKE@
EMS(2/[_&W211R@e]DH<^7NQ6a:B>=^RCP.SS)\[VR?[,]5RLd@=,7cK1P,YXK^&
/UAJS.(E^5O\=EI;EXcGUc-4C(Mf99WVJ1d=QWBO&K2gf-_fgB;5G\gQMPLc(]?E
R>\Ia.SH&Zc?]P:5QffL^,IQ:1#G,K)S8:5@(4XJS]NG=\]^O(AH_8#A4+XFg^Nf
]:_DP6fSfZN617.>X@,ePR9_3^>15L29+P1f-Kc>+J1U_C3W>&&:S6K(MV[R>ZeG
W0Q8@\Nb#QgeS.D]4(9+ca&;2/E5=UQ6aW]6.DA^T7,@Bc-Z^6@Ra1Y/]T4&IB&>
/,-^1L+?Y?3bMM0a?;YVJQ-]Hb6:<^L4WBMKgB0P4RY-I&>a1EH4CXd)=YT=B#W)
U/I^T)b7bZ6Z^_?I6P&L5J173.<F@/CE&F4882FeUTK.=.Y9L\d]9>>&(5<\1g8e
d;XfNIS4?4O_Ud-Ue0F3NJD1-<)[:@[Bc6KTfL^R3E\CFFY\DT[D&?@ZHbe#fA+e
KS4F=TK1R3@S]:P=DA])f@[0_N4.O[B/[MB0JR-dG_SVKe(^W@Be_:IJ#+.:TBC8
AMPXE>CHCH2(87P+[8>5aa0aX-e+-U(SaIO)Q0bK99JZE9CT9F1UW4&TG<Z<8+R/
:E;UeHCS)ARDKFEF&_254L21JN+bN[;4A/BNf@D4bAYACU.@X+Y)5e:HM>g&^FCH
GeU.C9Nc:3Q^4fKRTQWX]/&X0/B7&PcMFg@-9@V<I8,2d]QA@,-P@@NWCfB9TdT&
\Sb&)5IL7e\#G74dV8L^(6V+B:WVH^B+R/W8]A-??5.I..;N9WJ>gKbGa?MV/KIF
H0bT9be\=+KV\R+>3dWYS@>UI9?XVc16TS:F5T=G(B@/L,BMNF[83K^R06X#D9?@
A<?f.HbGHc9Zf2N#DID_f@NK.IBFON5R:fBZ+D8S\6Ee+]5,\4T5LN(df^[R,Uc>
aV+DM6,NWFAgI[(MZ04W6,V@+,LfM6?R8:,;9?DEON@#dfH_Z&=N:S5b(B@L6-M@
,Q,B65RNd,S-&:9Nc1:a<b<@U\O-[Q1MBD30UabZ:&1fKTWJI/+;1CFX]=HScU<U
75&^PSg>_=9:bYF)ZD?^NI&#_+1d4[N;?81Bbc>ZULNY/I0EGALTDOc^7++G?5,[
d73ZQGJ?QV(C)5B(LR]1fQO@X&KcWZWeF>P=e,J+U[ffFFCPZ1UUN>]5[S;I@^,Z
a/L)&N2<1LaV;9R2[f&HIN\W<3YEAX4TXWEF:Hf@_:4,R;J8a_==__KaZFYT6@)[
#):<PTY(ICR;3e9LOR7dT0.>30-RM)@++9GS.a:RF#S4H(MKZ[Jb[\#WLXPUe)X[
75T55_G_e5P.A=-D]0RC:K#@d&S5]TRTY.)-E,1J_;0J+aHM-I8U.Wa>P#OPdQ0R
8:[CA^ed1ZHKN,8B5O0[<+54C9M+MOJ;V3<.bJIZ5f?TPOIe]Z5F@&0f.SE,L\B\
Y1\3W0.W5/U6d2#=I^:@6CQ<?O#_BS5e:<D&c[ffTSaV5A?=b05G02d&X0CVE[-9
P^Dd@TB)0W.3>c8aK49?HB+V#61:E)+VPV,(RZXeA;(2?A&V1XK>#1VUGeXEgDEV
:V+a9AM2bT6U2^5C>CB;fMMLN(bB#cRTHfFBb/aY1WV,F6TWEGg5EX71H-N=d61M
[6[SJFd1BQ;^KBK_FE00I^HcbdL64P:a[G+GXJWPL\V?4^&^e+;<5>=Zd_=>,^GM
FIH<b]X8NZ@#,@#:(d7L59b)b93+\,fLUH55dbcgPX?&VCUWd->OQ0SQ=>W0#6X;
Z>R?XOcB;geM;N?,J3ag+17ICN5GN8UOE]ZH5V90P)Ng,Q0=-fA&Mg\c_T:DQXgD
[3bD;C&YB]>986LS4N)&Vg&Wa(g(C.UF44Yd]MDE(F@c^.[Jb?4d;HP>?dOdP^MT
#^ZZA7fWH+#1D;_47c^f>[A6.6e\54^LF=F,JTKY^,?.a(U+[e:e23285J,9QJD[
f>545AT#-L&S<9gNMaO_L7_JT3G9fH@/,#=0IHZ:-(dGgNC@GD@KI3\3SVC2.F[>
J?DV=FA1eO3>2bfFg>/d4VeL<O(?P]SfSBeNgP.F1a5WH)(JM0O7D;+^aD)fHVQ8
],P#U=fF-K#P&^<U##NXOR?Fa0[DKM1]HYR+-ee.IDT(^W,7Kd^3/e?P<0CA7/0-
YJf]=SL<2T304HU#Mb>H;eLE@[--U?Y>(.0,LPGZ9TQBR\^gE)52e#W+,ZAO^f:&
4D>AdR:TMU)&QMf^Oc;((U_\&FCRFgZ:C]KGB^BZ8+J-WEMK2,6CS[.QDFR?05B^
]:84a7)]CDcXRB[2g@_:#YV74-LW,Q]Y5dS__E>AUZMcaC56H)gWX0A;=LDKHI>^
Lc9?Y\Qf5U9,Y1<D7DbQC\<HYA//g=FW:d]<=EQbW)3:5>/@B:Q;SZ[OU4SO]#]/
>XA6gddaJ7T7K(Q[@-X6>3RAWSE\(#;#f.EZE5LC6M:_:f6<XX8S[aGOFdXU)UYM
fHB1=.6eTd>,+4WgQBX/0DN(N3[07c]Pag#f[RJaOAFX2+][bMG--<L,\IV1A6#T
=SL8[[06R.?00_7aJ^(Cb=R:.?bMV^dg^3UX0UMAD/5Q=-8+f#_D<884IO+P<-6[
^,KIA(>?S+^.8:I,f/O)5>:.e/c3b<66X3MO;6#c)A@LF<,9>cN;.TL6,,S:e@/N
0gOWUQU/ONeK+(G)2S=UIR<5UIUg@eM1]&P:?X;]F73IX?/D+FKeTQ6&&XP(T(f?
e<#@JTN=)0+<6^I1+f6N+afBE17AD3/)#URcEH8B#Yc3PbO7Ga2b,&gIX)Gg<O&=
c8f:GK5<ND7.[^@fM&^g&cgDOgggL>?URAE-gVNfcT&_\&&D+&8A&]ZID_C-?X^=
BHaCKYK#fgO02a+20gYF]0AObY(RU;3B6&^WRPTg?AF:8fP@-=VeC0P98)Rf#U4g
=D.X;6/.\/LA/1dL<0@D)QE50?C:9S(fb_IX=KB>D,Y4ge_e12_=M)ZEe+;(DU4F
&a\H?<_PWL<FI;Ze0Q&>>^YN:-.=GASV](J@X(V?G8[,2Q=eQ:;@B)b_CY&P1@E4
Z.Sa7A\7d1E,F^g2&V-)[@X.5I495:g8P7fR5JUAQ&#B0&__;=bWF+[;#I50/\30
._5b=39&T.?V?,>>MS.2&b&FA_&]@)PDC_6DU7JA?AFU+6SV0LS3=O0POP(-OKgd
GV,DN@C[IS@SXT@E[MJFR4cS<IfV4Z=,QC&TN9.?,dKc9T<89J8KTAZ05L#()DIJ
BO?47^J[61g]7FEXO>[J#AL,^Z<XRJA]aH8TK&[\aYY#A(Q#L,FaEdUVUGTU(7Jf
BAY:JeZ&19ETa+G)__C1g(W><TF\+S\K-ZaY8/62.)=fGd<=TN\6+8_,aES3/,5D
XXe\M0I>RKK3cf5bU_>#Z?0RJGE\/JLN^O.ZQ&N95TPLgE4_T?_I8gXA>J;[;YO;
EUH(\:T;b+JNV<,X_E??0H<#PeU#8G<&:V2feJUd^DCWR>SKG,(G3L2bG1FMKgZ^
VU[b3T3T8I=\]IMXB)Z/VN1FBTV31X2&/71e[Q4JeN&,D>3NOT6>)9]V3<#>U>Ke
#A+gM\ULg5TH7.P.O5O:&fYJ5WD\(@7G#dJZU4_P=fHP:@^K,5VQV(4<VHCL&5I#
J.UNU6g?6f[SI;AQa[H<W=K93;84Pd&#[D2X/BU>bOE/fPKDcRX=5&BGENOadM9]
0=IDR8<17&6?25?D>I/D\,#&3-&e^-2F:./YfESA\F6cD)(:Bc5M\Pa;//<?V2(@
gAYG6#5aL=CA<>\Yc-SGTR?5BCF&2S-J(gD7fY;SE>6)PR(RPC/I0#@a5<b?;/UQ
SIS76-I4X&dW-[:S4fJZ[:2&cc>:UPBK:P7R603/+e8XX\C=0=Gdd4@=J1d@C2KR
.H<BF)1J.e_XT,5RTaG01:</Me^W-RT[6FW2]/ZdN)&VaVK\,(RQPT47aI((L15R
f:Y)Sd(Z<6>f+=-BDYd^O@X(JaU4TBU_KA.3SUR7(M<2JaEQ(ELS+0Q04GCYEKRM
gB9-I1B72+:UbQbTG_C<U&?F?fHOBK./AZ:JP2YJF7U/TL+=SM&>AG@&_M#a#7SH
>:<d/L4G7=VV=KW940GHQMTdRWWfGS5K_4Wa)dUE@V+U/bO>H+;bPAbQ&=beU<B?
ge=(EE7;Z,#4HW[aP#&B/g;/PV?[#2,]<X6]D=T?)8=PE>QW;,YDKVU>/d8V]33E
/-Y/_8f/dB_dWCJMgEX)?\;/2$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_S25FL_SDR_AC_CONFIGURATION_SV
