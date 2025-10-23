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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
8ko/JpulcPfRzbbZO/UOtZbN4WKQeKbERB7G7ECVB7bK6s86692tOvc2TQM87gm3
DRZuUXYiw2W214GWs/dOgF3IG+2B3GvFNg7t/gdyPgfTNxEwdehRjl8hdI9gyQyS
0sSDSCSXcZOnRTcCNocdB6wyhqZTV+ilQcYa9NmTI2Ma4zPItf7KIw==
//pragma protect end_key_block
//pragma protect digest_block
oeVEcGlYE+NTIfHc96xXkSQAD+o=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
D2MP3exXFdcDIAuWpIW7iXRrTXc=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_DYNAMIC_MS_SCENARIO_ELECTION_SV
