
`ifndef GUARD_SVT_SPI_xSPI_JEDEC_NONVOLATILE_CONFIGURATION_REGISTER_SV
`define GUARD_SVT_SPI_xSPI_JEDEC_NONVOLATILE_CONFIGURATION_REGISTER_SV
// =============================================================================
/**
 *  This is the SPI VIP xSPI JEDEC top class.
 */
class svt_spi_xSPI_jedec_nonvolatile_configuration_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
4od0bzGbo1AOrXmx1y4uljmFFSUj4nLx8WRNwrgnTN7l8Iexpy3wV56tB4maAMUh
Z5/OxRqWZXWKx3ZTB7RbzLrlcl/xRPa2ADAmYlkQh2VPotHfbSegC/RlqMPN9dj7
mlUawOfu5UjPVLMgaguabX0vI3bN5/04FT2M92q/uSu5pSPG1PRi/w==
//pragma protect end_key_block
//pragma protect digest_block
/S4mvIMqsA7KqskCUMFmtxrhF8w=
//pragma protect end_digest_block
//pragma protect data_block
j0LNH3Jg377RQf6HfO/CtRqL5MSr1P590JuKyBA0j9rktXsEzCSuoChGWN7mzDbQ
j4exyieFEFG8QsfVHhRR963b2QN2dmgrs+xGd15Bwae7vTCIjzwZk7ya0xOZxNNp
zwNFvrrhQJGtV0TLSLbmSvJ45/uenzL3HcpOD99k+UPf73pzfFyvGecuNT5nDfxX
VEampO5Fu+NatI+oQc7xOlLoYKHkiP9NJjj2UrCLzJlnJlo5ZrVh3ruOncLC9g9I
buE28yB5wll1KsaNW1XnnE/q3o7GmXIKFBn8FSoDzKlVBbj5XZbA+Ac3byk/O4PF
0A7ngs9S20ijjL6vI6iqcwQ9XthtLFVOIb9HjSqMUeOKM9xWOV7fQMlRF1AtrVfX
ib1FZ/4mMLCr2Cu9iN3j1evI3dwqMWIpEFCE3d1q4Hfm7mltugl9S7OCF7saHI1A
XeZA6Tl14ZwF/+1U/duNwpxg23W4URMFfrrSca+doFnpse0kTRRGEJkhURfJRNdE
vTqccgqLgCwmvYGCzIjaTfS2zuYC0rezfkMxrYD742ycglrmHBjizipkBFFr/A3O
PI7CwgK4PY/673LOHHD0hEqB+O8pqTyHU8bs/5g2Ju1qrHdysyYDBsyCbsf8B7to
Q/YOwYe3Twn+6AvbPSDLsf4iuGTqkla4sDGhAbZnq78=
//pragma protect end_data_block
//pragma protect digest_block
4nfRoPs80lcWtlHYkO9qkR1vq9Q=
//pragma protect end_digest_block
//pragma protect end_protected

  /** SPI Agent configuration handle */
`ifdef SVT_VMM_TECHNOLOGY
  svt_spi_group_configuration spi_agent_cfg;
`else
  svt_spi_agent_configuration spi_agent_cfg;
