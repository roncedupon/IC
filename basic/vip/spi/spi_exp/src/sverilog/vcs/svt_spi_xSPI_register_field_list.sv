
`ifndef GUARD_SVT_SPI_xSPI_REGISTER_FIELD_LIST_SV 
`define GUARD_SVT_SPI_xSPI_REGISTER_FIELD_LIST_SV
// =============================================================================
/**
 * This class specifies single register field of xSPI Register. <br/>
 * It encapsulates field name and its default value, supported field width, list of registers that contains this register field. <br/>
 * Member 'nonvolatile_reg_field' holds non volatile (if applicable) version <br/>
 * of this register field. <br/>
 *
 * Following register fields/variables are supported in generic registers: <br/>
 * <b> <font size="+2"> Field Name </font> <br/> </b>
 *  1. write_in_progress              : Device Busy/Read Status             <br/>
 *  2. write_enable_latch             : Device Write Enabled or not         <br/> 
 *  3. program_error                  : Device detected Program Error       <br/>
 *  4. erase_error                    : Device detected Erase Error         <br/>
 *  5. dummy_cycles                   : Sets Number of dummy clock cycles   <br/>
 *  6. quad_mode_enable               : Device QPI/Quad mode enables or not <br/>
 *  7. octal_mode_enable              : Device Octal mode enables or not    <br/>
 *  8. ddr_mode_select                : Device DDR mode enables or not      <br/>
 *  9. io_driver_strength             : Sets driver strength                <br/>
 */
