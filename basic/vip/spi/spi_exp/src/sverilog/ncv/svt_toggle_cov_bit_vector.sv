//=======================================================================
// COPYRIGHT (C) 2015-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_TOGGLE_COV_BIT_VECTOR_SV
`define GUARD_SVT_TOGGLE_COV_BIT_VECTOR_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * Class used to support toggle coverage for multi-bit buses. Provides this
 * support by bundling together multiple individual svt_toggle_cov_bit instances.
 */
class svt_toggle_cov_bit_vector#(int SIZE = 64);

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /** Coverage instances for the individual bits. */
  svt_toggle_cov_bit cov_bit[SIZE]; 

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
/** @cond SV_ONLY */
  /** Built-in shared log instance that will be used to report issues. */
  static vmm_log log = new("svt_toggle_cov_bit_vector", "Common log for svt_toggle_cov_bit_vector");
/** @endcond */
`else
  /** Route all messages originating from toggle cov objects through `SVT_XVM(top). */
  static `SVT_XVM(report_object) reporter = `SVT_XVM(root)::get();
`endif

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_toggle_cov_bit_vector class.
   *
   * @param name The name for the cover bit vector, used as the prefix for the cov_bit covergroups.
   * @param actual_size The actual number of bits that are to be covered.
   */
  extern function new(string name, int unsigned actual_size = SIZE);

  //----------------------------------------------------------------------------
  /**
   * Provide a new bit_val to be recognized and sampled.
   *
   * @param bit_val The new value associated with the bit.
   * @param ix The index of the bit to be covered.
   */
  extern function void bit_cov(bit bit_val, int ix = 0);

  // ---------------------------------------------------------------------------
endclass
/** @endcond */

// =============================================================================

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
FMdY5HnYHsbdiV+VthvvC2NtVX0oGD5u+0+TicfcIvGMjvZ/5Wq+DxRr+jbKRDxS
1uAqrFFLDFYbysjatW/iGwodDO9aZsOa2UioufuOZLuQOlvQem21P7gkt1x6Cfds
/x0rXb/+BmE05B+KNQoVHfx0oQ/kq68wnFxx/2LlmGeRf7HdTmqoUA==
//pragma protect end_key_block
//pragma protect digest_block
PNJxTLequn9M4j93pSsHzvNCJME=
//pragma protect end_digest_block
//pragma protect data_block
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
869rPyhOEgfFbrGbIRnv/Q==
//pragma protect end_data_block
//pragma protect digest_block
mIQ2TKJPMyTfidQdo0Tp89KsCEo=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_TOGGLE_COV_BIT_VECTOR_SV
