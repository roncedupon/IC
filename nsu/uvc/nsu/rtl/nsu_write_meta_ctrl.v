module nsu_write_meta_ctrl #(
    parameter DATA_WIDTH    = 256,
    parameter ADDR_WIDTH   = 34 ,
    parameter BLEN_WIDTH   = 9 ,
    parameter ID_WIDTH     = 10 ,
    parameter STRB_WIDTH   = DATA_WIDTH/8
)
(
    input                           clk         ,
    input                           rst_n       ,
    input                           start       ,
    output reg                      done        ,
    input       [31:0]              meta0_addr  ,
    input       [31:0]              meta1_addr  ,
    input       [7:0]               plane_sel   ,
    input       [31:0]              meta_data0  [7:0],
    input       [31:0]              meta_data1  [7:0],
    input       [31:0]              meta_data2  [7:0],
    input       [31:0]              meta_data3  [7:0],
    output                          lm_wreq     ,
    input                           lm_wack     ,
    output      [ID_WIDTH-1:0]      lm_wid      ,
    output      [BLEN_WIDTH-1:0]    lm_wlen     ,
    output      [ADDR_WIDTH-1:0]    lm_waddr    ,
    output                          lm_wvld     ,
    input                           lm_wrdy     ,
    output      [DATA_WIDTH-1:0]    lm_wdat     ,
    output                          lm_wdat_last,
    output      [STRB_WIDTH-1:0]    lm_wmask    ,
    input       [ID_WIDTH-1:0]      lm_wdone_id ,
    input                           lm_wdone_id_vld
);
//================================Parameter=====================================
localparam IDLE_STATE        = 4'd0;
localparam JUDGE0_STATE      = 4'd1;
localparam META_DATA0_STATE  = 4'd2;
localparam JUDGE1_STATE      = 4'd3;
localparam META_DATA1_STATE  = 4'd4;
localparam DONE_STATE        = 4'd5;

localparam AXI_AW_WH         = ADDR_WIDTH + BLEN_WIDTH;
localparam AXI_DATA_WIDTH    = DATA_WIDTH + STRB_WIDTH + 1;
localparam MASK_WIDTH        = STRB_WIDTH/2;
//================================Wire/Reg SIGNAL==============================
reg         [3:0]           cur_state   ;
reg         [3:0]           nxt_state   ;
reg                         start_dly   ;
reg         [2:0]           group0_num  ;
reg         [2:0]           group1_num  ;
wire        [127:0]         wr_meta_data [7:0];
reg         [1:0]           wr_cnt      ;
wire                        meta_axi_awfifo_wren;
wire                        meta_axi_awfifo_rden;
reg         [AXI_AW_WH-1:0] meta_axi_awfifo_wdat;
wire        [AXI_AW_WH-1:0] meta_axi_awfifo_rdat;
wire                        meta_axi_awfifo_full ;
wire                        meta_axi_awfifo_empty;
wire        [511:0]         group0_meta_dat     ;
wire        [511:0]         group1_meta_dat     ;
wire        [1:0]           group0_axi_len      ;
wire        [1:0]           group1_axi_len      ;
wire        [1:0]           resp_cnt            ;
reg         [5:0]           axi_cnt             ;
wire        [5:0]           group0_mask         ;
wire        [5:0]           group1_mask         ;
wire        [767:0]         group0_dat          ;
wire        [767:0]         group1_dat          ;
wire                        meta_dat_fifo_wren  ;
wire                        meta_dat_fifo_rden  ;
wire        [AXI_DATA_WIDTH-1:0]    meta_dat_fifo_wdat  ;
wire        [AXI_DATA_WIDTH-1:0]    meta_dat_fifo_rdat  ;
wire                        meta_dat_fifo_full  ;
wire                        meta_dat_fifo_empty ;
reg         [DATA_WIDTH-1:0]    dat_temp        ;
reg         [1:0]               mask_temp       ;

genvar i;
integer j;
//================================Process=======================================
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

