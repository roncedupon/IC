
`ifndef GUARD_SVT_SPI_FLASH_ADESTO_NONVOLATILE_CONFIGURATION_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_ADESTO_NONVOLATILE_CONFIGURATION_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP Adesto Nonvolatile configuration register class.
 *  This maintains teh copy of Non Volatile fields that can be stored/reload based
 *  on requirement.
 */
class svt_spi_flash_adesto_nonvolatile_configuration_register extends svt_status;

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** SPI Status Register. */
  bit [1:0] status_register_protect = 2'b01;

  bit sector_protect = 1'b0;

  bit top_bottom = 1'b0;

  bit [3:0] block_protect = 4'b0;

  bit complement_protect = 1'b0;

  bit [3:0] security_register_lock_bits = 1'b1;

  bit quad_enable = 1'b1;

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
  `svt_vmm_data_new(svt_spi_flash_adesto_nonvolatile_configuration_register)
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
  extern function new(string name = "svt_spi_flash_adesto_nonvolatile_configuration_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_adesto_nonvolatile_configuration_register)
  `svt_data_member_end(svt_spi_flash_adesto_nonvolatile_configuration_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_adesto_nonvolatile_configuration_register.
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
  `vmm_typename(svt_spi_flash_adesto_nonvolatile_configuration_register)
  `vmm_class_factory(svt_spi_flash_adesto_nonvolatile_configuration_register)
`endif

  // ---------------------------------------------------------------------------
  /**
   *
   */
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);
endclass

// =============================================================================

