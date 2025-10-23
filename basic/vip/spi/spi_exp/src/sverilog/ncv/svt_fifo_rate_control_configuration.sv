//=======================================================================
// COPYRIGHT (C) 2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_FIFO_RATE_CONTROL_CONFIGURATION_SV
`define GUARD_SVT_FIFO_RATE_CONTROL_CONFIGURATION_SV
`include `SVT_SOURCE_MAP_LIB_INCLUDE_SVI(R-2020.12,svt_defines)
// =============================================================================
/**
 * This FIFO rate control configuration class encapsulates the configuration information for
 * the rate control parameters modeled in a FIFO.
 */
class svt_fifo_rate_control_configuration extends svt_configuration;

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************
  typedef enum bit {
    FIFO_EMPTY_ON_START = `SVT_FIFO_EMPTY_ON_START,
    FIFO_FULL_ON_START = `SVT_FIFO_FULL_ON_START 
  } fifo_start_up_level_enum;

  typedef enum bit {
    WRITE_TYPE_FIFO = `SVT_FIFO_WRITE,
    READ_TYPE_FIFO = `SVT_FIFO_READ
  } fifo_type_enum;

  // ****************************************************************************
  // Local Data
  // ****************************************************************************

  // ****************************************************************************
  // Public Data
  // ****************************************************************************
  /**
   * The sequence number of the group in the traffic profile corresponding to this configuration
   */
  int group_seq_number;

  /**
   * The name of the group in the traffic profile corresponding to this configuration
   */
  string group_name;

  /**
   * The full name of the sequencer to which this configuration applies 
   */
  string seqr_full_name;

  /**
   * Indicates if this is a FIFO for read type transactions or a FIFO
   * for WRITE type transactions
   */
  rand fifo_type_enum fifo_type = WRITE_TYPE_FIFO;

  //----------------------------------------------------------------------------
  /** Randomizable variables - Dynamic. */
  // ---------------------------------------------------------------------------
  /** 
   * The rate in bytes/cycle of the FIFO into which data from READ
   * transactions is dumped or data for WRITE transactions is taken. 
   */
  rand int rate = `SVT_FIFO_MAX_RATE;

  /** 
   * The full level in bytes of the READ FIFO into which data from READ transactions
   * is dumped or the WRITE FIFO from which data for WRITE transactions is taken.
   */
  rand int full_level = `SVT_FIFO_MAX_FULL_LEVEL;

  /**
   * Indicates if the start up level of the FIFO is empty or full
   */
  rand fifo_start_up_level_enum start_up_level = FIFO_EMPTY_ON_START;

  // ****************************************************************************
  // Constraints
  // ****************************************************************************
  constraint valid_ranges {
    rate > 0; 
    full_level > 0;
  }

  constraint reasonable_rate { 
    rate <= `SVT_FIFO_MAX_RATE;  
  }

  constraint reasonable_full_level { 
    full_level <= `SVT_FIFO_MAX_FULL_LEVEL;
  }
  // ****************************************************************************
  // Methods
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
`ifndef __SVDOC__
  `svt_vmm_data_new(svt_fifo_rate_control_configuration)
`endif
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the <b>vmm_data</b> parent class.
   *
   * @param log Sets the log file that is used for status output.
   *
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(vmm_log log = null, string suite_name="");
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new configuration instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name of the configuration
   *
   * @param suite_name A String that identifies the product suite to which the
   * configuration object belongs.
   */
  extern function new(string name = "svt_fifo_rate_control_configuration", string suite_name="");
`endif // !`ifdef SVT_VMM_TECHNOLOGY
   

  // ****************************************************************************
  //   SVT shorthand macros 
  // ****************************************************************************
`ifndef __SVDOC__
  `svt_data_member_begin(svt_fifo_rate_control_configuration)
  `svt_data_member_end(svt_fifo_rate_control_configuration)
`endif

  //----------------------------------------------------------------------------
  /**
   * Method to turn static config param randomization on/off as a block.
   */
  extern virtual function int static_rand_mode(bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Method to turn reasonable constraints on/off as a block.
   */
  extern virtual function int reasonable_constraint_mode (bit on_off);

  //----------------------------------------------------------------------------
  /**
   * Returns the class name for the object used for logging.
   */
  extern function string get_mcd_class_name();

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_static_data ( `SVT_DATA_BASE_TYPE to );

  //----------------------------------------------------------------------------
  /**
   * Used to limit a copy to the dynamic data members of the object.
   */
  extern virtual function void copy_dynamic_data ( `SVT_DATA_BASE_TYPE to );

`ifdef SVT_VMM_TECHNOLOGY
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
`else // !`ifdef SVT_VMM_TECHNOLOGY
   // ---------------------------------------------------------------------------
  /**
   * Compares the object with rhs..
   *
   * @param rhs Object to be compared against.
   * @param comparer TBD
   */
  extern virtual function bit do_compare(`SVT_XVM(object) rhs, `SVT_XVM(comparer) comparer);

`endif //  `ifdef SVT_VMM_TECHNOLOGY

  //----------------------------------------------------------------------------
  /**
   * Checks to see that the data field values are valid, focusing mainly on
   * checking/enforcing valid_ranges constraint. Only supported kind values are -1 and
   * `SVT_DATA_TYPE::COMPLETE. Both values result in the same check of the fields.
   */
  extern function bit do_is_valid(bit silent = 1, int kind = RELEVANT);

`ifdef SVT_VMM_TECHNOLOGY
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
`endif //  `ifdef SVT_VMM_TECHNOLOGY
   

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

  // ---------------------------------------------------------------------------
endclass:svt_fifo_rate_control_configuration


//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
T0B8ZDN8tAj9AGAzxQZL25M4uYsLhOrmJruXNcb/kokeV1RKgOSnnRg0d/iToBKR
lgkDlCfYViK2UCnlpldKZQmNrDp4VY2webw0RXi5rmRkTipakanxqsMyuu4XAMez
SWZR8kMK9ATgl2LpwFPbgEyQY7gJTmd2oo/MX09kgUv+/aItA9CQgA==
//pragma protect end_key_block
//pragma protect digest_block
VqbGVgy+PI7g4EOKyza/iFQHF1E=
//pragma protect end_digest_block
//pragma protect data_block
c2/khAaht74I7dylizCsQAscz7UC2ZwVk8XojhiNoG3HpuyNsFwonAC+YaryW2om
E8FKD9qsYByp1/Lbdmt83HPEedSOTtDDS3jlGyCyl+NR1z1JukQpggJsHe9z7PSx
6uDldLCPC8XO5uuTQumD0CncVEMv1e2KGXLXaAyBxoNngoXKVJ0m2Dh0Qk9b+uvS
g7rO7Qfu9pLk/XbQ08AhjoxNGb4quckP6d9pklgCgSXjeaRM6iNEKAcUm/mkNOhj
cTMDynOfdmM2YsPDCPmCmhJV0HRMWwzf1UUbQgDNn0SBj3Zs04C9SyfyvA1tWYIV
OhUIvvXdz15Jg52B2vDmw2WMkhdvXVhzK/9BJLkCKqVNPhQYfy+Xs7TjBzsbdA4H
8THg9dz1Ih02NQk5CKXYhue2vZIWfiA7qcOa6neDm2yojKXpMRxJciaToQ4KD1xX
+NXBhFmiR6GRt6NXbpW9KfSayL51iO4fqEkPcIo8/9HbibxFp2kpSCoEPnNKAOFL
PK8v6cNYxU1DV813J1H51e3jd0qI4jjVPPr7L/gzdZXRDoiXe75PNVJZ7wI3Ib8K
Q0bTLgwptTkMTL/PyDKZAeplolN58GE1YVWebJgyILLtcjj+csj0xUJg/oa48mGm
7sFYCWsemOQA23oddAaK5Y6KMnPxLphnaHMfi11tO6D/z8C5er60poDiTC+QVKE3
DMO8yLCuAlXiglB8S8d0I1RtOyuWS/cHcfhqA7K6e5E2x7QwGlR2KIgDB6jONv67
+6Qx3bBn3PcTAhuPxBeEygsRTcLXDjzZLOSlFqWS2nfDjUYlSwWK5VHudIW+98Qm
BarvuaHgopclCCKDN1gr0N9iPZ+YF9LnpGBRIf11MlghMeLU2Jgp61+Y2ZvGc+KR
rYO7rrJEtG2GsvoSTCcSthpeOVGkXZf09LF3y5GrW5mqmpMpvKkayNGzaIcoqXWz
5Sdr4I+NfO40Y6VZb141AXmDlT2AmcQ45V/t3Yms2PDXQvtrd9vLhyszTfWAnI17
pSrYj24kMeFcPGJKgLw43a4xlL9eKVyB7xJ8oZnEHo7xlcOIgFRWzD7sYcSs3Mg6
o2H7amr3l2TgR6xRwkReB+VtWUHZ7T+EV+rvtB2LkN6xRll7YHem6efHhMiaekiN

//pragma protect end_data_block
//pragma protect digest_block
MLFSPrc3XG6ovdXLTX461aIqJ1U=
//pragma protect end_digest_block
//pragma protect end_protected

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
XKhqQIvAUjIPgQt7ghDzJMQgLniYfzN2/CC+GpcRXiHgEvYdSG1vCd9FBifwhWII
SxCg97tUiHtS5gtX1JvE2XKzHbdYTVMN0i5RozFanrZfg4Z1qeZ7ZTkAOKxO6kDy
Xq9qBD9vxixWzD1Ah0dBpIIZdWnbbw4VdzSdCMsm2wDW51ZCndyuTg==
//pragma protect end_key_block
//pragma protect digest_block
mAlvwbJq++7tBp3Exl0Gzh4EFnk=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
WGn0XKVZwWs10OLBsul3AJmUhwA=
//pragma protect end_digest_block
//pragma protect end_protected
   
`endif //  `ifndef GUARD_SVT_FIFO_RATE_CONTROL_CONFIGURATION_SV
   
