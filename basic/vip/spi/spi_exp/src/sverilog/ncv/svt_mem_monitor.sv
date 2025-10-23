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

`ifndef GUARD_SVT_MEM_MONITOR_SV
`define GUARD_SVT_MEM_MONITOR_SV

//typedef class svt_mem_monitor_callback;

// =============================================================================
/**
 * Class that provides the basic infrastructure common to all SVT MEM UVM/OVM monitors.
 */
virtual class svt_mem_monitor#(type REQ=svt_mem_transaction) extends svt_monitor#(REQ);

  //`svt_xvm_register_cb(svt_mem_monitor#(REQ), svt_mem_monitor_callback)

  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
/** @cond PRIVATE */
  /** Monitor Configuration */
  local svt_mem_configuration cfg = null;

 /** Monitor Configuration snapshot */
  protected svt_mem_configuration cfg_snapshot = null;

/** @endcond */

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new monitor instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name
   * 
   * @param parent Handle to the hierarchical parent
   * 
   * @param suite_name Identifies the product suite to which the monitor object belongs.
   */
  extern function new(string name, `SVT_XVM(component) parent, string suite_name="svt_mem_monitor");

  // ---------------------------------------------------------------------------

  // ---------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY
  /** UVM build phase */
  extern virtual function void build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  extern virtual function void build();
`endif

`ifdef SVT_UVM_TECHNOLOGY
  /** UVM run phase */
  extern virtual task run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  /** OVM run phase */
  extern virtual task run();
`endif

  //----------------------------------------------------------------------------
  /**
   * Updates the monitor's configuration with data from the supplied object.
   * This method always results in a call to change_dynamic_cfg(). If the monitor
   * has not been started calling this method also results in a call to
   * change_static_cfg().
   */
  extern virtual function void reconfigure(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Returns a copy of the monitor's configuration object, including the
   * current configuration settings. If cfg is null, creates configuration object
   * of appropriate type.
   */
  extern virtual function void get_cfg(ref svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the argument
   * into the configuration object stored in the monitor. Used internally
   * by reconfigure; not to be called directly.
   */
  extern virtual protected function void change_static_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the argument
   * into the configuration object stored in the monitor. Used internally
   * by reconfigure; not to be called directly.
   */
  extern virtual protected function void change_dynamic_cfg(svt_configuration cfg);

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>static</i> configuration properties from the configuration
   * object stored in the monitor into the argument. If cfg is null,
   * creates config object of appropriate type. Used internally by get_cfg;
   * not to be called directly.
   */
  virtual protected function void get_static_cfg(ref svt_configuration cfg);
`ifdef SVT_MULTI_SIM_EMPTY_METHOD_FLAGGED_AS_UNIMP
    int dummy = 0;
`endif
  endfunction : get_static_cfg

  //----------------------------------------------------------------------------
  /**
   * Copies (deep) the <i>dynamic</i> configuration properties from the configuration
   * object stored in the monitor into the argument. If cfg is null,
   * creates configuration object of appropriate type. Used internally by get_cfg;
   * not to be called directly.
   */
  virtual protected function void get_dynamic_cfg(ref svt_configuration cfg);
`ifdef SVT_MULTI_SIM_EMPTY_METHOD_FLAGGED_AS_UNIMP
    int dummy = 0;
`endif
  endfunction : get_dynamic_cfg

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
gkvxeufSh0MQVsogVdeqU0Pf3ijxNhI6upUDea/y+EObmCNqWMyZ7PBbLdJ5ERTv
lajj3wU4BAW53fJQ2m0t6DMCh7pfAbv4d2UZd5eMZXK3rywvwBa/nuJo8GrSp9Mx
FrNLx24macjvjAwtlfcJhikYgSKuMXO7/LUcpljuQ6e2kkvEXaoilA==
//pragma protect end_key_block
//pragma protect digest_block
fTTECGZ1xb5FNR5D4c6MatbnxSE=
//pragma protect end_digest_block
//pragma protect data_block
RItUsmPlT92pLvN/OAmDXxiBoemoCfIxVFGIB0YqDii4tMi+3V8vmAKePIRu+Lxx
4onyus750Tl1+bpeWKSnNBnYBkdG9REwBA22GJn/mJ/+BEz0Lz4vC83ParIa596K
F6MBD9SFx7QN/5UEdJWW+9QEtGvo/KC+07JPhXADIgDGZy32HxlaRg85dwHKEKVy
G76rmyujn/lMaElWW+BntER+aSXoK0TUol8yVgGMvJFTdHIrbhGO3DTyCXViNYb/
O44B++DskkUPSWSg8HPLjhFBu/bqNc+MiaRHG2XDHLcgapyLtnltq1UeYBJRDi4v
bCtw3PSG6Ivc3iQ9MQcLoTWGE5VXBgHv0IQTIxZy5iwt5D8My7Y0rysZtIIrM7oH
ev2QBiLhteITrX0gm5mcsQ==
//pragma protect end_data_block
//pragma protect digest_block
xGMA0pcWhif9fYaYTgPHW/5W2PI=
//pragma protect end_digest_block
//pragma protect end_protected

  // ---------------------------------------------------------------------------
endclass


// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Q/1uZfpwdAj4xbLFbELmWMlr6s8pE1TtV0MbvD1BZcuFSPPlCkrbzPpKZPAHkQTd
zaod7wljuhJREicEoCzmXxBIzi/y+v7cUAdWqieP+KtQ2f3auI9V9AWyuczfN4QI
SVWCcdW80LHJQ5a3Y3q65jCcLaf69LrjFAYx1TaOkLtxDWtQBNoOew==
//pragma protect end_key_block
//pragma protect digest_block
KXhADfUchJM6v0L0CY8HCmcms2c=
//pragma protect end_digest_block
//pragma protect data_block
nCSTHcICxKb8/EuDlzXgKjT1br09occ44doTK26CtM6Mmu+OTIHy97Mmsvdj+VDI
CnZuLibA6mOsYaVxepRB+DM19+fy+/mzCuUreqhpP0xC/fHBsrGHDUTz9OZqyAV+
i9GIqNxr1s+usEHTS6jRx8Fildk4sSyJRVtejiXmFvrQBcCvalj4Hm8dGfAdK2YV
iWX+g9kYbGxWoBVCN6i6PNL0GxTjuXceH/WB9v+iJfgADjAGrXFoufQIBWmpb6hS
aAHNQIneegvJKmnEEXnSXJrGW6IB5LvnleF3+BBHltkkCRWceglMh8nzTDaEcdSK
9ZyAaF+pLyoUlYIuuXrQfr5lO/1fLrSMdibjyyiNu9GOxrxXxmaA1PjNWDLo/TY3
pEf2MVMcY3xC6+itIJtpY4SD+icpcucpI8DwHkOCT9JYprqFkLtexLtcH4JX4KIy
lPLulhLsHUSlNWZtepFu7WHIawwT/1FWF6d1vRgHXRmBs1xkIiYaPPu2Z2c1KgZA
rqZ+VndIIRYe4354jl4Uu00fsQq/VrfX8W9jLdcInvNeK4EM1IF1CYw2WG3lQOQq
Ha87Bdfa+Y1R6OvWU+d58mf6HTNz1FUXkTQVOOAKkkSHFXu+wRsJFHer9VMfPWOJ

//pragma protect end_data_block
//pragma protect digest_block
h0iFbzXyGUcrULdEYZUrVQEuyp4=
//pragma protect end_digest_block
//pragma protect end_protected
// -----------------------------------------------------------------------------

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
AWHgx8oL1T0KTAQs3PYGwIkr8sxkn7Oi1KU2iOYnh2aDK2BmIm1gf66dXbxxL0Fr
3ZSIxJpOWzxqr7sqHRAMWqpUZLivkHYYQQX3Dy47QANQkrN853wHLB4IB6mDTiNU
2hjzYPcuh7PVaGbw5K2H2ImW7dDsjEMjTw3CSIqaJ3I0wIQOpREaiA==
//pragma protect end_key_block
//pragma protect digest_block
KheBnuIeYcQvHN4YY9RyhEM+q4o=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
C8barynEkVtZXZ18nfp0imJJz58=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_MEM_MONITOR_SV
