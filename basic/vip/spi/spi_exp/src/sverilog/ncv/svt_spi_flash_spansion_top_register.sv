
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
/n48hp1lmRGHrwD3d/oAYvk4E4Gy7C8XvXStW4hUnKKAZudEic21lPAwUt90u6Z/
Pwdms12D9jcOYEdDFIk5DGmaSg6YQKMYtT+9lHtsnNcY+tluFP5Jzz/yTmwN4/7i
56FfQGmyem4zPvSv2WzCFfU4KnfLKEgDFXY6r+Lfys5H54f2OYjHJw==
//pragma protect end_key_block
//pragma protect digest_block
r8+f5kxVTfnakDgO/nQS1ZxWyfE=
//pragma protect end_digest_block
//pragma protect data_block
fH5FsZyQXoczBaSe9pE6HGhWFQwY5Ib/yJfe45qtPUB9sbraz9+AXXhQnehDTIEF
Cm6ZjAZbfkgUebDzMkddVbVdRDzm82w6QAW+sBVz+FlXB3Ba0GAh8uFzkZHd5s2f
aLb25SnRMOxN8plehHoyMv2VH8OtbXVX8T/Yy0/GCv8dKVpdWmtvLnTHio62FWet
ziYbH64Aa0T02pV2CNND76o7VXTOnhOX4Eai/ygBdDYgDhqVKxQa+sFdpRmtG04m
cMHGLnazkRHOID74dk5Yn9WC3TVPldvB2Yu/7ZP9Ig/JbU69G7EzPk1xKZ7xCOIg
85CdrczPZ41YMUFVBtam8rULI0kRjLhssMWxVyLKexkGqtLtjb9/i1+QSAysF5pX
eITosMw25ujgyofTkVPOIWdrL614qQKYoV9tupYUccL9oqSo+8lptAvRBh3jZtUw
uiJejDoAbyWBJIuQS53S5UkKMdDne8mBSITpLiL0ouoEjjqDbsuECMLJVRUPFflk
ZVg5QBOItC2QMIhY06hb6GHlWlmm+59Gd3HshB4slZkyeF3pzZgNBhvgzeyHf7C3
VF2RiYiiQMug/VMx17B6QO6Pc1qUMBZX8UwyeTqjR4Gln+ogCAFRqCaIOcA+D3pJ
Zv5YLAW7SkyoJU8FdAy2eGTnooExkiue1k/M2k/nTxcMKX/c14dsZtQJ7wcQ/5da
lr0RE1yblI2BlOuSjxlwDEFYMSisJf39DXIbBqmt/cDBpyQmwtyf65XWxv1x9HPc
QtXIiIpQWAL7n2cFfyLq3ijKuRAP2qRTaPgAT7nxoFDnEJsFsFjT7Zm34WGTchtf
tJItPInEkkkHWa8DqBvYl46IOxZJF1A0SFBy1mR/bnq5E37KKIQET7Zp5+8XLz96
WDtS4XlD9ICVaQUe3hBB8SK0lUbCZV8/VHFnRXT+QlBrujL/v8UaMKUnop9ms4Rg
LTeZ9H83zBP+FvTyyjvqQL88uvn2Qky0if/UxLeSEB8xwJSi8dajLc7bvLzjkA8g
TRQUNgoHJK00QRr6sieUq6OiL6UMVXziJ3mcRPql47A=
//pragma protect end_data_block
//pragma protect digest_block
KpVN69wnq6H+LSDynIKUYX4kRDM=
//pragma protect end_digest_block
//pragma protect end_protected
   
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
EwzQJBkR7rVD4O7hZv8kPbBXR4J+vN9vdymyv2qdtaJBaxN4GF7lwzx28Z2zxn/W
9dS7JBu0Y2pCneXngoSgouHukBMBmhiGyc+OdJnMRpUWtzcZ/mQJX34V1fxzhBQV
19Mhd1fpgPX6YuYkdn8Pmf9VzYjNBbliys73H2QV/yXW95B4dxEK/Q==
//pragma protect end_key_block
//pragma protect digest_block
q3wwa46YUOohfulNc0rHcb4YwFE=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
xfsHrX7BLP6M8sxKLi0pC7tPFAs=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_SPANSION_TOP_REGISTER_SV

