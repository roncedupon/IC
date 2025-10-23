
`ifndef GUARD_SVT_SPI_xSPI_JEDEC_TOP_REGISTER_SV
`define GUARD_SVT_SPI_xSPI_JEDEC_TOP_REGISTER_SV
// =============================================================================
/**
 *  This is the SPI VIP xSPI JEDEC top register class.
 */
class svt_spi_xSPI_jedec_top_register extends svt_status;

  /** xSPI Flash JEDEC NonVolatile Configuration Register Class Handle. */
  svt_spi_xSPI_jedec_nonvolatile_configuration_register nonvolatile_cfg_register;
  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

`protected
QS[_fU[+Z4BC?VP/?L,FD[]fFI<Lc=UT,-7V,<fUF#)B<4_1G;GR()f;Q-I>AL;4
7Q96M9a:/HDHYKd2NN)M?VL&LOWV=W>0[49\2I.LI3:KB\C=YH=Y8Ke0\NJ(17]8
9;<P3A^JfB<YK08&]L<DC8N1B9T_WPgEe/-9@X&)TeA:2I&ReP,IHSe0P$
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
  `svt_vmm_data_new(svt_spi_xSPI_jedec_top_register)
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
  extern function new(string name = "svt_spi_xSPI_jedec_top_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_xSPI_jedec_top_register)
`protected
1&D5Pc5JF:OC^FI@M3@@5:1)</U99YS6I+XV8A;)UM8#VMP8Q[cK3)/PY+:)PBK2
?c3.+8<:EcZ1&O3;b\R>e32^YWF+_)fD9eOW##eeDP.XDE6D/E([=#[\<6Z&-BUD
GPQV],QV+eOT[)C09aO71:GXbMdH<KOB>g7_45/(38\>TXP/4c4@A7bH#(fL,&LT
_-F?XYCd5bP3gF^0BY?WagVMIb[_8&<O6]<M(Rb&WY9>A$
`endprotected

    `svt_field_object(nonvolatile_cfg_register, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_REFERENCE, `SVT_HOW_REF)
  `svt_data_member_end(svt_spi_xSPI_jedec_top_register)

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
   * Allocates a new object of type svt_spi_xSPI_jedec_top_register.
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
   */
  extern virtual function void create_xSPI_jedec_nonvolatile_cfg_register();

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
  extern virtual function void get_xSPI_generic_register(input string reg_name, output svt_spi_types::serial_queue reg_val_serial,input bit enable_profile_2_0_mode);

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
  `vmm_typename(svt_spi_xSPI_jedec_top_register)
  `vmm_class_factory(svt_spi_xSPI_jedec_top_register)
`endif

endclass

// =============================================================================

