
`ifndef GUARD_SVT_SPI_FLASH_ADESTO_NONVOLATILE_CONFIGURATION_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_ADESTO_NONVOLATILE_CONFIGURATION_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP Adesto Nonvolatile configuration register class.
 *  This maintains teh copy of Non Volatile fields that can be stored/reload based
 *  on requirement.
 */
class svt_spi_flash_adesto_nonvolatile_configuration_register extends svt_status;

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** SPI Status Register. */
  bit [1:0] status_register_protect = 2'b01;

  bit sector_protect = 1'b0;

  bit top_bottom = 1'b0;

  bit [3:0] block_protect = 4'b0;

  bit complement_protect = 1'b0;

  bit [3:0] security_register_lock_bits = 1'b1;

  bit quad_enable = 1'b1;

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
  `svt_vmm_data_new(svt_spi_flash_adesto_nonvolatile_configuration_register)
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
  extern function new(string name = "svt_spi_flash_adesto_nonvolatile_configuration_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_adesto_nonvolatile_configuration_register)
  `svt_data_member_end(svt_spi_flash_adesto_nonvolatile_configuration_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_adesto_nonvolatile_configuration_register.
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
  `vmm_typename(svt_spi_flash_adesto_nonvolatile_configuration_register)
  `vmm_class_factory(svt_spi_flash_adesto_nonvolatile_configuration_register)
`endif

  // ---------------------------------------------------------------------------
  /**
   *
   */
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
dILWzShgEtFPokHa/okrMvZKwreI6uGPxxFlF64+2BURm9mIvzs1A3GGJzvpCO2z
xb2NI+I+AXCTIa1BxBOP6wjy1lrHG8rPFreVFVUcA3ojHLG1MrrjWViHaOMsz/u4
3bT9oAZOMMloPFJze+PWc2ITO1KktF7+fVeQPz79u0c=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 714       )
T5rviadBQCcHuLCdwi6aVZ5vLkJnMcYHkbmzWh3kb4F3Qo3AnjigQSqocS2ko+qV
oIeWq3HZgp+Urjt6DmaveSobeMeQ46MGDtwehnTukiYeYioDRbbF5ACb7KkCvH7y
a72PljSCOCaalExfGcL5qcgqbzTSPEjmKx/3yfAz7zkY0FwLtRUuaes7upjnv1QR
zs+Ku9y1L76dczr6YQOONwx8gXen90CuEYsBRLtHpUbQHQdl3uLgv6PuidNz//V+
T0kbVHnbwh5ngHOtW2YnP9fHwOAwVFq4xyPVkpdXtNGyAGyUr2ziHaWZEiZoTqrF
iJEd64IsSzuA2UWu7yHgOvRSxf9be/YafOGy+Ck6tBJYGIKTGPWOfWCHL+RLLLbc
JEW2oMldwz0VomrsBKh6031jx3HZ5qhfnQXyvp9RRwrU2dzSa7gruq87YY+8dfjg
Tcqg8fvYUWD79bb5k0E+Lj0noJTZbPT7D33fsBjjUDGldhbGSPeegfqRkPm4FOwt
5F29f7zO3ETZPeukwgBMJ869swLFpgxe0gUFDPIQmoKfmWQ4JF0ff3RG5TOQTvZ+
H9zLNhXpSBUj+BfBWcyr/SRVBsmSqtjo2FT+bywK4GRdHUwqx99axw/f5EjYnUct
Vdh2BrG0Hcos1Y1tsqi3+fmgDO0824SJgMIApLzyHRsGtzXpaK60YSZFmisTSntD
lnE4bLYX3adTrzvIPYacmUS6YH9yFk6o9iJhb8+tVPtEZhX/pwv7dKkEZv8QbcMw
o1DG4TAXSpLGgw85yom8JzkrsJusN57qmpLPkh/EHzoHnFcdnXPYrN2aFLE1nE6v
YGjzZfOfW0k/w36keDSCVz1ngPkur/NymrFvhVWCCsRO4lPfMidwzamXG7+5DroH
0Y39yD1uU0EVSBK+NHEMW2wLxN03k5edBbF+czIQVmBocLbghsYjZfztKdxmvyaK
`pragma protect end_protected
   
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
B+gvsMiFxU0335Gd1/93GfcfaCChktry7w1ICJ98m5D7WY1EcYUDX9GT5W8lb0Fb
PV2zK09k5K/R+5etyjg+kL/161FzkhdGba4Shibe9smXbUgQQ2SLC0kfhVnWkwIl
H+yQY5l83LW/AVXyQPvviUCaDS/yTR/rmyiCNNmz6TU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11782     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_ADESTO_NONVOLATILE_CONFIGURATION_REGISTER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
T0BQocoq/5I90XDtQMBAUvq9NutLnS1TngafYHh4Pc/2J492NyVhBqPtc71XAVVC
jNL+TjjZ+QAMh/0Bmw9kLN14h7ao6QfupytiPw6+/p+L3aHikwb5D4muiImo199j
jkWV7Hp4bYLHzbTjAQd4ZXSI9dlGpbQ//gxui7ajtis=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11865     )
YBeUcM4XBUnzgcGXujSdPYdZjKAZkkcZwgGzJfNwyYsKcLjNTWmagKYS0b5hJZGn
yUMoKjr2qmBDYc1x7i/AjLyvRYR7eA9g7UKMGOg++S8dsplzAL40cL1b/jg5xPK2
`pragma protect end_protected
