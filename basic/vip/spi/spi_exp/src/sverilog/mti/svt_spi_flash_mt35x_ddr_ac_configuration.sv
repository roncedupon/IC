
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
C4/ETHJjcweVC5KCP05FzCV7+cjSwGdp262wBFXgBW+QuYIcSUkTraRvv4KPfk4f
QdIMhlkTYUM+bcL2Piz7BUjLoT+yz7IEwEiPOiAXZYFvu2waLTAiZhMmPULrrtJv
bxwgm56VJn+TdsLi8oYE/8rPR+8MXhtdqtzsN7OaD8A=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 769       )
hWbbWaWQgCTOTWqPIKXyCAJJDVbZFgZ8FNI0xcxprz470rxx7ksshLZG4rdwgsGw
FCI3vFNsRPLjuTVaq+vepq8f849/tdYCOswoJ7olr58gy+uBem/Hs7kwdsgvS2Ej
nN3Opb0t7tzAF5bAA6YPFo49YSEeqSj81drcGTttauDa28d2HmtCkkDwMnhEp8kZ
7XW+Tw9ue+hbsLe3lq/nh2cAQLI7a/QoLatangZyXr2PU2rAj2V5unZ02+0amYUI
oYTmmov9D3XLKu2Efl0dUZ2tEZKsD55NTh2SpAY/qT5WwQxyyd/T6JS+3E7uPGlT
/VisakbY1ykdHvC5GUyo3uDzzDeo67LDu1dATV2x1XM/j2tWXcZ0qRVW+HmhAS55
kr5ggDdm6D+1YPM1YzvS4f4aIL8kclRVtSPb7gN5CRBJxodHYbtVpC9CSw4xrV/1
H/P25VKVS7qFTMc2ZdqYlJ/+MD6G3YQM4vHOYpSazpk6QFSnvnUSyzDfvB2SCoMf
hM+/RH2h1xKK1Cbda7Fw16QzCef6Lv1dAFKD91pg10l7yMkXtUeMw+0mRTRLzFy8
2ZXhBDmqHUsw0yGP2K6vOrT4tmcr3JyccXNbPnZ1aXMXftE1OGBOzq9zPJEbm8pX
viLpnppBXkwsuxq/LkZ8h+4iLodNzimlAlKoSt84fZXPOHb92vlF+6k5QcQebIOp
dik2sOz/1Vm+CZ7hjZ+rAFIynQjaCHQgJJ5i7/2DID5k0x0seVZ0tDJ4fNNa2Q4S
N8rOyRG4Tmn+ZnE+YN+5Sr0TKERhp73sq5QkQlnCndTRvgHfoEHP8+oUVmT9TOnc
IdKBooziGEGLDVvOQetsQVzAcLG4OcUXtmPoAvbAPAy9NGh6p1SnLxb35elz5E3k
5yBVO2shAET2IPNOT+Pjsck+gksoyhKAmPWYSeHUBXBj59fJDPlvRUG1H0O1A49U
xSfVtSCkB+7OnH5KgC1owey3TTFX6HdvHx4BJRRrD3scNqFNZkQDtWk+AukJIGmT
pmeyQ2V5RuvKiyJGIpzWzQ==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
SkZlde/e3nI/KUT9YHRcY8rUOPvmU5q1tYu96EzYXNFxddcg4X+2Kjx/CqNPRFvP
uxofCV4odL530LBVDWEn0CdsTrJGg0s+Y6M+2P/u89/QdgVyn57XskxoQE7vH0na
JnXxzqqNxO3PTlzMe6LIxUeHakyWrzjQQsAH++RunAw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 22662     )
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
F4fZrbBHx3K7H28LpiSxsA==
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_MT35X_DDR_AC_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
fsG3Veo2M8gWBK2mTEy4SkrRhBuBHGcRe1H4bptPQvt5SAjTsz5z6xn8gg+EhCFa
lIguS6rErkViLp+2063v1opkQ2bYz73Wv+8XYyGZLh8a2vKDi3ts+X+K8GOSMWxH
LBfbR5yM0RciLTuLqwEBd5T43zIfX635h2m/31PaCfs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 22745     )
oeYyy4WdCteytRshtfzzI0rfe0SyF1e4+Fendws8M5m/la9rCL+vSQu9huOwUShE
o987f5b0UDFo5Soz2XGM4oGms/uolNp1qWhzMi/IB76BfdVW/W8GcGV3wBZwsBM4
`pragma protect end_protected
