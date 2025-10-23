
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
6BZQgZnj1yahtwnZ6NcPBiOmPOEDmW8ocrEV3DfZ3Qwy/33QK4nUp4KVg5gNSrOW
49krW8CY9WJYBUmUOLDQL4gkcg76Z5wwOaOIcwb7uwaDueYPL1dmqBaKnn1w1zdr
Ymqxqwo5h4f03HXYcOBxEIfogf5ybJ8Cf6cs9skxi8jcW0s/kcXB6g==
//pragma protect end_key_block
//pragma protect digest_block
dAq7JR8I1/JDPCG9o+xV2OO9iAc=
//pragma protect end_digest_block
//pragma protect data_block
4bl3WSg95+w/usiRolzl3d5jome66mJif06RlsQCeVMwd7YGa3mTdjWZpCV6Kf6q
AHaZK6hGZh+EW8gIgRc562Sg0oHD+rEBiJ8hlez3k3MrUCnvYNqrfNEB9cqxLveP
/hPoO8b4rfLUOmh7MTnf8Z8EI4z3Qe+h/wJmeKAKwNLWL/QydyDLihfL+bHSL2nY
phkek6+ectCdOTz2E0cQHya9GEPSA/LiviR65KsP6lCbJ67iVg26SgpDfPNjimyn
zp1TCloX7w5djqUclEbx8TfXaeMJpwPvhnCuUPfzlswtQgbrV9zag2fNUl4YYCY4
G0X8iN0cCQ9j9ywiIb/13TXM49CwUfJmzo8yQ9PSYsaz8cwjbfhWiCbY79P9r9pu
uWOzS7FWHytCqNOfJUMINSOy5gj1k++iG3kVAxh00E/OxXscDMxsfhyFN+L+MeqW
PwJZQekPMngQBKrJzVi5cGSVzBIwrFkArpVRb2wgIvT82ESy7x6qAkZZ/wqrKhyF
xKJheg+7ls8SV0Q8kE55QjryTP3XoPKY0d3t9KuiW9Hz4I1bRQSrTC7oeJFCTYCb
V+HUdiEnQ5TFG+aUMvCOpAmVDdIxHVJ0fJkSE4fnaZN3mG4dPvBvdHUKxx0Tn5cZ
NHLPudEXSzmcWBWTcjt4yvbjmi7wGXekU5Ai1EH3o9jGfy98O9u8jMbwsYI+dh5y
dnTFBU/WYdAl+sr5Z7qkVJx5LYszJY9sRsPsi6LbDqf+lvpCJmuhjw8Q4Ualco0t
9cJ0V+zwBDr+ZzzAuhDd3zg6tGocukBOaX0HyErjPKbhc70WzdS0lcCL+1+zekO/
Epul/eRVxk7qAB460rXimmkgP2x8bSMr/3rDbkhozIV44ytlc6w5HCPM0mFv3TyH
Ga+6sLqHvbCegopzZZdILAIAZzhXEFuGdbfUnsIcwfM9ug30jO+Mwa30exCJdRez
6eV8P5GA9EE29MN39OrkRLteo+lzUd+2S7Ewhk/xXUBkR+jhJM1wxrW/8bVxdYIJ
h4aGlsz9JGRmGteU46NhwS0SDaebWTWkcjihfBNbFf9hSSZneEqQZgpKdH/8oFbd
zYzKIPNZC5kdI2SHpT3yUs9oOJoWfz3AwVcpegWDxHzAdN68uIgsxONcjISNj4Js
J+rgP0HuWCGLx+FSXyiuH36GzzN5eMJ6rzdJhOFMnVqXNGIiHxzyHt17TwSufvFH
prE876ai2oOSWHz2i5vaUg==
//pragma protect end_data_block
//pragma protect digest_block
lbsdN4fB5Df99hLg+vQO7MbRFew=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Kcs2Ahfw1xrNbuyEu5C9CXUfgw6iLZCr9YscqHD92cjT6mOxpD/41Xa/fJpyybZL
ndq9N/SDtKfXjdyKMLVfxQ/vZsq+LGs3YyfS/MNvuiy3Z7VxmRECNhTEyGKVmXhi
sP3ByzLyjBf7pkD0/SB8P2XWqGJmPw4SzA4ztg07cNl2u9lkIbt61A==
//pragma protect end_key_block
//pragma protect digest_block
sjHkqXfl2yk5ZrCjKsBGkrrF3sY=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
QIlL08FwUF9MFHv/iTmXB79HEDk=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_MX25L_AC_CONFIGURATION_SV
