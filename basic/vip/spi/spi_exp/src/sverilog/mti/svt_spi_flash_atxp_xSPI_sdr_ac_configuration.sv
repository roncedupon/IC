
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
bBYq9jOZN/hWA/vBsMxLZxs/t0mRlgysDFyEIAMziu6p0rY3htC0kZJDWRrRX8uU
5GaEr6zxwWmQa9oZ3pArZtwnNxfkKLpnW4M1CJP/TfldgoG1dgCjyrqF4Sk8+CvJ
TmNyBFwXvFBfAl6RcvdU9TyJF9xaO31/Gz2CAOtpoNY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 785       )
Bt+qel7AZrZIXRH4W5ZdKfbxU0BcrPjkQ9YwnfsdnVTMSl0HMLuN9kMezPcQ5q7x
O3kxLNiPN20h0vz7ARL5jbrB48nA8xrrK8rqW4FtzUr57hLTMOkmCK3ar2PMQAss
LTm/sPVTufhWAT/ux5obvCojxFAgLT8zR+EiO8jfEW091Nza81bQOpQ1KVukADik
FlWYduh+cHdGhw7g2UwBFnJB1zUUkrZAEwW8YnyxmxknELgA81i/F0IJLAtGpr8u
2Jz8PGNw8WnuyhzpYuxKZaAeQQ69244xJQBjbIdnkzAFIrsbMPKCg52r9STZ7fdK
/EcUnIWnzKlqsbLCQDPcDoUOFRhUMadM75svXxcf6SgltmeXjYm5bI/lUnkKkgEV
e85VjDe3O1BrYTmzHgofZ+4fcPw4AQQ3mWKUt32ZP0gnHZqkAKhY+FGtyilyJdeq
eJMwZDGWNy77Ri7+gcRwi/z/sZDDZgvDCyIC3Z9lf/TAWGV+SaHDmLl8j2X8OkhV
5jj1PmmXcpH4wcWR217552+uptgCNSbLCcaPtE0ycrdxXBHIEdZmfx0FIQLvl6WL
CwC6Ea9rZizvKYRFz89RiAdiXyiCWV2UEr8zg5W8Yyick/J0RCWzp/Z/XaS5sSSw
Es3slA2i5N/hVhYs80WRADXdtiLktCsSVNibyvMzDrGzbjWQK5TQGekdKr6fm3c4
Rc5bi7pDs416JgNBSYX9zEkx4XreWbBNiVIPY0b34ZFfEpI732pDGW+MGphHvUaf
xb5iwlTYX5SpeX1clcf7MrpBoDz0DcxL3CnmN7fGpK1aK5lYxCJ3qAugBDWmr8gV
n5BDhdatBcWSGRjMbVpJku8aWWHmpkfi0IzpWpctZsn3uRDusPCII+tNzBHDjFhR
c6LOe0hhUUnCj6wphpatVrktFCCHcNku4X6rkRKkarKWy2yRvv37yPAbFm92I5yz
Sudbw06lrx5G3Q/7KfEP7ORAfzBLHNLFnc9xKaKIQDQwcpbKh0OIvzsET6S6cqGu
UZFRILBPdzMl6SDQxlL10EaW+Lg/EBwDIr4pGdkg9gQ=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
C+ovU6CNS49UsCSwnLcPNuca1KyCmDrRURsjk3G3L/ZMRvyT42ANe+1IW8PB8eVU
Or2wsJYPwMSDDfoHddhRn//79tScDwPIXrHGwY+FZfn9a8hYf5roVLik8EW70tm7
HpkiUEC2Fa+i2BNhzTpzWTzvBR7uhTLANbSgqAbfAeU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 29085     )
WBSZimRc19jCiLHe9/ZVuLJ4K+sbiLAajsUSyKDZxEpxA64l8vea0p4ouvsEP6yf
qgFL+y7Dp2j7JgUWdFqqSW9YjPxHZAhGNMpC65XBG1bO5JtR11ZLFArrNUvnIkl5
+K0Nmh5rTB3T3VMmB9mrZM0PLHEtZ3OLnXRvoN+ia9nhudpoTWjwgweG7ySqlVzS
VR1f7+EYZwWUeWejD4z/bPe+94LjK0xOww+iD71WvwV01Hxc8JwvZCqWfz8OtRLH
la1gzw7dBospLNYgn4UWD/9FQ4sg3V8TFbh75VfFrtvfWPlxPnokVtPwT1NLqHr9
/wyyafKXRj18bZ2TJ8KyfAEPxhDlGfpLCobHUSYjpPtuom8KBPr/NU/2xYVTkkSx
v80esBvH55Ep2ejyy5PGTTr2lkl5++UDteRWlUpNkk1B0jH28n5FsCAzluxcc1HC
YMzr9DhljyWQyjRboq0X2+7j2BeOT5xYiiFZqsnqnUqBO3p1AQDKJ1iD1eF78Etp
XgC8XNMIcmd5kh/PGmH1v/T3WwrRC6EilAOFJJxtvHUb3ac/Ae1B4klUJRf6aHPX
rhwyILACu7JW8ZmAcdC93G7PidCNG6gI2bTUA/pXZ/S23lP01v1RJVQaMfIvAbAP
KiUhB5oO2wcT7Ja0MRrOwTf/XjofUS16LrgaGgvyLDQChfC8znKPlIwEoy6y6DXK
ErjCmNeHM7dqZGq53M7h8TzaaQIDxvFftF/oOYNVyXNnQOt0PGiSclJCYqLLk4r3
d+g7Gai2EbJl+QXIlvFzSlI813Kc++UapDWG5Xs0+TVkTca+QvEB9f97n2zU4HWW
Gyp37R923LKkmJGbqZ9aiNWp7PhJxV+4FMZS3bjRU/wrrYsTznct/tAPGKYeU1Dq
9gK2pkXi2gMmHZCx1c2L7CJsWEg0lefoa7+CMuFN3QxKl/S5sLB4Uhm3zsd5kn9t
Qju3rJ05xqk6Layq2Y9RkNkVmahs4P1hkoFpWvL0NdYbeKg3LsTOFDhkQgP8Q+jE
oz3mhWHVj55yIgdj4y6FfT3ssA5pxwXYESXCpwAjbLlEtCR5bhNrnofgTPPBVxwM
SKV45COtCKOl+/zN0Au3mj5CLq6CbY7pzpSAP0G8GzV6df10+E/W7es0QUyZOO20
P+AyXmW1S1QpJbtfo3o7EurXOGXARELQ5roTbCnbjbgE8177s4Q2MIBVEVZh8Mwq
SQ3k9Gr+j4Rr7p9uJfkdUs9F3waM4HV/PndWCkXhOtnDtwtOrvj/pnYbguJPzBFE
ULIrC48dnv8AabFG8ZcOc26M6pQnB6zYl6ZfYfSXi+XpzmDqUizGTyeqb3Ik/6vN
6yAa7b1z0PQZsaXEypGYbkdD2KolmZCXFsIq/xr5tCVCteXvguG8dKOUJ31ii5Mb
NFIS3b7TSoj+8ePYSjS8oNYSrLCVs3RrVM+/btgRdFUqWn47uWrE1SABkS3jVFL5
urk7R5qP10XRcQEAdB2TZl+Nbelh8FnyajF3MMQPUmsa5TmjdkqbKHaF898Rsy0c
JencfQg3y1cASLZZWFKHtKcQEGYRnpQYaFwZ5jvhQSjB/vLkSREirROqWFAQM+FD
nMcL/OjXrxNaUCWEY3Tah9hk2bqKPqdXkcJMQuKuEU+mBpslHQPd4+qYkfMhwc4V
W9oRnbyRhODpQ4ZyJq4SoGLB8oW2fc2+P/8VSlQo0POCfitwdGwqTaYHGnlGw0hZ
DWIn52KGP0EdsTjch2UWpJWkhDBob+2mJxc61IiF1gB9YFPYyrCB1wKLjloiDJ99
KnZW3MjvoyIjVLBVOTUT2JdlBuaCRs3p+E+6fMmbjNvacrRxk7XFFOJKlZzGZB6n
hV99GQ78qKtoD/I3SylzPY5QhmuOT87EdTjfW+qSelA4iacGiMDI6bQ6h/41UeJ7
PI0dCHo/JNkVtkBzak5Rcd2DbtkzmQMUyK27IMI58Um4hdJzQXiRjD7yBzwnW3Xj
kLGy5n/UgapXtmO7CzhOlLlJ3GHwHiuanflr8jVEmlE423/MbnIL7G6pADbhljMp
TowMZrbbTKz5UAHb53QO1FYjhvgxF/0AZ2ySjaJxaViVbk1NbyQdVBAuhqYiYsN/
xmKq9YAms/4wXVoi8xKgEPgWTzLa8RfnFj4XvW3Mq821+kW3dRrzGFszbQH6V6+1
kQ5M3bLItEAg2xugaww9k0yQTAZo31w5XUuJDCXgDWEtwUTyKsnFUTkDJojBlnij
Zdi0eLUeofiiQIQD82MHeYp1vurYIIVcpTdOlpJdk7hn0iDHff2p71PfLg0oDXhR
Z3XTmC49G1E+/oy1aVvlxqDymuNUQ8VTpjg6sBmWkH8dMir3ORnewFfmBVv2sLiZ
MIw4GdJwALr9V58/436QeqvhGTv8P6WbplS9ZikS4S+lqIX5ug+qYsp++wup09ad
UOHqigmjuZLnm/Lnyi0+f7aqj6kig7pzWX6/H55bK4BBXqbUm93RStzDeLA5gXbS
1U/IVOkNvpxwsKRXMWkIBcKnXljYuZyH3jUC1+ofD2Oyx3YNN3QZauPCBPvQznkE
Blnr8Ay7RQfZ9ipJKUxJSk4CnO8riJFFrrzSoIwDO8k7Gp65jUW8S2RtTyipoj4N
fwYpmluNMF0r7Ck+viuBoRU8fBN7oMfhHeDtvSuXmmfC5QTCjx82Riu6k3OjZvtG
955M6dQS6skW9PNybxgbCOTYbLntwirFLSZFZTLuTkMYBf8/2CfxuLegxwiRGee0
RNN4rzJRi13RU7vC40qj2/hU06qsOigULjhhuTl2HF+U38iis4IXTAVs4e1Vso2S
ujObLLpSEFFzpxSXbtKJInEz2K4FFFpCMQrWqh7aEvNk3rf7j8RhtfpXXri093wK
3URuJDglu+moYyvL/snCE89psqN90FzJy7zPTxd97MGuE9N4KJf+dZnNods33Uxn
GsHyHobx2jkCN/gw007xRvyu7PErREl2aK50MNJLteJ2+/Hsi0cEF3m5uQHgazwx
U0AqN+1YIOSA8Wa5HXKZB0aMXAH3ktJGHFyfsypYeDcqvi+uX+XbnO9FL7YmEdJR
AjZnTqon23jov9uh5ONdgldwqF/nQJ41UmjdBf3AGrzWmEhYZ7clTe/e3uKu5Rzs
E+XYfCt98Zl2msMAFAByJCqV42/cXTTsmsOUPMZ4U+McT6uv76E5Fbp99QlYtyEh
7ms516EGDIk1MapXoJIWTwROdnYEgYLR0enBj+6JZu20xcobHnT6FIA7iFEqwHn9
kqTa0ymnSOe8NZuJfiHARmb84tu+93f0Hz43oYTvJOGcGG6KaOncLO74RFPtLr4f
C+l/fPfiQSKGxZSs73StT2zAWL2zbxqIP6SAFXgPXucGCTp4LPkA9uHeWxtY7o5a
zn9R6DNs8+ECjDcPjrHcmZJyl6ci++6y0EYhmlsRKKsbtuIUmEtY245pny8eaHKR
es3/HL8oGUflT8TNY5yASs234YnWZ1LV3byNTbuIYkFDG1xg0jMBdQGGoTSLfQg0
MoHvSuK0Jo6vRf4dJMYdBcOLbkqOwTIeYJS2k/5F9bOqnDuhGEW/Z4LCejbLsAoq
Kch+2vNyMLFu5/6EPyIqw14Kug1wQcYkMgaRJ5nsaAQZVxvLdcMecmAVTvoRK9Pk
tQHdnm29Ln3kwSpNWhz5blHJ9x4cchBgXO3nMGdtgKQfv8HnyWIty6kWNVDM1lqd
lmdsEn1cq9sF4QZTH4WoEccN3aNyrwIki81A4PoOPQz+o18VW1tVsjoO3vxXdEcR
g44slQRfTdj7XfgSG1kcIEO24/wK8cna2jxsEgY6VvEDIOOyceVUBIhkYJUHmrq0
V6ZqY0UJv3bG5Fp78YX2CEtV74fxoZI3UNwy6PMJpoYAv9HFq2tn7W/zxF+s7Fxu
1TTuuDlxQcGsyDzqfNKrm4tycHMhlcCZLTjhMz4UnzGRm2jfeP6Jsw9YHM7oyqnK
IJ5HwEXpR2bFfui8+udpbPkM2lLkZC5gvyf/RR3zMLFvdjUHH2/90G+RIoV8WC7v
HV1n6o8tuxQfVTu3zChEmQtqc59XqHNah5NF0ncjwk/FoUjiuBigI2oKIlVYKOVi
8y0peYrzQWTCVZLX8Vi+j/KSN+1pSVZ9sAYOXnobDh49//4VEwf1Lo5DyGeBIOAL
QUj1ACEe60y+UMWK14v4T714f9zN7byRMIoJMXZa9e4Ts4aKAFP5UmqiS6BkoHWg
w3R5XpQlEZamcCPBZLz36Qh39ctvXbtV1T32/PImbhZjZJXYgsEtj/j61Jti06wi
zmRwGW5eeTjzrGrTwV9L347AOm5I+L/bVKROFVOnJedZeprTcflof7b91fitQN40
nUdaIiZYaexhnh57J2CpNS7LTSt3HiwZl5M+MpSJBQsovJBq675fzG/rnnXVm1OO
euN1mJDBfqxYzdn8bl4kvl5Q1qqCc7V54VXzbQoM4erdGqrvOfdSyBRH/N+F6SCZ
ehMydvgZnBkVV4SpstFBarsvZXuy0FCnf8siFiXf3iT/WEz7wp1pZuU/NYRec6hD
4AafyFf5n4/N2sgEyLxTQYdDNmOexd4uNwxYvg65ynDmxFQomy0HI/78SxmaO3X2
Fe2/ZQnEeWwJHisEOzPuX1tkNiU7o4fmKXRLIU4Hj6j8EQh8YWMGoz6nkhbIfsg8
yWLGEdRS4Y0Wa7DRQKc/0/jN1m6I0n4bRRs+p6UJk6Rae/Lkadjdh+2fitzYgYJo
oX2Od3OXKY1yy/kOW/ZxXX2f/qdu7Y5Y5Vqjb5z0ZNcvy2TQnO9Tah1Rg/rOY+Gg
S/y2UlsIGdxrdQXNL9lI7Bq9bxGzZjjp+vno2PD+71Z89Hk4se0m3s8iZ2mU2wen
MqmSARQLoRZcqihQE1jG5EApdsYQBJAiHKr0KWMOunYg0r/syWVhED667AdBMbff
IP59IZDqFtLdnxQLHlTwFLPpcTOCr/tSEI0TwnN0slYEdaeBgAa/LOon3ljjigLH
T4fkOLxB1sfty+UpjssGFjWesOFY4G8bh/jQdRETZYDj2ZGzPDmKuOY5tM9Byh4k
lIbqmsjESkvlQgZw7ynZZMSl3AlbHCA3tS16gUE6gs9Id0zEbIc4e8pcpEa1cmX2
HgWCF3ahxLg2qlr5O1O/qrPnGvODYXtdOpsc8FWRed/vqF/AicA+RNmDlrQ0hBdC
Bjifno+kiYW/usKnQ966zXFSSpgVdt3BtVpAIzXiO/mzKDIr/1YRrqlRRGO48FmN
lXmhSmF9Fv5998OlMGWmM7MhExrtiCWdFQbaJkQDgoRFbf72iyR8uDrZGkVivb03
zfLB5c7zQXmS5GtXR/twHHbZ5u3xvZ71hN1bjiLMb/5/q/8mz0AY3JoCDk2lcHaP
MokFAOni7VZ4x5Sz/ndjvMGIi6Jb0yFhSBZNaoLUYbIZXDFqJ9IXxX8l6ZpZZlTC
uUyVoJCsNJHuV/uAnU0tkrg9i6OxxDiRZpgRGPM7k+5MDfq13JujA/vI/brYosUi
4oqJ+fxpZKFNBwxyQmg9SRrdQqOX1+jdjRoTYcpCFbX3KQFGS96NAYA9jVxjDZQE
+0afyJmbZU6Fg6TWSIKfjUhZxQ6DKNvwYuBJZwcVslb9GE1yat3kXG3KoMGy7p7N
Z8x7wHDEJEgwNYXOWH1UH4ke+Yc6+IumijQJ9P4r0DWOwXwPXZ0dGUpbAhRRkFdy
PmoSbPhys+NzCYmkRIKLeYl3SgGFC6n4uj5wSGEkBs4zoTV6vqjFdBo4F5kCz4kh
khq8W97qfEHAO5Z46t7gb+ekTY3Ru+4StgoQjuP7Fk23txq+ltm4W1pkUn3EYuYs
0gHxB21aWMWeTskm6RLi4mdRiN38EQ9BAy/YeBAcuL6crgJaKmU06+OT8uQc+QBg
+PyBlVcxQ7Ifnt+lCsW15NisQUBYf2IUeeteg9s4dsSrDs4Z+9R5K9ssFa/a3r7C
NaWdisROzALm/xdZ5ra7hz5m7bKgCizd5u3WvNn5CnEOt+QOjDHb8l5e9w76AgUd
b1Q3bMI7aAnI1JzgFyvdKO4penb01/LI0FUOkAe9zokfKlMmnCv1K2NNvRA4IaI8
raX4bwcUnapz1yk75/xFk0hUYpZBitmX6YnbjmYY6GRJ56l797Vzylhq224jEd6O
5Ksmz5uod+1jjZCKxQGXphVwP2+0AGxR62Y9g7+Jo59d5Y6XxMuZ8B5H5KNQqDyn
ld8rregPVcjE1EWbMvPsn8et2jFpwE2RKuexfMMKaU8MbQ65fUgL2ttjW5AjsdDk
eAIZj2rDOu+DCO+NkFQcG9KM7u2bIXHPV6Ra1HPauuyxirf1KlSdISsJoYiDccuM
yruV18261y+2pePn4hkhmrP9y5sMQk4M8eNLuyjmZ9LCPu2OA5O9gew47Tp6pHaB
Zb/jx0Kp1UbcnUsc6KpC1b7aoRgQkKBeZoib7ihkCYNeCs6kC0V7QantiIYFWVNK
yH5WIeeNVupKU2/db/pepeRzuV+JFkgT7L1aN5NRNtLti+5Lb4R86LsMbUoiPPta
NHPwPafbGoy0eeBH1ebA9FSd8LvDfSZzng5UPRuIEmg+dnOEXjWnI6pR+m1f/W/F
GnDhh9d+4r2+FSnf8H2exBPfMQ+4r/vN3OcPsqT73+O7bZJekz/H4GaxBX6fpl+v
NUqvx156q84L0Ra6WRmoeAadGBkiIIzV1wAv8ujzkGmTWJM8MbTaDg+2W9rf4Q7P
xwFuiyGgx3km2JYubt276C/o+MjuKKEQ8UbR+/7JjqMC3zyFUeWJuJdK3pW9KCqi
qM6TxU5o2t/dNMwszHCmF6pstaVmDlPevzqQrKB7vk0STSPRDnigVEyeUii8ufzl
Gr5MA3n1JLKXF8Ev4o/r3y5Gw28gU7R8a1bS4U1RlXeVI/LHWaezUrbFn4gYhdE2
g1GiSaujIyzKjNlHH5PSecLvCoJfawifM7zhd7j1HULTyKMzBDNnNVEtz5j7/MQg
4SdUzkVu4SNFS3q+Vx2Us1HhrZWYL/3vli7gluK9j7WAsjuUZI/Umzm4gldzBtem
DyNErqTvXBfQZrlRlz2isFIQ0yKYw0mafc1OpoSXTOj5vOZf8n+dxiayymQ2kQ0Y
zuCVkhdJJVpJYTG0ogPS+FV6lUyq/7At76d2/cgPm62wPX5nBYy1X1UP2VBAZyMf
LPjO1VhtyAiSBQkMPavHLDvK8n9/5JNGQhRTC1GeOwF5amocVkmFlHTIUB2Dr/bz
Q4KC04x73ajgLRqr+Ok/O7GswaUnCk+dpRgAtl6HyOld7nV4QP8Lea7hZ2ayOH37
OKmkAQK5GoBaK0gZvf2KZGeOncyOHZReL5nUgS98a+2lv8fWWPwoSXUsPLrobhhU
6Lf9VzTYZ9p+R3Q2a40Rgt8HMaKGrpiRZ4rztwQIupJ/HSRff6JKUz372jdub233
rx5IysUzdeCdzpQ8/EWBN6AWpjxTJG5b+M2DO6gg7rd0GKzEhrs8XGg3ar9uA8pL
CI+eVqf+1tY4DVOa7XgVl/zTg5Z4MWu3hfAZgggNkCMGhAuKNXdXSdDIW6kxtkBj
mQXSqcRq4Kw0FNcvufXnskUL3eljEdp6lZSKOLY3uIUadP6+a0VwStMfEG3jsHbe
e9XS7VkEZ/GwLr1oMhHsf3DUPF6rilE79PYteciGaTUtzYkm7heVKZPq1/nVIjqr
HZ6UFK09Qfe10MxvUcC0RMsUjKjVy4crRarALPOf/jVtbfF+RxG8uGKFeqKnJqx/
ybFSdvm+W+8RC0tN7y4AnSyifHOzOtGXjdrSNx8wTDKalF6midHK4ZmBIieBT5ib
dCiL2pZy2wNAcRplWTxDAekalzmFjMXAsdsbY5q65aanAdYgBTcAOemopnqliLem
oJMFwMAJpCppWiZJvWjV5X7S7CQJ3oOeQWSfbQ4SX8cCpiUJkV7nsXnOeHGZrcE6
sDXXxqN6j+f5mTm/qr3zKqJEwKQO8eAh8bUGd+jnREL60QO9N0sUeuLq9LR06JhA
qihrgR5RwcTwaOMii6gHDKYtXD1quFKCOCE2M9l7OZayz2KM6jUI4RB1r8WL4mvc
E6dzraVJWZ/0ieafjk43xt57g5iPdjo+lW1VMlHKifdweW7+vrrZLFWoq6es/p77
PhmoQ7QFucE/AJRzypVqXhPumkp6k5Dt0Ef+ZVCGXmdh7YmvNCJoXRUCg0To8KXS
GwUnPwmcWIPU+veetdIxeP73etqqidXfIxRkJjoUU7M+SMooctQ7WMPRlO/iBL0o
hiPEfBWgIBhWGftit796i7mD0IOEgMuQ7vfEMzqMjhhDoSTTTyh4JIlcgZ0PhnR/
2KXhX8IFPOSoEZl4DmjBotJlyzxV2WXoXLF+i69lqzHAxkKv7nak4Wfs88uGhGTl
86TNDWelbCnHfqDnX6G3pr4SOuKLBc4deH4mUd+j5BoLLGoy5aAL/1Zu/lKrK4oY
9NRyAKv6hecsAHn7HNIZvxDUnISURC7J+HkKidUdI8QdK9khF9ZMTb//rbcp7Ssh
4fYhVTGfzwYq8P9xjnkXQj4WVMIJPXhNkyyAih8w15e31uMfc59TLb70yLKbvpgd
dw42daAl1mw4Z7DjQ6vcXBna/QEUerHXf3XIaI/VEen1lRSMpodrVRuygnpfbyRz
dQBTNE7HN9iiiIv1ZATBuVeuVpTpmkezEffrrBpOhpaJHvFxOJhjIxAhVAuYGfIC
9P0w3FSvzp/ZZw6Tre9AdWcJDKYJdTDjj+mdGcNB0qrSZYqhDWRe8TAN9nYiQ4c8
DkNy0lLz+ZMNBJajwMRVCmVlJuxt9ud4RWDRmAejnlgVtsK8wwEydiZJKsJoP/OL
aFl3+IStqULKCzfyGYhTxTyZtPMgLqxK8P6HrWrsym9oaGxXi8pzhdedw/gHiq5Q
H6d7t/07qpM1ERtWfIJJZX4qpPXuHxdTWzOyAqp3FX88fQeGX8aOmiB8B86lFaDp
Wp250beEoarGgCIvlUxuevGpf76ZX4niVmnbDjWob6biSxMLe3W/f0XjT3rj9wan
7hQFdx73vpSbgzEyQS8sX4HbSkLAJievCUFfhOS1k/mpHxgkZE+fhPjtKKh/dcNi
SbylDXFUF8g/GxoZNmX6viyBmGRxm1ZqQ7cNd65WjVT4A+7KcEAuWIAO3qhRRl/q
5O1Nltft6xMnmFD5KHi4iibH3TLFdcBWtDVVR+M8+WDgQe2+N1bAyEx4x7ffADSo
TswKZiTk3kRXUEveDVpR36ECvRsD7+61w3vwtY/gxZ0ONOs/X4MwyU6oGTfCDYpl
FPaQXVLQ2nIvFF1YAGuIyWy/iuzL3vyepVgkKdNdClGU3lEHBDHBf55XsPwfkbuz
7ghl+w4fod58bUyeZCiNJIt2Ekn1neV+LggPsWgQlsyJ/M9+y4pOBJVwkY+L4mvU
qvatQbEgqZALYRKsB/H0Ijw6rBPni5yWh2MHytlF4bimP1vW0hYaNyWYy+iA2iLC
sh2EamEOqF6dt6GgyW4XZaVOLcUQssAPWJkeCKin3hcKiZukloiPDCB2OfskDGSG
AmakkUDHHgo3wutAj40rbmp7AtQukt2MLQ/TOYxZYihsZl4SVsMehsRJtXa1LUHg
+vljOaWg3Ithu179YhlwkiIGi9Om+oXw4N1Uc2orNSChAR6UGhNrnlzdy+GI6Inx
bKkRZ8z5MgLY7wrsSwKzmcqSdlddCWO2HFx9BumSPsFykZWQAaRE43rI3rcpzNms
qp0MpbbYc40arGuJ3xY7gv4qyYKmLQCAagsoC4QIc5GcpxJYaQxmUvNQfa/KBCm6
N1OpJbikB3qYiRmaipNG9XnFbi/T0868S7ihZJofaLAWXfAwefHSQtuaQYEB2zrh
KJElUZgVxXrEmVAyTBr39Djr8usINwoBosGxAX79EYqvlZJai7hd/TmA9G923sZ1
+jW62hLiWvjCUH4OyMQtcJX8EX7kxUmS8bpaSLPpGv4D7BsCi1BkM4a5VqJlZiDA
lpapd1nikbB+5T0cTZR1qSHIz/WzfWNC9xe6Xa6UJP1HKPiI8tUaexNBi6lhlkwI
MLhyV/gTcAk1J3HTArfHMCv2hYCUk0gfKeLjZtvglbLGmLWiUc1iQOd6UqpSpG1H
bve/usz3ryUdgel6n5EOL4KjchZDXrPtAPYQWeZg2FX1xL16DYF/ZJLAxpQ1MzNG
WY3T2aBbOQ7KpgQU7thNjbM/S2Xsl3lbDhTJFzN/1hJa7ojDGUYIjtTJaQR2dlZ9
XdM8vUxvTkUYAJIEpBkxrl4H4GVUL62kwveYg/s8Bvw+kJs++oXQyIrRFJXZru/H
LHn747mSw1zXwVeXTu9DTekLZIJFua7LluBFsIkv5vW+u0lmKOWDT2DwKRYVkPfQ
gBw4MlsAkpKjNFWjwtpUVOPVJonI2OT1+fpHpAtPV90CPxTEgx0EcwD/QDb9KAqq
DyL3/TG5kkdsNgstPMXBmWK4ordvjHlhG7F4/ZNCVHk/CFTqe84E8OvvgjlC3Bxy
QlXKrSHIIFpzv07J/oqf2c40+p5jYZocJs5eGqphN+0l+ukHeYViaaxQalz9Mo0t
SmcHfKfBaFj3B5YGOzCCE2ARGyQHI7bkxZhb+g7rwtA2wJlNC8MfvNuEVU3BHCGN
iGUKIMvAKvuP5zZtYfucZ0RzRWwiwV2nG2Jcx4s9JcHqCFTpGt534AMHgIfmM07W
LSTS/ZVC43pKujbvntIaYTR01yvNPvCQqfAyOrbaQSmjnPJ8/LkM4IO4j1lixf08
HgxN2rsX74wVP4DkxnnB+okYyk0QEv84lwBGYBETt6UsUdyEX9N1Rk1TT6Bs0seZ
7OXFzSs3fau3SKNwTx7+uLtaNyimLI7XAHsv5TKFUw0p9j9Snc+yqfHyUOnt1LiB
jJK6NEnEtKA94n0nx/iyhBvGWjX9Ui3bjaC5Y5IITfsce8OATD3Va6TpcXSZj/II
0PANomeCbFSgBjIGzkcDQdrZO53jGTq9SFuuyroXu0w8nt0y5V+WclhiRyRpECqr
Py6l9HcqX82Q8LIm60Yrva41HygoMVp9A6oWzvPeilPLzD+sPs23CgeDunK5iBnw
cW4kdDB0WjCm5M5d8SeE/gLuU3WjaS55rUPikmHtTweZ6wDWpLGoseFhq3LS6nSC
ug5sKnGjA5kjrUiq5cAjGgXmgesx7BTeFgTOIebfZDtNHY3ylsOlJ7HKJqlSnRbT
v1XZmjcAnR4JVWKMiNnxSmaLIO/19pGsJIAXdIrMyKdIkCrtgwLQzlXb07Z0UOBf
jL0PwPWKS7DB11zqZQrU24uSj01sJTj6E8Ykcfj3R585tlRis5XAX96l4BEJZRCc
GeBxeshHx6PC3WfanlbCK0048sz0WKpRHhrcZaob5YPKFNd5gLbv2btVLPcG+Zhd
56ccw+cSMqQs2xcfpe2or8C+wEeuFfEsfZmmbp549rfwxof8tVV1evEUh/zWDIbQ
+UvhYXaKqdl9OjAYO2Uuo3EAIP1ypuNNV/F/9bVpOEhsgJAsbq59Wl5z/dNvXZPG
XNWL2V+QYMk41rgTnRls8ZJx4m6n7HqTDQZblj0aITz3VpZiqS3U/bSZL0folY7I
fj1O/UdguJMZGqZIk6UQpxtwVauTcYfk48wYWL6AlIGffeotRO3A63SoaE0Iwtbm
GeDZup4TsER1SxUelcEb6mOUHwok8xE/rBPRmmG33vdVkQTik6XEdmmGjI9gqyuc
h68NRy/l6ZBhNPlB37VbBo55tsYQ99Zzj/fQRqpusrjTUX8MQmUIDp06zPUKKQKr
bSE+/D+DHIDuvadTvIZQxvyO3xxGAfpbnYsE2PAtWIXO946TYjX70A40sE1Z4TRv
0jmKCAP5/snXXY5rnd9tLRwZSfUevDHD6NaEH8eB8s9j6uuk8ClX7FYrj76nlq/1
yBVoTeG88gYN7iy1NRd6kGorXBCw1pNWsIqwsnaoISDXiXJx7Dc7C+DyHBLOx7dv
xJYEvfkK3MzWVxhXtNL5zKRHYJLorqVShMJmWTE17o3I75oOdwJkZkrDG83Mcpw+
7npyPcrhlK6Vf6Yi6SZS9r+MzKfPRm8yyTysU/nSSa08wv9duBb4hndRcR7O+8cS
gXoRYrWsZXRazJZPrJ3jWXrmzngKrDUy1DfTRyLAiJaQojkcBeFwmB/SMUh2glUU
Kb5klNnMyLZNIHNSFSdcku9z+UOMjN2nnC90Sun3mIf287sGoc0siGJGB1B1kBOz
qfo6w4joO6e+szFQkLx/98ljYOqsLJl9uBvAy6OXqC6tBvRehWmTqtz7Biy9P45H
zXl+9Vt4fSGP22gv4eAA6jsh+eY0sLmb/2Ifp4NacFkHXJ3V9YZ/BQS0kMdWPoXN
uT8cAnj3bp3tfz3f1ThNhpd/AccMjlAZYKOvK+d0FsF3WDdT+O4qQWel19l5aUi7
bzvdBPV6jgymiTsOgzYhtfP/EeL+7Rg09DIGf6tFPgEscC2YjxzHN9QPhwD2DLXv
F419WSWkEhQKn5vYKsSX3m+LZa44JawMRbAVHsumC898V4gmI4wE8iQ5DgKU4NE4
mPJP8qtDqY65RfOhp2hIYJlOBDh+UK1cG64KyDFlnbUu1iJAvYz3q6kfUd1QNk30
sjsKsdAhC8DcbFJwm0rzsvwanCgqfVR2QSfl2O0+82siq0sszOc6boi2GUHgXDk4
VL/rnbQ3jlWIjaU38WkDJU67+peY8Rk4ebVnY10EiGjqlrgsEC3bT3l3eDaXOv1J
9IO9txuKPDQ5nNyoiiObi4KYX+8An+VaRkLQMJp5EidaVXR2dv3nSMiDnKE8ctyy
It0t5yBwgeOthmikrqdgtji6F/2D++Ks+FT0QLi8hNkliD/Vz8CEgPIPoUTqhdpZ
Q1KKwyFzJl/K46+tJ3cNep4pEPzYDea1hcvD/5XpvLcDgjO3CZElnBOlOFhmg2Fx
FFvAsqe7PN7LzqvasW/saF79oDvt+LBO0y30Z09QCmFNI2NpR4NcreYDKjTLnHup
Dp2PGVd4UBjBeMLhnSq5bN3QTh5cmMS+AJaGEDz1JrNQ69i/786PG2LwLq5mu/XG
gWEetkYB7KiIWhlpM8McNNQ6JOtYKm75lWdj3wSaGDUv1satp4+IJYMrBa0giCMc
ELzeR9EY0/FqnmE96KYp3RXJ8OZcs1JcA0GSY8Qi3zV3/QcArLDmvaGVujqv1SX7
BIJBuNzuSPi2j5n/KLgus1jKQQ/xT6sCYMmCFmLHYdD6d0t6Y2AQe+Grpqj5pzCx
HD5XD5Qn93knBq9LV2swyZhTNSrv0MzLsNbw1rXvs3/wT3nhsx0dRYs3qiOxt7l0
2bXKHJEMHyW+o/6d+h4T3djfzDMM8RnwZ+YtZL1Vdw5fpyWrZeBniQIirbgi3G4U
RFgXTuYRgv6qiMnGOBQh1ER9jabsga+76dvaU+Wx2i2UnJ0IwmbP0R6qWLR3n+JE
H3kvcA5tME9IVo3rsbpcsY2J87HmTDRFrTtnYkr0XH9iHEN/2OK8x9riIrx6TRex
8dYJltST/EvsvMWT7nNqm65ZNhUXtsFSj4uIi7PuZaK8qpVN24koYWvXA5u0DYuG
sHxv7MoNBfU8c9QN8/i3nsqTHiU9Yr+Qlml4VUlHsjzgdAirf+s/j8zeXooBvtRl
Y4t5zubXnERXQN+GPuHzpY+l7goCukueadD+v5fZnNxs4XjRp412OC8e72VH12EM
3f/2E1sPjhSVc6GEIrrCy5nizaeAJejfAenqjkgbLYS3C6nDYj1dcl2Dc0zve03C
v+lXDGi7Mgzhq2AXxKxqqC7oy5KIlRvuQcjIZxPwZMsm4VN/bE2EZUOH32c4MJ+T
tm3zKrw+Y+TzLX4XIzSecXXdYqBqmyEAOLh64sYqJho+JGrxa5jYvzqXaCP2tsYh
QoK1sAzi1XLdwIOTqpnBAqs5s5OuJycYB5wtWr0IeK1OhTYmxsP6Zhc0zd22FMwc
dM3aaUcPkYIkSI+YQHbzVEepHoNAIU7TSEc2xBLlpLTi4lOpkPTQS9b8WRocb/h+
Sh+7aL0i124DmAzMmsGpPv4oXfFPyeV9eC48350xtdNhut14lZdlrnVlo795si6p
v+u6MupXDY3w+en8XEjrVEMM7gVKLuGlQMy72e8qnPgyf1dn9EjRhyevJh/+tFYi
ysNCyS58k96QJEzKgP/fDkQT5UCXUq51/nf9CJLg/Z5xqdBXPsVTx3LXbuY7CNU2
5dgDPi2pU0fY2sTpWxLkncCgsF3sGtvqg1dUuL/u484out9cI5mquulK4+UkbDy5
kDd//KdDRJfReAcTGH+CScoUyMwUOMx8LMKDVT+GpUGE8SR870XYz492Yx7WDdmC
6TQD6nb/JU4VxoNR+g0B52/pA3X7QRUxdZghJAZddC3z/MrH5TLIupEkJUX9axWm
C43ZEpAxiBYLRXUGkFA7q78hzhCf/qvXSkocOd5pNPOHBZilmkZOZragSEaFKGXF
eyzdaIvqom994XtKUHk9tZ2CGbiymxs23/nDgb9GIhxCCZPT30ZlOTflTF9oIRis
iGBl/GuTv2OlUw5UnnLXPbc9tY4Ul9hOoy4pfPzhy56DrVsbxzAsOVc8NINtE3/i
onhH6+6LTo3GIX/Z3AdIDR77n2noDR7FpnAPUnI5iJlPZU49k4ysedB9FU5cSiPu
XeNrsTvw/xRfEgdoQQ/xtm+Ih+Nx3o8Gr6UCoU1CIHZ9FzstR9yc9W++ek9SHati
vNy/Iv6545wTWXaMAMHKRL4hEjcA7HP0c/WvwxKq/Z923ZqJwTTLBRc+1IJ1uVjT
bWvV4D3BHC4Hr3UUc4QGidD6C/wCAwjqaXvJ4cQtsTyjFrM+1zfEbCX/FbMuaYYu
+GFkQrKpRoFArsyPKonmM597cl2Qehc2taXhcCDdQzFh0HBeZooQJvx0Wd7KEQot
Uuwabqz8455enqUmhJGgm226D0Kq2GcC7xT46zHSJKoYOBjZUEgc7cv2olCBXsRu
P+m8uzjhyfMPcy2Yo/qbark9+PtXl78hfCRLKK7czq+ycq5IU1bvDYi4WjFeVTPB
6FBDU0oZ4jBF8Y0Q7Kaw2D+Rpo8kQRC4hkMaQWFf26FrTnP9Cs3JnmVMQsUHZL1R
M0Gmvp9lhd6JxJ++Drzavx2izJyysORcBVnZRTgU/EpmY5goh9vTBBtfetcjtypt
oMa1hZkvCabi3Hk/I+e6/Pag6oh7SdBlH86nK4KHoZJW+WzxwwkpqZKOpv9Np/tk
9K1Br4vJFPYvOR4b+BXsnmOEyhb9BJjdZ87n+Sh2V5c7D9+f+NMaR+dOV8Qfumvs
cjtls4rM1hkxmGLFF7pgsyAvillXM85q2UtjhuhVK2GAWqqfIqnab+xVwTNFDWbC
UMqq7LvnF41lWELFZg8HgMWUKzbAFlaU+Lt2IUt1jb4QluPWWkOFJdRsagxXCgJe
R7O57oYYhzPrimIlNFTdJ6s2ioktrh5I42ghLBv2Zy1kGuD179CJ6rya0fG5Yt1b
2zd32a3kzVlTKFxVTo07ONrM4OBg97luy38kDYF/CF5bFzO02Emz5eSCtKr49aga
P40ymsihVqdm2dthbHMHh5/VwjaVleq2r3aCYFsNudblusyq6oPv9E1RV7rpRRIi
qjFMFnAVLB14kDOW1FGjLXIlwLvQVoRQW0VCdXn3wPMjCZJdpt+MY3VlLbgxUl0d
3xGwQzuY/uMrz6tAu5k462o2+hnwTYU/KoCAie8mJZbRQH/EsECZe/6Mcg7qKTxP
Ezw05yrhJlsgNxzqzXr0q3eJ4npOhppNU0Nz5tat49Vk7RmrBaAjPGLSuFllKISY
ioIutf0CIsgymQbjiPTvJfL7Q3H6mWxpbk2NR+h7q6VuwRIPb48Xf5P68r3MMqTe
nk/I4+3h0MmXcZIOn8nSOFlHNMEIBSR0JqpnhlSieXfmrv5ozXCjQoJbywuLbGzk
vqaWLUsJAYF0gDuafJNTixkhISx1o6V9RsM/0LxBKKTaCNEbwozNNfFMe3nbM+yO
L+yGPdrzIrydq6GX1dNczA7wN5gjQa4XrH2JVUXkxHRyPUVnJvTU/pmQm2uNhZJf
RPcUnsSiI5euM7p98LSvCZIeOu5v0r7ChQexWH2v+ZODKBekwf4dIcdAySALFJuW
2blbi9kF86AAmqDOZK27h1mmEJMFGuHkcMnWJI/5qMIj1ONRBsDT3tyWfyJqZbOd
xxuClANXFESsycXSmqI5wilUh5Da7VC2MAjAWFRzcpH58rg43dHqVYDwIJ7xbcRe
MQ4oVqgDns7WcpeadLzYl03d0fImDHNyfJ2Yi8fcpYK+EwdjSbUn2gU1WbJs5zEM
Y0FYKFjWoUS67jz5Ul07QA17mY4zjHdL+h+smRmQuwWwUO/TZ8qhy3S4AL5Nqb4V
Pf0C9BO9J4lERRoH+7V0CDUameMS4LdWLstoc4LwAmjGosSWqumksJrbsYTgBe+6
j0ngSrf/ZbRSTDawsA9qyTfkl02cjhwkseP27B6IFUrCfqr7So3Opax0GSeTyqdR
o4ouTKNL78HZZ1yT2xUbmyhXkYu2gX3Sm9fzsom0EvW16hsGvMUp0c8KvEwXONuU
GL5gXAFQHaPZuWGe2SeZzAxzqGeL0L6Rrsc0t2rerfKbvHa3oKpYFtvJXQkMSRSU
ubRAs2+Azox9nerMpIoVzv1zoQIGSafsVLveImqqaulD3EgMlrh1hYQfBXHS1gB3
j/ouf6pFPnC9FTIRauVm46t+OcbWk+BEmeUtICcQ9SiFxBzE/MVvSe4zAeVue+hq
sxvE/DTpRLw23XiF1hY3x+OVIiIAVdrGE2O6YC0uSEDrQYFTL/YgrYqzqbNxt6xX
rtAzAu090J63wot8fsOmD6GomjQ6XlO7R/txfyi5R1rLRpaOhbGZDM4wDOtnG9st
lhwZSS9281WZ/l8DmoZxa8k3s5/GfMEylRlGs8oulnqjddJAEEcuVxNJQRPj5s3P
sOXc2LD+AW8roBtqqCG5vcAwiLTeLxGkteFQE7n67i9FMrGTEJjEalLK/oMUKj4l
ONRmaEHPxDfjFycQL49X1HvBIzlyg8Jn8XfZ5F2xdsaH4Bs0rqsf9nx4FAFFoMA6
I0h/0gp+NT9hYbSDlui9Xf4TYQtVqc+j9t6pnGp52sAL33znR7cDEqRJHmb+5u+N
GpAAyb+raM+Qy4Ke4RIaG/gsO3aBkVLZPwdkMqB4wl3S28sT9u6UKGzHoyTlT/WI
7BGQGnbirOb65UHPdGt/ZUSxoRjGVCrSPUIG4O4YGF7B5zsLS56IMcB8T2FDnoIL
xIcAimubI1AE38NVKLbfc1hTFEqcfGwLuvYet3rmrwkM/qL1W2sOAuVMqbQfUo4T
a1vK95VC3cVCS/rUiSEeOcx4SCwzg7UT22LeixuYPTVCwYj2QuAcCID/85EQDvbo
yQWV1FZWnU7YajdpW7JCRicNelOH1GTFE117CU4HGoKxRbElc7ZXQeTwIDL/NKo5
YDPYUmwI/NM7m2B+kA1+5xlVyc3TJgfWAvS8vfpD1X4KiFZuabo4pHhG6+wXBvjH
6VBKqA6pYp8YoLuLGPDKiKG5YndzOM5q07bGFeWeuI9zv1zeJsDmCsxJaPXcz7V6
qn2wIaQ5oB9jmbgwQvTPkDcLrx9xlZGMZ64h2kEySbBD0JQa4KScAYuaAQoxa1kK
6KVWwwve8OEYFtczAr4hvCeNQ/ipVz18OZ6WYDJmVZ9kZD2FUj77gEQHnZ+VtqZX
nh2rnUP9hYVqjhaRWA1udKAdRWdNtqY2UGE2Tz9SzdGTRV/6KPeY+c6VE5c0ucI0
7fm1XMNNZVgceBvPOdbVPuIeKGAI4wVlNP2wEtUFIJL2pfNh8jGY7jaMSwgNGmCo
O8b1qZxZt1b/cIkBd3FfY3ulLmOVr/T0yFlUH1YIcjExqLyAy/E9UE97HhS21I3h
O3OFgNdcOUvajG9yig3WkIpFTkYVO9EUqtYuxWq9Jja3iANUUPID+KBJrfRssMds
KDQBQYdML4Ky8NsfXKOai18bkPD+vbfbw4BGcAvde7A2xH+bPJs6LSllsr7huRYN
tu3kBqX/r56DsGt3EOHB51w9wkoSoE4Jj7qrHMOOWI0/BAMw316u4+Er7JrRsQuq
+RwrOWOKbqrECED0ZPPeCYQcC7uUr8yW0Cw9WECMKLL2lcLbfX1aUFy+kvC3k88w
Ug9d03ur0PXchlVhvvgifapA+ZXEXfs/z/v2DjMTMKGHySIBbS4WraC7Mme5c+UM
bkjokKo7WFUYvWq2lUNqcRiVUPsdF9S+2ytaClCvOKzOlmSc5ar+uuJPkWMwRT8g
HN6tEvtJmIt56wEC/JDpGIy6uwI5FbFxV/1rQupoXe6FwcZ1d6pMqkosCtSaIZJ4
UH2k962qWxH6sWLxEA9KNEjiDzc1HkMxNetq1L4Foz6h7wsZjnGz5ikuhKHU75UR
c5aSY67socmZty56SHm3ArJLRZdcd3wz5BdembhfehPkYbHOCoDurptUXuS1VeNP
mIawS4eKrie/gLCG9sm6fUINaIzLZvtXwqwMCTN9ncPqN0PUQM8lVq7LOxF3kQkH
H+vZvcyakwH0OBNz/7HkV2RhjIuDhsLgxCfg0/E8EpkhysNeylR9Ul35R0BSVm/e
GJgGCwKkRyVwFAQkyQXFuC9KGjUewShqsHVQ4URbXNYQIRbbplJn1rmqab9CN8GL
J+viCor/2N1qZeJncGRow77NSFBQ7s7Gj4UqbvHQ0dX8bg/vU+mu2jLCeYvyNmSm
D535MRxZDtQqggNz58x3R4TqLOVkaHQhcxb7/VS/YUr1gUTdBRweR1ypqFMR3xEo
llphmvP4rZDuZg1GrrpLIzAmHSCnAQ0aPal3sFBATHaXievBDzyB8nXR0EBCE5h1
IXTwmmZ1hdhSyp6e1f6x3YTi5jD9vQsen5ze67b/St7df2SjW8h0M7hDxEJ1sys3
sGIOrnCcZx6R53iOyZ1gbNFoPCwC7mPiiTIz0LOXnufPr0FLrr9oHhl/ZGUF+gfS
gUMTlklsZc1g9Lwu3S4IbXTKIQsAq4QdnP8c8vUyuIGhqG8+E53gK5CoshAg6/6o
Bv1R/JUbhIeiPmzZbDeAwzcgbrigHzMLt4e9U6C3yoUNrNTRr1cryLZB+ntNMX+s
08LSsl200tliggHs+Fq47Ig2wwmCYSJxyDpWuBWYe8u1Eo56CZ1kZC6mzmuo7M2a
yGPIx4jh0DbFQcMQ1/yN/2EyLlj3kllA54Bh/F0lMlLoqol5BdQ3h2dv7oIFYgqm
t1q7yHQKX50YaPXaWlyBvdv75m7/otVkXojFyDLj1eA7SVKOa3n+i/4ECkhdoYJY
6GDRJ9aZ8+MWkrusZ8OQ0YIF+qR+sxhX9cwEhexZlygrJyhLyb3g3+G95JWaUMVX
DFHYqllavxuZ2lqeo9vbPPgMN14WJtt19VVHANEfmuBbWa1DrgHZH6eU9SrZ/tsU
7+JwSTFfCUU893GgqzOKmsgX4sJqMoQIj9aF6nQAPHJPawQRdwyTpNWokK5Dl5IC
JQblwJGHp4Bgf4TPY/j8mogmBIynmyJGXy3uAmkxfP+9ymT6ElPfCSIQ+UQDsOP3
PMe1uWqyQzAgnrs3TNvGD+wgoWeLs//m/23crGOZK8YJAIFZgaucFS6UZLa0iA0L
BJfs/jkE/3HaNrbL1oB+j8sPSQkBgFsq68YU1/iKVOpS8EQTyrM9GDBZP36G/VZK
kAMDd221C8NdoZgH8wnnKDJ+iPKlTy5uV1gM9qGF+vFNLkepqIu7WdfUwWCtX46V
n872xSG6sR7zoT017WGE6WG3RPckNhrMF9woK/xzGQls0QRouTODbLHftGj4BFWZ
SyXoC8dOD5FhE4tgFEimJTpRbsbcVThboErgjyQ4JA6a48EKSGg0PHUu8zBLMkLl
tMge2KoD39GNC4YAxJiG44iNnJHrew8k8KxDgDucyGkNs47cKs6B4KqC3QCto2BQ
sgQQwi1HkPe0QoPTAKXkeKiyCgF0G3Hrf9JUxzXy8AAd6riC04bv+CWkzo6KJUq8
rx5jQW/rGyJUGTvBtvXpBvnGABUR2CrdT9RcZtDRgqfg/DRsKCOIKzKdvdanJwhl
j7Y7VsZ+xQjNFi3CVlQBKgpgLheN8KmkjHcMdGl5HdiP2Z4LOcTrqBHYXqeiqQsU
Wxiyhx4Z0ebzPk/5E1j43eBzTcKqOIZ+unrC7mt3Hm5AGTLemOqsZZKY1AGUAD+J
7vzhlLWlFbKXRT10tkYQ+fZEXKLaNymoIJ5+8UOmHO6twKx4EF2/ZyucndfitN4b
ez33yoJq+AdNE7VE+Yuziv3C0ZtdlqMelmL3RmPGJYitwP59JLncNgbkfXUqfkPp
fB3n4IW/6WTgYLxhOcSDkogmwDbCzgroGys8quWhROA5vRG+KiFq9bo/o5JW3kP0
jsvaohkXVjlnLYHicgME1AUhRUZ2R9V6TN3yN/2r8Uc0LDFbwlaQ9Gji0P2En12i
fvcnGu8yLnxtwVenf2VF3ci3vhttnxrz/bGtCgT3wt/KqQm7eT4PV6HS0ywC2QML
9zg2Lk7ij0t5rSJS3SzQvexMvMYVuP1EALXCioVspeKpxezxQGrJrw+HMSpy8/Z0
jUJyKoNZad1JqMQbBtjGbhBiim63VOE6wJqP3KCvIgF97zIuxf1d35EHpjbSCOTB
kQyN4ADfWWR+ykGuzNPM7KERYjs8k+0ObMksXL7dhutx/YnS/ScgKEiwU7V+3irP
EyI8Sgq2Qmk58hzaHTfTLT1gI/qTi7apVCxQD7me/DyYrh4Ke46SnB3BK9yLpwm7
sVqSIExx3tEBkfuX18WYyz698vLKmSTiPk8/qpX+QDdxZplHydPQx739wAcQrBwR
su0bQs3VYTlEDDSATGJrJz/E1+TI5a2GW6fetzbl86zWblP5addQhOlvUDSXTEKr
CRxgOFTZQI4eGCYm/DU41zVxF9jQPoLiG0bygS/n5D1my9iVqfe2uc+hZpDzH1i4
igCW5rcc4UBDvS4R2Dr2fQlvNDXRfK1IBbtovxdn5ehfjptmtLY7ii4sfZZRauqt
K0lV9oUBL3ny0PnW2JHpLUbkCQQMzfFycSbLwG4TdeFklwRGateEYHplIlSd+iqm
jnXJMrd7f3xT/eHjhjNzr3MefCATHeUt7XIm3NUnIRmToMkGqsRCGEMFTq+2nOS4
gqQlHeV1FPgU5LiJucOOjZ6Qj3E6BUBCBngmjUMtoewLBgW+3J99eIX5YRxLMM7v
Rul9j5pkiF9bJKb/08hdbrPgo3/WOMZ2FmWtuPFqaJSffu++gmbZ+6uF9x6ixqgG
ZyF4sJLXDeKR+QhJnODOUhdXVDsXkU69ERGJG5tgcju2Xam+gSPV6g1uvFoDZ0SC
zV0+AnMGk1bhPwk4hdZgDZglAJKAK2REHRK3SGYYxPY2bnISexHDSatDBIrcuDh5
sXN/0D3S77i/lCF1wjECNpllAtlVDL3UJxgaOBqgwDOOU4fmRa6BTLIrZqGHJb5g
b+TtE4rVo4a42w9jmday9MJQxvKombh6d74BwACFIqvnfRQd3rv3Aff4S4lfOSL1
d3I2knA78SDL7+9mUf9mcEPgZaGLAi/z27DOAeVtGm9HkPdz0e4GPbSCElyvQ7DC
MUVlihAJ0qprMufl8YNGnzasVnBAkRcIiAXwCUjxDuPW32Me5sTVqtCPefi60L1b
/ZBgMu0++mFGQ/TNALsPaHdAnkviM08Ahh27W2Tky+uC4JgPegpzA/ADjOWrkdNm
igVy5qAEUp5Jf702U8hRpQuSYKfAIBjJ8xHEQSex2hZhpPPUiNoI7rfCrn0t8Axl
QZtDLjwqU6kBwyC8VL67ee1FmqpcRysfPNkq3oeCmp9FPFLqwVdccD2eOGEd7ivK
NhGLmTOYall0C5iHAD/sTv/NcpMhhReZJ4KuKM/LJCfR8bSauYqy6aa7HQ/ekHkL
F6M9opkCMYYt3DkIH4Ygkmh9yFEq0GVVViPxKg2+SPQ2xT8HuR/5Pt4LGwZ5mvM2
WKTxSrrWW1lggAvT9r3yHUlWki34pwgvOikZEMPob4FvJlfwraWudpl5OthLzE8F
rwg94IDWBIUGmfbDzxBY3ZucvI7yjETdENru3moIxlvOSGEJhmudJHgjxNGAE1mS
4NNIhpcKw5yavquNy8bH4vJqUFacazZHAH2PC/FBlG2PfDXS0/EdSSRmMeH83Fnr
lf2y9ptGZXrp3UAXsBrDJKyiPsNKNUMo/xap9uyC69YReNQIJpmIa0ZOvI4jeKRk
Qh7OylrUUZl9IqF3luvzKMKOi5oFZQA1SilIRuc12GbDpUPGR2LTldXzcez5+e0l
Dai33ab2rdCK42Ftsp30bZ3w8SVTTLjqonA7XV43aDsKlgIUAT5OxExNBfsMfpKE
VtRN6BQaRV9eEwdhP1hIdEYngynW69rYXt9xvDhU4oCkKz3FoIf8e+VDCF5rcUrE
ZVYKNJ1N3XRNpdADOJnR5zkpgEH/NDd6tzWJQcN8g7iZww2R6D750NLoBncYjNne
mUN/oi38SEJDNOj/5D9MmLkvt+BVfsFRZCSfggp4UNyqR8jHpjlejeooj9bzCssD
yz0hOzysksZoIm7V7xxS9zKD3WlLzbq5xg//WrCjsJd8aTToFmpL+Pgy7mdWRbg7
upAevkOU+aKdvvZPZYTJ3hmQ0pNmGG5V+SefrgiF3cjiTlPXgYRInC1M9PzakgMe
MMEPjwCkdsML7kxrQgj0qngLFvITRR2roPm7emko66fD+AyjGoCwgwewz3uWYhcd
RYwPBvseIyBLeby9iAtF3NtGJhLDuYTep8SrXd7TcZcKRmEVZUtLO4ijuyGdTA/d
EGsZBGxpjHYeD8Bukh4kQjloDysMDXdVmv/mptp8B069tx9cl2091Ew9Ofoes3ba
WMOvtT5v0tbyu9ZL4tlPFsVHtTjXIOT79wu5/RESvNQTclDbbXJu8Mvyx8Ny0BLF
r/lGuboVd8wUiGbEQYylEppNTqnAeXRfGt4dEhTRswTRMafQ3fgOuM2AQ8eMrjbj
IiNgIa5B7Cr5FC5CwImxLJB2HZ1WtX/1WkUSTvbUOwTn/jHg91jFuNjkaoFi+MBx
VhJndtW6jYapY+In/ejbcAbtnUbqShdsoDOo9EgQHrbWRRrcUKJ7AVZryrMn0Ikz
e2b+pgOx8Md/IVd+zUNbWVUuGXV8IfvFmLbNydnJqThKXU7xx/3Akgs4A5+AIW2j
ZXDA6/SCdYAUypJfhSjvsToksEX2wTqzrLdbyLw3eQKh6B/btL/pYKbuhbpyK397
7pbTHeipBrBHlj9qPthmUL287JYyEsOWf+RZZGm7vef5vDc97jXe+nB+WSHtZHNH
GirdXyTJhNPPuAaEMGpCz1I4Xy15plXTZ05iAjGzwQjw0Hd2EtNkD0wsWMc1ip9b
3sTTmV6vwoFBAzxpgnFSgYoPgMXpp8fmJqleSBd2yutcGeQO1S1BBZzE2RMlTJGs
sTr4L02hReBKgexGqFHMQEKKQ6MBPNvWv3jevLq8odoh6vbBlBF7JG9nGGJtRhQO
W5EDZMtIdQTVv3zNJI3W29CGfcni0GUQpWgXg345583DK9EMglIqeeNVgeCqZHgg
TdelCKQlcYBJcRAME5OUdZU3WKsqxcMxPUgh7n3XkmlBQwadf4nlL6xWkR06OJJZ
zUws3kh41dKHzzxZoX2FcvNLLK47K5ymrj5iNIzflw5pU2jhu2s5vgF3Gqv2f4yH
yxBBi/to0fy0mZ7PEaizkY7megMgDdW0zNinREkiwrAs/XX152NkywBCZGlychfz
1/yUQ1mKv/pDtYyZvM+05Ngn/3VeKdcsiE5NsLnySIuBjIrTgBRelps0pTu1BmHe
/c7fudgDeZCqHUPnh6cGlMMRZ1GLWJuY2eeH2ncLPhQfl0VvzIfi2YDFe7BbIk0S
XFEwIPJzy9c2MJ2DrGrXBusA6eFOMOplPUN23y+BqEvtWWn19hpGMkQIN8R7pwGa
XXDMOpoGSWaOYrEYiqj/yYNdMg3YpNKD+/kovCafX4xHpoU6zbO8+o5c1B6EKdrg
v110RCZudQ7Q/QsnumljPXjFtu5JrFAmPgLvG2wR6dgYtTrz2l/FxqH3SHZTFPUP
oIT+UZReI5kcAgniYziaR1500sKfA2TeelBTAy7PgsXU6bFS1hHArMUhswggs+mP
9qBgkQSFGcKP24ljuO2PX7IUQmr+Tlse9HRZn7jYrxdksBRLgle5zSPhdhEKyeWu
wwoQkZ41QbOGyXBBnLIrXiO3+ICWe8CFzUyoEG5fSR80o8wuaVkuB9dGt/KMQUO0
jotKdwVLqkHsadmdN3RU4yVLffKtLznyZuznX3h3SAxXcr5Crcks2hQoji4grV3k
igwzaQ04kMmXnKqQYE8/NG5XC5hpEkEMuCkBhCLKFYH4KryCd8ICMdgvcrib6AwT
bUzf1qyqs0BllPPGH47vbFu5i5KiOtwBu0fPt/eHYv617TSPHP96o7Cn3l+uZgch
SZab4tLAHwQ0jqPawZKEPcgDAMHzgOcIICOJTSoe4vjhp8ID9Em201x/tO1DqzW1
oNQXzxRhkebZGQG57nL/3ESDlbw0T8qpzOiCX1gr81jb2ce4etbfWG/tycF/GrWY
3ehCRYE00lm5Ta2PZkihdlkJLXRSHdBoIjCMHwPFzq6f5pF+4eisPktmsMCQqZ75
3F3r6DIxg21tcDOI8OmgsflVGOj3iViOPcjUv8Ed+ZinKx5pzqxyyMvvpdQTbkll
CO2Ej30V8VfFLzTSIbDd55pUIvspi8TSc4SqtCU1clmYmObK7lbGhw9FdDIT8ApB
dVAUxBmJ1YMaBql1JXyRNCbDM5LHMPPg5Tq25sg0SvLcgDOki+tIrXyALHMIROv/
mjquv4Gny/5kjnxWJvPIjvBRl4rYncC0gmmTLfHBacvQSZuwnRgbuWStyh5z9tns
UzqGcalJDZZzkkOs26XSinuykJwbj1TS/TK3OQ24a4HZhoM58apK/aLv3IpGeqys
jbFADmyeQWmGxaj2qYVgEVPDza/P4C0m5k0E5FKNSCgobbo948TfHJ6gFncDqpg9
ba1bYjOaeY1DJZhcVYLOQKgo9kqKrSTG0END497S4FDHhYrYZSE9DJh/NJ19Bql7
77meyALEKMdaylCwAiDeQK/cq38TkQpADnasi32CxkJ8NSUzGE3eQwurVtwdd2jO
5sUGa6I0F0bE8fUbc0Y9+F9VfFwOOrM5KzMkyODHA93GOvrGwNzTlfghviV0h8Ls
QN+Mnrr6nSdgpoaImv1BSAPWN8HYxi0bY+tHfYj8G64VHg9sfhlAR85fu0WBDhX2
ws0OEWYkkIWpzOLys9wxeXL4WmDcVqRzRQZtweO8Y0/8H9Y4Y7T8vzdjOCZsSsFM
/gme1f7EObeCBUpBBD0OQ5zVJadjgsYmdcrb0GkJmAxhlKjwBNu6HuqG6q/iE4+v
PkOxAz4O2UrqEGLR0R/ETQdrmTt4R/XtnfEYKxAQXCUbY0YIPtQedNEnUiQ69FP2
As2Nd9m+1nYDLdeYRSB7Z/rYRrwhUkuE2VzxszmBSzGSZFq7XjKUpNW3FcJ1NRwC
00gtOqEHYNrXNO/8tp17KXFuUoahDYBE75E/q4riyWLZYS4GjeMfdxPITKUQ4XUA
dzgKVq6SBlRJRL7bOdUoplekuqGWix+F9B+m+e5FBfTx4mYJ5Ew6GQylcx6wIJs3
BtvW04P8Fv3+dA+KILKszpt2PL27ZIVUOfkVGfl6nbQ2e7Zmhm48JCVcpd/lQmnc
0hxu7h/d7pLkbnNiuHEdI2Dn14C62q+jbrQeuVk3bZrhpyix6VkDImyc2DbUmyc4
TsCCTnlc2iudPQdKDNbS+boZIrSzsCK5063cFOKwNjYshz3WlaFV0qNyXOhMt61Q
BTXBA/Z2hFxrtGjN/ohEGSFTxubmGNcjzTS6txzeam6wc97BHXpkUt+6G8gTx7fa
iXc6tf0xbgvBorvTJW7tcc6CFOB1s28pOQMngGmFRvotxUw74LmMVnbfDcQrxfqA
QJ6425S9xMajRTDITBafDqcqmmM46FLN33N3CzE4K5+bfADm7NBemZ+ziBFYJtkI
rD2OcXs8iysgP+mOH8K25FTlxh8757ajHW6DXs8ustAYE5fvU6kGUGBaYr7ON72l
MHgGFCkpjcpV5Az6pGSoZGLCO7LP5rYau+TMYisIZHnAlw+LKjV4+9f5GL29cJ+m
j+UBdKvPwwdUF5oN/C+zegW5+bk+jia9QToufF9pC/YcVLkKQ0G1LKy3cXKPE7pO
+l+a8pB6FrNYEhWse2nCZHy85yCPZB1guzl879AYeyCra2BJJMYtz0rZBq+VH9e1
fmBB4KkFKAPhVnSj1eeQW4mXmJ07a84ekPge+1p+Paf2nRl3ExToeE8jilX4k9En
ipCHbyW5+Y6KpClKwQSnw+zZYbMCymH4srQynXlxtfLPPxxLW5NRs7lEWb1A6jfQ
+W8tMgF9CP5sc/7jFcZ/Bt0ZQzhdDa+WYB8VeddVPCE7oYFSHmPJE896FcNq+70f
nwH8LyAFraO3N+Ccupg2oeKEWN6sPENyF8XeQzZHpk8Jy2SoEwykYd0wqZDlXZJC
ZCdIInkVKlIpoxVwK6rYoH0CuZbs4Gyv8fQ7bb7R/zWLOpc3SOql5gbHJlnviVx4
MS6C1HKJZKeUUWK7DyP1onyY2zccIDFhnzwi2C97eet5Kg8FzLqETLC/mR46rc2T
eqVLh98K1LA4gmAhNxtTyr8p1ZENCu118Uh965Aq0lekfGgfw5ZDWgc5W8n1B9Nb
s++ck5LUlJ3Fg/6pjF/JC8xAIrdURp9Lu1qeE8/s0bqstdCHqyHsoVKokj83Ozg9
MX1WbATzXWwkUFKi8QAPKPsHDe1CHWxNkerkvz8oIbjA6CQac8sqSxYvMo7mGICA
8t2VQqMrl3+M0JvdZm3rLcxAnETPcaXextASvU8iZlSH+bMJ4kMxhAGZZqYP5c5Z
ohE+NBSDusPXNOpXNDAlbSfGhch1lQe+lxGHbrWUfF+fsqpVMNrY9cU14tWy3Ato
N05xM/MyP9DRGSOdSInRudgJK58Rnbbd17pf5FxVH4DH6pkKLbE4gz4ZDs0mcybF
5I53tLyOVDxg5Zxgsjpgyl64iPLlTT/HWWFAl9XB7IsSnqKbzzDf9o702/S9+OqX
w39wwM3YIkgiOS6MU3lgYz1eQgWQcZyO4GxwVRj9UcOocI1Y329/S8B+X5SQ8mwI
95Dc1aaG0gv5KRnG/KVzFsoKYysuuy7TeLa/1tlVVH0Rp33Gc6yJ07J/lX+A8l21
5eiulkGQJMiD5Fcg0E8n/JefR4nWY+3476qIozDtt2u/TpM9pZc2eK50PWS3Yycm
s1CvxmDStLNlAfKBL2oUV4innCmekkkwl3W+8zRBkXDACsChwpSOc3RTTTJ1y6Sd
9YUJnF/p2l/RLTLgD/tv9IIC1qz47AQ/gOOVaLOctWbS3Ej2d83Vw9MLeXrrE9/I
rb36owpWAuqkLgA7VYLfL0Um9e/CNBLcxIwV8ffU/s5EsK/nkcNScvp2wjfUDC/j
5W4pRrCmm8NQiapd0iSoHGXZMYAHYI394qPSq68NmrqOD5awArUlQRvmRqjBNtSo
ppi+ydd3+BSW+6ymUBRWQT45GsKtB3u8vJbWegrj0Vb3a5MY9Qc2MA2WDMtPz9S9
DmeRBYXrs1Ak+Kb0Hec/LlYZSOC9K+Jey1Khjn5dilgKGRrxxXIl6ADyoeIict3x
sXYs5pwmmR3e7jkTq51JpkyiYlMMTBzsmsPyY1Dm4QqSDYwGkWQVWdPr80pcf0vw
K8ctNWTPw31Nds+UGjeQ3SmFWO+KpF6bHR/aICP0mwJllsYQXM9QghM2/QMtih0h
hrQhUcLWRylR3AyQo+efJAdskV5QnbfaUmm6H8qUv0f9wcWXX4k7ULYocmgqwefW
Jedefu/RLGAggrlJMDK77beYCLinjKELbL4botvruaPaUPJaRX5cWHA9YGG+KNkt
hlAzHv1Zs1eJ7Qo0fhoXIVPJcp14wVg5HGSV/o3sCj/2KZI+QWRNFdzTJbm5QQki
n0QeTRg8QrYskcAja6k+BOvS9mRAl38Bt0PTSaVQh2FtQJnbUksKxUVJtN9L6wOW
8qNF0eadvufqqvDZj95oL9njw+ujKelCbKg0mcpyKn1VEHzMwSadXxRe3uFePBXM
qzC5oZx3+FYE6TDsWyEkYwxYhZRdymGYcgCAFjUCWLdRWDG38Lwepznri+PMM6Ge
l9TjiqQky1zQq4str8GnMkHs4+ASx6sm2HQDfcx+N9oPcMVB55yLr8aWiBegWUYh
hXTKuHd8oPjXNTAKzpy77Qqq90EJ/40v6bUFCkfzPqxQqxmylU1ngARjvZdX1SiI
+H3lFQNXcRW5nv3qx1me56/BL5jmy98u0Foh2JtS7pQtcYm7OICPdlndaM3qZKWo
TCU8rZp25OU4Q441Z8DxUzC4ozYPwElHjWPAnGXEcmMvvNOPN/118EKpHRn2Y2m+
GVpJtRD5ObMGPA0IZn5RsSLDx1Rj2RSe4KSAgXUS56n3DMB8n6HcmTclz3r+SghQ
sSsf4j+/DchRo0ZN867lIyozyBwbQHJ6zcQhsQgTV31ecJ6xf9ee1It2oxCtkiDL
YdqS/eCTBGOA+QqG27DJNqxCeRThpC6Iy15C1kRCHyW+BqnpSL1ptuWaEWtvQ8Wq
7XevN32MBAXfBsj820PTtBaS4SYZLOPkry79Fy9c69kWls4vdfsjqtDZ3hFlc1aO
ZOti3c/lNr4RAYZgaitiSUj8m2S4mIiq5h7TPSAD9paUMUt2V3iJBhvOA4TVuf1n
qSQOGmF83Vwn/4oErh/t5OSchUgTOaSKmG9UWJRTrNFrcQ66XcAO9vQBYWHcYEgM
oUXPGpNqEK1rARNR1fj2qEw9CEoDRnRWcKnfSJb4RA7foWXnOFy0xjB/L5huOGkv
XeKDg7oqYFzxpySPpVhg44tUugl59/dJponCEbB4hfZupiOgg4UAa7RLPXBReb6E
qE+//XZVwE4wAXE6xDvJBYdgp0oKuhnXUo1ia0kQMkJ8Rr/YWenvJw+5c3cRL6HP
KykWX6dq4gyZlfb6hwPlcDxK0YzBfUChx9hKVF8x6MGOyT9AztiNoFCg2XuI7l2r
SViFLuO3ncL9C+1XPTF20MddFWQ9UR7y2OmMu17AZEFMAR0oJsFMR+k3XAJ2MiTn
TBX6EiAL1S/fXorFiqxeFXajtqIeBl1y2YeyjAabd67VS2ZSGEO9ByERbPul70gt
Gi8JUgindDIzAPTaHAYXrIEWOQgZnZR6d0CTbXAQChTjFMBb2phMCstNmEvZnorC
JHppGtEZ8roAkeGlb2cGwjHQsJ2EQ1LKknsQwTG+J+UAYU+zmg1yoPskfE9S7K6Q
b7DAan4j8sZogCUWyu1h/HnNm8uLKXTz9WqAaZ9HJ1rZzJTrYDi0hl6YZaQUbsKy
2tF/+PFFPvi2rB79gMNdUD7Uvg+Uu76uGg68rv3N8mzsEXKYzu55QmFayRVbWIyp
1D68vnTSVe+KMBAoz2OH3TGm7+e4aE+ef1jjroH5HwuESpmJTbSnQRrjf3Xah7MF
LpTT5bdj5r8UfXW4HuH3dGO30F4M7YwQWc+XRh7Z0G2z3aRIO7J0zx2h8mcjKdk/
rgoFkqZ9+DvANO4LJUW25SWIo6JbD76fEd5ek6w1oryxx6RFd7DWnrv8rKX9iKtd
d8SThU4ewFMcpvbFhdGLNIm+bBY8nkfYxoqgWPMA+baStwaPQpLRAzmGGZBIpHq6
3fTp3mJrJ8MprfPOs9Fx38Y6Oj6V7gSKuI0fmNY6vQ+h54ewviDwADsL7NWuiQxc
tNoPjlNxyr4ehXtHrjCpDQWBTFfQfY9LQw4W0Q9cd/TFs9BNbQb/9fNydSmDyCsO
73IABeT/m7Oy5sorHZ0cwSygiQE3PFxiK1IyNOajslpUpDrnNX0IIiNmgd4StsHV
AjRdhkIxmEKfJL4313Mz0VQJKm5yd/7p3HneMXbG5mdDUBdcg+DliN/4taj70d37
MMXpzIBlXNx5I1IONCCACsl1L7dvY2OheDHwAtP5nRYvXZ1CBaOYSzm8vEeFKND2
d9oDutd5duzHcqcTI6mw4l+gBDroRUQ2X7k6as2sBikRgkDehyu3dhfpgDya9z74
R52mFX//2FUK2eEO54zoD1Ipg63Pb6U3HWZ9ooYs2PdwLs8EvYSY3qpioYXFi99p
GpGC7xTVfnaAcagh4j4p/wH+NdMfAPEAQO7H5HN61X0qbsYHNXqBVytu96kLMIb5
LWQ1ISJ+KT7tqCJvLC06FQXZvtm6uw8u6sg0aYHuzvhMy+Yiy2osMkwlhU3F9P1p
5Py+uR5avwp70cEcyO0IxhAm9W/yyhPP0ywMCvPYEjamJCtXhfO6Aj39F2QxuRoA
VqoMIMZpdH2NYgIF6zkCQIVr0FWYMd1674/k5RqJ+0itx1s6CrbRsXp54wc0Mipb
GecPs32em2pnPtQo4XNxjabV5ESmvpRQFmxdmZQcHQGf9CuGB33kl5tX58CRhyRx
stay/UrVNoIJEH2ICD5HuveGbGOfXfk4AqwraBKplgcoKgVr2emfK1gGMUNZTXdL
eOlx8yGYOVsTu9polzohLwiU3Ziyhqytse9QGDtHCPkK09iU/5nSh6tT2gS4tD9S
NFrAr3k8pjjgXqNLYMawN1DIW5DQvR9+AREQEVENywvSevSX7hU7oNtgjElszX3N
AikX5co+5UHEP7BWOJfDbHfTmoD7l9kgF1/MSU8EKf758oMgiaqfYRYCnd0axO9Z
eRq0gORny+Gf7dpYqC6H0rLvx7zBpM4HDr/S2+un/XucaKnWK+8BpJ2GBkk1Libq
jEMDBLl1s8uSytA5PGqkUs8punjtZhQP1kM5nOzrW+GIiANLsIbBDPRFT9cbCsA4
sUkshvvUrDyR0dd5je95Jo6k1pPo4iWb144l9H30smHugLkcmpzbP/BN+33fHFRy
vrNqSlJ1f6+X+XH93SQyOENCZvczSoy2BC6eGzpC1Zv6SRr/Bfku+4zoLFd3xAny
1PW54f3V/ap/jCdixFl6qn72cI7OUaONjtPB6m9jKyIB9rjbJOjHFKM8KbqiKgn+
VzaAExas783qE9u3Hijx6fL/M5D0Q7kV4I0FJsLNYMzOWTvc4eas1LrK4sJjGjw4
T1ZALwRoYjiLYIfhL7Y/OZhZI4ysXNO6pbcFSlcBP0d6VecnX+1VNjCu0jjezyR8
eILaqyb5WrZluc/EVtpMtViD1gpWUAlyyy+zMyxZUeeUCBCBg/rVQodC6Kt01vAf
VaflNepoxabDwBKg10VuzaHZu73vp/3iRB3OFVL/TPlZ6g9d5zzXdH1+htKjdqvj
C7VWGanrn1Mdp32wUHcyISjntM7s0P6YN3pyDTesn1n4O5CbstDSKYfEgrKqRkWQ
hzvQ2oB2n6TSZVa700jjmbFkBmwzbv4fc9qDHMJcJwpop3ofV+LYzZjrW36RekSX
BBx0UW/H2wDrM6i/dF01YW0yqBAWxcZYW0RFRk9DihUzTb65HRo42Qs9Yz8t0Pwc
eBFopz7Mg1jYuDUo7uVem09JGARM0ZBgb6UUgf/gwtpTot7pxRcvUkxQ+Y1J8YA0
0MZ0psT32btH/USrtV+K7yX5JY5+hCzZ39aOTNnkzsClJI0m2CNZMSXETwG0bpMy
UPCHdFZQqraK0y7F0+DQ2vHVjl/OGUJttc/txVMyHM18pys3Z/s2+jrJx9lu6vBq
KwSM8WCZ5HbxQ14Ka3KRmZuaKBMCwCMrjX9R58hiELuTIMGNWZ+JrqJpZhmfpVAI
NBf2WB3gtaCIuG48prfBjz1UDfyMaIq+lp/ieBZ3StebgL023jg5xTw1O58+u5Nf
hn9EYZyf1vBqR/Zal2hR+REVMULPAPELRwf2nhf2faytJobafYsHa0q1tSyOs6ie
TTeaqHuu94Ak5KCr7WaOGm0l9CrIQrR9+39lgqYo9vE3Irg+kyRQzco9KYCxP0Fx
0v+dBzHEpFL1yRgYpKE5eV9paWy8EgYxRMGUveg7xb3u2loxE6AXZNlTuAxrDycH
A9nLd8EMF/jDiEOTDXQXYg3MqfQDqTPtHU/YI+4LSok2kqSufWK7jWpPNpIyt1gG
FJrn2z7AlLqJjxk/J44y5Xt9x6RUGsOIzvVR7z78hgWebW/3+Tj8vpa7GMf0dEU+
948VXDHOqrgxNr/p+BDHhCYiYcsEwtwQQKNMO/Clv22NCahXdAq3aridmfhCpM2l
BiwOjmrLgTVfXJHR/jq6ifmIvFJR7aqzuKSeGytH52Lr6b5+PRycV16h9/3Q8QAm
NALGNLLA7vIrjRfNxZJVqzPh5I6lLOYlmkX9SvuuADdZvEu3ImYHD9zqyvQc7w3Q
6kUEVMABMoG4/hUv3sbJMA9Im1dzvUx4hiyr79Eq4JkzNzh1r4AsPE6mwl3rQ3+R
U34ymE4+XG3sduQAje72maVrv1QObgs6iRQe2ih54IcouLyA/HA+ozf9dLAoUd/6
L2+4N1iZi4tLC0r7mMPxLq2GpH3/RlPOmCJyRiXl6gJAzCTdWjQB+72lRaCNABpq
ZlXmxb8QcJA1Nykj4HD/h2e+0nO7OMsjfQB4VVNEidosZxRlUlxBNodQrkX1Aq4C
5Jq6Eg3WuoJNjRRDVCmPKhmSTZW8lIYA7OpucvzXouaxWeebpcP8fJd4iWwYc4yk
YXa3JdWV13fL8q+2y6U5h82Mkk24eleHzIXipEz+OwLsj3szytvUKMS022QOQxr/
/nTEzMtYAX3s0fDlRDT7ZCwo7+g1ycQsqHWEnU4zRxg/+6m3GeIQ2L8ykZrqBDWr
D8WQz1aitnbDixmWbZ7ZgapN/XUlXoa+L+OPKqJEmLTizo1FYzQxeYW9NSCEhFtg
WSqEew2CNkM5aF+jucyL28vDK5tNnlX0JIReOwr74+d5g8E5VStR84vPhEK4qHxg
hhOQd0eQT+1lvhMpskKvA8s0oXFD4BxGFnv8ljjSfaxleHlKWCw8pWP8HE3W2s+7
9jV4KiCsadHBKQCU60G0mHAn7fHl7gCoxluW8f4YlcovxFGvzpIF/lnd103p210C
9X1+rburJy/lsEGsaM1i5WZpl3qLS4tl5Clh/yUIeH9GSXIPIrXHHsWOVyvEdYTq
KpGwswUjZncV0eRjTVLoVPT3Li0DIIZ4YzwyGP7M4X/jqg7BJBYzbTUyYVR5HwTc
rANKU3n+xDJIIjy+Xae5XSLW/3mLk9juUp7pycDp+G52A+wtFshqD5L7Dzd68NUS
e6E3b9aMwuVQ7UZ71OVTocBaJccGAtSiLSx2c4iZsFR8LlRprrB4lbKh73zMQMg7
NsEEvFSU2o4kSdO19K/GmBa15IEsFJgHN8ZIguR/uY5XZhn7KmeWhRNDfwPF5/m7
N2csnV5XeeoBZi2MRN4KGokPxuYWZ8uq1XG9Tmupa+yZQQMYoSk8JYYvAzVYvXCi
oHigmFqSv/9cWe0XRvOgkx5TuT/NKd026HZQ2VykfxYH0rXylao85a22OEqV/xOW
2chGild2Z6mkcVNUkwzzEbC+jwsD/bPXvXQlL4T1PkhRASGNJeMTVCNCTeo1V5K9
NWuRyZtloyIl5UUaTDp5g9dDbq1ubDBWEkQHiaq+mDf34Dr5ZmBxFC0YvQSHH009
5/gQExD5LFfts/2GHKJSgGUKxJ1hqVDI6Ev7+aWP+ctsOggiHnrYVrRxZZTXp2C2
TKdugTAPnKkX3h/uTl1B+ujycUFcMBV+lLQJTMTd+rcKuEVb/fq9w4Lv1BZKoRW1
+Qpfdl1JmHeS0qRdzIm1zIFkAH7gD8DwJzohmrNjoHVSLE3tvAVqQQ4igKgyIO1i
7mmCj+Z7qaSvtgXSacyOGXShgRrMSjLIEcvqy6fpF1HAT5eb+wvmgUZVj+b6Vk7T
D1PFFnC5nynG9qz/GESDJVMjvlYuDEv8a3PKNIxhCCaF4OBxMqZhgWyohtFssO+c
trVZQxiaguCnrQDNWL+ZXb60jGIVYySnkv596JSz3/+5avAa8Exx6/toVVdP4sCz
53ZLYCf4bBwrbMioT33/osNP/n+nDZD7BcLlq1De6EAmTJj6Xdt33pZPoJ8og4PK
uXzSYILaQ0HuVSnf91+99vAzviKozUw+HRbDWtdIBBHG2KcUYikwfVJndFVgDrWu
Y5NLIwWyxP4mfdQMmTVAnJWxG7yIXZ6oWF88iK+G+hYz7ANMC2JLqbpyYD/w++ui
bTR7Glrox5yyJs9AE1IHzJRZtT3WWx/YrLa6VjlCZNK4cm1NEmKj462/8XBL/8kp
aeRvx3KcbpKxwujPzlxKEO5TRo2MjGS0ZtbQgnP9zfFNYHlm1gwZem1ks3/bT+ek
Qwv4xJPy6kcFHQOWyqpPcQhLozCPOlSTYlMUah2w3qZ4PKXG20MA3atdXxPZEAai
8s0OqDpDFO9Iw+AV9Ny1cUrbsL3pbu6dMY4LjCYzfY2YWu57XvfFhRt9vcQR8arj
WClD6Nvo/2ico2+7jhYCguh3Va0pw48w2cHJntKGqnYiNYp1RrtknMSv89yhZyXB
rkbZmvp2nVzow1TUeKKDcSajbv4vaVBI7pQCEPm+uguYHQznoabHdD/mTc7OxXeY
D+oLbd+ix4TtI2eFBldaiI8i89OZQq890dO3S4zz85S4phYfncgTuefxka00ideT
UZd0QmbvWOECBGRTVyNugCRvr1GJbAy5MLTFCglfC2F8TuIyWKDp+o2KSqaSBDNP
oWTjFKIl/hlNAnRTX6D6jSm9dAXhtH4Wcs5biWa0m9Zq/HGBvsO+Bg6QOifsI5oU
stLS7WCRCwqjy5yKd7quiWT7AHcRl8r/9KX73D8p7KuwGQjw5ThifEpjdlHZTvgx
AgYMfXALr0qoUUltL6qI6jw3poJj8fIbdsDSBIGkNmPlIwqs87D8I7TyOxBmkEf8
HUcBqXlgBIyr+jWOyD7aEbfIw+wXxuUK+K58KwclOHgezrVdSb/tZuCioAQGzaqr
LW/9mOadbPZDl1Dc/28+c5HcYmBMvrxMKfy9/box7ohsjyqCXpvWI9qNy7HCpYxi
C7pb1QjlVIiMtRlpI+e5Fly5Kp6WJBgZL747+n0J3z6CGThN/n+VdUH+Fmf5wiwY
qCP/qAFapLyyeKMQ5WRG1RMWTuJg1tGttgWx8v9aDsCDiNXcIIQPoR1HGDFyV2YI
4RhjpBRPOYSy0rWgOSYTUyHQ4KNvQImgvrFB4x1WIIKpOFnb8MUNZSk6C/PDdQMg
eOQjk3Qf8zujpDMsPbVfzzqP2MKka5TarAhpbNUx9ho4+ZM6z4rxwMRGHVIWwEu5
Ugv8fkyNy/PfKNUfECJQEkrVVH9UJM0uOptgk2ZsT3Rl5swzYA5+7iNWiMlKWPZm
A5mxgF4tm4XYuY1edTtc1rl6O5Lu70c66uXZXAhCceevHiBga/1Q5lCAO76l5DeG
El4vZWZDLXIO9nJQyYDOhwAPo2rxlOrsKtn1XwTJh6ceJksY3Y+MbhzzqJeT/gdX
JTqM3bQxhiy9+qOJHg3HNEsqg7gat944pmnFET2kvPtC2FBGbhghZ2beGrzuv3IK
fpgRxsnV5gz4OvaRTyhB8MmH637ta8QjC7GX60Es6tMYnz2BGNGLE1D+vcn7qjem
c+TcdTUhnmFgjp73iXJzKpgufmYUg0Gu0qR9fOwI78Ixfz66TL2ulyHz2E+V2/DE
8aBeFLf05EQZrpcsVOU8gXPFe3Cju2JEjuK2N8qj2NGJg3/46jDjj+CazNVG1Pei
01XjcIn12/VPvmfZ2uS6uw4CqmCfXha4iTa5eSGTDo4+pBBicHfsJog1ozciv6HB
aWyQHcM60MiX8bIyFwj0UrrjUKpDNV8nRAk4PV0Dzrv5yqr30ymVG+Eni7EQV0Xf
dqgWLJcTvUKHyqWekseYcXHIU5u7yJ7yHT9pxNFHvm+NPAdLRzUt0fZnx8j7HibJ
Iz3aruZXPv0/bVywRVqkmp42vKE/HVEdmxF482VFTE02W70XssSBz/rmtPFipueR
X0Esawx2FMMH+IxH8zUvfGxovC1skZPLvVw/BlfGGY57JAwEFEdfRZyNj6vgx0jj
jRPlln6Hg4KOKSmkDMdWCobUGX6K7REt1gmH5u1fc3qPnu2mYAjSgw/bjmJwAUAW
3nBMbShi+97Drl5Aa4B/kyXPP7pXFOfb51qkz6ZmKvhr+t5+2OYckD1kCHtQJmZX
Ca2TQpu1snF/ei7168y209TwZ7ZlSHY6CfHAVWh54Lc0VXlMqmQQmMRRX98SKKqp
AVlesprciROmW3/ZZO4YGJaTu7iPQ8hELnHK1Zh6wbvz8OxGUyfosceG3ij9zP0u
1WoJSP6DBo75ymllvbzsqOFDT/rhaUR9Sv9DxtBp1c8qooFZLv/FVCQPUPohJBtH
YkqE4BMee373bU2gEf8bhSToHIAq6AOUX6ypcvYbD5q10xOf+f22owh1c/L3YxES
GS+NZRCPtbtaLKBwOeRiNZVTvPiUicHxg91GiWmv5xj69eXNyXj6nMJqC4zgFzCN
T/neLFVsP4t3/PfjZIWza1R5clE1sUKwAQpXbtqbpRQ6A6BHVQR46lbSqx7VzE8+
eEQH6WASiLHpks67i3GYm9MfP8F8VDWmADLTwkMQeuWzFPjIjMDhf32bP/edGPz8
ylUAP9rg61TlZIHb/OVuqDtmkAqXOTNbh4uHuqHwQ25Qh2YQE+S/IPxwzhjj3JIE
+zpCJqwSKk/BEX2IMAtl4jzDZqnVbRvxkccAM2unNI0eIAwXvKc2+Wk2Zfnjo9PV
cuH32UWxil3SL+NCBBtj5GbM0tnIo8guGD4svydZ4QSSg3MwgOAma9h8j/fdjn/t
OyKi3U8gP4TfoUeGZGKcosNE8vPFbjdmrPhDmO6LN2iWDWIdNCIbYTMdDXsIM3Jl
es4eDsIbnXssb1fmXv5o+qF+cnxwudfP0jsmlZjO+b23uUuxbGi9Wcjdv9QtLoDh
vob63JM4bO3Q9q10ejK5t/XT9zvual17HG54HwWKn3p0tvM+F+05DlSm55DdBYdn
4xSnKN5BoXdIWf7n4YagM16BxbTQycA8jAK/6b1w6CsuUwNY+XKHjMThm00d3Uvh
tMdNNq/XNfrInLn5MeCTJ6uYm7wFRJ8NC7vT8QACtVh4LTOIj+dFw6kQ7LhubatB
CqRPtIpKego1PSwq3kHjrqxsMB8zxSxPYzgcgjLBW8gNGN7uGiXybanJUrBDrTfm
TReOU4pFcmP23XaBdavgW/BIbZCrTdXlc9OvVUAk3rlvyKO1OiJWO+bBdbSohSdf
68zgKsPGtD4jsoNOXutRjv0VqnIDF/zM9Ix8B+t+lGp1QiugmD8kZieJgyWlgN39
Oov5B7AUKwU3x1fQb3uCj6aYTGnxg5bbH2fPj3IT2I7sEHisgyWV9sMKrta0t3OZ
BrB9bZiAsSfghtSmUa2wZrGhMkk8wYZAurAl1JuFXrQEfQmVsgTCdgklogKzw6GO
vd8h5gw/wab0b9zxwu+HreYzvnELPDXFVQA+dj+KqLiYFh5tSxK2Ow+hHUC1PdaN
Cy0rK1M/WGlpZDPiga3VP7IC3s7exv4vqQzOba2bdiKw5UwgLOXDv/6IXOJUHzE7
9fddTkyVY7BIUQqo76fVXRb9kBsIOWVvBaTBx8qOEiY=
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_ATXP_XSPI_SDR_AC_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
loili8mkiHypHjYDKBnAYUUmCtmLxz6OIa0A4ajW2lC+H3pn37UUGVckLsK8tywK
SwB5EhmXPtC0DiNGVo9tZQYOsZhit+uJOME+OUuPTOBzSpOaicV+vc2gabt4sHOd
FHix5h2GmYAYtcaIWB2YPfRHCnhEMDuW7TxfSqxOFlk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 29168     )
dBNBE2hH9M/D3rTzz5mAJKEMN+eYDQBW0+ZuIADYujm6mJudf1BGT+SHj3aQIA0G
PBeKZRK/EEWi7EVzHZ9wiDgFYHmT+ONXRwXJvlAuh16IImWTuMamp8axPNBMGdSz
`pragma protect end_protected
