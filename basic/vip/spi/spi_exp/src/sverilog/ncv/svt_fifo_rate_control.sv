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

`ifndef GUARD_SVT_FIFO_RATE_CONTROL
`define GUARD_SVT_FIFO_RATE_CONTROL
/**
  * Utility class which may be used by agents to model a FIFO based
  * resource class to control the rate at which transactions are sent
  * from a component
  */
class svt_fifo_rate_control extends `SVT_DATA_TYPE;
  
   // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************
  typedef enum bit {
    FIFO_ADD_TO_ACTIVE = `SVT_FIFO_ADD_TO_ACTIVE,
    FIFO_REMOVE_FROM_ACTIVE = `SVT_FIFO_REMOVE_FROM_ACTIVE
  } fifo_mode_enum;


  // ****************************************************************************
  // Local Data
  // ****************************************************************************
   /** Semaphore used to access the FIFO */
   protected semaphore fifo_sema;

`ifdef SVT_VMM_TECHNOLOGY
  /** Shared log object if user does not pass log object -- only used in the call to the super constructor. */
  local static vmm_log shared_log = new ( "svt_fifo_rate_control", "class" );
`else
  /**
   * SVT message macros route messages through this reference. This overrides the shared
   * svt_sequence_item_base reporter.
   */
  protected `SVT_XVM(report_object) reporter;
