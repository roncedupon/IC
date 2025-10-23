
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
c+7/AR1vVfkpaxDJv+Z6yQ0gG4OusNPSkDfO4GnOxlu6rTvAn3kj4KLEPvI2ilVE
C3806vOrWglqiAhUbK4YDoocOdMGWQ8rBGFTMCFXO0CbqCFmDLavAO1YzMIc61RB
M/1c0KbYMKrkJY8ZXkmIL7E1skCsm8n0JwIgXY1itzVFnIDarLxnWw==
//pragma protect end_key_block
//pragma protect digest_block
UhvFUJ1+lN5BRMJftcVhF8iVzPk=
//pragma protect end_digest_block
//pragma protect data_block
SQG6ZRxXLnlBwIvfY9uDa+FD1Kp7B6RBTW4Eb6bg8h6mqOKIrxw7rwpaGwc03QX3
Dh1cbr9IxZnhNiDnv8A2H3hFtiqD70dQggJgw9zZlo3RQJhICXDBobtHmdi4IVy2
EytLhFp9hqnVgGaEGXnszD3EZ/NXL5C+ax4ZxEEIMhcSW7eovuUXJcdy/LL8nSxa
XKMQ4hN635VQ4A1ljRr8sJ7Oc4sO3cN4NTAMO1d8Kin07675wckHOAoYDv20Uqy5
UDrj07Ts9KrbKAGadxafjD1KkpbZTE25JVEh3yToMRW/5NdgzId5XqYw33Bsm4ks
JL1XyHfHl0mTE+PhqJhceZ6YItUJpdH5WSKJKVIarzRCN8qH3cXdrI/Rb7EnkuoP
oGN6BG4O+DhgBV22QIwnG3P5xema4j/urbqU4LvpNkHfMs1RHOc8cV9KJe40E0i9
BGEcg1IW5wsFd7RlBBCWwnAgURiQEH1g9+p87qfUgkf1SlpRagNUKQM9z/XGR1s8
nNnHgUgnYV088X40vlTfQdLe1SoJVrY43Il/+lNNscVZRRLP2LdG1wWGsltEnC4W
stCarFlBJqISc2S8ysDHH7quTxdM8yM68TsBebs2xH4Bfe6Mfcl+ckvTKmELBo/k
Zq5cMl0Gx72ZEEGqfm3N1ujIKVWqe9aOiw3TZY7hG1sr73W1glApDJ/rPuUrfgKJ
KNld4iRHR/aHpyq4Q4saKj7t0Na1WN6WxyDXWjSl2IYWLGC4JmzGvRc7pi66SpFc
TSypLzBnVNp+Ha8/qkptVIW7vNyEkYlV7joTzH9P6YqL1X7OHG5N4IInbZ6HbXLz
N8iBJxFYZ9NL4wpILOUdw8BdV7/HHvviXfVeeJnl4YxKU4xZ/xCoCayV04zVjsyj
yjofyoNXIGNx/lj8WgESTkWkkZlPGKVBgHxC8rAaFkYkpxR+uLT3KWwil3Jv+ioZ
Nf/ly8JgSj+wluLb+EK/oNKjLWShxEtiuF6nvMcl8S2IsLep+eF+x410MNxTGpgu
nkKkIQ6PCrpRQw5R+HE1vUqgYRU4e82+Su07OGajvsw=
//pragma protect end_data_block
//pragma protect digest_block
XWWnmW5IubAg2HsOst22eUnG3E0=
//pragma protect end_digest_block
//pragma protect end_protected
   
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
dy1AHMhtKAgFZlgpLMo5BP+nVMQfAhW1xh9jRutc5EebSkYNXYFUiLQvm2BJAJeR
UD9aqrERCnb6yqDcJf5ttzJIdpOP42cVj7yZOKhMQBfH1iIZQkEAXWB8OvXFBz9n
OytZ78+NbQ/r2osOtijjPAUkp0av7YCRETWm/3KIv4NvTki+j7K0kA==
//pragma protect end_key_block
//pragma protect digest_block
ydlHW3INVpKjstRMdvYb9E2iBU8=
//pragma protect end_digest_block
//pragma protect data_block
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
QJ+CtejOP/h1EIg3rshLcw==
//pragma protect end_data_block
//pragma protect digest_block
Zu8I57Ox5nZPUfuYLQ7vE6JjgRY=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_EVERSPIN_TOP_REGISTER_SV

