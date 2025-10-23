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
`protected
FX3O-DcU<1JR@J3-0faa5g]ggZ4W-X[V130K]=aXIVdE5[<ZY[7d5(FERCC>^;B3
gMK_)Od#aBI=Q<)_(:BC7CRKVM1ML@7)8OCHAf(E==Z6e=FW^IX)5(\2+gcUISSO
P\]077H44c=(4B\D[aES.&\]YBZKY<\#P8P+#QB^(^V;Y8]77GYK7=gX<VK58XI/
AVbe2c+W=KK1]]29DNJUV(;>fE&KbHX(-/.?\_^:g&VIZ4+NTEKW=R;XX2TcdW)g
;U_VcGTSSHeUPOG@fE,FQ-,<<=4J(QY(b@8>MTGTGN0;B<c#G^@E0<aA1Y-41W<D
\MV@;QW,Q4:14\<C@ZT-WTK4:Kf-8JMe=gD](#dGMO\75AR+aXWbFY^A_L2c&.ON
+eOf2]EbOYYNc?_e(Y]N?RZ]=Ua-9HbGH;e<AdT\8:EU>LeJ;Z&BPcPf<V#OX,F4
5]>NN2W??:9]>GE)L\c1C8K^R5#:OdMJacCc-gJZ?0UZ#E6JU37]9\JO\G#c<S\T
H3f;HL=)X-(IO1^RJ0(K2)R-:]e3#<A)YN(\OHXJaJf8S,ZKfHP[GCXId,9V]5,g
5O=;MLJga8O@AB3a]Qe1RFR-6$
`endprotected


`endif // GUARD_SVT_DYNAMIC_MS_SCENARIO_SV
