
`ifndef GUARD_SVT_SPI_FLASH_JESD251_XSPI_SDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_JESD251_XSPI_SDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;
// =============================================================================
/**
 * This is the AC Characteristics Timing Check Class for xSPI Flash based 
 * Adesto JESD251 device family in sdr mode.
 */
class svt_spi_flash_jesd251_xSPI_sdr_ac_configuration extends svt_configuration;

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

  /** Minimum Clock high pulse width duration. */ 
  real tCH_ns;

  /** Minimum Clock Low pulse width duration. */ 
  real tCL_ns;

  /** Minimum Clock high pulse width duration. */ 
  real tPeriod_ns;

  /**
   * Minimum Duration in ns for which Slave Select must be deasserted in
   * between Two Instruction sequence 
   */
  real tCSH_ns[];

  /** CS# Low Active Setup time */ 
  real tCSLCKH_ns = initial_time;

  /** CS# High Non Active Hold time */ 
  real tCSHCKH_ns = initial_time;

  /** CS# Low Active Hold time */ 
  real tCKLCSH_ns = initial_time;

  /** CS# High Not Active Setup time */ 
  real tCKLCSL_ns = initial_time;

  /** Data in Setup time  */
  real tISU_ns = initial_time;

  /** Data in Hold time   */
  real tIH_ns = initial_time;

  /** Output Disable time */ 
  real tDIS_ns = initial_time;

  /** WP# Setup time */
  real tWPS_ns = initial_time;

  /** WP# Hold time */ 
  real tWPH_ns = initial_time;

  /** Output Disable time to drive MOSI/MISO ports to be tri-stated after this time */ 
  real output_disable_time_ns     = initial_time;

  /** Min Output Disable time to drive MOSI/MISO ports to be tri-stated after this time */ 
  real output_disable_time_min_ns = initial_time;

  /** Max Output Disable time to drive MOSI/MISO ports to be tri-stated after this time */ 
  real output_disable_time_max_ns = initial_time;

  /** DS output active time from CLK */
  real tCSLDSL_ns = initial_time;

  /** DS output inactive time from CLK */
  real tDSLCSH_ns = initial_time;

  /** CS High to DS tristate */
  real tCSHDST_ns = initial_time;

  /** DS tristate to CS low */
  real tDSTCSL_ns = initial_time;

  /** DQS to CLK delay */
  real tDSMPW_ns = initial_time;

  /** DM Setup time. */
  real tDS_ns = initial_time;

  /** DM Hold time. */
  real tDH_ns = initial_time;

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
  `svt_vmm_data_new(svt_spi_flash_jesd251_xSPI_sdr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_jesd251_xSPI_sdr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_jesd251_xSPI_sdr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_jesd251_xSPI_sdr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_jesd251_xSPI_sdr_ac_configuration.
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
  `vmm_typename(svt_spi_flash_jesd251_xSPI_sdr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_jesd251_xSPI_sdr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
QEU]8YN)GI<BeFE.&NQM4>&[5a).+a6;9B79La,LgHXUIe9b,V<S0)<?:IafN-7)
R:f&;>55+M)5,aIgDXN9N&#&MQ@QH5UbJ8C[GZJ2XU6H>Z<Be-E)X;BH6B[L[K],
S,T@b]VXL^AB4<WJSOYRMG&fJ?SGKV_]3>e?>)G=D.?c8fQOdNB9^CV)F:6+JGQa
>PKbN5N(A_6AcKNE5X(=,0W#P)ABD.6P;.8c7DKW;PX._MSf+ER&^SQRJ.3G#daN
gE-g:3J\JIAb]]8.G.a_W;>e:UHISK)a_2(g6W61,O&bKOKNBe3S=643G&YV^J;6
bcYZOQ\FL09YY=NFUd)YHD/0A4=3U3HUT4@80UKH>4Gd,GL7XB@72HgZLSCE.CDN
N2C-Y[dSQ)8F?FFXJ]Xbf1\94\03F[@HVYS^#?:>.Z9W2PTL^YGe>W],-L:?dDMS
QCKVQ#.&M(6>:QB;7YPReO=.#Rae2,:GX>f<H01U_a5RL(NTePE4(^c;YRab3D<Q
aZNV\<9a#fQ&4:=T19MO9cBd.5\:gOX,KKH::BEF^N12\e^0<I,,b)P2A-NERRHB
):X7#Ya/EeMf.7A0RFM+aV1>F<cAMK5OP/[>We.e5dD&ZbE;RR(F(]YIg9J,G_4F
QO7]ERIaLIAOc0TZf]IcG\,FCH;QSGT,f[(HeQdbaI)=fQ,ILLeHO_+eIWO=IZX7
>-@8J0/bZGd3]EQV-Y#43(Re[L2,V999N.GV;N)K[YGSSPLbWRG#-]fRg[)1a62<
KNN5U#/d/1&9S<QN>CYHQbIP]dK_J<I_MY7QFa6,25ALYZ/-/\-X8BJ<S_a0R6gKQ$
`endprotected


//vcs_vip_protect
`protected
RT(_Caf6;,bF.I:J9-[McO-b<-.XGfG+3=gd];-3a<CS:cV^>1E[5(Qb#NUTB3=X
S/:,OGOQ&g4PV1\+Z29=T-D?N?/]d5C75K,XN2+gcG<\4gd8KfE3<=N]JdWbR,bb
>@AVW1<.gd0R4<2FFCI)cJd#IbaN.TR^,4c3:+.T)5JC<?XS0b.697I]0<Y2BfJ@
(U2T4#>0a@^O@4O9BDgWH)YA=9H=1V1CWD3BOW26=3Z&CDPSNd./)S6@bf_L=@1+
=&]#6RXKKC2E]g@W(RT<URAWg._;f=_<C022T\+I?_I(0S4&61WRGd(QKC6KQ)-]
5?RL]Q#5@+/TbdX&&-\bHR0a@gOY\;W=@QJBBAAX?0@DEZ=HS+aL7Qg&3+ZG><HL
Da(&;5M0FXDMZW0COe(B5AQd01LB<ZL4G<=M_BHCV(R;BMQDQV]+6:6;=bTJDDC]
R@U<9.MecV<N#A,a<fUI&(4AIZ1F32fK.A)/EI#A/K,@H(70(HE5:Of];5HI_\B[
;WMOSV8,,X9)PeDQ>0TFOg4bJ[fa=<f]KB9Z3/M1HEY<3X3D2a8G5#/\471BNGKc
NTAR=&b=8+7&>USgF\6#@P7@O[_>+GA>3,I<^8Id3#C_?Z5Z+0/9U4;Z&W3Z8<HY
P(9dI_A;Z&HR@:+H^]8D5dU2PYU\:B;<,W]JRcO0g.)dg3]b_U4aX6_:OSePWaPH
ZX/ZMV4gQYL(62RD5M)7-:^fdWQ,LF[7I;UCN&0.1X^B54>Z]-^2(E5\VB,M.6<f
(NQ:+/6gBbK:S+<RL6T@42U3QIaOQ\M3@1(2>ecF\&;ac\c;::T#\^^2I@GLC,?)
aI-cBg:gAI@1E[3@5_JUO/N+D4T@/?eB>bU])BC^N>aC2-L_Z:-J=Qd5^#QM(LOB
Y^c;XC-R,/TGf(^:U;gG_Bd\6f^4XZbgS-6(I]&Od_WP#&48W]GE2N4-:UT,C:A#
+7/=]Y#WN3ZW@(HT5I/Bd/80OQ/5RUKdE6/930dX>5]#ccg>M#JXOE02I?VN#@ff
Ke9K.BXQ5,eC(Y7T(W2F5>c:&XQ_fJ6CST1V+\2YdKRPV9J2,5)=AKPZD.@a/aK5
(V-[IR<,<:b2:6@fF;F,G2:M9EfL#?E9+Ua)eNd+W1XM;Z4C?ZGIGe24++_/#\MR
NGf-XA/.YM.RU^L[C,[5]WECMOJLJ@,7f]>A2USE+MZD+3H@^Z)C84H<5XQ(O<LQ
+PUF(0PTaR:EJCg:U#NA2:S2;=:(3:U;=FYZX0,TN[.[GHBZ71#64U&-Be5bBBdK
XS\@MNf4XU5.3<1W:H=XQ-&#d5-d0#[X7;5EAeMd:AZ_I,DW+>ZZaHV>?.:L)WW7
/fB=dU]Pd&.>8,d:GdKQ+FR#PGe=D_)EZU&M+:\Yd-\YU_[_7Z)a]+BWCbO<>H/?
2Z)DMC9CD)#:N\^]0T<D&__V,&8L6X2H]AP[b>Sf9.I67[WQ;1#D]8II90A/38ZE
eEK7Q)R-=.5Gda]\Wc4We-bCBXC-QKB5Ob[6^J_Q+_5LW4C6bKS.&5R\^G54]U,I
\^)@d0^J<>B3]@7P<+Z8C>YY<RdfG9QPc.7cJ2PR;IKC67,fgO(bU17HW8(-\7ZU
>V#e-U33_?LGL#\QYf,#.EGL.)K/gII4W2O#Y>-2?NBVdKFC[C5M0R)8CMe4?L-J
<9,FD3JXeI](6ffO54Z48gDcXZ-LI5ETL+d]YXOc57;J>J.7Z.#2YO=6,ZATN7ZT
4W:NQad_B)4)[B+Y3T\fa]3A<Ga/2dBbY5V79D#(C,IR6D6^^g&=+?#Y&W_,Va@=
3IgOdfDZ.&<\GC,cE@Z4(I/E0gL-X)(Q6WVL>?5O#H3W1]4g#e1H5J#OFG3#Z;N4
.K+--M[eND8-((SDEAgYMBY;WL?J7e93TSE8I]4Y&)&(P)E;B9(0EF[f/TAL#1YT
.VgW:N2QFG42K##ZE(K]#__M)?Z=7^.=b[ESYG5f2E1#eZ&FR@83<K[4?K>C<X[S
6-GB,EcISH<3@3e^LIKdO^c-500gJSTf3#gR2]8F#4ObXLdg3bLHS8B9&VF[YVMI
M#1141U=,4RX2O]]X)4G0<fLEb3Z=<]4g/PCa[P.=7<DP(PN;fLA&VA7,F53@NT4
-CeV(B3+T::&BFNaTfP[5eCb)EegJ9DVCg=+/R\;G2Q(-Qcc2#2>MIfa2V9SCX/Z
ZcO.MO7\/]R7W4TMfcP\&OGg&I^68]FYJ>JJJ#LIBWX<]dWe=g/NJ[W(2a\c-N0g
Z?<&QTg5F&5A:>M<H\<AR7G65WG)KR]7?&TgTW?gPcHR4:50a;WQXRP3#6aG/9MC
TSX8X38HC:?Id#e:UV\G60M@.@@_3;V7L.0[(0XZ:DN:C[Z9RWEB8cfTZ4DaA=(K
2I\WLYQDK:D^=GLJ8\&6^eg9,OdX5>)=,9eVO=#[A9Q\_<g]&26BE+S5VN),.P6S
3&/CA]V1-BZAHO<N@6#P/K+T#)VR_G?=XQL075X[Y(X@OJUN[#^2FJA00JGR0>_E
K5)7NED56QOEKI2FJ&B<B)&MIBGbHIKO,fG7.(Pf6VHNPbHG]]A7K_0gKJE]+cCZ
g@+#)L(_4,MJfb@)NFfV0EDLIW&/DW4^8KK-,0@?P/@g9Z:E:K^9\WMN11^5MG8+
.(\eL\AYVGNQ^&a6;#JH6L0EV>3&Ca@:QZ0DJa?F:,bZN15+JFWPJ+RY+ISLH2&9
CZF;M&K6HNf0cb2acEF>YINT5XOR(A<f#<R[7,e=XY?<RQY]](:1gLP#Q)&\K>)+
3:HBF>Cg[LF?<3e:98e=5G&,&>cN,^6J9VA]N<NXB53-9N-HZ^K#BF06Pg,EAA:>
3_4IYEN&\fZbGF90Ue3M@RBA=7V@]J>E7W0HT4,@BHR#X:cKK01CKA\N#Z=6MQ(I
G>8CMZ_E3I4H)SXBgFJ4XdY5d,.fK6<=(EFH@gX2+aA92(Y6D=2HTd53R?ZF6;AH
[c2,Ad)28Q:XJB.UWRUFT&I[Z2Y=7PQ5?ddORG)6W5O\R<RA\.S2WfR->Q#BN17O
f;-c[R4RG;_g02,7-c]V<ME6c-X-0g8L3C=\gR;5?E+M?aQZ8UJ_[Q5&[OR@,HKS
\N_=Y97&2fS;1C;:bUcfM/WRg,_S1bA/G?TJ[JX.T+6bF:^/B9#DOKRY#AX:+1Ua
V0\;J0([>7_G=e.1#K2W>UR=-0e8<(_V?;335BE;\Ja6YgISCFG,a[/;T-<Kd,MH
S>1d(dEI2gN>K+fP_,cQYfTMKFF+N8XEQT-#N4db?DOH3eHgCIGLcbMf05J]K,^Q
I(?/H>#1LQe-ZMZ^dOfb@7,#@Ka\RATM<B:,R0e-b][=-QdS8,7Z/.)eFR+)(R^O
AX)HHK@QSGIgM0(c[7H_==Q4G#gGFK(a66DE#)g:,W=f>RWBTfef2N98\0Y#YH3S
e\C4>9W7O<I8EgOZecR\Gd?bVXg6T)#C4@2;Jg<#>=T=4^cE2#T>F(4T&F/LTb3B
>Xb&SLJ_QD/WeT+:M=J+DJG]_J\@Z[70U=VTbTNZJ2Ia(>YKF/626U5@D&U0QNE_
6QcQeD&9/577:>ISG\4^8RQWESWLd/P-Bb)CI7OYULb1_D,N#&4HU<PcJV1b=HLO
SX(JJGR[6FY^6/Y5C0RFPLJebR5A@(&a9T@?8XU=O4CVZSB;)@-W<&(-g+QIc_S8
<B/FBL2-GSD;W=&CWK39@Lge1?WPOY9-?N4\.deTO&L1;D/+degHU#C=8<4BIGDH
VD?gfCZ6=f#Z>[.dK.\[_(77/(^g95LbC)d]?W<TC2O0e+^I4]S<]46gQ-&4LF99
&e.?62L@cTc@0<>M\[gMXC[H<T/IN)^F2fP0&QSESfOI&@35N+GY[d@DK&PFE&IG
,A&gcT134[Y)LNCB1fQacRFB#LaQ[O41&Gg2fa=PP;1\0X^bCLU2D6W:E/_HZ0N^
>Wc25AYd^)4Y(?Y:4MDV8VfMLW:J[I]TL;4]8XWGaED<.;P_BJN5^CZ/?UG+UFDO
@9<<bV::1e3DRLJJ?-edSfT;bNe[3PAS4GIJ;=9NA5U>8JE5#2J\2Tcefc1G]REG
?T1P_PVd:f,.S.cYe=P&LadbVdg>]_\1&8QNP3)4C+8L,[X>.;9O)N,D/W]A_V=\
0-180<G8b?Jf9/S[SZ4RA>a9Y;9?#<JQN8LQGeQ65/:PJ431XPGWNVYSY)2K\e+\
Q,d:0BXMXL\L4_-I08U)H?;_IC7;Z<<^b=/dV+OR]WWB[U#5Wd?:F]gI/^C5(SHY
-/C+f7@E6d]FS98f<Z@?eO#cRYTaP^>/3fN8<:@2fM5N_e\)PZ3ZNSCGFI]]fM/a
7MRaFUO=C;LWfQeGB79bM__GG?+@1_6?BXJDC6IU?0:1cagc:a@_>+OI.eE\]ebG
&4_;+<Y<&e33HT.DDd-Gda4E^:H>E20J]C_>N(VGORH?4aYQM:F>0S2_88]9^e;?
@9B/6TS0c+\9Y=)PJZe+T-^,O;(ZR@HT@D:BE5E14@.Y[&)<f@c=Kg]BZQUB6daP
J)gF2RZ\/T9<64IH[[>[Z6L3<AfG9.FC2,:VI72XA@61&-65)3G/^AH-K6LQZ)MB
&.-c]E]AcTXS.GF/1##d84DMPR?TAVT,DdF>+NVEH6@GKFRc:/\4JaC8<eaf/2>3
&eJc\[U87Y4KeY]G0=NT^R8MD3@TH]XgFE)>;4^-<_OB/(WX8=3W;0SNC:N31L?a
&/V_a+814KBM5\a..VI#eKI;Q.\&5^&0=8MPVL?cVb]c?Z7EW(A&Xg7A)RRUbU.S
BGM2=>S&=e)01YXFeP)]dP@4B8M+[;JZGVE0H5?W>A<T@.=JW8^8dT6Jb8&&+MS6
ac6B,agD]2.NP>ZReF7C>^ZV+/)0(_HQ:Y8;0e#ZSDO,;NYZ>#4WL84,2YA)B?VN
U?;I_5[d.cV9]9OcD]d?+F9:0.b/71E<>ESBMg1/C:-II1fa\+1G9\\(_eR4\eYD
G6e(GCc@8:UIOITT:XJgB?3:VbZcW;3=a0^9BJQL<1I-HTe)eVN@e?KYE]CXV](K
6V>F>F9HR(=dDUd+fgf3V^?=P5+cL5V4,.RTTW/e2/P;Q0AU[I4&-YYg7:F54OF7
3(dUCR>94Z+A,c@ZEc^<3(02>;WA=7(EGZL6W7Z\X9b0+>6QQ;=V2Fg\g,,X[\NT
fVLX;P_=\MAZaAB;GF)-1_O6?eLeLY11L5e/Je@KFT4[bJc85:,K=92g)^Ce7C/D
7<CZM#?;IP0YCUJIZ>EXag+S-U8W.0=QAAEeR8]I<aEVdZ_1EN._+5aYP,E)U1b)
gX=:-BDP=6769#DaQ7Dgbe/B;C<a/GKD+WWEdJ(DDXaSQ?8G@L7S[UZGFc5c./:(
8^fTX4;(CV>3cIZ+2#D/\A>\XGD26]=CS@J>?Y79>>+O[J1dX\QHa55edKeTgVQ>
TUT.[TfETMbZGCLXeGI8UV2K0daB9S[TL777/7]#@LMbbbKYRXJ;8_YA(X;L;_I^
V/RSNJ=3aJJ7&NUL@9G^VcFL#IX)4;1bP[.N,7[LQa&XO<Fd1UVT[@-E6(bbXeK?
Q9&?>9Ug2:QR.aVgEJYR]2?ADYdXF7f/OC4b_.eV7\9@7K?^JZ=88GQ;R?4\Y,VH
6E0<R(YQS?,0RN[5UgB?W1C[aZ\JU3)6><b6f05bQBE5T=D1Y(F-ad9>8&dXCc)_
RUgP/N5?eZ>N#8]38Ff0HJC3-b.WP;?O62J_?FBcf>^@_0C>0YA]U4[NR27IV3L.
9:C(^PV5VC.N,O?FK&][:59KTYdUB/dSQPg+#TgMQ#>7-2(#T;C-O<R#>QV/\>YY
2;?X?=Q]PLDE[Z@\5L#1g.T=D\3VD6,P4fN?#L,;VQd#@1@EJ-EN[E]<DT=e,9&-
?4))72P4O-AS--)4(>f81[+2\QC^OdE?-+FH0R/X@UP8.@EKcSN[)RMIQ^I]J78f
\317<e?bG)gc6R(2]/A+bP5SY2/E0>Y[6+HdS<S?-cEK]4XFbDI9:=C(U)?HMUY/
QV.E86)R\C;/a9O26B+Rc\?gYZHZT@W[_FR>JTPA^?URWddY?D-\+#PA;CKBX7fJ
=f/I:Q1Y)23)KK0EbP+3,+BC>GcFXb@X8GB#./VP/ZE2C^L=C,(GcBBQ4eOM\Q-/
J4[2dM#H_>8>5aV4&ZS-DPPY\4Z:Q?.:N<Ac:)Q=-<YEIKI/49;TO2.3;P.XNe8H
OOM/TE]/5K#bE4MK;X7Q8B&4OT=9QV4K+2RR^]@#G.@1cc=CR<5[1@J+_aZXK@NX
0D0VTa]2g,,Q;IE:^Pf;UXLeYM3CMgCdN@9S8d^NDIa@1+JJQDc[B]A>WFV;^P/d
<NDJZg.<HP260X@85,FEb1U5FdQg/K5SKcD00PQ_:NIHZEUY1<g:C3F;W0dB,<@B
S)51ec&[MX5.5J:c?5;e\e-&5fQQ5fM;^XEQDg&4aB3MQ>dRKDe6;O5a0QYKL2:P
91>VGX#[S4?&(8NQLg>/(fPV?^;c-M)E[@d-?JNA]e(;]4POC,M[AV1g+)Q3,_]O
0BICA;O;J27Q3<Z2J=(:I>a?@VA3]E8N=#XX(eKF3gB-1FC0CSM>eOW]bWP#D#bF
bB>gN9QaOG3bdfD;OR313>_,eP/;Z4<A)U_R9\7cY[,BL8fZ[^?.Bb)<,QO1I0gb
5Hb(ULd-W,3YUA/Xf0O\JCZZc-PfefLB=d-BI:+YeNTWIa^5G\P:8-9))O=.;271
C2-PT&Ha#f?MGcJUG66H),1#JO),A9T_Aa-=<=\9YfQWX&9S5f]@J/;RC<:CR=Ie
f0T.Y_XFdeQ1ETQ]#A)O7[5<,^@B#=06T=T(.S,#>R5gK<Ib-W\)J2AEO1M;W<cb
<XP7HVM9^9+16OdTb>S/>U;T.(&fMEF5a)>[NR2[ZAG/FEY9b&\YLZ5N27\?X-N1
GDC?09X,MEEI1VQA=3@E8V;.T1)]]T?,_C0)f\_?6&aR3UT7VDVTY7R643I\]PWQ
)6e9(:W<cDd@.@C_/&CKEbJ(?37f9AK^][[P8b33GObRgVV;Y41d/9LaO]T5AF.7
X(6IWR:,SdB=DM;;65e/QH.O)+8VfO/B>C46UMc4G(N;I;c(JV6a12A^@<L&,Bd.
.71TQ6dP>@a?.Rb;?&#ILUX:XOd0?:<QB,<,-?NZcD(927a+E[>_35]-]96;X<5)
N&g2H]JfHIGJXM,;cNETfB;5:EN^<=3[\0(dLY:)KN0ef8M1_C5FB>53_ES@^g8/
R)0C(2R6@&b=dd)L@UZF;@_1cOOLX(=]e^=A-1?1e6/UCFKOA0@FVQC3AgA]T:O3
b&=LE0U)IQb@fKIQ+#AJ=A-[>VOg_^Z=@FT6W;NWd62d5;cX[R]54=C<]0Y9PE^7
aUO3aCXGFB&M4Taa50ICLY2YU2-)KAH(0EF6-RfgfK>@[9f.FAA(D\0B^NJF)@E4
88+[D7LPQZ<^-OY21IZH(HfFCV2Z6TL=b&-ca#4PIXca2Q(N9g:-V6e9@\NNFd;O
=1JPNb/D_P)R.2Ig+(\T#<^KNg7(VEde6SaLc]V7=PTfEZC[_fgb]QWJGb#[:/[@
8MgT0/OR6OUd-7T#e,2I3bBdO_-]KC,^gaR+XaAe]9f0d4RC3#IRM#&B:WBY4CXA
JTA())8Y6K6^Z(;-E-.YA.#=Ug/\?P)1]0&)UWE.BM&=ZS>+G.Y[]5P#G^)U#BA3
XO;ZD1_.7MU:eA=g:Z35_7d<OF\@04X+O5VN\C]H0PO#7TG<f.bVb>8RG\\+1I)3
AYP#QGbe7a4L:HgJCNU6S9f];C=^C4>-85OC)PDH?Kd3D1I6I5gWU:.:VR-P<>UP
R#?\LIYFH:[GQe;a89g)a#XLVG5K0d\7M,](80,g/R>NMS\SOcbH08&:GOHQB.=B
G3e(cLbb\K?@-NRS;60R/14WSWg>cfT&\Ga]aBgN9^->eM5_KM5SQ)DPe]XfdRc^
SR_eB.Z8AB?/71=gdZ#=-U?W_RKYEH3^E.H0.Y&d2A^SbE<g+&fV6NMKa5PA40HU
6cKI<[a<@X>]UF_S3(>6Y:&bLQZ,+agR)0c<L:,U2fY=SgdK<CU,-42SLe\B#D8(
()9Z:JW1NZG?8WMQ/QQ/3R]WR:2MFG[C1UL(:_\fU+&O5cQ2X8?C3.6g4?\bPQJB
c8Cb)9WW]AG3-U6<E0g)Z\b73e#9)RU(YF3HS3RTI=Jb+UHgg:f:7/H2VV;>8H4O
07&17OHNgFO7Y@<f:T78E&g/OO@#SGMK,)30&W2:a4D48@W<JSffT?Q1BVM/a^b@
V_f0/Ac3\464#G=c4#_WYcg9?\+KEfdL(ADT8a4O&dV:DTBgVZ&7e^5X4^4M_L--
cD>8)0KE6-4Y_7#5ca3a@>_(;O>C:.?F[F9;C71IL#(.G<4CIU0QJX23]Oa+5ddI
P#E]9Nca7]eW]6K5V2.#<gX+@?\.Q?Mf)9RD)@dff+REV,;<UAAdS54;[<M&VR]R
/D@UZe9V]9/1X_\JWX2IJK_UMebdKN6G=2]:F8[DTRWOUW0ca?cK)G_8U62E_M[A
9WI;_CMC&H=5QUF,#+0DcT3Q^:Fa6MMNd8]=AQA,NZW47G_,4.U-VT<3^U17:O/4
Y)5GK-/dL.V\-_OIdPDFabZ3GTSNG+2N.5^RY,g.L?#LT<.#EE?3>+AY7V0QW\JM
J?(5>BcN&A3eDadZZ/aD6()L4M+4+)(@3g2-V<?d:eKXNDCcTNU4H+FbK=@3D7]2
7,3)&d5YTaDc:_+I6,O]9E;a-L1JDIQ(P?2UB70:[1Z&M@b-]9&T^.EP0B:C,1cN
4+;1C_VfM&;L#SQX/EP+_\[<8-&ZUWDOC?(97FKeGHS.)aXY&0)K0=U]c[gCN,4^
bH)O#4CZDSc3:@8B4I//T8>6H]70,gf-YK6UQ6+#0b>X2N<:Ag<c-D5&/3CcSeVO
12;DQG?^dc;CY5bT6W^L)TOOT_c;OK-E8PUY;Y.G#;56ebb&UC>B3J/V73DcC]gU
cL@d#&O#LIH(g+)B-[T0>W^c4-PQ-#+g^E.:TLGTJY^#d_C#/bO8Dg>1HWD5F<U#
8FaLL(X3cZ#gL0O1+T&G]dX(,1JI/(Rd^eXba)CE2IJW^Wc&]1<\-9TFTWV1@d?4
Z@.AQI.[U7LDb&(]?1cQZ;84QT0N>aF:)>^5E@?7F8,UgIO2gc^+Y4VH)##UDTW>
9F9=Je],I2-21E?#&M-XFI7g6YUGc_&E3,R^?AM9&RW:B87Q&6GFBK-NG1L]GVP)
1[:81X,P.MM:O2X+7UK<6],I\X[)YM\4I7+3;:_d[5RV:fdJf@,#O2N)GXV]X?:\
a1S](7c;I-/OCOV6Te.LV+1gNNBQUM/J[<3K[#1?-#Z:TbJ9[YO#b)#E9(Z;dW<a
:O=GJ4a9(.1W)VZ;1dQYVe#;H:]Fbc,BSSJ-+U:@NU5]P)S[-bca:@@(&>JQ<@E0
d\2+UH3L:-f=H;LUO<?34W@W[fg8Od\XGULA?B0TXB;]R87LLF-L-,b2<_?ZC0E<
TVQF0DQC],@YZHW+3fN_)2b3Se8J0ARgHX78,C,F5>N1,G(Bf7-:BS_C:UAg\Xc0
;>4#d_Lg;MRa_UTc-Q:5f+c9R;4fB.5^,?=e5Dd8)FD+T^]QDJ?#(fK<(5IMM9R\
>Nc&S+Igf#3S48Z.;QJYNeBE_OO39E3I;Vb3dbXBd@CKUVD)Q-#<V#<CeAXM(C23
aSQ+L7H3a-MAd0Qb>I+@&S27eA&cf_^+W?2Lf6EG>.UR>.,?J]-P4^Z0HG-;C>)W
[0HEf=S<af7U,6ccU-P0QR@=J)?bGF&)2#,Ve+N#U^Y.?E^.NX&#aTLHb9g>La].
_MFWd9K>FREcLTJP5EKC6FNR0,)d@-D^a8db(3[ES;K2+:0@)XQ5AfOW06PG-I26
8ALbAU,8N]d4DO#CCaV&Y2;S+[-?>+>X=K5A6[DaNDX=b7)Y>0/R@f,K.W=b6JB?
^?>6Ie64W,bPd7>U<F[/SeERM\3caf6C,S7\95UG?/_SGJE&d^CV2f<F<,5@&0,D
gT[S1+?&M3[@[)#X&^2[eB^;[f_-04V.g367Q5\[X7&@:;gU#+5LUJ:,(4]K)gUM
HcX\?;Sf;7OJ4=U,.E@&JP-&L)N=.LM)PLD3-)GKJGV249bK,/gH<8:;F)M2#<?Y
VX].0=K#PaQ7G\D&dXSLd.fJJbc8M<&J_>cTe;JXKYN3;SB:fUSOXT86B:C]+;,R
0RSLQB?FRV86FI3R]LSC3=X7@VFb^O5X]Y^>N?M2&J(02ZE_[)a<1N3WgW-c.dIP
99c^]gd?<4P)#K5U(Xb8A/_[ZT>P]BOVCQO[\eG1A</69]I?KWWBK#VaVe\]1[_5
W\QRM<:Q=cR,g9L)C:H/DeLEXOdT&+?AJgB6:d-aB(IeB?/R6=Q<,f4g#D9-eFA<
X.(ZQ9&^_6>GH7X&:#NZBGS3YfLV5&fH6A^\eOG2P^23@Xc9X;Lffb@PFF_6NMN+
@@HY6@GQG+UFDY9=H57BBHT3RdTG>7AGKd@EY6W6gY;CJ22H.#^WVUfR4U^#^MX.
E.<;bI/<We.DL#g=54W),,\gE0UWHf8.&9BRKcf\aMG_<L;=gV+@1.-@]OKD^8TW
-#I\)&:XKGa=g7XYWT\ZdD]4.5c-J1E=3]3dL_,:SRMF.L^+/.&?X=eHB>L2d8C.
/GM@@XP(:E)6]G]K5JRF5[.Ha0_I_=f6JJD;P@G[/dgXb[b+7fOS9FcA7(e^&UK)
5M[R5;J=NfJKZ]=AB2I0a=67Jg82U<-9-6#;9>,<M@.VV:,0ST)c,,D/OZHfFWV]
8]<g5RK/BZ\W=Q0,6_@5_;YP9R3JVGXE:(FGdFg(0OME:T<KG:NE1N/(PSUg;g6W
3H;T:Y8N=8<2;YC[#6f6X9GBBZ4?BON4@PO#+;,<(=-C5YeUN7YfRaU;8_B_SWG#
W;&DbB>?+#L&Te&P9GbA<;]5+_C^4F0LSM\/G2-P]S^+#MV</c0I^(HP(7&25;8B
IP&@>4,@#WRb=e&FR;T+,T3]\]5ef>W(R,3T:M?K;H<7IC(LM=O4(F):CE5a2Jd[
0;1DBTV3OQZ?:#a.>:,Cbg6Q8B/aHKT7&P_CW,<G#Ye4Zd2V:QG\-F6#,+B>V55Q
^\1eKc-QE=C-OM2GC_</MW(c\b#Q/?cUFK>?,BMTReLK+7]b]G\468WB78#Z^?\2
CQ0UCEHYBJKCf)cH9:<fP.ZGEdY&W]F@JO0;GT3G@\^O4VA(OaL6&L)&dbFaDbWT
0aY&YVASYL:H34<T+DdAEX6g7&2aH\aW)F:X]>.3gO)N0A/3^@GARXL>NO<=QTNO
gSI#F[H^cT1RKdZM?D3_N7#KL=XWeM27-LceZZJWOTJ=&afWFO0IUB49E8;B0U_\
]OCSW8MgaI8Daf(LYFYZ,e[>>-T/TUJ\JVP.W)g:5cRZaF3U_;36V4X5WE6b9AZL
K6V^?Q,4H&c+f=]L=BKR<LL/NIL[=aFX[OP9e2KH=K)[Yc)TGQZRRB/S6ZM\_&=N
MIH4-#IGPOeF6@7cNZR,_H_L8OIL3;GSe+QSD..,CELOF-gFaXYMc9B9T>5_L[1I
6=@TSZfV01DaWFI<B64XfY0(UH3Y]WSJJ@ec?R<>e)dU\@&;9XP10HgQeK&4GGa1
b]&eNTG/M+V;\F,/P(XWB&]L(3LW^4Cd_-.C4_<IeZKU2+6JeN.6>SdH]KDBICeG
b)\@+Q>:,HHMI]-<5GZO;a?.VB2WZ)TFLS[.#ELZ[&,,=F^]607-\)N<>aL+EANI
HYK4T>W5-R,UL1C4eU()V[e=>&Ua:9F:Z\.(TRaf=&aR2Z0S?8;Fa3eCOCY))<;_
.])GULbG\e_0.\2JV=[_VYT;5#A@U1B_+<_]NT]cP_Tf;+S+S(U6ba)JL401ZW_L
UHI0A?6P#V:>L<TER]7S#L)G(Eb))-=B-SC-g^)KCYOEH=^&^^@JXMP[?<;/gLK,
O12M-@1:@>_:Hc6RdOHQMTGd=Q3:=4=]\MCg),)3W2_0FfAdF^C=N;;,b_W.@0=D
?B.W]?:_E(f:UR6@+<J<a9Z[5P(O;7&E;R&g5X6b>fIS2\YVg9T>?97ZZD\(8E#N
eY:7>Z0J,E[LCA7?Rab(>&2XR(b5Z4?6?9GBRa^L^M,9e8BI2OTXAA9AMJWCP<,W
H50gd6-O=)BT1HCDd,R92.dH_:Q>E+(]QUM:BHN,f+?[:2.:9gF[/2UDb<A[6H)d
NO]C7ZRcfgOADUO:3+-X8Q1HY&f/,T2X15GX3#dG@?LUVRD\M50C_ZS;5E31C_PM
@:g+I&SE2Z8Pc(Zd234O+@a3bN0\-32cZ4_0K16;V-;^DZX___0g7JSRRV;[-f5#
/H9:C@XUPeV]M-ROQ<gH])\52gPJI?7G4KeQWX/D4SV=cPY,S34,+/>1gXWF7#H2
7[Y4_faSfE+:REa^+_HKE8AdPL,>3(APE94ReHP@\\TJ_1#da,-,U3d&F4N@eF+g
KJNFeKT>PYIH4IacX]L]D/Y=[#BO)J2EJZYIAV-Ef-3F8d0D#Zb@A=J9ZS7BNa(V
@f.\37Q)OA<V&]<RF=/1AXb>A@U1>W\U4][K-5Q)>XO)N<U4+W3e-QV+70Ad)(YL
FbgDFf\22TJQM()1,9MQRK\LZAXaB=KS]TD<NV(Og/0ELfbP?#-2\#L8F9BTE&5f
T:HWZ@ca_5PSbN@B:J[UNAAgZE733QeMR@XDLV]HO2IK1dc0Q?YbYX55H#F:59/<
gd:0c-K<d,\>T_aDc+7T(JF+e)V[fI9-<MWFEA&[:OfM1BMAdLQYS>_I]\fV7KE7
KI^<-)G2NG>59I_E3,cNE=,G>[8NW.:BJK4PAHK?MG>2bNOSDKd(gNeg28N\,5J/
0QH+9-XKZD-2[Z9#>,C=XOadYG)&gON+,3PPKMEOE[cAT34)Rd)H1H7cPW&>R-6Q
MSN6+V?ZJY4B[4aZ,^g<I5\+Ed@9<Y3]=-G+bPJK&=T)+cL+#;>f2,Pb(5M#N;VT
0,Pe8,a)VK&HISZLgF\?]8H[.L_e:&?JHTE_7&dOgeSS+8fR.8I<&0PR5)V5Hg[)
F\R/_a-4ba@8ND85UGS:74O9AMJ0Pf1&Ag:4A.dfFEK4^>_B^X&?5gMG.Z4PE.@?
Q3Z_Ec_;MbCb380GJ?C5#X9@??KL6\PDKQJWX=(_K1dA/4T&1dTfZ^93M6dSDGgE
Z3QW^V&7C&0O:e>^dB,@J^:7_J\EW>VYU,?QHHZ?8KScbYP/BAYR9TSRPN5/OfaV
-NaHN17]-f5T.6eX87F-?eZPYcA4U=[_&0/3B\1)W:[E2D1&):LLcXX-L=(\-D8D
R=L7V/cGQI0BJLIF]^Aa[&+KH5=G=C0WY:C+bG.?4K0LV5^+L=/[X,6g,Wa+W_6/
@R@BM.(HTT,MI\1eWZ1X41EQCG[BLMJ5>?b0W^a([+f-8V4_2EITbI92^ML9UK]=
LgRU1[.\EF>DN^](GCT,/ZA2>feWV+\2=[HJZ>Ee/94GB-+GLg3\X2-6c8/ZXO?C
7\^@ZY9D]WT??7H;Q+.P,QZBLE3X=9DdJOS?Q;N4#Yb+0ScVb1P?+9-JA9L,2;8L
8+[]]8RHNKX+6&V:(/a.AA?0K&.;MH[3IEJ>))\Y\L_=Z7a.:a7?4eQKaI]#9)B[
Rc/2E3T3_VR--[c^\.7V&cb/BT[5/<,8WCXHT0Z,Qb>;070\eAUTL,0</bec;1M5
E6+RZWD5[f]C4>\9214#>[R8.dJRYJ&G/]NW.QPFHYZ-,FH/YI(N.LJD@D+V97g0
Qf5eLH.a&)XV/_H9M9[SBBHeY/-S15D&]HYOXP[F1=.bOVD^KC<#K\cF&.3VOL;0
Kb6G^C?0cJ]/ZX;2RYV_8P&?-]A>-@<gB^W89)c3DBXaB<D-I]6JA<_O,TAJRH;M
:&Ga#\;P:)FZ<.eN6W7SMd:-:510DPSOZ7@Q;_[.76DW#:TF;5Wc#SKJIKdE71LP
d0gK73)(X7(M2/5#,7+6#7B/X5,BW+-29&,[Xg<WJL-V@0fe-<R.91N-RQOQO#\g
?gf1S8<F?/2;E4QJ1T&g9Mg:KHE1Mb_CHH5R5UJg57;&^WC6T@L8D+efRL>[7W,6
5-4ORLIC>+AV0[Z=G_>42d[O[P4WP2.@=J)WZV_F?_Q^MIJIdX58R?]_4WA+G-:d
,12_[5RP>9)+U9?e>0F8+3HQX-/Y(-fL:K59W(>SE#GQB05FgGU:;UadOCT_E@0/
cAPC=aed9?QMG8f^bSM6=KVT0D9)(.EGIaF,C\3:SE&EfLb(E5<3_<L;4:;]#\5(
0X;AZG;?^T-BKG#_?LAOT#,Hf[(=;9EA?QS>:578eV+V6EK5T+0NM:;,gH2Q=<I@
<&<SO?)H>Z1]0D9V5HIV2IVHDO/,YO=@LQQQ/aYU]ZE?WSG]-OR5IZMacZ<,dJ=]
6L=3\G[_XC_+W>.0+NAW,bP@8HOeJ:7e2O8Ae0,(2S160YI)XT??RfX>PZ\f9]eZ
)6OS6?(4d&RL,7F/Qc_D@/IP1d__RZ#2VJf9(<?P>ICH9+aB\1X,5N.CN5YdLXRJ
?(Q+eC6?^HYI.bPY:fe,OBYH\X08&<g7f>M1]e^QQ@O+0U^cFEQ&XZ(;EE_M&ZYa
>fe]YfJLR&8IU;WIQZSdD[H9g_>SL>Y8>[6D+MW.;CE<c;+?QKE6#)L=\@W73JL/
-M\(;Z5(>NWE@7YbV-PC2KM>[@QS^+)>UE/>7#NI6B&80^_ba7ZEZ5L^E5#U[VcZ
J\AH5F?>D>Fb^.IS6fed&Ba^;#Fg&#>?FWgI6Z\_F9(?7dLb_/9D@J;KgAL4?a^Q
5Z3U]L/VM/,8gEU-ZP7=M/Wd<NV3X#ODY]#;Z@>Ka&bO(&\(&WHV8B_gS^6&ZfcW
W0-X(R55BPE?KRgZf)T7_OVIS^M)_EI1a4Q@IS&<(1FHE<CH3Y(_05OY8J<>777:
N1KcAbF=N=/N]D)]D)0;/cO8924\/f9-<JPMJ7Na-(TVKR,BS<),a[SKd;9PK4R;
9_A2@Z_5QbH;K^F;&e?cV8R)/PO(:f4-<3LMM/^RCUf?,FO9N6;#(\B\Ea+8NTIP
>g)0CN-RC[0@(7M.RT4_8D?e&A^f;&,2bKBe;,Y@<1I^[S1Mb/PXULe@b7_X5?RM
8E.FQG(MS(?]?[8QWJQMJ@FV.3eI1C;gea#H,_KI06FV<,&_DVPbe0dac-RDVM6_
1HS@\Da9BMRK\MO+7))-&b5]VZ9AROH81A2Da_\[5Y(2UG/RP<AKa^=&N.#f=M=e
cA-33cf+XUQ^,TcN#_-Q1Z+-Y6.e-1?;/)5Sf7b@TfH/N[cVRcM_G+?-D44_699;
^/NE?:Q6H_#MXE5c7#DW0BBQga4V1H0O_agfY_6DfeX>R4[O,DeTG1P?#6?FCfLV
X_4E5=\g#@fY[ceV9f^3ZWK989Zg:?=N]BE@a7[1#3>Pb:U-3R.KN8ZXg:Od0JV_
afeO2T8R\=N,:2VC689GG?bdT)e68b?JO3Ef/#@V^D//K#J/-d#?C)<B,?L\CLW^
^cdeaC:EN#TdN2b1<WV>LTCIL-,DI]?9+K_cVbRN9>BUDPVIFO/OY2a+Q-],B:33
0Gg(e<=5,/3c6G2B5D5[&>?Zf\GgX^>;@D?S,?)RU:>@E#7Z6=Y>L7d/[\Xf;\3T
\c:?.b6^Q^HfM+cG2GK9,?CW,AYA.E=XW3RE20<HDX+a(,K69(3L)J[ga#OCLc_\
FM[Nc8BcL8[S@cHMN#G@29)WG8?UT55=ZW_IU<HXHCGR=X/\<9e@]R>\=7D=.XCc
CDC<bE=+U=J9.e(8KQ,aA@8A7OKEH.AP69P/1;EQ&@B:EABT0HSFXa6UB+X,[WQ?
>3BWbGTNFfdf5bXQeWXRNE@bDVNWDZ0U?/bN[=0bC7#LNCJVcda<;SM?;]3GWf56
ab@c3SRW:+MSYZ?29YGY;6_P>=f^[Y\26\S?fAfRdC9g2CB/<+?JO;EMOe_c\0@3
dUb-1TZX_IadMVJ@9Q?-9+bR]+1:M5M7VX_;bHaRTCDFJ;0#YYNLDFP39#LP[4++
.ISJ,B.4&H2f,85g?EeQ6=L7@:18gN;NcH3JUML<8IT5JC,J1SB;d(F>dM&WQfM1
P=V:1<a]8&T2M38I)UZ)A@N;WgW]a;A;^ZR3d5g4EVN/fPggggcP6Y#N986JWQ\B
]NHf[_cT/bE,F-CS-N2FY49GZ&L\dT9a(#EEC-)564FLSb4YGRY_eYFFJ040NFL&
fHe><bIK>(]ILTD;0SH]XX@U+=3/98G\9UFFF8DWRN:aB1IfS,BZRL5NGP4:LF#K
@QVRe>,N8d,W=bRfe4I_G0@<ce-,4]4PI#\cRGH1CIg,PQgDR7J(aE#->LJT<bF)
?N++ATPL11f6.GSIST,5PK\/DNd2TPI2XOA-g^=gc]^\g_f_<56=1,KAKI59#T@F
2fc?^.D@D7.&H5E3a>b[3=A=,2UVHgPecfG&;<3T1^KGU^3;=^/QX6Z_FH[#+3YT
_P/5aQHfFG-P4)<a?DJX)SP.GRMLG^4GWf;BNC5J3.YdAH2JUP4+bS5J5Aa7H?7D
W@83&Tb13B&W8Q5Wd)=B>->g[^7,8Ggc,H^-CCb:B6M2\0G;a4R/Rg?@ND[e9:B;
NTe4ff-&/g4cS+;&V)eM?B7_\RS4F;<M-,WB0g>c&8O(X.XGdgUAJ4FX=df=c>_V
R]a=7R:];>9.4:8dG2TR;0^66M(=M0G,e4;E(1PH3UIKW.#LYLfA,1_NF;Y8/E+<
KEG6HTH.)L)2K;)M-8SH)A7I<&;PO@,/S]A(FVc?_U,-d.5/N:;Rc&9\U/=6C9[I
c#Id<0_eYFV>]bPa(-HaZRV@dF(@W>HMG=H6U\gNfJ&D:5I[WTKLT/5[,<D1L+-(
IOe=RdRFaeNE<_4eG^?f/NNH+>M+RS=ga,XHPcdHW[]D0g8abJe[^Z7J89&LNAM6
&Gg)21Y:>8Nc_EX@N4N/D_d@K8._Z0)R8@=B^FM&bMT^#b=Q5FHK?(aZ/L\WVGMB
2^BJbL2&Q/)ZDJU>GV8&9CU\KG]88gB=&.C0)MZ6WPCgZ^ddT)H>F@A54eaA\ccX
CP=LCXY7ggT?S)f@gRaT9.dTaY9ZH)a=+<T1MX\I(G=fZYcd8TK,MfQ(X[54I>AJ
b@P#8a]_[Rc#RRTGS&X1ND@JWe9fUD6YD^+?@/\BP7GO0W40C7F^0XbJ=1cP-=V+
@XY+=CZ3dT;<^&YF6&cRcIXc#AQaf=T2MNC]HL76C8fDZ&L#CBYVQCRI.USee+Ec
5g,g+7SZEbQD<J<GIA4e@5BD-R?+5X6+\L,A+\faJ8[\LV.g#3V+[8\1[>\^CT;.
,B1,BYM1[gL0[]1=/D:EEag3R^=MAI?66R/6S-4GM^MVIO(-RFWSRI=K1_9OR7e>
3bdUG=#TdYIeJ1-=[gL2<?/]fMKa-)B;?:f0RWJObc[]aMY9GZ>E7,_FF)K0XY+#
YK)f(aWA1U2?_TVcQHWSD-7M4KA>?(S0>3E#O^#AX]+d5R&6H\#PW:37#Q5T=B.C
E6+L;@-b-_RLJM:RC5R3[/^CN&8@ZFe?;AF@.[FZHXH_^15>eHZ)4JYV]<.JgL#[
0F2QW(UPGB#MFa@7Ld)=+Uc2EEd7cK.[58J,3=S(2f.f0=,.@,^;?I87^NU0B(I4
]@9@^56@\&4[R=A?5:Q53aU^/[EQGC40QcCgEO.O]-QeOMA0@I_O[M#SXV2_a3PP
^^&I.:D</,aa+C]HEggW3:LPZ)Pa[PEg;7Y[/e3B=2&V.,Qea@cV)+G#\W3?MG9H
\:4V,3;C+7>98Q4HU8EH+?f^;4:gZS_\F/[@G.SVBVOIS&@7<c(_QHX6#Cb1>YR^
C=I_b?dQFVC1K#M/C2UXf?KF?]X=aI,/SHEO\)@D6R.&;_5I2/963]?-5ZXfGB:Y
c:KR(259eTAK5O?)gWf14H).OFeA6:VJ3DAN>+PYAE>XQ:+0K)eVF/9;IA<-N&>C
8,L+aID#NFS4I.UN+=-\JT0Z]T[b-07)/[L&PZSJAIRU4\<[3La=N]+H-:F?Zg&H
=L?DfdD>V8:Z9O(>Z;EW=2XD[4cNZLA#5>E6W..))3[^IdP1=D:-N5P[Z60QHY<5
fLA0.FZ&>gV]Yc@M=SE>;]:c)J.d/e_/X_;77HZR\4TTg^VP=Z/1?c:>AT2;3RQX
43fcHU5B(>Je:f2B^.WA-_78[7DB\HI6?+9DCN&U89_]+L^7cR[)/)#Z?->YUA[3
J.CG1d;gZD+FY<DAN?C2(=9JKU:dF;3P^(_f@+6^cWA.?V33#)XM-XAY1<6De68^
LJ:]9+<6,4++7H1:PX)SNV41&LD_-@\U+E\0DP>eWg3BB=VgE+Q?P.Y^Ha,8B_5W
dTZUI4WX=BABM_JZ75E)]+bVJI[]_49&SY^CaHg:L-BFb3\BL9G7,((K6>+H1I:(
eLJb,BePSJM3D<2(Xd4/HIQ[_=a4ObP^4a[)<)V78O7O9(g(WB(7b719QQ8IN68[
(+d?7;4_PS6aQV5#Pg22[?#O]YW0JE_BS_4eHdAKg5fec7B>_\,L9@AU6/.dJ#]J
[(Fb[:OD>>>b2ZA\)+TPPJ#Y?EO=_WA/g13Va=-+O:^9SUSLd_fBBe9V\[Q<OIf\
/M?)f:)E[C.CbO?4?:]:G/a8/)]@?A5(_+W6\?I__]JXB(af.FeU[E&3?T:C7@BP
<MUVe#DD9<?H.RL7>c)/;M&N81Nb_FY@0cM&fc.FaZ8.(G\QJaC#F6bY\>/W5T/(
P39X?++dXb+K(^T&ORO5P8O03+X=.\<[B<C0.X]>ba+Xc];E+0;<_94M(Z&)(^b=
UUfe+TI]4Q8/K#P/>\/e^.4I-6GGee5G;SN?M:#_L&B5V>ZTYWJ@D/gCH^#d]WNA
gX=?6WO>f5-N04e42)[bIV^-7#CLD\aK>Z,_(<I:5Z(Y:E>.>^>c6C6Y;0I:=CWG
XK>+1EWc0LUS>\#WaG/FU.8K9SYNdG,B/db3B9b@=LYY&TfCS.8O3QQg3SQ_g(RA
XFUVcTBgdAgfd2G1,0;eR:g]N6RfW1;E^STN]EaVW]c,DS;,(3G?C>dg9T5_NZ>E
XPD4NUY](C/:0J]EGF^#aGT(NHI[<L/]DI/O]4\>Oc/6W#URfD7I[JKJ4,M^RA1R
C;:I2+ZDZC=)IOY?SdX]KFMf)gH(MOHZL;+2;T:XZ;89;964/R2,Z9[Q]N@dZf_2
,SC/__N#>6Gf<GFV#:GIfG-b06&/:CM]eQTC<I4RJM\A/T/<B]JPGP;.?D;4G<#[
M(]=VM]^+&cN:NBQ@EB(_@=4[QDc.FR<FH=QFR\Y>MG1d;PJSBNcZ@(>=Z<,ISYY
Uc-\)BPYWUObX/L=<;12[40AfK>9J.QKfUQ^UF>+:;cC@FV,eNRf_ZP8.T=;U@DU
H6V])N[RdYM:4[5>eB5,TJN<)HF,_5YWWB&@5^]HVCOAJ.M4DE>+7&K&&b];X=O<
U;2HGPXFa[7E.2_)=-L4WCVBRRNAd:J[MeH4K_0gUb0-H6-H9b;J?:0A@gG[[3Q@
X88-\Z08[#&ATUe>ENf9.WL(>;T]W^TYg)NdHW1Z1M\S2AW>gP,3#V\_0a48NV_1
4.9J8MU(UXJR>A^HDUbQJ]EJF)T\(5d?U?\L514c\QYH6=e,]4d6YMT-bCc7,D<c
;9^IJ,@^4X4WUV,@2faQ1\B/P>#J&8AQ]Zg02Sbf]]1@G/[Q61IUGEP0M48P^0L#
Cd-@a4DX6K:LS&5Na>X&G]1I72#JLS<UbK1MC#aD;.\(P&-^T/L2[dJ6BM<1:Ee,
Xf\?Pg9:17HbPW>Ic4US6gVJZ,WD6,OC[1M&YJQgaB@(TR[F+\_MX2Sb197+NG.?
/P]d5L.eggP-Ac,P&We8Y-(8e0,>)^NN0_4T@6@I=)POM]XN]VY)P1-Z,=SHRIP4
,W9Y0&)<0P40:(MPcd)@d4H?/&(LWP:@J5JLQ\V/;N)EIb9U?CCN:FdJB.g]TQ4R
ZJ1IL09g?[REdeYgGUVF_S-g^#)d\;Zg2YcMHUSN1;<UQb2H9>?aVV]1>=<##=?&
Z-]L4HPCf;\^a:M)4YG7aH,+^Z3cbPHRS2;@E@^V/71a(#Q/L5;TMGY&eS7&TB2(
7PET3)>?>)4T//Gb+PC/g\c^.[bQ&Y@5AWFCJGT5Uf__ZDJWJS&O.@N<+ZG2ADEX
dI](?BT&=1;K3e7-8(9E6=@c.&MWE6U^ZeQ-JfSWPC.26PI;BWFb6;GTZEPD?#\1
2J:\(O_JFTW8#acNdP&F[:Oa@?C@8@I[6-EGcI#@f6XMM)=f+AMX9ZLBEd-OA6-P
R7IY53E(-bFZMBdWF;6&c)E8;^4]@59[_?&C:.@4[a9).,0-A(9cOT-1MP\16.JG
7:Q+OFOLO&3.BGYK(a);-G_AJH0fT49Y?75B-TSgg-dW#a_[TU.X9@D=)eF\G<YU
(f^,0,7eB84e8NVaTGJN4a@G9),I+L=N1#Y\+MTSVBRF:P@4-d9U?2EO:;[bBM@6
X<P=Ce.4^N5a@VGPZVeH6Ib^:LP\0?D2/V_E?bM>OcG,^E50KRO]RS&N/ACM9ad#
IOF)Ye3JG9-@de<C[#VMIJ4>U/GP^C;7#UORg-O7T:/-I[R:C^W,TRDecZMf7U#(
>S?4,,b<6Ug;XV^@;#@Q.cUUTDfWFU:OUXd:LA\(VeTbfM(c?EeRM\/W,b>9:X0C
IER7Qb-d_++F[B.F:Ug@0S^1,4)SIK?BE>.7K,cV3bXE?(V3;C+\/>)ZG4dEPR9H
a7?SJZ-K7N-9c4b8APR.7e?Z_>I@8#?/@H7_ZN0@aVKAC(QPYCBS2+KT:g.D13E&
-ZXEQH4Ab,X9FgENK_,JQ_)[6Se:I52<Y\]2=CT9A_9(1MK9[OVXH1/Ld7>8/W_S
g72LP1JUg.5a^U)IDI1PB+UM.MTGA;#KFbXUGM-Cb6Mb#Q=cf.&25^SGg0A;0G>6
GQa,?2OH5[M;JA.I0,2:\8YP+Jg-2(7\&_R8NZL,V;L2+LR)0J2-0K/O>\KaY<G_
,O8N<_A_K=6[2X8)1UC3cIf@GTEDMRLB3(dHB+E#(_L]44HPD45CYGX>>S_0dD#B
#7.N5b<S,_QT_\AUI7aEd>Z-F^0HR-^YLH9^4fcM+<[d#F52X-Z9>(B4@+7T0RC)
BTRPT5IS4XYZdI6E\#eIHKJ>RdAX^[PYgVGZc]QBBGHKP,(5ecO[DL^_;TH7J2.Q
7=b.CK/WV63TgU&6PWHB#cE-)#V2X+IFKX=CXfVX6H&-ZG<+L.U,J^^YE/7fedXc
>IV&3/RRSM?3A7I.5\,T3FR]X<SUB,]dH[,09O]Fbb93CQ_#LU=Ef##<f5e:0E75
1)b<@9/f[S,H[G;S7HW_7/\3bgf^0\TKS.O4B)5LR4TG.+.cRdGMBUWd,303^VXO
[/_Z]?\F-(LQU14c9LR:6G&5G-1<JKBc<R28bW@_BBPfFBHI)#BE1I(H[AgBgE1_
H3AF+agg\IW48We]]M\4_CCBISR+R#[:>+V27e##TWC0U1\=R\&a\FU;JR^^W-2A
&fRPa#L4DH,a6FO?KWN<:<dRTAT]59LPJZ>bfEKf)SN0c5)LA:5<a3LV64Ma5A7e
W;D?Se,XJ8>5dM,KcZgd6?M(V[D;LWcX3ED\.3TD#K&R>V__+J4b]bM=<Ve,U\YT
/aG7\Ad9Y>4\E5a?FP#0&g07LTUYS3Gd;gZ1Y1Gf04V/-73aRYc9F=L(Ec+;@^LB
V]>6E[CNcd?S]#3KO&YK>G8:F6GL:6F[TRTfME1#.LG@9]A0a3ggXJg&=6cD,@3T
UO&/[,D]R5MDgFW=Og)>2LEHCGcdK6Y+L[NC?VccAJCFLEgN61+ggK.XN+eW,d;,
Tf8K+ZZ\<BXL=BU<VSe&L[RY@5)/KE^?UF)YQ#c2(XUSgD?9J]aY,J<_AUg3[\[U
KM^Z?KA:,L+EPS(HV6)OW6YT6Z<DL7H23XAOGe&c\#:BbXKgMMb[ac]8..=6<<4f
1X_(V\UF(XfQ&/RCYeb2UaQ<1)PVD<Z#G.6:/5E,0UB#EY5<X??66&E^aXJP(<Q&
1K8a]A\?F(S#NN85XU3J:\7[/Q,SK70P>Eab/RCW1IOWUM0+6<=Vg2H4S?5e:\IE
G]:.K8J>8CEMc6d-Z^;T<T;IUf[f?Pe/fW;.NE5@(&S7K?JVUQ4[6H[@C8B&G;Ig
&E+XcF#.geM48P\;9^>e>f>RDUP-0A#&R8F/>1b:H-E_+M<L\3+G,YG_4Bb]^NM]
c?&+KK\\KZcW&Nf,FDGGO[D:E;7TDZ0dY+F[c5G)f\(9DTR4#H]G.,ggX@@G53#8
8N?L.JYYZI&,K508I@+YJ/.e67S:6b6XYB\MD_[dF<7-B=JLW?J=/R\LP+URY;63
B\3c.^UQA55_bRT&<&95g:ePFZ1_FRT48dDETJ_5(6g+S0(9R5RPTMg,#LO17R/W
BPB:[9_5TC5<+eDGKME5?(ZLfS04\:cR@_J?8OUd@M[9F@M((HJJRV#;^SG7QRLS
:(]&OP5>6APU_^H)U&,b&DM)J^3VE6IaN2J]EHF4Y;ASe4a_)Yf1@0K1d9(E2OE/
[b:4Q9JA[\&e5+SH?1=CUYG;WYJ_bHEOc(XZ6gK]3\<+bV2&>9&PP+db?,_.9:^G
&AIVf;EIbKaQEP9G]Sf_2+>PI=.XD4B#3^/U&,@4Q;:^WFF\ac[,16B-b(P]7f>C
JG+0N<U2,[N&aL4ORaHNK&A7CU:=1]B_N_)O9=-486VU04>d/9B38WDW2ZHNN_V=
gYXD?O@&XPgP8L.(Zf?(\&>+WF=1T&1;HOBL;CS34S=HZCQH&\AGP]S&6O0U,AO:
abQS^SCHYHIO&\Kf@^_L[7PNagUH_<\C]V/+K7);]&[Nagb@F@,eNEb#;.>-2bbY
g#1d[^d:1Cg(#=AbOG1-=VV\<ZXLT#Y]PI1+;4I>C@2JG?^;fCP2a#CU6:6DGFZ0
gb1GUab\5<;?&QV(f3#e[a2MR;/<3^I5@8b):_]KgUFLKTYG0[[f\&N+&IRM4@#0
c7N6M0:dS?ZUT_,cY5ae)9S&3(HP@;e3VPf_AH]9W-IXOU61FSXd^+F)XS;B5D]G
JRPg;.-V2MM\3e:P+&K#,;PF1:LXX90-WQ(b?(SI)22g3da3,c^_VVN3D;XD#I=S
)AP/X+GIZB-H0KVggVIB-b0=R_dL[NDdJSFG^;EZ\A&JP#W:8X4\U\[KH41BH_;+
(-G^IM@-Y,4<FY.UMdV\V:ZLcAT(QBL=&\Q]Eg;X/5W,.](4=M0FF_4(#-,UOP?Y
?&aSecfG[BbDN,,(e0#855f>R1,[<(_#VFeXb&4T68RKgG)eM[?5X)/bg?J+MWDN
<,F+d0,?.(<75\9ADJ_)dE)CGRN/_a:Q5K#[HGE0CB[==Y^<@G:]B3c(S,1I#0Sf
OTaf\/c-L?3]#?U=S]B\1JY+bJ+_UGfB^0bV?@44&8?Dg@G)<#/Ee<GT[6D?^KAS
CFG[WDJ)f+U&]1+UGf/,X+34GLU.,97YH=,\?I9/d,PSf,4MKc>[9e0]&+V)g35R
<eO^Z/b.EUV>>D5L65F?c\(IU:4FX;fV&JYTB=DCI9PGJPBfL[L7<+#URSZA1OT?
S5X10L4#QRK1XK46F3DYfPPBRF0<&a,gH[&^(LUVHO&XV.ETRI.4Z?6A>[OA]?NU
dEaT54#/SZ>;S8P)-@02.Z[[7#62d0MU^W<BCZCOa4O[(L??FXg^V)V)Q57VF<H)
,-8[[E9PN<GC\DdDgL4_NUR@;a906eP?L,M).W[#Cg,9<4XC:L]&A]6gBQH/\&:A
?L;SbPHRF):/;-CcY_?P577BD^8\X?agM2K272b:BZK^DEM>KGJbD)Le;)R6F&97
O&7-=L;Xf0B-U#3_SL?>K?f4+F-I]\\H5JJD3>W5L8#G[-Ze2?UJ6H2I709?ZM].
#X.bQD+J08W3-AI1U@?SCO:#,F:,F\KQ0CTP,FZbC<:5,<f;DJALGX5=HTYbR34&
JPdCNEU\]H/.IBM8eXM2KWD.NXGaZG_B,CN[9C:U=a-g?VF>MYKHO@TJ)GJ[ac36
g1;9HeZYZ4-d25S+)=Xg5d#61JVD5VM6-OU>__4.(WTaM)d9L.1K5&X^g/998)<c
IPR&a1ZW\9&&\^3+33F]:9WQ6ZDXGLXDCYJ/aZSfeY,UD-@Ad6\C93FRJ90Q9K86
BE8+(CgTWVKSD\V#UQD2&bdI5IM._8A73RgN?EIU0H?Sd[VD6D?BR=P;\e8=N_@G
:AS:(=LSN:L+C;#WC\S+LE96S]f^H2FN7b?)W1cZEb3Z<-KW+]C?<(T9Z@HWf[K=
4I1Of+\E-RJR#A/f3D[\R3<ZJV_3XeQd7IC)63-F1W+IKdJT57e].3/X08=\-NWJ
D[.QOK&H<V@=ZCHHe4[TW+bZ/0QAd:[JS<1V<XP8SI3Z(bN@c^VTgF;#,\&FG?Z_
d.TX9&YW,(OI_\E&&H3;7Y<CM:W-52?/@HI_Y#:)M<0^FVS41IY@.BNKK4.M(CE;
V=1DJS04)@\O3Z7ZQc?HF(5>0Ugd<Y=DC9>YIWc,JE.;I58a@J73K#PRVA5f@^=S
/C^=XY?];GDZ#:PWG[6D[6\G226#CCHDYI_TG\I@b6FEK;EKGNc_(WRMcX>N^B/b
5B,[&e/9e@/<VP.ZLJ?dC0QP=+SK1&3Z62]@.;J<::0e03dZSfZ)+5<4Ue9fOEO7
JL^W][++I>7Lf6=0M[/g8VedC_0@DW;F[T015;WMT2N5OH<@);2]He\,D@a]LUa<
6.gD2^MX35dL/HS]A7C^H3)##\a?LH;4K+7-R0e9J?Oa[,107<0I2F;4ef&\4CXF
U(6:1-X)=g0FK?/U@6TgV_=HCN7#D/53g_H3666(X?/.\7c09a)-/_#O&<B]cbS1
d2O9bW#bW?6_JEgOTg\;EH\/<cZ0ITSW=_dP]]C#D0S,e-K[UaP7E4-8c8=Pb@#8
Q5>1;-Z-OT+WT5:=PP0OB-0U:6S^QaC5SUL]DgecGfUQ-HfG3T=Kc,;:45@N+W1[
][7XG31Db=VX@15,=GC(>TYZfRf:D)&L1ef5XU4R\HgX\T.BF:f23?d+/\310<9C
TOWcO,E1a190FDc?K4_V[N<J^#N[#C;MCaT0^B&T9(N\?I2JL80,S=+P,Q2S9>XB
;9063#cHTQNd;DMJ66Hdcc9:9&NM[3gYY83fOM(O:9Tc,>Xb?R2SG:S7?BF2YZ>H
Z]g#4Z1^V\V>8JNHg&(W7[X:\[#NAT9JD\BGOHdBU0D96@MG5##.CJ)Vd.&-20UE
>>[,8+<A#G)84HNW66CLQ_Wc,\J.La5ELeQ8//UJH7&)QPad8Ma,MBD67cNcM@6^
7+;O8da7BNba]2?eV(Y[RMHZ/IUA>)gC@D_G6:8&?<^0DVS,M.FI2PUJ@6/AYU_7
2UdAV<@(]C2ZXB-TFB@X7H,N\O13EQ<Jd\d\&F@Ob]J6.8Z7A@<99O7TFWF=<N+L
bNHNFZ;RR>,TCFdDXQgXXK_#<e\,SH@ZD>FQ0G5B&IeT3&R12I9Lg#\6[E0#bHBK
F#D7X^SI(MQc-G9U?:B3=@Z/I-YDYZ8KY3RW24ddF+7+D16KS.dIbLU1#7O7O<AI
RgA45O(TW]&f],YTVAI14&T<\VH88;8)\5PT5]\E[Q\R)[dF-YUV57KG1bQ9@:1>
K\e,LaMeF#8,gZV&A8I2a4E-3dB:YQ:1:K50BEbaUA;SQW/S\<_D-eYFdcgabH,[
94>9+,[E.?DBg8E:DC5;,<N&0Y_&E3^c_-.;bK&DLSQZLd#)SKfeZ8LG;)9BGYe6
,,XcP]>2<G(P9,TL7gT/L4#fX.B]173>/29QF+UZ:?76^<W][86Xd+U.AMQYE:[/
M)9#dM>+f;O)CW?A01YL6:M</N6=1?;-XH_C05Z#UM;^_[8LRFHF71VVFZM7K7B-
ABHMV7,UWXOb.08#(J&FGg@DOd8BNU2._4NgfB?R@+Q<=[682gV>^[IOU92W:0F7
,;X&R;]_A[D.ZXAYH]@fGWaJDHc5R,T4Y0[KbcF?>b(92dNVAQF0bGUR6e;:M7(0
2#6X)a)CPAO-b6[.UeGWgM5Wa,WAAE)3Z1T&Q9Yd\0\D@/^30P,62(3C8F:1@E[R
E0ce(YIXV)T#GV0PUMU4(:&OW;\dDYe@=f0J0gG5R:Pe-/fO2RQUD63YF#cQ8dGI
3BIN<fKV&LEN)Ge>QJd:@OAC]#.I^E0VJV2-F?=CS@Hg109\cP-LNLUW<:RV/.>4
M4,9(.WJ.1AYAc<bB7XO7DJ,HWA0B?U\=;Kaa-+:a6(U#,X0R1@gb,fR(6B\e1O+
JZ&R:#HF_T?.[3KL-a\8EKfWD_-97=LXZYGT30COf\bWb1[3Y^LYA>EIg\)4KYK:
.:e:?[fTY;-dVa)99;\W(3U[-]S9Z?/?5C],K6.EETV5NZaN]E]#TTb/.)^R+UI5
E254[_(\-VAI>a\XYR6;I2HK->KPLS\c1e</_427Z?GJ:Dcf\0PM8DFS\DX6\^eS
&3e_W?YZaZZ03TgM/@db+9;>_UABO50e:BZ\UAPd,R@BfGf[_TR#A;>cH-BNT)e?
GbQGVC3L.IGEAJ1B]7S@Z]Le#0fde;_9840TaPUJ:V^V>F&3+T8^cMZ?_L9OaKT6
E[JV\7^OUSa-7S4GZ)U?;K9BdZ?UdCe1[1ZJA(^DP9[XMFGDTIgS=9_YA4^cDGQK
8.+H-E)JB3]#ZV:9a[<U1_AJI?/X1\.74E1-?-?FL?742SJQZKP+L&B&T)B2MaYO
gc?&.2f@&OVgLbVcge1:<DTME9<VQG66&D3RWF>DVd@QC;H2J^P7B\]OeFPU2c+U
#b-URBJ9,C?ZMWKJ4_X2PVFND_YCI^\6P-B/CP7XH&(=TFF._MT3Da9>VP#E1)\D
CId@]7G)14W+B:<a^H(aJV-J\A^=(0+.df#R5U@[[0cA>EdI7b5USb.I/&8DS2/W
@<Ie>SZMWafPM9ga[b&(5<A1,&T>5XR0aZ;DA@[)^b+SYaKBRSVKKIe6\abNX@>9
/UYb-O\Z,GH-U0RaN1ZK^(M7A=/BU\XaR+gUWWT1S]0fdUT2/FKI3I9;A?.?R/BD
+RHO@b2\Ug8[a\:&:?LEH>17V+/^(FZbO2J/O^2603=2(AJ)G9gPfA&T[3Z,\dBb
a5T5&a1VGQ+K<F,T&OWG<c4_,VJegbZH:UG_42+\Wcc1S35JeAd,J&7Z\_@Uf/I-
T^+#):ZCUQ8,V&^NYYOX(8:>-3TgNX9SH19bLL(J.JT-fW?[\d=(VGK.&I5V/+C8
bP=c&_G8TX_K:(DcP]8&9GXdM/5+H/ab86)PT=Wf]d3MU^J^HN4c/]RX\G.C/7d3
6Y#]^IFH<HL\;?@G9+>F(Z79H#A)G_YA[P;1/d+1&\AXM4+4bC;W07/bOL(L5RF@
HD005A5>B+#P[,1OULK3dFT\-Zg1Be9>A<HbB=Gc(EJg+d41:K39>NT#)ZZ#3NKV
V^XBZ_gBD:2)JF&E/W_]+XO>K3NNc8O_e@GT:2^NJQ<-#7G?Cc,<1P77bK>eB8EA
<A+P.K>f9C<_]fcJ=/A&+-4fU)C_^ZM(d+#JQK^;Z2D-SLcYcD[]B]A1R=/9E+-,
&HW:8fVX:c,8&B6XAg)\@++WP?3^)+/]5.AOQM4eAU5?O;]J0=.AJ<[N:f41MQ1A
16b?KP=c=NW??B3J2^43@F&JK6D/A;P_)3O#@O&D+)ZM0BG\Da08Y@DZKD8&fHJ5
Z=JKeICL)\OQYW+HL0d]1VT=a3H@T9a,b<3OCg9VH@g4=f(8E&9XK1U1J3G7/A.K
1d97R5P&_IZZ0T9:6C0&+V#(3^fK<Y#7e2=DZ\OWc/7##CHe1dY3]83@)OM_<T>3
E5S6U4\M]R>cY5cNB5;#/+KaX#]#&5NQKM7-&_>.Q_8-ZMYDTO&_KSVFEDZPP<@:
@2)F-@1DcG+#ACV1M@.H<:48Z)\42/:56R#[)KSQe[\-^SL5#10&H]F\S4^1e4-P
0_;O)-KdKZGZIffKbKSX_;8QeHB3U0(K#g4UDSI;FG=Ed16#E)OX?6FA_fHX]_75
#Rfe>.XJJ5&#</CgT^NM,dSCY[,.NLE@8ZA4Jg.,;(<D-^KJ^>(]140S/3V3R75d
bb.AB3<#P2/1?Z\(+Hg2I(4&c=?WJ:8-f?:O6=CDb.]70:RCA=CZ\4RgR&d8?VbV
>N=NS;8YU^egE7<I32_BW7].DR#2MC2B:-?9[PXZJ(G/.ELgLSaY<G9#,NQeU/gK
SWN/D04__8M3F-)Z^DT^U^;8M<Y6[G@+#]AE1^XTZE:eIU570[&XYaWSe5.E7cPX
H?(/.^a2<N<U1.<)(BEG-U\cD=&R1/0,E@8[8Z.^F6ULE\VXX0fYQFRVID,^a-B:
VX-N:PHeBb.AU1X+?FJH<];02Q3IB;?#[NPbZO.>^D5gWNc]QYJOW\HKfX?,<_N]
AE)6VFcQ[0LX(#M&RJaP;EN,#Q(JS)[CRg[?N.3Db0?1-[CV?/+?Haa4/MG)ZHU7
.Y,BT+)4.:G,Y1K?A+LC8UZ,f_CXGWYQ#B9I(D8d3M^.Z#1W4YG@HYVA.G9);6:T
+=B2gF,Q\^:DO(T.1C=Vg=D?c+Ge9[gC21T@<8EUeg3f(0XR+>FNJ;gMUM7VYTVT
,(d-,T\72H#]3@5.]^LU2B)<+K]&FP+?#Xa/GT;.LZU]aMdGS,WY;#L7PS/N&2dS
O&BE9=>E.cNDH:?g/B#gIbf#I6FgM9H=@SAYPOZeQ24^2+RVF+PVH.7_gP@H1F,L
PELbd]0VUC,\Cff5=X@Mc]01<F)<AHQ0HMb8^,=5(54[]T+eOZB5fME;#e=C@5^1
JfZ26@11(Z)I+N/4S(<T,S]=XM9>O<&6@SC4GA,;<cINb1+Q8\+^QY/]+++3B5?-
&g4NH9e_-=Q\/b?C&g0;#,\a5bgTU?S\f:Q]g9GML-aP00O1:_9(8ZI6-Df[^?E4
]/#XA<REH?\TSa2JCcMEIC;Y)_8UFa]BT5\A@RR>J]GY((>J5V_HH6B2]gD7Agf7
YX+2Q>^M\#&J=H\XZb6Ab\OTX:>+@6gf.T6ZI#d[X1SM4@1[(1FD\T:0,SQAV+b,
;7W.<EOHTReabF>6Z&eQTb9Od6LU72+F#+9,H^2Hg2UF5(CO2BU0,F:IN(1\(3Z@
?;I^.S4)=K[M?GC.2+AMAR#c9S_JX=aP\314/.UXEf;@:_UfKIJ5G_1f+M/f2QN)
]J:7D.:dcH<9;[f-X03KM&b8OF,K72bFXB0;>5/>OY\:>EYYX)_A<cTgQ5Ab[JF)
RS<>OT5&YCTFEHVF+b,KaT@?_@YAGME.-OB.WF86FQ+_1BG@@D]56Z7XMK@8->3?
/X](F1>/aRI5AWJMK2#;8D))I5UR>.U7QeBg7(Z;Ze3A@=gZF/0g8-N>LcH\Mg#7
YgC+0I)QGb5ZeaR:^/eAK3-ITQR85]Z,BCc:9GcF_C0>W3PJKXW[EZ35H_-_:CUD
MNDXg\)]b+.FKIK^M=+J/ZL0(7^Y4ORCbU@NR0Vd&D=>GK9_,KXIW_#aa_=.^XaO
2J8ae[K73>.19<?0d&].HBEM;WZ6W2X6?P.c+Xb<->Ic&Ya9=J?)KEF&8UF6VO;/
f\^H_@V7B9K:64[AOU7B^?TALEJVY9YOeKPA_:T/DQ4R@])1H^[(C7]P<BNdcV5\
C;Ta&8M\aO^[-@1dWMFgI6eFH(TD#Kc/RgN)7RLKBca?G\7#=^CTC],]I@;@;.VO
H@3/K[>HY^LI&.H,H9\M9(#>RN52E7<JUPQU/@D1R7(adJWJH]1\df@]Jf.e^faI
K2:DA4W(@]6+4MKQK0HWQ-YeCNIZ(;[&EJ.XZI?(Z;NOY+>(OSHT[^b;/YR(MN0=
+De+aL+4P4DONG+X-O\P7EW]T]FJ;f,Z/g:ISaDJW<)Z\/3a#&;I9Pf>Q/8NSP)L
gEEOdcMT36XCM:@1ZF=_Z,&<+F2BQA;B>(N](Y0<I<9IOP8T@+I^N99]I?[?O-/>
;>W](b-+E#[8Y\&N61B50dQcOY7GCTQXY^ND^\EbSbfg,##)@5Z^.=ea0B4<BTF,
Id_\/aF.I/=9gHR>P->8C;60W_a2KKK]CA+<#SNC8bb(?;ZM_Q:,b/WLF0Pa3fHC
Q>eQ#R_b-F&&5AbAV?EP?AMa[@F5D9:b#NP<7VCVb^TQC/#/_[VP;E->)X7LUTQHV$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_JESD251_XSPI_SDR_AC_CONFIGURATION_SV
