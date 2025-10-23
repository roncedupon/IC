
`ifndef GUARD_SVT_SPI_FLASH_S25FS_DDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_S25FS_DDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Spansion S25FS family in DDR mode.
 */
class svt_spi_flash_s25fs_ddr_ac_configuration extends svt_configuration;

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
   * Minimum Clock High/Low pulse time for Fast READ Command (DDR QUAD I/O) command
   */ 
  real tCH_Fast_Read_DDR_QUAD_IO_ns[];

  /**
   * Minimum Duration in ns for which Slave Select must be deasserted in
   * between Two Instruction sequence 
   */ 
  real tCS_ns[];

  /**
   * CS# Active Setup time
   */ 
  real tCSS_ns = initial_time;

  /**
   * CS# Active Hold time
   */ 
  real tCSH_ns = initial_time;

  /**
   * Data in Setup time
   */
  real tSU_ns = initial_time;

  /**
   * Data in Hold time
   */
  real tHD_ns = initial_time;

  /**
   * Output Disable time
   */ 
  real tDIS_ns[];

  /**
   * Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_ns[];

  /**
   * Min Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_min_ns[];

  /**
   * Max Output Disable time to drive MOSI/MISO ports to be tri-stated after this time
   */ 
  real output_disable_time_max_ns[];

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

  /** Assign refernce of spi_mem_configuration object */
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
  `svt_vmm_data_new(svt_spi_flash_s25fs_ddr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_s25fs_ddr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_s25fs_ddr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_s25fs_ddr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_s25fs_ddr_ac_configuration.
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
  `vmm_typename(svt_spi_flash_s25fs_ddr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_s25fs_ddr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
FReBvQxK9bzeaOYSj30o6SulepEVAyIvr7xxmeSAEWujP6OM3xmqeksg5z4tnh49
U1VYty3K4R6M0JCFhxn7fzDIF4BeBMsfDrQwVeQT3rxxASN8UD8MgmiPsSAq58cg
NEGAbIKwfOEOlUxNCK9PWrKxF7sSqv8888QfKFpnPL4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 769       )
q9Xkhn7HAoAAEF6iw4LxaU46yFjOEPl6DaCZVn4o794MGm/YzpMevcYLHxildow6
NsSLkmaPysVMwEmVWv/HILChEcK3zkZW5lBLLkn9BCYvPW9xeJ0iZKk60Vx3KgwV
1nmZv3sE5SzmwnSiC6H84FyRj57MicaGtICMBQNvju+t+/rL23uqcXIKgvAgZiNV
jKU9LBl/Gt/RsusNf//aQxooUIUyB2BWx8Ivas1AiJEB1GvU6N6B+Z7DLo0hdxic
lQrvyeEuNj6xdqJQaI6f0K19hMU0VlWQAHJvRd/JkR0z+23H9E6tSoYdVUf6ZhJG
8KKZ319KwwMBSgJVlDsDjpBGeX28+IdwDUVpORH6hFUY+3pYnGtWTFTTFPCVI5ph
z4Odj8lWq5jxvVnF+ezb4oIQlrdSDGysc5CqgBrDZalXkGKJwutky1pbyAEDcf8S
cpWLHSdz7JmjVSfs5RlWjpZ3Xpm86ZcpOPwk8WOkUUtl3xkbc2xcsXjk562djg13
AEnWQ4O0X8m8OPd5ZmVHBJ0irNLTX0+q8XqaKBzAZfkz6JXIxOx1239L8sTBa25f
wGDT24nSFbX2BpvQZ46dprarUqDsx5Qx5fGEjXMAH4006aYv3JsTxYpEp/FxKbb5
jcYtJ1ssKFk+/jEDyVwZQz1+Qgw39ycNBfm/RgSlOnT/ajUf/m/oYg30+N/8H+cA
xtE5b7IOla3s0Ymr2uLIeCbew98LJCuuOi7mHGJQ1VxACmPzLiZc5gjZf3QRgO1S
Bwr03mm5mHjPOT1QvRdbP78K0JBr/FYsU9VFfSjmpe5cLBQRI9maZ4fuM4Nbxj70
TI8ep868NVi2IyUvBdi85S11sGHIy/TT5YBLhRj6CZ9lUUwBCDQUpW/iEi9CfAl5
Q6MWQoFOl6H9CBziOQhc51ZVQRR3EGc9Xgqvhm20TtWNNL3u793ih+WRPn1am+xP
ZMllJRLe/PthBSpkAxIfx3jNjIhnHugG9B7OAMt7wiZ+ks47/8dNudRW+La7cPQB
zKVaMUigvljh5cOoWHEhsw==
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
D20Fof+KON+Oqg5JKFV14NnlGch65FTCaT8l/b8YgeJESkToz+eSHZ8rHABRXzqz
09ZmiKp2YFOspV2j9fIsGAi5UI+BO2laPtOBoAGGAgCxAS8ar5/VNBBvd2WldeZ0
xql4xaTwmin0KnpoiUywlftZtQiaJ+T96XJKrJPqoXc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 21136     )
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
gW/Ea34W9hisUpenEfhAug==
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_S25FS_DDR_AC_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
FvIYg3XcO/VYEBC2VVPKY4nG55eJCjIlaJoeWnGRJQI1rcIpbhpBKuMVMoPyGwIA
5jTM2lZPuqJr+B7lBkCJ7Jwpb7gtXkahVUHG3SP/Ts9I0JgGkZZVkeB9YUEdyu3v
X28ssKEcf5Yn4jTgvxwdfqQLGEsX29sqk0nvoGDED2U=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 21219     )
ellucsHgucqFJeKaNng12c3BecfHX/oDnVYIhQAc3f3L2dWsirimEaPiJELLa/y8
Llb9tXrexyp8ro7anWu56IixnplNNtv/BCVTVTcYvdSSIEeisb2xepKVKF2qm83S
`pragma protect end_protected
