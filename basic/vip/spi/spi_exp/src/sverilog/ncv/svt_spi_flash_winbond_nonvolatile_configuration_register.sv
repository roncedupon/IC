
`ifndef GUARD_SVT_SPI_FLASH_WINBOND_NONVOLATILE_CONFIGURATION_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_WINBOND_NONVOLATILE_CONFIGURATION_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP Winbond Nonvolatile configuration register class.
 *  This maintains teh copy of Non Volatile fields that can be stored/reload based
 *  on requirement.
 */
class svt_spi_flash_winbond_nonvolatile_configuration_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** SPI Status Register. */
  bit [1:0] status_register_protect = 2'b01;

  bit sector_protect = 1'b0;

  bit top_bottom = 1'b0;

  bit [3:0] block_protect = 4'b0;

  bit write_enable_latch = 1'b0;

  bit complement_protect = 1'b0;

  bit [3:0] security_register_lock_bits = 1'b1;

  bit quad_enable = 1'b1;

  /** Output Driver Strength */
  bit [1:0] output_driver_strength = 2'b11;
 
  /** Write Protection Selection */
  bit write_protect_sel = 1'b0;
  
  /*Power up Address Mode */
  bit powerup_addr_mode = 1'b0;

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
  `svt_vmm_data_new(svt_spi_flash_winbond_nonvolatile_configuration_register)
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
  extern function new(string name = "svt_spi_flash_winbond_nonvolatile_configuration_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_winbond_nonvolatile_configuration_register)
  `svt_data_member_end(svt_spi_flash_winbond_nonvolatile_configuration_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_winbond_nonvolatile_configuration_register.
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
  `vmm_typename(svt_spi_flash_winbond_nonvolatile_configuration_register)
  `vmm_class_factory(svt_spi_flash_winbond_nonvolatile_configuration_register)
`endif

  // ---------------------------------------------------------------------------
  /**
   *
   */
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);
  extern virtual function void set_cfg(svt_configuration cfg);
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
x3xgiA+Azx9GS0ZGBan78fk704Q4iQiCy6o3Geqe2czbV42Lh5qbSY6VZ26XjDc/
Xl8mG8jZv7wVFwbhvdVEeZYbj6t9GpSDFXuHcE+An/1jQ+WPbKxX58s80FJf5om6
3L/RjM3Xu4ZTu0xTFqovcQg37JBy0lkj6vLSBrG89dhglMYXEXaXIw==
//pragma protect end_key_block
//pragma protect digest_block
sLA/YIJDjGYY56xNXjEvAcBFLbg=
//pragma protect end_digest_block
//pragma protect data_block
dVZmHnuzyS0RbtL6IA3+02rMz1JQJfLbDyX/07gPF6ui3vVh+L/D6DbQ8NKWg1Ou
lwQu0JXf+CnDqzq+JrveWuzOusIxSax+YnQNf7BGPGwaATcWFfFRV2zDwPlrODNc
6UHk+FchbXqGr2jIDIVxFu3Qp7dsRaZZeyObzJYcXgh4c5k5N+aUPQNkJ5HnewLQ
Wu4QGYGRDUJ7F/IIZbwKp6TLA7IUbcO7CjO8nErfg7Y+3fzSUlw+f8NS51frctK7
y7wsBiPfFkuVFHZ71+9seJNcxo3luicLWnZIMNWNPr/YOClIArBGWxl+RmCbi+vl
/Gppun/1AI01iRa3m0SYIQTguTBdCN45W+zQBJkuvYMUZKTrVTAEpc7OmNU4oJ4v
hwAvpq5gygsVvyVg8axI6oB4vHIirxQaHveKH7sjvvOIlsa7jEz1sFQqNtDY/2uH
P+UmGnPxxPCMvXlzs7RLMwnMTkOrGnoAYRNouXiWmVOzbWDYYmPJLCJhOmY5MMuN
HlQmWofYy++0R8s65s6bm9IlrH+8WjwgnmT5OAczo6bQj72v4aBNdcOz0ymcvQ7H
DnPiSnB/AfgYdCUWrcG/4WnOzA2U+Jdwn2IeuweeGyNRbDt+ncb0A68noD8E4BsT
dty/kS2owYrcneqjUsHdSejBc3cUlL2bZ4jTCcSDVv/rQpAG6gOlLv/JnBnpA7ic
dyop4A8ScrgrJm40QZsQ05V+dTyN99atDrrNbDIZuIqpZJlVf9ZQ6CY8r5V6WkhR
pVwSX4DuRYKJVSbWWprbRXV/3B3gNlXGizQ4TotUkwLrFGEeCJ+Dq7NFvciHseC7
C5R/Ly4iI2mARGm+xhi9A9kkGk3AVa2mZeemuJMqPGGNyCaoPWY9g03mVeS85EFe
+WhVk38vmN1jbZsy+KHxEvB/oaYdkGTIXz88xnW/b5ML06kivyX4l57L1Kt4hf5H
3r9mUEVoWEw/pwG1tnocO/s52IhRFsdZiZzo3tx/fWEmhZE0a6ciwFW8xxHDuFbG
yMxjZnZ2htgyb3YxrlXl7ziawPizQHyluw2Iyd+GcOG/mo6SKw2bSYn8vz2FRMA4
GQUAisRe9Cbo0LFWCzh1YqPAOgb7i+JR0EZYOQZzwTLbK+3XSbJ+8Tnj+00xrHnX
gbVWo/Nx3PQeMkDmVnXTjGwZW5m27gwm/fFVKYb7YA0=
//pragma protect end_data_block
//pragma protect digest_block
WR6AjDbnQt8p3bBh807tAki855k=
//pragma protect end_digest_block
//pragma protect end_protected
   
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
MyEphcpFdAC07cld4Z6HIVkVE0ioaM0fm8qa4kiexGAmnr805ED9/iDCf+BoJZ/Z
ZqWwnhUoLLu6Yk9AbIFsnpxfkB8aAv7vOMmtwmcO6R8mn8ZvK9DfGuqOc0/C/Hbq
CHElKVU9U0t2GDOBTR6HPf2guHtWs2wR26gRsct8WG0JpVouyNgA1g==
//pragma protect end_key_block
//pragma protect digest_block
Mw1rBB9ZGVCflKQjOUbzIlpoqTk=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
fngk2cr89c6p0ry0qdZ0HGSsl8E=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_WINBOND_NONVOLATILE_CONFIGURATION_REGISTER_SV

