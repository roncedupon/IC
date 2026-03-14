`include "uvm_pkg.sv"
//`timescale 1ns/1ps
module nsu_offline_wbf_ctrl(/*autoarg*/
    //Inputs
    clk, rst_n,
    safe_read_err_group0_addr,
    safe_read_err_group1_addr,
    io_offline_wbf_addr,
    cmd_in_vld, cmd_in,
    tx_off_wbf_rdy,
    rx_off_wbf_vld,
    rx_off_wbf_dat,
    cmd_out_rdy, rd_data_done,
    rd_data_addr, sram_dout,
    sram_dout_vld,
    //Outputs
    cmd_in_rdy, tx_off_wbf_vld,
    tx_off_wbf_dat,
    rx_off_wbf_rdy,
    cmd_out, cmd_out_vld,
    group0_rd_vld,
    group0_rd_buff_id,
    group1_rd_vld,
    group1_rd_buff_id,
    rd_data_done,
    rd_data_addr,
    safe_read_fail_rdy,
    sram_cen,
    sram_wr,
    sram_addr, sram_din
);

//====================Parameter====================
parameter OFF_WBF_SRAM_WH = 11;
localparam OFF_WBF_WH = 8;
localparam IDLE_STATE = 3'd0;
localparam ONLINE_WR_STATE = 3'd1;
localparam OFF_WBF_WR_STATE = 3'd2;
localparam WRITE_STATE = 3'd3;
localparam READ_STATE = 3'd4;
localparam WAIT_STATE = 3'd5;
localparam ONLINE_STEP = 13'd5184; //81*64

//====================In/Out Signal====================
input clk;
input rst_n;
input [31:0] safe_read_err_group0_addr;
input [31:0] safe_read_err_group1_addr;
input [31:0] io_offline_wbf_addr;
input cmd_in_vld;
input [63:0] cmd_in;
output cmd_in_rdy;
output tx_off_wbf_vld;
output [OFF_WBF_WH-1:0] tx_off_wbf_dat;
input tx_off_wbf_rdy;
input rx_off_wbf_vld;
input [OFF_WBF_WH-1:0] rx_off_wbf_dat;
output rx_off_wbf_rdy;
output cmd_out_vld;
output [63:0] cmd_out;
input cmd_out_rdy;
output reg group0_rd_vld;
output reg [3:0] group0_rd_buff_id;
output reg group1_rd_vld;
output reg [3:0] group1_rd_buff_id;
input [31:0] rd_data_done;
output reg rd_data_addr;
output reg safe_read_fail_rdy;
output reg sram_cen;
output reg sram_wr;
output reg [OFF_WBF_SRAM_WH-1:0] sram_addr;
input [63:0] sram_dout;
output reg [63:0] sram_din;

//====================Wire/Reg SIGNAL====================
/*autowire*/
reg [OFF_WBF_SRAM_WH-1:0] sram_cnt;
reg [5:0] cmd_cnt;
reg [4:0] ost_id;
reg [5:0] ost_num;
//
reg [2:0] cur_state;
reg [2:0] nxt_state;
wire in_fifo_wen;
wire [68:0] in_fifo_wdat;
wire in_fifo_ren;
wire [68:0] in_fifo_rdat;
wire in_fifo_full;
wire in_fifo_empty;
reg flag;
wire conv_fifo_wen;
wire [95:0] conv_fifo_wdat;
wire conv_fifo_ren;
wire conv_fifo_full;
wire conv_fifo_empty;
reg [68:0] rd_cnt;
reg [1:0] temp_dat;
wire allocate_vld;
wire [31:0] allocate_addr;
wire sel_addr;
wire addr_sel;
reg [3:0] ost_vld_num;
reg rx_cmd_fifo_wen;
wire [7:0] rx_cmd_fifo_wdat;
wire rx_cmd_fifo_ren;
wire [223:0] rx_cmd_fifo_rdat;
wire rx_cmd_fifo_full;
wire rx_cmd_fifo_empty;
wire rx_cmd_fifo_remain_vld;
wire rx_cmd_fifo_ren_dly;
reg [OFF_WBF_SRAM_WH-1:0] start_addr;
wire [4:0] start_pos;
wire [OFF_WBF_SRAM_WH-1:0] sram_wr_addr;
reg rx_cmd_vld;
wire rx_cmd_done;
wire pp_fifo_wen;
wire [4:0] pp_fifo_wdat;
wire pp_fifo_ren;
wire [4:0] pp_fifo_rdat;
wire pp_fifo_full;
wire pp_fifo_empty;
wire fifo_read_rdy;
wire io_read_sram_rdy;
reg [31:0] sram_buff;
reg [4:0]wr_id;
reg [4:0]out_id;
reg [2:0] wait_cnt;
wire [31:0] fail_addr;
reg io_off_wbf_fail;
reg rd_buff_vld;
wire [31:0] release_off_fail_addr;
wire [31:0] release_off_pass_addr;
reg [3:0] rd_buff_id;
reg [17:0] sub_group0_addr;
reg [17:0] sub_group1_addr;
reg [3:0] div_en;
wire group_sel;
wire [17:0] dividend;
wire [18:0] quotient;
integer i;

