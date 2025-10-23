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
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
CbdRvzxD3jfC5Z/cxbFJZBhKF7BOyLrVEsY9Es0DYkoszjXkuR2XpN/PhnU6WHLx
DmyVezVx2mYAdbCRgxyPBBFxCQa8DDWXlQAHrX7jKdLNJwTC/KVZxJ7MmaNjeeCy
8yA80596THR0VrCus6KtVhGgM+UFLBdwR/4uuB5fuQk=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2152      )
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
`pragma protect end_protected

`endif // GUARD_SVT_TOGGLE_COV_BIT_VECTOR_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
GZmycRUjKhkgAlghpBWb/ynnzCWzts1VwJnfazEObJ1rf9hencZfCYtC1G9Uxxeh
bIl5puDDGEf6uPn1KByXKyiiTsRobD0dhZnEnhh2gf6O+5v8T5+bUtC6QuUKrYtp
2CnwwxYNIDrgNn7cQM3wEkqsHgSwNi8jEglLNk5RBV8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 2235      )
AIGJ4rWQD39Zswr9E7ehxbQqZrU8q5icNwaHu0jVpy+F5ZK/HBGKlA1uZHTHrJpO
ncnzO8U6IThJoT0N4iAa21UrCs0NsEGBfLjWu8A46SgatmVkBq/jCOL+5HTv+WFx
`pragma protect end_protected
