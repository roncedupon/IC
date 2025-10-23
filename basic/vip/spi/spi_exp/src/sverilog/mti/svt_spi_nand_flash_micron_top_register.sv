
`ifndef GUARD_SVT_SPI_NAND_FLASH_MICRON_TOP_REGISTER_SV
`define GUARD_SVT_SPI_NAND_FLASH_MICRON_TOP_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP Micron NAND Flash top register class.
 */
class svt_spi_nand_flash_micron_top_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** SPI Protection Register. */

  /** Used for enabling the function of Write Protect Pin (W#).*/
  bit block_write_disable = 1'b1;

  /**  
   * Defines memory to be software protected against PROGRAM or ERASE operations. When one or <br/>
   * more block protect bits is set to 1, a designated memory <br/>
   * area is protected from PROGRAM and ERASE operations.
   */
  bit [3:0] block_protect = 3'b0;

  /**
   * Top Bottom control bit used to control the Range of protected blocks.
   */ 
  bit top_bottom = 1'b0;

  /**
   * Control bit that Specifies whenther Write Protect/Hold feature is
   * enabled.
   */
  bit disable_write_protect_hold = 1'b0;

  /** 
   * OTP space can be protected after Programming it by setting #otp_protection to 1. <br/>
   * The OTP space cannot be erased and after it has been protected. <br/>
   * it cannot be programmed again.
   */
  bit otp_protection = 1'b0;

  /** Configures the device to program OTP locations if #otp_protection has not been enabled */
  bit otp_enable = 1'b0;
 
  /**
   * Configures Mode of operation/Region to access (NAND or NOR Read MOde, OTP/Parameter/Uniqueue ID). <br/>
   * CFG2 CFG1 CFG0 State <br/>
   * 0     0     0 Normal operation <br/>
   * 0     1     0 Access OTP area/Parameter/Unique ID <br/>
   * 1     1     0 Access to OTP data protection bit to lock OTP area <br/>
   * 1     0     1 Access to SPI NOR read protocol enable mode <br/>
   * 1     1     1 Access to permanent block lock protection disable mode <br/>
   */ 
  bit [2:0] cfg = 3'h0;

  /**
   * Device Lock Tight <br/>
   * Specifies Whether Block Protection State can be modified through <br/>
   * Register Write command. <br/>
   */
  bit device_lock_tight = 1'b0; 

  /** Configures the device into ECC operation */
  bit ecc_enable = 1'b0;

  /**
   * Specifiy whether Read Page Cache Random command is in progress.
   */ 
  bit crbsy = 1'b0;

  /**
   * For 'B' Generation based Devices like MT29F2G01ABBGDSF, MT29F2G01ABBGDWB <br/>
   *  0 0 0 No errors <br/>
   *  0 0 1 1-3 bit errors detected and corrected <br/>
   *  0 1 0 Bit errors greater than 8 bits detected and not corrected <br/>
   *  0 1 1 4-6 bit errors detected and corrected. Indicates data refreshment might be taken <br/>
   *  1 0 1 7-8 bit errors detected and corrected. Indicates data refreshment must be taken to guarantee data retention <br/>
   *  Others Reserved <br/>
   *
   * For 'A' Generation based Devices like MT29F1G01AAADD <br/>
   * ECCS provides ECC status as follows: <br/>
   * 00b = No bit errors were detected during the previous read algorithm. <br/>
   * 01b = bit error was detected and corrected, error bit number = 1~7 <br/>
   * 10b = bit error was detected and not corrected <br/>
   * 11b = bit error was detected and corrected, error bit number = 8 <br/>
   * ECCS is set to 00b either following a RESET, or at the beginning of the READ. <br/>
   * It is then updated after the device completes a valid READ operation. <br/>
   * ECCS is invalid if #ecc_enable is disabled
   */
  bit [2:0] ecc_status = 3'h0;

  /** 
   * Indicates if Program Error has occured. <br/>
   * 1 : Error Occured
   * 0 : No Error
   */
  bit program_fail = 1'b0;

  /** 
   * Indicates if Erase Error has occured. <br/>
   * 1 : Error Occured
   * 0 : No Error
   */
  bit erase_fail = 1'b0;

  /**  
   * Write Enable Latch indicates if the device is Write Enabled. <br/> 
   * This bit defaults to ‘0’ (disabled) on power-up. <br/>
   * 1 : Write Enabled   <br/>
   * 0 : Write Disabled
   */
  bit write_enable_latch = 1'b0;

  /**  
   * Indicates the ready status of device to perform a memory access. <br/>
   */
  bit operation_in_progress = 1'b0;  
  
  /**
   * Die Select
   */ 
  bit DS0 = 1'b0;

  /** SPI Agent configuration handle */
`ifdef SVT_VMM_TECHNOLOGY
  svt_spi_group_configuration spi_agent_cfg;
`else
  svt_spi_agent_configuration spi_agent_cfg;
