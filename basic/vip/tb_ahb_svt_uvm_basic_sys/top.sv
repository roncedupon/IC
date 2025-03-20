//=======================================================================
// COPYRIGHT (C) 2012-2017 SYNOPSYS INC.
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

`include "svt_ahb_if.svi"
`include "ahb_svt_dut_sv_wrapper.sv"

`include "ahb_reset_if.svi"

/** Include the AHB SVT UVM package */
`include "svt_ahb.uvm.pkg"
/** Include the AMBA COMMON SVT UVM package */
`include "svt_amba_common.uvm.pkg"

`define WAVES_FSDB
module test_top;

  /** Parameter defines the clock frequency */
  parameter simulation_cycle = 50;

  /** Signal to generate the clock */
  bit SystemClock;

  /** Import UVM Package */
  import uvm_pkg::*;

  /** Import the SVT UVM Package */
  import svt_uvm_pkg::*;

  /** Import the AHB VIP */
  import svt_ahb_uvm_pkg::*;

  /** Import the AMBA COMMON Package for amba_pv_extension */
  import svt_amba_common_uvm_pkg::*;

  /** Include all test files */
  `include "top_test.sv"

  /** VIP Interface instance representing the AHB system */
  svt_ahb_if ahb_if();
  assign ahb_if.hclk = SystemClock;

  /** TB Interface instance to provide access to the reset signal */
  ahb_reset_if ahb_reset_if();
  assign ahb_reset_if.clk = SystemClock;

  /**
   * Assign the reset pin from the reset interface to the reset pins from the VIP
   * interface.
   */
  assign ahb_if.hresetn = ahb_reset_if.resetn;
  
  /** Interconnect wrapper */
  // -----------------------------------------------------------------------------
  ahb_svt_dut_sv_wrapper dut_wrapper (ahb_if);

  /**
   * Optionally dump the sim variable for waveform display
   */
`ifdef WAVES_FSDB
  initial begin
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
    $display("MAX_DATA_WIDTH=%0d",`SVT_AHB_MAX_DATA_WIDTH);
    $display("MAX_DATA_WIDTH=%0d",`SVT_AHB_MAX_DATA_WIDTH);
    $display("MAX_DATA_WIDTH=%0d",`SVT_AHB_MAX_DATA_WIDTH);
    $display("MAX_DATA_WIDTH=%0d",`SVT_AHB_MAX_DATA_WIDTH);
    $display("MAX_DATA_WIDTH=%0d",`SVT_AHB_MAX_DATA_WIDTH);
    $display("MAX_DATA_WIDTH=%0d",`SVT_AHB_MAX_DATA_WIDTH);
    $display("MAX_DATA_WIDTH=%0d",`SVT_AHB_MAX_DATA_WIDTH);
    $display("MAX_DATA_WIDTH=%0d",`SVT_AHB_MAX_DATA_WIDTH);
    $display("MAX_DATA_WIDTH=%0d",`SVT_AHB_MAX_DATA_WIDTH);
    $display("MAX_DATA_WIDTH=%0d",`SVT_AHB_MAX_DATA_WIDTH);
    $display("MAX_DATA_WIDTH=%0d",`SVT_AHB_MAX_DATA_WIDTH);
    SystemClock = 0 ;
    forever begin
      #(simulation_cycle/2)
        SystemClock = ~SystemClock ;
    end
  end

  initial begin
    /** Set the reset interface on the virtual sequencer */
    uvm_config_db#(virtual ahb_reset_if.ahb_reset_modport)::set(uvm_root::get(), "uvm_test_top.env.sequencer", "reset_mp", ahb_reset_if.ahb_reset_modport);

    /**
     * Provide the AHB SV interface to the AHB System ENV. This step
     * establishes the connection between the AHB System ENV and the HDL
     * Interconnect wrapper, through the AHB interface.
    */
    uvm_config_db#(svt_ahb_vif)::set(uvm_root::get(), "uvm_test_top.env.ahb_system_env", "vif", ahb_if);

    /** Start the UVM tests */
    run_test();
  end

endmodule
