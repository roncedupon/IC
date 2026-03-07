`timescale 1ns/1ps

module nsu_ibus_mux(/*autoarg*/
    // Inputs
    clk, rst_n,
    read_resp_que0_start_addr,
    read_resp_que1_start_addr,
    read_resp_que2_start_addr,
    read_resp_que3_start_addr,
    read_resp_que0_len,
    read_resp_que1_len,
    read_resp_que2_len,
    read_resp_que3_len,
    io_rd_req_que0_start_addr,
    io_rd_req_que1_start_addr,
    io_rd_req_que2_start_addr,
    io_rd_req_que3_start_addr,
    io_rd_req_que1_len,
    io_rd_req_que0_len,
    io_rd_req_que2_len,
    io_rd_req_que3_len, rcen,
    raddr, wcen, bwen, waddr,
    wdata, bus_rdata,
    bus_rdata_vld,
    read_resp_sram_rdat,
    read_resp_sram_rdat_vld,
    tcp2ncpu_sram_rdat,
    tcp2ncpu_sram_rdat_vld,
    io_wr_addr_resp_sram_rdat,
    io_wr_addr_resp_sram_rdat_vld,
    msa_resp_sram_rdat,
    msa_resp_sram_rdat_vld,
    io_write_sram_rdat,
    io_write_sram_rdat_vld,
    io_rd_req_sram_rdat,
    io_rd_req_sram_rdat_vld,
    deep_resp_sram_rdat,
    deep_resp_sram_rdat_vld,
    // Outputs
    rdata, rdata_vld, bus_waddr,
    bus_raddr, bus_wr, bus_rd,
    bus_wdata, bus_strb,
    ncpu2tcp_sram_wren,
    ncpu2tcp_sram_wdat,
    ncpu2tcp_sram_waddr,
    io_wr_resp_sram_wren,
    io_wr_resp_sram_wdat,
    io_wr_resp_sram_waddr,
    io_wr_addr_sram_wren,
    io_wr_addr_sram_wdat,
    io_wr_addr_sram_waddr,
    sw_unmap_sram_cen,
    sw_unmap_sram_wr,
    sw_unmap_sram_wdat,
    sw_unmap_sram_waddr,
    msa_wr_sram_cen,
    msa_wr_sram_wr,
    msa_wr_sram_wdat,
    msa_wr_sram_waddr,
    read_resp_sram_rden,
    read_resp_sram_raddr,
    tcp2ncpu_sram_rden,
    tcp2ncpu_sram_raddr,
    io_wr_addr_resp_sram_rden,
    io_wr_addr_resp_sram_raddr,
    msa_resp_sram_rden,
    msa_resp_sram_raddr,
    io_write_sram_rden,
    io_write_sram_raddr,
    io_rd_req_sram_rden,
    io_rd_req_sram_raddr,
    deep_resp_sram_rden,
    deep_resp_sram_raddr,
    act_read_resp_que0_len,
    act_read_resp_que1_len,
    act_read_resp_que2_len,
    act_read_resp_que3_len,
    act_io_rd_req_que0_start_addr,
    act_io_rd_req_que1_start_addr,
    act_io_rd_req_que2_start_addr,
    act_io_rd_req_que3_start_addr,
    act_io_rd_req_que0_len,
    act_io_rd_req_que1_len,
    act_io_rd_req_que2_len,
    act_io_rd_req_que3_len
);

//============================Parameter============================
parameter ADDR_WIDTH        = 15 ;
parameter DATA_WIDTH        = 32 ;
parameter READ_RCMD_ADDR    = 7;
parameter READ_RESP_ADDR    = 7;
parameter DEEP_RESP_ADDR    = 11;
parameter CPU_ADDR          = 4;
parameter WOUTS_WH          = 4;
parameter IO_RD_REQ_PTR_WH  = 5;
parameter SW_UNMAP_ADDR     = 4;
parameter MSA_WR_ADDR       = 6;
parameter MSA_RESP_ADDR     = 3;
parameter IO_WR_REQ_ADDR    = 6;

//============================In/Out Signal============================
// cfg signals
input  clk;
input  rst_n;
input  [READ_RESP_ADDR-1:0]  read_resp_que0_start_addr;
input  [READ_RESP_ADDR-1:0]  read_resp_que1_start_addr;
input  [READ_RESP_ADDR-1:0]  read_resp_que2_start_addr;
input  [READ_RESP_ADDR-1:0]  read_resp_que3_start_addr;
input  [READ_RESP_ADDR-0:0]  read_resp_que0_len;
input  [READ_RESP_ADDR-0:0]  read_resp_que1_len;
input  [READ_RESP_ADDR-0:0]  read_resp_que2_len;
input  [READ_RESP_ADDR-0:0]  read_resp_que3_len;
input  [IO_RD_REQ_PTR_WH-1:0] io_rd_req_que0_start_addr;
input  [IO_RD_REQ_PTR_WH-1:0] io_rd_req_que1_start_addr;
input  [IO_RD_REQ_PTR_WH-1:0] io_rd_req_que2_start_addr;
input  [IO_RD_REQ_PTR_WH-1:0] io_rd_req_que3_start_addr;
input  [IO_RD_REQ_PTR_WH-0:0] io_rd_req_que1_len;
input  [IO_RD_REQ_PTR_WH-0:0] io_rd_req_que0_len;
input  [IO_RD_REQ_PTR_WH-0:0] io_rd_req_que2_len;
input  [IO_RD_REQ_PTR_WH-0:0] io_rd_req_que3_len;

// axi2sram signals
input  rcen;
input  [ADDR_WIDTH-1:0]  raddr;
input  wcen;
input  [DATA_WIDTH-1:0]  bwen;
input  [ADDR_WIDTH-1:0]  waddr;
input  [DATA_WIDTH-1:0]  wdata;
output [DATA_WIDTH-1:0]  rdata;
output                   rdata_vld;

// ibus signals
output reg [11:0]  bus_waddr;
output reg [11:0]  bus_raddr;
output reg         bus_wr;
output reg [DATA_WIDTH-1:0]  bus_rd;
output reg [DATA_WIDTH-1:0]  bus_wdata;
output reg [DATA_WIDTH-1:0]  bus_strb;
input  [DATA_WIDTH-1:0]  bus_rdata;
input  bus_rdata_vld;

// nsu cpu to tsu cpu que
output reg         ncpu2tcp_sram_wren;
output reg [DATA_WIDTH-1:0]  ncpu2tcp_sram_wdat;
output reg [CPU_ADDR-1:0]  ncpu2tcp_sram_waddr;

// io write resp que
output reg         io_wr_resp_sram_wren;
output reg [WOUTS_WH-1:0]  io_wr_resp_sram_wdat;
output reg [WOUTS_WH-1:0]  io_wr_resp_sram_waddr;

// io write addr que
output reg         io_wr_addr_sram_wren;
output reg [DATA_WIDTH-1:0]  io_wr_addr_sram_wdat;
output reg [WOUTS_WH-0:0]  io_wr_addr_sram_waddr;

// sw unmap req
output reg         sw_unmap_sram_cen;
output reg         sw_unmap_sram_wr;
output reg [DATA_WIDTH-1:0]  sw_unmap_sram_wdat;
output reg [SW_UNMAP_ADDR-1:0]  sw_unmap_sram_waddr;

// msa req queue
output reg         msa_wr_sram_cen;
output reg         msa_wr_sram_wr;
output reg [DATA_WIDTH-1:0]  msa_wr_sram_wdat;
output reg [MSA_WR_ADDR-1:0]  msa_wr_sram_waddr;

// read resp queue
output reg         read_resp_sram_rden;
output reg [READ_RESP_ADDR-1:0]  read_resp_sram_raddr;
input  [DATA_WIDTH-1:0]  read_resp_sram_rdat;
input  read_resp_sram_rdat_vld;

// tsu cpu to nsu cpu que
output reg         tcp2ncpu_sram_rden;
output reg [CPU_ADDR-1:0]  tcp2ncpu_sram_raddr;
input  [DATA_WIDTH-1:0]  tcp2ncpu_sram_rdat;
input  tcp2ncpu_sram_rdat_vld;

// io write addr resp que
output reg         io_wr_addr_resp_sram_rden;
output reg [WOUTS_WH-1:0]  io_wr_addr_resp_sram_raddr;
input  [15:0]  io_wr_addr_resp_sram_rdat;
input  io_wr_addr_resp_sram_rdat_vld;

// msa resp queue
output reg         msa_resp_sram_rden;
output reg [MSA_RESP_ADDR-1:0]  msa_resp_sram_raddr;
input  [15:0]  msa_resp_sram_rdat;
input  msa_resp_sram_rdat_vld;

// io write req que
output reg         io_write_sram_rden;
output reg [IO_WR_REQ_ADDR-1:0]  io_write_sram_raddr;
input  [DATA_WIDTH-1:0]  io_write_sram_rdat;
input  io_write_sram_rdat_vld;

// io read req que
output reg         io_rd_req_sram_rden;
output reg [READ_RCMD_ADDR-1:0]  io_rd_req_sram_raddr;
input  [DATA_WIDTH-1:0]  io_rd_req_sram_rdat;
input  io_rd_req_sram_rdat_vld;

// deep read resp queue
output reg         deep_resp_sram_rden;
output reg [DEEP_RESP_ADDR:0]  deep_resp_sram_raddr;
input  [DATA_WIDTH-1:0]  deep_resp_sram_rdat;
input  deep_resp_sram_rdat_vld;

// act queue signals
output reg [READ_RESP_ADDR-1:0]  act_read_resp_que0_len;
output reg [READ_RESP_ADDR-1:0]  act_read_resp_que1_len;
output reg [READ_RESP_ADDR-1:0]  act_read_resp_que2_len;
output reg [READ_RESP_ADDR-1:0]  act_read_resp_que3_len;
output reg [READ_RCMD_ADDR-1:0]  act_io_rd_req_que0_start_addr;
output reg [READ_RCMD_ADDR-1:0]  act_io_rd_req_que1_start_addr;
output reg [READ_RCMD_ADDR-1:0]  act_io_rd_req_que2_start_addr;
output reg [READ_RCMD_ADDR-1:0]  act_io_rd_req_que3_start_addr;
output reg [IO_RD_REQ_PTR_WH-1:0]  act_io_rd_req_que0_len;
output reg [IO_RD_REQ_PTR_WH-1:0]  act_io_rd_req_que1_len;
output reg [IO_RD_REQ_PTR_WH-1:0]  act_io_rd_req_que2_len;
output reg [IO_RD_REQ_PTR_WH-1:0]  act_io_rd_req_que3_len;

//============================Wire/Reg SIGNAL============================
/*autowire*/
wire [ADDR_WIDTH-11:0]  write_addr;
wire [ADDR_WIDTH-11:0]  read_addr;
wire                    axi_rden;
reg  [3:0]              pipe_en;
wire                    write_queue_en;
wire [31:0]             rdat_mux;
wire                    cfg_wr_rd_en;
wire [5:0]              cfg_wr_rd_en_dly;
wire                    nsu_ibus_mux_idle;

//============================Process============================
assign nsu_ibus_mux_idle = cfg_wr_rd_en == 1'b0 && cfg_wr_rd_en_dly == 1'b0;
assign cfg_wr_rd_en = (rcen == 1'b0) | (wcen == 1'b0);

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        cfg_wr_rd_en_dly <= 'd0;
    else
        cfg_wr_rd_en_dly <= {cfg_wr_rd_en_dly[4:0],cfg_wr_rd_en};
end

assign write_addr = waddr[ADDR_WIDTH-1:10];
assign read_addr  = raddr[ADDR_WIDTH-1:10];
assign axi_rden   = !rcen;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        pipe_en <= 'd0;
    else
        pipe_en <= {pipe_en[2:0],axi_rden};
end

// regfile
wire ibus_wren ;
wire ibus_rden ;
assign ibus_wren = (write_addr == 'd0) && (wcen == 1'b0);
assign ibus_rden = (read_addr == 'd0) && axi_rden;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        bus_wr <= 1'b0;
    else
        bus_wr <= ibus_wren;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        bus_waddr <= 'd0;
    else if(ibus_wren)
        bus_waddr <= {waddr[9:0],2'd0};
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        bus_wdata <= 'd0;
    else if(ibus_wren)
        bus_wdata <= wdata;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        bus_strb <= 'd0;
    else if(ibus_wren)
        bus_strb <= bwen;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        bus_rd <= 1'b0;
    else
        bus_rd <= ibus_rden;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        bus_raddr <= 'd0;
    else if(ibus_rden)
        bus_raddr <= {raddr[9:0],2'b0};
end

// assign bus_wr = (write_addr == 'd0) && (wcen == 1'b0);
// assign bus_waddr = bus_wr ? {waddr[9:0],2'd0} : 'd0;
// assign bus_wdata = bus_wr ? wdata : 'd0;
// assign bus_strb  = bus_wr ? bwen : 'd0;
// assign bus_rd    = (read_addr == 'd0) & pipe_en[2];
// assign bus_raddr = bus_rd ? {raddr[9:0],2'b0} : 'd0;

assign write_queue_en = (write_addr == 'd1) && (wcen == 1'b0);

// nsu cpu to tsu cpu que
// assign ncpu2tcp_sram_wren = write_queue_en & (waddr[9:4] == 'd0);
// assign ncpu2tcp_sram_waddr = waddr[3:0];
// assign ncpu2tcp_sram_wdat  = wdata;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        ncpu2tcp_sram_wren <= 1'b1;
    else if(write_queue_en && (waddr[9:4] == 'd0))
        ncpu2tcp_sram_wren <= 1'b0;
    else
        ncpu2tcp_sram_wren <= 1'b1;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        ncpu2tcp_sram_waddr <= 'd0;
    else if(write_queue_en && (waddr[9:4] == 'd0))
        ncpu2tcp_sram_waddr <= waddr[3:0];
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        ncpu2tcp_sram_wdat <= 'd0;
    else if(write_queue_en && (waddr[9:4] == 'd0))
        ncpu2tcp_sram_wdat <= wdata;
end

// io write resp que
// assign io_wr_resp_sram_wren = write_queue_en & (waddr[9:4] == 'd1);
// assign io_wr_resp_sram_waddr = waddr[WOUTS_WH-1:0];
// assign io_wr_resp_sram_wdat  = wdata[WOUTS_WH-1:0];

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        io_wr_resp_sram_wren <= 1'b1;
    else if(write_queue_en && (waddr[9:4] == 'd1))
        io_wr_resp_sram_wren <= 1'b0;
    else
        io_wr_resp_sram_wren <= 1'b1;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        io_wr_resp_sram_waddr <= 'd0;
    else if(write_queue_en && (waddr[9:4] == 'd1))
        io_wr_resp_sram_waddr <= waddr[WOUTS_WH-1:0];
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        io_wr_resp_sram_wdat <= 'd0;
    else if(write_queue_en && (waddr[9:4] == 'd1))
        io_wr_resp_sram_wdat <= wdata[WOUTS_WH-1:0];
end

// io write addr que
// assign io_wr_addr_sram_wren = write_queue_en & (waddr[9:4] == 'd2 || waddr[9:4] == 'd3);
// assign io_wr_addr_sram_waddr = waddr[WOUTS_WH:0];
// assign io_wr_addr_sram_wdat  = wdata;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        io_wr_addr_sram_wren <= 1'b0;
    else if(write_queue_en && (waddr[9:4] == 'd2 || waddr[9:4] == 'd3))
        io_wr_addr_sram_wren <= 1'b1;
    else
        io_wr_addr_sram_wren <= 1'b0;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        io_wr_addr_sram_waddr <= 'd0;
    else if(write_queue_en && (waddr[9:4] == 'd2 || waddr[9:4] == 'd3))
        io_wr_addr_sram_waddr <= waddr[WOUTS_WH:0];
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        io_wr_addr_sram_wdat <= 'd0;
    else if(write_queue_en && (waddr[9:4] == 'd2 || waddr[9:4] == 'd3))
        io_wr_addr_sram_wdat <= wdata;
end

// sw unmap req
assign sw_unmap_sram_cen  = !sw_unmap_sram_wr;
assign sw_unmap_sram_wr   = write_queue_en & (waddr[9:4] == 'd5 || waddr[9:4] == 'd4);
assign sw_unmap_sram_waddr= waddr[SW_UNMAP_ADDR-1:0];
assign sw_unmap_sram_wdat = wdata;

// msa req queue
assign msa_wr_sram_cen  = !msa_wr_sram_wr;
assign msa_wr_sram_wr   = write_queue_en & (waddr[9:4] == 'd7 || waddr[9:4] == 'd6);
assign msa_wr_sram_waddr= waddr[MSA_WR_ADDR-1:0];
assign msa_wr_sram_wdat = wdata;

// read resp queue
assign read_resp_sram_rden  = axi_rden & (read_addr == 'd1) & (raddr[9:7]=='d1);
assign read_resp_sram_raddr = raddr[READ_RESP_ADDR-1:0];

// tsu cpu to nsu cpu que
// assign tcp2ncpu_sram_rden = axi_rden & (read_addr == 'd1) & (raddr[9:7]=='d2 & raddr[6:4] == 'd0);
// assign tcp2ncpu_sram_raddr = raddr[CPU_ADDR-1:0];

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        tcp2ncpu_sram_rden <= 1'b1;
    else if(axi_rden & (read_addr == 'd1) & (raddr[9:7]=='d2 & raddr[6:4] == 'd0))
        tcp2ncpu_sram_rden <= 1'b0;
    else
        tcp2ncpu_sram_rden <= 1'b1;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        tcp2ncpu_sram_raddr <= 'd0;
    else if(axi_rden & (read_addr == 'd1) & (raddr[9:7]=='d2 & raddr[6:4] == 'd0))
        tcp2ncpu_sram_raddr <= raddr[CPU_ADDR-1:0];
end

// io write addr resp que
// assign io_wr_addr_resp_sram_rden = axi_rden & (read_addr == 'd1) & (raddr[9:7]=='d2 & raddr[6:4] == 'd1);
// assign io_wr_addr_resp_sram_raddr = raddr[CPU_ADDR-1:0];

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        io_wr_addr_resp_sram_rden <= 1'b1;
    else if(axi_rden & (read_addr == 'd1) & (raddr[9:7]=='d2 & raddr[6:4] == 'd1))
        io_wr_addr_resp_sram_rden <= 1'b0;
    else
        io_wr_addr_resp_sram_rden <= 1'b1;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        io_wr_addr_resp_sram_raddr <= 'd0;
    else if(axi_rden & (read_addr == 'd1) & (raddr[9:7]=='d2 & raddr[6:4] == 'd1))
        io_wr_addr_resp_sram_raddr <= raddr[CPU_ADDR-1:0];
end

// msa resp queue
// assign msa_resp_sram_rden = axi_rden & (read_addr == 'd1) & (raddr[9:7]=='d2 & raddr[6:4] == 'd2 & raddr[3]==1'b0);
// assign msa_resp_sram_raddr = raddr[MSA_RESP_ADDR-1:0];

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        msa_resp_sram_rden <= 1'b1;
    else if(axi_rden & (read_addr == 'd1) & (raddr[9:7]=='d2 & raddr[6:4] == 'd2 & raddr[3]==1'b0))
        msa_resp_sram_rden <= 1'b0;
    else
        msa_resp_sram_rden <= 1'b1;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        msa_resp_sram_raddr <= 'd0;
    else if(axi_rden & (read_addr == 'd1) & (raddr[9:7]=='d2 & raddr[6:4] == 'd2 & raddr[3]==1'b0))
        msa_resp_sram_raddr <= raddr[MSA_RESP_ADDR-1:0];
end

// io write req que
assign io_write_sram_rden  = axi_rden & (read_addr == 'd2) & (raddr[9:0]>='d0 & raddr[9:0] <= 'h30);
assign io_write_sram_raddr = raddr[IO_WR_REQ_ADDR-1:0];

// io read req que
assign io_rd_req_sram_rden  = axi_rden & (read_addr == 'd3) & (raddr[9:0]>='d0 & raddr[9:0] <= 'h60);
assign io_rd_req_sram_raddr = raddr[READ_RCMD_ADDR-1:0];

// deep resp req que
// assign deep_resp_sram_rden = axi_rden & (raddr[ADDR_WIDTH-1:0]>='h1000 & raddr[13-1:0] <= 'h1bec);
// assign deep_resp_sram_raddr = raddr[DEEP_RESP_ADDR:0];

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        deep_resp_sram_rden <= 1'b0;
    else if(axi_rden & (raddr[ADDR_WIDTH-1:0]>='h1000 & raddr[13-1:0] <= 'h1bec))
        deep_resp_sram_rden <= 1'b1;
    else
        deep_resp_sram_rden <= 1'b0;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        deep_resp_sram_raddr <= 'd0;
    else if(axi_rden & (raddr[ADDR_WIDTH-1:0]>='h1000 & raddr[13-1:0] <= 'h1bec))
        deep_resp_sram_raddr <= raddr[DEEP_RESP_ADDR:0];
end

assign rdat_mux = bus_rdata_vld ? bus_rdata :
                  read_resp_sram_rdat_vld ? read_resp_sram_rdat :
                  tcp2ncpu_sram_rdat_vld ? tcp2ncpu_sram_rdat :
                  io_wr_addr_resp_sram_rdat_vld ? {16'd0,io_wr_addr_resp_sram_rdat} :
                  msa_resp_sram_rdat_vld ? {16'd0,msa_resp_sram_rdat} :
                  io_write_sram_rdat_vld ? io_write_sram_rdat :
                  io_rd_req_sram_rdat_vld ? io_rd_req_sram_rdat :
                  deep_resp_sram_rdat_vld ? deep_resp_sram_rdat : 'd0;

assign rdata = rdat_mux;
assign rdata_vld = pipe_en[3];

assign act_read_resp_que0_len = read_resp_que0_len == 'd0 ? 'd0 : (read_resp_que0_len - 1'b1);
assign act_read_resp_que1_len = read_resp_que1_len == 'd0 ? 'd0 : (read_resp_que1_len - 1'b1);
assign act_read_resp_que2_len = read_resp_que2_len == 'd0 ? 'd0 : (read_resp_que2_len - 1'b1);
assign act_read_resp_que3_len = read_resp_que3_len == 'd0 ? 'd0 : (read_resp_que3_len - 1'b1);

assign act_io_rd_req_que0_len = io_rd_req_que0_len == 'd0 ? 'd0 : (io_rd_req_que0_len - 1'b1);
assign act_io_rd_req_que1_len = io_rd_req_que1_len == 'd0 ? 'd0 : (io_rd_req_que1_len - 1'b1);
assign act_io_rd_req_que2_len = io_rd_req_que2_len == 'd0 ? 'd0 : (io_rd_req_que2_len - 1'b1);
assign act_io_rd_req_que3_len = io_rd_req_que3_len == 'd0 ? 'd0 : (io_rd_req_que3_len - 1'b1);

// assign act_io_rd_req_que0_len = io_rd_req_que1_len;
// assign act_io_rd_req_que1_len = io_rd_req_que2_len;
// assign act_io_rd_req_que2_len = io_rd_req_que2_len;
// assign act_io_rd_req_que3_len = io_rd_req_que3_len;

endmodule