`endif  
   
  //----------------------------------------------------------------------------
  // Protected Data Properties
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Local Data Properties
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  // Methods
  //----------------------------------------------------------------------------

`ifdef SVT_VMM_TECHNOLOGY
  `svt_vmm_data_new(svt_spi_nand_flash_micron_top_register)
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new status instance, passing the appropriate 
   * argument values to the parent class.
   *
   * @param log VMM log instance used for reporting.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new status instance, passing the appropriate
   * argument values to the parent class.
   *
   * @param name Instance name of the status.
   */
  extern function new(string name = "svt_spi_nand_flash_micron_top_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_nand_flash_micron_top_register)
  `svt_data_member_end(svt_spi_nand_flash_micron_top_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_nand_flash_micron_top_register.
   */
  extern virtual function vmm_data do_allocate();
`endif

  //----------------------------------------------------------------------------
  /**
   * Does a basic validation of this status object.
   *
   * @param silent bit indicating whether failures should result in warning messages.
   * @param kind This int indicates the type of is_avalid check to attempt. 
   */ 
  extern virtual function bit do_is_valid(bit silent = 1, int kind = RELEVANT);


`ifndef SVT_VMM_TECHNOLOGY
  // ---------------------------------------------------------------------------
  /**
   * Pack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_pack(`SVT_XVM(packer) packer);

  // ---------------------------------------------------------------------------
  /**
   * Unpack the dynamic objects and object queues as the default uvm_packer/ovm_packer
   * cannot create objects dynamically on the unpack.
   */
  extern virtual function void do_unpack(`SVT_XVM(packer) packer);
`endif

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

  // ---------------------------------------------------------------------------
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

  // ---------------------------------------------------------------------------
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
  `vmm_typename(svt_spi_nand_flash_micron_top_register)
  `vmm_class_factory(svt_spi_nand_flash_micron_top_register)
`endif

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Protection Register */
  extern virtual function bit [7:0] get_micron_protection_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current FeatureRegister */
  extern virtual function bit [7:0] get_micron_feature_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_micron_status_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_micron_die_select_register();

  // ---------------------------------------------------------------------------
  /** This method retrieves the value of a single named property of a data class */
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of a single named property of a data class */
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Protection Register */
  extern virtual function void set_micron_protection_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Feature Register */
  extern virtual function void set_micron_feature_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Status Register */
  extern virtual function void set_micron_status_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of Die Select Register */
  extern virtual function void set_micron_die_select_register(bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the Agent configuration object handle */
  extern virtual function void set_cfg(svt_configuration cfg);

endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
LXuYnVxFW6pshdY+HEXMY3HYr5mYuVQF+iWbSh4OlWbapWfKyQr0Xs5gE88Vjn/0
W5oa30A/8VjDvkI8q1Y5Ht+o+Z6UwemGRas5+vbU9UFVlmqEXOIBH0R7kfrhzns8
w8S+WN0bFE/X6kimVhGHPvAMjRU2uhd3J7I3TxSnT3g=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 646       )
S3f84JmB2ckIsoG0wui5PP6UcrK6CGs+H9emVAXhjFgrNiLW1XZ8PS6xCMQGdk2G
HvT6MMyh/Cbq3kvhCXiyVX8rjfXAVdsvcU9LbhPcm0GnHHG9RJnqXQ/QdwQGjqQF
uI0IAl5mdAauXofDFnAYrwvjwNCWCuQhUUy/W5XYXhfLwOivIZez0mkw2/ErYHHH
COYdlvvonV88mzqHixCH73d4Uf1kp80OAlQXXZgz6ahODTVAwGc5P5Iu/RqyHWk8
jAFn9NB20gFUnGoAV+JyJYVJ3lIZKVcz81dneG5Heb0DH87V6n7WdTbmxkU+dFEG
Z1uAZYeDDTT4HuWVEKrsGmEwD/ZbALKbVo0ElMJLFTDmnnUDHXHb1qPCHDR3A02j
eyDrQZQWF2LMYNOq6fGKDxsUclqrzcYT0PiPUoN3f9rxH2K2FjvCKqU0d7OvU7CF
HA7d7p/1TsVlcmOomgfDn3Z/QChWqGQTiDrmbi3SvTEGRv2LCKFN2IkonC4J6/tk
vZ8Zj250ihckuD+3uNMV18ObTSnyicLdyoSxAND3ag2u9D5P3OhO+td3RIQWGgGd
GcBSaoa94f55QsTGL+2oMMM803c9PEyWaMV8JJxm6mav3YxT0EluftUVH+yH2Tpu
oUMhNPNbnxDU8uXiDv4EAD1w47Nve/CJpXdf49J+AQWLROcOjwsRSz1W7V9BGypa
Gv4TIJE06poz3EVgy3rhvNpmQgW1m+U2EgurvXLawAhrywG2iHnnvXxff1citaRp
U4T7eAvWAFWsovj3gc44M1A3Y5GyoxzA3gL6tfUfl0/NeKa8ackUeM4WleCmMdUz
y9RPoM9FAwqHJI2DaLp3Bkt1QVf5xgPwQSuDMfygGNI=
`pragma protect end_protected
   
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
M7AUXsJzB0yd9XM2olp1Rw7zIq9KAbdlnxu8hWeUZQWqJ0tJ2Lp9BC39QwBWihHe
aEji/D2jA/GQWBYuRDVFNSsUNsOg2yjoqrTu7gmV+SuT/M+tzKcGuDF41lcJxTI2
ItVLz8q2GfyrzoSTY9HoH5lKNodjd+2XrgbQuUhXZQk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 17611     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_NAND_FLASH_MICRON_TOP_REGISTER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Xk6p7ZAXGkzbrDNDNW84zlsbrxG6Yh0RyhvP1gQbzniok6TKrrnEvvJx7KLy+lt8
xI9hK1zoYxgTGidWJXU+hbip41rgTHElPOH7dZZiUgvpC1GXQwV+rWv4cFm8ON5q
T8SoKydl+LnZtyco9qWwnyyW2VyOSZhk+TQkZnklOXo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 17694     )
9C3hjj+SCp5FvWZn4tU/T5gdpxXCboZG1hhaSZMPTsDl/gusa22zMechFP1aUOrR
TVFfGIpDHfPRfEDD5+22BWKdpxiR8MHwn++Wa+hWfWc/x3Yh9QeXF3WvPzpic7yp
`pragma protect end_protected
