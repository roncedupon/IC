
`ifndef GUARD_SVT_SPI_xSPI_FLASH_COMMAND_REGISTER_MAP_SV
`define GUARD_SVT_SPI_xSPI_FLASH_COMMAND_REGISTER_MAP_SV
// =============================================================================
/**
 *  This is the SPI VIP xSPI flash command register map class. <br/>
 *  It specifies flash command and address frame required to access specifie register.<br/>
 */
class svt_spi_xSPI_flash_command_register_map extends svt_configuration;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------
  
  /** 
   * This field along with #address_frame_list specifies flash command/address frame(if applicable) <br/> 
   * pair required to access xSPI register mentioned at the same index of #register_name_list.
   */
  svt_spi_types::flash_command_enum flash_command_list[];

  /** 
   * This field specifies the address frame to access register specifies at <br/>
   * same index of #register_name_list.
   */ 
  bit [`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] address_frame_list[];

  /** This field specifies whether the address frame is required to access the register. */
  bit address_valid_list[];

  /** This field specifies list of supported registers. */
  string register_name_list[];

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
  `svt_vmm_data_new(svt_spi_xSPI_flash_command_register_map)
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
  extern function new(string name = "svt_spi_xSPI_flash_command_register_map");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_xSPI_flash_command_register_map)
  `svt_data_member_end(svt_spi_xSPI_flash_command_register_map)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_xSPI_flash_command_register_map.
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
  `vmm_typename(svt_spi_xSPI_flash_command_register_map)
  `vmm_class_factory(svt_spi_xSPI_flash_command_register_map)
`endif

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  //extern virtual function bit [7:0] get_stm_status_register();

endclass

// =============================================================================

