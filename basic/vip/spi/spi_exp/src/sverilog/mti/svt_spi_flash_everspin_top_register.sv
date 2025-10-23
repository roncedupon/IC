
`ifndef GUARD_SVT_SPI_FLASH_EVERSPIN_TOP_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_EVERSPIN_TOP_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP everspin top register class.
 */
class svt_spi_flash_everspin_top_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** SPI Status Register. */

  /** Used for enabling the function of Write Protect Pin (W#).*/
  bit status_write_disable = 1'b1;

  /** 
   * Configures the device into QUAD IO operation. <br/> 
   * 1 : Quad IO Selected   <br/>
   * 0 : Extended or Dual IO Selected
   */
  bit quad_mode_enable = 1'b0;  

  /**  
   * Defines memory to be software protected against PROGRAM or ERASE operations. When one or <br/>
   * more block protect bits is set to 1, a designated memory <br/>
   * area is protected from PROGRAM and ERASE operations.
   */
  bit [1:0] block_protect = 2'b0;

  /**  
   * Write Enable Latch indicates if the device is Write Enabled. <br/> 
   * This bit defaults to ‘0’ (disabled) on power-up. <br/>
   * 1 : Write Enabled   <br/>
   * 0 : Write Disabled
   */
  bit write_enable_latch = 1'b0;

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
  `svt_vmm_data_new(svt_spi_flash_everspin_top_register)
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
  extern function new(string name = "svt_spi_flash_everspin_top_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_everspin_top_register)
  `svt_data_member_end(svt_spi_flash_everspin_top_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_everspin_top_register.
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
  `vmm_typename(svt_spi_flash_everspin_top_register)
  `vmm_class_factory(svt_spi_flash_everspin_top_register)
`endif

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_everspin_status_register();

  // ---------------------------------------------------------------------------
  /** This method retrieves the value of a single named property of a data class */
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of a single named property of a data class */
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Status Register */
  extern virtual function void set_everspin_status_register( bit [7:0] reg_val);

endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
aNhfeUDhdfMas+5FwoB59maUAr9fSILxFglXN8/h7UG/enij+6kmPOm/I1ypRkNl
MWP4oByKhvfKqJx6rh21JM9BOO9Gr3mNo3Wb57t8JeSNZ5JEPdnojJqIuzd9lCA1
5Qx3Vn38NkJZd1xSD67diBeKC18V8/TvTMymKN57obc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 634       )
b7LGDH8+9hnfqje7Xu4uVxmVrlpAH0b+54TCIek8uYRMRyfs3o6S+0UuencVXj6E
eHkNCfIaGVAXU3fbqdiiw28LHrl7IrO9W4MEDK/lnHyXNkuX1zTW6NlDBBzGugXc
BqOJnJu8tduFjQbJfQe0jpyt48vuy1Ualg6NGC4qj7BMEs6PlLCU8y06Rva9We1+
EwtzAx6R10OJls5uslTo0rRX/MckYTYRQMEw4y5zxgkVtC58TV7jsBIOPgiIou51
To7L3Eks74WhsZDoWyvCJRaodsl6/100JyW26qeZAboO4dBEvrTfUChWoC0RVTQF
PmUHKLcIlwb4R6bV8W1sYDWvYHCRnJs/0ym97YSJhqyS5k3m3Bu0qftWzrrpM7Yk
iiko4GDcDSspFwD3on+rRzaIm/BtXPRMNs0PTaBQTvUNs+xebwajD2rTYKiaSehA
cWLiYd0yLGsR8yrdQ7layExcCc/sSpsadJudl5saub027j43H647m/IQ6gAPhhzR
BhqRA35N1V6WfjwyWbhc3yhTcXb/wi3r5VjgFhempOK6DxCeRO8Gc7MwxYznN1io
ACy/D10uIl9FZC67HXT5SVBfceo+YZoxg25t6Q6YhU+KZw7sjoxl28+7JzpXHbCG
n8Dcn43C4W+PaycKkJ3vCiOAIl+yaJSzaeO0uYkM5lPdT991EdD5oRYuhejtrrTH
jFk385OutLbIEuhV6hNjCnjKBZ7mtmP207qING9zM6PORAQGFEHdVvlYoonO/rZl
Lp5zkGKQeedoZNgUfUnz1yiFhGNUMAAt6JllyqhsGUgZ5gPEzXqd5liue/x7BRS0
RUBJZRxUUkK3cxaFioKjVw==
`pragma protect end_protected
   
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ASiLW+JKpiWoU6DQ2+TY0nfu0kJ7YrdHiENIABQljyWfD0Scd3MxSKqQnOn3XcsQ
jG6Q5EYj7rvMaavdVlYWQyWsLG371oHSyCc9jtH3DMHfMHcVvEbB7yZOJy8iS3+F
0TWlJloNUY6lKEj1kPCd6Vt4hYpd7UeAEFWg6BNrJUc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11512     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_EVERSPIN_TOP_REGISTER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
YoHwTbqn8fXHPnM60uiB2IIg7jzQCJC2lnoapnti5he3EZZgShLGhFK0rcYGlulb
4ybNltNxQdKYzjjL6PmHnh8qoLRwxOYcy2ncUTj92Wf2SkrP+X2tMnfMEDroEi+g
RvAJBS4PD0Z0vWGEugQbjRRYUb4Wc3nbB4ZSOS/8sLw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11595     )
YvxFifQSVCL3hBPXarrMWkJ0pDKE14sJwzmW+zuPkNMn/ikwxk4aJKGDsfcbzzzv
dwhhLlI5aZ1THu1AbrM3mZLBeljS6HlnwBNtAGfeqP3Mkb1rj2f+1bgtKvjVX9E4
`pragma protect end_protected
