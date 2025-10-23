
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
WS4laO3/RJfp/N0Z59ndDTrTnXtLvn4xp93iu1diTikQ/YvgRzVkP4uk44dY0CDR
45bvYRVmt3trnJf9Svjn89oDOUDQSls79yQ/eABVznCVCtW0730RT5e8sr6hosaQ
spqKU932ITtjwCC2i0dtYNd+B1rUUKPItWSKtLoRSs0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 722       )
twOgOmbrD/M9GKk/4mvU9WQQ5lC+oIjaPu40dKeWzrXHqEcmRFfJg514iphscVjw
UNHH7kDw0Rf5qxJxhOzPT4hqtd04W6KF+1kDuNKcGtO95YINaPnAh6Ml03PiZ7Qg
9CBkjLHSCcUaLu0pT2VmN8FAev1o3uqsisQT9q8qScORrsO5Eq8GQ6jopSoFCKvG
lK5a4ARyLyu/fuUNuJASxDuAHadGO2KuGOiOxRjifc98NndRhAvFOIZna7D3wzyP
hce6WZhiX7zke0HhmaTuLIWO92uGhGuCA0wb7jcqQbUElBXcvSALTOiDamDceYqn
i9mas2iAfXWqaPJnMZpxWWjgAz97gv5UZY4Pjl907wn5xlqO5wsc5bfWuuMAc6Fd
+y3bJycDK7y/WHrfMxb4af5c4Fq4bLVPYPIQ7pS01TX/KOJ3fZ4AtzbrlMONKXdv
psUnOf4cp9hHTJdxlC91zkTyCL/n3uuJ2s8MADVKzi1Rw40gHBr3k5wjAOZz1GyT
MJEnemffRZ88umAUe/Jaevf2SUi+h3d2MxZL6ARIxVTe3nsOkmHBHdhgGyVFw/f7
Le7GEal94GtoQ8Kx64lsWmnAztyre4dDBjiYNRNkGeG3klDSF9dJjsyv3EVt5+QB
B4YMbZDu5GZyi0j65AOwh2bMxZChPkIxz7tU8FqbGysvluiOUaZA5/bbXXNV1DLu
Po3FVCFnwJxKysWiKcAF+Bo1zI5Yd3ltqKMuTgoxjIRf/qdHHU2fSBdwrKK0+Q6/
KqLes/ynGkeIxXS+un2YziA+Dmd3PP9N5FlDmlAjtk66j54t2nuor4aVJw8k/i0f
NrcfKaMhbKmTK44Fpzu8f1HfdH4WUTJ521QNwVBvG6fhRXjiOTcQCg9RPwGfcOaQ
puLhOniiSlV0opEoXQss2XIHkpOkFuPrjC1eSvH8EVdK7xtqD2ktZk70L8U38rJP
hj+7x1ofj0IY40+HjRUaNQ==
`pragma protect end_protected
   
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
ViGFrVDadals9sE6othIyQ+3so2ItKKECgh2XDDZbE7ZNgTHrgdfP6WJYScr1I47
dpG//Jor24qSyPiswF+fyPR3HFWVLjreaeQ4kVIc+/PIlKB4Qqqexy9Em7j/7bRW
yw9XG7sekH3GRrQBD3eVHOabkorwVbtKqI7YWMKFcy4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 18725     )
bbFnm/tSVYJptZC6R5occ/HQVM45xwjr4HeD8HFHBv5K64W4JIsVd+sfr+3dupTG
ZpNAHociJxhGLmYfllnxAC2i4slcBUPD6oO5puDiPh1clOSxPzHz6B63+ZPojbGT
S3Al/Ha19wI09LNiuJ9Tz/PMdj3sNPaU+UgxOqwx+tSwEc4Bb5s7rt1yrTQVYeN3
X74DFpy7mkt9DF0z4CVlIRTb1dFooQWoHx+R7niMtzKXgJPo7llH0fFL3OIWalJc
6TkiI1daCyEHQiwrq2jf81WrLALzAqvQGGwHQvkqmh4eTOnN+PNpmp1qnICyhqbY
jEiMeftfQHLCZRBAn7nfp7HyayvEc9iAoYdEMYJT6uXHcp/Vk0BZs0McnTR22GWC
WYlx3woWHRxrnhrKp2kwz7oMzQ/HwhTxZ7JBiCwLDViEvuerEN3Vjw1EVY5DckzF
HLh1OY5tdsem64bKDFS8HZTqkrbA7Gc6mgqmv8JyOTvLUAFe+taHVeML/fkrdLIs
qVJTEh93tBstZYTG+zJ7v0Ifof5AqLaURaCDVyigDXlOHLpfhH7kKD6FBLtLHZvo
AHEj0uqdm+GBvZQiz/eKBdTBfvi0KWAslPH6UCXJwyTvSzg5qU+jCeubQwG4Si/4
uVpQt78/XZ2ZskPK7dsIZLGRBtYbWqo+ue39YbSXiUAdZgcPiNkOw/V+gNUcoO/f
hzQPiLWMAxFPktJUStdRcMzksgAuh6VkUFHOShd6tOaDTHdS15Yl6ukOJHiY1bAG
hetNwx+Kk32DDM2pazrl6qVOtdzqcNYjJJbf/dbZWaHiQqH+CaKoH4mPM9THsJ0e
SPYtsz3ZmVK9KqvtgMho60gFrZVp13n68iHIiE7zKNQYtvos9Qv0e+U4Hf4NdJDL
IjPC1NiX869ZmmPT+lzg4oEbwjqbWrXANM4TIVbtDeNm5vJH9Yh3b653aNyRbKGq
reqIRf0w0+NMW1+9eZTDOXIc2p99TWw435Vg4MTdMQYb9OeVrib7PzVpU5k9xkHo
P50HxpK66EF4jq1hO+6g7tYP4ER+59BSwzN/Sg2hTNGIbzzBlznRGg8G1m7cP0RR
q1/BpWaVklrO0gLpIkj5ZS8oBuvF4C3qFopEHN6AUytfjQEyKhDuC4mwCUMdZoX4
elY0zS664YnWlCVoXH83OYqsvn0rZPdR80LHcAsHiZUFM1OlzNTziJJI3vGZVNfN
L84UykSIPYsUvaxf5JeUwDDnXxhN+UwQ/ugUNudbBw2tGtW9cutw/OcrMzdZ62pj
nr0J7fsftUVJ+vdCqL+UBHnQMH61A5F7oa7IU7d1krK93z6NcFQf5qVWOehZKeG2
cP6JCZBi/tfQ9pBcFavaG1/stcvMGLkPIx73pZV1cI1aj6bBnXtBP2YoXe1mwFXC
2LffX9muy8Gc28vdwXRAcnqOBhwEq55vDQGAAcjUcHdkVztTn9kYfBJpXBJQrn5x
+m35xi4jCtdG05U9ASWciSGP/fp0OrGe/TfZf4vitHEYOGLAdaQDiUk9zzMLzEco
WifijImfKn8btSZ9xKn3HIOXIKXtxGEacwIp9D2Tvzix0c2nIAVyu3hnbXXSnMc6
BwUrhe2juLgT9BFjvM5gZ2cU9VuoSowQyy20jkkA7pzOD+pv9CXABmGpMrsIAeDx
36s+GPWqVS/YS3mMoJRH5lSm0mWAmscE8MfVzqoXNxHuyuVQNCCmosGGaYH9iQAd
1nrvBmD6UD3SQBU17DxHF4lUXhWMA9mGFB+CyBZClXbjrQkwXc2hmSPlHF4tXZhA
Wt8nzgi7IFrBOpRN3Kpk2yJwfcgM+hvHCJI1zI5Z4EGMfM8HVurGqaiX3ES9m1Mh
C4a5yi9alLXzEuzcBRYnSdB+dyo8nTen9mjY6+KZo/pHV++eRgyNHYgLuTM0GD8d
O82ee720HLV0knqRSs0fTExuF8eRYnK5FPoFN39ChCNXwkxFi8doEz6fthOo0BTo
CDcNZcawdly0o1rMFlW3+hCqMJGjPEfIa8XqacYdb7V2UmkOQKdNLkfnG0z2ymCI
DcA3qM7lQ6UChq4A1oDpelCfjBeGy8c9KugHt6OJzGFXbSSkHlG9rn/EH8Y8SYML
iR/paZJVo+CDTLlYhQ8kffw33ZsleyRe41nMtnkAQDMVXalwSqDXDhePLshzDYQ9
DctCyhvEAeRDXm8VFEjm4H2PXlyXfkwqdc4JxXXtb8NG4hj8L0wa/SXE58Fv2Hjy
BvF8bbnKK2PmhKq9FYKeT408itpWpAI77jCXhs5DmhRA9oopcNTlkmJ9ab1tyeVt
QFsWraNsEirxRB34icwPiIduzOW7L6qUWk0EWUlq2t3mAdRFoEs8ivnE/9KXnb67
k2oI38OT3Hzl1zZCJxJf1eQYg+1xy5PwQaSRiebteJVz+km4Bgk6F2+JwYpcEQL3
hRJKljxO/dJi3u7RbsdQ4gJz8sUTJBX9Tjr5WZaUPpByTtJsp451hdIBnscFOnwN
saKwu1tv6XhN04qUwWR4dvcXgibQCtywHEBmBnTp1KK8oUrUj5NqZqjqPtXsdxUB
4JLGCtrvKcXLrGI4sZiHDNdQ1smWFTDjBLjBV0k5gwMDdq/tGUEhcZCF3T9K/CQh
sKWEJPQqJF+eusc7vA0RQdTMxbHpFMjJie1RHVEeZ6t1S/CgpPQNE5UnoPbJR/Y3
YiYynj08Jrj2AGZhIFEDq0G0p8seMBbXX2YiKu/U+OxJ+zxZW8Kmp23M0cVcVZQQ
h5rGs6oE4WmH8QIXI2j15sUvpatn2JH0JWW5NcvEtZqLEn6cQJ74hMIRCGZrAsoy
f3gN2GwTKQvnAf/IMxTHGhKvPOk6SgpAsBpP1M0P2TJekxh5Ld7kjjnFx8jr0Jy0
GkPg9Gd87MnZRWFk3R0/ZnXbzX9OOsEKzUJ1l35ga0119789EdJ8GPtw1SI6+fr5
8tl+SELW5iNiJm6b9gjFjVmgVek+roqXi5J+C7KVpBmh++tzgQkpL4ghnnLn9bEW
lAFTcp9dYR6POc7Li3jFMQlZyc65KYDLvMoOdFiuyTNTcdMqhCm+qNAvPKyMHMU4
0zyfS4ElXggLC5kxH/tE9ULtECoyBwJxpguyQmp852HHwkHz6KgaRq6MD3B0RSEb
+eEZcKybqD07IvVpeG9lfTkP11et7r/IoTXYVH2K0pV0uFKxxREGSJ829tZQdyaI
/qlJyzT4Dq51C/2NJYy40nXGNysOD3cA7G2D/Oz2pErW8ktg4DptaEIb3uu0PSOt
SlfQi6n1/QceWKoLCiC076wFqMYOl14H46lmStF/MRdbdoRuimIWgoljbdEbRth5
ad+4Beii7JBjwsfK9oBkhks2T0Iz2Rp4rvkQSvg27TxJUXJb6CYEbvWbjOWuigdz
5e/Zc93+jtf6wqzc4oarVDuIzWbipGqNgSAb+WQ0mbBRCvYCCeeXZjWYuaJ/+FFM
ooDy6ujuL48DLWfzqY2z/z4nh0E/c1IyTxIYQqLeTvvBnSh7LEaRpWbbjKe34+aH
qYJ4qV0/itnnkhV3e29FEOAzO5RNvtImhQ77wdVx6+mor9jyktJN0qOQI3xGoyjS
nS4ujSg7sM2bVhclfB0+0bnIeUK4s+wItrsOvBJ8fiR1v64SrvCk3hGE3VLR2p99
IjtjW1V1IgB48bOE2fTLncJZAbm/Bm2v2pSi/YG92Q0byi6Y1Dztn89LyqoqsGWn
USIR0VqHiaG2ovITSj/8j80EcT0LYVTTigfmjAf14AGHX1Ns5GvM85j3DrsZlRCK
wbpbSQnbSkxU++eNGCw9gadIQ/IwyCVooaJH6fTr4prHg1KpavHL8oAV58RyVyII
rfIjdGjsAueUTKvQCaJ1Xr1ZJKcgkZRr8AZov5qRjmyLyX5M5DdJofJ/loTcgihv
aacdR8rhy+g69szuAU7akZUqAZcRy+88bbpIZ2s9S7X54+4/rf7wt7JuuUpXFwnQ
uLfmijzUi3v9ASgkeghtj3mbQVUQvrhHF/TE1621WbWGPoKl0TKESP6I55Wu4U43
eT58Sf+dAxnRqlKsGYLuyoxaxReQE34WOWxlZxSBQnt6+SVBUMugVhwrVmIbTJh7
82utuhlx+RGs2hZskyu31kUvbRPXDMepNHZ8dmo2wfob8egd9F90zXNHm+GOI6q3
SVOUScIb6eNyYzkLgzYsz8OLbY8nMPKLUEabVGB1I33AJXQ0xS6MthPVZ2cFzzUi
MFOXcXmC5c6bdp4ShxHYtT1vh9pFZ6hrXR08UI+JuaVVSdwaVsa0svV/4gjs92nx
1orthQX+qH5z5VvTA4CB0lHAUeXCx3isFmcgHbpn6uxyVtnouPDxpN/tQlwqtOHM
JaLcXe3EnUYcfnqGUEMjbu2qaYTtAhe8MWB+FsrmPidNBX+/KuUrhK8FMW6oH3FX
DN+GTstmzAEjvbAp6adLiycBwqbYAKKQYrsL0yTmpJ8VNnl2eRUAZSfTSPWvEQao
ximVTtwfV6cz0LPsdvnpmJG3zrE+rqkxXtFVp6xXcWFdicA2vro3d8+LojVXwaEo
23kbJ4sqfE3DtcBFYqNLECjePbAVHyhsvUIedbkL7qOXg2Hkg4J6LTC8xx7Mgwqf
ixAPDiFXzTRoS4QXez9WOCHlvow+jN22gT4RgXoZI1tKPhNLUnwtT0PN3huofJUD
MMTLICsn2lVGPUagl5ml+jNImoakDb4jM9isgYNrw9zLV/jzSktAMp9fRSmxPXLw
JRUufAfhemKA/rVhyk9K2Cw+IEiiw/FqnKWqWDtypKP+TLu8L70hbrynVhZ9BHkw
ww14RMMO2ZVZdb+29BJiqPvo8XAKTTPj9MdPm6dgRowvnRtGW4ipr2z6YIHXMAZO
cdDkKM1q8BWpLOatStFh4WAO+L0geT7xsW4fyw1NsLks8KLacTdAOkN4DZtXwE+Y
emaX0tlvEF8yQUpLKdlopy70pynjUHE4hxfLLYUZI2CYEt8m4cUKk6c8com5TaF9
WNjtorjPDTX523KmlqoaHWoMJz7GwjeiKyBF6x3ntoqr4pOegYMPzcPzOwvUvxAT
B2S6X7PU0ZWzcGc+v+h2q3SC2Bkp99pWJXF1BgKAxZaAaGqUkXPW8mcdgz0qCWSJ
9Eg9Lh2LlKDB7gzV8nAc9f/c65aoqtOYbTBLcKRxpNqSX7+d2SRihmTcldmBTriG
DVmtkgMMgL0p1r6Nyl1uUumEJ+Y1oOIco8ny7/YWBqlT6iMChrVrqMBJdRZSsyJG
QhdQVhdmWNrm9v6nNArYvZg2+Jkru1CMdmTiC33dv8MtHp0TFTpXtL9w15nQ/PyE
dVX6gQiYEgiyGDmptIoTbON3YXHTsp+jBrncD8yDyQwjaRB64w3USgg6JwGTnkSV
HOsfdIsIrvf1d/wFat2fTFUtrniJYc6pxmt4pgGuWV7dFI2iSo1/oN1CrsPcXmxE
t1liU4yR5pCG727YpOnLonSTjO8ukCooZ0pxbpjpCgW+1/CbuRVMEx+TnSimaWRA
1yAlJjxXfYVmFj3AFbVjSIUDcke3wFVT/M8yqZpbGXwK33ZZSJhQcCqrgbUZULHX
EY1OzG7R/13dN/sDCyPeuu+MPDoMVk4vnl38k3FArMlqlOfW/oykOuoz4jE4qioM
FarehuTJbJRz3s8B0VnUIDcWIt881im+E41GvLxW0m9UoXlhDin2dCLxyBTCjdDf
kwdRoyoQoy7mJcJBGRyVT6Akv7l1ybIraG48TCPMBWpTLsfBmLQv8ig2EZw8yLKZ
O2pT10sFWp2rZfZUlv3tqcrFuzOaXSi7xRCfUokGND7E+Mw1kPzYfSEO6D3Jp1z4
r8GcWIawkpPPQHLaZMLPKxiy8mGbhhecETVtLD0sAEXynOK0HYUCiaeEoempHUlq
DvKTz7gxV0NR/Iknxz/JLjsDH4RJBY0JA11v7MCj9mHIdeQvIFfvyW9yHIPiVbMY
v+BP/B6ekUzqLKsS8ALSLQ4SRc3sckC6s2zxPc/x6BWS+peWDyHUpnPzi5t84XeE
LI9CkaEqY630FDnUEGUpYre5AmsUFDAswD3gAqOJauava3r1ylnBWmF30lkYJd16
aguH45QyH2BiesrsPsbGHoXIF9IO7dYFpne/BYjhOC8weV3akGSqw16UFucjUQkn
/759Ez5OGJd3BWoazghM0g8yM5A5TsWRZMh4jbs6Rw+Yi7tmSpjlywAyUe2IgTFE
dCsUOJtq/XScxmuxdokdd09dRnpsuNdRUUOgC64h5RCQCdC1150UInSoPd/wpbxu
H5bDiqkoVwIne6UciWs0Dkh7MAHnt1h5p6dJj2CHAnBJIHrwTzg/fmLWLUgsF2Gz
+jLyyIO7tRlhw6t349bUo4SBD6mR2GFGpG1YbOb5uTyukDE9HaPiDhmvQUd0YIAC
scSCJLZoDuWlEsKehyLjpwHSvOhB9bQ0VszTFJFsMudQTGqUqIrqiLQ/Il+wP29f
Nx26YjjYeYKBRsu1rjSf7akDk22b/yQ3aTxX72mSJTXMgUs9BjfJAMtUxZedM6kP
4cbkwKtoVf/WBM726m/Oi848USvDTuo1nm5Me30hi3vKpyzuBC25a7l6nFbKs/mL
bNdnK8cyomM7Tuz3ejr42yscbUo6rqmF5bVjxH64u+bY7WDyNqdl3JjsoLN6Ldet
Fx1rwSNACw8GYga2cUmCDODkNiRCGMjPy5irK11DU+pFOcq9i95G6MmoIJN03aeX
aBM/QLs4dw9m7oc6K3Ro6XYh9V+WtZNxx8oq1nwCGOMf2+YfP3cdHgCwo5BZJeIC
xUWaMpj0RCxZOhbSm0sn+RxKnNUwTmsGkd5PWqjIvlnqYDWEp4sXJM+JjDKgwMRp
owuXSi92GofwLmNtSjtCXMvukOKWhkjFQLS+RSseasOL0JzCKkSSUEKTnfZUvBTp
BsNtTBDTd9gFQDyObPYikO1LfqiXJBD12fJ9yNE/SgvZzqwMuQaJu1TyYSP0ej86
Tq1FptjwV2KYHT+VFFY3wx6FCPGb6Olh6ibLgqK5jnCy+wtBoXfQlbDn43J1ALtr
jedc8EzQnFPIgytUBJqC6aTlnCUJf0min3oeHoB7Kwi4Lnfhi6dNv9+YLwGkeqT5
JSjcsHFZtRoDAa3KFsHp5YVQIV3dZpr+nlnxlxpS5mqVcG3HQo9MAeNj1RdXql6E
Nhw6znpvPfUHnkNh9vw5BsasbRtjRK4lxc3r8QLp+q5GcVHKLLP/1ZurDivdhOi+
AAcaWZtuBjBfcP/eRBjrtU9TGLHIT3hchAUesim5we8OIh61/GFTrxzoi6N7FwNx
VoLNf3yQ9o9wYtbGu8FCJG1j99icBarPZEVk2XrAH5sWudm8rfAuFQNLNiKrvtJW
HsW+wh8pO0jQgGmG1WnR5xt1INW9lxFThKrmMLiamw3P9DROSrRjFh+siDR0BIhd
iMkLq0I9uP6W379WQoVHvr+yWq/6TObVnunF0TUJ9tNRnLF58UEqd7qnUw5Pu8VM
dYu+KWtYMCeSAG2OCF3QvFJJq/bHSzgsJDEhjiMkwkormP8Fmcc7g3NNumVKFkKu
hHW7XfRGnA3iT3MEiMy9s115nhcc5gfTsM7WjPuxom40wBmNQxUGdvMtcTFmMF4d
6ox1CZLeDQU26v9b3E6twasQgbNb3Z6dNPxOEgPrCkjh/WPo8KdK+ewczX1xVqtn
dHPrIj2OzKhD6HQ+HjKPiuvqKchzrSQ6OdMmCMp2B4I3NQFIGZoOfXgZD8iFOgib
LuSvx3bTZJlsa57ef7bRD0G+kwbPvgs677hRaa+UPKL8t1bjw7GXMN4KYLFGB44L
tFejZScVTZeMfkTLFlpSq35XEhALKtgzf+iFjVqX9Y+GGhcTljInFVmgNGfWX04Y
coMtwwjvhm7YeU7v3Ce33RTta8c/S1xooAAHvA+gwBy4OOgcOG/7wDElYyCa3+R7
SyvKCpKJwc2bBMVVS1U6rdzHbKEgUKLBCbTIq7IS6A2y0T2gv8hkJaKUBp3XYt7U
GSJglua0AjxrAsBmhPOPFwk/bQv+pwtswirFPy3GZk1BBqhTfp+b4uiQ3Rmp5++J
qZfb9b99Jnh5pdwPrFwXwk7aXqPyE0yQsaCzOiPLVEgtcf7jBDmUaXyVIHoWg1DV
lBMEtgGNSW9vWJ+F5AvccwdcP98Bs3Mw8DAbN8yW5tpejbQ9RYcv+BDW1buJipdC
Sn7N8ii/Kbohvdk22ToXL/CT0xnFCqh1FDXBGRHGkY7E+HU6odQMkFmxp5uGNr/s
2vQ0Y1HB9ce/YN/iZ4bues01XSI6DvxHNeQm/kXukMgHCAkDNF8KN9B5FLOGGW/5
aq3/08JgzhUByzI2gbyW85baAvPk/VAJaosxAt7ScgOXw4ioU7BR307hGyA+NIDQ
bRC/6w9gU4e4t6X7Kg1t9OqvCXjhZOr+ghMDE/5iIeCnNQY0wFeUqM/whC9B1hmp
4AawwdAu28l1gNMgLfacF36BXQBLRc1wc36cRSId7GEKXptiVhlNOMyvtV8y50cX
A5O1jsV9oL+HYHbp2Ft2pbCerbeRxmKXUIyeTtPd1WeriRolhvaCCOKK09KyzSt0
eqPLdpNdCHYxo1INJDFaj9mr5008rMnpz7yyOrlyociwbEsGqFl5UgRYqeHgpAkr
BvbECSacqOklVPVvmKhe2VONhXnxF7hcMtD3Z0J5SxhFJJciw7QSwsCbmgSSAyns
rhABAalnqVOD2M4NdhMXMhCgI3PhckAGoMaMUSbUeACjY4l+imS6goNTC3CtpKA3
o09/T7/6LEdDib536FaEChq+my3RxLT2hV7qquJUpqWsAH+nAzNcm1BEj4+cXjUJ
UtdHWWJ7ylJxBvnCwOWH64oGp7HUmG6xaOU8EKDbBVhb/Ble7oXGsfsUtjyKQ/Nf
sKaGdGWSTEGU+ztGRIWtV5BQMSQ9uV+Y4l5YBQndqyl03KgHipgxf86gJTuW3uk6
aL5t913U3s+qlwoPPbngh7GPCSrE9PUmGCtoF/zipXDxJJCHARahk4fogm3r/2tM
NebTEUjR3jjwDrQkKVcV8kvL9o6i9a8XQ+F4wDGYBfCktlur4FwGEE0thKv16aun
LOoOI2/IWPHwDWl3/ME1l+VaUF5wxnW28SJgP6bJCrzvoTw+V/xzfi3cXfYowuFA
/iDhHwKUoeDhOrSrpL7rxs5H5eeqGgLihyQHF1iEeDMJ+QgG4XnNil2BAFmpGkgL
og/1M9F2AXVpUeUvhE9UKoYH/gjFMjKnD0YHdgMO/QVhd7NCI5suUHWKloTNw49e
BiwjmGWYmgmt+vVjA6OimCqMmJAprL5D5owuNQUhdFTQSUzmxu2/qFrGHXYkNO4o
VwYQlZdNDbcAkfb4Sqk8AktHKbUDpf22p/DhYxZ0djIGNNIGanH3HQDeFGLqD0Ly
P5EMnnrXqAHe5uMobD9giQu/dBusDkL++RqiGuBR3zDk/nK4vkG2Vqz13Dh8wYum
OysDOkz7gA0GfHNG1f201H/CUOcsFvcsDDHffjlNZbL5mIOtNOd66AZjDMuF81Kq
FmPNmlspgRTCQCaJVoZ0NFO7k51H8LmCbqYyVSWUFLx3YLhf6fxOp2ACeBmhymhS
95YGhxt6twpPWh+p6htNMscYiskBiKFolmDfQY5XwN54IavX4x5ih60XPY/b4Wk1
Fde++rYkV/KczK31yUkttZ6HsTQ5FapJnoBlUJ7ca105l9TsmYsZla1fGZEHmipM
25KXLYWcv0KjoBH9Pf7AwrevDnaUHtDdFUcCqYf2oJu1NxbnxBRw/gGlDL6E/q/w
e7Z0hfxP4pfU1C5JS4PRnEG3/m78QN4+V+xSeuVO7/8dgFX11fK4yxh8bxcSpYrs
A//G3Y1iNgWXdqmF79/KfQfbAK3271cKAhoftAdvc3sTNew2w/6Dxsou/n1M8GmN
ncb2nPZ9m6WE8lj+VP0Sh+FKrkmqb+hMzSdxg3ee91dOutuLYlzWKqRx7liwgCGb
0ojnz0qJ7nHC7+YkkKgWm1CnMLajayceQ9G09kc99RWosK1mat7zWXFsXnZW1Mdf
CB/+3/y3fRjqUukDeXdAj/4X+1hEWjusfJVTcvG/wf4IhqmOktLtucKW48WRG8IH
/sJyQOCoofI4ZMLWeyHvWJDbwr8XqRmOGQTZANZk0OsxoHgZV/ppW6zmjJ6hQF51
4H9y032SYac2xQRaPgatFF40c7z40YtdbJXmKbaQ9JjFqitrCpQfsWzUWqpI0Wdl
urIuCJkb/AP6REug8UZTmoj4HXOHQkX2pRr31zjCeRAkHGxDgkXUsxq80rHsyvqG
ddemWGC6iaxn2XtSuBDqRm6HXhkZD+7MoBQH3EtxuzZgO9Bupa8jz71c9GIAgImj
0YQQWoqlLgoAgE2dNmQskdzoMWhUj1D6O4sesj5wwOfkNiL3k8xq3Q/xCH/r3GVh
7b6omGqeZJ8UV4d8FI1lEcIgU+KnYklqtrMNIXkXIKEmm4YKIeVW5ruOAz78aug3
lXob4qyf/iMhjHn6gkecTWiSPd7kDIaEoHyrF1Qymk61D2VOFI2TiypJy0DdyWER
3iack0ky+UluCU3HbMudjEV2lV7wkzqcsC5AW68tEVotr3OsMy2/lV+ZwtdTjJWq
ChqeGJyrH0KKC6hrqF/FLzPstOLl0O98E6FGrO51Rf+XGpgCFpulBp4sgJsLyF7R
cXCjo4ANfoWWn7T7f/uUap3zgevNH9m85fEExFjalvr1Jkhu4SNtnVYinZdv2WIV
/AT3WewowfkydhZcEI3oqNB/5wq0BP5Ew8conNjgBGhJUevb4SWUWjq8kddmg5mO
B5a5/zZNGHs1gY1o5e3AG44DbPkJI2aMGkKvoz+NYk+Dfsuruhu29dSGm46zyIwH
pknclsprLVzWfmA3oyatm7SHkYmHzRcXlhGi5afF3ivHn6/a0qQ1R2+Uk3KnU1Rj
d4Tn3hIX6wyUiuOfNH7TGy5alTrLzxC+Hw/WMGor+H97O4x0TlDtMJKr8e2fOKc1
fIp4vaJkxwDk6A8InRAGeadrI5MTUuSdR2/04EUUdE8vwfV2yaYQQBYE+bPA6SPn
dvBelHFlrPWLDq6FIM5J9z+x3TMX+ddWQq2HE0SrO6jwk+jHIVrHDKwdt0i+K5xy
YtXU4e07m0FYgvjwMwyCrW8u48VtC2BPX5dTNMI5SexSJgzih2W3LaQKIWjl4hyN
Y9opuJc1LqegDphEOKiMdqjneVuXN6VlkK5nZmwqwCdXN1BnbRKWdUp+tiCHHec8
sZQ60pfTbRjwV02TEpwhOwDrZPagWTNGiOKZz3GPCImeGg5yTHi4YkEHiRCbEEd7
TXgPg7rWSQvm4VdlS7fxbi5zyaeTd/zqqtXwAnhA8Ws32cGk4BBdx5grNhdbOtqo
B3x47kKhAa0JO+kLScA7bUfNxwthVFx0GF1X/cj28ev79F4rfa8kDUQGeihu1EtW
gTTiMHD9lXhpuSmp9T1ApwBMRpV+QFO90g6v6TVgRK+lW6knNs1Z7LjwExWHBihw
nXPjRZZcSea50Y4O1bR51v54xm6I8tvv2de0BcqeqeFUX+ePtABoPQGmyVQ58gAt
KaWhVFHDcvvJpwQktxRfvijm3A6viHvFr22zbAegF/xxcidwtiLf8+x5WYdd8m22
29/Hyw75ywq2ad/QfSApL/l9xVhDWlONf167rI4L1e31L/sRCb32RB1+ijT4SuBf
BWQuUyalwqQK8m56jY7E1bw7n7N6UL6+v1WD1f7d04Xn2yYl4BE1Ghvyz2UvbgRe
nN2CN4DWyHcKhnD2CxRf3W9PDJ7sFUSbrUJmI1HhGBHi3AnBxYELF/UQpSd117pm
Z4T/Q1sFTUK49f3ds6I+18ASN/dNPlNyFkN2gVb2rLsgqRxnKnS2RrLF70SYnyDF
6YRB2HlDx+Vc7dtEbY0s6KSOiotA4GgYAP1yhyEInO2NHFSNw8lA0EcpHdL+KzsD
Vfm0fqPUIi1l6bNYSjsTMWLNRYCJ2G8DICFftsh4LwrLMXIbq3w1wOijAmYYD5QA
zMDxqzVeo8aibVkfx2rIBheFA519IkN19RBNwr7i9xj5Rzz+pM5vVdsB43wOJMkJ
/zcd7Ds/Emd8Eimu3S35vgOtd0uIPDuffruADg4JsRI5PD7k7xirpOYjLyepMooQ
1p/IB/Pc/+Syl/6cjTv2x2v2k7B+6C2zZsxb34Lk7uf5uCdBtXy7j4f4kxrxSlgG
iZEg7jUBwUZCX59S7oOslRTH+bT5XjKkpymVwDysEEiK/RQWYu0tEyOda2F1ZCeq
APe/uJj/r1zpo2zJtlEP+DpQtMKFo/A1G1XTj05gtah89Z3I9xeiYLCLpotIMpv/
WBWSjXBXZ9Lf91B/+DJmD75Hlx4xt1gdhu2xtE2vkXimXVvAbtAgvqkZ5kRJVqAp
tzpneK1KzL4IjRwoCpmsrQlfd+hiSER0WqcZ9qgsZbASicKvephFzBOG8827twXs
Qbr8/PxAJz1bgBlJ/QGg8MuWS+4pEAhAuvlwJIjBnQ7omrgqtbX/pDYoWjg9lMFz
bQF+/OLkkaCA+Ok1k20/0ICveDsb3DoET7qhKwZTbYB1LesHkpISKs0pl5+cZbRS
iS8c/sdp2ayeat7gnVH5q7YQjQIM1Yp9k1gFAoG87HgTw59SHptoScpzgZfWd3vn
/Fy/mSp8fBhD3VMiGcqFHDrSwQGux/Vuarujhuhc1L78/XKonNsdZFs9g7+1iTsG
9CwZEpbxzl/ppfqWRcwLOkBVuv7ADts5O8rH9PfW69rFZGAH0gEEWKEYnb8eYyHA
01zFvQOfemF6G/ni4COS5xvKhoa9wuEQPnIlTpOOH21MqChpC/AofglYB+y1g/8s
QtevPZuwwcXXVZh3u7/d71oLglTQMTcbM6IS/rmKAjnykg5o7hhMfoWU3DxI0YNN
tEC52kx2G3jB0sy0bJOM0q8vJ4KBmEr8fmM/Rq4fKsNB4phjHaXZf0qwERBOt72b
d/NtHzRF6seKXycCsL9CYjR7ZruOQsYkAMyjrCxeOJdem4N+PMKRqLO+O4yZFKuC
ZE6TZ/Ri1FIl4Z9OchGTEipAn5KkLoJAmzAqi/kj0Vu2fKEmn2Uu5vpKQRZ1Jofu
N+G0+7BL/g2zsIfKWlaqyZ1sjFSLUCtMTh8Jqw7TbuDkji+0yet5zCG4SIcHe2ON
yEE4Z5TjOGQl8HNjvvdengxai9Km0+u764InasBX5HQ8RRXkyFl8kIVQ23KrZBe3
M2BMvMy1xu0MrvQA4Wm3tLrq2oHJplsxQPXsNuvoB3e3Mljk5wBe+Pjt63q3wkmo
AJKM1sQJiH5hTqchDx8i4xOMnbSwGjczcjdv9O/cq2MbCiMWqkhT95xdhL+sM8Go
HCyJfoM73BK+MKXDr5oEhwIVx4DWt8+PD27g8bQu77r/217exRyHOL4FIPuwLUmT
6pvyir+NXY2mb4bWtNRWKyuXg6fmacrkTuaBmdT08ctsbEioA1biqMfqH5y24Aom
dZp1OEuWv4nd2y2+FdhBH6pvhIGnG/dCWWZEf1IncoS3b/h5re2TLYzFAs2oceQr
6pbF2K7tjGHSJx1gHXq69SoT074OPD0Sw9m0kz5HeARTTJ2SCPbJ9w9oim4PS7Gq
LaP14WhUA7gfGm34DB1g2E2ywYq3JmbCIPEnFYEsdmLB4VTgTrzonUAEB1kVkIkY
H/Aad+4nBVL+c1Xp+ZOljffs8+LrSrOwTWB7OkS6xlyMAYNA5QnzaddIjdh9gcMk
bRZzGr3hnKS67UJtuLOT7CEnC1y7lKGAkeX5ipVWNWkqo6P0i0xnaTDrRCX+Tx+W
q63TD5x/nDIy7WQ343jNOls0Sem5HpvLw9blEI20SEYt3D0bNi697GhvOVp6Lty5
g40+xNi19E7H7Qkgl+8wvoQ40dpD2UCe0bpQFY4+QNM70vt9pwt9DPTyGgwG9XLn
1GYcn+J4oq/CLec/RFzgMEwbI7v1s0FzlXQMal1x0BakGMLTV33OVSeZTYi31YGd
PrD0MfDtZs/lHJT/YSpCmnob7+QbfawcxHeMNNvipfhjyoTI44HW1lSLo0eTlMwe
I5AdOPDI2nTBkJfaw03l1MG0EDKtUbdLmjjFbJIk4uC9o8uC1A05XF3RSqhsvwLO
kxCAJDWVmrSKfodDqOYk9zCemty302JiFsw3I3FC0tSPXPNRwUAk1CEUvbzzmhzN
c9O0OEJTsGmB7O6DKRai8rt/YZ3mQKYdfC2YLLBVV3GNThr82NjWQlP/LvsdD6GU
4U922y2X62nyJyhoUjjnHAYX6V9P9Vw2vPAm7mt/CDNRBtRRm8PUl130CIVnaLPO
bp2M6JdqIviuzEcAVHlUemBKlRawP10P1UqemYGR+pRR/5PRBm8WNhVnQKCiogYg
uSnTM84N6K1qST2iWYIsL3JaihSige+Lt0wJ92uOnH4pnvUNZ9HuQo2KAhIYqPCK
xpZm0QRdntF71jjT0W7xbHX1PL+ndNyz79ybWG39nVLXfrHeMj+TYQJyKL76zKAb
RzqinwvoWMMfu+FQ8WgURCWUweJP6PkxNsfsC9uoM11Z2SN0kR62B6e4Sepy8vXs
Wsp513sZkKyEYae9NLGSFGEBuNzzmj+RZUpZpj1OtfOkrCCzuQep1MTOPdu3/6UN
N75Gjn+Ve9Rb6c0TC17gF9Dpes0nDGGLG08IPNSZjYoqQf8CABd69uPDEqIz8ZXS
N9tlauYQgaYEU3q4srjbMehGxot04dBwwWygwZ7gv+q0R3Heq+Zq7AXtS1Nw3NAg
yNt8bhGSYojp/mdJNuJOmXVDGuid0QesBCYWGXdm3gA3FP2UPMp5xXQotmTdRRrQ
X6lHwqtZ2MrKc5RReTwR5eH5Ss2cFZ5S2PPrl8/nd6IdmaHUKIaP39we6YTXyDdT
Xxnwq6zyrPEdHg9v6Ri6GRDt28HMBBd3xmm4rpax7+FR4ZEpwdzG4HL4PXdXss6G
oSN5rZfM0UTDBkhmN8naK3PcFyb8sfOl5me4KRe/CPnAbTOVUu/halxpaY8cpU1h
+w2Qe+64O70k/jIpfwhS2KWZo+fiz04+lPAKJhyjyExZTR64hfe0f7IMeJ3MU4sf
ZoeTgLJuqbAzIzu5nJedBX5XEsvcPMfI8XkQmzgn+EIc64cBf9RIWv+mqYEAfGz6
rphLtx06Dew17wEmvBUTcV/sUTLpRkwpsDKifkruNb2pTXkWey0OX7aKl8zPQYEW
nXpO1mbzeAFqjkIo90B2hu5avYYUi25lgTJClnMePxa202dtuhwz0QcTh9/wMpG1
wvMZZuD4KNBjaY+XLQ4LGHc41XkIFnRHTgg+SgewJVpDow64bdLhuUpdPorASuz0
dQ4QE7v9XbnplLUheccnftrwo9lxAK5H1nKzCcsKL1w+bKkVOvGKYKsmtGwdh78c
T/WYb7uCNWrN1m6a8mQOAn+Kxe0bUCnS933FkbTstrDFV/iTEg0vm8yC82zAfVLV
5MLsjqQMDJfr3IfqcjAfgK43rUJ9jUD2y5LLU5OOuL7lLki3gPth49xj9iFhqjn3
nEhaT4R/peGVgyriHhnhrHcEmADvle7mjtjJvaJsO5+SpJfD47lgdRLjhXe8Wvit
UrFSQsR2RRfajPYGUsEtiVfpFu+MRpz7N1QU6r+2rdwWQ7KMYTsYrJZBq6NrpnoO
YwlLmj4sj3CX/OsdpjQFFH5lucqlvNjuepoXTQkhhBx3aGM+zKifnut3n8935sYr
oq222Vtfm2/KN4/fyKJ3lRRJf6vUwHwKPbtTR6XVZiBgSK2KPINuGJ8+GygQQtKk
k3W3nqePiB5TrnfLywYnReIyck5NfZfy3jAdMX6bdc0nxgucmsF/qkiMNYhPWAAX
T2ZVha/HHo30GS1JVQOl3o9Y+CXgzd5fpp9DaZQkvgNXvD3eYOxfQfC81ex+1eC6
xCQcXQJrXBSZQUTRTALuMnwvXPfubzHGy6cuBS41/qjFrBL+2/7MOedh0HdBmwCQ
S55Fc2xsmZHw7cZRg/bwFd73JK2adRWKNSAxRyOBjQu0PoRYZJ5L9BR1fWZ2ea78
yYWF1JFchhHoct5wWTAmn+Jnl1WOh1+TnniWl1m5mKL1oLWHu4M+7qtX/NRfp12L
HGV1/turf2v9nADT80KUxwtq+Ie59BxM6/2RVTMyckxqnwjQM6zhBLU5vBSigssX
pJKeSFY45URArWw6MQ/QqWmOzA6nY5X2O7Kx9deST+1PRgJwrt64MiU30oaAo/gs
hP+WEImWTIKUMnnAUTFUINN6p38ng+YQZVoAncF1+86EXlTxI6HozNrD93Bt2g5f
G8FBj2Fo+U9aigUuWJVktrbZNp3tt8QXxaz8flADBYbJ4G+e53PdgqQdw0ibqArf
TzhjS51ibG4RDki+DcGyh9MgKcqjQHHQfdZss5PdN57USuOmNu6URjwfkl5wHso4
zLS7AhxNAOOdImEuAHUOSDhkSZPebFVqhGRM0lqyyhcWpFebCUWASWOLseY+6hdf
P+hYwTY3jhaRCsKeohlvjO6gRAcEbb28uL0AUcNYyVgfkRCzBZF/8d6Um7Jp1wE1
d7VtZq6d0VLH+HPBPwSXj+RhHLHS+sqpTF+DmsEOlhXKEG2Vf7dqx4bwA8fF6r9N
PALJhX+PAM1JDqiJxmfY1ARUSrA2G9uS4zhP8yggRTIQkuVNkxPi6QKHzwuQEvvd
UUJRWZmjc76V5/AAZ0Xqudl+wAp6xrpfELZZjXZg3ol57Z1fwiXNLUXcNHJPW+XK
37wSZqjLC7vVHbs+0GG0ZMDAmzd4QikHLKDUP3JXqSid0SBZYoTwDufqydqFjq6S
LAO4ter7PIm0rcPrLvjNf0LdcqEysxtBz0cMCY1Sk0a2FaQG3B+u9lGQhbS8O37U
A5SGr0gtvLW2ts96p2da5XEpvfY34V9oMjEDZR21IpgFWphYO1Q7BUhu9rdClFMc
4dHSjQ2hNIBLxxdIMpMOZaWs3y5yVwjuwIJSAjDpAOYSThnzhVUTkvqbaD9ES8G4
lMM5PO7JioqN/6YkYYCHI118FaM4nsYemxJbuQc1eeHvoSfH1re/b4yFwMZG1tD8
HwopXeu21+e6QD+g0JnNGcBxv0v6WCsvrCtRJxnb5aJx88dtIp6QkudliiYEKvlw
YrWf19BFs+miZvgUxuX1gbLpfBZnro6LQhKSuHktnuApoSUlxFYsDDR593eJlId5
YSIHXMdzz7GHIJWDk1mMVXx6hZ7329GDFy1z1LmGtAyH8DocjrXiKtb6bpibVn8U
xMaFOY7muXjPGMZBj2ZKQi9hWhWqDMPTgtqTTgNX3GVFHpDQ/t2yhy19pc1hKOhL
0AZ/NatJvfCQRo1gS44jRftfoCbcuvEHq961dVFWtnEgrE/trc6cE52E09a2v514
Lxt+zv2s496MxsQp3k8pd77xyV5BwkFj164HxgSG6tX4ODrr7yijyt5MXfzt0UkB
Uf0MUNyHqyF86drK+a0q4L+9TW9pllJFq0E14zZVvx49kkBZiQwzu7INJUiXeHh2
z76dnjHtcnn6AlKR0eYbLufmZ/c5ZB3245/maMi2kxxxuJYuvIiowPjd/A2o+MEy
vONxgO8Sn6iKmyHWNGB0MEJrHxrJaP4bSiVe6+tFKI+7tJl5O6lNMy1rQP4WPpov
RfodBHcrGpL/Ywnrm9Ehtgg9TZAQSo3qyzh8s9RLL/0S7SRyOrqsCvRRoAy3yuK8
KkcEb3d+2ZnafGROUAzQPG4e43SfTIuyAuZezCDepzgXh1dEd8D7K+JHgnM4K5T0
DNmXo0nLxmjqbSRbmaIYw3ADCB0SlymaGvt6/yamRCGF2tWUB8WpDEJ7Z29G0d+q
jPjFCh1AF6C6BzLt8qVEvdhRvljbUFOg+BmHg/kYs1wRtSIo01vLzwnXwzNLKB6o
eXWdyf0WTcA53yEg/qTYh9/UTqq+GBdt64fgJ7I0HAhcKoMdbBXWzwyZv3yi7Ajk
2nadD0DxnhmAztnEsw596UIvFtoP9MIO1/tJSC20CSDEjXe5nSwK+pP0WuzN05Ic
uq7AAsjPmvSVIY5PRDz7QXWaWRFT4hPLssGoUTC5+JDwAWgkepJG3MwMUMmK3g/W
3e32LM0WRizMmGwDuleuVxuW52mzxZpfFo76ktGP+MA/7ALPG3krWv5w8LOFjE/X
SKDuB1z2rzee8W8a5tQwndItek0iX03YMaefuXYBdQt2npJgi5KE9BYSWE67BCre
GqoTGOt9l5M+qWFdc156EqhLkQuqoqLQsjnwjME4/mHio0AaJe49MPDc2U5xlc5p
GBESQ2Fy6y0DsInLbvejBVOQnzcp4RobXvvnFvt5Tur+9vU5b5xcKURFZWim6Z4K
gexRURqBu4m8Ya0QXm8kcyUeBZnonSCBPVkXch31BLuZquXLaTnpBQLUKWDjMX9R
i9NlJWdz84J9NlCwcAFbHY7g8HuslJxNKI+lJYMUe6RStZu2BZxJlVaclfS7RzVk
YRNFfKXPXpOWTuJVqdLWvWmbE/LtBgDxQYBRAZhkVONzdeAZUJRSgiT7JXRwSOdt
mQxgdU9y+mn6AFQbZhMiW+JDP/niG3h8GXNmpysFLzKGhAaCsB/K5VyyxyMqeTtz
bnx4esur/UmIbvE/JWFq/HtW7F0ohwt/jwKDAmQ0SiVgobKsLVK27r9xtK9T4XiA
JQgMD9JFgv2SpWn2um4efyc3N0x9i2KGWR/nTZOfYII4oDDzW14wNCNmFSGUxOjG
tZbNgfW3fRlTb3pb0Vi6zpkFBZX2wMd5FQqaplJoZAWabAvnWlPgrhwb5J+l8iWj
f6H255O7qt9kVHvaGI1JfdKdIO72B7WtLOtY5NizhmTSPrdMmI3fhf/HOtI3Mubu
uBD3tCCtrC6G6pfCNHj3D7QYMUMT6eyzC0jmsQF9uSyZNJe/FR3ZMG1okVyy1SL7
XmjWwxshFw+UtGvlmU2YF2mMruJs/gWnq2rx8zxBbcMfFbeZmRICaweEUDpoJNr1
wnGVvjxEi4dZ2iXzrq2JgNQbE/F2FK4nOglZzEZjBNcIaGaIPb7Xt1DV76mHwVvp
+HqFSFoR8m7vBz+tYOSNFEkCGgFLlfQ+WyqLh8hzEMwmQCD7GEuW4zvmAdkjpnoP
DxjOCvG98LRjkIwRivNuywwnePJY2xZrGxHn21beisU04A4JKAMKzD8Ct3BZes5e
MSigMTHfgleOYv52pp+RZdtVDePNKI381WGEOr91L8ibmgAnYloMH31SI+A3Q+fC
d7ukz7QiVFcvsM5MhqXaTFYLwzJiuQfBFUVGi7SK4DNi27ICRJzGE1VaPY2vJpL4
UtDS1NlqQCPL+akvfBneX6wwgM2UGm3aXMxt8xwn6kI69psRt9yBBeMWML3xmCWp
wkHx3YMQN81064lk75lsQZpaxoWHCuKQP20jAr8EV13BjP5ICi+gGqbKGdrsXApD
/kdu+2J7sD2Lht6JOJPdo+fKZ/5Pbu7PVHuUSGcD10tAD+5hTLxs5hrq+kvCE1Wv
4tX6PaJC1Iurj6f52YUvYuwMVpM+mw4nEJ0UzWEydsrEPGFZngiI/288lbpyGD+1
CBKkSVcXOlDGDnAQXu0er0BlgLqucwyGkowdxmjzDguw2BY3MQ5MUdjsktFbYMTP
8ghRULK2I0egnru584QRyNHL3RAXtGi47RYm4WWhKbOAx9P+NLYagmTQPrJgOrC5
MxJ2h35/BACF28nOCYYxYtqir1+SW0z3Qrm0uX7ZDr1K1FQTBtMmeM5EvSmKtHxl
X6JYhFxuzLkuJhwuP1GpziJuW/VAP/lhrCnY6XZfyyVaIppea3yWY7gombqg5B6U
/qEMsVmggJDQqMoKBX2RTcZKuMhPTHdji0j1WuOMJVf08w7lKbkbxrCMAKzs4xOl
UjinO8yPxBcx86vn+HJGeS5GVNN5fF8fsZe7ts+rbvyUkuPSbKHA8lG8sIHDJt8X
PTsAuRuYfob8dWiq4qgxO8E3g2Og905R0lGCFIA6HMufRTORvt7yhjqDCCXNbesu
6F+YgAA29JPFWB/n+VSHDIapxHqrlYFJz0UuZPo9fEVTq+wj2ZiRxgz3BIuLszJU
ZtwEf6ret974KeDbZL8mPLXeu6NaFP9ZFnj+8DXJfNu41ZA5TZ2sZn+i1mYmQGVq
6r9/NHnRINv/LZPcPbjZUs2GVNCTgHh1GSB7qIsuLFr8Dht0tF4JaElC6CRdNr9Z
wbAvkG5MRRdpgzJ0EBwpUF6MeKwJVoMX3i0q1SBUEfkMUQtGRtEODyP5KJqkAUyf
c+ryWvDR5DkklZwD8G80b4/znrfcZtAiOH2IM9rOnIfVVOLHJiOtffKoqzetJCql
ckuRgKtzEnSySmBiEBWO2Hfth/RDDjoxyxhJd68VBX6xXiDjZ4yHfUS24JFXrA47
ZyHIFsuDAn4f/3qukW+iyEb99PhseBwO55wCeQ3eFZJUFTYoPNP0wh3UQRKqR90R
KklLTi9EXBzEsEbdy4Fse/FxAdEV8yi3oiS5XV7XVpZ/UBNg8grTSzhsaQUDUvId
HEKZLRQZCwV6pA/Is/t2gUBB31EZiJ84Kv5v6+lRGVuJnFXZB8I61Pbkg+YdUWi0
l9CATxRjfRmYfT+IXyy5t2G5Y3kMEDOZJ15O1Hfn/mdYVWjW/lpzT2qNPexSEYiT
Q0I7T0fQflUB3Jm0lQTNFStkypEKQsVbFhtiW8Sf06nXmCaeisu54mD7lQDb+Sff
nIQiPnC8Jj1vIR1SmxiDaanAxN5k5NOYqSRSYcSDl4zNzp17vmVC0+FzofcUewhK
MPDbD/L9zxuhJ9r+YUCPVQhAB+95dMJpMgZEoLg72DxnNfLpAvfi4NhD1u7vQX6s
fwQgUHcD3toyYgLSP/cdK5nTMzk+3LTfSieFJMxtfKnQrhKdTNiFI/Rkn0M/s4ro
KBNzkbbTHx0G3jvJxK1MAbwa4fHvoNbtcNmc0d4CB0fUHNRsmXTZVP4gueE/i3GI
FRZ8iipbct5s9KKvzWtXDdjmXoZWl0yDP7x84eUQfJ0KhZAXOwRbJiMzrnpdgrN+
XdNZ4z1a8+Oa6NjRpmhR8Rm1NtfTHO+jGfHU32bx0ajF0XqV9uNJSApYxr+lJ7Sk
KQNgw8ZIHIfryYHqGDNvJhSaFrqy7Nb2chtI8FQfDm6LlugomiqHfTZ8BKURKTQs
Y5KjW3am5pb2P9RZQhHoW01izCqnFh2oYgdgEisTrkSZ/Vrje7UmKBMb6kbsc1Qa
UfGlnmI7bb9fJrmp+P8+0mwjZjHai1xJCN/2HekKED6or3kFB/4lXPTqDlmTl+6r
sAOJcdnpPFtcgn45TUHc8HsV3uWc7yxIuIWha/K1l6CJlF/wE68KRzuuraVQNfK5
RQYo0tprHn3E1nWC6HivHwqHDN2KDm3GUj05AtqagKSM/tl7tBFlZpPGmFoF3xdQ
8+0FJVR7ahSs93Qq3MFd1qEMwehgBQSHCIuE3ZxxgTu1Yzlh9rIhrGjS8BlsgCy+
50qDzVvH4GeDIyTX61yifXg4Bw9+QkmRVtZm9fKcuyvejUYFQ3qQD8ek29smqvMr
4v4uuWx162TlFxq/4Bfp6FWImRgcjcEku8UhGMV0iYAaJBIsnN6F+STGmPB++U0W
IGxQLgIsABfT1aPgb9XBPtp3QljS/E9774iX16pmW1CzAlmqf32m9ds3dwksNyVM
88cbxJtqHhkZlwy6rcb9Bz9dE12iUOPw5ImtLZX2715DQymy7jhB6fzsSyG8UO5U
m3TlH6UxAEkOLm/LQUDZIPMqW4lwuwIUKfNRos3DF0/MbB8HV+glGUzaayrC0f2f
OcYI1sl3SgraqUqTRv6N+3PUCI/QbK0kDqUptw21JORnvPVsSISMu/CSoyg9dJJd
JegU3aju6E0i4yzn9Ck4OA2hp7wqZqpk9r4IidYw+RszdBi0ynl0dIzHxQP7TI9k
+vwKEeuRrvsL5aWFTIY7h4x9beNvZ6gcnBA+Abqajn69MKb1fSaxfcGDae0SrcAO
6ecTlapOH4COPYy2g8KVnmZkUz1TQSb3AVIXbnPboMKyIL7EAG5k5XzisG7gNSmb
xyzJWBQCsaKOpDwM5Jz7Q/JTU2KNg1ourkfxDtf+38gv63wWgNcvx4EWvnn2rNoL
5x8ES+xfWImAhGaz1Fn5arV9NvUf9Wh8hMzyf8iIksiOXzDS7n38lkzy7DfHmIur
HblgdkiaSnLnG+eSRIIFt0vCzlneohHO8xC3G7Jx+iSYSwyKcYLPupkDPgKeN0br
vtvCb3V4gkKRGbnLYMbmGEiNQF16WDFktnSBfKmxWjJ58yShXtYHFGjFpo83KCQn
TtK8vG+ppHvbwEjRpd83HFtAlLV0kxBJJJYxqmErNy+ZFvCAFDbgj6q+fezl0xas
huCWPihXmjeGABEE4iUkhWmxnCiIQmMdN5OhGpL4Cub2QR9FULALeqP6R+kxACpx
0NTFXfCLFhX0TZZoAoAuvb3IVgqCGtVqMidkny63yqWdH8/V0l9gw7gQ2sWvOjbR
x8dyEQTXtaEDoqSP6C479tC0l/UniO87z3uHNQQ0pbkeLfp+Iuj4I/HSgcJBQosj
g+2cCXZw6Rhu0yoEu2NZMg7WHOSSCcxLy3owg9sJamm0SrgSsoEUVek4ozPKUby0
8IyWyPY3q5GY68d9OruPJ2Z37wOAaE7IB5NopZ+2HITk6vzsUgL56ECrkS5FUCAD
ba8HSSQMfCU2hDwsFBGmiZRp7yD+TMBEs+7tTRJiAEX7qGTsHlupNv2SdOh9uISo
2PZZXwTplXVcgulKeCKJ6TnElIABjHGGPE7hvSqPt+wjUBlH7erj4MFPfdqRkj0Z
2vbU4/IfwsbV+QfphgbKVB1u73IoKvn42q2kIogQPACAOHzOEIBJLGbWLrB30K0j
mRC3pIWocgnnolkH7FXhMOTpejxx9IlUZmGu8oQlsdjfOgC/ZPZH8zlz0KKnxC/y
A9rgdRMViNRNErDcW1IdJXAKxuCW+UJylcvFxofUpnaK35bFpAk7K1dJAW+CC1lb
sLeWo5hAg16qLK1bcGscAKfZ0g2qgUUTrAMpb6ddEXkPsosKcIed/spBOLK1ReVN
d/1EWVGejHLzmk/qq/m8W/w/DpocUCdM/acEynCwLPysTbyePkh93dDDzhlte9a3
noVfuZIIiWOn10z87jgJ6ciuiCL3dnItmahTFUl2jz24eh8yQFPfeOpRzhxMBKrF
JJfg8BEjhA0WvXVF5og7HEAcp7KLwtalxlBvJvOU36wDVdzyrAnM4RO6UcblXBnV
ho++qb0fiE1hcn43SaWDr1nFYKvMoQUHOUoVCH1J+XLUzX4J1j0tluFZg2ltGL7h
9aHtL7hqJzEBkD0FuyVbdvMCmZFju9PsXPfB+m9BNz7DEduEw8nGEEy8igeHAtZr
CxREsxYsbPuv9ucLhlFt/ReBwc9nEFMGUHVsVNUigMQKWEffuETSlOabMEaLDP5I
tmJNFhrehugSOR7uTpp5we9sNQ/6q/fxZlTwIrbCjX+dKZVPJ3izEi8Y1/7uf4gY
+kHBHUqOozxvFbOivOkq/v7U/txE33jH7RTEDVlYGUHHkEFHtrF39FyqOQLaCmI+
MH+BjbiF/yWRqePcwSJrbwfXXkE3G0wF26D7JIiRPfGos+qx9dFLmN/dI3jxWTcr
V9G58/lL04AkstNzPLKVbzrtK1sg6ojEYVUgvgZWwXw5JxAH/ob41rti7oCvkPEt
n/skdDuUYk6wyVUamKsS/f5DMKpUdOt5mSzmGnZmxQKy1pbcdcscUgE1jYsSqEZ5
ywHBjB3jgupDp9JdN31Zc7jnoBnavFHHoHaj6iOrkNhymdN5t8B6cE+bhlmnrC9a
X9lI9Zyp+iOG3tspp6y9Fele+f3z+K3GCg/7BgzcZgZh1If1mN38tMISy9IPVxSs
aMZWk0DJaE16RENjOo2/ajtxykZ7ieIAci/0bGtsoDBif7ju8E49L2kW0bM1pA2G
xLMv4ebmo48o6eZ06p0ufQ==
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_SPANSION_NONVOLATILE_CONFIGURATION_REGISTER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
HERPEqqORZ4yLVXVhOiEL7wJI5Egsrr1po3ZCyxILjhqq4vm0YQDpHuFPHL+jZyP
As9qz2xex5JwKt/Di18mYvQH9dTWEIlJe2Wops2QI5SUZ/HW9ipQ2KOK68lJ93eO
Au+SgAwT9w1Ujq3YVEbFsgmHmtovcWkV1UBTChA+QWw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 18808     )
78prTwK9bvgHlpJXtr5OPP2po6n5FmCtvI8ATSG5AOmt0WplLbYK+WulD9CSH81x
+W78NvDWz2NwnIg+jc7lp5OA/UWVKf2uYzxwtfSLY7BgjU5EnjqJKSQdl1FLXbb/
`pragma protect end_protected
