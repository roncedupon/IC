
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
0hsIeJeN7sI5r3wecQrkngy+hSqGqm6BUpi0LU7pyXrR1V0gWvSkClarTyohplBM
HsCvBInpKgGoJ+EP86/fuUzvjjp6VYohoY59wBHImw07V63ACUO5t4QIK7xUJ7dy
DpBPx3rxmw4Dwr6PN5kt0pEfbi0o0FLR95PxBF2K3f8b2eppTNS59Q==
//pragma protect end_key_block
//pragma protect digest_block
SR5tuDNuv93e+qKG9TlnA1zfF5E=
//pragma protect end_digest_block
//pragma protect data_block
iXMJyvWjzin1Bpv/Rsr7RfiKPs+EGP3Gz9MJhmSzAvS0TUZ7wrMEV1Y0Ow2mnq7F
lbUq/eEpYWg6WDyGnu3LgLNcYpOSdYnKR2IM5AmHDwKMb2XqYKqUMIYALDGRTIGF
GiBOP0VJIr/bRsM9JWjY41ZtS2i4hhSxlVN9FFVZXNbPEvCP8PqNLxBiiZbQJqJ+
RaPCP2b4MwvkqXcf2TzJpGPG6oBjo884UMrHwDe2yjSvhz13cL5QoJssC+XzizrB
FRx4WIdf40IdFYIGh3VSpL1bzhFjzayRSR6HkcLOtasbdZKTdP2rmFrPc2O8097w
3yfu3BOwLwPIop3zvNoTEyfPsgSAnHpJR54jHfzki5E76ZcEduIhV2HTNnHH89fx
/OIau28vwxfnIL5+kHWhQptgDnWpvm2gUY75E9j/qLNXdCAZoZRSksKPdnuVJd5f
7Jy3kvNUolkmxHDaMm6btHDz9BUzRhJ+Zo6wTk3lIWl9pnhkVVVwosgZCV8ygeKQ
LYrYZ0ctpWA9vm7rmrfAzYsLGYm6cZ4qcDc7wgMJ96RKQtL24DmCR0J9KznuBOxs
lKTWw1dqOvovymxOyt39+jYkkZ6RgllqoGCsdBmXuy6W/L/b2KAOdQlfUl7DLbr0
7xKw/JgEobXJQGCjEcv+CRmYXzQE6ub2/6qnp2lN3OrbDaJSEGKQz+CCHh0T1xo0
89rZZqeRNV7MhlcL1xsbXClXeZp20ighDVXqRO2C1HCuoR29t098HitnAf76H+Wn
d3cenSOj6JzfG1W0Ka1KLAdHQsqbRV+jR2roBEwXpbPfKFQXo4d9q9VmDfD8foVg
UOIaR784J58pljaZuBLjYyg0qJOHdiI4qCHXthyJnBcMJFxrPm+hf16N1Nz7VOQV
vf23QQIMJycHZOZLS/dIpqlX8BjNVmgzJ8AFb2V3Q31MOoQhK7vNLveGhaiJalmA
LhhmTNX51twjm5JK1qJ0kJAebRNYsSCr0+PjdrHeAl9tuW8Erll84HQoPUFsWvpw
KP6aW1EylgFrTH8IvAaA9l8dgeU6u5OiBMqbPacF2qlHSEKPPzJS+g3nn0f1ceOT
hEVsA0YvG+OIzGfC6Yd6PQO2jh75aHijIcsn9KdD2gvue0Irei5Lqy159EkJ0gbr
X6bU/ZlTNcRzTJ1gQ/gQ7wIDHsudTvnUxPwj0F4QVGS4zVURWuj3YwqZVFcmVCDK
hlHp5s+uGzPRCWBY87CUu375LxzMehPNLOqUGm6NF80=
//pragma protect end_data_block
//pragma protect digest_block
Lb5Jq4NIOR56b131W+Ps+v2u93Q=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
OuuO5fBPWFulnNOzwKGtsjHM/Lx/bXs0z9X3gfTpne7r95Cj4dkhYz3lYbCA0yKr
fXv5XnWnlRf1LqAhkhXBSSXkz5XN7sdH/zscX5T9CmYBU0JqDEpJiqqkV9MUwGNE
hYE7CAXH56N5sREUvGpzxmUBizv5tV7Isaivb/gD+vdqw8d8LkpEtg==
//pragma protect end_key_block
//pragma protect digest_block
7BBRKeJJm70yxRQEIcLo5HDQVw4=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
y717kJk5o5S4RotB2DVTGPtJ2D4=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_MT25Q_SDR_AC_CONFIGURATION_SV
