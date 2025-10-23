//=======================================================================
// COPYRIGHT (C) 2016-2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
// The entire notice above must be reproduced on all authorized copies.
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_GPIO_CONFIGURATION_SV
`define GUARD_SVT_GPIO_CONFIGURATION_SV

// =============================================================================
/**
 * Configuration descriptor for the DUT reset and General-Purpose I/O VIP.
 */
class svt_gpio_configuration extends svt_configuration;

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * Specifies if the agent is an active or passive component.
   * 
   * Note:
   * The GPIO agent currently only supports active functionality.
   */
  bit is_active = 1;

  /**
   * Minimum duration of the reset assertion, in number of iClk cycles 
   * The default value is 10 clock cycles.
   */
  rand int unsigned min_iclk_dut_reset = 10;

  /**
   * Minimum number of iClk cycles before the DUT reset can be re-asserted.
   * The default value is 1 clock cycle.
   */
  rand int unsigned min_iclk_reset_to_reset = 1;

  /**
   * Report an "interrupt" when the corresponding bit on the 'iGPi' input signal rises
   * The default value is 0 (no interrupt enabled).
   */
  svt_gpio_data_t enable_GPi_interrupt_on_rise = 0;

  /**
   * Report an "interrupt" when the corresponding bit on the 'iGPi' input signal falls.
   * Can be combined with enable_GPi_interrupt_on_rise to report an interrupt on change.
   * The default value is 0 (no interrupt enabled).
   */
  svt_gpio_data_t enable_GPi_interrupt_on_fall = 0;

//svt_vcs_lic_vip_protect
`protected
ZRI3J_SCV6aDd<\>UY>3:(a)XE22D67[Pd/>1EG1EgIQVOd-A\_P+(07P/#N_9#E
CCYB4#(8][VI(fYP_Y\YJ(4-,1PI92(eE8]M;[#])g[c8L1DURX2RIKV4H^&AR_E
/4=6NX_=2;_Q&GR_3f.G]M)C^fS5)2ZNgR]\Z9Tc=F5OC-88.Eg3#U[6.C1#?=Ue
RdB-7dgTZI4KKVL<Q1<_67=6P.L]d+Q^ESGSbcUR;S),3:Ra2W2XXJ3YKf3ZU\5=
FMaYBY_<N-H)1#1TYNO[LJT_DIG36d0O=0,MfX29#e092d56)S03XG3YM$
`endprotected


`ifdef GUARD_SVT_VIP_GPIO_IF_SVI
  /**
   * Virtual interface to use for a VIP.
   * Valid only if 'hw_xtor_cfg' is null.
   */
  svt_gpio_vif vif;
`endif

// TODO:
// Need some constraints here

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_gpio_configuration)
`endif
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the <b>vmm_data</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new(string name = "svt_gpio_configuration");
`endif // !`ifdef SVT_VMM_TECHNOLOGY

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_gpio_configuration)
//svt_vcs_lic_vip_protect
`protected
-1(&_AWJd7Yd7JaCGS_6S>(><E>2T_.:7.52KRF)V0ICY]L+8B(P,(a6LaL-T0a-
VeUE2c>;08Qg(SSCG-=@H5bD]30R[56UG.=(3,+BFJ)P?(b2_8##SZD+9@>OfBY<
De[G;:cUJ]ET0]X8V7AHdVS+;#A-@)CNE<WI:;cZ>ZbSQ@ELORe+Z?+G3BIgZf#5
7/,#+X0gV^()Da7(9)JOQSH2<RI-Uc83cPBF,:UWQdg@+f.=ZUI4D9@0:>UQB?_e
PKRTPM[cD[-)B]/X+Qg3QaH28$
`endprotected

  `svt_data_member_end(svt_gpio_configuration)

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name();

  //----------------------------------------------------------------------------
  /**
   * Method to turn static config param randomization on/off as a block.
   */
  extern virtual function int static_rand_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_static_data(`SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

