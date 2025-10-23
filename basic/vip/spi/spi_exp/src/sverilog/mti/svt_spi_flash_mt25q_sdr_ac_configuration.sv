
`ifndef GUARD_SVT_SPI_FLASH_MT25Q_SDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MT25Q_SDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Micron MT25Q device family in SDR mode.
 */
class svt_spi_flash_mt25q_sdr_ac_configuration extends svt_configuration;

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
  real tCH_ns[];

  /**
   * Minimum Clock Low pulse width duration.
   */ 
  real tCL_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command (SPI) command
   */ 
  real tCH_Fast_Read_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Octal Output command 
   */ 
  real tCH_Fast_Read_DUAL_OUTPUT_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Octal IO command 
   */ 
  real tCH_Fast_Read_DUAL_IO_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command (SPI) command
   */ 
  real tCH_Fast_Read_QUAD_OUTPUT_ns[];

  /**
   * Minimum Clock High/Low pulse time for 4 byte Fast READ Octal Output command 
   */ 
  real tCH_Fast_Read_QUAD_IO_ns[];

  /**
   * Minimum Duration in ns for which Slave Select must be deasserted in
   * between Two Instruction sequence 
   */ 
  real tSHSL_ns[];

  /**
   * CS# Active Setup time
   */ 
  real tSLCH_ns = initial_time;

  /**
   * CS# Not Active Hold time
   */ 
  real tCHSL_ns = initial_time;

  /**
   * CS# Active Hold time
   */ 
  real tCHSH_ns = initial_time;

  /**
   * CS# Not Active Setup time
   */ 
  real tSHCH_ns = initial_time;

  /**
   * Data in Setup time
   */
  real tDVCH_ns = initial_time;

  /**
   * Data in Hold time
   */
  real tCHDX_ns = initial_time;

  /**
   * Output Disable time
   */ 
  real tSHQZ_ns = initial_time;

  /**
   * WP# Setup time
   */
  real tWHSL_ns = initial_time;

  /**
   * WP# Hold time
   */ 
  real tSHWL_ns = initial_time;

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

  /**
   * HOLD Active Setup time
   */
  real tHLCH_ns = initial_time;

  /**
   * HOLD Active Hold time
   */
  real tCHHH_ns = initial_time;

  /**
   * HOLD Non Active Setup time
   */
  real tHHCH_ns = initial_time;

  /**
   * HOLD Non Active Hold time
   */
  real tCHHL_ns = initial_time;

  /**
   * Minimum delay between Hold assert to Output Invalid
   */ 
  real hold_assert_to_output_invalid_min_ns = initial_time;

  /**
   * Maximum delay between Hold assert to Output Invalid
   */ 
  real hold_assert_to_output_invalid_max_ns = initial_time;

  /**
   * Delay between Hold assert to Output Invalid
   */ 
  real hold_assert_to_output_invalid_ns = initial_time;

  /**
   * Minimum delay between Hold de-assert to Output Valid
   */ 
  real hold_deassert_to_output_valid_min_ns = initial_time;

  /**
   * Maximum delay between Hold de-assert to Output Valid
   */ 
  real hold_deassert_to_output_valid_max_ns = initial_time;
  
  /**
   * Delay between Hold de-assert to Output Valid
   */ 
  real hold_deassert_to_output_valid_ns = initial_time;

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
  `svt_vmm_data_new(svt_spi_flash_mt25q_sdr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_mt25q_sdr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mt25q_sdr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mt25q_sdr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_mt25q_sdr_ac_configuration.
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
//  extern virtual function int get_clk_parameter_index(svt_spi_types::flash_command_enum flash_command);
  

  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_flash_mt25q_sdr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mt25q_sdr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Za2Er1j760F/WWz0o1cPETvBnv7ZXqfJ/aG9ezCgSdGd3BPGOprB6R01iithxekN
TCgbWzOiYc2s6Q7lGW6kJjmPGqWcSZVGnyaiM+I/XWvXrCH/hR0QGXBaphnaWml9
SslZyg/vq3mLpO2xbGlbQiChiKdNxtGtZLa8Mtk7/VM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 769       )
tJRYGyp+40QH4sz2mSC5rH1RkTEVlxw7zbOnnZ0epAhR/QPpZvdjAoLJISBlqO7z
bjRHnRWSkxwHih9EjPRfvwjKdqak1mzTLvgjZtQiVpPsduUJ/GIXQGfR2NEvu6T4
I7x0iITFCu9y2hV51tmzJhG5aGzDEhXisZBXi9Tz48tSI9nm1IFj+a5oTqlmDFTj
hPgJ1SZ9f9dt2aaOzFspeOwxIW05hm4pgDTN27q1zoc5Mt+//eo4FxBpn/wwmy8T
3uH/Ju8o930UAiJ9/tIBdKKuYWQEbNUT0tSQfD7yWwGrwujYiOB0w/qDsZlJm9Ls
htvGPJuaI6h+xCrQ2Y0lTw4uW5wyLCfxqYf1yLAWPQA9/j0jnozbpak7d6wh25ye
FslSdyXgw6A8xG/hZXROOSkm6dL/spm+fGuQgpZdmi+FYORjH07u8aLM50pf0/bc
j1bZyyJTVys2kG7FhqeiG+0YpcjNj3NhzRJrw9ow0bO3Dpxzeo/adoLh6En84SmW
CMvPHeTVG66d65itN32deps8+OSEut+8C/jBYcCfVQbjWu+VrIo6T6uGhUyUoP5u
2Xm1lbo4n+dzYUbicbet1WaAUTBsnpWg97/phrgtGuA/ukn1B+Km1YpaiqSvcyKC
j1x7v88W7pmWJBFD5AeNy1lt0Sd++60KYXo4Do2A9JRktN0YY7O7orFTwqqE0OqJ
XP8HgiR18ZK82IseEr4/WG4wE6LENIOKJ4pdVxY0wfxzIiv5VUVEmdVJvWXdIuxg
7yiol6SOuUdzgI4tm4AR6T5kfGE3SWekrOzRhAWv6mJidvRF2v4U1Ym0QBZgd216
q+Dhv81q3A4jHF65wpD5qQ0UsJxrimWd5ItVa25IpOUwAD03hhohpkwThsjiuXgh
rCd70SMyo65trust4kq1lyqXayRZ4HF/nwHlXQgGkHfRIjvoc2uyceeQQ3OnqxrK
OqZxidrYRPEIbr9thB5iqax8t6N1K7B5zHaSlNofrwCVlijg7L1wCQT6Z0zFciTf
MQel+RKlYI7yJ/rKoRp8yQ==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
kO3ANz4m2asSLyi3vLRZQFIJ+kFrevCUB9BEXdYQipgINMT3H6d9mst7Q3G+aktb
VOEeVlT+Q507KXXWp8eSAT2SSEAEMOBzXKOmSvVCF7bC5QLyt6w/gqQv5hWu1sKN
84XlYHAjjD1f+do5fvCDmhIgbZKWVY3t9EtuaPFQ3o4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 30058     )
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
qbDmTOnwqz5ZaGAZYPs6Rw==
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_MT25Q_SDR_AC_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
SLQcaTUrorQJH2Yq7xQF6jPDujFzjJfiX9UUEKhXLcUw7p4LdUrHjI2wfQ699jyf
qpdR7mCG7EiIi5GE9GFk0x6GfqCG026yyBz2WjEpaxR4Z2Xn9rsBM+BdxoDLlUPI
8cru+Oew2cTWc72JIUDhjuwKc5M2QHC2KNNZ6y3bhUY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 30141     )
A20dw72ex7VzuWmwudAMEpBchRKkbJJUbf+zWxY8jrUDX7Vdc9KBV3ToN6Nptt3j
PQ+xM82BPlyVZFy7izw5E+LttU7Q0Aa9SnzRGnQ6crdZVYLSP80Hmi8XGJxgL2lB
`pragma protect end_protected
