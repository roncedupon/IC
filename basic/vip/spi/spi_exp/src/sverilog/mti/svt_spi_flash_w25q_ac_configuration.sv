
`ifndef GUARD_SVT_SPI_FLASH_W25Q_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_W25Q_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Winbond W25Q device family in SDR/DDR mode.
 */
class svt_spi_flash_w25q_ac_configuration extends svt_configuration;

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
  `svt_vmm_data_new(svt_spi_flash_w25q_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_w25q_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_w25q_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_w25q_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_w25q_ac_configuration.
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
  `vmm_typename(svt_spi_flash_w25q_ac_configuration)
  `vmm_class_factory(svt_spi_flash_w25q_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
fyNQUK1x3RvQmjI1uGi/BrAoyx6CZFYBUmhZbEOCRwdJtKx1bER8zECmWVCITv8o
BUiRthPxtDa3Hpoz6IL09MtWE6KlMbdKTKx/utb9bC4DvouORPKJbIPkJU83Dezw
Varvim2o4tTVqJV1LBksLNgS81rogXMkgFPTpC+yREU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 749       )
rmiPDKobIZCiMPIDrpZgyFSA74aeApmqdmKcVIPN39gqMu5cNSLuybSQ4HS0Bbn/
RUlqD4O2+gGDjTujpZTaabTBpSSbEfSUsaa/RTDakchmzZOOyqLbXQVROT4Gd+CP
YGZyZoBaMk5FeVh4hDn9JhlBgFQ+XIvgDFH1hWacA/a5sD5ULAdTQ1x1ftgN+xiI
4+ujCUvzj2jt/Hd+CzqQRtVTw/xEQZkrJohZ9fTBha/IyOhuc89CDzNn3P9xmlQm
MLWMSVMue+hXkXEbPz0vfTROMubY3R/TVMgFaMyCcaylg+eG6DbKX7N1WkKc0CyT
pL7g2v5+iKpdZImT5I6jZh0XPnwdpRYya/UACTZPyQZL5HnfcTh2b6YbwrxD5a++
fnotIMAsgkIBSIcuZZX+udm9DLuLDb4wA1k8jAsS6liGywWxk0Tgytr6wKEzNlTm
l9IfDYkEVLFaoCOPs16P7HeosOYMkXGTcpXn+PGSJKPBl2eVVvhcftyhVgjYsuWw
jQb6Ez1rugTDG8VKwJ3Gzs7XR2vJg/7mSgsnw6StdZrtpHpsrk/BlgkwIZm5wHYp
FElJmsz6rqV4uNZpLbWXkvNVf37gh1EfrIFD1tZE3/miwJtsVot81QzcW7q++Cf+
kPBIVqg1K5ZtHiSBvliyvx5iO0NHw837NkkNpiY+4Z7hUuAi3IIAlIH/C91m9OPx
ZxRBLj0JEYmx8veNuu+UCDvZt578cFZVnZlU1QLLtKLoEnP+rYPxBvAs7BPpEN8J
UVr+Vz7Pl+iVmMBPxYcc7VlNZQmP5mUAe6MsIaj0ZQu2IyF8PBFUq36nEtph047h
gqvt6B1L658ffRWtoA0ND9ZeTIp50yV1523BnnmAytGz6DBoux/mGEJHrbWhRHTw
Qjcqlek0AF9gLPa4WgTIsaLJflDTBKpPMNRExxLtuyw8Qbt6Ty8zWAEa569Zaakg
ZC4W8SpYAEIIIoFhLd2cN6LPIWS58HUrZ+6tFa4BprU=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
DwxehFDwHx6JRGTSL5/wnB998ZQlxT1qsc4saS0Lh47+tgyMg9yDAJSoBLlR3HO7
UBff6oRDFFYXnuG3iLh1hOy5ruQsU8IetyXb4azcm75SWq3sHIuo+NiknSlzIPIl
BlsBHIFvRR0bOQJakrOO8gA3rgbOz6hNQb+RAL3rPMg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 19248     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_W25Q_AC_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
hcuY8gj1FRWqlGapRB4NxPbnNSl1KzRWmBeThKiHLAdJnt1WwpRnZ9cejMXmhCKp
w/TCHvtnKGFKS94NktZ0T4DmqTO1BZ5/8U1Sypey4dUuNleREpImAzQgc0M445E0
qUDeFM82kScKDGc8AzKvzVnLXfTWbCkcuJMRGGLuRxM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 19331     )
uaHywpBANpaWZAPAkH6yHJsA09eKvjsUdIl1i+wJak0iWRPTRpdzFgw+9qwaY7bO
dtAOl9Na/AK52MrYZLClpNBoDrEHPdrdPPgHebBHF8eucWs6N3u/bPfMvb6wahjB
`pragma protect end_protected
