
`ifndef GUARD_SVT_SPI_FLASH_ISSI_NONVOLATILE_CONFIGURATION_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_ISSI_NONVOLATILE_CONFIGURATION_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP ISSI Nonvolatile configuration register class.
 *  This maintains the copy of Non Volatile fields that can be stored/reload based
 *  on requirement.
 */
class svt_spi_flash_issi_nonvolatile_configuration_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** SPI Read Register. */
  bit reset_hold_enable = 1'b0;
  bit [3:0] dummy_cycles = 8'h00;
  bit wrap_enable = 1'b0;
  bit [1:0] burst_length = 2'b0;

  /** SPI Extended Read Register. */
  bit [2:0] output_driver_strength = 8'h00;

  /** SPI Bank Address Register. */
  bit extended_address = 1'b0;
  bit bank_address = 2'b0;

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
  `svt_vmm_data_new(svt_spi_flash_issi_nonvolatile_configuration_register)
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
  extern function new(string name = "svt_spi_flash_issi_nonvolatile_configuration_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_issi_nonvolatile_configuration_register)
  `svt_data_member_end(svt_spi_flash_issi_nonvolatile_configuration_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_issi_nonvolatile_configuration_register.
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
  `vmm_typename(svt_spi_flash_issi_nonvolatile_configuration_register)
  `vmm_class_factory(svt_spi_flash_issi_nonvolatile_configuration_register)
`endif

  // ---------------------------------------------------------------------------
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);

  // ---------------------------------------------------------------------------
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);
endclass

// =============================================================================