`protected
3b51NF>XH.d^8PH_a=<MBVF6XNN;=/>RbK4QDK&7L?2?/[?bR9@/6)]fGA39KfaW
;A)9<.dI<38LQA36:6H@g>MV[N8(E--H[?^1XcU/K=fbO_,R:VM]C;(:gC+7a-;J
O;13W=gVQbQF4B/@eNfL1N3<6,5?T)5^,F([aI[BJ#:&ADRNK;I\(,>:?8H7O0T+
+@VMR?QYRaZ:@e]9QV,cD[5eS0I#+7V2@N:R<fDPBdCF\0>cS]RS7;I46,(0<c>&
=W,??A&K^;T3#KWIWH^Eb/(#A4Rc9W3F=)>/ISIfNfC^/+OAL&[(.:7=4X)6P\)+
]EB/_<V&_:7Wa^#RF;TYAb8CL5QM2C7f)4d#G4b3YL+P:A<.D1YJ.4-9eUSO;N+f
NPa58@cUS/U4aM3WbBcF9eIR8g5&FS&_HF[54UOF6-@BZ1gW/V=[]<&17UB&OcF6
1RbId5T;X,<e3?31^67e_P2@3DR<Y#0KQ(#:9C.;43267Kfg>TWgf8b/.4;Ka>L+
JfH@8N_NKOST6Y7+-[AC6/I[3gdf62aOHJF/?d^,?U,6W/2gD@C)LEJd6++XMXg#
2S306)]@3gJ[e\^280VG/7DPA>TPN90EKAIJM:#gaY1F8EXO2IC-GVQ=O;g?EHA#
gI+0N]E?Lf6B58P(SYc7]?Q?P8WJRFBgOJe27FeGH^cAR:Oed#NTG_6+H.Y(.D-@
:JAJM;J7@>(B0$
`endprotected

   
//vcs_vip_protect
`protected
#;+5Fc&B1cd^BYS#]f+3_a9Pc4f^GRHT0Qa_ga^W:PX@Yf]_#0Vc5(@P6=?SeF9c
c@DRT]Ja<K&-R2U4ONGe&3SX,DdgJ&L-D@f@J_a&6_B\)_gQY&JDY)<O02c+/HQ:
1fY=AgARU3)PE9f#bg2V:T4:&T+E)g3eTYPM5:.VbVZP;[V6S&XD>=@3M-Qb4-C3
Z26)fFXB.7&bLHXX;@b:^BOPT:XKDMc)-Q5]GC]>H&2@##39M<R\?ca5W</UVTL1
<G9R0TL4H.J/Qd+Z(U\cE/cWNX,HdR2=F5+QDPXX2=4)WF+41f6e(Ne6aDM?<#(]
_MMO#CSK1+P73Q+O\:]P_@+H21[KHL)M6HVa9P__OO<7_\UX9<D8:,a)9Te/1-1.
43;K[b:c/Z74fHJ/3,2Da&)2G^CY=K#d9HPZC_<4Z=c60O&18M6AN\N5Z(NZa(aY
(/cW5OK;7N-4Z](A0;O,/>F^X[X26M4e(XZ=/^,SV>D79@M/JC=gTS8]G1YI-ed#
A2dWZgRCS1T=B5-UMSX5D.Ag7.)D2F7M6:>M&a^DOfFPQ8.H,EBbP73QJCS4;.bZ
?OA;C<41PL+Fb8614K_Y,RgNTgCfQ:<LMe4,72:LBdU9TGF5<4e;2CdCX\Uaf_OV
H/?.3f;]YXQZ:e>?6RSgaD/c3S,G?5+@>=)T/<)[D<()Y\-&LN?_IN,\;cT>;5&\
DgDb.DW;+2;P,)X7C957?cc,L=SQ,][?&Q(R,I8VEL>;F7-)\;ZC@@PZIURI//]D
SW86\,7N9P4?IcS+L_^d@/=L.3/c6IZ5H3L7>-CMVffagCGO^2_@9CGL=.@X<>VK
<g\WK<WW[A(Zgg6[/^-F+befHHdD#H5(C<1TLM[FO22,3edV)VCSG^MV-.5YD/W2
L(_>U[D)bKP&dc>,J5TTL;:F-g3B/LD]+Y[:R5-20DYg?^<IeCJZPKCM#A7GXP4A
F6c6&^NeT&DC/(H1ZWER^TBH-O7^)<Y(4C-XXX&]8HC)C6eg0E]@+6OJ&6Y^f-\0
N;Bd63W9VC/Vf@Yf-a1K[QE.S-M)f@(fD;AY[6T#1N7\K_/TQO,\dZ[_85gD4e-:
?>-TH,B8W_H9+]:6bdWN_+GWC9T[VgER=F,;XGOcVeg3Eg-^&O1/]S0[55[,&L,E
WWbNW1T>BBZ@USDV]XS0F5HG&cVZ4K+A_<,\F@F=Q^Xb?BQ4KeMJ1&QX9S9;V0YO
L[E(1;AJ8B4BC2<#^^VG3/;X?fH&a5MX@+fNBg1f6EGA(MR1K\D7\VUS,=2](93@
=Vaa-C4U&GMZVWS.eJ7FgdG,VI\e5]P:KfB)AUgIef4O1VI,4MD9adI<M0CeY_L0
M-^K0EO]>PP<[6S/U\8=c5+LP-+PA?E4=H[Q6XRD651Z:YXJS)A-#^2T#<BREU9O
5K586Hac,#L(>8#<?+=45G7J=FHQgL>WGDR,GQ];HUX3JV.)18dFf)CB:CVUMc;6
<8[SLBU+aH=4g0#TA#GfR^fc:>&)N[1CH:49S34S@PT2A^&C=f-0OGgddM]P+?Bg
]I1[G;e(E=Fg5NL1GPUWB6I7&W;5L0,W6J:&(;^)cBNBL];BK>5MCgVBBQ[Y9E<4
fA2bGVJ/UGXRcUS+8W[b2Eg8ETD+JWWN(e6.1]aZX).[.VcBC-0_IdQMD420B\GL
#NX=dT2V.aP.DZ+\SJC1M.SQ2869_JOM&+DGA1?cE[S//4&d5[G0aALY4[:(f>7R
aaEZSCF5I=M?f(/32,G0S[g54Ce=E3bf?FC<&5W;TOD_18RZc&e6_54GfAcKZR.L
?dTE\d#N-Eb4QK-N(B1#MW,\VH]Z6V3U2=4^Tf600CSId&P^60b7AI-a=^^8McZ5
21/gOJ?#E[0)EeG.fH9^B9_ZPb20F=#(b9_<VL+gX_>_7B1af.0.OHZ<C<fLH;KH
-A<XMAg>0[6d5Lcc/@e)HEeT\=T<?(@OWZYX_:2)19DcWgb_.?M[&JBFK0RY\5gR
657)T9+6?N9E;KJ)=;H4.)N-TRBNFPeEJJFcI)I:/9TYGDVYS6HKI\5-M#6B\/);
(6=[XeP56SF(J1Y@eLf[3.111LVAPf1OeHYELF-)P]_R@0Be\V;0B<#47A+=ZZHb
()>?,1=LH@\20TOfL.5F4)6WGN]+XNgd.HgO.4bU=1HFI6WU\T<0#_.=QD6g_3fg
CVEF[EGL2W1DRIN_T<SO)C&e>AC:1J8NWTM4H;aP3QIRJ09LWBDA4+^VL?DN:FT0
VTIACEL:;5S[F=H;eL-;_fcL.Xb)7dFG[HRB7QZVF131KMJLX0MGI&2E:N>QIb__
P.]0=]9=a5ZX?C<R?QaG5MNf5DIORJW81)(GDVbTDP)\D8O]JNGdDY,e1>aEebG\
cfQ+TL5[Ve^4K0O]e9&MWD#G^#b_S8-K@(91SXgeG\b?W>0E&E;,0UgH9+eDV;7<
2CfW6_2@,Bb&VLGVO,F48E<,LD0(CbVO:(@B&)H@TbYW1f9\/;1CX6egJZ&gRA@e
\35W#:KDcR8-cVLF7/AZP]Qe>Nf:6XGH7\BK&C>]31NbJ-d\0=M-dB8XOUaNHOKI
X-]GY.[ZJ8DA0-c_>bg=;C9cg(F,E7A89)^O=eH?WO?b1RK>FSQW?<SY+@fd4TGF
eR0@>Z8GUY^.?OB8e3KgWE-]cT<32:9XT\Ze<-8ZO=)M3a=7&fZ3cS:+E&]=+Z9L
K=eH31RO1,)+7?:7]KQQ3gBGH#XC81KMLA[7+Y4QROgB]Y0/E79C/P.X1B>F1/BE
D[)7/5T?FDJL6@W^a+f5WcC)dP=8N/e.N6?:c8=NTO6.8J87e;1MHK[UO29[<:Q(
?aW58&,?dD15LcG^fYE)U#37;X0YVW2-55J1I3Wg\B2C(Pd_[?4374EM.\B:.GS)
_):DGXa7YKC0K2Aa^9KO-MV#;-6N4/IbE][\1.LB2-0^6R@&\:\)7EAZSX)&+1T.
4+Dc_BgL#,M,@#JPe1EdQ^\gU[cT9F;.-@NZ8VA\Ba\g>PaD;BRZOg::G=I+g4^:
UM_C_U[<1#,_#1=T.38OHNG@[HAEZ2b6V_];cV&MVH:E71R-7\O;D8MRD.MIbW)6
3O2GAa@MA10PE\Y(&D)Ie0#RA/(>Q=G?=[]/,H0(3I^CVc5W&4^4;Pd<Fc]]5-,P
0:&52d,C\/+,R9)Me,G38N=ER[2G&R+3+BO47C[G=P3L8VX5]L-2:XZGe2UM)\]/
(V\S0^7fT/9d\3@;N,H+(aXGCIO1WG_([])R=<N^I<dQ&8@,INU#fRRCA@P7daIQ
BEfSB75Z(S)X@4<c;.--<7]E27S?;bI[e/(IE1WUYZGg\XMbBgXBWMe8>UUG4-_+
M68.I7TYaIM]M]c.#YO:8TEGQ84P6IAXH.eeSgaM3YI4NNG\@2AS3U0gIDU#8#K<
2<-T=f0JIg+#K?@cCYfQ1](U(7NPMF=;dUB4Y[\T]J2P5[@P6^JQJ\aVPVI1L_^K
7?.9T;PW,7a_UAI70S\7,S:7X\@d[65QCK1#^eQWDZV,_HV9^fJ2/6^V5e+bbbaf
6,9G^.7bL\.OeOFPQVNf9S)Fc&]B_Q-OLZGP>>[.&A@\/.Z?1\T)a>X?MR9aQ>Ka
=+.D>6Sc4R4^9)bP,C9>G2Mf2C<I>M8b0BAIUB-^<YJ2aUWEUW?WI\-?[=)bDeeB
Y3cI_@NOO/\fZbT[KQAW9:d<<P(Bg4F76\:B9)aN7G=f&KgJS+c/c4]@g9#@d<eW
W2(O+-#PQYZ+\/--@O@\0.Y<Ug8(9Wa4;+FZf\^_7C4aB1;9);IJ3b:f/FL_9Y\^
YAHA<b(1P/WfVOW:-R9Ea<#FJI^TRc=)Y8:ZZ]A+H&.0,<PR\QBWX-@IK?Eae#=T
=,fT_VCKOe+3e8(I0-H&Z)+PKT&Lg_CHTd0_1M_\U_Z9)A4,JaIQ[MV-OC0^ZSUd
?+,=&bOY9QJMCbLQ0=g4K.e+-UaKIAdTAB@MJ>4_HY(R;&f6C.APR\LM651PK^aE
fE5ZYM[-&5+b#41:NHgHN064@DaMIWA_(B7?Q&aK=#6CHM.NR;@0+@@GRW\;EUA.
#])R,+#.=,\ZJ9ae3N]e58&^=.a39>JK7[8XB-.9=/>Z)@#Z??27DI:MDYP+C;,9
XcFE_gD3V>KHT_dfN]WN]U\Q&[@/3IIZRGcUU+FFNLLKPfAE#d/2(_2CCZ?W:d@_
L8A[8W294B.ADKS#LJ,5b5PF_2R-F74I)P@PAL(QZ&04XR_H2>,YF#;ea5+.BL6P
.70IRgCcg<UXALYe]/J7X)g,\K/@?c@;(BK)V[2IP,OEV\&aDO?U0_:P?NTD_=Q_
:)_UHH[B;VC#fS[SM,?ZAX)6:66VLI(ZTP+0VB73?ZXD<ER)+P-6;ffUY/#HM-KG
)\f<cI#fOa\d,gIbYU+[4C#GKW7N;b(5J&B+-WRbDL.#2-JbW6+99T9D(@\XB4gf
1RRG/(L2S#MNS&.(K;CAWfeg9>7RcQF7DZPWb]:3AMT;Oa;I>_09@=POG/-VWJ.(
91=RF>>^_Q=9NM0N#PZI6[8,]4A(>_G-Wc:5a]^5V3/(3:UEQ=@+MKS/2/#]X6BE
ML:(.W?f==_^GZ_XN8T,NBW^ONCBC5<BNc@dIVbI:D6(<.?,@+3L6VcD.DIQ67S_
@UDO,C.76[G1]Hbd>-0f;[1a.S:d48cbdXHZ+<Hfa&)BN)gaZ<UaB@C1d8WBdBUc
KXRbg^(U,E(X&a-fb6I;[U&Fb]#Be64G9Ed+?4=g;;B<@>?MOSTT9K-:@<BcG4F@
@KU>]HT(ML3a\)CM^[gGRCY<e.X\=&DLbPaQN0U_e5[Oe)#SF?#\&5>gIRTHAW(+
U#5LX4OI<ZbWC3DbeeVddCE,g&/ZXNO70BX[<X/ZdU(<FD/&:aJT@WQ-P^LU592Y
O^#JS(baH3HTd,5T]>7+,6B2Ad.;1BP]U3H6fM]?O,0=Z2,+:^e#5RA0X1eI[PXE
EOZ4._2,)#gOe6U#DWF#HJb-cc2,44fgBLQaP=S.P5:S@0_X6GB4[8&1-:-L;]:e
L;<_Y<+:WGD3gJ0Z#D7GOUAgb</S(ZDFYWH+He1A:.#I-\/<#d7KS-KJDX@O/X&b
4574g9QP;@P6f:)UL_TK8P&\J;/L+g&/X22-3(fG60UWcTPF<SW7Z=?Q<0eSF3Bf
45?BTK#I0QH9K0\<a?8T+Q:,P;T)G?0>/:KR6O(1JHHIe8#cc-Q88X<G:8e6eH&9
6->HWCebA/Y@9e&7B(]M:Q5IfTM:)KIE6GR:6=be@-PY]N,EPR_X>6JA5/)=)Ue<
XW2]<7S:YST[>-1IR?B9WgP/2,c^RE#HO(9QU?DG0)-W92ZF23X4B/-5,V_3]E-:
V^JeG=O#,5Z7OTOLSRd+P29GSDdQfZA3+-.O?FAMEYS[>JV6.K4F<-G,T8K<1.<\
P>VABaD6L)Y-.PT<Eg7e.gPXCe?OS5T9,aK3X44_8bSGA2UZ2eD9f,1,Gc#bD^#8
=R2-F1+:c1<::b]_d]1G@0ZSOdK?#Z-I-RA(P&9WN>K:Za9>_a(Bb<[NcHeIUG#A
HK07F6@O>4b#=8?YPZKSXa>3BY^-H3CN\(N=Pf(XE2K>8B8(2>6P8aB<@\\&8+^Z
VI08HeN[XQ7K)BLIfCL^\b&d)8bQ^^1QVX-++ZfGbfeNSGA?P>&?Oa/#eMCg8U,0
)7[/B@D01F-PCZeS\6F?2C=3CN&/T(/6VZZ[a+47LRUKaA&(GO;(?AbBc#F)CX>S
-C-/8^SURa,FP9gG:XA+B]O?U:RE;QKQ@WBQ,>1+&[(CYdA=T?AH8[#&6#gOP-@c
f7D^9R2d0O07&]##212<HfGP<aSbWeW9HLG6_:@I8de17B0:e_bc?=C2ILWPVPAG
c>W(Q.g2=Da\X6#WCUcB;dNN]\WOdbN702bW97;_U.)IT^WN7J5eHB(g;aO4d<,?
8aN1Z07-6,GKN>g148>NAC\XNF5V\BRYI.[XYR3TbNHNOF1S+G1dB-IC8/=WZgT3
])fYQAZcf/T=9g9KITFSK:BM2.#K.4A_O_OCPGA3L8<A)XA]4\cTKc@.46RSQ8b9
.0CUD(X?,Z]84=#:N8SCbRL+?W4-D?0C3)F2A]5RQPJM]LdF0LNSXPJ8_S\N8.SZ
&TbGF[^LZ;4G(d/2e?C^CN.C[9<g9^QRC=.L_QM@7U5^cQYDJX)GZZLW57YY;g_D
PY[Tb.L>^bBR0dD8DX1ZKW8V2Z2V[P>\.QKL6?/V&P47?JWgG?EUSgZ5fX_Q,L-e
=B-H:/_C=02\cJ0a>T\cEB^(<;aE@=SZO;S#S-ZX\GQ9<6\_C#)K7GHH07b_L736
A@(,ZbGe:;e#I^dfBC)^V?T0864cDg+0-b>X7PV4BYV.fI=S\IXLA?>?[5057-H\
\[?GV:8g[JW7cHWEY>X.g3#4R=60=0fA8bQ;2P=H#PO4N&9663T:4ZN8-7E&#&f8
3A-Kef?75EXg(K(.CIR0)?&H^C_8NMa9(0<T<\BB-<EG@1[#TdeS2);.:=^AQ^51
&&^J03a-E#_0SF>GOPU;Jf=JKU7QNOU;7/c7bF?F[]KSbS5a_WV1+<&N#bO9=7V3
(C_#.^0)@GAS#]?0DcUV&&K@@b(5.JQ2Q55F,f/b:B+S/N+@#5130d3Ec)&4V^MO
^B6-LJ[a&R_T)?bEd81.UG+c.FeX&R\UYA?):SNV\;KD^8J181&U5.X1_:2JC#-3
)^[T8c::](1fW]a9)aRNg6Z=M)Xf<cg>@<OId:[@:&.5D,#MBUPfBFW5&<FL@NcN
N:ebCcWU[SX27.7gR-H+]-V+#G?YOT/^0&7-,3ZC63Zc1:NUc&gd?,J]UQJgM1=S
M,2b.]?M.Y?:d50.+Zg9(H(0Ea])D<<3?Q\<]K&7VM71[+Ud..FW-@>J8Le#_@<F
[[EH\+XX\=d0S9f=J:U(c6;N)/\cBR#8F;CBfX/J46gKeA9+&<e69^FI7HgFb1Q^
@=FSA>g>K<PZQ\6>QJB>G/-\^?W6BKIHYe5P@/;(?8F5NI-;D&X(V13_CN_Vd=>A
8J9(L_XM#d/5JQ\G/bPO7I9e?QGTcZbN#H<I-VO8FJ4LWO]6HaK8AUM,WS)UL^H/
7G;A+;4U\,3Y[Z#S8/WBReE+,9JWMdLAN3gSf_JUX\]T1B5#SXPNPYRJ6=/YODL]
:TQ21\\D,DU<7O,I<;gBcR-+CKeE>TJ[ZdH:Rc[?AXF.;J^d+@G<XeW-XZaRQXVP
=_OdLDOV4QA1([ZN8QS8bA=E?NHR]a2(acU3G[bP@S#ZMM)-C15,\Re:Dfe9Q7,,
#MT0+NXa:V[1-<+QZY-Q80);HSdOGaHD\9DQBR#1U3(75Y^Q&<I0f2?>SP64H^c9
,F,eHDOC>6,\DR/aD<:4ZQ=f.HL_3Y76[FTS0NUFGMJ?N,KD)71ND>OW8YM648L<
4LKK0ADJR<gQ=)+cRAXL8+3IeH,+KODXJ(<Lc=E&\M1:<KH9YIH1\)L5/59\.DMG
B,JW,?_?BW,<4&1U.LXZOe8ZaCS([709CR(]QX?M2?+-6-RVA:1EA.M--:=+\V.-
7FEeVX:0V;/]Fcc\_T1[7)fC#90V36\dQTQf[I-5QFGgENQB:E#/T(^3]K,>WNB>
N:cPIg8b89XL);/@FQHdc=:Q#EdG\5@Z3g;B7H1O?c8L??&_SK?bOLbe,:8(BV@0
RgfN5.A[g[B=PBB\E1)G7C)g-7O-b>AZ>.>O]T)V<RZgFNYYBMTAJY1+g1OU++\g
W4gHJRTab@97:.;fF_2C?KSf>@Ae<M#]0@?d7-J@Ye;@K_DXX8>\S0C(,I7G+.B<
AI_?YBdQ6)DO.\(:SH==>GB3;C@BR&.V+e>JdJ4-U0N#U-N/F?JD94(4,G)K9KC5
KFQ^#OIcIOcUe,WWQ5^T?XZFA#\HdHEaJ(<XD.MMR=EHfPaFSOAQLJaNfUd^FIH:
90^H_(f,S@E4X=;LC,fS@SB@[aZY5:OIY(K,@C3=NMe&IEPX.#EbfYC+U9/>E\3c
(;,WP#VZ7&daM6GBEc#e5[g4M:fNg?ZN/b7=CXGH#)Y<0\aK6&6#^5(:+SFK\H;[
_9CPg=SK[/XL?)<3,1f8ag9-@T.;DM;C+Z#c+2L;:V5BA(I+Q?[F4gM/I.c:VD\)
Vf-S0]g#DNZeIa2Q).;4bgDc\I^b2[DA;>K;L4RE[]FI5=MU@):O),P-^O4-QV)f
GBRJ8e-c^>?fUH:N2aEKf+0cQDR-I.&3=^-\A+437EVdUKCD^:A67(PZC1<?[RC:
F7O^@#5W?3gIQJ61WJ7Tc>G[VH(,7H4R+>N..F)(fEM3?aA?bJ3R-W=N?0Pg^0eB
\7H8cW[ZJ+XO9K,)WY)G2AE(d?Z83?@NRbAQAXaaF0=KAPMY&<P:e;2T;Vc<R8gZ
1UdU8&c\12Y2-3).,/&J?gG&C(CFH:KG0_<N:e3=WW3:IB>>T4Q-5Qf2[@=[</U3
F#/E<>KAbRD4E7:2/TI8R[Og3KROSEEV_8P8CP(=Kf7SV/I5fTc?fZM3B,6U<J\U
QYa=>cTg,.?RB2N(I20\:4T\08g<ad<gbf_?dVL(aDc/c87AS_ad@WOK3YMAceK?
^-E0412H#LLgEa6070=a?e8A2KNEP#<TT]85R:0PAXeVL>>2aL=g&HgD\8-G50+Q
<5:=\\P?g.R]0D[OeTST^TObPJ,7QSNZ:9g029J<;+-7QD<DR\bd5)B<+VY3E=Ra
ab\P<=GE2YUDPMHBJXD_fE;L_6EZMC\8egKG3f_F=0f3E=4A,/?<g\Y;YNLAZWXX
?U6),BgeGF.ag:aHYG7R4B9(PL#(.RKKR40XBT>CB^^WF=3_)OV7-?GR5N&?3[48
YQ?8Ud=;Tg?3V\ef>H^S5I>fC9C_?P0aBLM#cJ\1Ka9L?2ZGY#7)54638#UB;Y]0
D:Ua91VIX6<Q-A.__#6dTgJQ<4/g2,g_eVKJ^;Ja97]X>&.1A>]>PWccYPAPH7Z[
R[=0ATRC[6L-=&EL1M;X<[eAO7_DfdgW3(8\92-B?>.TS@SE3@#LN7Z2RJOOZTBG
VXLMRQ+0f&O7)EM<b<4(S&C^;UFJb?Oc,A/&&7\(M^331@Aa,D=.N(EZ;1@)&Vfd
]..I)N(4Lc:CK5#_.6Q,0]9SG&QYB7:bUeC0B4e[X/Vf0U/412KN5SY[RY85e0(;
g9dg4WS:2;4g\6^a.1_/aQQ.FM;105E[gOO?K]b.E/=_0T<4/J(/73VUJ>=>[P;\
0SK8J5)gfH3f3;19-6>U/W4g?M^S_=,)KK7&>P(7>g<K-(\C.5ff2T+J=JCZH95Q
dA?-HC<)[G?:53@,AXdP8RO-:eS\bJdfB<6W:GS[VP:Q3SPgB&\EST=,<_XIVaGL
.@,=-N\?V2A+E@YE:=>=59<\8Y.J#?6L3J/XTVPDSY+ZE9RO+;NMcf_L#CbfRdEF
HI@7\2gXFc#.;T1VZN.O(W<<gJ8Ab0,&0)0M8Rf-8B&0b<,b6YG8OH\RT4_1?<Z7
/\X<&H?UDUA=CY<#VQLG0J74DSILO^6?;79_5Q><OYDF8/&2P7K@#YZKH[Wb4T;T
c,Xf0&UAP-R?XQNR.DgC7E++#.Q/L157A&>HO[7c>,^ag5?0J;(6>CA1WPCLJW=Z
:7b^H,XQ<MTbXPae-I/YV;S6D-?&)=R=_g73<4SUWB8Q.-UU0a5Bd/6Z+ZN7..@)
_+G#DMW91dO=fGF:e_:6G+fA4K?I&)6_Z17eT)1<eMX30Y0Xf@1PG]E+)0_/]=WK
LdJQ#Z?^9g-TW4:R4,9+MTL^6R=&[>1U3:L@RQFPW/F?8Fd^@J?^YT\CN42gK=)e
B/Vf>XO9TcYX:EKf0.0&>61_,2S=aHfL9>Q#FKe&19:c3#SAVdNKbSdW)Z,YY4E+
-=dI&OFb[A\I,T<.afJ]<+T5RHQ+37C&HGW0D\7@L;(LQ6_g+NR1#Eg]APAJ05DT
]9cHa=O)^LEOVHXBMRPGBOCZLNK._Z?/KA(CPbAH0BK.<W[f&\f+66]39BG4A)<g
-^e#[a<3GM/L7[6INZg4JQ9?+cAJFJ95?1[gMd>7M5<]D;A>^+eB]OHL-+E_(KVH
[O,L&dRA)W>LS(2GL2&>#<?3<6&0FXH@J47U;;\=#\/MMb6+gJ\.;W[\?&=)=fEa
<^0QKCbaC2Q[V\DT6#O6EKLgSIMD8Y06XA[#]B#O+NNNITR1.0\Q8T@LOaL0PVK&
U/4JJ@N8UXV4;:F>F19R\f9WQBbO\6CIdH73TcIVU0ZZ7c@FQ,YO5@A-MO.3Qd1g
#c=K[J.RSbdXcb=#d(GaBcSU4=f2Rg:NZ#>W?XbG[?R]?WaD1gO\-/:3^PJ]8T2\
JTFM9\KJ+/TDOaARD,V870/=@(W-1UKTaa.B\CTaCK)NbLg;1U;]58#/PIO3)T:8
ZHcVS@7\HA#P<[79CWgR90\T>T)4)#(U9-dU9MT9I\^BY/Zb60]DS_eG35_4WOR5
XaQ77+NSH88=88Pa=TJVWFbbSNPCP\<0;0-I>LC&,Y0>O^5E1_\EJM&>/K]<d1NY
DD)Z.gN:\e7E/FeV4cIFB#.dRbIOA7\P0Lea:#+6MU?H]FKR2N#/e#^GKJ-Nd[@V
LTI9.[_9gTC8eI(TSUaHU)1V5/:5+c52,:Ae7G8X)FJ04<]=85.OXG_Ld5+9)M4E
XE/B[_-A=II@G1H3e\>&g&Cf\ZCEbF#,f,\@c?7LY544T2-;4_ceg2<<A)AY^,8(
57=^.3c+BW]g@TVGR8=^&b6:\8+&,5#8BKW67O6BaMd)88X:Q9.\4HWXU([>M^36
W?CNJa?+RF)C)Kfc+_E^95e\U#DTS5I6A_]Z)3I?fH>]GLZ3f=-MU#N3P@9&1AFG
70_Rb/+7QI/],bC>:GbF-CC8TO[WR8CK&Ia^HW&O7-P5V\=&<)JJ9GAPScE4.3IM
&7+bFQcb,-8)T)]T=+C;+P@]5ITHM.JR6IKcHD6[H9_Y,RRZ)4=aYYQ[bS:9__;F
FAOSJP+@0/7EA\W+W.RW.J4g7O,+XV?#C)-Y5;U-X1Z7#3CCeV\8/<.0.9bX#gBO
4NGA<TX?PC#^KeGPA&TNbQ1/Nc)dD(HfJ7E5FAFOaJM[YH/I:,,2g\5[FY+=D]3\
=9N3XLINDP1,]TNB?^Q?0#W0VeEd6Y-CM&KM&aU;-gNDGX9cF.=6R.XS]AIU9&5e
<&O0HD0eTJJ-e6W@/:G+@<D(Z86HLcOFUT8E9&<dFXcaU6AdNcg@0L9)I-f)5T7_
C-c,HgQc)FggNDd03GDYDfC7^<-7P=b<Vb,.Z@3#O[A\6[gVL95WQ=_bZd0ZcKGa
V&-4=5RZ:fc9Z-N9_LIV^Q^=-SR8:9ZS_)WL3Y(J+654>CC]Ma;bZ6E&IK?1Da?W
@0(<dTa3TR73YA14C5;3CXQdKB7GAQUd0-9-;<JC>A(S@Wd3V6+0LKIRE=\/Y6&5
^]ZE428Y)UP)8fd0c]V=.@KaDG-;Rb3B2<cNVKC-1\g@d7=HIf[edR?8:=-=RM)>
/NbZJ=)FeW?PIZO2a7Q1b_A=VFBWEB,+L<7Y9YL6;:&&=cE&<Q>;&7dPfK]^@82I
f8]T@[+:dEZF9&)4..30LFB55;O;IT8aJNgReIfcG,9OEg_^O3#D?NT]MPM^UTb[
V3LY)JA8C5):,7J;+H)0KE+?(XV&99^LIIbK:BTD0Z4Q-(H7a9ZQgIOa^JWM3H:e
X17T4F.f\&,5cFX_8_@9a<g)65K@[/?M.T>+^gH2(M8:a6c2R&5>ZR<7(N\=9#f5
NcZ9#VG#(HVYM4W1ET9_b.NL8d1TZ1309.D@00\aSe)\=Z)f>?[>/H?f^,#VZAf&
XV8-LGTKJQ0LR1F;G)EJc@@>(SfFW,:>MX?;g^a>,Hg619(KLggcHB:BO\2#>^_6
P;RU[8ZF[C:R=fT34G.JFUM,/.cb#G:aGHX<KBJD&949eQIZ==Sb+cQ+>[ZK9@HI
cPf@_P3b7XbCe,7<_5Ef]MW5ScgT]#/\.?Na\H+4<09;QK-)R7.PU:N=f?UG5@b)
2QR8>+-VWZc)W^;[]Qd<>ZgYWFcI<1edPXb>:0eAfPOM)+4<\J7c96J&\IWaA;<=
#BFH_BMA.C=KO[T47\8L><LG/bg\;I>JR)#cQ<I,,M@G(4X;S/TL6EC:2bc8;VV>
D?9)d=:W?1NLa\E?ZVQfII,CO<aTRbA8?Ydd1C+Aa8fK&XVVb)^JI.XKX2cg[e?B
^W=>-g/f&+Q>>T#R.5.Y6U<EPP]_1=,dB4>N\d(V#>#J7&,L49;7e,XY3C631e\&
&+4Yc0Y3QZ/c/^[_F/)6X5e;.?[H<0==8a1aKW7IcF=:fK_GGC.-;E6,L3#M-U0(
ae/Ta]WSP_C_75AcW5b6YO.7L#L@\_g]F@d0R&1)I>[=);fLfFH+X:aDLcVdNK#b
Y30?QP1GVP(dKYG@d:e6UM.GC1eB6NUA=4G&J3PCgg^cacLYO\MVJ48XU#eV&PO8
6\[GVVN1G50/RK<=0MI2-?K[VV0KYZ0Q#HL@Q0e4M2/FR>f^1-HdHSTcMH^MLP_P
P:4XgE4#5S[:=.PedDH@[A5/XSJLVARK,I^>c@e>F5b)S@gG-4.6X#-\0YYQ\QDd
)0@eQI=Q2a_8SGfZ?SRaa&EUB[_&;=?XXY1>(P97CP@-T,:GT,EB\^]d:WK^,W?7
EI]I\-e>)ZdIRS(<-ARTYB&CR6J9ZKaW7U0eM:XXg);HHE?BBf.>RgTdGJ#RWEAR
?DJ5^:],<U,e@\5SL)(MbaNadY7Ed+gbSOF43b/W[5f4-4e;+Kb5)KF:6Yd[ELDK
G5W--?[>/cNeS?cO=g9-=9:3RS5aD[4#cgKLS>ILfG:8IUI_U68/4JIG-U?)MOF&
MIW.H&^JP@;a;3&ZDHI+SHRTLF-AD916)BO)-f3&e087)3^/E5C0=/g/\5GdRS,.
U<,Na&X74T-4IF(7ABGMDO=W-1G]HUc30&RQgM5f@.A:D_H63\aPM664d0AC,(H+
R_BcCR7Y+R.\O8NR=dJF2(A3)-cL#&A;gfJ:OS.Z#-<.>e8]1.M1L[+/&?P9G^G[
OQbT.HQB:.Y3MV=G6e_RBQGbE8PN?a?.Nd@-d?K\,I2a[<_WL\D9P]089[&HcgQ<
(bH9_4;^8O7E@,1?2CZ[XWTN]2eOG^cMP)VJa0>3Ab+0+:F6fgPB0J??5e?:cEU&
d&ZZQ^U<#L;EP/=1;a9(9Y^1.WQ1KO^D[IYgDKR-60bTa+7V8aJS[Z>W\.C^Z2Eb
SO&^Q8+K+&XMRAde&8..S\Zf;Ag6_Z0Af6[0+527RAB]d^&a5J>ZEaZ=-LP@ZR0;
c)R=Ig#-T^g3B]#dT(HgW4CPJ9\D)B06JeL.0/@./_M]dH-+?0&B,OGC5(BUa;Uf
#e&?_DEN1^YG)NH8B@ZebJf[;BAJ?@^B;W&CD>FP6Q8.K\1=IR>DU5ef?G:L0A_3
^ZKS7@I9B=0HBBd[0b:81bOeW[M?P[G9/D7-WJ?@1P)\MBgI#geU6>HKVLQTTALU
JV74[:(B@7B.7R70#RT0KOIIC>Z1_g#2c\OX]K2RI7)06_@ZC3a>QM9D:HU\[ULH
CB@(87?AD^4Og/3fCW,-Bf3,IX/D]N6+V/X@G;C;]LCI3d-fY?7(cP8Sf\77?-&;
2S[C=f,QM>@g\)X2ZGEbAOBDE>;C?/6VDD@fMU:=P+_K192N/9S7-gQ)T3X<?M_6
eXK8(M2B:1C4(L.?^=F,XJVG\;#+=4G5/L@HGVS)RH=:Q8?Afa#MEXQSLd\=1GN6
g0A0;<IS7FMe3bTfZ4@.e_1^^A?R[a=M#YN-2L;ZUJ<L1TDF7TII0?5,bKKffeG^
-/LW;,aD-c<LT/PI&-Y?FBHJgVE)FaKU61GJ9&F.H-ScL51P4#H2[981:XD+&aLK
(#2RWb?R2BQ]U71<N\OEKEG9b_)2C^EMKI@OMWe[^K&<5+V#8:V[dMFIC]c;&F5#
_?5bVZ?L\<FBLC--eG03e<FDQ)LQJGMUTRd+D8/\Mg&D=MM@aUWWG,d=d+TCGY@e
YEY_)^<bV#;C_YRWO-^dI?:L=;(cZ<E_-/J@6d.R&FFdPe6D8/fQ@:)gFc1UZ&)M
O4Jb@+S@X9d_^A,Jd>-<Y^\EM^;=,T1E(+.FD9R0O^;@X_JU]a7Pe&cf/eN2(ME;
BJ@Wg49b,a;eb]Z#2:[7QC=NH4gW-C#6d-)+<\=P;TTJSPZBE+HH1]K,@GcL1K7J
Z,&JSf-)1fBI#G#c[8[fW2Sde4CgPd_(_-VKP3/bYO.E./-H>b8^R+7G8gA9+AK+
UB6<:=(E@\c9;Ae;2?5RFB]6S1?Gd51RGA_NG=T;R^.@Y@X.YS[I<b6=U/FcL+D7
65U5()FB.497S__c5FDCf:-L3DU,dM5MO\PA@49X(V2Ye0[^MQ?YN8b#ER7:fE-]
&)O&0_V061AD19MPMI>O8cZ+gLJ7_gIB)+@gLJOXPe<?,^PYJgQ>Zg-0+H&I[\4E
Id1<bad63gA;dZ?#IZ6I@0Ma275VH:)703JdS9;0DXBRTE=2d8[I/C7_R>aY(XEK
N(5L4@DK+(=7WH=D]##4;Cc].KQ)Nd0&,JA]SB<(_Tde?P:/W;0]6?c<1>4A,c4I
W?)H#_A6\M&W#ce@]81S9BGX@+d;P/^EGN50Sb\^&V8T:HNJJE+(W;?\O\9U/7>6
[OHG>bGAdU_aEg)/4S_R57G1TH\U,c4d)<@=E8N7R0,_&e@gDa+^D77O0>3dXPe1
:=gESR)NHCFce^I+E7VP\FFMUL<g107A9YN?B_\/2(CfO@MR,2.fNC>2,G3N:eb,
IaPLJePI.7MZcN.1ca4)+_C@af[U/d(V8JBc-5HV[92/8A.a#:gbUQ21I2F/A<T:
8cCG.25ZPKV?-B7C[:Nb;@YJ9L<\I=_d:gd/C]]R4NTa92M(B]D<H(0)DFW0Vb#5
]CQI/8MWIXY<(N./9e6dTKQ(ae4;d?U@]]PX3_bfIYaJKDd]]]a58(eVcEPD\1GJ
NRa1/:b,2MHQ3/)1/UIe,_/M4=+J7KL^Hd50^P_W_O^,[U+L<#P?(JO5[&L=@USb
#00+.F9C1NfA\>AD(FH=9^2d+c<#TB?0_RH.AFc(M(C_,QU4F:I=1)/GEe/2/gS1
aC>;>:F6=<@_8bJ1SXOF#2B7IGY0H6>(4F(+8K8LeDNP(Z5J;)#@FM,e>P)]B^;Z
EM;_X6V6gg2e;#XV.YD8A:T7[+e/6=M[e\ZV3GU5E71PH$
`endprotected


`endif // GUARD_SVT_SPI_xSPI_FLASH_COMMAND_REGISTER_MAP_SV

