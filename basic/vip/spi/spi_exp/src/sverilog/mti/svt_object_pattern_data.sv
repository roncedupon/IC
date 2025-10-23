//=======================================================================
// COPYRIGHT (C) 2015 SYNOPSYS INC.
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

`ifndef GUARD_SVT_OBJECT_PATTERN_DATA_SV
`define GUARD_SVT_OBJECT_PATTERN_DATA_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * Data object that stores an individual name/value pair, where the value is
 * an `SVT_DATA_TYPE instance.
 */
class svt_object_pattern_data extends svt_compound_pattern_data;

  // ****************************************************************************
  // GeneralTypes
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  /** The object stored with this pattern data instance. */
  `SVT_DATA_TYPE obj;

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_object_pattern_data class.
   *
   * @param name The pattern data name.
   *
   * @param obj The pattern data object.
   *
   * @param array_ix Index associated with the object when the object is in an array.
   *
   * @param positive_match Indicates whether match (positive_match == 1) or
   * mismatch (positive_match == 0) is desired.
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
  extern function new(string name, `SVT_DATA_TYPE obj, int array_ix = 0, int positive_match = 1, string owner = "",
                      display_control_enum display_control = REL_DISP, how_enum display_how = REF, how_enum ownership_how = DEEP);

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

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
  
endclass
/** @endcond */

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
EbXhsPslVyphz8Y3/EjYcabNampEvvg8YStnQfZFf+n8IGgAA81J2BCI0W5Um2QM
TL6D8wphcWB/7ccJpUzGf8xEYOUj9FSXtalz6SQcgb0kWMlzpApvTqaEVbpsWDuT
vEmiccVrckyVh73hOhR/8EoDWPMK7YUc583ROhL5htg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2363      )
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
3vioTRhFNIWK27wZx1VDkg==
`pragma protect end_protected

`endif // GUARD_SVT_OBJECT_PATTERN_DATA_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
pFy7xZ+UIYxZK/bY6eyHJEh+I8xYBUCapeaW7ldGh3hw+ISutU/bYs2m8fK39OsQ
cLIAhNMxUt0ulgIiqHlu2992OcKyO216bpeIfDsUW5jvLmXRe+qDz1+IKdZe6GnI
Xt7MIpgh5kAsas1mnPzyx8BSPzBTFWtXNx3EIrcx34M=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2446      )
HtKukvXCICsXGTUJM8mwaZvo2WwAyFE9hPP6kLrUc0u/D3w5GMdb1zr91AVK+NQV
f+dKZZ7aNKMSBxlT6gRFgHPvCqQt9Rue1ezz6BaBPUMu6LiDt+GJSPf6SoFAwhyr
`pragma protect end_protected
