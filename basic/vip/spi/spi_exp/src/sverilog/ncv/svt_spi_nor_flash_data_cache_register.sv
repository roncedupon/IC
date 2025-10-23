
`ifndef GUARD_SVT_SPI_NOR_FLASH_DATA_CACHE_REGISTER_SV
`define GUARD_SVT_SPI_NOR_FLASH_DATA_CACHE_REGISTER_SV 

`include "svt_spi_defines.svi"

// =============================================================================
/**
 *  This is SPI NOR Flash Data Cache class. This holds Cache and Data
 *  registers of NOR Slave device.This is instantiated inside shared_status
 *  object for Selected NOR Flash device. 
 */
class svt_spi_nor_flash_data_cache_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** 
   * SPI NOR Flash Data Register
   * This buffer holds the Data read from Memory Core
   * ECC operation is calculated on this data, corrected and then pass on to
   * #nor_cache_register (Cache Register)
   */ 
  svt_spi_types::word nor_data_register;

  /** SPI NOR Flash cache Register*/
  svt_spi_types::word nor_cache_register;
  
  /** Valid bit for corresponding byte location in #nor_cache_register. */
  bit valid_nor_cache_register [];

  /** SPI NOR FLASH cache Register address. */
  bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] nor_cache_page_address;

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
  `svt_vmm_data_new(svt_spi_nor_flash_data_cache_register)
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
  extern function new(string name = "svt_spi_nor_flash_data_cache_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_nor_flash_data_cache_register)
  `svt_data_member_end(svt_spi_nor_flash_data_cache_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_nor_flash_data_cache_register.
   */
  extern virtual function vmm_data do_allocate();
`endif

  //----------------------------------------------------------------------------
  /**
   * Method to make sure that all of the notifications have been configured properly
   */
  extern function bit check_configure();

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
  `vmm_typename(svt_spi_nor_flash_data_cache_register)
  `vmm_class_factory(svt_spi_nor_flash_data_cache_register)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
1JM9KsBoy7O3O8fUcs5kWP09SWIx/Sj1Y//ZR4mJOVcskMRwdc4uzkh/2ReyGV6G
+bWNfSm+EANBo67ycH0dX5o2EcE1XkHHfOOeQKHXFiCRmE0gYkemzyApZyMXQRAq
n0VyYd6VPuSqKahdnIhBwOm2rbyag+SLqquW/Q0j2p+eHliklYW02w==
//pragma protect end_key_block
//pragma protect digest_block
52IJ1+RdD8mrg3g1Aj5tqbTsx88=
//pragma protect end_digest_block
//pragma protect data_block
IsIWrNvOlgLAP90PScsF6cmUWYK/vkcKZ1O3IOFjrOmKGZPVtNnNThZZvHItIMFx
ldbssv6x2Edy7sY1PEQ/Dd2Nly+E4k9gMLmnslyw478gyFsX+q5TblHqWRYvPxN6
3SG5WESJ1h+6G+TVxJx6PQIKKqoefBVZGSOT0bmlWX7HwUPXrCPdK7ENzl87/TZa
W57dE1oOz0ia29zRszzjyjRp6K59XwdCtw5SIpEFG5jJO/67Fn+2tvvoRVMKlb5V
PVhxIkP1tnDj2rgXC6aPcNvrWlkkWM3OCdm6hQjg2kIUhaE2ts+Eq4fusQs3c6Nk
AUCkMXt52sUpjC+46w9hCYhxHiN2ugyUGeU/eZpB30M8/CbEOTA+/J/Qh21FRJu2
C/ro2wYV+6a+GX8FJO9u+cnzimVLGjlSLmzF2d5H8saHcUMzgrSmLOPCPMNuixoG
Y6onU3OV2fiBS/VqVQMDvXjg6N6j7tG6AOvqySOcZqdxxVYMTr1S2dOaNQQanQnt
llQSSC+IW9IqrwRQMiU6DBttlko9iwMHWHiorLXehZAWqRCegFmCgEGPzEMNVD0p
jF985pEts/QF552jy7tevPUowFx6wTOzdMs+j5vu/n05VTZMNfzLbIjdYHaT8y7i
L6kKt5nW+G0489vhI516P8vMSCWeJKaHw4qh0n8h/c71pXWzJAwH5b9BcI85w/gI
cfQPRO1PNn4Uq8YgpRDWju7SYjZ2E+97vD+d+e+KW8GZzw+Bhouxonu56Wzm0bPL
loRqrCWRGuX/7c+fNqdtcExcaeS84ZLzuMKauvwcmLAd4VT9c1N9bOmWjCyoGXLe
eZqJO+Zqf5LkOvZB0A7WlRwOz0B7ZT/MBjT61MV4jumnGqFpIpHHYVcD/MH+IbzM
QkbJkkQ+Nhr4QpifyEd2Zo9kE19gqizNMpPpJ/cYmRZTvXMBc9hDbz2rZgf1NNNH
yf4a9eHFH73BmMgjxOBKBQvmf6LWPqvKV/aR7qt/TQ8Qp61Zvh7Vi8nA40B47Dq0
trU1uK2KwKR2+4Ndxk6tLkEKwM6BsDaNGB7d3btI5gG3uWl+5ZzJ/l8HHJGyvBi1

//pragma protect end_data_block
//pragma protect digest_block
eDdaiHxDLLIYTj524e+JRl3GxBY=
//pragma protect end_digest_block
//pragma protect end_protected
   
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Ly/rhWLONW9RhqtpxVSiYNTTF9cCAx72gVhTJAcCUPvuzjL75TwbIRrh/bCPwI6h
l/yOnukK/zsHFt4RyN1A8TBUvqU2TVVmaM3hDihOKY48jZOdLgdxOB1sfc4Or1PA
SdTPQ1/eirVwvM9on9ajs+RpQ7A5h0fJ8FgVNA0m8l21wsDM1oUQxQ==
//pragma protect end_key_block
//pragma protect digest_block
n9+4bQz2RFn4ZDYQsrSP8QPnuzI=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
yKacpSgBhu1j7jwesJYJC4uIn/M=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_NOR_FLASH_DATA_CACHE_REGISTER_SV

