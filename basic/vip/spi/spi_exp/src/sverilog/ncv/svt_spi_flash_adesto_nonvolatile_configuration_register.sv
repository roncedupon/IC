
`ifndef GUARD_SVT_SPI_FLASH_ADESTO_NONVOLATILE_CONFIGURATION_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_ADESTO_NONVOLATILE_CONFIGURATION_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP Adesto Nonvolatile configuration register class.
 *  This maintains teh copy of Non Volatile fields that can be stored/reload based
 *  on requirement.
 */
class svt_spi_flash_adesto_nonvolatile_configuration_register extends svt_status;

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** SPI Status Register. */
  bit [1:0] status_register_protect = 2'b01;

  bit sector_protect = 1'b0;

  bit top_bottom = 1'b0;

  bit [3:0] block_protect = 4'b0;

  bit complement_protect = 1'b0;

  bit [3:0] security_register_lock_bits = 1'b1;

  bit quad_enable = 1'b1;

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
  `svt_vmm_data_new(svt_spi_flash_adesto_nonvolatile_configuration_register)
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
  extern function new(string name = "svt_spi_flash_adesto_nonvolatile_configuration_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_adesto_nonvolatile_configuration_register)
  `svt_data_member_end(svt_spi_flash_adesto_nonvolatile_configuration_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_adesto_nonvolatile_configuration_register.
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
  `vmm_typename(svt_spi_flash_adesto_nonvolatile_configuration_register)
  `vmm_class_factory(svt_spi_flash_adesto_nonvolatile_configuration_register)
`endif

  // ---------------------------------------------------------------------------
  /**
   *
   */
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
gtSXspwJVxOMZuGOpt3+ahoDw6HMmcoTIq0nTkWdlO+VL0pGimwYSkEbvXsq4gIx
KVJaD7vxXUbJgCk+0Hv84yaILWjKXS4V3aoeSPTfDBbSNUtDVrqfJ1lISavW8r33
FEh7i9+wbC6w2S8qZkJewAH9T9BsWqYbAWuqdfZXY+F6vngsNJhMmA==
//pragma protect end_key_block
//pragma protect digest_block
hyl4ndTuJRw7M1ZwRWNOwpheyyg=
//pragma protect end_digest_block
//pragma protect data_block
LtVcW1qJrM/vabzyneLShIbcvqphvEeizaZqSogNyV8tz9l4SlMJVn5PjLqyRfO2
RQsPjHbY1IYSCt3LRAzv1/XRBX0++s4p+fUTwgwkK+/QxObN/HxiNqfdKI+0prBo
g4BJ/f09sr/174tzYEcTw2dGIkxDzWbYPefq70UAuD8Q/im8bDfVwSl9RXarYfg4
MzkCj25O7LE8/vTH/68gAAP0a+Vbvo97YSZ1rqH96VGkmBjSC2AbADPflUIu6c0g
rQzfrD9iJHFkE1gowvZ+nj3EPiVkxo1W6I2HSBy8VCIxS3xZqcls1HajPmEMwu5D
pG1wbRPXHjipn6UrshmZZa5IlMHJmjP+jOELKOgbxHiLOYToO6QViJ2Bbm6GNTtg
FAsfczYEofErXKGULQDsjdjNNY3CLkRc3QXMMeMga9IYqXMxwG/l/e8ZFSExExW2
uVFyb/AgXHepjTfJVKRtAIsvYgavaIYoMRQpZHlR3OuulaUDCGZRcyWMht5zx+MO
8BnXABwNwrVr3dVr+0iTnIkR9kb5GcnAQ6766vAj13cPz2VKBcRWQwMneSLvI4EL
AKyZDYtcsvIcoYh/Ph0d9cIf9ryk7DTFxjmz+ZFHQRa2cOMgV8RRjwDa0C/ZYHV9
GLEF4KHKnpgp/9XhQ7b4n7cD3o7FnBkI6cyL+5WVBIhhKEJZPLqOEOAvyOKSQgH/
/RWfbi4Ti45EGY1wJgnYPJBcHfgIy9cfa0FQiiZQtMBL5XtT04uSB4kqndEolajq
n5q7wWaUeusrZGR99+QvXBzWfppyqHOKYKKYx1bQEFrbhgHNf9ZvoeIOFcx6Qkxh
l1vqB1/mZhQwZIcyWQBDd8jlcOMCSCyCCWYQGPUCaIl2XNEhJNqC0I+K2Wg7yYFv
QOFK6HQVKyuP4tKjwhp6W9nBrD0V7Wr3HSdasd1VCPTISTapk5EX+6UQOGCuPHal
JbeNQqhVEjLIqvBCytlCl4TzpHyNb1UH8R2a/xzRIeLGXlFEhm43X8MIypIqWfHT
iGgxkt3eVvWGrAH+dMDhxUZTq3SilZF5X0N6HQqyl9/O7t8n82sEuyNWHx5SesjG
Etrn0Q6J+6NygPwQ4y9tthxX3kM84Q37fBVRiDh/biS6u7As/l10ghIT6U3Q8rer
SyFNWEjEpOeCeeKvsHDAUQ==
//pragma protect end_data_block
//pragma protect digest_block
HrRaf61uAU82ha3bKEkjacsHShQ=
//pragma protect end_digest_block
//pragma protect end_protected
   
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
KKu0N3MI/Cr4pfFZ3dpy0JSaSF/0WsMIUToJbcDVNd/q75I4vyxvsr7B3DGAhKhv
qrlfOWtdABJJnR0hOCciYMkIZ2gvGyDUlQKfHWiztljaOPElqRMroHJGwRoHcF77
DZXsp2Rst7QHY42PZQ8wdrKrvLFUw4l9byDTZ5P4kIEHfZvMFkZfpw==
//pragma protect end_key_block
//pragma protect digest_block
qJd+5uOFZyfGmH8/z5MDz4pjjmU=
//pragma protect end_digest_block
//pragma protect data_block
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
BcbLpwt914/nmVc/aLmzSVdM8/0sltFOnRKINzHL0wejL8jc8vzMxJb5v9jYs7lU
cTkw7cEcJx0ZO+o8dse/BMSFdC/8QoneiQNkjvQtiwd+D16+4wfe1Qkvj2ZmrT00
ey+XeipK7DJSgRXA7nfbEbUoosyv3gk+n6yD4rA9SlEJTEEI/TF6YjPPMvqgjlZ8
cBPP4KGRaISU92SFRQ1EQi7wubn9q/pGSReZdMLHL7z+KktCdfSZOsAB0/Vt8+5J
nBLiA0B5oBMtOKIUSKf/jwprYFcAzzAhZNq1V8QBBVPkLUjqz9W73SxPFzL8ulIb
Q712ct1VbIcChs3fjyDlGlVGAlIA4h079YZ20ojddpFJDvvzIPzG0oJhKl+iwwo4
oLQcWa2eRj8XYugER3MIR2qPqcnBKw6CtTqV3fQjvIWHys/RZeH2DyDTtImLRUUK
xxt/2q3vI9WBRjmCTzlobRxLk0AclnwrjmG6/ZdSHe3JyUa+BahNSJtHUFhBakpO
yjVVQdWsmeg6ScbhPSn3Fnf2X0ciQvMxeo+fbpTCj3QSEIopA+Dl4ympwtOujeKq
XVKpFDFCMnd2ZymY8pIlfMrmr8S55TlqFiB4P5Q94928DfZRTlNj8tWaPxb2nFiW
V2b6t3Lrg4G2m67S/qUL8hJjSiqvYkO4nzFvQI0TA+IPk/jvMSWlLuiCqJHiRiH8
1Hn0K6lyWGyb54WNpUPeiRxUg3MDoX14NAb9n4iNujbl6Z/JfVWojAmjOC3jtJcB
hGyUX/IgtKtM1P9zvXBDl/v0kqZmCDTJZ5DMrUqlStwyP4UnLn4xCvBztnPNlkgM
v/hwS1kqRgtT5qJxFJHnkypXYQxsNFjKkO4BNAcyRhUERNuViIuXt/ZIT0MUKjUk
aPuaF0C+GUldKTnh3tig+i2w2LUy5JJtNRM0s444xdhQMWy/VxHSTTnL33vX4PGk
cJgti3HoyOs0Fnse9dWAsn3s9sp0TPMKXiWJAwdN7UUspB6sDHM4NRmymV5tEMnr
IDAj0x6JOd+zNCjURNn8jfgz3mBjNn6Ul4Qtj284OT6nxQagi04PtAC9TSSSkARm
MjWvRVxDTFuTdrvGjVVHuknA3NtWG01UMKXyi3wmSF7zL7y1YwvEKDW/4swbhXAn
7AXG2gDQPF74y2hEo0ie+5I260r16IvOjLtmIeWebe6xEC+srZBi0JK83IUAXJYg
LA7zwnFiRfno8Ljb7PvycnedQkpaZ7oey6WVf8tlBzd157EPzJCYG/u03Up7Cn0z
QIqJYny+YSw6QKC0L3Cx6Jg7lPFR9i3X2vHx/Pjt+veMPJijvLP/BOULDb9ALUvA
Rw7DauviYMTJen7Qwe65AtqzTNn1we/Ug3UzxAsng9Ujw7w47A+FW9wRx1kmMm8T
0hmSDkL+XxGBMzmshSe6J/+J95cDL0wJm77iFUXIUe/zSL9uOlnKAyufji/xorW0
lu9oeE3DpxqnH9BhDbgoSJDzYVXThWJVQa70nsqHSRFw/ioTzm9T2NO5f56mr4pT
9vQE8+1soCg4d13LFU0lB0qeHHZr6if8jF7eUC3DnYQ584aJjSKapHri5+WflJjf
d4fYyZSL6tt7N6OqaR6P+g==
//pragma protect end_data_block
//pragma protect digest_block
NLhtWFDWUUJJ83ydn2TW0x37If0=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_ADESTO_NONVOLATILE_CONFIGURATION_REGISTER_SV

