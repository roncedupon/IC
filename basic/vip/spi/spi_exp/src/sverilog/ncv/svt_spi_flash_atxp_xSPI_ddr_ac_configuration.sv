
`ifndef GUARD_SVT_SPI_FLASH_ATXP_XSPI_DDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_ATXP_XSPI_DDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;
// =============================================================================
/**
 * This is the AC Characteristics Timing Check Class for xSPI Flash based 
 * Adesto ATXP device family in DDR mode.
 */
class svt_spi_flash_atxp_xSPI_ddr_ac_configuration extends svt_configuration;

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

  /**
   * Minimum Clock high pulse width duration.
   */ 
  real tCH_ns;

  /**
   * Minimum Clock Low pulse width duration.
   */ 
  real tCL_ns;

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command in Quad DTR Protocol
   */ 
  real tPeriod_Fast_Read_QUAD_DTR_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command in Octal DTR Protocol
   */ 
  real tPeriod_Fast_Read_OCTAL_DTR_ns[];

  /**
   * Minimum Clock High/Low pulse time for Burst Read with Wrap command in Quad DTR Protocol
   */ 
  real tPeriod_Burst_Read_QUAD_DTR_ns[];

  /**
   * Minimum Clock High/Low pulse time for Burst Read with Wrap command in OCTAL DTR Protocol
   */ 
  real tPeriod_Burst_Read_OCTAL_DTR_ns[];

  /**
   * Minimum Clock high pulse width duration.
   */ 
  real tPeriod_ns;

  /**
   * Minimum Duration in ns for which Slave Select must be deasserted in
   * between Two Instruction sequence 
   */
  real tCSH_ns[];

  /**
   * CS# Low Active Setup time
   */ 
  real tCSLS_ns[];

  /**
   * CS# High Non Active Hold time
   */ 
  real tCSHS_ns[];

  /**
   * CS# Low Active Hold time
   */ 
  real tCSLH_ns[];

  /**
   * CS# Hugh Not Active Setup time
   */ 
  real tCSh_ns[];

  /**
   * Data in Setup time
   */
  real tISU_ns = initial_time;

  /**
   * Data in Hold time
   */
  real tIH_ns = initial_time;

  /**
   * Output Disable time
   */ 
  real tDIS_ns = initial_time;

  /**
   * WP# Setup time
   */
  real tWPS_ns = initial_time;

  /**
   * WP# Hold time
   */ 
  real tWPH_ns = initial_time;

  /**
   * Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_ns     = initial_time;

  /**
   * Min Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_min_ns = initial_time;

  /**
   * Max Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_max_ns = initial_time;

  /** DS output active time from CLK */
  real tCSLDS_ns = initial_time;

  /** DS output inactive time from CLK */
  real tDSLCSH_ns = initial_time;

  /**
   * DQS to CLK delay
   */
  real tRPRE_ns = initial_time;

  /**
   * DQS to CLK delay
   */
  real tDSMPW_ns = initial_time;

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
  `svt_vmm_data_new(svt_spi_flash_atxp_xSPI_ddr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_atxp_xSPI_ddr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_atxp_xSPI_ddr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_atxp_xSPI_ddr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_atxp_xSPI_ddr_ac_configuration.
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
  `vmm_typename(svt_spi_flash_atxp_xSPI_ddr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_atxp_xSPI_ddr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Prl1auq5kJVPoibSAd94/pHI18h4nIWRf7hmivC63BuJTQV2VkGSRmDuXgIY5IQi
W8nuE+pBqzZs0WFHNLVUOsgboCoeWrP1Qp93/8CNeC2YGN0AkZF5y4UaKuxunjyx
cqupDwbV0K/EJFvAX/OirjXtCpaKAQ7OcAtnEhOGHdbGPrtE7K0IaA==
//pragma protect end_key_block
//pragma protect digest_block
A0hPigq6zGhWxFJCluKWs4YmRW0=
//pragma protect end_digest_block
//pragma protect data_block
vpmdTnnO6A9bYrWabetv/SpR8cUX3P4i32y7SoobqrjV49xUK0y0cNHVXosQyKAh
0daTsffnIS+/R0BkO8gu03HeYg6GFYDWnm5gYEC+bLNywAolVYfD2bbvZ4sw/RcK
UYRPRdLR0QDOQ1cHFB9aYTmqvMgdRr41BIpaAmkuCSpRwP7PLJa5zrpFMbFjGFbB
AGNW5+TfUGC/yKnVjys7YfPjJFEOOYE4lSwSzEfxbOs1f5Y251cRCeSzsszNGukp
2kWErrsyyBSj6hTt1ysCER5lIsjYrkl+0EIBDBbTaC33JaBUeeLjHBKv9e2U+lYI
C+tCTbfnBvYKdkfg0dTum/5tXAA/JxTP3J4+EmiGu475z9p7z78xn07GWo6dizOr
s+YICGUuqZw/qGt/GlDFPB180dEdXGSNzpTbI94L5dpGphkyScldfV2lRAeXr3PZ
ZvdrnESLOCi6CHjrIRPHwA+NxvAA//k/nxZq/UE3B9c1WfxFvJ11jBSQIfaRSEGb
Qszyqrn79InQeFTES444+cpLotwZyHYddFLbQDBqJ+bgwmFg3JP7Pe8rqsvCw2SD
LhBSjEeiLij3KWE7KVzKWdKjKk+UyMh2hxpbqY3MzULMnvW9UmKFfai3tQeb8hDV
G94sumJ0S50KayNjJoceVKRFx+Mw/8fwd986lUZAx/SpXYA+gwr8w9uBKJha0y1v
LeOfnDnA5Uhg+8VJjWH2PvJQoJlSID3lPk7m38nso58PS6P9wTkMWAYUTrW7uure
kAtSJjMXaEkSKW6vpu+GrE+ysXpqdxsQluw4wKwGxO2Mm/UcXueOpBNMkX3i/z3D
UVg0ZRwmMaXAs7J5phOp7aOsvN2OWuPEObnekTQofrzYO6YL9Ar2tsOuUQm0SfNI
lnuSk8lNN/7phjOXFv19OkWlKF8QRnwREJqu8BoTFq0xLUHQW5nTKa6x/9s2ueek
gTp2PwqXdgIUgAnJqJNhv6zoCc2XDlJgGrqvant7q3TQtzGXkVpk4BX04CCYJbet
CrGpDwdjgHKpwPU1XNuTjn16yM+Us5RLI9oaD9FzAF3www9f968gJIlqA9WHQm2j
hQ2Fp9NgFTM6DQSsqDIrlCMPTLhXNwQMI6JlHGG65WzkHVarnsXNL5q55pMXXa3G
WFQlplgYEGVeUjwfKrayFzfF7jI/dMOnr9emICRI+q6U47VUTZY5N1sHCrPdEc5L
M2TcAprhJb3UXcckJkcIjVYywVmLFHZVDobTFGYQKXWd4kIqgh0Sm6PI5RRdiN3O

//pragma protect end_data_block
//pragma protect digest_block
TWtWjyqgYY/3099v1b2OqL/7RL4=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
8tlOzVbetYpzKmx3zW7gABalfD1v2hrmL5eF0a8ayJMsnmQzKBAk//rG+VT0JTey
C4zNB5nExnA2/AV+tJX4wu+ywTD2LARVe64N7vwD62FoiDijUaF0qCl+D6qJLiij
xuAmcm9lj7Hrq6N7U05hGIV49Y90TUlo7HaGcCMUQgoKRRNiDncTgA==
//pragma protect end_key_block
//pragma protect digest_block
FEBbq3M2qW8NciUsEOTR596MIks=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
jhbG2Wnf1lP6TbmmvzpPw4f2uWY=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_ATXP_XSPI_DDR_AC_CONFIGURATION_SV
