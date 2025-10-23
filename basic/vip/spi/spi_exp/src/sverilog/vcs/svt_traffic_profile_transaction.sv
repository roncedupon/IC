//=======================================================================
// COPYRIGHT (C) 2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_TRAFFIC_PROFILE_TRANSACTION_SV
`define GUARD_SVT_TRAFFIC_PROFILE_TRANSACTION_SV
`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(R-2020.12,svt_defines)

/**
  * Generic class that models a traffic profile. Only parameters which are
  * generic across all protocols are encapsulated here. Protocol specific
  * parameters must be specified in an extended class. 
  */
class svt_traffic_profile_transaction extends `SVT_TRANSACTION_TYPE;

  typedef enum bit[1:0] {
    FIXED = `SVT_TRAFFIC_PROFILE_FIXED,
    RANDOM = `SVT_TRAFFIC_PROFILE_RANDOM,
    CYCLE = `SVT_TRAFFIC_PROFILE_CYCLE,
    UNIQUE = `SVT_TRAFFIC_PROFILE_UNIQUE
  } attr_val_type_enum; 

  typedef enum bit[1:0] {
    SEQUENTIAL = `SVT_TRAFFIC_PROFILE_SEQUENTIAL,
    TWODIM = `SVT_TRAFFIC_PROFILE_TWODIM,
    RANDOM_ADDR = `SVT_TRAFFIC_PROFILE_RANDOM_ADDR 
  } addr_val_type_enum;

  typedef enum bit[1:0] {
    END_OF_PROFILE = `SVT_TRAFFIC_PROFILE_END_OF_PROFILE,
    FRAME_TIME = `SVT_TRAFFIC_PROFILE_END_OF_FRAME_TIME,    
    FRAME_SIZE = `SVT_TRAFFIC_PROFILE_END_OF_FRAME_SIZE   
  } output_event_type_enum;

  typedef enum int {
    XACT_SIZE_8BIT = 8,
    XACT_SIZE_16BIT = 16,
    XACT_SIZE_32BIT = 32,
    XACT_SIZE_64BIT = 64,
    XACT_SIZE_128BIT = 128,
    XACT_SIZE_256BIT = 256,
    XACT_SIZE_512BIT = 512,
    XACT_SIZE_1024BIT = 1024
  } xact_size_enum;

  /** Configuration for rate control in WRITE FIFO. */ 
  svt_fifo_rate_control_configuration write_fifo_cfg;

  /** Configuration for rate control in READ FIFO. */
  svt_fifo_rate_control_configuration read_fifo_cfg;

  /** Utility class for performing FIFO based rate control for WRITE transactions */
  svt_fifo_rate_control write_fifo_rate_control;

  /** Utility class for performing FIFO based rate control for READ transactions */
  svt_fifo_rate_control read_fifo_rate_control;

  /**
    * The sequence number of the group in the traffic profile corresponding to this configuration
    */
  int group_seq_number;

  /**
    * The name of the group in the traffic profile corresponding to this configuration
    */
  string group_name;

  /**
   * Full Name of the sequencer instance on which this profile is to run
   * This name must match the full hierarchical name of the sequencer
   */
  string seqr_full_name;

  /**
   * Name of the sequencer on which this profile is to run
   * This can be a proxy name and need not match the actual name of the sequencer
   */
  string seqr_name;

  /**
   * Name of the profile 
   */
  string profile_name;

 /** Number of Transactions in a sequence. */
  rand int unsigned total_num_bytes = `SVT_TRAFFIC_MAX_TOTAL_NUM_BYTES;

  /** The total number of bytes transferred in each transaction 
   * Applicable only for non-cache line size transactions. For
   * cache-line size transactions, it is defined by the protocol 
   * and corresponding VIP constraints 
   */
  rand xact_size_enum xact_size = XACT_SIZE_64BIT;

  /** Indicates the type of address generation 
   * If set to sequential, a sequential range of address value starting from
   * base_addr will be used.  
   * If set to twomin, a two dimensional address
   * pattern is used. Check description of properties below for details.  
   * If set to random, random values between base_addr and
   * base_addr+addr_xrange-1 is used. Values will be chosen such that all
   * the valid paths to slaves from this master are covered.
   */
  rand addr_val_type_enum addr_gen_type = SEQUENTIAL;
  
  /** The base address to be used for address generation */
  rand bit[63:0] base_addr = 0;

  /** Address range to be used for various address patterns. If addr is
   * sequential, sequential addressing is used from base_addr until it
   * reaches base_addr + addr_xrange - 1, upon which the next transaction
   * will use base_addr as the address. If addr is twodim, after a
   * transaction uses address specified by (base_addr + addr_xrange - 1),
   * the next transaction uses address specified by (base_addr +
   * addr_twodim_stride). This pattern continues until addr_twodim_yrange is
   * reached. If addr is random, base_addr + addr_xrange  1 indicates the
   * maximum address that can be generated 
   */
  rand bit[63:0] addr_xrange = (1 << 64) - 1;

  /** Valid if addr is twodim. This determines the offset of each new row */
  rand bit[63:0] addr_twodim_stride;

  /** Valid if addr is twodim. After a transaction uses address specified by
   * (base_addr + addr_twodim_yrange  - addr_twodim_stride +
   * addr_twodim_xrange  1), the next transaction uses address specified by
   * base_addr. 
   */
  rand bit[63:0] addr_twodim_yrange;


  /** Indicates whether fixed, cycle or random data is to be used for
   * transactions. If set to fixed, a fixed data value as indicated in
   * data_min is used.  If set to cycle, a range of data values is cycled
   * through from data_min to data_max. If set to random, a random
   * data value is used between data_min and data_max.
   */
  rand attr_val_type_enum data_gen_type = RANDOM;

  /**
   * The lower bound of data value to be used.
   * Valid if data is set to cycle
   */
  rand bit[1023:0] data_min;

  /**
   * The upper bound of data value to be used.
   * Valid if data is set to cycle
   */
  rand bit[1023:0] data_max;

  /** 
   * Name of input events based on which this traffic profile will 
   * will start. The traffic profile will start if any of the input events are triggered.
   * The names given in this variable should be associated with the output event of some
   * other profile, so that this traffic profile
   * will start based on when the output event is triggered. 
   */
  string input_events[];

  /** 
   * Name of output events triggered from this traffic profile at pre-defined
   * points which are specified in output_event_type. The names given in this
   * variable should be associated with the input event of some other profile,
   * which will will start based on when the output event is triggered. 
   */
  string output_events[];

  /**
   * Indicates the pre-defined points at which the output events given in output_event
   * must be triggered
   * If set to END_OF_PROFILE, the output event is triggered when the last transaction from the profile is complete
   * If set to END_OF_FRAME_TIME, the output event is triggered every frame_time number of cycles
   * If set to END_OF_FRAME_SIZE, the output event is triggered after every frame_size number of bytes are transmitted
   */
  output_event_type_enum output_event_type[];

`ifndef SVT_VMM_TECHNOLOGY
  /** Event pool for input events */
  svt_event_pool input_event_pool;

  /** Event pool for output events */
  svt_event_pool output_event_pool;
`endif

  /**
   * Applicable if any of the output_event_type is END_OF_FRAME_TIME.
   * Indicates the number of cycles after which the corresponding output_event
   * must be triggered. The event is triggered after every frame_time number
   * of cycles
   */
  rand int frame_time = `SVT_TRAFFIC_MAX_FRAME_TIME;

  /**
   * Applicable if any of the output_event_type is END_OF_FRAME_SIZE.
   * Indicates the number of bytes after which the corresponding output_event
   * must be triggered. The event is triggered after every frame_size number
   * of bytes are transmitted. 
   */
  rand int frame_size = `SVT_TRAFFIC_MAX_FRAME_SIZE;

  constraint valid_ranges {
    frame_time > 0;
    frame_time < `SVT_TRAFFIC_MAX_FRAME_TIME;
    frame_size >= xact_size; // Transaction size for one transaction
    frame_size <= `SVT_TRAFFIC_MAX_FRAME_SIZE;
    total_num_bytes > 0;
    total_num_bytes <= `SVT_TRAFFIC_MAX_TOTAL_NUM_BYTES;
  }

  constraint reasonable_data_val {
    data_max >= data_min;
  }


  
`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_traffic_profile_transaction)
`endif
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new traffic profile instance, passing the appropriate argument
   * values to the <b>vmm_data</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   *
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(vmm_log log = null, string suite_name="");
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new traffic profile instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   *
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(string name = "svt_traffic_profile_transaction", string suite_name="");
`endif // !`ifdef SVT_VMM_TECHNOLOGY

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_traffic_profile_transaction)
  `svt_field_object(write_fifo_cfg, `SVT_ALL_ON|`SVT_REFERENCE|`SVT_UVM_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)  
  `svt_field_object(read_fifo_cfg, `SVT_ALL_ON|`SVT_REFERENCE|`SVT_UVM_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)  
  `svt_field_object(write_fifo_rate_control, `SVT_ALL_ON|`SVT_REFERENCE|`SVT_UVM_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)  
  `svt_field_object(read_fifo_rate_control, `SVT_ALL_ON|`SVT_REFERENCE|`SVT_UVM_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)  
  `svt_data_member_end(svt_traffic_profile_transaction)


  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name ();
  //----------------------------------------------------------------------------

`ifndef SVT_VMM_TECHNOLOGY
  /**
   * Extend the copy method to take care of the transaction fields and cleanup the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);

  //----------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`else
  /**
   * Extend the copy method to copy the transaction class fields.
   * 
   * @param to Destination class for the copy operation
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);

  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind. Differences are
   * placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare (vmm_data to, output string diff, input int kind = -1);

  //----------------------------------------------------------------------------
  /**                         
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size (int kind = -1);

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
  extern virtual function int unsigned do_byte_pack (ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

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
  extern virtual function int unsigned do_byte_unpack (const ref logic [7:0]
  bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);

`endif
  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val (string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);
  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val (string prop_name, bit [1023:0] prop_val, int array_ix);
  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern ();

  // ---------------------------------------------------------------------------
   /**
   * allocate_xml_pattern() method collects all the fields which are primitive data fields of the transaction and
   * filters the fields to get only the fields to be displayed in the PA. 
   *
   * @return An svt_pattern instance containing entries for required fields to be dispalyed in PA
   */
   extern virtual function svt_pattern allocate_xml_pattern();
 // ----------------------------------------------------------------------------
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

 // ----------------------------------------------------------------------------
   /**
   * Checks to see that the data field values are valid, focusing mainly on
   * checking/enforcing valid_ranges constraint. Only supported kind values are -1 and
   * `SVT_DATA_TYPE::COMPLETE. Both values result in the same check of the fields.
   */
  extern function bit do_is_valid(bit silent = 1, int kind = RELEVANT);
 // ----------------------------------------------------------------------------

  /**
   * This method returns PA object which contains the PA header information for XML or FSDB.
   *
   * @param uid Optional string indicating the unique identification value for object. If not 
   * provided uses the 'get_uid()' method  to retrieve the value. 
   * @param typ Optional string indicating the 'type' of the object. If not provided
   * uses the type name for the class.
   * @param parent_uid Optional string indicating the UID of the object's parent. If not provided
   * the method assumes there is no parent.
   * @param channel Optional string indicating an object channel. If not provided
   * the method assumes there is no channel.
   *
   * @return The requested object block description.
   */
   //extern virtual function svt_pa_object_data get_pa_obj_data(string uid = "", string typ = "", string parent_uid = "", string channel = "" );

