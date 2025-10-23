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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
wPt4smMd9f5NcdBIEkPCb0aFR3RF+4YL38zzdQIYQ+Lm6izbuNiWYQkGFhQ0F/Hi
emrUko5A4PUJNVs/ngwV/FCUAXs6oWHtd7/RrNHDMTmDmLAh0UDk1OomUQPSPjRM
M/mJThrUZL5SLof0n+P/l63KJPdB3m3PVYTAezM6YOACGgGnzch2ZA==
//pragma protect end_key_block
//pragma protect digest_block
5R/WNhCeRxe8RjmZWIgT7q13FBI=
//pragma protect end_digest_block
//pragma protect data_block
0I9Sh5hCva5I8MD3jA2QtGglBu2hI2rVyaAQd7bMHVuhZZHx/iskRZdY7tbOIgPC
bELxopz2nDT0zbKnU3RRTTpwqxavhO7wk8d4vq6k6KGjV4lO4KqQPN/hBgpRYjRJ
5WoA/Iieu/eYnUann2xOsA08uk3pOOLO/oyvY+6Px60hbjsNjgu55QS2clW/4449
r4/antB7Pxi+iMrgfdK3WPybr8Z9fN1PPx6IAgTFll+mkw475afHYScG+wqzJzuk
VlFDRYMFiOP/O7c/tCiGpzQsOFNVj1aa6nJ4eIJg233ZFB0ogEZzqq+gpeaD3UlK
a7rNvOGXjq2c4e9hOAglaVn7O6YzNrMndnzLiLbf3Fz63/Ald5mAndDJR5W1/L6V
Ba7a4+TpwK/nl+PptCx8EN1zLN1wswSCvJmubZ6IyzuuwQ1wvKcMjJSUWLEI4Hu4
R9SZvnbOOj4H3Nfy6A75yro06FD+TXdIIWhqnnC6q5854NV5xlR3XQMc0V9l8c44
GU5A0/Oun2AIu6olVIRPNWINRcdIxQTylpLK9Y1vW5XweA0+wrf5NotE0HElxb7R
WkOLus0xzXsmE2TyfkWRl3rj9tuafJdvDLK5GlBMIlTu7TwOiQect6ZfRGZni8NU
h1KmibJw6aiSjC15cheKty/6giolo2geAwzMRkZccZGsLsBOtwUPAYYM/7//0jlm
iD7MkKcFjQSfCilcWAjQih6ws1XJRX36WkHhbiuiPCmGv0aCW22/ovbRNDrO5Z5L
lS6gUV+zZA4bjcB9yxi6onU4S3dipN59kJdzZhAJHAhJpWM6gbqX0kDQwwdsKJZk
9wFJQHn1ZX8kOjne0t5IUC1+b0+hoLI+Bp74dDGKJeY=
//pragma protect end_data_block
//pragma protect digest_block
sV8FHrQkFChq4KZh9/0Zl7YrVZ8=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_DYNAMIC_MS_SCENARIO_SV