`endif  

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
  `svt_vmm_data_new(svt_spi_xSPI_jedec_nonvolatile_configuration_register)
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
  extern function new(string name = "svt_spi_xSPI_jedec_nonvolatile_configuration_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_xSPI_jedec_nonvolatile_configuration_register)
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
KiYj61mL1EdGNCggYoCQCqi2+COtySw2Ps0cqCkdIOh10yx+EspU5UypyMdl8YfQ
fJeA/HDYC+ZevoaTBpBvYVdWMpD00UQFxdbpzLkaaGbUjYwLznI/z5wTWKtqlm0V
ZDh8Nmft3nwhlKy72X2IxRCzsV7lu1vEEger9WOn+RrbW6wG6Y6DiQ==
//pragma protect end_key_block
//pragma protect digest_block
rzHN6adkGGuVkOlEkx09uKfp8uc=
//pragma protect end_digest_block
//pragma protect data_block
QTcjlrxerq28uKgfWm+sZ5o2rKYW4KL+p08ycK2qk3KgFvhb0sLRst/RvO94a4I2
jlmSIYvbMmS76j2cxNGhi7GzXhDhkt7d0gfejHvc4Z7NsJLjg53P5V0nQrLiY0fp
MDQenUXV6lof/QWFDrzNbqo+jKpZhR7YBWpNRAoeuXf28VpBYNF+OkGSwGzIv10F
8hVSH/xqsllj4DdBAYdJYRnfeISACjlgBoxpwDwy9yvsgDYdYHo9N4GZ9SJyp0ZP
EniVDuFWrpqS5WTGnSSZhd1p9FCQhrFjis8TjfwR7onUk133UhVZ4GXBy+r9y+rN
0AmZ/8bHT0vMwkiIuR0WAMqMfBlmBNWZmL/EbmPzxj9dJ8Lw0mZFAA28G4ZPV9+g
Oco+StCRimO38Y6h9pWVBe+7txIA0ExEXJqTJL258KX4bd3y1d4iF3jgNYqC3vaM
jIp/v54IbhOQmDrnjmTAlqczO+qZYaZZ0syzi5zGfsU=
//pragma protect end_data_block
//pragma protect digest_block
KX0eBM+RMcRRGq59osodEnigE0E=
//pragma protect end_digest_block
//pragma protect end_protected
  `svt_data_member_end(svt_spi_xSPI_jedec_nonvolatile_configuration_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

  // ---------------------------------------------------------------------------
  /** This method sets the configuration handle */ 
  extern virtual function void set_cfg(svt_configuration cfg);


`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_xSPI_jedec_nonvolatile_configuration_register.
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

  
  // --------------------------------------------------------------------------                                        
  /**
   * This method is used to pack the register fileds into their corresponding
   * register using the bit location provided in register field class.
   *
   * @param reg_name specifies the name of the register.
   * @param reg_val_serial specifies the of register
   *
   * @return The 64 bit width register field data.
   */
  extern virtual function void get_xSPI_generic_register(input string reg_name, output svt_spi_types::serial_queue reg_val_serial, input bit enable_profile_2_0_mode);

  //----------------------------------------------------------------------------
  /**
   * This method is used to update the register field with prop_name_field
   * value.
   *
   * @param prop_name_field specifies the name of the register field.
   * @param prop_value_field specifies value with which register field is
   * updated
   *
   * @return The 64 bit width register field data.
   */
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);

  // ---------------------------------------------------------------------------
  /**
   * This method returns the updated value of register field.
   *
   * @param prop_name_field specifies the name of the register field.
   *
   * @return The 64 bit width register field data.
   */
  extern virtual function bit [63:0] get_reg_field(string prop_name_field);

  //----------------------------------------------------------------------------
  /**
   * This method initializes the register_pack objects with all the regsiter 
   * fields of the corresponding registers. It stores all the register fields 
   * along with register names in their respective register.
   */
  extern virtual function void create_register_pack();

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
  `vmm_typename(svt_spi_xSPI_jedec_nonvolatile_configuration_register)
  `vmm_class_factory(svt_spi_xSPI_jedec_nonvolatile_configuration_register)
