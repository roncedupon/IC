
`ifndef GUARD_SVT_SPI_xSPI_REG_FIELD_REGISTER_MAP_SV 
`define GUARD_SVT_SPI_xSPI_REG_FIELD_REGISTER_MAP_SV
// =============================================================================
/**
 *  This class specifies xSPI register that holds mentioned register field.  <br/>
 *  A register field can be distributed in multiple registers. The valid
 *  locations for register field at register is specified through 'register_field_index' member <br/>
 */
class svt_spi_xSPI_reg_field_register_map extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** This filed specifies the name of the register which contains reg_field. */
  string register_name = "";

  /** Specifies list of 'Received Data' Index that are valid. */
  int valid_cmd_data_index[];  

  /** Specifies list of register field Index that gets updated with respective location of 'Received Data' specified by #valid_cmd_data_index. */
  int register_field_index[]; 

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
  `svt_vmm_data_new(svt_spi_xSPI_reg_field_register_map)
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
  extern function new(string name = "svt_spi_xSPI_reg_field_register_map");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_xSPI_reg_field_register_map)
  `svt_data_member_end(svt_spi_xSPI_reg_field_register_map)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_xSPI_reg_field_register_map.
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
  `vmm_typename(svt_spi_xSPI_reg_field_register_map)
  `vmm_class_factory(svt_spi_xSPI_reg_field_register_map)
