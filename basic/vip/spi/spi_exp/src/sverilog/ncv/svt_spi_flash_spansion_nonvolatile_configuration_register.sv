
`ifndef GUARD_SVT_SPI_FLASH_SPANSION_NONVOLATILE_CONFIGURATION_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_SPANSION_NONVOLATILE_CONFIGURATION_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP spansion Nonvolatile configuration register class.
 *  This maintains the copy of Non Volatile fields that can be stored/reload based
 *  on requirement.
 */
class svt_spi_flash_spansion_nonvolatile_configuration_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------
  /** SPI Status Register 1. */
  /** Used for enabling the function of Write Protect Pin (W#).*/
  bit status_write_disable = 1'b0;

  /**  
   * Defines memory to be software protected against PROGRAM or ERASE operations. When one or <br/>
   * more block protect bits is set to 1, a designated memory <br/>
   * area is protected from PROGRAM and ERASE operations.
   */
  bit [2:0] block_protect = 3'b0;

  /** SPI Configuration Register 1. */
  /**  
   * Determines whether the protected memory area defined by the block protect <br/>
   * bits starts from the top or bottom of the memory array.
   */
  bit top_bottom_protection = 1'b0;

  /**  
   * Determines whether the BP bits defined in #block_protect are volatile or non volatile <br/>
   * 1 : Volatile   <br/>
   * 0 : Non Volatile
   */
  bit block_protect_non_volatile = 1'b0;

  /**  
   * Configures Parameter Sectors location <br/>
   * 1 = 4-kB physical sectors at top, (high address).
   * 0 = 4-kB physical sectors at bottom, (low address).
   */ 
  bit top_bottom_parameter_sector = 1'b0;

  /** 
   * Configures the device into QUAD IO operation. <br/> 
   * 1 : Quad IO Selected   <br/>
   * 0 : Extended or Dual IO Selected
   */
  bit quad_data_width = 1'b0;

  /** SPI Configuration Register 2. */
  /** 
   * Indicates whether 3-byte or 4-byte address mode is enabled <br/>
   * 1 : 4-byte (32-bits) addressing required from command. <br/>
   * 0 : 3-byte (24-bits) addressing from command + Bank Address <br/>
   * This also depicts address_length for S25FS_S device families.
   */
  bit extended_address_enable = 1'b0;

  /** Used to enable the QPI Feature  */
  bit qpi_enable = 1'b0;

  /** Used to enable Reset on IO3 Feature  */
  bit io3_reset = 1'b0;

  /** Used to configure the Read Latency values */
  bit [3:0] read_latency = 4'h8;

  /** SPI Configuration Register 3. */
  /** Used to enable the Blank Check Feature  */
  bit blank_check_enable = 1'b0;

  /** 
   * Used to enable the Page Buffer Wrap <br/>
   * 0 : 256 Bytes Wrap <br/>
   * 1 : 512 Byte Wrap
   */
  bit page_buffer_wrap = 1'b0;

  /** 
   * Used to enable the Erase 4kB command. <br/>
   * 0 : 4-kB Erase enabled (Hybrid Sector Architecture). <br/>
   * 1 : 4-kB Erase disabled (Uniform Sector Architecture). <br/>
   */
  bit enable_hybrid_sector_arch_n = 1'b0;

  /** 
   * Used to Select 30h Opcode for eitjer CLSR or Resume command. <br/>
   * 0 : 30h is clear status command. <br/>
   * 1 : 30h is Erase or Program Resume command
   */
  bit enable_30h_as_resume_command = 1'b0;

  /** 
   * Used to configure Block Erase Size  
   * 0 : 64-kB Erase
   * 1 : 256-kB Erase
   * */
  bit block_erase_size = 1'b0;

  /** 
   * Used to Enable the Legacy Soft reset Command. <br/>
   * 0 : F0h Software Reset is disabled <br/>
   * 1 : F0h Software Reset is enabled
   */
  bit enable_legacy_software_reset = 1'b0;

  /** SPI Configuration Register 4. */
  /** Output Driver Strength */
  bit [2:0] output_impedence = 3'b0;
 
  /** Used to enable the Wrap Feature  */
  bit wrap_enable_n = 1'b0;

  /** Used to enable the Wrap Length <br/>
   * 00 = 8-byte wrap   <br/>
   * 01 = 16-byte wrap  <br/>
   * 10 = 32-byte wrap  <br/>
   * 11 = 64-byte wrap
   */
  bit [1:0] wrap_length = 2'b00;

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
  `svt_vmm_data_new(svt_spi_flash_spansion_nonvolatile_configuration_register)
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
  extern function new(string name = "svt_spi_flash_spansion_nonvolatile_configuration_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_spansion_nonvolatile_configuration_register)
  `svt_data_member_end(svt_spi_flash_spansion_nonvolatile_configuration_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_spansion_nonvolatile_configuration_register.
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
  `vmm_typename(svt_spi_flash_spansion_nonvolatile_configuration_register)
  `vmm_class_factory(svt_spi_flash_spansion_nonvolatile_configuration_register)
`endif

  // ---------------------------------------------------------------------------
  /** This method retrieves the value of a single named property of a data class */
  extern virtual function bit [1023:0] get_reg_field(string prop_name_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of a single named property of a data class */
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);

  // -----------------------------------------------------------------------------------
  /** This method returns the value to current Non Volatile Status Register */
  extern virtual function bit [7:0] get_spansion_status_register_1_non_volatile();

  // -----------------------------------------------------------------------------------
  /** This method returns the value to current Non Volatile Configuration Register */
  extern virtual function bit [7:0] get_spansion_configuration_register_non_volatile();

  // -----------------------------------------------------------------------------------
  /** This method returns the value to current Non Volatile Configuration Register 2 */
  extern virtual function bit [7:0] get_spansion_configuration_register_2_non_volatile();

  // -----------------------------------------------------------------------------------
  /** This method returns the value to current Non Volatile Configuration Register 3 */
  extern virtual function bit [7:0] get_spansion_configuration_register_3_non_volatile();

  // -----------------------------------------------------------------------------------
  /** This method returns the value to current Non Volatile Configuration Register 4 */
  extern virtual function bit [7:0] get_spansion_configuration_register_4_non_volatile();

endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
5e40nOV0kvPdQgIAbQNqKnMfGPyrjzyubPLz6bIm5FKuimpJgAp3YGfujPEINVkI
ThK2aNQvCLa0eF91nw9fBdRi+gcbR8xuyxZTDzdjHnGSvUBVXsnr/NfCALoKtZ6S
jdOknj1dOFdP7/+BF0Q26UOUP+Id5Pl5SQLv8/sF2BvpiaHCwp+sjg==
//pragma protect end_key_block
//pragma protect digest_block
W1S9T+UFQa1QuLwbu7HX8sMiICk=
//pragma protect end_digest_block
//pragma protect data_block
PYJVUS1KO60Yx0r79kBwo0hfXtXoLg+AKeWXCkvJmAS0BQ02HrqcLQKYRFy4WbI5
gMtd2qqLXBXMs+cXZOGnkd+JRtNvTEfPw0j+FAF1OqXikaVq/za2WNa4Ygtn8Rrk
LmQglJ/eleT2RdMdOv4Qn4jgABAoF64bcMFwdO5b7o/xYJqiZpxahoFmekZubm2v
yIAlvvoiHz/VPEFp8Ipdle1WKjV+ZYQPgRi1F0qYrMIu08hsx6Vwo2qH1bg3K+T+
7o2tgIqziL/HVWoTZnN5gxhmcfQYOskGrs+pPah+31c7nQjqzSFT1WgeblVUF7SN
tM5homxmO69+SPqTGT0Gpw0YezAfoIJ8QrHSPzYqigQJPE/zMOQVejjIzbFmpH4f
hVeg96FzlnzFWnOeX/yhnKdmmk5S8SSluFGTqY1ECPpGHB9StgSafLmbLRmjzX3s
zKyLGCXLjkuZgMw7qxqFLqKxdEtwsk5TcWWHePDQfzuUnRFuMxKAbUjI5r7+ajVQ
8YLy4/eYPL+esPfFlWAlHecPx8TO5CFnOrYPX4sUwPJ3bLX5AWFfTl7UZCCV0bjP
K/BNDQ9hgW0iYO/az6zC+UkUf4++B4vaFDgUljyDnywORnAwj01ypqpwNgv775lA
7nOM+DSZkmNBS5HYfLooZAMTysOuNs+9D30Oe+hYdR2rUal8yD3BqcmaO5VOKPfz
Yqf4HW9Of3L8MUm3muOuOw55JWTOhnt6+s01NAzBwq5QJdXN2CtLHUuFnGJrpFD2
pTAo7PQhPGMUNJgoLw7d3fjzviLFtwj7nfn0Cnosy9Cr1OLOl+e/YW8ZNbZiOPuO
Vajv7c6VhdvvqnUUqNxQbiZiOtn9ro3FQIc5i4d8SzqRv8W8L/D8N+6u97W9XGsY
f85OJIezYqw3AKdFK/AINgzlM+2SfTW5rN/DZbkGVD7SJtRkaY1L3Ngz6bpbdfG8
TT5dtgWKfe+dIpMQzaMszNtUS5wWwNsbTFWPNnI2a5MvND6QbIOMizZ0IbgtewiO
3HcpzrOVRKaLeVkzdyX6d9RKBNUJyscCIpv8TM7AHSX3REmUSnZliVp51MJqe5nn
O6Ni5CCA10ReR2bxJbJtN6Zr1QbQe2GtdokIftjLGJDjgFaAaNJzqO/kNAN0Br3o
ZdVIRQ9k0dvZ5Y/D5hYM2wgHOmtyqGxrYb+1rLx8p3s=
//pragma protect end_data_block
//pragma protect digest_block
WaGZUZUm3fojwi/Nhe3ivjmVb1Y=
//pragma protect end_digest_block
//pragma protect end_protected
   
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
uuI7Xsd8N7SDX8foSlURmdTAiJWINsBLUEZ2WRaam0T7dhQAk9mv49COT1ny31o/
p4ipxmeL8bQOC6UrY7wwwVKsw0XxnmsXjE0S9uCUlsxDxPrNbX22RIenRCnNnGMR
pb604x/nLuJyqF8UPYdZ9QcEKeFjBOlQqwUbOmsR3+0cYDwKJmSu4g==
//pragma protect end_key_block
//pragma protect digest_block
2r3Wmi873F2wdIeoT52Tl6k5Fb8=
//pragma protect end_digest_block
//pragma protect data_block
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
tyMB15OzQZI69c6mTVRZ48br6QTopzYuNw7dJtCPnKYEYsxK/E7JwJsu8B/qZkuZ
SIWVW/y+I4JxUgrf0lvARwBTH+JeunayLr/6QR7aJ5OsEQCxuIda+9C94aXUrMTM
BEvo3+PFX/0GAGd+TTitWyox5QqrhoUMz4JXrjaDqiWkgqtf/yu6Wza/CbmSJ/qe
TmJGbyiREnCBEcys6TLoHq3REDKxvOP1TeqI7QD45E9+JpMFGJsfuPBHVFsORqdo
sRSQ9xiGE4V8WZ5B4rubuZoTdtAEDEulHd7qaGv/+TtMf5Nhrvp/UJU9Pq9ZrvX/
XuIKyDk9/Wy0GnIDm2thAw/r+4EFnZQnhsdmY1OZSac92deW3B8e0Cn/nrfCyOol
VoFiN5gCAZSpIDFnV29U/LmLDjG1hx7W3Orkh3/M4SqLX04B3+aJpPcbOeBi9uO4
OIoUbQru800FczGLWuyVm1VO2j/5dAtIaYxWNDceLeJGdd4eIqrmsNCn1RpqFixm
nndaZg8uH0kr0cZffannjzp3O90iXoPZYNCgtg4e1l9ELCQq9EjU2Bx8xePyxrIP
/YLipQpxVs7/tcyFlc+fV3zdgsZ5Vp7HAKDslO/bObl477Vb4ivcuYVuJe8mYdkh
T1ZMkCiuQg+DRY2QjXF7Up3J6hRuRg8D2j/aDS/j1cm7ASr26lXdjnYrklJBxzvz
aI/AeydEEG41PQeXLzOklD2IqtPQOtr1w8M5haTSF/GDL4Q97+p6JgvlcG8I9HI2
VwXTk08mUSQqtDNhelQEFwaC8UiDvU3nNPd0cIPx6WVcpBobRh+EmzX6LlntbsMJ
DzkzYYHf7LhO5WxZ7h5swOStmhuh0lgAdIELwZ8qesURIRZQ+QmnTAOHdP79wf8h
VTAlr4SG55FHNIc1XbCvDbdRWT6zaDcen4GNWoJA9KaOtkAwwpcqyjObly9dSmvP
frEazaq1HzPoLtDgSzjJUD1TjKQebyscKGLgZTAKWaEfjGdUZrRPgqBMIw2LF1/E
IKWl2rMgr8+Sfujo1edNy2OGQX3RXCS7TIjMuODH8tkvtsOiKclYcXyKemxxd5+G
c+yofiIWtuRKVK+fCW9kZ0A3I/X/cWqLsQxMsQrfAY8urV/s5hcMq3hOhg9t2cOY
+5bXnISlgnLg1ivmp5RuB7Kg8YZezbiv/rVwTkh24VIv7obBNbnEoSX0cqKLb6TH
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
//pragma protect end_data_block
//pragma protect digest_block
JTI+1UKPWzdK/A3PnR05QUwX0I0=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_SPANSION_NONVOLATILE_CONFIGURATION_REGISTER_SV

