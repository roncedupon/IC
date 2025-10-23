
`ifndef GUARD_SVT_SPI_xSPI_FLASH_COMMAND_REGISTER_MAP_SV
`define GUARD_SVT_SPI_xSPI_FLASH_COMMAND_REGISTER_MAP_SV
// =============================================================================
/**
 *  This is the SPI VIP xSPI flash command register map class. <br/>
 *  It specifies flash command and address frame required to access specifie register.<br/>
 */
class svt_spi_xSPI_flash_command_register_map extends svt_configuration;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------
  
  /** 
   * This field along with #address_frame_list specifies flash command/address frame(if applicable) <br/> 
   * pair required to access xSPI register mentioned at the same index of #register_name_list.
   */
  svt_spi_types::flash_command_enum flash_command_list[];

  /** 
   * This field specifies the address frame to access register specifies at <br/>
   * same index of #register_name_list.
   */ 
  bit [`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] address_frame_list[];

  /** This field specifies whether the address frame is required to access the register. */
  bit address_valid_list[];

  /** This field specifies list of supported registers. */
  string register_name_list[];

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
  `svt_vmm_data_new(svt_spi_xSPI_flash_command_register_map)
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
  extern function new(string name = "svt_spi_xSPI_flash_command_register_map");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_xSPI_flash_command_register_map)
  `svt_data_member_end(svt_spi_xSPI_flash_command_register_map)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_xSPI_flash_command_register_map.
   */
  extern virtual function vmm_data do_allocate();
`endif

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

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
  `vmm_typename(svt_spi_xSPI_flash_command_register_map)
  `vmm_class_factory(svt_spi_xSPI_flash_command_register_map)
`endif

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  //extern virtual function bit [7:0] get_stm_status_register();

endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
C1TzIbj1k4gI/cv8mB/WbkYxT2FXIAhQoZkpyD89QxIV9ZtiykXvHVGCBwF+TQYn
QuFekbwvNK3KU/49Y6uvZl2LQGhmoPI+Xiy4UErbg0Kaunn75fpe2W3T/y0i6kTS
Md3C1ElZN4QvABxc+dzKtUdqp608CT+mjzW0+ZELopA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 650       )
srbV7HhG2zS2+sm4Utv2L6a2hVUs7HDSP+B6nKhXNsnqS10VwwNZcPOOR+xoIXdG
3Zz4XgebRJIhJU4lYYp/l10RjmqLZKV6mlPDTGauY29f3ii9fhfGOWBZqnsiZp5R
7bQnZJQa5hqT1SD6GGlcWlYxwJAx+wicH2XoNXNrs+0ViQ+AW5zt+/lDSih4xYe2
+dmOBtanXQKdlPE14wgK4uqBR39Vib/6lyLW5nDqSKeDnzwX1lCfWioq038MuW2Y
i56K8JvoiAuXPcT6Fnm00ED5lA3iDuDiI99TGgM1ZHf1Z3it3EsLlk3wCjK89wN2
I5agsyBjvy7vtSWKA39SAnl0fcv7o89aLHBWiYiPhU0PD1+dElLDs5lOnr1Cm0hG
0QI7DEhpvmE5OqCvFhlqzd52uXby2YVnP58WVEDb2LYdIZFA/hBg23ZxQNRWpg6S
tceakth0bY0kabcAvSYyNWe6cCd1swOW0uPkhkHVk7tzwf8ff24nZ/htbAc8CQRD
A6cPTdm2s9c4WwUulPWN0ps07QqkL5mYBBh32FHHUJt7B3kem18l37GCRSOqwOc4
jV2tW5ceyJZLaqpZ4FQVww9w6uH4UMqADYvASu7zhu3zOtPt5BcJwosy5U9W3raI
Bkp12KonbGaQjKBYbX7FmihSAnhMgVGSFATEHhpXdU1zPatkbF1wP5Y/h9lxpEMf
5k/7d+DsMUwseipGlEHvtu8qAub84pTDnCc0EeR7r2pdGTiBGvai26UG9YpKagS2
81nVFtd3FUoHwoejS1AFAdr8ZGbYhH8Zh/vDBLHll49nchDwDwZYw0IWPHNY9Shf
Kkh5hDZ2r2xBnvnC0UWQybTfjssRzYx6d+hi1xiH+YM=
`pragma protect end_protected
   
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
agZFcc2KJyXufMh7m2PIefep0C9ov1JLdnkcN5QVyxFHieHbf3J0mSaBut69umHi
2ehpbIOLNy3yurEShZavNOZDlT8NhlUpqT4QvCqTnQqWguoKL7bHDmpvQEvMw9QK
AT3U8KAsc6yxrH+v7R3uy1LIz+u+6mhczQdojtb3tYU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11996     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_xSPI_FLASH_COMMAND_REGISTER_MAP_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
AYFLKevUio1CBozNKNDPQgoFRLguzT9YNWVLeoZP8934LjgVVfYVIu8YQ7OGWsUK
jpVcv9HaOnYk0W9aIMVQTxXyoQbf+lMJBy7Hk5yItXTYzBEYYEhHRxAjpWP+d4tu
+JCa/6/cQQjwU7I8CWhe3B9zH0HkOqOdJ2BQoIC0gcg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 12079     )
r3D2RNHoaOfPSwrrjH2uu7Yjo0Zg5Uhyr8+Z4gOptlQpa80v9FVm7L/QeM11U0As
Qftet/BICVHpURWuHAWetIgDxNzf5E9uiDw7ZTHCid1hNTmegZ9fgFPNY8ODqTX1
`pragma protect end_protected
