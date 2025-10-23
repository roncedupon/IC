
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
XRLRRC619Lli/V7g8G1unEajyTTwzVvsJR97MgKjfJ2mAYq3MEC2fwnzWOSl4i8E
b2g2MJYXmsBEn3WpDm6ommrr6rqgFcXM3romYoga7IvEBfezBm2XCnCMFbrahCwF
WqkI7LKc3H6ZkpULRbGTGNhZ9bkDuUIF4WmSbomy/lc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 801       )
aLDYa7J1/dw5xm2gEwdbSKqPHly5No9SMIA0H1sdk1klvt5oHHzfUMAXPvq2R9hY
wVL/z378p5j/rbKS84X97H63k1JjgOtFhekKp24CCEJVtDowkgzSZm35uA0RHqvR
AXBrak6mknIaBjQfkTAn7FP1if+xdMtMtcevONHLLMNioegGmKRw8XhBnmHG6++X
qBv6OaLWj+aa41mRjC1BnFElXdsMFbpbeNn4dj6IpFzUIpa8FEBiwJvt2TSWvPCR
DDxoejUWthyiXfDxEcE5Y3kRyjRXJotelSNYX2N51Rj3ZYvkuLroFRB4CV7X76Jb
aQnHdXqNv6llwknnb5dKnEUk0ehtYAotzWl4fT7Vlo5qBGvtxFg0JyKV0cf/Pkp0
IGvUiAFNIg9xnUet2EpW8eW6sGyvvJ9ljr02S1M2LM88zyi+I3qZSGtZzsiOKF3b
Kzg+YVOBG918gwjTohAorfh/9L7opWHE445c+dsf82MTqzGcS76vCHz5k8tLUkF1
OxMRgpgKNBeL3M1iF4jR+jSIg6HFLi+hyewvJj7plNHLfkf13vmiEu9ogHUKG+WY
W2ukqKaBr0kHjquz+Xp7ZDN5+T9nTNXHbh2OURfvazvMmfdabsawzxCOU5/fXAOf
rYWhDeFIQuKnl0G0cgePDIgfehXvTMvDVbTI7UsKrdW2xKBDw9ZJjNU8QmqSqKvD
ete5o3X25paP8QwVissZiOnvUohciKwQPYb8DwzhaVz0hQWi/AgOqq3rxQv2jneA
YufHl5/z2NN2UU+dPQn5OQArbRs6zcbYqLXc2yZd1GSts6XMM5DMRPSPuNQLJXAd
yqK4BV1/rnv0B7bXZRuISyt+ADhELRFbFZXwFQbzTOYQ4SP0cFEgC2E9L8KfodTK
LcDz85inWRFPXJyuNc9OGLBZL/2q87+oQVpvYyKx/W4UmUeYYlmmawZPgH7xpHG0
ongUgeJgDbEkhmQv0bYb2CbuYhEYCBpWPy70LIWNrFFYUN/+X+Vv9SFNY2Yoj8Fq
m97wkZ0jX8MLE5qOoNISWbK/vKnU7p94cFt71LkYrG4CJpU6Lk8xl+lxnxk4hIZ8
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
DEFnVmzhBtrHw27u14S7oSwvizk/BGEO0qcg3dmCaZXc266tlQzKCvYoECXuUz3d
OoyLafbCgbnWcwXnzUBake7/hgqiz5OI69WX0YNamxGKRjARO/CzENELFZCyqI2P
OzAKI/yA+eXyvodG5asvuZHoLDHHzTY2quzYRqTqRck=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 21386     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_MX25UM_MX25LM_SDR_AC_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
SM1WRM3V6dqoK4RpDUUpczYi01Nu7f8DJ5J9BzwadqkWroFPbs9BFPonAfNKtZsr
qtCVFPJgVugKnEdzlZ9mZvdQV1C9mP2TaNr4ktthSJmbQTJqH9FdXym/Dzggc0LR
yAsuj6tbvBiy1tvAXyu+NAhMgPftaAKbmqM5FZIy9+o=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 21469     )
/XXkvWINXnXpL4xBlKtfQ6N5DojrKq8vUY85YtTfdaxkpVjlxHDtNkdnMkR3KQ2z
0WdhjFdM7s1yuHbcLyovzaCG9URawSjcGxQ8wLwREiiJMiLermdVXef4b4ZQ1rSr
`pragma protect end_protected
