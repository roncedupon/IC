
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
WIqBWBm2DgDZUMkiYP+kzDZWpx+9oCOpvJJu6vuc4zfRCq3EVhPXrTplqPDvClBz
6X5ckPELEWo6T/s8GVs6hUguDLcfnrleVjj4t3yPGiHcX4hevPeGn9cw7MoEeB5k
siHIVsuVN9jHmoJ/DNTzTVtOgDRsRjAedKWagYpjJeA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 793       )
5ddj6rph1ogYOx0vXIuGNZ7l0kTcwk0y3QzD4KioziFMbWeCLTkR/DmYmAd72KWN
1WWE/rumhVHknhlOHZk5y6inEfKzxGlUb8QQqNO7MMsHU6PBK2YHz6UqlnMAV5vd
Qm7JcHFYRWnU/vzfct91oJP62tt9KbZHZhNVtukux1A/WsDkEkv8gGN3rBBbAWOR
ljeQXbxBAl2aL7ty5LxjVWcMKYP+a7mXakcNOsTgzDuYA/A2iT/MAa8MJ5f7DgcK
65svzdBTUT5f1UrrDCN03dh2WKddTijDlVEeBVSkjzvVyLqTrHKAprUZDUai8fgF
MXRhyJPlWk2eA/iImzCtD9LwWVEI0MNpV7XRTaZTvfEAM8GPQKxW5rzmm/XudTNP
2vCWqYqFA6HJRDq3jMx4WbwktoQAhkQJwBUSJME9ilTC7B9uuKEu29VVHcyEBzky
gEIooYIVXFq1V7os4bii0tJN66QzWLKTPQ/kJjLzJKnXe1nYq7GFsoPyvMCjTSmV
GzWvqsdhwJRRA8udd318G3s2Mi4f/MsniBXrXRDmT5DeBCSp2F/0nyF1peneZmqw
jEuvCMMHtdo8yu2NMK8kMZA5jBhPmQnAkkkXw3xsxhWi0K9ZkurL4yFEhFyya/DN
lWSIMuraWz2fRTPfJOxRpRmcD++1xsywOKw8zpHAam+nY86f1/KIhWGc8muqdq+2
Acvbi6lwIv8iYnhY91mAPDpJQlgd2CoULDdup7Wow5lDW6GtPT6tpUdMBC/Ffsmb
0dyZRSrcpr8IpfrghBdp5YIcn2MQPM01JJKhxOzuH+rJE+4pFOMNmg1PicTkiG5w
2+SYzi+XJxpR+aPCT6dprLjD6SQGVoLtL57STuYMHK3OvcPVaIFiFqkJcYnadWM4
gFWg3YULbh3B71UgOWXgDkaWYcQD4YGCGK9D9EOYc9lBuHpDeI4YDvpPfzIBDpsq
JGJqFQi/M2q3FEeprl++la4VVhzxQ/M09T9ukXzwa2B2vNUaDyQDuNLsEYBZTl/8
sz/vrmpoV7UZ+S+73KGn1ZcjcbJpqk3pGQwoO1cvxT0=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
M2WRfV4EPWOIRur1CwSnb++E8zZQZ7OxKA5/iiEDlh709iPcN8ekTuhDluazsNCT
c//xeHGGmX4edb0XriJQhyHplBDKvzhJUG/2zvSofvoZxFXiy8pSUKkTAaOggIOf
QQnFikrgqpN+BeWPASmN69FACx88nhR8mgP9e5vKlCo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 20640     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_MX25R_LOW_POWER_AC_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Qv4RUucqCM/6qub93bz5EdWk1WvkI6842xiRpOXOpthewW+NrZT7DJbkrlSVCzXY
ppwZ3c4nXv8tXHZrwtrk17KByW/2ALEMUpoQuXl4MGpj6FQeHzC+FXEJyH040trz
EMWkfTf7qSr0FYfKP8gpVrAc4byUbh6Z1AfoQ5I3KvA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 20723     )
ZdTTlw6x44YsftP7hlcQ3R0YER4XQO5oZBOPeLG7lU/PycMK0jaHtorosdfw/EWN
FF4nj2rai4hHn8vVQJaEQ4YNYbGqp3Z8jOcOUa0rhPTHw8nXkRKIeNnj0GPqy+Mq
`pragma protect end_protected
