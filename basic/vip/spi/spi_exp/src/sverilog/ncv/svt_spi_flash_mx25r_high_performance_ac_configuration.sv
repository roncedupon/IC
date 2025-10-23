
`ifndef GUARD_SVT_SPI_FLASH_MX25R_HIGH_PERFORMANCE_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MX25R_HIGH_PERFORMANCE_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Macronix MX25R device family in High Performance mode.
 */
class svt_spi_flash_mx25r_high_performance_ac_configuration extends svt_configuration;

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
   * Minimum Clock High pulse width duration.
   */ 
  real tCH_ns[];

  /**
   * Minimum Clock Low pulse width duration.
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
  `svt_vmm_data_new(svt_spi_flash_mx25r_high_performance_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_mx25r_high_performance_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mx25r_high_performance_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mx25r_high_performance_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_mx25r_high_performance_ac_configuration.
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
  `vmm_typename(svt_spi_flash_mx25r_high_performance_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mx25r_high_performance_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
mvTstRRZ88ib4Glf8xDckMSAX9cbjC6ZmzDydqEpQaBiCvy1mVgJo54K470ezBdi
Eb04wCOoAt2KyzweysJ+oqPz+ODNjsUDODXi1RYtdhTzgIufFb+ONJXmvib3AXzx
x1PuLPdKc0AKJe6l106k/jS5Og/uxp75y9sZ/LvskjanBsi/z8r2aQ==
//pragma protect end_key_block
//pragma protect digest_block
XjjL3yFvPY6hyh9ibiRb5xVupck=
//pragma protect end_digest_block
//pragma protect data_block
t0F1m8sx/llmoYa9vWHAW0IQM1cmslAk9EI7CygCnQYMw1lu1FDqo6TN/1PlWgh9
FUxh2TRKkb2wtxeTNjO+55fYclHK8vlszZ67hSJ37gZW1vxApYkwnUtVuPNGTKob
gM6m5ZlkOHFqtwyIuufmDMMjVHCP7k4PsFE+2bcEFltCZJB9bj7BluAjgrUygm/A
k9d7rRJeXJ1/ExbZXgcgLLi0M6nWqw7cBZ1nQMxHcbRCkL8aJtrarUrJSrIR1jm4
TZXrWm34yX+irJU2FRtREbAg+9wFaVic9Nxi4g1hfhYLkb9GUUGfCsmPciXXfCEC
XFYPtzzY5V5MBSm3qOqEY5Kr2kk0gIj1hYdbJAyuCQH8RkyH0vaLzfq9CbrSbw3i
Zywrmep3W+6s5gBXZkL8Qhx/Z0TWQOcDZfZtvWHglFbv5coAUxJuYeZXM9peyky9
Tet4nHZdQhE7KIA1fZLUKeoQb9MVtYvicQl5j8uMNRiZJCFwryrhcg6EYwRxnW+f
UTz68kClTxtW8i9W4LudXijtSCmGoIu64uR8XIlxeiLHdksQwmtQmM/8fS2f0d9B
AeM8tZffOalOhgqfuImbiCyLGF/haj8s1VqHG7E4hkbNlyjSpRampppAg5V35nPm
qPc5bqoJXbb/JnSzJtTBcQ6SvW2yH9C43NwKOoRuHvX+GCga5j5ghoqYkEDVbGku
MemWDR2d0IecbQsBsflvfQ+/7ojo5R8KwtUOQZNaD0h7lb52d7Zpde/aEEZpAts0
ooN9I3pbuvad8WBeqfMoR5Z3AO824fAP6jeOz8iOURdxTVVewenRs4AL5kmR7rWX
GCNU6s97BEEuX7bRE/hD1FlGqhrxTDTpVNUdSMPVm6zC3UT7LYbvs/kCKEBlb+PI
cWiCohQy83Y4g6HQjcdBGVXB+jlNcVo1ErluirxLuvdZFjjdR7Fb3bR+lh2/C8+3
Z/uNkoCnqeK6d9vsJMFXCsU1CLjzN4sMyDTl6G3LCNJUXBAw7+tfG6hY+/sfrb7Z
kM+VhOCvhWPQCujn6o5uYvHw5HsTO9i/faUD2wO1WcLAuCtAnOjXy6Fo24ws85fU
SVC0E8NVR1/JwT68UxJivtcKi50M3Cpp1MphSjkdBNpkRYF2w44syE/hVqQQG4qT
7Q7wZ5ggHseGttS4cP+LjEgsgDuC/nJ/EZEvp/nbcDl3Trf1vC9ffMxB176xP8ZV
T4+dV/DKHUF/MDZcG0OZ1OIwDZtttL9uhjMwsE/tYceQTfuQMlmqgIZaTunUnpKP
kjkwBKqAgsUF8PVXIhI8a5l6SoTGukkw8gR8S7YEtbU=
//pragma protect end_data_block
//pragma protect digest_block
u6kFMjYbxDF0sYdagxbq0Fv977o=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
w2WUyTGAPKEHwoE6tkzTiebE3G9Unyw1F9vWQXH6w11GIpAap7aEsQ2OovzFbQYz
dDR4gGTMAL2ArzHqqQ2k64Lj8vDOhMUk+Ib9tOqGszAY346T3ZIQxZaupl2F6RYQ
TPCPoXA20l7bxkokwaORhpq2YjaDcUx3OkZ8ALzyqedYtEHSXrY8KA==
//pragma protect end_key_block
//pragma protect digest_block
o+yx1AItgk9+XyG4/+l2CNC5Srw=
//pragma protect end_digest_block
//pragma protect data_block
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
TnQGnONOxtLQfpAQRMpGeQ==
//pragma protect end_data_block
//pragma protect digest_block
4crrd9s77zsvh1DaiQS8JJw5Ha8=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_MX25R_HIGH_PERFORMANCE_AC_CONFIGURATION_SV
