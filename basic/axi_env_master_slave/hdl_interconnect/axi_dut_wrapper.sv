//=======================================================================
// AXI DUT Wrapper
// Description: Connects AXI interface to DUT module
//=======================================================================

`ifndef GUARD_AXI_DUT_WRAPPER_SV
`define GUARD_AXI_DUT_WRAPPER_SV

`include "axi_dut.v"
`include "svt_axi_if.svi"

module axi_dut_wrapper (
  svt_axi_if axi_if
);
  
  // DUT instantiation
  axi_dut #(
    .DATA_WIDTH (64),
    .ADDR_WIDTH (32),
    .ID_WIDTH   (4),
    .USER_WIDTH (8)
  ) dut (
    .aclk        (axi_if.master_if[0].internal_aclk),
    .aresetn     (axi_if.master_if[0].aresetn),
    
    // Write Address Channel
    .m_awid      (axi_if.master_if[0].awid),
    .m_awaddr    (axi_if.master_if[0].awaddr),
    .m_awlen     (axi_if.master_if[0].awlen),
    .m_awsize    (axi_if.master_if[0].awsize),
    .m_awburst   (axi_if.master_if[0].awburst),
    .m_awlock    (axi_if.master_if[0].awlock),
    .m_awcache   (axi_if.master_if[0].awcache),
    .m_awprot    (axi_if.master_if[0].awprot),
    .m_awqos     (axi_if.master_if[0].awqos),
    .m_awregion  (axi_if.master_if[0].awregion),
    .m_awuser    (axi_if.master_if[0].awuser),
    .m_awvalid   (axi_if.master_if[0].awvalid),
    .m_awready   (axi_if.master_if[0].awready),
    
    // Write Data Channel
    .m_wdata     (axi_if.master_if[0].wdata),
    .m_wstrb     (axi_if.master_if[0].wstrb),
    .m_wlast     (axi_if.master_if[0].wlast),
    .m_wuser     (axi_if.master_if[0].wuser),
    .m_wvalid    (axi_if.master_if[0].wvalid),
    .m_wready    (axi_if.master_if[0].wready),
    
    // Write Response Channel
    .m_bid       (axi_if.master_if[0].bid),
    .m_bresp     (axi_if.master_if[0].bresp),
    .m_buser     (axi_if.master_if[0].buser),
    .m_bvalid    (axi_if.master_if[0].bvalid),
    .m_bready    (axi_if.master_if[0].bready),
    
    // Read Address Channel
    .m_arid      (axi_if.master_if[0].arid),
    .m_araddr    (axi_if.master_if[0].araddr),
    .m_arlen     (axi_if.master_if[0].arlen),
    .m_arsize    (axi_if.master_if[0].arsize),
    .m_arburst   (axi_if.master_if[0].arburst),
    .m_arlock    (axi_if.master_if[0].arlock),
    .m_arcache   (axi_if.master_if[0].arcache),
    .m_arprot    (axi_if.master_if[0].arprot),
    .m_arqos     (axi_if.master_if[0].arqos),
    .m_arregion  (axi_if.master_if[0].arregion),
    .m_aruser    (axi_if.master_if[0].aruser),
    .m_arvalid   (axi_if.master_if[0].arvalid),
    .m_arready   (axi_if.master_if[0].arready),
    
    // Read Data Channel
    .m_rid       (axi_if.master_if[0].rid),
    .m_rdata     (axi_if.master_if[0].rdata),
    .m_rresp     (axi_if.master_if[0].rresp),
    .m_rlast     (axi_if.master_if[0].rlast),
    .m_ruser     (axi_if.master_if[0].ruser),
    .m_rvalid    (axi_if.master_if[0].rvalid),
    .m_rready    (axi_if.master_if[0].rready)
  );
  
  // Connect slave interface signals to DUT outputs
  // Write Address Channel
  assign axi_if.slave_if[0].awid     = axi_if.master_if[0].awid;
  assign axi_if.slave_if[0].awaddr   = axi_if.master_if[0].awaddr;
  assign axi_if.slave_if[0].awlen    = axi_if.master_if[0].awlen;
  assign axi_if.slave_if[0].awsize   = axi_if.master_if[0].awsize;
  assign axi_if.slave_if[0].awburst  = axi_if.master_if[0].awburst;
  assign axi_if.slave_if[0].awlock   = axi_if.master_if[0].awlock;
  assign axi_if.slave_if[0].awcache  = axi_if.master_if[0].awcache;
  assign axi_if.slave_if[0].awprot   = axi_if.master_if[0].awprot;
  assign axi_if.slave_if[0].awqos    = axi_if.master_if[0].awqos;
  assign axi_if.slave_if[0].awregion = axi_if.master_if[0].awregion;
  assign axi_if.slave_if[0].awuser   = axi_if.master_if[0].awuser;
  assign axi_if.slave_if[0].awvalid  = axi_if.master_if[0].awvalid;
  assign axi_if.master_if[0].awready = axi_if.slave_if[0].awready;
  
  // Write Data Channel
  assign axi_if.slave_if[0].wdata    = axi_if.master_if[0].wdata;
  assign axi_if.slave_if[0].wstrb    = axi_if.master_if[0].wstrb;
  assign axi_if.slave_if[0].wlast    = axi_if.master_if[0].wlast;
  assign axi_if.slave_if[0].wuser    = axi_if.master_if[0].wuser;
  assign axi_if.slave_if[0].wvalid   = axi_if.master_if[0].wvalid;
  assign axi_if.master_if[0].wready  = axi_if.slave_if[0].wready;
  
  // Write Response Channel
  assign axi_if.master_if[0].bid     = axi_if.slave_if[0].bid;
  assign axi_if.master_if[0].bresp   = axi_if.slave_if[0].bresp;
  assign axi_if.master_if[0].buser   = axi_if.slave_if[0].buser;
  assign axi_if.master_if[0].bvalid  = axi_if.slave_if[0].bvalid;
  assign axi_if.slave_if[0].bready   = axi_if.master_if[0].bready;
  
  // Read Address Channel
  assign axi_if.slave_if[0].arid     = axi_if.master_if[0].arid;
  assign axi_if.slave_if[0].araddr   = axi_if.master_if[0].araddr;
  assign axi_if.slave_if[0].arlen    = axi_if.master_if[0].arlen;
  assign axi_if.slave_if[0].arsize   = axi_if.master_if[0].arsize;
  assign axi_if.slave_if[0].arburst  = axi_if.master_if[0].arburst;
  assign axi_if.slave_if[0].arlock   = axi_if.master_if[0].arlock;
  assign axi_if.slave_if[0].arcache  = axi_if.master_if[0].arcache;
  assign axi_if.slave_if[0].arprot   = axi_if.master_if[0].arprot;
  assign axi_if.slave_if[0].arqos    = axi_if.master_if[0].arqos;
  assign axi_if.slave_if[0].arregion = axi_if.master_if[0].arregion;
  assign axi_if.slave_if[0].aruser   = axi_if.master_if[0].aruser;
  assign axi_if.slave_if[0].arvalid  = axi_if.master_if[0].arvalid;
  assign axi_if.master_if[0].arready = axi_if.slave_if[0].arready;
  
  // Read Data Channel
  assign axi_if.master_if[0].rid     = axi_if.slave_if[0].rid;
  assign axi_if.master_if[0].rdata   = axi_if.slave_if[0].rdata;
  assign axi_if.master_if[0].rresp   = axi_if.slave_if[0].rresp;
  assign axi_if.master_if[0].rlast   = axi_if.slave_if[0].rlast;
  assign axi_if.master_if[0].ruser   = axi_if.slave_if[0].ruser;
  assign axi_if.master_if[0].rvalid  = axi_if.slave_if[0].rvalid;
  assign axi_if.slave_if[0].rready   = axi_if.master_if[0].rready;
  
  // Clock and reset connections
  assign axi_if.common_aclk = axi_if.master_if[0].internal_aclk;
  assign axi_if.master_if[0].aresetn = axi_if.slave_if[0].aresetn;
  
endmodule

`endif // GUARD_AXI_DUT_WRAPPER_SV
