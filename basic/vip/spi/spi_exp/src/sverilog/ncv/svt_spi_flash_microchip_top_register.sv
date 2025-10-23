
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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
oTbzHeK/K7tP4yaOh0CFU+FZXEbY0P4qXaAGZYF2VFX0c81Bo1WdGwzIBargCS1R
mLYXKaxHUDoXwiSPdmUTMRNi5l06vxib0KXwQkq9yYz6TwPMhHCGa6EQoTaJ/y+R
eI2y4HbJnQFNwlhFOUTza1xXbBJDjY2tx4xfc5bWEPh3Rdz0zVrWYw==
//pragma protect end_key_block
//pragma protect digest_block
dcibGuu3LVKvyBLxFH0Q/WpCV8g=
//pragma protect end_digest_block
//pragma protect data_block
U0PTZ/0Vv0aSGOHZucbtPKOnretxCrcfNAGjtpibVcuEGcLFH0ExtWlV9zZKTTaL
4ka10x6G31Sk/msz44GbbXG/8yNN4ixHB9USJ9OntosH8mooZLiK/pqpYbOXIER8
IWqyfgfHpr8xYEcVBwqBdhi/rT/PfxXyX1lhryEYA5zsTvzkroFCOXukqRmGg5L0
u+zHyXAelz7DCT9/NcC0RXU7UpUROn0vbj6a5Kb0/5QBX9ZF9dF5sXofo9HXizQg
WQVUGNxVqf88mbbONgN4SCizQFsMbTla47onUpxG5xtw9lwz5wjEMenzzUFSIScL
AaQtIfnVNLXFcrN88tvebeR+yM0eN0uB2ypLYBy3qc3fmZLRtE2I3k9eGxTWtn68
/ZMy4KQqbtKAM9bpsKDRC/jlR0Hhl2hMCbovEeOi9ukFCE1mbla0JPhjAb4lAoin
ZPeXJ1zMpxJgDVpXccUCzFRu5TH1nAIfdpOBWvf4+GigT773GXp96CflTF4Tqetf
x/eT4sFM2ww9XWJjjIRHQIoL3mCK2qldBfkl/67fwEnEdoG4eg2nB3qt0TqEwMhe
e0N3iTVXVOyhDif0NK4xiIVb8W7Uyd5W1xWmSlHPcTxM0cEClENaI8pkJd1e+SgF
cCc8THwB7D203Dlg06sre0xAqIHyJ+EMj1aBCM3lOdR5qNimnWw5QVQbQG5BGRpX
s23k7NaxRMMk/SXyOjzydH34uwbCe0znMeZhHiG8fyqboV392rb3OQyS9PjldlR8
8ikkxW1JXYYnEgg7w3oJyoknLVqFK289b6lbxgz4YOXY654GQ7zd81XtYvNkp1t1
eR+i2ua0tY5JGgwmK+VQOYzXBCwezi7xPab8ehNVPt3a75DmOHJ/m6KRmyaFBqYa
IIF+xwbZl7WWdfDrcGi11V7K+RoC/jBQ1OUI1IlcBm/asyeGb+SbWMVvnfE+3aO2
vNMHGlLk7QuLY8lT6dDQqNTcPrDl69d6WoO2N0GPxGj41egEmiTmZ0MkkWAuH7aG
Wwjfn48Uro9iJ/X25Azx82q0D5ebj67VK5LFPObgF+xMYEUW6OzR6UEhD590yMSk

//pragma protect end_data_block
//pragma protect digest_block
6PxoqBNUYHo8dSEcle78zvv3tfI=
//pragma protect end_digest_block
//pragma protect end_protected
   
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ODK57x5nA0YlUyOGRE4Yazg6kgZA5oCxVUtwmeGjWefOnYy4PjNFSkEUzZdjysmz
zmVY1sWLMsoLI2HHfMjoxmmZDIKvstCTk4Ad3mVC1vPaGcgsFcCQ3NunHXKGw1MF
J1Ni/WQO8CUhiKONtw6gbHmmpLkey3sthpkwofYPTxntSvi0PyxVDA==
//pragma protect end_key_block
//pragma protect digest_block
laN//dcjbYWrPuQIbaGgwsiuQcA=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
FEU1AcITKBn8RApzTYC0XMEemZI=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_MICROCHIP_TOP_REGISTER_SV

