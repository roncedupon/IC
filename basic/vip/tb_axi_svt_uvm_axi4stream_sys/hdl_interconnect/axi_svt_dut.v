//=======================================================================
// COPYRIGHT  2010, 2011, 2012, 2013 SYNOPSYS INC.
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

/*
 * Abstract:
 * This module represents a HDL interconnect DUT that has 2 AXI Protocol Interfaces.
 * Protocol interface 1 connects to an AXI Master Agent, and all pins have the suffix _m1.
 * Protocol interface 2 connects to an AXI Slave Agent, and all pins have the suffix _s1.. 
 * The behavior of this module is to simply connect the two protocol interfaces 
 * by assigning the inputs on the Slave side to the outputs on the Master side, 
 * and vice versa.
 */

`ifndef GUARD_AXI_SVT_DUT_V
`define GUARD_AXI_SVT_DUT_V

module axi_svt_dut (
  /**
   * Clock and reset
   */
  aclk,
  aresetn,

  /**
   * AXI4 stream Master side Interface
   */
    tvalid_m1,
    tdata_m1,
    tstrb_m1,
    tkeep_m1,
    tlast_m1,
    tid_m1,
    tdest_m1,
    tuser_m1,
    tready_m1, 

  /**
   * AXI4 stream slave side Interface
   */
    tvalid_s1,
    tdata_s1,
    tstrb_s1,
    tkeep_s1,
    tlast_s1,
    tid_s1,
    tdest_s1,
    tuser_s1,
    tready_s1 
  );
 

  /**
   * Clock and Reset signals
   */
  input  aclk;
  input  aresetn;

  input  tvalid_m1; 
  input  [`SVT_AXI_MAX_TDATA_WIDTH-1:0] tdata_m1; 
  input  [`SVT_AXI_TSTRB_WIDTH-1:0]  tstrb_m1;
  input  [`SVT_AXI_TKEEP_WIDTH-1:0] tkeep_m1;
  input  tlast_m1; 
  input  [`SVT_AXI_MAX_TID_WIDTH-1:0] tid_m1;  
  input  [`SVT_AXI_MAX_TDEST_WIDTH-1:0] tdest_m1; 
  input  [`SVT_AXI_MAX_TUSER_WIDTH-1:0] tuser_m1; 
  output tready_m1; 

  output  tvalid_s1; 
  output  [`SVT_AXI_MAX_TDATA_WIDTH-1:0] tdata_s1; 
  output  [`SVT_AXI_TSTRB_WIDTH-1:0]  tstrb_s1;
  output  [`SVT_AXI_TKEEP_WIDTH-1:0] tkeep_s1;
  output  tlast_s1; 
  output  [`SVT_AXI_MAX_TID_WIDTH-1:0] tid_s1;  
  output  [`SVT_AXI_MAX_TDEST_WIDTH-1:0] tdest_s1; 
  output  [`SVT_AXI_MAX_TUSER_WIDTH-1:0] tuser_s1; 
  input tready_s1; 
  
  /**
   * Pass-Through Assignments: Inputs from AXI Interface m1 are copied
   * to Outputs on AXI Interface s1, and vice versa
   */

  assign tvalid_s1=tvalid_m1;
  assign tdata_s1=tdata_m1;
  assign tstrb_s1=tstrb_m1;
  assign tkeep_s1=tkeep_m1;
  assign tlast_s1=tlast_m1;
  assign tid_s1=tid_m1;
  assign tdest_s1=tdest_m1;
  assign tuser_s1=tuser_m1;
  assign tready_m1=tready_s1; 

endmodule

`endif // GUARD_AXI_SVT_DUT_V