`protected
Q#Baa6Z7d/ga.DG8=1DV>OKR7V7gAAP[Yg2P.bEaINf1.?+;?;J_&)5657<Q[cd4
/Z7eO>,Q6fSPR&11D)/.JdW=RIIgMR&:2F=)QM6#^,#U.Ub7=UO5I(g6;.#4&1S5
\;<P56V2+^\7_f=BI#0N59,V?Ve1:9,6GPP3.HWG0A7f;b)=,:^dJ.?C1U5[-4e7
bK+Z\]Y2;3P:?fY<U8A+NfcCO.@-3Pf5\\JQTGb@)=5B,,AQUaTZLg3?a7+8-H_d
EZAQ5:0X4aY1GNLG?GE+O.9@>(XPSAdXXBF:PRW[AA\(.3=Z)4b/CJg-NOOGdN[A
TMZT;Ue?_IHK6X)TZOZ?B)==RTTK<;a2,,I-]Z?JfSMgD#F\aVN>AgHa<)++3X(K
@MKMN2faf4J-3WYZWM142ac2eX+?TPgUNbZVV^P3QI8dUff^2b-F52[;T=7aNL:D
GIZ30Uc&<3[YY00>N7SZ)?;cW>QI05RBQJU-@?L;0UQaM1F;_H#WD_H>IXd__AS4
bb-J8Rcf08Ec:&.XO^:[A<XW:0P0J+QX6)b5R/:g.96W;9WM#;/K)d2I/8(3\DRZ
F)X6g;LW67I:#OJ]D3[H4gY,326a<ZR3?@e_61I><-R:W/-+<R1L\Ed+8g9a>e:P
VS\:F>5?;595^I;Q(.;VAMTN&CW#AHJKTG-L]G9LKfXa+1>O@D0>=H&Z=,29^/c]
Gf]F^XVff&I.Pa\fTPc-OHWA2BE[IEcgSL_6UU]3R&?A>Nb,C5BF2QA>SUFW&GgA
2f73fZ/81cBNa0^c[<c@0M&)bb25Ag/<@$
`endprotected

   
//vcs_vip_protect
`protected
fe[g0C.]]PE5fgaQK#GP#A;65U@f\D@2_ROF<<KBUG6&T3^;/C=05(-eD[eDdC>V
Q,#GN)]d:,?6Q4U.+5;R#+)-IJ3,06ZBd^XC7#0]\Z)/C5?M>\OLPI3YXJH8,77N
&MWE/65]_@SbXaX]P[L[_7)NGJS9-^G:f0./6.7\ZYN1aA^Y2<_W[1E<26G<B^7B
60a9da[+3RJa3=cE>MgGHb,05(/)FfMAR.ZF6<H9SA7A.g\+cJ16L2#L<21P;2Yd
6@a(XX78CAY>]_D>IIS[(,N3Id^@VSL0.E@b6\2)eBXR?0Mb3H@ED)2-(4@&e.AT
(J[ge&V57IXfU?RNNfUDRgYc>#c[f219R?E6#0d#H)WVDV?<LFI7V^I69=ddI#TE
UDb,_#4,+8=33fc+[_Lb?Dgb?1E-X@^[29Z8_#?5/c5+E5a,V@2\DR:;Gb6FAeNZ
Vg4R5Af5_E:TVCO81JgJ2Q,GXc=W,UMN]I&+VY>b]Gb1B(Kd<4Y[OcU+]FM&6:DG
#-,J#?)&KC#WLW.B:8H/:8GFM89-c6Oa+A6C7H,;\J/E_7I9Y?](#IXHfVT;M/Jg
^J.5ScaN/YR.B/2((S?)bRCIb?ZFD3Y&\HG[eDS4YZ:R.SJOG,.)eeY9__;]4?ad
FE,0a_0-H]7=GPI^eTS,OY;:Z;+]eL0=4:?+d(,A2]#]F9f2R6Mf0=N6WP=fC<=a
6A.C^H6-2WUI)egKM3<_Cf7<?-9UF@a>^E)R:7H>LMJ:Tg:b0IMHKeL-,.c@Ncbe
W>c^86,]I)#P4+F_FAY?-Q6D_VA=W02YHT08Y^61=_>:HX;(F]N9=[G1P()5;:KS
OeeOI0g8>GDL8CUTITFd+XM+8I+T/CNY\T3992d#&5/_&QZXWDYTE>_E>YUO]WUV
</\EX5D\O6b^15b(LABHQQ8U@cePMR>@GfG\^@SFJKeKT_X)82Sd#UTbQ+E<4eF/
UT[3>3NY@6>G?Lb02Og)fc13,]=YQ3>RWgE(5ZbgC4:D>RSHR?;C36<VJT3X3K=\
RKPQA7Q&(+FD:K6EAd;[#C8UWHe^Q_43\OO2K9X;^9?M&3CFV)UOg6LR/NZ_9@=0
_.I5X^F>Uc/IH:GGLF.;9eS#fC1O),DS\;[7Gf1[E1+A?346]PMH9S.cJ8#bWf=\
Rf.A4bEQW0A;e?0f,M&5EfAD;411BB,@Q9_E8fEZ_>TZ>S?8SE(a4Y?+N[?VWdB^
>:c^=VFSJ]]7f2Hd4L,>^QT84fd[JF5gWE:2MQ/PAJ#KC#<QV-CFbGXa=,b[f^R6
S3/M/G2JMN+\KcIa4A1aA@D,a3N/D]4UPLJD1Ofd.=aMD&6N/K01&XV[-#;IG]AT
?2\FRC@g=a>QOEP2e=V>4+Z3g]-MRc>L92.Lf?9=7K,.KQHf+1ae?X#8L672Af1(
MY1?aQC,6=+^AZJ8>SJ1)9B]EX\c4:JU,<c_?8N[YC&5:W0<g-cg>_DgJCDB[\g7
g+d;0c8MeK-76bK3O1XDb0F>FD+b&S(GCGDUOXRAT6b\4N0>ZK]WSP5YZCOf;>MD
NN/S4\E4U0LO9\Xa#1_U=R>RKafD2KVGIMgb4M&N09EI4KDEJ,D:bX?L2/U);:?]
GM7&CE<MV9OP<IMDaH))cWeNdE8-fD_4LGA5VAYNK-+I1>Q8<PLD>W6\&@U9WC\4
N:YV@_.?R&(D0eS/84IGOZ/#^g2LD>PQBR@NDUB:aeUWVaa:#d+e5@+AEOK05TeD
JT(RcE^71g/BYB<QcgRNJUPVHN?K]H<G;S)e#TUU\;fc6.Ua6N<L)-gIER9aL:85
B\ZV2[;UU])/MS64UTQKR\>3@aQ2>Lb0@;BfHE2gEgCRIKMT4[Q23QW1+<=1?PbJ
UQ/OHae)L](@/18^6gc8=[&X)?(75g[6/#Nb+6fgdA02UU/0a8Se?E:Ed/MR:ffR
IEf0@9>4QN)YI]TN(/58KYI;I3\Z(OgYI6+CK]1a&MO.BXT:5L),c&O[XTB7CB27
bPE(9[#R[,eC6H3.W(FW=Q/B-R=XZGMcWJZ;>@5;\ZRd6XL:LUKJUU@XZIe<V/TV
82?P(83.NV&(^d,IBe#Ff;RSY89N4RdCXc<<[+a+Tb/TB#Q?f1c9V[-+BMcE]dQM
>\MKEVRF/Gf5gUV2Y6d]T;>D]bB-L24cFR3_GI,A0IZ0/gcRH4LHR<P]MPIXUC,B
K:56c-O^L<a--CD],<Y>X2YeP9#A\S@N>?A<)U19H\:PG(==IZe40-g4]6O9@#-+
Yf&?VQ\#ZNVDa9P#PV\9#(D-)2J3(_MXDX1X@NF-N96IVHNS[T:fD0S(&XVb2B6-
Bg[J:F-HFSZ:Q4]=WH_]X?\VA.0J2.7CI=.HdZTZ&](@g7N\<&-@QX2.Fc?3g/K;
g54EWW?R#JSOMg[>K>F?OJDB/U4EI>MZ<V2^[5V@766c/C?4dG;A=@16-O.c2^b)
#1?e<MeD8#KD1WI49H,a1[4KLR,P>H^0GGQ:0T(9<0I9<+Cb^2V3P[^DWc+R7>NW
XJ9bbYb3a>HXL;H3H5X1)_H4\M<KQ25&7dDaBCNfX?521J9-a)Bb;<NGB.N(_=5Y
cf-e>c?IVBMPNg>e+6BU0N4D7L4db<VMM(b/9f&Y&ACKd,R>b\)gGPcV[b?f,AP:
M_G-V]44C1/>b3XV4Ib,eJI<H&2_=0g6E;643.\QBa/S>c9)W=VdKELXM]F8-/cV
GBRSHN.N&;S;3KMU&:@5[7;LT=&SaTZW5C]6XY[AeQVAS35/\<?^E??21f(C?TF9
6J(&25A3I_?JAXR+]0I+&aZH+.9?3&Q=F_3:L1dDD6(4#g&8=9)#eB/FRY^L0(R8
UdQ.<b,d84QIM#2-,f597WeaV7c0@)bG68>O8Z8PRO+A(Ufa(9P<L,7c]AEJ7,?4
C@/3.+0P0GFK=e8Ad0b^5ZV:91UEaX<4_AV-?fX^<(S\O/7RNZe7./#bNOYU=2,;
TYIFQ8;R-5B5(HF)1/D.c5XSH4.b0a_=:d_gNOBZ?X)5?WGM.TeGY;1WG223PROK
K=Q=9Q9U=X01&C&bZ29,.,6K3@,Sc3eN8#L2BQA3)fEE5;egH-B(7N@_>VeAQPKH
U3;Ve&g46H>SKNNR:aKBM-#DPT+CHgESZf8?#T#N#9=A(9-Q#>1;eH<R&CG+YdS#
Ve.QJ:\-O(2;4U,X>;e3#S^J\_V6Bb@5Dc?abKZASMM8YP1I(ZANg3B=ITF\RJE;
N)#Ea:\V4S[V7N4/];GZZF/R^Q9XDF0:OW7If/McWPQ=<5&E/3RMRT6dDT,S0#DO
^_^F?D7I_5Z[]X\<2@03;aH-AF[PZ#7g;X:0M-5#+]fJfZ:WMBV6-b;D&;,:3_8Y
YgaT31TG]L4=TEO6OY3OK[FX(6BQ=XJ,/I/#K;0.WPUGDSDM;/>SYN8AZ&f&CC]3
.3W,IRbY++N#+M:8[#NDSYI\GSNVDe9T3F02M^CTNOe?81(Q9Nc#=;<6fSe^9Q2U
F5NXd,8L0aY?>1UR#4[M6=:\/Xc<=Y1G9PD)B46MJ5e8950Q,K=?_a3(V39M\A^.
/WF54AIdbI<X;PO++=K9#a>F,YA#Y0/#JDG<2P5d&<6+X(H]4NVV;b0TPgZ.:+)K
_.A]aP_[@G??::0/;6-RC9<D@dbMdCe),=V./eeW.T;AYPGA0I)D)SaHH68W5&F3
8B0QGNN38+#<M.X+f3\N_#gSCIT;Kb]E?7LebaH)g;f&R0>5+;8/89RU#bW>YI/#
2#ELG<I-<F[bWV\a3=)g1^]/QA7Y:ccGb7Jc^E5K&4F&fPS1Z-eUSWE3HWS&cUOa
bONBR<(JWH5=>X&5=-=-PEJ<#G-(XR@L2DffD4JO,+-/5K?6T/MS0<_e)Y-98,)[
QKEgDTC\A)\9AW,bF)9P^GO12BYTQ,;KS7TgMTg;4^bf[VK#/f[AL-][ZATPR3<P
5W,I#e<VRd&.BH>>?21]+<bZI)F23c-fK<.(&YIgAS.U_@b_+>^4+YbWe(3=9eg^
eWb^WgB8&RU5O8Y/Qe9Db>YYKSfY45aCSQ\K;MDNSZcL,9A;&@F=(_agJ>MJV?-\
PS+M1g>G;US:N1@>5Tg\:(OD:CJb)KbcS5P0BFT@:.QPF&:LU\6^SE73I;4G8]V_
Igd,D>BT]UNf[a=8OUGNJaRbB+YZCO+;DTMRaRD9&&Z+TCAT5AOb0I+,TKFdT5;]
>2)<3EV4EY]1(#DM3B8/f1?HdI7<a@975L:6;1A5):gW=>,cNFT3.7KCO-#B[CC=
5C6Sg/KaZZBd=)8/2[V6aTOOOedBb^b@5G6]3aZPQZJ.9/,\5JWc.=4fWKMGGJbg
baJUP-MHS))T&4;aFP<>cEf,RZR<TA+C8gAH,5G8D>;;:HaVB#eIdB7@a9T6>^K+
#FI<c?KT4G3W#1LM;Kg(\2+KH_W4T7eT0/.EI2;&E6D+fSG(303b4SVR^b@;D\4S
b_V9U(IS<f\afBPUWSd>G^Ig^3?aET#>&?D84H4NF]#R]OJ>a:MHIgOZ/@)^B?Lg
)SP^>UPM&RaIBgAS8,0[E\.H&PTCOIfEdS#-dB\AXJ[.#A<9XG/@-FJ=179Cc2:A
#YXU]2_)56cR9.7+>;gENOXV25?;bD;U:OH8b9B27VJ93/K+:VGB?GR;R[1<T7V-
e?ZHL4#a]d?A<VaRJ3@Q<(/@K[/K.KB8_T;9SAOZg];a8aMXF&:FG+fI+=:7eEc&
BTZQ_K<A11,ME8.8eMXP_^N&gY?LG2\-;:Hg97BXA=W4a7==HIEbb>E97.K)VIBP
K2386?E[87S)]X1b)^-TEb0(:P9CY:L#ZAPb(LL3-gA;>2,T1dWNMU?OZKZ:V;O?
(#9:Q/bWT-V/_)c=e6XfDYXWf-6.fD+d(#f9C/9T+>W@.B-NDZKVJ.2+RG3I/O;B
,6b#HI?6M1Q<g79g)S/Y\R?.)RBORUb1QecQT:<3cAcE+N7LWcF_)7I5P?_/eH8@
7.IP\G;Y,IQG\XHMVTO>MCc5QGQfT0Z2Q=_=OcIHQ?+\ZDO&^\TD48&6g6;9];1N
9F,+ON_W#+-a&[W-[-N#(E[IfYb[fQ&d<GZ@NAL8@cLM;50>1LJO-PCS;U/3XW8G
\)bLcAI=PW_\NbJ0@]DT?D-A;]J47d-RgW86b(&D@bG8.SO>+&D]6]0G+2BCX3_T
7a,;CR#5;M6gWJgZMD?GZVTC.BJ3a44\WPS[4Y_4)4Q=S-KQ?W,WHD)B[bg(FcV\
Ug[bZ(OUF@6+PRUO,G4Y;#@Y]XCI39][M#a\6QdN_)=OAIH1DTJT,M19O_,[EUS9
36NA\R+E=cQ[FLF]PR/7dR96B:9XACFJ?aVB52>=:S@f_G]QTaYDR;>MV@8+T?=R
.e3+(AA2\cV-B23381a-aZ9HT4?c#2abWTT2dDC@#&7f+OVV>.;>OX>)P\[2If2P
66GLJ>)_^/S;1f1F67PYc#P.:c@2Ufeb@;R:BR^4efU#&f7&J1U3K<eBBfT#?9&#
W5\\>gE@E.5gV0aFR:VJD(d4QRb/RRP9]&Z/^V:?e8eRKOZf;C&Z<b#(N1YUPDXg
7>_gbN5XYQ3LS,geM#3aB<62X]9VP6:1HPQO_:HMJD_\6FOa,<BY:f9eD2B=OV3X
:_f,R5a6ESV.V0)3/^ADJ4F]&3EYHMd,W:dQOBYHT-2US>DVeLBR[E=KEV-RcLNX
Y:=<Z7A[3g1_TLIa&6?.5TQC+XJ\b;<._?+3dSe_\</VLfQ34MREIbeI5Gd(@W>.
(NS9LNS/OQ=CB5RZeUT&gA-L]^C+8T-&WOONOU#F0b8b;>U/M?,K=YR+OB:E+K&0
:U]5XWGVNg63LP7H\_/.7gd0EL^gC:7XJA]cW9E0c+?BA?:7HaW/.,bAU1eW(H;c
4UU<5S7<E#7;[QX)(^b(+#gU^b3<XV:M2[F\g,-9eWW=K[bITT2GB/=fD6XJaYSU
=4NH_fF<XCbK59;Q\6<Y\WAUb7M@MJ))DQbO8:_#cUK.Ab;2)Ra+</K.c&OB2FGI
M3Rg/V>1]M&be+M4\P+Q_U/>E0,bR?D+bIJUM;e]5F..[8M[XOMCP3Eg6B/_OVG3
d.49<K<aIJ=LA\&9fcQ;Z58[R?]Sa#@Tc],4+0O?Rc=Ube@=0Z;))@5[24G#L17W
bC<)4(gUHSA26IVgO&Bd5C.E[eT\T1H]dS;0.?OM8Ra:1K[fCO_Y=3IWKZ@;SgZ8
KS/g5c18bO]b<a))gP-EK7\]?XP\ae#Q4gNP(TGZCRK[P@.D<_aa.8d3=C7E1<fM
cIdgCc.70.K@SMS8Z+OW3,9UK-;TVXO2Bd<?dg@0VDJ@0+Wc>FGR7TR4)\3HLS-(
Z>a/-BgNRB-0KW3dEdJRW#C(:Ge0/.1PH>UQOff:#YVYEQAP5QZPB2BfWQ#]DNVB
b9.]V-2f7>BQ&3ILIcATPH&8(+>NB??)UF;De,Y[6PMRf=aST&F75b;Ncbc;-8cc
Ga>^@.J>6]A[J=(?F7^EYSMI=dDU\Oc@V5>CUcJfU\O-D&XST?7O@Q@GZ3&G#0ME
8_[-M7OYMCOCf82\F^+:1[gV.+.=[8g0E]L[29-#L6EC>MCI64[Qd@1L)US.>Q,8
WO_XU&U4BQ9A/RR5)bYC8=3U9@ABRSWB^#.(6K+><:/NS\D#gGW_C\EeeQb\2VBB
CK?b.9c^RA4gX-(Y_\.S4G;,#c+E2&e)c=cdH61eZ3XSWBe;FLTb9I8XJEJG2\,e
OX\-SQ;<9?<Qc\)C^]IK&K3>#dZg:TUG<O^RF+1VI_M.adDed5)+De4ZYO(f=d\c
E9Wd0R>VQeV(a(/8G+2[LJ?AA0(4N2KR+(f&X:S^fA0JW8G+IP39_P_^:/28_9F7
-SA_b>NTd7f\H=&9cWP<aRV9Ag5]2EW[792O<66,]#d_;IY4OGgLf-_ZH9Q7&C9?
.;c,-f^,)D/2g6,CZ1LX+Q=ZORA5ZFeDZ1Pc7L#89+;g,SK49<b_FPXdPc37a.e\
)2S,IC(=f6):]aLX_b_2\c@>C7D^@JM+>_\CH2:B#[/:2d]2Ab//c_Cd04Hg)aKE
WBg^eOUG4<VP.DT:WTd7,X5,#.9WH?;E1d2I^1K2X0F_5T.dUg3@[MLfSMd-Z<J6
+MK;R[?HFfN^]W\HPQ]d[MP=Z)/GZE4gfAaL-,L8IW3DM].Ec+4?EMc/G?D3a@&_
J4WdW\SHUP>/gUO[9MbAR,dc_)8K&:L:I\+c?\H^[1K10>6+LX/cPFXgA=<WWCD.
Fa\XQ\5G=a2&^4ISP;[_+-7Z];^@c)_.#X8FN8F)_3R=(GRTga4-QD/36VE:O9AJ
)@=C;^9<WA(f5\+P9++@4W?g+7SB.agf#B92IJCNH]D9,1S;Y(T=-;<MM@P+14_)
b-eb#PD:35<ZMKX-RJ96E#[XSMaOJ(]OdN2[f]0^Fe)DO3NHX;G9_aL192X6F,^O
OZ>OXBM?6D)UQ<Dc&+;TbKd#NB5cR8;gMI^#4L,VWaF-,T6EQ@-1M:H@R][Zge\4
XcHd#_eWZ\3C(UZ:;BEYS=X(dRV4)f=^U[T7Z_5c-acHd=\KW=O>[C#^Z+g2F@+N
#XeY2bd642]Hg3(K4XTb55A9BVWTF]/e\^)@^BO[g4W2-9K^_0LFfFP[=9I:L\T7
7Z)=/9dL.ca/3EQJ.K-ecP\eK6JUC)\&PDY=PO7SW)E+)gW98d_6?WUO(bZ^,G<g
T5,CEF,89POe:8GeHZg]42P;X38&0&]:?OV3g>a0Vg.Y)M<OFM]]b=#I5LWd>W(V
C\TI>B=WD#JU9P(H2D@GPfF8JAGD+M_7:>AX6.]d<]=9fO5ad83Q^O8/a#71@GKM
B03559<B:V&0ZR>4KKN+4dST)cZ=#+K(<:31&&Gb0cNHB&g_cDN.\^8f7EBKLJP0
d1QXC0VGB?17HSeS[DPFG0#<KB.=,QK&5.Of.WD9I#aVf>@L[3&G7B\HVA(WVW0C
:SVaOBeH@D>=g9&MJT/cJ/;FMD2?6RJIbB,)..Lg@6;(]AGOHbUOa+K]Y]V1dYXN
1(?@F:9N+LM;:GLXU;Pe8BcAWM<P5:IF=#&\TdLI_I2eY.Q<#2:@f+\;TY8/V]U6
N<1+CYXP18UUTYYBTM:;2V>)#d/4XV8d^,MX48,9DM;<.3Z@XV_LN4K4d_43\2.;
aD.NAP^O1G</JE=,(dRK9g.U>3(DW)]@3T4OVNX3E2be_79QWIOg4(<d5+YZ(\aG
gP,fJLde0^<U10A?X04J39[.-N7bW][/&acFPJ;&]G2/#3<S4TBEfM#5P&+-3V)U
1<T8UB=YK?94?:-F3L6dW73KETdVK@FVdSg5^_W4=J#b8d7dV]HYL<?8X4<RURT<
YRI<[=agEE8CM[e7NPF(^JQ?35WNWfc7[>L^]f8&?V?9:-dV4OW)/YSPLVV&+7UM
KLf8H.HZN0BVM=RL(+:^_H)Ka,+-G8R8EBbA/JH,5S8TN[J&>E5LXQ@OPbND8FB#
^8H/T+a1cUYX-=V7a?Z+(7YOIOc/YW[6NYb2S46=-CB8ecL+]YQ1Ce+EN-1\6-+M
B5A8W6N84=9UK3M?c+>)J+OB7:/W/=AV_>&/<PIaG-TE/LTWV/9_Na?#V@+dgPI7
Z)LGZ,L6VB,?F/EOK/A6?MRRL1ZM:+&>g6+[T]NQ/P&SEEQW/aM/=@1&1:Ka+/G.
R;XXVM@7?(PUN_bI-O_HTg\cabUbE&Y?G,WM2\D^^Z;HRM5UPa3cG3eY\_1X8_3a
EEX/c:UG(ed:>d738DB:ZOV2KN@:LLW7..aOK:8=?2(f:C?=[De4;RE[dGa?7)O:
&dKW)[1=KI]2=BZ)G4)4-MeJQO/IE-Ab2:Z)SVdW7,;b9&4EQ\A_?+(:#IWKUZ)[
J<1H_a-JT5@&]+X0P^T5@SV+E3&IWCHP0=_Y@1T_-C,f0Lb4R6M(4_FBI#f8MAF&
Ef>IV9;AWMEeMfWe+=6S\:68-N6DXU2NV<F_,eb+/SeD9e<e,L+FG-USdD,g)e9^
S&W\MALfgL&g\4feF>,X8&X82C4]5g]0P6C\W,3-\/&#g:BO2I@?dRFL<&&=A:(K
BE2/f\I>FQI<CT3-?7G)[AHP_1GEE&H^>CGBf:=a5W=ALAQYPBYO_Df-5JG1<B\<
JgNA+d@)#HI;].#f3HA>[JeAV1A9S0KOb75:6YE2+AU.R3:B9_U877@,&]?62&W8
=.<OLRD6UT8@9bcNHSN11;#X[M.Y=Z>=#Q]65>;e3FbT8.Ac)9&;a-W>[;IT_6MA
Og]f1P0+:?H>01dO]RQ#T+O[,8.?704@)/;f^YPAZ4d9GbUa#6MFUM<0@;Q[G<1?
F4f7T@4[0EZ</N0<I4GJZN-)ZH5&B)EFKC9.\K6#ANQ=P2;E]ZQHRZ5COI?dGHdG
Ka.LVQIWc0T/e4dIEaO+W=S#I&<4gNRR#1O(9#)AQ@[+..LBf<[>3\P&,1.<8]G7
:BB8EOc>)G/IF\T?cK&61.@=S3;KIH]b:/.W.E<XJZ]WFEY)TG=2LE+AVAL,4;ca
Bd][aAZ#5W=aTWU)GNB\Pa)AR@1ET=7+U4eVP8]\.QFE7cc=-A#S#\3a(Q.043D_
[/1Cf8\N/I]1&?c8RJ][QC9#W6&HdPAFL?Vc7F_QK<E8EcL0fA(,^FVLYQQO]&/]
]#^/>DX;?e\W(#d7+^/>S-#8KgJ,71M,a;Qc?Y:\<96O[^a5dbf/5MCdMD.G\KgC
JFgg)fFb8))LGSV\c^O1:acTBU1>QF;ZEa(3[D8aa:L<US4_8X9/VFL=3^J>_;,S
_:4HgGA/N^fT@Y=,=B4R#C#LT;;e?FZZbMB621K@?d-UZNL<cZBGED&\BKYagN/&
N>f(Q#&C2L@98J7b^SKKKU1d+^9Q:A5]EA/?4SC:XT/J7#),:UE/IdEcSJQPOV6[
Yg#XZ?cEYQMAgI?8\,c<&)R,+J(P)XT32c&bf)=J@].-T9KTF52-a?QI;GBSX:FC
F1,e</,17L_Ib.PRS[O56[9QIGC6^S.PO0#W?\#fIAUd?YV:ON=\E]\[J6_KcSJ,
])bI0KWAWfKdd93NRcEU]M^Z9EH9W)XX/[H.H5;URU^;L^YGGRJTU[@g6Q+Cf>FS
3##ETXJH.c>fZ3)E;F6B.87_@]].?A+__8?>8W<.T?#a?ddE^4@I\)\#DN0CZ[d^
Ge&b[OJ^B_]a#<<:&;PS2I=MCAR(#eJ#TVJWQHSW2@a)GMF#M=2c[[5BR0,^AUE]
7KL@JK=8Z,<ABS[e4\>E5/[dG;0_OAK7[YI]R8+RD-F3eIY>W_b#N.WN-8eOb>E=
U?AL76a2\J/8:48VfE>R^W<JB&2E?bB/699B7[:T)I_?3;]7#^2;+-J+.(NONY:6
>:/JT,+I]2V0P7Ke8G2aM(OF^c4P50a5Kd,N+/\=T/^Pc(NP(K@T=H4_fIAeT2RP
HP3Hf],?896\SJK7Scc:FX-6?b^P/^&N2JY54_1gU4=K&I^_K1LXKV4aGd>UF]-c
4W1G(QZC;69+f[gZcWga471VA\Lb+C/[#@M>P?NOdV-_&O?7Bf(f5[J\TMG0B+[5
CJH1.:;FZ3GM_GCE_+F^BbbJ#ZE11gJMO7DB1c=1FUb#+/Z-K<Qbe;2D:]bD5KT<
?MY:IJTJ9A4.2E:aF):A(A0V<bQeYYbb#@+fG>?1^=KAcI7OIPB4YOMdbX]142/G
DO&@YG]6BBGaKAcDc<V=b>RFM>S-5&5ZUV@KaC3,04Nc;12TV^Z)aZegJfSPTPQ>
M1M?[R[QCbJaN81gVS5Q/KJ3LREC:V9fE-N?,F;X-H#G^&a>Tf:9.d7(;-b^+8NB
Ee]YRO+.eAfXNMUN:cL13VCF@@Z^)CgZ3PZIa2]Z+2QTWFbK54J,4?AQPTG>gVMg
[7fC3f)-[dAP=Q.Kc@H^QEg?#fKTa(S&_9>#IW+EZID?5([5J8dJfI,K]<FG]0<c
dPOf/@IYfeeK]3/fU9CQ1Qfc)HLR?DCPE#CPZR;6Jf4^3cH1A#Z>c5Q794NWZANR
G2:H/T\MB/I_Y&YfVWSXTNbe]5OICc,GB@D@4@#V)F]c2/G&O0V<IMH#P>EHZ\Y]
KL0&CNG8CS&M[L?A0#@_,::ccA:3Og>74#5M=Ag_c#Lf#XeRMd&]Q,,FIYUPE;ZM
UZbIKO3R/f3eXK)7]?GQ<d5Z3c]N+.CW\=TV;_40Q<D@0WD.8.\+.+R-&?6SGf&4
=83DU2S?N+L@@9;&6d.S:cH(5XWA)<C0P8E82,3<CHTE;7Pb)LaD8S4L]Q]OW2(T
cT_>N,fX/UYZ3:>6-VU>C>49^;J+\_2B(Z@CcUA7UEe-5K<Y3ZE;2R_;c8JTX/8.
0cK_234(@:9GbH1:#MQ(9NIYGCI@@6Pb5B,5)C&M4MH6=1U77EY@/cU0BNT8If_E
64(e7CdLX.(QfR#=,TCXY;]:L4e@VH-OLQ]1Pa=d=QM8&aM])R8S8aHYe)_I>(>3
B<UdC#;CU(O]OKTC290)F#V;4^ITTE7A^bJ;C5AD\(BJ70I+XcBJa=@C#X)YG&Gb
WT>@D=,4(3L@KV3OMA?K&POBQ(8c(K[R[S>UN.ZM3;bH#.aYd.8S<3DV5Z:3H]c]
D_.C,cM1&N3+b+DE>654.CG#O+HB:#-E7?S^ZFK=(CJ-;(J)2=c+13X_TBB^\gG?
aI1V[fbX2,XSE];2H]+b)TS7@+=3>Jd9d0KAXHCb^;IB[]=gRgJ\KMEf406<UKcT
V:5;<3Rb,E,5PJ#g>KOJgP_Q:F46DdZe5d0/>QERcVN3_G4^SVA9)?c/KH9HG5TL
GN<1Dc;08F6cYb:c+=G,aI(Q9:G?&Xd8FE76H\1+P:PfB9X2aR(TfV(QIgCcg5a[
:fCNfbe&YS=IY05eUL1P>cL&Kc85:<@3>=Q>JZg>NPEgWEX1,O4_fH[RVN8eQAfL
;fT;WgZX[4/BLR;PVR=O266NBX;B.1Q=a8fD?:1H66eUMY#1,0V\0.(P)FK7FY1C
(+g1#S65CME0fZ@HBQD>RB/KF^Yc@?.^_Z[E6:2F2<W1QDD\+Eg(O^fb-+dY1>>2
T22E=F0ZS-65I[KHga/7)US)T8>XRT49_KL;CPa7R#)bX5-0>f:?UEdK6c-WTFPD
)LIe.JFZJAa/T8YB6OFRF4?W)WT_^K02GP67F75_A#K[,N#fD?@[\ERKO<RBeE-V
JB_bYZUDfKG9M+7\<:2SaC3\&=FP6GQDC?5V]gBXXfZSc9?.U3GD?:WECXWJ\K+5
.6.V_,+_=3?aJ4J;WGLCEBY/)]MM.@Y1OeaS?B:I9VT64?g4QOH2B7[;ZSILKbW(
F<X5&19=A/5U];XeY/)?)<b@2G[?7cR=@aINfe0BV?>a6=:f&63E>gX^GAQEW9+f
D^<K.fPV5<4&(5]^[EeC(d2#LAQeg(WX/RcAO9BGH#J?&UWWOER6F>_7KK42CQY5
6,ee6[+<[#BN;^Z:<V=(THV8+fHH^e(c_4G@9cL6FBH5V)[I&Mg:/:6KPRJQ@Dc_
4PW;d<##@JY>VP:Fg-LV?)MQG?4:@Q)+(0M@>#_F3/3H//(I(HDM9P\,XTd9_<,0
fb>L(#eTD,/eSPN,<RAFaB+UdHN9V6:edF-KQG&LS<YU3?M-5f+Zf[8#UG2T&H3K
SHE26:2[E=?&1(O+Jg_KY),-Q&cb47P.?T8XRKgBHLRN04==XQOP]QVgDJG56[)S
>7bCLX\E)a4<G?;^=53RbgFK7[(9b.2bH?I=+?4YE?)0DA8H]B6H\_OcMCVOYHB0
.>7Y0#\VD/J9f7Q3@]U_\c#/ML9SJ,cL_PVO\&[&2O<_ZF==Q4F]W>IC6EgdN[fI
#LQ#YZD-A(#FC.UT,b3AM#1bBC\>8Q[)R?_<-BR4+WDBQM23/agWLXU&T&@;-T44
83?W]DGNQ[b&TT2.])SEUC4W86\7a:^E0O6(2+(e[848=WNA_@U\?1&@,E#ZD]^A
^JMYYg_N[1?L)-4D7:1d&C:N,c<UOJ.J\^AI^.LVdOC:<F-RSCHaDIX)BTQ<#J6N
[>3.,+Mc;++()b:1<>c-,?/>Q-2:2Za2S+U]fM)U64;-\ZF&Ed0(Q[VdI#UJd<74
PaN8-W70G.Y?_Sd/49H/g.cK=YJ5TdE6cFJ3\_SY[.DfU5XXeFFGXPF#T0ZF75&&
g=>D\8=MN@6RP^2e3,RZa6BeJPY\41\9YR4S81FcR.eCJQ_P+<6+>X:Q-eMLN&(@
+f1=LYH=-OLG9]YL+e2\9_bFSQe_PPBLUKY0UD<.egS(_,_^8A\(DQARf=\e^?;-
7ag;35MHK-L;9+2^+>Xd/8a8QaI/dR,JM4,d=>7I,Wg-Jc812MfQb@f)2&JYe0e9
][(SEZ=:<&BV<)1VdMZ8e#4RA(5#TO_V+C#.f>UgVabLbFM<1,&eC^P1bbfV02cT
8TM.;;eYR,E/a9d@4DA]3EI+SG7)J9M1/+P&AAeU]--O^-7.Wf;S_7_0^Cg2f24I
1FIH::M:RbF)PfOCR,bYQ&8E2_3@W(=CfP4ZI;9D]KWUZK-:OML\.[R;?EUQ&>TZ
Sa?0Kg4FU#fgEN>)-FaYW]]#354@#_bS^.WEA)KeGf>^;,(;@RB;P&62,&6OPY&>
0-@)0-7Y)2>WLH:8Y#?3Sd2.YB63451.[:3LXP9I711U_bV[,)dRO0^RHa3UU[cM
?eLc15>A+UXD#7a?c58]\9L\<VA>2\fDXD@)S^KSCbA9?88HM)]TEU0WGHR=cH5D
HKIUL,Me.:^-VH?GN&Z0O_FPSf,J+3)[+Qc3FC=?gcAZS-8?8AX)#<OQ@CE&aY#Z
\09J5gKJ<=01F6@5gI;DD=WX_CT<L0BE6WKM1\)b=8e[T7d9(\XPJ<0JE-PDTR\D
X55M8?O5G>G7c#9PAf.BPQ/\,RaEO,K2<3AE,b@8X>)P[98]:^Z?,ZcT:@&S&W_L
:TdEHVceU8f5gWdSKC+f4&9A&W@J(U/]bf9dQS:PX(/J[[bd&(RFV?2HX-:ZG#51
CJ:G4\TSH9JW1D.CJ1)a^M)fg&.3[f2V5#_]-)<V)2HQgP0^dR>D;70:^OfD06W;
#O0(E44d.?7N(DV@f46b.90JB7P<e4#BF)BW/R6DMfSJAdRgB.D83-SYcW-&2/\R
a@LUg_(<6?cV1>4I\)_0GbG6];.JTEgfK#G:C8T3ZE@X3)9O\WZ5@f7aL)b:Y;A=
@)=-FI+0/;C:4HE:,f)T)>F&SM@J1=U)B^[0-PM9+K@,(;3#4#.06<H)3W_FT0K1
)44MS=6GT0?F+eS<:>WO+g<E<#P68e_TK&@&M4gP8aYFR/b7[@JK6TF@YH<]2[Ud
&DD+^,6aKc@AYM]/bcS0.@2XJWJ&GYJ[27YW-Kf<XAAVGAR=NY\>V[RYK\_8b]S1
Ddb>PBG0CZO[GQTJ;GW>]+5T0I[BIa&)=ZQ_Ag0=C^C.1]EK[=+3eF:aZ2XYNAb.
&&W\<dN/AC:FMXY0#=R[+\4f]R+gQ>\Ff4UONYcHN0;7GW1@<Y)OV(aN\B)U]X>K
.)^)?_/1,5,cVcRDAQHg+E;\.a5@.1YX1)gFTG&E#2K7].3Q[S##Q90F&.4]Ng4/
.ba^b_:Hb\MbZ3cfCJNV\5D^O-X_=_.e9Z2UD-#7L(+OCB4UaJ-40Y50egca5UgC
4AQ\H+S<J5afZaBeQe(?eU&J08B\I9@0LCX4S@g)O)#[OVc-FAD=+D7_)OU:KA&[
f@O]0S;I+[Z#3U,O0#F=Z^L\<S^a&Y_,Q<O=O=RTA6Ue]W5bL?aF1KP_47G[9JT<
;JW[f_=f1f/WgEJ?LJC]WO^9TDO6eGR.I&.VM^^?Eef4@)b+0d+cZ/O28S;\UKW=
b]dYfI7C4&dYR2f-,&SgPB^\QTf<MP0eJ>[=(;764O7b[#VPX7V,.G54:A@DM>;CR$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_ADESTO_NONVOLATILE_CONFIGURATION_REGISTER_SV

