
`ifndef GUARD_SVT_SPI_FLASH_MT25Q_DDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MT25Q_DDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;
// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Micron MT25Q device family in DDR mode.
 */
class svt_spi_flash_mt25q_ddr_ac_configuration extends svt_configuration;

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
  real tCH_ns[];

  /**
   * Minimum Clock Low pulse width duration.
   */ 
  real tCL_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command (SPI) command
   */ 
  real tCH_Fast_Read_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Octal Output command 
   */ 
  real tCH_Fast_Read_DUAL_OUTPUT_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Octal IO command 
   */ 
  real tCH_Fast_Read_DUAL_IO_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command (SPI) command
   */ 
  real tCH_Fast_Read_QUAD_OUTPUT_ns[];

  /**
   * Minimum Clock High/Low pulse time for 4 byte Fast READ Octal Output command 
   */ 
  real tCH_Fast_Read_QUAD_IO_ns[];

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
  `svt_vmm_data_new(svt_spi_flash_mt25q_ddr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_mt25q_ddr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mt25q_ddr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mt25q_ddr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_mt25q_ddr_ac_configuration.
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
  `vmm_typename(svt_spi_flash_mt25q_ddr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mt25q_ddr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
p7e2IYgR76P5LKRSPPxUKVJlu8YN7KhsRL8LqPGNDJ7B8BMcV8qiomKNii1GP93N
qv+nUPVJ6/hX1LfnhJq0jFsVdXlReGSoxnCXgwdK9PJQBVIcTHQ1vOlt8d2dgpHF
vn7TFflRhl8v1Ofoi6GDikfMFe4OPVNaWPKguw/311eXIRwmGU7yhw==
//pragma protect end_key_block
//pragma protect digest_block
ohhSCio9rnaiWSFCkvhJ1vEh+cI=
//pragma protect end_digest_block
//pragma protect data_block
38wu3enW0t5kokDTKRqMagMAOuqLihHvIctaDBwvst+01m6kViZYcsxUmvPqr9/i
3xS8q9nGqYteS3zdwIWi+8KnwyqbSsAJnhzl8sUYzfrc9JT8KGNRxMCZhh1IaTbV
+YZi6G4Wu00q750UPagmgj/GAhjAIFXD45C64rXXSw8GcAzy7HOHFPAS9dWZbG5S
jZNyoxU38K81Ak+i92Ihm3qow+BobECUDslrodY94IBynECUM8yfAXSW3t/8uPbw
QZw7CNpY4DaHlPQxIo+anGLkLAhjPanHwjgopK4+ViHyDW4a6Kad2ptQR0SbDpYw
16hIXzn4HnGDwiprU86eYQc4EHM++BvBPMJBB9dsZghb0bDItpFGq+FiO1QI26cx
oMBJgCKet72/paVAGrt2PrcevolhtEx6gv8nBoJ1Y6tJTaeNGQ4gWSWhD1z23as1
3ElfJYNPfAVSfWgehWVQJfRV0bpUMFcDA33FGhx30EbrnqWiJZ0xzHSmkCPJskvh
Dz6baZvzVWfSpGrMRlVWuYwTIb7C4SryuUR5X0ENhh+fm/uElnsoGf51JeH5Ec1o
B2A/k6pDS6IRH4tOOda1g/ndFW3jr3zS4Gng2gA4m7mQAjjKPfF3xQC/3qLm6mNs
dX/nnA5N2oAIphuygLOUCbt10GUGnblj3POQUGkFjgqTaHhtoXifGDE8Ze3sOwWf
i4g7z6zYwsrHppbdykJAc/35f3F7ieOs0sYtf5j/sDB5PsNZHk7gmG0ABu55Sx1+
sA3P+x8oDL9c58R/ksxd7YEhhB/0oesn+KzhrcjpzsQfc4OFXgR6xkcm+VCcWS4i
cK3Ox0645OWJ4BxWiYEBl69SpU9TNJL6gm85L5eGrWCiCPQ+VFsF3Zi/Z9w92Uli
Fv9LU7pT+3z/nZ9y+F+PlIq1rBsWqzuZFEevsRlifodtOp+Vu6ctsXX4iioOUyNy
ybvPTymP4NVdv3UhIgU5neSxVuNfYZEZLvwVAwOgd5lCfXJ9o3qHjmtbGLdL5VZJ
CJnW7Z9W8YQ0Xrn+V4bKJRiSjNLvDUMLhuRv5t8n2HUYMgmpQWKGZaZg4v3A8ex3
GpGsBYySVogigswEBLed4FOkM4b8JvLwwCBPCP4qmwkxlvQRxasSljWMSEREcIYl
xttQ/dgamAKT8XGMC3QV0YFB3/6uGwN9USedmcOqwoW+2RpcEEePm5DJ+vJ2As9b
YJe9AZ4pZ5PecmXkR1zKdvHHEw7gBgpJb+DTkeBLRGo=
//pragma protect end_data_block
//pragma protect digest_block
xWLvGeqp99vx+Rh2xJMHYnedzEU=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
eqpGHHh5Sr5eCyaBhTAt6Re+J4zch/845k+a/nv4/Ogu2J4GPP6Lal8fYya5r+Aq
1Er1cenVOu/FB2BJzuZ97SSvY4cK5bWEC5ZzBcDwohJn6LL6f3GGk9GvVFyKPW0q
xxW0p0qqSm3lS7NuS50PN6w82QosUUq2UZeAhUT4N6lzuvQZDUyRAA==
//pragma protect end_key_block
//pragma protect digest_block
0aewPVZEYiswOCvNeVkLHJYr26I=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
pw/bMPWoqM1OTS/mHALN1PWY8aY=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_MT25Q_DDR_AC_CONFIGURATION_SV
