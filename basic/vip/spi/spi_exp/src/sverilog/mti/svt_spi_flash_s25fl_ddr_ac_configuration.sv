
`ifndef GUARD_SVT_SPI_FLASH_S25FL_DDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_S25FL_DDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;
// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Spansion S25FL family in DDR mode.
 */
class svt_spi_flash_s25fl_ddr_ac_configuration extends svt_configuration;

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
  real tCH_ns = initial_time;

  /**
   * Minimum Clock Low pulse width durtaion.
   */ 
  real tCL_ns = initial_time;

  /**
   * Minimum Duration in ns for which Slave Select must be deasserted in
   * between Two Instruction sequence 
   */ 
  real tCS_ns = initial_time;

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
  `svt_vmm_data_new(svt_spi_flash_s25fl_ddr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_s25fl_ddr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_s25fl_ddr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_s25fl_ddr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_s25fl_ddr_ac_configuration.
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
  `vmm_typename(svt_spi_flash_s25fl_ddr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_s25fl_ddr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
OMZqOOB93weJzbKtEJl7PKCEKI8tgB+jy6TEwBFeoVqbmfmtTrS9kbqZQpA3/Dxq
DHGC5tVinEgq4tjNjyjk2U2GwtZZD1fcHUSZg91tUGm4E5RuIMm7tX6xIQFqTdqY
Qm/K2h2l+dWrXqKEZvsQC0++y++qWV4nHLpsGsA24KY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 769       )
64K7SIRaHCUQk7cawMgxcS44fEYfGU0iFFzxAZdHiKnz63cMbBlE47Nv1f7MI4mQ
EW4pCdJFCAKtrNsWeF1vrSGmLkQ8KEcIdhn7l+1LNuv23EmeQlnP4lWoedGNkk+j
ChANp8N4dw/ne/KBHPxyQ52zfjpihqHDRSKe2caX//tewyAEYnzbrxh0+BVRklEW
HDeqGAv5nOrSzJee8MhDufmxYlZmyO+URiqSL1FiYYNO4Oz2hF6EC7xyAKuU7Dxz
2CCu2YPQIqnbmrN+ajegUmFofLSvcYKvwXxHWR2AyovCHaE03hm6bh2zubQwLzXa
xtA9RSF6sgoZb0HnwgpCQ6DpyArGlfxoMqot51hs/IUWI7mPay/hcnfkgbz/uJZT
gwVhk/bYMReNatYz65jwIU4fP1CzFlWVXY3c6lUO4wLVCqX7PCzKqdZvL1G1dz1i
nwvqzxzoUjeY8zRNZNvIoLZNgX7JlWO6iy9gU4kpgywATe7TzVjzTeroDWKpu5gV
em43GpxZl7z3bWCAzlnQ9QinQb7uCr94SKAkAbwu2a8dvDNXqRufaG8nwhr2NGo2
xwYJeLMm2DKjDABlypHGpBei3Gsn0n2Za3ocfpJok6DvLMBM6WEriZLbAOvffUu/
pNmHWKKN2L5tX1ZkZuVgPNI91mC4Y526/zebap4VhU0tO7mbJv8gQ1hpdxQvac6X
8u9UWKu4n3UXSiPZgL/Yl4IIp+dwLRfEulSC94bujqVerRDPJ9HC5EwFwyVH8+Vg
+V/dqDO0v/mT4KvSNfv3oAlTU9S7jj8/9ekZuAv2CkDJsCwF29HFhLzyimtkSNfE
KiV3QGMN8NB9MR4STE4+CZGuI4OqPhp1SXAjPwpujPfaeRBiA1pfk2o4OZmjGBCh
8Aj0VEtF0vf2qCmgYzePappZYd7voCvOzOu1s1CzvlBt6OVaA8OrrnyALbPbjdWP
JzOkjpzw482hV+Zr79Og3/wJgtWKhzDxJoKSXBwaGfDfstyImul3mzNYSsTzKsyp
ggaI+5AiVlV+qcRz/JbnRQ==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
PoU7CxBNSF+5vfizi0u4LBntNkBDS3LFbkOMzK+fDWVPKpxSRlw1s/d9odobIrxz
kPLBqK9tT9WpHg2N4p/KjnSgaDGHN6UkQrz3IyIH58kItQZrCwkUz38tKEEdoo/g
AXDsCJIa1/F5X+tyj10+1+WhPCFYF2tlY9qmMlFq+qg=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 19245     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_S25FL_DDR_AC_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
EU2uIH+0ktPzQOfLRVW4M3ZLjV47roWy1OoiRy9+HcGbNzemD8dtLKkvVRMtk+w6
PhzsLd/YTpJ50/EBKf9XfarxaEuy0fjz+QI9BcQshctdQ9ZyKmz98AWsj5H/ou1x
eduUjAnMFNinqepz0PNHHp2BgEe2idwelbjYumm/cwE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 19328     )
Q5zFnsOAwkvH4EUE5nyzH4CL10ldLZac5bzOwsTjq51kziAmzLxDawwu3o2XEapU
SmAxhS2tlZ9Mz8YsQGhcNkxZrVispH1Oj6DX3yD0ksn6YO4mAaynFLtbTlz7fEQ0
`pragma protect end_protected
