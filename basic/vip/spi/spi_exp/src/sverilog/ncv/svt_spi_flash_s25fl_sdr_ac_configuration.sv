
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
+m/OSzK0LdZ4e//sxhhLrwuMTyX+80wDuYbKYaaVmPaK9dGdB6bPLjbwY3OP2gVj
QXS7A0ZoUfKsLssua6TY0zGI5HaLNrS4S3Q5htRH7gSX3oUOgSTAt9cohiDJsfSA
ld/jvh6V1tdey6GdC6ML64u0m7b9WMhTyCBC6sLY7v+uyM+0gdPDlA==
//pragma protect end_key_block
//pragma protect digest_block
zfmdflu9K7t6nlAC5N3OGGTbK/4=
//pragma protect end_digest_block
//pragma protect data_block
hVPXerY4o63NEy0MlTtsMdv30z742B12THMg+lLdEWAvEQCLwTeiJBsfI5HSnw00
uwKTh33Qycmn7reEeMEslFiFCjsnZRbATkZTfAu3t1e5AGMrxCBlcrWn63HykEPf
in9I/sqnbq66xCvUCTvJl9SG8FgqQIE7p/KOui6F8aArIzz1C9r0bRnHwN8xI/ig
4SX/+1vB4GfiLWgfxnzyKEH9tCW8UWNSuPmFfn1KlNZHo5AAgcwzcCig5gZTpdW6
BBz6JHyGQPc8LJOgx5ZkFt188PPNPDzbNeQL08ShDoqjM5guE5Qo5MzWncRQ3N4u
vPcQVQnDfWcc5MD4wBnr9GTzORObM2bUBot2I9HUSyLXPrXv9izAIbwAkXLd6bw4
zQZnsj04hmR9euASBe6O3cvfxkvbGTeCExRWnbvAcf2rcT+TyQukef0Yzbmxjo+u
SIdmTBSXe5QMmrD1tXTXII4VF6O6U5OnTeUAlD+q1xVb6J6aZucL2HCd7SanXVeF
cFGfCnR2m4w/ZiGFRE10ViorxNjQSQ8fdj95DMVqteqaw+qa6FieU7DaM/gwBrY3
fni4LOUZ0pkmetspLAk8PbBCxQ9yBE8qqfRSa98t/0gEV+DS4PzBLXQXDS6tMXSy
Gji7t3Qw3s3Q3w5S4yZV5W672xVVymf3qfhDYRi+L7yBA/B0MTJfunLhjNcTZXql
CrwLJ0eduznTHmwX806g2QRgvkUjtCv+dyJDTwmBctgc0AcnAaTQ0SzOp9JOm5M+
UFf3DPnqxer3bUxmhq85rUEdczQyqyHJjFsOlRmENtjslF13iT6NW1gYIoB979iG
jh2wg4d+PhwbDsVMY57px7DY0R2zcKq9meUycLQi8tNiU3m2YONFG+4fXGp/h+QP
kNWjHrfq13W/3IRkmXrX7srgXzSJnmQFTVPZM8GOWU8KV3UydtO6kvO2KUXwe6jK
JrY2P0V2HzLNa9HbyWeVOjFVqRsAVMqlO1QnRHco+7cOjlwBtVOJ7f9SwPlT9otY
AaLHDUSq0onSuarg41b2wWD5aucT9OOGzrBBX/yNbuuOIgaO2ZwJZe5G6AysKTaF
M6+NFmQwIWPveCM2jWM9DxYF1GH4LxwCVJDx31ENYGwe1AqqTyMoSTfpUNrClg90
H0Sy+qa+kFi0b0Br8CeAFJJFKegj74MP75i7US6gCPgymd+IMP9PUNwl38LNYTFH
UJFQmm7kwh4ar4IpUjaAs18wzPajqSurNXvExQ7S3Rg=
//pragma protect end_data_block
//pragma protect digest_block
w5pd1FDCAyfXS6dxBnH32uZrA00=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
9RaMg0XpbLAsHhUsMBuTl6HVmjDoS4RAtz1R0iKzfXV28irDYgsmerjmG8wsMASN
+j1xxYGW7t64HgnEKQ5zFkNxp4E6W0bVM9Io/kGu2Yo9FInmv25rOHhHuP6uKvVF
ONJeFPY+y/oTz5+Uv1ZW7otqRVtTNaXv0kZD0iNKQou4n0KiS4p+Rw==
//pragma protect end_key_block
//pragma protect digest_block
81wi1SxK6+VN+cGLCvUAvVAeJnQ=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
6nnLWDkMdau9b2AlLnmp9uLtrzU=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_S25FL_SDR_AC_CONFIGURATION_SV
