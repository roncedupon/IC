
`ifndef GUARD_SVT_SPI_xSPI_REGISTER_PACK_SV
`define GUARD_SVT_SPI_xSPI_REGISTER_PACK_SV

// =============================================================================
/**
 *  This is the SPI VIP xSPI register pack class.
 */
class svt_spi_xSPI_register_pack extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** This field specifies register name  */
  string register_name = "";

  /** This field captures register field object handle index at svt_spi_mem_mode_register_configuration::xSPI_register_field_list */
  int xSPI_register_field_index[];

  /** This field captures register map object handle index at svt_spi_xSPI_register_field_list::register_map */
  int xSPI_reg_field_register_map_index[]; 

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
  `svt_vmm_data_new(svt_spi_xSPI_register_pack)
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
  extern function new(string name = "svt_spi_xSPI_register_pack");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_xSPI_register_pack)
  `svt_data_member_end(svt_spi_xSPI_register_pack)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_xSPI_register_pack.
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
  `vmm_typename(svt_spi_xSPI_register_pack)
  `vmm_class_factory(svt_spi_xSPI_register_pack)
`endif

endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
OyTThVQiiQiWC8/PHKmt/VbiIchuDeo+NkJdi7xQtfJZgdseiL+0yeEUL00kPXua
2ikvNqxvAekrLmXfSFxP9vkEu9sibcOl6JwHdFBK1GjcjNfehQwoO2lyKEF1r0Wg
peHiEr2/O/xIs+zYelzsHpJnaRYX36bfQ4Mt1vZeduY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 598       )
ROf8Y0I3FfA0gS3PVT+L5b7RvCe0dKo9qzLRBrpcnrEq9KRft8DkDl+rrF9JgFrw
NumWwnB7iHLKdGbopYKTE629Dum/LZ/niv0RIBCKP4B5ixUqhIDeH4pTSe41IdvY
Y+Ofktjol7dygc1S7lFy9ZVnz3IZhXPMJtSYOW8KbRN6b1iHbFN7aVbPlaIRhdZc
ixKqOf4eysfZ4V4O0iU4w3UIlJ5+JiGZtwNqKBAaNhtaw9e2eDZgSGoiaz8fBVBC
eBfiHCPeTxZXhtAnqXise6N2vDi4Xn0IF8PvS3E7adkIjs0m/aHTBKwPkEFfoFDs
4qKghmGZF8SR9aRDHH/q85fVG+5jDxYSRkR0/lB3ov7d8rtIyn4bFoOKYj2SowY7
FTX638HS4s0jOcW45A9OuBZHC3Owno6WtzDVFCJABWzZ3Ma+Zl+6NkSmMmGVV8KY
k/cqNm4Sf8hRiwvTZWweU6cERG4eWbSbAgutAXMA3/rAqgOogB9AJLHXl1XwPAF2
R/JTA8cFfOjwqe50n9Pd4h2/5jEX/J6hgQ3Tc4sPAVGfN36Gc8GsMLKQmwMzcPTO
Ro7bdBC1jB8xZW3zp5jz6CB9ik7+3ewqNuz6x3M67ye6jDF+3WekPylLHIcqJ+ty
OWUrTjvX/ayAZancjj40lZTYQQFrCUcJUZwDdfW0uVOIywBIDZjjQd9x4KP/KQEe
OJOtA28gGqdD+9KyoKkmJkgU4UCehHmxWJllvvnPMjyVs3ieqW4E/BoDdpHPsf00
0z79U3jSmJaZ5zoVv53rPdvHescK12rBfwePpbXNK/A=
`pragma protect end_protected
   
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QORDO/0byr4KxH+7PbHv9zWyVBtw2dh54SeXlGAYcSt9jC8GMWUQh7HsOxTMLkaM
KPYI+UK+z/IKBN+Xm1cI4WMiivOTpHgVYp6M1pdukS9jqT9rH50UTqizg/c1GWBZ
dLQz0aHvt399WGr5S7VPKyLn1PXfg7DNlbndAG5/piA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10172     )
+Zoh63O7ejInuvG/Cgb0J75LuahhitpF15CxWeNCov6OyDaP4+7DmvL4AF1sebwT
jT5U9I/aVhPdkEilcGTpqGVZ0TcfxPXGQ+VoEFYxacZ9S3VbJ448RtrCv4KYFlD/
A6a95VrH9QvFBECNRk+UFxlhBnlCqhRa4UfbJQ2tHnKNiLiyojdAmXy0ZIMvc5bF
uLJrZtpXornE+lOTg8UfRzCDpoR+2almzejMFlXU+R1+/v25UpHsVcEWqE1uHda6
Ej2sYzEJIZ6pQacbKbnprim483HqjvaoMGJ6JIM43PZgGQ7wBjQh+ygR/X/ONr9I
c6mOIMRfUWg2yTiBRMEZAsuzzP80G4KZZIXjR+RXGhrrKVI+aNE4xRuzGWveKRSC
r7g8ukRG/Pgs+M8R1w/Kwmbb8F4fz41WyJBlqrX7YpYT14Tc+r8FNG3/qjmXipVs
XuTklqQEBC7NNJm5NDJQ3hkDN+CSoUgrV+Wm4BtSo69UtHEvg9/vY0OojBgFZ3HU
94Kug8N+cJ3+MJWhyoV1bmnoLVQBN9iRiYJHnrSma6k9SAz7TppRYUKlptdH7Ay6
KZzxFlVLOYDrGj/1nchvyprJot7PZ7Lh75uz+mtIWd5scpgf6HI3IzgtDGZpIwNx
SkxGhtAohHbTlnFC2uzyw9ZU82Seu/MqgHSnfH/9WO0N6ty0ykxsPv+uVxnYMSS3
/IXBm7vuYJxrHEKdmRIS/8ztHX2ZOYmzO/6hadNSwCxE46gwM5Bp2kBQEPqhQ3f2
tLToZZoHs4r6+0HIJtr8Ud3yz2x9WWyo3AMewFgbHIxUhVXsKNFeArkhscD0+X39
kJqhWiBDuNJapPQgJfnUskWeC7tLPU6LllVHpTAy1CSQ4ie66YnYeFes4c8/hEww
VIojdS//grQPFL9cqP0cAPr8ncVv6U4CBhW5zWVOUNGhAUvEclsXiqlvAggPq0MW
LO2Q2rhdVweCGAddz1kSchVCAniQcicTqqnkggE0/2AeaNlYKOotBRwFjPZBBr+1
frTpNQC2oxIlzuJjK15feZf8p5CV6gH/w5CmHUBaR+l3hG84VhHdE/o6kpV34NRC
e3qH/X2NrdvBN5viOfIb+tlKUpu24dLN25Z5sfjlpyCUDJ+Zlf+Tvn2suC2/I8UN
9PZWhHM4OOVj5Q+845TRC7TEIXqcdodu89lCYCi5TNvtVljL6W6PcY5bWC9OqXj1
VjmS9joTG50GnSDpcsobnlTDM7p/fHpGlsGFMXbEW89FI9epGs1d7CgEhVAB351K
mWTGy+b8LlBO8df0LuD5IXNa6e2qsULsLnC+IGROXZjuMyTp0/dG51T4I7ssl65O
n8Vz0IjUE4j620pHZHpLtsNVvRmrziwTYBYQ85J31xb5/3fb/m7zyvAlDMrpvsYw
w4bTcNNaV0ibzmzJKTDR5l0Xl8K0HrDx+6k0Nphwo1LDDiDP4z9KdvnWcXnwFvvD
EpUVllLS1xfQyfWtuQ8P6DLdrt/oVvFrAp0L80/fmGuEKHEj1cMD312rsdUHmdKa
CRhOjFTpPSLl0t54v6E61Xch2GFz2Si7vH+crkPF694wCW2V1wmFYujS6Sh4y0V+
M2KUs//pzYZ3Fyim3T5RF3k0vdWKbMi2v16a99vvN+ztWhX2Gtao5l6KKztTj6cO
BmJd0NyRPzSi9ZXb2ezur4tSDA37oisbtkNttkj5fwYN9McK8drQvdqbQMXMXXRc
LCjx9YXBP+rWbo3teEzmLoCen4sHnsHinaGrtmsoOQGO1l0rwQIdV7kAn4BWXsDA
rpyLc1IAh3pdNEhh80JT9XdBEbCkjzWFVlh2TPGRuz/9IavuraQay8lwVm4eD4AL
kssMej2cQQrgpCNJigfXtslAVT1JLSz8k672TIjt17379YnYCzv65eHRsaRFWHxl
S3//GwEknXhpUd7/b4ZHfBhZVMdOtPlndi9M5T5jnRVJDQGya7GDNKE9/cCLOrv4
OJeMdWlA20NKMELpsUFYDLz8MXuwkAa5uwpRrwGq1ioOHaUrnqvYisewdxCM6Aou
CrIDmxKRunkkVW1LeTnTBb0F6d1XjJA8BJ4ATJfPxMdQADFJCeE/XKiXHd00kgfC
L/N0MKDv3L73v+VU9O/+zkVxLqvSMnsSvv+ICRAOIVwkYn+3hjwiJSuCyHH5o5c3
RMPO4cdzEc63y9806oWtfshZFTgQGEyYST7deYrHVALWIQWJG0AYiearqUs8hpTa
07udGqNzk+41cVHylVyzQazEv2SmBfzqGqGV6JMdty+byvrpaZc6qLtkweYs5sp6
86HrhV/LpmAns8gAVH3U12LQzTjvri8NMkG2yUwl0et7WygdJwDSSShV+8iPuBMf
rVMKwyoadXETMjMNDTl1kt2Fo7FStBMxVyeZqGlNlPTlI23JWPkTiAP/aK5L0ikV
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_xSPI_REGISTER_PACK_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
bNuqRLFngbWM5rUfCcnvBfPfpKbm8tH2v+eqS+Fc+1HnHe7F1vx8mRMaBoGuAYMy
O9x7YD4s7Qjm3ze/ev+NQR9j29C7sYk9GYvr3BEKaqyMDCHim0wBbs3t5/Quf8bW
oo1yeoWg5+y8K0eiQBMOHEYHou3wRNoKvIFwW1dq6io=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10255     )
Fs4/iJEE2pLG3LczlgK2C/D+QGABmzdtGQYb6e42jO1OCy348HrSjMTpwL7sSm9E
c5Ba7ik4POwDluz/VWCH4A8+Loy3yMCcyHzEPQM2QA+BYG7ZMulvmuM0kx+0k51i
`pragma protect end_protected
