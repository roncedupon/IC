
`ifndef GUARD_SVT_SPI_FLASH_STM_TOP_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_STM_TOP_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP STM top register class.
 */
class svt_spi_flash_stm_top_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** SPI Status Register. */

  /** Used for enabling the function of Write Protect Pin (W#).*/
  bit status_write_disable = 1'b0;

  /**  
   * Defines memory to be software protected against PROGRAM operations. When one or <br/>
   * more block protect bits is set to 1, a designated memory <br/>
   * area is protected from PROGRAM operations.
   */
  bit [1:0] block_protect = 2'b0;

  /**  
   * Write Enable Latch indicates if the device is Write Enabled. <br/> 
   * This bit defaults to ‘0’ (disabled) on power-up. <br/>
   * 1 : Write Enabled   <br/>
   * 0 : Write Disabled
   */
  bit write_enable_latch = 1'b0;

  /**  
   * Indicates the ready status of device to perform a memory access. <br/>
   * This bit is set to ‘1’ by the device while a STORE or Software RECALL cycle is in progress.
   */
  bit write_in_progress = 1'b0;  

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
  `svt_vmm_data_new(svt_spi_flash_stm_top_register)
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
  extern function new(string name = "svt_spi_flash_stm_top_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_stm_top_register)
  `svt_data_member_end(svt_spi_flash_stm_top_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_stm_top_register.
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
  `vmm_typename(svt_spi_flash_stm_top_register)
  `vmm_class_factory(svt_spi_flash_stm_top_register)
`endif

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_stm_status_register();

  // ---------------------------------------------------------------------------
  /** This method retrieves the value of a single named property of a data class */
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of a single named property of a data class */
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Status Register */
  extern virtual function void set_stm_status_register( bit [7:0] reg_val);
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
KWrx8NdS32s7Hq8SFuud9nNv8i3fesnE7yjE8+B9Bj3pEuhOy0FFC+ki/tIo29x4
Di5hyErYPtK3PqsvNdMZtIFmy5PEQn54or78BC/0jNS0gb7goCfx8AuFrhLKNEit
V1JLimqxFqRmzlHChQD4MRZY3O2AhQosPRvgmMGqUiMeL8yB2CHN+Q==
//pragma protect end_key_block
//pragma protect digest_block
bKLcT6vDBRuOm8oWAZ8i9R4+cbo=
//pragma protect end_digest_block
//pragma protect data_block
haSn1LHDPjwX5dyRmgwCbJUXTG6SsKDkdDcW4kI0bQxGao3BOBLQey6ewduHQzx7
AI8bohJ5NrzVlNBLafq5f/m7wCoXESoq8qyHk+d2uOhTHbIQal5cidyhxXiF079e
C+CgeFWdD0t5jkRXHJu3xuOBFU+PSitPDBi6PDpWqUV9Fwo/953197SQkstoDU55
nJqI5vtc8HXbByPfwQeqBFrXTntxDjPcPkzBdrvlh/hY60T8Tsl3WuqVe5K9SSw3
WMi0zqDfMNvb1IAPmEnbSAh/+7kYSDFN0UnZNflv2DDZRAWPnKP6iwiOSLMUaYEV
RQ1L976xLBXlNLQp6jpe8LKfKvhIqwGXc6BbsIixTgPzl7tRjX3r6wYVjE26OPnk
ho9rqOF3Dhm30oRuHAdpXQwagnk5NLiu5VD8n7qgRy+lMnFJEzrd99Vj6Zk375jm
XbPieHGciU1MFEqT0akImzYjBk+pHKVZVJSU1lgO9LlH5I/iKEqYPaayuvVxG+PQ
y6T35KQ2eDn3XBJAZ5OfHJIlpR+sNBPWKPU2MNFJpQ0swMvTUorvY0G+whYcecUm
H7seWW7jx3ed7wpUmnewdIfYTzN4fgsAc1/0w6hELn6MUw8YyDLDaVeB4Cp6EaUf
xlbpZaqniNwhoxpCGLIlq7c6Sp/thzN1e5kUX7kG1KFgcnvyrogD/na3O0jMZli3
3T+xvsoNx9kkdxrGUhETH6qo/OKw8pLvefZDL/NZu2PM4SKOiaQy5YqfvWMbLve8
Vno0kcDLfT3Efrj9XUef3aEPWVg0Foxu1dahghJmJO6c2Fo/L/jDCaa07XliLsI1
ZLSh5qaHp/NMjwngk48QH07u+KXsYneaP1E1o25xm/F+xRoNSs4Aa0UaRyZ3d2vj
WqXhkKg22aRhyJeO4/RKjWGIbeli/dS8l2Cud2BxYQ4FSBmrIJPgagIa1I3igfH3
p8e8LfLbykvc63BJYAkr0j9xVoi3wO1Y68NXfBUfXzXDcVVm4vhXjkNfAaN/g7Um
IQ3qTiO0WlV/v4GawQ0R2g==
//pragma protect end_data_block
//pragma protect digest_block
+EtksIW64y4COxdoZRs2I7aYl5A=
//pragma protect end_digest_block
//pragma protect end_protected
   
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
gZgkbt2RxJJlTVbI7PvO7JgMTi3Pnn8y/BvkxEGBGJNjUAc0QojebwmCWhwSL+SI
/59l0llF7wjAHO+Usi0pvKx0pXSbSWhQ9f1z1DYA7j4VvAihPLErrmc6Mi8nYHgH
dGeI2u1R2goB5DpuDisFEbAxNytKjtlur6OqzwLxYSrdsBtHPVq2Lw==
//pragma protect end_key_block
//pragma protect digest_block
AnEPIBawP1yHgxyIMD3EaCiPIHY=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
n2MFzNeRdIIQySJTi/dJZSDzJ0M=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_STM_TOP_REGISTER_SV

