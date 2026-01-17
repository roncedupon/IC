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
//=======================================================================

`timescale 1ns/1ps

`include "svt_uart.uvm.pkg"

`include "uvm_macros.svh"
`include "uvm_pkg.sv"

import uvm_pkg::*;
import svt_uvm_pkg::*;

`include "uart_reset_if.svi"
`include "uart_svt_interconnect_sv_wrapper.sv"

/**
 * Abstract:
 * Top-level SystemVerilog testbench.
 * It instantites the interface and interconnect wrapper.  Clock generation is also done in the same file.
 * It includes each test file and initiates the UVM phase manager by calling run_test().
 */
module test_top;
   
  /** Import Uart SVT UVM Packages */
  import svt_uart_uvm_pkg::*;
  
  /** Parameter defines the clock frequency */
  parameter simulation_cycle = 10 ;
  
  /** Signal to generate the clock */
  bit 	     SystemClock;
  
  /** Includes all the test files: ts.base_test.sv, ts.directed_test.sv, ts.random_test.sv */
  `include "top_test.sv"
   
  /** 
   * Instantiate SV Interface for DTE and connect the system clock to the clock signal 
   * in the interface
   */
  svt_uart_if        uart_dte_if(SystemClock);
  
  /** 
   * Instantiate SV Interface for DCE and connect the system clock to the clock signal
   *  in the interface
   */
  svt_uart_if        uart_dce_if(SystemClock);
   
  /** Instantiate UART BFM Wrapper acting as DTE*/
  svt_uart_bfm_wrapper  #(.UV_DEVICE_TYPE(`UV_DTE)) Bfm0 (uart_dte_if);

  /** Instantiate UART BFM Wrapper acting as DCE*/
  svt_uart_bfm_wrapper  #(.UV_DEVICE_TYPE(`UV_DCE)) Bfm1 (uart_dce_if);
  
  /** HDL Interconnect instantiation: This is just pass-through connection  */
  uart_svt_interconnect_sv_wrapper interconnect_wrapper(uart_dte_if, uart_dce_if);

  /** TB Interface instance to provide access to the reset signal */
  uart_reset_if uart_reset_if();
  assign uart_reset_if.clk = SystemClock;

  /**
   * Assign the reset pin from the reset interface to the reset pins from the VIP
   * DTE and DCE interface.
   */
  assign uart_dte_if.rst = uart_reset_if.reset;
  assign uart_dce_if.rst = uart_reset_if.reset;
  
  /** Testbench 'System' Clock Generator */
  initial begin
    #(simulation_cycle/2); // No clock edge at T=0
    SystemClock = 0 ;
    forever begin
      #(simulation_cycle/2)
      SystemClock = ~SystemClock ;
    end
  end
  initial begin
    #1000ms; // Simulation timeout
    `uvm_fatal("TIMEOUT", "Simulation timed out after 1000us");
  end
  /**
   * Provide the UART SV interface to the UART ENV. This step
   * establishes the connection between the UART ENV and the HDL
   * Interconnect wrapper, through the Interconnect interface.
   */
  initial begin
    /** Set the DTE BFM Port Interface to factory */
    uvm_config_db#(virtual svt_uart_if)::set(uvm_root::get(),"uvm_test_top.env","dte_vif", uart_dte_if);
    
    /** Set the DCE BFM Port Interface to factory */
    uvm_config_db#(virtual svt_uart_if)::set(uvm_root::get(),"uvm_test_top.env","dce_vif", uart_dce_if);
    
    /** Set the reset interface on the virtual sequencer */
    uvm_config_db#(virtual uart_reset_if.uart_reset_modport)::set(uvm_root::get(), "uvm_test_top.env.sequencer",
                 "reset_mp", uart_reset_if.uart_reset_modport);
  end
  
  /**  UVM test phase initiator */
  initial begin
    run_test();
  end
  
  /** Optionally dump the simulation variables for waveform display. */
`ifdef WAVES_FSDB
  initial begin
    $fsdbDumpfile("wave.fsdb");
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

endmodule
