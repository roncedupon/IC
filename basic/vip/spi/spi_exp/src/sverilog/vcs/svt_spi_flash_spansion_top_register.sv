
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

`protected
<MT5PA^f3GZAe]=M^[XV&IacFFZW8IAb78/>dcb@KgWNE&B?feHT,)YT>VMD)E-<
SWg.aaKZZBSg)HLRa@UTBI,JJ_JR:M#NA/+35K,CT_1#XU8[d5#5[B&L45=.J6bI
_<-c?#eIb#:2SOC^4FE?_=&FfV/I7P>/@=WM5U>U579BZGPaJ_BKc_6DSC/O88NA
C-@.O59U)#+U0JEDJO<bFYMI1ecNC@Q?ZRSg0>6,Ya<&98gP_-0.Nd^e\?3Q_?/_
94EG=g+QJS2<:1(A[82EQfWK4B@1<:SKT&\)0?5AZNHe@dSd_@7B.2/VgJP8F#66
>+X?cc)@K0\EJ/I?,fEC]7a>)UVWDB4T/F-QUG/;\E5;/DbU+PVTJFc8&K83?^<>
CMGPQ@#T2OC4+J@-(Nc8;)5d[N3I:INT:eL:Lf#N:G]cTZ6NQ9bDPKS9B8bD;\<7
>ES)+#8b^#_X5DN^2LPMA\QMScfF8d9Pa?(K:]C].QG,.L0:-[V+,Ma4<K3a4Q<[
H&/S62^?C[7LP0f/Ab=CRaE5M52Y(?c]gM<VF4aANbd&ZeE<QT5\Z13Y#dG&]?](
0Fb,_9V+:HB]g>H&<TbCgB=QKg7\_I)b;-^LU90b:X_9TZSA_W]R]=8C>TXN_^6D
-[fA0eSTQ9G:L+3I)\4XQ+D-[WCNKO;QN8G+fe[1K.F/_)DKOF0A]Y8CP$
`endprotected

   
//vcs_vip_protect
`protected
V:#aNQ326,BM6>5H0V58,]:^B6)Z(N4LD9a1bU=5a(8:&#UeF;eJ7(29OQ_F(#SY
9W^G^_8I9c?AMI(11M[,C#Ib;E>Y0H1@O\+;fH>]-g^9RSb-.QJ+-7d9>Ad3-PAb
a\;CQG[9MH@gQc=V[CE]>D8)g;\K93@G?D=CQD6C0MI#@VLDC5aO+UWYb(8ga=g;
Q1.&b5FaUeJ./:_>-eC27gf+EFTGTMbPc:O-EQGWZ\;g=@c&f(_g&C/U):J,dS7=
[Q_0aXeST)ga84L.b(73N>bQ]L6(_fN<Kf^US+2]gHJ>_cdXRb0NQ-@&BW/<WRQ(
7GfLgPHZ>(EMYB7(?/faH=BR^(2Q]dKEWMM45R<B7W19Q<KJ[Z,cV9\@],(c^0Y&
=d_)C1R4O7Q0L?H4FP^+]_X[agD@6-<ABM6N);f)#1YOdO,>5DHZ;56a>0-YHU6U
e^Q<1\aS^OSS9PSWDX@>97I(U-E3<G4Acc9;4bNTKQWX85WVT>^GZFaS1K3#-dK2
:X2PN:HU&X54bP[44S3,\c11eW.]c=\fR<>UM.WIG(V._E@<>F,G4IY8XNDK=;bY
/efNeUYeSf?VF9a@+eQ.fQ8(8EIDG871gG+XKb3-H0--4#6B/7^Yfc/+QLYSBQ36
RGN_MTZ46J)6bCK2EIF4]LDCNVSbH1SZO;CXcYU?f\WX\Ia4O^g4WCAX2e)K)efP
4e)_GE7>+FQfDP1XJbKXA)52dRc<&92<@6<^7Y1Z]VEI&\+C22^50&c4Y#a,&5cY
(2ZKd\&:E:Y>-.@HQgDI]f3=Of&NGAd+,()[];6Y+a8^?e2=EWeTBA^A9P9e/;:[
BCS>?7LSKF^:L9BC>b4YTKG\HJ5>1ZA(MM-=5cEA+Y)743U8&E[:-ZGS_V\JRYFX
U<QDQa<&L)GV?Cd;LVfY]0Y/>O]>0]YA(.#6Aee,Zd<DG.K1&b#_=R4@gd0^bZLe
B24Wa5HdA3P2f-TNTVce(\D\EHP=K.6&\U+:dV^Z+IbGPK5PCQ[d1A_g_bKSJU3Q
QU-^#./F15]29V@Gb5WMOCULG#O90XCV&(8_GZ^H(-NaK6OBNe_T.K#4#Zc>AM>#
,9Y[[<HagMPbF_7H,SA-GaeE=AM8Ne6I??NbaG=EF3+#2ce,U_Z@dWHd8-Ab-WRf
e:+a(W:3M(QH7@0/D3/fB:0?422DT)Ra)],PWGL0<d)Q&4QP[L4SO4:6[4Ff7.&g
[I10B;(]VfY?7E83VeS22>9CeaCV_eVSgI3_N33RYN2TWBV-Y@9>D@DM;N[CG(<<
F#a[J5aPb3UT8g).LD18DLFEP)?a413Me25D>e5Gf:^;X5dV1,P;M3LF>HE_eQI)
@/;DOSJ&7@X6G91\VL+WOQN:a(a8G=a8?KUP6@UJL#COD+5/EUM]NUJ?A3[@VP_d
@V6NY)1dYeMK85_AASIB^,BX?04)LI(K3Ifc[=V5XM)JME,2E=<1FRec)J?204,;
KYZg(K,Y0PAc^f49YH1:_.YCZPPLQ/V6e+acR;&K1Df7=RJJbSG@8?B;:>gd2E8]
\d<TM/;R)JGB372EK4.W<G;Y<\CD])[X(MO6CNZ^]g(?)/aHL(@ANE00+]SMUFaY
U1g@B8>JbFLCQJG3fNKMMLXIeQeeACa3g.YQK<;Z@\:Z>fM1LH92\6[eGf-ISDMP
PCRX<I9c(RHTeC,N2#HLK;3g&AIe8dcMROQe7D/-5MGUH+LS@Q=@7f;TIZ.fBbb8
]2@X<E/K^6_EW(RQ[2#fJb_::O8G9UD92&OB#=[BYQEW]Ba-10C4QS14^OAdbDeP
HdA9JZR#_D/=@0abdGd8TBDLZSXeCUVK4gSd##\4QIGT9MgG,OG88M&T/]-.T=R_
;ZeXfFbDU]1)8[#eAZ@5.BbbY[KDcR=eH^cDAHPF3+gUMeN[bK[PSE](K.g[\f_:
MX?KeL4AcWT3b_&/T@bfT[gBXHfX<.ddJ\+M8QbQP2gU<VX1?cU,0f1=Q/^QfFC:
:/JL>A>O359#YC\IOOT2=_+T0OfEE>D4Y?GZB0I^NgM>>D,g(#SaS@-[5g&CAe_)
BI8+>LdTEF+GLfSJ<L_V#,#f-<a+QC#Md+?V^dMYbR99O5-a+J[NCW;#3d8]FW]Y
e)5=[f;cP:^)Y>8Z0c=_f8T+HRa#+H8XO31OXK?caSMbE#+&&99bDTPQbM44[G?2
99=<TNAM-FO--55)f;T(M]V@C]4C]8:cY#:WT#<9>)5MM.Y#4IRdWC9P]P/#8O_E
N_<TW4GbLfY4g?HKKP(6\>N8-236R1RI(6LWac\Q4#8MY7;AP(=-&1+O3U,Y\>2Q
)>\GG;KX96aL[CHdZdQ/0c[/\@MU?(YY&IXOVdYNHT.,X-EEabA2L<]CBeXVJ.\E
Y3+1VWX=_(<1UYda0&fTE\963LBc0]TW^=IQ8)[aSM9_eE[711[#CDP5Pf>M7NIJ
+GB:PfWQ_P,9=:A-Rd3MgN1aN._TAM,d+>Og4F.2X\L1NMI2gbA-?T_7]ZWXF01G
]V@FG0aaNcI705Z8L0EI98c+b?:bF)EMc2\4)6eN0H9dFLF52Ag>Ya1JNL-20KC6
)0>+eAN^.3Z8=U^b;c]UOc5,@QX95F.E4=[8R5GFM7E_2C3V]Tb[dfOEJ+0@RC+f
OP[@KBKbGQMPBJ)?^6Hc<14@.AT&:5YOM/,Ig\<3e3R#JS4GQ]P]aaEM#2Z3.ggZ
37F]RG_^MS\=g_CH/7+UH_c4@X-6FRXe3fF<8U<]>LV5E9__8OC+>148_+R=N4Y(
N?CG]JEC1-)L7[_8^@aTa#1G;M5O(b\4>^RKe+X1>Q_5ZVRDJ?R^Fe)?VVQfV1W3
E3cdUZg0.Xd@A;7[W5GPS\BL=N5D[7b;=ODbG\>CB6\SZAY?0C[aNS?_8N=G>Q_0
F6V3V]+(](J(KJd1@C2Ig4HRf?BIPQ>N\2^cF)cP_,?8_8-N7[a50-?TE/NC[K1#
:4J=/KM\cBd]fT^@?FdUcUO2U]&b.ef(aQcX^L2c:W[XGU<VaJ7^#TF^AeZ#[NNA
8fdBRI:>a5A?1JHN.ALXM2e23d(@KS+BK+CXKW8BAN8GK7</3&C(+Mda/<aN_O#P
4.II9\68VHd([Z9e4?N[64KNEb.C=-#<47^/1V74eeML[&ZJS9R>V.bD)P-=S2PK
3?\gHdX\ZE/QE8ED]G_e3a?9?c@)_J0\6^K91+8>&V1:C#3Bdbab0<a4JIG;LeXX
EM5&&D6SbQ1@J3]Y#afM^S1KY-H?P7OS]SL7?5/d5-+=87Ug9>FU:0TbDT2.7,HB
DC3KD_<T_Fe3dfbCDHRPRK9dPQ8d^e6N4dD^#7>K:UW0ICJ>^L,cLbN=MLfSA#f0
F3LHdMB]G^LZ?S#EU_0=YPXRcg+P0Z<HB,K[9SE5-]^VQ]Y@3+OY/WOMCOB0\,[.
S?:2EVR-RT3LL_)CATB3N&YN>A@,Ze(KG#^88KH5A#N.b>3YJ\,BPV(TggYBB-H=
eH;8[a]G]#_P(E_M#f]CGg^P_0EgT#?M_Af57T@\<,\>BMN^9b8#VB]G.//J^B<+
S:PWd@dR93(-0V)9PGA,)\+d+5dA2\TW2eO)4JY=M.Bg,_5,M0UH];HCBAE=[d\(
7a9R1:+W>2OZB5##=.=+):)TDIB@Q5@UJ5YdJ@OQ-BIPF5=(CU@e=V#_(6BX^]d:
>C4-<6b<BGH86.AFJKA5/0WY-Y)e9#EXYEU-^S.P-Rca?WX3ec6a+O-H[dMSdW/>
5J/GC+,IZ/[K2d-B?]+@DH##>1+d-(K[TcC<P^+AAE=UQSMe<]LFe79H&?K-[?G9
NDc3+64_T_O6DB,^EP#K+W,PF0,RN5/K&QLa()WAS90GOBXC(U[ZL.G#I>#+)D\<
,9YOIDPUI/GRW\U]>P_1g_aDIT,U6R?LY0gbA8daCe:V\9FBFCC&<MLN/3U.3YGR
66+VQeY7C-<]4M8K_-XNbc+D.L[DXGJgFI_AH-JG/<a>JIcD\gI-\1A;_0@D-(I<
7NG@VC6:C]f5^Y<PW4[L<Z9SQ,_e/,XKUNC8Z,bW=fa;,CcU3fE4O(QUR9.^_\:?
SSJ483eLg68bEXDQD[BcXW_E9;Td_W[HFSB(e#)M+Ja?3TO?cG-;&2?]TV>]cF-a
BAF_^2/<1-6e)MF+aD7.6/K^9M#<]CR.9(&ZFK>(&Y+/]@>O.(-E[HVd7b0JP.f3
/E(L\BT,^X<T)1N>[B?YIA)@ZB7>9&21gc-TBDAZ=M1\7<L2LRKeO69-Fg:7D]AO
g&5(_ZPd/_:dY;dO@aPXUd>5B)D27)<[;4VA;E:c9/C/;F;ba6O[DJ^GK?T/IHdW
SeY(J58OVb=89WbXPV3_0-K?:Q(@eE??e]a\UJE3&X@YVXbNNU0(PB3WD1P33R:C
Y-G[-=^#Ha-V\VT:#aG=c.@da[8d>R@R6/G/Oa8H=;YJLQdA1SWH\7?ZO#:,/&AZ
c)R9a6Z5CH\GL,K1R.dSG68c^aI)FKR@BTe6W>]D[=ZE.3M2)0.O^LGAN_D.N.6P
6>UB#>(4Jd_1A#F1=YG2E-gf@32^JQP[X/3B5[B>7I8]])+HadQ]d=3SN.[)HNa6
4+7M32[##,dF)F:,GJYC-)B_acaVXf#LBY,:c18;e^-3N&KZSQ#N-)>[VDWV8c-R
6\,g\W[a&-3^#&eX9aJ;/cATP>E&RP?B8[4+6eA@>\(1W/5<X>(5TN1K<EJa];DQ
^g_@R#U,&@V+e3ee/G&9(ePB&##?2,L+6&>587HQEfSW3EbXF]\3BC]+c2V#BJbA
.H0.O8\/b=bZbA0QJ-M\fSfV.-ERDdD/L12KI57?SE0Ga[UZ>]S?/RS,]N(>LTM-
4dbRZZbV1GE^1#JL0H=H;#Pg),U_F;,G3RO[/V]TeL9DD\H(I#]2G;b2#ML+C<OK
,:8.JSM8HYOY;ED?dSW20@ZK8^PQ[<;;/__==G#cCVBaXG_;)0W9<9NC9]JS);d[
fX64YF3Z3J/Z9cZ>4J>B0;XaQ<T+U3dJI5MVfG=<&+64R#XaK<L&5O;d(]d.;PI)
)Y<#I]4B^f+8]<>U^S&HbI<E9FKRfQPCZY>_dETP,B.UALbN(??\<bPMV^g^]=:5
TN?g2A(6QQbb/YIbZ<A#f&;cA34/SG^MSS,RF,E1A9TVB60BR2a=f_7V&e6gPBNe
/5;a(4BTTNYVc\@E8Yc@BAA0DR^P(8UA:)QDYY.eU0459BRQCBJ[\?LDK=)=X0IC
GE(XD.8O=<[fL4^gC2B]IN4PRO9=;8F:-8QE[@\?=II:=^JTWU/H]B:66g+[c_Wb
R244Q_,ZRX\eJ?F64b)^<7_1K9.<R0ROPJVLTbUROXDOV0a:D^G=/95E)[J-K<P:
LOQKH6JC6=S,,_<aaK\:6GX7LObE9MB\>OS762aKV<:-/OZ)R_S?,KYG-/->Z-JG
=b2U.1W^ge1(.f27C_@WGHG#6^Ta6HLeVPV5LL@?H30-c8G1W=?9dg6HYZ#(:WGW
9]ZYgSB<]J=1f]#I:R=a9:&TTE)DK[\CXb?fN_#5R?=;d8M/HUS[A6E__&-f/I^,
A)/UQC)](MGcX;GV1X.<?J2@-+2F4SA#J96Sc):?ML4@,B/&5DXSC##]C=<NT-A+
=gY+,&+,&W@6NV4H-9]TCKA4EMY31U[3)COaW+]g54?+BgS&Rd6R5g]=2e[&13[M
9.fRD-\3;(?+9HZVKOb\c@31^c8D39:/c_Z,f[YVEE[G2W_\Q\e_?>TIJbFKZF_Z
#E:<^aF?A(B^TU(RfI,Z?H?X/J?>?0YDV&aS]\8.R:X4TD(,VL4L,3X+UeX/PLXA
(]TT-9e6[.=T;WdF+M9KNSN:[=6TMM,ID,HZ7eE()D]3?5U6_3IbIXDX+,&I_HX0
O-0=7CeZbB9-FbQ;_^+#QKUY4^14:T@MAEUM039\3:.4J7MYD[N:\\1XA+<LVJeN
)]Qe_Z<D5)Pa7b?IO..4.dCD\<:cWePQ[+MZDBT5RNC>ZgSb]^OCA@6_b:RD^07I
-g0T/Q[g6?,0:9T7?G>[M]#A=(f41]g9_EdU2Gb^eJ3@>[(NW^,c,c5C(F?O_1J,
bW]U/^9Y8F8RX)<NSLOA__^92LgLJF]]Xc@L@0R+N=DP1Q-H)-0<;FF1\BKUU2cB
ENEZ9?0E4995?QGJI7=H)A<UZHWDI-&3;&-4W?H-dIg(LdHZRfG^@a(M7Ee<aZ-X
=L7Ea/L35)gPJCRdgc;G=GNbSR>(K(0X+2<&-2HS:E=Z4B@16Ta9C]ZV]HMfY-GL
AR5/(J=-)-[BW@@HH>6:/S3A1PV-YT_E^HHC7UGI+#S)LAJ,R)--6A:f?W;I+C(J
B5UCOGV=Z1F)T5/TeW]GY6619\K=YW>gL1P;=;\5[f#Y50]P.&O(E7R<_[46_QEY
f\-ZU>4fbG-(aC?[UW0>8EcZGP?W4A1Ec;gEggP/5(SfJ[dOT-65#3gGBLJb-T);
+F/3A5>FBc+.CBf>W(1B(XcN4^7_>FNN18MA#<g/7@N653g^@NQM9?E&16KeB)S=
e,VW#^g#RNd>W@;W93aJ4?_T;.S/O<]&=f:fW/OdT6N7H0b5U>1dL3_)G=9Da>OB
F&N-9,8J7D+gbJbJZaT\aJKc7>-.UP:TZK/59CJLLP@X.TKR=.;Y-N9<<LA8?cL0
@bVYSA:207Ye#LQ\PVSH^_VW<e)L#4[.&<0GMHBb2_UW>NM]0gYR@K?&c(AJ[gOf
R:=CQX.Hce8#ac[0<)W5H>U2gYFIXJ<_[3E>[_UMFO)dd4R[4>_M(b?TAFWLe8Z6
R.#Ue#MB+Q&8)21AVaC)AKG^7SDQ_X;&X.G0/HE=J@_KdTUAAI^dV2_X@4(6V8\6
^8RdgFX5(@75G&#a3UX]GU8c#S<)\>[SEXIS=_]aQ9YO<_@YNSM0;a]WN03Oe3O@
/a9Z=Feb6Z.6R7)&_a[N,fbWATP-[EN^SU7>R=/[Zg9(1fF^g8PB+C,Vea:(N@^(
@5OYHZ5=8<La]AYJ?Q@#?OUGKZMf79J#N+B)/RcR:c/S0K1\d<6JF:/99C,+_GcX
:H:LOWE49Ua?ZY-[V9>eA&904;C\SW@Vg&Z>WceNAHLC0.NO[^+a)926B8X#V40X
W5B_F44a7\b/D?O5MU9(c6LFX8aR&V4G/7X75]W1\H>;\ZWb_D5f:Q/c\:,1PHJH
3DXDPD)Y;,0K?&c4&\?#c,F<-,O2X:(<DUb.DBE#=P)KOQW537+g8[4b-QA#J0Q,
/8X5H03X+4:OVDK9bSDPe9Sc(:GDO4169EOUcCBRFU\beU<2[BZ^TaL/XdY#NB/^
F48g#UEI+D@(_KGA2L0R7J@\OT1\-FVY)V&06UV.6.0+E7#d2\_(0.7]e.fCCNES
H@=Y&\e3??4?^:][X^;fSb8JGM:BYZH.c83?V(/@g+0;F@IdG/g#IdHHf)g-=:]K
FD#)[_\4N^agENT,JMIF>1dUMK9,[&M[,QG(APK>;?PYRWb@[Uc<-_F94FWD,FKU
G-^6NWO8#VY:AB&D[f/@];9/V(J80X,dW^+&cb2/P3#2#,^JX[_aad,0:44C&UO3
5aN5ge#4O4:91^IdZ@Q&aYg34_;YbX2=La]g-;[_EWgDZ=(&-e.@V1F;>]<4VTP)
?H@.=J^9\PW3/&^7]#DGDDNf7-9BTPXd,TG<&CYd2d.FbWAd5ADD\^702ME^@K47
W^8_LdB@ARacFUEF@(9L(-)C2eLe_Y.;E19?4EQ^YB3U]2RS&(1SQ11d>Y_>^dd0
(I_CH5A+VV[ggFb=OV47X^;M&>NcdRY>e_&4E9QMS@e6&V4B2&2f[)3D/=<LcA?]
<fV>gR^C?gQJc9d3R:c=+F0/J/7S(ePgfWI5SM_J^#UPG=()R:d:fH(H8+OPQ].7
?_c9&9]XBUW[R;EAFKc[Ed5WN^M;ROagN0eae_T6dO<eOfB/LE,M\S_gJZ#+G.E0
MUK8P[^aaBNKT&FFCZ@cE4(D#-4/BMFIYH<K]K7R-Z.6Q_J&,GAJZVU\@ZC^eNME
;\QTNMe)Dg:fENDBDBb90:_YKOAg+eQW@O8;8EHK+\UZg)H#6KVE(_]]TX\:P&UF
e-/cU.;SUT,NGI/&b1_;-XR9B>PR##P.\SaLP./BRTDO5V?5JROS05VO_gfaB/J0
e1ZX=,6M)/HffN5S/d_O7b5B^-JE5^4=-V4J1?0d?HXT7a?]BDZYg(K>=O_[07\Z
//+KCeeXOeRd0Z+U)>)^Z([KTB^[7;M7-1?+-7:=)KI2Y35-12\BL700_[K]=;/<
/7/;TPWdEGHU.K<GU@6@\JgBMLGZ5EOd3a8\B-b?@LO^DfA7QG6],_A6M5baeY&]
e+fFbbA)S&AI+W>_VWSe[)H2ABOE0R1c^0IEQQ[K2P.Wa7.GD?c86OV+71E+bJ/5
IT->04_J<05,4:JU&@2L0>YOd55-bg3dOQF;c\Q231#&FJVJ\+Y0PGGF_Zg3=[MG
T#6T>b/\\=<T#&[3Vd@;f^=a5]+g)JT@J)PC>=PAANUc>URNX\3fLA6:=?\B^JfJ
TSB#PBORU]^:_<I)eWeA;ZL>+30@Jd.#/M\9H2]KKKU@1(73W6T^P@XXNFP969Z-
ZW<^\^T=G?<fa\b?FHP>7OH9)>@#:H=g(W3Qg2ALePUZ>eXba]O37f/_?aKH7OXa
=\3/,O5,Q&T)VLHGOH)fK;Cg4KMDTRT8<]dZ8J5T/VDU??<EA6dYOQ_/+OZC6&VZ
eK[5;GD8gMK>a5&&O4_VW4aN^UgO__1T.gd;W1=C.EY3+K+WZBNZ&D=d9X,G;G29
f/<ZQR3(;8AeA1L)52/_#RC6c1Uce>K5NdP06R40\e+R_)XCVb4,B9>^IXJRQTEA
&D[6S.5ID&dLd@&[^S@7L@<(:)3V58SC0C=S>e2+?CY^Q1G/J5#,D;A=:&_4_@Ig
^UdDXCV+]D??dfZ_8<])AUTE#_71WCNfTCVMY)0P>J_E0^\&9U7^^^VdR9d)PU5L
\UKK&Pbc2X^3:CI0X55(2UJfde4KT@&6AecBXGZ4S4I/edL/5)])[0<(Gg4PL9Ng
?J]P4<,^+\gH&>E,8Y11<?M?Z+#MM_UI(GgVD1HN>GG<=X^T6._[HB7abcdZNVM4
G)KT_-aM:IUO(XH\f8F=+SG0c4I^#[>^@IFFf^Od4fNK7bWH-SD@5V0,?98#]8?0
>[aOF&G1CC.91XdQ=7].beaHWNS0-M:f=+3B@G&(BVB6_FVOX6&NgY6fBb]bYgUK
/;N2cSS&TLI#2+5U:]_A^?M)?X[5Ka6?Sd)@,;38/NL9CTbf0R.eQ3+F9+O@a),6
7,(SEB+R>_QXQO+Z19,D#7]VP3RL7I#3YL[8TbC#>Uf,N-S;MQHOd<QEMc^[86BO
Ee?F0bT)CfG]d3IS3W;HW3#N@>T\OGM6ARdR<^f.>Y]PGG#PSRTDJB>279:DR+/b
F^<-49:2MM)e8:4#/7<f\PU[MX79fNP:^J16]#)1Ce^X9R/2aP0F#D3?7XSF&IY<
7AZM9#@8aG<B32PLJ_.PMQe?;WG>3/Z?-6.;b)^OX;A5\CPV?>W>3#VE=E6=8U5C
R1gYV0IHE7K3YW>P[V-d[@#F=,M:5#_PNZZ[PA:bXYgcAeU)JYbN:E7_NfA5@GKE
E_DQ86>fI;&cYT:+3ITVCA.4Za9E+.a&>J9[a<2g@Q-VdDA.7g2G^4aB)O;.LF(0
^,aGK/DS5N4gNGNZ-g7TM;1gYIJc?K#Z1R<5W(fKAD\]4[)@Z1f/#HZe:e^FO\9N
aGPT2VSCQY(U0R;9Z;ZF3>)U8)L-=Wf_KY3=c^81aK_M4K@d2DG.8JRg2aPaX5Wd
WZVG,+(T_Q+IRSdgR+EGYN[TL(M8fKWa<YZF]dYRaK+GF:3c5V[[_,Ed3-<)1c)N
=,9S^PKaK//)J9<e9R\bTGS_f+&Q)/F4d:+NT4cUS\2c1E7O;1O)]gZNP1DB#[<0
1I_=O#K@8QT>dXI[L-2gSN/)EYWg0R6Ac?UCFFF]A[LE:Y792C,<?[@^-FO3Qcb[
V\V+Xd[E#R3b7)XNS_QA?+ReKUbPeA^8#Vb9Ld2+d02G2N^FQV+<51_4SP.G790B
DZKS/OLc[X-aaBcS9//GA\?Q5g9Ac>2MH)R@a\Tb;<F6\(\>agC[X_?g3OBZ\b4c
+RC360.3_aY@[Y8ff-MD0](0=6Qg-,_+A4C#)I.<EK4I@0BW.0KD+^b+&FHZ\>[R
0)<JFb3J/U+c(>3L+SG6LV@6;]J_H.f)KUQ)ETd/7U3c:ZTQ2R;cH8]c1TQI;(^:
LR@(\MQBUYJfD,?I@Kgc0O]WS&SUf6F;VZ-=8@R=FfO;.aO9@&3PZ5XI7BeDM+.:
OcVIII8Q,=]VL8.B)KXD&6G?V_C,3F:cXZa\4=>PRdJA#IN#;O)bBX7Fg7_IPbc;
>2UdT;J49A18?5S:_OXTPAfM/Sfd42K@GU_[;;)I[@eL]eVE^HD]QXG#DH4U#9R,
,Z0cA36O&SEFE4#?,\VaNW3L&J[IQVb,J\G&f6=1P[ZY>>[RQM@1JK=L[:R@5Wa(
?-\FAQ53gVS9UXF@0AT_+UGP07a^c0SES7XYgCaIa-N,9e6+25g+a;/EHAF,dJgU
4&Zb6bMV?6OTCHR-G]6J96bAEVbP1>M#7QG:G8MAC;6d[Q6N0KF_cN=VFGEZ(W)a
@dEFDX:)@_ZXMg02F(?ZQL?&:&>#2/#Vd:F&SLgY098ag91cDf7^OCJ49:@TRJ/&
]JXgF2Jd8bF&ZF+V\);:#c]DU[VXAP>GT\2Qa9R+,><a/fQ6IN=[DMeFZdVgGD,_
bd3@V5+)W4^KLN<1cM8>GIETc(REbgbLC@gAPN#OG0&UC<WG^VF>Eb-LEV,PT:gR
CTHYAXa+<_1c194[,+V(DH9A5:F>QgVa5B4A>2TVP_17L,SD.;C6LZKD0aJ+;C1;
ZNTS\,X7X6<F-Tc2WWBKTHR&dZcL(614>6\D1MXKe=4,N@@QD5>M&(V?@KG&NbWQ
g04IT_#f[J:@G@#gM^)24K,LXPFc+)6SK<MXeG-^C]_59:,bUNP,\:ea=f3)_QN1
HS6<#\4/,7?HNWF;G=P_faTUJ^P8EB\&]<>)K\CW@^T2c,?[UKUVO:N+=U0c-/3S
D=_N:RY#KNET?98c-WCDN:]Kb;Tc.d_L0fM(2C&J3F51CW(W562QD3g&&:+C64F_
=MEM.9eA_5KJ+4,B<FDB((aId<>QVFf8Y<]1XPcCRZ^__4O3#NVIWef__eFFOZ6=
_bBa^#D,OV\.d@CMVNPWUKV/Ua,MV1Z7?EI4>g9V>2[R//Uac&JL#(Ef\QL&c7RQ
f2CCQE?KO7Df.S[ad]6]Z^/.d/?)I<U,c)=(I=7312[J5+Y^7R25JBeNAdQ+/22f
)++/GEN?KWJO]&GPPfSGB+KO\L-32H>N?QO-5a8X:S4+KZ?a52E]K()d_MW;4f0L
2eVOL>H>T0LdSHO<]?SX5]\)1fYLJ@6#NF)DQ=Mea/ZQ3e:X?fYb3CO7f(A@dWE9
TbObG#2-=MZC:U);+[WXL4SM2[9G3QV8XeW0U_Z87<K66/_@4gBVBA5](]K<<;_/
9f7_.?T_D6:SK,[.5=@+GN-XUdWOPZBUK#O6-(CNW3ORbZQN^?(LbKPC8ZR#N0NG
58dYOAC##=F1?K^\2]EN;P0f-)X7R)<HWS-GM72VS6dcVNIQ\RBPCeA_ac@\Y#C?
)IJ3O_.U#+Fc_@-&<J^BE3GOBC;c\=9R.=79,)65ZL]/UbR;eP>Y.?6WJg^9aR;E
)Tc.IDOF)13AFHTNZ_6CGD.I.:F<LUM4KT7Ab]9CegGS?f:QC/V6#\WH\gMF(EYQ
L?0R22HR]#AfRFY4O_1(D>=(FbIJL]@7+=+7EYW02_6P-QW^KC5>81WgS3c&[D,#
1#YPA#ANK/SM7S.aLIPB#S&)=MX)V8N#GW/fC]ML4,+1)77.M?aTCJ2&[Qc>6GH3
[_\2UD[<d[02FI71Z\-3MEMeX5@ARZ702^MYW0(+e7FF@bP:F^;77@RB-4?YHPR=
e-0Of+&BSLV,3#X(U9f(#bPKX0Q+@4R;>ADg\2I]O?B:aKM(BEc.(JOJ>9@cC0K.
[g+WNO4MU\>U68H0fB7NJ,[\GY&7(VHA6LEWJTR,T2e)QbE[7bg@X:0CF@1CQH3g
-T#V\S>BZ8ZTOXQ+5B.E#]&IBcEY6[::KF]^8FX?]BIBNc(V(cg2Ob(S<OaCU&3&
S(/-<T_^&b[1Z,6LfLKY[_0=DDHP-eU_<_)]-@KB?5F)8>gFde()R)_5W3D/906O
2LSI59dER;(AN>-d7O^_fFHeAJ6K/JCB]_P4GJBW=S>;);67+_@X0Z1A[dD:JJ_;
Y.E?A>#eF]HSXUF6CA<]:CE2=eQ1Y-EY-:4fIfP3fa=]f/#-bX.f/RD2Vg/:2ROT
dWI>dRJg=@-]@AQC71\UQZ=[ND1619#G97<M\[5U+CKBO(1QgORMX>6gF^6HB>^?
Bf^&d3a3[^A[:O[Y+LT2;c>O8TJ(e.+>MXKCIaNK8=[3+0XB,O]XT==,Q@4d_f._
J#;c:A46VAHWJGZ)I::6e0QI(RdJKWVJ;d#4SIR>MM+:TFE2A3E)0AbUMD@ASbZU
KdT#Z+NLN@KDPZYCe:R77^&FVO\d&WH8.D/<c2_94(7dd56PWEeZ)]A7GeGFd58P
bDZWV2CGB\ZH^+0IW,5cWOH#O2a2?LcdU]G4S_U/#:-[[N?GI1UQfgS[#QbJP0OC
BFb9X^[aIa_>K@Ub9c]R[@W_X>b&IcfLdG>CO&^U8,QW,a?Vg<N?;&C?L)12dPKd
[F]@dDbZ&)6GYF4efNHOA6PVbcPN(c_QGUE736XA0a8@gY?809T_8)cbHZ,[0KC+
.cA,[L#eHK1H)>>0HG9g>AM:GJ+@Q0B-eITWG[U1ZSLV+IO2U4D28XTZ15Y+dd\N
d[SL+>D7dH+_Ma9GXDR-9,ZL[3+[^cPX9FCPCZJ>b6g_=8HOEJ=MHEE35<:IOL,/
S^PR3TQ/.O9@U_Rf)R;_,TE#OF[A(O--U@#;D@9c&=O>RLOb4TGbaeN?_HGVH\4Y
VaD09-abTTM#^;W.b/T-fA_D<V4Acg_0EBO)[_[L8?RF)OEJ9ACL\W#(@fIgUd0g
@<SCSX^BdKbH)Tg,()7XS\fH99^\HYfC)/WZQI4X]ZM:9A.IW8,;4^[]5f.T+^><
-bTbPTD7bgT.SUZBJ@Y=ATFAb(<-<8;F9O7NdYL.YG;@D.IfDUK^YOT6&:HA;T0)
5(901T@@M[]NeZ#K&5b.+b\aO.A=K:6JggE_0<L,^K&6N4Q,QgTKM?;BA]=\)=V/
Egg3Z^-Y-b=<A/[:K60)_^G7CU\,9C2/<Z7R&A3<aKVZ5Hf0=MaC7K-RBa5A^>(7
[12#/SYJ(,)T4Aa_^&5EKIB>)ARKS-6UHQ/;;QWMgaVDRO5f2GNfRTfB^&:/+FV=
&b&Z[8#_JA.F^M[4;93F4E4:-fU#L.+,?Xe;B^WFafS.+-1cNTG;KC(8T/<WcfPI
Q\7NTLWA&9(KDIS-4YOU[eP>4]M(@+9/VS>ZeKP:3b\;X6S@I,bZ@:e5gJ6NeYCU
_0#fD2CdWG34BV-1-gD(#[6JFB>\66)?I_Y-VHbMYKUc@,&DFVO94-E]PA\_CLXF
X5C9.8=M3BU4;bMWfGWFBXbVFY/bY_fS3/D]LOa\g[OJZ->e28g:gLY_3ZX-]GZ_
E48YE60(H)JWB;ISJ2D:fQ;5HQ1O1^[]/d_2;/0^:4D/V(F\LT0(-)+MHeb#UM@b
G,+J3E&8fIQF/XZQg&Nfg2<B5Z6P&8/X:a14_4XP3[LV23?2AL:b8O8G\)@Q-<bN
ZB/G[WQcIO>J49)K_J=e:YVGP8[VbIPg;3UZ:#4SC,,?.Ea?T=CUfI:AB/E<-V?(
8&R.0RJfYc:\KOG9K+a^eY[W/92fX91>26<<;70bedU^LN;P7=6X108ER(gdS?69
-WX01^)K75bGf3RO2N7B+LQ.eQ/(W_=TbRF9Y;,gCQ=QB1e:5ZX(aWPG.>[:65CC
<;-<PTT7/7X^KaII#c)Gad4=0&=EA.AfU]L7/UB7@6C]JO#76\3MbS/F^7\&bbD+
?Y769:)Y^27bEF@5TW/&PZMH<^>)<3V<\S<Y9,?b(+C80\-W4TA@W;UXLCd9;g5.
S=_E7)8CA=:PS018>)LID?1;Y^89L?W_B5fdM#=J0\T_OV0AD?:LdJ34DN=g(\=O
\Hb=EAF?U,+6=HKC3e3SCeCeQcFNTBO:[6<SA@P;K7b:3N,FfF??^C_Q>eQ#W-QL
?6,3+AETIW2\X2:Og)@^aaSaLA[QdOa:3<?Y0WH#5gSaR;,00H+e;e6O+<g,cV(6
C,L4M(4e[dG_Z[gFY?TETf6KX3./IYgEK:6bJ25O5E69V&U_Mb^&13cFA.5>AQ2?
TI_\E,]W2137;b.R@Aa70]7WN[Ig]M65IQ<@+[f9S)C8.-70;YKfdIYX6df5_XBY
dL=UXAY,MU#U]?PT01,4cR2a#--<dcL)AA<B?A0H1E>Md\02R,Q>#_(1f@18X:DO
PQ=1G8P,BN[YCfOWED9H(WI4aR[Ve@/Y+Y:O.R5W&f/cSSRV6cQATXM/>Y\0Y]QR
1(e>X6bG,S?M=+B2&c.e3d(b\=6Q-7+W&eJ?(Cg2HAcR+QR9C>K^XS?1b56/b)B/
b9fS;[I&5<YbQZ9,3@bJOBO)9:Z?YWe;1XXS=#/_UEL1H8(bN);Pce.GI6GF.UQ@
\V6ADO7F5-E+>cX5-PWEQWLKBIA>2LMVTcBg6#>,a4(2SZJDNA[YeH^E>UBZMR3Q
2.<+b2?<\C(<C0ODS5fF>,>AMWg;ULA\PU,]fOLE<J>gEX6bRZ>/20R-GY(U\_)^
.#R(S#V^P63GP]S#11Y6aKd2\W7<9[,Bd.FC;[gW+V0-5QK&2aJ4WS;LH/I8^U^,
6E.eQML/c<gM^b_-[1R=c<^\W:#=)1AILV^06B>SY(#GF5#)2Y@Z6bW#[[XB>=AZ
H<F;27dD+a)dMXcLHg6V4+PF+#?6ZH],baBC-L5Sc:??99_&-R/?F+#_XX,_\M=#
\VD9:#=XVJ#:KEVJZZFa_1,/,M:>7dCX&@)D)14P/:0U^J/?CC=UZ]RQ<6YI\J#.
-Kd3)PGaeVdGgf]38:ZI,fg[.f?3]I5EG]#U=-[O-L/_[,gOYegYJJVSfNJdFgcG
\abP=)B[/^S<SYJVE/+)0<VL47X9bF(1T.Q<^#adTFZ&ZWec]9VII.D<0g;<4]Cd
90Cd3dXV7V\]),,-9a4)fc_7E<fJQ\,JB2--4gDd.gca=(cGbQQKA7LdPID1=4^-
@Igdda&W73.gM_F<B)=4E::Q3SLQ/U7?Z/)?fTb0]ZKe<)C@HV8,WOAe>^10+HJD
D>GHTVKIgFSJ0H&;.3fDM2RD<286=eJL-WXEL3;VHCbCafg?YO,JD>Q6VB@T_&&(
U#HD+Z2]@P2;cEeG^D0XMg#(,Ld[92-H0CgKNc0M?KC5gbOF^]4f4DFHBSVfO[U_
Q6ZD[R@UEY:OgZGcDW)SJ?\H=[a<Ea3K464:17PX@].>Vb;W5c;,cfH_R9GNbc1f
(XOFbB=)ggVMIK>72OL;5d4C[W8/Te;:CKDKFZXB&f,4@N98<A]U-4bcJ+07c2\]
F2Nb6>ZI+PZDF\JgC2B.@ADWC0fU0fDET=b/H,;<GYFfS(2@2]A0E&:X@711:BFZ
-,+:\#GLb=2gE]C4C/^=4CJf:0G51LP#3@cFf+1.YgIC[d:VW^\G(Kf:Y&87D]KY
Z]e-5Pa@DeSc?Gbf\\QGbV.6=Dg,dJKGX;g21_UZLcET1;(:KNC>Zf\]<3?:6X&_
,)I5?a\ZF?60/^e(,I_>OJ5<LBS:S\ecJ?9c@a/P?G61_]K4JD0TaSP06GeAS&Hf
#IQ+#+XJLOVbLDT2Ig_HT.V[[0C=HBOWV^3LE\H=Q-=G4_TO3[E/L<96cIL5]@+P
BY/C(WS-J/U059g)JB\:6MOM:TXa+NV]8WgI<D@A>_K).2YV+EF.WI>CC9Z=80g4
5(>KST>5)H(UQ52,\DIT3=Z<+Lg@KQT(a9788,.SLBVQF6B>-_[NRV.X5:<5,XA<
SLXb4E:,^1Ld@[B@.;ZdLa1KdM,JF5f7,N0UFX/PbC\W41ebRc38LX]_6Q[d=;dW
g-/&).]]INa3<_,A_V2Ne.US1OLVH@B^#4T.3XeF_\9^@MEJWgGe&VdgV<R):KPH
=#g,ZRg_L@.(c#M@],M+N6#^EA&8V?.gW3#-d_Hc+^BS-:6_99Q9c0OGgP-<(d=6
\EB?7K?E@D\4SCW529QTKY>C3XN@MA7WD6L02R:d,eL@DT2ALIg=FFX5@BT0PU&T
b^a.SJLC_DPIA&Bg.THK9(18/QL>-F1fFV#VXX?WI4::HMGTW>]4)O-HV,NA90H\
@e.9=0MXCcBP.e0DB&]L^7QCP0J(-A)=R2aM(Yb(eI/P=>B)g2TZ563@PAFg8@F^
.1K0D9PVV\5?NcE1[Nf;e[CI?/U8W2>>SI/<)IcMR2G8N(be1E\E0QW1,<#HdW)N
6cM^.B&YYYZH&E,H@89^1-fafY;]bM/2DLb4FNX)4G58WY3XNRH[,?A<@21#0VON
X4)<L:B/G7><0&K9NBD=DIIDJQ\TS0\C:[\cG/WQ0eP3UT=:cV0/X5A>(WOE.64F
JP:QI(+_daS9PZ)7P][f(Ab/4C0#-=QG5E/^b@f@ZXK^?DG?:FbNFM>b5_J5(2ZF
\&)&[W_6KeQ&9+;U/@3Z^^J>)@JG_TZ@2@_.0Q7&>>FEf>3_XN?f/BY?MdGMb;GM
9KGcD++P.LI7+f97\)M;L85gcG(0J#+3cQKBO.R_d,^7Q/B1g;M=&X0V?d]e#?SC
fZS]JHYJUL]J>V;AGNYN<fRUM;(+H=7R1X9S)JeRME:\7B&&=[?;GPLPPE[YVTP:
PLW/MFS6C//?P3NL[_@<OS7<RJQPZ/&eV^[#@cG^>;7?\9;8O.eJa/6a;TV00?6L
8LI?J>VbH03LSY;f4G4X=F@?IW-W4/&SI^X3>R90.1Y.40/A\5(LPP7KN[ggIVGW
I&5#+EY?GA_=B&2DMRKY]0fOL,ZJ@FXNbG1P1)>^3;:<E0e]@KT)]YU>aCJ>0C7J
[cHG.CFRb<C/\^cP^Yg7QM4G(7_EKRg2f+=DS&?L^aU^<Td>>#)),DZb^BP;T6_e
FSWgP.Cd4e5@D0<)Z.B&>0Z_:.O/dJ<7\LAc8&QDGXC1T6/#]IR-.?8#MRHF.2Q\
(J4KM<=CK^91IW&aIX)g4a)315?]]-3BNYRa5#D?S&#+96KZ48L0KWeg=M7Z&>-_
SI/6cfL-]\D7#BP[)&0+YZ^UL-Hb6b/fbc^;MS5SfYVQV/d#Ig5<+6NDEBQ5,0^-
,)Q@@Kc6R?#/EaJaUVV&QPMC?J/e=AZD:LJTaH^=LMe[#NAYT\3<Ub#@H7PP&eBS
,F9I.#IH656DC7P]ec[5;<[aD=TL65Rc3eL9IM7N7/VN.J,eCPg0FGMH4M42cdaf
\;M38G=5E3K8MCcR;PgMc4bb.3>XW_M^A)_14^]ba^?P)EYY[NK29JE=33:?@1=I
ETc:LEQ7(7P2Ta-Q;XLeW0]FUU@@D4bOb?=>SSd3HD))7,b9IBQTX21WDC7DK?#Y
_2K)=c>&[0@^OFIABI0-WD=,P4+28LaGLTP3\]M@+UX/Z<YS1KdT[\7H<?[?DDN;
?MeFF4&>OZeV6I-?E2)3LS=XE)LXa[Y;BO@R(,cIE6^J=-9RCKRd5G/:)#&PIMX<
eZ6>aUcP5N2B.+D/)&/RXO43dV5Y4GU=XB:+4_Z4c5PaEZ78<O4?TKB[Q[dOD10b
YC_3\f?fI7:_:UX-3A(CA^TPOd42SIV=04B:6(-/LY70UC015,(CG.?HEG>7G\<R
B<DHAIVCYY7G:T\FFH^E&E(EY@<+XN6=e^?LE5KIMd(G3<>E1@C<gSXYcF:Z3e>,
LGS><IV\G[KF]?cA45OD<N8PC[]&J-eO=SEV2+-K,W@+HAcBK7X;.-@(I/AGfIII
N)DQ.d+_Z<U7^B[&dCbE6+:b]E_=/Y+9[P[bAHUMJ)gHFRfR2&Gge?H2P9A,g(\>
Z55R8FRU\II06V3c=bV@GUJ35e7<;Fd5_TPO[cA+W6e+0dUUSTJUHdR3>89>cQ)F
)6IZ-@B48<@2.g].)M;<,0gZPX4P3cE<4AaV>+_G2.e77C]]F\>=Y_NH[]cK\70a
(U6cRBHG?&VVJ:+1)D=M/Ib<6F,)Z+E.0D[EFO((Z<&[X8B:3+KPH&DD9/K3LK4[
YO4D2bEG3d3[6&V)d&+fQ01:fH_L(KCLcOU)B4TM/I-:IL<b]<Q(.ND<JbcTBZ7,
1cQbKgP:(V/>-Ja,5<A8fB@7(GKJ4.HEgJ<_EB=Z9^M(_#NPS67QQ6W[6JCK@U5&
=O@VQ0>;FgQ6#Cc,A9b;U@K^F=Z5(A.&U4dFN.5g\D<Y[;eSdS2CL-ITA2daX1H/
BYF8.7TEF3I-bAe+S(;J6cTc2#5GG4F52)YFVWRHea,04([Q<0+<F@)(\f9;CM;Y
+ZS=3P8gR.-5Z(e1\7N8DF9f<H__;26e)>F-(U20@HZ^JgT(0N.&AE@d,,B6RgEa
KeX2B#7?A.>gad:A\2L+#9VWMVS8gW:C_]fDH\BSf37S9_?ZCPB9)d06P04MR@&f
^gc.Hga[ATU?>5+dYN6;dSTCN(ag&OBU:Q52R:G(-g5N62^Q#)DRRXbg.@[JfAG=
g(df_<XE_ZaI@@.DG:.8b:W\:#=f::b@I&E)cGc,]&eCEP&8cN&BOgO3H^AcF/(-
,A,_<J\C+-6WdR8+@MCSP#^Z[G3d3UO,2c)K/4NQbLL)J4&CK8URBW\b#HY8.+96
(6QDNPG&H&gM4AaF5d^:+c>C;RfW3H(D(/-IK6?e@<DTe]c;4=.9LR+Q1LOU7A(^
J;SB.LQTV^V.9:b<cUeg4aeAJ[&Yd9EVW&Q27LZ5bYa@[VU9e78@9c(/;CZ@@>AU
HG2,>cI1LScZe=(NE[c\Q0:=Y^ggF=a1.A_RD?bWDGKJ18@BMZW-&;0@E(LaVFeQ
[]/)4UQPMg0/GfVIQ32#]3J32GLgJJ@f,ZYY&:)V)1WWB5S]Q_g,1_9^#:66Xd,g
7A:)GXY8c1X9ZbHf0@8;L\H:DBcKf3D=.)9>>cPPPP9UH,H6@>.^\eE9#L=)REbG
K9RKDeYY_9?MVfgKG+5PC?34KA0^4Pf0gA,84Veb[RbSBOE4Y]aXALV?\(]940>2
4D/T9OW@GA2c&YZ-L]O;8eOL3AHNFL9I-BG+ME)DQZDO>=UF8,7dg>K9L>XBcQ.K
8-#0WRcYcUb,X+.LU#+)=/>RT67^,Xg&F1:&VCT(gJ+(<Vbe:a>2=)0(4>8HA7[P
(>a&EX7W^-IAAgI.e0;>@;/.=1cSG2WQZ7+fSXeY4<JLaa\&b.R4T@-6f&>3.3dE
AA(\</3>F.dU3eSV8fX=E,E6PUN>a<C41A9gR\ae6<5+5.>C5^P32gZZN](5[D=c
XX==7>0\VOaT.>Y<J4(EP.2V\^GQIF]YaH#A21MNdcGbe<GG?@;IBe<e5TVSC7H+
OG5S9g,G.3E9O]^<CNK4Y8&EXfbEOK3GW?>+\]N9A@IX@YN_WK<&J&):Fa)PR#UX
NB=L(=/1@6.Q=,:D,_;@G[fZURD/;]RP&B@/6&LR5GM@T1[GF-F2=?d3:bE3\fR9
C;=b3\+HG&YF+0@fg.52S4X^8D=R(N3b;\<>aA^J7&F,Z[UE9>Jg()cX&C+>\;]/
:^@>J\b7[TI-([?N6\JK@2)=L\;<2@CWPK9+LB_0>6&Z3/M\^d+9(dWVgM<Sbb17
TIEJCJ/+g:#/95(=5fG)8MB0R/&cH96\2<]DVFU_(-g)Ne(4TMg?^5?bN9#,+785
;.dN,OIN38^dL(L&:</2QJV(1FQ[_@_?1#ZOY^;Kd5_NSN1gLR+A-bcSQ+E5PFI5
G\#X<VJ?XFR&>Z#6:6=)RJ[3b>/8XV-eAA&6.JMd?^,aS#3?JSg??1>/?I@.N#C0
L^&QC=(TFS?L4d[\_3O[;/.1@,-+2Y::YJD;Lg)URQ:8U2MBCba&f;:UH>:D-K4V
d/&JIWB6/YT2#^OO7.D75)-<#<;-g^LDY#BG&+E@IL[FcYQ9KE:2e5B>a/:CSS/D
+Mb1KCg^X6Z><a,PJ\e^d6/-[8b^1YN\QGS=1JX]EE82A2CNF,\/c/K+a<5dXA=\
c=acb+ZV&4&C&QeH1+,@0JLS2cG@A_7dSbN+SgJYAEMd:4bT:+B[#Y^_9fgQN2Ee
&5XH,+^ZHS)W=?X#&[HD5e/[\]AdfE#>HCW9[+VXW=9\e+@#04.F4BO5PZXSFTS=
5:1OfRO8<)<6R1aI[f>:^OK)R^Qe-]^,C#G@dDdeJbBT;O58B00c_VTe5.O@/JY>
(U2UJ9@8)(S<EG[g5<#/1=EF(RHUQdB6fHQ88FHF6dRP^cUdeFG7&_=3?XTC^W_@
7(=ED2LYaQ3@L]?ED(;U(X^0_O9WAY-S0<2+U5d9+ID^OO;,/e;#KS>YWg-U+^F?
QV>K+8e>/NZ1Y08g8W_a7]g5;]1Lb5&Yf[GL^ZQVc;f62C];#H01:cR1^I-PeK-9
QKD7.,0_<P;Z:,4LQ2W0JPa1H6AM5e&P4H:[ARG>PBgd9XdYR+#G2,\a@B84(;74
G?-@<>HONT2[20N7/VA>ZXEROJLC.=Z037[N1;X:/H@Gc5^/.N+@2SCgR2,?G@^:
&DaWbe]L#B\=5E,:aKa48>(5#UL3K3ZdHHI)Q2JV-:)L5F#.7d?aADdD[VK/Q,)3
OB](@S70J?bKN2VE/W3<,HN1>&]XOOMRHQBe#,UbBB\V(Lg)<c[UVKc4-NPaWF.U
+C+@(BBN&6d?9V<+56,9b2)V]SW]I[f;1L?d66S&MY+UQK_+[7;ODB5E6d;4acWc
DM.7-?LIe<e5=)4F7NfM+<,D.P>8BBL=-PK>e@Bb.N<Sb=NTI8>9LCc>eQ&:4^dR
aW6f)Eb\7,4^[88cb5B1X?,GYZ:>3=bb6OR?)+Lb#LA2gB+4Q,1@=5U52c;c+eD2
>NQH32P13HX1&O36]X.\E7S4g[7-M;>2.4?0P]NW[90cFA867,6b]0^d=SA6Q+#3
OHLCEK8&0L+5NMC<02g(L(Hd)N(1909GDVO^T/,[M,_OZ_]P9aG[7GdS,Q?5&a4U
Pf-B_Ic-E<-c2.K(N#-1?ERgV4BPZ<<\_,a?K?(6c5HF8GeZ5Cf1/=YZL2Y1-LX@
.AUQBH5&\>@-0RfcIXA+XXOB9A-K<E<;E6^Y0^_[YcOCYWA_2YMX?#(1#RQO)2,N
X1X[8TgVXP#O+H\_=:BOQdX2RIRM\&+_)7.^ZM0+d:fG4bDfZ(6=5Z@LBPXBHL1W
f0a=;,&;d7VOS_CE-d&T2:VIUg@@LP.+Z()5H^d,L(fFSg4(SDYMVX30_Na5RITc
HC-OSbb-cX:F;SX]HRTc3SOP+^ZZQb@P+3M>c-)d+dKVU#-X.4),7FYAeZBWW??^
QCZCG>[VV.ZIQX>KPcCG(GLAfK:7--CZ9V/>SfId^eI[?X64cYKbHb6,;c[SDQO1
#60GUV,Qc[2[_5Ucc?>dNZE\b/AER4BXcH[<dQLRATb5BONMZc?S=7IUP/[9NV_]
g;2AAPeGeg6,fB^(Vf6KfaSF^V^3)3B/0f8.d\^E(&BJBR;=4X\2)dEJ:4-E.Rg^
&O^[CAN#VV39,UOS0]FIK(U6LU/2&V/@6<3b>)O50F?J7U&Zb_\\;,,B5XDAVagB
/UaA3U@9C^G>4@@8I&^ge/E^)G+GH5A\_DeSRZ4=J:L8&B1:_)(\&bFYY;_P3_Ma
Y)[W0Ae(B4(=G.\gfH?2R=&]b\33Gf8Z^F/VWg<>I,6)S5JG+7QB7CG6c_\_[GEY
CAT?&@<0D5dF/Q_c^NGH:G(d/-U3]c/@<5D(K6^_aKa+QO,3E^4<<-<XP(f+JJ=b
PLcODL=cO3?@?:/4(LI8)=(bf#8)\KZ9&d:@)LZ8C1(CR@KXK;d?d:D)QX4fTBIe
TD#dfd\LZZ[gU@7S#N-\N_:O2dCf[F()+MM^F?[D;3?-03U4f1>P/ADL^]T-^Nfb
g#UM:/G>42Z(JN)[Vda:R15)D=1,2]ee6b+.G&bB=DS_JU<X[28->H#P<^+,DcdH
S/>D0FHRc0/)OZIL=55:\E:GU#F&-/^W8Q-XB,E6\c:ZOO6GME/?6,OB_X@(FNI;
^;I6+E7MPD>KfZRQ[\-GM3>LeMb@;a_U@TYSZD<gDfG0eKb9#-[Xf1A+SIdB)e)9
#Y@Oc_O9eX[\NFE@9Jc]Yb=//G=B,^5H.JA>bST&QW3ZW<dAB=SG?/[P1HYJU5c:
;UY01[eb/dN(^LRT&HZHC<4g()^1KVEa)EC.f@??Z53S:UZPJFOM[IRIaICM:T/G
fSRW3\GE3#R\\bBVfG_MI?K-7KYV\=BXO2P.2F(>c6<aG[fA/6VOK4HHTM]g,.YS
G<=O/AM#2K3RU04MAS=OgFDD5JSDa5BP#RM#/X5#>Z_VO/bHOX+0D4b@;X7]:2b[
DLER6VOTYNNJCZP)M=XR]X&VNF@8E?&P0B]Ug&-5T(5YTffGT<._d/M:M;,c^#CN
#53_PL._VPKVb-.=GOMXUQ#Hf98S?3UIgU9B0bc1M&E0),SFPBFL\HdK+LAB&-:b
/QI-ZfQH_WPSKGPdNfee3K\^K(_2g^;EAWX,EV]O[9Ba-Jd3,/23NO<79Lb_N@3\
=FXI.^)CH<#>^EU#N(G&?Zd=(?1AZ9B67M:,<V=?,)V;@T^b62DbB9;V_3;TDJ25
R^:IFN#0F]C?LFcFAU=(&V-43X_JTM5UV81TdT.YX[W>(\RBLZ<gE32K7(dG4JJ]
b(25Vg_KZJ\?4]XS14bdCQ7BAP3.^.5GO=DD0:<8LN=>H1-(LKY.6[>c#TNOQ687
#GM0+1UF]EgF(KK-8+\3SM(2[eS@fK#IbbM:>X35&3WE)OVD;Tb_R;51STH:RKC5
<Ig^a;R9JWFG)H1c21=KQ,ca)^.)/F&8)PSIOU2#QZ=>TRRS0#+N)9796RHN(<6\
QGJ^8@1&ZT8,BDAZaZ6;AfU0RN]>RgGF8ca]NE.Lc3B:3(=#-PgUZF\=H@9ZK7.V
1a/6EUC3e#+A9U-#F)9(2(EJK[YAbg];=\P69-Z&M55KMM=3fHcT-JHG9)B@d8<-
caUd.V5JH]9US#b[#BWa;6_g^>#>Q+/dZ8F>_JY<c43(dD\8)DZfHV:fTa(IQ,ZM
V4BYZ;-Y&#UIXZ/0.FFXf\7GYbA\\WXXI:g?Q@X5H(?T6aKGd\(PJRfF+:dC#P0H
VBK0C,Z.SJQM9c@1g_>GLP:SATfBAe+>^347371N[H6WcH0,Kg-Q,9R]HLK0&Vg+
4<Y63I_4JcPYY7#FR0&N_;K5/]RFUB;&5MEBSWTAWdS3.8_:9@61;&J=RYPMWA+]
O77GKT+\U(X,BR-Xe4=JW2I_.RVN2g,;O(R-7fVN(a0a<GC7QR+VE9PV(IVKLNa1
\6^,E88Y#.\L,+gF2UJ-2,39^25W^72UK/?S9(XXFWRG]gRfF(G(LNf_Y75cN8\Y
RJ@HedG9]@=f:4JVK<3.E5e@BC]PJCJUI9+H:_V8A27MEa\MC5C_ZMBZJ[+cME44
9SH)3S_dM;YMK#R+F+JF8Z@@f&;1V=8D_ZCf&OS.Mf[>E?]I5_885-e/Eb(da5EE
d2D?;OH[U^+0Jf5a/?@b<gFQ(=O[=ME<F+;L^:@[&>^S,a+#-6&KfS-FH+[8W^0L
?//57K.C9.eRKKV9cH&737ZL^ESEb+BB]J7bb<g0R==UE_[PgNVI&QB/^V\(NP,,
UaB^[+&._9?g2)M5P=f[_PC60g.e?KaMM<Q]G(g.dFTI&#>+G6]4;KA[UGGe6<@P
N#A:26_=UF-&fJ0<(ROD(V:6:R<[JT?F-59FNcAf;V@a)?U0::.1\+R.U:UX78-N
eQWV@^OIRJH-UT1G&FG8SK7#2a)>9]D88YS,O)/9A6T8DK(Dc3.+gM6Y12F5V:59
82PG+;1N+HcFTGe+4ge\2DM[/-EB)^0T6f<C,<Y^c[&a[7&S.65EXW7?W\H<TK,b
RF4LVaL8VKOGRH=]RI5-+C9+T_[1XUGCTI)MG0[f(9IR):.>BT[dB<S/DR7;gF(5
]\5gTag@-<HE]U+5IeZW)5_M1cWN9c89EYL/^\S71e+aKB1+-,32e2eK2eG1>7<Z
Q^[A#\9CAF0KWMf1\T#-ML<HC]U#M,Z@XXd@?2WP(CaC>c1],]TGKI,3V]HgZc#X
6_=<^3:@384-_7.GR59G>R89\e/OG]8APK0MSE4-[2b>gU=N]JNPEd[bN<XVY:HE
D=XHeZ=.O?R8X.f?437LHd[Wf5dK=&8H,&-c)SO/\+V(dBV2:-@BOX2Za/W#>\C8
:DGL<NNDO;6@@DM+DJf#H/<SQWTgRV9&Cb4K]5(QH((W.83<bE_1BdPaDG4W==YK
=b&Q4+EHfNWg5dUaYNMN65-Xg5LH2Q9ZKE@.,9&UJ=9f+._QFOU?XM@QeVB<+)4X
]C;3J7^]KWXbDVQWYAYLQ(SV@EG4-ba,b14A>aVeQ1C0M/-f8]0IZ8f@aL(P;<1:
VcGG(PP00>G5NX]3C+cQWVGV/:bC6\14C1[JG_,J]J&:&S1_6X\B4W>c;cX:)a6R
9JQC[Z_IX9.G;Bb4Y)]Y4c/NEbP/A,6)7J.7,_@UKaG+QRHd;+Y]\/X#PG>18K-@
,,&1&AK#]1W3>WC/QH\_VOX#)fM+YT=]8cMa7eD[bUEX)(FZ3I(D-G.J(.)4</JG
_,6@DG\a,[^S=T:aTQN-SY2)2DM,YQ1@)Lc?d/[R_M\e&7,EbHQKdgb.3&_ZJe;6
35U96ZT<O<@Kb.)9@6I?cHDB>I8K7Q]#Ng.SD>EBe>GK:;(f.>;#((f-CO2?@\+&
X_MNTDf:_cI[1WB93+(P7D>6V(B=)S995#9F\GE7@>d\d>2,52&U1ZHSGBX01M[=
&>9_JQOV-PZcDg)If:&F9O,6XP)^=M,/Kb[a?.SdKL2KOR3Q2^3NIBg<V+(eRF+g
P0fC-=)?<;T+9E@1G0c&Ia478PLKHB\d[;M,T(PJb;SR1(>TI(;9.5aPYVXAdY?I
4KGN1E;ZZL]^S[G=_S@G5A,M/@MQ_^FABIMgO:X;9#^+fV?<,d)QN#SCXdBNLE_<
75SY+_eCM,,1ZAff[<e[<c2_#10E4@JMZS(eD1S7<;;7G8J_]^b8@G)(N=1UeNP4
I>fO6JDTOS40[9[,.]YdK&EB#_#7T]DDLIIT&cLL90Ye1D4?Y^5;(])_]JA\]CdO
+FL^L:ZCRVR440aIc:@0]>9OYCE3X9,D&3JX\M1bbd0?0SbDI+-=X2L[L2:;-)FK
&_c,4[&_\CUM?^SY==c?KX[aL+D,H\FRRe_C=F<<@BZLb_:UE4RPYcOV[X/XH<?R
7].b#=E;V35c@aJR]B5UgCObQ,c2C(-S;N8.7?X+SO0g>S>SfE3fg>]DX(fe(79/
c?HL&XX>R#@9gb5O(ES(ALR3I/LWNJ6/,BG\.OKTGb+-L7FE,g+J;+2;4>dA]X>I
5X1._[c^&DE&Z.G50_XUW.XRfKR5/1Q:>4J<NJULe\FY\,X:SODLYSV],#<V=4\b
W(SIZH\KDTY]X\,D@ba9SN<0JTVI4?-U+5?Z]A3GY2V/-34SP5R(KagFLe[+-1R]
f@XBC5.YM6N;AFWceS391B.\E)-6SHFb9/XdD.(Z7;ZF[dDgcWb0:K:2<Bf#^#1c
\e(W\Oda<ZD]>ONUSL_d3#0Zd.XJA#=)(L9eKHA@RBGH??8UH[2-3PC+0RP<?A<=
HUWK0R:WUeQU#-6;DM=3JHg&a2PXG@K,K#Sc(ZI]L<U-^6+VTW]-,Se7\:6fL<3A
SE7NIRS&@1=a-RR:8.^d.F.4ZYW\X?QA7De\18_EW>(P]DE^HJgKSdX,BXE/?]HJ
2ca^/Ib<(0aO5/T.Da9fAJW+aU,:WcRd_SZXR/5@OK\(]B+\A[Xe2:5VdPGT/I(3
.TJOG8V3_.,@(^SYK@[,5/eF1g]F.c\NA[PRGe:TE;3-B5VI:e\gbaJ5HXS\3E>@
ZOAfdW4LOS-RbHEMWSU)A&KN=Y/cWBF=,KB)GI^T,TT0N#6Bb?&\\=V@(g+7HA0H
=R._EI];#H@U^OH,_T035T>a;PeT3c8;O>340;_]3]^PL3f^b0=>9>(5;D-Wda+_
Y\We+Z^DOD2,:9Q+f?YU6^F/)QH:Ld+b39B7V=aX+H<<FC#U\0:2-)9,G]C@Cg((
Rd005Hf<1[aKHOITT4Y?&.08S[LDX6\NF^MQ:gH3VQcQ?8@HQGKg=;O=&@V.@T?Y
Q;RVX)7HO@/)N2+XN=]6K?c6X#Y;RD=4[;5e#)+UM\,^3\SA@=,=GMTEA11Ta3fd
H3;#aN>0HHS>]XeB&V&TE;P#[G77G/,([URJ0a6f(8QU5I5PM(P+C5_3]=SaJ]Dd
.^DDE)4P2#TMM4bJ-20S[[]Z@4.B#b]?4:&69PRC6(XS)YdGA7e3^+.U(<5_=V>V
WFg2YOOL:7GE_/FgQ/J+IE(TO+_V<._[4Q?3BG+WefQF=f+#3U<5MS(DJ9QagH>Q
2M@@:DcZT&98_^TK_E=QDOJ0G\cOa[J/,cL@\CN][X.]-Nb&[PER1f:5-?ZV?KC=
3P/&b,MX5KZfXN],J39f4[JG-eJL/T4B(L;)e9ccb9ZM=K)b8J.)U;Yg6NAE.31H
:<,HZ45[ZX4DXCC;,cMMfTO1126fSAD^/VH)HGeUeaCR-:=,^ZA^<Zd/@Z.+He3(
LLcJ>eX@Aa).6OSJ[E^EQ5eDME=-c1G81#TRd;_.fTNT6H^=Q;2a=XB2/I31)815
eeOP&RfbIZM-0@SBVef1#_;X^Tf5#+^G0S3SCeMcJ&&M&X6W+I/ML0PH)cV@)WWJ
65:8&)(g#CZXPD[>ASGH#5BXg<;;Y,>)\aJU4EQ=(RELKOOBX:2NKO/Q+NNR>V.M
M9@O\..A801;QUA>1:^\^8f&7\V7)TH,HPbUZb-3TEV9:8f#OZ<d=7fS\\TZISD8
.P[<I.b6:WVY?M(>M7+L,OVX(@c/-M=c:H/LFCKEJ<9+TM-(#81[]D>G[PSBTV,g
GV.Be3Ba-O[Le720)W#66@fbG;S_E<UC<#1+Lg.]I;:+_RHO[GNb>J4.#=P6#36Z
=P,+<He8[cLV>QCS+7G0(]4VQ77;g9<OeZ@T0<1B0LY?7Z_Hbb_V+SeUPEC;1fK8
EKH+34NY</DEN&:3)^)5e&>AEgbfI87+D;^)U?9KfPgVER)]If5Bd1FHI\=]e:H@
T&b-[-6OK3dKF.aK]T.Y[\JAGbAGMK+5bHPX2^J0(9CP-<#JZG<D>Q1B:IceU<T]
X#A&7J_f2O6KF=8=Y2ZB&M#f)9Y1CAL.EXA8/aI>#cDLFB)].55[IZ4B1I#TTY-S
HF,8<:a8bBcD71ZD->&0H.\W0VF3;;D&gaA-=f#MM<;@@NSK)=KR^UNIW:9=N)^T
5J[5dM,#9U)8^[/8Ia6T2fVUGV<\0CC<=;:\-U^a9:b_6)FQ[R39,A=D12=gWAd=
,VdWbW?YP//A@I4ZK>6]SBXN=:5d2RP6AO0f3P=3gG<-(eIU?AUJ+6#.I+PUd,c?
Rb#ELK:A8)XB_&/CAIa03NNMYB_;_:dTQ2I,,MGe^ba<J@BXM:IfX(.?TG1>FGS#
.5e<;dC)&JL./6fdL49fW]S.RMMfVVXW\TZN)PO.57-2?G<g==.XV@,]^=9H6<L:
1c/\QI]_.PN.]b6,&YBC5gGXfF38B7#a\PQP#50<d0/823_M/IVHUWHbaKM[U.GS
g5#b:/+&#B02NbXGEZC,RQDL/.Ic;W58^(C6+,C.X&Z;E.&Gf7T30gAQCX\DWE0c
(C?(9.:C6>QSgL=b1>L(A.WEZB#[6,V:VCg)]M7#&9eV-E[cE\N-9[FU;H,5F^(;
e)6e(/,E,>8W+0T)V7XATDgM&4-O,;Fa.((07OAM3<CB[\6FNLS#]fOBSUPa[I)D
6I-3?JTG)&DGZS\I<WAK.gLW[Z9:<SZ++D.(6O^3QKFL6cf18e4XM[M:5^SAc]6N
FN>;dBbW,P.cb[4UFA#Y^ID[)\]Z)b3BacQN4TM&a7XX_E4b9fA5HFVF80PD208@
a+[b9#CG#SPRcaR2]6+::+OA+K3/U6Q]g.e-J>VTLO-]ZOR#U5BK-;+dQFaf>7[f
P-K[MbBUOV-:g.^Y88T5W@^JEU(9J&^9CJB0&3[)U.2Q&5[gbJJbWe\,C#d-7<:3
d[d8--D?BX/#_Od.9#Z)JZ3C&>=DHAB4\)2R#R<Q&OcWf1bC[QG7>8(QPTN^Q/fN
1&8e[.O\_@(.>>MFZ-=\+fZ+J340E<-W&&+BFWA,cGBb#W>87ff2X9F;<DSO?;Wf
Z-38J188HUW)8&UGSK7H?b>-3V0[(9R=G1\a/NZNBA[=Q2#)bW#^H]TeG\a9&Z+@
[UM@-1eQ8Z:W^R]XdN\[1^f2N#=<,JFg9bA1G&&UU&&K(BOS?3J_PSA)O55^&C)B
B3B@V\5#--a?Y7[P4[-K-@_Q;2UcG_M:JAM,\6[PW/[Tb7PJACMc\D#,0cZI_))Q
E;Kf_HE&ZXI;DIQP;FPc)bV8e_96.CPMUUeI;^.RRRge\@ED;8,QC3B([X#SR)\W
d@FO]H3ZZ6GUPP0O.e<72?69VDf2&M#=QP6]RR9R\52/<&THBMQe6):N3Zg>]S>D
WD\H8\#Jaab4I\=]YC7V/2UO>-772dcSe79E\CYR=4I+^\/XVV6+cSQdOaK>JV+g
[>T_fWFO2Qb(@DMEJL(VUHT1cWP31TL5CQT#Q.>6TS,Ab[SVT?E];O.Y@<XC_U>T
(:,,YU;-LGDX3+J)b>(d]eb8Pc)K<B>=eY]QV@<]W1e[\0M/O:D424<(00cI(,4K
:5NfQ.]3@N)7VH+>#YA61]#5d[S]=C,eG9T4?+bS6TO&:R)H@W;5LI/4-^48\-QG
DT.3@g)E;-&HW[Z(/XUYCe_C5G-eL<IUeMRWY&V=;Y?;QBE=V7TMOQ.[R#OdcdH]
DSY4&.MRPdZf#X0DELHHd_\87OG4Xg<&U_:g&JKXL+GY>]OW\=#_+(-4RSA]Z/FO
?-b6G&(00PYJ7<-66+&;;Ac#A5U)UPTa[4KB^A+9X4+\/2:]YR]+0#Z:K0AUPBXM
4G]bc^N,?PUWR7Y^787P;7K4K5aK;_?b+GaR_R;XQCgCd\GSMTF)T_;XRQfUYZ,3
W/?c8@X#Z;8N0/H>?S9LPR:d5e(WHT)2aDC(69U_eU?O],6,a?.,7:^X#HYIf+J#
SS.dM:73I/6fM^bc-[MST9\T6YB./)O:P,GS)0@#ZT7MB<-;>E/c9SN1D:&feOB0
V>-_f(PXb)OUJS8R(CW_=S.(0/Pe7=XRc&(WWJUSD1]A2cPE)L#YG+6I1@:OaK\1
BY]gI=Q#a>T2K;UQ&\6O^O9@)B._FSYd#e_CPbe,R+-ab?7HEd(QMaT(]bT0V.Gc
C]<V]A83A9,:RDcYVAA/aW(61b-96gGOH#Ffd9Z_N>f2?#85ES.<SaOA?\?0;aeX
067>H-:a#&f38+f_-6DAIcIO6U6M\U[B82QB32[_8PDcAY\HFU?[AKJeA\[a3<+\
ZVUJ]Y^cV(OW.HC)1LSQI+8^DMLL@1L@Kb)\9B+X.I)W@RH&d^ZF>4<C0Q<EV]0c
[?-Y6DKBE]>EDZ;6UMScDXMb;=2+6XG,eJ>aQG8@=<7+^=I<LXQRBEU:fUV-(L]N
SU-1@69+4cZUORI7--\SG8)[U+NI.D9O1DKcTb(4E]PMb#f>\51eY+XH/UYZ@aT6
adV-Q\0CQ9DPeB/afK+_Q0^D+M6V^bIb#^HeU\9H8/_+g8L<f./Abf[S(B:3>a26
E.J,>32f/_HXHG;C(Nf>V.9d(UML)8<e-bPbZD>22IY)6EFe^g&5WbdUMZ(T8(NK
+R/cANH_[M>/NfZOZ@(8G]S<:9>AEXE3bNQdB7R5CZV.QAUVMb//7:C^KRK>N+C^
/a,E?S5_2#R)]FeLS]<ZdV;K?-6:)55;1R(1PSL<4H1[6M5(-F?HW44ALU>[KZX\
TAZKG>G=EM9)Md\Q)T\Y_)Wb_RIUZ-AYb:NAZ_TabdX44T0a\Cc>ULX4H8_&fZPT
(8I8F[_2W0CU6(/5\RB+U7&ZSW<SUM-4OWHU@ORNda47dKOQ>dZ>JLe_BV34F7a&
#Y=eXV,+9;(FQ(6If2WaNe.LcYSE8]Ob-:aJVf=0Q;F&KF(D]>[9eUK#YJL1P?/9
ZY#W6=d@&;LV)@T7SNBgf6g@.2V[.f4I6-KgT54+6PIaXa6W+e9f9@(:.BP:[2,=
15N=64MFg/>/P^[#c&]gLA,gb[[5L0Id+B5?MbAW.Y^QR.W6/EUYI9L:4Zb(CF^7
a9_.>GNDFf#ZU&ZJ.(@W8X0Cc]>S,WT]DGCCS(M-X.ac5I3#d5[=gbOTNc,\3A(9
1H5W67VZ6Q[7E.QPBb?_Z@/Vg#CTSS8d>c1^4B?^2dC79>[GZ[e]V6fB-b>Z31A\
^MgTGYeE2L@ZJGF9T0g?2-fcE2+E0[V#-JO5#1.;H<T&GNS/RCfM_dcVA[IcE/d]
RLKJ1;CG+Y-##7NP]E(Te]K(JcC=+NF;\YG:;dWV@F0(E/<\[B](#[]?C^cDXU0E
(UZV(U9OT8bE2P#S<#@L[.&(b#Gd-<L+?,Q&-I<Y=.bTB9_;eU([Tgcg#NgG.\7C
_F[4aO.);#F_IJYO6R_>87F>=6>^P6dDZP,)PZTQ4eD_.2J;+Ec=TBC>IC[ZZ.(]
B-]34U\27gZQQX?+[#6[FOgS6<WPb3<2SPSHQC[b=8gdGT?=2DbHVVcL/;e)MJEb
0F(9B&(OI91U82IKUN;EU@Y:c9^1PgLL5PMe]XKD1#:GD4LHXIOcHI[:C,c4_Z8]
^)\I?,@3SccPOM^0UY5H)K7VDO+cYPP@VgZge-4aDIb3)KI2bQee5.LFO79RE8A^
&Fd3WDgRQNf>^^.N.V0_EE<6@361bK-B[^]QgGf\F]Z(?KH^0U8R.E7+ON^bWVcQ
S)I,_)D4)bR<2f-YO>KJU&T:Va:1UB.YZ<U?c4OHbHBG-::<5XJC7@SdgW-7d9&L
DFeE(#bTa<Z-LJ4HIR.+DU-O)TP<6@-=9FVf/&<<a=UNWc;CReZ_/,;J_H#4X2>8
U4BP/Q-V@RBSH[^e:;0YY_AH)g3F78]C_2dH-1,U,C.@#eM^QG(f55715@,./XP/
fLNF]X)#4ID>6K(@E\T7(KdX0BOBOTOPFLIH(F+JS75J\IRe+G.b:KP&OgPOL4(T
<>e8YK927E-ZB^32XeN1H>;X/(?.[+71cf6:]?/T[C9LLc&RY)\^#65#ZOG\/L&;
31_FgC<;\7STI2UeSB(N@B9\>7<1N>2DIU(Uc&@f==MY)_&4Z57FQ5,fF6FU,(_6
;FY,;H)(MHdgBDB_SU_5H49Zg)>D@L057R994LU;F])5#E:H&]/]^#0\:O]J(EAA
\Y_D3+I5R^#V9\FB)8;8b^POV2Nb+KQX\+DF[8]/QYT_4LD0@7L>YS8gW(0(W/3\
fA\DPNYZB_d3OaV1Fg5LX=IZ5JdN&&.#KSO>/TWEee3QZ2.WY<_AD^W,e&+:,/)O
UMfXS-39N.(R/=?QJ,E?AAP?.IA828F,5NP83d?G^?e.ObPEcJ:HT/)30GW8Q5O^
B],aWFbd>-f?]Ke@g>.L,D\HR2,.#,?8JV,^5#OPRW,]?(85&L@N5+:a#;=#>U\9
WE_5YJB+K17d]<AX5I\3=6JHTBWZH)g_VP@FX?26/B>;K29^<(55T++/8SEX?3Y3
Nddc<NgB]U_,6Y)AXdZ>J7\:Aa<Vc8JKa+[e[_:+,->OS:9-<5+^?L?4E.B3^fV9
MeJ\J_,_EP6=-C7>)A.Z/dZJ-7B?JV:HD)4@B6^dg[Ng:J>H99@JS2S7;9=fAB06
SE(@,&[HRR0NZ8))@6D]?Q8fF(&,Rg)b;5cD@[QP;dKIXA8I-WdCAC&RK?#;c859
]2#+7K7T]F=gaRIAE_L:>aE]daQNFX(E?NGC\Xa=1^D^83-24;+)Z^c01]\B)8CR
;&/K\E8-U3>d5M4Fe5#CYMEPK@X\Z)?)+[(G9\\9ZCX2)JE+;Y?2A/U:BI_(=MT8
&a#>K@)<01cYP\F55W0ga<C]D)RQ2;H3&O_VS?gXM4cf47L@&&.9&-Z>LD7E4-X<
4SEJ27[-He&C.c,QAG18f_ff4@,DIa0Ee(3?B-0c973B;NT41-c3^K.FGD-(+9A7
XcY_a?dA55eaB9[3K4[G&e)gH<,6GN(G-6Nef1[E2Af2OI/?K--<C@.fFBM3<\7L
X&]+2_CLDgRD)(MdUM@.[>H6OgIeJAXcA7Q>GJ8a9CaT4,_SadeCaY(KK(E+B:Dc
&?b(<1ZJ^6,1#PfYO&WMc9JTUXLU;G5K#7@>@GJeDNGfRHaa_ZAKY)H8[5.+EOB5
NYVD1/K[_6^UT-#.;;?3\>HGO#\8Y23BO.c-KN45>_H3VKP^OMQXEe[QK;aNFC^-
VI;/[3Y>1ECBGK_,1bR[aGf=g?WP76gXD6eP[cUSO]/BC/PAXO=#=c_M+O,>;YM:
5<\9PaF1:F;JI.Z(aBga6)XZ9YCSISOWFJ)Mg.6Q1)RK7cXQ[:9(7NOcZ948K/3]
dM[5/_,b\_6I?=^W/_Z]cga<bR0R)P&LO#Y.4[G#7T#RY)fR3G_bP/d^KDK;Vb4b
:1&))TX@XIb>U?.-&Z:B\gdWSUHBWfSd(g#YTY=MDNNF]99E2FRT7_8H,W[=XGb\
S_0NcF&>?YBX^?-.>0O>SSKbWb,Q8daH^W.RIf;bb0e\B.B=ME[DN\=8<(FeXQ]/
MWN]ED???VB/=&<BJa=6<4[RFSPEH-FSYK:))O7[2YMG..F,2O/<2/9L0DX,C5=[
Rd]0HZ5SO,;G/=cT99#a.2RO+R1LR<9bV^ed\V#GMCbSNJKEP61A)[NVdUU&<JFR
BSM4]N)\Q[Y#1<QI7[[<7315O/),Jf:SaQ+;Q64a3)?L7OD;G(J8MA5P#OX/Z=]\
2g<9M1S^95eb<e+4TOPC[G0II6#NP7dM/BGbKIW.7-MW^eAR>S2aK90^?;HZ7OGK
f2C\3@De<^=L+[fH;AVDC@Be-1X[-LVV@U<;U.baL:A6)[=(DMS_H@>#eXM&EJVG
758fRAYc1[-C_1.b.d:GGMR2P)CK-dAW,Ha6COgdX_NZC)H(C,L#::7;aUA,>60/
Y,>=M/P5]4.\(2U^&U,2N90FGYTd<ZfBS>fXOeUbEMD?0DbeAN=J,&e^\1d@aP8<
g1=QDZH71AH>#R/N(K6+Y&Jc]^>.D(;LJ#d2-^WXLeHNDMDV]IJ-.Af>]D&F;3>3
1aR5#9OZ[aG.E73RI5:db;PHPB<PN2AT.9C4T?4^f.EJe77f_)JK&>/;<&<04A9^
A9BcD:=S[)8?VR-&aB^P]RW@A0A/1d7Q8T=/:O,=HeTa]c^)5/aaEK)ALa\/()(Y
I2Yab]-><D>AK5UF81F4^g&)3C-=BQ#4=a[Q@\/(9S+N(;dB3;gAS<D,A](D#a<(
AYPD]89HEG@d>>1;/(C5EMQY9c2YR5OeT5.DM28b=?M?@7GD)gb.A9#HU)L9MV+P
d]f?;1)4^&de&d_)X_-=dE+E^,0OcAEF7-DTF.MJ&fH?<0R3^2B0YPT==GZbKY;[
N+feB.#e<L#(M&HM\LNP_+^:EA.>Z3/7cI8GJMMNAB.+5Zc:Z.d]d_OdWYHT+\RF
Y0C1O:gf#a-U9aQTP9EJ(?c+/WVIA9IH=5HZKMD()7V3D7\0(C&W#\]gUN]HJG4T
Hfg.##S?f(c\(b8NNWYfCYY3N0=@3Nc7=7JJQD7Z08/A2H>\3LPQcW1VNFZ<)Dg0
6A(\N,QKA88bITMS_(gS^<c_PNG0S#Y##?LgLL3>a&Xf4)/_Ke](2X:QW]AT8)H3
QWJTd=W2Ef8UW\UJ@;AW)5#EV/>Pe#C_))TPN^B.0AAAGR2:1V_N5QY5J.;[E6O#
;OY0N8XD5)3Ub&LQC(/>>]^1=X<1&Tb7f<&f3&1\b0[32aLQ=NY5:bd(IeAPES>^
5.Q9M<.NW8HEg&cW#Y1OXQ^QP0OA&^+_dVOIT6++U#)_TXMYSKWY?WI?\/V8d6<)
BL]7+H(#&O.aFJJa=?E#?(&b0TT/8M8_JMcWJeQP=(]7CbC9b1g??49eU]?T>+,@
_2Xd.&[@/g-D-2A<((UI0O:6]1IdPLZZfZ?Z@ZL[N84MB\\,8Q&b>:d-N8PQ)Q?7
J4@&ccaO<=^_&F26#1^^3,,:D-3O-e&9M;8W\Z9XfJ>-gRMF1;+;QI1cCR_c#C-O
B=A756371.LEH.7LTJXO52N29(DG0U[G):SXU&c&b_.fBc7b2G/b9OQBJO59#d^Z
>VSR1HfW5^-1]a6dR5=cO?IL(_&TI0b18#&ZOXZaZd9[1-E0I124P9)a6WPbg1HF
#O_1>>]#WAfJd^I448RPG])//YCLf]V@fJ[:</Vf8>4<8DeFI8,cVd&EP66+d?3R
f8<EYCJ1RC876MRUDT:@H\77P0FURD3)@fO+ab&:IU;^V^/8/>@4Ef&)8B>g,,EM
4bMC8\7]3=9+.3#BFa^,V][#73K9b4EOZW+,E-_9#RO6\\0agG#.VH.TU&gEC.@c
I8X1BET0.^cCGTV(D^,ZRdC:TO6BI8Xe+W\YIJeQ8XAH\&0TA,8U#-=KA#cEe.N8
00EeY9SB[-W@6I(<903\g,WW8QaLe)<Jd&><((+gNY3TZc]#9GK+eM0VDX=QNO>/
5[<JdJX&#^HJ.O;/N-07J/3=QGGUDW7f8[-@Jb2#)cfV^SUGU:/(VX=eS?LINf]F
JO0#&@BQP]OXM_;GJ/G1FdT7#MGCJKUYLE#42_5F_M4>8>M[#]g,Y#:[66A6\g1/
?AYRX=I^[>=OQ\)G\EH9YfNf/H[V\1IF6c\2aT41R:\83SCOG9V1U4D+_U5>R3f#
=9La8?:C+(^AC:.[)Pe[cC4?/;OU,/^>?NKYbE\_aCaC-23TA(Wc1@OcOg.:8c;7
Z@7+Z=^_)Xg>U]ag)?@[>f-)TYec2KZ.]WZ,F</&aEbB5135YPU91;@:_QMV1]J;
Md49Y/U7dT0\2//F0d#GQF9/?)IaS?&+R;)M\Q[8L9E5K56;R/=b_,J6.f2S8KgJ
JA2CITFQ&IDZB\EJ-1GQJC61^YG>V)M-/>&78@]9F,ZQYcEa[>(NC188e6D6EJTe
87&\+P/0.^L@N=,B&(d3XN@gcRSAdI0.NLJLPU(L>>+d_VV)CX^aYVH_]LP:TD-@
cK=/<ZM/H;J/K^5W\5-e@OegE;F#X#.@NNRN4@E_H/\)6bKg#e=F^Y7?,bXEeg6?
VX;OO+eZ#S1:Z35^N1N3Vd)-JC72I:OK=]4da9Z)R89d>RL-1\6>LFbG3_2^)C2X
b9)PSfIVBO#DUMPMWE::H^EVd?G,G>E3@g+HaDcL3^E=eb\P5W116-bN;YYY=FY.
[CTV#)9/M5Q<S9XFD8P_f^VI;3,?_eS-QNQ@]C3@).C=7MYC\=HDe:eIO?WTEYB)
XIWVg@_+/I9c72AXge?1IOYV:FJg,\.ZT/T4FgK.X5U#ST&e6dO5\)ZPMGO^?G&4
KJP;\8AH_d:<F^_4WLAGP(EV=Q\X1\:3?6+G.R3J43JggB732+)TD+cI[]S,L28[
]dY&_/2_8PWA@F?b.@]BUF^)\]=E(E_0(=52?>WIO).XgL2OSCOead.W^\_WX/B>
<&WE?<2Q=eKQPVGfC[Q:6XP^?d4&?V<QcZ:C[O.EIc)2AX19)XTPQ4(V2M(I5,Oa
&eB&(N?[\4\M-D658,ZSbAg?&YQb.=3DO7N^=@bBQgA#cOTIUZ[I&Sc<UD\^/VR]
^F#T;0IS56+P]LNe]e(=:YXAe7AV:NAW9J#OB1c2ER,6D((9K@bQTZQb(PJL_Hdg
<KL-#^bV9W,VOHO#N#HMOVFOOJ>XaEN<5DY,Q?P3HE_L[<#=G@NFU;b],NZ-(O:g
gQ_e2U4\=^a2dK87Z2g,J\cIRXc^CbH\@E^GJTTYJfNHcGR@)5O(](a[?+e+7&HJ
,-7A&S/D+e8c)aa)AB]P:2P7aOGX<7<EgEI,/V5.3V2#9]NgF]_L0Ke\8Q2+)1GB
QAUN81SSc/AYf?84Vb)CgAed4WSB2,KEe;eJ/2I#DMa/f<6X5?UKW4P&1@M+)1IX
Y.RIcP6NVR\-??a@;NJ69a]N),-U1V7?)(F,?a1SEO)P]RSOSdccf?>B[fc2:T1T
W=\Cd#2dHD+dFQ2)=?YcJJCOML_<(;Sa96)7Q8f=X8aYR\LRL7LCA>U;@+VZS]MW
D2)RcJ\C=b>G6;0g,cRS-NaW@A&:f#A/5>986.M(aggT^]7aWL3&N3T8;EgEMg9Y
RMU7;J9\9XA22[&77:^fOTKFN^b60FHXTF5N;fX64N00WT;gJEgVYVMNE]1FRb[>
4R4\bZM3QFI,g>K1/e;<1J(A2;K@7:<E(.;24Wd1KLCF-eXbK.HWWL.P^NC#&]?P
7^;SD[2V7_6.FP/_2eZQe\-Bb_(gL2CM\cTDd1I7=cC#8^O&XWQbN;HEL6L3D_YB
(&YL&M@]+[;@J<\6W5NcZ9)&,eE#M[5Y4^&@d)@Lf]O0c]gIO.Of&=EDNH1AER4b
2\KT;=d>Mf7\1+L/,cK-CdUL]2(8]4</9HU)W1deYAIJG>cg2<c)GCJ&S@0029#O
;.OfFF,f8NV^Zd#(KRT-aK[OeP>QAPX<13#[c/))d]EBVP_C?HG4VKV(J[gV+.+1
N83I&/:C_b08]FDRGXS?0,WKEeGbJ/\Hgg).O0HC\b.5@EV-:Jg:4OGP&)a;96S9
O?f:bJ_;/UM-NBU<cHg@AVa=6e/aQ.Y87QMg8A^^dS81[?Df8TLG&e0\2WAgbD;g
;3eNC,>+.LWF0f6(ZS=YHf-/U(,7MQL1Y.TH_#X0fYH#]bN^HUH+e[Y+G]91YFIY
ccY?5U3<+9UCJ+^RU+]YQ/g(-e,MDU8gP.TSHe0d#cV4Ie5(WBP4H+,+>)K<)H4^
_Y(V&]+VO)Fd(e<e>72C]D5aVddF:S_,QQ-(WC\bNKIe\6.9O[[=8c8-9N3[g2:L
Q#6^@Yaa^CZYb6R?79?BU[L1c,L9A[JNP#2#g(De>&S;Cf,QYW7+OLJLL6[-82C3
U8H7<;J<]#CJ>V/4>e08\7FF>edO47\bfOf>2TV-MYH_??@;VX//C?8HTHU&<MYd
eSM535a?Y(J-A[9UF:8X#\2#Bb8eHCJ/J.8/^&E?c)YT(]/MC2:4b7A:E:;\2SZ9
U?Q+Z-\S=ED=Ie/EZZcWU0/NO^gJ<3KVOYT:].0^FXM(+BY].1BXe,\5+2.990Ag
.>+S7#0:^e5JV5@3YMSC37>>E>66NZ+0+P>T&XUPD<V]I:SU[eNBUD2g1@LVgL)#
HFd>TW)L7TdV=(=^7_HF.=E8UDeC<4QV-57EPL2G/Xf[\3LcJ:F^<6BYT7VTVbTG
fM=XKMN<@7ZBQYfG?,Z/Pe0PE-V:)JE\gET(U=FcHf5X35FNXb+cV5X#8T2UZ@@G
)1f@8LM<_M;5d1=V(;5QE,[B)C.-T)?gc@#:TRF;,+gF8#(M-dJO60ZX27XRKM;(
9:7X+1MMLY&3+EB[>?J@U)Z6G9)S_5&1d&0_JeD3OP?J]K;T8?&IQB6O+FgD7Qbf
FB18c@^3;N0+K4EKN7&#\Z:5ANKR9L9:]]22]=f:F#c)WZ05XdN+XEWHW@N;IA>7
aP;g,7HKOGUPPWdKR6WD05\PgV?:7f([Qd)9+V,f89R+?(R(FCY@N@J^ZQ\Q9AJU
#2@1BB46T0>C>.ZF40N0,S#K_FO0,&_a,eS^RYZ])Cdfa(b:NFePPAegO+9DaZ1=
5694NT+&M03>R&[(F2TBQ8bcS\;2O&Q#>8&Q:;)c4gd>2cZ+(G(&K8UZ9I74O6g&
CWg8B_f=:V\417;_);]VUE8R]=644gFLZJHWEU<9bBWfQ<TJAZ?W,JVc?7PT,QT_
8]OD&H.>_^Uf4>XR\d3V+QfP\]cP;T=SKR/LK19D;&2U>O:HfNMA;fM-94bS21X@
@?g?0_]RAI/aE/WOP4b(7^6V[7?=,bT2,<-,d)+dIdKPMM6T\dO?.Kg4;&=QY(0W
PM[A[>.J45I<QXb#/WPS=BU9G^4gWfU0SARP9V<eU;57C>[X&N@V=.V5_J?JKT/M
eU.aUO8FP01M[M;INNU5,^/97H)D/KMEBMdRb2cFQCIBT[dQE^\X.C&Hc3MMJ+SG
1)D0fd.>PZ^d9]dY]8Q[KEBZR;1+X?#7^.4Q#_\R@.9b.V4c&8MV:0P+N4bX/-ae
C=,_<-/)&&+TZ<SBU#Z[JGZ-^+aXa,AVH9bg&Q_[2<8G8cJ6AYKV?]Y?fVSE;b]=
V<d+T?6_G)27\3IO/]8V]aIcb#Bc6aG(b6Y5N,;gN1C8+g7,;MKaQdOI=e?]FY=<
FEX-+_ILfQ66f=OI\[eGLFHQD3P,+Z+SI&E=\d_96&I,ZG&V@76(=U=.Q5?GL+=J
N[#X=NN^]#IB-YgF]FC\G30V./BYcU#Z-<[b?QOaGc632d5e8\fHf7\+:17T;aA&
Tg1:F&]=e;@#WU#QFTgA[777(,M3R6fFN-G4,B)eA?P^0-3+EEB2RGEe0(bFE\)3
R0RaKc:U))/W:RISSb80UgXTN-3\KaDXg\]6LQYKJ5dITX=/KQ_TH<61:\a2)YS=
;LEC7@gVXQ[;8;e2HUC&aL-cQUL]EFVZ,BKRCVfNJ@1H(b+IF7ECS>,3F2NL=@[9
4N+FW+-,ef,_])54_A\H;A#-EW:_M#<A&gF(&_[XfZ1.MX.;(<X[7D-DgQ=^W+0A
14?-7+;f9&FJ>BNQBSJ67b.YNE:N<2OT7Og\C&6cB5]:ETe9I42;dY;Z#UgBUXY^
904SI]MNZKL>-?&SO+EQRg[&=ZRQCBFD7J@].9_M_Yb>KCFK;f7gQZc0W4ecc+-b
G]Pcd\PW&9(2=)8PF(KYZ_NU2X.>SaQ#HGT:F_Ff_.J,B\-=[WJUW59b<\H4^KD4
&4.ZC]Kc-O^EBS4>\#6N[0S[7bRSaQ74/C?/2D)(Yb7N10=TZCTCBV&=P11.f60P
?g:96\CDFd,Z16;O7O/<c=3J)YW<[c.ASNUb=++dO-Kc[g=477+Ae\ecENS;4a81
0E><EABX48<@YZ6Te2&AGUZQ6MOY0<XV=PIYL[DCE:BA)gU<]<T78MQ)72@[8.-H
dQc:/Y\1@C#a(ODB05U_BTO@\V5G2b;T]7ZLYXSbPR@?cQ.:^DG(F\7@-)=)(eGS
X;gW0Y?+g6Qa:L_RL9^G0;S?8L4>,dcEZGA7O[&@eK\_WKTEMOV,;1^S>NA,C6fI
Y813Y<]D/L\bL9Y_O73>Q(BgY4R=7ZeY+(3:+^?&EF/&c69BI?B)b7[9&PNU;<#<
/,<6C;Qb=:.F,bKUAc.COU6^-_^.60XUCT+3QX8AJ5?DY(?;91NU=HS=g^ZJ]HO&
@TVGW8:)<gI9dRE>1CZJIW?7:^Sf@6<+/Jc5734)(bVM52XB1;.DG]6Q1b-R.4(9
1=7Ab9HEgE_MI00^AQFO1C;38c@]=9&,;LN43Y7)#MOCB^,H:0P5C-R-9J>G17=#
1OTI_+W(6,4a7]/<<a_\035(\JAZa)c^[HJSV&(8BW9N48>VA&XBLJ6]<1L^8=S^
P:E);9I-TZ8.6gQ[V:G:TfV/9Og1+ggQ#N<VW;0F12Oe><cJa;T:?.B-H1INeg()
=(9);)V+VLLJZJ3\X>?W1.1FH)gaX[1-Hg=_g0Wb/RGLV7SXI0+&5<;2IQD@&_7[
[9R&2CON-Gdaa_T+:&4#/],d31-63RfK2&+?;.EM=4#)5W=3#-_Of[OFO<02,e+(
O[][BUa[Q=0=?QM.7=OLI@fB_6_OI6.,E#Yb(+GA=S2N#<M,F<L\)2d+;@MFY)c>
(XCD[PY^K]K3>V\5FgCTXYgb^^0;Q0Ugf9Q>6=d<(LB1aFPNB2K=:O\^^QPIDb?.
U9P+?c9ZE.ZFcNDgLG?SgSFGKH(WNSL&FC0(a_U7/J8CD=A9f^4@7c)_VMUc+AW6
YF_IcAFI2C=cXg(2f4D[D8OH@[/S^/=/NH:5IbY;,[(4/WWZE)T&6D.@N_\LKR=;
9@fgA(8(@)-/T^7?3@BT]#AAOM3U0/\KO=>SR,H98KBRV?/0&A?WFP[UcRW<:Q^M
Y(D&#4b4a9@R(Gc-(@@#F\@=_&3RU#:.a&CRH:O#?[U;7cFW&M7[]VgW?@RZ-]&/
I-HI4\B_F+VLQL3+5T-1K7T8N]G10#e?O]C\RH6R/W)=f=AL:AH(e;0I,>aSeM6J
(EF?HK@0B&WWYP<5^a@,A/.#<LcEPHK0gXbR24a-AA2UV2a&?>QE/#fdG=CSAa<3
;3?60V03JPBKK/bQM2-EDF;1fY5_T.Z8c#3a>;2>8H1LAA?))Le3OSB+2_e/Z8&9
gJP;XZ;>5&G3ZRIZRM.M@6gC/HOeg9.IW;0X1ZMeX&22STW]5>bRN[VL92B9E<]H
UFTQ;Z=(C1VD[8:+(01K:-Z18UJR8RL\Aa):33;SUGK?#TQdWD1M[CRO>Hg(5M)>
MGd3F3[\e<2T9Y(S_0a?N:E4TRWfd)f91(]@,VOf.N84.27Jb2fS^WQAg0)GTMOF
6NDE[fTKD,c.e?VMb_&R0T(_GVc;T1bCIL<GCZ;@C/N533F;5[<+ZVL40RJ&R+IW
33a77bdAUNP8SM]aZ]#7JD@?NRKK^0UJ_.0VASEN85M^QJ05fJ[gR0FNYQH\#+03
LTa+LV=AI,+BY7,(AK80.:@QR2HYEMUFZ?6/)O7aZ8JH_[+Bg:9-Jb]V[e)LO2Hd
Ae5/BRG\5X/]g:J:,Ng+Qd-TTX320@NSa=dA)=:>F_;L<Lg)^IH),^d@H4Y\_S)>
&2eV]cDUTJ5C4F(;KTgFMdA9f,M8](@Xb5Rb,2\F0KF^6].53\Ee>RG94bUPe0QR
XDDbILdEOUWLL_\H?TGa:7TJ+PNG7NHcP<-34ETT_Kf?#e_[/CL[+].e_]KFbL?Z
GKM8QXSa^,:B/Q6.KV;a1Dd4PdT[X=Q3BPf@USR+=.CV8TL)D;4N(^g2,5SgEAgb
SW.UL3IDM.a4@ES[PP3,L-[SeWF@0A5CQ\;Z41&_V2(efB\[&ZE66GCa2A7#S3O-
.a.VB.00U>]P@STTH>#-4._:FH\F=dO0.YD),C\1Q8G=IA\[Cg)PU58U1[2E.V<#
cSLb00?g>Y5DBNFGG7UK@^I)>e:W\6bU]J0HPS23>QQ\&T2YIZPV?RRAW-?TN.TL
1N<0QV_M]5,I--#[e0C+#OKDJN;U=C@^)cW^1EG>W@(/>_9;VXZ@3Cfe5I6_I(Xf
QVK+4fNQXEdCLI#VK:T(.,7:CAdbDJ5c>+/_#+a:<K8.b49;AbQ,Xc<HP/(SZJ7=
^4\D##;D&G5?(SJJ)GId?D\aZ?WL#),=SE_+FSHEZCeDdQV@27Q-FSLC64Q+4#35
c1&1JM7[7SV3V+2\^TBd\R2Q3dOPA/9]V,JDg7=YG)b.e]Bg^g^adO7(Ne6RVf0Q
,<(+).4T+Y0K@F.b7PZPPe(+^-\f&&GQ14[[_QR=c[J8aR&?.-2&-dN#-K&5I>93
X?:fF8U=,<eE16L0GDXD?=UWK=dUF56EEZ;X40<[0Rd0GZ1O0bE4HFQ_..AA8=26
Dg>9PS.E5SWIGKSca+gbWdHL@Z.bU6N@d7&YFIS9H@c<D]?X>30bUWIDBLZ(4]S5
@/8C6@]2\F(G4W2_KV?8X<Z^)K\NgN\PL.8RQ1,(GH268Q&YcJ>V7dP]2N&)\>9U
\XB=K\d-aVBaO9^M3PGK3JT)?G7K:2AU[J?##]O;<N:+6N[ASD1eBD#>_WIH4#=;
NHT.Q0^5b=AaDVEBC,O;)@Q1ZIZ#R]@M)#T_<.-f>Z5:@S,.\EPL95+HU&\[d^MZ
OZQU<0S2E0:MG7N3Uf@X;CA,Of7Y[NU]^+fJVOcD,EWA58LAb@#G>QP<6O3&<.B#
CGB^TK=8<T<HX/0bZVA]/<_,@_.DZE.KI8:[PDJAKQ8?M7?045O1.MG/F6]f6YMc
<)e+KGcWD8,VVLQ<U.Ja8Q-^DP5.&W[cTK5R2HgNSg1C(P+BEGVbM\8US-JIa94Y
#XO</]dg.]/<0G3G_XaeD.3XB:]2))6N-)=+?fcEPHBVJa<)SSHDa[D9[aF/FAMU
M\+V^Zgc044^@PE]HY_e5>H/9c3J]Ggb@dLF[3LD0LZ.6#SJ@If.-3^Ya@FHT2E^
aE5A&LRQYC1d(C\&^[QU_CfVUPW_1DcPB>PMH/cQ;&^?-O.9SGaA.]CE,.--8g_H
Df(,fdS.W)4<d=10T]bLbMC:;a0bE)_.VEE@aZZ;)0a^?9K[ITc60,ATS]?4YQ[7
HVO,WMQGa[T86=@]T0[_Ra6-e3:2dO&B?9c6>SA+cI#Y8>?:#>6#D0257Ed8A6:/
&H4.W2_GTWXbKU&ceU5I<5K145#;#/ZJG^M4_W&[SS@(6Y]_&ICL@@SN4FB:b-LS
##,fZJBc/J+?G[_5EY0dM?58TZLUO,]J<g.Y.L?&K>2<]NB1M4#:I__L;PPW9_1J
gEgdBKc6386-]HL^N3W-D^>4bQ)];H_@IAY&bfE;#OHR,_1Y\WWAW-Y,UecVR_)a
E1A_^R=f71-bcL#VF(3fEZJ;]/L.WC9e][@3M9+,A_A>(<W]#J]]FdH.KdDAaLKJ
GD[01FOb?CFP(1O,R&)QBb5&D0[]&L>^e@R?+2[8_b&FR_d6HU;M^fIHA<]09O73
)OOE4;D2bB(;Q^faJbF6;NMG,.#TDdY0af[VEHR\)1^3Z3WU0,HE_g4VE0X(5[,c
BCS:7NC=-V]TODR&W1Ha:V\d_+3U0E5=CF8OFQ+=;XZ(ga^D3P[JT-EAU]K(V+5/
TI&YTX,H>e-O253.I0_C[7GP4@I5M#]9b4bWF=SgAT80PKIYUW\X[Sg&G1aXRG97
#5_U/WWe2V8,:\T]EQ_>6PbMaSHf8NJC@2_9.f7UA,HS,M8LMe?;7cQc4RJg4CO?
Sf@S=>AO_ee2PX>??00QDLWGMbc_20Z)b3B+(,&R5PW+R7TX)U&5,I/RD1/KOZ-R
_&#FAa7^5fYdCSF@:+HUPGYTZB2,Q2H[1S^,Pgf4)Bd)9eb3N)I1bdLa#:[UF2b3
V]IJE?:BU\b8=]?MX4:g71\45aCJKeZEAL_21,VC?cc4\(4?Fg\7BOb=&bR]WJ=>
9_HfQV^DAKTFWHd.D-X6<GYf7HA-:X3(W:PEEG#T9<XUeJ=aaE_I9VNg)MAHL/P4
<TINb_Y4,d>^eDC_#FdC35/e&N-^/,@Wd\@B\[9[OIY5T:+0B,KL)9,4/MERXZQ#
(NP3C&76dU0MU3GS+L3]OQ[/Y]NZg@(X^2Nb>-0_Y\\GH;XDWbgV8.E4KF21f>RP
VQefCYC[UUP/cY6_8VBLL;K;?JY6YG)IE_OQE/F<);^2H,ZFH9cA6ZD9e\MY?\56
EU;G;G17)K/C<,[4PZUag7391eF79RKeAdLe3V6KRNM/ZHa,a[3Jcbc((#d;WR2H
[=/3.Id&B4+1;7KZ516)/fdL=K7E>fMMN/W80TW(T/C<d;+]PL>?#0U7UdXTIFf+
Ff4233[0I_b<3d/UCg2bK^:U(O][e13WOD:Da[?C_C2O,\R<P+K?)0>]2E@7YFF6
;.ASeLE8b-C/5WD5)7c>[U3,UTOT).)cQBU>+Hf)X0P.66_Hca937:ObHK[Q7M=A
?9E@C;LV2f07d\5Ee[^O[<]e8@/cADL3VLI5AB#G+2BKFBS^7SJH5DTEAYVRNQKD
W6b6cUSFG1PJCA+^dUY=DK^)/2;IddL?WT3HJd-34bLY3MM?Q/d0)^d7DZeBUHaY
CQ&+)3:6JU<ANgPE#3e\CaZTHTAUA?dNJ5Z+G/NDd875K3O=II\7L)GI2d(2FQBJ
c.S.9^ERL0&SXS:=LG?c<c0c0<TCG#F0QAG0H16UOH@CM/00V,YOY++\-]dV?V.H
^L@P^d.e349@?15M=@1YN/6L;H+c5a3Z.[]^RRQK.EGDfG+9+DZ@V^-60EgTHD/+
FKQ=<3<Z]Q?VW::g,5a=8b:NFKTO;-4:f<=:VCb@OPFKJ;/cf(U/@CTY2+FY((T&
<Y@IM-6\ZJ-A&-:RY8GB?(bPG\f)_HM]01H)BIfR,6A-BH:45Hb\gQYV/&E.@6+\
[.N7,V0Fa+CJcTQJ>cE3O(a_d9]#<6I.<7NJ9Le^cd0+FFR+1G_N7.@5GFDR-F./
[(&b8\7N/b6U+&RG6D70VIP]--;#K]BcK-U81K2#[+d.PCXH?-;c+FZO4[324+(7
Keb3Q4HZb:bY,<=>83&D+P5,A1eYC(4Fae^E9B\_,C/,D9b@4g5YRK_c?3\<59;K
Jd4GJX#XH.&5LOd5BcN+Z/RD8K&&S#W04N3b]cGOU1:#g2^QBVWG1DZ+&B.@#dJc
78.[];g2;@MCHR(bF&C^f,4DU54]0X>Bb1J3g2d0&^g_(M+PX7d-1\,4>afccgdH
)UA;ZFP5T9fd@H2c;E_6G^NKHDL5MPI=B4V4#U6Ug0FaIC6Lb;I>OVS.7VB=-?PU
#g^E:Q:-TOR(eJ/W];AU;>59-H3U]Lb^\?,bD;_<S?)VX]WbJ+M=JTeF]1F]LbXU
+aU;<>JIWDS5e8GAc0&=D:1W+D#O4d0cQ&Pd,Y^89&;a(EHV7eaUO^^;1A?X[HD[
7e^+Z0JVE:bW)LAed@-HY5<B:N?6U=4RFc/_(g,CP9T,UK0S2F.bf#6,NAVI=IHM
egX?XP]ONF]L]K[UKTVFIIW,FG<-9QZ6VZE61YULE1MZYTEDXG(3Y9eeJYb2V=:Y
=dNG[da=ZB;[EN1P^QW[NHRW&851CaJ4:WR=cR),NbNa#Eg;]SB^Y[]Y8=8Hc8C#
&L(DWfW)e^2D:7c<-b-^(CDVT4geO,/9NW,G;W3J\QWC0&4UDK_(DL#^S.g1(QgA
UP-P+aYD16ZRZ[JM-/H_4-I,Z2H6G\V.W6N.g.>;O6?(3EL,<5KCG>)([0Ga0Y^.
[UTKRR-(ORK.^B18g;B?6WLK?d/_&\YGG3W04]0d?G-@UcB<2:]d_PIfJYf^6.L>
=R7f4TX2[,)e87/9/(W1&^WC.YaccbUSYa#)8?&R@RceYPLT+N;.d6>-;O5Ved6T
1D)7FBR&ND0ZNT#KK3ZeB;OMA=<3#.2.Ve;L:1B3I(Ke@B-e+?0c:.@fUYOU..5?
cNO(51d=bcE7IBY074OKO,@C>9SN8.J[?YG;C?5]aVM^Eb0W?KL7J\gF[>dcJEM<
HY6=<OLKQD6f#O^:dJL)&AcSU8GLG^2,\OKfBYb]D>VEB:6f?e&[1:.EW-M\VUL^
T=>cF6IgY.//FbG36SXI_aN:DYRcO6SKN9Q4gEQL4G)4;dKAF<0>Y9SO#BXNRM>T
CE@@Ug],-\JFY+<W.7(<gP\T.K<EH)96ZdC:SfH.M,MB.?L.HdMe&^(NH,(HZYN:
@/_02geSD2KV=eVS>G5]2<C?/=3@^SS^E=@IOS6E;FQJ\)24[K4ag.Zc-)AgO8#b
(AP@K.(??_3gcS0(C>(e]N\\^D_50&4bDE1>(9I5??Q\4Y00.2-2a]S8=S3(9.0Z
e>A>MF+/B0I<,A_6)8LR/bRI0Zg/B2L&cK96;6]c/5JAW?P.T1d(HF^31aD;D@a6
AMC:P0(L4DMD>GeCJ\b^^G0>=\VXg,3E34/5^^]31/bXSc2^QF9:YCS<YV82W<b5
U]3,@#M0ALY=D)>HV#MB+S7;KBIc3//+^23Jg-P;9a,5+Q@JeM>-;V>d2469@]WH
(:b(/3G#)@/@;,Udf,Z26Y030_BO\&DV.00UB.X?=B1X_/a,Ad<(Gd.KA7^.E>T1
,RBcbURZ&:FT1IH.(C/DYZf(R&(f;,b:aB0Hf&?Ega4Y/b7gUCS3&W.Bad(b\aKV
GQaQLZ;][b.?fW2P).0-Y4f=Y#FS?(BC^S^\Z#>]=POL0F1,,GQ-I\=+EM[EA7cD
>d@+]F=RMNXBGMJI:U=12;^9(F-/],X/ISC3X)XWb->b6))=9>9M&QZfL5eQXT]?
GOV&E;\3C[0)KKZ(VJNN8RKOY63TX&3,:bg0<T=&^:ABH@KQ5(7HgaGYWE=.3/W:
>ff]>A>=>^^g+E3^eFCea=eQFf1ALc_H_fBV3d0T#K0@\Q,+35W.@QJb.#HfS_D0
)#&Sf7GD]SgN3De_]>b:g\CKGfCLbLb;4S/7DGPHH7TWOK)f870[/cR;QeY.b288
GP9?1_:Y,1E7RDB,9UN^QG(_,=Ig__T6A6REcBeI.(3&5=3=,(Bb_K<,RFQQTTJ\
1-QKEW4(I>OU(HOZ-c-HF+/K7^:J7K2SaWD8;^H^5Q;>K#/,-5;=4AVDJ:MOaK6,
+/,+,?d-eUJL1]B[[)P2,V0eZ6V_BTbA0(4:Q&gHUJY3:W05I)9\B4fI2(FSGfGE
Uc:>7KNC8S90KD2N/]]VLX,e@VF_@AH4P^Hb=;MED\FK,P.4,=^WUL7/-NB:[<?&
fSM;P/7SBDCI?SM2V6C0_MYHU9W<2\WW><&&R-2F&Md[V\g6Z[H5??LSCAL_a>0&
9g.[AOaH@>V6_<#I&FYg(?WYOe;L<[>eC_Md.IF@]d(DPQ+b<:^X3RT/UG&D#)ZP
XUU,]F>ggc3fU[<5SUYb]&UA0_\5\d7.P86[gS/&3Q^_g]30aU^^(REZ5UBFb7SS
a9cQdNCaPO]=QVJF5_B)RGAa&1(;da3&@GJ9NN9<CQP4RRES2VSQ_)?5,C(NP:DL
GRfD:=R9JeQT4b/8Xa7EgALZDb1bD0@3bc]?a,K8#b)Vf6(-JZ[&7Q<Je&5K19&3
9OE6VG^fYB1g-LaE6<;C&c]0DRJJ-4bd6=)8d8(FYMLaFG.HHQU/YO\=ZD9aGQE;
BA2(HDVT?F3C),]FaZE#66a1U+[G-NTN;#eL/R5T5<FW,b+1dB>\.UJIVU6F,^J<
S/;@\ZP\_f\I@=,.cC473@/K>\U&4U@8[4LfJ5cedDY/KKC&GNgSDDJHD_SO>ITQ
f_WBb.A:6NFc4H9-326>4Y=g];]f&T1Ceb6b)=g-6,=K4PKAHL[<KYT/C5+CSg):
]<:e=H=&I^Ac(DB9;0;@:9[V)80B1^.A^<)SDH_(H=>dB495?V,d09;#aZ2X7SP>
YPA2/O5E8XZ0EYHLM0\B84cEPD#FE=ES)Ib0E(bYXI18M@IYE.>.9TBQA.+Q_Fc?
V@GY\/CP469SdTY&HR@]aT.Gf;:?eGR[?Y02.1AfANYDf<PH/g?5N7?E#K9HY/^b
V?^3KMIc]3B66,2<,OB488,CIAdcfA(?L7_;##GT8\GE?OeaaOg50bb5d+>F>e:(
ITHBgEfGQ0]QEWQa8<1T&4^CQ,fJVV4?9ee&#Q+S/?^>]I3PEONL2(d+^;Ra]/KK
(/2E-QMDcG6TP,FNa&:PcQ&c>cVD+KG]8aK[R&25d(3Q5.94488YHE/HQJ5T#/KE
a6/S6cUcOTDA,CH,DF5DU-Vc7)[IRMU>R6<]&IE:fbL/.)<_\CF+_\B66aSCDE7;
H]:S]::12(+,8ZFFa/;GXbg=1Y(CE\<T3<+E=e^:F:U_^[=#X5:c/QFEEWF3/Nb;
F2]O8UF(X>&g:MBLG2E?=^5\Gc)+b/Q-X7#@4MVCbKCG/)_gXGb:^9R;T\XQ+-[2
?cNU[99.((#G>KbU\a1AgU+fHT3O5#dPUE+I0.\aV]DG\26NA\C?O]4O,8Y5+R[V
VDf(--PbBbE-&+\fA2(CI6f)U/LTM]g4eab4W=X@:K80<VEO&48f0VP?#J4c9Y(-
g]a&4P19&H4^_=P/RS/H(-HDeg0TWK4VE?/=/V;Xga32K1>(JA7SJ53a_\GZIb1=
]g4^1HX,ab@787\2-2^HPS;^)d^.4]>2RWg>g=;4S7e9UJ9-3,HMaI^V&W91-L4>
RLT4I/MT2Yda+2MROT3Eg[fE:S82Pb^c7XRJ29^^^RMS<0^8>UC)Q93.f0eP9?A_
1N&MW?Qa6)GI=NWWVG/6aD2;EW#<ZW#7.M9CHe];C2#AXLPA==_1QSeb>23b-C>2
)g@U)(@O?54Q/UAIg?[QNeVSD=MADg_0)H<cdeK(5Gb.ZPG/DKAW=@3ca;HVQ8#L
O80f-@]99cZD@3d:[a(JS=;3:3OO=I-,/&AZZMGHGVFKE#X#O9YGILc4:-XM>2?f
VJI8]5ZWD[f&b:NFeATKMGEFKEJ]E&8A+>,/1>NJF)Y.9g?CZdVO\J-/YNLS-f]O
##/adSb^X-c2,7A(D?WZU.1B+,8956@#6GV2dd(YMf/c-Hf56ONS#S=T\=/4)a>0
I9-+2ZE7\[1YJ5e/ae<&27;TY8B#Ae#VIb;9M>]FK\)=6<@N1JK\^d^;WJUBb;.3
H[LLTT88O.K;P?]K<,8)RTSPDbJG-<H1U/4[)2QWeU?TcP\:I(8\VJBK@Q/Q=@7H
V-\LOg4VfB?0X@XL+8KW@TW;T>4MQDZ06cHI2.#f4IM-VSc>(W7<5;6]5c>>Mg,Y
,_9e)4@Y3#^2[SW=5B.YEf=8d8Z\FXW>EbKW/Zd(OUMM5?:B@B0W+MD))]@.2<b8
OFceE,e?+8)A?g>6=fd)eF@@):]_dF(4^#8S3Ncd<9<X&N>RW)VT0E-cIXRASO6U
cX^NH5a)BBFe+>af#^3<d2TSJWOUIV4eWDZAPB6?T,2OJN1V.(O47+d4#WU-D3WW
Y-9,2/J]=6=)bJg-;CG7YUG7\S0PTbL<,_g-[-Z6/#=<UFK@<JH@C52ga?L1<?+3
S7W-28-[;d.WF5[LN11YD_e.SBdVP6Me/SgCJ;0eR3<)PJO5(Y6=7:@@9V:ZIALO
Y1++,X^e#RAIU/=E0,]]6Kc9a4_d)N.c2[6^C2b&(RI70bVJ(R^=8eGTUFC@f@/T
g\4>d:?<6^FW0&7]7,8-_KC)DF<8O93?4S1b+2e;L]bG69He:ISgO2N28P8CTN0g
Nf2)NGK]efE_.\aDYWV<@:[[:UJ2.STI6(+Dg#EKX>2:9CCA;AN;G@-9I9gL#05R
A<657H#4A4?K.<Abf<[Vd,&UMW)[f-(<QABD798JDMLTWGe1Q]LILANXf4QC;=>e
N.:eY,#/.RcTUUHL8,)>)YA[\/_,@SP3O>V99>2TS8Xb39ZXV^]9C;?b1LP_c<XT
fa8Y\]I6>I\;f12d(/Z^b2@#KYFOUQJIL@AC4?d&db6YGJ;XGA@3&@+@M]1a=+-R
bB\29YOB20TB-JfP79=(,VKRDBN1H+@0Q)c;\M>HUV::BEB5bZLX=R,9N&<;(ZV)
a&.V70D_eG.L5DW&<Q77ICJ.MQJcZB)33?5]8L);R,RO7)IRXRLGV3GW;&KNJf,?
I-HbP\1\E<.[Rd4bBXD#@da4WNDc(D+e1W]V8U+>f9=5Q]O3K1MN<MX&Yd7<.0CV
_G@0,d/;S]F0@L;;Q5H:>4b_K@aM2>Y0>f.f=U_AKUbVO2+gGOT=a[LLV-=Z4P+Z
-=WUT0PG?=J._AJ,4\RV[Z<0?S=.Wg20[DDYBFI/PB>+1P+=)IT-UO1\T:LBW:&,
We;K5.DCGg<Mf<,fXG>F=BA+1>acd184,YA-2dC^gB7STU2T62[JZ;+5XT(0HJXV
6LBKd2HYMeIIVgW\/=_e):KS-3O5b(=LN2R]Y,4Q1fBQ=Y1,5#HZB#3&6;<Z+DO.
?cIdTX3Ig\@,+F-.>Tg,91P(DYBF3c;/S.9UKI:H157&2-g233DX-_+.[bcaKX3_
1U:G;@W_+-9GW2JGP5KJFR&X)VDaT&2b=^4NMHd=Z=BfGY[VdTGN(.CbddMa=SQR
K2)N<aa;#1[Q3.>(N5LU6Y#fQ&K<2]?QX\\PdgDGI/5,=,6:98VSG9OL5&IVV2F3
JOZ>64/P8RH]^9#b?PGL_<^:0]/I=Y4?=P7(EV&Z)4OILP/IY^^\QH8@4bd&g<#=
SZ-eVcd9/cIRP@8,I4aZ\BP:504MDL=@D::_ON+>&=0N]14W7#R-&7U[M=\De/9f
\2XH[](^&54\T+==F(\51(WET\@X49RCfRd=XE<Ta\/WI9@eETAA46P7]7(^;-OI
F7_UH)gHXX2A[M:GXK]=C6dL@5c&1)_C-N]3R338D+CHKO]H:F,W?H[G2)6\WI[^
#d2A0PIY2NFW;=B5RF#J:COSb\QMF,/=[b#N0:#+L+G1aK[T[LbPLT8#_RTPEA;B
=LNJ2d;/_&:R&e<8a8JSGb.FCWVO\6ZI17YFUeeR5DM^S10Z\(fN9+I5UI,V^G1P
OH_X#f>HQ6M8)GL/cV3IPSR[:9>-XA5C4QC0[ILd)UT2L7C;<eP#^+<PR?;N+G-/
.C&K=O8c+\W0Q2313f2N[(QEeK^?>.]17DXA85DCHN>=9BV(7H-gO=,baX.ZA.8_
;<1X67_1:MY0GGXIX6)X>+4dZ(V#I[3I\=3Wb<>A.:O&/a98Uf7a&^bZ?)=8\H/8
&[2+W=XOGS4+Y^63:PPJ[b=+3YHXS(WM;/#YeDg-e<(^+8H1LYJ(cVS=O1(^ZR^g
10UEB)02:_N@0)2J-ACP^+)V1N.H&\];LY0cK(IZC<#,A,JCA1XX^FgS]I:(,g)K
bc@<LA]0HI^.5XbcVJUdDZ#R&N?P8/G3bU)c^YNYgb>?Uf7SI6a)9B]DbcJW.d=d
E^W;#<)LLP2,@@7UFA#@,=g2E@KEI&][P>_c?E>P^5VJa._(_cQC2[7e\-JR>&^I
0P6I;65.(OMVQ;Y_^[J(Z&U97RMHNL(D#0C<JLbXX47.A;MBO5_SAA;7.88E5S;P
+C6QC@I4c4c1e:=PUC(HQHUeM4cY-<Y1cNgX/C9IU#51&b?Mc5\4:-<7?8La7SD[
1e>ZHHO&+Ib0&c>e.QRA0L=]?82V-<SWL#08]8S8/CE8P72GF([DZ5,-KN^CDbD6
^ffV&a7\ULcZeY7HB]2F;6f^(>U<:DX&^JX>3PbY9A#W1,1OKFRRg+B)^4T^b@G(
Ee>QANV]C?P_KR/U^AY4YdZPb_^/6VAcWL^GL9X@DYLUQE+W;\=+EFB\VM,_I3H?
S3=AXQe@[c.=/9>(A<Jbac);<GER:>Yc/(>OQTW&WDdW4?)CSYQSfd<IZY].TX;M
aJ4I\MLLeFbMe/AOZedNeE94[5D1H.I5S:X_QeIV\13edRYOeeMGBMR]X3A#ZW](
M0F=,0H.f78_6F_c0W,X<g>=TT&GNaXeJ^7W_g,4UKU08TNJM\dHe\7;5f)_e&2L
_QQQ\8CdCNM&<X_5O9bFR9G#.UBM;3H9/PD3:?MZO/cJ9PbNUIN4>a4X9WNaFW[]
ZN3)X]4BCcRc4),LNPH[>_GIL@NQILa?eULHKFafFdKDc@cFP>8>HQW/g?&7MD=H
ZW3fXCKeZSNYC5TMg[X8^_S;YEb<(A-:Df0U_LV0-/ZXg#,L@bB3):7S=b@+e,+Z
O\GWgS?Q<>9.0_&X3T>@^Te(PUGP#8)\+Q2YY8UQDTF+fEP=g=0UND<R@N@UdCX=
1A;338aY(2LDc@W9J:ZMFEH>b3]M<I:RQ32M?&9<TD=e1Rd2;QWWeg#_FK0N2MCJ
<:E40<B&AELWGF<<O&&;^=@,/QWOcL2)@-Ee:eLe^J&/JL/8&]FL+VTT4LBG\_DC
EGSF^GS85&fDd5e7PA@?HY)4:,=0?)UNTWFOX;(gC+ET<>Fa#K],VU7:JH=X9O38
?F&HJ+)d_g^(49QBXbKFN78[dS@J(UFc:L0\N-ZUa2Rg7:8H-b9(,NWgb9+YV02^
WFC8G08SEDK-D9COZ];c0ZMA9&f:GaOM\.K9729J3IST0UV&=WcC7YeHUC/CfAYL
H#HDI<#9?3C2J5<R8\U2ec@-b.R4M^8RWIbVAVMGOf/]Jb//M<4YVFcU07c]]DQ1
[?c/N\ZO,S6V@V)\S57gWe&F,,(R6F/,,N?Q=5LDWV275W,:Ba9.^^INOHZ>W1D&
#\R0?;2W1W,N&44f&F4ZCNWD9&^cbL[IT)J=W[BA9eaf45>bS;N(6CEBJ=684GJ3
88.D1=S7QT3VbTN;J;(,5(&A&&F(W,Y8e4DU_@7YaM+N?A6),C,:]R2Zc<Aee[.I
M0>W/AQ@a41>Z_H_&+LPIMCf)b.XTQL0/G>W#G_5.--M>HcV3>1;aH\CDg3DEKLf
,+6EbE+(PUb;ffK&YAWP3\UVd/9W15II8-GQf:I+C2].)bAN7K^Q#4J8Oc^D9/[,
8:52fcOMIGYg&:YZfC5D(gbE>>N-.Z7OS#C13Z#+_fL4/=HSN]FXN50Q3MLGcbG&
OJ9@=)5QOS;_45N1B,Y1W6=(?PB98WeYCb.Fa#_8M4=NQI@]0APB-^HLN,Y?G4,2
L-^A?eT)(,a,U8:\?6>>U>eTdHK=cIUAEF(L_-@VS&(GB/g&R3N8\4\<Eg>;LFH;
._6Kf0;=&Q0#C]^W^=.c<D]aM.?6)\UN1T;?BUQ,U?aN<_J_6Yb2T[N?f?g+BWef
[0<=2J.1=A;^X4#35:e[S41S+E.EH]<8fX.0^AF@VEG#,&C[YEE4XNV?.bgVXA:K
@e;6[/IT/EVL>(.651-7dE6J\EAUN7XI?/9)6/T5LU;JO^52&e)LP]eI&KVERGB]
7Q86H@(4_J][6.R8/15G;-@&49BJ.,[SE98fNW\1/S/7)#>]\.4YZ#Va3g\KM=BO
)NT@HHQ<N4&4WW9e@U[(FX38>-QO1,d@0^(&((X[QD^/-X;QVbZ]F-TB^FGZ[339
-\Lg<4eI]4X(;X=1<=He6&\7Sa3+\(N.V_C\@&,?:H\bcX]?V/gRW4aFc<7&R,WK
KKGF.I;(7B?bbRBPNc)>9b.e[R+>X1K],CPZO)1;=JYMS+X;cc\<WGIAZ#OSNgWe
MCd6VS9Tf^JEA^T=d,:]+D17=JK_1FFae7dXUO;W5RH#,H/ALK#GJ3NI=E(+0We5
Y=K0_XGO]FK-YgD&a+4-[.9.KP>_/)_MH7(9<9G0W4NBV(D:573:@8aVa3L\WH4,
93b3eV4L9S6N.2=FaLW)We]Q_N4ebL1#87abf=_Z3I+UGTE\d-596\UAX>^36deb
XZe0/?</V]L@1H?:<P_W--8Y+)9?#^7,EJbdDRC&&RO+ITaL_0dg9321M[aHV.4X
6K:,G6^][#>XHX2AQ@N>g&F8]:4&USP0;W.H0&UXb>_8ZNVg@SE,?RA2>d_^a1(N
Da)NB>ASbLWaT6?#OS9;AWI&Ab@9Y_.>f#L2W^FW=#MA=J#L\5:9a=<EMD/-H^WH
()+\EWA?/IR5)=RfZbUg7=;a+;TWeN,Z_dK+P9YUG;^09H]Y(?)-K1H8R1S=f)\[
(7:,d;6H3f#+Fb2[gScE+#.UO4>:,5P\3ZK90FRCQ-\<ASc(7H:3cDYUZH84J,;X
(bg4;8:5;YbEZ.N)CJ+]g_TSZ4#K5V50T4<WX[^NTCO:/(_[_G=O62S8TP,]F3SK
6[21U64/ffL-E>WO(&cdB\Gg0SSM/3QI(8NMTI41cg+f\Nc)7C)39EV=R/[@9&RL
\P#50>N+.^K-(=2/05(G=\268(f1eD.</cOZbI</+@[PBTN>E7)c/]HdEAQ@-5CW
NK2I^N-Z2;\6P+e\gdTSWc((2QAKS5+SWCbAZ8Y1PNT)[Q@b=@>6I\)e=I0d0E6\
,BG/NF\N\U>BJ4TBLdWH8&DL#c<,=Lg<g:P1Y)T(P(].RA/<>/)S3d1?:dSPC./1
[4_1S^bDFE.B:;4J(;=YMc<[]/P.6W&NR_B]\e5ccE&&K;A&R<2,AG+NaP72_c=E
W>8UO;[&J#aHW8_[AK_cTef_.MKD:CJ3/7[SaL91g1H.(]b75TcN7fX7HEJIKX>Z
,H/>VE+7OW_e1Y,KK6Q5<a81KB5C8:B9_K62N;f-C:NNAVC/T)5Q)T+:[Z.\+AY1
:>V^bVW[KaHPVA<GRM?+IE=09[LbCF8PJ\@MDf)G[HC)5[\Vd>D[c89@;[fC0GDQ
[C3VT5BG[aO78M]d6\[3>SA;\e-ZB7QD>Z,YJCgVC@#gDH-[3#GYIYO/8;>1dLb^
Q_5cMO;#0fg4(SIR\H-.>LJZ&UgMEc:4LTM?5WHMUZJ#XC]gHb>^T.4SVDJRK5U?
BF@d56;5>VD&a:+_fR,>ZEd[eYg:2ZYG_Q51+8/U.gT/FWF.E0Y+&BJP)VZF.D0d
&?+>BWeLX-L#/Lc]^RQa=+&e5N#<.F0O5/KM2,@6BR/&++]4.bR0>/&:fP<62<LN
44\3W/QIBgaa?QXVd5[&.1]f11d<SZ#eE=R^#-Z).Y;\\^8O4b5MW])PCUSFbC7D
3YT+]YF(05[N<06g:aQTaN(EK5F.Z(^6EOL00Sa9OZ<b&VO+FWD?4^4fdG6:1N&@
c=A6KL;\QfQC<dY.O+N@24XR9MEI;&4D1b&4]^KG=H0cYXQ_#Z^-@(]]VC#3VN?R
4&6QIW<MRDC]-g56FfH#FG8.cOQW<4.,^JP;J35d?[V5PP5aX_N6eZ=2+=HXeQ)6
/A_c.9Q.=a3<1]1<<G#/<>;)9/)L9=fA<+FVefRRcAb14N5Y,c@ec39/[BCC^4^A
RZHd47;7+>?f.dUNH?UYa\bX3?;_=781#]0Lea](4S\9]<^abeA,GY57LCWZP(9&
Cd1S7a+Y12AQV#G]<dWGI/(>)>W90>5ONNO+7W?-#R06@\Mfaf[c>)M(C&83Z2;O
(QD8bG1^4BPAD?#gKI<a1\bH\&C8a/AAFXB/8ac^3>=a>SC36?4dYFD5eIYD\>&:
<+\.=[3-<@T2D7bAQ,Vg]D7XGTL9T@JDGE#1[4+;d4f3VD-cX@I?0OJXf?2:X]8R
]A#=dNE@AHF0O7=175UIUUI(a4F5+FF29/5:G_KePB]5&Hc50<H9.U9I>MdI2V/>
(J01HT9K.H^Z]B;[.FNR#T5@>6A/,;TT&c9AT(LPF(=b>?7O^:-(Xge/M2aBHP,4
7HE#KKF=C.[Cc6EX9B]&Y-F)O/_WVG@?^UV+(]3TgL<1X>^^)(:d#6-#E0e5gUbZ
Fe?AL=#UB/-d^3(?3D>;NKOA\VC0:(AHgcB[ARQ4I&CW4P@[DV71?F.Eege_\1DF
959^cRe,6C)/SSA6_0)KB3)?YTX@<GW]D]=B=L:F4UH)&@ESJ-+2_+<g?/ZG^2D^
ea4I@.fR(1V4Wd0SVTRW4=,\I9?(P=M9?d>TbS+D^)1d5_6a.XE56Y/[:_?FWHB4
,[R4&_8>f3FT]L>38#XT9@\DOG#+7[WdO<-g4b[B2XP[AX)P3I/G&SI[.YIVJF?>
QX6JHA+^9<:.b>7.eP5gCe7[7d#NDQ10WGaNX-S9J-D-X7[/FZg]B_#<@=c8f?#g
&;d20B?3/;MK0SM&S1:<A:S(b30LV=;]-Pfa^I\:fK>57S(R/IZIVTO@McRR,6d/
gKc)-V+WQG?>7O]a40g2GCBMW/;WH9a,=5+A9;3,^@aHJTSL0Xg@0,cV?9O_0?5/
2I.]gQ^2V\JB2FXe:Xe-Qd\bQ\5UV;C9POPOJ+@>T,#P2@?C,bIH8(Z=;596E.F^
)^e;73.\_4O0)LLfY3UHRN+7?J]2;Y^2^U7[N#W9GVD]MJ/UZ:+4:0PfD459A5SE
gXYHEK<7M7>3X^WJ;[=OU2B@9J;KbC,&2Ie.[#D:?a]CL8>EPSC7d(;T7Ka/Z</\
1T.V1_BNM+:@;33JOcKUd(b5Q;]W6g#[HH#4Ve]fg0YP8>3d;5@6&#g#,CVbW,PJ
<VIgaHLcR9QE/IeS7+M4\g:FGN=P>D0HPe>A]L8EfF/Pa@8;PYMEafWY_c;0c?/a
UK,gG,]-EfM6LZH^4@H:-#=7dT?EMEPcPDQ78CW_7OO,1/KLWWfINRP1/NLBa,E\
e@\BAT@,M)H+1M\6ZLe=:V<,O]-[AC#L3NV[g^aJ3]TbF-_+.))TI4T3KC?Q9Q#A
@7cU):D,;_;NH/C1V-KJL.CVY@?]-PVKZOg&FPg@>PEUWX#8Rc\fD82AL\RIIMO+
Q7&Ja2^,d5OMAJ4_6#UfB-VXZf>E1Q=_6P&.1/.8BMAGOP0L8Nb(,[3=4L(59=DH
<;IPRQZX;d/(,9;VX+,6RAW?W[HaY8BYNe?-TJ]^9N4HQ3AN[NVg?>e;a768#DIG
,SH<Ig9dV15N59Q;OQTNA_T4CeT/9EP.T4]+3B&SDCDQ^fHJI[=/W1CXYH8QGH_M
UWN:^A#a\ZDY1O)g2;RdU)=)BFN/HaE[-&F27c208DEQC$
`endprotected


`endif // GUARD_SVT_SPI_FLASH_SPANSION_TOP_REGISTER_SV

