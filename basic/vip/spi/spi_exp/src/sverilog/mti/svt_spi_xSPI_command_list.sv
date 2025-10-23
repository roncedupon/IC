
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
WwYkxiLlnIAFYvDPoHQc/9fw7ag48V94juvE2RQwRTDGAEvh9n4blgPToXa3RCEI
I3l+Q5UX9TXHXHb8cVnGFooziOvV4YIfXNEGYgqsx/ltF0RwKklZgC+F8zZ5HydN
vOpna54UH2VJcnFawN7qAMruQIBT7pEj8fUUfoAdkZU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 594       )
FvA4ZtOyQDqWOXYR+VpfHfwetI2chqGo0h6rFwR681QnntgCfwbioBOyltTrAC3U
hOeJ79snL+gldZIketZNL/YxzF8booNsMSY9tzPII28S1RQlReGFs4fwQGKhEziu
VKFvSABD9QtNkkIbL3dQsNAnfTMZdFlBCUtYTLr9slj3puesVVd+8gwLb0mbLU9D
WbecUQxv2om9VWlvZ2Mq4J1L4MWXvcs/MXZURfWIqrbY245x1fO2FS9Ssg0J12at
2tUKQYRSmGAiVxjqZbF2yISTgqtteSKLOqSh0TrdBvE7LP0VAnnFfPtf0rI2es8L
AT1T4G0ZztPZQrsBC3fzkDioBOfLFTJFCAERndEVyYDLs4u77/e6yVzvdTpmqgrf
T3pcRcOxUdERR2dSex4eaPRj/6KEOwcvP0d2kIX23L+7+Y7B9yiPD5VqC0wq6Gjw
WI+L3hhOzpdEpvLYYrexaDX7WICff0U5mDL1FRc59mkHE4TCSFZAF/flKCEEG+B2
X+Y0JkGfIWoonFiEq2SzQD4GtBkx5fYypfqvtV7TG1QYoFs93dl2VUyXpekdHvN2
iXC2CcfHYBC6+UeuW0LRW6SKVFM5Rddu/hUZs+atHucNjS2oI+14A9fctDgNeJbW
KFnKCCVB+pX3Fryy1ak09wX5KXb24OTK9ZeyXjUqvXYl8Vq81Jwznaw6PIa9P7s4
L8vRc1WFvuKtxCbirGoTyd4wrbJUHZbAWOStef/qGlFzHUWShqRoNiPHY+buFH4i
feZH9DCq5+YqmaHTPrnFp/Uu0zKINX/3sTU26d4IJdI=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JhKE8QRE1eK5dD6IPra/pbe8MWrUM3VVVvNfcCgwH3/mpFRP2HczTOs2GjDHk94n
FmzuN/N758SqOTT9tVlxjOqgWZtWzKJ/yG0gtBePbnmWgrmfMgoztBxbLpbP3L7M
tQINwzbWdf3t+69lc4sk5ADacjBuru/zD6RGw9f/Yhw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 44105     )
eM0OQCMbwC9WTT3cyxvsDUzPWxDCE9zyIFL3pSkQCd9/+/uRVjsCuDaH6C64NqcW
GaGTtkZ0X+SbUe0Qrn4gFh2cu6fAV1pmlebx/3o+dXEWuZ4hSoHwQzyWw1o9Qn8z
2Xo812cRz2GOP7WRJ3YUdoqh1ypUlvLIWz4eBc561DnhSY3Ebpou0Vy8dGxL/87K
GjSImOAyEPkn58uDU3WnWCWPyZxwl3CEwnihtDe25bPrhE4bpLMYqvuMHJgdFjaE
MkrZ5hOij9CAdh8hiz+A0wg7RCUVzf1BrtBHnJFe4IW84NyocKmSW1xYwaGHa96t
IfIySeqn33EjG9RONdPImkkLlt189U4PEYQwMB9HWqOGz3JyBEdocxTWK3PFt/sK
DXr/C1t/XoKtKAwl4+939/PJ1Aa4okIQX1nPaWjP6vR85T7wvVQTeIutCwc9r3Fn
LKLmwlnKZGMvbVe9BaCM9bvOgkV8TyAywJR0tJw+QVcyt8J9PfCZPyiWwVTUtabg
1h5LfGpb+3YWcqu9ZtVpI91ZrWha0DbvZBNb+MA74uwpfJFIRiNm0b64cfdNXGiw
jEm2c0hsd7kMDVU9/4J6rw/Zw51dnK8qTKvzD1TyGq44NKWfWQ1ywTgDsuqG9+dy
I9vQO3w8mX5vr2gtg3FLKnH53y2eGXZoZTGQsaL3/xAn1IDGzJG5lhlE26d7B2QV
TQJzd4C/W8a+P4sBOCRG/eIhM2bMBtz3cyTFv9Gsn7svDP0nZIBRg739wljXUHJp
++XgpW226BkD9LQ8YuJEw6PCNFeTeCQ7TJBJp1W+1vZr4w8ERaLZfM4jcPBzvh+G
XeyG3J5nTR3Yr/42GbFEb4jshvEN98NPZSVMJrvWSHqVp+4Ap3+AdWQ/rxcxga6+
p4xqpdH9vp1bp7ak/J0Uwwn6XDeBx9d/CqiLdtuGnEkv6hzCYrYvh6O3W6m8rDJ3
PZcoBVNvRuipJvHZtN/13OObcxsu7h0wSov1py0oMmmWlT6eAeyV6GKm82kGnUGE
ONEJQhzKuWsfmIw3BoGlRSQYA/ZGXDPqM1MtzkVFd1NRXD4/24wM/eM119k/e8xc
Xms8za072ASuOctsmnggG3BYQEif3lZP/i8ioGcXbHJ4JKUxPR5Ep7V113DH+67m
dELyKwoPfuUIsZczeMKMjsahl86mAc4zcAsWx7MkTGZo3MBIhuxZEbw+BtG37wFO
83Cx7aWbZXCeG+i2vk18zpZ5uA9qIV/a2oZs1wesbw4IFKm31t9FhSyR5y11sSs8
DZi/sUqv5obGoDYRQtWSmbgsx4yPxWHbACC45QJPL7PGm7N+cQiO6obsh3m/DvJL
sPZjRyzg81jExwJpkp8iyXvvyMYXrTAE4wVy5mLsyhJ9ryh8rITK4fZ4BG2V+ck+
/TkrUW78UZCnA1EpQxi0khMRNl9eV4sgm0BnLzLA7ItQoc9/vu0NUEtOTeOnacRR
HQxWhX6NMfTstnsQAFhplno94H3qPlqRo3n/jm5YvxmpZJXw4d9hQaTO9VL0cY1k
yazOVEqoltZbfGq8iJriiB82Z35CS/jvmn+uQGy5W1jGiF3cGIH/96CPhEtFEbzh
3X+CrWgpDCffxj4pwGUG1GT4NokU1CtVFEzAXVEnPDDpZ1SZnKRP78k0XkiVDxgT
gI17MivmAxpr0tS6Laziq+cy8tNZhtyIJNJkOoUurY2SPs3Wd2fHesP5C6qj5Q4j
+NCGzETDNxVBvisQBAnbOYVg651CVDGRri2Yz5hVfHoDE6Uj5DoPPKt4D3N2F/9r
kMt6rgSwDuSTQHXb4ufUvph+fe3B0RZISQ2P5LS6H6tHdt9aNz53kvOLAqDvczSz
An7QV6csWtZdOo8xaPEhk+PJ/yEffcQiWx/uY+Y13pckh8tmIZ53PM7lLymTPffa
HShjxDLvAXYCJHAb/cR/UhZ7e4OU30mWF8Rv6Vt+Pj3HpHnFriP2m2voQyVD+nUX
JiZYeiDGcW71/4iVuE5phj2d5sGg59CCDfm+83qE6sy1u46SfVFGutC2KKhyPa9G
KBHDdE+N9/Evirza2OZzVBL4UL6ZwETyeXFm6r1cOU35YOM2Qp3yxtSlkHWaiJMT
+jRWxdRlwoGBN1sjUAt8KcEyUHzwo5WyNWEydHwitbT95cgJEDtHzmORabOWhAco
39SyCbrK2Tmsx0123g5J1eAq9qqmi3VwyREDIxiB88giUG8Nnk41RR5hbdktLONm
N0Fq8d9uZ/zTFyEBAigLsbrf/JrjrxplAkv9qAS0hRkldUgtSnQuM5APe9HW5l12
4Mo9YhpRoySoM3ZPenmRiKFFwgvnM3FvOzhTkccmZvE82Hm/9ItOkecHyw91Wbig
U2Iq6IFzVc+kZOS1M/UNO4i9DVLRVvRwyNBIxZ6Urlybrez27k0iwndSv1nKNslm
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
yliGgubZ8eYoWgxdGRsi5EO8yY2bRg20NRy+v+rFgF81uyinYyUsmZ5PlOSsjIUm
QJjDWLZRKhEt0Vr8oCNngKArJy2FQQJesb+Ia3N6KXaawSIiQxOPpDSOm2P7F6pp
NAI0IGWgEBJpgZ3Yd++ltYNUn8u6hNerVr2kepcSreO/q8ph6OM2+BQmyaSVLTyc
BmnJE5mYBEYAMjSpqz5Ax9bJp5Aviy6Oarkp5tMN1WWhlnGNr5f3fQ2IlC4VHcSl
ePx9UeBnt+61et/Jdjqu4xe5SIchsVbEuI2D+6QnngqcDT27kqI9oIP+tY968s9E
LZzZBjXo5h5OPxI405B8tHkxjOK19NcJVI1KB+qC0oosptPpPke/S7xCpLsr/weh
IpYS4WKK9AG97cSs4awRmjoT1eKsQ2plvTQwJE1/atPaar307w4k3W5/fmg4wAJb
BBaHzuP5vz2LKdQj+76IoMALtz13NloWxHU3kdvRblQJn4teA/tm3GHfXjnHKzpa
KMK1ruTzArL7ja3591Q74qbbTzxw6Tkqgvkug0zDhOAqATkMfamjdBKE5D5txoQE
E2thQb5sAPv1EdCvbEVi7Ku+zhjwSm54/wOY7u5/WJS/N+Np9xc7MJgfTXyFtSHG
Bl3iqgCDrKJvdMyi3w5RKZ7urwQNXnqNlbmVmekSX+XU3TEbhJrqf+sKSJzsgny3
u9OodXRjPL9/mWjVu7awdeUhtHgrjGCxTeAoWEP8TFBriDtSU2fTOy3+ivcupDwm
FQ6+znyAjZBii/WjkOTRCnHn3LU7kNQTmRlUEqPstfCGRT+VbDSsHIzcZacW6MJM
nizOW+pQxtoK974ocXiI+5U3AfjxpE43Ej01xzn4iKhm5F/7Wr3rg6ye50ktEXOr
K/f+Ze29AFdhWcIvWTmcHscrMR9wgW9TIgkRmdH71HcwVgplpCSqt53q5mb9c0KO
PbZdFQVyROMDCxV9k/136kTIOeucMs8yGD8diqpN8uzeu692BgqTppqJKKdHlYR9
bImK/L+5sfMMCyA3P+v1HIlG8pg0nFeHqBp+d0FHjaLTFV3yVFG+KfpcUW43ZnAS
C4pqpA1gqakh6W/3rHS+VTw75S7PEJ7i1M1PD/U7bHyoOvEif6CffAKLjKkVOstK
T1sUa/+fnVB+bc7gZSJT2tYW4Nj5fHcQLs+qvQOrZbYswoBCL3fx2cNInOrdBkO8
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_xSPI_COMMAND_LIST_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
D8jC+tFs+G/baf1oZwJ9ExzdyKeza86FjYHv1xGxSqlFfD1m1rmERnnbgTMctf6U
mBe7TngyM4rotDmvWkEZr4W6wrfMXOH+9QkZ0aqviB3WmU3zBc9YJ38HMAa46Pa8
EGGWQApn6OScfrRP3puFq7EZoXAmHUDDUUIguZgrgHo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 44188     )
fEUVBE6QqlAEHhlKWalgmKuf73S/bnVLDVsGz2Y82Bpx9hlk+OMf276fwA70QXqr
w/SRMRryB/ONCxmDf1i0WHWSPJteUIkEDgvtTngXAcPKK6xXjbVAOUsHw36ewptF
`pragma protect end_protected
