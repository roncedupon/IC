`ifndef GUARD_SVT_SPI_FLASH_MACRONIX_TOP_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_MACRONIX_TOP_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP 'Macronix NOR Flash' Top Register class.
 */
class svt_spi_flash_macronix_top_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Status Register. */
  bit status_write_disable = 1'b0;

  bit quad_enable = 1'b0;

  bit [3:0] block_protect = 4'b0;

  bit write_enable_latch = 1'b0;

  bit write_in_progress = 1'b0;  

  /** Configuration Register-1. */
  bit enable_preamble = 1'b0;

  bit top_bottom = 1'b0;

  bit [2:0] output_driver_strength = 3'b0;

  /** Configuration Register-2. */
  bit enable_dtr_opi = 1'b0;

  bit enable_str_opi = 1'b0;

  bit enable_dqs_on_str = 1'b0;
  
  bit dtr_dqs_precycle = 1'b0;

  bit [2:0] dummy_cycles = 3'b0;

  bit [1:0] enable_ecs = 2'b0;

  bit [1:0] crc_chunk_size_config = 2'b0;

  bit crc_n_output_enable = 1'b0;

  bit preamble_pattern_sel = 1'b0;
 
  bit ecc_fail_address_valid = 1'b0;

  bit [2:0] ecc_fail_status = 3'b0;

  bit [3:0] ecc_failure_chunk_counter = 0;

  bit [25:0] ecc_failure_chunk_address = 0;

  bit enable_crc_n = 1'b1;

  bit enable_dopi_at_por_n = 1'b1;

  bit enable_sopi_at_por_n = 1'b1;

  bit crc_error = 1'b0;

  bit high_performance_mode = 1'b0;

  /** Security Register. */
  bit enable_advance_sector_protection = 1'b0; 

  bit erase_error = 1'b0;

  bit program_error = 1'b0;

  /** Configures Feature Continuous Program Mode. */
  bit enable_continuous_program_mode = 1'b0;

  bit erase_suspend_status = 1'b0;

  bit program_suspend_status = 1'b0;

  bit otp_space_locked = 1'b0;

  bit factory_lock = 1'b0;

  /** Fast Boot Register. */
  bit [31:0] fastboot_start_addr = 32'hFF_FF_FF_FF;

  bit [1:0] fastboot_start_delay_cycle = 2'b11;

  bit enable_fastboot_n = 1'b1;

  /** Lock Register */

  bit SPB_lockdown_n = 1'b1;

  bit enable_password_protection_mode_n = 1'b1;  

  /** Solid Protection Bit */
  bit [7:0] SPB[];

  /** Dynamic/Single Block Protected Bit. */
  bit [7:0] DPB[];

  /** SPI Password Register. */
  bit [63:0] hidden_password = 64'hFFFF_FFFF_FFFF_FFFF;

  /** Parallel Mode Access . */
  bit enable_parallel_mode_access = 1'b0;
 
  bit four_byte_indicator_bit = 1'b0;

  bit address_segment = 1'b0;
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
  `svt_vmm_data_new(svt_spi_flash_macronix_top_register)
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
  extern function new(string name = "svt_spi_flash_macronix_top_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_macronix_top_register)
  `svt_data_member_end(svt_spi_flash_macronix_top_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_macronix_top_register.
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
  `vmm_typename(svt_spi_flash_macronix_top_register)
  `vmm_class_factory(svt_spi_flash_macronix_top_register)
`endif

  // ---------------------------------------------------------------------------
  /**
   * Register Accessing methods
   */
  extern virtual function bit [7:0]  get_macronix_status_register();
  extern virtual function bit [7:0]  get_macronix_configuration_register_1();
  extern virtual function bit [7:0]  get_macronix_configuration_register_2(bit [31:0] addr = 32'h0);
  extern virtual function bit [7:0]  get_macronix_security_register();
  extern virtual function bit [31:0] get_macronix_fast_boot_register();
  extern virtual function bit [7:0]  get_macronix_lock_register();
  extern virtual function bit [7:0]  get_macronix_SPB(int sector_count);
  extern virtual function bit [7:0]  get_macronix_DPB(int sector_count);
  extern virtual function bit [63:0] get_macronix_password_register();
  extern virtual function bit [7:0]  get_macronix_extended_address_register();
  extern virtual function bit [7:0]  get_reg_field(string prop_name_field);

  extern virtual function void set_reg_field(string prop_name_field, bit[63:0] prop_value_field);
  extern virtual function void set_macronix_status_register(bit [7:0] reg_val);
  extern virtual function void set_macronix_configuration_register_1(bit [7:0] reg_val);
  extern virtual function void set_macronix_configuration_register_2(bit [7:0] reg_val = 8'h0,bit [31:0] addr = 32'h0);
  extern virtual function void set_macronix_security_register(bit [7:0] reg_val);
  extern virtual function void set_macronix_fast_boot_register(bit [31:0] reg_val);
  extern virtual function void set_macronix_lock_register(bit [7:0] reg_val);
  extern virtual function void set_macronix_SPB(int array_index, bit[7:0] reg_val);
  extern virtual function void set_macronix_DPB(int array_index, bit[7:0] reg_val);
  extern virtual function void set_macronix_password_register( bit [63:0] reg_val);
  extern virtual function void set_cfg(svt_configuration cfg);

endclass

// =============================================================================

`protected
H^OA.\[]<L&Z_b6K0G4:S[,GUM4+geNP[<RSMGGEc^5[Dd_UgCIR))9/A6V;?GI?
XD;<bO-fN.KHS]W?\HU4e/8+#J)8\>IQ8\Ag/^W5>.TefGGb@f^f5Lf(W>_0\-C+
-[XM#GA&\7A@U[ZQ:f_ER_UD7E+e/W-0R\V6HIcNfJ4PV;<+,g>#/F,+)(beY+<<
K.Rc?76<WIL4bV16;A.bCRY9)<2#XW(L#F)3f?[e\J>B9].+Yg(,4+<Vd9C(K9UN
Y31>M_AXeE1.K8F-4?0D_+;&6CFB@YQ/I76aR3#(&eS(Ec1S(3@OQ[8Uf9ZKf.NO
-2OP?M3ZXbOVWERC11K8N)>>W5ODf:#<21&bWfXCH.7<J#QNcK(O+N<43I[T0gF0
N;SU43/6;Z,ZX/>?KKZ/_5Y><C4PDWC,.Vda<.@14KX/W42B0S6YGB?F8B]R1VU&
1]M5dRAN0a8f]C[dT?\ODDS/0d,4D(?BB5)>;7D\(R\aM6,(b-(AE6Eg.TFD,^^8
4=)L5OF+>[LI;cESD7L4[CeUJWA/eF/a.30\S7FG)?_fSQgf(P[B&/&7][@61)]?
@:C+=&Z5W1@^c79&>6:e\RNFaMd(8A]HF/XKgLcC<TIAdc9:>5Y.CC[8&L7C0@dU
B[M:)99&L1W)_^fZ_HHT&W86V7AZYWCLC5)Z@+Jd=K/W:IPP#cVVCR[8O$
`endprotected

   
//vcs_vip_protect
`protected
.ZWS6\9D0gR[<;^9OXU=J/:0,G3E0?]UcE&C4XIdL.(=bKFEWE]G,(?:A\.f@148
B+S>1W=2gELZW&UI+CZ&FBe^5LDfM//4gX)92\#<M,XG(>2+N+1;R\E-AEc^7GOV
,aZIJDZ85@WADe;2<6NXe7B2=)4[:CCL[c^4T,P4B-G7cVH;Vf3Q<X;HfY/)TaD(
X1D<Q(98T/XaY,K.f]0\Y2>CMd:1ZN7gX@I+_>?Q2RZ5La_f;6U@]?.H_.<FO2K?
UN9XRC(N&_515Nce#\/#eR9P3??U2ULCd,1<a1TQ,[FP0R50O1FH@N:+CK<9E_2G
E04;83U.?HYN>VSU?\Je,F9)dP&==eFOY5fIG6\_gaVO4LVfV4VQV6.7>;KY-[^C
B<Bb,M_53T-gP42;B)D1P[\+K84;9&Kd[,Ec>DCcbWd#R9:<DD>7733bABO?C&P+
V\X/]1XQ(P[TPGPP<508XAR/&0^)9;3?[K=57SB.X=1U/-T^5WD6G9f-,aVbdEK.
<&?7D;G5WK?@;Z@/f&f?ae,R>.@RBb.SFHD)JZ_/7=GN4Me65]Fg3R(D-:1VV1EC
CbPfM6ZC4K<3GOT8?<=(XH@?.Rc[SN&7Je\C:A6?GTZS@afb:.FBR)ATFNa#2+W.
,/?=Qa-3NZDPJ?1Mc4ZXEG8JFITI2I2.#,09\XeXO#K#?Q[53+UcKW5KQ#V6:G<V
2RJ=MKece.6_YKc-gX@5I47ZJBc3C27V\R]]36[(+STN,gP.Dd=18;1.E[6[c[/e
VY8R#[&Q&)NUc2:HE#Q(<aPR><JY2C9_@_[,=V?fD<BE>#3cOMN-a9S#BDOG;^1b
[S^7Z#Rb#)X;Z7<]eeHP6^ZN&d.1[-_TK0V=,)>R=KeJ\gcHX+Hg5P8gcGc-_c4#
2AJ8dQ>;/G++C0.R>W0)Z^:7T8M<<U2V77C8,)3.RC9XIb1>U]8g+NX9Sb^?Sg)8
7W9D179UE4C4<J+@=,P1+P,6eS60d_Q?K,UV,Rd4_D+B6D#YM6d78S(_>aB__[,/
c9[]5,NYK9JQ/V27]L-.6fY[.3-]S5Z0.;<@\4b+bP--\c8E?B[H811Meb/c;</A
8Z?K(]5#=Fe9#7Y+3HI;+#)We4.W\_)(MXV5D<)2Z@YLNaO2S_K(a,aJWFK(<P+Z
(4OG<+-cDKG8aX[Jd:PJc87^/>>D3/7_/LM.e[b+ZYLLVD49.KcDcdVW&-CZg7&e
7;71d0O\cRM-eQ\,+)eS275<9P?<H+&LQf+8edV=fb-A,N=IEdP&TB^aR@\?/V/R
?3<CP)@a-1A;[c\G+)8KY@H-0Ee38K)0==BAA7Da1AHg7C=&4+/_X+S[_UGB?L=(
W-Q][Gd95b/DFeG>_QZ<U:L(Y?,:@/Lf&M1331dL4IDc7.)_fW7cAaX55Z:T6_3V
4NIcM,D8X(DR[b.YYEL7a,;T9SD2O^5HHJf:XaWQ>53MAd+]ce:.4-^#=6IMEJVd
W&1X[&3Dga:V,a(FaKR+E=<R>I1PP;;(?ZN[TLMUd0=7WZO#RgV&HQ,2VNeT36gP
U87fDS#+[dc=<E\^^08?)FK)+a9VQS9XV;UO/AFJ)#K,[63b/KP:JY0>cP-+0)]T
]W6FfDaTL5cF549F+X5/91(66OBgfN5>J(B_G>5?GZ8T]NFL=>A31\)UHgEAb[V<
+B[9P^L;9gT+EU,3?EZ-GC5[5-[6HO0#?=3<UTcc+F27cQBAQ#)E7KF[<.-b<d(F
[(9&R-V5\d+[b,N<1[/7e7<F:.TUUQE&4_0EY4#ALS6-_C,eTI-W];;KM?+g=/C:
;LOIHDd?J)OWc(7:<:)?2B1g3gHQ^LfB_HBd-35;->:V,>eA,/6UG0GXRKV6bab#
#HAS:.UXK1>752cC:25J7O23F0SW.EO,UJfT>4Q=<F?eRfTXDPPKMJAU^E4H1_FZ
F8Be9_#[[[@;>[(\TDaWP>fN7(T.\dVX8ML<\e1_DNQBK1>K\J?T.@NG#L]5c,L0
.N&Y2+FUH/[5X59Y2FSSD^TJe9Y#.g8d[_@XFD:3=B?-e46U#_O2<2Z@+cJX2;bF
Ub[/;ZKU+eVN<2PESL#_RL7WT\-<&HGYPGd;YEB;eEOK?)e00VdO/>VOHW3=4?=1
5K4af8<6^5>]eAR/=R9X0fDV;g1Y-CdJC^(fK7@(J9LHS?;dE1&cA,L)bNMF4NSD
+c&5DXY2==3J,V\FRHJ#^FCSG/TH^V0SAEP7=+:ABPRBMCF[I2]CK&E>GU(ZQ6:)
F(0>51)4T8^6d2FWCP^WMA7Y;/4>M]ROb:E1?OVYg5Y[-D6aT:2_Ag669]6>NHbW
Z]L-^)9[#B7;_&,M9VdCSCOAT2T@KbRSK&Y,<Ta3?8O20R?3g/7#3,.RQ5Fae3V#
d7<4.GBZ0N<P#^(La)Q/=V[V;Q#F71>Y8(5S2cM#7@H67eMa9YH6>6[9>]gTLKZ1
C47DD3gYga(ggTdV)JaaTeLfXO@O<CU7a/^HHSX7Kc@7Ba=(:ZFM2H9MDUa5a5]0
PF4Hf7TV?#SN^&WP()FO]B-NV-PQUK,f?CZ]Mge7+YBYMCHBS#<g,U,26_-:P#FL
a)^ag)NTgL8Q-gR5S3RQ\_N6FF)C2=?a[?2-K^LT9ZfV]KQ.g.=&#,Xd;f()K9@g
A9c->F<D;JKf,MbO49S\W@2S/AR]Vf19TC/c,L0fW:UfC)FQMRAca6.Q&QIdQA_N
g8g\b#74371F7;8JbWDW+5Vd8I4W])K[EB_afF8D.M)Q@6B0-N6(&K?FI:9(1V#d
U+Q#B))>]SK2R:V(.67S1e>S1I@K=/C7SfR1^&<E1H5b83fDTV7_-]SZTFG=bGWC
/\6H7OS^OgMYf=2@QDSP]9+IXZ)47Z^]=;)VN6V=fdEYN=_?2W>&WA7KXdXgdR6N
7D3,=N\X/0(BUP>E08IXSb))HT>BHI>)\S2(?3(E9b<6gdYXQ##:KL]\Ocad(24J
c_Eg^U3gLFHADHRS^11Ee0T^FA6Ed,P16L373S4eXF(CZc+C<7D19GbaM&@>N7AV
4&[Vc/E2R]OXVRLI=-?G9U+,NXa9EYOTCT6:N8J]<]:?8A<G_N@.9B]bcLYf)d<O
U]WB1HDKHG3S8XQX=D0SA=0V>3J&^D8[=57Kg;AO^QSWK&/E/e-UEEf3DN^V.aMd
f7KKNK1\Y>5M[Q\=GQ(DINSM[bVOW&cMT--M=+U5V?Q7(SD#2(5O?E#IM^(&CY8I
#+V-gQXFY<_.SgK4@WaTS^5f8<+(K(4X3O@5C=F[&Fc-/GZeZ?R:6;(<SJS@<-&a
5\&D&aTVe\bKA&K7d^JSN/LD(TG#6;b1-[<R0@([aN-.]ACO&PPYCTe:5G5^Q^1B
WEBWgJ^0S0bG)_2-KU]T7&bgQ;Xf[3B2:&b?M.-&KABT;JaV;]/QHc1R6G6e82:5
Q0T5L=R(6U9VF=A6KL?[IZKQ928W9>R>+1[G,.<XO_MPV,T6.>T+_/:U8N&O[dQ2
]6)?O9XH2DPVC-AJDF:[-<RT,G^,g;39[IA@>^cA0PMaT=9M7b+@A9.=)7I+M6Lf
E]\EB2\2G[^Ye(0]f-KQeYW1O[64)5#P/EV0&Y\1a:U=6@<3B1\,Y08bFH^2]9Eg
GD;1.PIM1#>V0PRL,31=,(dDF0@e3\P^IP>+e44;GO>/@8+##f+RX?7<5SMZ2X>E
8=VU0_ORKY8VNHJKP_WT4N=+82;[4Gg1>):V+-9O1R8K9@M19I_2?YES&VfUbGWT
,3cEQRd]USe8]]&TV<?X?N&T8L(D&:U5eCd@T0H;E8&QHMXc-,X.&AU;]LTe.Y/^
M9J<UA,D34B2;YSe2g.He:U8>c3e+(>M7VZ6Hc<6H&\O-]fM[O167QY34C=&?2C0
EE]CXX8cdRW4S=<1N.;FO>V^?^>]FTff0Gce2F\CXYJ\LY\EI);T[Ld^];PS0@YL
R]?B\7ccadSbQ2N]Mafd(:,O/-]37DAT&DD4@Xf)&B6++HBR6BgCc.7eG5Q]E>7H
K560])8a7Q._GbJNA3_@B(fcQ^URa<4[?Y_NGf#HM8E.cM3>8DA\9dJ[#dA+MXe7
459Q<TOV0.Z,AX3M@TgcBOd=6O<662O4\]@?)7RR]UX52c)MNA>S>+B&5Z+f;Y19
=H.;<L5@VU/3,KOEb(#,98R.EMDG-^@Z>8)#9g/aP,eC&5)^Q3d[X6WSJQ:LKJ@:
MM,413Wb,975@NY8K=LBT0ZM&A=)6PaYIL<FSJa0TI_RAR5a=aSN)(b);RX?1M.=
C6c:],9^;YY?F[b:HC605=XVB#cNePW6\XS[&:3eaf4EMZIMdJ2/QY5V(2MD#gg)
EK^b.?fP[D^5JH^VV0b;IU,3JCdM3d4X5TYGT)1_@(+5\c#YJ]LOAE+X/2-/T/[J
>ACC\Q?4ZB7TN2,,4WC781AL0d(^gV-G]O[V/./F3Q9\X[a/^E]FAY.CMZEX0dSG
J7T:G)_/eQL=D4JY4-LTD6L@I6^LM[9.e;fd:QF+Jd(V/RA8NED/Q.?&B.MSR5L6
+5OHX-JG->(Q^AcG\-=,MR\7+>=M,K<Hc[LBBM\YEUT.KbYeEfEL#4?3Yc4/TTSb
^e#^+9:BC+g^b9=N.DS(GFFX,VG;cP:G_/3+O3:;-6afdS,+/eE2@<SE):_0\:8;
NW4_agK.gNXSRCE8)2@PFP)[YE[3]Z@LC3TZHO0TYE#G-D^=1S+?^ZL5SF9]O#/4
Lf8F5<I?-:@NN7:W^X)-<O:NNXTaG-;)Jb5(>FT.R[^8LO\S5_TMMCHHe);9A6f@
Y:gJR6-75T5]Q2I^BR4GXbd\_PI>#;+QS@47>X7,?91QS2_D/?A&)fY1gI1&X)(K
Y=V1SK#]eg@_@I4=E5DK)DC\;9g00V4@A0A<,DL81GQ5gX6@<LaFL_f#F<g#f_PA
]8+5UTcH\GN]V]<)Y/\UQ[R,Q7JXf8H3NGaa>FT2HS)><1RSE>POAC/YgXH&b0?V
D4O6S0g-c&OI@T<b1T^=2gS:A._\#a/,>_VIGA)4c/80K1fCY6=D7MM._AUaA>W[
^ddC#H,b\aZXS2G6e6O\RZ\H&Ma.f1-2f:VZ&W,bNMa?P/g08,_9GDRYRP)PRN#2
f=,aUZ#<T2,36F/.EQ]<ab-1HG3beLIJBJD/>.c^2#NE+>TH7):\d;[W[XMQZLH3
0Q2@/KXG/[]L67aObM=):<=+>W(-OM<ZJ][#IXUL#>eVd7JG;J,??:TOG=YeK>]S
<VNfLVYR;Lbd#d7FY[7P\=6ECHUZJSMJ254IeSEE7)/dHF:GTVgB:SXC?,9A66bQ
F5.IQ,.^B74>&R4;=9g526[LSA#:/,/O5[7_=(=GB\e21_37KU_I#H(fZ5MIXS>c
Yf4?BJ3#0/dFS[4QM@CJQWd7J3-ZfG##0+\2fW:-MPP9\TV;fdJZ\KXfdORIcK&V
(FbIGE2>5W#fPbZ.7If9Ga]MFB_2]VX>S7[(0C2b-1G^.ZZTXFbT9;-HK[8UN#/;
XXd\3>(X>=MZggGMFYaDWS-V&K.VH^.9QIOQ0f\7(X0NHgB4.UKA??ZX/>TR3EA;
U[bbKQ0fLD:e=4g#@OF)&A-\VcY@^G7<;OJ\72&fEgE-]7Q&K=L&#L+E2bSO8@>A
:6JP4],f)F_MP70IV^/8=/LKV[VUL^6?6+a2&6F/eJOGfS&cSR0L-IJ?Z[c>ObJa
YMM#F4>g.3PF\bb9D#XBE:8N^#Te[f(@3_I85AV;eacQd\CBYGH]/7;V:#AP]:9X
26/T;)c9dO0CF4Ma]g3K0,fE5LS&G<&U);c#=G)PR-YV09Y5aJWe=P(7XdG099O?
LBg00b-BAgfPSC3IA>b,Za:9N9^;PL(bA3J^.^8I81:=X8=72#-T^>HIe/_C1F.[
AA^\88<-R_YZ=c]?RcPWBBJLeE29DaQHaJKJA1T2aQ6M_)GYSG?[RVA&=aQIT.PR
2GTgTG1TCNPY5S<Cc.F\XU\V+\-BQbVM5Q;cG/a\ME@KZa5&gW._Bd^&E9O9D4P6
[/SIW?^b_59cNc#8]Q?W5gV0-Z)bV9?L@W1UV1]4_F7?_[\.Jc-@=,\<fB4da>g)
Pa&HDM[Cd]WdV)6ZPY9T+]bI2W[Ke[#9M#:W^P5B?II6eI+R/GD.CU?GPC?)^82J
N]WC6^RA_MDXR9&H8#R7;U2/=M8KbSECC#^&7d_JN&-VM&gHW:0ZB6J]5\4/caIL
54a,6aK1NCW3P^DT<W:5)V@+/7A8&VBPRD6]b;&cW:LeL)E5G1Ud+V[KZ;RI41]N
:\d5_5([TNCG#0M6LG_PVS#H3a,W/aDfB\9]B&aQKGU]b\a=1&;>907O\_AANPLb
.D^P?T26f\^eL.D<NBd;IFU;Kg84d?9^5B)K1TXZIHe?5:ba>:.>4NWL7O8G=ZfF
@cT<.3fZ4_bA8T\NZg9d?L.5WgJU43G,]J=_?PVK-R]J&@F[_PD]C62#GR3H\4U9
Ne;SO/NbC,G)SJ44b-[S]XM[Ud/>g:I]334N:L30b-?K0;TTNCECB#^0LH-D,B9(
9?RC(M0AbCJc4V]LdTNA:PK6?1eVdCZbGeDJ85[+\^&d>Q4GS7@[L3RQMg@JU>8Q
,UYDBRG0<4CK:X+a66\92Ad_C@QDZK\W+QQ@MZ+:5=L1QB+UYcOEI3A@M=FeYCKS
92-4.(L(F+?6>8<VCD=3BKASI7RG;Gc9#BY,V?N&ABXD#@+]#9^Ca5d\70cGRX(4
@b40M&K=W+PfAdIb9-2eCWLQ9#7?>B7IaB9@QYXLBU6QK+POD8NYG\OK)aP>JJL9
8DcUIA;MfZ[MST75(L=)bP_11IY.eO_HS5?-7/)]57dGa-33>ICV]4ed7>]7gEBS
/[3e_=_A8M6DIc?1ME)S@g)/XAEGH#-0HZS>>[G[^U\Gc@9]I,9<gSP067F>)=:F
=N+Ld1ICdL]INO^[>3a,>J(68819HJ41fM/XI+,MCHc)OMdXSJfU&R@_A(g-NBCB
P.F1GJ3SDHS.Z<_aP_=g=J+,1eV/Cd(?@9<TLMHB75KS8-O9,X6;:;@ER\fO#1M=
AV@&Tf;YMO#4eDLSg:V1+WACM?cX/OZP)\DEB3VX5d<0EQVdMQ9&Nd2B-S9S@+f@
P,2_a(S;eAK0IQKC(/&?CX:?O9.,)KG?;a3<WQ#Z4\PfALH\R(U3BUVL;P(;c2_L
GJ,X-8V5bB8F6;Ab=F3BfNLSL]BS<X8@^D-M7J,VB2;B-ZLWPC&S6OSgOc+49[/J
Rg5[Je.]FTVSgKJ#@W2@.A.H\Y.8c\LW<?3&PYXJcAT^5CT1eP-0JRfA5WfZ>(Hc
>YVJ[]D[_QeE?F7L(Nf2EX:XLUc_MVT6L+:/\b>0B_PLD/2fg/M^_Uc((e]J\A]K
?INO>b>VWCS_-J67GU,41#M4:9G&L8D0\7XVK[.V>W\K0f.&RO@b1C3Q#-+Gg>4;
O=-c3Z25SZV<,(<LG>K:Q_2DKRG0[gZCP]/W,)UHCSUda+YJ;Mg:KG1@1O9QQ&Nd
IAKS(CRNUd8BQI#(d0V2W+K@#9c&P_^AR9-.]=Ugc86--V[RK2?9,:=-T&Q2A2\C
=49AOW,XML)Ud[D0bN7SeI<M6/)9db,b70g3G&b)5@5?L1I]S<800aaR(@.<,33O
26d=LVT5e\>1^\YUZ:HT]dYW5ag72gC-gAHY^[R3S3L(+MgX&c4E\UL)MM4&0cb+
).aJ.W3.H@]Gg\P6aD9RUc4g<-f6;Hef?#I7))?2J,dcMYB\^1RF7dRGXQBH;/FM
0U[ZV;ZZgXaC7INJE-,,GW?3eEZSZV7.SB,X4<6Ua^FeCSYHV?UO7[WO]=57F&g?
-BfdYV>)+&XT[UC0-[/Hba>B8&0N68&HE:IO)>^F(g>57Q[/)(./&H4SNXHgL,-<
_-ST]@=QC1bOH](.9)8-9=7<5gF-&75H,;GW/#XXLG=RcJPP@4aT9XJ,EI&LYODW
&dIYU:ZKd+abZ;68N)eFfG[^B]5>_eCXeL5^I[FSS=YbL+ecX1,.)581=9FHMcGG
cS?&6d&;:WT7R)AaM(Q4RFF]M73@.d&D=8[W1SWVDY@H&/^^V&>=M/Q>3^P#L^;.
8e2GB[?E<I>a1@?#XIH6LNN8S^P@]:M3P-S,/((7(QUN.GO2T./]N\[SHJ7LSa(1
7\?Y=1=<(FG\RWZg+@V3OI5T6a<6_+dC?IT_N5S<O8J-7>K.G2H3UXV>e\Fg<IQ/
LEea+8H[NB0E3V:7V=9EX3T.G49YaL6K=d9_B\-OCEbXU6DBW]SS(D))(S^<1G:5
487,LYb9^Z8+N2J&Sd#de6RMZ]1()IP<\FRe55bR?0Z0#b47;.Q;:WD@(8faOUBL
WMUSIdNPDg\K[+3R+<e^AV-\OL<FKeX4U.5H6A=]E:^2]U-08f?X7A4JU,KWW5O@
^2\Bb:K:Ce8^6TQFXVe0O@FaRa2A<#Pb@CMUG<S-]<_/bIPFSfc.U)DDTN:f\/8;
INN@@H<6:LbGJ><-2f5&GGY;YO:0)Gf99;[gJdVLfGI7X=JVX;,cNa2=LaJg^?JA
&:]DI\=\NU6-A-WHM#->NQ0HN0006B0.I^@W3?OdYW8TUBYU0ENYOY+O8J5NSR;d
G446-8>B3]/?G?CNO:8J+4Z&5cL491,Y8\9&I^g[^9:NKQT(D)\If[Y.b#D7Ga6f
5])(f51\bK]g4+7M,-JMIOM6+FIaTJ]A+WRfReM;Xc160_.55D)UZY[-+.EfT+b7
DZ1d@HF?4M_<,\4d]d=\DCR6=P^HD2@e8N8DNM-7C1^FDCK42&<R&b4=IJ6HB+LP
T^\=#?d8=F]NZC/(a(BY<8@W:D-:CX&-8KAe23W3?<C3\)P+H<FC.-=>N7[g9gSM
A8Pe:_K-??<VG.#9=dWSJXX#)=@2A+I0>AHLXWYQ0FLZEX]LAV]QU/1)O2=;=4W(
(FNgYL-N\>_[ac5=+8AEcC7.M-d+,EUdE46)UJU&L:fBF#CUW++ZC6d(PO6dW9Mf
9?)0J-\B9C>>#]35];A^EDY)YH6G:H)HB@K_G&2@b6B#.4,0K>?VK^K9]SS2#L0[
;eR,YVFDYVKKPP9D:3F^(<^6N,db^bAbddY>+0&TIA(.?_Y:FT=Bd@#+/C=+F<[G
--b1\R9;<bgf#PG+D7<@#3TX<gCbL4>c8>->2T9HB2(UNc3.(Z/H3daN)TD87C7P
b#IOQ2(eWag(F+Ze[0K)dF5N]<CB-8I0Y_IM_S(<0<Y09HJcOBDQX/P;/P>gbaRQ
:-bgY-ROc+c6I.0?beGDM=f#NN27Q=BRST:EM1XAbc^5T?F\Fdd_87:^Aa-)/GWg
7Zb3KW;JK67I/Z\V5>5+^L>G7e3]4VXRB]CB],4P3D/WSSUdB^;c2fD23KA6T.A_
C?^@AfE3E2PU+6df[VR#36L=Y,gaR+GfH:QG6(=I8F:dLUNc7=HF36_\/R#5#3e9
,]^W4fJ+_KPa?f:31Z373RWPTbRbJb@_7bJ#MBFGK69:[fRb9cbH&IdF73PNc-cG
YAEYVWf#74fC1_gJg^V)F,&VaD[#4]49754MK=2Q.Yb-T,(3C4Oc\Z^\M46;OSJN
).\2cg-4EEY57.JEA)BS-IBO+OH@]B8X.bL\#:@8QM#:YZR,-1Bf#5B=C2f>:D-K
5I2K<3IT^1SDM+_cGN6KN.V,A/Y.Qf7.^:.7c<=Y?0MR-FB^0\8c)cLG?9fQHH7S
M.VeBM1Ca^Kg[a=7[:AcSfOdfHGK[b?I-[V1CQM66EbVFF1[-2>^-N=#-gF4b@1g
^,UB+dC&7GMPTPKad>KF?7W-)IK@P<.FCEHH=:?N8?-931X87.K<9GI9?Z<2RO7X
+E5[.CXAP)LH0MXcT;I51P0@/XC@LT\PLb@bY]9PRFAT@Rg]]URLBEG@,;?9GPQA
[a,\:YCMHRA7b[FVK=]]_E_^N[)&IK7#PGJbL0]TL;5U+2(>-J9e5.8<Z.BT6ZV1
TIc3IgEH+[M,T\MC&4N6?7IeS2YOG^WJ)fRa6gg&N,KZK2=]A2(AG.F)URL-@+=J
B4T/Y(cAO[\#g&7[^G:IB6Q:g2SYGVB5f1H4AOMQ>SF]/YG,)(g_N:d8:?a[L<gB
:K,Uc)O((c6WdEVM3&KUcR=I,MNHAJ8gJ2>UD0\(_F@Z#C:I5.WA3N(00OHH1Q7D
3A3;\/+Z]=V?><CJ?XA.EeJN6A1U&RP)R[V3(CN9N5VfRS?7DSU1Ge7_D]92_#Fe
[GGH6C,&7KTFb+Z]O7W@O42>\#8cYU5KJ=\C-]]g@gW]b\.223HA4Ab\V44=11gZ
DSR97Gae,]NCUV&M?(N[Ig,8ID@@G7b61c)(<Fg5T^GLTW3(G,-QI5M4eaHO>-[5
Udd>[?+R]R=QOM+:WWE,TJ(47>_BL_(_VN?<65F:\50REV[R8/V]AYEU=QIN=W.<
:ZVJO8P=W=#<N1<gZTIPA]LO.(L=T9C91dB=2^LL\)J7MKE)A6.]&P=L@C@?TOXJ
d2?7VUQJ\W0cIHJR]g:^7J-Y<dN_CV01L3UBY)A8<3R?Z.UL:f\V^2Q13?(7,&A8
:]8\cA1:@[:,d,XOc(SA-d^;L9;;<eRPYB,=--+\,]O1eP/SV(HGDHe[Z-fC[DPb
YdMV;&<C4dZ/=/SAe;NN?W?e:K)46F.b6AEW-JQ?fD=IS>X@_.[)aG^B_^7,N;Uc
/^\HDVQ4,_.c(P8Je336B>\Ec63XN1^U>O(?J8NgJ0dF9^7BM]CUF^G^/;f2]CV1
Y>K0SBef#WYP1cX\S:NP]UWX(Hb]Q;8O/FU3IWXV7FHd)\;/V3bdbG?Nd9)M#4).
5Ne^<G\66K9^FCb5EG3:&J0E(:2,F8A?2--P_e.:,f6RZ+OZ#D@7GLH(;79O],VE
;]>QFGEb#,a1)bZ;R?LM.).8QB7L]0]D-1bJ+fg5\fKd,e.UIgVZ2#Tc5KG<TQ6N
QeC]5<=e3HZ1EK8,#F;+3f/Q@XCgF@+P[.X<b@J9(.78QOQ-3f:?#TPLd:<UZ[D3
3C_]]fGW)@-I?S5E#bF>X#>DU:Ac8C^ZBg=gb0/PL+NgPU2)U]SaDE1be?V;PT4V
W5b[5a_9ZZAGAV^4JU=dbLG7a4bMAHG@VLX^6PVN#4-KBK31DP8MO:A>,fU_,A<8
)G)I.W;+#EJKVcNK@gO7PacGTdL@QJddTJ2BGd#A9CNb2TAS;?S=H;M1&N-f@K8U
SUX<g?XN94;<Z.b/McXD\(02GR,[G@VfBJ),)R#=fV(1[@eE/,@c4JJXJ8Q;FZc8
]0B[8@V=,Y_IOE8I?LIT^_](KU][)SY76.Z09ZbcA\LANSX[>5E.UgIf=/^6^N7H
[];FU+Y&GJJ>.ePBNLV1#:2bPJ,[^MG]b1d0N)X)N=8PDWMd3DAc^VL?\RMb)I<Y
@ESJ1->KWTR3;]U@N+FA8_Jg@dW?61A#^SB2&F;Pf@,YE.,^^+_@&_M0YD7e,3aW
W?5)KA]DM27<0(.\_T^.Nf#>2TOCS0)-DeD4>a47E0X@Y/Se6-&>BP6@++M9Y<ST
W2.7;;/3?;?&(:2C,fe=YgKKSP5GYOPG>Mf-[.G=\?4\C?D<>+_S5_:D)#,_V?EY
YQgP.e=HK:4aOaICLM=)(E<ePWAV20.]J1UQ2XVC+Q8>ZEL]I]C-FCY@N5L>GS+#
K8L9OOVA;b9Y]@Bc]H(GDRZB?,c][D>f2E0V?2GG4g4K?X(B.=5GC(CSDL?3K6/X
>0FR]3G:LF<PFL?Q)I5CQ)0C/dNAGM@gaFKM-1eB9dF1LN<TJC]:9_)3LNRJ4#G_
L-06K^C:gKI#,UYWK;81\27#ML^MFgE4FX45L\:OJAIOLQKg3W9O9cK,,a2)O]A8
N4EIf\.aKH?SIc&[K\GV.ZD<E[8:acB0S0Y:B:BK?L]]?X)/P_Z<LS-M:c?/b(1-
CG3.1=BA:HRTP]2Z4N(#fL\&I+&b-<BJfJV5g?G\.d?ZWF^eB=_<aTHJY8(F.gaf
fGVYB@&IG8QC>UZ-,Ub0H2VcHRJf2f^)dN=NF/DO?Z?FH>VB0L;2?.W_cT^Ua5D.
7@KFZ_P@WIDM;dDFI7S2.Q46_70TK)5(HZT9d3<\<BS6X8VHC2A9XB5)0FWd,46a
UE&EY(M75P,fO#W96+5X&K(;\?7bYe@PHdEMM=M9VQ/6LU#H@6_Y)g82-9]GA2>d
)I;UWQYJ5B,1FUC#e&<.=DAJS)2:3SYX1ZKg80K#);.<Y3VE/.S^ae2?[/H&@@bY
G)O;dUWbV4.B;DG-R:.]C9\@@CF)ZA).&:WE;I)T#7B8N])+LH-J(L6ZOb_999KM
RP])gYUH9T?aFf3@5_+(VV20EXY\UET-23\BBIKP+DgL5c5^gd/d[TAVO3B7S]AE
F8NY?aVO0Q7]S#I&dW)a_T1GLEUAIP6)4Vd\OK_;/NcIdN86_RQ)fY#A:;aV/5(e
^>T/A@(0&ed5N5P>&<<L3WG0G1GBYJ.:DM2@YgBc(WP,4.1?E@]Hd#G49g-f5)L?
1X&+@Y]gW??C#42E>=,N9]C=>/:3Rg0C#_aeACCF]7[-X61U09UP=LY9L63J?ENc
Rdgd)e)\E[53Z4&Lf^]Bd569bY?BI#,1P[5OR4YJU.aDH^<F>La</Z2V@:#fRSJH
MVYJNS8@I76?#<,,(Y-SHZ]QC.W.>e+Da#e.c@),CEU1(OC8:J<6;<AV,UNBJddZ
/S\#P,_eZUdHAg)=8B6;G&33bVL(L=gF.-g.N6L&-T;G_:S-2DO+K&/.bEIH4>6#
b\L/37A>:<b-A9-@78Ge]D_XPf18^Z<Y&aIQ@.TDL@X?:X7X0RGa;/c&JV9NT(M7
R_7=:FOdb0c/REH2?:dD>/a/[>b\^&BRg0;c]F(QeMBLGW,ZVND[4(Y4]W7S;P\E
0BDbbdU1?O5ATPRe#Z7F2g+V1YR>MM^1GAZ-0>&D8_\;BOS;B36@0R#J?f]-[\P.
M3P_US3>a,Y.ZHg,ZfPd>U3+X]J&#02<PT6UB^(:-78^7F9,JON#)KDK+JGI-Qd@
3f<c:\+?fY94,;.Pa&?V,^BCH,f<gg-BLH#MMMFG7bIB/],53)R+J1Rb>#-7K+8Z
e(/eBf_9[07FdF&Bb<3R[S;IM4N,I<Y>]Xc#FF(dUc7X7(?0OI:S\H>9DIHRZ/_Y
?EcO5KdE:EQ7DJ(+LCB,ffeC#HePZ;\&c=)XVJ8eEX5d;^5;C02cR)1f#(69<H73
eR78eC6.X[Q/YMcJV;eLX#g86/a5[fSWWG&bBdQ6\gL53Q4I\D1_f3dW5)CIU1\S
J8VJWOGL;HKR&LU^C&0QSX4&eJQgH)D5.C(IR>(aY_dHJ4deCC3e:IZ9R[/2ZXHB
>([T/D8[3dE+XJR(KE8NH5.LT3Zgf;G=NfC[4_>Xa<ES0PUNPRBD;Ocb&FXSKJ?1
3R1=dSVe3_2BYa?SRgCD/>F8Z;?C.0\>G?6QPAQ-d+RH+@@_0MA0<>d\VX:)J1J6
e<WbRSJb&L0;W13Y5;V4g?[C/DDc/bEAC2?<U<:5dKO.F3/U#TU.@D95g2U([cH>
Q2a1E_WQE:G5A=,M.WV5Pe89f8141_7_IC6EWf#/N>MNT.+4Md0WSdHKHGJ>d;>-
(,&/PfM+MYfR(&b5?#)Kb/O6JL0,b4^(JB#>F(=K^XTf^&17>>FAC2=<WJe5;a(c
8[_AgAT-W/fG^&?R,[0bJU\:c@RASU>bgML<MNg/?,[@8S/[e=Id04_3=GfJF5;@
\6I]cdG?D]\AAAB+3@</e,@dGcJN+dLGEDI/Y\0>JO5K0;BFLV&3[06L))b8<0(f
8-Ac,a4=LUNJ@,-K4DZHC;26(=6aAcBQ_K<6d<-F:KNCDES.b3:O(+H<?HF_),8=
bAJ=U&8?FD^e>Aa&S:A^ZcH0ZAL7V/M#cgbVJN@a,S\\@)<4A>S?fJ/S]U;D/c1U
gaPeI]58D8eUL)EV4ZB<3)3?[cScFDQD^<dR7W4d7;CB:c?)50#MP.KAb4D=>@CO
K\1.O:/_U_IGebEA)<DMLQ4NZ[1aZHQg^W]ALYQ7,8R3OZ/K]8MI1I<KLNb37AWG
_/_]E>SR&CVHPXa^K[U15Ubd6V^ENI=c6GHN71E7b5_>eG)dWY8f,]8TT^YM#]SD
9-:7),G7Z0<A(7<cbVCUR-?#c>9PfJ.8f&(_U39YQ?T4\:<K>#/(.BMG;Ra-R9/F
NEYe9W4//(RZb4YQVRWH^ONPUI0Yg_BVcPPP_Y.8O;1a6Q]9QQN/a,3B,(J-[e4I
1GEUQe7Rf@?MVgeW5/0JeZF=3B(d4+e^+8bC5+O5?f-\aEf:BFMYKQ5-;NB7@V18
?/)Ge/6)RA>(FKJ);^d_4a)-#BcWDG]6W9XbK;.5RKG=Ta(C[RXX:EcQS/K?#Xa#
\Y=LaGg-Cd.93)&X<NTP(-,IT7=(<,]Se:F[51d]57>8IXCJ_BBW(IYL^WRDLD@V
b(eY+?IEL5+)<Y905UA=PW^7/AbH9<Z=3_(+#U\YSeH8GIC?b9;;/gTDg.[(7g_?
GBCGeM4EL/RD7-,@VBEXcCQOIY7;Wb&HP\e./?+cUg+1XXRC)7/:SV<dL]KWUGO&
DY47E9,><@T4T:3U^7J[(_PUO6_c_HHV?K?NZ1MGM\?I-f.&g45/gR_I]A0ZB>:c
G_^=_6#U5gQ._ULcQVR(7RCL1Pa/4M-HFTCb/DUO5AgY;.ZK9O94G>A)a>F.Gb3.
7Fa>-+;?OOAb/5fa=8^#@7@RO7\;aD.gBLc)6)-^?JK8dIX=)5M&KOSMGZ(G0IO+
QeM]],F9Of\;18;5;\Z\M,;^<XC3d/^E,.?\[aMZP@B3N8ZF/-4A:dWYc2DCcJPY
[c;dW:6M#?1cDf,C\[I;C)_d^VSPRaeU##cIX[[LLS1+=]3(a?OH:#7OTW1EB:Lg
fG^JLR(c_NJDHMCeMTf[GUV9Q:ACC<:QDd5WSKPa#DI><D^FW8@,cAf#g1+fSUI_
)/c[R.:]R)]<T(0S4f=[V?:C[A/de&9S<B)3R[ED9:.g7(+&L_fB+=C&2VC]f_W6
O4\FK9a714F)9//1YJ,.B:H5C<(C#g4/,GNQH7?@R#f980E^](J23Yd&_U7U64YN
^Ng2.U,dUa:c/Q2-E:NBN?2>cF6PC+)\@>7G\F+FT\0FNX0U:\1M)\MC.Xgb\B7A
eBT.OM><_T6;GDJD&WCSBHVfNK#F9(a5QIMF95dV028R7<QALYB=Cf821#985f/H
1LYS<G&e]AR3->HO#YPa;[2<546]^IdA-0P2A[&Wf>=JUN/c5[W2Y7+dS63S2da#
I81WgbU.e/CeN-2J_4),/afaW+CaFB1c.g,-f;S0I@W?6\8#aGG=6FSVXU=<aM38
+Z)CMG]fB]d09^ab15UBQVa6]XRb@6)UU(>Cbbc>):E/LW?^Xddbc0_RUFDPT(\8
;/Rb@PN@U<:3OG=L7G]4aDSP2=XV-<&9?S.80^O/LFX:c^?L(;>/T,aS\B:SSc9N
d]O@caWI26aeVNZL5[\OG((_I2Na:Xg0M>BB5/I@(/82FV4?.@);3#2O1],^#+QQ
MD7N@X&UAYeK-f1e/GILS@=cHQ@Yd:VdCOSGJ0)_.KL5F65JIW?QOdAb(#GY3CfV
>B-W)Qa&DQ-9#G85TQ_MJ,7JCP]NE6\V([a5Aa,K9E/Ng@=674BMDeg/c)]T3H/E
Ac#,S1eH]c=Z3)Af.Ia1a>+^B,^3[L)EdQ<aSQ_:^JA86GBMSUZZa5dUGTZf>^Ee
UEeW9MZB3<<K](Y?7[SG]gBE-V<b_OE;8D&K\X+)4\&SZ,[(Y&>/=NEM2XOUX^:(
/Tc#_@/RPW:0#2?agB;,fMLXG<9DdT__UN8F2QEHFW[/Y?IPZ5OSI66fEVOdR^MJ
GC9b16<D=O4T?L9\ZTgR#3feJH1[PJ#TANR#]e9BFYV(/RbT2WZ=H-./_Y7Y>8&?
RMcFI/W5HS?dB7d<30NK?](NB[(gAe]agJb[#,]#g/O1IIf)OBL=KVXZ-?9E_YZ-
(,D1_bSR^eYUWLP/e:XFYRV20+09&FZ,:=_\)0-:K[B=>_G3U0d23@P@B#FI>_FA
bReNMb>\O;@aTYBfF_\d:@#]7M@)8W&^+-88J/Uc&[+Y&@Y(72S2dSaBQZ^Q(X<b
.Sc0K?VJ>,_G[fX^]KOP8CfEHG(WNN;U^@9&(<W+;f0d;)>O_L2a-<1dO]_+gI1.
:@b17L3:NJbXR2:=H2fEeHaOdO4_O(>J:Bb/F\B7)((IAaH1c7Z-CeLO:;Y3+;B.
^XY9)>P+8LF=<:2fedZQ2P[&Y,T0W>,EH(_>eBX1O_\J8_D;&2G/cEB7eM+E+]Tf
LGKc70>;_SCD/8);E-M&K=KcTS-,eUKXA-:VLGPQM5+bR/fdD67)J/Rb\VcB,a34
)[-K7?_T857/.A5Z9>#TaU,S88#//1dbAC0H)J-RP=]85L5@O+J0Ee4\4GHg>fNL
1PX8Q8f=c95e4aQ9RX4P)0/aKcCU6W]KG3W<O@:cP^9)SVX(+?2#;Fg=.8[gIgR9
L7ba_EVg>QQe>f;0dB:;80eHY]K;NKe&^/JR)_L.=(V=6gSaC7+:JdSBFL,A&IE@
?OO2X5bM&1V@,c,>[)D2M?ZBSD.N:gT+bd.D=?\9gHFB]B(Y.0I\MG(3O<7]BXWL
aGWW-441=BTcJHGVF-,eGDcd#aeNZ&Xg434g4AC7Nga:9X6@85;E2cM,>YTI85D9
PK3C1NHaOH7KbWUdD7a)-QEPfC:TIICX\]J]XWSUbSG.HFE/<K_b;-2c<:f;(NeL
Te8,eg57K/eNGL\X#IINX_]4f5F<WMRW>2JB9acHe^?Y(0IT:F3+JO?ESXMAa#L8
gIOAQ3[fF0^_^0Y?(?#)2gHIgU,,6(d;[\+e>B#cJII@^3a5GB0&Z5c:D=TMKe(>
LQcG]Oda>R-ILOW=7?HFfde1MQD8STb)]WOfA=N-FKPa=RPKHb.R]e]IGKU99V)a
>,YCS^.UZ3<6UcDC5OI?3,RO&&aL]OP^C,ZCL431V3-EH7TRFg2]/PMd42b\.^DS
QcK3aeYd07d\&gTWe><C0=?aE/D<TZg?c<PB?eKTEVAdEKc#8d@Z+1?GCPUZ7^Q<
3DNf:?gJ?9PO]Ob:_Q2B_6)BeL]QP@0#51ZSD[<]&AS=KR+EV_M>B.@;\<.FXf_2
#&PV,SE08eJYKR19a=O=b,d/KO\48A#aea3_<FHQQT#Z-T3O03d2(7cC7a196:f^
1fY=e^9(W(bUP[b5_4RS2aE=R_JK3Ve:9Sc\^f[WCI[b5<CdDZ04JSVOCW/?^d?c
=U&TO/\MRb_B]R>Ig?.9KWJ@3F_b9fYEUQ4cNP)B?\0T+RN/]d?/)DLbQJV@\P9?
Cb],A:+AS761^2eb;\,7/[]?@;;bWI]\=c(=W6YIY<6[?aY@g+0f-\YYG1/[AV>?
3Z#8H>+@OI->XZMQ0fB\6>2H2@3C-9#8_6L4>[d&A+(CfNKI.GffE(.@?W]R,(O/
G5[^S:;4;8Y_&LbV+B@])ACBVF,Gf_]&_C&H3=^<;F^eCfL(,C\=I;agAc50N)b2
c)W0=UbF3)XT;8VaeHL3,2-MO_ZOBKK+I6\++dIUXQYc-@L0XNA.f1B9N#0+^>0:
7FXFESQ^?Hb=b=ONfYV_U&V,K5\<#G.OC0,K5#4J6Db#V0.VfS9Me4UVJZ99+K.d
>49LU7BHfRYf9;95a4,/T(M]/(YMXHZC6N81:ZBVba[R7D1V>M46DD8CMYQZ^=][
])/fgPG)Z2[D)4CF(ZDE]U,TOH,f/#-)B/gFIZ:.?7Z^)@GA2>>4QYb#1UW6EYF^
QgI<b#Q/d?4gS?40EMA3E;dWNE3.F5f-2DGBf)VI8?^[TfC:#,DNJ@/^5CEbL.PS
TeCN5g>a2N8M)K7G4-K876\A=ZeC5c=S;<;4c-CH2Ae@5<ELY_b)IYLI]RC8Q3]B
II[M)J#,MFg7#?AcD71.:EC#cbP;IP?A[++X?1@1H;+gXB_/UQXFRNcUWN0/7#O8
HMeB]?]A;COAePg[fV8POHJFWDUM2[fFB6g^EJ4c:F3WX_bY,6,)N]-7L0:>I7(1
,57H]T2ab42J^OLfad]TMDg>N3+-D7.=CLHBPc-;Wg?6;Ze#U#1TSQ<=.5>bN]W@
H+D18.=SUV7IZ6eSbQ7aXN/>c8Mb__O)c43bd>BMN<7T]/#+W<WNGX4/D?ec3Xc2
4((98RME6B-;deBV,GAGN2I230f^7A1S#\VRJ/+ef(I#8P4#^@Y\<]7eV]4/RYAL
@-8IfGOe46[+MFG(GZ50D-0e2BY\C<>P7=CPS2:4c59Y6.e7&2STG/TVI3ROTYd9
g\5W6I2,ee]3NNGe-UBI6KB;]=gKVF1=4K_(T?BE0T#J#8#E(d.Ta,U89\A([;4/
3>;<(5:47-<1dM\@=:>L5bJKAJFT\JOM^F9&W\P;#Hd;T),;VY];e69)RN?#VL<f
J?=dRfBVO0+Q,g)E1b/\dR,CW1R)WMI:e.,TGSC=afYMTe.\XOAe,B=HPBGe9S/)
dA0JVVXB?KgW+Jd)cO_\D2K+cdcdK;<OY?^SBH#)\W20Zb=)DP05F+La_5M7QS;\
FUXeJ@7fb=8@:[G4Y)>XB3_9/6K[I?H##KSd0?#=+X:]<Q>MBSXWDYOV.H@@+<0X
//9Sfb0EK>H52g=c(OHM.]Q#X3N?9X[_Q7O8HPeL?:O4ZNAcF\&.CRUda(Qa1#;U
D);2/Yd?gIGD6f)6<f@<+-TU9)3DUM4=Z-#GO>[]Qf\S\,ZQ]@;+dWBbTOe7,2/Y
B2OEK.._M-B;PIOUYa^L/WS^20BU32O\4X4De#5BfNJQ.:]#9RWKcX#J;&9[e1GU
Y>X@K>SH8V7R8^T(4Q>dAF1?3e(2/a]R.U#G?KOA8A3J1)cROBOS=P\OD=B;XB]2
SI1Yg2SMT/-#O[4>FFTZ_N8;c@2WPNa#@XQS\e.;[IN)ZN62Q+#3N8^-T,Pe6G]g
N+,FH\UYH\P\UOcI[N.Sg6;Z)&(P_f2;4,+:KaCFSBDfSQ&_@=8dOOGQL6.LQZIL
?;J-cPSITG8ZSF\:>f/1)<2]14W4NcXO6XRP_PDEB0Sd#Z,HceQNM6ETLZ-e[2HV
2TT/NDOL_EX+&+T9.(P-^D&A^ZbY5[b@?TW1>:]Ka)BF:9XGKHL>c<Ba;(VR4JSA
FO20_ZY-eC=6TM+ef&<>,O8\0a>\aD-53EAL\T=@DTS#VX--Xc3QGFU:08:XO4F5
3@W?<[SR_Mg1]JX:0FP/.aAgg4E,9XD05\MZ@<4[dB-;5)2b[8cOV\-B2X,,QI;P
,?+]4@-9PW?7:YE(D1eO[4.^+(dTA[Z</OW)U+LbgY-VZa)H)#[WfY_+&J.6R9FG
W+J.8/Bb38\cI[TL\1T_.7GbZ,@8ET7-GM@H94AZN(L(T.O)>UOZ3=g7[\@9Nd)E
LT1E3L\&OL;NPD\Y\8:T2I/R_NB0RE83D)5R.)D((8D&#IUbc0]bg.<[]b2C1URG
6,,N>.+,5<8a80N5BMaZ#cB<&,/R#dN^F4VQN;a.#Y#X:Ygc+:3G6[J(7BD/:5==
TgY=^ZM?D0]2aII>&=eM?&ED1g(]>:?@U/0YS,6KI</X,-,@M?V/QH]^YHJREHS_
XYE=(4PR1=(G-V#K#N:@0_Z@8J#>9de3(C[V<AW8>E1L:fVe,,R3)c+c-J<@1W?Q
,M;g,ZF&ICNLX]9Wcc@aP][[A_M,P;d0+AYDGdg,&7,Ra:KM,\?F[>B6;L[Z^Q0B
/^>c.L_7.G\+(:KLNA(L3&<E.3DV0#6L14[HDF[/LBOHceXY4=+RN80&^McM2<Kd
(e6^:^^M.>2]6,6R^_B]c\c2EE;^ZIf9(2#eO><_RHM,Q5H.B>&:).P_XcLOB>P?
d2@-33RaGM/2X:D3Yf/HAM3EGYK@S[)[B#Y+_?e6^cU57C@YFAJQUbYa\TAY]NW,
U&A>.I<BC6T2:)8.dcZKXI]ILS12,]KCZ-[:@?Ba5gGV_YBR?&O\MR5]<d6d8aNJ
7/)MR??A>;DM)RT=3e9W=MD5B>@78eR&1gTI]W;&:]?IXN2+J/H^b8U5\cXW/b)G
C^PAa8(F?Z[a;-S(?/M78ANGCI#?-DKV9g1f7O.E@1W2\W.R])1L)#Q==I&0@0S]
RS:-/6dFLX8Fa6c>SO03=bOC<5;G3aG1#:f:\F@&;3?\>/bDa8&3Y()KD66UW.RM
A2&HRQY&g+6<7SDKX:7=;UVV,E&>R<A4:=6(e@<MYc.G4G4cEB1]84=>N]=/&2?_
aD8H?WO;R(U;f>YP?dAHe2>7WCJI.EEP8P&gc_ISBJ9LGB)-g;4d#Z1GJO&fZ6F=
PET[W\X#5G^Q&#JPeC1(PI8#E<291]RTWcH:UPCEE<C(KBDg4<4GAE\07+Z7&c@e
ECJB4d?cWdA0[.I-/8@\82Xb>,]/c@62X8VWR)GWg;59:1=^L7L4^:Afb4HBW<RQ
NdaR(497\[SP/C&Z[(P);@TS67]Vce]MQ@OJ+5WW_7P3C^JPF#;[6e,U-e)]MY>J
NKIARH9_BPdKD.V^H_W00?LENAC5/E.2(#;-P5S4g_Q_<1&F@TAY76>P>G^1,A6G
,(\]56WW?AN_JWI78&QQI.&U)X:<]8-()9SGN>=J_O_X5X5NRP9P^a,VDN[+>d8T
].91&<R5d[GMY4)Fa.122?1fM(P\<JS-.;IND[);4K30,/]T#)f>d91F<8=XPeZR
;7(+&W6I;^B#DT9LV7T]ITR:K9V+IOYJO,cD_#&T+(N0Y6M_Ie=7QK1X>U5RAeA@
_K3P3cTWR5X2ZW(EH8NGZF25Ag@HGR<fH)ILT]B_JMZZgRd@&D:<HG@P/fM\,^>R
E>]?8\A)U(_J).OSf4<5A1a_0+3IIZ#LF_X\c/S4&11WVEDYD]I(_)8[ON_9([0W
34WX:=OW31F1HcX[9Ka@[L\L8#&]aZ8LXFe;:4DF4c-K+OGY]-YQ/U@<ADR;Ce.?
&.bfS_F\=/,9GQ<O7,RH1;4f/Q-d_0^KaER,F0JDFJ1Y?^[6Z]d;Pd,NV,(g9X>N
+?6K2#TOd^;=C\+0NY;?I-_\\)J/eA-MMK7<6)&@8ML#a:UU>GWO-]Pb_2(=XBM9
c3F_\^2:R0)NFM&\1A(e]4^0@),8,F;GJZBJG5BHUKf_82;?QcEPF<-.2_YF,S@C
Wf+^b4?g73<ER2CJMV\5f[adJg/B5/PZU(cPKGB?4EMPYS9Q,ZH]G]a_J:7#eX2E
c+46&1M5<&I/;d&T0H5[f8b@=1=CY)]JR^Jb?D>-IZBTeg=3[?<(fId@_?R&HPYL
:g&EH/+g9aY:[,XG?/>@]>^eFKB\@;+5CH?X5&7eF;IZX8fMYR:6Ed_^C5eTSfG0
_U)Fg1J<TE#UI.F^2(^LC.5OZ5=XUB99_DOU5X+g7DO?(:)^?(6\TO5-(H<DUM,/
WfSEHbI#:U\dCDV(TJ2@&aHL>J3Oc,K3HDTb>Je@^ecTMZ<YG#X0(&f=VJZ#1)a:
a8@2>#E#[^U97?dbbO]CIG/>L<3Q94EK9]/OeELYQ9173)?_L4bVIAP+VFDF7EU&
\R8]gY<CdJV^(afeK)f?3))8W4JC6(92WN0.]II:RHIW]3ALX,[NAV;50e/g&-Y&
6R:5LS;_-PM1_CUdOCZ.Eab[CM<AC1#]\N_R?V\9)X1-Q4BA16G?B=B0D,C^XA46
QaE2c,ZXbQ+]OIG.F1:OQD#O:MX0CgETS,E00d)6C>N5#CCR-[1_50=-=faBZ[La
VACcc/g^95Q,KNVI<D5L@@7D<6-<:@FEKF)9C]O6C_M=(RK06S>&MH^6T4(/ge+T
6?47S6)M?NCEKE_e\d\B1B[IB?+RW<c+.,:3IYZJ?=GgFJ)#ZB(WX,HMaOg0+GDB
>^ZA?;[+V=@6-eW,Gd+:Fc/Y]9;&P/Db&b/3F?5YWG59?WEB6QTT/2\F(3]E,#5,
8#Vg,AW:S8dCR62d1VJ9WZQ.P3c^[1XEN?@a)f&M@@BGCGT#<=G6G-U)\UL&<Nd.
@6.<Fd&^##J8CF>O@C)?LXPRNegUBVTLF0#D?;Q]b=JG:C.)8>NBY&1XF_<Z_(2F
:YEdWG^6P10(6CMKBJ=7DdbIOV=+?/54CMQUC#C[3QV_80#[UC<U[e_G1e#8=MQQ
0A6<8NXL[+&?M#:/(&]#W61DS?dcL)DM@<?=5:7-b[9LJ,,b:0]<4)FLPKXdTGFW
:Q##[_)H[LOLA]S()3Z?.GMQ&)=>[_?(f8^>JbJ751Y)+WcA,3\6&Qe&4GKW_Z+]
b&628VOSV8e29X/)Q=QGc5a:?E7OUDTDU_11S+N&--HLG44J3+R^ZEZeCNF;(#SD
2NV6a8+9>3(E8cIZfAKH\NSOD_O_]+^JcZHD2b[0?;;a+CXgb+GBK44PH>;:=63g
S@[NQ>B6([GO(B8>#6=8VC3Z/6&DPYJ0-0ZX09#>,_6KJR;T[9bNZD;([C7?aH3^
:L8/d&+@=fgI<fS_&6f[HOfc][,D=N;Hf#.B_678@HW452fFW&(3=VM@SN5]#a@;
>DV)b?6+g>2aJPHA.E7#a/X&]_PMJP)N]D7fg4Wf4XD3=@@&;2X,O#d[HS9B=9eS
,>?SC:cQ=3-SWc7^1DN2]IJY(38\8<-M1=W@^IHJY)4W5]79S967UeH/K(>M[D0P
XdUUV>O/ZR,56/-+N>e#L7YLZ=,@a2](S43C.Y#Z5DRPZLBW)[S=JNgXNb\R?Q-:
Qgc4RZ3?EgEZ4e[A.>G>c):983P:C>VV2]-b-5f1a3-6@BAK&2a=7-_8HC&RYX.H
?Z_C/(>(+]=1\D2Q:?DEB:8DW::I5b&V.BA^?IUT]G3PKA0AA+EA6(fe:P63FXZJ
2HYK/]8f7d?GIRC<P@V#Qb3283BA3Q]gTRK8:ETa;-Gb?_G/(b-+W2W1Rb8c5+&O
>b,G[G[gC#DP+ZDG0X5F+gQ@+#ZUHOGaXA(e6L4UY.//=MGgb8JgP#0F]Qd:ZL=1
CF^&W\KKOYRX8d86TN/B=2?;_d;^5&K,DA;T4MST0G[9909H-BYPKJ&RFG/:<UcK
)d5:TDcf>KJfI]^f(948LOA<\H&12YeT@T66\7]8(e2-d&E^E:T620Q8b-KPbF/.
g1aOC.7@6SRFJRUQM>IgY5]ag2H:B?HP3>Q01@8,TEB]]XY_PL1_DT)ZA_,bc,>Q
g_6A29;-/WL=WSBe6B<Jb5QH&2^Q\2[OM)#ZNR.aURH.gJOQ;db5W+;[)^LM(;,H
@Qd44^IMXeZ&@@,NVA]a5EPZ4/[YK;TI70F<8[H.S\[e,YK#\EBTL[?_21CBb)M:
<V1CW)I0T-a\\_g)8cU5HdbbZ#CV@E-a2@f&efN=4MN/BF,[X0]ZG9F?Ic+N5RE0
Qe0WH=\LM?XeUXY;KIO(8=D_O[eJ=3BF6SX,A>YD[V,c9O+Oe+I>NM\0aE<HfKOK
R,HXCO1e?<JdZN(@)0:#D^<B4SDZ0YUP8C1K];4IfQL:?J:GGE[QQ[,C=RY_)66e
LgPcSYefID06I@CLU506eRLTQXU1O1?ac8.LJ)Ng1d8I.U3FP[.:c^&G,6@(MOZa
=,KZdN#ATdeD=gX1MCNWOA,]4AUC?cDU=G_.V<YTDVWTfc,ZU5>>)B-QAIG4R3PL
QXb#IWQ:5YeR2]OM(<E\2]&<2?@^e4-3>)J9CD2HC4(FIH@ba&BCYQP@:/X:#/.g
?8FD1OM^QR5)E_(L2+cYH8VQ03Y_1LH3DbeA2Yd]QU,gCW/\SMC8YT07=\=,W[3<
]EVV[@-#cHG5L:d5Q88;YCTJ:6WYb3&^2/0=1C(DUL2,THZf:DWWJbSW0]^Y3X7M
CRd7)S7-U9.#F/07G\8Jb9=T,<]7T:XTHY=DPcf_.8]V7fX_I\+RZM1FGAH-IJGS
&X0?L)N1Sa@JTXW-]6_I1_,HN#8Df;.K2O;N\7e;EcORa;3^&7?_VI-D#B+dT[H,
2]F44e\[f&1b,WdNfc?AN<7@SZEG60,97NAA<NT^&6JAGO[KYgXENAV/T-.AcMeU
X\P?7_V-dG>5:X>HY?[[JZScI\JaR8b8E^ILS/+/W(::>KPgQ(3VO9B^,-dTCP;_
@VXc-.\OM.c@<\#_4dJQ<LG\4TLWT>-Ld_TB<&A,?59ZcHQ>Z+[7T#bZL<:HT7.B
/K28AU[1C7fJ5I\6(&+6E=X5^^[\PH[+3)0JSB+R\>+X#3AS#<Mff^f09gFD:KEY
f\+1U0<A4E>77+=_^(a+b&YKUIgUf/(PD:]S^a#)1.O<;M0\&e5A<Y/-&URg]0\f
219Ce>J^1HfGgO\5UZZeQ5PKM;)B;++N/^;0R+]F&X\LSM;Zfc<:.._N=\HAD?IB
KEBU?1@c+Rf2UaX36g]YZd:+?^(bL&d0/Q+_7P)8P@,&RaFBdVdUfRU.^(?4d3(^
K@=#N84b1@248ecUBS@.d67&CM.Q>\7OV]FH.J4B+MFBQ?X.,(+0T<(fB\KCCF>b
QAYPLH.QbHYe>+_fcU1Ybc5.J_LARVC7QG.[,[Q0BcU_W7V5)5_8W@=A,aHY^RC2
0,O;KW[;1G<SL/-NVK(c2GgWbca)8bID(LTLZDB[A,9KH:R-P8?3OP[B5c^c?c:4
f7JNTKA]g)Q?)bI/2XRTdb\QDE1B;-Ee1A-ASGRW1_5TZ)PBPH,-R0b,S&);_5.P
A[=TNWX8T,.\+4_B(=O22DW4A>)71[B@#DU_^;#82)K;_WDLE4Wf-SX.K02EfT6]
fUH___#J,_T/N?:I>WHd]5#H^5C:b4DNBGK,(KMJb>_<O7ZWg;Z1:\9#[fUVLCYW
+(7(.JJU:@>/7&G22@Td.-BT7,9\I>@ANFW^MUX>E;V&_gJ9QV\.0e.V#-&@4?M:
81_.:4Z3^)cR-8]SfII\S&@&NcX#H;@)+\K]0R8[Yd4I)NZce8/&1);+V/,Tb3V1
=6ea)Y6gD7W1#]LU[<a_6F+eSND][DW+O5973^,WGeC:RO\IJ&]^]6_#5]^-=3,/
(U46bXG3(&=[fP\,P71+)+b65[=]/Fg05=N6XG9f5aPfC0F0S?H3B>;bd&S#P1Pa
R4Q+OX,RQ2GNaQ_3NaE>Ka49cGN8)2=JQg879DI7;c/1[.NWOQW5X/;d[d3(/bYD
<>K9THV-gZNZIO+0X(_IT^V=5MY4Xga,gJNa<E6Fg[U[]be3UM;SVee=-&:>WX.Y
d]8U.U&ATKIG6&^Q5V;Wa-)LfU6fg2ZVS2C2b4[]E,4WR1gO2S>c[3T@IEJAZ?CT
-BK]ag;Gb[[b(EQ7?XP^d2EdU8\\)N)+@[A(@(4fEZQb(>@&Z:(FGH=HgR4ZB<@L
ZS6JJ]>dGAR_K\f#C7B<AF<#g22&L3ZI]B,e\),aH;eM]=AC1LEB,9dFFL?g(^]8
&d+,.+JXLg+5OY\b,UI4B6c7<cQFD2WZ4HHC6<7g#AE4d+^@H#,2#7\[cO@>Fc.b
T>@8:A?WXKW(NU09DMJUc=>Q)_a0[,3F[W^3FLZ\NYK>;bXL7aPQT+10T4K.6UAU
0^9][I^W1[Y5a>[b+.9\U7S)A<#3/.4-)D3-]@<P)7)gcE:K8@DCH\.0/gB)]USM
SY:,f/8DX#RD=ACR=DX50A,#fS/aMgfg/3A#Z3:=Tb6>\e77\3B,?gN2EEJQY0IK
g7bPE,H]3e]c+DR1^,,PEQM?JUP=Y,Wa7DJAV(>],+\)S+5#AENF7bD<dY]3PH8]
=>3gS[XU<gVGH9IHOQM7@9.>@Da:Z3R:&aW/(_:EOIg0Jg50_gSZM(56&(,&-.Q6
+3dA2-W];WY8[4HAT50\UD-:GQ=QFA-7ZU[_SId]MC->C8YW]N9)+I6/,]=GfU+#
R[ba4eTGD[PfF1aQ1L1U[Lc<(7fBVW9dK2<JVX\&^4T5X+81dB<0E_[JYPFd^E/a
E-gJ6+c?_&XfI&Zg9F,O4:O/]Z?R:WB_;+B5Z_JWN2:/8+LA60f(I1?/Ec0@=-MG
dK89^M10QR9Yc\AQ5JeCADZQ45>T)E1XR@[BTRB23c-.RE5+R.H.7K_TVGDM\M2@
2HXQP[AE9+5P&NU934G35)2cT-V?-<)bdU1@e8=R#UCCcWB[?^O?88?O(S&7;,4]
/+Z/^.2B6.9=^1gHFNAf77bJHI3V>)0J1#-I3\1\R9JUAf1?KSJRTV.eL9)W[(T5
Sfc0YJS98ATZD=<U</\;TV]8:8THTE&=^<3SaCAQRE?N]#g_ZKGOKB.6&R=.HK8Q
?/MY9eH]810cEZI_XO^3HJ^JN@a;Z1#fJ25KbJGfWTXRH3aF0WVM?I9T58]24a=[
@[0@UPg3BI;0;;71RL]dV1XZ;(O-gC=1<0ag]IN:X-\@b4X0TcBQ-=HF9##U?T),
@-SGO.\?GY&)F0.0-4XdD8&-4,HAUc+EI]1<R]H3K-C9J?75+PBdNeC/B(dYW-3L
aO6F+Dd/T&<Gf]^\)7daV2VaDNQ2WOUH7S+]YK&?B7H&G4Y+(g9QP>JLT08HAgAT
4d(+bgfN?C;[P)c_79\C3Of^WQ9[FX<f[f_2b(LX_OZ2R9R8X7YW==V:)DH?</_C
]P3LV8T9FEU)U4)17G<2Xa38(PKXaGX+7gQ&YC8)<G)#Fe(M=G&ZD1cK]@6[;Q9D
2IG60JS]3,:^)7=UDV3S2W,>9B+AL1)/?2/=#IFIEQLf?c8MEIOfA1[Dd<.O(PLJ
<fCY:RX^BfUJP\G<I-)D?_;_\\#S9\WG\Z@E0WM31,2Xgb@ILKeg.)/4LTcg]X1]
;]1a[43KBV>T]I6\2V[95[T)0bR<@]DC2_+SDVbA0dCET-1MEb8V?.TC#@-#>R?H
VZ&_SMHYS0Le@<d/g(<Mb4]F]F,@g_0NE;=9JF[Gb25>=-0YY3,V_ZY46&V@Qa0(
Y?Y,+f^P@g_cWWEI<MXfW#BfE_LT@W+&R;c4^;;fNcOHZ87=^=-I-O,F,,L&X3Yb
-2^&E:bUKA2MI)D.H;7DB2#30N6H14_bD@-OR][JbAGL]c46752,fFa(KbJIYCF9
O\JQP_VUUX4RQY;b?X&78V/=dY:ggB)Ye)Z@M(bcS>G+HG+:@(gWN^HQ:BTW]B;6
D176\G4)A<@&IV6<JABbRY-B.1P#?]3F2N?_I#DDW<WA##^Gc7BE^A7@<+;[GT.X
H7E4Fd3CM_,329>]9OICU9Yd-Eb(//a3@XN4J405U-UD^SP/S)@KUbKV[;8\eEbW
eXA?9YL1f7=<E51XY>e5E2A\Oe\/)@7feU[&cHbO]X>X6<S/.>YCUd^^gP,;2]C+
5dbP;]#SUKZ,abNF&d_&;N/8GES);YWBV0]16b]a16AgW8/6(-R>W2=V;fL(B<O7
@9-aY^^bZOffOX]<V2XBVe5CF,AM7.?A8SPS((]9@LLDdKH/,_F148^Z(.OeFR(D
,?(/geG4JQ=UURIY=CG#KfW:[^fg5-:3]-&SSG&VS9.9?/U&BD1;>=>;+Q.(cYH/
N<I1Z-df0FJGKM8;GR\[ce:CUG@cS&N^bPC1[?S9PPd&CcMGN4(44TbfQ@YS:#EP
gMbN<,PXA/J/RU/67[,c,WZS:_NJ4R7LF]O5@BP5)3/J.?VG2]6MA.+D=\?TB?<#
Rc4OC,b,KG;@&Fd+,ZcVFeRQ,/BM)DO/+H]C>^_ONbQJRVZI5VN<]\5g:W56ffW_
(.I7-cNa(W9#^(=_d(3Z)9c+:Y)Fffa6)b=#W+0AZFN5@Y5(H-Pg-cQV[CN-#OMW
eW8YLX(T\ZLRd\SAE?=8(VM\AR7+82cNCG\9H4LfgAbBf\bdF\ZJJ#Y^H[dNEU]A
5)=JV&\]fXgCYE0T>5AWONgdG?+gHE,d48,LZ=b<ddgZaM)JMbTQCaCa>STaS&90
T<TdSE:I2L5^B^(bB@a0.=ggRc^5H_VYMYVEP#;21_SXB1<F\Z=R-)F7,b>W<\IQ
2-/Da[Z2DUebNO[AX1;=;-O7+A(2ZJGTGHF8>=JfL_4TARHO;Fc8<1QP61OaY@46
eb/-HIT@7IQF?abQII[A]:#);T)-ZH]K\//Hc&QFA.:.=V,fK0))XW&OVNea+E=9
_PCK/4cI63P\a?1S/VcRN@HBEXG\aYENBSO-NF\cTW\-^Q_)B7B6,X>d8WGU2)AG
cY5e;_;76M+K):36YGLZZc3>dORARZ&;X\6XO<@C6eK,_?[1gfO2@/2XDUC(8e/)
@/VK?S13E_VA,Y;<-RP&91V81_^77^W#0APFK[bL):3YgDOWFg38eRH7B1]/UZd0
<(<aW\fa[g5@_V7#bJ-Y9Z5)<11bY,?bfE5>#28W@eCMfGI9a,WFeEbCAH5EbCAF
<&GUgGSUOCZ?6PHd9aAVfUUL=(O[155=>1>/f<.16+bK+cXfLHIAaV05\Xa9^VO9
YaH;/D]:>,MSH[P]BgLEFe:STGbb/\#PSdTJX;26Y[dFMVT^^XO[YZG8Xfd<d@S,
aX:fR4WJ/I\R.eK4Z9ZA6Bcdb+BIBWMLS;:@ENIG.?A8e)0)c4[^dTJ_2??O^-W,
0f3=2OW8I4;T+4ERL.)]&4)BX<SQLM4-J./H.GS:24R+16;SM217DWEa,<3226TH
OcWSWV,4PfN(,,2?2CJeSb&7E(W8<RZecG>/B+aF^S.R66K+(_G^_SJ)/]+]6__U
MR\X)[J7D?FdQX<=(Z<)0If/b274\g);VH4aA?^0J>W6[=a5[38F\bQ2CZMCaA)4
e=O7WgGU@2Yb,15.1VHf[45_[M069/J(3:K+3+F@PZ+U@5KfSe.F[H@LSGR2a\I@
&DaK#]BPUUO66;TK\XUD/^DLP5cCDI6R&-)\URV<7(&F<cMY0,aWB>24HG2./^db
5;\,3,F.SP]KgO]85EN.Y@JJgF1LbF^3^>GS,W#B]0Z:9N&d/U2PEd?S:,71?ZVf
\VAKPS[G.&OF,?U/FY3C6JdR=-D<AC@[]@Pd(DWN/:N<W]SM[;/.YW_,RP&9H.TP
[5.AO:C82B[Y8R2,#Ca^:K?6B^FObPJ+T<b]-:8N7IH30;Bdc\R8COW@Nd7UQ)Ed
5SO?&Y7e:]ZW+UIS5<Fc5\^W[ad=?X).eKWXCZ1W5M;\gG>BM\.VW][FH2^_VQ;D
-_Yc(9fRI1)2GSU]c7=Z5+#=UNKf@6NgZIBB<]/H[;[R\#e2Paa+HbHd,7->7?VC
R<G2M@-9QUEG9Y;#@6/XS/=@2cNBYFANP#V\S0Zc&^[&MCQ4&PfFK/1M<3Wgd[PK
4?H==VSVb68b[^?U]RcNa2I:2DW;3O\a2gB+Mg0FZ&;bR,(<M9><OPIdU4f,5-+@
WNZCVNeaS\7/]N6X6A;0X\^=F.CEJ?#AaTaAKT>939WQNH2Ra\AKc1.22KI/6:IV
G;^KSYUa1-MK]5J-28H1bE#MFW/1ER7J-;N,>J/2>N3BV(3SU9[]N<N74a-^2V&Z
3VV>]6VT&6-^YB88TVGSLILc&gOc;B&bFW?=BbY+dK:,Z5X6F_^:9MaL-;GA^OG)
05,Q=H[B(^?)N.2[4&.L<D/51[.70]>;[HKQ_W24O=E7b\SD/9L?0X3:M<9g#1?a
_<N<>_bS=@AR9KGM)U:,=/KDU?\8\#(FQ?XN;U5Q^bTW_NQ1C3O@HLXf0+15QMWA
EV(O\,:9Q5.,.NgUZd,fE^5]>E_=aGEP(IJV4>X10V8U4(&K8?01aVP+SeKXWQ_H
?EF550I(2LEK[5cAUFH7S7gSadF/];RL>M#L@OJ;A3)LF5#(_SHTDRI8ZdOeG4a^
7^I(EOWCaW</I5ZM(D&FaF&7EVD@VJDG;I&TN>g@G-D@5gH^)MaeaUC#60-ED],;
/WX_8RS)KT\/Ef(1RUN#C30]O>&@Q7QB.HO.+Re;(W0<T7LH=U-#X_#D\3a@X+bG
5QF<QUZNN:;#<GRTRQ>3?Y#Lf5ZJPCA+-Y3E^JF83,B.BCGK2CWT&Oa^T)g]Ied_
A+1dAH)9IG2gN.)He1YdH,(-0Vdf=0eW#@g[M03a.b2H[+QLeAZcQ>2Ja_<XQFHY
^,-M<eJ1?AP6&0<8gR@-7:<a]P>UAT^@2KZZRdSYUEI-aG+3<-6gA^B>OOOH>7>M
7/)?e&-+Y,QT19\RG79cd27(HHVRSc_]Pg^ZTVT,P^gfIVH\(84DDa-&SARK12UX
Z9dU#VBA^/=W1VRB+0cJ(+gHa@_#RC5>>81\@2QZI>92WP__aG-Pf4CIR2#(-S]3
[GI(75&A4dWSY1#,>8(B<?&\N,2/C8bRV?4EIR5HbS)^A6B_.?JK<+Y\^^d9ES_D
Y>6/>1Vd1gT;3V;WO6\0L1+H#Y[QfC7e@O9=R)D^#UDN&:fgXLX\UQM]O#G:e8FI
,b.#QA_&a<1EfU@QcHUTDMb[)G]P18XNCEYYFacG#_Fb0fA2=aa2H?VQ^Q:2,M95
W>gM+MS^FG_A[@<cM./O?/1,:9:4N/AP(Z4)cCFH=R2C1KR,UIebfL&0K+@_1O4M
Z1EM/Y&+b,YeB4CY23P#1N&_G<4DVY;T_3PUf-^06S@75[>6V##U,@O6I]e7Y<\Z
;c4D:)QR<?XRFOCL<8M3FD5ZOPM:GYN)CLEUc_<Q;>=&ECF(NQ?ZMX_J7/3U53XM
^Y=L_JU:TbAPLF4Q].PA;\QT-O[bM.gg#DGMM>L;Rc2E;ACW;.[,9U^5@>E^H><L
CE+-C;RQAc#(U3dIO;D;U<YGXAL?McYfEKYEN[+]#NA4BT=N4T)9]RcM()_>&8\f
a,N58VIa[_X4V>V@X=F5dG-+#PVO.^XcRb1=a#UUL?/_R^g6#ePc:=ZVP<U8^&82
I-FTNULM.18)J_Y[YUZQHBX3?]5_L,4c7.Y:PK.#ag0T(Y7W9,2aNNLT:EV1UUFI
Q9a>+=3.g3HBPT<)YN4,5SU7938-R)X\Ld#(Q,QD590De183+GNT>[g)7Ya[=QT1
ZHKP#0G,R-MK0E\Z_ZLO]4/0+:W<MUaR[c:4e9_e;J\J>bZF&-FD_#ZI:SD(O+,A
6#TU5WS)HSZL\E6+IG1Ga9+PYNNJf4^2KgJ;eeIWX?\<aKgVRB/-R/)80JWEUEeK
@[PPC@)H&C^T?)I6R.fV)=L_R@T;N?)VIFM+(2,?QH9.+W:ODMDgAO6=XI88))&d
&F8J,Q<ZU(DOU2VG=967/Y0A=[[LE;R=)-Q+aJ]TCL9^^>/[c.2Ifad6C7_=7M\0
-)C1XOZFC<X-RM\IJ1SN-PIT0LRNP4Ve2e^#]A2<Ie6?Q1;GdB52P2bDSH0(9.KE
[@-1<156RM5E.JR@.<V1^#Y+>S1Z>^6^G;-B7NC_YA0C>ZFe8efT,I&ZF25UUI_J
EF5/bU=Z)SK>3P@f\?C\f_NMZL/X(]]-T5UOWH0P[fVX.Mf?NQ4&XICg6K9()8/@
4BfR<H\gKPZW0Qe/6HQf8+KRT@3\#_/U_<_9fbU8QeS(gLbDIT\a<WW50@fdE251
QZ:CC25X1>>U[\6?dP/)_fXIa:R6_]ZGL[X<HINAG_28JbYWe0LRgUG1ebYATWdQ
@7WR3G+<LVQWGUT.9GQ)D-DQ>STM9Nc#<&@+:A2Z>WOe6O,cRB\?I6WBY[K.W)Pd
M9I/bb;+aeM_AA69bNebD;<GH3MW2B=XR;a&-K7BE4LRR179SZaSLKI^5Q,_;];V
c<c\Y9=.9gT<M-dg.g-:SdA8OQ3M>8_[OYZ@/[Y5>F=#NE8H@TE0HF1IFd)N)cI9
]E(MC:7=6/\2L8V+76eGFL8(F7eA0OX+2SJ84.]3+D,5dNSKHVFe.Y4Uf8K=N@P/
<A?@D[U0MZPC=5/\aFL/#&7BQ?PK]89#<.U+P,2OaPHPX-5GMaVEY+O&A9+8g#3W
Lee(C^^DSMd:?D,AUDD.;;7O7V<UOO[\>6UgM[DO[TXI)=OUB5[/,?W?aGV0):c+
8]BP^#PJZ5BXd)a_/DMX,KCg0e.S>&@?H#<93dC4_YBX6>ZaH+<NeCVXae7(F@7/
b8f,a@8VbA=T6V^TOVbY@JTfT.@[N^cD.+31&a.[#O[]I.9VfDVPdZ;Gd#\Pf-?7
=<DaE2WYC+N+VOJ@CGA7IK(QQPISV]491ZXce7cg4Ne2)2#]#LcREABMBGa-4F(^
d1[+7EYMWWAaVW^(NT-U+9JSX6,(WRG70:)I+G@&f]a_4^daOT)\^A6]dQY2::@W
NEJN^+:fcWcYg+]Z27)d.T78&2K]N3;5]5I@_a,\#FWY:J38?OHKTP)bHA5fZcd]
XNZUIIIgC2e:5SI8>E@?IC(_7S[ACR]QG2)IF&:MaIAPXY?[HC7Q)I<PU.W])-)e
a:M8IQCI[?,.,Mb;G)>7&,_aSJIODKd0(3Pa1G,_g=_11-ZdO0(ORX/L&S=N0=Cf
6VY=[T12A&J,RbDQUGBZI#Z:bO/VIg.MMI@01U#(MF@=AYf3?:,6IY[XJe24015M
1_[75#&PWge#Z_(:Z&OT2,JW9KE.KQG:d&Z0efUZeW&S@VR(U856^YLT;S;0K9fF
58/HX&e,U9(X5R3D5G&F:1d\)9(@B&\KMC/V&/_SMA3Y#93Hef:\?2aB:]G7#BG4
-56H=;]\dT9R=>fZFc_?,dXSNI2GS3L6OS247@&TKT?BF=3AEX[HQJEZEQd)#,,^
>FN27.)0efXYF&[^LS\7Y,L>NR1\K1[@b,U&]FP7f4F<I3V2QC;PE&_99-2Oge//
gO@V9Pe)c2R?AJ2Lgf&CIH0YDaHE_b;G9ag&#C((_V_GE:O+]^\1aWQaZ1;?OU?2
L@/F64V1^D(RLE2H1N^3>3>WeI5BO&+0&Q.^QVK,D_/:PV^IEIeG)?M5)4J:G;Yb
1-XW:DCaW7d,#P3==:6a,F@^E3OZ/G@\5:/gJHU=:G&@]6BA12B3N92IBR4RSAYJ
=H6++&(QIEO;C>JVJKG)J8S,;56&+&WXF44aB:X]JD4HO5C\9FZSBC@7GT4;f<&8
\2_)ZQg,,GRMI9].<[7(=BA;6)O5J0)CU<YW@GE_\IP9L;74g90g@,S3R,@RO_;2
f>Z>fZ2@LP4Y2U<;P.9N@#b:&RB7&,ZQR><@EU(#gK1;HV+/DP^8F9eVI(JSM5[>
N:BS(P\:N0e(/S#6HP@7]J2+WJ]C(KfS0caUAY#NO#JD+O=gI^bK3f_GFc@V1H?K
Nf1)\gAR@TD\()<dLE-Re(6b+C740b6?e3F.5a^>f1G(R?3H5VX\PG\Y5B.SLOXN
^UfYJMb6@.=[[=@2g90]&/1bE#95S#cC3H0/Ue8ZZaO4TM93F_<(LR;[L\Q.]E)^
<HA?0.91D-ED<XG(.=V3(?@@@d:9@KT,5/5QNN[8.T2E&OJ-K;ZQ3<cQcB.,MUJH
/V[,ZSW@.a@Oa,V3Q__;84NZNL7BQRE_c1ZR6<cSF=cJW>REIadUc3P2[#MbMNQ<
>#.J(?&;N^G#e2R)IBLH\];QQO<_^e+Xg)Z&f,eb7)CRR(3A1N?71EfYZ[Dc.3ba
.BdLQ4@-(Y[7^.-K:JH)aANg4fIM:+g@40.63RD[P6^PT\11A#&20/>++AN4MJaT
c#T8#1W9>.MXNUH\S,\<NG9D,.I-M/U(9G;.&Y10(2++J9V\+1&LV<c0J;C[PWgI
PUdZDc3N\;+SQ@/,gUg\W?)JAG/f^K1=,LIPaR+)NYE#5HK]TAX/MGfHY+bMS(0E
G[gHZfa#2cb_4&dW2-?)La<84]LE[0WE?:-Vfb@\/?-WCHBcC]f+-RIVDHI>JS)b
-==aTB__[B]LTJZ=6c.=FBb]Pf-QQfG^8EdXN1SE[PWBdKJE_SI.6PT+)?S=]1@S
6B]egGL7=<R[=2-ZaQdEOe]COg/)VQB]c^-<PE[45C9Q;77QUKR&UcKQ\P2g4D=?
c5YBcS_L\#[]J-T38+,Qa(,,:eNeEX7L&bCgVc:f5dMXeTcC+)GGHg[_g-b/G[K+
EZY]Y=/JQY;8Q?Z?dUA(-=S/,d_MJUT-NP]cJ?[Og0bQ4cF#/I5DJ(1\]/?U^@/V
W_[A>7Q^C@G<.6+c:MG_:[7HfCA0<1_Fb8AY&C:g8Z7?)Ye5O5Nf]\_4JW-JS[HF
X^F/;-T4I<VYBKH^2E(0bfaM7>99O77-R3dNMcRN@6Z\R6)RfY;4G(ZZ>?\7a-Fd
B4TR]FSO_[(RO/>WMF/>_e@+c.Cc[--OH2K8\-9bQ&7I._6,;9NI?^DI2M9(/H>6
CELW0S)6_[CX6C0bFAPNIUOB8>BNfD&(gf2@:+]5#]Z0_=^D^&X\OIXR.L4WUZA1
>Pg)H0a8XYFH(-e1g/\7V=POZVB\/P/NLXL8Z:=ba9dg,PeZJH]BE[(P7SHP2U+[
SE5#;(5NF5Z=CZZ+e&]&:];6MI?O\DRIJ.d&<JeQc(XI&72^>Y?BS@=eSN5J.0]A
C/QY+.5GfSBA=0JAS8>f^U3#[[T.F<1S[X0+^>2KW\STcCE.A?c+ETZ?7G]4_N3N
gG858Y=3D5-]X(/[+K0>I>=KIG86K0#?[/f.ZBIWEF2F-dGBMP>/1UI>&Q&gD)dU
P#+FAK0He9g?>(Be47D7aU.LE<>P8U\:FL#M\B08AeLK9BQUI/DCNYJUYdQ=[&B7
7+>1IRC2DNZ[\,6ac75C_3-gFf\1HZ@;I2N#X:I@8[#FV\N:@@Yaf&6IVD^_A78@
+-a?B-,<7UJ]E<DcfX&M)M@+0TCIXedZ1/ON0b4ZDM92RFK0c(Z\D1(AWG@S-(YS
WP;#WY_LVY=0[feS6c#/ZE8+Hf-8VBEHg6E^@GLWg99@;JBF;CgTFdU?U@Y@)S1+
B8:Z<J^2EM#W__aW5Y/G6:@6RQ?1J/N@;?3BI0>B@K4B?1MX^CALNUd24N?LC,;5
4GLO_OPH-]R^X4+W&L6&-+M[SQX&GUKNL0RZ?a74f.9CB+_>_bB4LAaV)gVP0(Dd
Hd[ZaA=1EMBaO+bNXRS0Y2,D@8<NE<C+,K,WbNP=SM27PPLAX+f6,gJPN83KSbL:
B0&-AU<U^T(8\]F.(8S3,=ZF2)BA:]IL>5=)G^@DL4PDcMdcEW=Gb2Ig-CV-8Cd;
V-?=Q.V?:f^X-9Pf^>G/[_\9&6aROK8V<6ab,BC(_]CA^,MVHS)3NQJEJ1dDU-=5
dV\P-dLa=,N5e1F&U)Pa3XSH:.#@&C=cDUDM:F?bCd#aH[N.YBKMJJ@2HS,QgEA?
&G+&-a??.BLU+\W,4)dZ@UKaUZg#E5d>P/@-7fOEN&+GE6@Z<F&<T:C1RG(MWFEd
T7@a\cN^&/LNaZ-FS#d/bVBgbM6X6R<8,3+6=\GBTC4b#0,+^KAK;#c_dc(f-0Tg
:W\9cbB6010QH<:89Ue:;]Oa9U0ce<_]?^>U8<28#7X8CUF-9R+\#YK8T75D.2-I
Wb@0^3N-.0,/R,333c[aMc3HXP<(@<V(f<L3WK_D@/U3-7K71J>VE5(==,TP-88>
QCTeDcN5PcFgP>9@-1R>CQ@KNMW9)L-9XH(Ua&YaLW/bBFaJSSAW]8YAKN>ILd1A
[/NE7_INc1/eJVUEU4+)QL8GR0/T.,bU157#2RP_b7)FcKeBJ4)C\F--;WIX9+HH
^B9cLHY)+e;H1Ca]FZ^/F[1/0g4D)BYB-K3XJ+4TfKd76Gf&]BRC_U,PY:OX19IG
]Ufd65RWN)VYdPZ:7S+BR2B0B,SLga)_f7)OFC2gHMTVQ+Ma4^MG;KbFa=E8X:^Z
)#_1TTL<^3F(H#G2.fARVE9]?Wa,7OHOK1&_<1\?GY/^>M.^K-><,+EVL58-Y[+?
AQ/1gV=c5<7M8\ESM8RdV?beH1HDZWM3M]-\\dc-@ca@+LG[@;3.QZ)A,BZcRP?Y
)XF_E#E9_JbGBM]Q\.+M,3MU88.N+SXHYOWZ\R[Be#^;QJc8;=4,MMHBY_KI(edV
R&d0W2g2?AU@X[]<F9M.P5d.=KY0342.WYJI21VX?fD-,?);&[I#9[ebG#AF0X>G
If@MD^FH(#Hf0e@J7>QWBXOcSda&]V137e32ec.UP/T;T[/+\7Nd1GM7(2LMDQ5C
[@.;<ZCdJ2Z][[X(W<+B<;^(KDe7ZD2a\HN>(9f1TR;,Wc-5UI2[6bL>1L5<S:Hb
/IQLbf_X26?(I72efNYM-,W8J:TI/26,f\7gBJ@3ZB9-UXUQ&O#0U:16fb^6M_#W
7R@7&Gc@_=YOS36_]Y#G&?(XC(SAZ+5-2WM;[V4bWc_J:[]VGT365F^^BJ72R<P&
>29YE7U,U,:a1dc?cJgB,N4X=SCJIHb8HLV#ZKY3I#;=>O.2(N;H965cTAE;KO/[
WGO78J&FNU8S&9Q@JOfOHKUA=GQa[PH<bFSW4-F3bQ:\X#Z^IRJFJ0S2_UfVF+e<
eKJQ[A>9MZ7HaU;;J.R;RL[73=)+e4XWgRQN1b(E.+NN(,6HV(79WR=O[.9KPg\:
X;BM23a8g_((b&R4fbN7_1?H_G30JWJ(\MB)cYI5).<_5gfO#AEX6UTD@(8P2<RW
HW>PKgV:GC61\f9;5>8(c07;F.WV?FT><Ld=)<=c/(--OcSH2#G2KPRga^#K1bb>
J]KI,IQ\b+/GG3P2_VY>3#.WL+bE=6BX>b<?CbVC&Y2[[a3>03Y;B^eW2=FX;?/>
8Lg]d@gGc3V3NIbULHZ3N717D&8f)<]L3MZIU+D<LFIMQ6.:KT/=a=9)^?B/:Aa1
EGDYO[?Z0..6cYYf1aO/<3:9U^W@I^U/L2,8W?XFYAACOKB.>04AWG]XF:UK?N&V
a0.D\05R_KVDSPBTbG6^^5TK4PKWX14Ce)Q)F.7XN3f@7[[d>1O,=(CLNfY9[-50
.XTQ[PK>Y6f2/g=]dVAC/XEK^DYN=F#YbS+S8.CK1gD_[W[8?;>R;E<fVeJ\@]W\
f870Ig:54BVZ\]>8ALZ]Q4ea&c?eT>(B#EEbX(&<De6bF#J:QE1U>a&#WTeU6/:T
-/]_J<.\I0XKT1[(]@b-#Ig9;S#E9GbIJNTICG]O95b2F++:[)80(d2bO\<fC.#_
K#@#@@MD7N#M>c(a6I79/=3d8V+]/Q\3ZV\c&2#a^+S]f]d=P5f.8T:=9X>AHW]Q
__f;Y/b\f.G&37<#8JaH];Y9Y(F-VA\+RADM;<X2/NKRbET_I7DYQ3<#5WUQ>+N4
+>7V,AU:[O^@E+^b(ddVZ^@.ESTV(N8&g,@C>AXXM7R6c3=4H4R?=Zaf#_(/C.,N
U./:VAG\388@;TOJ\3FZJ#UdXIQdFT8g/2U)Af,5gH5S)f1:Df]X=YCf9(N\a6^W
@AGc?UF>DECD@6>]X>S(gS81+B##=(?T/U/.84(2D6RB(+@.7,(:gMKYCKN.NF98
:/_@\TMM5Z<S=WeQ/SZRWKf#A&@^D23I9:\^XU.B@O]:gDB9N</D0TWCZ#/J\]SJ
-g;.I4_M-0DO@.7KMU4fcUVC<3MKI-):5.+^841Of#,EF\9,#DfRF_RaOK9-@UM(
UXSc\?EWL\<F)K[R&Qf.BZSWXG0g:2>3=:Q[\8RNb8IfCRPA^]2^]7AD,Xc7LD,A
\4)\_gPTKBa[JXT4L<[7#Y<K\]CEE\L<ZgEeQ8)VG&7D77+3+;fZRb]7D>RSKZb;
3Y6DXb#OU0B@YXPB_:D4D][Z@46TV#/P:]SFdKf7<K-N@)e<#?@fZF+ad6^6G8QC
],a5fUNDIYCR27?<#Q7Uf?:.PUHgB;OfN?O&/a?0>QK+aZ.)Fa3gef:2f(XQ>1X6
-HP;c-HF+fQ;CN6]Z;RU#(U6+]P&c,P)HDY2&PC)I#/U8<1]]2aK;gQH@Z=CYCK:
TK9e<fILL2QHD(?BPEUTdL0eZ8+9NS-M_49CX7;]=H;d,/^5M6MNXU9;AdgU6BP4
\dNU_^HK@#ZUCZ\A?2O7^&R7]bKd_[E(G:]Z<T17S-R&L&Ob54TBDe0gZG3HW)41
Y2NO&DBO@QA-5(0F@JJ2-8@YfT1+FGYDS\aeB-JRUYdL\-@Z-A5O_ITdV9Ug<@^Q
-,(gF1G=D]J/](GW;1U=<]+fCbB^LQbC.[dGKM5:BGU@U7eRN2[b/:BF+HfOX1fS
@<5LR/D_19B-UCc.<L8K0ed,H[6TT:FN@BK_Q+?KU4LPA@V[X4JL.NBOO^KUZCRU
;8KMgQK@@EH#-<<:ZgaIS0D9YKN,F,;ZPG;BQ<))>+X+>OC/&(;F;d:T.U748BEA
>MJ@AWN7_)U9J>S,D-geUe@DO&LF,L31E);Jc#LG126S9XO):NYgMYDKQ7U.TF9G
c)RE9+OH]eP8&C-aXgdcWM;JO^(HFY0\-<QbU5&_=2GZ&X5A4LQIg6a??4A:Eea/
@^>D54=CaV[1;Z7V3O8eK[KHT@d.=d/YVXIg0c+,a>-HFY:EeF(2VCS5TE7T<=bM
AA(gA1NI.,+Y1GRRS^)g1G-YTL;f8H/J,bN6>g:Y_4A5f46FFBP;\XZV@Z)LfL1[
;@6;J@\G<ON[9/)5\/WWY1;8M()5IPXVEQP5C\CD=>&-g8#FHgVCEN_g)F4QSWS-
X0J;E<PM61^e&7(_X\K6\LO)+<LBSM-)&_,1^+De=d1:QS=6[EY_1?R0;f4JYaF2
\\,6TTOEXH[Q\=\>G5-eY?R?0aeEKe#=A,4H<PLg:bU;]ZUb,7..gXX>O.UR--[V
OI0[,2IPX1[g41_VO=)2Vg,O;4JB)R\9cBf=-8G1f(=eabGX-<5Ta[M@0N?QQ_)A
3_C>AXC];gBc11].\V=/9#SgDWd+M4)AM#,3GN]-RBSD55>&Ne:9-\^DbVOV#=NI
W:6E@P.0E=f^J?(C;bK#7d^#Z5fU,)JN]#K3,/N/+/<b-;7e/>Y.VVd.Zg?<63TA
X?eSE1DYb[(2aWHAB#>.83O9O?Add108MG5ZHGR)9VWE<R1bA9M.5^+3PM.^5EKZ
3bTfU2B#>d^S_eD3+bZAOXFGM():-U-,eTCb_>Vb(R+T[FIZZKcW=F;dJ+.K)/7&
K=Q&U&Pf5-MJ,L+Y<2VIU>aT8cRbI-La<237d:EfJa9);eb#1bF^5/C5_)N0;>?J
OJ=NHCb1BU<&>AGb;+/gBfL_,IFT&R<J;18=A6f=^EI.)A-#=Z9T_A?Y(E+7@5dV
KZ;MZ0^ECEEOVM1WF,EU+I]eC8f1NFddcS/e8H?d_+HF_JF5IJ0,G5+b4X2M;E)c
G,Z:^QPB#5W3>SR#NaDT33+BN@[=4PBW(\@\Gd0gAF0gP?.6BXH4<LO4#,LM4G@5
G7HND53&).7,QUK7?,LKNJbc)BX(H<OUC.TRT7#U]#;P9YR8Q^\X\cOI^ON4CH^Q
\JWK0\D,C&A(Zf8-LcdD0B6)c^FgM.@\<V3BB)I:D&eU#]8+.]-g1E&ffL:E]<BZ
S6<DTNO>Q9L].T=F8L&;:Gf[6e(8fa/KX,XYd0.P2bUgHX3OQM8BM_\1G1^H?K6R
?YHZ0^FYW(Z8fI:[XG(-L[FKeEDdgO:JL=Jb4dDebT&?76GZ&HgAT=,bTg>3J0NC
Na8(_YJ,Wd<N;=>.EgCDK>3+SW54LcX?9bgbT7FHI[^BQ-9SW-WW=D^IEb91NbT&
5d0J4J:<3-(YTMV#LZ@,#b358BAd\V#L<:I+e#HGeB.6fbLag3D^DTAf.Y-1bIJS
c+L3Id?U.cH5U-YD^gV:aAN1+C1S61bZ_#4I1)4Q^CZ/>b4-QJG[Q,K8Wg,&LBb=
Y)U\H#_M6Z[>D&2IYg(@/a[L-?4PDU+dEA,;EY>HKQ()HPRAM6,K)eW(_,F,a,20
cC@QKZ/<,1?NK7(S9;d:L5Q+H#fWgAOED:56(O1\,-(a&Y<Q78XMG:55T_I/]<J7
<QIR,83AR;AU??Td^A21-[R5Q^ffc[K.UW+g:ag,#d:2=Md86?1X<VL<0,+;C01C
38,\B\D8TMS]]ANXZHMUYA?e4[-f]+1c<]#bd00CZ:#BZ10Y;CKUZAUFe9C2:@Q(
HZ405&_0+c?a+N>\+>89B#&J1dE#0,&XI=;-e8W\83GTVJUPCZ(GOSIL+^Cc+\Ba
5#W#1C\dQAOT=U3O5@]Y^?9.^-42RY_X^gUR1>dS>FC_\AZ[4(=C>cX>.H[KLeBL
3OV-Q<]1e,SEcfXY(Q:ULYY.\(Ug]V[<&?HTf)7R+CM2^,T/e)8;#/c]W<&)B7R[
K6<HI,(da:TbQ@[E(?>CI[C?\1@>)[EEfLfFU+Xg(d@]gQHO[#?(.WDJA;<CU0J7
7GI+?WeO<I,:[^dC+;K;SI>cfTY.aMOE&g[G(,f;;Z,<]-EEX007X53\5E[b2>?V
Q>56<a]#B(Y+<6[<Kc<0Y@Oea)^D[^cHfB?SKeSU3S>HcEfH#OVLK^Yc)QM8eD55
4?^Z+3fYF:9K5Y:=KM,]ebZ#D3Of?&ZcB]>WBV@a-87)_.K?=-g/c5X_a9KLC([J
952TF;2MFU(fK.=cKF#,NS3L?J#J3EA@ZH82\\H+SI]OY[4afMKXK84442f)GQY&
8[217#5I8<fd^2JME,52MCNPF/U7S[G)Y95H98[8d9[L0MTV(O)=V/5N09ELM@2)
FbSP9VAgA45egBDEUCF#R,06,I.]-\9=J(]&#;H=W\-[:D3W7Ac3)_OcZ@>F]e9U
DeH^eRP+K@K=Zf>JfPL3H56&B-+]DgZ=Z\Y+.-AB&gUAOA:7CQ:5D]&ZfH?<<^a#
<,+&Sg88:=N]?]:Ld[D6+HZ@:@3X,Y>GQIH@eUKR(VNTRYMO+dXEH[P)FcS-;6D;
?/22a]^PJgcZeI<KO/X4bPAU-[J)_Re6ATW&EWPK+.R(XV>0]A^fH_V4NFc\H;KW
27NB6H>]&XgP]4eBeR(,UN3VZM_;55e3VY3&+aCPJ=8b8-913eB8ZZbC_1L7\^5?
^X(e-OS+3NQ,e]SQYO?@CZd=Y6_KL>XO.&R\.bee8WM<O318KdD0T9PNeT)H:>],
+8[GZg1)9?Y8O3DI-9+6]FQ9U_<WQ;0HK#2/1::JFD?)GMfI2=9d)FUNJ[\4XYHI
9V(e_MNAY:T::IVJ;RI0RD;9^[-2NEC.1VO_d0Z/.d4=(IGF:/#V[D=7OgdAcT]N
SKJERc9V_FHC2FL6.E=:@XSKQS25_XXReL\/MQQYd#OM5;O_Hf\^N&LgY[(c5YT4
P8B=@?DE@]eQ7Y?SQGSP8<L:-]S<=]&X+G]Rg0YeVgeQR2]HVfMKWKSEOTZ6YJ(A
#7N[W)L6bS&g>N?NeLe<Z3c)5YSIPV\Y+L<QPH-X1BKIA(#Lda66J)0YCeeX1]X5
44J1d>JbeXb/gS.g_dSR[J;:9A-<d>eW6I,UQX:SFaa;KI/HNU0EI2HIHNGd>&VS
e\C+Yb/MS[RRP7R4&YcP<WJVZ-O(QRT@NMQ?ae8B8,dD=>P6SOVc[,;<G=e_]DX9
6PTQaXJU#P,WM>aT;9a9X4<_-aMb]NWDW2>&E3bM,LJ7AI(4)#;)U?3:/H_MfPN-
\N7^D?O);S+gT5R4]((f?QeA;C?^/N^>BaZU[VL)fR+gQGQc;C1Z)(_eKJ+K>)V/
/IK1WE95#dYda2-4>gLc\G(BFB@K/-1\eP/Sf7O_(;@N4GIXe#Q;Ve9D0Qe&3#9)
:_A[]#/U3fD/M+.RC[VGHW#V?ECd+Q)]Pf46:89NC<F0V@ea_8gTUEV6PS\;^;D4
J5GE\;(B7G&(39EC?3ga7gQ_F\+KeHAV+PD8;I_Y#7P/+HFE))CU4TYVb]cY/=8>
_2Z6cS+W4R6?BV9KBBXe,@^)>Z/(_;]a/=#dN6_A^H;+dST]/#CJ8P<@71b\57:B
(8O_KOBdN:MB[N2=OKf[1TCPNdZ?Kb0SbF6#G4-BT9]-(:^LOfD(I1SW+4YM^0:7
?bLB//W(bZN_ZU\/PAe8Vb3-VC&(PK@93/1,g8,;GGQ^N<,(P-\\01F]\<[ZT^cX
Z^7H>MXCXU@d1)UU<CfDgV2Ff//:I+RFaa1GHg>TNV:UdJK(-GODYB\/9=J7&CQR
/;OXfW7I>4TSL.YTS-RX#+4MNd,\SL[?+S8FV1@&bJ)G0,GT<9H5.;/;VP#T-SeM
YKAfd[/-FO?ca(Q7cHCYQ(HZK09X,.N)D-a4I@?#UI:8ce?_ZHMJ0QF;;2^2TB47
8)gOI;L183d_#eBN;Q;06cSRB/^HVDA7.>V&R&dIgAgPL)7HPT6<PJY/f_9@c,^=
;9/#)_]3#>]KS[-<0e+QLe]-Z8SAQWI+<]?A0]DRdfKFH#d]3,g&<N<0GE<1PVLc
(UTgH1E7.(Kf,RX72?8C5SU[GGS1C5>NMJ;96<.&UBaH,Z,0KIE:>9aSdVbU^&/_
FcC]1d=LRG@@]]O7<a)[#C>eIYM>V.1gL,.BF(\_D(<JQ+TD#dVXdKC#U.DO+?KC
#L-4;<\/D?FPKdd5_dR:0/HE/0\++2A,OG\14geAfGJWBcZ.-XK_dQfb^6a<MX+_
Vd::M6QW,:7TcANdQ[M^ETAG(8[+=J<R.+CZR&K\?5(JI2ePQaXWZ:_(@+U4OC5d
,LdV[.NIb57.TQJ@dE2NIc)T6gO0)J8N.a.SUHe-:B\0.d/<?d[&4#ZTL6H^-U:L
@IGdW@M8]cGgU2Y([XZd#^<Ne]N]bQ8P&JOGK:EW8,5SG6F>@15D:YJ(f7R#WO:e
c+OGV#0YZ]LaFH=32Z]KDU:fV7Ye/A,JZ5gVD)RTH/H0LB-W#:KD(1Ae7L/5J>_b
#DEKP9Qdb97]70THTGF4d+R^.#S-22RX9/^0R_gSc\XB>VK:SeYdW_Zc#=OY@KO&
3X@?RT?H@UV19?=c?VAO6/J)K4QY/<0TOU:[U,^RFaF&6@/KJ@ON-L;1\@2_0bRN
.eX8J#_KCXHZBcJ#gI63+\eWVEQ.d=:7:&bG\-Q257L0D3a2>T/3)aA#JfE(?QY)
F95NH:fTT3Zd,8J?#NaON-L0:(LY^R9ZQV(7WNGZdIbHNT9(7c.P+J1.D]gV2>Z[
c8g:OLM\#Og3eZX-fVI6)[b8<:Y#g/+=\CX&E[?>SA+7;/fAf[8(^aaKgZaf[7(.
,[_c\>W3fP8UYS[;#D84M1O&V/_(.7WN(Tf@U3@5@)J8E[7A\#bKUH[GeGT0?2\]
f]B/UU_5e.63X-)WWJ(OEf36&PLUEaLTJ]T>I_G::\fcZNO\fNNOCVC\0^?b22?D
6U(&;E82OMf@FHG,]-_ce4bZeCe3I@dOS3.:&LbAY[<VRABG8I>58QO+@WR]MB&c
7I^UP:Z():IWA/U?#:O-cEdN9T(9]S<#.,7L\Q/#=V:P8WdV8.]RBeB4<c5<;fI;
BG4:d:S>#&R>F<LP-199;Qg^)WMVT3&J:C/G)g\=IT@0-a+[e:+00[Iac\BV5b8V
)acbbQ1-LEN[H3N)gg8Hbdc?B(Df3Z#TZ&^6fHa;382cVdcSD_G3&;_2Q4,F?YYB
_Jf)7a1Q13H:_KeD)eb86Y\(>H<,:?XI/-b)<)c(>KWaG[V:.+?-@N9gYOE_<RgV
U>.M<:6-E+>F\4&_POIRBNc&X9CGK]PLKNg)E]fE.(WN0[:(7Z.d?0>A/3[QWWT_
,1Fa<bE2)QMVE2I.;1_/RZ_H6]KU_Yf2&eZc(C80-5TZFOH78I\7WT(,eN,PdE]d
WU[DfeecR)B\KDKKK]\LTeaJeI6;#6V5dB&fX?DWC7D:I2AN8@3.ZCNS#8I9IRBK
ED#))R]7^f,XJ4^R:#OPR8J>M6U#?S<NQUY5b0\B+(SS/YFBGQHR;#OY/BF<EZ9E
3EDf9C]HX&,>b#@DaI(G]((WV/b>BO1>EJ^dAB6@9Y]HQ;W2@L\\8Q8]UcZM^JSe
[:FMDFBUg2e(AK>@W6Ra7aVQX>a>dR]dNG_;ZQeVN(Q[CW:^U;eJ-EV?bKE4HB>Z
F/8Xa[e.FG2Wgb,d(e^Z_^N?b20cAEI&6e,>T-H4&W(e3:O_QU;HF6@)XYL?I5-K
NUQc[<C9:Xa1&&)CMB,L\.5O&QU^=W[&L;cC;RE>@/MCVVcP?\Wa4Ug0E(YU(]Y<
0e,R_]I1XFTUV_Cc]>M(]^gde:YCdZ742=eU[P+U)LU56A8CCeb/3G=21W?ZZ]AB
2CTQ-V_YKYC^P9ePFXg6X_=++D4H=gR5R5EIR_KQMdegf]9X3-XfK]#[-S>Z@TLU
3?PV=?E)2aNaL-@L==J:F295SVFccfA(<>ZVKAD_0bO]:Fb,:UL32QR868>a7OY]
B^dWQT@FH[@cTAb<P8^R:MI04(e>RXNOJ^ID@?,d7<WP6NJZKV(JP&g])dKa)G<a
P^e(RA(3G4dL,PCJ,ZJ.ETZ1U9d<=H\LC;5+KT5JMF:S=A6OSI::+>=We8B63HSb
)_WYS/I8Gf)PbgXK8M[C8DU7[OcT@c9A+6YCgdc9La_7KU+L/#=JP?YCb9eZ[&;g
8302@Y)=V_Ag)1Ke^1[B(^bHZbYfg+7_Na[\L98RBD<dGI,&:AadTPZa-_HO;d+_
9>27+Y+JQ(Aef7A<>Xb+Y@bdG6AL2fH/T#HZQA+/-f@I#J3&ODSHHfC3dA7;^9@\
0?TT30]C]8F(??Bc(Jd95GQM>gNaW7aaO^7)OI?eC:6B)e+#:eID7(14,.62@c/e
Y>5&@?WW3F&^BPB]J>bD7:ae2<D+GL\)+#NcfAX+&b2Y1)3PD:;_dBTU&X];<-a:
<20&PR\YLD[]5^:LQaSA=D@bIZ)&T[;fb8U)TJ=c720I1XcM+W-:gIOZ/9JKOF2M
0B_#I@aKDL4[9+74DUHd.SY,&>Q)Z7_<V(V#7gRIJQ2(PREI&eQR14f1OXZTV3B+
dR^GIdJY;g]d&?P8-R_O9<U_WZG6FTcNS2d9?V\f9dd_5_:GCeX?N?O80+;dY2ce
NHgaJVL,.9aXB968#84Z+_4N25UQEYL\=C3QF?=H999VPOD)S9_cgfX.WB>D8J#:
g7b:]5&V1J)O2E9R<E;#^?b^AR,7:GO>Z0T(_-JU,^A&3V_KT.1[aNcGcP)<S_H_
G0-K7/+Z^E?N8[.?LVd9)fdVWUSV\:R??HQ41D[<@9&ab6/)IUGOYH4T?G,2QbaZ
WG5cg1CQc[ZV/KZRD6D\^SI8.0QSEJMb,<FZH<7K+6dc6J]H&/#@3J25YIRYd2,]
f\?(b<+-G1BfE3V;.;(T647N4Y=:+WFV)RbRDbZYZ8S7Ee6.H+_^OFeCBIGBd?)S
L-<?I5,MOTgFLRKe_-)8G2:Q\6ddFF4OPR@NR17TGc(XZJTBXBR7cMAM70LR&6,?
X8&HXUAWAg(WW0=LD[.gH6ODTCCCLH712,3MU^VC:\9XQQ1a<FBWA/^-QAV-B-CP
/@0NgYPN.VGg\4SP6M44PC=6,AL((;HgA8Z2./gZA8>TTf;2F_].B<(#W_#T7;[&
ZXJ.RdSNH^\IV(I81@5b2cJIA,0P1PeT46^T^8OE([c:T9=7JV#UHe+&^RDQ,G^V
AJA=PFWS-[^a_E(+E:-8H^^SF_:#DKC-KGWNAfgY?#G^PA-;=7Hf=IL.d)cQ9+ZD
VTN/:PI&E_Dca+@.3fOZO=D^bQ4.X]R6.HeT\)WN.L8)/,HQ:g6[1&7RGF.>1_^)
:OO0&J[6=]1/3>EL_2dbgUS7#)_K^-ZAOKFO89MIEI/#AN0;C>LcG5TBZ3.8Q)CI
Ea0gZd.^H#/Y8FNJe=N1721,))I+#TA3b9?YCFVVEJ_+.0:OcO:T98X6fH0/EI9T
DYAAWV)RE?5G\J>7L/J2c<Z6P,?\1Y=)[J3AQ^:37N:&3<ICF,QW5I6]>2OG^2XB
N/&MSN=]b=S300[_+IMMEQ#Z^QVQFDUfXcNEGRG=8&3;^[EZ^A<C5HE;ES8^<QZ6
I,0U_\c?M:gcIM1f;Z?G0UVK?L[^W)67PAA6Z7fYQ[=KVa62B>7QA-e@5R/(UE+#
(d(ACWg6DNJ7H@;FF9)=I7J[@1==3e_2Yfg71Y,)&L3&E804FO:QaSb-0TZe=&:]
Ca8H&:Ye83UGAR;.J[-@J(1UF1YMC;b_aM2^59=AC>f[&]L>M3\6bVKASAQ_D63<
:bOIW0JRXW+,WPU,@CB,ec[S>;-.K0=)c0YB.aKg4MZXM:d,^7F=8KZH>D]8D)2T
H:b1,WdYc=NP)P<:dd52[+LDG.W8=Z/9#L\eJ7E0\D0^_593W-f93&:L)M)FF4IJ
?NO5LZe+KI82gHYX+.FBBO[Dg>IcWS&V^Y1YQL^BHX&^X&IHN.>VF-AZ7cZD7RN/
S5=IeDO:BAAa#+&<00fY814_EHM_Z)6;Qd8.gQUOJF/3c;)>.O.@S5CH7YUW?QBP
;4R+9K,cM0]J__4)K52HLAQ#7YCZN6GX&^V90<@_GcKV=KL;J\^=RQT)W+W^P;BW
Kc?FAcWX:#.Ae?RDM/>4.L/Ke.0.34Q9XLU3EVGMSP0-X)&@IN<eF;\be.-^+EFa
6PZ^&#Q8T3N11F53C5FU7b.bE-MbY0O3<UdIHJ_Y<V)EaQc0N+;d<?ND.+K_<1WX
&\M.J,XNQ)cNLA6@Y(Q.R2CSe0Gg0T?)^HV&WAJPS7+6DDJgJM(W[EbR)fOcfRQL
UZS)2=)H[1A&=D0M3#;7HB4f4ZM4^->K5XFP[6Oa7ZC/4+F,4\c1Wa@YFNB^cKfR
[0VI]K&W,[5MYaVGH\V3aD+->g;<8[eTdV&_H/&0]d7cWB<We+L2,\7ae=]X9Hf?
/#M4@Bg:MJ34H1B-;[CHU(\G]M,KO4W5=U-5_@Y6T#Cf7U6g7>T?70(Dc/Z&-[S<
^K,K/_<Q(;NTb/FB2;EFOZXfGV-1IgP,bNgL>>3-=<&&I;CE36(=:HLVCQIP0O_J
T0,-+>a-HAK=1+HaW0N0ZK\;aU7,E-=W-QcI9>E7[c[E/B7F-W0e]/UG470#LD<?
=e&B[ZA4MQ-[&7D<(cD5XTIb>39dFY./&;OX6F.-Q@RZd>Ie]J<?MD06EU5KK^?3
J-I+]<+[;2DUY-=T6<S26J2IbV,+0P/af4#eMHDAAF_^VDMa>[ZG:Q9/7Y8Z/JGR
LI;#C+OWTT^VJ,Q\U<cUBH29FYHePX6QEb&-]RKD)/2TC\0V#XNN-OfR@+F,]TUQ
U&f\JQ?NGQ48c],C_3]O#b/-8HI@6KbZg9=E=IgHB>Tg85E>bdY]VX0#La&:^VR8
YRSKZURZYJC&agRLQ2=>&)J.U5I\D8:^CaDHQ?QR+R50;,&?CQPW^-4NHA8495GH
c-3B<_@\F>b0HV>TY)7B:0,J4N6WbYAcc3]6(_L43#D7PNXYLdPOe_c_0=(d/A((
.PKXRcT9fUUPA>S8?f4_9dbM9Zf@+@Y.NA>g6Sf[I1(F5A,EL&D52^TTEY9@()bL
A+O3LWga;@G9g2)<F]DTH,IH1fRA)b:SAC=#^_AWDW2/.8_,0ECc>E^C@gZUAC43
1>H1&1Tb:EUG]91@4-OVFV[^\/2T2])<_3/\^7X8?X7JM/UfD([CHba[2N+4KBAW
^J^&+B_SSb;JGK/H<-GR9_ZR_X[;0I[+PSOCLW<@PgP>F]:E)41TfaO&VMR/]O5,
XU(OT/(0&5O.CcO2X[gAAM]J(1NY&dFP3U,]+:RV.2OcCROJfM1^LZ<cBB@00L?W
Fca;2C5,).f.#N/4?NTIRWD@P^=,95P4^(,?)JaQ4&)aO3cGMYQ8TD5X@bBbU#\T
<O\@&;TKS/\QfPW>32e^fCd0^Tf)1A?U@:HSJK5>T&&=eTGJ5FZfOa#,J6g.P/I+
>FCR9ce[-0D4_&&ZG]V3Na4G@<5e;Lc^.R([(U2E<>8CHO:)7K@CRKQCcPIdMec\
:ZM(KP3_Q(?,KJFg^X72029J.-ZSDX?JOe?5F&C?\Z@<GDZ6-EZ7+);K.b#CN+B;
A14JEDXKJ?XV6)&PTY+#H8=?L.AX>ZE(&8dedL_0?Q=HC[/)P1c:[H/LU6;cVUP[
AZ@VebNe/@4fJ.X7.1Y\8E1DUPC/B5d25_ZL9.-f+H,?H&Ec&?&I0/L=N.SM6IYO
S8J+a9G]+VGK2<?9@]E(VMPQH&ZQ>3Eb5_&R1I]b[B]MI;R6XV<VD)B,/HOWE_H/
#dW8JT]1]R15.U2fE2U<55E1,eKREe/<RWT2;MVMC2FHf=EUe70e8#<3[[YNa.,-
IVF?XdV8-]GU6Xf;SU:58J8SO7Z6K)J-RS>=SYL#0+0AD4MRC49CPBW,-3RT=VNJ
dMeVG(aKLc\VS3&.Z&M(J]cT6#=4&LAUAR<^b?;TR7/P4@\P8Dg?SX<;].FLfKR#
T0ZZO1=H_BO/G2:/;-ID1\0/\0^WS7<N(X,GHB4IXDK5O\=[Y9-H&^@/YZHgfF3/
C;f,3+a7TNE:E(;,gL)Sg)U3ec]A3&S#3R,JAX,7K>_.U)C[>(eG&\JNRZ^=FN_&
INI>N1GYHB<S_a,E-/a4\fbF&[8-QcC+^Q4eJ->)0E?RM-B^@<.,I)Y,d+N:Ff#?
U33N_M+WAOB9Te)N=Ka@F(\<GWSJU5;=]A,-=X=g[:>V7309gTa>1f,#11O(If63
&a69)A6Nf+W]gB<=G_O^,Wa^9Ic)WXBg4&d9=ZC]C?8.9--SKDR06\K^\,H(:_SF
Q:V]OP1-\.e4#W,bC1<,@Q90T38IeO#U3F+:]@Pe3bfKd#I9RROb1M/AX@?DO,CZ
\Ug(eU[X82ZH5Y^9bD()H=QA^^^:(DZ:AZ+-HO5V8ZHYA??1OdZ2RK&N2g^e87WA
@DQLC_K?A/F4@C>f87:QaMZ#gI,0=?Og3VZ8ML2LOId#K#I]YE<fW#F0[?Q)c9cb
8?;+<NT.]S/3bD>?>4LdGM5#+G-QII.I_=X,FMNF_P);(1Tf:GM)Ga1&VNMUgKV?
COW(6/KT,?ZZWR3E/DgOdc415.BfK@HbB(Z2W#XfYdF:Xfe^69D5e_4MUR+YV^:&
D_WLO>]K)e.WdW:;CRN:?/f<T6ggWHYIFf).1cd,DL5fHB\.-d/aLeMc58DEfNO]
A<8ge/2Q^gg#R0M8Wd/H)N&=Q&XN/G>Zf<4#G.-T=3LDF,-&31-46BNY2V](]Oe4
5YHU..:-QTW,bK>C_dAcO/1D7YQd[8Ge;FfC)6&DXQ+7T<NOX;88d.BfM9Ie9>&O
G;bOQ2:U3cTYUPQ0C,U[OUH_7((5@M_VQCXW3#d&U5H[X65+Y1IQ/J^@F\Q];E5:
QJZHUbON[f;2Pe\;W:O0#>F=R/#Y(/RGN1[4BN(b7??dR#aF;.&2W?F&@IJ,e8ES
44Q--N/BN+gYL:Ff57R0W<V(?LIZ.f<3Ic3bI7I=<IP7g1RH5+Q0F&GRE5Af43=V
^J<)X2>JFO2M1=VL_\N86,ZSL<7ca&Z0K^[Tfa(c<,.:Z[R&+6USKY5>DV+#c40.
f3AE_(B?N=GY9Ng-FS&;@/QPT4UU:[TEb4LG3)>E,H4\d0/FV3U7gG<APbea]aGI
:JE_TUfJU],5625>\]T6G+0CC/bQ1Sf=]J7WEVaF2DN.b28AU[Ab8Lag-\Z@Eg=&
E&[]0Z/#LT<?90#W>KA#4aHf^3.@N6-[3eWb>J\Z\=)<8<S.dL7(E3F&8JW,002e
XFG#K/8,,?:XN1+W/@;+GDg@G#aF/)@]<]&<<Td)KHH,Vg<(aFYB7A(>5Hd>5\B?
U-CZSXZ@5SdE8KB<PF+?Sa@1<RC^M_+2:V]>V^,Je83ZZ7>0e\7722?:R_S2fg&3
b:E=?FL6=:2>E8EH@[d\dAE1H&\IC,fJ<>7>W&+J10Rc/MWPeID/P13[CM_&A,)W
K#SK4VSQ:<eJ\fCZ^cgDfE=^WP(&P-B2aBUC<D]H\[=BEBVbc,5cNaD1_UQg7X<d
F?Y.O<P/G[3+JRO5E_5b(R4T)2RT5G>,>$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_MACRONIX_TOP_REGISTER_SV

