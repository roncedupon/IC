
`ifndef GUARD_SVT_SPI_FLASH_APS_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_APS_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * APMEMORY APS/APS_OB device family in DDR mode.
 */
class svt_spi_flash_aps_ac_configuration extends svt_configuration;

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

  /** Minimum Clock high pulse width duration.  */ 
  real tCH_ns[];

  /** Minimum Clock Low pulse width duration.  */ 
  real tCL_ns[];

  /** Maximum Clock high pulse width duration. */ 
  real tCH_max_ns[];

  /** Maximum Clock Low pulse width duration. */ 
  real tCL_max_ns[];

  /** Minimum Clock period/Highest Freq support.  */ 
  real tCLK_ns[];

  /** Minimum Clock high pulse width duration in terms of sclk.  */ 
  real tCH_min_duty_cycle = initial_time;

  /** Maximum Clock high pulse width duration in terms of sclk.  */ 
  real tCH_max_duty_cycle = initial_time;

  /** Minimum Clock low pulse width duration in terms of sclk.  */ 
  real tCL_min_duty_cycle = initial_time;

  /** Maximum Clock low pulse width duration in terms of sclk.  */ 
  real tCL_max_duty_cycle = initial_time;

  /** Minimum Duration in ns for which Slave Select must be deasserted in between Two Instruction sequence */
  real tCPH_ns = initial_time;

  /** Minimum CE# Low pulse width */ 
  real tCEM_min_sclk = initial_time;

  /** Maximum CE# Low pulse width */ 
  real tCEM_max_ns[];

  /** CE# Active Setup time */ 
  real tCSP_ns = initial_time;

  /** CE# Active Hold time  */ 
  real tCHD_ns = initial_time;

  /** CE# Active Hold time for Enter Half Sleep command */ 
  real tCHD_HS_ns = initial_time;

  /** Data in Setup time. */
  real tSP_ns = initial_time;

  /** Data in Hold time  */ 
  real tHD_ns = initial_time;

  /** Chip disable to DQ/DQS output high‐Z */ 
  real tHZ_ns = initial_time;

  /** Output Disable time to drive MOSI/MISO ports to be tri-stated after this time */ 
  real output_disable_time_ns = initial_time;

  /** Min Output Disable time to drive MOSI/MISO ports to be tri-stated after this time */ 
  real output_disable_time_min_ns = initial_time;

  /** Max Output Disable time to drive MOSI/MISO ports to be tri-stated after this time */ 
  real output_disable_time_max_ns = initial_time;

  /** Minimum Read Cycle */
  real tReadCycle_ns = initial_time;

  /** Minimum Write Cycle */
  real tWriteCycle_ns = initial_time;

  /** Minimum Half Sleep Power Up Duration */
  real tHSPU_us = initial_time;

  /** Minimum Half Sleep Duration */
  real tHS_us = initial_time;

  /** Half Sleep Exit CE# low set up time  */
  real tXHS_us = initial_time;

  /** Half Sleep Exit CE# low pulsewidth */
  real tXPHS_ns[] ;

  /** Minimum Half Sleep Exit CE# low pulsewidth */
  real tXPHS_min_ns[] ;

  /** Maximum Half Sleep Exit CE# low pulsewidth */
  real tXPHS_max_ns[];

  /** Minimum Deep Power Power Up Duration */
  real tDPDp_us = initial_time;

  /** Minimum Deep Power Duration */
  real tDPD_us = initial_time;

  /** Deep Power Exit CE# low set up time  */
  real tXDPD_us = initial_time;

  /** Deep Power Exit CE# low pulsewidth */
  real tXPDPD_ns = initial_time;

  /** Minimum Row Boundary Crossing Wait Time */
  real tRBXwait_min_ns = initial_time;

  /** Maximum Row Boundary Crossing Wait Time */
  real tRBXwait_max_ns = initial_time;

  /** Row Boundary Crossing Wait Time */
  real tRBXwait_ns = initial_time;

  /** DQS output access time from CLK */
  real tDQSCK_ns = initial_time;

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

  /** Assign refernce of spi_mem_configuration object */
  extern virtual function void set_timing_cfg(svt_spi_mem_configuration cfg);

  /** Randomize all timing parameters in between declared range */
  extern virtual function void set_timing_params();

  /** Randomize tRBXwait timing parameter in between declared range*/
  extern virtual function void randomize_output_disable_time_ns();

  /** Randomize tXPS timing parameter in between declared range*/
  extern virtual function void randomize_tXPHS_ns();

  /** Randomize tRBXwait timing parameter in between declared range*/
  extern virtual function void randomize_tRBXwait_ns();

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
  `svt_vmm_data_new(svt_spi_flash_aps_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_aps_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_aps_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_aps_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_aps_ac_configuration.
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
  //extern virtual function int get_clk_parameter_index(svt_spi_types::flash_command_enum flash_command);
  

  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_flash_aps_ac_configuration)
  `vmm_class_factory(svt_spi_flash_aps_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
axJ7vg2XLKqMoiN1oRmzloouh05ijB+U8IexxzvmhuBKR9s27APxFT+zMjVvk/1x
BroT0X44FTBlXOnTRj+imb92gJxZrGwWa8cJCHOlknQuZ16jo2bhLUijntz35fPY
PAom6hoBdh7cNWyghf3RSPmrp6i70uwAaPg0JO9VdG8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 745       )
eJyD8+8dLtGf1hSfx2iIRidiiRuNOwWVCTqknenCxM+VEhItBUbODfl0ebSHypAu
e0vJMCsT3eICo4Mz41hwjNv3wBztzMMggAnqwh5NVyzvVD94fpOpJQQnoPJyxnjU
t0n2EmgId1aPvpfvfCuVAqmZ/PghXjNup2AD4Z7OuAgrVWalhItx0F97Hx9jPI4h
GvkLbDK0sS3JNb8ZneGtHFMkPr+XQ74hR7QPVJglvuAU930qGnSDIQ8uWPjhVwO+
S+SMqg42TNXErukfXKJHXnm7xxotMxkjdJRkTS/VPiyANUEKhyJlDwCvvrVDxh6w
8gChKnDVFSPSY7ZfPV42XZY0tCEJMm7v8U0UTtycXkBwSbc/MYL9Wt5V/Z8f6q+2
4YNKsRCpyZMLFp/TvGMduISRQ6wrykwH2c8EoBfY/xmneowi5aa69h+o5IGh07oI
2pkUdIJ2/zvmcyH6hyJzFqF4M8pbh1R378N5mwqN47YMpOJfg9Wgsw9LVbNZRbZg
oZKy9aThNtypcsPvpbH1hanAbuErcYUuTtEwfwr6qfVhhVpD179h1/RlNQzzqqlr
QpypF7vEc8Pz/gsAKEFQ0sxRe/Fh4slDTupl1AEWkX4eITozNkiYEqbP3bT8jVQA
/LDCRDLN9JqzTX68CGnTmQW06FBtM2dyEz35nw5Kw0rl6eZOqRujtEHJB6v3Rfjp
Bg92GJxeyOx1zE/H89U7MF93wCDqezLsd8SqZqEvWd7cPrOzArn0CjnzD58Ma+ak
XnrgZu/c3xOWI4BuPtTGaPVVnySi3JqMik5rKz3TLNcKjkKQMjtXWY/tnaj7Z4uf
TN1Wkt3radkKGBpzzXG/ypvzNfyK6BdiRlQMeRLT36QboeFabM2udOC95hhgO3eD
AXMUCcav9vTqodlkAPoNhHmJ+hE2jNeYBYZM2gpZHx6AxknqcQz7z67Yr4HhOn07
o2EoxNMUrwTGZUFI/9dCuLmblevKJ+lb8TS3gm1SYao=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QdDu34lq8NEtrrQ2lYhbAooOLM0oFnaCN6yiKYUMf+Z40XuMgleWnknVwh1TLbUX
60KdW8RipncXxq4N7wUX9rWgreB81DLc3NvbAcX3O7LCEZKgU/3zHP16O0Ct1k3n
FYihhyp2LSgpreDEfZ7gB6JI9qviaO7YGo2jdASm4Y8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 31857     )
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
qG06WV5h+w/Lx2h4v8oqJw==
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_APS_AC_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Q+E7pdOJR6HWe9r+WPcA8LxuNYbrhwhMe7WCkVdkYTlkKnOz7+6EfFJG8CS08sdp
ceaSkUKlEzAz4tTQUAfiQnKrlq70oVqxaqKx2ZeipHscfQ4a5JFgCKDVB+xaSHGG
SVkE7hsKcuH/KVFVrWGoefeYTHtto44poJOKqlH83Qo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 31940     )
HzwY1fo2pPOiBZMarCjlrJf85hGIDrw74Kt6+g5K1Z51oMDvGTnoofeGEArW0B6G
bMp3vpf7T/7Tc3AgiP8Pbu9JATOwkEnoEk1VHr/ug7vRPBBF4SduL8EL2u4BzNtE
`pragma protect end_protected
