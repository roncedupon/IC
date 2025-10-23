//=======================================================================
// COPYRIGHT (C) 2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_FIFO_RATE_CONTROL_CONFIGURATION_SV
`define GUARD_SVT_FIFO_RATE_CONTROL_CONFIGURATION_SV
`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(R-2020.12,svt_defines)
// =============================================================================
/**
 * This FIFO rate control configuration class encapsulates the configuration information for
 * the rate control parameters modeled in a FIFO.
 */
class svt_fifo_rate_control_configuration extends svt_configuration;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************
  typedef enum bit {
    FIFO_EMPTY_ON_START = `SVT_FIFO_EMPTY_ON_START,
    FIFO_FULL_ON_START = `SVT_FIFO_FULL_ON_START 
  } fifo_start_up_level_enum;

  typedef enum bit {
    WRITE_TYPE_FIFO = `SVT_FIFO_WRITE,
    READ_TYPE_FIFO = `SVT_FIFO_READ
  } fifo_type_enum;

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************
  /**
   * The sequence number of the group in the traffic profile corresponding to this configuration
   */
  int group_seq_number;

  /**
   * The name of the group in the traffic profile corresponding to this configuration
   */
  string group_name;

  /**
   * The full name of the sequencer to which this configuration applies 
   */
  string seqr_full_name;

  /**
   * Indicates if this is a FIFO for read type transactions or a FIFO
   * for WRITE type transactions
   */
  rand fifo_type_enum fifo_type = WRITE_TYPE_FIFO;

  //----------------------------------------------------------------------------
  /** Randomizable variables - Dynamic. */
  // ---------------------------------------------------------------------------
  /** 
   * The rate in bytes/cycle of the FIFO into which data from READ
   * transactions is dumped or data for WRITE transactions is taken. 
   */
  rand int rate = `SVT_FIFO_MAX_RATE;

  /** 
   * The full level in bytes of the READ FIFO into which data from READ transactions
   * is dumped or the WRITE FIFO from which data for WRITE transactions is taken.
   */
  rand int full_level = `SVT_FIFO_MAX_FULL_LEVEL;

  /**
   * Indicates if the start up level of the FIFO is empty or full
   */
  rand fifo_start_up_level_enum start_up_level = FIFO_EMPTY_ON_START;

  // ****************************************************************************
  // Constraints
  // ****************************************************************************
  constraint valid_ranges {
    rate > 0; 
    full_level > 0;
  }

  constraint reasonable_rate { 
    rate <= `SVT_FIFO_MAX_RATE;  
  }

  constraint reasonable_full_level { 
    full_level <= `SVT_FIFO_MAX_FULL_LEVEL;
  }
  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_fifo_rate_control_configuration)
`endif
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the <b>vmm_data</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   *
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(vmm_log log = null, string suite_name="");
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   *
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(string name = "svt_fifo_rate_control_configuration", string suite_name="");
`endif // !`ifdef SVT_VMM_TECHNOLOGY
   

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_fifo_rate_control_configuration)
  `svt_data_member_end(svt_fifo_rate_control_configuration)
`endif

  //----------------------------------------------------------------------------
  /**
   * Method to turn static config param randomization on/off as a block.
   */
  extern virtual function int static_rand_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name();

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to );

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to );

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff. Only
   * supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE. Both values result
   * in a COMPLETE compare.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`else // !`ifdef SVT_VMM_TECHNOLOGY
   // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);

`endif //  `ifdef SVT_VMM_TECHNOLOGY

  //----------------------------------------------------------------------------
  /**
   * Checks to see that the data field values are valid, focusing mainly on
   * checking/enforcing valid_ranges constraint. Only supported kind values are -1 and
   * `SVT_DATA_TYPE::COMPLETE. Both values result in the same check of the fields.
   */
  extern function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. Only supports
   * COMPLETE pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. Only supports COMPLETE
   * pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset. Only supports COMPLETE
   * unpack so kind must be `SVT_DATA_TYPE::COMPLETE.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the buffer contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif //  `ifdef SVT_VMM_TECHNOLOGY
   

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
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

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: This method allocates a pattern containing svt_pattern_data
   * instances for all of the primitive data fields in the object. The
   * svt_pattern_data::name is set to the corresponding field name, the
   * svt_pattern_data::value is set to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  // ---------------------------------------------------------------------------
endclass:svt_fifo_rate_control_configuration


`protected
R8b>gcf9;WP1RZDLD)BN-40PcDQW?VN26051>]bC<8N/Q9?cJa0=&)UE]&V#]Oa(
DUQXB2Q45\[g\dTRbSBIR=5,F<BLK#?HM>^#8_<YR07N55DVAGXg;\13_E^d-=fE
NbV<<WL3<bHLZ]:F#:.PD9N>PYX.:-E#&?9fK9cb:d_efOEKQTI[CgD8(c5;R5(e
.e5X=L(a(_eR)0.Qf-]UE]XMS/Ze:/]HG_WW3@g6N1]g@<ZOQ_/J\R0&IU?LJ-Y3
JQYB,fF?W#YJBRN;H(<U2I\9T3_@f@.dUHDQd&Bd]g6[<UWcH@<G/<.b#A&/#aZ-
:MADU#.R\.<5L>Ld8TR&4UT+FUV3F<\d4Rg=TQO;(R0MU+1KH<2]VA[4_?DGMggF
0OR)>0a+HLa_c:Q(C7[BQ.E47-gN?(a5HY?;#M8\d;-Wb.XAg)4g+V?1@&9ZZbe3
f.c8;fR?F&87cG0JWB-K<OVNc^(;5.?4U9#GAL3\cK/C9?#;dI2_=(dI[eff&2dB
7<KB7VTeURLK#;,T;&M3K.b.72-7LD+24)A9GbbRLa=T+0)/e,503-KW??W7a<LA
Oc_g7QX]M4;\>AA)AMDN.@c][(6bL:1e)ZQ@Wd4Z1YWM,S6CVISTE7dG;]FcXgK[
7>ZEa(5Tc>/bQff>eeT0.0c]6$
`endprotected


