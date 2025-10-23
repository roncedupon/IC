
`ifndef GUARD_SVT_SPI_NAND_FLASH_GIGADEVICE_TOP_REGISTER_SV
`define GUARD_SVT_SPI_NAND_FLASH_GIGADEVICE_TOP_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP GigaDevice top register class.
 */
class svt_spi_nand_flash_gigadevice_top_register extends svt_status;

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
  bit [2:0] block_protect = 3'b0;

  /**  
   * Determines whether the protected memory area defined by the block protect <br/>
   * bits starts from the top or bottom of the memory array. <br/>
   * 0 : Top Blocks Protected <br/>
   * 1 : Bottom Blocks Protected 
   */
  bit invert_protect = 1'b0;

  /**
   * This is used to reverse the Protection set. <br/>
   * if set to 1, previous array protection set by #block_protect and #invert_protect will be reversed.
   */
  bit complement_protect = 1'b0;

  /** SPI Feature Register. */

  /** 
   * OTP space can be protected after Programming it by setting #otp_protection to 1. <br/>
   * The OTP space cannot be erased and after it has been protected. <br/>
   * it cannot be programmed again.
   */
  bit otp_protection = 1'b0;

  /** Configures the device to program OTP locations if #otp_protection has not been enabled */
  bit otp_enable = 1'b0;

  /** Configures the device into ECC operation */
  bit ecc_enable = 1'b0;

  /** Configures the device Bad Block Inhibit operation */
  bit bad_block_inhibit = 1'b0;

  /** 
   * Configures the device into QUAD IO operation. <br/> 
   * 1 : Quad IO Selected   <br/>
   * 0 : Extended or Dual IO Selected
   */
  bit quad_enable = 1'b0;

  /** SPI Status Register. */

  /**
   * ECCS provides ECC status as follows: <br/>
   * 00b = No bit errors were detected during the previous read algorithm. <br/>
   * 01b = bit error was detected and corrected, error bit number = 1~7 <br/>
   * 10b = bit error was detected and not corrected <br/>
   * 11b = bit error was detected and corrected, error bit number = 8 <br/>
   * ECCS is set to 00b either following a RESET, or at the beginning of the READ. <br/>
   * It is then updated after the device completes a valid READ operation. <br/>
   * ECCS is invalid if #ecc_enable is disabled
   */
  bit [1:0] ecc_status = 1'b0;

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

  bit [1:0] driver_register_bits;

  /**
   * ECCSE provides ECC status Error when ECC Status is 2'b10 as follows: <br/>
   * 01b = bit error <=4 were detected and corrected <br/>
   * 01b = bit error =5  were detected and corrected <br/>
   * 10b = bit error =6  were detected and corrected <br/>
   * 11b = bit error =7  were detected and corrected <br/>
   * ECCSE is set to 00b either following a RESET, or at the beginning of the READ. <br/>
   * It is then updated after the device completes a valid READ operation. <br/>
   * ECCSE is invalid if #ecc_enable is disabled
   */ 
  bit [1:0] ecc_status_error;

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
  `svt_vmm_data_new(svt_spi_nand_flash_gigadevice_top_register)
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
  extern function new(string name = "svt_spi_nand_flash_gigadevice_top_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_nand_flash_gigadevice_top_register)
  `svt_data_member_end(svt_spi_nand_flash_gigadevice_top_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_nand_flash_gigadevice_top_register.
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
  `vmm_typename(svt_spi_nand_flash_gigadevice_top_register)
  `vmm_class_factory(svt_spi_nand_flash_gigadevice_top_register)
`endif

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Protection Register */
  extern virtual function bit [7:0] get_gigadevice_protection_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Feature Register */
  extern virtual function bit [7:0] get_gigadevice_feature_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_gigadevice_status_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Feature Register 2*/
  extern virtual function bit [7:0] get_gigadevice_feature_register_2();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register 2*/
  extern virtual function bit [7:0] get_gigadevice_status_register_2();

  // ---------------------------------------------------------------------------
  /** This method retrieves the value of a single named property of a data class */
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of a single named property of a data class */
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Protection Register */
  extern virtual function void set_gigadevice_protection_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Feature Register */
  extern virtual function void set_gigadevice_feature_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Status Register */
  extern virtual function void set_gigadevice_status_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Feature Register 2*/
  extern virtual function void set_gigadevice_feature_register_2( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Status Register 2*/
  extern virtual function void set_gigadevice_status_register_2( bit [7:0] reg_val);

endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
cqSk7lGZ4s6mlQ3pNai6uZJRExHclkMlplho+oYNkghHirg4jt8t8Nwe2bXYFjqZ
dqEY9aeH/nBU4gu6FJj4FJAMcjhCkqWj+UUNCoFP0QHJ9DSmZl5+TBkeJg7dbzKs
iyupYhpNLRUxczez3qvMu/9RZifM0OzeSWmC4K7Uax8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 662       )
N+d9gAMXijsqi0II+jrJXkPCBPi9wW+kJKuwY26rvhZCDqLvexfRpDG+Hh0CjSql
vv2M7UQksrZsYW+qJvMVkjDEWZ00rsNDPFWjVz1Zzc59nXir9upfHJN32HFM3AUY
a+R9yb2Kt5v1IvGQQBF/3MTc82jQfFYjrydeOK4kxCZRKz7QmkxHdSnyKxKAsjxK
R6VUq3t04Irp6ykrO+yg/VO6bYATqDM/F/TlGURqpr1UiikBFhAsFgEXH2snUUSQ
HyJP7WxjmsU7+cw2W/WH8yQo1F7dHEqYpjcreeZ+7Ne9GpYudWkTlje4rwOtmTkg
CBeR4JS9+AMuKl6GEhEbCdjaE7rNA4/Frf+brMCzvFeDyJ6PJadWg9BJkfMgM7St
K94uvDnJYJ0bvCQcBLoIX2MhVyuMfXLefhSSe+26xf5CRzut5NGH7XSlY6MOWiT2
n/NZlpyNPF5v6W6dFfl/oeHI2l3TNC7dCtZwt2Teifo6KBRsvhtewDHnQUnj0y2+
JMhFo8LVCRBxAeZ8mj/zNhz5fIaHajycFOYgXb3UWkXZIygsSvV46XHZR2evoq9T
1WZlyo7STYjI/mBIigkrZYLDIk1oQfVNAusshMd7IUHTLwtb8AP7/t5lnswJpUtv
YmC5An0K9fGMo8j9BBmui4iPtmBnfzYplbmKcBgyUIMV8vU2Zd/Jg8ZDo5Rq67kJ
w7mdaDhL/4HTdUVlGchEqDiR1NVbqGu0PSJSFRzSmHSdFD9taDdaQLyf95WlCXgM
YlClraoekYKhlgCsg+qL2wg6MEY5RhY497zthcDFlPwhf9FFTK3vUo5u/tiXDwDE
tK6/P/3GAsmHYq5vvp4Z64zi5tJDM85KMM9G74fZbCL99Fo2FdoduJQ99FDfj6ch
`pragma protect end_protected
   
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
oghzM7/wVI78xCPWhuuSmlJtqE7518WOPENZSTi5MFJjgJX4/8pm7Jv+FgI9WN/s
HqRG6/D1NAULdK8LttJvU5NsQo3JSze/AKn7adOV6hpMb5FYCkYL07ld6uWlHgia
VgmPqeaYQvk3UArXGUUQVAeeUBG1H6wK3an8jTOhf3E=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 18241     )
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
RY4KN89uu/Vq39uSlZSjFg==
`pragma protect end_protected

`endif // GUARD_SVT_SPI_NAND_FLASH_GIGADEVICE_TOP_REGISTER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
KMbVYa64Ko4Ua+ntC0pLCyItIrxHb52/gxb4EdT0siBsoSaM4hlUD9fDRpCV/1C/
EpmyFzi5afg0ImgAfC4bBVSlwOFYWhKFk/utb0xZiyelYGvIV/S/eu7ZcquBoIm0
kWsMczXnAOJtizBdTLnlzucrJU/KIObEJML8TYXHM5o=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 18324     )
zNDy0LrhUMD8v13NA85eigSiLJ0yzstgUQ4Q6HOfvd5a7++BPTcPN0ZA+JQrsfj4
Wg/XixGk1VREU3k8JfKV+qaKm0cSXxVydF5dL5M+VbZrIWq34vD8eWPTgGI5S2Fs
`pragma protect end_protected
