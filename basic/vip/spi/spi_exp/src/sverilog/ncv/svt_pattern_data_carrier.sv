//=======================================================================
// COPYRIGHT (C) 2015-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_PATTERN_DATA_CARRIER_SV
`define GUARD_SVT_PATTERN_DATA_CARRIER_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * The svt_pattern_data carrier is used to gather up properties so that they can
 * be acted upon as a group. 
 */
class svt_pattern_data_carrier extends `SVT_DATA_TYPE;

  // ****************************************************************************
  // GeneralTypes
  // ****************************************************************************

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** The properties which have been stored in the carrier. */
  svt_pattern_data contents[$];

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_data)
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_pattern_data_carrier class.
   *
   * @param log A vmm_log object reference used to replace the default internal logger.
   * @param field_desc Shorthand description of the fields to be created in the carrier.
   */
  extern function new(vmm_log log = null, svt_pattern_data::create_struct field_desc[$] = '{});
`else
  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_pattern_data_carrier class.
   *
   * @param name Instance name for this object
   * @param field_desc Shorthand description of the fields to be created in the carrier.
   */
  extern function new(string name = "svt_pattern_data_carrier_inst", svt_pattern_data::create_struct field_desc[$] = '{});
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_pattern_data_carrier)
  `svt_data_member_end(svt_pattern_data_carrier)

  // ---------------------------------------------------------------------------
  /** Returns the name of this class, or a class derived from this class. */
  extern virtual function string get_class_name();
  
  // ---------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow command
   * code to retrieve the value of a single named property of a data class derived from this
   * class. If the <b>prop_name</b> argument does not match a property of the class, or if the
   * <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1', with the value of the <b>prop_val</b>
   * argument assigned to the value of the specified property. However, If the property is a
   * sub-object, a reference to it is assigned to the <b>data_obj</b> (ref) argument.
   * In that case, the <b>prop_val</b> argument is meaningless. The component will then
   * store the data object reference in its temporary data object array,
   * and return a handle to its location as the <b>prop_val</b> argument of the <b>get_data_prop</b>
   * task of the component. The command testbench code must then use <i>that</i>
   * handle to access the properties of the sub-object.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val A <i>ref</i> argument used to return the current value of the property,
   * expressed as a 1024 bit quantity. When returning a string value each character
   * requires 8 bits so returned strings must be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @param data_obj If the property is not a sub-object, this argument is assigned to
   * <i>null</i>. If the property is a sub-object, a reference to it is assigned to
   * this (ref) argument. In that case, the <b>prop_val</b> argument is meaningless.
   * The component will then store the data object reference in its temporary data object array,
   * and return a handle to its location as the <b>prop_val</b> argument of the <b>get_data_prop</b>
   * task of the component. The command testbench code must then use <i>that</i>
   * handle to access the properties of the sub-object.
   * @return A single bit representing whether or not a valid property was retrieved.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow
   * command code to set the value of a single named property of a data class derived from
   * this class. This method cannot be used to set the value of a sub-object, since sub-object
   * construction is taken care of automatically by the command interface. If the <b>prop_name</b>
   * argument does not match a property of the class, or it matches a sub-object of the class,
   * or if the <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1'.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_val The value to assign to the property, expressed as a 1024 bit quantity.
   * When assigning a string value each character requires 8 bits so assigned strings must
   * be 128 characters or less.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @return A single bit representing whether or not a valid property was set.
   */
  extern virtual function bit set_prop_val(string prop_name, bit [1023:0] prop_val, int array_ix);

  // ---------------------------------------------------------------------------
  /**
   * Method to assign multiple values to the corresponding named properties included
   * in the carrier.
   *
   * @param prop_desc Shorthand description of the fields to be modified.
   * @return A single bit representing whether or not the indicated properties were set successfully.
   */
   extern virtual function bit set_multiple_prop_vals(svt_pattern_data::get_set_struct prop_desc[$]);

  // ---------------------------------------------------------------------------
  /**
   * This method allows clients to assign an object to a single named property included
   * in the carrier's contents.
   *
   * @param prop_name The name of a property in this class, or a derived class.
   * @param prop_obj The object to assign to the property, expressed as `SVT_DATA_TYPE instance.
   * @param array_ix If the property is an array, this argument specifies the index being
   * accessed. If the property is not an array, it should be set to 0.
   * @return A single bit representing whether or not a valid property was set.
   */
  extern virtual function bit set_prop_object(string prop_name, `SVT_DATA_TYPE prop_obj, int array_ix);

  // ---------------------------------------------------------------------------
  /**
   * Since for do_allocate_pattern this class simply returns its own contents
   * field the expectation is that this will be processing a pattern made up of the
   * original carrier contents. Implying that it already has the values.
   *
   * If a simple check validates this to be the case, this method basically just
   * returns as the values are already contained in contents.
   *
   * If the check indicates there are differences with contents then this
   * implementation simply calls the super to let it load up the values.
   *
   * @param pttrn Pattern to be loaded from the data object.
   *
   * @return Success (1) or failure (0) of the get operation.
   */
  extern virtual function bit get_prop_val_via_pattern(ref svt_pattern pttrn);

  // ---------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  // ---------------------------------------------------------------------------
  /**
   * This method modifies the object with the provided updates and then writes
   * the resulting property values associated with the data object to an
   * FSDB file.
   * 
   * @param inst_name The full instance path of the component that is writing the object to FSDB
   * @param parent_object_uid Unique ID of the parent object
   * @param update_desc Shorthand description of the primitive fields to be updated in the carrier.
   *
   * @return Indicates success (1) or failure (0) of the save.
   */
  extern virtual function bit update_save_prop_vals_to_fsdb(string inst_name,
                                                     string parent_object_uid = "",
                                                     svt_pattern_data::get_set_struct update_desc[$] = '{});

  // ****************************************************************************
  // Pattern/Prop Utilities
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
   * @param array_ix Index associated with the value when the value is in an array.
   *
   * @param typ Type portion of the new name/value pair.
   */
  extern virtual function void add_prop(string name, bit [1023:0] value = 0, int array_ix = 0,
                                        svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * Method to add multiple new name/value pairs to the current set of name/value pairs
   * included in the pattern.
   *
   * @param field_desc Shorthand description of the fields to be created in the carrier.
   */
  extern virtual function void add_multiple_props(svt_pattern_data::create_struct field_desc[$]);

  // ---------------------------------------------------------------------------
  /**
   * Utility method for adding simple supplemental data to an individual property.
   *
   * @param prop_name Name of the property that is to get the supplemental data.
   * @param name Name portion of the new name/value pair.
   * @param value Value portion of the new name/value pair.
   * @param typ Type portion of the new name/value pair.
   */
  extern virtual function void add_supp_data(string prop_name, string name, bit [1023:0] value, svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * Utility method for accessing supplemental data on an individual property.
   *
   * @param prop_name Name of the property to be accessed.
   * @param name Name of the supplemental data whose value is to be retrieved.
   * @param value Retrieved value.
   * @return Indicates whether the named supplemental data was found (1) or not found (0). This also indicates whether the 'value' is valid.
   */
  extern virtual function bit get_supp_data_value(string prop_name, string name, ref bit [1023:0] value);

  // ---------------------------------------------------------------------------
  /**
   * Utility method for adding string supplemental data to an individual property.
   *
   * @param prop_name Name of the property that is to get the supplemental data.
   * @param name Name portion of the new name/value pair.
   * @param value Supplemental string value.
   */
  extern virtual function void add_supp_string(string prop_name, string name, string value);

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
hyl7HFp2fErSQRtwJFhWnYcRowQjUKN61sXQRy9gVH1An5NUiVg6/0gnQ4VocEKz
Pq3143VqvVCmCfGcxUSiIOP7oif8X4r5ie3bSvQ9gynGLrupdGJNvVUulu5LCK61
N1aM7eGiDqNRkAnpQIWNMCFLQ8NTTpTwpClhDNWXKWbGmFDHVWrfvg==
//pragma protect end_key_block
//pragma protect digest_block
bCXQKy4Rx5HJI8LejNweRP+gL8s=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
EialoRnmMBgfLUkXR1xJD8/6748=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_PATTERN_DATA_CARRIER_SV
