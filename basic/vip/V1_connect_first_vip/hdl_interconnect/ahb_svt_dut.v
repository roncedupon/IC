
/**
 * Abstract:
 *   This module represents a DUT that has 2 AHB Protocol Interfaces.
 *   Protocol interface 1 connects to an AHB Master, and all pins have the suffix _m1.
 *   Protocol interface 2 connects to an AHB Slave, and all pins have the suffix _s1.. 
 *   The behavior of this module is to simply connect the two protocol interfaces 
 *   by assigning the appropriate inputs on the Slave side to the outputs on the Master side, 
 *   and vice versa.
 */
`ifndef GUARD_AHB_SVT_DUT_V
`define GUARD_AHB_SVT_DUT_V


module  ahb_svt_dut 
(

/**
 * Clock and reset
 */

  hclk,
  hresetn,
    
  // Master side of ahb protocol interface signals
  haddr_m1,
  hburst_m1,
  hbusreq_m1,
  hlock_m1,
  hsize_m1,
  htrans_m1,
  hwdata_m1,
  hwrite_m1,
  hprot_m1,
  hgrant_m0,
  hgrant_m1,
  hready_m1,
  hresp,
  hrdata,
  // Master side of user control signals
  control_huser_m1,

  // Slave side of ahb protocol interface signals
  hsplit_s1,
  hrdata_s1,
  hresp_s1,
  hready_s1,
  hsel_s0,
  hsel_s1,
  haddr,
  hburst,
  hsize,
  htrans,
  hprot,
  hwrite,
  hwdata,
  hmaster,
  hmastlock,
 // Slave side of user control signals
  control_huser
);

  input  hclk;
  input  hresetn;

//Dummy Master
  output hgrant_m0;

//Default Slave
  output hsel_s0;

//-----------------------------------------------------------
// AHB Master Port Interface m1: Dataflow Interface Signals
//-----------------------------------------------------------
  input  [`SVT_AHB_MAX_ADDR_WIDTH -1:0] haddr_m1;
  input  [`SVT_AHB_HBURST_PORT_WIDTH -1:0] hburst_m1;
  input  hbusreq_m1;
  input  hlock_m1;
  input  [`SVT_AHB_HSIZE_PORT_WIDTH-1:0] hsize_m1;
  input  [`SVT_AHB_HTRANS_PORT_WIDTH-1:0] htrans_m1;
  input  [`SVT_AHB_MAX_DATA_WIDTH-1:0] hwdata_m1;
  input  hwrite_m1;
  input  [`SVT_AHB_HPROT_PORT_WIDTH-1:0] hprot_m1;
  input  [`SVT_AHB_MAX_USER_WIDTH-1:0] control_huser_m1;
  output hgrant_m1;
  output   hready_m1;
  output [`SVT_AHB_HRESP_PORT_WIDTH-1:0] hresp;
  output [`SVT_AHB_MAX_DATA_WIDTH-1:0] hrdata;

//-------------------------------------------------------------
// AHB Slave Protocol Interface s1: Dataflow Interface Signals
//-------------------------------------------------------------
  input  [`SVT_AHB_MAX_NUM_MASTERS-1:0] hsplit_s1;
  input  [`SVT_AHB_MAX_DATA_WIDTH-1:0] hrdata_s1;
  input  [`SVT_AHB_HRESP_PORT_WIDTH-1:0] hresp_s1;
  input  hready_s1;
  output  hsel_s1;
  output [`SVT_AHB_MAX_ADDR_WIDTH-1:0] haddr;
  output [`SVT_AHB_HBURST_PORT_WIDTH-1:0] hburst;
  output [`SVT_AHB_HSIZE_PORT_WIDTH-1:0] hsize;
  output  [`SVT_AHB_HTRANS_PORT_WIDTH-1:0] htrans;
  output [`SVT_AHB_HPROT_PORT_WIDTH-1:0] hprot;
  output hwrite;
  output [`SVT_AHB_MAX_DATA_WIDTH-1:0] hwdata;
  output [`SVT_AHB_HMASTER_PORT_WIDTH-1:0] hmaster;
  output hmastlock;
  output [`SVT_AHB_MAX_USER_WIDTH-1:0] control_huser;

// ===================================================================================================
// Appropriate inputs from AHB Interface m1 are connected to outputs on AHB Interface s1 and viceversa
// ----------------------------------------------------------------------------------------------------
  assign haddr = haddr_m1; 
  assign hburst= hburst_m1;
  assign hsize = hsize_m1;
  assign htrans=  htrans_m1;
  assign hwdata=hwdata_m1;
  assign hwrite=hwrite_m1;
  assign hprot=hprot_m1;
  assign control_huser = control_huser_m1;
  assign hready_m1= hready_s1;
  assign hresp=hresp_s1;
  assign hrdata = hrdata_s1;
  assign hgrant_m1=1'b1;
  assign hsplit_s1=16'b0;
  assign hsel_s1=1'b1; 
  assign hmastlock=1'b0;
  assign hmaster=4'h0;
endmodule
// =============================================================================
`endif //GUARD_AHB_SVT_DUT_V

