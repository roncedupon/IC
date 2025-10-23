
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
/+decwiXA8/g0lrDxi3jrQyC0wZTwpkLCCAeXM8I2ie/cyF3OMfZOM7L9YIHjcYI
Yq7/QvkU4LZdWHcd+evgGLmpeZNjaLgLOj0DCtmNiac8gWO4Bdtx39TuuZJ5Ctjb
WEUp0/vIx4OzjWSY4aca7SSihd+CCSRTTFazHAJTEmMRpZd99wggyA==
//pragma protect end_key_block
//pragma protect digest_block
xW7ljQVo8qK0OS0pRNBnPRaO9uQ=
//pragma protect end_digest_block
//pragma protect data_block
dXCZD84XotG0LSkDftO0RtAbtdf3WtGxnHdgqTuEYf6vFoun7DRbHkdIGZRt85Zb
fBYQiCEEkuQQJ19OlD9LmC9c1v6ptepGyq1l7V9q2vt8fbQDXLhSv00z7yWTHa3p
A3VP70h408NO/su1qdwjXJtNdTB2DWwmmzcUsgj/L7Iqq9WWdBuNL8DBzE4DPFB9
/mXO7Ul/2LdssuyuAQiretxykX53YewuEqI2uwifb0N0omriHcy9pESWKgANJ/22
NcfzeRQL8n0uRDOE0qKFRD9l5IBV8PAvINo9uJfd5UeZud9Mg9RuXV56WHnLJFvo
w68pwzf+4k/U8/VdHZ1fSURlHXqz7nHrKOKaRGbc0gfWsxFYhf6stFDY1lcuRONE
LNR85bG2i48NpKmoM5bBxZMS2S4U+ZcOrJxAYrjUwuiQJyB8iwig2KRc0De0jnk6
KZfo6QaAIiKJF9LX/6euXDPCVZ7z5+ImIqykiYY80+mU9RaGFJugsDCBjnyT34q/
wSmEmTIhWEj6Uzzf8jyicYaHiDFn620GvGd5zJUYT1WyrYAIoFIwDgbh14nKKEw8
k1g5DwS+IJK5tFdwHmjoBwXaLHcm8HWcJWL+3pMFWZSsRsC0vix8lI0IHheZ3oMN
PMxMxe/lF3Drfl73HRSnTJYDbF5uO5zSPvIOsXuzUu1sER8ji5SosW5JxXWwpYrx
WPxPCndiBII/X/P3NYyVsmH9OAu5ksJjIgmA2RwCiM9GjgWIQ1/7pW6FvpFQsoh3
/bnMWEI07/gGLV7SU45g0EZjv6vhgbLuKB+1o0GmMC92/BNMRr31OQwdInW2Cj3v
0EMTFSwqCTVf1/SmPcHky9fNzt8DeDUAZamY1DPx2wFehs2uNjM1N5Gzlab0KF1u
GOrxxjQMATkfQ4neI9CUwlBMuMSCmNARX8uIC/Bwy2GcG49uOCSGH+KDMwU5jg0d
sq66VvfwBEGbDoG3tpcARRXJ3vjKY5oSOPJVKXaZQkELRnk9wStAGei7aBpWdt8K
Ck67Nxhre5SoYlXzS58GyO51SaHo495IcqlBU6odn1l6sgkABcFjyP31yS/ZgI7C
KdH9fVf5pb2Q19n5mKMeOsauPnGu+M9iD7pOxiX558LfESIuzFR82pWmWUn41Ypn
AdsZhTRWXxV8qw6rGAovYaC+ncRwlSRGC0LXobHa1g8ytIgRzufTI8G7nLT8CG5t
kcvdzzeOaRKQaMQSCQuIxxHFU7KfO4PYvsIxxIcoxcgWt9EDC4Tpx0xeFanukF85
0GFeG/WL+4aLyD87sB2e9w==
//pragma protect end_data_block
//pragma protect digest_block
SDHa8GItbF8e8bDX6RXw5X++Q70=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
jlsrSTlS5SnqJLhvO3xkE2WmfJvyC62NSDppZkZkVFYQ8LwA1EWJyO0y8st2i5kv
+k09iNWsTJ6VLyyzSO0RJEcKpUb6PRdjE7ZPwK8pQhOb2ekHCkumlTGLHMgTj2VR
dZeZZgozIXcOH9r4oLsYv6VhLDd4/L2vFrf6bvqBgSFTGA3EJOlXOw==
//pragma protect end_key_block
//pragma protect digest_block
WIW2RLHyaU2tPKHPF9XS2sXTx7s=
//pragma protect end_digest_block
//pragma protect data_block
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
lFks7iFsfBxk4iOzBxDzrg==
//pragma protect end_data_block
//pragma protect digest_block
J3+nmpgxd5Jl3s3pAmnl0wB0eN4=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_JESD251_XSPI_SDR_AC_CONFIGURATION_SV
