//=======================================================================
// COPYRIGHT (C) 2012-2017 SYNOPSYS INC.
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

`ifndef GUARD_SVT_REACTIVE_SEQUENCER_SV
`define GUARD_SVT_REACTIVE_SEQUENCER_SV

/** Determine if set_item_context is implemented in ths version of OVM/UVM */
// // 1.1b
// `define UVM_MAJOR_VERSION_1_1
// `define UVM_FIX_VERSION_1_1_b
// `define UVM_MAJOR_REV_1
// `define UVM_MINOR_REV_1
// `define UVM_FIX_REV_b

/* We are using OVM so we must use the workaround. */
`ifdef SVT_OVM_TECHNOLOGY
 `define USE_SET_ITEM_CONTEXT_WORKAROUND
`endif

/* We are using any version 0 */
`ifdef UVM_MAJOR_REV_0
 `define USE_SET_ITEM_CONTEXT_WORKAROUND
`endif

/* We are using any version 1. */
`ifdef UVM_MAJOR_REV_1
/* version 1.0 */
 `ifdef UVM_MINOR_REV_0
  `define USE_SET_ITEM_CONTEXT_WORKAROUND
/* version 1.1 */
 `elsif UVM_MINOR_REV_1
/* version 1.1, no fix, so it's the very first release */
  `ifndef UVM_FIX_REV
   `define USE_SET_ITEM_CONTEXT_WORKAROUND
  `endif
/* Version 1.1a does not have a specific define called UVM_FIX_REV_a, so there is no way to distinguish it. *
 Therefore we need to just look for the subsequent UVM_FIX_REV_b/c/d/.... */
  `ifndef UVM_FIX_REV_b
   `ifndef UVM_FIX_REV_c
    `ifndef UVM_FIX_REV_d
     `ifndef UVM_FIX_REV_e
      `ifndef UVM_FIX_REV_f
       `define USE_SET_ITEM_CONTEXT_WORKAROUND
      `endif
     `endif
    `endif
   `endif
  `endif
 `endif
`endif


// =============================================================================
/**
 * Base class for all SVT reactive sequencers. Because of the reactive nature of the
 * protocol, the direction of requests (REQ) and responses (RSP) is reversed from the
 * usual sequencer/driver flow.
 */
`ifdef SVT_VMM_TECHNOLOGY
virtual class svt_reactive_sequencer#(type REQ=svt_data,
                                      type RSP=REQ,
                                      type RSLT=RSP) extends svt_xactor;
`else
virtual class svt_reactive_sequencer#(type REQ=`SVT_XVM(sequence_item),
                                      type RSP=REQ,
                                      type RSLT=RSP) extends svt_sequencer#(RSP, RSLT);
`endif
  // ****************************************************************************
  // Enumerated Types
  // ****************************************************************************

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

`ifdef SVT_VMM_TECHNOLOGY
  /** Request channel, transporting REQ-type instances. */
  vmm_channel_typed #(REQ) req_chan;
   
  /** Response channel, transporting RSP-type instances. */
  vmm_channel_typed #(RSP) rsp_chan;
`else

  /** Blocking get port, transporting REQ-type instances. It is named with the _export suffix to match the seq_item_export inherited from the base class. */
  `SVT_XVM(blocking_get_port) #(REQ) req_item_export;
   
  /** Analysis port that published RSP instances. */
  svt_debug_opts_analysis_port#(RSP) rsp_ap;
`endif
   
  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************
  bit wait_for_req_called = 0;

`ifdef SVT_VMM_TECHNOLOGY
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new sequencer instance, passing the appropriate argument
   * values to the `SVT_XVM(sequencer) parent class.
   *
   * @param name Class name
   * 
   * @param inst Instance name
   * 
   * @param cfg Configuration descriptor
   * 
   * @param suite_name Identifies the product suite to which the sequencer object belongs.
   */
  extern function new(string name,
                      string inst,
                      svt_configuration cfg,
                      vmm_object parent,
                      string suite_name);
`else
  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new sequencer instance, passing the appropriate argument
   * values to the `SVT_XVM(sequencer) parent class.
   *
   * @param name Instance name
   * 
   * @param parent Handle to the hierarchical parent
   * 
   * @param suite_name Identifies the product suite to which the sequencer object belongs.
   */
  extern function new(string name, `SVT_XVM(component) parent, string suite_name);
`endif

`ifndef SVT_VMM_TECHNOLOGY

   /** Generate an error if called. */
   extern task execute_item(`SVT_XVM(sequence_item) item);
   
   /** Wait for a request from the reactive driver. Returns a REQ instance. */
   extern task wait_for_req(output REQ req, input `SVT_XVM(sequence_base) seq);
   
   /** Send the response to the driver using a RSP instance. */
   extern task send_rsp(input RSP rsp, input `SVT_XVM(sequence_base) seq);
`else

   /** Wait for a request from the reactive driver. Returns a REQ instance. */
   extern task wait_for_req(output REQ req);

   /** Send the response to the driver using a RSP instance. */
   extern task send_rsp(input RSP rsp);

   /** Continusously wait for requests, calls fulfill_request()
    * then forward the response back to the reactive driver */
   extern virtual task main();

   /** Fulfill a request and returns an appropriate response.
    * This method MUST be implemented in derived classes
    * and must not be called via super.fulfill_request(). */
   extern virtual local task fulfill_request(input REQ req,
                                             output RSP rsp);
   
`endif
   
   
`ifdef USE_SET_ITEM_CONTEXT_WORKAROUND
  extern function void reactive_sequencer_set_item_context(`SVT_XVM(sequence_item) seq,
                                                           `SVT_XVM(sequence_base) parent_seq,
                                                           `SVT_XVM(sequencer_base) sequencer = null);
`endif
   
endclass

// =============================================================================

//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
X6FXmwZ9qsZf7yqBbnSdBfbNuzSmCIDwNTb/CJQ4wSHzgzzYZ5aWOQsfEWs4lWgy
ZBQhURujwiRY3NwnYmumYTYh2lmjXsSu959ZAk9HYBT/ENtsDGijwVNxqPyPYNM/
WfSTHb8N1zWhlwiNineAlqOgTxAWA5H19g/oR/Hq7hm+2PZKlRZ1EQ==
//pragma protect end_key_block
//pragma protect digest_block
jXqoi5u74kxDinK/g4vJLR0XtWI=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
92YQiL7xoYgu4+bNtKwLipBHSqM=
//pragma protect end_digest_block
//pragma protect end_protected

//svt_vcs_lic_vip_protect
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
Q5Z9GO/75GhSZYLp4kCl/vChPkva/L9ARbKqdTAoYmnHPJTJoVpuf67jZQDkLSce
gxx3pdOAbpJvneYQ4CFW5UiGEwH0DqLF1HirZ3cA2TL30OGE7VmHmkkJeqw9uYLN
si2WMB6hRon0auN1P/Kf1xeaXu/G5jdstjborX9+Mz2Q2P894cS+nQ==
//pragma protect end_key_block
//pragma protect digest_block
hJ2oZ5hHdi702kvxyTQnUrgCPKg=
//pragma protect end_digest_block
//pragma protect data_block
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

//pragma protect end_data_block
//pragma protect digest_block
b1ydigxkuVL82MPmQFpzqqSw7U4=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_REACTIVE_SEQUENCER_SV
