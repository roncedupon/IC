
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
QOQWq0HUI/SCu8JanvqYT0WOzEw2xOxx1We33+2HDFjQ7UI0p6G+DWVryW5uPCsX
v0+SzICA7XmOy0z4dUXLfFLVIIeGIzqGZQZBHj9D5NIZT8Qv5P0wKDHZvfp2vB85
sCY2mDW0ZSrrcLzopKw18lMX9n6pm5s684VkPj3sRJ0wX0VQe2VvSw==
//pragma protect end_key_block
//pragma protect digest_block
s62COKkXHlYctN9R2DpQs/LBqoQ=
//pragma protect end_digest_block
//pragma protect data_block
2nVgqbxy5mydWlaA1RDoe+OvdiegsWuOyYa993kYYHLV/DaPfF7QtphpfmfrXC2w
AU1gIy9iEdrYvsM5LEJFHnEubICSKzVQDFB5f/s6qIra/5TW1VD1DiqwlDMxv7yI
ULuuuAX4MxBuXcNPGw4HOlRh4Jp22vmMku5IRGPVVk2TLG89wy0j33HS1LwvRvoq
yhzD5brJLjsAX3ZZ4cGEiPNyxR00clek1iEPBH8wKdUbGDpHQK3QvvPd7Pwsbux2
/ffQ4bY54bvZZ6hARoAEi4qPlJRNLYpw3PN+1MQNvDSEIOfy48sS4DiiqX71c/vU
+fklXEu1G3a7Xw0NAsdBt5QEkLrEU9SyjUkaPhNafkx8+0eN2kPrPgpvT8e1QdSG
XD3/FfnKyzu9xQvN7NyweT4KQvkIbhn7V8/zv0O+BCh1lnplXmQ27yiJtWE43Cec
DPy2MYaV19fT3u1PO8EsATh6h/+aW0P5am65pzJPBmBZyxbezQC6CikgeetOD9ta
cU+yBmoHGW+YXDHi6kXUQO+fVCMDrv7mzgvTIy7HREKGAItJCZ5x80QCa9mkOyy/
Ogk7w762ovz1jFlXcqlmfKRk0iUBHeHsIWy36Nx83iov1dkwy00ynwrs14+pwWux
uCrhHW4TWcYZXAo+KaP+Q8SkgsaUJ7eLeyglX24Uuh0xGOCoua0c05F44/Ugyy/A
0AVl+zRhSWNWMsEhadVw2kkyelft8/PvVUY6d4A94ikg3pnSJpM4YjEbafGdh6wc
ApAwze2EIFgPPh55oO3657eRJTiD+BfIoCosBfkstOlORD4QXHn/N0Dz9Mtae3nA
IDM0i2eWBOFni5vqFB9dxpn1A3kxCPJMLPGgeUNkgOKT2kVGsJSC9hvoWzp7lFqR
43JiH67lgKsOYxEBEiUE2S/Gm4ra+mnntBvvgAVW8yeVa1F0pWXblV0KMDtt8sJi
nSP6oUEKdC0A+zAqg3LIwbreDREwTWJJsDhWtoS5D/W3uqFyA+hGwHaVeYhrAZZR
o1Svk31rzkGIr6SvaL5bSSFk7v8efXfx1obdLN49/Ktm56dyA99I9xrfLaxI/J1F
TRIvaS273B8J1vWekeenyOA5Bv4W8TlArjgO3+79sF915QQ6750awVLjWL6mZ2C2
nxeYbEEcOYPPlglMpWxsmDHQSCvLQ8OZ2QxaKCNvc5Er01R67db7Z3HSFkHXK/8h
qg4jTeNBxOjjEAPVOQyMJQ==
//pragma protect end_data_block
//pragma protect digest_block
tnUfuhBxiSgENBpDw+mHujC3Sjk=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
KzLnH+aHntGG+n7UqnivL4aSu16VYd9bLu5TfXiGw+5ioKuByIUL57EOIQmcQJXs
7KHgFHPJezIm5qWRivV7gEOgs5G+8il+QQj2rXPLnDRH7uDz/POFA2KYkuajOTLv
2deTWypM2SLcO5Dry5LUyF5gylTR8bnx3YMnSkBPs5gW6jCkcwC10A==
//pragma protect end_key_block
//pragma protect digest_block
LHDgle/H0ddFIgO900UM0936TkI=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
cz0bc7GMVYJaqcwc0BS1C2QkzsI=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_W25Q_AC_CONFIGURATION_SV
