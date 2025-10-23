
`ifndef GUARD_SVT_SPI_FLASH_WINBOND_NONVOLATILE_CONFIGURATION_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_WINBOND_NONVOLATILE_CONFIGURATION_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP Winbond Nonvolatile configuration register class.
 *  This maintains teh copy of Non Volatile fields that can be stored/reload based
 *  on requirement.
 */
class svt_spi_flash_winbond_nonvolatile_configuration_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** SPI Status Register. */
  bit [1:0] status_register_protect = 2'b01;

  bit sector_protect = 1'b0;

  bit top_bottom = 1'b0;

  bit [3:0] block_protect = 4'b0;

  bit write_enable_latch = 1'b0;

  bit complement_protect = 1'b0;

  bit [3:0] security_register_lock_bits = 1'b1;

  bit quad_enable = 1'b1;

  /** Output Driver Strength */
  bit [1:0] output_driver_strength = 2'b11;
 
  /** Write Protection Selection */
  bit write_protect_sel = 1'b0;
  
  /*Power up Address Mode */
  bit powerup_addr_mode = 1'b0;

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
  `svt_vmm_data_new(svt_spi_flash_winbond_nonvolatile_configuration_register)
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
  extern function new(string name = "svt_spi_flash_winbond_nonvolatile_configuration_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_winbond_nonvolatile_configuration_register)
  `svt_data_member_end(svt_spi_flash_winbond_nonvolatile_configuration_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_winbond_nonvolatile_configuration_register.
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
  `vmm_typename(svt_spi_flash_winbond_nonvolatile_configuration_register)
  `vmm_class_factory(svt_spi_flash_winbond_nonvolatile_configuration_register)
`endif

  // ---------------------------------------------------------------------------
  /**
   *
   */
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);
  extern virtual function void set_cfg(svt_configuration cfg);
endclass

// =============================================================================

