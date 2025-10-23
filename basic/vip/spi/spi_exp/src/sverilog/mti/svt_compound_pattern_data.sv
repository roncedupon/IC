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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
KMOjJay9DCRbByWQPYWDIa1rs2bZcZdTlz1tSijZI9JP2Mw4jffJ6TxJQbRytXOx
clxFVLKzg2fOABSqMaoWVgQp+2W7gonht8KM2YGT6ruyMhj5ODgXNHmDL5OsGafx
WPYlUwwa35f/vFWGVEQHVaKiyEDNKXELbMHFElDc5no=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 7605      )
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
`pragma protect end_protected

`endif // GUARD_SVT_COMPOUND_PATTERN_DATA_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ivSi3NgQ7D5titrAvY9OXMqX1yDReSNosDU8xXF54PGXozIGsri+4FugN579XctJ
CctVjG507kBkkz0QNUThhr4jPkO521KECSmXjncHExg/fkU3kHmw+AgTgSVdUumd
WLwQXuqYmTZ4sM+fd3GkEH/iIvS8jpIw991h9wuiQjw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 7688      )
/84JGxyTA0eRw/hJk1S49i9elAin0/YE0osWOIyjco6fERZNllK8xT90sOAAUP82
DSFKMmcKO5cUmGg7DSqKHPHBGoNOpdV5vpLWyFGVTsNgQE/KAcybnv4S9OsHHtOU
`pragma protect end_protected
