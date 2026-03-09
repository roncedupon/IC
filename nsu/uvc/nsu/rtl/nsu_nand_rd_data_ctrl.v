`timescale 1ns/1ps
module nsu_nand_rdata_ctrl(/*autoarg*/
    //Inputs
    clk, rst_n,
    tsu_rcmd_done_cnt_clr,
    on_dec0_dat_vld,
    on_dec0_dat,
    on_dec0_dat_last,
    on_dec1_dat_vld,
    on_dec1_dat,
    on_dec1_dat_last,
    on_dec2_dat_vld,
    on_dec2_dat,
    on_dec2_dat_last,
    on_dec3_dat_vld,
    on_dec3_dat,
    on_dec3_dat_last,
    on_dec4_dat_vld,
    on_dec4_dat,
    on_dec4_dat_last,
    on_dec5_dat_vld,
    on_dec5_dat,
    on_dec5_dat_last,
    on_dec6_dat_vld,
    on_dec6_dat,
    on_dec6_dat_last,
    on_dec7_dat_vld,
    on_dec7_dat,
    on_dec7_dat_last, cmd_sel,
    online_data_rdvld,
    pattern_data,
    unmap_read_sel,
    msa_dat_addr,
    msa_dat_addr_vld,
    off_wbf_pp_vld,
    off_wbf_dat_addr,
    off_wbf_del_addr_vld,
    nsu_tsu_out_offset,
    nsu_tsu_out_ost_id,
    nsu_tsu_out_vld,
    nsu_tsu_out_last_pack,
    nsu_tsu_out_plane_en,
    nsu_tsu_err_msg, tsu_addr,
    tsu_addr_vld,
    ping_pong_flag,
    ping_pong_vld,
    dat0_sram_rcen,
    dat0_sram_raddr,
    dat0_sram_rden,
    dat0_sram_rdata,
    dat0_sram_rdata_vld,
    dat1_sram_rcen,
    dat1_sram_raddr,
    dat1_sram_rden,
    dat1_sram_rdata,
    dat1_sram_rdata_vld,
    dat2_sram_rcen,
    dat2_sram_raddr,
    dat2_sram_rden,
    dat2_sram_rdata,
    dat2_sram_rdata_vld,
    dat3_sram_rcen,
    dat3_sram_raddr,
    dat3_sram_rden,
    dat3_sram_rdata,
    dat3_sram_rdata_vld,
    lm_rack, lm_rvld, lm_rdata,
    lm_rdata_id, lm_rlast,
    tsu_nsu_r_rdy,
    //Outputs
    tsu_rcmd_done_cnt,
    on_dec0_dat_rdy,
    on_dec1_dat_rdy,
    on_dec2_dat_rdy,
    on_dec3_dat_rdy,
    on_dec4_dat_rdy,
    on_dec5_dat_rdy,
    on_dec6_dat_rdy,
    on_dec7_dat_rdy,
    online_write_done,
    unmap_write_done,
    msa_done, off_wbf_done,
    off_wbf_del_addr_vld,
    off_wbf_dat_addr,
    ping_pong_rdy,
    dat0_sram_rcen,
    dat0_sram_raddr,
    dat0_sram_wcen,
    dat0_sram_waddr,
    dat0_sram_wdat,
    dat1_sram_rcen,
    dat1_sram_raddr,
    dat1_sram_wcen,
    dat1_sram_waddr,
    dat1_sram_wdat,
    dat2_sram_rcen,
    dat2_sram_raddr,
    dat2_sram_wcen,
    dat2_sram_waddr,
    dat2_sram_wdat,
    dat3_sram_rcen,
    dat3_sram_raddr,
    dat3_sram_wcen,
    dat3_sram_waddr,
    dat3_sram_wdat,
    lm_rreq,
    lm_len, lm_raddr, lm_rid,
    lm_arlock, lm_arcache,
    lm_arprot, lm_arqos,
    lm_arregion, lm_aruser,
    lm_rrdy, tsu_nsu_r_vld,
    tsu_nsu_r_dat
);

//Parameter
parameter NSU_RDATA_WIDTH = 2048;
parameter LBA_LEN         = 30;
parameter BLEN_WIDTH      = 9;
parameter ADDR_WIDTH      = 32;
parameter DATA_WIDTH      = 256;
parameter ID_WIDTH        = 8;
parameter AR_USER_WIDTH   = 1;
localparam IDLE_STATE     = 2'b01;
localparam READ_DAT_SATE  = 2'b10;

//Wire/Reg SIGNAL
/*autodef*/
wire        fifo_req_w        [7:0];
wire        fifo_req_r        [7:0];
wire [512:0] fifo_wdata        [7:0];
wire [512:0] fifo_rdata        [7:0];
wire        fifo_full         [7:0];
wire        fifo_empty        [7:0];
// wire data vld and up down select
wire [3:0]  online_dat_sel    ;
wire [3:0]  unmap_dat_sel     ;
wire [3:0]  axi_dat_sel       ;
wire [3:0]  online_ping_pong_flag ;
wire [3:0]  unmap_ping_pong_flag ;
wire [3:0]  axi_ping_pong_flag ;
wire [3:0]  write_up_down_flag ;
wire [3:0]  online_dat_vld    ;
wire [7:0]  dat_sram_wren     ;
wire        axi_wr_sram_en    ;
//
wire [7:0]  online_dat_in_vld ;
wire [7:0]  online_dat_in_rdy ;
wire [511:0] unmap_cnt         ;
wire [5:0]  unmap_map         ;
wire [2:0]  write_data_cnt    [3:0];
wire [3:0]  write_data_addr   [3:0];
wire [DATA_WIDTH-1:0] axi_rdat_fifo_wen ;
wire [DATA_WIDTH-1:0] axi_rdat_fifo_wdat;
wire        axi_rdat_fifo_ren ;
wire [511:0] axi_rdat_fifo_rdat;
wire        axi_rdat_fifo_full;
reg  [5:0]  axi_rdat_fifo_empty;
reg  [5:0]  axi_rd_dat_cnt    ;
wire        axi_rdata_fifo_empty;
reg  [5:0]  axi_rd_dat_cnt    ;
wire        axi_rdata_fifo_wen;
wire        axi_rdata_fifo_ren;
wire        axi_rdata_fifo_full;
wire        axi_rdata_fifo_empty;
reg  [5:0]  off_wbf_cmd_cnt   ;
wire        off_wbf_pp_vld    ;
wire        off_wbf_vld_num   ;
wire [3:0]  act_off_wbf_vld_num;
wire [2:0]  off_wbf_del_addr_fifo_wen;
wire [2:0]  off_wbf_del_addr_fifo_wdat;
wire        off_wbf_del_addr_fifo_ren;
wire [31:0] off_wbf_del_addr_fifo_rdat;
wire        off_wbf_del_addr_fifo_full;
wire        off_wbf_del_addr_fifo_empty;
wire        pp_wdone          ;
reg  [2:0]  pp_cnt            ;
wire [3:0]  off_wbf_rd_dat_num;
reg  [7:0]  off_wbf_plane_sel ;
// read data control
reg  [2:0]  tsu_nsu_msg_cnt   [7:0];
reg  [7:0]  tsu_nsu_offset_pack;
reg  [7:0]  tsu_nsu_ost_id    [7:0];
reg  [7:0]  tsu_nsu_last_pack ;
reg  [7:0]  tsu_nsu_msg_vld   ;
reg  [7:0]  tsu_err_msg       [7:0];
wire [48:0] head_msg          [7:0];
wire        rd_cmd_fifo_req_w ;
wire        rd_cmd_fifo_req_r ;
wire [460:0] rd_cmd_fifo_wdata ;
wire [460:0] rd_cmd_fifo_rdata ;
wire        rd_cmd_fifo_full  ;
wire        rd_cmd_fifo_empty ;
wire        out_fifo_wen       [7:0];
wire [255:0] out_fifo_wdat     [6:0];
wire        out_fifo_ren      [7:0];
reg  [1:0]  cur_state         ;
reg  [1:0]  nxt_state         ;
wire        read_dat_done     ;
wire        rdat_fifo_afull   ;
wire        rdat_fifo_empty   ;
wire        vld_flag          ;
reg  [7:0]  vld_pack_num      ;
wire        read_flag         ;
reg  [7:0]  tsu_nsu_last_pack_dly;
reg  [7:0]  sram_sel          ;
wire [3:0]  sram_ren          ;
wire [3:0]  single_read_sram_cnt;
wire        single_read_sram_done;
reg  [3:0]  single_read_sram_cnt;
reg  [3:0]  single_read_sram_done;
reg  [2:0]  mult_sram_read_cnt ;
wire [3:0]  pp_num            ;
wire        pipe_en           ;
wire        pipe_en_dly       ;
wire        dat_dly           ;
wire        pipe_out          ;
reg         pipe_out_dly      ;
wire        rd_dat_last       ;
wire        rd_data_cnt       ;
wire [511:0] data_out0         ;
wire [511:0] data_out1         ;
wire [511:0] data_out2         ;
wire [513:0] data_out3         ;
wire [LBA_LEN-1:0] nsu_addr    [1:0] ;
genvar i;
integer j;

//Process
assign online_dat_in_vld = (on_dec7_dat_vld,on_dec6_dat_vld,on_dec5_dat_vld,on_dec4_dat_vld,
                           on_dec3_dat_vld,on_dec2_dat_vld,on_dec1_dat_vld,on_dec0_dat_vld);
assign fifo_wdata[0] = (on_dec7_dat_last,on_dec6_dat_last,on_dec5_dat_last,on_dec4_dat_last,
                        on_dec3_dat_last,on_dec2_dat_last,on_dec1_dat_last,on_dec0_dat_last);
assign fifo_wdata[1] = (on_dec7_dat_last,on_dec6_dat_last,on_dec5_dat_last,on_dec4_dat_last,
                        on_dec3_dat_last,on_dec2_dat_last,on_dec1_dat_last,on_dec0_dat_last);
assign fifo_wdata[2] = (on_dec7_dat_last,on_dec6_dat_last,on_dec5_dat_last,on_dec4_dat_last,
                        on_dec3_dat_last,on_dec2_dat_last,on_dec1_dat_last,on_dec0_dat_last);
assign fifo_wdata[3] = (on_dec7_dat_last,on_dec6_dat_last,on_dec5_dat_last,on_dec4_dat_last,
                        on_dec3_dat_last,on_dec2_dat_last,on_dec1_dat_last,on_dec0_dat_last);
assign fifo_wdata[4] = (on_dec7_dat_last,on_dec6_dat_last,on_dec5_dat_last,on_dec4_dat_last,
                        on_dec3_dat_last,on_dec2_dat_last,on_dec1_dat_last,on_dec0_dat_last);
assign fifo_wdata[5] = (on_dec7_dat_last,on_dec6_dat_last,on_dec5_dat_last,on_dec4_dat_last,
                        on_dec3_dat_last,on_dec2_dat_last,on_dec1_dat_last,on_dec0_dat_last);
assign fifo_wdata[6] = (on_dec7_dat_last,on_dec6_dat_last,on_dec5_dat_last,on_dec4_dat_last,
                        on_dec3_dat_last,on_dec2_dat_last,on_dec1_dat_last,on_dec0_dat_last);
assign fifo_wdata[7] = (on_dec7_dat_last,on_dec6_dat_last,on_dec5_dat_last,on_dec4_dat_last,
                        on_dec3_dat_last,on_dec2_dat_last,on_dec1_dat_last,on_dec0_dat_last);
assign fifo_wstrb[0] = (on_dec7_dat_rdy,on_dec6_dat_rdy,on_dec5_dat_rdy,on_dec4_dat_rdy,
                        on_dec3_dat_rdy,on_dec2_dat_rdy,on_dec1_dat_rdy,on_dec0_dat_rdy) = online_dat_in_rdy;
assign unmap_map = (pattern_data,pattern_data,pattern_data,pattern_data,pattern_data,pattern_data,
                    pattern_data,pattern_data,pattern_data,pattern_data,pattern_data,pattern_data,
                    pattern_data,pattern_data,pattern_data,pattern_data);

assign lm_rid = 'd1;
assign lm_arlock = 1'b0;
assign lm_arcache = 4'b0011;
assign lm_arprot = 3'b00;
assign lm_arqos = 4'b00;
assign lm_arregion = 4'b00;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        unmap_cnt <= 'd0;
    else if(|unmap_read_sel)
        unmap_cnt <= unmap_cnt + 1'b1;
end
//TODO modify
//assign unmap_write_done = (|unmap_read_sel) & unmap_cnt == 'd63;

generate
    for (i=0;i<8;i=i+1) begin
        assign online_dat_in_rdy[i] = !fifo_full[i];
        assign fifo_req_w[i] = online_dat_in_vld[i] & online_dat_in_rdy[i];
        //assign fifo_req_r[i] = online_data_rdvld[i] & (!fifo_empty[i]);
        assign online_write_done[i] = online_data_rdvld[i] ? (fifo_req_r[i] & fifo_rdata[i]
        [1]:1'b0);
        witmem_sfifo_depth #(/*autoinstparam*/
            .FIFO_WIDTH     (513                   ),
            .BETTER_TIMING  (1'b1                 )
        )
        u_online_wdat_fifo(/*autoinst*/
            .clk            (clk                   ), //input
            .rst_n          (rst_n                 ), //input
            .fifo_clr       (1'b0                  ), //input
            .fifo_req_w     (fifo_req_w[i]         ), //input
            .fifo_req_r     (fifo_req_r[i]         ), //input
            .fifo_wdata     (fifo_wdata[i]         ), //input
            .fifo_rdata     (fifo_rdata[i]         ), //output
            .fifo_full      (fifo_full[i]          ), //output
            .fifo_empty     (fifo_empty[i]         ) //output
        );
    end
endgenerate

assign write_up_down_flag = online_ping_pong_flag | unmap_ping_pong_flag | axi_ping_pong_flag;
wire  [3:0] msa_off_rd_vld   ;
// assign online_ping_pong_flag = |online_data_rdvld[3:0] ? 4'b0 : 4'hf;
// assign unmap_ping_pong_flag = |unmap_read_sel[3:0] ? 4'b0 : {4{|unmap_read_sel[7:4]}};

generate
    for (i=0;i<4;i=i+1) begin
        assign online_dat_sel[i] = online_data_rdvld[i] ? 1'b0 : online_data_rdvld[i
        +4];
        assign online_data_rdvld[i+4] = online_ping_pong_flag[i] ? 1'b0 : online_data_rdvld[i
        +4];
        // assign unmap_dat_sel[i] = unmap_read_sel[i] ? unmap_read_sel[i] : unmap_read_sel[i
        +4];
        assign unmap_dat_sel[i] = unmap_ping_pong_flag[i] ? unmap_read_sel[i+4] :
        unmap_read_sel[i];
        // assign axi_dat_sel[i] = axi_wr_sram_en[i] ? axi_wr_sram_en[i] : axi_wr_sram_en[i
        +4];
        assign axi_dat_sel[i] = axi_ping_pong_flag[i] = axi_wr_sram_en[i+4] ? 1'b0 : axi_wr_sram_en[i];

        assign fifo_req_r[i] = online_data_rdvld[i] & (!fifo_empty[i]) &
        (online_ping_pong_flag[i] = 1'b0);
        assign fifo_req_r[i+4] = online_data_rdvld[i+4] & (!fifo_empty[i+4]) &
        online_ping_pong_flag[i];
        assign online_dat_vld[i] = online_ping_pong_flag[i] ? fifo_req_r[i+4] : fifo_req_r[i];
        assign msa_off_rd_vld[i] = online_ping_pong_flag[i] ? axi_rdat_vld[i+4] : axi_rdat_vld
        [i];
        assign dat_sram_wren[i] = online_dat_vld[i] | unmap_dat_sel[i] | msa_off_rd_vld[i];
        // assign unmap_write_done[i+4] = unmap_read_sel[i+4] && unmap_cnt == 'd63 &&
        unmap_ping_pong_flag[i] = 1'b0;
        assign unmap_write_done[i+4] = unmap_cnt == 'd63 && unmap_ping_pong_flag[i] = 1'b0;
        assign unmap_write_done[i] = unmap_cnt == 'd63 && unmap_ping_pong_flag[i] = 1'b1;
    end
endgenerate

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        write_data_cnt[i] <= 'd0;
        write_data_addr[i] <= 'd0;
    end
    else if(dat_sram_wren[i])begin
        if(write_data_cnt[i] == 'd3)begin
            write_data_cnt[i] <= 'd0;
            write_data_addr[i] <= write_data_addr[i] + 1'b1;
        end
        else
            write_data_cnt[i] <= write_data_cnt[i] + 1'b1;
    end
end

// ping pong sram write and read control
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        dat0_sram_wdat[i] <= 'd0;
    else if(dat_sram_wren[i] & write_data_cnt[i] == 'd0)begin
        if(cmd_sel == 'd1)begin
            if(write_up_down_flag[i])
                dat0_sram_wdat[i] <= fifo_rdata[i+4][511:0];
            else
                dat0_sram_wdat[i] <= fifo_rdata[i][511:0];
        end
        else if(cmd_sel == 'd4)
            dat0_sram_wdat[i] <= unmap_data;
        else if(cmd_sel == 'd2 | cmd_sel == 'd3)
            dat0_sram_wdat[i] <= axi_rdat_fifo_rdat;
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        dat1_sram_wdat[i] <= 'd0;
    else if(dat_sram_wren[i] & write_data_cnt[i] == 'd1)begin
        if(cmd_sel == 'd1)begin
            if(write_up_down_flag[i])
                dat1_sram_wdat[i] <= fifo_rdata[i+4][511:0];
            else
                dat1_sram_wdat[i] <= fifo_rdata[i][511:0];
        end
        else if(cmd_sel == 'd4)
            dat1_sram_wdat[i] <= unmap_data;
        else if(cmd_sel == 'd2 | cmd_sel == 'd3)
            dat1_sram_wdat[i] <= axi_rdat_fifo_rdat;
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        dat2_sram_wdat[i] <= 'd0;
    else if(dat_sram_wren[i] & write_data_cnt[i] == 'd2)begin
        if(cmd_sel == 'd1)begin
            if(write_up_down_flag[i])
                dat2_sram_wdat[i] <= fifo_rdata[i+4][511:0];
            else
                dat2_sram_wdat[i] <= fifo_rdata[i][511:0];
        end
        else if(cmd_sel == 'd4)
            dat2_sram_wdat[i] <= unmap_data;
        else if(cmd_sel == 'd2 | cmd_sel == 'd3)
            dat2_sram_wdat[i] <= axi_rdat_fifo_rdat;
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        dat3_sram_wdat[i] <= 'd0;
    else if(dat_sram_wren[i] & write_data_cnt[i] == 'd3)begin
        if(cmd_sel == 'd1)begin
            if(write_up_down_flag[i])
                dat3_sram_wdat[i] <= fifo_rdata[i+4][511:0];
            else
                dat3_sram_wdat[i] <= fifo_rdata[i][511:0];
        end
        else if(cmd_sel == 'd4)
            dat3_sram_wdat[i] <= unmap_data;
        else if(cmd_sel == 'd2 | cmd_sel == 'd3)
            dat3_sram_wdat[i] <= axi_rdat_fifo_rdat;
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        dat0_sram_wcen[i] <= 1'b1;
    else if(dat_sram_wren[i] & write_data_cnt[i] == 'd0)
        dat0_sram_wcen[i] <= 1'b0;
    else
        dat0_sram_wcen[i] <= 1'b1;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        dat0_sram_raddr[i] <= 'd0;
    else if(dat_sram_wren[i] & write_data_cnt[i] == 'd0)begin
        case({ping_pong_flag,write_up_down_flag[i]})
            2'b00:dat0_sram_raddr[i] <= {2'b00,write_data_addr[i]};
            2'b01:dat0_sram_raddr[i] <= {2'b01,write_data_addr[i]};
            2'b10:dat0_sram_raddr[i] <= {2'b10,write_data_addr[i]};
            2'b11:dat0_sram_raddr[i] <= {2'b11,write_data_addr[i]};
            default:dat0_sram_raddr[i] <= {2'b00,write_data_addr[i]};
        endcase
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        dat1_sram_wcen[i] <= 1'b1;
    else if(dat_sram_wren[i] & write_data_cnt[i] == 'd1)
        dat1_sram_wcen[i] <= 1'b0;
    else
        dat1_sram_wcen[i] <= 1'b1;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        dat1_sram_raddr[i] <= 'd0;
    else if(dat_sram_wren[i] & write_data_cnt[i] == 'd1)begin
        case({ping_pong_flag,write_up_down_flag[i]})
            2'b00:dat1_sram_raddr[i] <= {2'b00,write_data_addr[i]};
            2'b01:dat1_sram_raddr[i] <= {2'b01,write_data_addr[i]};
            2'b10:dat1_sram_raddr[i] <= {2'b10,write_data_addr[i]};
            2'b11:dat1_sram_raddr[i] <= {2'b11,write_data_addr[i]};
            default:dat1_sram_raddr[i] <= {2'b00,write_data_addr[i]};
        endcase
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        dat2_sram_wcen[i] <= 1'b1;
    else if(dat_sram_wren[i] & write_data_cnt[i] == 'd2)
        dat2_sram_wcen[i] <= 1'b0;
    else
        dat2_sram_wcen[i] <= 1'b1;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        dat2_sram_raddr[i] <= 'd0;
    else if(dat_sram_wren[i] & write_data_cnt[i] == 'd2)begin
        case({ping_pong_flag,write_up_down_flag[i]})
            2'b00:dat2_sram_raddr[i] <= {2'b00,write_data_addr[i]};
            2'b01:dat2_sram_raddr[i] <= {2'b01,write_data_addr[i]};
            2'b10:dat2_sram_raddr[i] <= {2'b10,write_data_addr[i]};
            2'b11:dat2_sram_raddr[i] <= {2'b11,write_data_addr[i]};
            default:dat2_sram_raddr[i] <= {2'b00,write_data_addr[i]};
        endcase
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        dat3_sram_wcen[i] <= 1'b1;
    else if(dat_sram_wren[i] & write_data_cnt[i] == 'd3)
        dat3_sram_wcen[i] <= 1'b0;
    else
        dat3_sram_wcen[i] <= 1'b1;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        dat3_sram_waddr[i] <= 'd0;
    else
        dat3_sram_waddr[i] <= 1'b1;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        dat3_sram_raddr[i] <= 'd0;
    else if(mult_sram_ren[i])begin
        if(read_flag == 1'b0 && pp_num[3:2] == 2'b00)
            dat3_sram_raddr[i] <= {2'b00,single_read_sram_cnt};
        else if(read_flag == 1'b0 && pp_num[3:2] == 2'b01)
            dat3_sram_raddr[i] <= {2'b01,single_read_sram_cnt};
        else if(read_flag == 1'b1 && pp_num[3:2] == 2'b00)
            dat3_sram_raddr[i] <= {2'b10,single_read_sram_cnt};
        else if(read_flag == 1'b1 && pp_num[3:2] == 2'b01)
            dat3_sram_raddr[i] <= {2'b11,single_read_sram_cnt};
    end
end

endgenerate

assign lm_rrdy = !axi_rdat_fifo_full;
assign axi_rdat_fifo_wen = lm_rvld & lm_rrdy;
assign axi_rdat_fifo_wdat = lm_rdata;
assign axi_rdat_fifo_ren = !axi_rdat_fifo_empty;

nsu_fifo_width #(
    .COMMON_DIVISOR (DATA_WIDTH) ,
    .IN_WIDTH       (DATA_WIDTH) ,
    .OUT_WIDTH      (512),
    .FIFO_DEPTH     (512/DATA_WIDTH*2),
    .OUT_REGISTER   (1)
)
u_data_fifo
(
    .clk            (clk),
    .rst_n          (rst_n),
    .fifo_clr       (1'b0),
    .fifo_wen       (axi_rdat_fifo_wen ),
    .fifo_wdat      (axi_rdat_fifo_wdat),
    .fifo_ren       (axi_rdat_fifo_ren ),
    .fifo_rdat      (axi_rdat_fifo_rdat),
    .fifo_remain_vld (),
    .fifo_remain_rdat (),
    .full           (axi_rdat_fifo_full ),
    .empty          (axi_rdat_fifo_empty)
);

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        off_wbf_cmd_cnt <= 'd0;
    end
    else if(rd_cmd_fifo_req_w)
        off_wbf_cmd_cnt <= 'd0;
    else if(off_wbf_addr_vld)
        off_wbf_cmd_cnt <= off_wbf_cmd_cnt + 1'b1;
end

nsu_get_8bone_num u0_nsu_get_8bone_num(/*autoinst*/
    .clk            (clk                   ), //input
    .rst_n          (rst_n                 ), //input
    .dat_in         (off_wbf_pp_vld        ), //input
    .en             (off_wbf_vld_vld       ), //input
    .dat_out        (off_wbf_vld_num       )  //output
);

assign act_off_wbf_vld_num = 1'b1;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        lm_rreq <= 1'b0;
        lm_raddr <= 'd0;
    end
    else if(cmd_sel == 'd3 & msa_dat_addr_vld)begin
        lm_rreq <= 1'b1;
        lm_raddr <= {2'd0,msa_dat_addr};
    end
    else if(cmd_sel == 'd2 & off_wbf_pp_vld[off_wbf_cmd_cnt] & off_wbf_addr_vld)begin
        lm_rreq <= 1'b1;
        lm_raddr <= {2'd0,off_wbf_dat_addr};
    end
    else
        lm_rreq <= 1'b0;
end

// release offline wbf io read allocate addr
assign off_wbf_del_addr_vld = off_wbf_del_addr_fifo_ren;
assign off_wbf_del_addr = off_wbf_del_addr_fifo_rdat;
assign off_wbf_del_addr_fifo_wen = lm_rreq & lm_rack & cmd_sel == 'd2;
assign off_wbf_dat_addr = off_wbf_dat_addr;
assign off_wbf_dat_addr_fifo_ren = pp_wdone & cmd_sel == 'd2 & !off_wbf_del_addr_fifo_empty;

dw_sfifo #(/*autoinstparam*/
    .REG_OUT        ("false"               ),
    .DATA_WIDTH     (32                    ),
    .ADDR_WIDTH     (3                     )
)
u_off_wbf_del_addr_fifo(/*autoinst*/
    .clk            (clk                   ), //input
    .rst_n          (rst_n                 ), //input
    .wen            (off_wbf_del_addr_fifo_wen ), //input
    .wdata          (off_wbf_del_addr_fifo_wdat ), //input
    .ren            (off_wbf_del_addr_fifo_ren ), //input
    .ae_level       (3'd5                  ), //input
    .af_level       (3'd2                  ), //input
    .rdata          (off_wbf_del_addr_fifo_rdat ), //output
    .word_cnt       (                      ), //output
    .alfull         (off_wbf_del_addr_fifo_full  ), //output
    .alempty        (                      ), //output
    .full           (off_wbf_del_addr_fifo_full  ), //output
    .empty          (off_wbf_del_addr_fifo_empty )  //output
);

assign pp_wdone = axi_rdat_fifo_ren & axi_rd_dat_cnt == 'd63;
assign msa_done = pp_wdone & cmd_sel == 'd3;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        off_wbf_done <= 1'b0;
    else if(pp_wdone & (pp_cnt == act_off_wbf_vld_num) & cmd_sel == 'd2)
        off_wbf_done <= 1'b1;
    else
        off_wbf_done <= 1'b0;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        axi_rd_dat_cnt <= 'd0;
    else if(axi_rdat_fifo_ren)
        axi_rd_dat_cnt <= axi_rd_dat_cnt + 1'b1;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        pp_cnt <= 'd0;
    else if(rd_cmd_fifo_req_w)
        pp_cnt <= 'd0;
    else if(pp_wdone)
        pp_cnt <= pp_cnt + 1'b1;
end

assign off_wbf_rd_dat_num = get_first_pos_8(off_wbf_plane_sel);

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        off_wbf_plane_sel <= 'd0;
    else if(off_wbf_addr_vld)
        off_wbf_plane_sel <= off_wbf_pp_vld;
    else if(pp_wdone)
        off_wbf_plane_sel[off_wbf_rd_dat_num] <= 1'b0;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        aix_rdat_vld <= 8'd0;
    else if(cmd_sel == 'd3)
        aix_rdat_vld <= {7'd0,axi_rdat_fifo_ren};
    else if(cmd_sel == 'd2)begin
        case(off_wbf_rd_dat_num)
            'd0:aix_rdat_vld <= {7'd0,axi_rdat_fifo_ren};
            'd1:aix_rdat_vld <= {6'd0,axi_rdat_fifo_ren,1'b0};
            'd2:aix_rdat_vld <= {5'd0,axi_rdat_fifo_ren,2'd0};
            'd3:aix_rdat_vld <= {4'd0,axi_rdat_fifo_ren,3'd0};
            'd4:aix_rdat_vld <= {3'd0,axi_rdat_fifo_ren,4'd0};
            'd5:aix_rdat_vld <= {2'd0,axi_rdat_fifo_ren,5'd0};
            'd6:aix_rdat_vld <= {1'd0,axi_rdat_fifo_ren,6'd0};
            'd7:aix_rdat_vld <= {axi_rdat_fifo_ren,7'd0};
            default:aix_rdat_vld <= {7'd0,axi_rdat_fifo_ren};
        endcase
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        axi_wr_sram_en <= 8'd0;
    else if(cmd_sel == 'd3)
        axi_wr_sram_en <= {7'd0,1'b1};
    else if(cmd_sel == 'd2)begin
        case(off_wbf_rd_dat_num)
            'd0:axi_wr_sram_en <= {7'd0,1'b1};
            'd1:axi_wr_sram_en <= {6'd0,1'b1,1'b0};
            'd2:axi_wr_sram_en <= {5'd0,1'b1,2'd0};
            'd3:axi_wr_sram_en <= {4'd0,1'b1,3'd0};
            'd4:axi_wr_sram_en <= {3'd0,1'b1,4'd0};
            'd5:axi_wr_sram_en <= {2'd0,1'b1,5'd0};
            'd6:axi_wr_sram_en <= {1'd0,1'b1,6'd0};
            'd7:axi_wr_sram_en <= {1'b1,1'b7'd0};
            default:axi_wr_sram_en <= {7'd0,1'b1};
        endcase
    end
end

// read data control
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        tsu_nsu_msg_cnt <= 'd0;
    else if(tsu_nsu_out_vld)
        tsu_nsu_msg_cnt <= tsu_nsu_msg_cnt + 1'b1;
end

always@(posedge clk)begin
    if(tsu_nsu_out_vld)begin
        tsu_nsu_offset[tsu_nsu_msg_cnt] <= nsu_tsu_out_offset;
        tsu_nsu_ost_id[tsu_nsu_msg_cnt] <= nsu_tsu_out_ost_id;
        tsu_nsu_last_pack[tsu_nsu_msg_cnt] <= nsu_tsu_out_last_pack ;
        tsu_nsu_msg_vld[tsu_nsu_msg_cnt] <= nsu_tsu_out_plane_en   ;
        tsu_err_msg[tsu_nsu_msg_cnt]   <= nsu_tsu_err_msg   ;
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        nsu_addr[0] <= 'd0;
    else if(tsu_addr_vld & tsu_nsu_msg_cnt == 'd0)
        nsu_addr[0] <= tsu_addr;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        nsu_addr[1] <= 'd0;
    else if(tsu_addr_vld & tsu_nsu_msg_cnt == 'd4)
        nsu_addr[1] <= tsu_addr;
end

assign head_msg[0] = {tsu_nsu_msg_vld[0],tsu_err_msg[0],tsu_nsu_offset[0],tsu_nsu_ost_id
[0]};
assign head_msg[1] = {tsu_nsu_msg_vld[1],tsu_err_msg[1],tsu_nsu_offset[1],tsu_nsu_ost_id
[1]};
assign head_msg[2] = {tsu_nsu_msg_vld[2],tsu_err_msg[2],tsu_nsu_offset[2],tsu_nsu_ost_id
[2]};
assign head_msg[3] = {tsu_nsu_msg_vld[3],tsu_err_msg[3],tsu_nsu_offset[3],tsu_nsu_ost_id
[3]};
assign head_msg[4] = {tsu_nsu_msg_vld[4],tsu_err_msg[4],tsu_nsu_offset[4],tsu_nsu_ost_id
[4]};
assign head_msg[5] = {tsu_nsu_msg_vld[5],tsu_err_msg[5],tsu_nsu_offset[5],tsu_nsu_ost_id
[5]};
assign head_msg[6] = {tsu_nsu_msg_vld[6],tsu_err_msg[6],tsu_nsu_offset[6],tsu_nsu_ost_id
[6]};
assign head_msg[7] = {tsu_nsu_msg_vld[7],tsu_err_msg[7],tsu_nsu_offset[7],tsu_nsu_ost_id
[7]};

assign ping_pong_rdy = !rd_cmd_fifo_full;
assign ping_pong_vld = ping_pong_vld & ping_pong_rdy;
assign rd_cmd_fifo_wdata = {nsu_addr[1],nsu_addr[0],ping_pong_flag,tsu_nsu_last_pack,head_msg
[7],head_msg[6],
                           head_msg[5],head_msg[4],head_msg[3],head_msg[2],head_msg[1],
                           head_msg[0]};

witmem_sfifo_depth #(/*autoinstparam*/
    .FIFO_WIDTH     (401+LBA_LEN*2         )
)
u_rd_cmd_fifo(/*autoinst*/
    .clk            (clk                   ), //input
    .rst_n          (rst_n                 ), //input
    .fifo_clr       (1'b0                  ), //input
    .fifo_req_w     (rd_cmd_fifo_req_w     ), //input
    .fifo_req_r     (rd_cmd_fifo_req_r     ), //input
    .fifo_wdata     (rd_cmd_fifo_wdata     ), //input
    .fifo_rdata     (rd_cmd_fifo_rdata     ), //output
    .fifo_full      (rd_cmd_fifo_full      ), //output
    .fifo_empty     (rd_cmd_fifo_empty     )  //output
);

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        cur_state <= IDLE_STATE;
    else
        cur_state <= nxt_state;
end

always@(*)begin
    case(cur_state)
        IDLE_STATE:
            if(!rd_cmd_fifo_empty & rdat_fifo_afull == 1'b0)
                nxt_state = READ_DAT_SATE;
            else
                nxt_state = IDLE_STATE;
        READ_DAT_SATE:
            if(read_dat_done)
                nxt_state = IDLE_STATE;
            else
                nxt_state = READ_DAT_SATE;
        default:nxt_state = IDLE_STATE;
    endcase
end

assign rd_cmd_fifo_req_r = cur_state == IDLE_STATE & nxt_state == READ_DAT_SATE;
assign vld_flag = (rd_cmd_fifo_rdata[391],rd_cmd_fifo_rdata[342],rd_cmd_fifo_rdata[293],
                   rd_cmd_fifo_rdata[244],
                   rd_cmd_fifo_rdata[195],rd_cmd_fifo_rdata[146],rd_cmd_fifo_rdata[97],
                   rd_cmd_fifo_rdata[48]);
assign sram_ren = cur_state == READ_DAT_SATE & !rdat_fifo_afull;
nsu_get_8bone_num u_nsu_get_8bone_num(/*autoinst*/
    .clk            (clk                   ), //input
    .rst_n          (rst_n                 ), //input
    .dat_in         (vld_flag              ), //input
    .en             (rd_cmd_fifo_req_r     ), //input
    .dat_out        (vld_pack_num          )  //output
);

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        read_flag <= 1'b0;
        tsu_nsu_last_pack_dly <= 'd0;
    end
    else if(rd_cmd_fifo_req_r)begin
        read_flag <= rd_cmd_fifo_rdata[400];
        tsu_nsu_last_pack_dly <= rd_cmd_fifo_rdata[399:392];
    end
end

assign single_read_sram_done = sram_ren & single_read_sram_cnt == 'd15;
assign pp_num = get_first_pos_8(sram_sel);
assign read_dat_done = single_read_sram_done & (mult_sram_read_cnt == vld_pack_num - 1'b1);

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        sram_sel <= 'd0;
    else if(rd_cmd_fifo_req_r)
        sram_sel <= vld_flag;
    else begin
        for(j=0;j<8;j=j+1)begin
            if(single_read_sram_done & j == pp_num)
                sram_sel[j] <= 1'b0;
        end
    end
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        single_read_sram_cnt <= 'd0;
    else if(sram_ren)
        single_read_sram_cnt <= single_read_sram_cnt + 1'b1;
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        mult_sram_read_cnt <= 'd0;
    else if(rd_cmd_fifo_req_r)
        mult_sram_read_cnt <= 'd0;
    else if(single_read_sram_done)
        mult_sram_read_cnt <= mult_sram_read_cnt + 1'b1;
end

case(pp_num)
    'd0,'d4:mult_sram_ren = {3'd0,sram_ren,'1'b0};
    'd1,'d5:mult_sram_ren = {2'd0,sram_ren,2'd0};
    'd2,'d6:mult_sram_ren = {1'd0,sram_ren,3'd0};
    'd3,'d7:mult_sram_ren = {sram_ren,3'd0};
    //'d4:mult_sram_ren = {3'd0,sram_ren,4'd0};
    //'d5:mult_sram_ren = {2'd0,sram_ren,5'd0};
    //'d6:mult_sram_ren = {1'd0,sram_ren,6'd0};
    //'d7:mult_sram_ren = {sram_ren,7'd0};
    default:mult_sram_ren = 4'd0;
endcase

assign pipe_en = rd_cmd_fifo_req_r | single_read_sram_done;

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        pipe_en_dly <= 'd0;
    else
        pipe_en_dly <= {pipe_en_dly[6:0],pipe_en};
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        dat_dly <= 'd0;
    else
        dat_dly <= {dat_dly[6:0],sram_ren};
end

wire  [7:0] act_tsu_nsu_last_pack;
witmem_ip_dly #(/*autoinstparam*/
    .TIME_LENGTH    (4                     ),
    .IN_WIDTH       (4                     )
)
u0_witmem_ip_dly(/*autoinst*/
    .clk            (clk                   ), //input
    .rst_n          (rst_n                 ), //input
    .en             (pipe_en_dly[3:0]      ), //input
    .in             (pp_num                ), //input
    .out            (pipe_out              )  //output
);

witmem_ip_dly #(/*autoinstparam*/
    .TIME_LENGTH    (4                     ),
    .IN_WIDTH       (8                     )
)
u1_witmem_ip_dly(/*autoinst*/
    .clk            (clk                   ), //input
    .rst_n          (rst_n                 ), //input
    .en             (pipe_en_dly[3:0]      ), //input
    .in             (tsu_nsu_last_pack_dly ), //input
    .out            (act_tsu_nsu_last_pack )  //output
);

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        pipe_out_dly <= 'd0;
    else if(pipe_en_dly[4])
        pipe_out_dly <= pipe_out;
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        rd_data_cnt <= 'd0;
    else if(dat_dly[3])
        rd_data_cnt <= rd_data_cnt + 1'b1;
end

assign rd_dat_last = dat_dly[3] & rd_data_cnt == 'd15;

wire  [3:0]  tsu_last_4k   ;
assign tsu_last_4k = (pipe_out[3:2]==2'b00) ? act_tsu_nsu_last_pack[3:0] :
act_tsu_nsu_last_pack[7:4];

always@(posedge clk) begin
    if(dat_dly[3])begin
        case(pipe_out)
            'd0,'d4:begin
                data_out0 <= dat0_sram_rat[0];
                data_out1 <= dat1_sram_rat[0];
                data_out2 <= dat2_sram_rat[0];
                data_out3 <= {tsu_last_4k[0],rd_dat_last,dat3_sram_rat[0]};
            end
            'd1,'d5:begin
                data_out0 <= dat0_sram_rat[1];
                data_out1 <= dat1_sram_rat[1];
                data_out2 <= dat2_sram_rat[1];
                data_out3 <= {tsu_last_4k[1],rd_dat_last,dat3_sram_rat[1]};
            end
            'd2,'d6:begin
                data_out0 <= dat0_sram_rat[2];
                data_out1 <= dat1_sram_rat[2];
                data_out2 <= dat2_sram_rat[2];
                data_out3 <= {tsu_last_4k[2],rd_dat_last,dat3_sram_rat[2]};
            end
            'd3,'d7:begin
                data_out0 <= dat0_sram_rat[3];
                data_out1 <= dat1_sram_rat[3];
                data_out2 <= dat2_sram_rat[3];
                data_out3 <= {tsu_last_4k[3],rd_dat_last,dat3_sram_rat[3]};
            end
            default:begin
                data_out0 <= dat0_sram_rat[0];
                data_out1 <= dat1_sram_rat[0];
                data_out2 <= dat2_sram_rat[0];
                data_out3 <= {tsu_last_4k[0],rd_dat_last,dat3_sram_rat[0]};
            end
        endcase
    end
end

assign out_fifo_wen = dat_dly[4] | rd_cmd_fifo_req_r;
assign out_fifo_wdat[0] = rd_cmd_fifo_req_r ? {rd_cmd_fifo_rdata[48],171'd0,nsu_addr[0],6'd0,
rd_cmd_fifo_rdata[47:0]} : data_out0[255:0];
assign out_fifo_wdat[1] = rd_cmd_fifo_req_r ? {rd_cmd_fifo_rdata[97],171'd0,nsu_addr[0],6'd0,
rd_cmd_fifo_rdata[96:49]} : data_out1[255:0];
assign out_fifo_wdat[2] = rd_cmd_fifo_req_r ? {rd_cmd_fifo_rdata[146],171'd0,nsu_addr[0],6'd0,
rd_cmd_fifo_rdata[145:98]} : data_out2[255:0];
assign out_fifo_wdat[3] = rd_cmd_fifo_req_r ? {rd_cmd_fifo_rdata[195],171'd0,nsu_addr[0],6'd0,
rd_cmd_fifo_rdata[194:147]} : data_out3[255:0];
assign out_fifo_wdat[4] = rd_cmd_fifo_req_r ? {rd_cmd_fifo_rdata[244],171'd0,nsu_addr[0],6'd0,
rd_cmd_fifo_rdata[243:196]} : data_out2[255:0];
assign out_fifo_wdat[5] = rd_cmd_fifo_req_r ? {rd_cmd_fifo_rdata[293],171'd0,nsu_addr[1],6'd0,
rd_cmd_fifo_rdata[292:245]} : data_out1[255:0];
assign out_fifo_wdat[6] = rd_cmd_fifo_req_r ? {rd_cmd_fifo_rdata[342],171'd0,nsu_addr[1],6'd0,
rd_cmd_fifo_rdata[341:294]} : data_out0[255:0];
assign out_fifo_wdat[7] = rd_cmd_fifo_req_r ? {2'b0,rd_cmd_fifo_rdata[391],513:256};

assign tsu_nsu_r_vld = !rdat_fifo_empty[0];
assign tsu_nsu_r_rdy = tsu_nsu_r_vld & tsu_nsu_r_rdy;

dw_sfifo #(/*autoinstparam*/
    .REG_OUT        ("false"               ),
    .DATA_WIDTH     (256                   ),
    .ADDR_WIDTH     (3                     )
)
u_dat0_fifo(/*autoinst*/
    .clk            (clk                   ), //input
    .rst_n          (rst_n                 ), //input
    .wen            (out_fifo_wen[0]       ), //input
    .wdata          (out_fifo_wdat[0]      ), //input
    .ren            (out_fifo_ren[0]       ), //input
    .ae_level       (3'd7                  ), //input
    .af_level       (3'd2                  ), //input
    .rdata          (tsu_nsu_r_dat[255:0]  ), //output
    .word_cnt       (                      ), //output
    .alfull         (rdat_fifo_afull       ), //output
    .alempty        (                      ), //output
    .full           (                      ), //output
    .empty          (rdat_fifo_empty[0]    )  //output
);

dw_sfifo #(/*autoinstparam*/
    .REG_OUT        ("false"               ),
    .DATA_WIDTH     (256                   ),
    .ADDR_WIDTH     (3                     )
)
u_dat1_fifo(/*autoinst*/
    .clk            (clk                   ), //input
    .rst_n          (rst_n                 ), //input
    .wen            (out_fifo_wen[1]       ), //input
    .wdata          (out_fifo_wdat[1]      ), //input
    .ren            (out_fifo_ren[1]       ), //input
    .ae_level       (3'd7                  ), //input
    .af_level       (3'd2                  ), //input
    .rdata          (tsu_nsu_r_dat[511:256]), //output
    .word_cnt       (                      ), //output
    .alfull         (                      ), //output
    .alempty        (                      ), //output
    .full           (                      ), //output
    .empty          (rdat_fifo_empty[1]    )  //output
);

dw_sfifo #(/*autoinstparam*/
    .REG_OUT        ("false"               ),
    .DATA_WIDTH     (256                   ),
    .ADDR_WIDTH     (3                     )
)
u_dat2_fifo(/*autoinst*/
    .clk            (clk                   ), //input
    .rst_n          (rst_n                 ), //input
    .wen            (out_fifo_wen[2]       ), //input
    .wdata          (out_fifo_wdat[2]      ), //input
    .ren            (out_fifo_ren[2]       ), //input
    .ae_level       (3'd7                  ), //input
    .af_level       (3'd2                  ), //input
    .rdata          (tsu_nsu_r_dat[767:512]), //output
    .word_cnt       (                      ), //output
    .alfull         (                      ), //output
    .alempty        (                      ), //output
    .full           (                      ), //output
    .empty          (rdat_fifo_empty[2]    )  //output
);

dw_sfifo #(/*autoinstparam*/
    .REG_OUT        ("false"               ),
    .DATA_WIDTH     (256                   ),
    .ADDR_WIDTH     (3                     )
)
u_dat3_fifo(/*autoinst*/
    .clk            (clk                   ), //input
    .rst_n          (rst_n                 ), //input
    .wen            (out_fifo_wen[3]       ), //input
    .wdata          (out_fifo_wdat[3]      ), //input
    .ren            (out_fifo_ren[3]       ), //input
    .ae_level       (3'd7                  ), //input
    .af_level       (3'd2                  ), //input
    .rdata          (tsu_nsu_r_dat[1023:768]), //output
    .word_cnt       (                      ), //output
    .alfull         (                      ), //output
    .alempty        (                      ), //output
    .full           (                      ), //output
    .empty          (rdat_fifo_empty[3]    )  //output
);

dw_sfifo #(/*autoinstparam*/
    .REG_OUT        ("false"               ),
    .DATA_WIDTH     (256                   ),
    .ADDR_WIDTH     (3                     )
)
u_dat4_fifo(/*autoinst*/
    .clk            (clk                   ), //input
    .rst_n          (rst_n                 ), //input
    .wen            (out_fifo_wen[4]       ), //input
    .wdata          (out_fifo_wdat[4]      ), //input
    .ren            (out_fifo_ren[4]       ), //input
    .ae_level       (3'd7                  ), //input
    .af_level       (3'd2                  ), //input
    .rdata          (tsu_nsu_r_dat[1279:1024]), //output
    .word_cnt       (                      ), //output
    .alfull         (                      ), //output
    .alempty        (                      ), //output
    .full           (                      ), //output
    .empty          (rdat_fifo_empty[4]    )  //output
);

dw_sfifo #(/*autoinstparam*/
    .REG_OUT        ("false"               ),
    .DATA_WIDTH     (256                   ),
    .ADDR_WIDTH     (3                     )
)
u_dat5_fifo(/*autoinst*/
    .clk            (clk                   ), //input
    .rst_n          (rst_n                 ), //input
    .wen            (out_fifo_wen[5]       ), //input
    .wdata          (out_fifo_wdat[5]      ), //input
    .ren            (out_fifo_ren[5]       ), //input
    .ae_level       (3'd7                  ), //input
    .af_level       (3'd2                  ), //input
    .rdata          (tsu_nsu_r_dat[1535:1280]), //output
    .word_cnt       (                      ), //output
    .alfull         (                      ), //output
    .alempty        (                      ), //output
    .full           (                      ), //output
    .empty          (rdat_fifo_empty[5]    )  //output
);

dw_sfifo #(/*autoinstparam*/
    .REG_OUT        ("false"               ),
    .DATA_WIDTH     (256                   ),
    .ADDR_WIDTH     (3                     )
)
u_dat6_fifo(/*autoinst*/
    .clk            (clk                   ), //input
    .rst_n          (rst_n                 ), //input
    .wen            (out_fifo_wen[6]       ), //input
    .wdata          (out_fifo_wdat[6]      ), //input
    .ren            (out_fifo_ren[6]       ), //input
    .ae_level       (3'd7                  ), //input
    .af_level       (3'd2                  ), //input
    .rdata          (tsu_nsu_r_dat[1791:1536]), //output
    .word_cnt       (                      ), //output
    .alfull         (                      ), //output
    .alempty        (                      ), //output
    .full           (                      ), //output
    .empty          (rdat_fifo_empty[6]    )  //output
);

dw_sfifo #(/*autoinstparam*/
    .REG_OUT        ("false"               ),
    .DATA_WIDTH     (256                   ),
    .ADDR_WIDTH     (3                     )
)
u_dat7_fifo(/*autoinst*/
    .clk            (clk                   ), //input
    .rst_n          (rst_n                 ), //input
    .wen            (out_fifo_wen[7]       ), //input
    .wdata          (out_fifo_wdat[7]      ), //input
    .ren            (out_fifo_ren[7]       ), //input
    .ae_level       (3'd7                  ), //input
    .af_level       (3'd2                  ), //input
    .rdata          (tsu_nsu_r_dat[NSU_RDATA_WIDTH+1:1792]), //output
    .word_cnt       (                      ), //output
    .alfull         (                      ), //output
    .alempty        (                      ), //output
    .full           (                      ), //output
    .empty          (rdat_fifo_empty[7]    )  //output
);

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        cnt_clr_pipe <= 1'b0;
    else if(tsu_rcmd_done_cnt_clr)
        cnt_clr_pipe <= 1'b1;
    else
        cnt_clr_pipe <= 1'b0;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        tsu_rcmd_done_cnt <= 'b0;
    else if(cnt_clr_pipe)
        tsu_rcmd_done_cnt <= 'b0;
    else if(tsu_nsu_r_vld & tsu_nsu_r_rdy & (tsu_nsu_r_dat[NSU_RDATA_WIDTH+1:NSU_RDATA_WIDTH]
    == 2'b11))
        tsu_rcmd_done_cnt <= tsu_rcmd_done_cnt + 1'b1;
end

function [3:0] get_first_pos_8;
    input [7:0] i_data;
    reg  [2:0] pos0;
    reg  [2:0] pos1;
begin
    pos0 = get_first_pos_4(i_data[4*0+:4]);
    pos1 = get_first_pos_4(i_data[4*1+:4]);
    get_first_pos_8 = (pos0 != 'd7) ? pos0 + 4'd0 :
                      (pos1 != 'd7) ? pos1 + 4'd4 : 4'hf;
end
endfunction

function [2:0] get_first_pos_4;
    input [3:0] i_data;
begin
    casez(i_data)
        4'b???1: get_first_pos_4 = 3'd0;
        4'b??10: get_first_pos_4 = 3'd1;
        4'b?100: get_first_pos_4 = 3'd2;
        4'b1000: get_first_pos_4 = 3'd3;
        default: get_first_pos_4 = 3'd7;
    endcase
end
endfunction

//Local Variables:
//verilog-library-directories:(".")
//verilog-library-directories-recursive:0
//End:
endmodule