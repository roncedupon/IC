//=======================================================================
// AXI Base Test
// Description: Base test class with common test infrastructure
//=======================================================================

`ifndef GUARD_AXI_BASE_TEST_SV
`define GUARD_AXI_BASE_TEST_SV

class axi_base_test extends uvm_test;
  
  /** Environment instance */
  axi_basic_env env;
  
  /** Configuration instance */
  cust_svt_axi_system_configuration cfg;
  
  /** UVM Component Utility macro */
  `uvm_component_utils(axi_base_test)
  
  /** Class Constructor */
  function new(string name = "axi_base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  /** Build Phase */
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // Create configuration
    cfg = cust_svt_axi_system_configuration::type_id::create("cfg");
    
    // Pass configuration to environment
    uvm_config_db#(cust_svt_axi_system_configuration)::set(this, "env", "cfg", cfg);
    
    // Create environment
    env = axi_basic_env::type_id::create("env", this);
    
    // Enable UVM objection timeout
    uvm_top.set_timeout(100ms);
  endfunction
  
  /** End of Elaboration Phase */
  virtual function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    
    // Print topology
    uvm_top.print_topology();
  endfunction
  
  /** Report Phase */
  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    
    // Print final report
    uvm_report_server server;
    server = uvm_report_server::get_server();
    
    if (server.get_severity_count(UVM_ERROR) > 0 ||
        server.get_severity_count(UVM_FATAL) > 0) begin
      `uvm_error("TEST_STATUS", "TEST FAILED")
    end
    else begin
      `uvm_info("TEST_STATUS", "TEST PASSED", UVM_LOW)
    end
  endfunction
  
endclass

`endif // GUARD_AXI_BASE_TEST_SV
