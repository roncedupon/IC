//=======================================================================
// AXI DUT - Pass-through Interconnect
// Description: Directly connects master and slave interfaces
//=======================================================================

`ifndef GUARD_AXI_DUT_V
`define GUARD_AXI_DUT_V

module axi_dut #(
  // Parameters
  parameter DATA_WIDTH = 64,
  parameter ADDR_WIDTH = 32,
  parameter ID_WIDTH   = 4,
  parameter USER_WIDTH = 8
)(
  // Clock and Reset
  input  logic                    aclk,
  input  logic                    aresetn,
  
  // ========== Write Address Channel (AW) ==========
  // Master outputs -> Slave inputs
  input  logic [ID_WIDTH-1:0]     m_awid,
  input  logic [ADDR_WIDTH-1:0]   m_awaddr,
  input  logic [7:0]              m_awlen,
  input  logic [2:0]              m_awsize,
  input  logic [1:0]              m_awburst,
  input  logic                    m_awlock,
  input  logic [3:0]              m_awcache,
  input  logic [2:0]              m_awprot,
  input  logic [3:0]              m_awqos,
  input  logic [3:0]              m_awregion,
  input  logic [USER_WIDTH-1:0]   m_awuser,
  input  logic                    m_awvalid,
  output logic                    m_awready,
  
  // ========== Write Data Channel (W) ==========
  input  logic [DATA_WIDTH-1:0]   m_wdata,
  input  logic [DATA_WIDTH/8-1:0] m_wstrb,
  input  logic                    m_wlast,
  input  logic [USER_WIDTH-1:0]   m_wuser,
  input  logic                    m_wvalid,
  output logic                    m_wready,
  
  // ========== Write Response Channel (B) ==========
  output logic [ID_WIDTH-1:0]     m_bid,
  output logic [1:0]              m_bresp,
  output logic [USER_WIDTH-1:0]   m_buser,
  output logic                    m_bvalid,
  input  logic                    m_bready,
  
  // ========== Read Address Channel (AR) ==========
  input  logic [ID_WIDTH-1:0]     m_arid,
  input  logic [ADDR_WIDTH-1:0]   m_araddr,
  input  logic [7:0]              m_arlen,
  input  logic [2:0]              m_arsize,
  input  logic [1:0]              m_arburst,
  input  logic                    m_arlock,
  input  logic [3:0]              m_arcache,
  input  logic [2:0]              m_arprot,
  input  logic [3:0]              m_arqos,
  input  logic [3:0]              m_arregion,
  input  logic [USER_WIDTH-1:0]   m_aruser,
  input  logic                    m_arvalid,
  output logic                    m_arready,
  
  // ========== Read Data Channel (R) ==========
  output logic [ID_WIDTH-1:0]     m_rid,
  output logic [DATA_WIDTH-1:0]   m_rdata,
  output logic [1:0]              m_rresp,
  output logic                    m_rlast,
  output logic [USER_WIDTH-1:0]   m_ruser,
  output logic                    m_rvalid,
  input  logic                    m_rready
);

  // Slave interface signals (outputs from slave, inputs to master)
  logic [ID_WIDTH-1:0]     s_awid;
  logic [ADDR_WIDTH-1:0]   s_awaddr;
  logic [7:0]              s_awlen;
  logic [2:0]              s_awsize;
  logic [1:0]              s_awburst;
  logic                    s_awlock;
  logic [3:0]              s_awcache;
  logic [2:0]              s_awprot;
  logic [3:0]              s_awqos;
  logic [3:0]              s_awregion;
  logic [USER_WIDTH-1:0]   s_awuser;
  logic                    s_awvalid;
  logic                    s_awready;
  
  logic [DATA_WIDTH-1:0]   s_wdata;
  logic [DATA_WIDTH/8-1:0] s_wstrb;
  logic                    s_wlast;
  logic [USER_WIDTH-1:0]   s_wuser;
  logic                    s_wvalid;
  logic                    s_wready;
  
  logic [ID_WIDTH-1:0]     s_bid;
  logic [1:0]              s_bresp;
  logic [USER_WIDTH-1:0]   s_buser;
  logic                    s_bvalid;
  logic                    s_bready;
  
  logic [ID_WIDTH-1:0]     s_arid;
  logic [ADDR_WIDTH-1:0]   s_araddr;
  logic [7:0]              s_arlen;
  logic [2:0]              s_arsize;
  logic [1:0]              s_arburst;
  logic                    s_arlock;
  logic [3:0]              s_arcache;
  logic [2:0]              s_arprot;
  logic [3:0]              s_arqos;
  logic [3:0]              s_arregion;
  logic [USER_WIDTH-1:0]   s_aruser;
  logic                    s_arvalid;
  logic                    s_arready;
  
  logic [ID_WIDTH-1:0]     s_rid;
  logic [DATA_WIDTH-1:0]   s_rdata;
  logic [1:0]              s_rresp;
  logic                    s_rlast;
  logic [USER_WIDTH-1:0]   s_ruser;
  logic                    s_rvalid;
  logic                    s_rready;

  // Pass-through assignments: Master -> Slave
  assign s_awid     = m_awid;
  assign s_awaddr   = m_awaddr;
  assign s_awlen    = m_awlen;
  assign s_awsize   = m_awsize;
  assign s_awburst  = m_awburst;
  assign s_awlock   = m_awlock;
  assign s_awcache  = m_awcache;
  assign s_awprot   = m_awprot;
  assign s_awqos    = m_awqos;
  assign s_awregion = m_awregion;
  assign s_awuser   = m_awuser;
  assign s_awvalid  = m_awvalid;
  assign m_awready  = s_awready;
  
  assign s_wdata    = m_wdata;
  assign s_wstrb    = m_wstrb;
  assign s_wlast    = m_wlast;
  assign s_wuser    = m_wuser;
  assign s_wvalid   = m_wvalid;
  assign m_wready   = s_wready;
  
  assign m_bid      = s_bid;
  assign m_bresp    = s_bresp;
  assign m_buser    = s_buser;
  assign m_bvalid   = s_bvalid;
  assign s_bready   = m_bready;
  
  assign s_arid     = m_arid;
  assign s_araddr   = m_araddr;
  assign s_arlen    = m_arlen;
  assign s_arsize   = m_arsize;
  assign s_arburst  = m_arburst;
  assign s_arlock   = m_arlock;
  assign s_arcache  = m_arcache;
  assign s_arprot   = m_arprot;
  assign s_arqos    = m_arqos;
  assign s_arregion = m_arregion;
  assign s_aruser   = m_aruser;
  assign s_arvalid  = m_arvalid;
  assign m_arready  = s_arready;
  
  assign m_rid      = s_rid;
  assign m_rdata    = s_rdata;
  assign m_rresp    = s_rresp;
  assign m_rlast    = s_rlast;
  assign m_ruser    = s_ruser;
  assign m_rvalid   = s_rvalid;
  assign s_rready   = m_rready;

endmodule

`endif // GUARD_AXI_DUT_V
