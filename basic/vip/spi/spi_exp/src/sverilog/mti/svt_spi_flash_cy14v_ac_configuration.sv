
`ifndef GUARD_SVT_SPI_FLASH_CY14V_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_CY14V_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Cypress CY14V_family in SDR mode.
 */
class svt_spi_flash_cy14v_ac_configuration extends svt_configuration;

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

  /** Minimum Clock high pulse width durtaion.  */ 
  real tCH_ns[];

  /** Minimum Clock Low pulse width durtaion.   */ 
  real tCL_ns[];

  /** Minimum Duration in ns for which Slave Select must be deasserted in between Two Instruction sequence */ 
  real tCS_ns[];

  /** Minimum Clock Low pulse width duration. */
  real tPeriod_ns[];

  /** CS# Active Setup time  */ 
  real tCSS_ns = initial_time;

  /** CS# Active Hold time   */ 
  real tCSH_ns = initial_time;

  /** Data in Setup time   */
  real tSD_ns = initial_time;

  /** Data in Hold time   */
  real tHD_ns = initial_time;

  /** Output Disable time   */ 
  real tDIS_ns = initial_time;

  /** WP# Setup time   */
  real tWPS_ns = initial_time;

  /** WP# Hold time   */ 
  real tWPH_ns = initial_time;

  /** Output Disable time to drive MOSI/MISO ports to be tri-stated after this time   */ 
  real output_disable_time_ns     = initial_time;

  /** Min Output Disable time to drive MOSI/MISO ports to be tri-stated after this time   */ 
  real output_disable_time_min_ns = initial_time;

  /** Max Output Disable time to drive MOSI/MISO ports to be tri-stated after this time   */ 
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

  /** Assign refernce of spi_mem_configuration object */
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
  `svt_vmm_data_new(svt_spi_flash_cy14v_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_cy14v_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_cy14v_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_cy14v_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_cy14v_ac_configuration.
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
  `vmm_typename(svt_spi_flash_cy14v_ac_configuration)
  `vmm_class_factory(svt_spi_flash_cy14v_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
eB5VzyHfFXj1rFAg8rJm8V/jF/8vM/DsxiMKKNt9cPmi6J2dbTiofwr+hszMsiHa
Eth52yll4jx3QM740/ANsjfXzpBkIM94pRwmQHsbbWpPNGaqk+2hU3rL4IBv75py
6cyi7tl+RDvBTk7aQcnXl05zVCoN6+7alSP9s9QPp/A=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 753       )
3PAOIc2Q9adLFm/Xse3H2joD6cKQZ7DxLv3hNdmPuJgSed8te9wMFW2sVr4FExxI
nYxbrYrIDKHWFLMkCOzwD3Flg3jUTWpJJrgwSpQ6a0gKO0eEvZhAx6CXhvK8yffC
F5gIfq+xYZ9x0/wk02btY8Wdp2aDsYa8Cd48gbrDoynTvBP/OzBsBxqWGMAxAyh4
iCIM1jH2C8UGtCKM5eBkv8RPlP5NxCggHOq8m9CiNlMKiD/55rmD1Avoyynu87Ck
IlYQXtzhsDDhZt3vQ5df94lkgOUnxlBzQOE2J01hJL4ov6+M6Yta6EGsUogaQXQZ
77xBb5ql0uLFmogLXeRrQIJOXtbSasHVHl4fFGv76Gjg6M8eF/pS3czTGsiz+unD
Aqo/5z3aPIQGjl98/1hoQD4GrVKtexsRVqam+F5htEpd9jKQv9U2T4ZIuQ2sHSsp
JfGKq4hsziATvqwBfq7+BoFse69JqTmgv5iem1KsJ4fpRVzMJ8EIVmt70H65UuEv
KGbncOw/npU6P1Pji9y3mg7wsRYGBE3OAKb6cdkKiIj3ZxKX/8kTFDMQkQ+obnmd
CeG4XQbBu/1a6f4v9yMIG5FwqwdGe/J2kClItpjk+EQjNR96f1BYIKN4bqsPlwX/
G23IEWw5SmCAtU5cU5KarnllqZ1y6/d5gCwP5DzGEyObXgf+xkTJvRjogewMMNRT
x7PiE3nLfmTIukQ4AacUhoot33ecOh6cfpjIejvBOm/4spC7uWJg5f74328CQypr
hga5Mf71mV0iJqeyzU6KoOl2Xlf3ORnmUp8Kl2O7T2JXFDnpxirGYQdAu8JJwskS
wmnh2gXMXiAe4lpKrsiPY1h6F77zLnOQwHxywKuLTtMesJ5JMVaY7mhSaDFoJQEk
oNWaCZu2G6KpclfHR+8G1sSjoxW4lQUe5NfMhK3pfI2OvHt7ZHZmqPRp18EUUQsu
9p/eAtQ62VU60oOGW6K4k4FjIQU1tHAQjCEFMrHBQsuErFWFn3AK6dEcofZp2bty
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
N5U2TBtWg9osmwXOmmwuoi/sAYEI0IlkIVnJEPewXcjbxVrKpcg0KIu3AQQbfidY
8eg1HXdbgaJMUi60WfSrIncexe98ozNcFJvjR4EoLoYLZ8lUG8ZletbOMlP0oBfQ
GqXcgg/0EJiAgj7i54SpS6EsN7sls6LYDmmhSO67Vwg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 20222     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_CY14V_AC_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
DwC7MMAGuMn/WaI7cSAIx3Ru2jC8AMegi/tjjRWNoHnxh2bCBtCRbJuge42dhyVN
XLWFUYNHaj1x1RNwW3aIv7fY1w8xfaDKHJ77yAeBKgi2k/tGcxCt/5cEPteVpFXO
DhdgRV50o+oPDJ0xSbmPJ6lc/9oypxnTccXgOSfC4p0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 20305     )
5XODsafou621ZO9EKizak3Vl23F9/2G7HXzEnrrTHgcREvjN+CD8ohC8ggg77Gkr
ZtbL+VMTKlliPeoEeqLIuasygGVb/KJQ2MY+v8YAbOr1Pup154Vls5B4M70hkFht
`pragma protect end_protected