`endif


  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** FIFO rate control configuration corresponding to this class */
  svt_fifo_rate_control_configuration fifo_cfg;

  /** The current fill level of the FIFO */
  int fifo_curr_fill_level = 0;

  /** The total expected fill level */
  int total_expected_fill_level = 0;


  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_fifo_rate_control)
`endif
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
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
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   *
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(string name = "svt_fifo_rate_control", string suite_name="");
`endif // !`ifdef SVT_VMM_TECHNOLOGY
   

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_fifo_rate_control)
  `svt_field_object(fifo_cfg, `SVT_ALL_ON|`SVT_REFERENCE|`SVT_UVM_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY) 
  `svt_data_member_end(svt_fifo_rate_control)
`endif

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name();

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
 //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. Only supports
   * COMPLETE pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. Only supports COMPLETE
   * pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset. Only supports COMPLETE
   * unpack so kind must be `SVT_DATA_TYPE::COMPLETE.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the buffer contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif //  `ifdef SVT_VMM_TECHNOLOGY
   

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: This method allocates a pattern containing svt_pattern_data
   * instances for all of the primitive data fields in the object. The
   * svt_pattern_data::name is set to the corresponding field name, the
   * svt_pattern_data::value is set to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  // ---------------------------------------------------------------------------
  /**
   * Decrements FIFO levels by num_bytes
   * @param xact Handle to the transaction based on which the update is made.
   * @param num_bytes Number of bytes to be decremented from the current FIFO level.
   */
  extern virtual task update_fifo_levels_on_data_xmit(`SVT_TRANSACTION_TYPE xact, int num_bytes);

  // ---------------------------------------------------------------------------
  /**
   * Updates FIFO levels every clock. Must be implemented in an extended class
   */
  extern function void update_fifo_levels_every_clock();

  // ---------------------------------------------------------------------------
  /**
   * Updates #total_expected_fill_level based on num_bytes
   * @param xact Handle to the transaction based on which the update is made.
   * @param mode Indicates the mode in which this task is called. If the value passed
   *             is 'add_to_active', num_bytes are added to the #total_expected_fill_level.
   *             If the value passed is 'remove_from_active', num_bytes are decremented from
   *             #total_expected_fill_level.
   * @param num_bytes Number of bytes to be incremented or decremented from the #total_expected_fill_level. 
   */
  extern virtual task update_total_expected_fill_levels(`SVT_TRANSACTION_TYPE xact, fifo_mode_enum mode = svt_fifo_rate_control::FIFO_ADD_TO_ACTIVE, int num_bytes);

  // ---------------------------------------------------------------------------
  extern virtual function bit check_fifo_fill_level(`SVT_TRANSACTION_TYPE xact, 
                                                    int num_bytes
                                                    );

  // ---------------------------------------------------------------------------
  /**
   * Waits for the FIFO to be full after taking num_bytes into account
   * @param num_bytes The number of bytes to be added to the current fifo level 
            before checking whether FIFO is full or not.
   */
  extern virtual task wait_for_fifo_full(int num_bytes);

  // ---------------------------------------------------------------------------
  /** Resets the current fill level */
  extern function void reset_curr_fill_level();

  // ---------------------------------------------------------------------------
  /** Resets the semaphore */
  extern function void reset_sema();

  // ---------------------------------------------------------------------------
  /** Resets current and expected fill level and semaphore*/
  extern function void reset_all();

  // ---------------------------------------------------------------------------
endclass
// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
2I61inbFNchOKGJGRPvOl4ldq2eI4QEgxAH1d2hiof8Oel38uDyDEEcuCwXqantd
87ek85zNeBuwhtpRD4ZLIvei/tJ0eMExcAatOc3KWRy4BZWLuveuPBY9IAaSCFBh
/JyFjf7AS4OzKfzheBQzr8ytk35rGLHrmCcb22rqGVAOGbmZ6jqSdA==
//pragma protect end_key_block
//pragma protect digest_block
13C8qhMz9zO4mes3SnKVo/XLIEk=
//pragma protect end_digest_block
//pragma protect data_block
HnCiNnVdRGUgni5AEvxv6H+eHEKMO5/5HQbHjeZWlUN4bl3l4JbFMBc7ii73NkYe
/7t2W9EvLrSizKNEHEdcxVCae7BMkRx9EG3IG3uj7NY8myngFi6JMs8msG7alupw
pwQCcQXYZoZGvtk1bUeFYGaPXNVWufM1wXf1ChQ0nSFflQu13disE+t/ioNV1aPO
ArXAmRVWrJYZuyUb4AqYl+58LU2mIRKxrrYXutICClU1odtAE3NRFgFRf8fWgagd
mOorGSmx83MUgTVlfsjJjmXrflEfO6Lx+jYZHdK8NCkYmL8WFprfhaOM9Zgt6i4d
+rIvlfXIFE+3u9Pl2phQemwfUOEXRY4jlWWzBXuR9xaQQU7Up8uhF1z23bc2HhEK
NGUXOHVLgIRa5m53a1wc7gez4f/lSZYILwhvtvx5oKQ7MtJtOhTzYTAbo/H12pOg
HLzRZGjGgh+SXjAni/RL6hM+eav02Y/cBuSjCEH3Lbf0uKlmDteX0cgHEl7Nm0h6
CfVHepftpd49rNRHJbHpimX0oGbVi2KHLxkltYlM+Z8FKBqxS5chJ60M62sn6Zp0
Xabss1Sv2GdBnY8tobfcqtKuIkU00zz3KjKc9jJP8isYcidJBWS3K+vNpn5AwBJR
EDFN9Eqc9ADPKQnfKsc72BRd68NHrjoK8sYCdhs9IFG+3cuCSK4nija0EYItfS4L
0HXHG8YI3zPeZUiDATNPW+UWKlDsPzRahpxsQSlUwUQONY5w/PsyLDVllJFehTiL
6WiNUBfTuFr6srEFfMXeU6Av3GQ1nBGkkRkbcHNkz/XNmH4/fcNALD0e3Du3eVR4
d7dwZnGUBGI/b/VvICjq3AQpE0oXQgF6JoMawBkcmgI0LKew5BgW/qL+50auVatK
AshmqUdeiM5Fzd0QKHxlhw==
//pragma protect end_data_block
//pragma protect digest_block
xAd0o8shMEiTEp9g+clef1v3YnM=
//pragma protect end_digest_block
//pragma protect end_protected

 //svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
edbhAMzDEH7dPGvlRy/Tk5jrT4SKWVyaeJ268hhExbfOEsltAmShryAZAhmt22yc
LMr2A2w2SlwtVPGBZUbzueOBpJVs6mMYeHw7tnM+UUUMml1xlRrxWLVLecaxNnFJ
8iSXd1NRw23WvYwpBET/6wGDNp/PGPA8DaLyIb1/fzbxND/ryVdPQA==
//pragma protect end_key_block
//pragma protect digest_block
gyEN0vxT0IVsLL6olbnz5nIb30k=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
OmUR/DqABr35iRawwI3Sh1eR3PM=
//pragma protect end_digest_block
//pragma protect end_protected

`endif //GUARD_SVT_FIFO_RATE_CONTROL
