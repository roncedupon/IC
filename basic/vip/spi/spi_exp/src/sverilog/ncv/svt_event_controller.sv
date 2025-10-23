//=======================================================================
// COPYRIGHT (C) 2012 SYNOPSYS INC.
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

`ifndef GUARD_SVT_EVENT_CONTROLLER_SV
`define GUARD_SVT_EVENT_CONTROLLER_SV

/** @cond PRIVATE */

// =============================================================================
/**
 * Event controller class which is meant to be paired with svt_controlled_event.
 */
virtual class svt_event_controller;

  /** Flag that indicates whether this condition is already being watched */
  local bit active;

  virtual task wait_for_condition(ref `SVT_XVM(object) data);
  endtask

  /** Test function that indicates whether this condition is already being watched */
  function bit is_active();
    return active;
  endfunction

  function void clear_active();
    active = 0;
  endfunction

endclass

/** @endcond */

`endif // GUARD_SVT_EVENT_CONTROLLER_SV
