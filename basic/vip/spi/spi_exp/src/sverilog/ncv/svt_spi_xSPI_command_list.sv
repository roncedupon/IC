
`ifndef GUARD_SVT_SPI_xSPI_COMMAND_LIST_SV
`define GUARD_SVT_SPI_xSPI_COMMAND_LIST_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specify the valid commands for selected Part number based upon xSPI specification. <br/>
 * Each Flash Command is stored in a separate class. <br/>
 * It contains required configurations per command basis.
 */
class svt_spi_xSPI_command_list extends svt_configuration;

  // ****************************************************************************
  // Local Data
  // ****************************************************************************
`ifdef SVT_SVDOC_CC
  /** Workaround for SVDOC CC circular references */
  int cfg;
`else
  /** This is a handler to the SPI memory config object */
  svt_spi_mem_configuration cfg;
`endif

  /** This field specifies the Flash Command Name.  */ 
  svt_spi_types::flash_command_enum flash_command = svt_spi_types::NULL_OPCODE;

  /** This field specifies the Flash command category */
  svt_spi_types::flash_command_type_enum flash_command_type;

  /** This field specifies the Flash Command opcode  */ 
  bit [`SVT_SPI_MAX_INST_FRAME_WIDTH-1:0] instruction_byte = `SVT_SPI_MAX_INST_FRAME_WIDTH'h0;

  /** 
   * Used to select the mode of transfer for serial communications. This field does not affect the transfer’s duplex. 
   * There are only two valid combinations: <br/> 
   * 01 - Write <br/> 
   * 10 - Read  <br/> 
   * In Write Mode, Master transmits in all the Phases. Supported phases are Instruction phase, Address phase and Data phase. <br/>
   * In Read Mode, Master transmits till Wait Phase and Slave tranmits the Data Phase. 
   */ 
  bit [1:0] transfer_mode = 2'b01;

  /** 
   * This field specifies the Flash protocol mode supported for #flash_command. <br/>
   * EXTENDED_SPI : Instruction on One Lane, Address and Data on one/two/four for STD/Dual/Quad respectively. <br/>  
   * DUAL SPI     : Instruction, Address and Data on two lanes.  <br/> 
   * QUAD SPI     : Instruction, Address and Data on four lanes. <br/>
   * OCTAL_IO_STR : Instruction, Address and Data on eight lanes in STR Mode. <br/>
   * OCTAL_IO_DTR : Instruction, Address and Data on eight lanes in DTR Mode.
   */ 
  svt_spi_types::flash_protocol_mode_enum flash_protocol_mode [];

  /** This field specifies the number of bits in the instruction phase for each supported #flash_protocol_mode. */ 
  int instruction_frame_size [];

  /** This field specifies the minimum number of bits in the address phase for each supported #flash_protocol_mode. */ 
  int min_address_frame_size [];

  /** This field specifies the maximum number of bits in the address phase for each supported #flash_protocol_mode. */ 
  int max_address_frame_size [];

  /** This field specifies the minimum number of bits in the data phase for each supported #flash_protocol_mode. */ 
  int min_data_frame_size [];

  /** This field specifies the maximum number of bits in the data phase for each supported #flash_protocol_mode. */ 
  int max_data_frame_size [];

  /** 
   * This field specifies default Wait cycles in between Address Phase and Data Phase for each supported #flash_protocol_mode. <br/>
   * Specified as number of SPI clock cycles. For some commands, wait_cycle_count default value is determined based on command type, <br/>
   * protocol mode as per datasheet of selected device. User configurable value is obtained from cfg register.  <br/>
   * Wait phase starts from the next posedge after address phase.  
   */ 
  int wait_cycle_count [];

  /** 
   * This field specifies default clock cycles in between wait Phase and Data Phase for each supported #flash_protocol_mode. <br/>
   * Specified as number of SPI clock cycles. For some commands, pre_data_cycle_count default value is determined based on command type, <br/>
   * protocol mode as per datasheet of selected device.
   */ 
  int pre_data_cycle_count [];

  /** 
   * This field specifies the number of lanes over which Instruction phase bits are to be transmitted for each supported #flash_protocol_mode. <br/>
   * This can take values 1,2,4,8.... <br/>
   * It should be integral multiple of #instruction_frame_size <br/>
   */ 
  int instruction_lane_count [];

  /**   
   * This field specifies the number of lanes over which Address phase bits are to be transmitted for each supported #flash_protocol_mode. <br/>
   * This can take values 1,2,4,8.... <br/>
   * It should be integral multiple of #address_frame_size <br/>
   */  
  int address_lane_count [];

  /** This field specifies the number of lanes over which bits are valid during Wait/dummy cycle phase for each supported #flash_protocol_mode. */ 
  int wait_cycle_lane_count [];

  /** This field specifies the number of lanes over which bits are valid during Pre Data cycle phase for each supported #flash_protocol_mode. */
  int pre_data_cycle_lane_count [];

  /**   
   * This field specifies the number of lanes over which Data phase bits are to be transmitted for each supported #flash_protocol_mode.. <br/>
   * This can take values 1,2,4,8.... <br/>
   */ 
  int data_lane_count [];

  /** 
   * This field specifies whether configurable Wait cycles is applicable for each supported #flash_protocol_mode. <br/>
   * This is to be initialized to 1 if supported. The dummy cycle values are available in <br/>
   * svt_spi_mem_mode_register_configuration::wait_cycle_code_list and svt_spi_mem_mode_register_configuration::wait_cycle_count_list .
   */ 
  bit is_valid_configurable_wait_cycle_count [];
 
  //----------------------------------------------------------------------------
  // Type Definitions
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  //-------------------------------------------------------------------------------------------------------------------------------
  /** This method calculates and sets the transaction object fields based on selected flash_command and protcol mode.   */
  extern virtual function void set_command_parameters();

  //-------------------------------------------------------------------------------------------------------------------------------
  /** This method return the bit size of instruction code  */ 
  extern virtual function int get_xSPI_instruction_frame_size(svt_spi_types::flash_command_enum flash_command,svt_spi_types::flash_protocol_mode_enum flash_protocol_mode = svt_spi_types::EXTENDED_SPI);

  //----------------------------------------------------------------------------
  /**
   * This method return the valid upper limit of Data byte count for mentioned flash command. 
   * The upper limit is controlled by macro SVT_SPI_MAX_DATA_TRANSFER/SVT_SPI_MAX_PROGRAM_BYTES_TRANSFER etc.
   */ 
  extern virtual function int get_xSPI_max_data_frame_size(svt_spi_types::flash_command_enum flash_command,svt_spi_types::flash_protocol_mode_enum flash_protocol_mode = svt_spi_types::EXTENDED_SPI);

  //------------------------------------------------------------------------------------------------------------------------------------
  /** This method returns the valid instruction lane count for the mentioned flash command opcode & flash protocol mode.   */ 
  extern virtual function int get_xSPI_instruction_lane_count(svt_spi_types::flash_protocol_mode_enum flash_protocol_mode);

  //------------------------------------------------------------------------------------------------------------------------------------
  /** This method returns the valid address lane count for the mentioned flash command opcode & flash protocol mode.  */ 
  extern virtual function int get_xSPI_address_lane_count(svt_spi_types::flash_command_enum flash_command,svt_spi_types::flash_protocol_mode_enum flash_protocol_mode);

  //------------------------------------------------------------------------------------------------------------------------------------
  /** This method returns the valid wait phase lane count for the mentioned flash command opcode & flash protocol mode. */ 
  extern virtual function int get_xSPI_wait_cycle_lane_count(svt_spi_types::flash_command_enum flash_command);

  //------------------------------------------------------------------------------------------------------------------------------------
  /** This method returns the valid pre data phase lane count for the mentioned flash command opcode & flash protocol mode. */
  extern virtual function int get_xSPI_pre_data_cycle_lane_count(svt_spi_types::flash_command_enum flash_command,svt_spi_types::flash_protocol_mode_enum flash_protocol_mode);

  //------------------------------------------------------------------------------------------------------------------------------------
  /** This method returns the valid data lane count for the mentioned flash command opcode & flash protocol mode. */ 
  extern virtual function int get_xSPI_data_lane_count(svt_spi_types::flash_command_enum flash_command,svt_spi_types::flash_protocol_mode_enum flash_protocol_mode);

  //------------------------------------------------------------------------------------------------------------------------------------
  /** This method returns the valid Flash Command Type for the mentioned flash command opcode. */ 
  extern virtual function svt_spi_types::flash_command_type_enum get_xSPI_flash_command_type(svt_spi_types::flash_command_enum flash_command);

  //------------------------------------------------------------------------------------------------------------------------------------
  /** This method returns the valid Transfer Mode for the mentioned flash command opcode. */ 
  extern virtual function bit[1:0] get_xSPI_transfer_mode(svt_spi_types::flash_command_enum flash_command);

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
  `svt_vmm_data_new(svt_spi_xSPI_command_list)
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
  extern function new(string name = "svt_spi_xSPI_command_list");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_xSPI_command_list)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_xSPI_command_list)
 
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
   * Allocates a new object of type svt_spi_xSPI_command_list.
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
  //extern virtual function int get_clk_parameter_index(svt_spi_types::flash_command_enum flash_command);
  

  // ---------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `vmm_typename(svt_spi_xSPI_command_list)
  `vmm_class_factory(svt_spi_xSPI_command_list)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
4C4M/RBw2TEPu1S8Sn8/xAavLgDWh626DbgjIJcpZoc4p+XlrJYrPNaBR3Qm/Aos
NHM+G7kjrZrSrepEszaRGqOONnBhrvpz+6UE4RYiAKN7mtTkRoIOOZhrdFYUvrFl
sNpLS2dM8yvu66+hUKnLIinJbJt3HY/fQdpY/Ho9t9JSh2fbyl16RA==
//pragma protect end_key_block
//pragma protect digest_block
5ZMgET9JAbXqmo3Hdp/gUQ9Ppos=
//pragma protect end_digest_block
//pragma protect data_block
6LV2P+k8gWMRczU200Xa9RBmI9RQdcptIRHabENTiygnhb9xoYRVXhv83Jm8zya2
6L5QOjsuY1r7ZnaCJT89IuNdEbaTWNHAwLTrNscymznW/59xNIHOWE7+KTqWnKhX
0JRmYrNdAA1SCVk6ix8GqvkObeSqCCACuSUGCQVA719R1K48vvbeqZ8ADpLr/TtU
HXXjYJZwKTKLQJnA3cNx0HdbmXnwUNIiyj082qr5N3d3CGl2nSAqkf/X0gghz+bL
INn4a8mzE4SfIQJoE8st1kr428Szmdlw1NInzY7gu6L7D+El+fDYubhbXLymT3G7
ZwpXoe0HV1ou9SSJmMftMVkUW/8gP9WhM9OTkATWjbu8s2o0eN3LCgvGTe2PEKtA
QcFI7HYlYjs2IOKyK3DIgdA+RQgFLT2nX/ZIpluzsbUyyPcvc4LJg9TUzdN/UtG6
c5JFPVZIklYwRXAibhv1LU3ynvLkui+xdVEYjKofdoOkY05Y9U3pvGfV2Mh4VEGc
uEYRlNCh3Ajy+j8lQpH+KPZnUOP3Qhn4bCYOwOOd06hh6P4YrfOd6rcvGDOexlUn
oDi6aEOZKNtFn2gucPIlOn1pSfmvKlrs1OyIaITYYwaZ4t4EnNUSBv/o6WFR6D2q
BB5nIsX/dzBR8DD3YCMDPdT1Tr0rLZ0jiiQPpMUqOWsIORuFg2akmmv+SCtlGmtb
4jp1+GhAoJTZFB2PAnfGvyHQApvNFwCR2UFAhNn2G20B7oXkl+D0GPaPNkWSGXiS
3HNPaUe8lqR32j9K4LBb6feAJU2Lmxk81XGaTw8ARG8z/uN2Jnyjn+Wbow8sCkcM
aN/gCd4+LK+99CneY2/P6hk9OPLUyqIrDXcae07tCxNhCLg3vmGUxHnsHfNSdj2R
f4AL33gIhCQnXNLOSbOBHlWfRWniWoNqAj3cJzn9bga53jah6BHAxnRDxEmuts13
uvwoBkrUXCo32DGkeyt9dniWchZkbkYoPU7VmLKbPn/dXXCG1e8tA0xnd6BUmaQc

//pragma protect end_data_block
//pragma protect digest_block
q/G9ZRyn4F5BQiU3EwLcieZU1TM=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
gpDJboyM5yHrmpU3nz3YF7IiJvtwj0ihwQNoi7mklyUff2gRbb1261bZqPvodAMX
JrmU56EPzR5tl2+q0w6PoVgWqFQnXcDHkQimwaEHfuRCUcr77LpxtfAPo4O7ZYaQ
bxNJVBiymBawVLDxAjVQnpZWk9F84DH59gq/RrAhX4X8VbGrzOvg6w==
//pragma protect end_key_block
//pragma protect digest_block
wHYcEsyIsAK5LDAkO2g4NecmyTI=
//pragma protect end_digest_block
//pragma protect data_block
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
0P4LDNnb/xj8+UBq8eHaa8pN8/V8oQGoRgFsG/0UePXB9HjL6gP0pRrWEaNgSgdh
bJL44/EeZlaXyR5RDSHJcCbr9fmesUlyr0Tt670iXqkzUz5xShI7P/LeQwn/3FZy
vSS3k7Fqb6qfsJd047xPeVYDj8xqcDaf5URY0iPRDsWK54ZsbSTmeqvO+4Y17e+1
r9SNkoUvB2ebGy/tMt0ONRYkJ3qmsD/QRaza6H4VZCkbdP0OQ9UeI7U+FsPEXc0F
WIdm+89syy64ZRXE7pm/CAGQy6UwFKUwBeBVR+ZmxUdSIBqxGNcGmwjYOwrMtP3j
ZqeOdideNIe99Lo9kqCMm8IY28vbPcxnBgszfnZqUevo0zUQduUwIzFNAHTBxa8a
lGnsPlHAV+yNvOe8lAr0X0Nly8dLI5/jeZGruvXve/UwyWnz7mVe7Haujv4hbf26
2gzs6O/WSvzWCLgUTmB8wNJXjspc1+n9JrDj5WDMFqQKwWrXGHCgeZsqRNmWJjcW
8P174ajFaaYsZ535A4+GGxpxb3Qaf/HSCBpPLRIBbH5UVJiHtX7BbM7z3WxpQShV
KfYJLCW56ShLf7e0UsEQB/+7+nvRoVTYaul3u/xxFcZn+MIyN9Wx2tl58Uba6eQ5
lsfT1nsLxX2TiguCIbm3w7esncKwDxr68srSrIacJKCgc31RGddqr4GAzg0vqWwT
Mdpi32U1/XLUB/geLJehrlTQkw76uM/yI8wIbS1tqFy9Aq56j7peMBMMYdQ7DWD7
bHZwnlNCua+Z1spf3ESyn/IYN8957c5BIz/x7F4MSaRJgQ/sQ9bVIPdWwhKBfkOK
x+5PKvs9804L/vNVbNLufjUQW+O0AG7iahVcj/QUTI6l3vPBoHO7FgJ2ex0kXzgV
iCPHcaYkOZArgDp5Z4KU1hdC8/Zlg09BuHb8ODk+/a0MrJKRQ+QSiLVbuXOq0pvk
1hfNpUlo76N3f6n+esLTRszGkntsm3bForHhzYWA0X+NceEo7rDV9+aBNoItOS8x
gn9BigX8eEHJmRTtSpzwqv46VSHaqLICt+o5i9QgHkHxpZVm8IjQUf3+ucMXEMvW
vMceuhGOeml0irNuVqy3zXiVNzVGs/16QlE6y8F3l6ITwr9jtDkz3+yyRz1bLRCr
Qz60sFwolEAHbdxH2SAtfdodBFTP8RbYc94RtMlTHjVCzH3tQ1tvVGhk+UMbRNkN
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

//pragma protect end_data_block
//pragma protect digest_block
5Xl+++DRcccMLE5Lp1Fcd0lVjvI=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_xSPI_COMMAND_LIST_SV
