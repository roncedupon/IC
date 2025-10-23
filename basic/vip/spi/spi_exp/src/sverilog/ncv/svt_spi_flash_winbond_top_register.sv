
`ifndef GUARD_SVT_SPI_FLASH_WINBOND_TOP_REGISTER_SV
`define GUARD_SVT_SPI_FLASH_WINBOND_TOP_REGISTER_SV 
typedef class svt_spi_flash_winbond_nonvolatile_configuration_register;

// =============================================================================
/**
 *  This is the SPI VIP Winbond top register class.
 */
class svt_spi_flash_winbond_top_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** SPI Flash Winbond NonVolatile Configuration Register Class Handle. */

  svt_spi_flash_winbond_nonvolatile_configuration_register nonvolatile_cfg_register;

  /** SPI Status Register. */
  bit [1:0] status_register_protect = 2'b01;

  bit sector_protect = 1'b0;

  bit top_bottom = 1'b0;

  bit [3:0] block_protect = 4'b0;

  bit write_enable_latch = 1'b0;

  bit busy = 1'b0;  

  /** SPI Status 2 Register. */
  bit erase_program_suspend_status = 1'b0;

  bit complement_protect = 1'b0;

  bit [3:0] security_register_lock_bits = 4'h0;

  bit quad_enable = 1'b1;

  bit [1:0] dummy_cycles = 2'h2;

  bit [1:0] wrap_length = 2'b0;
  
  /** Output Driver Strength */
  bit [1:0] output_driver_strength = 2'b11;
 
  /** Write Protection Selection */
  bit write_protect_sel = 1'b0;
  
  /*Power up Address Mode */
  bit powerup_addr_mode = 1'b0;
 
  /** Current Address Mode */
  bit addr_mode = 1'b0;

  /** SPI Extended Address Register. */
  bit address_segment = 1'b0;
  
  /** Block lock array, indicating individual sector block lock/unlock status. */
  bit [7:0] block_lock_n[];

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
  `svt_vmm_data_new(svt_spi_flash_winbond_top_register)
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
  extern function new(string name = "svt_spi_flash_winbond_top_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_flash_winbond_top_register)
    `svt_field_object(nonvolatile_cfg_register, `SVT_ALL_ON|`SVT_NOPACK|`SVT_NOCOMPARE|`SVT_REFERENCE, `SVT_HOW_REF)
  `svt_data_member_end(svt_spi_flash_winbond_top_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_flash_winbond_top_register.
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
  `vmm_typename(svt_spi_flash_winbond_top_register)
  `vmm_class_factory(svt_spi_flash_winbond_top_register)
`endif

  // ---------------------------------------------------------------------------
  /**
   *
   */
  extern virtual function void create_winbond_nonvolatile_cfg_register();
  extern virtual function bit [7:0] get_winbond_status_register();
  extern virtual function bit [7:0] get_winbond_status_2_register();
  extern virtual function bit [7:0] get_winbond_status_3_register();
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);
  extern virtual function bit [7:0] get_winbond_extended_address_register();
  extern virtual function bit [7:0] get_winbond_block_sector_lock_register(int block_count);
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);
  extern virtual function void set_winbond_status_register( bit [7:0] reg_val = 8'h00);
  extern virtual function void set_winbond_status_2_register( bit [7:0] reg_val=8'h00);
  extern virtual function void set_winbond_status_3_register( bit [7:0] reg_val=8'h00);
  extern virtual function void set_winbond_extended_address_register(bit [7:0] reg_val);
  extern virtual function void set_winbond_block_sector_lock_register(int block_count, bit [7:0] reg_val);
  extern virtual function void store_winbond_nonvolatile_settings();
  extern virtual function void store_winbond_nonvolatile_status_1_register();
  extern virtual function void store_winbond_nonvolatile_status_2_register();
  extern virtual function void store_winbond_nonvolatile_status_3_register();
  extern virtual function void reload_winbond_nonvolatile_settings();
  extern virtual function void set_cfg(svt_configuration cfg);
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
5buNEWfmqAf2OoVIf87de+b+riWZYb/w5NarpHK4ceaV6qLGLQZIdg2Y7skhBVej
v94PbffgflLjLGCEo1rs8sAwMR1Ldu1E2VGuVhyzmEmO7pkzbpJdRdDnLBCw453S
piZejYcKzp4lTZjtCrU5u8szU13paLOUahRO7b5duylOYzUH1AZvIg==
//pragma protect end_key_block
//pragma protect digest_block
JNuRgG7XV034pn1m4Y8oEuF9UnE=
//pragma protect end_digest_block
//pragma protect data_block
+Mc/yq34dQbrl8mEn7gTVtFLzxlxHzaluEwP+kM6X/5Pn5HBiq2Ii7j3UfxZt5rL
WmpP60zcKZlk8eR3WxcMDqJ4WiiZQz6q+p0REA6NjViGQln1VzbTAM0xerlRrnJX
NrJvxyKeHg978eRI8lvICmHrQklWsusbzn5Y9Gm1+rMbMEggC+R+VYmCdytq8w5g
F67ct/W3K3mzpYnRcDVonzvDccY4bI6SdWSj1RopdErOvoB8Zs30vFrpwcp+M5Zd
DdJQ+9KSQedU/IX3v2yIvnSvFxT93Ej/LHKH3PVjIVjkHyeAkguH+W63jprDZcPr
36TAb4KXRKOENZPjQn1SDi4FLpyHhjHhzo9uQQv7IJ3QRphL/XdHGE2sGXmK4RKj
Lk+14l/CRB5OSzCSo+o6+FLhdMD3BMw5JUnms9HktuzeMZYFd5+GIHb+7RCy4u1e
tDWawTI+BjfTBCEj+Fj0RG3dPgxGDVdIYO9Yrj0EM5K6cHiylKai33zNMeefjbFR
+uVqxb2cvdVIE+PtO39YTwc+96TbjfCDwpl5zaKsrvqWnyAaDu6p4JNRALq/HZZp
aeIMTmvXTJ8guJBp6TuipdXPFB1n6OhDhrdwy39snpIWOWmlm10/i53S0bOHOUz9
WgCVkfLyfdTJOw4ZquTQ3/WXLIeECuSgLAEnnZm0JpTm9+3870uVzRc025dt2Ukf
GeRlVGYbhZZM+06P/EE17YTz8DfB/rRTUYMadOKG+Q4LxdLOv89EGDB3MUfP5JVZ
/7/YJyog+0udq6p2FUZc4W7l6pPpdCc1VKO7UpO79ClztFuqA7klpnB7+3N2J4lm
KVRizOCThFlkyaA+u0Lqscr7Hbi8eZMxqO522U+2bLHjTQoV3kzzM4/zxMfT9O8d
5WCBIgcHEE3JGY2P09JcCvC7PWOteznDqnje7sLrXG2PhjLXRF/SzYYqCq6wX2Ug
S75Brylbc5GHtWf/Ozk2tDVSKKZdAUfUS2cAS/exQ84I/hXqj6IoUU9548/yVgSo
eDTVUvQzPDigtIZg9wZ78SmlolUmgJwVUMdc3Jlv3Pk=
//pragma protect end_data_block
//pragma protect digest_block
7ocoPf8A53nmPtt3mh3l/J1kHK4=
//pragma protect end_digest_block
//pragma protect end_protected
   
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
uDKFocB1YLm9L7/EPhm2+4MVzXHZ8R34D6ebJshwxjxtzcmLJfMvNW7SzR0QTfMI
Y0efRK1lfPxMVrh/9PCxFh1O7fOQeWpinIdokVaTlmRYfY7GRP/nSb2dFa/SHb2f
s5h/6AE2vPak0S7NlpG8HBWTlYrRC8cHRwfh5RNAw+4qnCepT7Cm/A==
//pragma protect end_key_block
//pragma protect digest_block
f38Dg0QCpLnGy+QBICJGJ0qiyZE=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
IPMmDCP53/fDCKyG2K/69iLdtdo=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_FLASH_WINBOND_TOP_REGISTER_SV

