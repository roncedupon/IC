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
 * Class cust_svt_axi_system_configuration is used to encapsulate all the 
 * configuration information.  It extends the system configuration and 
 * set the appropriate fields like number of masters/slaves, create 
 * master/slave configurations etc..., which are required by System agent.
 */

`ifndef GUARD_CUST_SVT_AXI_SYSTEM_CONFIGURATION_SV
`define GUARD_CUST_SVT_AXI_SYSTEM_CONFIGURATION_SV


class cust_svt_axi_system_configuration extends svt_axi_system_configuration;

  /** UVM Object Utility macro */
  `uvm_object_utils (cust_svt_axi_system_configuration)

  /** Class Constructor */
  function new (string name = "cust_svt_axi_system_configuration");

    super.new(name);

    /** Assign the necessary configuration parameters. This example uses single
      * master and single slave configuration.
      */
    this.num_masters = 1;
    this.num_slaves  = 1;

    /** Create port configurations */
    this.create_sub_cfgs(1,1);
    this.master_cfg[0].axi_interface_type = svt_axi_port_configuration::AXI4_STREAM;
    this.slave_cfg[0].axi_interface_type = svt_axi_port_configuration::AXI4_STREAM;
    this.slave_cfg[0].default_tready = $urandom_range(1,0);
    master_cfg[0].tdata_width = 48;
    master_cfg[0].tdest_width = 3;
    master_cfg[0].tuser_width = 8;
    master_cfg[0].is_active = 1;
    slave_cfg[0].is_active = 1;
    slave_cfg[0].tdata_width = 48;
    slave_cfg[0].tdest_width = 3;
    slave_cfg[0].tuser_width = 8;
  endfunction

endclass
`endif //GUARD_CUST_SVT_AXI_SYSTEM_CONFIGURATION_SV
