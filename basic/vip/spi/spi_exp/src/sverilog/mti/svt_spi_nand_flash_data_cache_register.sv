
`ifndef GUARD_SVT_SPI_NAND_FLASH_DATA_CACHE_REGISTER_SV
`define GUARD_SVT_SPI_NAND_FLASH_DATA_CACHE_REGISTER_SV 

`include "svt_spi_defines.svi"

// =============================================================================
/**
 *  This is SPI NAND Flash Data Cache class. This holds Cache and Data
 *  registers of NAND Slave device.This is instantiated inside shared_status
 *  object for Selected NAND Flash device. 
 */
class svt_spi_nand_flash_data_cache_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** 
   * SPI NAND Flash Data Register
   * This buffer holds the Data read from Memory Core
   * ECC operation is calculated on this data, corrected and then pass on to
   * #nand_cache_register (Cache Register)
   */ 
  svt_spi_types::word nand_data_register;

  /** SPI NAND Flash cache Register*/
  svt_spi_types::word nand_cache_register;
  
  /** Valid bit for corresponding byte location in #nand_cache_register. */
  bit valid_nand_cache_register [];

  /** SPI NAND FLASH cache Register address. */
  bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] nand_data_page_address;

  /** SPI NAND FLASH cache Register address. */
  bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] nand_cache_page_address;

  /** Specifies the Partition Index Updated by Program Load/Program Load
   * Random Data
   * program.
   */ 
  bit [`SVT_SPI_MAX_PAGE_PROGRAM_PARTITION-1:0] cache_page_program_partition_access;

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
  `svt_vmm_data_new(svt_spi_nand_flash_data_cache_register)
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
  extern function new(string name = "svt_spi_nand_flash_data_cache_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_nand_flash_data_cache_register)
  `svt_data_member_end(svt_spi_nand_flash_data_cache_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_nand_flash_data_cache_register.
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
  `vmm_typename(svt_spi_nand_flash_data_cache_register)
  `vmm_class_factory(svt_spi_nand_flash_data_cache_register)
`endif

  // ---------------------------------------------------------------------------
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
F+/SOCRI/JT+6xaPz43X4AEGBr65Z2S1U797xMXBE8i9KpogGgJt8HkeeD/soCwJ
YIYTPs4fO3ChkFYEpokrGoKSVWoAfE4NIvdD/4F/xHyBezKeXO92vQXgSIbJGIdb
dpnRPVg5ELJ5fgXS92MoiZQU/1h9Z+7jqRaRTlucjNc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 649       )
REi6QCwjm9ZOiKxke4lsnLt4pACYjTUFceL4Hw4OLrGV9VsSapiFG0lSGEISeyPx
haYvwwvP/vxFfj0nqdGgOsD1pSzm7UXCxi5ZO9DzzlRl9J83/RvHQSc8kR7ez3nl
mp0n9GW3l56kwacgn/X5jD3sUGJjSVAmoX5uU7JnJr9kDz1fJtXsyuc0XKja+QfO
GPJ52QVohN+w+IGu7lloUewrAXR+jVAIeRMpnrjA4Yt3E5ZveLvwFrhD0MAhsP+M
rWai4k4b+iVYTHbEuGKpiQsM922R67UKKgviC5VRBeNEty13dgRrFsfRl9wRvfJm
2aSeAlwnTW+RWqmhp6q5cjkerM9v+JE7pxUqwjKIEZlf85ZO2A+cf4AUUA54Mo4R
SldwLG3oG8AbQhSLuqReYYhxuCfEAMR9hGq8qszIy4pz1J/Bcd7WVxQpEh4Ax6qR
ILeOgbrDzN4m45dBePVtCD3jxvjgyvWGVT8TwNB38yTZ4uc3bh53Dost95oSByvl
Jw3q/3HB2ksVHcJlr4bB7QRCiSOUyiD+g0xSkfUwe+gyvxC5sjLfyYQQzVQCMa86
fpNTl5cRAXel2EM963Ie7gZvXR4e4WyDvp9wW+blV4USOcRhkKgfkD5VZAHN0Fj6
JZ416yjL5QM+KzHt9i7eQF1R0paX9YZkFgAP3cJgy9eb9eijJ0SYu3vDQyOFiRLz
a1NvSPpRByc+R7ed1WxWGDhKNVORhiYkrUDS1yvwb/NAYVmFCtGni/zhg9+K0Wcv
Qc5gkXvqBSLelG/qxYjdyE08WsRkIcg9cBRYgRhuFoDF/9icnZJNppIgHTizhEIh
LeGsA3Ucb8hTk8rl+2HkxTucTeDRIR9aeMSLpRsi76s=
`pragma protect end_protected
   
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
cM8oAzvb4idfxn+eC+I4JD3sSr6AqAsdWglBtCiiwBCxcUwP2Ivhxbauy8SVgugj
YfOz/lqCdmtGKL2oF2AGO5YuJjcpYXOJfWaIoazMPOYpkdxpf34O3p+826VylpJa
OKFU9ET/9zeFe3ISp3MHE1zK9StEqTU8YIosMuWHl1Y=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11175     )
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
SD8rskg+4kf3yX52rhgfsxiIonPEjHtpkdP6HlPiYGZ+jvTAn/7hXwPzrhECZPbj
leFLFYXBXO9+5RYFLMM3Ua/1vlDaq3GWngfbloy9kmkQ5yQc1xRavqkff6x4hMsJ
8zE+WN/e4bq86WNeZnndQgGzUVwrr2SFQtU13OMYfRa2wuZIzmbFxswTmcWAKJpl
cA06MDMW9xjgA7CZX08njXHL4oTObCNRpG7yGqRth910grbvGOYdVWbtpoUYRl4N
IkO/yu7EiE3HMGvVWoRhN+j/HcPOvFPAxTSVg3yrt2+1DM+FA3fvLHm6LSFnpwcI
gSkDC54ABpTBd9yxMQqGw9S9ttZXQoeyaYPajfSTPwGU47TMd+bJ8Ax+4D4KD9Hx
/L5dS9R0Z15GR4QUT7UYAi1ghlBbuzygplOVmMvronrXF27aubdgq/pc61MOBMr9
/l+LGgiXqTILF6PdZqRsKzTzT+Nilu/EyHJdDAzV9PuGHfXGLYzjTqSYhLJzcNfk
OFcMF79tv+jqwzjublLLav3RVyMIqglHeAFDF/zmeTRe0MfW9k6RPnwpfNABRmKv
Yvr1SaRpfmg/h8w/rHN5UsvxjoD/3lXWPEnwInPlCcNW7Ar79Eg30dYjV3vi5HwN
IcQacZkKYFiKf61rZBboNA==
`pragma protect end_protected

`endif // GUARD_SVT_SPI_NAND_FLASH_DATA_CACHE_REGISTER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
U20KNFf1FVBE1ohQd/DCr5qjFPxrLyymdqMKAmGbxixx5OJxkC+6smOctky23jnB
zW78hdXQYK1j0PQsY3pfSnKYoXPI7Wf4ADibg4Q0U9ONhePm5CplOg9RhDdsdx8T
hUOo633y4PMx6qRqXdaHojg5uZ0XCpMWbKi+QrbgwwA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 11258     )
KI6PDy3SM5XCLWE0ECCfX8wa3QyHRnm6h0UJIXIdnfivksif+Hynwf7H0qJ9hS5S
Ero97ezwyignwbKP5Xx2CWscLdIrSi2Y9rHbZ3J0G0fffbckEW+XCd/HYLrxzL8T
`pragma protect end_protected
