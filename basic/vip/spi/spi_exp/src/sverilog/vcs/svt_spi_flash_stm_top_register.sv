
`ifndef GUARD_SVT_SPI_FLASH_STM_TOP_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_STM_TOP_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP STM top register class.
 */
class svt_spi_flash_stm_top_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** SPI Status Register. */

  /** Used for enabling the function of Write Protect Pin (W#).*/
  bit status_write_disable = 1'b0;

  /**  
   * Defines memory to be software protected against PROGRAM operations. When one or <br/>
   * more block protect bits is set to 1, a designated memory <br/>
   * area is protected from PROGRAM operations.
   */
  bit [1:0] block_protect = 2'b0;

  /**  
   * Write Enable Latch indicates if the device is Write Enabled. <br/> 
   * This bit defaults to ‘0’ (disabled) on power-up. <br/>
   * 1 : Write Enabled   <br/>
   * 0 : Write Disabled
   */
  bit write_enable_latch = 1'b0;

  /**  
   * Indicates the ready status of device to perform a memory access. <br/>
   * This bit is set to ‘1’ by the device while a STORE or Software RECALL cycle is in progress.
   */
  bit write_in_progress = 1'b0;  

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
  `svt_vmm_data_new(svt_spi_flash_stm_top_register)
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
  extern function new(string name = "svt_spi_flash_stm_top_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_stm_top_register)
  `svt_data_member_end(svt_spi_flash_stm_top_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_stm_top_register.
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
  `vmm_typename(svt_spi_flash_stm_top_register)
  `vmm_class_factory(svt_spi_flash_stm_top_register)
`endif

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_stm_status_register();

  // ---------------------------------------------------------------------------
  /** This method retrieves the value of a single named property of a data class */
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of a single named property of a data class */
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Status Register */
  extern virtual function void set_stm_status_register( bit [7:0] reg_val);
endclass

// =============================================================================

`protected
b+FQKF&FF+@aJ/g3<94\>D\RBdf7^\gQBgBVTYFYVO;XT(0)6DbV2)CeD9S2W-/d
a.AfRJ4H;7N51JMRN1<FYde.2g8K9\.A=N+\OB=-?JIGZVO?9[?bN>=>?,C#+DP4
29DQfDNM@(A>#O&HT+K<3]Z7U]J5=XC4dEZ8L?D:.&;aff[U0)B,eGF_H?H6J/6S
U.7I41:E93;F?LVSE/5Lb-5)-K+;W_E,@E5@A2G]A-Za[1MSeb.,Y^>UAA@bKA]W
+OCbA^]ab9XDNG8#]NQ6NN\@:8SOTG;05J=BXdNgGY@]#WdN.VNObV@AXJ-?+cGJ
X;f4A.;Y8/e?=(W@@YL6Q?@L_fB[@23:T8O)@Xb-J=WMI)^X2Vab]gb[P?4ALg,D
XDVd],YH),a#IG_/,@PHSD/AZ^Q4@;][PcS5K&(TQ+142g;Yd-dG&E/=2(+I^Z:X
dZbJSI&B:C;J]E60@baU\+5JXcNAT^=)4gbGP&YSeIQ(75]d)>/5KL6_X4E00T82
MX@]GQP2UKMCYg8eD1T,SC9GH;e\aU/(Oa#@fGTB@O=S99_a:Qa5TaR#=E\+d_e7
;REC^bD;E56]KcgKFaC>AR@N#])&Y?&R4/I9=]6XaHK-I#0NSKPE8Q\>MQ)>_gV]
NEeO_&)D<P,@6/YNYI,X-N55[1<WF[:R<$
`endprotected

   
//vcs_vip_protect
`protected
-+BK)4cU[]1:.;NX;,6&KUI^(#V3N^\MF\-9gd1@Z#]>^.=2P5ID)(TUGUWa(XDC
E>+/AcN0^.g8Y?1DV(cIY\M:@\XAQK2KceafVIbZa\Sg9.7GbGI+W;:A;b4#)5IS
9#,c7ScABD<e,D4+JB@)U.)[92K0abgZQGX6BT6b;+MBV1b:;30O+77L>_8MaO-7
+4-UJ_Jf>L(QX)gdb@GC#(c,g]-&LY1E8T2KP/eS-=3AVF5Bf]TXCDE5>X25JeZ\
]<g7UddOf=g>d(^[FT6UE4aaOYc@.UXY\1WMV_17FYTg-W_,8@R?BVI8#FBZS(a[
c>1WKLH<4R+dU7F7EUZLE[U(Dbc]1?DQ1I,g_1MXYD9W&Z3,)MH?N(/3)49?aZ7D
cB\AT@#O\\&V+-+A3\PGM<5cXT-O:U^_:7d5Kfed\KLQ\LMg5IF.LS@+)TKIT=_I
)8VAcfB0.0aW0)ceX3_M#MeO<)MSZNW<I2ML_=6((-7=5PR/WgR+(G^E,8W1&J3\
1O1DV3;A6aT^>2HFTE;Bb5Q&aYZ>:;ZFc.WdD\UAE.+\C@g@B[0eK7.fEX@CADE7
>R]YVYR:fAbSPX.-g)LcYb^L]R.<[JVXG(.R8^7,_70X&HRdEa2[1eU:2SP4^bZY
-a>cQ90((:C#CWY9#_,50[47TRZ++FG8&;;1\(HHQ-WPa>OCD0VJ+=M+Zg+TNb:H
7D#(128L=#,_9YQ#]NV#(\]7bC9LQV)/4?a;dKadRWP[7c74B)I<H#D(CRO2fBU6
][-05=;F(.\PadL?&E6&Q1QI1C.9b]>#b7;B5b\_V=Q=cYM\]@71RE>6[[FL;1X+
ZF-)LfASX9gM4+gJf,02ZbJY,)PBR.b:YM5?P>#3HR4Y9GY#)0S\cU)M@/:\1L?T
[P^6]0L=)2feEA@Y1BbQV)YOYDLC(8N\=?PIe+,&)^8#fNF2ccM-<F+6Y/-M,]20
-9N7;S[cS?.WG]-7?^fbBZI@3;c)<,?T-.BeB?A&QPdPP\-=c>5=.TK2\de]_PYG
N+Y]DYce/)c/W##LBUC2._\Ad;P8R4YQ#K1gT171:Y[Y?M_6+HYM@]RZJ\[42&94
J2_(fO-;#>6<[,@YLB:4KG+b^Ya4>GD^?_8fNfeI-dH(-;]/J<NU\H0-DGLHDDG>
bZ2)9[Yc4g0KWT_.KG,\<-CcY40=Y54H9.MH]:-]PGZ#c,6XH):/:f,0C7A_<6Lc
VJ91d@4W5>dAWeQ;9X3R8I&b@?:FTE;#X)aeM5JPIE_8V.:^5[;UdJ[WH=5@D)aI
A6=BFLY#4dXN:BP;UL2:7Z;H(4F+JS^fcO.0YT>B#_QNTUA^[.UY=EWWPb?S5-Ca
8(=,cgG^:W&MDg6K8T@J<:,gfS5T-?_OYcM_.>Z\-9?](=ST.17-[.W/[#>UTK@O
4IV(\UV7M=;Z#G-Yf0Cg:]>\c3^+_D]:ddI.fXK2aBE9F84OW=cIaE>4R^e.NbcK
^#&=+,CH#.gCD,Q0-U>0P&A)]g;#T?)IXUSCG,2[2(=3,[S=P:1)ASa];E6:egWP
RU-+<b2@+]ZLT(Y.M3ETg8>IK-f0g?aM(@CJVbc8W(D_dMfS5Hb</&1&AbfA<=TY
T62A9^4cd,X0H_7=J8&O8TH5SA<JW68/T8Q?^C]C0U?LX\VIPIYGfB)3L0cA1FaP
bRb>/K2,A2MB8Zc=)/RXL6:I=2D+D+L(9_HDZIF(ZPXE#[J)KaY;BY\NCS04gRX/
aK]8=\SDK>4^W(c?bZDFgI\-a47\WPMW[[.<R_,3154:_)-.4[SN.T/Ud&82Q^Mg
8Z79OUR9bA/][&WeO8?P5Z6Q6g#78<@(:X_Z(S\:g-&bRIGeI1MBE/-#?Y,,2.=D
W;HL8B6b[(G>N4\]aO:-8c?^V&f=E@#69LQ[7R?L@Ga,;9F-8LY=B?#+Nc/cT\X7
D,]ZaK>)9]VFT^QEORDR,4,#Y.^0OSO+,]2NH#cT@BEaGTB0+0g<2)(a3/\AU8e]
F-Uf#>d=S70&a/F#0H20@S400F:0-ga+=CI:3f2W/+=6QD?:GK>b3Q>_/#;0/^RK
,S+\JO8Y2?U\ZfOO#YORYgeVI45564=<WTV,:O<OCG-,C5(F(.>O?..aObfJI51P
HTKe+[Jb27O-ReQX_:V6K3Sf>^IG[=a[g3d]c),<0gCRQNR^fL+TISWFQA)P^([&
dE7D=396TDTYT&8^CN6&+:5DFE,a,I=:LCV])L8G?;/F&.QSPaCbf&e:DfaU?[=G
,@&,-S_0H,ALTd]7ZA8Q9YW<b2FA&&CYB3>T1B_Y;(Q#I3[84&._>40;W3]28<(2
f1/C5F\ISN:/fSP#bW&3?(9gG2&b]TSJJcgWHKA?>P>#)G98g[V)>\/Q18Q\bSUU
G-Q[=()#g\.Hf^ZW0c01AdQ<,1c1WCOU36-3#?64eYLa29]<._)_eF@]NFB2:A#a
SCD9f]J))g9KU?JD.@E4QO>.B2bR+P;,g\V,6D<B9TCL)([ATB2[1\[^;:D2PH2?
c.,GM[F>(>ES+dD-=42N)6O9@:AL-b:PK]W/CR,:V1]=cbCa/&b&UbUPTQC5L;W^
7#8--DBg\UE1-#PK]A0ZdQf:Z\T^f/F6=6V,MTJ-F]2+P^L=edId:^Hf0C1N[KK^
Y,CX6gf6A[,X0aX&<<@f.]FDX8[\+_&U8[1P-ORSE6(8f,4N;P?1X,DKE/P1711+
c@O=;6QCE<2HCD&XTB\gD;UK(AfX]2]cG)\W+fJ).10X2J3Y,&61?<&0K5Lc-L()
]06/SZP\L2MHX<Y@G(#YH0b+L,-7).;QRTWg:N<U#&e0/6:8-6\OA7G8WUB/I+,@
_]B?aHHbECD_@)+A@@TXe[=4F&8=&aIV0UXV+8a1V=DYH\BSd=#d=HdUg?<HT2ZL
&#X#:[I8B@Vb?X[ZZC+JYTMWb,;MA(_6_CND2NV0H<YS/O)\?(?94AF-JNS04>dH
O4<-cVD16?7d#(>d]cL.d5a_:;++3b1.>;=X9b+@&TX6T_(Ug]WSS8>a)ATXQeQC
&7YLGE@]MGc+1#),-cbgU[S6BMUdE2\OGL,>D&cV@48_-Qd7PdHD.^5/FKQK4\Fb
8c@@8:a-O=#.?ZKO0V=]\NT=0ef53SgA5<GcE6.A?O:U0IDM8,_K,OIF/b]22NPA
[W5HHG\73JPgG4B(&0fS0,[CF:N/#WZ,SOYcgT#QZ(6>,?gacc(Sd2+/AJ^(3>Sb
DI+-6&gS1:U:;PPPA+:g+b5M9W1#2XK<>6(+GGX4I(0MAd7P1+bHL6F-S638Y+#Y
PK(RTIR_OQd@(G207Y/6M,V,8CMIOZ[VR4:2BU372:SML90dW=NabXM8E&G71\.]
T9G]fb;Qe1Nf1R&?17:32F@R7K<3/L2-.\SC0bb\>DV]ME6,A87[Me/G[H=NVY:6
g_WQ09A:C/>3&5TPC3HU[\X1ML3,5RMS4,_35T^OZZI+3<Z:PB?aZb4Eb7YWGYCa
5P]^T/eMDb+DX7?MA7a:@ZNd:F13?=QU5]1(P75)0UW[CJF#Yb<_^,:_M7J6X0/Y
3/3MLBP1+6I_W?=4JH5+#.c=W26d?H/f@NY3/=V=U,F9-]&.<B#]DCA0<4OE0M1d
=.VUF1)e]9Z]]2HbWcUN9._9A)cKE_Y#:MeY=+;;?MTTD@T.L)3RUZaMg55:+#f1
g5)[Q8H:;Bd_FN=OU5ggJV]O__b^DgH;P?S]^e9X=9X+3DSR5<(E4-GE&>ZQ/_7.
J8>2Uf<5@+)#KV=:Z;)V\Y(;)a:P&+PH9,QbP5M),SM)1MQ.9+CBD:QBC[1_^\;W
IBS[ZDa3MWOFf,(WEb+7>F1]RR=]0AGFSN0JKKCGb80+aSZ25]/#[SdKTN7Y(V;:
;OJ_,_N2TD^KJ8f)YZ(ZWNbQ3Z7#.2Q7@XOdT[]YJ&SV6D_866WHWGeR#W>+7HaM
aA;MZff5EUCC2TUK;4[[21KB]MKS0WH,FFK33cZ8YG_LNQU&F76LA6<f_aX,[W2+
,b(DBI>3g_4YIK@6dWJH8f\::deGc[+,7C@[1:BWO9_c(bI0AX++?ACD9cKZ9c<0
&I52BN,ZNJ__;UbZZFG+D8I#)/&L6Z\#WBBeSK9#?3C6[DE=[PG-YR<Ma;/3ONQ.
KFJJ,^HZ>Y/FT?.b(/WVD.1X)Tg#=4aK[2C4\VT<724[K@O@@4;U#3;(H3,ff1QY
R#W=6MUfL?b5:9#?>8<MSc4+-ab#[/eMUN7?BOK;YTU/SB7UJ]H=<=1LXa7S:eaU
ZN3:1C];,@;QBa\M,07XZV2ANaT:CUW,>HDKI_KNa;,3;2(.BSW&gaEb\d7+HD\-
5DX)gIcJaXD/_Bg@;4Ia#JVS>CPNU26F;^g::HKS2D\JeB93JGJS&&:(dG7G>I_F
GBeRfRfQJ3O6O7K#g.dJ[CM]^Baa^&[&Q;3a;.,GST^b46&N4=F:7KLXZ3EV7)X&
-M(](0.-SIObc(-VceZEaIVI(;<;ID\3=JBAUH\AI]g9\>^I?b,9)BDIYPC#aBfI
>)U^Z]81PTU71IY9)F-)X^<Y\V4JAQ@Y(E;KP5)(cHaO;eVC4R2,1T,-[\Y(/S:-
:a:O1VfQD+K.,7Pg0Y6TQ8<U@LPA(Wf\.bDQ^W605UG?f@0.<]7(I\2Q8gMT;)R;
:>:D0+&#53I=?+VeCD&W#4/#JP7NVC?V&#3D&NfYeYb-,Mg9f#A=P5Y.bZC))X39
9AN[C3,0e+)@K=4KgfY;.dAB+,?1fT)#RW199(:gd4Q]a>63H__2d^C</9F1HaB7
>#a.9fPT;J09N2B+7XO/R8IK9-@UXgR@IEb25F0#9;UQ=C5:E?3NgG7L/4C>JXCZ
Q(OaGNL?()P8DOg64E,8+=8=UcIKafY#D)SWG7NS:/&P(&9VAe>G,Y2CTRUX_0H^
]7W:X=D4L9eNM:SW/3RgHI,UgRM^b)1-_2VaV^7;a]O=@\H\?4f@;PD4S0L4JdZB
;PRN+Cgb@fCJdaII]C4,ZPROX,KCRES#a7c>(_]6_Z95)RF,;#(8\@DDg@fLPggc
AGaZ#UL^R:MJa#VG/B)d:G0K6<KFU2J.1I7H4&L8V</B&.;@K+NOV3VO\\.NX@(:
[3>7V=05(;,Z]YRORD?NQ\MD(X;_29-VF[C2-#N-/c<)])0:K5;+&FUX&@]FG?;4
A&X<F0\d7MZRL-KFPE.@#GER#\Z=:V,_X-K8(XJGf7<KD=6XTC3SVg8bd1&bDVZ^
F:YHN+:SRN+FART@?7?O#VZ.>O)&SbB(T<K1E4)Z]U06eDc(HT+S\=J3b&FFII?;
f^W<7\ZcgVK0)==_H[dY0e)TT/O+/4?DI&9V>QKgM&\7ba^J\YacVee78]<&K:8=
[]/?N(da^7S+;^:[:Q/cPR]c:-f[Sf_@QKXRE^/3>U#9-bB;g[PQ(&?I6#UK](aD
J9.FDZ@0K9Ed8&SJ^3EAa2_YM2]=WD(UgEF+-R-0)N>C+fQ<g]ZCWOH6N50BS;>&
4](aQa#99>L[OP4.WaT&]P6=96[XXM#MgGad1Z)eOAFg2#g]1^>adHX0Q]]3cSRM
NI8=))eaRdRO=)ISM>4ZKJ#Sd+M>.VJF/@_QIFVP96MX.GIg<CLN/8IM+UP_>gab
G><##EHA1S-QIB@C9ZSb35Oa3GJaELZAUP4;W(JCSV=4=E>JYfL2eQ@LD;YJaYfC
4_^=K6\P/?Jde:4I3,DO0DOY\1+/WaHZ79XB?+HFNfMN_K?B+c5X:>?FD-[Q(7;W
GRF8ScbT)D1>Qa0a,6UL\gfB??IA^Y30\>9#+M^^@25?,;BO8^F9+Cg26f:d0=Z]
+(;0A#2?e;5a<Z\_9e]X,H@0C/Q4S:_UR]Ze0bRH\^X3L.^d,K[U&YDgOSERYB0I
N/:[8/-R;[E?g1O@gSHG.J#a1S-^&_Q>)D#Oe97/ag.R-7P-e0cL?H3NFFRKJY9<
]Zg0QH)CWdOU;+E<3G808FSU:E0KeV<@^ND/EB#\EJQ/bd@LRWc]066KT0SBc+Ke
V.>F:[0-VTd00>FYQK2Z957=PL.S:,5IR&P2-@\\Z1QafVU0VT<Xg7E7--7VS=WK
7[3&Q\Y;]J[)]1T.a_a>BE@C]D4LO=8&>/C\Q&35I6/OXg>.Z+;b1:E,;3a1]J&[
fS&GV?YN;WMQ@R#9BGIR]\8PO=,D-UQ>_O&EB?JDQ27R</fDVRJX2.d.fb2@35]+
C]RL\e&X#+,c[#7E_](:aU,N:4decWbWT;)<FG:.Y+aH)g\V/E9]U^?4^g@&#UB8
/<8811@b0>-)V)A#cOLfN(QLMeN7SZQ)U2V226/d61W8&WDP)@?)?AV<+1)/)ISF
I,UW^<c]R9/N788;N_YIa<2C=/C^Z@+X_JV1:7#M-20AM4B=D0O_+1K549>a&9RW
;+.=;fR=O401:>d:JNNe72QSI6FJIB#a]R9(3YEN,MT;]9a/:#[.(2^NgKH7R^)1
gZVO8eT(()GBfcO@e+DFGE=\aJ83+ZN@ZB\I_66dL/M&?HeX;INFd7ZK_YXVKJ]O
_W(KL>cAW4LW+d\b?B;A=OK8Id3MN9g&]=^TXH8ePKcJ?X<BS,S/L)4;@:(X&LW6
[WGccL^^X420P4CNK&f[JXVSI+MG^Y:.I@\(+-^YSD3&R.-:YN?WG8EWH.D=R3_X
0.5-<ZT^C>c)RQf8BVC?T>[Ja#&#55<bT4/JU?f2M0:ZfW4XJ;8.)b0ZPgZ6(QXX
#[^E_F>-#15]:EM.<A==Hd)e4<GM(GYJSdc023JeaQ:KWK_9)4Y58fe55:]M_[H9
RHY]dV855S^+cU?>XE9e9Nbe1La@1<DeA<\cJ=]0JLHe9#C(+IPX#B&b@9_<cbLQ
:^<3D,FX9T-.#MMKW5Reg.EF1Xdg<S@5:P&@d>Q1,X677S3f<L:_/CEA\#2O/[Bc
9(A+U-9NHRb3f/&QAaL;:?0)QG558)9=CEEJ/>f>WMD[P-AYdGW]Y4^5QT\=Wb&Y
S)[54WVAF?B^,XMC(FLZ<af?2J>-#J\XK(PG\dBXHH=564LeNQ2C^3@LK:C[5TYF
\QP29U[fNQaTbK2I.KVE?V>FF2b4)6CfeV?,/4L0e<9cA)#T[G[TT36.\O>K&8)G
XAA9I^1cI[H=R]L,F;9+95R2NGc-1?;_QT78WQ@P,\^__2EL:g)])NFKQK=:NQ0N
>5+a=3G_ZUfSB>[;;2URA+f0Zf@UYD-D0d9T5]XDa-H0N^N^#3[4@P=,STHLBgOD
)J?=fH]0LOCRR?KK>/eJYFKFU_+078VQ&8W8+D4W?Cg<(S^R4MM93Yb0],;G8-I<
>e7)0E,HT@XH#P;.H(W[1CM7E2SM8I4WXZ<-@c&(<</AF:[d=f-/Gb;e>@KVSEDg
S6@N84c(d+.6#Qf2&,FfJ2RG;f_5FO:D?77F9@GK,743\&BY+Z7YH/)9]=,G13M@
])5Y0X?OA>3Hg;(\,<[3ZQ7-83^UJ,AN_?FU7cC/IR=FXB).<E^@?QBf-^,#WL_Q
=(82\^:6JDKZSgO(U&PAX):<QE-?;.IX4<^KK2bZZZU)Cd#H_C8c)G2PT,3N7XA1
LEMT672:5,4dI1;gD&Y&BIS^4b=G)CYW>OK:2,9(6]4K.Scg]I9T<+M\b]He-gJ-
aPVRUcYDGaZ3QR.N0E8,f>L2B6R8<_[37Z4XK:518Z,bVPa3R?PY3/FM5?2A.a3g
JYI>/CE.K4:b9=<Gb+?F,9Y&eV#UR,_]6HLS2<\+g=P]K5;4>fO<]+O@.aDWQDZ9
8B+DcEJ?&R2P,;f::PbA==L0BN=d5:08I[MR;V7FA@91R488_0V]F9@Iec;DLW37
#b+7M@S9;gUI#345;EC7H.4cYFL<DY&C1[?T_;D(3F&2&\Y-,M=3UA2B396DZWWe
cUA5R\)e_-@BP3DAI9LXZWJ76H<.QHb>B8gb57@NGFM829^.>QfA6AQ\T+d[W1IZ
a8MXQ&5+W,SL9Y=bQRZ_XKK?6K390]J3)KI;<+-2Q/bL=O1R-WW/\&N3X_>P)4Ta
Q(Xd#[L\2OL:30F;db-YG/65FcWGCLBQUFHEd0)00D0N^2MT/<#S&A/cIU:,F[_X
7Fee::5UFUC1I7K,eAgUCP@Faa2,QeY:YZF4/=UJXF+(KB(C<cF-K5R0R+/:&3>@
/Y3@I^IgEab>XIXTM<7D953;.F-d53+2Y0e)J)7EX4b8g[6b-Q.[W>Y#]QDZDPNM
-TLbZHB-AAB:KS4=>CIRUB0>SW?O[KaUW@EeK^_1CDKYD?/-6HPR[\\ePVEU\O9A
6@)2KGGVB28Y?Z/&UG]0JQW2K<DND0CO/BJ[G6d#9Bc(1\60=[HP^KQ7W1[F51Z1
:T-;;VGXEJ,PI:MEOaPd&N&6Xe;=(.T<O4&A4cg5Uc+FRI)bQ<CcO[-E>[(aSU(c
;W=_LU#P><=#=/3:H&S12WSW92-CX=2X4bc23[IAP()79)WCD^=2@SA(+Hg3/GV4
7_C85?5@F4b,Xe:Vb@?#L3F2M]UfTUA+KSCWOIV\9-Q=/NJA6LcB>6=SB6L);+S7
(IORMWaEb6=7abAAR8\-B_2VM]GKcFO(C>C_O6+S9aeee:M2H\FKddWHV=F4G;^Q
16Y2f&TVWG:;XGX1YVXSDM:2>?VXKe-F2TD=ZELU>]CQaK_&R:&.edEcc:ZT=eF(
J[(2)6W7,?b+JRQ73dI^7PCZY)-@Taf#=_J\L437I69RC3Og?#g1d3\8-7&0U7G:
1G+ZRYUP3ZV9cDWO,@T?-gTWe@.a]Y2FZaYdC2Z3bb<K]cIGEdG2bT_(4++YFG//
OW=.94\G)>8QZ(g_f^cZXb(_^dE<O^IH=3eO2ARMH>^^dPX]?<+g(6Rf)IYa2c.a
b/M-LSB+a?1&@R]>;e8AR]9SVXFM=:YCH:WOVNJMEaJ8UIaI=C(a]5#YWW5bT-F#
:MY0]/e:30a7&LgOO#aMc>CEL84eKaOT=Z_^_<K6e5IL6-]\JC=V58/)@PSZOY7b
\Gb@[Sb85]JQ\9[#J)CUYGfS,AgYYFe/Vc@cHL\:YMR?URUY8MS]cWQ9-cHI,D[M
LBQY6+9U?1J(]TCP2C&[5AKR68-+7U\),<cJ<3JJ=_LFFcNb&/.L5JT/N&K8IBEE
+Ag7X+5e6+3Dd=XT+C1G.\1+FA76BA1/PZ9Xb[(T^RZQdb\cJ4#X[OJMf18Z1AFQ
&J:M\:+VQXX2UHU^A?/_E,X>Ea_RdH,0RP.<S:7/,gD0Qc^>54[U0P5V9ObM5/;<
T@UTRKb\16ACA>1S(]7[85/ae6^J9cYK0?<1<R0TTY>g4>^BB=C3@/]3@9\M=47f
<?+B]8bgSg;<)cU;QJ+58Jg;dI_:CIS@X/6M6N1R-(0WJO.@7T852=0DHHVH8Eb.
?@QbZ9Y^g/YZ_(-H#H#Y6E1.JK1OF@:W2&c-AT5e^3^C,70TRS>=N_)R<g)<N/_S
@:C7/9JGPgM2Q)MF0f:2HC6aVF2bK2],3dG[2@ZZ0#^CO<10=b0UJYD3R\2+@E]e
S\f,:&LR<2B[TGA[R7_E]HX-faU>>2UPa=LO;2Ue_gcGN+/:_XG(3fWYS6eT/A)\
c4GHdZT&9_Q.8cQB2,g++MGIZf(&;dR[LKf0cg2g&0;KIVAWY33SXNg4->YUJ_\]
MT^6\L&XBI<WY1-aK2Z/efQS55^;cO/0+^_Nd[?gZ-.N)K+]?LcNb1cC2Ke(8IF-
]UI7LT=DKXK;e+V?G_V-<[\cPHQI-Y6ebG3J9:IH?,/0UdW9=4bC-b4\a148QgS6
cMON:5&e3&7.BfXPI)J&fQHVNBcdc.8PZ1ZFX&ZY]BR26VILNg3L^[b0BbBQ@.H;
W<,DCWWZ.OU/X(d6FCD581d0-J<33dP,O.X.J)ZWXEEO#JCB(Ze43C[OW+8\=[bD
X4V?cDT:\8(g#F#Y2J6XDGF]&S?ES-@LeYKXRUF&f3;Cg1Y9W[F5TK]3g@;R/\Mf
V;C0VBI\DZN&8=\]MI@f.ba\O&>0_:=^XF3=_,GgHfGM>IGfC3KEDUAb/T@b;dQ0
/NP_/:W=bK3#Xc@f98Z\L/9Y1f##Z_DeH;IXfeLP0d_9#L<b_)4-D;@8ZO/_@F=b
OHK).d@\71YR3,P]XX#dg.TARV-1)4G4bQ54:J_UXTWB,6@)E7Xe>V?.P(09-ea&
Y?PU^7Z\5AQP\\@acOHT.+IZTD#_5M7?JRLaG=-56#QF#cb\3HR9?U@>O4RZG6_1
1\OcNRUe4[.WN8JY5.4QP6ZF9D)LC8E/5E<EP:/ac=bO3C.6[.=bD6<(E4A7)?,@
W4>_gOa0;aPGUB^A7TO-9HJfW5+FbS&Z(1J\,[/QH/-118e:CEb^\P]^VIRd#W?1
>2\0R<?2.(RN2LfgV^BI<.XeG;NR6:JQ]6cXM4TA[(RgYHPO>X1gOIF#+DKPW:F5
<.XNW^Mc-#cE6>#\^U_)@8d6AG[NGL90GfUc-^4(g)[<\QRaXFL@Vf,JPINHD&3X
c]0.9@[BaY#cC?VFN7:]U?+L[@S&.^B-1OMV)Db=U0)T=.F=9d<@JDFR27D/aMGV
-eX:T\B+5W1&g;d(&ZJ?Q>LSMNUL)4<G.XS0acF^?/.,Y/W7gT6K2_8Be-#0ALCR
)\c:HZE=WEF&K[HV7FNGJc3bX;Hb<8O38;61]VD,/&d)RDTY;):FL7L(02)>JY+:
:?dE#L51#Y_UG]C=UIa@7.51S(X?(BTZ5Ff>V\=gDb<^SZ)#Z\JE4aN/&8fKR?L0
F7_1&2@<fNQ3cGFLPe?B)).IMP0C&-X(K]^GOfQ[&D-<AEU>UQ)<dbXUCML;Jce?
O[a_aC,Z:/=,Y).9PgZMScN<5VI96N=aX3HaZgc<+-3?CV1DKG9Xg=-c/bNQ<e^B
136#P(MB:eP>JG8WcdISCaWTHYPOR]8<L9-aS4Mf;]_?4N)TaL6F43>8-QQIV#4,
SRT?)-_NL)gS8&J[Wc9ML8C.Y6/Mfd^=+I[&c=;8UfX/YgXF^VNVXHMgNb]YdVZU
WZ/A1:7+B.dVK[4GIZZ44a.B+,6N&5M(].0Y<623V15VEcd+.URBL2Kf^4?BDVE:
D8E<NM5OGDf6K(a(P-VFTXYbKY9]LD+5QAFYYe+?_g_>>?@\E]C:L:Q5?4-3WOgg
bWQ>G#]?C,1SB4b-.G&d#B=YX[N7&KOE)J)@dN1.4GM:_MS)P#=c4W_&#/Y-g>eK
.cb,1=D4Z^:GT5)U:aQHSVZT(OZWa</L2?gB][K,LE?M=\9624[@Y7Zd_g2A#>9A
USY[B,>>W:1RF<_C<LV2QZ=3&=);K?CT/BSH#]S,]/TKS\<189#))_O@QX35[1,c
\7>5]_,6)RNgL1KTPd]JJ+,8d_<:PU#,(,EgOARMIX@\Ef.0Z+<[&a,.d4?@eC@K
YcTJC:Ga5@Q7(_4Q/,08c+XNB?TJ-Y>ME+9d6f6(1\)d2B55A;C5I5T\C8bHU-g=
E06f)=.De^HbJP6?GS5XA8_NIGG&]dR)We)EW?PfKgWf)09B6>f,,^-:H(8SE+.#
O9Z:@185,^#-_^MN+274N[aCWWZQC_ANM]f^IeFK/eJ3eR[E_age-bb0.0]72ba1
]Oc>Pc[^6EJ,6-]J+]85A9W4bG@/\:IEQL3I,D7^gGM38L6)<FZgIF)W1[6^RSQ(
J0,D4QTN]7-VI^HAB#d[Ve#(V_Mc(]2^R^XAON63RRV>VAN][.b)3RDHU9X[g8HS
[V+QU:AWYNLR4?eD^6UA+<YeY,ER9P1+2dGd40,6J)Y+g<#;dLVH6+D8b5;M@PF1
^M;4WeU0I[A#SYcLU/Kb8+]N)L3g[\X>GC,-2UKa7<Nc9f#;B3dC=>gAF?U4bI[;
QS&2a@S@7=ZPc(W=b?2>f5/F4DEd5^C4bg<:F@AbgKC<K,Re\BI/.,K/3DPVa?P^
:-fPS[E_N;,^\aRgD5bLbTT/7NR[8d\[U7[F/LH:;#[Q7]-\Y6#<7Z]/19a)0Y:e
OZ,/-A\2GV.3F90&OZ,VAVF+W(9Y.)\S+JY]=7a>GOg#_3CZH4dBYZ[ENY+Pg3:_
]:M&IRZCVb5YT2R17?Ue<e1[LG8_Y&+4A_.X=e2a[E.aRT;Sc_FY&Ogc6f10?(;]
^O6:@QgWf(I]?NHD8d#fA\Y<+:T9AFWdP3YVBc^G7-R^C4QS_BH<RZHa]-P@Yb+e
OL#<R[H6OZL_T);D9F#RO@Q2KIBaJYP0cB^CJF1b_QgL257T9bJ9.EHY1OXK(113
LJR)a=,[DER,2A;JcI,?#eB,#0;8g3_SUM/ST?C;&>+E@V[&g09a/^&3\#.d2Sca
19K]=#F)_?_C\6JH>1X33BbT)UC_Bc8Lf(YdfB.SLdUW:((_\29>1fc7Z4L3V7G+
XIM:_J9OQc5&?eP2ad3?Bf3decB5\[RWLS2O0&?0#S;F+1JOSQa9eW<W0#;><)<A
SF^eG6Z-P<OaNHP_LX5PB-W_,.<5P7eg)E\E#,1aDJWc63_7@O_;SZc_Y8VM&BX4
gM19B-6VGaO79?8SZ@S^Q#+L^2;=_0/Y;&?PE6\E/D0@06f.eRR.YcYST1]Q)=8-
gUO?09QXfVX;2WMc8;]d>-LEZNN\OFTJ?OHf\5NKA-51=I,0P0_.e4^YQC/&I?H+
@?P^89fX31GYLQ(WeDNOg_1]#R>\Xb6,f66UN[)MeWY;SU^_4N1D/#bcbIGUF&_7
[-KC9H[PVN^<HZ]QN,P;A;Ga7@cY@^cX,D2]ALdCKD+Q\<,,:(HQe?]/_9]V0+8B
RI?8V7U]\M[^:Z5(:Y6^e_O^2_T9OS>(3@<8A6PT&fJ4K#fKXP<_N(G3S68ZfJJU
ONNVJ1Gg2Z#7I+CTBTYA7P#DfZe&CGaZ22P-W4YV-K:??(+AXJJe&R07P<UB^;F?
/68ULGH\B<HC9)BRV9<\4-^5D(EfPLD3E>)d#8E0eMY\UBSF.CTc>#YXSSD@79DB
;\91?6&61@TW^F>67O8I]LW)Xd#@.AbWdGCMT>&SKaLPF,FJU2JQ<X5Y^(OdV)E^
+>7?;OY==V?_2_C6ZUFFCIET8<AX9]D)RCcQA6)c+ZCK45fPZ<UW.c:1L[,Z-dO\
5\bC#\X0D1?QGP+I9<,UK218U5K3I<A@YN9#D=WbSLGc2e4YW(U_79I<P#)0KQ<N
2O.\#&K>[,_#0caHQNf=4-R#+fZZD@I11MN<GF.BX8YCbTP&49GM<3WL[8=;)=0^
+NP?67;aQa0__^.)?I&F1R&bH,PJ)NZS96)4A=/,O6(dVY_&N).?c];<.e=B2#)N
.55]^SDIKL.UHYM7_;M0fHgHRF>]22Aa_]XAT^5QI6_-E;:<]A2+K[2IXIAUY#)<
QaNH:U5VH-_N(7J4H&,_(+Y]Z3:TOX<(:[dC+V@1FJ7^dK71>&&AW4?;B0N,\e44
FJD0D;+;>&8FPaY4dJd1\J9N)P\Mc_H+>:RgRGab.0SZ83>cRVZ?O7b=V<#S>9^e
gfXQ=U.bO@?agdOLWaVM[D9^PU9-S\0?)\^,G&U^AQ^:e=N0[3T1.P.Ha+@@<KZJ
S9GT)Qfa>N:M5gI0F;PB<H:ZCd70f]J7c8Z,FF@]U1._?,IOfONJ9SQ(cc<_UH(d
(E=W;\(30ZW_VSO3)7G=CQ9ML\=H9,g+5OWaRb)+_ET([^KCTBU_F^dY_d5UHYMH
3JMNR#XaS;[)U<#QAI-\@C(GH8EFC4X]TQ-(4EOcReTa[C:>A_C?Y6Z=M=MNN;H4
/ZYF@)/.3>:,>BfWVIbFVQ-6HC[223A#;,-\,(Q(O+9F&5:ZU<0<S3UCBY3B;<bY
ge\b=;:4YQ1W73V@.ZY(_b@3\K_6(ISc/.(=F0<=.DVT1DHICgbNMQS/dFOS^]X>
IANgCE4[Nb_@CC#b)F?@cLYa],;@O-@B5=^1J26[=)A:5\?c0Z7K#U12BL:[<,N[
5(:55F10)g/N(^;<_6A7LMcK94@BEI8N9T>V#RZ-III>BF3RDV_CYN5f7J3(@T9b
_=IP]YA^?21#^[>NBSM-Y=>B=)]_HEf^NBCMBeR8=Z^S4=HWF/gC6<2@,W,8>#HO
e8E?NAQ-;aLFZ:QB,XHLNQ4X^H=;92B>e)dLgIf4,]FbMcLJAUD;Z]ZUR6X^;=95
S/7UD@L((\G83-d3Mf^YEA2Z?KH+IEcGaB0^46[,:ggEJ66T(RB]S3N?BQ\C&.1d
/VT1Q;\RNb+cGE68X7f>AW2M(G68gAQb9d3RM>@6Wf(NN0&KJ,Ff/&-,6Be,B0L<
+JB7f53:gR#fQ+U+)TJ#6a7>e5Lg7W-cg^d#_C9S<3?7fF1T#f(0Q@>)-W,7(Zc6
bLcPK1SUeOO_U0E&MHM[,+7X2b2_AZDX^BSJTgXK,A(9]QM\gT4Va(^\5JXM6,PZ
:0G?MSP#SZ)8a#BL)9\((T]D:BR#.ZUZdEHUT79=(W,9H$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_STM_TOP_REGISTER_SV

