
`ifndef GUARD_SVT_SPI_FLASH_WINBOND_TOP_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_WINBOND_TOP_REGISTER_SV 
typedef class svt_spi_flash_winbond_nonvolatile_configuration_register;

// =============================================================================
/**
 *  This is the SPI VIP Winbond top register class.
 */
class svt_spi_flash_winbond_top_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** SPI Flash Winbond NonVolatile Configuration Register Class Handle. */

  svt_spi_flash_winbond_nonvolatile_configuration_register nonvolatile_cfg_register;

  /** SPI Status Register. */
  bit [1:0] status_register_protect = 2'b01;

  bit sector_protect = 1'b0;

  bit top_bottom = 1'b0;

  bit [3:0] block_protect = 4'b0;

  bit write_enable_latch = 1'b0;

  bit busy = 1'b0;  

  /** SPI Status 2 Register. */
  bit erase_program_suspend_status = 1'b0;

  bit complement_protect = 1'b0;

  bit [3:0] security_register_lock_bits = 4'h0;

  bit quad_enable = 1'b1;

  bit [1:0] dummy_cycles = 2'h2;

  bit [1:0] wrap_length = 2'b0;
  
  /** Output Driver Strength */
  bit [1:0] output_driver_strength = 2'b11;
 
  /** Write Protection Selection */
  bit write_protect_sel = 1'b0;
  
  /*Power up Address Mode */
  bit powerup_addr_mode = 1'b0;
 
  /** Current Address Mode */
  bit addr_mode = 1'b0;

  /** SPI Extended Address Register. */
  bit address_segment = 1'b0;
  
  /** Block lock array, indicating individual sector block lock/unlock status. */
  bit [7:0] block_lock_n[];

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
  `svt_vmm_data_new(svt_spi_flash_winbond_top_register)
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
  extern function new(string name = "svt_spi_flash_winbond_top_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_winbond_top_register)
    `svt_field_object(nonvolatile_cfg_register, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_REFERENCE, `SVT_HOW_REF)
  `svt_data_member_end(svt_spi_flash_winbond_top_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_winbond_top_register.
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
  `vmm_typename(svt_spi_flash_winbond_top_register)
  `vmm_class_factory(svt_spi_flash_winbond_top_register)
`endif

  // ---------------------------------------------------------------------------
  /**
   *
   */
  extern virtual function void create_winbond_nonvolatile_cfg_register();
  extern virtual function bit [7:0] get_winbond_status_register();
  extern virtual function bit [7:0] get_winbond_status_2_register();
  extern virtual function bit [7:0] get_winbond_status_3_register();
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);
  extern virtual function bit [7:0] get_winbond_extended_address_register();
  extern virtual function bit [7:0] get_winbond_block_sector_lock_register(int block_count);
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);
  extern virtual function void set_winbond_status_register( bit [7:0] reg_val = 8'h00);
  extern virtual function void set_winbond_status_2_register( bit [7:0] reg_val=8'h00);
  extern virtual function void set_winbond_status_3_register( bit [7:0] reg_val=8'h00);
  extern virtual function void set_winbond_extended_address_register(bit [7:0] reg_val);
  extern virtual function void set_winbond_block_sector_lock_register(int block_count, bit [7:0] reg_val);
  extern virtual function void store_winbond_nonvolatile_settings();
  extern virtual function void store_winbond_nonvolatile_status_1_register();
  extern virtual function void store_winbond_nonvolatile_status_2_register();
  extern virtual function void store_winbond_nonvolatile_status_3_register();
  extern virtual function void reload_winbond_nonvolatile_settings();
  extern virtual function void set_cfg(svt_configuration cfg);
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
PiDSdmtwNkfhCyokYG7XuS//G780ZBiTg93e9RCPdJpV51vZ9LJF6zvMYt/cE9BY
UQj4VKkkqAy0PbuyUJFt41EKCavwCZaaGeUL15T89hYltyG5Y4+2IGIilYr1LRRC
s5uLQ1QpxCpcbKIrs2z1Mmgw5gLgf64r2RZ5ra8h1Vo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 630       )
1I+uM4pwfxYChxx3+47jaI//vFbkwrOoehImNi3oeJXXCrzfvVbCDHp7dkiRtPGC
+0Z+SAfN1dq5UyYzP5Vwbla3/bkXAY/ce33ecmG/1Dn6GB23V8ScxwaVXVxh4FbY
LioiqJBWFvihGHypS8UqhHn8BMxJsIRID5VJY4dk5ELcQka055RROPmo0z8ZfFUI
9cXojp17RsFc3C9nDGxtKjG6ghfVGRkJJlI9sqJlar3wuJ38Rw7uboFGGhgsbnd3
deFWKTEMXakpiUj4tR4N1Ckc6+iaTEE6gHm9QDH3xLMxF69HMhravC4bhB3on+Xx
U3vnp3fmvsgNYvEHOY/jm5zbsgHtk3jO3SFxzUrbkYV9CE1uZxhaDxX/CqWg5QaD
QpHOOfKFvawEzxz5XXK2m46fJ/E2xHESFkckv/4HRanoGOorKL0/qqNXQXQ8/lwX
YJ1Ew/IowXquFsUrsGCwnZOm1eGPgLUTqZRpgW38mw3PNmeZlidloEVeHHDrl1b1
ApQ5BLucwu8ZHkJeGkLT9xNzUyuWft0QJAinAazMqEpkrr8fUXF/XHExrc3i7VJK
Eel0xyNIPhXAJ2Fg7Rnov/SkPOvduuUf6+h44BTxa/3zj3cSVduP5S0BziuGXaA3
QaZhNzDhuwVKuhO3ro5tawK4WqZzkcQA6hcaTzZCDndEnvzOS9qutFWBAQCr/quM
IWLWR2NVvxZEyraPbtMlvdxK59ihJiDobLlvYKEB5xyZesZN32gjjhe3mkqfmEvp
SOa9TVVQa1WGB08wAXVcuQ1jCwb6maUW5ViK8TyCkiwzoRqtpsL0n8NQc1Wk6iRQ
U8KFg+AU/xHggHHUXk9YQg==
`pragma protect end_protected
   
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ffPk51z5NRtijL4Ysht0aaRppCCDT4q/s7Fn5VZyHnJQCv1ArFPN6YqIqWxkjAy1
yqHBZ/pTaIaHL7Mjr9HaYdY/cXKheWMXoeLhBsDRHsfrKIwWhmAVfg044g1Ow+Rz
0y9lmomcEias6vfJ5jZ4g4jLODQuU/u2SOdQo+LIqw0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 24355     )
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
ALQZXlXNYKcK2TNDIKwLqg==
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_WINBOND_TOP_REGISTER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
BF7PKokI+mmK51EeiRrjJgE6Dp03esyfx8FHFV24BNOWzsyTzw67VRpSV7QwoOal
ZGU1vED41r01YrzZNqmtwAxev2f1/V9B6i8yCyTKMvMaQBN0+jZ22ts2JXeQUfEU
yeNkyfhFMlaOktwUIu4h/6qLDOU3YmCWibDUvFWKIlA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 24438     )
7JWFlYt7lkXVuCjyyKORYb35yK2Yf8UjfX92NDjyPmQy0n8JE+OEBTM9o9XUn1ZG
Brt1H6R2k7QAuLFaleFcw9bhgU/V8mr4N7r/FRMUA6Wgn0noe8aq/MAQT41TumlC
`pragma protect end_protected
