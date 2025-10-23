
`ifndef GUARD_SVT_SPI_FLASH_ATXP_XSPI_DDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_ATXP_XSPI_DDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;
// =============================================================================
/**
 * This is the AC Characteristics Timing Check Class for xSPI Flash based 
 * Adesto ATXP device family in DDR mode.
 */
class svt_spi_flash_atxp_xSPI_ddr_ac_configuration extends svt_configuration;

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
  real tCH_ns;

  /**
   * Minimum Clock Low pulse width duration.
   */ 
  real tCL_ns;

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command in Quad DTR Protocol
   */ 
  real tPeriod_Fast_Read_QUAD_DTR_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command in Octal DTR Protocol
   */ 
  real tPeriod_Fast_Read_OCTAL_DTR_ns[];

  /**
   * Minimum Clock High/Low pulse time for Burst Read with Wrap command in Quad DTR Protocol
   */ 
  real tPeriod_Burst_Read_QUAD_DTR_ns[];

  /**
   * Minimum Clock High/Low pulse time for Burst Read with Wrap command in OCTAL DTR Protocol
   */ 
  real tPeriod_Burst_Read_OCTAL_DTR_ns[];

  /**
   * Minimum Clock high pulse width duration.
   */ 
  real tPeriod_ns;

  /**
   * Minimum Duration in ns for which Slave Select must be deasserted in
   * between Two Instruction sequence 
   */
  real tCSH_ns[];

  /**
   * CS# Low Active Setup time
   */ 
  real tCSLS_ns[];

  /**
   * CS# High Non Active Hold time
   */ 
  real tCSHS_ns[];

  /**
   * CS# Low Active Hold time
   */ 
  real tCSLH_ns[];

  /**
   * CS# Hugh Not Active Setup time
   */ 
  real tCSh_ns[];

  /**
   * Data in Setup time
   */
  real tISU_ns = initial_time;

  /**
   * Data in Hold time
   */
  real tIH_ns = initial_time;

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

  /** DS output active time from CLK */
  real tCSLDS_ns = initial_time;

  /** DS output inactive time from CLK */
  real tDSLCSH_ns = initial_time;

  /**
   * DQS to CLK delay
   */
  real tRPRE_ns = initial_time;

  /**
   * DQS to CLK delay
   */
  real tDSMPW_ns = initial_time;

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
  `svt_vmm_data_new(svt_spi_flash_atxp_xSPI_ddr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_atxp_xSPI_ddr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_atxp_xSPI_ddr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_atxp_xSPI_ddr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_atxp_xSPI_ddr_ac_configuration.
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
  `vmm_typename(svt_spi_flash_atxp_xSPI_ddr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_atxp_xSPI_ddr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
T4H7knjkOXQUtCKRc+XdZz8uitcLZg05OdtKmWfVg9cw/m0dox/vpPX+kZKA2U6H
yKAUhINsKbNiOMyWit/p3OrrNPg//mxSLdAA6q2cDVB1pcEvVNps7lkDL7IQnSqj
YYx620E2csa2HmyzNLOC9dI4PKm+oY9T4Ihfi7uaYfM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 785       )
FlVWnpplrKjIu/3O7pZR3gzewRbWdpG8Nfz1hwSiIpAuMQDA59PrfU4pJLRnN3dB
A7IHXxSyEPhhew7eeZME2oLUd3bhrj2sY+lQwDK+J5rUEaQnCtEJeaA+r68msGa+
laxWPTMgY33D42Ol5OsIYGMTaz4madXIywo43OKbpHcILvP08Cowo4O6uVgGDhY5
oIkS/2BzyOY6ULihVBuDOdXsjg6y5ud0dHUua1jVKL3ccaU9KKbjxxVVvcoaakiW
tjKAQyM9BUmaxqInb0GUYtVeIrIjdNF3lb5NZCw++5F9KHkyYBaFKe0xH9vj2hsH
5mL24bGp9KmsqwfBK4gMQFqSMDriW4EbZPml7W2bdvqx+QUZPhM+sfuVbupE//N+
MFXEm5ZGR2qH1i3tV2YZhr6c7lbsZ6vm16X4hZ5GHViJ0j6K2zd88h1GAe54JlpT
uanvPK83RpTfEN8cmd8NMFmaoJEI6i0HDqXmfjyP2QOWlE6vWaHslLqYSbzBew/i
SP4Gfv+6kUINSrb4cYDkucKRq+8tXrtqadq7LP8uUrz0KS0ykYD6seUFW0CZXDqD
vcxCE3Z3/pdKKmhIiQw9pWxCmUI/kRBFzLXp7oWmZrRV+3SgOuAbSgIf0cz1z0Yd
9uAIJLGGaath76PBQSoAhuBEpUZNoeygWknoHJ1bf93EnYPtFwEiTzUTWcwOtaZj
mHRE3OKse6lzIY9Tny76WEKum/m9UZjoj3RhXM4gqWva3Ke7GsdUvsAMkDw1NkBc
i8aTD0febMPzPkwdzGs1WxCKe5scBfZMgdIc9R3ok8r8hY49IHsF13U19SOa+LYL
4Q9DDorUuQD4S0Eqlz3jzigF2lIqq9cal0Oluc7hlWqNII8FhxVFC9dzjkX6cXYc
+fsigMDEoIO2e5KeCPycU/h+MZsMTXY6qy8ZFRE9OyR0SIOPjg6yTBYSMYR7IbAL
N8ut4pGlVrULG730JWa/tdSd8Szpwwf5BYOOHwZLdKuk4uNYxAFUG7GoQ2mZj0UR
k5VganF/YKr6fbPOX2CqmD/vzzxKsuruGxtuIp/FVrg=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
V4v/UTVa6WiRpCYePANHdJiVNX+wdcbwv2prEyspErH46vFhUByTSgzZYVnWUI8H
CXlnJLDULBu7ZPsF0Z7/Gs+8fkJxfCIYh8dCITNSWfwE9DX/PaktB9V51qzA6Knp
h0UF86H41I4Gnb1SnS0tcW6md1JypijmiGrtW7Vki6g=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 27305     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_ATXP_XSPI_DDR_AC_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
UrEVp1Z6cP7uIwubESixtJzTJL4ApK2JBWEkoCfakwDgKQsQGlYZiVFGGNx+E5Z4
PQPkwkYM4N8PblEmyZHTLXTuK8nA8qwsXTDY9ywMgNM7kVKXVh8dFvny+37AjG92
NW1I9AAzdDMlCjYX1ffBFYwQOtw5V8dt+IIHA8FYNMA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 27388     )
WqhPSkAEUGMIkwCAjCbE2VvoMuo3LxUZG4uql2UNy3Ue/Pg2d74fdr3qxvsSR0EK
SfCUlw6kXwIOq8DNnh/5clc68w/dY70rbRUxJ5V56niZHJ4x0bX4oxoOWjiyJpwj
`pragma protect end_protected
