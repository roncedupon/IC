//=======================================================================
// COPYRIGHT (C) 2010-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_DYNAMIC_MS_SCENARIO_ELECTION_SV
`define GUARD_SVT_DYNAMIC_MS_SCENARIO_ELECTION_SV

// =============================================================================
/**
 * This class implements a multi-stream scenario election class which avoids
 * disabled scenarios. It is designed to be used with svt_dynamic_ms_scenario
 * instances.
 */
`ifdef SVT_PRE_VMM_11
class svt_dynamic_ms_scenario_election;
`else
class svt_dynamic_ms_scenario_election extends vmm_ms_scenario_election;
`endif

  // ****************************************************************************
  // Public Data
  // ****************************************************************************

  /**
   * Flags indicating whether the scenario_sets have been enabled/disabled, populated
   * in pre_randomize().
   */
  bit scenario_set_enabled[$];

  // ****************************************************************************
  // Constraints
  // ****************************************************************************

  /**
   * Constraint that causes select to be chosen randomly while insuring that
   * the selected scenario is enabled.
   */
  constraint random_next
  {
    foreach (scenario_set_enabled[scen_ix]) {
`ifndef SVT_PRE_VMM_11
      (scen_ix != select) ||
`endif
      (scenario_set_enabled[scen_ix] != 0);
    }
  }

  // ****************************************************************************
  // Methods
  // ****************************************************************************

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: In addition to constructing the objects, controls whether
   * the randomization relies on the VMM 'round_robin' constraint to choose
   * the next scenario, or if it simply picks a random next scenario.
   *
   * @param use_round_robin Indicates whether the next scenario should be chosen
   * via round_robin (1) or purely via randomization (0). Defaults to 1 since that
   * is the VMM default.
   */
  extern function new(bit use_round_robin = 1);

  // ---------------------------------------------------------------------------
  /** Setup scenario_set_enabled for use by randomization and post_randomize. */
  extern function void pre_randomize();

  // ---------------------------------------------------------------------------
  /** Watch out for disabled scenarios. Move forward to an enabled one. */
  extern function void post_randomize();

  // ---------------------------------------------------------------------------
endclass
  
// =============================================================================

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
EzsLp0BvU/0/rXHuUBJiTcgv4S6ECV5FXNlIcPx25F1qV5f1X/xAURj0TAAjxMzw
Krv7iNucrLzzwrH8E9v8y7KE55+a9fOsROFedUu8NmQ353zMIH1bB1XsttvBeQMO
HILzYX82dJrrnNjaZat0JwEz9Z2axcbBufOjJpoOWR4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3172      )
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
cINiUQvfk9Jo3vIJzdt4GQ==
`pragma protect end_protected

`endif // GUARD_SVT_DYNAMIC_MS_SCENARIO_ELECTION_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
BXfTSFv+SKZ+qm1M2/SumfP9X59j/uLZfEBdO4NFeKObG8UlB+mAaTKEKGvFbCEN
cVQ6rywp7xsKBqlFwYghkFCJ7P92H4rri8G4ec0Vk8gbcTwzp9IfPBvjwKAHicMA
rQUdeIycd1GVTAW7hs+iWxaefkHRL03aVXYmfpPn3q4=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3255      )
dc5fvY5g+6eTDDzQ0YUaGsX665QcjACkOChuSAshgIB8UctLBEDXDd42NX3iO8WL
+Qwh8MIgsglS2qFuMbcgxm234c/zGQbrjepe1U75aGDUzgjZgTvnEzS1MLhNmSlw
`pragma protect end_protected
