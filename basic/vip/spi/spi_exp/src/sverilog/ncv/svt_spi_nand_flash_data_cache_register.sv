
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
6Y8YSNDoVz/Wed3KOeH5XKxuA0FfVrVfhAmQB7usvYvb1FAYtVxBUmj+1fmGI5co
a78ufQde+xk7mqdqpQ9Co5zR5uLt9HZy9/BxVX1ObpVcyzJY2y3FZUbWIUmKlXLt
nBjwBmzbTa7E8VPECeNmZMUMygtN3fcCpHbGqJNXB2sF3KWWq1nxdw==
//pragma protect end_key_block
//pragma protect digest_block
D+X4eIWLmSXs7T5IuNCop94ufps=
//pragma protect end_digest_block
//pragma protect data_block
rP1LSbs+xM9y4X1PfPaZdRfPpr8LbI4XCRvI18QhtKWTpi909i+daRWM+Gaq5r/b
G2zCgQIRg7Mi0GnyOh3dfIFYbYaJq7paoOidvqv1j+pBtmLaCs+yim5rXWSPIJWV
ZD8lUi43yfScTC2UNk1CAF332Y4BBj8ClRPR1NyN/fwA8wyKCrZ5dQ3Fv5O2qYFL
VpjLglV9FWRADy2QCIR4eOnArUU4HoLQM8s+RG1D3zfTuhIe1DZgBLyoxxv9Y4dE
Gdu0TAnp0lt1+kmTsq0/EHXy+UqB0OmVQsc7XqJu/sWKaYkmG9komkxL71qrAnke
fjvGEQwnlAKK0XdqN72grn2V/8fGimK4wVIOyT3EPLUuZVsJuflg8hNUklzc0bMI
SC9VvwmDcElxzxvpJcFxjhIGNowo7QNLkQ5NUt0PUA6Q+blvxx4JQbM0yLqaIIoR
zIbjn8Aeh0bMDw3CstKsx5OIjhZyi/FeEYaNmcOU/kDRTp/F3NbJEv2eH5zOGX/G
EbPhZdZwefWKiWo+oIdphOWVbyL8mcmR000UJIjrjoxS5VaxtO7zq2mxQ0Th9l1W
hbVUXpazHoCtHoHYaqKKpN+jK4X/pg2MUjd6aICBfduut5sc4b6C1nUYkXF4sfq9
Xfi/bvN1sFaJjFcxIstptGZ7IH3BIUptiDIU7ecW/jhohUm1K97FcwHbC1PVdFmw
dX6cm8jaZivOyu8hrB4a3Vls1gDoiYqc+B6AYsm4lv1JQWPlRtLSVqSTKJdE/Qfg
KHC4UNNl+56frUV7BcjFxbr3D2Iu+qNo0CUcpf1N0plE29vGlqIOtzQX2oK95xiV
Krsgd3t+3/VmHNqNCOKoJRryT70bePdO6B+zoSdYHafpWC8xSWulrjQhZT6CYQoz
gFyUuhf8667kNViaQMaxugWLIo1GyRIkK0a7vQx9c3mgqGaBbB/4S4TpLz7/zPo5
9eHbdlEQeua3AamYK1ohqPfDRzBu5vafzz6doRtp8p/s0zE2XukM2L3Dn1D4d3u1
IWu/kOmEanHpYzjef0hvy9WeDnYTvn84if8wu9cBKWAyCzIzdb2ZCe4RNp/wWdul

//pragma protect end_data_block
//pragma protect digest_block
ChtbeZrxw37hX+laDvzdN1aYGPQ=
//pragma protect end_digest_block
//pragma protect end_protected
   
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
PIR3FUszwZqrIWnzaavA2/m5x6+5Sl8KBcLst4XyrhHgz8ddS5jzfuVWSOer3AZA
Yjr66kYiK2ge7n/HmzSB788xdocr05ObjOwob46ew3SAIj52Hadl/wzLQvsCQ7ws
pyjH1bMH01m7dw9RqBtDg5mi2jhpBJiFREFNFMXu2cj+jL9xxXydYw==
//pragma protect end_key_block
//pragma protect digest_block
kG1fi5gLvvq2121hc7V+yLh1vTE=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
cYffXf4cODuQv10g+rwS6C48YYU=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_NAND_FLASH_DATA_CACHE_REGISTER_SV