always@(*)begin
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
            if(!meta_axi_awfifo_full)
                nxt_state = META_DATA1_STATE;
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
    else if(cur_state == DONE_STATE & nxt_state == IDLE_STATE)
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
    else if((cur_state == JUDGE0_STATE & (nxt_state == META_DATA0_STATE | nxt_state == META_DATA1_STATE)) | (cur_state == JUDGE1_STATE & nxt_state == META_DATA1_STATE))
        meta_axi_awfifo_wren <= 1'b1;
    else
        meta_axi_awfifo_wren <= 1'b0;
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        meta_axi_awfifo_wdat <= 'd0;
    end
    else if(cur_state == JUDGE0_STATE & nxt_state == META_DATA0_STATE)begin
        meta_axi_awfifo_wdat[ADDR_WIDTH-1:0] <= {2'd0,meta0_addr};
        meta_axi_awfifo_wdat[BLEN_WIDTH+ADDR_WIDTH-1:ADDR_WIDTH] <= {7'd0,group0_axi_len};
    end
    else if((cur_state == JUDGE0_STATE & nxt_state == META_DATA1_STATE) | (cur_state == JUDGE1_STATE & nxt_state == META_DATA1_STATE))begin
        meta_axi_awfifo_wdat[ADDR_WIDTH-1:0] <= {2'd0,meta1_addr};
        meta_axi_awfifo_wdat[BLEN_WIDTH+ADDR_WIDTH-1:ADDR_WIDTH] <= {7'd0,group1_axi_len};
    end
end

assign lm_wid   = 'd1;
assign lm_wlen  = meta_axi_awfifo_rdat[BLEN_WIDTH+ADDR_WIDTH-1:ADDR_WIDTH];
assign lm_waddr = meta_axi_awfifo_rdat[ADDR_WIDTH-1:0];
assign meta_axi_awfifo_rden = lm_wreq & lm_wack;
assign lm_wreq = !meta_axi_awfifo_empty;

witmem_sfifo_depth2 #(/*autoinstparam*/
    .FIFO_WIDTH         (AXI_AW_WH      ),
    .BETTER_TIMING      (1'b0           )
)
u0_meta_axi_awfifo(/*autoinst*/
    .clk                (clk                ), //
    .rst_n              (rst_n              ), //
    .fifo_clr           (1'b0               ), //
    .fifo_req_w         (meta_axi_awfifo_wren   ), //
    .fifo_req_r         (meta_axi_awfifo_rden   ), //
    .fifo_wdata         (meta_axi_awfifo_wdat   ), //
    .fifo_rdata         (meta_axi_awfifo_rdat   ), //
    .fifo_full          (meta_axi_awfifo_full    ), //
    .fifo_empty         (meta_axi_awfifo_empty   )  //
);

generate
    for(i=0;i<8;i=i+1)begin
        assign wr_meta_data[i] = {meta_data3[i],meta_data2[i],meta_data1[i],meta_data0[i]};
    end
endgenerate

//reg       [31:0]      group0_addr      ;
//reg       [31:0]      group1_addr      ;
//always@(posedge clk or negedge rst_n) begin
//    if(!rst_n)
//        group0_addr <= 'd0;
//    else if(start)begin
//        if(|plane_sel[1:0])
//            group0_addr <= meta0_addr;
//        else
//            group0_addr <= meta0_addr + 'd16;
//    end
//end
//always@(posedge clk or negedge rst_n) begin
//    if(!rst_n)
//        group1_addr <= 'd0;
//    else if(start)begin
//        if(|plane_sel[5:4])
//            group1_addr <= meta1_addr;
//        else
//            group1_addr <= meta1_addr + 'd16;
//    end
//end

assign group0_axi_len = meta0_addr[4] == 1'b0 ? 'd1 : 'd2;
assign group1_axi_len = meta1_addr[4] == 1'b0 ? 'd1 : 'd2;
assign group0_mask = meta0_addr[4] == 1'b0 ? {2'b0,plane_sel[3:0]} : {1'b0,plane_sel[3:0],1'b0};
assign group1_mask = meta1_addr[4] == 1'b0 ? {2'b0,plane_sel[7:4]} : {1'b0,plane_sel[7:4],1'b0};

assign meta_dat_fifo_wren = (cur_state == META_DATA0_STATE) | (cur_state == META_DATA1_STATE) & !meta_dat_fifo_full;
assign resp_cnt = (group0_axi_len != 'd0 & group0_axi_len != 'd0) ? 'd2 : 'd1;
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

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        done <= 1'b0;
    else if(cur_state == DONE_STATE & nxt_state == IDLE_STATE)
        done <= 1'b1;
    else
        done <= 1'b0;
end

assign group0_meta_dat = {wr_meta_data[3],wr_meta_data[2],wr_meta_data[1],wr_meta_data[0]};
assign group1_meta_dat = {wr_meta_data[7],wr_meta_data[6],wr_meta_data[5],wr_meta_data[4]};
assign group0_dat = meta0_addr[4] == 1'b0 ? {256'd0,group0_meta_dat} : {128'd0,group0_meta_dat,128'd0};
assign group1_dat = meta1_addr[4] == 1'b0 ? {256'd0,group1_meta_dat} : {128'd0,group1_meta_dat,128'd0};

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

wire    dat_last;
assign dat_last = ((cur_state == META_DATA0_STATE & wr_cnt == group0_axi_len) |
                   (cur_state == META_DATA1_STATE & wr_cnt == group1_axi_len)) & meta_dat_fifo_wren;

assign meta_dat_fifo_wdat = {dat_last,{MASK_WIDTH{mask_temp[1]}},{MASK_WIDTH{mask_temp[0]}},dat_temp};
assign lm_wdat   = meta_dat_fifo_rdat[DATA_WIDTH-1:0];
assign lm_wmask  = meta_dat_fifo_rdat[AXI_DATA_WIDTH-2:DATA_WIDTH];
assign lm_wdat_last = meta_dat_fifo_rdat[AXI_DATA_WIDTH-1];
assign lm_wvld   = !meta_dat_fifo_empty;
assign meta_dat_fifo_rden = lm_wvld & lm_wrdy;

witmem_sfifo_depth2 #(/*autoinstparam*/
    .FIFO_WIDTH         (AXI_DATA_WIDTH   ),
    .BETTER_TIMING      (1'b0           )
)
u0_meta_dat_fifo(/*autoinst*/
    .clk                (clk                ), //
    .rst_n              (rst_n              ), //
    .fifo_clr           (1'b0               ), //
    .fifo_req_w         (meta_dat_fifo_wren    ), //
    .fifo_req_r         (meta_dat_fifo_rden    ), //
    .fifo_wdata         (meta_dat_fifo_wdat    ), //
    .fifo_rdata         (meta_dat_fifo_rdat    ), //
    .fifo_full          (meta_dat_fifo_full    ), //
    .fifo_empty         (meta_dat_fifo_empty   )  //
);

endmodule