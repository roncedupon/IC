
`ifndef GUARD_SVT_SPI_FLASH_MICRON_NONVOLATILE_CONFIGURATION_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_MICRON_NONVOLATILE_CONFIGURATION_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP 'top level' status class.
 */
class svt_spi_flash_micron_nonvolatile_configuration_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  bit [7:0] dummy_cycles = 8'h0;

  bit [7:0] xip_mode = 8'hFF;

  bit [7:0] output_driver_strength = 8'hFF;

  bit enable_dtr_protocol_n = 1'b1;

  bit reset_hold_enable = 1'b1;

  bit quad_protocol = 1'b1;

  bit dual_protocol = 1'b1;

  bit address_segment = 1'b1;

  bit address_bytes = 1'b1;

  bit [7:0] wrap_mode_reg = 8'hFF;

  bit[7:0] io_mode = 8'hFF;
  
  bit [15:0] register_value; 

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
  `svt_vmm_data_new(svt_spi_flash_micron_nonvolatile_configuration_register)
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
  extern function new(string name = "svt_spi_flash_micron_nonvolatile_configuration_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_micron_nonvolatile_configuration_register)
  `svt_data_member_end(svt_spi_flash_micron_nonvolatile_configuration_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_micron_nonvolatile_configuration_register.
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

  extern virtual function bit [15:0] get_register_value(int addr=0);
  extern virtual function void set_register_value( bit [15:0] reg_val=16'h0, int addr=0 );
  extern virtual function void set_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_flash_micron_nonvolatile_configuration_register)
  `vmm_class_factory(svt_spi_flash_micron_nonvolatile_configuration_register)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
FPYT2,E@G\ZbBNXG@W__X_E4-S[V]NUE@/8bH1c8M8-,GCCVO&G1.)OfOa=\^W59
;8U39X4=ABJ4C:H/F2R;JXWAd>DE7DGe0/X@JM7[\Ad:&b1.NBLAJJ;7+4ZGZ/Y8
b1eUf@&;-Q(]MF\CQ?U.^(&=G_KA(RA3g/Ya0O6-2S<I#;^-FMQ4=N6?O=bJKd4#
4Z0dFWZB2ZR4H@EH,>][B]3F2M99NOf8JaaacS.>DA+A9gL8EO@<+U^,c3P.6Rg0
#<d-,b\Q272WcMG^M)D\K<58]gQ>V22(9JJeQ6]AA.L@Y-Z#bSWT@]GcFFd1<>\S
ZaV/=7HD,E_KT&9NM@c7B#K>69.AY695Tc7WB/)VZA4&f5=+U@3+P7K,#gHeY7L<
.&7FJQLH(F)UH>0VAX0Q5E[=BPGNX&[H_aBX9X1AF6DNbV,8+(D&/S#RPQ/K>K?W
f>D]I<8N.:D[=+:BUBOSZB_-ZC+fHQF<NK;W\(T)C@1G,.D+SN<Q9)1Q3I^fe1(6
AN>_NVZ;>>:c96-+_P.f3:CUaH^W,YLI1_Y8JBL2?MBf]F40O[7[bHUO86+\+5O[
H:LW_I0;LdH\CWH)BC;gD-c9OZa9[NbLZ[8N\,O3L1OLYF)KEe3.M5a_Oc@W>M)B
C2fBgEYeC)40/BOU+:VVWWCXK\?]KWe/Z5OB,62)V:.]W;(9D76Gg48-RcOU/^^5
1b9^\H[db^bPg7B3f^=XL]c?gJGHWZfb<bJA2HU2U7].ZV4V\40@OBS43)^V.fIE
G<=,b/AH0L1:8=gbRA;cJVPF/<b>WWP[CJ4_c<aSH)K@NG_8L9c?[ZWBX9I4@473
W8,@G&g\eO53S40-QC;-J)FARC7=c::@3?)\51EN:_]39ME6Xe;fR&]/88;/gAC0
/(=0;7dN1)F4A<=f64EF6Yc[IGG?Y3+bHfWMf1I_#FAQZMN33NK/3G@5A-/6,>&E
CRAc76ZV>c#55?E9?3741Pe8GAX<ER;M&<^f/XFG\AJ0Z)+MJ+.]A5\PT@.>T=f+
9ZWgST,W1c3<&E=&(B\EF8;LKO,B3>T)8VR<;:@YOHSEMHdH#,.P7K3IHgVPJcH3
T#@R;cJ)[5+H1_I@0bbVT5]McY:^P+1L:$
`endprotected

   
//vcs_vip_protect
`protected
=)))?S<@8G<)@gUcR6da/>GN/>fO3L?6\J8L??(WaOVVVM+;C0Be.(O:M=]6B62U
B?5:GB@.4b#fLbIFJ#f970Z4\A-^I5WU4EJLZ9O1>FcbVL(<J-X[SfT)Xf#;]CL>
[].1f3.LRJ7=G,7F-EaWV=JCF<B\WeDW4:QMK+TfYXJP3<fM+O?\ffb(>H^f0&L9
g_b=FCb6#^Q^VJ4/?H,;Q@??G<G-U9-,5.0VR6)>Z[T1f.#A0,.S=NSF#\Ra2N/U
I^/]6AA6H6OeSBGd:,4/K14#RJ0a^TTF&[G2,/^cV1/.Z2KAX[\a/,X4J/<X0g+=
WA.X#F^f26RGfN9Mc4XZeUJ)3>]=TA+?(I@/W69+6OcF=8[(;b?Z4I?10NNA4Ya1
^&#[I8AU/.4a0+E,@HN.:dE)46WXPWIbcZC:K1cV)M]H0OC<@7&BQMZ/\:;_=N<F
#+K@#WQYGJ:&@=D/NJa;:DN]>SY2U\d)_)&B2RE:?9bUD\<ZYB)HeV/e+=FTZ16_
N=&;&eFKc(Y)0X6\88.6H+1^gU;e7;HZ?e7/\[--S^EgAQ.S9;1Y[?,D?<cZJ>9]
6V+=)9P_FI[bcW/=5DK[ddZGGSE;.92L/S()a@U9#fI#T&PbM-FXVS1,H<+fgBY+
&==QAee\da>.HW)TMFMg-^YdF<BW.9b\3[b^:TKJYSHJIK?A;XWCEN-.bV\SB@IK
ePF&,D^(Y8X=V:]dGYA.@2KAI]A<:Ifb4_3f)Y(1@)&,7LCOG#O&Q#G&Pa+>,U+V
@;^DMc2XCfH#8;TDJ+/R>O:FGZd\P7dXHcgM[)8N:<T:0RPA6-6=,EARO[bY(Ld=
ICCS1U.;5UKB1&98dAA-7XQcI5^U::9N\@XbWWcbcI7C.]8(HKIK/I&D4Z=5NUQ0
3<&W?_KU/ST=03LOOg1E(Z2S<YTD?b[RA9TGGB0@R=f?P[S+afUg+G<LSU2WPN,/
4)8Yc->&@PU<LIA=,=[P^YgfT1LdZU?/4bW+AI_ZU+,O9I5Jg.ZGG.dND^fL#7>O
B92:F->06/Y<1M;g\HC)(RC/[d>Q&e^>?&]KO?,f-L&@-:cL/C84GG=MW-c:aL.-
<9<0(L1BUa+<LNc/XM.M#]AW-TTBOaQeH.DRf47)SVT,RGL>&cD4\Y1^K]1bK+b-
\/eSJ>>/5C,M&1<0EcCNI#B3G^87Z\-Z?=FC)\Ve^S:Kff;-&eBfD.@7436a8];6
GcCI+<.;c0Qb_WAK<5@XGZD]<_IVe^;=Y68Z&^9AH8KPS8K-+^-g_5=,CKW#,JC/
)CF=I.3G3&D3/Y)ca5C4\]A9)#N7O?&A4J><=Je5/+)FX)/d0Z>^/YN_6dU<gXa_
;>F?QOPM&>-Fce,^SO6:CRD#b>FOJWF+U/gS^AK+;,#&ZMU<fZ;I-QH68OSR=&YS
cbHJD?/Z-N__EE+g+@Ae9Mg_Yb--9+>2=^BO>;-/AFd\dB7gB;:2c=dKV;R.NfTE
RM@65/_08-K83R,5U\1Z[?J&d6(U?J1U7,-QA1Sd^&B1F1A6L_NLPT7\&:)+1aXe
dDG:&Z#/eDZ<[^&fR^3c\:ZHP<5/Oc<+^L(abD)P0IQAe&B<EbI<E[5V^1)S3)#e
PKSd72),gXZggD8e6B([@W:3,G29@T/cR,W=]Vb4_IA+J_VT7T&a#CW7\bOM8>(@
-.;BBD7B^@3XA+1YXdaL_Q&fS,7P0_+_2=X>&:E:W^?+)<_.PXC,g90])_C61+RM
d3<F[V6&8_GY=7LF&<>PgGK4DS8R^UXA7(KCfMZR.UM[9cUC:dNSR@(TBT\4A=^W
P]&O0GbgU]QJ#PBY0SR5&2=P[3G,728eE[R?T30agT+-Q@3-.@Dc=-JF+-=0ZcY\
QccF?LF4-0Q5XSUVBaWX5GIV4;Y(.Y?,OFTY.A/6^BFK)_7+>7f^N8[HRYT4FP?S
GKL28#\/QWb;^0:[8(E99>WSKH,+1[#R;&fIE]<SMb?06^+-a^X]g67E=C(Y4OS3
I(>-9<V3RJe=7/^>?.V_g_C<C@0b7K47DH_VSR>0YH2S#??#,:+)+,W\/c\\TD=8
3-H2GP??3F?SS^(Q995a]+8Q5M=N:,A>X3HHPa:BBTAbA8/6AH9/=26C(5/\g-9g
L+b>R?/O0?Y]F-2,,bdP:&HVC#7LOdT?(#aa<e[/,dZGYd/I42\Nda[8BX6J#_\L
T(e\<bc4e-3B(@6L8U:;TN:7XUVWNPFgG14B:Pc@>bdGM:d50479WU(^fZWOIS=F
S,_E<&@94^^5RGeM.CeWDS&YY8D3A3CA2VC\.f(a6;-H:d2O:&9fGF7Qd]#Qb[HS
<FYLee:]9W8+8QJW3LgP?ZJ>8CEYbO:dP2[&>9KLJMBcQLCRfDCgI<&VZg.9O?LQ
gbD]/>,;?G;YbC/-Y/.V)]\M/>5URIKPE2b=^]2+-Z<TZ/V1+98IfZSCZXXUHQJc
<K_EKg;^GT:Ie^:\Y6@;VW4cS/-Y5M,3O(gP,\6X:?TUaBJe;e3#:P)d2XX]GZJO
F^_WQK&9]gGU^TS99\4MC2H]D=e9Y#2>bc5#5_BQ9G,(a3bI8S)+?6?9?K8ZK=5C
7UL7OZ1#:36V[2GD=9PMQ4bIF^/R=8T>(bZQKd>f_:M3D.5Q:(RRIRH[6c1:4PL.
E)6/[\WMIHVW&6?IUegSI,7O_62Gd;KgI#[:cGZQK<7c:L_9D9fONS@?e[E/&OA=
bZVR.=ZRbDda2NYMUST1UId+D>WH(FHLCDbA55,>Re-H6O;LaIGC3&[#=fWg+8JJ
cK1WRbL[6.a-f/B5FdUCgXLZ,^YX=&WG+eGX;O+,K60cK9X6&Vf3bX[;TKT_d#&8
@LEJ6?&P>(LdUC-L4.>a+]=SWT34:H3^P<3Qg/=KF=.#>dbc4_A/Q>U/[cA>(E:&
,cBcP5N=b0aLK1fI@K;0^b;?K44JQ2_+d9aP41P+LA4&g++)+b7DU-]cH9Z-G4/1
A/X[/ASX6Q<9O_>=Ka<\495+2?I1U(^dWZNQR<MG#]L5</:0f#(cUENKCV2GNFX]
BD=^\ZE98=#/<ZVC9bKJ?:#+S>VMaOdJIcC5&\/0TZ=+NOEK+E>>[SR;&GIQH]>F
@Cf\:_>X\Y_,a6QTV4=Jg_QRMI.VO<&5,5@=TOaY5=aJ,EE-XMP_V.)]-&/K\RP;
E[WfU@O4-/8:/(04[aUK[V>,W,,VO.CA;UR6HS-\MRK:a=^R9(4DP?5#YC<IU(GX
ACC9-@;g0?AH9JY]cYf7GGQ\ESQZd6Y]g[S3;L-N=S/[?^4RX<gf\fQLHL\<BTS\
bB28V@KPgbZI4J#=I?G=B\=^N22?PC:I2N+3[/.2+A,^_>Ab@B,R)aM7C,S,,5-W
LUa,UX_^.8R(P@.Q)F[E&aV]b,0VcFT9gFeV(U>.(,ET:-^QZXGDebKI&b^/]aH.
U^+9PJ<W7Pb84T.ANIM#)I]9gGZT3QCP4CT6QWKNa/VM0KY<7-1aM)L3K1_(K\7I
\&D13._;UA0E#W_A,)J8A1OPcF\TK4<?4Uc7WFTMg#_K]EFJS5-/>N_PC.9gYQR[
^(K>dY5^VGEX11,)PJFLONR#5>a[9\K0R)dEd-YX2UC4F[aGWSd13C-.[MPUVdfJ
@1:TBZ,#=H>:V5H(_CHL\,AM7XMeF/T;UQ8]RQ3<e+DEbRWWE<9YAf75:BY.@aV-
N5Y\J<DHX>;Z/=e<U?dDG]8gSIQdJR)b)_AU0]?f4<#A/-[^LJWUWQL&RBWIH[Vf
,(^LL@aKc((e.bU[4US@bdd&5E4;M-PQ@QPM3e5LO=g>f(JFZ9:cAT@/=W32JbBg
1/WDSE+IYec0AY)1.TCKJKec_ebH7O[a9713#b8PIMAB:cLRRC]?;E:LL#b[]:1U
a#UV8V&WY#YH9S1bZ<P(L,Y_RPNC4.O_GdYa\OVaCM;(QJ6(\I;7UTJC@d[\Q6OT
C#U7M5W=?@6<3C<FAcRW?&5eVP-,f,MY=a5IBJ2cFa=LGI;+SfcUCZV>CZT(70SK
,,ZI,8-eaVdS;TM_HH]75Ba]]6c&@M?7b_YSaMK@O98d^9:eb(HH,Z)IR1]>EI2-
ed?dWP\_TR:c&JNO?F+=2C>=_1Y4]HY0:&JZ)[^_J]:e;[>PK/,Q9@4Og\:06MdG
YW(XF(=>Eg-M3[U^5F9,2bY=TX^EbfR6-6Seg9aB,^Q@V3GQIY(c0Z^@M-W55>+_
UO8P=@=7SEeY?O,[721O]5IH<FPA_:@&BTg/8T?5C.fKM9]_b8J4gTQF0B-^RIS7
g8LO6&Z7e)[QO3@PT91]V-/J/W4([Z/a/_C]&1A@HOXe?+bAd;_BC,V_.EedE8K)
[__=TJ-N4RS=PJJ:9bALK&477a95EFH;&E1U>bZU_gBZGS6d_.H2g5RN9@T0Z2\6
SVTaP&\<(5VKF4H/@0?b.fD13/TaSI>P)CS_<3IIF_bJS1&XfQ/7]C_DfK+.cP17
eLKbVQfHcRL+QT6DTF]R#bVd05FF]a_HYMH1?>],NNcafc<c@AQ=&[b0d[UUg.[D
64C(B&UfD,MPH<0ON&?d4A2XBI=R/1#88#64KCf1_<<(S.P;7/V6bJ5fW?f_Y#H6
_G&[]3OK/Pb52Q_,K89]8HJ<.YD>&gP^-BV=L:C04KZH@^(;d&VMGX)2EOGaBHLB
QAT91_VRI,]/(NY4^8.LeGQLK;-ZcEC6(dQeLN2AB>>HMPX5_gMFHD=M8,]39M]/
A_,SQNKX:D<:KT\Y.#519B/1LKNd63J12=6(UH4,AP9/+(=a-TZ-.L-e+F#AHE59
EO(4=V&f-EF;R5+-6b#-H3[;PW=<aDU2<d((S[JPX2J8(gP7e)Cb?#HDQC<3)EBG
IbX_9a:8.#\+Y5LP;1K6Q//7AT2g]C<4)2L7]2PL=//YLdcW7;53R73^FYGQ]3=T
b>,b]S=VN+gb9M&LDcP8G[PIJ&#.f+]2-).Q^/6FZgHCBK_O7DUeI1=;#R73R>g1
XQ@bOD/gaS\Da4D>FRYcf1D7@d:B5QeZ).9#AU.A&U)TI<fd=PD?01,:RYg?ZZcP
0Q]Q6UMa&Z7&H>76F.MPC.E5fGR:_aa0/A-25(D6#9Fda>g>]O/CF@MI#4C[:ON,
&Q_C-;)g69^[9@Q]3+87&Q7>S]cgg39DX/fOF^64>gWE):gXKPR^8=XPcB[8QQ.R
Q7A]X]YLTM+&4f_XOFP;E^->DRD)+S<\:d]-21T<7_c@8L/<b)@#,TLFBGE>KAU1
]O)A8fCc^AEd(C3aX-6?+LdZT[d_cFNQL:Y[2?aS:dT:Y#)N^-f6_.M\?QQa#/7L
QN29-ACK?./TE7+=9WS27K[fCABP4Uc2];eWGY]E:aJ1:McAB&LJQ;</Q^_-fLWb
O@-FLW\dOSN6_N)]J-K>e>fZ.ZU\(Re?4fdB<HaT>G:,Aa]Xa^D^6_=72):LCbR9
NUNI4<=TA8gCCcU)eR(CbLB;7.?Z&2<QD=IcQXC&M6GCe4<dN+F\OLJA4:TOf2Z)
5c,C/&1TM#G+?JGb:3/BDK2C8WcTZCXd84:0facf0Y1cf;LDY^:,J:^_]<]TQ6AH
g,ZdP7gQ-DHdS:\(#KOSf#D4(=J:6P[dTZ6Ef6@e4O[,C,WAKZ:8WDET+@@6;cAP
SC362D9cS__/L=T[);9&A@Y)eaL4e#2=Q&/104O_\7S>TAQ)G08([>T&cg2Z65MF
Sg6WN,g027G\ZQ#Y,C:2gC_\AX5;]Y2;MaN+4QNVa1-8OAb1]?#F-E(C)-bYb12T
EDKWKS2+4b8L117#K1:=H+cfc./b=e:a-PP0AT@SN=1.SY6KH.a-WgJ\c4S<:^D:
2?;FG,K)7VB_Mc70Lc=E^-Z0T_OR&PfU&K?61;PARVNfHVDG82PW6ZMDR/]</;0C
b7E):BX(N=HT)?V-?>0?CH6e?]/N5XLf@X?UA35=39F)<<^>35F]E]):;BU+-ABP
R+=bSZ0<aSR-B=OJ@0W6([ZC>WX>BR&Q1?g5E5C-Lc5R/dZ]]H6X(-3TV55AS510
S3=+CSSP=KG/Af&-f6CQ7[<HQY7UNS7<dJ[E[De)L&[(,@:X9^DAJ1]O>E;3[BM9
Y.9^cL-YOQOEJ0[,J77G3_H/Y;><ZMaMOFLQUaX&]YG>;aYQVW@DfN<6CP-,?a,5
bBXVe::Y3^KX&KV552LYQ/QGNJaO^B,L/S5dQ,0&VKYL;45M?R-+g#1?12PH.ROU
b8_(XdGC7Cg32S\GWKN_g<1VRT3B[FLb1U]9a]F)14[MTP_O8;Q65&ID-9)<4M:G
a_>T@]6aJ<gL+L+A]-LDNT(aSGd?g;L9&(>YegP_?XAR#&eURZ43FfD>=@;_F4f5
c.R>K>#ULNb?H?TMN4c3MFE;O<P?b+TB9<2+@N,W=MHA_FV?>N<1c8+RP#IVX1Bc
#0SH9C6@A80><4.5GW.-XN:ac>?.A\_a.7@Pf4EQ7\28E>;.7>TDFaQSWKWBYaWS
G>/)_?dg_f3U)#c?0\21WM05C6XEX@<2ZM9N>M9eZaM)B,2J,_LU7AcO93YWH\Ge
3OcO89=VSNJ+THGEY6>K==+VA9D#@JCWP+MU/#3R15/M[_3B>PU_b#\7+#IPQ]>J
VB7fZ6FR#]3GO.-?:Zf&-e1V[;N/.eWDOWQ7:Y7O7&\N)f,?ccWdG701C?dT2AQF
^?XBaEL/(TPB4f#46Q@M;;Na9f<I-V&Mb348B6@PULgN4@dUJ;<1HW2TM?=MC.3b
H&)+PO73+dUc1d)6IJ;269G9>6N&J/X8Vb7LQYcJB+U6RfMfa4YF^f.)09,Rc.<E
bC9D+BJ+YW;F:1)gMD(GU0?0SgRc28bO)H[BAZEY&_E=PUU<87?f6QcB-D]fg[@9
EZT+W.9Ha)QB<UP(9&GEK@VHa78)&XL_bGBQEM@Z\@+\&F1@L\HbD)P,g4OIeZdS
6@[E8OCeC^K4385\(7VL771Xec]ggPP-c^A;OZ.b;Sag?b3R6(>/=#1[9OL/J\;]
&=B\J?7M<MC?d-9TP[H27EAECF[KY&>5\CUT3FQ5b<LR9O,0:M,SP@R#BK=60g>K
8YN#RS/ZS?X=1)6FZA5_6E<SZ_aY-V4L7QSY/C?#T^37)073U:==OWOFb[eL1H5X
_M5#T3W_cO^??]1]g^fWAD4g(>C?W5T2L<3AeCLR.ZGHQ8JReGWN&Y1(Y.,Dc:Ya
>c[L6(ZX#Q2_?,^+7TI=>Q@_/H+8ATSCU\O_UEC^fe<+V4a56P_N:UHcGWYN2VLA
;KF1Y888WC6B8-X<G)/9aK^9._34<A@(dGae5\W?UcSAabS1<DPFM\8:XT/;RU\[
U^--1SQc87;_e/,#6b=(.Y<\\;7MLI:C>C[bJ5J7&f;)J=:(:f_:[fL]Z9CUGU,?
]Y0@_#(d7:N7W7<=S#/;JB/0#R;?#R[)E82Z(G.,T&VaV.F+eF4Q1P,Ob5YUC[eX
T8[A23_F)53=36TN>W^G#MT#OGbIdT-G1C7_TdKEE(:EUJ7(Oaa@3/(NcA=T3F/C
#N[\OO#2GWFf+H4DEQ1<L\ZgDcM5?FBUDb_2<)>d<NZ#JPD[BR2<KZUW+f4f9N]]
>SgOM6S>R4)e(;SR0Q@)RB&F3+S^2+af(T[K9#U0CgDUL)eg_Q@2C1#J/C37TG8<
061UY&H^]Wf(5\+^2=<>aXY:L804W[3\P/4Ua.[UAGbIOd[IS>G>S?VG>0gN#:.a
@a3Jf^g9#F3gQU9#OU0E8fQ+06M-_K^KQI4=^1_A7YPb]O:,>^>caGH\\=0O_66/
@\NI8gY7NF<-(2H\BdY1I5fTH&53=+6=)@YT]Y3/F50ZNTVM]SePA&=ZY<^8(OFT
e.SFE/.KD51U&H]:EN-0QHAXKGeX93V4>_7Zb+WMJ,6Q@O^QSGW?SXMM,b11NC@=
\e3[eRCXc#>NY;6V9D-08;1QE4?S+VY_II/a#8Fg9EbIY+5,a8\6#SVHK8L5_a8a
fE,ED4/0MBVHc+3d\)TVMAb1K/4J^Z)gU<S2O)WQ/.<TL.,3U4;7d+2P=eg^QMSc
fM8_K9ADWT-<\Y\SbcM5:&Y<BJ-7/G7O7>BgQ79GAc-Z/.<fHLbDJCW&&c)XTV;b
C_;;X7eY.U^Fa[OWd=d8D\ZSEO)&3d1_g70HPLd03EfZ2FK^;J&Y^D,c[GN>_51_
-?dOH<2&I(?T_FY#N;K9?T.8KPE2D)U.ODGSJFcT_Re]9.[GXKQIMDfU]^fd])QS
3+(I#/AQbdf[F0/Z@5[fUHAU4]<cA;.+=[\9)#Q.\MC(][41R(9>;-EgLQI.I4\4
K2d)cFT\ZPV;^IQ]e@MdbXYM0BC4YW9TAOa63,c3>dc&\\ZI&dcORK5X+N>&0XIN
dc9M\:S4IUZ(6b9\V.=)XHF)Y,Q6cPRN&gLG.[PTBNTCR\_D0S0Hd,#cAc8(VL_@
IJ1G:EC-aQ9-_Y3&5f&N)A=B++QBT:;.-ZI_+CC\[,,YU-L8<g.VA]e4SG&V>dgC
O[_>e8?[#fa[JVANag;TPV[E6#X--1A)BR46M4GWT9X5W1&0:59SX)\-FZ&PYP,R
PIMdD_Mfe^N_7^Y]NDb8LO6J(<KbY.6/.Z3_SML)_=A7QPc;:MJ<_[UXdHe/e_,>
6X=QfUBV?Z;DTd1,LV:9V?H1]d)YYKFd@Z>)(=KZ-H[B;ZHE@g;.AMR;QeSfFU5g
0Z6W?9[)0K/NWb]6?,BA4LBBbJR8VQ>;aBA;=DfYR=R;gH4d^K7T\8FO\B7/ZeDc
AAaK+M/V/D](XI<6H/J)>5WC[&UHeE3cIT^YcT;L&K:+4FSL_J0NNgFQPgSQR?_[
?34XE2Ld4Z2+Z9H.QS/J-[J7(f..2RI.8W(Td12]&#OXJ:+R?dDQ6G));USZLJ4[
.LMN_XD?;PUC@9N&9<J5U_JYIc_13bIWQ<[=aLX&N.(d@6DS5I@5WRe8GLCbWYYG
N4MPDeW8b4Wc;d_<UU,_Tc(OE0UcD\EQ<FJ8HF9WD-@6M<]U-/[>_83abFWTL-<V
F2<gX+0PgGE+>;K9VL^KY1_YJ8@N]V,]8+2cXNL])@_\1,UL4+gP8<WY_S=DDI2M
IH+^ZKN]0GF?TGD.USLgT^78gM(4b=+a,P=d)(-CYN_N>WO9[QB6B4c\_HEZ=M93
=#.cgdO1S2Q+T0I^M1.>Rba@PV;Z]+P&OFAX)125EH+/8&Y@7g#NGW\X9a3KG27_
H_+ZW\Abe/;4=V.LW[R.Q4OXXc<);)>K^I2N0?\YQa2F]&.6QW+UbT)S1KH,21;F
gUG[.a)\=W1WYV?_P/W_=W-G4(8g3@29R_c,]QWA2N.D_P1I=_c[Hcd+bcM4b0dP
:GA0Gff.4IX[b;\_dJM?JZEZ<7Re7/3YQ@-9T.Rd/R(.b(0S,-AR7SRJ#7(@8_UI
LQU;<JV96gNT[T04T=F3c2@^gLSF5P4cAgD2H?P15C?[]9K>X?d=YYdaZ)XCF<US
ZJc[Ab&]P_T<I-+^W3)+XbJXL]3>Na0;cW=-A&6_TCF[4#P[DNaYNYfF_bL6LdLR
fCC:&&/[>P]OVT:8>/G7<KGeR_7^BN\Z#IF0=L97;-:b#@c?NHf@;U.Me8W0?KA+
IZTZ#0P7I-;+THLS52WG,#@+F?+A7Ce>@M3ME[1B3.)1dDNa5^-EU10C@0_#1g<a
[[NZda=\+-;R4)GP]31/\U#=cV=9X9R[@FY&/KHG2C8Sf_:-D#WR[KYQ?-5<G2);
VRO2BL0A+d-6YS8d)>#JH,B9e&O/eZT8LEM7==S6)B1\MbT<+XC3KS86]FE\01-Y
X7I_\D36;44=>>8CL2N_U^fWOU8_##f/P]B=QUC-QW=ADg8fH+_Tb/E]ID0H<JW,
4XK(fJJ5BeJHSD_Lb&]5I)#Z>.c@.65(0RVFCfB3?dC6:Q[P84#.Sc,W=_91,\_1
S3<34286&=,L-CODLHXF8L>[\.BT+TEA_A0AI,Z_W=9TaWG/?)N:6d1<B]/;JD/G
WVgT[=TK?LT74[:WcF/E/b2J8=3(7.SCT(UN&]J3P0S=_[F-9b)T>ce-3V3K[bFB
,b-?A=^d\c/PCX==;#9>2D&^.\W5A4_DWZ>\cO9BLX8X8KZ@6,(=[HcbQA?;I@5[
ZeJe8S&9P6VX#4?FQWZ?9W.6?,W/Jg3LKE/#aJ0=:WR68WVM9c7V98&_;J2b=a.5
+?dJ#d@-A4]Xa3JBTgQ^Hb#^;AHX^6:(XP_P<>&fB)_G1Y9)3DU2EAa6,QVN:NBR
2<ISMF<(&XbQ(g;&IYgK#OB3VLc<V57UH0XF0GYReFE-d:WH_4UdEW;NFYR<0,;4
Ua3e7_+9]P,W.7bXGLD4a+adg7F4QeFGf_Z)J#/@.60#/>3#9a<V<OEgQ=d,S[gf
OSZ^g[#^Bc6A756AWGC,RaPP=[Ub@@HFa/?,ca,CbO:_>eaU8>YgA#ZYD\=)GYgA
ML06U_.=OX2J<1(1N-?X0Ef1F+FPaJY;NHGF#X^4BO@b@SY@FfW,HD[827Z?M6a@
NMAF6@V\d[5G2Pe_Q6T43;&;^3P>V\D+d3F?C111(e:-ae6W]TB/_6Vg>82U(3E=
I3F/1=AC5)<[,OOMDKAV@Z^I\Z0SM[VB+d&1dDR;JBa=_)GX5&794SEAPH/NL1R-
4(P@)CWcLUXNVHg8\(CR4#.),^D6^=O4,[eNg=<]@^U[N.DMQA@[I1HGAB7]P(F6
PeI@cR>gCZ69#D2a-;MVGSDZR))#VV=AR2XL^?,5Z-J]gIY3/Uf[OE&Bdee;5.5D
HLX=4SWZ.c3HW<Fb;@#N]e,N<<3O]FLYFWBS1.,]23&SY,O3_R^:UO,Bf<KHRU5[
d)5.2C\T]UUH<P7]X@W,Cd.HRVUd?.6JD[g=Y4_U(291Q&ZD(,Xa91]0.H@:#-c8
eOG8b;F4DK@eM(;6-D.g>/Ab]IGX#_0D5^(V9g&f>R^T,dfUSC1QC+/=3bWL#>b^
1809_W2&YN.Y^SBGL_aZg7>8?A)ZT/TY_5ZZ<5ggEfeFYK4YUB/WCLcH4AZb7E]g
OTIf\dB16]VV2Z&D\>,a/C##XeeP(AD)BFAbYIEM/@R6B7C11VI7P??fLc8W8DR@
PYDg1+HS+MS,EQ<T5S/OCR^b&GAIbeST.?Ed97-9#g\@PDfgQM]@:ON>H=)M&cb>
8ba(3H-7OAF-_67)Za05@Q:_ae:;K4RJ2PEL0]-(GG0]5gcM5[T(@Gb@FTZ_.#@1
gH_Me/K^@VI&:_0KE_.HIU-5O:7B>8C5^-6B\UO;e@0)(HE;[OLK+T-FJ5g;^-F6
WXPfEQMVK0aNEDL-C^\3cR:6S\2E.:F3A3TH]bAcfE=LT_gg&4O8_&_\Y^9efZ#A
X>D6TcMa0<#URKPPfS0^(Dc4PXQ5-STV>&KT6RMDV8TF:f;VCgQ93^-JI0F3W-ea
Ge],7Zd2R.f=1NYeAGRd[=Ba2+JA,XBUeLVA#D(K#Bd=;GL_7>>[Fe-L)Df+.OR1
F^+P5E5_)6F0g/\7R0MQS.,483Q;YZF?eN<b-=;0E6<UJX^^@67B2H7.Y\>Z=Gb<
,LERN_NY_J5HUJfB,TfJ&W1IcE^Z.9T:E#/=B].)FC&4?_?g1PZ=-Ja.BBI92//8
(K7A31GNd5fGLTU+B#D+2(@4MfE=DY8ZNAd;H_,YX-0J-Og/(I4I8OLU.IL8fZRG
N#dWJ1P8LB27S).MA9M&Z.1-NJf1+>Z+N[FQ<ff@E]^,1RRT59/GL/KVU[T5;fLD
C/PfH;?ENKUD5BF9GS+4gL+^aU_UW<@;O?O2HX0.0UA(2KQf#PM_&Y7)FC35G__D
&]NI__:aSOC#?JM4,XTC\/+U^B]F\2,/L6FQgR(^.@dReLMYdc3MA2(?e5O\[gFX
PBY,PM-/.2d/LRD<-c395,eTNb)BaD>OLJ^+;=3.dKg(3c6dC2(9>.T2He2Z05M4
H9#AD.Nc)ee@=Fg;8FQB?UFJ_03[_:9[GUW<GJXfH[V#bN(OeK]P1;:IED:AV]NR
>F4&5SDRHI9_ZIJ]OBe_9LcH^43100X8D7e?f1N&6d#K3g>H#AQFN(D[4;K=<7DM
NH<>c[BTHVF<1.E=b]&X#(QUO5QC\GLSKM#(&2gX>RH.KLS]_4IWH&4-LeA>[90a
/fDF9ITaC]M^Q3cES.N_fHG\(J6>_F^(&7DTDd[4:Q&,P;C0AE>Y1OGY2.KS<0&M
A)LbG.X@<ZB<N;WY)HNJf04JJ4F:/V8FFN7RIb]2+:\ALBKQ:NCBU.TQTgbcHVe+
Y73#f<7QR;R5^)POIa3]I<4&a@F+BWUP:RaB97C?1[,5A^QCO2aV)MG=LBf/1Y6d
)b=]@HPYOCFZ#;77(3Q\-YY3:S/WeI+QG3C7TVa6O25NJS,f](?W9Le8bd4G^HB+
VA7=F)[;9)1<TJN.OBTFH/5ee]7U>@(>F(:1g0>^B,gC+C#)-Q#Lc][;/UVV^AHR
4cGBQ4L6GS]HQL.]/QKX&,2J.8Kb^:@J._-Q:<>+H1b-RcISVP27cT<Z+U.FR2+R
X:0Ke,:a85?TCTWG&W#)KI3Kcg<BaE/GK=LV9D\V]:8+_aAN=(f^/OF#2K\U1=5;
Ja8SLgg\S/)B]&SUA)>NTNVMY4eP@b]6T@1N5Ub4Z(cI+=A#fcX/7OdY3AZU;4J@
UZ9fc3JDBI<HVVTQGI<MNcd;IP;EIUE^aW7cDc>JF?,8HBdGR#13RD9@g9H3OKG+
_10,SI:g5c8&YY.(20E+DaEYaT_^MS\^+O;5,E\gFdW3V3.QScZ<,fVB1[d\ZNL#
/TJFCG3g^&a:/K)^,;^<.GO^4[P_4XePYTHDGH9WYHU,HCH9QR0SQN]ab6=\SEb+
bZTb&M)9,Z5KI8PeTSg5eC^1-3bNCSB,U:;QZJU)B3>#BMK611Y<bOf60M6f9N(@
ETT+W>_Ne4/JZ\LdC:[fZ84>20>8,@)57[F0_L6_B)V_ZHDa6:PCIO)ZZA)=9If]
b@@1@N\?/W?\^@FBgSUE?FQdf8@\8&[CU5TWNXW6T/e.8?e)59)5HP>OGD[>aSBJ
M2Qg48ULcHQY,\V>Q#5A,d_Ec62CHaCF/c>Z1YIF8fc9Y6_7e])QH+2fYR2#N6/2
LfTcSL<&W#MS+,JMdb9Z:OJZ4:EbJ]Z?BQ7@F4^3<Y#]2AFdM#+.-#f<:fbdN^-C
OMfZ@7LcY@VPTP-a)eLDCNLFcHfd[E^#NJKR5X.X/)Z2f6L0W]JK#gD^L(Xa4ALY
/U&PJ[.3&EF(PYMU]@fI4EMSaa#UK&9^\cE-H]ee<A((A3&\XEQ(R[P7WR?KA-Sf
^:62@5[+Y.PQXI3>_9QZB2dfGH/(fV^fK1)B7T)TW#^4,IaMOXb:Z4^B=LSTQSX,
U@.7(M#TL/abI_3?R]).3<XBeVRE;..164#LJAce+.(M1VM;&4JRb4BA,(#6[4GN
@#3V-^:P:WANL;CcHZ0@8RGT/:-X0?;<S12)L8B@/R<,)?;2I1,4.GeYC-JafFK_
LSL9.1N;bK+adPeCNdWY1+f0eJ\2N60gZ-&OA:8ecRK_?NJO02Y@@Y1J9TX5[L:]
3>]7E=X@I.CHVA;I==bJTO0_J\[&<[IGRV;_(+NcODC&>WV:Y)&=ZaIQ6Xgc=g8S
6)+:@fBST.e&&HY?2-O>e0<cZ(H<W8K]^]9R#dQV+3GSL.E,9(.5H9.JX9DW\F0;
8Z;BSMg<O423F?9_W[[BHTKgYZ#CaD^)S(EX&a,T0JL;>M_MJ(:B(AK@@>)E^OHR
@24E35DW>3g5)K-.R-(2HT\UCOFQ<F7fLII+ZY&EN@=V0W[KXX1SB&>\W@AS;5MI
.+A8\>Ga9()\+2,WA7>J5INU=Y>cO.[Fe1.&=XTL3Sa\ILSE3dT-C\If_3];_dId
?c=>E_8e3(W?1DXZ4d=YT(=Q.7R4/#LD)Y0JMc6?eHKRLMX-(/DH3M>@+3d/U.K5
P>Q?7Pdd@5Y_W:/A+>S0E;KW;fSfH>T_&=)>cf1J&RaX+JM)B2P30DHZcBF:JHL&
(RCVXS2>QS-JLGcKN,S4e[f_O,BW\1Uc<]@AW#J;\5.VfNe,R0PS?BPfZfWVIBWL
<#US6IMeGJCd(VgeR6e.aTIYE&-LTK+cF+5O5X9ESHB/CC(<Ed0-gPULG/EI<J/E
b)9WFN=..9T?(M.cg^fdKJ7EEH.eK4De?a>WaPb.-B9:,WBA_ZZ[fQ#fXd1&UMTO
6/b2\/LY]9--J#H5[1HJc_#NE&2Ce)?K>:dKD9_5QaTZddAK<W(XE.KQDFb0\H6S
5I]f?LaSZ)ZB)1agY1J<[Ha+?f#&)c2Y4/c9+;&9KOXOB2&ZAKJfb2AZ\X@NOKX0
;6.PL08=.Tg0QY;gR>0RD:^;D)2.3aVHRXPJ2BU@3\5G@N<\bB\9HA0;f0MS2]UA
GFWB53Xf&JVUAN)aZSe=C(f>UP7H)g8gLJ&FBZL+61_><RR/QL.a^JfbJ4V/UEB/
DT.G7U<P[ccE+b8A,#O/;g[JF1HH->;?E0A/DEQ>OYJZC<R3-McPH.XQSXD&79)&
a8&e1O>.f;55.R:+EfP](=@NIgRGb+_6g10,F=Se8Jc+fCYEK;ZH9@)=TRU+_8<S
b[6<XST875Y13a[Sa@/OCKIX[?e+]96O3)PP#MVg81BAVR_07[E/ID<RfFY#V64?
O(DG)65]F?8-30G@5EZ+=R_0HX<?(.B><G>7,QVU/(>E3X]@HBODG[b:@M;Bg^?B
9F^-ICG@A6\0PKV,[&/[^(C_?(CZ2g>cTN1)V&<&N8NC;0#\A=a/;b^>DML>2J<E
?e#/=Va(Ff9W>Rc:e04N-Z#67X/>^;Kb;<QQ^]A\^JP3I:0T?W1?&O>.+;GM]aa2
\#dcM[cAM<(g?3>\ZE1eNe9/(>45K7eC+c,;dd-P^L1[BC??]L6IHW:f#(P[-(/G
0,(G^Rc&R9QeK</e,KYKL.Q?f+7M#BfM9>5W]4FgVAL^YY28M5-S78+ZNUW4bKdL
J(?&=.[G/PPeN^P5&aeR(ODe+_3_V05V:O9:^]AR@c^(O0b)b0K5faPC/08^XKNF
3>-XD(H]M>-Q:ABFCA,fA2#9ESZ7?OUQTA#J3Q_G(0N2Xcf9VHfa\JID6-SU0^YF
bf1cC75fDQ+[+30&UZ8/2b6<X18Z3H0RR<BFQGKKW51GFN.]SRc.gVTMLM>8OM9f
9,CfW?<,E2Tb<O<5[.U:PD=-WVPFY8f75MPAOJS.8=(fQ5Ba57Q#VA:e)&;GYT8R
74MO_8+C:=BYe31PS+d8N9TQB>[(f,/R\7SFLBGZ2_Z[GJ8G3NTfU]WI]N\CGNTI
gL-UTHL+&@7K4eNT)0KCW)5MXFKO28Y^+Nc#EVB(^K(-[/E@a;b053)3J4eCcOf_
Wa9VaNYZ]:f29;G\g#Ga2W6QZSU0>]_B</#<G:gcJ>(Pe#XFf_624dfSaSU@]U(+
OBJM;XL3&9&1BN&)-N6>K2>E)#NG8+cKJB;VN?+PaJ;?Q1EE9@V<_MLY6Te62XS0
-5/Se;.=<eBL\J?)&QfMJbKBU^)MI)GT&0BLQaYMI4RMZ^S&GXS&]SX83DYIVA;[
,fUNQNF)JU\>QHNC<WO/S@\JdC)RNX8ggNT-ZB-(9QUK-;PNG4TG6MYfU<L49E\2
\].JY8K&\Q^e8EF)RYUgc17+Xd>E::W6ZO#/:U=P>Pc/(F+Lb@R[\.#<>I-;XIE;
1.3Y5][#RXS,(&dSE47+P;M]gY+WY6dgeA-FK/\dCIfS4R+J_1fSBU8U;XDO_G[O
/ML4YeR2OK#9BGd/\],;STcg\E]G04WP5I?A=F9_&WL\Yf<eQO,:K/2?f#gIL.Ha
d_I]D-E,OcPPa5DR3#\U@A5E&C?\K5?0JN;K1--QUZcTP\f>YTafMg2P9=9Y3X7c
G8+&Bc4-&Z.K3+S8IdL<M697Oa2YQ2(b1aBKUf<\3cNE;KNJ0)K0.a0NbgOLNS?#
A0=2@\P(7Q]TD688^-Ad+K.63W82V1W0fJF)1,dR2E@,@7LC=3.(0f\_:[&R)DON
?5b_PbGg2K&8(P1M+bT+LdHUZ?5T@53>N>5;]X)1(a^49/TAO(Tcfa^#>MGEIa.0
F0FY(OHV\VR6HS,&KSEKF^X5>D75\1T;5ZZV;J\@2bKB23CJY&0K>GIdA::HC.+-
@IYcX0;>NMcHPBbAWcS,V>&c:bDIZ4HdBYUSP\7+^Y\]Z,LG6eN?eHd4+IVEdOKb
9Y36-#J0[(<F]5eTM\S3[274I4D(M=2&=&\b,PM/4a24=C9gSO,2Y4&^O8Z:N590
05&IC2EdR3.H7c1aI/#X^eF2#Zf?/37A^C>QdTAgU#ZT2Sb>8OZ6IeM[NNfZYT3d
L=YB(OE7WBdV5]-F5Qd>MaadYN_EW]-9<>_F_HO,aW.(@QfA+gD_:T]c>J?Kc\76
_LaH\02\-PQQ=]^9+DS54L7S+EbZNNb](2>e&.+RU8&b1PHSY6Q9:>4L6gJ8QRBP
]#TJGG)</J\(Nb)^>C?_#@0.0ZU?6>^4>4@JXYSYED26C:JHZE2>O/]K[/\AC=A@
S^E::AZJ;^H,4LEJG;#e&\[3<;?90W<ga1d67]CQA1Gd\W@ALOGg5CC/JX2&J>-<
.R:2;ET>XX.]W8c#e6(]^XN0I2I/8Z?/7#@]4L)cI5)T;OH?.RMaKJBSI(O(1fef
I>46HF\G@@5eD\Z6Qe@_=0(4F;>2\cOBbCCQVcPD[1b89f&[47=dbX-H+.bFcDRD
G(:_/HW\38SfBHKfN[5EGLcAcUb^F+8@R:?F##OKA1L-6Q8_8(R=N^[3,(b,IJ,S
OO)JO32+@VA[C&4A)?bOU(3X,\g>(8&@.a]g@#e#1T8Y36aJC89R(JS>,f+,,:Ma
D&S9PO7=/6Tg@QRI.a7KbCPU2PSbU=_LH[DCY&JB(<IdI29c63#P9]=^,R4e>88b
.>F/7[FLSFHKI1XJaP&OAU8WO3]FED37//2.G;Y[ZCaWTM/T>I,6d9EG@3R23W>_
-/QQc>QdT6eFVX4C\FT8,WP@;1;ZBgUDI]AVKUVY41Y202FC_,6?bA@J_D_@g)^O
>CeBV<09#DPgZ5b7P82MYO55C&c>K]-U9)@HIC3]R\1a=;<gSUUe^E+I\fP/E&cY
0B__M6D\b(@UQRaeg_g80KBAZ2g44B+D(U^B#JBUY>UL_g?GW?K.XB<<],fZY>d(
eS^fX.&OSLCF\1>;0MVc[MJX@;D.T8Q<,KW9NO<8:?MV^KGdI&4X[HA5I;;;[(T(
gQ)9M-]CV1Ra(G],/53-U;6K6?GYC.3&Mf7KddMdU1#0cMQ2,4e3ZMFCN++NGI8@
\NZ6/78Fc5^:./;.P:bd73c6S6K;b-)Rea9G<66+4aQ5-3C>/D627e.8E(83@#Q^
1M6c3AK-a/:5?S3A],bG-e4/[^2-92af]5#9LI_,ag/^6a:[?U/d]#RC15;86]ES
(XC+]U.@S>15/CF[J#]CKg<DFRN<RIT[fM,Z7I3A?FGK=1MJ]@ZBL8MVXR+<HT=I
aBCNJO)];-+_O7#>IUL,.<@a?@V=b&=N&,[CRLY\]4gD7Y[RP^ZDaa#c[7:D1Y=9
1Lb-Ud?(N&S#)+R^U4&+AATMAOdB?Z1g8-X@CP@M-N\9&6YWe56ZXbVIYBK62_.^
b6\N9@.P^SE4EY@32=g7>Qc6GeL9D7W,?==/WGXMg(gf6OILWN9>=:,Kc6_Ocfd;
Weg(>O>QOG(Y)bJ-+4c79=?\cZ<[>+X]:(<&K,S-;FXER+1D1;L9D6J-ePa+L(Q6
:W2RX5HH7f^\OIL5=VRAbI);&;9&b-8)NW9Z>,Q\M>Tb@VOPRLUT6b^OE1>]5U)G
#K1H?241g8V(#1[e2[-N<.^Y)&_UHD[([M9QQOU_2aBYeCO+F+gVB);acIP-WH55
aCI51O(FV[0GAd1[QVX__7)c8]W/Fe&Ve=<N&ebA&31+a)87M2B<2d9)a_]b7I35
@R<@.C<aYGC8^N>@IGAK7N5B.^JN6O?,268,a-WYLaBbG=F]c;SJc>G;?+YL<O#6
-\(]WaGYd+-\ESH0BfC.5N[(CFCMQL=XXS\0BM/a/Ae#B@<B\<O(WS2J]4GDT-Kg
+)MW-W0X-7M4#fWG77g74C-[8#G_3dc6TK:aG;,;W>.Q5U8(?X57a5&.\G[X5#6+
0f.<\Tb1C&DB3[.gPd/f5cSgHbXb98[5F5.,H5F#YQg]=F6A3XT^D-;eWMgU(e3Z
Qg:YKSdDC^5>F_&[IKI.eKJdRW\8TY<VH:+P@MOLNDX<8^@1<>^0BFc35b)fA5OF
gI=Q/MN2(Y#Q8)QN=6ZM-P4?(?dUaL[b&;dCBbGJ>K9b9bMT9Y.+E7,0TSL+T9fU
f(KU)@B&B#=J&M3/f?K=86\<)>Y9cU.8.N@=++>OI4)edGICG2fcYDUTIS(>3M9(
9&7VDf(a-K=GS,B2(#]KaJ)d-8I^cC>3ed#Z.>baY.a_Ua@LAMf,1AO>UN9@K=.)
?T-?&3#YR8WHc1QQ6a:[1?LO(^&4^.JBS33W\X+8.\_bCK@.HN?,;-\c+C#[NDU#
PG_SZE03[A);3\[#CYNJL;5RG5E?]-TCeE5DH@(@=1)a=7_</BCJ0TO(\C\C?\Gb
LLTMb\7W2JU44NUPOJU;4=1NYL;eL85=/ZZ>-\fYPB>Mg=#B/Kf3<>6JDSW>fcd;
?Y&=1TQ4248,.[f^K5KFTb,@;?@R07I@_W62UMF8c#H0?NAC\VIa:&^/X=ZIb7R^
&GA+Hg&K+XYK1\-<Pg&b,R#W7Y+VY=gE2-?K:K+CW:S+6OPDdfe]7H^E:\QKG.@a
O(?N#C-1J+OPQKK.+A3<O.c#^+TgE81GJ>\afLWYFQec1-.F\O6<TZ.6P:H6@@3C
KN?Ma[MG2Z=J;(#,JF3FO#9FUf):RYDf<]S/&@\1G/OE#:=TaWa+HDT?@(N?\-Q,
=M2Q>.BeRB5.L8?Y:J5\8Y+27C+37FO,AY9Z)4IU4(1A<BaZ=/DYL?6MJ5/F;NZZ
BV(,JED=],OB:ZWE&#9R9+5&W(OA#?>?_3A/>7GOROKYX>H\\1@JQ+?,A,UfTH9X
T:3W?S9e9R:=R:,CHac@0J;.fO&X3/^f8\[?bdOd@8A@_.gG=LW;D^89J:#JO,T0
\LNg6N>_X^V])Q2eE7LT(?-TE:]N;[\S6.PP,K,+\<KH/3<>3Y[CXXI&DNfUN6/P
9N1JLN3cTVC=WUP#K2LHJ?HY+@>b@&]d+,1f?:6[Ud1+76LaH5TVR/VER<+?W:PD
EZE2^[+D6WJgQKb&7(ZJN&K\PZ?BC()]aY@8:d06PCZ2<8dLH3CUd(C6Q@;0[X7C
fP@,Y^NM4=5UA@3U&E09PPCX:H5#;Z=>eW=Y0<UPP6\:WG9A<Vg7]_B1@Zb637Z8
U[#EW4NMg6Y6ZPMR#]GM>D8BEW9NVOQWL3QJFOFVN0?(E:JTce\G]63DFeS;Y98/
@1FQYgMJGZ8S+4MG&@&)EbbDgVb,.@3MWSPScG^NaJ?9;RHE6/8dG^L>^?7cgH]<
W^<<(T3NL#UDP5FU[CFJTRNRZeg2)ZWRcN6EMWgRV_Y[0@5,&V5S#(Ne?AJa(^]Q
\IG7WV34]B\H9;61[cL/5YX(<,L9,?=S:QIWVF)b]H_KB2/_#A8[ZUP[9;a5R?P&
W-T@VT/&7559?d5D[Q>VAR#J^MG[2JCPM\76J5,QO@G;acb)5H(/QU5edE?K#2@W
B2_GTQ?cH=?A5#715]B]dd#CfLR>_X^UT6cF=R^[FV5E[6)R>EQ=.F+;[L?NIZC>
1[8)U-0FGfT:UEXBL(\PVLEFge)DBG:&F/cQ?(0=9JT),@H]B(a?I[eLeg:Ic:Og
LW[3ILL94+[^E6]Ka_A@c1V[VBEcLJaCI5caMe@2N^G-]d8LW8g\DFIKX?b6JKc@
+If-I^^87D7:8LgfXa5?IZ4Y\Uc>+9GE[^6,d4_QN1a@)DQGe=b?>K9e>+&NV)RU
V5CPGE2DXSNE\,=d1^f<BP+]D(>E.#\C.K7V43_CG7gfL4-^.cSHX)F:-f[g?MI)
d=L&P0;@?94@I0_(I]@d(AIB=fUdcYZ>\8H]8J/8C?B=;W^3d^-4:NFLDePI#LDC
.bG]QU)gG<XP@G<GR6#5[bLP;VBIee:A\@\7#IcG/SL&)W(^0\.WXB#U(KE^/)GS
WR7#27aN15<I0S^>)2X?(A[<WLWM(Ne3dXX3E(5=fZ<Ma<?2]DIF+=MZ<5C>RX53
O[4^3a>6S7RaS88KT>(9cF<6KbM/Jf4IWAJQeT(4ZQXG\>T-QgH9:HBg9&<WCE(H
Q8[7^.GT/__^W5=7==Y)T:G/c_^))7-KX86VGILHbJT+8#CA\Zb>S:O7AE+JRdEe
#(;a5YBa=2,K2W>=TI>[J>EQ\9:eTbee&K45f@^E(9Af4SJ8B(X>)QeXVe-T1V?/
VTAI3-5f--ZTA+=bG-&,T3+.C\<a)S-6D,5f.T8&SJ+UQ?d7M>E-X]&We-+<g005
?gN-4>Z[&LbEHg#UT2?=Z.^F^f2X+Vac>46Hf0<^0-b^QL]:Z#3@<>3d_B0._12&
OGa06gBQT0T=I[73K-T=,cS?(6?+9CZ.9\/7Jf0NPIRHPccIfe;RC6PYS\PCB18W
_M9<4>2Be7/@WS5N:\G5F@4g?:W?N74(54V,]Y\,de1I\-NNW0B#99LI8W#Ce/EH
/a8a<2Z<))INKVZA6/OH=9EUU1T@Og4M0G2M;fHFQRWVD3[R)fR5MV;48f=_O]][
?=>QJ+&LP+^6T.8bZ<M:Q+AQA]#6\F2TS61VWR/6?R4N)>Bg)5ARL;3GT@[L30bc
/^66CZDH09b6,$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_MICRON_NONVOLATILE_CONFIGURATION_REGISTER_SV

