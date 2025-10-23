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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
PhlRHVReERKrXbwUcAWqkL8I+8RcYaetKPZSmE1M2BcoZ+9/8/ShojmQ/7PthtBJ
2tthubqFXtCTN0U6iJcSQ9rFQ3A5mN6eV9zYjG9U8+EArKGlXB+cYJSFuqZt66W9
1ieGcC8secNzLmjx9ABksV6rgpJ+FP2s5qBl9YBqUtc=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 12196     )
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
uShmxUL9GkVDu6gfHQBKww==
`pragma protect end_protected

`endif // GUARD_SVT_GPIO_TRANSACTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
OWjG/cnJ7aNUpu2OFWpvBUFWfgvtp8OJeyYudiFSD3q49+Fp9EVFWHAB6nwwQrz7
X8EF1g/4eGzBXNRyS0Lr/NYq6V3W7TsafX2tdCamH3furOYVHVor0Uu+VRHbHVKT
p1W1mMhLt2f2qYMj7omyiwifkBGZ/WQiENPPD8AQLuY=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 12279     )
pILAR6xquAQE9KRN3EjAEmAO7oogtAvi7F8LN4AxaI+myxdIdMEkyYWXXOQ1UZyP
yZ6Xf5ita8QCTCtAOfJCGSn8gY112DxaLDtxjw1SKaxA0a1qdfpEakCJpPfWeNMd
`pragma protect end_protected
