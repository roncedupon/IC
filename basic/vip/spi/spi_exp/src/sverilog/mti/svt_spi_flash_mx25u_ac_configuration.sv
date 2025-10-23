
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
A8bUPP5PnfLvHKubtUdO/5N5tzq1lmNxo6WANH6O/aFEKtkDaOyLMATHf0gBDBWx
nmH/PTtDoHKH72Paqpsk877FG5NWI+zgwLp3qYaTiFFoDsjaqpeLyTQGrulz/wib
B7Ip1jWwBk2Y+FOjLufVdbQ+/6AcyWpRzUNkkS4pO3M=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 753       )
xQucDux/Vtae+MwtnsIj2rTNcd51zTpDcKuiQEoh9v+YLJT0ljBogvGaT05vcUD8
pBOlGwyU8GD55xwdsMzg59BA09dys95v48ResroBo58D+YSpcnlaQsE+4bUhKPe4
famnqy3wFeZFD5sKnDxsInROdP/Ol4n6nmHzrrySrxu7GVCCKHfXoTG3LYSiu58c
+WldKQ3DuMBxPYkD/6HHZlnNCDSBJzUo3t9BwuQYdmhE6CiR2+svRYhEGkILw002
PQf26RG5v+MsrvhEGlHTE1wFb3DuBVRauwWuDl2aruCoKdnFEeqcMyunsQZMpuk3
7ZALgEP3aAyctsxmXKh7U7Z25gQv/eirb5liIQrhdW5ZkS5pw2D9vHbH9wFA1bje
RsTmwESWoePmBW259eHkm/U4VZS3r+x3MoAl7LjuouDIfdgXZvhwZQr0QJq4GUr+
TWnlZWOVLNL0V9uf2fwFjCn1m+fGw1AUmz1NypalSObarbf0hzUhqC83rRjGK8Pc
I4iaTV9O0//KQeqTEpJdm1LyuV2aGX/b7bkX+ZSmFjtOo7nQ2OspYcN25qCylHKA
sgONvfF9BBREUfjs50sBMLRxiVcK19zSZC8d0elVGrVZ+NyCaGSWLs7IYwbaJLL+
IQz0M8Pk/BcQFEBr8HTZO3HAXliyKjuvTHNfBK3P7scDN5ZnZJHxpq7ho1qTSp3e
CPZ1+lWc00B9kJ2sRO5S4Aw2TlT5mOzhLbkNdHS0twFHToyULHWwTWYjbKkjqqKF
06s6uFqmLOASyDHskrItu2ghtXJNo08Cck1dK4R5URhqgEa9VDbe3eo4r/t+REMq
lQa7dBRBM2jD6mOp/1xBNj1QGPlB+MxzMgp7qBJvU/HJ7btecbSa1KmIvmOg3gJP
bPdADJiF3XUHWQMcHqr/I4rc7Hh+e2ZezrcS9zb+1QyB5NpMxjSfz7JR7amy/Esk
TTniYaFNz9YvCMOkLGpl+gsG3MNslNwqiMn+Og82no64cKx+oiFWpAc9IYAdsA86
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ldsHUmLVuwbh0nv7eK99pyWfnuqCt5g+MlrV8X1V51/o1Lt+tZvhyU9xiAXI0iEr
O5Qi1Y1vosOX3bB8Kh5YCRWBaA6uocWgjyovvG4J9iXF2yq2kYTTdFSx2FmJJGD4
XlehXIYO1i5y224xVSSQ3UShv0lXsN3alxmiFRFeMyo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 26206     )
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
ZwIr1AAOsIAaPFsXEeU6JJohttwQny7SdoNwHkoQ2GGoVxzUX00JNCh0ERxOvP8N
KuCC+F/bDSL3EknGyiaUZ4+hYwGnBcqoTRb2OR4Xa8FpNmguW4XuI3u5/sDU9JQp
Tw1zeLNZK1/9JqxlEyqHYnommpASoFGcaL2NBvWQV46E1K+f7UNlYR0pKgUHtG+0
iyTtZ61eb0LUPUdPdyBKlu/19o3f35XDPOJptIUbg+DsnMZuIDBegVLQA1ceL4sY
Z9e+GMcoTyfig/OvWQAobKSfMaNEfce6UaTgx+2LeLe2wZUuB9BRDWhq7WO4KQab
RzKjNRCUoDgGlDc6Ryx8wp28cS0zjEHQY1BfVE6mgKHyxg8iGal2nS2Du3ZkLbH4
+wjxqzdc/bWdM+24HSSWsk4DVA0ncBS3kSFlTVzoV3YWk5s7r9np80l+MnmrHG/B
xFwNrUGAbbLb2ML8KjvnGwYdqdEe9WUMJ4MGHtgO+O3/QA/joZZ7sbU3kj4Fs9Tx
2ev9PF/Ue3KvaQywXWcXztTevpWsM7WwlTCGTdtoJWkfQ/QqusV5ZZoB9Ugbpe7D
8y+AJVxmD8XTvskQvj86r6fw+D4EfdOFsyXH+gjqmyF0i6NNMAcLahrSJ8LkzPMa
sbNWDKrJ7tWl5Ke2jzHlnT+3AO7Oeu1vuvZBnXpyXcWJc0SHS29ZKrKXnXdA/jh1
3PzIAFgx66vtGlM5nhJJwm2ziWOYAf+HEY0q2SBJros9AkYFXg3Kp4vNINI7xdsD
1uvqiYQFOxB4bca3EXw5Vk4B9c/3J+Qht+zR1Jo4q6426pXByG5DF3P0XugvCxB8
QpnuA6T6H8mT4TqT6Hb72n4LCJjVhtOYjdzLRpslc36PZEasPC/5l0KBn0oWjrqR
QkGBgrjM4xasstZafW7WGmEgyWzRiTNxdkDCaKHdgRJH03WqTldb3yHgzo3TJ7kS
kM8nyQGMIcgbD9QobHW0b0nDVnSwIEdYCgAIlwcxI41FdgkMoQuzUusYuiDMrcY0
L0ixcSvO+xgQp0eQnp38XLSn86bPrtLSlBvG5VhYbrnoCbawV2vMD0apnP947i5D
3amO94dIfpwZ4IOMq1vpXFa86kw3Rh7Xclju+6Wlrud1NbxHTt6NsyNXcG2U9OWc
7IqkzSRt2zAJ/+ob5V+nS7dH5s97zJONY67C0HNx0FNRf/tOjZzMGCw0cH3eIBGr
EciS8l3MpQz/Qno7HmGcxa1/D4A+i+RhuQP7eKfs0R8a8Pt1qiFiBRpzwB9IVLJX
Rz1JYjmZU+uD6lCgPJFm6p0x1qqoqaUxPlpkN6zcDA/TRkosxfmp4sy78ZfddsPU
Eow+gXFIEaSCKNP9noddzeAQKEQQ9BMX8vZ1jvibwNF79La7YuJc3fFyrLXwAqk7
1Hh8BQC+hXeSRs+l+Tbn4Kj0Lpe0fd5IXEKIcRwdphAynOwQhAf99+MRCkKlkNAh
lwSh/Pt9xhR36AJD33SdFcqPI2AnWxo5JMlVWCQuEr1NpGXf83bG0+XnC5lCAbsW
/KB6ZASq8t3Oaf2AsUacqB7KoyndfGnbM8+GpMpi7oJJTFX49SsQgeHrD8Zbi3TE
YKWoabMtPAFTYQfsw5jXd8KlDFA+Jp+g4z5eg5jz9P1KEZCoBCCpEiBntRBG05iw
AL4Mhtno4qEKOU80KP9MVf/aUSqOE7uFbnKPek4w3CCPyA7oDUaWqjJ1GL9PNV+M
qFtxDNmb6EBDG75m6AAgapcIdxOQjcY4Kb6VS0DwRCL4AtaiG6Ib5Tm8niqq38tn
+lfbK/tc4Ie0X/u98mFUg53k8VhYiralQC66pZnffdGrn6wgHAaofYUZinn2yv2x
Nm1xy00DafMfV1u1SscvtbxTskIrwOzEIiyjCL+ewtLILPCcN9cLecNl4i3SYkeF
iS0nXhl3y4WmcQfwTH1PVGIHVv72W69E9S2B/00PrBTM4yXdir0QeQjRy6QjQTHE
fD4nK1a8F3LALKzj8UEBcPqaUKkIZxL9JgpoJEuP/jEDEouIxCJvIn9YpGTKUEAj
ds9pv6BvtyhfxGIrytPWeFa+J/5c8SwqO9hRGBaf405RD1bJPOz3zGPDCotcduji
ky09KQjAxQYmDoCamvl7j6gDppRpZ/Tp4Zo2l60wULYA2m1IbuRIsFMt+n36xQrB
CdDGS2o1Llyq/q9LAoLWiXvp1liR1AVa0Ayv8Evi6ZkeI70+q95+OHfu/lQqHPzp
/OETsS/Qm0+DPi3ZIk+GUMSWVY44FHKVBkPdPl4O/2tgxMfGglnhRod0+5T3vIFL
2NcDn2nm6cxTQAcvjQ4/WA==
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_MX25U_AC_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
G0aTtyfzLyi6Wj4Q6pOwBkba0vgpnL+N4likCu5qmgRpwQklfq2JaeB350C5wtJV
LaQGQnlH61C/ha+4zJdlk+4ELexVGjJLEe/ANSwnOjgNGw3yrulOwzAquER8Jbxx
GTswDYpqixVBMGyEXk+im2n6xIl5HxTE7weqJ9cuiwI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 26289     )
kO+QeObXeMl2Pj3Xea3ijs31sdKFhvdVL0EYMD47/OkhgxgCHxC9hxY21BOkZkh7
pg58J6U2Az6xVkeYEgaD68VONeIy5sMBS3BtQeb4GaeZn6qGf0L2Rxb06nudYd3o
`pragma protect end_protected
