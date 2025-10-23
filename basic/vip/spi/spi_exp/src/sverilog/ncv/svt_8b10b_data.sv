//=======================================================================
// COPYRIGHT (C) 2007-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_8B10B_DATA_SV
`define GUARD_SVT_8B10B_DATA_SV

`include `SVT_SOURCE_MAP_LIB_SRC_SVI(R-2020.12,svt_data_util)

// =============================================================================
/**
 * A utility class that encapsulates an individual unit of transfer in an 8b/10b
 * encoding protocol.  The object can be initialized with either eight bit data
 * or ten bit data.  Methods are present on the object to encode eight bit data
 * into its ten bit representation, or decode ten bit data into its eight bit
 * representation.  The current running disparity must be provided to encode or
 * decode the data properly, and the updated running disparity value is returned
 * from these functions via a ref argument.
 * 
 * The 8b/10b and 10b/8b conversion methods utilize lookup tables instead of
 * calculations for performance reasons.  The data values represent the full
 * 8-bit state space, but the K-code values only utilize a subset of the 8-bit
 * state space.  Therefore, the following K-code values are incorporated into
 * the lookup tables:
 * 
 * - K28.0
 * - K28.1
 * - K28.2
 * - K28.3
 * - K28.4
 * - K28.5
 * - K28.6
 * - K28.7
 * - K23.7
 * - K27.7
 * - K29.7
 * - K30.7
 * .
 */
class svt_8b10b_data extends `SVT_TRANSACTION_TYPE;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  /** Static flag that gets set when the tables are initialized */
  local static bit lookup_table_init_done = 0;

  // ****************************************************************************
  // Protected Data
  // ****************************************************************************

  /** Eight bit data value to ten bit lookup table */
  protected static bit[9:0] lookup_table_D10b[512];

  /** Eight bit control value to ten bit lookup table */
  protected static bit[9:0] lookup_table_K10b[int];

  /** Ten bit value to eight bit lookup table */
  protected static bit[8:0] lookup_table_8b[int];

  /** Disparity lookup table (indexed by ten bit values) */
  protected static integer  lookup_table_disparity[int];

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** Status information about the current processing state */
  status_enum status = INITIAL;

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------

  /**
   * Eight bit representation of the data
   * 
   * This property is declared rand, but the rand_mode is disabled in the constructor.
   */
  rand bit [7:0] data_8bit;

  /**
   * Flag that determines when the eight bit data represents a control character
   * 
   * This property is declared rand, but the rand_mode is disabled in the constructor.
   */
  rand bit data_k;

  /**
   * Ten bit representation of the data
   *
   * This property is declared rand, but the rand_mode is disabled in the constructor.
   */
  rand bit [9:0] data_10bit;

  // ****************************************************************************
  // Constraints
  // ****************************************************************************

  /**
   * Since every protocol supports a different sub-set of K-Code values, a
   * valid_ranges constraint can't be create which satisfies every protocol.
   * Therefore, it is the responsibility of the suite maintainer to create a
   * class that is derived from this one that implements the constraints that are
   * appropriate for that protocol.  The rand_mode of all of the random
   * properties that are defined in this class is also disabled in the
   * constructor.
   */
  //constraint valid_ranges
  //{
  //}

  /**
   * Ensures that the 8 bit representation matches the 10 bit representation and if the
   * data represents a control character, then the constraint ensures that a valid
   * control character is selected
   * 
   * Note: Functions in constraints won't be supported until VCS 2008.03, so this
   * constraint is commented out for now.
   */
  constraint reasonable_data_8bit {
    /*
    {data_k, data_8bit} inside { lookup_8b(data_10bit, 1'b0), lookup_8b(data_10bit, 1'b1) };

    if (data_k == 1'b1) {
      lookup_table_K10b.exists(data_8bit);
    }
    */
  }

  /**
   * Ensures that the 10 bit representation matches the 8 bit representation with either
   * positive or negative disparity
   * 
   * Note: Functions in constraints won't be supported until VCS 2008.03, so this
   * constraint is commented out for now.
   */
  constraint reasonable_data_10bit {
    /*
    if (data_k == 1'b0) {
      data_10bit inside { lookup_D10b(data_8bit, 1'b0), lookup_D10b(data_8bit, 1'b1) };
    }
    else {
      data_10bit inside { lookup_K10b(data_8bit, 1'b0), lookup_K10b(data_8bit, 1'b1) };
    }
    */
  }

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_8b10b_data)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the <b>vmm_data</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   * @param suite_name A String that identifies the product suite to which the
   * transaction object belongs.
   */
  extern function new ( vmm_log log = null, string suite_name = "" );
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the transaction
   * @param suite_name A String that identifies the product suite to which the
   * transaction object belongs.
   */
  extern function new(string name = "svt_8b10b_data", string suite_name = "");
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_8b10b_data)
  `svt_data_member_end(svt_8b10b_data)

  // ---------------------------------------------------------------------------
  /**
   * Encodes an eight bit data value into its ten bit representation.  The
   * data_8bit, data_k, and data_10bit values are updated as a result of calling
   * this function.  The function returns 0 and no properties are updated if
   * Xs or Zs are passed in via the arguments.
   * 
   * @param value Eight bit value to be encoded
   * @param RD The value provided to this argument determines whether the ten bit
   * value is selected from the positive or negative disparity column.  The value
   * is updated with the disparity of the new ten bit value that is selected.  If
   * the encode operation fails then the value remains unchanged.
   * value
   */
  extern function bit encode_data( bit[7:0] value, ref bit RD);

  // ---------------------------------------------------------------------------
  /**
   * Encodes an eight bit control value into its ten bit representation.  The
   * data_8bit, data_k, and data_10bit values are updated as a result of calling
   * this function.  The function returns 0 and no properties are updated if
   * Xs or Zs are passed in via the arguments, or if the value passed in is not
   * in the 8b/10b lookup table.
   * 
   * @param value Eight bit value to be encoded
   * @param RD The value provided to this argument determines whether the ten bit
   * value is selected from the positive or negative disparity column.  The value
   * is updated with the disparity of the new ten bit value that is selected.  If
   * the encode operation fails then the value remains unchanged.
   */
  extern function bit encode_kcode( bit[7:0] value, ref bit RD);

  // ---------------------------------------------------------------------------
  /**
   * Decodes a ten bit data value into its eight bit representation.  The
   * data_8bit, data_k, and data_10bit values are updated as a result of calling
   * this function.  The function returns 0 and no properties are updated if
   * Xs or Zs are passed in via the arguments, or if the value that is passed in
   * is not in the 10b/8b lookup table.
   * 
   * @param value Ten bit value to be decoded
   * @param RD The value provided to this argument determines whether the ten bit
   * value is selected from the positive or negative disparity column.  The value
   * is updated with the disparity of the new ten bit value that is selected.  If
   * the encode operation fails then the value remains unchanged.
   */
  extern function bit decode_data( bit[9:0] value, ref bit RD);

  // ---------------------------------------------------------------------------
  /**
   * Returns the code group of the data value as a string
   */
  extern function string get_code_group();

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode ( bit on_off );

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object.
   */
  extern virtual function string get_mcd_class_name ();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff. Only
   * supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE. If protocol
   * defines physical representation for transaction then -1 does RELEVANT
   * compare. If not, -1 does COMPLETE (i.e., all fields checked) compare.
   * `SVT_DATA_TYPE::COMPLETE always results in COMPLETE compare.
   */
  extern virtual function bit do_compare ( `SVT_DATA_BASE_TYPE to, output string diff, input int kind = -1 );
`else
  // ---------------------------------------------------------------------------
  /** Override the 'do_compare' method to compare fields directly. */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
`endif

  //----------------------------------------------------------------------------
  /**
   * Checks to see that the data field values are valid, focusing mainly on checking/enforcing
   * valid_ranges constraint. Only supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE.
   * If protocol defines physical representation for transaction then -1 does RELEVANT
   * is_valid. If not, -1 does COMPLETE (i.e., all fields checked) is_valid.
   * `SVT_DATA_TYPE::COMPLETE always results in COMPLETE is_valid.
   */
  extern virtual function bit do_is_valid ( bit silent = 1, int kind = -1 );

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. If protocol
   * defines physical representation for transaction then -1 kind does RELEVANT
   * byte_size calculation. If not, -1 kind results in an error.
   * svt_data::COMPLETE always results in COMPLETE byte_size calculation.
   */
  extern virtual function int unsigned byte_size ( int kind = -1 );

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. If protocol
   * defines physical representation for transaction then -1 kind does RELEVANT
   * byte_pack. If not, -1 kind results in an error. svt_data::COMPLETE
   * always results in COMPLETE byte_pack.
   */
  extern virtual function int unsigned do_byte_pack ( ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1 );

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset. If protocol
   * defines physical representation for transaction then -1 kind does RELEVANT
   * byte_unpack. If not, -1 kind results in an error. svt_data::COMPLETE
   * always results in COMPLETE byte_unpack.
   */
  extern virtual function int unsigned do_byte_unpack ( const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1 );
`endif

  //----------------------------------------------------------------------------
  /**
   * Displays the meta information to a string. Each line of the generated output
   * is preceded by <i>prefix</i>.  Extends class flexibility in choosing what
   * meta information should be displayed.
   */
  extern virtual function string psdisplay_meta_info ( string prefix = "" );

  //----------------------------------------------------------------------------
  /**
   * Returns a string (with no line feeds) that reports the essential contents
   * of the transaction generally necessary to uniquely identify that transaction.
   *
   * @param prefix (Optional: default = "") The string given in this argument
   * becomes the first item listed in the value returned. It is intended to be
   * used to identify the transactor (or other source) that requested this string.
   * This argument should be limited to 8 characters or less (to accommodate the
   * fixed column widths in the returned string). If more than 8 characters are
   * supplied, only the first 8 characters are used.
   * @param hdr_only (Optional: default = 0) If this argument is supplied, and
   * is '1', the function returns a 3-line table header string, which indicates
   * which transaction data appears in the subsequent columns. If this argument is
   * '1', the <b>prefix</b> argument becomes the column label for the first header
   * column (still subject to the 8 character limit).
   */
  extern virtual function string psdisplay_short( string prefix = "", bit hdr_only = 0);

  // ---------------------------------------------------------------------------
  /**
   * Access to the D8b lookup tables without disparity calculations.  These are
   * added to make expressing constraints possible when VCS supports this feature.
   * 
   * @param value Value to be applied to the lookup table
   * @param disp_in Disparity column that the 10 bit value will be returned from
   */
  extern virtual function bit[9:0] lookup_D10b( bit[7:0] value, bit disp_in );

  // ---------------------------------------------------------------------------
  /**
   * Access to the K8b lookup tables without disparity calculations.  These are
   * added to make expressing constraints possible when VCS supports this feature.
   * 
   * @param value Value to be applied to the lookup table
   * @param disp_in Disparity column that the 10 bit value will be returned from
   */
  extern virtual function bit[9:0] lookup_K10b( bit[7:0] value, bit disp_in );

  // ---------------------------------------------------------------------------
  /**
   * Access to the 10b lookup tables without disparity calculations.  These are
   * added to make expressing constraints possible when VCS supports this feature.
   * 
   * @param value Value to be applied to the lookup table
   * @param disp_in Disparity column that the 8 bit value will be returned from
   */
  extern virtual function bit[8:0] lookup_8b( bit[9:0] value, bit disp_in );

  // ---------------------------------------------------------------------------
  /**
   * Returns true if the provided value is in the 10 bit lookup table.  Otherwise
   * returns false.
   * 
   * @param value Value to be tested
   * @param disp_in Optional disparity to test against.  If this value is not
   * provided, then the function returns true whether the value was found in the
   * positive or negative disparity column.
   */
  extern virtual function bit is_valid_10b( bit[9:0] value, logic disp_in = 1'bx );

  // ---------------------------------------------------------------------------
  /**
   * Returns true if the provided value is in the 8 bit control character lookup
   * table.  Otherwise returns false.
   * 
   * @param value Value to be tested
   * @param disp_in Optional disparity to test against.  If this value is not
   * provided, then the function returns true whether the value was found in the
   * positive or negative disparity column.
   */
  extern virtual function bit is_valid_K8b( bit[7:0] value, logic disp_in = 1'bx );

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val( string prop_name,
                                            ref bit [1023:0] prop_val,
                                            input int array_ix,
                                            ref `SVT_DATA_TYPE data_obj );

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
   */
  extern virtual function bit set_prop_val( string       prop_name,
                                            bit [1023:0] prop_val,
                                            int          array_ix );

  // ---------------------------------------------------------------------------
  /**
   * Simple utility used to convert string property value representation into its
   * equivalent 'bit [1023:0]' property value representation. If provided the type
   * is used by the default implementation to choose an appropriate conversion method.
   * If the type is specified as UNDEF then the the field is assumed to be an int field
   * and the string is assumed to be an ascii int representation. Derived classes can
   * extend this method to support other field representations such as strings, enums,
   * bitvecs, etc.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort. 
   *
   * @return Status indicating the success/failure of the encode.
   */
  extern virtual function bit encode_prop_val(string prop_name, string prop_val_string, ref bit [1023:0] prop_val,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * Simple utility used to convert 'bit [1023:0]' property value representation
   * into its equivalent string property value representation. If provided the type
   * is used by the default implementation to choose an appropriate conversion method.
   * If the type is specified as UNDEF then the the field is assumed to be an int field
   * and the string is assumed to be an ascii int representation. Derived classes can
   * extend this method to support other field representations such as strings, enums,
   * bitvecs, etc.
   *
   * @param prop_name The name of the property being decoded.
   * @param prop_val The bit vector decoding of prop_val_string.
   * @param prop_val_string The resulting decoded value.
   * @param typ Optional field type used to help in the decode effort. 
   *
   * @return Status indicating the success/failure of the decode.
   */
  extern virtual function bit decode_prop_val(string prop_name, bit [1023:0] prop_val, ref string prop_val_string,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

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
endclass

`ifdef SVT_VMM_TECHNOLOGY
`vmm_channel(svt_8b10b_data)
`endif

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
7BqB0OcZPynkfeAJ9Xs1ff6ELfCUSPQWwMkZKSxCHjOEMTImMmMuDRyqMjLNmQtF
zQ0g4f34TJOMvRVdXzp/rJ1Xo+51HIemzntWfDUq6dVGxqJ8RDtIKxkIhhzHNB6z
RnJrOfoVlv9eHel42swFrQpZ4xrEa0b2OJBpqnZJItPb5/Q/ZG2Yhg==
//pragma protect end_key_block
//pragma protect digest_block
dCO8+/Ml5k8zNZ/BpAAVE5poPXU=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
RdkcSYTnRJps8D2+TFQEipbTEO0=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_8B10B_DATA_SV