`ifndef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Pack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_pack(`SVT_XVM(packer) packer);

  //----------------------------------------------------------------------------
  /**
   * Unpack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_unpack(`SVT_XVM(packer) packer);
`endif

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
   * HDL Support: This method allocates a pattern containing svt_pattern_data
   * instances for all of the primitive data fields in the object. The
   * svt_pattern_data::name is set to the corresponding field name, the
   * svt_pattern_data::value is set to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

endclass

//svt_vcs_lic_vip_protect
`protected
fH]dNSa8_<#T8,e3-.-b3CZ&\9=B8N[;gZT]?_]W>d8g^1:@5\S?4(^HGTcK:M?>
SN.O67;HcAKCFITHREeGeT<(YMf4NG<_68/A:[S-S):\,YFGZ?,K]^Y:[OACNJ\(
#E-MEHAAg2XUB9&I,.Y<\S(-[c[-7-0(6W\/3VZ&e<T+(_H),<[e;P)(.EZf00JT
&+U<9F9(<D3;CI<7>2&,XKKS]H4N#,?=Y1fT=#E\.PE51/SBN>+#@Yf#4&D<-W0T
6G?OI2MK.e/N&#H3<[4<G6NB#J?VCf?T+GQ4Lg;La?fSE0W)aV\?Wf=)V:D=d@4>
V._EIceQ];ZLM0Q@AI4UFI-&&.b>/#@_::?U@#a3b2?K=F@&bI7HPH?T1+@_&CYK
IONdgA]EP(\XS;g@fA3:e8fQ#ZA)4F@+Z/[\B=#QF#>_b?JVBNZE@B0C1(1]P.70
ceDI9X8AB#Q.eC?)J#XHB_:I=ESHPC98WO2PEd_BE\V-AZC@5WaaX9<gfWd9U]fZ
>WP6;S>>;VL39?S_AY>P.,1UNV1S>JH9)F^,+Y9O62W0#a2TP;7>e.?;b[cDNg85
GG&N;1Q?<934d:2ACb(>/>Z,LMZ,DBP\aaPN]fY-9fL3FQ#STRUGHXLdN-]EZ>bW
M+MND-YZV6O<Y\3_,0P.Ldc7)a?5)D<ZE505@c:M+W-gKO);27AgE#\:NT\P&IG6
T)N2,+0ZA\3M:+42<>.M32./fFIfD2P0#9Y]-4J/)eU:gGD[B6^NQ^F/7^D8LUK-
fII/.1G9?0<KNYQ6Q(Ze#:C\D>#S/c3=SZB(,?,V\[1JfH&EHb=@]5WeK+[9),K^
?7R.Y>(R1.C6LYc1.8>Fa>dePT7d_7H>A87aS&B=@R/IMBX_<2.7UT4O]/3M8EZ[
;>.?QfM:9]8,07T(#?V^LWd)bR1K5>[M98&=BQR=<1M9,58cB#7L5VH[AAN/eWNc
H-Wf5]=?[EOKMVMCa.43V6?1#^FC:\_CFGU3f<E[&<Z,S5/gM(@Ec7SU;6H5A?OX
K.4fS^:2;I<:0L09?)&<^IN;\f2:>^6]Q#2</P+&(BcD:2GF73d27/[XD0JQDa6M
dg>?M30aIJ2)>fPHQ?b0TZU63SW(<W7V5QeA<ac<(Te(<69M<<OZKg>&&C?Ub?7b
3(E.PI,3/J::Wd8Ag-bG]U#R&S?e9]LT?D])9R0&D<:L>V\M/NNB81[78O,K[>d4
7a_@E3g20YgIBC6RdV5WYf^^Nf-0SRC>8<:<TF^.eJ6+bGfPB6PMK-8PK^(/+cfA
(D/V]9+6(KZ^S5-0C<^g\\cVH<#+^?Dg+TJ+9VEc.O68]Cc&EQC[LYaf)4,GfY)U
)gBMD:W>BWKddIJfDeYf.;egeW[<?@[O/e.];O<_1-e</dV=9Ce9JC[.P7]2NMe2
-aA11O\OR>Q<4,<#-PU>ID?_1QGV;KNF-cEP6bLT6)4YD27)K&#WZXS;5-YI\/>.
Y)L]T[2NYK2C<P?_@3;Y]>4O,Cd,_\9AJRQ5^a#[cNfHSb.E5LHHQMH#)??/c^<>
XD9DZHL]2UF&FW\3aAG_52B5#<cD=4:(D4VRO<4H-AJJg[_>030\6YHeA0)9(IAF
QC<7fe:b18H3E)G)O7B@\NS<UO:=cDWL^^4/Q^6;g)>YFSD^fg9(VWQB/;e_O/aO
94L^1.#dDaOVdH#8PcQM\V/cP,bJW+]GOVCV3+#4#&L;1:IB[\L/QRF&=8C7E227
8OP8S,Fea#.B7Z+T(P=^f+)V[PbLE;A&;>8D)0A9^[<&fR+Z&^)@E.c5RY8f,]]+
:?#RQ-X3_KTTOb?+06>6c<AK<0Gg:UGbPMJ;IU<RV:8M7O)AZ8TdNR.:L6YGG,R+
Q^T</Cg9/923M/F@(M_<683b,VR=dV8&3M@VK1L4K6a@8D3BYf(^0gTG,4;J1OVH
VKIJJaJdHY@]W05-b91adY63>W=74Y^W;]-JL21WI_.g&3E<b\H]T80VeA?1N<b.
DHI+WaMY8c-+TAb&;L(K\@U\CY<TNWUdKE.7\)a-_#<X[D]W#RXSHYN7O54f9\40
G2YR9YBS:f+,#NVYf.Y9d86LLA<fA1OgdAXf;EFT0)9RP--A;S.2[85f[A1/3:/V
C2GH;#E01g(UeE^L,<g(b]=)V)I@P#Z\-#U>0H97;#QN6Q9/-A^LWJ#aX#C&JgVf
c6YGaGd<\3d=/87YHQ63G1Be\VMePZDc((>[QLb9=D0>PKFJ]@9Z[\;)TZ8N4bYY
]ZGG^;D)ac:-?_e^a3GRG=Oc&NM2#@agQ/_J^d56F>)X++<d^2I\c@e<Ze]P+^MX
-]A\3ae=H:@P(G)2KW_bEH,WPA4_g&]@FE2=M[@KdNd0/aeY\dIOV6SZ/(OFO]C7
:Hf4A1#IcO/2L5I<cPcb&b4[F4E(3PLJ#/LU1B0)DcW-CM,,bCY3=DE\\@+<:DVN
+ND[[Z+1P7V6VYEe[?TRcC5+ZXcM5B#V_#fD<>;,NK1(&,0PX89#&(UPCTcX2RDT
E2g(S:SYL?=MWLTNd2bMY<RE+Y?Re<CMbAW0M/(gfdCA[CLRDH.IJB\RC?^5S<5R
-BY[W3fS_Q(:5U1O965VLH(b6I/RZJID/d?T46N(5T#;O>a<VDY@CQ8YS5^<=OL3
;@>\4Z:HS_4UKWI&Y1]d)TZNUJ04;cB0-2B,LXH/3(C]T.8/?+edD699:ggZ;e+I
74]ZM@.6:g=OV6,#)@[;]e+TUBe6H0?LgL_e0J/cL+TRC__B-)U7++Nc?Rf4SaMM
Z<_fMKeW:JQPH[B,c[MR13;IB[<.F;@S]ZYYe.4@UC520F6]AFXP8P:\;)?;ZD@?
Rb8Y&XSCa2^#WNf+(Zg#2cg?]2a;;5=[&(.LN8G0X#L5_d;D\GR9d=(,NHdFS@)A
U&aQ-2+Z[#/QJ?R7Y0a6c#2:^@V>Q/Mc3E?YfeYOa?0Q,B@V;<(7\YQ]JI^(OTdG
<+HY4(.JHE,1<4=5G=Z[_OHG3WT;<^3]bST>TPQ?C,a+RDgO?U;D/B]M1SGdB1Yd
E(4;XVV):D0DSL2^@+V>3Cc>N968C+O6;#(B5Y05DYb33R>?a<M+@D;Tf/;YGI^3
P7([fU[6B.++DbgI6@U1D.CK79YN@#AR.RX-2TY1-X?g;[5>2STGeX\^2F7e]IK?
B-,2G,>J+9KDUPcJaX@DVY91ACL;=?1R#]))MdcEG/9=E3W_ZH)]eQWU37fXD<LL
L[>c5PQ>8a#-J/AbU1I(:Wd)3GJ98R\T)ggO)X=?3aZ91SRe9e<[f+f9f;W=J^1B
.L(XN5Q&Z]YSf7TJSLXYgfJY-gR?I9MW>45@@NO+1C,7V=(?TKb&.,(^GY4@H9P\
I7c_(6ORS\NSOAcLXc)dd-.MC6(M:,=DZ=D5DfAVF2J0fY<3@5Xa#Q5V]GOE-ddI
:C1HU>QV-g:]gZZUTCgBg0EWD.^VQD=W_]1b103SKP?-\\?9DMF]7@>O6G<e4d:(
R8Fc26/Je5cW9G?]W?S-9/LC8gbAK-?eNY91]PY,V;N/L5:QD55#TTG8NHE[SD,B
6ODO:66eb59C84[82S<7_(:V_Od<Q#]^.DD];I>KGFZ5aKBcabYT4;QVVI#?EW7M
)62Ib&0HS)?\=(dBD19b4IZS=fE^,_ZG>Q?4]+2(/#X>1IdD-SM#6aMg>47=1M.-
1H=R_H[6eT8BX47@T8^Y#[C[6P,KOI4\d&?XQY_Bb12\O9O8d-OX2(554e:1MMaT
LT3^S=Naga1fH3/_RQQ>cb8+7FM_,#+S^633ZWZQNDfTTRIcB)E:XBa@3<(=&07X
S7+?YeCbIL>Z8a/HIag6KLQf8<+?\B&.5;BaGa\E1Qdf:S<48P;[(RH8Be>O)NaF
ULB8<\Y)d1;&4c;b30++1BPH\(U0Qf?P9OH(;ZIe.&d]UV-A;Q\F173\C[<O@]CH
]g],c,@@.a#A>EQQJd;cLE_/TU8fPY\H:TWDU/QcdR51fU23(Ea/#]78e7a#JNPI
Td(;CH@7DJ(feZe(KN@+#g^C5UPEBD&KX>YRHKQKXOc&><IgVG^LFF.4DI]QB3SF
-0X@e=4f:GR:Z=;PV((7;M6ag5Uf13/1X,A+U=FOdF=B8]K,_+K\\b\/UH&I(P0V
VfX>N>6aeEDGEWA7]#&D:W9=XF6EC,=NX#TE.g)B(M1W.U,\BQQ8@).ZGbf2+@X+
;-MZFTMd#&2<&WYJ+S841_c;,WW_aQ78.1AeII_93Z4ZD(AA#bC=)KcdXLZFFN@^
([Y8fVgZ+N+Cb<)]EFNVfPHbQ7CfZY>#VEFe_>U@^(f07(5RD[86e)M+bdaHN1DH
QOLe_18>@Y<F&QObZ]D#O=3F5]#&d#THML:&G\^Wf3I./19[V(8;@Z9G)A6)WZ]<
Y@R(<^\1_87DK?[cJ#&RFP@cIX[ZH9O7OK7=[4M60&gQ)U]9?.>^b[BSN0.0F1@R
JH6PfC>+/0e._fW37/Y;TEMF8W_[8K-9O?3B&-W,OQ:]eS<=O>e8@gKFFLgO7JR5
SP:_DbBA:<Z\]Gc=8_BH^3e8>;9H,\D_PXYQN<HG427PW??.(eg[)Jf2eA4=1-<^
RFB_U>PTgd^\HQfE?A#SN7aJSZ^]H5b]7SAgMg2a)KWcO#)II&=K^C2Kc=ZB(->9
e\XA(VAF2:]H04I@U1CZ7._YLbSCUA8HTP&W&\_>1G43+IXK;[8D+ZLW2d6ZffMV
-=+9JdgS9FP<d?Bc(4H.ZMLLM.ZL3OC>UdD^X4E1QO+M#^OTP-EXC,<LP_G)@GUZ
T6PUV<7V15Ub[b6I,&e<KTf][)]1_VS7:,42&-cXE4W(YK22LY1ZAPVeZKRU1#e.
Z+H.VGXQ#1c[g@b^eN>)H_Z?,LNZ[3)VLWS^1)>&\Q.JHSN=MU1)e6&L@;_+-<^7
ceJ^B@/9<&+1;O9+=&-3)<NUZXU_&K\858YA4PFKfBR4Hb)SJ3bJ;eeR#e7BN@<O
Q,T#^V?fb65g2[H_e\DUd#Ta>MIE97Vd8+D;2EHDJOgGN5K,=Pg:eLZYW.I1BCH&
.Z462&4Y^>8O_5F(.AA#2=/D^+]-[]MN2P>_1KWB3S>cQLK[0g.G3QD7JMNNYM41
9aNZS5\P,CHS7K12feT6gAc/MD,edfO#L//c<&0ZBRQILPI/_=[A>ZEP0L[HG;LN
f/\UC8eE6=3/IO=:5W)>#-]U8MKL3MU05&AS0abd[LTKdfc6:Gdd_[A-)[+&&CU)
A^c8O@_IHe@,D;AFg[]T[KZQ<V\;Y,K?,)98?/2GcEG2EgZE3H2=HU67>7dfAbYT
Y+8(9E]W3>#eNXNR6O8K[WF\A,1g&X8BM>K8/g@Nc,N7Y)gcBT(V-RDLGb8\O_Ja
(ge#3.L@)\]>E>?PNT&XNYF;I\9/<[\VM._(1/)^IN_8ITU-7Ld:U]7>?\IY/=L:
4MdK(,>VdV7]O)O/1(B:0IC[GDF1[#?>X/>HK:N^#==7P]L7B,]BO3<C51D4C^gP
+YW)3^&-MLDG5G?CT?f?[71U&DcP_Me2,Z?T;4),WK^CMa]Aa9c#FE#+(c=OPG_H
B4#J-#aRc9f1E^-R2/T#06[68#]A4>HAOV?(1R444Y>[@Pd-8AbDa)4g114XR)[#
^74?>E//JW@DDgW&Z/[FFXYLD(+DEbfV4?)BBe9,7RC8,XdDB+XY=f2e(WV90\-M
([I.NFf;;9XgEX,IQP#Ua^W\#46c(3VGdP#g^:W,6VbCKFY_B2-6PbJV?048M22>
0I#Z]T34XS92ecQXX7KGAKA^RL8=<ZE2==NPY.Udc26SQeAIb_Vd.FMTce<Cf2aD
/#J0/>PRU/]dQ3GKGK>PIZ1HV4bbS?,+N\MJ(LaPeUB:CBFE>ILB13\V?PAI,S^3
]^VHJ+=^0CUC4#0IB1WJf9Xg)30Nf<AKNLDR0ZKa.XOe[1>QcU:JNW6[=_-DTXe?
Y1N2J\#D-TC8a9@.47=<af<fBF,L+=RJ1E1U<51MJT)]9PIOQ]12J(@#MWE-.W^?
6WABC[,VdX.FN<W^?VI6/bKIQ4XaKcEKVP-,)?P2F@@^#_fc]e3bAa<AgeT/J7_R
fA/EAZe5;G91QDVDWXc(C0JP)><L^I0RbAL6KW((a)>\&NbEa4c<d:BI9@:O6E^/
TKb;H;bU@UW6T.E[C_\0F__bI@(HGS#Q5GZR#7F>?TPd/86)(8Pad6>TI=7C5_CS
L83/Zb)R/g;Ib-Ee[BJgKM/P-)TY(.&N0N>dL7125JN-CaJERD(TYVf4)BQDE37.
O<:N7.=IaJ>VL:-DS/e83=cfKfFS3Ef-F3ITE7F8&WG(Ie;Y,<8ObB.&Y\70=J@_
dcc9Y6Y:+U&R2>_G5K1_;_L6/4MPOR<0X6UXbbFQ[0<>5A&BMC;eII]ZcBAN0C9D
PS5Id>4M1+:<2UONeMOdO>(bNBUeP)2fEK8\eSXE8VGBS1.c\BGN57UeS]JXU?M\
M&Oc.8Aa(7SWX\<NX?I[/PLP1ceJBG56R1Be:^Qe-1(bT-._422e/5^WQ-NdVBM8
A&MRRdG+6gcL:+M:gTNJ&SH#dCFZ:8JX3V7#BB#g[gaU7/,6S/4f@W;#E8Le+)Hc
OP/>E+1D3OaVG#c_T/5-P:R=,X?VeM9,)4-/)#aE6_)3/IJVMLH^M6<NX3JfJA);
EYMJ/HR/W=bF,TL83-_,+;[^&,cT<4Y_)f5FSOX(=P2S4M/(._MeH]_&HGOB_&1[
+Y+TU1Z92;(@#O1Bb8(@RaCWL9=F+(.7)4UM(I\L-dfT&d1VLeB:KYcR=)>/ZGb?
E,56_AO#8A:W<(f;BB)YF9S:-WCf[3J3ANM06beNc?]beB==Y>\J/0ag5O23_Q=P
JSO?_)G0HMX=<O48WVR6,<8Gd(_,ccF]=+Y[c2_&Z(3X?4.CG0RP,O_39fU:I6I?
7-5Z7FTK^7<MZ+_3B>R.2?JB=3)9a;\;14DVZ].9bI]TALGU]RS)=5O<fGR,]V5M
FWX:?@C@@^(/f_Q(VK\=9Le@::gV25?64GN>9E1M;SNG,McSZP<(?ZC6-/^I7gMH
K[7L=DU+KP&CBP&R)5e:QZ&O3g9D/@K,T.H=,OKQSBZCd219M#.TXFB/(e[]ECgQ
VMQe;F[,WAc>gPA88,[9O=]T-6X.Bc#<>a8&;.(UE:D(BK=(#<MIUX@XFcN=(P(c
&Ga248@,([4./H=fEed79@/P3_D&6BR13<X@@VGTFIM]HV8&@C]84Q]=0),)c&)?
XI;=/US..03.Q2#HHC<^T(&)=Z11V(g7cgVMJ40UI+3.gCLVBF,;5:D+Ya@]_TC/
JJ@X68Z-5gV@fJ/ZfS^a7H[3^N#WW@Y8HO04.5addX,.<a]S?4=dAK])FYc^Cd8[
VNUV.fOe)gb/\[gHX:_U--^R:YWX1/IH@U_U7/:B/+b)5.W]2PBM87B#7g4<GMM_
93=OCOAUeYX,9=I/@a7;S7WZ/L46VeCQH2^TU)IWJK:UF+TV,LUXA+Ld/_-bT]5Y
A/]NK>eP3a?&a(;K\=N=aE0\08#8V&T3X];J8AV5f.K-@b<J88E37fDGBRKLE.F1
)dg+)PV.U0?V8.E25048M0_;<2La#@PeT+QO#-I_SXK_W^g-?bKbPV>D<b-&c&gG
:4[KS/&<V&ZKHU,<>>8O^@9cDUF8dEW?X<W:I&.4:>7FgMU)31,N#0gUVaT-E&]b
S\;@2=aDaNNYB\8:3Jf=D1gPA0e?eVBMcaZ^Z\PGSc5=>PWSDBAA;^LM@;(&^CB7
2DS7YLXX;-_H8V#N^IRR3Z^]GF,#./D8gWHOaSK378/):T4cK)&)H7DJ68R)^Q_T
?(AaS>5T6-/HW/]CFQ8MVQMXD51#,d-MT9@/3+7e)X]AE-1_A7bIE<FcG#\g,7?N
bYcHE/;^<??7/R..#\]O<3I1f62)4\&FG;@G>F=@G1ZAE0]>./1-]1CP&c_WX;gH
P:@LM0OTfZ?U;H2&-X]&R7YS6bf>PRg[G=3V(:7?JWLeP8O4NYSTJBKd=E_C;XgI
>[UZ4Q=+@<?3B+S1JZ,4gYR[S3]&DN;F^81e1Z=21fGI]AZ5&FV5DFW:=.L#V\A#
9agGY-=AH3(AY?.Q1Wb_Q(+;T+2AX,]fA7?eHH,(:T4>ISd)0&Rg]af106bJE#J&
=/CCI?cJ-H]&H>0VeNfCe@&Zd9P]Z[Ce2C,#Q[_a\:]>P4=+V-1L2\cY:6<,A,\C
009?0<]];71Q-E.7ZGQ.^^NN0<[8(\DN-O4U4XEb@&&KK)4M;5YUID1:L?)?EK)<
.N0<V)e9d:.?HJ3VW@0LJ&ag]O?+&EFW&dQN3:de:EQLOC9]IY06ePGVH[fU^M3T
#]VA>GR[P:/W<,6/[He\>SQF1PX&b4a7C/a28eL</+?Z_]\/+JDT#WOR2<R/\)UE
8+AT6BPMU=KJ>Y5TX2FA89EWV&<e@FF#;Pc/c;DSSIV^J1ZN#_/=EfIf63B8.<cN
2KG4DIXMO;>c2L)EP8bVf7UA^KRVA0?6KgN&dZ24S+JYL[EELa-;.ZJ8bcA>B=VJ
Y.+T8+7YQ\6Qd1\f106c+19,c6ceb,##bd9g-9XV_b?)DE_a.E->PL_.#B-C1@Bg
6e&^&3L]H0Z2GL3ebRS2&g4A0fUMY.Q:=?P:D]_Lb:A+MXA_+cC=R-7Sg^D-47PX
6UQI5@\K9CQXG_Z?Z&26e2;#/YAY-R&SDU9.>-FYY<7NcEY6/&?+5F)/T7/,PBD;
)5C9>f,a7\_]QJ7ZW+FeDG)YQ)RU8L8#a,EK2>G@@Y-X)OC):K,N&.BC8<EDe4.E
3GERH3A(Y5EIS5UA[bd=1B3dd4;4)E7=0&E]5LQ^GX=f5J3;Ta?8CB4&3Me[f1U)
RY^P,R)<];_0d:TC(d1Zd4ID=)eWEF4EPgRPL^95/#a1?W6#PQRU-.&1PT;.V&4/
LMeHEI<I7U&6c;C_KBK,2bOSaF704F12G;TbQ?6P#R,Z(f?cL.H6SNNd]Z.=g:XH
D=VV?FJgf^7CaQHVHU-K+S4QHRP\-FXD-A,JY3CFAP9>D]?gGf(\V>PX#1^W2,<#
a?XXb^E84=#3C[Ee7FIM;]@PS+PUG7#._&aVVA>M\G]P^C1N+@7NT2JHCDSD[1ZC
==e1c7:(8_RN8W_Z.(E3=)(@-N;K_@YJ<2^gDH^A)8PNRe,HZ27K(IG;KXWBJ0]e
I8WX9J)[)a365]fGHLWe8YVRTKeEIcVIS=(,4@)F+?0ET18g6I=1@,DDFCX2bD1>
9W;?:/Wd#62VSa?d^<1DQ7_e:7f@Y4e>>?#OGI_8R\fN1]^J&;/&]Q1;,PfGLRRW
4]M4eQ[XD,aF>Z3^;_XTHg@J&K^UTPY[Y0H&7gR4eUaI7Pe55W2DCaeS4G=.,B8(
EPPMDCabIQS+2Rd\BL?XGM#E2;DOJ]@Z+E7PHS_1)OKca?OU@S^>;P<Ye:gdX5BG
F]c<Q^EF.:,U=DY#FJa?<\D0E:b@OQ\=SR[,/T-L?U0K#L]OY5<\T#BFD+_06<?J
LU;8#ecdOZB-c.[G<Y1VcAGQG_C@=G#ME]V1<YU7L:KYXL/\F^\Y=N;\680GIEd7
+I4JRG@+QZ8MWBL?f0;].=T50d8&Q@SZOZ^2B,[Ca4O(W6+@A.Y-Qb5aH)Va2(=3
UZP\YA[>C#SaL#Y?^S)4)+eI]dLV5L5bQU[MPNXDF6&8aM8gO=JD45)]P)^Lb_Z;
QC@H<eI4K,)g+C<eX4.L])0NMPTO];bGI+aP87#9^A:TO.c&51+UG2VF5,+M5@7[
eW=3?&OLF0@8ZSX:PLV?2;WUWC_>GJ]W1)dI(Z2GAf&X/]322eI7]I#QG;/4R]W)
gN&9Q&I9B_d6gNMdO27IIF0O3)A?&E@b[Y09\f[I-G;0L,A##UBLZ;P2.3[a)A-3
e13TAV_Z/Le4[GS[#:ZJ[a553a7,c[^)D:e75c_)2HIgc>a6INKe3c=^#2^7EOOH
2Q0IW@[_\^GA5F3VfVfbDJ./_#_B=G.?YIKgU_OQ#/J&e](P@.HTAbX#9[MU:@d8
N\&+#e3DFZd_RWfM63=f=Z^?VN8e(f.dA+FH+/YRYAIFI&Q4g,M9T9&1B\=Z_9:R
:1^\5_(<e&N>6gU?ebV,K/U.^f6c^_:-F<2O\.)E;FJY1Y]^>[DKHCVDM.CLa-Lg
CVE)e4(@XabA_WIcFXG]KSe;_)836DRLYZ7c(d>R1VcB;^^JCW;IUL:W0W/-P;\f
2G-c0>_/N1-LOR^=U#S24-U@Je-5Pg33NU>^O=-=d<NeB2[_c&;=b8#64BO&a?cF
Ea#[,fL>&fPB\K<BH<TAcI#e(-R9eJ\1:D:+KWaX^cD[d](3-Fd8))4(UAX3g?De
=7NODTZS?GAXK(FgTgB+_/XZ7KB5Wf@^\>W7)Y8b[<1.2+E[aUK].TQ?N/5K9(/d
OeU?\5&]Q/SgAJE.1a=Pe316?5Q(PG91g1M2K\7dVPcU1GaJfS7@W_Wa50P>Z7dK
GF8X64(eA_U(2[?>I-K@[c]\?F5dTf6<XV[McML8/-G_N#aN^SAKg1<4O@5>O^IK
WZW/AQQPT.eT@A@Q/WN,W6B:fGPM;2\Q10M#SaR5\bW@gK._:f._:e<-.f_@EGTe
DSbIEMWdU-HF1):-:VWNfcgA/+H6_@Q<N9f1U)]dI-Y+c/FWaWXD,N;cH6X0IA&0
A7Ucg5cQa>gPX,?Y4B\KDOLAMK6\;L:<XUQJPR)VTaEQeN3e.5>91LZ(]^ZLAcX0
^86:,BaESEFJ6eaXbZ=[.3;K;XGCJPOXH;fJ;Cf=A_G1DYQ@R]VBb;W=aG,G+QIW
Q;Y[Mg-B1-=?>VBg-PVPE..B(W<4W^?7-&=]4F,^(;g>8S3BKI5DU\+NDHKA_0LW
?D/d5+c4g[_P)D?7:8C7_cef5M2<YLg1FJDQWH+&A,J5->OMGD_<Q3;,A<aZ^((G
L5/PIf_QTV@dY(J]+,::Xb[UEF<Ob)&JE0@WYRa]UJ/9f@J3Q#R8McC;SV9DHDZU
\,6,]R7)BQc2\<X-@cOfId3:#G&.+/7]?NR^Q;KT&(WHGS1_6GNLX:e-L)7R<-86
FPW>X&?E+KbCbD>.P8g63.(&YDDVZW0^@ec3HEN#;aQU0,[Z#E-1O#PDcRRF,578
UeIgd&@R]g8YWMZ39Lf2=D5GLUZ)ZfIe8\6P\e53[01>(?Gc__-fSJWTJQ1E3B-.
ZGXU<4^7ad4KGD6:#b821<N43+_J4W()JdcVEd4ObN(QQJ.LHa7Z5c<_MG6IJ-Q1
,[Y5<#6^1&II>V[AB.\.9HLY^4C#R>V[SSfLf69ED;]EDggfPW^?VcUd7YB:Ie<d
J7.6@M?B;^#2=EK;WL2M1\cE4<P>Ef[-CEHKN07gRNQPb/PF5B:WC@a8dD.VaJ]+
d(83\:3NJ?+AVX,Y,g,HX^TWUdH;X_NdBY#X]Y[ER)<cC].BI/Y-E0aa<@QD6A_a
eG2B]KQ/,a++\/].M,UJJK[SaS9.1:.MN[J31<Q0_C4#WgXT#QP\+A0V]MgZFe.5
D.d^4V/;+L[I\._#Q[.^JBe1eg:S;#21<KMA_Kb>E9G@M0g6baP5A,+MWL6-6:5c
?:&TYNFG6^IPNfa[PWL+(.N]G.Jc4IKB+U]Wc2PN9a<[PRN@#\cc48=daZ6HOSD;
LA/fYMAf+7RKM:DTA7Z6U]1[4fT2[A]Z467,R6[<Xfd\Z[?^+-gD0Pd;2F-WS<K\
I;+9Tg^@gNYbNHW?55#ZZVaf&\^>47=1HXf:C]O]cfHS3;2/))-\1578CCJ@.(+d
PGf@@D,HYUDbU\d4\2cGRDYIF?eeZMG_Wc9<)^4]+@=OTQ_2UR<bFWbOQ2g/:DOK
K09P,51gVcYdGTA8^Xb#&c7NF)-1D).-Jc7U^5.2RBg0NDY<;F#@I&ZB^B;VUL>J
0]:d_Z,)SMXV/@RX=OGJ#Q7C?_=NVOH[E)Tg9RC+B2?J3O+/(5+_6^3#Le8EYR//
.7UIQZEEP3A3<:(EAT/UZHUbc&IHJC\R:&3V/F4aE7<Y6ZL3)X.[cTbVeg(DRKX(
dI&BfTTOTPG(10]aG5b24BSO?7S6de;V&&#UgAg\N?6>7+),H;VSP20/Y\CMB9?b
\?0cg4=XgUF58Ze3Q[;CgE^C;3,,63R0^GV,9TZ_Bfe</ADB93=^DZa\QVIT:2ZV
98T6_LY\C-UcESB@FR?/W384])J7/Z?1@7#RC.^YaH@/7:N:N_Va;eZ:7OJ-\7F7
NI@gb2#X,]F^I>?80C948[XPYK)9Z3fb7#c9_^8f:UKdR_BH[6KKGeMZ]bCc+S?2
e#R.92(Ug527GLP;/LDH&GRK<KHIHf1cc>[c@=+a>5SW>8RB+b>2/Gc^W2?>eE:]
NGMDRZOa9aJ&PB#Ye]S64ANW6).a[XT#[7cK2Q][L4W^L=_&WF;2M(6cMMfZfTQ,
&=F7WW.K\W.Cdb=;J;Z:7SBB&K;]^cYV^6OHW?>MbH:g_+C5]d+G5=@-L\HPdYV(
(c1\I9;=W[G.KO]LT(D=<Y,EK/9:5EfH_\S)gGL4X,-)KL&P6G>#C>KZHc2:#S1R
Q34ODT4/HS^K<G>TY(.\efe/<FOY<W1.-b4+4=?aTDN1He7VEI\4HA:YYOgATg&F
SLa),D4.B7EaHg=C&^<\LDW=TC;Y39&c0B:.NZ1E,fD;]K&-V92B+cE6J99FZ1=3
>V^//ZR&:5g)bC(IFWZST@^)-JL&I87Y4PCFU5+<X)aLK]Ug+X-0N]T3fRB5:FM,
^O^Yd8/TZ@Ng9<OA:)99@:I#T>DN:#X&9,[G/:3#^6bd^D3c(cRAQO.?4U=PAPKK
O#<-)BT^\cg5-C:[-gR+#Q(?\L6M)]+YDFTfF.X+egC&=\D8W9eJJBbKSb3/A5E3
>eG^Q460/J]d0gM;P2,J5JH?Of-,<73&>b+WH_BZf6c?Q3KV@<(MB;6XB2CYVM6I
0YIfV?X+ZUIMS,JcSfZPV#U+30c?eO8c&Z7QgTE#JR\QJ<6(HAN.>JS9V#K;)9J5
D_g/:A(MVC[+V_CC2HGbH[:U-0UT7T@]&bL>0/]ZbW<A2PBQPU\]dZgEDT_AXYR]
F9_)SL130NEcfV?.L[aB#4cMP&8<I1ZT6HNR9^e+)1&]\Q\fNWL9,0G.YT+dDZXQ
WM<_NIMYP#]-<(#9a3OR)b;0bfJ\1:[5=Jb&6Pd5VO&3YPR)YSJ#OY\]6RIdEJ^W
+[GLI3DR5e7BM+g2T&HR1QdfIE-0JLL)&)9;.b8WOYH^\>,:cL=d>(Zg?9Jf)\=D
VE,KcX_V46f-T,8+(gYY(36:@@\VF[F\Dc4T19P-LK4KS[dP:W@DXD&=(U:+)W#C
G[W>X5SY)aaFDE]aU4JTc=Ca^f&-4H(+?Z49gCg)@9-7FZ84)3gIMePN9LXS7\7A
ZZWZF^?gKICY1ZZ-WX3[MJ3RFW,U_?,7ID+.(cX2/6GL13FaDE>Y3aMI]gfOZ9^>
9@Fg.aB-/YCL3VHEZKU359N^2E.DD9<6#PZK15I2J&\?\^W@;NFHA?RM_D2KN@\2
)JV/<,4)&R#?\>g?<9TR4X^XfE]DPEB<>3(a/B7:ZVFB5FL[AU#5IT_6&J?1<W[B
;8.I)aE2?XPJ4/bK5TNJ/7_fbI-?/?7@d2I^LfIeeRaQ&Qe[g3&,6:T2\.FY.SKd
?Jg-H3409XY4f)fE#41_1U3#<VD7W3<<N-1JW/B)9P5LIRaYFagIN+/API&H>J<,
Y0311\<QZe>+dG[4)CF[8DU<-6cC?<]2M>70Z0M1S,F2-b:Ya)K6,LT/MVeLCYA6
\V+\>.6V5<9L32ISL[Jb/J8Z\/gL7==HdC]PD&Z0/(=+A5ZBa2/=INVHVDfEGgW)
2+.feS2(_HJPXFG4=)Of[,3U+VJ&e^4EcaG,DcY,C@,&PN074SX9_OQ<#5Q.UQO<
>=,>AP;Q7B:=6c?HJ3<W?8+f6bCKUGU[?53E4\:bK7DE2f\E2H#cOIcTK0JW;M](
_a]WdNg_S6UQP^4>Q)E_Y>X)Y\X(<.1g=SD4IW/I5cIPeT,-e;^&JH^#C7>^A@:F
3]QNRf:3Y.8W31W)OGCI3REWR,Nb?B7AAH&\#b.8bGOgab5.M&QCg8_7/-N^Yb[/
82<,Sf<0(R^8]E_JZ8V7H4b<=D5H]#:-&E;Ag5UMCZ>fDJ&Cb#BYG,ON06BSQ5^N
D&T[]POZY5^?c/gE6(<>^03W,L9Mb]6B8RTaZOd]-cfeCM4W8U.LM=Q(XI(Uf:fH
(TbF<7F/ZV]Y<a5GQcM;F-334d;gPITf92Z8#:O<UR&f5dZ4I2V9A17X.(O#V04J
7\,ICR#??/:5b2]gP/JO=J\>aC(O.K=\GA3dGc-1a/Oa)2OQPOI9;EC2D:.ea-5]
N&(#\/S-cWg0AH91gD@QZ=,JO-P-2JT,9K/JJ+@7P9L.TX[74)PdLML&^U<AbD8N
D<_94-d>.UZR9IDd_.@3^_QVS),baAE?XMZgIU@#Pc/cf)N/<)#eceKNR=2eNZf@
dV9[?(+DF5KZ-aXNWYL##<P]?C,^aI6bV4X?#YD>7=1KX^FQB4R^V#[60H&U>\P6
2[,#^N&^O=YGKbW<WaP9IWD\eZY<HK2H9e#Z/K]Je3/F#\9[73eRZ\O0&S<Q8faX
>0X><XLZ]g3&0Lc9@?8IYP<G><-Tf34=b?:MA7>#-UV_7[1&1<;4N;^O0A8L_1V[
,QbC;Y>HBc(1N5Y-<81e>SDc#(MfcTT;<Vb5TI<[aT=,[O,Y&e=FK1<RBPTX_ET[
#UE71X^FOfJb_e+PCMcd)U0(?]a.GaW2&]0:RB:>;6#+LMBZ<N\#:@FEDP24<E,2
P&?S/[Se8fe[0B2.5DG@+ANdWHD0J25&fS-)2Y>bD664#X&,-8@/JE:JH1_BFZQP
B1GPA?L;Z3=g[Sa54POUT+7TVEC+I)_P9:N7T:.f<99M7[>Y:LGb>Me<G#defE>O
Y9>5XH<fe.ZM,LY>B/&Z2B(?F(U(GW31A0001&OSKNdORR/:D2>gLG2]I6gaH4eg
ZYHEXVcDFB+MBK/f);S/a?R,6bQ=:/?GNMK:)M+@\-eS^6aG1[ZcQ#XS8VAZ10AU
AQ:_N-86K<f[I).WcE@B\N9T,MO.7Y-<VD/@4162GIPP=WSP9/&]4RaKW1DGISK8
^&8G\^2:bCH;V9/:PKT;,)N[MAd^/BWAGG>7A-4HJcHXI\Z4OdZ@W0Z+FJODXCUP
4-R?fHR7b^C,=OD8U\4Gb0>VCB,Q]BHFBH/P2D&K>1V1.)B)#^ee4W/+PV+L,a,Q
^dO^)Se@Q,6/A2[+V)UC/?<=7APa#,S#4eIIcTO?+5@:(U:B.7ZgH4=8&XF9&+eJ
SNaD_E>,ca+S?&<XWP]?N6;cNa7ED=\9/L&,A2>2DKL-A.=HL+N/U5>.@JZ?(a5P
>H4FC<R)PZ@0904e0:#8D-_76cBdcEZR/9OFF<&Q^EIU<ZP#4\J;G@W6WGCQCMT^
UgKg^8E[<.#IcDOEJ(17Tb8f+KLIL,/CK<D_Ke:&,YZ;AI&e2NWR]Be,/0#E/OR6
?4b^D<[WJg-MPUad&LM,D4dU9XRB#)OKDW<E;a9FUe8:UVS@+6,5MK:TJF55-Yc)
SO^^W(5VTY[S1-9Wae5AUf.c/3M4(AI7<^f<=C;L^@@]f=JBB/KP-P-W#MY^H29E
YWBMTN8N7_Pe_A[9cT#LFK4g)7d[V&=cZ@(aIg\USZE:?CA]dPLD>?@5Zcde80^e
PfBI_O]A6#BFKeJESCM@F:Z#^Vcg+,8EB?V(R1T&fJ,NaZ:d.JFbO873FbY.(?R+
U-?5N;_XBfER41+0^#^cR=P)@V@T-g0Lb?&Og&eYMA>?O[,4,[.RDYB9?U<48GDJ
LO]U=K.CVK-;,[cg(d;I,+KX#3#4:36&8B&Z..XX(@=<]5DQA+-[.:c4I:QcG8O,
T9PR]JI0V)PIHXT1\d+3)fQBO,_cK5d35SQHE-.1,7PGGCbY.Z_YB0cL[8EN@)J4
.dBFD4&O[QK.V(IdP]I&P>B-K/dY+BBGcQ9ECZ\C2N[BJ1Nd,]:gg:/6b@JcZ_5&
?cZ=^&7c[4g\bJN(<>8WJ)d:/,6(]O<M9Y=UHWF0TFfT8[)aaOZabGZ<.E=9gY^]
WL=[bfFc)^3/b2H91=b-Ge\I9)@g&YBcZS4RLRcfg&QQ&N[-[M=_e78(HP/g?-0(
ZB@c-GTF]@1[;P/Y1)[-EWO)-1E)FP]Y5^6.VP.IR3IBEQe-NB+)V[IUGFYK&<+?
J)BW+FGM].:6H9<-ZB6DOMA3^Q8OIeE^B>E9[-B+\EgSWLBA[B<TfADV[PfeS/6B
R1eT[)B,B+MQ;0=Ia2<dDM7<&PLSCNHDSW,ge\+_3c#,S&d_[c(UP&FECF-\L_D?
WLR,fJO&=4VNQ1/F)eT383Z[:4U(O[F4\NGgcDR(Aa3W<CGPeBce?7T>XYD]>VZa
/=9(W5M+>W;4B>+]L]+L@#DIfO[;O-Z3\5>fZ=_/ZRAJe>LeFH+a+a(\fBQ-W4YN
U?6bP0eF)NDOG0FM=gI@084VaR_K1:Qb^FJ7H#VV_WKG#G,EU0G)IMWfB=c^];.\
+5W/dH+Wf9S[:fLSDTf:#Md#D:MNAbL_LKAe;V_R587HZCb>,aK^FA8[6Q>@PJ30
A+O1GH-#&Z>B7?:S9TQVgXbeF68&VIgRc_9TW(XBYZe_d\C#V#(PQQ@3I1VN3]IL
_9,@Ng-&MPQT82EIW1fXS>cHOU[U?U8J3)&3f@GW#_<I[;8P@Q@RX2)Y-5R6_:LM
Q^]0C[25S=&fe_Y3E88A,4RVG-8Ga.FS[>T&@Z0Aa:HY,Wf@4YGd.F_f&X0/a(31
L;>R[OU<B&AECU^H-g7]T_S^fO7_f9@f0.4X6,_EF+:F/(g1F[EgLeOG.#XVHKQg
N7gf&KbP=&G#Y6<^O^UQD6WZ>MQ].1]UXg_D28T4\BH@,V(>Af6)@1GJd?&:/H;d
cNPBP:FQGJecR9G5gMEO20.TM<E3@ZQSeYF(#:XZU.\C)6E.1;5EN)d1;MQfOF<D
2C]7U<c-?bF3YK2LP(J31P#<J?>R2;MEL3<2&^3W_5^V.314Z+\4NAae\JbaRZ-4
N-E9S=cBa3,M>T&IcP5X6<<?<+e&)KU-e]H:/>&7X2D>U,ZaW[>;?QNGfYCe<bUA
/eHeQ&4N\YD\fV9dKB8Pc=&5fb.bTB[-F:DSg]:3LVZDe;W)](E9I(GRbB2KA4D_
TIF&#,]@5Z9B4KFCH4DK#,CdAAJR;e?_B@]=<d,T_7H7@Le=:aYMM/NP21P?I0&f
3FE8L7_/Y5^T8MRQS7Bf1(-_He&J;]\0CDI6ZX[Q-Lc=,c3X<7c)4:ZdO&R1XXPf
.4(Ac(Hd+<QA/0IdHg]2C]XZGeQE9S8E&T6XO6b826W54QgdeVXd:9TdAcRJ&^Q[
WGKR@F>AU-O-8,E<&fcL0DK1254+0+Y:g4QE:/g@\Te,N9g+D[9M-2.F=O7f^Wfd
.+QA\CPb(-<b60)XYd]>=@@S\G08C.#3=:Hc759[]8CTa::EOM51FH??4gQK_702
EE8&7@I_C;f(;6+e0ZRU2GH60gAb,],9.cS?F)X#/AJW61BU&E1PECMD-]\?SbH8
77[;U^?,J=?9S^[g=)^>+N,2CIZB8C<Gf()[/9,7R]CcHZXcPLL^O&_I351#?<4S
_X07X-2f]F=D@M2:fgZZ(?Pg7L-NHZ0YZd>=5Tgd6#=D0_RUaXYGCf2d:fffKK>C
6W0P6Vg#Z[IDCO^91HCG4Z8)9>HT0@3HBVW[\#4PS.\)7-FWd\WWBCE7bg):1ca/
.MY(=c#V&OXU1SFYbOZN7ZSL6X<V=M24Sd:^BKgEKSd8[TR6<gY;9)#8e#73[\-C
1V:I)_Hc#8e+PZ;@MI5d(FTKA@]e]>C&/TBDK471//bC@QOU.]JZ;XL;S^c..@.9
=fU3)U=FYSGX/(Z^c75&:.3?ENVZ=[C9NM6HeBVISbTd8I(\_#:eA\<@2_[Z0SeS
B<^04Ac<f8f]g.R-OYQ.-J:3fbQSW:fD]#+5CKSa)TgBe[E:fNN-5-,1;#ecR#@L
QGE_DCcT3Cg4\8EPRO4c<[1=d_AV8We,Z&X#T[Y4O3U,O;E6GI4VM1<+M)^:O3a&
FCO.5MYN(6PJN/A4A1?RE91ZML59;H@HS[B;Z0b\Q]fP_U4>F_J1.\9e;()=36]3
IPU0(KN=004WZc0FDadDA]I6dY;YI=]K2BeI06+bTd&[);)G]?Y@ETMfTDb4KM#6
=4gDZAaYY@(bG1&SUK8WZC51^D<EG,[6MA4W/CD8C\/>3c8&923>&8&IW?-[7IM6
AY>fE4[BC@<)CPF1A35/+g+LM.cY8A,ZeB;Na85^Q&e4MA;W:98Dd78?A/=H25:S
QA4c#YL5^.-QQX\).D)J+DdG^>\2\@TQ(@)+(cF2Ncc3I+aKHO7]C6EJ]O+Yf)a:
^BC.S.7&NH4&?T05H/(5IcZ#\O+ONX^:WC)A5X&2d^FKH@-fWb:=b^V_+c=-8O1<
/XgZC/WAHCI/AKUX))cb:3WR1fU&=S3F&QQ4.J+[L)6S.O7\<3HeL/5<@QCcEN[4
;QDb>WeV67Q-6f+FS:ZISd/bPEPRO,[f2e(e^5C.9IDT+WISbR]7ORY(Y6I#fB<T
cdAQ/S\X194((3e3]_f.fWaKUcR?=ETA.><R9H_GL\7X7.A+dQ->132g(YY;A;K?
f&^FSR)=]E8>PM.EeCV(4IBC@2ON6S+3a+)H^OT71F(4@#J)BM_PH1;M\fLfVB/Z
09D8;;\]Z&<WU+YU0W34G<Q:&R=KKOE1?:Re1e2T(?CHf^7#2O,=#c.QAeCZGV,7
,R-bSPaWR<9_>5d<(3,bDSRa3)@@U<H;#]LH_0E2@9QR1A(>UTfG^1I^P&/.VUJJ
eEf\[6#3KG9JfNHG>@<C/c0Jf-14XA7^S6TfWW:I8g4;7,.?b3.;3WQ:J=;]6]@_
T[I)I+Q,JZ,N7<VaT46A80CHFNf&AO18AZE)7V4g)BCA3ZB@aFV8R\8@[1d49#Vg
XTOSIH]=)f8OJW-75A?VSV\D7EH4R[B^G-CM+41MP^T_F0-A2[1XS8Y,V],WIXgL
;H8K@37K]#TaRM&J4cHJ1#Fd2T?8;Bb;+_A:A<7KFVROXbK7dO5)gD7RW7aOF/Ta
.2-Ne.[MQLRN[U;bJ42UPY6W(Y;D;9f--JW7KQDd<:\?gc\^IS^9&\;+L\A0@BV,
7Tg?<D,@F:,ON8(<Y4M]?BJ4-BT,Mc<M[;bVW&@FU8<M8[Y5,[=-M(LY4R31:)78
INTZa1(Y\/dE1e6DW]LgI.U)+/J#H6C\:@e:fT.SUNO+Ie8)&L=f)88RNaRVEIOZ
QI942&THKC/5a:-V+<N9KKCW1D/[1VdOB_66=[0OKS\fEcQ5.:O\B+D06XB90#HA
@NL@@CWOLCJ3TRY(g4Z9A=dc\V0P,])D@9L3c&f=/)B@Z.HCJ\TCT0#=]^PK?f(1
L9TD=K3e@g-8EC^7<.UFbUS[E@?A4+d:2&,^?2Kf?V(XH&T/Xfg)WVE5MY1T_C8Q
N#BT1V-^ZCGT6+>gYDLJ_17.DWc)IXMf#CHLX[/QWU>XA$
`endprotected


`endif // GUARD_SVT_GPIO_CONFIGURATION_SV
