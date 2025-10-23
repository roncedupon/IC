
`ifndef GUARD_SVT_SPI_SERVICE_SV
`define GUARD_SVT_SPI_SERVICE_SV 

`include "svt_spi_defines.svi"

// =============================================================================
/**
 * This class defines the service request transaction items that can be
 * triggered from SPI Master in SPI_FLASH mode. 
 */
class svt_spi_service extends `SVT_TRANSACTION_TYPE;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Handle to configuration, available for use by constraints. */ 
  svt_spi_configuration cfg = null;

  /** Processing status for the transaction. */ 
  status_enum status = INITIAL;

  /** This variable defines the type of service command to the Link. */
  rand svt_spi_types::service_type_enum service_type = svt_spi_types::POWER_UP;

  /** 
   * This is the weight controlling variable which determines how often <br/>
   * the RANDOM value for DQS initialize as ACTIVE HIGH is chosen. <br/>
   * This is applicable in Slave Devices Only. <br/>
   * This is currently supported in JEDEC Profile 2.0 Generic Part Numbers <br/>
   * when svt_spi_mem_mode_register_configuration::enable_multi_factor_wait_cycle_latency is enabled. <br/>
   * The Max supported value is 100 and value should be multiple of 10.
   */
  rand int multi_factor_wait_cycle_latency_wt = 50;

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
   * Valid ranges constraints insure that the transaction settings are supported
   * by the spi_svt components.
   */
  constraint valid_ranges {
    if(service_type == svt_spi_types::MULTI_FACTOR_WAIT_CYCLE_LATENCY_WT) {
      multi_factor_wait_cycle_latency_wt inside {[0:100]} ;
      multi_factor_wait_cycle_latency_wt%10 == 0;
    }
    else
      multi_factor_wait_cycle_latency_wt == 0;  
  }

  constraint reasonable_behavior_type
  {
   
  }

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_spi_service)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate 
   * argument values to the parent class.
   *
   * @param log VMM log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the transaction.
   */
  extern function new(string name = "svt_spi_service");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_service)
    `svt_field_object(cfg, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_REFERENCE, `SVT_HOW_REF)
  `svt_data_member_end(svt_spi_service)

  //----------------------------------------------------------------------------
  /**
   * Performs setup actions required before randomization of the class.
   */
  extern function void pre_randomize();

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
   * Allocates a new object of type svt_spi_service.
   */
  extern virtual function vmm_data do_allocate();
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
`else
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs.
   *
   * @param rhs Object to be compared against.
   * @param comparer `SVT_XVM(comparer) instance used to accomplish the compare.
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`endif

  //----------------------------------------------------------------------------
  /**
   * Does a basic validation of this transaction object.
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

`else
  // ----------------------------------------------------------------------------
  /**
   * Packs object into the bytes buffer, based on the `SVT_XVM(packer) class policy.
   *
   * @param packer `SVT_XVM(packer)
   */ 
  extern virtual function void do_pack (`SVT_XVM(packer) packer);

  // ----------------------------------------------------------------------------
  /**
   * Unpacks object into the bytes buffer, based on the `SVT_XVM(packer) class policy.
   *
   * @param packer `SVT_XVM(packer)
   */ 
  extern virtual function void do_unpack (`SVT_XVM(packer) packer);
  
`endif
  
  //----------------------------------------------------------------------------
  /**
   * Returns a string (with no line feeds) that reports the essential contents
   * of the transaction generally necessary to uniquely identify that transaction.
   *
   * @param prefix (Optional: default = "") The string given in this argument
   * becomes the first item listed in the value returned. It is intended to be
   * used to identify the component (or other source) that requested this string.
   * This argument should be limited to 32 characters or less (to accommodate the
   * fixed column widths in the returned string). If more than 32 characters are
   * supplied, only the first 32 characters are used.
   * @param hdr_only (Optional: default = 0) If this argument is supplied, and
   * is '1', the function returns a 3-line table header string, which indicates
   * which transaction data appears in the subsequent columns. If this argument is
   * '1', the <b>prefix</b> argument becomes the column label for the first header
   * column (still subject to the 32 character limit).
   */
  extern virtual function string psdisplay_short(string prefix = "", bit hdr_only = 0);

  //----------------------------------------------------------------------------
  /**
   * Returns a concise string (32 characters or less) that gives a concise
   * description of the data transaction. Can be used to represent the currently
   * processed data transaction via a signal.
   */
  extern virtual function string psdisplay_concise();

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
  `vmm_typename(svt_spi_service)
  `vmm_class_factory(svt_spi_service)
`endif

  // ---------------------------------------------------------------------------
endclass

//------------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
`vmm_channel(svt_spi_service)
`vmm_atomic_gen(svt_spi_service, "VMM (Atomic) Generator for svt_spi_service data objects")
`vmm_scenario_gen(svt_spi_service, "VMM (Scenario) Generator for svt_spi_service data objects")
`SVT_TRANSACTION_MS_SCENARIO(svt_spi_service)   
`else

// Declare a sequencer for this transaction
`SVT_SEQUENCER_DECL(svt_spi_service, svt_spi_configuration)

