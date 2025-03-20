
/**
 * Abstract:
 * Class cust_svt_ahb_system_configuration is used to encapsulate all the 
 * configuration information.  It extends the system configuration and 
 * set the appropriate fields like number of masters/slaves, create 
 * master/slave configurations etc..., which are required by System agent.
 */

`ifndef GUARD_CUST_SVT_AHB_SYSTEM_CONFIGURATION_SV
`define GUARD_CUST_SVT_AHB_SYSTEM_CONFIGURATION_SV


class cust_svt_ahb_system_configuration extends svt_ahb_system_configuration;

  /** UVM Object Utility macro */
  `uvm_object_utils (cust_svt_ahb_system_configuration)

  /** Class Constructor */
  function new (string name = "cust_svt_ahb_system_configuration");

    super.new(name);

    /** Assign the necessary configuration parameters. This example uses single
      * master and single slave configuration.
      */
    this.num_masters = 1;
    this.num_slaves  = 1;

    /** Create port configurations */
    this.create_sub_cfgs(1,1);

    this.master_cfg[0].transaction_coverage_enable = 1;
    this.slave_cfg[0].transaction_coverage_enable = 1;

    this.master_cfg[0].is_active = 1;
    this.slave_cfg[0].is_active = 1;

    this.master_cfg[0].data_width = 32;
    this.slave_cfg[0].data_width = 32;

    /** Enable protocol file generation for Protocol Analyzer */
   this.master_cfg[0].enable_xml_gen = 1;
   this.slave_cfg[0].enable_xml_gen = 1;
    
    /** Set interface as AHB_LITE */
    this.ahb_lite = 1;

    /** Configure the address map */
    this.set_addr_range(0,32'h0000_0000,32'hFFFF_FFFF);
    
  endfunction

endclass
`endif //GUARD_CUST_SVT_AHB_SYSTEM_CONFIGURATION_SV
