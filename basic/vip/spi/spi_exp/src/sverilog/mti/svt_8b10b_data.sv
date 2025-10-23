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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
CFUYBcThYtGuZzjwFh2H4Ziz6skBf57s5TFd9EpT8C8ZUNpxN53V7C45ptEakaYt
nmW1idKPVlnIXmXhHRYD+0vyM86tR720JlS71pfHjbEEaSctceyl6pAF/iqkgWp9
Rmd+RFj5+tZ8fqLpe8Ly1pUQhspirTu6Q3nEqCY2Npg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 46292     )
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
`pragma protect end_protected

`endif // GUARD_SVT_8B10B_DATA_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
bygYSkdOW9py5d5cQZTqWef0xvIVLnS6O2XRuFdNvjEyCEBRXbE0rVoslEM67o8g
/WD2o/qF1wGv1t3qRbc+zUHp7LIKXOMnChXS4SA7EBbKXas9s574e2lNSUI8AIQG
XGV3UGQpG6wLrKt+12/hdlpGB5fei4rnZrYoe6rZ534=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 46375     )
HvJQvec2bn1xrPECL79yRR1APIofzxzDiulWvOHu7sx3X+SoYitKxB5FcVGeXgDB
iH2JWeX38VYBD27InWDzHkZyGRUNHdjVBS8IOZz2V6fmD3XY2hnEioF86FK/3obR
`pragma protect end_protected
