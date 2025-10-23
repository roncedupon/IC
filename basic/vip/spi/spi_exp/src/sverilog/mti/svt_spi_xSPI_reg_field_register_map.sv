
`ifndef GUARD_SVT_SPI_xSPI_REG_FIELD_REGISTER_MAP_SV 
`define GUARD_SVT_SPI_xSPI_REG_FIELD_REGISTER_MAP_SV
// =============================================================================
/**
 *  This class specifies xSPI register that holds mentioned register field.  <br/>
 *  A register field can be distributed in multiple registers. The valid
 *  locations for register field at register is specified through 'register_field_index' member <br/>
 */
class svt_spi_xSPI_reg_field_register_map extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** This filed specifies the name of the register which contains reg_field. */
  string register_name = "";

  /** Specifies list of 'Received Data' Index that are valid. */
  int valid_cmd_data_index[];  

  /** Specifies list of register field Index that gets updated with respective location of 'Received Data' specified by #valid_cmd_data_index. */
  int register_field_index[]; 

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
  `svt_vmm_data_new(svt_spi_xSPI_reg_field_register_map)
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
  extern function new(string name = "svt_spi_xSPI_reg_field_register_map");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_xSPI_reg_field_register_map)
  `svt_data_member_end(svt_spi_xSPI_reg_field_register_map)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_xSPI_reg_field_register_map.
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
  `vmm_typename(svt_spi_xSPI_reg_field_register_map)
  `vmm_class_factory(svt_spi_xSPI_reg_field_register_map)
`endif

endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
oomOab4YITEABSwZq2NOUYRazCrKgUgM4UUmSZyVir8e4NOlwaXIDuAiu+k/P6Wx
xfc2uWqebSxlIQu9YadRLR7BKVndkWGlNp/rgcvwoggSwzUtjKbHGYzvlHL23ZGj
556CEnDdq/8o+Ie52jg1DT9x/MhMbrv3y8ZrX8E8OvE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 634       )
rYtQBJ/C8IGvOZSds2oDEzqAM8QnGF7t/ULalvKIuMQW/4AoY+d9n5RiNMXNFthQ
ePldZQ/zuRHtzwBMyLrmL+XfwMc7GxCXZT9jn3YZROIkeXGc9y+32tFp9xdeQIZ5
q8CUHGDVhKxqYSn3P7P7729wQRs3A6FncTiHQN6Z1k20Zpb2ibwsBWnKlmVtd7Me
K10yJjGpsioHHxA+550hJsp3Kqu0Y3P3Ij/vHifDwoDLEFfH9//bC92XaUxMvNdo
V9IZFUniKXbY93MxR7uAGXxbnLcWXStS02szDyJL8VFSSNmb5EbjS4hlsd8kkOFZ
s9oMGKRo0R0RTgQiPWVV7foLnKez4qBknSmTig4Rulq31yrkeJsjFjZPkyBNMmk6
HsRAatcTmTixX7a26lV6x1pP6JETReoN1l27SmOafqGurQCUKbxa4jkyDVNv1ioS
1Ry/rSPNkYx4Upih5vj8Gm4fuURU9yGt32cdf05ldhiGGWp6rKDSWCtIqGeNiK8X
PE2HCVw80EY+4BFUzKvhDPG2WCHpX1qZAinnP6ukwgS0otgQP3DI+SpWqVicNAyK
hXLWE9lO/uM7tRtpNytMaTQGfXhBjQl1g8Rbqlt00lubkMKW+Nb9Oa+PdWEOoktB
w9CDZ/F8cOHsoQRVvMvo8R37AcujTUZUobL9Pj3jH6FsUCsfuKb3SvdMCp3Zzgo4
+9Fv+vWJQckI/IEMkQuHsFRB07C4DBRuHBiwFF4S0U8uOKyqdzuGmgLznMTggn5N
NUBQkYJFaJroDkN91gK+ec5Cvy0P7/upQGtKOOZZHOGTO9I4LhcOToxHp/Qr+7uU
SVoqgXOsAFBmqnbdGsvXTw==
`pragma protect end_protected
   
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Ud3mYdIJctrQzKLww4Sdf9tgk9PU0p13sMGek+LKpJerHHAy/ZLg1MzzA67QW2wE
dAy1fzelL13QWKwqSsCPjZ366yNvHWrcrQb8M9iEDegMNsiIN0A7CBqYMOtoboYs
UYToFFVuP88AwnOQUy3GYAObNd2GTa/D0F0eNdkr8I4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10264     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_xSPI_REG_FIELD_REGISTER_MAP_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
EiunIwnK0UvstJ7GOx72NYtLaEpU9tVV/3uI+kepl/71yNiYuiO1Dl0fjx/I7JDU
nwNfz0K+F7skXMvKcao9gTZQZeU9Y59cypytVm0KJKfu9GC8lVrGqM7A8MjITbo4
fttGQqSzwkMizOtnufLpv6NhQ5BggR/GvHlOVxlUFwE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10347     )
+8EyC5tAbsheWS13K+zgZQBdYH3TyabCgVNGWtiHbEygvYx2BIwgkljh/Lt1WkGK
ZaVeYpmD1TunxRvKldwdji2LG0yImeq82tDEKnZZN1FDWZNo/uOu0qCG64DMI6Rr
`pragma protect end_protected
