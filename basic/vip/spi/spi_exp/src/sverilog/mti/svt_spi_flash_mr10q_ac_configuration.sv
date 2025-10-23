
`ifndef GUARD_SVT_SPI_FLASH_MR10Q_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MR10Q_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Everspin MR10Q family in SDR mode.
 */
class svt_spi_flash_mr10q_ac_configuration extends svt_configuration;

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
  real tSU_ns = initial_time;

  /** Data in Hold time   */
  real tH_ns = initial_time;

  /** Output Disable time   */ 
  real tDIS_ns = initial_time;

  /** WP# Setup time   */
  real tWPS_ns = initial_time;

  /** WP# Hold time   */ 
  real tWPH_ns = initial_time;

  /** HOLD Active/Non Active Setup time   */
  real tHD_ns = initial_time;

  /** HOLD Active/Non Active Hold time   */
  real tCD_ns = initial_time;

  /** Output Disable time to drive MOSI/MISO ports to be tri-stated after this time   */ 
  real output_disable_time_ns     = initial_time;

  /** Min Output Disable time to drive MOSI/MISO ports to be tri-stated after this time   */ 
  real output_disable_time_min_ns = initial_time;

  /** Max Output Disable time to drive MOSI/MISO ports to be tri-stated after this time   */ 
  real output_disable_time_max_ns = initial_time;

  /** Minimum delay between Hold assert to Output Invalid   */ 
  real hold_assert_to_output_invalid_min_ns = initial_time;

  /** Maximum delay between Hold assert to Output Invalid   */ 
  real hold_assert_to_output_invalid_max_ns = initial_time;

  /** Delay between Hold assert to Output Invalid   */ 
  real hold_assert_to_output_invalid_ns = initial_time;

  /** Minimum delay between Hold de-assert to Output Valid   */ 
  real hold_deassert_to_output_valid_min_ns = initial_time;

  /** Maximum delay between Hold de-assert to Output Valid   */ 
  real hold_deassert_to_output_valid_max_ns = initial_time;
  
  /** Delay between Hold de-assert to Output Valid   */ 
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

  ///** Assign refernce of svt_spi_mem_mode_register_configuration object */
  //extern virtual function void set_timing_mr_cfg(svt_spi_mem_mode_register_configuration mr_cfg);

  /** Randomize all timing parameters in between declared range */
  extern virtual function void set_timing_params();

  /** Calculates Random Timing Parameter value for #hold_assert_to_output_invalid_ns */
  extern virtual function void randomize_hold_assert_to_output_invalid_ns();

  /** Calculates Random Timing Parameter value for #hold_deassert_to_output_valid_ns */
  extern virtual function void randomize_hold_deassert_to_output_valid_ns();

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
  `svt_vmm_data_new(svt_spi_flash_mr10q_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_mr10q_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mr10q_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mr10q_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_mr10q_ac_configuration.
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
  extern virtual function int get_clk_parameter_index(svt_spi_types::flash_command_enum flash_command);
  

  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_flash_mr10q_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mr10q_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
U5pGx9GfSPxxvfhVkT32sX6dJoaYWx6FpDjAERnthdaSP6hWwezU7JlPFPLm3K4l
vEDQ02T8P8CvfSnoHhNrXsdNGqjzBJOT7DD7t+vkh7kI2bKaIErGocJD/I3bfQcF
CIDmL9gwT5rOudUHSYtV+2CvpdPAeQVTwiH4Jes3pD8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 753       )
OfQPS1ERjri2YBWEfIgcKPII5xL/bG8dvxOD37++chAXqoOWW/m9qFfZXHNQWuzp
CYjpXgt8LgFbCfq1bMbHhOhwuw3xglC06LC2zoo7VDmbrB0EWmD5By9JlTcj4Xou
1HpVqjljxQeapPoZFfr6lghiJTmYxuzZyQe4ctCjisexEk7EtSx9hm2rclkgOpdf
Qw+sJNwc9kzZl5sNYoKPnFOl10RxpS5IrBJwFnrJFvkCRoADU4pjHl2V8O/62kA+
R8m9JHzmPmmVZPiI/vvmg5UyQC6YjIfnU0EYnzEyluKICkaJ9JcGP+5FYT/MveG6
FieVq/a33BLmU1U/dy28TBIz80DJJbZEkZeX4fHjmnYFNMCta2VWdlSv5vbKWKAF
5/q3nOrbvmClqLvfs61BOXCGx+7romrpVM7cuNNvBb5U0wP//4QlC1ZiWAgGswv6
iJpp9YwM9M3vyTdhkZ/TjqGX5FblqaEUCh56Thnw3NcmcoWKFbivsF/FIYRYXByG
vL2gS/eor9QnSiRaEbvzFCKumU9clX14rcDuy3whWO0UZ9w1E2U2AwmCBcDLia7O
xpmYpB6X5q8h7p/1hzGYfCzgbwjAEnv50NR9uOaouU/KH9Gq7hs2y4A9PNWMZ36l
sRwL5U484SLeVSELU/Ty6PpNbbTo6ctp/QP4admhr9YgOmeszUb6+JTlUKXBa/pa
6KFmJC2ncj2BaEN+rj81fTS/eyQ+KsOAZOOsAyBzgadKraF8Bfrrwzlp6AA0rU7/
cDd1EVCWBekMzxXKDqVazI4hKgvqolxCHx2Vs7cbh0VKfKga5FutSu2H7Ds6YeEz
7D/aVRc4yKC4srUCuhZyZY13uIqOxZ4bZk4kmUnPxv3ib14kciC9rR8079JLF2Cx
9ibUMza8tvjRvvVfCucXmCUldemo14SK2XzH5gv5A50ZufF7IKtEUZgHnFfQKDMD
LI7xUScotPaMD5Aj487SkrRcafQNa4FxdexZR447jMMGmyl+NasP+zFl8zKBbXVD
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
F7j4MpZMmq/2rbjIRvTCNtfNTzW6n/RP9yFY9zppgu3t2bzcoF0nBqzSizNPDmmq
/wlfW8cOEVoXLycTV299ey8FFkk1MW/tuXecsMWJqyipZd1+KcZ3Gffr4GWXuvNN
IwGgYpZyJ065Sh3H0zr7aMMq3BKE3ze1Q3phVjrchZg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 30940     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_MR10Q_AC_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
RB+Xrek7aJDk9gb2J2LfLo6RuzfWGSolgEswN905wn7/Zl1u7TN1qR44bunecsMb
PXR15rNu/MkSYhAkRlEalNZ3pbnBEk0li5ALe2z5h85sLQ362N7s1Csdh1ez8bRG
AUwEyMy0JqFDu4F092YWrfDu+Onv2c1V/G4LtmiXEe8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 31023     )
9PoR5hhhV5ykNTFAteWHWW9QWAlkm8lZ7vM7bRID64D0GqBqb7UTLFuNJyY+NBnD
X/RPxV6UmD62Og8qIb1N0B/ntNZ8GATtYD1zxRS+WU1hT98q7TJ9JeJFB3CNqJAS
`pragma protect end_protected
