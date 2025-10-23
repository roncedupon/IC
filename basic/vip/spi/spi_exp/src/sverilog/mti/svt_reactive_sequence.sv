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

`ifndef GUARD_SVT_REACTIVE_SEQUENCE_SV
 `define GUARD_SVT_REACTIVE_SEQUENCE_SV

`ifndef SVT_VMM_TECHNOLOGY

typedef class svt_reactive_sequence;

/** Determine which prototype the UVM start_item task has *
 * UVM 1.0ea was the first to use the new prototype */

`ifdef UVM_MAJOR_VERSION_1_0
 `ifndef UVM_FIX_REV_EA
  `define START_ITEM_SEQ item_or_seq
 `else
  `define START_ITEM_SEQ item
 `endif
`else
  `define START_ITEM_SEQ item
`endif

   
// =============================================================================
/**
 * Base class for all SVT reactive sequences. Because of the reactive nature of the
 * protocol, the direction of requests (REQ) and responses (RSP) is reversed from the
 * usual sequencer/driver flow.
 */
virtual class svt_reactive_sequence #(type REQ=`SVT_XVM(sequence_item),
                                      type RSP=REQ,
                                      type RSLT=RSP) extends svt_sequence#(RSP,RSLT);

  // ****************************************************************************
  // Public Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Protected Data Properties
  // ****************************************************************************

  // ****************************************************************************
  // Public Methods
  // ****************************************************************************

   /** Calls sequencer.wait_for_req() */
   extern task wait_for_req(output REQ req);

   /** Calls sequencer.send_rsp() */
   extern task send_rsp(input RSP rsp);

   /** Called by wait_for_req() just before returning. Includes a reference to the request instance. */
   extern virtual function void post_req(REQ req);

   /** Called by send_rsp() just before sending the response to the driver. Includes a reference to the response instance. */
   extern virtual function void pre_rsp(RSP rsp);

   /** Generate an error message if called. */
`ifdef SVT_UVM_TECHNOLOGY
   extern task start_item (uvm_sequence_item `START_ITEM_SEQ,
                           int set_priority = -1,
                           uvm_sequencer_base sequencer=null);
   
`endif
`ifdef SVT_OVM_TECHNOLOGY
   extern task start_item (ovm_sequence_item item,
                           int set_priority = -1);
`endif

   /** These functions exist so that we don't call super.* to avoid raising/dropping objections. */
   extern virtual task pre_start();
   extern virtual task pre_body();
   extern virtual task post_body();
   extern virtual task post_start();

   
  /** CONSTRUCTOR: Create a new SVT sequence object */
  extern function new (string name = "svt_reactive_sequence", string suite_spec = "");

  // =============================================================================

endclass
   
//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
hw/sBBUe/d19ytAuJXZ2BdYUBxkyAJwwT+IbO9L5V1cz1D4dX3XilQz/njB5cpX0
anTIJ40eXFddEE62Ga+qONVW1HB0Bo6QepNhm/hHJKKoYwcNMWvrUyVVgBNNx+FF
CPnFA5bLG3GO+maPYgs9kbv/TkVsY83seXq2mC7duzE=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3214      )
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
`pragma protect end_protected

`endif // !SVT_VMM_TECHNOLOGY
  
`endif // GUARD_SVT_REACTIVE_SEQUENCE_SV
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
dApyMEHtE/UiVmP5VYGA2abRAqe6J2VoYlPGXlqljP3A2TvBdfr7ZuN869e5WE35
Emg+ed2VGsxii3P+qfOt+p2IvKCazbrZvBZjRvnlD5dGcS252pNUbA0NtXuR/11y
eaeApvWyHMRGVrO2lEkGUBe3IaqSUEcsRXwkg4KmfX8=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 3297      )
mUKnXUkR01WsdBbtz9vzl2N9QpMUMhWB5r7fcgMPqQLySh49WMuXULAd/vuCA9Uc
eMv3JoJSN6JyW5F8Ax3UNvy6cBNXu3AUgdkbL5uKzhQx/Yb9ZIOah49BfhMdiocx
`pragma protect end_protected
