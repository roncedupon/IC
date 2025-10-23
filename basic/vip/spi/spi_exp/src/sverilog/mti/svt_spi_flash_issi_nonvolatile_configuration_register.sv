
`ifndef GUARD_SVT_SPI_FLASH_ISSI_NONVOLATILE_CONFIGURATION_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_ISSI_NONVOLATILE_CONFIGURATION_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP ISSI Nonvolatile configuration register class.
 *  This maintains the copy of Non Volatile fields that can be stored/reload based
 *  on requirement.
 */
class svt_spi_flash_issi_nonvolatile_configuration_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** SPI Read Register. */
  bit reset_hold_enable = 1'b0;
  bit [3:0] dummy_cycles = 8'h00;
  bit wrap_enable = 1'b0;
  bit [1:0] burst_length = 2'b0;

  /** SPI Extended Read Register. */
  bit [2:0] output_driver_strength = 8'h00;

  /** SPI Bank Address Register. */
  bit extended_address = 1'b0;
  bit bank_address = 2'b0;

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_spi_flash_issi_nonvolatile_configuration_register)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new status instance, passing the appropriate 
   * argument values to the parent class.
   *
   * @param log VMM log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new status instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the status.
   */
  extern function new(string name = "svt_spi_flash_issi_nonvolatile_configuration_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_issi_nonvolatile_configuration_register)
  `svt_data_member_end(svt_spi_flash_issi_nonvolatile_configuration_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_issi_nonvolatile_configuration_register.
   */
  extern virtual function vmm_data do_allocate();
`endif

  //----------------------------------------------------------------------------
  /**
   * Does a basic validation of this status object.
   *
   * @param silent bit indicating whether failures should result in warning messages.
   * @param kind This int indicates the type of is_avalid check to attempt. 
   */ 
  extern virtual function bit do_is_valid(bit silent = 1, int kind = RELEVANT);


`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Pack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_pack(`SVT_XVM(packer) packer);

  // ---------------------------------------------------------------------------
  /**
   * Unpack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_unpack(`SVT_XVM(packer) packer);
`endif

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation.
   *
   * @param kind This int indicates the type of byte_size being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in a size calculation based on the
   * non-static fields. All other kind values result in a return value of 0.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset, based on the
   * requested byte_pack kind.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset, based on
   * the requested byte_unpack kind.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is svt_data::COMPLETE, which results in all of the
   * non-static fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the exception contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif

  //----------------------------------------------------------------------------
  /**
   * This method is used by a component's command interface, to allow command
   * code to retrieve the value of a single named property of a data class derived from this
   * class. If the <b>prop_name</b> argument does not match a property of the class, or if the
   * <b>array_ix</b> argument is not zero and does not point to a valid array element,
   * this function returns '0'. Otherwise it returns '1', with the value of the <b>prop_val</b>
   * argument assigned to the value of the specified property. However, If the property is a
   * sub-object, a reference to it is assigned to the <b>data_obj</b> (ref) argument.
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

  //----------------------------------------------------------------------------
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
   * Simple utility used to convert string property value representation into its
   * equivalent 'bit [1023:0]' property value representation. Extended to support
   * encoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort.
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit encode_prop_val(string prop_name, string prop_val_string, ref bit [1023:0] prop_val,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * Simple utility used to convert 'bit [1023:0]' property value representation
   * into its equivalent string property value representation. Extended to support
   * decoding of enum values.
   *
   * @param prop_name The name of the property being encoded.
   * @param prop_val_string The string describing the value to be encoded.
   * @param prop_val The bit vector encoding of prop_val_string.
   * @param typ Optional field type used to help in the encode effort.
   *
   * @return The enum value corresponding to the desc.
   */
  extern virtual function bit decode_prop_val(string prop_name, bit [1023:0] prop_val, ref string prop_val_string,
                                              input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  //----------------------------------------------------------------------------
  /**
   * This method allocates a pattern containing svt_pattern_data instances for
   * all of the primitive data fields in the object. The svt_pattern_data::name
   * is set to the corresponding field name, the svt_pattern_data::value is set
   * to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

  // ---------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_flash_issi_nonvolatile_configuration_register)
  `vmm_class_factory(svt_spi_flash_issi_nonvolatile_configuration_register)
`endif

  // ---------------------------------------------------------------------------
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);

  // ---------------------------------------------------------------------------
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
NFUwkBnYdyKIuzHpI5LKqKmOPGz0Ob+v3LMDIHtszVNO80R2+rlnCMdVUq6hLhph
xKkxT6EeugBoUdMhkF5TBQHPhJ3r0hN00Gtu2+uiRjCl288wudvxqWp561qXIqhO
8W3tlB6EwamtXRxNLQYUkMLYdlHfhj74UOrpuNnNFWw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 706       )
polv7RlYTDzlir3TxZXRWYbBYE4p6vWCudGzGqu9T6hTLO0iWXqYR1Bd2zenXiS0
UHGb8IeZO19YtTvl43XXSvnAl/1QLyOJwg5nIC0BEIZWG3SwrUTBWIll+faji3D5
kF/6nn6QuHRNi/UBAL0oX38lClhtYbgwInRig/4h8CylOjmz02bj5fZLccOvaz8D
va3JjgTHPnW1qW+M6nSmggSyUj9czwghgH0442f2vdd3sl9t4aeeHrfU5DUlyEEE
ZW+F9YBjVDsWUg/LWW8b1WUdJbDOLJpXZNeix+EOKXiLuuPPPOBa3/eF32NUtSAt
yz3+ZRd5QYZ+D8azNlibf+InuXYoTrKycjnfitTiKmvqTmnFRfRxr4YClTNFptTw
icm5jcibfvjtQ+OikKGgdyKgQ/P3+Duy5b5uQq8vsy94IKQE03P3ElmOp+tu8rkM
p8fBod6JhT8jDDsiZj0nCXlz9ru0WsNsdFBPmwoHkIr6fyq79eC/yOkreQm4s9OZ
J/enKioiDNjk/IEEm0w7/pkyLPmhJoSa1r1oV3j9Q78ou08aL/cdxBFu+n0QwlQ6
PFatgaQQwA/3G2//ny/JNee2GHW6I13hZ1gA3cFPceke4YCrDfOs7l7bo2iw6kPW
4eqwIm/dSeBHU8YqPXDmFwniDVQ1m69aYnI2GBxFRlKnd9mFQe6iSCVTZI0apQpN
bvCRyfrSO6PwjwefGXrz1cQKnzPMOXExga13bI+d6ZHg3HLeIZn6vvACsA3X79at
CtlU6gF0OTYT/Aqws+0NjFEhEX3AxcaLx1pGmrmzISq0JUWPqcblos1EAOV7M7rr
ZKzKPoszUvCoYi/d2qsoSE683XY/KYpTPQNR09BGU3GUnz6CAmo2rPAoOQmuvYvq
11P7s4mX7dzGE4J1USbpQSHSX3qX43tuPK019E1RoJIMrLBqRZ3RERp/RCN9JVks
`pragma protect end_protected
   
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
e9EeLh0VADHuU0fBRhKVlNSIhAC/4mxJoBLIoRj3Tu26dO32zxhPHaMyeZlJWp8t
xAs9tnxZw1wZ39WikSQfXGSDWzbtU6uSLhn4vKRRKWsQ0ri/ZMhz8cBoGnDfXmzD
FgpxtbRhV4knJTCJORFgc3n2185pDor9gIRvnSK2AAo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11760     )
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
uOlw2GMQhNbOdQ/yJfYlfQ==
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_ISSI_NONVOLATILE_CONFIGURATION_REGISTER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
iJ4EmVOF9hg9X8DY26S2ynSsKw0op12tve0Fm0I91YqcZQqm575BDVUqOCGDKthd
dJlnTbOhxire8W0VECjS6QSWTuViuqAC7sW3LdGwC5mqFVBu5tQFBMHH2XzgxhQ5
nhU1zAJXl7wo9t39A9IN5vBlh8RQEcot7czK8nDcaXQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11843     )
Xg1zpqJAPCVRjrnz/r1Zb2DeAL6uho98vk9XYGnDRqZvRrg3AOj9Hn3OGwSKma6L
lT9Oe/tUR+ZhVRy2ufCKea8b7yYqbyP71pG5ItdB+mdy0yjfbQKHy+RkR9g61/ce
`pragma protect end_protected