`endif

endclass

// =============================================================================

`protected
UQ9&LOV</c9S;/W47.W=J.K+>0gD8gR2,eVU@Q5)L/#.4LBLe.Ha6)7_NZ<O50B2
\<aAXSE52+D+3aG.,KA=)1[2TA@.#f]UW76(.],7b4MKX8b_[Fc?f?NH,4KVeD;5
P]DZ9Z;2;,aPEODD:<8V5(S[,+9JVA9;-,];QOR3g]X2/LLDA&X+G^X()XOc[110
8&Pg>B0Ua:ATf1[(GAJ-,4E?MZ+cc_0)ZfT2a>7AC.PCV@Ncb//FK[/7L_RABCG>
-/]U?S]:,1OD32@1@XWdH66B&Y>(HIcCIe;R-Vg;OOW+RQdM&MVWIJMSK6_5e9K0
6AE?F[#),<5K4/=&FRSfCb6+T6USCC5b0=d[d@Ygg9eH1]]WP7:X(II)^U,.O.ZK
F\\->JV5LQNUG>0L[e3G4Y/O69),KfR_SZaeRB[_3X)/>UWFf>P+^QM]L\>@Q[@T
=QE2(,Y03=a7LWBJ&Q3,Ac)RJ#5NTAb.UM09BMPU:VR_8H76b0A(Y-=-C3BF4ZdV
)EP^DJGW1R.R>]@)^g)(NJfNg&8c]9^f-^1gKKPRLM,Z,])8PJJQKT3&BfWUF.7:
][\H)ObY7BWAOSb.FYa?O<ZZbH5WbA_^fgAWUF7]_9QF25WfH-W#cA8QLaTV(5YM
P\BV=32+G[TYB2<?48Tc458ME[6VMG5QK(SBW_Qb?d3GKd-5ST,0CT8QP$
`endprotected

   
//vcs_vip_protect
`protected
<Rd1+ZLOU&LGED.SFE4[g/&UIUe_+^K->U=AM;E[_E>+E,TT_)2e3(?>^I[J+<bL
LN(HV[NH&NUY6;dU#E,Z[G=aDfBX(cOW<@d9KPSH:37FBXIFEX1:5DIe?c&GI?RI
H@G/FdPT@g3gM<3A6AB]g[cGEO<)f\K_?8,_cKgbBHS-Z5::e)/M?Q(IQ?\_J;@6
YOAK+@<M:S@/Z<K63N^a<)X3)deLC^GfGK)S<NM[RI^Z_a@KBd)-gNCXR5]>>PaY
deR308:OB+7Le+Od^,Uf=AYX^M0V-,;A3&/KCe=c79L(J:VeZ/:eC2#1UI\(TBL4
d25fE4198FUW5cUg:NHAH?>c5^4:U-OE^OGBdcG0@,-]PI.CX>NRS8I4KL^R;K=A
9RMTUS#\VCTE^cYd]d3D&ZG?D&)e>+/>M3I[(KMT:484GR9_gBf_]]a[2HFdW[,R
dOOB?;7dU=+:ggNDF,L\759XM.NQ1S3Af/Vc0TJ:N<(D7g2e,5LG2P^[86I>a<G5
.3cYE-JNZ;6W.-NBN_&JG8P@+aKdZFBcdM(Sb0X3)PZeR19?;14dRS7793D229D2
\&V[.4IG<3(FLL-L3NJJR<KC:IA<W+MR_g\XOe4B;[9<@[K&g.aX]D92C=HW,ARa
M<>@H4),Y#5#Fd7^&?aY,?0cCR>[3V,?aP2SdWSQ-,,Z3/VO]H:YUG@f=[II[c86
>7Ga5@>L\#\^95cN9<CILZGA+_(4cD5?+N^@CH+7_^EJEL8/F3BMPd-V[,\Zb&XO
(A?eXg7:K<M-Bb+7W4?PDALI8ZR2H<E4Ub?\SLd&d2+/ePMB<17A_X)Y]La-F2FP
V&\+44FQcH<#L35Q=<?Z+_E,),c(F_,05b1BG-BW<C94d?;Xe/A4f1X08ce//PJC
,=NL)MgbG=/F]L&Z9?[^&U)ZL2_f[+YP6IKOBTSAeZ:XW4L@1J:eZc8JfY[WY:XC
8++T&Y(P48,F<61\Y,eBf/VFE,F&W_BcLNUE/eT]9ZI;54,J4G>,6QA;S@bWU6a[
>MY^XWV<aXZTJSDN7],aKFNA47QDI?#QO+TA[0PH<PM>_5QC7eS_=:I&JG](P=af
_9#I+WJ&+C/HNZPW]0]6e54d0[S_gXR<?=J7GX2R?TR3HN+A]QMI,bY011<D<T\-
-^ZcZD@d^#d^C1EQ+P^_/d:g]Sb?4IJN(M??\-)3J0JP)LZQELLd?V2KHGIc#gRG
GUGS9Y\/;Y&;-]GaWG/4-7H-\M&GBI]S026JY2[eNcN/XNJ7ERG?Hg>-/[]>@VM=
-?c)g0B&c7W=f7)3OC1GV[2(6>FS(-d)JHU94?/R6AE4[-_Rfe>)J3JYTM9[EIRA
[38CEUC0OT58>0_N1;dVcYC0=+F<eYE32?]4-(9&TF+KP>(P#P<4[Rg?G&^A[946
)RQg_))HJ--HHM.(543)(CAg3eEHC=-/A:7F&\\aN[CXWPGb<=EKY@IKV<IZ\Y3d
JfbcCUH&H3[@d>g.Dg6@FR7#^H^\=+52g=X8^<d/Y)d0)C5V=@@MaFc9ZR-.Z-Y]
6\.?>,O-Eb02ZYd,@GEZ:1cJ#bG/CB.4LCE\Y.aOL1P0[(9)3cLT]B<4XLJD]9W,
5.6;L8,9WCSD_C]&+f(P^T]2^KR<BR8C:J)Z>.eag45+MFB=\ca:9O02V^2-P4DD
:HG.;6+(.NgQVW5D.C7XKRJGHJVS<MXGF&&6R-II109c9[B[,+=71LMPV<V8V1H=
_)/T0#fSAD6=B9b?\Y(?^_9Q856?:M<_GZdg6_6[5>14=DYLK<2ddE?G6AcfO4Pa
O3+B2FWag[(VJ0RRX:RXXH>5bW/1G_8CIPGX.JecY&)X)@,A]\-b-YN+0g4,7-4(
b4[Q;/Q,8+1Ef4B6R.W]L[K]NGYT]R@3&;\abJ)I[b87/416]e;2LGRTIY\TCMfN
UR.d>M)JBFM\1QHQGA?,=&:S.WeVTED:-S=T@DEgGJDY1a.XFV8cHbf[e0@;C3V]
P@[.30T=6S#YG@QDKa:OAdg#^OK<?VPb)@bHBM(dK@e];>5TJ9.CZF0@^#XdCUc/
Db>@IHQ[b3G(G3:(MD0\1P?\/<75N[[YK2)IIb5DCJg)=I>fNDS^d4[,8S\^AK+/
WHXTT+#D&W)VP[=U8=He89#N)e]VTaV9COPF86O..:S-2++e+GfGP(H08O^WY1MY
M.VfdPELOSa()&LQ9#6aW@K)BX?=-7G&Y4?[]<18?]#>Q2V7;>&)>cZ#VLe2>7YV
2DTD.b/c?(H\:HPcNZM>Aa-#@E2QgM.MLN&<XeT_BK6E>cFRT,]J.G@TVD_M9JJK
:<2C^JbM0ZOOe03X9I^[CEQ5C5+5-R6cSG_VEb5cW(Q>9H<UQORBcaP7I7OL19e\
W=]:122bXcFK>0P/ZDRB5?[T3V]E;MZ--,GSHFg9/3I;/NDBV313<K8,<48G;0^D
/#bHE:FN<HaWK6_AE8,&;CU=&gX52STf>QGP-F<gb91Z[)L&EF/:).g3F.W2MU&>
Ge[Bf:K#NH]#-IR4T]&b<8;S1V5ONa=)WKL8;JdT75JFCeK#[J2[BVE7+N+,U@=b
RU/7;d:f?;D9YN;A72REd?<S<K.9aW^J1D@aA:J29)0BF0B5D:NHg-2?,E;eX;V7
DV)2Ea9f09LJI;e.gNP6=+D1=f7_^U7YgIfR#1@A]d?N<c6,K(VdA;QK6W0+NA[g
@E@[YL&:&HfZ0Q7@e1.Xa_[@R&3U?AT+cHQbP^/CL[#ZKNb/]O8YP5&;2bO9RLHP
32#26eR&W--ZFX.2b[ONAM\\T=5.LAE)]ELL7]=dUD,22bB8fM+40V]H8fA:_/++
I@EV[NHD6[VCNO[Y6^2Z]Ke.dZ-CV?GPC4KcLDX\<B^3;SUcB.AZ^+6]\<NH3,R7
VO&g\&)[8C<bg4b_LX44LHQb:WP4/Q#\b/>2,P/5Sa#Uf.bSQ6+L\;F;Y8]UbL5:
W^,/>2@Y^\-T6?gJMb7F9,U.-b<0E5[)(00P9FX]#J=^D&04^4>V?FB:)-7,Jg9X
,g4_-J)P<\Z&Ue29T:-5_HJ+,CV/;,U39]87Y6Q5N7b<7cFX:9RM1db0Tb/G7[Hb
aLHG;e1YV0PG)(Yg3<OB;b[UI3VLYAfY)DQ>8-Q1L>CV+Xf0IG(f?fE]&=gfWL4a
b/I,&);5.C1.N&9?,,4J;dKI02Y:V@,&\Uc:74RB(>&95^:BX+gJa#6ES+961;:[
NCYE#P<1)28RDQC58L_YTRQ\B7-#@P9\eWN/XDH)08+K/c7KKWeWH#(AG7e?7BP-
(VI4QRZD@:([](M#0Z7K6J#T1?;LESGH.760@TM[T8fg5.DVL+g_G,fb>-_cJTDD
E@?A;BB_SHLH12Z]L;6=PadMOYHSVA]E3/ccH#I?e5=>D]1U;dIX3.4\@IE6dR&>
OX@.[Be.:-/#4b8QEO0FS#&FBYFA3&aLS:\b-&KS7C[9OUZQ:Q2\0R7D[e=MgRS=
5gAN9N[@Pe@0c5S\YB/5PJ&9KA?/RJJ6cc=gAIW6]LC,0dF<)gN6+89F^WQ\gB87
a,AH?YX2_3SC+b3(M@+YLC0(VU-]=(gOOeaeRXCH)_I]WQ:8S\KL0g81_D,N</E[
655OF9:^Rc0@NC?4\\WV6Z7^NT4RC\X-(>Ug]CfWF=N9fc=g6-V9O.6Y_D,.(=RP
QA#.5DD[F6:aWHG&fE(97D_N(1a\D>@FcUdT?.g]0egF=)8W.ebbC=5eO(2ac.fU
MY^E\K+4,9d6WLcR(LfU\N)8MSfDF7>?WH-LYF#E<R4LY7BeFA=BR9I9fE_?eH3g
@E-CDK6ZH<I#YXWT500@Z6.CJea,(E+<eRP61LC9RC3XRH-F&J#8ZYHAC)M._;=a
]L>ObWSe(=.A7c^HT0@:[FBcL=TEK16-EK(PK0FTLFLDI2fE/g7cc>g7R__JP(HW
Tdc;=ODE--2d@;/=,K9d-d@>[J44TU/DgRHf(U-5FS8E-G6R?&T9PI,AYF8XM>cM
VYW-.Yfee/E>J^I-G<JJ_#4/_g@Y]eTKNCa^6P8W5G8B=S=FgCA&8-I_CI_\/a1S
906UXJ<DcWbZ(,f1>0?7T4R5:b0SL3=Ec(QZ2c_E7\&8WGHG;3^Z-1Mf0PP([e^1
Cd)5\NTC-IJa(W#/42Sg#gNRY^N&-Z>_3bM]:,=3TWI=\.\K:b&P#QaRKS/W9Jf:
-f8cCZM1NY(;/-/H+6#eD-?5HK3dA@U)JE:379>gG4?_4Tf1fGa>c6T=gb3;S3G2
&,H&[e_T7edP?@H8K+JJ,bT2??/[EPEfB,fL/J8[@@9?S/d]@_7V)+QI^WWdB-a>
,6+YZSJW_E<P\2RO2ZH0EZBe[(c\b9:ZN]&bPV=[Y4b2\OU<+ZF4-.KeTY)UKM1Y
7K8ZUfIW7,6KY&Ba7R76BNg7UE+;8M<-GK7VT6T)3fEITU[D4JCXV\Ld[.X8VCJ5
UaD4;^8,_4fB:Dd7A.0<HQ^-TP3T[X?N4gF?375Z95##c/H86/.:QKZORU5b1BIN
a5T&_^.RV=-+D6ca\CV0S[++P])VRG+VCZM-J,QeTMR:KEOWX\=ba87b\+RNJNG9
PK\WYSJI9H2PT]gO++O9>-@LF;J]f(@4Wa-HWR.KGUdV(,-R54.D>#??]1<d]<PS
7dQAFJFeE+X:P/=)>6cNCQ;V<F,d>YL/&<ZU<B<.^X+G8V6_7H[?S1dAIH,2Vc6b
7]<G.JfUdOG@Tg_<FD^Q/VN\g=GX_-QB_g9+M&9f,7?:RUgU=JQ;/^,3dT5[IUH&
]KRMA[R,Ka\7Db=5[,OFJacQWc[F6WOR2Y[,)V\L]TD<Q.5:^>8Y.N(6]f6WCTPd
_;_Y9c6S:)D1g<K:;P1J2S=8;,Q_>=-.g;=+6J)2@cEO2da>@c-;LfA22?=f:@c7
MB_2O3EF(QBII&>6BG\9N]XbLXW7.g>O>0-)dH0.[PO;#-[G[A&_QXB=A#I30c;+
+g<c[YAZ)a+c>^&#9F?E7gDD]38KN-Q1_6dL1P2-)<CR?7,T0&/LG-M,AA,X\-b5
9>Da=e@#&T>V?2JeH8=IEa7^51./e]:\B;.6dNI(+5d)T4+N,/d-D,S]6.8@HG95
J+C55GZ^=GMT#=Y&49Y])PV.-WW\217Rd+0V]5O57cb+9\<4[XG@9M;3d;?\OZG7
S;D4ABPH5KV0ZE3(Jaf-[=)Z@&6OS/E7LZ8R[&Ce]+0<_(eE+>VX+T(&CLUOGYGY
HTR;>Ia;D4YNId\c;RH6E4NLYXS>ObWX[Iee3f#^2Y:d2Z[FW>cX6=JNOVXa;F3T
OM=S:c_2-@b?W0X3F.43\D/O1#GL5e]8(99FOVM8[)/E(1?#gZWK0/NHX40WT=(2
:]+,N:G3WIW@O-Bc3O>^+R6=XHDZBQ1,N0fZ&(V#FSZFT\[(XWc7c_M7D4-SMNKH
[P>W.O/RJO;CDZ,P&8._9(.6APe+6)Z;GUK0#M;D&-\BT<J=NKWU\)FT&;H[4Z(_
]-/E<P[ZTb]8f1@2BKe&(,=,(_I5-RY.CXFBN/FQ<9UYg;g(#,8V_WTG<O^TB5cZ
DfScM62Pf]OQ3_>D^P43^Mf]7):IIgQbJ&9II9GE#gc6;.2RJ;eMPP5a9[O:b@#a
4#L7^.G2;E]f,1@B(@M<+DD:-O4I^R?PTY@C<4fK&HE5J0=HPdT\JP[F(0<K9(R:
R0EY?(2.@AEa9L^]H-W]]JDCQ3.cU&W?Z:[9LJ9gC2VF9-,3Bg?1L5g:)MC,<WU;
T_gTLCF3(+-N<R=5M(e]8DC,_X(Q+OQOafQ]LH9+L_d2/QF.JYFF@JcX\LM6c.\=
R.(SG[&Q6T>QK_6CXUU9L\Y5XgNC2b[b?DY\F14<163-+)Ef@/_T)9B^]SWO;?EV
:/PbAb\>4aX?/DF1\JXE;aBS_^E_dP/=VB<_9O8aG==.?<F9O45JGLXBVK2XIOJd
gANYA0M#a@GSaR;W0.&_]?+bX=WC@NN\WW4Q9Ngb=IU?]Hg7MO((?-?S7A;cTcg?
EfH(EL\S5-C?(+XS0PdD_M[_J,>:40O-<05R@,UfN.+^[a[e<Ee0QbAAg6g786aN
ggGR+V46)LA8R^=RR:(-e4P1R>IN]@^@6:>KOGaSEU,P2>,\RJ)64GTJJBNdT=8J
5JA5+\J&;5cgMe4IgNE?c5b3,V9=E<-3JY.CKg^<0;Ce^&-+#HS^KK&<A:XQ1ReW
@<<BbXCYNHaGBR?[#(^>G(-.B46,JW&>>X737/[QIbC1Y+S_.]a6_^8A()dM+UU[
)f@0BF7&5ZWS@>G90Y.bFP\LA.T<X?7=C7CQEYT5W<UMC<X>=U-Pg:KM_c91+f>@
C;UMB)=KJBY\+KP\WH87d7GU\.aZ7KI-#L#]QA:L]LATMFRL?HgV@7BAFIV@0BSV
a-]>)SA6<9@aDGPDZ3Q.\CdQO:SK5ELV)\R0AN4(XXV2^U8A(.VTUZYK:Ed;-P,-
;_AAG\V=8)YXd?c]AA#,O3#MWX1T+=1J@VH7QC,S879eYFfZfD<YOAW5))^V7eFV
^-a:,f-(I;Ga/1XX?Sd-P:7N3V>eANMTH<)H#9G#\,<W=DQ<:]UPE>Q=>V,[#AdP
2g/0Q3C_(UCBEP2]#Y8#&e]?L)BBR6U4a2Pd@ae8>=W<M;BZQU@#/)VFLeRIVd4G
b7JUfU6NCX-GTO&+Te&@NF1/-R]24B;_aMcU4URA.<<F5<+C;Q4:+=f65H=EAeFa
TX_H1Q>]UC+]Mg85,7P>N[RAJA/7M82MF&c@M3A@=1YCH1KfAe7&?gH@G8]J.5d_
,)[[V7)G4LN94PH1XORBSQ[V:b\b=eJ#714-YO5-+QAZ\]g6<[ZUOQ45?f4CF.Q&
Paf4Q,Lga0G7>Yg\XJZC0D6F=7CNE&VJfG0_9aVOEU(<Qd;EHX_=9G\aaNd45cN3
6g^3SPT.\CZAN7T6+Pce0XgJYMF;S4cLW^D+LBTP,<,f>UD3G7P8Y[,][<1-+a7b
-:S?#5JK<JN;a).fZDdbbaBF4;P<LJf9/#/ZBHFY=F-6,I25XIG\PBS^/+@EJ2d6
F:XCd,Tf(PTe3TeEITZ9Z;,5VCcQ8XUOHOC#Kg2DAIWINDa1Q&W;Pf8;#-@J=@@5
+XQ4GW[fOR076=2;-eYJ1-Y>8\:I#^RWZTO0Z?5LTXHCf:V^6)U;7T5bQOD6NXH@
\=a[]G:J/cgEB&G+9A)<P4#=ZF3R,EG1E[KT:H++@daZW67GQ+D6L>W\>g7G0032
T]dOPb7[AB/WNOV2f&1C]4;Y;)-[TSYCON6I7T#_L6Sf+;Y^F=g#4]=-++)??(_K
MSa/c3X:]0M>eO=HJ1.<>?U)PMU:J(A)_&f<Ha<56?YE6KAJ:4fX9N;V,aSU+dXd
E\>2N^GT;[0+6e6cU]P3,&Ee1E7-U_6IX@T7@eAf:b\VX6GK7WeT&gG6F\IB]7E]
g=.g2LS1&\CZYBXba4I].6&@/S+8FgK#fF._^BVC[@.@44WA4H\2ESI7UGQ_0&7@
&fG(5g;?Q.B8Z3_[/0C41-L=<TD0[;XZP5/TfXdbPM?f;d>75g^5\P8,Y9[.;#4c
^b]3eI?gRYPXSWP_2&@2;#.YD@X@9XQZK;Q=)FK]>M#HZZY=[KX0FcEg<93.UI=d
N<PH;EA+(0WDT_Z2L]3;0Z=R0CITTJ,Aa1+U(aYcM>O7=YY39_G:@6U8\a-eYKO4
88gD)&bTA8FXFg-;+cXGe@dNS9OS.3MFbZBHSCQR+I<UR@UU[9>]]f-ORR20J6X]
)aMOe9<@I<R,JWAEK;26GB=8HP+X?@eVIP/-]IIa7V=N:F>9dR6@^([#]HL2a>8;
K)Jg-UG1cN4D5bdW(eM5-KeV?#<B>RL=L:9N<3@K3;QI1g?He7F8\UG8KPIIU]Ca
;5+U>FVCUQZ-@E03+gLd-^<Y4e5AP-dTRW)<ZM-VIa0LXA=Q4bF#S).5dgVd@#B@
,@1D3(aG8#2/C2U]O0BEE/&L/#SG(2)0TZGIJPRQ8-H1J3H,.MAZ/b@U)F8.5QS+
/Q\P;NP7[[Re@\;:KfS&0e6^99CNVN6-edG,8<#GQQ_)55/1dZXfHa0e[=+?CJ@7
R/-D\=0MFM9OH[K2AOI@293F#[/25\?SQ;)AOSA#0f,#D>@]OI,)C4,gOMgcNPW8
>=[O)+6<^>P/b&S(RZFS+RM^#Oa(VZ^N#[(>IGR&5^\&[ec&G4W4Z:/FN2VO437W
+:#R[<9XZ?=U<Nf.I?J(7;caC65.VR]K#a\U)\N>K;ZB+&_E(+4PX,.XeW/cIFWg
bLLGR(BXS^[,>b8F8dUNdgDQKZ<T-ZYYG=f\(G;1ET(VCH2KV10H<fG&I,.S3WUN
VET+a]M2:PT((AeS/,2J<Q]1d:/8NUI>IUU;U6;^1geSJR.3D^^d84>:gZ@OCU]g
8GDAB>V]fe@G<R4DSU6>=0141G3(J)c1OfBF</)=0HD@5[^804B-1#eE9f#JW=@b
^+:N;4W>]&XYT2QU_T>SEe\9]FKB(5ALf6:1fN1L0\YfNf8=[:?&4Q5IK]]D;L88
PYRC.a?3XU))1W5]VQa<CeRG\)?gIE,g]U?Ic9+AI3ad=OD/1(Zg?NNDb;c)AgS)
9&fN]7C[_6MMG=?B/GS5Z^8M:ZC@#HefFJ+bC:&>=Rb&Z[\^KMY7E]<)VaN\7Gc]
3+[@:6dF1-c0XP:[_c.)IS\(XRQ47+_Bb_gdHVd,3Ka#6_e[e-S0e4\cIZZ7+bF:
UE2EG]bR7cX)a46-,>^YaJdUb=LXG:UbbKP06?J[;:?I,HV>2//:GfOcD#b=51b,
e)BF;eHR#;7W+#VOcc#I;M.#U/V7VZXIQ/)X9//2II^9_+30<BTA12._#)PF<1>D
9ZP&dVS2TM>,=[FbCb63=<>f9LQR^8HMCa)[X<58(9PP-H]L+.W8B9gHQeR:/M&G
=e[0^(8NT;YZ>+MbbW#;LJ#77YCNeb,PPWfV/4ed?=1NH>\f?@,Lf@OW4+HfEIb^
@,)M324731>MM]Nd?7D8=VE-+/RYdK<HQdJ,AT\W&>bTQ1L>?A1..J/<SXg6X2UQ
8^#\WV-W?4K\7E>]E)Cc8H(N)N)J/F2^NHf&-\:F4#g3V5&[,?LdO;U&L9WPaC5<
.7gHEf\\)f26eXBf3/29,YW9G-2B;G#2K@-@:J6)A#@OO8?,:^KC.=FT,PA,5HcJ
IA1:_Y50?D541R:]bQ6BPC5;3Z?c#J6ZTX\Y^_]HgOCUd^.8D>[+9LJHaDN_SOJ-
4HU)FDTROeH4[[S><\c39[=);\c0CeG9XC)3Of;b([,6L:O42PF.M8=\SW:)E9.a
C/JZ&=HgWSK&cGKcGB9A_1V(&H2F=UU64S-8\+4UGBZMTGdgcZCFQ2ZH8Afc&.gR
b/_d)Bf757J+f^f?L^/f/1@4:;PH,<(6Y=b69bMP)@3Ob>#3a-I]@XIC4OX3Xb8/
ZH?a1fE1G+/d>+_[LCK-gP2a/TGfSgC&)ddRQ+;O(g/[>ZD]cG[YE]aF3=PL+=V?
:&9gPE<+#A=b?>4+[C_MGD7_M(,3fa:2]M<V@:&52fB&UQU=LQSCP,S9g@[M\Uaf
R&2N?DE</LD&=JILPAdK6Y_1BL0SZbC6P?gTKA6\>@.SWNB1<d_OGVY23[1=1/4V
>/1)g08/d7W,>E#e<c7SO)=FC\<J4(b^Ic.Z0Za^gTH?:69AV&[JI,U>@5:NHXGV
1MC.cQ7Cb.#W76fF0G:b2M7U<MBG1e9CQPAa=5XD.f[AHBf:=<RMgT+,\3>XD_]\
=WEdT;O/c0QGd_+F-Y7gc-0@5ZT<ERM\6_7^2;#OH(&QX7L:^gAB^55/?FPCFEJY
[G1UXa>,Tc8XZE[+?c7([1b4XNIg026b@TeQ27a3g59T)(]eeBHC0b?64B>]GH.,
K5b\:+g>V,5a_1?.ZJDZ\]Acd\?>.,.@6_H7ABRH0T<Z2F3L8E]TZU0ZEST^dHHS
eJS/9LXF5#HCOFHC&Z3944cc1A8ND>=-&b?/S,0L3P<<@NdRP[0K;EKR>c[=\01@
4]7D@#AQCd8Ua982\PXH:)&Q<GQP^X8T#&Yd0:=A:gdVYKfYVU(d_1DK>8(]7H<,
591#&)-^gV&=YdbQPEBSfd1e8I,V3>L@#NYX;)0ELM;VgNPd;(LcK9WY(>7L/>A9
a[P&QZJZJ-SR6V4)4;RAD:Q^((C_(2H2a)SNF_19>dEZSDXgXSM/&F6&RJ?G;d9]
>H\Q_cB0dg)KM@X5-TTU-J7F#;728;&L<3L<A9(C.<2IA+@IBB7<Wf9L3&dZ<CTI
eRR5gI[TgI[W9]W@gDWR9=L2=Tf3\]WS1PE./cO[J0QYKP)?+A-5;b#gZ@/:A;8C
#=C510UM9Na#I<?+P:ZFf9b.YZUKZXA((MbaUf5(V..eWU(&-Ec+_6]\T<4M<_</
D]c/;dW<0^&[6QMdPJ^FG>a].[)Z]g9bRLARe8_N\a_0BSHc0a\2XK6PCCQ,_9G(
M,25@/)D(>,aS-/62E.6c,HXeKW@&MA6_b1A@6]6WE7g^JcMN&G,&e/1V_SN_ITM
b?6.#8;EZdHW;ATKE5B5])be4b(9TfZLOF>eH2bAD#>Y8.cNLGW.dPT6?(&F2(b<
)60BQWUGdc2>CS#/E.2e(>=ONGYcL_]E6TLc[\DfJ>TC]eY&5T5+S?/RF^(&,GM@
^\dI,3bcF)Ec6Nf>b@#-[]DHON_g5dZ-_c3Kb/_P@[I3/FXQ<b<3=@<=5ZKB8@.M
C[Jf7L@GJeU1c<d=/@UPYP,B>:JLGT:DG3]HHd7]TZ0-EZ]=S4AEL5^>B)Cd=gd<
3QI-8YXLXe2Yf6Y\d&g-/ZS)PZV(#H[eX&X:O9c&g1642K#N3K0+W#6=[6Q]NZYQ
_WBUbK-Y=Z3L)C01H(VF3D@V;F/dL[K;Y0/IbL<X(]9HO/7>YY9e7HFXAQ6dP([8
=UfAG#:#\C949<GSZ7E/dM9]91f_IDNQ\5(#APRB,/4G@X\Ba?A@KD7;60G@1Jc-
f:EIKZ9dJAcEcJMV/E31gI.0?<P9MW+d7aXgSS^WaHW#+PfD&.B]@UY@65T6I5.A
L/]?7Y<gYI?F05Z\W\&)RTa?7U_(T:cIQP>fNS)RZGZd))W8L?,E>Y,#@C+0S_8W
&fG?=8RdJ]#?f?9JL<P0J]e[;F6B^(XfKW2R,aG(gTQ(,eHKJ#;CF&YS)R4V-Gd/
H)YL&GbUdKIA4K]L(W=N?a22B+I/UDU=ZfdT@I.cK:J8H54c+9/DA43@Pe+J1:d1
+VUN[eGV,a-N)(KRR479^]JC6>>A8K#2U+U_.C/U^^\Dg3Y3@\f:PJKQ([GRA01H
0;d#C3;Z8):)C-ScCZF<]>SC4.^[/=W2&6;ZHH6H7/bgJ#9Y=Yce=fL00:8ICO5e
28)1^]Z-Of:L?/:MT9[S.23_-6fg#,9#3A/T66PSG+D<LfVXL?VVbeB\4D>ec6IY
e(Z+I&L3B(bIM2Y+GHJM#N^aB3\5cC4C>GCf-Dd.)V,dX[.^8g2K6O+8gB=(FT(N
^Q\R#ZaBK941;Mg]^@S<QKe/<2ddKF81-+FAa>O>MM^>dNFX@gg7&6I>-N-M3\IJ
_BM.Y5?[acYb2N2JC/Z-4Je6:0aH_XY,I8gC,S)+4OHdA63U>U?dd6bdZd0L6K?&
OEBaf7bW1N/]0#MWT?XZRX4.P)#294,&/]2@331,-4dSB2JAg,J#<cW27<gYGQ[)
=+NE2F#T:OYSAc[Gd[Z+C3V.)]M/^5O0KZcNCU7V\7)LNHgCeO?d(PY&5S)ME4\X
+H_(_fX@W4)KE3[U^Zc?2dF^K=8Ig0_TdH2Lf&9W3#&,Ob<<bd#2W>REMWe+R#\T
O8cA?5?9;A(7KLAef^-O0(?)F&8/+]H.Rg.)8[-[I</W(1\A[\f1_LY?J+ABHK;C
;2)EeHARC.g]._g>U5\<G_Uc?aCAe3?8H0=4()_C/2dFNZ37O<K.RYaOf\C>[^L>
3&Ne2@W87V)2\7fU=0M@?P4V,;PQ/_5C(f15V09X)6bK=L9]VK+BC<\DSD22I)MM
P.C39ROFS&Ga5U#cW7)JUO2^T(F6[D.E-3K0QWH9:N&UQ]CWW0(V]1>adYCHG@P-
dLZ><Q^>^\8Z9IS^V=G1db-/5N)<T,S4MRWCL5S=a;86(WP;8gTV(3(b(RH;fR1^
\QV0;1NUD2TA,]&0L8YP38(.9N^,(Yf;KbfPJ0CF9LRD0FA(#&8-<Z;>/RGU1V>4
[fT_]:cJ@3_I11TP-VDG@bc;X9a[]H[NBe()QB@?]cf:\Zb&Vf@_e^U]&_W&IA0f
Va4GB8P+?C2ggW13<#G:+&^&5Y,S#8WXH@g]PX3]V?7_;BV^)8NP0bW^O9#Wd<)F
:9.<WaPS(?K+TFM(/UTXG^7PAYc,.bJ-JN6JI6X9FaM+YXDP2YI6IBZ@IO:f2TW.
WgT^Y@0e)]ADd/OE_@cgC)fQE:7=@8[6UY^9#N<Nb\BAc5dY8-F5,F+A;(^G/9>Q
-]DY:E(=a\WDQA7.PSGa\[+00YBLe[PSXP]?O9gLVP.A[XSGgU/[B\;&gKZd).LB
::\;U@<32/8>/W2TQ=2ff+6(0Jg:BU2NY1+^LIVZDS+RdcPdH@>M>Ug=03WO.^2a
G=0[ZF=-c:_<?,0ZKfIZbZ3=T\AKcHG=Z>6a6.I5C[B^Z]C@T(LNaH[=>X-.)WN+
cEAaT-+eKZ901##5a>eLT+G<C/P_JG:BL?Rg2LK1\61[UA?/Q;;CKQ<0F7ABY)C8
/MB58aEP<cV;9Yg.A5YM><PZ.Jd#?=-,g<SH;0Ze+PNHg38Ag&+1e(C72R6AK[@<
-3#)8^\E\c/5]7^/<2I:d)HEG?gFEX;H@4+9<)XXX9;+cH,M4>;Rf.#K&2GNXbMg
6GNH<QY0J.Y>P56[X5^/4[^,e[F1a&^C6X9@^cL,F^fJ7X-H@[^W#LIUB\PbJMd9T$
`endprotected


`endif // GUARD_SVT_SPI_xSPI_REG_FIELD_REGISTER_MAP_SV

