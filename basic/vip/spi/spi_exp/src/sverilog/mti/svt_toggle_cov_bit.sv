//=======================================================================
// COPYRIGHT (C) 2011-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_TOGGLE_COV_BIT_SV
`define GUARD_SVT_TOGGLE_COV_BIT_SV

/** @cond SV_ONLY */
// =============================================================================
/**
 * Single bit coverage variable used to support coverage of individual or
 * bused signals.
 */
class svt_toggle_cov_bit;

  // ****************************************************************************
  // Protected Data
  // ****************************************************************************

  /** The value being covered */
  protected bit bit_val;

  // ****************************************************************************
  // Coverage Groups
  // ****************************************************************************

  covergroup toggle_cov_bit;
    option.per_instance = 1;
    option.goal = 100;
    coverpoint bit_val {
      bins b0_to_b1 = (0 => 1);
      bins b1_to_b0 = (1 => 0);
    }
  endgroup

  // ---------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Creates a new instance of the svt_toggle_cov_bit class.
   */
  extern function new();

  //----------------------------------------------------------------------------
  /**
   * Provide a new bit_val to be recognized and sampled.
   */
  extern function void bit_cov(bit bit_val);

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
bzrQgxJsG2UMHMcdwA+EKBO/azAcP9uMRhTWsrE1miz0b7v2bzlRTgGtpK59NgnJ
Lex279yYrL69NpJsYMbFpQG+WJ0/IKxEv/wATNuK1+6zHUspTEpw7SNl+F1qAxZx
zArDDUFr3LRfAZnA9yRHcx7n9Hlp4NZg7rN82ZUcsn8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 682       )
fnC5eISiOYTo0PvJaPTuOKYerIC+lPWj4lCqtV97UHY+g3ndxd2TU4eew5h/OaHl
HlsO8HAe7d9fE/uCHPJMLXC8xfVC1OjHL/yAkwr7ElpPeZTzi55GhECpQgjfz23W
lhVMmxEd7NJrIYCZs69JcJ27Xd3bO84Xs+wr9NoU+KUyr/++farMKaPF1pMlJdZs
AHQ9zzHqWc+Bs13oHbQyti1naHYaUZUqPKo+JBq9CLpYeIahGMbqEVXxvmoWob4O
bm3J6Keh04DFOznWVLNXGdGchknoQn+iTrRVTj9vtUp+hY+dw4F3fPrjswDwie/Z
gb22hmqBtqYAeHrVTOospmDg3Kt8fSsknOkgb7pmJVEG/xXDVv1/5L/O5a6cEP6t
0EKmExU9vQCPxUPaO5DoTBcHhXJTizTGcNK9MNAp5Tc5DFldpitHQbdIZsqv9pdZ
Yuw5r7J+fhkgNQwoNzw6C9bg5TiR98hYtLz6wL0NPRGrPS6gtkPjw7bByOJWApRc
xShVwvfK6/ZWeaJH0aHJEOPK9Sabc5wOdUEzSgr5dQX9E3Oh/EWN0aHb/InDjnRO
jJNzFVQaitpyxbqzamnEcsO/BPbjUW2uY2nvOVzi7kqgqHjREB877DtnO83bdP1j
cK6QkdFkMsfzToDRd1/IK4NSFEMGh58F9jrHOuj4H16XdGoztqgwpzi64BJp0oHB
9YIOqqVd3JX0mFZuChP2JDXS4yu6WfhnNlJ0VBh4QCeEpj9qrooV4fmGs5xUAAcz
F4xb6685XX9PrO3/zmuH8VpnLJbsudCucWE7G7tQKTcc5JPyCH4ViwSM/JxHAn02
rCCK+6eH7uN7JDxJnaoI9XLWnm9Oq73AaZPFy/4ZVGYCZIkLmOJBLTCdDX1DxjSk
CQ6avy2kTWpD30Xb4WPn8A==
`pragma protect end_protected

`endif // GUARD_SVT_TOGGLE_COV_BIT_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
OLunsH+3zyH09Qv8+4XUF+DuaJGxlTaGTbae44SMO48n8koe74SH3S2MHPYjAOW/
LCa0SSSHyN+tY7aFTk8Ok52zlvKr1HI0HjuwyAcNvX5mbsKlXq47kwABdMvcCIqe
BMia/Lwic/SLkC6S7lcj17dDCu6uARBerXTMs95dMks=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 765       )
gk07MkYIZFvnk+zM8I1gSltBg1zLIkHDjtu+qxTCduDs5vf1hIohRddB+ITBBsyu
pfJW1WqQDdiv9887/Cm3OPuQSG/+ouWWzTQi/gwavT1MVi6P0O346/1UpCgUkKvh
`pragma protect end_protected
