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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
snuLhMukrAWW50QI/q69f97tAO7EZ4+uRpmy2qcLyBFZryVM9CnaNFRBm7aDE7jz
ttWRqyGQ4iSzqubDkBpfcQeeTq6lJvZgxYzz2mx/N79RrTaRmD+DbZs3gOBd3jXA
Jkw9eJHiBEloEMiIxOBSvX8TdXS5g63e4cSLTTPX9UMUo1gcCDcCjQ==
//pragma protect end_key_block
//pragma protect digest_block
m77aKWq3IgrnHuRFgrFWIaQnq7I=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
SFR4OwBuNlgyOAbcdanbZoBJuQI=
//pragma protect end_digest_block
//pragma protect end_protected
`endif //GUARD_SVT_TRAFFIC_PROFILE_TRANSACTION_SV
