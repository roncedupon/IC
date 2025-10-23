
`ifndef GUARD_SVT_SPI_FLASH_S25FS_DDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_S25FS_DDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Spansion S25FS family in DDR mode.
 */
class svt_spi_flash_s25fs_ddr_ac_configuration extends svt_configuration;

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
   * Minimum Clock High/Low pulse time for Fast READ Command (DDR QUAD I/O) command
   */ 
  real tCH_Fast_Read_DDR_QUAD_IO_ns[];

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
   * Data in Setup time
   */
  real tSU_ns = initial_time;

  /**
   * Data in Hold time
   */
  real tHD_ns = initial_time;

  /**
   * Output Disable time
   */ 
  real tDIS_ns[];

  /**
   * Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_ns[];

  /**
   * Min Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_min_ns[];

  /**
   * Max Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_max_ns[];

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
  `svt_vmm_data_new(svt_spi_flash_s25fs_ddr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_s25fs_ddr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_s25fs_ddr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_s25fs_ddr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_s25fs_ddr_ac_configuration.
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
  `vmm_typename(svt_spi_flash_s25fs_ddr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_s25fs_ddr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Ai/51cazVrui05zbzYzoG1ldjApW8KMkkQzFAXxKWiw2jcfg2PMyZMyBF2uoy8BZ
U+1gw5/H9IATn8QZls8Xm5FQ8X+e/0S3yOjy8gZmxDFlX6rPgQ6Kxzg96cvtJXQI
c2la8WBBEl+gngWoyC9N1enIQcka/1ZLEYI4MHxwOP78e8eSKmqiEg==
//pragma protect end_key_block
//pragma protect digest_block
6fSCMTt4wAf1d5rEFDNiO4uqSDo=
//pragma protect end_digest_block
//pragma protect data_block
xtkQBIZfiXuGycullRDBVNqm243IkgBjIbt0hIKK+w4aZYl+xbPgnJ3rdjt5cpW/
UK9YxlMPDGE9YkhlQphN0tc+NMEXwK/mnsj5Ji3HP7jA0/h6dboiPyFKUjihJsGc
Dv3eSghMw7z510254k66UsJG4ImX+7hTCoFCU9IZpIjhFCTCT33nfb5TQiI9e+G+
ZKaJzqDVhQ6JCuMkYxXtItYCTibGu4pwZZeigZqhwYH7g8FsFznSTSNEw9t+Z07h
5dw7w4DwnhcxVKdqj7JptUU8fJ1WFX2o6KvNmR8MhkGdmU8MKqRawJoHjoCW9xZL
Ozsx4RV0LLW9XS8VQ9LJTgkjb5HaR61tqGLAwCZ1OOESOt/0szLGJWV+2+bNv+Gr
TuXJUy8bp7Z8BjxILJeltMrH3YhH+ObMxGIJOarqcZjlLtt4sc/uK5ol2D7hn4Y0
TYO2Ts5OQWmJA14kW2XWSPTXz70X7k98tSPmwU+4iHBBKR8K5oj3qbLVoy4PPrM1
gTACsg0cA+1IiAcGD63+G+1tiwf3JjAqh2DP0qREii/hZky7YElP96cFkOaHkuVY
QQrSGDLEGJuVNd3iQ8yPOsB8E6Jt3+zyZhv51qZKO6e0yTNPomNX9XMpEBUNDRac
aIbMgTAGj1g5SkCs9fU7ykOViD50ovnl1+GBCjgL3vfcM90JNUCi79Zq7rd017fP
7ep7AwNFw3I3M+inuO07/x3un3k2oL7gaiwHAEGGrXduzp/k4s451k/AncP3c9TU
Z4D5PmsYlbR6fi6z6sP4IUup7QfQGBBkMf9yUssGcdkL3Tv7InE2HsbepN7PePAF
UOEJLxS8mNO3nXj1im7ov6s0bo4T12kmUHZIZA/+dAF8fR2Tkuux1bTNvSm2TGeG
5f/i535FdmPOLRbFQRv+GcVGE0mH6S1jP/6nB8X96EweQOgWdKzffeTD+X37S2pX
s2SvberkIa72xiz0N0+n/qoINgaAc6URlJpLSryuzkdtoLsEggMSwyF12Ut0tsDs
jincrcuZGIhMTHjuNTIlz7usFxiS+aidTxJTvCrH+YDIjyocvD0s7FmGU3lIs9Va
PGH9HLEVlZ8uNPw6BJlU7sPTu7RBjWr2WS1whjyhJQGV3bh4uVReo2J1cY2EVcrQ
v6v0cUEil26PlCJFyqhNC6UR0RGCuYRCis4etCX+X5N3nIf2MO3zjhtdW9SdhQMp
ve9UofIas9MQ49FS701SvA2Z1nia/ia4XU9HfSu2260=
//pragma protect end_data_block
//pragma protect digest_block
sBPnfaUeXL6/2/0EYviozuplNcQ=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
4TR75T6n573yPxTMV/FkEwoTREk93v7ArKBSw/YiawjUouAPIyusTYVNTg66fVwt
UKP3t9TmqOyAnhrV89HoaBLOY+Is76lEWeF7Qnb1ptkL/s8KF3xoKkdyhn88vbs4
LFkpDGt36BCxCISZle8BWaRDdk8ZPRx+fgO+pRFAGNryXE8qw7scXA==
//pragma protect end_key_block
//pragma protect digest_block
HV43BhN+E0KAJDhw4kApV9QRZzE=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
9prtSZA5uOK0r9N3D2pcXzLgeV8=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_S25FS_DDR_AC_CONFIGURATION_SV
