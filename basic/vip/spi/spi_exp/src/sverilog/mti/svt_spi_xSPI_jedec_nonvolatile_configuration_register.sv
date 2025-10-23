
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QhillZ72Ftyf4EedVGQ8lcsX0ZFUV/TyPsganB8z15cDDPjggjkA+6gSrGzqQ0KD
aibiV/ZpetNTCHlk2JL8+cURlLamYAMAjURuO/BP4kJFmT5ntW7GpyduOgTSvOk1
cmQixMKAmUs1I02Evmwj6RVt4anHE9ZWc24i3jnco6I=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 336       )
WVcZMw2Q3x7T1CdpNlEkA9k7fz5n1iNwmBEw4fkmjqVV9SfQr+1X0LnM1Ziv7vuk
cPkelmg0+Rqxf7iuaOBvmkgDeEzMVKjJr++P60yDGxFoC5Uqo4D73kSMwgnOkCxp
5SUloGy7D7bSLoF24lqlS+gv5FTy97TkY3ovwfVZI5KzfjqVh1HrWcYhWYhZ5Ovm
sY1l8jjxfGzUp8wIucea6KKVCCKuzm3KKbRESIqBXDZs7nB+s2jq66pv7koREBty
jkAKr/Cr4SlvVMjyPIXBglylKHbPa04KM3nrcUVbpWCq7L4YOpuYjTlTk4HLrCLt
aZrhocnPYNbPX7saRk2aBbLs6gFg7ThCF5YH6o0HvPO+OKwyZB1GInw3RbtIQhkw
3G6HZEwGHWwN1QSvLw3b/b4SuOAth8flwJwOmDz3fK8ND5JVn+DI1V5+8iDJ7135
vMNYjY3dUMmb36b++bvPqA==
`pragma protect end_protected

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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
dEwTAd6/bBDxAPI3zpT4DIVCWWHXDHYl5pEyA3F6M4Js4VZeBDZK2Z/0WEpGvWhZ
07idHSiXu2mnplQEulRc2n0hicfrkmzKtO89deDBRmsSfgi0vblazxbxL5eSOiBn
THIbAMfrKlP6Y1ZDpIx9cMjXYncMQ3nbaMkxBoGhFQ0=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 539       )
wow7NYAOs4Jga75Gw+nHacWOoTla7yP1BmDO+y1NK0tV/zXOLGHRbP9IrqlGcdGJ
rfnRD03z1dpbz9dBSxTHRogByKw2XPY34oOaeEIdv/kG4XW5H3qDcBJMyNCtObvE
gccgFv7NScBJXZ5k8vjPQ/94wU98WvXLPSyVsFTB8zH8LNYaEaDr6kPbwiSPOcSh
c6rl+8IUomFrJd00zJ5dWkpROHtQLW8yffbDVJcEX/tv/mh0DdVhJxZ5/oFRIooF
AnqoEfgUKfXsSGKTAc27SA==
`pragma protect end_protected
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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
YlzxtP075L+y2jB+XXQpLmReRAjHAx1MrZUV20w7JnhVYXjVRm47j9rCXy6XykCK
28ZSr+pNq6gugH15phO5qGXwvDB6NZ65SCES/H5VMbfdk71GOUW5Maqng7ppD8oX
Cdu4iyuPmOCtJmr9/TRkbsPt4QOzJYShxuuYXPw501o=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1245      )
i77gh/GaFFVVXuKVOmloSf01xxLeZcMzfYWStCxAiV2uMruXxeni/nbkq+VTQ78P
hSKIIfHL9sVFDhTbtnw5e6BAJjDcBY3OUelKMP0Hu2/zDf/5x3JbomF6iJ3Hz9pQ
9fK3IGYmhcZ6rW8kTCS+a6pd6xYtu7xU7HSXnPlk937Xx5LPpTV99BOoEqphJJBe
VmTuc3vpXFMucIs2+nTJ3n55E/EsNtWgIK/0/Z37JIdCHUY6u3+9LqVAdCaUQdE/
OeUlLEoqDGlV4HcAYxpjTdWgARB9T9001saL1E6MvmgV2nmLb71QrOqeFiKoro96
7PqwGzO3mDboWQog9R/+nJvbksC+xa6NlfILnobIdjPHJwnSBpw0nMIq4FYQT/rJ
/HkBhuEf8Bcpsha31XfAugCeBW3J92BoEuu1ZRLU+SD55NvO++ppITNvrYPw4psH
yKDZQUMIiaeugHY5f+1Gxw0bSEGpuNxETC963+JWMOCcaigi/vrka0oN5Mj/RTO3
lHuNYyrCA5xPW3zyjSF0GONAOQdVRMgS7MseoF8PiLn4kWp86jl05DzRMMLYGjSo
t4BD2DMKGXRfPDLATOAa6DzMOMcS5ANUFkGNODiuCC9PWGbyycDtkJMSIAqzdBQe
z6B4bbvE781bFhgIZ04aXt3etPuQEMi/uoIBHASN3gb2PjWpPU/SKBrfvs6Wgqns
jp3l0wcB6vRZIMzXxb5EWCD0CvS6kOEu1yTxI+OtSL0k0Aj3GMmEMc8Fm7dahQ+U
iIi/+AdCNJhRx8/hK2Jat2ZcIW0wjGaWfL/YnDJvUsKjjq5s2eBAd/FtbKuhU7mI
Aa6ZKUCo7ouS2PaWaTHJXOt8wLJQbZ0wsLsbl83UUvjgy2zucnq8E5u5Fv3EKc0V
2wr20/dtTubeS05nlmxsYogkQagV1bfLs8lRQulAFXpO+3PKw3S8zV9TL989GS3J
`pragma protect end_protected
   
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
f9J78N2qPN5JCj3UQ7WesNNNqX1+kD3VgjW45Zqa1jBDQ8srZ8vKwBGFPymzQ7o9
HykgjtG98SabxMw7LKIONdbcGBHYrH3NN6c2dzpu3SJKymdslEiV0qYqDoGiP7wQ
j13ogZcM5cn1IzG7VJinjM9BFPlzmW1ramtp9EdDufU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 18360     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_xSPI_JEDEC_NONVOLATILE_CONFIGURATION_REGISTER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
n9bB/9l/a/weFP5hE9hb6NaHmECorFLepNlMyCCxjHv9EmH+dLd1CMaua77pOrpG
k+xDLXLtvCPvVfUlhbsG4fmOZ9sCUHTFndZQdaZyLBpVa3Zo+oRt7SNH4sFS70+T
0FxFZmff6DAYJelyyeoJSi9rs9m1z2+rOxh70BWnpRo=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 18443     )
V32gm7BMBRb88ommNcBQH4fpvWdso6ta91e2N20vaJ9oa/7ea+b0HbQ7QzD2mA9Q
gK3pwV05eI1jXW2jBjZo3+4rjOEqNJClNN6sV2zTIh+0elCGSC9lYaAR93s3l3C0
`pragma protect end_protected