//svt_vcs_lic_vip_protect
`protected
6BE2GYE7&+CCH;g=RU6\L#ISZ#_M_#=:J>?gT6fa;5]ZGK[cfD@\+(Q@5Y=N[L6.
+-L3TF]9)cAHZcK@Z<SHd[?<0<HKU]PV5O>?N9D.0(:.V<I#32E)bRf/#8\+HS=/
d,1-Rf47PZ<EY6a(K?Xc-GJTA3YO;C[c-=#V6H4Ye]J(dSfE&_\0.T:_L8e.0Q0H
-?2MaNf+U#,-A#=&]_A5ZX2NPR](?;g.V6TQAGNO0Y-LF=0M/?>Jf#XdE;gXTYe?
G9.31TTOD<gWPdWXZG2M2gaNgW.2LU4(GcWcY\9\deS)?^)7WM[2_U0FTZU(5B^Z
M8=ScTe_8W^0V98G>>R^1ad?676[D836OAfZ\2>[:TW=]=Qc\N=H,F8T:B6X_I&9
V@QLQXROOJPB>9QFPF@N>Z3L:62E&FPPE+9J4/E2-L.:J@)65Pad17^[0Oa;0\3U
XB@cGSa9O:(M1A+X?@^CAT2GH1,e>C4T8Gg&1I)W<KN>]-I_WD/RZ0c\JMUV[</+
6DAKbc.XffOUC0a&E/_9;,:>YK+,e1NUf[aF&X;21CI,ADC?A_/8J:b[Bca:d:?^
FCdDUOXI1AfRT0=a>NdXQ@<@>+W-ICNZL5La,@,,&b8e-.2]II-Z+cF<M4\6/DWP
&USMVP/TfQ,[IHcKN4#Q=eK@?^K.9.bIYQa>8:))BCV0FfAd;T(Sf=,JRQ#C^AY2
=a./@MFbc#\GWf..[XCMY9/YNeF)Xg;]HEF66DHCNPL.:RcM,GFKHH#(N98g\(R^
LM\1EdC-E[70^70YEJ2^4>2\C\_0R:LZPcLNGF,K[-LaZT9-VP>483<F]K;CCRA=
,d#3\3:cL3f^0KHKKFf&ZCb204c=KJfaYX:@PR@fLO/7=SZN@-YPB9F,e;XTJ&YH
[AU&W8<@EL&68GJDWLKBY/&^9NOB1f;-PN@C=:C6U7/6O)7f5@d^1JAJde1Y.1]Q
f07IO725B9<QOVBb^#)O@X<HE.83>J9]B+G34W[;?M&BP.70c9]&g\9@^A(NM17a
PRHf;Z<;3>>DI.2b.2<HGM#]Lb-O(F@a]Y/78ZF[<00QgQ/2PE=S7HDX=TgN?;T#
.DRO]4PbMYRTa9g?HWKO(FCG8f_Wc&V+KK=FW>R<M:UV0,WMf3RS1/E]ZHGV1T:&
EcMX6Y]I&+c1d3(,46B6f4F1BJ/bBHYUc&@8f1[2S/&4AX1f)7/;E,0MF6441fB^
O._M\AHPH:+],;S^=H00J/B/8P(=C]PZ1#V1X^Ka0a;\L4Sd\EPFdC)2g@^7bO(+
C^UZ[SWY;HTT1[cb#KRJDI2a-8<ZBW7ZJFD@IE;,Z+(AVRAVQM19/2.G@WIaYecT
NZ<^6[#<XHH:J2(=T4\[7dWO\D;6/N7:D(<5O42PT><JRJ?_=8CD.T^JP#M.V;LW
I=c7_B>DVD9@,&)48JcK##R135de&ZT.TJ4Kg_OAd>W5YEF\3-Ib1[=NO6H1<.Z^
Z>,NQ3O01^_M#Ma#]E1D0.>Y]C2W:08<a21fONB/3P<R,(RDeDXJ)+[)]=N@8e\2
A4>&4C5Q(IO_FTHH3+=&4)+/_EJT(?<ZdGJ#E-3b+S02PT;)FK:g>ZLW&_,QC./M
0eU2AGTWT3bG[;T_GU=8=:[VgTQgYPe9OZ/0&<[,E_RB+]VN;aJ07C>\0T<(W)93
>[Sea\<<e,IBD1]-HHdf8(;37QE^^g8gF&1,baY&dc6/b_a_I)AbZM&W[;4DeQ(;
?=b)QZ]H)@bMJ3CB\I?5a7Z/Z]S,(6RH4RcUG),JT@b#:LL#.P^aY^<<I]:d(W<c
H3.c#U>J7XG544Sg_4CIMH[4\^492Y)\J9?+;Y32cYQTe<Ub=EJ/>E/WM#F76Dd=
]L?ZaHVL@WZcQH@JG[^CO&VR:1YEAHL@2=b;BAL,KT2dF&eW:?dP9/2g(1DWYPFQ
Q?g]<R@&:^X.B.ab.SdJ]SOgMGVDEWg<;9fdN:1N:;/;cOfT@+.59YVJ=)T@]1Y7
c4fQY.QY,P3.F.bJb1AWSNfATf3<;E+.g7P9f;C3^\c33Mcc=H.\gAEL7NdMG[Z#
d=cC^4#CI3AX:J5McSX&]O)HSWK(def[)H(;NHRSa[3R&:+4gH-PGB6fDK373VHf
S0;50ENOQdIAB:H=G:^NN:(:BRGDG@83d].6d.,WC6I[[4M3.JD_76[Eca?4]ba[
:<f[NcTEeYRgY-\8P3N1bNQF^5GZ7?Z\<QM>FR3PW;RK=2;AA8M3_0]0)Jf2[/5X
\][fCF7S;g?2XFB;fZI(3=F4T:78ebbO?KE\#e^PE3L#RgC]Q;Q4]AQ,80gW73>e
R^^Z.67@8^RAY^Q-Jf0)\W]E>[^@GUfP[((,H[&=1P.V80gGBXYZ\LEf08^Q3[^<
79P@g[T3JFZNgEae>P8=UFW5R-5IL0CP7/^B:Sb596-QKKWNf5#CZ2WCZ_D&[\(?
^G3_2&NCdZW3Ib@-(CE#X70JB#>g:Q9O\G@QYdd0&B)#TE8TL4XC?=Gcb0W_M;K_
1d4>8C<83#\=AdJKOIN<18K2L#NPAQC?@IPDIG#Z?Me+&O?2dE\Z/1429DNb=U.-
1K)<bb)]G(R,Ug;HZT/TW,RU5.^(T#]B&e?^7^Q&aHKb/B3)SJD^Vfd(E?Z<:MR[
3EST+>VKEGe[-bfTM#T.#4OH]6(5NV&ce7,HH_4=_g;.^T6UA]G-,GTaU,Y&YdS#
BU=@OFT\9c8PZY-_OHAL-,E^G7]\VQR@--d[]+]5]<\SDdQLg)WBEJJe_J];->6E
CN9>,2:?O6J,^4?[B7Hc(c;;U0(\]R4Je6_GIaQb#Ie-^<IHKT0<3X^0947eIMae
(OO]RMbT3B]PDZ([FUF<4\8>DFLY<\6IRT]3SLI+Zd9I,\W>N5NFd0N/2Cf?a@V@
CCAWI6W]:-BO.F8)Rg42B/QDPYSL>WKNKTY(fPF8.,>Rc/7UH[Q>LL5=5f]6KNB9
5K@&FW(R@eX^&8d.2B?7]9.0UEF/P6?L=JR@()7MJ^ceb[01J^[2-_^d0_@cAa4R
VWQ.HQ9Q?V#5BIC.OLV+F6?XDaTMQ)24IB?P,K?^D=bMO9aP#MdJ/Q,F\S\b/RU]
\^YGFYA464Q_N07_/cCe17<+56=UZ>3+4f#XLLT4;I/5X3[O:YfUf.:BCVIC5IOd
gK/a]1@W:ca>3(@<M1f@,eQb(2KB5<AAbb-+eOIQAK2_,TH_?17,KbN]###AQ5b]
S?.1;FDX9,bR#<<=_b7MM\VdKW@(;+;^Sg:cP3^AOJTA&;PA=[Hd^G)I[6T2&AG]
PUS6d2G)+/D?F8W/==8QNU:.7eJN;T1S?:F(Z.;Xa2cGPE>/<YUPX8-SE;B9;AB)
V)G?O^8(H;3?f0Rf,JRIO0:2JU^_<cYfME,/dJL@1._IeL2Bf5HfR<1RUA^]GLL6
\OX=3WaK#86:TEGdH+,/URgCO_,J14\,_N^]=GBVRI_8/A#YP<]_Kb0.C=]bU5>#
+.TcOC/+92DWE;)<OXJUG>S2fa;<R10T-O1?T<VPQ]YcZE1We6/4N4.e0/@JZ9]L
F8[;cO>^4a>c&2c^5gd,5P/+Y)\8@)#]ccYf?/D;C2=AV1Q1NL2f8A<6B#(bZ+U:
g2E.MT7)JB3C9,UdKg#M5(8?UP^EAVL6T1e8FF?Y;:^GS;<#PA0<(2bAR3?+DH6B
AJ6;GU5>Q+YD9MU/C1VLSAbFKAN;=?IEH1Zb5b;BUW5(@#M[g;\&6F</1<eA2GU4
#U=<,Ja7a;SD[/HH]6^];(IP#4-d;8;(SN7;NIW,>E71a#2X(NP4,S#I7gS/GH-X
H[(/f7Y=ND9:_4MA6gAVP^+SdM(&NDQ_&3.^<c&cXV_:F.2S=)KH9#0:X24cHXBO
_OXb(6Q]3B+B>H-Lf^O0g]00OFXD6S[,>CVe),L.d\IN2Y=4cE0R1LfM#cJH7?\S
6)K4D7?aF[a1@T;FIZ1UZ[4-@3AHb,KbdO3K#ac]+9WI&[2(e0a<5?IMVY@VUJUa
G0UO4gEf?#CE#K[P7;S)2[3.H#5)SIefK.@=#VM3N)67(]J\cf63?(JZHQPBU)&/
+[MKKB\9MYJAB<ZB>H>YLeNg7P-YM>5WF527DIX5Z[\c.(+4(g#]fKbV2#/<FRQV
G>R;FG[)<_0bTM?QTEc@@bg.MX=HI:f]MNDRZ\T,+B]?/BKZ[Vbg[A[.?DKEW[X^
C.XEC?&I7G+SfF&?:KT3-fYbKS0(_d[(+N=PXP^TLZ</=_:9[cWX]BAM6fQ@abZ6
DCZ.X4ad:M],ceQ)GAb.0#Gf=JMVS16@GDPDD2T&Db;IU..9UAgd/<7B1#FDEI;J
f9K;d(DWF=]ZQ2fd-.F-OWS9+OePMV>8;QaP[;5/(TA:(Sa8HR3QCP^TFeMD^:c=
.47@013YZM-:W(-.M,L)CIgUY/^Xc;gB-<C@E-R-ZTB,]&RC0bgAPdK./?#JM0a?
JGY>MD;gb3D;;>KY,bc<a+a.6MTF,,A?:>E7Z:5:(Y#;8,(VT/544XgE(PQN7<Q>
K(AT+U)eO->,CXAY&+FOK/]C?4CH&+?=VX46V:F<d6ME6<dB8@QU]#J_0[&IfSRO
g?+QH1+FbRXQFCTB2U:Q>@F^KY6GG92L#;N^BEVafDZg_@MKQ@CFLX,7[eJGBQ>-
/g+2G\?3,39L9f-)RU8+MOA;&cbDf:=/NU9[<T5N7E7<Y6CEI0^a]9YU;Z0Q&2+D
ITWNPX(5WO?,V&G.cTWH2a[I5_&Y1b#:C[V^NGIUX\=&SeSFEea_M.A\S5@_>/.K
_AKQZJ(T=PND5;T__f_&a[^e;R.9DMY\Kd?QLQ0:/LgNbZ>?-E9e083cUO5R^<T,
K\/)64-+gAH.M91:;+6P1d\g6.gf\aEReXWd6g3CLDSK3FPW8=3E\:THcZa9(IFP
+0#RZI[bE5RdJ1O(ZHGUT&A_Yc2//dCY;W0,g1cBNL&HVGKe[;g0c:@(.\P=bQ,/
56;7OX/8M2AC7;#?_,adeCBHc?QgGO2YEXWe&5Q@?39aR0DW_C1=AJD66OUAOQ+0
IdO^#QY?eZ^V+P+T<,NEO>b2F;SNC&.Mabf_dGAA4?BaD0K;[1+2]QUU+97IAM/e
&Hb7cN1b4&G=M#\<@9H4=S,K_:Ka6=6F2A,>Vb_/3R)MTP[XN/Rcf:g/OLX]0g^:
bZB:-RXMc^PD/QfU=H9eWTMcLg9^J\(_.G#R,10NL#a[HdW)fbC_#VK,V2Y)2F(Y
_+<@,K=6:Ua0G]#^;PT5/2W.4PX2U&=<Lg]?:?LB09?b6I7#1AZLZc77+@R[JW<E
IFF6(Oe=ZHU-,QBO9CIYY>2/>T\Q<HeGS4?(0V<+Cf8IU2gR;-S?N94)O<QIA[4e
:.&>UO;^4X1AB3T++M6EY^?<a.2BZe0X-_OC#ZI@],e^EPdYT+?K)bHTN-P?2FJL
O-(8<=-.U3d.29XIM)K;3gX-RH7Ig?8C.eKc=370P^/NAI:f.2.dMXGZM)\PS=^?
GY6e-&8^M#8@13&]?7@]KR]1/&72Ld6f+,=b>9GZT7\.I47T.RfJ948,51^&=NLI
O:4\:B-0#;PS,K@?FdOaf7A>YF5CNT0\A[)_?@=[)3E;A+T]H:XR+?/D_,#2>#Wc
()SAW-[>)\HD(>#]:1D:fcX),/X-#S1B7]1\+,N_E.#@bB[OX9=db6RNC+cP7U@?
>5)bZ[&FWE:OA^1Qc?K=K6,3^c4ZBAUT[AWDOH58C#NW15>LL:7]5f7BHSRYU4NB
D<d<1L60.J)UQ^_W?XS8e:/LOD>^WG,IA^;G37e9-RHMDG8WK8,UI1S;cT;CJR7D
R-P8NW(S;I,+<Q,5>9g9M[8f#)+f2cRaY7^\X(c#\]S4LU^6NfCaa@]D#H&/d:dd
O(d4HcF^C=90_1P6YS_b)KY4,Q3[P5O^WW<.P3ACH-WHY)BPPN]eCT5eI?\V-[Z-
=,#;O@_)V#(A\#[1(/_0_/+9-Q=J8M,U?E53H0(Y+C.RWSM48B=De=8,33@R_8,G
S]ZdUVB8IV#@PQW:Sg_91>P6cfdY1,KD,W4,,C1EO:EKKA?1M/3AP?,735:W@_MJ
e5A@1Z__7\<,A+B.M]T3[ZK^J,XSN_NBC.YgBVLZ(JJNT6T#-UHeKLGS]@7=OWN9
L6)JE,X8RabAES&IeVT;I\JOD@&+D9Wg[3NQK^6._P>?BgbCc(MFW9XFI.>1BfF?
_QSUIR,c/.XQIDIXT3,3\C4b5M#\RHXObd7PNYB>SbCT-@c#8aKc.ST5(J5IZ2GA
C>cC#UH2UQY^SUP)3WE-_0+S,/J3<H\Vg0/I<:QD8AIXFYfVYDV>?X03)bZ#X4d=
7\B2Ia:Ie]CUC/C2I;aUcdWI0KS]:IQ-NH/3-Ac;eIgV]4b@ZaXZ[0f&>77N8R<8
bAIK_HNgV@fZ-R?[&9=b\&Df7LMa<U3E-T253S[Ne1&?S3=)O\>F3cUa?3DI6f48
Re3L[B_PUeHYcI=B\:fCQP2U/</aaAYW^EE2J(N3D/HBPbUQMO:XFd\1@UXe-HTV
MV?FX@4\YT4@Kd]?AcFe68fe79-De:PLZ>3&70MW&]AMfV?<e@Z<2U)WA-d,cKY)
<6dG,G6g9@bIN5a(g)ed@IIgJY.5g90\>)=89b)gRR75O^0(4Ae&cWP2YeD@:cCg
YY7Zc_IE<>QddaQSDL<5g69@2F/eYT0eS3,U\M>H_T<WILGXM8@VdH9X#I&HP)N:
NN\LCQZbY5g?C+2-bgM>9WS?#CXO\OD4Y89La[=/P.=I+EREU@DUBQ-;9R,^?eV]
AK(5cG8Qa1K)\>f(B0B8DI6>#9XQddFT<[f/NKXBQ@4WATOf8VS;d9CgO^J-eMBY
:/)5/#SP(Sf@I(bOb5^4:.QARI<_/_/PA5P^?Fga(PWYe;>D)#C(D+U#HbGgZ_-C
Q^5AMM4;dZ2P8FAF8NPP1QQPHC-d8eN1;E7@X8@R,#_24?9<a\B#ESK=E^__:)fV
0JRCCe23c)S8U/50+:Ia]).:Fe0AO76a\>cg\D>.J@HIb>(A6+gb@fJPG>e2f:O1
?_)1<DRd&8G<I@9[eI;cR6PHdP.IB[RY]:[+_U/cgEZ<@QUW3bXf<(U1I;X[R+;C
2aX;;,>aX7,8&[M=.ZJUUY>d6a9NZG1^[;>HN+/_&I4e>C.g>OW\00SZb0\/Z4I5
eSAY\D)QX?cO@bE1.W?U\:8^&-/5V?>K,#QdD^UDX>,F;;)YN:e>AEPeeT9]gEAO
cL&AD,&Z4H4Z<:/NPJG\f>A6cNbZ@C.[A_3(3HPA2dG[Q9/2_2,F?)A^/D(ET9(A
5Pf#JJ#5;T/-5fITG;6SO@X9;#))G,4Mc>^0c]]c)FM/MWfAcKV&gR(YK@M-^[(c
QJ[8/I_g]W8A:O..[AVJ-.E)2PCJJ+:0/N5U+,gV8P2<Q1FV.[(6eVS0F-#M7bOf
.9Q.3R31;FeP1ULGUJBC+B_.)T@.KBY90:.S18:BJW[WgLAGb)f-#@<1?d;_=K6c
WZ9=_Ib4Q\<>2>[7NH6Y-_UWN9L9bVNgG6Z)I0@.H4BRG5SL_?DXD#G)S_VQ+MVP
C@b?RMH;Y(g:[H<E;8C:3X/AIb[d<H21aLJ^^ZDS+3VJ-e>;FV\gZc,.+g1Ue\97
4;f4SY8\TAH2IDT&9<aGUe?&.AgD[\KMgX\3R\W5LP.>:G(=:S6Y\UG9Rf[:A70?
_H9[-^a5.:E/NNPgOH<W&D.gBbT+,9=AEH77PFLX/?=D.a17dXW7g;7eT+4Q7><?
fHFS_D^>=/Hb6_2S<:K8(SK2WZYNZ&acI-Q+T+_+_I(bYKIVU@[)dCJU?ZCQbJJ<
KAe@]f)O6CLKBB#c#IH^S]MT]1BC(U<QU_cc&C[ZfM&N/,Yf6S(edM&+?g#VU_@I
63Q0WYI,R,E/IfV0PLc]JK@W81(QIMgLe<AeY0fBg=[</^JB8B#R10E@Q;NBXS#W
4X0B/3G0H.LTTK@dZ+KC<02]2Db:/?LfH1&?G\-[CE9&[A^@RT+S)(TgRd:#^3de
dS7(-K7GZe38?A#.4/70g)0><GX?\]T[9#7Q[aDL/GdQER3MDZIZDL3VZ0SPe4g<
FXH9]203[\:VY\Z3R=AT,dG)HJAF3O,C+L4))LL5CR4.+_b/+:.9;?M_()3^-:SE
5EO&9c=FOX&<FJ_33.#+c<+:1)6VdGKX8&^NY#/GPG/&Z=EG7?#W/M=b.=,_^Ld]
B##c2&Q:+=0U<X:SCa;X-eb_26H8G;Me]I+22[B=Z_aID=]B4TT&V3TC;XgDFe2R
Y&A&F<+e3J/6R7(c(IKI\5+@9@<SVg&3U]6=Xc:eKce:62?X5Ra+CB.MB;7^8QEg
/XYZb6V[E,O+bNOZ2PTKM5:d856Yd_cDZ<-?(F\/,S>#YTGK,.)d5>f]D#Z5#TMa
9Q90_cVc#Q883)O-:W3CF]=e7HBG09(:F,T4.gGEZ<D9SNe#]g;>K.RS/e9W3LOP
/H5KRHa5#ECP)BA0PP]@GE?T8H[#c0D[Z?4Q.;FOFJ/2I</gQS#1\VX5VWWRO#,6
D/dKCD,JY9X;N<ReRF\T2]e^[2[Ccg^X\##[T6SH5R]ffDOcG<]RNf8IKFSQN0),
,eIg@[.K[1g&7,aR(IW\//+44N9e<=3ZVd@87)Z3abd2ZN)4N:&?[#22&OYX/Xde
BC4?J?Re+D98-7,#H@R]KX--Z5-L)SX<.;)X>TT,9.+QW1=4>PH7[V<@/W75SMFT
H6>JR.T-M:OJXG1&3=F8EP\d+TNHaAFMUY(O(,>,fDD@?fY@9A[A.K?=FJUQ0D)]
SUfJ98AbVD=0e0@:46]Sa?cKT^[7[5aFE^S@[D/J<eV4;e5R8)I(1[3T6UPU#+NP
:[8=86<I02d>>#E8+Z7#_+V56UgK,,(/7^3O;+\E(C/+N@12+U[ZL79f8BT)6,0I
adI@2@b9GL3.[5&ZbJVc>0Rg@(=eQ^+9A7Lc8OZRDY8LK658aKY/EW#T:NC&9W0C
f#XWK1FDCdHEa3&>6O_KJ>1QX;0<[&9?f&4N3OO1bbZ<c>STE#R3J.JS=DJ_Xd=7
EeH<RZdY0Z<AQe3:90XS5BV01[G00FQMgN):OQ[#PX930eOQU+PQ8eN7Q945X@>4
\T0cLJ<d\aN)5gH(ZV5J+eB3R;E2-ZUJMWW_(X?KUdNX8dGWg\:TEQ+T0>A+bb;/
&F6VO.M.ATdT)IgV1=5_bdIY->1QR@\H\-@)8>56P^]9A1=6=S.bfR5A[#HL]ab1
WBM[V@,])J/J@P)0bXOO46HZK4MN,Y.ddHNV.9BD&Y/<+99G+VFWSB;8]@NNdU3X
-(QD)R;B,N4FGeH1G[aCVF_D^B5OB_6L@3ZN,[F&1CTR^D+<04)B044,3L=aX[\:
_^)Df@;[=[6VRG\3_+(BgFJYY\>ZH#aWe,KdO7NGO:XOT9GQa_B;,7]&)YF:bI_2
6:1S8[&P#C.;/F3;d]SZ&=-WVJN2=]4OVV/IKI[FRMRc4ePNEYf,Hf@4EACD5D3H
SBWE1+602148H&U]bTab_[d,9^>#gJ_2ACM/[OL@E?9WBBg^4U1R9Z9Z.0B.YFK2
Z58R8V0@[d11CS;<b9?GT,cV:2-GL.N8)TcNVGRQN5MESS5HZ^;F]]5@HR>>T/CQ
#BK3FYcTY#:Q7R>3P?>[-PQ.PCGUHQ(Ea+HdDO;R4cU&eM-FA^PYZ9+)AH)B3fCf
Wc=/-FHOJZH#IUNP8]IPff;DF27eb688E7B1TR9D?;^RAIVFa.-:W<R@5eRZ1bJ;
(>TX;VK/5)<+&bWKAATYH#.GfUSRR0<3S:D8QWLcZ26.0]SRb5A2K(Q#OK6\JH3K
C\]6XAGZMTB9fdI7><ONE2M(:.[N5ER=@UDeG63[\B>g?e,/<L?A2BR,^O/DbUX6
gO^[d_=FF4YX+Igf_]G,aJ#9I[8:+KLC)>):>Q9?dL3NaNE3&3+GCTAOP51A:VPb
]Ke(e0FYP>73b0X^b8Q,W&@-B9/9DSB9:D1PLC-g[V&XF:UO9G7WG5/_b+GZZ\^b
48DLX.HT44P.H+b1K5[SGM[QS\=]4MG^T?_K1Jc[QGL-HA1:b#ec)>N=R.Q->NZY
L\[C@XR;g\9Y&^4F156DFBGF/93CBH312B]2PY\2S0:(#:1Q+58@5NMLO_8a]M2>
K+8>Fbc4&0XF6f2N<e:dUBL<(Q:6cGY+_[g.5V1VdJ>:.#^Na34^0;&JT8\^LRcU
9X1H\gN+ET24V[MHKJ3]G[b(RHPGP<.aZ4<)dY#.c96(6AL9V?4SC^).g39/77Z+
)RQP_;I9eW>;^Q72eEc1D@cRa>N6L3:=9]=>T9P[DLEU2PZ:^TTd(aMW&g0E/1_^
ICUYFR)6H4XRbGI0KWgD.N=3,dNFSZga0Z(29-:NOGJA=_WI,UU?FeAM?<#4@N+Y
Z]<G;RNQbeH->Z/O@LB;gRTdZ>&^7RBgF/XVc6?6c,DZa-S._J,1V^BEQBdeU.[_
N(7abLMVAaK1AN9H_/e?R(-^9a>[[^GDV,0KFVT9Pg&<2aJRN4FJSLCUPc>3?.Xb
SK]Yc<?fRVgVRCV_=X\P,YeMYa1F2.8KM9QMP>JfS^#T<-=?^4?cd(:M7&;U:,Ge
5;J84\a/[(DD\HRBf)D:^)c1FF\[=BI9JJ2MX<e^f]/_\,CSD^bKL:(GOc8F-N6.
6F.+S_\\KJ?.L\@BYW-5A:+WfGbdTX84Dg,C6F=RDO5T:XD)3A)3?.PTE3Fb_Z&.
La#22eL5OHRbOCXPBMF-dP7_MLV\c+.+fG+9N)aD?SeDOD#.)A6aEdA0T,X-c4M&
c+(@(#D7Q]T\.8^>4C/B^P?[F82&8.PFTZQS&+@eMDO]2.;MG>E.:N(8E4BXZd&N
bT;;WAc^>N3AWVC]_]gEP>BGG))(XV0D,+UM-6JdKc=KeFQ./VB]BZ\2+?B2QV];
/5G(a0Ab:<NZ\@#CB@X=E;:M)L&011;3M5B3GESIBS-YS?:5)P^4JX.b0@T5(T,X
IZTQ=c8^KTY^A?4VN(<Y>-,7/,Ec_[<NM)MR]5-b@VcCCV]CR9Yf[;F_U5/;?F\[
@A;=QPG/&:T9B\0WIWDH7aF82K4G=IgP+5d0)[UgMK#gc\&9-LBNgI4]>09+VTTf
Tf0@[1/SG-)V\A6\:1[(36/KA_V;Z@0GOLXaK6N:ODWHf1L&/QPXYUT:MR_>Tf5[
8Tea,ESPS>6VL+C[)9_\If^4/=]9TPa/3Z2:Y3Ca_4,CE#?fJ_[</]NYIe??]5[L
JLW23-3>5fLGY2Y\2d)TN;:)8d_DAgNBgX#H3VcE4VPZJ4-61eL:+d(-08VFEb[I
a.,_13VRR:Z:e<GG1/(6G49P6IW+L-YS+fX&0I\Pe.acMab(V?(S5fR18T0K5]L?
GM0\5:EQ.N4c=DZF+]_d9\H&Pf_]9CK#gc+O:NW_Qe[D[J=f+EE)BA.S2a;N-^^C
f;P-RNAWG0,+O-P&7RQg0(_-TO(eVf;DI]RW3#?dXCLQJ3-9,](>gaeAfSL1.:^A
b_a05=T3SHZC]g4>9G?gTY63\>KCF8JA[Y0OS2+4OD;&YfA7:^N-8:?N>5)NC)X<
7WKc^KdI\;/SSbaVS42VP+.[VDYDNM\]0(3Q(=WPNc^6N\_G0V2YDANCa@=YJYVV
)]Za]?]\?607=-WDM6Y0LUN(R8:@Y3bK3E@JJR@>P<GDfTJ<VT5PD73JO8(HY)d=
AJPfg)P(WebQN^C]cb>U_#gGg#Z/I>MW_g@fdW]BG?Q?_1XA;Va681IC3U4XP/:E
70AdZ9/ac\[#30Z)edV3Z_@cK/J^NT?\(?PXHVgbRKH-^fFK^HM50Y>[HN5dY,d?
\#_F-=&XA20Me.94B3OQ.GL-NMFUPDbGB6K9]3@W#g,Z>>2T5;>(M^\:W^+#C^Be
NS6ac5b^3=92-,WF<]3BE0H,Y;7/C8Xc19Z0AI<\+WVA;@>/VU\[XUYFZf\_)QZ+
2(,)H?#8=Q&eE09^C8><dR/EdCb7GQ\cALd)BV1[eK>F^&A9YIN<.&e#&3S:4Of5
-Q?&7c<2F\fLE_MfGd>@TF11F9&:5H9Tgd1gae&6@<]FDP@I:I6C[cC7<U@bYD=+
Aa5+]Lbe&_6H)8^gYPMdU#5TZa,W>2:NQ]N,NENAN/43b[20SMFdOdK07d#LdKC)
gUHW(R)++>(CB-BTA7?CG<g;=5@N0E&Y?_\@-T&aV=GFbE;e69W3NOH72]fbfTfD
V@E>&(5GO305bYL))4Q</S/5M^TN/.N@+JAc#_#S1<=EM=c@(DJNVL18K&EL#ZC8
R]C[#T+OgYQFED_/:BRB(35(1OS+YO.>.C38UBFTTeLU0Z#29<fH=1^09I/O44Zg
[KCHFW(<1c9c1^Z-KdX.&=[f)=XE?=S5<+LegKNR999,bNH?_F6]U\K(WKIAYa#Y
E5[R\39]H&QC>a)/F3&(LOC8V/9RG3JBT1K2d5AVB?W3C;637(EAQcQZUc<)6:08
6953,U8,TdRKCfR3QAE4#.gDQ&@@/SN[L)]G<IRYA,YIObJSd)?L3J.I)K8#WV9+
R./IOVfG4F8R6[TNFFN,-??2dN6]DA:\-M+94C03,Z-L?,aA6BBe5^Z_W>8^5,_H
4X(QP[;M?/Q9=e;VN5IT]Z^b3_/2#(IPR]=/_BCL=HI\3V(:]R-HOCJT^M.YN0>9
CX6]@=3eW6,&]DGSO&;)T/VH1OM5O49XX+cTOC(7FaL&_)6Oe+K:<,+5DV7M:B4X
-E->>#EUS)@OW?YRZ&940A+A2\(SdKOWB<,1.#QJ-I@8BfgQ(>4I);\T/T/#15[:
;:WK1BVCK^g:6#..f@2QaD9L8+d^#8ag/13YMWE=3^0H[\-?Pd9P:;O>CQ\1]e5c
/TS-fePeE->S/,V:Gb;&XgM.e9I_4R#91DGUS+/e>X_@CFa)d^7;:R:\PF00@dZ>
dN5C2#-0<U^B[<03@R]Ve82M8#Y>7gW<HCHaR#/K4eUU427ZMGC<A2f(O2IF<-DM
@QI4\60Nd=?(PHeaUJAPF>+76&H#Va2\9F]&.^Da359O]489)JD[0OJ9B997)_dM
;BN+:Z4P7@Pg7AKbTW6/VU:B(\MZafPMQ4FC0BR\Ub:S=2K[M,&_1J5f=20U>3&>
XJW57g@7Kg>G)89BTFCPE)\KUU)IRFA8F?_(>L&)@B7;Z4SN1gb]Zb0dP89^6a6B
5HK\gM^^F5AMIc9+;B(8U8-VK(R\d&#GPG(=@7#XF8AT/AKMTG1G25EW6YIWGgbQ
a>_KG(ML@EX=#FS;;a)-a:0Q2IXXQ_HSNeaM(]MXZ5g.cgdIM8U]514ZeAA-_6-O
<_2.&)FL[[?L5cU\B]AB1b>_F_[Sd2FE5PCR&<SP2#(3;IS347MU+d9PTg22\G+X
K=_B?cTFZ;#N0YLRZ]&=fC\COJJYP[/Wf3:)eGW+[K?\cQ6f:I&IAI4>NQ^KF=:]
-YM#L_]+DU[8ATO)1GUKXY@7JU)BCNL-)9YWL#_+]:(:[^8)JS5Yaf87T:L/71AN
ga^E,Md6^fD;(H8cJPf9bBI[@-efM[fIRXXA0UW0XP#VU#>BEB1]+F;0#QA8DBP,
7ZbfZ(df9F=W=[]#Fb?agc_a[@Q?573Ef0)@B;5g^H9?/6H-_9/ZL=I<I+Z0DUBK
d@A2cP\=6&#:BK@Og&(XU2KfDS.\O;e.\ZG/3ZF9/:ZR/3OF6,/ND/gED0+NX6:#
.86fZ7H10-/g<:VO&;BL^cW69fK1Xe3T)feY3f05P=/b0O5><2]D.\cXAU&W6JLg
C+>&MIRg]:MV^ga2PS[3MMZM3eFO.dATTB1_R\CX(7>9<G>I98.RJEM>XXW>O.gF
RIL_K/C@DSA3F[HTb:>HNH3^\\[Z^)#EL&gdNZ3,NH>cCG3FO:9M,SBRX59HOf(X
.>H6bg\H@&&Zf[O)LM+F\=EVNf71;0BQOeUM&N1>]bKV-I(\8<A56KG,299g:T:-
a,XJJ;K@0UIAMAQ\(DZfY?2\6C&L)QcY@eU6?1SK0GTa4f7G.WGaGGb5+L5NHZLN
UEW>.dbKY2(c6/0.<IK9HZLQ#J-F8DK1OX;V9B;@@7_^[#7B47P-M<8\J,\bMfSE
MR./TZS,cA78K];=?>6bE0&II;Y^dOT@JK<&BbRDDGdB/7#ZSJ8YY;8d\(C604))
Q?;IND/[@fB<4>YNSaPgaf9NRRJOZE@6?LO[5+Y(aR(:;H]GRPT;>@AT:QG8T<;E
,YQXYM<Q9M\ELaX761d7&aV.]e.K\QP@(gHK>T,g6HB_eHgL^>X_EH_B.]>[FGaM
>,=?C&_;@(1C:_C)cFeX2OgUTWU=^c(YJg^@F,OWU)@?O?XEE5_ZVPQUOY2dQRE(
L/NG)G31UBBI-F=4JfEE,dDP??\,=@&Yc0H0:UZ=SX1BWJUR=D(/#:Z70?e:)/RS
PD#EVMH=U]PR7b(E3_Q9O[CSfgE2_DBXH-3<&BTH&/7O,R,=.#K0G9#EUG(W[1A7
?Vg_8-]BMQf7^;D)dCR0RS@2@gM95R;S.]eZ0G8?81@E6Z3ZcUC2)9?Je(GTb+.f
ANX:gTfFZ@,RE<@15G2<<VW9>H)A4].GO;)]R\UT<2KZ:0WV(\A00.V_Z7,O5EL7
?WZ^ER65DSN@>>FJRc14a;7C;fLOb=(LUCF5_WR0)bQ7A2@UZZBOH=C,NR@ZWJ\/
AY.[e+\3NGW7>>\72D:eHA]a)X5,P?4cI^LKTfBPN/\+)\SOgU_1^,T3?3^6e_ER
LgAV>VQ.9Z((4IH5UF2J(E>3^J,5b)^90A1<<eKc/0JW/DSFVO3(M5IIZ7Te@;,e
V#f=Q@:d_=^E#U+W]F0M\\Z^ET/&e8^dab9)(:\T#O4&73RP>dUGfPfZ_1VH(gJ\
)7bUA(_.6TRWEHN^#WSI?K<Oa/;<SbfFZ[J4\I,G]bPe1a??F14NW+1c@D\cJB^Y
(>ZKA:/M^VE#C]NO2A@8T8Z]818KZ\8DU;FY#_R.Xg@U]./XM&;<@O)8>N6c@Z?H
Y9_T<RL+T)Q,7BJ/,/@c=>,->]]dZSVCDOLX_],S22&,#>U:V1+[\&)fFEVY.I\E
ZQK)7D,CSEX[1YQUPW=Q9M\A)H[:+c3D\5K2I?<0e5@GWJUG4L,Lb3XIdW;,D/:4
(KSbU42TJLNZU&c49S+01=;<SLL5&0LTIb/S>P(.@a93&#C0BFdgJe/4c:HP[XZI
+OV<BUVVW)\e@]GdUO5S]BfbW=Ob&df-B:ROa1X-)>8^1Q7?-4]Qf9R+A0?WefRO
^2LAB)OG6&]_U9LUS6c-J:OEb?dJT[GCA;N;O:MXcB^;@fA1Y(I>D5H2b86:+[)-
Jd=^Gf(eA[U69IJ_KZ+GIa=df0K\<Z=IWd1@VX?Wg>?2RJABaQ_Q0<NHdM1TK(]:
BOS^N=46]2be7ab.RX:9Gf]X^I0[D[7(LVK3g/CW,,e:PUX1d&#+H#e2J2-Y7BVH
g8RVReP@70)25(1CI2\(C4X3_WOPHND17=M?U0DSZ@7,S\#O.^[g(=\#cYWN-<JJ
V?YIHCL+7aeN?\Y/0-RH,^L0F:S<<P4QPL[+Tb1&NNDb@941Y)VDU-X^]#Zd?8]B
CObOB=6J&Ka4.71ASJ:@DdeS1\40TG8Y>D56CUF5bT#g\fJW9]FZTJOCFSTRBCAB
/Y#^.7HBZ6[;VXe@Tc6S5KF58NgE+#cG>H:U)3^4]7?#JFE5LP5H?QGKX.US0?16
bHX9F6/a97HYQK#@X-0[XO>SR>eZRDRY#;>WC@_W6#^I7J\W;0Ac],e<R2#\D&Z4
Nc2e#<X(cLMOQX^U,TdM?152[Y0M=G;Z&6[gS^IB1X-/+2KMUR,dgK^/;;Ygce3\
\/#f&^?_UeTe,4Sda>Q#]-^\NJ1@)&8]fMH/4]VQ/>L:WHe5fT/fcKfcH;fV0:4S
=<(VFZcdNW+b/XB6:7KV>62NO/K>J\.5\48&]^Z@f7T>;g>TVIZBgOGdS\BH\=fX
MYGgV8Oa2e1166ZY.N6gRWSV<CO)aN7:cPG7a(T+U[@X@RV?Qe)7EL/d/[J,V;3O
#Ib2AcS+?d;,L?ddZ]eBA0,Y-dcY)<Z<CEKJ5R?IJ79P@V^eY.39DV>&MaF@Ba>S
F[6EIZZb+P_WG:#9POfB9K]-HJ(8/<&2O<8X#e9dE&QU2:@K/)3NOWZ=U;D+93X(
G[JW]-_VdTA,P;ZJ.Z&N=.YKY:dNFA)]#7.^&,>H4cD,D/g2OG.eIPN]A/C\XeTR
66W>e+e-[\@/E]VS)2e_V:0P/?3_M1V9+B\GDCX0N,HX\O@7.,ZWaTJ^gU0-2bMF
IYdKU+PA]LfTTMGef5fQb5fT0(<F(4KU5>Jb2_S-MaJfMTIA=SSa<PW_Q-YQ?AS9
A6<aY#@&Bd<^8(-GY>^RYb<19@HKAAH7?.4U@8>c\^b0YXLQMd20eSEUT@KCTe(;
RPUd0IMP)Me-PPN:^],Y5<M1FXWMYLJAB#A=QfI?@Y>I0Q+0Uf]-4TX?7@5RLNF6
_]^S/#8SC9g\3O-5?gT_.Z,VeE27C2EU&I1Y6W^5AZ7D]>6<2HB0Z\&26-W6UDdd
E:D_5aY,dYEcRc5EfcM(?9)G3KA3>+=1d:P?[#QQK(QE]G\?J6P_N9@UJS-Q+&a7
0=&L0;4SFK5U-fJIJ1BD_)e^WUUAIY>VV0?c5[^:<ecGAK_KN&^0JLZHL:TbR=N?
gRXdF]9Ba.eKI90\L:Ng&P,A?O#@6NYI10Q<\+DJbF];G/b^#D_OI@Y8dIL-:M1M
+aGK5WB3Y4c>cQM::daE]f[M?Z13SVd3WD0]+2;\&:OZZHK,<U0I^R[O?g4&9?5]
N2UMRR(F;D&,A4->U2;3a#Q.VPB;QYP3+#L+>cN#G>8&37AVFWKW9789?d22E+9J
b;382B?ZAYLIT;EIU&:OK)QC_=MF^=UG+=F4:Z;4a1.\,76Ye>@8NXDA4cPTPWQ+
<KeBB@0KP#gM\faB/]3BZ(D5,36SfV]+9+OW+.E0>GZ:8fdENNEYb=PQHCI9e_Ra
=;YV6E;C-3RWYLQ1AU/&>;P9Fg\/e@O_^GdXU7W,XQ-4,7M0Z8<#TGR3g@X^eNEW
]6W;119^FR#.0Z>-EEVUL,X;OBMG_E(8DV/c+)+EJ?7HSK>5L[]\JR^9;_370/K]
af]4SY\MgOI/f#?b)6GMd<?=@cZGWH2<KRRHc7g/f?\ZNT=aUf3R\1/D8H7)T6]7
GGYHO?RPMOecUY^5FW4:7eDN)B/C(=R;G0eM(?SO+YE2_ZEMbIYM@g)TPM)7\FJ\
]X6@-#>N=L3K).)J</IfX)D[f>;f8LHJ&7UE0/KU_;LBa9Z3Wd[6L(c03+SG^VO&
<XM8MeRY]]g0&=Z=FBaC6;XNQ8a]A,^QY;N/72#Z-1Ue<W8L.?=ZJBd/ZP/<T(,1
G>16>9MY(?RT4X=VO@<YEUL(UZ<HQ-PC:QaQL\E-#9+/3fRe)20^R0I4aX3A+)-.
-aY?(W.)L6@GK70QJR4JgTf8(6T=:\VIR]TCRA<4[.D.;6#TRcUZ140NI.RL9BSS
F^SOa7_>B-@eF]=;L]@CcKL_5TU@5HFO^#VGdP,\f)#U,6.77LQYcb^@d6]?MC-U
e_M>0:?49G6^?D/Z>bda,>-DODSd(2=-VT(TB4:cY/Y^-:[>ZcPOb@-(D&Te.64(
8<R3.-)SY9QDbPKE?IHG2WE]>679I_:fAO54M,)(Ie>4B>^WIFLUXRffI?-NTPBZ
Lc3)K@T=7/?ZY_=S_#DNfa/Z7P0daD4_J3TCeP?60a9>[GD:@R,05,]05BW+.EKV
QaYYS]X:AdWY(YCGQ=eZE71(a0HFN,Ce_]gO[fOXV)d,[-5OUDeTS^GT)YfJJX9I
ESL&LH8dgca[f@Y&.8&GN;fB88(CS)c1<9N[YDFLX&HUICb0ICO(R3+E@:_4WOg]
;bb394-OcRf1Bb8J]<fBIK1(GC5DFIDZ1+2;VN85I12@@(BUAB@3AP^-bP##E_@6
Zg,XcdM)\>.AL_88W=L.6g_0VYKPIJ0RYBI));5E=#UI(##V7VFL>P&L]=_HK@g/
]>(FX2_I:LMf0fb8G=Z)_JFTf8)(&6UI6\KYB/B&,,+;f4I5-(Qd7BaEQX:O645B
:afN:(FgJ^O2.8B-NQg]XQg\1[Q.6GL8fN@TF\_4;FHdW/X=[L/.J-]KLJ00X[B:
(9Q>SaXMGT.8LA=JDS<OV9--Tg06[\R>Y+L;21Z<AY))AE+B7MQ0b]2+<ELYOTK+
-aQ&)\KQ.FTO-_EP(YDZL2Y442R)J#a6AFO5G7[(^>K^@_VW[LCO&)K9COGJYW0+
1@PPM=;DF;KS+IcOcOTVD-JRH\8?cX4TYF=(eYRgL2JV]X?@9aZ>^V.>BWKXc<F]
EDMT>((Z<P]PG;Q+<[J_,D^.A-,3#YPgZO:69+)EJ8IHUTYTE&3Ve)NW_DXdSd>X
I_M+K1QP#IdT6Y?Ogf\e2Y0MT=1??bC[Y<aY))C>dB9T#/LgC?0_Mc4d2SdL5/-U
L[JO6Fg(cNSXWZ>DfL8A>+5_[S0JR>],\M,7fYSD>>LRGAZ#/Z29F>C]<6^3eL/K
HgCD>8R#Nc/#\gf>[>^:WZIOY.S0,L-B/QWY)GF.1U.5=@fO3JJ=bfIf4^0JLGLd
S]ea?FfXA]^_)>77+bF?8SE)?^Y]M=:b7g=bA;<TKeNT3A.[2KUg-G72RB#b/4O=
44d32[,)3TYEC>8>9+5a\/<Z@S:;](RW-((fZ2,+\&GCW+R;d>QYEA)\7KXJGS][
.39/+@PWEa?_@<0\:]BbMPT:.RRPBAaRX(Xg52U1GI:6V_KWCGaA?F=Sf\G(]8;I
X6b<G#JB4fc?V5Z_14g5W)Z577dM\ebOZS-/TZ-,0[9-PAK<3R]O2?IQDFB4+HF8
FK-4.&H06T^5TJ^g\P99abUfdDR)AW/P:/(4.e(9UP?\Q50959Y;>,U7^,WN(F(=
HfQ.KM>F]0#.S,5(?NWfReBT0]II]_Yc0Z#<R,e/W>bb>W1]e4/dc9d/)YAD>PPR
CX.4@2.e,0?L1A0d(G1.M<O5HB84a@33;B<8_CVI=B<[bgFL\=M4I<QGL]9[^CCb
>F_\9ZTSaeM5M7=ACP(-IaMOM<9>.a.?K.g;)0W?O>L]1@\AS]eM=gPD@G4J_;1[
UI(PKf&fPTM@)ED3MeB4g-4[e0Q+-<ZUgG,JJBN5>QQE;OT_WJe6Yc(6.1:KIY@Q
eP.T9,7P0C2]T>UEOK[ZCE)&a#G[(cf:8ce7.:X,b0#HE?F67:J@U2(I,-TQ:NBZ
?c8CM+(7eSIQ_@Q<O>M_VNd8G7^7dFee4EHfQNI?.Cb;/>X-#\)P-\d9MbCA8.,L
EEQ&&R+IB]g0RAO6<4;?JH-=_Y@L9e[88I[/Dd?5WL/(847aALFJR^gbc2-VJ5Ye
X8PZgWKU^7>UU6#GeO@F\].6a,SgR_>/8GdLc4g2cdVf)@/bCPZ]M_JJ?C+YL;Lf
5_RB;CcY)L(F[JSWB&],;)aPSU=Ma56YF0PWeC,;Vd^5.X>^R>GGSagLEaM421B]
61@NP<E<8H2#3<)J+?/4CbX(E69S-EJD(8/X.E[g+OfgWWcL?J7gT]PW4NG-Se68
Ee.)GCGbN@5]A30OS)-F8\W:AeMU]dbMG9<f4#P[WfNFYfBPF;3@D+_33>ARcQY3
efgfeIR?PWNa6(4U=+W9bSQ5Z8M^G.I7VYFeJJP<J,)IF;0^>7[WDZ:6bV;fd[51
V47@E76T#ReN)]1TbIBXd\WK=T)+T[.g,\A)LXWJ+T=,W)N1+dLIBe?M087(6:7c
Z6FgKd1;7#OIG,&Fe__[_ZNC#+HSHd>&3&CP4d][cJCdHWM_Q@Z;^AH&Q7JNJ^LH
1Ld>3]bK;CL2M/H_9e?e=/+H_TN.8a6ca#bS5?dV.2:G8HCfa2RCGQ+YeX^R)[@R
-dPXe^7N2?W\5\ae8(;Y17_NJ7&LAe=CbE.g0CQ;E4d2BY5L,BS(Z8FC4E[OIJ6[
6)J9.8c5X?N3>?8d:a#XE7HX5I^f)(+&f9@3W.O5?L=cfdC-P2(U(3#8=\,UL<34
#;SF2:@D3>YdWQ4+Qbc\Q(A4WJ++NFN=@3c22SWbg03eIN9:&M8WabgXVSNT,?1C
(QM5\@UYA/FX=IbZ3>b9>La=BQdcU9.Aaa>9P&36fH<RV^>\BC+G@35\WIL_0TZX
V+B1U+:S[>UIcTB;2KX.R5A_E<:RK+TRW7.>bF:Fe85PT8W9>P.F9cJU(f+9g&]B
7a]+Q&]MGZ:V;OXGW\7gQbKE]=B?_FX]-ReX(b8?]RMTO:9D4W3d>cJNN-,D7N;^
.@V0+^X00@)AT:&99Me&3_T_OS2U>A2CS20RaW>P;,^6E9D^gEMCWX9.cJW<1]5\
=<(D<:BZ2/eS]E++L^d81_ALFgISD+b]7PV-,O/G/X[/8ECK(&?O,LW0_NBTC^@<
N<[[dYaf=#0&5SBNB(WVHAg2I;=F4N7>J16VMYLY+b6V)a:ET7+T0JN1V+;/UXQa
TA8HRLMQ6<4c6).2>AGY2I7A4,^6@N/+PbRcZ1cXO,F5(AF=Kc-VXM2\L70Y,8aY
CJ6d8b_8F)Vg8E^;.+(\/IM7Z+M?;BD(c(YR\&8QUJ,4&fVTPU7a5EI:G:O=?-eW
dEJ5@71Qg&KYIXZ^:WCa(I#4A_99F40Pb:A.(U&LFKP/,31ST6:C.W=CdC4M)O^d
_Ib_FB0LFSMIDW+H_4G(cAf7K^I;^?)S4:2cBdA)5/C@VY]34cQ/FO.g9V><2]J4
2&<0BcZ:,:A<C;^+J3cPPOfK^E][=8?abWPNXP5WHKE?CO>#Z>JGD@P]\KJT]M#<
)RQCD[XbV(20;Q6f.^G=G#?e00^@&=9/88O;f#+:_?OME&^T0XTa0R+W,c@+f6C+
0D+NJ7a^e&gFFZOe?5TW+I10)<(+ALFQg<K2)4SGJ-UYQ78B4(;Ig76I]96J?R-1
_.U2aXa#d/9><G7TL#e04EQ00\4D99OH(A1P/e/9[6DNUE<Id_<^DLcZB5G<d6]-
-I<[c\[d\3)PNfFBMdX.Y=X&.;Q+Bc50SfAVQL[Ma:?-DRND[8V#e17W]6D:T.6O
6?63fHfH[&-4<-(<#Q,d<K91\D_R0=::fFY1=V,+,J;OMR2_BF6;P(N]SDOH,\GQ
8+a;(f[cT_:Q>g;AS0=R5V)1#FX/Z^^<Ac-54&1JJO[I)GJ#8NEI+Z;1G(\Z3gR>
^PD<C5Fc&7VF><cS<=(UeW31V87BfceZF0:7dT;--4[[R>c(F,XV+5;1M$
`endprotected

   
`endif //  `ifndef GUARD_SVT_FIFO_RATE_CONTROL_CONFIGURATION_SV
   