//====================Process====================
assign cmd_in_rdy = (cur_state == ONLINE_WR_STATE) ? ((cmd_cnt >= 'd8 & cmd_cnt <= 'd39) ? 1'b1 : 1'b0) : 1'b0;
assign cmd_out = sram_dout;
assign cmd_out_vld = cur_state == OFF_WBF_WR_STATE ? 1'b0 : sram_dout_vld;
assign safe_read_fail_rdy = io_read_sram_rdy & (ost_num < 'd16);

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        cur_state <= IDLE_STATE;
    else
        cur_state <= nxt_state;
end

always@(*)begin
    case(cur_state)
        IDLE_STATE:
            if(cmd_in_vld & ost_num < 'd16)
                nxt_state = ONLINE_WR_STATE;
            else if(!rx_cmd_fifo_empty & !rd_data_done)
                nxt_state = OFF_WBF_WR_STATE;
            else if(!pp_fifo_empty & cmd_out_rdy)
                nxt_state = READ_STATE;
            else
                nxt_state = IDLE_STATE;
        ONLINE_WR_STATE:
            if(cmd_in_vld & cmd_in_rdy & cmd_cnt == 'd39)
                nxt_state = IDLE_STATE;
            else
                nxt_state = ONLINE_WR_STATE;
        OFF_WBF_WR_STATE:
            if(wait_cnt == 'd6)
                nxt_state = WRITE_STATE;
            else
                nxt_state = OFF_WBF_WR_STATE;
        WRITE_STATE:
            if(cmd_cnt == 'd3)
                nxt_state = IDLE_STATE;
            else
                nxt_state = WRITE_STATE;
        READ_STATE:
            if(cmd_cnt == 'd39)
                nxt_state = WAIT_STATE;
            else
                nxt_state = READ_STATE;
        WAIT_STATE:
            if(wait_cnt == 'd3)
                nxt_state = IDLE_STATE;
            else
                nxt_state = WAIT_STATE;
        default:nxt_state = IDLE_STATE;
    endcase
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        wait_cnt <= 'd0;
    else if((cur_state == OFF_WBF_WR_STATE & nxt_state == WRITE_STATE) | (cur_state == WAIT_STATE & nxt_state == IDLE_STATE))
        wait_cnt <= 'd0;
    else if(cur_state == OFF_WBF_WR_STATE | cur_state == WAIT_STATE)
        wait_cnt <= wait_cnt + 1'b1;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        cmd_cnt <= 'd0;
    else if((cur_state == ONLINE_WR_STATE | cur_state == WRITE_STATE) & nxt_state == IDLE_STATE) |
            (cur_state == READ_STATE & nxt_state == WAIT_STATE)
        cmd_cnt <= 'd0;
    else if(cmd_in_vld & cmd_in_rdy & cur_state == ONLINE_WR_STATE) | (cur_state == WRITE_STATE) | (cur_state == READ_STATE)
        cmd_cnt <= cmd_cnt + 1'b1;
end

// ram control
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        rx_cmd_fifo_ren_dly <= 1'b0;
    else
        rx_cmd_fifo_ren_dly <= rx_cmd_fifo_ren;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        sram_cen <= 1'b1;
    else if((cur_state == ONLINE_WR_STATE) & cmd_in_vld & cmd_in_rdy)
        sram_cen <= 1'b0;
    else if((cur_state == WRITE_STATE) | (cur_state == READ_STATE) | (rx_cmd_fifo_ren_dly))
        sram_cen <= 1'b0;
    else
        sram_cen <= 1'b1;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        sram_wr <= 1'b0;
    else if((cur_state == ONLINE_WR_STATE) & cmd_in_vld & cmd_in_rdy)
        sram_wr <= 1'b1;
    else if(cur_state == WRITE_STATE)
        sram_wr <= 1'b1;
    else
        sram_wr <= 1'b0;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        sram_addr <= 'd0;
    else if((cur_state == ONLINE_WR_STATE) & cmd_in_vld & cmd_in_rdy)
        sram_addr <= sram_cnt;
    else if(rx_cmd_fifo_ren_dly)
        sram_addr <= sram_wr_addr + 'd1; // TODO modify
        // sram_addr <= start_addr + cmd_cnt;
    else if(cur_state == WRITE_STATE)begin
        case(cmd_cnt)
            'd0:sram_addr <= sram_wr_addr;
            'd1:sram_addr <= sram_wr_addr + 'd1;
            'd2:sram_addr <= sram_wr_addr + 'd1;
            'd3:sram_addr <= sram_wr_addr + 'd17;
            default:sram_addr <= sram_wr_addr;
        endcase
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        sram_din <= 'd0;
    else if((cur_state == ONLINE_WR_STATE) & cmd_in_vld & cmd_in_rdy)
        sram_din <= cmd_in;
    else if(cur_state == WRITE_STATE)begin
        case(cmd_cnt)
            'd0:sram_din <= {14'd0, rx_cmd_temp[20], rx_cmd_temp[223:216], 2'b1, ost_vld_num[pp_fifo_wdat], 3'd0, rx_cmd_temp[19:8], 20'd0};
            'd1:sram_din <= rx_cmd_temp[183:152], 32'd0};
            'd2:sram_din <= rx_cmd_temp[87:24];
            'd3:sram_din <= rx_cmd_temp[151:88];
            default:sram_din <= {14'd0, rx_cmd_temp[20], rx_cmd_temp[223:216], 2'b1, ost_vld_num[pp_fifo_wdat], 3'd0, rx_cmd_temp[19:8], 20'd0};
        endcase
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        sram_cnt <= 'd0;
    else if(cmd_in_vld & cmd_in_rdy & sram_cnt == 'd639)
        sram_cnt <= 'd0;
    else if(cmd_in_vld & cmd_in_rdy)
        sram_cnt <= sram_cnt + 1'b1;
end

// outstanding id
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        ost_id <= 'd0;
    else if((cur_state == ONLINE_WR_STATE) & (nxt_state == IDLE_STATE))begin
        if(ost_id < 'd15)
            ost_id <= 'd0;
        else
            ost_id <= ost_id + 1'b1;
    end
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        ost_num <= 'd0;
    else if((cur_state == ONLINE_WR_STATE) & (nxt_state == IDLE_STATE))
        ost_num <= ost_num + 1'b1;
    else if(cur_state == WAIT_STATE & nxt_state == IDLE_STATE)
        ost_num <= ost_num - 1'b1;
end

// tx offline wbf cmd in fifo
assign in_fifo_wen = cmd_in_vld & cmd_in_rdy & cmd_cnt >= 'd8 & cmd_cnt <= 'd23;
assign in_fifo_wdat = (cmd_cnt >= 'd8 & cmd_cnt <= 'd23) ? {ost_id, cmd_in} : 'd0;

dw_sfifo #(/*autoinstparam*/
    .REG_OUT ("false" ),
    .DATA_WIDTH (69 ),
    .ADDR_WIDTH (4 )
) u0_dw_sfifo(/*autoinst*/
    .clk (clk ), //input
    .rst_n (rst_n ), //input
    .wen (in_fifo_wen ), //input
    .wdata (in_fifo_wdat ), //input
    .ren (in_fifo_ren ), //input
    .ae_level (4'd7 ), //input
    .af_level (4'd7 ), //input
    .rdata (in_fifo_rdat ), //output
    .word_cnt ( ), //output
    .alfull ( ), //output
    .full (in_fifo_full ), //output
    .alempty (in_fifo_empty ), //output
    .empty (in_fifo_empty ), //output
);

assign io_read_sram_rdy = (&sram_buff[15:0]) ? 1'b0 : 1'b1;
assign fifo_read_rdy = (lin_fifo_empty & ((in_fifo_rdat[30] == 1'b1 & rd_cnt == 1'b0) | rd_cnt)) ? 1'b1 : (io_read_sram_rdy & (lin_fifo_empty));
assign in_fifo_ren = flag & fifo_read_rdy & !conv_fifo_full;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        flag <= 1'b1;
    else if(in_fifo_ren & rd_cnt)
        flag <= 1'b0;
    else
        flag <= 1'b1;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        rd_cnt <= 'd0;
    else if(in_fifo_ren)
        rd_cnt <= ~rd_cnt;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        for (i = 0;i<32;i=i+1) begin
            temp_dat[i] <= 'd0;
        end
    end
    else if(in_fifo_ren)
        temp_dat[rd_cnt] <= in_fifo_rdat;
end

assign allocate_vld = in_fifo_ren & temp_dat[0][19] & temp_dat[0][30] == 1'b0 & rd_cnt;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        addr_sel <= 1'b0;
    else if(in_fifo_ren & temp_dat[0][19] & rd_cnt)
        addr_sel <= 1'b1;
    else
        addr_sel <= 1'b0;
end

assign wr_id = sram_buff[0] == 1'b0 ? 5'd0 :
    sram_buff[1] == 1'b0 ? 5'd1 :
    sram_buff[2] == 1'b0 ? 5'd2 :
    sram_buff[3] == 1'b0 ? 5'd3 :
    sram_buff[4] == 1'b0 ? 5'd4 :
    sram_buff[5] == 1'b0 ? 5'd5 :
    sram_buff[6] == 1'b0 ? 5'd6 :
    sram_buff[7] == 1'b0 ? 5'd7 :
    sram_buff[8] == 1'b0 ? 5'd8 :
    sram_buff[9] == 1'b0 ? 5'd9 :
    sram_buff[10] == 1'b0 ? 5'd10 :
    sram_buff[11] == 1'b0 ? 5'd11 :
    sram_buff[12] == 1'b0 ? 5'd12 :
    sram_buff[13] == 1'b0 ? 5'd13 :
    sram_buff[14] == 1'b0 ? 5'd14 : 5'd31;

assign io_off_wbf_fail = rx_cmd_fifo_ren & rx_cmd_fifo_rdat[18:17] == 2'b00;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        rd_buff_vld <= 1'b0;
    else if(rd_data_done | io_off_wbf_fail)
        rd_buff_vld <= 1'b1;
    else
        rd_buff_vld <= 1'b0;
end

// modify
wire [31:0] release_off_fail_addr;
wire [31:0] release_off_pass_addr;
assign release_off_fail_addr = rx_cmd_fifo_rdat[215:184] - io_offline_wbf_addr;
assign release_off_pass_addr = rd_data_addr - io_offline_wbf_addr;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        rd_buff_id <= 'd0;
    else if(rd_data_done)
        rd_buff_id <= release_off_pass_addr[16:12];
    else if(io_off_wbf_fail)
        rd_buff_id <= release_off_fail_addr[16:12];
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        sram_buff <= 'd0;
        out_id <= 'd0;
    end
    else begin
        case({rd_buff_vld,allocate_vld})
            2'b01:begin
                out_id <= wr_id;
                sram_buff[wr_id] <= 1'b1;
            end
            2'b10:sram_buff[rd_buff_id] <= 1'b0;
            2'b11:
                if(wr_id != rd_buff_id)begin
                    sram_buff[wr_id] <= 1'b1;
                    sram_buff[rd_buff_id] <= 1'b0;
                    out_id <= wr_id;
                end
        endcase
    end
end

// assign allocate_addr = {27'd0,out_id};
// assign allocate_addr = io_offline_wbf_addr + {out_id,12'd0};
assign sel_addr = (addr_sel & temp_dat[0][30] == 1'b1) ? temp_dat[1][31:0] : allocate_addr;
assign conv_fifo_wdat = {temp_dat[1][63:32],sel_addr,temp_dat[0][16:1],3'd0,temp_dat[0][40],temp_dat[0][18:17],temp_dat[0][0],temp_dat[0][34:32],temp_dat[0][68:64]};
assign conv_fifo_wen = addr_sel;
assign tx_off_wbf_vld = !conv_fifo_empty;
assign tx_off_wbf_dat = conv_fifo_rdat;
assign conv_fifo_ren = tx_off_wbf_vld & tx_off_wbf_rdy;

nsu_fifo_conv_width #(/*autoinstparam*/
    .COMMON_DIVISOR (8 ),
    .IN_WIDTH (96 ),
    .OUT_WIDTH (224 ),
    .FIFO_DEPTH (8 ),
    .OUT_REGISTER (0 )
) u0_nsu_fifo_conv_width(/*autoinst*/
    .clk (clk ), //input
    .rst_n (rst_n ), //input
    .fifo_clr (1'b0 ), //input
    .fifo_wen (conv_fifo_wen ), //input
    .fifo_wdat (conv_fifo_wdat ), //input
    .fifo_ren (conv_fifo_ren ), //input
    .fifo_rdat (conv_fifo_rdat ), //output
    .fifo_remain_vld ( ), //output
    .fifo_remain_rdat ( ), //output
    .fifo_remain_mask ( ), //output
    .full (conv_fifo_full ), //output
    .empty (conv_fifo_empty ), //output
);

assign rx_off_wbf_rdy = !rx_cmd_fifo_full;
assign rx_cmd_fifo_wen = rx_off_wbf_vld & rx_off_wbf_rdy;
assign rx_cmd_fifo_wdat = rx_off_wbf_dat;
assign rx_cmd_fifo_ren = cur_state == IDLE_STATE & nxt_state == OFF_WBF_WR_STATE;

nsu_fifo_conv_width #(/*autoinstparam*/
    .COMMON_DIVISOR (8 ),
    .IN_WIDTH (8 ),
    .OUT_WIDTH (224 ),
    .FIFO_DEPTH (28 ),
    .OUT_REGISTER (0 )
) u_rx_offwbf_cmd_fifo(/*autoinst*/
    .clk (clk ), //input
    .rst_n (rst_n ), //input
    .fifo_clr (1'b0 ), //input
    .fifo_wen (rx_cmd_fifo_wen ), //input
    .fifo_wdat (rx_cmd_fifo_wdat ), //input
    .fifo_ren (rx_cmd_fifo_ren ), //input
    .fifo_rdat (rx_cmd_fifo_rdat ), //output
    .fifo_remain_vld (rx_cmd_fifo_remain_vld ), //output
    .fifo_remain_rdat ( ), //output
    .fifo_remain_mask ( ), //output
    .full (rx_cmd_fifo_full ), //output
    .empty (rx_cmd_fifo_empty ), //output
);

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        start_addr <= 'd0;
    else if(rx_cmd_fifo_ren)begin
        case(rx_cmd_fifo_rdat[4:0])
            'd0:start_addr <= 11'd0;
            'd1:start_addr <= 11'd40;
            'd2:start_addr <= 11'd80;
            'd3:start_addr <= 11'd120;
            'd4:start_addr <= 11'd160;
            'd5:start_addr <= 11'd200;
            'd6:start_addr <= 11'd240;
            'd7:start_addr <= 11'd280;
            'd8:start_addr <= 11'd320;
            'd9:start_addr <= 11'd360;
            'd10:start_addr <= 11'd400;
            'd11:start_addr <= 11'd440;
            'd12:start_addr <= 11'd480;
            'd13:start_addr <= 11'd520;
            'd14:start_addr <= 11'd560;
            'd15:start_addr <= 11'd600;
            default:start_addr <= 11'd0;
        endcase
    end
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        start_pos <= 'd0;
    else if(rx_cmd_fifo_ren)begin
        case(rx_cmd_fifo_rdat[7:5])
            'd0:start_pos <= 5'd8;
            'd1:start_pos <= 5'd10;
            'd2:start_pos <= 5'd12;
            'd3:start_pos <= 5'd14;
            'd4:start_pos <= 5'd16;
            'd5:start_pos <= 5'd18;
            'd6:start_pos <= 5'd20;
            'd7:start_pos <= 5'd22;
            default:start_pos <= 5'd8;
        endcase
    end
end

assign sram_wr_addr = start_addr + start_pos;
assign write_vld = cur_state == ONLINE_WR_STATE & cmd_cnt >= 'd8 & cmd_in_vld & cmd_in_rdy;
assign rx_cmd_vld = (cur_state == WRITE_STATE) & (nxt_state == IDLE_STATE);
assign rx_cmd_done = rx_cmd_vld & (ost_vld_num[pp_fifo_wdat] == 'd1);

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        for (i=0;i<32;i=i+1) begin
            ost_vld_num[i] <= 'd0;
        end
    end
    else begin
        case({rx_cmd_vld,write_vld})
            2'b01:ost_vld_num[ost_id] <= cmd_in[38:35];
            2'b10:ost_vld_num[pp_fifo_wdat] <= ost_vld_num[pp_fifo_wdat] - 1'b1;
            2'b11:
                if(ost_id != pp_fifo_wdat)begin
                    ost_vld_num[ost_id] <= cmd_in[38:35];
                    ost_vld_num[pp_fifo_wdat] <= ost_vld_num[pp_fifo_wdat] - 1'b1;
                end
            default:;
        endcase
    end
end

assign pp_fifo_wen = rx_cmd_temp[4:0];
assign pp_fifo_wdat = rx_cmd_temp[4:0];
assign pp_fifo_ren = cur_state == IDLE_STATE & nxt_state == READ_STATE;

dw_sfifo #(/*autoinstparam*/
    .REG_OUT ("true" ),
    .DATA_WIDTH (5 ),
    .ADDR_WIDTH (5 )
) ul_dw_sfifo(/*autoinst*/
    .clk (clk ), //input
    .rst_n (rst_n ), //input
    .wen (pp_fifo_wen ), //input
    .wdata (pp_fifo_wdat ), //input
    .ren (pp_fifo_ren ), //input
    .ae_level (5'd7 ), //input
    .af_level (5'd7 ), //input
    .rdata (pp_fifo_rdat ), //output
    .word_cnt ( ), //output
    .alfull ( ), //output
    .full (pp_fifo_full ), //output
    .alempty (pp_fifo_empty ), //output
    .empty (pp_fifo_empty ), //output
);

// add online decoder safe read fail addr release
wire sram_dat_vld;
assign sram_dat_vld = cur_state == OFF_WBF_WR_STATE & sram_dout_vld;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        fail_addr <= 'd0;
    else if(sram_dat_vld)
        fail_addr <= sram_dout[63:32];
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        sub_group0_addr <= 'd0;
    else if(div_en[0] & group_sel[0])
        sub_group0_addr <= fail_addr - safe_read_err_group0_addr;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        sub_group1_addr <= 'd0;
    else if(div_en[0] & group_sel[1])
        sub_group1_addr <= fail_addr - safe_read_err_group1_addr;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        div_en <= 'd0;
    else
        div_en <= {div_en[2:0],sram_dat_vld};
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        group_sel <= 'd0;
    else if(rx_cmd_fifo_rdat[7])begin
        group_sel <= 2'b10;
    end
    else
        group_sel <= 2'b01;
end

assign dividend = group_sel[0] ? sub_group0_addr : sub_group1_addr;

witmem_lp_div #(
    .A_WIDTH (18 ),
    .B_WIDTH (13 ),
    .TIME_LENGTH (2 )
) u0_witmem_lp_div (
    .clk (clk ),
    .rst_n (rst_n ),
    .en (div_en[2:1] ),
    .s2_a (1'b0 ),
    .s2_b (1'b0 ),
    .dividend (dividend ),
    .divisor (ONLINE_STEP ),
    .remainder ( ),
    .quotient (quotient ),
    .divide_by_0 ()
);

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        group0_rd_vld <= 1'b0;
    else if(div_en[3] & group_sel[0])
        group0_rd_vld <= 1'b1;
    else
        group0_rd_vld <= 1'b0;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        group0_rd_buff_id <= 'd0;
    else if(div_en[3] & group_sel[0])
        group0_rd_buff_id <= quotient[3:0];
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        group1_rd_vld <= 1'b0;
    else if(div_en[3] & group_sel[1])
        group1_rd_vld <= 1'b1;
    else
        group1_rd_vld <= 1'b0;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        group1_rd_buff_id <= 'd0;
    else if(div_en[3] & group_sel[1])
        group1_rd_buff_id <= quotient[3:0];
end

wire [5:0] idle;
reg [5:0] in_fifo_ren_dly;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        in_fifo_ren_dly <= 'd0;
    else
        in_fifo_ren_dly <= {in_fifo_ren_dly[4:0],in_fifo_ren};
end

assign idle = cur_state == IDLE_STATE && !pp_fifo_empty && !in_fifo_empty && in_fifo_ren_dly == 'd0 && rx_cmd_fifo_remain_vld == 1'b0;

//Local Variables:
//verilog-library-directories:("." )
//verilog-library-directories-recursive:0
//End:
endmodule