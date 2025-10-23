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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Ap0K5CQCDdxxc9eoyWIDu1wgbDWW33wft/9dyMlnAtw09RJJLp9CVWLnqEEOjQyR
fZPGS90lqRoi2z/tQy6JQC/slMG/LS9rbZHHDvxZWngSk3B+wusJl3w1w3rjOrU8
13ZGZBF8lCqcYgsSpyt5EJxRBniJtqzJOCq6Bk/45fE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 642       )
NNFBBhSnLJji1il+QhChYMdOLyd9v/DCVjSwb0SVe9MjmKoiLK+2rGKxeSrmO1Rx
/9uxij0Hn0d3PjWDcQZFs273xmDXDQZFSwZNt13wyHWY3THNLPxVQF6hNcHFuumq
9fT/2u+M3qgAm78daWZOwOQCofUrqKNJcxtDvoXvRDFjlQHbxa8pbfOtoAM2Rulo
kism4isR0LBrWf/omnH+7NyoHdEaJw76gJxyhBJpwO5I0/+iwaTahfeEbcLAP856
Penoa/wlS70bZHgOEPNZfa6+k2Gd/3WxQDaOj2pmChSw2zozyoUb2atlfzXX3k+8
vEzwFfcYpycTN5q2rGdIDgtO4ca/Qe94WDpABPtPU21g+oCNNr9oBi+dq3tKWvP7
7TQ6P4sbb12rvZ13S8Eg1X4PjQQMOTqfG6rJFiT8KIzFQNx7Xj3cHP0RCurBqszx
tamxPFwqL2j6cBhR2iMVNVzF4PyO/4eItucw4Bhn/aJ8JwnxkBDN+YHu0JkeSfS+
tyW9CTFGz72YJUe/BQZen6y6eenw0RSuL1h/iZ15rguv3rRRG4dHaDn1I6QaddDs
6CXuuTT+jAvBuzMNWI4iYnglmcWjsk0cTkD2DEn5gGNEZmtYaheuoDmoNTiDSJDP
GNgXOQznV/I9YQgCLmy7554Ezal0tIaDGn3tYYB84gSZr/fpftKVSMx5/98IAQaQ
dB6FyPgrYkaYXsXBL3uBEedgID61iGhzph32XT8Xn6dlXGu7nOyMxe0h4cCje17C
3SkiKrYHPiqLX/bRZbLCPHo+p/aGmmQe+LvbXaVUedxlikxKVXXza4u0BKu/nCXU
YWROsH/KfEkCV4ONbH+2eg4tIstIy88S56tAmtPu5O8=
`pragma protect end_protected

//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
E1WnnxBajIt/jc5Fhf8+E9mTjXBol/ulPb/T4JznomRCeVMcF/HC/K7W0iv7GLGT
Annscnt5ZWaWzF4t8BtM7uVXPhsD86HyEj4c9XLYUIgFcfCrTLoW8Rm5GnAHK2PB
/nMBb3l+w7wdNV3wKFMgOQQjpyjw2UzjetEr1TbUS/0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 45022     )
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
`pragma protect end_protected

`endif // GUARD_svt_spi_xSPI_profile_2_0_command_list_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
WwlLVQkQCulJh4KCBMYkXwdgOkQBgIG9pXqS6uvxglraNsFFUtekGg+/VzyetAbo
LljogYYWWUIghj2PPzZem8Bb5wALay9VDLlbMVdxEDZI3L01ax3Vlw1x9v6W4S3k
tOm2nFtm0ccK444yE1ku6ukGxSFDnFZwYasC433v0PY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 45105     )
hQatzns7OWdGsl2sFqAWqVEuQ8vkUXRyoPPekBhEL6zpvMCmxTORm6V2NOlQukNf
efyhDCjJmqPcUlLNBApqH8kxwnPjN29HBCxG0eYmH7XeN2EYWBC4vgmNHQsGYSnn
`pragma protect end_protected
