
`ifndef GUARD_SVT_SPI_FLASH_MICROCHIP_TOP_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_MICROCHIP_TOP_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP Microchip top register class.
 */
class svt_spi_flash_microchip_top_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** SPI Mode Register. */

  /**  
   * The MODE Bits indicate the operating mode of SRAM <br/>
   * 00 : Byte Mode         <br/>
   * 10 : Page Mode         <br/>
   * 01 : Sequential Mode   <br/>
   * 11 : Reserved
   */
  bit [1:0] mode = 2'b01;

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
  `svt_vmm_data_new(svt_spi_flash_microchip_top_register)
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
  extern function new(string name = "svt_spi_flash_microchip_top_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_microchip_top_register)
  `svt_data_member_end(svt_spi_flash_microchip_top_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_microchip_top_register.
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
  `vmm_typename(svt_spi_flash_microchip_top_register)
  `vmm_class_factory(svt_spi_flash_microchip_top_register)
`endif

  // ---------------------------------------------------------------------------
  /** This method returns the value to current MODE Register */
  extern virtual function bit [7:0] get_microchip_mode_register();

  // ---------------------------------------------------------------------------
  /** This method retrieves the value of a single named property of a data class */
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of a single named property of a data class */
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current MODE Register */
  extern virtual function void set_microchip_mode_register(bit [7:0] reg_val);
endclass

// =============================================================================

`protected
K_C)-VS5;=BPKS7@@+(@[=-J:4Y=f19U@UCS7SU<\P0d\DaQW\C71),8-T/7Y&D;
;_,U(gM,/K#b)M#M3D5HfFBUU;BV\D26E]H+.eDG,(YL0/(8NIbL4;BBO5]dW/@W
Ad6HW652<Jb3MEG<V&S<IKW@<.W24>LFXITda70b:+4aAQbMdCd0@g.)HN3@<:]4
B.(:Q)DeS/FCd7S#,-Nb5(aHSUEf+Y:VcA7)1_6E\fIYUE,.G=\:E4S,c4R(Y0G)
](:OG#2(/[F=c@g7?7,Z-cZ;dR1M=KU=e=RG3BN6U1GPN9dOS_OG=XZ@QJ2=KKIS
AWdECIWc(=)BQL[/UKFB#W;Qa9,b.86771._HZX)]e(H@-F8>X\.R;d-V/^XVI\?
EU4L>(I\CU7(CS7FRagf)8?+>5:;;(JOC>MGEZM^F6T@;]LP&&-c)<V=8GR(DgLb
)VISF:N6KS(.cb;X9]3KEYJ/c23[KZD^W[_QE9QQ-][(<\S5KSINE5U1H-WC-<)V
<\]=GZ&aTeF/@gR;c@5P6@F[TUb?-6-a7=FCEB2e^=[#)?PGd[OO@&eS@6WaH<#A
NV:MX,C1g/(Z.PR+7:ceHGIXegYDRB4dDM9P-.NVDCBJ.U<MMPSRKZ(C,Y55PKSc
BXaJV)J#Eg54+X7aQQbH]9A;Z(IgM#EN(@<gVV9Q/X;O?43BP4@-#WV7;XAOXH=MT$
`endprotected

   
//vcs_vip_protect
`protected
?:S]MKD)Cb#V7:0DCMXTC1XU3OC/]OW4(#B:T.CV?AdY1L^289KU&(XR;b<B>NE2
VI+NUNZ^>.PD):7,@DZI@)84J2dNcW]X0JD.6TW0Ra[gO\ZT92aQ>X-G3#9_K)=0
e6HK].O9db=I^Jd3AFJ1N-OA[UL\?Gdeg+GBDPOC=Z<D&E4,<BG3TIFO0W4-4V#S
ML=;M9^gbVW(//)D_a31PIVE<DF<\S9BE5V]e>TEG8RR>3dO2NNF6K(XFg)XWGK\
,MUO9[CUQc\fF_^04/6-6+K(?(896T?266)PUXa3K_QD3Nab1W1X.E.FYK@&?fC;
D:YD&1_g8I16TKQ#aR?>&FZ+.QJ/69EJ&V40gL2d&;8\FCE4@<9@0Z1RI&0AMPAY
5#E()QfPVAQO[1P.)A?<GBD/aQbF96K@]<[]4b9;(N8L36PK).FbW)Fc0O>&@U<7
g;Va\NXaFEX2<_UPEE5D?c(Q7,\05-V<XH?5P6+:-OK=#3RCa&NDT0L(fU5CYD6E
M[K2R2@?3Fg&G\?&Od>e0gV&V/,VJ._^f):dG?8bGH:JA]@f65DSIRO[J?2O:BV_
1=BXD/H-R]]357VVUV(C/7F2?QSa><YX+/00+SP35K/&VH,?AQ]E+BY<c[[&10<K
)R\5Ac27[^(D3#gdECG)36)^a4Y,F@J=[>;d)<TSMf[+AX+2+_[?(>Jf@H0:+bV;
N3?@9(b#ENJNPQ04?d9##fa/0FfI)W:@P3?X+U&50(BO[,7SVf=\6&08<2:?(d@e
f]IUWbFPeZ13:T/0>4We/9Bf..-L,.92BIF]62X3[bYf/0R/DI7gU@YX0DTCEO[H
298P&]UO=DAYGQaFSNDc/>@;56L:?ZaV)6L[,Ha3?bS_7^PV)EV2[_#b^?KdOK./
UE4>T.:71eF0J2X,58>f[XE4NJK0C.^E4U<(8&7T(LY#O\//61cC>WG-\L7G.N.3
_VQ6:Y<]:).B80dCP65:;(0&8,.48MX/5E3c@5/H(:29^]QT(G@A#>IY]AWc]J(1
CGIDAf.&MDSEd]6C2d^2L+ZXMH(C4E7,7FMc_e)6.>O1X48&6OE4U1T_,4dI7WCS
,?RLT&U];c(N^7He842B0W4,SNHX(L[\0SaaX-SC/NLZOB--7BQ6]X:J..BU78CI
DH[7/fV:SgL)\_1g>,4)B4T_dC3QbUT>K31RBQCg?G#\^929P9E?=@3/eZ<>SOD?
g_2L=PV^gGcCdAL9J>b6RS;RH/d7ZIB&bHTIT8<FegWHF4FG2R>a=Vb,>U+9_]==
acXO/XgKJ9]>WTD=;5/YM45.EbYLEXeN3DGL4,W&?)BU9+>TIPTI^2Z>M()Ufg^X
^fGH9UU;8(d#d3J3BP\S_DP+.1<Me^IE>UOH[fRS2fI)01LaGdDO01f4RWSVJHg-
#Y;N4P852Y(\0CV>V>Q.7WCg=@#A?J9ESD?T?\^[R;D,(cU39.@\\9F3cdK&gg_D
gG-Z=L]E8Z>e<Q>6O2-J8&GRY06NP@S,gH:))&@M.5GP#f7;Y--2O5/\(KIO4-F5
V\(0d[)_CZ#a7L8RHA&([6,4<QL[;VdR6:=1Z+fV5OR;Vf/#^N1IN-3c[G[[)OUY
AHMJ?&@K>YV&S;WU+BXa:2bU;CUUU:DPcG-d-I/+X]&3Xb#W_>AC@2;f[9Va\YU1
TggM:3:cS8ZJEGXM\8a?6;2c>KfDR+DcKL?F84S6BJ.20Z4:)3Vc0gB0/_2SWA),
LM@6;,7M:\ESB-()/A)b?X9.dPY.=8=K&TH8BbGQ4e75R2A2A)IW9B6XG-WAPZTC
C:GO<d0TE\0e1g)-B(f>WNJ2MDZO<P9@D3BW_5YK1]AQ,B@\NGS#=;Se19]W80=:
.g:]Z6=+R]/AL_.BU<X>5eNHR(MIWgOeYUbVUH(G0,\gJdBHIMBFRTTCXA-&=1[F
C0P5,ga4aV9,RO4KW=<cA]8T61F0e8W_,^<.FdM:YQ:DfM4f^/d2V1JM?N&Kb?+T
-[[P&Y>R+D--/5O:6#C>\.T(=c1VcLW;3PSUBD<R\F7Ycc,OZOcfM#Y,6efCVDRH
:&I_.9J+b1MfB;MPAZ[CYA3@-G3b)/_34F&W=V_M[V5==/V/Cadc#NR9]ZS0-/1P
,gSNDVRK81AX^B=aIdSF_G=3DA_?>@\L.:5?ROF1&bMcO5X47V(FI;GU84MgF7NL
P@16Z8RU@BQLC.[Y?feY,I3/(,N)-UcXB/?fIN#N4;<8K@FZJE),8FZX?QS3&^Te
CGGQY8dUMG?:GU/WO0EF[;?Yf&5C=R-BDUTS6@BFbPJa4>^#02@cZAg@)\(BJ&1B
>d\ZFHM)+L.Oe5d1ZBX<7W01C#@[MOM?Ae,Fg+aFP@9P)Z\YH0&@AfCK]O+CQL<P
Zc_7,DY]a2R#S#K/1EgMFS9UQJEM12eMd2[GG:LWF1CX4f]89<K-Hg/f;O;JgH_^
^DU@Z6Q:cfe55CWGebcDPUc1:#&5[V1XM>a<F9f[,>>?3Oa2gD]6I[>?Wf[9IBS2
f9O8cg8N#@&[eAS_D_AAZg7:/cJ810T6LS9?cQ;IPg(1[W)fO_)3(YaSacGZPY.>
]<CJNM9S.d;e9/eM[)]W/VV&(V[N3<+FXCDc.<U3\+Sg6&\#1-R&TJG@J#(Fe=9)
QEP6CO0X6X8/>=@9@cDCc;&3)CRBEVT@@6YDEaMUMB3(E:E3:.J1^-1gTQ5adWXc
(b=@D3eNJ#S;BRYSI-+BdG.bXRf1VS?=gTW1B\#8UT#0]]F&g?5/ET2cf6@RD=f5
Q;KC_NQLC_26(_AS=QafWR>RX@d&8\+1OKRHP\]Ua/L0gaZ]3PGaUZ?be48EPR_6
?4PP/c^\f<JTdGUU+Z/\J^,0BfRWHA89X/A_B-7e^G&PXM1JEBC5(;efdUA7L)dO
V/\;V-BP.X+EcRFY/f@0HPDWP.GRU-3=D#ff7;1[gc;[4[Y3KeX_>B_?E@QUBVNQ
#;5Rd01TH(0b=YF8_U@WbTf1C(.XF>?J-_+GN?KdA.<&d\#K&@cZHd,25)2<^POP
<5>6/[#SDA<\d^,.#5FS.:a7Y6b6VDbJ0O9^f>#4Fa\IZJT/+:XZ[Y4FA<ECJ9DU
Wdg#TSA0PTeGBPL6+/Q>CWTcZ]AWNLL@X1+:R:_^XPYZ@7VcIGaUG)R-^6DGOPN6
&Q#5MT&a=9YbcEF?DgcVEA:XE&GZC:3]O\1C6[[aVR86ASg66#U\/+)1Je,80PPV
Ge\aeU@[5XC-(ZFd?8f&7WV1EPBYA1XE35/X3:O@(bPNb@OLHF.2.c0DT[.&]EN-
a)FSd/3P<4@N/aHNUZQK/Y)Y^g[R.]4)?La=GR:K9e=+07<&c6c]XMN9P)JX1a5S
.;U0QKBaGWHS7#4P&[OT>^._]N?1F/b(YCV52ZPSfAL<XJYZL>+2.ZCa<0XV7_8b
8aQE#6<3W]4NfCY:B/H/36NGf.(bdcRNbJ#SJC<R3V)..-beOKSKBD(#<bSI=]\2
7_T9?W[\5fWAM;<W1Mb94U(dUGfS&FF?LgCUA)/IP?/-gZb5V31aD:Df8D.5@+7K
:/2B(0+(8>GO5SO6Z6O0]Y?/^?W&HPfTW+<2)]DDdUXYdbd5)IfXbc]c-+D>VdSF
\e0ZJ&Z_U>&UP59)OKgeD.AO.1#0bE5CH/GO,UF680RgS-d=E8.e.),)Mc2.<@.Q
]GbXIM)BWQd[F0CGZZ[VbQRC,\1QBN;W//_/]LaHTB]^N0V1,]=[de-G,W&;AV+>
_5Ig5L(-e^eH3RA^NRM@;f?S0W;;;XHPNEO_>R3T<8PP[I:>ZQ:NP;B#]ARGPL8Y
,P6CW/BH/[@Sb]:1YZ?8G<c55E?A\+YSYR?Dd_+=U6K96>Hf,R(C6@16bRd;0S6a
a23=<.QI3U[MD/&=[I6TYMH)Z[WJ-Ng5H<=gQKdGLdAGU#DUSJPg:4-,RPO=4>PD
U6/Ngc>M-44gG#Dc4CRA6[)?5+HFd:.?I+fDLEEbITHZ&PYJ2B=+Qf[^VaK4CB8P
/;))N:V\\^@CEM89RD5dg>56?Bd8O[1LgcH]5VR8UO9bOFI[+)=A[A/fNUbH?<)B
TDR+\ebA(;2O,9=;TDKOH-0:(Y?5cC/[a4(1WfQ#LRg:M?.a@-AE/)Y6#05SL]4&
Q\9gS@cP7]?VC4.Q<.,OPCO,70^J6?P>#\^GCIHX(ECN<Rc+Y^JBMaF)P#fba]X/
DfZYQXO@U:-dQD9<R[9_8WJ&VH#1=[89=;Y\^N;X]2)IZ^_T,ZF;-60B;K)^25QQ
\_V+FP1Y=Z+#V\Kd0#9C0Q?W(3L?J;;CVUPE8a<-CSd)&:_QNS,#K\X^3ZCWZ+bd
/aWZ7E>S9c&CI+,b(33.IHN6T6IR]@=JKD3^=GEX<KKBU@;ODOc)[L8OeDgD2P00
dYO6PEBMI=#de[6.0TYZ3?-8<df,Q2,OQ2Fc4B7J<bUCgcWQ(YFFNS5)fDI[cAS-
NP#4L,&4d144\;7e0QO>\OLM&QO/96a9>2e2>=OS@4RK-Zf)KP#//V5@K,-3.PY(
NB[1ACT+I_HM)XRN552CaG:,-gN(QJ0dL>^#@4YRN35P@JB7S1A,1A_A0&FM<-?,
e@?F52?_])IFcA=Xg><#7R)33<9-Z@6I_deCW-f2(6SU5g]\/##:]U,eCg@QU8W7
<65(6=:^/9a_IYg)c-fP\g-VPSPce-B[)>0N)VTUNDVFVWTDZ[)IQUfd.db6)B);
XDX]FJLV,g:FB2@)UI]07;ZZ&5WN6c(>.Tb-f-#]:-Y(^1gRF9aQX[?[>dBZR0Z:
>GOK2^Xg&JXWZcJ+L/5R>c.]E9NTKY)b=?.a]cF3eX-Y5J[aFdRa_CJGc&GTd#FQ
2,&8O2=;4.E:[CP+a]JZ&VeU_/LG11V7Z)TT=23:5HGad\<a5HTF-X(\A<+f-fIT
C[[47B)=0CbA4ZRF^I8QP6)c<6\)Q;HEHI[@5&>/ODC9M5@GT80DGbJ>?4bIFE+B
Rb^4/<+ZW3W.&-5>0CDO+0e^PK@UcSINWO@a;L))KgF<S:Z;&a<ZfU\D0RG6G?S1
dM[A62fX2WH\B6+?+Y];(BF;/+?)[;9?Kd/D_f7^)+KX(@d_N)bfg>57<]1?_)^Q
Y/d]cf1_X))SAGNWA3L07]HM?@?2BPEbP[eZgZf6^8U1J>+@@,).RW1aOC..3&V-
&4:5ffIMEF]P6XST2\:W^Xf5bW?8)@f&=:F>\8\aC-QUe<WbSY2/6(:@G3FQOc^M
G-g0.Z#)4a^7L7J8O<](;UDH::L(4W)5^++#JAU,K;N6_U311QO@>BdLAVOLH@MC
NZ1cW911a,H>0515R&B\\27(8C=LFXA9L^\QaGe)>@[M#b+(fIJXVAaAK=gH_P)B
SDV2/LO62+@PV2<KC7eCT0f#dN(2453?.E:TRQP[2DK3)bFJ#]RDP)2DY(KT3:0c
4I(LBCS^_O?&Ud368;J+K^7Y:1Ab+\>3SU6C</[8Pga,Sf@(##:?JTYJ&^(P2fVA
U6_Z;#T87bR\EVK.b,Qfg7F[35.K3GYL.H-1gd[@4,CRT/NR:Z37S(<PLO5;E&)D
4bcS-])d,VP>S:-1&[E<R(V?.6LR\,3R#:WS=>]I)c,B0CYd#[WD-75?]>[]<)A5
15g3^)HQ+TXN+3><Z<;5F7Gb&d26)c1;SJA:\=>Ug/]f6(Y+S86Ife_NW=;LgNO9
\H=Ef,NTWRAL.RX<NEa_>-]WQ)A#9(XOO>1eg,+W4Z\([Y>ZS6b0K?SX97_\@@=N
dEZ[&H80@=bB1gQ,3dV[[Z\9G5\,4UZB;XMY#J#fN,9CIN36CUgYY@1AZ/GIJZRD
N5gGB@FM5YaE6U6a[;8\BYT:256CB7fLW<O.gb/BR\_I/+5aMNX;#:3]b<^)f@TI
4]=9U79A.g6a1Ib=S#dLILK?E,1QD&6^Bg:B&>7_NA#<;?^4SKVEPLO4UDd5;<9\
.O7Q15#I0.C\T.>@V:O#;>]YWL60NV@a(0Y,^\GD;6KNT4+;2P<VI&ZaG;<&/GB8
1)g=MD)7EZ2,4DaabC9N@P\QM]dQ3,fc8FS:6YMUBLg#gF#eXf8X^QfCXAe?2)\5
4HR-@\H^QMRO2VMdJL_;If+X\a7=8)6U&[.USMO4f<PA05,_[2//GW29LP(L;0FE
;?_K(KS;9,OW8H#1PF#3:[UN6+58_N-C.+_SM#J/I^/.L/fD)O1VA6B7Y]cP.9gH
A;NE(_:K\,(413&GTO7ecgf##Rf5?eX#_E<UC>&\51KWgZVO-AZYDXG5#/8)/..>
7Xc_2Zg0EE931L#SaWNba_,c.eD#UCL=WI=.=0X(f)YTHM[5Ngf]G1KIIH_37UP1
XZD2_0L#M&6J#?69:,[L9?Hg6(C[@XJBS0U[Q0c4;N_@UUg>B@-a58)PHfXARg_X
dC8Q0[]/IQ;R=OSb>EQAD[/YX&?=X:[BC?FYC/L6Z]Pf)#0<QJ<Jd];gBKVdLZ/^
86,W,[+7TK\AJPEDAWPIE[4a;]/=6ee--dIHT&V?L,GM60?R-J>V6@&H@Fa(35f+
TUNg8H.KHf4cV<O5dZd-:,E\Z3&4BV\RA=,P,B9bUS?ZV&T-WeQ)A5fRUKY^6LL0
L5&)<AN81A)KV=c\IJcCG(a;\WOI@c4/5R6145eaJ)Mg2gZJWC)L)J9]:_7?CA:1
a]>N=CRTI3Ueff,^L4Q&>aFg8.D3N#E73^fP]Gb<F5Ac>X=\]A)I<[YZJMX>7>.+
MAA3SCP4[TYA61Gde-9;MI)J9MCB&5M^=B1+V1W?&9)G-RfH8?7c7dDT/K6/L8Cb
3Xd&./GdVa8A,UZ5Ja7degfEaDJXAPFTB5D0\6ONFH^+#Jg8;.N?CY+PNC1YM(9#
^1D,2)J[+K+PHGD_DEO?PfDED?VZHF,(6@C4@/<M@&05&C#YPNN8XbQ:3-?U:DEX
4MSZgMS8F+HP,=-59Ie@UD2[7b5[08W_-<&E9&ZfH++HJgc-)V:21SK(7,USJ62X
fd+-S3bGGM2P:5Z9A;@G[F>/.g8E^1b1,\]dMA4V&9ZL&>A52WBO3HfXGC+N_^X0
[53f@^3XYaGXKdfSW2PH)HTB#F+R=;9Q5c(eJUfCeA:F0T-4Z[/G4R+4(RWO.Daf
Q.8BHAdO)a24]8)7N.E&U)SfL(3CG_JQ,XGc:.V:)X,bMA8<A_Q1VP#ed3E(ARYc
H:GN)8fg.W?^@_ID[>RO6=;0W#/W+HVSTS)/eZLUSVfDJ13HZ3XLT])_HT,gb9Q2
dS_)2Zg\Wg.2U2F[04+CWBX><&MLGAC7ZBWS[B=3E.Y<S@JPcN<XG\NNATae0@+S
3OF4)W,e]Z<9]I+QLI1-RN]?,<R[XR=]N2;P1<W5K=a[N:6ZUAf=]0?d953+F<2c
gJ^\LA6MLZb,\T8U<_e?H:OfWdOJELQFT>EH5/-WDKF3bR;V0KC8J]-3,6Z8gJ)F
TB/M5]ED0NC6X\]H^g-<#VI9F@VA(UIA;-_+&99g,8MHJRC5cPG,]OD.Zb@YNW>@
<Z);IM->TOE)/;E?-KH@N_c)+A;d3BAHK\PQ\\8?P<5?GCbgY+IN]4)U((-QbEL,
-aP[RcV^^6P4F2>^Ba-6#I(f+5b3gHJRBW:/d[U[S7Q-A8/a2G-AM5J)NP_+K]af
,]L=N9f\E>HPJCPG]5WXETe-F&J8\.A?#T)acbIP-a63PT)LKWU<b&IQ7/K5I>TB
Mg1E_=P-AAU&I>S.MQMG.#=#WN0;\A.@<ADI7PGU2Z51c+d&2Jc&&[G+g6^b?VPM
IP2fA_H848eNGf0(VTgeS7f5<Z=XL&WPZFNd;Y#-;.;LA0Vcf-69GMAS9/Z+#f2g
LNdI27W&NE]4-0KP:H#^0)JQ2ZN6ETKg&H0=/G>HbOM>4RD&7R8DaU6C)P&?bg&9
Q1e;/eB6U>4;.@=KV&1;&/e=b3adO0@\-V-3N^cMYZ7,gc&#=[X3dgM0SU=E(bb0
ZB:,U1&6W2@;dGJf^(.B1=VRK>0f9^VIggM>dAA6fUT(L[6DM2^J.f3^f53/G0=Q
a3>NO&]S;1a5[bE+IgNcRQV0<X/S\QG@DX/Df)g7GaO]bX&A=Bgb?U=Ea9b1F5W^
07b8fHLKJJ89.T<M4O+6[RX#aOJ\SdDW@a8BN0D2Z#H1/P2UR#[9\@]Pe@Dd64GN
4S-Yd5)N7@H;MdN.(7H7)<V1UR9NO;=gJ>B]LdK;2_9^:1cb<<^__\7A:[CGF-CX
<3G^UgW9/;d.E#XZ(FE<D.V>8K+.gAS1A.PPd3f;CDVBA,VQDgGZS)/J&eVMQgbB
8fFa]<dDVXR^[<ZVcUTE-J[1G4K_Z7Dc9ZLS0:<6_ZJ;Oc?fQI4cY)XI0LFdG_)U
,5CfN/W=]69.S/3WWA(=f)P=5Z3[D3;Z@g<61Z1d(7/8Y)+YIBZ5b+JOU+/;<I7+
-/IV?GScEQ>PT-f\TcFf7GXUg08^Rd2?:.OBfVE1+Y+d0W_Q-ZG^F=#=9a@g8B9g
ffOSPb1APY)KTeA6TOCVL8eYACeG\1E2fSMMgU9?EdRdCK<Oe2B&DL<UMP?W<@WC
[-9Q0[+?;W54TPHE>9J8/N[UV/Q[1b2UV)e5egUTDAL:9]7Z_aEALGAQ?](?\SZH
>:]_JJ0#aY42[&0>K3=6X86.(V-1DY=GO6_9W>_9J?#4-GSMfSfV@Ec(N,MLAcO<
MB3_EP:,.727KLLGH3X0Z[bPc#Q)JPJZ?NM6A#=P]R7d.V30/O4<@#2V)/&LfLM;
X9^\K>KI,.(O_J8X08=eW,YdO_GZ,SY7e+B/TS5P\,1_6(4.\6,4_)1?5[?aR]@Q
J=L)3C81VJTX^gTL\SX<d(Rb)^M:&-be8]85b6Y8a&]U#Kaa468Gc@IPF+e6Q8+@
XBGFW:^<bI:SJNfc#/?GRAc6>W[Jc\0#KX];LZ39b<KEVKHb<4FP3]/WN]g4K(1=
/Ib3&=N0a;b+S9OSJH,\Z5(^UDg3c4;,0)]#J<V5],D7\bPf@X:54H:G.^#:dc9^
JOKW2X@J+>9b.76G6fb3:N^3OVGX)+T8eeRU?Z0C+9EbE<-N(9bX<:ZI&OG0b=U4
b171-3&&(2YbQRTSPWFB:0Ae7Jdg32S2</cL.KI-EcSL]@eV9aGFJP\9dF^<WY_<
:\1(cag^)KeUKLD<#(Q&IE00?6R);e6eIL\7&cN#T)YaV?:b;3\;J<,CL3=+J)HI
MPKR,EgVE;IH-UA4X;--4O<K7_SO#e>:P8MYPbTZC=JS)W.OV;KZ[NE,aF>gD>4F
dJK)9UU[8+M0P3HJDQGefI3B\gF9XRN@[.#B=C?JH,3Q5\.:d[>7.<bS7d-=A4[1
@E8KB2PY2,0d<RV):e=3=7?=#GXEeF=56M#5G9LVIGf.0<9LaY,92^^Q,BR>9;CK
>]dDHMSA)UX;2-N&NQDPdLLVOfV-_VWa>H8,RZNR.I+R-bEDa9aZ9@J:N&O&.E;R
OZ+]O:cB>b/a4#F]fI#-6WXT:\bZ]eYaRH2XI@;XEMC^WV2/?E+K2,eI:X9a.;[e
b(87?GDM3#VMDAVO4C(GW3O&JR<NG@YJIX#?AKZ0)^&[Na=7?g.2M6DSI]RIE6#2
9UV/#:5HKGHTLe<X4H;e&]b\Fb?WRCEVLe(GNV7#R99[)eBd)72TZEEA<O-.b/T3
1a7f#R.6b+RR)6IZYQaXPNE8<&.4I]^RV2U^dYNPQ,Y<?K0^L29GgUI/[-f--R\T
CaM9KK7gAISLgK:7AHe[6M(LL&_b=B2<G0NJ@P_:W=#aV_9M@5G5;bHWI8M;#?HD
;U;=S#WQ93AM9WgbA-R-F<C)A[KLfKPR-W.[GSJ]GQD_JBE:>7/RZg\5N;)CG^Rc
8K_A?PgJU?>bUNYG6\NgI82A5@-Z_C\aT3WYJ[DZ,EY_V?/Y<5@)G-.KFY6?IeQb
Sf.5>G34A:(g?P50\8,RR()KaVTOCbbH:++@J^)S=eJ_=9f+I=4GGC=\aS#HHK?E
AeY0#2#3F1.5\A36MYQWb,2.JA?YI7a]+FbK3<JMaL[HFC-,Q]C8.gU5T[CIZ-@Q
1RV+]>e5Y4B>>:cCWX45_=^c(:];Bf68+g,aT7Y2Q9K3[4YbaZ1-e;6^.(UB]WVX
Za_gAW+8GfRP@\\(#ME[L?JQ#(>dJ279JW9:C>P;377:?VWKNI,H/HHL8_A;.^V]
MYL,Vd)@M:;O:U2@@_FVYQga,41+G-C&F#+,A]RPPc<UdJaMZ0JO#<_aO/Y\JUZ=
2EPc7f:-JD>OF@14.(?[IZXR8]+AKU=1.7F^6?W3\K;d+9JH@8Ng,a+&JVAUY7O-
#?PdbZ/?R:;FFU;L)[H@1;HPg+5IWg][/F5_Le@]6(\^HGPI@0O^VXM[0((,I2-g
;85cW7_R0XXg(]8e\SE[8JYU=A@1/&3-<+MX8_PCC>[+N9^]&GM)d(dE_Gd)??5:
^f>AGF:/LFXO9&:1E;b1YICbWQb6R7.d1(C?g1>+#&AdZ90_&1-U82KGB\BTL#Ig
DCg[-OQaFdGX.87VTL>+0@,=/OQ+;D>bV&YP/\0JT/B;@]+I3BegH8Z#;:X&O1Zg
D9V]8L?X4URX0,N=F?.+32:A#XY5Qd9e#P=gDF@PZUXEf]&_Q^]@]c46b_Q98XI5
Tge;IT]?1YR+IEGSaA./=gA3-T+Z),49?A49cSgXP49;KJQ13ZO:+5F<7-CfM#MW
IJ_0L7/_KTa)_UH&(2H@UL;)KY->I-7^?DUTYZF4W?7S.e.)Z_J8g?Zg.4N):c\/
fEC?aSWQE1WB&?1J#XTTIB8\Da0&S(5)Q100RBB9[[B5^VDgBL01BIN:RQg)Y^<V
PD<28?#U\HU7B4KJ;6YU+AaEgCEAbLY>g4S9aJX=;bDS&b.Ra=D>8]gdQ7C#(d14
f8CA-1^Yg\cY^WCe9SC(Q((XX]LRNWGIAWHQXIZg2NKIL,_Z<(_.\JI=\F5=3-e@
-+]XOEA@1L5ZJSHgb8&9_N&#?f.L5RV8c?FdWeE5]_ad]d)fPCX>a/+2T]1S0QE4
BIPADNZTZ2H.&a49Y:_?f5d;8N8#a4g[B2@XPCJ7,AC#a@UeS][KW8E;3?L8<+]U
J2M=Ed;47MK^NFJQ>X+<bE04cI,)<@^4c@Xf&X:KC6-a_TaZ3H;gQ1^.4^W8A9?J
:YLIe2_.fI:02@2Y?=b/.,:_Q#=1Y:4@4cCH#_F^ANQ[,N_3LDE:R9_P-Ob&(C>#
gLNGQE(B/T]);+Lc\^B31aF#QA;&5X]CD5\d(PWMd&RDH:1GOa3S)IdVS8[g^M/-
D4RPM+KG.,TR#68:&+a@fR+?M)\a[,L(;IKT1U36XG5S13)09I[f;8M]ZOJ8D>8)
^E=a?N9M)#fP;&9L]agA4]Fa-M\],4XE/,.CJ0[80dTNBf6]/>[/T,TML2NZH\X#
)c(/RWd2>DXMbDTbEELa0UR_I^4_QDQZ_N07REa(Td8FF?J]AbX2SUdV\4?DT@:<
TE\P(TXS.D@[16#UBSgI+g5F2A9JTa5;HK?ERK(9S=fVe.;B--L02:[(9JL&;aa@
1?8GCGg[)X9HVH;?HYee_N?JT,Pd2^Z->)<5]4M+V8980\CWR>V,SO?WdXE-4C0_
+bHJC?[DY7>JR9Z.\)3RIW)</GJ,\bgL)2e<1ANf.4E285.3)1D<_RE\0KbYB^GF
+<ENf=:LNLd\2WfS><P-THXI&K?,R/--aKM1cPXI9#DP(?1BW&LHG8:<WRf=G:(+
)bN;H7Ud^Mdd?BYF(;Xd-&5+_c)-eaFOa_(DWNL[.F_-0Q+Id5g-,E[1W:Jb2THY
\KQ23T_3U)4gO4:R0f&=)QbN75<Y9IA)eKf82WXUf)]LYeW_R_^7_/(_Yg=0AFI[
6D<YA]4a)b+Z#eQZ0@Af?IXKMB),W,/<@TM>BV4_+L3HWZP\]E=3MB]a(4?KJNNO
;+Kc_NgfY1IfOMU11PE(085.)=KI.,cC:9)Y4/#&F)FYM4Wd8#e1]FZ=DF/\9c)R
2=Ye/acN?5ZH1<bNUgX@H::XI\?dR8H(@A1cb<YY7Q^:PLeg#b?=\#_FBdW&\3KS
2](0SPaD=;;Xe_D9Y.?Q5C?d_UT<G+LF]Z>IdaQ6[g-&J]<GN.c+9]]c^K\JS>Nf
-V:,SBZDB>(NE#[:b9C_5;86^T-.&YaPK:3gbT]=2P8-/S&b[<&AE](U45A&=c<0
/IVcDc@FZGDU3Md+[T9YE-()FTH1Z0B[RT+c0C8M2R4FAYa4^JO@#0CN3YDVXe@f
7[V?\9(SFN+<+]_:?G;1#Wc\UGBZC\40^OJJgL+X/;C=3&QNS+&LZIV,,dYOQ=TM
D:#_?X_6&J8gI]E3:=Y[(08C8F5cFE2e=a=FF@/L+W_Z]]<V9AD7adG]SLfTg.@^
F9(_PED:aCFb-47V<L[\./D6[[TeJTGWaC8FVD94__+@7OSb&ga&FY+7.d\ME4AT
B8gA^6Z#,3Jaf-:c[&]Oa@RSLT2e6ZTTT)4f<AY]SC&T]O_/C1.&gMZWKO>:_C^O
5P_aUOWUT3;8Lb@EYS]6cbF.f/K\YF],?ZA3?95eJ,#UN#K2Tg+<]GbA,KX]Ta:S
PQ_&Q+\.OG(7MPH:BTLYO3;3,CGS8ZG<VU[UWcBJ)ITdTB_Z0R3Yf-[<=QINU-P&
5SVOC(<R26VHVg-1LP09N_>0<P-R3eHOA#5V8=?1;2EeTN;1:9S22I6UBMRT7?MU
6176^EGdb>,IRFd_YPJ)b.I)0d5-\1PA0>M0X6+gO&eYE-5dN\cOVL5g;X2I9XYg
,e-SN@3&2;WE#>M4(/1JC:TE],.VC1ZOY[#UBU46H[d49g]MPL2]Lfb(W1Ad/=;+
c2B>8-;T2W83-,ScZ:Y>BOXO;T4^Kf3NV:_@DgK=T=+\6KT11&JIAPYD&f8H,@?[
49A>9YE:JJe)6921G;[S\13)=C@11\TBc1Z6OBJZMf@Y2AW]F[5VTCAdC&3W58\N
VcUY/9,C:(d2.F7#OEOM1edSSgY4[\(b00Ce<N=._<WEe2):SgA5a^\,BS1Q=YO1
??0>926eZ1428SG.)YY[)+0\\LI,]WECZU&0:THf&)IP7^^[2SN1;Y+MbP_K\1>;
F;G5/0Q.6f0X.4&E=Ef-D3NKH4Q^JX&_44<NdV^VHLNQ#=D>>]8BV@V_dW]#6-.5
UV0U4K)K=1B.E#XE4G9>(PPYY.[6=f[AY>1DZU+(HXV:bGaR-c0G^>Z^MQ@CW+C/
7/KK+,T@MF^bMT75WRgC^+(6-XEbe#F-]RI/@85FJ.W@#G&7-=\0I1S\Ad=BLJ2a
\,SB_@S(3;N?,=HLS-WJ8c&X(I9THb?8aLaB(7]IA=20WJaUBT/MB+\(,a_ML4D;
1a.X^P2X)5<\<VL#&9AeH)&X3$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_MICROCHIP_TOP_REGISTER_SV

