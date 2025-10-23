
`ifndef GUARD_SVT_SPI_FLASH_WINBOND_TOP_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_WINBOND_TOP_REGISTER_SV 
typedef class svt_spi_flash_winbond_nonvolatile_configuration_register;

// =============================================================================
/**
 *  This is the SPI VIP Winbond top register class.
 */
class svt_spi_flash_winbond_top_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** SPI Flash Winbond NonVolatile Configuration Register Class Handle. */

  svt_spi_flash_winbond_nonvolatile_configuration_register nonvolatile_cfg_register;

  /** SPI Status Register. */
  bit [1:0] status_register_protect = 2'b01;

  bit sector_protect = 1'b0;

  bit top_bottom = 1'b0;

  bit [3:0] block_protect = 4'b0;

  bit write_enable_latch = 1'b0;

  bit busy = 1'b0;  

  /** SPI Status 2 Register. */
  bit erase_program_suspend_status = 1'b0;

  bit complement_protect = 1'b0;

  bit [3:0] security_register_lock_bits = 4'h0;

  bit quad_enable = 1'b1;

  bit [1:0] dummy_cycles = 2'h2;

  bit [1:0] wrap_length = 2'b0;
  
  /** Output Driver Strength */
  bit [1:0] output_driver_strength = 2'b11;
 
  /** Write Protection Selection */
  bit write_protect_sel = 1'b0;
  
  /*Power up Address Mode */
  bit powerup_addr_mode = 1'b0;
 
  /** Current Address Mode */
  bit addr_mode = 1'b0;

  /** SPI Extended Address Register. */
  bit address_segment = 1'b0;
  
  /** Block lock array, indicating individual sector block lock/unlock status. */
  bit [7:0] block_lock_n[];

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
  `svt_vmm_data_new(svt_spi_flash_winbond_top_register)
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
  extern function new(string name = "svt_spi_flash_winbond_top_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_winbond_top_register)
    `svt_field_object(nonvolatile_cfg_register, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_REFERENCE, `SVT_HOW_REF)
  `svt_data_member_end(svt_spi_flash_winbond_top_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_winbond_top_register.
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
  `vmm_typename(svt_spi_flash_winbond_top_register)
  `vmm_class_factory(svt_spi_flash_winbond_top_register)
`endif

  // ---------------------------------------------------------------------------
  /**
   *
   */
  extern virtual function void create_winbond_nonvolatile_cfg_register();
  extern virtual function bit [7:0] get_winbond_status_register();
  extern virtual function bit [7:0] get_winbond_status_2_register();
  extern virtual function bit [7:0] get_winbond_status_3_register();
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);
  extern virtual function bit [7:0] get_winbond_extended_address_register();
  extern virtual function bit [7:0] get_winbond_block_sector_lock_register(int block_count);
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);
  extern virtual function void set_winbond_status_register( bit [7:0] reg_val = 8'h00);
  extern virtual function void set_winbond_status_2_register( bit [7:0] reg_val=8'h00);
  extern virtual function void set_winbond_status_3_register( bit [7:0] reg_val=8'h00);
  extern virtual function void set_winbond_extended_address_register(bit [7:0] reg_val);
  extern virtual function void set_winbond_block_sector_lock_register(int block_count, bit [7:0] reg_val);
  extern virtual function void store_winbond_nonvolatile_settings();
  extern virtual function void store_winbond_nonvolatile_status_1_register();
  extern virtual function void store_winbond_nonvolatile_status_2_register();
  extern virtual function void store_winbond_nonvolatile_status_3_register();
  extern virtual function void reload_winbond_nonvolatile_settings();
  extern virtual function void set_cfg(svt_configuration cfg);
endclass

// =============================================================================

`protected
FgA.e7<R-M?<(]5PHM2#[9^1\8[5U+75?NO[+ZaGG@WL4e=c@a;</)OaBE3+N<D#
-^@=3J/^R#O804FBPZO5O#)E9a];#-;G72S&>AHcg@2M2(=R_+?XF>A@[.C8<f+S
BeC<(SQ-&d^/N&;]U;c_d=-d&M-N5@.BHIeLT=DRaa[6JU,NW7@95-(N#TD],D6K
H=64+1J>Y>&@6E3:MEIcB2>RJ@&=;-bc3]Y@/UI?WM4a)c#>K8X@,I#XMGCZ1f./
PCgAJF6G)ZBV5d16XYbeIfH?<e(A6QCVZ,/Cc<BAHQ@J9HUG+3)+NMgM7<<\Z7e)
\<[3Q+c>VU=Q1Y./aQ&=]a.:0/c(HXa<XZ&+R71Y7(8:74f49)/dW+7H99H0a:^W
3LIM3ZIU4>dJRT:0>gU39?0Y\@a@G^Fd#?II8(2#BefD(d3U_KL#^WDHD@7?VLHH
AX4@U3;Ufd;.\#VJI#8WM[.>Nc9HH.VfF+L/IL.D,Z(=3<WR)?.B78=PIKB<\12Q
ZUG6ET?b-c_FR^WbHB6P@SS@YAd03.@EU]Of_.]Cb]T]@>_#:bWO?07ER-RDY[b>
-B-QI+8U]PEPY.X6K1DYHNK>DQ:XWRf<S0^N2T?,W:?bOc#7Z1SfE)B.C7H?Jd3#
34Ob5QC-RGIR0[/:Z322Nc2QbM+1G8aZH8DCD2b[RS]+M[&K[(_a51B.L$
`endprotected

   
//vcs_vip_protect
`protected
HfZaQ/+ZGe2HLQ.A10F7>&LG/_.8VLc_-E@&NGTFc?N^AbBJ&(O:3(7:c\>W?+?;
c#:/[4./OY,<_=<JZR&U?f=W_D?1+P_27&bGL>KR6,8PF:VOL3DAbSbMMLN:4,K,
>TF;C0^4&P6=&c9KDS9IVDN?3<.XB795e5/A4;e-Z>6UdGb>]BS2aaLDOMOO-@6B
57^d7OVDFT0[TS#4S;:J-YPA\T>>:R?e,3OG^:GAW(e]/L#V?+)&ZW?WYZY+6&I#
<GWB-)9b-[_,9](?E^W7R^<]Q:X/X4&FZSSdCPQYfSH-e?93UY-\<HR3/<=O65Xg
P13N-A:T&g78F)cDYZ28)g[egRac.HSKA0FWNX8T<VSfBCea>+(#f\.?ZGXT)7#V
E\0X-?CT8SZRg>7_<<B8;1ACK&/:G;BGO,6XD.=^7>KWNR/+E&/W5)7/MLVZPcJ#
FTO<CIA7&.W)#d69)fC8XE(Q01#&&cQ>^<b&]BJI1;C_7=<O=GW=W(6Gd0fd]dB+
9/NKTM=?Q1:E1GC+.\<S).(2RUaQbQ6XG6_\YWHAK9<VIM>g#BL1+&>(cU5Q:7Md
d2,\IgJ0HFEK-LM:P^#bScQCPRc#L8dW<V5CI]LY)AJ#EH?&#](DRZ_.:^+?,3F0
I?Md48=//\#E)NL(gg&Z2CGF/-Q[Ncd7FX7R&Ue=)+;bDY?A;3WL5;[A>CR,J_aS
FR#?P_IG>gN,(];@##PC]E&4S+^5,-f][]GdO#JO,JCX@)MV6WHER@Ef^=G:N-A0
DOC\V>O(4A?I:dH.CT]cHS:GZ>1VK[#c.6QNc=#a_f:L6gT[MITD^d(d_OQ:Z2N+
^4XESI6/&W<Z7NJ7T>KFJ9E+SGc/=CO#KO5e+]&:/<J?@02,ce)ADdg)W<2:&>Lb
ScG:N0YYK(0OB<T:X7&cggGMY=O2.;4Fd,_4OJ</4Of/<<278b6@c[dAc&4L6&C5
R43>-]aG..^/1@&(Ic4&\TG^YZ[3:T6UDNaFa<CCRV^K=)eVb@M&Sb3-WA8IV#P1
/.ZG6.,HP<4?#Mc0_e3M8f_RKZ18EcICF)_>YH.46-181#\]Ec1ZT@/#:2IWIZTe
+Ie&ORf46<cR/bfIBBBcR2_P;4NMG_^#Je(A#I@ILCK<AIITGGP=gB0UO>2&#bdQ
Ze@d=E&2KB#=7?=8dP2fB^QI8)==[PG+,LX<^7+38bCM88SbDV849R-)d2g&F+V8
RP7OJPJ-S0+c9L/QO6?5@KYa0c[,@VffF&4aDgW8ZT0QfCRafc/7e5<41?Qa]D92
7Rc6,;7e(?b)&f_,V9#BD78J;&c?P56V\V2&&?0bK4f=fJ_bZO>C_#72O3;RX^Fc
5EdcZ:UYW4?dBg+FZbUCf8Q(5B&B:Z?4a>HSN9f:60_.YEaR^GfH-F-6<LYSCW@O
aY]6665E12^(/R#f<DM?]J.[XTFF&JWQ>0I-S\?TC(4.<0b<PZ82G4eY,O<N\f]K
?=FXJa#:#T<eJ6b?72[8?4+VJO(J?;2KS2@<8B6P3Dd;A/Z:#.QV_0PQ.I+dbG-1
^HY0\AeX1^,1TOHP:59T3?7Y63N.][3W[ef7aX-?VNJIB3A1CXbb/4>#2M:^c1+c
-MBA[GBI00+@A](/Z7&@12.UO:\JTPZfA=\KbfFQgZ#7D[1d)\=75CgNVYK8Ab1/
,a?M5[545/V4d,:ZPN;>M0OF&5[4GFYVU)1OU:a-NQ]?5b=IX@F#8YO1^X0)d;f&
f?\,c@d>\@R#9U\f((@.)5FF_&G(DEAK1&T6:ZPJDVN+U3Eb=L7C3[=<D3HJ3FDL
7)fC[8Od/IY#RJ8Xd_9M,=>)Z(TO)[,3P,Z:V(2ZFaa6g0?2a)(DS;R#&,d5_L#d
0cLL=I._.TK>b^SRCC-C?YHQRCU0c]3g+R17VRU0-:WG7DM4L2ccf6QZ(gc#\C>b
V9#^AIf6,\DK\8K<8D9.<[:Vd_THNY@cN-<AGS[,NbgP7RZIFG;2OX9754eI,B;:
O9gG;Af)CD/+C9DXI>B?gJH0.S-g?JeG@?.19),KL<Da05Z.&0/#0JcMaJ_(HEX/
S0-HZK+7[BcDB/CEY3]7Rde6]>&FDO8Q-71,FT0?ZW<f8(_WbQOe))X/SJ]@H_3&
@LR()af=QLGG@GT\MOZ;NLC9I::,;5<SLHB=eHO<4^26,W-X@OK75.S?2g0(?TAg
OFY?>f4U:W#b>&SaN>+W,FYE/XO,7-dI7VICcH_[(bZPDbO3>L=EKVF/Td^6-N:\
gYF(@7P[X^FQ7/Q0YF2P0G79Z5N(QdOf3g=9ab&=NQ-+We?0VQ,^9WC]JbPVT577
/^//[@8)db7SQ[NG>OgPLa8V;/7K3HCE@[6G@;?=:[(OH2)INID:.eYK6F<L6F]^
XPPLET/YVb2fFg&b/Z-1NcX/&>\H/O?f4g9K)H8>0@UQ+^A1BGUP<TcgC)PZW@8I
,</EFSIWOef/Z,<I[fGQ78WZdF<&[+dX&U85d_P;\W9GKA]P\g3M,#..-UgJHM@0
W_^cB#7=;/:OP_-,8^/H8f5Td:N;cU?Lg?9UPA_]5>HCf=[9QT7V\\A?;a0EcKdc
3Df4U(+&I2=#6Me;6=8)R+cZ3-fF8EGM&)XAEK^2e?9MI-).@d6UG,E==.XGB:d>
R8&-GKDA3Eee.G>?4JeK-Ja/AU(PAGHE+3=SX61.-IUH+E==[E_M0eBTL+QRNDI1
6gJE)T4cZ;,8eQ3<=cGG<L</H0]0HM2QT/1_/[3#6(\<7/E6-CgBed<=L<dNfJ(X
.U#0I7K73>8P1I<MfF<JGc5fF9aO6A-?S/5>P^#B:K=.E8f+U4ISK5N_.UQ+INP0
DF::B45A3LPd1^YJ.+0eS(ZY7HRg)J[9^D;C(Ae=R)2a5B6DN+^KH1-8#F)Z_dCf
4=\H0B\5e6ZZ8,g-GBeAGV4+H=C^>VF3):5&UOAdWCI5?;c7bU]1^1bgAS9A>OM(
H[6fDDYJZ^M?g/RU/EOS3,T=I[^W7<VOfBaEaRQ-(_Q;aW)Q<41F360P+L<#daA]
8>+O5fd9K2#UG.I=U9PJ8Eb^<(P<c_M5&g#/QP[&VdICeO=?2>91]EFOO@NVfWV9
RO-&-\JOAa5#WQ2C)g4_3[>O=9M4/aa:_b+E)<_YR;-cf/CI9\SAb23)G;A.DINf
9O^0S73C^=UVT#?R8g2dA+(bA:A]\KQR9\O@[\OQ>,Lde&G)5(6U6M-+(@fZ,HUZ
&#FGTR6M,OQ4eS,QC@RYQPS^Ig&X4)ccQabA:07FE_6_SZ&=6M]QU#AfL#G_Q^GJ
gLTJdYZ.0B2L=Y31=S4UAUM:]66]g3SJ,U.Qgb2PZD62TE#EDUIX_6\4fV3gSBXX
)YW6NW[8#Of&4Y.HB7KNRdCA0TF8.53Oc^+K<>\2W3QTX+;,[SeDge];M_f\ac\P
0)VH>>:SNHA-[IgXG@)IN1M,f:)UG&D4cV+(0G]fP-^Hb=S3ea5g&a;gfT[I_\,d
XC#>F1aE.22_Q>E/&ECcd5,6\+>[91C/_]fCBT;KEY<O(K\JZ;&O.LG-JZA8K6S0
V;9[?d?/J@PHfV@^WBZEYC67/a6TUY5#BS&LUdI.4/4F:@e&<):AHd29=O]4:]TN
R4L3KJRa=(bM&N^?F8\XCad2T=\PR5;NI+MB2DSSMH[bOb8N&-UXQP=WYS8)<]\Y
fB0@P_a9:M^QTJ:6JY>BN?5J?DCQ8@<:W3dFSY6C-\c_L.L>LUG^eZf?AUBQ&SR@
.VPB3CED.G?XE-ZbXd)1\&9bV2]KUU(gSTY:C@)\T?34AX9FM^A@)-2BT_LS1QFM
5+R-KcJNTM]-#FQU;g^^Nc4VG@:Y?Sf2c+7NG<8GN)b1&0+DYY5<cNd/SbBf62&8
KeZad90SGMXNZ5\.-\cb>(=_caF0,#:N5XRJW+ZPO&UC^YaV7K@8.ZU3gIH@5a3Q
4cD]Y-=+/[-=:=VJ2H5<L#@[&K1/c20U^X?_)bZ,NUVITO4a^ZD,UM=+X072a9PQ
J=f;OQ,4FGYYL:Z[_BaG,<&S75_NY]_4\=+:YI5.f@LM@8MT:,AI7g^e4E+4VLb(
c[A:@aY7+?Y#L?]DWU2=F-KTL5;1gJZHGRCVgUHV)40=(27T4N\1Bb4(F)+Y-DSY
dEdF2[gXM+Zf^JOYcN#6^KTWgcXB16\WA_RB)0[K?<.:HA/])Y14U7N1FQ3O]adH
BCPELf&0C8QW+&#+b[Aa0JS<UNg)>Q=IH21&^Vc1Y)8b:F5=Df)591WU:f4D)5c]
d#^<MDCT7HNZB(&9C.MZGd,T>fdK^P/J+QFFL?b1<b[?M;[:/FWAfK/L5+Wb#M:R
7SEIGH9EV,40c1c;(:O@6NEdG=dcU2SE1JL)fP8387Y7[Y#JAKZLSQH5CZVa#-:e
V9NF#A)RcTE?;?F^#C53ff---97QI5>:+I=4^CJ-?/GcKOg)KF0N#H,L^D(2F(12
PMd:ZB<Q?_(=[SR3V3ccLBHgO7..]^7[;fF=VI_H\/VZOORX:ca&:c)eVMS/KZ^)
HNNW(MH>)K@<HOR,#c,[VfIaY(/#RIV>YYL765)ULdI20E]Tb8F)8M-C#=8J18P>
g)K.DMBgWPCTX)C]J7]#Dg/5PfS8,A9:>9-HD<a1&>+7,Y/3T3>7&7B8=<7W3a8_
1eJ6.6+dNWc;d,^-Z-PC8a7/PS?C49\;@^[8G8RDYFX_QL#5gg4Q/7A+-&/5#X&.
CPW-PW#G4#2Qb-OYG8GM&2-;SD3E1VEbWF?aHeNb\cQ;.)=6UZL6V7bKL9<SRVP@
#D@MUJ.2,[D:47;A(715S@?QUQ[HW?ZE;#WZE.J33A>0NX(BWKN9OFO6GaT2_,)T
;9O7:2M\]<5IfR6(OPF;_a:5bC;AL]S/[e@F\d#=MFB&5[GJHR,[J,^dc_DCFc^\
?EPP,Z&\JQ#()Ld:[FZd9#@/AGF3<R=-GIeMYBCT>L62.,3Y25CUF0R(/<@5:,4]
F4G-Y(<:G^]F39P44CUW<(Y=<2BbXD95c[J_?7E^[?eeW4^5gc1&[44<<\f:Z3P,
HCKE_@B82OgI8>=dNI#^9NA2-e;127TBIO-S3ReJQ035W&df:EF?>IKVKAEMBP/]
AWg,Ja/-4MSdELUU?.(^>aN-A9E.R^Qb90_MWEUH>QUZfGR-[QH>Ze:ff.D,JZSf
Qg&E.B0T^cMVS-2&bD<_W#?BZf16</978@XS(KR391:&0-MDNM&(T9@S(L/EaS\J
/X&Y@N#/E8eX;]5:fA0V0#Y?c7_Q;Zb7GQ#NF/\J^5-:4L,<g@H07df+=^&\:RNM
]6B.Pe:4V_HD3RTF6g_(=OSWY0G@bV?)#C5U8H+M]>=G<N/_H1CZ1CYL6/e0@4\N
9;>NAZHR1LI[P0#B)PQg.V4O,CU,a<;_6P[7>FB\#OcN<I21]/QgYagf4<M852[1
AV[JaNXIcVZ28c.M3@AaU(3\Dd09g([C6CR1?ID^3PAFP6OMPITZ;6eH8BAMU0F(
:=PS118e,7PGGfU/DJS^_Z&_S[ZBVWFfC2],6a](@1#8B(OGF:@P8:d/KJSLFAdY
6L[X_4LcR,K+gUY)]K[P.BU-)W1>,;2?N.2<G7PTRa4972G0IEI)HQ:(.-:eN^9f
B4YBa<N5Yc.QUIP(&_ZUFA]0c6WG[d_.PJ_WbF6G[8e9^NJ5Q@GE5UCEIT>OH83\
\WT[FZCL\X:V8bNJ61MT[3X<-]1aZSXeLUY_/U[&5?>;_U2+VYHg1..LIdS++X97
#0ABU+&-<-Y(,(5M\3>&O;)]4d0UT=[.a-8UfK.BX##E3cHA953OJL[YY=:)cDb@
fU]IC&e<f&#.WVO9G,AKM^^EZ-J+8ATaO^E^_bMHNTQ#Jbb]^fH.a@N5T5IB74)T
Ea1TQY8b@EMYM\P1:,/:+N9Z+(>SaWGVYK53fDf6V<_;9GK\V9?a;7^&D#AaC]1Q
dVZgAZ6C&Rc_C#Q_IaWPWBf\L_XPGU^3S#;G8DM31FT8OW=LQ0^b.C8]F9P5\<RR
/Z/0[&&Ha6dD-<.IE>+WBSBP=2A<L\.XJ/,d857VJ[Q<.6eZ)O.+4P4FRFJJC)Lc
e=dJgd\[8c:GUDPaUIX:Z>gAb2W(HeZeLbW/.)8Q:[S?[0e<V;ID=2Z-+da)1V&2
V26J:MPLJYg[N\\\V8.NEeQT49ccLd/H?F_gVK:&e9b=:8Z\/[#aSATMKD=e(:Ld
9@<S\:U4/ZDGV\4:/39=:H1A5^G/>=I>8;,28SbecGL(2b+L>I0;4LP_&?230FNW
7C]Xf9(;3A43?(Z-fDK>MO/Qg@B0^_eQBGB0YPD]-R>;f:JP+BO>@CB(Ub^@/3fM
9d98f27@\PON18(R8-bgC5N:aCKV9ZNd&<aO,H<^:bH@R)_c]Ta((^1XfgE,<d?T
?:G>#_OCLZAf_(@a,FYF5BI+SUK]?=fA97?VXaDfg,aO,:/;HV78NXZ3.-R-#IBT
0__<.KD2OF>OAH()55V/>(^a)5LQZZ1&fLR[XedfB=[+03Sd<gZP-ASdH/>CDON3
58D>L^MMg4RU)4,:PS(AB^4Bd/cB=CGdA6<QLac\a;R_MB=0D)Rc#(5/.fPZ^F;K
/(0^9\,\R6/G,O\4743J2Q0H(CUg=A0(LVL;;f1WL7bbDV4d)J>1TF+_;@J^f9F4
g8O\a?9[-_f(VT0B>3RY-ac/N8YFKIMaC;LF?TR_Ve@E@(]-1_T-,66WJ@6c/KRR
=Nb4;]XIP=[W),f>3U_4-D:#?,Uc4c3N+BC&\D0<fNbST01:BOIfTg2@A=)GNQM7
=OHH5V#-67d(K]2[R/Y&#Ae>c@ZT4Y-HEM:+M4Q]DD^_O)Y^We,\_<c<,UEP[A@X
,U>GT.9&;3?<N#V_@BJO7Q2EaaPZ]WcVX&YN2CXWIJ>]/W&DQ6JPW@_JG5<EGHKT
(I8:<O[C;eLg,d=NaW7#O5QL-TPFLZg<ZdW\.dO^VCc9(@Rc8(UH82a3:TSN]H^-
GQcO7>+8bMT-&?;ERSX50GS2TgF)VX+J.)10##5cY[/:X30Bbga]YLd6R=Z(b2X2
7:ZdW7YT6IL:=Cc_I@:&59.b)@?<^.D4P]ODW5;V2[Z8U/=#d6)+2QgFf=BT<[^R
L+72ZSI0a:_##&64]6N.\S@4\+Y[Wg<aX=BW>ac_N-8LP(e]OVA]KA>ZB4XNaC/f
\2;67Z.M&0IT(1).L5R0\Ab-B[C[Y6)9S[)=Y_?A_A0BD_5@FM3E@)#.U,eYJVF?
Q)NBfF^7O^F^5#N(F@<KPL&IYMc<\8e1#=LZE)-;V/<KB&abL(TZ+f<@KbFY86CI
9RB-L</J5VOAfPP5HTL4]LQT^;[K9KHGUCPgI=U?ISU8)@6<CK=8,BMVJ>QN7=d]
9X>24>746B@M)b9-:H?HBAf5@U[<Pg)7;-IP46KF+aHc2aD2\\6=T/2,;]F[IP8/
[MDI5^TF^eJb9B)@FHNHW:R9\9U]He.).=Q@EKdZ930aDX\NFTZP?b_)L]M@F>KE
_B9D[GeBg)+G90PXB@B37@XJPeYKJZ/5?bXCC4+2B2JC==bdd#JB>gBANd355VM2
/,PW&_fV3Q</P[:00WK=/W[34EO_^3&B_XP\^>>FKEG=(@]J9TE^I-(&KDagfKMg
?LGN.=NQJ0F3,#599F(+1G0)G67J32GF_^.CJ/?+JZDF\A_)_ET6O[;<YSgdN,C5
BW>:KF]I45I(3NIJe#40[ETYdg-G,eV-6=D]?5U4bP[CVR)[fAZ0eOe+FNM0SW-#
L\e7AHP]-;(?g)e(Q-Q6(Ed&28>E@\_c(A,VV/9O+2U8[KdL\e@39+8+RJ0H1I2g
CO_aR@>H4@DE7P6#0Ve\,+Z\1Zc.4+\OQ3Pg>,=G\B=I.c<F:cI(OCZ5+3_C:=7F
Z[4a0Kg<\MdZZ[>GX.5FM=dDY0&7I4>dIfcTBXgB<_5Ye5_A34Q[XF]_@Z3M8B2)
9>aVXAfI_&#Zf0/AR&O6WU0=)VAJF&ef3&S)6X_L?):(>.5[9dC>.KD/F)#VK-Ig
/&N)RS^DATY,Z/N?bB8aIA;3+M]^UfI[K8e0;CQ]fEBO?E@[IRPddQ9<c>FEC3g<
H4VD<<48@,(D9@PcMR,b#UY8F>6X;d/#USU:IU7R84]19R@JU0S/g33A_aZ))B(R
@4b?_(:5Y3,<)cf=eM@.cV?>VfF50dY5MQ>d+]Y]^BAV=a>gT>>8)O5[g@=5GW+_
b-4^9/D4;,b#UHGXQ9.12Y5(IV>+78QeQc[O7;,EEBLd896YQ&EBR==&Sac?-X4g
YO/eOI&N1[<4GfG?T[f:E=8&+b)O-SL4F8PbYb?T;AdRe=]f.>&_gL7.O[/]a^JX
f=bA\WfO+U^I6W:&K6&CG&_1ff?2=KIDXIM4+K4gPOLLaG:/)^NR6WOS\(A]G42+
Y>/ee+XL4,3\+4@+(55WaT>:_dRJZ\ST=<8?^5G?\QAF2/4^1;,^AAT?Ja4#Me8K
-EEFFUBQ[?LC=9C-^cRC&)1_CQVJ8;&L(W)+a[c3)AITXJf=;<6ASKd&3Z,UdZSg
;L_1.ScG@5YgA0MN#&(61G^&/VO/5H4f?]=;C5_3(]_^S#5(2&;/?\<JR]E9\B3[
cXX;QW0#cF@<2+99Lgf1]L=CYW]UDYW5ZA87GV82#1_H)#\:_E8.0ZL87^<?2H.9
(?P_)L^RLD&b9N19J>Z\.4(MdL>N8ED?[f[HFTY.L+U6OS0GH\-^T;\E-.(Z0-Z)
UEMdd^73\e0J+;]K7(EV#H:R41W[@.AZ3<=TAGMWc5<BUeEL)M1H[LA+F33I(&Md
=a;]4,,6]\DC_Lc-+>E0dIHUagc;eaTbg=F9<KaL>D7Lc>KE-D[5AK+2^eS/S^@\
-UJ7KA#GdRb3E\G+JC?OYG[UeI@8EZ(X1-8beV[V8[8JEggb)0/f;4]^U@F]RReJ
Pe_X(R2[EZFF[&.&CdKDLXNC;06Za5^;LITddgWbU9AR9KQ2#?D\1=,3fK[dV/Q>
dbeWU1@JKYdV/^g:bLg/<^A4.,4IM:8UN=b:=ZH[LQ_g0]?Ua]c8e\5?;6B>P(0=
SE&\>a4626.MTTO&fTW)Of@-5]b+<ZFU&14dEC=YV5M?2CX)[efTS/7##D##WS@B
[ITb4G,#1XH_]^.d]13F;+D_4RGc73N2=9+M,0dT)N)LZO2/Q)_DOQ@,BIA.7ZFc
,<=S)g3>/]I6c>XS/)0_D+683+gI]J\2J#_b=71-\H7<NVa>4gK3GZ4(N76)]b8>
8UJMT6LK7X>>0KAc[XXZ@BN^\cM+.TDC9T?W22\R(WUbKC5COKd3]W[7\AV(2VN=
)f@(ALJ[EWT>GV<AG;267fe2JARAI.QAb5)Me:5R_3ZLLcS22f@M^&KD:IDEO&Z5
L+1&QZ<_,0P6/&Y-4&TQU1N/:?8I^ff5>SW,#BF^];IG3[+:8+\^?PSQ:3E&UcGY
e-10X4e]EaaKP&4JD-ZMg<4<<6f[<@O10BJ9-IQD[BJ<WX-2JSV@>+b.C-Tc:)?X
D610_Xeca.P?@N^S&7-2L,OG4Q=BaXTY6[PA<Z1ED_@Q]O/A>b5:b1@.@a,<[CDH
V_0\\OWg;)O1)7OUc:U[AD#)],)+ZN9(A6IQLGA.?,dFIeP^KF)dff48.GZ^(fDW
B_?44D1MFQC-8+?Ta6&EFcTE16fa+gc2aX?HY.>Md<8Oe9eUNe40P^CFAXVRR70V
XSd_+>9FHc[S+9OYO>PS<7P1X&:Kb>5??W;/e@#&g=4MfM4fI;;NeA8GQ7O[@1/G
[?b=Vg&T8-IQ<_]AJ5\Q-=_(-XXP5VF+3]@->]W:KZDafZ=7HH)27a;HIYN9;B&+
DFCR#fRD;HBFDaB@c0caEBc6D9Z7VfAKR:;TA\B=/RV/9C5PQQOUL7Z9+YRU-UR(
M\3\TVP5Q0Z+.SMZe^ac,e\b29CbgUe+GOWML)ZTb356;aNQ?&WO5VN@F#-1@e5?
@UJHXf(cV7PZOX3Ic&)8HY7Jg16Y&?K?,)N?,c+T=8IESXP-3)f2&(H9Te1S;8B,
.E57U[W7FRQ^YS;e^GC#^,aWP;GS9?a(HZ+(^TAM@]=JcI?ZU+1</;;?SL?Le1QJ
?2R)+2OB0d3e9#@dH^#L/dIJ?e/aK:/[UPJO2)52gY1:[UKQ04?(8@4^]URL]YEc
7>BU#)D.XV2IDBf2[ZEWdPP&PEcRO@ObW1g-F]HQI\D73F(U]Y7d0U]K;S&A]3^.
BB&?J8^FaL\c.-,?NeFL&>H=UgM3=<KAGAP#5=UeM<->+)?S7ZX(LEe(cg1]Baa6
[#_B[,EZ3(FWU>(fS7R]GfCDJc5K&3+1Q[^M&;&0J3C9VKV7bKe1OGPU#Y__JKF)
#b_Z2e,/g[;Q86;PCKfDIBgDg2d>a+32?Z:K.HJ[:BIN9?9MT@A+8E+/X-J^QeMe
E-HcH81XJd4G;,:2J6d^5:2]T,@VIP65\a@4/4])GC>1e9Z7GXXI\g,N?N&8TO]K
#(Jg#ZLW[XTQ:8/=_&9V@:FS\\>Q#g&888</4ReYG<Agf-d:80#RAA.c_Q_WOR[N
_ITP,ZGagC[C;#5Yg28Yg&RT21MQ5IERIP2R+A-Q?9)=U._=e-D+/bZT93,KR)()
5T/T)^fHI++gX=#T<7_:_9c+UXSXPTXB&[F.dPX)+<0b5UQDWdPQH[L[^7&UB3&d
[9:E;4[LN?c#ec@WL<_];)KY1-^b5EEgC@0aA0>bX[:,B1@aHVb(CZ7:5H<C^H;+
H:NM+9LC[:)SaKN8WU)2?>eNHPd<Id>QW6?)gMMWC2VI#M=R3fP7/YB^[LEKdOW)
d>E99A=RW:7SGWfP6;:I.Z==[9(QgF[1dA<:HR^DF]7]9HGef6:(6AQ+]MY)/UbN
SH:dZe&2[2MK4LG&F&1.GA2./</1)(_B=A1RY4C,TC@2YTB+>X7_F8(5I@P+3@65
A;=^/V(5DE&Oe<J]/M(EQdA(G[Jc)P[5@eBJIJ:8K2Q<efJ4f+eN6>fL1S]f,76f
7X^1)A.Q>)g[N^[@(90;QQ4WIfK)Y_Ie\@1Uc])3dSRMe#,2eT9.&-@U[E)C)b=0
5^M9/@^\X4CfG+Z1/gJD@#,R^=f1fAE-c?+E^822+[>?SI4AY.f_G0J5D04fXdF@
@:KW.VO0P\E4DVdBgL0e&RWK;aYPC=(Y\(Hc&B(dDNY(R.#Z9g;>5#BJJfF<TI=4
a5Gf_V>]TYRHGQ,0S;KHQ&7MYS&,V[RT_D9bQ_NYbC[K;MbbBaO/\E7:,U[CQ/R]
JgSM.Y#018ffD9gA^UaDGG5eGR[J=6HY.]++N1=V3bE7^M[MSU<5,CF(QS2\=bAP
^gRf\-5REKZE.FG#9DNaJd_;@3^2G.8.M;aJTKAMaGAQ+D4g<WKXBa)498WV1Hag
5+#@\YE5]BZ(;PJTB=#]b]<-&(9KA&cb)J=L,[1)82Lg\ORT[@.5g8)Zb69+MZ8E
bY;EIFC2/8>b5?IDZ&:T#]c1[&_(W&gSIV8_+_IBODab4XN,PR9.=XJg+W#K1U5L
6NcQ&#/9]-.^Ua2\=<@9YKX;Ee(E>D[6#RJC1a=eTN(\1>C4@L5YT89)aX7Qc9+J
<81IET5f@?6AR2>]TVd_2(DKV>^7ddB8//563-_Z0JHDL(+NV\G?);DaC6[3:R<B
/P9YXU/5J#e(.6Q:+gC_T/ZbeIaA2V>G]gK^.a6&bG2;-D1McW60,PVA.gX./BW)
^VXIa.(/L>&/G;CG<[23WW]:[-R(fJ,G)D\NSa(X=5[5;\2.OT//KDJS04?ZDI:]
4:bN:\TK.]+=N91cMV<Y&6dY)S+?ac[g145-H8a)-T42b-[)01>Ude7I#KY-@?M9
SN48@c4]-GHPRdFbD8]DG>REA+6\\(=S[^M]?]FG5@^6J&7/9Of82_/_TWaSMU=)
E.C56SZQ_Uf5)cUEJfS4[)gb@5E]5dP[?X\B(Cb5N\LE\F11Q8WW=<LL2#28a4H9
ZM8dU?L8CZd,+?S&DMaT2fD#ML)6X&-Mf=+cBI766[?THY.+=GI<=6BY++d-7I5S
LRDg#+Na^2?_R8FRaT_CeKaQ41_8>g:-,EdZ0PR6D?@?dd0<0I@D;#BZ^IQYfFQa
[00G5<@g&)[_f3L+48VdaM\BaS^U9YQKQU=4CR&4=.9aFK1L)<d?@2GH&9J/dY^a
F7^/OES192]BN].Q;+\=cT4?]gF_eJ15XPR9?=-+EDR&&A^Y/>]Mgb.2I8Z-]\b]
WQ]8Q^ERN&@8_JLY,bY(4(/-WJ;R-GJ[]dAJXRL5:144f6OI;PTdP.4aLE;P;\<O
@af507Q+9_3;[)6eO5M?/8DU^bLMBdA&J^,I3A+S>bDOAT7XE(Ob<&HfB/8e/GD6
,K+cM6b>@I1d[2=0gd,W5DUaZ>cOT\P#A;/31Y7>2\Ief=\WAU:<F1ZJWGH[4IVP
)KR^(J@P0I/SS4\UKd4X^<A)+Gd+0&HAef[BG+H0C]8#g>\-dO+))S1TT9MQ^S@Y
eITV)I/5E4@F#R>OV:-.N\[Rc4F8<DW44_gUJ.6FE=&I@Ha>IaJQE.I5c9/>1HAZ
=_CgeHNf:Y?S#ZCaO/5^>[R#/>g_>_L;-QCMLM3?eP#@V>R=H@_G]>Fd[N[5N^Q?
>Z93E;Nf[U;=dg_C&MR:+U@W]GFOFF&/,fG#c)FIS74b:1V(_D2RR&U79>^:LcP2
N=Ac#50>;Y9;/DZ23\5PBSQK>3AHF4JFaD;d5X2/Y&5Ie:AB+A3#AC>XTgS+)Ib6
/eKc9bcSG>+BVY;Nd4).D._.Sa@DB>3=6^B/P:T<S[<4VE+3J]^Z8?T#a^Y013HX
C.6c?AB16YV.J2[CEC71Ae54#]c(IATEAH84QQ^S8UFJXDK7=eC:)28MVUcKEP)d
P?#Ca_3_DVR7(aEVKb&+AP7SK5^NX2^Ra9&:bf6(C7HW[O=\B8[V4_)RERGS7OSG
RTZYPQ#<RNMKB?D0N5-V/YZ#?C_EeY(B4aUd/;1TGSS-YefdF;CCB,X6)b^gbN0f
dP36VgLE;+14fKcE#X3B-_-dA^8PM?).#7L?S?Y&0>/d]2dDa.UO8H5IOBL,BR?A
XTWB:;7Y8E6YE<1P:0I.WBA=076+NY^Q9e&=6F9P@-X_JCHc>0&JSZ[7OJ?,IL]D
FW+D.15M0[5(ZW:6X3VD&^5bDOILSHJX7Y6GNETO^S?S;=LNW@KH2fJUZ?N^0X-:
84PNe;QdW;>_-UU.?1WLg^CfD9)f0(;.JF,5,EW@9-f:bJQC/Ob__.0VRO+@B#\7
8PTBM?.8,:BIM&EL]XHY@,AB&Od860;FG#e+/4C.A@.+Hg=,Ng=N4/b86H;5d&UH
2MNW^D7++WRUJK0W:?0<WPA5a)W,V/?M.89][FDX,>71((Q0ZV&F/DQPH;\=AZWe
J43,F,0SIJ5NSJ@?_46-)4EG@G7DD1cKED@HR>^KaE+PFI:6?4#TG/KT3?96\eaX
0OLB-FTgGSE-W)/BA,G24.\?9KK=J&@]TIeCaMHa=@e3I&+Mc:)MO#2_g@7dD:(@
;E5\SCR8II2?WIYU9#QO3^O=Y.[4PC8Fd(V43U;5-Kb720\B&:]YdU@7e3)48+T^
WYMVT[V^+GD74D:O2S@-#g@MA9VW5NZ)[:#G[3RAX)JAEBB[K3O@Xg0:^gOWOI4X
KM@/D,1ZUR7:ALV:0WA=>5J42A6II6UeUI?3I#Y9OY-IF(4_3fL0O)=S>^YN+FJ8
MT/4R7S+d&HSgIM#ddc&_-4A+f/0D6.FL5gMG]TX0;C78^)f.I0\)P_14=TI&0-O
edTRP3#Zf9CS&?BaB^PVSODN8+Zf.CST(&-MMWJ4=cK-<D686]2[fO&W/.@@@4X[
+OZgN(]F6/9E=CYRB3b)6Qd;83^V7M6[LAOX8@2.#f2N,e)BQX]VY8DdH9f,ER2#
C:F4@@L;V(>OEJB[=F9E7/#;+f2./&MB3T4\,ZCXO3CQ>EHGY0RfT7H:HFI4.?O&
5^GaIJQ92H1>gfVSMJM&PL;FWbK_:7P\A//>GIOI(<Xf/:<9?A\F&8&Zf\B1gBbX
(C^<.4XU_4;WaO_U4-NEHGM7\Faa?WH(a965:V&CdbEOH(I/:NGL&W79<WMP>528
3=@UL+<cC0bLV&(b8=]UV-U/Sgg\HYEX<=;+b<^N;:c.VN2X+M.0T#O+MaB0&Me^
F5MR.J,=5F84N=E<]DE=3BQ?;efK\V2(6E^7_S\-MX)),?(LK.4-S:IAW)P,g9?1
)Z0H\8>CdZNJ\BL,9;,@N.L7,b@NK3aDL_^-S-<I/_,1RA;VYNI3111TSLIZ:>WC
@#1TDRCGDJACcD@F?#:WVg_CSF(),OUW]AaaY(@c?c,&81(a_CO1;>UWdQ[CT-<(
.G0.WGOZ3@;Bg\(0@/ETVWO,P#DY7/I?44Ha1cXH_5;-EDBUQW/@U;f^Pf@<0RJO
DLLW-(U3:H:SX?S\G8110QFZ6I@EG-ZKgB)NIGNf35P5?:+)R[[]5CH;)NTP^KWL
Y_G#f<\IcWcU+4/&fe0P.5Scf=A)5_J4eK_>TJM,=XRVg7\4?<;_F:gXV(UJ4bA3
T.WJUXDe-T@[/W(SX;Lg&NVFU^)I<;RI-WC-Gd(Mg@WFS/>YSaFR,V?1eYJ,CM/?
7@aEV:G;2KYHHg,ZXQeZX,=FQ<L.YUD3AJX,&b.;Ob/<^;,@V.F.f>M+2c_YAeg)
TQ+<:\W7KEg[,7QSDHM+YJ-J#dMb,:>XBM09L.KDa?D\R_-X:Z0Yd8G=^=X+2YWL
?ba\&_>Vf3I=NQ[dg,2TIWb^@?THZ\S>:B>N^^\DH@R^7E?J9X.FgIeb&3^\?XOX
GM]TVFa)GJZKB=>c.S4T/=+M7f&;;;:AUV\.E;E>0+)/O,X[V[MXcJFBf;+(+L^(
&;77Geea)/-U>-J=bR><[H7ePI8US#QgK.U=5KCCSA;0Y(#L:7OS)IbJ44M\KH7T
)V+2OI:^6[;UF?HKJY),T,X(@,]V:+@S_UO076]OGbD+]Xddg-UAddK9^+@B,.\S
SZVPR4]?Q+AZNZE&V//OF<J(&O@>B)5[)5_f@9b^7b=3f1H@W4J&B.8U@EZU<TGg
:fLI0+CRa[aB&RPTU8Q^@PeYcNEb?a#,cAD-c^,R8]d-#eLK9LgB7W2L(LLYAG+M
.G@dgg)I=G-+>A8@VNbbgbC5\1WfGN&QY]fH&6a>.VL6F^-F.I.GTQ(6@F#E/;6H
#\\cWLAIR#QTFGKUQ,>P0]J8C@#ORQVU_@A_#?JRELA#PYG#=)P7__WZe._<&\/M
c?]5fBPb@ME)&>cCaMbJ5@EEXQ_:XCUB-1a]B0#ONHfVMD/^7&#c37;WRSgQeCM,
].AYg0HE<4KdL^;4&_;,C]WQC;D&]DF);H./5FcE(/=MD[_MWE58-0db_UK(B7)R
B:SHFD;KWH,]#T)?@25DVQ2[BgB;>bWN@EYI,bWg/SaBTI.TDC7fD4^;f4MYZ1?)
-[f>2c#Wc=::UPS@-+TSYP,69[P-NVd:8C&NX[[P=NU0M^5bcCEe\d:8QJ2T]C[R
O6G::ZJ4X_TJUP9J+?K90KB9B.\B,a<2U)MW]?K3bbJG&/_ILP?VAcdT6b)XXgb9
I]g/^5g_V?\#][Z:VI#E[F[=g[X;LTY+^_JYY@GNJZVSJZ;Pa]AA#&CMR0\I6A3>
U0.Y&FMM=T^0H[eXQfGG@9127T4b(:^/;PG/I?bJ7F=/43?7&H/2VQB<=0L446PM
,dBKX#2<[BV</JeV;g-Yb.(DA>QcZ[1=^]c08-7UOBYP3,BXAGDQURLR<UT3c=,U
F.)BA#[c?OK<:5CR-5c^VD;4?S22XR)TdKK][]5A[D=@1),G/3+1G0/SU:LC#3XZ
V43Yg\XHJ=01<\A>3/S+_RA/7/9ZBTV2Q[ZH;-^I8N5FWNC8+M)F&V7-gZI:>8f;
PPJfIR\0\e312^TLA+VG6+N+E-^HZF.fU]5Q@2Tdb4Yb]_FECU\(Z5d2/R(_?Nb3
1H2ESG&QYW^e0gf7fCQ,ZR=Zc:E;@bf[KX.=3U/.O+gD^W.[CG-97>.L3ZI[13N2
_2HE(C<U3FJJ]dB8J87cJ&,&TTaD@E>dT8)YbU\])O<KR:\b4,0XdbAB;3D>2Y.9
RTH5W0N4;GZfO8C[QSAM<F35#LbI6_JDJIU,Lg</6#N.H<:YG9+<666P;K1>T(#U
FMcQ@7.NE^L<0;6f>dd&MIc5CKdQ+C+J3^c>A?4;\5a+0(UaP3S5Y^7Pf>MW)S.e
OKb\:aZV,gD(CF2bD[\O._<W\UYad;GG(IR(E6#&V,SL@K=_NXK^/)6R.WLB[[D7
D<8TF3/(fPZ[#(>RYRJ,><GeF11W7+6?^/LU:KZ&P,5(DV1AGC0X=0R=U/J^.7.H
Z)CbAdU1P:.&^CV0P]V6a4<_Y[4/(8V2E7&K\&BgA;UNDSF<TeSH)aQ>>\f&Q@,1
[a@P:#_V.QX.[Q;+9F)+RG4Q.#,-,)EM<<D:EOVS:\U,+F/B2>..;EY54bg6J9GP
+0A[Zd7f<Y/5NK[Ye3ae]MT?+JMAI)4]@^&d]<a3A,#Yeaf><M(DK&Ig:NNP2BDC
93Y=HF^;fFW?&357QFec9?T=cPT>J0[H-VL16^VM]]d1[\ZT@GL6^1\YCX[bd4(c
0(X:4[E&GX.YE>eLU]@5<RBcV5fCEd@(NcB&6#S5;KRGK>ZKWC^>9fYT.RLA@\Gf
1RV[BHF<\ecT0@K3?L]JXb0]0YWE4SWP80HOF4C^JCH]HO)-RbLQcTEJGLEPHdP>
PQf0:+6K8YMC:9g?gKW\8>?(58UJR;.;QdELQ,7e4@b2gOb:#QA/L64)aY>6,0^6
1S49d+LB07@a[3eBNg@2_<]^9=e+6WOX#gT];M3LfBe5+g;JYbC>D(Ye#L?/?W+3
7_:^3)2L0-K&-0GEEEBOI._B[b2X[^<>&\AY_Y3,Gf7UNX,>Eb,YA6W&2U61#cUa
MU:Tc2=Ae,.Df>@b\+0N]ME)\b9;dNLBLY3HG8RS7/PQa&T-L_T;BSX#WT?IWM-U
SVUW5J\f)(J>^T<+1-,W/?XHb9@1BdBAEfL)8O&YEO-2LGDTVIPGRKOLA.[GS.4b
-.6R)O0W3;]AMaSD07EW->(8eI_I]P0K:0?_(,O^V+_R:4_2QD;3VHd^[RH1J5H?
9HTB\G>F@?Q>C=3+.1;B1/LU2LE5AUNOG0Lc@CMFKKE[DT7ZL&1,T:RcLAI\=IIg
60;V7T:3b_MCM(>R@J5Y@5&WP:X\[[@fc1?_6ULgY);AN@&&IMN>4654AK67HaJ?
\b/ETF)DYd3W&b]VM#ETdQ+X3F3FAVI?+E5Yce6=#\K@ZELJD?_Z+3<])35YCPDY
c5U\=/b-f,7YPC//D&)e&2U>5?W_/4RR]5[I09XXB+11^]+W\\fEeUba[U4?UNe<
85FS_Z?R63?d#LT:]6egY74a^UdNM)MWPd=07&e](2]77FDa,L.T@ENE^E]c_d@]
FZO(f9T&UTK0-LOBb/G8eWR/<;NS<Y&(_]T;aEJPJKZ._[e<([.&&.J5[Mg4J:EZ
2EU@6F&,D-AcOUW;R?>U^DDXE[.-M:ga#?K5^9=c=0;G\:.fVO5#6@/d&0E)bXT8
B=+]DS)RID\78Sb_G4?8L#&/?-=aF9fCHMgAMW[V9N4I@:CSDRbd[U&QHdecS6Z>
:=W<KS8<3YBWHE>:BXB:8EL<bT06d+Q7_0QFY()TSGPM>6ba^8aH6Z=,fX9?X=>@
R(7(DO=K,QY=BMZZDEAUG0ZO@R(9DQD]>=D?cc,S),-fP9I#T5/E\daRS#+F7+S>
3V[XOZ^K/b]@ATR=_Qe&\-RPL\e_ZJXa[G]L<Z.QW=[BgVAPV[206cF=_HZBc=VZ
KA+/Q\b9Sf^e7Y.;AEE.[VI>]1aG.(4XCY@]W,T0C2F#Ge\9G#FgR@/1X6Pf9gb_
U/E=gQfg/NHGPKJ-\AI]MeT+J;3f(KWMI]?cO</U\KY=2CG],@HS(UB<d#[[[/5V
DL12)X]Z:9,)OZY@+eE?cW\^G;dCH?HB-.+N=bFSY=F;_EZA=dXNfY>f[@f<H&RV
9_G;FKR4]WW(XWaGIBH5<R^DN\YG/)(fcO1XGMYI_J9<9R:#?K=Uc5.OSNJB3]N7
+)]bg_dS\=1e@A^D[F<PYH@+I<CK8L>C:H;-37_)\c8bb:=41+KKB7U6@F,c#Z^F
B965@:<W>-Z?2B)S(OX1^QXP=+L;X74I8_/1bK8DGQS8b_X@IQ<?+Cf8XR:0C47-
841E/gJ7e,a>d2B:>H20<1We;&4X827/;<P>B0MO1[E6e6ATS?,60DK=<3[[WAS=
eP,fE^E=MH-&8KP)6dH_#3IZ\6E,>Y&_((O]]+OBeIW7b(+OEH<4](<5W?=K:?6E
0BV:SK2c41:dMIO6D&(30F)G@GK#1X;gHf^Q+Z@DTeU<fL?1<Hc-]^AO@J5f91<V
#/,M0S?G>4R9aIK.<OB,&9>YVM@K<.N2KINQMN9\@d=G]:CC.aA_;QMRC:d><=Oc
,O-S=U:UD5.U+I71X8FeG<+A2]#=A0H6<_A9=GUgTb]_I0:G0]>d-_J_1,e:C),K
/ZY<<L+NfLBFN29f&Ib0\^f:NN:/8(.-Q5D9XNS\9N2)KJ]e_CIPMc2T+/+425BM
g]3)L<[8WFO>ZOVMM?=)5,&H^8fSDAWc[S?(Gg8Y=Kd5HI(@Qe1c11NaQ:-40-d?
I^9R4\Z<A\#We>C-O[fI9>+\(f20R8FKL,WFFSYgM^6T0E=BNd:7=6cc<1CY_>ZI
Se/ALdL2/?.+97#-R/G,RM/S5,]FQ#e?G3+UV6PO_AV9504:\UIc.(F&]TMH<dBJ
SQ85aB4>MD8^gMKF\&[Kc>g6V<H+[+I3;1Q=;+-4D<X[(@+eGdFD3Vf#RNeM0T@L
B?9[dX?4+<]OS:.Q/S:=05VT8_a2?eZ/O=/>@O@ACB.7S=4\PfK3Xd<_^CZM/D-3
Y;e-EWVQ3QAL)ba2/:7FcZUM6;,UOMgE/VfJQbU.W5E;P1M]<,;_J2/K.,+;ZD:.
Y/WB:fXFg9c/BQ(),XZR@2>0/JM/#G5]ETD?T0cV_a_ZV9S;=K>gLCNBW]OUaFL>
fHUI)^,#_6HJc(VbP/QJEQ_I037>O+1X]_Peg140I7G75ac18C4=K8,<D9;]f,^F
1ff2Sd_QYV@;2/DA4C5:aAFA_8fJYD2fEg\b+?c.B>,?[SBYTE2/NgB(RfdUa2P&
\GYBC5f-P#DdGc>-<M,,\Y(07=?g)-A;W=fL&9c8aGCcJQ=\;H1#CQ<\<7<J/HcU
(8Za^Yg,\J^-58\TLE]D[7(@geX0RFQU5I)IG61YIO052YAZQ0KXfPQ@/@G.>E:,
UMDZ=_5g:34-09_7>KK@+P(B&U65&YH:U-;Ga+)OLQ_I=Z2ZEVcg@a(UY^DB&<0_
:Le@O04>0f^VaC8@Q/=\(PXe]PGBZd[dJF#c04]E<9@K(/?AXBU;e/#P=,>F90K6
BNZbH1WX:&OZYYeVV1KKVF,+f-6/\QH8_.c?IaY_^L<bRDH(-[<Z.-eWRgg2B;;L
VX??2)8Y(SG@..]E]0Oa)&9EZd?(^RO>f,f:.D\BEY7eEc<5.Oc>f1)CK:TH4;b5
9Q/KU0b(V<aWJY]A@S6g-@[,GH+\,/F_<(YAU5(=&GW.+b)Ag>M2@6E2;,_eV9cQ
Wd8:5?7H3\^/_[;I&3MN&X[g#d_b&dgCRB9G\RYcZKgMY?K6E@VT;:?62H/I31W,
WBVcaBG2dM<@/5\>@GY228SP_a5[E3<,\0Z.QP\gE;AFcN+K+,K675W)AG,c@\)A
)M.?<[<a5,386fT5?Qe#]R.S^,S<BZf:g,IF-#N+c7@?P.9Ba[GEgB5G>4U06@>L
6?9EDQ1^;5D=U2Y4-&bC)RL>66@bZ]/@S1a^b<[L/gBLA0Y?BeM\N4,)Bf)2V^DO
9\/GXBE#0;Q#^8\7FQ)Vb=Q_I7).5=5g,J2@SP).KYSME6gg^,C\c?MN/g\<KBG1
V272.87T7.0;a3Dg:\CI;+J3e2^:.bbg=-2dY=5?=(:Uf4\PS^(O[-GA5Gd9YLPE
7F=6>?e#:9Q#THU(\SGN#3_;SEXADSE)LdIT-;MGOO;PCF/(Qa=1YOOBe57ZF-Od
-b[Z79PC5/CgT=8UcPaZ+2,&a^YN5C0JL\+YR2bAO61>BUH3R&3Qd/bbL(,8f_JC
FEJ8E3:9K[RaE1HFG/>d;MI(K;?L/UMfITB&A7a5c9gQ/F(\EJ9&>g4\8B6<10W7
f,WBVR?Q)XG+J>Q0L5>H9_Mc]NTB0S(:;-XK8F8AbTQX_>_G;RGWeGb5UQ8E>_fY
7I29bPa1+R<T]\S?PXC.ZTH-I=7,7g[dV^[d>3)+(X>ON)\(bFeGA&#85bWPK3e0
fd-6GPJf;=OQKGXJ_U_4/0&4aX6d/-Ug-WdLK#X__XdIG]RdM;XgZ9;6L01dF59d
HX(#N<A:O9?-e^+9OYfZ2-3b3A35#dE@[(X;4DR/d1+^c+.3&;,PWCTc]c3&?B2J
BeAfLPU.d5Xe8,HaE0<HQ&GP:^a++9HO5a+JR^?6/FV_@&=)gfG95QPGZdJK]fFV
=<4DB^CH[Ra<-1a]M[fS&?IE@=ZVb/^bE86AI0f3EK,XITX:085c8-_5>3JGbBHJ
Q&)A\T2LY6>g.dXC-<Ud9c1Wb&1Eg;S_QE7?aUZ#=NTdJY+\:2=f10;aX?>?;4KM
ZdJVD08.A^C?<cR6C?\9F2Z;@K]gb>T675-Q_S4R2O2=+:&M7T?@+(M:H8G;AdP#
@=8=ONL]@,],_#Y=/^BEO+HbXcIg===CAOS^_S#<M_DGbdP1Rg17\+TL[TcAV8dQ
OX0bBEdH.-0:9WE;84KW=J;MLbc4K<d]Rd7W:]+9Q8bRBJE05N_MM]FEC@(O8-A7
M><^Q?+:UW+^gg<Ra.-FAd6EB1e+;SI31V&b#bdVU6HQ<aSEXX]:,dA&CQ6GV?)Z
\de&/(/]Wa\&R8#M\(E;&=+J[0[HLB+NW0AYJ96&<#Z(g64]I&AUQ=RaV0W,YTG6
8A=ZC(GE6PBLbE[HUbe#W>c;K:&PRO:33]6gI\^+SZb<EDBdN.^(4).VGc8Uc?KY
=A_3CRP3;J7U8Z1Ug+0eEVRRHKaLe<+3&2J7O&6QD/f0?7#f4(T?Z(=DHVE.4HZU
Q]LB5f@T5b_UA;233:f+#:DM(BSK+cc]J.V/F2HMg(FLE3KH3&#b2YT.TP7\b:5S
dPILR3Nd5Z4&9TAT7c0^(]&#]F\gM<Y4bWc@gXMc:@3ICY(#)gT/S1UDG+B3^.Re
P5NQZW6H>OUP>Pa_/?\909N:Xf,)Y:QV^JPf:gDa6&)VIW(?=;S\UC?B\b3WPJS)
3LcZ-d=0+41@W/9X4.0@4eb1:C1QR+2UKT)cZ43bV@K)7?=(I(;ISDH_JA\gE1P5
1C/27#3)@Y(UNfgSe))E.g:]Y,E/IBPT+4KZSMKJOdNgREDOG#?I?73GHA8W)&V>
d2X)5ACc8<&)-We3,de&[K.7H[;Kc4dL/^#F,.61B;C9/Y3-)SCKL5SQ=7a0>(&[
W7OZ74.cBFL68[bZAP]@LMNAW,-&.d_bOA6#AI3)\STPO=c6HfPG.^Y;O:G<:F9A
d&P/4YK:/5LfUc?eK+fONW@f2UK[SdY70H];U;c<8a4VR8EgLHY4g;_ScPF)/=LE
JU9&+d+>U<QF7DgVQUS)+MX,93J/2)0gK)CCU_K<VbA#K:b<Q\f+#K2>5KIH5]V=
-)@Y3DBMS]M+-V49PfbJG0PQYAOS7c,&]ZN1?OBK+8eX]67>QBR(5I1GD.K#I7/#
CN/;9H?7T??EIX<MESH(58L]GLXR-RNG>VY#DEPJ1NHIZ,Vg.^:@1:9/g8T76BL6
?1;V,,?52+e6\LU/MH.8F_5S/3YQ7A7cE^OW?[K]f9L@P]SLBG0ZHP)_IZ@T>0SL
R6H[;#RD-K06J]YH.9Vd73F<5=Ld\4[(b1ZE/=,JQV0?<fRTW2AYbD[L.&_ZZ3_\
7USCOaZa;T0PYWU,CHK(F/]<=FKgLc:JK(d-NJ#\AJAg.6_3]IFZ\Z3E)aTGOcV5
KX0R9Md(DL0ELA7\UKWU:HgLM7\TDI8_YTK4\3(28K2dAPfdf=UXL+V0YKe8f:e9
SFaU@@[dYY3^>&<GcfXB=Rf]>(TI3[#4Q254bTTbSVY>(gW:V(59Be[4&\^FZ=Ka
&]XLOMP35A-DcWDB1)8IRC\.R;6I@93-_B?#C]N[OAODDc+@5C4eU29Z3+K4g5\2
P#+XHfU^c]T2fL,d(J8?&3[@/-8B[Qb^D;NWGdWGK\GL-WMd8UG.0gI.6#/M5K>)
d95cC,c,b:T9+DE:PA<N?Q:L+(5X3?-=Y#2A-TLHPQH8YcbdQ@PF=DZT=2&,6ZI;
@\a?gVI=T>LI;bP]J>^JPf#)2_Ba6L/U7H@f[/K\.5<[MTCa9V&5a?eV=e]07]U^
0K[BWRae[W+<c>;OdM\I,#f=.6Z7TU^(ANfP7IZXA:L=G&e+=))fLbN&(d5XS8UL
.S[+JaLU;X1-R1df7DL5>_)XSN<5J:a]<[F45.-:N+YF106^Xe)KD3SgZOAU6^6P
];Y&C_Oc.>7>?UO^-/OP>>G3K><IUHfY3AGeEE_fNN<4S1--b(b;A;L:U_[T<Sa.
\:?fD.bg5DIF+1a2J>JT-0CTB&CKQ+GgSI65U^);L=H\a#A/7SYZ98d9c(b]/3IO
E+5U>P&K99H9W(?:,C4Y1,0?.&e_V_.?7eZ6N.P5(&gP/(OZ8fU&4H=)\F?LS=IT
c_gH\@eEJ&XTBaSe2DITI76.,X0fA8HX8P^\@X](=a><0=)B1g8FR3LI0KI0)F[I
(&8bXR0R1F?[Vd;g3WX+e@#I4307@TABbSFbH,T.@8[FIQI2MRabG@5f@OEV6>9>
OXPF.).,4\3^3ede&_3S\N7_UEf#QX7HO;3+9W6DAZWXCd(dR4?Y#cLD1A=,PA,B
7AQ+Z/4,^=?eGMI\S#L0d0Of3T/b(X8H>JARJ=5a6Q)>-KJ9@^O6DCF<?XNT8.b:
@HP+68:Q?N??V.dCH;Y=YWT>_/Rf63#f+&\H\QW5.H8KODDZEVY&6NM9U2,147eg
DGe8_<&C[PE?HGa@1C4=;&b]OA?Ub.a57;(=56T#>M)U\]0fffALNWZ5)YMVA&M7
b;NUR;7^5U=2WHB\e(#KDIZA;VUK,Jb9CK=I6C3eCZ)Y<3^]\CNI?Q8<U,dJ_D#\
bc^M3MG73\4,(WRUN?85W6(LC15A8B\Vc_25>/QI-SXPR@8dTd#:G)=G12f\[A[#
([cJS-8>K9.FHN2.4@Z\+4G0Z0WU,PP+d-Q>;L?568<7@V1f@A4JI2[ZdY(fBI?Z
(f2)>64aRV:H.fQcAT6KB)LR/XaWIPXa4HCU,[\8XJe(3LMJDEb/R1C<J(<4V9G(
T/.I:dO^16T4TGP0X:O02dCAC(?T,B.>[40c<1A>^4()[Z2MNCb#1^)S]L&ROR-c
RJUQ;22/,g4QWI\2Z.6e<E[:RVbMO#\QNMOQ]/C9S25FKHFR4Ig08LPPf2)Z@46,
(D&Vf;cG>?UXa.Kd[1UD?]&1#g2CWKaC-(R/1T@L-LC=+D#42?HEVbG&KV>:8#AP
R).[ZSU.AU#\+=<PHc^9T,eBOD[?9X[88V6Z)U-7WGH1[WLGE5[[<A68g\FC93G)
bSUY@;Fb99\Q2/(0[R#/L,dZC6L2I&\Od<@0==0Cef#E#gHHLdL-@1e9+fR5]8;-
BbK2N9f][acUf&VDg7[\:5fd8=T22/&+>.@<=I.I;X<A@(]QL<IDTUEfC&0RUZ<e
e.acZOZ,Ne0WHDV@)/YGg3JgL]PJaJ4aO@5530KZbW_KH,W\\bUIJFE#;U42U&G&
=.P9#\D@DT@&b&f\1OMPM)\^XSR&]\fdX?.bMV&V>RY9=/09)#c<NK5(2bfdVA&Y
KE.O@;UA10cb@Q9Be;<fd,d&JS<.bO3=OI4P5>XSZWHG+#.GC,P?;8K1,J?>f12g
b.eBM^1>Pc0W5#JA<C:8ZaJ92PF5>S);S?feg[eZ#8B0^,G-Nf65g9-S4UKg.PCb
B@O34MTIfIX30RB@,ecXHHEZgJaGV-<(8DW_4K6N224LPW3V376\]>4:2D>A]Pd(
TCNMUDQY1;f+DY-)3F=^>]&@0_K2Q7d(YH=2c/7-[QD&K7Qc2M6Qd><^0:5UTUPN
abRgc_C0J#X@26K9P3,D7OZ65Ze&a<]T[V<]9L([5fc@>\6/COSWNaA3,9Rc;@f#
UBC8T:@N4=Z,F-HLP:E#_?&=&f#B;J^=f@K+];N:36@E3IIK1E0=RJ#Y-T5Y<:7W
TDf)d_?QE1Z_@FMa#V(gO1P2?ILXa.@;KH?J#8>/;(Ag=_-dIX4+ONfA=@EC]Q8>
/f7e/15O48^bXI_+-2O)OHUb>\2Zd&d\G&]&:4II(PO8)=548A6L.AfQEOd?-B.4
=&5beb8Mc@dR83\?-NKU]Ma9G<QAe8+L=f]6;:OI]K8b?F_:=N6d;,>g0V1O-#[L
J0?914C-\[7W/VQIQ0b;B,_18UI1S.XYZKK^0C3b)@)O4N^G\U\6Zc?U(=E]H[W<
,If;,[0=;+XFeS/\Je-Hd-N#LAB^7Nf1+3]]K(Yf\84,<(fCLEZ7<7UH_>HYLV:-
TaC-g?[CF9:B.>D-2SL)K_CYIW-[A_fL<6#e/8f)T<(SB_GU_1O([.5M6/TcOVAV
9S,_4<<g:(g2X&:(FbMb5:)1PT]g:KX1]M6H6E#-C7:;bL8\EH^-LJ:Z19>^EX,V
Q6?@9b).UYUZES8:g[ZB7A;0JPB<-fXS33FZM)JK>2&-[9B\=@T#)<]/B9.H?I55
JZQMcbYOM:@H44g-dXV7F;^P9+bf/4^c;DeC.@AYeY_WA))53,Pa.bHd)4;M;D5G
(TT3,1XO0X)ST17TV01-RbXWV3+-J427<QQL0;IgfBUZ0S]5c95N\Rf>b;4Z:]>O
gaU_->73cQTM3,1Y8eUXF@7PG+34-@8g8aD:dQZQeU510X3,/4P4M^(fA&CVeP5P
X,:HHV+TW9TPJV4B:ROD]6K(^c:?V.FVXEQER<]F#WPMGKPf=BSfF=YcL_4G:I?-
2]\U2:e5c90_INQba==VU-M=G;K(OH<AAP)=0_:2HU=W?\>.UCJ_a/)J#G#OD7g@
MfA\3gS,/gW9J-Z(O7&39MF2RR@3N97(G584-?:41I#PdXQcF:D6K?XT&^OFE;(]
[J@)Q5AN@2[?=AOW+(>cDY5IW1Z>M]<78[E42Nd\&.7]_;BO0(/e]OBZdSD:7QfR
JQ@+Tb#<G#>g&#Q?P3XSM01D8+BE98g0O#],W#;-cN_B&HS\(H1XG>M117;3?gG(
5V7WKg[8J>RGeLfa(acT4f87f<DDNA[L5,PU6]XGR274P(XXMFB;._GY^[=CE>[X
HHJ(X><+[WdVRMWe5&;P9f&Y&;8XS3S-eH58,G4)a&[P7aS](7\97S^?0[K7)Cfc
Qf)X9K)4IZQ=#,H]BG.L]TKBAaC6\CCS05C19H;4+::C?0&06\,7DWG&1bA)bJ7T
F8Je,K4c7R<@:bMe=WCRM&IUeW/:O\Wa?)AFTFS?c5>e3Ec6HR:+\30e^I+cEeC,
A5IV28ZPS=6=_0ZRHKALZ#-[TPD>BYYY4RNg^:<:ITbSdGBO]?DG25][U(GH+/U,
KZ34cI,>_6<BC(F1_C\15g6[<L7=-DR573WJZ7+YEbZQ0^RH_f0@LW-KTg);J800
eNf8\:T+FQ#&CP#/6fS\.[:JAQfT;8]J+L:<M#?^N9]d_M4AGc<BK1TCT:8_>T(_
&aX^=M8^0JG[&F+JZSOCbN(UU&WZ:YB(<^6b8B7?Cba+>\31=<abRLC.^P?0e]Y0
HK&041JWb#0/Y.]1bL&7G,](MS_R8AW2E2KfG[<XM@AAS9=EIX,A9Md(b1[L>]J_
aP>?@J<bHPD7M5\X2,9M45gNf.(TSLLTF/b?2P3Y#>33Se=TFF7-;VcbHY,ER#&F
J=@L]BD&3W58<DA.9ESdKgJT<ZR)T6X&A.Pe^ZW,2@8ULX#;-6fIG9-I>K9:WRYf
F:=VG1@:(H][aFFMB41?)K[Z+Z+7FKREMee>=BLZcQDF_1@,5^I#ZgWa(aI)QdK^
J(aPac4UWN>I#dP,Z1D5+WV-Zdd#d[6@8eX30(ME9caJ-,X1;RcMGQNFH<WQ@+f0
bfCLaX.GP)@3/\@fIB\MH^H?G2a2[:2W5C_S]e63A2H75GRaV_gG@UYT9173_#Bc
AYL#aM+\F\POE<X+W92?a_\U?0RM>.E+AJ>X,4BJc8W&#8XdZb;^.3N55W\ffJ=-
5@9C+d9D3/H@@V-1W@N^J97Fd0dPB#1V1DRbRN-c>P3YKVGSdCO9@0E[0QMX:BD@
g+9W=K-:V[U7a_IE5SSTYFOfd]S.,cFYZO@dJ)F215;PO/Y2AMS]Z_^@E??:J(Ae
4,KMM]R6CO^c;J7d12O8&-7UFWWDfSd?5RW7[a-4a<X=\OJSC37a1BNJ\&6<JQGQ
L@5e7LH.D=\[a<,&4O/9X9gHN<PPW7:3TA/d>(J(15(I<(;^+E.489V/._YPD/R7
D;0I.06C\^L7\CWM>\BIHW&(GJ(_OKTPb?OQM6-]d3&PO-7:&FcP)&-TC3R8(SW_
6aZ]F>>;BIHEAg+,)e;25f(6Aa-ZDF[W]=L0\87GXNHbWc4(?KSc[H?;A]CF<A\O
W_CLeGF[c?\00TF3TS-E@CeB30_K(,1f7&2Y3S?;8PKIaFdL1(IEga(-XNFIVC5Y
\=[bZLdETJ/<HCGRSQJV5JbLPUCO&L<#2E=YM#d9Z)ER;DJ4XSVN^9FK\a.1=f_0
;?;OX2<N2\1IV=I#Z,03:4Y/5H80@#[1dNWE?M-1/F?CZS):LS9C=gd&WAWe)a3W
)NT,?S=>8&dH)\ORg]#fOb_9D3MY9YCagXY@Z7YHJWIA9F,VH,:NU,=8MVSI;a1,
M4W2ZME2M_C#/9+4<MT(F]eO--?;7S1:G^M1LQbW=FbcPY55Y?:Z6fD=02[Kg&G8
,=VQ91(:b[4C8@^<C45fbB-f>G;-12Z(e@c6]<(<C(b6(1V^GKfN]5ZYD/(^8YX5
.A[AC1A-)\Fe3Y4Y_0A0BCKg=a>>X6;P-VJ&JXSQ@;OIX9F=J?6@-K5H7AV3K4ga
6ZZDdGU6\?<8]>f2PDFBBd(K-fE@1/JeO_]B,W1YZ^H><g4M).gZ&[9-+O2U<:b<
51@a+V8?=R-&BPW-)-/GA/25DC\d)[3ETafPU0H6LWGX=MV5@(5\\8&E(=3T=G1;
O>dTD<Rd:\=GTU<faH8O2=D]eK[QJ;&=R(A+[M6;>4DJZWQ0S,J2/9\e3+e@fc3A
?ab/g20R8:KcWac/&T;4a+96ECL;f6bB_\SA5SXWc=<?,Ja@IRI[JS-^8?Fa3.FT
U[4U.VJUb2VdW7:HHdKD<-0I^@eAKC,\1UfNa.C4SfO2e46MT_>-7CH.,KV6G,]0
gS_]>5L<=0b>,6QRYA(egeaM:G/R53/+FYc1,L6=gQ;OS864K.;COeFOH<MAT6Y:
2(XSJ:]8^O.T7NCXAcPK#_/F(#V+RJ/R).Z[)A4U@\J>,KPBI,U46VP@5Q=#MJ&_
MW[046SD@PFY+8)FEgAXc)#-[NG+a&a.KX?8CR3g[K^VRfI@[1C9:4?bUGLEc@RN
1D2G#?f28P0<d:Q-PgBFPEQg&\6)Ud&SeAQa[E?B4=ZfZIO2RKB-J1K+3BH.)D05
4=(c982_H?dP7:=#W]RF\4S@@-W2A=;VTX<_[ZgOMSJX]>B7OGc8fVSMA,,V0J&P
LX+LLF(HG96TLd-Q;c]#1ID9dRSW1aMJHK0>N=PC(cU7>I_\PX1FFF^BCAcZQdC7
H;ET0DgQ@?_Jf.8.2F[CSAN14F2>FUL-)#_4O6PGQ/EJBU]>P\&6>(g93>]/C7.Q
c@fD>I=BMZQC>f0g1B<M&d.T-4#=JS;6RXYWLL#ZEO1c#R[)X]I?eeX)M#L^MS;M
FFdQ\OX-B+DN^20S>:S8]/,F<UU5O16W(.e<c[gJIf;9?J::J4ZI@HNHK6-L9BG9
]aGUB;N_5F+E0Tebc=803Cc@_eZffbE4P=P-bTfFM/SbNXIXFLD_e\V+,]/0A7Qd
T)C<<N;ZDW<Q:UA#f/Pc77cPbYU#b^Q\J6gUO-]=6<]#-_ZE@;XJ3C_d_EOgD6O,
;EULKLfG6K3e3JZ<Id#.GPeK;XQU&@#0X/A]A^ZW7<(#5<.G8WPdXMQGSEZ(96]e
PgSf_-)FFUGIL0a8g+0>Ab)eV7GJ:9]X/992Q(1bMV?dd.MD2#aD-_fM>a6PfRHb
D/cRD0E0O)ddUJ,B6[><Q3;()&/:2@FEaW)R/PI-3.6HPI5IdP-:.d:?))adQfEU
8aXCNH^8A(D:0IGU=I.B>;OOAbegHWf][-98PWgK6g[d;;AA\-AZH1a;FBH0V_7f
)=H;D5VY^C7TBFXL^7<V:?9--&R.8-KPd5.[AAG.Y,^ffQHT6&>ELJRSQXgB;(eC
0=5DWKb]2g[__XG6f/Q\OX-R_FfKUKFCV6OSC\KUL#TBWY?Y<[HUVJ/9&G[SXAQC
Le7\X1FW3-T7]a91,4a:N7V)d)P20g5;Q,b<:@;f<0]Qf2KNd?=gbWd(QQ3EA8\>
-)-.R&FD(eU18M2H_R4K-:QC_4Z6#:d,>YZC#03W?Y>I@T>#b21XR+HF#QWCA9T.
,2Bd93\1bg>,9X<22^M4X+>@MP6^LBP3F5S&/dF)F(39fa#7c44&716W/6RBYT-N
05+FL;,(f?2S8WRL.1>c&BZS@9VNLY(?H&=bQ2[,?J@UHaIa5XPN=YLRCLMaXcZb
;)\=B^TPJZ98a>S?R?/=<7;a&6+dJggCRXA3fK\\F6VcIR_JM5.BYJ5G=1a_6Y4g
a@7U4J(&0B;,9<ce>42bD;Tf)-TU_PGbgH1EG0;?WY+_aAY9AdCTXg0QJ+/?-8#.
TfF16b:a7<-;aEB:LP(Gd5E]ZU2]TG1NJd\aHg\COg6+ca1JbeeJaI_OER:eOg@&
#U^12[9_=K[HPKKBU6TR8^&2;21(_-_6f]S8WafST\1Ed/):d6X;APEX@f?L[&XL
OLAX;&c46cJPXT\1FB2[Wf7=QZSP[gQTAS+Vd4BPP+bJ06JV_@eK<f6)G\@]+J9L
50(BYX3B&_\:,3dP.B[1P04<8:F4:(;e1d65B2WX.:^=Da@&Eb0Y:RTPHX@A+CL\
L3BJ5W]M<9+Lf\NHE,VB7bP52G7I^([fQTUgDU?X>VSQb:;W;<JHI9[P1ML+5F-6
,)b1@GG<E[U>T=W8BUK14W]K:HF27[13M7aB[.:65C6:H&Hb6,J@2547#XS&B.\D
6bbC8-VWYS3+O/<K0.5JEQL,^)Y7BG9<QOER[5[OB6CY4&2MD.>4[eB+;VM@=@d6
W,J;d78A;Ga1@O^eN8<F[8.>I;XSFDR-8#AC&U7-=e=F3W\4+/@.K97d-:d#<952
:YG+W.ITaeY#(1>,a(7-O4<YX;N8Qe_/6#LE])Z(P334;>T<2.3;UKSg_)@R;M/e
e:c8.6)B=/(8L.IF#X6HdKK<S21YH;\K&Cg-LNH_+be^.3#?(#M7@be95BKFAJ]8
<8Q8,@MI:82?Z277KSXd48\G7383YQWGNe=:ANBD=d.0dVQAd]V]R;TVYeJ1J[5X
5Xa0F_d<bG8XRQ7#JWF=:RcTN9C):23HDA])E\V@42MZTbd]<[HC>CZL-V&N9V;?
d/8g/8DUSY__)+M9SMZa:_Y[)Y=:g&&8A?Sa\fN@6]c8;:@38U8]X1RRA>=L(.S8
SRf1=d4T>H@A.1,8&LZJ<Z1#.>WIBYEOfc&aK)G#<Cb;b.1N9V+LbW4V)OD2Og.[
:2[M-#AO(&[VAf0-9#A3\)6V:+.G6/-N2.IGU]HE)d:^La/>R6[#R6c:-b<:5ATX
;#,&SGM@.:bU-OUSO[P;TdEU23E&\>4YVTAF;#(N6UdHScf@26Qd8feJDHB3.MIF
0>1+f]8)8]ZI)OM.f^\S6c<UP./ZCL<SVgX>^-b<BbIVbfF)02-[1HQ<aT/UG;S@
#?c)C=F5H3<K9AM.4gQOG3]FL2fIbY4aD:GK/V20]I>dSV)VYAQe..MG2?1[:gJO
f9J3WIEQfCEgGEKgbeeN4g;BfRD,7T?A#(eEH,bXH\Y?V_)0Y&M=[^OeWDKZ/RW5
JED_HDDgDA4??ZB8\&77+[)^C#PRA\/D)]O5b[C46#eDHg^#7CDb@R<+eR_8W+1N
Q@baZKg#_4NTE[HE39W@[g2<:UFSWEO2IH+8f)=-<#XMA#TP[EN-M#<(^I[-8e30
GTJMGe;\QBKK[,/RM2bS.RA37,S7,MTC#&#,#9#EN:F<)WNWS?#7WA8KWC.L2CHL
2fHM5N/-??/>LcP.C/bZPPL-8?_G]6RC/)+6bID4^+,SHfHZQ)BbDbUX(ac;c=@e
NS9?)/g@PdV,P..)GO[eP\4IFUP9:<ZH&/?YYG4&9U6#NH#bg<PUPTO.FHKDE9&f
;J_cedA]P]S>CFMLU9QY[IDf,38GWU&P\8QDb#<HRAF(6bM.R[Z@IUY2c++P8Zcd
47TD-N\UJgB8P]Y#EL0XX8Gb]062G=cWDEC^13B[B8VPeHAR5+.<-2:b=H^QCZ2^
\]Q#<75EE_+Fa,-=@_/cSeg3]6XNR#LE9/J&gN3420S81J0aV(3<D6>NB/RRPNg@
bNHAW/gaUQY>R&g>g3fQ9X6e4e@Ic3);1;98RAZT/5-0#3#c0e_G0@27/5QL@7X<
E@8UM@FQNHWg>E)WKGPNeSe66:@Z9>SQD\Eefc5/>.gBTLEA8F3+\c<9ODY:,eK\
FT[+U:Pc6cB]3aJ1&aB?KA2G>EgWBe)<,X+K#;bFc@LVfV.PYZFP]\T?9bW]HfI=
7[:)RLS5.<eW:;Q)#fO:@=.BWc84E1M^B997McP):(T:@]EaXD_-68A8Q.5U61U8
BXHK6cO5^/,.&VX/g:8UeAHA#bg6DOb\GQFQ;3DWd_E@D4d]E\7I,5L[7/1e>IDL
7D8<:]<4QTDDS.GI=DAB>Ld?(fXX:T^/R92^]?FOB]1\>eZ/.^RdB:3E_6FTV3DI
M^aW)]=&WIA7YA6Edfb3X17ODVV#e-)Yc8=WR/,c4a]VFD/YNNE];4Te+3?1WV0;
@\Z.9Ob0:^YAZA\=7?\\T/<QfYNPU^QH1EV.[87a[2&dY.@?D?L(Q)2+CP.4,/K?
3N6;3H]&Z@M>+8T21/P5YF=2]M)M0/B\4S3K7b_PIMa(P=FZQJ>5]^@1Oc^4D]2M
VC.XIN7e\3Wa(P@LgfH(8T3W5@=NbbH0bP6^9-&P@MWQAT+O+D#V2;P.1S#H]g@2
=EP>+@FBCSKf3;CG\9LITF&O5FbMJPgQ]?\b96OAgJ2cE,F>WYHC,WP,^3Kg;5OD
@W]d.U;Gb,<18\K?c<=WAF9f7M0eZK9IaZ:67fU@1:<RWSDETA<Z.<IFX)_^]2TH
VW#,e/:OTIYB6aN<7c[6,?\MAE4O(@MaRADN:?>[,E_83D;W(,?gQ,/N_\Eb,6a2
:@)&Y.J_./4V&J.f?MYI0/fIaN0(A2Xfa.d4V/;XP700H.3(A@H/ATg+AYA&gfO2
H+RH](\P/M-,N2baH0V_X=OcEA;Ad?R>XDHJ,gX/d<)1JC1__cA9YO]1CXWF?_W^
V8Ta3W75:d@]G(NH&;[(7-&I6cN9[gWcDUEHZ-Ze)LbHcGIV/CA@/N06+SXP0JaJ
f[g]IUE+0Zc=S\NJ;89\c))N/[W8_]F)[&5=_H7c1/cWN)U=aURLL]S[cF@J3<KN
5A]7d92HOSSd@U&/S85R2BBC,U3U,06)USPO(3@d6g8/&/4E[dE&LQ,:)GS9@bfE
Jbg9EEO@0+:a4V)bU<eXdaa?7M2-[@IX&L&3A.ac>A)/C$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_WINBOND_TOP_REGISTER_SV

