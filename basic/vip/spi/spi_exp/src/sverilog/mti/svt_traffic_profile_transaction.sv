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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
dJoPBeG0ITinTCn6mPEXmmX6Ap5sd409zYW6VdN9HV6tmz95KALwMDXcTQmQw0Px
Zm7tOhf49f3Sf3FLoFr7chtjEOPRuAforNluenZy1SBtn819DuVgWTRaV7r08edd
xcL5i1Z4DYDOqsejVrAHnJeNE90JihPULa1sLxbNWss=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 24550     )
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
`pragma protect end_protected
`endif //GUARD_SVT_TRAFFIC_PROFILE_TRANSACTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
TlTbzDaLJ49gMV6oDZqj8ly2lTzb3tD5zIntNwi9bfL0b5RL2ilTYAxs4lW7S70A
/D54mZKzdmMCz7pDDkcCgOuJwxgLD9ykzfRDtwookX/LPYtD1wdPMkA0o0TF3IlE
oNILMJI1HcI/QZXyand6RENEyWtdt9fL0VX7oOCNgpk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 24633     )
F3czvwLESm3XmeKk2xXSA8/w/5QhjQPLfu6mENtXQq1q/5tTO9sEkZZ58bJ0kqdR
pDqHuzD3XPE+0TfYr257rcOqLiiDcNAd07QHVG6m7+YOyI5H0xnLPrCK6x139rB5
`pragma protect end_protected
