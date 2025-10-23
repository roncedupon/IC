
`ifndef GUARD_SVT_SPI_NAND_FLASH_GIGADEVICE_TOP_REGISTER_SV
`define GUARD_SVT_SPI_NAND_FLASH_GIGADEVICE_TOP_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP GigaDevice top register class.
 */
class svt_spi_nand_flash_gigadevice_top_register extends svt_status;

  //----------------------------------------------------------------------------
  // Enumerated Types
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // Public Data Properties
  //----------------------------------------------------------------------------

  /** SPI Protection Register. */

  /** Used for enabling the function of Write Protect Pin (W#).*/
  bit block_write_disable = 1'b1;

  /**  
   * Defines memory to be software protected against PROGRAM or ERASE operations. When one or <br/>
   * more block protect bits is set to 1, a designated memory <br/>
   * area is protected from PROGRAM and ERASE operations.
   */
  bit [2:0] block_protect = 3'b0;

  /**  
   * Determines whether the protected memory area defined by the block protect <br/>
   * bits starts from the top or bottom of the memory array. <br/>
   * 0 : Top Blocks Protected <br/>
   * 1 : Bottom Blocks Protected 
   */
  bit invert_protect = 1'b0;

  /**
   * This is used to reverse the Protection set. <br/>
   * if set to 1, previous array protection set by #block_protect and #invert_protect will be reversed.
   */
  bit complement_protect = 1'b0;

  /** SPI Feature Register. */

  /** 
   * OTP space can be protected after Programming it by setting #otp_protection to 1. <br/>
   * The OTP space cannot be erased and after it has been protected. <br/>
   * it cannot be programmed again.
   */
  bit otp_protection = 1'b0;

  /** Configures the device to program OTP locations if #otp_protection has not been enabled */
  bit otp_enable = 1'b0;

  /** Configures the device into ECC operation */
  bit ecc_enable = 1'b0;

  /** Configures the device Bad Block Inhibit operation */
  bit bad_block_inhibit = 1'b0;

  /** 
   * Configures the device into QUAD IO operation. <br/> 
   * 1 : Quad IO Selected   <br/>
   * 0 : Extended or Dual IO Selected
   */
  bit quad_enable = 1'b0;

  /** SPI Status Register. */

  /**
   * ECCS provides ECC status as follows: <br/>
   * 00b = No bit errors were detected during the previous read algorithm. <br/>
   * 01b = bit error was detected and corrected, error bit number = 1~7 <br/>
   * 10b = bit error was detected and not corrected <br/>
   * 11b = bit error was detected and corrected, error bit number = 8 <br/>
   * ECCS is set to 00b either following a RESET, or at the beginning of the READ. <br/>
   * It is then updated after the device completes a valid READ operation. <br/>
   * ECCS is invalid if #ecc_enable is disabled
   */
  bit [1:0] ecc_status = 1'b0;

  /** 
   * Indicates if Program Error has occured. <br/>
   * 1 : Error Occured
   * 0 : No Error
   */
  bit program_fail = 1'b0;

  /** 
   * Indicates if Erase Error has occured. <br/>
   * 1 : Error Occured
   * 0 : No Error
   */
  bit erase_fail = 1'b0;

  /**  
   * Write Enable Latch indicates if the device is Write Enabled. <br/> 
   * This bit defaults to ‘0’ (disabled) on power-up. <br/>
   * 1 : Write Enabled   <br/>
   * 0 : Write Disabled
   */
  bit write_enable_latch = 1'b0;

  /**  
   * Indicates the ready status of device to perform a memory access. <br/>
   */
  bit operation_in_progress = 1'b0;  

  bit [1:0] driver_register_bits;

  /**
   * ECCSE provides ECC status Error when ECC Status is 2'b10 as follows: <br/>
   * 01b = bit error <=4 were detected and corrected <br/>
   * 01b = bit error =5  were detected and corrected <br/>
   * 10b = bit error =6  were detected and corrected <br/>
   * 11b = bit error =7  were detected and corrected <br/>
   * ECCSE is set to 00b either following a RESET, or at the beginning of the READ. <br/>
   * It is then updated after the device completes a valid READ operation. <br/>
   * ECCSE is invalid if #ecc_enable is disabled
   */ 
  bit [1:0] ecc_status_error;

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
  `svt_vmm_data_new(svt_spi_nand_flash_gigadevice_top_register)
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
  extern function new(string name = "svt_spi_nand_flash_gigadevice_top_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_nand_flash_gigadevice_top_register)
  `svt_data_member_end(svt_spi_nand_flash_gigadevice_top_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_nand_flash_gigadevice_top_register.
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
  `vmm_typename(svt_spi_nand_flash_gigadevice_top_register)
  `vmm_class_factory(svt_spi_nand_flash_gigadevice_top_register)
`endif

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Protection Register */
  extern virtual function bit [7:0] get_gigadevice_protection_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Feature Register */
  extern virtual function bit [7:0] get_gigadevice_feature_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_gigadevice_status_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Feature Register 2*/
  extern virtual function bit [7:0] get_gigadevice_feature_register_2();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register 2*/
  extern virtual function bit [7:0] get_gigadevice_status_register_2();

  // ---------------------------------------------------------------------------
  /** This method retrieves the value of a single named property of a data class */
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of a single named property of a data class */
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Protection Register */
  extern virtual function void set_gigadevice_protection_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Feature Register */
  extern virtual function void set_gigadevice_feature_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Status Register */
  extern virtual function void set_gigadevice_status_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Feature Register 2*/
  extern virtual function void set_gigadevice_feature_register_2( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Status Register 2*/
  extern virtual function void set_gigadevice_status_register_2( bit [7:0] reg_val);

endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
lAkjv7Rrar0mMwxkW1gRJsrQzb4/Wl1PcQUq9WIf5mPlWZmt7ZY+QrRVhlXywH2D
6nhb0pPAdhfs+xr0xFmaKLSzesnn26SRshJZFOh8/azdrHylT98lz68tGNsdQ8PK
fWoTEdEAICFVkEQau7b7yT95vnL0Bng7H7BtKGHYSOD309LjxOgjqQ==
//pragma protect end_key_block
//pragma protect digest_block
polfrokQ88PAZzkf7GI0ZF6oM+Y=
//pragma protect end_digest_block
//pragma protect data_block
CWy5CdewhVhyG8th30SCKxpma5vrWwwqmer7V+GdvKacQv5XzRayMEoUvsRXIZjO
Ok7cWUiIowAdu9pS2QqE2BuG0ld+hgl+CHvBO1QRIVj7nCQtx7wPkM40d9GHikct
uHdDqqtil8ZAWdACiPpwXlSiaFILaKCwpHJ84avZl4Ug1Hz/oQ839Gg9oHkTuaUL
PmPhd7DUGWmqOjDIYvwY4MDgTJ+/tEVHKz9718vK6/K6HuRtfk+r7wg1uigJ0Ob8
Tjaw0lAm781CisseErf0M2zpB0bNtzkjOdHYPU5e8fl76CxAtKWAq171hL+1Cf+w
K/iX67SrZmOg77Lpg8CWVRR3LG6nNp4g7PFea4TM1k66DylzdLYv04RB4cdoNB1i
7XzthF+1ojphhKDAHlpACim2GT3pQ4HaM2vJVmMG1Tqt56TRXB5ngZQ0U4bxbSmS
I+cqlszDXS2xjxyAl6ZzmQ+yV32WCKTJOanc0I7VKKoNui3WfYdiOXnh50c10dWe
4FxxnDX8B0IlDb2v2F1SafDasbpdC3HMSqiAzQhhNXL9JsLnqv6fe3jnodZ6r95y
lQhary1KINm+fD/Ik44FVtB0CuP0UYBQdGaAyyEL239jr+h9P9iYplyCTj7NQ5Kl
fgxzChe/U0QiRLduwQgJxzV9UWgd5o+VbX1YDCFnp4KI0jgtdZnQun+j2K5jRakw
JmHOGRP5k1eP76ECYH5eENhNHodWgk0RdUy78jmiOX8xHER43JJBKr/zAdEjOIDc
QQbNwEYnOAFOuRuUFGi1IRUf96FSIovqp4CMDfVXcM7AOqXUS1VBAcMFwnhE2Ja2
VA+dF+Ao6Hs/8RW7umIPHeN36hMorYQDJzb8A4OW8hGzPcVy31/KqDTlWDkocKL6
uB7MkoveSuvcJljLYO/iIdMNowlmiyLBIYuAG7qFGEBqcM8iKtkWXJnY04u895FX
GTG6cY/l2whSQ3V7MUZ0ZIxU7x7YYPk5tVyJQB30Sseofl2JTCVDGxks16UMnYjm
cZ7EnBDqZZJnBi+M0BJLYVfceiW8tCSu9Nrm6Eajqt/Bf0x0YyRzFyOIHyz6rGyE
anf3tmqctPDiQFNe9FFsTg==
//pragma protect end_data_block
//pragma protect digest_block
Y9CK7Noc2jXKzo/QfpNVP7HETv0=
//pragma protect end_digest_block
//pragma protect end_protected
   
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
RojUpDm+Dj3gEcHZ0alSmjRrv7x5iCKTwRQTJFCNGACtKJjnXVSZactF81+ezU5b
SSzwNYt3XA6CtDmi+a/oU6YxWNwqa0Bsf/TGibEk8/r1Zcsd9iG/KEtj25yE+jBq
vJ6r7XZ6ov8AWhLTG7yVh75k8sKRtnc0g4HMLwGOd+aj5VKmz5cqRw==
//pragma protect end_key_block
//pragma protect digest_block
j2zi5rxYOs7pKhckwDJoDJ1tePQ=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
hUSolMwKav0YIq1e1+M5bAx5NHU=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_NAND_FLASH_GIGADEVICE_TOP_REGISTER_SV

