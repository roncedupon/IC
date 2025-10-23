
`ifndef GUARD_SVT_SPI_xSPI_JEDEC_NONVOLATILE_CONFIGURATION_REGISTER_SV
`define GUARD_SVT_SPI_xSPI_JEDEC_NONVOLATILE_CONFIGURATION_REGISTER_SV
// =============================================================================
/**
 *  This is the SPI VIP xSPI JEDEC top class.
 */
class svt_spi_xSPI_jedec_nonvolatile_configuration_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

`protected
]/3;8)4eaXdde[.__]d&H.\<fRAf&L65DQ\2NbbA-1+JPPE[c(3C2)YIbdND+gU7
06ASZZFS@b9c]F]#?ac?<1;7;[K1ZQQb#\4_S,fLLJ5OLc1;F&bVQ/e[@_N^ge]T
:^Z(]^If.9AcI@c/Q()Z\1(=:+E1gL1.>(I=+_)5\/Z3e@]&V6AW1Le[P$
`endprotected


  /** SPI Agent configuration handle */
`ifdef SVT_VMM_TECHNOLOGY
  svt_spi_group_configuration spi_agent_cfg;
`else
  svt_spi_agent_configuration spi_agent_cfg;
`endif  

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
  `svt_vmm_data_new(svt_spi_xSPI_jedec_nonvolatile_configuration_register)
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
  extern function new(string name = "svt_spi_xSPI_jedec_nonvolatile_configuration_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_xSPI_jedec_nonvolatile_configuration_register)
`protected
LL]VZ]/.BNAR,NEM/fNb14CK0MMIcgS9)HP#LcNL-30BNg.B=VK?))3]W^/BWY;]
3:DC8aCaF-GP,_1cJ\Z:-ZI.(]5Je&L/9<]QaW=.CU2O?,?FDB2KMY^QXOEY^aXc
EF,aDc?44,&0UK_D&;9U4?PEbFdXQC_@8H:9>QSaXNGK4f#U8G:;Ye\FO0))Yg75
G8(2[;E6-UR(9[fW0U[b/W>_S&#g6.5E@?5GdI)1XZgKA$
`endprotected

  `svt_data_member_end(svt_spi_xSPI_jedec_nonvolatile_configuration_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

  // ---------------------------------------------------------------------------
  /** This method sets the configuration handle */ 
  extern virtual function void set_cfg(svt_configuration cfg);


`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_xSPI_jedec_nonvolatile_configuration_register.
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

  
  // --------------------------------------------------------------------------                                        
  /**
   * This method is used to pack the register fileds into their corresponding
   * register using the bit location provided in register field class.
   *
   * @param reg_name specifies the name of the register.
   * @param reg_val_serial specifies the of register
   *
   * @return The 64 bit width register field data.
   */
  extern virtual function void get_xSPI_generic_register(input string reg_name, output svt_spi_types::serial_queue reg_val_serial, input bit enable_profile_2_0_mode);

  //----------------------------------------------------------------------------
  /**
   * This method is used to update the register field with prop_name_field
   * value.
   *
   * @param prop_name_field specifies the name of the register field.
   * @param prop_value_field specifies value with which register field is
   * updated
   *
   * @return The 64 bit width register field data.
   */
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);

  // ---------------------------------------------------------------------------
  /**
   * This method returns the updated value of register field.
   *
   * @param prop_name_field specifies the name of the register field.
   *
   * @return The 64 bit width register field data.
   */
  extern virtual function bit [63:0] get_reg_field(string prop_name_field);

  //----------------------------------------------------------------------------
  /**
   * This method initializes the register_pack objects with all the regsiter 
   * fields of the corresponding registers. It stores all the register fields 
   * along with register names in their respective register.
   */
  extern virtual function void create_register_pack();

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
  `vmm_typename(svt_spi_xSPI_jedec_nonvolatile_configuration_register)
  `vmm_class_factory(svt_spi_xSPI_jedec_nonvolatile_configuration_register)
