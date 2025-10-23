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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
lIPQL0tcID6ayAFLYsc/NqBus26UW1MJxVqgqgG6I08syFVAkR3DSb/CA9CiQgHL
Y6sSCynvq7GF41905U72P1fF6lR2wLsI7OShSDoucjFYGQGo+T4PBk5eS0oDicK3
EfYZBkL0HRa3ikZjI1BDqQS1Y+yeKUGPySPBx/0JZko=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11665     )
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
+nAL6eBTLuFN+ofFaxaUZQ==
`pragma protect end_protected

`endif // GUARD_SVT_PATTERN_DATA_CARRIER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
gPEYbOODreXNepR8Fv2XpJu+ayTnNLTlNFoo2mAMZ79WOR0XMYquc54kMg/g4JsQ
iMO2EakkobD3QckEqDvt7NpFzkpguPZPI0uAwAZg/qRsobzI6tFTltWS767BZ/Q9
WeOUESVZIbEWguK6bkCcCjxF671SHFp4XxYuaW22RrA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11748     )
I36pBaC+rkiXLtUK+odeJChI6XlTvRZ5KwwUErBVTZzEnJ/Xz7cVzGGmp6KL9ERx
LDhjoF9aV5U0wOb8/jUETyeZTwg7snIQTElOrkL4azsyIs3b3spWFPUGJFUihtbH
`pragma protect end_protected
