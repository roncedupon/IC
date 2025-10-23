
`ifndef GUARD_SVT_SPI_FLASH_CYPRESS_TOP_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_CYPRESS_TOP_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP Cypress top register class.
 */
class svt_spi_flash_cypress_top_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** SPI Status Register. */

  /** Used for enabling the function of Write Protect Pin (W#).*/
  bit write_protect_enable = 1'b1;

  /**  
   * Defines memory to be software protected against PROGRAM or ERASE operations. When one or <br/>
   * more block protect bits is set to 1, a designated memory <br/>
   * area is protected from PROGRAM and ERASE operations.
   */
  bit [2:0] block_protect = 2'b0;

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
  bit ready_n = 1'b0;  

  /** 
   * This field stores the value of Status/Configuration Register to non volatile memory after
   * Store/Autostore Operation. 
   */
  bit [7:0] store_status_register;
  bit [7:0] store_configuration_register;
  bit store_autostore_enable = 1'b1;
  bit [7:0] store_serial_number_register[];

  /** This field Locks the Serial Number */
  bit serial_number_lock = 1'b0;

  /**  
   * Determines whether the protected memory area defined by the block protect <br/>
   * bits starts from the top or bottom of the memory array. <br/>
   * 1 : Block Protection starts at Bottom   <br/>
   * 0 : Block Protection starts at Top   
   */
  bit top_bottom_protection = 1'b1;

  /** 
   * Configures the device into QUAD IO operation. <br/> 
   * 1 : Quad IO Selected   <br/>
   * 0 : Extended or Dual IO Selected
   */
  bit quad_enable = 1'b0;
  
  /** Flag that indicates that if Autostore Feature is enabled in SPI Flash. */
  bit autostore_enable = 1'b1;
 
  /** SPI Serial Number Register. */
  /**
   * Stores the 64 bits of Serial Number Register(SNR). <br/>
   * Index 0 represents 63:56 bits of SNR. <br/>
   * Index 1 represents 65:48 bits of SNR. <br/>
   * ...
   * Index 7 represents 7:0 bits of SNR.
   */
  bit [7:0] serial_number_register[];

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
  `svt_vmm_data_new(svt_spi_flash_cypress_top_register)
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
  extern function new(string name = "svt_spi_flash_cypress_top_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_cypress_top_register)
  `svt_data_member_end(svt_spi_flash_cypress_top_register)
  
  // ---------------------------------------------------------------------------
  /** This method sets the configuration handle */ 
  extern virtual function void set_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_cypress_top_register.
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
  `vmm_typename(svt_spi_flash_cypress_top_register)
  `vmm_class_factory(svt_spi_flash_cypress_top_register)
`endif

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_cypress_status_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Configuration Register */
  extern virtual function bit [7:0] get_cypress_configuration_register();

  // ---------------------------------------------------------------------------
  /** This method re-stores the value of Stored Status Register upon RECALL */
  extern virtual function void recall_cypress_status_register();

  // ---------------------------------------------------------------------------
  /** This method retrieves the value of a single named property of a data class */
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of a single named property of a data class */
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Status Register */
  extern virtual function void set_cypress_status_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method stores the current Status Register on STORE/Autostore */
  extern virtual function void store_cypress_status_register();
endclass

// =============================================================================

`protected
EeXI[6H3LU7_JGBa&HWA1JHN^?g2ZU.CBOKeT/=RM>FcV#R=NPMU))c.WKA\,dc<
57/>:PAg#D<5Z1G(U2>5LX(_g03O;3U6ZR;T]GP>2^.-5@>)G\RU8TF[O:<YSF--
QP/IY:^-HJQ7fT/#1QY\K#^LN]-?dD;R/GHLb.6M7F>W<HFUTZCBJQ)NB1E,aV?>
^3Ca&SF&d7CU980F\AZUe#3^))JB:MRUaeLQ\gH>3G>XH.Z.Hf@9@O@e7^^EfR29
HSCC.0;1@bHEL6Y39O]a^;6+9ZWF:I\7_D5a+]/bd2L.)?BaR;b7(&/aH7UQ>c3c
G@bIbNX<QL_-LD=3[aX#B:I90Og@d.\MY.Q+0BP@Fd0bcX.B7]D]JF\7[B1KNEK6
<P05,FT@P-FSDTH:P:LU=_8Ue[c\cYcX>JX0X..7;WX88&@)2?9PWA7GgO1->N#c
X^SCGMU:A2IY<ReX:@SC2/LK>V4<g91/LaM[;6B370/1QB3U[W:?d,.JI7ZT?9FL
e],+B06b^)1PM<FJ;@+b<]M8PX:Zd9FXQgKBI#,]&HA3A5I3[PMK\E>aL;)0+,7;
[a4/f.GUQT3O.f]6bECS)UCN6X_QM+Bd9XMN-8KCD6Me_H+Q^&5@(N-0:g5><45G
@-/Rf(9=5I]L?CE(+]OM6dZ_32NB,?Afd>F[YQb]BM-AGU;1?eQ]HT-0L$
`endprotected

   
//vcs_vip_protect
`protected
(#OcD\.A2#Zc0+U87T&3XQ=14U/LCAXE,F<_R98YRL[Q90eAXB(I&(M;-@9=CJbQ
D0\-=B8RcEMfM&A#Z+(41FD9O?OZP5c.c:=[86;E,_Y03VW/VL+b.-5DOX9A?XHK
RYgYPQbS8\W24VI.O;A/Q5E4eWL&OYFW?3)b8KP@#WFe)?/e9W@I=@O\)1#M2C(J
8EcX#(R>:[(d8=,[J=QX0UFHNIK\YM\\FPL2VT8I;Y3HI<Y);b3^S@W[YBMFQV\)
^GTS_f&,9N?=_,b,]DE<TPTSR,cUN^O39J>\V52L_-S4L#(ENGAT@FMR7G-d^1@[
/63]1<[SET;CMGa4CEC\MT<a-?\U\6a/]aT<IV-+/:6Q2@_(B0M3F[YUG@^f=Zb#
G@2@]UTCJK3ORM&.I<^B3ZKbA[J4\)V3KXAVbV7/T8;LYWYJb=HB?AKD^)b&9C2E
bgR,BZGUU>R89:0f-OHZMHKNT^fO1@ZN26;4gL1:L5#ZO.D;UKK+F]1XU6VdE9e+
1X:OGQW4Q1>CU,bND0<,RA/:)0\5-Y[GD=XQgIO9c-K[)_?J.ZR::Ad7_7<>#Q(P
I@R/gGBAgG/9Rc0X8H:=KA:1Aabd+^=H=)V@LXX7N3:a&O3T@WUc?F>)^6>+RI(Z
>d/8+UM<WVZU&]KKXDY7#GWaC[1#aJ_\K/3dBTPP<]gLM1X;(fJ[0Y<U4&6KJEQ=
?I3(S5D]>^8fc<+eQ4,6OY7=&&FJBBN.Z;)gX1\TGZ5GPF_M_FL9f@T1Q8G[UNS5
GDHXM\OVg?1:a9.47C^)Q/FPf:gL3UPRV@YGS53.IHT?Y.F&:KVP7I^6fdgNZC(M
@S2;<#-KLMZ:J1H:7H0@.97J_916-C,27P0ZB2RN28Ob3Y/RY6W<M\:?LEf(]3W9
Q4/PSOEV50BMQ/5C;7N;2ER-<HKS]Z07G8Q([E^_]@243DX.:A>02<WM85)T>H(]
;\:<]F,6PJ,g4.Q\NQI;DeIC3@8:bPVL_&Z2#H\0S1H4f[@aZ_P??GIaXWTbeb,C
0AF0ZG7=#KO1Y5#ReQOac91FI#-.cY0;eCE4DC?.:ULa-dJASZ(\HE,1@P]2U?[>
FH8>_6&_3O0L9Ab<&C-K@7J=GOI<JIE@E4046I@c1Va@]O/]OC0S<F[G3<Z1?Vf_
)9[\1Ya#>IR<Vbcea</-5K\f4^]L,8B+MFcOfU))N().8A]N.fB.7-13;A6+L72Q
\XI3E[AU5PA2Z/:)^5F,W;QffQ7)L&9@7M)]SCcTV#B--VV4_.@)[OG<O[;2fGBb
#/XQV_Kd(U,@.f.>6c&,WV\H3GK^4TD7SZ4Ze\[O^)0&XJ1PVBNL[+_4BMg:X#5S
1f<<TO+2GY=M)]NIBZJ0T(@JQDCI8dQ4FG2FX7^?[b>/7IF18(O4cLK::BRQK3U,
F\814IPO&[DXK9+A7?0]f>(US,F[/VDBJF#&,[4?B6T-B0PQSX]1WHeL5M1fdCOQ
U\B;VRXY4+R;0b:JdTK0eW+\<(.&2/)4\e9\A];e+\8,<bHB7fO1F4FE]e+E.1NE
?I#8=-G)E0RWbDOd5-&+3B6GaEZ4.f?T;G>@IU90e+T;3WfW^C>&R[aZB__^^/aF
KUU_>2CaJ,F+2GL9.GK>)VQfL34FGF)EIXP8:/GK74gT6T]PG2>4&+#M0;9OPg-S
96T6d#EC2J092XO=5dQA9VZ;?5SEJ2H[fAL&+_egT&0>ZGI<I_@+XEg6G7]a]Mff
06TI_[)U?ATd#gAc,aaTK)F,^F<HW8?\Q]8VM/AFE3df(2]>d.H5^FN2KaJ4[44&
)Q>2.)98]I,Cb\fWDb9>8RZB&>/F2_<fH17>ZXK76g82?7_)9Ed^AR3GZQUPdREb
CC(J#KCgQ)LKf]<&JWdVg1e=L>YGc<]ZXB^>V\^CFD6SRO@C933Ra4^B]#S^Y\;K
LWIDU:J36a[.cY1P(-/UI?]dV7b1I[LNM@CM794[<NZT\(^^E/Dc&-a5W2XGe3eA
Q@[Mb_,aZ0+\U]+N?Lg\?DZ2b0/a&7bVMW#>Kd_6RMWP7X6X1_+P2C0BYQe]++FT
ET=.]S=BZLdc7PP_d+RXO[HOOCOXLbL[0R+&a@QECG\d(Z6/[+FQg3CE<fC:?RHA
4DBQ@?3K0?AP)a#D19)^?a\fN@3a3LK8Ved4F1A;Na_[7_Nf>J6HFYa<,\P\IH[.
Z,;TH,b:aQPTf&GO2=[#]S\F)(0@2KH<\YTV:5LVUBDDdcAgXJ[++-2d519)SHK&
\X3/(8L+V@][XJ-9O-[C,LY)&TKLP3+1S&3EVg[KYMH]_RW&<BZD?8WY-#X]X+^.
4PHcHQ#UV4X//M<P/f=JV-^)bFHe/.J4)HMZgHN.Y?cYA.e(=2VPXB05WK(Wc18#
:4SeD]9S#@ISVRd.-^Z3J=&DOQR7QARMe&_SE=LR=9d09VUK2,NBH<NZ=#A.TRXN
HX3#H\)X[b.Z+cT6SHZ1?U0Q7GS8-.;XLZg4K)&WVN28=V)4[2^Q6V]?dA./#R^:
Wg=Q22Y\Mc<,+ZCGZYPK_A+U(NAAIEdH+S&?9L6HSPJZ4P5CN<b=[SdfaT.R0YS>
Z_=1aYC^E(M1(9\TX>-==2</6R/2BT<NMG2WT)IQXd5[)SXS?CeQ.+BEaI045WHQ
.f8G7[/e?[?I[_D&_56\U7NCYEf>F?/H-U7A)ZRGV&c^M7-c<=)CL:Z)c)-Y/X1R
],.gDU?W@G8\N)gfA7P>_VMBJ.g+VfSWdY]\/7I>,+La,DHd3X/2(?J<G_HA#.e)
dLD[DCX1PG?\0c_FT.J(Z6PfL5&?;5#cV+a4;:K&@GN<SUQH06,c93d/>X_H#:UV
I9I-J9]^ECeCG1IU<6Rc&2Zd7/5UN-bgDDPP@F=I:7b[M[,,428aFZ)I-gcF[&_D
g^GRMG8]9UZINXdETPM3:adE\Z_]WA#PPAaBf1:<YN\3C\@PN+]G.@[[Oe3NgY6+
9_;cR5:AN[W2;#43(J5P5P-P::JgW_GeA/e4=^6[:IXT3Z8,<+e<-f5A)D3/K5/e
ecc2YL5BQ<(Sg=GD<HX<#[?@\;ZI=GXKVDZ;>@<BM.YfSd;HW6N3?J]WA9;BVJ.\
P:f0Uc?e]K@cMHIEH1f#MY+#GWf:0@]FJgK5F@:94GE7WEKA4/Q(FJb2.fB(/dgH
U(L/4SWRPgFQcdL2)51b\9@AH5(,)5[@9gSbdba?cP2X/>>_2Jc&Q=b+6/:G_[Z4
F-\FM9QP/12A5c][Ud)MO+TY\&682(O3>K=<G1^d#TQ)J#+M5_0-TMN_9/eOdcLZ
LSCKHU_BOK1#e._K7E30Z_1OdS0J.8#ddM/M^5g3gLc)BW5?/QP>>dP]?g4L??8O
4.W66=^MWA.c+@H\&9N=1]#Wd\?Cc)4:WdZJ_\_d_83+7BJKA@WKM5SJaDQUf8=N
Rc7b?.a:+HWM>1K]GJ=7cNe7ZU).BIf&=L>=W?UF8(H7b;A^W[\;aSRD-;?N:J1J
Jg.11SBHD1-YP[Ha243J,N19a/.T&QgNUUD/#8<1D[)0UI18\,LAS@2:e?=.+RdJ
^H>RSgaPK>\II4N)VM&3P@8DX,O);94J-]/&RfX/#/4U7d^7f?8&9QIQM;G]ZOHP
)0Q=S.PN-XT<>7&[V4):UQFTdH[/_][+X#fJ+;VA<g)&SS-a37FGUc#EJ@K:()XM
bY^SKa-PKL-OG:#YN9:f9Y7-^4cZ884S2F&RVVRe(FV0KL,++@ObY@@LJN#H0T84
c\5@3/QHM@]XAB2=4>0GI_cXK:K9CcH(3_=2=R_WI5)D6[]Z(gDdbG)\VWK9\L-6
ga86d,af/[(Zf@TV]JBW7&_bQg=fW5\-/aJ4/P39CZN:9\\L_-e>KZ)L2M7b,SS+
d2f=Ib86Y;DPLba9e6g]VOC-B>:EV1/_O#;7,Q5Q.4KV4&09,OPN@]).P?17TMZ)
JB5KBa&9QNR;/E^G6;P,5>O@&]PFN/SfGOH0P8&1P(;S>^L_7Y6CQ?G3BMXae2gO
RAHbc4^7QP-f/FF\dd+S+fc^dVf-\1+]ZY0+I=QN#E4QKa)8</VGQZ/V_g\eE=M=
X[b4ab3+0Zf3eV4EfCKH&<^EQc;FDaRPH\X4\4/-T#I.<X]=I8gB6NBF8BeYa<@b
?^J#7N92BDeb.\49TH[U96C@M,9@9UYWZ3Q5&2,OT;Mfc;6@:)_BW1FMP66[ab,d
/WJNHF5QFMbI4SJWgEHJG^G0[IgW+7+@F8,6ef.6b@@(PXYV&8,Q>6_-KO7K>AR(
b#bQ#_3ZFR4O+(aL)eX81P,0GP&cUO,\4.G[_g1AJ^&S6YYK]Q\TM0MP.WK&I26_
_V)V\NH?0fYYQ?S7E\^SHE^;ZI8)/(GR09I\dW)ed8NK0C_0:P7KDSH2e.Y.EQ<,
FAaaA_L[Q_@3R^FeK;#EXWR0-)(dQL?XKDXEF//S+2U9fA(:/2>.fCUc=UP==ZN1
:#CS5IA=&JL<G@[If9b7CSf6-HK908>)JfddJB\Jf/QFQ+ZL@MCf3NN;cZQ=T5R,
;<=G5QNQ96aT@=]YH1L)@cc_L)KDLa;?^_4.XI&,^,@/dQS=<@7@0X;XUf(^c-7d
?>T.LgVNZ-a3JP4?<<,O,;&)NI]9<JC)8SYfW43J0G@?ADM#I-Ab5]_d8#D#e5cW
f^Q0[_QR6UOb6-F[AdZgV6aFbCc)c<LA9W-4U16F/#?cT&(ESa>#S,\(Te4O/203
3-E]c)_UQ-9JdC60_NIB=YQ?^H>FI48DG@)Hbd=\c4BH5KQ=J<@[1UH6#QfD41e-
3R#HYRZ^f>Ne(LZ&aB0g=\R\>,dE]2?YAV2HD+QRXV\f2_18#,@]146AKPc8BHf:
aaD61H,[>-4aY90]7fW#HHD/bbNgHaRf+5R]Y-gO1&FCA6KJ74V5BKS)^gD?0;88
B(XP9)@D=>B?5#B7QKX+/TJR&6OPb+EORfNWU1R-C_JCHaQ+-g;^C)+2(-B;eFB:
/P6J1&cZId,M2/:Yd-->C4^0RTaJ81S#=9\2^Ma@J8<@]JOGD796[.+FR#-6[ZCY
(V=OH;IBB\;0,UJ//_aFc68WVT@N?/cCI0O-T>?BEJ=:6=E=+B:6ON&b5#4B?KaR
&GP(D,FI/I2_^6^OIMA7H^8;,3e8H;>UJIZ+]6VOFNKV\2F(W-.[F26cOFTN#@17
R[_gWVHReB1c4&-&AeY6<f9Mc,^M@9gO9:/KR9-Sa><:[Q4;)8EC1F7+#,P7&,@_
HUJHN390N^?PH^Y,AZIGTP=5D9QZ42UMI_b/@D-Dg2UY^LO)YFN6RD;>2];7GS>1
OdcHa7N<T#.>\/QWLW1<dH0?P)GAY\e=<D)M7-f3QX=:SXPUf::/aX^I&OX&M/9?
D/>-BB>G,8IL+PAZ]b]CCQ/[HH&18=AR17JC4U.cBXe&B232Ja43MW/b&8N3[4WZ
JZNDdZXA:)U0;&XZY5EbMaC#@&G814b_E9P542F^bZ@SH4caO&IL0\\-bK3NUGV?
74Z4UQZ8UL.:D;/8=:[DW6>d:TQ?[]>A)G=1dN+cQ.W+_6EA-Je2/d05JVd?1G@6
R_ebeH5d:8>-7L0&;&SVAeD.XB?5S=^&8DVEXO;[.(a.\?8>4cD0eT\A)]>>./Xd
<8a6.@HI^707FA2^_QKe6XERe[BT]I]ZVSQPYD3JMgU)Y^;F-?gg]H(.6]/U@/MS
FJ).G;NXZUaWGQ5+aK9>+J/KaO9VZgM;KT3cKQf8LK4=<PMg>,Z[9g;gf<8J:-7L
J_DYUOU@HK]:M3f,SL]b)>+L7V0aa&N_MTIG.H]^CL2MSH1BL&2LaUX,+ZSY[=WH
QbeQP.g4]U&AcMD@/VT>IGR393:b41<g_0F@gI,8bO/G@^+Y@S75\)g<UP84N1)1
2L@L3@R/XEN9&@/CaE>?b4DS2H/cYI=R8[4(2V2KA,8C2E96bP_AYMf6beTb8gDF
L].Q(&#:RPg,K.[MMV=RP@D#--Z/]&59a--W5f2\a<@0RR@ABcfQ0O@;0#3/.6;(
/90I+A@.4X(><WOJ693Yf3Z^>I0(AEYGK#8b#T:<FLK3;/fYX^<Z]f0>J/ccU-?#
),(2AC:Ka87^J2GIZ_UP6&39+,d1,Cd2?OUcR0@d-#cd+2M),\@ZQJFW51FCV>\1
KM\MN9FGNCGe]ZbaTR?D3TI=M+=.TG\?CW05FS_g\g,_R7+A7.>)/NEA@Y4g<;Tb
fMeFEJ2<QS]Q#V.OO_PRYeD7e1gE&05=WFIAN5&d76[QSf59_R+8S)DR_Le4;daK
F+10?FE,M_Z]LHD:UVLAaPL4b^_=><UH8e^\YF6P,R.88WIB2NZa>^M3-?+Ag\Z8
T_K1=I;H(aE+7Q2A]Q45,XH=NG\:O3[,YECE9,>9,0#@8g^@<Rc23>f^bdEKHO])
gJ>&V+N>OY7F1g&Z95#/]9OBT8V@8_79^&\S4]^@f).5N#Ue9DWKbQ=E34>5gT,R
aIJ_,.<)O>\Ub#0E7&eZOF\:]e\Cg2AM.Q[;YL0;D:EU[2SIP_@YM1K0:5BT[/3V
I0J0\<0A)_T2<NUCJ0AaQ]P8QG>2_\H#dbX]&WF,gURd4H:CRHB4aRX#A(98Z,NG
.F?]8WA^dFE5MSD,@-)]a4(6NSWWLS97UW6#;(T/aa#DdY0@YLQRPBg,83LAXdBT
OdS#:5:;eNWNbgD_/:W,HD[7Gf=.]9=6?ebEL&f=.eG2R3KF5,LQ=)XUH5V5g)PP
GG.XJRO1:.[A/3<?fEQF#.?#bf,A(3c[6Z(<WCSBcBR6ZL/45(SC0Mc2]#a,_bKf
68UA1eT93T37=3(;X5#CB[P^2.^+KLaHH.HS;AcBN^[9IW-4+>1K]KY(,Ba=ETT0
;Z^10\:-JUJd7PIe9g@8d3D.b>53SD;.[2e&UR<-5NQYX.<VfJ,O,;@Vb&B8V.W&
HN^V(]AE>W;<D.F#^bAb0&c(e4VdP\@H^U-9H8\^J&\1WaH8GgOfP@FT>^&,S(VZ
GVP+GWD&]QR2;9?S[0->[?0XGNH;3XJT#MXdFGNJ?HbcR\E4-C-X.I927G0a)fC.
/6=)a+Ud7/6V9g7Y<B/(@;YGA3H#AU^RYZcFPGgW)?S(/MP9&QXKB?b_ZL7IVD5N
7>;+2A9E)5D7C.D]T/gEM43,ED9GM5S)E)Ab0c2:4>Se?0MGVIWW8>)CX7dCJ29I
H>=\]K1NdYB^DGI?&cQTb^dT^)N<XO1HJ)M#D@MQgJA2LKfN@cCAGbDY6Q:&ZM.Q
1>((K1V9,YN@MTe^Bc:<^<NUMT\0Z=-C,5-K30B&df#IM7QVeC>#+1-E?=aJ@a15
J0DS\gf@;OREB?TZ-7<7WD6S>.(G5J=,?HEJ-UVeCOJ:GcU>OP=bAV)/(1=;@N\?
[L848(U=]a4/MRIN8=eK#9<PW)/Q39e8,Z.P#CT1KXNW;DSO)fXFNG\&,7ca5gVN
Eg^\.1TS\?4OW9R6DRXF2QP2eT?[29TQdZ46F0Og):/GJbQaCKE173Q@&SBag]WH
F\5[d3D.g1g0L4a-bPRd>aZ[,I._5\W#VTPaPc9\Y^.\c0H5T^S\K@7U2dbC6M?a
]M#edeI+)>>0]V(f_Xf3D>:7>ZbZSK7dI1c2O&EH,C;c@,7XN1I>S@c14^.HJ<OH
V^^KD38OH0dM2YU(5Fc\C)[(]V&.,./SgUafYJ\&U;D^XU@VfGS8R7#SD,aJcS2<
UP#O:T.W(O]9TZ(VO1^ZT+Ac..(-gOS_/BG:CN/EIIDFdeUgfC;<43.NV=C#CdJ;
RBKW+KTcWZ)8^/633^:BJdB(ac5BJT-HLB7^2TC&97;=YX5@N2SI@eO3=#=ESTAH
\8I#=6d4,:9QP&GIJ#AN<LV&3F]@+6EJ,HPe4W1\^G=G_Q\65:2KAV&A2/YJ,KO_
/U1+fU/c\L6OP[3D<O[+XJ)K-b\a32&8CH#J_3<OS]]U8c?\46<)NVWR9#=9C^JB
7_E2eR8fe;g3a)/KJU#b7I-X@\Kc)\,(TfJegM-YbeDMBKQ]Hf/)27f1C(4a?5@@
OECd6.OQDWeLdA-?eI&FUR3,6_CLb_S,M#7J.CfCLfdQ6-K,ZAbBCD-GA-/XQ^FO
\)b\KXZL6KTVUgQ2bJB<8Y)\#JN;0BYT\/+\3RZZH(C2>c_93&WS7NLJ2cK>Y><c
2_RBGX0-SeME0R=[RObgFXV/7\c+8E/(2M;^6:M2c^DI;#XcB<3G@fXIW(2HG@(A
IdD3]]/[LGMd&:,@UBJGZ?OHKR;b2MV)O@Q?BA>D@]2T7-GRV;IP-<I(3Wg&aMa;
.EHX_/0c7/4\:d=>[)ebUg;T/47EbT&5GGcG;S(?UbQ_>9US?RaM5:YR_?5E7CA;
9(0CQ0Z\KZISA2W:Pa+\RdCN5X2KGfbDS0(+VaL@&A?^3E8@baW>g=XZJ.FW2D>X
S6B-41?0B0(4ga?JJ]8-=-aaRV;6&#NRb/I6UH?>cUVfDfc,RH>R=8_[-&]^Ud,?
(/5@3AZI6:,SJLD.69VdM2]T.BIK<9dS\.4[D\/Sf\Ha67</@8g0;(ERH;0&Y47C
H,[7KF2\#U2N[=]#X?MWPg>7cIZ]XT<]E#99<EVW#SJ7Y(BMO->;.2>/Ha_B#X;P
(E8BC&;\HZJTV4XFOa&H&H=S7efL7)de_acd4[KTSQRXYddELM+B)VV\27Qc3NUC
)BB68;TbUNbYceV5X.V^(URbGE#P3H;??5C;-CP,TXCd76D+&S\]439^X/-eNAIW
bHUNeVa.#EA5B5B42cge81?W87];8W9.+<BX)CBPfGO7IJ54f2O):IbN6<_>S.eE
V4<6EIOU\7,JINF+LQ.;.<YWY?P6FYB;/ULUWDRPL)C])^WIMG16IJ)Z+<E195CX
PFHPVOV+fT^K0;>?.@<PTgK8VRa;:D8Gb]&(eOWb;E-ZT_;__>N_N(S#5[XU6+OJ
6@8O==^.aIBLC_;9La#L+[SOUX573W9E:M1QL-(N8NC\Q>c&CPW5+?,76_9fLD40
IcCVL)-Q@+&@R+\gYB.FIW8_ZJ6#Y8G#92DK>/adY7+fZeNSadcT)(]5C_gfH.&F
g7?0Y+PY?-(GM?<_X#HL4_d)ENZ@(a+)\+4dB=NbW1D.MAQVQS=OEB5?PQDPE,A@
^IUJ\]a&?Kc3JYKT.R<3557FK0:c:[,0&GeG;8Y?H9GS_#0ML)E_H9aE.83=;]K8
d[ggH8,]g,5c.EHe@S&B;<cN)GCB31L<^6^e,G@=d4NOLR=H[1.bFEC_KFKN4AbQ
dDD5[#WU,L8R+SQA6H4f&\&O-60_bM0O4#W22Yf#.C5+25#LCL<?U-1ZWQ4MH=V.
_a]g1ag?eG)fM#dAPc1Q#7PHXE,->3BP[@Bb7d3&D+50J+_S[-ZRd5TFO:L6^E#0
d(?O-I;Y=H6c6f]3=,5VfW0W]VIZ#97YQRX3@IZe=93KG-<#I,Z19e.&CNNH;RHD
fJKd3_3)0OOIgb=gY+]#04?O13/4<>0XW3M_5a/XaQQ;HNM+4g&1(aG&28N&,1AH
]EPV5G^cV_J-?8.^]IVJ6bL;FJ9B/43B(I2F7I(6_R[.J^Zf18-3?MMKe,-8?O<8
#/gI^,S>T_,>fU[,8;=_:S.C,:IFL[4;>H>We.KB,7;QOUG4ea1Ua,^R9X3WQ]]A
SH./dRM[Q_>GDE_c=?Oad#+aMO+)>Tb.77QI338H]XT@S0D[@KG@XOX:^O:^R[L]
AYA]dQL6KcA1L@9LY846gND)H@W++&S3BH3g&(O)&AMM+J+>Uf?G6M(G8R+M>1,O
gCMOUAUF<T=8G+)=#.SBOY:)_H(/bY?2W=1OGK6M8c&d5]0/WHTWMd:13gX^>>.T
9#?IJ^bLMfG/bU8C864I1Q+\@GB=T?:HGf-F+SB=AJaVC0([9g3Q2L-&dOH>^,)_
/d[dGN;_8K=0BD\_W;-:8g:g<Pc(Z-;DY&g^ZV4<_#YUM[0V04NfOYTa-S>;ILJ2
_XW<U>52D5;<1WM-(\fcT_)4BSN:MYIES.F.fc.;ZAL(6<]T1[2+E:./.)ZeNL.C
6W5)=8@;L9QgF(F2DY633WRJ(eF7FE79S^P;ECYTS8cA/RW[]PA5+R;8W+S#0?@N
F<^bT40UP.9>QF<?QgAIHV60#D/OJLd>KV0ZXB/,>1LER]2DNaSN?cV8MfQ.JNC&
Ie60FNZgVMD&0XK<AI,U/0C.cU#7GLa)J]e78\;XUX6]P5Uf7M8cN4+b=#JFGfC#
.KE+1KB@fD8L]>Se:>Q/9&2N\<Jf=O+0-UA?+bgX:N<G)a]g;)2Z77S1aNbLB))1
K2[T<fDY]?abXDG3+0.WOMUY/gQR3Tf(Fb6>-.M54Z,gL;;E>+@I=?N^cGgRXM85
=O^g@3WQWRACZ#7c_T=+JL]WW7L7V,f>GAe@V7::/-#+SU/8E/D)?T>(Q@R>0HZQ
EVGS0e.V,;=IG^5U:CW?N1_,.)Z)[6d\I=6[11KMJ_+UGc.DV+cMN_cZ6G0);7Id
D<WLT+W-7gCcGdF9eBVTbTg?aFPIGb9a3./1e,UA5Y1A[-(C(6;8J-K5PJ,N(EKG
NGOB:=/P5BCK3F9:LAC^R-G38&dKa:gD0]T)D^R_;URGDL<PTD@))>7#.(_I7KKJ
eAG9&[H#6C6bU+d9H:9_U29J).<<-E>IU/.Z(dWcL<T0JQd.O\:@K_]]JHRC;Y0T
;DXQ+-;Y_@>[4ZdKd[\0ObdOZU\)9)cEX:V6679@4QP&I9c^=K\P.-eC[^?.X-@g
VRHB,D&DV<Rdd5Y+MHT2I(RO#,O8CBLeL,>FW9Z@A)J@-cL/R4Z<\&9-UG-bN:e)
^4]AK-WSBdGNYPCFQVe7?,QNCMda=fe?EH#6R=1-W[Z_))d;fE>W(GbX8-^MT]60
1aeBBfd2367gEd@51US\bedTI[YW42f\;2\+]5W=XENU<c]CG2b]UTI[#TN9</Gd
b_<85K3f+\#NBZ-CI3NHBbI7S[^]GdcVJ,;B1eHVTeQE]O+CQQM5.gFcIe2X5DaM
(-(/W:@,&4R=]f:JD;b+(IX]8?1Z/I,NC,0+,39Dfe]=;GeKa6L0_4N]b&1[U?0O
YRDZSJ>dT-SMRW86eK^MVEWRKG;-fK9/caE,GI?T>1+M&Tg:g?R6<9J_S^a+H,G>
)g9]K6g9VW^0>H#<@A:B4&G=(5=6cIMIR@Q[-W<4;O_1fZ)3C]8(BIW[N;V&RK8a
WGc05@QCGSGDQZ(95aVDWAg9TUQFF\V>VAZSbXY56LTWX&O71[N\VM#GU<e4G[Qb
NKVBT<&+C?3VW)f=.VV)S:_.MU^T0Ea?,Y0IW5133?3Y)#NRWU,:958Y^L2\=PNX
ca963Pd(XR3XX^2(\OL.4d@IUK#<8=1IE6g3AdH6TFD.eMgNS(YM.86U-/F^Z726
I6YKQcT-3QT<g74->Bc6AVW/7)9&IOYUEcD7M/(AS[MAW22661#AUPLd?>3g3P74
UBO>>QVP(]J<_7Y?_Y<Q4g9FMSYXH95^QS[LHAI)Df&->AP.Y+&NB:Y.FY\eEe;&
X)9J;_)eW3AK5N^T-eaa\<1SI.]]Z.fGRN.2Z)2A,E]4&MaFfb8PbcGO8BVPVd\P
PTQ-Ce0c<4aSOL#B],7-E0J2Jd(_&@2,@=1;K<+82+C;W3(AQ[0P,bCKS(^DPBf#
MHPb:5D,77dIZ1KB-,C_@E>+[R#MN/c5fCeL(/;P1eU7R<C(#[YE#T^3JU+_cWEI
,U]-&a?D,cWJ/AI+P=9:+J6WgQM(I^T;C,/U82cB?2adIBZ_2V)4XVdY+g#@\KJH
Y)7Zc8J,G4gJ[Q15+@U2f#+VM2fa&5+]L:AV@Qg3^G6R)-egX77G<K\-^Ya1M01&
)Rc?_2e47fVQKeBd(/7;0KfB@?_UC4O@?g<JMR2,-++4d/^).FN.eVFZNWJdK(U&
d#O-_UOac]1T+U-9Y/Xg#C;L85+83Y\K5d^EV/55HcI&e/9\Od1J]ELX_3M@g9R8
KG:EL=>NLD=:#WLd1FEWC=8PO.fGY\CdP8Y]9(\[)bICQg[>=/Nd/YH[O9;J-@H;
WeVBA3<6P7H?]W:2H2SY>Q[[dd2(J9)2f/D#3X(Id(9URYN1T-)cO;</ffCQ^R;_
3S2I?cYHJ::7D,C392./S[@).c^R)cSJH<D],U@ce7Y<XU^R?=g7WY-?/f3fJO8+
c;W^H9NAD:=6Q;@S>DV0C08(\=Q[&^H7DCP-F>VI&8?d.6[E0?gU+7D6<H6gJa.#
AabK+<6[/]QOH&caY49</NXKVeNB>)QJC8Z;D;J^gge31>4.DFfb3]N?\4eJe#)Y
@[)+CgAJI)<?I=OBKLIDXCS3_2C/2;=H:2<W7LCKIXe.bRR3.Q^TdYC,27(1Xb-O
:;>=79:cb[U(.[F:\+HWSUf_?4^(+1L^eZVUg#A/_:HO)N[J40?\I820@>5.39L_
@f4@c5,]X1P.ESC]>9O8TND-3_<.<gBDMB?aV8eeMY#L@D\fPEL#DZZ>RCC/>3GM
.UTVB2c5+T=B67>Tfa4\:E,@:+:)P;2G=F]17)6-8X#.5KM2,5B.g7(OCNX8fD#V
F:.dTNIc^fO7ZGFf0KZ.U<1]C&;]#6-WA#d8BX&0@+KF._;QP4JJNX2,bf46](cY
RPKfL#C9Q8U08+VEA>H[WB7@SA@K5#>KQDD&KFcbc.c?4?c35QR7R>;#MCaWYAMb
/9OJB7>^_KgS,GcbI[4ZeC.._MC#XYEIeAWXOY0KRXH_<UTY1fV56&Y==JeKA&K5
JcbgFd0eR.UfESeU>NHe8H7d.HW9/(efa()3AbVP=dGMG/RHMP0g?3gL@LUXFG5a
=W>QJ-KF@LZLK1W4Ta+@HTa)21I[.=(d>)CeFMJaY8;VKH3([W35Z=Kg@[fV&_eg
VH5c&PPP;G0](DD26\eT?IcfG,<PC7]=d-34Ec/d>62RM]&B9(,5(M43/RJd#5ba
7HGH4)03_^A]N16;J56R>UKO7/RQJ+\21YI92b0HATE#-VROOG9+6BA210P[OHfQ
.)C8fP0>7_FUC;:Qb.5G:XU#>X,,;f3.&B?)PZK<F)Xa=1H+e]T.MX7M_4Ef)Q=-
=b>7T52C1+6H#7_64Ad/+0M+G@.?J8YHefR1X4L0RLHW9F&Xb^[/T8,/>,+G<()#
=Q7QS^[O-cL+D-0_^FMJ+LY46SUfg&REVRQc1TX:4E;7HKXd8ZO#0)?c[=1FNaIP
H.;a738?b3V4\-XD=?\EW20H/L/+Ed=Z+DX6cN7KXc@O74SRC,.ORZ\S&)=Lb^\6
fD</KK^CMYAe11L9[A43=;D1.Mc_;K\]_;gZCRN#M06X.)g\B748VB.1PI\FV(26
\\+G+.Cc0;eWb?_;FS7.(=&KRd3K2?aZL(1ZWLdNNE+,Q5U6gSb6?Oe:ab.Lc/dY
CG9HGdGU7cDSE]\U=?<&&K9Z/\)(W8XOVQEZIgO-T27(BUY,2?_Dc:L_K=44:=;C
A9C<eC=&LSPUNafPb?>Yg#G94Tg0aOa#L)=V3Z1ICTZS?\<FH5FIfEZ#>Y-;d[<_
[0-^GGZ07,V.9\Z:LY,6JA7KKZDbJH[&BPNTE7;M2Q-&34Q/+fff6g#A:Yg<^73E
]TKS19b(gM#/PTP-Z^e5(cTQ4dIO8<(<d6T72S55L,_,;,=,fJWAMS4E=EJL4gS^
.O2M+SR/C^OR#RHA8?^&Sda\@P[UaY[[T:+DB8fADB:);fH^gXg\ReS92Sg:Ca)0
;P:4#:NXW>Q;+fL^[4PD-L3VET82]-5D.D?La<56@+\d]g/ce7LY77.YXSU,TJ_;
&0><:fH=ef^A.USZ,:a)Z>,@4EU=IC9<bC8>QI0gBWEY0P)14gDY>([S;NfZ5M8Z
N3EEMB8TJO@CA.KeZYF1_+c\<gf;3FN>2#@S#bEb]<J0BdD17S-=6-RD:@42>&Sa
1._XDA<23;?.;W?@@>DK7KZYBY>;+]&0aHO+8ONH1[/K6<.=YZ<&F:7NR&YF@6:e
D]._3LHXQU>TgDG-F0]B4_SFG-Y03TGa#RG&3>Z_=e:9RaQ.KE>VWa=H(dTUQA^2
,FETe+B,\;RGPI<CF+K]XIZ@0,NceLec1a<KV8>;/T0S]gC3f6[MCQPf_E??aE[V
0TX=Rc&@HRb_0.O4EDV_VHPR[>I+[IYdW&XcQ5)1ee27/)a4O\O0cGUVLVE;&Yc;
M5Ma<W?=T82Zcb>gMg2V@gATbPaIb=QQ+UFLa@S.Pe]>@FaQZ=&X[SU\2Z,?XGMM
<:2bdD,a&cZ>_WDaKX.5?6A^R[/JQ\4O]6P36LVS2Hc#3W,9_<YI2O[2G_dUc:4F
DL+Q7(AINd\S/M6e/SEW.;A:XH4U,37CcfJ(HMaW;KDRJ^<;ZL&CJ\aa3GI/D;7[
1UYB40^XZCf^b[28D&E#H+1,F+[GZ=BK0f)K>K4-T_&6fO.27C_.bQ_@aLNfSE#H
15Q9LLHM6JD>(LL6Q/8NWE\:L=Lbgg3&-.D;IJA#@L/Z6/]<;1Y]JZ?Zd/E?_>-2
81LFQGTHgaS,ce45WVF;Oa,9\Ud@&T:3RJJZRGWQd@]>3GD3,FI-AOZBgN,dZUM5
/2R03Q[T/CDU403bdN.bJ+P?1=O9MUC/@O85Ibc+#KHE)\H8XfFTDQeO8Y[20Ug6
2=L9+6GUV-dGTQVS-W1>.3fB:aa(Qc)\_HIC\2AfKB@,g<\JCa=<KWFg[)\CQ1Fa
193GA\/W\X=4/9<b=519?W>ceX5N.W^5:-@4SMUc;.B1\YHbS@IYRF6^Y][,LZ[:
MPM(^@-F@)0Eg=;K52L1ATb#K&YZSDUDd@H21-Yg);Af]C672Z#e.,PQ?b]8aCbG
dd-Z5U25R3c3(T<)[LaOEG[X?.TE)2g/J@c/bXTF[Q500DHI6f-Fa]\(Eg(?XJ<J
Z;gcLQ]Na\W#RSYda1]7>=8[7>W+YQ&>J?>ZSKaG>,YWA3).IXACW0.B&d)-#?HP
4X;ZQd-0-,^:)38&a#O96NTDe:.]?cH6FL_[aU-fN>GXMCU+.@5&)c48,Q:Q,000
LZAfI-QUfWUg)8,)P8;dE1Qa?,Ae5XW0ZFC3aB_Pd42,H6I(PB+^QVL?)290D-;#
?G]:,aQ02&fe9^;9(.(&VD,NW?8cdO/.^G/UP0#FJC<T>K2NRe^69Y1)Y,fK2b@.
UL^CJSe3IR2c_-5VV;M+0g?da^eQGZW1AD+ITK(C6=(B0],^D&0LR:F;SLR1R@cH
G_,=,8QDW&H0D:FJGX6P53@QQG;Xa_17\WXgeDEcbI1<VA=E\<gF(]AfJXf+@K@D
Qg)I+JBA/[dDd6,f[K[RPWK3B<_^@.H;8V-U+\M3M8_F:1T3G]]G6P=76f5+6G?D
-@<a=9[7HX2X_]9C3,+-@+OANPfQeD81L9,3>Nb0KSYfO1&Q(>Wg:?.@S?g..UX6
<+]bZY_V=M@)C-f4UMMSBIG_bBVc1eMZ.>DH0?AKUdIQc\(8KEH5AV4+]cRW+:\-
IR(0?Hd,6,8JIU9HNJEdW[./5C^1,Df]9X?L5)&+0N+,H:>Ka)NR+@c&?9L57H_D
8IL0b,8)@W0-.fNSV;K,Q?L]]QL4Wf?2>T-#LHd\VY-PIM^8JJJeC1]@J/^_:N+Y
L<d:dI+4KU0ZL4=;V5(@9TB,.bR0;S0NKL?Sa1FZ:F__G_Ze)&LfVC2N>T-X6&);
:52FN53E(#?b]]>?U\J5M9TW<>3<0[/S]O.\YY-24c=TgP\A&_J47V][4>15^L,^
.Z7dV0;P\a_<Z&_-RM;cR.KXL3faR.WT0[2R9&RRXP,dG53_3d)E]ERP)(W5.(AQ
JcYYBQ?9=A8W?O-,U]&fG#CJcVJR>-Z6fHQXa.VT@a0T/[H#NV-Tf>WgcGQWC:3=
J[)a5OE+LLOd:\P6d05Ze-&0N4=P8=.MCW2fTb\\@F2I9eH:710.L&c[?-U97]LG
>c&=<8fNGI6U@/e[f<b8BAg10]]CcQ6U4<aG1P]SbG=C/()_#UU[=GLM=F/+_)BS
X+TWHPIT\&J56MDI,4,O<0(a)gW\eR-1Z8W@JQ&9TZf<:TBEdWK:0CASLX-BEc(V
J]8fGL#9M2<FM?ZFBHP[TWgNe1ZC#\8W-C/AQ:fU/SZePS@JcSTZ#49_\Zgc.6N)
2KV_8WIP5Fe+01BaM719\C6LRG_SCZb<SOPZD0Bg#4WVR(R^_A^:E/TZKG-KYQ+3
GKcTG-;]K8;T]+CXR/CgZ\5BW2H-R.T5N7NT(f,T:YgOg;2,BEYcX,^dbW6eJg-H
SD1+L;_8b8XV5&X38T.Y?7B9A6P\fZXD6@VP=[U@GTReg/&EU_3[BCJe:1;XP8dL
eCEe72+R.S6b[\cAHe.K/U,gP#0@bPYQ)#KV</<EZ_)H;1QH^:S#bDVd=1]S>PT1
#1&DN^-OgAg:f9S_MTbGS(76IQ.+WI[gEgZ_B57/1410#(3dF(,NUMe#^B?0[c1C
_Q_(d><8;J2I5RM.:AT_5<:H^7dZ::>#SQ).WHP/<GXKY++KH0T3<N,:/Z;_+L^/
XILEB#gHT)=UH/(FM;016):.EK;M@I)7Td-,.4gI9:gQPUG131&4./?.BVWTLET(
IbG@dYaDWJd>WKGF6QED[369X3R5eJY+M>80)P46CbJ+g#9\.ZIaMH5FdTKUO_,a
,K\&?]g;1L0fI&\3UFQc4:P<2P3:I/BH(>DS2=\PTZe4I0:Ra=7FLL@MUc^V^<HB
\M0G?=EZP>&&4dLF&/\d,a]0S7^/;JK)7WW#P0eV[J[E#^HA0_KN71W^dgO+d(gM
QWY19.fJHH:XQe_(cZ2CS+EK8OOS@Q\I\P0b9aN)IfJN0^LN\2.7FK1PQgaa8-DM
L0J,FG5NOCH:\]^AbJP&QgRDcC5eJTeTPH;A)</HF?8LMCKMPYBYb8WAd_7>N1CP
XE)G:EHKc[J_V,7:Gg0#f24UGR6/K6NM?c</g#T7+=DeT2./:)AWJ;7IP\d/X&4e
D[/dGCVV;42EHY_?\JgBN9g/KNK635J<DV:BNHYcCXQg>N-I,<RbN_Qb:DRE:=@\
H;eFR6XWc^9?9[MI7,X>LI>Qa(Af<EdEe.[P]d3dV(.=2\=;UVZ+B[#^TD)D0-Gg
g?cU,F^2SB(:d):M[@8Sg-L2Y[@TU,[=&2fLPJ#NG0fXe5NKQVIS/S?3fe;KX#(&
9=5U^+9CB+UA(,MY]28F1J8;\N/7VMf)Ta;#g[^-<VeHW.DZ?U=CMYcda;L[)T-d
Wf[@LD<8e&:Y,_f9c8J<.)+N,C/e\VBI/0=f@A\Q:ZCdJ7F,PWTXB5e-\K\6-BJ_
eMAc,26C?6ObALAQbL,3.XO@4V9Q19;FMF;\IVZ^60#I=>_2fc-P6f4a4?6RRQ;E
:;&daKIBc0K_T7E.7:1@cX_\SIa,e322C[A0#:MR0N3>F^0:I#QPD;AY]RI?Bb2)
/_>BXR2X_bY8IU4>Va>JbY#c;[R]Y5FBBN0_dcQ;e[+]&^>CVPT+>d.^<5@;C,39
1SH;\<HbEgO@QD(+Q2,0/Xc:DSRI55T#@RRKJ6^D)JZZLC/+b8[4Ud./=\X3KW^K
JGTE4eSZ884>f&f@=WddR?F3BCeGW?_G9Z5T\4H9?<LO9#R5f?:3\85MacX>R4X2
ET-?_^XM/56ae4))K6/]:R7@)Q#)T-1]IUHC^ga@VO7Yd:C<Y+2aZSQ(P5/K.=Wg
B(A][+-_2,\dNH]&.)PQS-8^UB90e[Jg0<<(Rc1g1_P>#EDQJ@g0[J]N8W27YR2A
QABQJU>1A\CX;NLP0(QA#a5B_:E&51/g7[c4FI&)[JZcR_gc@g)A.c6IE_f\=X?N
R,ITf&=JARZRO<g(VaU8GQ\PGF=_Q,_5#0<HL=+.HT_B)N:-F4#94VeF=G6=P3U[
[X1c@V#/4X;VB96ZGc/=SGK=QeKD;ATI^SWKc(VeGLEF3,eU4.SND5-X1A6c=GWS
\:4+TL8?PTG\Rg4c7f@48FA/\8Hd;N\:_KPeb2=EgA0G?5I,Gc+a\ZY+90g,5Y/Y
T_4;+Z#ce9)F;0]@8VJ0S#+AHFg43CKLg,I4F,RW:N,R54/]FZ&Q>8AL72S-\bKe
SR=Q)4:d3D?=,c+181TC)275?X]d0FPGRLcSR8X(@KNF&#][-E\f);<WDb..6+IZ
PcDYUTG+1/\G=H4KZJ\924+]QFVTZK\ISV.RWWc9cc_#\)Aca?\FXS97@7S?8R=f
[/:AM2ITD\1F-QcHcP02Q;=?J\gBJE^OWQG85^eUa5FCdT,7W6R=S5JN?2a=;<M4
6NN<8HFdL1VD1;T>dI^e&3A>f1c@])H)2CLUP);>-5>g19VB?]C0fKWP\F=_-FNM
SW[ZGJ-]G-@@dU^W9,7NeK;eB)1aTU_J([>2dW^-H,;;OG:JU#OcQIS21XTPfcFK
eSPNCK+0K#=2_[/-0cdY8GdZc)<e9@VM#E^Bd?(HIOb]58<DFBO5,?/O1cA<a9_G
6-X9Zdb52_Y07:&O\Q5_fO#:J09f^<M(#e9+EgK5K:VU?-PF]GW12[V._,#Nb42a
=aZ0fJR,C\fGH5T-#-:T^0A9geP_98Mc_>G08\<c2D-2Aa1DDX:],[.I+1VNg/(7
8&Df#0W>T5f7.FQ(7:MH5OcK6_^A178C#8;aZda:+Y/Zef1<33G3,U4#>HB-RH,(
^4K^GDQ[I1K(=:MMe[V61D/<ISeXCZ62C=59D.X]ORON\WLLT0Oe&Cbe/EXL;J5)
@RUc_fK5:G/]0KC28BfJCU3b+\M+&,QT7DC^@9,)ee=g8>0F\ML)O^X>^dGN(.?A
/1ET[HI<-[f)#,1a9N=OdA-UM-[b7UPa7&a5@ad6HI>dY:R&.9P5QF_&AT89E6/:
A@N18PA3+#MO0HC=2eB1SB.aD4eZE3-M,\9c_<@gEfDLNNH>/OD/#G8WO3e9:\+_
Q_AHC[CEZQK@OFE8=ffVHXGUgSXL,CUB-3CDI16a)/6C)Y@/KR2]:C1EBHBB4<c.
@[R01JX[b,MTX23eE47N=I)b?A0[?H(#(^65_/RL03PD;^74JMTEI&2KH<>1Ve+C
=cG@XPXe52<X]c94:,T\<)215NaIJI]Y;7E-b-:e<gM;9#)a7F8I_O0EZ1I=:NMU
/f4<?I7.adF[UF37(C:,L=5L@+.ObUU#;YHH2a/\fMH?D\5CRA]7aMH4f=8beARE
3AE6RJXcQbW,0F6,91G(<@Y0f1G#1I+SF0fd1DQUV8<<2<H_52aB9?4>3M,\+K]?
._7\fFFd<R/:W_4>VWU,Vd)Zg,a0d?-Mec8QPGB5@P(A1f]OQE@\:Ge6]0FEDfNf
Bd9HA)J8Jg;^_2Q-41Ue#YF&<OgD#_6L.CeI<ZDC2>@2TYegL+O<R=d=UG)G:Q/0
38?CJ?2XX2X_&F2DP/&cY38S.1JM0_Y\M)U:A1V6>X>2ac9<S^]22FE@eg])B,^.
=/+]WOW@a7?bH^LV1]P.FRT:Z##2T5WJ_ccF1I<=ZaLcI):K@IKAJb;Q@A@W?dA1
6Y43-]8Z/dRUFT-f-c^c_KUG,@cD-+-R9_/#<[#1b3#f_^.CT_ScgVM1IW-B#SVO
TC#=A40RS;g+GAD).,4]K]7I6#5(:D6)+P5P/cIbL26.;.cI#T8Ig8B3^EO.d#K/
8J77S\fE#/E;-_eO2/-d<S3QeWP[RRT[?gcXdd@&eg++&M>F^Ve],,OL7&.Q?a7S
,5AfEU<T/D77VcgWd[5_2<?(&ZV6-\/2A+.77M38g/NQgS6+2>.&FXR]4DFKP92W
ZW)2I6Y1Y]B#ORV6N<7f2LD9TY\e:(-WCB9P3M1]:dAC+f(U_+(DI\>LY-;[S3[F
_g+BBAFD9BN<M@Zc_XGB(A4C<]T@F[0RTeM^M[>J1LRV:DT[Q3[0J+YCP@R#=;_1
1]S1g5>V0]]RGP1@?C>TB@9Z<4GX3)Q:DAW#gfEa#NM@Q<9^;EZ?0[[fO4#YUW\&
P2d9&/Y<EH1O6W15=F3P,TBH=<0-M7/^)@7K(S]e[DQ@\-<0+>BJ@Z(Fg70dIH(g
&=bR3d-.OEXe]H@0IX=0>@NL];+[C<+#JEBK7/e^ZOb03_\cMP_<SUK1g18]2GP_
U,/QD@JCNOc&IR]O0=?8SL>)P^4U=5NFM/39MN#2X7d>d-O(KWK4XHZ>3H[W_.H)
5[<IWSe34XSP#SMSM8?<3.O94TS294W4XVYR9/Ega80[&DTSd&C[e](QPF5OcE;L
7TQc)5&cf^Cc)eeT7W?-PN]JS^U(9&7CHR]#<>OVf;2FC(+a,9A/,12e=&6(&PdY
5EEN.;)O<KRL4<3LFGdag>50+L_Z+;XG4VZ^TE=GS8Y_9gGWX//9D=386V:2=1.^
KW#ZU\DB8YI582X.caO-5dYJ>5Eg]U\9>&(L@dGTSP&e5,=0[J#Y.>(R2&WgM-AJ
g0:J:g,4<;JAW1W(S:Q0L[OJZ[U6CL;0Ee&K#^Ld(+<?))\55e<F]OY2S930[)./
KSC0VI>21-.(JD5+IfXX0MB8W:\WaZF-@eAaW3HNZ[Se8,=1N9)@Y;d0=8-W/<2[
EL-,V\:SVUR5G8T2:99QFB,(ROMUST2=^/&/FY;BBHEX7((N40:)NO7FPOcbcQ(c
]W268[S798-[1FNOE#?eLb)5g.D+]RM<G9LEZ7Q)?B)e7fa75^[6[CHAPG(U8CFa
N<KL,L>/?(P032.bLQ6OP0fR)AQI?,VK]0N:KAM4D@@>UP;T#.QM(#+9G<RBN&NV
Uc<03E:IgB3RQYM.3.1dQ:KKA0^.?KO1+5;dd_CRG)+2^PHV2W]DWJ24YR:E#,(M
L&N#E+ZfgNRON?Nc^[V)\=DOEb2]^13Y9]MZ@3T/gTZ:c1d@f8F/gOS^K9DPDWT7
ZK)9V\&RY._R-;6P[SNFM1X:LBIAf(0a>^QVc5ZSF8dFD-KbQ1J[#g<>6Y2:J?2-
A228(+d@5IeZ#M@e:<B:#,2eeO/d.<G<[\>8bH(BFf1QC0UQ+W^_NC:]g5GgT_^>
H6@Wg0DNI\P\DWd:(;XFB1#OcgG&L3S0=(bg=f1OXJR70^SF,f5@ZL.41+]Tca6L
(L4=cB;UCd07.17A;<N^PA[SO^?H)644-2@OGJYH(DAdQSXeHXg0<Y+\-)SZ+=P2
QTPX+-13aA+^-f?[ZFYG6HfV8/^dJTJ)?.547&a).3P:X;)NDNcB9:OgS=bfRaQ_
XV&=VZ>D+D;7#c#<^6g<KI#NOBe=Z_]IJ<E8I.U-(^0Bd(IOFb^=PEMVPBQ^Q[ge
Q^);OACe>MM+#B/^R&G4[f^QERKX?.GE\f5,DDP<4.gQENC#7Zf]B.XfS#Pg4IEC
HTHL>#IYAf8aD[AAb><1V9#8@,[<->;KP45(MWE?RAMS1,]W^.ZDN4GLXC-)Wf)T
8./289@fYTg<c6K#BB0^=]HWc2@<D_W5:@867O#,E8D9FHR?B=9.[YUPF^YbM:H,
Ma&gOCMI^NdTZfJ19)AL1GA-)C\12COGBGM\,cf0D0Z\CP+cP>>6XfHcDY(b5054
)P?P?3?N=EACG6Ng:-M2-ENF&cAaaf7FBMT7(eBPD#EM&IN,URQ_fU#DU^2]1QNJ
(Z^);8@TV@(<>FDg@VAH)HH;gKCQA3RV-<JRC9bN4X1]OH>aJbH&8<+\S4P3JHaA
R772-C&9D\,JRP2R96DS80,SA(Z3J>O_cL\W?e;JC4?gQ.1f#]MKGU@(M@-\/JAW
cJa50WCC;gdTO\7_+DC@S_/N8=9AN<dbbJHVb(4;VW6GE8^T]./b5CTO35TKCe@,
E4\gQ<?9cEED@CR;\I2aX>^;fY&TR<@,^]>;L)::RaSLe82+=)O)HaGZTUc:XR?Z
:_ZU:Ze7HbL\cGQG6YNI[M_Q/D;\3D(YgOVTRKD3cI2M8^ANKV#b,P11]3R_2NW/
Y<MZV]LC4)[eeCYU.1?>(U#&@+@;BBHG5>-?N;.VNZNR#CQ.6@#KKf,T4#_7VSW>
EXaP]O2gEf6HeaFAe<TS>KbT&()-KWJ8QNTA.@7c4>3CeaP_4H3[=0VEUIeT4X,^
LKN91.eU:#WAVA-O?4gW;XPLY35_W1;QG<4MJ?=d2E&G4+D.V+-KTS<SFSN#EEGL
/F_O&SC8X7HMN:31fde0)=fJU(H<V<9c#HL<#V;JC-;1,0_LBM\;[N[TSJgYIA[T
RZJe8I3cJR>7,ID[08@./dN>9,A8/Y,F:/fRN4fUT>V20-5Q^[J^_@COR6?P@FUX
FgaeY#QJ17DH#I_e6M.,TF(,cL2=IZG7g:.gR\LGS1?EBS,aY@3GDDN).FKV#6))
TOb@K))-)N,J82eS:R@C8(61&4.=PQ@_)UBD]\R9Y5H770R26Ee#C^L1cHG</?3+
b^9cf#^fK)A\d[CA03P2).&(035&GYN^=;3I?@=]JN4G]V.3gOCK3-F::OaR@^M7
B0,:f;M<2P@WL?,2FRa>45#C:=DOc5TaV;V_c\&&C\EUZ=;+A#G.4#_6W(O&-_/A
4Bc)b>X@L\93/D&+3UTKQ]S9(;J<C\CU;$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_CYPRESS_TOP_REGISTER_SV

