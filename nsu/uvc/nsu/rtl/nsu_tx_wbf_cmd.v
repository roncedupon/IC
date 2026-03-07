`timescale 1ns/1ps
module nsu_tx_wbf_cmd(/*autoarg*/
    //Inputs
    clk, rst_n,
    tx_off_wbf_cmd_start,
    err_report, plane_sel,
    plane1_empty,
    plane0_empty,
    deep_read_sel, meta_mode,
    resp_sel_que, dest_sel,
    nand_index, inst_index,
    group1_meta_id,
    group0_meta_id,
    group1_blk_addr,
    group1_ost_id,
    group1_page_addr,
    group0_blk_addr,
    group0_ost_id,
    group0_page_addr,
    plane1_set_bit,
    plane0_set_bit,
    dec_status, correct_num,
    off_wbf_work_en,
    flip_thresold_sel,  // 拼写存疑，应为 flip_threshold_sel
    thresold, seed,     // 拼写存疑，应为 threshold
    descramble_en, fail_addr,
    dest_addr, meta_data0,
    meta_data1, meta_data2,
    meta_data3,
    tx_off_wbf_rdy,
    group0_dest_addr,
    group1_dest_addr,
    //Outputs
    tx_off_wbf_cmd_busy,
    tx_off_wbf_vld,
    tx_off_wbf_dat
);

//============================Parameter============================
parameter OST_WH = 5;

//============================In/Out Signal============================
input                           clk;
input                           rst_n;
input                           tx_off_wbf_cmd_start;
output reg                      tx_off_wbf_cmd_busy;
input      [7:0]                err_report;
input      [7:0]                plane_sel;
input      [7:0]                plane1_empty;
input      [7:0]                plane0_empty;
input      [1:0]                deep_read_sel;
input      [1:0]                meta_mode;
input      [1:0]                resp_sel_que;
input                           dest_sel;
input      [7:0]                nand_index;
input      [15:0]               inst_index;
input      [31:0]               group1_meta_id;
input      [31:0]               group0_meta_id;
input      [15:0]               group1_blk_addr;
input      [OST_WH-1:0]         group1_ost_id;
input      [11:0]               group1_page_addr;
input      [15:0]               group0_blk_addr;
input      [OST_WH-1:0]         group0_ost_id;
input      [11:0]               group0_page_addr;
input      [15:0]               plane1_set_bit [7:0];
input      [15:0]               plane0_set_bit [7:0];
input      [7:0]                dec_status;
input      [8:0]                correct_num [7:0];
input      [7:0]                off_wbf_work_en;
input      [7:0]                flip_thresold_sel;
input      [7:0]                thresold;
input      [15:0]               seed [7:0];
input      [7:0]                descramble_en;
input      [31:0]               fail_addr [7:0];
input      [31:0]               dest_addr [7:0];
input      [31:0]               meta_data0 [7:0];
input      [31:0]               meta_data1 [7:0];
input      [31:0]               meta_data2 [7:0];
input      [31:0]               meta_data3 [7:0];
output                          tx_off_wbf_vld;
output     [63:0]               tx_off_wbf_dat;
input                           tx_off_wbf_rdy;
input      [31:0]               group0_dest_addr;
input      [31:0]               group1_dest_addr;

//============================Wire/Reg SIGNAL============================
/*autowire*/
wire       [63:0]               tx_off_wbf_cmd    [39:0];
reg        [63:0]               temp_cmd          [1:0];
reg        [5:0]                tx_off_wbf_cmd_cnt;
wire       [1:0]                temp_vld;
wire       [1:0]                temp_rdy;
wire       [1:0]                tx_off_wbf_pipe_en;
wire       [3:0]                err_plane_num;
wire                            tx_off_wbf_cmd_done;

//============================Process============================
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        tx_off_wbf_cmd_busy <= 1'b0;
    else if(tx_off_wbf_cmd_done)
        tx_off_wbf_cmd_busy <= 1'b0;
    else if(tx_off_wbf_cmd_start)
        tx_off_wbf_cmd_busy <= 1'b1;
end

// 原始注释：assign tx_off_wbf_cmd[0] = {err_report,plane_sel,plane1_empty, plane0_empty,2'b0,deep_read_sel,
//                                      meta_mode,resp_sel_que,dest_sel,nand_index,inst_index};
assign tx_off_wbf_cmd[0] = {err_report,group1_ost_id,group0_ost_id,plane1_empty, plane0_empty,deep_read_sel,
                            meta_mode,resp_sel_que,dest_sel,nand_index,inst_index};
assign tx_off_wbf_cmd[1] = {group1_meta_id,group0_meta_id};
assign tx_off_wbf_cmd[2] = {group1_blk_addr,4'b0,group1_page_addr,group0_blk_addr,4'b0,group0_page_addr};
assign tx_off_wbf_cmd[3] = {plane1_set_bit[1],plane0_set_bit[1],plane1_set_bit[0],plane0_set_bit[0]};
assign tx_off_wbf_cmd[4] = {plane1_set_bit[3],plane0_set_bit[3],plane1_set_bit[2],plane0_set_bit[2]};
assign tx_off_wbf_cmd[5] = {plane1_set_bit[5],plane0_set_bit[5],plane1_set_bit[4],plane0_set_bit[4]};
assign tx_off_wbf_cmd[6] = {plane1_set_bit[7],plane0_set_bit[7],plane1_set_bit[6],plane0_set_bit[6]};
assign tx_off_wbf_cmd[7] = {group1_dest_addr,group0_dest_addr};
assign tx_off_wbf_cmd[8] = {24'd0,plane_sel[0],err_plane_num,3'd0,1'b0,dest_sel,dec_status[0],correct_num[0],off_wbf_work_en[0],
                            flip_thresold_sel[0],thresold[0],seed[0],descramble_en[0]};
assign tx_off_wbf_cmd[9] = {fail_addr[0],dest_addr[0]};
assign tx_off_wbf_cmd[10] = {24'd0,plane_sel[1],err_plane_num,3'd1,1'b0,dest_sel,dec_status[1],correct_num[1],off_wbf_work_en[1],
                             flip_thresold_sel[1],thresold[1],seed[1],descramble_en[1]};
assign tx_off_wbf_cmd[11] = {fail_addr[1],dest_addr[1]};
assign tx_off_wbf_cmd[12] = {24'd0,plane_sel[2],err_plane_num,3'd2,1'b0,dest_sel,dec_status[2],correct_num[2],off_wbf_work_en[2],
                             flip_thresold_sel[2],thresold[2],seed[2],descramble_en[2]};
assign tx_off_wbf_cmd[13] = {fail_addr[2],dest_addr[2]};
assign tx_off_wbf_cmd[14] = {24'd0,plane_sel[3],err_plane_num,3'd3,1'b0,dest_sel,dec_status[3],correct_num[3],off_wbf_work_en[3],
                             flip_thresold_sel[3],thresold[3],seed[3],descramble_en[3]};
assign tx_off_wbf_cmd[15] = {fail_addr[3],dest_addr[3]};
assign tx_off_wbf_cmd[16] = {24'd0,plane_sel[4],err_plane_num,3'd4,1'b0,dest_sel,dec_status[4],correct_num[4],off_wbf_work_en[4],
                             flip_thresold_sel[4],thresold[4],seed[4],descramble_en[4]};
assign tx_off_wbf_cmd[17] = {fail_addr[4],dest_addr[4]};
assign tx_off_wbf_cmd[18] = {24'd0,plane_sel[5],err_plane_num,3'd5,1'b0,dest_sel,dec_status[5],correct_num[5],off_wbf_work_en[5],
                             flip_thresold_sel[5],thresold[5],seed[5],descramble_en[5]};
assign tx_off_wbf_cmd[19] = {fail_addr[5],dest_addr[5]};
assign tx_off_wbf_cmd[20] = {24'd0,plane_sel[6],err_plane_num,3'd6,1'b0,dest_sel,dec_status[6],correct_num[6],off_wbf_work_en[6],
                             flip_thresold_sel[6],thresold[6],seed[6],descramble_en[6]};
assign tx_off_wbf_cmd[21] = {fail_addr[6],dest_addr[6]};
assign tx_off_wbf_cmd[22] = {24'd0,plane_sel[7],err_plane_num,3'd7,1'b0,dest_sel,dec_status[7],correct_num[7],off_wbf_work_en[7],
                             flip_thresold_sel[7],thresold[7],seed[7],descramble_en[7]};
assign tx_off_wbf_cmd[23] = {fail_addr[7],dest_addr[7]};
assign tx_off_wbf_cmd[24] = {meta_data1[0],meta_data0[0]};
assign tx_off_wbf_cmd[25] = {meta_data3[0],meta_data2[0]};
assign tx_off_wbf_cmd[26] = {meta_data1[1],meta_data0[1]};
assign tx_off_wbf_cmd[27] = {meta_data3[1],meta_data2[1]};
assign tx_off_wbf_cmd[28] = {meta_data1[2],meta_data0[2]};
assign tx_off_wbf_cmd[29] = {meta_data3[2],meta_data2[2]};
assign tx_off_wbf_cmd[30] = {meta_data1[3],meta_data0[3]};
assign tx_off_wbf_cmd[31] = {meta_data3[3],meta_data2[3]};
assign tx_off_wbf_cmd[32] = {meta_data1[4],meta_data0[4]};
assign tx_off_wbf_cmd[33] = {meta_data3[4],meta_data2[4]};
assign tx_off_wbf_cmd[34] = {meta_data1[5],meta_data0[5]};
assign tx_off_wbf_cmd[35] = {meta_data3[5],meta_data2[5]};
assign tx_off_wbf_cmd[36] = {meta_data1[6],meta_data0[6]};
assign tx_off_wbf_cmd[37] = {meta_data3[6],meta_data2[6]};
assign tx_off_wbf_cmd[38] = {meta_data1[7],meta_data0[7]};
assign tx_off_wbf_cmd[39] = {meta_data3[7],meta_data2[7]};

assign tx_off_wbf_pipe_en[0] = temp_vld[0] & temp_rdy[0];
assign temp_vld[0] = tx_off_wbf_cmd_busy;

assign tx_off_wbf_cmd_done = tx_off_wbf_pipe_en[0] & (tx_off_wbf_cmd_cnt == 'd39);

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        tx_off_wbf_cmd_cnt <= 'd0;
    else if(tx_off_wbf_cmd_done)
        tx_off_wbf_cmd_cnt <= 'd0;
    else if(tx_off_wbf_pipe_en[0])
        tx_off_wbf_cmd_cnt <= tx_off_wbf_cmd_cnt + 1'b1;
end

always@(*)begin
    case(tx_off_wbf_cmd_cnt)
        'd0 :temp_cmd[0] = tx_off_wbf_cmd[0];
        'd1 :temp_cmd[0] = tx_off_wbf_cmd[1];
        'd2 :temp_cmd[0] = tx_off_wbf_cmd[2];
        'd3 :temp_cmd[0] = tx_off_wbf_cmd[3];
        'd4 :temp_cmd[0] = tx_off_wbf_cmd[4];
        'd5 :temp_cmd[0] = tx_off_wbf_cmd[5];
        'd6 :temp_cmd[0] = tx_off_wbf_cmd[6];
        'd7 :temp_cmd[0] = tx_off_wbf_cmd[7];
        'd8 :temp_cmd[0] = tx_off_wbf_cmd[8];
        'd9 :temp_cmd[0] = tx_off_wbf_cmd[9];
        'd10:temp_cmd[0] = tx_off_wbf_cmd[10];
        'd11:temp_cmd[0] = tx_off_wbf_cmd[11];
        'd12:temp_cmd[0] = tx_off_wbf_cmd[12];
        'd13:temp_cmd[0] = tx_off_wbf_cmd[13];
        'd14:temp_cmd[0] = tx_off_wbf_cmd[14];
        'd15:temp_cmd[0] = tx_off_wbf_cmd[15];
        'd16:temp_cmd[0] = tx_off_wbf_cmd[16];
        'd17:temp_cmd[0] = tx_off_wbf_cmd[17];
        'd18:temp_cmd[0] = tx_off_wbf_cmd[18];
        'd19:temp_cmd[0] = tx_off_wbf_cmd[19];
        'd20:temp_cmd[0] = tx_off_wbf_cmd[20];
        'd21:temp_cmd[0] = tx_off_wbf_cmd[21];
        'd22:temp_cmd[0] = tx_off_wbf_cmd[22];
        'd23:temp_cmd[0] = tx_off_wbf_cmd[23];
        'd24:temp_cmd[0] = tx_off_wbf_cmd[24];
        'd25:temp_cmd[0] = tx_off_wbf_cmd[25];
        'd26:temp_cmd[0] = tx_off_wbf_cmd[26];
        'd27:temp_cmd[0] = tx_off_wbf_cmd[27];
        'd28:temp_cmd[0] = tx_off_wbf_cmd[28];
        'd29:temp_cmd[0] = tx_off_wbf_cmd[29];
        'd30:temp_cmd[0] = tx_off_wbf_cmd[30];
        'd31:temp_cmd[0] = tx_off_wbf_cmd[31];
        'd32:temp_cmd[0] = tx_off_wbf_cmd[32];
        'd33:temp_cmd[0] = tx_off_wbf_cmd[33];
        'd34:temp_cmd[0] = tx_off_wbf_cmd[34];
        'd35:temp_cmd[0] = tx_off_wbf_cmd[35];
        'd36:temp_cmd[0] = tx_off_wbf_cmd[36];
        'd37:temp_cmd[0] = tx_off_wbf_cmd[37];
        'd38:temp_cmd[0] = tx_off_wbf_cmd[38];
        'd39:temp_cmd[0] = tx_off_wbf_cmd[39];
        default:temp_cmd[0] = tx_off_wbf_cmd[0];
    endcase
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        temp_cmd[1] <= 'd0;
    else if(tx_off_wbf_pipe_en[0])
        temp_cmd[1] <= temp_cmd[0];
end

witmem_ip_fwdpipe u1_witmem_ip_fwdpipe(/*autoinst*/
    .clk       (clk          ), //input
    .rst_n     (rst_n        ), //input
    .s_ready   (temp_rdy[0]  ), //output
    .s_valid   (temp_vld[0]  ), //input
    .m_ready   (temp_rdy[1]  ), //input
    .m_valid   (temp_vld[1]  )  //output
);

assign tx_off_wbf_vld = temp_vld[1];
assign tx_off_wbf_dat = temp_cmd[1];
assign temp_rdy[1] = tx_off_wbf_rdy;

nsu_get_8bone_num u0_nsu_get_8bone_num(/*autoinst*/
    .clk     (clk                ), //input
    .rst_n   (rst_n              ), //input
    .dat_in  (off_wbf_work_en    ), //input
    .en      (tx_off_wbf_cmd_start), //input
    .dat_out (err_plane_num      )  //output
);

//Local Variables:
//verilog-library-directories:(".")
//verilog-library-directories-recursive:0
//End:
endmodule