`protected
-M5NLN&Fc-37+M_JTMC>JAH6#=W_\EBfY-F7I.#Z07W7c9gU&__J/)?/D>cKCT<)
UD:O55=-1/+DO[F]<1RK92:a2UY?12F>H0E-5B^FUYK-MPR6DcEe[R_:19Lg#BBH
>N>.Z:)Kb.+2-PWX<?BeKB6+g#KV\454T3d@\)04Y>K7M)8?)a.Le+E-UAP]Cf.#
cOd-@.e[f>cW1g_/R?];FGRP9YOQF?.=3/J<KaC3(_1:IL&Nb]O);I^@X&Z3V@_E
&\8a@Cd@(YI,44KN^32KTC0SJB@M5EW3Ca;XC:c:TO5Ceb9JV#SeI;P-1&I&D9H;
\?c3>IE/[U/X)2;\?7K0/B+dVR1LSNe9<#[/V&-=3B0LgME-=GA/K5J9]&IaLCa-
PW;_#B&9:+K4RQ];BDTgeZHC59](>PfI.a\\Wf6H&T35=#V,>JJ-5R)JK1WUd6C=
^Zb+\b1?TA?\3NW.7MSE>=>e/SHP)G]Z;S2?K29&@0>O?,fP(^@GGS@]=M9&WB,,
f4U2\OSWa<^WFTOJDXf7c6M^ZeJ^W\d/8GNKGRHBGI2HZIGBUeWe8WVa6g6Va^P:
-(165I/?S(dR6FRZ3NPRL#Y.<f1,A=88c5cR7>X<C1C\SdOcd.YI(+e#Q2d^8/F4
ZdSVV2gQg7,IZ@OQ@UA7K6Q?4+&\eg4R@$
`endprotected

   
//vcs_vip_protect
`protected
MBITeTG>I(4PPc9GJTHX(/LTUc/F:5b]P<7YO^b-F_#+=HKQ?EOK6(06N#]UEQc9
eFAbRBEPGCC<>30>Q(7eO9:#6^/M5P90D1_+JKOP]H,>VA3N:dDUE2+c=X0JPXe&
&>A:#68)5Zb+QJB.a6=(F1-.GVXDg-ZR#e4,DYCL6/cg/=550DC39.W^N)ea/J5J
\V_\4a?Sb#><(PO[YN36@9#8ZCJ-Y1]<9&_U]KA6EA40ZfIR>&\_]eGN]0-d(2dY
,-DKD;YG^WKU_W,-M[gKVI089?Nb4>QZ@7c?OH]UEAR>5JB#IB,IfQ@2=8dTY.\&
IM>EO0?(K.X+bF8A5g?3@C;Z&+,:#90@([;5dMAbR1KE-=UR4Rg\==,9W+5cM-KA
C&7M1KH3))Pb:S?.K5):bAB?5+W8957S##fI6gWQOeWORC+8U:=S=ZU&0NKF]SZf
5BNEE83a2TG_[=f2EN8^=f?)HZ&Y\Ogc^S#_F1OB4TW#XW>C7[:#VMFcPW^ZR10,
_#NF4MNHD2\_S3+WKSB[?Kcb2b>93IX@eH.JXE&(^15cMg8V1G(>0TDO]=a7OFJT
=:F@fHcV7X+gW7\f=#>W5\25V?5C)fD=dJT4PE^\GFMQ8/2-,RG:Q,S4dd60V..F
Z4Z(P<bBKLeP/-RMSeY&GUC[XY&)<TLg)&Zgfe2<]L)(AXeT[+B0#BG\#e]b6A5(
.]b#=O^g;R-POfN_F2LQ2D1_XGH?Vg_gLc>O&6Q:bO,7D4FND@O69+S_U&09T/M9
YW@@B5f^fA]35R35Q(_P69Za^\/Z\Oc8WLZX51>;;ZV.(AA9#CHa3[9c?-VUEP@a
:Wac(e+/1?<RE227-L.IHG-KMZJR/=S=:?7b#PCE/L=CPS,2QJ[.C_1)(?]_Y37Z
FfJF:(E>WRbN+AG@6#[/RK_9H6A6NR[K1_UH.WZcR-3e)FdGgT0^H\4PJb\3PGHN
@0R<U2P565Y#gCTA].#)]PHQ28C##PBFE0Tg5gGQJaEH4[W.VOK9E+)54MbbD^A^
SdWR.+U9:IQO-U):5B(=1K<a0N_E3aEMD@cCIAD[P?5?)UY9_#2cM]>QVKH2,]VZ
P)M59PIY.dTe(.9Uf),OYe55TFF<S&+,<:ND(8IH2794=8_TIN0e=F2aCL4_OR;(
0@[&cZJ+?R6_^#Y]&gN)>(_6-SW.=X__F]@FLJ5]AM\24L?0b\D8&TH47P4EB_.-
VK^9P7QD&d06S=\=+J\-/:K/aaP#?P=@I8U#-QG_MPPHANA0]48A#KRN8)f#<]N1
.]IdPZQ]ZRV.V9&UCL[XdOC?\afX(_U,]VF@4\07@2#6QgU&dHN,KcCDY>/5ZC&^
V_b&6^a(d87OafV/AHL8CF\@UI7(IW\\R?+K#f7),.^YQ.9MI@(JdO:RcP2VgD45
-B8\C0]c<A9W?EOgH;@gD4fECXHOREJ_U2_)(5#I^_KVg3<)A^&LJZV&&D)YX84F
Cf_892X6UR>P0=e?bXb-)K9)V][4S#WVe8@=.8Kf?AA)Me-L5U8N7U2Q;-<ZM>,[
5>f0-.Z>-=/[YI#?g(#9<:7WSAP-ESAW,M)RNOWZf]=]WETaIH(WdfE?YZ0;>?8G
G?MQ=dN\Q6<P0IB##TM?3]+ZA/+;D/>X(YGB1eTGIZ?5fW\J-.f5dPB&1\fK>[a\
6U5GV88d/f(3>HVP#.Y.]Qe4]A#Qf_Y2/;Kb7_BO5PcO]9ed+8X8(:Nf5/#N@ZB7
-,Q#S[JRSf^&--&.@?;DH0;>bXae+(/@]?IL[=:ER>[=M7M@#R+DbS[beP/2f1[+
3d\M/UY_D1gM(Ff?+\4Q99BcdWX-2D#7VAHEW0J3C7de66d6bB[GE(&ga]N@WN>V
-(XAL>^@H,P9[(.197OT<>55g0&/)aQ6)V>b2NL@@]8aK>.\VP:Z61(EO6UHc16K
#6_,A[L&?V.380[0F48,?H1Z.ORe=Ob(B?2XR.\U;Cga:Q^./BQ<3C;eM=+F]W_3
G?XZ?#g][0/?</0H0N@N^&M@G=R:2,XcSL^A)4+GC.S_5GcKaE3+d#+)375;GQD+
@H^:3X/Z:5WL6U;01132LeM&](d8QcMMLBW[d2&.)&=ZLDRe<XB]Q5?a/[eF-g=d
g^;a7Q9.\0/QY=6c_)N@;NM)_7ZV8&5#K4ZDfU-@D3TFS^M+Q-CPU8>P5XN.9?9f
?HEE6]LDBQZH]aUWa.L2//P(+bda]d:K=LVK:0\Dg]cH>]W8#:;D1(Q#PA7-L\Bc
+M(N#.[_KLB._9/(5X<_BcLI-Y)AI6EC)@I-\FC)d,/.?,PY>SL6HKc<H06M;)Cd
Qb?D@Pc=KIOf0&^<G&;PRD&f4WK8YJccc(FHFQ8+@4F)ba7<Qd)>8I_66(U^[0dM
g8+P/NE&d9I@,.a2>:g?(YaK>^2KAbc?J;FLN25))Z2BEd(7P?/DWcKSRBX6M=Oe
?P]3D-2ZX_&-RB4AK33O?IC83O)K;KX3]1M^D/X.gY#eKfY=ABbE=RWJ(@-RT;/C
ObBZ+g\>>HPd_Vb7?0#Oe6b?9FC0Ga)3U\\>a2>cR/YU6)WPBPL</-aUJ9.=?R\)
f7MK&M\]:,BU1^Q?)GfK1/+^fb:T+g5FS6FfS^Q64GdGT:S27KbG;d=-77?<d)_K
CYaIEW>0:M=O.9[TMXg8#.V-WW]#N(QHU/.;:E7C<):b?g^ZP?UWO6CeBC@([BeY
gbK,7OV1^?#J8gSEA<8ZA1VXTUDK+^W4\TJP-,MNHGZ6_@/AS\8fITF8W8B^RPf2
V_D@,(d9+a2ARe?cWT.7M#@2deSQZ@R84#]DF>cQW7]:.4H>&]D6^</C-)GY&d88
WXYHJFWAC5aEP6b62Y@g9#^^SMWJH+/ef+M081DJ\,40Qd)V+BB<&_?8c-M_C_P9
)+GFIf/E<OVZZYUMVKR#^MJ.eN8APVM5716;1M.[=c1+RNH0LV--#_WCIBV_ELcN
bd/^f3AMa=89G]?\7LQ.?BQ7V2_@W]7SZ_3Ab9]_UR-(6?Q#G/)<+^JLac<P3S0-
2&[/F-/^MU+_PKW8<c9Z???MPER5#M#91@,/\C31e&\KDTKSFQ=08,&\)7)P-EeF
Hc69Z8XWT]A,_6P5CbRRMf0#,@CPP8T(V7WORBaR(f5YX#]<;J427S@=&EYKL@(b
b.)_PDDFYM(.E6d+\3_)#7Ac[0/42+K0HL8LbXOVVE<)S0_#>HOE;<a:XbO/S)c5
QD19;()_:<IY#8?M(a),/4G=A.21;XPRL09+3+#[::5aAAWe_R5)+\Nf8cI=1.G)
ECf-d5bZbf^,IT]F)W#@TU[Ze_#G0]M4IcbLYW-Y4gYOcfCC@2@=A00W-dWZMb_K
P&GEFBK7bK@+56=MQZ4CU9H=@5+/^RT)cLNMbJa22@E9A;RNR:SZ5U(\fB+T?g=;
YG^Sb/a.N?+0DL^7H:[28BdK]_?><KQ>/VK2,[KNVBEV#_RcK;BcgL1]FQSg^,^G
F=6@U1M?.A7d4CG0\Wf:AH-ACK71)]PELG9(d[e:[d--gWU[ZTLReYe-\dI#dDEJ
dR82W3,)PN[,)<\Q]gVY6R_b1:/&/NJaPG-Lf.CR#2ecM)3;T:L8F#J3O3H?L.:@
U2NB@/1c^B810aX8NZ\^VgX2[e-.0&?-,8f&:.MN6U@_GJ+=2NP>MMLdJ(DV\.dS
,@.4=eJ[5@70d\B)RHbb-_DUX#JI^0_eD]@MgY#a:3NE;<dZR\g;3eY;&P:D+C=1
IWO?HF^gP3G-RF;_?[WPg194V>PV.^H]gA^g27Z75gC6Pg_Z::>Q[Y0(TJ42BWJE
[BC)cQ6gAW.TXZd;d.HcVQ;B>.>W90_3b@6c]We;FCB68^INaX0D>a1SG5_H^H+\
f>VFKJAO.FA-C,&VDRF+ZUJFG7#7OfJ27+N+Og_,9CBJUFI[\RH-U6Ha4K3d_JC6
+4f(PLfNEC:ge)Mc0DC7R9J3+]M0e6;F2N3SP_DVX0P=\9X]RGE#1<daDC8HY&b2
L?89J=fQ0B&,G2Ob_K#E5C:F@^eX35ZG#gNMD>Y92#CO6XU&,e]<6ATA4<fXNK?I
3U)NS=EfJAR/0?@-g#]@>TYAT:/W+U_eBI9-[e[>;]KCa]P\\&2.[#X6Qf2-g4b;
]^)U-E5GR1YT)60Mf6)43@]1U.2,BaE9\2GSX2H?FU_3;6T@#KgaKcY?PV0F&1bC
UPB7N/+.dL5-XUL;d.7Sb^gKE4F4KAD&AGO03#J0JeOY/@;<=T/48#c\=-@&DH-?
g8S@dCRPA.cE1Z17JYSd95+A_5R3#UC&:B8XO53V:C<DFK<-aT0YAO3L[3PU<+1H
>b\),,LgZLA(&:+D<R8^WfFbBXANZ##381^QP(&SeD7:dfWV-KGgX(HJbE2>a;#1
^R@.H7ea1F[LbR<WSOO(;A=P=L>OS7-G_O+M:;6eNCD?\Zg.c5g/@(Q?;N_DE.Og
?B6OZ.A[H]DFP/f=MWfb6=O_9<#C0?;L3@H2ceMT74X+FA^=^_DaCRL_BVU@5Ze,
?G94;<;[T7)C_2FJH:)?10EX#9GPga2),=f5b.,afR\E@(&#Za;R@)AU<+LCf.R\
Kb6-;;KU[-;Xb9C<cW3Kb__,;?&_D/DSQ5D3Y4PNE#T25_9)4U?8Z+O[J.9#=f\9
_F27F5g>]UT0c^T_#>BU2Ve9IY@^XYHDA.VN\>,)L,9TdUU@=gcICeG8>OR/.14)
JNQ>X_[C_aFTX#HW0A0E7/QJIG,)e_8c:L?cIe3?Y(@e]bQX)U6:dL-9cWdV(9)]
T<+Cg+0X[;WW&#bKd1)6b]Q/SIKCR?GC;c+Q=#81Ld?d^)6N#C;_HK9BI/S@WRE4
>,cHK_fNc88+-=RDVQM]>QacDYB6Wb=K(41FCcOK_=P84Kef#c.;AV7D\.N-6JA@
.YU)KLG]H#9\@GQQ[4_5@+HS6]J(c]AX3Q7]W7N7J,I.+H_J(08EU-M-TP<.P1IK
^YS@H.@a6M4:3>2RDWR)8PT/9[5.D^70P_+J]5[MaK:IX]fJ<JcTaVM>LG(=<60>
6+VD@1S#E#)5QK(C\O?\/C^+a@GK.<D/&bO?CHba<<I\Xf3&dEE/XE=)W4:G#[[=
AG>[Id)^_fQ1;5A/LFf4\/?#LEOgFL)^1+TeBT3W,8VFW]M&AKP+-R1,EId#1J#g
9IeR]KSGHU/#Df/0ZN(15E1.9U\5IA)2Y/2RNNEBQ4US:ZKZNVZN<3);NW@V7KIA
Z&TW;Rd>.N-(2Bc[9dPg5e&gWg1FYeP.,F1Cf,.]M+=O[^4S2#:=RbZ4;U=G]6O6
J+>(:KHPeJYcG-FG_;(24)[=SUIaI9\a,Z@72/YA71Ib=T[9G50e35H;;GNg>\_H
\CFELK>ggNS(A@HPcONO1dd^QRYE#?;2B;GIF8;SYS<b=0ZVS;8^Z64LgFWK&M<=
090)6/BFJ-dD(FY.8)VB^R)Tf\N\M40_1NTd05[dJD(K;O^g:L(?Z<RK9^7)IO-2
.=L^55gIEBI/;1&;,g,CWY[eH+9NgbKdRd5H(3bH:7PDP[&/cLL12\f;MH&>15OR
YQ</@0H7(e;R5[b\5XMMJO.J60NFUTAI@0#FXg@I^E6e&\36G1-Xf:SVd+gfW\9/
ZUa7R4R]14E/ObPJaI+KU,?T0,]c\@0a>_bG#NK\SPBJ_c6cIaW?/^/7eLcU9IMC
R=+MGTT[>)5=Q0_Tc5H_(99_AWa_CT\8b=,)O?JBGC9P@ARRM;KRVPP>(PN>3;16
g:E:,)RFS2N-\9M,1=;g)=?^,\>DX/@-M94-WXB,@;a=_K8T]E=A?#DID\W8(I0V
W>)070BU.-eFUV4O)Z_(UA[<,:Rgg&3E,C6OE(5^BMO(ZG,-ebfO7=e@MB^6cNXX
:/-Pb6SD-C,D=V\ROVAQ3Ie=[(FE>8\AN^A()K4XE8U-WVb/2,Z=Y_?2BN/VA?]W
&d(>.R&+N5SKO\d;&DRIXV:]XPTHRJ@)YV:G,5:bJ8gcb]9@W?H]Z&V5aOdKW9#;
@F2(@SE5C&V=f/[DAg17RO>FS??;,_,D,R4/D90WEA2^QJbTGXLG\0,M3/QL+g>B
#./57_7dbd6G,:?e875cUT1(5If#U+7GIF[c>H.WR<6?956GgG_;7E(,+L@+fgB9
R[LE@6KNPTI]AIE<7UC<(](3XQ7W#&NK.#)BC1DGJbTN\KP9(RN#M,.&4;IW/+@A
d.-EcI9A6;C,/cR&]^]QUdE^-;:1)ZJ)Y?gK>U].Sg<b2,<8;1aaXTTGFbS9gP)>
PPPNB8E972_@2JAcd6fZHEI/HD6eJJBd]e6::>,b;FeL5&T7:A<<(/SRac),AGHO
\PC#W/L2U9LIOOgS+XHYR1ER&1PTgKfc6F]?4()Ma^W6-IG_J0)RO612ML6>9-:6
1Fb=Y/&]/0R6]NWIbLV8f4fLYIJ3T24VV-WM2HBI/1&(9RKWRCW36GM\(<<2F=4T
)F-.39724bFKd3(I@.AO4(M_,g1e5_98\aa;]UX.RDY1^N>SVbPVZbK@S](=GJ=O
4Xb3U6;LIX4N[GIg5#AZ-QK]QEZcDP1PC@>UM3@b\EAAPWe;OVITb42d4(Z6XFHe
O&0-2b15aFHPF=MC4MbFW7;V:+BU,>>_&>DZgJKNUJYCVgL.DW-F=>L1Q-;F)dT?
(EDS:D=+&QI7KD_I@.DULaX63F+V:FgAae7_e7FYL^AV9AUgbf6+BCf^;/5VbfMA
TQB,XgG0e)F5H(>g^IKX^5:9A,)YX/1QBdR&gSL;?6<@-&&;@HbLZa.#?V?@>F_-
.&bbJP97aY&_aG-.0-+75O9X/7Q><Cc,<69XFN4QE:eLN?86=6Z5dWB04KFae<.1
,7,=.[36efK:-aENC9Kd2e)d&^f6Z5;g5OT6XZ[<bRZeAQ-K/0A^T;IL0+7U)B?N
],13&beJMdAV&RG++;XH&Pg/D-Q/\B[J4[+X7+#eE1MF3EN9ObfE^(P/<L]>IIHT
[g/[B;]:-7/2gJ]<JcM4&#LSQCLW<b<=H9O3OD>LLS0S0-c@1g<[29D9IZT+Y:bc
dC,)VA?8L&TY(&/?X:@QI8ddRe]SO[;ZY8]1OT2_8-0=.R<?3G&5e/:Gf:0R[d/Q
ET@XUKb#33gMdcXdEHB^YN\V;6(Wd)^ZQF[,C&YS@<EZ,eOII54_Ic9/6&aK^//H
4SM,BR^?VZd=PX70<TZWe7ZMX)^M+NTcW]\NgBA>fFU;eOg9Cf98f9GA_,KAc_>c
5HCJ=V^]]JH.S.EMYWK)0g/D]H3LaWc-HV:fgUT.1@(L=:P^F->e@732J_#fL](R
13\[+TCN1ZC@7QbCK=IKb#(b+FfLfF5=#00C8NDTf5/-,F3gODSbDg^@:#XL0U<3
KNFI62E8BaR=3<5?VNI#D(Y+_WDeT1#XJI/],7Y.aUP;2^=ae0RP7\<A9Q6U./FM
\L\,A2LVS(,;+HLaQ)g-[e4^O0<79S#\K8,f-(X7&44:BYY9:10/FGgSR0OZTgPT
<,VMCc4Hbd5-?^/]SQV)GNKZBB2IZ2/&X2TW]C3@<+@dK9Cg_#M)FE:.-OJ^;7B9
URNWd7F:.KfG>L?<18@\6gG/+Pe]0T].V@WBN:a(ST&=0TRC/ZEXVIEK8g2aFRN@
5#@(G+X:<)<ER0F?[X_a)f:ISd.]b,&PbE(TQa-AL1gW7ZNc>[gPQRI667\?e:;E
>;SI_=)X_V\X]@0Va-0U(SKED.a&GOFR7E2=#bfKIHEC[LWf@O75:VHT/>-^Af[M
ZH3@\+(ZHb-LbdO[U2C._[NUPDN(3KKU\1+06FcEJN3>=0fW:4&B\:4cH=H5#<8&
C9HIbC:TWL7[I6F>+K&dbC,JcNCC_[GCD?>+RF>BBC16?KJaA0UN&IF^95AQ#Y/F
Ra2)7(3WH^fKAgE1+XM=&Qb56+[Bd?OB>D2B#@Z/2+3A]W1d5AL],AZf-)U+,/&U
gLABR4Q7-b_PE#RaJ.IcB,C.SWXf_/I_H:B5[7c9)La?/gfY)(,;\>.8A34XWMMc
UMT>5JdOa;@Z]&1UXY4&I+#^]#@CC[a;81#697MA?L#C2/3^-;XRgS4VM#N\@fKS
b5NH.d7\\a<=[Pa+J0(bAE+P5(<.&WX&Hg?]NZf160/W2>-dYL>_X#X[^N+G(L=0
(>5QBe#deG#)R:2LS>J)^R6[G,-J@aB@Vg0IcS6)^Zd;(&O3a9),^\&0EHGK]-E5
KKO;[HY5BDCOXHXG-g9?U--&YA4=]-0PN&@/_g03-4=]Y6B63FW#&eRdaf)C>2N4
.)9+@EWX2Td&]/:PDG7LM,d?FX&L1,Y@>1+OKG:]WfIZN97^V#.&TWR3L11?f57V
LLFBYbT29[SFNT\>DJCQdL8)9K,:eeV#aOQ)RERfGQNS<c()1HQG(O\5+,3V(>KP
7^T51IHBK5Y;1H0:Q/5fYO,8^>VJ#\JMH);f-6gfYPEVg&SNe5bBU-=W)4DMZV44
F5_PF_WNT/)H<-&S4Se.T<^[?A<d^VJ/C]+50Ab&=FgSJ@+93Q8@Y@@Ff=Z/03bJ
<SU11E1DE:GT179:7N6F2Uf(J2MQ-a73RI_Y?Xf)MTW[H[a6^5dP(X1_#L?:GWA^
c6K@CI-0E0JK^FODKJL1(U?Mg^CLTYDYa-9a2,.MB/@;&->fZR.dWU]&Y>.B9@P<
=>(WAO<g9YeH4F1N+\M=dY\K\D.E/NIMBa[TG9?U^@/WIATM6T[?U3L_1P5-We]S
X\<:S4HHK9#@8D/]NV[I:H<NBDEEC&N9NV,#9XO?>+5IH9YJ,:4NP0PePX29BPa(
KP,f&<KFc^bF4O]YHBW^K01fSQ6HU)M-[39G:&3gd_GJO-2d=5RJZ=7EWFQ,;HSQ
[aQ_AU<Y?MHSb2:Z1/6e;TL=\>4D?7^,5^>c:R4f,BB-+eReG&5McH0c(Fa(E2<:
D3,^G[=g+_g?QS(0Kb(^RC43X\=B2dIPCS.X(#Y>#Ac[B(UR#2E:6.6)5.E##<=g
.)=+C[88F]3Y=)bNK#T\61=6^8c6cb)J>BP&#/>HP?+^P9]X0Ac?gc;-S_1WE:#/
Y&#gJX7:R1fPS^&RO5e?-;(;R1?6SD(_AeJSCab@.5._/1aA=0>a=gaNDB#3L[De
aZ)5ERUb\7DW=^TDIEFYN;dNRK=ELF(J<3(g[<YH.0a0VU.7;BOLGND539P[IT4U
3+@DX_;_AOCFL@II(?Q;=#\=_,WBcEZ@5Zg50Ne@,<+38R&H_DEL][CAX/94_aG-
NAR\58L/GOFc9O&gU7]SHcVWJFVHWe;<PIX#0QeXd.T9aNc1BJ0)/2f.H:6]L\e-
(YUQfbDO2/[[3[T-V9MM;6.C(VX/?dH=-9Sg2fTJ07/HbE+=+GF6<SV@:JaV8S5b
BA_D00ZVQX+1X^gK@.NN[ZJJ5bWD0XJb6L2+.GHC<Q^Y+OHPcfHgLYa^NI.gYQ2J
=P</&MF6KO)X_CLUAIBc[V;-B-+eT9)DEaKf=-GGC3G//RZG6DbcI;4H(e.4_ZG?
03g\39+(3M>KbW64KM7+;#3YU]8T\Ld-NGeA_YGSUG&ENQ5<CTZC(_R(Y]/SZ(a.
eF(3F>&R>_45N-Z]N>8G)XBXYC3?0TeA.aPN2ad]f0bWD[e6b],#2T\WN<@/#9#.
6/HL@(2T?\)VF=fb;A+QKI0<10(eO,e7<fKe[P__2:b1000/X4A:\&.JJ?aWP<^c
2BLEY9Oe0WdC>\H^>^,IG0(9QNFP598B,BJ2:A(<FX29RO/c;L6I>DY#=XTX@9C[
@5^<Z(4#UMED6E,W3/]ROcM8\Je12RJ6R+?d/:18(IUa_JGQQ:VIM#Bd@6R;;#LT
=;aO>)EV?+0=-,OT#?Wb(7_2agQW6GY:XX9S696RD:H?D/@RU_(-fJ(cOL2d[T2\
++LDb)g\4V@UK:.fC@>B4M@L62U?7J=ce+1C.cIRG\UcHdU:Y5RIO^^\(COC#PQJ
U+Y.R0#]+6O2[56R\J2W7d[a.AQc_L4AI/[Ya+S15/H>T;3f)0,BZd(.W9Xc2Ka5
-E,aUO;VQZB2)fQgZ+(<PHgPBK[^#Y^IRHRTEf)W/2@Q6=XA>CK4F7>7-YK_:FQa
3A,8O2I+MW)MBQ<I0_TD-05a6=E8I9V>+9Gd0#HgeYET@e,[a<?YFRRVTJ:#6C(Z
H6a<Y_eVP,Dc=6H4Y/,+<]BZ(e#,?<X\RF,8K8]bePZ;Y1B&,8^I^@AY0X<E8F5H
H12Z#7>YcKA(Rba?aN6FO&Va_XIEOeZ1:_.C7.dDD/Vf.7eU&=SUOU1g7TNXKId=
A>Jc\;2#G5b7aT.F0P[S7eBF_38G;J@0MQ7UQK1L,gKE#:K;#O>aDYaJ>9+dZ[^Y
>.AJY[9QBV1e=L(IEc[J7)SCG=/.7R+S0M^C\I1+g2E691^=WCb/^=Kf\L\e0-;@
CM;(G1(_,><(@82;(WSZ&/=TJf@6\c1I.WS:>\M,71+2+1@[5XDZ@CXCaU6W<)Uf
g76346dbHZ&-P=-PcH&JJ,/&EX5aFb:_a_(4<aC^J<K#Y1a:F9fBG4BPfV4a;F7]
ON(82ZD8O.YM[dJf40G=H;c3gTQ@JUZ>]+S=^5,af1g4eC>_4(95YFI6/;CZbS1C
YKKFBN+FB>E/,MeME+[U\[7<^TffE9Cb0,7M>?(4-C7RdH_bJR2K-_3dM>c#AcGa
FJHba+T2H)0]eMU6?.()+7Y?>69-5M;&0)d@]JBE<&@7BU/Mc+e_]?A/Z6b8OS^:
KXL[7[++[HU/QecVcVGfVB^Rc3_LF:Bg(4R+b>(LXC.B)P6d)4[+0XOa#JKb7+bZ
TGB0T(6FcB)<-ZW26/WSES(Vge969.FD@aB1P#Cb]#TBZ=<9X+\#+OD1ZbXMRZI&
HcY?3FQLdZ_CgU)2(\_P)SOL8K8@N#:+eYYgD8D,CfZF)_<AN&.8QM@V&MFLa0J7
)4Z_WY:5QXR7ANC,<@(S+#7^E+J]I\-B=3,OD&9Z5U<aO77>U]\.=:S#O,J53gFW
>e52MUEU)3FWNIW@Q5R8(+\Q[/,=B5-2;V]ZR),F[27ULAN;;&\OfIcXZVOg?@[f
4;8PJ]EE4<Xe>63SFSb6/S#DbX><8&]-I?II;H0F/0QTcUDdLGP9.WdU+RAZ(EQ)
RI+^2MHZUZ?(Nb:_SAZ@UDHWQ0O,QP#bfb3T7R/&7eL,;<CJ2S.MIf:0L^AH[gNE
;(K<N)K)P]K=K]1V=3^5X5SdE,#]11OCI3BGCC<,Ee:U^\F+M/0K)Z1LBHJa1U81
IAA1A3@JXO8X@D,42/Z2+0Zdef4<.a51UPU:N5DPZb);.(9^]_((ZF_,8.4BgbIP
bQ[@GQgc\\8JOX0[3]0VD.2TDbDKV/;0R=:2E\\.BL/W\H<94S-DJ(=2cWLIKT?O
R@R>c/ML>cU.ZReYDg@-^e:U@QPf\bCA><DTNX2.=Q;,TR\e2a2LWN2:[Q^(^EVW
QU4c<N4@/KZ2(07L)M2Z4e\OYdI]+4-,aJS,@Og&#5T)XbIL7<K_#2Y9G0+.U^MV
dd6=U>KL,aEEMP1;/Qe,EcEMJC^2KR]9EE,\J=X0,3OT3;/TFZcP>/<9_^bB4Z6U
)-C:16VWf>)DG6CAEY#WF+P/TTDW#]:De[F?+\2K@LWIeRPe\?[(ZC)^2Z#\b<X(
?ZTZgNeW]88gP,7?bAPWY?Pg_+YfXJJ/MO[QLfB4L=220P[1;AN&LRDJA8&^U,8@
R)\V7Q\:JO,G><HdbF/&H&TZ#WaBgIB5E]#OMWBN\?d9H]36R4^dD-UYKG4/.6_I
1&V=T5>QLX;^<SXcG;A^TPf,?M3UJD\_\>4]X/:ONYO+gAZ/I+]Y,SF,KWf^0\EX
)eJ)\BK?RbPTWZ3YcC#PSGCHY+c\e@;(YT=-?KB-EJ&NVBN&b#RV0Q-I1D>Ne0g]
<[:.c+SN&7^:f^WU-D<\=3>N_F9(RI2gWKH/M.WQC=gcIg2BH164\BRdg\9O^#YV
?)UO+TcgG0c)V.:PfO-EG#8P.b1<d&)]-RGL&c=^2Y]?QNDBI-1+NW+^@R0W2P-b
AQT^N61YU69A@c180T\ZMg@R@V:/Ng&7=E]#)CQ/DPQ;-UY-MH8JDZf0TX:93KMc
D)+aH[eH?6LY;^2<;G+UK_f/_UgB9gQWJ#(SeEGTPMeI)CJ/Y\QMBf-73(1+7]J4
W^^EY@0Z<?LO_bI8&_+A2QL4B?=aQXU>?&JK#GVS.<KRb40e9]:Be=J5Y&NZ-[AC
BO9XI)??Z-W&YJE)LE:HU\ETO/e5E30fZ5S=Q,A6]#7fZG+X;5E\5J?[),R=_YF^
Z:K@_9.,-J?cJd4@O\&G7eUWg,@<IEAMO6baN8c&Q3c/Y0_F5=UH&4<#VfOWgB(_
R<:4.dDf&PA>OR><ROa<I8S2GWARE5&R+R69#4@d(/QQ<)<[b)fUZC[.ZCHecc.G
W_(27\W8AI5(U;4JZaG@U)C(6b.H;S>[SZ^gT4]cL>B<e/bJ1LABBKTMN5@.c-GR
MEH.b.C6_;cd_ggbYX,;KP(;S\W]ED6d/:FZ<1OPA8VW]F8b]7SS@^5K7\Z18BJT
)bQdX_d-W#7(^.3&N^;.Ka809-,.Z0@@Ye5K/MAe,VX68H03@M.O,PAT8ORSRTOL
A8(gP/-/c+/RZ53OH5EUC>R0AH,3HOM/47./&\>9.K3O+-VMFHNG?+#gQT_1^Mee
\>/4OOYUDT+^+OF#6VG7&Vab_7<+f4VWI>R@FdLRA):gXZ[C^,9\[;C.Q+=0?/;S
VA@6(cAFQ&#.637J-DN0>.>Id4R(UXDc/9C/K/dII@<V.P=VY4eXB2D48)aY<+g^
+U]HW[J:,XTV#a7].7V&NE),#8e36M4b7FJA7<M-A0f]^D)D#A_2E3G^6=MV^-^Z
Ra_bUbEP+>>MLB._b]4[#_e_LDdcAC3I#&5]a3U>E(C52bO(JYcXT^d)I_b=cW:g
53]3bNg/LQLRVGZK,U/de:\.8#>ffId9CB5176a<[N&(f2<:>[6Z(D:S#<AC(#OO
A\EW?WF4eXeT?T@]@_Z2-ZGUNSC4b#dXeJZO)<9[612I5B59W_[_W:(_1g0H[AY(
HbeSGUYYOA:9d^^,:7,-PFCB2PeFVIE2G=cHFXWHc9GI,ZA>A^07&Hc&e[\=U?^X
+2QfD+TO\SDKD0Y:f2LbOI&\SQS\e+gVCa;+abS--O9GHVRbHQ?SJ(HCZAO6C[S<
P?I(#/;[2)0D2cB+X,):#A-aP#e]CfBHAMH&eWLa@C@\[Dc5g236L_(JIc8G?:^_
UECd99@dGaSQSL;GH<=AaL;AR0BP8cZ<V3S6(BU4T9Td]L(LVH\<5-JdK6^JKI<g
dN7U?ABE0:f653B>]bFRCM>5K7.b.5S0.\:a7LO)a[9&1NWd\\cI3YcSg#UVG0PX
CVU[NY&9XHS91BHgF4GR01DJ38Q(bg+@#&bY/&4SQ:E#,\2,eKbX]>Wg-ac:Jc(S
U;a:\W&S><B:(M=3O#(.1VM9bZ(GU4I6O01@GBaMNE@)+)K3O4dOV-T=@aYF[D96
Hf3HVecX+GCeY>9/^Y@4(.82Za:d7FE:A[2Y6A&T.d@G[c@)&F(gDfY)&P:&4>WV
0N]Y?RfJ4F2<)N2]aG1[&8)1.9FBN4R)-fe=N(8@&N/Te0^RILaV4=<Nd11-=NC7
LaILb:3=_aV&3QWL7(R[925OWg1RWK,_&T<S_d\#F)cEVWD\HP;CM28?&]:D80?B
ID7#3,+)Ca8D?XbfT8/@1R>O2Z)cMHf;F7DZ3c0O:@4a7KL3M\<?LNEbIR-<S.PP
[<[<eGU9@f\RWRSWeBES2R5^c[;^^A3:LQQMH9N?5B]-e.-[5.,XYQMS9X4\cc:X
/R#GTWVM134_J3;OZ@R3VG[c,^_[ODFB\#g3<8J/geKJB#2&GbPK3S77XQ>6/NbZ
46;R[;6QSR,MAgd^0I#)N7>/^ZJZ1M>=be_RH9WaOg[/D&R#-NcFC9GX#@?&?@=G
?#=3U3#MW7:/C[3RW-HXE+4_D)F<B<5ZBdJ37N/+_AN\M=);d)>LJG+gSJJ-XPD)
:S>R##FMfcf2C&WX7)dg\E^&[9GIgG)A^cN@ZP.,d\X\?KJ\5Sb/]bVY:RL/YO:e
I_2eCBSN<b@W@[g,\_C+JGd(:EM1;T\LFH+VGT)&UdL=3<IYA4B(\H0(O7CQ>:K\
DB&YAJN(>1S9QF<d,AQFVD/KY-VK98=UDCcV>X86Q[>>8[VVPC&0](099PeT+^a]
Z5Ce>HY@^6T])=(N#>DBEA-c0PI[0]:[X6F)&?7D,adc536aTKa#:IT\EV]\?Y8,
K2_c-Yb3]c>A4bO4)O_95&eW1ES68YJGNKabc//6)(fSHU<FU;4/@G\O9E=UF9PN
LaaI:3cgM);6=OA_3<DVNaJc\Y@g0U4+2996.)2NGWbQV/T4SYAb1NWN3_EFSG\)
(cKBY_(c]U:^Sc.NL:X4-22<M>4L[LaC]K.(Gd7,c<1I\RZOULPbBP;3]MQ+A<V3
O=;W&=1EXOY.8dda+IZ3:T/WB7QDd;>?/:,W+^4U(3^@2d5CX+-U/@f209XJE3D]
>)X(eE340M^7>KE7a>:T:J\e]^b5]bXY+g(HN\S4Y(W(8V2(?^/;c&]ZLceT.^=b
/]2LA+4A,71cFMQ#FBBA-17=J2S\X\]ZY)Y0_H:>\D=B=,3OLC&;c>1.])IU0JC4
)L#EZg(ceCCR],VP17D>+_AH+eX-;\E7W9We&V[SUJU31DK<S[?Oe)=D?<5e1XVH
5RYUZ/S]LF<46H=[3g0/:IKGc)+?SPLX3d0Sa64:X7P_@DBN/MOM5/96>F-HEZA^
d6AWA_^,^,Y(QA7WO.>cdTDH)3ZZ5Kc3BZ34P4;S&;MEQ;5Z&(I.gFTJ(dJdI3A0
5B;16Y)FAX@X7ZPHe>4(//?F/Q50>>b4J_80?7W3VNea\aM=(?F,(,\?.4OZ9_D3
Z:)B.X89;&IUd1]2^TCc2_?2J8L0GN1;#CEI+>f2@2J6c84bU+TWdM#NI1#cXX<>
9>9gd#[C@8>f72_Z:K;UM3L/DR&9G@dP17TVWU3F98/K:/Wb:8[/RAH+R7Q:7HO[
NA4/fWe;.PT?3HA;GX]4ASLRQ+^,LXf>2<;D#,47)H-=H9EKZ7Lg#8eDATEJ8D^X
c/,d;^8f&2;I?d][&e0L]OE:WKGHRE:)\U_Y)(B/-O=57.GR[KLF1efI,0&3dBJ0
gBCb3[377].1:58G?)=X6NJ;B9?<G5E>dL)1MED=NQ6^0/Nd416WJ1J#J4V:J-<c
\)<3&61?FBPFO;@4TXEUbf>69\MK@#(AA1c7NE_KNd8+g(M_AG)N)dbHW&1JJ8=f
T#>MU-O;eYW3Pb3aa5WT(C::dDe(B>-d0S;NB/V:VXFES3;cH34SbCEPV@+L>T4Z
Y?:L@Ud^ZK.()<Ia(dA/F9[aM&Pc5I04#6g>d]0F@6>8e<c4G&Pb,(E>P3/>>Q0Z
YJ@+c@AcCQAY,2EObAUMU:bC78QT\[,M(#6&;;a9Ig5dA=,)b7SF?>XL\FJN&_HD
O35U#^&T]ZYXPc2=PJPWL0;8@X0@eb>bQ0d;@@<+GPT@\<&M6F59E&[0e3)f>?[A
@=A8F/[+;7SH<RZ_S&#9,:NO(Vf\gQ6LD&==&G(SVB?DB^2f7>/IWRX1LA_.IO2a
g?UJ4O<ESDQ\&1Q<d+8NFGOZ7ffP=.ed;)_0>gL0X/91=?6QZUff],=#SF3O/LS>
;7WSeTT<KCM^V;\+6?Y-VedCgXbCXT&+a9?WJC(f<3f,E+3@a+25#V+@dA&Jg5a?
KA<Bg92;#3KXCY_La@Y^339>-C3OS=_-]HOE=]FX_CgMb58E5R^>ZL(1VcUD,ZIa
NI[K_K#O]E:HWS7KFMb/?T@+c?QDW[,^L#M&2eE;M:6F#;(TS8,,ELEBBMd\,[+<
(HWgIP^A8G)<R_PKW#U]\XZb[bC5#.G-DTEZJM7<b)\=]JMP>K<Z_Q).TYD;60/G
+O(?SBe]cHUL/-FLHV8QBZEMg@N<[;?4E:\gS<Qg9OY/+_^;SKCW489>&7B;Y]e?
;JJ+J-9RdW81G[[XY0Sc;3,74HV3WD^OSV4DBJZP7G0A/79#H7f0bM8+V@1]64[P
X^=IK3#0GP+ZHC8g,\fd(VdV+N@QLUQ#N1Z-^3H<)(a]L)()Jf=QIE,-f0MYMg+F
0UdGaK3DV6Q4EB=[&.9]8^B\^eF^QX0L.-Z.5_P<#MPOA[PbL;.9;/^Z)O0&]c1#
@W(.\T^7-\ERDAZ8YKMEFGOdAc:NZD5\#d.K.2,gNWX_>F+JGR&M<R8K?Z-3^B]b
.+WCBMcPIL8cNd8;#F9J?W:eIS>D5QK2F@1e,-bZZ4ZH-DQV?1)\,]FbEC6+Z4bB
D?)[Q;Idf#FO5aPdB@#X_?O5UR.Fd:7>&PI7,5I+/caO6aUPcC0TN@L/4F0dM/Vg
a.43@M[RX]T^be(4=H<;IQ=12V+2(TV9bZA9d\++Q>#G)&WJ[&D/bMI.A[b>O1/X
fZ_R.AK6@7&UXW<McZ=3?]TE;fTNTILfR;B4S-PHB.4UKc&<O8YYPaC8K)5:fK#X
/Gf]-08H9-B,]O#U^-,YbOO.C30^OTT+BaI;.(TVFagF8_VgR9/I8Y_^_gg5@DaZ
=7>,:6aH0](1\GQY1=HBZ<ea]2]OOJS49GMSJ]HBW.[&D0E:[U.F>KT>QT(b9b<=
Qg3T>DP\[+C1N@&84C/Pg6JDO:BBZL1,^?X].B4L,OFKW98G8bC#d^0IJ;TT2EF&
;Z3M;+AH??Tg0-e&:gf,_6VgR13W8D)+RCcI3X&\JTD]0#gSP5G?KMc-Yfe7>2&:
NR#OcYCDK<#NC.8C\a;7>SP=VEZRcRe9g-,\^C_[PIDR.F6ea-ZEb5^8Q/K@+C(5
=@)@R@M3]>S9Q?a+I&9Z9a>HKKX-aV.@;A[6eGCH<&)=;JUY-0:9;JB+C)H,9QO3
R8/c6-1BffC@N8GDIFE/@I25,C3YWaJP?AgZeFV]JWQ5bU4;ZA/9A2;b#I>NXS\M
?7B,(bW]cG5(d,F88=>Q?^_b&YcI@dfW0O_<V1E@Mb?f?,fM->^6QX^Aa1F=HIgP
A+]K[_+E158DXHN(9MZS@Se;J]5X,8G+M7.&<a-N>c3ULYL;2W-)G[.K5:[T1<\:
Z3UI<G<Z4PcF,f[1XANS@3)+NMGV71WOe(YB#>S28>\/RKW;0M(e_AYg5UZ#dNS&
>R-P16[[_^GS]HU-=ca,]S3_=)FDfB-]&d<DX0L&<PfY1KQ;++;3:NX6QHE7bf>E
ML77WCDR:>\fO;5T+L&Xb9gG/<Kd)^]523HD-+(:Tb_XeF115PEES[L:([1@3R/>
cGW,dU5,PY?#1]IX_1K[EEVaT.RC-;b3X8T?X#,+_QU\5c-09A^KIP&f?d^LY)E>
K7O<bb-T--[@1((D&SI@=3@^e0P)P(aX42<H&:;@C9HU?VD#VN1A9b<,[0Z[)c@2
B3^.EXVFO)&=NFE9+gM[Y:#(?)W4@H#U?TE&IILQ[/^;6@.+TM[eC\(=d3ZY/cb_
[EdIJe<7HU=:AHETM5/&F\Q]&I?_^G?--33,STD(7F/GBL@#OY&Q+3B16cONN<;-
.6a/:g5,BKY18-(G06/)g#&DAVgHL+FQ#12cLZ(.g]HP.:<CE-d0P?d4=LV(]14>
Wf+V+-dV@^P2>Td)5&b]60f8\&RY8Y97BS46.RUC.24P@7JH^NH+-U((TSZLg?cU
O,TSF<+5.59IJ9BZdL]IHg[674\>MF.K9\Ja.AMg.AI<fM^E4=#\7;0RB1?_3._S
3_3A+A(L.LMVD?aOdRL7U-O3W40M6eN#/=7#>FFgagIUBDc9IaRU:N7=(d3;(<MN
-18;-S6B6eb4-F6=2./:.B==\dWK<+H&X:@MI6@gKFIg.,4ZRGe2L?fA]HU4Y^:/
EXXWUFP78T61K#Ya)HUfV+.05RB)3bQK+Y/)C0e#3>CR<U+;7-X#e/=I1I?VC&]N
U^aZAR.=Y>^J-4<g82S,\L\8DSE5]J.Y2F_O,b1&Pf>Jg1#S7#a>ITdXfWR&B0:^
9E_;:XHU,1g7(MJBbANL(4dV(JAO7TD<)VU^(6b2eVFe6R0&cL_I=0L,<R^NH<&S
\+EJH5L]21+M;W/\gZWf:B(X1<O9N85X-GM2FW5SFR@M?T38eM[DI56.)G)JX=b/
c]RPPNJG[7e?CM5LVHaQ0>d=2U^F0EA>,>8O84TZ##G[GP]]:\)I9N8N5@b_^.@6
FJ\SCL]fHbY#a-.SKLBb8e=a:,ZM\CK&M0V:=PeAeZ1+#Q\(-N[@7IL&8,0_TcV2
(1:[3P707[2)83df=d#V)1)D-Q:eG4QL[8M;1GfNTV:P57D]f,LbJS.;2TD?TP:-
Yc-Z)EaM<W.6&_9/cZ-EM8NUHOM)g-H6W;(L+M><:I@XIf9,E2@^L4M\)P/C?ML;
S>UELIK4IReE/6+LHfgd=A5L[#bVA0V30ZcM=aX:FG645)2BVbB^XJJM53Xg9&]8
:/2;efW7e0bCI>K_&)-=TcBQDf76=B-P[KcS.;Z9XH7WPUROBI\I_aF[/X4:Xa46
QQ>]@:Nb5K4G]Yd>NFD=_#3NO--a?=>I#QDc-D3YA,B/E=9=(2BKRXe4\;N94\K-
eM:]_(V,fNV)6.Y?NG)bLaLePf9cd+X=gJ,6]/1D;KVEP]D6^K)d?,HRE21IZAdb
FM-VDf]5H/:Sg:?EO;6^AK;eF^cB:LF=,TTOMYW9F<d.7bQ,0B\.\FBR[,.BMOQW
[?,5R&M2/;XW[?K3X@(OD>BX\S,Qa4NKEb)gU(29cP8.cOK9D<6Lc-a49J,_1F^1
,PbSVW.NVfU6=3e,=50DA?VJ899->c24VYGPE36QM\AOb2PA2+1+EPG[QX/L]A=\
J;-/9=ROW)-ND<PM#]f@T6@Vd@7>[JJZ7<GF<I:.=(R&+c]>-I/A/QA,Y(#cMVPE
XW5^0AS09b,>UUf)0=QaDR;=W5BY43BN)5\M);CTGb.4MOW=CG[[\8=@3+LcH;.G
Q1\Y+0FF;@b].eXXET[&7eM\?_>-g1):&UfLPf]>7_4C7A2[6T^R]I\B^(YRP2SU
SbD+SbW@4V8KLT/C2Q-Z5VcC(VMT-;d?,/YUQFD6E0W<T69(\KF2FOFILO3J>aD6
Y]=IZBOaJ<I)RK,^a,V5U+AaOK(:KbJf\.4-eZ<6PJ^JJ1=A(84@A)2P;892MS))
=NYB^JfB)&&]ZC4J3=WW.9NXAC2M/VgK&>cLQb#M(R\#Z]C=CgH#2T.1/@E7eY^:
:,aJE4OFReHU;[bc()S-/f64A@QZ;^g5@X9.@/Q9M9,=R82Qe=HG8MX(=OV:D&Q2
JDfZ^RXUD\PA.a]5_J:@(JQL[CCBRT5Mge)\QXee0(LHb(OUQ[[0+4P-X_MG;01G
XIb3b8<c&@?AX<2T]4gc@M_O11]R,_7Z-+/XXBSP4>^gaP[&A4A&eA(<WYQ/YVE.
L#:AK-#58HCeY1.]CcfG_RddcSUfTN6LP5_I3HT/8f3KCAQWRcK+)LVRNT=(e^FI
,+ADNLLW7E9)KGHT7\bK[cKgcO/U+<HCU^@,IRBPJ(:ZfUWB]I-:I9[7Jc:)B1O<
,GNAC-c2F@BV=d],Jc:^8.E^=5TU^S1CaN#B31,Wc_NFOO5CcNWP<LHf&[/+K?<D
1)6)M0>IV=gNPa,?34c>0S)S?.]:_bBXO)-H<]/^::J.>aX4fLL[W2Q&T/_&RY32
53X,#]B&#N,;_;AL/gOLL.:IOLO>Gf=@4J,Z<B1_fD0]=M-QMV&T2SY//<HT&7-J
KK=]#BD5ce7R:c37f8;d(^LN0-M]N[B+aG:RFBB0BK8/daYc&L>_eOSEc^FS_)Ga
=5/8JQ^72c7]FSAa@SYTX/D3[#4WF=C11[R/G><W;(UOR7YKVQ6c-6@7PaYO=)8Y
fGc5\Ee1N-+&O_]92E0H9RYKb5(K>E?4OO&=2L9f((#UgaU=Y?.?;G)A9TYU[aWb
]OeN#f?f6CS]#b;//@]5OZ6R6<7_[7=7[HYg>CZOQK-2X=)[RMMO6B@=BT#b3DE)
HMM9^6/YGL?b-1(R:,L3K&JMPb^T;ZaC[YMcfW\5fV:M+D2?Wa^/HY_WGG+^G/OL
S3bRS\+0T6G?LJMTB^@U1Q#;D2IPVH0+fJ:R+-@+5.gKL7<H21R7Y<>RA^N+WZO?
?\P/=LY4=@;24gSg/?,T(S](f;a+=KDf.,XXD?gXBg_2?0:GCH<L.[5/LF#1OMb=
-T0Xc[eCdge0E+VR]c):bQF?;\QF=a:9@M/3/LOX0^AC65I4eSNNS:>L1=I<b.6K
A3.e_c)SO0>H#U)R@caYF7Q=]:U<3dL;H(f;?GBZd/fS3Ld==AFg\RfebXNJO.KT
1MabaQF4WeW:8W<4D7^Df=?(E&GG^GIX[&CC#\;KAbCH1#O_NVgVGPY09->>,R5=
6JW-+B<I:bc0\LagBC+)+3:3CODdB<HV>dge(3[,C^E]1OIX?EWL>5OP]#X<;VZ5
^\JY-N[Sa;<U-K,e;f:d]3=\I\P89fXJC\(;KP?-3I:M>P1g\R=1D[R\7(E5EQX;
#<#/OATKFKD@J788=(c;1W=18;,-(c=F:YX&96,9ag#WQK3TI5M]OT9a<F3Y@^YT
5SJge3fM=c>@&++W6BU4,KL&GD,b\?&^V,_&Y<U5;O2S:6b);JT(OKZdI#0+1e]7
X369G;XN;P.QeEZNe^<;P8P.Le\\P6I[[ae^-Z<(AU[-5cDWK#797Qb\B@]00S;Y
6E7HHN405c#B_?F\4G1.,UOM5)ETQWFF/NF<G#C+2GAP.KI_PS(S&N:(Xe&)#[X0
a&9Xb]f>K)@TBaIc>Q.)#>S^Lda;6FNT<Lf/V+];=-:>=NKgF?C(d(W&/FT-&b\R
JEc0.W2UfFH,96];;\\4C>;(6L?T/C[C4e6X1ab[N&c>X0-XD_4=;H@aV4GC3#2^
99P&)^)_C,[\0MS5LP=987^LHC(U<LHSDI[VM<+W9[@;Xd=OMO4X;D@aN$
`endprotected


`endif // GUARD_SVT_SPI_xSPI_JEDEC_TOP_REGISTER_SV

