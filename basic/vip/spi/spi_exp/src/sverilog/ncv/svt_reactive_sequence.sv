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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
zPCjvaw67aaYzGsS4qPPcq6mbH2VwFeRqII4/d8voWs0msBmSL53D+bZ9aKIyGk5
leBarHGV/wc0+SVUbETQpS12COsFi4QZMDqOJrHncXwpQP/S2exPjKzISeyUil6Y
yoNPZ7GHZwNvEheU+gAYmMl0e4kyFfsXvKYMXpfhcstdC++iKslBHg==
//pragma protect end_key_block
//pragma protect digest_block
ou4mZ0s1jq7B1kngX89e8w/zv18=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
pYVHXPERRqVeW3mOv8rJBX+c4hk=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // !SVT_VMM_TECHNOLOGY
  
`endif // GUARD_SVT_REACTIVE_SEQUENCE_SV
