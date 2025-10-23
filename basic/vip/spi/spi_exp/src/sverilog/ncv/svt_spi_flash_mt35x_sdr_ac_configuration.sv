
`ifndef GUARD_SVT_SPI_FLASH_MT35X_SDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MT35X_SDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Micron MT35X device family in SDR mode.
 */
class svt_spi_flash_mt35x_sdr_ac_configuration extends svt_configuration;

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
   * Minimum Clock High/Low pulse time for Fast READ Command (SPI) command
   */ 
  real tCH_Fast_Read_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Octal Output command 
   */ 
  real tCH_Fast_Read_OCTAL_OUTPUT_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Octal IO command 
   */ 
  real tCH_Fast_Read_OCTAL_IO_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command (SPI) command
   */ 
  real tCH_4byte_Fast_Read_ns[];

  /**
   * Minimum Clock High/Low pulse time for 4 byte Fast READ Octal Output command 
   */ 
  real tCH_4byte_Fast_Read_OCTAL_OUTPUT_ns[];

  /**
   * Minimum Clock High/Low pulse time for 4 byte Fast READ Octal IO command 
   */ 
  real tCH_4byte_Fast_Read_OCTAL_IO_ns[];

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
  `svt_vmm_data_new(svt_spi_flash_mt35x_sdr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_mt35x_sdr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mt35x_sdr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mt35x_sdr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_mt35x_sdr_ac_configuration.
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
  `vmm_typename(svt_spi_flash_mt35x_sdr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mt35x_sdr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
xGnJ8W8C+0Z8Woxu9xwhc+QiS4Q9xtegdRz4P8+d5q40NaQ91hm7Ykpk6YYjg7VT
2GWw7BNOAAybayBOl1IQwLL429xr4lFuPLL01nSMZCOo5ao/48F1n0peeOD5qDrT
evNkCzUeAZ/fMvSg8wr0n/AzQz3JoOP5CsdRD1fSx3QTApgYy9HYFw==
//pragma protect end_key_block
//pragma protect digest_block
Ucd9RHtAV2/24pxi2mfWAgjjWPw=
//pragma protect end_digest_block
//pragma protect data_block
96skcjFaPvVM/j7n1VXYDlpMGyHBQ9BoNARfA1sC3ocYrR/NXANuyi/F0t/jrvRu
JLOf6rHr9OpnX74s63Umb68SgFyv0JCEPL1fwIdFlhnShtKv/jXOmZnvfWuSVbhr
txStjnREP7ba4n1/RTWCbGyP69k/wNncd9+CvBv3uuUyxTHdEptgTlEbqFHeOV6C
jWHDYoJwr2MC3+rbAdGRyRJQGQGbD77Do3oPjD2uYy/GRMNU4RCTdyJc97asnNTc
vPlUVJCzdAc6bdhSfKHT44wckRewiR1elXO0GtnE+DQ9XNfKeVo1Z4LovClUwj6t
kaOyTslSGfKtdHsLqP+skgOR0sQOrcd/JxurwXdPqaE4HydzlN+VtfllmbNFiiPb
PZbtAOJ1SlEb0z1njBMo1iYSN6CxStoOWEy+12WZphoseZnrLq4pMTJgApJ66l3q
KTbt9KKbd8vfLVg4fGR7Uxppndu/3v8wTHxoe/gTxoHTARl5m739KnzSusUEaXTi
OQg6IzHALFPpqjx03+E9FdYW6R8I9IkRHwZce+izacSJj9n8upp5p8iqK5p+dKJv
5qVtR21uHsL7+y7/2l3N27rw1Nv+dDAXHKO7kJrcQrcjpFaulem1zXsBUt8UJunz
QwnuO2YjJM+utp/G1yFt5ExZf4sr5U+CLCWNTEOkgacZZFhK1fdqYQlftq8jwI9N
jfLI5hQgGOWon7tr/PNLUIpfrCIhZ+r8s6LdlHo9ZC/1e9dFUw5xwfNAKRxfXexm
/CsZIowJ0oGEx/tQiYZZ9zsBjBVEQZ9KrTePPDQGr3zUk+NbHwuiLJ/Jaxsnc/9F
L901cQvYhY8JCCsLe5pfXbRbJLL9o+brMY4aSK8QpnjO0G7CU9kPG4uKoQaVjr2Z
btHjccDEkWwYsGakKkCuddpdZxtj6znZuQQwXm39Gbv720ryB/vvt96OhKFDfQe3
/7xEJG6iIPic6/SBwi5po7VOsGP1yPeyzIhCvOBBQD/cS/PUJoeKSvV8IHvbhZw1
V44mdkozCMovOdTzs97OeV8gKRI+9PYZBRVe7QKgtH26cOf/x6ffkg2hRZO2jeDV
SjVCNAgPaf/OSV6s1a8l1NibgsfgRSr1+vBExmwFFvPWf7XRIaMyh6tMn5izY5Hl
iLksLhLNEo48D8FQb0973f4huyz996oyrmMiZ2PRKpTqTInFPZ/04NJBKKCIrJu+
HyD6cOqINeyg1kWbiR2dZQfgfDQ3y9c9NPcT5lR05c4=
//pragma protect end_data_block
//pragma protect digest_block
UMeMLVZ5I8vOwemsqSocliEwjIY=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
0IYMTJ4tYkZDwT7EAWeDQkK4kDq5btw1+l+YQkSJpK0fNpmQEQPXNeLUjuqOKYi7
UO/lQZE6+XP4MQ5d7d36EI8JDB5ojrcw5r0sPaRN3yWbFc2AXgDhLF6GcwdvxEi7
Szx5VpUvl4+MLhzOg9mr+imwSczAAplT37DQXb+YEBzGuC4mLX/TJQ==
//pragma protect end_key_block
//pragma protect digest_block
STGoZ+qXIZTgOpCJJVInagLkOVw=
//pragma protect end_digest_block
//pragma protect data_block
7L9+ujclmynQoC/1mnSYBhk++R1xSeMjkAvlWIx4CUNc2Zvo1nQnqvEiVPo4F11r
5yXPjsMuklZWGZTC3RFRofjha0amcflOH8lX3q/cRT0RUtlWqbgM4KK5lrZRNFLS
i0W4HiweshsRhYy0ytB4TMkilYzumHLRUdJSyw/nzMDjgU0UQm9k5kynYHbISVDk
oW32/DTFr7gsu1NxOaSputX8CW5m/pWneRNgMJGj6glakZpORv2O3mQU6Gdddla4
D0o/Kk5hKhWyKyrCBHYUCS1/+10XufmUnDKIL1gV6MwZUBVwCXHus/qdBxTF8Daf
sM/trrnujrC0forPt1aaH6LDh+x37xZFhQYiuikQC0GKgPzIdzP+t4wrxyXM4yV4
E2PJ1fM0Hk1OVVMSNCxjPyhVdAjKo/u8D3pxIiX2N8h/cyjMRxbPtT5xbe2gJWKC
gUomZM3qSAKpq/XvKpyBIC8/ljNp4eL79D5WLHRhlyFfclRGncTDSP1TuOSDYMVG
T3H9WWS5bfFoC+kXVWTCV2CofxuCS2a8cbJXlxnJklbHRat3PJ4+lKoe0epTzFGd
OkE/G8HKc5+6Y5F3MYJNdcOMEKB4y2JqFR5zObsSrOSMVz1zK5buIWw0O8w5NTDS
yWGvCYwOVdgot1oQVcDSxPTSjpqQJ/1+VfN9YrBgHl7FXwZBnUmWQnwyE+M2xzOE
NAwb4hnQY9C8fSmbzHkR7S0/6oOhn1co4twrO8pJ5DyU46GTjRJ56ClJ+R9BJIJ/
0hD/zxrEw9t3KzuaQ162uzZcHSeyOehYNugWVH0d8sU/i7BrKkdfUA/9nrVyLTSu
dUc5BCUa6i75NN17OIjhd//98TtU9oQ1u1fvAktiTfGokaL2fvJXHZrWWl1I+5v1
md3moGDwebuB/1wbgVdy2I6W6LxSCgocniDhhdnBWBuJBtlaN2OzSl79w0ObSjVQ
+2bNwAyZvdIvfPzaKpACdkiNnCPwcVdTkm8OHusYP2ifjlALlZDsT/01Falp+STC
OBwo/kUVSH/1HPjpadya9jPZJc2NYTIHB3T9DHngPqOz8ktv81EUM7GuWbEXHarY
jeXa4nfAYadMnsbWSthSVtOm1PR1NXzQxQC4hbBlr4PVqZCgIg3nVTxIJY6KmpF6
x6t3ZEUUC8pXrYpp5wH50u5mf6E6xf2lj1zd5jeK2jFLwhutttWwYzSN0CqYUSqC
zVqYK72YBz1oKnLWEITcu7QWErrFb+LL/Nsdoj8ayrky6YqX33WPw+ED2h1MH6YB
mLcP2P0d+h3V0LRy0iPlwzjL2FmYLUxKjroJbWQbEkcKz5bEqlC4fP9u34rSTU/C
a450oUD3Esb5vEamQ0Odw3B2RBON7yoVSAb+AbRkGlKz6tkI1q8bpLiFKD80Oc+c
bBGvIFHDv9BTg+ICs41HL/ZLSDF1EN63918PmLFMQY5Y0G29zZzl4ZCnjXcXX7Lr
PyTtaEGNM9d91qd948900m64vGC4c+WLljztCN1PrIwcqyQMDI1Cpf8uwTlpMdDu
ID5I1Yhe4LZliXBmYFS5RyVyTNRXQT+P+ZsJJPVGcSWpEJb2rmb8AX0vryhqkb2K
GkrjxGxwvT7zNDxNBxXB5VTLCMtIzAHvmEWT9iH0cy0DoFAUf9yu7SyMprze0Zri
8SfUHtzvIIi3L1ARoHUam2nn7WLAdkJhJ+wdJTtWrBQz9oZ1iQ165jCzJk8krM1V
ieANGnQ2LLfspZFjBpIZfYm9amvxVOJTcRIfpumrlOEuyzzNzBAlU2m7Q82sgBe7
LJUwWU44KSQfYX7sm3QgsKpTA5DqobCnNBFnEVFpSN8i3wTt49RVIgS0eZfvQ9iK
DgcWBRMTuDwEq/2DWnIAQALPKxrUFirxwVBOrntzAdkGRjAqPWxLy4XLOzVqBlqM
u6b2tpiUL5jQktL8AfAbRp9rK1/E9rc8Eu3hp/JwIMi8+pYTHSRxfbb+spR8BKzp
ButAaC7T73BPBdAg9qncpR6WxenQcvgZqM49AfCtnti7ihUCFN/co99ayPOhkl49
V5hHMGMHkRUUi39bfPECSbsqovINFBY/AKRwVIGZJIfzGm4lFOS/84Bzdo9aH/kD
hBzUcVbnnDVFpbM2I0y+VR3e0gyLNCwoKssUXGMfN5sH4/kCkOOd11cMCU1g4io+
sxI3TBTrslZGpcfHxJs87fp5mtrlL4YOG/gNkq+dpHk2gQ307TTxsJW4U+biuFBY
9nbfByE71TYX4yxbUJ/VAUklRNHx+T6a1Bay3RLKfSq3Dz/VdU2YkWAInxp5G7Bm
NiFrPk+HvDAnN3Hf67yVgMxOm8IaKzowMlmMuqCeGPVJ6o2jEj9def47MWb4s+Iq
3GhGrDKCMXLicMZFR8AGVne8CgwhE9iY4m/tzTwXLAQL6tuFwbUy+KnmjfUnf4Qe
VyJXbDXtFg3b0AhoMcJ34pehvfXst8HjbyBg9xbTmPTyY8rElJImz9/V9g+398jW
TahbE/Dc93tpVjbiaS+58s7UFEAjJEmnJnNUYKMluYQypz7X5+NBX4lAiCbIuO9D
3d63wFrleYNYKYmCm6gPx9kDvCL0kgdqNsdywOjB9gsnJZdpeBVkEVKOdteGCNYQ
LdoUBsR+iTvliK0527qRIJyZPQlxFapVdMvwrA7L5SdSm6ZaqjUP615tY8pLobrt
U+YOKspTCklizOws2KT1psU6+y8PpzoQyGkVYhTe66PwSI6PpE+Rsxkqb4MT4jan
5CkR9plUdgv237Evm+VT3gwTPkaUJ1rdiyX0vjMxBFU7h8qH1fGLQb1MI7xacyez
tMnxixTWujIuks+YPARr1vG9+4IZFj8UnIDx6TtQqtQE9LuaLLaiBLQ4Hf1gvkBe
c5SjuRP56vKjYbsyCs+5b4sEMwt/DUEAogg0+SCLjQq1HzdjuHds3RpJBzFZ5dW8
lexkNBqhrTtHfKFG0C90PspoF4HhMn3LcPCqFcD53acoY3hMY9Dz9k5yR3KSYtAM
4mP4sPw3TlDUszbkTIwFI0akjAN9nLLNn+boQOHlijei+l5ZHT1KQchz30Q70lmQ
xeopF6hDgZt1i5yqRsqacL9PPlD/2UOqVphpmdmUn1V8AFwm1aGgLSnhsCfuEhg8
WJErGqKe78RD5TTKcJJVqSqpCh1zjt8RLU1KK9VHRmwFiDWIqfonCR+TrAXi2iiP
RsKZPV3Qq3fE04MT1GpOoNN7aqwICh0QbXzCNenwQCa1MKMbzewfeQvRksQfcOo8
fcxJv3DDV4L8Q9wkwswfOu9tQR8fae9lWqxRdJJptpNBPKbhP6cnmGGHCBm49KB8
mx6gHw2duUcr2GH6A/YzbheMM8W4EsgLXbpWXccozs9OIrALH3hCsA8UKz61h80g
89eRlRp4Dz1rcgIDQhHjL8Yj/eWgrf+2FN3YMDWaCzt6rdDc0PWPd8EXDOiNgDdb
GLllAtvtCmzC0W0jxMZqwHISzTS/N6oL0dX7EexuWXp6XXATQ9AGifR2yuUdDcQ9
IF1Qlu6t2ADJ8IeqPI2U7NCUPfLipA5Nq640bbN1UScSWtMhB9aQaJ43Ta+rZIUh
qcTLI89IYvwQEtOZS+zHmYdxqC2xakh6rMiwa5st0uyqT5gXOoJwyp8KeHHaZrnb
t+BbSMeEULwCxnM1Ad0VNN6Z3vUtDy73f5JLvCy8S7tmk8Vmu9gBsYPR0tI8hzap
rrr5fUV9QjLkj8iEFge2XaIzMDYNhrmyyc9BEBJCsGyiBWyfXhO2GdwbWIPcAvy4
6SURVdQvKlXWk5kpe9toiaUzTBLZxOZk5pqGS9vZYffLKX9L8LiDBVtoEpNqy0jz
p01L06FkfbyTa/X9s1RL1VAZHlVZPOvVCfzaTUq8GZsm0a+YKPqJzr3o70UqDdVW
5DfAx+pe9zibB11PO1U9RFCevz7le1qe40Dy04cixoaVttslvptBHdr3rwwEyloc
z3QwkNGuKdK5e0k9MgUUr+kI4cIllJk7fGqYvhD0BNukjxutNs4xrxQAJC4Aw5q2
E3Fzi0/yZMYKwjRHnuKm4vYI+duBCn/rBJqJ2V3/cYL0YMIdi83u4VE+mb1QSa6g
eksQKbzx2BoWXA/7rws52w3sh+Otk/94H67Flle52nUAuQotrNOYM1MHrmAdX90e
h7JvmUxVN84MwnXV27IwlNPY6vMu15oazxEH3jFyYKJS/81OX8265eoNv77pgtJU
61Ur9E8pq3z2BcnL11MY7UzYoB7s4Z2FTTLGEK1df/RJ/dqEdnt/TMqtt8nB3Fxl
NT5SOeJVavmANQTiN+XP7SZSVKOCygphtYyhaBD7wY1apozttVqKA014t11sP+9h
1AMhCMsKexRmq+PJNX8czX9SJj1tb/VtwiQb08WGG7pcN7muxb1VgOccyo52svnZ
KD/QPoN8mnALRnvMZfeoiSITiwUPeN9yYzERc1/R2aTuy+jVzfoQHpdw6o4UfEs9
08upGm9qPeqg5msq+dfHpPXsP5NtceQJMWTa8ZnDcuQ5ib1nPwi3qdgv/+D+gXMT
yTDgdXklzKwze6XkhAYzUew3TIKWPxhD9JoTfE4H7g0n5yFRr7q0eW7C2vb2VqUM
4bnrQ/EPTQRkv6Stfx2cJCTbs82rx9XVWxVkgE/reN6xD02HkHH4ZiBeh7bgnyrx
B5ZsvwwFUiUTv1yWuRaoqHLmwg96c9h6iWLLjAtxKNNOiIaSVYl7nNnO8976mPjM
zcPWMgUgiOw+8thwblN7aLllh1X4CqjAI1SlYSN+WDHsPcnXdPz5Z7IfNPUqvu3U
B0GtLP0pCkGQ3/EsjqB9L2TXHGgAexOdUkW+WsObUXugUhYts8S1YDSx2GP/sxYh
OUePNSsdG5Ch402ef+8vcUh0ny1TamUj931go3rfDjJGYwMyH1eloj651OA0OqcB
4hM3ruYNc9R/VlMhS86K6kOlA8HeeSU/jUddaQyPCj43UPF3A3a3XZP3l5s2P28U
tpetGeTPBEHR/IsHBh5pxiyjtT0N3pYIxHRGlHBSEqQrOce2pjzF4Ac2U+vIiQj/
mqIs+SmYvWZZBZC9cS4hC2zpjbOP9tGQyNtNmI9co5EIQZjUi7Ozodd/SnlpXgQB
t9kP4r4NRlunLiGCFl77iLpbut8dYZkZzWG6T7TbSyRl3sobRTtFsEjENtH5ltYv
SF6yciRIgR1STVyzcB8plfAlZgyezzjxAHelFCj+fu244A2zolk+YXNQQEXQxWuU
EEDCKBjpWo480sjWiCGeigEtnuNJtZmfbmkkIH9LwT+rb8xDftLnu4NTrqD7xi76
YP/iNFtXRXSxg1mPNneVk0mhMg1OK4Yft8O73uqhy9t3WDMxYxrB5BhVqW6V+fJw
TodlewX0AAYIUCdJFgb43orZxtjzhGukRPC3MDggP9Cmsugfij7P0I9huCbTZJ2v
WGSfh1MhsypGURCQQ3j504o3+MVrN8VKJzm7BYdEatEHXlVz1xJ/vDzP98KZ0Ijj
sJBN1egW4VWXGbM9hStvMjVc7mRdqkjCOGNuJiagx8JCFNLg8AD3mu+u4WqcshgF
LgaQKvl2mWc3dcPAQtNpf0DBoHJRs1MuK0akCqx79LCXr4MY/pKZ4Ei2QZMWUXJk
Xpb4eOHtVJA8d3xQ6+qZl9Wi3UZq/GQVcd5oR/GaDZO9MIx4xsqS9YOzcAtadKWu
aDJiwp7i3PAeLXZ5b/Srlw12OuSWrjUWmhoLs3lx7j+MAVy/MCpsxE7PLEqawHvf
9RlRxN1A7npgvo0009YhBVLuEc/UkqK4Q0iBAZPEWpMiIDib3FTFMIIfYaCuJPe5
sLLxYPUC683FU75lgyfHfTrjEtABcashtbzPvcWAqGJkD4KiDT6EJms2R86m74VP
i4jWt1uGIRrgcrNA3wxAHoZObjK4fdoYfXCiRoBY19M2h88nwJgCQIPSKdzoWxwi
JfCgsuMMMTqXJb3uIF5aHAv5fKJNG+6IglYfXYqJmnQLvfuzTvaXOmNRvbh3x9bx
OdC0IIQ1j5W7iCPup0fvdND17v3UsqPV+v0+Bp3kb9bEipZoLQC8Tcco/eG6RNZS
cXIYeEC8DeKoCsFW9uiDLnCR92cExnBVn7eMTYneihd33+R67KF2eIXF1zUOQVvV
UDK3bmPwTEB8jMuweEoZnDP5NJ5XuKmx0r6CtwPdsRc/65Mqod5CTb4HVKxK1Pph
p/xxo9IHwk6eqSFq4PUNMsWBf3pP30vyOXCO4mBdckciRvQ+SfBFdzDBKWxJtmXN
/pGA4U/aO1fCPb75MtvQp0F9S+XgC6XjdQtHl2g0Rfyg88BZ6obaZLXZz51NAG/5
eWwIIetEF9hOd/HYIJccpVdwL8sFeseqqBrMcgiJ87oSxfBBxwooVs9dX4xp2UW4
he8FM3POUOfAZJn/JC9WC9riR6MIKE9bREXyB8NWiK+bT76Btp0CMuH5jTF62DRq
eP+gwGqPRnQLg4uuCsGcDfX4GgwDXDDt4Ko5apmTr6R8Pq7riQHYYeHn3SINgJ/Q
hJvN+qM1+i+mvc6Cs6MlcwiNiHmnQqWzyjkI+fNe4kFUGWqozybasp/zUXRiohTy
m8E1HxvooFzao8rdYBEKkyJNIECqEbWXftLAcOUX8niOqbiWW4f4gTFG3aSFot0n
Xxxo4qNzqYprLnmLpap8YfN6vuPNXrRZzV4QUpZ6gUImGbXBOsccug/lQ8HP5onz
DxtB1TrV6zF5J0SXw7rzebvjR/hEaszIXynnP8u0Y5Cepfyf3FUsLoZ4p+xvIeDl
dZbn6W/C+Xe9lYv82Uuid+NrCchbsTsxcuRYnxCyTHxxuuic/wGkTixH1GQAlM5K
jkKgVmmPhczVv/nrGt4kQOk9O2jEVb2C45iXU+Zz2OFAdtQ1+x29pd3WRdSFZX3l
rwXcsyIJms7D1UlXxamDhZxTwbFKGYd32NVkRZi8spHEutbtUiHqgT8kzycN60KP
nHmyTWzGWO+I74ClFt8wLgHwOsrC2Z6nTduyciJO+LlApIdcxoYNQXYtI/VakEL6
ds/pOyIiKmacksY4MehlBTpT/o7SEm913k1YONgq2x0HgrTwlM89AFJZjwV71j/m
TzKfnlcPdwYtU9ZH0WmHlKxUDIKZzhqw7p8dd9sJzFjvAs78cOdJpEkDnoL3/9mg
W0qK+Br6ZdPNB7RyZKUAQSq681RvfQCeGLBr0JAqVOkfZf3s5GEcQnVCgtAIa78K
rEIw9ZcrNKYVpncbw/zM7C8RNof5whl+5mWBO76C7BGd5V2BFuQelmb6w4tF3vwV
s/+G2HlTpCXs7O/J465H/+BeaDpVKC96u3Ky+1EdPUNtlANvwzFAvtmdygMkQi2U
Ua/7/10rs2bU1Hsmz0sqo50T5AX5b/HWfXXAsyIssnUJX0QI0l08s9mu5TPdzYNH
cPSGqRYGEM5dDVYAsouSrxrCwrnCg0UD9y/DArr1MsjkEcftfblVaXB+pBwglKnH
bPRCHDlYX296i+YCfViNxlewhbLwJmIr1waP0oA3PYoU4vrj9Xje7NXQi1oYXiUv
xAaZlZVn314SAe995Q0+D8oTr0qpEHZZhbxeTin3d0LhuIIxaA8FByu0bL1XCL0q
G2Nz0JQnpgeoPZn6DYkMA0veVe1fkcZonznIKUitmDY5blRJOts1LxTWnZ0ktMUH
2ojARtJs7BfizanbsfVlR2oSI6ccEfg/cHNfeBhPPSGjMulzHCSgL31kTFMuZpSP
epOJVcGRDnBdXD5iBpnIiB/CcT2aasGxKP0QBcaClP3YTcozt/7XYlKqYxQQir+z
UYNuipfaojwCAijFDm77i8vcjMzWd8xFNuZRRanClpnP8NqfX4CTRqHVpZH/xHhh
rNPMrUZVxINbqd2eSt0uM6ZZOk7cineyxlDZgWkm03ennAN9NQM1wfAnr+QEo8Jo
efxjk7QRd4SLGSd923OI4jYo5LuWbhJr2l/4LgsAaU6+vEFJEEpySDEbnFuAP1FP
uRTdLtvAjJVTn3uloNOSVW6/p5HZcaon7g6U1fjxtzJ1lZDMSOhFbv9VxC7vz3wT
oMVkHK1PphhYJ7JrLD8Ch4TDf0MnhIAfYn94Bud0XilrRf4Y6HaAKy9R7i0//2Rk
BEHiWezZIZ2f/owVdBwVxvp0SwlOnYGdVFkCjRmPCangtFsYyNAWpAn+GQ44bYM5
2I8aHgYufNIKmx3afAvlvn0piLVNxGNYRzgxI3g4Eh6u+sa18RiqQbJ9Al5VE8wU
wQcNvp4B45un2POsYnvN2U+txVuZiH/qL3+SInZKKFjdy9Q4Isw/gBDTv7xKAogE
sPqonitvEFdRh4Yu85Gm13+EMLnCs2gUxQr/Z8kikcxgv1jH2sRPmo02IA54EgnU
7YoDFfJeLLrwuuTDN3HxxcWN6nGUdDN12EHL281mP6NN2K7QHaX1tvnCkjrZrkz4
kk3bhuKuhXat55Y2bA1KcCc2IJCNsDFxcanoCFPA+HOrkxZ/b3pk2pE0qwLgV9wv
9jCtveipET/u8i/weMMkQ9EKaBxFa/Kyg4i0FDvlP7ByTRgCnJPT+7VHT+PxKcN/
HO3Io8ShjZw3VerIQ0bmrfRzH65+k/eAm0RkFU/8JRhz4iCzQjJGgmK0ZBHHgJUP
AHCuLONJZ/CakPEGWCEBT1gN1fKFzzKHPOkNcY1u2wepcPhlmEiwP73w2M3ekERs
JEcsuJlTs+M9KYi6bTY0FD8N8IsV5o0ZI4gkCgR4H6y1wP3dXPrND/Q1s98Me1Fd
Hx69Yixp5XCnIFRcdoM3GEdymath7a+XPE9L9n28ebmJVc+sAc1lZJqkeKmvwhiD
F5oCgmj4212s95Zp1OWGlXV8Da1bAsYfS+yN0qodUVsBZQm/nA/8sGa+BKAaVce6
sHfJb+X1bxCgSk++JMKs24c5YOiuqWp1wQ2b+YnzIWjtgzG7+9BF2iXfcjCJT3X9
R0qU8EOWW9/kTXPxuxVXMaISe5BfUWC5AGeHNNhOjQhjvePJDVaXl+nRitSNjAYk
JnnKjVGYDQMH8cw327KBMUFAPtyyiyHUmNprvT2dMlE+LYvwXSWghYEdFyJr0HaL
nwUivsEQO+C3gbxoceY89PrEqUi4rpdiU4ZliRTQ1MNjBSTcQgfXPZ0TN9ptYWnC
TKGKr1Bu0PHJx3j/pJBeGYXzh1TdlQLca344Fh41yc/aioGElRpQTdhWElnBm5mo
fN4NEZbZQc7IB5QTNHNzxuR/77fy9PsjY5M29wSlzlmzxWnbgrLwv/zMEofGwwJC
N0R9LK70duZwWtdrh1t8HjBCgdsXkw8gwm6miUrSE5oVBb9GvRduLawJD/olpSpm
jde+0a9VRtJStiVPtq5sjg4uManNC8n91+OMVm6UbIIYUPQpnhiQXAFhZ2G1eMro
HstbDUgxCFSMCP88gW9DVtYB5/q1jHDNhTe3ensUZQAUFuFhSY4J09nXThofqkHx
RPidAoMBhaPocMEKX1/TOaY1B+Y/Y8y4jJJesGv2SB/JwQnDafbPE8aqOMd5KoGK
BB0OEeMhqJvjFb/7G9YeDgaH9wCoaZeOqSkInyMFxaRFR0iqv9O9PIufcFFoaWyU
lK4biomaYEGCZ0PTB3N19cluNNgBTEeUuViqJyQn31dW8EsflOzX87FaIQxJU2GL
MH8Fiqiai0CgJ3sLe6H8BH0dJnmWo/t7x5XwM4eZDddDDHrK2JehOIgd2EFXzlhF
i3UgN3ULfbZnES2Z6K+0dRlulrvUIPFb9Vt+4Km+uuZjJPFtyygqxnr4Z+ovNB9W
sXdRn+hyGyaTV/zQz8Gtu2/vsH3nzkIHp7039BAfvoTo7EV77eoi8Lbp9h8A2ET4
J17jaQx6IA6GseAjJDJ2dxwKg7uGQH4eb1ixpC66XK9UbKln6SloE3urPGHST7/Q
ERYhj7e+5Kxw+A2futElg+RikjDoY4ySL54EQTGTYgig7nxc3J+M3SkL0PH/YTF5
tQQVPM3t+OJKHMGsp0swnLZSxLq9yU9GDNcMJW+vSMo/zXYCebUPG840DMg0p5EF
A6LqEZN8vspRZZtAU2uHK6NOPQZXa3RK9WkMwHfVPeoar73y31qjdwdERgFJNpGB
SHO+TqJh+USmOgPnmx61ZnLRrLowRlt0zlPknkYJNdSr/BHLTifAooA6YEJ3Kp3c
E2tgVAXnWnMUEiSc1QDdNT5blxgMk1O2mRRfUTpzUX0H0txsytjYwF8jbORkMV0c
SXbZZTmPptW+PwtgX5z+h4V5yApAAlO3DIo05L7bd/oAJghFRHl9nJlMcJwna8+v
F/MLq86bU3U0Kh2yHaAGcAtS/Qt4i/pDWIqg8xYa/2xfakzTga57smYf3fNUNWXA
rbiGEXKd8mb/oiCVmFOMrRQmoPW+eaROk5+iOKUVziUZseIOMnKnqS5h/L4yj5hg
TCpR+pdEfASimOQNcvQ8e1p7ePvD8gfI0ip+j9Iz5Br4eHaQ7c0KQuCVPKWn3Rsf
HjRSy5zcU3ZHZjy4Izcco+X01NHfhej2PY1ZRW2/HQY+kqrwvgkN3QjR34w9dJFZ
fq5qXjGOX1HQQ/IVnIAYlLw6feP6Xh43WsV/czOBoBmx7oLt1wmCrVT+t+IALjIs
AaB0LtPoJVfgYW6vD3nvZxHrhCoSTEs5t2c/W9GYcrHH4zb4MjcOm2ixn5EFyWU8
7LTSOq7zo+fSoleBVPDmru3OWpsqPvCPfYlNroOBNLO+5kK9neitxKVBnW/mNCBI
uHGpFEd5Q7G7ANjAZRn8KzyfSyKVjasu+wt0MDhkoXLV03cJ6pffCKwqTJnMajzQ
WpKnk/2HQy0CF75j2ojjO6Rvei46TcebChu2mI/NooFG+uuLGCmkVxEiEhHsg1Bt
BvOcHrvAxTZk9zjaVAW4Gn1icLsqiHr3xJrT+67saSQ8Fe22F+3mK+2mDuWmOuwB
5S6/ePDg79uUluImq8AVt8dqPAksxP+Ay//KwD3Sd+6hXXXThKztjGx6WHLy6qm1
RAsk117/Ujpu6qqlm5XW0BU/FgFSnDLBgn/ahoLRbbvgbDSx/uqDUaK8U4muuVpa
H39ap/U4Nk49X1+nGXMWh3DwPIxnH3zaINoCKXTwkDS7LC0DH6jzz5cA4zXHLE89
TpO/xJeaCGi/fllhBe5zrm3RWQHxTu/Vp+YEONPWhRMWl1aJnxJGCcqD9IPHz3HV
5WXD6/PSouTDp711IrE9nXBP9DKthIminkZQ+V8oS6zYuq4qlFdLBOpAGZ7XrQCX
tsmUL/J5/rYrkNt7Lk7jeJkmpF/q6eP6Yp5chFwZFjtMgg7mqV641HRAAqs8C+O6
uiNRMD6GCmKUEr71TdNe+o+HTTs4cKkWjTbBeqAl/POQbYCorViHE1okFfjW8+Ra
fnsobQGfYEy5Hpa9qD5VhGr9oZvSb1KqypxJev2ZeoKvO1Spx+xFtTCKqhJcBe4a
/rjNcERZuOLYxxVtGcC4XbvUlTYu4TZd3L33Rk0pNgc4XwjcFrZ5wfFYVmJhBtRk
ba2dzCw+GqZQKdtbscY/NVV9pQl1ueK2DzTdVUeV1V4SkTeFrz8NcGjY01Juf1A/
sUeArGCuCnJd3Y2NQ6UZgw327Krjcmhfve8NuP8Hs1VkyZWHl8w3Nc/hdl7TcibH
5Bfn0NsZS+ohbI9H7MeZLBax8Y7XoWdBsMEpywnnGOcVYAJnOqTDXgIZQWBZxqk9
wvBYp8pVBqaXqkEoLWrpN2dMkxfq6mF5CVN4eiSOFvRGug+WUBm6m0ULPZK/af81
15VK7V4x0KLK2IV0NQJlMkYMn8lU00FaCacRQXpd0OtboTb4WbFIZyqnRFtX2stJ
gHy0qDGVIRenNSXi6WBeEgwCFb0PfaGPf0yvKvRSnlXwks73VhiXs7WfDqndRxBh
maZYH9hdSqnLcLebp5npHf6wGxS9aEjESfiPomyGSaU/+M+PGChxxfr/87iicPX4
92hzJ8HFflzQhNhgKsD4Ni9keoNhwWgQIg56k+V5m/cCxUK2YMiUf4Xc3p9v5LHW
wkvck+aycSZOwYsQOpqXAbrXcNPy74ngPKx65Ex50yb3SAPal6aeXQS/ydg8FI8P
7Ac+NYj0/E3RU6NoUi8QZH9XSVIZ0iqIVOZxOaMChhUEMr94iz9PrrCvxqThyuN0
OjFiXmdA+t+qq/cio4ei9Np9F1oZzia3zY6fj35dnUMNTrsXKOFoMRpjg7mwKFK4
F0RBIZ+QTtb4YRVNIf+ZS2Q81QBZjZhaafOQJ4ZhlnxIAkDo65j8oek7MM32p9Yw
DylD8fcd0cln5PzUBU46ngpFoUGP7mCykiX4Pw4kx/oqJcgrgfupCn5hGBUmWEv/
1905YN9Ka7wzIRinGWrGiN7xrt/h3+Wokp2AH4BwYG44dA5qOEs6L8jB73sQN8K7
19KWm7+SjNPcJlBT7549n+FlV49G7+xRa8pR7bFOaWcgfbHziotNdfnobsr9wucO
1olnDca37AZXvcLlr7YJ5OMg/plR5vdAYfKjpjGbdbgVqcGZXwhYE30y77XpccS/
TyhxFUHWEkw/vFkEcoOBAG/C0h9aNs+lIqtctg8adt7TenHAcsAR2Foq8iOcaHEN
NcmdF3DyrPMfQyanVTBBJLzCI57PfE9TVh4765tOS9QEmYmzraW61AzHSFxQH6SU
op0goEC3VUMebF1TkrKEbT3pJxNRy5Tj1je/7RLuhSdpYPgDndYUvShZAcAAmjVf
+JHx79OqMughm9pm7fc+kLR1Lvm9Wn/dXOBso7d6sTVu1bPOHdtD6U6JL5FInLpH
U0rQi77/6JCz3yW7Q3is70IyOp7q6JyBYDSBcNDV7fBc5reM5Z9UTQZgDspnVf8W
6NExiOW7p6cSa6eJLlcKRYKYaAhGwuqj1ZzM4dN/DJiOfIRjeognYuz1W++Tyda1
9AvXv8uVoh10dDC7NR4sOFCWM5jmabsvB2BA5ma4+yMT7K4xC9ILszMYOw8H8/Qm
UUeuwdSN4Pk08/0zokUE8/HN1hayFNrlVi4t7mC3L2QOYvD2PYb1dg/c4XQFxWGk
Ut8cTCccEtb9cX8lpic0dHPmR1OH74twIyDWCmmOlCrui4G6dAZHPkdLxGHu1/QZ
zV5E3L0Zt6a4CrWbZ7zsHn032vnBkw0iD7qJzeP5WWDFn0CVMNyrHTuwQRhWABLD
GNP7nABHAcUOhj3NrUlRBX1Yz4aItdzRKU45X65zQ9iCoh6cbDk08tfBYTOaz8sL
tfRsHLk5x2n3Iz9J7scOMgLI+jM3l45s3o2O/iJdEd4Vn9ElJmd2hLON+/iJlAtq
2bF/9K6anZ6NGJQGWeRormz1NKmBfHL6K2RvsVeJia62K/zFJ10FsdOVTJ35COBb
R+3bew2JVsJnSBcZEL/2q5LbaL7y07yaRkzHZ+ojAyiAL/0O8D7Q7LPYCBmlUyX0
arAdtFNLWdcDXYLPVN4MqnghmcSZQOG6nFlDApMp2aO9033229GN7ZbmCJGf7vqK
z9/d7ugm8D62fAhZdNoWrv4SKbsgNO/PAGXrQUzZyGw3ft6pKNcUH2YRrTmsmcI0
fskAb3ocpBZrI9Elh82qWRok782ksLhozfocEOWIeABB6s/rTdSIqV3DscqM9ZC4
Bd4Y/jPRr/4cX6QHgroWMJHAMmjnPlmWrfGFfxX8dGHKUCbg5prIQIg2Gwswi0tQ
u6RVorhnqgJOEjnHgi+i5JwIZAFrV1VUFjSKMVHeupG71eH7oSWOAdmWXQMPTt5L
wmzKnWlJSDo6UeACEZH4B/80pG9YLRvrUKd+tAxUAoX2KEsBhkgmbQEG93+q85lL
GKQG35hpsKy2jvPU68aIr7Rl8bG4GLEA4l3gmeua9TViPz2zUs1E/SkwVhyU2O94
DwFCXJlsJRC1wKlVE/vkVp6/Iq8CzEE6sq7BVZ834er5hOlaTpPK8fVwLdrZM2tG
bATpUyi9nyZDu0z8grcPr6+bC796oJVoQY6V4zUke44+dkIv2Qrv63e5jCxPCVC5
DTE3vzhbUS3nIXdQXVbU2UUouIAr9eNh4tWEWgLfibKHhYSnZKbxKzYeTz6Hcdk9
f2S2D9L3qJ0ve/zjb+AQi/InU6sUYnfaQHzcOBPRFe91u44UysJO/rSgs/aLhoiC
vTRO+6a6rDgGwkPssChZhccAPgXiq2WqL4bBtyBFiULlizSCg5fw0FIvZrF4jyEg
cvPDkASrHwCIbmMiq8nh+HnwL7goN+YjePvoEjCnhymICRH89YrHIld8zZI1n3JQ
lgPdJAwZGuG6iP5agxwROc08kQtcJ7UPEBVf7k0AIo2UN89eeL2wOIYh9nWpCa4A
PZcdglnOuHEAnlikLbBlL3sCvSyLJpxaM2VGqSgnC0rHeN52OkJF3PqbiQsFk2lt
8O9MSx3NJJgQBdy+sOkBXrGkis7UU1mkqCW3+2zm+0KjgmW0jZIgaiZNgx+87JRF
qHOjo+USvkq5CVM8OVhi6cE2nMr9N/y5DMhPsoEvbXe0ZoO/Rg2MjF+MX8wOXOg3
1sTwTrg1iAzoObg/vvdCpTq+UA3bAEH/uuSYZjxI0xGbFryDzoPAoe3ORQXATIuN
n1+Wyi9tjR17cDKWoaXbYxqR6U4/WV3Ectl4o+5WbYYwoNIyKT1cixcs1CyXmRvK
tqfzE+ALF1KGii2hQlvqOB/rAfOfRpshJwM9DzoMfgd4QPYTXIGFZR0a1rWnNmnA
utI/BxVnQffeCkG35hAS6XtgXsSbJ0nHGVT9+p2dxSXUaj5U1n2tYCH9R07dRzxy
TWz47fgPkKn18jWGVAsCYNjo15HK+dyRb85754e3yd+grh+A9kkjdv4ruZjwui9U
nmWGl96VRgR8ZGGHXHtkh2FEYwhXNBJxvw7fuGyBfWa2LM5rD8tsMoJxavhqQukl
vGGzOFzgVYnxU0Yj6OC6BCyzGePoPMZaPBHVu1q/QaqqaZp672XeJbMPWNLlPZiK
pSv4rCKVxJt7fq5cNSshG+tnllWiZMAxnmfzifNfp4Fn1BxjAKjNDLrXdruHhMx/
QX1BPyRgubywpnAy7WwLbDd/OLMpMTZ11vxFzY7xO2C4bQzh5xpItjnWcOLwhcS2
yMUjKTAtCZO+UUPTA3d4xwfWEdVfhKSCgYTDW75iBS64pKwt5uVfkahGDdiueiC9
aA5PTZx9D95065OOkRkXrZrtu16sR0YvhDDvN4coI4fBXHG98e/Meo65UCr60qXv
SVIazIXoeit1BuRDGz0XxNZCmVny5P3pj4R7iE4VCXl8iDFii1nzfQ3vMdKjD3kM
iht1m7lpuJbnvhroziEKfCYG3mU/05HLuxMuxBFZ9Y5AmImsigJCoPAEaZWdy5Vf
oZvIFkcSK7EEoCvc83q/9rww4xXF3odCKovQydshRfO8qMMaitMzRXVxjIP1DJvk
egwdan4IxDaCgZvYAtWIHbjCilHYxOB4eKlX72g0dE2RJxN9w3sbjHIKmX+KeWEZ
XP1pr+vN+oB6hQKBu8cItMMm4OUeybUZMaUKWLwdQESRgUZpLWUgLkDsr43lVcgY
ZPYlNdgKRcyUw02BFymR/KUnGWgC486If71OYA3guLBInxLtiBklqSDug/+GJirN
tIWLFzb/B2Wa/iie6mvS4RXtum8aQweJeJZ0qF/UZIsuhaKHGyYWm3Y310AIDnqL
xbmKW+JWXXVAbkc6YosEYG9d56T/f1wxdpIJAIMN1wyBrIB+he9ZfIufY+jHeFPl
DU0Y+P7yuN9BZ3w3rsTAF+9PHnkxsgBJR8Cfg7+E5LoUKFSghFQtnJeYVs4Loksp
Xl4We1mjbOvfMkinljAMXPNECqw9DRl7JW36jpXZHTnuvSO49isaeb5lzptZF3wC
rzBBFb4vh1uhxrwo6+1Esxar0EL228r2H2hR0iniVbab3uctVeZwLvl+sKbV7bWi
7DMClQZ7tjNwg3asa92n6u7iWdbAN/BlydSmji62lfDCj/iLlDF0QxunsF0/IFGy
Bt32KDYv17bSacs2KRfwYc4TqSCMKT/NRw4QZkJgur+RinxzwNUelwKR3duzeMrq
rs0rcT/hPuFr1NfevnkvsnM7Um5zvQ7L0CAAfAnvNzUlaaQw0fD39Ky3NbjCvjg0
pgT2eUdmXzOIbhaS7ToLJcnyWnIDFK49zKueSZvsVWZul5pdE6Tm9LltRehJcatB
EueO0X0cVMIb7Du0i27g+iQJ4YPHJDSCWMBQy/F239iUaShOlsPpmiHc8bM8BaLy
3RSwvXWh9rO90k/P6alrLjnGT2/D7A4o0qIoovH81uZeU9QDvKJV1AslY9Bh2bOd
NARKRX5htl3g3JnkYiyjShDJLMsQdy9OyDfalr4YSYFqlVy2DUXzWkznYMl3U3hr
MVi9Oxrsugur+btMwOOtQbWZ9eoGUJ5mJPYlmZhKcBKCjePKO1/eXMjffhfDsmH6
UwgllsOxbOXbfxJ5NkAnxnSenSJb4kMtBDAvRUpRK/YkWLLjy9ErPJ4S8dCkxRdx
PtcoYPy60sH80mngy3NztXx2fAtOestzSe+NoJMWIjzhOb1fcWJP7xErxzPUwEtS
hDWXx67jDcmrDPjWlUdavZVW1/dmGX+ye1VcLF5hTOzgMiz8iAnCkj3ygyETS9G0
NMpBMXV+Eq9HQu37Q9WVWPMd4dMMp7caPL0Cm2ekKZ/+SJm16CcBuaql/eHTcpR2
BgpNMYu9D0O+3t/1Z/IU07vhKzapHyea2NUqmg7BZ3Wr+RLbHkzgIrnV46VogfA7
BQ7NY0Xju2p1n1nFwqyfWha+7oOj0LVLtaHwTfouwJFtIVpq9j35Rf+S/nyI3QFZ
KuqtbC1nBAew2FpYaY6mfsOz/En2g1uGUpH0jykGBbMgnf6c5BZwdTZ7WEMTLkGt
XjCimBUP/Ik2JVGK83GXLSwbseJ6HBlW3bcwCLPfSmpIOGLjkAlWsZ2pw8PM9xgc
3KVQlLdScsbvFO95YejGxIdw7ifxF6+sNV7oxiA0POw7vJ5vO9nJiFr6AaAAtQ0M
Jxq5TBM42QMKjVI6DYNOfHi3dO2nfHTBfSQApQ+JOlCo1v72aVKke0ELCS35IExP
UpJ/I/zzb21aKID1i40CN2t0F841i1QglOaggfHLYttFh36Qh/+wUbV6bDah1fKB
MHioTUD8jAe9IyO+Wl3lipDIaoDY8b4PeQM5M/0Ab/QanfxBJkSBHknFVFBssBp6
O+Uye7f4nFRpp0Rqb/GW6gUyHAcy2XcwdaxZvzO9UpVKNVY6aXD4//1ojEPTqnKK
OTMsnrjgpDc9x+JXdZjQpKbN9IbSquGMII3eSaR/UBng0IyBDIVMj4GVGoV5QGl6
K5+iNpVJKfJsCOp8PxaUfYo2ZQRmzGgybkVs8CW2sW0rC+exXFz/0uuxBdkLebCI
tpH3Cylm8/lu99fWigbOFKvAe8U4mmZG1ivPm5TzLsp3MCWIPaulDYmbzGsKFERW
J3hPRfZNYxEAhOnLDAzOS3K/1rB3L/LpfnzYVafsCcBVD3wYClVRW5TQcqQkumyj
RHDd5IKqUMk/UkfoTo785qDlt8w6KEgeNSKd8/cZBxCHnhJdxf+5F2VoqVSESnW7
ubAtTS6ucZCYyV9n4xh3TlY67+C272KhLZH6cHLr3BCYfj2wpP/P9z8TAyzGW2Jm
8v813xOOEyL+vkY0KeJDXQks5ErvZOESV36uBHLhK+6v3Wb+S01VISX1eKFVi6bS
6DgqV1cSLU+h/Qn0c1pCUyIwU/RSZAgzzdC7VQvHChQw8sFrXn5mml6f45vK3/hB
ap5YyxXtYtLOKZ/Go/Xa3mYiF7AU64hP3sHc53imQgPlz/kjMhOvM+6JQgfSWZpq
hGNgaHhdRLlSFEu5Uyi46JlIUC7HD4BjJ72gSqocDvpz+zYW62ZokEhodUsSRnDw
j+lagXSWCDtXJ6upnZj/PSDPGoEOXjRw89A6UtpKm0JnI8CsgjSW52O+MRfnbjdg
jAt5k++5Hz6+3dDslQ+0sxx9OCale5oMeUxPO8Ijm4WUnpfgaS79qNXzxBaBKDbL
BR32dFVyg7Aa3FCZ59ydxgyV048lQeiafUYElEFN0TkA8KYhQuxcxi0F0HP8aE7/
raRqAq79DvR5zrIF0isYCnTFM6qk8yTxZaA1gxXygg0aTYSjCrJWseuT25JtPCaX
1YALq08/cywvyVtdzkZnXp2K6LSF8dbPWo3I6t0lROmx7bAnYZTT5qwZb6Z1O+Aw
SGlzg6pXeAEPpS+D6/o5x1iXcM/oah3t3qjs1fk8MLGtox06iH2KN/2sFbGph5UN
M733ziZ78lTzy7fVzj6/TaZ1pcEoCU5tgU+e5kqI/MBOnpNANk1kRCJHW+noE7U7
DgrX3bCfdHivYbmCc6r66cJxy/zsO913LQ3vDKKkc5Un0GST9rRiM6E6mB6bE2ap
W9T8d6hpQBuHmL0eFSmJrD0M6lyGMvJViyvpFj0rWLzx0jyYpnqYCWmJwpAg+aOb
W1Bom7+bS1fDMbCIDZ0gD61rv1oZY/PXT01ENQL3qBtkbydgNI+kvTdlP1NBgLuf
zPRNivX4ulStX8aoJqER7aoKpGfwnLTg+c8tZE9/S/KvL1eAA5ePV4Exs6C7trLY
3cUaIadWOG+mjlXmkMD2EfzYwza3JVnfMNjz7lME//7Vvv/k9Zed4nb+dJpYCI2l
4oV3AfUeAfx9x9QuBjLMlZUST6ZVCe1/ukGaO3V7sH2eoBI9rsG5JMF07nksIp8P
tJbpOBdijeqTWdS5AbHZKeiezyYq5JfsJfDI41IYBgYIllYhCBqUq2kqXvu+GDvs
7zYotFhuJHeKdXas2is7gZOEJbKFn63bc4uHt2Qs38nRA0FIOdX6C1oHwlZciDql
KwKLdTFwAEGO/SGCZvbD1k/KqQhgDSZNz0n4GzfHr1UZRJe41c/PA4K7zBr9zvk6
Iasm9Qi6Nh9iWNemhYGjwsG635bOtIXYUf6CdjHWNqXdHTHRjSJKIaqA/bS2ul3v
/GWVJUvz34ADJQ3vjnMxkdhNnEJo7mHyaYT4ObYeP3RL0IV1OE6IMLTQfZdIo9s8
Kx4DLYic0rvuiTQMnLCGnB3SH86tzY7zYdiXoFUzszHxRLo4Fja83h4p300syn5r
Mh5StOl7KWiDK/mCfnEwtnuaJjOLB0fN+SUtOtTn2udb5x9z6wQvTiXc1JccakJh
f2Sj3AeR61yaSTL3QtWyiPCEHJJ4GKJaYkBazd1jGbpjK0CLYFpU6dN0DNkBKoML
izxiV2RVM76Dfim517qWbctnAfhAPBwN7x3yxEkhCQKSwPzmhB5fGOTNY+M9VAIh
S4QYYjpwLGhOG6UPfWbmcPNN6QS7OGwkvsvhLUfCFoHdZEox5Z0RV5iwcBFHnjci
4giJImym1hwE4Kp0QNZYVX3ot+T4TdAi3U19Bpz/idcRot+mCT50G0OdPubkro++
5h/DEzjKtYcEyrluutMjmld2lh5XtT2HVA5urJG70r9bMtFE4Di/GskHfjbqE62Z
dEOVAZ5HMEd31GFGLGsuF5G5mZCPirEbNRuQvqUASPgNwUeNmQHelU1FGpjc6Z1D
Nlwp5gsp9CDxOByFoypbzV/e9G+Y9igYQurJfGo1m9q9dM9taADO8EWwZ5ZlL1fl
6HbbVWCg3PsLuRyPfKeQHGC3shbJDYYYMIyLRchZcDAnL0bvbI/Kx25KRiPnUDsQ
O2P2+HnImFG6eB01EQSRTiCZSrt8WUAkmpR2IgPv73EvKiUGRyBXReqYgWrNOgnI
EokLQQuEsB6wbJqB4JtVlOGeAjebDNGw35Y46xBH8CaqZx4u49QFbsG6vjNvwnSJ
vPalYzSCltk5UAwE3QgwO2xJH4uP+q2EE9Vpss7Xv0mlAVlNemC7Jpp2MmbRedDP
LnGDEvq4uFfzC5Ub2fKRwtFkU4f9ijopKmT7s0fBR8w6ADS6LwYnBwwXxYPdi6LT
5qwB4aTXMPYSpdfU1ofsU6Gq6WEpEWgpG29Sxq/dDHNfGWAJQ+IflrckbemYMLg2
62/8efnBxc/Th7h+/+TpelT2Ch7I0fNqNLk8rcve3M2L/bWh1KbY0lS5uFSJ894B
feRa3dt1oA7B8Q/8m+858ZKKrsw+/LiqwTqfwgZxjkeN3UrwAOQ0NvgRd16XEdG5
Gjxy5hKQ1Wm+2JtJd//IDdDwPBDg9wgMCy/hUmRmSlIf2V32WIHBvdJPoLLR/12f
2LcmQ3rKnN93vGRuRhV68G6OjpkkiGkILcfBUtOBgtaDYPQ6EDUYFYurhM/W4lgP
bIqEnysDfoAV+c3xFNu6XMgIAKZs6AA3rmOy3aEb9w3icN3FiCHBDaIewHQ+nJ3U
N9guM8B+fo/2v/9moVlsVHcI2zl7PqhcppEgadtOzMXEDGMtm6AKxZ9YR6hByLtr
GBZ65xJG4R/AWIJqB8ISXYrYnEQAU8PIF8yCkgnQza0blNu2u7xjZEjrNtUmI+if
HfgP8GW1sJHSUl32t1PjTbmeluLJFC0H2EUByZ5YVyJUq+a2nma3s531ngqs+Nck
+9lDzRnlyGsN4qzobpHnejDWo1ZSxP8aknyR0k7U/Gia7o5Mo+a0pBFhE+eQRx0V
JLAEIUlOQ2oY4M8Y8FO1BSh+Yn96M6oo4ASxx409lu59z1k9twM95ZP9fmL+hrA0
mEOIxjkUz4W81VvnUlHEpqSDiHW2lUhAfQ0DvNufRZnyCEwQyYEBaEnJ5xOPYY/q
gpDtzvdw6qHHQuG2f3iKR1WTr6JCFX6eZByuc/QI6O1O1iouYGaElCiIAFY3Ri56
u6SBoBINyKM8T3LgsOZvgfL2J8U3C1dsKg7Bl4synbHkk0QqkX/ZjqDLSXxEVrqp
FAACgXU1saAY1vhQQ4FVa7y235ofBSfo6GnDcruK6J31uw3BiKkHZOKlhKfaRF5A
Y4sQGDo6KSU6uAKKrasl4/8QMUK9RqVFK4fRLRHYdrB3Rbue17bSyi6T2QvDSJht
qfBJqk+cjr3/Kx71k3xsawDe67sSGwEcOsGapLhZiGv4bd8DpDVsdfyOK8VYLKdb
gc/e0Xbp8qc5Hb6/9E2I/SSUQY/7V3kytJ/h3aV/yFF1KeqzxFuhuMkCtz9k78dx
+ykNPdFFQ7ZACh7oxIi2fZ2sUA1dMNkXdQqK2kvv4RpNJCFsHtnQmBzQy9+7+uMG
PWl1osXBRstLhoD58/lafDlsHBJwXQRvnjN7fN0uTs6MxLjtCwt+TvXaoVq22KUS
xfolfuJb5zP2mn8tSr8GshECw5GgrHaAtvIpWQEVbwEIAgAlUjSFcVPZ8c+zqOue
lda9NX6o+GVADFvhEl6b8Rj4pGOdfTlnSrRDMskTyNzY0Pach22BzfnUYIVuB9TP
HP5jRwWbfbLxb42QmLdt72QaAl83Pazyrqewngk9/f2i1yNqxvLX8BslvG9GHAB6
A4o/WKotuP+iAnp327fCwtOiape298pbM0gRglxtQcYZHz682aSl9vKNaHJj+xux
sRsiRwhWCR7UjnpKH3eg8HbcQmyVk1Vu00+NyuqUUHnoZg3Mu6d2uOJRFyKUHUjm
SdlC1yy3JsZo4lN6Q4xplzl3PuVyY4YNs/SN21/SRSo9SIJfkhBoH+NqBiAME5Kl
xLzOxJi4jnJTCLkHpDCNgfE7x/fVSGhatJDBQ1ur5vtexcs7S08fHhHYYlbqpZvY
vT44jJvUNhH1A869TxzoEQsq3BUE1M8UfLYXJa6zrd4FKVgCLlVQzI6lfLv45q6x
/3qO3+j3dOIbbycQGIw/Zt/almyxokjyUBn0TmjXB4dEBLxIPc+dQL5tgMfraH5I
myheoRejRHPHwpevcwa/6ECsq0N5dJ6AFnBww8yQlr3J9Ofu4eh6ZztLS2x4fJ1y
X/5gRTcVy1W1vVeP0CYHzMGnuh7FIn2kswZVHjGN7HmGXzKIcMmm9PDlX3B0Rbc+
x6zTh8gvTuY2W1X2vD0qquaXGfuY4gd6mLKn7giTGwDgkpzRbMO//Fawh6bE/93C
GDlrTnIv+s/Nrc/0ByU2kfq4ceVUWxZFU81tnDyRGfGqBjRUBQ7Axlf9L8iUtcpe
pZo5KnbjgC55wHisXB1BO7WYZOvNIF5xnG/IZ2thXEk0syAoyNZbkHipOLcsCMeM
nJXkZ9kG2PD2A+ygXMXhm/jFyMZYDUaLNTcPHUp+ST3XyhssHfCuCszTz35E5pGY
aR1FkuD7AqYxGu7BOsArrWi2tLyAB05c6bEBF/Q31DLOv6QgXHDbJn4snKADPdN4
u8IjGyOzgIFcNlCha+kCIGUVbfmGSuOdkYgjlo2mOtIXM1733KiVazALuI7ADjrR
C4B+EBm6gZVCRMPWi6eJCuSK67bILVFbNPxwkj1p1HQ8WPa86WzkX0QyNZhIdGVP
OriRJPhuKSxoD57+EBg2L/9gjhhbSbPjbtybDbVcFbK/44vs/GJAc9NGogQHkD+P
i2FDrd651IIdEkCsdgfMXtnPMTAnhXp6r0fqVNwVHWF7j+rSpGx9wS4iuFzcxWuq
WwW4v9uPvAAdCunONvC4EeLeEe8ajKdWlh8FzQekh22dFYvt/XZvUdvBeOgBDTqm
KfL3dLuTzQZztyW90UhylbhwUYlCvtArGJ+cvPuzYkWMpF194DeRkC2aUtm2j8Ef
LVRYhUP6JuxNzjaxMpjwBwcYs+NulRL9peoAboi87/pOskgH6wt2yoU6dCoevfwX
M2TYQFyRrY2GBml5PsZcepf1J95hv3XSwRxWFxFhOMcqwp13Y47sujawz8q/njIJ
+DER4V5V/ncXGj1jMarigznC8lPaqmQZGEU6jWtx+nIP9W7ZWhYs3y9uGkRvSRsr
LgODLaep4RukKEk0cieZFrERHodmP7PPM/oVwlDe60hDjJmBRut7crJzpa3Y+/la
3RRtZ2lT4IktfPqR15pK8MDsI512gLQk0stu7S+hM2wRDi09EMUJxfs/pAUgOyFz
FJbV2t/LW7TdT0UcfYvqAIbctbFiPCWY4XlYtjhQg40DD3IqtzgXp6neC2+3pGko
V1LtOQuMRAs4B5ESU7E3fIVcZuoub/TL1VQ4Uf1ur5y9lbfSy1GdUfuPtk2Cb5Tw
rYP9ZpE3+9kyUoLlCwGUntSDJ3SwrvkyD6mHeUj+MKs+G924UE2PdLYmP/WqL90k
ir6mz/+Oduq+MixZf/l0cijXdgItE/NS6Z7vzrlBacNYxeEE/M7IZM9N5gr8XuWo
wAktFsBmKImUyIjAHaMJiZbFiWEI3hutjhKUdC28OfN92QK3jMYSzH8goZSKEMad
6oooD56Cv7cTlPAg9WppOizNWyy/iNu8gNQR4knyHUCBbJFJzjObSePWArKsoTxa
cxsvnRTp2GcF1svkRldXmSrFThm9JFHh9MABJJJhTT1KRh6u6YZKvWKGERVYzz6q
9Zj+KPO7BFPC37eOunXcPydEoRDZsZQ+2yIAwljxuY+33p7qQ75Uazar2n9HfZTR
eR0oBTXWszaVOuG0sOq4HLMPn97gpLhXocV8QpgwXR+vTTh4qVZUPJA4llBuQbAy
0LQ+gwanowqp3US/ZC9ebGv7IVQiWGXeSVPMKOSKUMTK6GP5BGJComnaHWg7p7aS
OzC2oI8Rx6HXxKr6JVF/5BlTCbkKbIbJk7tlWgzw6JdESSNeRoVjU05fc0+zuLp0
9XdPwPsePQMhg/kQnwHz3jp4cdZOUN8JKA31OCFoPgrKMeJ7XV7ZPjm2nDE824WX
ghBKUPrX26V5xReSeNLW3p727NEEP9+qA1sWohf6vvABwkwIafmRPlt8fn91Wrkr
mC2MkXXXTGPA8vwceQF3r8av3pm+BoOdQaF+2vxlXzXkYnRZN3hcZsZExtfop6gs
nXZktFjKZgOOrQrBpLTtA+oNzOoLg4a2VeRp2cJPXqtsbSrbaNBNesp8CnMkU/9c
msdZyzbJli3mWVYdnJErMmdzqVnS22b0MAVSk69hbDytNWrbWxd3HkouEyKgriCH
NGG9+PBnMnsn50PxhXOaI/8yzx2wrKgPU/XufcfYMyjGj8UE8VayGaeEuKVspAHz
7fW6FmuXcc6i/zCfcvHbFgR8c65mpR0ywvDK0wBbmx9LHQY1gh46vu6mygyWBizG
MgmlF+0q5cvHrTjkszO5VDQDnUeUN1Xzup2g6OKth0FY9a0EFYHH/1KCEyu9Ol2b
oOU9Ru4agx3hl/vnGZKI5fPt5J4oEMY/ldGpimfZka+5sGX8poQAuNvxgCjxJ1Xk
DJ3ZdIc/j0VsZVAs0rPtlRfidaqZ2T4wQA7zw8+eOOTw0JUwnKjq8K6R5Ksx77+C
IEIVxTH4bYLLUqKmDigJUHprhTUtcBxvLvAy7I/+JF5ZMzpSC/FtiMer1D1M8Mnl
O+4LD3kyQRYiK3W9l5WnOU13ANzpaf3fvkcE60Y8TFRws9eGDohtQ+g+1xKZU+IW
el3GKdQEdWgBbZptPNC8CNGQAEKJ+4PwNvqMuOVPo5bMR7GP5/WE5rlQWZwVW10Z
dWojhDMhAOt2lUI/NiiBH+wiIRdmCqqerrgSqshUtVvomXtnexVbPV2/YVG/qUVj
l4fwQBKmZQjFfIhg7r9b51Hwu/qreCWlRETyj//AS2ExZdtci/iy4BkulZWwTspu
n0tgJnr/V58pk3c1iRHuoKwY1SG6ORmwGk6CuhyYVB4pk9StMjnDQqmwLcSen4A4
W64McyhfCujkhJcDibisaIUZ8X2T6Xl1fUhwtXX3QSAaL9BQ1EqenkewPNQPS0GR
eGKIc352fr40E32DIlrnt3aDKHO21yTy1NbdqTa2oaTEwna+0InqGNEc0P1NJqeu
92b4FgyPQodOqmtUoYCphudAV9OBE7uaZfijGlVqw+0JXefmk9hUyrP9D3hF0Bz2
M8RbiaSx07BifKIpGXTlDP40KmnjSW3LNFVUadJxnYnbxVsZy746ltyhf6Qg+vj6
ba07CZR5+/CLzcpnQpXvIMQpyFnTdDN0FSxNrO0/yrsvAVcumz9HIm9nkADT+VJR
/q2DZvld61zR4wvntr4vBFhXN85bhkhL1aVS2B/EyhqpQMhIThsuSilZ9VsQ7T2j
2pllQ6tHnNs4m3TRVM855OJRXtr7R8Jz/AsBoJYG3OdqcrRIDnCkSJV3BwhVbwHF
JfsAdqcfB3lwOlHHf+3M0N5TQHYSMljkUJcmV7DnWX1WGZ0alMLAx8OCDsacMzCo
06zJaKdqFzIqA/Nc3IiQaWUdgyMb5pcHDkXaIeeR+pFcWLEmLmcbMil0cuKI8GuT
unnCgF/LhzwIRCdB4XUUnpCGDnfI80HgOpAZSyQ7OOcX8bJWGl0Cogp/lZS0VvoI
+NfvUDFGaxuDIQe7hBaWMfPHrRslMHeDV03AiiQ3smzPceYxgRICzSrhPgu0sGOf
1P5liKWqdEiZgKEA5XHqoXfgVaMRgiTNE3BRjYrvUAso2ya+kp6fiPIOkUB0woEk
2Y5/28zxFKLXNmuVPYsK3WZCK+0bThvNcQC1zK3PhZBOrJAkV9YCprg3jZeNMQpp
xEbGb39Ws6/LhLuYRmYK8/fs6gRPTKAh2gmgoWVT/LpLbvn4QpNyXEXJoz0xE8F9
kIw/ZtuKFB47blvolfysSNfkIjkfPjbuM3aEDsD59KPWJYic6UzL1LijB/OgGOpV
djYZldqYaJHGYji+9lVjt7Rn7CSB/9YGeQMa0saSIHjbnmObhSnV+l8UQiWdfTKy
r0co0XtARLnl6F0nGm9Uf3FVVjZPAqCyhMHVEtFPgDyG4bxZ0/F9Mnipaujz70co
DavniW9Yeud4yBDJ3NLHZ5V+5ZUxTp2mJsUvWQNyFgDMX7KvkXZv1rQWxJiDzfVJ
euAjU+zgF81LyuSUr79diS80lCD+yA3Wgu1TXBdaOf7XX01ZX2YmboDOrXN5zwlQ
QmFMxiIeJbezxKkFNA8y2rqDYDr2OWA5uYoDzpGJikccnWs7GZ0Ic/dLdfcSvBfV
bHfJRCTXBES0mVH0KZd/K4Eag4kULUPuQK5Iid+CVJds/Rddq8qrddWB3pXXNWy/
MyMX70XR8f/EOZDbpSnKQxBfytUdntHzidDq4yHkkwTH63AAXWqEJVC1fMI3sgUs
uI4Tn06FxQvOOPBTLV+BXMVB+j5Z2FJujcwMcURJ7/EmjVM0/Qrs3q3mMNjuWFVp
b8BTQDSEUczt8hEb3MyZhNB1V2a9sLWWfIe75gVuE4qYdMg32Hm3x+aeiEJhigRm
bbHNSgojpl+ZNupONss2KOIhTb8M9V34Wz/lIBRoYt1KISY0skjzw2Rcs3pHFKiq
MsmKSDy7wq9iOjiRNpORHjekIyan0MoIUsuz5wA8nDKVJSbYGgbwbmmd53W5R4h7
0RgkgXLbgnv82uC3BhIl/GY3qG9vu3MnUs3jLzVWR2n5gYJOnaBDx2/Xb8MFByh/
+Lw8ppvWR4EJE9LImhWk8sVLnRkHxM3n7E00iimMLcxciNVXSzUEEYxPzlYMAWdT
UE2FBEsTetyIR9QxA0LGoIzLrSV6v4Y4dc3basG57r4VCVYjMPENeN6VaZP816Ke
sW5I1C2wcpPvxuBRPskDKQHPq8tHgIjBgVyn4hN34oAk4k9w2+oT96L6IH1DMmQu
JvQMqXFdPFf+aq3wyORnk7qdDSIzMLzeO+zAyC7TIif8v6VquBSIWgtbF39iJvfs
LvLjaCaImluwrhsgeNiRqA2m7uw4tPd1gpvssQ8aFIOJPsk7RF1WEA/T2tdzunVa
ArgD5vbsf+2oowpPiVszwKqHSZUVcoyjjCFQGGlj0gbE3s8jqo+slhPv9xIw4fyQ
Gj0qrHGP+R1QdnAXnXylTTRs6Sk7Sb6mrS3BfsehInlUfS85/Pg/dPhbHwWnOy1p
3SJ4mGcxcoxa7d+pRF6ziu0ETcniJE7JVNIBmACHjyDKwD2lz901DF68EnK0ygR8
e7I1KhpaePETfhaQiRVQbuzMslHwOiu0bem+7lkFziTETvAQPrfSB/HOENizaNIt
mH2lBJk3/eWgeiL/h4FoVSNKdjcixedQpp49XfFFyQUhnC6ORz/j050piPFj3xxV
cXIWChA5gK3YTDY+r3/FotLcrn0Fkl+5GT/ry0kPIL5xCUJ0VqIX7JsZWvHlmgYO
KTQNbJKrvvOK5pbjqoYNrLa1QFkg03R6K8E5cb1ekt1+7DscGc6xC+dDCu1tiszs
2v8t0SYtJaKB9AH9j8p2tCmer7+TXZs+9gXtyk+xmx6r6ogjxiWPIOOmrxXEpJQf
bblux8bIoC+YkhMhxWR8cOzZyY1P9+C0URBtwwC1+n974k0glkTG3JG8p3xQMMgF
9i1dFTRqqkHFf5os5PjsRSQDqkxT/JDi4YRqCga+xqzh2UnKFeaTqQM1CknyyEZw
PsVM4ez0rrv8eN2Nv9cktKXjhEzhrOnffIeoYonWUxYKcD/CIRfJI5EdNf0pJt/0
sjO/BVhc/PA0j/8zPhgd8NdsLoYjOfbeNBabfbgI74Hi3Miw/ycNq8HDIqaqNvV+
7EpVOjaChpcYyRST2DtjlhysKtpAQM6GGJ1V3hY+HPa80Dpy2d+tUC+gvySDHmNP
2EJjJthtHshdkAktzbsyIlNdAAFNwh8TqEzE5WSXMDD4eruF2aicLoAPU/aV7oA/
kULpKFUgQkw0tdWG5bZqhImgMHkr9u2Kyl5aAmJOzutXQmF1Cpu/8BbMiMqByRSS
nDzglSKBRAa5/8Tz6V3/1qnGkE6mIXf0zFX3qGDmSyQFDOlqUXqGEtBJ0Bbxfn5w
+MiuuzfxVlrZ392wOyT5sjLVPaXJdGg64IjXvKZNuX02AsxjdveHuTQ3IlJPe+WC
YZ920bkHMR9c+VdjBv//Z+DCpX2J8mhpI7X1I/cXzhVVJQZawhW6BGgMLJ7rND4c
xzUwvqTUtiHMX/2f+kK80y4p3ZZMMfcEXbisGkE1YMRcow7QbKV74cSJb9QPT+ko
1U+FPKa47GVgWZib2uEMEHgLiKNH/9DRiPmjmLjCpsO3ERNh2Bo04MJilJytwwiD
TTn1SUsdxUoDOeBDIo0D8wJ0H35C0lY/VJxRwftr04uHJCa/ivmEwIWlWCkHIcYF
HttYguhP2GsTLvZiCgYhjdkVyzSiMb78Emu4Mmhgt4zi48Cjd6TgqurzwPSnMX2s
ZOm994tJqxCdoJmNul6+TTkXA57oFI2r+gGSVm1U9VubINV4dwf0igSmEMrqa0zi
1vsIdqWCxd9fc3ZJTsb5hmHndC5yxhRakmqrrpZejNv08oGX4J4c+sDcYp60CLgN
V0xC+Xon7f2Oue+t2xipmphYGte6zcUtWMzmyvlW5fwhM7B+eSO4BIFagHa6nurs
LEdfxm7Nw3bQP9AtCk0952E3/Nx8Bb7P0Q9vlzkz1Zgt7ARaRXleprUiTI3S51M6
k28+a4IsIxDS++jxXAD0vDQt0dH0HexakGD0pBswZpOIl3iF0TCewy58Qql4KNHW
0u4qdQQ7HcKvnf8PVkzwsjFDCG8ffWQRZOijNGUZ9eKgE6ewQ8SpKGzWgyT7vmKy
JFctMH97h1kVl+oIzEs2IojrhpG90LLNcTMs1ph3QWCyYPpZnBKsW7lG5qD54zox
znrYIWZ4n5Qzednl1HEMv/jVtYbKfPAHBwi68Hp2xwW8EcPj/CbN9iL3XYpnUmi4
DGsbbcIvd3jLOSqKRmIf0jjfWB4D8wncR0uhZyIqAZgaUTCVELvNuZd+hChQqjQT
3QNgdH3dbkwuwhQp3KofSOixGK4udThXc3fdyppagLgU4KKJCMfBHxAvKsEsD7HS
zAjM06+hjj35p3R3W5RDdvILcBM3cjwkyBditwMd9vC2l8I/UgkyFmawIJee5Hhz
z1ew3ZY2jsKRR7C/2RRxN5KA0KzyW8QQk7lOgnSHxe/FfSu15uZOW5RzKjMzuXHm
R/JzSz92Dyx08Slydgoc+rEzrR/rvXZP4Bga4gRB/AOPzC2wifLxh2ivkuhti/Fv
H770JopbPQUdCroUSdVnqLGQBq4WRXvspnYdOK/Q8Bhuyeo5S+cWASl+O3glHu5Q
DlKxVbZEB/f/1xGy6DfWjkSTBYW5vLH7/O1KggABO0y7Tt6Q2xcoC/kgpBUxbThO
ptTnkx81IUnyjUL9NwGi6z1QbEn9WJc/pMDo7KqOFnYA5q5/avv51lzQi7v6L6Hl
Wf3X/FlecDShaQUtpOz31Y3eIe8+UgvR612XRHp4/oj1Jx5fubXJyNtHtvo86M87
hJCWcJQmdCHRFJUy0wuYlXWIO0r5yKWSzKBxpmuntc1rD1xusmKpiGjO+dRVCrlU
iES69O/n3fW4BKH34pVTav8OJTCnlIiNUf4RCwPFAHt9l/lMeB06F0HHGORhC9Eb
n33owc21AkZjmCEjPUNmbX015sWtgx8J8mEDeYSrt4i1MuaAbo/H3nrJbrX3PSlh
rlvR5GQ7qX5h1MH3YeLs4j+LqbI9OjhsMW1UgIJGluIh6atdOirov9CqnV+4FvQK
sBui3fRe2TXPBfZHSlosNifIT6qyc9SybVM+dPqbWYlEHy78Bvdd+U6lGh+Lgzoh
qIUffKNmZkrqRwCbjNibr49dIbxf/LiSDWdqaZ19q3lQ0tO7lNuH76ehc93etrAE
Xhvw3IB7+3CnwWmjpCsf3shqwUv/7VgNvYI8Eu63H8sXMirjQsP/4oVrkIh1SxLl
USNUMJrV+zVRmMex3IxcsxCmE1+0TnW6qW5V8Xsq63BYv4Sg3tpMgASMpLBswtA5
kI10HIDmDzcqFm5m6VI7Z7yOqZOd485ZHfV8cD8HbLSZmC09aJc0ee02PLF273D8
jaG8Teqso+l4OHRX2yju4v9wlBNd/3be2mAtXszZqdeb0QXgCxzhS+4iB+P9a6Pu
+gMEqQ2wZcijlG26gT8cXgKD3vrd0ps56RvkrOVWCc8QH4Kba7b9kV8K61ZlYPed
/nPeSqhPauS6RwD8nNkam5RnrhQON5oZzw94pUkz9Dy/olYxAdIkfOM5V42G+0WB
+lLA0SNYFUZDPsGNXrk9by61CGVKyfKRuQSlhf4XuAZR4V007UQ4X5zxVQMSuIRA
3MDPtxCXhXilGSGrhEKPd8MBJtwDHqYZhQjJjzMmQ+/yHwo6AklkxzjaJdL/J9mM
rILtfqpz3ndVVTTfTpb/UUIQss36sO99f0oAF/neaDQP2xm5u42z6mjEtdeE5wXs
pbjsfJ6a72L51zwqVYsM1JruMIfQwVxrraVHM69MzrU553QHnHBPGyST/3fBrgS7
/rnH9dtXrzG7sIBIEMYYAWvvylUjLSo6Kf+XsM3rjWzZLNXNM3uS7/beQjnJWlct
jvQyVjH//wbvkeo10JNZ+P5fWu7fxj+W4vkjIO7Ouh3HK5PsaZWY249pIqQVoyq8
7PYOkVgbXvsVrJcbUwsBpswalYIG+Q7s88jHinNfbnicIVAgSDsE4eZmJF/qiX+u
vfoPWR4yTHQ5H0nK518ZL2tPsDl7Kp2xoFY55iNAZ+iF1wj9rybbdCFizabgPxoL
1rAk788d6pmH1Efr9ZjgL/ulA1g3MoCgnEOzQh8KHAwkvXQd4RaVSaIlmKIOxHVL
ULkYCzJjZrUjrRwETUBnJJrg4q2rfZoFP4r/WSBHV36mP40as2i8zi6Bs6S8Iknx
/fQM7pLh0mjOFdLBiZlNUgjHTpPmCfJBFsYlgcKdi0L50pBBrXDeQZteQcus7+Jh
DSSh0DtaErsSk2Nd0Cv4V5qZO9CeUubII54d40X5fu6kXDF9stBEKFDQqKc2T2gD
xFopDhGecb3YMAXgcR04gjtKeopXtNxiXrKMsEHyv8whsjq2AHyoCOed8HYaFrB+
fHkXDVBrl0hbPQR8QehFGxQTYJZErams/r/amlxaXTUs/72BVKJf26rsVz34lO8z
4NynLmiSKsTkNpjXy//DuC66ryDopXp7ecL9iZfXBm2BEpCAPTR3vb3XMtmuhBKK
K1ZNvIvDJTJixUFYPLf2bpIoz6r6N4rGnLs0yLPDvWW/LD4rR5Rqj/BjsavqTyS3
ChBqYVRoL52NJCw7aGi0tq/CMvG2OrIYz0VOhottLBS59safTl5ks8o06Vq2hpK/
RyZT7vqJDSFkg0zKwW3/mQDkVg/unm5L8d5QnKqX+jUzATkMUBu3gCtExeL7wgEN
+DfGEZs2E6I4AJrfgi8DYSrtsod1bOGsIbZUvt7dFHuTsaQUZ6i6YM5e7FRWDDUq
5yKmgDvQJ4nc1fcHv2Wc+jk/2YVeF5JyX8Wkoj4zH2mkxisscCf5eDxsQrP8cvCU
pG35jTtt593vrY9rD8oYxf02BYsud7h4p3cRx9qpD2vRHi/a53xE55Cotnc97CSE
dTPS5/jLWjjskkHTLQOwXxtvBtb/LgoLsIB+FVgRW8CK9bmEqWUCNF9EdHoESSFD
S5eUuJGK9NMoRrFddxwJEnU9JY+mdN7um8yyTDZNANq8CC6omE5awdQWBl/LVaV7
iY7PodJ86uzFgbI05twO5f0yX8YxWXvoVEcpc7jJBlnzLOq6a744XB1x44pps3e3
sZZkUmU4D3eN0K6Q8sjxq6PdrrTwHGpbiQ/0oLFMVosjKljkJ4wgf8UXTRhFUMvJ
hF2+Mu0wdDuXh0EQLg4nn0ADxZ1VhVVblJ+LaSO0x8ZiKHNt+j8K/lyXSgYgqFQH
7VHcsESZJtHA5XUlYt18mXB/AxNOOc5h+OqoH4TztkL+gz7SM6aRCJx60qySwDNx
0Qm54NaTgi5RoS67I6cfCXifaVghnfEX0oivdVIm8pL4uMs3CLiYYJ137cqzvxiL
pg3LDxuT4hKeGFQPyTiaN3M26hXlqKt9KrVBuDFvOJwiIim9HOAQGkezY4aljte6
1uDi2MVceDkWg6tCdzTuOC7YwCTYvuigIyhLfcQ9KIN+nxG0RrxpPqMtGNhJ304g
LyKjzKGUjPhden6bAfJiyzP+CgSMRuQ2ak0SoyztFKstXF8YjK35zKYXN5Up3HJE
klh/QyTNSHVyXr9cVNen/qztpqlWeLufelP/T5BmyKefCyjnoOlu+BpSo7duPxlp
BPPIQsh32KuLdRJxBQbrb++YNay6EZuwdS2VYRLPSXPlOj4Ce6orHE6xpQIgnZfi
+3BO50AbJLB5BuOH8u5C7Bx3cdoUc86Z5aiHV3hsSgZBVdzZgYiQtW7sJ9uB2PCU
8/8ifUV1DTOPG9LyO1xkXcS7CLU5fdiKkw+IHtoelPxVk3Q7wDUwz1wfmYmUdRAC
As0PXE8Vj/4AqVP/+y/q3ATrgd9JX9UgcVc47NlsK6r1bH0CVy9tuz2QZsjDzMdN
t5+sdssznUvIQYUKi3nUAWz8VYgyz7qe3vwrGsSXeK2IrN3GgA2MRkoc5IPs6OoY
DZeerQH6x15KxcXHFWygfg0Xw3SADyxREB8LUJcCnWcLxm/h1iYQzSQ6Vdql22B0
VHkdYsrTBCPCt4gFPHSdgAORN9S9hTiAMLY/5t2apFScpfyFq6buQUa4AcrKCCKc
lUodanbTpzSBpT1IvIXHR5ugR3DFO67ah7p0SxhDt6QJDQkz+PkwCQ8ZpVf1X8yn
fq8D+nAbVfK5v6LBDgdADPSu92NST+UNZ/6SUQPlPZrDTlOvoTF6nVtMeetsztUf
CgvjjhWrXGwC5OEcgHk1GCERat9ftCAXjcOYLOlmsHk/uqa62ZUMuQLD7EJrCy74
kKUS2GCOyqKvcKQWBW0MUMYHrv9qoqCd857sEQlepFgbKQ4C7w4FkUrQt6OrLLK5
TfyKZ//7MfvciIN8fPLv4o+YbUmb7Jq0KKwwuuDWXrg/7DFIMRzsDpKPQbWZRl43
nV2rK+a17iTH8W1KO4lvmb8hWO0LI2OuNTw3JrzkZBiiBW6/Nq84ZiQ242VCbaF4
7zUVxfOJ+rO3++czo4XOTp00Lm++kpOx0KOYWIGQNL4jv2B9a1uYiHOzvQ1TQJSt
5gAgUOqRPW5XpS3mU4P4yqDmv53bpqtTh9TtAE1N0cJHmg4MhjXZcDxnu6qb+mP8
PbyqzmTrHgXsaN596ApRA7+ssqMeFJwN3ZAgBx7sWSBDUyINv0MnVEAJXWNz5Aeu
D/WGR00JyW8wwzgQe6wLEjbgGnKHd8NTLwf7t5ZWJUV9ilrdL/j6coBIFJ5KSqly
AsvcChIHGj9XZO9z06KoURTGlDSYpWQrwFPRUDA4NNN0v8MRi7fxRpaxJWftfZxQ
lOWO14gz15r8Y4zJ+XgCAnQmxIZYQMWURp7zWrlOGwvepYOrRo65cFBmy2FkH6U2
ttUSnb8XGaKdE6sttFPNtoYh9ewD+USp1qD9nDSD/glwU0fhsw9MX4nfcaFBAihQ
k/BjRuWcmL9HPnxJDKQRpBXMtOblbB1Xx7bTDXRqtEgdfFCvDAZS5SNmx9F+4cm1
asRoEh72aPw+FA1CYgJEvdquhoJbh7zGkzcSDArv10l/BkzBfsifFf83AoQPAxDY
cZLLS7OezIl+4W2BEAiVV9kk4uDcceRjtc8AkKAE7avPEIEWAcOeXchUVLvC/HOl
+gsdTvR/y07Nc1RTZCa1H4sa+NISodlGXH76mnoLpel9I5bT+AvqdbF2kAOhbZiu
/WDlo47ovxTsVW8XKDGfGWF2l7LY6hEux6TWpemEV5lOEuFx47oqPObNBsB0ur6A
2N8XhbiEuIv54ueBV6H3YEY0rAZDkzH8BQUY+Q41Ml0rQLTS4ZRoAzFaXoY22rB8
f6dWFpfPeURnBERVCM1pPjwUpUWny1C66C4pb2L+Zmh1bTC9l2SZDhBbypTTOLLL
4IheK3IzhHWo6EMGc2nB5zdjsZ6TW8iUCRgmfES2rlYw/efyEmDb/eIX823okKjc
nZ9+ZB1AL08eGdmAODir//1Lqk159prsBZoF93Gjszqgv3zHn9SQg7Bz4ARO03ru
BSq64C0VaGAm4l5WNU+s+Cd6x9DDUPhbeeNDrvLgHlQavVeVghWedYIgYk1XaGcu
vrNLGO0hQfnYnY6YCwuNF+1s2lEwz3mIEdHfU094pSTKZwjvrsUprKuXTLXLY6P6
OQn3nYjMxhmDX8KEtMrLlkPKgqRiQKvvkPOY9I9gFjCSLb1ZaO2LVXGcRvdknVI0
FSpfH3+Cxft2m71PTlM1fxcd6+BKbwK4s1v1dKTLQw2Pzd88vaNM6zekvCy1li7q
rhPruq81aCL49BliXblitNLW49/p7WjYEkBIs3xH2WA=
//pragma protect end_data_block
//pragma protect digest_block
ERbVkdYkw+kUWA80kOwGcVP0tf0=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_MT35X_SDR_AC_CONFIGURATION_SV
