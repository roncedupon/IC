
`ifndef GUARD_SVT_SPI_FLASH_MICROCHIP_TOP_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_MICROCHIP_TOP_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP Microchip top register class.
 */
class svt_spi_flash_microchip_top_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** SPI Mode Register. */

  /**  
   * The MODE Bits indicate the operating mode of SRAM <br/>
   * 00 : Byte Mode         <br/>
   * 10 : Page Mode         <br/>
   * 01 : Sequential Mode   <br/>
   * 11 : Reserved
   */
  bit [1:0] mode = 2'b01;

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
  `svt_vmm_data_new(svt_spi_flash_microchip_top_register)
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
  extern function new(string name = "svt_spi_flash_microchip_top_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_microchip_top_register)
  `svt_data_member_end(svt_spi_flash_microchip_top_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_microchip_top_register.
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
  `vmm_typename(svt_spi_flash_microchip_top_register)
  `vmm_class_factory(svt_spi_flash_microchip_top_register)
`endif

  // ---------------------------------------------------------------------------
  /** This method returns the value to current MODE Register */
  extern virtual function bit [7:0] get_microchip_mode_register();

  // ---------------------------------------------------------------------------
  /** This method retrieves the value of a single named property of a data class */
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of a single named property of a data class */
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current MODE Register */
  extern virtual function void set_microchip_mode_register(bit [7:0] reg_val);
endclass

// =============================================================================

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
HpdQiZ/gyOWtm9+YlLinyin3Sk06xA0YH2lvM+1w6V1uHr33MPYz4owdtBVot6DL
rx4n5TVfXc+wsbp1+j27QgOQ8iM17i5KPoZtsMMHMuLkuRfiW5ZETnEaKm3mb7ol
PIPLntDLwb/JXvbsJtenl6T0b7Xg+hmdhSJ9aeue2s4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 638       )
L6nYcOyyvrIpnMKpq4UlRedbL5l5eklFT9GlgDUYgotx62WklhReNoSU9JjXdh69
Jt3z6tE1QylKrEh+FmJUsl7D7BG3uHmtqBx/nL7ddUDAOeZlcOLgCemLmKvzH/Nv
fVh2nW3xJe2XcsOjSDMGFKnvIkxE2n7PoZx4CnC/e0fhKzp50l/e7P+BBv+MoHR7
WsHOkXCM1HCsVH2zH7B77gnjbIxbbYY1l7PtxAHMbF/tjBF1vo5pUa/+mAUhS7Fc
Ekkxn0eVXybUcXk70hONb9QwglTNde1WWyeaWwyxJnffjuKqoid9UEwBwgeGZnI3
LAlf2zDPN/2UjDhhlK1Pr+HEcMXuQeeujVLFp5vFgI+iy/mbj4XmJ8Gox0yZSVrQ
KQyiDRTeBxjD9d5dRwPxPIamlIhbpg29HZX92vbD6EIaWCVWuc31E6DBIWO/k+4C
W+XEafQm0r+pKKDnkwATDEZA/cuFpZvANUtC55YkuYTEzXVVlsytyKNwbjtkM2IF
AY1hlzAupUd8A3b80BVawF++qpypziAm2mnZ3oPehGDogEyYdgz0D/7CnOUTpZyQ
lJTJbGj4W7kyOw9qg25ZGZ2mJniyu9+flX5gRKo90o8m+yYK1mGgTTslWDphFV43
n5LBP0PL1XEtXEDoTmsfK9Dow32Y8iN24t1vmK7oJxLBcQmo1acMFdcwXsXbNua3
r90tIdrPARgqObiwFkKyq5FPYh1+lFo9+2CbfQYxLfnCMBqqt21EI61TCzufMtK7
GTzSQy9di9JP+vTdbgFC3PvTZ2sr9MoyYeBYEP0RuMMz0uZGd0VoVQ58Qm2MRYfL
2i96ziRdySHVu0K52CEy2Q==
`pragma protect end_protected
   
//vcs_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Sbqzokz8U6kWctS5iFZoy4cZMXxyYMPLMwQ/jwjfAWADSCv787TZft6P5p7jnfJW
dWyj56V0JM0WGc7+GkMUSUd6O/hJlPgDpauE933m/ZVJ+KxZH4GlwXjIJNMuIp0a
xKkgrsyVo93IOkmthS9eojF6ZHuQi+evOMJqIagS94k=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10571     )
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
`pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_MICROCHIP_TOP_REGISTER_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
GtDvTal2PTmSZh5jkv98P+2EDjsQ25rRq2zJj/fJoFh/srv1dnbkafCKiZprL15x
AfietwHaoV/PePEk9Y7XyQdOHKE33ZSJ8bPigPITitW6uar68B0OCtlupFdMfmly
T3b4+4tJAhAziNUce83QzP5+JDHiaGjBNogxEi5KXOI=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 10654     )
x6sNJ0PRWT72+sBGqmI/RU4/ssBqQ7tBcJ4ldFXLIWo5zYuaqzH7s+bucWOWAZTh
uBj4cbK5NbdB6elrykNC9KUtx6dOv0O0b9zJo8nrmR8oiPhHE7nrPtRUvJUVOuZX
`pragma protect end_protected
