
`ifndef GUARD_SVT_SPI_FLASH_JESD251_XSPI_DDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_JESD251_XSPI_DDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;
// =============================================================================
/**
 * This is the AC Characteristics Timing Check Class for xSPI Flash based 
 * Adesto JESD251 device family in DDR mode.
 */
class svt_spi_flash_jesd251_xSPI_ddr_ac_configuration extends svt_configuration;

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
  `svt_vmm_data_new(svt_spi_flash_jesd251_xSPI_ddr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_jesd251_xSPI_ddr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_jesd251_xSPI_ddr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_jesd251_xSPI_ddr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_jesd251_xSPI_ddr_ac_configuration.
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
  `vmm_typename(svt_spi_flash_jesd251_xSPI_ddr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_jesd251_xSPI_ddr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
pG6z6E3ZseewlF+Glk3T1pW6NX2pwGpjQi5WOG9Lkp98eqG0A+HwMnBcOOdUX9u8
WuOyIoR6cML8Mvdnu84Bxca72iOAY0a3naLio7um+kUo4j+6BBzR2Sc2xzFE0uNR
aR8nthV8Xkse3b8d12xueuNwIqeb/jXiziQqTwf7T+4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 797       )
6/Mr8wRlCEoJ55ohB7bG+HxBtbSHFPyXh3OCXWKG+F8aDq8fkNP/mDepmB+LZgR6
1KhIzWcA0WWsx1RNXNcG6dwFjX6m5Qf6iSje00b944BQT4aeGagJhmm71qYDKaWK
4WoEG/joehlQHSBaHwVkyUrGax2Cx1SUREpNNzAHRHOLRJgxXFAuGcg6QyNNAemS
MInRWEApaS1hV2Ym5fW0MWdr5Z9mmWvWvYdD9PTGPN3SplNt6V1F3dxKeHR04eXV
nKsCsDb9dZhua5A5OkCgkAE90bko6V5N87mzjRWPXQ21MfVfK3TK8mKxRJNrODJi
4T9UvU6opBpvETAyPMlwu0FLLOPiPDiInezQRF/lD5gT3YKnqb0S8fjRR3e+uDtA
zL48PxOEOON82LlwNvNeLXnP11mbP8JYREZN/kJRbFfi9ruX2GGdey3euEsjs+hb
Zk49eRbMLCP30TP5g3kAvy9VH7RZZWUfxrcbK7rFHOhXF/u/U3O/JoTHu2gFnKvK
PlzK3Kw6VV+PY5VHG1DpEsn01ms85mHNrkbcIkPdL6Me8wdfEDVS3jFHlbM7uMHS
Ra56Vx09gske8AdAGA0lxwHMbxxmMB/ULYcoWT8tKaBU4jYYWucYtyOlY3wen32g
Lu7I7/Wvt5iAK+yaz2k8jLFZS1iugUR47Qhl0yY67rKzndY24QPvLXKtMmPDIntr
rH/5OjFVNEP/DkNhr3p3MLorsBfl/q8hGucNDvDGmPJNn7dLc32tsO1/Tj1k8lyr
7d9IfAU0DtR63s+hb9A4y6ICJ2xv9LoGSsU3hqRsXksbn5WexdHHqxqoT2YpSrb6
jOXi5TnHF7nPPVcvK6qjIoC0wi87lVFcm6tQr+aOf7dNvOkeZCaf/L7ZdpI/l7AN
MoZG05EXpmunf+pBy2w0U2/+hO0jOQjopSDPwyffNF+ik2HewznGvkRme9w+1R52
THh2QvhTFgT8mucANQXsAZqmi1eyzIcxngTUAA7O5wugkzBpNQqRqlfqAQefZdC6
l7BY6A0ctkWjkgNShlXblkAcl2ZNyFOIcrfRnU+/PMY=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
HWPq+Fd3DxtKhN5i8ZnhjfJUJWHxdpOfAKdXpYqwmYxzZqx78ITnAIUP4cm4xYL3
HOJBLiIUfg/geM8POLwU3BVJMQ9k3F7PC4mLUvsF1silR3fuPtzWkM9F4W0XHhN9
j1i+tMkY1Gr5R095q9D4oJHUIXCMVL6Eqox9gFeSpEU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 23245     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_JESD251_XSPI_DDR_AC_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
njbisNIQGMjVl9IqLPql/I39GOimnIdOViV8a3NKKeGv3ujQAFb+MN4wDjVhGU61
LKVFknMYc1c2Hd8FN7neywxNaEEmoDEGkH0YGuUeIkqrRfl4W/cXKPwpyx7u8cby
NEZuF9IMJI70bLVZ2JR1kC8E58uZhEMCYT/EFhyE1o8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 23328     )
VGZmLngbHeFRwbxAKI+XOJXqcVYpkEGdgzoIrucqkndFe2z2940KBf0BdYquP6vR
z+Sx8Nvk2LgMYpKhFcqHs7d3Rlb71P3ZK3hGmjudNJU7w/iNUpPXQoEsioHO6pjw
`pragma protect end_protected
