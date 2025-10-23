
`ifndef GUARD_SVT_SPI_FLASH_ATXP_XSPI_SDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_ATXP_XSPI_SDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This is the AC Characteristics Timing Check Class for xSPI Flash based 
 * Adesto ATXP device family in SDR mode.
 */
class svt_spi_flash_atxp_xSPI_sdr_ac_configuration extends svt_configuration;

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
   * Minimum Clock High/Low pulse time for Fast READ Command in Extended SPI Mode
   */ 
  real tPeriod_Fast_Read_SPI_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command in Quad Protocol
   */ 
  real tPeriod_Fast_Read_QUAD_ns[];

  /**
   * Minimum Clock High/Low pulse time for Fast READ Command in Octal Protocol
   */ 
  real tPeriod_Fast_Read_OCTAL_ns[];

  /**
   * Minimum Clock High/Low pulse time for Burst Read with Wrap command in Quad Protocol
   */ 
  real tPeriod_Burst_Read_QUAD_ns[];

  /**
   * Minimum Clock High/Low pulse time for Burst Read with Wrap command in Octal Protocol
   */ 
  real tPeriod_Burst_Read_OCTAL_ns[];

  /**
   * Minimum Clock Low pulse width duration.
   */ 
  real tPeriod_ns[];

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
   * CS# High Not Active Setup time
   */ 
  real tCSh_ns[];

  /**
   * Data in Setup time
   */
  real tDS_ns = initial_time;

  /**
   * Data in Hold time
   */
  real tDH_ns = initial_time;

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
   * DQS Pulse Width 
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
  `svt_vmm_data_new(svt_spi_flash_atxp_xSPI_sdr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_atxp_xSPI_sdr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_atxp_xSPI_sdr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_atxp_xSPI_sdr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_atxp_xSPI_sdr_ac_configuration.
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
  `vmm_typename(svt_spi_flash_atxp_xSPI_sdr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_atxp_xSPI_sdr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
hjNKx0yDXMZQuuKo5FWl0pcugAs0WDt7kb/lV+5gFTFhr2JUugSMBRrdv4fq63ty
U0Nco1i5nXfCo0vuJVuTFBq8OZUC2b/2SYOrT02e3G6vGpA/dCsqsEApCcYVBb82
pn9clU3bGqkPcWJ8km3iOqPtOwL0rbXDuIJDHCF5W7LzPyV/Ne58Tg==
//pragma protect end_key_block
//pragma protect digest_block
U+6TAKlS6b3TzOZUYqhhjzSScY0=
//pragma protect end_digest_block
//pragma protect data_block
bWnhHQRT59P4gDXLWRFxjkEHQLi12sqqWlR4cqr85hPPWQFAH0FI/DGExe4E4tXz
7biAxIJqXThz/EiXNcSgkquMHPH7LZhjjoUFVFAPngJC/+8DGs08WTfgncHcLG2w
ewTVyS/uj/QquqE/1uJqDWBrjwIvsY+NO2RyqmRGgv2ElN8wcZhpe+WFdVB02xRv
flh56Z2ZaNdoMFUHe4WV/hDa+TfXfad7J3cZF5k+QIPjS6IxcI8V6Qo3+d9YVIiC
2Bbo+JOlVllTA2n+ZOurAgLJ5vJkHWd40Ru3+r499JxOgm5knjx8hVTdHufXdVDZ
vzzP1PaBOuhchodiOLmZVzPMr1r9DGJd5jRByseb/oGiLtd8O82n5HtxXnK10hmt
H7mahFUyrwmupxf2IGUSL1mz4UUaq3znNyjeqKKEwbFo/PnOywaBMks6+30qsUgx
h5IEraSnVebUmWQQg3fbm6Ezox2F0Ap2CtMtme1c7dl6I4393rwrTi3+npy/RUkP
sujltzTdBa0NoUYP0CSK290+n1EJyYVfpUoqFRmypxmf+1uM/wglBsPFAZXIy8Ay
S8HE7m5NC/HSomj9oD4z05J0/Qhh/RIOa3ljkWX3P8pP9Ib9bNRM4wK+O0A/PGRh
3BpQU9JNpMXFAu4YKhGluIMq5TqCbRzQHvTXHK7Oda0vKcZpmLpeyiqFBp59c6Br
g7YlJispS23AxuPsDIK7EsEhs+Zfal9iAn3uzoRfjRZLsC2mi7mmBYp0pgpTWaFl
H/vSlhKlhlW5SmhycCQdfLRg0pSjHWceyc0NPxqxpyS8SHuUqBphQf9cZI0ZJcgm
2ISH10y8ZWU1iFwuYfNECXXxxGxdqIRGpCjvQNQogmLTQc9kLiOht3OHfN7c0Cr3
TISNeqS+YwbdGFEFn37/2kwitJ5eJDSNN8o3VL5bip3WO0WgdDYfVZrPBzFGxiUt
M2kuZvVeT5oJBTqyS+hN8xhuu8Np27ANOTaCThoitL09ZgJULvP7OWLqkyardeo+
7nLyoFN6ouo7ClxI8nsLDKMva4sl9MWe2OovHZrcaJjLuH80yVBPwNmF79Ly983O
9lOX3HUOJg+YXWYq5IKPrMqBSn1vl8+jAqJEaZmQpm8yaFbNlbm7UVfigUqM8Gd3
U86Et53OIGPgXgQ9l6uasOIsJIO/VuAQZgpBYiGR4t8y9WkAhJQpn/gnsiM6JyaN
zCXfFpwuQ61gQ10llebXgQPpBo+76K+pi8mhP/H4oi9B4BbzCkURJXxcIdTum5VD

//pragma protect end_data_block
//pragma protect digest_block
wpMaxvXsXzbr+rljy/SXHnlh1YQ=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
FWQ6WBhnU2i9C2dRXs+F0yNkVdaqPkjIhfkayvSF9NYPm5ZGSJuRJfWjYl7M99fN
S9/lPWQvlmqY1H1kiAVbtqvoQZVvw9VPy9lMTbhrPEwhIiAHrVR44zgUEV+NsSgF
XxhMwheeyhRdOWXdmeVvtTtAyS1YDu3IZ+smsB3aQQQNAWsscmagUg==
//pragma protect end_key_block
//pragma protect digest_block
I68/VP3XhQIwahg6CJEv8lE6wew=
//pragma protect end_digest_block
//pragma protect data_block
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
DJtCdtzYRh1t5D0rjSfDhslM328lCfeZC2RLtPrmZul+L3NiLx1PGOJvlVKw0tBK
mjk97CSEmzdN2vKcv83nDY/K3t/aChzm23tM1tFNv3NqArFpMm5cdakghSZThBIy
cugypJTKjtQyEUa7/uyT7SZyHttD8evW2ApL7w6wnB18ofTe9hgQCEVYz/XaD8/m
3wGaQvIyUcIAoxhyTEeaOJj4bEM+IegSGo3jOpK+s6XCrawUHi4pY+bkz7zMsofC
bNRG9US2F72s8+DosVu1kcNBNe89QL3yBemlo70oZzxwF7sL3KFUQze0wZMZJzFf
00bTnNWElRrePg9Yfa2uQ0bg4NAJwdQZGVf5BShjb9hz3souZ+BBiSW+OagcArET
aIjTGyPCT+88VAfdveQbtmwNvn91Tt0ObjKJYNaBWRDW1dJe9G8RLPZt8LdNhOiC
aaf8E1b5LdMX7Iw363dB9hpZLmI5vQJBQLEAVXHZoRLmUCJyHBdpH8glhx5shDsa
z7iZjXLqvJAuuCFlrWMXxRl5CMV2jJdzJcrkvMH77w8dEk6slU5p7kIxCOpvdv4R
RTMqAdCdhU86NIb/PrdxrdmOx3o1we13+1JyprS1jcv7leI7F0CCuobTcmA2GW7P
Tg1fE7Scsj++LSTtgNU3eodnrvWL8/TYphGLQZ7jL84i8OS568W98VXRdiKFLNc6
h3JZ6u0H+51DqCuDwwUshsJKgVstgb0Xnd/xgJR4ZRMOYuuox5qilMIx51kS+IbA
bAODFTUSsJFn0tCuQ6OLj/BtPV1Xl8aZ61RZGzQD+rxzftcXlIJaKlUxuJgXgw/J
J6Uvf7serWG31KOswNPpY6U1I81JRRyYyWi003M9w4qNFupCIXGR0ZJDcNu51rGy
PczzVNL4UnQQLJXgSHdbWJgrbZw71s9xvo2VID6O/W0Lto+Mpy3+IO3NZy3hOXy6
GOrnw2QBf7noEd5lVE0uhhp/Hr32y9bGRbB5tCEt1g9Grx350/r99UfenPV/9/FM
B2r43Q88jjzo+xbCB3yebApD+DCd1oTC6TZNOga8a8zaRq8qfE5Ut5sX0hdS2o7J
874995B9ta4Byi6enwCNIKFYLUWyDYcQ+iiNHYpxQl2kTPP+gQ8IeJFuXv9lKomf
gZfjXalttpXVr7Rq57Wd2mtNjAX60/TBtBl2r+q59VsDcW3uUQuFDoymb65+E33m
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
/x0M8jKigEgXPuy0CrMHSA==
//pragma protect end_data_block
//pragma protect digest_block
RpZc+pjkFPWMdyseZ48/F4vREF8=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_ATXP_XSPI_SDR_AC_CONFIGURATION_SV
