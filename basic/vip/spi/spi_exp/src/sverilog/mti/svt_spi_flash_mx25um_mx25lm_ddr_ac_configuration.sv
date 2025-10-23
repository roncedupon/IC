
`ifndef GUARD_SVT_SPI_FLASH_MX25UM_MX25LM_DDR_AC_CONFIGURATION_SV
`define GUARD_SVT_SPI_FLASH_MX25UM_MX25LM_DDR_AC_CONFIGURATION_SV 

typedef class svt_spi_mem_mode_register_configuration;
// =============================================================================
/**
 * This class specifies AC Timing Characteristics for SPI Flash based 
 * Macronix MX25UM/MX25LM device family in DDR mode.
 */
class svt_spi_flash_mx25um_mx25lm_ddr_ac_configuration extends svt_configuration;

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
  real tCH_OCTAL_Read_ns[];

  /**
   * Minimum Duration in ns for which Slave Select must be deasserted in
   * between Two Instruction sequence 
   */ 
  real tSHSL_ns[];

  /**
   * Data in Setup time
   */
  real tDVCH_ns[];

  /**
   * Data in Hold time
   */
  real tCHDX_ns[];

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
   * Output Disable time
   */ 
  real tSHQZ_ns = initial_time;

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
  `svt_vmm_data_new(svt_spi_flash_mx25um_mx25lm_ddr_ac_configuration)
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
  extern function new(string name = "svt_spi_flash_mx25um_mx25lm_ddr_ac_configuration");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_mx25um_mx25lm_ddr_ac_configuration)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
    `svt_field_object(mode_register_cfg,    `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_flash_mx25um_mx25lm_ddr_ac_configuration)
 
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
   * Allocates a new object of type svt_spi_flash_mx25um_mx25lm_ddr_ac_configuration.
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
  `vmm_typename(svt_spi_flash_mx25um_mx25lm_ddr_ac_configuration)
  `vmm_class_factory(svt_spi_flash_mx25um_mx25lm_ddr_ac_configuration)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ItoqFY0lOOMgwAgp7ZHtwvbSTifklZ9f5nu2HCCgZ5p4ZKf93ahNu7D3zft+jPSS
F+Ec8r5tx5lmidaNBLVRz62999nDNf5hjb8BJ7C3WLwgNaMOoN+CtbousY0HDcDl
zCvZN6BpMb1UJTqjyHkhDy8ip3S7Eo6ZNOYVXebByTk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 801       )
gsPBjOXzmVal2avVWBTG4dUHDpdGiJsgQYzFqnshYcZOeZMwP43V08Y30xTXza8K
y5RKk6nIswN3qb9w/ZvztcCG6NX/nZ2r6CmBJVXfeM2xzoWXAIgW/A2O45TOvgnQ
HZYkThExh4UnNe/QXGHxUtiWlZsNjqV5wGazyoW3Mus9k4j7PMhXAOa6nYe0+EU+
H1ymzVfp9RtCR/+PHJ9FaKR9Sv6xaNBDtvYJXbapfKtfa+lVbBpW/SrT+/OCc0aL
k+U0C9H69Jr0kzzYa2we2qalYoLoPV7xm8bRwfEblc/cDWWtXUdp7cKiyxmKFnn0
l4l3aWRJNrdFeGmktJ1dI1UYgcOg1Cihku1+X2zeou0AXoCVzH+RmV3NMmX7mcEA
7ZO96HuMaAkYW5+vzBJITkS1+0qR7uQ0wmM/WLi0LTB1lJpfivWV6c4lF4tasl9R
Rtli0lGwuFVwYW1EYsJqDANH66QNlJHS+5cKU9p+bcI23e58KOun/gbLaIoed58U
XmB9SOvFPLhXP7o1THk9TDaoOuKQkeGszmjw02g4ZE4gsUxmfWliWB/0Rx9g5VOC
c7Wj0faxSiPg/RrKiA69tx/Vkbcio/Vhclns3bzaqaeU3n5K/yh+ntJi/nKxg9bu
nQFufKl70JhFGylYQGH2Rk95UJP3X+ymzc3nlsIqaIP6AadTu6DljtIVzfHXcLR7
/+H8emHYD2yIqkxBK8XXR7MoLKxVqjzHnB4543Ex+USsY/y+Q/O57kVWlNE/6sUk
QRlxTtPEyE9eWJbn0eXm8AZmQnmdTV/F4Ogdn5qfN/H9OcsBmnedlnncjaHoqxHJ
PI3+5oM9GHiWtpNaeQHBM0xuiGuB0+8ap8O1Y4y3hjgkR+Ll3IDWOWHaQZKs4L+W
kR4K9VaLXJ6kWNmXygkQ4nMqBCn3h20/oiGBPMNC3fVgL+e8cf9jpyg6buWxRmxh
VGDrC3iTockAR4e09E38WgZ2PGopAl/8qRbKiA7y3xbUrg0rjFHIP4b0J3es8GQh
OTZphSCNpARSK+j/Hs4HjUXSkauf6MZAzNs9PVZmEOcqj/4RUipM/W2383UAMH1k
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
N+qC9GX5OdQIx2UQijLmcxfcl9M8gwf9mNDV2ahBZK09t2xXmubbX8OKUyivWdlG
243wXEoKQIJTuaTREpRFHDpksPYSibcvguLzwL9MnqT9aQzgvTOTIFYTjOa7ZMO/
E3y7FvvKEj5ccF1cnJBiZMewK1nV/pzpBWElKd7n9nk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 20669     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_MX25UM_MX25LM_DDR_AC_CONFIGURATION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
M65/9OmmGshn6R/FNzxx9gjVeph2Zc5mnYdjqHzgAzcJ78u8PplXziQ7kv8HqHzc
1sHnQV5YR12C0fXA4hjuQyNNZFOhYOPyQ8nGxT1VBoRGXGMAXuUfRBvsWHgWsPgw
elewZ+VFeQqpHzdYaPyQSoWSSR8A4rKSRQ0kTSbFrPk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 20752     )
8bC6sB3iu+ES4jTifVyyQecEJu+02Adzd8IBsx6vuXDcHoU6ZYp1pUahlIkNcI5E
dbz/Jm6kXDiaxWv/cwgeYhriTdwYWFjNk0ObghKnsrCyDBPMYOjwwgU7/wI8IRbf
`pragma protect end_protected
