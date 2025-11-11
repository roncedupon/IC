//--------------------------------------------------------------------------
// COPYRIGHT (C) 2012, 2013 SYNOPSYS INC.
// This software and the associated documentation are confidential and
// proprietary to Synopsys, Inc. Your use or disclosure of this software
// is subject to the terms and conditions of a written license agreement
// between you, or your company, and Synopsys, Inc. In the event of
// publications, the following notice is applicable:
//
// ALL RIGHTS RESERVED
//
// The entire notice above must be reproduced on all authorized copies.
// -------------------------------------------------------------------------
`timescale 100ps/100ps

/** Include the I2C SVT UVM package */
`include "svt_i2c.uvm.pkg"

/** Include the interconnect wrapper */
`include "i2c_svt_interconnect_sv_wrapper.sv"

/** Include the reset Interface */
`include "i2c_reset_if.svi"

/**
 * Top Level Module : test_top
 */
module test_top;

  /** Import UVM Package */
  import uvm_pkg::*;

  /** Import the SVT UVM Package */
  import svt_uvm_pkg::*;
  
  /** Import I2C SVT UVM Package */
  import svt_i2c_uvm_pkg::*;
  
  /** Import I2C SVT ENUM Package */
  import svt_i2c_enum_pkg::*;
  
  /** Include all test files */
  `include "top_test.sv"

  // Global Variables
  bit reset=1'b0;
  
  /** 
   * Parameter defines the clock frequency. The value of 10 given
   * to this parameter is to generate clock with time period 1ns
   * as per the timescale resolution set to 100ps.
   * Values of all timing variables are given in ns as per the 
   * time period of this clk.
   */
  parameter simulation_cycle = 10;
  
  /** Signal to generate the clock */
  bit SystemClock;
  
  /** Instantiate SV Interface for Master and connect the system clock */ 
  svt_i2c_if i2c_if (SystemClock);
  
  /** Intantiate Master Wrapper */
  svt_i2c_master_wrapper Master (i2c_if);
  
  /** Intantiate Slave Wrapper */
  svt_i2c_slave_wrapper Slave (i2c_if);
  
  /** hdl_dut Instantiation (DUT Instantiation): It is a cross connection. */
  i2c_svt_interconnect_sv_wrapper interconnect_wrapper(i2c_if);  
  
  /** TB Interface instance to provide access to the reset signal */
  i2c_reset_if i2c_reset_if();
  assign i2c_reset_if.clk = SystemClock; 
  assign i2c_if.RST = i2c_reset_if.reset;
  
  // ----------------------------------------------------------------------
  // Testbench 'System' Clock Generator
  // ----------------------------------------------------------------------
  initial begin
    #(simulation_cycle/2); // No clock edge at T=0
    SystemClock = 0 ;
    forever begin
      #(simulation_cycle/2)
      SystemClock = ~SystemClock ;
    end
  end
  
  //-----------------------------------------------------------------------
  // Initiate OVM Test
  //-----------------------------------------------------------------------
  initial begin
     
    /** Set the Master Interface to factory */
    uvm_config_db#(virtual svt_i2c_if)::set(uvm_root::get(),  
                                            "uvm_test_top.env", 
                                            "vif", i2c_if);
    
    /** Set the reset interface on the virtual sequencer */
    uvm_config_db#(virtual i2c_reset_if.i2c_reset_modport)::set(uvm_root::get(), 
                                                                "uvm_test_top.env.sequencer", 
                                                                "reset_mp", 
                                                                i2c_reset_if.i2c_reset_modport);
    /** run UVM Test */
    run_test();
  end
   
  //-----------------------------------------------------------------------
  // Initiate Waves
  //-----------------------------------------------------------------------
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
  
endmodule : test_top

//--------------------------------------------------------------------------
//-----------------------END OF FILE----------------------------------------
//--------------------------------------------------------------------------
