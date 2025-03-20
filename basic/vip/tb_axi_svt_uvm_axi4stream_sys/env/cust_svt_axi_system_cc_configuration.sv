//=======================================================================
// COPYRIGHT (C) 2010, 2011, 2012, 2013 SYNOPSYS INC.
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

/**
 * Abstract:
 * Class cust_svt_axi_system_cc_configuration is used to encapsulate all the 
 * configuration information.  It extends the system configuration and 
 * set the appropriate fields like number of masters/slaves, create 
 * master/slave configurations etc..., which are required by System agent.
 */

`ifndef GUARD_CUST_SVT_AXI_SYSTEM_CC_CONFIGURATION_SV
`define GUARD_CUST_SVT_AXI_SYSTEM_CC_CONFIGURATION_SV


class cust_svt_axi_system_cc_configuration extends svt_axi_system_configuration;

  /** UVM Object Utility macro */
  `uvm_object_utils (cust_svt_axi_system_cc_configuration)

  /** Class Constructor */
  function new (string name = "cust_svt_axi_system_cc_configuration");

    super.new(name);

  endfunction

endclass
`endif //GUARD_CUST_SVT_AXI_SYSTEM_CC_CONFIGURATION_SV
