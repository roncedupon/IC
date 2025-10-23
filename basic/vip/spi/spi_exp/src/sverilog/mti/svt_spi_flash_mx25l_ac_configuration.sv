
`ifndef GUARD_SVT_SPI_FLASH_MX25L_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MX25L_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Macronix MX25L device family in Serial mode.
 */
class svt_spi_flash_mx25l_ac_configuration extends svt_configuration;

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

  /** Calculates Random Timing Parameter value for #hold_assert_to_output_invalid_ns */
  extern virtual function void randomize_hold_assert_to_output_invalid_ns();

  /** Calculates Random Timing Parameter value for #hold_deassert_to_output_valid_ns */
  extern virtual function void randomize_hold_deassert_to_output_valid_ns();

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
  `svt_vmm_data_new(svt_spi_flash_mx25l_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_mx25l_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mx25l_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mx25l_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_mx25l_ac_configuration.
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
  `vmm_typename(svt_spi_flash_mx25l_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mx25l_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
nTPVWeQoMKYIR7P3VByoTUCKhStY/s8Jb7AlhrktL3S0h5suK0JatQyzeyXzkYAr
NtK9pUBGN2Zg8otLHCihO0Q9GrbFbypHc2q9NdO65gnBjBpgJaswnr2XsJMJiz2Q
iDueC1hjLfcLdv6V+mUcZTdq+rv9BtHQE9LySC/kkqI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 753       )
cDjg+898SGtszBQlszZs9VpyO1ZJSTyrBrDU7nKgP8CHWHlSz0fnNJUcSrHnPpop
yWKt0Ro7KpAd19ElV0L46C4A0KFwmRGh4Z7F7ac4h+7DaMwkTsPKkYwvzjqhFhAx
d3WXGMU85w3XBrqpriDeot808RmXYs3XYuNl+VBXtvIf2d4+1/eSsmxKWC3AZdOR
Wrz41SG+NqK6WfTFti6w8kINX5oRz4pfETFPau9cqym7pSL+JHwC3qH/9xAYrZq1
+q7D2dKzV0W410TpDwJfGp5pG0Y5X81K5XLjPPEvw6fpddVvJlGFT2dM4iuQab5G
Zl7xmCTOZdRLXm2Re6ftohxbJcSgrNUFCNPOcW384hBCHmXksoFD+mOUREC+f5Xy
WGkv1c20AznF1Gh2x7sqMcBIBNH+uKa4HfyaHexjvUmiskxKDMA8aS8/R5I4z8EW
+j1exPWsb6euUVR01ahImcKUksAFCqlYlToH8/lxuyDfKoIS7KXR9IEKcinWbr/0
BHtYlqUfUBqfmkwhYBv/ZrI5BEZqX4/AD/b2UJJj07dsAahSEJC7UnufEuhnF+QA
zYdAh3BvQaJzk+fCcLXxSZEiPfVW7qHgaX6mE6p4v1IFyJCJoKHrB5UVInqv3grb
JBBia3M9S8N2on9V/Y+eo9TzigGJAHTFZHOe5eknYhrH8WtiASQDGa05yuwbeBDv
1NEceFTD0wjzOhuEFyNrMuyNSOaQXcJC5U1CyFcWeRV6zjJgM/lZ4xaCkU7mcLqZ
keepU+luk7ozcH6hhxtQtIH4qdJAfsDUhtr7kMP47LHHFNxSXLDRp5O883uS5rF4
rQe6c1eYEHwSOhwoI6/wa/WPwJhbd30Dl9LFzUyfiY02TEtTdm8rIZcZqUS3QOxl
hcwezlw1tt8q8Nj4LdDtD07TVQhKVZOrI2vIl6PE7w4yfZLWeYoF1rceI222WJjR
NJLESu9BZkR7lvBVTf4Lwe0daIoYgIWcN5gYGLtm8HvO1sJSSxEM+GODNXXRFVpG
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Oy2XpuHc+dKQ4/k/QIp+wB/i4zcrAmkqQBbptWAckwEQSJAxsykpUNBbgqrujLug
wYbYkPr653XqYs3Ixb7BbYAwSxi3kpSTGkNxcb7V1h2ZINaTq0zBcmIMRBt9wQzh
/6UHscWpFxAyXv64Gyb9hLI6BrMC0yk3ZvV47EL5vOs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 26250     )
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
cRZ3OpuTPlX+0iskCnBaOg==
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_MX25L_AC_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
VcWzqrKVHFgnXaS5RVPhYMoNryjOnrlE6+Tvovh41qqaugv3zc8pu8mCQ0YvdMWp
5l1OgfY9qdUfAziOVIfnJF0QlpRSvywU2njWfenpZ0lPpoRcSy2y/j0LvxcjkR4x
dRsjoEPPSVfkZsmsunQoQCYOJmIXDHS91+Kw5mQR9Is=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 26333     )
XLV3XU6erogSdkmoAjDNBLpMLgO18cVUib8H+sZ7NBRwYHaFp7e5MWAfYHxrndur
YusR2772KUwS0eGKQC1zrQkSLa3kGoG8R4WHRGChZ/fiON1oDlIg1S+izfEKeUhk
`pragma protect end_protected
