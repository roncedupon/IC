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
 * Top-level SystemVerilog testbench.
 * It instantites the interface and interconnect wrapper.  Clock generation
 * is also  done in the same file.  It includes each test file and initiates
 * the UVM phase manager by calling run_test().
 */
`timescale 1 ns/1 ps

`include "uvm_pkg.sv"

`include "svt_axi_if.svi"

`include "svt_axi.uvm.pkg"

module test_top;

  /** Parameter defines the clock frequency */
  parameter simulation_cycle = 50;

  /** Signal to generate the clock */
  bit SystemClock;

  /** Import UVM Package */
  import uvm_pkg::*;

  /** Import the SVT UVM Package */
  import svt_uvm_pkg::*;

  /** Import the AXI VIP */
  import svt_axi_uvm_pkg::*;
  `include "basic_env.sv"
  /** Include all test files */
  `include "testlist.sv"
  
  /** VIP Interface instance representing the AXI system */
  svt_axi_if axi_if();
  assign axi_if.common_aclk = SystemClock;

  /** TB Interface instance to provide access to the reset signal */
  // axi_reset_if axi_reset_if();
  // assign axi_reset_if.clk = SystemClock;

  /**
   * Assign the reset pin from the reset interface to the reset pins from the VIP
   * interface.
   */
  assign axi_if.master_if[0].aresetn = 0;//axi_reset_if.reset;
  assign axi_if.slave_if[0].aresetn = 0;//axi_reset_if.reset;

  /** Interconnect wrapper */
  // -----------------------------------------------------------------------------
  // axi_svt_dut_sv_wrapper dut_wrapper (axi_if);

  /**
   * Optionally dump the sim variable for waveform display
   */
`ifdef WAVES_FSDB
  initial begin
    $display("dumping fsdb");
    $fsdbDumpfile("test_top");
    $fsdbDumpvars;
  end
`elsif WAVES_VCD
  initial begin
    $dumpvars;
  end
`elsif WAVES
  initial begin
    $vcdpluson;
  end
`endif
  
  /** Testbench 'System' Clock Generator */
  initial begin
    SystemClock = 0 ;
    forever begin
      #(simulation_cycle/2)
        SystemClock = ~SystemClock ;
    end
  end

  initial begin
    /** Set the reset interface on the virtual sequencer */
    // uvm_config_db#(virtual axi_reset_if.axi_reset_modport)::set(uvm_root::get(), "uvm_test_top.env.sequencer", "reset_mp", axi_reset_if.axi_reset_modport);

    /**
     * Provide the AXI SV interface to the AXI System ENV. This step
     * establishes the connection between the AXI System ENV and the HDL
     * Interconnect wrapper, through the AXI interface.
    */
    uvm_config_db#(svt_axi_vif)::set(uvm_root::get(), "uvm_test_top.env.*", "vif", axi_if);

    /** Start the UVM tests */
    run_test();
  end

endmodule
