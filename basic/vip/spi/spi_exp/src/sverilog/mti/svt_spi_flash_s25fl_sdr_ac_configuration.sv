
`ifndef GUARD_SVT_SPI_FLASH_S25FL_SDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_S25FL_SDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Spansion S25FL family in SDR mode.
 */
class svt_spi_flash_s25fl_sdr_ac_configuration extends svt_configuration;

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
   * Minimum Duration in ns for which Slave Select must be deasserted in
   * between Two Instruction sequence 
   */ 
  real tCS_ns[];

  /**
   * CS# Active Setup time
   */ 
  real tCSS_ns = initial_time;

  /**
   * CS# Active Hold time
   */ 
  real tCSH_ns = initial_time;

  /**
   * CS# Active Maximum Hold time
   */ 
  real tCSH_max_ns[];

  /**
   * Data in Setup time
   */
  real tSU_ns = initial_time;

  /**
   * Data in Hold time
   */
  real tHD_ns = initial_time;

  /**
   * Clock low to Output Valid.
   */
  real tV_ns = initial_time;

  /**
   * Output Disable time
   */ 
  real tDIS_ns = initial_time;

  /**
   * WP# Setup time
   */
  real tWPS_ns = initial_time;

  /**
   * WP# Hold time
   */ 
  real tWPH_ns = initial_time;

  /**
   * HOLD Active Setup time
   */
  real tHLCH_ns = initial_time;

  /**
   * HOLD Active Hold time
   */
  real tCHHH_ns = initial_time;

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
  `svt_vmm_data_new(svt_spi_flash_s25fl_sdr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_s25fl_sdr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_s25fl_sdr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_s25fl_sdr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_s25fl_sdr_ac_configuration.
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
  `vmm_typename(svt_spi_flash_s25fl_sdr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_s25fl_sdr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
HzjwRMpWauT7Mzgyks/CFgRI8oP7OWhvcZ6pZ1YVpe43bHXLj6z7c6rpEP6xTA2M
vnaeyjVuyKT014kusmHEvuj8dvBslSs02tc+PVa7QWtHm4ejDlLVk+1KOTzZC7YE
PuqWEjMJKc9ErWD4rvjKQ9/TXyU7TLxPZpOve8aapBE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 769       )
HPa+6FIOpiJOtjeK4cPKKOZp10/CyZMaqqgGg1fmc8siZCZC0kQxo03kFO9SXTV/
XYygDfOnXlO/IAqvmU4hbW+oSsIy3FXh2/MyMRCgkkRxsPQCMnm257p4suvhSR55
zT7dcLBY1GALzh1T0qc/+1QZpLzYVlYZ25GaKU4j1PI+8WR8KNKad852ik5Cfbrv
2I1UjtlSm3QfeS31w2t/O5YsFDenGFgzxIrGaWSXSwFrmAQvmVgthgtrLIb76D3/
K9tJmhn/k6dohELUvYVG/fDjptmVh55XE9FxlehgP4JXlbgZ9O2RFDkts1UFwopv
xZL/QTOqSLCxkefV/mzWYmBw0zcQl28jZ/juKdVa9hxGrCN7FBIlTOf52XRzB4qy
2es+G9G/hDBREuk/psppo4mBCeDBV8y7xoAHPd9ckSaDnhTB1f9nKtcpZduGdJ+D
tyrS5aQsML+HhGndwBkAGxSRR4HrAWKc9uGYf1eNIUQav33eWwcKlXD+WG6YKE+G
MOGG3mraivd564aA3s3D+OAuVWetPhtC4XcV6ziuLF6nGgfeqGNEy2UuoPWICOnJ
5lVelfS0zXtWK2s670ryI69H12YoG3Pw5eT2N4FSHsRJD0UZtCStxWisUp/0SIA7
BEFY6XdjgRSyTH+feOIZNNyzVQzVzQLilKhHawCZBzcSBZN0QzOwneovy2kRmW0b
V/a6DYJQAIngtvirKbG0RSWMqgP48EKlzcd11VGHgLLru2zqwN4tvdtv3Ui15bKC
liaf1+wFMAOOsDUJ33P2m+EVa0fwgxNVKPdFCV924CNYJRqJYosFEIOSRdTa7tZH
Y0tln9g3quniJqRhQKjX+zUCUOOgBFffkfa1iRQOauNAr+rA539MTHq3ZEPpBggj
KVK4QKJysUaBFDBRrEYzv+cI03MRds6UZwJdc9CIucciEeM4o5vAHgiIDrYGE3wR
cn5TUwelYUKdkuJyfeOi52qrW9m4tTHDe7TMFSb/+oLe9MwV9GUVeWZbbr7ugkV0
VL/qBVzhSYMJ3lgMrJSi/w==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
KROmJs6QuFeySFKgcFkYXFa1rlIICS3bRnv9X2/k4siFRY3wRdMHNTEdK6fAPOVn
BcIusNa0kQgOef74qgSk69JE8cHGIoXHQxXvnVPIafePA3d71hAeAPKAQDDBFy7V
Wex4tGQeJNodsVjLvseMCieAlxlC2qjqIXaPtS+6V1U=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 32637     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_S25FL_SDR_AC_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
htGhdJn6yJ/d9Lyym85OqKSz65ATB1Fk5QjOhRoZVbyrIHs3BbtRUf/Ote921ctC
a5nMsILNOXpnU2c8zvOcJHG42brvRb0+t31kcm06HDf4ZS/u1dEM69Zunwj7Rogd
ICeZlNELJEGzXKk7kdm8Zy72f9fWtbGRxhVjwR227G4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 32720     )
zjFURRXc+iHBkLjt21fdXSoutyWZ0CSKhNNzSQvVnH0ZpMHenLLCAz9eWfu8EFif
Fgez6jSwpl/7Ax5CF2leQ/gOLkfb1d3K65uxN6/FuB3P9Kj8aM3GltUjY1Gx3Oz8
`pragma protect end_protected
