
`ifndef GUARD_SVT_SPI_MEM_DATA_PARTITION_SV
`define GUARD_SVT_SPI_MEM_DATA_PARTITION_SV

// =============================================================================
/**
 *  This is the SPI VIP flash Mem Partition Data Class. <br/>
 *  It contains Data and Data Valid Array fields to be transmitted in the Upper Partitioned Data.<br/>
 *  Currently this is used in APMEMORY parts where Data is transmitted in more than 8 lanes. (16 lanes)
 */
class svt_spi_mem_data_partition extends `SVT_TRANSACTION_TYPE;

  /**
    @grouphdr spi_trans_flash SPI Flash attributes
    This group contains attributes which are relevant to SPI Flash
    */

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------
  //
  /**
   * @groupname spi_trans_flash
   * This field specifies the number of Mem Partition DATA bytes in Data phase. <br/>
   */
  rand int unsigned data_frame_size = 0;
  
  /** 
   * @groupname spi_trans_flash
   * This field contains the actual Mem Partition Data to be transmitted. <br/>
   * This field width will depend on the value of data width configured in this system by define SVT_SPI_DATA_WIDTH.
   */ 
  rand bit [`SVT_SPI_DATA_WIDTH-1:0] data_array[];

  /**
   * @groupname spi_trans_flash
   * This field contains the Mem Partition Data mask bits. Supported only for flash Mode with DM feature support like apmemory <br/>
   * This field width will depend on the value of data width configured in this system by define SVT_SPI_DATA_WIDTH. <br/>
   * data_array_valid = 1 : Denotes that corresponding Index in data_array[] array is valid. <br/>
   * data_array_valid = 0 : Denotes that corresponding Index in data_array[] array is not valid. <br/>
   * If size of data_array_valid is 0, all indexes in data_array[] are valid.
   */
  rand bit [`SVT_SPI_DATA_WIDTH-1:0] data_array_valid[];

  /**
   * @groupname spi_trans_flash
   * This Read Only field contains the Device Physical Address where the Memory has been updated/Read.
   * This can be used in Analysis port and Scoreboarding purposes.
   */ 
  bit [`SVT_SPI_MAX_ADDR_CRC_BIT_WIDTH-1:0] address_frame;

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
   * Valid ranges constraints insure that the transaction settings are supported
   * by the spi components.
   */
  constraint valid_ranges {
    data_array.size == data_frame_size;

    data_array_valid.size inside {0,data_array.size};
    if(data_array_valid.size)
      foreach(data_array_valid[i]) data_array_valid[i] inside {{`SVT_SPI_DATA_WIDTH{1'b0}}, {`SVT_SPI_DATA_WIDTH{1'b1}}};
  }

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_spi_mem_data_partition)
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
  extern function new(string name = "svt_spi_mem_data_partition");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_mem_data_partition)
  `svt_data_member_end(svt_spi_mem_data_partition)

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
   * Allocates a new object of type svt_spi_mem_data_partition.
   */
  extern virtual function vmm_data do_allocate();
`endif

//  //----------------------------------------------------------------------------
//  /** Used to limit a copy to the dynamic configuration members of the object.*/
//  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

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

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Extend the copy method to copy the transaction class fields.
   * 
   * @param to Destination class for the copy operation
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);
`else
  //---------------------------------------------------------------------------
  /**
   * Extend the copy method to take care of the transaction fields and cleanup the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);
`endif

`ifndef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /** 
   * This function defines the print task for svt_spi_mem_data_partition class.
   */
  extern function void do_print(`SVT_XVM(printer) printer);
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
  `vmm_typename(svt_spi_mem_data_partition)
  `vmm_class_factory(svt_spi_mem_data_partition)
