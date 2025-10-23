
`ifndef GUARD_SVT_SPI_AGENT_CONFIGURATION_SV
`define GUARD_SVT_SPI_AGENT_CONFIGURATION_SV 

`include "svt_spi_defines.svi"

`ifdef SVT_VMM_TECHNOLOGY
`define SVT_SPI_AGENT_CONFIGURATION_TYPE svt_spi_group_configuration
`else
`define SVT_SPI_AGENT_CONFIGURATION_TYPE svt_spi_agent_configuration
`endif

typedef class svt_spi_system_configuration;

// =============================================================================
/**
 * This class contains details about the spi `SVT_SPI_AGENT_CONFIGURATION_TYPE configuration.
 */
class `SVT_SPI_AGENT_CONFIGURATION_TYPE extends svt_spi_configuration;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Bit indicating whether the VIP is to be used in Active or Passive mode */
  bit is_active = 1'b1;

  /** Bit indicating whether an Active VIP should include monitor capabilities */
  bit enable_monitor = 1;

  /** SPI enable_txrx_chk bit enables protocol checking*/
  bit enable_txrx_chk = 1'b1;

  /** SPI enable_txrx_cov bit enables functional coverage */
  bit enable_txrx_cov = 1'b0;

  /** SPI enable_checks_cov bit enables coverage for protocol checking */
  bit enable_checks_cov = 1'b0;

  /** SPI enable_txrx_xml_gen bit enables xml generation for annotating functional coverage */
  bit enable_txrx_xml_gen = 1'b0;

  /**
  * Determines in which format the file should write the transaction data.
  * A value 0 indicates XML format, 1 indicates FSDB and 2 indicates both XML and FSDB.
  */
  svt_xml_writer::format_type_enum pa_format_type = svt_xml_writer::FSDB;

  /** SPI enable_exceptions bit */
  bit enable_exceptions = 1'b0;

  /** SPI enable_txrx_reporting int, indicating operation enable and depth. */
  int enable_txrx_reporting = 1'b0;

  /** SPI enable_txrx_tracing int, indicating operation enable and depth. */
  int enable_txrx_tracing = 1'b0;
  
  /**
   * This field is effective when #enable_txrx_cov is enabled for SPI Flash mode. <br/>
   * It is used to select supported flash part numbers whose coverage object shall be created.<br/>
   * Coverage bins of loaded part number will be populated in a particular simulation. <br/>
   * Simulation run with different part numbers selected can be accumulated to check the verification completeness. <br/>
   * For example : <br/>
   * enable_spi_flash_catalog_coverage["N25Q_1Gb_3V_65nm"] = 1, creates the Coverage
   * object for N25Q_1Gb_3V_65nm device. <br/>
   * Similarly coverage can be enabled/disabled for multiple supported part numbers. <br/>
   * Please refer to catalog for list of supported part numbers. <br/>
   * If a SOC supports Two part numbers lets say N25Q_1Gb_3V_65nm & N25Q_512Mb_3V_65nm. <br/>
   * We must enable this array for two supported part numbers. <br/>
   * Simulation run with diffent part number can be merged for verification closure. <br/>
   * If this array is empty then by default coveage object for only selected part <br/>
   * number will be created when #enable_txrx_cov is enabled.
   */ 
  bit enable_spi_flash_catalog_coverage[string];
  
  /**
   * Reference to the system configuration object.
   */
  svt_spi_system_configuration sys_cfg;

  //----------------------------------------------------------------------------
  // Random Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(`SVT_SPI_AGENT_CONFIGURATION_TYPE)
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
  extern function new(string name = `SVT_DATA_UTIL_ARG_TO_STRING(`SVT_SPI_AGENT_CONFIGURATION_TYPE));
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(`SVT_SPI_AGENT_CONFIGURATION_TYPE)
    `svt_field_aa_int_string(enable_spi_flash_catalog_coverage, `SVT_ALL_ON)
    `svt_field_object(sys_cfg,`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_NOPACK|`SVT_REFERENCE, `SVT_HOW_REF)
  `svt_data_member_end(`SVT_SPI_AGENT_CONFIGURATION_TYPE)
   
  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type `SVT_SPI_AGENT_CONFIGURATION_TYPE.
   */
  extern virtual function vmm_data do_allocate();
`endif

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data(`SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

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

  // ---------------------------------------------------------------------------
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
  extern virtual function bit encode_prop_val( string prop_name,
                                               string prop_val_string,
                                               ref bit [1023:0] prop_val,
                                               input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
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
  extern virtual function bit decode_prop_val( string prop_name,
                                               bit [1023:0] prop_val,
                                               ref string prop_val_string,
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

`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * This method returns the maximum packer bytes value required by SPI. This is
   * checked against `SVT_XVM(MAX_PACKER_BYTES) to make sure the specified setting is
   * sufficient for SPI.
   */
  extern virtual function int get_packer_max_bytes_required();
`endif
  /**
   * Assigns SPI interface to this configuration.
   *
   * @param vif Interface for the SPI agent. 
   */
  extern function void set_spi_if(svt_spi_vif vif);

  // ---------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(`SVT_SPI_AGENT_CONFIGURATION_TYPE)
  `vmm_class_factory(`SVT_SPI_AGENT_CONFIGURATION_TYPE)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
/g7P@&&5+eAQX3faWKIeO:cf()K]1BfX]JQ64eeEZc)/16+YH3N<2)E0A)gRUf9L
34/T=F:3\IP+Y>d2/\M&MFMJ4Q9>ZIVZ\[@H36+QYEEZRgV=.0d3bJ23L1TBFP@N
OQL1,5=d.2Ed7NgQFH#f_ZE/&7,H=9TJ6NOEE67E/3Q-K8gL>C[TM=;T3A^^b.>5
/b5e.DKfE>B0ASTQ&3g^Z1N]OWCM-Z3a(-15]Y[=?P7V<:_C&CZV.fdVeRZIQO]b
7&7Y:@b^Ld]>ZaUeTfQSHYFY^GH1EAgM-gaD[PFPK5+\7b900&0ZKYQ1B.+RA/F]
(H&^T9&T:53aVWfJeO#IYdMH5M<;GSJ3e=N]?fJ;;=EZ[>AFGe<3.,DUN_C&6H;P
RR+-&Cg?VV[.Q.(K[A1@C2@?+?Je..#5>Z35V5]dV_L^a/=WbFbYP:^JI&?HL.>6
OYY;=(.86C-_]ZSQPWdTd,WTb(JF7E2>M)-L(e<[9I/D_YTI5M1A7<LNN=+=/,0O
ABWc<@^T8:E1N,VL?7g)/d1^(<bXX+U0Z._(:]#.+X,O&<@\I;g54g:/-A&-Z3Kf
f?BJ.9:Xd]81-$
`endprotected


//vcs_vip_protect
`protected
2M/,(MJ,d60V0W3TX2._JSVR]C5d.N=@QV>@L@=Q_c\#^Qf;Y[<.2(:g/HD,a=/Y
FNXaIcFUY[3e2#dGDMf1IY_.I/]),)WF1(g+^K=H5P9R;D,7@DH\Og00>C(2H=[B
H/>^<TXYJZS-SVEXMO5C\QUE/7g^N1X4JeM>d:K+JEG62TK2,#V+/Dg>?4LQP48M
a/3aZaR(D>:U7/BZBAX4PF/]/+TD?K3<E#MgP<Oee-Q+9F+SP:VZ.,QHZ8(?[><B
4dDC3#:IBcYK#S;)WFT3(X5FbUFfYPWYV)eJ.<e]:Yd^c&OVAK7@/8fLg.S@^9,D
W:b>UHR&<OVc(GfaPKUZSA+fd)KAFHNgOSF38^<Jc^S-8VFbe2AF@>B7CUV]XK?U
ML0A\0-(U?[4K,D43Ag(AS?CCF.I?D;J8ge(/C_Z(0VfT-9CfX(]]\GJ)bM9?F3G
]Rc0?\QfE.<891(6.b2IZ/aDf&++D@V+FSDOHBNIgI9MP:/WRcV(c#V#Z0aaUfN-
@:]#B<N[:1FdLROZ[F2L@[fH/Q5P,+V0P<8f1\J.PMM]V>:9aNO)aWaAH24;Q9Le
PdWMI)WB81_fEg(6dc[43O/XXBMA9E)aDT)<@9#=F\MD;Z.IPRf0>+0(RD8O[UC)
=YAW?IQ:U4:5fJ=>GCSU1#_/=+-V,F,&<A/C-c[.(Gb?c1.CSbH]PH[0F/??LSJH
c;P/+A8J4AP>2.T1-.GGRGZNO8KdO+VA=L;,0RY-[(4]K@F96YCFa_W=++e]-BLD
b-cVRK8)PSTN:GU4]5@6=RSDPDe\FP&LAMTNe,7Q.e1V9OI26@=0+[]P;Pg2d.H)
R/4[[X[6?23F8887GbCgP3gA=#TVbPE-@(aU^&3B^VTCBA==X[;.<:Cg^]F-[>KH
c\=NN@):9WONbO_E6&aMDg5?ATH)\GI?CcJcT2ZK,57;QDN#FN2.b0ME)NVEG1[=
IdWK-CU8VHLbI@b<;b1D-#?dF]a-#c&0g=EWO;Qd[5J&S^/+GaT\YWC@A.(/?1.;
JE7gR9aWR8=.bg.?M&.GFB_.#^DVAK5ZRaMDAN=)18g4F(GYeQ_7X4WG>bdQY=1Q
=PS<BIVJ;4Z,FU#a==Ba+8g;=H>d<R_J(20-/-]#WI?8Fc^86dd;a<W_^d]AK618
PMU^YdW3eRZ8[b6VVDVC_\WB1X2@PWV)[TL/:J<47?I]e;/egHK?&;FV@KYS?B1P
9LY2XV8-^TF26MNc6a(V\,\9=(DeA^K:?01GHMEY\Z]Jg&HUgF73YZ<O?13?/N2^
<VPUQ2>HIgL8:5FfOcZ]OeX4/9D+T=6\3CfCAUE\,f8,@8_ZY;VgF0<a#b#ZcW8H
R7><6c\Q9cUESSD-+ZGH&+G+UFcXSH;QF/\R1@AUP6ZeeMY@Cd);W>\SO#6>@9P3
6,?6^[8He4G;LKg:JM0TYV4c?Bc_B(3A-0FFVO0fN:Kd67MeCESg2=SeRDPVQVc/
)ZQ8Ab<0),gU)3[+L+/]A@92Q94=S6LQ8)bF4GELd-:WF8@gY_I,()QL)F\4F=4J
1I-0Z/EJ0QAcRS8O@_O#e]_R@62U>J.FgQBbQf4RRXe[#SD[#@Ic3CY)HadB(YTL
@[fLE3]#0D7=>0R8=XWR,b9T)PV,H:d:]#eO-dgL,<GQV6[Q-^)R[/LTXPO=MQ(]
OYS;,PESc9];BfM]=)Xab8G6^V+RL]1XVfV>Dd1=(3[@J3/?XL(GS;267cC4-0aU
?/\WO?ETOAgDL2.5=O-K]cIbV;^>^[/5U\L/^/O#ENIGH7:)CH+668,TcIN^Y69_
A.5?:Re,bE/YJ;RUUdQg8#PZ4QP,;e/ObPJZ_1[SSH];2a30dPXd,KH012;PGFPZ
PD9_.0cS7JM?,+ZL[POga[/,6D96;I;WA@8ZeMHE6BB.A?)aMWCfFDMQS1MeJc+N
G\L:<ZMKS>^1M_7#EfEB1?7Y;P9D]G>/]MW3)P1:DMVPeJ+Q&f]DMBW/bFJfg3.L
](CFaf@d8&ELc^Q2QPe@6+3?K?7AKU8A.9W#4>ZUdX:R1F)d6UY<Z-9/HaE+PN#-
c4?QLeW=_eSDU0MgVWAC^GN[]Oc2^Q_81\F6Pg:NT+I<+<<Of^F?^B;R@EF31D(^
5W1&TW]QEJ5K>/FRWC5@d94b;&X9#R([Ie\C.0Xf4d1O:aX3C&4e<O3+D&,XR</b
ee)KZ6B;=JK9XN[A<TA00BI,/MMd;T-TCVe/SOb]V--c4?+1<e=WeLb0_PbT?DU3
09_HC]7:.WN,-a?#745RU/.dbP8)C_VRE#/;6KBgTQ^_,ATFFPg(\cD=I=(PL:=F
;O,JT>NDVdN\#(eZK,OfBLWQ\Bc311ENK+,Y3;,7S)W6SND.9XQD7b]++/28ZV=[
XA[L25:#([;E88_AAPU_4RPbDS70O<59MHX@:JNM./2_)K8\Rf>(g)C1LBF=)g,N
H-bfB9>W]UK2)gP]F,L_W+,;d((,V47OYWVBV==GEP#0_I@Ndb+UKS(c@Sc,D)YL
T]P6R1V+=@-KT^8KM@?KHFMD7=RHFJOgYa/4Y11bRL\gTBf9Q[;[HKM5Wb_f75Y-
M1[b]^M/T>Z:,BT\?\A&<gER&R4CHX<LY=O&&@PTD9_<V7^N,W8>e+Ca@GL=JZO>
Z&AF0YZ&Z4=TI^cbg)eJ@C3=8S#ZYO8.GeDTNgYe?)ERCe6-5<;PZb<1#\6cg@RG
GKbdc7;G?<FV3a6M3X6+O9(W2HVP?.3]M=Oe/2+CBK)d9C4=Kg1:@000N;4Z7aD6
;\_-7,B__NcXRO?3PSX<?>Q7eVO]g>R=C\HUbR/KPM=T+V--;\91T3VJGbN9SgUJ
WNBWR&HG?.3L&N;EL;M,0Cd.=0gdff@Dc08LW]WU[Q(\>e/]N3dZT;=]g10b#65E
I37KJ+BMS,.DCT)Z?+J:7O3K6Ice4UB-OC11+5Z@FH/d?160W74QI1C42.IPZXSS
7X#><<eOXb=S.:?E;9WN-=N[\9:500^MEVg.G1]#Y=_L>b]\Bcd1Z8(.Z;NR>LCN
PcMB->EYdW;6c>0^<^WR+04I1O3_\XT?_?]IG&,_&6J.eN.@C]MO<cJNB\TYLEH8
JV?e++#e1bV?ILUFNB:N/GWD)&>\O4NJS@bAffD\Cd0DGe905:gR2?>4=DI/WHcd
02IXT.EC_PAF9HSY4E^GD36RS<[[@eUD>F9A3-V036>BN#OI.&If4/ZAM(/3]B#a
46TAH:Vc.-9^fF_d842Z4J_WV>4LRcKWUM^PXS.WfKG5S25VZ^SH_3=IOAB)gI]A
6[<1d_A/EP=XG+MHRVRD]+3]+R:aX[-5B)(eb+2Q##C/LOEFIC;(K:VA1B;P,XZf
J>+DCB;[5R<O0VP?_;ae?J;=VNOX4J._@-G.,MUbV_C/(:cP<3J0+<O^e4b7E#[E
\+]8d1B55^XC;68ADf>8]ZJdOGOQV=,.]+9S&+-dKN,]a)DK7&(VSV?K&H4;YM+7
3:a,=,W[VIAXE>-XYR>)H6eDJY<D>MQN8_S+D<L[>NI_8X=f5c<aRTb[BB?g3Ef,
Y9DN#af++F6X9N,ZK+8,7>J:T.M\8\?X+L(]S_2Z4>21/Y;;XgOB<ES&_Bb6f(A]
;Yg#S.Mg2-Q?.[V>0g0Z,K<M3=HLTU+F=FBGC=>7R3UL2=-d[QNM=ZSCbM:C^DYd
I(ZA_._Ca1KV_(+\-1:Y^FFFaG:^D&2=4F;MdHCV>C[[>G=JFH2Xag/c.S@gZ#D<
C(+SB[U>gb+<ZY_44Y8F+7>>+89Y5:2HZ4dZM_GUBA23+<Cf91#M4T6Yc\LXO>87
F?NRITUB;)E-+(Xd9C4XRK+#9ab@T#:G;DQ+RFe5f05E88>.B-,LT#HMfc<Q5eQ,
K,+T&))=#>0AagP1a?e4&7<BNNLE&3G>N+=Z8D@/<+\B&BK)^Y53\QIfGE^gE^KW
LXEP+f0(Y0H?(LB\K5H.?4f@ZD?Kf@;QH?I6eDgD2)QYB?SIE\)_/-F:U;=aR70V
MCJf>VeY/B)0[7KeOAWI6S?/ZBA7)+2eg,Xe@&4/Y=YYU,BHVJZI_N8U;#F_Cf)E
bE>MOZFb;ZVaG3HE9@#N[a=4bWQYeWb,]:Z/ZJ0UOc/N?2ccW8M_a^KDC7VD>W.Z
_HgZBgf0G^@@._-aTe^7D[XK#+R26E8;4C3eL4SbbfP<FJX?G6Vb=UcSd+.[??YJ
7/gY,A^_cR#=?669aUV[[T8XUL@HB@>&S,Zd^-MO=A-(cAM2Z>5YRG^IK9S+#UQS
2+@Td?GMcdND3RZ#,4L(2:dJ+.E9S\45X6VcK,1BJ),N+@C\SDUM0(@A)8Wde9T8
>.6=O4gG;d6WW8KPgM/1Qfa/K/W+-5g>7519gM9H>9U9baAMUJ]QDGb]3b6LRDGS
RD#MKg\TPW>fM]dYNNf(^#eAb=D30Q@+4_UB2fI=.((NR-D2DC5E1274H9:8Hg/+
Z_KZ#ZC\X_<;_I?6NcDcH&IKWB3KKL9GQW,R\[&,2O]ME3O/@W^3aB4IA3(_U&RM
R]f3H5R:^B<b,JedZ+bcCNG<66,12A)^DD]f:]V56XF]]_J5]bM;:dV)5YSTSU-_
b/I-LL/D#EXRYIVU,V]^IA#050-1KPR_=0II0X1UJ2G\f:XRgX#bW^+3O)J>I)8c
KbKXgCKNI8E;?-H#?e;CJf.TMKIFLJUe:MV(N\G[6cH:5ZP,F-SEY>-c1GS:c#g,
HQa0=VfdR>Z0fWH^M\bIXPD1^]&B]?LTbSF_V_I#)U?</:fNN\@:gW4&J>M=&1[f
36dJ1E(-)JUbX\FdM31\.+BTI.e)]SB54QJ87]W\8&Ng_N:51L6@#N/a21KFO(b<
DK_LW31>-Qf8W8]X987e1-X^V3.:W.&^(e64@Z2dS^=dV+TCJ/GI3We^9:+.]bK2
:>>^QKA(6(@]&YSDfJ^@2f.EfA#<Jc(c/>2+UV38V<Md]3>([bX6@-C:H79HF;2(
\4dPPedMf..6>dZ??7W1cAEYG\NVDH0W-^2:P<PSQVKL\(?O&/+?I/B3#N/P683H
>YS134V6.I67-e]4R8SBYP[)==I0#+.XGR<cD>8UMY;.TO-Z3ZZ2?.__>R^LQ96.
PgFe-XPV<AJQ#8Vgd9(/K?6TF]HPDAVf;,?8_KM1FccZ@]DdTJ(2bLaE-R);199;
8NZGBX4<C3[b[^2V)D#N(\?MW?3JWNM@aP^b+,.>_03S[D^CBgYT)@_]IQ-DXCW#
Ua(JT._(^TODI)[H7K/S5L/fe[@-D&T0:VY92;+5VI\.)d#,O]4+5>(7K#SF<d<+
7_,]fDLD.4[ZYCHBK6CQcIa/D)WYL2ZHIS3DH2\?a8\2Z(;H^XB+OcT-bgZ-+,)3
;J9H5E^C5:>26MIB51QZP1:+_)VG[<8ZVPH0e7PD8>=&5a#+H818-B#J/D=a,\O7
DY;1S_6-LQ^\ARMG+69_03WDIYdB5MGb-E?Zb)CYD-gKX6^Z9];M(5M[-Yc1G100
8EBHQg^D=f;XRJfJLGEWb&9=4=GV1XX5-;5-HQBLP_SeLDP1_:9&dK5CAK?-Z?cC
N;0;OVaD<bRSW4?EDf]7ZTXbORPg62f>#Q+YI-R,Cf)G[Z/)/GdKPP9B+WJ?D==9
9@eHFXR8E7/HZP=[fgd+BZT^gK4fO49+5f5K#LCdZZ\83F]VLAS+d/)_>2<X:F=Y
cEKTWc;I&=X8Y;TfF;T6##M(2X[edW#\)8AM:QMOfD1C:,?]>E:-B>/1GO&-8S14
=ZTU])W47PWJ,cX,D94XFT81<Ra7>(@L8DI=b.1[geE[Y4C+0?e9eCgOaFCU/WM0
1g/CeEYL)B4DP8-LGOXF-YB<S0A&f45LW_Z6N4dQ8.AUWYSX9X6Y@A+aJ&S(:c?+
Jc55TW]AH85BMP^Rg;WW+AS_VQ4RW(WE?P-RDM@GH7aeFf^0I.Z:cNU3^SOK,R.-
fEdZXV3\/S5DT&R9Ge6MXF39B2;E;HF)DV+)K&,TJEUF1e5cE[K5fRVI\S(S0P\)
AADV\>#.&QDZadWc2EA5FZZ7Y_BC-22NQ\M^Z91eKT.3LO7#&X(.HNP84DcJ9P>2
Ic,aAT(&RTUgPdeGDL[.a5_3^HM3E:>O6bM)[8cW^P?JD(IS/g#EA6GCH[TMIUQB
IS(^:,--]e.29SHef4]8#\9b=85,GX+?:<24WddbT:B(TgP=A-T,bN<b/C8[W5W;
SAIMYN9]SS&?<D#_^@Nb#2g:)6MVL\bA/0=fKQIRTdWNSOQADI[IdeRIGE=LE]:F
L[-W=R\&80ZaT7/#VFZ+<Z=1N=[&KE/?f]V]C;SRfCAc=]Taf&Ob<cd#EYG885[W
Y@DB+-Vfb+]@K?gAD7^J2<^]XYX:(,&dX=M+,+))c+Sa;9[MEa(L04SE8?Z=J?S-
#+_.HAOY:_&D;V+7cC\H[>92_VY1Q/+[2;Z>#3D/(IB)X;<aD>0g(d\?>aMZ/]<^
E)3cA5WQd29?Q[UEbB3f;0,[.<f#)]b<)Ec_;Z;JdSYEPM.?AB+X02O<,DT?P,Vg
8eOC<6L4CTaJIOAE/=;]T]U3Za(dg_?9aS]IWV2V0)ZC+f#L]BPJTGN-[D?B0#+M
D\b\U3D3)].]cGG[4FVJe7@+YVJ/TO8@,>HU7>0fVG:a/Q[]O&/c5@Zf7>(#Wb,E
KaG(MXBN=dN7588^Af3)>-UACG2I=(//0\We\<=1:0bRX(NIK9gD^^@<WgH576IA
G,ZU-DYOX:F[EH7@.cLB))@bB<C>6O1Td8CLNXSFXcU(a+;3.<.4@_^1A7D:=BA6
+7XR&^9[_^g@2RaMEF=>c9Db4()aZ<MNM/W<H=M:W>MdP,<&O?O&X-XH]#QFC=GC
50@1GCa8gF)@->=EW>_9GD]e?,:VbE-XYa\CYV4F,AF&0GT^3_J@>>,B<PRM86E#
9a:8O\W2.KTg.9UC-1^4]?Y_8I&-2PV3C@TQ+(ZHYRKO-fc20=I6SH4G=K6<ag<5
42GS]_7[3C(>2;Vd\(0L@/K9_&GD,Q=0D=@S\)&8(SL/47^(N7Of^a6#?<gGLbgV
V4(6XT\0c@@G-EcfZMW&70eR-02UC^B0<4SV\=E1^&((Y,\[6,PT1CbdR/cA6)4^
+7NTU<BS=d(C\+=Cf8FN20R&:K<\e)^N.N23TC0SJ,W71BST&K8TL6]J1@C2eIfY
fHKIa)bA>f?L3,G4&ORD9OS/ZO:HC[&[:/5C4JG?&JGK]2MV_HPE&R,WB&E30Y\3
J@UfJ0K[K]C_3[BHNQB-^3a+4P:23KF8(U4:G2O6D>/FBbX([d(+@HGR,#:1Pc&?
WR^3F]9BNO<3IL(41O\WaM=YHG7Q9c1L\K9_UE1_)AWFZXH^760IT\@>=I_TJAQf
a^>Q36J>TFd/Z/TeM.@YUI_>7+:L1aD:H_0Jg@437c-c1T=.SgPdNY=R[NIDF&T\
88)/+;]6STQ6e&17OE+2PGP?B9M,;BI,5FYR]^L3E&Z[4R;II=),7#FG1J2S7M-a
1<MKMV)-4B[efZLd#d^)5PUF@-Adc2I\O=YIXSO[=cOe&eDfUORAE+dQE\ab=V[O
OU3T-Rgd0]VCHc]TUNTO@[E2[B#(8a>A7H=-YFbX,YVXN/dRWHJcG&VV:G-cD+L#
02.QV@3]M4c4C0U#+X]CB;V4?E@NWNbD]/^M_\FY@]]?Y/-YBI\3S=G\GgJDFIT[
XGHX&dd2g#2WI)O:;9R9afDS[Je@G9?ZVXNd/XP3/SMD7J]PbNcNDF)X]fC\>4c:
EICaG.8<.C9<&R+.DZ?Pbd1[c;IQ:H&Y#DNREA+Xa>.?9[M=LE4HK1ZU2g-WNJ(Q
TGZF?;R4)F7Z#T9^S+@9T0#;WG]F-[6ZU#F5Z7?@K4;c.N2<QK8MQB@8/Pf/=C[G
(f;gDMT,U3+AJgTYXNB/g[QQ<70cNa?H^cF(=P9QSf8O;6)&?e=(QfDMOaWb7J2F
g&2Ubf3bLY7OaUC;GPdg9A4Z;/O8a^3U>[<FGL+E)4N=([ABfT[J->(##U(G+Z2Q
O)87^e_Z+gTW&DcNAQ,6bc-XF)b?:0I^,\#RO<VU]=5C<<51U,+]^WZB)LL<A=VC
XN^80=2Z?;+C0<5Nb_/JR^#L4J6_/^K:Z0B/,S;&(?[M1X4#D=C&8_,Y2F\A:?S(
5>-[:eL^\(P)=E:\=EG?4=\L;\_F:>X-&D&FJ8X[d?,LFS6bYN,Z=56:eT[G>G)9
G6.WKBP/QY:bVRPBeLTe.BNTWEQC2:^CHD:T+ZGE.Og4U7eW8Z4[O+U_JMV;]-Id
b,-CH]&2[LNabfW]dEBHP^T9JC/ZTREKXOa4/B5.RLBADGOBdMgX5W;J3PaL9SdX
)#0f=aM5T71B4a5bW=&5R64d>Ka2N+-RPgRC-ZQC(,ZN.YYE6Ad0W,>2Fd]b#>?W
8YG<H:4F]Ya3ZJ4?M>Jcd[7?E@ScD2)M821Y@4.6G0AE<2U+-ag-_K(ZO#.G>8Tg
NLf=/?e-_8DM-W\e()^UN_B<T#O3R7>bX>:2P=?QZR,02O@Q?K_N;?MP3A60TC_\
(4.JUAJ^eBT;=U[J3R1d#5CdZ>_fTQTVA7TJ^>A=&M7Ie-9RcXP>+SSY3HXBCfOa
@^BL&UY]3@[ET2[g=UfTP9[YTgCB8S8LcaU(33e)>0?/2U:JfIW118;YW]&gM(PO
ZDH#9FP?MJUe##CTM.@c:1=#Je\\)8?QdT)Q-WQH<+G<e-PMUTPFaCHN<^M1Mf>J
4_9bQOJB])T1I(3Z8NNfFX-J6,LVH,gK<^:-7XMgFaXS6,KAVdVEGD2@E+/-c52M
gKODPF>=(PY)+dL8@0cWX491O\H-\XT5._,d?AG./_9>,,#2#>I0<a8YV#Dgb-fZ
5aXfKg9@9-IcQ/fN)dRa#;c0d(Qe\Re834SS.P&;7=Fg12##A0U4Bb?:/X9V^@]I
IY14K)eIA3RbC0>@;UfOE4]2T/NGd]S&+NL91MGX+VIeGB7A7AAU2^@4,R&(394A
Ua-Qe[H47g_ea/<T(LJF2JNF^eBWS4@&5KH(c68#,VC1-f4g,7S#8\&M)Z7WS#J?
&T9RcV./=eVX3\2LHM;4e)@)W(^(OY[d<YaeFX+:8I,MddSDF#L42?;2]L<K9C12
K_aD[8Q5:[aXO^,,(RHge\=_&(+UGf]0d9[#GIK6N^P;]g:.B<8#G6bD,]X)/>cG
@\.5P/42TOJ\R.,8\<ZG81/U+K-M@WYY;+TGM?7#_.[_e<+7-QW./#+1@1NKJScA
U.&1[0Y>fL@:4<@>.,3Z(6_DG\UBaYH+=I7/^g9A25-\3@2WAEWZdQM2c7SS-&.g
LO=R#YMeAV@<f+<@2PNY6@\90dL1?#Y1b69@.W(Z6H#CGUT_E7eP\L?9_G-,b)RT
cB16-e(&d0Y1:(].F?N__I.72F351cRS8<bb,f=&XWYA\USZ^B18I[EO2[U>1cCO
941WX5&2]Mc?9:P:VM)6acdWYgJD[LegP#a0_A5G9;g@AE@0&Q<X,cRA&M^#+M.P
6Vd#[+P/TAELJ35RTOI0KdG\U0.D]VB9:E.N?[CD?L82/Q6J2R,,QO+ST:4.R;a(
DSY64Q<.T]OgW3e;XC(C.X:YQ-_Z:\?54)S9U7NP-,RH.#ecSJ3[Tb.Af&#XC)Y_
#4UMW6A202ZI1I.^ZU57Wa;MX.ccH@)P&L2<GLgY(XU-/He,Cgg2Ge,ce3CB8L?/
>T7#98QR=bXB8Y(&V/=LF2B46<1eJ:Q=A:IFG>F)X.2JP_[7>2ad.RB)ZOA9e;(;
112XW9FI;?AM)M9Db3:D8L<4-VLFVgF[3e)cYg9Z(c4gG&B,Q1_eS4fbF=K3)^6I
]=5O<TJ<S_,\g0>\=Y+/K233)X[GAgELTLP[NMa^aU[5,J@W8c7G^H3a;UeM^&C&
P,0)9/c;BGJc(#gGe-^F\Q=Q<CdJR^FCH9:J,1HI:WaX:F?U\]EIL_eR2egIC)/\
V[JJL2]GQ4bTfZ,dZVX0,=Od-T.G+UPGW[TA?Y@a9a\cB[Eb1cU05O_E4TZJ)_61
g@SAf2+G&+Y:aMBQGGFcGFQKOH-06N4\RIe/-?ZgR&)^-;IS8QJHTR)6YP>ZUE=1
^V5?6XTD9eBeJMeWccB@RSgZ>ae,@#:ADH8.X@:XRaQ,S/Z?L8f]_KD+#\U^S0ZK
;gGEK5RG];4gITN^ZgcGF/0e6^f+f\9.DT.b;6NQ&2)+1G^0SUI,SHHO^Z1>0[OU
@C;MSL&<8(]\63S&d;G1ZYF)1Efc@]J<Y#3@^d;e+H^IB>9G_B>KJM4d[ABAZegc
f(ea8C+cN>:]?CCM^,4[3&;K.#gAf5bKF258-Ac_4C](eWCJW]T#,AOS\<J,O6E=
SO\55(R=+DR@SPBHY\\B0O5QME.Yd)fV1\QY25^BX[00_S6H[a3B5Yd[R6g8YJKA
A:\BLH@<7dMUL,&B3BAdM=0\Y&F#Q<EDF(V\-X<ZbDZb1)+QPN7F;Ob3D-+>)8N8
C[Bd>(8=]eYE[E?5Z\b[bMM__4d5EJ=X1g<&DDJ?8/CM0]\Gd4):f_SNJVLE4<E/
Z@aTR]=AE-OR#g)C+OUT7\4(GQ8+a.9H(TD]H=7>:\aQ>58YM<?A@Q,I.04(P_7M
_-K/0KLG(Ra;b::[9^&\RP]][-5>A=1=YF3(4bL1URaYdf)K/9\WQ8.DJDQN\=&>
?gR-5e-6fCWMeI[QcfWGWT#3#Q#<N(#ID]@\-4B-9A-H<E&9M#2W1>]0[ZLF=#Y)
/P6ST.2NAbZdECf<BQdF:f@1&Ba<Cc-H3\6NdN,&5Gf)IMa(4OSXP<]IS50Y>L)5
W_6E[#?DF5[\G/O/NBA&.]4;-&^WQY)AF[AO63MdYHe8;F?AKI@RZ16Kg:DaNN:1
ESB4F/S4:8[gWZ5LAF(8P2?Ma_Yf)fDJ#[<,AK[HKHc+Z=,62F2F/R:S5<Uc5dB-
a;7@R\WT@cI[D<1BK6YORHV47CP3d?)QQZ>B[D.&/V4MVKX]NUUVK)^35V2>=77Q
-LOE;e.03ZY1W[Qc\DY(M>Y4?/35_3QGDD/Jc8AggZ=7&<CD#e_SGFg-X+M>C1+@
G&?,9B8H1GaK4J:OQ,WP5#fWX\\EOHf)3HMG\gGAe.5@70YT-#MB&R1[g.+0Q3#F
;eaJ@VQW9bZ[^G7QWKS3EB0PTF>IbA6[)Q7E^@K(>/-.<@+,/[,eMgS?+RXXHJF5
bK0ZIM/)_?6f1&_SX,5Ie9QXC;:-PX,E[DW-SIS>dDO6:a:.8F9Z[3.Q.F[1&/Xc
N+,<BV\0FFBW/,P7V[dZ[-8(Aa1:FZ9QM_#LPX5/GI6#,.6]D>E[K\2G6;daP>KU
:I5?0:?FS_>8&\P7K8[>g=J7)S@KaSHUfBNK2<UeP,Qa7CTCNNCdA-_K-I5G7IDS
AcA1B4A;LEEH75cAMaP/[f,41N\R.-AJ:OWF:0>O/EN(\Y6@K:^SDWX[-^D@VfYK
WK&BJdA.#SDUTFf@&c_1NBVc3RLIg1GY#W.gQ_.B;]N_7,=BAcCJGb?e4D;J(Y-X
7YZ.0[R6C62D0F(;\d2=E;5/a\G&P[J:,I8KDD;GNK#Z+JV^&2]eA@[-H+0g.IH?
X&KI4E5C:-O9IT.;OgL\a<[K:<=Q4H>>WeDWe8.V#KD9FDW7X6Xega[K:PSY<P-6
]P;dI1aOf)(,)8;0X#/L=JV]-8cJ=#_7Q.eXRTS79RG]_ZLT)[B7O]a/6&MU=bW1
DLPbI]e)[?T9510G;c_+e??/Z7V+/05Q62Oe5\81UN;55XB:GE.gYQ(+Oa)4,B5I
c;TS:fD91bGUSR],;Q2X3+>1Xd=SBI4SfXWX81dCXR8<[Pe+.#[4-1,g3e5c1BCS
BXUH.&E1G+YUa.\+YS0Z\F0Te\##eSSWW/;DC.J:=(@ILeWDO-IQ4/_f.^N=K-P5
9T_TC3^5_QC_9#]UR42=O6RL8#8FNLHb_@dCDAa=D@Vg37:]UK60LPc]]OD-5ZbY
>H0CKXXTb6FdJcE-_&BF=G+Z3b;Z2_UXS5BQ6O:4cEJf?/O]eGHZQ_KVU#8V+69G
<FPb[:O6(6#K?gfZMG]IGJ62\>K)-c[b\HJ@;P+VS1daC\T]M.]==eCMK+9R=;3Y
=T-NB0UNeggP[:^V8c_C^3>.eCHQ4S#6#6XI&BSJ?=E1],ccX8&D?N8.\:Mff@?a
PDTV6,:EQ;f;;YEF4a;#@[(f2e)&Q)R]54NZ>B@1<2_D:@ACaGKTTO/McU=Q-6WO
)(K<@3;,P>Ac7ITNN<^\/\cdL2<35e^;1]91J@2aP2(]K,(SFW>QaGC^#T&1_0;^
VXJ)6g..dH2L?XE7<e@PL7Y2N9DA/17P0>(]aR9PeEKf2Agb4bVG0&(&b22cgCL-
.LL;&+6R(TI->dc?E,Y+7BNMMJUD6Ga1#>Ca1J:C;Z1G5gVE-RHAEANRW&ZI.a?:
(Yg^^Lcg4CS1DT+=25B/9F-HPZ1=:CMZP[5]SUOD1Z+21,4,)4c@4dDZS46-Ea/^
e2\(eOR5H)7^HV2T@B&G+a0^H;=c/G)^N22.IJfe);->T?>dIPD^JP[?;?[-60&Z
>Ogc/G[QWQ@P2F<Q1(CS-OIa+EgL?U>0f+g@5dJCXe6THR(V2=E0@Qec,V2--[0C
O\Y5Hc[E<U:T8e@gTeUVT_cJfKaLSZD6[;b/<\]?-bVS,II^4C4&AQ+T\gA:>ZDA
@N_@BE,:,,R+MgCSOb<YbQ8U0@A;_,ZB/[Cf7g\4e[+1d4-dKA#:KD2.T#5fRebD
EgP/4.2(NV2+WL:@g@R@4IQ[Tb,JU8I@,Z7@:4DUVg41fg1d0ML8MLAMeT#=O;CS
)FT)N)^cf6a^U:6Gg/?AG?+CXUYJa#DD8Z):+eZ_a(T<9:V<B\)(/F8:K0(_Nf9e
U4._BSY\X9IO785LHD446b45HBZJY?3W\e,Pd:LH@;79fJ[\Z8ZX^W0g0&LBL<6-
.JB;R9\^V[:.GaCMI:D])T6CJ?]\?bHM(;)fXUT0W3+K_XW;4Pb\@P_SdBXTXIPX
ATH])3>X0_bR<B-RHTUU)XRC.bGcQ:_PE=_#&C,@<.UQW:Y#95d/\I(]\?DMcGRT
^BE_L,-Ef1/OUH0U17LXE9]\URT?^/SCHQ8R9GUF6?B/Qb+UV1R<c+cG7GaFZH->
;PBRAOT++Xf8@#fK3DRedH,@.dM2D(D[bZW:#>7DUW>gZ_ZVZ(.f,U.(PZQR=GWM
34Y@C>QHT)G+]_O\RSdE;QR>SOY@X,eb0/SFae(3FX,W<7_;AOe6a-V3Z4NY8#HK
#S&@C.>KJUG/^76+;c0-Y^_088SYI_0R3?QB>F\\gNX_)F&ObdFGf6/bW208fJ1)
:Z/D>Q.<):8.K4K/OdOU\QH]KR.&JXV,->E,U[_a?Sg2X9KHVc?\PT-bgOW4L&f,
>:^0g6+)bDa<22:--9CZ#&=16K(C7g&J,Y2>)^FGB>D57L5;aHW_abSRF^;d>:J[
6LUU-]dJ<1Y-Z&VMPJ?<PX:JDW=3RL<:)c.6:FdfJgUX?;HTg/\0@F7f1#5954Uf
WO]1^N2BJ8eHC@QEE>C)#F7QeE,1?M>ZVb)N@C>Q=31<I37EP-KAB5b-A8I;Z<=0
S\dRd\^^H=6I+BOWgH_;@V]+2OO-FR(FYX(_XUH@>@EV)+#E#JaCdeQ<JUVJVHFg
]T523C+9V+_B4AP^3e4U6E\O&d,OcO\_OJT;&g6Ia)f\ZBIR.?Re-448#LSUY[./
\bKdS0Ca(SY7V+^S^;/c@G)/)4f5D8+O4V</ObQO65Y7570><UB@P[?9,;cfJ-_W
<5XHGW#eDS/)1-VUf+T#+O9f2INf#-<>1(?3YYfMCG,M3aU&48?Ba[LGe]+A;)4O
##(^LN=NTN;H;V]ER?I=7d?]OUW[g:U,@R0T5#G23NCK/;f+0:=P:W2e2J;ZT]/e
+CLb06[a3Ne=&5;0X+P-SJLR4N1BHKSA1Za.ER8H,dZ3BXb@^g=/O5>_/S__g-UB
M&02JGD5T7>:2eN?PNJ+/IPb88M)aF-4?0V]90].CZ?S:B=ZAX6G72e8BPKMFMa+
[K5&f9==Cc+E@CBb-Fa:,^D<+4S;^TX?bEZ2aBR]gEE7JJ=.9KJ+&RQTO:c:bX+<
HESDH_;/=F+IO<f/MG\N7c,#JGH@TE,R]5?PZMYbPZR9EPH_\,]ZTF\M@Q0^=L(G
TIXWfZ:=?R#THIC7_+DEZUK5N7UE5XS?7be,0-T3H&g9N@(2FAVIM^;10G=6I8,X
fVOR3;L^J-9UX:<2C38HPG#53NW=QKU]<4:c&,N;Bd3aSXb,Y)^46E3(_7@Db;Of
_7E3N6>f=HD\CG^Y,:eReQ1+0P1(RYA8NO?#Zf:5-d))/b[_b#Te/OU_^Ag7]DSL
N3#=28e0#V;Bc=2GN-.,J6SJ:SX7IgJ/RNdJNN5\4QX,-=L1.S.B(^<BfZTg(CD6
6ZX8Gd02Lc1Y+D?:cYcTVaW=HOX5PbPeFDCELXKZN3b6<QRO-7+aX\8?B<IXCFL3
(J])+&N\>9F4??:<DOB>A6#bS+W,Jg?46GZ.2@9c)[g/9F\,[<DKHIe^A)UT-QI^
Y-K;?I,aF+ADYa1V#-Ha-gRRT4=IQU@UD^MJd01cFZbaX6\K]OP\@e?Ve7-8\]&d
+T6N8]SSS>.JaAcS;6J1WF#e1Ae?QKX_J&e;U_ON^C3O\NSU3(3#/7I_S3I@V&Fb
BHTP^E-S;2Ze06/X76<2K<;6O7P/;_8SCZRLc]BCJ9Hca^1(5G=b];[4[[?]/5-g
:6)UCRXM#EXS<:MBF_6_cdgV]/)a0+c;K4;+STYL9E]>9NY1:6df=?MbX(J#d&]D
_)G?(AfV-;4PCYG.Y]8YH?A7V/fE+,=<<1U>_aF4^eBD7L>dEc94J<@-]YMGR@c9
W#Ng.9@;..QR.J644;QE]c@R_D)GXAJ)^B9<[WQE\TFM+P0_+(@[N?,]WQEfJ</9
fBP3N.9<Y/L2\YRRXPW/NV:1QAGDU;H7#d,[dGcF3G<UKa,ZKHDJbSCZ\9C>Ha:O
7]MUMgLPOP/e=g@UBN97YBe>A647NTB[dEUaZ2[=#DbGDE]0@_^dbQ?RQ4)>fND,
:+3dWeW##TWV:gB6e.J7-&8,&b-R]W-S_4X-8cVAdO0K,JX0Qb-AER:<)NZTHY/(
bNU4T3fPP8b7JXe(R^@#fRgH@0BPYOfK96T)F1UOeTB\4#WfHMaa6c4_CCfMf8O<
dB8Dd.VBd7UdgSI#^A3:?UXgT=MESRJ&39YHL5<45N\/UX[<21]C@>a2&4=A:Q2@
5GPVO9DJEH:#N3b46JA(,K0K(0W>dfWJ=C=6<:OZ-eFFRH81e]ea21N9OB:G[WIC
-/:LF\_;<Ug6g_[fZMCR?&[H:QK)E0Z7VcOZQ5S9YNFBD<<S)JJ;)]/.>/V)^1eW
3GO0F0C;SD+NULN3-4\(WR0_QNRUCBLSZ&G#O97dDXOMO6S0)BF<_L#.N?E+C5)8
&SCWdCB\.^,<GVUUCH[1FU>VW?VLEfW0^1Ic)66fT4O,&@R@Fb+_(b@-C&C0?-[\
FY45RceIUNIF7Off0D??+:]C.:fP9N<Zd6/IdgTZ658E46.N:A4HYC(MgGPRYKAK
SA<KTfO,CI9GfAJS>+)W@(fH2Id@6[M.M5Eg]@<JQgd/\HFC)K.BWIJ[7MP._9GQ
\/aW>T=/GXS]-?@LdC3-.T(#2ZGSb+88_TB>WCW+=2>=T#L:.9A0P)&Ib7.GOM.U
Qa6KF##^>DeT,7VCf58eO=P=RSA03#3eSQE=aA(MQBa,I8R0)f5)&<cLD(N0I4b+
.STe;#TNF9)K^;9X7:/,<eGS\-<TSVO1_YT/^RTLGR3W>+5:MEgcZ=)\CC4aBXAb
fdc9?a2Ia0DaP6Z?PE>30]Z?]R23V>[GNMH/W9&K\IbB2C8dCN#C&<NU(39F#M_g
KEf^3VQ5Z?=]]A+XfNA?RSL[F,W26d/_BO,3[MJL[7@-HBZf<F8-bC]7)Ff:.g;;
NKKSV@?N8:>\C@R4Q7UBC_Z]<^#_c=M&<EDDVX2<3&CJ^SgQMSR]dI9W-HH0A25Z
c;2aO;K(\Sb>&+I-/RZ>)6)BM_BE2<dD&AG7.C>0[07:?_CERL:TO[c+>K)E:\WZ
<9S=OI<P\V\Sb3PNH>_PTB+B2:9G;d7D9F=R7TIC,.\FOB\/[XS>e:NKC@\=K2R1
Y^G]I^.?b[#cI>#.G5aXY;C0I9aIDe]I+]2OIA;34:bDaI;\#-Z6#9.<74?M(3K.
4a\6+&<\MB@U0H#PXV.I]Q9C,BL+8c2XK6d(\bLW]]]YISE+5+C4)#JdSS02&NV_
JV<CA>3X6=PZKCN#MKE1&3CIHXW>b_cf04@/1S8e59d@(7<WL#:eJYZNPXd+#QWf
6>ZXU4:^CLO>T+QDF[(7#@)M^^Z+gFKUe(,LfdMRHa=NaVB,MgTg>>c^M);1Kc-/
L4Z,CVLU)FU+YY3.TWA1FA4L2B17,QHgLEWGY-.M^T^6CU6eMM^(@]8@QD0T(5I+
2AVe.]6G^<-QCU2U9EdT@,NR,DX,V3[^O@MA)J,V=KaQIa5dEQ5f<c[)O^UAgNMb
MXFeH(RQ13L_UW0bX2Pf.:JQ^]7V?;JSd7R;M.b6QJe#^HUC_gLZB9fA8R;f_RVD
VdZ&Z+fWY649IC8\[=R6,Q^(T-T(G//AKDcT-GIZUF>)7@>[ULA8+Y@a?,U&9O2>
TU(215DDKSVJeg[APN#>N1Cc/XUFBdDF/+F8IJ+eH=R>]?+1;f&c-79a;DaD9+YR
\fSH+[0IHFN9L78:P;Afc(C.aM]Y/UWD@\X]db@+&.43=XP8GLS,QN0[>#PD9M(2
4OBGMO<0B#L7?D@V?dD(1Q9?P1J)B\)EKLU4V:W7.ON0JgS7TXM1QAYF:,ZFA<5g
e9=1N</b,6159??f\LI?6#?,RgR3=>YJEH-2@;85fa+Q;BI:CYCaVLcCM/;N3QMF
K]>SWH4eU7\:9aCe;ZZNANc6LVF6^>>g.d&6.:1#I[M3LO1-4[+;.VB6(ND4@61W
11fIfTLKR05U,UZ:-Y#@[^2S?TO6V\YWC:0&@)DU)B=gRVb)N&=7L+)72KRLCAQ6
;>WdQ/0E[8S:R6591+LI8Rb0?=.#7?@^7Qd[PB+cN+4&M0A4-X@F986]+Y:F:MBZ
#+J>]E+I,@8Z?S(3I4cVLKG4U01Y1S\>8(?FNMXKOcQe.V5M4:@XeUGA+2D(G=Y0
FOcg)+83OSBCT,[/c._LN.ZJ<:Y@[<+T<&I9)I?)E&:cKLc3U:>25TH>EN+#O1?@
g0E:H^]OWG78>gQ,1Ba8O>b._Lg/40@S19G76H,H&\?U+1\WaQc2SM-^I82G3BAP
XS1e48:YMT8bA[/95X/1WaU<T9;B&Q,(\3MZFX7.JKb>EI#&K)GF+/4FB7)[Y:_E
AZd_@)1<UB:]=]EB@(C<U9=T>ETEE@S[GIL=4D@G,Y3ef>gXCJcM8/TV];QAY7;)
#db52Z.E/,Lce8^#^B81X&1[55]1[M8\SPM]RNVTF8=.DPBFKeS&WF[WN3.;YSc@
(_AH:Y?H;&L?RVAfgT^,#X-1;U=-TQT6::^/WUf1Ce>MU061E?BeE4I(XR+2cPC,
>\@aM20VUO?b)2J-F\-PeU0c@+Y4^bf\-1=ID6GeAU^V^WS9V&e6<9@(.U/U=<VR
d@F=[K_1BIF],LA,E]>KUg91HcI-6Tc&.dc[1-dEPSHFV;1QN+FB[DXS5J4-U1.0
=X]52-6D^[Tbg\a=R@75fCXY,Q7L<OL.07.:&^^OKZRK;5Q3WJg\R3P6TY59fVZO
g6Y@QeAMgX\H3WPg05gcbXBJ2EFZdL-;P(@CZd<,)+&ITfJY:bM0_DF&^RNNBL2c
A>)#KMF&Cf.c0:8PeRHT5P/2A8>@>P(O+7,(((4ad9;A=4)9;[W/;Z&M80;HO8,\
BeL5d0/\)>XR7:a,W..>2BU9d[.]5S^aDH)4=+<(Q6A:\c]Yb?5)@bcC\-gX[c,^
,c:2#GILQPXf_TH?/[6#;HbF;(O[^9CGYK_&4FFaPD:0R]J/fV^B[dHc^KO@#>>U
_d_LY?@3E8B(2W/@6S4)2;4&aY?E+_;5a/J+J98\XJ.EL21QVcG]B[XBR4cbHeU,
#2Y5589/+/B)K]:+_\IP.44/,Y[;X6G>[61VB&S,L:MN#g?GaA9#DE+GLT@bI]&9
CMBL/EA5?NF-f[,Fe+?3CbMbM6d8P[(&FdRO/D\2e0Q2e-d-]R#HVR&T.F[2?J=?
\#0>HHgc_1_YDRebJGbRN_Z[f;ZZ3F^EBGRU;;BG/dSQ]ZY)9HR-NQ;U44CJ_&2L
Qc+?e1O36L)(T?-dN7X?;ILfZ1T5VR-[:HQ_1HIBM.,>DMKIP=1XAZ-#_aH:eM\?
P.8bLcV/C7P6GZK]1gQ8>RAG_)(Md\fS3RF2FCRg(d2TCDOJEbY7<+V+J^^;cVYZ
KC4>@O4/?fR+gPT0aaZTV33#GZF&N?&\N+R]9fR.T9<8b4X<ZQe^L(&AbfQ@B36-
;LTQ-W19#CJ:)?-LA1F9CPWbYLfHXZIc/9d3LM&b^E?QFKI<+/eA?a]>/+OAeIAE
U.[HW3gKJZ9@cY4dMEH8C@TW5W.E2+LDBgAEd];&?G,c7P6dVVH1Od^>0PR>QF43
Nb4E\:T/;[d\fNWJ^PQYGID7)<LY_PU^(K7.8gMG>N-Z<bAA(\Z0<(6Z^2B<UNZ>
:=73ELUWX63BV4S?(,T+D;L)&cUW8N+O:Y;<I4F8BL,YEM^ULW51PU8Y(:29LNXA
_c]NS-8DbW+\2Ec;X<BO@(c^+4,gZL(W1Y?B>I7Y?V+9\VB#BZRMPGg/)&W.Jc?8
LA=#UXDbDB_74+9<]L<RB>J=&d+B&QaSD)UR11WJXFEZQ6=I6FKXU/TF;F7NaK4/
XX&dV9=A[Q-b_<HOKG.JJD5Z]A1U>&cJBg?V&fFMU/8g,P7WSa4Cb0;ED,N]/V.0
6?d@bGecDfEaC.>LD8LZ;)\XdgQ&DBS#ZB8_7J6&1/5:g=FK:Sb?=]R6/WPYOM0=
3N-,fF<ead^)^K_6,QPAbR)LagM>.^aP/7fM=KG,#I5RI>5K=RgQ)U9/W6M\LW8A
F)c0g?78d+:J_KgG/GaNaCN@,6M[^J])]DT++E4G4dfc(B_)eI#MS@/03,-dJfRg
Jf,)eV.fKJ@Id&[gDCN&)K]]3>Q;/F-1G1<db[?>HW;2K)QPY;dMC,/a(G^KJ1/b
12[;ACS3L=(8A?&+6(ab48E?./,?T4#=I_bd\YEGR]SXE=.#V0D@;D\<dHNU]5.&
3f[B1V8R=]+5MJSSIX@Z-OQO,+?Y+<?3W;aX/1b=3AD,&&>AbV:W2F.0/XXE3Lac
XF4.b:_gQ1fcFYC)K@+gC,JUE(88P6:ReD=:ZZL,198@<=BV8deg>6#&P2_,@I??
@BJYd&-TP/#:IC?U>VaVT5dN8OX41@[B#+6.>,T@bag=B9#233VQW+WI.T6]@-,J
^-+A,[Rb+PYG;](GS&QCZ6F0OO7L1-V)a\(4-#<f<(9^5>5;fH^RI5?7@6&UfCNJ
8ef\bPB)>TR,>EXC,BKA+O,dWZM(_AC6GD?9LILAE-WDc[cD/U5N6?WXRX=T^OL:
e#Kf:7_(XT./;FcQ91HCgX9.N@d-^eBY><T,F4d#L4+GBFG0M&(UY@T2U8@B2_2W
X6V^5N(-0bf54W(<4T7f\U<9N5R^2DYcc9JNUDI;5e>C[YaAA\?X.-^5Yb?D[TVa
DK&c:,VF_V8O#ZH2-IdfW-U^<9AbZ@[O#U>LQC_H])[Q54g.XB.F<RfWUfS)cG]-
,FfHG9JgU4;..[9LAT[d.LC33dZ83J/WAa20M1=d1bS;O:E2<<8aCT;\LVY6^BFD
3.KS0a8Y+fQH+J9aU74f>C50=47fT()TKI#AAR&YY)G]2QDN1X7d+HC0MA7)LbMC
&0U)XcB[8C?ZP++<@PIa-_DaL\8CMP:e(S1?HGJ\;#T+a;M)be?UHV;YOGPcSH+@
<FRRgTA1/ELGB[X^1/#H18T0V4)JL\\R@c+R8XVI381Bd>+.V?0)58Ne8MA76DV/
58.6a5>YRS@c[-#KZ9Q&&RIA-:8?MS2<6:Q^V4C56W)#1M]G<F60afG/EREUaHI5
NG_#(R:6-WEf@=]f-=f\2,49bI/4fK53O7:3Z&EPU2B9,>I<4SL9gR.^H[B\);C8
F77^0IW#6Ba_OZEQ,Y#843LN#)KTBHWd9Fe8EQ+^KJ<&K]55#LW9PEAF]Zb3cDH,
eH?P.Fa[eB+GZ,^L)T?229A0=ODO\b9N.3GFIIfBC=7.a_Nd;E5@[--RYHJgg]_&
1L1PF<3.7AE/@HFKe<eaKPK^FZNY@_gFFc+<-[(CG>^O27@[8=YEC9#?K\?NME?Z
M2QC:-8WYfI-(X73==SefU&L4<Z@+2-BS<aPdWDLbP9_7?6]:-#SSD#?L$
`endprotected


`endif // GUARD_SVT_SPI_AGENT_CONFIGURATION_SV

