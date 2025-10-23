
`ifndef GUARD_SVT_SPI_FLASH_MICRON_NONVOLATILE_CONFIGURATION_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_MICRON_NONVOLATILE_CONFIGURATION_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP 'top level' status class.
 */
class svt_spi_flash_micron_nonvolatile_configuration_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  bit [7:0] dummy_cycles = 8'h0;

  bit [7:0] xip_mode = 8'hFF;

  bit [7:0] output_driver_strength = 8'hFF;

  bit enable_dtr_protocol_n = 1'b1;

  bit reset_hold_enable = 1'b1;

  bit quad_protocol = 1'b1;

  bit dual_protocol = 1'b1;

  bit address_segment = 1'b1;

  bit address_bytes = 1'b1;

  bit [7:0] wrap_mode_reg = 8'hFF;

  bit[7:0] io_mode = 8'hFF;
  
  bit [15:0] register_value; 

  /** SPI Agent configuration handle */
`ifdef SVT_VMM_TECHNOLOGY
  svt_spi_group_configuration spi_agent_cfg;
`else
  svt_spi_agent_configuration spi_agent_cfg;
`endif  

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
  `svt_vmm_data_new(svt_spi_flash_micron_nonvolatile_configuration_register)
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
  extern function new(string name = "svt_spi_flash_micron_nonvolatile_configuration_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_micron_nonvolatile_configuration_register)
  `svt_data_member_end(svt_spi_flash_micron_nonvolatile_configuration_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_micron_nonvolatile_configuration_register.
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

  extern virtual function bit [15:0] get_register_value(int addr=0);
  extern virtual function void set_register_value( bit [15:0] reg_val=16'h0, int addr=0 );
  extern virtual function void set_cfg(svt_configuration cfg);
  // ---------------------------------------------------------------------------
`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_flash_micron_nonvolatile_configuration_register)
  `vmm_class_factory(svt_spi_flash_micron_nonvolatile_configuration_register)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JgqBbXiMIVFtZ5MJldv4gK+B7EWtZs7qWpFrEJImQTXhTDUh5lmBadywIERC3Yqc
0nJK0FPuxgPYPszXZNWrHFurGUwhlmkkjJowg1Jw52dAYO/r93gjq3P0ech9LvZG
/S0PsqQCQxJ15/L/l1fPXamfX71Es7ihsDLMwtmFZkw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1028      )
aO9cm+do6UhsYNSru+cXrglx2clbHRun15jq10mdw03u/BzEXSEAdpkmOJb9qsoE
d/AqQ/Jzpy0SwFgntYO7vkpJ5plB01m+7OK1qH9IYjFilINNh5s8ZMjKD65jI/i2
GF6r87RCnR6YzuJDI//bGmrBPrpM4tXFLBmsyjSbtvPGb3vKzWo1JmSmyLgFXUK3
34Rr4WQ9IqUUy/dlLx5XH5JW6Mfl1UUW1r3q+aZEvWeoVtIKUn4Y/DmmeJjFoF1q
PR9FBfPJKtFgqQvfNqENF6kCokO0oFdHWp8Xu3BVOxtL+wytsF3jH2vx5eSN0TiK
xtHDAT9mvUoZrH2a/Q0Vb1tSkkyK/nq0900mLyhhFNh004OwGTiN2yJ3IyUll7V4
h6WS4lF/xop1hu7ETr5VB3mbf9orlAvhCfrMLC3BFRphVUObyQ6sJgK16rINkDPE
uziaBVwvWQDAkslBHq97Fz6++5BfipC2fO4KqokGrYlQjeYPC6n+rxUULKMgSwFv
qmTTp1E89UcwmaaNHtmMtuVjp3SDSwjFX0ZeT4t9NB4JWV4sCjDFjHydeavjWVTi
jS8ocazs3Rk7VW3BK8WNu7MdkWO1KVo9Bfiz4hPjpAwhhHoAL3ztcV/a4Sjtof9t
Tai+/n0Rwh6Tt+wyvR5Sg97HLEDQevs/jck33+z5KINFuf5Xith/04X1NaJqlQZe
yw4LBG7ptIVKjyGQyM1rXQXPPVN/bJOuP2cCkYq/zvfxmyI3BQ4E4r9vD74hr+Ym
HCxbHEecp6yh9dBsEKY+uJiLHaTDyDrbtrX+eCZqqE0GKgywFwegGRJHP2H5NBIm
X8MPLqPXIEUkTZbQfz0cWFcEekjM9vEarMF+tt9UwrKCvEhPtD3Mzye3wK7BQwVj
y1VAwzTsDFcOi26MUdpOL/1YVwI9lGtWZ/jfOuWBMxqKKyVpPAdZn+5gX2HemOPm
zdrPk9fLX4SAWddq1YdvnF1lg+vsZV+jLTRYmASYSFntLHXYipIxRpe9MUl0iTxR
Jxcdh5i51cRgbachHMb8GeUWAckK4osw5SnOjMBLHt1HaJIxRviOVtvjk4Yi4k34
K7snTDNP5ugEs2NaVCqREkHbLFkGTuQ3ChphE6Ld2AJE71FKb5PSoP8deJoIfyh1
XGq0VF66Er5XbPdd8FeCu5bo/xr8TMJ5fVkHBlEP9XBIKIVsE8bg6trCofEPDc2q
78BodkRqvwjlwXgQP5Co0XJQgsTmbGxCtUEDuXigbCS5tf3C3dWE9jIIHE6ZjKOC
cdXnn4YHM5aviE30m2IpLfDR7ufSbp2368SZB+rgG4aF5GV5fXogbCiz4XDAp5/+
G3ILwVfhNkTXH7nvNOyQroh+4gSCpgi3BZi/adIOax0=
`pragma protect end_protected
   
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
COQCzDBctYWs5KA61/DF3UH55JgB6kTXtqwF1PfTz6rOP0Gmwexh5dL2Q8KCIjBU
2dC0v5Q0YUzplyXmdPGopEG89PRb5zg1Dru8nW3BpI8exO+EOEoIaO3s8zg2RfFX
N9NpJhg23yu/zgwfAqcyTv90ksUmO7Dt9Praa/eYfZk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 16474     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_MICRON_NONVOLATILE_CONFIGURATION_REGISTER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
YF1OQRMI6L5tG1jaEO/id5GEhRzkAAQWQN8iPCLtaaDyN00o995CLEVFIqveAZiI
a2qGy8bXeldOqmgrHicmgphLqptjAthgoP6aIqrIn3W82lNKc5fK78ve7bcdXWbC
kddOG1iqbfpoYWTZvowIMtkOKXpp5YEync2UU4flV8w=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 16557     )
iQVfHXRq+cHRFWQPEhnu6ZFuSCQqAY8RQ20gLEgkytVvGsFUl6sbBpLEGGfRAcdD
24sgzEjRcAXfrQ9GushSHL2+Ue4FZMgtXPmjme1M1QuA3xt4qS5ZejT9MIJJnY3K
`pragma protect end_protected
