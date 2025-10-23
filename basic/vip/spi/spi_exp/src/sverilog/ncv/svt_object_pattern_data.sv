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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
JcNc0yd6BX9PE/qVSKmjPtQCWOl8R9mq9rWy406flW07fJnDvxGSqgPrs6l94kxo
98/nzjvSuI6D8MIybCVoxfv/NRdsJBkW46q7Ed5XbU1Y4Qtx/BmbfHywF2U1of9Y
eP8XkCtELv1lW7kOwGM0GNgi5GRK6LMQtBki9Ny0cBSXiSiO/DIXSw==
//pragma protect end_key_block
//pragma protect digest_block
mnvDGj5dsh/gXOKPJPMQAMMu3xI=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
lLB1wirf/WMC3aU3EYVhuU86Tzw=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_OBJECT_PATTERN_DATA_SV
