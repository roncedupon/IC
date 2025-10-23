//=======================================================================
// COPYRIGHT (C) 2016-2017 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
// The entire notice above must be reproduced on all authorized copies.
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_GPIO_TRANSACTION_SV
`define GUARD_SVT_GPIO_TRANSACTION_SV

/** Class defining a GPIO transaction */
class svt_gpio_transaction extends `SVT_TRANSACTION_TYPE;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  /** Transaction command values.
   *
   * - READ       Read the current GPIO inputs
   * - WRITE      Set the GPIO outputs
   * - INTERRUPT  An interrupt condition was detected
   * - PULSE      Toggle the GPIO outputs for 1 cycle
   * .
   */
  typedef enum {
    READ      = `SVT_GPIO_CMD_READ,
    WRITE     = `SVT_GPIO_CMD_WRITE,
    PULSE     = `SVT_GPIO_CMD_PULSE,
    INTERRUPT = `SVT_GPIO_CMD_INTERRUPT
  } cmd_enum;

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /** Randomizable variables */
  // ---------------------------------------------------------------------------

  /** Transaction command */
  rand cmd_enum cmd = READ;

  /** Data portion of transaction.
   *
   *  For READ and INTERRUPT transactions, it contains the current GPIO inputs value.
   */
  rand svt_gpio_data_t data  = '0;

  /** Data bit enable
   *
   * GPIO output is affected by WRITE or PULSE operations only if the corresponding bit
   * is 1. For INTERRUPT transactions, indicates which GPIO input(s) triggered the
   * interrupt.  Ignored for all other transactions.
   */
  rand svt_gpio_data_t enable  = '0;

  /** Number of clock cycles to wait after the command has been executed
   *
   *  Default is 0.
   *  For a pure-delay, use a WRITE command with no enabled bits.
   *  For INTERRUPT , the property specifies the number of clock cycles since the
   * previous reported interrupt. The first interrupt is reported with a delay of
   * 'hFFFFFFFF.
   */
  rand int unsigned delay;

  // ****************************************************************************
  // Constraints
  // ****************************************************************************

  /** Do not generate INTERRUPT commands as they are used solely to report interrupts */
  constraint valid_cmd {
    cmd != INTERRUPT;
  }

  /** Limit the post-command delay to 16 cycles */
  constraint reasonable_delay {
    delay <= 16;
  }

  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_gpio_transaction)
`endif
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new transaction instance, passing the appropriate argument
   * values to the <b>vmm_data</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   */
  extern function new(vmm_log log = null);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   */
  extern function new(string name = "svt_gpio_transaction");
`endif // !`ifdef SVT_VMM_TECHNOLOGY

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
  `svt_data_member_begin(svt_gpio_transaction)
  `svt_data_member_end(svt_gpio_transaction)

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name();

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode(bit on_off);

`ifndef SVT_VMM_TECHNOLOGY
   // ---------------------------------------------------------------------------
   /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);
  //---------------------------------------------------------------------------
  /**
   * Extend the copy method to take care of the transaction fields and cleanup the exception xact pointers.
   *
   * @param rhs Source object to be copied.
   */
  extern virtual function void do_copy(`SVT_XVM(object) rhs);

`else

  // ---------------------------------------------------------------------------
  /**
   * Compares the object with to. Differences are placed in diff. Only
   * supported kind values are -1 and `SVT_DATA_TYPE::COMPLETE. Both values result
   * in a COMPLETE compare.
   *
   * @param to vmm_data object to be compared against.
   * @param diff String indicating the differences between this and to.
   * @param kind This int indicates the type of compare to be attempted. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in comparisons of the non-static
   * data members. All other kind values result in a return value of 1.
   */
  extern virtual function bit do_compare(vmm_data to, output string diff, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Extend the copy method to copy the transaction class fields.
   * 
   * @param to Destination class for the copy operation
   */
  extern virtual function `SVT_DATA_BASE_TYPE do_copy(`SVT_DATA_BASE_TYPE to = null);

  //----------------------------------------------------------------------------
  /**
   * Returns the size (in bytes) required by the byte_pack operation. Only supports
   * COMPLETE pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   */
  extern virtual function int unsigned byte_size(int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Packs the object into the bytes buffer, beginning at offset. Only supports COMPLETE
   * pack so kind must be `SVT_DATA_TYPE::COMPLETE.
   *
   * @param bytes Buffer that will contain the packed bytes at the end of the operation.
   * @param offset Offset into bytes where the packing is to begin.
   * @param kind This int indicates the type of byte_pack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being packed and the return of an integer indicating the number of
   * packed bytes. All other kind values result in no change to the buffer contents, and a
   * return value of 0.
   */
  extern virtual function int unsigned do_byte_pack(ref logic [7:0] bytes[], input int unsigned offset = 0, input int kind = -1);

  //----------------------------------------------------------------------------
  /**
   * Unpacks the object from the bytes buffer, beginning at offset. Only supports COMPLETE
   * unpack so kind must be `SVT_DATA_TYPE::COMPLETE.
   *
   * @param bytes Buffer containing the bytes to be unpacked.
   * @param offset Offset into bytes where the unpacking is to begin.
   * @param len Number of bytes to be unpacked.
   * @param kind This int indicates the type of byte_unpack being requested. Only supported
   * kind value is `SVT_DATA_TYPE::COMPLETE, which results in all of the
   * fields being unpacked and the return of an integer indicating the number of
   * unpacked bytes. All other kind values result in no change to the buffer contents,
   * and a return value of 0.
   */
  extern virtual function int unsigned do_byte_unpack(const ref logic [7:0] bytes[], input int unsigned offset = 0, input int len = -1, input int kind = -1);

`endif // !`ifndef SVT_VMM_TECHNOLOGY

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>read</i> access to public data members of this class.
   */
  extern virtual function bit get_prop_val(string prop_name, ref bit [1023:0] prop_val, input int array_ix, ref `SVT_DATA_TYPE data_obj);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: For <i>write</i> access to public data members of this class.
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
  extern virtual function bit encode_prop_val( string prop_name,
                                               string prop_val_string,
                                               ref bit [1023:0] prop_val,
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
  extern virtual function bit decode_prop_val( string prop_name,
                                               bit [1023:0] prop_val,
                                               ref string prop_val_string,
                                               input svt_pattern_data::type_enum typ = svt_pattern_data::UNDEF);

  // ---------------------------------------------------------------------------
  /**
   * HDL Support: This method allocates a pattern containing svt_pattern_data
   * instances for all of the primitive data fields in the object. The
   * svt_pattern_data::name is set to the corresponding field name, the
   * svt_pattern_data::value is set to 0.
   *
   * @return An svt_pattern instance containing entries for all of the data fields.
   */
  extern virtual function svt_pattern do_allocate_pattern();

endclass

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Px+kG5kK1BtlKdNr63w9L4FQ0a7TponrNYA1VBt1Mm8eSLLFoW+Bq9n7Cn5fQDcU
Xq2nzpFB3EKjmmj8GjDES/OfyQWY9Lub1YXboXCTZ9YA7mRaqJx67iPQ4opKZ58R
QaaSyWUZV1HKdiNEZqVpZQrOowBK3R+waI544blVy0okQ+ZkjvTsNg==
//pragma protect end_key_block
//pragma protect digest_block
yoS0GoO45l/ILMRIrkIEa2+LLFo=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
y53daGaRpAcBa0n2LOnZowXirhE=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_GPIO_TRANSACTION_SV
