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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
yj/9J+sxegeiaEuSWUOiLO+v2BrLQZvyBkKHy9QSlmgFTCtyPI/anD5G+fhNKuTN
rqpuSHDMrFqwtOS9ImWP+YcqEryJgdk3M6Zu3upRrV7g5mZLCJ7nkcZJDzzAC3HY
jtsmf3vaRmMQbzjnG3UPXjupEN0mp/FMSWzfK/QmIlQOG6NRi2MLrQ==
//pragma protect end_key_block
//pragma protect digest_block
xo+pSjnq52nScE6RbXqVEKjTSpU=
//pragma protect end_digest_block
//pragma protect data_block
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
kMYD/T3XVev14c6bIiJqXg==
//pragma protect end_data_block
//pragma protect digest_block
gSt2q4qkuLWR6wJpCG2jIjYpHpw=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_PATTERN_DATA_SV
