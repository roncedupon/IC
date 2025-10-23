//=======================================================================
// COPYRIGHT (C) 2015-2016 SYNOPSYS INC.
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

`ifndef GUARD_SVT_DEBUG_VIP_DESCRIPTOR_SV
`define GUARD_SVT_DEBUG_VIP_DESCRIPTOR_SV

`include `SVT_SOURCE_MAP_LIB_SRC_SVI(R-2020.12,svt_data_util)

typedef class svt_vip_writer;

// ---------------------------------------------------------------------------
/**
 * Data object to save debug information for each SVT VIP in the simulation
 */
class svt_debug_vip_descriptor;

  // ****************************************************************************
  // GeneralTypes
  // ****************************************************************************

  /**
   * Struct to represent debug properties that have been enabled through the auto-debug
   * infrastructure.
   */
  typedef struct {
    string prop_name;
    bit [1023:0] prop_val;
    bit status;
  } debug_prop_struct;

  /**
   * Flag that indicates that the lookups have already been performed and so the
   * values can be trusted.
   */
  bit is_cached;

  /** Flag that determines whether this VIP was enabled for debug */
  bit enable_debug;

  /** Flag that determines whether this component is a top level component */
  bit is_top_level_component;

  /** Reference to the VIP writer for this instance */
  svt_vip_writer writer;

  /**
   * Instance name of the parent component.  This property only gets set if the parent
   * component is enabled for debug (meaning that this sub-component is enabled for
   * debug through its parent, so it does not need to set anything up).
   */
  string parent_component = `SVT_DATA_UTIL_UNSPECIFIED;

  /** Storage queue to contain each debug property */
  debug_prop_struct debug_prop[$];

  // ---------------------------------------------------------------------------
  /**
   * Stores the debug feature that is enabled through the auto-debug utility
   */
  extern function void record_debug_property(bit status, string prop_name, bit [1023:0] prop_val);

endclass: svt_debug_vip_descriptor

// ---------------------------------------------------------------------------
function void svt_debug_vip_descriptor::record_debug_property(bit status, string prop_name, bit [1023:0] prop_val);
  debug_prop_struct prop;
  prop.prop_name = prop_name;
  prop.prop_val = prop_val;
  prop.status = status;
  debug_prop.push_back(prop);
endfunction

`endif // GUARD_SVT_DEBUG_VIP_DESCRIPTOR_SV
