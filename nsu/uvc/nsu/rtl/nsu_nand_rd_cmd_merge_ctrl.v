`timescale 1ns/1ps

module nsu_nand_rd_cmd_merge_ctrl(/*autoarg*/
    // Inputs
    clk, rst_n,
    io_fast_read_err_report,
    cfg_error_flag,
    cfg_error_flag_mask,
    cfg_lba_mask, fifo_clr,
    io_fast_read_err_dis,
    error_flag_position,
    lba_position,
    meta_data_base_addr,
    off_wbf_fail_base_addr,
    read_resp_que0_ready,
    read_resp_que1_ready,
    read_resp_que2_ready,
    read_resp_que3_ready,
    read_resp_que_ready,
    read_resp_que0_start_addr,
    read_resp_que1_start_addr,
    read_resp_que2_start_addr,
    read_resp_que3_start_addr,
    read_resp_que0_len,
    read_resp_que1_len,
    read_resp_que2_len,
    read_resp_que3_len,
    act_read_resp_que0_len,
    act_read_resp_que1_len,
    act_read_resp_que2_len,
    act_read_resp_que3_len,
    deep_read_que_ready,
    msa_resp_sram_rden,
    msa_resp_sram_raddr,
    msa_resp_que_full,
    on_dec0_cmd_vld,
    on_dec1_cmd_vld,
    on_dec2_cmd_vld,
    on_dec3_cmd_vld,
    on_dec4_cmd_vld,
    on_dec5_cmd_vld,
    on_dec6_cmd_vld,
    on_dec7_cmd_vld,
    on_dec0_cmd,
    on_dec1_cmd,
    on_dec2_cmd,
    on_dec3_cmd,
    on_dec4_cmd,
    on_dec5_cmd,
    on_dec6_cmd,
    on_dec7_cmd,
    on_dec0_dat_done,
    on_dec1_dat_done,
    on_dec2_dat_done,
    on_dec3_dat_done,
    on_dec4_dat_done,
    on_dec5_dat_done,
    on_dec6_dat_done,
    on_dec7_dat_done,
    offline_wbf_cmd_vld,
    offline_wbf_cmd, grant,
    ping_pong_rdy,
    tx_off_wbf_rdy,
    msa_write_done,
    online_write_done,
    off_wbf_write_done,
    unmap_write_done, lm_wack,
    lm_wrdy, lm_wdone_id,
    lm_wdone_id_vld,
    nsu_info_rdy,
    tsu_req_ost_id,

    // Outputs
    online_dec_fast_fail_stat,
    online_dec_fast_pass_stat,
    online_dec_safe_fail_stat,
    online_dec_safe_pass_stat,
    read_resp_que_wcen,
    read_resp_que_waddr,
    read_resp_que_din,
    read_resp_que0_wcen,
    read_resp_que1_wcen,
    read_resp_que2_wcen,
    read_resp_que3_wcen,
    write_read_resp_que0_err,
    write_read_resp_que1_err,
    write_read_resp_que2_err,
    write_read_resp_que3_err,
    deep_read_que_wren,
    deep_read_sram_wren,
    deep_read_sram_wdat,
    deep_read_sram_waddr,
    msa_resp_sram_rdat,
    msa_resp_sram_rdat_vld,
    msa_resp_que_wren,
    on_dec0_cmd_rdy,
    on_dec1_cmd_rdy,
    on_dec2_cmd_rdy,
    on_dec3_cmd_rdy,
    on_dec4_cmd_rdy,
    on_dec5_cmd_rdy,
    on_dec6_cmd_rdy,
    on_dec7_cmd_rdy,
    on_dec_done_afull,
    hw_unmap_rdy,
    sw_unmap_rdy, msa_cmd_rdy,
    offline_wbf_cmd_rdy,
    req_cmd_vld,
    online_fast_safe_flag,
    ping_pong_flag,
    ping_pong_vld,
    tx_off_wbf_vld,
    tx_off_wbf_dat, cmd_sel,
    unmap_read_sel,
    online_data_rdvld,
    msa_dat_addr,
    msa_dat_addr_vld,
    off_wbf_dat_addr,
    off_wbf_addr_vld,
    off_wbf_pp_vld, lm_wreq,
    lm_wid, lm_wlen, lm_waddr,
    lm_wvld, lm_wdat,
    lm_wdat_last, lm_wmask,
    nsu_get_msg_vld,
    nsu_plane_sel,
    nsu_rd_ost_id, nsu_rd_lba,
    tsu_nsu_err_msg,
    nsu_rd_ost_id_vld,
    nsu_info_vld, nsu_info,
    cmd_arb_done
);

//============================Parameter============================
parameter DEC_CMD_WIDTH            = 32 ;
parameter DGT_SID_NSU_INFO_DATA_WIDTH = 17;
parameter DATA_WIDTH               = 256;
parameter ADDR_WIDTH               = 34 ;
parameter BLEN_WIDTH               = 9 ;
parameter ID_WIDTH                 = 10;
parameter LBA_LEN                  = 30;
parameter OST_WH                   = 5;
parameter HW_UNMAP_WH              = 45;
parameter MSA_RESP_ADDR            = 3;
parameter READ_RESP_ADDR           = 7;
parameter DEEP_READ_ADDR           = 12;
localparam STRB_WIDTH              = DATA_WIDTH/8;
localparam CMD_PIPE_NUM            = 12;
localparam ONLINE_WIDTH            = DEC_CMD_WIDTH*CMD_PIPE_NUM ;
localparam DEEP_CNT_MAX            = 27;
localparam DEEP_ADDR_MAX           = 3051;
localparam IDLE_STATE              = 4'd0;
localparam ONLIE_STATE             = 4'd1;  // 图片原拼写，未修改
localparam FAST_STATE              = 4'd2;
localparam RESP_STATE              = 4'd3;
localparam SAFE_STATE              = 4'd4;
localparam TX_WBF_STATE            = 4'd5;
localparam RX_WBF_STATE            = 4'd6;
localparam UNMAP_STATE             = 4'd7;
localparam MSA_STATE               = 4'd9;
localparam DONE_STATE              = 4'd10;

//============================In/Out Signal============================
// CFG Interface
input                           clk;
input                           rst_n;
input                           io_fast_read_err_report;
input      [31:0]               cfg_error_flag;
input      [31:0]               cfg_error_flag_mask;
input      [31:0]               cfg_lba_mask;
input                           fifo_clr;
input                           io_fast_read_err_dis;
input      [1:0]                error_flag_position;  // TODO
input      [1:0]                lba_position;         // TODO
output reg [31:0]               online_dec_fast_fail_stat;
output reg [31:0]               online_dec_fast_pass_stat;
output reg [31:0]               online_dec_safe_fail_stat;
output reg [31:0]               online_dec_safe_pass_stat;
input      [31:0]               meta_data_base_addr;  // TODO
input      [31:0]               off_wbf_fail_base_addr;

// Read Response Queue Interface
input                           read_resp_que0_ready;
input                           read_resp_que1_ready;
input                           read_resp_que2_ready;
input                           read_resp_que3_ready;
output                          read_resp_que_wcen;
output     [READ_RESP_ADDR-1:0]  read_resp_que_waddr;
output     [31:0]               read_resp_que_din;
output                          read_resp_que0_wcen;
output                          read_resp_que1_wcen;
output                          read_resp_que2_wcen;
output                          read_resp_que3_wcen;
input      [READ_RESP_ADDR-1:0]  read_resp_que0_start_addr;
input      [READ_RESP_ADDR-1:0]  read_resp_que1_start_addr;
input      [READ_RESP_ADDR-1:0]  read_resp_que2_start_addr;
input      [READ_RESP_ADDR-1:0]  read_resp_que3_start_addr;
input      [READ_RESP_ADDR-0:0]  read_resp_que0_len;
input      [READ_RESP_ADDR-0:0]  read_resp_que1_len;
input      [READ_RESP_ADDR-0:0]  read_resp_que2_len;
input      [READ_RESP_ADDR-0:0]  read_resp_que3_len;
input      [READ_RESP_ADDR-1:0]  act_read_resp_que0_len;
input      [READ_RESP_ADDR-1:0]  act_read_resp_que1_len;
input      [READ_RESP_ADDR-1:0]  act_read_resp_que2_len;
input      [READ_RESP_ADDR-1:0]  act_read_resp_que3_len;
output                          write_read_resp_que0_err;
output                          write_read_resp_que1_err;
output                          write_read_resp_que2_err;
output                          write_read_resp_que3_err;

// Deep Read Response Control
input                           deep_read_que_ready;
output                          deep_read_que_wren;
output                          deep_read_sram_wren;
output     [31:0]               deep_read_sram_wdat;
output reg [DEEP_READ_ADDR-1:0]  deep_read_sram_waddr;

// MSA Resp Queue
input                           msa_resp_sram_rden;
input      [MSA_RESP_ADDR-1:0]   msa_resp_sram_raddr;
output     [15:0]               msa_resp_sram_rdat;
output                          msa_resp_sram_rdat_vld;
output                          msa_resp_que_wren;
input                           msa_resp_que_full;

// Online Decoder to NSU Interface x8
input                           on_dec0_cmd_vld;
output                          on_dec0_cmd_rdy;
input      [DEC_CMD_WIDTH-1:0]   on_dec0_cmd;
input                           on_dec0_dat_done;

input                           on_dec1_cmd_vld;
output                          on_dec1_cmd_rdy;
input      [DEC_CMD_WIDTH-1:0]   on_dec1_cmd;
input                           on_dec1_dat_done;

input                           on_dec2_cmd_vld;
output                          on_dec2_cmd_rdy;
input      [DEC_CMD_WIDTH-1:0]   on_dec2_cmd;
input                           on_dec2_dat_done;

input                           on_dec3_cmd_vld;
output                          on_dec3_cmd_rdy;
input      [DEC_CMD_WIDTH-1:0]   on_dec3_cmd;
input                           on_dec3_dat_done;

input                           on_dec4_cmd_vld;
output                          on_dec4_cmd_rdy;
input      [DEC_CMD_WIDTH-1:0]   on_dec4_cmd;
input                           on_dec4_dat_done;

input                           on_dec5_cmd_vld;
output                          on_dec5_cmd_rdy;
input      [DEC_CMD_WIDTH-1:0]   on_dec5_cmd;
input                           on_dec5_dat_done;

input                           on_dec6_cmd_vld;
output                          on_dec6_cmd_rdy;
input      [DEC_CMD_WIDTH-1:0]   on_dec6_cmd;
input                           on_dec6_dat_done;

input                           on_dec7_cmd_vld;
output                          on_dec7_cmd_rdy;
input      [DEC_CMD_WIDTH-1:0]   on_dec7_cmd;
input                           on_dec7_dat_done;

output                          on_dec_done_afull;

// CMD Input Interface
input                           hw_unmap_vld;
output                          hw_unmap_rdy;
input      [HW_UNMAP_WH-1:0]     hw_unmap_cmd;

input                           sw_unmap_vld;
output                          sw_unmap_rdy;
input      [31:0]               sw_unmap_cmd;

input                           msa_cmd_vld;
output                          msa_cmd_rdy;
input      [31:0]               msa_cmd;

input                           offline_wbf_cmd_vld;
output                          offline_wbf_cmd_rdy;
input      [63:0]               offline_wbf_cmd;

// CMD Grant
output     [4:0]                req_cmd_vld;
input      [4:0]                grant;
output reg                      online_fast_safe_flag;

// Ping Pong
output reg                      ping_pong_flag;
input                           ping_pong_vld;
input                           ping_pong_rdy;

// TX OFF WBF
output                          tx_off_wbf_vld;
input                           tx_off_wbf_rdy;
output     [63:0]               tx_off_wbf_dat;

// Read Date Control and Write Done（图片原拼写，未修改）
input                           msa_write_done;
input                           online_write_done;
input                           off_wbf_write_done;
input      [7:0]                unmap_write_done;

output reg [2:0]                cmd_sel;
output reg [7:0]                unmap_read_sel;
output reg [7:0]                online_data_rdvld;
output reg [31:0]               msa_dat_addr;
output reg                      msa_dat_addr_vld;
output reg [31:0]               off_wbf_dat_addr;
output reg [7:0]                off_wbf_addr_vld;
output reg [7:0]                off_wbf_pp_vld;

// AXI MST Interface
output                          lm_wreq;
input                           lm_wack;
output     [ID_WIDTH-1:0]       lm_wid;
output     [BLEN_WIDTH-1:0]      lm_wlen;
output     [ADDR_WIDTH-1:0]      lm_waddr;
output                          lm_wvld;
input                           lm_wrdy;
output     [DATA_WIDTH-1:0]      lm_wdat;
output                          lm_wdat_last;
output     [STRB_WIDTH-1:0]      lm_wmask;
input      [ID_WIDTH-1:0]       lm_wdone_id;
input                           lm_wdone_id_vld;

// Get OST ID and LBA Offset Signal
output                          nsu_get_msg_vld;
output reg                      nsu_plane_sel;
output reg [OST_WH-1:0]         nsu_rd_ost_id;
output reg [LBA_LEN-1:0]        nsu_rd_lba;
output reg [31:0]               tsu_nsu_err_msg;
output reg                      nsu_rd_ost_id_vld;
output reg                      nsu_info_vld;
output     [DGT_SID_NSU_INFO_DATA_WIDTH-1:0] nsu_info;
input                           nsu_info_rdy;
input      [7:0]                tsu_req_ost_id;
output                          cmd_arb_done;

//============================Wire/Reg SIGNAL============================
/*autowire*/
reg        [3:0]                cur_state;
reg        [3:0]                nxt_state;
wire       [7:0]                in_vld;
wire       [7:0]                in_ready;
wire       [DEC_CMD_WIDTH*8-1:0] in_dat;
wire       [7:0]                dec_fifo_wen;
wire       [7:0]                dec_fifo_ren;
wire       [ONLINE_WIDTH-1:0]   dec_fifo_rdat;
wire       [7:0]                dec_full;
wire       [7:0]                dec_empty;
wire       [7:0]                on_dec_dat_done;
wire       [7:0]                on_dec_done_empty;
wire       [7:0]                on_dec_done_full;
reg        [7:0]                on_dec_done_wren;
wire       [7:0]                on_dec_done_flag;
wire       [7:0]                on_dec_done_rden;
wire       [7:0]                plane_pair_wdone;

// CMD FIFO
wire                            hw_unmap_fifo_req_w;
wire                            hw_unmap_fifo_req_r;
wire       [HW_UNMAP_WH-1:0]     hw_unmap_fifo_wdata;
wire       [HW_UNMAP_WH-1:0]     hw_unmap_fifo_rdata;
wire                            hw_unmap_fifo_full;
wire                            hw_unmap_fifo_empty;

wire                            sw_unmap_fifo_req_w;
wire                            sw_unmap_fifo_req_r;
wire       [31:0]               sw_unmap_fifo_wdata;
wire       [31:0]               sw_unmap_fifo_rdata;
wire                            sw_unmap_fifo_full;
wire                            sw_unmap_fifo_empty;

wire                            unmap_rden;
reg                             unmap_rden_dly;

wire                            msa_cmd_fifo_req_w;
wire                            msa_cmd_fifo_req_r;
wire       [31:0]               msa_cmd_fifo_wdata;
wire       [127:0]              msa_cmd_fifo_rdata;
wire                            msa_cmd_fifo_full;
wire                            msa_cmd_fifo_empty;

wire                            offline_wbf_fifo_req_w;
wire                            offline_wbf_fifo_req_r;
wire       [63:0]               offline_wbf_fifo_wdata;
wire       [2559:0]             offline_wbf_fifo_rdata;
wire                            offline_wbf_fifo_full;
wire                            offline_wbf_fifo_empty;
reg                             off_wbf_wr_dat_done;

// CMD MUX
wire       [15:0]               inst_index;
wire       [7:0]                nand_index;
wire                            dis_read_data;
wire       [OST_WH-1:0]         group1_ost_id;
wire       [OST_WH-1:0]         group0_ost_id;
wire                            prg_verify;
wire                            fast_safe_flag;
wire       [1:0]                resp_sel_que;
wire       [1:0]                meta_mode;
wire       [1:0]                deep_read_sel;
wire       [7:0]                dest_sel;
wire       [7:0]                err_report;
wire       [7:0]                plane_sel;
wire       [7:0]                dec_status;
wire       [8:0]                correct_num [7:0];
wire       [7:0]                plane0_empty;
wire       [7:0]                plane1_empty;
wire       [15:0]               plane0_set_bit [7:0];
wire       [15:0]               plane1_set_bit [7:0];
wire       [31:0]               group0_meta_id;
wire       [31:0]               group1_meta_id;
wire       [31:0]               dest_addr [7:0];

// 图片中后续零散信号（按出现顺序提取）
wire       [7:0]                fail_addr;
wire       [15:0]               group0_blk_addr;
wire       [15:0]               group1_blk_addr;
wire       [11:0]               group0_page_addr;
wire       [11:0]               group1_page_addr;
wire       [31:0]               meta_data0 [7:0];
wire       [31:0]               meta_data1 [7:0];
wire       [31:0]               meta_data2 [7:0];
wire       [31:0]               meta_data3 [7:0];
wire       [7:0]                off_wbf_work_en;
wire       [7:0]                threshold;
wire       [7:0]                flip_threshold_sel;
wire       [15:0]               seed [7:0];
wire       [7:0]                descramble_en;
wire       [7:0]                dat_out_en;
wire       [31:0]               msa_err_bit;
wire       [31:0]               msa_src_addr;
wire       [31:0]               act_lba;
reg        [7:0]                online_dat_fast_rdvld;
reg        [7:0]                online_dat_safe_rdvld;
reg                             online_fast_resp_wren;
reg                             online_fast_deep_resp_wren;
reg                             online_safe_resp_wren;
reg                             online_safe_deep_resp_wren;
reg                             off_wbf_resp_wren;
reg                             read_resp_wren;
wire                            online_wr_dat_done;
wire                            wr_dat_done;
wire                            cmd_rd_en;
wire                            lba_compute_en;
reg        [1:0]                cmd_rd_en_dly;
reg                             complete;
wire       [7:0]                comp_lba;
wire       [7:0]                comp_err_flag;
wire       [7:0]                comp_err_bit [7:0];
reg        [31:0]               dat_flag [7:0];
wire       [7:0]                err_plane_pair;
wire       [7:0]                set_err;
wire       [7:0]                decoder_err;
wire                            read_resp_wr_start;
wire                            read_resp_wr_done;
wire                            read_resp_wr_busy;
reg                             read_resp_que_busy;
wire       [31:0]               read_resp_que_status;
wire       [31:0]               deep_resp_que_wr_start;

wire       [31:0]               deep_read_status [DEEP_CNT_MAX:0];
reg        [7:0]                plane_pair_err;
wire                            write_meta_start;
reg                             write_meta_done;
wire                            write_meta_busy;
wire                            meta_data_busy;

// tx off wbf signal
wire                            tx_off_wbf_cmd_start;
wire                            tx_off_wbf_cmd_busy;
wire       [31:0]               group0_dest_addr;
wire       [31:0]               group1_dest_addr;
reg        [7:0]                rd_sel;
reg                             online_io_read_flag;
reg                             cpu_io_rd_flag;
reg                             off_wbf_io_read_flag;
wire                            tsu_io_read_data_flag;
reg                             io_read_send_en;
reg                             off_wbf_deep_resp_wren;
wire                            deep_resp_wren;
wire                            state_done;
wire                            msa_resp_sram_wren;
wire       [15:0]               msa_resp_sram_wdat;
reg                             msa_resp_sram_vld;
reg        [MSA_RESP_ADDR-1:0]   msa_resp_sram_waddr;
wire                            mux_ping_pong_rdy;

wire                            rd_nsu_info_vld;
wire                            nsu_info_fifo_req_w;
wire                            nsu_info_fifo_req_r;
wire       [31:0]               nsu_info_fifo_wdata;
wire       [15:0]               nsu_info_fifo_rdata;
wire                            nsu_info_fifo_full;
wire                            nsu_info_fifo_empty;
reg                             rd_nsu_info_vld_dly;
reg        [7:0]                tsu_group0_ost_id;
reg        [7:0]                tsu_group1_ost_id;
reg                             tsu_group_flag;
wire       [3:0]                group0_len;
wire       [3:0]                group1_len;
reg                             nsu_info_out_cnt;
wire       [31:0]               nand_lba [7:0];
wire       [31:0]               nand_error_flag [7:0];
reg        [7:0]                unmap_busy;
wire       [7:0]                unmap_plane_sel;

genvar i;
genvar j;

//============================Process============================
// 输入有效/就绪/数据拼接
assign in_vld = {on_dec7_cmd_vld,on_dec6_cmd_vld,on_dec5_cmd_vld,on_dec4_cmd_vld,
                 on_dec3_cmd_vld,on_dec2_cmd_vld,on_dec1_cmd_vld,on_dec0_cmd_vld};
assign {on_dec7_cmd_rdy,on_dec6_cmd_rdy,on_dec5_cmd_rdy,on_dec4_cmd_rdy,
        on_dec3_cmd_rdy,on_dec2_cmd_rdy,on_dec1_cmd_rdy,on_dec0_cmd_rdy} = in_ready;
assign in_dat = {on_dec7_cmd,on_dec6_cmd,on_dec5_cmd,on_dec4_cmd,
                 on_dec3_cmd,on_dec2_cmd,on_dec1_cmd,on_dec0_cmd};
assign {on_dec7_dat_done,on_dec6_dat_done,on_dec5_dat_done,on_dec4_dat_done,
        on_dec3_dat_done,on_dec2_dat_done,on_dec1_dat_done,on_dec0_dat_done} = on_dec_dat_done;

// CMD req vld control
assign req_cmd_vld[0] = dec_empty == 8'b0;
assign req_cmd_vld[1] = !offline_wbf_fifo_empty;
assign req_cmd_vld[2] = !msa_cmd_fifo_empty;
assign req_cmd_vld[3] = !hw_unmap_fifo_empty;
assign req_cmd_vld[4] = !sw_unmap_fifo_empty;

// 状态完成标志
assign state_done = cur_state == DONE_STATE & nxt_state == IDLE_STATE;
assign online_wr_dat_done = online_data_rdvld == 8'b0;
assign wr_dat_done = cmd_sel == 'd1 ? online_wr_dat_done : off_wbf_wr_dat_done;
assign complete = $plane_pair_wdone;  // 图片中$plane_pair_wdone模糊，按原代码保留
assign mux_ping_pong_rdy = tsu_io_read_data_flag ? (ping_pong_rdy && nsu_info_fifo_full == 1'b0) : 1'b1;

// NSU info control
assign group0_len = rd_sel[0] + rd_sel[1] + rd_sel[2] + rd_sel[3];
assign group1_len = rd_sel[4] + rd_sel[5] + rd_sel[6] + rd_sel[7];
reg [3:0] io_group1_len;
reg [3:0] io_group0_len;

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        io_group1_len <= 'd0;
    else if(rd_nsu_info_vld_dly && tsu_group_flag == 1'b1)begin
        if(tsu_group0_ost_id == tsu_req_ost_id)
            io_group0_len <= 'd0;
        else
            io_group1_len <= group0_len + group1_len;
    end
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        io_group0_len <= 'd0;
    else if(rd_nsu_info_vld_dly && tsu_group_flag == 1'b1)begin
        if(tsu_group0_ost_id == tsu_req_ost_id)
            io_group0_len <= 'd0;
        else
            io_group1_len <= group_len;  // group_len 图片中未明确定义，按原代码保留
    end
end

// modify:2/27
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        rd_nsu_info_vld_dly <= 1'b0;
    else if(tsu_io_read_data_flag && rd_nsu_info_vld)
        rd_nsu_info_vld_dly <= 1'b1;
    else
        rd_nsu_info_vld_dly <= 1'b0;
end

assign rd_nsu_info_vld = cmd_rd_en_dly[0] | cmd_rd_en_dly[4];

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        tsu_group_flag <= 1'b0;
    else if(rd_nsu_info_vld_dly)
        tsu_group_flag <= ~tsu_group_flag;
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        tsu_group0_ost_id <= 'd0;
    else if(rd_nsu_info_vld_dly && tsu_group_flag == 1'b0 )
        tsu_group0_ost_id <= tsu_req_ost_id;
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        tsu_group1_ost_id <= 'd0;
    else if(rd_nsu_info_vld_dly && tsu_group_flag == 1'b1 )
        tsu_group1_ost_id <= tsu_req_ost_id;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        nsu_info_out_cnt <= 1'b0;
    else if(nsu_info_fifo_req_r)
        nsu_info_out_cnt <= ~nsu_info_out_cnt;
end

assign nsu_info_fifo_req_w = ping_pong_vld & mux_ping_pong_rdy;
assign nsu_info_fifo_wdata = {8'd0,io_group1_len,io_group0_len,tsu_group1_ost_id,tsu_group0_ost_id};
assign nsu_info_fifo_req_r = nsu_info_vld & nsu_info_rdy;
assign nsu_info_vld = !nsu_info_fifo_empty;
assign nsu_info[DGT_SID_NSU_INFO_DATA_WIDTH-2:0] = nsu_info_fifo_rdata;
assign nsu_info[DGT_SID_NSU_INFO_DATA_WIDTH-1] = nsu_info_vld & nsu_info_out_cnt;

// NSU Info FIFO 例化
nsu_fifo_conv_width #(/*autoinstparam*/
    .COMMON_DIVISOR     (16                  ),
    .IN_WIDTH           (32                  ),
    .OUT_WIDTH          (16                  ),
    .FIFO_DEPTH         (2                   ),
    .OUT_RESIGTER       (0                   )
)
u_nsu_info_fifo(/*autoinst*/
    .clk                (clk                 ), // input
    .rst_n              (rst_n               ), // input
    .fifo_clr           (fifo_clr            ), // input
    .fifo_wen           (nsu_info_fifo_req_w ), // input
    .fifo_wdat          (nsu_info_fifo_wdata ), // input
    .fifo_ren           (nsu_info_fifo_req_r ), // input
    .fifo_rdata         (nsu_info_fifo_rdata ), // output
    .fifo_remain_vld    (                    ), // output
    .fifo_remain_rdat   (                    ), // output
    .fifo_remain_mask   (                    ), // output
    .full               (nsu_info_fifo_full  ), // output
    .empty              (nsu_info_fifo_empty )  // output
);

// Read cmd control fsm
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        cur_state <= IDLE_STATE;
    else
        cur_state <= nxt_state;
end

always@(*)begin
    case(cur_state)
        IDLE_STATE:
            if(grant == 5'b0_0001)
                nxt_state = ONLIE_STATE;
            else if(grant == 5'b0_0010)
                nxt_state = RX_WBF_STATE;
            // 继续 FSM 状态机
            else if(grant == 5'b0_0010)
                nxt_state = RX_WBF_STATE;
            else if(grant == 5'b0_0100)
                nxt_state = MSA_STATE;
            else if((grant == 5'b0_1000) | (grant == 5'b1_0000))
                nxt_state = UNMAP_STATE;
            else
                nxt_state = IDLE_STATE;
        ONLIE_STATE:
            if(prg_verify)
                nxt_state = DONE_STATE;
            else begin
                if(fast_safe_flag == 1'b0)
                    nxt_state = SAFE_STATE;
                else
                    nxt_state = FAST_STATE;
            end
        FAST_STATE:
            nxt_state = RESP_STATE;
        SAFE_STATE:
            if(|off_wbf_work_en)
                nxt_state = TX_WBF_STATE;
            else
                nxt_state = RESP_STATE;
        RESP_STATE:
            if(read_resp_que_busy == 1'b0 & deep_resp_que_busy == 1'b0 & meta_data_busy == 1'b0 & (wr_dat_done == 1'b1))
                nxt_state = DONE_STATE;
            else
                nxt_state = RESP_STATE;
        UNMAP_STATE:
            if(unmap_busy == 8'b0)
                nxt_state = DONE_STATE;
            else
                nxt_state = UNMAP_STATE;
        MSA_STATE:
            if(msa_resp_que_wren)
                nxt_state = DONE_STATE;
            else
                nxt_state = MSA_STATE;
        TX_WBF_STATE:
            if((online_wr_dat_done == 1'b1) & tx_off_wbf_cmd_busy == 1'b0)
                nxt_state = DONE_STATE;
            else
                nxt_state = TX_WBF_STATE;
        RX_WBF_STATE:
            nxt_state = RESP_STATE;
        DONE_STATE:
            if(complete & mux_ping_pong_rdy)
                nxt_state = IDLE_STATE;
            else
                nxt_state = DONE_STATE;
    default:nxt_state = IDLE_STATE;
endcase
end

// 例化指令解码器
nsu_rd_inst_decoder #(/*autoinstparam*/
    .OFF_WBF_CMD_WH      (2560                ),
    .ONLINE_WIDTH        (ONLINE_WIDTH       ),
    .OST_WH              (OST_WH             ),
    .HW_UNMAP_WH         (HW_UNMAP_WH        )
)
u0_nsu_rd_inst_decoder(/*autoinst*/
    .clk                 (clk                ),
    .rst_n               (rst_n              ),
    .error_flag_position (error_flag_position),
    .lba_position        (lba_position       ),
    .hw_unmap_fifo_req_r (hw_unmap_fifo_req_r),
    .hw_unmap_fifo_rdata (hw_unmap_fifo_rdata),
    .sw_unmap_fifo_req_r (sw_unmap_fifo_req_r),
    .sw_unmap_fifo_rdata (sw_unmap_fifo_rdata),
    .msa_cmd_fifo_req_r  (msa_cmd_fifo_req_r ),
    .msa_cmd_fifo_rdata  (msa_cmd_fifo_rdata ),
    .offline_wbf_fifo_req_r (offline_wbf_fifo_req_r),
    .offline_wbf_fifo_rdata (offline_wbf_fifo_rdata),
    .dec_fifo_ren        (dec_fifo_ren       ),
    .dec_fifo_rdat       (dec_fifo_rdat      ),
    .done                (state_done         ),
    .inst_index          (inst_index         ),
    .nand_index          (nand_index         ),
    .dis_read_data       (dis_read_data      ),
    .group1_ost_id       (group1_ost_id      ),
    .group0_ost_id       (group0_ost_id      ),
    .prg_verify          (prg_verify         ),
    .fast_safe_flag      (fast_safe_flag     ),
    .resp_sel_que        (resp_sel_que       ),
    .meta_mode           (meta_mode          ),
    .deep_read_sel       (deep_read_sel      ),
    .dest_sel            (dest_sel           ),
    .err_report          (err_report         ),
    .plane_sel           (plane_sel          ),
    .unmap_plane_sel     (unmap_plane_sel    ),
    .dec_status          (dec_status         ),
    .correct_num         (correct_num        ),
    .plane0_empty        (plane0_empty       ),
    .plane1_empty        (plane1_empty       ),
    .plane0_set_bit      (plane0_set_bit     ),
    .plane1_set_bit      (plane1_set_bit     ),
    .group0_meta_id      (group0_meta_id     ),
    .group1_meta_id      (group1_meta_id     ),
    .dest_addr           (dest_addr          ),
    .fail_addr           (fail_addr          ),
    .group0_blk_addr     (group0_blk_addr    ),
    .group1_blk_addr     (group1_blk_addr    ),
    .group0_page_addr    (group0_page_addr   ),
    .group1_page_addr    (group1_page_addr   ),
    .meta_data0          (meta_data0         ),
    .meta_data1          (meta_data1         ),
    .meta_data2          (meta_data2         ),
    .meta_data3          (meta_data3         ),
    .off_wbf_work_en     (off_wbf_work_en    ),
    .threshold           (threshold          ),
    .flip_threshold_sel  (flip_threshold_sel ),
    .seed                (seed               ),
    .descramble_en       (descramble_en      ),
    .dat_out_en          (dat_out_en         ),
    .msa_err_bit         (msa_err_bit        ),
    .msa_src_addr        (msa_src_addr       ),
    .group0_dest_addr    (group0_dest_addr   ),
    .group1_dest_addr    (group1_dest_addr   ),
    .off_wbf_pp_vld      (off_wbf_pp_vld     ),
    .online_fast_safe_flag (online_fast_safe_flag),
    .nand_lba            (nand_lba           ),
    .nand_error_flag     (nand_error_flag    )
);

// cmd_sel 控制
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        cmd_sel <= 3'd0;
    else if(state_done)
        cmd_sel <= 3'd0;
    else if(cur_state == IDLE_STATE & nxt_state == ONLIE_STATE)
        cmd_sel <= 3'd1;
    else if(cur_state == IDLE_STATE & nxt_state == RX_WBF_STATE)
        cmd_sel <= 3'd2;
    else if(cur_state == IDLE_STATE & nxt_state == MSA_STATE)
        cmd_sel <= 3'd3;
    else if(cur_state == IDLE_STATE & nxt_state == UNMAP_STATE)
        cmd_sel <= 3'd4;
end

// msa_dat_addr 控制
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        msa_dat_addr <= 'd0;
    else if(cur_state == IDLE_STATE & nxt_state == MSA_STATE)
        msa_dat_addr <= msa_src_addr;
end

// msa_dat_addr_vld 控制
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        msa_dat_addr_vld <= 1'b0;
    else if(cur_state == IDLE_STATE & nxt_state == MSA_STATE)
        msa_dat_addr_vld <= 1'b1;
    else
        msa_dat_addr_vld <= 1'b0;
end

assign online_data_rdvld = online_dat_fast_rdvld | online_dat_safe_rdvld;

// 硬件/软件 unmap FIFO 控制
assign hw_unmap_fifo_req_w = hw_unmap_vld & hw_unmap_rdy;
assign hw_unmap_rdy = !hw_unmap_fifo_full;
assign hw_unmap_fifo_wdata = hw_unmap_cmd;
assign sw_unmap_fifo_req_w = sw_unmap_vld & sw_unmap_rdy;
assign sw_unmap_rdy = !sw_unmap_fifo_full;
assign sw_unmap_fifo_wdata = sw_unmap_cmd;
assign msa_cmd_fifo_req_w = msa_cmd_vld & msa_cmd_rdy;
assign msa_cmd_rdy = !msa_cmd_fifo_full;
assign msa_cmd_fifo_wdata = msa_cmd;
assign offline_wbf_fifo_req_w = offline_wbf_cmd_vld & offline_wbf_cmd_rdy;
assign offline_wbf_cmd_rdy = !offline_wbf_fifo_full;
assign offline_wbf_fifo_wdata = offline_wbf_cmd;

// FIFO 读请求控制
assign hw_unmap_fifo_req_r = cur_state == IDLE_STATE & grant == 5'b1_0000;
assign sw_unmap_fifo_req_r = cur_state == IDLE_STATE & grant == 5'b0_1000;
assign msa_cmd_fifo_req_r  = cur_state == IDLE_STATE & grant == 5'b0_0100;
assign offline_wbf_fifo_req_r = cur_state == IDLE_STATE & grant == 5'b0_0010;
assign dec_fifo_ren        = cur_state == IDLE_STATE & grant == 5'b0_0001;

// 硬件 unmap cmd FIFO
witmem_sfifo_depth1 #(/*autoinstparam*/
    .FIFO_WIDTH           (HW_UNMAP_WH        )
)
u_hw_unmap_cmd_fifo(/*autoinst*/
    .clk                 (clk                ),
    .rst_n               (rst_n              ),
    .fifo_clr            (fifo_clr           ),
    .fifo_req_w          (hw_unmap_fifo_req_w),
    .fifo_req_r          (hw_unmap_fifo_req_r),
    .fifo_wdata          (hw_unmap_fifo_wdata),
    .fifo_rdata          (hw_unmap_fifo_rdata),
    .fifo_full           (hw_unmap_fifo_full ),
    .fifo_empty          (hw_unmap_fifo_empty)
);

// software unmap cmd FIFO
nsu_fifo_conv_width #(/*autoinstparam*/
    .COMMON_DIVISOR      (32                 ),
    .IN_WIDTH            (32                 ),
    .OUT_WIDTH           (64                 ),
    .FIFO_DEPTH          (2                  ),
    .OUT_RESIGTER        (0                  )
)
u_sw_unmap_cmd_resize_fifo(/*autoinst*/
    .clk                 (clk                ),
    .rst_n               (rst_n              ),
    .fifo_clr            (fifo_clr           ),
    .fifo_wen            (sw_unmap_fifo_req_w),
    .fifo_wdat           (sw_unmap_fifo_wdata),
    .fifo_ren            (sw_unmap_fifo_req_r),
    .fifo_rdata          (sw_unmap_fifo_rdata),
    .fifo_remain_vld     (                   ),
    .fifo_remain_rdat    (                   ),
    .fifo_remain_mask    (                   ),
    .full                (sw_unmap_fifo_full ),
    .empty               (sw_unmap_fifo_empty)
);

// msa cmd FIFO
nsu_fifo_conv_width #(/*autoinstparam*/
    .COMMON_DIVISOR      (32                 ),
    .IN_WIDTH            (32                 ),
    .OUT_WIDTH           (128                ),
    .FIFO_DEPTH          (4                  ),
    .OUT_RESIGTER        (0                  )
)
u_msa_cmd_resize_fifo(/*autoinst*/
    .clk                 (clk                ),
    .rst_n               (rst_n              ),
    .fifo_clr            (fifo_clr           ),
    .fifo_wen            (msa_cmd_fifo_req_w ),
    .fifo_wdat           (msa_cmd_fifo_wdata ),
    .fifo_ren            (msa_cmd_fifo_req_r ),
    .fifo_rdata          (msa_cmd_fifo_rdata ),
    .fifo_remain_vld     (                   ),
    .fifo_remain_rdat    (                   ),
    .fifo_remain_mask    (                   ),
    .full                (msa_cmd_fifo_full  ),
    .empty               (msa_cmd_fifo_empty )
);

// offline wbf cmd FIFO
nsu_fifo_conv_width #(/*autoinstparam*/
    .COMMON_DIVISOR      (64                 ),
    .IN_WIDTH            (64                 ),
    .OUT_WIDTH           (2560               ),
    .FIFO_DEPTH          (40                 ),
    .OUT_RESIGTER        (0                  )
)
u_offline_wbf_cmd_resize_fifo(/*autoinst*/
    .clk                 (clk                ),
    .rst_n               (rst_n              ),
    .fifo_clr            (fifo_clr           ),
    .fifo_wen            (offline_wbf_fifo_req_w),
    .fifo_wdat           (offline_wbf_fifo_wdata),
    .fifo_ren            (offline_wbf_fifo_req_r),
    .fifo_rdata          (offline_wbf_fifo_rdata),
    .fifo_remain_vld     (                   ),
    .fifo_remain_rdat    (                   ),
    .fifo_remain_mask    (                   ),
    .full                (offline_wbf_fifo_full),
    .empty               (offline_wbf_fifo_empty)
);

// generate online cmd FIFO
generate
for (i=0;i<8;i=i+1) begin
    nsu_fifo_conv_width #(/*autoinstparam*/
        .COMMON_DIVISOR      (DEC_CMD_WIDTH     ),
        .IN_WIDTH            (DEC_CMD_WIDTH     ),
        .OUT_WIDTH           (ONLINE_WIDTH      ),
        .FIFO_DEPTH          (CMD_PIPE_NUM*2    ),
        .OUT_RESIGTER        (0                 )
    )
    u_online_cmd(/*autoinst*/
        .clk                 (clk                ),
        .rst_n               (rst_n              ),
        .fifo_clr            (fifo_clr           ),
        .fifo_wen            (dec_fifo_wen[i]    ),
        .fifo_wdat           (in_dat[i*32+:32]   ),
        .fifo_ren            (dec_fifo_ren       ),
        .fifo_rdata          (dec_fifo_rdat[i]   ),
        .fifo_remain_vld     (                   ),
        .fifo_remain_rdat    (                   ),
        .fifo_remain_mask    (                   ),
        .full                (dec_full[i]        ),
        .empty               (dec_empty[i]       )
    );

    always@(posedge clk or negedge rst_n) begin
        if(!rst_n)
            on_dec_done_wren[i] <= 1'b0;
        else if(on_dec_dat_done[i])
            on_dec_done_wren[i] <= 1'b1;
        else
            on_dec_done_wren[i] <= 1'b0;
    end

    sync_fifo #(
        .AFULL_TH            (4                  ),
        .AEMPTY_TH           (2                  ),
        .ADDR_WIDTH          (3                  ),
        .DATA_WIDTH          (1                  ),
        .REG_OUT             (0                  )
    )
    u_on_dec_done_fifo(
        .clk_fifo            (clk                ), // Clock
        .rst_fifo_n          (rst_n              ), // Reset
        .fifo_clear          (fifo_clr           ), // Clear
        .fifo_wen            (on_dec_done_wren[i]), // Write Enable
        .fifo_wdata          (1'b1               ), // Write Data
        .fifo_ren            (on_dec_done_rden[i]),// Read Enable
        .fifo_rdata          (                   ), // Read Data
        .fifo_rvalid         (                   ), // Read Data Valid
        .fifo_af             (on_dec_done_afull[i]),// Almost Full
        .fifo_ae             (                   ), // Almost Empty
        .fifo_full           (on_dec_done_full[i]), // Full
        .overflow            (                   ), // Overflow
        .fifo_empty          (on_dec_done_empty[i]),// Empty
        .underflow           (                   ), // Underflow
        .fifo_filled_depth   (                   ), // Occupied Depth
        .fifo_waddr          (                   ), // Write Pointer
        .fifo_raddr          (                   )  // Read Pointer
    );

    assign plane_pair_wdone[i] = (dat_out_en[i] & cmd_sel == 'd1) ? (!on_dec_done_empty[i]) : 1'b1;
    assign on_dec_done_rden[i] = state_done & dat_out_en[i] & cmd_sel == 'd1;

    // todo
    for (j=0;j<32;j=j+1) begin
        assign comp_err_bit[i][j] = (meta_mode == 2'b01 & plane_sel[i]) ?
            ((cfg_error_flag[j] | cfg_error_flag_mask[j]) == (nand_error_flag[i][j] | cfg_error_flag_mask[j])) : 1'b1;
        always@(posedge clk or negedge rst_n)begin
            if(!rst_n)
                dat_flag[i][j] <= 'd0;
            else if(io_read_send_en)begin
                if((!err_report[i] & comp_lba[i] & dec_status[i]) == 1'b0)
                    dat_flag[i][j] <= 1'b1;
                else if(comp_err_bit[i][j])
                    dat_flag[i][j] <= 1'b0;
                else
                    dat_flag[i][j] <= 1'b1;
            end
        end
    end

    assign comp_lba[i] = (meta_mode == 2'b01 & plane_sel[i]) ? ((nand_lba[i] | cfg_lba_mask) == (act_lba[i] | cfg_lba_mask)) : 1'b1;
    assign comp_err_flag[i] = &comp_err_bit[i];
    assign set_err[i] = err_report[i] ? 1'b0 : 1'b1;

    // online decoder data control
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            online_dat_fast_rdvld[i] <= 1'b0;
        else if(online_write_done[i])
            online_dat_fast_rdvld[i] <= 1'b0;
        else if(cur_state == ONLIE_STATE & nxt_state == FAST_STATE)begin
            if(dest_sel == 1'b0 & plane_sel[i])
                online_dat_fast_rdvld[i] <= 1'b1;
            else
                online_dat_fast_rdvld[i] <= 1'b0;
        end
    end

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            online_dat_safe_rdvld[i] <= 1'b0;
        else if(online_write_done[i])
            online_dat_safe_rdvld[i] <= 1'b0;
        else if(cur_state == ONLIE_STATE & nxt_state == SAFE_STATE)begin
            if(dest_sel == 1'b0 & plane_sel[i] & off_wbf_work_en[i] == 1'b0 & dat_out_en[i])
                online_dat_safe_rdvld[i] <= 1'b1;
            else
                online_dat_safe_rdvld[i] <= 1'b0;
        end
    end

    // hardware unmap read and software unmap read data control
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            unmap_read_sel[i] <= 1'b0;
        else if(unmap_write_done[i])
            unmap_read_sel[i] <= 1'b0;
        else if(unmap_rden_dly)begin
            unmap_read_sel[i] <= plane_sel[i];
        end
    end

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            unmap_busy[i] <= 1'b0;
        else if(unmap_write_done[i])
            unmap_busy[i] <= 1'b0;
        else if(cur_state == IDLE_STATE && nxt_state == UNMAP_STATE & unmap_plane_sel[i])begin
            unmap_busy[i] <= 1'b1;
        end
    end
end
endgenerate

assign unmap_rden = sw_unmap_fifo_req_r | hw_unmap_fifo_req_r;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        unmap_rden_dly <= 1'b0;
    else
        unmap_rden_dly <= unmap_rden;
end

// resp write control, dest is share memory ,write resp
assign read_resp_wr_start = online_fast_resp_wren | online_safe_resp_wren | off_wbf_resp_wren;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        online_fast_resp_wren <= 1'b0;
    else if(cur_state == FAST_STATE & dest_sel == 1'b1)
        online_fast_resp_wren <= 1'b1;
    else
        online_fast_resp_wren <= 1'b0;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        online_safe_resp_wren <= 1'b0;
    else if(cur_state == SAFE_STATE & deep_read_sel == 1'b0 & dest_sel == 1'b1 & (|off_wbf_work_en) == 1'b0)
        online_safe_resp_wren <= 1'b1;
    else
        online_safe_resp_wren <= 1'b0;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        off_wbf_resp_wren <= 1'b0;
    else if(cur_state == RX_WBF_STATE & deep_read_sel == 1'b0 & dest_sel == 1'b1)
        off_wbf_resp_wren <= 1'b1;
    else
        off_wbf_resp_wren <= 1'b0;
end

assign read_resp_que_status = {~err_plane_pair,nand_index,inst_index};
assign err_plane_pair = plane_pair_err & comp_lba & comp_err_flag;
assign plane_pair_err = set_err & dec_status;
assign read_resp_que_busy = read_resp_wr_busy | read_resp_wr_start;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        read_resp_wr_busy <= 1'b0;
    else if(read_resp_wr_done)
        read_resp_wr_busy <= 1'b0;
    else if(read_resp_wr_start)
        read_resp_wr_busy <= 1'b1;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        read_resp_wren <= 1'b0;
    else if(state_done)
        read_resp_wren <= 1'b0;
    else if(read_resp_wr_start)
        read_resp_wren <= 1'b1;
end

assign read_resp_que0_wcen = read_resp_wren & state_done & resp_sel_que == 'd0;
assign read_resp_que1_wcen = read_resp_wren & state_done & resp_sel_que == 'd1;
assign read_resp_que2_wcen = read_resp_wren & state_done & resp_sel_que == 'd2;
assign read_resp_que3_wcen = read_resp_wren & state_done & resp_sel_que == 'd3;

// read resp ctrl
nsu_read_resp_ctrl #(/*autoinstparam*/
    .DATA_WIDTH           (32                 ),
    .READ_RESP_ADDR       (READ_RESP_ADDR     )
)
u_nsu_read_resp_ctrl(/*autoinst*/
    .clk                 (clk                ),
    .rst_n               (rst_n              ),
    .start               (read_resp_wr_start ),
    .done                (read_resp_wr_done  ),
    .write_read_resp_que0_err (write_read_resp_que0_err),
    .write_read_resp_que1_err (write_read_resp_que1_err),
    .write_read_resp_que2_err (write_read_resp_que2_err),
    .write_read_resp_que3_err (write_read_resp_que3_err),
    .resp_sel_que        (resp_sel_que       ),
    .read_resp_que_status (read_resp_que_status),
    .read_que0_ready     (read_resp_que0_ready),
    .read_que1_ready     (read_resp_que1_ready),
    .read_que2_ready     (read_resp_que2_ready),
    .read_que3_ready     (read_resp_que3_ready),
    .read_resp_que_ready  (read_resp_que_ready),
    .read_resp_que_wcen   (read_resp_que_wcen ),
    .read_resp_que_waddr  (read_resp_que_waddr),
    .read_que_din         (read_resp_que_din  ),
    .act_read_resp_que0_len (act_read_resp_que0_len),
    .act_read_resp_que1_len (act_read_resp_que1_len),
    .act_read_resp_que2_len (act_read_resp_que2_len),
    .act_read_resp_que3_len (act_read_resp_que3_len),
    .read_que0_start_addr (read_resp_que0_start_addr),
    .read_que0_len        (read_resp_que0_len ),
    .read_que1_start_addr (read_resp_que1_start_addr),
    .read_que1_len        (read_resp_que1_len ),
    .read_que2_start_addr (read_resp_que2_start_addr),
    .read_que2_len        (read_resp_que2_len ),
    .read_que3_start_addr (read_resp_que3_start_addr),
    .read_que3_len        (read_resp_que3_len )
);

// deep read resp
assign decoder_err = (|err_report) ? 1'b1 : !(&comp_lba & dec_status);
assign deep_resp_que_wr_start = online_fast_deep_resp_wren | online_safe_deep_resp_wren | off_wbf_deep_resp_wren;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        online_fast_deep_resp_wren <= 1'b0;
    else if(cur_state == FAST_STATE & decoder_err)begin
        if(dest_sel == 1'b1)
            online_fast_deep_resp_wren <= 1'b1;
        else if(dest_sel == 1'b0 & io_fast_read_err_report)begin
            if(deep_read_que_ready == 1'b0 & io_fast_read_err_dis == 1'b1)
                online_fast_deep_resp_wren <= 1'b0;
            else
                online_fast_deep_resp_wren <= 1'b1;
        end
    end
    else
        online_fast_deep_resp_wren <= 1'b0;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        online_safe_deep_resp_wren <= 1'b0;
    else if(cur_state == SAFE_STATE & (|off_wbf_work_en) == 1'b0)begin
        if((decoder_err) | deep_read_sel)
            online_safe_deep_resp_wren <= 1'b1;
    end
    else
        online_safe_deep_resp_wren <= 1'b0;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        off_wbf_deep_resp_wren <= 1'b0;
    else if(cur_state == RX_WBF_STATE)begin
        if((decoder_err) | deep_read_sel)
            off_wbf_deep_resp_wren <= 1'b1;
    end
    else
        off_wbf_deep_resp_wren <= 1'b0;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        deep_resp_wren <= 1'b0;
    else if(state_done)
        deep_resp_wren <= 1'b0;
    else if(deep_resp_que_wr_start)
        deep_resp_wren <= 1'b1;
end

// TODO add crc error
assign deep_read_status[0] = {plane_sel,nand_index,inst_index};
assign deep_read_status[1] = {8'd0,~comp_err_flag,~comp_lba,~plane_pair_err};
assign deep_read_status[2] = {deep_read_sel,fast_safe_flag,2'd0,group1_page_addr,4'd0,group0_page_addr};
assign deep_read_status[3] = {group1_blk_addr,group0_blk_addr};
assign deep_read_status[4] = group0_meta_id;
assign deep_read_status[5] = group1_meta_id;
assign deep_read_status[6] = group0_dest_addr;
assign deep_read_status[7] = group1_dest_addr;
assign deep_read_status[8] = fail_addr[0];
assign deep_read_status[9] = fail_addr[1];
assign deep_read_status[10] = fail_addr[2];
assign deep_read_status[11] = fail_addr[3];
assign deep_read_status[12] = fail_addr[4];
assign deep_read_status[13] = fail_addr[5];
assign deep_read_status[14] = fail_addr[6];
assign deep_read_status[15] = fail_addr[7];
assign deep_read_status[16] = {group1_ost_id,correct_num[1],plane1_empty[1],plane0_empty[1],
                               group0_ost_id,correct_num[0],plane1_empty[0],plane0_empty[0]};
assign deep_read_status[17] = {plane1_set_bit[0],plane0_set_bit[0]};
assign deep_read_status[18] = {plane1_set_bit[1],plane0_set_bit[1]};
assign deep_read_status[19] = {5'b0,correct_num[3],plane1_empty[3],plane0_empty[3],
                               5'b0,correct_num[2],plane1_empty[2],plane0_empty[2]};
assign deep_read_status[20] = {plane1_set_bit[2],plane0_set_bit[2]};
assign deep_read_status[21] = {plane1_set_bit[3],plane0_set_bit[3]};
assign deep_read_status[22] = {5'b0,correct_num[5],plane1_empty[5],plane0_empty[5],
                               5'b0,correct_num[4],plane1_empty[4],plane0_empty[4]};
assign deep_read_status[23] = {plane1_set_bit[4],plane0_set_bit[4]};
assign deep_read_status[24] = {plane1_set_bit[5],plane0_set_bit[5]};
assign deep_read_status[25] = {5'b0,correct_num[7],plane1_empty[7],plane0_empty[7],
                               5'b0,correct_num[6],plane1_empty[6],plane0_empty[6]};
assign deep_read_status[26] = {plane1_set_bit[6],plane0_set_bit[6]};
assign deep_read_status[27] = {plane1_set_bit[7],plane0_set_bit[7]};

assign deep_resp_sram_wren = deep_resp_que_wr_busy & deep_read_que_ready;
assign deep_resp_que_wr_busy = deep_resp_que_wr_start | deep_resp_que_busy;
assign deep_resp_que_wr_dat = deep_read_status[deep_read_cnt];
assign deep_resp_que_wr_done = deep_read_sram_wren & deep_read_cnt == DEEP_CNT_MAX;
assign deep_read_que_wren    = deep_resp_wren & state_done;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        deep_read_sram_waddr <= 'd0;
    else if(deep_read_sram_waddr == DEEP_ADDR_MAX & deep_read_sram_wren)
        deep_read_sram_waddr <= 'd0;
    else if(deep_read_sram_wren)
        deep_read_sram_waddr <= deep_read_sram_waddr + 1'b1;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        deep_resp_que_wr_busy <= 1'b0;
    else if(deep_resp_que_wr_done)
        deep_resp_que_wr_busy <= 1'b0;
    else if(deep_resp_que_wr_start)
        deep_resp_que_wr_busy <= 1'b1;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        deep_read_cnt <= 'd0;
    else if(deep_resp_que_wr_done)
        deep_read_cnt <= 'd0;
    else if(deep_read_sram_wren)
        deep_read_cnt <= deep_read_cnt + 1'b1;
end

// write meta control
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        write_meta_start <= 1'b0;
    else if((cur_state == FAST_STATE | cur_state == SAFE_STATE | cur_state == RX_WBF_STATE) & nxt_state == RESP_STATE & meta_mode == 2'b10)
        write_meta_start <= 1'b1;
    else
        write_meta_start <= 1'b0;
end

assign meta_data_busy = write_meta_busy | write_meta_start;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        write_meta_busy <= 1'b0;
    else if(write_meta_done)
        write_meta_busy <= 1'b0;
    else if(write_meta_start)
        write_meta_busy <= 1'b1;
end

// write meta ctrl
nsu_write_meta_ctrl #(/*autoinstparam*/
    .DATA_WIDTH           (DATA_WIDTH         ),
    .ADDR_WIDTH           (ADDR_WIDTH         ),
    .BLEN_WIDTH           (BLEN_WIDTH         ),
    .ID_WIDTH             (ID_WIDTH           ),
    .STRB_WIDTH           (STRB_WIDTH         )
)
u_nsu_write_meta_ctrl(/*autoinst*/
    .clk                 (clk                ),
    .rst_n               (rst_n              ),
    .start               (write_meta_start   ),
    .done                (write_meta_done    ),
    .meta0_addr          (group0_meta_id     ),
    .meta1_addr          (group1_meta_id     ),
    .plane_sel           (plane_sel          ),
    .meta_data0          (meta_data0         ),
    .meta_data1          (meta_data1         ),
    .meta_data2          (meta_data2         ),
    .meta_data3          (meta_data3         ),
    .lm_wreq             (lm_wreq            ),
    .lm_wack             (lm_wack            ),
    .lm_wid              (lm_wid             ),
    .lm_wlen             (lm_wlen            ),
    .lm_waddr            (lm_waddr           ),
    .lm_wvld             (lm_wvld            ),
    .lm_wrdy             (lm_wrdy            ),
    .lm_wdat             (lm_wdat            ),
    .lm_wdat_last        (lm_wdat_last       ),
    .lm_wmask            (lm_wmask           ),
    .lm_wdone_id         (lm_wdone_id        ),
    .lm_wdone_id_vld     (lm_wdone_id_vld    )
);

// Determine whether the safe read of the online decoder requires invoking the offline wbf.
assign tx_off_wbf_cmd_start = cur_state == SAFE_STATE & nxt_state == TX_WBF_STATE;
nsu_tx_wbf_cmd #(
    .OST_WH              (OST_WH             )
)
u0_nsu_tx_wbf_cmd(/*autoinst*/
    .clk                 (clk                ),
    .rst_n               (rst_n              ),
    .tx_off_wbf_cmd_start (tx_off_wbf_cmd_start),
    .tx_off_wbf_cmd_busy  (tx_off_wbf_cmd_busy),
    .err_report          (err_report         ),
    .plane_sel           (plane_sel          ),
    .plane1_empty        (plane1_empty       ),
    .plane0_empty        (plane0_empty       ),
    .deep_read_sel       (deep_read_sel      ),
    .meta_mode           (meta_mode          ),
    .resp_sel_que        (resp_sel_que       ),
    .dest_sel            (dest_sel           ),
    .nand_index          (nand_index         ),
    .inst_index          (inst_index         ),
    .group1_meta_id      (group1_meta_id     ),
    .group0_meta_id      (group0_meta_id     ),
    .group1_blk_addr     (group1_blk_addr    ),
    .group1_ost_id       (group1_ost_id      ),
    .group1_page_addr    (group1_page_addr   ),
    .group0_blk_addr     (group0_blk_addr    ),
    .group0_ost_id       (group0_ost_id      ),
    .group0_page_addr    (group0_page_addr   ),
    .group0_dest_addr    (group0_dest_addr   ),
    .group1_dest_addr    (group1_dest_addr   ),
    .plane1_set_bit      (plane1_set_bit     ),
    .plane0_set_bit      (plane0_set_bit     ),
    .dec_status          (dec_status         ),
    .correct_num         (correct_num        ),
    .off_wbf_work_en     (off_wbf_work_en    ),
    .flip_threshold_sel  (flip_threshold_sel ),
    .threshold           (threshold          ),
    .seed                (seed               ),
    .descramble_en       (descramble_en      ),
    .fail_addr           (fail_addr          ),
    .dest_addr           (dest_addr          ),
    .meta_data0          (meta_data0         ),
    .meta_data1          (meta_data1         ),
    .meta_data2          (meta_data2         ),
    .meta_data3          (meta_data3         ),
    .tx_off_wbf_vld      (tx_off_wbf_vld     ),
    .tx_off_wbf_dat      (tx_off_wbf_dat     ),
    .tx_off_wbf_rdy      (tx_off_wbf_rdy     )
);

// receive off wbf decoder command and decoder command
reg [8:0] off_wbf_pipe_en;
assign off_wbf_addr_vld = |off_wbf_pipe_en[8:1]; //TODO
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        off_wbf_pipe_en <= 'd0;
    else
        off_wbf_pipe_en <= {off_wbf_pipe_en[7:0],offline_wbf_fifo_req_r};
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        off_wbf_wr_dat_done <= 1'b1;
    else if(off_wbf_pipe_en[0] & (|off_wbf_pp_vld))
        off_wbf_wr_dat_done <= 1'b0;
    else if(off_wbf_write_done)
        off_wbf_wr_dat_done <= 1'b1;
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        off_wbf_dat_addr <= 'd0;
    else if(off_wbf_pipe_en[0])
        off_wbf_dat_addr <= fail_addr[0];
    else if(off_wbf_pipe_en[1])
        off_wbf_dat_addr <= fail_addr[1];
    else if(off_wbf_pipe_en[2])
        off_wbf_dat_addr <= fail_addr[2];
    else if(off_wbf_pipe_en[3])
        off_wbf_dat_addr <= fail_addr[3];
    else if(off_wbf_pipe_en[4])
        off_wbf_dat_addr <= fail_addr[4];
    else if(off_wbf_pipe_en[5])
        off_wbf_dat_addr <= fail_addr[5];
    else if(off_wbf_pipe_en[6])
        off_wbf_dat_addr <= fail_addr[6];
    else if(off_wbf_pipe_en[7])
        off_wbf_dat_addr <= fail_addr[7];
end

// control IO read lba offset compute and offline wbf decoder source data addr
assign cmd_rd_en = cur_state == IDLE_STATE & nxt_state != IDLE_STATE;
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        lba_compute_en <= 2'b0;
    else
        lba_compute_en <= {lba_compute_en[0],cmd_rd_en};
end

// todo add regfile sel;
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        act_lba[0] <= 'd0;
        act_lba[1] <= 'd0;
        act_lba[2] <= 'd0;
        act_lba[3] <= 'd0;
        act_lba[4] <= 'd0;
        act_lba[5] <= 'd0;
        act_lba[6] <= 'd0;
        act_lba[7] <= 'd0;
    end
    else if(lba_compute_en[0])begin
        act_lba[0] <= group0_meta_id;
        act_lba[1] <= group0_meta_id + 'd1;
        act_lba[2] <= group0_meta_id + 'd2;
        act_lba[3] <= group0_meta_id + 'd3;
        act_lba[4] <= group1_meta_id;
        act_lba[5] <= group1_meta_id + 'd1;
        act_lba[6] <= group1_meta_id + 'd2;
        act_lba[7] <= group1_meta_id + 'd3;
    end
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        online_io_read_flag <= 1'b0;
    else if(state_done)
        online_io_read_flag <= 1'b0;
    else if(cur_state == ONLIE_STATE & dest_sel == 1'b0 & ((fast_safe_flag == 1'b1) || (fast_safe_flag == 1'b0 & (|dat_out_en) == 1'b1)))
        online_io_read_flag <= 1'b1;
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        cpu_io_read_flag <= 1'b0;
    else if(state_done)
        cpu_io_read_flag <= 1'b0;
    else if(cur_state == IDLE_STATE & (nxt_state == UNMAP_STATE || nxt_state == MSA_STATE))
        cpu_io_read_flag <= 1'b1;
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        off_wbf_io_read_flag <= 1'b0;
    else if(state_done)
        off_wbf_io_read_flag <= 1'b0;
    else if(cur_state == RX_WBF_STATE & dest_sel == 1'b0 & (|off_wbf_pp_vld))
        off_wbf_io_read_flag <= 1'b1;
end

assign tsu_io_read_data_flag = online_io_read_flag | cpu_io_read_flag | off_wbf_io_read_flag;

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        rd_sel <= 'd0;
    else if(cur_state == RX_WBF_STATE & lba_compute_en[0])
        rd_sel <= off_wbf_pp_vld;
    else if(lba_compute_en[0])
        rd_sel <= dat_out_en;
end

assign io_read_send_en = lba_compute_en[1] & tsu_io_read_data_flag;
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        cmd_rd_en_dly <= 'd0;
    else
        cmd_rd_en_dly <= {cmd_rd_en_dly[6:0],io_read_send_en};
end

assign nsu_get_msg_vld = |cmd_rd_en_dly[7:0];
wire [31:0] act_err_bit;
assign act_err_bit = cmd_sel == 'd3 ? msa_err_bit : dat_flag[0];

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        nsu_rd_lba <= 'd0;
        nsu_plane_sel <= 1'b0;
        tsu_nsu_err_msg <= 'd0;
    end
    else if(io_read_send_en)begin
        nsu_rd_lba <= act_lba[0][LBA_LEN-1:0];
        nsu_plane_sel <= rd_sel[0];
        tsu_nsu_err_msg <= act_err_bit;
    end
    else if(cmd_rd_en_dly[0])begin
        nsu_rd_lba <= act_lba[1][LBA_LEN-1:0];
        nsu_plane_sel <= rd_sel[1];
        tsu_nsu_err_msg <= dat_flag[1];
    end
    else if(cmd_rd_en_dly[1])begin
        nsu_rd_lba <= act_lba[2][LBA_LEN-1:0];
        nsu_plane_sel <= rd_sel[2];
        tsu_nsu_err_msg <= dat_flag[2];
    end
    else if(cmd_rd_en_dly[2])begin
        nsu_rd_lba <= act_lba[3][LBA_LEN-1:0];
        nsu_plane_sel <= rd_sel[3];
        tsu_nsu_err_msg <= dat_flag[3];
    end
    else if(cmd_rd_en_dly[3])begin
        nsu_rd_lba <= act_lba[4][LBA_LEN-1:0];
        nsu_plane_sel <= rd_sel[4];
        tsu_nsu_err_msg <= dat_flag[4];
    end
    else if(cmd_rd_en_dly[4])begin
        nsu_rd_lba <= act_lba[5][LBA_LEN-1:0];
        nsu_plane_sel <= rd_sel[5];
        tsu_nsu_err_msg <= dat_flag[5];
    end
    else if(cmd_rd_en_dly[5])begin
        nsu_rd_lba <= act_lba[6][LBA_LEN-1:0];
        nsu_plane_sel <= rd_sel[6];
        tsu_nsu_err_msg <= dat_flag[6];
    end
    else if(cmd_rd_en_dly[6])begin
        nsu_rd_lba <= act_lba[7][LBA_LEN-1:0];
        nsu_plane_sel <= rd_sel[7];
        tsu_nsu_err_msg <= dat_flag[6];
    end
    else if(cmd_rd_en_dly[7])begin
        nsu_plane_sel <= 1'b0;
        tsu_nsu_err_msg <= dat_flag[7];
    end
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        nsu_rd_ost_id_vld <= 1'b0;
        nsu_rd_ost_id <= 'd0;
    end
    else if(io_read_send_en)begin
        nsu_rd_ost_id_vld <= 1'b1;
        nsu_rd_ost_id <= group0_ost_id;
    end
    else if(cmd_rd_en_dly[3])begin
        nsu_rd_ost_id <= group1_ost_id;
        nsu_rd_ost_id_vld <= 1'b1;
    end
    else
        nsu_rd_ost_id_vld <= 1'b0;
end

assign ping_pong_vld = state_done & tsu_io_read_data_flag;
assign cmd_arb_done = state_done;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        ping_pong_flag <= 1'b0;
    end
    else if(ping_pong_vld)begin
        ping_pong_flag <= ~ping_pong_flag;
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        msa_resp_sram_wvld <= 1'b1;
    end
    else if(msa_resp_sram_wvld == 1'b0 & !msa_resp_que_full)
        msa_resp_sram_wvld <= 1'b1;
    else if(msa_write_done)
        msa_resp_sram_wvld <= 1'b0;
end

assign msa_resp_sram_wren = (msa_resp_sram_wvld == 1'b0 & !msa_resp_que_full) ? 1'b0 : 1'b1;
assign msa_resp_que_wren = (msa_resp_sram_wvld == 1'b0 & !msa_resp_que_full);
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        msa_resp_sram_waddr <= 'd0;
    else if(msa_resp_que_wren)
        msa_resp_sram_waddr <= msa_resp_sram_waddr + 1'b1;
end

assign msa_resp_sram_wdat = inst_index;
nsu_reg_sram_2p #(
    .DAT_WIDTH (16),
    .DEPTH     (8),
    .REG_OUT   (0)
)
u_msa_resp_sram
(
    .clk       (clk),
    .rst_n     (rst_n),
    .wcen      (msa_resp_sram_wren),
    .waddr     (msa_resp_sram_waddr),
    .wdata     (msa_resp_sram_wdat),
    .rcen      (msa_resp_sram_rden),
    .raddr     (msa_resp_sram_raddr),
    .rdata     (msa_resp_sram_rdat),
    .rdata_vld (msa_resp_sram_rdat_vld)
);

// online decoder statistics
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        online_dec_fast_fail_stat <= 'd0;
    else if(cur_state == FAST_STATE && ((&dec_status) == 1'b0) && (|plane_sel))
        online_dec_fast_fail_stat <= online_dec_fast_fail_stat + 1'b1;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        online_dec_fast_pass_stat <= 'd0;
    else if(cur_state == FAST_STATE && ((&dec_status) == 1'b1) && (|plane_sel))
        online_dec_fast_pass_stat <= online_dec_fast_pass_stat + 1'b1;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        online_dec_safe_fail_stat <= 'd0;
    else if(cur_state == SAFE_STATE && ((&dec_status) == 1'b0) && (|plane_sel))
        online_dec_safe_fail_stat <= online_dec_safe_fail_stat + 1'b1;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        online_dec_safe_pass_stat <= 'd0;
    else if(cur_state == SAFE_STATE && ((&dec_status) == 1'b1) && (|plane_sel))
        online_dec_safe_pass_stat <= online_dec_safe_pass_stat + 1'b1;
end

//Local Variables:
//verilog-library-directories:(".")
//verilog-library-directories-recursive:0
//End:
endmodule                                