
`ifndef GUARD_SVT_SPI_xSPI_REGISTER_PACK_SV
`define GUARD_SVT_SPI_xSPI_REGISTER_PACK_SV

// =============================================================================
/**
 *  This is the SPI VIP xSPI register pack class.
 */
class svt_spi_xSPI_register_pack extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** This field specifies register name  */
  string register_name = "";

  /** This field captures register field object handle index at svt_spi_mem_mode_register_configuration::xSPI_register_field_list */
  int xSPI_register_field_index[];

  /** This field captures register map object handle index at svt_spi_xSPI_register_field_list::register_map */
  int xSPI_reg_field_register_map_index[]; 

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
  `svt_vmm_data_new(svt_spi_xSPI_register_pack)
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
  extern function new(string name = "svt_spi_xSPI_register_pack");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_xSPI_register_pack)
  `svt_data_member_end(svt_spi_xSPI_register_pack)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_xSPI_register_pack.
   */
  extern virtual function vmm_data do_allocate();
`endif

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
  `vmm_typename(svt_spi_xSPI_register_pack)
  `vmm_class_factory(svt_spi_xSPI_register_pack)
`endif

endclass

// =============================================================================

`protected
<UAaK0=E,&II.+9)BYZUcGT;1QReQHfKN7cH:>8/O6&:1LJ^,2K</)1:b2a,Z_AX
4,#3aF3<fS:K00)3b(330c9;g?/=(L,I<^,4Q+&QFaaKg./6/BUP)Y,X<e-?BY-c
)JK.ZXFJRG8R+5(5J1U8](48Md?S7.&/5:EYN2+2;ZUR)GU<(^XF^8P,ZLEA:KcL
2PK_2W[GM2&Kd7I7.:EaNb+=b\RKX_)LP->(8CbIe;E_(MC/ZaG77Tag]WJ:7gEX
SBHf#8+D:#cRV&,\O0c]^Z8AG,f)HfQNWd(RLBf=c=D3-+Q-U9+fWA>0&(3/@7bN
A7;Y(;T7-eEFVdS^:9S8P8P4H2U>2)Ue&7S=03S&.._4M.C1Gd):1,?8Rc_<eS33
F+1;MSg;ZX@eLAd@;1e/6fGQCKS8Y+,=+64@3?&(=#9fT:Z.,&ZZ]&BJ[E38[f?C
DV4?]I.AKg+5RJ#8^>]Q@3Eb)]df\R/WV:.g]HP_J59ZE^+=<NJ&F&@]:H?0.]XI
GH,NV)NXLM\(L(4?RD+A^@44bcY0#aB+D3MLRXUdTXH8HF\dME/.e[ZF2JWTea^W
-8OP53C#H]K>Nb+F@[Lg<HIDD96[e7MMUeVAZ,12O/.5?(N[4^,6W/JV8cZDY9=T
B:7I]=\(P^(>,$
`endprotected

   
//vcs_vip_protect
`protected
P8:7JI@[4eL<f2-J^8;]/T,X,JU^QK_g:]&_=a#7PQ(3M#b@0a\b4(gL=87_L-cb
Qc/@FZ>CeUbCD7G9@bCMO#bDBE0<cbPc>4H,OMOf6QU#6<RJ,TZce8NT=[ER1eO>
afD^1bbTEB_.BY[^YYGH@&.-+S;Y8BL5/VX6c)@0c2fR-9ZD1<G.NYD_P_Ce/@91
Ed7P7<\?E0^M.A6\NTbD&ZPQE>X#U5f4,:+=I8R(R3cMV=dX7.OJY^PL#0]7[g)\
XU6]C>Qg19KF]&E\B.g^GZH0@D44,]9UL@DXcP2]4)::\f]<#eMFddbdFe67d7J>
SX61YZFJ/eM2,TbK5&[_CQ872P8S/2]2gWgTcPOG?6::Q+/e@6@D8U828cKQe;9H
OT.8F#6B(B+6CNddBDE:R]YWW8QV9b2:(KQ=RU\YWb0NN@NJCWPFeQLJYAJLO6L/
B7<QH>.;D\egUN\Rb,)=./PXGM3C(C3V;TUPH920P6U]RU9&JOf9RZ_@)K)9GOY(
71g,XU5&+d^=1\OO_VFUL-+\(VJSP3G2MFK-WV2bA^eZ,EJL0dDL;Wff?+@8FT(7
eg&]gTWKaa<GdgC2Q1\@KdFC[6]+@@>IMZH7^@/XZ/FVT0^O3MRI3NJMeZ80WIA@
XV^Y>KKaE^@-MIJ7,/>IGE+BK4G3C6Ja;D5PXP5TWMC<>KCJYS::\Y.=XK1g+(aZ
3LA#QN@Q8J(A:/\;?2+2I\.\_J#HXW9(0\IQO[=2WX?82UfDUR5&Q-_9H_I@]X,<
R3#IL93ZF37.JVTL),;URR/)g8XW@cV-^>&,LHcZ>HCAe0):--C:+8J,Y+(P5V#5
cQQ9/f]KF_KQ3c65@O;WO<\9/XZ^_1Ud/,@W9I.O4^6_AAZF\8c;K__F:A=U(S?2
NS]f9aNGVDNOT)(:WKFH5B-6Dfc48UVNG+(WPN-?SRS_3VcAM<1B8cJ@^URC#Le=
X087Q_,+BaC7OKKJU3+<=JKY=<<I(U=#0;2/#S7RZ>F0Qg;^(\G_8F7O<250S82E
J@-1L21]KDFH;A&f+)-_,L)E5-6OHf87Y\2a#ETK4Z49F.?8CdC/<TV\8/?QUNOB
WFEZ16PUP6?_UcG.L3B/=1FEad#(J@^H@NRZK)6=gT#/VPPaRTGSOU/X3fQ5F3EW
.WD^_;FWT(GQ-dceBS7Q0+Sd6eU4T,(1/,/U6K=G[H(8J//U:gOc>TO@Rg82/GSW
&379WcTV</bV4AI2_2O#Q#,MacPASOY129Zf1_1TUN6gZZ5IF_XPdI>;Rf[gC>AF
M_F,98ZMF3J(KFMUJQPCUKGX6RPS.R:EQd@^:a^)CMBGaS[Y/P@,M4cU#O[ED0[;
Y\[WJWHVJ5c<WAVSA;1K6EQ^DC.GVQdFDU67OVaVVJN]&Cg?7<g^99d=71_WPIZ,
DJKKI@(0.bG#976TEa9,).OVYOT49/^Z+?Y,a:b[H_WQ^?GH8B4>2Y=TT#@FGE]=
Ig;\4>aIYTYMO.7Ag88b2X@47Z-^T9fJK-L)<ag8\b1_[;-=J_d1A[YbJT7(P.M<
;NJLXI01BC)JC+)dZdaTP+\RJN#<GNDL(=2L8DF/a\W9SPC#d9NNgOY4Y.:#^[>W
V6VD@H.<VOF3@CaH\W_37B4S0;Ie+0bS(c(e4_LVeH=GV=<+6VORU)gK)+2KFAWR
3VEca4)626eYADR]gKaS<?XdB?0;J\_g(][#7Qg7gNH0#gKL(#^/:MK=:=W#4NF(
Kb@<#XC\[SU3dY37#K7-<[Z5Wf]+L#3Q>L\L^&[^@)c2G0[=TMI];18B+@f033L=
V^S537#E,[6ZgOSaY?Z>WU5.CS\?5-gX?)4,&/bK;2TERbc9X@NIG2G/212.:.4X
J+W,_816_D27WGY78NgW5><1&g]^ES(TMU#(a-H=71NZ-]ZTcRVB.[9cc\9G-HZF
J#@AZT8S^:F&@4.LXOc@bF75FU@E&6A<c5+P3eB?Z[QN;C+_bfaCB.7VV;?XW??2
KD)+#B8]cDg:7ECE(,b+1S2LC5C/N5WXJH[G81gU61]Uc<,YJN(S83N+7W\[<?YN
,F^TJC0JRU7^Lc(7F5XT3<HE(e^LIRWYH=L6DZgM@0&RIa4TVGQ8R)8[G-)W\1MS
e4T#9aCJRJ?8(/7IS?1_9_7aa0U5+2^MW\f@-4)cPbK6.Wf80MS3.E.U#&f/5Y)9
HQAV\;E:&;\Y&<PEbN<BOf?KIBf,LWa65+OW\7HGYL@=>UdG[Z4GTBO,26VZ^<IX
XAQ08B3[/Q[b3_+Q_YXF,b>-FHNaV,V&(<C<NUF(AI^C&GTC-+SUB80b,/^aSON4
SQg9(O4cNTKMX/ZIa[b+K>QB31e,;8H3(HR]HV8K24D258^_^\C5DLD1XK^34ME/
CD5>H6-=)dBdfEJGGH-,6aXg_30@CgcYf=./S1C2]OAZ+g?C?N41f=-JLAC+V7AW
:_MGTEM8.-TV=@cP7<ZeO7_SYIG7(?6/#)=U^@DC86M5I[g8@:^8+G-8XJBIU2=Q
(fYG]3[U)4;@f#.R8I?FN1YVBGDT\J7J=(NWWb.BV5HV,a>ecM(05X#15P.H49>J
3=Z96AY9G<C<)/#=#)&6]+gVJ;TA.U]+&)R?\X.UQXPZV2=:[&gEXaX+a48@6#Z6
,+C98b#:L@T:J2)T.4]H9/,EL1I:)cWf@0+M\Oa\)b.SO7/\=P,aA74#e#N^<YfH
BJ2DI]+9MXf3GNFVPFX?OM)RI[U=&#@TC;?ASD>3((+CI;&PY^N3R?ONRKE&R:#9
gH1fBVdDCCO+QMDSK\dMTU4<.?M\1S9a.M5+6U^)TVg71c^Fd&Ng1aODc;7c,RH1
-9N@=aATZ6I:<K[G8)RL31]2P:(Z;0#5McdEV<?/D4#J]5T0O>ZVNZ@,X(V#][^W
f?+.6&3Jc[HLK(;V23:AI[2Z;]c\5>GXW1<=;J]+K1IN;SFU,)cB_N2X.f^^U<MG
Pe8LR3RO,NWG@Y&),;)O+8]I)#GF7GX+JXSFA6D4-0K=T<d);HE[KgG:W.,_(+W0
E)/JXZ3H[BD.Qg<#O?Ud@_HY_QA,3LDTBLRSKa07/a9G)S+GAK3MNESQEQ)_@-[E
#(R,&K/QT4SJ&9g@L6.43b_QU]NT8GD5EN0b\BN?UH>A?[d^?c(\e217(R(V-:6K
[<cbO[=M^)P,_]??UFU]??.G3SJDLW-BH?QaUS4_c:KLRR]/04230#CI0;YWCB,8
5S_U;c6Y,5L9Xf,Q02,=+,_SPP5E(A(Pf6[&H.4+GOfP)be:(>S,>C1/\Y:>L,1)
bSJ6X?1J;T/S1/2(6AJ8SB:7N^QX\7HTC-;)(]Ed);6[eU6/AdB-(B=TV\9KINM&
T_b1XH?#@<TYF>bP1#cKTU^Z3DJAO6\IRUHIMaI5d;fKJ=W6G_P4e5PIHg1F>P4:
K?g8]6PgY2BGD?/7R[9-M<\b.2L=UOMN[Eb/]810K<HVYg23(/=._(e).;#EfgBg
Rd[YQ]:\H3:OHC5VG]S0G29[7Lb>&TQ^a65V958+Y>JBW,e?\)@HB7A]Af/[W1UU
DWYE#,Z0Q&EdCJF;4^;K,T_W>&HS/MfQ(2KECaV<]H?OK)OGNOd;^/KT0KECK/#)
2e?[.XE_a+&[_.1LK_?><K?):CY#=?c:AEFIcN\]Q0D)B_c6gT\O?]Fb8LU2VDG>
Wf18CVZa^;]A]TB4\0Q[:.VFRTfS_e-cY(P[&RYX(2ad.;M+.B#2\O56^)0UR0V;
)aa+K&CH\bY@#H&:@B\/C2Q57,#OA0LVTY-C04H+@H7.75,TVB\_)YGa\7-8;0)f
F&4.XAD=[#5G#6175=0FB8N35I_03BK:Tba&RW>@4GZ?:-a:Gg>O)-cd(3K0CfE4
TD<fMf+R2\NC=D85QVG5=]^a@2=?dR5NN4/g@;_5NZMI/J):4UFfUV8cZ0P9b,7[
[)FDJ]f8/Z[H7[93fO>Lb;;B1B<MWESMb1fa7#2#De4R:dQ3;#E.VR^5BN4X19aT
N42A-R0@(/[,R;KRJ4[e6PI_/V4\/a1+]4U)<5C>eX#NR9)92G<fc_O)_+3Gf]+J
,7F(A>+ZgJ8IdeS6<bGLIP>GQV_QJ)OW<8QNDL_#-f6I9Fc88&T7^SUT)Q0b6BFJ
ZfETVO+L;3V4SERZM2.V,+&#T&6865ENI^^\T@#O3Qg]Y]d0O6b&)+aD3Z2_\FD-
G.]5ZdC3V#/D0b0^)>O9.MX\HD-eV)cZ1\QfL3\S40I#Yf[NWebEGg#XR-#22,<2
>_U?SK0=:&RQI7X&=+:7<S5UF\KD:(E8@IJ[^[5;C#L^Q<,V_Q>@:M<UbB3U5(5d
SXG3Y-,<1_d?e<R7X/<aU=1DNSbEX,]RPeIZOXIM7)2)V:_&7[I?4)@JV;@)f7I8
I]3?:aK?e^e9:=ZGL+=Jg#C1]<d;fEa&/NR#Q\e]_J(&,gBK5[Pe5U38JbbH1?V+
7<0cG9=JB]UF=V&TQAT=U/[MRdQb4V+,]89VO6:.,PB-W);FERc0=5IX9[=SSM92
\JVV^H@WR\5&eW^daB4(Da,S3&FSA_T9>2E:&H;)6):()4S1?aT^QMMUS(cR-E,6
gSDZec#[?=&Z3KXU_K[\?^g+E7::<N@K&2W_06##CR>L+E4\e9V^BQ39(QKOE:K]
1R[c1YQa:^V;S]6:TR@+1b(+@/-F9:;PK4ZAH9]A@,^LNG?B]4431(bEGE-aBFBF
\CJ++AUb9&ZEB)P[ND7;F?MBKefA^Ydd3Z+RB4+Z6I[R=Aa4:#dX7B.IDUOB+B)&
D7VgG1>91NJdA9,J+CZgNO>,.LOd:DR5O87eT3@CLDJ.eC(Ie&_9@7+UM@Q<OePA
U&9TfX(9&]9F\<LbQ\NabA3XB]<UGFb?SRD1BXeS-ZI:Q5(R^9X#_FSHUXOMaO<W
5OOBXPR2H]6bbb/dgHD@a3L/.,D/E5/UQgZLQ3R65F:&N\Y1R0c_.LRF>a6]WgI6
).[#TU2.D^OeIP79#5Q;dI[F5W<UTIXG/=242DK-5^5,gI\=2S\_GOK&2N+<YPc;
)X0^+[F0cFS1]0gSTXA2SK=7&16BKH)+C6,g2>E?+YT1&67fOLe&?Q&aOD,Y8(3I
E/SAL/Q#DBM@g-QFX[-4Z/eG@g<CRD,7/J#b[(9g)D^>/Xd3XH7@FF+FN]AM9<6X
MO:<\=NEKASNa9?IfM24G8#BXC:@0RX9/R;&0+837?JEHdN)QT?6U3Z?S)L2NUeX
O+W_[^=>J);;><L8HRT?-@8+@gc9B1-.IT5ZZ8H;+\6daJ?@^<bZJVOCUSMdRC\1
JES:W2T;#E6>Fb2c8dLD78I8[Sg\V,D<K2aaUXF)cC\bHId)YN>eR/B?M[eJHK46
Q0Z&SP@Q0D3CJ5.NP@9aY0;I@)ce9,-BYRILJPB,]>I=Z&_UcY/gRAU)D/M\ag9V
:f.+R=^\RF0FbTPXM5E7@K@5_Q:PXd+\.TH;,44KGdRZfcPQ^79)UZ78-;7gOeMZ
Fc#@@P>.7.8Lc[gcSN<TZ^gbMH@9eeHB)6DgO&CX2>&18ge3bC91b\SM2cR&_aXI
?SX2I@?#5dS?+gfOMW9ML](OE+T]W@&>PbO]e721[WB?aHYI@3T:#A1[ge;S>(1L
>.X<>BQ0Xd#6A<0\<(9O#e;L<=&MUDcSKd/E55Y5?;ZD_U^De4K1X/#ZAYZ&>12d
=P3W(COH,:<CFA@:WGeAKBK/,b--B\^4^X32RNS,/QBYTQN;f8>>e8[.dG8]c\9S
>51(Q_.gYYLFL&FVPZT2S;><e9.HUNS6LdI(-/UG<&R/_,_M5KT#:/KF.D;69]WZ
;RgB@0&)9C4Qa82OM1?XE.=?1dB-5/#-79Kg5XZ:0I6.?;LPTV>5<QUb0.M,a5KQ
+.^AW-[c6e/eK>abJI;Q.bMF6ZTVTS;eK9_H^N-7_EAR3AV-AfdED\XHZb2:?HTX
J6XB/\P.TSEL2[F.\/,#5CP,R&UUOHTX5+f/FDcAT0I]d3B2GW1g8&KNQcg22XJe
VHDV5[+3<&VXJG3\-6.]1FB;Xf=bf]a2;VW;ICV(#G([#859)+KLL7/#L_J9YO]T
4e.EC6T.LOIKU4BN;F:0[0GLNa.&dO6PW2A-ED.?aeU<J=RQ[=]=115LJc:I_egC
Fg]gf#+Kg0L[>WD4X:2-MDSF]R7;M@eeH)93C(fD\Fa>8M[fI2]PESMg/\H5&IQZ
<N]HKd[7K_J8J;FIX6J>Yc\;O#-g(CW&Nc.-7H^0_+2(UYI5,-G_d(Gd8?H>9EYZ
#ZL=8TdbV#R9<964NCMZ7+SD\>K&X<O]5/bIN@W+5B_Cc]_,9K:_FNLZ9cB\R1G)
N@OQNb[cDAV4QE5+:31?V.6K1RVT7Z9C3C1)J<\F[]IFJ]E,W]WPd?dfcO\&8cWB
KdUI2MD]:aM/CC0_g[E/L^_@aN\6+8_5Fc]\ZA8_>2f2\O.C48MaCIV+4-D]g2NW
gbJK),F(FNa67ML7;=cM)bdJF-EUR8H8@6X2)&2B(0VB.+<2:WVTR#F1(IGWdb.S
O1LbW&&IKdWZA@6.3<#-WGL/TJ,@eWY)bVNAf0-<<+,]22T@b-ES)#-+cZBADE0R
NHP0),8V:4:U[^Q]PW31@WJQ+9ZS=M52OU2#]C,^&CH^QK+f\H\(_6e+,Qe9>JS6
Fa>=RKHN036O_>c5H7&<+<cOD+_?P]eC=,fg.P_JAAIK9W;26ad&B=T;/O<G>.Q8
<@bRFfRW3JfAbL\c/gMC^VPT/>;RB-&MU1M)8S:XW@Fb4,Z;6T3ZW@VDMONA4SAL
DAB9FG0\0TCf,[RHcAQ276-A7Df3MeN:Z>Qfc.&8@dLC83M9b^2TWGLU?Y?#NcO)
\OM^P<]>F]1.NB-KEECfDD[AZVH:N=,&)P&8AgM8ZF?B]C&X#+f@BO4))a^gUJT<
e,V[W,cL,gPAD;]2>#H;.7UO1W2_K;:QcU>8^\7B;LUW>@M(@;HUXM/>5+MRSI[L
XJT<JPI3WPH4M<D)-W<0NYD(=(G7JQHFQYg:bJd5WMQFVZ.H@[aPL,?>3XFS3LMU
ZXRF&Y:,adJUZ#1LM#]4:_9SR+J#gNDBGS]-RU7Rd@DPMgWL]\UD5cP8FBWb+0>T
]W3?A;R\+NY4OE/)EfggbRV=_&Y9POJ4DP6<#Ea7RS#+)^Ee.0c]>,H84-8DH8JU
/RaRR4:Z1KSLH1GIb0&I7:bQT>SIKfP<-;O2J@:D[D/)ZD)+g1LG?AXaX:1-D4J#
N;=UR7M&X)_VbB&RQA=]0T,4Bbag-?_@?VC2]dB1cF,T:S0?8g\Qe[^a:UfHOHCU
9^EZX,,B.5?g&/#82Bf?9,G.^90.>R<=(fY:XCSSFbPeM8M3/I-I-RJ\>:A7(@3:
5Y?2\S,Z_@<&M]?eT>/R6c(7M/9,S^FQL#YdZ;3V@^&]6Y,0BMAA;D>[f/cd?[@1
X47d?N-@6U#:ZRKS]TU^8?6^:5&gFIRK/LBUO(UG6?=W>fT\Gb5F8#PK#/:Cg^-]
7e4&P\2=^BVW#72^5dI3Q_V/TFXQGgPQ/4b/c+1^.0R<7>Z4[IL<=^Y&CONV>cWV
Ta;3ZMdES67D?4/W9A)E&<LOQf?b[efQ@e79g]T+\ac]I?GYF535E:2dI4)Q=1)A
8\LSb;D-NYBY59Z-.UM(4<J4G22gS/95;c:Y&F_(7U-M_Sg4,9?C>JAS30McJ4AW
O4C85-J&M,APIfK;gdHDcBeM/GOOX?-9A8N;=ad@efUa7<a12V:aNO?]B,)0dXJD
<H1cYOLF+O:B\SY/-?RHFYRRA,<-DVG=H;KBb>/R1+eVH==WR#4M5XOMODIYe<YV
Y0-B>5?TY]F2.+cd,f<,?/)\3OZ08I;4T9A\&H#Q9>6c3O67^KZ7a::FP52\U617
EAM2MDP?8_,PAKeaeX?fd;;1[W_G0c/ObX+W^PObeF,<8U;,NDQVDCFV+gR)(aH?
gVa.I?c<.^DfD3W(:/.0bR(D#.4CcJ1CG@1ZIWd?Qf)(=;1.R4M+/KN+2-P-X5(F
-X+\0,=cXQ#<BC8:2(^g)JC,++SA.(40Wc:,,QDJT[BZ)e(Sce<2g-?f#=JZL@>U
K4aKYGNX-6Ha<SXHC8PZaUR]>_T\-,]4Id5+0@cV<Z.@fF=0-G0LH0([g0>?d@C]
dCVT@PCBIMPaH3I]C=X,TG]H(6LVR58cZ13]+0IMP#\)G1KbAf4C)5A,Q7N8;ccY
B8O;?&@MB-QGaEPMcdg(D:#d</K\#WPDaF^eYgBR9W8TA3)))@[?BK^G@HReLHfa
7\aOb95cdReDT)QW46/\VUG#_PbD)=]<R0]cH>TJ#Q:\<+=W&-@9;#ZI=b:M1X4D
c6?+GMHgVYB2_=PHSS^AO_(Od]c,gMK[Y0V)+AQ^G6H,V]>D,?OY)3L:G^bOK;2N
&+<I\D^.\g484.aKH(KDWdI:8/g2McPQSfI?TfK5cd(C2C1Q_Z)G.0;/:8_&/I7/
dB[\DLe)/X7e++Qg^2<&VK4BAb-[BZ,6GK7?),P.QN#4/-;M&YdTS8PEGg9D9Q)b
2?b493b5Z]6JdICHg[T]aGfRaQLTO=/+&L0+8,4=XV=F]c[;bOS),-bK45dN9eg8
5&B+(R?aU>:SZCK1,H=EcE7IFI>A+\)V@+^4e;D.VVP^&5ZEE@:(G[9R&C2S8+Y\
1AZ[(e;HF-_YU-@T-E1B1#7Y9c>QFO:dIHX<51=_30T0_C:;]E[eB0GXN?&03VRD
CbQPDH6\@fPCZ<b-FT)E;>Kb7c5;g1acFX-8;2N@H5A(M3<@c,74,,1C0)9b_NX=
;V1a\1@<Y,cC\/d>7CCPQF&f,]6KeU<B:TAf7dF[IB7Z0BZ04DP#07U]WIS:Ce0,
,MRGL+c.\S&/@g^W?^dR9D#RQ^6IU^0FPCGCV[3>aOd2JbW[2O1ZaKPA?&b.#T&>
PQA)0N#>(NAJWa:GEaXP2-I62??8#N9I8<5B+X^XQKCSO5T]9NFdXW29eRf,AXC2
P>YERW0NZ;W6;([6(3(d47P>EBeR)IWOY1SJ]2c.CbR^&7]GO3)C8LQ2X]>]K5G-
2;H9f+XC_NE+&HYX4HI&@bMOLT>a_,_&:83Q_/><<b(V)?AZ4>Nc,643g#R@I+f-
fX@,F-beZ6ef)#VU6XXgF-]NQ+Y^+]@MXJL^834YGCI6TFcTXRCMFG8?@)G1+5g8
?5\_K>>dRA13H,BJ+,00T[2^U_&e)cdT;29dM>5?2R;^_L58#-+)c:+E[^<IQ]++
a9O8_7K/,PS,6J-ES5RF>7:)\H-J,CY]0+Gb+VXBSTDGFQcKdUbKZA7QgIF)PG^C
f=a^.DDg6=@[Vd_Idf1UKdTF=S&<NcNQg(&.NBG;4S.JK>[-=TdS+&K:+6bDHa>a
MD?IQ6T/GL/^TX)10LbUY]W8A2#F,-fHGV8:YLF)5]M2XB4YMRU)K2AC7.2=aY@J
37D[-LR_3((3@@(_8V2c;GHf91YX-(PZ1KV6f(eeBI)R&,43:Ob>Sf3,c\?GY+aB
+?<2A(X\D]]S^W;G@A(>d:YXaA\;>EBBJB#E2ae5-2aVE:N^\EAcW0,CRCI8=<^#
IJJN>E@6F<..K3:6aMJ.4D<GYYY@I5HNCELY[P0fW?]<-)3TCADZ;4_55)9/Y((F
cNUE0Q?cG7=#8RSZ.3c=,Q@/WQ;#A>Y;6(AI\Y-c@=KMH4QB89Qc=C,XP/IS<.T+
(B66-)ROe6INFK1@W2Sc4A;:X)VTGCFGa:bR_[RITZZg-ZTBcQ6Y76-B)]\AU3CM
[GfJa^;G7H\-UPf.?W?7Q?;-2bFgF;EPZ_K_#@_.D009^c/1M^X.?(Y=L&B8S>6X
CbC?7/eX-,+b6MK(I[R[=6A1RQeFHL;3H@dB^Xd_e4Lg^PZE_gJ)5W2g8ZQ;^SQ:
AAKDX\F=Oa(bA0\P:W_)78QZAM=e0N2e:@L&#):@/,EAee5];=)WTdda0+K=KD9A
eIe&2eS[+LYKJ(Xf57J^AaF=8/BUeeME#KRbe);+AL@[GA2c2#0#+YYY\_TOO]Dc
+\aNQ+8LZZ=?UL,eAIG)-WF+MbLbG#Y_A&LgQ1fS^bYfbb<+&G2A2FSAA^6a\_g\
JcO7/ZFIIKJ@UHaOGUR@&#ZH/dAQc#?C/G<KZWQKQN##PN>(OgOZU3]e,bN(a,C6
&C/5<dBfW:;EA9U,,-JcSTN81^X_N#f4QZ_?A5/Pd[e=;I9Qc]@QeV(^L;I3XPXb
2][NOG-+H8;\&3IG.OLS6GaM@3aa12WgVU<ZW/F-4:C[\e-#B^W#0L&4Q?7XePa:
P]M;6bA/fU?.1RL=@)C@L63HFM+(KIE-f-IYP-F>,(c6F+YV?K995PEQF>?.]Uc.
;1W0(L[g:]VPP;T?37F5<MF,[R0K@>Qc0)4ff1+Xf1Z4YRR8C?T7bSEUg2-7KJR>
QcL;S@2EU0D[N3#8M991)-SbMEZ\BL?d,\:C&->IZD^H1FJ]@WKHeGa2LPC?&RT@
WWT8WDdN(9TK^AX+K9+&MD0/5=2:74f;ALWfC/8VP+_f@&B@Td\>PIL6Y,2)gEI0
F3>>&0/7PP1/5H44[D8.AY@6\NAf7dE\ZC]U\F2Jg@HeNFB?M)dB>\4RMB6C,5G0
)()[T?#67(Q#].<GI)?=Q9]\N]3UEacG_3[OSUP4Yc;d(DgO>YC\(Z3P:#C.R\0)
DXb(:f(M/FU3=(MH3K5(\B+&7gIRWS)^C8gbZ]K14SZBRP7DOXUO-+K)5Cd0CG[I
27)5KGQ=O/93=bHM7Q[3M>a?)XKQ7MP071)Bb>eWOGTM2]B,AC>N--b+C2@Hb5<T
I,A1B8]Nf3@)>cT2JWD?QS7,fB@C8Fc=8^U-aP3[J:+6[7Y/?BUK2=,/dO.d6Ld)
5eg]XfM:He\;@@\/2NNR\PUJK>XGY0D6e&KXE<I/T=RbA4Bc2.Y;K)((()9\O&N.
W2&0B&a-GQ1R&P7&7O2Z7D8e4?(Jf>73>XM3MKK@2>-YDBLb=@N#/K#cWU[D5-3+
65,ZYX,K\8=3_W\\2dO^A^+NDKP=H5J:;@BEAg9D4WPCdU)<80]0H6S[Y;,AN?O=
_Gd6[X(;I]>eQb;-F,Fe2LeKEEF5V:M0=bIG@V;=cFd&<Y@:WSW?AIIIe:_J1RBB
\Je5+5(fK=\=#3Y_II;FYa-B]Z+)HZ#2Wb^_U??gU;/-NIXVT(U19D7<@[5M7V8/
B_S6__;8ZRMSUJ]_Sf(aL]\U,,:D@LNKH3@2VPVVK1=;&RP7MWFO=2f>@G(LH7Je
eZA5BM<CDR[bK)@a^,FgHCedMK,K<AQg\KZ2SJXf].B);-].H)+@=X<<9edf4F>8
(aMAebHY6SR4@g)V4QY[_g#D/Wc>2VWPFI#[Z,]OadJGX@6_#V9G-QT:)\.E@(<^
_fQg?a(4,9#FW=X[Q]Q.4OSHB2?J;PB?S=E&\D?8;+\^VPT+cRX8SX/)VMFD&Q9?
\V+-S579X/P8HOFM9YU<D&1X4@2NI\7R,#-KJ<^VQJOO.TZD);-Y)1AJTR7<B?+g
A5Zb8#.5K;7O-+C;]fK:-XCU.WYWO>^JJ1,3;=.8A(/PWOM\R:&9#c[K,A3P<AHM
#25Y][WC/[TbG@cK^^)K<+CA9RB2UV#gf5;[IJQ)Y]XISfZe6gXM)9V-9Y+b@?R1
-O3-a@?[-3ON9P@b)@c0SRGJ@abG0Q9fQ99/OBSO7\L/ISFgF:f?]6T?H)VX7@4a
:@e^.:]^:G&F_G<[:d7Sbb./NGZ8#DKG#0>e7dU+EB/QW<)J<:B40/GB)1>GFC<8
L=KXJDAc[cTKca?NN50c8Jd/W_Z5aGaGeD&b_f;E&F,WfKf]S1T#6C+<c,JdAB14
\X[J[[D5>3VD8^95=LZ[@&,W1A?YMI(<g;G8F6f59@Edg3eJ#[E/A,W@-J8<G6=+
5+,SLJSc#F;bX2G9?>.6WOM.2O4X#.[bg5WU8PGNZG78JdQ:H</07J)BP9<GZCQJ
fGOa4AN4GDJPJ-&J6HPGP;K8:O6D84K=/CV-KXY-d(7Ic+37/\W2T5\Ka9O;<<=N
ZRP1F,]F[L8HMJC]G5adQ52UX[b+aC#V>0X0GcQ0YY#CD9\,S@2=B4S;:Q>DA^J(
DQ[e2aOfJ]HBNJA)-^Y-G].2L(],TH;8CZX_8<1-3(MMU2(ZW230;5f,6ePRSZAS
]BEP5d8\T[&_:19L0ZQJ5;:1.P\W7>+[+U:^\SG<G__dD=SEAMIdWb^0=e2\#,_#
]]93aPJY&]NY-6^d_:WMd@RA_+T2+6fbF0NJCP/a/Cg_I&0OeH?\2V2NA8NA+WT0
GBLY8CY-(8<&Gg7LY_Hec:4P&FGN3C3K=F?9&A+M#6XF1D-/\F01Z)#UKST?)I<-
OSN;[9VLeGagX]YZL5?^((<1BE-0>KJ;c[9.SNCYTKEXQgHAR.PIA4)A[<ZWU@R0
N,5KNF:G@Z=7+6a-.EXT.\GER^XbK(3I:M_ReQ7Q7L)>Z&D+cDE5>BRGR]&?&]F]
:I7cU_/Z^3B3F>310.NO@<bUR<]a>,bF@1GLd)1;1Q9EYBg:AU^:X/\E)cf&/?\I
=\(\?1P.O;2&&a#0N+A),B_c#O;7e)1@X_VP)X6_=6(JF@.W5^V85JR9B2f89H];
R+dTQ>O8?62Y;0deWQ[YWYA[5/=g^CK(QB3QdPA^GF4-+Nf/+,H3,7)Sd)FF&P#L
>]W\IQ&(@Y-D/2O5BgB>a#;#XV-gQ0F91-cT7eKEIKcD+3Lag6d/1,:E4_DWW>(_
8[F40ETddd-G?B;8;=II<4QRJ1AET]^T&&@5T7V<.Dc=KOBV.H2R2f35L64:MgKP
32II<6?5(,;3:c2OR4ac)OU\4]85=C[c_gg(d0[:&PN8d2,(:U>4B535L$
`endprotected


`endif // GUARD_SVT_SPI_xSPI_REGISTER_PACK_SV

