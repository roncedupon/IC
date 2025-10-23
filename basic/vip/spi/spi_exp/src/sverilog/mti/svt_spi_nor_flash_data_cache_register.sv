
`ifndef GUARD_SVT_SPI_NOR_FLASH_DATA_CACHE_REGISTER_SV
`define GUARD_SVT_SPI_NOR_FLASH_DATA_CACHE_REGISTER_SV 

`include "svt_spi_defines.svi"

// =============================================================================
/**
 *  This is SPI NOR Flash Data Cache class. This holds Cache and Data
 *  registers of NOR Slave device.This is instantiated inside shared_status
 *  object for Selected NOR Flash device. 
 */
class svt_spi_nor_flash_data_cache_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** 
   * SPI NOR Flash Data Register
   * This buffer holds the Data read from Memory Core
   * ECC operation is calculated on this data, corrected and then pass on to
   * #nor_cache_register (Cache Register)
   */ 
  svt_spi_types::word nor_data_register;

  /** SPI NOR Flash cache Register*/
  svt_spi_types::word nor_cache_register;
  
  /** Valid bit for corresponding byte location in #nor_cache_register. */
  bit valid_nor_cache_register [];

  /** SPI NOR FLASH cache Register address. */
  bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] nor_cache_page_address;

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
  `svt_vmm_data_new(svt_spi_nor_flash_data_cache_register)
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
  extern function new(string name = "svt_spi_nor_flash_data_cache_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_nor_flash_data_cache_register)
  `svt_data_member_end(svt_spi_nor_flash_data_cache_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_nor_flash_data_cache_register.
   */
  extern virtual function vmm_data do_allocate();
`endif

  //----------------------------------------------------------------------------
  /**
   * Method to make sure that all of the notifications have been configured properly
   */
  extern function bit check_configure();

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
  `vmm_typename(svt_spi_nor_flash_data_cache_register)
  `vmm_class_factory(svt_spi_nor_flash_data_cache_register)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
NmHBjdnGIHHXwTmQ5gVpfGvNqMi/5JngG1pYEU0HDyUF1EYYhponcFu0H6chV6HG
okrhQrnUlsLOCje4DSH+rdHRwMtALH4UeG6QikRMabv/Ziteu5K4tAbqbnwHugQ5
kZODVR9pQZTIUvrHGbHJFQP0r5cSm+/xGbLff6ORK4U=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 645       )
AMikFpVsAA3KpdGVVrAtIMuyQVvxSmiL4Q3STnlt4yhS4ZjHguEaFYuvpScccX94
cJWTtaJj97Dw85v3vajn8TbdJBQipbvkQEwue5l559oCa1OHwG2yC/qLDJ8Ef3ie
+f/qg4P6K3lKL5pxVlY1c6zSWjsOzcTpqCz1tHooAsnLCHNGh43tbNiD158u45nm
0L49VVwvLE2mZl8qfq2YrSYFBLhYT0hq88x0kGulAR5o/bc9erWgODdMBn2gxXir
ztINEBIpVEJtskwsDvSj2XBIAN810uwXhPE9R4EEetsJWwQhAw3YD8bYI1qwZ1aH
Txq1l24rTw1xMCkT8r7qH4J0pHnzfVEgRUsRryxSWRG+JTYJITO2aLOTZZSg/XkX
4jYP3aWOXxgld9p8kFsUlgd0vpA7yuY89a48GKFLdZXfi3E9fZnr/J45sc7ZnuWP
Ygh6I5518xSWLriLCRXoXfm/GADj3jYYXd9NPcljKnkhv0VOwspzH4fFPURfEy6p
ACtroBpnkbgl7EJGcFkMC9W4Ws5Df1VjU7Z2n3DKaEIjKD1ctBnTOlSuGhEfadUd
a1ctsID0RZTgOC8MDtrIDbmphS/Nz7GPm+9l9kGRJiWylXY7AM8HdHXjBt3xPhxJ
+bxPJSt4Xj5Pt065adrGtGtJQcaFUr78xLELEwuZoSwPH6zowTXDmX3w+pdNjyF2
I1FNn6FMQ7wkh/nGSdwGo0iiIse9lD26SmTeAl0/3pO1mAbkfOJb5a/MlfwS3N3g
kVNARe2WQCE/L6/dbcpe5TI5lsUIBT9NBgIMCQPRnctigJEEbu25kj4x5Q0qKm1P
gabMUDiFC3Tnxroe+GI/JChD23CkD/oBt1lxTckxaJI=
`pragma protect end_protected
   
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Y2Z55//wI3JUXcxNCIoXUWCFXFEdsb5I7Wjyo9zZ2rePVh6hJrXSB2paCH3KB0xD
GBozW4e+S+GUXmWmorQOZQZgkRK5ww7izi+pPg/s7Y28momx/S/zCvfM0lx9l0at
HYUzkW9Mp/Gaw5CfA++nksyWUCXl0hX8Za3xykX5rOA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 12429     )
+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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_NOR_FLASH_DATA_CACHE_REGISTER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
KM8tiY4oVUalMoRbhnPnjp1oycU56JKWHbfmJryJchwLjHImtRorwZMEyFFXHnbC
4WVmJokx+US5pKAN5aWxhMpH6ARAkrC5XPn4ejJ0n7pY5766tMZIgORdXNZ6OD3y
rdolTEBkXyROSOnI/ovQ76rrBsxAc12nWb95Fp0X20U=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 12512     )
admfnh4NJy42BZ5ADZyeIpVouG8+ioiahzjANKU4Q2eRjKdMR0Ns2o7kuOg5gpV6
Fh4S98Ne3gQgCgc1l0WL4eZFg7u7ZimMatIyh2lI5sj3caqjBWZDlcOYcu9Xzy8s
`pragma protect end_protected
