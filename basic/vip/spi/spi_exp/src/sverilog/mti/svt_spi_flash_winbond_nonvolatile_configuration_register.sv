
`ifndef GUARD_SVT_SPI_FLASH_WINBOND_NONVOLATILE_CONFIGURATION_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_WINBOND_NONVOLATILE_CONFIGURATION_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP Winbond Nonvolatile configuration register class.
 *  This maintains teh copy of Non Volatile fields that can be stored/reload based
 *  on requirement.
 */
class svt_spi_flash_winbond_nonvolatile_configuration_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** SPI Status Register. */
  bit [1:0] status_register_protect = 2'b01;

  bit sector_protect = 1'b0;

  bit top_bottom = 1'b0;

  bit [3:0] block_protect = 4'b0;

  bit write_enable_latch = 1'b0;

  bit complement_protect = 1'b0;

  bit [3:0] security_register_lock_bits = 1'b1;

  bit quad_enable = 1'b1;

  /** Output Driver Strength */
  bit [1:0] output_driver_strength = 2'b11;
 
  /** Write Protection Selection */
  bit write_protect_sel = 1'b0;
  
  /*Power up Address Mode */
  bit powerup_addr_mode = 1'b0;

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
  `svt_vmm_data_new(svt_spi_flash_winbond_nonvolatile_configuration_register)
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
  extern function new(string name = "svt_spi_flash_winbond_nonvolatile_configuration_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_winbond_nonvolatile_configuration_register)
  `svt_data_member_end(svt_spi_flash_winbond_nonvolatile_configuration_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_winbond_nonvolatile_configuration_register.
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
  `vmm_typename(svt_spi_flash_winbond_nonvolatile_configuration_register)
  `vmm_class_factory(svt_spi_flash_winbond_nonvolatile_configuration_register)
`endif

  // ---------------------------------------------------------------------------
  /**
   *
   */
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);
  extern virtual function void set_cfg(svt_configuration cfg);
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
kkgKq3f3G6vNkBOdtDw0t+JMGnb08TRRVep8gQQfM9aG7zy/NrT7M+M9BzohuoWm
FA8sZ6CU6axSfUNXrLsjrMSyJT4qhm94zjHNhsi9WiuGFCgBslwaDkP+K7BISzJO
4a5i/oGOpE5X2vCQNBscuSdAk4uPljYvVhqG29ZJ5vY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 718       )
nIYr97tdoMqlDn0gQfgeBZk4WfsiFpDDRvccCER+n/YP8qhV8ioRao41RFLCU/J5
bP9wGvqGmtrLIDDG0xsbO2Xt+hWr/CHe57OS/1gWz9a7Vg+3qF0otbNu+RBQ+QDk
dCHGpGedV0dUIfdTcVE0wAWhSjqMkvHoeafefRsbspGymFIvSxMMfMRTDMa2FhiR
/7eJOsNRmZWieGxP+4dpYH5yG+KFhIUls8pV3BrnsroyRdDhFSXvkPVD9hetMviR
mSkmFI+YCruHoyiqE4xADpNezlo47QATPg4Ih0sU6gadAa9Sj/A0Rzgq0oXRsrQ1
eyzBMigM5bqVVKvEaC65PDX7gfBFqQYYkYCRrH5z22u5T0VfArFNad+JXV5/ij2w
34giey1G7uNnpn6ZiX16l4ZINwJWeF5nQmQP7/lKvPi2oOdYTEG2gu/EXK6KAfJf
UaGynnOzySuspw62CyQksY40Ucth5kw95EbOLxAA/+j/BOf7TM4VxobzMSbPKJZV
/7yd1K417A6QcinFHOCMyXrWoDHVjnkIp4zuX9ljZX37pXNW0mFJJBirFOZXIhI+
lceDM1ZC6olYYejvOLgVm7c4s/FGjrHXeIKd5IGFOnubVlibehKTEGlBPI4Y0btH
vmrMhvPprdKlEa/qBzgY42Inq1DfXcDPB2Z4sO9rWecjkqG5VfPlsr4xh/rRS0TS
F2qN+Bhod9MLFS8fI5Fa0/t0/IG6pYTvnN7DfRBNoS8e3kUbswd1o4Ex2LsNq4fQ
GLvDgwWcSuOLzgH6wHRep/p+k3APMtnpkMLrpnX2lWHaKUr1ST115nVd+Vj5KQ4L
jwKMA9lxDKGDQO+hN6fR9bUzCPsagz4DptXa69lz8bTrMjW+GnPv8bVNKI3hORy4
YkbMLe3ZWFcshPp8TzRAAgRPeHeQFHoRaVyo9EYC7xjlxiuD66XLZYA7r292Jl5/
`pragma protect end_protected
   
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
m7iXxYUrCKMiJYLrTwMG2bdcG3exPfWNroQNjhJCZLfxqkdyJ47oSocA/HKFRGlf
6wpYuVVNxjzkRXc9ZL8e6M17XqRbESCKO3huSn9Yj8IQr8iwLGfMnv+Qj1EgzMo7
+p9RENHDHuCvviveGU81mp9H5fQfO14rJ/lhFVcma/Y=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13248     )
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
fm2SghNwoM4N0Uv0QWxfvA==
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_WINBOND_NONVOLATILE_CONFIGURATION_REGISTER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
PsTuvQ4WzKLfobt67OrGFTUNgamk2xaTKR1b4OYEjIrMmEpZ+YZQnys3Gmb5czyW
Xaxj+aOAMdl0vTiVbI7nmn8YkiH4wTIHYtbeFlM4iSWlXoOCPucJbKdbXayD5gq5
0ls20eVqk8LUDTBv1UWAxFryq9UkoqifnckstvT4wXg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13331     )
MLpsjEdKq3ZB7luKFgziBtVR8qGh8F1U5HMeqLyYs3Bphsy4cfXYmv7FPOcAPp4Q
yxrrhtjXvMsDema1YGtnTgeD5R4D5F6QKtj+te4lQ0PR1tYMU+VVUYhA5pwAw0qi
`pragma protect end_protected
