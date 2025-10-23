
`ifndef GUARD_SVT_SPI_FLASH_MT25Q_DDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MT25Q_DDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;
// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Micron MT25Q device family in DDR mode.
 */
class svt_spi_flash_mt25q_ddr_ac_configuration extends svt_configuration;

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
   * Minimum Clock high pulse width duration.
   */ 
  real tCH_ns[];

  /**
   * Minimum Clock Low pulse width duration.
   */ 
  real tCL_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command (SPI) command
   */ 
  real tCH_Fast_Read_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Octal Output command 
   */ 
  real tCH_Fast_Read_DUAL_OUTPUT_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Octal IO command 
   */ 
  real tCH_Fast_Read_DUAL_IO_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command (SPI) command
   */ 
  real tCH_Fast_Read_QUAD_OUTPUT_ns[];

  /**
   * Minimum Clock High/Low pulse time for 4 byte Fast READ Octal Output command 
   */ 
  real tCH_Fast_Read_QUAD_IO_ns[];

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
  `svt_vmm_data_new(svt_spi_flash_mt25q_ddr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_mt25q_ddr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mt25q_ddr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mt25q_ddr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_mt25q_ddr_ac_configuration.
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
  `vmm_typename(svt_spi_flash_mt25q_ddr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mt25q_ddr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
/Aa+XWMcA&cc6#M7ae>./f<@RH(c_J=c8g^4@O_#BdM.S=^c/dY=1)ZW87W.W<S@
EVQS=58SK.YN:57<[&K;+1;[1a?,08SR3E18<XH5S-@?URC/[I-0^XPI9&H].&Ga
&U1W0@K?8@_MI-1>8dIHX==S-6c-Vcd@[I0I8e==gS7DVF,>D2[bf#ZJP0IeDV>a
E#HACd5XdF6<AC>M39:eC06.\L))3Ce2/EX82?)16G81CH/aZC9M&CGA#;1=FMf:
:Nc\9C>1fL4)D&.@M6f,W7_BJF>6XEWX4dbRH0GGOE#.D^3<9Dd6MSK4B8H4#X-Z
Nb9VKe@CSUOR[Bb1@^K_-g2T7GNe_3SYTU;X[8],CS(1OEY?MIDb>B]6g2QV<GP]
K-cPcA,eHX3d#QcV<6_Y>[dM-M@M,J#=B7g=T#-aT]e:6VJS2Rg=,QE_fR2,E8+f
AfYB\[[ODZ@be6@e7E:fHO].9f6&Q7[?S/F9]^f#A,0_]LU18I:BS9[KOY[]/Q&>
.<2/^Z6B]ACT71?+.N5?:\JHC87=DfR;Q6Dg\EG/<dYUBO#1Lae[T?^Y4E+]O8HN
,O8RLZ@7+Kggg0gG\2cLeK0[>DGJBB^eY/A_K6#LK58&_cY:[ebc-OKLOOQgS4>f
5^-:8cE-LRa5&YaPU5(;46b)E?PFLM8Vd054^>DY\.62UN<E-ART1\)1S/0<^TLI
a::Z?Kfg0He=7KX]gADVG99Z512<X/BN45FZ30#Ra)ce8>f;T&^6gC^T5dG.,4KK
XV6aJMQcA(G\S-])>&WHg^9Z5$
`endprotected


//vcs_vip_protect
`protected
-^:(JW[DG_fJNU;BGM6?IUb_G^fY#ffK9U59bYHdC2\_[(->@cc.)(&\=4O+3K;c
GaN,WOTN,3SQ//LLPG^#RD<3[(F>]MT25g?aB?+22HeK)LW</^bQ[V.4YVJB/H#]
(AI9E+dWB@Pc[.7?E4C_[;17T/SYbP7@-&@Ig24L/U@CWKN<[EC_M1MVIK-(5Z5/
J1X/RZ:FKYG&5O-5ZR?J=3WY[R5;KQ#gd3Ab1))J&=cCS9^HBX9Q@V)f+-O,#B:+
=SObY(HG27+MM9ae)A--&NWS-?G54-.D9O;U77a&I_,5.QI]eN>ME5;GY<G5Q#((
0QAYJ37R(;S9[:ZX;LW]QXO_8O09^1.d^LUL^_I_U^RfH<g\b@KSG/L)K\W?2/W=
CK=O-cT,aB87)6.1<@2[?U4Fd]4?-\_[BO]UV3DO?_([ZeMNL7A5(AYDZe(0GDTH
U)g3_M:+9e+95/CG\21<[W8P(-UT[UdER3NI@6I_FUVI3fd482R^J2g2^L><X\HP
3dPdgP>f1O8.(&/G(+?,(80-Db4BdY6PD,/+.<>^L\)_M\g7=UaF?JN=TXF,UJaZ
dAGA]G(YXAZV+)K42>==,_5.C<3R]35+6SRc2>a8-ZJ]1-ET95I^cV65c.7[(b?X
M[MR3LN9A@&ZG_Z;<I-Cca3\Ld?-M+f.](<#8O5f1:0H7^KMUX>B<3.UNNd9JcRg
C)LN0.c20ZPRI26@Q<C[TY-=HU8)4+B^VTbE#R.)UQ:E?Q_Q;/O,E5ULaM,J->TT
9\aAN0;A:-HKYHPe]V7<[LP(<;]FdTPf9>ABBF&F+)Q#QIe\_gHQ+S^c\NR#OL++
U96W,\;-64OJP8_R&b55TG+8R)77;BVEA.fb:4+7_NH?b[9:+31M<UL#L8XO)Y^2
HY>^[+a/dD;D^2E9L-9SF,4X8Q(VIX08V4V\D,J0EHDf,ea>)?@-YB.@\?NF:O.O
NLW/AX+U@HSI_Wf=B?De<:>=9#?[B.VG,.VU1O=RC:e[J,ZeV]GP5ZLaWP?[[L53
5(I^DPH-T:4PKTKeHVb0R,1ICBaAb)GZ=C0R9VPd7b/I80\@;H(NQ[RCe]Nd9@\V
K,L<J@^Y3+W/=&/>T=[-?;3=.9JN[2-.&,VI@URQG^W9dEN>#)M4U+HC:##<Ic7,
BbDMB@5-G6WI<-W?db2-G-&Qb(PT;c]]99F7@BeMVX6bdRZ)Og57(@+LTg<_0-CD
eZbI#_Hf\5S-S&();P<W_6ZC]:RFX#1,g2X>FePFg5)HQK@2E74KLbC1I]@efF(Z
QEAA4\8O=+J=7#TH1W>JP^;C-Md(W<c/a1\@2AM.&4LeC,-c-HO<#SP>IS0RO00&
WGdT]#c8VK5<U:2LVFBGO.?Z3515^^Db,@CMf:DU+NY_D)HT,B1)<C:6YM\Jf)EG
\.S-#f.[V_O1FI1I.P>g9WR@+^8BfTT;LW-WVDN/I=1YFeHVAf:JUIV:5.g?50:G
<_e85MVSG[-YNLDN@,\9c6#O+CW1Z3R0&0<d:)+.PcA1g.)8[)115dXUA=K06VI^
FBE4F=KBF/->WDT_15\T.KO\<O+]#5PX1]8>LM#8O_//:6LCVXTb.dGIK@8_1Bg9
c26:g_J<FUg>48B(5D((U_,\bP:3E42Fe+?^U(Af@+OaLD<f5FaVN\+;);KTFA.E
FEA\eVLP?CQ-6KZGeV<QZc2R15bF-G/GO&V8)3)H\DbF&G\4TR>+P)FbRB93Q[JC
SFFP&.ZYXE_)ec]T&TL02)>5F[5H)Z8D6J8U+67_F0)/73S18)ZG(0R/0@FRdGSE
Hg:23>V:4_4MD\YL3AJ3)U\I7;GSS,HQB;SfdgOM=/54_IOBS?(Q>f.b92;=S?+8
;.Y3NeS7+I/8QDE2WV87JRZI<,1-YR^8,Ad3\J:c16#0.5AQ#d09e-Z)d_.#D5ON
9b9#@D<W+@EOWYd&W@-.<FZSUY@<-;5VKRQWfW5@\GI.efYZQ_T14)78BaIR[@@a
TL##efMD.#ZACUdH9)(^9b<G0(?J^(\J2CSg:OV60V7aN4IAL178F\^CdC&d)@@#
20,7=bO;&Kb(LffJ/CU#Z#Tb]0d_3.JS>&(c>)7=KR(6G\TQTf[05IHACHMagM^V
+IPR=SbJ?CS6O1>?Y7_Gc88\W4VYc<2=B3-#71-?/ERIT&?fFc0:#&]JN5_+4]@2
D@7.7gVafDcC9CXR-7FEM6MG.8IJB://B,K>?8-BYQ@EFFA^<f))f5C&VcB=D,1,
7QC12SA4_/\MS?.Q/L4DB6KUJ7c[X\=@S25[L=/VDO:aff]G(1UP>C+X,&,-644?
MNZ;(;XC&eBb;5aW<agR73S_U.9b:<bc+0cZ\Q+ED5=c7L?9:Med84b)X1Z2a<)>
Z<L08K((+.]TQHL-X_cM.e/SMQ&c5(D;S1L:(2O\e+VM##:#:;8EI;ee1\f8b)d4
dgWcf@9MaZ(UG#H\Z1Sa.(7[cD[3:5[4C6TT)K0P8?SM\eD@2QbPJ[1WIAV8-F]U
/8cI4,I&dMKC,G]f;dU5:8e<+(8@\2aY7@2LJ65+3cP_[)a^LD-=dZbIJN#b=>fG
eKHPW<O^09#b9B408Ig:DGG[QW#]<46ePJ_59N;+F2/adA:P&GO\]5U,&.b\Sa>0
4JH/)\c<DTCKcN)\FVZSOG83L-TSf[>@,G2ffR?)(\0;50._Hc+;02&LQ87gER_)
<5O:#J,cF6]8gJ0G9[&+APV>fcNA+IW.P0H@MaZEBA7G9X;FeYUca\,4A,;GRSX.
R3TD4.K[e/;<_W6PN;&aT>730.SbI06/&6bZ;?<Y8MJ]0]_Ud0c9N&a,e^]_U9E7
3T\A^]8b7NFI+2B/)e9(&36>92EGCC>]^UcPTPNYSb^SXbL5D/Y&KeGRT+-BH:R2
ES60AU=dL2U2_^,dAOdRIZE:Sb0H4IET[L^(E<VfXHe\S@LS#)b#:2I:YcG68W@J
=&YNDd<]98Je.2HV9&<7.V55bNg(MQ:/A82D-T@72LC[a,K[+J3c\I0^Zc.,[ULT
W1H,8+0P6[/^G^(6,RDd294LKfW.ZW[T.MH79/EcY[G5=Y5#]XV1>WFK/aYUBB7G
4Aa])Z#8^KL>caD)dWg#(.Dg2^Fcc<VFJg6+@OOORA0M(BJRQS?[A,FQ5=_&,K_0
.6g,MF2Q94QL-=M@fP.3/Je+H(IB82@5NHG=@W&_R(N9JHFT2:e6Eg3GZ1NE[eVV
3/F?D8U2Y?VIL^R^3;HUG(4:F<DN?Z_/9gf;BRIfFLE>EY:(U@]_+\/b+C=8\C?e
[E>+Z8Ed/Y?,8G2A3^bD[]((1TPEZE(QYJeQBDB^7U3UUONXJRccDb20<IYcL0+L
VEdH^dU2.G-,-8GNAR2cdg;MOO;SL/Va][\<F.?OQ]LGJd.KOG9bV17c7(cdS2/^
2)<Q/\TZDIA4[1HZN/9aA\=1QJE\IPW5A;FcYSX<+>SMG.<JR0;V]N0dPPRHC3MI
H,&/(-4VbHZ58>U-FH12d?R[caUB3WJ?.AXdQ=B]J(;:R(KQSH7a7U955&58F2=b
+EP>\[eNbc75X6+Vc1\JJZKJ6JN^XII;g\AZ:I)UbcMc?c5,&/J/-OMEgdKA?+>9
TM;0cO\/\E6d2-1YZ\_/)OU,#039FZEWbCQ&T&?.cgHcVA<]_;>a7aJ;#PDCHLHW
]8a#2_3]P:+5&K/e-&IT9&Q[,DFLa3QSeAeRY8.&WL728TILW#L,OKL6</[X:G7f
J18LWgYFHaZ46S;/&Q9egQY1c]_1Hb3IZ?(29,LC0ZO1V)R&O)Ud</C9R3A<.Zg7
+N^4R=/^\QI1E[\8^;cH:Y#?b(-5Y^B21f6ES-&5TV.,>G@cd4G+^Qb.8V]E:Q9W
<5MFAbG(VOeYNBP9gN4GVIc/g;=)bcHKAWRI_b-C8Q=EV8SQ<WG/cRW_YF?+R/28
25V\>TM)G8TUaE\df0)FU[I_N#]a.Y[?T(?0,BgZ;0dT1Yf;9O^3XJXKV-<Y/&9#
A(9Z+TTJaZHS.EU(6K_MLga/(/bD1a6ST1RZDE^_Ad3>cUP=;),/)c.P();]C6I=
=>^.7\D+F7CG>7N47DV.ND59_NWFQ1;]K(^#_M#5Bg@;#[-[af[7<]=afg48?:W)
XK0aXTb\FV(8LIbHT0DNZV^a9\Y3JYR6867_=\]7#0\2dSZabW8@b\_5&X9[1ZQY
?AG+3]O/.+Xg8MC?STXU7#fV:N^I@I3OGZX@VM,N[+ZPQY/<2X_J5IFKHUf8T:Mc
A0(HgHGT33745U9]N^WJPfD;/[XIP>&d-PF,Q2-J\d1gR-fJdFB<b7aUHB3dTDWD
9bcRI6eND[4KE^Y(-N;Udf-_PL]=BY+W9/\S2M]W7PNFZXZ1cI58W]+Q67FL@YAf
/:51:UeN44S+E&Y:dWN2=e=F[^a/\Z6TA)0(\ccGDZ12Pee6P>44TK&g05+W#H]E
/LMcPF(>&3U;PI?6\Y#f92cNSEgc_=#LTE,YX,1dFbg8PLF+/I5aW[\.A(7L]VSS
0I#O@VA0Ka(5MG\D>+YD[Q>aL0:Ub]W-49H08bVD1(A0=7F?W[P^YXP60a,\OfR+
M3U.#?\JMf(e6RO:LXVZE,)(MSIB.9TGO#b=UY1Y42Y3Vg.1MM.=_ML\Z4T:]:<[
<@H\f0Kg8(JNSJ^Be?f\?b/ZcH[O/H.@a35+(e<F;bLY<B#WM.\XJ<b6cKD77)@2
GSM+NRPS<#((R-^EJ3KF>X6P=X;=?S>Hb@eE+WfAFW.f.3JJ@F&3cB:e^EHC#C62
\;C+]KJ^@10@>]^BJ[WAfZ#CXFB;OTTGgR(ATg50e[LR87CK-Za3QCg8R?Id<ba>
)US:K7ZVQO;]:#5c>#931&=g&YO2-\6MX/EV2(c34\G;0;bAGJ32.F9)aM1VGSC]
C\-,F9JYS:[d>++,;Fc<>&Y+FJfKIVI[]5([1J(W2[_ITc,]R_7Xd),+G^EaFf#-
)OY.[T+?(FI1Y#\#VO&e(A:S8QC4DG4d+<QcLW?#<LEI\^H?F&^+E9/8>c2OZaK_
>V8@55EgMGL<BN8WB][4c)^QSed&=H1&SVP[KE?L&ade>C8Y>5MF/R8^9QP+?C&?
d8CFE&KWIZ7QGfC7dKHRQ&(fgH,8:-:&_5f@XAL,Vdf_,8>=T<c#b_+WM4(+F_eK
&S7Z-?3eQ-13@J>>U/KZETEG2cBQZKIb-GeCB.EFg_a0Z@?f^,V2I>_fZQVE2M0:
<,9^PP^;d)4&M&PZ[Cf560L=8,G0AH95(,fRP/,&(6aa2aP696-V?>B@NGG/Y5V4
+LCV)]7CBE#-gGXcf\gMH6X])ReTgSZCB8Z7Sg76Q5B;C^XV&62CEW?P;aWCId:@
cgA@+H_U<a?.TRY2:S<RX4X/\a&3dDdXE#Ub/#V5Q\,V,V3(J6-dC,DB4cGX+1d+
IDS5ENI]?O=g^UH0U7S3+?SESX91DG_A8D&:&U2.05(0Z-#,(;5X8J]FG-H&TLbZ
I:UIB?#b]F(+;ID#KM0WM9>a:H1A?RDB]=];LI-QI&5&d-f3+e:D>#gb?[DBPcI+
]<Y?T7XVH^D6C)5QU#?F=+dR7Q(^QJM.e_fBGM0YT8>&;(HcZ8[VZ]\g@L1&[:H\
PI)aFOYc/Z)TZY)_a>V/>V#?;gPYD>1b#WTWg^V?T(WR=&A\NQ\;C.R]XG+Yf=H@
[G:R#(_QEacFL7.)N9T<VUVQGS(1eVORefJCWb[QU356@9Jg\?;W@:S5<d_O?(TF
2aNZef9FWM:Z0,+)<YL,:IOHF(e:f0NI]L.#K8L?9<4dAM?Q&XX6.PU_HMdI:]eR
=P_.)J4^3I(V?LWb_3WX_[E/^V[I;W8@,E4O#G@b-NER:Y#E;W3_7>c+/R7R<^X4
@^SdQBg[=;gB/c2;BWC?-]Y(e];QK?fdT@^QPY0<P&9R<;<C3L@B>11I1)=?Kd>/
?VR/..(dGX?_Y6X/5E&/fO4?,bd\TF7J9\P>\.SY-IV?d7-HE&bbgR9G;1<=R48W
P_Le\N6fV21f@PB\eM[&[<BWf(&bX@3OKU.C\/+:>6ZV-E(0]b;dC0RHT8c3OWKK
gbLP?5Yb,KUN8OcG7+&&DD+,@CQ#[]gFFQ@T^Q6OT26W?HLe8Y8MBKH;>W4b/7Ya
4bc/fHM2;g(81#gMK(O4DTZMM+7RO-[b1C--GZTCUO;aO=S\K7BX_7:WPGeDX=E)
F>TP&BDRf+g_@&&egg@eb.K-;;>I0&Q.WdANL:2C7+3Z]G6^D>21e8DK\OTb^Z4V
6eWL(DMU\E7K/=Y)624e<CfB5X3XDWV9)ZK2cU/00M/W3TbA4OT321[^Kf+,9R1?
6QQ93GEB9.PN.\=/8d^eJ>T1LCGQM(CT]><gdZ+9IRQ,:P6V7JUc]>RAc,@;\;:-
^TD<bd5AE/aU+0(H(2=RDe)L^5Z:2MKOFL1=a#Z(8M^DQ;5;L5NC=<<..V0]]<f;
-V::F++#B8.4)A8]E=:#P38cXGJOa\fL_ZZ,R6#]gA]R)1U#5bc6^#\^FfOFQTd=
2AeYAD:-&PHRDH=OY10-H6QX]S1>Z-BJ^-F;E8<\9+7QRRP]a>0VT7DI,D9+0cD\
f.fE<B2DDINKAZKP<-;aIHT9\ZcQS6bNPB/>ZX)ef41Ub01#L0R_N1FaTNSC_Xf+
<T:W6NEUI/&C;SJU0#TBSJ_DE?MNQ,_9J0gg#f9fD=XU80N4[9]X0@aG\HZ)TJUN
CR@@N[)a,+[TD5_]E8?RAM<g/RYBTWFEcH][a4K^K[,TMF,Q0<,?,Z@RVBTU,8,2
1FaeR-<:S+.U4H,BN39eE7>WK,UK;4/HSAbK@G,6AWY66^NbOVS3;O&da5_(?NI.
:?A.+[UH(4Q1)O9]X&YEGXUJ3K=8WGJC?fGAO56BIeNIYeR@c._Gb7,JV0.?0B7G
c?@U^55>:ae:X92R3&1S?:/;>\0+Q^ACc30e78=>I^=F-Z7IK\:g0\cT=I)66_G2
AUP#8G?NTENaX<KO>MT9,2QRWB7SJ<f46KSO(BT@A].(-]b5;5)8a7d5fcCOLS=N
TY<7[#61S>GG7V?]>]T1bN:43DRaK63YX+8_g0+7>f=bST>aGM24_IKB=#_J]RPS
cOfS:;cSNeaJG/#L@0\#@9^#LC@7U0=-eCB:J<T=:7<)NH:(LcK7ECc2RJ],5\\=
99&76Dd\)C]QDe#c0ED@ZeY(RAR)@f0PKRKEI)U5)b0].F@Z8d3A(f.gAf&=Y^O0
[Y/5JE,K44GA\+E4Ff,FZXgTX9d7OQE1O+?[VMMW7,Gg0H;g_Q6N;OZ>12RW9NKY
.3f0D>S/9)K5Le?UZ=Kg+])b39<QYL^KKI7Ue#bA/>>=AP#bX):ZVC?dN-CBIa^c
8-f?\&UDFU\]Q-SYcDfa:EI&@d#7b2Ua3;gL-^bZ-I9N,UcE5/VZB1-3RO#1^&FQ
+daHF/;.,[L-8SF(g9Q(T\cUK1=WQ93WT(-)Z:_A>F.ZGC+9LV._KgQS#,RORQQ9
Je<MQcKYV]?:eAP.@C6BZ1V<V^7P@O)+\7a[VF:&g/XD/8^RZ^JO0JL^O/dYO7JW
c&/7ZfF),5V9AK\87>,M(aK26:GNLL3Q5bFTLD6=bD\E)JD><babWXffKZ,>_E:=
K-AA\-=LR(TLYY@L9]16P+0WTH;1J6:c>?SfUP\3LL[B;aGUgIPYDeM.,JDJ&JOP
VOZCT+>>_D8>cFP]gD-NH(-fGgJPISDUgOgHIJ:.(QT?B8VW6P?5_9=D9d(CR8S_
Y+3MNe+S&5F<cfd,<<V)=61UQgKX@0^J/RO(Ub49Q?<G3;5Ec3KRF\1)c,D?)@+8
F^L)M:.@K1O[=AY]Uf?6J0GGFNf=X\Q1;)/=c,C)R:\J[(A,^Ic^XeEBReSAW_Z6
RKV/G910B,4dfOR6K,ddH2bU8:_eGFbAL;aU-:,B9Mf)WgH]d3.=c\dc_/4A1^NZ
_e2?XTZ&aXX^9FX;:#N0?/9,>U@GO.b^?@>OJS)9XF:@+G=G<Nb8a]ReMK;_A)Qe
(\b;MfPCFH91eKgZRHF&>8:-P4\GZ#.3E[0^bH;&Y[1:T2V5(3:WR66:c2_AZQfT
NW4<dT@2dC-fV.@bP]9J?PO;>.(G4b]_(Q[0[R&..]KC2--F+BHgHf+9BS]@10S)
CUR04E&MSCB5T#51+d?@L-HaIS+9\0#fAFfIMI;(AF5]EINR3L/USg8P)Sb\g9K)
2(g9e8L>Z4VQ(f&YSR:/:(,#JA,(=-1\QA7Q]EHDaI5;XN\4T/[5U,CHYW:?AO)#
G71ffW2H^0dR>c+::\Ub<d6;135+=JHFff<2G(020W)bN480&W,C+>?2^bLS=/?e
VFF+.8gf9:YQI5:F+=T8e>)Ra,)S5-TL_JG6_-ZQ=e?M+.4N\eORHWC\69(VW\?;
@/8I3RT#URK(d1NZ,7ac;;]BFWP1O38>EAaP<O@?F?+.-8[d#eG,Y]Qb_Q]Wgd#;
VZV\5#-HV?Dae-3B:,M>dK88Z(a+XT]D(4b(]Q;[ZZV1.6\8=f)99fFP]H@9,Pa=
1YPaAZIF9f?2VY6]g]U8.Y8g(73.9RYJHa9b]FgacO;\AO]UTEYJ:JP]^F6#/#d/
=0,:?7+42E\M;O?GeB(A6O_^A)L,SI7&H#a9bAF::KKNgM9MZ84.8/:#X\f<IUGc
6Z7-XZ4@D((>Ee)aBC&FKLT6WI^Nd]CcU7FT8WYV&?WdTIc9EY:ZA8/V3+)4R(C)
@&70S-3?cZ7@NELL2[f)ND3.E]6eRUXc@V&&f7@1X^dN(#fW^&]Ue<Z70DX28GAa
L-N&+G.(A4?U^[M8G:XfR1b,[(\\78X24JZ@QK+bb=M17V.Y+&5Oe_+;acb]SIX(
=,UCOb8];bP/[[Q0O-\AWS@P.&/@H?00bX[bGY@/0U+3Eg4gR\:R/OYO+3/6Y/6c
?TB:K7Lf^0DId1>[)0MV<ATa(aA27AabIP0UD[PbQ8W(N5\Y^K?=KPQD[=(OC&WT
9>4M]86a1>VK9a38M7b.Qc6C@:H#TPBL&?4D].TU#HH>Zf,F53ZdS3NYEU,(CW[;
2@]\c[.#]@MMU^XXDGC<R/<a7aH-V;04cZdYdY\9\7CZGGDH=R8/U6]CUa0ZLCTV
;,#&aWa_.>4-=1KL5DbHW9,Y8F:[Q&TB5gSL06F]aEc[.D;\BWB\[H+6/U[32RKd
#N-cFOeTE.cUfMR3@JA(2JOA?(4IJ>RPBdaL7AD=0_MXc27JJO_:;R4EZ=7?4H^9
E.g&9,5@)g,6e8a+b->TI&:#6)^X,:\VOV(O4eFW]Y&6[dZ=U.^C]5#.=T8_^K.7
\0Mc4_C8EU#3677CX,R.6dPIG.4GX,V7AQce2<SZG7,Qb:a_gfRXOXBcT[I3fD?)
eVF@QZ2ZE;3C>J75P49dXR9aY(.L,^.Q(V>&7c5^W\?affDH\Q:0bOd\RXYO=c?)
V?KEWcgE]#;?G&KL2V.;JKJEE;f#RJcB2/:Zc=YI9Z33=edFM[4##G-G\.M(a0/2
Z6S5=KQOBg/VaNQO=E6.R]H50#:)3d_J2PX1C9Y]>J:gd2PTL8>9C:_X@<TL@+WQ
D&1,1\Y:8@gAH4+3Tba<DSB-S\/MZC&GM0F1EQHY>e^_a-)O&7+\XS_7JEgQ5R[+
[F7VN52W=XAPeNJ7)Z9,/_e<a&f4aY3dSg&KF+9;UK_g><MfLU,J,C1==,WdPD_K
7G#b4&-63,7]+DCW6H9[+/DLVTEggaJ_]/H\HYD<eEM@JUWGaU2(;UY.LK8FA1>8
,ae&C3R0^f.U/M+W=KG7<dB>dc5X6/4HC[5H9dHfPa4SCBeXZC8]]G5c5+K@gb8-
_GH/;@;N&e5Re2MGL-@,HS1-e1LgOM?7bI7^7ec#(c+TACRd:5Y&W+[R;?fH.OVB
\=1IZfe>>;L,C((9+PSZ?TfCDP+4#&L=]Y_ZF^QZ9+W6R_4JP^<2cR?G/I7ScM3F
1\>X.=[>#>eE+gg#\Qb.aPGBYHZDcag(Z]?fY5bOZ-0(3++D-ZM=KZ->/D9a5Jge
#b4O+BPd2CT/5dRSW7H+Y#6e2dZU=FI4H_ZWN&)2;HeNGIU#\EDgX,O#45Ke#1Q9
H&3QE@ATU&dEafG+NK@@(STfQAS#e9c0AR[WDg;D/&Me8TLS@:3AQdK9fEG#cfdY
>HLY9^gegH^\^^EWQS67,<OPXA+g\32eSGEA,PV1##;[#>e7W[+30-g,39:I#O^T
Hf>Q9e0]/ZT.,99R&]MGX@^5@?/<:U\U9V+eH4083f&3&Z^^bK:R@[Z#7Qe<6#bX
7)0K5cQZYF2D-5<U-<J/dNBMTFWe+HM1,3bL0KQ1NA?WTYX=T:<_]^a-Z<fMVM8K
>40P5I#c=MZHaN=H:Q&L/dUSC,0H&a;Q?,KLTQb,?9b02Y.b?7&<DQ<a>VROF:gA
908PdU0c^SXC/a>Q-1N8RKG-.NNcC0S8CTU3;LdV9\Q52N,^8(948c+L4I)Y8F;A
.b8]N6(f4^V^BI.UM^MgK&L,e(O\/2JO823b61JI?CES700CD]RTIMSXE&bP#31;
[J9F0E-(N&-7VJ+4AW9P.E<fd8Mc#WX/+/bNe^YF.?cRLKG].5ZaG;M+3NN5ELE3
>\YY+<-Q\&]?3238cH)B1O?.eJAB.6CNY)B6C;0e-1]\]V:3<J=E_Xbb0/:G\#Z>
HB9WQbbQ+c\f]A>8]R:BV:VN7SB/#>KIWR[(aYHC0?HA7f)F[d1F?Y^&Vd,T3g05
BVZbJe?Fb7F,)U<2YAJXC)VJLE5427;95a4(CeSB&2:5[<)HZTcgf43#/:)DAfME
<.XB(=63/C8[0BB-].X:0=ge<:_.3+4_c.cLfCIK>9Cg^/cKbTcM<COdd>OP5;fM
2SVe#P-FE_>F_)X@gK>Z(M&B[[?S]3L#/_95JHXDDN7\b0Lb6_7LeNK&9#[#7=aV
_M#^;b>GeWd2U0)M2&M7A[7<SRYc)f)11MV\1=0X\\_a]S2HM9N,f(6L78RIVcJ@
40Y:Q)ccKL1aSNW4Fd4+5C]7ZLK]BLKKa1[-6Bf\cIUcVK&R:]M)g50E2+..@Qd^
2cLfRK1J?<\d,f&Id8a(\Y)NO&5@X/4,Z9NC,eaEFdX6/98A>gfb>S,T)M[(H1@.
I)&e22Ig/A9)^FdKUD#g^=?X,OX&N7-<9FNTXN^Ud)\V1Ag6AGcG7U;AS.J7J@0?
g51DY12KNa[5gKDb:GJP#\5VLC.6+XXEUQ.9.P<A<Q;=T(1g4D/V[7=0g6=PIF#W
B,dL7Za2X[URg1WMaEXTUP@fS,YTeC1F(;638eHGQ]/3+K5\Y849)OLHSgN1_N7,
<DC5W>?#>I1d7,gdC,1g##NY@N3/,VICc[IGB-1I-Jc(,ga=-Y4R.3]1T2AK6^Q;
#Lca/0?SH5#N1[4:Ve?ZRH](Rcc4^d3;U,EVR.c]]--@@U]d9\AAeNWZ)KfIQQ:X
?;H/IP<;T+AeP7-cJ05HC4I5\RC\2O0L9)=PE\+ZRH&KU/B&K>KA:Z]@L2Qe2?B2
-&N,5HHY5N83R7VX]a)9CZQ[K>_8aU&D>,b1Ke&>?8)C@CRZ7=691,(]XBC_ZVJU
:\@2X;<L499)E_:]A)CXT)?O1AVS]L]8,@W_8OG)L1TY0S>\#3TdHO<9J+RQF2BE
VXIMR>fHGg3UA4cBWI@J9eM@K:.IBBI5=cIRcJ.ACeBBf2Q9_0Za>+.ZKd2RbH>W
27GE9Jc:L#fB;T9I\ZZNHOL4UR7OdcM1#V(R+;\9BgfQCGXL\&OKYI1Z#H\9VYUT
A6#+^:aFbEJOXf4V-P)L_]KWG\A@RcX]L;0X0:))NKO6Lce.E0c>W(4UPXP=P.YB
X@KW:S(MM)4[S2>(<-IXUYa[)9EL3+_K<eIZ>7e#^UCNAA0e6YAZ?BMcdN]F\?Y4
/,I50CT2XIDFDXCA.?DS8)SCXW,QF:UXJ^RHOP2VV,WLU#8U1)3g[6S3)1JBZ<SC
1E++WD?W]Se2>]TEU^?#I&IA6G;/95A-afAM4S_DDZQ.AeLcIG:)&#]<&c4\U@LO
/IZTVGQ^)_Y;D-&+8R:XIgaVOBJ=Gg^DF7G^><9R@+.f3A;7CCM6M43EUZ4[GVUT
E13V07GBCaG+7?IILZ4>J38?Y^;>(I1bENcGD<(L:-DNM[gFZ;U2DHPNSUHL_cQ+
W2=U>/KS3:;_?aOB8T&8Q.Q<4a15^-bU0616_IG&6eFUQ)C.a7a&@49Sd:KP:<f&
ddIS8(FRY4bN@G?>4&V8T)#b<+[C1LdZ[>ERI;\C[f^=6/LNM9A4I1+^9C9,/(W5
(+KLFWGL.aLKc8E]A+g(=GA.CQ(Q[]/.bKN7:KXeG4?.WE<LWe:b@FPNaY(N)-K;
J_[0^JaG==aB^)a-_MF6eG5,_a;;+,3S97FPE1.C8O[8Id:4Jb;U:dE=e#_S2g&S
F[eSc0S:YJ41c+cN]UXW\SLY15KAI9g(J>].Te\b_cTEC?LJF=aTTYTF,)T]1IcA
31E<9=J3:97SW,cX8L[[?L>E@D.fC@97?#Ld6[f:,Y<J]g\O6Y1V-LN,((dL[NLY
EIBM(I2)JIIY?^b7LVPg>)8?DD/B]8S/:/\X=D9\e)]d4:^7R:D=4g&;&=UQSN#V
-22R)Q#U,GM+Z(UJYb+?,PO8@<-7adR_/9VDeX,D]7SdO7GQ2Ndg7=&Q0R9dD&44
a,(FW]/.5@8,3dD+S?PMCV9J3\3NT_ObPP?5&W)(-;b@^;P>:Wg8feTCJ+d9Sc7+
Fc5^7(-B@a#PN48Q.d@X/H\d/0(Y>c3#K1M=]JN-I:VNH-E+@P5/g)MgQOW536e8
gP,[9CC:0(_-[X+.I-.eY0J#LF[.eR2.T\CI]O4-0Ef8RJ0]\1Jf.I,=RCdFGY8e
UA^S_R;)SeRSJFC&0CKRRP.7ODG)DL?]FGI1)M4<6\S2Nbe]UWUcU6f2(f5,+FA4
YQdN&I,FB5IW3;aX(M.?S:A:)L+A48X.PZ4D^EO[X#dId9dFPAM##-4;b4O]_),#
JO3GUP=QI^=XdWMQHC#6,MS?@RcF8<]D0Vg)6>[=:ETK#5.;,DdaZ]a4?]T>SZFA
?KS<Y-M@&d5&/F\5)<ZXM_5YFJP&1S@Z1>LEDFVPSIfXE3\+@9?5UEfe2Z;OCLDc
4RLd07dG;8IZGHJ8(@PfM/MU3-+6946#,3B>>8=c-H2.Y;?ga)aUg1,3\,d7VJf:
50S:NUb9[^^PcSROO?+:)5I6JKS_Ac/=e,bS[aUX,b7>.,UW[ZE.IL+/FDWBP10N
RdaJG&D.^XE&0e9<[>261;EGTL&;JL0^CF1aVEXA3QNC1YXS]O=5BHR+-ZQV+&&[
4DC&ITY2/1aU1?KRVP.+:3fPLA3[bM(FTQ:0^:/V2UEZ9YO1GL=Obd7Y/#[b&^.)
7SU.<ea<FU6^aAXFP:[A=LZfgQ<1ITJ_/<E)XdbfDH<J:W/@a/a2.V]>N->aVS(@
3Y^Ya/UaXObE,@cc-0+@[7,KL^@4/W^5E:,a_HH2eYVbT1a9QH)G(+]dOb8>Og4Q
[2O1=S@a9=&D2+e757X=78SUQ1W\;UeNVa@dHef\LFL^9H<C:SQJ-g(01@ZZ4)3S
5O7L,CHAG6A:<#FV]V_OCJ\<+K8-8^4#eb.1b+=3)#LO8J#3ZGDI.Vf5OKXD75:_
3#H6E)QQ8Y99C,GTY,:_SgAW=T=T?M/G7R;Xa^&/D7Q=)T.LNM,@b.BDEUNU714)
D,7gg><&\=5<QdQRabHd2@><O714WR-4[eIFE4W]T[BP6I1d,BK#O.MU^a^+IB(H
Y9TA.4Bf5?Z0-5&F/>LZ?R:DCQ]&d_F3@L:W9P?WWT_++MGPO<aJ?4YHOE<5(cCQ
V<JBRO]T1]e?PD4eL(cD[[W^BO>,:c59Og)d]9,6-([7b0W3MT6cNg8(SQ)O(5N+
RR)bf6ZAFT9=IY3^2c,T#N[,5JLRC_^AX+UOZ6V(&3b:KfS29Db&=D(>8O+VRN.1
)a_GK:.;ULB?cB=UT4e2:V@Y7;Za7JJ6Q5..&5GSMXcI60?ED1>R58?dX9J\f/,E
&)8OcO)P)LJF\PZV<JV3ZfR=9ZOYB:./]I9SZHZ4NIK^W+OOT5WUI3NVRcKd#K.V
XYQL8DUI9Rb0bORbE\>g#9+</3Aa(UL>>6AS<8?c7@-g(T\gT;FG:E9A\C\KD+GB
>ZY>Vd^aAJHe4_/GD8.-Sd3Qe^AX4/J@3Z8e3:aTIJSO<)2_41Ae.-H;^6I8P=GS
>9c.>)+P.e<f<S#5E\OYe@9OH<Nc82G9>Y(U?gZ25<DHc>P7gLXg[DU;(ETXGJdH
HL?F6-8WbQag(.7d(C9?&#bg&\30WWP^OLT@B(]Tg7>,WOEP3T7WS1c3.3/0N762
7M9LN#,7ZeH-<ZeIZYU:F^A9)WN_@1b]7AKO/P4\U(G&C&_Y[eLL:=UFEGHB2MO+
#N8eB0J(:3#<E:7OU?.I8<YVZ5Ha_RcH\Gg?-F5UWAN-FSKK;5VSF^aU/B-DHZMD
@&=N>#-X<5CdJELCGPOa)X8>eQOd:G,cIG-AFX^1L01X6/DL3/2dffCO[?X#;8-=
GH.)db&M#Zce50/\JY:ET9_ac:=CaY3G^>aK?19dE3IM,>Ae]YE-_GHZe>PfT^\.
Sa/,@[)FFTZ0;g1^T]+K/,Lb65L.8,O<d.b,dbFb@6g-^H2/+HUXBWNI.<<;-&N5
J?9b:+XB?^+^Afg&#D3;-bA_f(+0S?R:#)BebAe/Ud]LGAAX769SM4CO9S7e0XcO
VXc:LEbd:7cNOVYg_K]_gc=J7^EL]+HX)2)D[5X>;15VAPUAL4CANDUYf@:DfTW1
JFM.\H<X4EMa;XWL-1CRS<EX=/RA(K8-EXW./J-7AXNg.1,E)ec2WKID(CIV4g)\
1(I[Q]O\E2fZ3?EI-a;.:@.(TbJZ@W-MbB<.(-7bgQ-#.XIdXUH.9gUN?^[c;G(G
(9.U249dGSS>7ZZWbRI8g_Y[aS>Pa14)0/23T[e#E].9eP0g\J^S@6MOJ[D]TZ5Y
_.e3c?89ZUa\[Z>M8&>g6LO[\]D#+2XCQb9[H@(BVbDIaVJdP<e:O\JfJ=F:&FSY
0#RLPY?Z,0_V4.B3\bfM8>Yf>\4QEgY0C/0T@@(D\#&Mf-Q72B)Zf<W&2&b>BA7&
(KSb0E7KLR;35RMD)5KfLW8^3TfV>C3>;c9M4,>^VA]-\;QbU8ZE74TA(#b@O383
)S#e/fH)NQb-];//c[I&]#BFb\RKNJ0cgQ^_/#5JVgd\D(6=P2]6ZWTV?U;1]Me-
UPAF4P^&J=dH;3Y>@YE^X[_E^[F497YC)@F7WG<dEAf_PAVP&JG75EX7V94B#0gL
GaCZLRT370FH5SELbX^&gc@Ab5@POI(VO\?2NPLfEeDY7[bNJO@7D1;^VAPMA,T#
@-cJW8RX&N-)XeCUQ/P\H<L\R5X)eRLQDC&KVg1_IH/7YfCI@+P]>A-U?gc&9;#0
-OX-_8G3;1X]fU9LPbD[0,L]M>7;+W^X0RS3S42<-Z+.^PJ,[K,GV\&PdeK_B6:2
^]IR>;gC+NU3aRO(M<AND<Ud#CT=]B0B6?@7L\b:^AaAeUVf#>M3RX@L@#1-ff?2
acG1c-e+/U,@33HRP4?P9gVbI#(bH<f_]MLS1/OUfCU?V+#?]B-FeZ+EF1O5QfZ-
#K-VY>8@M@\2]S2Nfef<-M^>C0-F:KT:VgDS,R9K2<4=9LJ]OIgaPBdI53KM:^&I
G(fd75;K/>5d2IGS/7.S,2GVV.3a/H(XL@(/5)+:eBVf;gUX0g(;[)D2(7V0P(HK
dXREFMc_]g[V)?49#C5>_@&O:@@_NH-T^0ET#0>TUPe?+&=K22f)LaNQOW#1EON_
Y5e-IHS3LLK4[(,^dc)]EeQIPfZ;>52RQ[KWKO\\ETD.N_EM:]I54[Pb>;3aa))]
<#T\A9bAHgB5,YdXaKM\4=VTZQ=\P>.<X<a]:RJ.ODH,D4Fdb[1\CeQT&.]f8Jfe
HI:],a?SK_X4;+2M_OPN@8fcg-C8+cT=f\#&-1JQ2TRD1#(]c>-d^a=32>a9e8NJ
AXC\)\bH/+AJdfd&4S7RDR2+9]SL-V8)S(10J(Y>A)N;<7g02>H3:ED#D;_9Y)G2
NA94]#IH^+=+GX8;cED<_-1]ac7F>FF8:X3-V9QK#D?9LO[EA1XA8\Y(WL;=1ga4
UNT&8Ne=OC4A<-UU1MFI\&a,IX628#-Y,FU4NA.X=?QGWJ<:(,KdP&>A_\a)0I8F
BAe?QNO?^#gGJT8F;5_G1VXK=NU(A[G-Y/O4Y<d)\_Cf5=;]N^7gNXU1Lc#L2F,c
b8Y7C(g+aWKW<XXH&TZ)FW>;R1K,3EJTW(SY)ZCK3dY)fabHYG2E:OT8C\Za@DMX
:#dKV#962@E8MCH^JCGO,=BLE7\QKAS:4UNHRdSLeKR&)UI,MUJ=^ZJ::^J.6<\8
4_U+MSOCI(:19U?R@54=5>][dcQSe6([,JUffL&YSa;cJZRTKOYgC,Z_SU-BPQK/
--\J3NODCH2;U.9)W+3YaP6?-R/4-bLb84G)9=VA7Y=/>CIR7M+R0TIe=46XN:Z_
edBfV6K_?-F/VKCbW<dVZa<T9J@J8=BecL^XadKKGPVO)UFS6IgK::c9VVXVY.R[
D/6HLf[P/];WA0V_:bJ7V4<SO&44C8\GS2_?3]\DU;P(bWA4LPFKRSg=gbFGgX51
2Df7:HU??&Ac/UF9WR0Q>:==c7FH=ACdJ8+5IPZ8&7>fJZM6Ib:)34Db;JIdL+Rf
;IMW9F>GL3)43WO\4(E;NAfN)8:VTW[-4\,:U-H70,9>KGA+M/E=Cc]@+55A/TT7
MQI1YIIX:S7CR@A,\KTb:_)X:K?D.T]G\O+Y17ND7JSQ\@5:f8/F?;-]QI)0Z>/S
81&6^ZY_(_(]U0,3)QR.b4)D5;@_[ES:4[YVLaPM2f>;Y3d?K@1cc_3a3<LCF.f@
GH++YW(9W#&C^QBJQSO/LK(G>)#)#KW\?;?EK2G?-RS[?VE=XY?XWcG87#@^cYH(
@-);eU;X202;YGfWLJFMAPD=8\/>Y+.N^1BX+1+EP-@67Z[dKQdX\BHIJ,&)\3DM
-6[PQQJ7SH_Nf5@^,&MKGA?&RYU\#::W4]6PX6H]A6H,+ZgU(f<eaU1::C@/c?([
aV36YeC9TB7#\/;=:(KaL\5@K0CU.gOeVO0>+NN<[\^Z9R8]1aeIPf[(YYF.H@I@
V?A,:T5:E&@S,Qd]?)@3XXX+Y?:7).SW/(Ve/F0Sf-a17_C\\\E)eN)IbXT7B341
)@W&VaT,^OA[WbQKJbZaOP()^+,6#&g5+HMb=M4-L+I-I>(LLPK]A?IN9=M@DEHe
FPMMFf>a_[0G:bgG-AfCTRf>),IRe7M8(3BM[HP[G.R@EEU70-5fH>0=PIS613Z3
29a&LL>^+J\W7PQZ&3ZH4?7ZgD6CJCR2=(-_F+UG+)3&18N5I2fWf;VH_O^&>#FE
DXRYAX9A2F,OI@3H0gDL[]92WCSJB:e8_Y66a.UCPP;I_<1QVHK]E>@SW0(OJc0b
fLHZ/LcEBDQ@[e7aV,_6d2Y+Gda_,IE5POJ,7<7@HKZ^>[g:<OF+3.?+^H\c;CM1
2FVP=_U4SSXb>W\U>&.W_7&GD1_=GPfU[,S^2]4N]A>Ma?]XF67b^(&T^3MJc(]W
E]T=E&b-RUJ>^G[@X,@RODXO2<+Y)7b2/_CdIC^<CR9DA0_W]]00b\M4b^\-=EJ,
-\)=G(50?JJ#==e=R;H/_PLgHP#+eMg@NebU(Ec[F]O7=L2M@QfUF?&:K7b0bFRg
F-GECPaBX#6cc(<QH(&J:\<7/LB0))]Yg^ML8P\XLO?^=gM+./<BcB>Y6LJYdCY)
MECAf>0@?O7ZK-X.@X^7V&/)5-@FQ\WG^14SE[WH^.WfZ^WEI<ELH6,;,O,>fMYA
C@bCa@QE.59RL_7Z6-)QS)G)b>S9c#UKY9cQU]U82CXd@;UOV8,HYE/S(c?4L?MM
;W:.V&S?F<]:ac&I2\O/V5BY6BYOfE+2GEecS9WVS5I/b9(-Bg/M[-.QF)9=8&,:
1D=Z(\8NO^0GJ=D,\#LY8OO5<V_R@B(6I^04QBb4:;NA<+Nd;-.CeYc,R9OC[7=V
;b(ARONYGK\59F#eTR<09e7#=SaI@7GVf1.W=c<(V&WaTQ0,6Ye^e@TeUK\KUdBe
1)Tg#:&a2S>+9c#\P&MgF/N]])Bf2&FVb8/e]-gDYY\?IGgdC4Te8C^@\O(bZc\V
M:3IOKO-7WY6/_g)O4JO#FdR^>LDUF-R@=Q,=IgEd-;[Z,dWVb-8CZ89AZ2G5Tb5
Ya=QEfg(>QHT=><GBFLJB+QeCW2?S.XCV0TK8BW8D^V>JBZf3486D/-O?_/_6;7G
B=42cfgVDUS[V?(?LdT(J=TdO#XP,acC,WU^=WHKa&]P)R^JVbH3FU2FdRJQ9>Qe
M+CDa#e5Wdb6L[RS(_Sfe+,BT0Z[&[WaWO5GA,N^;V7^R4&)3-M+@4<M801G6,[R
A:G9C.F7^[ESELTDa#=QRM+:W02ZWZf7++(R7V,2S0>2N(8]aO<#&NX9R<472(7D
C;H--_0LOZ58@CA5-I6aQGM\>;gK?a?TMAf>2T#O@O<;\J+S7RWT0ENAN61e.^L+
cI#MD5M9+Q6E6)#bNG\HNYVTYG6gc_U(]\V-D-3A)8M2e]Mf)UCT+,Ja60+;7]g&
-0O.=BXG\SEZ#1&2f+,QT0M(M)-ZH_LNX/dCERS&3(/FPX7EU?cb^#WgXFPZC.;2
FZ#\]D5N&B,.\X1dEGDX_BC4@&4BX\K4W(?K[d)Vf/RNg1)<T=6X8)<)=YW^P-<5
#HQcG9b&AVBE@F:@&.Ma<0@ZbH:_WK(\#H>J+X_^NM_E2SSdT.-VQ<3^H:JZEgZ3
H^LY,V_YH-Off[Z>BK?G&bF1^(d)W=G9&#Qa-BIeZ\[2,@_5)IZMEe@4(9+Zd/?E
2J37AL)B<Q9Ue&GZ=?\K;X24[S[?a#3.T=IYSU+U\?_8O3MK-K^[d2QgZD=5/LX;
WBfIB]\X)3V8N;IS/K&aX-R)9&2LN.I+(ba)4c):3.@Zg(R><_IJ)#,A\b+I9(T,
IHQ->>)4PA&=aWHg2H2I](25+Y1L,b.@8]8NFL&DYFQW6g6dZCE9X^+R15:,/;bO
g651VU>6N\XU<F/:fO(T<IPMGO6M_,Z,&SJ;?T/-6V^79cPZXJ[WX\^(\ZFfcad5
GgS@^KaUT3OTR#/c/;Vg)CUG)C879g#WJdD;+g(6.;G^3P9L:a;dH1M-_:;.23N:
6T<&V;eFXE,S#QQ0<-g_RLc0V=9=A>:E&=5J&L9_+G8-L)YN8TH/YG[_RLHdU>WO
MZ7HXG5Md-4:TDba8#0;Ng&PT(1eDVHD8f41ScOB[&35@G@0)>dD,WSOWIVN;:\X
>d_K/XKPZEU_TFMJc8XOBRWN?9deHTabdHb6GeTY[VOV+,L8,ZDV-2YD/,J6TMA/
aaf610Z650Fe26N@a-&gPCb?<[\,>YeAd>,Xa,\gJ8W_@SK1U1#E&JK[-DS>_AQ)
EL8Ka7e(G&[e6C2J<KY5H\#R#DOC>_JGgZGMJRJW],f3CFW4-F@HJ8.PZdd=0=YA
VL=fKQ?fE(U9IIZ@+VF7<&(M9+1;]aY:CBZ_[c(Y;5IPJV39:\A@P=d]E+a]K/@U
O>;WF.dgIOML;\V-Z]F1F7MgEb,X^M+<.H#EZ]&((Ga,2?>,BWRP8YJ).7YUCINK
WN@(Ze(b0HfEV87Jb6UabUB=R,1FgP4TKeFaT8S((T9ZeZY?U79IAK0EVg0CeLF]
9NYY3T).X_YY,KNL#>e=VS\^E56LcLSQ;;8GX7.8#&g3e,3aH7R>I;[MUOSOI_e6
((@/]U(4RW.0M[33SQ:Y\J&_#QSaX\,Q?TD1AD.DQ37H1G3<eZ/>WdW9.U;dY(2?
(FBI5]I2LU6NZRJ+[f>f<g3E7QA^&#[20eM\^A2bU\,/RfdD,0HAOQX;2I].McF5
--IaO6DN(a-dS@_ZD34db/fCH4:&<Z)(&Q)XgKQ&O1J2<O&GSLES\IH/gc^0?M9T
>Y_aFV9gA#1BP=geC;^4^L>+H,C\]OW7UMe#fd8AI?F++X#)ZVGZ:8=QU:?&a]+)
3F+2b#OaQc+#=QK1ZRSdD0:8:cK3GcaGb2d_1]H=]cVO#514?5H+A6JZ]f?2[O40
FFc@<HZ7DXAG8WC6[H>9YM^1TefLV@eP:@_U4(+Q?(4Sa<595&KOc<HcUNSdE9+-
W)3ZL1&gCP_aY[)L#11([PX>Mf\@^g<JLUT14WO,V3C)+^L:SP-#&MQg;:8E2X0#
-#N2(eW_]N3JC[,,AZ[J-f+<_Gbd(NXWW4+ZI3W6]R&+/#,T(2LJUV1g[,VP.T4c
BL/M@U_FG/M56.9(S.<Q]M<@BDNMF])ZZ4]3JX?;0Z3P4+:f/Q#c31Q8F:YgDRBE
1Ga->=)=DU2:B)>D0:][F+U>H2,Tb=QbD[OU-ebX#^G+R1E+9-9@8K#EYSf@E6-H
US-0(bdN.8>;fPCe1>.-#G<?A0E7(C#+\;_&L\\KAS6@L+e;.K7G1GDB09]?)FU2
&_,^)9\?5:8NX2?EELJPZ2+=#?-8fS7P)16AV]EMUgOX&5Q.,-6J@0JfUPGWa)^A
Z:01T3#JHe01CaXFEUU/.:N1G/S,eZfTVBe.+O8.W3SbDXJ_;X,@1LP?fGIU]fQZ
bQ9L8.Y8H?3#Tc>H(I+dVBfZ)_F]YSfT#PWL[]QE=H=MDaRc,NXHRH-EYS6SeL5W
K)__(-)WTG)-\I[8:Pa:=2,A1<UF[XRYQWVZdOUaTC9VWCR<VQ.-cI>>DK7E^NW&
HeW98Z4)Kdg_VEfG71RDMa?g<-+IH/7aPW,3KW\BYL+,M#0[1>OTQ??0b+Q3WR.9
(eJf/Ad0@9&^M;be)KX2c/NE\dQC_[fWU(SU&WA(1,_\L?f^?,U1GDFK/H9>&0D[
9XfMTbQ;+ON?T-Z&RHDVB>gYT@N<VO7Z:bKS=Z]d.<E46^R^cVC\IE.X=1S0D50L
H6_dMW4KQKBOHRCSBTWW(AJe9T-Ugf1Z6Sd4d_1#d@c74.+c-H(O35U\X:Z>H(T1
QeQO9RgH9e5^5FJ:S=(JO.8],/:dT0^<R&>>eM]2P;U:3DDF]9H_KJ9)g&+&cV[O
5Pe=efZA2UBLTU_:82&245R&e7QS(g-?c2P+LbW]=<Q91;E_)L(+V8/^e9CD&J>Z
VN/KJ0S;KLgMQ/Ja-d-N@^L\>D(@6IXD[;U&FbX//-f036FWS0R[H95RCSJ/f.58
(+V_H=#RAIA0UN^^JL_C?7L-2VMN-Y;[#4)?AS3)4&_JZWb#]GMNa=KTTMI#V:3X
JA4M]6OV>#_PH2;E8]Q@S6C@dXH_3+LSXbB11UP->bGZF;=&aC?<Bc<N_[dK&e&E
@EU+@4[V)YZZYBCd951@g1ae1]\aXf:DP6ZLLPBE@9BEXAeUfWbPD_4:FMNPVc91
\.T-T#^4\Cd=5C(KS\,<#bVFB+VIF;b[^f@7X8G7Bc2UaNG6\D;?0+@S?;H0R/aZ
@e;?1VJ=9085ff)J2SaJ\X+,?OC&:[IO\-96Ge0fX@GH@DMQ8SD>)FAD#)I#f0G,
.<7DM:FPQ.RS]KaaO9dVYXI>:NGeF9H=U1QB:Y061#O2G^g#&R3CfC?5Da8H1dWN
aC]8HV,::9(I\R/U[ABR8KMNB+^(^3;6G#&7gXf/GK+Lf#/d3ORQR#-c#/N::4bM
J<Ef-Wc6O@/\L4T3-I,<H/1BS,?E=]ZUQLd(4JaJWb4O6C1ZaCN)U9PJ^1#W1J&;
b30I=W0X_dKgS-OQ\]SOJE&BNfSc(-505Pc-c_)TOGfLbDeUGGY59D4dJ4>Teb=b
^/IFRS8S7@@&VVYbfH05#9J/>g\.fMH25GX).8A1f.X530]<6VgO:1\X0DQ&=6E\
(BG43d#O3U;?(KPJ&<1P5d+5,,E0>cbD+6H17\G,3]S(&b25]#S+IVbRA^W3?]8S
-75U].8&)IZIC)OcBS55Ub7XY>91D3LMD:7.Wf;2381Hd(6+2(^a#^^<@2+_K[))
\=aYG08RE/9<fNH:IF4=;=J.66&IK+BeXR6>dSc526=0#?eIH+af/^:TEU)0Z[b[
)0TV&aA69SH,9b-=gX?RSR_YJ5.CS3aW0#+]\TEL-HVS2GSK>e1M25D?MOWU5^AG
8[RW#GCD/=2W<>.]7GXFQN&RMXX_H8/C99e)T<AXBY,CW+;;P@GFXFHF7b>\P5X_
BBQBXVW<e=g7Y,+9C6C2^H-aFg6Z3(:^\87MQTeb,NeU^ObO+[Ab:\FaB+?E8^+G
?M3/G<0,I9eE6W<b6K267&Mb#LB5fd-M52Z2U<E\SWV+P382V=T-;OH]I]e^#NNB
0B@D9XKCdUHC3?ZP^Mb@L<AK>WcUTeJ)g,49?3.[-D_6#<_W?PPZd_;THXY0<;FU
YSIa7/\PMNUe2\W174/5dX0#JS3TT]9+\U\b#Z&V0_;D_eGM7V\K>dJ)1If-ZEB8
a7B#ab@>>:BH8g/0_Z5fO^^@>6&K^T+5c_HcQ0:JQ,1@A(c/;X)0c3M(\#dQbZOZ
DBgg99L^K\fM/[&92AM.1^&=8a.U\W[SESQUF34,[V=a[NE\J<3T0b\&VQ;4a2VP
XG2)89)N6M+YUI>W,ObJ=AJecG;=_,I+K:_QX4^LX8-?U]#6gKg^YI#.W5DJ(F(O
1acI>5d5;aY0IV&eZ00R/;fS[[/OJJ&7CA+7MOCHaQISZ7;UC^#3M/5MCT&[I0&[
b+=?YPLE68+])RO[dA4Qg7MZEG0\G>=aSMU]MWTQZ[@SJ@N:IRMb[N,X5GXc&>GP
R7RZ(4ZDe;3ILg1Ab;1\#T/T<&>G<>)BIIC-AZ462[=,OHI6ND?ZC^&XG##B))#[
Kb4X@e^#<+,=3<<CDZ?[]S:2S]SNfA]=8[+F6@W2N#?[^KOQ2gM7:7[V@FbFQcLZ
)b/JS+PJCBd1M4Ke>-<+R=OK6-Ad_9T@=_6IVAZY=HN]F,P,T)Z@<2FTN=02\Q9M
F\CTXae#dH_7IC&7M4\ebgCEJ/.LNW6.+#g99<1T1U-eNa.N/C&<JQ9M-e?&Q;SI
-S];U<M2HSDJe.Z^(GcLTN9\-QBBTRS=)8P=b:L;)HW<D=WU_7>LBPd8Za]O/:R<
<@G/_S]a3DTT42]Q_<SJ/PX83@SEfGS;MNAK>KD=/@#bLHW.:M4bc^Jc:F;R;NM\
\B;K&IN,#Y7@S6#9/e-;#fW+.&+RUE&JY,OYD1J/-WLVM0[#DT=dSMB41KEJQCQI
YG^651TC\AaYZ3e1_/9-;(QXSLH0Y==3F<^UIQ9IMH=3:JS(K.AcPVJJPHIGL??g
^1;2X/1D3?2M1,4e6M=1]H5eW-&D.E1OH<6Ae9g)Y.0-HNK[;PW>Y28S/5?5A(Uf
f(?OdWADMbU:d/e<VDR;VD0cBK/H9)7(fK0S.^ag8)fe:+DY:e\\_HYQ^I=6VQf=
-1>H2/a1\bIdVN8/7G]CRRNC[:O]Pe1\0ICa=bUHZGJ#LQK42CgT1e]U]SRa(9:,
Y([eL.ML(V<#eb:>:Kbg/LYL2\QS)XXDBQ_8<+<d<H-IK+8Z7Q4()E#d70^f927J
-QK4@6_3AXLXJ1.b/Fd5GRBfO)UHJ0@\#?AL:>-W2F+<(W^2)55[S4)RO[)B4MP<
DCgV-;7TLZ]g\Bb2QF:;DF,5^T>Qf#]=FU&OV47I./SS<SegIP;+;@:SN<LI]E3X
F6\JGDS/L/>O0&)#5,H.B_V,>^d3LZ#DW=K0O/C4DbLV6^g9\8HZ\?Y]TK:^^?:R
-OHA#@c5W?L#[BKBL^G^BJ3WNUM/#EX1[K-&UbB:d-PG1]LaP4_3KBHaP6K#@0&T
:W8/e5=,DPI\J^V1\g]&Zf03c<d5_Q4;;4UcH<I4)8WQfVY>VeQ:b<;M3eGL#PZL
Y4A_OLMfA21&fMN>b[:I1IJ92H@8@c>Q&eNPXAX]Dc:eR]6JLDA#_O_a>C@-c+0Z
D&)1T5H4+Z#485YH#)D)DfeD1d_D3XJ:R5CdPX6/:)0EZO?V=2.Ve1:?g+&WI4bX
4H.e29M#]P6^Ue;E_N27&#]Y_Ld;PG:UgO8U?:=Wd&&8OIOF#2:TOPM1PJ>HbWI2
,DD&YQ,50<0[ZMZGQFQ3K\P=\)CQRA1LS=f8:XbdUSa5,?OJB9AWZKAeTKZ_g^AF
()gdKc:0#?CPJJ<,^C3HQU<;S0g9_a#]fXEaIW51CE&^.7AL#C@-/7R/\dJg5CMJ
ddU=GJ(a+_?#Z)c+F.GP@&Q&N0AL?YZ4Q9d_d<1b+.4^60fAZ<Gf9/)LR[6D6RK7
[W\N13@@^eWK/,If]^f_\TCf<PI.6EF_;@.4U#dg)A<NA7L),BeAa77LYNM0TA:f
>I;^=:#b=Rb-13[ZE2LB\:IPP9JMKXQCNVR>K>G@GN;.;V(6_9,))Xb07Q0+SYD@
/M2Y5Yc_a\BO/&cd+\gQ8O@a\XJ<3GDY;e@1JC\dY\>L-M+&&86(;<cV==FP7K[F
YLUaE]g#&E?;0:X&WbR&P[+c5RRa<+2+g_a\D=@dd>T3VY\CHd]B9=UV+QN015IY
X_NBE:^53fZgN#<a,H;_O=V(BQ).K2d1N5PN\M(,NSUA&^b^;Mcb:@7gf2^bI<V9
OK<.IR]5:M7Rdb+)U++\0@P3^b5UYLS__)&dCY.fB-XNR\G?,09\;EZC<-,42?]I
G+N+7fX=<):F41Y9(B8&\,U^K&X]L=YAN6#1DH3Z&A8Xa&g#_a>g+E^6];@8G,(A
324H5._[^,gM^cYeGK9eJ1I9+]^R>KMI25<;4^gDT=69a=6YL_P,BL/&RV3JZc>2
G^2A?BMK^\c3HZeB?EWFZ5Q;f>H+Q/13[5JAWc:Y_&-H3M&E?EQd#fIWX6=Z<+=L
_@\.LD[:PgE4I\(JV:P\S-BS/@3/fAf-ZHU?Db6/HM3<X52C,6QJ(RX]R/(TL+Wd
\T;^2MZB&>A.a@&6@XRKPL-f:J:1VJ[VFK6TUQ.,,WMZV,f[/F^+73,eU^1SfTF0
:C>EG5\P0)&E)Z6\0-IC<\NFPS?896fO2g)6ZY/29#8_Z:JPfgPSedGOA,O8MM[c
G@4]=Tg[HE4,c]b2^C<9BQ?188,Z:=_;,GF].08#MNgXZd2RPR.&BFEX2^ZG<PWQ
:8A,=@IO^QgOWJ-Vc-Bg7^ee),XR]-\9=EG]X86CV[G92.SWY\ALOR#@LB8O5=g,
^eOQBPSCM#(7g@N1B[1ZPP0e5Sa4fLK9e[G6.)M0Hg?]UG@gLd)c_EX5;XHT,<Q=
19&91RZTBTbOGKcUG>X[g<MGaATVGB7B7S4N?+TA:>/-DOb4B21Wg>cQFL__\N4B
QI[L;?-IQ,A5cb7FJ;ZLQ=J8N5_;MPE@]-Tf/dcS7g7M;.bZ32,\Wg?VOO:@VG)1
JX16T/^2P074-&eG=,6X[K=DCQFY_g?>A6A[0D@-7c4._/E](]-31IYD1:0&W<14
#354X=E&EH0D&:b?9@2Ec7fI6A+^0F0QW^g7?03>(-NS]\9/f>b=D]&6;#C<GJeB
_a4PWW/RDH^TKM]EZBPB=KS5&S5@M3S;2B&J]FJYe(]3[&R5]W_0,V/..bC_7_Ng
eCe855\c1cd:W?&d@YQSN(V4S@7^_R42XW#^=@ZWPH7:._&AB[E.f2-CdN-=8MeS
[<65F=L\cP(&36#cJ:==SU5^<>UV.a//5U]O/gBSH125F?CZMK_S7CLO@CH^c35g
f9Q,^B>/(91cMA1g/A(&dD@MGRYN6ZZDTZPU\N[G7QgCF(>-NUe])R.G\Y;E,gBM
M(S(XPPFg^B8//0eB=1T##>;AN1T;=.N8N2N@gM#\cNHA,Z&Rd4(U58Rdd=[S7EP
cF\77WL&bO=LgVbVT#P,T^>?g]e<;5eJ^;)(6#\&Q+fDQ]-fKYZZG?/\MJ03D.W2
3K=Q9+LR\1_?W8c\C?XDE9Ba&X[8RV=\70KJ9ff.;2+/?Vb:+_JN:1J?;5XT8Y[@
g?<?0<VYGP,B6=JN5Q3U2:@Sa#HDP1I>/.cRWC1aX__:afCf;K?G^Z3XEa-;9fA>
3=5Q(A,aCM7[Z2\K(<\\1-fG4X8GQeS9+S26E;<[K-3R8W/Ef,RQOGSP/&FH1?bb
A/;f5#e+DCBeBQ:GGD&29D/9>]0J].d,?XG75#P9eKId@HU-GYV5(g>)(>MEOKS#
.ET+I,cVd+aFg_.X]e2A=.9geGZGa=G<F^f4,,6:FSL0e;P?U\MTUDcMWf+Vg;=S
TQ&XWYU(.TM+A1Z6.[aK^S2R?_SEOB)3W8<=>9DV_\QA>006),9dPHU5R@Y]IcI^
A+3g<WNc,.@RFXI\(3V7\Y&-19J7B;>2c<BXe&42c96U1.W1JOTTM[GJ+):?C\2+
<3BYgQ-8#O(GLQE1>+IccdEa\/[]]PP<WD<+2dLcA-^AI4/>5aELdHAgd=>e4>\D
9JB=0LeP=NAdT3d)8-U^S8@?>MC<SX4CW:5IJ-GH0]\FUbAQ7,)UT[4&Z/LW4DM6
QUCK-(3FOe])\0Wf.6WC(d@,<&Rag6M]/5Q0J??YPP_:DT5R.S<#1g^MKNU7X/G1
.NH76AY81[&V#7+F#+5(L&CJe6bE/X@T]OC:JA2@f8g->YDMJ/I&g3CQETJ3],Ic
e,+^V-(F2Y[H2XJ@fW[Xe\\SbA,b)D=\9JEd)VBO)Ga3cf.(LYcL,I<F7/>e99=S
YNG._g73b/2b@Nf5:K,K5OVZUCcdML]9Vg5fbg5MI#C-fV2):-A83dWGG<EfNB3C
]W#Hd8b[5W#(A;A5Jg+,K,UROUEe<Wa7K4=1c&Ed7DU.S64]2U54/;91D@&=I_=-
-cbc1aR3J26E;51FMFFfJV2[fg9eO[1A5fefD\Y<NH8HJ;C=g;[;C-E[8S]_ZXL/
@_1=N)KXIS-Z2@TJ(M;=b;1W+A]7&<]6\AG=[UUB1O^U<C0A@C&2UCc>;E\#D3=U
[fDb]+Y=.B1IW>g9DY6ADb<,@U),eK7cB/c(BLDKfbK,[H0T))9SXcf_;/7.WXP?
5KDD,3X-I/):c+\52GAR.YB9ZO^BYXgEGCOV&<gB<+;S>H/IQZ^[-e7R\N(N)cKV
H8eJ34:31E\d]>@Ndfd/G>RNJMdTK3URT^dgQAW4JOT,5GNCXYf4?<+9XZDbNcJg
OAM(Q5^2Y^^&XE8&.CDFK1_A@&YRL&6<7_LVX9##0EQ8W9WV-Na\#=J=.L:/[+JX
,V3[[O=IFC:_f2;ba#M+eZQ-#5F3=^30V<7Z>LD7W=WT(&I89B_B>GFa2>O03fY(
9c_AI=O]/LO1g@/9,?c5KCReA^(\aJW>R=T3)2E8-#0JCg/VQd7;0KI;/7>VO>:[
e>_#96MVR33:>ce0LMX]9+30O[WCKeLE^8\8^S1W+9R35)fR:AdN)eG58JZ-gXeR
gJ4V,:EL&UR#A7E<XE&4B_SFWSH,dY_3T,3ZRJ&9ZV<&,fC?c4P6?gW-f(KUQ<@P
g5;P5&<>)>,^YJ[Fg,;_T;.?<dBOO;;YLDC2NT[eEN-e]8^H+ZZ]Ra#4-D#R;JaF
0BU1T6#;3VXeS4/gLPX9)N>O8N?_a@cC>@cd_XX4G+VUF_a/;geK_,N=^/E(NX>)
=@))b@B6-]UYT.@gbW_U976211cgd:5;=G+9FSg9_.MMb>)7F9dL,A+OW/&fe](f
X1M9P6212a>;;GQ,\I,Z-)ZbA6?\^B+-J6Q^84>e/N>P+/QgI<=OGP+Y1EB7OG0U
1(00M.gT9UD;MCI>I0eS(?E<T(BbK95\M<DD@RI4Pg2/cecC]>Z\>DbL.c=8_1YK
#)]SWUC2F8D34A9WWZ/bZ+J78K.>#U::KDB#;Ub(Q3V+>-HLBD??:Y>T7HO\KJ]X
(?=FBFT\R/U/?)dFb?1@W/4L&]>P7OG@g3,_#QgdO2gCeUD^e)DF]Z]c^]a#S[<)
NR(I)X)1dTA3C+(\\/7(eQ?ORYbaX_@VFa=70]bGg<0eSa-8=DHDIdRA)O3EI9aI
^6cMTQFBR:K4X(D(N7LVfA/MIMbd#3af@,RIJGcRGMA0#(CTD)0fc1?+KBD.LG>d
8f90Q4[O<-NV_4Og<fD7f-J/LMI)LP>BGEDfAS4+57OIXJRb6V(OR_\\LP]JG_T/
ZcW[C4G0\U^be2Q7e\])K]CMZ1\;.\U&L@G?b?];2-ENf[D<LAcf6)NA/Z(HPa.M
K<(,P;<C_L2TOCYFN++Tb.-2g,DY_CgD#c+NKQ)FVUU1]@_3B+_&fg(5Y3a>H@X1
CJ9A)YAKV0UIgX#^+a;88EK]I[P+-3g7GJ)8G/gCIR-Ga^3F9(^M]HGBC^^6@=-a
EU&N]A.N\B6K17:W],1Yc+.]_[.d,@W&SM?8gK9W=9Z=KR/.e=)e4(dTbND+BXZ<
#aa0#Z0LI6Q/V6gIRUfWP5[N+QRaG.5XR:;^-^?Nd,X5_1S;K\KRN7&GLF)aA44=
D#L;P<Y3H>Ue;78+\#58YN6)JOE4@JK[)R0M(4.7(KEGMP-1091-G:W-S;R:=0^&
a\f.RH2J&eK0V)@X:FZ4J657\U2Q/\,G#/QL0NC)+XF;MWAB]_e0FF..9BX^)TTQ
NF9B>E3NA]#TL[<dM[PP&X;GX(QUE;S_9SVOdP32II]16gVOCIf4fH&gL)1#6KA3
<,PQN?6?EIP<I0@T2YT)<QY.CL9_KA/R5B84gFUc\RP_3QXQR4LGGU2W3W<1E]&Y
]W;=6YgK^E[c>8OJf-\]6#8D/,YL68fJYO91=;C&;Q(Y3/CBe]5IE@RfOcQKP_#f
7cHE?YQ.bXIX,LePg-&dY)9Q)3K7APb#Db,J5Bf1a[^GN4H[=AH>T\QYb\JE9bFb
1<WT758Uc1IA-]:5=,4Q5N(3WB9/S#EV;U-9MH;=:,5g<=RU92,S2cQ]JOD)+EV^
,0^U4GM:b]/QWaM,Q@F6Z[/[KP9f/Q]7=_&HBWc[#ZRF3&\Y&@X2^E\aNO5N5eRP
=_ge\R-G.LSd8\GR[(fU4^J)FK,)\E=&BYbU1Y=GR5)Rf8I/B7=P>@N/]9)[L.\L
DT5cSU.K^T\=RTH)N?cgRI@f76L6f@a(]aE-252(P6Q.E82BVPLR9.[4^[OZ=0e,
G_WUg:>3:IC.Qd[dP/KMa:H-,;16VTI5MEI).#^/U07(dV.RM:eZdI-VB@>7;7eE
?OJ;_AA_/97H8]U6+1ZA,A_GBP1)<^UOB-O\U(4>c\Nc??:V:]SK)(_6@gdM^F=.
3#HdaQ^O#;CYZ7ZB?EQB_8NCA#VO9eQUNY]&9K._X5BKeCDbPB.3F698GOHFMR6(
[WNM50/b=_:W\6BRNNT,G<J5=\3XKUe&15T4Y;-=3/L<,L6;#=a&W_d>-KH056b;
c.(FdY6>6Ld>4J0#4/O5PN2fgEOE(@66J^7c,(6>CU-R\K00IO-+,=:_BJNRNQ/2
D7FV7W<dA.KPTJ)?7P4KAQ#SFcWK#C#BQN[IJ4^ScWN[XaRCaFC8XgIcBZXG4U.c
e?W]5,FA_F4aZWO_#-8_H,I#I0):8dZB^X54f<YJ+X2_(8gGCRI?fU5.OPN1W8Ra
\QYfJ93.-)B.69dc,SUKK\W.=LTL_9fcP<b>6?#]dRgIGHAKYB)QAe)Q4H[GRg:T
=QKP8V]b(g)TgHOLVN126M^VP(ND:e#FdedgR7/DQCO@]PP:VGZ[cC26Q]#RKOB8
N;7I9UY5>UbHbU-5OYfGag4CdE&2IL_a]6;[Z@YMF9S92?Q-N&UL0(#8+QIGOKCb
-HS1gEfCMGYS;=^0MBD_L,EVeD12gS?-BDdP+c7D^X)\J<D#93T,+bg7aSDC1BFe
@GYF9aM&TWU(G7F275>MIR64Yb=NCAcO6F+TDSNZ]]Z=QM.G4]=]I2dY)?GL7K.3
C8PZ-NV6fa+2TceM0+SL]X+:26J=JL5P+]5PefMLac)?QWbW(Y6MSD1F0XT__1JV
&NO)W,R+50Hd)U@5RXQ=DH8;\\S59#RZ+e^__2PgcgeTI\YacX-?9cDJ-8J)P_#C
?YM..3^S],>gS0QeYPJB(XLIN4_ecFJC42=D+(T8e+HOI]R>D#dF4?=7bJ_3B&f/
?NO;[G-T.cAJ05IH[OS-E6^bRSd?UZ<;ID)(&U[N<B#9Z6YSV_QKZ?b82P,F7N4b
8T#RB_IJ=TWXfAC(@8f6,2V3,?^8f9e?aLD[IaWJ?D(@.W&>J57_D(6Q:+IW9WQ;
XgVL<5VEZN-4F2GUN@f0c#7bcJDR73>dR5W7GKEPNUf0948-8a1RN@Z1<U1JNQ^2
g>L/\(af.YG@adCA4gS6O/.BRcY8_MWAB#/0-Le9a18eK>Le7]@15bf_?:VLPMF-
DN[96e.KH59?5@M]&HM42L^N+7GddaIMVCCE.NZZIA>&eAW^ZdXO:,2=DQX;5-3Z
#I\CQ=[BL_f:TAR&N1COP/966[BEJY072@FLZ7]W.?_0&c[Z3<bU1[]8c[?>67QL
VEGNHN.K3XT]<e>NJeJF<QWd+<Ud<<2=IaXbec6=VHRUZ97AGG18>A;XG<a\BIM]
KULb#D^0WL<]\H/&J+#;[U/ZRK36:W07,P&8M([.9^@4<21K<#GSUO8R-D1PK-.f
Q;#44CXYKG20/-L].eR-(Ca\3)gB-Y2)?e3&.ZRN4)KgX\>/cS#E<H^Zd&c-R/_#
FHF6/FeV-;^3Y6d-U);=c^#C1I@9X\8CZY3DST+a^;R2c;TZdW5bQ+@(V\#b-E;3
.8bT269VWJBgXa3aXb/SXZ.VCSWF49c=8W^_>[1-(&?#U-9Q36Z:d3b6^gNXB6?-
D9GRYcgJ[X:OI?Q,M2d8(VE.RfPEa.NLLZO>^3VEJaNgd.9gYQ(8OL2af8(6#Ha?
e;TXHMLD,P.&6I)@LeH<cE\)Q:_/a+Lc0GL[0@-N5#Aa,[2eL<S94_W@4(C?0eM^
N30E^Z>IL)MNNc6(.fP(C+gd9a=SO.>Y(6f4-.9QA&J,2T=eFUTIaH_ZLeH?/D-a
-^W8Y-\P-3SLf1\QS5Z<)DbL>V&.AbZ-H(<LXGS9c8-GE_9(cg06/+CN<6US4+cF
,SQ=]c+0f<TLSg.:YWN8+?9A[<QOL,a+HZ7BgUUPE)>Af2PgUb11/SPeYP9HW8.e
IKD15<c\M]O5\TZZI+g&@NNSA1WQ;J8C4UIF@P<5VfHAOOdfG)WA+DB@8d=7gSAI
Oda<.E)GcTd2YN/J0cQ\>X^AF6-Q;1V#+>>81c?^gC.T=YZe+fF5P>(0/1E\XP84
g(UMJ)<H#BZP^KKM80EIQ9K[MI(:3#L.Wc=@-:&cL(.aZC#XFb6a\eMQ_TDXeYc/
P<O8U+,I>8>@\6PQN_geJ&R/ZJ7PV-E)3EWH2D3^;3&U]?Z@IIR.XK7_#;.9O+_?
c1R(@fceUH]13DG\=9_V9<^JNPb]H:>[MKd,H5.@3a<g\BY<<8^HA<OPFA-56f<?
2.,8,9HSG>4cTH@c6W6+\^96:7(9D7<+OW5e4C74I.T>K:^>8]]C<^D895L)R#)I
fQ[7ZN_C)23b>TVg8eX,a+4YDdD[^d2Nfd@72-f,0]KM78IP>aFXHT91Q1R@OZ;&
037\Y0;FRDY7(e3<8]/_C1-KY\BR<]N]Z\T>PAFDBBM7Y=.9.S?6V::]O0HfND1c
RB+J);Pf?BdY5\\\BA^\E33cdU\RACA\PF@)4#D#O=2L=(FJTgJRLV/7M64VGdf+
<4,RBL\12E^cHeESQ8^X;N48U?BCC,>;+,bX/=W_0IF-BR5e?A\8cX]#^8)TSX13
QXTHRHQ_>Z^31\AJ8E@UgXO0WI:fT^K(^CMb,H&RP1bX@<&cddG8C6bP:\/<M,95
9EY9\0:UcT?-):62&5QAeSf0:QR(O:FNdfIdQb;Gf0VFO+\I>[N@FE,9VU5=]/(C
>[A;#SD-6)MH>\&?CPQ2d;9_b(5_aK=DaH7>&Z(J&RDR5E@G0?6J6d3.dCQ>;gPM
^AQ_&O@.BaVLLX)3C6J)f8FaF8KN5\4_GG:(f=G6-M>N6baNX\@VWJ:OE?)_dD(K
RJ)eFKQ\O&^B\&PDR2?DKdZKJ1P(A4NKARFOIG13/>94920(5,2@c#0HM>7+O-_P
WT@_JUd5=+>]d@M&6D10DcI#,37YYT@M9gef+]I4JEG#<c1SKOIQa[IKQ[G>NQ@L
RD)RB[;D?A@/D:W\RgF4,S8ZFL9FQ>?6&#XJAW-J4\,4VVE0,SS\dA]J+Z.UUO=Z
Z#,B#E\\<1>g#fc[]Y)KFAA<X2&_X+W7NB[fS<63F&PU07#=9?L;Z;.Ma7,Bd5Q:
M:(Pc)9KcHADCM9W0AG#-+?VL:P<JIDgF+YdKPUg#.gE14VNM/B\]H\6Z(F3Jc\D
L)[?-[EdUEagf_8N(T8?WW,_\,>3RJ:QQKF7ZL(H#Vf);M/,Dc1:GW]_LO7YO_V(
7^[]HADQ;-fRA[(gJO4421T>&+_YC(G1VBd40PIJT.ABd=H)Kd)GD6(KOWI#>M#X
ZcF7FaYbMU.JFTS=4Qd:&O#@]O5:?(Z8#@9X-6MB^fBKVG+Q?7TOSbGg_b7KdJN6
U,(N>SYfWU1D??G1bW3gG0OGPW<?VS>Q(.V(O<YTJa9KE$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_MT25Q_DDR_AC_CONFIGURATION_SV
