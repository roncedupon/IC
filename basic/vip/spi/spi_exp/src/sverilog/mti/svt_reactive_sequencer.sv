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

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
Ewqwg7heumM7KQ3DEKtbxERVQnBp4HWjuzDiKamw3qlneFtZpZAeiRmjN1LK0HZO
SihXTgwhbGyh9Ehbs5hS9DD+qfi0u6I5/2qMKAhcBn5nZPGJijzFisTh0W+6sWXh
a3r6MOBXoqk1DbVPhv5UxdDgHXcP5POFWBkoi7tNYvU=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1883      )
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
dHILHbxvARTelRfd/j10/w==
`pragma protect end_protected

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
RMcDLwhHLyT79kSuZJ6Yks4FOBNdFudTIi9Y6R5ehSEirRAYf5Zglt5JgDD1nd6x
QzIoKBG6KDvSDEpjEocoYacY/ggC1R91HF7XO9qYXl82TG0xkTvEqEDYhCyCqKpm
+4imcK2vA+zIQGMii1SCbg1jv4X11hnWOfOvB8gyHng=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5023      )
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
`pragma protect end_protected

`endif // GUARD_SVT_REACTIVE_SEQUENCER_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
IunOE84rCpm83xuG82troTEAjRkPJTp2RnGrwWw1JxbrrrUT9MOjhyiT32ttSE7E
XyTE5+y3RqCMK0czL6HSjjwxCwH2Bq8mw/Nd2JfUl3lWR9CCMHOA7Ao1JWdYTYpw
Fs/lF5bY2WjRqEepE0a7Q2pjGHBBiw5YHWYcwqeXYWs=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 5106      )
aAyxpe6VMGQW4XBLdzbHlmNc4ibiJP7YFZHXqV03GrsAn8Iqbhmp4mBZtLurl9c0
fvUDXQ1dL1/pvO47/gRbg2XOaTACUrvObtP7xoWNgLSMVT0XVUlZ4otG9XyLHwE9
`pragma protect end_protected
