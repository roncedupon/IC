
`ifndef GUARD_SVT_SPI_FLASH_MX25UM_MX25LM_SDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MX25UM_MX25LM_SDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Macronix MX25UM/MX25LM device family in SDR mode.
 */
class svt_spi_flash_mx25um_mx25lm_sdr_ac_configuration extends svt_configuration;

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
   * Minimum Clock high pulse width durtaion.
   */ 
  real tCH_ns[];

  /**
   * Minimum Clock Low pulse width durtaion.
   */ 
  real tCL_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command (SPI) command
   */ 
  real tCH_OCTAL_Read_ns[];

  /**
   * Minimum Duration in ns for which Slave Select must be deasserted in
   * between Two Instruction sequence 
   */ 
  real tSHSL_ns[];

  /**
   * Data in Setup time
   */
  real tDVCH_ns[];

  /**
   * Data in Hold time
   */
  real tCHDX_ns[];

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
   * Output Disable time
   */ 
  real tSHQZ_ns = initial_time;

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
  `svt_vmm_data_new(svt_spi_flash_mx25um_mx25lm_sdr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_mx25um_mx25lm_sdr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mx25um_mx25lm_sdr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mx25um_mx25lm_sdr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_mx25um_mx25lm_sdr_ac_configuration.
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
  `vmm_typename(svt_spi_flash_mx25um_mx25lm_sdr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mx25um_mx25lm_sdr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
5mqKq3tuWJ/7BvQHCxj4tibSMEOAldSWX7gGluQM+cTGIb+W/Pe8r1VBSysZchBV
lMKfFO92biUTc9kEjsBK+MXLk5pU7xf9nR2B8PMSywfoXh9h041LYXYTdKKCZHTx
JygVauE3+mhcArvr90HuY7OLu7xbZ4MTzxBoUo9QYbWtVJ5pADzthw==
//pragma protect end_key_block
//pragma protect digest_block
Z7jmWAVZqKEuSJMYOecCtIfuAj4=
//pragma protect end_digest_block
//pragma protect data_block
Ey5KrPeyyQgVc37dXCGKhnysH8Xb+jqTicw2Jj0BbrfBzF1yusTfUq8bUWTug1oN
vHfYHg89Q4FU94YYUbGhZXw4hp7dO4HsYJGOLmymMS2//dpeX81O7N/TwwderOYI
EvcPrT/mx2Y9zpfanjYEO7zAhE8bDh7BEV1HCY2DExBCIDJa8+dKw72bCMwP6L45
O46ghrvaJnCkJWd54GboULj9s0JGvyJh1gQzHnrA8O7T7jWIppAwJiNrO8dTb3X2
ybZJQ01Ak+RXViBZicKzxdFCw+97gXkWvpYXwbi5//Zy2+pzX3UfDMvH9dWmlFe4
C9pD7VvVyO5orUqZk2XvfnemlRjIT0TlHYhrbMCB+rJ6RwhqjzY0JqpjCBBaIT97
xkZez9pdjJV8ZtxzyvYmopOBqWutDH2OBylQL1PHXV4B3TUoHbqcaXIno4Lv/6SD
vY74xgHINzgn5iqsYdrFNZSQ5wqn4C9M8YuRy35N1xHc1sc+L8ujxTCbbSTT26mU
Yfdy1R+Y6FbnMb4dCaGSFCkcqIXhoHDuUNvVGc44stleJha7vXyBeTLyw8n2hWeU
dqMC3nHJsbi2wXWYYWy8H8bE9B5JPVhR06Q4KiSXdUTKzdFZHUbZGuj4B6a2l3S6
Q7UVW8080rlyw9pA/rLCIRLvgKjSZuhHx1Pa1ysIEECMDOgiktkAMcetxjZxaf2k
616q3uh3eeVXq/zUbknYu6uBkPGxSF4jTwJJw3WVN+3zOekwzRMfOo3H6fkQo8Ro
fh2QDymr1KczGIkyJsBjSdnSXZxwq8uHLsA2640wAMvD5FXZkavLYdGUENNQziiq
bsSQNHvPBynwwm5YERaLT0aTDlTeWkRI5tG/D1c6UIyvOmwnsvWEcypkEKVCfh+i
nMTuTju1MIrDE6JpdL9cJbci5Cf5jdoCIH9S/lrPfacV+ZcbD9iSkUTQTf1eukLM
UHPu5IhOVvQ74/gjYSdfDC/goDMQT5wTK/WWiUBBHDuuDQF6EgXO3DLHn9XJmEDV
3WBAlKUQ3dUfF3GpM7RjrgArek13YGfjocGaFgkq0lrW7o+W5iK7I0bHsb0z+U6p
9W2kV8xAYaFq+eSQbsClcVC4I28Pf2JiapdemDpN/1n23PJNrFVCe5XAIi8B3I37
xdt8BqZcOGMV/8HBKdaXzCQByEE5WJD9zFxAw9rgJQtXS36cNBWiWdvrBLLf9pxV
haqj1V+rZMA893OKcVuGEtbZzwbgDWhcCUAdII2XMIrxvdhSQiO955GnLfYr0tNG
DZ7Pyr0Xrqg5V3DgfuRVjg==
//pragma protect end_data_block
//pragma protect digest_block
qgj39NmYokeolpbhA+2WojfFc0M=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
K/IPmiv2yu9KzfRqrdDaO6n9z2h+4IBEivcGeLdC3fUc1VuwRXe9MeJyS5UlQPjb
fwsnJQtuVrPre3bOenf6EHdP99hjr+xmyA7ZxZ7oOSBOIPCWNMIYakxheEQ9aN1p
KYeKI7bqhbSCmhB5lpbqRrNu7I1u6YLoRXo/C8Gy2ocf1RCCt2q9AQ==
//pragma protect end_key_block
//pragma protect digest_block
NykVz4OkIM3f3q41LFCtBTLPMY8=
//pragma protect end_digest_block
//pragma protect data_block
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
2VvEGgr7t5bcp4g16pkrLQ==
//pragma protect end_data_block
//pragma protect digest_block
nrAxMZ6AtOZoDWSQnr+voA4RS+k=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_MX25UM_MX25LM_SDR_AC_CONFIGURATION_SV
