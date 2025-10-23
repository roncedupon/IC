
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Ci91xMw+5fLHWntTeCsEl2FTQY7900BM2a8/J7sP3XLeskrtOzhWjhiAwYghUaN8
NpTLYbQUgQo3ur3t9yfHbMQVo1UsOXhaZUhE654siVm6AJKdfkl3hIUSj/Ibc0JS
knukvnAQIry4KFfiAF3NqnIcRfbr/2PozHXjfOvdL8k=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 769       )
Hw8WdLA+dAyD8H/Fl7ToTtSjPuYSLOqM3rXLsuG/L7rg4+yZwcb84zhRBBFJFgUd
IGeqNlNYfLOq9JD1LoqbI/bYAUSjsKpq482CtzL5HRM+aHFZmio6e56vIGShci7M
ovddftN8FaH/tqKp8fD+MlFhfno4Xz38+MKMXwDaax3dFR/j0FXQahLv+5tSrF8d
3dF6yQxsrVjS3RlPgXxf2REw0tBJN1pRkfhtwddFgEx5AbTJe2u4DdJnf+ZXF2zN
C9M9xuHX77wItGt3Wdz163qW665rmyCk+oxrNH1ildGEvJ4y4LOVhRlWZ0WrS6Th
JBZ9zcUeG+PhLpjaGBsLMcGae9ffYD29xXJ5ets060p3b3vryGyGgrGL4Ymro0OD
uEeVIoBBUIFmRmFjyG2ktXazoVwdoAAx/g9jAFjEPiCYtewVt0UhzlXwiowrbC5p
yQQsv/GaF6PRpwoDLhaLgycuzL/eVaLNhV4DZOHJ98Vm4tEsB+0tAcGiNvZbFo/R
EJzGyRdk77Ywla8C/etzyQkSZbYsn0rh5bAOVYlz9wHrEuT4oJ/zeZzAvI/b3dgL
paM9hj3dxPlA0pRMUZjSEgOv9iL8jPx9LIAZGEBEjv9tngyDl9fR9lvSpwUtRLp9
/3YMzKXIat6NyJkMgUpJtqxWeidlnkkVQQfnbins9pqsWlzmmfGAxqoJWPMXV+uR
MGxcsu5JC0sRNU3oWXaHkk/I8ACcMslZdCPhF5l4UdFxC2iU4/ZfFPXGm39AL925
qU8GkBMSg9rzxEqqQq/4RMqbCHdXLl/2CS73quuCwlhr3eN0A+0eniHd/HXuKdoD
NNIsm0k30xrKeDd5VG6LmRWvFCQ4KcZWSeowDHmp3NDhKFKaOARV+AUVcPG453Fr
pxW10N2Lg/WfXODY239lmG7uBP0bUj/bxiXx/gPxwl+wBLdNbjlhmYdCMqenqPgB
IMfui4dkzEcX2I4TlX2xYbdYQ0f0/Lb9r2q0HH+kjjdQlaB2DpmeTyWsW0f1pZpC
WuhrUUfMsfZyiVcmG5p7qw==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
O36WOeFuMWmI7kwH5lMaqsGkJLuzctNTR3rseHj1eSSClJ+9W6ls5cQAPX1iT+cO
+9BiGbaNR4whocO0SsxG5zv1oytlzYfRZ6A5cDZ5JwHfitPulRoC33udQUZ1aOu9
t5ykUuLzhswlD3Sb/mgENVZOUFrv7J6+sdn5DXWknZo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 24976     )
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
DeT3qR8QvGrqHvj5M01kP9O17HiQiiFEuHn+yfJHne7BZxE6HazcTUWouXqzY4tA
qE5sruKDdaMAE73JCvTs5OJLsuHsA1swXn4SBAhj3eGZG11MqcfRyZ7fsN1ODBlj
DVLiQxfGwG0VNIYFcX0neTvjcgBzzEEeoumZJNHvz5ZXgYFUY7aot2MOfvze7OuU
A5Q5fSWWIeFxcCGKmdkpAjy2kWQSiDATtvthgyhU6LZtwzXH7cPPsvigI32gjQzl
xQF736hKMmpLF3pb1FjWnYwpSks+x4deJ+dK5Iwh1KXHEo0GnVeE3vaxcKz2PPpK
+FmdSAJX170umXuYieCNwtWLJfrKpIeaajbWasu9GynpvRrOZo/TlpqpYjYCMkpj
dZYfsZawMIlbUkmFsnBX9ZiRTQg0/X24K4g3QR3j4Vy0pflBuHBiIzQHHp104BnD
QuVcQFBeNLoNdJ65mlFfYtvjOEVOOu9V2J/GhuzutyJUoK5aybP2Q0yL4+jQ/Vpc
cbtqycK810G979q5VxVl/fhnb5zA9BEembhDi7LVJxxO5cLstulkyUDNuJu+dAd6
fJpLsjhfSQYU7r/tU/V6SuQ6+1HNW/Dx+CA+FWnqbVpBQQP8x3d/M6nA9WIq4xHa
pykcOBX2mgtpude5Bb7WhjYewZEFiFMkNWJ3XCxVK8EBXXibg2+jkiIyhfiMDU4D
3NBxuyp82WDHW4+0eOTTpEpohK8uoy+hQLRSPH4+vBYxNqYJm8BkAS6Mzui/VhxA
pWWOz85U4TAksy20dwYBNl2p3nTbtj7o5QWIY1CiMxNnGCKEn2czaW+qpCN9aef3
/izLiZSP0MWu9OVsff9gLy+k9iGyvdR2yW0ksEXQ22KYlVo6DW5qn/bDPjn4qbDh
aQ9zYslgUDLGrVM2kEyXMm24ueX4zLy3yRz++TmD/0dY/GxGU1u5KZupZDIdgNor
Ga0IuQ9ljN/j4F4AhARbORj2IhSgv3Y/thHsU59vtJmxzqHIpJLWn+FnmUaAunn9
hFZ1INBtHx3dPxqz0wUqTm/81XpVuCNK8NDPY+eiSf56FCq3nzHxCbXNEZateZOb
oUbOlr/oMCZQYSWS+Qk0coMEt043hCm5uKAtxAWtGAv2pYSKhbsOPnszGUeF1hz5
6gnorM7rM/+/nPKNg9dResYpjpIhQvyhGRJE2DWON1NhoxZprvfs+yz2xf8VIFtM
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
csIxTjV70Xz9Nmla90Q+oQ==
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_MT25Q_DDR_AC_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
au6BJHiML/YeyK38dTzNX2aJGfJ4lJBWZ/zZs29WZD6geDywoOOR14xi3Dd8Ooah
VHRNE2EcStLwtav1lIdwmt+cbIub/3KXS2m9/QZjLrHrIt/oWUH21W1zg+ABfNVK
7TLVLQD7hBPwQtWkS88Q6cOdk+cpmAp0T14YBa0lyGo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 25059     )
NvAh4qiszKp6VJNULNlvXbj/YS+N1lI46T6CAQo7ba4RwDHd8LUC7thvxfFRTQh2
44CFD7PnguW/x948yVq5wdCVZ7qwofwYweLOJ9HxbcRYXTdbevqkAV84prDBpnt0
`pragma protect end_protected
