//=======================================================================
// AXI Coverage Collector
// Description: Functional coverage for AXI4 protocol features
//=======================================================================

`ifndef GUARD_AXI_COVERAGE_SV
`define GUARD_AXI_COVERAGE_SV

class axi_coverage extends uvm_subscriber #(svt_axi_master_transaction);
  
  /** Transaction to be analyzed */
  svt_axi_master_transaction tr;
  
  /** Configuration handle */
  cust_svt_axi_system_configuration cfg;
  
  /** UVM Component Utility macro */
  `uvm_component_utils(axi_coverage)
  
  /** Class Constructor */
  function new(string name = "axi_coverage", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  /** Build Phase */
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // Get configuration
    if (!uvm_config_db#(cust_svt_axi_system_configuration)::get(this, "", "cfg", cfg)) begin
      `uvm_warning("build_phase", "Configuration not found")
    end
  endfunction
  
  /** Analysis write method */
  virtual function void write(svt_axi_master_transaction t);
    tr = t;
    if (tr != null) begin
      sample_coverage();
    end
  endfunction
  
  /** Coverage sampling */
  covergroup axi_cg;
    
    // Transaction type coverage
    xact_type_cp: coverpoint tr.xact_type {
      bins write = {svt_axi_master_transaction::WRITE};
      bins read  = {svt_axi_master_transaction::READ};
    }
    
    // Burst type coverage
    burst_type_cp: coverpoint tr.burst_type {
      bins fixed = {svt_axi_master_transaction::FIXED};
      bins incr  = {svt_axi_master_transaction::INCR};
      bins wrap  = {svt_axi_master_transaction::WRAP};
    }
    
    // Burst length coverage
    burst_length_cp: coverpoint tr.burst_length {
      bins single = {1};
      bins short_burst = {[2:4]};
      bins medium_burst = {[5:8]};
      bins long_burst = {[9:16]};
    }
    
    // Burst size coverage
    burst_size_cp: coverpoint tr.burst_size {
      bins size_8bit   = {svt_axi_master_transaction::BURST_SIZE_8BIT};
      bins size_16bit  = {svt_axi_master_transaction::BURST_SIZE_16BIT};
      bins size_32bit  = {svt_axi_master_transaction::BURST_SIZE_32BIT};
      bins size_64bit  = {svt_axi_master_transaction::BURST_SIZE_64BIT};
      bins size_128bit = {svt_axi_master_transaction::BURST_SIZE_128BIT};
    }
    
    // Address alignment coverage
    addr_alignment_cp: coverpoint (tr.addr[2:0]) {
      bins aligned_8byte   = {3'b000};
      bins aligned_4byte   = {3'b000, 3'b100};
      bins aligned_2byte   = {3'b000, 3'b010, 3'b100, 3'b110};
      bins unaligned       = default;
    }
    
    // Cross coverage between transaction type and burst type
    xact_burst_cross: cross xact_type_cp, burst_type_cp;
    
    // Cross coverage between burst length and burst size
    burst_cross: cross burst_length_cp, burst_size_cp;
    
  endgroup
  
  /** Sample coverage */
  virtual function void sample_coverage();
    axi_cg.sample();
  endfunction
  
  /** Report Phase */
  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    
    `uvm_info("COVERAGE_REPORT", "==================================", UVM_LOW)
    `uvm_info("COVERAGE_REPORT", $sformatf("AXI Coverage: %.2f%%", axi_cg.get_inst_coverage()), UVM_LOW)
    `uvm_info("COVERAGE_REPORT", "==================================", UVM_LOW)
    
    // Print detailed coverage
    `uvm_info("COVERAGE_DETAIL", $sformatf("Transaction Type Coverage: %.2f%%", 
              axi_cg.xact_type_cp.get_coverage()), UVM_LOW)
    `uvm_info("COVERAGE_DETAIL", $sformatf("Burst Type Coverage: %.2f%%", 
              axi_cg.burst_type_cp.get_coverage()), UVM_LOW)
    `uvm_info("COVERAGE_DETAIL", $sformatf("Burst Length Coverage: %.2f%%", 
              axi_cg.burst_length_cp.get_coverage()), UVM_LOW)
    `uvm_info("COVERAGE_DETAIL", $sformatf("Burst Size Coverage: %.2f%%", 
              axi_cg.burst_size_cp.get_coverage()), UVM_LOW)
    `uvm_info("COVERAGE_DETAIL", $sformatf("Address Alignment Coverage: %.2f%%", 
              axi_cg.addr_alignment_cp.get_coverage()), UVM_LOW)
    `uvm_info("COVERAGE_DETAIL", $sformatf("Cross Coverage (Xact x Burst): %.2f%%", 
              axi_cg.xact_burst_cross.get_coverage()), UVM_LOW)
    `uvm_info("COVERAGE_DETAIL", $sformatf("Cross Coverage (Length x Size): %.2f%%", 
              axi_cg.burst_cross.get_coverage()), UVM_LOW)
  endfunction
  
endclass

`endif // GUARD_AXI_COVERAGE_SV