
`ifndef GUARD_SVT_SPI_xSPI_JEDEC_TOP_REGISTER_SV
`define GUARD_SVT_SPI_xSPI_JEDEC_TOP_REGISTER_SV
// =============================================================================
/**
 *  This is the SPI VIP xSPI JEDEC top register class.
 */
class svt_spi_xSPI_jedec_top_register extends svt_status;

  /** xSPI Flash JEDEC NonVolatile Configuration Register Class Handle. */
  svt_spi_xSPI_jedec_nonvolatile_configuration_register nonvolatile_cfg_register;
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
LyZ7j+6/utLBHAyncZZQcMWc+WJF99qPWvpnM4pC+FKXrffMSacHmOXF0F0qqpfo
IWOW90BlD7dOQS+Ru0UZSuTPBx9mXHZHjP5D/kOAh45vk7feeYKaPA2rZF1fpzdT
TczJn5kpoeHarP0M9XIqv3eP36NhQ2apsmPMmvbjeNQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 336       )
9moOKFJz8gnIAKwOlmHirX/poTb+iPyYRj+7oE4B3LGU2/2B1UvVAj6pVRJacW+P
rBKaN+7uoV51ViAaxF05rTzoRv5gTAdxwhIFPNbruMpmn5+vJT7JuHoXSZda5odz
FN7GtSlFxZEbExEHOkCtcLhTJAgG3a0g93GFoKcYSkzTmiqGGjHtlOhsjGnQF/Ku
s0wXH8+a3rTXQ8jQ/9EsecympZOTvkv8I7Wtw/6v0QrWocnmMcsIeMIKpChfjfAy
JP7z66HMyEw/apCQcPad38zlAFWx4Cz3xCfizaYk3A6bCbUzamdbkWVB4g4ZBGO+
/LSLgEPSVzxaKblUNV3x1L9E6cIG/3ms/vrLQhJad+R16iuZTLEH3RWeUgC0dWVl
eRIOhl+XpDGxZPQGm9iViVW2qng4ucbvsKTcO+jPIQp7f/5rXETmwPDWsy9MFiO4
xdL1BFwWU+EqAc/v2vRqig==
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
  `svt_vmm_data_new(svt_spi_xSPI_jedec_top_register)
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
  extern function new(string name = "svt_spi_xSPI_jedec_top_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_xSPI_jedec_top_register)
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
XsipT+055Th3Lo5lPnpikKjH/gDRIAs+IiLu7sZDACcMMC/klNVuHMTu1cXlK//D
JH0pMhsTmO6pD/AYON32yqKwU09Dyv6sFJWZX+vBQH+UxjJX/TS/9KEG+UghMEhl
AEMehc+Q0KfBj0h+4NbwhvqGWgjqt51OM4LyZCqh1uE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 539       )
07E2o2I8PfcX9fWqQYV40PU0G5p8wpZwBRXWh5SUdpS2bXvg9mfPiHB78rj3zu6U
9u2S3lDHafM0flJr34U2lbfaIV5wxKKJrwCWyNvwd6xkkK4vk3kTSWAwgiLnp3YN
f9UCJG8rvDv0DisvfYriIzGoPZ6W0Li24jnJJ0hnsUEoSHglMPZ00ktkfupmrbBU
wz/y+XBn8hogMcM/P6Vlj6sLA/Y53FTwjGco7jjjoPh5y91RGwVSPzG31c6AS9AU
9IviJmpA7ab4NJcOc9H9AA==
`pragma protect end_protected
    `svt_field_object(nonvolatile_cfg_register, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_REFERENCE, `SVT_HOW_REF)
  `svt_data_member_end(svt_spi_xSPI_jedec_top_register)

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
   * Allocates a new object of type svt_spi_xSPI_jedec_top_register.
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
   */
  extern virtual function void create_xSPI_jedec_nonvolatile_cfg_register();

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
  extern virtual function void get_xSPI_generic_register(input string reg_name, output svt_spi_types::serial_queue reg_val_serial,input bit enable_profile_2_0_mode);

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
  `vmm_typename(svt_spi_xSPI_jedec_top_register)
  `vmm_class_factory(svt_spi_xSPI_jedec_top_register)
`endif

endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
kt7B9sLst+f6gAjCaJdWqKhVLipf+ZYd7JUP70za0j2YIZzVJ21XNtvYgXctwAgo
Ry7OdXzml3QEaT9L5qo0j8rm6E4cAIOw7293Wqkpi1gEB5/BOQ9rIheyYxg4F0Mu
gqYUSX2kq/SmOqKsAKJAaHL0oGeDfC6alS/9ty3nwfE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1157      )
NAFtr4N0tJodjbxwtGYltXRbOSUmaftporbNVRajwx5gufdFZAq/nRc0D35AuVeQ
/8Xbx0DHYQF0V+lL2mauiv2UDjdgg5s+inKRYR8LXPd+oRNg/u3Zu3pwVzLClbMd
9P2Re0kn7tXPiNIa0fIwZjWZjxTg01TeAwlz2A6C1gVQMWCqOjQ6z1NaB5jhKKCj
RC/Ry/X6xUZy+7supJm/L+8jo/tnDG0T8lxQ5gNezgsLpg9MjrYb6Bc6fF8pl+hv
EVmZ9AusIoCNTMURo328F7QaHasWWdzKiyCXjBUcr6NMllxOwoakh0hdEU/Vv0iH
Rs6sqX0w1C51R0r4ZByACMMD3/fxqC8vg0U2q8/XyrvsvD4JjsLbtEqR080+ewPP
W1BFOakOog4UOSkrI6gCE11BehIxfacEdSFXubCyYXNrkmeZzSorUYlwEilsUNYa
qDWUjW3o+5M3NwPeq5QSkpqVAv/0/bAwZObYLTgRSZ5jteG1RiBPgUoybOxuNefB
Kyka9Vch5Q8Uv48Bk/sYPZk3fjLVxyuQHhDKQTTydLLAsyluf/4AHqYt2jZShmxw
skopOuvOjMlbZiBvf/XCiv8QLMVSfgILD4GR/mEUW4zO41VfsYSXYDdi2Xzd2GU4
XLI3tkKkREJVzj4gUB81vudB3lQyEUz4agy9SxN56wqEKOD3rzcXQw7/AHqYPpPU
Z+lqBi85IskU2COCkU8G1WQLBaXVgBQN01IcITBn8sSsIBrjkgNfJFVtWCoaSFTg
YUKefCMG1kmMGJ7jmXBF8qROL9Oj8HhcqAkJHskfGcAlfgiHUkBtPLVhZLPe8L+/
`pragma protect end_protected
   
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
QGxiuqqcfkm/t+Ok8RfOGOxVWBbt4OazMLw7+FtkmYbM5vJW447WqrE5g5a2MFJK
MKAtyCO3GtuAP8FKs4rw7V+0m5fmIatl3zivaQk3MUxsazAMD/jsrAEyKOf4qz/H
tLJt8aFgud49dQqMILkCYXnvXdLASepI7T81Pt5Qsmw=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 16781     )
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
feFlKaJ1nkxuwmxHtOpurEcEfoGhXp54uY9pJ+5WxSRqPQlNdEBYbwGdpG2hMAWP
dojJ+En/wf9ddf42saPCnN/F4t6WQ47+TxDM/joHIH4JOWLDceC921MFFpgMXWzW
UnudU05gk2HXBdK0Y+5D79D8rPNmS4hYr+cjqmkTV5i7vWTpGoZ607X6tQdLdOHr
n+FmHfxZouIdKGuRzD7DDwC9mB9JhVjgp0yqfDTUsxBlK3Te3qiwcpWz5+KJFCvQ
3RSynXj4MtsiTvEcaeB9ne4Ilo5/Nglw+DfTzxLQD6CogdrWaSqUDN/ZgMkLh/l8
NBWUV7sOPzbOxzfPotXV9hP02ZMBQCqjn8JJFhgHmHy5dALF8CZfpA7wp+bePwAj
G5RWn70OeXtgTIDxc/z1H7jUO20yFaTqCKkCHgkpuuZA+2yfc0R6D4jZ87Lr+Wqr
v5NWnX76oS0B8yvingDjKCf63MsFD675WN/+hqE41bkvP7mDnSJGSDJCPT7+4y4l
9zLuXVT6tsjy0s8bJiu+9M6fR6cynvV0BSjy2K+r3h/dZWB3HM0N/tc9dIqLQEHN
jZhVaQkk/Rx4AclhrQ1Gqf2wcMmqS4FnbyvLcFhnzfsptBuSGiLk415UFQGiQ64w
lnr1QIyFScF6hA5u2HlgOg00DOnLgYn91s7EE910mbmyc5aafe0oSaV0djatc/Qg
pgWxgnmHv4Vo/pu3C0HY5LO2sy50ikU0KKF3C22RzGFZ6p+Fk88JeAvUAT40x8L3
b8dakouXf6XExEeu2sAjniUg0wq9UfgPPApuGVRzTy8f+cESpgAPfdgH2XUZ/+g+
MpjmQhF/+JRe4x+eVeQIpkaqGFwl0vo2uxnamg1U6ZzgTdAWolE8R9mbe6A0KY+6
NihC/eIuFcnipT/RfmAl9z3P5KWjxrYuUJ1de1ZyH42JCOBSyeQSy0X+oCnA0DQm
KjeIOu4TOJWRusfqiVYVazkEDyP4Grw1BxjNAQICqwo//vtCVSgYmSmDf0FzZY0D
o1GChuGWVnH9fiab3q9L+vMy4rYgVaKSTT+IUe/fYYyPzNOtbImrm0XdxHIgp6ev
5Lo+Cv0yWrjLX8JnK72hiXBg/ppJv02J7vk59npqVvzRH9j211ekuo2IvjSojpNT
Qf7vM1vcq4+7FTvkmxHijUL3o40+x8UzoRIxMSruf2b+GodN37Hj+dIQtND8qhPC
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_xSPI_JEDEC_TOP_REGISTER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
NbiSR2D+p2s3SwSaGPzSBzyOiyBU1yrQDST5LKENY4DpFUDDh9r7g4ROvee2Ns1e
75OMOu5BebxnV7HfVVq9xw5bHQJuAIVeWkWsV2gUXXd4n2roaf+KMX4L4IYPVFB1
Or0rpdaLzXz5CEXmo/hGGP/8WSZP2F5lyGASjUsg9eY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 16864     )
8/vlupjE5LwjTx/cPaX4FgwHDN5/vDRnMI/VfUmWrns8Juz5anCPiGTad2E4SN/8
5WY6T8kgWwBEd8k1YUAnM23rZlmaMhsWxHlV7VnFPkEU/pqiYB+kYRn7r5+8YjfM
`pragma protect end_protected
