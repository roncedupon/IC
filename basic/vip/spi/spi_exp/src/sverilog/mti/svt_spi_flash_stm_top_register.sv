
`ifndef GUARD_SVT_SPI_FLASH_STM_TOP_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_STM_TOP_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP STM top register class.
 */
class svt_spi_flash_stm_top_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** SPI Status Register. */

  /** Used for enabling the function of Write Protect Pin (W#).*/
  bit status_write_disable = 1'b0;

  /**  
   * Defines memory to be software protected against PROGRAM operations. When one or <br/>
   * more block protect bits is set to 1, a designated memory <br/>
   * area is protected from PROGRAM operations.
   */
  bit [1:0] block_protect = 2'b0;

  /**  
   * Write Enable Latch indicates if the device is Write Enabled. <br/> 
   * This bit defaults to ‘0’ (disabled) on power-up. <br/>
   * 1 : Write Enabled   <br/>
   * 0 : Write Disabled
   */
  bit write_enable_latch = 1'b0;

  /**  
   * Indicates the ready status of device to perform a memory access. <br/>
   * This bit is set to ‘1’ by the device while a STORE or Software RECALL cycle is in progress.
   */
  bit write_in_progress = 1'b0;  

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
  `svt_vmm_data_new(svt_spi_flash_stm_top_register)
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
  extern function new(string name = "svt_spi_flash_stm_top_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_stm_top_register)
  `svt_data_member_end(svt_spi_flash_stm_top_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_stm_top_register.
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
  `vmm_typename(svt_spi_flash_stm_top_register)
  `vmm_class_factory(svt_spi_flash_stm_top_register)
`endif

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_stm_status_register();

  // ---------------------------------------------------------------------------
  /** This method retrieves the value of a single named property of a data class */
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of a single named property of a data class */
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Status Register */
  extern virtual function void set_stm_status_register( bit [7:0] reg_val);
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Qd0YJ/M9Tb08Kbci+2dpM4G9kZzZckCa3b79JXFnWaaBZjHJVZQliyk/pQmBLy+1
FmNM32R6sAez7igEZYxkgO/BvmOOwQbGanSUHuZVIG6YrHXiWuUNQhkE944JbdQ6
lDHzPlqAFtB5mmiZCXBuE/86bVIxoUq1nqSjmwx6J1I=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 614       )
NdwX6Bx59Z675nj+jgnI+p3cNuk6SpcbmPYD/djhb6kr2EuPOO/mY5UKGPnBIA5Q
u4hmBRIbzyevcxpCD10GCZ9fpcgNjb3XozcTu6HROu6nb2G+31BDZiFEdmMzVV0X
9vLplvsvS8FuffeJvhY13ZzIceZa5R6j7ve9xreO5YBwLvE1qkTToPaj2bFiFrY3
YnVPCXSQm/2Mg7W/RzvQQSEN583JpFC+e8QLFsTQrXMu2i89HqtPVnp4hm3r9QOL
sfa2SsrkF8xAwAl+qvk1csFD48zdCC40ElNfB5Smqi7avy416mdogyhNpOLo1y0u
2alllM6Efmfk80SYA5iIhoG5qjSpiwVRwF7z9spHu1p1hzSQI/mtduSg5Z8RLIS0
L4zgbkm/y5cKfhn5+LtZ2CV/qhypXfkYeM1JmDIyZEGsTwOienLGKGTz2GqEXY4i
B8anQbKxhRMBMb/bLzO39D/V1Ir8V32+K6vdRFpRLuaqPZkk+uzMxiEL3FWH6Vxl
OlT76APZoA6/1lldHVcjMpmmPvHK7qP45cxRDEhcGeFjjFUiCUWnD+LT6G9dBxx9
DUk34mdDlGH+nbVcjcl1VxNbrn9DHwuZC47gtlbkB5bTkCasWzQeY7QOAo7B8Tc+
82xJUXkzxzL8OL4fEOxs8uWGAcNEnvtGlY77m5L8css5ForWhy26amArByZn0QNy
Dm6qDabiK4X1+/OuTwRA/HG/XG0zZs8/rI1xf2F2r8KfL4tAOf9rli1cEUVaEUEe
oawX/B4Le6A4kAbo5vu+YbSEXZp2/XnS8CDQrrBAOCh6o8i1eiR99ZCjhWRy/mRM
`pragma protect end_protected
   
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
IdgWma1NLjrU8FhN/GQWyUXy6rruLq2+T44q7FWOMwG6AAN3IsJCWQhYM9JnVo3g
j0pIun33MQEbknCImtVEC7PGZvAHlo80IvTMIdDdRtOvwchJl2N+Q/i2WWW1veCN
Vmos2mIQkSOv6ccgTgyczfmOohJW/QjnWC4pSy0SnwA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11336     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_STM_TOP_REGISTER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
HGW8DnELcrl8IXagek+2nAK+3TnHjOgDTe5YF2UdLC6ndNV1IeuajT7EAWgOXIX1
Zbd3PkSx2ql+1y4K6B3V8CCvfmdHN7DUEidGF2GJyF8MX+H0nf+SvRnBviK6Hu2a
AKLdmZ9XVX8TrAlM+TIvzz/pwtAB52LkWsjhnDrGcA0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11419     )
42rGp+2Sv9WmnuxCERpWCnTw2hlLAfSqVLgTst7PVp9hJwiN4ltnqYlaN7px7zW9
jjmGZRscGZgQ9uXHDAAAOv3Cfzr1LhBY/TOlk+/N+hEPLgWgzCbCRdAkL+jZFC8L
`pragma protect end_protected
