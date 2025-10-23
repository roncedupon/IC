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

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
54ZCyKJZZfPlB7P9qzE7E3yRn16bdxIu7u5TVcYIwlsEiGp2PbkBALOsJlJ2ZTyf
fGB81oU23uFESSPjntQnut7RHS+hSsj6BOhQdSCdM/6z9rz9bdPcxRIBJWOz+6+Y
VcDq9B62iipzuKrOyMFLRy4rt8CqEiZRzXD5HqgLuDZGnKecA0fYXA==
//pragma protect end_key_block
//pragma protect digest_block
lOcupaxX8K+rjOplCj1MQ7OoIbY=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
pwz0XFlrFkYf9/tqSpUxRhZe0WY=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_DATA_FSDB_WRITER_SV