`endif

endclass

// =============================================================================

`protected
_7J[.EY\CKMTed9:.IC2;B6;^7^_9N0)bBf0-]WC6R-@HK;H]8KK0)^X>.>2@8X@
TXJ#g]ENN>^S-X)d1dffZY#,@@aDC#KeGbT/R=8VRE<?2U&D.b<Y-)b^]39SM8EO
[6RY2>0Rf/U8V3:gdTO50=#OSAOCH4Q3WU/6(=E6>4,Gc#9IPFI0RW&d0B\2GI?U
fQGCB].V.#V;0gEY@YSUF62N(1DeMK>/_A@U4>X-[e>J4[X1HFg7D8?RYg39Og24
X]T#@&,M.A?,b_YHG7(g_J:;fP?1PG>52ObAOJI@=7++CGMA9<(UIV7]QH^W<TGd
67-RL(AQc4d#gM,:J?QUd09-P3]&,D^C1Ta1@;:Ce\GJX3C0+,N66[\0UFS.&\NJ
IL,/TYQFRS]7^0^U&L(R)L;D[&J[-QLSKc9=V3.,Z-+4(O_b(+@^UGf9&<R81[XL
A><gZb.Z-e+/ZcRL20P,4)B\b2[UN081N4T[7_)K/C,XJ6Sceg-&7^+\:X<a)3dX
9UM0S5B[b]AOHBI>(2C9AERN]?b68N8S[A=Q/9;#;J-?e5DSX8TVZ\FQeNI,+.IN
)&;O^]UBDT^?FZ3]&A>JGg8T]>EIS8ZF/VfI6MBXLYOS?E?fC6HCa@9\Pc[RS@OF
_Ta\./cI5G-CbHZKD0^g58X>OR84,Tf<CDXL;XJJ]8=-8\Z)ec\[&)I+XWM4>Z]W
31P53I9FQQ\D)b8#KfK(=SW(@#@(f2=K?dcXfDK>WO,82XCV6FMg4A2>Z29YGV;/
H,.?8c,P=&WZO6@Je<e9]8W(8$
`endprotected

   
//vcs_vip_protect
`protected
M@F(1PE>g]#;7JZ&CeD,?7GaT?O\G^BQ0MGg-WWVB.03WCCBf49b&(L)#cHEE(Wd
QOQ04O<HGV9;?;RcDC(\aeHL5Y7d#eS5VDFgXO5ZX);=87ZF,WFF_DQB(BC9S2)N
X&^7Y66IPg+H:DJH:M;?L6g2[2C&]-3adPfDF>eK[Xdf_\0-H>05U-#I6(LgVbF9
XPV>.c@KF+0#+gYB^cWf]X4;J?1?U+aYQ-Xd=)&PNFS2-WZ.9@QW;61:=fdQD<5#
-W:>>2^=XTO7.5UJ?PQC&c).DOc4\,C0I1,T<-JDEG>XDcX5687VE^J4T@cce?>(
M&ROM?cKeeCGYLDS<2,1I,A+FeWI;RCBcA5Z87QKcKG_?QNED4/Yc?5AL6.VdB^=
&?-bQL]VQH@<4ed5S/.5@Z59efZ6>ZJ0Eg@INKR^BQ=e?0(A(Rg:8@GII9^fUg/_
Z3-WN.=-\C.&3]Wf1&5=4#c2F)BZNO,PE36,K2;1f]<KBb]]F3^,EP0e6;;K74Y1
V,)9ZTUeIVG1)HaL3_::D78P/^)<[8#+YD>LP4,5?S3(c=N1I:(af^d,aF?.MMKV
FTX-7&_L]M(9O\Y&J\C4.(c(#4R>a^;cC(<LLS<;3K+K6)NB.C=1Wc,]#g7\KgZ(
G_Q5=;)PDJ&5DW78(J>Ra@&&+QbI4[&_@F+3)NRA-e559&;b#1]1\U=e#Y3RdXY/
@HVO3f^Q1J((/^/8g=11Y=B8/X)\SX,J\6AB@>;4,R<IGD9(K0T=I^I1((M9_QgE
ZU\NL&V#RS9/Wb4f&aN]X_IMGS(>\.A/bd<37:X.PQ7N3fN@^\FQ47#[Oc3S&J/@
d_dZZT<<-&J\fNb?[)Ve?E=M8?Q];2fE/_Xf[:gQ&)D)2#]-G]>+_3V,8TX:F-7S
YB7(NZEISc0&bVg8(d3&BM8)==UI[W_]76_(-6<5P\Z^=[Qed^BfX)IGWUL6&U5D
QV;_SGb@8.M;G^<BM\/g>8gUSL2KP_HYGdCH0[&YMJ6ee^3W3K]U0Ze^(/)U@V8b
egWJD9H\#KHZ9N45)<eT#XCS0=1BCP_cC0)ABJ@WFK4E#Q;2(d<]0S#Z)8)=#Z#D
[?4dd2eSfTERUA4\D<4F,g(1JdRUg6A,_8TMK+AJM_AZB;dSVDRXNOa;V+1FEG5)
^HU_7Z#L.bAfMN+fAYV-6ON6LN#0g1QOG:d\E85/,[=FWC5<V<b1#NC^BUD&cF+a
XMKKJ8-=&MdcLVaM\9c]+AG#Ua;93_L)S(G12F,-b3C\-^DMC;Xb\CK>A8MRV:BF
FUB3;\KJ1:[#@OU[JX+)NU2>T-XKWUC636c:92R;XYaZ6:3MTR-4U7b&/#J[7JRO
@Bf71/[(@S9?:R9W4e](@7+fOEV8+L6#gGV-cI^6JS63=3G_8HD>-a3LcL<RB-98
GLDAEHNK4&@cd&CUaa)eU3E_\]IFOXASg2R0=9\7c2U@[,cg79L4bd70RJ@0EW-M
5A>;>D_]9A=E7KK1T=X=OYH-5V,f)gJ@H9Y<0]OO/f-[E2CN?(W,;@IdY3+O>/.4
N7901)D-#b;AE6d.J1cQ?;ML99?/0EbO0@SG@-IcE<f@F-N.egD>M;f^Z,>N8a.g
O0N0L[eDd>:VBP9?^,V)\OY4K-Q\1X?)?T12:>c,_eGB=KNW,/58^37<>=1fSH/-
I\Y&;K(6FYF+A^FZ#-G)R@7^KWNZ=OMd003BFI_?a/gB5ZC-R-PWaCIUDAfc>M(b
e)X.#2=bV=Y]7)TJN4Ic(]KEZd)fS5JeQQ/1XL6QZf]),aKc/O9\Y)\ea1,U,FNL
2(g\S]IK/JUg9TP>)=]2G7X[22gGXYVNcMPd+Je5,W@-PR@Xe@XaECG?)&JbYZKS
G/1LYK\T9R/0bG>Cg-fK.42gIZ\QNLNdDS1Z\IJggd]X.KgEN]OgH(9/#+C;I#1,
]IJ4[NAZQIf3=DcGeNQD55I]JB#OV3NbD]BJ+WS@47\(.0.D&eTM;DN?gTQ@a9M<
==-S,g6aN57SCVI,g(B.)W&_\KJdW>c?caZ,ZX:e<_cXYbR-UL/2Nc+0S0d0YG0]
VYTR+T(+?aV^XU1KVDd8-JgLg7+PC?Y4HZYQ\7-G]I7gR+>38YLP(QD>b6B<c\84
Aa_,2SJN5b56gA=>aH_39P70L+JQXP5:E5DGZW3&C2b584@EC@U7_]]CNS2VbRaA
42U]7>[Y\bWQL,4R-^3DPcbIN1QAN>\HA34Hf=MTB-:#+<(@>[E-dOL?T4+SU3IY
7?QH21dS<H0&\LeX\(GWfV3+g[7W[#P.Aa.<DK7+_2[<&T)0(?_K3?2^BXe#I3LV
9?ZCCA/6K3K2f_LVPTdX&]T,e#A;)_^ggW\@eHTBL_Nbb.>fc>bDD)BE3K1PZN+F
?_Z/91XLT-a=+.I[<G4cB>C1>1DU>DHUVC/L3ATD]aW>._9;-:ZbEZ]Y1LQ[#NA]
K#/\/e699#GB#;H):1@4/@S;P)NA-0W(G4UA]F-=(=@cTAHXeE?LcRESEeF7Pc61
>T&IJ4-AUJd+@Q,aAS&HaB<0X[a<,a7HCC8(Y#@+J5^2H(gC56]3>386^Y#M16Dg
@5-P,V-MLN-MJU]_+7ce@,F+)?V/0?UQfSQB=IU_aFag];T>/dKC0&Y<,=?_0dMf
+VD5-V^1PPgK8T4H<JK6B#dZfEDQ>3D/A:R&UW6gV,^)LO:STZ3d&=#;43TSN_Yd
\&gO]fOBe(<E>dEY+^:BB]W_eV>Z9=4a3HEYdP[D^Q<eEQZ?#+TN+XVM./IQSMU3
=_]6cQ[VC8/NV(]EF]<?U\IYS:FXgP8I&&SQN8-.14?/:_gFVS\.=BFc/-+E\BU6
#JZ,20@WfH:,HSO4\eO]Z[W;I=71F@+1,FPYGde&0=fWQVRdegX4SG3>(U3e?TMC
4f5^<P73^_7HT&58VN7=IL+G+NZP2]IcE(I8JZS09I.XQ424HK1#+3C\07E@[);9
/&0TF)4)b=dL3HC+V65Y8dYN>OaaENHLQ=HPbd0Z?adK=FI_4.8DHJfX;RC?+Nc,
?F07f@L7DV_RU<YZ>:UJF=I8>[g\<C;S_)4_07-C5.<c?=WAfUW4IH6X4BUTeNaH
9P(S^[JdN+\^YFM@cHUeV^N]?#_e^T<M1D7R.>K[&8ZZc,SPD<:NGWR+X]d(U=GP
@#5VPVB)9)&a<:T@Z>^>EVCAZ(Gd2cJ=7SR-70@X[,P;-UD_(N;Hc[c;Uc-D\B4:
;3<MIe.:UfbYOACKBg&5>Ge10FV1[aY]V^G_OFf>\AR7?H8DBBSf9Gf<0Y1D4Xf)
EY86UC>C)R.H=XDa39]bXC[-_daOV1=59]Q&)<JLFM>W9[-(WLdP)K>08RL&F,Z1
LL]<W<FK/SI;Z]3.&2BQ3Be#=D<;FB\GHT+:Z@S;K7.OE;&)YcaKB1NF@-V/#&(4
CXM)P]\W;@V;>c&E&/HTAKMTb7YSESH3N.e)O64Z.)/:>5=]0D1^GVeXUJc/c[]1
K<6W):OO@-IZHV^M5+AE?aDH7Z3(J-4GBN7PI4WW/@d\FXAP[<&?-7)SJ8.#I@6_
SQ+>SeWc&fA7@485KFZ&-:^L5gDc)_L-3MGQ[;]FSWVT=#.SU;gb<g:;VC4f7&5H
8W5ETUHb62?P>+5^W]/7>0WOWc6)9P^&9/.&fF3)R_TU?a1WF.\N.d4M9=b7Uf\g
?CNC12O)99CSMZLCFPa-5bEf-4[>J/(2,P^H_?,#D_=\H[_ZGI]?,.Z1#OD#?1.;
7]M:CT62Sa/MHCYcD#>Y2(Oa#We44+KCf=F[C]^67GJ6U(c&MU8JSD\H+H7/&8/H
]B]_C&;=PCV<0AB_,<(c5a[BcTAQ\7?Q99(S_OEePY?A.aMW27Fb+YP;+cZ]Wg40
:=7d:MZHD#MSGRfB;LFI^:fVTKV<AX4FGD5&.-_8+;8gaCE)\OY-]WL/e[A?CNO=
,X@K4#U<6(P_3P0L8IK@2U-)3(SUGf2,dd++--#2QM>eL\^6ga)4Q>C32>V6(/_G
Ua/Nbg&JdM].2ZcK:^[M16XbG9?Z\?XaFU6EI008BD>90GCLX.#:])IL0?4_#Q(d
^dJ(&,P\aK<d_@VDe2^_Ff+UDOOEL-SFML[.^=Y9S&H-(\dCd0TQR3XOc-e4@.#P
O=eJHGHL+Bc]Zd[L/3W,/_L8b=.C&^[cId[X+7J2ffURUTf&Ue<9IJ0>R:>\R?e;
A?RC#@LA0.1ZVbN;K4@=.2Kf[;JgWfC)>>MXaTD+G&fBTB+/?U;[P&H:FeHLN<b9
+;<SS?5_IH]AHB.ZG4=V6\B0bA=)_.Ra9#>K0P4c^<J9Ue9-M[.BCEB/C8QLB6b;
JZ_N8C=[)E40I6fII58L<<=/2;6PV3BM.JQ-Uca3D;Sc[&aadD>II\O^)AeNK?7T
_ZE6:;CXGXKdGcfKN\=0,>5Z]K:;UM,G_)\RN,@eQQ+(Z-1_Ud99&1>&MZX83eW4
HO[-:A^#+QUM,eaY_PU#&SV-9\5ZD?S)M^XK/fe8F?cb+4#.eK3CY0<acFF6cU5b
gF;.CRDN_VCZYaF2+^0FK5EB[B9T-:)+.Le;[W]0E_7QEaK3RXcPS2Q)2g@_c&MA
]5NPdb2c\:c4_8WLSE@6K)TZG4d?O1O[LHfP,Q0K_#@JDG4^0a[#;H&_+3WPM=Be
SW.b,+UPS9DYWN<NSaV(>_DD,c_[2^O-f-(7KR]JBd0c1[N4S&IXK>KIP+&P6Xc9
)7;P;^M?.:ZT#,=KH6fAD?c_9KSc?VE6-3c(:YW_d^d&YX5NU?FW9WA^:22eS>2Q
c@KePEBEga^#36<18WC2&@8(&0VT/N;-,a]_^OV..5[fU>J\2Y)d7RD(R]#_SSP>
\[XS(;5R=3Fa^7Z<JZ5LQR\[>/.&][(\T6U>5QVF<[^G9Y9P>-Q5>1]KE4.0JHKa
;P-)gQAa]egO_\R.:Q?9\7&FEKG/K<]VK>;aB0IVIJDO7^JC6Dd<Y^+?YeWY0TRW
f+7d[_W.I:3a<_9NfU0&=?\0JVC@USCADCY9KeQ;6g50I7)gH\X=>AJ=GIdE(:J&
79/R11.+9c;08UD?Zf?Q]T4][N=VXT&.Zg8U)S]RXGI.X?P#YN2[=\Y=J6:Y8TVT
S_c9H]H>:BC7]V>Bc1c0^[AXc6&Q=?5Ka_IA+/b>+9;aX+S9B4CSKa=D?Z\bH)3,
K1IFbO7-]:X,>/e;ZY.7TU<N));<S,0GBNSEXJ,Gg5bW7)1XO4ZLPPe8Sd7JE=+f
BcF^D?Cf]OL?4eWEY?f)0)XTOe/B+DW^^d0>bZHSQ3@dX-FM:?^^5G\fQVWF1X#2
cCXTf.UM/8eA+Q0#73g1YeZ?K:P/PXR)7UUgALB-1;)_+O78QS;gR;/g+:<](]OD
614<](-PX^?fDbP)=-I4(4H+5U39\Q.B+&GG[<5Zfd@0[DUA=-d\&:RKGdP0G&:S
AgK8L/7Lc2eV-JV^7(&:3CP0gES[@#+IWQV2gX8^2)0IIg;bb@A.7-d7V>Q@=U\.
24CF>c3SYHPgT5^Y7R[PcCN_-?0_,cUAYaLX&#U_f?61EC^LJ^fcN5\AGH9c?BXC
=O(-G9=,#OA8?(H2_1]4S-ONb\\P7>WTG67]dRWa5LI9U9/W<Nb#>)WUdK,P][Qa
ZE+S2^=R-CK]MQPET]ZGg\dS+JC>gPRN5LVC_Yb3>__>NcP/XGCEUMKUI&\\^XEK
C,H(#>>&fJbWIWO3ag?4.UY=gCHY6<;O.E36?=\4I9_MYfdIM_W^_R6<)_@#RQX@
C#X)5f&6TINE^_E4(UbQgIc2+ObB3XMYI6;,_C9MW.R)cc+:f\cNVGZVd2F]Z]LG
SPM<9/TJ+8TLW<QS&NZSRM=9P=X-a?bfDg:XQa9I\?7.Q,R(Za@e&K?7MN54;f]_
/cC<4)T(GO#<K;+J7:9fXBRITMAB(BKX,PCF&O-&BL@?71>>IS<N/IJ(TKI1d;K#
W<R.7d]WJg8GO)FQ49=]X>C,5:.9<8\?,Z53R2L\XWJOF#5SSA&@IDJG0f?(>6UU
LeF9@8[#LC5eGC0(Y_aa^.12B;YFXTd;3d<M(0BXW9cGF_DZK2FR:1d?V=8.+:a+
3R-H(6fXa<L&PR3J<P_H>)c:G9#8V6EL2a36MS6:IT1XC/1C)-,H70aOI#)&S[P&
58LH]61>7GCXE+2f)09HW1DbD7_4S/VT5Jf97#.Y8C7C<HdO0VM\>&N?>gd:G_-G
T896Z7Zc(Z1^/TV<]:&8JSG1\,Cc4HYS3(Z-+0U<[6,@UU2]V.Ia7Z:U2TV(YN/<
?U5Qb(ZEW[DULBGPC^U-UCC0.>2AGVO#2Yg7ZG7^KT>fVKC39>0X9F[?0GX-dIEG
TYFIC-b7eDMI0c\)A2]O:aKX5R_480NH]8G;N8O,a&;QD.(0M.\>YAcZ8+#gdPf&
J?Ib#2+RAXIV?9[f1I2NTSW2Q7b&^R:EZKFJ-gB),_1>G^&:Fa)6\17[(K8g:JJ\
P#1Ja.4E2OEGfN_AA&L[?R87\P]_-<Y+>V)fdJQ@GBDGf/2_V+1N-^-G\+2JcSMB
2:2cDb5XV+R;\IYT(3W8^=X(b;\(ZL4M+XXUO4NgUdg)\D^??()_b&dX2;BeEFK=
;G412]T#_gaW9+#Y.cbAfF;:TO2^#a8Q\AH3T6XV81gF_V\2F;5aQ(BBM8YQIDV(
N>Rd1F&.ZQK=@NUfPT<)1A,=+g3KW;_;Q+5U;WJW=Z,YCA;aU\]d70Jg,eTP+#;#
&_fFf)(dVO^_8a1+g^&fa;3-@OKNZY@ZcJUH+H7c<9Ya,LD?GMU^40PU/WaM:Y?g
WagRKC>d#LRM@eFg.CYGgZJ&T4)0JbACS:LU)Tg4SNS+JI]a;PWW[YGLH989#GT>
P9+<fWWV>=bKBBLgYc):>=WHO/\EO<.0MPFH(A4@@_M9?)e.4FT/F(N[>7Z\_F4>
+;(#NKg\IMLf_da(200E&><FUI\6P#U6,,7BHNEB020^ZHJZ:O&1b)a[#?EAG).0
A3Ve<X7/&36F3&JZ6@Ve#I:8]^QS0BWKEdA8aMVcEU:CVA6Q/U53EWg06EAX/[Q<
K^<Ja3IP\aV92U<<K3d39T?@AT7+]6XSH:\c7\6e=1&[=B,7J_L0]>4<#0X..:T:
2G\R:D;V9[TMa(Da,Ud?Z/^U=5UQ=e,HMLa(73IFg>ENC)7->UGE>H3(NE6#F75C
Q/24V:V/1:8A)FcF/VVRNMSPD9X[gRVCc;Vf=g]>g]N10g9FSIg9N:CE1YCWM1##
#Wd\+8@-TYbL,FC0)KZ1-dMSO-IFUXQa&<^WYSG5a]AG^D8&bE&>]c)G1KJLVc\Y
Sd7P55.?_Ka0KM<(W\;8#?2+]RN?U:=\^g=?0-2GZ5FIA1cL+SQa-WQU@ZD+M/=R
2f,gGR/KAd#50=&1[dM44=TW#L/C9Q:AQ5,CFa>SLE#0B&4=G.F.JQ)PM=#?0fK8
d&>1-+bH)+WCD&>B=GD/ZfNSFD-6@Eg4C\a?#2)&?+0+A_2f[MH1U+L\^K/^g]E_
_2;Nc?[S-NMDbF,)1X\9R:P9Q/)gNWO(05#9X\P+dLa8?(H-cQ5>T5W_GeXgecd4
5R_8)IO[cbFR15EA;FfHaU[Z(F:X(I0D+HCfH>XI?c(eB?D/-?bVRVRLeUKZ4cIV
?278S3cEU/U(cX[(C,Z\]85@#e;a]:8=Fe=6>aR,22f;4ID[:a2O(\Y?MBHIfW\5
CT+_A]TM?]A3>N7gE6EIbYb<Hc2[Y.FcXG+P]^ZU2Z(57DD_&TMe&,cQ8bG(9=dT
AVaY@gL7@B<E1@]RG^QbY21W7ZCFR-8C34>3?C;AGKOZCAbK)?Qb?2RZX&4+S]2\
L>8.FIWN<3[5-_)C4]2FO2USYQ#QPIZ^.c5cZXad)VJS()0TeD-9GAS^WDb-V?UO
7>++015\LI,_=PS1.=#X1fF8.?Hb#X[Tb#-\5LX;+V)U#6\:W<VD@cBbM[=MLP&C
aEca]S4_d+70F-?fEW#c_]+>@Q3,LgGgSZIHG5@0e:_J/gd?dX(D]\TS?aMP;8NX
gGgR>MT(Q31/NXT#T3@6X/Z#G3[:e).7GTd_NHN(T]E[]32_2@+@R)Eb5E-.bCML
XRaL^;gER,=baU6K??@1J>1/c5P,?7Yc]W&LP)=N]_F-6E,e]fWaX1c/[R2@YP#2
49aH11)4=LM<gL^e9P+8T:IIU:&,HDR;DP3LMW_d.;(J4^af7V4/BfG00E21D3;K
W[U(YX]\aO2X)<1>U,LD1BCYAG2=>7:1H-;;<-#8<&/O/;VP5C>c._P4,0Va>FE@
T)VJW_8-7<A+)INa@8AT]88P4UJOKDXB+UI+(/8/#dUDa(#T-#F_VMe?T04]J[b2
A].4EDR&+T0ebEgLBAZ(deOX=e<9[FYDP)+LAJC,>L^:f\aKNXUY;A3>KU63S74/
1?NEL<9_bS1I:6JM;M(,I3@W_]NK#9d9RY5WZ)TfH?;]fFF7\/[dEY-\;QFDQJ5Q
BCC&HKW7Dg8HLO<CPLOMA?:TO)+fLTX.b>JcA0KU:Yb;Dc=Q1_&6=S8g.Y/-_cVT
<Q-@G..7;.>?U1^5\L/05<MY_dO_IZceba6PIc-4OdPKJfMQDQ&D@QAW74QQf02e
?b4L21[4M3JY>.6N2Q^SPAId0bBI:C=L/=AC9F,:KU?\c?2+HG<F5b@Ze2_>YV1B
]RUL/DMX/+Q69,N30D2ZN=[K,#/Nd9d;YP7=CT(24W0&OTc&eHfPW=GU@6D.\R/c
3B6+d<<A[W,-W@TFU(\XRJI,)b@OEYdTC@W-+J::c[J#gR+L&&MG=H.b7[.c)\[\
04g;&>),.6_HfgGUGCT5S[?>ZD^QWOJ2,IGN/M4>_CF//#]/a#Ab7=WGCI)N+B^C
L1^ZV#2\/.E=C8e)D+NZcS)(4M;C4R-FS/A>K,\^dR/+2<_R^beX)87_F[HcKb3N
ZI0:/X&-f1.]S5#eM)LI3]Z4062a5191;W&IdTHZ.3Rf.VWdaBEK-3DZ7.(H065@
X_B[f)fBadU<APCH>EL6a7b\#2fU\C]C:aSUJU/SBV;WJY=D/SYD)HZ5J4#4cJ:V
dGNWY/G&1gTJNZTLe_L3<[[7gN4I>DI.[(@98a,;5,7:e8)Pd_1?VRE\+@K(XQ=<
=&>@\08Gd=9TGN0IR:;8ZI&2+[X-75V@HWEMCL/cHA[<:IdPC4M@/NF.f)_MadG[
GM0<])EH&:D<]FR#MeQ@FMS7+)[G\g(g>4O,LKN3#><_Dc5-LfR.Jc)OJ<gCPAQ4
L4_V/@a(dd1@b-E##>M,_38KX@<X[\<e>_18VefN]\Q571LcKcSB.W=dY3_\HM/6
]1]KJ#HF(X]0]2T0BG(5M0A#[/MPgfT>9C7,fcU&/DX9L^FgHQ?FaIZE0[M,QCEZ
G55J1>W1@ZWd4CQ3T;]g>J9>S/6ScDWI>/=^?9)cE6:@bNHP@TeM\TgCZ=#c\&^A
6eYTgXVIT6LbH:R]CgaR?JGE<4/Kg+I]7+BM5X,AGV@[=47eeYY&?W)eL39\3aS6
58dH38\1<K&>Y6ZdT8^+,PT5W?@UMCJX_\gab]aN.cWcLQa-4IM+=N^(&d=3RdH#
\.^QBLLbC&fL:aNY(_4B&,+KTa4L8Dab#3RS#94D+FfM?W;Qe6AR-NB]</:@;X-c
7U,S\_I-H<V5S-6[)c2#4=DSAbCaOM8a>NcV7U4R6^fN4g9J?2HZe#JM>J/[28.6
1##dH:W_K,_K)_KOG9S6#MBS].P\+(^KM6LJ?5/]T6P]C+eg^,+A[20K[0->[K0g
,V#-g\d(?/&DJVX@J]F6G<86YgXAHRZb>3X[[fCI:KDHFH6>&_^GE/[6+O/SP2ca
M)P#ZHGcE>NXY<=L)\9@.6BI^EbAMcDCP[IL6@;2OI(^R,UM2+N8XJ8dL>FY-FT]
dM<@Rf^I.2aOe8a9ga4fQ)P,E,fI8N=SB_/cI^EJL+X0^^GgK1ac\[SR9-a)BSg(
34FN7;FeSXeF+e]?9QR(O0^WHNUS>@Bc8U6ZbBD^W42&c1bA#]B9HF9OGcg?IDKb
-7Ib^R3ERRNQ>6_E#.D4HU[\T4+[dC9+\:5#0[YL431AJ1/:VNb=[60fa5\GZQG:
^#eLVX^F?BRe)68(6g59;BY_7\G79^Ld7U&Q4^\3JgR.&gCLE#B6Zd?Z#YdRRWL&
U(.WX45U^/9>?<FfLYN&a&;_-A]YbOQPM</Xg?6@5>T<8ZA[FO]/27ZQSeN(2XfI
=AI+S0[WC;FNA0d[C]URT2=Y@2>-&1D[\[23fO2gU4B6H6LH^Z<<LKHK_MbHU)Dc
Z>@\;@1NFAWXCHT7c5bS,MV7Dd?<MN,@8S,K^ACKBWXg+ccBZ>(>SDI.(J99CMcC
2<GF#AQ6.,e#:3]8B3S9I,a]3IP]^fZR^T>-]XGW9N>51:>59HD_M-P-CfHMANVH
/b63TZ/fdPKeEFS7A^^SAKM+?&:&D=HN0cKS,JYYZYYIg@b5\=8@GW477KF3#>Xc
b@Q<c+U&31?<fBK;O[=g.5]1N(:RX4Z&7H;WV0TN_+,fXG=a-QIE[W,6S22Y1^5=
g9U=70CWMbP,X/JU?6Z?ZV?0:BMQ+[OKfARIFDSE^9BA\Xca36gZIIUOH^YB[99Y
\MX0f8ggE=N9MC>CcQgU+]HGe\ZOMMDQ64F[g[]BK,4):[NBOT8W,<9VeT/[Ya2[
NQc#KS9B42C8G,+GH[<fV:4X/?,S\]8b2#Q-eNa6P(>Q7J18M_0=F#DD<U&HBF#9
^ATOSN7U^N9^YCg58>?_&PZFMN\?8>Y1OZW<+OA)\f0eQWH^[-/RV+<&&LCY6(;E
+L\F<CWR6]&M0:eV_.?NJ?,4A1-PV4gQ7(Z&DcHVYB)84\N0c=9.HG8R&ASAP&dd
2-OME31:.6AZZ2LVI^RM7SNGd?dNYFF+(e=eR5CI0LK3Xc.EB4J9g1;g<4Q0a.V5
3V3-CS:S[50LZGP@\&4P8.-^9;N#D&>4eJPSBdd2XgfY5K,O/WL4WB@FF\(=P?K=
Y<a3/C<KB#<D=KXTJ?9)NPc6>.Q65;H?K?.MA7ML-fO&O^UCHJKR3W?_g>T7_1cS
dg1CX\2#PHM,J[ELHZTEB7D&\V8[42;K&1\.H3bYb,C</D@J2L<.7P-8T[4G4ETD
>O?4)NOEY<KIR&M0.=9]d5(,N_;2E^Y/^<NMaBSBcY3_KVb(X&(>.M5ML/16\<:#
V)QK#\@Y4=g0)24/Sc7P7F1ebA2_MH(Q=2>>1_0WDAf0Kg5:[[[5&21[1\b:_J;L
=fYC0#JMR6g.=TfY[d92aAD(D_SWPV];/0@e.9LeG.Bfg6Pec]FA#]H^:BeKYS(.
PAd==0a0M#/+U3@&fZT-5MgdDS2PA8DF[X>MPa5IaQ#c;f&YS\A1I]V4(L+)aS\2
B?gY:T@S?\W7+[#14e1.#Tf]1Pb+[e>f^I4NYDJ]/X0U,C1-6#:@AfQ;N632;4)C
f@.:8DeB^P[RW:II;N-8dC922fTJY#=.17:(Zb74b20g7K.HKK;fMAF8]>ULZU2<
HY;R,S0Rf=ZE=\Ka>C+2+1OdZba,Y[<d3]W1PH9^\)QJHbR>_\_J;Ib;-&a;3V7g
A(>.X_[?f0TJ00(?f@D\;C7W8aP^BDC4cUU/S)Ya\AC4O2/0I0=)MGQ3?.12D56K
?<F<K#X,##&7VW/,SII5/aOEQ(<e<4[TbD6_cETE\0J);BJ>/B;9H):<bX#QNOI^
>H11CS:<=8.&RM=d[^A.)d7R=.[X#=K+0f8DIMFT8f@-.MdbZN5^Z2=0N_#gW<f-
MZ)_U[#;.0KTI(]Z8EZdc6b]Gg\5gYNSIa6fe):]GgdMUB81OK^K5f(;H>MS=(Kd
g43?_965I=FNR,Y8cLB.S(BbAG_M.,6H^[<.c)_?N+4eaJf&Pcd-CFT:1V0=W&ad
N-&F&d+aXIA/6A[Je=Q8?PFLW62FVIX[WRQ(?d;A9e[DNWOH1G_@E/F13,Ed=-XR
(Z0cU&[0F&?d-+a=,bHE=_2gDf)5EPVD<NZR^?IEZb]L/DL-bADN5U&O>\>@UgBc
eU6LPF<caf0S5aRL]3?-,IQb>;UTY<a08&H7:_GOJ[2J>P)(5N7YQ->4dALf,YZX
cLa-_E8DE#56Ga;gQ1_7^A+/QAaR=;f)\fXU>#Z3^&F^bOgZ1J;O+=XB.JQ(W,.b
#LE(,\JO;6L<AOLbGNQaS+.aC=K;\>Z(XP?;\<BHCFg9:X7PUYd]\NFPD+)/GUNG
FRPa]2=4BT/d<:;9WT.7aW8S+>?a,I2K;;d-5(Y^:0=ST9=LJ37aG&.3Jad>5YIb
Gee\,FW@f@C1,S[ZPACJ+@dLE6+.^:1:5AV>X(afXfdIEb^A-[8WKJU]V(-GYH=\
QabMN<&[ZaS8c^GGU2QX3^+[YL85/W=8)aJg/>;VLE:BZV\CQaMdeF?B]Q-?4OJX
(>7aPI[Q2Z]KWdF\,PYaB#I)LUbHeSCY3U2M6XUM3JTW^;7S2>Z0M0g]>7SZ@d?/
_MMD@D0JASN;,^RZ8=U@4f\-6?Te=[_/;.<[)/e][0RMGCE+@IfQbeUb<V7[==I\
H5C,SUFU+=8W-/A+&W#]F@\CC#EGc3&[=3-V)@KI<4M?A<3:>1EaP8RKAOXM(QR6
VBNP.AI8,Ra/F3c2XO-Za22D.]<cS>SSX.@OMQV_W](f7B7910G_D61Qc3,7?MM-
S/&W]AROe;NJ-C?<fc/580GSVL?_L1BT5fP1DbKM)dgA3g-5c(N4KMUTUf\)9Og.
#dSN0IbZG]LJNL,\\09)]E2[X7gIdL]g@(/@bX,eBKO&]-6cK7.5E87?J5&=>,>(
;B,gE^4M<5)_aES_1EXP<2OJ;B>g39W11SYD#9+F+AK#1(1SOH3d079JP^C10cVH
O?6E]7=X+^6SJedaeb.X1_X(L4MCag.<)M^cG@\CY2=efGSc3+M;<Y__#1Xc(9ad
[-VQ9^V2B-0G\WRGeKO[3)I:.2#_9V#E837??;?a,Ae9>ZVE1]Wb__4FF\3BZc^)
=KRN43>1VD?B??@(c\Y0b..I3A/Q^.QRgU]cZ.V@4EELZ6&.BAaN2Z4RK6bNT-]c
UZ;S&a]4DN:(#-0R=a?gLBcM#+Gg5Z2ffTG<;#\)dCIK?+0OBFDWD-U]NKe^5Sc0
EDS]#A;UWS0UYAgB@8<e-2)0f2.AKM^QY^b\CNY]4+9NEULgAUC=Y618S-Zg&@_(
HCTX)-P[83^PB^-T&4UIY6dWUeO-^\10cK7DBS-:ef)4987TaLR.[R;0bE=#@e2+
(<0\DY4I^bb@6(?S2AF)@a.b.#\;19K][53POdH<5_8):[:P69]ecA59:V9J6EMA
/.0(,W=A@F^01]VZ8d?YK?U9c/3+^3^If^U,F-Ef#^S:0C##QIP0Z6;R@2ZEE#89
70@e69Xg>D.3A&K6UJ.G##68TW5<63M#3A_@20,WBOAER;C6+e>dR/=0eM00L.@K
.MAQgZQIAfXD_WT;JddI7>TL(ZKFL5]N,eS0B>_26)2TS-D?aWf:-:ENVfL_VIa@
(.1_0gb-AM/;0#J+aVN:6:d>HT=BR29g8?#]39de>G;+&XP@8A_13\Y7]Q/0_KQG
DbZ?9U4N12BCV0e-TAK[HI[=<H<G1?E?c:Lf:>?C5+@VGOR1KK/I0S&TdE1A;J76
B4M&3A8XO+Dg5ZgY:>5CTYO5=a6=K-f38L18_BYf4U9Q)\S,,Q2@O95>c=(,:Uf7
fc<:a(U\J(A7>)[D4?/[4;+CH&DOQ=7)d?faT&Q11;bMP?\VKBaW>A(PFMBdf=4<
.[,&99H63MQ@c7K>)fDbF]95ON_=NeR2M\<BCa+-C3_W6f_^aLG[O32Yb^TGXPcH
.\Jdb<_9BV.>MC^,IWcJdC7Zf48R6]U]E]?ObMB9R.Q:O_/fD3R)IcQcgc4_6<M9
:N9)R/>dAP.>/]A+U[R/CU?.=(cMdR9dfBf_#Ie8[#1Y[Vf)HfUCG(VJ)=D(?gA)
]=]YW&_C[XOUdQ//?+93HCCcFES?#W/c-cV(b^L[;c:5IMCROE>)Ig#&:@d@1DN+
QVRVH=)@8S[.[=KPSN]EfB_g6T(WBH-7_^Z>fe1J1Xg9<1FHOSKa,XUd53__4V?<
[acg-BDYJ+KLS.g[7CE#D1Mf&fa1LJB]PQ0N6Y]0<K,KPYZbaT\E(R@M7&:c46W;
Q/]FEEg6d/@Ic(c72\c1G84#(DI.I:MgB<\7JF(?bGP9Q_R-T0_[M\:2PR8O4c_Y
MfdNZ)V?X.cBQ-8E\+EFe-Q@/BE_+9N;W@ARZL#eba(WW\5NX,_#,@3aJSQ0HGeZ
dHK>P@4E/3fH>2G?ZW6IM]]K8\HK8\V+9SWW\FG/UXP=dS1WgPfHOWE<@OFSA1\f
5eefHG3V@8@3Q2J<>a<&(OZBTQd:>OgCBRYYeOcQ@@O??@8=ASN9LA;Y64CYV42O
^H3Xe;g(.N1VGYGMYZ^0\BGe\N2VQbS3f9];GF(f\IF=5OL:297B6)UO2FGN>-@[
KdAEPc6+0C?78_2U7^c^D]Za835([>G5Pc55Bg=84T(6eO3X?g.&#J18T0AXZ#<E
@\EB>T(a5cFf:AFHg2aA+=FWIef2X@[_:N80VQ2ELIGKKAA.bARMR<2=;IA6b3FF
RdXW7;#/TFI>efYLc=e[P/4R9RLTLLZgF5YM_)&RYAZ)b.C]d>QM&IPTS>HAQ\PK
B=9FLe\QV])-@P^4+XE&\S58<IG3E3N^.g?g59AQ1X:1A0@>[(fg9XAHQKK)R,;2
cC)X[-F#D=6S1M7^&>f2Mc)MO6PQP4OA)#R-3)fDXS4eTQ.R/H().HHcZYGY&9E[
afgeMSQ^=8f^4;)ceG@fU5CN5A#e69F+CIf.R1R.:fJ(7RDaM<FMMT^Q#dQRG,2?
CQL#Df;H@@#g_YNd+gG[TU67_&5EX,OBaN816?HdSBHC@/Q:e0C^H5BU0_.+ZX=P
cEH(5HgfU2)&=PJ7cOY@\Y>MJaBddIA)<g6_;:d3TS<QeE[UNJ78_.RGQ<;3-<+U
Ve\8.d,ITN2IDTTPR\Y?[47+=,-XC7Hb1SX@;.Wa2PT:\fVE2Q#\[VG-9B&aIQ3J
[,/)?39NCQCMT[Ae]<R?[e\P<bQGJL_2N6eYR.6:4g6@Q9^KJP?F+c59a@7<Zc__
5HC-NbY-);5^Pf.(JD+M35DMU@M<52-TZG]I=DAC4Z2?H+U29M(8KV^J&+O&N4Cc
Q,JGcR..&Aca9f)CHc++a/:N-X;cd+U\gf1[TENSC>#MSK,;XB.DYCABKdC91>T.
J35DL0I@5#F[K0?eAe]^3<(bA72d:7@8KMGgH3M+^W>a&f^0fEOXV=21+W[+6@T)
f_;]6EfA+L.)H2H+0H^DOg9=1Q8&FVQ1DX9\A5cAG)U8:bgDC=@_L15?J#BdfV39
_&=[1L-a;_=NR/YW)D+HI+B-NIF&=1R,EX:gZ;cL2GD_;=/<PA&g.15ZQdR:P4QS
DaOSP8(;LcE4-4PNON5ZCe3eU#A?R7Je#3-IN84;P3O+B,=\H/?H>9I-C6dW\f@6
B8SHT2XD/DL\N.R@PV1-URD;c\V[I()9eS?KZ4AD,&O16/YKMJ8+ANQ+aE=c),99
5_f1)CCH4DF^63b2\X_PBgJV_NS5)K[&A7+@4KgR0?4V<T&-LBB3)f-IRO@).7M5
[&?Xc>)RC5,&<<C.8_T8bEdPE40;S5aSMP/R3@AaT/GK<K,HaPN21+b:]eY)Z+_L
I5aTF6Fd^1aVS)W&fJ<>WZO[RO50J6;(Z&8.;f^G]S@&._-3.EOS/8=]N0UU6b4F
B<6-<<[(/T[=N.,+LSZX,6;JA7[JKH<EHU6B?L;/NFNDX:<e6P04aD:HT0PgY+c+
6dC]CI9[F,8H[>P-&H6)QSMLRb,a2.7Cf=c]V^=T9\S8#D>2LUZ1,gQBa2YaaNDD
F<R+J=dZ4]c483G4<Kf&8BKT4Uc][Fb:QC>GQK>Mf@/_M2.3DLC_R:Ndc0R0&EcV
5+JP^HPT6=G^B&+K.#UKNHd0[[L4d-1YP12_:IWCB8ZaXN5=.g9=gEc]Y?Pg&]@H
,QZ>IC37>=\]4@HQUff8TQL_WI&5?\]39,.8L(4G2bfQVS)LfZBKM04[]M4F_?\J
W\(Y7TR=7@(\.1)(-<Ucc\DL:?0WOS4+2g/f</N&V#a+#bVX=/A:TM/T.X/cY)57
B]9ODX(a\&+gGX?9Ja.DVB/SB5_SMWDZO>a5T5fN6XQK>;UT\C94B-fgaSGWZ+AP
?T#Y4aM)ANbH/RFDM;=7R7W;8B3d(P>F5R>fLge<[J79]T0UU[ILU2[KX<OKNNYH
L1W#]e3G5DNbX1Ze9[^D9KWeVQ^TJIJ/W(#YW2Rf##(.OJ7UWO.E7XMJd[5BSG86
/e=[6d75:G_KG4dTbaZa[Te#fSBZ#Z/DZTA=AKWXGDO,g-3BE_D+P##aaZTg>WSF
J^9cY)U<?X9))?/9Y(JE;N5Va-WB/=BT.+O?B[YY7\M\C&PSEF)<QdBXQWQdbH3^
O49[+7[fMe@_6@FK/9a>^&E??9N5<K7V,,_ZKBa@Ve:F[H-U5A2N:a[41D^JfH1)
OQ7CQ9fC.U:3F8/XMf69.Da^KE,)1)-1?XZJ<,SKEeS-cLeecO5;1TY]c:;(CfHY
24BTBM_N0d=e2CffOg(\;3#Z0_3OgQ:(Ed18A/L3,>#P91d<TSA5F0X6BD2S\>UA
eeT[@+AR]PQQ[?@\BPUR4(:<g?AfP^07-E7B_747K@_WP^U59Be_f7K:PU<JKL-D
2.T\@^W4,Y1d1O[C^1C.87g_1K./B_T:B#+7a/f]+&#X:0C0JUgCagdECFDI6SCZ
eVG^Qf.WTCJ+5-CefRNZ>E&>UF1(QE?Q\Ubc85\[G52[4P_YTSPCA;GSRV+2\XDP
V.E0cWY=b)09QU_IRGZe?B<N&NL.M:aJX[a+L2P1a+bXECO^g[S+]f;XT9GFS6Lg
0WL]1,@_D:E@AYKJ(KeG[+R2+HT#OPN]FHF=feg/Q>SWL&6)W?#B(A:bbQ2f#-.5
cUaB^9\;3M0M5SGdgIST?6LDRQR.1a19T-K_Y:,\PVPgEI#94;MZ78UG9H?c:5;]
AV6ZcHB^KKbHK5\(++F9:Vb[NFXTRObbRE<+aZaSRD1=QC><dY:OLH6@C_QKALI#
JWJMU[_=&-2[SFITf,#YOI<1H@AU;QQ1NfK4W;De6I>DfWD@2OKMJ0OBR;aYH@FO
GEV)a4\1>_eEUIf\9La/YU&d5U\C4\R3T\1\@H)2TS1-[--b?I+,F.-.>+UDNa]a
RD#R&5O#UH0TIL:@^Tc)[TL[4;X^HPbWc_5/5PBGTbX27-dX4]=4:-ULUS8JNZaS
S5N]..,a9-T:5Q;O0OINAg3eY,M[1>G#NI/b^c<FTNgRVH3a3KQfG@d[X3YX4E7c
74C3?_<f8b/c8YK2XACd/+2IUK5e^8BL_Y2FWJ07c+\-OSG9J&@g6LgK1<60;#D6
bWgN;G,V+:,ZN9\c]8E:N/YC:M&1-[F#&]SC^QY>J2-FA56=3f3UKZ:Y(1#,L/^7
YFCWfdW>KD^TJA+c2d@9a-Cf[+cZ<FZL=S(\UPPS(#D@>7\J]+D?7X3?PaX=_T\P
V4G&Zfg.T)W;KfAE9_7e,E=da2e9/ER2;O9NU^b38IVUI#W1;>=6=]8X/G=1_?.D
1eLRdU-C=MO4IMO76X(2J(H13G4SW.#-]QM:d0c,aQS83-0@-Q)?&fId00B+#R[I
@7e9W0f_@/]W#Q49VG75/+GM&bOa,(Y8U:H>U611:ac>&J+OZC-\VU9CX&301CC&
GA?QSVG/@fR]@<LG8T3<>@A+5VHT)XK:JE7T,0.+[]c+2KJ/#6+WcLP-P&4Z3d8-
7<Cd&Sf3M5I(\DNP_Y2O2X5J]/W?gR7A[e;_,((/d(ag#AG1K9[/BA>)_3B(G:WU
JN3c-O4Hc]NADDL(G)#U(B6B=9PPbc],a91Vg_WCD2JQ@>6,J4VU0eR-\E?XM2T;
LX^:N^?F\9G>N)e@_I/L+RA:EO#ACCVdAE\D3]?A?f@:3>@5_e_C1PQS;TODG&Ab
g327-,1WO_Y784=3X]aE5,+FM89S0,/,I].6:&N.)76A]]7<eK9M46I/_Z=THeOD
g>Q9V7KIB,8SbX\(ZeH]dU=6-X)^[RTVC0(W9b^_-^0\c2F\fLe,/V]3a.&II^Y0
C(,Y(-c6ag/g:CJ7XG,]FKZ@d_[FHbNYC[IcX)&K<:EXc9=-^TQIJ@;(E>KM\._?
cg.aWF+TZ/^P^=Dd;QF1-4/=0Q]RQQN)V2R24G5&_]#[fS&;H.\M64W4TTgg2W1R
N6fB(,)[&2g7A]I6+#]BO,JeW=f&@RC-_cO\da)G,LEJ3G63E[AKPLTN8=9-9ff,
cO>27(V/ML2^.&SFAT,S1PF2CF]fR=VQ6K-F\(R@PNL1Z;^>(&W<F++AK)0+=>+L
JK;ccNb&?HZ,M=1KXI1Eb)7).6D[c1@^g3(bb16X6:?<QNLaIT\7N;K:P&UPe-MW
KQZ3aA22IG9RLR(O2^gL?)42:(f&^/c&CXb7TCOP(UVe<Df<SFD)7O.S30UPI-/U
b,IB,FFcE:Ld.eM?UAHPF5Q)56&8ee3#^cb@Ra#Jad4.Z.H:a:#FfPU7cD@/M2:c
-e-:TB&@g@ECWgOZe3cMeECgC&9=UQ+b[SUcaJ+#,O5>GU>?\WG@E9FZDLZ^+a7[
HX\g/KCdf1_.VcW&ScIM-FcH4D+?Z>3D_();?UF,D)>K&C8\\A3RdU;H]@WA<;N?
<8g2#:QK23ad7;SNMK#<Q3b\)C(=]XRH2.9QC[=33O+#AH&>AYU.[GZ(CbKYA):2
U4/49ZP6@:ND&0FE;#@&54W&fEb>[HIE&eI1(gTXWOQ21fRS4b#-^c6BR<&9ZdRf
RADS)H3#6Y40.87F.0I/_H=5/_27/^\3#30GcR)UdS^S1+f1>;QQO4E[O.:eW1N&
F>)2KJ;7.Fc_D_=IS/gD=^_27V#AF<Ma6QXHO\WJNb72@\]TSH&A+6Z7L496O0G@
b=#N\J,WUI].ZTeb79gBPaTa6377K<NYFG,2Pb+)]N<:NGR5JRF7X/HK2^eb_+ac
:TPDY^G:L?/RVGK#=KT3[0IfHB@;R;<>HWd21E5^ND-AIWR.>P@=@QZ[8F2LH]C\
#_>\dR3&69D/G,7g&Y[LRC652H)PY+.g>.K#6=CGCWU05dO3E4/_GRG:V\&,W&.G
>adA19XD@#Z-O4P-JB@4:,5beY\_5H:P&?;/<ge=M:\5F;LY=E^\=fH5TFeJ;(2S
U:T8PP+C]&[gE:1bQ[?HE0VXXT5WFTcE_KN73#G7AJ+8,I+:-Ueg#OYNe+>VY@HV
K#g8_Y:,]H\2K<aEA3J;X-HI7N^Y^&P&)+/c+@F:)AEO&,\3=fR079HRPD\3:f/S
KPFba5QHB;TZI(K/J;9Z[0Y36gd^f.^P+N.4deYH_#]dB-WV&YF]QLg?K_Q&O5H1
.;;NI@UA\4@G_FHB)#GT:gCB28&\389)f8DHcP95)b/0YYbK+Q:[CQB(H4#cVW-e
1UJ+4E3_ITJ]KN<.X(K4UQ68E8>eHM(X^LH?INA9437SUQ#GU@:IUD472GJE1.09
;aH),EPEf+,f(8DWQUF)5G5:,:0=9>)2?#?.SM<gf/9QV(RG?e_^6a?K@;_WCFbd
[_.3VE[USdZJ?T<-CZ)XVHaP.4(B78R^I-(4Ea>R[Y\^^5@^T&9STVg66+2YOZH9
1;,XO-cc0P,N_DUMG?8gdT8DU/<?0ISAY=a#4@IeG3?AM&8Qg-,=b?bR?1J(Xc4M
JUR.Q@98#B).daIa&\D;=^YM7MH/0J//Da;W;DPKCPHU7=1.fef+<)-_3NZec?1G
FC^DIP#DfP7RPQ<YXVD#40-\abTe,J&72QPeOYL14e(Z95(^d;\&M]3Fb)G^\;g>
\g4G#_D@4P+3T9>+^Y#9<G&]+J27ZK;P^>=&Wg:eM1ETeVM45cQaDDdSZPSQ_eFg
BX/1X9BF[1CO->SP&a4dIXB<QcFRBUTNQO@O:5O=?M(]a;&c9Zf(;1U=@[4ZU:gI
ER2LBUI\4IG#WY:F6QEe^7&-TbaU-6??.5F42d45?3-]N29\C;AC,4RM_W&?(S&E
+b9P1D#L4I?(/V_1c+4<a&KA)W<J72Z0WD;WL,fZ-g#Ma.E9a+KY]XXR)@BEH4eS
R#LV\1[^&9OK8+69RXA22)Y]L48IZMR4#b/_a(D<+)LG14#9?-5/=I.dc\a[dJU0
9[KWe3fJ@E]FR.>NB>G+1T>7:81;)[g&9g&2;@(N0,GdSHRf_4gR7[EVCc=fCLfT
D^,8T7S/^PXeb#I4ee[K5T8\T&_J-V:Igb)D?G\;<a:I)I(1PJW.,>?gR8J45P?O
2H1,18IfQ):75f9.478<\I13J^fIA.15d^5K1Z/1+,?<E\,9(aXX2[M70/6UW=f#
CI-\8eL/=H(S>NHSTWU(TZ^-a8@D+(8ZGU@:dBb&&1J/?@@e)G&<V=D5BeFK\,OZ
+PM76OgI15bH/J7+1B=bf3HK\5<NS/RCM#HY&N\,WYOd2N_+daCCO-^K.<Ae2W#;
LNU;&?C3ZK?(+9,\NeA-d;PH>7Z^A=g2/=)9(KR>J^<1L18Bbbb\X\\JYR9a&5U2
]/:dQL0M\G@fE/&Qc.Ndd3=dU6KYU]Q40[;V)aPMceM8^ESVM:C:-Re-(.E55^>f
8,.;g_GG6G4&35F&K[<I/Z1\M+\K=6WJ,Ge:O>-OX<d,MU4E=+]A^H)@)cW1TICB
cB8,]6IFeJ:A8=^3950^2cURCa(JP<JFPPHL9;:)2MI/8=eTJMM<L=USWGBG&5KR
]g<F)815R?:GFJ>@55JWTKC[L3L5UaWK(5YS[QAeeN3;<K_IP&Za)GV],&Sa8:XM
aK?Q1WPN,TWTY^?6TD-R#ff:fD,XWeJ0[EY7Ea=RQ.#\_#=::##Odab,+KWX4,[4
.GRR&T8G:?0Pd>;cF[H^]?a4HX[?[GY4XY,#N[C6_^P2Z0DVGHRGQgO_HG3)CO96
2EP?D\L&#F9ZN,+HLW:H0U&(7cYS:ge(H&XQ<+DQVa5]7@#];J=84HCdEe_-Y.]5
@Q_2./-EQJ&1Ic@+&BL]dWS2H,BU&IQTgC\BG4.X@D<Y_EN408E9<d>(?(#EdeQ5
RTeg3-4G<+S=[8c47B;.#[:Ve/(TQKDL5@,N;5.(<f5=LW:75JY>PZcc[;X&\:,O
/bIIJ1=6Sdc.+X5?.&Uc6M3>,#>8UYGaG>XQGRT9O8HKV@f8I:bb9=+5HKe65RZ)
9F\V(=,N/=HAT)_^A2]P+(Ze[1QP)S6b[1dg45c#7H?ZM6gYaOE3F-g]=TM:EDT+
C=V1]IGQEXCc)T:W<RMR--\L0(9f81:-U.RSb^?VX)&#N@b?C_fY,N#+4;[116B5
dN)2T3J;2.OQ37a\TQ6((cd1P(Ve]T62EKQ[eK,_].S^P20GH]2P94Ybg:/ac5FU
+50[e<O_@>PO4,)(8E?TSgRR6G80L(NGAZ;0;KfVKd/]6=U&K>fL]9CQ/d[ZRH]L
/6X9N7g09/b#B0X1fWGT:?.WJTI)<=[5TZ#>/1+W[;JNQK^SHOMA-L4,PL,4[\I+
&YS^aRJ.88a#7B\@d0U5fA@H0ZL.LBT2-HLXY\cNNMXWdZYA-Ig?XWA)G5>9?<R-
566&+@;IVLAA2/(+-HWWI9BUNBKE4X03GXBI?]e14:&8@b_I=?#,X.LN]/K2(]&#
E=OEGBSXF:fN5X=^dXBSd\/J,A?gI[#[T.TIRdJ&\>CfJ#W7NUdN&7)12eDC2<Y6
aA7?9M8UW)5fK66C-FSJ@71L853<H5C[GfE)P\P_&@bE4.@Qa9g<&;K0)fTHG06-
[9.+O?D]SZ3&VR;a+5>IZ;fEIDW913>aT;A3\4<4#@F)I,)R8;Z8gD(XNJe/L:HJ
H<X[VJI3V1?93fGKNP?MVaX8SFR&8SJ\?HQ/VLG=Y34PQ:QQP3WL9#FBUT+^,\S>
4L\&ICW@\&&:X-VP5;(JO2[1S#U[NeB[NRTH]MVYf#gE(Ec(a,Ya==D>D:?K(0VK
O]HX,M1^4PPgB]4B;JPe99C4B@1f;R-<Ce#:CWaW)L_I3YF^M.YSNRH7^^JZ)T)?
W5(+01-G1g-4O#^=V;8@TWOEXJ?O\]ca18FSN9)S3DSgA&V]NKcV-+[<]J^A.D,K
]:3c8Q\2,d-J,;e(7+P/,+1-5XG>W@T\R5Q;be[/Z10X(5VNUX3Y\XW8L;-QSdXP
JF<O3P].[_F-;]?c:<?DS+]0=f+d2aGf;-M3=<3?K&g76UF=8f1_25G7)^):CK,=
S4PE.#]2^BITGM=Gf8MIOgN5S[FBC/-U3EQ<GD7RMcZ;900PaFa?2aPU=D#,0G0Y
C\O,^85#f50g^/)ZK;JNOI<:@W/4(S2Ig9KUZ=^4\B?Rg@9TM^c/b904L-C4a6K3
HOZN.R,ABI1(4dI+4>Kbfb<UVaL+D&A2V?G@;&5XeKa<;M/UE4?I6gQd:A8Gf^,6
S6+OFP]#.d9FDeeE=3GQ42OTf_+1QZZO\JKXA-^Q<Md7,U/:-CK=e26\9I40:7>-
,:X-^)eD/aIS(IHR1,.XDS^HGV0f;7dJHO7:MI[4>0dV8B&MD_-1aZY(BcdJfPK=
<7_-G<0?SU6K+0g(9,,19+\g3(@<24V\]6H>,FIAR0Ec#IH;fMZC>aOI/3bg=gS#
<Z/&X^>=^>YT6(CH(OE,BCR(MGV/bIQ>EZ@LW\C[5K(2;)_-T6Sb/[J^,)_E^D<2
QQ>ZE?;9e6R.\V1?d]bW2C_fcCS@KeM1fFdWScPK4[&7&.OVQJ2DHUJZ<.dYgOZG
7GZ9+J>JB6[WUNR;GAC&Q^1P6>(c_(CZNW(2JCSMAe-DAOA8aAP&^,8(g=eF;Y-3
O@X:+#8_V7-g^I\LHfVMO02[3E28N+T<.a:Wb47IHC;@3(-Q+0^(_ICHF?.\SR1&
1H_B8A:E._QFMVTFK@<5S((NR_e)0\K_S9,\W.[MK;LP2QJ=5;24gW#FHY6=I(UKQ$
`endprotected


`endif // GUARD_SVT_SPI_xSPI_JEDEC_NONVOLATILE_CONFIGURATION_REGISTER_SV

