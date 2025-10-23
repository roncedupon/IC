`ifndef GUARD_SVT_SPI_xSPI_PROFILE_2_0_COMMAND_LIST_SV
`define GUARD_SVT_SPI_xSPI_PROFILE_2_0_COMMAND_LIST_SV 

typedef class svt_spi_mem_mode_register_configuration;

// =============================================================================
/**
 * This class specify the valid commands for selected Part number based upon xSPI <br/>
 * profile 2.0 specification. Each Flash Command is stored in a separate class. <br/>
 * It contains required configurations per command basis.
 */
class svt_spi_xSPI_profile_2_0_command_list extends svt_configuration;

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

  /** This field specifies the Address frame in Additional command modifier */
  bit [`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] address_frame = `SVT_SPI_MAX_ADDR_FRAME_WIDTH'h0;

  /** This field specifies the data_frame for xSPI profile 2.0 command function.  */
  bit[`SVT_SPI_DATA_WIDTH-1:0] data_frame;

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
   * OCTAL_IO_DTR : Instruction, Address and Data on eight lanes in DTR Mode.
   * Currently xSPI profile 2.0 supports only OCTAL_IO_DTR
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

  /**   
   * This field specifies the number of lanes over which Data phase bits are to be transmitted for each supported #flash_protocol_mode.. <br/>
   * This can take values 1,2,4,8.... <br/>
   */ 
  int data_lane_count [];

  /** 
   * This field specifies whether the command's address frame is configurable or fixed.
   * When it is set to 0, the address frame is fixed and available in #address_frame. <br/>
   * When it is set to 1, the address frame is configurable in svt_spi_transaction class. <br/>
   */ 
  bit is_valid_configurable_address_frame = 1'b0;

  /** 
   * This field specifies whether the command's data frame is configurable or fixed. 
   * when it is set to 0, the data frame is fixed and available in #data_frame. <br/>
   * When it is set to 1, the data frame is configurable in svt_spi_transaction class. <br/>
   */ 
  bit is_valid_configurable_data_frame = 1'b0;

  /** 
   * This field specifies whether configurable Wait cycles is applicable for each supported #flash_protocol_mode. <br/>
   * This is to be initialized to 1 if supported. The dummy cycle values are available in <br/>
   * svt_spi_mem_mode_register_configuration::xSPI_prfl_2_0_wait_cycle_code_list and svt_spi_mem_mode_register_configuration::xSPI_prfl_2_0_wait_cycle_count_list .
   */ 
  bit is_valid_configurable_wait_cycle_count[];

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
  extern virtual function int get_xSPI_profile_2_0_instruction_frame_size(svt_spi_types::flash_command_enum flash_command,svt_spi_types::flash_protocol_mode_enum flash_protocol_mode = svt_spi_types::OCTAL_IO_DTR);

  //-------------------------------------------------------------------------------------------------------------------------------
  /** This method return the minimum address frame size  */ 
  extern virtual function int get_xSPI_profile_2_0_min_address_frame_size(svt_spi_types::flash_command_enum flash_command,svt_spi_types::flash_protocol_mode_enum flash_protocol_mode = svt_spi_types::OCTAL_IO_DTR);

  //-------------------------------------------------------------------------------------------------------------------------------
  /** This method return the maximum address frame size  */ 
  extern virtual function int get_xSPI_profile_2_0_max_address_frame_size(svt_spi_types::flash_command_enum flash_command,svt_spi_types::flash_protocol_mode_enum flash_protocol_mode = svt_spi_types::OCTAL_IO_DTR);

  //-------------------------------------------------------------------------------------------------------------------------------
  /** This method return the minimum data frame size  */ 
  extern virtual function int get_xSPI_profile_2_0_min_data_frame_size(svt_spi_types::flash_command_enum flash_command,svt_spi_types::flash_protocol_mode_enum flash_protocol_mode = svt_spi_types::OCTAL_IO_DTR);

  //----------------------------------------------------------------------------
  /**
   * This method return the valid upper limit of Data byte count for mentioned flash command. 
   * The upper limit is controlled by macro SVT_SPI_MAX_DATA_TRANSFER/SVT_SPI_MAX_PROGRAM_BYTES_TRANSFER etc.
   */ 
  extern virtual function int get_xSPI_profile_2_0_max_data_frame_size(svt_spi_types::flash_command_enum flash_command,svt_spi_types::flash_protocol_mode_enum flash_protocol_mode = svt_spi_types::OCTAL_IO_DTR);

  //------------------------------------------------------------------------------------------------------------------------------------
  /** This method returns the valid instruction lane count for the mentioned flash command opcode & flash protocol mode.   */ 
  extern virtual function int get_xSPI_profile_2_0_instruction_lane_count(svt_spi_types::flash_protocol_mode_enum flash_protocol_mode);

  //------------------------------------------------------------------------------------------------------------------------------------
  /** This method returns the valid address lane count for the mentioned flash command opcode & flash protocol mode.  */ 
  extern virtual function int get_xSPI_profile_2_0_address_lane_count(svt_spi_types::flash_command_enum flash_command,svt_spi_types::flash_protocol_mode_enum flash_protocol_mode);

  //------------------------------------------------------------------------------------------------------------------------------------
  /** This method returns the valid wait phase lane count for the mentioned flash command opcode & flash protocol mode. */ 
  extern virtual function int get_xSPI_profile_2_0_wait_cycle_lane_count(svt_spi_types::flash_command_enum flash_command);

  //------------------------------------------------------------------------------------------------------------------------------------
  /** This method returns the valid data lane count for the mentioned flash command opcode & flash protocol mode. */ 
  extern virtual function int get_xSPI_profile_2_0_data_lane_count(svt_spi_types::flash_command_enum flash_command,svt_spi_types::flash_protocol_mode_enum flash_protocol_mode);

  //------------------------------------------------------------------------------------------------------------------------------------
  /** This method returns the valid Flash Command Type for the mentioned flash command opcode. */ 
  extern virtual function svt_spi_types::flash_command_type_enum get_xSPI_profile_2_0_flash_command_type(svt_spi_types::flash_command_enum flash_command);

  //------------------------------------------------------------------------------------------------------------------------------------
  /** This method returns the valid Transfer Mode for the mentioned flash command opcode. */ 
  extern virtual function bit[1:0] get_xSPI_profile_2_0_transfer_mode(svt_spi_types::flash_command_enum flash_command);

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
  `svt_vmm_data_new(svt_spi_xSPI_profile_2_0_command_list)
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
  extern function new(string name = "svt_spi_xSPI_profile_2_0_command_list");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_xSPI_profile_2_0_command_list)
    `svt_field_object(cfg,                  `SVT_ALL_ON|`SVT_REFERENCE|`SVT_NOPACK|`SVT_NOCOMPARE, `SVT_HOW_REFCOPY)
  `svt_data_member_end(svt_spi_xSPI_profile_2_0_command_list)
 
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
   * Allocates a new object of type svt_spi_xSPI_profile_2_0_command_list.
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
  `vmm_typename(svt_spi_xSPI_profile_2_0_command_list)
  `vmm_class_factory(svt_spi_xSPI_profile_2_0_command_list)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
C+XHG9BKlDuigvzgDeVQsFiU98ru/1vyfUK8gXJe6vnbDfKTFGBRjSNhIduwAt/r
Necoyruw/X0herNKLtKEsvljh34dQ9k2ZtCUCK58vWCB9I/xundsGi+hBx/xOQfX
i938b1lhUKnUw+Jfy1b0qUhgZ8IfQVAF7+WXFVCHZSYYlUST5ldvRA==
//pragma protect end_key_block
//pragma protect digest_block
48yK/5+Llq2F3rR/NYn51etpzf8=
//pragma protect end_digest_block
//pragma protect data_block
RiwQIktABrgCztbVl6AKwFSFig4RhtWMbr7HSdqtNSaymLFk8KrH8iK3JBN9Wr8p
yFmcUIlFAKU0l7UvgxA/uxc97exs6F3ILmbpzUnwKecEcmR3UZBgwDok7UIn7w2R
pXPE6Eygcdwrv1H6yG3hYQx1mVPpT6SL6xR3+lzAgjAQo9kW2UJ2nUakVPmbjS75
ocMk4H1QJOOBuQ9n+XPDIJP7zc7P+XRudm6IEZGT9keH70qpwNWAWe+a35Lmajhu
ihcWYYp0sJqDHGJsBoON4LhCBdyPTJz10qZKM4E8MVTqvB/ThrTsG9YxqJxKOj9E
2Q/rKer+ClYh+utlme5clPjdMAGpZZ26ce3X9CQgjvUKAV9GzWbS4NIIwADQucD2
jWRN9OC/9RrsI8adFnEk8f02a95yUEx48L8UCZXcGBE5+sol92iRaiFGY2YmfwI7
tInaS7APiqFc36ElaM67iFLf8xp5RuvdX/LemHG0NO6/wu5egvjud06U5x28qONw
9hCUVFS3r4/XHfVNNO7npYSo0o2cFPtOrtFWwSDvIlDuJ7mTgIpcxxeSPihhv8gV
SwRANBnOATAQphbbBbX5Z0MNUmTBkDs49AUXJV2OJeJV4wciEfmUZxKwZkhcYcEu
wNEx++32KBqj0eLDoFNVsLon7CaijkOpRHKbh3mT8rZPg25inqYshF45nOflcxBK
vAdmCnNm+B4p7osuGU32J5Pqgca/ySh2G6xEBTUeM4cQ9qVk5wTPPcOeB8jzdV1Y
SVEZdZwTXrNFyOpynI/Xd2Jbi5bonzm3Q0pHPkrDMEDm5GE0O3q4Cu+m+HKtOml/
TQQxDrIsj2fIC33bmSekyDLxPVBagkgtaL2T5FCoYOuy75TPcU/Nmcirw5+3xJDS
K/LKD2Cy8YTAHNGUawE3WZveiUZYNZ22bg3ZblYwzZ1CEcg4bZpTnk8DOl0nBpnZ
7p3vKEKqHi7WJGWuKxr0Zduhfn19HaG2lNUFVY27Ixs7HuZ4E/OA1e31a07fA4GF
LP4D4besVh2c3o0jaOXf6wjEvlvPUwWBKvHzmaAjxQIpf/sW6Dj4l7iubMBHxItd

//pragma protect end_data_block
//pragma protect digest_block
8WK1fU56cVz7mFq0BCka6VkzpVE=
//pragma protect end_digest_block
//pragma protect end_protected

//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
lSSgl0BmEyV976lKeB1Vc6nwHcTwVDXp2wDPModasCXV2H32O1Gs6pCPwAqzyIFP
SA3f+gaMLprewIzRWCslKPHB66dLeuCf4b/xDSQ41yXpKvd/66n4Jh0hFdgaAgku
qne+qkWs7hCXrH1W72a3xt8ConfR8VTOOpgFr2ppUuVUKsckhKYhIQ==
//pragma protect end_key_block
//pragma protect digest_block
pnWs+BLQSnjaI9pUGr/aWmb5nGE=
//pragma protect end_digest_block
//pragma protect data_block
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
Yezf0WqviHHXkhKOLN+ggw==
//pragma protect end_data_block
//pragma protect digest_block
+JQHxiTtBYwvpEir/ZmLzQFNCmo=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_svt_spi_xSPI_profile_2_0_command_list_SV
