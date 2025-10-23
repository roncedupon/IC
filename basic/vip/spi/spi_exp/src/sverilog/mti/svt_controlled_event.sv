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

`ifndef GUARD_SVT_CONTROLLED_EVENT_SV
`define GUARD_SVT_CONTROLLED_EVENT_SV

typedef class svt_non_abstract_report_object;

// =============================================================================
/**
 * Extended event class that allows an event to be designed to be automatically
 * triggered based on external conditions.  This class must be paired with a
 * helper class named svt_event_controller.
 */
class svt_controlled_event extends `SVT_XVM(event);

/** @cond PRIVATE */

  local svt_event_controller controller;

/** @endcond */

  //----------------------------------------------------------------------------
  /**
   * CONSTRUCTOR: Create a new monitor instance, passing the appropriate argument
   * values to the parent class.
   *
   * @param name Instance name
   */
  extern function new(string name="", svt_event_controller controller=null);

  /** uvm_event method that is used to trigger the suite specific trigger */
  extern virtual task wait_on(bit delta=0);

  /** uvm_event method that is used to trigger the suite specific trigger */
  extern virtual task wait_off (bit delta=0);

  /** uvm_event method that is used to trigger the suite specific trigger */
  extern virtual task wait_trigger();

  /** uvm_event method that is used to trigger the suite specific trigger */
  extern virtual task wait_ptrigger();

/** @cond PRIVATE */

  /**
   * Method to implement a conditional check to ensure that the suite specific logic
   * which is used to trigger the event is only initiated once.
   */
  extern local function void activate_controller_condition();

/** @endcond */

endclass

// =============================================================================

//svt_vcs_lic_vip_protect
`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
BqJiHyQwixtzKa4Js9N0JDWIcceDv8/9dQtnoNkyRgJZlpZk7eiI6qeIHHPYQP9Q
6Av01cnlZ3mV1QzGkAhiBv71ReAVkuvO/epqWdeOI22kg3c7cFP74gYztoXgBo6I
UgRSvyEtdNaQlqXBi0dNWCe0RCZphLOUJd9Lzxhtz34=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1880      )
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
DIlFlucacnUpEtzk1B9D5A==
`pragma protect end_protected

`endif // GUARD_SVT_CONTROLLED_EVENT_SV

`pragma protect begin_protected
`pragma protect encrypt_agent = "Model Technology", encrypt_agent_info = "6.5b"
`pragma protect data_method = "aes128-cbc"
`pragma protect key_keyowner = "Mentor Graphics Corporation" , key_keyname = "MGC-VERIF-SIM-RSA-1" , key_method = "rsa"
`pragma protect key_block encoding = (enctype = "base64")
NO4JJ5yLyvHIZvYaQuegPxoYHB9LS/F0IF2uz/fVwegswPFZVwaiimtOclLp72AY
wlTywWJOcOi1pc2lryVa6NvN55cgKsfk364cI0aD9IO5Dmq87qgBvsuEy+mfSPwM
ddNAkjhwwyf2uzqyo/WFyUZgIahruv0Qrd50I290tgA=
`pragma protect data_block encoding = ( enctype = "base64", bytes = 1963      )
tb1n3NLk6n7yHQ2pucWW0AhtiErqiGz4m6pOJPHM4M6dUivI9qY/fUJLneq2O3a5
qg62oMvCRlHury4CYCu3ufjOTeViQSrLbKpPaLVJPr0vwJbJzI9AfNx1JJrAVRGP
`pragma protect end_protected