`endif

endclass

// =============================================================================

`protected
,gIF0D?b+/#RVA+ge:LG=,S:UG)DJ<=:[MPFMP.[VJ]0XIb#eK990)NcT1#HZPe2
#35QN&4.@,b:Q_2@6CcK(C2(-ES4UIeLG=-_R5+0]a.S-ID0XHc;f+/<9b5QLH/V
5V&fAE)S&MMQGD&Hg>\G78.d;0-S0\WM=b/CM]VII:K7[7.MI_SGNKODbB#=4a94
LR:ZI>,<gJ.E.c]\Q41L6]Q#ZU<=Nf<(TSGBX_UK-#MTM#DPdGD,bd&;ZJ71=]DR
M\M.a.5I81<;W\WaI.WNF+S<(JS)>PZFZAASCdX4V#U9]/Fe1:+Tf4_-+(M>EKf,
)+LNJC2)Nc5c78<:(2QWKR+fOb_#90(NB_3eI4Y16XX/=Y;@>&((a>,D4J_JP(\=
D]Oe>:?]eQ&.J)G-G&gA10U@f2Z86F^U[WLb;S\W(>YBVL7[OTYQY/>cF;2CNS7]
^PAASYB4f0>-J3^Q(4=4?+,F&N9_HSG-W9f[8.UI59,d_8;]K4^e6-;Q@/1RR37^
ZXCCCN3BE)aA0H44#ZY0g4]3UP2-0]Z^&70N4+fLA(S2_MbMDBXZ]6f\=<Mf(5ZZ
K_\.H(2MF+30O)OV)c.+d\1e>Q<E3FEQO0F05b-T\YI7I9/@,GIS+LW\DCabR[\0
V,NB]37;BR=0,$
`endprotected

   
//vcs_vip_protect
`protected
-7Mb/]5eLUO/5.d5;aFgD2O[Ub.(+[9NAVAG&5)C6>@25?aY]1@@.(d]7<\;P:eb
c^7Z239.UYIdd,5P;48VGgR^:J;?:BYe&<c-cM[;6MIGM.bdb56gNMRH(]MT<a@?
&(Zf,1#X/S;31T;cQBSVL@:8WZ.Gd\>&D8:-N]aV+0#cT=8@ZYAJ-A(8]AIERT5+
@GQM4TNHTP7CTF-.8YT/9)CPNT2H6NcOT[P]2^7F:15b3X+I8[gC@8#^ggL5,816
X@,F-7F:MAX+]\6a;X0<^8e2.DM9FNERcXQG(E;.SZC:PW3UdWNS2&WF\U#V]>1V
Z]RSbWSS9OEb/PGQ++Jbcg:0<c_2Gc-^K9aYQWS8Y@6TI4(^WF&8ULYV8AR\\/?(
HD4><@bP76::)FWQ_dbeH7@AU&?@Lb):1JYLI98+X<;,\d@@_<G9?-GdVF&4W#M4
S<1)VZ:g<#4,V]J4P_#T1L1X0;(eWN/3/6PDD)K.K9&.L0Bd+aL()H7@(OOfE25b
_INXCHDJJZ/>8LY__J&d_5=I=UDE>1dWN<@GU4UbaRgP9gV;-1:GL?;#UddV,U0)
^G(GgSB?8G/KF+(1B0UG#5+^[\d^8Q:5gf0?7+=E0-Q&?LD&?G4=SGB9fPINe?JE
0W0J#WPFUbBXM325/^#->a-\:=J@9e/#NU39&IL-A=8)-H@OA4P3GP1_A\PVSJSB
=fg1L_&fNe>.eM27KQO>#P)K+_&bB37FYY7TH)&:^V\#M?XfQW>]R13-ZfdX9SPO
d(/6:T/48KfcgbeO)4U7fbVUGG\)Y9_7EQ;g?:.HK&M(/+aKRMZ@cbgW#]&gVB2T
;&&d.fGUgdQ0<SQfX9@KIIY1M<F5:)AggUL]GR_X_-a4O567XNS>][R6J](?XB3W
5H]Sg1#1]G7QKD@L0:EeeC-7>N<SYPOaKVGU46M&Zd)VLVV.5H5[E9^>MX=)?1Ab
(8)FP8B\[D)EA9gQPR/L]IGO.N0FBY)LU+9WBF+O-fZ^);DA&FQ9/\S3AgP0)U;5
UP@F8P/a\7T)P\TK:e8D,B>G;a&cT.+UbZRfQG64YX5BOdX<;FKbC2H3RHQ+d(X6
SQ-Le>c&YN_0:/Sb0>VRQ<L9;);ZXK6K[R.L<Q50/EQ-8a\\cDC#MGG]]32>W?NM
bJRYQf-WU,I[WG3T&NF+VNQP>]dgSO?0]0Gc]R3^X/=A@1VL2G?KY[^IY/cZQ+B5
b;VXM?PT2ed>_Z#gQVF4E&W38BW3.WI]aJBES1BCF81O1)=3B:+3PR_V-Ac;UH.g
I=#FLc(gGPIPN9:?HgGgeY>&R4M-JV(/>58fe;VI1GE&L5aD1Q\AL;B.e88<@_\]
0IFg.Q8.c+3Sf3B+=\LWHFJ<JcB##8d;DDMRg8^<^AK?6D6gb)TLGN.B.<(/EGeC
7f70-APM=NXA,@YF=J91#9@O-]fa;F=eX3LPc25UC7N@F+2DGKP+9_WOPBLa+<_<
QSA/A:;TGa(>&K)KDV2YbTA&Y3Uc[Q)>9WKL_#0R\OJQd>N+f::IW4G.75@=J+df
EPJX/Ob.5Mbb];;2fK2F9@D5<A3,F]SW]c555MNUIECg/d<-DM:IHSN)?/CaPQae
4C)2SOSU>5WGMC)&PMIGCe725PFc8=UY3JJ>?\<N&>E1ZJKXSX0_a2f(>?g?]B1B
eX2gH<_9DR^H;B8Ndb/HgXa/b;3;NWF\XR;@f/SU-62#\9(WHLSD4[;DO)L,.O#4
.J;cdEGG&<b#8G.;T<Vd#de&^O[=5IT>;<U5-A#d;M&4(&@-;H-2+OGV9ZO218=O
;CS9TP;T>XM-[BKH4]\017e-,PDL.K<e[9;-P):]a^ERQ:=Q59gJS)BbA#&S^BCb
O#eRL/?/COGd8+MT>/NSHfZBUfU[3]PNgWN;OZcaH-^cH.K&bRP.OL,aP,=X-;Zd
W?U\cbR]Z,N@PZX9#TD,ETZ(S7f#;c:E(][YP1=X98V\FWL+.6eMO0?I+4\&TZ7.
EGf[]d+ZF_Mc;a7TeD./c+f@-^KI;/M&];=5QUJF?BQ\FAX5BOA@ES[,ZYaULb/>
I_R=O0abZb<U0_ORZ1a06AEE<>24L\<Jd19gZTS5&fT\A=aI=:Qb#gN[Z9.#)0@W
IP@#2R2D7=5fg]7>:#bcURg@6B60_<8S8BBM0LRA&HW^#a9VK&Ag38cMK_?B,MR0
PLIS]b>&LHQec&^XON/VR.1<;c8fH1JWP0g5,KHc&9JS^7K#Ta3g3J&[F?\HQ^c@
<#eI3KX4@@5K@.KgIcaU4,gCS9dedV:_TXLgDDGGIF1Acf2+D#9GURfd__+\444-
?[b@^d+NLaZT7=;f(2&aPPX)X3V20FETZdRYHG\VARbdY0fdZQ7VK0:e]H,R[0Y9
C@FCN_1,/[fG.-I54g><YX[P2FUaM99.b\1,@W?:HX5N:f@FA9^_AcY2)Ucf=8Z\
X5F<gdaX6gggJg8F7D;FR3ICYeFB]a<d3Q#dfgeT=Sc/UL[6FGA\F25JZ@^TfSTb
UHASa&S#f6f(/@05d<-NVZ6+;&f&<F>,@2.=VZG4V2bP-_gC_E5B@Qg+5J4aB;ZP
IQN^VUP8C)B^?),W?F_,Q6Q9G=@LRSV;IS9J^\@MY9P3+-T@e&E;8?0B7EJ<N>_J
L[>H?DA;Y;LYCOGER=->GE]b]Z(_eF(#<eK>6d_V;f;B1&F]=)6g]6&K;1]WKC8N
C2d&D1W@9(<2+F&V&F2+JePKS^PQ&F)cTU<BSX\ROg[LJM:MF+?dSPe5e(?3(JC9
[-)2LRaO<:g-M<MV8ZKbX8_NFfS8-&9>&KeUJ+]X5^g@J17)8OXN(c\XQA>G5M:M
3QETTCUTb7&0#V[5+73Ea=>WK6:.>Y.@2f3+eFD9G-LAgg?X+N;K>?9/T;BW=f?f
#adOZRbKSL9QG-QS]A=adOG73O<9<1A4N+(:,ObTYPZW,:\0RU#/:_gU)gKdNTUO
VN3?A&N9/EXI2V2277VJg?DD9Yeb@=<bO-L/--cf4DFe9=d3<[]Ib;EE8>&]Ae]a
cL&,dT18V[g0Jd,<+\LHYWf+7&[,A,-DGY<8IWeMQd,#f^FS##\G+-A@4B=b0#?-
ST=OH5CQRNW\&B4V08cI(UJPb3\3;]CL?9:NAM<GL>_V+GcD5V)gfPJ5W4A@EW;Z
S_35QPE9?<dF8>YOb^=2,9.9E[D:RaUM/9(K7HW_,_W<4KHX+EP<a_:UM36f[Z&K
^ae,6G5BRE)#Z\W\4>1[?NC2W\_25.RKZfZ@c[GO(9>QKWS/FF(S<.M7,c+BZge9
97/]7T6CL(Za6@EaGKW<ee[?X?:&HKdcUN@#@@cN?@ODe#8cE,_SPU>LbN=f:.fW
6@RK9[>:&;?&4;<;IRd:]5fLUG]H:<?4D5_#>PVCMg<d\5G1EK4#7d;\<9K,BG]/
GbKY)6:0)9CDN(X=,I_00HPYcSI0PEe/+0XW=Y7X1C3ZVR;9CRN8@F-=ObJ;bQPb
)\HNDZ/6UNM68CJLH9IFQ(VW13))aWbJZELBGeK5^1PgRS<8I^/9+E0?FK8?YL9F
:4+LDHD)PEb=f,-fZf)O]<_E#W[#eFa?/&F2@E:4T+NQ_IH,ZX<]cGe-I??Xg:gO
K1c>LII(;FO&dGS2A,aEGN0C\R/5FZa._,EO[;;Q4W9aFWG,4#NN88eaP(1^bB4L
gA&+NG2QZ-HA2[/K.HD3PFBT-D2HLVI5<\LY@#d\KM&5,Xd=5#PaX@+M(Y)JG02>
[-@T1@\XUaE&-6J&<-&[0g;G?#Zd,I>9M2YPb:V]DT+_I597X:RT]0LJ2Z&RWL_.
/D:>g)WB]]VYC:AE1d;]6@MJRG>:?RMBF^R.)BgWbLM/SBD#.@SIG0fSLW4_#42V
WN4Y8B7>TWJQd6897XFZG+974MdI(-AVYJT)<e,(0V3Ef[HCN(O3-R]I.b4ORF3X
c__TO_a?YTRZQS&bT;]_BU-5IG=L25G4GDZ7/Q(;TQXW\SOfFcAPY]=_LP]+E)&X
:LCa2gB+SZFTA1F3N;gGVZd#YVgKDJ4N2@]:U^c1]8aTH6M+ISce;6HFC>TD07A1
VI32:DG5Ag6ILH1cD?NdFPE-L2G-^GeCWc:<Y<KM9[e]P2O1b/X.I_ES(OOAM\;(
PT=0460Y:#M&;U;;4234N#2fF]1Y^/K>1N;MUAP1,TbKY<>E[a,SY2cYP9;=[@b(
P5Y^a-G[a6K[+b\e+SM4_QE_>\4JY@4<M1DH@A@3-THZMg:e-2\5)YO>B_@T2O1B
1Q3]EXQ\e]^FF,#6-M>S7DC);M4@XBL<\Yc5KB\^73P7W.fN9C..<I-dc>MLI.B&
fE2EIWd=.D<X17g8+Y8=_V77A]dDM+^\f@(5dS2.P-[EO4]\#[C:XF_2fZ.e5K1L
c>Z;]:6\,#d@TJD+]B(]KCV#8GW&D9?d>^L5&/&&;bH4FaF22D9S2=2=L0g9><U;
gP>WY5G-LXLY+N\3d=SZNF50UZa.+84b-3\7TU,R26XbI(/?]C#P3^8@GL_Ndc(S
G^RbM@8/E3<b<=1CREfAIIU\G3c:_@K^<fc8,,)CM_([].X9?P<_-LMI][(6C34=
@3N7@,]dVR]Vb\16.>->M+OZ&MZ42+\3LZA#63I&(Jg\fQ:FcSWf2^X?YbUMbHCM
d^Y>U=>5@G9Y\Hg1;I2N+R#[=b=6VR1;_LL\:4-Gf<R#H?g2SKK2KW?Y-TYT42I5
+,KRJ8HE2E#bE#:1N(Hf(7fW_C8TMYS8JVA5T,Ea:ZU\Z?3bL#:7]DVfVbJe1>8e
]A2ae?UXK]HJ@-Td\-3F)I.PO&WP4,Q_7Z,V86S:(=W0@be)KV,e;30Me5W)=,c/
20bZ]Aag2=A2g)O0_:^>Daf&X7b[07VXcZ9/IQT5:MZ:&8Z(DY_1+G5=//J\/_Q/
9B408/@?6TfQ)U;D_L#IUXR8Mf/4NZC9XdKJ-=0^7U6+2MR0>,?.(:g5eYGH3ADA
Ne72EVa(J3LZ&PcE.58<7C\2Ac_?1ZPfUP90-:8L_&g6<?>)[([@S#.0Y8D)b&#T
eH]/Q@@G2HbN/RP&HV?N&J/@W<(GSe_N,(23cF]R?X??4&7X.TbV5ZWN+?8fONbY
,Y5#R1LE;a,g_11eGE1YKBF]8b<K,^]\I3=U9P>?9BFVfAC,]<^4;]P5cSQN>.0c
1_dZ5/XX]Lf&_7O<9g_];9;NWY+:g;J/0GcBRb2^RHG(1?ZT2.)7DX.K7__@SM#U
F:4[5C_)F_B:G3PM;Rg2,T\Xf742I/7TM09AWC6X=EabSac:eK6H+[O1HTET</JU
@_KL8]?IZ0^J#=./ZOMO@R]=.#Ac?dDaVWGgRWVMD,(2TIYN>(_;AY5g0VK^M<Pe
4#N#acIK/=L4XXZ\SREM->YLW8Ka0TRe)cX]6(\\C0A[9bW91/c+)7KMT+TY[DP=
Z:B<dXQ+Q##6.]KR@:R#W.Q1[=>)@MG9g44B1_27.4[:05/IQ,Q?THPT\RDC)4G/
59fC3J&:EgbF>PVTE]#YB:RNGKC,&J>BDQ.,L<gJ>3YU1:1]XaKU/4#:g@MBa8Q=
VS[#a&)R^1DI=E/^RWFK396.+G^)TM&BHUUWH<K-EJ;.1#][bJ;:1):;SQO/VM,W
YSM4HR-K&)]dEZ83\/Q23L\\[XAL\+FAe:]I=PDR(BMZ/&ceL37_7[P6?6c^Q&88
NM8]baE3,@T[c&+S,RAIKA([=XbET&PMfUW+R3M3^[Uf1_Sa,Mf^LY0TbKS+22R0
Ja-OE3D2O6A/7FE]Od.gM81K4::UC6;LCN?T5_/3[BQ<[)/03GFA^)T_1bb\5D]F
YG&[KX&=6S,<&TBI@Za77Z3>JaERF5#<T_G3c-WB;_5c-RHB+UaR9X;<?BT,D<d7
@Lg_LZMA8G;T;_R]0>LBT5+0-)V>Ng^]B@53EG:LMP6DXa5HY2A&;PK]bMEIEgF1
AOT(TQe3-_9H_)U[/23BE?gB1.6#a<VOM-W:#/?2GUT]FN_KcPUJRCG:QfbOKUZ1
bUdWT8S8H&_2T^PZUXG/WVQH;;_C&_#EN3R:?/C]WZPL4-FZ8+45LRU22+^::<LQ
1MM5:NQgDM?_Of;]gZ:D_C2I_1D?M[P?,,(ZVFWGGg0K0;D\LA0A?WS1LU]#J;33
f+X<,IRVY>9+L>55JX7OVR<N,5QIK=G3/>XWeGF=6[(g8)^\\54b&SA<G>/NZc&9
<74[+a_X.Sc1W<A+B?>21IOR;G7;C3<8I#NJB:-<QY8b,fe])e[KL2J=8_PPf;:6
J^;P9[C-/cgY3@)7WGX+20a@IR1\V(6MUKG+:KYN06H#19^a0:5E@VM,ORKKdB&2
-A]&Y/bHb9;#N+T03Na28AL.ITWdf[.1\;I5#F8/81?)-Q6RX]#a=e7NVS8MZI80
#NDXKT[ASeI)TQ\3dAIY+ST\SD>Cbcg?AbY.7Y^fH8)8&)<Cd;UUSFR2#O(Yc<OQ
(\/09EO2CgR:0fB58L/=GKG\Sb)16EUD=-Y__^4IIJ6&C-b3ecMFPLWeAH:OS/Ke
Q&PK=QcR#>,B^e4,U4>Z:RLQ8g:CG??GJ@]B_2G=^aPIXEM?=2O50b^+gGef)H[:
c]<J6D((8dH)++T+[#;P(F#=eXE^=bH1F_9BA;S&N;2af=.Xe[(e3IWYRB_c^(AB
.5cCS;84<<#bTWBPRNcd\Ba4:dSPV@Q-a3ga;3JG<#FIcB1D90=UEa[T);5(60P/
?N+KHHVP:/;0[UYY@DK<L7/@\X0U[]8c_S-(E<BH4JR?PBSY0RA>U0)/OL.OK;)#
U]TA7RYE;:[/[5?GHPf=)BWcH,CNJ?]G&b1CUYV_HFEI?g<DA3:Q<\E3WR8M4I])
V5fV:JMQMUQ(+Mc9=(Z?cc+:b&^]e\c.TaU5K.fFf&bW5UeLMWdCSRGbMN=:2MYF
06>cG<HfEI62XZS3O]9a((:48YO3YWc7fQLT5<MS+6e5]#OP+6.#b</\#YL7)a0,
#U?&+9bHgeE4g).dY-Mg-)-ZG-,4>1/7+e\<5^g&YR&a.][VB(fYY1=O+2(YUOeY
N<Dc.c5EMb:LfB25g/G.N]ENR:6>B=7.IcG=gdQ2\]J9b>]ROQ.T^5)7L=]f[b=R
cZ=#<ec@af<AM;?Q+.=_SDW]PMQ>P#^HJ&D7UNJf(5[6NLN=75>)cMFS,H,22B\G
WL^4U@7e9M2Y7D#+^g4=:/Z_c?Z27-7PE6d7OBJ:5_ER-U(c;aK]-aF^]NZ)N1S.
ZNU?5>EJYcMLHS-X@d[WGI,OIL=;-+\c(PA],4K2;^(GYY7KE8W5FK-2L:186D8.
L06^[;)8+c86N(_FJ\<EZUB--I,Qa:9T2&N=Q2D@@=G(I:&dDPf1aLYc=L9:EQ;Z
1[VXBN_-D:A(C-a&,M[ePQ3E,Z;P;gc>.PWVT+UeWW8C=NV2?66QXd1P0H0)N]6;
#:b-cGC#NI4G84;RY-#-Xf>9>-c\<\^PV((DD9Xe.&@@@_QR8-2#H+NN0>BNM1&[
>R)CRGUN4GR:V<L1b>J7bKZ2Ibef2>[ZIbM9IcPE/X2QMaQ)1DQKZ<O74)?YPIN5
<RT19)H8_);\aS,IGLB&e<&Zf3S3Sb3X?NVa=+beb(O,VXY]:UfU=^6PP-I><B#>
^+?CW^:Kd&b+H_D=TcLg>;00X>)B0]f[fB4/54,\cc<N,.V,=^E.(HH8#V#3/FY#
KNLCacc-F=9+ITV9F;,6#V.N0]H,&1^657AUJWUe_Ded2S]C_+cb)[d-(QM8<G_?
=g?0IHKE,T4Z_4I[=J3:D1&YEL<X&DgYXT@+D2f#>XCX\Y)O>MSRBeK)]E[dLN_c
);VB<5:SS20FGDgS/K.7Q?O(K?03V7(H,EFA\H57OKLG5^;Tbb14:=AHYPXRF;+1
&BJX2Q47_cf76@]K?&(R1gDUAba8)<(^BEC,ScKZ2:WAYJf1S77R2ZX6_E7bNU44
1Y(BE+9RH\WRXGA)4ALF;1YJ,9#f#E/+85e+C,E9]N?9H#.ISHF=e3;P;D0R7FeW
7WUHKJMe=YL@g&C0S_55(\NSRaOa<JRVC0QN^5bU;F+,EcO6TN217PEge\GbABWL
L0V0RB2F^]Sb--0Yg^)e^d1TcPCMCOS6IX)M[>JR\2(>gBF?X>E+^4Gb.)3d<,60
^/V<Tag,:=Q9G2<6=GJTS\/.YN<<bP10bB6aG?^-_,]cdIS@=K9Q)(KVA5CYe+7S
X^BVObRM&W#YZ,7TedY4;LfRU\P,fRQ<S5cN851EO@I1]@[:KDbR&]K+_74[87J#
&dOZ)&acPJ[Z@[e&][;4;aLa34U)e>YGCXH>K-9]QC^K3eC]5T^S)UBRXH+DW&@J
3;Y4I:^FIU:LbP22f5:^g1W(dPFf;+:6@BEIX)\<fL(.+a<0M?82N]N8UHYPac0)
5,&I6B5MHI3#\0&J@>R52WI:-XgA2U>TdB=4G9N7VaBH;eVNg^/57,+^O)?G\?R1
\9_Eg986a-12^8EYA)Zc\6VA/=-Yca=QKOWeG9b(YP::P.b-LWPb385)P8f2OJBN
<BCd+&4]NKQP1[Z#>EFG5+ZXNffE_>-#TgH&fW_bHZ1HA]HBGWV.A_Qg\VQ(ZZJP
dRQ:(C\JgcW07Y&A>e;@TX\0e7+1GB<K&cKZRad.PMe.3M_;=@DFK1W,NI<GD/Fa
g3@UfD)gXG@eJYDYOc_9Z#2&-GIG5C4=1Bb0[MR=8VCW>OM1JOP(a8PKS,(E4[0<
[edE11C^1+>TTeLXd?C45YNe<?J=WbY.O/<g/T8/9&\CQ#35fgR_P0NZ\QWN9FRV
:FO7V)5^<RgZ3,?.L(&UXe3B0B/M^MWc;eRg=OVO/>[QB>#QHGKe^I(_AMcW?IL\
24M74_[K2WfG^.,.[V[>O?:K&bI&WTP>>d]5N^gcV1[FTJ380\\5[H[E]N009#PU
F3Q3.8[=WB4(/SN(Sd&aFXc=6FK+.OZUYK=A6gY9GKaTU#Q>:N?.S(Vc^DP6a;g\
GM-#G]LbA:81T0Hf1fP#/^NB-1KO&(_>740Pg<)1QTYFIHS/;4d8KgZKK5R;dU(E
+#BdP1A1Y&.ELAP(193?_Z;@b16CX(CA.0A2_P;AEWGEWKY_5=&TIf:^9H=@^F3.
GA)5.(Y#Bf??-eb0cB_\A,EP+A9?8,&,?M0BBEZ,O59:+c8WZ)X<X?ET;BX\_-77
:QBf;OM5+gC/2O_B_OP&E2VQ.6@(B((&db+LJX(#WK-ACPfU]a0VO(NTUMFb#YMR
1,69EOF(Y1\&=:BRPO;[Cf=fV/B8WX#>09A>&DfLEbfTQ//5R8G>GIFgg:5[@VR+
&X,C+W]6WT^.L<2WCIB9@R8D._NU&DQ\@Cae2P<@I30FJ7ZJ5a6L_D57MaS<-6b;
-4TF;0N3N3WHTFHcZ5_dG^#NeME=0F&,GLUF[&5bC.?XECZFbR\941(#Aa;850?Q
#0WD\&<e&CS<^IOEN(R0UegY)ZW^.8NG[RR1[:AK5Z<Qa>/.TCe#BEg&C-0?[D3]
0Q>A3f<G[JO,/VF8V.6=#B02;#.FddcAM6C#1RDW@V&Z33cJNKF-c@P=<7DX81aL
PBR7X[^g4g4Y_Od-)?SO&?2&O,ETV@]#YCK3PN=)>.K31F_;egF3-)<SH^/(N=@Q
0#00@&AAbYEG08MeRc)](QCa7JaC+//8d,E(-ALJ;+bFK0CQ<XOgb?J1BWd8)I03
HcG2N9ZY<:K\YM,VO.\/D>Ub]<;-DOYR-18b0WWE&NI<g(KHIYX/cV)f/\]CO+0H
)0>3=TGIDT+T&B^1J],H>NAQ=P63]>c;P9\(D3>c4XH.9Z>MP0f:BWO@84cY9_+Q
Kc=Ha[44TK4LgU7,I4e?CC/DA;M]_U:Qa70]N4]&dCQZ\W+aUWI8LYZ7#2MK;d8X
7#BK7M]F&_8LEL#+d79F<63@^/1\a/Q&\]0@1U40=41+G#T,B6@eS+Hc5CJQ:YDJ
BDVH7EgZ9^G&F:GF#Dc:3U-7eb=P?Gc\#UJfZEYHW&[ge8]f:UgU@<<ICb=8PJa^
=LQG=H#<^XG/UD[,B=37LU\^?^[\O?H&6&W8?TE__O=DCC@<1aE?T3SX>bPM0-W?
^6WCJa_F#2,K^@M-&)cD_&MRdAA:X0V)6BHMQO9BV4ZA1[>,8PcZ&Jd<][b)OTE,
X\J[1?.a=\)/N]IaUG>KX;2V+K6SI,e4KaN=SF3dZg.RZ:TF4&9977L<ZOD&T:NC
gUW)6?V0FLS?/;HCMQ>NC),a5cSeB:+K[acc31-X/QB12QS8)-KcXGM\R\@-/:>6
_9F7BJ)8MG>eS\WD0O2Y>aS^[S;8Xf];64b2JPSPJY23Wd5^+>b<]dF0L]CCZ-T@
3OM&@EW,TXe82F8+.&NbB;5I-[EME1KJDJS8LY,+#aM[\&RFNR42f9.CLQ9BC(Bb
BP(24S;UF5?a?M1L5XfWC<4HfKWf^A/Ndg7K\,GWf:0<VQ/+THYF),>P2^gH82>.
G/7CU<U@NT&7A(5GJJ07&OUM,P;61/eW,5P.ZWb/:?O2;L?8J(E3RPcV<1K#W-GV
DH1[@K]?5Nb(eS=N[ZS;O_PQ7[1=bRBgd>2WH_<d_;-a+Z-Y=\J:WP\-WD+^?/_3
a;Td?0_1TaMH1G[V]bFQ\be/SB^0gXO5QD>,NJ=M2XQK]-N09STg^[6F?.9Z-F+K
KKT<F27_9W)G/FRD5EN-:9XXWdRCB;.Ub5Ye9@;\CK=X574YIOb:V)4973_W;>g1
6/(;_I[7T37D^eC&U15DNABPN3b,N5R>K#^[+2P@Za7R](\R\DI5,/?2538NNMcC
^A(]V^UW^>WL(Q5F0@dPI=@,<XIKW1-[>KPe,>>18]&9=_BL&Fc:3/T5-(gOQE&:
<PGBOX6MJ8D7H]g#O2E-H000R,G9756;dB,3#@1-b1WZP.;#DG1b=NOKP.ZACQ5+
W.S\;RE>3&E(CB<2G5N=IQe)9(F.<J9daZFI8-Q2R;2@N.Cb+6e366Jb62A-b-bO
O(dBVM:R&g4,97H#S?R0S6UfBGR40^E;MZU7,OC@YJ.//X.3>d8<_]PNU\].Oa>B
NceB;2Fa??K2a.[LW[MVY2;>?Q;UUcR]X#Xf#WXg1U0d>364)2W[EeDDf:I;BZ64
RW:b_77NZ<P2@&e#960/GI3b.MZ8YU=N[NLE7Bg)-)]3I:g,DZ;,SNfR785].b3[
1<0&_4e?UG27O;I&E&_3T>Da;.7e9ePX5Wd-3CO#e##NaRY7^][L1_\[Jb>[d>8:
BVR<):dFI5579.D/g&4@8#WA\M2XeF^gU9]9a9&dD_S,T->D_?0AT20-f7aM_PfP
WE1@,UB.<4(RB:9,5c6,F_:WMEbSIa-,(>D8=3,R.@J1(,8W]c82AJ3]<g@O@J.Z
DQYW6caDN5-JK_RM[4T61@-P<_e),7^K?2beY.]U7dJHCFSB#=B2U[)MX=:&@_0L
:[TOd4Q0BPd.5M=Ja7MG-:TM:<U1f\>)92Fe(A(B;\>O6RQ/Da/22N^2CUJC6X(K
+.9Xf2d[)I06_#bb_#T>1[(8.X^N7_F8&V^-?N7d.1U@L8QSN>a3#7:d46G1D>gb
N,LJIE^f5gMfQR5#29a^b_Id#M/+g=)f),\)0<[6V:A^A-Qg:JRCZU5b<b.=KF+^
3;2(O0H?QO&QWB?,?J[6D?Z-b;9b)Xe[[+(Je>>1V2_TFfNB/12+2abE?F2N->=D
#HeZeO]8ffNS\+fHW>7Kg97+d,]eU>Q_M&U<JJI[DBLT]dR-^\?VJ?IAZcIfTTbF
3W0Wf6TTW<c,/NEaRH+I0-A;fFB.(1:\c,>(2N2EDWKPPU+J4A=JJ8?fYeb.@]]/
J0#F50HDL;;0#E5,,eK_-1TC/<+gR:e3(@3W.OgbITbRFYNQd:K/)d8b?EfQOTOJ
2<b6L^+6#Q.6B-HY)f/)V^[IAXS&_4\e0UcD@F\L\;+3ID3Q;6:O9OG7Id<9d@T7
.:Yf59U,LLG9K7SGeDb9L8.R24.M&PY0G+WO/4S7N1c@_YZ5L92\/YKXe_;WNM;&
.H>)XF]Z4IW[CaH[c-\?bWZ6=&,2V++YcLD>V,WMgaU2).^_>=YTN;(0gH4eD;FO
[2WE\XTeP=M2TbCg2&]&J(c,fcW,[[77SQC&HQE4/4A\Z(b\V[8(LABMQS<>Z5F+
QM(68-35(H-IL2-H@XVf?#_RXfX-[)e?UWf,9ZWEFf7..C>@^>JDZ9I/D]:<H:8\
;SMK4,L+C0#OS9M)-HLXEb+RLf6GV<WK<g,2),KeLfH2BW9>S\;61(CA,Sg#Lf1@
/e\&=:2<;LJWcP83-.Q&I0VTF:SIWNOU?>]+8g\F)K1be#R=?HV2[J_A^NX6H(&M
CO-eU=Yc>SC.&I/a1M/NCJ>-KS,L<e&A>5)S8GJ7TRS+3<QI+X9J?A1L>R_7O_gd
.dS^gTfaH?XgNLccLU/Fb+?6f_)28FCZF=9V_D3;(8\;MZT=,+M03SCG>UQN;#O[
@eU?:bc9,@HVT]]]9L944.@HVMKb^PN)Y-b<]@a[/R,734J&M^SN42V#AU1@:6.(
-3#.6)UUE&d:6]9?0\VX3/D?_<b2OGTd4+@>D6W(A]650X/(e1++2@M^&.NJ#/fU
]S_-@?ce)^\?2\\/[I];]S4USF+/_.K+Mc&)6MRX&CPRD^#c5S7U.Qf&WJ1+dLV@
5/<:.6,3#RVBL_;70C1GK</_4(&<ceDZ5CXW7=7U].[>9;/2XRZa=;NaQgH\a8:+
UZJAZ3T0AG;(e-eB(&c)_OK.ZaHY_U6IP7-ZZ=eCGe(^WO4Raa^Z>bZIXdZ[D-#+
=MM)d_1>2(cFFVPHB5?#Ya^[]G<@b&b2;gRa/=U<4e#e+^]<fM9ZY9:>]DK?(U;c
QcEgbHQ<54?JaJ\5,M0@&aG4LQ\9L;86Se9&e[,,S(JPXVHQ#==U1+NLF<N82X^4
19UD<2+d(f3UQRNI6)a9J5NffH?RZA(dO6eG8dNeQg2bfY4)O6#UCD8C,Fg+7]3J
8>a2.M:]3]-5S:#S-.A@adf(C#YgFVEMfc+NN]S/cV8E^7SP\&;eLQPIbZ3[LPc@
8M=Z+aPc0QCW0V9WKC1Y[3Pe\6LAX1K9TgJ)#,B/)T?UUHW)]C#b6VJSLe)]T)<b
FEWKgW<K^2G#I\>F.69B0e:g>V]UB7eM/.eF?)6DWX^RG,+;WDfB+_5K<G?#ZSTS
RUJJP[cTe=@2QfE]d-CcV?)2e8IH9E=<A=:DX<;Zg4ONQ\GBEg3][WB0QLG]eUAe
3#F_+Eca.aTA,8VZGE2&&F0_K4K<Yc7f&EKQ]W&+XB\H,aHBaBEV,S6eH\OC:=T\
EMMG31(9Z,72R[gUBd1(I:cIEM9?(C\OM9bPR4IW6VR+a19c<1fdF=T.TD4e5[@C
(4#D9WZL4M<5LPA+H_C2dL9_@=?T61>AQ:#+\Bc<FLOdA>&cTT@/N[_aK_ONC.e,
Bd_;X4(IHF+(P82Kg>McXXK8ED\+Pfe572gOJAVOPNf2dR4?Cc(C1/H7;KGV-A2U
^8--ZQEP;PC@Q<93S?F3:Mc1VY):a/feA[N(#-N92)W_Q-fcc:,,N:A.=DVcS>MF
@4A.<Z?6d-TI[gUO[S6<V_d(R1Y)VUTZEF/S87L>B8_aL[.89P&AI0)>92fJR20^
JBYRe?KL^(KMZKJ22c#O2#K8Ca3c;A_)NUXd5(9.f3b&<987YCb#=.<MOD6(W)=]
g5eFGb]V;M,&.Wd_c39-X/5B6RBYGL[BF^QOH3;M1f\QRJO)<08;F<V.8VAVDU7P
Q)[-[;+XH/fI3Bd^H8G:A(/1c3(4WUa(G=4M/<deSeQC2V8GYLgWZCc<ZS=6TMJ>
H7Y+7\7bH#Z07,Y5YNaX2+^<LB:37cBCHX8TXZfF5O6WA&RO&RDCJeF3/_,d8YHH
S#Ye;SA7Jd/?Z2I7<Y\AB&.c..4:)g7EI7QPQ8f4WZc;e5XGI&K?:4IfS&gP(fE1
).^/Q+=9T1T3DM33^T?5a&R?8dOX?Z^5;>b^S,_Kc^c]4e@^R0M8^@0+RK0BXf8.
;Ya7;a>^O,eL(;@NZ,+4]?C(@[4Pdd/&+&bI16N2N35G^\d?LQ3HZ[10CdRa5\-b
UA^aUE.FegL2:6/]P2BV>].C:\I:cgbFMM]]_d@e68?IUHB,-PM4A&<O;]#&&J3B
fK6=<6E5HBC5F1&;eOgOFd,(8P\9H.a8DN?A#OdKP^T]O_XF5>9e-RC_4\<0ORSV
D.3/4G.(<(Q/4QP2=5a,14<M8HWWB#W7gB5LPeXCB,46</3gg4>:ASd]Ja-4ge(d
4a24[A11NI3^:^IcGK4fAC62K;MDINa3TQa1eJ<D)(@;a7^X2MAOf3T]/@:L#J4R
(/)HAYV53cQ&?/6XQ7dB<c6^8-W4M\5e7<>#6:3F73AXLGC6J9-//7U&2?64+6V)
,#7O?gPf#;J6,SSB^31W5M#FQ:2e3P6N_WB^c2W]OE6CG6BWf6]F(O@4<YE#(C0Q
D\M]Z[_FZNF)H[/I))6Yb3T36.];K^@WR48]GF2=DC^4)3;3#.G9Z@SP8X(&\]gb
\WT\1fVJC,X:#.JQfa8J1_C&B6)F3<0OA==f)_#A;JddLEU[\TQa/MB.@U8_S/>@
6OAD7N8e#4B=(Mg,ALYT>a95#_YPQYDXD<fPU=,P>;D.Wb?KZM3b?^ZFOA;CRI)1
R,dO>bP#-g)=C]SG+88<7>W[Y0Z+56daFG&_W.#^]A6=\NQ<9[SQYRH;+))^Y.-5
=H]+-cHU<cA(KUcC1<EPVA?cB[A9_NKQcdV,^,C6F8<&;f5eIgU[O8?cG9Dd_8bE
(JJ\T)/5WN\6+=QEO0F)HLdgg6]<5TEgV30:_9T4GN.Kb6_@fIVbC?XZ#Pe2(J?7
eA(=ALT:+BR)SW+DM1XSP/aOR?(2)TO@,)XDc-A\U&@EAY@&VT7IA5@#^<T?C&7D
(F>X>=RW,GCOWE_OLa,Q[ecA^):?&GH9bW1eN+UCUGI3Gaf_W]P#VT6I\[5]aNX:
7>/fABCI=85Q^+eK\R,NBcIRfPBEBWg@>S<W#Uec>/\NLQK[BCeDO=,Y4[6#TcA/
XDfGfIeBSILQ6>c/_[E7BG9.cXMW7?E58,a\W:c)V9OF?OP+]]gE+2Md?,ES3.\W
TbJW?BIU0FB3+[bNa:JK-)H92H^R7)J5,,2QS4a<VS&XA1\:-eLJC]LIBA;\b#IE
eT[YMWbCLYEE_FdO>8)Z2X4_0J8S6eZgM1g>U,?L[&CgQa,2I.E\4VWL#/(D#Y>V
f2]7HD<YOg>Gd7J<c]O_/X<J,EGb&5&ZM/J#V8e<6<9>HYZB-cZK;#A&>C961.[e
-AX:W[>0/b#IUW^EDDJ/<1IF_>9C7ePDg[)-Q^eEK23,GN>PP,P@8/2ZMV5?=:6=
X:^e<V2FFNA_828/1a]d=JXDG#I6#N6^N<I>/^SNc6M78GH3ZD?Id,5GL0ZTPgMe
7UH_TH8R5;UFCEJTD+4_[,N,-c835#MJ?&X(OX;F)&:CUR=K#ZU@X0Oa12SE>TVM
_BO+@/[f7H>H>:S6bB?3?SL9CRZZ=?_G0@\3:D-d^MT933(SQVN,,@^]Z\RU//?1
g(A3#bLO_EF&4)267cW0,,2@/L?[A12cU4IGO4>C4-gcPV+G390HfY[Jf^BRJ4e5
1gRK)W_DW[RT..,KG15S99,?@]dFe+LAXEPT^)F=/[(aEZJf/2dYVNZI?LI)NH4C
bg9HRJ5\CD402.S^gc_O7,dD8WWBKGC?FGTAZ==,(HcP[L@@Y<eG.K4N-R\_Z(87
EU0C]/X376)QVd/Be/U9dZ:F6.ZKR1R/+RgEJVV?[J+:>;[3W==UZF6WgK4+ID;,
S.B94Iaf2U6V,4.Ae_>J.^R_+S8NS:TcFfFS?/K?(OaC\W&J44B_gc[T[Gf\McaX
aCXMecb)F6JES(\Z[/X9ARNQ-c\:WUQQ]N&)TV6b-E,&7Z1bZ;V)>4P.@/6A-=>S
\aGK[5P(Y+([R\T^9a(:P.f8B\ROF?PAS-P+PTVO8V9-C]^\ZV:H&0PF[0U(V6PF
Y#H>101T,PQaLd?O3Ie^J\eY#dI;;TBJESI>@C.M&QP=.c51=WF.0Yb,Y0_WKC1/
4@5\9.e,1COJ>K>XFQGF+7,e\JD4N+(PBT#DJ7IH#PTXFEQ.[SI;Md?dbIFHV&Pf
($
`endprotected


`endif // GUARD_SVT_SPI_MEM_DATA_PARTITION_SV

