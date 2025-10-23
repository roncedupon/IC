//=======================================================================
// COPYRIGHT (C) 2009-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_PATTERN_SV
`define GUARD_SVT_PATTERN_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * Simple data object for describing patterns as name/value pairs along with
 * match characteristics. In addition to the name/value information this includes
 *  - match_min and match_max
 *    - Used to define whether the match should repeat
 *    - Typical matches:
 *      - If match_min == 1 and match_max == 1 then the match must occur once and
 *        only once
 *      - If match_min == 0 and match == n for some positive n then the match
 *        is expected to occur for "up to n" contiguous instances.
 *      .
 *    .
 *  - positive_match (pattern_data)
 *    - Stored with each name/value pair this indicates whether the individual
 *      name/value pair defines a match or mismatch request.
 *    .
 *  - positive_match (pattern)
 *    - Stored with the pattern, indicating whether the overall pattern defines
 *      a match or mismatch request.
 *    .
 *  - gap_pattern
 *    - Patterns can sometimes need to describe non-contiguous sequences. In
 *      these situations the non-contiguous nature of the match must be
 *      described by defining the gaps between the desired match elements.
 *      Each gap is itself stored as a pattern, but with the gap_pattern flag
 *      set. When set to true the pattern is used to do the match, but is not
 *      stored in the match results.
 *    .
 *  .
 */
class svt_pattern;

  // ****************************************************************************
  // GeneralTypes
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** Pattern contents, consisting of multiple name/value pairs, stored as a svt_pattern_data. */
  svt_pattern_data contents[$];

  /** The minimum number of times this pattern must match. */
  int match_min = 1;

  /** The maximum number of times this pattern must match. */
  int match_max = 1;

  /** Indicates whether this is part of the basic pattern or part of a gap within the pattern. */
  bit gap_pattern = 0;

  /**
   * Indicates whether the pattern should be the same as (positive_match = 1)
   * or different from (positive_match = 0) the actual svt_data values when the
   * pattern match occurs.
   */
  bit positive_match = 1;

  /**
   * Flag that indicates that the pattern values have been populated.
   */
  bit populated = 0;

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_pattern class.
   *
   * @param gap_pattern Indicates if this is part of the pattern or a gap within the pattern.
   *
   * @param match_min The minimum number of times this pattern must match.
   *
   * @param match_max The maximum number of times this pattern must match.
   *
   * @param positive_match Indicates whether entire pattern match (positive_match == 1) or
   * mismatch (positive_match == 0) is desired.
   */
  extern function new(bit gap_pattern = 0, int match_min = 1, int match_max = 1, bit positive_match = 1);

  // ---------------------------------------------------------------------------
  /**
   * Displays the contents of the object to a string. Each line of the
   * generated output is preceded by <i>prefix</i>.
   *
   * @param prefix String which specifies a prefix to put at the beginning of
   * each line of output.
   */
  extern virtual function string psdisplay(string prefix = "");
  
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of same type.
   *
   * @return Returns a newly allocated svt_pattern instance.
   */
  extern virtual function svt_pattern allocate ();

  // ---------------------------------------------------------------------------
  /**
   * Copies the object into to, allocating if necessay.
   *
   * @param to svt_pattern object is the destination of the copy. If not provided,
   * copy method will use the allocate() method to create an object of the
   * necessary type.
   */
  extern virtual function svt_pattern copy(svt_pattern to = null);
  
  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Method to add a new name/value pair to the current set of name/value pairs
   * included in the pattern.
   *
   * @param name Name portion of the new name/value pair.
   *
   * @param value Value portion of the new name/value pair.
   *
   * @param array_ix Index into value when value is an array.
   *
   * @param positive_match Indicates whether match (positive_match == 1) or
   * mismatch (positive_match == 0) is desired.
   * 
   * @param typ Type portion of the new name/value pair.
   * 
   * @param owner Class name where the property is defined
   * 
   * @param display_control Controls whether the property should be displayed
   * in all RELEVANT display situations, or if it should only be displayed
   * in COMPLETE display situations.
   * 
   * @param display_how Controls whether this pattern is displayed, and if so
   * whether it should be displayed via reference or deep display.
   * 
   * @param ownership_how Indicates what type of relationship exists between this
   * object and the containing object, and therefore how the various operations
   * should function relative to this contained object.
   */
  extern virtual function void add_prop(string name, bit [1023:0] value, int array_ix = 0, bit positive_match = 1, svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF,
                                        string owner = "", svt_pattern_data::display_control_enum display_control = svt_pattern_data::REL_DISP,
                                        svt_pattern_data::how_enum display_how = svt_pattern_data::REF, svt_pattern_data::how_enum ownership_how = svt_pattern_data::DEEP);

  // ---------------------------------------------------------------------------
  /**
   * Specialized method for adding an bit name/value pair to the current set of name/value pairs
   * included in the pattern.
   *
   * @param name Name portion of the new name/value pair.
   * @param value Value portion of the new name/value pair.
   */
  extern virtual function void add_bit_prop(string name, bit value);

  // ---------------------------------------------------------------------------
  /**
   * Specialized method for adding an bitvec name/value pair to the current set of name/value pairs
   * included in the pattern.
   *
   * @param name Name portion of the new name/value pair.
   * @param value Value portion of the new name/value pair.
   * @param field_width Field bit width used by common data class operations. 0 indicates "not set".
   */
  extern virtual function void add_bitvec_prop(string name, bit [1023:0] value, int unsigned field_width = 0);

  // ---------------------------------------------------------------------------
  /**
   * Specialized method for adding an int name/value pair to the current set of name/value pairs
   * included in the pattern.
   *
   * @param name Name portion of the new name/value pair.
   * @param value Value portion of the new name/value pair.
   */
  extern virtual function void add_int_prop(string name, int value);

  // ---------------------------------------------------------------------------
  /**
   * Specialized method for adding a real name/value pair to the current set of name/value pairs
   * included in the pattern.
   *
   * @param name Name portion of the new name/value pair.
   * @param value Value portion of the new name/value pair.
   */
  extern virtual function void add_real_prop(string name, real value);

  // ---------------------------------------------------------------------------
  /**
   * Specialized method for adding a realtime name/value pair to the current set of name/value pairs
   * included in the pattern.
   *
   * @param name Name portion of the new name/value pair.
   * @param value Value portion of the new name/value pair.
   */
  extern virtual function void add_realtime_prop(string name, realtime value);

  // ---------------------------------------------------------------------------
  /**
   * Specialized method for adding a time name/value pair to the current set of name/value pairs
   * included in the pattern.
   *
   * @param name Name portion of the new name/value pair.
   * @param value Value portion of the new name/value pair.
   */
  extern virtual function void add_time_prop(string name, time value);

  // ---------------------------------------------------------------------------
  /**
   * Specialized method for adding a string name/value pair to the current set of name/value pairs
   * included in the pattern.
   *
   * @param name Name portion of the new name/value pair.
   * @param value Value portion of the new name/value pair.
   */
  extern virtual function void add_string_prop(string name, string value);

  // ---------------------------------------------------------------------------
  /**
   * Method to add a new name/value pair to the current set of name/value pairs
   * included in the pattern specifically for adding information about display
   * properties.
   *
   * @param name Name portion of the new attribute.
   * @param title Title portion of the attribute.
   * @param width Witdh of the attribute.
   *
   * @param alignment Type portion of the new name/value pair.
   */
  extern virtual function void add_disp_prop(string name, string title, int width, 
                                             svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF,
                                             svt_pattern_data::align_enum alignment = svt_pattern_data::LEFT);

  // ---------------------------------------------------------------------------
  /**
   * Method to copy an existing property data instance and add it to this pattern.
   *
   * @param src_pttrn Source pattern to be used to find the desired property data.
   * @param name Indicates the name of the property data instance to be found.
   *
   * @return Indicates success (1) or failure (0) of the add.
   */
  extern virtual function bit add_prop_copy(svt_pattern src_pttrn, string name);

  // ---------------------------------------------------------------------------
  /**
   * Method to copy an existing property data instance and add it to this pattern,
   * but with a new value.
   *
   * @param src_pttrn Source pattern to be used to find the desired property data.
   * @param name Indicates the name of the property data instance to be found.
   * @param value Value to be placed in the property data.
   *
   * @return Indicates success (1) or failure (0) of the add.
   */
  extern virtual function bit add_prop_copy_w_value(svt_pattern src_pttrn, string name, bit [1023:0] value);

  // ---------------------------------------------------------------------------
  /**
   * Utility method provided to simplify trimming a pattern down based on a
   * specific keyword.
   *
   * @param keyword The keyword to look for.
   * @param keyword_match Indicates whether the elements left in the pattern
   * should be those that match (1) or do not match (0) the keyword.
   */
  extern virtual function void keyword_filter(string keyword, bit keyword_match);

  // ---------------------------------------------------------------------------
  /**
   * Finds the indicated pattern data.
   *
   * @param name Name attribute of the pattern data element to find.
   *
   * @return Requested pattern data instance.
   */
  extern virtual function svt_pattern_data find_pattern_data(string name);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a real. Only valid if the field is of type REAL.
   *
   * @param name Name attribute of the pattern data element to access.
   * @param array_ix Index into value when value is an array.
   *
   * @return The real value.
   */
  extern virtual function real get_real_val(string name, int array_ix = 0);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a realtime. Only valid if the field is of type REALTIME.
   *
   * @param name Name attribute of the pattern data element to access.
   * @param array_ix Index into value when value is an array.
   *
   * @return The real value.
   */
  extern virtual function realtime get_realtime_val(string name, int array_ix = 0);

  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a string. Only valid if the field is of type STRING.
   *
   * @param name Name attribute of the pattern data element to access.
   * @param array_ix Index into value when value is an array.
   *
   * @return The string value.
   */
  extern virtual function string get_string_val(string name, int array_ix = 0);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a bit vector. Valid for fields which are not of
   * type OBJECT or GRAPHIC.
   *
   * @param name Name attribute of the pattern data element to access.
   * @param array_ix Index into value when value is an array.
   *
   * @return The bit vector value.
   */
  extern virtual function bit [1023:0] get_any_val(string name, int array_ix = 0);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a real field value. Only valid if the field is of type REAL.
   *
   * @param name Name attribute of the pattern data element to access.
   * @param array_ix Index into value when value is an array.
   * @param value The real value.
   */
  extern virtual function void set_real_val(string name, int array_ix = 0, real value);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a realtime field value. Only valid if the field is of type REALTIME.
   *
   * @param name Name attribute of the pattern data element to access.
   * @param array_ix Index into value when value is an array.
   * @param value The realtime value.
   */
  extern virtual function void set_realtime_val(string name, int array_ix = 0, realtime value);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a string field value. Only valid if the field is of type STRING.
   *
   * @param name Name attribute of the pattern data element to access.
   * @param array_ix Index into value when value is an array.
   * @param value The string value.
   */
  extern virtual function void set_string_val(string name, int array_ix = 0, string value);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a field value using a bit vector. Only valid if the fields which are not of
   * type OBJECT or GRAPHIC.
   *
   * @param name Name attribute of the pattern data element to access.
   * @param array_ix Index into value when value is an array.
   * @param value The bit vector value.
   */
  extern virtual function void set_any_val(string name, int array_ix = 0, bit [1023:0] value);
  
  // ---------------------------------------------------------------------------
endclass
/** @endcond */

// =============================================================================

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
SAQNnOmmvscT5DTlDRzZjeGoQpRNn0bNaX/SCu9Exex+awJXIbAiylBvE/L7sQVY
CAA5D+4sfXe1WZpjbgxUoyxTl4ahoXAALOW5jBI8gcr38jM6aee6gXAjzQUxsVV3
isHAwTvlhyZaB7Ld5hA0+F4xMM1kmbZuh/1wR9D1/Io=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 12540     )
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
gynDTsROzK8lgznMQhcskw==
`pragma protect end_protected

`endif // GUARD_SVT_PATTERN_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
YNy2UhtEfrHP0GuFid/a27Ac76A7xMmtJu93lz8qPII5YR11/EubTs7OyO9TyuwO
oHfbIUJqOiCl3MCtexr8WYcfiU3t08OewlNtl6FFYlRkerWf3+7kAzuXMIqIIV6k
fbGno7hBOpGTdLgQ6uUlJUDYgnjNNq5rlmMqVgdVFs4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 12623     )
H8Ash/squ6uZEWWgs8lfEmGBYDUguT5iHrnCBa5d5S7GE/yR3tj87/gDErg1RZdr
TGsx5um26wZOkWGmgvOOLUQN9znGSlGdtoOmwwVKCZKhGAEvQHMOuN1bemb4nnV9
`pragma protect end_protected
