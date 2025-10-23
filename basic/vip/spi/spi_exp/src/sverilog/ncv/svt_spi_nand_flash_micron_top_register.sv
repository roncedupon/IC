
`ifndef GUARD_SVT_SPI_NAND_FLASH_MICRON_TOP_REGISTER_SV
`define GUARD_SVT_SPI_NAND_FLASH_MICRON_TOP_REGISTER_SV 
// =============================================================================
/**
 *  This is the SPI VIP Micron NAND Flash top register class.
 */
class svt_spi_nand_flash_micron_top_register extends svt_status;

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
  bit [3:0] block_protect = 3'b0;

  /**
   * Top Bottom control bit used to control the Range of protected blocks.
   */ 
  bit top_bottom = 1'b0;

  /**
   * Control bit that Specifies whenther Write Protect/Hold feature is
   * enabled.
   */
  bit disable_write_protect_hold = 1'b0;

  /** 
   * OTP space can be protected after Programming it by setting #otp_protection to 1. <br/>
   * The OTP space cannot be erased and after it has been protected. <br/>
   * it cannot be programmed again.
   */
  bit otp_protection = 1'b0;

  /** Configures the device to program OTP locations if #otp_protection has not been enabled */
  bit otp_enable = 1'b0;
 
  /**
   * Configures Mode of operation/Region to access (NAND or NOR Read MOde, OTP/Parameter/Uniqueue ID). <br/>
   * CFG2 CFG1 CFG0 State <br/>
   * 0     0     0 Normal operation <br/>
   * 0     1     0 Access OTP area/Parameter/Unique ID <br/>
   * 1     1     0 Access to OTP data protection bit to lock OTP area <br/>
   * 1     0     1 Access to SPI NOR read protocol enable mode <br/>
   * 1     1     1 Access to permanent block lock protection disable mode <br/>
   */ 
  bit [2:0] cfg = 3'h0;

  /**
   * Device Lock Tight <br/>
   * Specifies Whether Block Protection State can be modified through <br/>
   * Register Write command. <br/>
   */
  bit device_lock_tight = 1'b0; 

  /** Configures the device into ECC operation */
  bit ecc_enable = 1'b0;

  /**
   * Specifiy whether Read Page Cache Random command is in progress.
   */ 
  bit crbsy = 1'b0;

  /**
   * For 'B' Generation based Devices like MT29F2G01ABBGDSF, MT29F2G01ABBGDWB <br/>
   *  0 0 0 No errors <br/>
   *  0 0 1 1-3 bit errors detected and corrected <br/>
   *  0 1 0 Bit errors greater than 8 bits detected and not corrected <br/>
   *  0 1 1 4-6 bit errors detected and corrected. Indicates data refreshment might be taken <br/>
   *  1 0 1 7-8 bit errors detected and corrected. Indicates data refreshment must be taken to guarantee data retention <br/>
   *  Others Reserved <br/>
   *
   * For 'A' Generation based Devices like MT29F1G01AAADD <br/>
   * ECCS provides ECC status as follows: <br/>
   * 00b = No bit errors were detected during the previous read algorithm. <br/>
   * 01b = bit error was detected and corrected, error bit number = 1~7 <br/>
   * 10b = bit error was detected and not corrected <br/>
   * 11b = bit error was detected and corrected, error bit number = 8 <br/>
   * ECCS is set to 00b either following a RESET, or at the beginning of the READ. <br/>
   * It is then updated after the device completes a valid READ operation. <br/>
   * ECCS is invalid if #ecc_enable is disabled
   */
  bit [2:0] ecc_status = 3'h0;

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
  
  /**
   * Die Select
   */ 
  bit DS0 = 1'b0;

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
  `svt_vmm_data_new(svt_spi_nand_flash_micron_top_register)
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
  extern function new(string name = "svt_spi_nand_flash_micron_top_register");
`endif

  //----------------------------------------------------------------------------
  //   SVT shorthand macros 
  //----------------------------------------------------------------------------

  `svt_data_member_begin(svt_spi_nand_flash_micron_top_register)
  `svt_data_member_end(svt_spi_nand_flash_micron_top_register)

  //----------------------------------------------------------------------------
  /**
   * Returns the name of this class, or a class derived from this class.
   */
  extern virtual function string get_mcd_class_name();

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * Allocates a new object of type svt_spi_nand_flash_micron_top_register.
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
  `vmm_typename(svt_spi_nand_flash_micron_top_register)
  `vmm_class_factory(svt_spi_nand_flash_micron_top_register)