//-----------------------------------------------------------------------------------
/**
  * This method is used to set object_type for bus_activity when
  * bus_activity is getting started on the bus .
  * This method is used by pa writer class in generating XML/FSDB 
  */
   // TBD: Add when PA is supported
  //extern function void  set_pa_data(string typ = "" ,string channel  ="");
 
//-----------------------------------------------------------------------------------
  /**
  * This method is used to  delate  object_type for bus_activity when bus _activity 
  * ends on the bus .
  * This methid is used by pa writer class  in generating XML/FSDB 
  */
   // TBD: Add when PA is supported
  //extern function void clear_pa_data();
  
//------------------------------------------------------------------------------------
  /** This method is used in setting the unique identification id for the
  * objects of bus activity
  * This method returns  a  string which holds uid of bus activity object
  * This is used by pa writer class in generating XML/FSDB
  */
   // TBD: Add when PA is supported
  //extern virtual function string get_uid();

endclass

`protected
YW[M6XZFVZF501IE^O4]f=bQEBV9H^;:b&]NR:A_^UUfOJ+#&-CA0)9MWU#X=J5S
D@;7dfG3(/EXQG#0T<A::5.QO9F&]]=\[L?^T]VPZW(4TVZbFBLHC#O)>MdN53@6
=XBdbgQIHH[UC,3-VUL4VMN7Bb3A2O>-5,LA8V0Wd<2SK@gG]4QF(3Nf3E4Z#,^+
@[_Q-fW3F#_OP-Y+=ced93JKX3+VdMN&A0M],[Ug)cb_g#</?P23d@5NJ9WZVUBZ
b\a2C/3UM(32Ob?[7d_24SF>O,f6-DLH[14=K4N=F4:Kd)7082SaA=?E-_#Qbf<(
::Xb+&--3#E4GF8(dEdD7Xd.]Q=19,CAK0WE/CAd:S-d#)Y?D)L4TD8TMd<cX/AD
;447]aa6/;a@f+?9gIZ(30;@EU#OO6B[UK<33;SEfJ9/8Xb@^fZ@R)20-Z0]gW3B
^FC8RYS:UdG=^9DF[/=(^9IVI^C-/2FgIUSUF)M#f87E>3Y?XeO.@C?L;\P(OR9S
^0Of>:PIHIObf-?B9eCWPT48d(Og;@VD]@H&Fb&/@/?+XLO/K]II:+b:c//Fc+g9
B2eg>^_)G-b)LO]OaAOe_8D6J4Y&C\b=K-+cfEJ8KeM#dO?ES\2W8\;E0]e7UQ4Y
[FIL1,L^c?=c9V3Mea8WX=HUL+H6-g,)&\2[/_1b3Q:2\T#T=V6/ITMKSRV]?.K2
H@1EXIBB#Ea]CKL6[56DN@/f?10BGAHBARPQ/:[0+LJ@H>f80+P-=RLPH#@c--#+
a5)22\+[OA>RHI(9=M;>a6O0=4Za;O1#FL5D4JL@L27XU<gf^&8K+eHB#5dTY>-1
8Rg7)Hf^)YCJ<,@F6L\0)>V&^ebORc]ZD.0.Y>@NPd^(-;#a(WKE(8@/H?Y<3C\f
L#K3A4+G/C^C#Z]WQ9#P).MM2MSPB.aX:Z]-\+IcH1?BM6bYGeKP+dgZ#bQ_2=Q]
N<cd2Xb.X)ON093>RT56:21SM<_S<#T#Qeb;]I(fV^90_7e3Qe1_A5CMe3#24..:
R2@7g/YTM?:][\V]=#>(Ag;HX,L7J_[3K#gc)_.6#LcW),EM_9-GOcA0WVVN[VCW
AW;=#HTTYfT1^2^EU3QTB\(B][ES(6G=bRKf[_(Lc;]]4@S/V(UMU2\79)fS9X9/
F>P)+SEQQUAgF8ZTD/ZX<FBSW0ZPB^e.f<FN_WB9\PMaa[d^J[]Eb/CCRR01NE\;
.T?RKff=bX].WYHTd(HPd8[F2)=95GMMIZJ>FGc8;V]7A1B1VZAH=^TY_3/3T]_D
A</\ebV5/S(I-6FebL5a/gdRJAOLc(?V4-aaf2Xb+K)._/NL_d(G6.YTZ\O5aJ)3
K\?FJAB9EA/>Kb+A@-RcHTBTUf/dEFF3,b.>4DQLc=0R13XJ<+[+;G>Z]<(#<@^E
V]8T5@eBJQbRa@R&_B9T<Y>2,HaP>)&997JVTY)M)^AP_5M8#\V-(#IRQA>e)3BQ
4PA5V8Z-#-402g>1c,/5B4T#NN7:fc(?::]N1P91KKH9_dVfb=.^=P4?;cS4M8\_
gb>J<201^0<gH@7,3-T0V.(1XK=6C0[:IZHaQT0JQ6)9V1KN^Sga,ZOUW/Ug&I:4
B,8HNFY5f2C6M:_6c?.O>-g,Z(?[eW,<#MAZ5&JP\@D81^Q0Ma+^(&VOFV<(.:?O
DPA\W+Bf02cNa:.Z]eLY/YSZ.@C22\I^AMbNEF.1e0PP&M/S,,>^Gb0E\d^A[<0N
X2+JZcX25&838_(KG;Y2>K2;K+0WKg-.84V>gA5&@McI=[9gF1H8C>WDNeg729d(
7#9cDF=5HeG2>a,?.CT:U/F+LCE0.B(Q]c4P^].fS=[1f8bXUFZ&:6d5cTX<=S0&
/Y]U3B0CUe3f8XIRHb^SFS,96^#LPZgA5G/V,JF3)X6UE+JU&E\\3Q&1eCaXc1E.
c^[-4R8..U63NKHU<eF_(+WUTg.B7/JW7/2UV^([+&3aW/7IX2DW]&S5IcQ_0EN>
J1[gABGDQ@HU9HabN1UR2.4G+358??g::@(VCI5[b=.Q;<61Q6VgJ0XM_=49YL>+
aC:=VNda,cWa=<]Y0@S#aD,fHO,LP7_.>UG</:2^VJI#=eW9f+fWcYE,S=&6\X6:
6B9K]a.&+DNRET.ZQ./Yd-NPH3S:UA)HA1=IA-;[8c;47)De@_)eAR2P&T4F4>8W
F9\A,62^7A964FN2W1BHB-Qg^dNFbecZUAGA[Q7b3F-0R+K4Y_fAc@S&Xe&,-TLV
K,(4LL2-d:<9a[X[H<J_[=]_@eVJ^>aA0<^9#ZU6=2S8cc9A_0VfKM_JS6G/>V2,
WI;7aCC/B_/HG15cG3TXY/V-:J-6;G</(FET@=dCL/[)f31_a#9Q<.S+Ug@:[\KF
Z0>?SU3G.8R#IaR9]aDVXC[S2O/T>8GSNEKCd7TE4ZbAS=Y<?8PNNV9L:N[4A+/C
P.<,(WTJB7eP378J]U-Eb6]P4agW,4eU^#Kf0&-R_4g9/R-^(1G1e,\[@U]7>A@2
;J+([D#<CA1Z8[X.684QRWT/,?[3ROTe\>1A18O,6#J2^+W-JF847<VSR9E]dL6W
-FH=>:cWKBKX/@)&/a7M]1F#[.AA#LUX0M.W^3eMWQ.#)VZ[(+Z^(9aIIJ0_SAFO
KAKL?)I4LbP-MOSW2B,QgX1;[ZSaSV_Z<OX2LU3T#Q5Jg\18OAE6\(RM/5BVA8,-
TK,ZA2@44gIc5H/C0@;E:(L/L+9TJK>4KR4c3SI82:Y4<O4&50LSJMI-XcYb]O6Z
2>(I49PCb5BD,3=<=X&#Td0>37Gcc](I1Q8W@,486@dg0BXU-_e7.S]1VE?JL1H3
0O,?#FIQc^L>\fI,B4HBP]cgQA6B(LCD1dJT\A0b[g7eIfT22M4Vc\=f8d)AgTSW
D]Q@2cYf-T4#6<)2,#_MA7XH9GW^NZW(9d]E>?,#(UCN#gY)#F6QZNWL_/O9R&fg
ZcX:@TH5P@XKO0XL-b[c@?\>U2-XVU#H]M-eN9[N95+d5Ob<S0:TULADdH]0Q,c3
b^,G5EV9I_V[c/RF7PD50+S86=M6:Gd>@fHF^_MB73,F,8XTOg,MS9/+XD=7K&:(
&b&P^a0L]04K=^D^@0_Y.TbQg^[36?]L8<[cT+73/28N[O/1\_d09d5Cf0O\KM(,
4+IVMW[?Z1NU<a_3a0NDM4F>PaF(a+6Cc(/CS0A_[,W<7YFCFNX24/Z4AU3F>M76
.1O5N#79(5Q,2]\U9.C/F9[#H:]],7KRBR=1X:NS?3JKYT[L5#L<]Q8GSHM0D^;H
PSG^?LL_&N@X>#c[cfYE>S\a=Ba:.?B)/JYY_\#;PgV-Ffa\Q@UO\H&2LKaWQ38M
N48X-U3S@U;].2#FB@)]<<X6CIV>,XOUZYc4&3KQbd3ZG]6XXF#@PV_JeK++a6/M
_]H,;DJ>=VSB.L;^Zb9HS?[T0fcf,EADbP]2+K>4MDSOP2-:f,O,]Za1DG8XWM69
b6-\]/TcKA:ag;[COVPeKBVQ9Dd2R\DHW7.LD8LZe\KA[BHeVIGBF24YEG;-@bR&
a3:.9=F;4cJ+Nffc3G)D8,bHH1LSV6A;+D5ZYR8QX&,(SS4V1/4(V;,cGW:8#QYL
?6CbUb;f\E5eO2KNGT[WV7R^]7U\HXgff(df(FE>D4S7J24@?Ic/9fS\>Kb(I(2@
Ff5W8X7Z=S/QS+7]8d;3[)-^c4S?\4]@0AX=U\?C&/(@O-UdO7@)E04>Ne(/WZVM
cP_RBe3>7d>&=(=NCP^TUfM#_[_OE&:;)M##D1_.=17.6S^&M;c/&Z3+C/\d/6B+
^VM:FW04^AOfP.7K@6P0?CG#\PPYeHL;/_3f_K4g\LIONDgW5+GgZI.WT>1ZM#)G
fF<T<9)gbXE)5>VKNII5#6+F&Xd<0WT(77AeJ+BOO:\fPI2.U(Q@25[aI_-:dgJN
B:adJ-Q?MR9TD03&=TbVL_O4(EDf]+F+3SH,T3JBWX(-b]9b:&_;\96bb=TU4+?7
MH<79XUI/U.Z35^]4+X[-2Sa3]AG++9YXR4Q0&]73H766>K)\HMGS4SX1(NQ+:XE
+bgDFL<\KEC2JT63Ea\:VH.d4YcA8b(-W#EQ5Pc9OB6#dELQ<^,QJB+TQZ3+0=;,
<PLcADY:PCL7C-1VQaQU_<e.IE#0]QQ:-RFQbR;[JA0/c9.?RGPeP6#0S?GMYLU^
63E_<(MN.&6N8dY]E_,Q?B>.3P;O/V,&<FHeFMD@=2/LA3J+#+&f<-[+G/]KG154
;GLaUSRTYO1dCgIT^;@-N,^)Mf;_-3NF;N7g\GVKX90a+MM/R+(\EUMC#Ib1;O-@
/OHcdEALa/QH\+#SL_-T>7RaJH/2V.cF@>>-Mb<TB98Hf_a._EcTA_+?KRQEc/Wg
cMG0C^9>fbJ^RWF_)8,HF@)7U512:#=M<+a_/\=&]JO1(RNPc:R7e^#c0IQA_MYV
QPc=)c3]@L1#:Y@,&a<YGR#ab#e-ISWL7Q0&=<9L7aK=&S)gZVNY[cV]c_B^S=S4
:@Y\H6@RRQLIgV6A7\bfg&4[W@)^@bS]79-E29E0ZQ^3-ASW/JI@K@#faKMP+H;G
X7b.JT:,PA@19Y>>DRQ->EHK7Jb@,_21&b#?MQ9\PY)G&3<=5]&L^7R\T7C=FL=>
d.GY+[Bg7QH3ADW\&UZ/dd#.V9J#:_9>#L3;aFWfg:=36)HQ>GA1ce?;,UIEd1W3
e&+.OZK&@:<29PM]Y5B&_VYgZM&K1[+F8F_D1]&&N)L:[7f]eI1+?=,;#2Z4D)cR
VQOd8XK&NfU3,G0K:=M:8[4X,5I]#C>@(HNEOQb5K4Zc>2MX9e)E]&=.=EH4TT#;
eX>1,@/e^5<.<MB7JVT+DTCF3BH5Y@/]\_6F:a;EAXG[QS/7/P9;EY30LXM4C53A
FO]KV=I)&6VL3:R0\T@7?b.@W0dO;Q)c3Rd#)Rd:a0.V/@>@\CHXgJ5=I]g1/]F6
WK/+PEF6LN6>5D#=E>dK<7)OVZ)OcV0Y6ZW8[([]UGLa)=3/.bATWSbL]JXV>b30
.fbB_)A?1@Z3,J4OAHE>G1B:DD:[.N0e228:dZ4gd0M^,FbGNeQTI]?GWIf(>.cV
faX#S3b_d2KBD-gFG@G.Lb#^&]M?>16/RQK<I)a7@BFV9HC-HGJfOfCacXGD#a8V
/#M2&7(@_3S;[&1SdZ+eD[S_?c7,Q:1@&.]O2e2>/N[BOIZLSPW?[O/\[UXF2,-e
:CRdXAFW7\E)<g,-6d<6;-W#?V2P(Z6K(d?;O8,3XB1F,LQCDY,]@T<(gV>X?PA2
HBI;^3M@86cRT[\[<DW#Oa9>Z:E?,:;;VQDAb&OJ_.)=;VIDe3P)L3/KAUYS0dON
UfgVc(a:))A3V.Z[0UPOdbUH-a4=/,PG,K2N?A,Gc)e.2C7I?3dNYO,=C^LPUK@[
RT(IP&G5?R6&#BN^@PGL4&BAX_[23bg0^PZfSb17CdV(Qg)ULfSBcBa4/\T1PIZY
QBI3B@:#a=<\fAZ/VQ.d-9(-^2LDaR?_@N5_29)M:S;TSY[.F7QZ^^\^L#ZaO,U[
6AABQUTH)Y<Af3D1A92FPZQ=PN0)eA]cL62ILccfcH0Jbg;Ae9=efFe,>,?aF=[J
4IBdI]]DBVUFTW^2gBPdY;?LHEDbCCX)^Dg(J13/:5VfTS[Jg)14Z+C1-Hc?)&SR
R_aN9+YLdNW<J/fd0T)WAOg=KT0K48<8.[]afT(MNJ>U1X)P3M?YPa:HMcB#Q=dX
f7a7KS-ZYeV4fN2)VH63eRWca#gGHLeK.I?/(824@6&]1<^-UbK&BBT;9100(N+P
P_3RZ-+\X1BS)5U)MFCUN(B3[?S3/Y/>8_)aS]C-0?f#58[0<@2W0-C1Jb7_EbOD
^>2XILAVO4Y308\cafD[&1GS-cV>N67--,7KEaC&D.8_S^b[IHRL&.J)F_/>dSI^
QJdPKU>eP&RU,C<gLUL=C5#?3SLe^QO4T1,7J8([cHB6bN6[2-R.<O0gF:/74bg3
cJT&4?@EdNOET-<:X6=HAIW6^PAa.aAJ;9/gP#&QI2DHL.P1.CK/HJgX10^SD/C\
RfQVJeKHc#:#,c#25S@3a3P8O(Xb3S1:A,0:.^DM>Kd<T\7R_IP>6_+/JYa1f-JL
KgBZ3_G-,TGOV0T-c2]YL4I0R9R_C8);-XdR,BC4Y3b-:5M?,EB6eNG]=3UF@]UH
3)@3RQR(D\4Z]9_2@V)N0UFc2=54_H9Q/a8+TO+De(NZa,aY+8))K,<Y#_C2)=g.
AVc7AN^&]fJa;<dWK#<1UA>WC=D^a,N>+0.^[Y/I?-NP[PMb7f<@M53)bf27T2A&
Ca=JWUOY(TIJ<:^=#6IWMT&cP6)DYKK-d.[_69K7G&6]F4[4bIe<](P^>cUZJS,A
+Y=^E_8Y4:?,JEbLdUODd8.QfYT.XL1&3-d70_MV&eHNBUT=FH&-F(-_[.E-.45>
U/L@10LO08\Wf4W(3dHX4-V2S7GFLfSY@Y[G)g(cAX-OQ<\E3><TdaS<18VO>8#4
8/6#(Sb;^g_]-?Y5I_/4_L=&eX^(Xb6P[D&=,.C4SUI08N0P8]]SQQ9DANWCG^7=
A;@EWCV-a&Z]F&BffT-.<T:Q&ec+c0=FYfWL7>dTSZ/gHY2a?:AZI@/3,AI8c;]U
C4X-.>T3K^A3FEg[LK?QF\[b2V]\6T\DO]G.I.JCa_V14&/b_P7-H<=0]&4[-G[I
IWF/cIL;3K42I2X?<<B.dI/F9<U,T?2;Mf1)W_[N+?S:M&=HLT@TVe_c;J.\?^Z_
2<CF4IagYPfTHR\R)Ya]:=KLA?]W.I+g=#\SWO/;0g#6CHJNFD)+@:Y2J6).3+/V
g2DDQN)69G[S(SKEQVcNA3JaN@Y97)-0gL.BA3a6<RN:6c&DDJA_X4H1IDb>(,E]
<1>X_<4OMJZa,E7bN-WbWBLMTYB-_GU<N;;@(X_)a0.<5:WOZ[7bcM7d)9]UR.dW
?\@UMZ;)_\[CdScg]5IG.\0?YC7LRL_5R\0P6/?1DHB-V;a5;a\7]Y\+-DF.NJ^#
NgW2\<fa-TLWUPVH:8X#9M:cL5FMg^7O+1PfE?gN(O<M]IKR@8V?JIR1><&G_<cF
Ye=(b^=6#c8)J-TP]@)JSJSD]T]>SbK_LgL?#Z7DZ,I0[:d&)_5<HUcL93g[c^0^
d[/@J46QgCAcT<1./A0UUL-CM2cLaAZ\>\ZG-#7RNNRaXVW:BOGfS8^NH]G3,T(<
JMN<d7H=Dg-[PE\BR9b@>P8K1(PC0>OB3bOIIgICXF\PdJ5PWZMUE]fg?:(<b;3+
S/#_b)?4P#;[3eFF>+15BLW#>Q4^Q9ZM)5Q<Y9[^(BH;dR2A:I3#@Q;e(N4LEI3U
ZEK22<-YF)F79[e34YXT4[\cdH;d7G\b5F(^c#O4@X@R^Y2a/W<4^@KV/M2fRYL_
Ne6?af0RdL+OQVH?G)]JH1dL3-FDKa[#_^442Q.:QV<3V\AF8)Nb/4@(W96_f)R6
-T_X4b0U@CN;X>7Ie#8aQ8C>VeDWAZ_T()(HUEg7:c.[]1<,XEDVE#@PC[^^P@)/
g:D5[?X?@;\@23D\-cK<EeHTeg^c#FU[?C&,Y?=&.\Zc_fYGbLS;?TDTSU?^L:;g
7;]=bf\eg=fXS2ZU<cRZ_L2DP/[?Q\G5&6N9,VR+81XV[VC=4FD@JR3c]3::>USJ
W@XA?<:&+BaMJD>d\:E@:/>Q4MA.JZ[:ZRKU2BZfE)SMF)GXN#LN).M3b3__+JB<
/UO1/@TNb/-HU17-c]8<AAdcJX[R,]XS=Eb<)GeMJKbTLT[T/7[^Ubc/eBQV@_N0
F0HN_55=OFSQ+a522\YFWe6BGABPdeOB_D[XZQ5T.a,UO)+L7SIZB^AITW?;T5gM
43[.J>I<G4,c^<FG+I(SeM?>Rg&6(,eQ1SF7P:1WPIa;2NLC;;WXZ\8;^+KYI)0>
;Z13F97/>P@)MWC;JP2H&H1aPR]1BA_^OO.FJTIdQF<eFTb_2/bTV=&O(aS>\.MU
7(T^\\b6=3;[dRg5^TNQM&\R#5M2T>a=<,0dI#XR:afg1Z3.I=A\Z6WHCF&+<4a>
#3[d1,4E;ZdCQc;;RF3>FMB76W9C?\/c_ZUS_10gEOK4YO.?MDA9YW&;N-7Wc0+P
J\S?\eLJDJ-O[:QEO#<M+P67UZb)@?fdefM,3c0Vb>PGaCdE1/&9=ZA7B-R2;^C&
3[ffB0cTGgR)0GJ>\UOdH0<5)1Me@UC#SDIL>5#]G@\ES?<F@Q-)<YgaTgI\?_8]
)@L^V8aB:;&+g-6;X<2)E:/&U<?f?NeYc>dH/D@)[C;]e&G;<1MG0/dd11]E4NOH
V#D>V7I)86MXEHKFQKP<P\YYdg/\/#_ENQDW[f6>+&(SZ[Y#/gN2c?Tad.Q\=IK3
@5;)eJ2[b\/-;ea[e+cP;6\_#J]\/>FB1@f+S&W]Va3&#W).O,a2ZP_&-PUf@4V-
\QP8DT1186E?2K14^7SI)/Q[9/a<)EVb9><QGTW:]5PR4_[V)MPZ=<BW(K:aF=O.
Q??CL^T2\NV,H0FG6ML@#+QHg,P5GDA2BPfG=2:W)dX\AZA&X9_M^)#L8T\&AGL0
c,Q6N&KD)/DUQd?<fg(AEQSJHQH0SB(P;.=YZWGMH^16([#.H2E8<1gFe[U^JdO/
GYQ&2a57ZS1e/I6)7M2PQV+)0O@]c:FgcASGHcTe^_6^+;ZYA/TX8a&B=CI,:,gU
H-;L(E&J71N(cZO)a#>?V#bM,:L>YHC2BNa6^H4.7]\85B1fZdJAe+)J#\WHX\X2
@E03Ta;EZ2EY?WV^0c;Q&QL^R?aLFKDJYO7V:(dc&.&7CfACV-CeOKA(98a4:H/0
+0#5<W_ZKf1R_+15#S9^_]3fM9VH<L7?ZW)I;P5+Oa#3S7JPG.2.)\.;5Q@CFfX,
#OF.OSH-NJ?)Y=1;Y63fK8b:GK;9&HC4OE,HE_\K<OZ1f=0DA01H^-9V_TFZ2>KU
LS9Q>+[SSX[G(7?YBBb8BQC]\5g6&gVJZUccQ;AJ1:]eMQT/81@;YY<VYH7M?2)X
,)b_NRT+?f#XKC[^PUTZE<QPeY#-RgG#g;:&(?FEHO^cdc1#RV<(U<3ONa<?A2?W
9D0)A4[SGLc2IW@QL79-?_[S5g.f&+e,KaKL>B5O88[F_e,PPRYE4CN=Q/+2IQTP
_.bbM3SX4W,P6a6LDGEQ+?CVL.B3OS[0^/-UZ@0JMNNMS.HP06Tg?LZ::_,)DG(T
1[EA_E,XQ9a]b+8Bc=5FVD.9cL0JW-NC,7+O/c5&);)4XVMXPL^DMLF(5Ggf6]W<
HU\^]WUgcE>33]B(4T9Gd]/R&[&]@/9Ee<_\b<b-d:N>ITV(6B&;gYcSVEYc\NbS
/RQUCLeHI:;.#6_J2_e&MUPLAf45SZFF&BCR=<XS_0A@,U9OIJT(32>)^99g,?MC
KY8fS#a#f54Q.cB7,2Nd+<)HR+:HH,U&XeJ)UM<@;Z@dQC:Y+\ZGM#c4#E0c[KG#
ZM(;)G:C;ZL0b@-OYcP2KVf.1\V0YTa)FV#7>4+bJP=WPTKc.&C_gRCb#N83MX;A
W4-34fUWPe(4Y)2N(3WP/bHQ:TeH9;PI7,9WP8XgaLQ[V]6QHCR#)BI++F&9Cg.C
#4dTDGBP4_cS9RIQOR)<X&MU#1)aWH<(XZKEE]6#E-EWDN+dO^ZF6<HDc\V)#UL1
I3a^eAN28C?39]D2daNS:I?:@e&85#(+1VB?1f@5T3K1SB)\>;)&d<V8Q)6\6:Mf
\R?AM[RfKQL./e]2+E93fV,2,T5S?W9bCDde]R95(aT]4+<[CEH&NWS2+:3=FHA6
3:CN?]+0K9:=>F&>9&U0K/09L1C/[8eWgV3[1QQJL?B?JT0,Q6;QGJ#G=LcJ&fXa
.),HZ(H67YOGB,:MWT-T?LTJ;d/eOP0cF>]<.02WdPY&f#IZS/=79QcHgN?XADVG
;O7L#<C\9D[FMeOO7RIX1G;4G3UR+75TOAd5>10I>ZXCOZ^#1O;8X&?IH(FaVP,1
LM&a[IEe^&#.dJF9HNSdQbUNH7XcB<QYbF&dU,NEX:.[_42C=SS3KTS)4[1QJJ1I
JO@_?GSE9c\UFe]J&Qc\EQX/f22-K-SWbO-[B4[Hc<gM,2]:(#UBTQ9R>:3A1+K;
=c@0Y^-gWD6e=dENPda(+0#XNQTYJL/RV/:^MV0K&<YFJ2.Sc;HM)e&?=J>c-[]1
.>JBV&/6f(?G?IV843QUU7e;D448#=M)0M[\Z?H1QJN4BW6]<M2.][]=7,EYbBFY
-(;3)4DA=ZWF_[ea_,f5/=C/(UfYFEU,R:F,B,#c.0+V6]_Lg[VT6d?]\Q:;<RWf
):_Ef:_8(TT:9G6I4D0.?.9fg32I(]J3X^C<>YY9[CKbE2FA<\GW1QX0#QH#6L<[
+(N&IN[PeWUZTEI#e5SG:ZZ9+7[Q7+EUB@CWcXI1G)8PE(5U#=9M<9Z,#GdSdJ6R
@6]&=W)T=&G\?\IB/,Ubd]UBdE8Eb72Y+MfVOV6aEL1U;.MT:JT>(:bCIeY5@H+7
4;XBL>E+7_^<fG@DWa&YKTX(Wf=DI^]B-E-P<V5;5(YGd_(&FX,#&@g,L7W\FOP6
3__MRH8X_OBPg4EGVPH8HP#QTKVPN6;<L@^U?<S30_K4S6@T&f9;;_3=BULPOZ:-
6eLgNBI=Y4G7SJ<a://gF#MP(YXHBR-^A6?d>D&/CSI#+VZJG+BV+#G8XQV8^EX6
Z86A3gMT3TH5:+:OIG.JMad8\+gfb)[0?KG;7a6Y#Y5VL(#Cc9G.We[J9[MW_J<b
bS:LgcZ@30_JF45#W2AIY&SDa7AE1XQ;CeB8bI]A1APAU5Y]gH8J,;&LK6^:U2];
2AA<?NJQHec&/S3,Ca#AVQOTMK/EcLF_ZCS5:&)NOcO;[g;0O)B.7>//0SBAeWQL
BL;J/]FQU+6T.VLD]MV/+/Hd4Qc><>bU)>=Q=;YATF+PI@0f8gd.??P^,1cW,UKd
H4A.^HD?aO-Kd&^-&K,-Q#F@SRB;d,FFW]CY998[(P54^QZ3Y6Z)AA90=>YH)SQ@
@[Q(g.Q=#SIE>NC4JA#d>[SG;D0@XLO;f6[6B9e64:c#T]Cb>3YXeRgX/-)BXYJS
Cb^&?QCXf_9NSQRMV-;CQMUO4:_->Y[7\.^(eC7Yc,K01@5V+C>Oe1TT)(F/V2-Z
gdQ_e/aGgaM=(.LJ+;Z50U_Oe+<d]+OH>-@381(GIT-/A,FMdSFg;]XYeWHN6V\=
MZ:8001[CF?TE?g7FHDab]C,^>EHM1=JU]?(7&FX4Q1X-KOJ,49ZPegKBT#XdG=8
-2LSYF3I9:RGaU(::4^Efa+fJ.dOIH[W20=1/&JH?<Pf&BUNQZXPFa>0A9fT7LcI
005:@4W3b^024?>XbZ_\a:<IeJ_OHSbW[/V^0WQT;1<b,f6A^:MJY2.A[_VOF<B0
PHAYS6H.IL((0+Wb1QC/GOddJLZAWdA/6H-OQK)<KO5L;[]\Y+aRd@6fQ@KK=^ON
Y+3ae[>0=)W-ZD\N]J>bfB_A2T3Te)ZYb)c5M6dU#GV^_A1;&C3]T=JF+#R3ML&B
09><ecdceD/QS@V<=/&I_.b8)YT^+DRGQ-UefNN.2#<fg5GV^4?C:39f?Pd2([7V
TdN\WP=g.02?+@JO\80OFb_-Zf=O4711()PZ7/CE)DM?9XAD&=8Z[?1:#a[cL@SJ
=.-.f#6^_;5+#99fW/]0ed+M3-70P#\5Y\US=\W0U^Ab8BQTaZ&8W6&[ZQM,XJ5_
]+K8&KZbT).OI^6549_g=&7BR0acPRVbd+(IMU_K[@.&RcY@D^:#/-b7c9Mf-K>0
NR+f#dM_T<PUI3+I0ZGCX58R.d(8V<Yd17d:7VUd+4@d#72aLgHe^911@908K(J@
Re_E=RH]91eRJI#ZX=LUZce>^Rf3/]7L_XH#>J0?F:aXaJ&.d08bC]QaD:6?_N:c
#\-O>>U7+GYBV,&R4]UJ+5Qb&[1#/U8FB_/MFMB;?Db0SD?SV[\J#)g#LW\YG+Jd
Z=gSJ)1C(<W;QVO]N459O+PG7]+(>@\BcB:I@@3=&4NS@.Fd]V=DXS0P@)3.Q.L5
8O;.6E@C8?5ER,HWgQ(JgP)L[66LJ2a_OcP@8D6DZVgcQ)T+7LM9=Gf@5gQdXf:V
@LQ,2MbL6_6@&+0GJ1AYa#7]3XZ=C],#B6)aO[6,Z+W=f6;2?N3T;\K)-F8,J=K,
JSH+0?BXC4\U(P01]R(BL]O(#U=HE8DK5,0baDZd#M>-0L7+UeaWG25XT=:#Gb=F
IKUCFTY25V9QL:2>);JBf:W#PZ+5)JdYF[K#_S)1M>[\BK8UaVL>KaG@10#Y=[bd
;?F<&C[+/#cJc5<74Tg?VHM:(7I347cL@Q:P9\ZV85S5C4f05I\5F0[2\0T?2&e1
@^e+__>6(5#^>4@RQ#:7bCQ)Q+2e^BQaY5[I?SDO:)dON74+BJU0CQLC]67NO4I[
\C3UXd/OL__S?MI:&MUTT_,N&bB]+P54aa<L:QAe>WS?-Nbg[G;3^b..47R2Y?LR
+:A7d[Hb8?^#_MS<XY9Tc9N[/(U=G((d^AFdJ69,9^J,9H-dRQ4C/[Oc6T+FAPX?
X;+3a>&9H7.I=AXFB@^Y9KKDB2[EN?(8LT7&d=Jb_N)[3T6YRQ5]d:O^Sa[c&G#2
V5E_Q+eW?a>fUQA2cBaEd)D,dR^52FDWf-&]6;2#X7\[DGV4II5(/0O@)D+g@W>Q
EJ7Z-J9P00^L?E=EUg>G#:MEeY+APed&;,^.BV/:]g(J/.@/I,-#Iba@1:>1WFL:
R/EE>U;B)LbdYcXU#T[)R<I3__g/VSbBR][JKLbU7&1ZBMZL9ca14>=<E:N]FgY5
;5L,I,=R>W08_AIGY/()[/0;0D6bWN4.Wc1g79[dCfZ<cQC.?#K:YPBF;1d>KYY8
M>PI>\^.J,,d?\L_<13,D=bRK9Ub-BH,GLbW1YOTGa[(9HD>eV>7/;0Tb@/>VX+a
=<\3&_a6NWI/U[0TLGSEA5,MW(AE?44XeH<MF)=(>fY=V49:eG1Kegf:/M(97G8R
1X-eCSb2:(c6&/e4/]@aX(OLH.-gUc^S1&[#;\AI;U3#bFD)-HaW0-0dM6aa&PMN
?AgaAF<S/H;-PFdFI4Y(fACMcd[DJ#c;,3TK2QK)dDJFX&9EAb;C#L1eBB9H8,.b
WQEER<.20dX)>MZ\>_fS]4+(cY.]8[FDOC+1]X7+PS^#PZ1U@c+ZY-P.-41?>cSO
>0V:2N35G#J92b&f:17HR5&AE=A>F@+HIK??M_D60W[G=\:V:^,UVOB=MZdREU6F
HW2Z&S9,I02b[J:W-+RYK^WI=7NJ:cZ#HXO;J=g,7eBVc@3LON/)B;-VSbFB^e;I
J2P83;@.[DY=E@Ac9gOP7&T?MD1G#?dN:0/+eXK+3_)6R2<R#9HcW9NH8Q3Q=/^X
EH?O0Q^e//=1H#POJ(VY_?O(<5J8@FAL11+gLY-2C9Z=+[eeD>5;ZMUca3_>9E9J
:cbE]aA,3ES&J/EQ>V2?G><ETB0MXKcaeX,EBc^+5M)3dZHAX>5<2DDMO4JRa2Y4
=[UF6J>)CcZ>2#(,W\\@[V.&X9UM4S0\e8#]L#VRXVLZ@5;N95ESe1X_/H2J#SP?
?Ja8]b5Hae6A3bMaU-Q]>K4KM9SF@#2&M>\f@f,;:5LXV1ed1?UefEZd\e:XZ.;=
+g].GA&IW_D=[I&ZC&M9?C0RFG7RcC)a.]UHU-&Yg.1?@ef66N3)?L6+C^T8H;B=
DO+H>UHN04I;M_g53:14M?:^-UDS<a3dM0@1JEVHIf/]YSW&QX.SM-W\/\\Z,#dP
YX).&ZD1Q5gZ_9Kf+[L^Z[2dT[=\b,<2W/J3#+E&XR_;G;9-e_UES5g8d9D1O#YG
98V=g3LeHO+Q6T,d;gYS?IJ\))WKVE3ZGN0[77#ZIX8S5OZU3Wf#EJZWK<MPSgNb
5A_+0Z:>6>UZ6Ic&CC41KQCVM=6W1@LJ]2KB^WEA?UC0]O7)=feE[CBA9EJ3@;d=
L3gc&2b,R8KCbR77>P\,G?,&)^e?\546/>)EB+8[UO=K:fAZ1L^AcF_4);PLUafO
a>,EdO(6LTY(--C,Vg8cc65-/CQ#b/,#SP:D_:Q[28TcK)_P5DP,bA_VAbHJYHg-
5;RG5:BF^1(E]E\fL@K#\UU(V+/AadLT,:fg.<T5UI7S^A?+PASSC>+;YA>GURge
B@=#Y_IcG.W;VVF,;BCLJ6ZBJc#F0R^c+:cOaUMDF0SUIOZb7RRVa:,<^UB.E91S
;<LfRLBQDI7],7/X.BgQZ1SKA^MR?QKG/-.WcI4V8Ob;B66a<WS8@Lb;&TRF[g,C
5PcX.4\X^UH<SfP6Z0V0\)DS<K)QF<-?g)8\P:VC&4:_Tf0W?2;M84/9NXN]LBJO
#/6WQ1f-M.63eI6YX^P?).\@52RFWX+AT2b(V;P:7BZZBDN.dG;HO+>0A8E1/8+a
,7^.VMF6QO[W/,BQP^UG1c[/I;D#9f6,g6YMJ)C@5A4J>Q/C_XZF<W4\Rd\W9_g,
X2R6=5c3/9a\2M[gJF04>QE9gOA/9N:_A<SEgPN@[(3b)e(8NCT3BXUG_,;0^JQH
(5AW5^5^_Ubc8@>cgdC,&/-:#D5XN4TUQgWIdA4([[79AeSP1H6PERTROc&#GH0Y
0;-UKG3E<CELMJ(3-N6fK1aZg0G:W.:[P:.7+0fO7W[96b\PV49K2I/#7LP5^;R<
2Qf)>)KN_M:T5ad+BP@@+=f=<Q0Mb5ORQ]T)P<1OGIXT]2M,:G/<)<Ha(NQ)XfUS
f-8Y^3D3bLQ,e&A^A+M)?BYV(=H:RIHg+^DAF>d&IZ:<0?S)N\<^2\_Hg>FfE0YY
(@Pg<3N1-FZ7WgDHR+@a(=<L.@A:Q6RAE&I0=FDNR_U?@UWa=;01a1/9ZTN4df>R
E<UNfO@R+9G(G#X3R.=KQ-Kf[):fK0g.Q]#3K3&+,O(W\\bUS3E,?)0K1F\/CZNF
8Z>7d&K]cIB&NFHQ^&??WGXKISc3C7UG#@Q#M1+.&E2S02HHBBU?OCO&[d/7:?KU
^Z0[Y?_P1]-PT,>U>S(\Q:Z9\RfO0\A.A:)7bS5-3fJ[IAe447(F@+UAAbJ_540:
5/#:HD2_,R5IcI-gV#e71W,SQCST7B3F:\\TEDV>-0VY<c#OJ]Be6.dOL?;\&.H0
5[(_PdR/I(D7[_-e-A/I,cUI^GQYG,0]C4-W(a3LC6fT0)QPe?V7PO3Y]VGf-@D4
G.Q5Xe8WL5V1^L;N^bI#aZ.V:O.d#b<g[_8-N(c:MafZ&OFRJFPVX7,b/_Sfb)Va
(F;.AUZR5Y><4c(>C2.cNWF0O/<d7A\a95ND]b3FH(UfH3:)C#3OW]4I-^@-.(3A
RU>N2RU80#E5<9H3()R-OKEHAP>]g?QXFHbH?&b6BTYEYOA7^DD+Y>;&&PF,=&S5
03.B19;PBJ2d2fE7T4-IU2U).PC@gWIYS3B=5MS>WP_\>91g^ARZ)?R&)@IJ/dfS
M=/2IG)B2FB>?LAUFU;6>:M1(/BT1RD0&[]/5Ea:V_]DaU=79>fXIW>KgBX+\I^H
V&\<M:C:?<5>BX+_O0BI#f,QgUJD)UcC_abNVOPc[JE>BUAO]dW^6\#gVUWWf2C<
-QNVf@\=^]dg6.)ZZ.)=&U<gK\5TLQGQgQ]:>QVXfb0Mg^MOTR+=DP;ZE-INY=2J
0?F)+ELO\_X1/1T2NdK_^7d+cJO[dedD,=LQIXR27b4=Y2CH.a[^GRPV?08E)#TG
f;M&RAcZ]Vf7TFK3eeW7?S&?,G.:+&K&AH:>8f)E^Q(U_fggF<=R?1WZR3gbARJ)
J3=,:dDO8gPTA7YMSRC:P7?,;,R9BDDPfSd.\7SF6R4^XQ,X09dL:3-<O+]9(TW6
K]dF:>I;OP\,[(/=Z,J1eX@F-HW=8T2(Z-e32J-L5<TT]g#gB>6cY(DFfaHRNdQQ
>8g_CZ#2gRK#S-)6VJXeI=g9g5E5IN>;<T1E]S4YVIVM2A^#eB2#L)f;Q>AOG7EG
:@]\D5Vb\PO6F/YYE/^L?.Q;QV9YC5&[/INN</,_-KbI/RQMd?ONf)WdOdg97N5T
Z97MQ_9I0:0EFaG7J(:b+US8H:e3_XJ)O[<XG>N;0?cf6N]O@-XH[#[+4^7L<ceZ
PT<JWZ=fQ:Lg:[4A@^E4D35?#70G9B][=P#/2QCBZW;S^7O,A3bJOZ,N=94gDC:Q
T4RNcg7WR[#K.2A>8/1b\Z6]#OJ/+>9W:ea>3ZNRdQ)RCOX)-J9bg(NW<:1F]J9g
ZF<XQ:<_3(eLMa>P6+4^dDO/Z_J7,b2U_eMZD4=DcY#\DS(MQ5^TfXC+25WUV1YX
U@(U.69.V?,fX:5H[@I\e+2K,K-9\faIB+5fLS^:X4cXaA2KB,Q7gb@2g/^bY_H&
#[8deW@#R[+f\-&-H=C_MdLN0acSU4B(F>7QOHM:c17OVL525?\>)&TKB3PA5)[S
(CbQfKOH21(6:>O;(2M4V4f/3#=MN85\]eXS^#HJZH43VBQVe+Z6YFUKgaX<:##=
;R5d?e@J/5GAPD^Xb#Y4<<bQ+D-35T70J05-OQFdKW)a]aeP?+QZd[/9I2Qa0K\1
W@cS/?J30<H4>;=O-X7DM=S7/#LD40<@7I9J&DZLVS9LZ/f.)[9IF@2M-I3R3??>
3SQ#U6K?#H;SX1T?.MD=51(Ra80OI]LZF_=R<:(gV4LM]^L8Y\3U3cGS856IM9B(
:PY@RBS,\\-5GA3)/G6PQP\D1H1dVGMg)+aEN)^+1IaX9:GDRLXUgBXQ97=\=2I)
?N-XdRJBIBE+YUcX5#J.?R&FfU[V)A5QR42B;;B+<L+8M25ILDAA.b_)HQ7DaYWN
)(4=(G,eU3A12SDQ#;Rd=E_CA/H(_]/BGTLf3d)X_/RO,d>206>ZOB1Q_A.I-KQI
<UAPOUdH;7N@NIX.4@13QM35>#cG)ZO0:+AS>1[:J3NfMW&S4<R.cQQ5G]1,/.;L
1A[8(+>98>T>0R:/KWd8/1R_dgO=76PdBFP^R;7PRC\8V7M=-.;&.^\G5+1E@4D9
XfUV.:(fP=GDYM3.UH9CJT9bC[a#fBW;2CGKS&NGMWKWF-7&g38afST\c,&6D\V2
D,AEDXIGKJP=81(@3+bcRT::A)bOW=8N37>;=1HYG>C7M:5;3FBfP^;3?1RGZ7^V
#5e)C:[N8X1,_[<Y8_;>P6[&9_gRd^NI;=R/f]Bd(Df21YG;Q0S2a;EOB;,-1f02
<KWZGe9Q>H5O(g3P]T)3J\MT5OU:356+U3DH\K)[&fV)Y#^M4-99b/V\4cKgFB(K
^,?Yc@,e7T]OZVMC8L;eXX:<MXH+]H\MV?H;C\Z@,2_N0YA?D;g?B:AOM@(FS^aL
0R)V53O82J56AX\d0?]5eT-H-:4D+DaEP.^0MCV559L[d[8@5I9C69\/]KJ7d,D^
bMd3agA>?;C1P:CTa^fLWLKOLUUA@T#I@99J<LMV;)APgT)V/:_K8RSbAH6gH)P(
QZ,2T.CWHH=8fWB23VIRe_@]3c^;S8W72K.:,7g+T6PLOTJJF=AF@)QQ-USQFX55
B3&HY@GI]=db8dP&Z=RWLP^1>Z09JOO&&26>7A7(M^?&)63-eE0TSJ81TWXbDZ>,
E#=C)fPM7-fI4QH)O?_B1EeHaL7(cb>/^->3.BU8,J3&B-_0W68HJ,6&)dD/NV?A
OE_8>4?ZB0bb.L6S9/WYNa43IJC<>P?D8GQJA^c?<&.,6QaVc7+G&?&SDeHN_<J;
0)+7Q&DFI,XV\Q\8R\-;e^VEK\GE&e0L4EU=I6-&/[;(0D[Xc<OKaM^6Na-1c]+1
.F(+0:HPZ@E-UT3S+22N:HUC_=.>TAQIF\E7\)I5dbW3cU.9K+L-Va5.3c+SY/)W
?;S<L@,X7BWQIfJ-OS1C<QfgK=R8Qf69QOSfQ&aX\D?eT\&#(&R<3U7N\aILUPe\
\XZT=(WJIFVA[;]2<]26[:NGO(TE1W^aYf=Z,A3#KFF&OM?E5&A[OBJ0UUeD;[-b
8VA5.VF>64.-+bCeU7+PZ?-U[K],U]_&D20Ua)5.Y>;<)JT>CQ7@#Q[a-86__:+&
ALRJQ,McH=Eb,bbOS2?;/d;<#fUVHWe3X+D#e#DOCQ]8LDObN_f]EF;^_K4YTKG5
@U/1M>V53Sfd2AI6=L;3K/H@SM5KgYNG8/,UBJV--OEY+G7V(VAM^dV(Cc.<MPDR
b?7a1/4P3ZbN+ZZ2-.LU?1.[SS07,d\:49R13(40N7b-]7393Kg_OPa)DB;&KCaN
dDIb6N1fYdGR(>01RYgB6TPN(+&X^IN#F7<L#_d4[:K-2VH]>5:]e3PcOBCTFDW]
Z0OMFP:?V59S59ecT,T-Cg#]]e0KPK>,W<1FUTT[=g5UO>fHfO+J1A7=0>G]3=b:
P20318T.(e[D4&6cW]M.S3ReS1VPQgc(NH6_B6.3c,]6Z=f9b<4E94,[b;JTf[31
8@d=[#gTg4B8HceCLC?+A2S_/+(8UGMfcE];-P>b#W76G3=ILR2M^?)42C4@gKd3
^BSf1OY>(62^WYWJ(O^3/4>c_)<C9E+86OM8\A3&A[C&J@66dJN56Z42ZD-GX=MA
e8,#-F)@^HY]3gNX8>53?9:Cf&=F985XY04#E>3#d;O7CFNg@<-@<[/O;JF_U,9\
D<>[3664SMT>dV]EOd?dUSQ3^PY^fDN=0c86]faYgQ(8L7&Gf/O[7Z(21BWgWX,F
QLa</R84/ZZ0eJ@6/7H##8\?VAHPAA[>CNcEaeEM(]+7D4Xc16VN36;:VcBKHPLQ
U?3bg6S:a\K.,&J#+ObRMBGS&D5?beSR&ZDd#NRV]DMSbg:XIeO;6H(RYaODVV^5
D7P..QNFaS;L_@F2<QQWg?LX]AdL_F2I3^35EHS+T3b2,Gf0/D10_6ATWSRB3c38
0:3W:Cc8g1&8fS7IUQ?3#:=9U,?W;B&/&6FaKEX\B/A[L/#^f\;2M7b.eV[dB6]K
F:T;^gQ+B0G;Ef)/9a,gb>WHIA:I)#P[c4KGbCX:G2O26gI9a:^^Me0EC(N/b<^U
^0NY4I.MOS,?I[A=f+UT,GdgbNED1aIH<DFN.aIW-U]S&)eDFE^J)U-b-WN8QB93
<A\.F5C@5OFaR26#SEF(M.^]A3)c/e2Q@<BLHdBZ.]]J.@&JR]8M_g1_(RFT9f,P
aE:2DZP_(f)N7WOHYTaH7<N;=N@Q_;9=b])8a1WDED9?)K1X8fT-&=#L_(0MV,eP
V9G[9QQ@aHDAO.BM;&02JI&f3S=LgbA-Bae29^IKNe2L#aUS7&8_<&)BVWSYP72.
SZdVQ,7I_bIC./1gaE@R7:fLQ4ET5I8=fbbY>U15KK.=IVLM6?)fR4+WV7?>Td1L
?40WN)d-g\<UFJ[e0bI;YTP-ER07M](<-]5N47af\SJ9_CRAVRSY-B\_Y4\C6?fI
GH1e\f]\ZMP026KcH<[&DTMDBLBOIZLFX;\;6J]Y-QF>(3Y146N5HZG>L>N/d^L+
46\3DLEEc,YH2&=1=>:dD##GK,3JHSa9BTHHVLBA^\5(cU(0:2_:@KLC.cf/ZUH@
Y=FQ_A9:&80]6dG1&g_+Q5X32O-T5V<eZ[&+DA:HJ=>-9#)PNbSIU0M=2>RS@)J4
@e@RSNfeWM)K(#WWH5-/8&Ee?+?:0I=:NA2c&W+AR3-H<.3C7JbMJ>/L1N36VM8.
/K+K;MHe._XcG9;Ug21:@@LP7L5N^fZ6\Q7PRXP/e(ZK:@@ZNC9<7fSP2eCD+cY?
F66YWggP_eA@M.QfA87,O=S:6Z:0<+O=VW\3f^8LJ9f:^@=H-ef-[2AZAV27SV#N
7<Ve,K;Pa=CTAZ0]HK+TO?SL<+FRf/RgW\^0eAQOe(@&Y)a9PX1EE1-7g+7Wa.(X
VKF&)Jcd4GH#H)?(FGM;L#\W7NJH(0LJEU_0XCU@d>K><EbBQJ3_e3@Q4N?9TQIY
G#2?BV.JN-QbM?YFBR/Vc^JWdf-MYN5B;#&g;Z>6,EK=g7YcR\I2e4V5SP7@LA?X
R_;RD7\]MK?[WQ:A>?FXI2@FdBHN5[>a1T&a>?O+-U&Gb)[GH3@ZYY&Z4U[-X]bW
WM#3+Ef1#,f)<S2.CR@geNGedXS_gecC3(N32H=-XX-C1&[/#+WQ,gc#;:J;g;c&
OUd).@>E2NEcgP;g]SRS+/)8G]JRdH)7A5C,C#]e2-[/bZ363?c6=#FZA6Qd<#1<
JGNgXfD\PQMD=^Y>[Se.9LbI4=/WE3#]<>d.J#7I57E]dRXT9+]6S50AVDa9;J@@
Xa9(17N-1.MSd(Ld>#ZM#P<JVWK_L\C9>cGaQ3)^Qa2O<NX]7A=\I.C922MH=_W6
EH?].U>HUe#ZeJ4aPNd2X/6cXF667</c[W8UQg1f7cKa;4fLJR,cE9Y2PIS7HT]E
+^Xg&3ASfG<F2K\NW;d5WB>;Z-/N5:U0bV(4a8)5#?C)L1a2fCX0@;8A&]U@bL;Z
^==:BJVe]c-Sf667MMGY(PLBF7:07GbC=LPQ.GO.A2WXZeJe/WRZYSN.CDIOV/5#
ULbbTUeS^V^=a^V@HC/,703@ZX:J\61X.gVON?QO.>MZ3\_NWdT@>;-CFgK9+?99
24)f28?Y3K0JJUgV0#MWbbYa.NNM8Og6ED9W2>KcONWLPSb_DP&+4[.2J/YAa?Sf
^?<_Ic,FT#GH;G^6J[Q>QK?N5&d\b[+15^SAF@G1,?U^@+Xbdb:e?[AUV&1e^?I8
Bf/eYf5+_XL]?-4d&\9^.H)U3T_2<.<A+fRGBGC+A1&[?L+a6>_LENNZ.TVe>E4g
_H]40O4efFK/92?.J[L]Ga_R7EZ_?,F(e(Z>Y3Q@Q,ZV_e_2dd@2F],VgRYd+J.<
F]ZLA0W5UPH[;TR[X;,[@GgRC=<@e\D=Jf2_J9R;BbG(F(PDADH?gf_6QKMN>->D
>fQEG7.,4_H+8;\_>HT#UA7D4.RANZF9H@0P&Gb][EV>T:>\^JF5,PfF,;d(P8G4
F=BTeRJKD8<Ic=JMcC#K/+b11cP.YG:9aE;^Z,DW\HV3G1JWgG.g65aN\aN@.1c5
S)=L4HUYNJ=5CHHgb21XBbIHIM_BMgYbgO^+GeR(Q@3\#AIUEPcBebXU&<Z_gAS[
KW>:6=-bE7\G#7>^7/W&/8d=;FPY0:14O9KJT(225B)2VG7gS?WS<ZLIZHA>+_;6
<Ig;c9Z_3Hb0;RG(AY+@]([?LM98DSH_/^5TQ\fYK>1)[(--U\GIRFb\1Magd@KV
@]@+N_cU(OLf4MQeO;O>3U\1W2:C8KIEE&3gP5=1VI)d793YC&GN-&XCDJ)/5ZDe
LIZFNd_8<I4fIZLGR785#C[045KA7M#6:?ZTgY;Va-^5(8)&[2^FJUO[#851RaZT
<d_D>B.)XB9\DY.M@.R]fC)C>J0SW(BNLM4]?\.RK,X/_H]N3<bRgcMY(-(f<<)<
]]?_Z?g;@2>I,?f#8:2[6)UaK.V&:;Q&)5>>FBFGA3@XOP7X2G#1De55Ye]]B&TM
H(SEbK)a]NGJcIE7PK0^QZ<aF0492(gD8>H=62b@a@(S&3AAgN=_[L8HbAJ_=>5(
OTbQQW[d-4cCZeW#g3>J5g]adJ<F#ZCeF9;)P6@&PbaeL30[9PUX/6c14-KTT<ET
]c#TS#U+FT85FQP12^8ZLXRQB5JYN0-+g-gP5g^J^e2UfILG[Yb^0#RdVMWB78N6
>e6EL(W=&\596=g[LWd[MW&XcS4#c@e<QLN_7@(_CVJ+VacXVB_2,,URb1VEE[HG
<)ZA&5RL^\R&dH&&f[>eP+<W(T9d>fD@(g\?^>6a5T@)9HAUYLaLO_9#_@g&dV>8
/gC@8CI12#4#0[Yc?A3W9=NU7X\E,[WeVZY>1YO:/:Y1EG?b7K6;CA7(187>SfMc
@&/#4DHBc&W,N[JI7XZDe&);TY^IG&fI+P]1.0#2YQ.3ET?cN422:)7^_Sc>Va[?
B2Y.&>U1egBb^TR2DGVRAAX(Z]aUN9[E2.:BTYc3/24e7cSM9RZRW3C1Q7N:[-Fa
F64[U(^><J)6daY1LZ.H>O5TS&D5W?;P_@?#cA>^e\ITT1JP/]AERTeF062>R9WU
\[\B@#^b-C-f&4Y&K<MBR]Q^\&<NcES1/0U>,.YYTD@fe)g-\/^)[8fT_&#>GD=a
2gVKg&#/I)>@<S0dJ6H6(V))Nc]]6VZW-VO_)1#,-,Q[f>3ae9O/b2@<67^,bU+c
0^^B>HOUd/QJG3&J[>#X4M>JR4L,_0.Vb,K0E?dPAKO#fKee5g:T&RaNO.OJ=+<.
[Ce8c15XB:U=HK1TH^2b>@G.W2HWJ@7K=gO^X-1YCMOD>6)T-@RWJC\==;QWA5fB
3IOVYZ)U[,.Tg\]0YPc7Wb\UZDZ2KdcW9e,H,]&(7LU,.a]WWM)8]7XYR>RRa7JO
aZ@KB_UUEL,L(2\>74#e4MT/C;-B>eHBUYE][4Qg]2/3BVba8^D4Q/Taa?(&4X]Z
aYIZH=Y.Q9O7E/S#,fBP<adBJ.^&]#Y7f+?H4X;6e\EW+:P6Y)QdI<QfA]Dce6.8
N/DfA@LS8bf+bdJ,_066Q..OOE^WCNda(f#@P]-YKd/\&A>G0R3IJa3V@]1f(62;
QG?3R@0A^1]J-O,II2GGfR-dD?F#POg@/fRRadZBTYbfV4/5Kb[H(RY6<4TR>7V\
P,eG7W\F3a-YRI/SK+)5Q@]?fCK.<d0SGG_;4BWS7J])N-efXCZ6X<YMM<7.S)O]
EY+cWTETW_dc7GWg8@I2?eeF1@?AUYI.2(:<\Dd9[\(d+_XT17??]K28caI4GU)H
9B,6Y5M0U5(GAR>9+-2:3^8K0H@?:Nd<50T@^22.JPg078c_:V)=f\0[ULUI7F9F
HLb9_6V4&:216I9/&,&FP)&d,FEX4ZD.8B+V9,6.RMG\0O)>+-B518.RM/JDdZe;
8VKF)XcMXgM9/BC#[?-J98DVe>MO#bLM@/30\g9H#WMH1&bN03PHT00=;.FPLU<\
\@aYO3K1eGcN[@S.:W9&Q<;S+O5:Z)DED<JS0GdQG+g3dfJ+Y[PNZ4=b[Fca4]OS
UT@^3YgaZ[7g;RFN7C;Z0M0]Kbg&>3eC@FVa=/(<gZQJLYB,AHc4VN\/,JCO[Z.S
;XgIaD+Q:,L/Y\6/2??A0M\RQ/dIT[5L+(&&^B]@0NU&MS_Lb9DAae/(G8<X;A^@
6=<+LPOeL/AG9.WfDZ]Lg55Q-726X,S?;&FP-QF&H#\^V0&E<SGVT;;84;<@FNVa
a<Y2K&7N:S;=aSB]CNgH=EgN6CVb-)0)9^e_-b92\.+5(cEBaF4L;]#UM/;G<GZ&
-]8G9(Na1F=b#\bHZD3(FKIQd&b5V\QM@&&CX)H3OgJU3I?(YfRV0e-)QaX:C1K&
YQ.[C@^=K]03+EI[):DRB3JdNJ0\3(H_fC;.GHeM^_923^1RXYRWF2IV?M>M]4KO
G)H9Q3e_#.-fT\44fNKBbHDA_D&T&/??QY&Jf2_ELXN@LR<0JaFH<[9g8K?,SCX>
UAa(N3>N[W;XbAS1N:\S)DU,>(28We(d+MO2?3_C2.DQ0II0E<N\U00&H9I,82]E
7ZI(H\8e>_U,&/DIZHJQ3T8_J[<J>)C4>=P:EHI8,YD[gF]Se:D(UT4.4O\f&:/;
5>#@JFHII,Rg]aF4C.7&@-A2.6]W(0LRT_>)Z+W.OT,/2YF#fWH,]HDJ&4a.2S?P
[+4Ie[EO;NbZ=(e5=8b/X@T0ae&OE5K3f/BPWTK2g4AZbecgMS9;E.I:K#X[BLN9
/A+Bc5JBH/5W[gGQTZ^GYQP:.^a1[SbG3G,V-,cd_B1C+Z>W<#OBcVINO;6&9ZOE
8/AeY?@VX?58R3Og:4J.8XYe8@d&aTOAddD876KAf<a>A;T\NAc&:^.2H&^a;D9Z
3J=bIZ.=?-42YaO#=:LEF?ee#b,a-eg5KZJN@;/_10Dg\M.E8@MPeOZ&U;BO#Y]Z
gQ.A<gEI&3<.=bOd745BG&3WT<F(UV7bDNQM]0#\3_JZUYQ<VH5(LNf#2,#gg=.<
COaJBHMC)F.+DNBaW@<28]KO;f_H=9g:T:+&)g4+QZ&GHAK97@fUQ[Xf^FUUEF#&
8W8/,:/?JTg<3B9>&;6IE)03=7I4-47G;9df7A_@MMKF&V9U@#5UF7H#9>6;R3;0
3)[9-(e;@H8_N+<8=&ES4]/H\bKaP)4IIKO^d#=.]/1EN_F[5f,6GY1S85=^UXKT
]P#/GN.^CY@F1O_aEZ&/(O/3fBcA+XKb>WfQ-@O_/3MF@/3YUMZZ3O+gFVfAaXO?
P,7-gUPZ[EP5[Z31V#^TTQJV24XL]Z^X52RJPKY>IgU@</4VHGbLebM[1-33JU:5
-X;)N)\g9CH:71a]I\)@LAa1(6ZPXX4.FcQ\1QKY40?g]U=<Z\abS^/REVY)/:PI
(SIO,W)e7T\]Z.+[RI/BDN5gPWIVC;-5+V8d+>4dA:GW+YI?X/2MP,C\H+a6UH)b
MALcM+dgP2>.??;4geCXYUT+VXdcT&\D(Be)G&U1F^EUb.T>:69M/BR\Ze8b-O<1
LZa?;/(T.9_2100YR+T@E1K&,962BC>0R;8c&9F[Yg&1ef:ZWSYX>gDD6ZOg#9=8
?-S1eVDCUD-6^,84>LWKE?L/I9TH0M>>\G=&Ad2cRJ8Y6\J/IW\/IDK+KRD@#B)3
9/.0N]-;@(SSc[f3Q9XJE[76<RG#M2c8WI6:X:e\HB@N,D_(gF@[=,cB#7b0#c<]
IWE52Ncf]J&DNRR&Y)2X-G2[^X8MeG8HG?TS6:9f50TJGN?bG5N-W&aaEWN?@c<.
7+==GbTR7[L0A409M.>\/S,H&-25gM/95E2e.J#a++d(8e22OD1>WMV]_g(cAV-<
(FXLaeB,70M\<f1[9f9-/&ZQ+NEd/FW:(7CGRf+]EK7U[FeES@KN1Je93I^/[gYK
C9fLSf1YF@G<U4bb6>>WW<?^.HVdf,ZX\/3c]4McR1YOAScdVgW+Db3PPP^FdOf[
=66U,Ef-_.UIA<\TVNRe,,VL\dO.O@TMRXOC7T<O,d)ZB3^DU1VNe)Da8Y2=f?R&
WaeQ(gbV8]N_Z7]J6Q-@[+JN)PgOMPc]:##eO_F^3<KNZ3e0TKZ,g?b&2J1A;V=+
->g:HbSDH7EeT[E+4Y)_&CW9H.,gX>(/-Q?DXD_U6d#K-_bZ(gYD1Ibe++VB&\#3
33<B7&OY/++U<1)00R<\+Ja3>X2CfNa8TY>O4C-/fLVH:O=0@-bA>,0K?8-(Hgf.
5g/^M/^\R4gV<eg;[O5GQ?QPU\X>771K0M>1WO>8XCUQNTJ43Hg-<(T])>GSEXE8
0F]DaRKXdP,L^CX+6=3A9b/#3+-7LL17N[82)L(6H_;7+f9dRb)2,cABAX3/d8,g
G>E^893I:))5@30Vd(5be4LKc:F69-?IUA8&a-M=>U[TC18N2Fe>UJ<BQ(TX0D>C
>4T]WEQ?J:W]AOC#gVD.B476+,C>+@&0CX/9=^T?[7\I\N=K2TJM3<1\?CSgJ+]9
<<DOIKSe\<1Z,T(A@_BSI#-H8X0JT)J/+T[6O6-X7Me=A1NK>]c+>gV[O@I[)QXM
67C7PgbZC__aPc3_;E15V/=)H)R6YTY?f@]BZ\AQJ^H[C?\N)XBY_M]e_H#f.,_:
I,OS5LBYM6c8,;HZTBb[F-HH?;(fdg<CE?^.X>R3(O>J,_I,Xe[=S6KVU[;LVWX]
L</;\;+04?7XN[@A=CCOB.WHee3;XZ2#.9#)S)@:SIaW+N,N.Hb97OCPOF7#5_K\
(d3Q_BC@44R./Vd7&@2Q4fWRTga9.T)65>\I\a#bb64\4S\NgSQJX)#QR:T(S[6;
b=eG-V89Y5Sc)W^gR=,;K(@)]dH-R,&b<dW,B..NJ:/I@SX\IV(QCV?I\XK80e.(
>2YUH_3)&)H[04=4D^3^T@0M<V9PZ?,[W5/cTVM9RXe^>Cf4&MV(2(RPUA>H_;6;
..4WDM;;><U/-8]>/,?^2S88BXa2b4T_(85YVFEPVJ>5Nf^9d[[=O7Q;6-0cW2&C
&_QX?)TT63cM29K->,Z6=]@8?9C8[?a]a>>^9e5K<e\(SLg71g#S<Q8.MG,a)U,J
+a)b16B^L()BVI?@15G;BNd@_-3CV36M[(R?c<R>#9a+&4=ACJ6LfcaQ-72ec&R-
0NY&a9MF+GOLD5\VP6F.4]HSCF1NDPX48V7B,)@(1#S\06+&IX0NP08GZEMF.P@E
?#<Z7EYf-L]I.8ION,6/[(K_.?3\=\?f.BJKF=IPG_O=F[IJW19bQR>^JH-+X4;Y
0,&U3PAgV^]ZQeTaJ,-bcb#?)ECA<KPbH+fBVI?d>_EQ4)d-57bT-&D[RQg;P_)2
#DDIdDR2-MG0@I8TB4+LGc-\[(E(]WJUO9a19Q0IALM0,;AXFU5N3KNBE,+UV9WU
[S[BU)YM&N=0JQWFQ?4L_1R+YK:GY5#;.>RRZ.YP5_XS(QY/a?.b?7HA7DET@)de
78DFQKg.,=eW7PUNWC.MN/SOS_+X]&.\FN4U4N:[9K4J9I=5[Rf7gK7.dS.\QKfe
3L8^(a8;#3d=Z]K_[Kc.OQ2-V.d;Nf-,JO1.KfG1CHT9g3bdT9bQcXZXO]HW-[4F
^2-gZLV(.QM/Ca]?+YAC#1:1AI-U>Q?<7+E>Fa.YE8TdPI[8;N9>@6O/H^^[1AD5
X/XM->eX=X995_>.<K8UFA3IGXVZXKd3:.#,44V94HDK<,aZb^YdD#&e3+QaNOEc
>FOR?ZdB,b_?[R)-@^,YI3FNd4HDJ6>Q0L2H>-2B<K/dg:J&/7NIOVeC;ac)aR8&
7&[FEJB3fT+.c2.6T=N#8CIgX<R-@+4D_7C2eTK;OO#&R1QcA6@K.Af/VWZRCVa/
OQDN08<aR+O=T3(:c#R\#JPF:V)8e+g2>ZYcN,HK#gNZKCg)deY=(-SgWF/LN/&.
U.F=N3f>/A=_0_KT+-fJF6eUQ\[,a86)\/SGaUf[a3fC>:^T=_>EXR7<IcW>2WM@
?Ndb^f/>@&=UU5-<bH;7cLfRde=A\H?.VgIJ=f5?S?6?Se1@8:7BM+TSJ8>V<9Bc
>,HII3G&:Y6;07Q#8KFd?XL+QKKK^S5XC8AT+6_/>.aSB^NH6A.?[dF&,&+g8Y;Z
C),SEZ__)XQAYNS8Kf;B\_X6_ESC>5,=N6L+Q6;K>I^);:;b7Qa0P_Z9DPD0+aeb
_8:^1Q1V9O#=KeU04FK&F\He_3ZY_6A@8>O31<QI^+,6P;@,efI>\#_[;?B.X9.;
W>2O=3f3[HNXc6F4UE#f:0T).+Mf[^(Cd>ZTG+aP(7IID_=FL678(YX_C?=\S&&+
PUO+64V\eAd](L6E=_9O1c=QaV>]b0S(BJZFBT3/_;R;[[VdN#2;U)+c0B60_O?O
W08X9-#4fA#Y/C[LSN&(,FcS?c41\(91IHKM4ITXA[0W3a7dS=[RY<AG#3)dXQc=
:)=YQa6^8=YN=@8<5(WD=L]E-M\=Q\1+HB/TF;8e-:1VaL2K=?Z3E?b(TN?(O2+X
#g;f6@R6^bT#M2\W3I+GPVOQC>)3&Q:R#M3-@BD>@ee,Z_^b^CAKa(@QcGeg,G-Y
\YGDZJ)f^1@:T-TD2cf9C8.Q=\K]/eZf./EI-O,?.Z/U3f5><@6T3.+N&K1>Jb9b
,7DI/<I1Ze7<+<RB^Xg;N[fZe/^@0T)5^\XfZ\RH<g8WE@1F_(e4-D@\2X_Je/8:
=YO[93]La&2XJA,?_8M/EGS</:?8a4f27>;W5:P#7)];(84N2C0LDcR73>c-YeN]
^:,.P1O()fY3VIE>/3,EYG;S?89P2cV)baL;bTB+N=(;VH+8^QHABIXO.C3/7G30
a,<>Z6;]G3g9JeUgbX_aMTLca\CT.]0>3E/\S;>M+Z9^eCdJ-0MZ#AXKe.:bXRc.
2-HH100c9\(W&=-\9WLNc93[6WAQ&)2S#BWdP6AWVZV(A/2Yc8]D/dT^[RFLWDG]
V\0,U/BF&C3G3E]D.e[O##FYZDHS7)3(B<:=L3b/fNK>ZQRX@8RL+@JT88[O]LaS
-&d-:VDa]ccY[-ALD4H]d1R<Xg0[;FH5&Z3\],&Y=<,J9f09=I/H/L6?W1P\7(+<
^4cW8(;);Oe3g=1Y_/KR)@1=JY@N7NaU<$
`endprotected

`endif //GUARD_SVT_TRAFFIC_PROFILE_TRANSACTION_SV
