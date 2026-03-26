//=======================================================================
// Top Module - AXI Master-Slave Testbench
// Description: Top-level testbench connecting VIP interface and DUT
//=======================================================================

`timescale 1ns/1ps

`include "uvm_pkg.sv"
`include "svt_axi_if.svi"
`include "svt_axi.uvm.pkg"
// UVM imports
import uvm_pkg::*;
import svt_uvm_pkg::*;
import svt_axi_uvm_pkg::*;
// Include environment files
`include "env/cust_svt_axi_system_configuration.sv"
`include "env/axi_virtual_sequencer.sv"
// `include "env/axi_scoreboard.sv"
`include "env/axi_coverage.sv"
`include "env/axi_master_write_read_sequence.sv"
`include "env/axi_slave_response_sequence.sv"
`include "env/axi_virtual_sequence.sv"
`include "env/axi_basic_env.sv"

// Include test files
`include "tests/axi_base_test.sv"
`include "tests/axi_write_read_test.sv"
`include "tests/axi_advanced_test.sv"

// Include DUT wrapper
`include "hdl_interconnect/axi_dut_wrapper.sv"

module test_top;
  
  // Clock period parameter
  parameter CLOCK_PERIOD = 10;  // 10ns = 100MHz
  
  // Clock and reset signals
  logic aclk;
  logic aresetn;
  

  // AXI interface instance
  svt_axi_if axi_if();
  
  // DUT wrapper instance
  axi_dut_wrapper dut_wrapper (
    .axi_if(axi_if)
  );
  
  // Clock generation
  initial begin
    aclk = 0;
    forever #(CLOCK_PERIOD/2) aclk = ~aclk;
  end
  
  // Reset generation
  initial begin
    aresetn = 0;
    repeat(10) @(posedge aclk);
    aresetn = 1;
  end
  
  // Connect clock and reset to interface
  assign axi_if.common_aclk = aclk;
  assign axi_if.master_if[0].aresetn = aresetn;
  assign axi_if.slave_if[0].aresetn = aresetn;
  
  // Waveform dump (optional)
  `ifdef WAVES_FSDB
    initial begin
      $fsdbDumpfile("axi_tb.fsdb");
      $fsdbDumpvars(0, test_top);
    end
  `elsif WAVES_VCD
    initial begin
      $dumpfile("axi_tb.vcd");
      $dumpvars(0, test_top);
    end
  `endif
  
  // UVM configuration and test execution
  initial begin
    // Pass interface to UVM config DB
    uvm_config_db#(svt_axi_vif)::set(null, "uvm_test_top.env.axi_system_env", "vif", axi_if);
    
    // Set sequence length
    uvm_config_db#(int unsigned)::set(null, "uvm_test_top.env", "sequence_length", 20);
    
    // Run test (test name can be overridden from command line)
    run_test();
  end
  
  // Simulation timeout
  initial begin
    #1000000;
    $display("Simulation timeout at %0t", $time);
    $finish;
  end
  
endmodule
