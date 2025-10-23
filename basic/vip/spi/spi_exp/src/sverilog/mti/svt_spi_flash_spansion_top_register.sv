
`ifndef GUARD_SVT_SPI_FLASH_SPANSION_TOP_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_SPANSION_TOP_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP spansion top register class.
 */
class svt_spi_flash_spansion_top_register extends svt_status;

  /** SPI Flash SPANSION NonVolatile Configuration Register Class Handle. */
  svt_spi_flash_spansion_nonvolatile_configuration_register nonvolatile_cfg_register;
  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** SPI Status Register 1. */

  /** Used for enabling the function of Write Protect Pin (W#).*/
  bit status_write_disable = 1'b0;

  /** 
   * Indicates if Program Error has occured. <br/>
   * 1 : Error Occured
   * 0 : No Error
   */
  bit program_error_occured = 1'b0;

  /** 
   * Indicates if Erase Error has occured. <br/>
   * 1 : Error Occured
   * 0 : No Error
   */
  bit erase_error_occured = 1'b0;

  /**  
   * Defines memory to be software protected against PROGRAM or ERASE operations. When one or <br/>
   * more block protect bits is set to 1, a designated memory <br/>
   * area is protected from PROGRAM and ERASE operations.
   */
  bit [2:0] block_protect = 3'b0;

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

  /** SPI Configuration Register 1. */

  /** Selects number of initial read latency cycles(wait cycles). */
  bit [1:0] latency_code = 2'b0;

  /**  
   * Determines whether the protected memory area defined by the block protect <br/>
   * bits starts from the top or bottom of the memory array.
   */
  bit top_bottom_protection = 1'b0;

  /**  
   * Determines whether the BP bits defined in #block_protect are volatile or non volatile <br/>
   * 1 : Volatile   <br/>
   * 0 : Non Volatile
   */
  bit block_protect_non_volatile = 1'b0;

  /**  
   * Configures Parameter Sectors location <br/>
   * 1 = 4-kB physical sectors at top, (high address).
   * 0 = 4-kB physical sectors at bottom, (low address).
   */ 
  bit top_bottom_parameter_sector = 1'b0;

  /** 
   * Configures the device into QUAD IO operation. <br/> 
   * 1 : Quad IO Selected   <br/>
   * 0 : Extended or Dual IO Selected
   */
  bit quad_data_width = 1'b0;

  /** 
   * Lock current state of #block_protect bits in Status Register, #top_bottom_protection in  <br/>
   * Configuration Register and OTP regions
   */ 
  bit freeze_protection = 1'b0;

  /** SPI Status Register 2. */

  /** Indicates whether last ERASE operation was successful or not. */
  bit erase_status = 1'b0;

  /** Indicates whether an ERASE operation has been suspended */
  bit erase_suspend_status = 1'b0;

  /** Indicates whether an PROGRAM operation has been suspended */
  bit program_suspend_status = 1'b0;

  /** SPI AutoBoot Register. */

  /** Specifies 512 byte boundary address for the start of boot code access */
  bit [22:0] autoboot_start_address = 23'h0;

  /** 
   * Number of initial delay cycles between CS# going low and the first bit of <br/>
   * boot code being transferred.
   */
  bit [7:0] autoboot_start_delay = 8'h0;

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
   * 0 : 3-byte (24-bits) addressing from command + Bank Address <br/>
   * This also depicts address_length for S25FS_S device families.
   */
  bit extended_address_enable = 1'b0;

  /** 
   * The Bank Address register supplies additional high order bits of byte boundary address  <br/>
   * for commands that supply 24 bits of address.  <br/>
   * The Bank Address is used as the high bits of address (above A23) for <br/>
   * all 3-byte address commands when #extended_address_enable is set as 0.  <br/>
   * The Bank Address is not used when #extended_address_enable is set as 1.
   */
  bit [1:0] bank_address = 2'b0;

  /** SPI ASP Register. */

  bit password_prot_mode_lock_bit = 1'b1;
  bit persistent_prot_mode_lock_bit = 1'b1;

  /** SPI Password Register. */

  bit [63:0] hidden_password = 64'hFFFF_FFFF_FFFF_FFFF;

  /** SPI PPB Lock Register. */

  bit protect_ppb_array = 1'b1;

  /** SPI PPB Access Register. */

  bit [7:0] read_or_program_per_sector_ppb [];

  /** SPI DYB Access Register. */

  bit [7:0] read_or_write_per_sector_dyb [];

  /** SPI ECC Status Register. */
  bit [7:0] ecc_status [];

  /** SPI DDR Data Learning Register. */

  bit [7:0] non_volatile_data_learning_pattern = 8'h00;
  bit [7:0] volatile_data_learning_pattern = 8'h00;

  /** SPI Configuration Register 2. */
  /** Used to enable the QPI Feature  */
  bit qpi_enable = 1'b0;

  /** Used to enable Reset on IO3 Feature  */
  bit io3_reset = 1'b0;

  /** Used to configure the Read Latency values */
  bit [3:0] read_latency = 4'h8;

  /** SPI Configuration Register 3. */
  /** Used to enable the Blank Check Feature  */
  bit blank_check_enable = 1'b0;

  /** 
   * Used to enable the Page Buffer Wrap <br/>
   * 0 : 256 Bytes Wrap <br/>
   * 1 : 512 Byte Wrap
   */
  bit page_buffer_wrap = 1'b0;

  /** 
   * Used to enable the Erase 4kB command. <br/>
   * 0 : 4-kB Erase enabled (Hybrid Sector Architecture). <br/>
   * 1 : 4-kB Erase disabled (Uniform Sector Architecture). <br/>
   */
  bit enable_hybrid_sector_arch_n = 1'b0;

  /** 
   * Used to Select 30h Opcode for eitjer CLSR or Resume command. <br/>
   * 0 : 30h is clear status command. <br/>
   * 1 : 30h is Erase or Program Resume command
   */
  bit enable_30h_as_resume_command = 1'b0;

  /** 
   * Used to configure Block Erase Size  
   * 0 : 64-kB Erase
   * 1 : 256-kB Erase
   */
  bit block_erase_size = 1'b0;

  /** 
   * Used to Enable the Legacy Soft reset Command. <br/>
   * 0 : F0h Software Reset is disabled <br/>
   * 1 : F0h Software Reset is enabled
   */
  bit enable_legacy_software_reset = 1'b0;

  /** SPI Configuration Register 4. */
  /** Output Driver Strength */
  bit [2:0] output_impedence = 3'b0;
 
  /** Used to enable the Wrap Feature  */
  bit wrap_enable_n = 1'b0;

  /** Used to enable the Wrap Length <br/>
   * 00 = 8-byte wrap   <br/>
   * 01 = 16-byte wrap  <br/>
   * 10 = 32-byte wrap  <br/>
   * 11 = 64-byte wrap
   */
  bit [1:0] wrap_length = 2'b00;

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
  `svt_vmm_data_new(svt_spi_flash_spansion_top_register)
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
  extern function new(string name = "svt_spi_flash_spansion_top_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_spansion_top_register)
    `svt_field_object(nonvolatile_cfg_register, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_REFERENCE, `SVT_HOW_REF)
  `svt_data_member_end(svt_spi_flash_spansion_top_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_spansion_top_register.
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
  `vmm_typename(svt_spi_flash_spansion_top_register)
  `vmm_class_factory(svt_spi_flash_spansion_top_register)
`endif

  // ---------------------------------------------------------------------------
  /** This method creates ISSI Nonvolatile cfg register */
  extern virtual function void create_spansion_nonvolatile_cfg_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register 1 */
  extern virtual function bit [7:0] get_spansion_status_register_1();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register 2 */
  extern virtual function bit [7:0] get_spansion_status_register_2();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Configuration Register */
  extern virtual function bit [7:0] get_spansion_configuration_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current AutoBoot Register */
  extern virtual function bit [31:0] get_spansion_autoboot_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Bank Register */
  extern virtual function bit [7:0] get_spansion_bank_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Data Learning Pattern Register */
  extern virtual function bit [7:0] get_spansion_data_learning_pattern_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current NV Data Learning Pattern Register */
  extern virtual function bit [7:0] get_spansion_non_volatile_data_learning_pattern_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current DYB Register */
  extern virtual function bit [7:0] get_spansion_dyb_register(int sector_count);

  // ---------------------------------------------------------------------------
  /** This method returns the value to current PPB Register */
  extern virtual function bit [7:0] get_spansion_ppb_register(int sector_count);

  // ---------------------------------------------------------------------------
  /** This method returns the value to current ASP Register */
  extern virtual function bit [15:0] get_spansion_asp_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current PPB Lock Bit Register */
  extern virtual function bit [7:0] get_spansion_ppb_lock_bit_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current PASSWORD Register */
  extern virtual function bit [63:0] get_spansion_password_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value of current ECC Status Register */
  extern virtual function bit [7:0] get_spansion_ecc_status_register(int ecc_unit_count);

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Configuration Register 2 */
  extern virtual function bit [7:0] get_spansion_configuration_register_2();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Configuration Register 3 */
  extern virtual function bit [7:0] get_spansion_configuration_register_3();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Configuration Register 4 */
  extern virtual function bit [7:0] get_spansion_configuration_register_4();

  // -----------------------------------------------------------------------------------
  /** This method returns the value to current Non Volatile Status Register */
  extern virtual function bit [7:0] get_spansion_status_register_1_non_volatile();

  // -----------------------------------------------------------------------------------
  /** This method returns the value to current Non Volatile Configuration Register */
  extern virtual function bit [7:0] get_spansion_configuration_register_non_volatile();

  // -----------------------------------------------------------------------------------
  /** This method returns the value to current Non Volatile Configuration Register 2 */
  extern virtual function bit [7:0] get_spansion_configuration_register_2_non_volatile();

  // -----------------------------------------------------------------------------------
  /** This method returns the value to current Non Volatile Configuration Register 3 */
  extern virtual function bit [7:0] get_spansion_configuration_register_3_non_volatile();

  // -----------------------------------------------------------------------------------
  /** This method returns the value to current Non Volatile Configuration Register 4 */
  extern virtual function bit [7:0] get_spansion_configuration_register_4_non_volatile();

  // ---------------------------------------------------------------------------
  /** This method retrieves the value of a single named property of a data class */
  extern virtual function bit [1023:0] get_reg_field(string prop_name_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of a single named property of a data class */
  extern virtual function void set_reg_field(string prop_name_field, bit[63:0] prop_value_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Status Register 1 */
  extern virtual function void set_spansion_status_register_1( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Configuration Register */
  extern virtual function void set_spansion_configuration_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current AutoBoot Register */
  extern virtual function void set_spansion_autoboot_register( bit [31:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Bank Register */
  extern virtual function void set_spansion_bank_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Volatile Data Learning Pattern Register */
  extern virtual function void set_spansion_volatile_data_learning_pattern_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Non Volatile Data Learning Pattern Register */
  extern virtual function void set_spansion_non_volatile_data_learning_pattern_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current DYB Register */
  extern virtual function void set_spansion_dyb_register(int sector_count, bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current PPB Register */
  extern virtual function void set_spansion_ppb_register(int sector_count, bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current ASP Register */
  extern virtual function void set_spansion_asp_register( bit [15:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current PPB Lock Bit Register */
  extern virtual function void set_spansion_ppb_lock_bit_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current password Register */
  extern virtual function void set_spansion_password_register( bit [63:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current ECC Status Register */
  extern virtual function void set_spansion_ecc_status_register(int ecc_unit_count,bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Configuration Register 2 */
  extern virtual function void set_spansion_configuration_register_2( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Configuration Register 3 */
  extern virtual function void set_spansion_configuration_register_3( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Configuration Register 4 */
  extern virtual function void set_spansion_configuration_register_4( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method stores the Non Volatile Settings of Status Register */
  extern virtual function void store_spansion_status_register();

  // ---------------------------------------------------------------------------
  /** This method stores the Non Volatile Settings of Configuration Register */
  extern virtual function void store_spansion_configuration_register();

  // ---------------------------------------------------------------------------
  /** This method stores the Non Volatile Settings of Configuration Register 2 */
  extern virtual function void store_spansion_configuration_register_2();

  // ---------------------------------------------------------------------------
  /** This method stores the Non Volatile Settings of Configuration Register 3 */
  extern virtual function void store_spansion_configuration_register_3();

  // ---------------------------------------------------------------------------
  /** This method stores the Non Volatile Settings of Configuration Register 4 */
  extern virtual function void store_spansion_configuration_register_4();
  
  // ---------------------------------------------------------------------------
  /** This method sets the configuration handle */ 
  extern virtual function void set_cfg(svt_configuration cfg);
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
XIphTfp4hFFB2yaWK26hmihJSq/yqfrxusp9ZQmBPSqPFJMAhPupVISAZuobRmgj
rKd5OCql/GfXppeLWuMwNkz0iO8hI8WBpGb5HpKa+Jb7/YiRdhqXbcIhFgS9CqTB
L0BB0WjzzHTuOC1Tlaj98gqMH6Kz6k8EpO3qTn3F0Jc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 634       )
yNXVYq/Nj6r89yfjMaPZRrSvdJ/VAihXYV9pvBDTSTcVRXJ19SkY+M40YG29dYcu
9A7AN3tceaR7pcHGywg/23wUTF1ur3LzAhKFDA7P0pbdi/+UkWrr5Kl6IKTP9pMm
UbRPLRmO53sgcWQrQm3AqNQI+mW0xuz3U1zqr0VwYiQr/k7f5qtiNNuN7xy0MM45
5KiBJ7TYITRv7+6NX3J18n52WmXV4BIt4VKyc8CV9xf8SV3tz2TeRJZZpIv4OUhy
BEVgp4IT/HN5Kly2/QD5JzrI/o1826lFX7dHyVoFijgZpIq2rNxPvUhnGFChiZKS
v9hn3PM7jcGsd59cmm9ASOPnuplEATAjh9mqY0ECjAr0NZh6U2VquxqLqjCdt+QT
c4EaFc9nPXxdFs4H4yIk8J9O63McBdkmn9ZvGdn8ROqWd3oGTybJ+IEDxqwRgLxl
rJ8qdlGkY0NaMHYIvaLpm3GY/RKqZEY8F2cAXDoGeMmLYgAjtoUAB2BUDYEThR7F
sXTIFUbA0HUPv5Aw8f3zwNzA+KYaOGqOtT15RVMz8Rga9wQWaS85mK3mF/cZ6mxu
v9Jq++jzNs75QYYC2UPZysGwFDERa1hyofD9atINJGtSbyxGJf7VL4znBdeJzo28
V1uj6Kd0r+EJjKxSpScCkBl7ta6eTcq82+qajl2qTYPTqoGmiToooz7Mb/dqDlRt
jSlB3X560Jz6wZeyLhe8rcoqmPL8GITXJMDuWnWjVTA2PuW6d8lEj3l9qijFUJF5
Ve0p6t25/rSDry03FhtxFRXDt9XqtTnQJw0RRcVy2T/LvqBW3HGgqZi0/1wHHcEz
lKLZf9lezo5XTEng0PAYlg==
`pragma protect end_protected
   
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
UN1s6SKQ1QvaornElZ1N5brGINUGuGp8kA7qH69KE3HHFA1RJUjJqmRBtb+Q28vG
58Ofr+yw9JAsAmJN4SB7cNSQw/6nlB4SkyjWt0OATBg02ccpHikeOfBkjiTsJ227
AOP0/hBEfX03Gq7lUJY1XuHwWzrFgRWz+eSr9fZ5jTw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 42455     )
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
J/XuzlWgrOUabFiF/MrIsN/XEmFmqZN0U2YkD4swtbgjgVqNSwETeB3gglm68kX6
nTDTXU7Rst2zpdTmsTKIoPyH5kH7Uyyrq16uNvlr/s4WslOVhCq43n+eiqjPKdzZ
T6iv6nmqXU9MPm2PWbS62D7yDQ9U2NPtr3mlJ1ZW12dNS+fQSCrglPYaUaae2khA
rqJC66O/RJyz9As9DbJcOX+CexPIA911SYMrkujcUJEDX6FRYVnW+84YH8ZvcVPG
9QiFg3scQ8HdLGjHfwqmpJJVmpHYKXocIhLw+uaNJKLKTZ2b1Mb1QYXmYvHIWoFk
ncU0a0GNFZLcc93NiRcCqac6vYTuiE5ahf+bhuqaMWwRbpV/JgW3uiW13nDLArc6
j8zc46gc7+tJkXulBkouM6LfKCyGFWSrKergqYfK8gyHq4gw+6IMjxTysGy8dQ/w
yzL0BwyHQOJnpRqEzcP1keBvtrp/oobo/tiVQoJDuYn6d7AwQszbOLNDbmj8zsB3
cC3Ax7PsNjN09VbTeDlbi695ZdrcSI+2nZB+mJKhszootgZDK8N38c6FPwTwDFJy
ksnw4quf4pLRfSoWLm5YMMZYVuXWo4UVm1zqpaLs404Fzl4f2DB0zCIy7zhhzrmJ
wBXsVEAXiSwRucdOSqDnd//KVez/9u4eFPFyEX/nvJBOizwloRbVLZbp+w0jH65J
Hfj/BbQ1tls5VDo6CqtrDdeGZQ9Dsc0Vxo/QElKjHwBPr8D3Js9d4r2rtUof1VbX
2muGGrdf5O0Z2c+KpTw4ExjqotIDhrcsLI6vD/mG8Oh7Diki8iYRaTe69WG+oopY
uWqdCfAlB8yO7M1NiSlNsPyWdDQLso4xNRFQDbsZk2I9mPoSCqPwRwgCH/nhAggd
quhUBOZXG1j4bmkkTFPVlyceJm8Q14x0uZcRuYFA7k2/EoY4PD8MuUbYa3y7gHU1
K+iE5p4CONEKn+p6wLbbhIXT09dMor+T76w178V6HgvB+u5bV9UBAwDpUhmfXPih
lFfP1sd3bZrp/hlAFcsyZkQV0+tCSgtm/Mg+WrIeXHCb8OzxoZRnpMWm8t/XRAWn
2tXWCSF4n3WUCOoZcZQXHBT4Rc0DczNqh9QFrbeaiNzniZhRU0QXavAcLvT2UFlu
7ZPs2rMTqZBr2ADlDJpR51wRuLOn7t7MUPy3w2mDMRVNkXU3XS7tPbpeUATn5Ez5
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
yRsunosKNTrRFdljZM8SaQ==
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_SPANSION_TOP_REGISTER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
bwVn1xQ0cXzfpIhLk0MpvhRKbDg8MegXQbvLZX1IRDJ6k4bqhNKLQR8JzvHyAlaJ
Oi0rTElWBBBFREIKJVqy8U/T2oi2x1HwemJo8wsO+A0ucsE+vWkt0u9OiBmAA7V4
J0TrC0bmaGA3lyjwXUCxFYHES4OegUm5QnjC2I+EIjM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 42538     )
MYj6cMFM3nZJlYP+yD4kuFQmGemXygnDC7sd6TKfF0EbP4u6zVEPWLvznBiMhJkH
fPgtGVltifS9FPtIRtkYjQrvXJdXFIm0iZTsW/ZctirwfzcDITKqwjUoUtcgwOy8
`pragma protect end_protected
