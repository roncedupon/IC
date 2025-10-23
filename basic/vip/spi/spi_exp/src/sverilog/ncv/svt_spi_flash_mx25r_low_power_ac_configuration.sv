
`ifndef GUARD_SVT_SPI_FLASH_MX25R_LOW_POWER_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MX25R_LOW_POWER_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Macronix MX25R device family in Low Power mode.
 */
class svt_spi_flash_mx25r_low_power_ac_configuration extends svt_configuration;

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
   * Minimum Clock High pulse width duration.
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
  `svt_vmm_data_new(svt_spi_flash_mx25r_low_power_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_mx25r_low_power_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mx25r_low_power_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mx25r_low_power_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_mx25r_low_power_ac_configuration.
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
  `vmm_typename(svt_spi_flash_mx25r_low_power_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mx25r_low_power_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
HAVndN6gclfnNUZwqmScOIHM4ahMoqNSGFeiO5e1lcRcSqBi0uB7InQFVNm3bVa5
a5acF8rvH47SadyPZXA6cVe6CgaZH1IWiGXacilabAAreTiLaVrE46AYYh63UWeJ
cCia+A+KvxedOBLUc6sIDyX9wRswHIi5BKqEplIJSJpF+oYCiQOYLw==
//pragma protect end_key_block
//pragma protect digest_block
ya2XYfpMNANsMCFlsSEbUe2BPkc=
//pragma protect end_digest_block
//pragma protect data_block
R6Nzle4ahJP24vxDVUJVDfK9SLN+XHP11MFE1uMpxx5GbV4s354hMVSCbKyeEjVG
hYM8A2b2ciDcLRWeRGPdKNa9RLvex9WAF8hWXSsrwetDtsiNUhNsd9kL+fVuR2RB
GG5bOxzLTKfF5LYiQK8Zsc0dJBg1iGmXXMZo+D3Vud808vYOad7YBLlQbA018YTU
htv+J3KHYSOGjIHcHVucfNQdkiohtiybJo3bxnm0oKel01BHWUuBkRjA2TI3asLG
ez1t7Ww7OdiEFlCgoVGAvs8oTgaRYvPaX1TlZyFYhWJINkC71yW2w8WjndKQrOiM
hUPma5pVLWTtP7clBaHgFA7cIsz9iqDxxhnS4JzVNADJVuPrMxqmz3IPafA3+Rik
tMuTM2UKYbqYKs9rm6VuCzTk4nnw8T/spig2ZWwt1YCKG/xnSNtTJJ33iRHWZ9WV
6HCOhDG3/dtsqb0jz9cUAkjHQxFz3l7/eugBfLywj/fgJexcrC96S3uT3HR2x0Dp
Te0ohv8NtwG0cUJvVOomC7Fdz4DxalTCHMk0ibznvZo9ENSVBa7X0uz7iZju8uL6
FkznHMkMa/bzVXppUC5+F8+pwxbJ/pwPLMBeBOo8IbgtzweQV/qZx3/KyQ5JYOfh
QRYokclJ3Xui2dTUpwKZ30u9MjxUOw9AjyhT1GI6eVoEQB3FRqCxPsYUaWuZeWbr
Eg7ErL3Yfp9BGptqyBBzV8EROyjkZBgbWreIp4jYQ2Zd6W8/FYdiSX8yQD49uZ5S
p65PrzKdLQqIYw9TNnP6koq3BoW4pzkFd29s47IWuIyTuSuhz0w8vA+ojdyJ2RIP
q5aAkgvCedioB9HN/9CYRjPM5wSzHABmrlyZuBwqPu5OhtA/Zpk1VzGgR1TPYtmk
iDDsj3ifFnAvSsNruRRm5/rsZx+qQx5s49gepuHoC8IlHLnQO4JNnRlHwB8QMoq7
IJBxJZRf9EO8aFeuhODswZn2LnYkIuMLd528PMFrxEce3s4Qu/M38bukQWkmsGOT
f77Eu4xaqN5TZ65bcf7vIWsjhXD2M39eZjoHr8gtzp/Iis78n3uXPaWVxDDCb1QX
im139xT+J5CnB2yL56pTCyXXILvAhNR8UgzXqsXLlwSHuGcY4HpN7xWQZD4nQKzM
uR99wujY+vCrAyjU4k5R56Y5FjLB54EnIB8eYF1JGHBPGhjROjIjVRE2xgZV5Hc9
ajCJnGXfX6b1tBlarNp9sWfzP0YwDnWejpQkQdZ/s30gkYpYWB5aGesfGTOzNyG8

//pragma protect end_data_block
//pragma protect digest_block
BQkQGzWLKnldu05IIYWoU3TQa3U=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
BybQYsmr8KlN5nUIQNglpxDZB1w8sCduuJUneG/4OFv5HUcIAyUbwx/Ha/LWTHrj
/CxN8ZMqYJq9HTESVanG31yPHBE/RsMnMuHsy08RTsEynNJb5+/SwBaEPI5AnU/2
//y9C5UGRQbgeu4FhiHHA7YoVvEyvYqzQlTPSY1LpW6UMriqhmQm3g==
//pragma protect end_key_block
//pragma protect digest_block
UL7mMIdhlTbMDAmADJs3aIaM0Nc=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
dx6dIGdzpwQtjDhIZGHTzoo5f0Y=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_MX25R_LOW_POWER_AC_CONFIGURATION_SV