`protected
b9B,^]R+^NTDBG;d8=+g6dP;3bYF5IF9KY)KGPCBB6X4S2+?7R3\3)dZC&8]5)4E
GY9QKW^dfG]C^W(N6.@UKA1Da7WAe^SJ[]fH3]c(0X:G+R)_OK\]N;=0;4?EGE?9
I2,<aQT#::HIJ+UAO_AWRg,cOX1e?,<@Y_81R^JYOZ+L=RM=U\8;2QB8dC&(RE@4
HMW9T<D:(5G]N<1P,2NS2b-&[e&CTR[>Q7HM+()L>7N12a^T12I=QU#K\_0/SXXZ
bJ#83Ye,af8(fE5a>X6Be)?:GCIF?4+f=TcY^SedYM-a56SP#/,+_&F&)=GD<>fI
Q=L4f->9H7>7caPe]f1[AU)XV-5Y8<#75a/cegN[1)b2D)>L<b,abOAf<2WS<9IW
IT49^)]0^;IaN=?[>aKP[HCQ4JEP]RMEJ6aWLT<f&NFS4.-1)eS]Kf#)HPH/2=P=
4PYca275JAI/\A8R]]^H?aLT<DH.R6c<4./_^aLf?&-<?XWP7T_]3NX?aKAf,V5N
DW=L@@/B5Tb3.K_CCNDD0B,TBY]58GG,F4/SAbTM1SHY:3E/@6T]XIUC(+1O#N+/
;&>V><<\V(2#WI2D?JS[<7F1L]RX0/_)b(Bb)C\>9(^W6ZA&U0fUS7](E=^bbSC5
RL:GN1dDWc:-3BM&,bD74dU&(4Z8dU@<^\UAYBROG_J9]A,35YR5H,_8BdLIe8B\
1<1KfP3STG3HGHNfJYP>GAXPgc2-D=/1]_c:O5)2K(XC)?VEN9?E^S\B.Pc@:14@
N.+#?7PI&9#ZM-a3[Y^Ng7XP8$
`endprotected

   
//vcs_vip_protect
`protected
8:VT8HC#_+YTQLf/Ye5Q5fN[EU87D6=48)@CK]@OK:8I3.=QED#O2()O,eg[HNdB
R2.;HIfP78?\-^BPfcdC)S-.#7=A^Z8I<SM?HS](TS^[.2VTZ+F_&)9V-[;]BPZJ
6I_MIeA/-7(:47C.&-ZH0e^/,H>\J-QB(T97=fZ(0ZCGXK[()H4)SR#(0PML[@=V
AV;YCR.gI7#@M)3X53D+N&075/E?bC&(TbFXRNBFQ-P6[-CaeIOK=/P5c2/O1afV
^aF@>>AAO^HFaec:@-&^f;HTS0P8P?7ZKOdYK46R[_56IW6gc4^IEgXfd:@WD3TH
=UF3FU)@_463,bB\L@#;+cV^E)GF8-VU4fNYN5fH>UZc1?27ABM#\6;Eg=@aY0V=
W_MJ<bD6\)4E7AW3\Q>c0N1=Q805,ZHgL/[0^[(H5>@Z^_C3H6Oe@U\)6Y3/Ybb/
DPYda)J[AKT,UMbUUU:]5QE3B\3@?TW=9^5JZHdeLcX-gEZcABV)AJgEO,B;:RI0
@&/(VX?9.3Oe[&MLL.H1:Y7g\//@8M9/D7_g1UQ+I0@WD4La?_b3P+3B5F9L;gXa
cGeTPDd._bK<)H8VW:Z_c99B/bA9S(Z6+6H+NgK,[U]ZSKMD52b2ZZJ)>d4R2+2J
\DbHXG:UHZ>2F,77Z5UT>H,7ZP2EK:Q,71VF(3a359[?WQN/D:CF7K/<>S3CJM2Q
Igg>;#ZM/KQH9e-F&9cZ66R1MP2H\,3A(K5]:TdQ/-D88G:@;3bP)ZVe[=>W;)YT
C#@3A?=Q.+8QcICd8CL5\&X9HaPJIA2B2A>I+_\:ABP)K;XTgUS-/HYG:26X_O/S
@&,Xf=?4dJH?8ge03&OdHZ:aXbcEIW++<OJfI]<,;KF2>eA;-F#-@)AV[\W7&Z21
_Z-RE(N;TAfRANa[FVI.LLGE<=,4g5_;ED]1.YX[J#g9+/TXMO_d>NPd?^BIB.\F
A]5>HA/I5F-\9(B6M/6GLR5b]XETNPZ2Z@M3,/\1Y7V.1gSL(g?R9CdGOAZb#0H(
?gc81cNYP:F6[Md[&LVNPKdR[e[;PQ7DgCg(--^_WZ?b-5)SJA9+]d<e5Zae8OCM
BX-;YX:P4b^]:\+#EK_3(=4VNH0UYXGA=E\WB=(,Z2;bN+49RT+?&g82]@EZC&c=
.3/Q)e)8C&;:5O+34YF):-^LbRGAfO8YF@Q89OO.2EIcPabbe#.\[/gfY(#I2c82
YH[F289WX[SM&HaV:cD&a:/;W1<a3S=HKVD=EO>d;:Q[#bCaEGPgU2-44?Jc\Z6V
R5Y1XW\@0=8^88dcH1X2H^+2#Vf9@P.#Xg@&8L,[&)394XH<\BP&G@,,+-YE(#fJ
<]eZP\KF+bL+>bQ//BTIR2WYMb05IJU^V^\=ZE:fVWRA]#@C1Cf&2_7C5P_Ve.g-
]d=6/HI]WgGYPLTH]TTXc;V@:0)GIA=Cb7IP:59c;##=FRICI9c+GX#E9dg:eWX\
&;JROeTVIZd9XVcON_bY23OB>G.[M]NH@W2R3OW[668V2HK&0BaZ3?FaKa[G(I7>
VK1JH4>c-b?+KVBN.M]JT5UA?01G^7&:.8]=[2?3I@M]ZO-6_W(GN&G9S<_3,5_F
:0AE,8EF;6OXM9J/MX;3\C/Rc\5,.c)X\5O5WcZF.EVaM15d+N]D;eL?XXM@Q881
@)Q)-@B3a6B,K03YUZEO8)-PD_2Z_O[_@7#?0XbISDe;G,M@BM>/F<KHXO^1--U:
F5MT.=9OV1NEWQ+HY^a/gZNgVg<MAdO)BSHg3_/XH(4R>:VN(IW3ANQL4=6LBAA-
K)^Sf_>aa;=)^QdFM:Ia=R/_.ODTV,]M(K_M:I/FQQ)3WMIJIVCO;W+/K9R+<Y(P
Z^#JWU0IYXBg=:b[Aac-f5@X2S(5?7JE[EC]^WO<?VQMc=ISXWA#WE#ZB>[P:W@_
W1\BCOG@#[+b966LIZe+\0K\KTX5/:]Ld]E^DUgC<NVE5I@2g,e>C<7d[=P2QPK+
85)A45Y_Z04Fag[(a)3Pf\@TaXGC<>TE>#,#M0\4@7#;9)?R3A2+,3JWcQ2N(b-G
0H^.LO>[N^cR^6>V7J<(ZRKYP[&<0G#8..U&bTM==&QZ5S#<FH73\M20Ue15_f4K
2\Vc9^b1TPV^BA-:D[.9dcL(\>Vg7NH(E<e&RbO&cK/X&M2A;F6+DV^IOX(d9+:A
0@-=Y-5T5=;\Z17V]111G5@G.RD[GPQODV:e--V/MW][MWf]N7fAL7FIIQ,0,2=D
M83A;=3O+-dD\1c2(J6Fe):P2CSb@H/(>PeZ-Bac/66@XDgZ=#FcR[CZ9=Tf-[Qf
;)V#/Dfc#J#LGBN9ceD5WgYW#:BF>cI>BV_]7@4VHAS)eQ,A)V@.T_#@]XYM@526
)H/G=]U;bDfB.bV58S667P5R([,,aZ?fTP>ZWA(.E&&)&1ETPTacR][f[4f@GX\V
dVaC[X_^OcOb][N;cM@B5?b7_Y/>[PK=RR2FX86CC+2>aS>UMP9gP2S,H>WfDVF?
<a7839Ta),e4,bX_ET#OG\6E0R)SYd1]32JKIaY3:O9QOQ_&@C^D8&HGS4Sf6(F,
,HSf:J7aU83F#Y>6.E3g,?GM;e39##;fE81OJ(aS:?9#;;ML^UT+5^6=W<]:gT0=
SUcEYUJ>KMg#)d+f(,)X0Y3JfWfb0(YJF^I3]e;3R8XcL;Tf>_1Z+S/M+.J/;3D,
^RaC&SU],A3=&O6J\O_0fD3L;3;ZM>Z^c5QaT)GJ3I@RH_UTa3#6N^YDf:(7;fDM
@dQSE-T_\]ef/c7KXT8N6TUX+=^5,(R_g?^XK2\T(/8PPeQBW7+SM/eUZ3g[J[V#
,cf^0,3C33(HK66^(5;;6G;aSDcL(GPIW\_?H4R>FW9MHLO&R5_&MbAEWY>cS)@4
(OgD[acVTR:>=Tg9,,\cdM--g.)?5GSFK@cc1P&V5=7@?11g)a&#9bKC:D6.\_4P
)=\0U@K9Id@,c^_A#RA9FH6I]_#=&Xc??V_+]KcR/+06-JNU/_TB;2<f,Ha9((Ge
>8/Z-G_M06XQR1B;W,IT^LEKe:A7d,_JMR-Ba;F[X<[f[=bPCQ,PK\T9,0B&QZ-V
GQSEC0&O_;FO3[6Z]5:39Ma5a[KO=KV<BI<MS:N5FPcW>24RLHWIK.BSCNaZQ7,Z
O88NV@eA#(KVX<Q0fBB5O_QDE&IWQ=0NQS1BdWc6<N:<B=XHN]Sb9[08)<2-Da6]
fFFZdZ75)NR#<c1FF[768F)O_R7B\/A2U&.00>S(U,bAS<AK8DaFfPOGWUSV#L\?
@3DO7:#FbQ&,B05=PK0??88d?<aYgVNF5YYB<CQfBE.<>>QbNL:D&9M?NY\5XV,@
9,g[9W0aXdREc9>T[BL<,eW21>X4S&V4M<[/4>_BZbY4gIRVTCfEL_LRC?=ENY4M
<;/FP]Fg>2BX;CO?IUH;D5f<c:/7+JXaPXM=>eNSW27H)9RC1/WDW+e7M_7_OZJ\
7P.JIWS8fPZ^A<\/d,/JC6/I[bI8R[ET>2RM\0=5H.S>XFMf(@[@@H[I]^Ae/_N@
>S=^^O7[1C60ZMWgLJ9O.^;ITE;PWg?RM?6b&31>49dGd[FP<GD+/_[J5+NE):FN
>DW]a63Y4X_TP+S=d0IYKLaZd2.ICYJT7b]:K-348Id&-7/Ue/c/-3P7-:?;1f>V
e2^Db3,g5YTZc1?K?0OeJB(aa:_>M7dN&+1P1_M1-5M+M)XN8g64\dOfeY:1_bF&
<K\?@F5^/;V#^>&(<U5D4fAd>J-I8=18A2F@.a6K+a9dDES5c,gH-WBVTgL<Db[W
;+<K/Z\(;a&5996&.f_d3=Rc0/BM]VZcD/>#]gJ0ERA5Nf9-JK-.aIH)57<ES?Oe
]R5ebROZ6VdXQ1N0gGKOT2fQR_U#)BQCc\F,a2EGTD#TYZZY=F;ZJ0GH(-.4c].E
bHIP(E,JT^.^Sb(\/ES=SR+71I48]OO.GI:V4->0JL-M:Lb:IZa&5Z;:46Db=01/
RUe,P^g#.S/#X2P)XEUK:Y6?HSKT);#0QC9>I_\faNL<8K)^aY(-ONESJ-CDG/Z2
)[d/-4[JJ6:RTS<K7#]+ZO<(139F4D9E_-b^f0RZa0bFV.H0+.6=3]b3aR:,QIE:
CdPb=6V9VP;bA7/d&Y3/HQ0)0).8bN4=Sf)^fg:#aI(M]<[d9H.:T1eWRGAXYV]#
aLJ.ePJ.N1XC,&W9V\;&P:RDQY<70C?Wg+.S),90_E9>GYA)<5CAWJ_HPCIGY)fH
\X1.JW:]R6@529NXRd-?LUfAE#gW-MD((;B<1P.?TQN&JPK?RF-=SE&,J-R#QJ=#
H<G&=[2A<@g?Wb2IZ9:DHV8=[&fBcZ6_8_#P[:3Z6-@W<b#;d+V,C_EG[3:SF]X[
HFeHJ-1^(fNaV7-SOG6DJ,3U\0VfNN]AWMdXf-VK<6BCJ[<CJ5MK)]6OETd,R+-I
@1ZXNU3);QRY58.dN]4\(+.KY^[a[[;56AO6V[I8&gGJGQ^-SF&PIC>?eU7D&D@[
Q,bL2VeGFZO/LC=3Q/G@G9_OcPEb?aQ0W1EU9VP&7_VdQP]AM(+XGfRXNM3Y,X;e
-fB2OACMbKEae+__eg^7MXa++c+P+/d;9KLeVZ>?<)Z;AQ9<13R##UCbTe#@I)CT
&0J,\e3LRTe=;0K;Z?Q#PZ[7DCZJO-P=>#<H]TZ3,g_6NHNfM4/g-)_M<FSP-a(8
4VZIbD<3>-gMXRf55A&0;N4]Y<D[(@\G2S-2RFKA&cGeP69ZI7T-R80b--LN,/WD
K^F_W55(&:()gf/d1H2<UZae(S>(?S61+OZQ^GFZ_F-C<e8)Ub#BR<)?f./HL-IC
#2e\])]N5DG+\?ZQ;](9/UO^9]F7=@bNT;&YGBdU;BbL,G&Cb35)K\1Qe<7+[49K
_]O_?\W)#>gW9?ebD+,]W5a:.DQ@KQF>/W1^YD]D:.Ag]:EKOFTP+_eT\Z;eK#EO
1,b&9#B;&Hf#K5+#QIFbA])10Lg201Z6=RM^@RcSN.cMO9D<)/+W9B9b,c/BIQ(S
Cf00PZ9Z8,0a(139GA2UP5<Z.7OU;>e1IJ.W6?[DX:Y@LHQ>[-4_X+IKY\=6_7A;
OYFfc+Q[g;7I;R2;Z463\#c;(#F;36Q-0WQ5,V&HM2gc:@)cR3_BRP5&B3VDJMe[
f3Z3Hb4W>g.c8/SKJ^X.0gcPK:EFf=gBE@(=+e6CK0f[3LN1.+G[V>C[^dWJE?dV
Yg<Nb2,Lc@C=/_K]JYa^E7_GQ)g8ZU&b^9,gg:EdK/RH7e5d]U&QWF#/QZV;d;)A
?DN,eRf2JCB(?K.@)A=YJ>Q_BXG@4Y&.8+4_>UZT&?a^PE;H>8d1R#f/5f:B2B,I
d9\4CP#(M0D<)JI_[]XZI4)[dA]0^RB3gTgFU>:gF-cWQH&ZMgRaHgH]dGcf+SPI
N/b6TdINKPE)5Z77)V=I<cb^-LN@542CU.&I65aT;YO=O[2fNQ(68\I4#dJ\?E5:
M=>fDc^.bOW+c-g16HU.g=@M,ObGXN+/3E)3(f3@fb8AZeBZ^TBD[XV,CJ3F_f_a
1PIYJM(fCeI.<N0J]<\0YDK)5?/>[Gb/-=>CEgI,GfW]S[EBA3K7bU,=W4IcV-c+
(07a8D7a+69Q@U#gdY2_cHQ;L2J[_3=3>1S>(9K+57ZTd-,#+MGfVM&1;TN61O-Z
4CNAD3+Ue:+?dPaSZWJ@G=U>F]C1g,fXSZ1B[4T:33aZEYfLb4\ecR,?V/Nbe^[F
]4:BL@_6^(+<7&bZ/SRPI]O@NSg,Q;fXL1/2,EGa)^F,+BR^3#9:fMe;:HHPN7=e
LKCNegabY15-?1K<5S4VQcNL30dc+Uc_=];?I2f8RECeb5S\/dQY4Le@T6Mf0\>V
SXceD:dK+BS[5)VOS8&;=Ld?G57JDW;G2T5<,T_W0f)06G0O&6H>)AO-Xc:]DU0A
&;4,J+0cS)Q/3D]AKA8]RFeK39MVL@UKM?YEOffREAM))75bU/O&eS7I8QRU>):c
5)]Lf&[)A\1,XK6;VN=)&^^=P,UGLPRQDR^)4LVGY.&W1I&9OR#:g^XOYZ8400J5
SWbgaO,VJ?a._UN@R#c062dCH]R4H=R+&X2MH?:+LH&]]B9^IPLDYWa,gR&3RI.K
dM.K]B/@@ET9K@VW7\\>&/eNO]03Y,LdE]O;3F6_,Feb;,=_BY?-1(,CWD<J:NU#
;WF3a8-(;VIQ&W;7M=+8B7>^GI]Ja</#c@beYD,M(HN-?WD>b7.T1M9,3JId_WC7
e-RPABLV2HcKL-eg;:&QEBd@PX@JE)\fK[TU@8<^POTSR._-2GdZJ4R@G.4bB(5=
X.A5E?6Ie7=\USe.NfL_CM)QZ&g@AEC)5A25e8=@d2?Aa24bR[(\&:22D8/^DW5;
R@YQ&c-KZ-HV^ZG1&9OdP=P5(Ma\@<>[;T\X1HcAcN;MF/BS\I>5TUSOPB&+5Q2T
b^O<@,3YaVeQMTGAO5[5P-VHWRaaZXEUB=)\V]2ZO]-OG82[Gcg<[BJ?Se^RC2]+
G<[YP>Z@0V_<eaM9,+.L3./2.AX;8<^U<PIE:bB40MI^)[4T1E/)E>A1,ZUXgR@W
b+DX\e1^>N)4IJX/M:N5N-/1Z?I2<4U[5#(W\J=9Qa,G088N-eU:[3==6,]gN(78
c=B_7R8EX1XaU=YHVg/Z9]<V<AcQ#50H:9<SYR.25[/6NB<=BRNX#OFB>-9F4-ag
X1G5fZM1PH_&R_G8=EUCLRMGQEYf2HD=3TUb6>>)E;>1WgO1,SJS,PM]LG<3?B?b
c&eQd5\Z6JUI<KW\9S^\fBdab1-@+M-[2Y5;M99gA=#Y_;J+0RR;?V-N&_7&P^G1
XO+#]aMfbSU5=Cg9VI1&faNE#T4N<A(;feaGe5&S@^bFZF8)e\-,M,MO>U8J.[4-
4VdDR41?M@WYQ>ecM2<0aK<V:@4VG(NY.J0;4Cc:fcR@f,.U9=N-KV#aBbN]5G=>
-VgX1=J<488/fP78W#2V^DF@G2,Z&Adg7QBA-S<Nda@cI?[=DLZW@?Gd6dR35(_7
9.>A&6NdMF8A\cebE(;K=F^f:I)=SC98LP01_-gWCeODWPgI91_g2dZTBC3Jd-6U
F1[++6[ND2JF-Y=fX687UP..[CLM(dCKe_2WDH;&CX@)9I?5RZ9;3a7_+9HD5\O)
KfQLP&(S)_B_<G@_R87QR<B19\W=Gbe=PU61A9S,0HSYZd&a?eVKCNUSc2ZT^1(#
(f@@/OXP;?=aC13S=)<0\3-UHP/&E>]&C:^H9#UW7N0d@OH7WA&H0cKc=V5L&bS<
KI^E#aIMLA7P/K\(M2[6Ob9XTAAEN7[#(&C&[WEeFB>a59Z<B;-EL86&K5.Md;H2
Ng.=C]?D(b=MKQb2d\=U+O)dJaWZPX^=KcK]+&0WS.^[(Pb;P[eg)-ZS\g35LKU?
V6MTRYV_ZBKE5^fTEWY=JM&D)U>LHaIC;V-,fa=cOCaVG2_HA[FH:[.M-:THN+9b
B;[WaKa@eE)SCP[NK<W@S0F-#Hf/DO#,b3TGK.C3SAcF\PT[X=5fNWIRXWcHH-WW
2eHV[T9AI@TT3[Z0PH[TC7;7_Pdbd4O&3XS24gLD,9?Q2K+]>DSLB59=7Ib[0^.W
c6BC5,4fTP?O=7AINOALQB4YQGd/?^G\8a&N_UPaRRc]Tf+,=KQMWdc958;.YLTD
?:^-bN[[&IReTE;8,>PcP61:,^29)MN?]Z:8&SL<;=Fff^T8EWQd#_I//T(=B\6<
KEED_<90[8IDQ^D0PN,=CH\YL@AE?P)c-1aL5YA@E>@,E2d6S.1eA\Aeg_24FeIW
.KYS,/]@(DZa?Mb72UafFEcPH;AY<]]19HEWC5:?8R]8eU)bON4e0)\XbH,0a+;b
^W<a:(9A10=K_BSE6_L0786]^d-QWF9#9PHFA_KH(Q/cVIZeG<G5R[13g&=[+9fV
C76BJKU-W\4fQU+3>.?Ff&-VJ4#X6g1@YC&^VH;&P@G=A&3IAP&-//+9I4S\Q2;P
Jd2(QGaGFg)HGUD9Z0\[bKGP_,^bTP1g:WM,Pe0>b\9</1WZ(e[Y4/Q@S_fe>)[L
LLR/07Z_]g:G,V4V9deU1DVXFd0R-A;7FS;aLA7L7IL?FPZK)0dWUaA[V+6b80^e
I-PYFQ[ZFe>1+\DNBKR;>;-TGbc[:IbHT=dWYTF1JGNS&,Q9^DOX]YI[2A_GPVL;
_NI8bY?LeeSVNLeM64+-c@VHW7B1dZ,E6PYAgTB+^5\#N5+JZA6/g:0Qf=_Ea?X)
[=d<bAFS#OT_JEfbKa]#g5DW[9WP667a\)ZA=[+7U5[>N&b7Yg:&X&S)(TX;;:4M
.?aJC#Y[K(;B(H7JbR]<g(OQ=4[L6[20L2W4KT&41eg,JY1PCB^OX/-J@JO@?g[=
a29>9)J+4Kg^/R=(d2BW@>GA/AC<F#f5RSRR\Y8_abV>K+/B)2B8D)7VE-NN)Tf]
H7AT>8]=0a.d]+9fOLN+1S<_\;;;NKOe4C8QY<7@P\VD?D13DLa.WJCf77\01cLB
_MGaaXa)[A?Q0:QaOHf7AF54N3D@+7)QSeBCV3d&BE]HaNaC0TK_UXG695#WLON3
:/G_;Y/UDTHWJO^@\DM/H+(Jg?@+#+V/[-#0cFNW5:>cSK+[,M:E]]L9:MF_e1bG
X?O82W_U1RecRF>>J;f9R=c3fXgc\fOd#0&M^Q2FK@YU0U;ZcVZY#)ZEQ34BWL0O
O\8f)>RGYB@D6Ed:<UWOLfQa^=a.E@#\Y>f]IY8KL76/TZ4<L3N1V1OKX#X6O3UO
VfMdTVO[,Y;DU&WHW5_U=#bMD03QV\85>@X8MGTA_8]aeSO,=W#BJ=KgbY_:(EPD
EC@2g6WEIFUaPQ/6/2_<8G-0E;K&f3\X&Y[@;,,6DM,XcU9QL<;S<.ABUV/(N+52
_J+_fIX6(AQ:1_TAN]U#JP[V(?FWNdJ7[DK(A\UZ6R5KMIF@KTF+>MaC8-YR,e@e
H,N].762\(g\OY?d0Ygf=+E#.fBINR)gKQ?A3(4aOFB4W0)3eVa/?](>e7/>K\@)
e><<ZN22Q;;X+F3P<#J16Vga@^WAB\e(b8b8UPYA-SdTQ8,_N,^EF3Q(dYJ.>90U
@@,0EU8>V,e,MUZ[(Z]#7I51bE)CQ>Nb&5XXBMCL)44P=<g)Re[eNXAP]QJYR+3I
V_dVfDc89_X/afR]:d=5>eUNS_R)M]B6Z[g4R29:&FY54/W]=/81X0@B7:U3E#C/
dBO2]d]65XZT0]66Y]c>9OEH&U,P(43FXM>Y(bN^#bZgYTeL5\PHB8INUUaTf,+.
/(^LTd/c(f2fLb3+L59c5L[cZ5V@G+[PVS-9[eK<LWZeQe-dBK>.P+@ceaeODG3/
eJfLMU6=_7P:3C)I2eA@/:8S,gO/S1J2]gTW#I]PM;RHE@dHCXEcXPG1I()+d>,E
R2DURXY;)f2)SYG.G[TFBDc[Q4\Vb,90=CXgU(8a\A.SI^7?OR1#PG(gM/FRSWC<
>M_DJ.LSHBRfOO(g;[(>4ZG,CU8a[OH?:LKH-4BIBLSbVE\V53f#+ZFUa=ec@G7I
+I3bY\07ReC9F&/Gg>Sa1B)CCYbFN:bAE+.K;LO+)7V+[H0c0>W&f\BJcQ,JX@04
IaLc-9+g^FA;AU31<X)_O+JKc;?XNJE2b@8]@g2XO7W#KPS3R4D#R-;F:7_;=G=D
GKf3C[fMBSFT<Z\46?O.(M9#_dELC?W8I\>F9bfWM,31f?+PW)f[4_SG/(G6>AKC
_F31Ud:f;YTU;4g-\/4)\_^L7K/9aWQ?(Wd2c@18STN)3F]dJ6F8].>])90a8(G+
U7+V_G&-,99XX@O3E;3^^R9&NVe=HB&5.WWFT+LO(=5:&)MV_1+>RW\-<8Z_]T84
1J,:Pc(+>;8T@X56Q#MJBGU(8NCC2T@GZ(4Z4K((,,RW/QL(>2OVP^Z>L(>N0L1^
WP49C;GKOS^c1D=ARV5F?N<^TY<=\XcVEOJ)R_e8&TBQ[c[Z<=GBVG.)dNQ<\=bP
;&[_C]K;)QZ[A.W:R3J<H:KB9)H7,?-Ud/QC5F4M14IgKaC2VQe,\INZQCPO8TaO
&]APccMa-@Ngc=ED;1Y#?:R[#&TMK8B\)IQ]ABDT7>A\4_dA@9OVfe0gCQ;Y1++;
RXdd?_WXcC;.SdW=5B3\O(>AEf82c),8_XJXe3RN5NB;?/NY)#.MZ)00\#cJG\>+
;9)]R+:bWDW1X;&cH,FTfCT_cZ&OXRZ-.3\7(<KK<)C3^^5LDX08dFCQbL5eZL8P
HG88/TGHV<bGWFJgK&-g.^6@\&Z2TR(gB:PUIT[^;5U5R:b(\IVXT.>HX_c-b5Xd
VeU6?3FKMYegW.Wa:B-WUL\3F1KMMA=I7:N?^N>8]SD4Q#5Ob[@beb.FYcL>QR++
>397_42^PI]b5=e&@,>K)W#dDg[A\EON3[Uf<N+NN_\55;RN;O_ccFUNOPMRILQ4
ae3(#4#[=WII<QRc\W:2@0VO+WPY2FQMWR<F9^25b]JT29AIXcQ&d^VLE8.W/\#V
0SO:T.,Q-f(;NQW7+GJZ6Y\S#9A47#9),;U:\#Ab+YK\9VWL7N7[[9QdM&P2OHG=
-cF_RVQ\7/#TV^a+2-V[P+R,8\BFK0B?_,\C&eBN<>4\>f,]+K;:fZMBBS<b9,(a
:@OFTR23?]&R)N-bG])\cTAd,Z</=.(RP8/OMSBP7Q1dV>3:HdbINYIU9X]>76@-
EN+S&K,7_J.M&f@5E]E.0#R,geAXLHaVObF<HQ)(;cH0)fXa4GF_>-G_[@L+Y[5b
<_.ML,Q@g3[>#[@+B8/QQ.T##.:TV5LZ:J,9#Jff=U6;2b?V>f#VdE52;[f0c2)Z
IV>Q<UYCWT7_3\:g1\#2U[R;J?f_M=T<gbHC@)M._4GB2d-9eOAO+LYd;6Z(JB6,
geID;YX\ZD(CM,U\NHT=MM&S^DMb@VRGC(dF(8]>\2dgBS/E8OUQU+gYd-M9O)1X
C;C/I_UDW39=;^2J#=f]OP2J/)BKN7E]J,6\L4_Z&4T1#8&LW^SMU&W5^,H-9KR)
8B-/a_eYa-<39.-<+9WLOHc&1]C\JU<_b[5G<CO]28gK(6S1T3PBePT]DWWS85&,
Z#3E](<A,1.U<K?LU<a>O1;0T0)54,]7d^14[@Vd/EI-A4H@189#D;FY]DKa-g@>
,@#H.A[I_c-WW1-1QQ?G5R/3XV82@?0E\W/]Q;&EMbM>fZ0GZ\Gc??1P7,KJL?:T
1NE6C6(@WRc_#UME#?_1B;2B4<U>,W(@g41>S^g^92C6aLR]GCHFI\G2O_e&9.TD
I5^[#J2(f8+>#+/J^YCP6BcJ7SN5317@8\M<49=OBZAN:_87f@[;=BV2,aYBc)(K
:@K+b9;QN7JIaRbeQ,3,JNPH,OfJ[NCdeX,6U?FH)KOe4[VKSIVc^\FS1[,D?Z8g
655e,G@+9=gYJ?T&=6G3gA(e4.[,;NE13?5aX2IRR&ZV.-)N>[^Z7RP/T+.PP(W7
N07-,_5=B]b2e6L1?HT1]E23cC]\;e>2)8=UQ\[XN)dUGcNYPY2>RebQ::(WL2,#
NbQW#.cT2H>AD(Ua<QPTaO&:^70SZ/>Fg>FZ-.Gb/QKD09UT>XSN,E8QH>J)C7YA
b[\ER.Z4:@d/-<5U9FRSSeOaUFUE\g:6&9c>^9R_@)2V9L(D#OQJA/#TAKU,,(5+
]aVGaJ+>>cIfNdf-W\\].M6bd\-A7HS=VCURg7=;>T;Q69/84db>+/?1C@\_IgZ<
WP:FL?]e,]2C6\1HTR<E(),,<O+F3=RD?@Sf0_P1IO<KY+6A@???9GD&1V,A])f)
R=&E3ff=QPW[f6e3)&,f+M2If5.,;(G9U218H4QB7.b?G#+\YS3X,Q1FKN)N0T@7
5S33a+I/?>Bb^JY7[\R7]O>WJ&D:QDQR)US7WQb>OO<2g?[g8:]cD?-N@/MFWI;D
11R_774-7-I?QeSQGLF0EU?a:@C7fQ2>3=c/,d;564997Wb4KV(9>K:>;7X[(+1c
./;S#=+<,WLeB0gg=[-J,M2BScW_<Kc]I(U:=Q@RFd<E,C^H=@#4O_e)>cUXfBS1
GL-QYRJ#^d#@/EO]1P4b4b[G)PEZfR;YTX/HZNJF826-3BQXX-?>ZU#,:?6c0_QV
VDU,XQd:Na1aI:_WN8HDV#)<26fMU8bL5(7/faE+78B9WH26(I</a]8A(XFHcTNT
a@bId<#M2&cHKeK31:I@9+0L696)1Q9:D^;OQ)gRcFUN87e@#C@>B9Tg[NcP[NJY
C_WQE?e\9LJ&Od=6BfQg1\C&=FX7]&Gc3f?Scg9KQ@61E[Z)I\OW6LQJRW#Q=:dU
F5;_dNAaP7[7N8N^IK),GCRP:)+Z@d.Q+L@c[5ORF#H@>N2H69>T.1CE6e/,IU-:
\c,/f07P2M/B#7Qe#eBECPFTFW^5C5SOf9N4a^4-<T:\g4T6Qe1fSH;afK-M.+:5
Q+OU^,H-b8>)@C;J>HY[7BJ+>1MNZ<8(K?,27-a3UN)=Q3cCV_;e>P]06O_U2L_>
IGU#LLJB7@g;]NYBVGNQJ#G+N)\9<#SS>R82,O;MG@gZV4-Y2>1B]3<;3T?-SDL<
,9)Hf#:Ra)^e8R:a,HdEPfTSPfZPB7TH&WG#8-ISRV[<(0b^)?.QUcGQU:44EI6c
X90H53b3K+WHLD7XF]\A43)QF/B@N4KM4CN]HUa#YPg<#a]MH9-0P.1KI[\(<S@8
Z..:-6IS#KF/<&)K:G-aN3ebQ(g6Z2->T9=.6O,7JIK=ET/CK,4/0LR<[(T9<D/4
D?LL8>-YD#YdC8b5ZF/+OTBcL:b]a84Z/^S]^[NB#88IA1gM@?M7D><Q2SZ&f[>;
8HWa(8@L8SL2Qc]^>LCb<O&7IRdMKP)PE_21O)e];IPX5C@PX&)&8TW:S8HSBCd7
L^g(ZJfV&EEfbHW7E9FH#PB0;6CIU+@V<QLLJYDI:NK=\P/185)0a>01R2+I56[H
)BQSdG;ZYa9ObM(-^EJ:,:G,_65?Kd18CW.9^>.QdN[S;aV4E:5D+H@/-&/J@7,O
9&e=/<;D2Ya=Cc_<#-BU4K-ZI-QE;dK@Q.;)U+D7>aQ08RH#9^8U//\#(#d_FIQG
B;LW77g08VOTBLc5]@O(Abg+2(;LdPUX3GAL9LTU3A5/YI7OgY3L^+Jc@=bA62@)
-OC&<fMbZPA^UT((9&U5,=0)9T7VHJV1Ig<0aJ:YL#8Af#:B6XU6E1B[XQVC)#NH
WWE#WLfZa5D(WL=&#g-WO614P7AVP#&L;g),+0a?gd,(FLL\:QCBB7Q,#;U#PS<K
Y.17L9fW1GUc6=>/CYL8N)=H\S3\L72:UJA6CG,]MP0A8<HgC6bH0gT8A4L.HNa;
^.UFK+EHF?1RePD2b(cd??/]>)X,ERK_7F<<W?^(AETb1=[N3Jb+Z^<).#+e7^:3
bc,.F7TPaBF)dPc_PKH2W+\d(@.K;CN#(Qd#P#+_?&dX;FYT3(/gCS.=LZN?\d[3
XR3X].IL-ZfWIIOGWOgQZg:McR/J\:JH?U-@aATYRZ_-#,(A=Wc1De;;^+<U<:&4
V]JPf;PK6WLPE7EdXLUYCZ^/afT(d8\-:f\-fc5.Wb[4dQNfGbfW4[RA2KFQ#R^A
3>?.I9V>.LQAbB4=.9^WaC^7Z;(.LW0P+baJRQ603bUag(4.g?Q6U\]]cJCdQ(c0
e>[M=UM\@<_&X\2[/LYX]X.d@e2\=ET4E_CE0W8DAOXM&/6>Z810\1S,[HIePA/M
98>eK&[F&7\BSDUOQ2LOFBXX\)a[Be4\^0?+]AH_Xe]gFc4M#FH+J/9GVA;SLb,W
_+[:FSH\W@.1gN>0BW:@bSYG5=MeMZ0#Q?+41Y9gDSO8A5e@C#XR@d)_TT<LY21P
+?+;4Y21,;[EE=;R-A<@.CO\LCbMVPZJ^F(HM(9Sb[MQ975FDPMMF.TNcX,Hb>+L
7LP<QZObZS5fZR@RTQdLALM-)Z.;MH[:A[1.0BY_;.a7R[)-E<[66d3Z#Reee.4Z
+.XWE;AQ(<+B=-VHTHIPL6#<#\aM,6(gUJ2LJX8+PDB21TH47--c7T<g57_d6>aa
([X4D-SfP6XA(@e84bXcBgOHT9f6d?(_[A55:(,DB1THR;F+L;T(24[1K,C\;JU.
ZE^?X(M6[PWZJ[/(:Z^JPE1X(dbdBa[Bc21KAE(WPM?a^I4&5IdHV7Y#KW8+a#XP
LG6+N&6ST_,,QE_BI7SHMO34MUf1WE<cg\:#2>5:AR+4?9Z7.2)5eBMN6+C?7^X+
12;)Xd;(BF:8WADJ3HP]Mb_7WPX1_J->6M,H9:AC()L9FcH.Y5(^^VK7A.c7)623
NESPQ_>+d=VX+.)6&=<12,dIOY;c:\bG+aY8O3[3f5BYUQ]>3J08b\Q:NI1E1]Wd
1ANSb-^cTW1;H4S98TW?a^eRH&O2WA>8JC,^JZGN?dL[eQcg79PLFG(\&Z@S=Tbb
MUJ(0I#6WUAY#2L[VY8U4?__gV:P,A.FIY(L.^-_9Z\FRK=VSd#/e)VeB9J><DO7
#c#RG#)/]]A;FVBO_/5@/fa8DdD0RUSF,\A&9g9=?JS?T>VD.H.M?MBa/9IJ.\6c
R_A/<D)6Pff_TZ\eeFPde/-6V1G;J^>MQ:@U1fO0]f1aLb#^C6\?c.1\9b>AKY6e
ZT]O:8?:?c0<UK/g]C=VcF51^J^2P1P^0.cb+/T7V7LT,UDgFFM/_/V9TZgbJEDY
4e&;R:bgKH\3=&&K:c-8FS:1:g+#AA<4W7)F>7cJ7X78d.GNcg<cf]7Ka>6AH2CT
D6-PRUa6=^]1BgfPVN3S@=@]dW-A#35NF_YX-0g97\V8D$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_ISSI_NONVOLATILE_CONFIGURATION_REGISTER_SV

