
`ifndef GUARD_SVT_SPI_FLASH_APMEMORY_TOP_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_APMEMORY_TOP_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP apmemory top register class.
 */
class svt_spi_flash_apmemory_top_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** Mode Register 0. */

  /**
   * This parameter defines the min read latency and maximum push out for     <br/>
   * read commands. It also defines the max input sclk frequency.             <br/>
   *                                                                          <br/>
   * latency code         min_latency   max_push_out      sclk_frequency(MHz) <br/>
   *   000                    3              6                66              <br/>
   *   001                    4              8                104             <br/>
   *   010                    5              10               133             <br/>
   *   011                    6              12               166             <br/>
   *   100                    7              14               200             <br/>
   *  others               reserved           -                 -
   */
  bit[2:0] read_latency_code = 3'b010;

  /**  
   * This parameter defines the latency type:
   * 0 : variable(default)     <br/>
   * 1 : Fixed                 <br/>
   */
  bit  latency_type = 1'b0;

  /**  
   * It defines the output driving strength: <br/>
   *  Codes        Drive_strength           <br/>
   *   00              Full                 <br/>
   *   01              Half                 <br/>
   *   10              1/4                  <br/>
   *   11              1/8                  <br/>
   */
  bit[1:0] drive_strength = 2'b01;

  /** Mode Register 1. */

  /** 
   * This parameter enables the support of ultra low power mode:<br/>
   * 0 : Non-ULP (no half sleep)      <br/>
   * 1 : ULP (Half sleep supported)   <br/>
   */
  bit ultra_low_power = 1'b1;
  
  /** This parameter stores the vendor id.*/
  bit[4:0] vendor_id = 5'b01101;
  
  /** Mode Register 2. */

  /** This bit defines the good die bit. <br/>
   * 0 : FAIL <br/> 
   * 1 : PASS
   */ 
  bit [2:0] good_die_bit = 1'b1;

  /**
   * This parameter defines the device density mapping : 
   * 001    : 32Mb  <br/>
   * 011    : 64Mb  <br/>
   * 101    : 128Mb <br/>
   * 111    : 256Mb <br/>
   * others : reserved
   */
  bit[2:0] device_density = 3'b011;

  /** 
   * This parameter define the Device ID. <br/>
   * 00     : Generation 1 <br/>
   * 01     : Generation 1 <br/>
   * 10     : Generation 1 <br/>
   * others : reserved
   */ 
  bit[1:0] device_id = 2'b10;

  /** Mode Register 3. */

  /** This parametre defines Row Boundary Crossing Enable */
  bit enable_rbx_feature = 1'b0;

  /**
   * This parameter defines the operating voltage range:<br/>
   * 0 : 1.8V (default) <br/>
   * 1 : 3V             <br/>
   */
  bit operating_voltage_range = 1'b0;

  /**  
   * This parameter defines the refresh rate: <br/>
   * 0 : Slow refresh <br/> 
   * 1 : Fast refresh <br/>
   */
  bit [1:0] self_refresh_flag = 1'b0;

  /** Mode Register 4. */

  /** 
   * write latency code defines the min write latency for   <br/>
   * write commands. It also defines the max sclk frequency:<br/>
   * 
   *   code     Write_latency    sclk_frequency<br/>  
   *   000         3                 66        <br/>    
   *   100         4                104        <br/>
   *   010         5                133        <br/>
   *   110         6                166        <br/>
   *   001         7                200        <br/>
   */
  bit[2:0] write_latency_code = 3'b010;

  /**  
   * This parameter defines the refresh frequency 
   */
  bit [1:0] refresh_frequency = 1'b0;

  /**  
   * the PASR bits restricts refresh operation to a portion 
   * of the total memory array.
   */
  bit[2:0] partial_array_self_refresh = 3'b000;


  /** Mode Register 6. */

  /** This parameter is used for enabling half sleep mode*/
  bit[3:0] half_sleep = 4'b0000;

  /** Mode Register 8. */

  /** 
   * This parameter setting applies to Linear Burst read only on RBX enabled devices (MR3[7]=1). <br/>
   * Default write and read burst behavior is limited within the 1K column address space. <br/>
   * Setting this bit high allows Linear Burst reads to cross over into the next Row. <br/>
   * 0 : Reads stay within the 1K column address space <br/>
   * 1 : Reads cross row at 1K boundaries
   */ 
  bit enable_row_boundary_crossing = 1'b0;

  /** This parameter defines the burst type  */
  bit burst_type = 1'b0;

  /** 
   * This parameter defines the burst length:
   * 
   *  00 : 16 Byte <br/> 
   *  01 : 32 Byte <br/> 
   *  10 : 64 Byte <br/> 
   *  11 : 1K Byte <br/> 
   */
  bit[1:0]  burst_length = 2'b0;

  /** 
   * This parameter defines the burst length:
   * 
   *  00 : 16 Byte <br/> 
   *  01 : 32 Byte <br/> 
   *  10 : 64 Byte <br/> 
   *  11 : 512 Byte <br/> 
   */
  bit[1:0]  wrap = 2'b0;

  /**
   * This parameter defines the Data Lane Count 
   * 0 : x8 mode, data is driven on 8 lanes
   * 1 : x16 mode, data is driven on 16 lanes
   */
  bit enable_x16_mode = 1'b0;

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
  `svt_vmm_data_new(svt_spi_flash_apmemory_top_register)
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
  extern function new(string name = "svt_spi_flash_apmemory_top_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_apmemory_top_register)
  `svt_data_member_end(svt_spi_flash_apmemory_top_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_apmemory_top_register.
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
  `vmm_typename(svt_spi_flash_apmemory_top_register)
  `vmm_class_factory(svt_spi_flash_apmemory_top_register)
`endif

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_apmemory_mode_register_0();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_apmemory_mode_register_1();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_apmemory_mode_register_2();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_apmemory_mode_register_3();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_apmemory_mode_register_4();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_apmemory_mode_register_8();

  // ---------------------------------------------------------------------------
  /** This method retrieves the value of a single named property of a data class */
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of a single named property of a data class */
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Status Register */
  extern virtual function void set_apmemory_mode_register_0( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Status Register */
  //extern virtual function void set_apmemory_mode_register_3( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Status Register */
  extern virtual function void set_apmemory_mode_register_4( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Status Register */
  extern virtual function void set_apmemory_mode_register_6( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Status Register */
  extern virtual function void set_apmemory_mode_register_8( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the configuration handle */ 
  extern virtual function void set_cfg(svt_configuration cfg);
endclass

// =============================================================================

`protected
3:5OZUV\G2C99c/cFM<Gf:X)GU.6Z<9VD+e0GN4VG2TY=5LU7KG]7)O#Mg55XEGf
J_HJ(bAV4+HG9(GDCY/-d/]V3b&.LYCReI./>SJ]I0X:]_gA36M5IXZQ_<G5]YfU
FTeH,.K6e=/eb._0T1.5C]N<<A>8?\1eb\IE71@5H9gb7_>#-FOH-bT;X=NSb:I2
gJYL_3XFSW85N^@WeN(+5\>.e[Q<VKY8]aAWBVcf9G<SVD<ZA/UN\baC&^6V.#+G
HPN>Ld_0(B,O=dH0TN5^g+(ZYP:KH;UNJa\4UFJ1f\:0,B1T?\4\SSC4U9(>6\NU
QVI>40XU<MY;>1+5Ze9M(>S(#S6R,0cJ1]I:gSMWYZEX1_\(EK0ARV4_+50Z)C^Y
9UfWWIXD5>SS(@CJfZMgI[[6\E&[XVJ-<>ce0;+]Wg;6bI2aQ0)7\a^a1^gf@B+1
6W\VHaA-XAKag/.?PA4N+:NaIB]#2H_^gFPFd=UH7,:)#&OY\)4?&9d>-2Q<&e5_
@OO5W,5/#MFD/A\)E1H+0NbNA]LDUSD7GR[](&^4a)X&g:\fPHa;f+a<(CPYQMM)
BJ]31D,(Y\LP1,+]1D\b@]ZK+CE4[C[4J@M;SN>^)[Q(fKAX23D8>Cf,/^&.<=3S
fAKg8?N1+HcL9/+?+fJBG3?R[=EJ=0/-6dF3\:]#EBI-[I=f@IJ=>;f,P$
`endprotected

   
//vcs_vip_protect
`protected
@H96aT(=b6&99J1F<8:X6;Q(?KETa=I;>6HGRCefY@M=E7GScU(4+(,;dD;N65N6
S)_[QScb^2A;.VR;Hg6^MESFL>?W6XWeSZ8M/)4I1-^T\/aO[GJ5LMce[^;L)2I[
ba1IIN5gfd)aTC-ZJT2^=;g1;2CV_Sg)SUM6;L,C^=J[F]\O=MJ23(:QU\PRaY/8
(.C3>HI\BFM>;OHg,6M4V#1Q]bZ<K1,:D&?=RNa=8UBI>IBJ&d_A7-0\7JO[;eQe
=.M5JZF,)QdIY)b>AH1<>e[DUf?(E6=+a<DL./1K^HSO:WcRO&=Y6(\[^QX,f@N1
e6EH?<N<_M_b42XUJ,ZQ<G.0,=g#e5^7P6OgP<<dK/W&_d6FDaKf3O-X>c2;G#(I
Ag],fWFDN9T<ULT.gcJ#8fMVdPcX85^c<.)IIb<X7)7#<\+&U<.@8I;a;df8P_&B
<P_HZ#;8WD<,G0g8?HJD3>]62;g#O?\3[eSC).:e2KZU;=aGR?VHdX0:R[0=I6)b
cbYg/1);HJAe092X\MTId@e3X\cR=g#OYK_J&@fF1HX#fAe:-Lg&9#^P70[UadfX
A.X[66T;a:8S)CC]UKA:NLf;_LXH_YLH^b]4>PKG6WROfVSL-FTT_J@<SLK0N4O\
2)cY(@-Ka]7R/O\;(0gT)P+AA/G8YKI\,;GV[:9YW-\UE2;0IA:d)5C:;7,<8IIc
[-<_eH&OULQ4I#G_+KQNGMKcGGCB4=3]5-3/T1aHQ5aXb;a4gcI+4e[36,C;T63&
0>9/9.HH=1YVbK\5^F<\D60M,J#24c74F_eW2g9c++1aH,Z@RI2KS[6?[EECNT^R
)9Z:[&DbS7V<&?f3PBg@39^c9OCR])LZ5)&3?-]+.cQ:Y\-S.U(4\e3KG@N8,0ZD
9M74:RV_?G8)F96Y&c6f-Gg-U4>=?U+Lg1@cF=,845NGUU65<PSKd9Y;(LX_>6&+
P.F@^438f-Y,A3QTQ=AD/[6?+G40CRY@G3N6_ZZ0&VZ\D65S0ZT?d;\(59;31Y;J
NBMHReg=^62a3QWC.N]#:-@G[UBBRV:EBfQS?Sg1ZY=R8b#>WTBa([#Cb8=XMdJB
XXASKU9W]ZZNN7)LDKCU9T5Q:16\UU-g25Y3a0U,)O.,c>e:EF+G=-ZC96JZ,Z@@
2=bbG-5LG3<I=,74RPCH1Sg2]>#+7W]2MZ]8aN0N+@E9MGZe>Sg;f/;]&7)aFGNd
OJ\TZeBI/4+4b\]<K<-,a:A]L>&VBEO-<9WVZ&c##L-4@^TNMI=f>a+O6Y[]cdU9
g\6aV8IPA;Q>2R/bS#d];PH:.X1S,Waef(_IF(\>J(QYVO[e02-.>6@]age>7-GR
beU?aC/#ZKJS1Z>?6a+1Z@f<G0R:HYP5F:eN\E-E0GL^WF\]+\2AAVSCG_Z7eP(7
Z:.OPM3-<J?_NV=7DP\4(&>A/4)HC]ZUJ0fD^4b[,:J/>Ra=.H+_7Eg,XK=JJ(5,
:,#Fa?\;PT1_K:IO08#6GQN\A&aBKg8.RWM[F^J_9e\KP;_W>O[M7^<e+?D6B\(:
+4.QY29_g;D1EcA.XQG-3(dQ?I?V5DGBKDW=RX+6P\/H:EG3e8WK8bF4(A3].=a)
>@<H)+OV45JN@E(5BQ.HCd@MSTc=Wd?8dd<NcW@69/6W=JM_Jg_.VY[e17F60LT9
HgN/)_ITV_9KWa);D-\2<:+T-+.P6?EfKB^Had43SQBdZe77DL04UOV@DDL.8FY_
](-S7W^<]D8KY/6eQ^2Bb=1fIV]fbB7bKIX^=Fd,<#8?,>;;c\+IR>.ab[8;YAV)
g:0D6NIE-H62XMaa_DEG-0,;<5[YN^NFCL9RD\@a7[H[+Ub1[f[+V?GO6MMD.U[M
]=PSNPOaM7f[6/.IX]ANa4)0>FYOMWM(aEQW7BDKWU)O9:Bd0_DfD,WV@.31ZO/b
+YLd[M4OLb.)SW6#-(eRYULV)_g11TJF+/>d[<EKZX\,b)cRgT=;cB2XX7,@dGG0
G_=b][0YF8D87P^;/c)CTf+8TeZaC4b:[cWN/CILPf6ZdYGAHdgaB@O/_.CAXgWe
X3cG_ZW,G#8g1G4c3TOX+YCe\C&,&TODPe@,;1faC;fD=8WANe=-(60;6Lc+8(:V
Y#?9^D.f&TfO@A_57gT2GDQ+TFH4cWS;a_&^2+c\V>N)ZP_b<5Sd2cCGYYCE4EZ^
+U1Ff@bEU7Z3SgR5aWEW?.321_2U<FL>e-5]YO#4?UO1fAdD<>ED#@J2D]agIF:O
c&0RX/JO1)UcZKW>(3,IXK:G9S9bD;@-#gO4Se\a+>f:L.aS[SL/<Q1,;>5P.AG9
6[Qe>^\@W(AQ[M#_CH&)]b4;-0K3af13)#d][-[TR-P+_fL76UHGV(356d/R&4];
4G=05BB9+4\IU;]02W-Uec7bRM/YBY&cL69>)>YGTT<YT3-PQ^:T0BFL,OHWBJYD
@6=[X2QQE9-2DFF<S+KN0X3V/8e\;=(\]\0/-FQY8ZS7D+J?]C6f3&e;END;CT4N
3\OSWL_H@UBIgHE1;[e&86I)XBD@FH[FI@/V_aI?^f,MTaZ5;IJQQ+KH@YRA2AG7
=PWb[=HG[Kceb2DGBJ^O0>/Tf]ETW,^I.L0TbbW,N0a_g/1XK=C0498,HU;?NP4C
2QK2J(Q\#AAB44D<Q;Mg>0TAgK84_R-S4MD(_I50GZ&.;3WP=@=G&Yf#NIL^L_c5
9=HM494:P>WR^?QB-Y(6;PR:@ObEEL9BgZ(#IHg#6(gZO89gX[)@7NR9Y_(>7fIL
BKW+9H\c/NLNQafe2FafP#G_C5UR,b4CFYQaJ_G5cU(H#[\9I0^fP>2I[I-S9[)3
HU-X7D(L-V:Y42BWT0T1F#9VHa5JRX2G85[cGZ\CM,1Q(MXf8f=Z(d4+d;b=Lg1Z
QOD0eAUdSbK?FSdGYR.+C_I3PQUcf/W0L)bU,C@AMc@X5Pa3PN<cX#+R.PCPPaY[
P:\0,Gg08N+49B]QES\,Z)1?.>=G2(2#b:?X=<[#+fBf1,/63c+9FA9&Q]EBYO&b
;7dgH]L?]L]AfXRD]aa>aE4LA(UJ@?f\SOCRMJF;)I(&9bYTgg2Q&)WP=.6F;8W;
<M]0XQJbcTDLU,M?B=L(dOgOF8[WV@:&d@g6@bcYSU1_4e:E,EK;MV@^A\Q;LdbL
,d2Z\78cPPfHSZ7bJ>;18cScB_#d^19[.Z/=J_5Y<;NSK@NG#O@1OJZT9RB-a/[J
)N8SV)E2Ff=PZDZ&Q7aSPK&WfFXH72<>0#PO+[,N,ZE\,:GAQS:4\:e[L[)Ze#@f
)I<C6G@=OU.<29FgF&?@DRgB>eb@F7L3<A;HN\b@J#bLT-WdARPWOB^;AL#;Q_?S
bQY-V.ZaR6/G,U7fUR\1.-[N4-.E=FEC;DM88M+RDS?U\LG93Zb2XZ_0^=YUb3_;
Z44_:X^ZJ9]F[WEN-\54\^3..YAH&^6\9L]9KPQP[/L<-MD]]J0VGg#67MfC&P8I
_gE6;c#O5_L5MEYZf+H<F83,NdPb3:JI?#fK(VfJ-Ngf;CM];<J#B:b&9[dVX:C<
&M11RA^SFcZ0R?SPf+(<eU&:;?Y0ILDQWHY^)eA=>0e9#,RfW&\]W]<G.c+[7[(-
BL\1:_5?bC#ATG[OUEKT/8K7,dLTDbC1UKGL)NUfYX?,cY)36T8.UW]8<EC6(7IZ
(^g5YGDI2,NBCAGV/-&+?Hc=D3cYB:T9L;KH]M,C7?]6]>;1DAKW_WB\.4Z=6H_1
:VQ)9.,819f,_=H<\YZQ-4(.6S:.OD>Y=&UM)=\/CcYCeX2VDG&)@?N@eE4_4eH^
_WUH_,XMIE9?d<0_DO.)a#>BYK.)#f3H:L-[>JdD#[)&:eT1[(c-Z[X8/#O&5W/Y
9[6(e=AZV=ZWeRRVRK9d2(Q1WT_,MC+VL&eIB:Ig^JM1eAEf-P2ZC\7QHXfBJIcR
02AF1->WFc;.cIf0>(#L7T;)3H+?2-\AeW3Qd0^1._)5CB3MMAfK5VJd1UB^C^_.
B?aB6#H<e#SS-GfG(FN=KI=3e/F-:E7<F9(==NULEHE/2OPU[M0=8PQS,CFGdMLU
4K9]X28>BJSgNX#gRJ-?I&fVVAKb7C=Cd7/F?7RUHM?cQ:T#;fIMc?fR)N6=S+IZ
6/d.<69=N&4f4S?#IT9&RNaAE13NV)2@,/4)<I+?YNG[f8-.T/,YXf7Z5:#4+R(b
C&&B;>&DC.N@b6WGe2g(QE0(=S8O>\09,#MFA\,7eUW>gN5(HbU2/KOHW0e2CeKA
=70_D0&C1Q@<_<#^dd\PQ(5SR>Z\?ES.>88FFCZ_-C/]6&Zf8AFE36UUSbER5L&:
F3c,/J54;_9;4D\C#G+1KHQ/bYW;4)+GfIEJIZUf4P(]Y6XTeeQ0XT1MHVI?U9g+
LT[,)PBL8HbHL),ebK1/a3c[K?H]E./Q9^1^a-<D/[KUd8dY>;ZHI^VNA&gAWc?\
.Q_2f93P3&6ZAF-(P\cVJWISEYa?.Hd^0UIZT@gAbH42V@GAg<&68G\^3X4@:VZN
MBS)V3b::XM?0f+6[JR)0XIF&GC]_]cV\NP>A#DfA8B4e5N?(NMfHV9CBC&U;J?,
2,cJXe=&;P.ZY#[O4HN6+=C\ZSNO>eL0YcHUR0RA[A6@>8/OK&UZ5KH1U=/-_C06
I=0Z]B#C@IQ7gJRICbe6;LeMD](>B_;PHTEYP3-I]T7:>)##I[\0BK2\X;BLF(f4
3A,QR,SR&//5Fe[KG+>V:a6Ng3F8WO(ZWLV_(]<6b<PRZV#_TT^0:H]e8<S2P3#[
g,N:O]aOHUS)b0AScA4TXCEB.&Rg4Z+((;?)b##Y&/TRA)PJP>YJR\[(+XPbUR)K
T<KMW8K[Jd=B#Rb>[Z?@[\N[+/6HXH>3WAT<OOaX5GN8G1[06be9IZFJ<)@K#?+.
=3H=>US,,7&P^ANAH?6Q2f7=]T/R[VTFUB3_.7U4f^57Vf1MN.E_<PKA@,?PXLGF
MQ(8AR25BA-)\A4(Z(0PTI4<bD[IaRJd&RI(A\F=Da3g?\R#M^+9-.6GO#IBTJUQ
;a)=_V5Ug^#EA,BJ9d]\Yd,G2P@Cd6MQXKd+MDC1MgJTFII]a0OX4AY<1&GcWRL2
RL:46I6dOO#7^,2.<@DJ?GOU\[cQ8aO=C/\05D/6()7FF^?\4#8&T:^dL<#6Y#PI
U]bR@#)YZ1eL6^8AZBIM9g8V9]D=Q?V<]/TI)N_58JUED67Gf12YZ:J<Lee.1[+\
+fE&NMbP5W5\cdPc4AbN40G[GISW8GD_6X^#6MV&T#>S4WPY@W^\B;N]2.I8]cJd
N=INH^&TSQ-4C6W1gf=4a(GecFb)8&L#E_.aNcU2Zd>M;+NHdR>)RJ;2>W2Xgc;)
78[b8BbeZ7V&3TX.(/_Y6<ZY=][MB-Q1Y;6PYH3A5.#_,OdfV/_5=_EJg>8MTBgF
b=410+9#1PLBUScc4L+A<6e&8)N0\,BEDSfY4GYK#I?+Cbe:Re72A^F#42)(cY[?
&.WEP3B3&K==5YdGPeUDZ706L8GLS]M^J=-GbK@,8,UT]?IZ8H#2[I6:R@Y\d.._
S&C4G+.CT>]g8<cG?G_gR?-)2^8[fed,EV[YAPZZ5.5]OVME][44D9WbaDR=L2M_
0A#@ONPbP=GV,>37Gc#6X:Q]5F\>c+ZMB@HQ6@aP#0M,,SA)dL(6.&f5FE+]W0[D
MOS[?Dg,JY)N#N2F567/Wc40f3TO2>fXgg<<H6XU@cSDa3PB0YGB)2DA>S\M3QG8
)2_6MGD<M4KF4d[g6#@J:<Eg<@0EK,LcOaCW8@XAH;JR_W7VbN360A>S>C=?Uc]0
Q[0)I-EeRJP1WQ(N7++/3Z:2Jf=,c>]EV:T]>@2MAMB#HdGeQ(&:9QBK+eT_/+aT
RA_/_RcQ]fG7F46RBaW7B.93/,_:XL?47g[UddHDGV_UYC_LO+@4P&>8Y8XY/XY^
R5eMM-KR3&@Z[(6EE&Y>+/0-LY+A;V8FOBHcd\.K/E/49QOUBbdT2e2Zd@aId(M]
PVOc)EgX+Kc2.EeUX).K:8E?WJW6^1G/LdQ2LF@>W4(/A^Q]bfPS+J(<5?5^P@3N
=G7OMPCc7=5c93=C9.c#X24bEe.BJ<(gD7G^[5/D?07=)TO@E9dOEHL.D84QRHE8
29d44G8=<499g06L0Pc=@Y]_J9II;=^RZOX&?f>K,86R&.UL?,^7567)+J7e]^\-
<-9)KAY(\+W2K/Z0J7M-@?]G^+1AQ-?O?JNFbgB1.g8>3Aead#]G=2HZNBg9G>6)
^T<6Y70=bd4T;D/3Q8CE2FSYW?T-ZU3RgL>GGYd]QeIVZOQNFW4CD>WOEaa14-a,
=K3WXP^XE?Z@VbF0GZHK=3-_e,OEFEXGZ;,b0+_[=YH;+-+V&M8DT,6(_gg/gEU=
H54?WSVTf(g[#TWKOY=HW^[X[(5Sa_89[N-L8N4;GLb7H[Qg.FgFW<g-Da-ND^14
2UYbMb0?2+](TgKeAHMBAbUZ8MX966Y#9]JdGF9e:Q&GOS^\;PB)V?K#OJLT9cA8
2,0Ig>JJ-M#N59:TR48<OW+SIJ&;<+5RCY;],_+/-\TC2e^fO61_D0=758S>DaRD
H-JbZ^3#W&ING.F)FQ_Yce54:a.5F/#YeS^[/A:,EF;2)T??I4?4I-+Ic[R=^bK[
S+bQ;+ZR;5V_R7H@(bd3;.3f3S91L_+-K[9;]U19XEdG&US0GHZW&/[:&G.C2[U;
dSW;BV2?^=+28[]&K5>]V1a3X/MBP3Z/eRF>=c3gD5,ARgN4f#JX-aZ6?g/CW1dQ
>^agbOGa[RdW=F.g\-gHD4aY1C-])cHPTC4NIZ)eW,Qd1;@/M]7A4a_==5G&)31I
X]+<#8##AXT6G&],X\P9dab=CL#[0/,W<N#Rc8=&1JeGEa93;;71],;6@/)_LL)P
4XMBPQPD-1;_(GG2OQ4O]-14#>UEQ^BU3#+fT1T<KOK<IJPLga-#[d2Mc[4+@<W8
OPTEaR#V[:H[fRYcU(,X;61O([0bbY.-+,[3[3cKSB<8@@cSC&CQ/G2;9F^:^[IR
Ybe,C5&;O4MR4-,9>?c>9\MK9Id:/X.D:0HHH5g=?[182?8TBfTaVL&XISLc;Mg5
&@5:]/AN4g0[Ib5adA.N&5;F0f>,QVD+^VSQ79C^@&#XULTea=@\fV61RbBFUEEU
0c]EZBdASK>GK3B\^^F4Z=(,+G_08LDa);;RgIF[ET\<2=fcV+I26Q?/.A^6:,_,
W>)[VeT-0f4GPZ7H>bK(;gPO-LR0W=HER@5UdIRS9cRcA)HSZK5]Z=\##e,.Q&BM
_ae5I\;,/07_AF-;@:U1)))L4&W,OPS7QNb45YG,AZ0]=5RP1#4Y;?8,C]OK:R@:
-ZaY84c(?\-:L]TdDL9L83&Pf9#,@#cc6#B)8#>DH6Q\7,R?^&af;Y>)AdNBHR&c
F;LII.O3F-7Qfc@],O-O[-fLdBE3G\O>AgACg=[_C6FdaO_&\bZc&1W^;AL+AXKW
3&:>a#>:b#<IcTB47G3U#H]aMD5AFUBC_V4AF\).WSE&<#)ETbT4NbQG,eJcH1,U
R=.^3SFFdZA<cG>UW_8@:4HWdAQ\eJA_H9fFQA<@>&gC1:3>S]-B:b,LN.#32Q<e
_G:,@G3-Md\.@W[5CXL4T)POQ(A^6RD2)26K0eA0W?/V/aEf&16aOY1Vf@C^+?)B
NW@CY-A_A:c7_YK#OE;N,:2_@YQ184_HF(>>Cfd;DC=QO1UMg#Wf60J&&&Y1G:LX
T>IDG=MM7@8QO/LI<>0f?QOgA1C<<b7#^edQMKX>_Y\@N:^^2U/[TH-,=8\W3N4a
;HHHVSGf-2LBSRW/BR/^&KR0dH1K36/DI<L0f=DVXZg\Q^FXLYe69M_V+[9APXF/
Uc]cb]X]X>d-_767-Z]eN:VFGVMI06+NQQJIP[aDW7RSgfWS[e:KbRY<]4fG3_JR
&9B[@_AWV@I#:1dB8:&)T:HQ-@H3W2AHN,b<AO/D7+Od.16^#MUBSTd0[-:<W;\D
_IKObS<UY&aGYHSW\6[WLJf5:\S)YdbY=.YF[HR2g8T,\ME=[gN7e\bb2B_WC61D
[?^cC\Ed3\)^LZA#0]bPeaAb8GgTL,-cdI^[PJ0GM1ZIJ.\<,[9&XZF4?&OLa.E+
-4J2&NE7.[X.R6?/2&+FT4Idf-)C]W3(-?EB5H4VONEdF[X>ad/.D]B.BZ10/<<c
KIa7ZX2f=b,G?a,6^QEURZWC(-V0@>,\I_N=]QcB=@RDX02F,dSUe(:/1VaPFdO.
/:KVPD4Zg>GI7^7W8Cf40E1g:egB7d#S(VX@X;,^gX>+ce^1HLa3:B5NHCb9]a?f
P0R#LcG\b\bIV^IGPRb@6ILCU^;(=aJOKA.Le1+\RXI\JU?Rf:Z^TH2=C:;;UU+:
.#d74^NW5>^?.N3[W.Tf;7b?+?X8D,F1NYO/)]\>e[CBB(TC&\bY9<I\N#+XDS8L
U3GHS>JHER>VAX+>2)9]F_6]UMM)RdG6QG4,/g&?7<A08]TGX0#+\cLLC?(I_@ga
D:G45g]PSXVNN;+(Y[)-2C.PC7RbAEHJb]@H5>g]U,K_073b6#68.Ce7O0TdVE0K
B-VbZa>S5+W6M.>D,@NNVTE</WX:3?#ca-POIg_fM,c#?RL.41F[6Z#1?_<-9&.5
ISV)CNR=+f<UWDR31\Q(UD85WFV,)39DAZJ52SD_bU9:L;gfKL#XBO-3@6((DKg4
X=E4J6]7=D-O,;>b][D6gbB_[g@gY[N<W].I??Nf#MKZSA79+Zd]^ADgMX].aQ.O
B=]6c84c]SXgXS9T:^CC-QFKTPAI_d1e9&MX9JF_60FM_cg<-d:bA0&O00&-/RO=
fR;X_gW6>c,J38)V>E^9+K:9;IQ<VBX<C=K+D)<LcQ1#<_LV8NTNQf.WgF0e<,GK
<d^@QEM)C/8&KdR(/c_X:GUg(Y1#UV<(bb6P4XQ9<ObOD\(U58T_7LSbH3Sa^U/D
@>5O8dcNYSEQ(]=aV=[]74BDPN52_7T8b2?cEC_Y1+\+ZN^HX6&]WR][KSZN1&F@
F_ECbEdCBC7Hg(B(AISAI^@BeOMIHO#XH-:8\XS5aR9.^e8Z6?(56dYPM:;M.CJT
/4765T0[GK@eY:,)e1P;G4P1DbRR=B0AO.dBY-deTVTY\eDSdQbY#7RR7eM?N;BG
P[eDMc^<\_QWCf[DL_LG1d<DMFNY=b;?IFWORG-6]YA]NJ703ORb<07:T3ecC@+G
ILB_6K41WX?DOg20#E5V^]G<4UPH23&_G4H4YCgFc:@@F5U,/BcCSYO@V=3Y7Z=C
O.31H>STMGeNVM#Bd#_/bOQb]P[F\/Z1_Z>dgT2G_5>Dgg=;\FUCFR1X9f(WI>/L
0KIYOB]A3H.c@T8[-::c\GKf-bMcL>?:5\aRVH7][HWJZE3HHG?YN=bcE63HU8cW
7\UBS:C3Qe\YTP.B6]81_Z#a.WWJ.#:83=PPQ-GL:I:?_C#H8?=]<2/[N\DFJSNS
V8=Tf@\(G+M=;.10>T-34ZD(4(6dLJ@X9d2=:NVF/T-78):[?[a=WF4H_78H4bW)
TCJC^c[^>ffEbQ]DU,#&IW0_0-3ET;V7WLS#R#NXX-Y,/cgL:cO4(9->.=Q;]-RP
,bNf2+.bKQG2M]F6RR>(P727C)d6]H:-SBA@)/3WWg2Z48UK#HK;>ZWcC7MaM]7g
IKP2TAH>LV7>SffF<?Zc6FD6Rb0Q>\TCUHKI2b=b)d4HB?JH(]F_.4,4cd4AQ08O
eJ[89Ya17[H\H:J])-7E_gVZ^#D;XFd9Sf0B?LR)#W-EEM6748bAL.MeNdgHJNNI
W91M6T2C<.(EbL_&BSF,CO4#X9D)^;G<D8LI=MgM#VYf9A(.TW/#.(@a=I<?1EQ=
2;+71EfRD8P,WgVNE8C1\F[D>G0CRMId.e;bIH5SE9=T>QD@aIPW]]F>I0THPH88
<TFg5M-DcOHEXXTg.<Q0B+f<BSN-)=Tg3N&6_-baDTG,eG:&L+[IURd0efPG&+OA
+X&R13D/;>KS;_Q//S:K3<,]=(J?N]^Bfg+A+-c02S6[MVSH&;3c/9=^)W_CSD<V
b@6/-3,dgb.Z4eFPJIGNddYeZdXXG9-H9CRL9NJWCdJGW,O?<?Ra6-4Y@H1/7:O5
CD(dU.Mc7e2.G_8Z1E,LX64(<C2=:4f^,CaL?2QaL-f8Kc)Mg8bF6WXUH^T+g1<a
CGgf<)==5GgJKa]]8JR9Z@.NVHNSE&OdaQWI+FAb<(ZK=Af)\gS?a__;>S0.)#6R
X8fKGX7>Z/WId5Z0fVFVb]ZUV+-OTXI5,<@6R8>+3+-/B)2=?b(WaN<:8;PS3ZQ;
\Y9KSDB<28M4..B5c:Mcd0>GFcCLZZ]WN7ae<L8HW86a&(QE=SbWVG)S>I=OL>7Z
1B:]caO/8-6]-c?Pg>D;e)2EfQ#/AG1JI4LI5]0L?fD67;=GD:C(/8?8F)G4Le9D
NKZ8fa^<T-]X;^6._:A6T^<5411eS[@<@>>Z==b^<EK5&e(N(,9YY=M.5PA0A8Ja
IY&#77==/,:PCe?YVV@RI)a?ECW[PPL;<=HbH\T?&S\=;?+KE]IW-aX-\ISQ?UYR
64.G?MeTCMZM\W3PT-MdEH?VCa;9Wb#^I&JTCNdR_R236)[^;g-=K@b>U@:c:XOf
21&S]38_1fYL/GM-;O;A62UWU8cQ[#,9?9-(T]1IPO^.P18WMDW5F(EdT81f-c\D
9Q=N;9K,b4O=]K-NfO5,H5_cHTD((f;37U7.YUU5U:HJgZQ++8XcJZ;KaZMMHAC<
IdY:]@RF;K_d:1JGOK49[N?6?WRS(d]e_6JJ<I@AC+,e>68D-a1:YUNd^CPD?]A,
G^bdC2C&AQN#Y>IIO?<?T8.3+E9&]Q[E)b?#0Sa83ada[Y^HF3>eGGZVd2P#M<VD
D+1gg347B?6;P.]DQO6,N@JAM[g^OCLKfJBLW4,X490)(<@P=f\;L2,Q2K?7+O5G
#E/09P7-R\.H49[S&.4+PSgNZ9.3/):[;gI:PS)3W)e4F3df>YGJd<P\YT92K;6(
UZ[a;HYSg)0#5]@SGVa0:KaDT5X0A6^J;Ic_),fCI;[0C+HaTR?>TbR0=GFPDCCH
;,?@Aff-50RbX5bS=.c_=T&(W8H<)B=+5\)6a4CY-5E[G)FN/dN<1N_6ea0?>5>(
-&-fEMA#;2+geDdeJKYLZ\3X&Yg]7W)>3NG(@E@=a^\Yd;9+L?67^CHMGa1Q?WV<
7NRQ0WS(cRE[N=437@43SA^DKN1NQFV>R0A(Sc^):FOGS,L\8@?\C^;_?IOYRZ.-
Vg.^FK:H^C1##0[E-NBVPMC6#+F-M2N,QgdFf=&F.FMN@(=N5<T;C\U]STYGQA#S
E/GJCg:-7Z[),fVF.W3f\?d.<>DA1f540Cb?N<4=R9C\H.8ALIa[&41a>U:?ZY)9
6cPNN6MF+E_+0](>Z/6E(,CDa4[+JUB6-J6&_8S>S#CNeOeHFKBUR+/#,X2bb[V=
(c[2/:gOFW]=)J_:R[.(T)f@e@JcH&g=Ye?1O<FSFM1T&eFf\>ZD3O92O&F[7DXJ
ZM0TY/Sb_4A<VH0CWVdU3d1A.eJERAg@;?W?-\H94^M]WD]<-L:E&6aCLf:F\-VB
F?Ae^E,[08(YL+[#_S0B7YT5S^PKPQDb,Z=ILK\VU<Z)FTHG]78#g?W1^3d<Y#CB
IbJX_aECK=dVgbRN,5QW>b60d3X0Ze&B<;TK^;S]DC)KN/c]cAS)U.\/CL.46,<;
1TW10E4OVIZ+4\g#_1IE7=IPU@13;[NYMGUJRRQW(=&>?-50]8K:S:HHcYEPSW[.
?9OX_cJT-0&5g@VW_:G9K5&c_H&8A/bP^H((:4&K[c.(UEddH9X=<NGW\E?FaaSd
ACd=PTKGY=G^K;-THH;INC867@)Z#2P0,\+bH5BOaGYLK]MJ,[EMR];[WYEO;SUd
BY#4/GG8J9:P2b7TK]UJGORNd>UQ^=K0fe&f6eQMMgFd0?>DT8,FS4@5cFHbK9?>
;WB<8+f#BDC/=&G_\&L7b=&0AS=4?^egFKDf=K7[4ZZQ?Y.)#GNdQ?R=B&BcUG?[
_4\Y,7<FQP]IRP<N0MV.NeEdTK/11HO58b_9PKKFX(Kgc=M7\J5a;<d9_)A0\#fR
0IFagCT/\[@[5cd<YN&b-^Z4]?X>4S=.O]SLXVB;KG4P9\62e2M?F/&\MX.Ng5[K
@cPF:^#D+eT4&CAD7;IU,SN7VF<C+E@Ug:g^/<Rd.VHEdg[]GUD=6RF2(e;g4MdR
W->A@<8_H3[BdC]5X,5)TJO#3\_R,5;8/=W<d;YI:)892;Q6>W#2EW1M1L8JH6b7
>41[YS(c&+4R2Z>2?/e#N27MK,4.KZgC_OQ2UE<4W#2.K:5@O#NB#eS7K\\\3K^(
=7-^]H<[]#FP)d&Xe8^0gfHRB2QKSgJ#[BEV):@9>SbL/g4cE0V=^1AK&VF<+Y^.
TJ<A/]_]XUfY<.M7GPSB(0BGUaJJF;H^8?ZHR<TE)._.@9.0#aOW\BYF7YV1=g@0
=Ma@5@E56__Yb6\8ODGLC=4c+WXe[+;W)1?6)]M^(1@4/4[+/M8(=<U[62V2]H5O
0eD:NUP-0J+SQLXZd/=VX5:JPW0U-d^-JN=M0?:H7A3(DYH@;F0#6I5IJSFJ6@<@
-VDD#bVX:dG;K]d(=R+K@0^_Pa\I1.cH<^WE_c-6L?VgS(OG7.dK.YMNIB2QOY)J
e17M)d-eCU40P-;0X_?[AUW^=@?4528=8>0MS@1RY02L+?WB)TK<V3MO&3;;/]P_
;6g\+0VWJLf5-2+D;I<B]W44XARe&(d@HM)002MR.P]bY5X..N7E@CfOTc,c(B)I
c(UFH?[Nbf/;AB+?4=:]@A.YKQ;@WL-O-RE@X#b6d(fDENVN=_5Y2502UbeXc[I#
-_]cAG8JGYA@C2X;\0\bW5(MN9AUgQZ8a-VKfa.6?Y/1fQ2+O16Q=8M_KWbb2GKR
#K-X5eS(Q+0DP\O+7=OY1GUWRf\W]DcfC+GbFAZ#d4CQ,)=JbAO<Y;8c-O;J7@A@
(?GL4d4>FfO?N#>C=]78b<M<]6C^PgTA^GfDGA&CN<\Q-bf-MKG.45./4SB,.2QP
.Ad\g)X7cSef[O.)[+U,03GOg^Q2R1OQ[31#Z^-7#c1Z[/?(E574/f0cUKW)E2+b
Y5eB>G^,E3Ab;3NEOUI__aFXXcLIe_UE:)8^LR(63.3;>\:N5Z(V/<gD]6\P<,/d
=P?WgN\B;?5C:-bCGZ>.2F?_Ad<g^;([HD:H&\ZP,J&,/<KJI0<<>TY[ffH;DbR=
9\B:E3N+6P7UeG+O#G6fMEMVP,e,/,Va/BbJa[B4fKT:@NSC7ONJ2--S(.9)@?aW
g99b?(Jga7bB55]4bZBOQ17M[XGM><@8FCPR^a?F.IZLAO;>Lg]LREP0;.Va&(J/
^AO__f;P_INIWHV>aW3f8JdQFA@E5Y--OY7f\D+[ATUKOA?][;^c>M+aFHB3:L^O
,M0--O#0f4H1Se]^7U7?<5\0X95DFYc\TaHAIDC_I4/-(/FV2(0JcQHO>O[@CJPR
3R9b7I4T0cLIL71AQbbGfP8T&[X)e#:0f7^?7,9,\CEKVBCL.W<N)VgB?6L]V@]4
H7^3.:RV2[F+g^/(+D7^#N(Y?TD;bNHUAbN8a0@0TV/ZI=(X[0f#Sg8U+)a=3Q.6
@4EV.2#/[?eS=K8e\0/FV&_(I5c;LEK#V8]Le,]92\Z:VIPHXLGg\/H[5I67>:J\
G?6_NTBG_IV9Hc/3Y&(bE#)6T-ERV5=D-XX6DA9UX@;_@@e&Z^T4CL-;&CB)=.]4
dQ&aOXZ_I>:3S2AK8e./8]NV-ELC.e1\/=PPS+1^?HMHLG@:;I?@c8]IZSQOBU=.
b-[MZ>@c?PU0T[2)7Kg=LPH3</F@V>H@Y#>_3]fL(;NH+J@VN4g3[K+V]aC-&e^<
IF)9E65C2R\;VFG@8+\f;I#(=.b/C)7GE<cM51D,7G3_K>GHX9@L\>6IcV2T-0.O
)&T,YYD-;FY3<:4H)BJVd.8d_VLb7HL6B4\1I-_7F1gb7)J8NSM^;)aFO<:HNVJC
36QR7A,284>?:f_[XgK12&Ta\41T<df4=GgENB8RB:<M7Re@8:+d.UfQQ&-L[(<3
/1gQ2<K-R>XW,-CH5fRO4(Zb:K)G2#7K>^ZS[eC\HESPX53cb9/;E2Y[I=Pe&VS8
;Q9@NFI,PE187J<@>I3)=#+;RbANT,N6@8]:-(OIY&1aB0W6+)RGc\@QNH;,d-4/
8Jb@#a#X&=,CcDAS+.=XS01gEANU0D<IEGOU105fO(9XOZUOK-Jc#D4^4O5Y,@fE
L8VBU0;:81+8YEYW(F7OILGNR)O6;N<a^d;-\\,9E6-E39NE]CNFYVZJ(XEaRdd6
J#Ff_.>B.YQ[OL<6]/<SCd(\fVbdY,V8b7M:A+Q;;=dYa<PD7\N:-2Y-^g40&2W<
KLMG\5K^aLVEeeO0_O[5,B2Q@@96e?C+b#DZMAaBN-R6.H1LEVWR=JK<)V=e^QV^
gJgAK5I;,(eLOCAEBf[IRgNcRJ+-68#K2KF>#V4TRc7ERP>?[@_BXA0E:6\IC<@S
,_HC&SX3NG4eg)2f6NW9C8KS6>\c7DOJ]PXJMf=.LXb8+&3b;DMgS)aYVQV=URJD
ZX:Y_<9d88QIQb7=_FE.\88O=YD(6LFYcK8JU,b=M,WGGQ-<cF6L33>8P(U,CGLQ
8O.+(4\J>/K&Q2DAc5-ZSZ[I8747-7.+&M;Bf><dJ6KGeC,3H#7N,A8P+?NUcN=K
;\JGE/=@]ICa,^&)@(&,eO]=4-Je9W283VgXDVZd9BB/UIC=<b_^W;<1_.IJ9TCP
KV,ODfUC8H^W5FV?=P#c&4G]TMSQP8O&bX^:Pb<AL\2=#&7MTD/3;2/39GY#L//U
db[-L0W;)Mf?I\V:S/349O+9NU;8Q)+fObJ<baQTYZP1HGbJ,O-#b,VeM20gSU5)
9Q)AMH/-S\K5^GL3,Z^&;AaGGK=NA:P>8F?O>_585]5URNH(QHN^YYQ5K,L;NY_b
EI47YfaKM,8g/3)NbGX,[&T6\_J7\bJTe.QE?G]N0WS(I\Oafa,e<@==GAZUJ9F@
c5[RKE9bO[STK(:.b[C73/,C8B-(@6(KfLYNA-_4HJfJ_FU[cH0gGe3G@6Ig+QQ/
eRV:A4UbJK#>Q+0b]f67=+7Z58<&[3;]/PW)(.#N#=_^@FR[FEF:\R_C+Y(FacOV
R0,FM[HIaVQC8S);_ScG=KJS]GGNZLEUe.Eb#]JXE.7cH+[1)2dQA,F:8E0YM[0Z
a:KTOeHa1L3+;4WN4+3^#4S^WUJI5g1]-D11EaXP__OU:)5HVB#E4>;c;eE,EHSC
EPMJ:[AIC8HF?Z_US#052Fa8^4IfZ<ECUK0FC2]16[F>ZR@Bf+^bQEfPS#-4O8GQ
?c,MRKY[b3?50F0ZacE7BIg,Rab_S#JdF.&&TWcKgfe1APEcBfa()05#=3LJ4)=4
PTKI_)E0GBE3Z,D&A\YVN/S^dGH(cD8GUE@K7U8F2LXL>7&bF.c97U5e9ZI>;eFb
V]=7-a.fQ?c9DE+XK:98C-g1CP0H&&^3+Q,N-OME&A.1:\Y<e\&8\R3^>Y#,Aa8.
Yfc6?;fFX@ND3.;DVP03I(IdN[2b2]W(+?b<KM\@X7ee=Z)@+gDgb4]bJFP_OXfg
2M9>F8J?KEDF55UB(HO<-VM7D1&9H]2dSW,>06Z;?K]a[@.:M+/?QW#W=_e5K,gd
fBTL<G<LK^O5ER:9HVM9&)3e[IPPHaN]K@UZ\bd9XSRf,4H\;KHC#a636ZV<,d<P
#=a:cTS3AE2OAaS5[9X2:PXA@-2KL]-8E\F)Se3UcF^AE0#=W@:_f.-e:=,U#AJ\
Z,@N)@B>0_,<]<N(AfAg9P9@>2S^OEB&K.ZaX7Q?2\/#Y2TZNcJZA]b_Sbe/\dCR
e?;-\:e+ZTPMY\)VGJfHIXKQN4Y@JGKe@b.>DJA>QZQ=VVc3H=7WR1bB_a\ZX:NM
:=RBJaJ:)BVS)Q<fX7\):a&dfgGE39Q7^Lc#859TG.5\D/U@OMNNKL5D]Va)56<=
ZE7;:XS;LYH+PBB\?5Oc6QSR<()/9XUVBTY,E\:?#)CN3:a539,C/K-02:TQg_Ce
7WA)9I6ATHW830R46HL@7QUJK_Da.#LR316a0e,H;6<<,3>L.;f]]_5[R)>I7,TR
7:AS3SO30?BE7-+83T3?QKV+RU#@-@gX3?aEf]S\NLL04fLN2I9ED)Q-5#U?I)&@
+4dAS4a3O?S\T/793gJYWHP<UQ@6C;;WY.X,IKCZUgT7aRHb0VO-FVD).+bP_KWN
[Z_Za[4VASJ2cgK(bM/Z#<7./&P[):?^ZbVO^^IY9aX._][cM)aVAM2PHOg@>Kd#
GQY.S:3J[T].<_/M_3(&&W^e_?;e6^SaLVG+KZ7<Oa;+cgW5S&T2gMbD+_[&-+e-
Z)SU/V(9JB+L4c=OZ\QXV4:\XCEMgQEU4)E-IOMX+L-cEX&?4g4EQ7?JZOg0.Jc[
;&1U@gQ5/3SW/SZUTCROJMSBWBdDgP6d>g5RQ5+g=V,Qda\=LE;0Ef/0.RMK]J>]
c?5-X831:3X.XV^2abOaK1\D&/^4beT_T[2]]C<(=^)2aJ1-@4?GXg&Z\MedOQF@
.agJP[4/(XWWP67L?Xc8/::-D:X:I,SL6619gT;74DA,([bH[[aY#D./0QZ[HG#Z
,<I(6cZ)B<[F2CD@NcDJEQ@DQ/G^XN+)Y?-)C9V7UVL<R<8=G>=64GFLI65>__AC
8P1>22Q.e,_](,>MU+]_9)eB.]ZgK80+2H+14Hf=ADQQ)8^9;/\aS1,CY#9Ha+_.
QK(1d?DN2?(UDL=6\bGW3P78(#Qc03DKMXP03FO(edIR7674,>G:<D#-XgcH0/F1
X@N;&]CDBKegK6ERD#HKN:\OT<)/69R_]+5@gcWIHB><cV@fb/W\D&S4/YV#O8MS
N(EC/eIX5UF2UJV&bV#;9dZU+/KQR_PN,3f?cUPR#H2(N&ILLAC&DNcZUME?e;?=
?]g4NWdWW=U\-.QTG]<b5Z7J?MaUM1#[W/KSM(_H+1HDK3dQSK@@#.@.QVR_.,8L
)71;0N5I9Lf:?&\\K@LfbX&LJ<_UH##^>T+IGTc;K_2;Lf0dfLaK^,Ta5+];O[cK
9Bd3-9&c^c:DHe?fO.(g]7a/0B:/K)[CLHVN_[_4BgC#c_7#HPg1Tb)WI7DY3342
RZ]#)dDg#C:fZ/\;aaJRc8VCRAdG&/,CE5E\0&(Fb1\>a:-=GY+3CQ02T[W6,I9L
>Z)f2INAMPCK_M+2?]\P+)[ZdbEZ,eE\7;6=>IX,e>P.I4XPfO2/_KP-?<O8VZ6B
@1(D68@4d:BVMYR@6?4L4H=d.R^U3IBCOS]+^T--U]3J<,6)cHE2@_NP2;?TdYMa
WaDY2RFa-&LX_QW&/(0#:9D?&B_d2_3c=N9I(aM4A8Y.4U,/.SDWJ1&0HHD+0RaP
dN,/ON(9\aMdPJ?Qf2d1\ND[d6F4&_Z.O+?7ZV1Y.WG,Q]2eXf?e@A_7K?1Y?gEA
A8/b8^ea5-Ld?[H;7TdCBUCJTLMA3D,)eWEOe=.Kg8=82-@EZ(X<#+)e<FY@[;>L
.E0TO7MZ\)0]<WS[DW6^)VeebW>V+)38XX5Agc&b]P1)<\:Bb:ZQWQ<P@B;a.TOK
-N+=^XR>9J<47:dGF55-d^7W@EL4>Q(>K;+Y/[WPE4KK7:Y+VPP@M]b1G>#TQa)_
/5cJbG&AM8MPW4LD3eLTIWb-S&_F3V^^.#+4EUK?.1,6a?=WK9BE.=B,f1#5F#]A
#5\I2D9S<d?afN:-D>8@aX/+.,D5\0JMCA9?2^(E;^[E9C6#21Z@^&[<@_cg_dM9
^5Tag1cRaB@aJSSGIPbB3#Q#g?;b)g;_,bFTT]7I_<XNIV+YNb,,DGgZZ,0b448_
Z]Mac_-//^YVIfd8IZ3DCacDF^L:V,fOG:2dID(G7_RJdTCG3=.AYA1Zb2?(1,3O
W4G/e3b(-)UgG>N0V@F-c2#OL8[cP354ZeLZ11.;,(e6H@0#b)G0ed39PS/VdVQR
2M)d_IQ)14fNO;0f&JTKX8&MQ^1P0L-a2b++S2I1\D,(+>6K</K(OU.Fd3cec_g7
TQ5bBa5-[)9+@&3UC&I5e;54&S<d5YfT1_YM:_J4V?8cMPgJ^?XXV5<:)1MZJ^3\
8(BY14Eb77_X;F1EH=Z(aJ(c4W9He5??ANR<D3ZU,:O2AMMQI+IZ:E8D)Q8)W5eg
ZT[5&c[F).d=AQFT/Y#TG6=/KBAg+DAe+ZaCR\]KG?NTC0b2Q8f]-J<8LE<K]ISA
165/+_Z216_=cN3E9(=fG>a)eI/>WE(WMO11#J0Ia2Z[7(5^+F@ZF7(&00<V3P>N
b;2SVABZ#514D\HaOETWXeJ.U[K1RG+2fPC9#FMLL=;4.adT,B)1ZX..Z0g3E@+g
8d+;D(:3Z[KY)27J[J:,.+F2>e2XPHQ/@ZQK9LB(Vb6G\,3Ke0A^9eI=3I2\AcCD
TB)8R-):IM1[?^S1++/f.Y#CESC=N&4L;?<.NY&^>AWA?SBO.Bf1-+C9da)[a#J?
Ia>Bb^Ta;>)F?f4eA,.C,SRH?J+e_(Q?3.=/?W_#/)219^/e5UfAWO;&Caa\V([T
WJ3(cZb^9#fYI&:=f0^+H(4=ZM6S=W6V-]&NU1[;TCJ\/@+#4\\9XJC&U_9+UQ#E
WH)@e?H3S/8D_1_G\g(3c\\(JN8+F)g1^#7REXRI:Ra)O0W/QH6I_?,N.3BZRUVa
b37A@6&&E18>UXMVSU2J):S#.I]UL?+<P4TBN[.3MMJ[BR>7E9?^6^[D\-S@_4H6
c:fX2X(]=f:8WUV+/HYZK\HfL.Q^ac0,Bbf7gC&?SS42M\:?CTL5^T/U;KQ1<V1Y
]X>0&RH@>?<Xgb,?GVSN:H,B[U]JCe?ZYXB5-bdDP/0&Z4a]&F3-0TNgZ5MN.A;.
S-gJXWX66O5+f8+/G>?<deEB:\AIZ#bA#9U0I+6)b.J=]B?LRGd(I\eSf+^WfTe3
B\cU4X>R+PfCI=f+LBS+.O;@BKHd<)_Q-K>e6[V[6+fCgXb^fc>CL\2A8BN\4dC4
UgZX#e^FO8R;Za0<:Yf>HX_C0&Y:>0#CGIf#ae^&4\83KRL,QB&@DX/YO8DWFIg]
HUR0;KZDSTKIV&:+E+WWL/bBJNaA09>c#PVSK;WXPD#/ZJGA<KK9Q)CQ4b_H04UQ
7g6+09SC(R((O]:b@DDRe/WO)gRE3e-/-E,\R[R2Q68Og?U56+2>O:.#:A^Lcbe>
>>@?V^5I7e)NC^2b8&NM+N(A>.7Y>U4a(NK+75?K()#d[\Ac=<;58./PW0-f>RV1
0S1A?M,(9@fBX5Z6-I9SB-H^-8U/8bWaWA>cc=@]Y1b5Zf&EgZ6??AX1(E1-L\4f
9@-aaU@60-T3C#54#-QYSa,W3(c<.2S#LG5d)E(?\10^Xd,-ZWLMQK]+C<CP<XR\
KN(fY(D@GN[DC3&/(7.#Bb.a>Y@8:\DX/bD9CI/&F)0Q+EH-LY:Nb>HOH?,0C.,M
I=0@C[G&Z^=TK^&3\[_E;-T<X9A[F)#:]I;DG^D#1fa:7SX(b8(PA3LD4><:6)-F
0N2Q[;f3H--\KEO[D[(I)a(I<_Q88+_.a<HT81UR4bHPT?dQ549KH?[=T6cFY5fA
,H1TQW+d\1C5Q<^)I(HA?M>N1_7?3ISc?TVC;;DeSD6ML@Sc(J:adH=C4</Ed]@a
ASebSZ\dI.?Hf=RAc?UOBM5MdU=F-Z7W6N5H3(;7a83&G@UW[08#P/F(6,e=P:dJ
6&fd7S_?e>cR(K.YRcDaGFgcWJC7S.YU@fc[eT,^g7ESA8H.d+cdQI6DXT;FFc<1
.[(0W8)1eB#HY(/)BY<)1eHKg>TCNfe9D03gL/N.AY]f-L-]H:fbF_6DNc6&\JN<
BC-YdW19_4g4WEWa2Og51_K+T9>);U1)^U^UEO53C#/RcC2(:)b7VJGWRMD6^<2,
LPIeFQ11#KZ,d4JbQ(<6JcL/.C,LQ&,F5VgT2,E_/UOaM_?D#4I]K654<HeABMA)
=FCf3,fVE5O7N_9-Ged]5C[V8^O]0+ebHUg(1X6SeR7d71S+0@AZ.B<CW4U\V(Z9
4F//;XMRM.,BE5RJC?A1.D,e<C/@d+.+1U/W2aA<?T?JNe<f_2a7?U)6;M:?80c6
.2fWHGD1B7NG81Q7Z]TTa@^]Ue:fGgU93<7ZL.XPLM?[7OP+KA<2)=9R.ga+FM;R
#b(GE6185M0#d?QAV4A&#<EQ@08Bb\FJd(GQ#C3=X8^Sg?#=V_[(JIVV>[DNIK<)
]^CDXfcJ;ME]4BM>Z+MWX,b@J9MY7I&<7-A-NP/PV?=d6)]RMXXJW>0GCYU_7QE5
RK0OML:>^-(8f\Y\5bR;?CeS9=J9[AVFQe1GY#Yb.:YWR6;\+IL0OAYb#:#[g.K-
Lb7G-IXC6OC?.7@#Va813K-INQ.1O7B-K(+7,g/eJ.Y1eZ>c#D9Ma[8aLX-M_=__
cILG+2-dH6LKF48bEH=,;,?]2c#eXD)K^PBVQZS6P>,[_-c6(RKQ34Ja65I@RAKG
b;bTW46FcXBE2\CdDFgEF@ZTGf^:J)5.QHK<]9=R5baZd,+-KJH?4XV0\^MFZJJg
&)cP\WNO1T&b7TffWD.R#9JWb#aLI3&^FW:1Y+8?8</WXZX8DBQ_SEZ#O>+0J(eG
>@,T@cc^gST1T3Z3ZcbU0GSWDG.L26_W^UOD5HB@2JO2X7K@H#VbG##U_A7V,B0d
E.PW#O5X;Bg71QNWST<XG5&A@&f_3J#5R>DH40HRMY=3Ug]&N83Ad,W5JICF[@&]
HBbU(a4D(D0,FD1]&EO4ZCG0-FD09a(&MVd=MO_@K4ZK\KHaOD7PPF/FZ>:C(]^0
[_QX<3>AaJS5;\Je.J7#)Z,,KWV^1)X&D.NaC4R.Y/C8g&->:LLcd9c)gI&c4D:^
;56d:B_]-7+7dS.0=MZ(7B9a:1eaHSE?U:_#g.FRW<aG1\5OXeYSP=Xc.,#&HbBZ
.e153Dgb)OcA+b<A(F6>GVTNEf@=<SW.MgP94Q@1b3DSM3;_1<]>Z,6X&f@_<C5J
DDLMVc>f;O9&5XQ+_f+],f\OPAV/1+G(TS&J_PIY<abg@650g.,5DX9>&&XT[[dB
.8&d4X);&;.5/\c<JK\R5M2[50I[6ZG:ZNHJ,b1,&M]-f4#.J9e?1-eLJZ>G-9/7
Q]5(XL=@J[FCFJ9H(,WZ-PMH<OD+LXT&M8F(Z8NYMYIJHSe_@OY4(@W&<,Xg@38V
\3LO<YV[9G2];-:0PNV]g0_L4ff3+-_)AI<8X;V_S1GgFGVB,S::dK:@4a=QOXOA
##<-G,e&@(?F8YDI9c-E+1^AaEZBS[HG0@bOI0cMDCSG<cLPY19C0FXD3H((G=+6
Ze#8Z[e_?4fZ>:RG;PYBGM=O0E[7f4IX.Wa?4;YWB<VRMRC6>007UH\-<05I;XAF
L)[=GbYcH#/Gd.-WGV2O>ORJ&f8LAaDSV/IDJ;DcV44\TZbSfcAQ9_KQgg2QLb:L
eI_<?65YY3J(NJJIfdOg5806L=R1NP7[T,Y=H^WKLAeT[9BRGFcDO?5/B<4g;N4?
ADT5>>QLaGKN)\MZ3+bM]\Q_/L639fdH_bLJf)0L?CV1E,9QK]9OL]<e=@21Y&d@
/61F[YKF#T2A]GEM@BcGDBZKF>fTJ@<bVZ=e?+8PI/WBD,K.@98&CAg?<36>3_+0
Pf0.[QV4.Q\ECF:a6_H4PWS11Madg_Z=+<I2PO=e#2Qg@>6.?.\^:M<3_/IK4<e4
)Y=50]/J48M18YL;<#0)PZ+=VB]-b[AIR1.(9Q(BBe0dDEQ,DL3M.3CL<(;AQP?.
0P,<4-fTgAW)7;JWZVF2g)&(TX/CHgO38>F=TA2(D4_0W-SJd/b&SU=3E@+?E73.
:YEbNX=K)GUZF3N4R4McE?X1X/]6V5[/fOEP7VOS\(GOU2TW)&ES5])X28+H5;UN
<B>@1<(aLE5V2bCE]=@7L7f)LeJX+6?572/796#N0b6V[B:&;QA8L/4B/^gOCQIG
d(L21XDSPVO&bECR26UeF;]PIH0b:g@)]V7Sb]fHW@aKg>FG>3><8,\F-A],C;J<
2KXJ>(gRg<(#Q=C0D+,;?DM&F0Z3_(\c(#1aT>?4H,6JSS+=)e^dN6]g?=IRO.b@
[DX;3,305d]_&+]<D#ZeX_Y)#Hb9B,&@6N(\8F\7=.F)/F[?3LBZ]ER8+A]7WSf6
Og\;.dV&(/71.[KS.,EJ9T1J3[?S1@N]fJaP3aS/Z<B2>cC>50)>ZXEe=?2.YWIH
WB#S,B4B#15=A>5W2<gcEe9ND@<E3D?UccO9.3(e3MNO\?g1-YJ94\O+)S^U+;VK
ANH9]->Pb.WLIbbS2Oc&6b/,=M7QVJ,+Q)&H[(4f(OW/cbZCD5=<_XIRaCLPW5HV
af5022:-UCU\Rd^;B1205)GL/#4(g[XC,00fC&eYf]7^Vg#2^fO:S&@;KQ:7FN@,
W&?Gc=MGKZU/\ed8FO9.>U:PC4[fB@L7[[C9OQ5VK^0b.=UbCOB6-b413I]_G&7N
V6c?SgKR)C#D\9)_V]b@/a9+BJ#</d?;F-?)[Y>NR[WK2P[?_0LAEH.HR?GAV^;E
KT?:=A<RJG49^JT9#OgQH6FK2V;c_)aX=3Y\=3cd\_ZCQ?F#WE?JL=K54MFL0GFa
&OLW03<32H[8_(aIK;]V/#NG7dUbgURZ9^;c)DGN-/QHXBY>.BY;-fYd]_-6^9CJ
,1;X0G<#5PXb;+=Wb<)5=ggK[\daK8H,=FMHLf[e7PdR[PN?@E==13ZDAEDI]K]g
Y[O>]dOe?-^SU+\N#d+P063OS0U?_:DH1D/<H)[Ue@.RF.J7)/WWIgM[BZKaICQc
&6Y=FP..MZQf#CFU([#-a+FW8(<eW)KX:V[8]&&dEAa:^I9DS03R@d;D@.J>#2>+
CGBDF03->,FPDCAWV:\4d6Y33T]E2[P5/<Me5N96AWE2/;K+Zg5([<d70W&DJ=[,
-;CGVCR./0&0(eFN=<12HfV)F@U=4N2E?_@5XI0+aAQfUO<50NQO-D=]Qa4J0/8=
\.U@gb-WZaIGMGb7/XEM:Be0WRZOP-SZ)D&eVR-3<Hcg=Jg/AZX[&6NbQN2?V3CP
,C5;3\+B2-)C+]Z64JJDEg+G>7VJ<F=VB6gN(VOL9:T:P[eO:O38AfcfDLGCU.b@
0RcP)6DW+?.GP(YNZIQ[g57+g#QZbb](aO&2gVCMV)PAQ_/N=GJZ/3_/fRHBV^39
Z-GQJHRQKMN.>YE-B]2]5_MXY&&5R>5\ge&Y+L[J6TSd(LeKN++SY4@4V__6fBR;
ZU2fH6I.4S.DP]B[bFZNXQ^.a.W[P2UK,e\&\/;=6Xa+aMSZT)8AUK^0[]>fNAa_
Q0ab/G);bf?gC.-O;Z:4be02I_.DF>K#/?543Y;3TG^)af@XM,4X&U/E)RYf\)S(
_#(D-e#N)bCV:&b)AS9NYBLbcF0Pa:dc-C9,JH_e]80C&UE&Nd/cbd)9BFCC=O3I
^d5O9IQ<KGGT;M^)9_:9N-.Z4&PJ6O[2R+RM@2)<Va,R3VgO]&W)aCCf@)HfdJG&
a&P/7+UX0Z](YZPb&WIYR+33S9VO;a>7Eeg4?\(<SHFe<Q(OC)8#^=]FF1ZP/;C:
B\#eDR@G&bPNAa6=&Ha+fg-PaRBgK5eHZdEC35)[c^P_^Ue_I0?^4-dNJR5A19df
JC;XTQD&(W0622K@dT>Df/bd]RYCX]^P6#AI8V?W,GAX)19)AD)(]^C9R>IH@AdZ
8@-H&P]e@#;G1NKOfEEdd>aHVg\4@<Q5EQOPIWOC8-e6Z4bEf8Qaa,=P.&S_TYbV
dT47S6ffe[HMS65ONdW5JE5]d3cT/6KKC]&c#JV@]Q#g<E@Af[60TaO:)5.bFE<3
??5aJ=-eeW@C[S:Ua6g&5+CNEC][a,B9QfX,c9YN9)LJ+9KT,;eMB9M_R1VZNf6R
0D-.\C2DM_:,TT<]a^aAAC#\A1XM]2GK9)WR3H?[/78IMF8?fLJ>N.dO@[NQ6\:2
WB1cP>_fH2I)?Dg?E\N)8ED4OKDZW/.T02S;^>6ee\eE:=T&bZ<<HGFZ/GL^:eXX
]8J.Z?S&<NPZI5fWW6??_7,D)91a(b.gR6HPO7BL#Q\(K-T\K3L]N_4C,ZV^2NT+
7589T:e)QXG)ZM7:C6?\(e<M(+bfWL9RRC#.6C?T,>N]eGEM95+89Q;gRXK:,]Z:
EDDaN(^TBZKZfL7UD0>WUA&#312QPFS1f?SRA8/3GWAE?+KH,:(=IPe&-B84Jf4B
QS=B7L><IJSBG27N69DC7(G]XTB:#.@daTU9C?2JXCK[(=U?AdZ88F57>fKf^DL:
J[Kd&E3Ab&VW7Z_@-N9PJ8eS-V3F-,b=;\B+TQ59CW31e)#0MHKG^bc[<eX6ICN]
VQ>6,HT?efJ/Nc;^fHe3fAR;V(2],g26g;B8;1SFVKPYBV?>KA^A<=/8)1F=4_[7
[Kc[<P#JJ\Lg:KGS0C(O5ff#0?;O?V\P2e3ba>VgYGW<AL4)fJ3?-/T^g9WHA/C6
<:[K5H#H#-YB2/#TFfA\47e[/W6(;ePB>@FR=:>bgSPE2<L;6OfN(>7RZX8T-F4]
[6:d:#dKN#X=R?d+^&6/cd2X,3\df.47:J3cfSDPJERg//H\GI:I.[c,VK&B;f4?
O/@A@IEF^Y9:7>B4YWLYLQ:;26LD5(D3@I_ZdcLF+=Ke>Dd>Xf@)XGB<MeMBHEGF
c.]P\PX.cY2^8eZ--?1cMXR<NOZ7P&9VS/G:).^FD.Xg=.T7_P(;b^/Lf^XbJYJ]
8DOd1Wb:W.fd@]_=II.=V5]SVM^SK2ZeZIPQ?V]\WU;/A.@W^><H5@Bd.A)d4[EN
,I0dHOJ@<<GO)GOP[?=Vc<YV<Ke1#]9]WDA+WP^R1HLg?(#AK0&cRSJ<eXN,RZ&-
C>@RR8PND>T@>ae3M(b\?:0LR67OM8dZ)I:U90[C6O6/E)+N[R7L08E08P?JZe.:
?I&d>\BW7AYIPWG6T@f:;f59Y9e?01+,_9CI/4=^7S&=M-N1DAS62MPD5?74A.eT
3HCIYL]/#D=Sc:<g6]42D0dG_)/UB-dZd_0Bd<gFB\DIT,MBBX3bZ5aC@=I_LF\g
O&4UW/0LfW6^C=EfU0CPJI0;#f.66H<RFQ9:8_d:,.F.K,7aGG0)/2F<1]7Aa5TN
3^LEH.1TdXQ@:Ed)RgM:bYg71>aWB@-]Z(\KUGTe:]25Z=I,HQ(fG(:1.RR[\23E
L=>OYE^AN#Y4[bY4eAXb9O\[1,/d]Q]8;VP@b-b?8ES/-:]4:^<AW@0+^-.,;4>T
+/[^2.EV2>]=Y.GeR21gdFRGg@[]Y?eP6Idb[GNaF,S0+[\7XDCZS<JUVf5F)R]J
;2L&ZRCf>Z&=9UEc]\J?75^V1C&J_T@fJ_fR^;;dBETFP@0CK32P\-SdfM4:1Z;c
4,&I?XBSB+gS6O#&-_NUaAS4;HRWXNRgOC3IA4fc(V=@Xg^WC2dT>-O&:f9Dg.+L
8BDcD?1g/^=9D4R=23CH7e4:8=J?XI)E2SZ^9f&bAgc^_P#K05I66D0]Fb?b:FKd
&;[(A7^W]J59dCQ-/R-(agFNN#NH]DKP#ZBA3CMXX=6+,ITLC(,\2W)[@&:c]>KD
RZZEGGU?a>N;<QET;MKOT7.K&Z,5-ZcW^B]Z.UEVBWNCX^PDXYSSBK)Q=9Va(=OM
]gS:,&bLO,G1ONe9Yg#<>QO8:cAXB/HQ)#HfN6-.KOE)a-4,.ZI\JIM])5G#1WI:
Fbf#@ee0@Y9F@CR)5V.13667W80gJY<@<cdG8<_JU<@\4S3VT516&;&?[^MI:<HZ
,Y88eX_.E6M/GC^+U>@]\92P+_e7b7QB-B0+2b7@ae)VCZD):0gb]<46bE[3>)1T
BUf<JE5?]D,//2SZ>+B^QY9QDPJ[#;BI2E>&f0E939^)[)_W+>Q[f;>I<gJ0>Ta7
3GQSW+,3Dd:&&[9R.0TcK0SP3,D:c4MW984I-WF@H=2214f&eMI>Xg=I@+KT9A?8
C0(^N7MP^<P\^HK[VF;PY?>KH3)8WgZ?7429gGYQge)9.MV;L6b=DTVBZFU8A8Xg
)&9.WU9\MSg9L5_8]NQCUJGCF6KID;ZFUYYO.N<T)RTH6)&-MQYfgCF,Sc1B:8D>
C[]0X:bKS,:^Y&2-3K.AR]L<Q-:361-;I#C_8b\P1]LHE$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_APMEMORY_TOP_REGISTER_SV

