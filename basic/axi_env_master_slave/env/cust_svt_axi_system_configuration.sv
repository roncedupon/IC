//=======================================================================
// AXI Master-Slave Environment Configuration
// Description: System configuration for 1 master + 1 slave AXI4 environment
//=======================================================================

`ifndef GUARD_CUST_SVT_AXI_SYSTEM_CONFIGURATION_SV
`define GUARD_CUST_SVT_AXI_SYSTEM_CONFIGURATION_SV

class cust_svt_axi_system_configuration extends svt_axi_system_configuration;
  
  /** UVM Object Utility macro */
  `uvm_object_utils(cust_svt_axi_system_configuration)
  
  /** Class Constructor */
  function new(string name = "cust_svt_axi_system_configuration");
    super.new(name);
    
    // Single master and single slave configuration
    this.num_masters = 1;
    this.num_slaves  = 1;
    
    // Create port configurations
    this.create_sub_cfgs(1, 1);
    
    // Master configuration - AXI4 interface
    this.master_cfg[0].axi_interface_type = svt_axi_port_configuration::AXI4;
    this.master_cfg[0].is_active = UVM_ACTIVE;
    this.master_cfg[0].data_width = 64;      // 64-bit data width
    this.master_cfg[0].addr_width = 32;      // 32-bit address width
    this.master_cfg[0].id_width = 4;         // 4-bit ID width
    this.master_cfg[0].user_width = 8;       // 8-bit user width
    
    // Enable transaction coverage
    this.master_cfg[0].transaction_coverage_enable = 1;
    this.master_cfg[0].protocol_coverage_enable = 1;
    
    // Slave configuration - AXI4 interface
    this.slave_cfg[0].axi_interface_type = svt_axi_port_configuration::AXI4;
    this.slave_cfg[0].is_active = UVM_ACTIVE;
    this.slave_cfg[0].data_width = 64;
    this.slave_cfg[0].addr_width = 32;
    this.slave_cfg[0].id_width = 4;
    this.slave_cfg[0].user_width = 8;
    
    // Enable transaction coverage
    this.slave_cfg[0].transaction_coverage_enable = 1;
    this.slave_cfg[0].protocol_coverage_enable = 1;
    
    // Configure address map for slave
    // Slave responds to entire 32-bit address space
    this.set_addr_range(0, 32'h0000_0000, 32'hFFFF_FFFF);
    
    // Enable memory model in slave
    this.slave_cfg[0].enable_mem_model = 1;
    
    // Set memory address range
    this.slave_cfg[0].mem_size = 32'h10000;  // 64KB memory
    
  endfunction
  
endclass

`endif // GUARD_CUST_SVT_AXI_SYSTEM_CONFIGURATION_SV