`endif

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Protection Register */
  extern virtual function bit [7:0] get_micron_protection_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current FeatureRegister */
  extern virtual function bit [7:0] get_micron_feature_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_micron_status_register();

  // ---------------------------------------------------------------------------
  /** This method returns the value to current Status Register */
  extern virtual function bit [7:0] get_micron_die_select_register();

  // ---------------------------------------------------------------------------
  /** This method retrieves the value of a single named property of a data class */
  extern virtual function bit [7:0] get_reg_field(string prop_name_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of a single named property of a data class */
  extern virtual function void set_reg_field(string prop_name_field, bit[31:0] prop_value_field);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Protection Register */
  extern virtual function void set_micron_protection_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Feature Register */
  extern virtual function void set_micron_feature_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of current Status Register */
  extern virtual function void set_micron_status_register( bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the value of Die Select Register */
  extern virtual function void set_micron_die_select_register(bit [7:0] reg_val);

  // ---------------------------------------------------------------------------
  /** This method sets the Agent configuration object handle */
  extern virtual function void set_cfg(svt_configuration cfg);

endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
8bTrIL3utykW3UkYTsiJStpvbS8vm/JTtf/b1JxtZaIEDMw0sRk2itxxm/muUBga
QxRXRYS4HOq+/yWIrG7lhH12DjxmdQWvhYGzGtvqqAdOlFO/JjoD0VinXfF/OXzg
kk5d0+oNdvI5sF1a4kDY4zMjFW7Te6sPj13oXD/9qn9UTIGvjYRjdg==
//pragma protect end_key_block
//pragma protect digest_block
PcjjDMRocsBaEFT1vbRXNdZ6Q2Q=
//pragma protect end_digest_block
//pragma protect data_block
sfUAfyljDeamwXS4FzNId+Rh7sYwD2BkRXl/5ER2bxryn74akTrn//r0cxW8mOBj
xbgX522OCjZa2AZPz6bS5cuTLOhL6M4HU1CHJ8ijPDckeT7VwDlTAWqbZayieWYN
3VHfLVwdQk6axakCCedE+OSmt2n83wr9/gEB6foOuRoigerEKkKnuFWW5HTeGiLB
DY/Q/IXM95Ji0YtmGDUtCTsEycYbwVQrMT9GX5pC6QX6yBBmiPWTjGgLIucqWm8K
gd8UjEmj9P2b+p9rRO+SxHCNri39/+1kGJS08NgX0tda7BaHP4w9s9XezW6mWeg5
RMhS9KoGCA7hyuyfFxSetI0xtiYeTzam3p/TFdzsFStmRSxsN1vPETFQwyHpP3od
mpV+h+Eh8Ad+nCDATfhX3orxr+0SIst7SDRMo21NkDa9erJNz8LLJX+g4n1S3THo
VatF+EHeYYOQH+7WbMDt/hfd9v7m8N5lMcWjfzlQy3wDn6dZNvhemI+rWM54vqpY
QWv3nJm3Ja9d9u/NOSkOvjNSENHHTYsH10PFE4PfV8XwLogF2vQCsijxNVwH72M0
l1Ymq52ihmXSSbc3hCQryjAztgcML1QsWbwmF/my+O8GT0lYDQDVQCCBOU7xIb6n
guO/h89HqxVstcmg/BXRTXIw90PjAPNOurhbJeHTt+Zkg3e0NNM6bJoksTGXGzAw
5Z/4KGH0mQvWDlLD8Tlox99AVaMU6f4Z6j50NY4TlQjJxh8aY7o+hqDKu5UMU78L
W5sSfMX3JCuDlnw0WfaHith/EBWKRLfBbgbyj41dYgKcSXGw/fj6AaTjpFxK8ORN
8U+3nU1XkS9yhqTFPOws4P2fi/1ug1v6gzuxYrjklnrkAi4c5p7TrqN7zfau6QfE
UwIg4WwTwbbUEQFNHbqmywwQPTa0QQWRDLqxi473BKz0qaxmYGOtyRm6M8Ocarmd
mMgANuYb782MG/PPFRXHcpLRFTFN1/CarXNhKyQh4FsBhuCbIb18YETvNceOBz0/
vahdrCPv3mauKgfdiWs+1qPzzef9IHqoDDaqp65PI1NpJOJkL0zDyxOvxZKEylpY

//pragma protect end_data_block
//pragma protect digest_block
XMybSt/SXM7Ojx+RiiAIwIm4Ohg=
//pragma protect end_digest_block
//pragma protect end_protected
   
//vcs_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
6bBbuDh/mEdAXIIS8Y5QRe91mzvqzMbq5OMeCZ7kjSqwGG0pEUcJwBVBEB1g9sYY
FW7SNHZxKOykal2XyDJEv8Y1BoLc6S8hA+KHkF/rgNEfY39OT6joOrhbv/q5ZPjl
aClRA45eyLD5IqUcxz+adkOq3rE3uO4JhKK1IJyMKsihSyGTNMoF5w==
//pragma protect end_key_block
//pragma protect digest_block
hri8bfVl79u0bYvoztwFInWS1+s=
//pragma protect end_digest_block
//pragma protect data_block
z99ExruhtM9tuf32mo5fAzVMsL296k8zDHAtNwLwLMeOViHYlxwWTTiX++5DegVn
rofiRA2n8U0IjDbzvFkHEdt+Eha7SaejnI0s3pPj9SAbN0DtQBNfeMZg23T2+TC3
aU0Rtd/vjA8FfQu9dqhEpLaP3JSdG+faB7Qj6r8bt/zXtKdt22wDSe2ZRHTqStv5
3ooSkMTaW5sjzefsh3tRh4xJXM2ClvBh/TpK27jCVbJc0kDxOCs07zuq3zNAGz5w
j1sM+8PxyEyc49j0GEjNwgnqats64S1nqkWJWJL/tlsTbBUlK08IjuJnnGJfPT3R
6y8B+HUzC1UhPrk+BNme+Mh4bMQvfpKjix6lAk3cdMSSCtG271aX6d6C+RRnlMYN
kmuPWp+Yb67s6Uoyv8Upk4pdh/sV9K2TiLDKLFBC0LdKs+XO9P0z9zUwOLzNTPGx
+47X4DAoIDr2ubca4Hqn5WPot/2YGgFHgIDhuk6aPPwNmbOSe+6Rsyt7oY+nAvCf
rpX8VviVcmWqjNEHIUTlqUnZJt7aShtcLKVaAYt91LCamCy2Qfi1nIhOAJhXwwzF
8SxBl21vEX3zqzD6rVfdr1uzuqlzSV+p22JV5F3FbKXo8h9EpgCQX3VYITG9hTeb
PJvmuz4cAd/hnE4lcQl7HIWjm9yb2hPIiEczrl6o9EmDBeTsLrSABKKw4w4bYvMX
2xTBYh+iMVtCSsGvRkfj1JFilb/u/psY6/IPu3OltUdMmMjtGY1i74ljOmxx3bcC
5QnSQv2KrcHqB94fWUt+NGrqyA0tOhajayENkyHicDJH8xCu1Ddk4m8IH4hIi28T
pyeXWqYgHDei0sbHjy9yD3f0X43eCmSYA5q/4xkHT5XDEhpFpIgLQlNca4HaBKrj
LkT6M9P2127Y9u1VBQLY2tt0Ky2G/XokpprKTYfgUlDTeh7ZdNKSpIoipYmsNQy3
L79lCYRQQ5s2pZ2VGBYIpm4e8f8mpLp4XlLshvs5zGs8NFVqAUEZy+2qOWd5meoT
zqucT9wgg8z3dAx3kcR9fRG2Vbs/lr83seJsUwFEto+KUtrmju7fT2znrRPGaPPt
VWQUwx+DSKtRPn/xrtNhkxnhz6nuWa/yAg9cHphe/ANDZSNntmUlq0ofdsGWE6IX
nki1KNHJkolRPSFzFnCEDxTw4kDydYJY4YWknM72s8a++ShJjpV2ngvpqMBmmi9C
B2EwNW3LvJCTCVQpCgIgYbcUjNYBpORSwqVwjoev90nvO9J46Ahpy8W0quq3QfH1
wJ0ysWpLK/pReXo0NwlEl/d85rLsAyGYfRtjZkrw8y5b5/NRrLKfRhoCy6AonExr
+7ERc6SGu8JPjGQfChdmLvzxaWJrep64CRXL1bFqXQbmqoUMBIr6H0Oeux9sjbG5
unAksjV2Pc0xYGg3D5Q6kHYvL70b97viEKiD+EA1JJlbm2zBxtW8BX9SU0OmJJsX
uj0PYMditkR0pSC46ojMxgpGIzTRRSNTR1UP3ueV+QmCwnjzkVHyMGP6sFVkjlLC
U1TZYot07MRs03hvDYvFHhb/vKg9atWwtfjbUq+P8Cn9Kqo1l8n5NlPZlri4MbLL
K9v/lOt9UlHy5RBjl5rc8mWHwECGfi6KA1Oc1+GbDW0TwKLNoZByjZudTPUOIWO6
W6bzS4HxeWHV03PDRjvvusbCXraPhTXOySRVi2rqG9mO7V3zxhuLxLI8l6CplCYG
BcoW+r/Ks97cF1pXV8aH17qpzEnoS5YRgYhcX7hSJLVEu/K8wdTAcT8+T3l1tkC1
ALw2a4KFw1zqHn946Uug8qMD8tmdZokKFNXhfWmMH04/fx37bmjoIFNpLEbFVXOu
pOfXE1wqaaymORMGlx0tuTu3+nCLRUDpY22pigtoiKg1VEgqjD/hGzqbzfST3uIC
GwNpwTQO8ePWhRr0fettb0KHBdNioB4oNGm0G7s9i0ZeWJIATlV6ZtLXSwCWuuJq
7Xpotx6+J4Yj7pXW6J48a/mSB9zhcvOapU+l50y8IPWm3yucC8R/jOIc9n/Tu15T
locYK84z16D1p5uV2e2SDjuWeEzwOo90U4R0D/bZmadsX+HwMM5Dcg3byfQBuAGC
k9EtOJebvJhWWqHK97dmOcR+J3RJPTXB6uJc53egNhY8V7zp2gTbfswWozxcGYcP
VEhGdLNggawZwTmA3njcqWNRFnRiAqM/1VmHLU3k5/H9nAf7s4NsX+fy4RfpWmWb
xlmOi8Z+4CNhwr7pEpDcR8MQbPUowvYi8NM1l7uVp6q8Z8iIytMJtotswrkeX9Da
2anHWWWH+lAA2aT6nVTgXYbNotNV693zU2yLxb19v3RcYJBdU/opK9EcnvK+YzjV
JELWFCi5wOYK2i6TujFTP9Y4rgYYS/3hHJ+q5B0PVBHXXWhe2hE70jSSQE+GWfNT
xPl4Ulb5HCIDsY+5NCI0QGgr6b8F+nJt7pgxd4QLdxptKi/8DuZBpgsSa1XPCE5h
8Qfp53XNmq/yPvKIbk2R99shbOuRccNxcjGAi8DVqcVBhHhl7NfVL0hpAQLXbOMK
YoJtHcUwQW8SccSnIjY8GdOAflaJpcio0Y+QYZFSEeYjvP6IY1/laz1Ej1nvPoQt
DKsHoGSW9TUppN9HPeJmHbIe3xgnDktF5KlEyJeDjVTg2HohU8YRLc2Ojmked0tD
YOtn7ZTKDhv0LkLRdCdL52WuYGBLgPA7JnQ58zkwfMn6sd7ZyDycVs2wxJzIhmEP
DvDPPWeTPSgWSipnoDyOJyOsYCPocHr2SZ0FSark9hoJhHQt24vZwqRjNr0EYlwB
465UjaJdQh3dnNKYti6jkp669fg1Reg9+FDhNb2UaqIPfKIzjBsOoeBDmJRtJImm
oHTrd7zJmBbChBwoIupFVO+JZGyoWyJt/XrKpgqTE+qdtTZk+1YyqyY6Y2jSt2yl
9myvy0jCDNX7zNpfbOU3b7gr2/5ZN6byt4NKjS50JZg+2kZEACAvC8BS1u8cJPNL
FXaUPnLEpaCy6I7QuJ0Oz9uMwNQsg3tNhwPs69sdpZojK5hiplZloajGKI6goqU9
PIifBNK3xtZ/rxx1QTDFS0zLKVjfr9e8ws2TODJdqfZsN3ucmexVoejW4PLGNXbQ
6VKNj4UqS75wXw2sT0PYoa+ojQ40cKxZVp8UxFqGG2yIHQlXA2UHZHRtGqE6YwdB
swXvNaaGQQOkeqgcpz6vOa/uZWufuYETvaw0XbMiuZ6HvMPlQ6OSz8D4IeCgZxk6
UA8WhjL2jH3rH76/wmv5Usvo1C8A1P9y96MCct8AIUW4UU5H0r9h+nVbeoRapyTX
804Vdr91OE60h58yHOpl+xvVjlL7yNnOUsQ5dja+Nju9jucPuJ760yABYTMFmC+J
Swg9xt5K69x0qHysmmAbfxyDOAOXD+zI1LFyMRJPeKy9E4ZI2clDZurNi0zANXHM
p6cY0FhUYKwaqPbhF3OiyfCGNFWPK7JzLt7XQL8X3FTlMx8s38FOnP0OajQMQ7B8
70Yoz0H6mGOCsMTdoI5eAcydUZ1GSSJKzgjX0juBRiNW4eK6kgtsXM2YuCh9/Nai
/wV1OpDb08VQuMRIofSESZJijiWQ06Qyf7zTRFVZj4oZ8u1zBWFOZLrc27J4If/v
sbg9ZQOq5rfOn6bwC08q9KgP+ihEcDeKNr5rhJd10LSxfbw1AdbBpj7aJF1Zb1V2
+netriiEsQCnSeTA74jbg/xhqIagfOsII/Bbl1WC86ajhPFODEiDVWVUSOfrXwAb
fb44idMHdiYPCG0ecv+QucXyrV7T6YBlu9GGimFBI10sHK5kcCC5PztWz9pZWjxd
cgYygu43SaZn324cF+qlsjMwgVfr0kofPwqnlkzYMXTjpHJLXjxBV0A2BxrV9jB4
4QOabDLQIiMp3nA4JM62Y5QkOKAbPOM1wGS8AilGD7HvqP/SpglpGx4QmmdricfB
7bIOY6qKzmFwGLoCSKJeSIGUMSIjVANkftzSTA94e1dIzVY/ZCNWA53ZkBFqDQwU
GT9zmlTzatoAvgYtQCcXx2A09SxliRNH5CClNkU77h1SdYMeLHZLx5JmJ6osfYZG
jOpdRm/uLFBjK/njVTenMvDFnzkPFDTFUasB1ovcvFp2rX+KpRFG4/aviMAdHuwJ
52nJtIcsGww2aWth+g4G4uJM48rrEAJj0Ya8MsoyHuwEuX0o7ANh2wBXnn3ghfZK
2NLSc1EDzuDOyRnPuTQUOtZ/An/9R3IuYYmWMAqJbO0T+GdSG4w+fZv8SwhfcGhu
6GGM+3Aax9Bre9ZpfpTscgePLedi9YrXZmPBp7CL3ZrStwCQrdhjUVPtuoQZgdBu
aTFhoTE7OLD4V/tvv3U/Y/iJ2WP+oq1J9SwdZXHFEr0h2Y0wpCq1dgdIZcb4Vgl7
nKSqZzpCC7qd8k6RugAzSayqbYvvD6gIs0dSiAAgdtGx/n+rRS0z3C/dWQEJ0xLv
qHX+9w26CR21j+/RGTu1qr6n5h7XlHPfGASufqhet7iJl7TEdch3G8MVBHhYnqSn
woO+Fu2wlXGZR487t3oOXa30YEfx9PMngTZC0NJ8h9NXuUjgHgAPhr3cJDUp0OEt
dC+DKhbF3BDk6i4FzQBGQKQX4a660Doos3xnN5GWTvgEZXE6Q0lHgfk/GTvS4w6r
8m4UcOpRJhU/fhEXwgKdM8PTpg7nmgjCPZS+sj587p+q2Jn0sQtsIhQdxlBeOGWW
yR+u6e1p6DoGvpPfO0QCyzbrUb4x+KE2DtSuy6+elWllhKAKhNcPbK0NpJoj1d/q
BHDc5r2Rqt+X28VlHXnGkTvQLkO2Hm21yzzMnbXFta6N1DdyxvdVd4u6ijJtDH4a
f0uQMBck5flbv3YkffIhZV3MRJui6yKNHBmdiU92ax9wTfOHxs2EhrQPV29iGd/8
saw2S9kd69dU/JCIdcXyli1XFlMAZQA/JAL96sX25wv+g+Z7ivWNV6akbEUyk9Od
CQUp9dxCjKVBUuqROFHmWtARTpIwuUZdx2anqvAPMVmW7W9te3cAGflFoufwgpF8
imCn2RTaLSVBr0hbtMd1wm2uniA5EqkIVJyBM+xGuZ1nYFbsBAhisoSpfW1znAkh
rV572wlJQx2jacVKgVpordOrWUMSJ2b+EHAtlZvTX3F33M7+prv9kQAdxqGu5ePm
O4YS3UvYQH+IcGopwERq/Fd9I6AacDUzGx/NYUZA1bkMpnaxZjXe6tny+VQUhZbW
FPgNeQGHJStIF/Nc9xtQTuDRfdGKFnHD/xNAfa+VKLtBqTPF4ZzLHmuipGTbjLJk
jbHuQXaVgVLktGYJUnNJtDep6hUVY5kgUb8N4mzvhCyD/d11xTHxIW7A0Qk/3oEf
5aEDXNkjiCh+sDY0ijVbvPfO/veipJjTDdHq3ofluckHRgz+sk998IIIzE2R0/8w
h4Q9EOsOZHroZFS39a1IPOl8Wy2E3PBgx32PNd6RwJi4lhJffZbhXarZ3+bPHheM
gBA5Bj9GzbS0FMShyyP8/7eYHGbnOLvHOtAwo7k/lbmUk3LzsVHvQL4SF3e685U8
zq0mNCaDnO+VLtYTDATCWU7L5PoibdLnSNvJ1tuR6z5plRQ/NFwcjhTGk6y0uQG2
KhsMqBckaMdjH/T/R72WM9VWBb6RGIMOkejXP9gY/Sc0n5/OrkmEygLCfUyHo4Hg
Rc6hL26HL8QuQO3kgAOGDQ0MzE8nUWqF9AhAXTpULFH3mK6xrYKiPerF1tIxbtYz
lIqL6abdCl5My/JELK/DnbK1RX/Vv3VrktQG9oOA4cEPhmqC/qUk/4HeR2Yr7+AI
vZ7qf2CSPmPDrBuWh6iAnRnttXcZV/nytPl6MZYareevBfT9v1VXghfGETeg8uip
9shz+tyUoBGDQgft+mD0Aqgq5aVWI8Q0z2AZRRJLroyameHHGnEmEN8rt9GMwCs5
EqySyvUeZCpDW2JfAqXukqWo4syv4QB5YxW2ljWkx/RBo7HBEFtVCo4FMHr6LiAx
TO+TTGOlCfrzQrbNEKy4rlMR2mZtR33/1fbuSTRp+op3EZTIeUmNkbx3HpDkmHut
tLnnuLUsjD5lMbkY+uKVZjT9jggAOn4pdWwtFMygYqLoTo2erhBWe4/dmvh4td4r
CukhFefB4JTEHkzwaTY2FuSVymD6msh5JGHVe0vyQiLSaxo3gry6+S9AhhiNLj+I
h3D5cLL3yusbt/Mep2IqyYI1ZoEGMzjyDTUtZ5RFuk9sXvQ0qNhVQrdPOH1kAhQf
iBAy73k5A0sl7gzmMY61WL8mzpUwKaOaq4PZU9laffwNwaiUbfVL8bPHV6yr0TeQ
BPgy1cYlGW+H5StiHb6c6qlumrCiSbRtuiIhXOCtK8oeZiAQjMXy0Xw8VwnN0jf2
sw8J1s/grkjuKu3veJL0cL/qMOTr56+2zFSGRFWsqQAlXlPQff6Bkt5CG23zgJLe
vAlj3qTsksDaFzHQBer9KVIHKFykzQtS3CvNUi+h+/I4deEuRobUe2fgKHMw5AR9
uieGDz4Ix8Pn39DgANx730/NccAWYZiKjztYM2xGQ7BDeU3x6V9ngUqJ8SGjA/vD
7MN1Aggbutj2HCErHPuTcK/dKZz5MPCp5I6958u4BQ0+X5GPfps5h14vOD4CPd9K
tDZuaeiMb5A69PWieyPDYuT0kE2kPBlgA6E2TIxJUyun2ZiceHfGr4qNTtDnh9El
Io2d5S+3vqKhfGVvn2z8Bi/XRqtK2LnsV5E0SB40pjp66fc310fjGbyWchp/byK8
7LVLk8GbhyKAUdLApmMjx6XEXagy97Oot4RvLsEJGSbVerS6BuPsxUzosE/vqeVz
Z6mS+YVGeFfe/pXRMjMUH3t9z4ui1RbfLSTuzWe8ZLb8dNHy4BZfTZSBABR/36Ai
FJK0xzjHD2KzVavsJcUlbRfpBG3Udkuvoaj+iV2l4+qrI0DEkuX05+52i8+rANmo
z+3MwyefciHjByZP9KVD+MFz9YAe1TK0Q6PieK4l9H1YjQy4izzM17b2nw7iqOAO
UFUnkHiEkEpOoLrO2CNWh9kkQQTFVHWc5cjMtPe3Sl6tydvqDkxNhCA2NxKgL0B/
XWEGyBsMJyCkyGUWBlykE3iHniXeVb1v/UbADNX0D1orrwpYB78XNXCs1iu7OMpO
NK0x9xTK6PpwstLHqe9lml96T6s1i2Zkfx+D3cGGbvHVlC3DO8Vndx4K1mOXGj7A
pyaN3bEK0YWuFQCXMjgrITuZqzmeK7puTXDDNzAFW9DGzt+pykpllTxvzzLmaIvA
3ieR5tjIsEz4Bluj+Ke2HNnNDJLWL/dgrsF3HmFyvXPob07fCW1NIm2rfsTqjcJQ
EpJdk4rs7sqG569NbpOLNQ03xajUiHhiQ1jhsX3UoYg3I/qx/E7zf3A03ZS1tZ3y
V7WGvPQ0CSZNymc+PmHITxFvbVhABsmr23mhv+VpMSWsL3KL9tFSu3opcCp//DQI
6zRzMghDaq00XmmJK3zyfIM1uN/fh7AAgUQSmsXV8BmEyrqMHcJuQchnOVUIIb3u
8L1y8In+DZShBTu8YThUv6v0d5hSrzA71jItmL8PUdvWdR72ejFPvFDPoa5q/J+G
BWxVqgJGTh7WhZvP74ndUY7yuG/N95Za7eKPmKCb/Nhxgc3VtZQuRKMDJVhD2IQH
xs2+a20yBB3HDg9SjmEB7RtLe0oU4x77xgyP0UaTensFei+wQEGTkaFOt5ld61Od
xMtAQ/uXfwRqs2Ss6kQFhacghYE3Np1b7We9yxiGjnOQbwGQ7JYNVdCBdtMgZL8E
wPUEvDO75cQsAkq3HueYgHT5uZq6tjS3Va2RSiIQQ+HyaEr3EL4KYiHlRqhvwkzC
nqKITbwaKovJ5j0MDo3DYh0538bLRcx3IqyukoUt7nCEMdNjYB/s7FGsSy0dyw/M
oHz/Ds3zz9Dg4giPbNtrtTp9iyHv0QMPvRsFKV3zan8Ndt1M96JKbnGpumaRuYsJ
u8dCcRxa0pyxRfMVy9kSvd07Z+fLc1siNiovdry0OpzcB4dkcCnGPIidoQfmoct3
3YBpjba5Dok1Pia6VeC6mmeh1zUhKbSI67kPqsVfqesp7amvcHKudw/o/9wymxyY
aKPklAwuLS0hlExvodGudHG2WD8HmoLAPXwj8DoRrscCjofAOkUBedddVi6Hm1yO
VLFCqUtPdH/LNE7X5uZBBemL0yo4BvxCJM2HCp+A5dZXFVCKpNf3WLXqbkyEu2XQ
OaSbgrTloKrV/Fu99g0hcwj5nVRYikI4QkBZ4WmcNtgRrqRx6WyEbMqYb4sgiObL
Q0XygwOKymNlSpmhR15Sl4i/0CN/ZiihZ8vR2IJIHtDDpcwd+Pms5XMWIpprgEBJ
omNkrqfBu0D+QhXxKoh5aFKC0o7r3KKTlQnhgvJx28IvaDcrRsEIPAARHL3UrmaQ
xuovhUqzApHUWpHIUuIBAHCyt63KZV6aoxojJfTD+A7N8NBAEvzqxJp/tlGclCFn
mYyxg6sbfuHrFZHzW2Yk9BoLh3I23OjytgTaH7MC5cIC1MrNhtE1vcwfBkiamwLp
+Ufbi8NMTmdmbwxdTi+bPkziobJCzlwOjW9snrL1r4Q0tZa7fgtkTcMM3xgXMFaF
QvvebQpEUXLGwQmSbidMb6YICW8TSIbB9nWwxQ7flHpTNphhURW7EyF0VzH628qY
2vKqyhnJmn68reVlsR7DtoDDmI3sV4BlldiN/OlBCMQ6BTYuBP5tgGyJXhlV1b1E
VENJb0bawq46q8BMjoIameOGkwPlb1G/j7pMvSKlQtZ5aYbuAQB+QaZy3vXGAuXv
Sy9hPW6NKAcvOcFg3nX9s/X63sPFWBJgv+EMczKuzAl5dbPicbgDACMHcy952zcH
HnkVL6JfgbygBlAflVGWMB0U3zkmFc0HMzf7YZxYoJdWQ+zFGyGipf19fF7OtrG/
VCZIS5VZLojjgSlLpRS9S8+Es0Z3ZRKMY/q1pdp7RGqzwym2wP71El6Z+XCHvft6
kSsx6+lYGRoSQLsMURsbz9eAjF/FCqHQGe+7eplosUjdsPQM4GmKliDxZmAbTHlA
UVNTrXIZuQFKCkVKG3rqq9SFWuJUux7X8MsJ7Ihc3HBurUe0d9Z5C5njcqpPKO/0
f4PKeTiFX8/1vCGBcIRYEAFH5GtMr5snE2eRja0ZTZIohdfyNCpMuOtow2EQN/iT
Q4N6DbgZnFa3NPM9UMAVuP6TqJPqD8Fgrv+p/kVz3HFnOQ/SfaPSKdJeg9SyYOHi
4IvFVsY/64hV23EKYTsZ5L6eDKGlldBG+r29i8RvmY2C5+y0okv8vZQpYW701YuY
i32hFKtxoXqYa8vBCh3RCph6iVx+nW4+zuWSipcPGxkCFBwmX64kP9/+kXK63I31
CrvDKsZ/6JE0RpImU9ZFB2MDH/Xqe79IYrY9iwoHOkrAT4UQ7q6YDcPNknSijNkd
J//tIIdFDz/M/iS1CX4NhR9XG9068jgG0MfCmO+4TFM5L/cHP0zY1iHX6C/yvPI1
hswtLaNr38kQn8qta3OhCE6fMMvokT+OrgBzGUtWiL3ovF6qVXiJq7oLrE1u3gpm
/gLvsuHc6T6RC4vEA5crF9fubdS8wAlbDU+h3rEYAxm/jGPVf1mr57MZS+uF8oTb
ie6EB6E4CCvXatiN/sI3CbRpnSLjaGh9TvLmK36Rz4AWimG9FtvG2Tylh0X9WGHm
Q5it0ZuyMi/vEhVXz2PHwZImGevJHI+tSZdQmSiVpmf7qMeXs5YswdC+kCek6GXc
yKhw4onflq0qncxWBpvH20BXPczbGz1aXh/ua+mgIFyih2e3nalmxEbZYRTX6EQM
04eZR5yk6zRtD/OWaqxq5Ve3JA3UiNNU+RrsXkrvDPhBei2seaNJldXf7q9yeIc/
H9EJ5LqCuJ5XRzd+odIP7v9S5YLWFC2KRkvs7W3Rz8cTiTwSLqOQuYuJ4rjHAKmB
nMnKyMbIvvqMsKmF7yS2uAT45Bl/oT1X3UhGDl1ByklybxlhEPn3l0p3EpBJ0AHb
0XkvvEnQWgoJIlOuT4Pyii1XAf6xbVL+gMX/sb7dexNlTTPZ9sTYUKzI3ayPhOVi
LmMGktVEjU8XZEEi3ZxcCPOQpg19BPcuNIO4jHYH2q5VqgHby8rCsIawpHvEz3Jq
KSW+5gJXQuRBXhHk7yqsWXlWoTkm33H1+1h6yRKdPD3EHPydLhQAtduWYSTZfGD0
j0FyQeJQNX0lQCwJkDuKzAy7MhiTiS+38vY3K7JjsbVOhKGIyu3E0vg7KfB0tdjc
JnTNpCLAnw6EhB/P+HnZD11MTrmCHODzxGX7CXSHaW8oqpsYkP5X6XT6sx8bK1rk
T/gwNOkPq1MCVFoTCUHwrtTg3HRYvWDjNDIzdrpTh3jFDnIX8k3+sRrF3rWp0Av2
npUZwBP8KNrdZM1YuUtnuQVnom3k2cesdHkgOSQNGvXq3OZf748x41VruR1Txtwz
d6yQnWqp/4o0W4wRNl/mMsNkbNRtcnTRecDNsIcuaRv/eHDo24uZlau8yw6lNWKE
uZDoyIsa0jDL9lU4cFDGc2mGd8hL8ggycYU9Nyw/umf0PPj+yGQy//yrWVtznneu
gBQaR+6dIpRyuTFThFm5ttXHaUX/uPvgd3KtgVdQMiGxBYE3fj+dHIw/CYYWFmuT
gObVrYARh4X8xoxrZAK73JR6dB5JGvwgrNCCNl7CXJBFjzTOAMc7bLcROUh/n9aY
hHzwjBr9yiZhaE4pBKxoWA5DxoDzZi5SDQdXeEknUt/Q86nA7I5eg4icD+hMqEP4
r56aTzz+mGXpzNGwrIQc+xTR4TGRzABq5gueoBDyDIMW+/oi2GLRUBo/cIHDZghl
0S/kH8SAL6jV9WY8eF0SvZatmbagzdbbu7Df4luFtcVu3Z1CLbEOr2e2QjAnDXSZ
/fc627sy8+qIqBY1pCwRGOgmS0GvCa1M0mBH4vhYYtBHydx8gpnOpnSJCOrHgH0m
38Ky3ROtoYrrES9Kvin5WpEwV3DU//BXKdN1FM20fyMQ/aa+XR5lLYMvjntNh8Bo
B/2VTyoYqyYaclZcelzfKCXcBsdp7hDF26239Cli24dgLym529oHgo559nC1SZXn
PJ7yVZEEazd6wdJP/lEmnfIXMN8z62ZAbXuJ2AQ3QWNB4ASCLAAdPYbhNVyO/6c1
/VS15rdH3TPrQbLOmu8nWMBYOtIx6fOru3z8VcROY9cobuUcoGXF1odA4bkXAvy1
WTqpO/4d1IknSd8h9PLphjNH8mg/OPUs9I/EL72PxXQ9YLxb2QfokzDek1MzUAeW
zrOyD9o7D1rS4JcgPKQZmwprPCsY3856YjN1Mz/XRFalu37bm1+tGFYXE9H/0Sb4
EosFXZCRpCdpNqlHo2gkj2tgrXcn817TvN4ufNwgELUtjPlm3o7LMfHC9o42b8XT
fZerHuM3xUw0Af+yvyXv2kyJ8mK263p8Z9ZXTn+SD3GvyqewikIolPZGyt2/pVUt
qgXUiG6pkNLH0C0U7kOVjKWhmJJRIeZDCXxfYkYe+ffk4buWxcmxsxGq5CEZfisN
lACF5AldGDOdVgUXLzPZG8j9qGjHaeT3K+2ZOGKrfG3CdgQ4lXPazUkr0dNWRlxL
72XI008mq/0NRlFEHYpHnpiyc2l275wVPclry2Ixl8fz1O9TET3cA1S/3eyGzld4
15KpBZV3361TMgT5P0Xs+23eRsZ/jp3lKcuTC87yaDhzQx/glc7ZZHxHn+wi55q3
+8xFrpETG9MOwkuePv18W0nOoR/+HbTWvC/8nK9Jy1KA4ZxnLM95DrBodsj10sIs
NvklqXqL868lV2f7kneQ6sWK8cWnefMBkrwTKnxncR0SnhLz9lGhoR57FMJZwoCQ
kbkkHZ3qKAOX1uuDtml3m5spPRkmIA7HOQdsGyIucWqpMq/oKEfhIFxtDQ0lQ0SX
JNJbAOnAkOXffgpr/55mcUgL28r6loIrosIPKcpt/vFHZJoCsLtIKWtm18qzVqhF
buD7UFMeqPV0y9yyAEITavk6+ulYotgt5c9oyeLKLjMCzJH2hmshSP+SYiPTesip
iPdE63TY0B+qp3mbWS1/Rxg2UiqQuDCZD1onNmD/du2Uu5LWvqJu9xBTvN1XRAeM
eO77+GEAqhTbLjBmfer54Sop5QOg9NylUCcrPfahzZO7CJzfyDIjjDjsi4GK2phl
XLCMFK7ACEW8XkJmeLxz/CfMpxp82IWPv0lpnpEqcvxmJ+j0MQlgwqLNZxqkd0Th
FQcGzTsQ1sHxodY1jLuC9G1baip+1KF4e6t/hGczyuwJv8aFHxO7+c6oKpo9EeCa
9lQppDb+QC4BPAvCG2NZxz/QGo9326rYp9T7fGceYr/UzQXAbCrhsTyK9kQ5ngzr
2na7/RVp5Qc/iXNqvWoyPfaDp0FBZO+Lx3uK0bitlGif5z4Td4oEdK+odZJzUXIf
yqPul1hJxS19QBN1bFJm4VB+eovykRBYuOPcqWTgIwfXc9GgfyjyA36n1N09O4VK
jgTwB3NHtbn9wjdkFOH6Mntn30ipG9bmGtyn33Kk00JjzspwlTN6TU1xYVCO5pBV
b3Yh0nJcOaUqCpEt1k6de1R3k+meJcp5dMzEK5vyMnC+BhYSHIW9Dio4qJ+SY1ZF
2F5RfGi0+8JD6X24Oz43xDwhDPd6a3BuajGIx7Hqig50pFA6sh9viQFhqa+KgM87
LxO1xr/VX3bpGgd6MDNMVHQnPBCkgmuiLiwf3t6eGa1QON8GKurAr6ujgI5KiIio
qk48GBX3AptpgES04uVSxPkavBfgwNPWCPyuTUu+lTnUQwWAzqo/ydUOWAxsZtAL
2NDEHO4xV7UloF5Qh+Ex6kydH4oFv1uy15N8Wtg+tnzkw/qLE62LM6OzT4y9egIV
EMByjRtCooU0CXQmD+Vtm2anLxu9WpVg5irotVkS2+DaE1PisudSTi4aP8pys4Rr
lKjI0DPZq/VG8tSzOJHf4QHB/8SZYyOXivnPwv9EBV0gRcG96q0d3WN7XO1ZuLRT
q3B4mqkWwTt5BPNY+adP2aW9PCMdy3jRdmEdUmPfTzLvTkmwhQc3/+q+Jgx4igVE
L1sY4Auq2ELllPf5awK1p9FD27Wr1m2BMb31oxeuLjzePl/esDBRtc9ntlBddsyq
sl0E1q7NuluRBXfTvz8f0ioRkpT9UoB+XYtcgwaaCl9Qvi1h3BMSWdL/0aLERXVr
8Si6UK1IIMJKxlbdwwpKp7T2pN1BC/Qi5z+j+odJla0L9mqziAMLa83CHG7Zsoi0
hGyv77NAKzf6hofe9B/RYWgPamMR4/dqeYnYC/LwTw/Ie9PQWWipSnCh2ltuMHPF
muAr07nptjrV9+LJ1EWKlN2uut9WUoM/TKuzNeN5vtJ+NYPSut7XtH9sM+QCzv92
Ba0bvsTqTol/IKH8vL3Q6ipZhOZc1rz5zAtwWlHVJpDUyKWX/gert/v6CK9sQr1w
k8Y587VOPr1xE9N6AdX6fE0Z2k6PG5bWfjNhHlu3M40ZrBJe+DsNZDVyE/9ktlde
dcH+zkgj6ArPthnfARWFVKlVTJoeZWpv9jYzyfd3lcXlFHNK6t0quFqpy7/vjbiS
A4aFVM7fLbe5EZkvd6v9VEOkonl0RiHjKEqHnKjfkaHv1EantMH2XyEOWINypYJY
7AUe4mMS6gTYbW3eqmxk9ngnBOo6Ja1rJRGODWZzGIKo7AR+EUwFRPeoEgXpXxDz
BLSPPvEiHTgXfYS9PdkUmr45OYu+5vvAWSDCEIb1ZuG1Hg3YLGPD+V3Ydpf2tsq0
ximMr3e1uKUk1p6yCu4mciQy8NMF8wGcw5XPU/eUEowKZRugO3tRk32oPhw6hwvJ
mGEr3xV7OmHGfJ2ZdHgZ0xQHK0+gMClUCSZEQyf1MRfg1JHTUbX/o+biobdlLfQN
L+7t2pgjGVkZsTrHg5DFo3BMCi75yWyNL4pkAJInPkrrv8fWO7tHBSux5MEqfoGx
5IrBdjJpRdr+gmb7xDUIi71a4aPXq8oJq7IbrYmn/K5nZGNe2NQVFhctbcUB/3H9
yUQynkf5/kn/FjuUMjfj1zg3xFl2mJ+V+2raqFPL0lOh+Vc5ZTzpVzJus1EOeJVn
MzYwij09ibWpzz2tkyPypknW9dRkuARypOXhOaNxACE6dEE7jA2vjvRl2FYNZmCa
aj5Vh0AqlzDYgktgojwLlEZmAbmrAuYnT88/J1lBLPU6PdIGqHE9RzTA3GMuarEk
UXzPsJXXJHLWUtZsrb04x1CWmiRVnfZelGdaR63uytDrGkubIAC46WCEOoeOImW0
VSdE+TJCKYEoAj3oYPCojLpHwZ9OcjjzdPaudAY80LfLpBTL/ND+c0J4a9tBnO16
EQiOJPnHozZRU9/AgEi2b3AxDJHkAmfWjJfIr+vfJQgLESTkgIcvBwfOGawtfwSv
G7KpGfFDZdA9HTVhoAV7UsV17wp57C5e8ciReEqvZg98t5dHcVdIswkv9mzkQdq8
SNblf0Sx3Ferx0jfZJBTe58PhLEUCqKjp4NIY1IJGNgdbcFhpRvyunbuMnbATeem
pUBJzn892fzBY/RqiH8OYJDo88qQwAxv/b4EwyeP8LdyFTIIPA1e0D/OTjs8uJxQ
816YqWzNWi0LfPA6F6bQKDwCnSTcXe+LNnSwe3W5jVpxcxnrE6hPKF3i018DGPXb
HFPyV8bC4w0Y0zOC9I7xrXu4wJZd1lWOdSb9vXqeRqG+wwN6aoWFa7GC7yH1umx8
GfS7BsD5ATyEqUgvvOXCLNGRjSNe0aLTPDdbJ4QGfT74MBdKs8D0tQz+wAfUt7qs
0MC1n93l9oZL4xrMTh3Ws5zaR5aYD4WBNfkmTP5J1dk0WGlvOGem1s4kOVj1X2CY
UVMBAeHSg2mkMRoWGUBjU4nOncu60pKgc+xWHQGtM6ocmd/9FawcJKS6QXMfgM19
dCTa4mmO5ZxmMmpGA78T/8ew0B2NLX7qW4ZtLp1r8Pirdyf4v2u51frG+fERmwvd
Sd83CuwsW4PG9rvax5bUOkfmuRiXxHxVKPEH2f8eSphLljUJvyQ9FzNu6cOybhIz
bcWMlO9gB/dve4lMplSE1LsXuWr3ymW7I0Bs2VW4jF2uw+0S56t+dSXO7bj31dE+
5fCfR7wtEXUZwz56a35yfszp6PzAwb7l6fjcAs1HyibKLfpUXi9SH08HwWv84n2g
K5BqRNj0DmPdYksoKLjVCCUeNqBqM/so7LQ6tva4Kj7JtG+NRBIVQakofzYH5bsq
j26qbb5tPKdZ5aAyxVyZkx+8NMZ5KYxaldcVxv02B0lwXg5WlPsiwmf9T1uUidgh
PEdcGJk+TH/Mr9r9HDwC1aUdp/7VuyuZOl+7WtynsPEYXuye6BNTopMckXwMVc8k
KbDlJZFCRueFDju+5sa4cXKzz2z3kUhfwcc4IO1jDtGyMU/1w4jkWq1g0Vh0ZFJ2
lC0LtQlNiB7MDSzGNIywsVp9WRhgYB7K8gEpsj7zzOH9ltvFlYFhg84skh4FSRNr
w5cLYZSS9wDCiV16rhHGLRZ5OExV3HfgZXCCDq6lB8YtHuGxnN+LXwAPeo3kpx+L
D9C4WULvYN8u7wk4uNZ0jJG9LcXL5zQOIA5SmdrggoLI0OtNilLoCy/lHD2MMMER
wOQ9SJBuvRB87xxzg8VmIwWrXI4iJUSiUSJ/ZuOuTtrdKywIaywH85DWFYZO251V
0+tp8zlEDr2DQgb3uqTLKtRep6lQPpyZw7TJY6oW/gLkpZhwHjv9/ihu3NmccIum
y2ALXzJ3uBd+6/Q+Ar8lE3reEw5/BitzDEhTutNx/YUuRq09LKSEMYJyzLPdACFr
8mZfHmUn5ue1ivu/ZgNXggBE0T7//ibd7Ao5rI6pPvMBmgA69V6hqNp5XPl5rqVv
nCrrxMs4Vcz18tVKATe8N6ekMzNsJP29ucSAv47Lph0xKN6N6noZFNleqatDxx0G
2Vahwr+YZQhGsXMSANN7E4/kWPkjwSbSbTSrXV5UcnsUtKopd8TdwyTyPeqd9O5q
hI1bozBFUx5VyqcJgS7eirIOqVQaRnlxj+V5TUDw1FNaCjNUOGt0rwQ3s+S4wMuG
lwo+mEYVoiCzbnMRRUA7yTGNsF8yhrpPo2AJHjB74MEsatKNMIxyHhu3/v+d+k7Q
O+7yNblE7B3ImVvsJ8/wqxe7USfMK3I1wN0J5h7Br/TPIhBT6F9r00iU2p3Ax4iQ
Q9zcTxdk+eHz0YnlhKo6m3M9uin+Z8UIzISIZL97EJIKIf3SVjTEe8ixOR0DKzCx
FgxP67KnjRUxga97vsl5Qf8sAeMQ2njz3njyr4OdfU9bsQgyvWVdtZAGDd60JmQq
TBXF8/Om8ihAfIgxnA7LJpUd9rBG39TyuCWUSROeijzBVUbgYNxXJ36X4NdJdyVW
1ecqKcuDKkG/ZOCOymsZQciPqfVieJ/OkP2U8VN+jNdwSPJ8UYqx90lw3w36hpiL
xjIW5iKry2kfM4/g4FMpOpJm7X1D7OvFhYDXB95CI5iGuXUUVzaGg8XZwwnzIMp5
Ka7aZhyH7NT1q6maA+MBuD/G6rqpWnrSr1QeTnfe5uB7kHrUSqKNkKjXM7DLC8dG
mt4DJYu4xk203OZvQafNNzZ/ssbhjd4INs55EXep26caWk6sBCpbXmajOXwq3uOq
reUCL/rdy8eI2WBggj1/hj5vV/ViYLIY43YBjH6i7wloRjdC/NLOdxAKgkggoWT0
990hMULNf4imP2bf+H01lgLpjdukjIuKZYGF2XYTLs9woxN1lfNWapemHx/5SlG8
Hv6jXPbHD6wkx7a012ZXQwInwtyAnOsZglSO8uQ8Ccn3EDjruYO7NGQX+XJRwq0u
STEdukMzD2y1KNLoE3Lq93PVWP+Trw63SWf9W1x6DCX3HsPYK87zgIzNHl7XYKy8
HvuZeGJQ0rDzSZGrhmcuVvMobImR3nuLpuH01MeDnowWaRAkbZsCAfOa6bWp/WLc
k1Cd5hIByYnHg3Q2KBrkmapy9I3DNCih9DbJHT8pWgedPhmAypncW2uZrHCrveeu
3uFs+dTC+gvmwYHDUFwHKWsoce6iNx2MM82A8E8uqQH/Zx15k7SbhF52ZOwpPB4i
5T7lpjdmIO9zN/hd5InAvpKhx9B1ILzkt/ORvh4e1qApVs0+tj7MkrkieUtwltCu
osaHy/PqniqYm+vYUET+ZtsO0f30zhj8JexAXspo1wyTo1tyYT0gSpDRteJLlIbH
fPettyggU8G06NULrkYvHlKnnDDFCz4rgIM4xYpwZQkocsQzGIiD//gE1W6Y/Pki
yqzbrccCj8Nog45IFerivhuil33+lO8HmLShiYc7RKibF6rcjJuFxhCQ1kZmsV2w
zVKsW8IL4lVsAvql36GWGOPZRrlv1e+9qs6eqDKxRLa6uNWIRMiu0NnEsB63/450
x07Hh/PRsNO/9s35hE+O48KBKGURZlwIymqKYADuYoqR7IyLkiA3PiX22lX7coNd
7iOzb2TZRq4hyeOKs3+DIzCTqVQmjuLyg35H6hqA40NOz5HBPTp2WfCSufis360a
ELyoBoLwiaU8IjLNZW7L2lhccjYRuYEAew00JJ4PrSGR2L/Qt1GQDE9IQWzq9whc
99T/t8cUPdx8bbyJW9nMf5fcSKJz+syoRgBGynqP5GVVeqRpYZBilC4dujW4k12E
ulXsAIn2nrJS8u2Y8wHyCqyDJ/Z1j3shmzvcFPv0lILng4uzuGRVsVLzBalmJ8+o
O9NhQmbiZkfS1gNlaxdVYHVoS36RcBimm7roSQiYQY+185w91HCyHPopYo8kUIcI
Fr6bCrztIy+c26g5TEljXZ4k6RfijWwSHaJoMzrJH+QHgScEj5rVF2NA08/XJPU7
h7C/XWsShSq2EkQbl/eK+JLSD9pM9Q8G6v0qoxU6gJfm6TV8n0U6GtA07czoAWeU
aKSVfGbMGJOm/+j26K3oBqZjjuadh9KH9U52fOAHzu2uuuOdXXp5NEv5oUHLkxn7
IJ6RLGEB4DsGtBxj2MJPId0nUFvPM/odrcSoh8JUIN7JZCujRVuiC8jJcDHh7ti/
NodOxatlt6gfRFUoKtegxqYQbhiaIcyBYLtJ9G2Tl5ColCaSfLWp+Mm2EMt/z446
BLPizKospkoLsHaepETvE1U8IViPFAddpibKE3vLeC2otCnW9JIsPOPksHSwvow6
DRK7TpfSFqLOZCLUnGqcBlo+SZ5DArCU7mZuPFMhR2W7aqJcCD9KmC6d7ChqBKkb
Hd4GAhTLTMiez8HNPLaYZD+5gaRrEgwUuD12Z3dZfY0npFQWbvNyiJBb9lYWygUl
yOS1IhfLNgoF+yhrYsheb5AOX1uz+EeotBjHi6faY4kQ3b9KMnzaR6qtxp33vknk
xeV79JpOsAQZVcMNqoHYatYDyEfCMcFYg60bdGepOWR2YFAQ5kgDWAdf4tRWZEZw
guDwgH0pvM3+H51ibmgNnz65yp7fbcqWWbW+qH7PHHroLiG7VuqCinYD5qfTqTst
TsnlQsGHyqAJeeOTQiEr7aR0k4Zo5CbrkyygvABFwRYDSY7uvTrsEPsRAn7IWL0h
scEIAY40p5w3xAZo1LZoMxpoKtc5N6As3M+rUKSxrZ0zFhuOPr5LMWXdiLf++HF8
K8PtlXDwnStM8hY6miZIuBGJSVMHULo0aG5fSe2yN/Xh35UtvRNm8+I96k0DIWaK
/GhbIgq3PIMp5NgJHe9624A0TgIKtKDpLhjZEqyyq7eawRgcqNsvMVgbNXQy0e8v
s9rTQkkg3cATtPGTN4pECUQ0Ny6fRlE3Bzy1wvrk/Pi/WU34t73Q+Ylg0qMln3CF
skEXTuVkgTgDtoTErInwNbHt9LDsm+YzeZinfrRvNAab/yWTq6dNhIT6tWV0poLV
LMaHVr2IAyW112xVFX4/RwCckdn3kBNTgB6NTj/JMoZFQL8AQcNeW/AmQiUnI7d8
B6YuYbkqDp1hsWs89Lnc3YEmaXPqZff6DRqlgh4Ko4N4cHCPB8zea3BhrYN0zwNr
EqPnq4agMvS7sdC5kcsDt8HVal0UTHLLiFSQNTUWE/zBz/fzQGOdR1ajnEJ2+VfC
VFrRd7Qy+CErphG1Vt6L5oHuMZOcoQ0YL3W6yMQV2mzhbHoTvsBWv1Z1ITOlPNT3
vhX8T//vC+KGVPz9jy6+PahZ9/Zib8FWQF+silMcJ5ha2IS//6m/qGp8i3z8MBzh
Uram0kyYrdkyH/13wOtA13fVWPyF/GEF8qABzoxCS8ueDdqBpSN6YU/O9j91PkAc
WrlRXh5P885PzyMgRLbLShpGw1ydyu+Fp1vbmALL8ce3LviRU4kcMz13Kes18dG1
06JZYUjYe+dB5sgNw9PoOeLnOQecUrIf27Tpk51/UtnTABKOTuwDbgfIlJBWGfaQ
/jpGh1FgbTMwUG/kEWx3JAfZKDxnxnL74j8NhjMdQM+EK8IfphA6SeSZuWC3wRAd
0gFANRdSNIFcOKvwelsgEKd/+3ASupZ9B1Z14bVM1sjcD4vO9RJHFol2IaE5wkv6
D4b9IzFPune74iTdw0qtLRh4KsyMFIHp9BLSbFkEy+cvagDBBl9DUIb3+CR2EFGz
zSP0XxNlrbqjJLJWpf9oJapeQebEZdmYt/NWLYrTer0tij4W3wJ5uPgWoxjxK4nq
cqIGlSWuMe1nG8Jd1AzH8ermOrUjaMJ3cLgwiCGITdWnT4mCxr+hdjHOtRrBSCPi
OzKoT3YkNQABMSI6dCWQYZ/MGbSJphRDOz2C9tjpl3lLzOoemn0dEGU02e5RUYC6
9F3CWJtmE+U4pDKPyRbPNnqLxVovGN2JlENpPPz/LFjRfrLjmlI0KlIrxS/nkFNM
v7dz7MOThC5PX2b/kg6XIKwduDsXgCx916EK1E7yuImAf4M4RfDNGph6Lq5vijoC
UHQEMO16brM6zsu4sorgWR1CyBHGPhgQb3wvaJrJNFR2iHp/aNcR4reYkoMiD3F5
stRP9i2GwFZ6FiUYKeXtGrLYajwM/MOL0zlSPzzOFjYf24z6696S114upKbuJmgy
92unC3jrYDHtZY1+x/ofoDRZQ/QM9IMZXP0iycS6deJjmWHXRvtHtGpbyoWOOHYQ
LIg5pgJ3DrW20kBxoE+eGyRx1kf+TaBW6G8eV5v/zyIiMxXS3I2BghJ/WIfjEeFu
ygMcZUsfgH4O/boBnBmb2r1WriikgoapT77PgLnjB45XT0w3waeE1WjyYnQcioNH
dxGX/3whg0qL1eHNLStXLJm59DSaBQ0q3vWnqIFl7NiIY0wRYiP1zGABWHLBXi8G
OcVOZcH7U5FPfb+RoL0qKf/B2oV1yUl0r4LFkFVKUGfwWagUA9vG+u0F/ASMxKio
yiTN0nDLy694BNRGtiLbgwb3n1MZz1NtIujUTvI2AaOjn6RtVdpfMSXmNaAdHfBS
kq8sxAJDf8eepKbAyh4wAiDp7/1DJopSiSvnTLxozl0XWqJLwqu059NCrcAQcKVD
WX9Mg7F+jvtvb6+7pUN7vCFdYUgibmuGz+tYfIjkMyYycma/czd6xaEV+dJKLIkc
6b8UfALb9IeQUKYVHEIxI/PQm99rahwCyzD4KRF3mG4WAMNfohlfZiqAnr+3uw8W
iqyb7FKKr2i4iFTQiuo1K0xp8RX6kAWOW2KM3Hc9kO7i6aPtPIYuoe7UtIWDTGqw
a0Ac3lni+zPcmkR684KKxu4zECzF+Xr9NUgf4kySZ7IlCu9Z3txqm9G4Mdy0/y2e
W4Z7Smct9+s1+npzbPMmmXApxFGxXIKxUBqMg/m2qvkzq4M6yRDuG4QwA7H6+wpS
ve+a07USWiFM71JVU9sA8eq6uCcPnxm12/S+CcYknG98arUCiwP/7F0Xraz2pS/A
vcaQDfH6Ub4dSEtSWrWRlPHdwaoJ0bFJlxJjB97pEAkHzTuCXKJOys+Oza47u6l8
uGM8TvfcMA5zEboYov0yQJHNYvPuy9NN+hk6Yy0dqKJDUlQPiNscPfNKrhXM9OQ9
j8dgCn5TjFwa9TiKzkrsUYSrYq5G9ILwlcKkjdusKsnsL2HvZMXheB/ZcS4gaJlW
tMgeyHcVqhWWZmden8axgsC/A5GHB/OUcZV2zlveWiECuQsm81+UG7rYx1rylkvM
nDGNmWx31je2Yzko3ssa47As+Z3EJQNbRg/q80GA8JNbnQCDcn4YKvE3fBR+FFO1
DztAj89LYdoUst90nwrZwbQLylittb3KM/SrKOxzHZT0tCpR0LXZk2aqOmdT8AI2
Id/TRbJgGVtLQ7uSDgSSAEMcQh0KPCkq9uSr5Tl36pdAeqt//Yj4gZkPR8F3GQEN
uEvEDhbbu3Ut2uzjtmBeAjJuPbU+VipGnW4PWB3vq1U8cLm2FvHtScEm8Lt6YH3r
ZCVvQvH9+1gDKHw7GDRsStLq+1kLkcwhobRMdllGCb/u782TyIgYfDUmZE5lwyIv
l+8DXW/CYgdFq/o/uo5Qjm8Un6QeQRAMSf9Gl27NeIFPm9onjNpYiVLKikm6OAA9
+tfiMZDMIimTqs2iys5yGNBFK4HaAtOmDyXuHThOuiZruPzxGcXniIi7bZZKCdeJ
IpOD1tOPe5QTbVsuDPUnyR5dkkTJoUt752S5Jm61V23JgO2nnivq0sPerpcH07y0
iDFrt5sJEzp3EVcT8Af+G2fJFqhyRRJ1tx40BTKaeyTJxqfIjjtsUUugE+BXuU3W
HJOcTCX5N4+920lps9vxnyxP702lFknHolQ0wlgVYs7b8inz7e1k8p9XyamUAEYh
rQ1wmwnLEeTiRn1uUmxVED0DAqgZLf/WzpTzpacmIJhi+d836u/vqSld7vfS1wwN
MO4iD2mwOSUekgdzZT4cr1M+zhZ1OztCWmkL1IsKE23VkmYsQXDEQApLTK4xwCeu
m8tUkDqvOLvc8NEzUe6OiE2gcwx2bU/TnV2cEWRuz5vntPy/LykrSnN4rExT5wdc
8U1zU3khm+iKI7hF1YspdCmu2a0eeA9xM/FpQ09FOhZLjTEL/hyYn1OGBAgec3Ix
sz3ixSw72yNFbtAXAQzXfcTqplQ+T2+0gDl6ZQCDAAmQIijUpBcQgOnMwsgLGlv7
/v8c1sUElCqtGNIUAloYmCABX2goijR2198JqVTjgADSw3r65AMysaMLVRjukz6H
qe95WJ8x5kWuAGTjxM8c8Q1IE5Y/WRPgHP1R+NnuT2v86SCVHrmEm21HcM5FwO3z
7TWSPkf2pFpMdsmLy+4F+yb9cg8B0gDi40Wknb6m4+BzAQ3qNVosbB3cwiAAx/pw
QAAREUPWdEv+NmmpHpVYvTzg7SXvZyNQlB0j3FNVFoO2hzjty6azeSsTwewQXdcO
vmzQdxWIkAihptAHW4TtfW4y1byVznX5G1BroMgaQDNr9QPjVfMEpYrvSRYJpPug
+AA8DTLLPxBSoSIPpqg8LvgRnnmdg2xtjVOo5yIfrIUv0MroGSprsH03LQh3/Y9g
yufyMinCa1JSrTZWXtuhIfnzWVHxznOOb075CVwR8fuOYbcnAEBkw1m3+fGBNhjG
tFU46IeTB2GqD+pQihmiaQ3A0j4BvN6URRk962TIpT1i1XHfR0epp2BCur3wuSsx
zEaLf00xvZ0JFuDgQEvN+1ctbhPwWDvcpPe8X50YPm84tSWkf+avziNDEavKoA44
6Iu5smVY1tnYynDWADcUJHt7uDNK7OPD0sFWXG0eqlA+Str96yVtAouPwWCFifFY
nC3sPASO6Gx/tedJPZDPG3/iHZDhNfYHidlwU3fUEW4qAVDDPSNrb5btdi2Q1Em/

//pragma protect end_data_block
//pragma protect digest_block
d+a5toKyqBG+Wpoqy4H8LkRUVDI=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_SPI_NAND_FLASH_MICRON_TOP_REGISTER_SV