`endif

// =============================================================================
`protected
@T>P4bD\B\e:^#[A2-\b?^8\YH)[+_74N:;dFAU>Jf<J9NDQLH-3&)_JC-c>8gZN
_>PHc^3[V=(C^2_UUFc0G=F7eHU8YW&ZSb=#QQ5E?95YP@T+UL(9=#RLG5[Yb8(C
[>e#@E_T1HIJ&(IS\WYHW9L@9@6UP[+R?G<F890Z3;ZLVC3R9I=f(+I;-8XX8d@>
200c6Q19X[P-0MI],c#ZZFQ\-C6ODHA4;23BSF>+Yf?P#1Z9f5#42UF:gULXRAHA
Ieg9d7ZI=08Y7:L/HJ.)RNH<V8;JLPKCMMW7/6:N47c0A^]^ef&WHE72U@d:ZPES
;PA<dS.Q=8_WTK-6/&K(_:^)P@K7D^WDD\A+3eH[YEVC?F;KIK9#=9#_,AS]dKdZ
1O1YgM>\9=JO(0#Xd9O/Y[F4U^N7(C<&_._W,F.X72ZY1S&-gIQ4E]g/IX=+RLdL
gMU\YQYJXB,,T2@\R]edW(:T28AFJ(O8<YTa-,AH+\P\C^SSKY-PPG(cQGDV0B=+
P;Q&:UH?6<g#6=3A6&_=)RET7\:0ZLgR&c;[G..S1JXF?[[?=1[I3CLDeI:f78NR
31WTW0TcVN#W./D;Z@bC(/WT7GO3aTXcZE2,gCWFQ]<A\QLb1E_\LNJ\);UDKV=B
BE\\E;FJf2=J(8OCR/_IQSIES,^ERHMIVVIHPYWT37_>fbTda2_ZXWcHCdG=UE+U
/GT<2=g6NY0d]JRfR#77_7cQ6T1<4JD0-TZ(+@6[.6N6gIQ<WC8?&eJ^P#Z=./C]
U,J6b-dYEBIYc?N8(&IM8^.F2VESQF_2ENK4VD_Z2]-1\/Y7b<Y-a_dR0SA&]6=a
</A(?dZGHLF1Bc6^Z9dI\4(Af=^M6B3NBHQ414GFfQO;8,5IHTb@74-@OAGf]397U$
`endprotected


//vcs_vip_protect
`protected
E.Gc]-a+X:g/9U[[6,X2F0V@+X0>bF[5O)_/e>^a?dO<AbdA)(#--(UGg7X6Z@#e
(.,O?,H2U3F<4/&d=1:@+K7W+X<H+bABK?SSb2AZDR,38<[HUWg1G6)N,;)23:@Q
:7@X,8/4])Z.6+JG3T?;9;Y3A+JOD1eE=FNdO2Of?],_F_:6/#6Z&.d+#=O:Q#Z?
<<<Z?S#KPa@<aHg1W:Rg<EO8Z=Q1]+.Z6RN45-(=S\=&].+aD;9;[8K(7>bRM#CF
<\GC>(ZXGMMMI_LF8Ea#M77&)?;];W:aPE7Y+QU2WA5C1BG#)Z8<+c\<+#d?f?cY
,Mg:Q(^:JLT#;Z^b.[C,TXHg4:257db:Z__N=1(<Y4M^1/a,5TH#>U:0+GJf+TfW
(QBR[(7RCF8G7CRL6g[cDK[]4);=IB,FEO\&-efL(WV5?7THBg;XdXcYK3bWOH[[
cS)9b-QJ_A+W<S6TNbc5[>WT<^WE@.<9caJI:eW4))J6@A>FVUO]<4/G9S\KSe7D
7#Y+f,B;YU?M&)RA+G,Od+LVcfM]\NSKZ(XWVLC4QK+@6e.JFW0JM#aFZG@6,#)g
8:a5F^7cFGb<;(e7@=H:K=2QO[,Z_FNe<C^dXR)0]EBGIL&b>4^/=E,97<JV59[6
@AdXbgDOS,O]NRQ0O]X+UJQ1GFVREBd(4/PKBeG]RgMA1GFWYJ,;AC2eN?5-<H2)
K3)O?54:=ZGCA/O939d_?:A+8<AZ;fOZD3K<=eH5Ma#Zd9gaVa@<W[Z6W_SV04@;
;&1\:&d0-UT(YR1#NRM6T93;UC9G9O3K53eSdVM3==[-MI<<Ga9\g=?VKS,8VKKQ
VcM,3X>LcSA_V?Y[\X_eGRFY9)I^a4XDc7_DFg5cV#_J_,,+3OT7S_b-cIFa&e@&
L@=(#84EP>[(^GL5QKBgI&=<[(X]Y8M3dJO2^MdQaaUAfZ]E>(E,E[7#ZIM]L;D8
8W=M:>6:VM(3D:(&6geJ.8f8TU=UfO<f2eAA1CZ^<7POA@CJSJ[2LGgGLO^_BC22
O+UAF8beZWW^K/)]HR#_:G1UB77^bO#[,)>7/?:P46NS[L[E&V_JZ9e5>(I6X-.6
+_I3(M65VRD^6e6[f:P_EQ4d(6N+@J-DH\(T^71=V/L(ZNf7/#TOBPE(&H.ae4IC
+KcM./E_OFGdP15^)Xa2#579D#c@J86b/IgY#:X?EHX[DDOR+H2@C6J-34O9>+W.
Egc&+Cd3RJ?\\^Xd1#=HE@-PDFMO:B;[QO09g=3@B=cI_e@[S2-Cg@Ba,dDLaL^H
C#N\X8(6IZLAXf6f951eB,0O;:.[]EK-McPGEI)+XEL7(g[4VB?IZ3SVW4EKDGLH
KSQHA<N_=7S,df,<G8@7A&663[MZY?;BVP4V8c(=5-@3011cYLCY>(O^_5<W?]I0
M4QYOB[1JMRQT^[W7.],1K?T+bdfCcE3AI8C&fX#042?fc08Hfa?&.+J+,K&e&G]
6dBd>T1Ca8VW)UY#Z3&NL=b1f39B^#;PgA9cT)J]FgHH&XC6@0XW#FB(DLX=JRD2
B:XeF?AR(\.b+.aZZG7]e\:gYSYgQL;H3O3YFQL3MKH5B&P:41;1SZc::+Tc=9K5
\dbXf/^Xa&UO/LdaTU9B4DK+Q[bd&UW@LBDQ=[9(gc?3R^JFefAdZV.]3VfcTf>6
7\X[3-)OS;4fO&^KZ8P.C]gV2_]#SaHbTI3-:OSQGF4<a5M4SefUc?aD3X+Q#(4F
)M34#>R><?3J:6;IJK7&P(_@IEdBA#_<T\a0JG<0Q5P<5O(bD@/2#Wca;8#JM(#;
,_9M9\G#7;J@J7I+V9=N(K7c<:bfD:+VaKH\,DPVU#L#M,64Ta-?IJ0d3Te101^0
)Q#KJ?a#/gOU@B84&(G&\FMc)/Gd@f2#2-EZ(?XfJ\7L8.(\-@XA<&(:M#S03#0H
4YT2J_UN8bQSPJ>J#4<-C(P&4Gf,]WYde+6EKeO.bAZ^9I(<Z3),E/YD3fJ>#;Fd
#+gM_[E^P#O>b-<FXXc)8TXBHR:Z;C9MVbfL42(32LJ<)12\dOG(:YV71>AWc?3X
W@<P#.QT^S56@Oc^I,G[6((-1AB_@S&QK[c>0OV,G4Wa9=]1JL68F3b65BX:-TJg
#A^E1MR<a>QKDgV(Y#E8MeTbC9&:S4Y8H(efd_92NUTI=e,1ZT&81#;K9H-C_/dA
()XAg^T;[(STY=JXDS=E1PSDQU#U0aC2>J-&93dRe]S&NGBNXJS>g+9b6g1<6faG
Y\JP(D1g&,XOb4?f#S\b>WHGL#B17&B(RLJ?IFIH#1RgO28VJIdg-<-6[\M1a6=D
2YB>F8VW+(KcTO=7XRHVE9V+DMId)T_4E/DE2Ja9b3;a&2&BA)N_/0c_MFU8TILG
,Ufe=-Id6YRJV5)WGb8Me<Tf]G,P:/6f7aPJg6A:R(JX.VJ,,H;IXO)@>f8J>99C
<AdF1K,SSJ2ZMWETeFA>egCB+).,&=FH-@P/3<N1P)#cfKF^6K:WR(G4@^6T6,_R
60F7D30cd+O_;A4N\NIfY8[/#Q-JMZbJI;3_C9]JL.K8ORWV0B#\NGI#>ffgLA6C
1Xe1?2>A70Ae36P<XQ]U?P8/T[U.DcX3&VCNELVb@6#I\DAdR/B(CR^[NOY.bPHT
f8L>B\XQ,KV#:Za_K,E/Sa_)c[R+\cY\=<F,cA\8&[:.\./d@c>)BA5P.=VaWeS9
N\(3N(Z,D9<(B2OP-@;M7UG#a(]=H@IZ&UaH,4^2S4E/(a0HE?I8#:aSOD7KEeF\
=E<WP<a6WC<;\0/S5AW0C+X661H&S.?<[eK65,T=Z=d#FHSdN2-AT-D-30P5,^Z-
))J@dU,\Bc[=/5-JcNT.[CT8/)bVMM:/bH61>B@NYUaR9J#_[<..J3ID7WDNO./C
\9(0P]SHF7WA#g0)38Y#C]g?EWY>3O6K]R#P1/fRF2FQ+AeQV^fC6?4EV)XHYQ6;
A#<-M3L&_C)JFP4_#^BSUM@4TU3/?Q>XH9J74=Hc^Z@:/I]?d+)YO.^?/(MVg8\+
72a)S#Le9QETIOaW1Y5bK:5UZ6G\^T-?b,.g392H0cEA@GXJ;;g5CgO([ML&&(_S
2H>T?@:?0gM\CbH6CH:/M?XK.FdKD/Fd\+@7]6L#MK6;[W-\-ZJO5\R?U&W=](ZL
[T+3GZd(eSR5eH=E.=HXdEH3g#^0WGID.S:Y21V]+BgC<09/Z.3^<T<M)IP=X?^O
IM6MaZeW;_4:C8664>X57Y,DW7<0&Af[P.-Y=Gf7WbXEYH&9NCCK<PLBRE&La@(9
?1_4<<6+W&Cb+d_EdH_6_EQT5;YE[LXWD&W^KbA(B^76588(JC:RcP=.);<2VY7L
H;X/?Wd)@_0a/=9/Zce;Rb>DA_D\NGW+Z&Xe10;&OSU-FG+VgZgcWcSMFgQ,^fb:
1(TVM^bgLX9P,?KNY))0_X#MAUJcML[0)<M&M1RIbb)e@0KZP<,3&APc/<=I8/b5
gaL^^7G6?3Cg(#7BW>G^M3OEYQ8&RAd6&F(3I/QKe[-LQ@-b@C6f4HbMG>H8XFCT
W-0c6F)5dg9AV-P<ZM_.R5Q(^XG4#VY8aSO_b)25T&AT:X5:K()@WEI/cHQgDZb<
[[fRJa=>@#.B<0&]b@</]#4(JO+7+=5^OP7IQdT.bL#6Y?B,.KJ<<;b7NDGd6d8L
0Z;TSUeUEP3EKU8[Fe#g8,)JM.3M/&(NS+W_3)aa0I1PabM:(c[YO,8?/THecQ:>
9[R-]R5C)09@PN]Y/QC39EXY]/f#<7R?cJ[TE7<Hd<88g\C,Sa[NaZ)P8G7,S,^6
3GRF(7AR(#ZB+?JVS<H,#/6<B=5UO5,ZRcM40TPD^.ad65C=bTUM#@@QfP[EbYLZ
FXdZH<aMBQa13MK_/AgR>B7d.#_6\:(HZ>9P2,([Z8;;8fM1K-2_@2,_9[f/Q?W.
6Y0X^G0-74+:F7)X\3PJ=,3PAY4Q7dGNBfC/_76GQ<-PMRP,g,^7UA4cVG-U6Q&X
J[Z)V;Y?BXP[]YM[L;&M;@a]>#\a&Y3,T&YTdDdTZF#WBK6a_(a+@?-edKH#I34^
G:X7,4+E;:f-AZ8FOQTWY3@FC]=:V@)=8dYQa7;?W[d@^MATS[AEO:]/(Y.2;,9&
^15YYfRc7#,5.IHQQTRc_)T@,fX;Q)R9>9cdb;^4[:Vf(-9S=6FWJOMaLSD4(49&
^/#L299)2QB1T2C1W\g/0a3M8274^,6[@G)+B^#f[M@7_GV.H,,Ed-g8QJ_&D<2,
=R;Z4U^1QRU\G8>B1[RE/DAYP88?;9?J98>Z/32?+DA&V4)b0G.fEWFF&_9=KI2J
8T^9.9/#,<L+?/F\K[(W1J0D6K/GP(MJ#,WF2gA0H]Nb;)@c[BTdKQ?2DQVS>V<]
:@HE+80)Z6/^):cFSYgJE.P-QPR\;0;9\;F7UCB<N3H[9QD]>C^KAgK2+,X,YU^.
)+=IfC03<AS4VQ.?NHc[O,75KE8Xb)-:3.<DFQHE^-19P0?^/Y[E=AaS90aBCNKC
8T]9IS:/^<3b^Z(T<0QE/3e?LNJ7D82g,B+XLZ\Dg0LP,[N+1@IO/Vg9W5.L@X,[
/5M6@ff]N;e8N_O9/,#.>@<SLQ+[H9,>YXR(&faS4L?dgOIB-E=S#6K9H@/:+=If
)@X(4?@;IGf7J;3CA2I=X2E5d</PgR.HA>f5PZ]&J^]]A3b,gJ4cf=5?;\&V+02@
.;Sg>Y3L[<[NJEb;<#_c=S;5OaG3/H=_8J>LOT;Z;]=;@Zb+]Ad.ER,Jc(?Nc3Gg
bb,.a@);3d(5T<V0(]N&4;(F0U6C>^R)HcS+0OEaYaYQ85CRAbU><O2,FG+5;O<F
=Id25dSUAHgJ.^,5?)QK^C2SeTVJ>F0/W7,8J/>6QB\5Z;VV?^Y_#d(AUZO\UD4A
?=50AB+F3)^5gS?G799(//KIE+S4aXe^EAE&_0+XH,7P6]<6PDe@IJ:H3PB@;[RU
:ASR_^5(/FGLJI+a2F/e^.;+Md)A16YJRR7E6R-Q_+7DUc6G;J7[P@]3M\UD7=ST
1HcV>g-Qe[g(gE#L\N#OBgb5K\(#V7E&NZ;1-=6bI/2Z1CKW403DEVS0EWH-9S>c
CTJ>4PF3eM[[7F)g[F4>9);X0,(1fPHZ^VY+.RT6-/;a\]]Icb@M,KZ1.QE5=NI\
R[MUJDTD2#E+DaScCUP#LDWSU2K+(&\X<TM3H10;g(N35>D\>/<P73A2]932cGX+
f4J-<H=O5ONScFQB>1OK#J(#LK@(dTEHLJ#6dM?_ge>Sa=(E[SXVD<Y;;[)eT\18
,VSJ<b(KUAQ_I8aV8(AW(12@Y4UTYH57SeQ,E[:<@9.V.]W:7&R-bTTPf8#,:Q4.
I@:HSZG:9FgS@4Z(47UTcM9V1-Kc\F9:XP[aF@VQ&(9IQ(6PTU1T_+R5,U]SQN):
(4D+Q(Qg=G+1Rd^\b+4E];Y?+.ZP(79dCdB_K__?ZCfeA-M_16LNKfK].@/fA5]@
7E,PgDfXdd=1:II^.<@CGc-W4,+.=:<#AR&Ud-\X?5>_babK]CH&HA:RU4V^)(e]
5J0X4e>\PXB<2-Ud[RE1CGF<:1,NK(EGZ(e;TgdJB_aXP-#&J:TPMOT>>4;0B\3#
;DK@HBUWJ2&6WZO/Gg7b(F\NWH,VMaV.B@0^(=^F.W:)O0LK\CBbLFBbAX08=BaY
&&WaZH(:RY8M)T>LSFg>+)Q5H9856>:\N>Y>_5=:;[U-23R</38X5H2MVH+.D[aR
7J;e/I_eb]M2&VbH]RADSX(VRE,BR,FYXH1AI-T#QX5I--Me5\S.#3L-TY(.^YCg
=JUV#J,fR0,YBaTaP6cZg1H)#dH2aJ+P?6?WIUF^e\@5PKJU<62FUH.<U/QG@^ZS
\6D1cI>JWV=3c&I159cd\_BU,]Te@<]NDWc^_-7<C#>RM8Vc9fNP]E+5SUBN0bIN
O/JE2)]/AFf5KC7PRD4AfK&S0+Z@;7S/X&f,CccMXfUJgOL^;f-GAD^IK2A/573H
c^.N^_9B^.bD[&-QCELTU1A06X5HSgL2(>(RB6PUK48D-9,?.DIad)5b,8#D9=R&
4R7R#M_R25XWB3=c27ET5=QAT+aH^<_/KFU2[EW;[#7W13-(E<EeeI^-@D6XO5g/
[;U,MBgYL<L35)bN>:J3]C.9(^LLNWBN@D13EQ7OX.M2YcOde_#SBH-VJIPYIL=F
g:[5[QaJC+&,V;P>0)<13e2+#NHHfH,]Gg&H3CIJJgPL2;b(BbDg0DDL>J.6eE/,
DH^8QTO7?X@0DJ5Z]D+9eM3NEEe>IH<eC5KJH+@b^dfY@58((AC^aS[#J<;45QWE
J@RY\WPRH4c7;CWO9-P4UQfYaLU#3:2N+GA:9:DdZc70]LLH?MeJ74[-EDgA@4?V
g#f8F3(Yd&dDcLKI_fe@DT8f.FfLG643fe+KZ3e_fF2Y/W;3Pf#;F[F@Z+Z=KBO#
LIJERJ:)dI_Jc04Q^@_H:(2;2MQ:(C;Kc11cK1KPfc/4-b.NTCfcDc>KL@U1S:V>
)=3]7UcVf-S71G#;Q2Rb=L1J(.2UH6HGfJLWY[,^X>E.f-1dM2E;X9BZ.,HaK4<<
f/MN]6YD^?@YS+\L>N\)>eLN0E;0DU]a8&=6VO;#\I8eLYHaU2Y1.7I+BN,/VKY7
+@fQ7QVTH66-ZZZcaTVD.=aFL[M130Jg_MEMMK2D7ZKAd>L^M=_g-,+TfJ1W;f;c
6:b.d:GO7I);f/D4^c[]^&.ARD-QD7Xd>YY,d.0EV^ZKFCQ(e38gTgV#,8TBa6-S
U;9(JfZaJ[RbFZE45[6)d-8-0QT)?OW)9-8,<__7<,48E_353@c0AGe/P)/0W\D.
N_-AWXG1&KRI36]\A_[M3Q#g\b8@KUAY^Ka7UdYgS-bc@1Y1W=3YbNa\QVgLb4;]
]4SZJ[+Q^4>e^2^@3IbHL?>>0b)48IgE1b\KPX,8gII#U:3-:P-aR=bO6VBRQ=0;
WP/NN:4_X)I::X)ZT_W^TNd]=4CPR;,YdP<9A0Jb[]JCBW/R#-GH/(&LER]YZU)C
^]_U5D+8@5L3CH^(FB1FBefbeJ<;431Z4ag[B\>ED],@GCK>FTC>:8Od#U])^1,[
>3)d]GMObWc5QHKe_Z6eGS7G8d9AaYX,I-IZ&ZC(P@GZ_0\U#-<0Yf6>7A>-X4MY
g+4]B-?:@(Bec?2M_5e-A,4:BW+BgCW^(GHU-d&24<O0HT.L0L;eH<CI^RC(@Y)[
G)A,;)eW=SgPAF,X-N#@_8Rg<D:=VbEY(S63#&UU9MQ1(W>Q;?a(7L^(bQQa<a9d
BA120O)@@>W.SM??,6HP>;CX[--.S9]HTPL:W5A/bgU<H3E9:c/_gdYd&3/A:e:)
Jf[B;K0ce+#FXI[@2QW\DWa9V9>?K/@_SeUcd:[A./]O6HLL].0bI650T#[B3-S\
W5g)PRVB1YV7/?<P/8P/+17,gadA\XW>@M0.[<c-+#6DJ.GG06(4L+TV;EA]?Pa?
FS2GZ+0FL+YTd1K[[8Dg:d<9d_JN_OM8Y0R8cB0BTa<d,<IF3d9KC(<+g6;/)@E;
#6?./^,;J0YdD1XR##<EN&4]?AD)VM_V;<#:[7G=P#KN><SgW([3I>eNB2LPA(VC
0NdXVeFIV;:g>EQI#cJ#dUF>H=\<gU4Id&-2a?aXC0J&+Kg09)]0d-g7;7;]>6FL
BE(F0.\(Z@:<.S^3gM+KK<EQX5f6;.M^4b&37?M4CaQMIOTGW&W;_+C3ER#C>JJX
_:WP^9:4/&dSP<<Q2G=ZO^#OE-5e[daaRX,[,RPSU980\Y,aE?H]\&NB&:gd_@LB
4,JE27Z4706O[?R;ARW5,:Hg2A3RYYH1J7fC>XA>a_,>]70F_/.?45KBZcF,5fII
H)eYIRAZEIGdMg<H.5+W_2a;X9I,R-PP1\,38GI4K30\OE&6VWb^&QB22FZO6GI0
KX/Ec\DXCS6a&#]#>1ZPV-dG3XQRE2:-H/),\;TaC([MDA<-0;@BH[:,e5LJNDCK
XcIgaT3d]\\c6?,^BDfTM6;[f/:OcB3<;MaB0MAGW=4Z/AG0[/?/L02,B))FV><J
P9Vf+^EIU3L>FO\U(7\Se54b0D<W#ODD+gUcGZ>dWPFNN0#051_R=C:c?g<^9<Qf
Gd\>(9]95+M2<eIPBDA:M1Ne.KP,5,N6UHF9YPHG@D0XRfeFX:?NM2,&3;QWbXO.
T?_8a62K].2G0Ia5=#1=IM)83@d+g#>1FIJU:8=@4L@;.M3&]=<1Hg-J(bU0O+=<
=EG>(IMUYcO)PI1gBMD3:-DGX#RIW-)DOAbLbLa:_T<<1B?Z))NTR(@93[MFfF&K
TPPWeH^.T3-YWI=AFS9V(OI?0JFR1_8gC?MD#L)#CK2afE@#.T^EV:JL_F1M1^NY
FJCH1NO&TG#5.O<36.(ON0^INEO)5#)9O..P1X\TKbHaeZR2F4JMAP-a_,TG^CYf
]M;6[6g)E.ADKCQKeO4[VeL/L9E:GQ\NHGJYaU/\H&X@R@34-(J8;=,XaRIZU3F#
,N\Z,O8.T0VC1R<dRSe@1[R>Rd\^FMCcQ-5g)I=[E@+\Y_+J0>Q5VTbR\fg5(>N[
I@S]7,cF(&(NVNTC_7f)Y(FFTdPEBcea0Q6>\,/6&OX#6W4(gOe#a=Zb6T<GDS#I
6P_b@SW9_.905P3VaWF@7S+WN7Ce_F1Jg/:f)Y\O<aEeC.:_\CdJ,=^B-^XQcQ_P
bOL/eNU</5W\CZXDM_MNc2/OE(g59,C_eGC:a0eDNY=^B>CAMb<a,Ug[0PV70SXI
[FR3B6[(#IKIXCJeEIL^S?Na]8Y[Y4Ee:cP/^dbb;J3\=&b@F3[c/N17</GC5]:5
>A5AOd]_VWf6A[RO,@CIca+=cWRcR+66b2X+^Z--#@K[TK2Re&0@JV,F)3dE63F\
DEd_e[5?W;K@NP1SN<Y>E<<C1@,LX?G^A/U+M,fWM/GUb<@/STWNG,Yg.E7-IOI_
@:.2>9SLadV5M4-3<\+0UTL4R5?fb,>3g-/eJ<H]DGZ1XF2(J9QBTW9F<XSV098S
,P=EgGL(YK3[0BC3+e?.]Tbe8;@?WT[5-agO-J,BdUY)CFD,[Z^<=>;TUP2.@9&0
ZE_cJP,X)PSS15g:gI3>NZcE?).7/T(S=5]_;M.+RfPLO504C#=NdaIPR2F6.]>0
e6I?66gE:[GOV\eF2T74E3b4J(b>QJMMc>:YUJ;8._c#H]Z+7b_DABF2fgV0/NAZ
QaYH#e),D>2K&gJQ\7(CYa=gaH>JX;CWM8W/31EN99P]0eI[52PFP=6S-([QVN#=
7dHd>,T\H0=DQ7Bg@.Pd:GDO&OeeS2NT&A&A&g2W1+-e<N/G_;:FC(a=_fT_]Ne#
(-=][)YHT1]_EPcbPR2D9AOAQ(1A&J,]<HRV-2\I]EcOQTQK.d=a+Bd&XUU<(0:>
CcT[_;?XBc(O[ESZB+Y@-:8WEE.Y#bBADC_7MWWUbM?M#(B+0X^G-;-TaT[N]=Z0
70FWUA,cFN,YNaYS#5ZI9&Z;Y]7F=[XZ&Z=4]LP17MEQC0)G3cKGJL[LTZ8#f328
?W\M]JYH7-fKP5cK=e-f6TUKC^W#9ALEOEK==0^-/@&/I2b[(M2NS[Bd[9(aWBB-
[E>NJPI.VVH,#OWbFbCdZI>(^IY8#94+K)GD(2C]8.=T;Ia4A717[5XDJcT]HBSG
E,1D[#1DL_eBd/gJ704Ia8\EIG/19eO+N/J;W-L);eOAW.F/MDGT[I0^A8bVBN>5
H+,H)R/6:)HI3SW3<;PHS[K?4MOfMVNQB^?P_;L5)dAZ:+La@b.PYPK3U&MMQ.dY
f3(Zg9-?A+_aRZ)g4XJ0gUL-9aX^T>@5B6\IVE_4LdQ)?94,N]NOXW0e=,bU<2>Z
G^0:.ZM;R4g?&<E-34&2U=3U_(0@SZR0O[2(g@+OLb>:aeSb9Yc?90#S(=/BPKBV
^O@O/>FN](IJ:8YR-5_]cWbU0PfY2G5Wg/#[A[37OLgGBa/:V6+[IHca-JeSAZ2G
cH+L2I,9=88DdR^@Og#>J-]JIb03N[\U5,b,.</aWQ/f)T?.--3Y\+W))<&[4JUc
Z,a--#NYZ.CCf>^<;32CHZTFQSGA.(E\Q)O_@J0_9DKH;D-dN1_VBC?f/60:Kb>8
75NCe.G^>XC.H:g8=6+?I=C)<=b:>8:50Y7()a_8d\bPeAH7UNUU#U#W4fH/cZ\.
8&3XMUT^YW:(J[6I@A@Y<J0gW-ZDEQO5+Q]12&-dF,7M[Qf/,Uc6_JX\dNKE\)(H
A<=86;Z[(+eQ.#1FdgGL/)+0E9<XgZaKb\>N?ZL7W<?fgggHM&Q@,OMHV7AAP@(L
8@&A33/4G1gU<^Z^W<AgFWAFXbb-=.M:?HCZMdK;(1(4;9F,.+9TSZ0_^)/+48W0
H.[3NFQSK<)aVFb7FMA_NTN[G01_3,UQ#H-X5b?G9B3@2(XOT4)=LE=9JV4>QV/F
TSH;fH5Za#&?b9[@R1?+7X]#;<Gaf;S_^1]ga0g[^HHHP44PdBGVM4eH2J5(-4fa
=WH1WR0ZPcK7WIC,Z2<,b4(2H:YC].YR[aMEdZE]f^N/RGJd^5)\NV-^OOJX@F5#
We(@eX-YLe8E.B=<E8/P\85Q>)A>&a;UWK?+4H[#LB;/WCG<3QKM+V?;-GOVbQ2Y
dH>)6T@;>P;RYS<(/,F8g&A?M[W3-]GI(@O\FKXZ1eN&@C<.28#40g@_AaVR]bM.
Q;VAZ]JIR]R0;Wb_=[6V5C06+X]WN3U?_>A2g_,&5&W?5Pde3acf&B4eRDa?J\0G
\^FWGg5E<>W5,&8U,=C==)Ja7LVQdL_?<Q/@>gSCC8._KD[-a02)RAPfYbgBA3QS
URcX\:V?4(#A-[FIW+J^-W4W62^Gfb^c,C]M.+4:3CN>^958.K.g.ZeH,g8,291]
d@<:4E;V/Y;bgUB3P,PPG.>S;(K+5EZ-[)WJ&SJ01_J\18[U^H;GS3MV8aA0/VZI
2E1d357cC3;0Y=4a1G24_IcB+4#XHgM,QF(&T[dLPHH#IXa9F&H-0K0>.GV)(g9]
(;_]NE)1-F4ISf9O\26Z3D_I?V&1E8,HEY=83_D/^cTMQA9Q>,/QVdaFTG]g.&F3
X@Z6_?FV,HH[,(faZ[Bbb96/+20E,1G;Z9R4G?Bf@CE9T-3d>JD+X>ODO<H@:MTJ
Hge1M3WR>DL=eOc)Q67?_f>aS4;,aZ#5\S?:GV<W\6G/O&:DQ1F]#_5LZF,O]H[@
LJ3.9#H7f=;BWHY_gOLSS2=_=RL[?2@H(@e&91R8(XLRG6L5?:N?U[OF.=_.a-U<
T.Q)=gJ[J,(SE<=RJ+-JYYK+>U)3XZ@B\3>c[WUGgHb_O\VK66MO_N5YX/-3-+@]
,dJ1JRcCX&54]_/N0TGcO]g3>-[fPOQL9^P;4MGWB#(,a1=>64bDg:.AQNWIA,.0
+7Y,Y3Ec\(Y28:0Z-UJ>f=W=7Y3bVd7M@e>IRCCI@fFXgR_0)Mee/>f3e:K0c,.S
Y4W(;8R^Zb3WEaFZL=(<d&CVC2S8J@<</4X94&YAU;ZB324+.I+Ve9LPbXFM=NE5
A3[NQ3DE7gYWHb^18T#AW:MU\(9,9G:c\(>PG&M1:_XARXF0O69Q>V7F53-dHIa\
I@S2>NNHB4Ab;MMd^:U?ULSHIM2WD5IK_][>2B9AE&KB-+>7&DY<TO(9B^Z\LSNW
2JTcc>C\TY+R>9+EXLAQ#.<G\\O/#7C5_HAU>.UAH/@#]STB0NZM/?fL.QQ,b^J4
cG,?@:;Tc3D>W5RaKcHb-/gZe^>Dg<egM,/\^75.b9W#,UJQV/ETLJL(JWTO;LW\
TEI_/=/BY8\INb(+GV9J01@[3d00;;UTWdZOF0QE7HS</0X,Rf2c?<?:Y(K3Y84L
:1MKC&S2L(6b/J(_&R(cDRR?S(VI5AJ?1?)AdY6<55[2HWG)b\9G)>OU2ZR\g[DY
cD9]QfLZ3.3GZ^2c7O\Z,a>?LdBUFX@0F4Z5.X=]ObVM@+)F(HDF>6F1_\c#[GV+
<4^4O3@F=[F##b()F)7cZf;4D5e9Z=XRdL4\/7cCQV9/,-9@/ffU0K__+cd#_+ef
?bc1:V^I/S@U8&U0OEDSOO>/(UF#?Ze0?TXSZT-dL#J:4c8AVaL?(Y6C]_1fNb+4
9SgF9L0AR,VUXE2@0,5@ZaLM#=.RQ#De):C#A&):FfX.+9V?CLca(2c]a(_ZYW?S
EVdU,K10aB)a.L-QN2&dC;M[Y-HAJ765c6T>&?1cO\6&S[<#=/TY#aH>4,&:L,9-
A>U)3b01b[8NA6.a:,+ZQ17U>eSA:]<4Ng:J,+fT,J9eF]F>abg##S4QabWC[MT=
=gP(T;Z;8;dW9-?Xe4:&\RZdNVR:dT@?fQHIQ9<.)4=PU_RL=SZ)b>JW?#=[(]#A
Z;7&G:V[0B(O>9c.Y?/+O2YXaMXD-,CX]A7/@-WUBFSCa_TD\TGMONZQ-8/Z^b)V
?F+AIF]2L4,/VA8XPG+7bX:AF+g>eV@<)/FX#CAU8-Pd\PM&D(/^>a6egQ6_f0Wc
(\cF_,[g:/2(->a2JPa_/Z;GS,FKf/aEY,aGK<+bDC)bG]>3\1T^W_aX\#=:eY;D
0a4,[+#/<<=6DS9C^WUN-4VFEFL+M6KUFH7=44;N3JBRL.,W9^.Wc9)NIQ1dI?S,
Ma/9&>dCc<eTa<8>QQC6=J+?7^_.DD:Rc[fa6,SQbYdSNRE<HWDUGO30e,)D8Ifg
g:W)BIR0M03L-DEH1JU8^5eV]g502\a^<fEXR1cf,PN1VVGW97[W>fWc7H5@M-N&
^>;>.2dJZT6PC#WP4(M-P>\<Q>BZUJ+;VL^&4@K:0;Y(GIK2@QVGb^WJL7@Y1+8R
L\g=P)G-ZD;)/KPADTDS.cO3UD>Gf/RT3H>AOQZ_72S-&&83>]a2H7#OI26^@.bO
EOT8-UX94W\1A)b>+\FJO>[MOE8Ob>#K.^?<LNe9_@27cAe88UfSAdTDR&Ic)?fU
=-=gg+g@0R20&N^c>6@_gC3[AXT^\X5G0KMGaC];)RFQA@/N+304.6PI_L_FEe=3
fE6W;;A\g8Y\^_S0B?V0W>U7IR+.dd6TIBD\-gLA-7SN^?562\Vg?CP7YZT#+_Vb
^8.V/WI#c1#1T_Q67U>UfdP?#.Y4>bZ2MZ,f1a/4T5A1SdGO;>Q(<Y.+2NCM)B-?
[CHN0g\D.\4f7\004HZ#Rc42fF<Y&H6HJL-bVVCUBOZe:G;NECK;770);PS[Xa.d
b^;L=cX2&VfbBW+D/R0Q(7>7bMZG0=WRNN0<MEe=M-Y[G=MB6X2/YD&cWK=9:E2_
Z(/5?[7L(^\=&A,\EP&7/UP951<G671??\E@T6FcFL,VK63RDMIZPZSCc6^66W#P
[9)KT=3H=DL0(:@D]&KX@QedObFC,WA>:P@[cY6M+WDXYV4)C^&e?<,eX8^]LG+)
a.S_F/=^IDZ7[SHW6J&?e?N-Ydb45-X@=Zcdf6I-H=#L9OgB<_<?WO:O?dbH@53g
ScP6433K^\g?2/ZG11&NG_M[eEg_:LWYC#HYc.OQ;eC,b=8gD6R@B6,/_I^cVK,,
L+L5#PW^<Q@UX]1cF:KIQP3?QbU,,11HTXLDbPIc/75/ZUU\JY2J<M1g\K;(U86c
HHN?_S2f[BF=SgO1Jc:\2BQQ4g\=B?&M\DS8FB6.=g;1),P]6)KG4T\87/YB,K?A
=3I<W]&<Z5OdH,IgaXP/)d5R.0@2fGc&IS]K(XZ<=2ZZ8V/.+2ZJ??FK7J&V#\8X
:6<?_))#97?J)/I>Bg//2GOYSHZLBPN1Mffe(EMB[\0Y8dEf+cUAO[)>N7YI+7Y;
Y7+41?f\_V@X(T]gg+]8<Z7C0bA53OS@OEB1PALE#(C+eDfJY+,?XUXaZT6G+=0C
\SKb[^H-dDY46&WbOC_A0_EP8JZX69fa4324Q_(5),_<gE)MYW=D,EX-^&+fI3[d
WTILFg4,^#fWSIb5[1cA.Ha_WAXLFNM,ZCS7WEHP;[-=cGb4FO>Q)/+1KAd[S/^B
7(HX:T<5(&E.Ag__7,e:@]V=E+>110C5CXC[LH1>WA,EUT+U-,;;)7=^ER4EP.XC
4BZ&<#8\5IBf=]2ONL8#5VCbT?F1MEY(55D93\);]T#cN.JBM<-16\7QP^/-RMJT
GV=8a5GKeQY+MgI_684&_BJYgC7f/K&#4\OQ^cOH.aPO;<)X,4db5^DTRJBg;.>=
(bU;aaA?3R>0--L-3G33Y+cGf2E8[;](TM>JYPV.,;<#d2V6GYQg+2[6=&&b\:^7
Sc1OYCC[_GESHY<bA\_2Q/8^XY](I<fRR/&\LY\7:@0=K2f#)d1Ae^5,?O;+5JAW
gO]5ZVgNX,W\#cZZX+@^7Y:1KGD#=8?ZXDSTF7-Sg0V;9cDZ6)]+&>U.2^gKD,@>
Q&F=NL(c8N<1Oa?&P[?^RK<<VU]]DfEDd&-+CRWODG8+<CE4be4(]O2CC;829RRW
5[1X3NJT&/L/:P,;U[KGBQ/_g)U1FcXX#4^W;RBQ#U&,HI]/OdgF_=<5ZPO1(>e;
WS86O#LLP=55\WVe^HPQT,>YEcc963MaJOF7]Q>INCa;Zd7T^+8c(UA2G4>gH=./
/B[RNUY&BRA:?)&3\UNUSMdE0@K1O16SE]-?OEdRMb5b=OADK14R5d]cYSK/T-a[
TB=BNRLZE?>+,[R?/-&[f=_YL6bV<([@8<N1L<L<;L/?^YU#_JF)E+K8DdgV1?D_
/I:Z:.C)UYV#5-4bf[A\bRdKR>]?O-HdX+Z]:NJ.>1I>D\RZRN@_8PbK)dA1PR;B
A3a6MYJdP]6@149EWX@IF??33W48].5MHYbg6&R)V)SEBCME5IZDa(gEN4>-G0<)
S60CG<GQVDO:ES<38T(YSe)T&;&=fY0F2/fM(GAN3=&&<20LUP6cF,b_&4KTEY\:
PW<MJNd(2)ePNJ^[,VILVWTd#UDeWG87A3ZKFU8A-XEKC.7^DO\Zg)&F__HM^Z@[
=@[82#5AHH-\dWI=??U&]E)9PU2L/]\==KQd;RdgZ)CZ8d/]6,WD&AVVQ.@2HO[>
[1)aLBY8U]B.-SJ7AeC/DYEZ9-.K(P7]V3;LX-P:K_DM[>0N-_>aD)I.d#;A4>)J
>>NU-V[<MJ,TN[E45[+@/05A6:()Q.1XM<J6=KSZ.XNI<_Oa(QWAPLM(/X89.BdM
BHa.F;GH@U9JT[VL=UbM;S&b=cN.A(A=;-.CB5X&<b46=eQ5-0GgIbVMDX^>T_S7
MP[B27g&L,CA9UZ@D383Q^MHBYa>176.6A^]P=1+CHWS).da9S:<?C3R8b?>(TFd
WNPR(0gHJP7fa&DMSQC=XW]bD#+Ac>eTaBEW_XA=6#7V[,V].\IKa1ZMb,Df0\VT
<RV0M1D]=<9L^J2^31G=[5\L4e_b9LbQ7LEB[8fV,:ZH4/U0RLc9,d-<MA977d<#
K\@E46>c/^2OJ.dO[]XRB0@4AFIg^0Pb)XK0-.Y+9BRZ48e==aD,^+L=5P40gT#g
3FA##+\.fKRLEdL?N(-@;>YR@#@g39:/)9C3a72+_8L)g(A>R^;IPQaf-,B&CDXa
].YZL:M?>//K_SDf3Z_L4Q[Y@)-VaYO;)6)O5#F)=<@JfQE>7<D1[MGLV_>][gP^
f+\G18Uc.BfZfOdG;AMW4511&+c.0R9+U#.?UKRPUEbP5[K&-b)(KKBO\8[VN7<M
D7&^KC^58E@^aW,2fZL^1LBFA,C_\5[8eLTBWCOU#M6IVS]//SRBcOTZLQ9H;.#C
<]1HCb\MC8:><AT82e0)ZKV0]\?:NPR3BJ3&KRdM;Y>U>K6Q\:P1T=GaRU]W&EY&
G1Ed^S#.59;&H32e;AGa^44EA(D83\3OJbcM^:3Ee]&957S]A92?/:gQG+M5>_1I
;L+G-cZR+4N,N<_+;I7gXA&S4)5Mf^MD^IFGCZg/bIc8;CMLEW+X\GWSNQ^[Y8-&
&Z[148S?EXbPZ7TP;6#GZ9(:GN8dL3GU:?ZYRRc>=fg.ZHOdK2F9.1DNCF\Yd0)L
=U;f1NR,4KL-TDR?0fHAc6O3)FcC_^\QYR:[W1G(Ga^_UeLN)FM1[H6F8M>T.S1;
G1#1U(3_2BDE(5-L4:10E#6@^#RK5+DGCC,fKJ)L^8b11_#4J56e=\PK^e^[IgYd
L+AN/O+WbLMCO<>?a.3DZSM0P7JcE:1U4X5ZFRKV3=/DN.a>=aD<e-e3,5C2,#E-
Oc35#MUAKJ@GXZUEKCQA7UISH?+USCAIVTS>:=Df^W^6[_Nd9RXY+[XeR-@0;>4&
6)LA(@S1DgF_6N(]M)Xg\d&([JZST+aCR4G@D/e3VId+564LS<V]9H>3(AIE)KHd
TE)dE,eF>3L4VH0LRcCIIPEP:bL^:4(XC]G8,RLf2eAd91_1XI2HNUP67?V/L-G=
<a9e<dOF_K2-d=(U2X7&EL1#[3G2bJ3/@c2F67W5O7&?>3]:[Z?g-;KL+^VK(R&?
@^O\F])Q,H99<,R,A3R<Q]W8>=NQBQaZ,V]G>cIe3BQ)I4:JH-JS.:CL=A#>W[/W
)X,QK+5JR)e?GC9B11ZQTeQOE.7MFb?c8>M@@VaQ1K+f16.e)VR;1;>9L:)<WD+W
,O:fQB3P:d.R^Sc+3\0SRB68(WJCTMF?a7_ZYFKAZXR3@]+@Ze8OJ7E(1[3A2^6K
aRBb]6^-W_75cP^Bg29HB7.\a\P4,>;b]?&O06[R6[LQ>dN8OF_@GY@C.33P<H,G
.LL<DT(3_Uf+HL7C(XaN)fWIB3]1ccXdOR5\O0QE7TW866)IJ#N^RaW5\.MeEP=U
-PAB<ATF\QCD^T6T(KTEWcONN#X^0/VfLT9K,R4))^P><X;41NR#KR_]\-]KN2GT
D6KHNd/31eF2Cg\/IWGU4K:9]3@F8UV[d;HB?@5&5\?NUM[3g1g[/BN1M>AIKY)B
1)2c08]DU6FUUWe+_&>;2EN+N()b9(\_M4+-TVM9D?N0,/M#=0A\N@BY@FN)]S<V
c<B7X4ab.Sd/-gfW(GEdD3&/;GW8WL89@4[\O?a<,HQNT@L7P9<FO7\B2B&R2>^;
TcJI_F-1/?#MPXDDHBZ7dXR&16>[F^CBe1_@37dK)#O>f&?73(8H]bNA+J=XB@4U
X;F2_f5)JAT,dUE@_7df8&S]0Cab;eeV:V^5(,W4C3DIb24]D&SF+E1=(N0VGa3<
;OH<BRE3AKWFR>SY^?:XJTZ.L+SO>6AYcTLR3b\+@;D(4fSX_BJdgH;1JaUMG8NN
XD2Ie7AW1M7VZ5Y&5Y9GIg)=3,OX@64+=5G&L2)dAe4-Yc[Fb>B;NO>KIB^O29,@
3LMA\&(OO0DK=\bW,O5A^[/b3;<ODcPQC;]<;8X,eVVB[I3I]LB1c<fV61HbI;_C
E&0J6]ReOfWb:I;^Q:Q.V):,cO?L(-D-MdLSdP]LN#20TcV1DB?4[:A3e/.+^TeY
5B\VcC-3O52DXCMd&[eF^^9=:a2Y^<70a<AVVYcT7F.a#+R8G[g^+QQ--6^D03]<
?FC1SE<e@4\)e;gP:.\WL/@FW/WQ\2/5BAW;eD&7#L.I5Q\YPP&WDZ(W6Q)8&P58
d^@^+Z-.Q21K\7WNJXH3]gS#YSHP;;2]7\]dOYPg@1<g,1WYeQ,35-ab[c08GP:A
I2b7AIUKP-96>&E##4b[PWL6E;CgZ+Z1FGg-0Q>0EdHCT^ZW7><&@S1=LUZ8L-CP
eK1K4=[H41)?/-/U,Ba07&F^>OeV+91#EbI[4Oc0::G.TFEJaXeZ>DV;EAETP/8=
WFC<BEQd;50Ra^gb4YS?HR@B]D&D9C:WG8\<7P:UC::V.&K?88K\a3<^_Jf3D\GO
S2e@Z0(P)GJ^.cbE]W@cN4FAb,MM#,e-@H9I?b2[<7aH767W]ELP/M;C3A&=NI1J
Mb-NU4(?^LO2O;\US)A+ZAZF(]gd.;ZW;e&(fSY>NbH36P#V)C.Y[L0&V]dBEW5D
>WZ<=c[WVB()BF#(XW)d9,Y\X]4-1N6[\_&bV(Z5(WWXg-SPb^YE#MH-BJH7e<(X
_[+57T\>ab7aLF1g#H(&F,S_(^BO^NT2b[FC):8/(#S>J9#dR+88L_&e_dCKf@O7
XGf^>6C\5:gVSS(a?/XPY[KUaD.XEP)B,N:776GT)gWb5&>DR8):E)1S\U?[CTNT
Qg>(6.X<GHL#Z5D&[1#?;2\_L1?8^>(W&SbW0Y6ZV6<AAeOASKZQ9,^^/Jc)E1HV
Le.JaNIR#S=Nff+e0Od@H;NZ+N^Q#@536@9@M&).E#>D8\8)>F:H36GU^Fgf\E.<
CgO::.@Z-B[S5/ZX1AY,85fSF>gd3U]U3DNR6g>SE:E#-VTdI&BO@J.TV^:5+cdQ
TZZY<gRY/a@aLfI@2c[@c)6Y,;@74206c[(XeX2443/gXdVKN:2QMF?NJZPJDCgU
5(XKXZOVFdUHfGU4NZQC-Y;3#MAbXKU#\B;793PDHZCgJY6;R[S<PAOQeN,EHJE>
)Yd]Q:EP94b+5P,MeO0]\_K;6CVM?L3,TT.))WJ?O@K38#d;MPRHIE_^P,FfB94D
]PfC<3_\ON-#7]+dVYO77]HS#+KbPXRMIW]U;(C+N<N9Lb_3;O;455?Y@[2Bf-We
+cZ>NE@5,84&AS8<1e_WU.c.[Q.8.3P?T\O35Z<06I\5;\.UOAF-14JQ(-cAbY<_
5E5EY=dT;4U3/dVI.3gQUKd+2Z=-[UBa.S]c^\e3;+Oc,R.]02PF2d?NDb(c<.G_
e(YPXP;gH\Hf5S+\.H\IaWOCaF9JBQVE]57>c[7[(79+-S)QF&UF1K2^T+1O:^4F
0B5J44?+06I+b+:eb;@cJ[\\ged\(H77)S69Pd.QOg(eO;J4FB+BdX9(.0Y6<D\_
Ye>0fGdS79B>2+d:PS^fZcd^f.ZBMV\bK30fb\4KL2@a]@05V73?dcXFN2&^;dUG
($
`endprotected


`endif // GUARD_SVT_SPI_SERVICE_SV

