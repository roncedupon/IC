
`ifndef GUARD_SVT_SPI_FLASH_JESD251_XSPI_SDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_JESD251_XSPI_SDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;
// =============================================================================
/**
 * This is the AC Characteristics Timing Check Class for xSPI Flash based 
 * Adesto JESD251 device family in sdr mode.
 */
class svt_spi_flash_jesd251_xSPI_sdr_ac_configuration extends svt_configuration;

  // ****************************************************************************
  // Local Data
  // ****************************************************************************
`ifdef SVT_SVDOC_CC
  /** Workaround for SVDOC CC circular references */
  int cfg;
`else
  /** This is a handler to the SPI memory config object */
  svt_spi_mem_configuration cfg;
  /** This is a handler to the SPI mode reg config object */
  svt_spi_mem_mode_register_configuration mode_register_cfg;
`endif

  /**
   * Initial value for all the timings which indicates that parameter was not
   * loaded from the catalog
   */
  real initial_time = -5000; // must be smallest then all timing

  /** Minimum Clock high pulse width duration. */ 
  real tCH_ns;

  /** Minimum Clock Low pulse width duration. */ 
  real tCL_ns;

  /** Minimum Clock high pulse width duration. */ 
  real tPeriod_ns;

  /**
   * Minimum Duration in ns for which Slave Select must be deasserted in
   * between Two Instruction sequence 
   */
  real tCSH_ns[];

  /** CS# Low Active Setup time */ 
  real tCSLCKH_ns = initial_time;

  /** CS# High Non Active Hold time */ 
  real tCSHCKH_ns = initial_time;

  /** CS# Low Active Hold time */ 
  real tCKLCSH_ns = initial_time;

  /** CS# High Not Active Setup time */ 
  real tCKLCSL_ns = initial_time;

  /** Data in Setup time  */
  real tISU_ns = initial_time;

  /** Data in Hold time   */
  real tIH_ns = initial_time;

  /** Output Disable time */ 
  real tDIS_ns = initial_time;

  /** WP# Setup time */
  real tWPS_ns = initial_time;

  /** WP# Hold time */ 
  real tWPH_ns = initial_time;

  /** Output Disable time to drive MOSI/MISO ports to be tri-stated after this time */ 
  real output_disable_time_ns     = initial_time;

  /** Min Output Disable time to drive MOSI/MISO ports to be tri-stated after this time */ 
  real output_disable_time_min_ns = initial_time;

  /** Max Output Disable time to drive MOSI/MISO ports to be tri-stated after this time */ 
  real output_disable_time_max_ns = initial_time;

  /** DS output active time from CLK */
  real tCSLDSL_ns = initial_time;

  /** DS output inactive time from CLK */
  real tDSLCSH_ns = initial_time;

  /** CS High to DS tristate */
  real tCSHDST_ns = initial_time;

  /** DS tristate to CS low */
  real tDSTCSL_ns = initial_time;

  /** DQS to CLK delay */
  real tDSMPW_ns = initial_time;

  /** DM Setup time. */
  real tDS_ns = initial_time;

  /** DM Hold time. */
  real tDH_ns = initial_time;

  //----------------------------------------------------------------------------
  // Type Definitions
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------
  `ifndef SVT_SVDOC_CC
    /**
     * A helper class that can generate random values for non-integral properties
     * 
     * @verification_attr
     */
    svt_randomize_assistant rand_assist;
  `endif

  ///** Assign refernce of spi_mem_configuration object */
  extern virtual function void set_timing_cfg(svt_spi_mem_configuration cfg);

  /** Randomize all timing parameters in between declared range */
  extern virtual function void set_timing_params();

  /** Randomize tW timing parameter in between declared range*/
  extern virtual function void randomize_output_disable_time_ns();

  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Constraints
  //----------------------------------------------------------------------------

  /**
   * Valid ranges constraints insure that the configuration settings are supported
   * by the spi components.
   */
  constraint valid_ranges {
  }

  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_spi_flash_jesd251_xSPI_sdr_ac_configuration)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate 
   * argument values to the parent class.
   *
   * @param log VMM log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the configuration.
   */
  extern function new(string name = "svt_spi_flash_jesd251_xSPI_sdr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_jesd251_xSPI_sdr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_jesd251_xSPI_sdr_ac_configuration)
 
  //----------------------------------------------------------------------------
  /**
   * Method to turn static config param randomization on/off as a block.
   *
   * @param on_off Indicates whether rand_mode for static fields should be enabled (1)
   * or disabled (0).
   */
  extern virtual function int static_rand_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   *
   * @param on_off Indicates whether constraint_mode for reasonable constraints
   * should be enabled (1) or disabled (0).
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);
   
  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_jesd251_xSPI_sdr_ac_configuration.
   */
  extern virtual function vmm_data do_allocate();
`endif

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the static configuration members of the object. */
  extern virtual function void copy_static_data(`SVT_DATA_BASE_TYPE to);

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

  // ---------------------------------------------------------------------------
  /**
   * Hook called after the automated display routine finishes.  This is extended by
   * this class to print only protocol kind relevant fields
   */
