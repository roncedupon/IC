
`ifndef GUARD_SVT_SPI_FLASH_ISSI_TOP_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_ISSI_TOP_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP ISSI top register class.
 */
class svt_spi_flash_issi_top_register extends svt_status;

  /** SPI Flash ISSI NonVolatile Configuration Register Class Handle. */
  svt_spi_flash_issi_nonvolatile_configuration_register nonvolatile_cfg_register;
  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** SPI Status Register */
  /** Used for enabling the function of Write Protect Pin (W#).*/
  bit status_write_disable = 1'b0;

  /** 
   * Configures the device into QUAD IO operation. <br/> 
   * 1 : Quad IO Selected   <br/>
   * 0 : Extended or Dual IO Selected
   */
  bit quad_enable = 1'b0;

  /**  
   * Defines memory to be software protected against PROGRAM or ERASE operations. When one or <br/>
   * more block protect bits is set to 1, a designated memory <br/>
   * area is protected from PROGRAM and ERASE operations.
   */
  bit [3:0] block_protect = 3'b0;

  /**  
   * Write Enable Latch indicates if the device is Write Enabled. <br/> 
   * This bit defaults to ‘0’ (disabled) on power-up. <br/>
   * 1 : Write Enabled   <br/>
   * 0 : Write Disabled
   */
  bit write_enable_latch = 1'b0;

  /**  
   * Indicates the ready status of device to perform a memory access. <br/>
   */
  bit write_in_progress = 1'b0;  

  /** SPI Function Register */
  /** 
   * Determines whether the device contains Dedicated RESET# port.
   * 0 : Dedicated RESET# was enabled
   * 1 : Dedicated RESET# was disabled
   */ 
  bit dedicated_reset_n_disable = 1'b0;

  /**  
   * Determines whether the protected memory area defined by the block protect <br/>
   * bits starts from the top or bottom of the memory array.
   */
  bit top_bottom_selection = 1'b0;

  /** Indicates whether an ERASE operation has been suspended */
  bit erase_suspend_bit = 1'b0;

  /** Indicates whether an PROGRAM operation has been suspended */
  bit program_suspend_bit = 1'b0;

  /** 
   * Indicates whether the Information Row has been locked or not.
   * Once Locked, information row cannot be programmed.
   * 0 : indicates the Information Row can be programmed
   * 1 : indicates the Information Row cannot be programmed
   */
  bit [3:0] information_row_lock_bits = 1'b1;

  /** SPI READ and Extended READ Register */

  /** HOLD#/RESET# pin selection Bit:
   * 0: indicates the HOLD# pin is selected 
   * 1: indicates the RESET# pin is selected
   */
  bit reset_hold_enable = 1'b1;

  /** Indicates the number of dummy cycles to be programmed. */
  bit [3:0] dummy_cycles = 8'h00;

  /** Burst Length Set Enable Bit */
  bit wrap_enable = 1'b0;

  /** Indicates the Burst Length 
   * 00 :  8 bytes wrap
   * 01 : 16 bytes wrap
   * 10 : 32 bytes wrap
   * 11 : 64 bytes wrap
   */
  bit [1:0] burst_length = 2'b0;

  /** Protection Error Bit */
  bit protection_error = 1'b0;

  /** Program Error Bit */
  bit program_error = 1'b0;

  /** Erase Error Bit */
  bit erase_error = 1'b0;

  /** Output Driver Strength */
  bit [2:0] output_driver_strength = 3'b111;

  /** SPI AutoBoot Register. */
  /** Specifies 32 byte boundary address for the start of boot code access */
  bit [26:0] autoboot_start_address = 27'h0;

  /** 
   * Number of initial delay cycles between CS# going low and the first bit of <br/>
   * boot code being transferred.
   */
  bit [3:0] autoboot_start_delay = 8'h0;

  /** 
   * Specifies if autoboot is enabled or not. <br/>
   * 1 : AutoBoot is enabled <br/>
   * 0 : AutoBoot is not enabled
   */
  bit autoboot_enable = 1'b0;

  /** SPI Bank Address Register. */

  /** 
   * Indicates whether 3-byte or 4-byte address mode is enabled <br/>
   * 1 : 4-byte (32-bits) addressing required from command. <br/>
   * 0 : 3-byte (24-bits) addressing from command + Bank Address
   */
  bit extended_address = 1'b0;

  /** 
   * The Bank Address register supplies additional high order bits of byte boundary address  <br/>
   * for commands that supply 24 bits of address.  <br/>
   * The Bank Address is used as the high bits of address (above A23) for <br/>
   * all 3-byte address commands when #extended_address is set as 0.  <br/>
   * The Bank Address is not used when #extended_address is set as 1.
   */
  bit bank_address = 2'b0;

  /** SPI ASP Register. */
  bit tbparm = 1'b1;
  bit password_prot_mode_lock_bit = 1'b1;
  bit persistent_prot_mode_lock_bit = 1'b1;

  /** SPI Password Register. */
  bit [63:0] hidden_password = 64'hFFFF_FFFF_FFFF_FFFF;

  /** SPI PPB Lock Register. */
  bit freeze_bit = 1'b1;
  bit ppb_lock_bit = 1'b1;

  /** SPI PPB Access Register. */
  bit [7:0] read_or_program_per_sector_ppb [];

  /** SPI DYB Access Register. */
  bit [7:0] read_or_write_per_sector_dyb [];

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
  `svt_vmm_data_new(svt_spi_flash_issi_top_register)
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
  extern function new(string name = "svt_spi_flash_issi_top_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_issi_top_register)
    `svt_field_object(nonvolatile_cfg_register, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_REFERENCE, `SVT_HOW_REF)
  `svt_data_member_end(svt_spi_flash_issi_top_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_issi_top_register.
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
  `vmm_typename(svt_spi_flash_issi_top_register)
  `vmm_class_factory(svt_spi_flash_issi_top_register)
`endif

  // ---------------------------------------------------------------------------
  /** This method creates ISSI Nonvolatile cfg register */
  extern virtual function void create_issi_nonvolatile_cfg_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_issi_status_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Function Register */
  extern virtual function bit [7:0] get_issi_function_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current READ Non Volatile Register */
  extern virtual function bit [7:0] get_issi_read_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current READ Non Volatile Register */
  extern virtual function bit [7:0] get_issi_read_register_nonvolatile();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Extended READ Non Volatile Register */
  extern virtual function bit [7:0] get_issi_extended_read_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Extended READ Non Volatile Register */
  extern virtual function bit [7:0] get_issi_extended_read_register_nonvolatile();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current AutoBoot Register */
  extern virtual function bit [31:0] get_issi_autoboot_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Bank Register */
  extern virtual function bit [7:0] get_issi_bank_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current DYB Register */
  extern virtual function bit [7:0] get_issi_dyb_register(int sector_count);

  // ---------------------------------------------------------------------------
  /** This method returns the value to current PPB Register */
  extern virtual function bit [7:0] get_issi_ppb_register(int sector_count);

  // ---------------------------------------------------------------------------
  /** This method returns the value to current ASP Register */
  extern virtual function bit [15:0] get_issi_asp_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current PPB Lock Bit Register */
  extern virtual function bit [7:0] get_issi_ppb_lock_bit_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current PASSWORD Register */
  extern virtual function bit [63:0] get_issi_password_register();

  // ---------------------------------------------------------------------------
  /** This method retrieves the value of a single named property of a data class */
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of a single named property of a data class */
  extern virtual function void set_reg_field(string prop_name_field, bit[63:0] prop_value_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Status Register */
  extern virtual function void set_issi_status_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Function Register */
  extern virtual function void set_issi_function_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Read Register */
  extern virtual function void set_issi_read_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Non volatile Read Register */
  extern virtual function void set_issi_read_register_nonvolatile( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Extended Read Register */
  extern virtual function void set_issi_extended_read_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Non volatile Extended Read Register */
  extern virtual function void set_issi_extended_read_register_nonvolatile( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current AutoBoot Register */
  extern virtual function void set_issi_autoboot_register( bit [31:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Bank Register */
  extern virtual function void set_issi_bank_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Non volatile Bank Register */
  extern virtual function void set_issi_bank_register_nonvolatile( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current DYB Register */
  extern virtual function void set_issi_dyb_register(int sector_count, bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current PPB Register */
  extern virtual function void set_issi_ppb_register(int sector_count, bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current ASP Register */
  extern virtual function void set_issi_asp_register( bit [15:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current PPB Lock Bit Register */
  extern virtual function void set_issi_ppb_lock_bit_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current password Register */
  extern virtual function void set_issi_password_register( bit [63:0] reg_val);
  
  // ---------------------------------------------------------------------------
  /** This method stores the Non Volatile Settings */
  extern virtual function void store_issi_nonvolatile_settings();
  
  // ---------------------------------------------------------------------------
  /** This method sets the configuration handle */ 
  extern virtual function void set_cfg(svt_configuration cfg);
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
MDsdRfsbrdWdWanrjOM5wFn5+K/k5rwWZYYzN3ep8xmOh4mtGrnNv1vqZNRI9nvw
aM/vuB8gqRi9wEK+4W6u8ylz8+68nHbdiXWYC+KCbBRglOrUiCcWFBN+MwiBU1Ff
SimkTBTyF0k9maTy0eYS61pqAoYGznMHBEaFHUoJr3b/U+KDUhZGEg==
//pragma protect end_key_block
//pragma protect digest_block
Ru/nR9IDQqOF1D93tA6Ex28WRbY=
//pragma protect end_digest_block
//pragma protect data_block
52E9ZaC+v9t9/59nT9Xp3qiDhAPDFfqn3r6tJ5oQgMPEDg4D6+xYrNVLjn2eoZyG
E2odmWbY02pBOjRJHdlG4mNO6OjgDO0xVs58nJfUnJXFqzN82VFqAO6EZ+nAEym8
qpgHAr8ZPrncaVKrhruU8IopvXLkXBkwvoc3LNvwINsLMnwc2kSh/J1XN3avBbKM
jRhCTt8CR9ZtRJjuFuxSLCoktCzsL7dXP8dxSZW024idehkRdtztN7qOnln7sg/8
RixmpVdPnUxZ9k3K5XeidMdf3SG6cKuhAHhi3hRysE/cb53Bzy+h2y8PjPYKGVXJ
M6iBiGKk81gydnR4vtMzOk4UsJEB2iSAVOpFVOtupQKSQ+xWZtCpwyDF1k6BIxSw
4JZyYpzXvSYGlxlvKGcCFTThLJT4aOlZRE0IXogv6ZRTmB3RzDVtpwTv6ndtdiFf
VQRqSBSPVFD8gwOVVM2r6t1M0I0qtZE3E//9B6UE/2R8Wvkd/NgzbKCbwG1wJ7SM
vj2vLQ/NXe+BGhASPaO8bmcuo4GhwURdMtY3IkrOShtMJg/wli7xB4FWbMRHLxof
lea0FKe8xq5KMVaorwCBDgYiS8ix7fSTsGNLpvqp8GfN91rtJ4k7BnWaYnj7ZqVy
7/ULWFZrkbeqrhkx52SWZ9ubx2j93Yx1BBFclhp7r1WzIzGSrASXCh990CFX9Z0e
GyW08bth69r/2ca8eyUW3cBvM3uZYmZJlCkQhaSJDOAWpjS7zkMW+Q6Cw5I/2Z8Q
yFtgE+2tY0AOtuPrKr3EdOEzt3Qn+TpMu7ABmb7o71w+7kJQScPjUGn1BwEfJE6b
nwLOYNI9zqsyrmzJ0sy/MEHBp9Qs5OAHtKcIWyEKJFGxhy29yO4gTwocmUIQ9/q4
ryoWUXm9MgbRJWBQ+xorA5mUckaobU6ZSi4lu4l8BdcpTxSkbf1fPCNY2JJMgttw
Z2GVHAfezErihyq6o9ywXiKlOEmWqLOFX6zRTN1z21vPPXwHKJZXQxNADMtzbupW
DMDg7VKvcVLAbT6vZrxZ6w==
//pragma protect end_data_block
//pragma protect digest_block
ziNnt7OXgtO9o+F4ge8+S2VoMzc=
//pragma protect end_digest_block
//pragma protect end_protected
   
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
mcLa2bAtLTHPqKtl0Wdl0VDZ4GqLcIw8Zf4An0Ty2BlIlAJtxZKvHsKGW0nXCK5e
GP2tYOIU5SL650jFcfINNf2eVrx7NGxu89oUcNXtMq7WyaWhK5Cnww7ij7dp+Lv2
SMHuUv0dKKmik7/pz/OvdGrIvIlrtBbtJWaMZIPLTGfnMgx8P8hZ6A==
//pragma protect end_key_block
//pragma protect digest_block
ccPVtn4dBLJpwxBcrOqesv1k3v4=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
v5Fs4t7mbodQBqQw0YTaGzqPksc=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_ISSI_TOP_REGISTER_SV

