
`ifndef GUARD_SVT_SPI_FLASH_MX25U_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MX25U_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Macronix MX25U device family.
 */
class svt_spi_flash_mx25u_ac_configuration extends svt_configuration;

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
   * Minimum Clock period/Highest Freq support.
   */ 
  real tCLK_ns[];

  /**
   * Minimum Clock period/Highest Freq support for Fast READ Command (SPI) command
   */ 
  real tCLK_Fast_Read_ns[];

  /**
   * Minimum Clock period/Highest Freq support for Fast READ Dual Output command 
   */ 
  real tCLK_Fast_Read_DUAL_OUTPUT_ns[];

  /**
   * Minimum Clock period/Highest Freq support for Fast READ Dual IO command 
   */ 
  real tCLK_Fast_Read_DUAL_IO_ns[];

  /**
   * Minimum Clock period/Highest Freq support for Fast READ QUAD Output command 
   */ 
  real tCLK_Fast_Read_QUAD_OUTPUT_ns[];

  /**
   * Minimum Clock period/Highest Freq support for Fast READ QUAD IO command 
   */ 
  real tCLK_Fast_Read_QUAD_IO_ns[];

  /**
   * Minimum Clock period/Highest Freq support for AUTOBOOT 
   */ 
  real tCLK_AutoBoot_ns[];

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
  `svt_vmm_data_new(svt_spi_flash_mx25u_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_mx25u_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mx25u_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mx25u_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_mx25u_ac_configuration.
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
  `vmm_typename(svt_spi_flash_mx25u_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mx25u_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
IqPYVNq98cj6hYLrwXJas1h5DdU1SgkuX0frvxDbpbg2as23XxNihbGWvf7cdBw1
TNkgUuHSZ9s1hf0HRqSR72zjqt73OYd/ULLBi1kAXrWf29mgGGmT5zGhGb3BrYFa
rF2YOpfMf12ZdmxgqIYVLk/GzHDp2QPdHCZd47Al96R7FDFhX1xyMg==
//pragma protect end_key_block
//pragma protect digest_block
MqqZXuNSx4HtSrCXtbBQpUGQwVc=
//pragma protect end_digest_block
//pragma protect data_block
eQMGFpppAHraT9RiJHBn5g19OXccAGua1tOqh7ygiFuy629jwwFWvQ/5g9edqa+Z
/USipoaFGv297nj9dTEU+FsT4M81OsJn2aHy0O4HxLNHvSbe4zIW9By4xiuVIU81
InBiEZm3MRzOAMlizrST1RG4Qv+img1kpmy/n17U3ou9Ub37+Nfw6ahI8B1qAqGy
ktsn+moa9FKt1Nb1RQjJqhEsfs6bGrWjLj3seuSNa2fRno1NEG/+hte8iAKxmABB
V0owctKH3vV1eoi2ZxXr8l2PkkNOdF3sOLz+U/c/Zg1cL0fnHzBVsz77Csj7F5Kt
SBN6HIK2nIkt13I93vD3HsM98sz7LERhRDctHKB2OBRkAwZ5gAxha+8QLyMHPh/l
bq7Qsb+6jY81GX3iarkwx5AdUtRPhEN1F8hnCFO05pSO1JgtE7d9+hQeUr1Ptbg5
OS5DnA137nFwXchrZcxUqKsXxnvU2rXFUDKTxt8f4z12itGXlobym8Oem7gZVpaH
vfihbAdtYiZH29/v1JR7r+GL9PfLh9qnw3qJg1eAJ+MNx1eEbrQasi+A8jSdUQUJ
pcmU4LEA3q9kUQo32Fs8saS4UlnpR2GLhulITtg6KzDjFdUbeprU96TIAYnWD58W
FzOKdChcPTeTGXT0OlG6pxL908isWTILH6W8LDWMobybLk5FfWtcBbsbrAEw0hf3
uUofroB/YQNP8iOodchQEV+zuVCFqPjjRt3AILaOGCSt4JqLMD0DgKkPXWYiA52B
HZWkYIwBqZFq0cJbUVsco/zV/IimyFY0phchOqg0ALi1rY8lWdzXyESX4+uxDRuR
o9U8e+6GeGB5OwKvD+KhNNtc94rjJeTnxu0iek3+xvKr30RcB4CH3gv1Bz97Rw4c
KKG0krZCjkYR0v1KJUt9lAAHMUme4OT7Qgjg77MofhuO4DZYDSD4qEm0ZuablMAR
rzZZ+EcIEQBXl1rAzsMOdY3iyrleN957ZCX2MZgqD+P8E8npLQr2/iOYiWEe3wrV
62kVJnCQYDmMbYoedVJrxZDvFDlj07PiqYRUqTJt4fwlkZuUFvpSoflUybKyU2O4
VRG7Vsd4xlxcn6M28H0p2ezQ9tJUbrsPd7BMw6b+ReDrf3X/BN4cS07KesfSiGIH
BKYl6rY7Sidz+ug0ft2oXh9hBaPVbH0MURBi3XZiRA4qEd0JWwwUqZZ5SmT0TQnT
nfrOL3rUqZldi6rL0PhuDg==
//pragma protect end_data_block
//pragma protect digest_block
hl+nkvtNq+SUOR8BaGjzosSJiMA=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
YLCUS8p7wLDR6/vdU1GJ7Y5SxQGFAz8Bal+tsJ0Rh7SRXKTHad7DCv/OIS7GP3Bd
1jpdRvNlagLvFqDKBGb9Tuc4vXRG/pb/vcyVR4CyQ/U0b/ZFm62dibyt/pYWAvZI
ikdgGG0PedhKr3m4F+F7RKO9aKqbXW6OiiyioQoMF1zaYbwlZAGCsQ==
//pragma protect end_key_block
//pragma protect digest_block
+8s3sYe8SoNYigai9ZfjpFdOlJQ=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
mKoCLgwYMDvxJ+s5Cy7q3nfrPF8=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_MX25U_AC_CONFIGURATION_SV
