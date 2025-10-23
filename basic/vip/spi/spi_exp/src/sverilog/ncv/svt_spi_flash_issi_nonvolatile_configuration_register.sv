
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
jSDDFvbODFuyrBp2z/V1D6rP616E+dMi54s3kjuzfee0Fk1tKnUf8tlhQovEp2cW
YDsqamDfng3MvYp64DnMupX4gStxMsZkmFKs7Dg2J/BDrcaXMMqOg/Ce06D5+KS9
4OgURW1iLzCfQ9JKmfO+S4RaG5aj8+pBHRwF/hXwJlkh/y6LL/ZbeQ==
//pragma protect end_key_block
//pragma protect digest_block
OYvEFKyEIyec4eFImLty4+wDvs4=
//pragma protect end_digest_block
//pragma protect data_block
yonQmuYcFHDW8w1fQs1kbdzw6zlLyF4Gv79PuEkoETnFDr4kpIofjMOulzty/5dZ
f8oOYhwH+xyr2KdxCmf6NW+F2507kXT3GJXvtCe3Vn5kpMhs2GCvTveOoAzh2kO1
ffj6cfkYk/GRsOEdRh8/qPjCp6hfTBMWwwIZJO1hA0YwMT1+p3wxks1nnPlnhZGM
SG88ITXN4eLftOPkkTMNrHQnidi4l+z8Q+ydguHNLOcO0uKgCXz9E59msHExGkgz
YaCa8wIohKY/u4XA9bNW44NUsxCXG8V9COy2d9ap5LBHT+B443f1vqK92nV/jaFe
qPIY/navHi7WLVTO4oTVxcmHuYtHiGqx+QECZIGS4qcXcnZviqvY9dhNYnETZ40J
+uDlA3pFEcjnjKewvGgQOjitjlulmb0a8QwA26LGyX9Hq/IeOx7wDmxeo8DSbpQm
Ra8LROetZmYjE/Rs3Ne/U7ALiUlSTASjIifQh+ZD0n5VSp6kLlcc/NClCs95gxLC
UG+2WeaoyMESBuObsPKRt946/o2Y5JG6lNz7a2/V0/o7oDwgBv/RjvAKmcYc9rWY
FOnfOtmrVfZKNCyzbAIIFQzCVNY6ZO0iN3F4sKcbHD9q/5eRcSsd4850d/l9Y3Ua
AqWiCt5LIoX9f40pzhufbXYCD1dWTFKVqP27mWMEzizjTIrZoavCxMINM3vALFHi
rFJn6rETjTkSCEF2wkaM1++3ix3P5JrjEEDZwZrusP3MIGaOIx+MvEhZRe3p49Xn
xApnIKil9Uf5RghVWoaeu5yizV8vG9uHGW6vhJ7bUQIqx1cSxiBkdzgm5os6lv7l
KYGDXhGCFq0Ff5zRtrn7wiKX11j+tdjAfXB0D8iEjWbMZTpaD2i2qSz9t5p0qTCt
vnRQECgoa+BOG3puUHyhCbICIeCvHrlsFxBP7BK0CWmSugg+TIQci3PPkPUjqlSw
rP35lxQjq57Z4/MCGlJrp3fWJvRJbVQgeFTJDNzHhcxkA2laenufxZJzXqbHlBg6
URWW8Ktv7EeBqsX0E6EJ3M6SAmpFgMCstCj1muFyQoY6yAJncT09D2eQDEaPjzNn
TXUgnEC733P3lU4mn35PuNXhU7toFNGVNWFYkXP+xXWW74jofVzaF/ynb6mN0AW6
ahPA0LJ+4BZhLyHpTpGmIA==
//pragma protect end_data_block
//pragma protect digest_block
QWyzR32rNZg0qw0ipzWQ32WBOmc=
//pragma protect end_digest_block
//pragma protect end_protected
   
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
z4sOT3hKt6Y+wc3JW4e8XnYeqarJ5ZGIrSjTcL6uCsNVeuLs8GDt+CsAtkqv+Y4J
U3y1mHHoPvgHvtgOsuzrjNo3StN1U4xpan9UXLHLAiOgloXQ4rwRntX3CQ6L3kJl
5Zq1UHptdGK0hInlKUB7T7y/KZMP6AR5mioZ+l6p2wAp16IhD43IXA==
//pragma protect end_key_block
//pragma protect digest_block
RI2Ou74S52C/ku7NrQAOz41Fv/I=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
LDcNHQ7e7Clm+sNZNzL6g4CwPWg=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_ISSI_NONVOLATILE_CONFIGURATION_REGISTER_SV