class svt_spi_xSPI_register_field_list extends svt_configuration;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------
  
  /** This field specifies the register field name */
  string field_name = "";

  /** This field specifies the register field value */
  bit[`SVT_SPI_xSPI_MAX_REG_FIELD_WIDTH-1:0] field_value;
  
  /** This field specifies the width of the register field */
  int field_width = `SVT_SPI_xSPI_MAX_REG_FIELD_WIDTH;

  /** This field specifies the access type(Read Only, Read-Write) of the register field */
  svt_spi_types::xSPI_register_field_access_type_enum access_type = svt_spi_types::RD_WR;
  
  /** This field specifies the field type(Volatile, Non Volatile, OTP etc) of the register field */
  svt_spi_types::xSPI_register_field_type_enum field_type = svt_spi_types::VOLATILE;

  /** This object specifies the list registers, which contains the register field  */
  svt_spi_xSPI_reg_field_register_map register_map[];
  
  /** This object contains the non-volatile copy of register field  */
  svt_spi_xSPI_register_field_list nonvolatile_reg_field;
  
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
  `svt_vmm_data_new(svt_spi_xSPI_register_field_list)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new status instance, passing the appropriate 
   * argument values to the parent class.
   *
   * @param log VMM log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new status instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the status.
   */
  extern function new(string name = "svt_spi_xSPI_register_field_list");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_xSPI_register_field_list)
    `svt_field_array_object(register_map, `SVT_ALL_ON|`SVT_NOPACK|`SVT_DEEP|`SVT_NOCOPY, `SVT_HOW_DEEP|`SVT_NOCOMPARE)
    `svt_field_object(nonvolatile_reg_field,`SVT_ALL_ON|`SVT_DEEP|`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_UVM_NOPACK, `SVT_HOW_DEEP)
  `svt_data_member_end(svt_spi_xSPI_register_field_list)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_xSPI_register_field_list.
   */
  extern virtual function vmm_data do_allocate();
`endif

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /**
   * Does a basic validation of this status object.
   *
   * @param silent bit indicating whether failures should result in warning messages.
   * @param kind This int indicates the type of is_avalid check to attempt. 
   */ 
  extern virtual function bit do_is_valid(bit silent = 1, int kind = RELEVANT);


`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Pack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_pack(`SVT_XVM(packer) packer);

  // ---------------------------------------------------------------------------
  /**
   * Unpack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_unpack(`SVT_XVM(packer) packer);
`endif

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
  extern virtual function bit encode_prop_val(string prop_name, string prop_val_string, ref bit [1023:0] prop_val,
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
  `vmm_typename(svt_spi_xSPI_register_field_list)
  `vmm_class_factory(svt_spi_xSPI_register_field_list)
`endif

endclass

// =============================================================================

`protected
ZC^5;I7MR>gIedH?M_V-BXgYFMaSU@F3>Q0V2CROc#R+RJ6+a+:0))<5V<3cCAbb
Qcc-A0D#1.\@8@V;H^a&OTKQeS4PL^4T0(aE?#X)T)2P9957L+TYO)dR;SILBUgK
L6WLbH)T?a;EX==AAfII0UCZaQ^2R:=B]F?]WZff#/d45bNKdP\MTHZ(5U,BgEE:
=:9a:#BB[_;,:gL=XddMQ95EBcDI7f_F6:0N&K+67LNL,4DbJ^WfD+UU3e6)8OLI
7C)ND]J9C68[UX(G.C=XI>Y2+]BcUFZI?da(;7(UK[VJ)R;HD0Z=RD>S[+DcYX_:
[M5?TTJF<7\\eRCUML=b4.>A-:>\S]^8YZ50TTGKTXQ[HfF^WZSUD78Me:F(3RDa
,?U-XNX&2L;T49H[-L(4_0NBUa3(&[BC@Q\b&R@8Jf8CeP@P5Z^RRgdS=7\aRZGB
Z0_1XbZL-d_e/,^Q8XU#XU85M3>>RZg]3+AdE270fCMM>c<#?E:GB;\9>f;IUB)V
>80JgY]8DB@9S2T/YP24Z;b8eXN5P(9MS\IZNVX-8#^,Ub-2;56_3\adgR062];,
<)XR1(H&E=X8),1FGSeedL+cXU6/?ZZ]&<f[?))\Q?G&PS#-&C3TK((X6N[OGdg2
a7/GF:N2,,ZR_7R:7L9M(B(7c3W)@dMY)AHPJ.ALA,0&D$
`endprotected

   
//vcs_vip_protect
`protected
/Y<4:K5_X>)A3Tc+b;\_@[f3d9BI(f@\I3SfX-+a1gNWeM@L#DO&-(QR@EcGQ<VD
U4Udb?e&Y(MR.[c5dQb-N9gfI9M#,P?d7[HbFZZ72]fQ.XR98B@C1.NC6,IX>0_L
1GMC/)+34M=(^SN8/W[2c]17<XDWRAWa=?ELP?DV4P38;Z(ZJ.PM9&X\EO;U0McT
5A:<(8MO3X@V5=^Q5W=?4IFbH>a?CT<cI@J&X3Pc(-G]agC<>aA4ROA,A0A/TN61
2J0ATU:+Y7S^>^[2VUUeV:Ac3d/J\^<_R<CVKef[=Z3+L#XF5^T4)/EUIdYA=]=Z
=7f.b_HDP^KHc7f7-Mbe>K+GQLc-?)PLJOWT@#7HS[?,dNJVc4;C722Y7&K8.I5(
9&>8cW\AENg9&Q^6M8I,Jfd[LX_cQ39#A=dQ&Oa0N\WDcG@]F#J\3KYJDMQ?U)5V
L<]9EXDd_;SHV7KRFM<W623KO./;/NS6N1RKa..[7&OVELV4^\Y@0]-CC:F^PTd;
UD@-;AL+?&[2(JdA.REQNP&4g/LXLN/@=9_I\?#9RcDJcPYY/aS;b;,aCF[#-@E(
(Gd0I9a92X6+.PXM&Y)[K;[[WXP56PFZRTVY1M94We+G)(F3-?aA9ICQNVB_Gda;
.V\#T^7JTd]gaVf=/dVYaJLFK&XFMdN[7_cRH&.UCUOPaG@D@31=1[5]8;>^H3C:
QWT]>PP,L\.ATX]Y#B+,7=gBfP/2b@a\D7T4>9FS0ecP6gI>1B?72^L5[Q3bBL/#
d4^L.T^(dZSNOM,=2N7VR:/<QN7B<9T:LA:AVg@V<BK+^:Q2W9\GJ@KR7CeZ[8aO
_2&3.JQeHY1)IY,#\[A[g]ZH[J?e6=:3faS4968/>C\^F8D>6B&ZXJ.R(#5VTWZd
<G2bIOY;?KA_PX,)?H_5.QGa<bR+4YM>Tc;J;Xea2a.dS&ge2],\UO-:040Ae@Lg
0\>bCfMc29=5KPXe3;#T462VIFN.X@<VWQcAV<a+[;)&][K?TY[O,SU\KMc.0N=A
FdY&=&:15MF3XCUR.7a&CV5P9(T1RD]QHEL0=)\KQb>[]BZYEX)PHYJ.YJe^HBR.
#)7R.::NP&@-LLa8K:XXC4.gMOc&ZeE7TO],MPaV#IA8D@Y9^0A9/Lb9ePO8DVDg
35<<)f?2H#3S6U,XeYKJ[W,W2_.\C:/0FPW>N>Y0f^>Af/RBN9)^QK49;7Tf#?N-
XHDXW[N.(QH=9-CH@@;BMF9SCAB^&X[MRBf;MRNeT:f2.X\eaVJO[EY6XSOEaJ:M
<F[-/91A<#f<beH:6OGB_SIC<++GBb0[9;UZJPKRA>,QFF\VAT<)/O?MCcgd90E+
b9F:DQ/c#0gbF3RRT>PV5]0?CQ0JD/IaL(Z-1IC3e<.a##=CCIT>Z/F0L&1JVF+I
0#+_[a]45YF;\0FYA=G6<JI,\eD^/>XTJ-J=OTGM0_4_EDa4&H_^^LY>b6;4Kc,A
8J<[Be>G(0\FTYbHg#?5Y_3N-^VgC,#]@0+g:)G(C<WB8HeK6;+YPfH@87(WU<Re
EZM,YCK&-J-P?bH6K,8c1QWE7Wb8-b#PDLHg6g(&U9>c6b89fG\<:^D2Ca(;]U2R
Kbg962Z&P#-A(@).)6Ya)WT7R\FL67#;Y@HJN6C@C.L8>&;Ce9CS#D_YNcQY.1WJ
#B6=R...&5G@KIQM01C1ERKT4XEEU4V;74IbfGW0c;B:?]HRY^#@)WU8bLH\)?a#
5e[EKG^/A.G3]PK]CL>HZ@0f9FFTHUS,AAX9DCR](U@VaW@+20;+d/.<+)Y6M@PJ
=OPCUI3,M-AgF@AB)EgH#GET88ZY>0c>)8/D1KbBE#UTOd1eN2d-K,K#&.Nb/\,-
Q)\5A^5;6JJ09T,0G?]b=:9<@Uf+QL</J5+.)Vc(HcI82X6.Pf.1^RfA9TL<5U)Q
]>[I[<QMe1d&Gc[CTXd?@T=Rc2bZS?XW>]e<5B0d3/5\9MB\3(]6S:IK_6OVf_W4
Nc30>;A-BFIY\:L9>(-XUTY3b=3b1>DL[VSW=+D)BH+#TU3JLD7T5Ve:56:(WBb4
II9^ZcFFaTOU1]Db?Sa5dTaC\1B?/)LSHBBC\<R_<5A3)RX#3#[4TFW14EEB7T:e
(;3QCNE/O#Yg2Y4=:)C@A(,-g?OK]R:JZO>KBA:b\P7BA8S6S&G\RcR0P(]P\(J/
A\H\b4H:#S]85-70TQPgfC^1;EN^>X-:/3/1K=X=/,A@8gcLPP@<_3bOS^g:Z8[-
6>WW=c^3^[+>cD^==5_/;+0+PWQAUd5O-GD)bQ+4/UC0DMc-cL4+0f:6Ld+Q,4.d
()b=V(0;-67KVHYLGN)?^+Z8W=a:?92DFS]//0CT8PO/DJ)WH.d2O-8eH#4999J[
)_=[:F&Mc+(U6K2TF:-d>cdF_>Lg;ZefaWLJ1]W/D\GJADU+:c[A/G&0NUK@GY95
9-a@;KN#&.2b,1N37G8F8[7F#?f\G_\//:K6[H:+<,3AYb9#7@WbJP9WB6&PD:Z+
-U+<CY\O1M9HS6>/Q7L+R=CcWg:3/eTgWKOYgAT4@HZCZA3[U>).UPV9@Ye11UK4
GRSJTJ/\C9H(Yb\6U6G^EXIDL>+)R.[-X3c#()AG81LHEWC,/AT3-1@K5dEUd4;U
M8#&c=_O6V@I<A;TE&VTXWGC9Tad45;UT<cD_]EIVe2.VNXU)&YL(V_fQ8bT7,?1
4>T[(I5M8L_P/W8RCY[2<MH4WY6LIG77KZ@JY;HUU?^PK5N7H\@YN^Wf1RRT[UUA
N-Z=,SXNM)9=NHSM.D]5:aPT[f=F:Z+Z0_#D+bCa_;F^\Xa\;XE-SMdf,8=Lc=C[
KVGd5\75R80.\?Q4^d:,)N3E@^.9:QPeRKD_0E+]L;808GB6dI0<a5RG5YN;U2NU
8HJD@8Y9@P(IN>KN==f[aVU26,?@B[X]TP8NQMe95gJY9@FJcff<QUQP@:[Ra_45
N0IZ_Pb;7Z6-7_F(8PCD_)T_d@#91aW)(Eb\.V8,KQDIaB::c5D)/g50T>9)VO1A
_b7:.&JVCZZ#<F+FO)T^KBfPA-TN<Pd8J:H2<-:5P7f894F@38VAQJ:KKGBGf;TT
/8^[.f<T@dDTe7FY\(^6,K;F-]PSMAP[M5>&5T8c5<G\2+]Fg:]]Db8L^6;AC-_Y
F5&[gRAZ/HJALA/EBDfbATPB7,B6WSca.O]ed&2dd=:]^_#cK=/VK0A-W@R.S)@W
a3dV>fQRU1)bF^#\[:38Ld^.[WCfH,],Vf9>/R-J-0ERG_db_=?FfE(V,@Q-S0AO
LRS?VO(-C&5AL=;\;1cSU1CQJUf)g#]_PaSCM^CUbXA?>,:?F;\]TRfB&,&a,?QN
<)gg(I1OX>BWYS=QBIZ08;?JUb-H2P7b=@P;#5MC-EYMQ/@@XMYb2H_P]AF&<D(6
_K)ON=XEKBC&?\+X+SE_G(?^S4^_&.JL\FfB5OR+,cVUNG,(RQ,YUU(ZQB<HFe7&
II]XV/G\EFMXb4I<YXXf<N,T<4:=g.HPHZ:=c:gA5#6(3CGb=,XKEgZd\2NR:ad[
>554K3W]S\);<Y,G59KdM,:=_a6:Y\/B^Z0@EWH65.Aa2)\XLCV2<E@E2e\eHUZ7
X.L2I03Va6[1#U/8ULg>BPRdZC;.fc<T_9;+\Y]LB.A:/#fJ_F#;85eX2^G(eCWc
9eV[XYD3FE7W/;eC6HFLXHMV?-F[58-/USeb[e38>&bbD:5+A-HF,Y&7#+g^f.5K
afUMbX^PQQ.1VabB+FF(Q5](2V]?bDK0S+2c5MM8XZHEP>V;&a8/X3OJC/bK30U+
DCZgYWSL-4E)X9b]d=B+.g6ZGZC5)6))+T1DFYF=E^GYG;7M^R+UbFDa(I]Ee4M\
a:Y[9=A)=7YgG\MZ7DaJZ&-PJNV/5PKZc]F]W+6Xg_&9d?E9?Hg:Q34fFV=<5([O
JEVL).BD0EZg81ETaE(X3JZ>:ACLD4aNZ2X4Q1LNLXTQ]<17#,5dC<JPa(O1LSJR
D<bN&Z0(NMSGbO5LNg-V1),fH.?.CGAg<I+II>@;(8cD?Q@fa@(6MX4MKH+N]EAS
LQOJY]DW3A5TDaITG;7Tba,OJ32AKWVH>ODZ&f(MXLQgb/[dcI_27).Lf+@LOg]5
TbL=&&5;),W&LL6TPVOLbgL+(0I/5N,[U/M5WFCJJ\T3^P7SgN8d.?&_VL/P_XU[
Z+_4N45[4IHb^+,=Q08P30._[KQ]]HUAe(VY];N949.,4Z6W7)dbMOD[05Q^S_?J
17aB]AG?[73(F3.6_.E&[aN-b4JYD?PADG>Ie09+E8^VOD7TNI@bAGTaZ:DbbYEV
5#W)/O781\LKbeQ\?<L<BAARRI3\,c0;Z;V:M+@2(B9P:+S9LXd?5@0>&3d0;Rdc
1>f@A.I;))4I\A_>H7DB;M5Q.TBKO+SCYcJQfcB7dXB\J[)<:=PgWa]KC/K9VK>d
F,U2A[=,U]6P=H]UG7RN^\KHb(]M3UD(DG5g+GVK^-A16:b/X>HTP9KKLV;^D0J@
&/F_?@e6ZT);Rb1>V0S#[e^37#^[S#d+#<[IZS[\5TVHd<74F0\YZbJT@:\2<A(2
_M(ISU9M+YS7PfR965>-AgC[X7J,1&KCS_F(5KgU9=]S]3b_>SUce?D6;gGDJc4T
H9QTcg>&Rf)LA@c(HB5&+9JNFARKMge&dN:71QHJ.eH_3O&Y-:4OC6E57bW,Y&0Y
(#FIQ0S>d\fYcg&bDW,aS1CMC9?-ZW=LY=5RC<?YCJIK7SdXVS&]39aF^4-7JRUV
:F8<e[/)Lf:a6;]&6Vg+IR?<]TV+J,70abY]Z=GMY<e?@89E#&K@TXFM-+3?KH]2
-Wc=4##OfCHe]dDP.M_P,UJEVS5<,bLJG8YDIG)S+K9A[FSFG2G,,>R1MfTUK(I?
:)(,H/Sf8OW(B^X:@)+1Q.YO?HTE^4:KN14Q>1:9K=H34ZE8?J/#>?e^5O-;+]e;
AL\37f=M8GOR0AYP8-SI0<bT8</KQ,E&#BM0AE[R/QR32D_:8XI-UQbW(8>LQSf=
^fI725aRfLcVQLKAZE;M)5.eaQ>5;.#@5HD[+6EQ>2+0K#YJF(e9U<Ca]@f<OOCP
4PUK\FAA7S?MXE92<PPFSVfba,L9P0:0cCdE(&\(D@M\f:]29<1G6#;+SJH3UBZ/
[/g;^?+2eD)J?AR]9C]Re68&&+edLK,P1)_Me8PJ@>UQ1D,.c\1GCc@3bI54b=@\
@<Q2@K[Cc.gH(e+A>e?:#X2F]?0.E@/>(feSV+,K,(F^TD0R[,@18VWYO;_eGW)#
R1?CYRNJ6IBGbgA(E?eU)&\>@+N0OfP:#1K4ITA1d>+QU2>R5a2RKf^Td/6AH20)
g);/1V]8(a,@dN[LJJ65KCWf6^HcHfJ>,QXRVM-MJ_]J^RDgd4>S/;;2GbVR(dNg
D0ZJb:D\^EIW06b_-;GL5D8\36#[GAEH@WW8B/Z6/eWfW4JT.7]/5XLVACagIEG;
S8?&3++JSD3@IF>0)JK50GFLK>U,Ag,66BC+8RIgIXXa(EWQW:g[(a:G=F4gTDS_
8Hg.N\STd00fG.SF2Y^Z)BDNEC:eH7GG4-I5L+fLZI,62?1H7DS(90e8Je.gTB@4
-4]T/MCe/:feK@8](+g?AOS]_@:gLU)(G^&71]GE3/?,T/)6>_3b9#INR-[OeA]3
=TO4/Y95KQfAG7UTJP#._d2fM@@QVF-Z+.NG]0Wef4_f=9):3T;;a.6>B8.@TUE(
SV[Lddc&K(ZI22[?0+0ESdVbRPVY)O]P]DcI[DZ&SC\G7X+M3e]>b=2Ie#5OEe=X
6LT2,BP,](7CTM#EY2dPJ\8U(+g+N=W4/0/5Z^^CeU42K>@4+K+TM2:9XIOfWN\2
EOKU/AE?G?VP^VHgD4gZe>eT-]EfXaPeWL-WI47WS3f=WB<I+<94:0X]2<S1/WGP
5//Z_UFLX)MLM??_D&=34]>2::B2WYd/\4b51R=QKe)WW;5F.F+.7&?(?E:U&Y>T
^2E7..TT38>@6NdJ]INJGcIe&G8185M(KF):F)):&MVQ1)IF0G+@c-fC<V@^CE;b
fLW-XR7:+NG=cDU;NRY)OC#EHNX2J)A\IA(19eYc>(\_=_;\)NaB]]7?WNBTVAIG
a,XWgPcKNZ(WEJ[gYK->GP<Z=40Ob&aJ6ZcX@;0H+#,@U23&4g=eA91bR#A_5P8V
EB.Lf=3-:-[9c;e.YA5_<5BK,O2_4c=>&G2FHPdSYO)L#87^Q_9;G,+KeUDX8[&f
eY->MMCA\KLb@0A:B?(>#JC(DED#.[::11MDdI-<FE@5J]0W/W:]VLXP;>-=eXS;
44.+?^fDW6CbVdYPb-BOG^QWdL;?))D/_f^3-?(XPYPIU?LbI&(,#YHfd?M4#GT8
Tff+.&WgfG[&/b:[IWGD.gCg34:6Q9AHCcU)-fZf/,;5Ua=DQ0\bZg)_AD3(_g54
\?9/1(c5LJG1?IFFTXR_U&.#:5U+D]6f]V1[f]<NU+0c_b_1c2Pef@.^W6Y[CW&9
>;^0geS3X:Nc=7;4BcTCg^cD)-O;eUIg5<1FY/1@GdHCKcY<OL(da3C,8_MJOQK.
?.cG#N<TOZDMZSQf[@===R&/]cY,#;=723C4AR-2E[c)FfPREV>4MG[<4H(+1K@f
2b2-2>T_HKHB@OHRc[TP;39AFB(A<_1^;R[5>FA(5,eC]3@cJM<ZGP:-XWN&YMAb
+c^MdFD+XY29K>B:[5QB#=,a>7N:S:R)9E1>B3233[ET+-gZB<;c_+YHUT05XL;5
LAe_JTH,R:;ZA.DC8JKNNgPNSGK7F9>37?a&07=-WJ8A,8_9C_V3c/U,V_bJXd_J
8ERfH1fU8SLQ4Q^.2c.X3DOJ;YDH=_S=c7a&VZMH=?b+J0&H+:CD^;J[<(0fgdCN
36?e+F(NZYI@KgRaX(XcIP/00_QII4>2E4ECD?AdN@\.M&:5U<BS+bG3&IW+PO2\
ZF2(GTbAG^Pb<@2PK.X05>,9)+c.QW@K7&/Q1,R&CGD3U2A<<4f0eUR7,2c\#),:
2;#fP9YX?fS^,/T71Z6@_ZK@]T4O#QeP7[0<(0X0dJDU,8.Yd,^ZX[#1:[F&FI9O
>?>?/eg;VC4g[-;<D=J^N,YD[/_\XP.)D)SVR\_A)#7Eg:H>;IgN\eAe5PE9Pa2e
R@[6+b.V-]G<geUU55,ZdYV3DSeMMH^GBd<,IXK4\]f[Ee0+TX(NZ7DeN+C4OLZX
;@5;:eNI\C8P@A;IO\BM3HMeI.7dW3\R&H8)S)F?)f([=7ESVXbL#&/S\HK7BI&Z
HLH8:D5JTPIK]gcKf#R@9VO0cK>=>b3TR<WE&X=PNGY_9dLJ+I5/NdWRAF3,=KV5
8Md58WB&=QQdYdJ.K^E<5WA[S?e\PSVG#UF#(E(>c=>X&f4@Ye?+0IP-=XK-QHWY
Z\,?WT-KFM73W)&_M&T18F>+V.DG.\2BZK@49E1\Y5]/JG;gPBZ=3f=DO&MdD;&F
Qee)AIA>:@F/^f.-Jc=B,X)<OD/NbZfAB@_HD#^FDbV=LFcBAROSC4-^-XZX[YV)
f.?2/YRA^PSB;adS6Y\+2NCEE>cb7CR074^OaK^c<UbC3DaR(J.A/)SF&\KTY/O(
=Pf^MRAb/^F6XA=9JKNb(J:OV=TEFSg[0L,,B=./>0A(>\HV<6AgH@e8H#507=\Q
)N.AaTVN<+(;>Y^#RMd-SVM.0NXBXaBbc[.H50IGb@/aB\9N/RT]U5-X(@^-e9Y<
>8\V/H@2==A/0S+a</29?SX.Ce1W8@DP))gB8eHZ:9J&CW);8<.<N2:G,f-X]+P/
+O&FHXY^O:/]8J</=E-2dI7Q9(d6BS_(0M^TQ<&aL3P\:e301@I<R?UWD0;a7+4&
ITg0D9Y[gA99DHISec<)@M.=7TFYgM-KY:JA)^3N73#;GaedSHKgC7G-VZc,Z<Z<
G8PEW_M-BRbVfAC5B>.DYC2#/(c^TG6)aPOHR0&<R0gf:>>^,#&0:dXcNa_7e^Xf
7YNTK7MM6&SF:@V2bbYaHaHaZQeP#;TAR:.CEE_JS7F;:U#W#7U]CaN_GNaggfQT
:gR.AA;[V([9G1GeeS;7A2V[<:^MYGR_d<:=g579L:\N[I5]Z]c?11S<5B=f/B(2
\<LLW,<P?-UBMNEF9W-C,\G^cOA=G=#BgGM)R2cGaBdd:5.F:H4eJQVCOSF:@1Te
c<9]7f]XP5BgfBJ#?f+U:HVLNgSQS6X/BZ1646b?I2^cf@WPg1:7+9Uf8VB:SS:Y
4G=bPW=2G(#U;P0EbBc+&-Z@-=1O\N#8f9YJ40IBKA\U&R,G&P&<B^;N^e/9?Rf5
@SZ?J<4fF5MU1.I-NNVSe=X5>8(gC0c.45QBED[[0;FY/3Hf^-W90?2PIYE:EY14
.LWG.V]]bc#E8FeRW?A1GSXU+(AN8#/N,372ZAAWC9a)=Xe3^[HZO+&CZBa5#CYQ
;LNUU-@a\)_?/C^]VHD3bbTT,c]Qc)b(J(H<;96RBB2.3QDQLCdWX?CY@OefRPPH
C4JD)/84@8(NdI9/^cdERPR,gC@f#1(2S@6KE,);^O/(S@bROcf^_;:.>B8ZY@^O
TTc]A)-8Ra#58cf-9:Z;CC)U]<MZ\B+5Z]L5+YYb&@a?54<Z@cI/P.>U,f)2/)YP
bK&:3G9OY_)O_&G;69JV^c-PDGZ]MD+0aG,_FPDRfa^g,Bf5[1EgPCb\JZ@b(,g\
,09Ba+-Sdg3&E]@5eU(Y_KZYHPWPO\<gSPLE^Bg<M6K7[M9R<350d<31-a5CP-Z:
gA8+L5Y,\_WQ+^1MDL5(<?2e=_4dKD?PSX<73bG3+5X9YOD1H:-1-UP.E19@1KLg
E#;]FKe5XB8\_>EWW[HH@ZJ505Ae85a\TQfNHdebB5\d4]\&:RH06QJA?3BHCaaC
ggMHQ6N+@[U(5=]O/a:N.7>EA2_C7/C+=S5_3K3:gJY\#(\e@efHQ4UML=WgLO&Z
=49/PE5gD,^3]P+>feX6?VML&2d&<Fg^+AXV-4]#M^9\B5=/P=B7I(D8>IGHde]]
V[cJgFDB1XLP07PL.@/C1b9d><2T9&LIP0G0]+YH;)MN:Cg[GT,e^7M/g,<X@_DM
305J>C[TY,\Q:eSg[+b<T\W/9>,f0D:7V,#VOa<+T2+?aWM3S0?SBf@+N1,\.F^F
31Q2@E_50aLaQW>cZFR<cJ):[W60Ee>,[bO960^>@Z@]^T[e4RS(Wc6X,/-IH+[a
/-=,2,>b<(4IQ1BF=Y7Ya[Fg\.#YGLC/b_GIB?,EDEQV79G[GIGKQ2aLBEX+L01V
?.UC>Q9eM]Y4Q8,+-2IV1K(S[aR1e?7ffZ6M?#IaacTNMeVUWZ0:_&<]BXOJ\e&X
7W;_L#0<2ONU@9[(HJKK+T2XXIF71:#BWLf3#>3UK^J#7H9fFd(YfI3^RB.MWEMA
eFYC8M2f?OCN[0=<3@Pd:S3)&f,HAIK6)fKG7I^8NIJ)^&N5b?bQf.ZY7f&I,bJK
U1WW)_)7=M:1C_W>&O5DG6dY_6\(^AT>B,e_>K>IOPRH7\/=ATaELbWSEUVX_a88
2-[;Q,#UI>3]<<B7O34-NLR9DJ+U.dD9XO47FR;SKKK4B/f/He>ER=VH]M=8K[A4
J63F;.Xg=+gI(;?8MF979TE]N1b[+P3NXVcB)eE_/A5R-fH2P/B.dSL/?2=QSb_J
T,BYK-P5f0F3/.1/cW1;]P6B>?b=#?HfUGGUa/3@/C7]+EI8ALbQQL-6^\\2=?<L
5SL>ef6;(QM/Y9C-@YSERKDGda.W1?_T(P63bFG7]c&SD\CG,>6D0CIKWgYRW?-R
12JJ^)FM(Le/5BR-afP0W.GTP^QQ[dXEJdJP)Y+BWJ#M_3?18<LUgD1@;09>a13G
](RW=[GSG_/I9GU6eY197TU5M04TGdX-E\CM+e99_//;bA:V>F_eTV071-Q(VOgP
HQ>d2\4E2)&+CaRAb36D\2Z;c=:)0e)f7CH6bE]7]F_-AgeXcER^/UHG5\(6UY=#
Og?Z(7&[Q=Tfe>b]F/&MV91=O^S/A((OG>DKVI[7Bg@I4._-7/@L7cFYMPe#U3RU
&6.D<;R,QNN=#]I=SHHfTD];33geMNPVAIQ;&W-TF&3+40f33GSEf6P&:Ng^+5Oe
BX1UJ5T<H#+VC-80UK?cacT98F+6+Wd>]<[G11OR8NS(.]c=EJSPcJ&b&aY>aQ2X
R3@YL?KM0XbFZ,<I]-&@_4+fB5D[gC<eX2A?M43T7UZUgFWa-Vg?/RH-N:g<EP.&
QG7-79>AT6Vg)7=L=bHR@N0S6SPEedCA)J4V8;>R470E8V8;X;\MC&CTB[)aWHAb
f_7V@HH?Z\;WBbQI,TaO;[1eJ^UPHO>(Ra5@a45S.^XBRKOMD<da<>33-V<G-ILa
3?Cb)8/WXP-CZ-CdI,SO7GW]6Ac]JT052&:aC+N(]@3/U\[8?,@e+XB<T5M<D94C
+B_BUMaeEd5_B3X#6KPJZVO21QZUg/g[X^]A[W?fS&V<_W\fE;<]<:7Kf(NPe,[/
AUf,X1\9@Z)&L@fX)3HbeAK[1,b;@B-9B>X,)G+Z@Jc/TO06P@T/.a1NRe(HgIW&
KDZ)PQ[P,^)]EIC#K>FL@UdbC(JOOA,09M@<DL72EdI4e2)P)dUA@MN7PNT);:/0
<ZXOF(FP]?;.Fa(GZH(f>>L&RU^/5A]5X.4W&b5,.14b+d8+.1.[+Q(7)I]69DcX
1>#1\M@6V3\WJOYFFW-a4SUN8[M8Qd9^P9P=d-C36>7<KYFZ24^6\AJ_?NFK\G(W
dc3<^3N>YS9fD8Kb]^VFRca+((bcJRRJ3DSG95\:##V=REZ(8I4)XO&@7<a>H[(g
,QJ17\b>Ba]AH^Xb[R0A7SaS_bFTBR]gdVH;5>@S8g]7HgfP-DN0<1We0dP>P6E3
-D^[Dd1NROG6f+N4RR>3,#E/V[fe(.+FYY;X#KIVW8f;2,G68SA\^234XaYXb2-2
5&.V8B=@H=F[=91E2cKe7[Z[Zec]HD\95b5eA\#V&e670+PI+JM=BMSF9W);E]eT
@?b5?.3g--K\<HGKY)L=+7IK3Pd;UW18Q#<NF[Se<M)5=EUM-XU;7(aDCc6@\e2=
OC[W>>g;B.]>)a7UYR-:V]4fS#J[EF)7Z1TB]UXP=^Pe<Q]<&6_RDKJgZFd+K3N[
UIE5.;UV78Rg@Za<Y.M).2[eC^#,d[LM^G3Ac2O2LO06+,?/Y6TQW@#@#,=;3V<D
P9bBf=Vf.;8&SC4,?M1JP@,&NS#)KSNR5Z<#RB4#:g0C5#Y:,D&YA#&_J6Z<Zba&
I[DdJ=LOF[g#_Q]P^1DKBgOA).TR>W;73GJES(&eTZe,d5d9+(2=ML.>SgKSWJgg
#_>+Y35V=-bZ@)7fe8EG+;OXL]5F&Y-/0(T<=]eCU7LHSbHE162Q3SIeL6[ac4]Z
<WX);ZN88)9N+\?41-)\YWbbfN@cE3+JSZCLfRV6&Y@69E9a:_QJU&7,bdSe14AT
=J9(?MVMP-2NI6Se>@DLKH^gLS6C+cKaD=Z42T;O5W/E]97ZL,<+B[V.66^7\63<
C>\U-)D-^JO3,D=#g^@dQM(]A)8R,ICb,4e8eH]SQT,E&]CZ?3M\KNVWCIA5#KH[
P/8>4[PI3^4W);+L15XBC-W[^ZG-_YaEd)3?#I.RFG_[Y\C4.S_=1;?A:<\0F_\X
Oa@J^\4@85b:fAZ3I2S1(VgP0M5JB>_Y[#8G-VF8\f4dNNS]bged\b?(IMe_Y6FJ
E;?G\0c&gE#I]933&e(RbT3\654=PXbGVg)9bHX.JOHS(>5.\AT-C,0=YdZ857bA
^&I&@P6A^XNaV(fX#K63bYC/RN]Q&\>ZKM](O2Dc?>NWaWS=#U6RPY8-]B:K)/\(
/>eQ=@ggD_@AdHQ;TA(F(+46)_=-3]&&=GC6fE,DGLWEAdc1+Qa<N3I9ZB<=O.ME
V4C+Jfc,XIWHZ1(HCCXVg#4&LNHXV#(O>&>;3D6PYSBcAQ/65FEb0^d^^MBFC>RV
G6C(BIb\d2P69SF+OFV.0I)L+S2E#_2<\HQE,CQWD+.ANaS^8VNSLUF1,LJ_CT?W
J4P>J?FMNC(VA>=YgK#?YICYSS_?X(OMGJ2T^1bED<RQRBLNJ1\621S.Z(G3A;Ga
L;QbdWBA;[.C)YNU4@&,1D-A8fEQFO2-Peb8[gN=d-56cXeQYcK/@<P_?IG\VWN+
X[ZWENWBR=+L#4WSY,_IQd^CF-#g0P0A/8PUI>XegWYP)LDT,D(A,?O0S[WELaX9
2N(JgXaE&\I,]3]-BG[(@e5KaP(c@aV2#d4HgXK#e2VG=IC@(X9M-PXZ?/Z>da2G
X_&Fb8_/-@7d4]RTG:@]?.@=:1X-2^ALcZXSdbDYYNebBTfO6YZ@T7c;CZB]X(@_
(bQ:cf2I)ULXW(:_SZ7(/21^S?Dd7LA156::U=3<#(GHX3O8/>T_a^&.HUR0#>&Y
C\2-/a+W_W48Cc&/HI&VZ?3))=+;0_a3@O[B?b8U5ecQ\@@NT.TQ.1185T:A[\(/
bZ92,;a44(FE/B1gNbD8CN6;.Y1888X96N6+/B62YH>C8IfVW.S;Mb_U029(62O:
2#QUJP]P^e]?-Y/0^5Fcd>40@,VAY\HXc=:RI0=\J-L?=@_^-\19U1.30FNJN)QA
J52\DU5MfC9[:YR1D7-^d26?].\XdDW&=U?E13>5\_W[3a,)KBeH[cJIONCWI\2c
K7LN>PP;A3=QZOSg)7D4Q,5e#^TY58HD3],JWBfF#[;c6[E\M5@-;+I;]Y4+ffA/
\:MX-;1[fYC:)&D]FCbL?I44IBK;c.PESFHMfNc;081CJU9]Q--/(fdPf\\.5.V<
bUZ#RVW]O.RO1B_V@8g/MbHS#O&J@e78+57)aK-UE/^g&_A+#6(_e/MG>VQ/^/>G
e.3XQV1I?52_bPKbAf^f8NN)_QfVS1HgIU[X.\_AN(G_PMb;,#cKeg>(c7)#&M34
;PcBMcQ4dA-?9G&0V]^U=BgWW]WC,9O5.&J7a5CZ<_.7WBSA3AcRAXg,B#87<O[,
0BU&:59D)S?24Od[a.>fZ6C9g?7g6cSee(F0-N0e:1/04&@gSGZGE/B)FK5_RYKa
F3f@KS7/Q@V\CZQ,)MLXQ\AYIG\QY+FRQH6XQ0GI8TVd;OgX&?^T9eM=H6_J+KVX
f9ZdgM(c9-8HSN>5OW]JJ^@Z(V)84AQWJM>7BN3.NUKEPebKe)?8-77HRLHFA[gZ
Rge-^eU010R\O-:GC)Z@9K;F^SZOF<Y#<c8KFMG<?1EEXcO;:;CUQ=+F+?_3=YRO
I\V1E[SUUR-b]4OSWR@9V+;IW1gRHT^)WCS^O0^ON-O0PBg/DE?D/ISHeDN;9=;V
IQB)NB8J[<Agc2OAQ_[^F-+88W^^A1LBO=<TB941]5CL8+W:DDY1fZ/PaT5SJ3K:
)BW30#W/.43QXT#,6S7PdOM-KH-4K=^AC+Xb=:\<JC7&@HgX1:LOW]DcHL0GB(]7
PC9D00=RbVR0W<X,3.Jg5WbL5/#>&-W[f(/496O)??GXXQJZ6+\M6H_IP7FUC&c2
[9<3bW[JOJ3fA-a,F/b7WU2]08cg/WN#f25;,LYO^_N/RNf[J=1Q?e/)3#cgEY-&
AQ6]C8YT\Hd0-9Vd0U[3D/>:bO^3e#b+aHOJe]@F&=@J,_cgVe8B?-GNGD6GJT>P
U\4SaaLD=PGT/bT;a71+f.NP1F[aMR=90TIIH:\B8R/9&e)3^<S,8\J2#HG9]Se]
\(>XeIXC@&6c)R8b-.JH.;X0a9Zf&EMD0d3_J5&?d+M9CHIJRd[[7/MYRFN#Ue\C
QX\-RT:N9BfXG9b#<DB(^>Q45K7X12N0bN>((H<E6.7b)Dg&:1#<9.aN.a]LEc:5
dP303VPfc0E-PXDYIF=Y#(6H?>:_a1L@F/JZX)]=4JF=<BQ[Jg:4,(F?>VWP_bDC
AHcdH/1QC(HF1>VJd3&.:@-\WFKcaO-1.E?G;W7FJEM4[,]Ta,Gg#TR[.&fPA;Va
?LUZWS\(3#2]T7CX]V1@DMV63g\QDU:4((>?&7]&,LH76<C)V)>2HUKY(@Q\cC4M
Z@=RC2BK5^,Z(7>1)N)GZM10Z)G>a/M#=2g/da2bN)fZae[X(a=N&b=/X8N:BG,^
O4/cKaY)dL4#XKa,eURe(2N?IH)D:.48XU4X\##,C3)Qe;LR98HB0NH=G:_GGJLB
-.ZG;I<]ZB[0Xd2R,CEd<9/=4c>8O/2O_5^F<1YP)5CG_WP;DU8a_Nd5T:;#]_Q&
f.f#g8]T_>[:)4B(52/4=?Y]NF?/34[JM^\;22?5;7L]41=4R+XX?\7..^_S+ZU-
&0+^J75OGBP;@E3cME)YV6#\(D\8/NZ6<dRBA+c?<FSV3U;GE>#_77<@#GAOP-cM
(dUIQ1df]Ya&f.MG)M0NA_CQJGd(O(XR&L2ZeUf7RbK]a\J_7M\B<<U:fZZ]U+9)
&ZT<c4D>+BZWEf?^faOMXXNgEK@Q6Q\dL_9-H0[((;[-9\;HV20WbYWHH)B?[Q)3
)D\_^)ADI6ONMWeEQ)BRVYJS31W/A)<0M.\eT6CCLV<VLAWgf^#+(;X_Cb]D;L3W
f[1DE7N7gM-g_.>T=L?aIfGRPg\>)/VDG[6>_LbQ?N7D1&_CH)@P;QISBA^aCR)5
GP0YA1N3AHW0K3#2F@Y6MOJPS1_7PBaQSXN&J;B.#@&ZK=W-P+<TQA.g_Wfb5J&I
VQ=0Ec[^,&?<_5SIEQQ>A1-=f5)C9\,)P2IEKOe_R@OSQ238R];Yb>W5JXDbA5/A
c]BM];:X(O,7^D,LJ2:gWCNbJACS#RMMRCa3G]V6F#S+88.\0?-3)HZ,a]LK?aaf
QOEJZ\_8/>I_(>L(RE^(7N,[<,f:<9JJ\2D)W2b],/AC?7S@=X,Q>2cQ&&#D>=N>
9aXN.e9_ETL>HC[GOEgB:ZHI;+,/IZA=Af<ME,-:^YBWX[@e1RLC9(BW5GM27eID
#SM]W/R6D@0(;0)U-(O8Vb_P4;;ZA=QMeLC:^0ba_?+56MV\R[ANa/TgYaId_C.5
+B>LRQJE28Q5MBd3REXYBgAg<aN8)LG;cQ.;B+PN]VBIDL)92&##5J-6Z)O0J?,c
YAd9e<6;Ag3;F_O:)f]7S-_T]&^GMUH6FY_^6Z-[<(191f=\1#66I1MK;SI,W[#3
4.>?aL4:X(QT5Z2aTZSLg=C_46I#gF3@0NT;TFfRVg9KZfd#FWF?X\P,?eJc,_^7
f1(e8<+K@6[2SZM8?I2^#NHCg)W]<=LX+RZ+b9PbCaR@][<K,P<)d/AH-6G+YC,0
Ge-.6,0N/-X_Z?S@Y^5dUA/-Ja@G6\d=WO#95(f73QaZQ<)9CGW[NU36Dc51eLM.
,KD\b0^2T=1A:<5:aO-28?fg=:>#(_,DB9K[?HC^Z?3-YagYPC_Ka)QDJ[,EJ5^B
B/b9G4.;-9PL:5O(LPM]OZLRH;GRFcH^2WIR6]OCM]M^bVZMWE=fcYbF?Y]OWO8D
#-DbP?Ub;X6<1e5#Y1aKRfC6QEN2,Q@CbO[e>9OH^>UScb.1[^<R7V+U/_g&f^,=
V0YE]XC8H>X#2(GP@B=MLIES3GL7PWT#<=]O-?KSI89D)DIPE0NcfVK.0Y/=QIKY
RMLD?1376HC[,6Qd9\FK2.2We_)Z\Q]7_D@V3/UL,[PNIBXa1&X/cGJe>)@>^NK9
?ZZX9G\f1-IN[>DN]W)80[@]:M[&V#D;SD_5NJJ0,2@8A(CP^1#[@RV/7-D]K3O)
5_.gT<fAAgDe-d&4>@VZaQ&8A5@22ATYCY.@<dg1cQ=OQ&T/-6<B@+cGH>PWVB5O
^#R=DCL->\GMZ#QE]])]T@CT3@.C:,?Pa;fMGa0R353a\>OI]B7SB^5TV@ac=9(Z
J[H,O4+-cPe,PFCf:PGdLQecdMIJc1(]]7_1#b;03Ma:-&<K@(W=V?-9/2+-15><
7:@CFd.MJRJ#N6;QFU:<#OA+<8=_7KT<BW.&d4,VXeQ2=E0;FS<<d.JB0A9RY])Q
56#?a^ET0_ad2#P#C^?0ZX=3]L3_)5;L=072=9@1I;C8JJ;3e6950G9R2/@,/e,2
P(DCFe:NFPDXYa(0T6Ta#eMW#^3.76IJ[;&UMIP)/=TUD^63GaYMHf;-Ecg/7(6]
UZGP52=XDd,W+H15<4C/:-VWc--[]Q56-YI@Hd:(-/MK.ZVLVQUX+7&aZ4ME3R5d
O&K9@Yg=ZCe^I(O57_Qc)LTO<#^6,C[?BYKNBX5dHbSRR<)NC-ddeEfdN.)BNYUf
0Ec9aK1bV]2DA>^4TeL?V;gXXgW,AVWAgWW^V5@1#(]#IB9:^INa/ad5+c9X^e_&
S6c[bV\/]MNJ-UPF,^ebDH1]X/0=(aRdfCDCTP4K-4g;U&+fEe(KA4e^.A5AK#8-
OB3JgZ/P8G+GV6Y:;IU_RTLFagVBbW&9),U00IOfSD<]7MdU\)R-)0c(4E9-:+c\
I27IX]&[cPO@@(.JC(fJ=PAZGI?Kac(41Q0TeHL0M82ddC3=\LXY4O#J5Ja7POOL
M-2FfX5:LRO?-,/1]D@&cZ((U>6L4[,S]cE;\HK\E_2B:Pg(R]Q2M-[#\+^TK;DP
@S&]\;6AS@/5I7VHHZG:95+5C&SQ6UgR9E#+3M9.7JFLW4<K.#-5LJ3[@g?&9,TT
[fBgWLDUDbcWB3LYQ0X3?c+_R@SN&S7eMCM1>)@D,30WQ]]gOIFICV4H#6bT(#3V
+#(Y/^6Ge_bZ2:bTMLB2EUc^BdT)g./S[da\4I-LU#X65ARd6PZY9U\;a@8#FV7R
YYVc2;J:)-+(>K7.;8;EHBD.fCOaYYVSI591FNEF,V#6d2WKH^49I1BT8V_(_TX:
aT]KKG1,VbI:[O[WE(1W5MYAKAbU1,];/T>)><>2JJ&8HIUNLC+A2a>GNHZ#?cBe
A&IDO.DM?43L+BaR(>T?USI5\ELC8Q;@BSCE79&)W4UDL;fWQQIQd\NV.:I04_+:
4WBI/5U>NG^2N]+JZEc,]FRF8;9R1,UPKU68_3KK6-SR>N;FMbg).FT@V;9&1.(&
0WB-Bf7?KY-GQ>Cg^:OeW914?agUc_QE:^a..:WF.b3TMBM/V<S;2V@I=eT8cN5@
@V:3:e;V\@FYg>^4Z:>d<Q>3d920B/<81.YAf^I#&/9KC#A2_80K/JNP4OBGL(Y0
f)(PgbL?/4ce4\\U+<J>MJ\]IR-A;;c@/aX?&.22:TJYRaF@@,?Y;BD_1,fKK97F
GT0TY,e7;RI&Y=D;2HdP^?(AU;44;,/<[d..+-f&/@B2,52Vd=g(5H(O,g3Y+LE?
U)U+Se/J>):B<fC6DHWHQTeXV9K[=NcW>P)_0;6\7L+dX#B.UR:IG95N06[:]OO2
6;<C;eF5?0EK,cZ];\dN_B)G:;R1D[eccbbT><#8ZC?OC:Oc2^Y:1XBP+N<@(e8.
5A]C5#=6+])&7^+N-PRYTLRd4Qf_8[I_)(1VYWJKEg,eU]B9)_Je@7d<75>Z>&cH
8[^GH2g:9C<,^#a8O.;Ed9Rd4$
`endprotected


`endif // GUARD_SVT_SPI_xSPI_REGISTER_FIELD_LIST_SV