`ifndef SVT_VMM_TECHNOLOGY
  extern function void do_print(`SVT_XVM(printer) printer);
`else  
  /**
   * User extendable hook which is called immediately after svt_shorthand_psdisplay().
   * This is extended by this class to print only protocol kind relevant fields
   */
  extern virtual function string svt_shorthand_psdisplay_hook(string prefix);
`endif

`ifdef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to, based on the requested compare kind.
   * Differences are placed in diff.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is svt_data::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);
`endif 

  //----------------------------------------------------------------------------
  /**
   * Does a basic validation of this configuration object.
   *
   * @param silent bit indicating whether failures should result in warning messages.
   * @param kind This int indicates the type of is_avalid check to attempt. 
   */ 
  extern virtual function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

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
 
  //----------------------------------------------------------------------------
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

  //----------------------------------------------------------------------------
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
  `vmm_typename(svt_spi_flash_jesd251_xSPI_sdr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_jesd251_xSPI_sdr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
n62GvN5+W3AOEyFSLaNGa0v64Dhev2inMQ2B9vIwz3/F0lGabqD444xSomaLdqAR
Lc7gYpAg4lkAELM+8roeAA9w/ZsmdYImZxi1XkHveSC0PMgH80AfbScQYBBgAa0E
goMC3hLDOY9F1kU9MFr0Z1kUTuEIDtsYzMK3f8q8/yc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 797       )
KIhddeqbEaoXSUyeyChFEMftPZruy81XwOME5v7fDMap2n4MvWAmhDS0XlN+o0Co
pCmPk7rF69xyVnO5Huf6eNhHe9d4y1TceGsTcAf6SJO21UJoi4bvojgFpQOElze6
xsc1YmyEJWe2cUM4PpI3DB3mGTeldzsplIZqfmgzFsWuvYNpRPZTX0zSEfDIuewv
qfgyeMYdGzaXNxuyYh87/q8159TlqcE+q1p/0fBXSeeO/HSb/0gbXuslCEYuXBhB
5LXEzB2gLsvhk58Blq2Q//M3RvrE6flixTwHh76/QvMc8OwlOkktODzAKgd7WAnO
n+snDvRLcuSQUPXpL2eqgwTI9bHyhakBV1geNgMSX8cB1nJO8apfcRKYM/Duc2ua
xTG9J1hEBTImpAOwlk6pOIlBoOhmhlV9d+90eNRTO0hImizaCXDVRWb74tG0dz9G
aabG6ACcBLXP10kfLlPLcDW3mN+pDd4Dlgw1wUNaoHzyNfw8de/Y+6U8rFq2N/Tm
OLwFYuE1oEvolTo3OvSyaVcQCp92GATKFk4eae7LDNxKoRmLTJ+y2wu11V3JPlbV
A0/U0eVM4rZ21pqr+H26pg0SblG9vCfTUgG9t6girHwIMjDuk6Wxml4ZG8dNhcXp
q9tZ8YFxdEP5G34gUx50ZnzYjizT8N696wjcyFJHk0MqBMW2+k1RmQc25bRJwlZa
3sriIVWe2wDLP7eS0DNEFRM29mGdLuWpNPFJ7xkCA2R1e8n3xBBCHPzvLgJor2Fc
QFXITGL2P8jdkPX+Zv2I6A5n9osid8heIcBh76R7WYX6tuqNb/yB7izkMZDRoDo7
djucRTryf0+hGuG5KOxNpwARiPKyBpRSK6Kolv4Y+y7g2BbVJMwAs7FaF4bfHyGw
BdX+8qhei8agDA44OkYFnnO760YZzB/TXfPlgLxFNVpFLWYZL2+MsHBOEXp81xvE
+rnHKR5NpNDpxOKXooMcGrhPfkc8EKzVNrtDKVMao/KGr+wAOuvV+U+SOeCrXBso
CkZMAexVkNZ41/fuZuWOoyZCu1Jw57RnSCd/p9sy2BY=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
l6ilorn4ydpwxqcpAgoW6jsanS6tAcjFGEGz+Wn6n1TYrnWjkkIlDywIM+0T9beo
EfkIKPU9AthVtibhcNE5Scb+BHusaK+y3LTqCmQbIbaDHLFKYewNQoO8j/RfWEyL
ovihWRd412qsrm/LZBuyAU0Y+5pB9m0AGXj2pPpHSkw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 23245     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_JESD251_XSPI_SDR_AC_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
AAhgAFsnLpj5p8gITcsD90Thtvt/K9c3jOrSC21Q3HJ19lCgQnTSEDJXRf8/2XRT
490f9sA151W8xBY4H0sdHeDpxlpmWx3JfrLH6nEVjACTA1y7ZnNZPNE4nLVhgRm+
ZRHVQhQym4CTu8sU7AnlxX+KcAKm1nu2ZQ1hRU77Kyg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 23328     )
v4/CgCjE+umZxkvfHouzCk0TxOgcho0kHsstWadd3FijYtMh1MUScrJzHDwCvLrI
NGH5ck1ADPmCz8bU6dCiJJuSQ1FESd3M7L/ZTf4pW1gEFdNrC+Z+ZQfT5mjwYXyp
`pragma protect end_protected
