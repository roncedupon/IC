//=======================================================================
// COPYRIGHT (C) 2009-2015 SYNOPSYS INC.
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

`ifndef GUARD_SVT_PATTERN_DATA_SV
`define GUARD_SVT_PATTERN_DATA_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * Data object that stores an individual name/value pair.
 */
class svt_pattern_data;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  /** Property type lables used when building the pattern data structure. */
  typedef enum {
    UNDEF,      /**< Unknown or undefined data type */
    BIT,        /**< Data corresponds to a bit value */
    BITVEC,     /**< Data corresponds to a bit vector value */
    INT,        /**< Data corresponds to an int value */
    REAL,       /**< Data corresponds to a real value */
    REALTIME,   /**< Data corresponds to a realtime value */
    TIME,       /**< Data corresponds to a time value */
    STRING,     /**< Data corresponds to a string value */
    ENUM,       /**< Data corresponds to an enum value */
    OBJECT,     /**< Data corresponds to an object */
    GRAPHIC     /**< Data corresponds to an graphic element, used for display */
  } type_enum;

  /**
   * Display control used by the automated SVT shorthand display routines
   * to recognize whether an individual field should be displayed as part
   * of the current request.
   */
  typedef enum {
    REL_DISP,  /**< Indicates field display for RELEVANT and COMPLETE display requests */
    COMP_DISP  /**< Indicates field display solely for COMPLETE display requests */
  } display_control_enum;

  /** Depth used for the SVT shorthand routines */
  typedef enum {
    NONE,  /**< Never work with the object reference (e.g., Never display it) */
    REF,   /**< Only work with the object reference (e.g., Only display whether the object is null or not) */
    DEEP   /**< Work with the entire object (e.g., Perform a deep display) or the evaluated (e.g., based on accessing the calculated 'get_<field>_val' value) value */
  } how_enum;

  /** Types of alignment during display */
  typedef enum {
    LEFT,    /**< Left aligned */
    RIGHT,   /**< Right aligned */
    CENTER   /**< Center aligned */
  } align_enum;

  // ****************************************************************************
  // General Types
  // ****************************************************************************

  /**
   * Simple struct that can be used to convey the basic 'create' elements of
   * a pattern_data instance.
   */
  typedef struct {
    string name;
    type_enum typ;
  } create_struct;

  /**
   * Simple struct that can be used to convey the basic 'set' or 'get' elements
   * of a svt_pattern_data instance.
   */
  typedef struct {
    string name;
    bit [1023:0] value;
  } get_set_struct;

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** The pattern data name. */
  string name;

  /** The pattern data value. */
  bit [1023:0] value;

  /** The pattern array_ix. */
  int array_ix;

  /** Property type */
  type_enum typ;

  /** Class name where the property is defined */
  string owner;

  /** Display control */
  display_control_enum display_control;

  /** Display depth */
  how_enum display_how;

  /** Object access depth */
  how_enum ownership_how;

  /** Title used in short display. */
  string title;

  /** Alignment used in short display. */
  align_enum alignment;

  /** Width used in short display. */
  int width;

  /** Field bit width used by common data class operations. 0 indicates "not set". */
  int unsigned field_width = 0;

  /** Type string which can be used in enumerated operrations. Empty string indicates "not set". */
  string enum_type = "";

  /**
   * Flag indicating which common data class operations are to be supported
   * automatically for this field. 0 indicates "not set".
   */
  int unsigned supported_methods_flag = 0;

  /**
   * Indicates whether the name/value pairs should be the same as (positive_match = 1)
   * or different from (positive_match = 0) the actual svt_data values when the
   * pattern match occurs.
   */
  bit positive_match = 1;

  /** Additional situational keywords */
  string keywords[$];

  /** Supplemental data about this pattern_data instance, potentially situational. */
  svt_pattern_data supp_data[$];

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_pattern_data class.
   *
   * @param name The pattern data name.
   *
   * @param value The pattern data value.
   *
   * @param array_ix Index associated with the value when the value is in an array.
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
  extern function new(string name, bit [1023:0] value, int array_ix = 0, int positive_match = 1, type_enum typ = UNDEF, string owner = "", display_control_enum display_control = REL_DISP, how_enum display_how = REF, how_enum ownership_how = DEEP);

  // ****************************************************************************
  // Utility Methods
  // ****************************************************************************

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
   * Method to do the value match, taking into account positive_match.
   *
   * @param match_value The value that should be matched against.
   *
   * @param is_found_value Indicates whether the match_value is real, representing
   * a found value, or if the field could not be found. If is_found_value == 0, then
   * the success of the match relies entirely on whether we are doing a positive
   * or negative match. In this situation a positive match will always return
   * 0, a negative match will always return 1. If is_found_value == 1, then
   * the success of the match relies entirely on whether the match_value compares
   * with this.value.
   *
   * @return Indication of whether the value match passed (1) or failed (0).
   */
  extern virtual function bit match(bit [1023:0] match_value, bit is_found_value);

  // ---------------------------------------------------------------------------
  /**
   * Method to look for a specific keyword in the keyword list.
   *
   * @param keyword The keyword to look for.
   *
   * @return Indication of whether the keyword was found (1) or not (0).
   */
  extern virtual function bit has_keyword(string keyword);

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
   * @return The real value.
   */
  extern virtual function real get_real_val();
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a realtime. Only valid if the field is of type REALTIME.
   *
   * @return The real value.
   */
  extern virtual function realtime get_realtime_val();

  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a time. Only valid if the field is of type TIME.
   *
   * @return The real value.
   */
  extern virtual function time get_time_val();

  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a string. Only valid if the field is of type STRING.
   *
   * @return The string value.
   */
  extern virtual function string get_string_val();
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for returning value as a bit vector. Valid for fields which are not of
   * type OBJECT or GRAPHIC.
   *
   * @return The bit vector value.
   */
  extern virtual function bit [1023:0] get_any_val();
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a real field value. Only valid if the field is of type REAL.
   *
   * @param value The real value.
   */
  extern virtual function void set_real_val(real value);

  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a real field value. Only valid if the field is of type REALTIME.
   *
   * @param value The real value.
   */
  extern virtual function void set_realtime_val(realtime value);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a string field value. Only valid if the field is of type STRING.
   *
   * @param value The string value.
   */
  extern virtual function void set_string_val(string value);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for setting a field value using a bit vector. Only valid if the fields which are not of
   * type OBJECT or GRAPHIC.
   *
   * @param value The bit vector value.
   */
  extern virtual function void set_any_val(bit [1023:0] value);
  
  // ---------------------------------------------------------------------------
  /**
   * Utility method for adding simple supplemental data.
   *
   * @param name Name portion of the new name/value pair.
   * @param value Value portion of the new name/value pair.
   * @param typ Type portion of the new name/value pair.
   */
  extern virtual function void add_supp_data(string name, bit [1023:0] value, svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * Utility method for adding string supplemental data to an individual property.
   *
   * @param name Name portion of the new name/value pair.
   * @param value Supplemental string value.
   */
  extern virtual function void add_supp_string(string name, string value);

  // ---------------------------------------------------------------------------
  /**
   * Utility method for accessing supplemental data.
   *
   * @param name Name of the supplemental data whose value is to be retrieved.
   * @param value Retrieved value.
   * @return Indicates whether the named supplemental data was found (1) or not found (0). This also indicates whether the 'value' is valid.
   */
  extern virtual function bit get_supp_data_value(string name, ref bit [1023:0] value);

  // ---------------------------------------------------------------------------
  /**
   * Utility method for accessing supplemental data as a string. Only valid if the supplemental data is of type STRING.
   *
   * @param name Name of the supplemental data whose value is to be retrieved.
   * @param value Retrieved string value.
   * @return Indicates whether named supplemental data of type string was found (1) or not (0).
   */
  extern virtual function bit get_supp_string(string name, ref string value);
  
  // ---------------------------------------------------------------------------
endclass
/** @endcond */

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
YM2g7KkwryKZbOK1IG2ZLiQDgdqfB6/QwYNJuw9h/KAF5b8w1jblAsWPifPjG+RZ
dJ+Wwqn/03bkQYpMoMChWI2SJtIt2DhOrMbcsvg+QmS9JGHAfAV1/4zUMx64mlJV
mCNWdyZLjANqqfxasT4bUtYyhvCYGaw4Ox23SHLPb8Y=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 8058      )
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
`pragma protect end_protected

`endif // GUARD_SVT_PATTERN_DATA_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Vq5CkoefTzPgpoPqRf4bpc95p5AALeWfN3fIQk4zgN9OEi5TGTdFBaFvfwX3LQUX
zvDwis7qItm0V4EzTS4hMPkDmUV8XsZScuGKFb1q8JKD4iNO8R6wkqs4bSAF7kax
wqx7zAkrKuGyvualfSjag+g+1YNGUWaxVvpUQlGThvc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 8141      )
6Ba4G5xEKD1F4v6zSup+EAfyNR5buherfjbdgHqPKmlvUR42DWPD27GtomYvtxaQ
mn1OLvk9ZF4BxKN3Q+gPyb1TiJxnHeQMOmTHbD7XRGG/4WDDsq2SbVvbVFwfKGfk
`pragma protect end_protected
