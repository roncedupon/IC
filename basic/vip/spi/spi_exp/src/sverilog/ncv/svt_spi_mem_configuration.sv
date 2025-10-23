
`ifndef GUARD_SVT_SPI_MEM_CONFIGURATION_SV
`define GUARD_SVT_SPI_MEM_CONFIGURATION_SV

// =============================================================================
/**
 * The base configuration class contains configuration information which is
 * applicable to individual DDR Memory components in the system component.
 */
`ifndef __SVDOC__ 
/**
 * The base configuration class contains configuration information which is
 * applicable to individual DDR Memory or Controller components in the system component.
 */
`endif
  
class svt_spi_mem_configuration extends svt_mem_suite_configuration#(svt_spi_mem_timing_configuration, svt_spi_mem_mode_register_configuration);

  // ****************************************************************************
  // Local Data
  // ****************************************************************************
  
  // ****************************************************************************
  // Static Data
  // ****************************************************************************
`ifdef SVT_VMM_TECHNOLOGY
  static vmm_log slog = new("svt_spi_mem_configuration", "class" );
`endif
  // ****************************************************************************
  // Public Data
  // ****************************************************************************
  /**
   * This property reflects the memory Device family which is a property of the catalog
   * infrastructure.
   * Catalog Infrastructre hierarchy is as follows : </br>
   * catalog_class </br>
   * catalog_package </br>
   * catalog_vendor </br>
   * catalog_device_family </br>
   * catalog_part_number </br>
   */
  string catalog_device_family = `SVT_DATA_UTIL_UNSPECIFIED;
  
  //----------------------------------------------------------------------------
  /** Randomizable variables - Static. */
  // ---------------------------------------------------------------------------
  
  /** bitwidth for Memory Block 4KB address */ 
  rand int unsigned mem_blk_4KB_addr_width = 0;
  
  /** bitwidth for Memory Block 32KB address */ 
  rand int unsigned mem_blk_32KB_addr_width = 0;

  /** bitwidth for Register address */ 
  rand int unsigned register_addr_width = 0;

  /** bitwidth for PAGE address */ 
  rand int unsigned page_addr_width = 0;
  
  /** 
   * bitwidth for Main Memory in a Page for NAND Flash Device
   * This field value must be less than or equal to #page_addr_width
   */ 
  rand int unsigned main_page_addr_width = 0;
  
  /** bitwidth for Memory Block 64KB address */ 
  rand int unsigned mem_blk_64KB_addr_width = 0;
  
  /** bitwidth for Memory Block 128KB address */ 
  rand int unsigned mem_blk_128KB_addr_width = 0;

  /** bitwidth for Memory Block 256KB address */ 
  rand int unsigned mem_blk_256KB_addr_width = 0;

  /** bitwidth for SEGMENT address */ 
  rand int unsigned segment_addr_width = 0;
  
  /** bitwidth for DIE address */ 
  rand int unsigned die_addr_width = 0;

  /** bitwidth for DATA address */ 
  rand int unsigned data_mem_addr_width = 0;

  /** bitwidth for OTP address */ 
  rand int unsigned otp_addr_width = 0;
 
  /** 
   * Bitwidth for Chip address. <br/>
   * For Slave Devices, this field is applicable when Mem Configuration variable #device_package_type is <br/>
   * set to svt_spi_types::MULTI_CHIP_PKG_COMMON_SS_N. <br/>
   * For Master Devices, this field is applicable when Mem Configuration variable #device_package_type is <br/>
   * set to svt_spi_types::MULTI_CHIP_PKG_COMMON_SS_N or svt_spi_types::MULTI_CHIP_PKG. <br/>
   */ 
  rand int unsigned chip_addr_width = 0;

  /** 
   * This field denotes the start address of Chip (Default set to 0).
   * VIP supports Multi chip package by creating multiple instances of SPI agent in Verification Environment. <br/>
   * Each instance mimics Single die of MCP. <br/> 
   * If there are two 64Mb Chips connected in a network which shares same or different Slave Select, <br/>
   * for Slave 1, Chip Start Address value would be 0 and        <br/>
   * for Slave 2, Chip Start Address value would be 24'h80_0000  <br/>
   * This is supported for SPI FLASH mode only.
   **/ 
  rand bit [`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] chip_start_address = `SVT_SPI_MAX_ADDR_FRAME_WIDTH'h0;

  /**
   * @groupname spi_cfg_flash
   * This field specifies the type of the Environment in which the device is enabled. <br/>
   * SINGLE_CHIP_PKG            : Normal Operation where Single Slave is instantiated.        <br/>
   * MULTI_CHIP_PKG             : A System where Multiple Slaves are instantiated with different SS_N <br/>
   * MULTI_CHIP_PKG_COMMON_SS_N : A System where Multiple Slaves are instantiated but Shares a common SS_N <br/>
   * Default : SINGLE_CHIP_PKG <br/> 
   * MULTI_CHIP_PKG and MULTI_CHIP_PKG_COMMON_SS_N is currently Supported by catalog_vendor APMEMORY only. <br/>
   * For all other Part Numbers, SINGLE_CHIP_PKG is supported
   */ 
  svt_spi_types::device_package_type_enum device_package_type = svt_spi_types::SINGLE_CHIP_PKG;

  /** lane number on which HOLD gets asserted */
  rand int hold_lane_id = 3;

  /** lane number on which RESET gets asserted */
  rand int reset_lane_id = 3;
 
  /** lane number on which Vpp gets asserted */
  rand int vpp_lane_id = 2;

  /** Enable/Disables the Write protect feature for selected device */
  rand bit enable_write_protect_feature = 1'b1;

  /** lane number on which Write Protect gets asserted */
  rand int write_protect_lane_id = 2;

  /** 
   * lane number on which Ready/Busy# Status is driven from Slave device in Extended SPI Mode. <br/>
   * This lane id corresponds to MISO lane. <br/>
   * Example: If this bit is set to 0, this will actually be driven on dq1 (SO corresponds to IO1)
   */
  rand int ready_busy_lane_id = 0;

  /** 
   * lane number on which Ready/Busy# Status is driven from Slave device in other than Extended SPI Mode. <br/>
   * This lane id corresponds to MISO lane. <br/>
   * Example: If this bit is set to 1, this will be driven on dq1
   */
  rand int non_espi_ready_busy_lane_id = 1;

  /** Specifies the size in bytes of Spare Region in a NAND Flash page */
  rand int spare_region_size = 0;

  /** 
   * lane number on which MOSI is driven during Parallel Mode. Once Parallel Mode is enabled for current command, <br/>
   * Master will transmit data on parallel lanes[Parallel I/O] PO[0:6] and PO[7] mapped to MOSI[1]. <br/>
   * By default, its value is 0. Will be set as 1 for Macronix "MX25L12865E".
   */
  rand int parallel_mode_mosi_lane_id = 0;
  
  /** 
   * lane number on which MISO is driven during Parallel Mode. Once Parallel Mode is enabled for current command, <br/>
   * Slave will transmit data on parallel lanes[Parallel I/O] PO[0:6] and PO[7] mapped to MISO[0]. <br/>
   */
  rand int parallel_mode_miso_lane_id = 0;

  /** Enables printing of High Verbosity variables/messages */
  rand bit enable_mem_high_verbose_msg = 0;

  /** @cond PRIVATE */
  /** list of bitwidth at each Memory Hierarchy*/
  int address_width_arr[$];

  /** Width of Page Mask */
  int page_mask_width;

  /** Width of byte Mask */
  int byte_mask_width;
  
  /** Width of block Mask */
  int block_mask_width;

  /** Width of memory block Mask */
  int memory_block_mask_width;

  /** Data Size used for ECC calculations */
  int ecc_data_size;

  /** Address mask bits of the selected datasheet */
  bit [`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] addr_frame_mask;
  /** @endcond */

  //----------------------------------------------------------------------------
  /** Randomizable variables - Dynamic. */
  // ---------------------------------------------------------------------------

  // ****************************************************************************
  // Constraints
  // ****************************************************************************
 /** Valid ranges constraints keep the values with usable values. */
  constraint mem_suite_configuration_valid_ranges {
    row_addr_width         <= `SVT_MEM_MAX_ADDR_WIDTH;
    mem_blk_4KB_addr_width   <= `SVT_MEM_MAX_ADDR_WIDTH;
    mem_blk_32KB_addr_width   <= `SVT_MEM_MAX_ADDR_WIDTH;
    register_addr_width        <= `SVT_MEM_MAX_ADDR_WIDTH;
    page_addr_width        <= `SVT_MEM_MAX_ADDR_WIDTH;
    main_page_addr_width    <= `SVT_MEM_MAX_ADDR_WIDTH;
    mem_blk_64KB_addr_width      <= `SVT_MEM_MAX_ADDR_WIDTH;
    mem_blk_128KB_addr_width      <= `SVT_MEM_MAX_ADDR_WIDTH;
    mem_blk_256KB_addr_width      <= `SVT_MEM_MAX_ADDR_WIDTH;
    segment_addr_width     <= `SVT_MEM_MAX_ADDR_WIDTH;
    die_addr_width         <= `SVT_MEM_MAX_ADDR_WIDTH;
    data_mem_addr_width    <= `SVT_MEM_MAX_ADDR_WIDTH;
    otp_addr_width         <= `SVT_MEM_MAX_ADDR_WIDTH;

    row_addr_width + mem_blk_4KB_addr_width + page_addr_width + mem_blk_64KB_addr_width + mem_blk_128KB_addr_width + mem_blk_256KB_addr_width + segment_addr_width + die_addr_width + mem_blk_32KB_addr_width <= data_mem_addr_width;
    row_addr_width + mem_blk_4KB_addr_width + page_addr_width + mem_blk_64KB_addr_width + mem_blk_128KB_addr_width + mem_blk_256KB_addr_width + segment_addr_width + die_addr_width + mem_blk_32KB_addr_width + otp_addr_width <= addr_width;

    data_mask_width <= `SVT_MEM_MAX_DATA_WIDTH;
    data_strobe_width <= `SVT_MEM_MAX_DATA_WIDTH;
  }

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_spi_mem_configuration)
`endif
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the <b>vmm_data</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new(string name = "svt_spi_mem_configuration");
`endif

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_spi_mem_configuration)
  `svt_data_member_end(svt_spi_mem_configuration)
`endif

  
  //----------------------------------------------------------------------------
  /**
   * Method to turn static config param randomization on/off as a block.
   */
  extern virtual function int static_rand_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name();

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to );

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to );

  // ---------------------------------------------------------------------------
  /**
   * Hook called after the automated display routine finishes.  This is extended by
   * this class to print only protocol kind relevant fields
   */
`ifdef SVT_UVM_TECHNOLOGY
  extern function void do_print(uvm_printer printer);
`elsif SVT_OVM_TECHNOLOGY
  extern function void do_print(ovm_printer printer);
`else  
  /**
   * User extendable hook which is called immediately after svt_shorthand_psdisplay().
   * This is extended by this class to print only protocol kind relevant fields
   */
  extern virtual function string svt_shorthand_psdisplay_hook(string prefix);
`endif
  
 `ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /** Extend the UVM/OVM copy routine to copy the virtual interface */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);

