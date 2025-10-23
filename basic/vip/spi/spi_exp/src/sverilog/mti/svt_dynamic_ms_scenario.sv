//=======================================================================
// COPYRIGHT (C) 2007-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_DYNAMIC_MS_SCENARIO_SV
`define GUARD_SVT_DYNAMIC_MS_SCENARIO_SV

// =============================================================================
/**
 * This class defines a set of basic capabilities which can be used to implement
 * simple scenarios for distinct transaction types which can be enabled, disabled,
 * and in general controlled dynamically.
 */
`ifdef SVT_PRE_VMM_11
virtual class svt_dynamic_ms_scenario;
`else
virtual class svt_dynamic_ms_scenario extends vmm_ms_scenario;
`endif

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new dynamic multi-stream scenario.
   */
`ifdef SVT_PRE_VMM_11
  extern function new();
`else
  extern function new(`VMM_SCENARIO parent = null);
`endif

  // ---------------------------------------------------------------------------
  /**
   * Function used to check whether the scenario is supported in the current
   * situation. This may be based on the configuration, the status, or even
   * possibly just an enabled/disabled bit. Weights, etc., to enable/disable
   * randomization must be modified within this call.
   *
   * @return Indicates whether the scenario is enabled (1) or disabled (0).
   */
  virtual function bit adjust_weights_per_cfg();
    adjust_weights_per_cfg = 0;
  endfunction

  // ---------------------------------------------------------------------------
endclass
  
// =============================================================================

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
j8KOMtuz81cEWLSMlN50O9mnwhg3MU3rZHUTGOzLMpQhdmAgSnmPqZlwYBeNRR5y
KUrEh9WrsdF3PnUNzvMBHpRD3Mp2XBTCLtD6Bw+7s28DiEb24csj56/rJE85s0F1
XChGGawp/rT8K7QT6fAbDI5dKbsj0LAteojaMUQL91w=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 480       )
kp5QW1LVowCwekmKErmK8gCWgB1A7fOrzxCEjZJNpUEV1Fm6g0V3F9NAZnTcrL7s
DzAVwSg0i15f5kQOepEQ6MzOyBmK5DZj6o4Sf8ybF7S3QzxXcPuP2Jr4Ye2phrFJ
U1SzCgWSIEvEvd7upg1qyWXWB2LSkErW2uTQa4KoGtpa8+SsLKqk2PlU+akIC77x
onKqyXoey8Yo6miSqEbvuMi01PtlUYHS9q+5Tk6oGgSypm9vVJHuCm6yhLA87nwa
SNJx5ryMCqk4EraKWb54g1+7TgrfC4dsxX70y11WnEHnmh2Nb0XdYDylbrG9UI2b
qg/6fHL9zLal11pFuwP9x+4tXiOYHZ8fnhdiRKUzlvdzQvY99eRyoQ15sTnaZ22q
F96vPWrFEW2YGvWTE7l5jhzGq5mHswT1DJef+0YAgB+7O16y9jaK+/xJQfJ8vkdG
88ZUP6P/RgQq8h7zb3ZUoClErigLtrpjSU7IiNkxRGH3MLcM7VvSdsTfq3TyT2yr
suScZeVffyIBeXk5/pFakRT28+Ptg5MewRbUPJimc5Rs5LKRYoYHK5GC3w6avSxn
cnQ5PJTXncrsXNn1aFwq//A0j8bdn67SD9A1z2rtRnI6mT+Vkg1J2YkqWnCbmwVl
FDsLOf4R2QJf6/APyqM14Q==
`pragma protect end_protected

`endif // GUARD_SVT_DYNAMIC_MS_SCENARIO_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
JIjcmz4Lqhe7GJXcrXm1zg5yFWbnZjjix427rsRq7d5MEaQiaEJyA2KvzD9Q/Ov/
T1yxqlqPM5+ZTrNJKi1KROdS+XFenZzWFZOK9A4IdkFb36wWMrtkP5yMbADcmSHz
2yHf4O3hnAAFtrVTypR0enadTZSHQ3ZtaflLJQGvPj8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 563       )
n5oHZp/MrSI0CgXZfhEZ71OwhIxT6K0ukOuMEKgMxLwc1UImpVQld7I0imcvVLLe
smceVp6XZiL1OcF3DPUWnieu8JJzyGcQQsqFNLYMnKm4R+ZjDP/zp6x0enw9o+yZ
`pragma protect end_protected
