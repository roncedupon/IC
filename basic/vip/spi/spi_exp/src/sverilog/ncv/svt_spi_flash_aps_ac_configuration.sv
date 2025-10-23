
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
U9AsGt019hebYmEuKLQ4zYBTcvu9B4eiaCCM7O7lpQeEEJBLNR7PXdml/MLF+J3C
a7SLiuMkQikVP6fBHGXFjzEJzM8D+f9wtr42kM0Sk9D6GobUCJbMSvlHUoGtP60d
x+J/b5bJhlNfXgUKsNeJI9N3UV2ch4R0eUZHk5Lxpfl5ZHwFyVbdyg==
//pragma protect end_key_block
//pragma protect digest_block
iDPNOHlxepwdwiJNeXXnFmrRMak=
//pragma protect end_digest_block
//pragma protect data_block
9e9CkE1etiDbZ5tCEXVTS4v1AT6V8xBC7ACzN56RRSIhLXuJciQGHDKAPCXciZAF
0dAyNZh28OP/5mn0EBof2XWHw+wBWsjqv5vXrxJm4r3ip82cnT8VufgLFzLAi6EB
lJgzBBc6xNFfN/iYdyD53Lh7WTlj6gCtRiETZSBWzH54E4rX2liSxIuPhL/QFs69
FLQI0rERWo8TmEM887My58pB4yzvRb3+NfaBXe7Z6C/Eo6WNVzYifsFS8sLKz2jl
s/CVAgRkSaIz3cOPfQmWH+NRIWDvh7qSRVsSzFD7ognpS5eGhr1r/wwNxWcPOtcs
QyAadlQT+Ri4sIeYl0vjpPHZKv8Bt13tFx9mBOsDZm1tH/qu7KPakG8md5dIJyFO
B8pcRfNuOlGUthxV/qaYtRZwki8qSOQyNRezFpVhaS6RemDlK0EQYj4epA3z19y8
Pc/3RndodEyHaoVW8NIrs2LlQohEdqNS+oMccAjLHaaZvLY3/0VuP80PSknqBvDi
3uWumgf+9sWD8n+2UPZm8Eu73jg4oGGqPhNBLeVTLdNqlhgO+w6VYMfyjxr5myJi
fTczv3gTApIJ8MpV1VYGGSH09iColcFT/zU1SOUkHQstVN/+UOMJZU/EfycBBCLS
OiLxzq36ak1WcLTJwAI6dW5S/nvJvkUSsxgpHV1D2yiOKKKLNTfUjbNHYL63N03e
VYsJOlnyxxi//7rFkA+akpw8Yu1M+JwGVkulFhIYqXbr/tyY/wLLlzkr9wQGhg9P
ZbCIOTDBwzHl64x9na0mFa8inLjKZYRUrXTllGDQtE5PQHSw0o2tumIohJV/JeyB
cL8nYxOGZNFdBX17yRltS5wIoeHhNG3Znblocp8jOg0v8vYp+N5Bg0UZz/LhygSV
0kOexfvLZ90Uk7OOOVyc3HjhN2MGw5jNxlSACuB09px4JRtsLwXCzf+PPwDl55ju
+oHAcJiKdTymKvV8zb8k0q1Qyhlai1n05jEcz5GiIF8DRlCLf/kA9kLBIIP8+t1L
f33Cf8z4MzzCPy0x+Xlrs0By1gcJSB7TG8R9YjE2Dit9treptSMdXuaUZnAaGfHf
L7onyNZJ6++HJDQTMbQV542CRiLyD6own89gm4ZppIcJlIfKf6XxExUvxtbCQPjr
hvw+ZjX2lecwtqsmG0SGNs3d+3Bhp/Wf9QgeaX2kZIZn7pXPYBy5T9nKHOtC3VQc

//pragma protect end_data_block
//pragma protect digest_block
AVkM4hhDBtiHy43Fy4P9GfFpQqY=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
2Bz0yGOre9Yz4woytFMVLDWK+6A0H1xrEcbLtMUCF7ApoyYTD6QDr2Y97rjJDorI
YGeNjI4scii4TLGCdFd39UHG/4qDa0k+N7x0+X/6IQRHUeRgjLSqkSq65Sfs9Nr1
Mvel2eioh+e8KmgbRNxvXboheFxKQIKdRqt1SDftvxgrJmxTm98FQg==
//pragma protect end_key_block
//pragma protect digest_block
Uk/VzcHrjHztZwpWR65V1SKS3K0=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
4pOhEbhUCqwnHWZ6+fybvhfquKQ=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_APS_AC_CONFIGURATION_SV
