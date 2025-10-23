
`ifndef GUARD_SVT_SPI_FLASH_CYPRESS_TOP_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_CYPRESS_TOP_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP Cypress top register class.
 */
class svt_spi_flash_cypress_top_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** SPI Status Register. */

  /** Used for enabling the function of Write Protect Pin (W#).*/
  bit write_protect_enable = 1'b1;

  /**  
   * Defines memory to be software protected against PROGRAM or ERASE operations. When one or <br/>
   * more block protect bits is set to 1, a designated memory <br/>
   * area is protected from PROGRAM and ERASE operations.
   */
  bit [2:0] block_protect = 2'b0;

  /**  
   * Write Enable Latch indicates if the device is Write Enabled. <br/> 
   * This bit defaults to ‘0’ (disabled) on power-up. <br/>
   * 1 : Write Enabled   <br/>
   * 0 : Write Disabled
   */
  bit write_enable_latch = 1'b0;

  /**  
   * Indicates the ready status of device to perform a memory access. <br/>
   * This bit is set to ‘1’ by the device while a STORE or Software RECALL cycle is in progress.
   */
  bit ready_n = 1'b0;  

  /** 
   * This field stores the value of Status/Configuration Register to non volatile memory after
   * Store/Autostore Operation. 
   */
  bit [7:0] store_status_register;
  bit [7:0] store_configuration_register;
  bit store_autostore_enable = 1'b1;
  bit [7:0] store_serial_number_register[];

  /** This field Locks the Serial Number */
  bit serial_number_lock = 1'b0;

  /**  
   * Determines whether the protected memory area defined by the block protect <br/>
   * bits starts from the top or bottom of the memory array. <br/>
   * 1 : Block Protection starts at Bottom   <br/>
   * 0 : Block Protection starts at Top   
   */
  bit top_bottom_protection = 1'b1;

  /** 
   * Configures the device into QUAD IO operation. <br/> 
   * 1 : Quad IO Selected   <br/>
   * 0 : Extended or Dual IO Selected
   */
  bit quad_enable = 1'b0;
  
  /** Flag that indicates that if Autostore Feature is enabled in SPI Flash. */
  bit autostore_enable = 1'b1;
 
  /** SPI Serial Number Register. */
  /**
   * Stores the 64 bits of Serial Number Register(SNR). <br/>
   * Index 0 represents 63:56 bits of SNR. <br/>
   * Index 1 represents 65:48 bits of SNR. <br/>
   * ...
   * Index 7 represents 7:0 bits of SNR.
   */
  bit [7:0] serial_number_register[];

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
  `svt_vmm_data_new(svt_spi_flash_cypress_top_register)
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
  extern function new(string name = "svt_spi_flash_cypress_top_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_cypress_top_register)
  `svt_data_member_end(svt_spi_flash_cypress_top_register)
  
  // ---------------------------------------------------------------------------
  /** This method sets the configuration handle */ 
  extern virtual function void set_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_cypress_top_register.
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
  `vmm_typename(svt_spi_flash_cypress_top_register)
  `vmm_class_factory(svt_spi_flash_cypress_top_register)
`endif

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_cypress_status_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Configuration Register */
  extern virtual function bit [7:0] get_cypress_configuration_register();

  // ---------------------------------------------------------------------------
  /** This method re-stores the value of Stored Status Register upon RECALL */
  extern virtual function void recall_cypress_status_register();

  // ---------------------------------------------------------------------------
  /** This method retrieves the value of a single named property of a data class */
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of a single named property of a data class */
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Status Register */
  extern virtual function void set_cypress_status_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method stores the current Status Register on STORE/Autostore */
  extern virtual function void store_cypress_status_register();
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
F54lj4DO6PPoVSC9ELQ2ieItV15dxDuXTBvNKxAFb95azECCO5faDEWeooDS0cjl
2EfsEGDeNigJyXfyFd4WkBGypy1rw0DTEzwZXnimNxUJtWLZUZNSiAcVVAYyBb17
4bGfOFORTQRT0VvuLPm0xC9acY5baNkW6NMyo9B0zwm3s+s2QaV+qQ==
//pragma protect end_key_block
//pragma protect digest_block
6E64lRUv1PTeclPO7+KDjjvOOSE=
//pragma protect end_digest_block
//pragma protect data_block
yTpDVpiBgoT/ybDz7//0Mp0u3J/Fhkh5CYG9vMUAgXEv1jkU0kYM5+sNI5Y8kZK0
0Rjuinr2NyW7CeRQZ5wFg4DiPRL/EHNuscmeOKtYcL7aAk4wGCZPJqevky+5wW2y
a1k50pDS/9Ezu6iOBaT4lWOVHjDW50atkU4kVt7aXyMb4nkO5uY525LXN8b4jpqP
izSJaf9Urakyvj61PpJze1EMrKBrQDV4kAnN3wNflzNPiZd7DxGZtycSxOPf31E9
3xDBscRd/OxUB03IXZRSSIMZJJh75PyTrSPJ9aDwNJmfZWgAEBDsNepRhXZInPIx
eVq/75pe40KcYorzvEr2CqZDXO68M4W/bfarynph9h33qoTIEaR/6dMLgGxLL6CK
Ao18iMBj8Eyoe3ZaUh+wShtRIi0TpxMLNE2uDuyudcRWAdqGHPCzDAYEnCOfGDwt
wo1E3f6/gyMZJsOq5UiEVlWGPie1ZHU5lZfa6F7bcBVqDlLzer6AFCOi/vie5UCq
onUxdBEQMQLC8LayIV2vvJplOd9Z5lCiZGmD8lbsKn/MuxLQoP9DIKE35mzX6ZFu
9mJea4jccXm8sitcZ9tSL7B8rsMYAAPl+o+SqmCDIogjPw3+3E6VsqNtdwerfw6u
paEgrPrQamSRDv87jzSFpq8Ta07XNTDwffKyjwh2o3kO5TzIPXIZ/y6g+vbir5ZG
DKuveMEGUVa9SWCknlb5xMELFc2be4raX+NJp/TAUDClG+s4YryUZz615KpHN//M
Pt+rk/ku/ANBDHrs90BEedxiBgFBVemuUVhmOGwKUOFgIFtGL1l9tpnhGsRlDFG/
HDvLeC23x6yEkyHC1HjSI9upgI9N3hfh+KeivVDj6+x1P82UO3g2Azm4hl3xRC+h
3Xn24ybVn7WCj4Xx0GTh7ohYWi5HIKFWkpsi4JN/+vt6XtEuO3M1iIRcEfF5ZmX+
TYjY8R31s4JgyBkANj55cF4sOr7LC1xYB/C3tNvJL/BnAeVaqm7y7tK3TR1XVBvc
CFDSXb3KSrvQ2mMavlQ15raINGTBKg3BP1W/hhN+wmo=
//pragma protect end_data_block
//pragma protect digest_block
7aUxiEc23WFO7iBWItH0kC62qic=
//pragma protect end_digest_block
//pragma protect end_protected
   
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
ey8ftEvYL62BXUq4j1hi0/hBXzFZTa+xO+FIIYvZH+W+N/CJbAZIoMYm0U24w/02
kYB0rFyDW1mtC5k7As5FwCoBKUuL0suMIwz6PM3sL4tc0CssYpXDNHrpp4sskDi+
8XZ5z+2gu4Pb/Mby3HvLvbVLazP501TRpcMwd1KEcVAU+6CiYI3yng==
//pragma protect end_key_block
//pragma protect digest_block
9lDcUL97cqsKTMv0fQtUR+UOF6o=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
uhvm9+DVCSv75T4p603D2h8zMiA=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_CYPRESS_TOP_REGISTER_SV