`protected
Q#.2K0<]Ud<#-@SQLX01E]]PLL78SAHK8AdUbJ(6b)+A_Mf_7H(C0)X_]KHgeS=]
R&/#Q-@a8e5=0;5=4EU<9?CT8P.YMSS[92a/0,V3FFTMa2<bJ@2?4<UO=DZ.&@^7
_GdCQ:TJMe1SLAIE;9S6H^IS@:VaM[Kb^(eM^&L^C)44MXNcb3_IT6]496(^E&]_
F\Q+-P(Q&dLEIaT8?IW(.A)bbU_=gb7Ud((9\OZ5((/AR<cea=Va021:61S>9b^W
[MHNc#<BD>N,\E0A?IYA_V:?C14C;7O<Y2>T:D-gEY];9A0c=e6#TB#?6OgPHA_D
&[K=1?ZG/F]I/)\UJ=A,;@-TOd7JN&g@VVZH?(-^=49a[5I_85V0G]EZU@N6\-dB
H\:<-BX[>X2B_bWUBdKeVI[Id=S7Z]cV[c?TcCY:<eD67MI]P]>Bb8:8@D5@A1.Z
c\.K,FcE)WWCR?[5dTaMCUPC)K5NdXcgSJ0@&HCV^;]E]<+Fgg]^R;fM\ea,\X2(
>ZN#dQe>Y5L6@3/T-)=KeAV;7SPA+X?We.4eR+<N+5P]g,(6G6JP^FJP@OH.&CXZ
<f9TMG6JT2#?H^+[.aWV5Jb:=g?a-Z47^Bc89gT<N0RRR@JPf6J<T;3:R<WeK0.b
OL(C.ff_=?G1DS0IUFB2,5MS0W=+/?5C8[Ed=X9F3SdG2&HQWFRFWfNKBBB5VaEa
)^,^(P0f&d@a\ASC<Ya(H.A=4[SUgX)L:91:=<5MO9/TB,=XP,(@MTF,N8S_NDL<
4+J#UL9PHOR>A#-/J85VfBf^G2QgXW(dQb@DVg1UCc)TD$
`endprotected

   
//vcs_vip_protect
`protected
E,Q^#12<d;MG<[5F&)7SJ(-KHV/c9b&RWYM2,X9GUMd9<H0K++/53(gH+/gVQYg[
XDS0=LIP\/?@/YdV(8)BaKZf?B96(2;-@&ac^U3)33Af#RLJJ]]M^S\(J360<&?Z
a+3^>2.C]L4)6?[QNeQG\_VOe)+Q)4-FKddb)Y9]\be-3[/<9T5;Bc<BWcQ=]E51
K\/0CcBG3/JEV+JF:^Z#]8/TR1S,.gW_fJ2Qg;/+&3#eSg,^aHgF@\Bg.G)MEgYE
1gMgPFR1G#+A)>0296g+Y\<@6S@c@.IZQ7=QBI&(@G<?LB[5:L@C+)AdE&XFQCB^
&e448Q(O_a&I;Kc@g)fb[Y1ORWM,MQ#[CGEXM93=\=.@@V4aA:BSH2ELR^V9DI(G
NQ\^[(V)gYUBZeH9YF?7?&QZ;II;J6ba()^fCLc[0R1[25]?R[d[>g_FS^3bTLb3
6[G+T9-O+S\32KcecUU@_X>\1^G9&-U;f1f^>Sb#NXP18:.3LE/N26K>,6)?(A24
H<<Ia:7BE1J6DJ;Y&M)+.T/L#/D4gYA/GRL;L&:8EMA\)B-;MaC&X1+cbTb<^b_E
^Bd(MTfI<GI0/?6;QWZBT9e3d(ISOGGPDb0+HG)EU1Q,J+0/P61e2+??a7E4gg4+
2?[?)0.O=W1eO-R9LI0)Z[[_L2e7/;ga?e6I81KK1BBKc[V_SX8[MEM@gANY&14J
9TJX+WL;+0Z5K2)Ug.PObg3A8,3dV@JLEO>UR,&]/I6<IO(43YBELb^AN13(bbDJ
&U&]e7);9(]45Oe?ZLUZ)AK^W&O[T+PED&(LL2S6M-3S>gT\cObH?CM)[KV+^9b=
PZ;E#,cL)gd9gJJ]8+\8J447e]0)Ad6WUXE9JSTK_(OT)\1[Q5N-dE1eYfE&9DJb
V^V8+99cL#1./6cZW]Rb21R<B4c,I;1IKSPb_HPZ([d3[[5X9-5[+9(4JAfUg-9P
@3EI6aX(+[EL#UP^MXCU.10Y7GX]M<Z81;\XC(FL38)6B+/_OgaLDMHNJ5T:]EV[
([G,L_(24;g;X)>PR,/CVH#A4f<U</Q#&:?)OD.&]^b^aLgL&7>)\^:HccWb?I1;
1f_0=6=\,fQDGUQPN>W@,+J9I).&IF7?N;<TLb73HW[^O7IC;Le;J=1aU:W_c>a;
&73.7KHWJ-=d,7e_,F6^0>_>\VMDW;0&R^+IS>T#)D&+L9.dg)8E@BXVJb/WEZG@
2:H=g+P5W>M0NE#FS>V+b9I)_8IOP-,gXN7AKdMeg8:B]9bcA&+&6+AV^.M2QN4K
E<LK,=9Id7ccONZ@CV^J>IeGUe4\QS2V.+GC^(G784G=\VO\YaYaMCPZZOOgGfgM
/;H#@<.Q=U_12[@/HF8GPYB[cB&OF&VL\N/AXBK2??<&Q8?TdUa6b5c@5#C[0Z,-
gXN#PLVWPg8G7W39DM)-X2@T<@&f^ING1aBD>,fP)IHBaMZgROJ)-.A;AVbJ2BP2
I4T8-c3dN1Y<S_?^AQg6,fCGOZAABN:b26H.<>O,Z<J7Y-]+6/E?/K5,/GZKO?M_
aEeb2bSMBfd=#9fLP3]Q-<O:#PP#e,+B[3N>A,Ib.8]GWe[?cddgA6UaRZO#OT9:
E5<(S4S]G,EO^K+6:/<[&#N6-4HVeP?-g#IFaP8-^G5a/fR7V?,-,(]?Ee/AA[MR
F-(^-a,Z0a&0cOAG8G/C&g?Y4f.E8^\O35f@J(LFD9=\&]Q]=LDeV@\Ve?)gXGPE
S.Z7;.QC@LOHE\+P6Q<Y,<<ZVf/T[\a^E7F,P<)9GP,?RMcZPSP,7Bg,(OLL[V:Q
N1R(([ZAJ]#J174Q.](2SPcDS>\YMJQ7ZF8b&O+<\6ZaRYbRAG89fDGN(eAR:45R
?1IBRIQCTg8NNPHC)VH^/<=[V9S&1G-UTAM#8AH0+=_,++Q&;S=]<Ee79+.OcdT1
(Ef@0N:>XAC?\f?B::D>Q?-Jg1MXI@EL[[RSECbE.,\9-NWI]^TFQf,_HaGMR<Nd
1W1C7MLD#2W^GJ:H1f^eC:1U<PE[+KR2;EB#+agPE@,cR+>,FQP[e;Hc:U.-/HIc
Y^[\YJJ/PVQK?,.-)Je+]FAUX@A+4_D]e@T,5N:bJ>aV<21aEc)X6NcJPKK+f^,G
?cbC<9fgE-3\ef]#eDV0X;U?D_^1@-&FN<a030WPFGZdd1&?2FFE7N35#b8Y&5dX
\<E/&RT;-R:E+#W3f7&[NW;IF/df?b059U8>:dAB;MW,49dYa:KBTe=#)a_4ZZFF
:TCBG/\P_5>9X.I)R#^SQ131WQ[7?BE4^[<C(>PLfbQCcWTB/X5<dEA_^;VCW:Va
96gP58-9>_QK-L^f@&eaL&V-M.R)>92,MKB4F3_2#)6P7S)[GR5:XKX>DCZA3]7?
L/0J+3a)]3g4f3^>g2O<8R^[3H>\&<;a.,+6M[#Ca=0510219CC]2[)+N\Pe2c6A
:;<U:A2:C[)E-c<T.Q,LW-7a-MSD^:UDM9-)aZ<Wg\g&fPJPS4a(V)_JWCc0MPde
3XDMN(9C10=TV;.JBD\MC]5IDdWN1Z+Cg:[_I5KfAe5KCQ4++N-K@2O8?Z.R](^T
19-2U[X&XG(Y0ad_ReV:S9.eXWLQ?\.8+AIB39dU-T7>fNaXP9#83X48EcA9^IE8
635-/BQ^)L?+f1I[O=@9NODQSd6P[@29\N7\NW++T@dA;HfAE,8R5a?/.#A5\_L_
UT#Z/]-_7WV#<CAT<dU@8SB+NG=\&/d;RNZ2aa]6.+>0R6RaCYPN^gc#CL^ZCM^;
7:1L6M&2P_L_SCTC_7)ZN^\;);KX1b+5\a@3M[b]4[RgQc(HfPK5:&&C,=UJQ)#F
cFQGC]QB;1TY,^WXIV518^(OYO9A?99V@f=Ge?LPD<B.:?OcH<>6N@Md&CP\XCHW
SR;a<4gAW6RM,>6S)+R5[(\=,E[LXF^6LD=2/R6,OMQ])B.ELe&@K301d.ZeM@S\
b?Fcf^-@T-SM,@8SRQ:HTV-\\O?Y^CP.RJc+@8ENDI&XJG_VO7+G02\YZ.[HgG)=
7VT6+.CWSg=f)Y3CGE,G4Z_Md#9aT7)1LV+AYOgL7CNKEYYEdGN_)F?:PcX@0.dK
XQH/cO>G((D&)cF:04_-KDFRL_JF;.(-]V)FMR\VY9E4g[O?1X^T.Y38g<&WcR_I
b[J@YA6.M[Z+,PY>0.N;&:N6N;OE_+MeWfM@W>H&S#L.HNDI[Kb/^DSLaX/:S]8(
/d8=PTJPXM1&-XD7Ec1OX13W(BO&7.S;QD5<J3-1H;7MdTTWg_,9O]^>cKFT4?X2
L_FEC56J9,(4(6YNDL?/c2#2QQ;,<?EVA9L0Z5e^DW;F1L>M+(6(+L&ZJW&1Teg6
dRP6QIY/e]URYT^SVd#/9b__25,OYU+d435IL=5J(0(_9WCDLHaf<I#]XBgaV;ga
^S5)1Mc?QZbB-]aFbb6B.M&XD_]fX(_:;ZS8ZHc5=.H[1>L.U]QW#_RR\QEAO)/Z
6_//4W\/[9ZJY?^17d^(a><&0b)1/^E\&O?b_;f7\@LBbE8BDT1>>PC-6A(@D.55
cW]\\b+OK3V1UecY[HLe8FVSD:X8;-8#[.</.S0Ub4P3KLA/#7IJ[99I[)Z.X.)c
G?.ST?V)X:Y_:G3BVf:V1C@\+86BYgKPLK_G2P#F5((MCN.]).:XgA.&L,0)MbJO
GH+dR#Y4^eR6T>cX58@9f9S;P#SQAaZJ-,@J:9,U&bXFT,DJI_.[2(RLD,.D=bPT
IdAX59<&N=_W+HK+6I-E^B#NOT7:BC:WYbA2<O.R/4>,X-J<#T::F8:JPPX<C=4)
[_eX9PWCK?Nd^087gfC1C_W4VEdI_3TBeS)S@<U6(BNWLcHfCP_:R+g7@2A;4GO/
72CL_>bMbY5-B6C.5V(WQT(-MAV6.1#M&28Z:OH(-:0/K,T99b]Y(#Y@aC(0c@XB
c:QH(ETK,P-[8.QS.Rf4FGgI1118H_V7_HgZ&323E9NA@3dQDb_;E56cX2dScF4P
#8gX;RIP;PB3@>O2OPKX[Z0&9QR&FGR(BB0,YeF49.&FR)IEKZD4W=>L6318Wfg.
&&MfgR^Q5U;dWUgCSF[,<03O8Ne=dP=HdbWTFX\]1-4BW;R6@Wf8I:bW=L,_H@DM
(Z>2fJLB8gG5@G>JJV>:@IVKU[2G;NFd:1&B4NQ@_e81AaM&O\T5#P&(bBD05<(A
cB^=4TfZ89/Bg=LE^+>A>ZfY9GPdba9Y14.[fgZMdFKF63g.Q7JQ\/3:0^LA,=X^
Lb>W69Y9K#H+dN]]gPb(0FH.JED>?^2@eS@Zcee[G@PL.G=>G))A(<ZIT?O>HCdO
a/T13=45@A.[<9/5fR_(H=E1:Og11&GDR]IW1ePec0M,c8cX,B=M+#W7>M:B_d9<
_U+W#[cBH>L=6:4TM5=>U^)I&DXJOc?c[f<#C82#G+^IdK9#Ic823TX@fO;XLIW6
K;cf01FcK_+Vgc8;Z==A5D;8;#A;)X02TRU/1<3ILV1Y6UL3+Q)YZ0#a/V7^M-J3
5=H8N7VRM?25MNB9=^De@2Q^4VBgGgJRH).f^9(2;K1G]SRG-JBV])>Z<LJ221SV
EJ37#.MT2[_]NC5X[\d\XUH-Se(AMDMR,A5:b#[AfKZFC2O014D;abSSB@2@P.9<
WdZLP=M:<[_VIaR?GUQ)/K[.>G]Jeb@L9-I)YHL)2E#a=0d5\OGZ;OgN;d>C^K?E
\R[;.@-_XGIOa7f-H0d/:H#D4b&C6GZ2bI[MAF<IBYDec?X_>HPJ&M8+;NX0XGG/
2D;/4VZZYW;\6O=,\K96@/aMf;(0114gO4YB4NXPY=6Eba;L1R^4/FHA)UR&P,;Z
X^9,LV=5fO]SCLg77GLS.cT5PNNYJFZ/[G1g\DX:L8IN;/90J;VY_J=8BEI9\HDg
_UO?T,?652c-1W](g8F&K[e@UT5GXDS]+YV0=E3FcL<ONdG8:+_\8@3Xc9;E(ZAM
M+#&6ZS0b,df@g<ASHA(M;64B6<AIGXd,0NgI)->OD@HE.W[XY^3#\6LW,IZ_K<?
?Td)TeFXAYWDZ+&E>.FKL+\9^^WGgB)XDQI@W-.Q3YDcWBT?Y4>9=e7-WA@N7HIL
+V/^BeMgA\97]S;HWQ(?:P@bdb^T5e6bNJK(6PTUfTCBBMDGCISJ6f\6Y>CNS?S7
S>Hc-]Q/:EYaGLMA3L;4KAN3-H>X;UQ7_,A/>V-&<26ZgY6\DYQe;-WWZCQ)2.I>
e-\XXR]Ic\&T].FZE/0A)+d_@c1QPIFe01>):#O?^Ue;>b7e^(QQ5gg_C)G3XS@5
AKJP4A>Y\d0RJW-R[:cSI[1R\.RD^BYg_:(T=.3S6.De+[C[XPFK<;ZBgId0EAV5
)<F<>.bN^C5[U:HA-A)DASKG5[;<2a<.AR;Lf>+V+>(LOg&;7@.TQPFG=0cVO.V0
J[+;e;)<I2PL=G<c+bN[DB:=MBTZ,[F=7b[5g96TWBaJAJ5N9PU[\IYG3MWVWI1Z
UQ8DA]IX6Q@.DPWK:YN5DIN;8([2g_e4agZ0,2CQ^::3CAdA@UU#XdfEYL#C1@J7
UP[aJXBe\8^f][V7Y1MEGd]J)U\GW1RbF<H<W2.\S7VGH+;;D==,bYZZIdZY0e.U
<HUB8+B2\=:Fb^?3CCFMbE@0JJBgMZ.gK367)0.f^TW0@2)9#>@BXRI4I+BY:=3O
;1@P:CMFOLT,0Z)Q)Q<+b1I8W.R]2]gg@[+JbC(IV0>1fHZ4TLYg\;N))IG^;1=7
M4.eZ&GOZb4L#7D]/&#-/dWH)e=9:f_6ZA=dL:f)E\VF0XIG:#b.B<Y#.73@#1TP
ag87+[e?cRJc(?X?,\O<BgCeCbC.d;^DYF?3=BL[,MOO2NF@^a<aJ<0E?OaB8E&1
SF9g;CaVOX)>-:G5,#-.,MP5DJLMAaQMV\:(eT9PD[Xc(.8QSdK&&b2KYW6HWcB]
H&&-23a;Pde-/AE.PYYE=@1S,J4?GfIM,#RQTF<N\38[\?.X=;N><UIcVG7&/M^[
Gg]Hd-H/+)9=1NKNa9PXb2N_H/&JCGE2a[fPX.7@+.aBMg\3X(&#F\D_;b(W?7_O
-,-([_[0&=N5NeWUcc/&&gU,J(TFQY885=]#\,)^/WFd@S(Y[J]M=;&VG.6>[f:7
Y33(fe&@ST,6R(+UBQbW@DS3BYE4681cPc5YfJVe7f;f7fP:D1JS5U_BWRGQ+1[c
_(cPGYO.-QAGG78J^^8eWA]KcN2LeK3U?+1+>c7NJ9(E\bIe?E<c?aJ=GL>c[[>f
H<9bcGQ==#JQcgIE3cMdJ-X3U3O;#71IY6@TLYc)[UWM<M(<^Y(S<Y1?8W3CX:3>
8;]A/SY?[-_gT]aE22dLB_:Xb+][SPRL&M9KRL&Qb@03:>JfJZ-@N.1Z781c/VEX
<35A=S_cMA+X\eQ9[c)AB,:Db7>M.,>8>B<(ODe+eIJf6A/+KT#+UQRJ_-1_MZ=N
Qc6C?d9dFZCA_\XV=TQR>2P67<&:9/:7g^=T.I:5.+I&<T^R9]eLNX,GY,YL((Y]
JPJDS,#bdH+3YcTRUV51_ce;.38LSb5&U)>:ZD/b5OQ91QPeNcgX_8#8aa8.Y&_[
O?RVP2#RCd[._-6J/(#aMBC8/MG8G<Q+AHS:+<9>=TdHUHP<0=g()5T7@NLI]?N:
cY9)V&7gDDMa3F0[K?:_9+1bRQHGXQZ[KHZ@TKaL?A9OeZ_&>&6df87:C;P0AVER
GR3CTL47B8bea6Ce>#UYVb[+60FG.]=3>0C-gSX0]0]9P@M^2]J-\YW>2(b9aH;H
XRD?0b-)8;2&YX5UVb?HWf<#3_bCHH9c]SQ6>M]0PI&-HCOf[]eR\2\/0Y8ZcBMW
)f&=.#V_3Fd2B8LT(8XMK:fEL1+)@=2Ze8UOMY\1TNdNEBP9Q=Q[H>e<JB,7S6;g
)YMg1Z+Z_?.f,@+F:Rd@ZTa&5:WE#ZG^cRdR67Ab\H=c@:(a.@?F5(E^KZ8V)9.G
VcYH4EHJLa:_5gK\A=K@SLVD>[UXP;P6]&EAZP.G2;>PAD7-P_RWIeQ=c6/_-GTc
.NTSdO?3He\Y?d;J>).D@N06&?S7?)+ETT>K^:#6^<>HCQOdI>DWUW)6P#MbCFXZ
AgMUe^Y-2,9@856.BLE_:4?RR@88^[0JfAd;A?TJJ=E[^N(+a^8YPCQ.gH^ST@W,
F)+g:)3;_cbBGTf0K?dZCSDX,H2[1F6C<2&8MPN>VJdRRL)]P7MEDUNS@1-)GZO:
#U=\QF:6[dZHK]>#eK;LSRg)GOM^639)^NKaV6W5VVRc\)8R[\^C=X]==OXM8_5@
O<H3O#Y(O(Y)9,DL?K+I=g6(HBT\G+Dd[70B#MfRG(G5Y5@N[a(F/2\:;RFH5;TI
g=DeVC[;-E+a7@U#2g8f?eHI74H1):@0#7(AENdFgATM<f(gUM8fP2ISV9ea/&N;
VC,>9X(\7>U-?UF:7,[T=3]7gb-9.UGS,&a_bGPgeGBOc5J]\g[dGZ/4Z_CdWY:>
WVd<^;Jg-OHY&cU3@Z90b^QH=SD@84O]4I(ZZH]>>/_GdU&0//1+d<PVO8fSU>H>
aULc.-]9JDTZW(=FN&(8fbgRYc<d(b]2&6-2_MM/#R]\bP<)eWU;,b(f-,JQf?^>
.C6/W(.e+HbC4S]FC.KAAb(dJ0Ogf.dN.[3);2@ZH=WOZ<Z9Paf+?H)O2H^f;F8c
3)DQGOFVeN+5Dg8L?7NG-1LPFY]c-BPe).Qg.QYd(8e@DOB&0FN@Z:1L@>)S8c/U
[0KgL>WV(43(TAA3<(Q&Xe7Z8FS.82>9@OXMT]D>N)Od&9O;KH7d\VNd@@J<)#(f
4.6\)//)_O]5T<)PU2_SAF?T76#;]@Q(NV9.MS/-5O66R,T3HJSDV42WT4@[cG81
L?8&BY@RO8LF526d@0KAXI^EW+9C=Z4gM0^?_@Zc/UZSJO?AIS5S&(eN8Kc29BPc
8TIaGSS0(9H6TQIZM/_RFKOaa:LR-NL7&&[^0UJZ/OOS+ccG3?.5[08G[/8,eJ:H
cX^[XRaa4c>)CXdc4g;73624W<FK[cXc2\O=L;4bS?<719?KG]H]_L.a:D4F\R4[
D9O?U]1]8EGb]5=-[PS52X([I1=@[/dWA?DJEFHV&U+BUS[D+bONI.)U&0_H#JVg
8>E-NOK6eUeGEEWI3=(.CHS0;M7[?NA#DaW4ebWNLW)f5=aCTW4[QC8E?_@Y:NQA
O)a#g+65_AHC[/\/:C@9=.WR-0J1;C+SgR4;VG06]P\a]=,d+>,([e&c&JXD9-6\
:,[ec(g0HD??P?.&#g,2TEXK3&d#:X.QGL0b103>/T=R,K@=#G_ES0(2fA5T]Q30
54EZ.P)1gQcPS1/#E4&;UB:PR)07ZZ(44U\LQ6b-AFb1(,@SSUaESB^,X7a>W.ZL
\2)d39G2eT;eP_9-2=/V3>(c8B4,G1(VBA&N>>..R9?.dSFADVTeSNXHYg6fIN1B
3.AQNTgI7P-d?&(8#^R[;LPWD46.2XT]DW_IN&e0@&a/RC9,,ERA@I_L=(XcgB7U
\Rd4Kc3[TC?LFH4(R--0<8EPY.+6:RZC0+4=#7[^KK5d)=,Z85(XUYBT5^eGbJ4M
U#?g9bG;I)O/#Jf(VbLUEBTMd45A_,D]W4X&U;8SBSe+).c@@=HE@5J2OeAZTI4\
::)7GNE\>UWF3?#<JQOI<:;[UTPG@,XRgUU>#T.W\T:f-(;3JYM977\Qg=1\Cg(T
Q:7XK_<A?8QW^3Z3,2^Xf(:D[)JYOE\&3+P><IcY_S?@Z1&dP231(HO5&aP4+1<a
gZ+#W=B#5_^NdCd,9:JI6]NXN-_I?6[eO[CS9S2=APL.0R[55J8O0Lcf,CHdRXaV
=H)DWc<<.;^676KKF6e.a2N(E=0I:-f[]WeF=^<?^7_.,XbHF+[7SK-1H,3A9\-X
YGKdOD>6CEA1IGX]F6NEVE4Q\E)cGRc?C9^EH^fd^e,2e/24CB8CeH[Q>)4XALa2
Me^MaBg70CU:(V?F;IX?^A4Q8^SCUC&F^T4Q>9[A8cgCXI4g.3+dN_+]0IT;_/OO
d8/H39,<Q_M]U7(gAUIZaW3QW2BGZA@[Gd;R]ZeG#[Vf0>:Q5VPaE3e0(F5D&]7Y
YQKJM)VI)RZ)HB<8W:CK^?fGOXYSY+:J[/VG:0/LeLQc-M+65][G+SFU6C<ZUC71
J?EU&CE(TF\#&5L?9g4-QCNBe\NFOLSTPJ8<G51^c6=6_>W>I.#A2P:O/0@Q\B3D
g&136@g&\M(g+DDd,K\B-HAJdceGF8V?+.8/2\P_e9eaMBb]KS/2b_OGcE)I3Xd#
d-[Jdae/\-<K=e)?f)@,OL,OY^9A<4<ccCgfb(/gVU:e\84V^N-9fgN<e\B2>Q\Z
1W&)YPU.EA7P@A)HHFD.4-,IfY5+bI/(fdd&?<Lf5ZdR),]<:IOD(IW-O67DWZ=g
=UIM8d/9RaS)ZPOLW:;Q6S;CXG1=&S#/UcD6Y]Wg0Q_+a<H;TV7c\Q@PXU;a:/8a
VG&/FCVAQ1&e<I.ddeb_#aK.;J58E-@).;YCQH.UOg?H_^PP1O)+I)&PC?E\SPWH
M:<5#][<@,91&EZ_S_EH4@IZS2;=Q77H&E>Db^+?M[>@a?[W0HUK.D6f/a2.#8:J
M4(Fc,+S.J[H#1OYY@&6]3Zd)/&KO\>YX)&?7?ZW,ZXRU93Fd)aD0,((c>FN=@BL
(X+;0Uf)P5\3-N4M()VFTM.CH?<JCW_TdK\#M(^I/O4=PDYJ=@03RQc=+]K8])87
db#>(XCW8^575d:NEf=Cd4dT-7]AgQQ<+<>A)a9CbIDfg4c6\XcFJN/d9Z-N)B](
X6QUUSEUTg]:e:H>\dB4FFe/-F=>Y-3ZC6?I=Y+6/5P&)=JGGHT(NJ#11a;\_KTM
0V4@?>^/YAXL4EB.1Va60-BQDeR([3Y]0SJ:NTVXSfa(5PB+9QLK^IS1&@YBIV/E
:#K,M8c7@Z_?[8?QUF[0#DF3HPNSD<Y,Zc5+We<Mg#[36BgeM5QR[c6RIc6,(=U8
CM;:&J1R&eQKJXN1+[?G9&4FQ,0-WLKI[W)Z1aR\eagR:fD0-+N]99OT(Rc?XP,G
C@Y8_XCaJKQ4(F-Fb+(NH,e5O.OY)c11K-?3P1GgSF^bc@Tff,1gB>)EKVHU+Z_/
f-0=><&HJa0GG^8,PeY(RS/X<?/8TLcO#>56)FIJ^#e3cb2)[4EKC#:TR^24HGH)
?8E0\44/VDDC6<76V&?R,8+@#>2[fd^XgVVRUPLc@RN-W@_99fNf;65eZbR48H,H
QMdZd(N_C53LM/6S^0AX3:J6(=eaTA:MP:L&B\#fNV8GMH=gGY3>HPH.6S0F8-YO
>7];=d6bUB0G.YQ^9[8ED+RUbI3:.f1GU8L6UgWMWFW7g-&K0H90D(6>;HWTgCaD
RU-3#S+F2_6/PJ,^)>\LFG?CBR3GV6]SVI4Z(gFbeTCdB=TM_;\+S??,\][9^d2H
F#eW#(0+ARH;Ib5?2<QS+b>ZS87KW7Q>QbQ=M.4IAQ.M4VZ-9ZUTd3fS7@]U4^WI
:UO:YNM\.7\-b_==<EN]^AQ5?3.I,XZH-\;?,>:OJS#;;cRM89f;aVO>=DMd+S?Z
7X#TO?AO,N#X?1=c:f;O52]97X_6PdZ9fNN#1SG1IEN&])c[d5<&(a81YK<a9e#?
N0_aA1QV^BB\0K@95\\/(/XA0G\.cR>eBEd_-?6:IGgO^_aYCU2,,2He,2<\6]6G
D5<D]^aJG83aRTeg&XRVCE,,E/NgQJ<G5a,LZ>.#SIE9RSW@)WR4.[Q_UM:WG=67
IXK4fH?X2Pd_FbG;Q(<F\c^Z]@(]A&f?[[D<,RZ7>@.c<a?Y\79^WLXgJX4DK9+_
#eHR_MY0NRY>aVcPHL,>>\2+[-64/6?U,=A<8G^(=A62-C.7@\62Z@-JU3Ib^WB,
LQaCBAGV>)bTM_DILHfd1a7>#ZZ5=&&b[1?fJa3JaDe[dHHK,fMR2D>SfPP.-Y<P
c,SU[3=c5NC>DCGeYOYHZCMI.;=,e9<Y++,f4MFfY-+8J(;FG]7@W;S/Q-VX-;3W
ZN,_2.Jf.3B(@^\I(#CS1T-2O7.ePF:@[HF@E)0QfK#I]f3)A0Ia[=#I+f&Ag2dB
/DM6Y_(<)C^+[caN(:UbP)E,?28R4\&S(]LU_\Cg\/J\g0AQ4RIE7M7CEg<b-/OB
;95H]bg4>PCG0VQ/W,<59B7a]D@_]Q3U_?]2eHCaZQf7\E._5=OY#9CAGF6);28M
.@LE67[bbF&P-HU@aVHKKY8VE=YIeZbe819E6=aB]P5@5]eN5OERTH5P]d@FY+0:
PCaObT]7#OSHZXXeCR<AIfL;ADW<K4e?/NNfAb^&5DA5>&IW+0LFIBF67H?JUMYM
)QI/?LY([^<7G<IE5;&I-T(@f(ZgH\\;L_\F<-4V^5MaUVU+H:VC-cAa<D:8cAX2
1)M,EI,/;,AMDU8=X52IbWfEX=RJHXIFM2U7A+9JfU1Rg9H?VgAW)E6fD[[eSQ-C
d0(DK_&W>[,1&F/g,J]&YZgR:S7F?@DCY9C#P7;[eFS\BN]cOcfLE1.KWHc)I^T+
Zf:?UAIDbIAX@?T\6,dPHAbG:1=>Q/YeB<X/L(C^,Z1,#[f[&<NPc)9/d;3B1+@)
G;f[9d09\>/S@>::e>@AGB(,M/OTPG^f-<Z6V2HQ7D[F>=\T?X4=ZE@IZSOM&>#&
L4#DSgcfZAaW@NN(aPW+/DI(EZ_;Xde#A+&C2MI42#&@OFQB_V?(RQ[B3.NQ2<Z(
CVDXeZ>X&,3?4V;_0Q]ZU)fMa1gWH>T75=I7)1&+A/ZD+[#2G3_Q]e3]+I-?Y#6S
@fF0[[F4_A)K)V1I.#L_G:+:,EM<?OU&;ZQ+4K>4C-\6_aD41JAG-8Ac=1>((6g0
e+>Dd5c[6]g;;B4gL#+26>8V[?YLUFMI_.bZM\(20L-g[<GQ.=/.6K3gXcd#H@MD
bf6eGP@723)VQ_Fc+cX/(/PB4IPJRgd8BbMR]YD(RJ=eY\0aZCbXWFFN<4VbC&P3
:BE=Y?0Ae\F\0NK>fKZ2<S]g7G<#[/)\gXV^A/QS^EFVK62_>0?PL0UP[]2G04JL
A<d9CBY(&\&_;.<>HZUbCLgTB&BHQIV-GY:ONdZNI=J=&QFVb0X>2Y2JN^G?431Y
,7\F_]4&X\gCbW_TY^1e9W\gc^\#3eWM,VP=E-O?T\g(]0P4V)^KeCZI<_]KgV47
),,0FcD8.J)B4#UZ^<F_P0,g3SAD^6I^4)gG33O@O+b^f0)^H&\Q#X[7IZ_ff4_?
,((5@P.Hb35OEE7<1M4V(W(U^#<331.?O)L<H2?NLF?<OE9KGONde+B.[Pgf^EZS
U\aYI72ZJKJ^(^E;ENN.SS)PQ#Qg2b,RM\?U5MH9=W1R,dP8[0[f6M7U/4cHF9&1
f=&3+Z=PXP:>]W#)8OWS#E,Y5^=5?BHZ<;]#8[RJ+P<;QEMY8J_d8]++VV-Mc4eK
eaWR\^WSOEE4V<M7ca=:UEDMEaT\]6=>4NQJG=S]ec4<b;.4/^S]S@eg@S>/gPb2
SQ^5,\agN?93@ORdJ??Q<()2Y9P5\1WTJV+C<fF9T170Z;A<X.LM6+>ALNV_&_WX
I9+7S/F9F@fg#E-f3IfHf]LU3Dg1Y7=1+L<\4MZE2S@.Qb+.J?O=Ib1.G6U<b7_0
)7?<UFN;J+gAQg<FK0;\7LQ/.MINMXdGc4AO\aJK?3Vc81&-SEHM,@-/Na3J6&G@
Y+0\]5N&6gYOFcYF+X/UB?BUB.Dg:MacI7=ICgFY,C^A9^=gFB?NR>;c<2c:70=E
.^H6f8F.IPOJ&gb9^2>6KT2F51-T^#Q(]5/3a6g>L.VD8cO91WA<VAgKQB[UgS_+
VT#GN<;-(H05GK-XEY@=M[0b_MIERNcK0^Y##]YWSJLg?40a.V@F?N88AZH&.)Xa
;CBb==OADgC1F\EY5QXQ\(64UO7ZB0W34(9.QO&_6)TaKW<4(P\W=(9\FE]FdL6Z
.c)ET#S;O-?fPX1:FBdMN8PQ-@U>O_9_/R/)R0NbRDNI/b9Q7e\+ZM0OA+U4+eA<
0/2g3dLRMA85]I9_[?9SLE9O;dMV&LFgM9S:87.Ye<XO6BAOUV+-HZRYCCeR/9(0
HeQdJ=)5a>Y)5d:I5g&/R4fSN.>HZYGVOLVN2Z_H<^+Ng:Z#f)Q^HT9=6T(3?6a^
LFP=PEL_GR+#?Y7PFQDgZ/53)aP]bdLCe.UC,>XS;bNO_71#^LS>](f;)/0^AR7:
_E1Bf2GYY@dGe[WP<.,4NFEgO(a].P/Cf1g@@PB7\F-3N@/6bF2W][=:>c<?JfXB
f]\dKJY?:b3Hg+\F=5cBfZV=dW8Y&U@MEKFd6LD1;))38M_K0)0^FcV/O,D)@5P4
_70cC2-9+:QM:aWJgdN:4@>cSZgP)7^_&U<De,OL4&(?EGXU1Z?#^]&f8H&RPT1V
bg\VV#YUa9Ja\X1C>0^])1ZVcC>B0<T7dJbYP2T8:XI-dfdQfV?1S_MTQS->O9EU
bN]]#WJd</4f\5,[()aWGQR:[O&e=L+P?g93E@VI[X(g345\\L/.=G/8Q;6eK:1&
g;:fQ@\dTEOYVWXOe+]XTYAV^9HUVBL<,I2f)<44ZJ_)N7A.QeZEZ&G1VQ59ZE+_
4cJ#4?@76fLV4U0:AX)0OcUU-WaO>EPfHRVW+gTXV>VEfb,.;d2NNDK_)adNVU&D
JF7EeUXV0aBe_G8C80)8CR5FBL&924RAA>fe)7@Q+]VP3+,_9Y)4DAMQ4-NGX:Y0
]=P0Y5>??:62MSB]Q[1#L@_]:W=C93G3#;;N0\/0,5:9KP?NfARESVH/^NI]VC:8
_^=eb0U<5#:5C,be1=3=FF_Y?99\72^M@1+6RYB?VZXa,(=WHE#EX<90@b44e7F,
BHIc)YRC;9#^M00XOTY8KDMePEH62-H6V6GLIA1@gWK?2[D9[N5A[X)-<69BaA=U
S1QV:D]@T&dS9_FL1@8B,\eTJF)+5=)LP/NTe26KTd\G/HB;W6fQAV-S6fHA;TTJ
^R9XGV)3LD#BcP:,-0W]\WMHE9XY(KV,:=gBd-[TQ,g0)BT^=E23OS=;K3:(#_A#
9DGF#aF17-N)YEa)SDE(?9UPZB&1PJ.b@.g#_D-5?5HcN1SeYSQTRS-;4T^X9X#I
N7UfaKT=;PGHDVb^AP1f^PQb8P3WfU7<?QL6O7QGD[MFbd(6O8DQI_JP+Ua=IQ]:
9U5;8DR_^^N<R^3[L)P4AcP;Ce]^0(UMCf:G@9Q0SZ9]MNT0bQ?Xd4#^62ADTS1a
[aOW]MDRTL;\fKV[./7)9R6\44XZ:^BLLGA]F1IV?3f+^\L,J&GDe/d)^NRY>ZLd
CIe&aOAe@;;\cX5NfM+()(S8bDCYAJZRb;H=7R/R[56<\HWJBf8bMZC#d69HIL_,
c]b_^+\BT2MT^RV2/:-I)[0g#+/>,c6=)UcL4^O0&/b_I@FY[BG9Y/FL_I^M64gL
VBH+AWV/MLYHe^1U_X]K.WZ63b-/eJ>GD(+6.?V+R@1DI=E76FEBc&C&L?b<+cZ?
Q;F=K@e1<HCaRHGgBP0S4,U=\I&.LG9L:93V+WY)cAHYYG3abOU-]XA>^/8Oc)TL
,-#:@e._(M6193:C(S<CgUX;4GJ;,6<UEA/,2E(8cP:SET<MKQ[1XZ?+9+WMGP.7
AA-I^NO#]=8Mg@EV]_E4EMbG?Z,-0Ee=(HL<aS^<^a#M]O\MN#.>-F21C\>]0^g/
JJ;J78H+]O1HLONbN^P7@KbDZ03]Z>a_?\M[BCT0-\7EGSWX1VDK;>V-TPO1(;68
)C/VS38#>VAIW)R6,E8bH\,>HO#5ZL/,XQDZNHg<0M.@ea_]>6V043M2N+HB+fa=
Y0])@O[c?Vb)8HR5e_W7E\fF=V#YA]29[FZEPOP:]LWQE@_4.KeI(-3?YD]cb7YH
2J^,-..7IW9SVRU,T/YQcS9+aQSN&]2W//,OZBBHYe3Eb\M&^;OJ5Yf5B9GY0]-Z
cXNJVF8YP3H)9L+=6_KX(=27;4@9=Fc5;JEIJXF,/KcA0LIU?,(@9PR)_I_5,;_\
+B;=HfQJ;eE^&4XRCDTEdR)=>Ge4eb7_Y)O5aD2Y;a7.<614Q(<OZU#4fb<>fTJX
@0D^a5I;6Gc>;6;)(KZf,g<R\,QZ@-K^ZfMSJO;g]K,EB.O^/S<X+/S1(B]X[63f
L?d,I53S+3^VA=9HR+A6FT0J7TOb^CB7#@LbJa<T\QU&Y@a,=^BA7YF5b6MHF\dK
=6K@FM^GE^edc+TMJP[3fTVBY16(&/fSa2EbC4U._<AM,0LO.O:DEIJQ+\XN5]^0
7Xe[A9>..1PR@7A>,;1gA_@M8N5U0-1L\&/Q&)&gg2eV5PSB(J4=-&3=IZQ#:3Ge
#eEE3VVUXdSRV15NB?c2.[\.=17cJ_[G0.\8WX>=NV)\A_#c;[?6WXS-Bf5TC>VD
5+b<6:H2DI;E9&W0_N.RB#ELJa0\R@E(:-^L45.1UVOdAZXH@[MR#TU^gD->](G/
6_1IG\B#7PNFLI,B@9gF=-3f_S;A,^MCO^gYV3Ecg->BC&cFX)IX]=0c#b=99^<<
A&4.0g\?K6K5?O1e19V+B]:bC?SKFKV9E6T^P6fNc(CUMc@Q@U-#+8[W^Xe9eb1O
9g4cE[)Q\b-UW]R()KFOceZA0UKP_I-1Tc[Q;=g_]F7E1f7(+U9ZZc.bgBF]Q)&Q
TFYDWB>Dd8Q_8@5BBfdYY&=T8U]2(?#,KgZO2c5+DGG=5/EBMeD[D7GGeKWO,T.+
/CZ7D9cc28YM0Z#ZB:Y1)&M_T0/8MGJ?Q6A3OXdY)59-aP?-e8f,RcgQaaWK\U3_
M<RQR+;P^A([HF1UXAUG07K\FIJ7Z,4@C]19Yb;H_4B;5RJDgcU)gWXU=AI1G.\^
>egJ2X@<3O1ZX7S10,f,4Vg,,(]=gGF2.FM@7L+0,Z^;?2/<gB[T53=AR(I#;67)
DYM_FF4.M.)b@-cL^@Ne=MU@>H]>RQ3UFU(L\Y#43V1J/3,1b^JEd?<)-[_#O(<D
7VK[CYQ>b&ZES.b<b]#,0Jf-E9<,IK3Qa4d7W=AKI.(<J@e@YgBAUKV\R/UB-5Z]
RI)#64S^^OP=(128\/;d^83g7d_K;ZGMSHJWWL+2dC52H2<-=?02V5MHVN8MIVGL
JEf#dDW[c(IDVU)c>):9=H7X;E^Ud.[,@1GLRFGSf3N0;7VTaAT3b^?4d)3+4.e8
<T2+)>@Z\Z.fcG1F;]015P8d577#WB0HeUgU&QRDaNFA/2T_E,+gc_0JN:>1V(WW
K[XW/472X;0S^=7@_[)f+42=.eb1IJ^.[=S.5CB;M2//8(5d5,(;,X]-3IdUgGZF
a,TO+CF6X1HgSb1)Q(C.S+Ke)WCY&SE5OMZ=.b_>++g4T5EKV?XK6?g8+RVPBB-6
3P,28PHO1@E_YPUFT)V]fgF1T]DdSLg-]O9HabXLFUDcT0@D?ZPZU@C7\JaR4fP/
Od6:=BD@_Q#8E=>OJ_c.L&3[T:Ue0KgBF7d-<<3AZZL=9,cgM/+I]eAceUeLIQ-I
1=MOTMVP/NBDP_Q5),21^WVO.[=_R\J9<G0;6cOd((_L,4E5^\6/#_E@)I864D(]
07TO3>]L40FPJI;A,RL2RM2cWWe#Y_I2RDK3\G)H6)/bP>KQ73XSDV.C,C;R9\g)
-d^[9IVGZc>bOGa,L8A3EPR8WeCSKfFBQ7<X_L2D]cge;=Q7Q=g,86;[]\4efMAL
e:7DXT[[<4W-[YSJ#XY8GW0[H1&]:cNT2=c9S=:QN=A1JEQTTC2](UJ=[U1LX3LR
E.0N>g?\D<c50Q0-96a^7I0[8$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_WINBOND_NONVOLATILE_CONFIGURATION_REGISTER_SV

