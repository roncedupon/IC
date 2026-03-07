`include "uvm_pkg.sv"
module nsu_write_meta_ctrl #(
    parameter DATA_WIDTH    = 256,
    parameter ADDR_WIDTH    = 34,
    parameter BLEN_WIDTH    = 9,
    parameter ID_WIDTH      = 10,
    parameter STRB_WIDTH    = DATA_WIDTH/8
)(
    input                   clk,
    input                   rst_n,
    input                   start,
    output reg              done,
    input      [31:0]       meta0_addr,
    input      [31:0]       metal_addr,
    input      [7:0]        plane_sel,
    input      [31:0]       meta_data0,
    input      [7:0]        meta_data1,
    input      [31:0]       meta_data2,
    input      [7:0]        meta_data3,
    output reg              lm_wreq,
    input                   lm_wack,
    output     [ID_WIDTH-1:0]   lm_wid,
    output     [BLEN_WIDTH-1:0] lm_wlen,
    output     [ADDR_WIDTH-1:0] lm_waddr,
    input                   lm_wvld,
    output reg [DATA_WIDTH-1:0] lm_wdat,
    output reg              lm_wdat_last,
    output reg [STRB_WIDTH-1:0] lm_wmask,
    input      [ID_WIDTH-1:0]   lm_wdone_id,
    input                   lm_wdone_id_vld
);

//----------------------------------
// Parameter
//----------------------------------
localparam IDLE_STATE        = 4'd0;
localparam JUDGE0_STATE      = 4'd1;
localparam META_DATA0_STATE  = 4'd2;
localparam JUDGE1_STATE      = 4'd3;
localparam META_DATA1_STATE  = 4'd4;
localparam DONE_STATE        = 4'd5;
localparam AXI_AW_WH         = ADDR_WIDTH + BLEN_WIDTH;
localparam AXI_DATA_WIDTH    = DATA_WIDTH + STRB_WIDTH + 1;
localparam MASK_WIDTH        = STRB_WIDTH/2;

//----------------------------------
// Wire/Reg SIGNAL
//----------------------------------
reg         [3:0]           cur_state;
reg         [3:0]           nxt_state;
reg         [2:0]           start_dly;
reg         [2:0]           group0_num;
reg         [2:0]           group1_num;
wire        [127:0]         wr_meta_data      [7:0];
reg         [7:0]           wr_cnt;
reg                         meta_axi_awfifo_wren;
wire                        meta_axi_awfifo_rden;
wire        [AXI_AW_WH-1:0] meta_axi_awfifo_wdat;
wire        [AXI_AW_WH-1:0] meta_axi_awfifo_rdat;
wire                        meta_axi_awfifo_full;
wire                        meta_axi_awfifo_empty;
reg         [511:0]         group0_meta_dat;
reg         [511:0]         group1_meta_dat;
reg         [1:0]           group0_axi_len;
reg         [1:0]           group1_axi_len;
wire                        resp_cnt;
reg         [5:0]           axi_cnt;
reg         [5:0]           group0_mask;
reg         [5:0]           group1_mask;
wire        [767:0]         group0_dat;
wire        [767:0]         group1_dat;
reg                         meta_dat_fifo_wren;
wire                        meta_dat_fifo_rden;
wire        [AXI_DATA_WIDTH-1:0] meta_dat_fifo_wdat;
wire        [AXI_DATA_WIDTH-1:0] meta_dat_fifo_rdat;
wire                        meta_dat_fifo_full;
wire                        meta_dat_fifo_empty;
reg         [DATA_WIDTH-1:0] dat_temp;
reg         [1:0]           mask_temp;

genvar i;
integer j;

//----------------------------------
// Process
//----------------------------------
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        start_dly <= 1'b0;
    else
        start_dly <= start;
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        cur_state <= IDLE_STATE;
    else
        cur_state <= nxt_state;
end

always@(*) begin
    case(cur_state)
        IDLE_STATE:
            if(start_dly)
                nxt_state = JUDGE0_STATE;
            else
                nxt_state = IDLE_STATE;
        JUDGE0_STATE:
            if(!meta_axi_awfifo_full)begin
                if(|plane_sel[3:0])
                    nxt_state = META_DATA0_STATE;
                else
                    nxt_state = META_DATA1_STATE;
            end
            else
                nxt_state = JUDGE0_STATE;
        META_DATA0_STATE:
            if((wr_cnt == group0_axi_len) & meta_dat_fifo_wren)begin
                if(|plane_sel[7:4])
                    nxt_state = JUDGE1_STATE;
                else
                    nxt_state = DONE_STATE;
            end
            else
                nxt_state = META_DATA0_STATE;
        JUDGE1_STATE:
            if(!meta_axi_awfifo_full)begin
                nxt_state = META_DATA1_STATE;
            end
            else
                nxt_state = JUDGE1_STATE;
        META_DATA1_STATE:
            if((wr_cnt == group1_axi_len) & meta_dat_fifo_wren)
                nxt_state = DONE_STATE;
            else
                nxt_state = META_DATA1_STATE;
        DONE_STATE:
            if(axi_cnt == resp_cnt)
                nxt_state = IDLE_STATE;
            else
                nxt_state = DONE_STATE;
        default:nxt_state = IDLE_STATE;
    endcase
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        axi_cnt <= 'd0;
    else if((cur_state == DONE_STATE & nxt_state == IDLE_STATE))
        axi_cnt <= 'd0;
    else if(lm_wdone_id_vld & lm_wdone_id == 'd1)
        axi_cnt <= axi_cnt + 1'b1;
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        wr_cnt <= 'd0;
    else if((cur_state == DONE_STATE & nxt_state == IDLE_STATE) | (cur_state == META_DATA0_STATE & nxt_state == JUDGE1_STATE))
        wr_cnt <= 'd0;
    else if(meta_dat_fifo_wren)
        wr_cnt <= wr_cnt + 1'b1;
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        meta_axi_awfifo_wren <= 1'b0;
    else if((cur_state == JUDGE0_STATE & (nxt_state == META_DATA0_STATE | nxt_state == META_DATA1_STATE)))
        meta_axi_awfifo_wren <= 1'b1;
    else
        meta_axi_awfifo_wren <= 1'b0;
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        meta_axi_awfifo_wdat <= 'd0;
    else if((cur_state == JUDGE0_STATE & nxt_state == META_DATA0_STATE))begin
        meta_axi_awfifo_wdat[ADDR_WIDTH-1:0] <= {2'd0,meta0_addr};
        meta_axi_awfifo_wdat[BLEN_WIDTH+ADDR_WIDTH-1:ADDR_WIDTH] <= {7'd0,group0_axi_len};
    end
    else if((cur_state == JUDGE0_STATE & nxt_state == META_DATA1_STATE) | (cur_state == JUDGE1_STATE))begin
        meta_axi_awfifo_wdat[ADDR_WIDTH-1:0] <= {2'd0,metal_addr};
        meta_axi_awfifo_wdat[BLEN_WIDTH+ADDR_WIDTH-1:ADDR_WIDTH] <= {7'd0,group0_axi_len}; // Note: Original code uses group0_axi_len here, may be a typo for group1_axi_len
    end
end

assign lm_wid    = 'd1;
assign lm_wlen   = meta_axi_awfifo_rdat[BLEN_WIDTH+ADDR_WIDTH-1:ADDR_WIDTH];
assign lm_waddr  = meta_axi_awfifo_rdat[ADDR_WIDTH-1:0];
assign meta_axi_awfifo_rden = lm_wreq & lm_wack;
assign lm_wreq = !meta_axi_awfifo_empty;

witmem_sfifo_depth2 #(/*autoinstparam*/
    .FIFO_WIDTH     (AXI_AW_WH          ),
    .BETTER_TIMING  (1'b0              )
)
u0_meta_axi_awfifo(/*autoinst*/
    .clk            (clk               ), //input
    .rst_n          (rst_n             ), //input
    .fifo_clr       (1'b00             ), //input
    .fifo_req_w     (meta_axi_awfifo_wren), //input
    .fifo_req_r     (meta_axi_awfifo_rden), //input
    .fifo_wdata     (meta_axi_awfifo_wdat), //input
    .fifo_rdata     (meta_axi_awfifo_rdat), //output
    .fifo_full      (meta_axi_awfifo_full), //output
    .fifo_empty     (meta_axi_awfifo_empty)  //output
);

generate
    for(i=0;i<8;i=i+1)begin
        assign wr_meta_data[i] = {meta_data3[i],meta_data2[i],meta_data1[i],meta_data0[i]};
    end
endgenerate

assign meta_dat_fifo_wren = (cur_state == META_DATA0_STATE) | (cur_state == META_DATA1_STATE) & !meta_dat_fifo_full;
assign resp_cnt = (group0_axi_len != 'd0 & group0_axi_len != 'd0) ? 'd2 : 'd1; // Note: Original code has redundant check group0_axi_len != 'd0, may be a typo

// get group0 enable number
always@(*) begin
    group0_num = 3'b0;
    for(j=0;j<4;j=j+1)begin
        if(plane_sel[j])begin
            group0_num = group0_num + 1'b1;
        end
    end
end

// get group1 enable number
always@(*) begin
    group1_num = 3'b0;
    for(j=4;j<8;j=j+1)begin
        if(plane_sel[j])begin
            group1_num = group1_num + 1'b1;
        end
    end
end

always@(posedge clk) begin
    if(start_dly)begin
        case(plane_sel[3:0])
            4'b0001:group0_meta_dat <= {384'd0,wr_meta_data[0]};
            4'b0010:group0_meta_dat <= {384'd0,wr_meta_data[1]};
            4'b0011:group0_meta_dat <= {256'd0,wr_meta_data[1],wr_meta_data[0]};
            4'b0100:group0_meta_dat <= {384'd0,wr_meta_data[2]};
            4'b0101:group0_meta_dat <= {256'd0,wr_meta_data[2],wr_meta_data[0]};
            4'b0110:group0_meta_dat <= {256'd0,wr_meta_data[2],wr_meta_data[1]};
            4'b0111:group0_meta_dat <= {128'd0,wr_meta_data[2],wr_meta_data[1],wr_meta_data[0]};
            4'b1000:group0_meta_dat <= {384'd0,wr_meta_data[3]};
            4'b1001:group0_meta_dat <= {256'd0,wr_meta_data[3],wr_meta_data[0]};
            4'b1010:group0_meta_dat <= {256'd0,wr_meta_data[3],wr_meta_data[1]};
            4'b1011:group0_meta_dat <= {128'd0,wr_meta_data[3],wr_meta_data[1],wr_meta_data[0]};
            4'b1100:group0_meta_dat <= {256'd0,wr_meta_data[3],wr_meta_data[2]};
            4'b1101:group0_meta_dat <= {128'd0,wr_meta_data[3],wr_meta_data[2],wr_meta_data[0]};
            4'b1110:group0_meta_dat <= {128'd0,wr_meta_data[3],wr_meta_data[2],wr_meta_data[1]};
            4'b1111:group0_meta_dat <= {wr_meta_data[3],wr_meta_data[2],wr_meta_data[1],wr_meta_data[0]};
            default:group0_meta_dat <= 512'd0;
        endcase
    end
end

always@(posedge clk) begin
    if(start_dly)begin
        case(plane_sel[7:4])
            4'b0001:group1_meta_dat <= {384'd0,wr_meta_data[4]};
            4'b0010:group1_meta_dat <= {384'd0,wr_meta_data[5]};
            4'b0011:group1_meta_dat <= {256'd0,wr_meta_data[5],wr_meta_data[4]};
            4'b0100:group1_meta_dat <= {384'd0,wr_meta_data[6]};
            4'b0101:group1_meta_dat <= {256'd0,wr_meta_data[6],wr_meta_data[4]};
            4'b0110:group1_meta_dat <= {256'd0,wr_meta_data[6],wr_meta_data[5]};
            4'b0111:group1_meta_dat <= {128'd0,wr_meta_data[6],wr_meta_data[5],wr_meta_data[4]};
            4'b1000:group1_meta_dat <= {384'd0,wr_meta_data[7]};
            4'b1001:group1_meta_dat <= {256'd0,wr_meta_data[7],wr_meta_data[4]};
            4'b1010:group1_meta_dat <= {256'd0,wr_meta_data[7],wr_meta_data[5]};
            4'b1011:group1_meta_dat <= {128'd0,wr_meta_data[7],wr_meta_data[5],wr_meta_data[4]};
            4'b1100:group1_meta_dat <= {256'd0,wr_meta_data[7],wr_meta_data[6]};
            4'b1101:group1_meta_dat <= {128'd0,wr_meta_data[7],wr_meta_data[6],wr_meta_data[4]};
            4'b1110:group1_meta_dat <= {128'd0,wr_meta_data[7],wr_meta_data[6],wr_meta_data[5]};
            4'b1111:group1_meta_dat <= {wr_meta_data[7],wr_meta_data[6],wr_meta_data[5],wr_meta_data[4]};
            default:group1_meta_dat <= 512'd0;
        endcase
    end
end

always@(posedge clk) begin
    if(start_dly)begin
        case(group0_num)
            'd0,'d1:group0_axi_len <= 'd0;
            'd2:
                if(meta0_addr[4])
                    group0_axi_len <= 'd1;
                else
                    group0_axi_len <= 'd0;
            'd3:group0_axi_len <= 'd1;
            'd4:
                if(meta0_addr[4])
                    group0_axi_len <= 'd2;
                else
                    group0_axi_len <= 'd1;
            default:group0_axi_len <= 'd0;
        endcase
    end
end

always@(posedge clk) begin
    case(group1_num)
        'd0,'d1:group1_axi_len <= 'd0;
        'd2:
            if(metal_addr[4])
                group1_axi_len <= 'd1;
            else
                group1_axi_len <= 'd0;
        'd3:group1_axi_len <= 'd1;
        'd4:
            if(metal_addr[4])
                group1_axi_len <= 'd2;
            else
                group1_axi_len <= 'd1;
        default:group1_axi_len <= 'd0;
    endcase
end

always@(posedge clk) begin
    if(start_dly)begin
        case(group0_num)
            // 'd0:group0_mask <= 'd0;
            'd1:
                if(meta0_addr[4] == 1'b0)
                    group0_mask <= 6'b00_0001;
                else
                    group0_mask <= 6'b00_0010;
            'd2:
                if(meta0_addr[4] == 1'b0)
                    group0_mask <= 6'b00_0011;
                else
                    group0_mask <= 6'b00_0110;
            'd3:
                if(meta0_addr[4] == 1'b0)
                    group0_mask <= 6'b00_0111;
                else
                    group0_mask <= 6'b00_1110;
            'd4:
                if(meta0_addr[4] == 1'b0)
                    group0_mask <= 6'b00_1111;
                else
                    group0_mask <= 6'b01_1110;
            default:group0_mask <= 6'b01_1110; // Note: Original code has default case commented out, this is the visible default
        endcase
    end
end

always@(posedge clk) begin
    if(start_dly)begin
        case(group1_num)
            // 'd0:group1_mask <= 'd0;
            'd1:
                if(metal_addr[4] == 1'b0)
                    group1_mask <= 6'b00_0001;
                else
                    group1_mask <= 6'b00_0010;
            'd2:
                if(metal_addr[4] == 1'b0)
                    group1_mask <= 6'b00_0011;
                else
                    group1_mask <= 6'b00_0110;
            'd3:
                if(metal_addr[4] == 1'b0)
                    group1_mask <= 6'b00_0111;
                else
                    group1_mask <= 6'b00_1110;
            'd4:
                if(metal_addr[4] == 1'b0)
                    group1_mask <= 6'b00_1111;
                else
                    group1_mask <= 6'b01_1110;
            default:group1_mask <= 'd0;
        endcase
    end
end

assign group0_dat = meta0_addr[4] == 1'b0 ? {256'd0,group0_meta_dat} : {128'd0,group0_meta_dat,128'd0};
assign group1_dat = metal_addr[4] == 1'b0 ? {256'd0,group1_meta_dat} : {128'd0,group1_meta_dat,128'd0};

always@(*)begin
    if(cur_state == META_DATA0_STATE)begin
        dat_temp = group0_dat[DATA_WIDTH*wr_cnt+:DATA_WIDTH];
        mask_temp = group0_mask[2*wr_cnt+:2];
    end
    else begin
        dat_temp = group1_dat[DATA_WIDTH*wr_cnt+:DATA_WIDTH];
        mask_temp = group1_mask[2*wr_cnt+:2];
    end
end

wire dat_last;
assign dat_last = ((cur_state == META_DATA0_STATE & wr_cnt == group0_axi_len) |
                   (cur_state == META_DATA1_STATE & wr_cnt == group1_axi_len)) & meta_dat_fifo_wren;

assign meta_dat_fifo_wdat = {dat_last,{MASK_WIDTH{mask_temp[1]}},{MASK_WIDTH{mask_temp[0]}},dat_temp};
assign lm_wdat = meta_dat_fifo_rdat[DATA_WIDTH-1:0];
assign lm_wmask = meta_dat_fifo_rdat[AXI_DATA_WIDTH-2:DATA_WIDTH];
assign lm_wdat_last = meta_dat_fifo_rdat[AXI_DATA_WIDTH-1];
assign lm_wvld = !meta_dat_fifo_empty;
assign meta_dat_fifo_rden = lm_wvld & lm_wrdy;

witmem_sfifo_depth2 #(/*autoinstparam*/
    .FIFO_WIDTH     (AXI_DATA_WIDTH    ),
    .BETTER_TIMING  (1'b0              )
)
u0_meta_dat_fifo(/*autoinst*/
    .clk            (clk               ), //input
    .rst_n          (rst_n             ), //input
    .fifo_clr       (1'b0              ), //input
    .fifo_req_w     (meta_dat_fifo_wren), //input
    .fifo_req_r     (meta_dat_fifo_rden), //input
    .fifo_wdata     (meta_dat_fifo_wdat), //input
    .fifo_rdata     (meta_dat_fifo_rdat), //output
    .fifo_full      (meta_dat_fifo_full), //output
    .fifo_empty     (meta_dat_fifo_empty)  //output
);

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        done <= 1'b0;
    else if((cur_state == DONE_STATE & nxt_state == IDLE_STATE))
        done <= 1'b1;
    else
        done <= 1'b0;
end

endmodule