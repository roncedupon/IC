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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
y2ZQjGq3fd706ekvgsKQlDSe2M0Ze2zyIBIzy51y8JsGQMdkfKdoRXzItTEO2zOs
gtKYTV+N7Uq7IkxbCgpn+dztmgvQoL/s9KQcwbvUT2HakXxTAhJ6wix7bdalstlr
tuUlqMv3/CxayFUR+7uEzUZGGpHTt9a9e+54yonPmNmkrmB7atokdg==
//pragma protect end_key_block
//pragma protect digest_block
mcqN70KOkDL8U2AcvdzLcAhoq7I=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
aiD4NEetBD14S3t7wm+O6KNvA1g=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_PATTERN_SV
