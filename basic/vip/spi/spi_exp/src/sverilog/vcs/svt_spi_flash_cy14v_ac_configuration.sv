
`ifndef GUARD_SVT_SPI_FLASH_CY14V_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_CY14V_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Cypress CY14V_family in SDR mode.
 */
class svt_spi_flash_cy14v_ac_configuration extends svt_configuration;

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
  real tSD_ns = initial_time;

  /** Data in Hold time   */
  real tHD_ns = initial_time;

  /** Output Disable time   */ 
  real tDIS_ns = initial_time;

  /** WP# Setup time   */
  real tWPS_ns = initial_time;

  /** WP# Hold time   */ 
  real tWPH_ns = initial_time;

  /** Output Disable time to drive MOSI/MISO ports to be tri-stated after this time   */ 
  real output_disable_time_ns     = initial_time;

  /** Min Output Disable time to drive MOSI/MISO ports to be tri-stated after this time   */ 
  real output_disable_time_min_ns = initial_time;

  /** Max Output Disable time to drive MOSI/MISO ports to be tri-stated after this time   */ 
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

  /** Assign refernce of spi_mem_configuration object */
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
  `svt_vmm_data_new(svt_spi_flash_cy14v_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_cy14v_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_cy14v_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_cy14v_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_cy14v_ac_configuration.
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
  `vmm_typename(svt_spi_flash_cy14v_ac_configuration)
  `vmm_class_factory(svt_spi_flash_cy14v_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
Gc(fYdA:+F;#gN7?-&C3H+fa>@c;+cU]^-0O#dWZ?4/SgeKN/07;()]W@=]2)Ha0
)T@-;)=1;\:1A.+#D2)P9AN?+Abc-7gO7:+1JR2eEfb#bA]JZK3&N?_YgEQIAaLe
A&2@g[#<V:UC#5K78T@_#&4(EVW9>^H\Gc\Q(3M@T>1/e;3cW:S#gd&&F=@DMW..
25+.Z-eSaO&Ig<b]2E(C/[b:DcDPU&]YF3#XCB+.ZR^QLMgL_.5(BWFU3AbL)be-
J6:]@)ZH+KW.4A^)S)V&\I+G@:^5g]P5UZH2gJ1Se4RJGS_B;-V+,Ea8GWd&8W?7
DHUSP]D4H&\,4ScJ\+^J4<8T(+6FK]&)(YA]cM;(QS@E0<-R2MJgb/7(EaW<b4,3
G7KFD_._X\M+DG8SPBWY8c7;>W)R]a3<=2XP,d[(c?\N;Ge)/<SbM^D,F>F+FJFW
6UJL#^D6>?0^\TF?U>9@4#2>=5-e[Qg0@JRZ0]c^2[D6.8TgeNU5M1Z_7d4KW\g0
B)(.KN@c(d4JQLAfK7F@_#2N0)A@9,TJK.@/3Z1(e2c5[AOZQVA/+E@EVD;7DaD[
=:E>2=YSYD&(6T>L(<aPB_4B60Q.D:K,aTaX82a:7N/7E?PfT?;_XC,47^dUd^+@
S;\,@QX8[Q>FI:E@)8BbFR.6:OUYBO=M)Ib/.=6;0)I9f;=c.CaC93bG,>G?#e__
O44NZ1<J=I);,O5(a_^6^]I5a#f@V<,W8T8#ALd.)=f>L=B\/(.#T7XY&aFR#\>RU$
`endprotected


//vcs_vip_protect
`protected
@1Nb>0E5\@(_3/3MM_>@1#V_Y]\-;=[#&,/V+6OOe=44a/Sb(-;3-(7B0K.X;bfF
OT:cB6I<\LG_8<?Fe;9K=7\/)@<4RaKW4N2&WTY2F\+7R\2R;:fLEZ2.f79QZV-L
D<&JZV_#8:W3.^_UNdPQGfG_8#]HCaYTE,3-aWZTNaZgF0?0V@,,g/8fY6>a:=KO
8THfO5KcA;8682R>?(I28e8@@;aV=&@WRKD4^gS5-c?dB>c-.I46bLJ10Ke7M]E>
HPZEGHKTc=_e3?<<9JXG[\aFDba/1[D[?YMUDLGNR6X<+.WTU<,1.a/#,JR[U()@
<[YX7Tea,bM06V&cgH2:<N]R;,3/P6[4=4P)&T@A2c.[O^UNR8^TNT+[FOS#]g01
>;Ab@TY\f4CI3^FY<Z(JO;V3KS)T<bbd&>WZ4b?0g](S/IGF-gB2I89(8^H_SE&M
DP>T;3D[TC,9UFA,\)5)&\LC:P]1P;HbAH9:@^5SdYdR:H=P8)Y=\bR]^W\^ZAS<
+@C\4B,QV<a_V.gII9B]P.FQQ+G71Dd4Za2-?e[4VRPcbDfe<VEA]LQ[2&6RNK<S
N&]Afd1,(bEcAZ]+PU7TL)FaTWKS7/]a;QR<MPYFO&\..\+W&bR[J#SdBS=RJ1+A
(Jc2W4[\HVA[MOHg)B#<gObTV)>0+DWV[O.1RXa/6WL7N>JGH:<[Eb.1g7LdZ?97
?ET60+4:L6+^=/C/)[].V6W7YW2(A3_Qa)J9Q_X(7Od0W-PV7_YP+f2POZDc2A6e
CJ7^eO/6LMX<JXAKK3,8AcKT@]9C]@8CbfG@8;[]U/e(,GfAeMF4aaRM7PW#f+1\
E+QS@g,)6:@)NHD6H#>XRM8=KN?X;KB]O5-K3&YgO,0RXKDIB2G77O+2_S@<>Pgd
SOV#?2)82<Lf#0B,&SK\]SN6&;aWd>RY>DfcVLIE5(f?_W-b]2X6Qa-a)1GR#8J,
3@UQf1QW+Ff?d)KfMI(7aNT3/VODCBADI.(:L^430MX=Q3\df9I6N6#B1:VJF)&@
OfMg<?0[BGQ@HcdNeRXXbBUS1NFAVTNE#aUAYB[6UZ^<RWK?gH[S#[XE)>G>(e?a
VQ/7cWJQ,[B^H?>TS8Y5-T[SIBB2QX06BUPNB;K/Pd]FQ=_K3DBR9CWF35FcU0UH
M9Ve;:#4#e#RBe,Hg8<MT1Acf<]DF?3#bFaO5104W<4M;LbKT03H/3S3>WKBE?>\
dO2HT[EH:?EZ^](Se+eCc&gTWAZ<P8M]_c;4E,aEGD027c1,Z/Q\[^aUZUg[PY8e
9>#?6XL9S?:]>C(9,gP]:a9.N)?8,?QL1>MR^Q4Gc9I]]0;]U?JgT]Y>-&B431U2
S],;:^KWN++Z7gfa+<SA@PFA__^)0)44:e/<AY,VSWXg2((EQ[2\4E\MG5ORPAE6
5?GS=e^:I5:fa/.>2]U)MJ5MY.F+[/TH\D95?<5M#@./0OWI+e(T17(d;WBbA1Ja
MTA1?OD(/[#)^J8BL9L(=@bC?@(cK/+1DMU0DK^(]SZKDdYa-:&Z1aU674N.HY_\
Q@/N/Y\CVM6CZ8GWRRG1.@Me[gZM=,>TRdV\BX331DFLMPg):C+;0-50F4_U(]=7
fD37XWf[SL@>WC7Q8_;->2Y?948UYN-BHc45O1PMJV_OK1^gQ&+cYO8RCcdN8>1Q
Udb1:Wc/QdC89)B+f_:TH?/5=1@,D0-OM;L@;]_a#CN5@B/,Z<gA/;A\K3>S1P?8
YCB\/6190bE\72K;77YWSg#Q_QGE4+B4SHLJMSfOf^(+-B4NFd8+9^GYT:a3-AT:
b-+J8M_fR/-WWa]a.6gcIAN@B@37gc,@C)ZOZW-K.eGUOXQ9U:YZ\U6-\IRI(TWO
G=)4QSB/U.RCD;N&:1HP)D<V(=-U3KGe/>YN,=<8CPAOOU/R22+3E<5R::3dKQd)
/D\HTWMJU&T(C:215)P)&O:JBSKS[F\Z?>=+M:2DDZ>4=bd-P5a@>)W9GGM@5EC>
OTf1T^7JV=M,F261&Y(G^T?aHaLDBKOIVWH4>GYZGd[FP;TeL0E^Z7,MI1;(:PXF
?C]Z/G/6GW/FVbZ476BeZH52U]aZW&=,L8R=K&LcEOXH^N@&9_VS=7-VKM^&]01V
Oa=XC_^,EY#7=>+R-7@cgaOb.K8MX5.M4Y5=b2LY,\G.EH_/^EX5eW6;?^XN)c7f
3Y99Qb1IJ\T_X(W@e^R1)4WC;#aQ17fI([b3L(<Z<)>N[4J^e8[.D4(K5bO+@bbS
FNL:fT>6-PR-M4gGf;a^<^:IZ3>@JF9[FV;W\W5MaEB_aJ@dST0e68HF@3DRP.bU
G:,#;+f<<->#4:2F7Q5_?dG=V#UU(G1SCTN6/V3:YS8]g-M3TCSc>ILegQ+6J<0=
-_=3^Od/8afe[fOJ\)=C,0WRKJSa82d-GME9I2,gH-5)@_Dc[-_2f\JPd=L(;V&,
-F78A-f]&;bO&YP9[>9I-[+X(#OgV#8JL@8dJ9^((]D5]&c)F-(@YeQPL.a(-dHZ
]C_f951@7O@^F[#)(7H&b09D;A1E1UYLHgOM@f&NP^6b,e+J.V2&LFf33)7+a7I2
:<+#HS<7YUM_91^D1&#EO2QDEONIK2QTUbQD)?,CW9^f#QICC9a,B3)2QT(]Ve>8
,UU?N)3f+eKgGCYfdJ-5#?,SIfZc>FGg]3Ff]/B;dc/]?&N&</QHBPBcGM+X;eO)
/DU5\RdUGHSg)-XaWY0@c,a-8G]HMg-0LX7g^Rf]a9AHLfAJJYAgUCRSWIVc1,__
UOBW<E/4/^P[IYI-Idf@S03U^WN&,?LEBIbPZUe]&bdXe((2.RZJR3+.1(2BEF?Y
[E6:B42Tb.@)[1JUE@b=R2bFAV<g3cKgBTB)D/XQ^I4WH)UU90N:3?PFR-C2A<)a
U03F@8WYE:NR=0e&4&6eWF.5[VT)3\675f^3=-XO:(N#XfgH_UTW+QQ??UC1BM<V
BU7M+@011G5(f=8/=EdBA8/TT\+12UDNfWXa];AdDYYc.+UG+GVfKZ^V1dX&VU?_
UMKOG9AE)[,U>_?7.>&]]NJYWgM2J7JQ<FIX;^F0b/a^?C=d(W;9MS-2ObgT_7cW
J6<@EacC2e\bcJ(NR+EE:gF^df.ADeTgBga5&fRD7/0-6Ia3^.GEXX7f,beeG>fL
\&9LZ7>a@DdC<F1eGMN&>>dACAf,8:THP@K\R;&gEF0gb(<&@7)LDgS@+[I3<-QJ
GL]T>WJ3U-DELJO1#Ca,3PANW,PL2@Eg-\QTV)d9T1<\gIg(.ORW4]V&U]RJ1TKE
XY2\P08(?Z.JBb(cYEHBGJ>>H20HLZF+/Zad2EHQO]&<d-H;CWBV4&<OJ#5K-GW&
2L)c^[/1H4[9:R-;P,3Y@d/\19(gEO6=KNU>04R7(6a(XWWg;ZMFeT[V]^Z1SeG-
BeNdQBJb;BF]22H@+45&fTa+b=Of@>,3g&A.#O]Nb:W6A,X6fHWKZc81cBKLQK#H
FaCN6X5M&D;<X3^Q48fEUM&LgXf1/fGH0U)9CUf=&b5\2G1DBEQPB85RP/15,aU&
C;.@,dGJ43@:WNGW<I1\R/B@JO>^&.)[eH8c#T:1Ea:_PL>dCa.<aB;M,eK6V7VJ
ZdUbQaIB_dgY?8I?UKf3RYT,.KI4@Yb=K6^6;ED&DI.0X7OL8X7\5PD&&J#J-M&\
(Ub==d8K6N&\77QH#-C0=ZBRBc(EO[8a&ZNLVcT)eLN<2:dAKeF<?dOUaKQ7g+V.
Cd=?-YL23dRK3=?>?1LRBHW7(TcIb446>4KZJYf^[=g,X)Rcc^Dg\V.&,_c2PVdS
0:>X_5bJM,VSF517]_^F.+.]>[CB217(.7e3;6S9P;>K4V&+T+cJa>/HZ[\SUTU2
A-C\(&A,1;9[<VI)KNO?e#D7JR9e@^.&:-7^<BfY1a#Pd@T-YH?E=L3:IIbdN/OC
d=XR1D(1]YWM-Q:YB_;3CSBM8OR8#3;RP88Q[:P8>GOF3WVb@,&M^8Z#H+KM0@LZ
VK^C58#K=FJcSZD,-LXW.NFB^KS#@8=Y<,IQ[Kc7BJZ[HQ+,&Lb]/RQID4;SMKa#
;UZSBCcA@B[G;LFc5Y&P1)#cZ&U5f7;XJ576)cCaCJQ_QKc/J8/E>?N8N#VIPgMR
?fG3f08^OL5A,c,gTA_e@J@a(?Ab\X8CK^d.SG00Q9<6M&7f1GQ5S9VB)7+4/\F=
f(;ZW+R(/B;Pe^fHZAeC\NeF9>NZeNXJ8M&VMEI\4.29.9fDF@E2DX+d@NNL]&86
4N3IdA)K5U4/Q_Q_\Te\O.CV:EL-9LcfIYV;J5NLZaO&1/aC,SL.0)P(IG0#eSP1
b00M5.f5?)Y<_(P2c4)ONF.fP9CZbLIU3fSL+Ge4/XbUOW=8dL8EV(NFMHJ=2:4(
VgC^42G8X)JGQ9TSa/b@T/TU6O8[fF8I2MQ.SV2Z=4EB5Sf;T^/443afZ2g)28@3
<Ba[LHD&1L=@=1<dV;T^NVRDN(:1V4gJg?W?_(GFGDEP#4dRV=K9eI)#gc_L);A1
>R[PD?+?G4,1:9A]BXcX,#C]X5BJc.FF32:@U_&SeGEL<DgLY)S2,V7S:P.V]X9]
]8@U=YA5_.C-UC0?5b;gc+b9+SND_@^T&W<B<4T,O12_ZA=f;WU>Y[HFA_7)+[dV
-KL+P>>EO[>4@(\_X(X+@]FO]\J.bH[Zf[:bM=GQ=NY7)/),R+S;Z:&7dKc6<c8Y
YDEHFe<fBH)CF//L\A.c2bZS9.QB.TAP,=7/)SEHb^IHffB:^PHbVQ4Uc8LC;]8G
O,XeNV9Xf4]+CAL89ZLAL3ObX3@+>1O)e96)3e#NT6+c227Z1S\c1#8O/>AX;><\
b3<Ng.UfS(C3^U^YXIPHdM124SSXE-O5C97@&bNS,1E?0T4=J0^>+4HL4W0.>.+M
VUb00>/)_/dT04B81D(\-ScJe.&TATfHKCeB)<(eECVBBB5>g^4Le>>))E/f=Xc1
WQRL(:]f(+e+XN#9HWf)Xg1^;[7T&S+Gb>@Y:E1-\+[UL/7<PV^>L5X^\WW4JI@[
].,(2#]30Q].NgAeOSYGaAg,UAA+R.,T4QDL0-[R-;V?Y6E\Ie5)S(#M.7Gb=cEV
BRFWbQ)OeC4DBgA\+eL;4;;cg<#R?G1_+VZ/H)^b&ELH:S6EMYK\LLgP]-O];,OH
D,d1LA&LQHS;/FDDaF#52Ef[+F(>T#5/e/7HST:-P)A3@>?K59_)NT75/&Xa).8c
X;&.2TZ0C4)XGQLNCF+216XI?QWL6g3+c.I5AVHT/]V-;I1:XI(<GF2#X4Of=RZ,
FU8NW:60/YSPX.S25dVX.CHQ_]Y\,^g2:c7V>4b9@G:e=W.e4I76dB(2EAA;e7Q7
7a8:]QB)8gRS,[CYR;#6#&>JD@JLB(8I99Ad2BAOPJLOAKL)[8:ITL6=26-D;Sgb
^KC<OB>Ig9:5,NMMbSf2RPQ:@gb=HFTHM&S;5YUF_[;@1ZP:I<.cc:M8K_aVJ23f
f2,MO8=B8VIbb-=KP/G:[,-:a:6aK.LK6HFA@)<#eIOJ)P@W>+O9SU@7X<AV/f=H
,RQ=:(OOWb#T?0,3(e\RWEL<>J&R@(VJe:f+b64;fRYRF5gEUcZ7P2A::.EDdW/:
_JIKMGSa0/2G,W7Pd9S,N#,.Q@@c3Y)A3bf>eC6J@2Vd+ZYO>2DYC,-Rf.ab,@f6
4.YKW8O0GB9Q+P1-W.=M+JT5(T@1^AB-gMI-:9R.2/4aXQK=DI\\:E=A8CCJ5.cS
Pa@V4\HT^g2f],WA/.B.e533ED=XGG9Q;26F:PFU0N]SZJ[LEDXC6GVE9UJM_)K_
W1-ZS+/,GUPW(1,[<I);<\(9dC]0HOAb_A#:-K&AHJN^J<:O)(Y4fYCI:4.;Z-YW
\E\ceFP_P,4.CHfSMb7KBDOcg_J;+Z.V65FebcQU9^=W411OF+:fKb/Z:UfV>8G>
M<;6fRC+M]e6ZTXX6V+RM,G#B]Gd0RL)T&;]12DNQU4OYb7&.MFVBeL[)KV4eO?@
>C40#E,)Q<)D&1D4WQ2XFGf)XG602(+YaQeP;T)B5F7f)d[G(A@A2dQI#>80aRH\
Y@\TLTGcS<8e,6)1,UZCE6:Q3W0086M+I-QV4:;I4NHLF=,OO5GJ26)<&>D+;(9Y
Ba_OCY40F:g(b-]_[PH+9P/G.P=SL<[MIZEO>N5aX?,(9MB(67KCJ<2?g6F0Lf]F
f,W?57J)QON-[FOP1AQZF3V(WZdU?gWS<afg:8\E&ZPDV8(,/:U+JEdP)4-Nb.7=
80C6M#Df,B27eY0c&OKgaE#WGD2WXL5WZ[;Z\^).7_WU[0)AKIU,-1BEg&\S>>.7
ALRH#,1A4CNFFc/OJA3K<>P];,B-TD5H-[OL&ea00Z9W0F]96//F#_1KHeFH(IQ<
WET=_)IaXL_b-.T\;,cV?25H0T^=;#H>2L2<U1(6M#gW3Z5_I8+:91fGO2WL(,:R
=Pf4+cUKGM3@dF9VZ3HI@MAU_M4;::g\@BQgdJLGPGfG\=Xc531f3aO9NRg0S)2J
[WV/&KWgL?<#F^7VX.4NCXRfA#P3V=]CVIQ(?6:I07J7&@5YZ3SXJV6<d-cW(e6J
:PV@JYEb8ZF>dH_bK9895P]3WW;79_Q:#dg-WYDBH86KL8Fc2I?PZ[_?(NMJ+;P\
TUD<2.P&aN]bdKZET(P[OaC(:QU7&:_.O&J-S4BDK9<.-65N#-^e\e:4GJ\+GW/c
CO\(+?P-(aEA4e^TS,AGUQc\UL=R>:b&.aNOaSbCZTf[H,IM@EONLZJe.ggQ]c<4
;2?OeTSJD5RUb4=6&\FM?PBPV351fGN9db[I/[eYO+Rb@F\S.QfDN..A/M2geY5E
+(V\;e;_(AUX.3TD?ZP/dEX73+#\C<a#A\?@T+\AO9(]RcIbV,:T^[>8]TKeCKWN
X:/B4:,NN;B-6_:QGBV#F)S4N>OE8d(gPWY5K=5E=)XcG2#37UOBF9525.Rc6a9D
X2)Z4a9Ud6D:84HE8I@+4QdI)QfQAfKGOD=S:Z4[;,,e@aLCc4F[72dZ/D\5EP9W
]cOU+Ug[:Lb.TUf3)UJLUD5:_\)H2(_^81BK(C&_G;&Jd/J-8g1_G^#?#G>2g9(.
UOC2,FeFH9C^f1E_02e>bABBP1@I,Wf_7F,g1HC9U=c_QMKCH:^^2/ZM(@7LWN#C
8PJ@DCe.=Oe8;Ofg,7^0,LGF<@:M71C#2U7#\:gbKc7KDLO?[22eY\_9OIUYGX[Q
dQO3+Y392TfNH&]WL>[FCPgQC=<SbcO=Z_1,5VZ?L[Z1SP-ZBdM)5(d]#WYb]])N
L2C0P_gJ(<[)0]SDcLIeI&^D8O))3c_c@V=CUECP5R[/S#HR@Ce)<S.S_KPJ[@)a
S[;.1?/PL+X[g;_U&_eJ#]L[:W)L_7UW82ZCIG,MC\\D#M&QZMRX+M_P7QUM_;Cf
A[E3MeP-QQQE-NV<2QW3UGbM=6,e#_@?Qe2/GIfJA(A8aT4gV9:?bY>?L(QSSC@4
#7].WY,@AgV05Db5UCVQ:Q>Ue&V[):<N<X26=<a,QM37H9B.\-:MeBFQON6b2<YR
:.VPd(aN+I#D6&#;-MI(cEeDM._\Xe@\=&I:3AALMRgI:@.;NBD];#@<?;C@XR2K
_BDA,6PX\Q56X/ABd<BaFfc>4D[H@9^dd=f87SbVKACWOZH@C,VV<1e&I#LO),-=
#]&+Q504?L[;TP]LOOFYa2ODd7189JMa]8/[#.68+/>FPbW6V</fYZOeE_@CJ,_(
JA_P5XI861N0^HRF67&)4X^B3a3Z:ceM&+E8^SQ]W//PTKG.?HBU(a3\M_E]/=N7
G47aQ41OB2e#+O\cV;:CNO117HK5A5cA-<U/^_)KKI-UMgKd3]0E4+PD?H7-Ee-=
W9:P7@c7a5RY0=b.K=FVQdZHOWO5Q2E2T0H=[PHWgD.7X^@MPM>KXKF+Ha_WA<V=
.UM.WY52H9WJY(]gAWS<WA_Z0-[#/bfN;S0\aLAA59dT6aMBKYJA-f4+N=1TQIb_
8OXc:F@fb0.-K^Q;DFLI@F/_+_].:CWadHXCf9[^WY_]5@X8P\@7,1MN3^IW<-LH
C;I7Ag[79?]D^(5O;/VM<6?7C46g3:(SIL0]1>[0G/Q^#]M/R_LO+SA#8JK3b_C0
-3>Q;X--a]V+/;e>UV4:&CcZK/WJ3_OY9I#X#4eKcQZBAd+CcBCP5c5Ie<17XS_+
D(BDZJI)K9Y#ZZ7+\(FDCA4a)?^)-\0FM#2)-f,Ie7aebUK/R>-55RCPC_GR>Q--
P(>B8^_VA\VSTS;_GO=A+E0FBZdF08Wc&Tg6.:\g1c+<=Re.[()?HcX?LG[ZVf2S
[78TZ9T3N8@39OLY,/IT[eW;>#VPWV&++7J5LbRTS^>(I]T-XU1]VYIBE92SDg\8
L@8TLD:A3PA5g2g2P#[35:VTQ/>@5;9)[KHRf)O0-3>4T+T^VgCf8<:W=C=1L)MU
,WJNF]2b1.Q)g+[?A&):A,e8(7678bQ=AU4CG0S;XM)N,>XYCUU9Jb3\Z,>3AA&?
bTE2fDDb9AN.Ze=\<A]\J8Lb7df=>WT0-H,:K]HK[;aBe6OF@.c5K[(L=GWQS=\b
5_S\MNe?0)[?^IYc4U9=[P+-]:6>]8gdKZG,[WDaKV:TN=;#6,UCOU7<??dJfdgT
)HF-KK2^M9;If[:BM:Y/4DK/Xe@:0MY(1-Sg@M>01E].^C.J]1V]Z.KIP)BQ6CA6
@BFV9/Q\.41LYg2MROU65QbC^DYV+Cg2G,(c+=MO(<#:^bF,U4c]4T(Q4,gGNe74
TG=V06;U2d/SBJ9(QBBUIGF14<JLT,,d8L/AND)DZ=aMB8^QgNeST5KHdcGI2H3)
\3<8J@fP>S4H+>CAI[d_cVOR/U(C?2Z>LK#MeXBd(BC4X51LI0fV3#UP88+HWKY<
9+\)A<26L:+2M[V(S/Z2Xe-OU<3DD+ES:L3FJ12O9OBgT2QZQ[F815a7K<2Ib,BJ
W4V(O4H/N&R:GK;)N_@/RSc]]P9T,(4R(:8g^W?FT#.d<;b,1?c[abY9-Wb8;GUG
MEFbT&0f]_<M+<0Z.g#N]Z[^\5/&[WOO6dU:&QfgNDRJQ:3YZ@[8OIcYK;<L:54b
LA]0]<6V4<@ZB.-f_X67f@dD4@&SF+2CK#X#:,<T@X7<gYB7[Lf>0BbCH,]X_HMa
C7L.+AP,876=&ZN^_eAe;9+A(V[IR)c0]7b::]GKb),]WUHO8DY8BY)HT5O]VBFD
aDM=;fT^C/[_NOF0,HIbP,Agf_M[EePMA^f4@F.24dP>J7\N<8+FQEG_K1X:X?MS
U8?V(>S_cb/.:BTVC+GE,>QM60c5^U(Y,\J=/#e3UU?[2+&ee:M[fK9GDgL./E_H
cH)64WR7dBC-[(1W)/S>NBU1QgKR[WQQ22IF/0T73/bD,LDDQcOCRDG4e?IU[b4W
ZZBdT7/eQcFd<TY),Ng2,-gF3ZHE]A?/)b2CSHVI)>E:BN)Z8S@.87BcNL7V\fUU
V=[C-LP#3+QgG2SCJ42FU92>F/2;ee8C@C.6QA[:e;_O1YCXC^W4]g>Wa#Cce@SE
:[0]A9CQVdb.E/I13#UN-b6X+3Jc6+U_KYggNe]Id0bI6F&3CZDDG?b[W2_VTDET
?LB^3P@=d;fR?O-79_Q\J7K0:+D5-CfGf,_B+;9KVO(H9V=FX]++)E.\T]cUTV&E
.CX4;>:T@SIfW1DGM<-Ja+)SPZ<^aOd#W:)R(3V9\0cO\:MP2_W8g;5C,XZOK^=)
&Y0-MLBK/J1K33#,55gcA\H9JR<&baXY0R.UX?H6X2EK/#SQ9M_>cc-SV\Z;8O:+
CY/TO-,[2c1B_5>]Q;fOI>c?_D&bT[;;b;0V^KP8)Pf)[=.D?#GZ]\CeADbOXGb\
J02]YKRZ=5E6GI;3e^61Dg^cK8ZZ8.N0-&CYfH)01IHd#@7\C=7=6#D-(AN=JVgc
HZB]6,>WM2D6TB)N.?&Y_5^4&.-#:YeF@I#C&?-^gFYWbH5<IJ#APZ;,YL)/NM9V
\d7)/7L:>Y-2EX/\CIR:RZLe;ICREW&MTC/AfL===KC#[EO/)d:]WQ227Z0(DVFU
#Z14/TQd]2M#F[;B/J\PY8Be.cS5SQQ#])-IIe>PbeSeL^JH#Ag&?PcA=D:NXJ?D
\][V;6Kc8I/[DUF@AB9>_^<)1dP.\U>^WZ<(RT^eM2e-FF2EBSgO&9^IaVA6]DM.
0>(2&;gcZCU3.c5Y62.-D[&2UN#11/49=18H&6E^-6Gg),HWgEe,ZLSF(./W#>e8
<N,J0g>L3UJ(KOC/XDY27G287S<2&^(<DQTNc6Kb]_ca\A^c>=e3g946SH:@5JB5
7e>g6Q4Uaf?V\d)GCP/0\LLI#?4E7^fP=ROgH]Q/]\C)5c<g?FRW#14/Gge1+H6F
,<D9UL:T9#N@RT?H+f1F5LLYX@cXL(]C)b+WE3GF;E\Y)UAW2D2#U&+0E8T&^QaC
?D\a)SUV<)/Eg>@4Yef^/f=(;/IZgPY3])]GK)(:]-O?^)E3S12:a;Y2gF9<GJWT
@O;I+@YT#V4YH>D:b3ZTd9XX#^R;L9f5b/B@BY44;EQ[S^.cD4?;d>,Yf[NMI[g\
@5.Q.ORb;:58[8EHR0YKP73D3Fc6b@M202G3[a:?<<:)PNZ:Q5)KY<UQ1E>9;5@c
&NPJKS,0(+=<.6;bF831ULZ_E9W>>c8=_O)VG]>6]Y>-?UZ/KBIFfGVJ;2\/&+3d
=2C+74_Dd2DaFR:?fT\^(7M00JYAAA2]\e/?dVDf4=,CKSYXcQFLVCITbUU=L]9a
1:G+7N#.Q:WD+KSc?>.BGV^4US&DAeW>_CDbJ6Q:,OD&;6YGA&QMgPI:>DcPb=V3
;aA8==G?I0JG)E+O(H1LUO]]61Na/;baNHSGf;8<SIY^8dTXa4dS36;^+9.5@K()
LJ3C2&a1]&RFdOcV[#N9)aU.eVN2;<,R9Y9\b?dSa<+2)0@G;9b(K)4g(Gc?-(bC
4L\]aQT/I5A38/+O<B/>Qc+0L=GLJ1TG=CK)-T7fF^=/bOe:e5;AU@b;4cT\d?@[
_R95cg5-,OB;f5<5,JG31?.a-[+dM4N-^fP49bI]VL5=a7IbAcJ:@7_][?:^OT7?
8?_0g(H11CWX1(^212BZL,-f]3:?M4-5K(#OggHOV@&5cT&[c63.>S]U3bfT+4,A
&U#D6Q_@g#eDC)7GW:96BBWB9)A+?e:;Fd&.,L&FNV^Q+-;_4AYC3dcV@;4W[Y5H
(f][W;Q7fbQD/PHL\3QDQ9NFS/K[N2E]F5^)f&47T,<CeW+\OF.b37VJ7<_f<6E<
&A\9V#-J4F531B6YM_d(Qc<A[SGMeYC-6]T.E<g6;>HgTF)9bB(gWb<9LGfAaN8\
:Y3@-Q@-@FK#FS#,fJ&L1@<=>[c4_2HK\WN\9;0K)##GaMMVXDXO;3Cf<\e9g++<
.8(ZF5GcE:8SCJFQ//b_5[X0B-edU>]QWOX^U=57[RJaL@B3(\/Y-^SCI=,bK9CF
4R3IM@9eJ<-0:N9cBdX>_OA>dQTOG>F4PJK.A76UY@4Wg>&eV5TU?e@(SK\BB[He
7<E,^BD)U\-F&?/LZ?G[UMK7<FCD;X-aXbCb;\MS&c3KFQ^+DeV?TRJ-GG;BPR.7
/5g2F0]B0_PI_FTJ@>?O6G^PSX5(?O+8c^K7BX[16R\e9#SHW)EQWIT=E<5V:cPP
FJY7aC08_Q0d&ge+Q;P>B#.Y07U8B,5+B4DPJ)7+R\PW&Q@<U24@O[0J[/@,@b))
KJ?@Y@B:92;.9J@IBgIZV_3e,T]G>;:83fO2U-6>B72Z/:^,W0;5)[OcC-JTb,T@
A1dHf<HA;TEWJB;@B7@.NC[7BBR5]6SBfC422Y)b2@c0A#LGFKC.Z(&T9HA[B<=-
81AP;ENA7[+1+>80<;>G(aWRZd7IfS8=eB/LP6JPDHFB5d?ZI7TRR2JD17+:[<)3
5N>-cfP4dg8^HG50RP;E>XFbR0_XP>dH:.22+,G5Z^A(If,M?_;,,28VV+RPXW,1
GWHWVO+P?898@IB/O<A7&O\0_(591;KI8O7M,_6GeW,=]5Tg.e18[EfG^=7eS>Z9
1H&IQd]Ee<5L/6?IZ5Af4b8<5/SDKL?g6K^]1&gYV0d[)Q=(E-QM3(#/ASYAcf-9
dG[4<+UL8?58?WLY7?CLPXA_b2W+M9W34_#efJ&f)O4dW9g7cET>:UUZQ5X56HUO
cdR=3;-0a<665EQ9C>;@eV\A([JeURfJ?PTYN13#YR9B<cX]>YZ[#a35[/aMYbG0
?Qf/R()<\c5?Tf=g7-QC32V#[&[MMS#]e#HA;XTQB(_MS[FUc=PC9[BdD]1]&H]9
)9M6U(LP:GEdSDD[8D1@Z\F9XPCbTJE@@0HU_2/AW]<N_SG73^:b.PJ@6c_(.SN9
O(.FSeU@=X,=(Z/23ZQZfRR=8Ge:B#Y<;a>0\6NT+XAL])\)PH^L468/-\<8BD6#
5&2I,1KgScY\MIb)TA\AVQOLdNE=KXB8ZcK[50;Z0+17cbSRQLXdRc9,Q389=)XF
+e+8[AW.P)M^(.=QIPJUNg;0BGe8)_<STNJ=98JT=JdCEUbP;CV=X26[?^D-+>6S
gT@TQI/H3cE(e/cW2,]1O>5,>H1d.Cbg5-3I^TB]UI1+Nf@WGVJ_1Z]Y_N6<Fe/C
a4T&>#B1LD0<;_[F#Edd?APII1-S@;(:<HJ/@M)=X_JCY_9d2WB?FP;;<\5)U,V(
.)O_7P,2eKdGdd9MNGFL)-J@ESc3A@,3.A28C1.6[ac_5M0&ZZVV<F?#M6N3JFf3
4bD,:W/DOa[B5\g1U2G\3:\[8E?=1UeG#:7AL/C39F6@PWMTD4OW1e5<NWC89PJ7
fWZ-g(:UEEDYA8GBX9D6@H=^f6=N5d^II,RV;3W_E-fb9b:HLS\G+UL6b9#J#.SC
<_&11cEdYY6WDF-LP7f@&/LeO&3P7W[=2cC5d?Oa32OKN@Q.S7:,],(ETVD8L^@,
W#.7<_P<]3BDN\SH@?UB>HJf>QG9I-Ha2LK8g6[0PLXQ6SPf1U(P2GGKP@2UJV>9
V]]7QWWQOCF5dL_6(/1Af)8JQa.19<XJWTb,]GJ;1a^9GM0#1#/BA2.5-9EMMJR=
X9EKBPHaL/>D3/0Q/.?,MXI?4&Z=_)U;A5\NV1:-@&V6JA#M9N&J7+2[bAUX.#(U
R?FI0d5<B9f>KHRZ=W]S0&>^cY)<J>F[)I2cX4SPNO^B3HPHBMME71U1fME3);Xd
<,ZJN6S.=OX249MFIGJ9=Z#W;=9,]J4LK40>-6D)]UKQH#1#1=Nc)P+\eTfCaZ14
_dK1gH?/UYRKQFS#dD]Q_ae4@^P[2OY5\A)]g26(C1cgQ82eI&AM4TdR/L2R;C1,
4RdAcDF:8Y;1R7RHbA#>CV;Q((gg1R?MX[@gG@DMSEZI.Q)<E7#Z>(SI1@)6JV-H
S7Q&-1I^(&(?\c[ZC-[9N2gT#1Wa@I#J2RCFO\W[31W6P(ZZ>?T;]+VB[7Y>R\\B
a7)XeDE#6+.@,AF)J7Z)6ZW>^fH9[E;DPUBY?=4CT^USEb1<O[a=E99NN?&H>)1S
2+V:9fC0G&UH)-D_O\eD4QL=358SSeAd<WL@b@JH=#Mb>-PBeS\ITd6ILcQBPR=H
_D.C,?5IYW]4FFO>3<F,IMG9]BA3K\a>&60L?O3A/T_NSLL--BSQYLP6Ke>>Ka:b
_&[8aYQ_M,SG3_.HG<K?1\W-I81KGbbDE;C<Y3,c:1f#;L_^2(^+)9E?HNO_)==K
)JaCQ>LM22TJ->:&T>cHB[5_@Le(5S]ZU)8QU,gP2Z/Z\T=/Z+DF1+^cRFV<E:;0
<I<YfaJdUEE@.4.Xe#cf8:f#4g4=AHUYVP:WE_>5ZNe5BR9031H5J2Y1TB=Z=&I2
95GDZ[OW,IUWUK0;&2KEM#6X-VOG111<ONd4O<_.7U(g94=&RIT3KbJF=2I7P(Ke
D&P]R9\F_fSDFQUf_BT2>QfU2<8\#._\:DfggKR8W)B(F8\=c=I?Q1L)ATOF7K9G
ZL>1=]9H\3]ARC7LXdR-8\I?M+T^)Y7L^O_WB7.<Ye:/cX5X<=3=A<BBe0C(7&=?
,JfWA]@C/-:_aY628EEcbUePYbG:9XR]FbfbFW>>J+EBG/94<M8-)VV)[.278T99
A,(E,L7HDbQE429K1-f:XFcV1+RXM2dS3A]XYVE7g#/H6-[.UG6YA=?P:<@9ICN\
V96D9IcKPPQMaUXV/fR9/dY<E_X1D2<<b34;7b<,bV/KI=J\EXNG7(SA[gG6)^Pa
T809]NC._<-&\;.0AaJ1QSS6:;5F33;Q99.Q>K+G=G(]0(aKMQf<\gfb3W84<FJf
/S-C7DF\38:^):AZIS9/5bF>#8J3^)AagR;<:I3E.?ROQ4fS8SDVT<3\5F?17?\2
HU1YM;XIDBc,:a65OSC<71N60[0Z^T4c[Q:Z+NcUa/)/]UO<L]_BDee?+L[,EOEB
+.#\>@gNOC((67b(Q9,Ab6QEd.A]1=KA#JZQcdF_^_-,^AF-+J3.V59]3?b^M[cJ
DET@K?&66>BW-J?+&;=0)ES[5RPJZI)Mg1QH8YBcFK3K=2<d&D57g@;OOF?\T-LO
V:M\U<ESLXdNF^ZC(bQd<-PDdIXRYNGU3[Q^8GDM,^MB1d7b-B,9=6R8LO23cHH7
(5-=JI/gP<Kg<^7@#RZ5XCOG9<\ca/@c:3c]0#\8(_BR;;EP\a8bVgXO&d6dX-,K
&IMHVZ;3(EX-N(dd()Zbc3?#[15[XPKJ^J7,NN3D8-.6gea(GXCQPPC=GQ/NBaEE
ff=A_9e]1X^M;:7HA^=:-+G&-0I74fPU:NF>aN(XdJa,C.-YAH#?#=dP^(U&I,X)
CQ:K<JH>J0g6OA?(9(SZ59U09A,]3_TVUGI^T\?bHXF[VgJ>]0c;.f89^CdGJKd2
<]N)RQG;OQ8@Q46_AfVAV@LC:@:+AeFdeMg-W:fF,f1ASAK&Z3DC^R[7WBU41836
+WJOdAO0FSbR0=R8=J.5cH&]M&QQ/X/bHVR)KJ@BZ>36D<AFQ45FeOf,<a868^>d
>VQQW@_OS:Zf0E]c9UUK\O>Y5(<S4LL0CC]MT-N,RG1/E-A,^:_f=8a22#C[JG_9
<3Z.^8IZ1Aa\gR^4I),0,>.:N>N^A7L;&+]?6QcO,/g3QIZ8>8(Z_,9(I[2Ve-@R
170JKQ_>7&HNWC=6_@4U67a\gX8JRXT^WD5b[F/1=W9O1&4KJ3Z:FPUR.(/OIVY)
\&/4/Kf7#;9P@=</<&[fZf&5+)NYD_,^eT;F\c75;EN#ZI8ZaeM6MV5Vc[7,07Yb
6G5Wb1[EM(Yb,deMGG@84@-c-FfYNOU1f5&^DSK1\]BV3YeJS866(g_I/,:^\+[I
aLP-4JY(R[N(;_dPPVT]9He(GP]2eC[J&6+MG&T-80\+LJKO=f9#Q71[0JY-]+^^
=:CFLLG]C]X#9e_K=f^G;,6<)VG;J3Gf49O2X=L2?V?<>fX&.//W)BQ#,@b3a\JU
E/V_HD50TN/[24,Nc\Y65;]XM-\=d06b3RE<8a48_I@H9G@H7AFCPK9G5K0O)MTU
595B3[&Ae?b<71^TTX9-ZW.DY]dVH9B-]bYS?3/5+MP&K/_/J=2,a=IDG=\MWRNA
[MT#;MBcF?ERSd,E-Z0X@?F@BV[EDV#Cg8_ZV@fgI=&+SK1WPd:OCa;,8Q)6[.@c
LK95AT==Dbf]XI:-77;VQ)ZY]@S,(F8O,UC?)d\PLZe[F)<X+A3R+?0OSN#]YB36
:,(+:;B@:<c;Bf=<KAQZBE90^LG04V6T]dCgCIY;C1S9X-T_MeF.#2.#>4eb=IPP
SQQg,QNOCYNaKPCA.GBAYgV\/0U-5330XF8TgfI7)E?6,gM7Ic<eA1IWM>.Qd@2\
GMOPE_c]c2M)@NIH,84^TM#-30?+V1F)3=4GCGKOcfF]gRefJeT<5>0ce1W]A-8&
c0GcX?G^Ebd-45EQYXURC>N)J217dEQ@W_-NRfWD3<WY9Qc29U?DN>_^Q1)<G-QG
XGP8G&UL]IVLG)EbU-(&<>,.)6b\6JNQ3B@dg4MJ.5#7cL/1OCdNS:&/gSBcb&<K
W.G6dJO)?;B7ZFFMX3J@aQ/<N)eO4dL7MA,D;8c,[K0,1:PW2M>MVL&O(42]A/E3
RPRe&e9@aOR[K??N[JJXP6YIc74S7]R?-UOf0=;f&754g2dQ2=,:I_.Bgb:Z5ILB
DNc9;)b&c\c>6caK9JAfEJfF^cPQUPQXf0g?#b5aP\BD;Z8?NM7@RGJM.2WOVOXC
F[A(;67g4?^#g,4GcFecf+TTWMTU[-D93=R1;f/D4]CZVgF?&C<0N>D.CQ/^gLb:
N.MPL5=U-R#A6B4?4JfY_UID3[QU1Z59E9aCFb-NCH_MgQ+<.#_.GQE3Q(78(4^X
E7<AJ,,V-:5X<^.(Y31B0D1#Q[<?U-SCDJ#-a(;^bP7a0WCQCMVQ_RECS@A<LI22
BFfGG28Z^<(7+TNV]F;f&=eJ>C+LS3H5W26EYIN,<WDJY\0H+@C=e4OAA,=2B)1d
A(0HO.2_-GDR2)^3Jf7aK4LR#0(DA+=\8=NdES>0NRb8;+<L76EHAG:.c@a>D8VY
-W50d1Ib?UT]1b(:_,-Zg6W[],[(/U]&^IdHDSC)SL50ZWf;=JWCT.ZO)IIEY^&=
<bSU642ea8C@0REO8bg?6XRg57B72]@1POJ4ICEZaXZ-H.3FV\agYK4c-WXT?FF6
AaJXRV58a^8SCG?a5(BgcA+=g84B\T_0^L+W0JCVa<BC3@Fe;=7XDN)[?5NK)R7g
FXb/C=Yf)gP(eg80Q5_H-,P02EH8=CI1:C32\dA>MDYgJBJTbJSBJ0]5CbO;._-4
dQ_/DS/MfI_)8T_LfB6@eNaJe@)fXf<b3F@O:aX0F/XNd^B8]1SJePK)#fC=H7>A
V;W.^JE5d7IAFJ\-4AXe.8#GAP4cgPMZ&K^Og#RO1CI-ECW@Z)XVD(RA8/6e)d6[
?XaXO;=2M9X1LCEGC0:=;^R?^LRL@dSTN\D/R_c;&_fPK62#<0MC&T#/X3d]0f[)
F+30R=5K[4PTYD8)H/@b]=+@F[+-C5:-QPRA^,FSE9AMgD\88N@2dVc,K#.Z\,#U
@ZeT#0g:REeT0C4HK@K5(V+:#C_c)PX#+N+4C#g^>&5_#a[b3[4;/U?CE&DZ<)9,
aXN\[M8+2X4EH3)#a/)?LO:Z>)a)R2b>FY=\@==b\fWb(R#OG_JVB@<ggQM0c1>T
LP2W;CVb+463B#DfS?gJ69A9Nd7(V.D)gC=<+FXag=1eT<f0H>4g+aWU86YK0OIV
ZIE8&1>MKFS(0KJ[aCD0d[QM6/9dV,CPR;_GbKP=Q9@]Q9LEY0fE[SK?&/5/OP;H
be6:_C)?-gR7?ZZ(8R./bP2K1#(b^KO&7c#GXX4327FW[5USe]XMW);Q&R)5_91,
P7D0S2K4/AO<&I(^Zb48.<0#d0<eg;&#HgP:BBfdS5EM-P8+]RYF3,]5LC7808[3
Lc^F-f/ZF;]6A3d4ORA/d,V3^dG80CF2#M-BKOS0Q916RA)gR#(,=HDG;4U=8@g3
:/FZM3gG>Cab08aHQf;S<>Zf>+B/FWDfSVW-J2=\(O4d0EaT+0e0)g./BMgA_2&(
-/F)IIcgX9_D=:F>f,(ZOJFXQ++)68MB(aG&=feR#Q?/0V[,(&SPNT#Ta;E8_.KP
KV7-=9X1Y+VgNV\<&PN(TUAP58#dM#35b1DYRXKVUfZYF^;F?eRg)Wg/6?1Xg+OE
W=09=O12M]JK?S7LZ8,9/<g;8?EWaD+Df#:;,WN#&7UcNf=_X5RL#XL:(dC_dD>)
c/59N>+c3-_O??ReNZD6;4c=^fTb/+D^7\K+,7a69:WQR2@U([cgU#?)-]G&A/?Z
XEV4U&T]1N@&NFf;=+FgJ([-HI;A9b;>&1CR^1URGD:2ZdS^ReL+?I<dc7BB+ZNX
bb,Y.&SNCa6(>MfVB>6B&+A&d,4Y4RANZ23[1Ff-;+NG@3^P3B4036dgNHT+=URX
M<N8DR?R#WK_c200[@7dDQ,_6IL9=)5U(3B/)+;D5\@6edCSgCg.T>L6W)O3f_[G
#/OWa2B.#F-/B8<-VHH=80e8:6-P=7E<A,A:aCfM(J[GNI#71=+_QI]5(H21@U&3
EJN)Z(WO@-W1IYU[F1^/GEP>/\>@WW790>Qb/1S<Cc=Dd1R9AaQNK0Nc@+E]B4U<
aY8>>1+FT4FMgO^2Tf8Gfd+=3(X2W18LGc\fIBC=9L3OA;,ZaDGT#92FK^Nbf30&
0;2@&XIJ][_M4B3-@N\I,b+c6V)LJbC7^EELaVX1#KDKgU@<gEF[ef7VGEBLI+Z9
BSHfD>RC_=Gf8GBO5].Z--Z2-AFWbJ,TN3;6;ZBCZO8KEg_-)FGLEN_)7F<@_8:Q
dIMaFRS/RLD.E:124LG)#Sc84PSPd#(@(IZ5[WHaNN?Jg:f]aGAB+(M7eCfO,<Y?
BB8D^a0O[IXWfX240#X6_-Fe^eBbCJDPU;RcgU0cQF>gG7/(35B5?@B>EWVTRe6G
YB:E;9>3?LY8XMfBbd,M+GC-/O?9R=b.LbbZ[&SHB:Hg?-8AZDV66,FHbcXK-?6-
A9N-57L49ccSUE6N,TDJ&<A[I0,KNVR9/,I?WR#IF\]^5b\+Jbd:50WIPMdT+0,8
d[5+9XS^_\_0(,D-#+We,E<V5;\U-_9DI)?[M1AXX8@JO>6:\4Ce>Z7eBdL-,9R)
DH2W-OfMafM>;+,8-fU@&>e51#CD:V]@[_.K=+1V@OKB\8WIEd/[;1X;KCC9)2,B
]#+O<#HO&/Dg/15-&,[(+T5(?^Pbe^/f3METQBaAd]&CP()8DDO];IE@#B.5#,9d
0X+XgE[b)5MS<]>5NcJg\^A+-fDQ95G]Ue-P<6+VIAbJ,)bP&:<eR98CK=bZcVMa
6/P>^450CYL5@GF,JeQC\B\g()R8L=eG)XHe(T56;8D0>:1A/YR6JY#FSc6:<deN
H(]cI1P.3<Ge3@a+<=#U<JHD<QfEN\N8<O5)TecR,]b:@7F2.@GS:,5K)<65^QYN
QT3:@e2C4QXVa/)^db((;W#Tc-Z2L1\/0#D.O2c3_K7?\28XUbKOL>I\:2=Id-D;
?HI_,^<Lcae=P0bPK11&@X2U</F_I-ICSVY^[]9<Y7=9XU?+QW/9\<8C6_^+cC/2
+(WYDEG=UP)?J.4?#91JZ6Ig]S[3X/QD@9L@S8)AK_/89KE;JM=OQ6?X\LP^/JX9
>2=EWO,LA5,IMS=3W_M-<96W]Y>2;9)HfPe1>HID<L,g()@g21/#8_=9H21<J89^
YQT9CCQT-W0/DUB+6(9^RDM@gLC;DHd77A6&QF#2fccIg^)F_>AVLBONbX#8+P9]
>Y.\=+]#b(G)786.f+&15Y6BC/][T?SHSW;#]E#X@3c)WF^>3NR\8KMY&\;?RY8&
@0<1B-,1S]eHe6@[JDd_f@Z+;d41W@CM9eX2B_-5MeA8K<\0H<QQ\1&HYC2/R[(]
M/F5g3(OF-=KB+g(Zb+5LS^VM(P&AQU^A@e&MG5RAF#8,fHRFe_gTd)L/NHe;W&Y
L+Z>65KZc7)U,MFW>B7=<8T:Y?.).+UZ9H:,0d[PJIa4#=f#0>:Ie(LB,+7(K<#D
Y@4(FgQ-T&;[X@6?.3OSWL<AM+T0_:^(dQ0KcH@,]gX4<D@If/D,R9^5;c)f47Fa
:JQMA-dUMD3B=R5PEOA9gY6U1GOcCW3Ue1:4c(-_1FGG]Z<[(UaF;gT970b[8KRH
PX^F:ZX.K/\8E_H&[/OfJ9Z_+cG?K:FZH<g-.20N.GfF0Z>D<U;cRTaC&H2_AX)D
N9;58(<XEgC&Za)PN..d+G<1a0eBH-1CPIL_4/POBE24d^LCBAeB0<J[K2U#=.Ab
4,T,2B(#cE?/2d@M4T/\]#/T9EcI2ZgVJe\A_aHWO-R83<]FceIY0911\#[07XeJ
)Z.S62(1b7W^[aMe+7&<:CD31=5JF.+N+eBV(\c([6W;d5(WMedF/c_bX8V@O/<W
Q;M(ACBPc\1M5a<ZKLAb\HZ2gD?#^]M/9ED/E(bTGBIB\SFf;_:d3HDa,Z;L5=1.
3g871VI(OF#g45JR=2bLg?4C[VQ\84HcC8(UfAIQJ;)^A7(bM3&BVc(5=-4&(,>S
3b=\11XHAccXS>g.G7,^1b=Of?ff-DSMBQ07--[7)FT\b+d03^)0b_3D54FB:c[f
HF:;A84L=IB6dNObOSS4CPATQ,(fcKXML=F<9:0[+(Z1QMS<+)_8I3Va.e3:_d[Y
;]aB7:.-TW10I2^UfLP=Cd)#O,ADSXLD;T564X73(U#eE]:#g[6FKZ]1G]PaFC/@
e&+78@T-X8EDQ(f5&V#_L^#OSF-c3<,We?c(@TOGIO7+;A0Z4]#-YeZ=5DJM_5V>
=T<)Z(Z09UO-K+98K:;C9>?&LS7L^L6\3W7fCD=&UAdAQPU6J&I#4D[6D0<C(WA&
.X6&UK,ROK:-cD)gOH2>V[AXGVF<MS]@0GJEdBW6XQT)FZG@^?f3cZVe8>MBa:\3
,=SG9.;OO<K]a[f3X[XDS6]Vc_RgR^:K+XX\\=g9d,6?.BaFT<#CY,Rg_(IC6X4A
^.8e(KJ,WHT71V\L)R9=P4,LW8cIKX0W&RL5T?V1L;2C<NJUJKM^S0V??[URW/1@
./WdF-4OF,#YQHMabYC>I4.8()0?Af7[#+1VAWUQY,4X\FVYZ.)Mc.eeUf+YGCYB
TfCQWH[NKFeWeAbdN)U]A>BW(b9]Y#FUfXJUGOX9>S2.>S(FB/RaP44c[EK2IQ:d
W6+P(U3J9dg;9fJ7;VY32A<:.&DL3>5E]cS02cf29.OA[Lc2D+aa-a@b:F5=cIDE
]1JMegC8VUEZ_aZP?0H&Q.>+IT7N)8X1GH3I3->-02(I^5)4B6g&U[bH3e;[V#1A
5Pc\I\_/XTH62@K7<b7E[7KE2]\K:9ND@2O-IDJ?R9SFQU66:W\6\Eb485IdWE75
cVXG/:7=XbUY9H];g\,;RAggER,c]fX&)0#ZKC)Jg]W&RQSD&#M+9T/I5cF_[GU0
XGbddVB;gGYN-R/UGV<Vd<FPSO+-bHA(b.F71&(R>=-)(,(Hf.5N#d56M-IHaK-H
PI0(Hf=fJ>]?b1^_;1U.c3K(6<e3->OP=&F91EOOSTf/X2GLE17C+^8Z#M4Pd/gA
ZV2f(KOH;1<cG./^JHD>?2D]:M/IdR5].fO]+TH#e<>-8Le?<d(&8)J[/XY)GM#f
AZJ<0deL-Z>-Rg^3&7CTgJbBI9b=f+SX</KA;f:E(O6X&??,=9A@[S/71BNU#.N4
7Q3N\(QcT9L\GELIIOF#2EXc3:gQ:/2]#FJ4@5B^:_/,)g=69^:)L9U3f<aLZW3[
FZ8Y[8Z3([;V.:\]ML2af(/OeGN(AIX(OW1,1D_;/+Nc\+gK>)cOL^(+SLE<KeD_
ZVDC73IB#X1FVLL\g2:fg=8D^N&@(5AA_+7/>#]G@QB6?J>&_IR#?[I@]?&2P-QY
?E=/Ad4<,e2&Ca#A3:P?>G#7aZcU9D+aJgCEdBKO<9e<IKN1c_^X#eL_,KUMS2?4
,L7;Db(WP074dH1F?X@bE/H4O51H>TB)SED(?#8UW31=?>##7^W?McHV2/7^fG#.
X<HSC-ZRC^J0f2WC:&+K81KMRN?HQREIadV(K&(aVEPKYYgEY\ETe>#+5-4)\3?@
19TSSFfO8IcGQf<4+6V[I&dR\&&1d32P&RH]WH&A+W_0<dCI/KT^6YLPd/W(PPfJ
2,==__ZbD(T(,>1:MB<b133HTbH8fC=fJ9EcZ;+86,7)b;4D\?Q^@aJHTPGf?=P/
FDCa0D?b>EBE-(1D[=>Y)XN@\1M]M85C,eCPD_DA8LR<1<R\N1G8fb6GI,>a\#-O
?0P+fNYPY.HO8PU;HeK1DB08&#KYYAESP_gf==E(,QdJ]da\D]GaYR&EeYbVE.E)
JB(3NZ5C4GZ+VQ[O.\b3ZE@O1JZb5A>-RRGVS@\B1aY;/WRMTHCb#eGY1JQQGKO4
J^KS>JX?13ZfacBKd[IbB5bg=P@O0c6)EO/@(U:<+>JTbP[),?TOGOC9/9XNI9<E
2BB@]=>ed(V]7L4Abced,??IRNL_W9R)8IW.-E9AU7[db1,ZD\dOfC,#(;UaV^FQ
6Y(P2]N9[KZ1,7>KI8W@9ZT+0Y[eV8cag21)\3Q_GH)T@838-(T#;]E&0Z/V5cRA
b;N4VP,Z.HY)d:J.&\,K<=2N3E.#1D#7cG=4X]UK_NgVG]#2<\@Q:<@4g-I0O.de
K@),W,F>BN4Ee.E1fOA/(Z##87TD,VSIX(+2?Qa--N-N8N/FS[-G9QGE9V)X>@G+
0WBYWL#d=faW_BTQ0TCWcUD>b[-ECCE2Cf/)[KB9bcO@FSM<gL)JA5=&^^K;RCI?
Q5c?+4?@(aG.YR4>1S&P&(=(<>RV>e-&W4=(KOeB=;;A?<dM\@NS9b-^6:O07VJ[
J[3OW)1O@9gEQB#&[ZUTa<\[EaPb3a.<\(<F<+ERD0XQQ_NDSNL>HbWcf2_gCA&J
X^2YDge?E#MfHH3[=(J#HI=?7V0=6-UBDgI)XX@++b7+f3C=03.(4>LG7M]SXVY2
]FJfF(R8JU8VT69IdXf>RAf8E/C(Ng]OQ-::HbFF4e9&E[4T?;>ZZaLQX+8U6b2W
IQcZ8&8dVO[(_[gG<SMUS[5[HXH+<VNXS]GW+7g8E^[XP6+;\b@6GTH>Yb8K[TB0
P/-CgG+[_5>\dQ6d?VQFa9]>?LR6A50)Z6L>LCD.)_]Q?(Z&eR;F#Q_@^7]4+2?_
O-&R>Fgb9FU_[Z)A1(0[;=<]Oc<TXEFBD)8RRX9c98(57e02a1U-T#8eF1)+9+22
G[O5KJKFLQ<U:Mg49>SO)QZOHOZOV_dS=&MU\Ea8;S9T6aDQ_^b(R&.X1aH:9fE8
J:@T:#a5))gb5M<f7(13d3+/5bK[K[++e.O<V=a3]W+(IP/PWO[=a)OKI[4NW:21
L1A=GHagcKH(R@)bNLNgNR]91<(-c&<</^a[CC>_:.b&-VBU0YfeE7\WJ)da],7)
5>a8a/HPZ:RD4WE^/3X3+LN5ZWbX8/O]-AG3R=cDaGF<JNec>Jf=9f-DEL\,EH.)
W,IR(/e.db7bP;e[\Z_\>]g\XcVBf1Q24^VLC@]]W1^B#ID<52Z6&Y>RVeQbOBYV
>B&E>QI;?d?CT\YO\D3^>.YRN42@^41,2VE27.28<E2DaH1S_V/)b/2.F(LYQ=bT
@,Y<R_:_/??YM(BUX3:1BT\<>AF\,>R2T2M5/L0VW(-]3X><+G3R57C3[N@X;W8_
-B@58Z5-+SON8S10E[WWAgWNI[Y?+&YC@-?aWP8J#JIbODS3D(D/Yg+c1)b;++eD
UXgcc.2?\Ef.F\<b)DIWVE2\aVC\P-W7.O=XdU.XK3V0P+#N=X96D3c7AIfR:#:F
H:@dAPBa;c(5/7>D(YN^O_bBB)/KbC.:ZS;D4WU31;&_\aVF.M.@>/J_+HcN>P[<
Y^.g+9WGK=2TXP/67JOJ<G;:J9^D8Z>LRJJ?c4WScWQ)KQNC]?4]9?6)&SbbK3c)
Y@X0X_LD:\1Z&?T+afe3NGdGfM99F+=#DP77:FPG=[MNVQ6._8(\?DL_YR5E2KIg
7a/fZ1FQT:/&^/T:[ag8cX8Q>a4e^1Ife8^HXQ/XK3<\VYET0OQ@]eC#C3gP16[8
T[RdTX2MT<Pd=/4ZZZ&TM&/Q9@K=X@QSOE/Ne)2FV2_Q18>B,DK.I_Fe\_.gH:5T
6=5:a\f9cdVZ(M0RNH9-64K^0E)A,OaIb4aTNZ.PZU6Be<C8XPI?5A6(B&MK8WO,
-FYBa7NRP+C>/TF3N-IdT:QWfFUO&H\Q2LQ_-dGM;Z=K<:YJ._UT_(MfCAb5g7I\
::/AaNE@C-<YL;H=F6>MS01I2&/METd?2g9I#4DY;W;9.egRYPHc[@8P13(_O6JL
@^VB]^E[.c)Ag1Y<P2H3_<bNXbC;\JSRYP=JR9-LJ\5O+7He8(.fJ?2O5K)dYG6N
^?-9J@\+d)A_>BK4dZYNS#1:&5X)9.MV+T-,-(e#6S52=_-85OY(7=6#M]BA8Ggc
0L7SX]O&:D]Vg,8[a/^b1:COVXZY9+^2FWP0DcW2fIFXg#YEYK\gU.@-DAPW6Z:/
A@WeIH+DGBH&\.#&d_0I.LP9YgKPK5^4[I0/(NV#&YNg_b(7DEEDGKH5O+fM>b1;
[G8#ABBF]X91W\-5S/f:faN:[L1K+O+CP\gAGbZ,(;1g^PGX,5RIN5&T8J1\a=/-
;)P5[2V?I:U70OeGP[+C3_Zf#UgS2:\#<cME#\576U-.]=K1\eI\BJI1:4ZRRL+R
#-T=.J[7O;d&UL(3aQ85?c<D3:801])QO/URP=EA90JGC&SX[e_^M5(GYWL^)F++
dGc3[30D9>1MZ)Q\0gM/IMIC>167H\[Q2f)QQZK&,+>[6&IDg@GM1A64ED[M_M:,
WK;<TFAG;L6?Od-,^_VCFV7J&8D^\?8BYJFTP2ABCH]&AHg6YM,DaZ8JZb.[dI5O
T7M/LR#H6NS=\P@O0GL,ZV;[#[R3X#X_.F)43YD-VaWaf?[=.O0]dS-eA=PfVEg4
2XTEG>(:I(<[C>?:+,YQ&&T<4ZS4K=?.9AUd,^]I8:EO/Df<dDcH1M(Ugb+&SCX8
2BT+C4J2S2E_Z8H@K/cW-W#GN>a\EfXA(^?>55eA3\U+8Q3S&-FN.ZWc4YW@b./M
3WJSL\3_#XOC>+/R/G9IT)DCG5=SHB=@.ME?.7P_BaGFLe^OfTQ85cQZ9#9Kc94@
?C>)d2W,a6#+70fdQ&_,-V@egS6Hc,X-X]3;Zc<NdMbB+WIP-;J+-<9-UW(^1,++
H_&].R\+W1_NNNB?[A@):b[,KIO/E=Q5+d6e/BB(KDb,GKVTD-OEW3bDQ[-M-V^S
W21_&0D1X;I)W)()@Z6#baRf]@2KH:U9,34=d=f+XTPQd2Ed]T@W-c5+\QaL>05(
HI2?;a;)6-Rae+6484>dELf5\:,TSZOeQKda(J?beG)WE02Oe]=_gM.bM:#YWEgU
0.2\]gO(XS-8?Z[<(MeY-LF@QR@ICAEB1aGQ^b(/&LL+<&0?>.L4DXbG=][4/Q)]
A=?Y,NGC6/>Z=0]R7a&;A76(DO3/AfQa35V<Y5JZC\8=[Y2=0e8S>3-AMYBf;-V1
(c-24@U6-WG(@PaG?E2?#gAfKDN#ZQ81,)F9WRO9_61<LGFH)Y01f[(@W(K;7=&^
dVb?W9,)]0M^b?Pa:)e5L5O[2O=H+OHQHX>cM,X>AE;8:@[SZE[G#\0:F==V.d53
cUXZZ5E1/F?BgUIQ);F7B4dP?KFd)90_)_6T\?UB&_A6?1[6]CFZ<VWN+<+E/#G^
gN(DTgKSUZDC:gX?NKJ2(?e;ID+,ML+/P-g>#/e&\bBe6MTSdA&KK,@7)?@SDHSV
TF5B.+LI(2A]-]ZCOaO54]2@>22MLFT2_5eeb.Bb6O];VH:.\?BL0Q(.UdfET,B7
]X@Y,01=XX[C##5>/-=cgMa[:@gD;D#97P.]g&2+_/c=)Eg&0BZT<O4YV1XIO/a6
Fd2Ka<e(-C6+:\H0/If(Q,HcQVT(Q3#6.;_)7ORU6K.KIB,96]TK@)92^c)8)C,Z
9M(TI6<Z<4>)[7RV,203ORL89dQ(8Z[Y=WFga^M0A&CbD:6,d?0-E]7_?J0X+I40
CSR:C7;4eK]I_OK+D/9)8AFe(,F2[1-_B??N_M]SR,R<=WKE+VE])79Q:G05/9UY
?YDAG[O.6.T:K6XIA62F\IHB;bVIOeR_IVaJfG29R+.>\Bb,;W7JK?Y_V2aDRF1#
#P&9E/:]WU)B:7<GVAHMc\3U.273a&Y>/^;0gMRIgHLCcQBHJ+^IfX^BPBXA?1GH
OY?g)b3/\(Z]GeeZ/X)W_\?PEbSO&7,bZW=f=b9\WcD?Y1WWWJ/3.]MF=W94E0U6
2WR>Y3J9^M79LX<If+9dR-F2LaD?N]E)\Jff68V<NI5@CI_fV#^>1GAf_aSUCG6,
bT7C_O>Z_V<LUB:;^2cJ/;Q>_?0]ZTY>:+4:-[d2)788[gLY>B;&7#;?dVA<9I/O
U:dIRIT9NgEHVQ#XYH^]Y[Y;J@YQ#/&#ecM+V4NGEYCXZ.YG35DXLAdU/-ZKLcf<S$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_CY14V_AC_CONFIGURATION_SV
