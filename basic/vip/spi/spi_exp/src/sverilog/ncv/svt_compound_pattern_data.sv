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

`ifndef GUARD_SVT_COMPOUND_PATTERN_DATA_SV
`define GUARD_SVT_COMPOUND_PATTERN_DATA_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * Data object for storing an set of name/value pairs.
 */
class svt_compound_pattern_data extends svt_pattern_data;

  // ****************************************************************************
  // GeneralTypes
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** The compound set of pattern data. */
  svt_pattern_data compound_contents[$];

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_compound_pattern_data class.
   *
   * @param name The pattern data name.
   *
   * @param value The pattern data value.
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
  extern function new(string name, bit [1023:0] value, int array_ix = 0, int positive_match = 1, svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF, string owner = "",
                      display_control_enum display_control = REL_DISP, how_enum display_how = REF, how_enum ownership_how = DEEP);

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

  // ---------------------------------------------------------------------------
  /**
   * Method to add a pattern data instance to the compound pattern data instance.
   *
   * @param pd The pattern data instance to be added.
   */
  extern virtual function void add_pattern_data(svt_pattern_data pd);

  // ---------------------------------------------------------------------------
  /**
   * Method to add multiple pattern data instances to the compound pattern data instance.
   *
   * @param pdq Queue of pattern data instances to be added.
   */
  extern virtual function void add_multiple_pattern_data(svt_pattern_data pdq[$]);

  // ---------------------------------------------------------------------------
  /**
   * Method to delate a pattern data instance, or all pattern data instances, from
   * the compound pattern data instance.
   *
   * @param pd The pattern data instance to be deleted. If null, deletes all pattern
   * data instances.
   */
  extern virtual function void delete_pattern_data(svt_pattern_data pd = null);

  // ---------------------------------------------------------------------------
  /**
   * Extensible method for getting the compound contents.
   */
  extern virtual function void get_compound_contents(ref svt_pattern_data compound_contents[$]);

  // ---------------------------------------------------------------------------
  /**
   * Copies this pattern data instance.
   *
   * @param to Optional copy destination.
   *
   * @return The copy.
   */
  extern virtual function svt_pattern_data copy(svt_pattern_data to = null);
  
  // ---------------------------------------------------------------------------
  /**
   * Returns a simple string description of the pattern.
   *
   * @return The simple string description.
   */
  extern virtual function string psdisplay(string prefix = "");
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a real. Only valid if the field is of type REAL.
   *
   * @param array_ix Index into value array.
   *
   * @return The real value.
   */
  extern virtual function real get_real_array_val(int array_ix);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a realtime. Only valid if the field is of type REALTIME.
   *
   * @param array_ix Index into value array.
   *
   * @return The realtime value.
   */
  extern virtual function realtime get_realtime_array_val(int array_ix);

  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a string. Only valid if the field is of type STRING.
   *
   * @param array_ix Index into value array.
   *
   * @return The string value.
   */
  extern virtual function string get_string_array_val(int array_ix);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a bit vector. Valid for fields which are not of
   * type OBJECT or GRAPHIC.
   *
   * @param array_ix Index into value array.
   *
   * @return The bit vector value.
   */
  extern virtual function bit [1023:0] get_any_array_val(int array_ix);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a real field value. Only valid if the field is of type REAL.
   *
   * @param array_ix Index into value array.
   * @param value The real value.
   */
  extern virtual function void set_real_array_val(int array_ix, real value);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a realtime field value. Only valid if the field is of type REALTIME.
   *
   * @param array_ix Index into value array.
   * @param value The realtime value.
   */
  extern virtual function void set_realtime_array_val(int array_ix, realtime value);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a string field value. Only valid if the field is of type STRING.
   *
   * @param array_ix Index into value array.
   * @param value The string value.
   */
  extern virtual function void set_string_array_val(int array_ix, string value);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a field value using a bit vector. Only valid if the fields which are not of
   * type OBJECT or GRAPHIC.
   *
   * @param array_ix Index into value array.
   * @param value The bit vector value.
   */
  extern virtual function void set_any_array_val(int array_ix, bit [1023:0] value);
  
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
tuExVi/k9nlJvbY54xLKNeVI1e94RP6Qd/M8hkzl1Fg3rGFdEWqBMJCFfY0SFrxn
rnRKQ40iZxF26/obU+o2AFlusHzcojiFLxkL79ZAMTqf557tFo4TKTtkl5vXNaQo
KZ8b8QnoixKWkCZxRKFnh4x3ZVjQIITFsiind2NYYSGy7O6B+0vGQA==
//pragma protect end_key_block
//pragma protect digest_block
HYNqR+0MnnD7dhU7W93fESMxgXE=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
0KIBlru4s0SRe+sPQ6JS9TiQWcM=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_COMPOUND_PATTERN_DATA_SV
