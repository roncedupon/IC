
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
c8ITWJsGczwbxHyKSAfOWsiJgM/sxakjotqw0nHLFNm/CPl1jQWtGLr3yqa+0EVc
+JB3K8HBBFNMfA64drvutA6hsSjdFHMilo2sc54/lOEHP54Zdb7nP6zD12eB1Gfq
jXMbFyvWU6JlNkg8kHUhRc+FOF2wdbarfmxX0sLHLmo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 830       )
qvGm8arPJIKJnHnx+YxKzQPFYgC6/yAjFbVJLhqFROZemMnUR5ir1J51q6HwOR57
Iciw+pKkj8A6xMjPVfG4h8kuErUakDYyhsmg5kosHk4faJMSeuhxwNT0JU3utkBG
qtdfyX/wgGvwn/2C097xFqRby6+nJmMUXdxGeE6vKCWk7F/z+icePVUJLNvQeq2C
fUyjQjjZYOufmBzPJlkX9S3v7ePysXpBGl7MylFdtc+M9MPinvUqa+sKw/zi5Ydy
Zm50tH0noohy6Obo1OOWApxSShjDKAoHP902mYY87AMBuG4jgGf5otXqWUb+ry92
04la0KdoaFH0I/5qE3wFklfMJTINoyNI0q/uzujcfpyi6FOHg+tREV3U4Qtp5uf4
GiNMGPS5Qjj4S72KA5Y8OgKVe318O2qLJbxHhurQeje3rEhNyephx+WuNMEoy3sm
A5QzDVnu6Of0D0zihAWsu0quPX4ZppdCSBXpTMbDuDio2Kw/fC2e+A5Vh+t/dg30
qRFdWypTgW0QKxVWBLXrKlBaNDZWGvDF81cJT0xcKkwvYqTF8n+oV90CVptBE/lP
vLiywQPp1vyq3QFn5GQhRs+iLlT6ULCUIbRlUJ5jPceFiBfysvTydPNLtoW0icUe
OcldEFqfVyuIcpyw+YKOYs0TG78J3sD0n8JIW5EErC3rOqQYyXudtTfOOjmmVgx7
8pQWyM5mF6IpQjCLR5kmvMRrffPLvfzmEIixqzp5gX1Yvkdlbb74bqEes6hqVC+J
sqLJm6Ws5HviDAFkgkS7aTRM65+I35jrhInkTvsmehXjv9J/GMmWm6KeNf1kM55m
9JcEQ1qWL8Wc+QCqkAkYj9jNy5qwVYHNUyJMkWgJ8un0zbCsne3lBlxNh+0/Ze8Y
r9QzoIjFzpZo/fbaIFfVNQ3Z5ser0o20DpU4fGEgtazZR0Hp33XTnWne/DZkLZxa
ZhN7lBIvruNbJ5rFg6ZVE05SLhhbgzDIqR4dm1Wn2qGDkT/Mo1XkB+7wnCQJVCBS
7VF6PhFuHQa93FegUDHPNog7KmySFgAHuIDDx2SH4uzn5uE8aJ/uuQK3dI1eUeJ/
4hT36SGSQOstxEYq5LWlZQ==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
HO2q+hLdD849PV1xJRVyYMKr9WJm7EYLuYsjcUpL8k+UJhafQauZlemiNpi0l7my
lL8EWy9XlpPq0HJwiYZcON26xzyhT6nOptnkqXByEAMTC12gcTYXCss5V73yFL2R
5aV3PIuPJ6kQNaovTwvIECjQu2bNOSKxFwe6FdKxSew=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 39751     )
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
`pragma protect end_protected

`endif
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
AUA7yYy3FGBghP+IFD30IKxS1ddR2mNIEyZAzafC6bMN2pzgyRPYVcht/55gQBjt
SiABytlZF/n+FHtcwjUH8h0aWzUckwJEAxQYpHDuvr11YCmWwb44S0ieS+tXeVKb
6k5IWWDO2QvptNlzIt193AVg30vj+4zNOZijN0yZw/U=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 39834     )
T4u2kw7OhT2TG0Vok7X8NfsbsE17YWiQr7DLU7DGesG3XemRFvqJsTmmSv5i8Avx
bKAUO+TCIjQFhxPps/WSqcqkdsFMZl2RcOwmw+f7YRXYiwfDCQOhapTgVfF84/6R
`pragma protect end_protected