`else
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff. Only
   * supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE. Both values result
   * in a COMPLETE compare.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
  
  //----------------------------------------------------------------------------
  /** Extend the VMM copy routine to copy the virtual interface */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);
`endif

  //----------------------------------------------------------------------------
  /**
   * Checks to see that the data field values are valid, focusing mainly on checking/enforcing
   * proto_valid_ranges constraint. Only supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE.
   * Both values result in the same check of the fields.
   */
  extern function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. Only supports
   * COMPLETE pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. Only supports COMPLETE pack so
   * kind must be `SVT_DATA_TYPE::COMPLETE.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset. Only supports COMPLETE unpack so
   * kind must be `SVT_DATA_TYPE::COMPLETE.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the buffer contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);
`endif


  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
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
   * @return Status indicating the success/failure of the encode.
   */
  extern virtual function bit encode_prop_val(string prop_name, string prop_val_string, ref bit [1023:0] prop_val, input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

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
   * @return Status indicating the success/failure of the decode.
   */
  extern virtual function bit decode_prop_val(string prop_name, bit [1023:0] prop_val, ref string prop_val_string, input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: This method allocates a pattern containing svt_pattern_data
   * instances for all of the primitive data fields in the object. The
   * svt_pattern_data::name is set to the corresponding field name, the
   * svt_pattern_data::value is set to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();
  
  // ---------------------------------------------------------------------------
  /**
   * This method loads the property values from the indicated file assuming a basic
   * text format. If filename specified without file then creates file handle and
   * uses it to load the values. If file specified without filename then uses file
   * to load the values. If both filename and file specified than no load is
   * attempted and the failure is indicated via the return.
   * @param filename Defines the file location.
   * @param file Handle to the file being used as the source for the load.
   *
   * @return Indicates success (1) or failure (0) of the load.
   */
  extern virtual function bit load_prop_vals(string filename = "", int file = 0);
  
  // ---------------------------------------------------------------------------
  /**
   * This method sets Mode Registers default values
   */
  extern virtual function void set_default_mode_register_values();

/** @cond PRIVATE */
  // ---------------------------------------------------------------------------
  /** This method sets the parameters to calculate block/page/byte mask width  */
  extern virtual function void set_params();

  // ---------------------------------------------------------------------------
  /** This method returns the address frame mask based on address width  */
  extern virtual function bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] get_addr_frame_mask();

  // ---------------------------------------------------------------------------
  /** This method returns the total number of memory blocks present in a datasheet  */
  extern virtual function int get_total_memory_block_count();

  // ---------------------------------------------------------------------------
  /** This method returns the total page count in one memory block(highest level block)  */
  extern virtual function int get_total_page_count_per_block();

  // ---------------------------------------------------------------------------
  /** This method returns the Page Size(Main Memory +Spare Region) */
  extern function int get_page_size();

  // ---------------------------------------------------------------------------
  /** 
   * This method returns the size of main page. NOR contains only main page
   * whereas NAND contains main and spare page 
   */
  extern virtual function int get_main_page_size();

  // ---------------------------------------------------------------------------
  /** This method returns the the size of a page */
  extern virtual function int get_max_page_program_size();

  // ---------------------------------------------------------------------------
  /** This method returns the parity count for bits to calculate ECC */
  extern virtual function int get_parity_count_for_bits();

  // ---------------------------------------------------------------------------
  /** This method returns the parity count for bytes to calculate ECC */
  extern virtual function int get_parity_count_for_bytes();

  // ---------------------------------------------------------------------------
  /**
   * Update the physical dimensions based on the configured memory size.  These
   * values are used when configuring the memory core.
   */
  extern virtual function void update_physical_dimensions();
/** @endcond */

  // ---------------------------------------------------------------------------
endclass

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
fEoETmw+zA9bvzBP7zrBtvK22/86oaceC7z8qGWti4rSIIEVWwnnzArAb84oknaF
niU863NkeJlX/FstI2Gyn1WZceyuH8HFyynaz8Joj28WVzK3aHQZIxqKMpAHD2of
P6p3eRf+anUEdXR8mjL+RKftqxqnr2qgvYKhyyNFqv5NCIoH8a7zJg==
//pragma protect end_key_block
//pragma protect digest_block
Sx+X9oeTzNbUIUIyEucO8YDxr9w=
//pragma protect end_digest_block
//pragma protect data_block
ADKowXN6geiWtATSWaziU9EChmG+s+jYvpzUS0BMX+uEh8q3lDtnqHqXU+WDOva9
uBkGygk/XxVdwQI9//ILO8vaROlVkmkvSttwHi45Bk+X+EprAcnP6cz7xKrL1GC7
JLs+4JefwtfrmgzsaH+Vj7/lpL6WR3uYvR4tUQTgauCqJIhsd+1Pammzpj/82u+l
bu7UxVqeU5EIzqp6mb1Id7LSULuFzpwZLc5dkNOeTWvXjs0e6rRCHuukePohnjrp
sm+kpJ3AYOhv9gh+BYErvmdOxBb5LbJJQMuOpoZBHNYW5CJgtD2YfGmAoT6QSbH+
mkyoRAbus3fDJpVJtqssYV9yNUjr9vF0hVvfxB6HJckIbjIzgBgipPbrIuvQuKIa
1xv2jQyodYDA3iS05NyPSkzQDjKjmXNJXvhsrAjbpx1QE8HSwiXQeygESKrh2xm9
Iv19fcIh5lwcp3LtF8JJDJrQ01X9JEnFKqmR1LYnwb9pUAIYisXybIx85oGfywue
m/knR9uF2w/c/ln0d2WcxWquRXdEoElKYrqfzmJOjz5YvhV/dCM1B10XdmImIIPN
Bv8Sl5KgN3w4jRZLuNEa7WPmS4o07yYcMUKv6gkdaCGK+eVKFl4RwjSaJ77FeWRG
ZdSUT4fxj9EF9vHLRmPpvY/Mips1W0LkJtf2OEw1S1pQdWaZ/Rwt4pe6MvtAhaXV
2cTPdlC5BJ1GzXa0IwUTOsSmGcta9SNVOi+CmjgCMYLWIYQyJumZevknG6mUjJWb
Jl8PnC3LNU1d83TY2R4C/TTdCgimSF0EnUdGqFQJlM/eAzWuq28rgF3jHsBCOqq5
+Ibo3SadRDdUBQGpe1wXrvNq7kDOU6Qtvf5JB+6NF6Cr1u4X/SXaMWGvjGM3zJdw
F8bxlO4pQWHLFbYK4DzDb6GvTnD52z+WkmbTVAig4KFCuigUaX6/aAGR/3c30G6C
tNbx6uVLTyJqHxJ5sGPMyjiV5UmtiKG0v6+qQvxnNPIp7/V8hysKqbkyNOP4zDOU
8aULccr3STK2OSJe4YdJZyK8n182a1CLm+lid0y9SMGne+pvmnaehmlpEfLr2WzC
fp68L9l+wBwARzMVB5aBAnHAsuhKIKW8p45xHai1gHltm1F7wTnO+ODt+b7Hsk4F
yWj82IFdOYbNzX+usANq/1abpEoOtBiob7I05xoQkEfxKzrVWdUf4Exn1SDsxiMk
c0UHDhaO+J1akEXRmri255Jy0pxKVaBwC/V3stdiKMyuxxoRWOgL5BgicTprRQao
rWAQKBX/RMV0HylkhtLnMzSZ2hNu8BvfgiKh79kzieWnYm+qqMmuhFjqZfB2qSyw

//pragma protect end_data_block
//pragma protect digest_block
4IrD16KmYpGj+EhoHlzdZwBLDXU=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
fAOXna65Pqmu+Z91+tHm47XrUTy/hJKVVTUDmVuYhRBW/YOlMGNPXP4byCXqE2yS
+ifbgtYoJ+7fErK+k5/vTwvxA7bn2HhgU+L1MCltxz2bEMgsjtSgG6JNskYdxwzN
iH5eLnNfiDiaI8k+OmPrilRnIhj9AkcgLKM+63m+Lw9EOK6FeXs5Fw==
//pragma protect end_key_block
//pragma protect digest_block
9wSQtTd3ag7ggj2F7CZ90Sqmx/o=
//pragma protect end_digest_block
//pragma protect data_block
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
jqoeooLP9qSlqhX4jPO3BQ==
//pragma protect end_data_block
//pragma protect digest_block
i6RK39hfCwbZXAM8p81pMJElDlw=
//pragma protect end_digest_block
//pragma protect end_protected

`endif
