
`ifndef GUARD_SVT_SPI_FLASH_MX25L_PARALLEL_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MX25L_PARALLEL_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Macronix MX25L device family in Parallel mode.
 */
class svt_spi_flash_mx25l_parallel_ac_configuration extends svt_configuration;

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
  real tCH_ns = initial_time;

  /**
   * Minimum Clock Low pulse width duration.
   */ 
  real tCL_ns = initial_time;

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
  `svt_vmm_data_new(svt_spi_flash_mx25l_parallel_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_mx25l_parallel_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mx25l_parallel_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mx25l_parallel_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_mx25l_parallel_ac_configuration.
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
  `vmm_typename(svt_spi_flash_mx25l_parallel_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mx25l_parallel_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Vj2KGwDqS6WKjD4qf/LyXzb13e+Tofc5SftuIsemjHuX9Kb24RhiLV+lRnTU83nG
QdKvA5ro0oWdibjiy1zz08pjDfMCNbhYC1ZFBNDgjB83zIRIvnvT8J790EOlI9dD
qHkqeIY4+8951OrvaARyY2BNrpK9xmtMnQB8AydKjDg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 789       )
6Pz2EUJeaWFySG3WmcnaWy1WQWYCDWsGNeS7m/15y0xFORwuuS581vsOjmruD5VG
vcu40PA6aLajHkMDhgIIe8O5XEzEX9v0rqQMf76i1oMGRz7qeD9+SlL4GtJY68wJ
JAbWd6q8tvg47cyoWzyZjFoUOp//gXdLt2LXg+KO4qNhr9H5XVNAH0FzoKyFUR3T
rOzzXk8M14+PD6fzbeH8t7sjChz7rckuoh7H+rNzsxIQeKt+fhMJvXr2O+Wk3dA6
C/7esp41egpNExcojqVBXF77sWOKdnKzuCXU6Hql9PEGFc058he/ZxZwgBqsqKJX
R0ywjTy3JItny0WNLCavyqwUGHG9x7R/nd/iFiAKoSwZOGn3wis7PnZyyGLFe/tH
kkWN3tXUvdwddR4YWY5eEQV7SfABA7pu6Ww7Az3g7AYrU4PBiXYYXE6oNte3YpJi
UiJb88ykrHx8GgxktjY2uiEW+ne058gi3sxXY9qEd2iYtBQJeAVio6tgB10TWVKS
ssN7A0alT+tAInYtuDCuIRg9do964Rx01H9/fJ4O0VwJy15Xj5M9xyMTPmhHRMJj
r/emYn9PMIBIlqfp7hNbR0wmOO21iDH1W040D2qVK6aY3i0ea9e5/0BB3S7MbDd7
m0GVmeuf72b9QdM3WC7DIc1KP7NEwFFNrnzqbBP2uO7IrXSmxAJoDch34HgivvaL
S1JV8GjixNibVsGbMiWV1lRywH7+2BIXjDId0vsU6wT4WTb8nxHvQlW6+k7alDCw
gAgMKBAd6j7FxyZ5LwgsCHJQ4+S2z9ohb5MUKTKkVIXKVlCv2w3VRjJUBbwJaX8Y
8Hp4PuFkaJUio1qaB4l+4D4yXBObZqN/d0DV7QwAE32utU0qUwP5QsFAgm2UkOti
9x2LWCv8zrDswhMFAiCw5NCbRVe6cxsj+iX3VngRcnz/xV6FbKMaJh+gED/6/7Uc
VM0PfXw4Bx14J1Zi2ii1VBN5PmQOX+racBZYC+6yGqlSd9lAB/5bKDGpNLgSEV4R
ae2pi2Yt5pVkuu0Yz0HjUvy1Pqroquq0QvV0WNVwAYw=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
UVwg34EL9VZsCK4QguNvF9NOxh3oq9PBn1q1Lu35WbpZ3CHs3yT/0P/ckkbIX3hG
0LU3dRbuZwVlg7ifb64fkaNISL/HKX8Qebd/n3fg3+Cq+7pcpOLuuRru2dYhwm/y
oJYsWU1S29EXieRlfyooA8fiPaCH7sb14UuCi8D96Ms=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 26009     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_MX25L_PARALLEL_AC_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
W8M/r1eMXanIJ0FN1smUw0EznCr3ZylAHZFob8K+R8nDccR1yUk17rraTE8dZf1A
RXEm15wdZ0qB0SPyMTLPKn4nJQTaJXX27v8OFXlhky3/b+QsLjSpcBNT/duPmySI
Wvx82QQQHQM7uyMV5eXJAbh1iblDsANLOQFoPP31uco=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 26092     )
RNVZj4/gwL9gJJvLTjT0rJUnZ/29+xDbwJMveu0ovSXxI+VQPcNrIsvPq9FG1RTu
F3Hmm5pCcIPO9LCa/HYVBIy0gY6FAk6ldF15AZLwyXI14h01ywEW4N0+yygZ3iZd
`pragma protect end_protected
