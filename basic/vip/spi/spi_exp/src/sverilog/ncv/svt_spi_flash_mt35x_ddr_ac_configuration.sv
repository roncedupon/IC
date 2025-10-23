
`ifndef GUARD_SVT_SPI_FLASH_MT35X_DDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MT35X_DDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;
// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Micron MT35X device family in DDR mode.
 */
class svt_spi_flash_mt35x_ddr_ac_configuration extends svt_configuration;

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
   * Minimum Clock High/Low pulse time for Fast READ Octal Output command 
   */ 
  real tCH_Fast_Read_DDR_OCTAL_OUTPUT_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Octal IO command 
   */ 
  real tCH_4byte_Fast_Read_DDR_OCTAL_IO_ns[];

  /**
   * Minimum Clock High/Low pulse time for Protocol Mode "OCTAL_IO_DTR"
   */ 
  real tCH_OCTAL_DDR_ns[];

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
  `svt_vmm_data_new(svt_spi_flash_mt35x_ddr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_mt35x_ddr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mt35x_ddr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mt35x_ddr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_mt35x_ddr_ac_configuration.
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
  `vmm_typename(svt_spi_flash_mt35x_ddr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mt35x_ddr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
t14Fk8FTm/nPx/kECMAwMUQKVEHLfjcxLG0L4DeXvEaLzv4IZEY9eKLy4Xit9w//
tWtJ1c1BPZZqUAjCDEqsv3TB8ETXKBgSn6mScn+WVcx3SB8UqOSQk47sQVFxuPqW
bOgs4ub5S2RTRhO7O1VY0Xw+KAuQelHGMGYejolO3F9WrKr+wdojtw==
//pragma protect end_key_block
//pragma protect digest_block
+Ls9VCUlJmN3A+ZGgUXvYbou0EY=
//pragma protect end_digest_block
//pragma protect data_block
fTJIl6lqKuIbmVunzQinl2VFac49UnVvKGtqFbMJDrtaJxONYJP5Q1KBcj4bnhIk
PtE875MlpXTKzE99YTGqWx8e9iRrm2Gwsn0sCNjPaiRIfdeE/6lckHN8yify6D7u
KFSZ+iNPuyTWoOsJuxTHR//yTl5KfSvuOuQJP6wv9rZud6daRixp+7nKy46U52Vu
JVe5bsK5LTDJPs9jxagEEmFe5AEx+z43+4tFmXPKoMfYxsD/GxVQog++Q0FFqKYE
FFMENhIPFEiKQMbaGpBP202g7ia7+5tbnloCiaf4Cv6goDYOW5Bkh1SKBWVPLBE3
6vc7m0cjMN9W/PbIVu3LICzwvt3jFp6XbXJdSFuGSz/oj1TVRIyQxsZBSkShP57I
0OVjN4PIzUMPRX6BH/DQa7/rKpFHwJSQGO6j3XG/ypxNaBl4ufxDwwy+n1231HT6
rq+sQMrggzllY9umRSIgY6QMvVrkeMyV2tfLFPI0bHH67E02UVQ6YYpt/jasFGJl
srVTKUfI96J/+TPvY2DYr0YVak2Z99oS+u5JJtIn1WbBzUSNUZmXlrWhirZB6K8G
ovDPi+Yfe2louLTrZzKT2K5sfcClcki4iE9A85aAdDgPh15KYONV5+11TUOOpJuc
aY74vVmHWYuL1G8O2ncUHP0YPWeMtOcpqE4okG+ExFSavTz0Kz09SCc0L4V9cIKF
NdGjYmWj8S0zoJPS8NdeAUTuvcDicrrz/mdtEI/Lx08+bryb1y6x9ITbTbyKJqea
RuzJvLISUF397Ng/U9ANmjXHYJjmOUYIQ1HlxqSYGKpKnQnbB5pnVDH8nBsN8NYI
LBcmiFSbWlPTJQwXVokT8/CeVzHaWjXmn31nPaIFcwFa2wra0bePfPnpEO+Fl75y
QcsohVWbTI+Lcvs5jh5rrFN8djp9n8ENEAR4rd7uJoUkXMYJKyIdgobA6B3q0/JE
NLTXGFXTzp2evXPd3aRrITIf3NjMTBecrelMXsuy2vFICQGVUid66f1gN/Is81vN
Fz8b8Bwuod7/f+Stad39Mfzf+Sru7GCNeFfkQtVmotqfJ0zVCK8AM3F1BD5ttMLc
azqNXnwlSOUpgnJuc1+rys4d7sn69Prw1BGuE6IBhLWFaIXOwzrjlip0DFmor5u/
iPh6/KdnJrtkENM8FduKduFx3b3nG1EnG+2/Z1UgHg4qzGz1eVvxVokWMjCZr6uB
4dDz/xNrVvToFY/Pq2dM0xAsUgIoXgqvDb3HReggSZM=
//pragma protect end_data_block
//pragma protect digest_block
9OsqALPb8TQUudo9BlH2XtPqkCs=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
PKugyHC376xDEZhI4sX0zqdQfN/WRLpKRSTnrx+Hb2mmTlDToTeP6hXS/WOHd1br
oSZcfnbv85GfQis2boxPCDtyV4Zq5nwtYd/qM7FnNAcfoL0PxsYIaoLxs6vfApAX
zbdKuuS4jVtNBsU45Q0o1tN8eFYDOQQ7EWDyez6+kqVogJl3XnVYiQ==
//pragma protect end_key_block
//pragma protect digest_block
IdvXSKNqYmLoXxiwb9l9DtRrAJg=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
elcLuAkQtoIFThEMl2M7SgdVMaU=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_MT35X_DDR_AC_CONFIGURATION_SV
