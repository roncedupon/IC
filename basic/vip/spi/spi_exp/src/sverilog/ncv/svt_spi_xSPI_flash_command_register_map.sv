
`ifndef GUARD_SVT_SPI_xSPI_FLASH_COMMAND_REGISTER_MAP_SV
`define GUARD_SVT_SPI_xSPI_FLASH_COMMAND_REGISTER_MAP_SV
// =============================================================================
/**
 *  This is the SPI VIP xSPI flash command register map class. <br/>
 *  It specifies flash command and address frame required to access specifie register.<br/>
 */
class svt_spi_xSPI_flash_command_register_map extends svt_configuration;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------
  
  /** 
   * This field along with #address_frame_list specifies flash command/address frame(if applicable) <br/> 
   * pair required to access xSPI register mentioned at the same index of #register_name_list.
   */
  svt_spi_types::flash_command_enum flash_command_list[];

  /** 
   * This field specifies the address frame to access register specifies at <br/>
   * same index of #register_name_list.
   */ 
  bit [`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] address_frame_list[];

  /** This field specifies whether the address frame is required to access the register. */
  bit address_valid_list[];

  /** This field specifies list of supported registers. */
  string register_name_list[];

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
  `svt_vmm_data_new(svt_spi_xSPI_flash_command_register_map)
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
  extern function new(string name = "svt_spi_xSPI_flash_command_register_map");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_xSPI_flash_command_register_map)
  `svt_data_member_end(svt_spi_xSPI_flash_command_register_map)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_xSPI_flash_command_register_map.
   */
  extern virtual function vmm_data do_allocate();
`endif

  //----------------------------------------------------------------------------
  /** Used to limit a copy to the dynamic configuration members of the object.*/
  extern virtual function void copy_dynamic_data(`SVT_DATA_BASE_TYPE to);

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
  `vmm_typename(svt_spi_xSPI_flash_command_register_map)
  `vmm_class_factory(svt_spi_xSPI_flash_command_register_map)
`endif

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  //extern virtual function bit [7:0] get_stm_status_register();

endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ViyPfhTYlVWAlSbvg1xj1ZBiwpbSlbhndlfjDy6Zhz5XonYkI2C0OW8Xc+IHAFWm
i6rpHGemtgRrKgp1XDFdqkgVh5a0IFfaqoSHLa91SPADWL+JkfPy8ZvJjL4wuRI2
sZ4L+yjX/oFWaSGjF5Kklnv/JayJF4EZEtmG77gXiafMzZXfn8rowQ==
//pragma protect end_key_block
//pragma protect digest_block
fGJfQDSX2sqG+dGhSmFn8sQvn9I=
//pragma protect end_digest_block
//pragma protect data_block
0G60ln+YIwGV5KhyQnCY6gN5rllWJuyInpENQ8V+eHvReDnrEcA25TFVxoJtYEdm
ftcjqJeSjLIxS0r/ZP25kUM4tS9wKAW6BGzes/qPWk8fE07NQ7MYdDGcohaOYPF6
QEpGfGKESwTvcVVdC01hSHP23ecXBmm5RvFj9qoDwJahvZjGwuxhIlTC+GBiMESx
lY1hlImAAkqCKBTFAHhiQgjwefLvXkREEYigX00eQoK0eisvGuvQw06xgJlh3uY6
PRdeQzgeNSosWTohAxZqJpZ+2y+5anrsWRGMScvArArVt3jtlxpR625JxvUd1Exd
JxM70/tMqllP6G1tE0+XSOQSewSC4b2ENVBg/s3LVm69vfHC9v8lcpq+Ut3MwaSK
B74GWxK9javxj77qfjpvjNKVE3A+Kp1CVvDu1yTM4vYoarxG3OBA4JX0PGK4aRae
qD6fYaq48xb7HmiLF6XrFvLMYd9jk+vu0V2S7YCc7v5uwn/Jkkil3lTO+02rWXvn
XkUj/GJnK6Io9w2RvtN+cVohMRfsENq16vw9TGyPpk4hvbfjb/2Pi36qUd5g4hWQ
+iqVrZpVPtaxOhjAN16V+Ej1JK3vEQ/CUQNDrPFME93ikU/EZHD4Bsu9ONe0cJ1t
nnWBSpl8rrhEsK25zWq/7Q2MfhSXmRxSrNyZQuJVglMBE68IwbBhn8xKyXd3ra5E
YGqCDLFa8AdHREUxAeqc6Fx/BVrgqTCJdOHm4zoTTMoQL8S3SAgzOPQFxV9+Cl2U
+xzjLrQVksZEMB4cO258YDl4PdgjuWa9f7ruRSscXRoBjQ6AJqmcuqartdtb80Fu
7xoAFBjD61pIoRWoeD9cMpwZV99vWUFsYRVcIKSbCROoZYEuLJukoU4DInELPL4c
/NQXeNBBitfjSgYTTwwL1r3Q4YuesUAt1I9Qff5pwUtNKAbFHLRO0gTWFOS7khd8
oy2Ilx1e0Q953NaehqAu+YPd6b8RBPdNNCUgqDMjbzepNcqnLXAA5CkVMCnGUqQn
1RM9DHNEUvKrsNpF1Ky0LqrypmxKPj9Ytb1GyQMRrQ49VWs15cej3YPYm+fuQAnN

//pragma protect end_data_block
//pragma protect digest_block
xd29f9uoflnuc11eW/YDlS5OLFU=
//pragma protect end_digest_block
//pragma protect end_protected
   
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
+AtxcW8TGlLEHZ7s3iHchudMsdjfJvsgCPboZcyetHUvA7mTuzp0YQu9xulmSGMx
1BVomWuJi75m8Ma9am2XGpemMx7aEY6WFRBU+EkOqfAIzpT5+WlhxdxXVUZdEMP4
3e90quy6w81ALFgTJkKN1I+6qp3wllP7u0XE+vrknvx9ZJFvDS7PNA==
//pragma protect end_key_block
//pragma protect digest_block
Hnoh5UBsPxrF+AV3Am6LNwxbe80=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
9VxoBKJffVRbdi06vCbPdNYTAFc=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_xSPI_FLASH_COMMAND_REGISTER_MAP_SV

