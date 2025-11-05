//=======================================================================
//
// SYNOPSYS CONFIDENTIAL
// This is an unpublished, proprietary work of Synopsys, Inc., and is
// fully protected under copyright and trade secret laws. You may not
// view, use, disclose, copy, or distribute this file, or any information
// contained herein except pursuant to a valid written license from
// Synopsys.
//
//-----------------------------------------------------------------------
/**
 * This is replacable define for timescale from commandline 
 * Default value: 1ns/1ps
 */
`ifndef SVT_SPI_TIMESCALE_TIME_UNIT
`define SVT_SPI_TIMESCALE_TIME_UNIT 1ns
`endif
`ifndef SVT_SPI_TIMESCALE_PRECISION
`define SVT_SPI_TIMESCALE_PRECISION 1ps
`endif
`timescale `SVT_SPI_TIMESCALE_TIME_UNIT/`SVT_SPI_TIMESCALE_PRECISION

`include "svt_spi.uvm.pkg"
`ifdef SVT_UVM_1800_2_2017_OR_HIGHER
 `include "deprecated/macros/uvm_sequence_defines.svh"
`endif

import uvm_pkg::*;
import svt_uvm_pkg::*;
import svt_mem_uvm_pkg::*;

`include "spi_reset_if.svi"
`include "spi_svt_interconnect_sv_wrapper.sv"

/**
 * Abstract:
 * Top-level SystemVerilog testbench.
 * It instantites the interface and interconnect wrapper.  Clock generation is also done in the same file.
 * It includes each test file and initiates the UVM phase manager by calling run_test().
 */
module test_top;
   
  /** Import SPI SVT UVM Packages */
  import svt_spi_uvm_pkg::*;
  
  /** Parameter defines the clock frequency */
  parameter simulation_cycle = 10 ;
  
  /** Signal to generate the clock */
  bit 	     SystemClock;
  wire 	    reset;
  
  /** Includes all the test files: ts.base_test.sv, ts.directed_test.sv, ts.random_test.sv */
  `include "top_test.sv"
   
  /** 
   * Instantiate SV Interface for MASTER and connect the system clock to the clock signal 
   * in the interface
   */
  svt_spi_if        spi_master_if(SystemClock,reset);
  
  /** 
   * Instantiate SV Interface for SLAVE and connect the system clock to the clock signal
   *  in the interface
   */
  svt_spi_if        spi_slave_if(SystemClock,reset);
   
  /** HDL Interconnect instantiation: This is just pass-through connection  */
  spi_svt_interconnect_sv_wrapper interconnect_wrapper(spi_master_if, spi_slave_if);

  /** TB Interface instance to provide access to the reset signal */
  spi_reset_if spi_reset_if();
  assign spi_reset_if.clk = SystemClock;

  /**
   * Assign the reset pin from the reset interface to the reset pins from the VIP
   * MASTER and SLAVE interface.
   */
  assign reset = spi_reset_if.reset;

  /** Testbench 'System' Clock Generator */
  initial begin
    #(simulation_cycle/2); // No clock edge at T=0
    SystemClock = 0 ;

    forever begin
      #(simulation_cycle/2)
      SystemClock = ~SystemClock ;
    end
  end

  /**
   * Provide the SPI SV interface to the SPI ENV. This step
   * establishes the connection between the SPI ENV and the HDL
   * Interconnect wrapper, through the Interconnect interface.
   */
  initial begin
    /** Set the MASTER BFM Port Interface to factory */
    uvm_config_db#(virtual svt_spi_if)::set(uvm_root::get(),"uvm_test_top.env","master_vif", spi_master_if);
    
    /** Set the SLAVE BFM Port Interface to factory */
    uvm_config_db#(virtual svt_spi_if)::set(uvm_root::get(),"uvm_test_top.env","slave_vif", spi_slave_if);
    
    /** Set the reset interface on the virtual sequencer */
    uvm_config_db#(virtual spi_reset_if.spi_reset_modport)::set(uvm_root::get(), "uvm_test_top.env.sequencer",
                 "reset_mp", spi_reset_if.spi_reset_modport);
    
    /** Set the simulation cycle to factory */
    uvm_config_db#(int)::set(uvm_root::get(),"uvm_test_top","simulation_cycle", simulation_cycle);
  end
  
  /**  UVM test phase initiator */
  initial begin
    run_test();
  end

/** Optionally dump the simulation variables for waveform display. */
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
   
endmodule // test_top

