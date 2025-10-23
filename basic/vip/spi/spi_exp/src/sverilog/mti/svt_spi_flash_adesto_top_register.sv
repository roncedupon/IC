
`ifndef GUARD_SVT_SPI_FLASH_ADESTO_TOP_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_ADESTO_TOP_REGISTER_SV 
typedef class svt_spi_flash_adesto_nonvolatile_configuration_register;

// =============================================================================
/**
 *  This is the SPI VIP Adesto top register class.
 */
class svt_spi_flash_adesto_top_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** SPI Flash Adesto NonVolatile Configuration Register Class Handle. */
  svt_spi_flash_adesto_nonvolatile_configuration_register nonvolatile_cfg_register;

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

  bit [3:0] security_register_lock_bits = 1'b1;

  bit quad_enable = 1'b1;

  /** Sector Protect Register */
  bit [7:0] sector_protect_register[];

  /** SPI Status Register 1 */
  bit sector_protection_registers_locked = 0;
  bit deep_power_down_status = 0;
  bit program_erase_error = 0;
  bit ultra_deep_power_down_status = 0;
  bit[1:0] software_protection_status = 2'b11;

  /** SPI Status Register 2 */
  bit ddr_mode_select = 0;
  bit auto_ultra_deep_power_down_enable = 0;
  bit auto_deep_power_down_enable = 0;
  bit reset_command_enable = 0;
  bit octal_mode_enable = 0;
  bit quad_mode_enable = 0;
  bit program_suspend_status = 0;
  bit erase_suspend_status = 0;

  /** SPI Status Register 3 */
  bit wrap_type = 0;
  bit [1:0] wrap_length = 0 ;
  bit write_protect_pin_status_n = 1;
  bit [3:0] dummy_cycles = 4'h7;

  /** SPI IO Pin Drive Strangth Control Register*/
  bit [2:0] io_driver_strength = 0;

  /** SPI Read-While-Write Configuration Register*/
  bit [2:0] read_while_write = 0;

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
  `svt_vmm_data_new(svt_spi_flash_adesto_top_register)
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
  extern function new(string name = "svt_spi_flash_adesto_top_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_adesto_top_register)
    `svt_field_object(nonvolatile_cfg_register, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_REFERENCE, `SVT_HOW_REF)
  `svt_data_member_end(svt_spi_flash_adesto_top_register)

  // ---------------------------------------------------------------------------
  /** This method sets the configuration handle */ 
  extern virtual function void set_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_adesto_top_register.
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
  `vmm_typename(svt_spi_flash_adesto_top_register)
  `vmm_class_factory(svt_spi_flash_adesto_top_register)
`endif

  // ---------------------------------------------------------------------------
  /**
   *
   */
  extern virtual function void create_adesto_nonvolatile_cfg_register();
  extern virtual function bit [7:0] get_adesto_sector_protect_register(int sector_count);
  extern virtual function bit [7:0] get_adesto_status_register();
  extern virtual function bit [7:0] get_adesto_status_register_2();
  extern virtual function bit [7:0] get_adesto_status_register_3();
  extern virtual function bit [7:0] get_adesto_io_drive_strength_control_register();
  extern virtual function bit [7:0] get_adesto_read_while_write_configuration_register();
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);
  extern virtual function void set_adesto_sector_protect_register(int sector_count,bit[7:0] reg_val);
  extern virtual function void set_adesto_status_register( bit [7:0] reg_val = 8'h00);
  extern virtual function void set_adesto_status_register_2( bit [7:0] reg_val=8'h00);
  extern virtual function void set_adesto_status_register_3( bit [7:0] reg_val=8'h00);
  extern virtual function void set_adesto_io_drive_strength_control_register( bit [7:0] reg_val=8'h00);
  extern virtual function void set_adesto_read_while_write_configuration_register( bit [7:0] reg_val=8'h00);
  extern virtual function void store_adesto_nonvolatile_settings();
  extern virtual function void reload_adesto_nonvolatile_settings();
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
eGCZi6jQdoqsbtcRwT+C7o48CrM4E988jw1zJBPtyM918/xfaJXywknvD68F7QnG
foEGwV3IZR+aukJR72ll99JkNQrOsUU4kyRy5JaXJvDAurxe56Ze1JjuxdwjjM5e
TR2vePb6bfX101VLYcP9ddXHGu5GYM3TAOyRzlAZkhA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 626       )
Ing3wu8Emi/F0CV4yOm9xGVWax+WYd52hO/7tm4Ih7pKKBlC2uRGot3OyyUCbBf5
fMfW0mNdOUQt7yF/6WnJVgJM70jsIr9VmpK4rUNcN/YzzMvfRHBqeBFNG6/H1Aax
CSqKb5qE9WU44aSTH7VEABClhipluCPYw9dFvnXNSqaENKDZxUSngfzAiIqmmlgR
N+W6zYq6nPY+9oRvF6VoNtUIlO7P/APWfrG8N0vuOvWyiTYYx4dxum3e+7GJe4BF
1zUJtD0Tlvitygmo+M7OP96y3kfRBps+bM2yMGBOA4Yah2uNvQ9wjL4qWYHxh0Ly
c9/lmnx5QRZTQwzS1txYeHjYkZ3jihXEtnznRjpwZv4xgNHLd91odZ2TZoIs8lED
LqrD4msXGpvCzuHkUaifpLKRqujFqfxLM+krsB+5pk4SgPP5yNhdSq6CP4CbRACn
HUbS3+TqBAvrltqNKzu8o1z6u6sMHSTynrVVOZwma3l3ijLA8lMwk40z9Hqhmscf
0ZwDg6VEg3VrDI4SHu6eg1Z24/0rqm+hiVbDqVMaP0tFg9CY/L0tKmJtwP52nzR7
Nc0TEMSmNwy+V6ajAEaHAyjBov9BPy5+TWfqn2SRuxnZQI+/vWeI4taHUczBV0j6
Q8wEFsyCsBMfPgqxFxzYQURf9de/wLHb3GgKk6zmf9WwfWvHG+KuwgYCySj7W6gz
YQib6bEf6rho37bRI94+thW96I/JcRyby4SR1/36E5GBDcqegV5OuWjJWgPxS8/z
LBzmRo3lCeq2ifRxolCb4CzKZucdCfgexms99Lff5OJLzW6Ob54nVAXYbn/ipNfF
7s0k4LW56tL5YtXmGdpHdw==
`pragma protect end_protected
   
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Xov8n9JpzrgIlbFWVaYIx/xFvaquMHXlwwXrrO/8txM1oi2Sj5Vyv4hykI7fbmqg
HwENtChRsGt9X7RbQ+qtE5Y1TizgwA/yYTlW4v3VkHYMj1N4L7Z8A74EH0fGPP1a
E7ltFaX5LwNwRNDxQRLnqK8iulI2eeWQPFYqglYsiNI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 26409     )
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
MyatXI4SyReKlBdZsU6VGw==
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_ADESTO_TOP_REGISTER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Q5dDBEX1IrgYWfqg0qOkc/hFJu/avBWlS1iG9rktlso8M9YNn5UT/LiO083lWC25
1YIH5Aaqq5IKafYEVHI0RZxIfPuFT6sTb8FNOoMxuZdQnC4dkQF+M828Dww9Dkw0
R4PGrwZpLnm86wX/pgOjx8qRlPcE51OSezTJlUbwk38=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 26492     )
4mpaLbUq/2bKv3Stox03ZX9SsMxvNRDjmYNSu5wABR2Dv8p9ZPzTBHI8n8Z0qxSZ
C5yk5tZzjQnyiUPLTF6vmbayN2ofHLQDCUFbGhxcQSTd73GveK7RpGi29AYTkgxm
`pragma protect end_protected
