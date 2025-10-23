
`ifndef GUARD_SVT_SPI_FLASH_MX25L_PARALLEL_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MX25L_PARALLEL_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Macronix MX25L device family in Parallel mode.
 */
class svt_spi_flash_mx25l_parallel_ac_configuration extends svt_configuration;

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
  real tCH_ns = initial_time;

  /**
   * Minimum Clock Low pulse width duration.
   */ 
  real tCL_ns = initial_time;

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

  /**
   * HOLD Active Setup time
   */
  real tHLCH_ns = initial_time;

  /**
   * HOLD Active Hold time
   */
  real tCHHH_ns = initial_time;

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

  /** Randomize all timing parameters in between declared range */
  extern virtual function void set_timing_params();

  /** Randomize tW timing parameter in between declared range*/
  extern virtual function void randomize_output_disable_time_ns();

  /** Calculates Random Timing Parameter value for #hold_assert_to_output_invalid_ns */
  extern virtual function void randomize_hold_assert_to_output_invalid_ns();

  /** Calculates Random Timing Parameter value for #hold_deassert_to_output_valid_ns */
  extern virtual function void randomize_hold_deassert_to_output_valid_ns();

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
  `svt_vmm_data_new(svt_spi_flash_mx25l_parallel_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_mx25l_parallel_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mx25l_parallel_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mx25l_parallel_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_mx25l_parallel_ac_configuration.
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
  `vmm_typename(svt_spi_flash_mx25l_parallel_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mx25l_parallel_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
P9w8QOhzdK9tWABhJ89mLCLNIZY95E7adfWEUPH7AQcf6TXLc5whNMjW4ZRLfIn1
d+Xt1Pf3pOEmoDhknfGt9O7nM2/CLg/LHXs0HQe6n2gyz5Lb3JKFjJxmYFlkCiPd
7qTKfcADCagdOPcE1EFvNqYIaxm0j+ENu/P8BjUuDWkdCBLMHiaWLg==
//pragma protect end_key_block
//pragma protect digest_block
zXBQHJWb1OSSoWRhOCeZk21gxsA=
//pragma protect end_digest_block
//pragma protect data_block
00wIxzKhHksOLdwqh0qVBR3yvKV3gX9hxXarGcfTCWriyTdELZHt6jsWhfkfM5YG
6DFTN4RF1tdVfTmNtlXzLmADniJ2RDiDoJQB0nvSFYJGATx0qYua/pn+RI9LWq5o
CkR4sUEAO8Fp8gG3X9FA/9EFBX/CE1HmbxowZt4uCStkRpV6xKBOBsJBA7WmS2Lw
a6XRNinF1sZZyAIKIVo80Cp1HYPP8f3+9Leqq8Fgmu2mkInmYhuK8+YVw8IH1lR4
cs/hH6YtdV6DDkvaR1E1BWzrdv/Ylh46B3uq85VvCSO6d4xqt4O84gJGhtktMEgp
Szo7n0GAQN4rjUwuI5LWoLOuXrH92eHL0NKZ5zKMf6zJ5y4WvSsIMVR2BvnaNg4o
Y1H6nbzbPssUsPqi4Jgp0UCVbQodTzrrFKfCQKBriswCh2MH4sDGC5fv4h/invMj
ONVZXQ21h258fd++nYnZFZgwtvk7leQKEKMHabH+Xn3bWcB4HZCpAMzntzjDgwPl
W75DjttgIQ6t9KJzwev7yhhA90gBCpb56hh/e+QtgyMktRvJaMDe4Q9QGEsOjo5F
9xdjI4xzTYNLCPfNm+awk/ffkMNtlm/AaD9yP7gRAT+oORXfxmGERs5+6D0UB8iU
zCiZDJRa6UAHJpQOkWGWMfbtk9lGHwdH699e6cmHjL0oEQ71cDWSFjLYVmQvtYXO
nM+f+nqoaiV/F01lToWDuzlUF5GhIsnl+4oqOkvx6cib+tU7lbhUtNfeCPbwEtDJ
1gPTg2FqGEbtiAUfIuL6cIDjSZnUymqUP5UxA/T5Ccub1ktAYS3w39GM7uQc/R/y
V0m8wagXL7CcZ6KRbDAZ218RuMpvs6CnpC/QMrhA5T3eB1H/wZ2vd7fwhz8rpBxd
PRmBD63JzpZZhtNtt9vA001fp7wpX9v1nJLI4dpv+TkORDADPEO4qlpqz9N9+pYu
lrjFo/Y5+eBGTSi9SaBq2KXvTNKrcLh6CWDCexR3AdSMj8Lzhqu3HrWId3uHZG5t
lqHqEBwzv9TBYABbCCyqpNMqgIHo6eG8i+iI3gTu4Q+hr6oD6py0EI2X6A5n7VHW
fds28Mxh8OGnWEZtLl9vMUtkdbFwa00+34c+XZAipDb4bqQYSe883VB/YpOcq67D
8qu5HCF1qWwb7UgxkUTv/CTmnDvyzoEkH33RxekK4HmyE/lRduLaB3uCIl/nNzum
oKGkPd+GFeB4BQV/oAnDqLTEAtDJqfKCnyiBmrTs/ewI8IvHVAMuJ+dwVB+Lcz7x

//pragma protect end_data_block
//pragma protect digest_block
8oTWEyXM8AcLyunRK72dEEkK010=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
k46aoQLMYLWCOfGjBjOVD5UdSZ02oI2OaA3/EPE8x6MA1C7nuzW1/22huJ/C/OLw
5dlgJ0evX5ZsWwSBcUJQVTa2L9gdZyT4B19RZphJk0CXHxqmbzlaxjq3G8SIBTsP
WprifvE+pV4LOOwKfZOSQcoCQJoEsBEz6451s/WKze1y7EzPsZzAsA==
//pragma protect end_key_block
//pragma protect digest_block
YXk2y1G6udmfahPyppFcvFl/ZZw=
//pragma protect end_digest_block
//pragma protect data_block
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
cbpT8c2RPSb4kXqnv0aq1gurYDZ5RxTKxwVuutLEJOj0ymFqubKlN6Ys/hy2dQb0
rnNok+UmvdUcRbygDBPTI6O6HKeOyraQax0o3BTn8gERJjFIHluUjk2/V7y9Sjrb
2gyvcCPf0ATge8B+B3a7S29NXxC1FkTo2zWxVKCfXEcbukRwF88boXThb4zJM95J
T4ZmY/pcabLZHNHIV555Pv3Ua1SwNEWgY7qOj2OseY1sfkSapBZqE6jZa995z2Tn
Ma8nLlv3uoNS1wbZOqKWFqzoGCoFNfiDmgTnC5vu3HxmBa4mtccU0yIonjjeDAy9
wxLMfeepC6XmuPNhDLK3BkmGIRpfiTah6exAZdA7NbHB3ZdZcj/hTFTCgEZtM1I8
urS2lyQJY2DOEpXdCAWnyFH9rP2pSI4L4POCtj/fMOJp2DoKGKDloXCDkeyS5TnV
Ukqwno6wC/EDeBoL4cqCR1LXvTDTjN4EqpJ95RzdhPHzwxN83z4E3K9qxbLpXKJQ
LpWlEfmnkXGjxlvQWbpcl1CoSgrQLu2TBkrK8+xsM1H9uMmWNEqN9pkgcS/VFlG+
4HKWq2Iudo86eq3bbxEpCPPqs3GX6tJvmbaPNHa2vjedhyKbo+YAdGFIgSFfmR96
7I+O1DDG7PO4RHMC4OpmhmPCF4kYvl2IfLK9mkibb3Qc2wSiduSOQkktfpdLq14F
8wdUnl25aVm1MipOpFeJeI3AwzkVbCVt4RcGyNK6LEoGuqaBUIGe6OH5bsDzawHB
oRxjJYVWKdQYC8Jbq1tHOOjE7QHij+DLg2t9mlYdzqnGgd6zctm7vyFd8fWskZZ5
4yDxF6maGLESAqp7UXk4COHMy4qbBC5ogxBshP7C3GLhzDlBnQAZVLlWfu20g5iM
YQOy5Dcd6GdmolPVd3XxtjKLA+CTa+79IuZsOZah5kQJHVb3b1qXbMV/viDkqciS
E24LnnJmFqUfUMV1vsEyUYonhmtxwZuE8GESMwByKGw64EfAxxE3DHw+H1rxB5M5
Bh7rVVuM9AgkuJDXvlMen90j6GQXwTg46jE5FjnIY3B1pfcQbTxdqmTluRzJJwc5
N9TgnsAz4JZN37cFljG6ZNERXQtvsm+p2y3mEpJAdnPRgMQUGRikjoGG5rG7OGgf
LnZFAp+JQK/8bhd7vl6TXk3HC1N7jteFXDZbiKUW92o7KLNpKFgYqsed8m52pqNS
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

//pragma protect end_data_block
//pragma protect digest_block
J9jFoFRQx1KLRF3UaSyMwTGC8VI=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_MX25L_PARALLEL_AC_CONFIGURATION_SV
