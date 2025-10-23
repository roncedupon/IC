//=======================================================================
// COPYRIGHT (C) 2015 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
//
//-----------------------------------------------------------------------

`ifndef GUARD_SVT_DATA_FSDB_WRITER_SV
`define GUARD_SVT_DATA_FSDB_WRITER_SV

/** @cond PRIVATE */

/**
 * Utility class to write data values out to FSDB.  This base class writes
 * values to an FSDB file.  All values are stored as strings to simplify
 * the read back operation.
 */
class svt_data_fsdb_writer extends svt_data_writer;

  /** VIP writer instance to use to record the data */
  svt_vip_writer writer;

  /** Unique object identifier to associate the data with */
  string uid;

  /** Singleton handle */
  static local svt_data_fsdb_writer m_inst = new();

  // ---------------------------------------------------------------------------
  /** Constructor */
  extern function new();

  // ---------------------------------------------------------------------------
  /**
   * Obtain a handle to the singleton instance.
   * 
   * @return handle to the svt_data_fsdb_writer singleton instance
   */
  extern static function svt_data_fsdb_writer get();

  // ---------------------------------------------------------------------------
  /**
   * Write the supplied bit value to the FSDB file.
   * 
   * @param prefix String prepended to the prop_name value
   * @param prop_name String written as the property name
   * @param prop_val Bit value that is written
   * @return Status of the data write operation
   */
  extern virtual function bit write_value_pair_bit(string prefix, string prop_name, bit prop_val);

  // ---------------------------------------------------------------------------
  /**
   * Write the supplied bit value to the FSDB file.
   * 
   * @param prefix String prepended to the prop_name value
   * @param prop_name String written as the property name
   * @param prop_val INT value that is written
   * @return Status of the data write operation
   */
  extern virtual function bit write_value_pair_int(string prefix, string prop_name, int prop_val);

  // ---------------------------------------------------------------------------
  /**
   * Write the supplied bit value to the FSDB file.
   * 
   * @param prefix String prepended to the prop_name value
   * @param prop_name String written as the property name
   * @param prop_val String value that is written
   * @return Status of the data write operation
   */
  extern virtual function bit write_value_pair_string(string prefix, string prop_name, string prop_val);

endclass: svt_data_fsdb_writer

/** @endcond */

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
agOMSO850mFNQOHe1/I/ZU2EgYNMx4UJqRZZ4pdMJGc0qOxtiebdYeh5wlO2lGQG
EYSMiLnO9zUcJjKMTrANKY5YFc9Jkzv5H9lXMvRdhaCGMjmp7UvwjoJDQRQZwPb9
21iY6/XYBydNiOVA8bmeY+HBHep4wPoOQ9WGqmgPAgQ=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1837      )
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
FE2IlxD0dtRK7MWVdJUVHw==
`pragma protect end_protected

`endif // GUARD_SVT_DATA_FSDB_WRITER_SV`pragma protect begin_protected
`pragma protect end
