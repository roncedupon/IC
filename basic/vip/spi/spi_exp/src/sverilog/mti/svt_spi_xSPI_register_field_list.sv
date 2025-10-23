
`ifndef GUARD_SVT_SPI_xSPI_REGISTER_FIELD_LIST_SV 
`define GUARD_SVT_SPI_xSPI_REGISTER_FIELD_LIST_SV
// =============================================================================
/**
 * This class specifies single register field of xSPI Register. <br/>
 * It encapsulates field name and its default value, supported field width, list of registers that contains this register field. <br/>
 * Member 'nonvolatile_reg_field' holds non volatile (if applicable) version <br/>
 * of this register field. <br/>
 *
 * Following register fields/variables are supported in generic registers: <br/>
 * <b> <font size="+2"> Field Name </font> <br/> </b>
 *  1. write_in_progress              : Device Busy/Read Status             <br/>
 *  2. write_enable_latch             : Device Write Enabled or not         <br/> 
 *  3. program_error                  : Device detected Program Error       <br/>
 *  4. erase_error                    : Device detected Erase Error         <br/>
 *  5. dummy_cycles                   : Sets Number of dummy clock cycles   <br/>
 *  6. quad_mode_enable               : Device QPI/Quad mode enables or not <br/>
 *  7. octal_mode_enable              : Device Octal mode enables or not    <br/>
 *  8. ddr_mode_select                : Device DDR mode enables or not      <br/>
 *  9. io_driver_strength             : Sets driver strength                <br/>
 */
class svt_spi_xSPI_register_field_list extends svt_configuration;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------
  
  /** This field specifies the register field name */
  string field_name = "";

  /** This field specifies the register field value */
  bit[`SVT_SPI_xSPI_MAX_REG_FIELD_WIDTH-1:0] field_value;
  
  /** This field specifies the width of the register field */
  int field_width = `SVT_SPI_xSPI_MAX_REG_FIELD_WIDTH;

  /** This field specifies the access type(Read Only, Read-Write) of the register field */
  svt_spi_types::xSPI_register_field_access_type_enum access_type = svt_spi_types::RD_WR;
  
  /** This field specifies the field type(Volatile, Non Volatile, OTP etc) of the register field */
  svt_spi_types::xSPI_register_field_type_enum field_type = svt_spi_types::VOLATILE;

  /** This object specifies the list registers, which contains the register field  */
  svt_spi_xSPI_reg_field_register_map register_map[];
  
  /** This object contains the non-volatile copy of register field  */
  svt_spi_xSPI_register_field_list nonvolatile_reg_field;
  
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
  `svt_vmm_data_new(svt_spi_xSPI_register_field_list)
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
  extern function new(string name = "svt_spi_xSPI_register_field_list");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_xSPI_register_field_list)
    `svt_field_array_object(register_map, `SVT_ALL_ON|`SVT_NOPACK|`SVT_DEEP|`SVT_NOCOPY, `SVT_HOW_DEEP|`SVT_NOCOMPARE)
    `svt_field_object(nonvolatile_reg_field,`SVT_ALL_ON|`SVT_DEEP|`SVT_NOCOPY|`SVT_NOCOMPARE|`SVT_UVM_NOPACK, `SVT_HOW_DEEP)
  `svt_data_member_end(svt_spi_xSPI_register_field_list)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_xSPI_register_field_list.
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
  `vmm_typename(svt_spi_xSPI_register_field_list)
  `vmm_class_factory(svt_spi_xSPI_register_field_list)
`endif

endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
jVxjNPdPkgPnjbntb2KxdWnheHij1UgDbULt+1GwHxxSshHBtYlhprQrjs9Okw7g
2oKPCmc6lplDYUKR5ZcRcHf+hc8piwFaZiSNjPQCdeKUpHsnFnxL3vKdhRDH8ZiZ
sINKsAKyOkl8N6smjEnhU/fjPKAQ/fveD5/epPQqSLM=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 622       )
MNwfCm65rdRBuEntJM3M7j1vyGoVXrgH3QvRHWZ42CJCoJvY7Lvi/Soz87jBjcGd
lB7qaWCAhxy4sDyFEKYorjxvb6OzaHZ9NUks+HYG2eeFAPpUzvXQHPZ2tccfR84W
K85pkCfQLTDG+dvc6bWxnUVtvvYOVZ/C2kBvYsCrtFVz1weJANbVpOYvm8HXtz+2
EeGosmUZo01ykOAH1PVyUvheqSiloCt5NLBqnydlMQiEWlti9iJKLpngBuq5U6dZ
9R6qOk227Eu23GKby2G5vr+iQaqbG+TGbBL0W137PW/CHFD9eVgrrVlg8UYdtIBq
j5spwzx+TZ54XzmVRUnjTK2ZKn15lJkMkUFmoPQRta0wmiQcuoCKDWqR5AmsJQj0
rdRsdL1lPyu/QXn9RaKNbuo0gcda17bgC0HNnOW1gTDy7O1eHKet3znheMAte8MM
nd+B8Hg6rBM9QrIYUgVL15yBXl7FSARE381+FnpkUV4y88/3xgWaSDYQ6FyxmCGt
G7kHVKAgtZ8PabMPnnvMcNUTHez73gGKah1wjylViz9T8Fsxn0QGtzsK0Wj3EOO3
VkuiQ88EDHbtYtrj3vbcbK1WnjgHLIkNLRU08x4xCmz1jAHDGzk7vg+HE7WXB4rh
kgCcUZnLcKgsPzvLGly8AKgXiNpstgAOI8paSEpgkR0DKygmEZE+QI5ipPqzLXBP
nSgVKuKOc0GLs/7tVckSXJ+eqQNEwre3/mx/OuYIG14zsQ9lVR8Szo3DCvDxVz6Y
jVIpJ2vYlVJO9I0vKtq9/G7gWBOn6pEDFdebNgwnhSLYoq1KVg2O1TN/L2PkAgt/
`pragma protect end_protected
   
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
kmXAOWLwxSJrtmFnI9i9k9I1VGNs03wmoveBaRCmV6vqeTNwpJ7pSlamepr8DP9i
le4KSbGrxw7kDVhiuQBNXIYc3AmsClusJodbbUERT6I1aGN/9EZaaDN543+MQSPz
unksTG5WLE74djdBMnHW3HRponf3TjVWU46K6eLU81s=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13676     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_xSPI_REGISTER_FIELD_LIST_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
XFkguy9IEaeBw3ibc3pS96a8wP/Mf9AnP0jG+FgGo2pyzpz5AhfPXwdhtTpP5jko
KmZivlyBndTmElwx8c32/le2SD3JKT9jzD+F20MmqFFGR/NOECiLHMH1iBZ/qCN8
SziNekN7Dh3Zlfca1LSYmaB7oij7tHZ/3Rejb3y67PQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 13759     )
haKNmguOj5ea3rxZ0o+fbEt2ty57PHOfSlkTtOiqxkyTI6SMb0D3KDJEJspZoAkf
OYgj/GVnWXimxXwpRN62zoqpzJXzcu1a/VUZPrfFLk6u7fzsOzaTx5ULkzDOiSkj
`pragma protect end_protected