`endif

endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
R7ncNyYJ126UjqL67g3x5tcRD5lrSepuBi0P2iSDdrTH/OTuIjlvOs16HwPj8AjL
Wu9JNrgT7DBtw82tMjP1u2y9PjSCqiIJj1hLtXLaRfP9bSxTOWoth1D5KQS4LzTy
Yb6XyJ5Px6ilBTtApRHX0mmAwuqFYoO1yxbem0C5KqMaILrEtLjRrg==
//pragma protect end_key_block
//pragma protect digest_block
22F3x45lAD0NdCB4USVo5S4vBGg=
//pragma protect end_digest_block
//pragma protect data_block
b1T1p/1UFVNDCBZQi/8V9s3wMMdOXxX9x2uqPh6QHD3+bEpCGsry7sulD94447sl
InUjYLXxz7n6u2/MW/nYlD4ikWKfJ/8g2GolGUyUzIGmvl1LQOA4QNaBfZ0mPID2
yKG4YCiGd3Y9YFcF/ZGm0MYDOR31mNdEbXeu2wuAZboARZp6KSwZjBjjgkyewx0r
cmzqoat0fnMYorxSsaJIUrCAlPF7cllcSCtBvbOgoC8mr0E0xeWe/eBDQNgVaqmN
hwk5+Dj97OQ4VqmoOfWMOae8mpkP0KlBFpcqUnyH0I0gdSZXb3BZOD53hLMyGVte
BTIg3dwziqsKdDNDYHnzwAOesV/MJCaPUGJXGQNdnIGLgh514aAwvMCaE/rxhHnx
tOAlEbgpQOIgERlog0JeHwefrjuZjbIgFdprTLUoVb9FHUefBGEe1vdPvF4MVfvM
qgeF6+RAIjWrTEDeeQiG2xzCBDq3psIbDfjq0+cw8IZd6jjVVew1E74xNnCcJkeP
4eGAUiis+cA7lvA2bqpZfNlZQ2kho/gaNfgqXTgTzPzPINc4FHzdiNjLkFHdzMD6
SsFWX1AmdpinKH3a5z5Se79Y1pwqFt5Yy6nM5rzNnFMuSjNxlPdURd0oszLgkaIY
U0CVRAcvog2l7nFp4Ork/3dA5+tr8eJ9EMUfzjQ0g3Ek35kjg8UgP8bWGmPdZ7mX
ttn+LWdNJb8fViYYAle0a5iOd2QPSl6HSaCyl6NcitsZncAdOy+f9E5Tzp3rZttZ
4PCmweX4r+sR5eYj7gIo2xTSEMHTcJcXqjwtOkDiejolWF8RyESopaAyvU7JYszG
9wMpuMgCQXPAvl7uyluhmTUH44Sbqdn2D5Mhdlw/zuXSSVrEZiWIURx4h1ShKmjF
rcvJqXlWKbLh3wv3Qlrn0jg4dNsHnvSD4ex6gaBVisPLVZxk1gtqCOyX2ELeVXqO
gNwlq01AZ2oJoqd2HkYLWRWyJqZvXm2gFbuKHdOxwxclqdWh+ZVg7Hrcr04UzkK9
odJyPLx+N1iQxQ6cP4U1uJ2vxpcsJM2Ia8LThqNWg+DXyfcpPTKGhjb2/U6mrKC7
qR7M3gsSy3mMIOnGnrdjcalkSIohyHNmzOfLPByiTBpl9mzw6/1afnwHesGMLbE0
de9ACHlO2bge5KLwWQqJYg==
//pragma protect end_data_block
//pragma protect digest_block
PNSfD37RaPPxzSYCVUvgEj2OWi0=
//pragma protect end_digest_block
//pragma protect end_protected
   
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
/Ju1nT1r/S/rW8ldDeZxqKn/bmDoTuZmexHHfGyAQjuSfKWNL0swG8Oc06BTZahl
sha/gE9XkTP1NeM6afIXC00XsltWZpHFTyVw+8gdBQhZHZaU5+qmbDjfbJeEcWfa
SbooZXPwBPmVbdN5pRZTMI3OqiBdOFNrG9M14P5+BfR9Jph+LSeWZA==
//pragma protect end_key_block
//pragma protect digest_block
S2yyXWknA4KRGiDeUZz+ORvUHtY=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
2hnYIafLUN9pnGyW8FZ3dVm6/To=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_xSPI_JEDEC_NONVOLATILE_CONFIGURATION_REGISTER_SV

