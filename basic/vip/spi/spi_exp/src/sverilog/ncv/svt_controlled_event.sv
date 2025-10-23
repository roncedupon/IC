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
//pragma protect begin_protected
//pragma protect key_keyowner=Cadence Design Systems.
//pragma protect key_keyname=CDS_KEY
//pragma protect key_method=RC5
//pragma protect key_block
zXFXQbKdofn/VELUuAEXCZDf9qIuW4AnwmLirQWCqpQ+dI1a1OLtVnmEpLVIfyjB
NTuX74hBX5XWzXEj3VEYI6ILVqvHrwhScpsOUmHPer7byo21VzFNFfbSa3z+sq1a
NS1nViPXf3sNmnlcKUcEx7Yv93iKFH1z5KLwpgF2Cl12jObAxbvRNA==
//pragma protect end_key_block
//pragma protect digest_block
MU7/C2UVGxzcIkmieJ9QFcc6X1I=
//pragma protect end_digest_block
//pragma protect data_block
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
//pragma protect end_data_block
//pragma protect digest_block
CmISu2EhuIo+DVh8d42BsSxupZw=
//pragma protect end_digest_block
//pragma protect end_protected

`endif // GUARD_SVT_CONTROLLED_EVENT_SV

