
`ifndef GUARD_SVT_SPI_FLASH_S25FS_DDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_S25FS_DDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Spansion S25FS family in DDR mode.
 */
class svt_spi_flash_s25fs_ddr_ac_configuration extends svt_configuration;

  // ****************************************************************************
  // Local Data
  // ****************************************************************************
`ifdef SVT_SVDOC_CC
  /** Workaround for SVDOC CC circular references */
  int cfg;
`else
  /** This is a handler to the SPI memory config object */
  svt_spi_mem_configuration cfg;
  /** This is a handler to the SPI mode reg config object */
  svt_spi_mem_mode_register_configuration mode_register_cfg;
`endif

  /**
   * Initial value for all the timings which indicates that parameter was not
   * loaded from the catalog
   */
  real initial_time = -5000; // must be smallest then all timing

  /**
   * Minimum Clock high pulse width durtaion.
   */ 
  real tCH_ns = initial_time;

  /**
   * Minimum Clock Low pulse width durtaion.
   */ 
  real tCL_ns = initial_time;

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command (DDR QUAD I/O) command
   */ 
  real tCH_Fast_Read_DDR_QUAD_IO_ns[];

  /**
   * Minimum Duration in ns for which Slave Select must be deasserted in
   * between Two Instruction sequence 
   */ 
  real tCS_ns[];

  /**
   * CS# Active Setup time
   */ 
  real tCSS_ns = initial_time;

  /**
   * CS# Active Hold time
   */ 
  real tCSH_ns = initial_time;

  /**
   * Data in Setup time
   */
  real tSU_ns = initial_time;

  /**
   * Data in Hold time
   */
  real tHD_ns = initial_time;

  /**
   * Output Disable time
   */ 
  real tDIS_ns[];

  /**
   * Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_ns[];

  /**
   * Min Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_min_ns[];

  /**
   * Max Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_max_ns[];

  //----------------------------------------------------------------------------
  // Type Definitions
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------
  `ifndef SVT_SVDOC_CC
    /**
     * A helper class that can generate random values for non-integral properties
     * 
     * @verification_attr
     */
    svt_randomize_assistant rand_assist;
  `endif

  /** Assign refernce of spi_mem_configuration object */
  extern virtual function void set_timing_cfg(svt_spi_mem_configuration cfg);

  /** Randomize all timing parameters in between declared range */
  extern virtual function void set_timing_params();

  /** Randomize tW timing parameter in between declared range*/
  extern virtual function void randomize_output_disable_time_ns();

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Constraints
  //----------------------------------------------------------------------------

  /**
   * Valid ranges constraints insure that the configuration settings are supported
   * by the spi components.
   */
  constraint valid_ranges {
  }

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_spi_flash_s25fs_ddr_ac_configuration)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate 
   * argument values to the parent class.
   *
   * @param log VMM log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the configuration.
   */
  extern function new(string name = "svt_spi_flash_s25fs_ddr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_s25fs_ddr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_s25fs_ddr_ac_configuration)
 
  //----------------------------------------------------------------------------
  /**
   * Method to turn static config param randomization on/off as a block.
   *
   * @param on_off Indicates whether rand_mode for static fields should be enabled (1)
   * or disabled (0).
   */
  extern virtual function int static_rand_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   *
   * @param on_off Indicates whether constraint_mode for reasonable constraints
   * should be enabled (1) or disabled (0).
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);
   
  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_s25fs_ddr_ac_configuration.
   */
  extern virtual function vmm_data do_allocate();
`endif

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data(`SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

  // ---------------------------------------------------------------------------
  /**
   * Hook called after the automated display routine finishes.  This is extended by
   * this class to print only protocol kind relevant fields
   */
`ifndef SVT_VMM_TECHNOLOGY
  extern function void do_print(`SVT_XVM(printer) printer);
`else  
  /**
   * User extendable hook which is called immediately after svt_shorthand_psdisplay().
   * This is extended by this class to print only protocol kind relevant fields
   */
  extern virtual function string svt_shorthand_psdisplay_hook(string prefix);
`endif

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind.
   * Differences are placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`endif 

  //----------------------------------------------------------------------------
  /**
   * Does a basic validation of this configuration object.
   *
   * @param silent bit indicating whether failures should result in warning messages.
   * @param kind This int indicates the type of is_avalid check to attempt. 
   */ 
  extern virtual function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

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
 
  //----------------------------------------------------------------------------
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

  //----------------------------------------------------------------------------
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
  `vmm_typename(svt_spi_flash_s25fs_ddr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_s25fs_ddr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`protected
U2^Ib;0VC>J+HAXaPIYJf>c2+ZLbaLJ(Qe/S\PQ0[TKUYc,S.\6H,);RE?[C_#2=
?QK(Vf17@27GHFO;47FVabGQ_JMJ]+9B;dO?/Z&Eg9]c?3_e>adPSZaM3Q+(R,8J
P^GY1VbW\-Rc8VI1I3\01.R]X5]R-G(Z0GY0DG,WF\_(;S)JV\TMTU8[YC5R3.LI
]^UJO[TLc?aaRWbdLH+9GCA-dF.QcbWffA;EaE,[Za&/V@Z8(.HI<XACaZJ86f>-
G8&A_303MgK6Ja15;ELJDg,PNaB@?WIBJCHD(W?c9QRK6VD:d346C#5Z=Q9NDL[3
4GO&Ve#Z4LM86fXVXGJH,=H_+dI,U>+OAB3[E[X2SD,)\E]+2aS9fVgMC4XX-R<.
U(<<?FTPXaKcJdJ?cYfPE&Cfg^c)MbbW4PMXDAEW(X1V&/IQ[dR>Fa&>:=gS0=)/
P^IAg+(M:P9e^dW@67[Z+/MNUYO@g((&H-(A[@B]U23-)J5R3W]Z6FG+UZb+#R=R
RJb]DP@YI#U9D4gT6#cAZ)IM/d6-5/_J47[C:7M8,Y5SS2GSS7H^,b4OU,ME)cgT
0N[I?/-,;g;,+eB?RBCD@JYBW@gI\9>e=?)63N&(cD(&/,[-=M<R=3<+(M?d<;:&
>#8&eXbO:<\T0B5g@#0eXc+G^_eA;BKRV;Q)+OVgA@?BO(HZ;>?N)HMHG0=b,??B
KH&f2:/@XN_:TeBXVb7;L<3>KT(F)3,GOeZa(W):M)DHC:LJX&DX&4\],9fO,C2)
H[Qb8?1B0YH08]1?XXg3,[3>5$
`endprotected


//vcs_vip_protect
`protected
1W.Vf:^5^==I0O,3/VYFe6EZHU#SOO?d[9UXJSMbW)=W+CBd](N7&(-\B(ZL2G))
BdS;4eTBLFR7MCY[GR]5NbA)=c_0\MHAC5MNJ^J5DCL=()BSR@.SJXK99=/>)aMb
L3\H)C9gL+1(XZ=5>.a0Z;VSH9E-_2.J_8B:G?NJ_IJZM_,&G^g1H==XMPRPFEX1
3.>^b&:d5@DPM+Tf73T-#R0?&D>T9-#?aI-.#WPeA4[2e;QR9;:MaNcfdA0d[0R&
Q:K/X0,TRdeZ41,EODC.#:6MR/If^(Y_]<cSMQFJObQe#X<D1b#X\TA_NB3BK^.d
c:3T>.M]H9^MS_@6LY8_S+MGK->Y8W)]ZaF2MK<5+AJRBR0#gS+@QR64;F,X4SBC
M_9gb[3e2(a8g(^#,,+e^&FR8QCf[N:^7?:6R)>@.=&dJ;923Y=0ea9TQSN-T+d&
X0dH<GIDfF4K_bcX<9KI/-\/7.;RRgJ-N+^Y0Tg5IK9IC@Q&GaUS:ZY\_Lg6g_=Q
=(N&?(_(#d=_YKOCWVJ9eJF-_)IS7ObR@VLNVBKOLgBWZ==/cXH6#fS^.X?(1)S?
S,IN4-KWRcIJB3a[/ZW([.4E,,]0P+\ZC7@eVZP3WI)F]SgY35.bT)??TC2J.?3;
)YQDR792GX#M]c22V;B]PNI>DTW+&@Qd_,ec&T?3\2\g&3@DT.&1I,SUE17JU2Ac
(?aGL2]1\UHF4LUQMad#Ab)2L-XMO@1gVc=a?2HX5Q9YbFXEZU4;.L7IB(?,XMV.
fgI<U7a];;)243X.b9/?(UUge-J0TU3:-R2Q9:Q2X.;ZNNaT]_#L/0gB\&bN#0>g
HJ^/JEZ##O[4GSV@0QCPPRSGF97GVZ8Ob#MD[1JU4D>_-#CI7JcVQgT.Q+7:Ga?_
D#16M/]g0fa3:(RCH/IC-Z9G<Rf38P(:TP^Hf@eXHR<1<77\b)[1&THX9PMN.TEV
dYH0^J4&QFP+>K^KbbE8/C7EPI+;6#Q;/a@SJZVOaZe;.^NNL);G3H<X:3;X9,&G
<U?Z6BXJb(6=0>ASG\_BA;7Oe4Y:,3_HJ.=@6L^L0(XL9RE(13]R(EbaF]7c^]AS
9b>ZO9_KA&H[2:Wf]\d1g42d9]9V1)F45M:.>E[_LB5+)b5e62#RLV.]Ne?W2_>0
[0LOXVS[>CB1a?0B<egNb^3WceQ=G(J+<5:BM\WWE9UaR)f:TP^Ne.#ODF:@U+I)
>?JOE5QW.XKc3)QIN2E9KMf78=+7[:.P;U(6dJfMbOa33^.E;.SD]_[Z,4:8dD72
B-@eCONQD?4TXIO(075C3]cg#BK:301-\Z<UOP72-aHFF.gJA#T\5CfKQ2AHMB-1
@95U04e:9d,_8:2.f9Y4AeG\G:CcMDB<Z&:++W2C4->902a\/0,ac>T&Z1;/e:@5
T3)e)Q+=GgIJ7cd0#X<WL+QKA>E=K@L/B&ES,V<[b4gCeVB;;W+/^MOSS13:=(\+
,OA<:6SU?;RB^D)bg]?5deT;A=\&XV,a(][S2#e\B9g,FdH;dULdd,P__KKa:EZ@
RI-;g_H2(f2ZA:aAEN]>QV]&D,.,@ZQc8&ZHGRQ5R1d07\DaJ#>T<+b26g#5B#OV
O=Q2M9fVFO\[[eG-EW>+R/F@Ue0.b476W#ULeHJ/(NV1^1+0^SY=E1U1O^cDZ-D3
9c67?M:Z8#954]_4V7:?VN8AeaXfJD\IFRbb-W9^dTcfZ..I]E\X:Z&X,4e0FE\V
\#7B5f7,,?;7C&NQa/3,;_F:,@8VVe5N;E?;I(7T-:X<1=J:#=X9X&X@+]P3=;dM
Q+.CPH,2gbP)/#V.&+U38=aOQ3cA55b=EU^6e,D;V80X+9EYb7&TB[UJ&4^g_7bK
L:L848Cf?QR<F9e/RaR#^0CQJTVbS/[LPdYfD\dMg.(fVfcaO&GY#YA)WKA@:,EY
)NK:L@4ETcI08?L(5,Q;99D=a4I9S3D+,FQMG_+b@Z/bC.2E.(//XTOAS-cUdB2Q
g)U1T#&[WaQ]\8&J_TVR2Q=gR>T-[7Q.1gNPHI2D<W?H7MRaa@-G-^/Dd<J^QH7L
ZGg;S)eRM-f2A[N\4=_3XdR07M>:OCb2BKA4GecATD-,:XAb(.\VLdBcR3D>#:/D
3GMdb9#gHHITDWFDX.6CF@TdB^<38KeM_a:D;:,\I.GcKA,AR^=-FZaL9?4?5(MN
,e):5dXDJX5<^?0MPBF5;D^8g-a^4IGL(]Z_M61bf#1>I=(EWX^E&]NF]Z,5ERCF
1^Q,,#:\@dI(U):YN)2(Lg=8EHJ5ODBCR2eCV(=@X^7A4,B)W,E6SFHL,&?XL^_V
O#2)U=dJ67_#fVM>->6JKEMf)\&8+Ya]#RBdV+Df^UM_^0J9Q+S:2Ke5g)4ZRX]M
#>QfU=BKRRGD+c#BAQec.G)/-UbBM66L6JD@7)Ef69@A-@:Q,cTBB-&f>(]6/+2b
2.X(#[(9MQf>82X[FA]0CC>D:L(H:5^G^L\fY4<QO;FDS3HVSaA1_Mf+5^ce(cA9
T4KPHY-FgP.>F8Fa>T:[I/4^0.3F>B0J5@KaS]a@b]4.>d0eN-U)F_d^Gc.3c>>Y
)8#d=&X8GZ-LD](&?N^S27K>fQ]U6J8O@E(\E>UII8>W.IbXONQa<,C^01[KGL(I
N.e^X\CY_BN?2][)MF^9;T)bd=C.KWYL5]K\VD5H>)Ad8E:<.a=>;]AW,].J^YQ(
ce.:Z/[.E_MeZ&;14<N[PS.^WL1c+K1,WMX\-3.JgE6WJ/<.9+?7a_)V[HDX0_4;
TT:J6C\#G&g/..VP._b.0/.>JCT^@?[U\.\@8&WAa_6/7fAaYaAAfIYNGQRf-4b\
K\L7)f(d8Na#NK[V-BM/27cNXMP,.F0[5RMH56Ja_CCgT0X]>S>YH0T7YVB\;A]2
=CB@b8H(PS1a=OQ01MYE>[82QZ(-aIAW))M:dH>@_<DN4C1OP_ff1KN83M29/^AQ
GACH^L]46G&1T(O]LP19TP-XQ,FQ-5B0(Uf5BY9g-Z>a]g-_@_L:(@0;?,[QY]ZD
,<L]]KPd9PK?df.00WZ80\7EKJ/Z(Z<^]3]KZ@;^[L+2BP[@DW4dS@N+cBOaJD=N
(V5JdVbeHG?=9Sg8SMbZf)31]FKdX74(U8=K5c/OR6?aIZ7;36)QVe+22Z&8B4MX
>c<^F4FWC2dN+[<G,,b/LO[Db/K#.4)A-553<K8J-?@M27YRbC3aK5[#AHFe(.\S
5KRALZaX8U<>;/W^g(,4ZOX2\ZODT(PA>+[Q6ZZF07ECDSN[O;&M)#4GU.I1#B]&
WYZ.J?\]@0Ze\TDF:J,RK)K#,eQ2aTWOBVa:f/Z<^^S=##C/0fB2DC:HV=]O9:#R
D5U[OKULAXIWaWV1C006FEK+2F->dU3TDS6[D7LD+0=SfR1AZK20,\/dOV0K=gTE
Df+c=./ZI:UX.O.<Ge07@<OTV2-\cR2]E[OAN[::3ERU[aRI(6ZDb403eYaEJT9D
MG9P-Z_T&0[gBKfN.HW6fa\Ge,b&WF.QM1?@.=S;FL/UB[MaY2#>-CQDf(I7O2>J
#71@aG?#dLLAF+R+HZfI_8&)7:8fCWTW5VOIP.6XRb^aD\2@=,LKVc7]RYS.QIf+
1A/&a@)2S+U9;48Q5XRM=KD)FB:6613CJ6CB(:;M[N/V32^-H1VJO.bP]CJ=O-K1
PRKW?#EE<EJWQbX2LQ^++78QKF]1_O4&/DEPG98(=f:[VAf7AA:_T6d#@/6@KHdN
1C[c]L6e.7O.bUCS(AfOGJGaW#8L8Wd:?Xb,_eHKKc0.K(FQQ;+Y7Q5aJZ8XXOSI
CP//L[Q-@&>^Q]6.<3<f)P]A/O7&WXY4U,6>1,[MG4Y#QCQERD66&YS:@(_8;d7a
GZeFZN2E(Z<&JUDBFWZJ4F@Y]=H6GXT)EBUKB)@5+76L69&WB/;cK2F/2[/F4&=^
::fL2T/@Y@--^]7<\?e_2,J(8V+4/NHM^3E)HOOP4GE1fGX5W&H@5,?H?G.TR@Gd
;U@V?3P,NfgNX@H#_.LV;A,3U]T1(4,/2;bM^W41UR3cQSKX;FP=(e\+CCf&W1#U
=-[aJJ8X-S_V^NQ+cI?Ma_)[aZ_NPF,eMP9WRgGSZY41VMe==0J[+a&C9Z+2PAG&
[d;@#RM6bS-5:D37S#gEJ5cfH)58-]XEDd1e:;Dc7/c0ECDY7H8B5_fQe3bT2-7_
aL?(V30LO89bJ&]dR90K)ZN8bRKOF0V?:Fa.a5]U-9/2:H4?ER95G<NE)Q7fGT(<
/#6b35>XXT[4I-.CG?6<gX37G.RO6RBQTL=d-3CC:+/_U;)6bTU__;&0(.J@Ra]a
6+EYXE/D>W_VC&#+OKc>YO[F0DEM<EG0(W9#:SD&0^F1#bg/+,E4R@\X9CgWHd^g
./[U;V^4C>M6])G7NNYb]=K2(B\c\CVKE?f/NHVd<E@8a\I5dM0-Ca-)2\\3]UZW
XTOU#Q#.S<3N>B?<-eDWW,-#B?SDWQ?RD]c^PAE8VU5J8DWHI-U@0-;J+GGEUc?#
JMOPgUD]UK[@YZM#:P8]e-0P,#]3O3_.6--_K?6=fX0B^_\TXVXNJ8>9_N<fF0IX
cN7-+6,5EJb#QSJG#@&6@EHBf4_\4BY^bD\]Y0?EEY=;U3B>SF>ILLHT8MSO7OHc
Ue).H:[EDNU8a_E)K:<M2c]5Ff3A4?CZF/-dBbf3E:B(8H7^S>dGJFd+R3O+/ZLM
\SX>_2])^[@Ga1(9A87QKECaTBa3.)+[)RS2^SRD:]cME_GaKdS9\G74(Q;5J90g
=]3N<GVaKBN[QTM<d3WUFT^eSFW=:g0LU0H6+88@:7I^D:F5;<(c7(L3M(D1:[EV
Z0fV\S6H7=\/f^_5dM;/[]L[aKL-8]DT,,\Yf]EeX#VCH^b>4WNa9PaHKT:E_1U:
Y24/f9N-3^-.?F@Dg4E[#225Z>e^\U_H22W/:3gNA4P;2N+?#/R&:#e[BL+5PG0[
HcR_GS7>2JO>D/]1C.[HPS^5P?AcKgQd8)WTaQ0T8C?Nf;9Rf9>UO?gY;.5LNaH)
P8<c+Z7O+9V>V)S<8f-4S+YI6@JP>[=Z9X2a[Ja_Z3+KXQ>WT^I4U,CT&.N1_-/1
XL;Pae6:PVD:]IdK6Y/SWF/f,-Nb3SWD.KHLJ5_AA]Df<b_M7&)<7/+W^_bI\Q>8
dZ,&S5a]?:3LZI_^J+]ERCBG8cQ]CLFBUWGMeZFg.663.?RV>KAgHYDd6)A\JC:c
/Bg@d1S0RB&,;\45;L.;;?GWa8dc\?+S:>)1(Dd#Y67QDU:CS-<d56Da&6eS[BN4
HI>XDcPe=W@=1=SdMZUQ81fb[_&6I9Sa1,2RHQ-7QQ-QCLD#UBVfPfd54dZ5>Rg3
JY=dUOT[FW>D5b,,/++W;S>=\56++QEIY9/K/]Q0A&9D(AW=ag<:^8_A0I8M:\?3
E=7;^GF-]=IY\26R@KES_2bN]BN6>X\R#,T3+E^LYQ5(0ZIK_ge:R0_KU,J-4AZe
)-T6<AAf<,L,daLS_[5^35SR+ZD>;g+[H[5f>(7TSVJeVcY>;-3RWA];Ra96;,-F
32W3._dN8CCY\0QTdZRF5,_YVX^2V5+2UK2\F<?8+Ca;Zd^_YWN<<Za)@&5FW1_N
3g>^H2]CbO,d1,IXCc[5YB+P)?MBdT<2\6R(A6B+CC7_F-AfCM9K+2N]<)?^DX,W
=D1ALS<ASAYFa2gDH\afF5:-WY42Xf(;=H[V_&ccHBO+AG/O&G[c#:-?31AYWDIF
5DAg+P9^-<,9AU4-T#9Gd4.-<TY:7YHfA7:?+Y0UQ36L9HJa/df2O-KZ.XP8<,/C
:?1T4d(QD?88732A9DN4a5PKD>E#OWd]\WOXg(Z0dTcEO/BPF)0/^X[bM5e74RF^
0UFRN3@;9G@dRB7QIWVLaR1.\-Q1E-CDPeBEgMCYO#.Y:FdDdfY2YK(c;YG(3SB?
fD5IKaFU;&A>FcfSfW7U?2)=E;b+f?C[-Y?JF1\W5>FBXSST4fbXG,H56>M@aU1#
[U5ZQ>:F;JGR-UC_[G2FA5UZ6?6db.:PF=?cV8WZ0RJLM2.OfI40[K1=Q=@[CbdA
LR/\^I(aXC@G-7C^Pf.^Dg;((fdNDE/)@F^LbY_-0Q>Z_#d:56[Hf99;&ATJM3?b
.Z1HM3]&cT@Bd#]UQ-+8b@e9E9+XX5YCUWJ+/7HO+\08?^\PWESIEY>98B)L@R?J
D5ce[Q)8>_DS7dZU0(IE0F3=<V.Z;?fHAN_(4JMN;8LTGT)-#8WLD5X,T3e9V9gH
K)IYD5.3M2-ZXK^\LP,LC-gCP7][gSUNML(0L46B48<5#f-Bb:O:JO)bTCX]f6H,
b,NY8=5TRS;:L7E_c;D--GCEUHb,),A,BCJebKZSBK0)d?Q5ZW=(D@/Yc9Q8>PJf
^;18VLd268<VbA#cB\_1&bUD_H^QV6e7J6&XFRC/I>Ae8&IDBOMV+EO[_U^feFW&
B;(9bI[f=F[?XQ^g(Mebb<9,>Ud:N/R\Q;6D,,6JVZWU^#G1XM:\+LcMg+e]C\CH
U3BV?33ReB6RE9@WT(D^FTe=Cf4a>1FH)>g;.-AV\S188?=bQ-9H_R\J98QAJ,F8
:O1Nee1E/b9gW63AJ9X78&:)(-X.:;)KVKQ@VTN7<TH+N4U2#c=5)@_=d6ON?dbX
-fIUBYgGFL=TTI2/MQ0\X2fdgXA]_XJBf3G+],F<K_f9&P)V,&&4eCVIBU;3Bb[Z
UdA?GAOH\FI=aWX0ebGMZE);RR]WKgZ)7+1GPLV4G2Wg>[ZHQO>G1<_CK?aZZ#Z)
CM>@KFZ=<,G=BT1gN8&X;3;7\a@e1LbUNH20=RJf3JTL-06E7D(>7CBZdO17XQFA
NFF6&3:aYM(,J\f->F-Zga[-9eML5MD&8(.,<Ie)a@B3@SR3D>#f;E[bc5C:a>a@
3)YaF6YZ[B,#Ie#^WJ>eJ.D<Q0GKMH4GI-(dK:a_Bd?O5@6C-d)WHe/W^:gXf^/F
SIQPFfIg,C8P9K:&_\M(D6B?9#]:M\:TMN<3?Vc)N[LL6IQ2==&IV93N4#E[9b(Z
eAKA<f2V5Q=GcTCDAQN(Fb?Lcb-^)(LX#.O+A7_M_?[GC?-TFZ6DdDL]#4-MbYHJ
;S/)I)cNcRb7Y9G)QCJVZ?^N@FMC3HK;)H1EJWcDX](6G/4FV\UA-)>Y@PXg:RW^
X0^^?)SD;R+?:SF;aG=DW;(H.SM;Lf^Y1>]T]B>@P<5\2\R.WDKYa0W@d=b:@gE(
KD+:E?91MeXS_e[#01JY^E&\@2V)KcV2(<g8?WZDZ,0YGN(Bf1dRe4T;=0_TKR?6
,<ZAX^^SgIc>D8A[B[OYNT^.@6cPQS6-LeL462?K(-+d11,7U+b6aQN.Hd\.abgZ
)]Dg=P#+a#Z1.f[B196T@=T[^^RLXe>IFWHI-4<1RK/QRE5AFSA9:X-W,-MV4Wa^
FV/M-MZJC335Sf46WaA=^/aQQP:R:M1WFR=7B+&72#+KC+2-.:G-7/8JHdA;.O1V
73_8f^VYBBg98afI[[_=PX?gS;1]gc(3S3XM,5BfgHfc[bf-](^:W)7Ra,E?8;;4
6#@BGcZP98HD,)JX6ZG..d_5;^8aY(T?AdeJ<>_cYaKg&MAZIK@MV#d[e?e.B/>H
S1]XY4[4]R5S?F\(C1-g&B)gMQ5[6IS6,M[?I;J9<a6Od)Wc&=+4RHB8/9JVRgHT
F&3+aNYc[Z8QcFN+C;&5SHL5[CTR]c:>=IW_E3:Y_I\5)1#9DDDe)4U4[SBX>W//
>1d86G8^eWWJIG.cY]K1We9XK>M6.D2c3&6O3EEc]WX8Rg\\VC[f]g,A:>Gf):[4
#QfO9?fFM?-=9DI+6WSW_6C=2Ae.5P6?C4Y(e:#W10AF2\a1OCZ+K6bHeSX^NI:,
G@=PbH->(B1I^47?e@#0YH&@G+IF)6[O>#BbZ\?\7[AD>^Yf,TIfbgDQa8@fDEJL
Lf3d:MQ01]5e-MP0:_-S>&J2-W-:I&H.D]8JIOP(VIF,_d06&Zf;E]eT_J=a@gO.
S@A+6I)Dff4QO6(@@&89A#d?]?,0G:g-4IOc@>J1J:(:;R0VbWXY>WJP^=[8\8L3
G8=:#U:@?fX7I3-P7cW,a_:8^b\g0I/4fMLf>fGX7.HQZdSM=CL0[AWWa;]?RA58
06YOS1R]a2_fJ#1UJFH4:?6,d(<.,R\X8QTPQQM\;@,g#TV.+fWVd.S6GU4Q<NZa
7Y#3)aDI1O&I(Q0J5>2R3Je-YNa]Q8#5<.bdJ-[LT48Q7Y1,^X7P,XNaD<9TJ&=4
#MNX6-^GG3CI+)(9F25Qf([]C\4MYYT.+RE.>_gQ2E,P\Ic4g,.-/>Z_SYf&:6:,
Z#CA>06_4/ECfCY8?,fMQGVVRMLT3E8/4UJJebKZMJ^+S3]aFIVa6gVa8KU4\d_\
<GYT+U:E>R=^^G7@BY<+^=X&D)P//9gJ0O4dZ:e(eca^C/14YLg>4;[b@]<V:ST3
R9?G?Sc=bN>]&&NUPa=-4>a<.BCYe=ABT9^?[H04\H+fQaY@Sa&CWQ5>^/_FJ3f)
3.#<\g644^ZL:EdBOU;25P7P0R<259\FW\g5)@F0#-G./B6R\9&_-UC7KS1IE6?]
#S^4BO@f5Qg\(ZcEDJ_8CGIP1+(1ffYU^\&#[62,ER<;37dQ/T:3_R\QTGMe@W=[
DT=0/)Pe9fAgQ8?D9JDO,7,<NGS>2S4VDH3MR+Fb7OK.4->6P.fTb.^e+(-:bN5C
bM_bK+N)<<J&)LP7PM0.e.^5@Q)AbHV7F&P=OVS_:abA5TO#)a/HTX+MRP,IJaK:
agFf;Nd3T]^JGAd<,=22H2SE:S-b)?6^RD.]J)S>a\\#.S54_a34PUQTb9OXG@NY
PKFb8SI8LQgd]Z4Aabg05;9>Y>;S1M=a^(]0#KE=(dWf6^0Z95.2P?-I_f?UPaMA
:TbK22OfZ<_I1eOHS#N-=/P,EV>e9K=K5G+&G07cLW=B(g6^)edc^D:#VYE2]H=?
-;&9f3U80OZ)=8XGb(cgVUVVH^-@3bDW>6IXI8?CE;W@4V-@UgC;P(4KMHGT:MaC
4Y_VIa]L.cQ3CFMe9?_M/T@U5WY-B2_>If6W,C7;G[7O8OM<e=1T)@2a?BX5I7^a
e+H12S.>PFO-_H,d@7L_\Y]-MTS>f)e\G,6\[VaH68M5Vc1\QMIR^Q8T94D>1[aT
CS4Y#Tb#Pb_]6+6WEe7PXG^LWB3/9#G(D5>G&Ce2B9>gbB05.)g)WON=-aYAR8C,
.AKeO1RY7;3(g.=C)9A-^[+]<T]H@2?/JW?7?<Y[?ZTJNTT(K[,_H>9IB=(SUKZY
,J((b\/LKIO7)PVL?9TX0O?ZcLBR4\@+JY9Rd#OU-:(#WB]6T0<>8.7^KVB+[_3N
]PK,dTPJMB=ZW5#=R1J?@5MAL@bBIcU;J(/bQRFP:/bHaeb)Q#3HNeF9]6BB=XV;
b5Gg0S]aL9;WMUe:FTcDU?R)+cQ5\Jg78^6I?b[\4LJ]?(#F_:I>2H.]#T2g7Y/0
P(N8JaU3bfENS[1dJUHMU-=KF;)AaaeDM?#9&V)RS7GET1O;R6D/eR:_KH^[]5PW
R0TfNL\#+.eDL0[28VAR#AfMMaIcZ4,YWO=\?YbJ@F8+E4[)M@Z;\G(/HBNdAIf=
1ZT)&e(+Q8fcU&cYN?@2O0X6>Fg[\e[-c_7cE]1DUGZAg3GK4::.[1IUY>.eZ22[
X2E,UJ7;BSYQ54G+W6)XNO.a&N/DL.1\L=0BC(ba<9KEfK5QA27.S:&410C9S1KL
M1.7CK^2==EI2)1)Q]E?Rd-I<O+>EV8+gUF>?SQ[DA=\,a\-?.F/ZGWf(I]<7NKV
,ASOC3V=^VV[bU1&0?Y[dFJ:JgHSWg;3L/(H.dV-O;LgX^=Y5NH8L4&,OKe\5#/H
#I:#EZ:H/\6#=4Ve(c8?23Q1^-@U.8;3)GT/gTO.7?fSZ785cc1&(-57#50F02,]
CXaFQQa06EN7=\bH8TGV=&=_L\X(gG=f0,-UHVV)K99c2a:)@(63+M)77A@/EOb2
HRb#J7fY(6WHfAdN691T;U/c&6L,BfJ)L?dEVBM\Z/;U:BF&,+;<39]cD>N96:>>
4MD&+L9gdg0Ic+2[b482^48E]AIb6[R(a2LT#77gc(O^BRFc#Y1aLE=V\7L_F-8#
2L7OXf;MBIO8W;B-DOK?3^;[fF.c<fX\^8-XF(_V<UK:e>KU12N:K?_^&7;_e5DF
1a0\SQFK)TA^bb&D01VH6.e:T7O[D\Z:H33KX>M52Nc4EC5&9L5/eV5<)#OCcgS2
(B_<D6):KM+<OgZMH]+.6KcH[ZLLC)8D5OFQ&)&\+.S2V7(IbIPMb,DJ:(5dCM:_
=F[JEHI=5&3]Vd\Lb3JNHP+A4cOJ<:<ADaX,>7^56E21P&I)I/Z8cRe:Td8P\3D9
M/P:@9g/eR]c>T<EV9.ZYUZ_?5^55)_Pd3VLRff8[/:K=30_;fD_30]gb)7CcAd9
DVgQ)C,?FEFT/a>=LAB\J_P_GLHEGU9f;N1fV<0ZS=A\<F8H)>MO\.KUGR(.2e:S
:G?eP??cKQ-,__8M>M[N=20dTNM<+3225dCJUTFI5E\R8P8#^N2Z?d-5&5&BGJDM
A96QA;.?3L-YE7g1EZCb+?ddCdf2.4cbZgW(W+(/f,<H5AF<PJCI1DU8LH6]C(R4
RNDD3DVP#98+5J\G\,&1H[L-QR)UDc,@JJNd[=E>F>ZMNJX75J0ba:I2O=NI^\-c
]0/-fJ_6V#IT#aU0DYPZXYW5XC?L+BAeJ0@9-:-NeL2F#c2.I7=Y&HR3YT97OF-V
)<bL3F[@fDIXB5Y;_5&K]._dN35dAEU3>J&^gQ61W<N-bV4gXc6J:=L=dH2Y1X(&
.J\&+LQ4F=a;AVD=K\S&CSI8]Z_8,P1;f.dZccUeOTMZc59F@D(TMb(Sad#DfV]R
?:ROM^1OPO=I4CL+=>?+0c:g<5MBP&W#97B-(W[P@AM2XG0-O7E9S7=\(^-KYY0+
H-eX&(49=eIZEVU)8M8DB9O:22GZa0C-NJXY5L0IL2XQO\/XJ.O8L@<_bEUc81?Q
beJ8cd;-;Hf/Kc2U1GCNcFM6>V(UESSY.K752GJFKK^e9GDX/V_-PF3>YW]3EgP.
0V,=9,CKQFEEVPVSd&g.(C\<[ZcS9(OUB+?D\dS+/c3<=VSG&E9J2W2>QK5N?)07
71/BB\cDF6d6e?HIW/He(^&)Ub;0SYOaH78D4Z/U#YP)>[AfQ]c(a_+4=Y&THf7@
Q?AOH&TK6#_R&/I5a<7ZYaLEM-[(EIPJER9\Z1/P7C/UEK6b7Q\,WPAK)5518AX:
MVLP8fU[X.a2,90cAe-W](>NKJ>Q@+D1O6DdJc4,4\DP_04;K^18]=dOEg)Aa8A-
<4e=4;QYKR[NFK@=U:#Ma,660BN+acb.#C;FSA1L[^KF91<#<eXV<ZF:Pf9@1DU(
(bSKc/T9DX3]S5B_OPF=/Q3-^9VH^4KeAGC3cU>(WMD8X8Fb-1S7AB1g:IP=4.cX
\=K;;;G2FQ5;7YX;,I#ILdXA9_dCFB+V<H_9gML+2B.]R6->WZJ8Z-<Z^=e:[<)^
VNUdE-Z.Oe?JQ?S#[d7E_5,2P/gJG3GF38QUC?<dBfH2S&:)>_OUaTN=47Xg=:QH
a^PLI?-YAU/^-I32;>dFfd;7J:.UGe55DM]eTN4d+E7NfAUa8R&UJP/6?<f.]S]Z
+d[/S?3c-\UG8R?&(:H=^HCO8>IB1.0;+_Y(EFT5K[37=Z,XgCM?JT68eJP/b]M3
QE]YAL#&6cIdI+,gP25@4CC@W^+YZSV/dfH+D+DZg+0</4IBKSR?JV/OdZ07,&E5
29]=]@Sa.c3d&#e.d2M/USZe\aX<_8=6/fMTBSJAHL/_<YFG9UNU1W]4U-7FV-/O
28:8>H@;3NIJ-3EN@AYB2eA&fZ3+L<,c0HGE6FH&CGZ+;Y4Y/&)4XcJ\KBAE1A,P
QC4WC]#\/@W0FNI#33LE?WJ?H0?SQD&d7HMgZ<P8gUIR9V^?aDSd:<YUQ.02ZE[#
bE2UGN\OSF\BaJGJ4LAJ6Nd6_D&W\aLE(_S6b7.7fP+CXDA>@FU1abKG(&U6U5XW
&7B&:R-K]d7,f6DdJV#=e7SHK_^KF+9O;.TYHfXOX:&F/.EIH4[aVJO/2H6H[c]4
DO5LCALIb>U5X/PgSSNY=SQ4P?7eF/BY]YQV,+6f8gZ<:]1AK[^81I\ZGCEL4Q:4
0&2DWe8S7/:(]fbE@ZdHV.W0)c=3S)9TONdPP^g<DX/b&>ON3X25?RL40Y63,L)Z
g;&OT//,CB\EO^;B^U8@NQ]:5Z/K?],1QB#J9N9K;>>5NSUX]8H=_+Xc,5_F-A)\
dM_(/^U=4PNEPNL@SA7-^aD4B/f.S?MRcIc#7BeX@f<=d=CD:a<;9U@eeI87CFU+
#=\Vfe++AB[b,_(L2a\I=G-+DGQS<GNcU=1.N0g2-?>0W6.OPANJDa33;O-J,,>\
0N_b/Obb^d;;70</_^_d]c1+8]4(dS9Dg;M1fdRI\bNRd6PLW^cNRfOV8SeQLV-a
Id:I][2:@a]Z<N0GU<G-6TD67Z<^TG.#?IP^/1:3B7H?;>Qg+OBLgH6N5NbJ]>DD
]Q9dEP;F7d_W_8R^.)C^WY^_ZZ8LRd41RXbO=&b#5V>QWH.g<PfggY0I@<M3bdAM
I\0=QIT/ENc>1K<^3QC\a1b=WNJZH+=W_#_8TZ-OLX53M32]G1_Z\#?5La54OZT5
(cc]8T[9AWW&8?cKXRW/V)&;PH^IH>O1,/04US0EgF<>HYgf5?L&LXcMV(g6:3fB
.0VXP9#2PR(4YL2X](3P&+RP#aJH6<A.)3Zc:a&E(V5.YE8-\P);b0cGdS4#\4>V
7#AA21c_:0R9E(Kc[IQ=WgW,MU(.Vb=L80+408T)O2[8d.)U[D?HFfO)cU=@b6Z8
bXPNTV41BR,bgNG6Y.bYB;E]JM#CcS^I/MORK>LC/?=XH^,5Fd3?RDE(FLD+\H.T
G4,#X5P-aZ,1Q)E)YRGR4/G\NTO0a=B1=O-6Z-A^<NP2g<2;48VZQ1dYN5,f.?.H
Oe2e)6Tb\g-3KF#<A)D70=?W0S,ge;6^d:bA-LX.SIT)S3@\+Z<Z0)f_R2W^=PI?
a#faZE)NRT36@],]A/9]\VW74dYQUWTV</0MCW_1+UaTP?QV,0;Vc7H<<2K&3+6D
^4&@H((C0D@B+HS7bU4YaN7dD+bBeBg\8WegIP^HD::WTQ_a-F2@eH9[KEb]18FJ
0A0O@_U,^6K^7R9U>+^YgD@,M)UU-#A5SbO[MZ[I,]>;H8B@#5JZNg.-4=:bJ,X5
]ZW>(X@(=5-64-S]0(DQb&I4F846&K2L:(B1?U@J0Cb\TYH]52MQ-SIXGQN91^,X
e>Mc0Ub?KHDd-Y[1GbAOJ7A+(3a_T6aKB^>R&(RQ3-@65;8A@LI.A>=^=#&M72Zd
Tg^\b,gQ/_Q.@N6cMd)e8B7]B[^ZL0QSaLR&Ve4(<:K_:^c2ZW1(Y;?G+,0RL&@f
,(,F2GT+4[VLQOZZ,eD1^F]+EF48Ta[)[X?R2ePR,=fJT7ef5;^_K\I@029fC1Wd
0A\CQJANY6\0D<^9,S7S=RIML0cG)>&1Z5]Ta8V>&\)U?F-TW_GNfAI@55+_N]@B
HP6Md&VHH[F+EXT>LL?f9:&0@=Pg>/EKIB+DY(7O>7P(6dRA[:^Y4.d82[9BCf1e
NT3F],f^W4B^f/eG,afBSL\32=[(]1GO\bZ?)OT,2(/].MccaYID=Afa6M)(>ST+
DHEW)GZ_,a]c;QB:dN+P.K&7:JSAP/C(;;,b.d+(BcW:SLUNL:5BG?VPOZ^_8c0L
#dCF&_2-_EW^X^S#YNL.]=g/=L94[I(Z0XA=QW0]S1?2@C6]2XU)LCH^.c>,d]?/
/Be?NYJEB;2W&GA#0\&76M5T3&UI(R--#)_QD30#LE=<Y\&_[,0G[#e2#LI#^=4g
K>YBM^FIQ/-:3F-,T+/6eMceL>1=+bgU5,eS4Se4U^Y0_&@(&4+90]Q;aU?J&1+&
a/X&HL=_&Bd[@+V+@,S:E3/+/N^Ma;4LT<-H-fKN(-O6.Jb8fSI8D;]Id5M03SEJ
Y(NRM#N^YXCBff&C(:A9://0R4^1YLN\P&B@<JDA(OgDfHFH:4C.=Y7W=@?PHH&c
]+0JE+MZ7[8]K^B?MQ[,;AK94,]Pf+G5.S3I&?cODODJIFJHaTY=DC_&acS-R@cH
+b2YS.EK7e@U@9@\[[bM[gSEK@0IXbWM2=G[V6TGf^5N\[3fH>,ecG>APV\[^7=X
V_4f=[ULcJ4RgW6R5.c+dNb/UZNM@+5M,^)_0P.]W)D9bGfRaZYW+28g->.&@VEc
#(e2[W7dV6Xb>471Z\H&bIa-fS,E]3GdIO??9Yc3LN6IagCX86>2)1U;b]2P3<aG
5F4[78=SRJDJ]3S\c=ZOFA>F_N1/&BW]+?JM)(:NTRWDAU6,c_7\=[PA3>CPI9<W
+PYf-bgXJ-d64TMC4F@7(eNGI.KS##M<CLR825VAa5<ca3MCGgc?YRe+QcW31,4<
:efC?W[^?AY=Yb(Rc@=+Y54&N,+47]Ag[,#P,=S[)2945&dDH6]b[V=eSUKB[>6]
3d4L9Y+FTM(;@+d<_dB2a=>#7\KM<@)COYCQOL5OSNDad/-;E;eDS\cWK^KP#\HQ
NE:J](gT.L[8;.(f0G+5+bU/(]AB]Y-1UU3J;5eVcZE(.R&L&OY:(/3<&M=D7c,M
SNDBH3.GbZ5.5f;P.=]^.RG8ZM4D@f)_^CWBC.91ZK&0DO+8e^,@16K2TMc.FMf]
4c7^N(Q151QGZ]]Hc,0;2T&Z=M/U>2R:N0I;E[=[bfd2Q@P:I8K;1,(_YgE1=5#P
1=#;^PCWHR0O(;>:47FX8HE8Ud)@8FWTYg1>1JUJIYI(+Qc,9P(d.HeLe0O,N;Md
Ic7N8>WT@/c75WL&+#XReZ)Lf6=;0BUDQLbPf[D];L]7dTWYIO;G96XG@Ug&eQ.O
-4.d1LdADDO.87b;a5ERG>/F7.UC]S\^/JSa1L/18gGJ/YH_BCWa\VNU3#:KO7C9
H,;Cc26]:4^>Ya#IWD/@JCd&LQ;00T;IG<P[EI\<<D^G,25>._R6FLYO9HU6TU-L
1#IgKaL0N9J-[)XLc&gNeUA6cJ;8BY0)G(.W+O1[9<EbXZYPYAC@_VA1UAeLcJB]
W,SEbBDT/G??FL8I6Tc50=UY,W]]VcGBaLeQH;C(VVe_TTNQ)&\eCM;2:)YM2@S0
3b&2:)5Ggf.]\[XG519,ANC0Ncd(R7L0Wb]MgM,DA#A_\)H&0bcSH24Z30(=I1T)
WK8B5LC/FbK&b+85C(WEA(@GIZ7_7Y>e6-J3_6dNVIA27;U9gMaX4Y491>F00BX6
X6U^?WZ\2KN8e;EE7(Q8+0:HK2>1O-e35FCS=5WQ16P<W<fP7M9;8Y&f9S39PG4[
[D0MQB&Hgf6>b0-1;\LbTeX[D&dMAf=GBB4?/1H2.R11)1[g:0FSU\f>&6U[A9dU
_^VIYV-Mc_QPT=;W+,>@BP(Dbc5^ZP0+B(JR@c5aDDc<Z\01/Z_GeEf1@K8YB:b:
P8U;:(6A])LW,GD5cQ5@3OMLbDO>E6?:;#Y6Gd_YM-(;cB86a,5@(#>M+e,dC,1.
;=(;GNO1U.]H=_)3<KDK4Sc@6W]P-a>&O&eQ4J:8U?>gV.UUHL46J+caG9I[2\&e
N7d0R4/\^Yb8&N30&,d3f<;-]_(2g(6C#1@Rb-BT[:668e::,eS8SGO6#R<2N+dV
GX5DZ_N2L?Y#A)=^(^UT5#XI=I=UReR\cYJD6)g@[a[bV92:+Rc7/?bRaH)g/:HN
]b29]\b2Q>PKR];PFEK9(\^UUcY+f;:FOgcK:4Z2cR&X)XGW\4S,XS0#DP)FA#JU
8aAJaf+:N5OC-4;5fH>P7X01QU:-Yc_0?ENc>FB4_(c^U9FdQ0ZWA?AMG_(5_a1J
g^OBO)7W)1ZS.Ra(T4>,64;+UL>K98NPM4S]RLB_g#KH>ZcBe9NG_KKc<5]Y<N^2
^bXb@HF^&GIO4]-KaT0[-;PTCEfOTV@]#\#]>_.39<?D;8_LZ^9H>(A4XIg_ZC^I
f4&?,BVYO][,,V4/KFGVS+O+J_0/b=-HaFV6H.OSY[W.1>90W8<+Z/::HH@+?[IV
cX/IH\OTTQB,J=+LLWg@D/,gX;0&WZE;MB(N?e+,X^cT\]D)-ON.S/Ye#6=EC3<,
]BM-X2B0P/:GL17-8eLRN/+Z2EB]T,O.;Q<C4^LY]9-Vb6Ag]>N:Hd]U.Be8f_#Z
93:_\IS=ZXeT:1;J2)T-8f5+.8Ldf[F@S.HWKI<-+CRR0D07IG.]f;6T3U+X/)X4
,-5C4BMY4=fFJ]JGET,Xf\IVT[KF5?EfgIWBZCUY)],0CH/_#ZDFNC3FP-8Bb->d
7>U@KN:>2PNNPS]/]DTU;9//a[D(b)H:[\_;?H+7<PG:Q\4;BJO#Y_P2>Y<CP?E2
6bO7K4FeQEE^fJ=ggK+Racc5:fFaV+^b62fNE4eUZfNU@2D<<7@KCc(]RbF^L@\6
#?Rb997aKIZH_e^RP#)d^(6QKX<LLGSPAT-KHZR#fXN-S=0^1O\@e0.)D8\-b:+?
R9_E(M+3LeZ4f&N3,=JY):\<->8<P,_XF1]4XLM&7YF_#?4BK1P@@;c3aOC/3e/2
-#_f52faW]a&>7OVT>Q][\)J.WOSeXT1;</bJX-F=cZ4[+Ma93ENX.-O]c56C/WF
-RP+fZB@G3Z,SD6d.F/XJ(f80H>K0[[b6dWO@E#YL]d)UQH<.5bT(?2Wd66H/4bC
1RV+8@).:330Y-ACX5Y&BFSM?+=SN_0+#8^PCMAa25;)Z-DP51a^:.MZ6=6^<]?d
T710::P._[&2:LYK0-D@NA79Ra,f/&@J34>f@SbR,8BF8[VL66e?@^9([?dd-&,a
J8:.-fT:B-Wd;bFU(5H1O^-E.1&]:FgF7C@(R;?0;9&B-c#9REJ;ZcXX[3cDCP6H
#UCF<,Ed>B7@1[(,[OG&Z13(YE-:SaMdA61#\b7P_+:Q/DVEK_ZD#M]MeNVOcVMd
3V@B>PV\@GI1=[E&g0BK=A9,)QC6/N=DWY>Y+g6N=QF9C<H>TQ8Dg6<,T=H^dND7
,F,5fDaNIJRS0=)<Y\f+c_G-U(SHL4,\)B\M=1YV=BE?17EK@I50(_B32f2[Q?Ye
EC-NW)<[7D]_CQ5Sa,?-?,?>fb1bE3HL7@9MPDO+F#HBH7HKN(05Q8ZN3+@H.Q^C
QPGRU5@b6+6=5#@#AH8E2#BZ=0=:5<F[8SXCc)^H74[/HF#[Pb7gRM):13V4-0^)
I&N1,/A.g4:\-N080)D9;264T?dEA::-I9>I[c,C(OV5<A.MMZ:9D:)8=EZX6IgZ
_+gSd&KK@/]A#?\4FBVBT(^IVK-MODE7@5;Q@E^C<B3\A+egB8QUF\T[d;O<4X.e
/KfOK[YQ-#282W_bb>?;F)31])@I:6fc??5IP6DRFWge8&75@X5,SFUEH?SOB186
?8GTV:Wa\EIT#^+5?AW\EPg7bW=OAaC,2CIOeBYaEDb>dB#61F9b2N2@f?SQXBc=
&>?NOEOX#dFZPI]0#QI<6EVOG8MdS8Q+2fVIH37,f=dVKeZ5Bc_Wb49Cg;5278ID
1X_9J->034_TKF77+cY.Q&(\B;bI(OQ8Y5+R00I8C,e7CH_OY:gde6>f(d-,;^10
3P5=/73W)TDL4Xd,FSO=dEQCBf8.FcCZgKgH70.U^)_WN2N>8N11#<0P]:Dg.&Y/
JZd>I7QVCNG3;]/O+-KEL9131BD]a1QBGFC99TRT<da2Q<^:Z(RAde6;SU<MK3dP
VI66I5>Z_<63X/\7XAK1.T+8K)3_0<dD3gL(Z1:;aI=3W-eD28<O@BKSbE8A(?>_
TNa;KF8T8SPH;d]H-Ma206B&S)G5Q1##)H#Sd;U&0)L8d5aHNUPRQQP05G+=G1OZ
3\C)9f1U;)VR2T=R&PFf0+#18/I@4I=8<e53]2)LDHG#Y,W4;Hc\H&.8RAK>UdQM
EIS)/7c8IZ,(?KZN_/6#J?1ZWQ;:PQ]))6c>##-G-(D0eBcT<7+e3@/G^]87,N_B
,AC4;da[W<J_:]R:FDEZV52ffH@>UF5JZYTW\6U()ZW&5^<Ob18>NH2VJ\1FA\?J
/PZI,F059./[=WT/[?7:]f7=F9U/\93(V[C7[=fI_d>L<)>1&d37X2[eVH#<Z-gR
Fe>EGB_D;RZKYPE\WC]@>GQ)bYHBC(2LRTWPUB)afMCZ1/@+OU>5W1?a+>e=V]J[
MZFB]DTGT(cbFNO,J;_&G>\+dKd0>9IBeKgG134>_C&@G#OD2McW#g5+WZebC]1c
.)XWZ)YOBY74bQ2.2WU2?-#2>gce).gA940N>?(O:?SQ].-3?.ccW=?_[(A2P0VR
;2e(=cNQ?-;W2<S;_4&U]AMc94-[O8@11,#S@PTJVAeDKdRg/#&<?T#C7daH,#@:
N.B/9eWAG,Q<Ma[([a<I40DGYW]&F95HM&[/M9Z0FPJ[5bd_W?HC+RQe^R3&54#)
.=C(8fD?/WAb/AK8#e:N.1I5b.+#SD^8DTZeEF2?C)OMH54Tb-OW28+,Y^=2K(Ga
&-JUO[GU@W?[VA2(96-#FPB@>:JeM?P6d\O<U)DQLYWNbfJ8X?9TgPV-e7a9=>I<
21]?fM)9cK>.>S?,Le:IP8NGD_6]&N8O>O;>\N+H3OCYe62d-]7-KCWB\,FN49:E
/=>43.4&A,[)9Z<<(=>A(X-e0=_O/M-Ub#^/AYQS#GB-C10c\J-G;G8K>1)?X>2&
L>-QC;9&T=0>,P_UBF93aJ6OcXA3C^)7BGH@JK>Y/N;4L&Gc@ZER<a[)LVe]>eQ/
#c^D?(5Ja^=P+S^4WdU0Ya)(Y[g]+g46V/Y&-&5fKRNV/X:UX5;/E,1ON^ZJ^c=U
0<fN_6:Se+?8@DKSJb74T7AgYDTf=S_FE=18N^T?XQbO\4@E^WNg;8E9cH)g_S-9
dg\@7b6eeY_IHJH1X#\HX;&a[J>_d)c=JDd\b.K^;HV7geVAJG^K6b)?CO#T+Y_8
UJHXPKF5;[6.Qe8/]faV(g]E0fK386b=-[_@Y)(:\@]:+BOGe\:4(BH;9@,[1IWC
PgI_GA29:L3+Mc5QF3+>CDV=EY^3(]a]2D0[M+Q4W[Le,SM5b21?2NXaD,,^52(_
e@dFW4D::YGCgDaE=>81ee,.Q6fEP^?3_X+0Db2L?f_D_@.9>Q;[-&)N:GW]Wg75
NGeJDVXJU4@&,=@dAU=D5XNL7,H]6[bBB5E:&3P71[I@cEO?a\J0S5bQ&dG5gL)@
DfZN70ZS&=X>TM7:7N5YTCA_2fb905[7ZcBHK<]M+)Q?bZV10?OZTe1=bS@Ye:P&
61KQ(INK1^-f-Z)E=D+5NG<V3Bg3YEPd+ACE()X8Nc3#&MSMM(3&N09-EK[9)H5-
#>]=HA2Y[\e;B+OeR^/Wgg(/[d]Pc),];P62_#-B\LB6+P]Ca+5F?<cFLFbI,RS]
F<bWBb4LMZ_(&>1.,E@?EcgP:<Ze89V9BU.BZ3#_N+L_.:CR@I6FfN((=@TeE3.1
LYFES(WGXI13a1D\9DZIQ21<X^VQQafT8FQ^@AMV6XFGAP)RW5OEDNA@UV-SWQ9S
a]FBB]RJ&RG7S(H4:8DFTKO1#cgc:a(6;dWRXdYa\MW3:(6FA#V[dO1.VUBc).9f
SV8NX.TU,\GMAf1dUeR?:1La&Q^FX(VRVa,adbQ)-F3@I-Y@/34^.+B?.P.[Z^](
)Ndc_8>[RY+,3W8)<]WP.\AD7CWNc6gG#fLSL.0b62eXM^9/K&I8/(O((++IY+H^
9X?E?+C6])b_3S3DGR4/&+f9V:dU526W03IR:4KG,.:H,QOQ10TC@W2)PePUZO[]
,]^c<8[\92/W2AN><;>G2NNIS2:[6K9FZ,COdb<2S^fQ9&3?K8.0HZgIG/H1R4Ea
XVZ488>d0f_EAb7KTg;&I5.2Kf_16C@I6BA5?T76eBbVN@MZ\g6](B6C]B+\EOK=
TU:F=_GIL]MePeZ=S0&/008N27ERHAMGH&A_&R[=]H6^S-g/YfTYE#RM/a_WN_ef
DA_J3]>N.AIdRP^C@V:GZe.1g]-;BeS#J(d,GcEETB]&[Lc,66=TVHQ0MT8T\dNQ
I-M?/2g^CC:5#e&e&#U3I(X]/C8D]Ra._3&2?2CO::aHgaVbN+Y(3KM]=<I2d,5d
RYK6eJa&1V>-84:D?==#Y[M6UF=]&MKO)C-cZSgNK_OaK4Y-.>df?g(dS1d7f8RK
\>f2de<@U61Q[-.)&VBYR<]6\-b(HQD_JG[B1F5F3S/1#@/+]\<X#V2]M6[N1UcG
L1P3?BcX+6bQZ1e5E4UaDY+RXI@/Z&ACMTVVW>;,/D&b(7a+PUUM8N6)3]RP4S:M
);g#^0CWWV7>0UD,KeR^WK#PdY4?L0A:7VYK0,1&JF_A<755OcT1PY_+])4.]EcX
4:<Z-4NeWW5/IGAHMJa5)EIeC?:Qc4[eD6MKIHcI]MMEEOAP8PT76LQNG?2D;e+P
1aC8V_M8#\>bRF4gd\IUZ8G;;X>[Ha;TR7B3[\6Bf(<WM(=HZcT^d1C88e,_4DO<
@EI<5#F.bH8c)WSA4].OZMeaeJMUSA-=I-Ng6R59=2OHYU733_0U/MZaS7c]SCAP
&L?06AJ,^)U3.X5<O.]g#9@a[<<^9#U,>7:7^&gQNd#L52__=]Mf-VY-O---,0/=
Q[[>]H(BIO(/?-(K^?2WK+cNdUCUeEHV2KCe8P0fVAGS^MO_[\8,UbfG2V^)H:&=
]dV1&P-[M,9(5JZ4KFTQ5a=\ZR>:fD)F-X/]6I#Hf;0FEb0RF#Rd2Xbe\1TTdR1)
U/L[c=)Y>D?WIC.17Y-+TCU2YP\#OO^dcZcV3[2]WX30dX74#)_[?:U&)DI/KFH<
\BUgaUe9/^^NaUQXJU9&G9a?P9D:?2>DWUPQ3NKe9P6\?0@bJA/0SV_C^#QNIL_2
UdbB^T^Cc,_QSB53ccSe=MA?D4\@0IZOe-VRVGV:(?KOE^N&:9bXO-+;^GB-HZMG
d?1Y5NXQ1)-@;>XfZI0,1DK_Q+8/I(WG&@g9JOY8Rce#58L&P3=5B41M_G+E#DZI
FO:8/^c2^W#R:Bc2E:2;>\(7T9X]RI@TK;3(5/&+P/<d>HJ;;CZ>\gF1#V<M:QC5
LY53]O.EbffQV9?;&GeTF<W^FV>e-R)VKg8d3U0I1S7?WQ#=B&ec9ZVV-@dM=H(:
OT]9cR,gDWCgO=YZ@?Nd?Z]7F6FD6Q>NT/3]CMC<Sc:N34/:+0Eca.#D@0(4+3AG
W<V/(CHfa3c_X6H9PD=C@I4^BA6X9Y)d<)ZAf:6OTD=KF80H@;.Y(\BYg;-1fZ(A
KYfC+S\H=Y6[BIP@/TOZOg(P__&4IN8eV?9EIW(L(/+KAX@)f5ZUe/E]^,W(aE=H
KcZMgd>TG/N-b5A4&L;=:?S[,(0T>_8c-)Of9BcWJ,32^.P@QRLg85U3X?3]ZP7&
gGeOW6E:,LgABc(b#R8cfdbOM[-1Q/05TCG^GD.?X1H9/(;_+M[S=ZA&;(0L.X1d
N#W-95,X+)\>.[L=>V67Qe?W=M(\/E6?.VMB/_U?J9;+dR5B)=C_X)SAYJRdMcBH
LbC.SQ9(&1L^@?8Ne3Z<85E5M=,=T\1HH)?WOJV^DeG>+1GJM:]YR3-#,T2g0>0I
TQA/O?,EWg67VV+#6RQF;KRJBP)ad:bL;,2)Q?UGB0K,VYEK5]U?^:e0;gZ9(CU/
)GKY0WUX)WXNMO55>^eOcNJHU&K0W9DgPHRB5gTV=.<OU9ea?>48SJ7^4/,P9]B.
QJ2F_0c8?(TU(F)T1LbD?][3a>3U1SKQ1]Xb_=:^BdGXf5?gO]@?g,K=I3LS(fOa
S=^M.+MH_d4eF6D#99d+)-]JI2,J(KV):=G;)-V0<g8=FaCgg]<DR&U\Vf2S=#R=
>P@PXf_Tb(\MG[0/D?,d8I/R+]H;:cf+JRO0[b@&fB##5d1g9XcKeF.,V^g&9O+W
6;IgVTSU^3f1<]b6TBR;MQ[C]6#]bRBH,-?#\5UGZ-B([MCRcVAJ]<5-H:(M4:^c
(+INS=Q3aL82?34AeNfBCNE?:7cV0\)Y4MEbKNK)YMI:+b)>:<21_QQgbFg4WHR0
Fg/ZNede+V5Nf[e;aQ;;<.A(3&@NJEEJ?83V,gTZ-2:5EFURV#PY1[HPd@@4cSI;
H9MU+C(#FLL=4^PY/D<8eKGM#D-O2.CO>XcBaLO9e#.,M=-Ra+-Z?d_XOBOa=AVf
ZOC:],56>;d+@:@C4:4gO_(^_\a<<VMGZ.7#-YbA:(c5B/R/\?7d[?4)(W4^B42Q
VRE;@]:\Ke,Nd/#<IgaKPWZf7_Z-SJ4E2\L5gGH92HLLP3S(+JF.T+6EXIHf?aG(
=Q611NQ^WQI6TU0=.7OD1I&Z\Rd6,d2,d7F+]@ROf.8cccDX#d@#353K4_L,4Pb5
Q83+,#0O:,\#\)EK02K02cT\+TK+@@4YZ/[SH:>]b-RGAOSXAZR@>B=AdW@U0SZD
YeHG@/DDEN(#+f.C\e0]&C3Y,aQQ4IP.@#<BcVY\(RJ_YbQ1#aSgbb9FUUY);O_L
U^J\T5;a:Yb=+,g,D0=?>1)U<b)0:;0_538OWM[ZW_/7d(eL1FHTZWJ&N/6bf9XH
E5RI]NTKH@PE@_@9N@?gfe1@H/1e1H;T,0G_#,/PQSY])J-dZ[@\BI)4(AALY\8@
Q)K5a5FD)3-bRA)VP<>B:9g6S-N(W(Yg._5H,.KQW3FN_]:M?IBKg92^&(gXA<9(
P6HfdX&WJIJO081#@JC)IQOFdeXd)6X(::R5[,3bY?fF]>M+&+FODLF?Sc?PB9Xf
Md[ZV^XeOJUJgI_cGSPe\,Z=faaPeVX1AOOE3J(ab<:;6=Daa=b\AS,OU\,6N,Y1
?RMQL^REDPV7(;?,P884(F=SJe&VeA#f)f=G=:E601gdK::_PbEbEf]UEZ>E+VPB
TY[(d_Z(3T+4fdX6_J/+F93&@eO>(&\,6WGP+()1J+GB(eAE)UBI=R:a9?)E,VT3
^[D>41RT+>U<<CP:I1AA?c8g?a^8(D7TR&AS&+A3OYOA\?6\&PM/A04A),bP>[\4
(bF(V(Bc+:V/e[bO&#RRXOTYa\g\320NBeDM,aa2Qe\Yf2(EW3Z?IC\ZSNcL:Pf+
7(M/>T_8-ZWB^]QYX_T#,QQceM2g:VLg[[bLe34L_CdQ1\8JP=0L_T,YBRMB4.YR
[#9DP;>OQTbEY2]M>+)G,SN@FS(+CVc3\TP,TQRC3#0:]SC,VL^>gM<FbS]N,4:+
K,J06KPO&gWg=,A<F<A^G^<FZa]L0N6=VT@C,LA_7]ZH4e.P<M1Y=\3Yd_HU=VgN
0aHY4/[E[L9MgQQ--ZVQU-RG+E.[_M:MU,J]fB2NSHV:XO.:XER9NG+P;[-=#;-/
9GSMROUeY>M=JFZTXGf(1\[K((Nb0GB<#1Z)C8e&<T:g47.JfEDDKE3Mb<#^f2CI
I+DN&Z1\Kg[2\D)dT9d7TBD].O(J\R/LH#NJ#\F8_d;aU3OC8C,O[eUA1W.F2FP>
GT#)=UH,1U=H5@:^N,Nc(RN@S1&RS,b/5X09->&?>0g(1\P/XC;b1IVZdc;L4H5W
JT;3#_X?S(#g<Qd[A@MeV6XNJCI_J:KH#,6=FMfWER2?C06B\QYI1T#b58TVbc;V
-8ceD#\>I>Taf^HQG&=:U6&f0<<)2F3_+Y7(cM-V-E5A<K9Y:/M<X0>15:BFHc1B
T_)KNGD;DP#\b)7]\J\Ige^.0C-U-V?1<fd^7._.TO9^\4ZLe9?#4FQ#V@-:J_(6
AOUO[+_U&:?^?<CI@5]5@Tf10/9g73EN859N8_+<\Q^Q]9Y@OeOZ]P)1NUZbA\&C
/>?\V\E\#C+\N,_fZ&c?NQAaa^ARESZ^,eG#Sf8ZL7369d?\aO@;aH=Y:\V]1IWJ
8b;#fU<#SZYW6Y_c&cJMD0>+P>61=)@/&Q^E2OR(M4c9P>\TcR#8KNJTORAcU+#-
+CHcWcN:[TI:d3S)H(#]()XU0;&Q4@F,7L_C:(UX,\N)[T)=U)U#T_I&_.4fOUJg
UVHE+cK[TK2_QI#?9?Uc1[LHJ@K?&OM]/WY,++@6Y7?_ZW/?A=31U1dC9[R\2/MK
(&LP&(0D2f;8]+_8K5P4R#KfeM;LdM_+9/.\LF9;LMJL7a3Z=[+/0OH,4=O.X3Ba
/]]S4]8EP60VCBI#8Z)[-+2V4B7,)Z.>F-c-C2:25CKd:e#b-,V1:VJLOQB]FX\2
0@S\d.-^gLI.,X&bGb=<BNITZ]>X>OdMeD[3^YKeV/R:fZgG[:6BKH-E>S9ZTg[a
H5+V>,V2<:1g?\<1;b>=&X.)dYN@T[N+;g+D2QdQg.MPR@^S(g/&XRdM<S0>ZRU5
5>?R#ET?>AC<V\U((W(,3f@(+-aXI6TBa-KO.3(RQ0fNN4K\O\55A::e@_fL]@J;
B8VTNF(@FYVa2WX#(BgY<F[NHb3c\_]O5RIdSacZZ^@4E4(U#(:YVb=O[_:FW+)N
._-,;L>4)_(26bO\^gP(],f2-XPdO61BY<[2BZE74,@:Qe8=NLNTb=cPC=@I\CR@
UWMGGFXWY92gaB0/)@O@2\(YO,L3^IURJ6B9:,@4[PXXg;[Pb-LG,.8&YdG[DHdT
-B5X\CT^V?]?Y-&CS3((CXAOMN3V6)Q=0806b6-a[;EZ#I29\=GPQM2KEDH5^N]Y
9Q,e??D,OdR\,JTgKK)eF(Z5W((7#Y[K_H>I(3JdZ6/Z4GgfQP&P1cMT>GONKK7;
:?32Ee0M)1QaS6e2dY^g=X<_@X7D=09I_Y;\Tb=&e6B^.9N:17GH&A^_,RD.caY_
\L[(\W>BQVgE.>8\;B#Q<G@2NGFg[8=>/_fDY=Z02eF<e59\1,FQS6aH?eG_PZSO
b1WA+MISVdU2,EgE/.7Nf[4WZE[RfP1cRO<>0TX-He0]9fS^ZJ.>^I.>:e1E3<H+
BfJ<:^ZeO?5L:0EZSg1ETc-f-WeVK,5DZDM#S:T[,@C-E8DHKeRfCNKK^e)2f>MF
Kc1B_9@3\(>PdC5_E1_._NM(IG(9U+HcM7+6)HJ5H^#;A?MVg8SEbH,K]b8:93gb
[TW9?8/AVVRCB?ZM8WgPUPP)eZ;5.>Z^9?CO^9/<H3KMQV7O?CM0>XT]?K)#F#,c
:&Y-SSS<DM,8[bXQ?SX,/YPfeTU/HH(@OG-0G<cEF/U7])(e<3F:g@PaKZL)1KH:
g[fCZM\SF#C7ZJQ>f[UCSaJYPa]?V&E5]WH_+@Sg&R#^7;P3C^I)30IAJB5JV\RO
,P)f<XGA10+EMN-E:Y3W/5>\X[7+8Z)Dac\Y>LCZ5@7F&\BfJEb[;>QEAeYBY>\@
ad-3>W)6TB/4E-6<8YedL^LG@B;R6?5MBc<^A&f-F5UZ/JPCJ[:7PJYd(XXG)L=J
WbRf4T,EZ?.2L58Q/#6K@+?\B4DbC.c>T_#&J73bg_Ke+]OW:W9Wb[JaeLF,9(Xd
f<9E<3gT[1fV8-AM-)H9\&]4a3N_])G@HWb.^fAW3J,d(H@,[8BMdH8a-:LXa+-I
[S,&aFaA1TJYba,ALg/Q2\XO#AJ)7eIfPOX[BT[QE<B]_-Q3+cCIcSP@6a<8H3AN
-8_L<G;26)&_C;?=M9PMN0YUOOf+RU++DE&&>.Me+D7R&7/O]c8d^XL)@gNUL50B
27&T2LV1@#B1;Y;gfF-].CdT,d<K772+XcP).,\IJ)R]a]<#1fCPI_Q9<;X:OL+D
RA:\EHg@;?R24Q\B5W>R8X1^.YX5SdCTLO\@#[:J-a<@Y=cbe,EL(G1g;ATTSO<L
=:SN&cKS#].8R./HW427MNaH0Y5Y,)(.+[)#Nda\5\Ubd<-FfcWXEgA72ZV]+e_Q
Q:CRLNFSaVPKN/g0,0T_TY[D3:HP]J:&HEBKg#:A&@[&MXSRBJ-I>IDHH7WE4U25
.faCY&@#4>:T3e[?f6XPDB1_YA+c4f[WdO_ddXd?DATJcUZB\G-bLT4SU87)QT@?
XW/8H.C=aR3Q/GQ.O/48)BcX\d#[12&WGO^Z[]&S^Oa=Vf/,8T-gY;YGHNZ=-Rf+
UJ/c=H2_79JJNVIS3QTJ8R<fD5R4D48:4;^[A]Zd;ceX\@,MT3Xg1;7B-X#.1F[a
-98:&J7F?g;cN:HO&)4;].BYED1VbN)IK.Xc_dPD;d^Gg->_?<7eXC/J/cGd.0]:
10G/?AGVJ;?32L\)H_F4>;]CCf8HVMV67R72?9]-VbM;8SZTBcF7RId?8?[98F=0
0I3OR)?Ga<NQ2TM/@J@Q_RgMCSU#.>:9:W/P-&BFG7VOEbgfYLcO2DU,a?a[c&Sd
f,N5D2?5\?-VTU[d=F?9YFUG8gG)._UU94AX]9UG+NJ/KPTaI^L8Zf6LRXf?GE8W
aWebIE8.gZ=]X=^Y#=,+Y8T5<IR9)N]fXS2)O?3\H8Na#-Zc&0Ib(&P^[6YG>YPI
^RKN/:1a;&L2/b<7##.b==P<J2a#)9YG9#1,K9WgcWfgW=)V4/3>CW@I-e^?P#AP
de0[DZ:X[eDGXMe:2bg32ECEKUcb8gN[ZGD,F?e^KT(PVe>5abdMFd=SV[QASEPb
a7D7(1b)4:dQD_V3DYgJJCSK3^7be,NbA1J=,;9.TX(c?#&^a1cT+I?5R5MS\AO^
[-:Za,E2ZTWZYdZ(UOa0S&9,VBB3HA<(>/)=NdBH]@?:\2/c4f2ZJP1W0J7GV2gc
<=\F\.NO1&,4CF:Z,/fT10F?7)-@9;LJ.e8f+J0,MN3PFNM7bFbdMB;dM:[YY>Z/
7?-?+=g^0Nb<ES0/D,Q&()LV.>Y()4adX49KQZ9U^ESD9>TGb2D<If0^c=06_Qe+
H3#_fTJZ0CgD/FHE547bf/2(YbM>=d[.O<:3ZU#S>He8)=f48BF^;d9a-GaPA?\T
O@.O[bg#P(Ma;Z.0EfIQ>L,WY27.g&513g1Fg6ac?#)^1CQ4#<@TUJ?3P/F+GZgW
W1Z.=&<J5A<^e:GQCC85Hd)1LUV><;XA1ORQ1@/(^GUfQ;XB<PAPfE0bH42-fIg+
-.693QFb30OI#^V4-gaWA0RcBU2)VJaS-:EM]LK?#,L<8Pb?a3Y.Q3P@B9#-7gPg
V=+<T=9D([H&<^J3L(f4(&9,2Ud\Fa;bbeD]7V&)f4aBQ&R3E7UMQO]T8^9:];aA
aU_(,^3Uf3P[9WGBWES)>S-Q0Ib+9YV40?fS\>gR:)>H74/Ba]g,)P]<_[[^#/HJ
V(JK^NYJ)GXfQ<3,.HW.JdH/YW78[1Ob<La7RAX@f4J482gD(H\=B+P)L&FDNQ>?
=A.gNb4[BCC4YX?.A-W[3D>Kb_P0HM:>BRP4-.fTVK?4E$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_S25FS_DDR_AC_CONFIGURATION_SV
