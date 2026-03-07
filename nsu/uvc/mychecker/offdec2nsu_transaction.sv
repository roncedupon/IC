`ifndef OFFDEC2NSU_TRANSACTION_SV
`define OFFDEC2NSU_TRANSACTION_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class offdec2nsu_transaction extends uvm_sequence_item;
  // 延迟相关变量
  int offline2nsu_cmd_delay;
  int nsu2offline_cmd_delay;

  // -------------------------- offline2nsu_cmd：8bit×27，索引0-26 --------------------------
  rand logic [7:0] offline2nsu_cmd[];
  // index 0 (8bit) 字段
  rand logic [2:0] plane_num_in;    // [7:5]
  rand logic [4:0] ost_id_offline2nsu; // [4:0]
  // index 1 (8bit) 字段
  rand logic [7:0] correct_num_lsb; // [7:0]
  // index 2 (8bit) 字段 + correct_num_msb
  rand logic correct_num_msb;       // index2[0]
  rand logic dec_suc;               // index2[1]
  rand logic write_pos_jdg;         // index2[2]
  rand logic offline_wbf_out_flag;  // index2[3]
  // index 3-18 (128bit meta_data) 字段
  rand logic [7:0] meta_data_0;   // index3
  rand logic [7:0] meta_data_1;   // index4
  rand logic [7:0] meta_data_2;   // index5
  rand logic [7:0] meta_data_3;   // index6
  rand logic [7:0] meta_data_4;   // index7
  rand logic [7:0] meta_data_5;   // index8
  rand logic [7:0] meta_data_6;   // index9
  rand logic [7:0] meta_data_7;   // index10
  rand logic [7:0] meta_data_8;   // index11
  rand logic [7:0] meta_data_9;   // index12
  rand logic [7:0] meta_data_10;  // index13
  rand logic [7:0] meta_data_11;  // index14
  rand logic [7:0] meta_data_12;  // index15
  rand logic [7:0] meta_data_13;  // index16
  rand logic [7:0] meta_data_14;  // index17
  rand logic [7:0] meta_data_15;  // index18
  // index 19-22 (32bit act_output_mem_addr) 字段
  rand logic [7:0] act_out_addr_0; // index19
  rand logic [7:0] act_out_addr_1; // index20
  rand logic [7:0] act_out_addr_2; // index21
  rand logic [7:0] act_out_addr_3; // index22
  // index 23-26 (32bit exp_output_mem_addr) 字段
  rand logic [7:0] exp_out_addr_0; // index23
  rand logic [7:0] exp_out_addr_1; // index24
  rand logic [7:0] exp_out_addr_2; // index25
  rand logic [7:0] exp_out_addr_3; // index26
  // index 27 字段（注：数组size为27，索引0-26，此处为图片原文）
  rand logic [7:0] offline_wbf_err_addr_id;

  // -------------------------- nsu2offline_cmd：8bit×12，索引0-11 --------------------------
  rand logic [7:0] nsu2offline_cmd[];
  // index 0 (8bit) 字段
  rand logic [2:0] plane_num;       // [7:5]
  rand logic [4:0] ost_id_nsu2offline; // [4:0]
  // index 1 (8bit) 字段
  rand logic dest_sel;              // [3]
  rand logic flip_threshold_sel;    // [2]
  rand logic over_threshold;        // [1]
  rand logic descramble_en;         // [0]
  // index 2-3 (16bit descramble_seed) 字段
  rand logic [7:0] descramble_seed_0; // index2
  rand logic [7:0] descramble_seed_1; // index3
  // index 4-7 (32bit dest_memory_addr) 字段
  rand logic [7:0] dest_mem_addr_0; // index4
  rand logic [7:0] dest_mem_addr_1; // index5
  rand logic [7:0] dest_mem_addr_2; // index6
  rand logic [7:0] dest_mem_addr_3; // index7
  // index 8-11 (32bit src_memory_addr) 字段
  rand logic [7:0] src_mem_addr_0;  // index8
  rand logic [7:0] src_mem_addr_1;  // index9
  rand logic [7:0] src_mem_addr_2;  // index10
  rand logic [7:0] src_mem_addr_3;  // index11

  // UVM字段注册
  `uvm_object_utils_begin(offdec2nsu_transaction)
    // 延迟变量
    `uvm_field_int(offline2nsu_cmd_delay, UVM_ALL_ON)
    `uvm_field_int(nsu2offline_cmd_delay, UVM_ALL_ON)
    // offline2nsu_cmd 数组及字段
    `uvm_field_array_int(offline2nsu_cmd, UVM_ALL_ON)
    `uvm_field_int(plane_num_in, UVM_ALL_ON)
    `uvm_field_int(ost_id_offline2nsu, UVM_ALL_ON)
    `uvm_field_int(correct_num_lsb, UVM_ALL_ON)
    `uvm_field_int(correct_num_msb, UVM_ALL_ON)
    `uvm_field_int(offline_wbf_out_flag, UVM_ALL_ON)
    `uvm_field_int(write_pos_jdg, UVM_ALL_ON)
    `uvm_field_int(dec_suc, UVM_ALL_ON)
    `uvm_field_int(meta_data_0, UVM_ALL_ON)
    `uvm_field_int(meta_data_1, UVM_ALL_ON)
    `uvm_field_int(meta_data_2, UVM_ALL_ON)
    `uvm_field_int(meta_data_3, UVM_ALL_ON)
    `uvm_field_int(meta_data_4, UVM_ALL_ON)
    `uvm_field_int(meta_data_5, UVM_ALL_ON)
    `uvm_field_int(meta_data_6, UVM_ALL_ON)
    `uvm_field_int(meta_data_7, UVM_ALL_ON)
    `uvm_field_int(meta_data_8, UVM_ALL_ON)
    `uvm_field_int(meta_data_9, UVM_ALL_ON)
    `uvm_field_int(meta_data_10, UVM_ALL_ON)
    `uvm_field_int(meta_data_11, UVM_ALL_ON)
    `uvm_field_int(meta_data_12, UVM_ALL_ON)
    `uvm_field_int(meta_data_13, UVM_ALL_ON)
    `uvm_field_int(meta_data_14, UVM_ALL_ON)
    `uvm_field_int(meta_data_15, UVM_ALL_ON)
    `uvm_field_int(act_out_addr_0, UVM_ALL_ON)
    `uvm_field_int(act_out_addr_1, UVM_ALL_ON)
    `uvm_field_int(act_out_addr_2, UVM_ALL_ON)
    `uvm_field_int(act_out_addr_3, UVM_ALL_ON)
    `uvm_field_int(exp_out_addr_0, UVM_ALL_ON)
    `uvm_field_int(exp_out_addr_1, UVM_ALL_ON)
    `uvm_field_int(exp_out_addr_2, UVM_ALL_ON)
    `uvm_field_int(exp_out_addr_3, UVM_ALL_ON)
    `uvm_field_int(offline_wbf_err_addr_id, UVM_ALL_ON)
    // nsu2offline_cmd 数组及字段
    `uvm_field_array_int(nsu2offline_cmd, UVM_ALL_ON)
    `uvm_field_int(plane_num, UVM_ALL_ON)
    `uvm_field_int(ost_id_nsu2offline, UVM_ALL_ON)
    `uvm_field_int(dest_sel, UVM_ALL_ON)
    `uvm_field_int(flip_threshold_sel, UVM_ALL_ON)
    `uvm_field_int(over_threshold, UVM_ALL_ON)
    `uvm_field_int(descramble_en, UVM_ALL_ON)
    `uvm_field_int(descramble_seed_0, UVM_ALL_ON)
    `uvm_field_int(descramble_seed_1, UVM_ALL_ON)
    `uvm_field_int(dest_mem_addr_0, UVM_ALL_ON)
    `uvm_field_int(dest_mem_addr_1, UVM_ALL_ON)
    `uvm_field_int(dest_mem_addr_2, UVM_ALL_ON)
    `uvm_field_int(dest_mem_addr_3, UVM_ALL_ON)
    `uvm_field_int(src_mem_addr_0, UVM_ALL_ON)
    `uvm_field_int(src_mem_addr_1, UVM_ALL_ON)
    `uvm_field_int(src_mem_addr_2, UVM_ALL_ON)
    `uvm_field_int(src_mem_addr_3, UVM_ALL_ON)
  `uvm_object_utils_end

  // 构造函数
  function new(string name = "offdec2nsu_transaction");
    super.new(name);
    offline2nsu_cmd = new[27];
    nsu2offline_cmd = new[12];
  endfunction

  // 约束1：数组大小约束
  constraint cmd_array_sizes {
    soft offline2nsu_cmd.size() == 27; // index 0-26
    soft nsu2offline_cmd.size() == 12; // index 0-11
  }

  // 约束2：nsu2offline_cmd 赋值约束（输出cmd映射）
  constraint nsu2offline_cmd_assign {
    nsu2offline_cmd[0]  == {plane_num, ost_id_nsu2offline}; // index0: [7:5]plane_num + [4:0]ost_id
    nsu2offline_cmd[1]  == {4'b0000, dest_sel, flip_threshold_sel, over_threshold, descramble_en}; // index1: 保留位 + 4个控制位
    nsu2offline_cmd[2]  == descramble_seed_0; // index2: descramble_seed[7:0]
    nsu2offline_cmd[3]  == descramble_seed_1; // index3: descramble_seed[15:8]
    nsu2offline_cmd[4]  == dest_mem_addr_0;   // index4: dest_mem_addr[7:0]
    nsu2offline_cmd[5]  == dest_mem_addr_1;   // index5: dest_mem_addr[15:8]
    nsu2offline_cmd[6]  == dest_mem_addr_2;   // index6: dest_mem_addr[23:16]
    nsu2offline_cmd[7]  == dest_mem_addr_3;   // index7: dest_mem_addr[31:24]
    nsu2offline_cmd[8]  == src_mem_addr_0;    // index8: src_mem_addr[7:0]
    nsu2offline_cmd[9]  == src_mem_addr_1;    // index9: src_mem_addr[15:8]
    nsu2offline_cmd[10] == src_mem_addr_2;    // index10: src_mem_addr[23:16]
    nsu2offline_cmd[11] == src_mem_addr_3;    // index11: src_mem_addr[31:24]
  }

  // 约束3：offline2nsu_cmd 赋值约束（输入cmd映射）
  constraint offline2nsu_cmd_assign {
    offline2nsu_cmd[0]  == {plane_num_in, ost_id_offline2nsu}; // index0: [7:5]plane_num_in + [4:0]ost_id
    offline2nsu_cmd[1]  == correct_num_lsb;                   // index1: correct_num[7:0]
    offline2nsu_cmd[2]  == {4'b0000, offline_wbf_out_flag, write_pos_jdg, dec_suc, correct_num_msb}; // index2: 保留位 + 4个控制位
    offline2nsu_cmd[3]  == meta_data_0;   // index3: meta_data[7:0]
    offline2nsu_cmd[4]  == meta_data_1;   // index4: meta_data[15:8]
    offline2nsu_cmd[5]  == meta_data_2;   // index5: meta_data[23:16]
    offline2nsu_cmd[6]  == meta_data_3;   // index6: meta_data[31:24]
    offline2nsu_cmd[7]  == meta_data_4;   // index7: meta_data[39:32]
    offline2nsu_cmd[8]  == meta_data_5;   // index8: meta_data[47:40]
    offline2nsu_cmd[9]  == meta_data_6;   // index9: meta_data[55:48]
    offline2nsu_cmd[10] == meta_data_7;   // index10: meta_data[63:56]
    offline2nsu_cmd[11] == meta_data_8;   // index11: meta_data[71:64]
    offline2nsu_cmd[12] == meta_data_9;   // index12: meta_data[79:72]
    offline2nsu_cmd[13] == meta_data_10;  // index13: meta_data[87:80]
    offline2nsu_cmd[14] == meta_data_11;  // index14: meta_data[95:88]
    offline2nsu_cmd[15] == meta_data_12;  // index15: meta_data[103:96]
    offline2nsu_cmd[16] == meta_data_13;  // index16: meta_data[111:104]
    offline2nsu_cmd[17] == meta_data_14;  // index17: meta_data[119:112]
    offline2nsu_cmd[18] == meta_data_15;  // index18: meta_data[127:120]
    offline2nsu_cmd[19] == act_out_addr_0; // index19: act_output_mem_addr[7:0]
    offline2nsu_cmd[20] == act_out_addr_1; // index20: act_output_mem_addr[15:8]
    offline2nsu_cmd[21] == act_out_addr_2; // index21: act_output_mem_addr[23:16]
    offline2nsu_cmd[22] == act_out_addr_3; // index22: act_output_mem_addr[31:24]
    offline2nsu_cmd[23] == exp_out_addr_0; // index23: exp_output_mem_addr[7:0]
    offline2nsu_cmd[24] == exp_out_addr_1; // index24: exp_output_mem_addr[15:8]
    offline2nsu_cmd[25] == exp_out_addr_2; // index25: exp_output_mem_addr[23:16]
    offline2nsu_cmd[26] == exp_out_addr_3; // index26: exp_output_mem_addr[31:24]
    offline2nsu_cmd[27] == offline_wbf_err_addr_id; // 注：数组size=27，索引0-26，此处为图片原文
  }

  // 函数1：从offline2nsu_cmd解析到位域字段
  function void fields_assignment_offline2nsu();
    // cmd[0] 解析
    plane_num_in        = 8'b0;
    plane_num_in[7:5]   = offline2nsu_cmd[0][7:5];
    ost_id_offline2nsu  = offline2nsu_cmd[0][4:0];

    // cmd[1] 解析
    correct_num_lsb     = offline2nsu_cmd[1];

    // cmd[2] 解析
    correct_num_msb     = offline2nsu_cmd[2][0];
    dec_suc             = offline2nsu_cmd[2][1];
    write_pos_jdg       = offline2nsu_cmd[2][2];
    offline_wbf_out_flag= offline2nsu_cmd[2][3];

    // cmd[3-18] 解析（meta_data）
    meta_data_0  = offline2nsu_cmd[3];
    meta_data_1  = offline2nsu_cmd[4];
    meta_data_2  = offline2nsu_cmd[5];
    meta_data_3  = offline2nsu_cmd[6];
    meta_data_4  = offline2nsu_cmd[7];
    meta_data_5  = offline2nsu_cmd[8];
    meta_data_6  = offline2nsu_cmd[9];
    meta_data_7  = offline2nsu_cmd[10];
    meta_data_8  = offline2nsu_cmd[11];
    meta_data_9  = offline2nsu_cmd[12];
    meta_data_10 = offline2nsu_cmd[13];
    meta_data_11 = offline2nsu_cmd[14];
    meta_data_12 = offline2nsu_cmd[15];
    meta_data_13 = offline2nsu_cmd[16];
    meta_data_14 = offline2nsu_cmd[17];
    meta_data_15 = offline2nsu_cmd[18];

    // cmd[19-22] 解析（act_output_mem_addr）
    act_out_addr_0 = offline2nsu_cmd[19];
    act_out_addr_1 = offline2nsu_cmd[20];
    act_out_addr_2 = offline2nsu_cmd[21];
    act_out_addr_3 = offline2nsu_cmd[22];

    // cmd[23-26] 解析（exp_output_mem_addr）
    exp_out_addr_0 = offline2nsu_cmd[23];
    exp_out_addr_1 = offline2nsu_cmd[24];
    exp_out_addr_2 = offline2nsu_cmd[25];
    exp_out_addr_3 = offline2nsu_cmd[26];

    // cmd[27] 解析（图片原文）
    offline_wbf_err_addr_id = offline2nsu_cmd[26];
  endfunction

  // 函数2：从nsu2offline_cmd解析到位域字段
  function void fields_assignment_nsu2offline();
    // cmd[0] 解析
    plane_num          = nsu2offline_cmd[0][7:5];
    ost_id_nsu2offline = nsu2offline_cmd[0][4:0];

    // cmd[1] 解析
    dest_sel            = nsu2offline_cmd[1][3];
    flip_threshold_sel  = nsu2offline_cmd[1][2];
    over_threshold      = nsu2offline_cmd[1][1];
    descramble_en       = nsu2offline_cmd[1][0];

    // cmd[2-3] 解析（descramble_seed，仅注释，未赋值）
    // descramble_seed    = {nsu2offline_cmd[3], nsu2offline_cmd[2]};

    // cmd[4-7] 解析（dest_mem_addr）
    dest_mem_addr_0 = nsu2offline_cmd[4];
    dest_mem_addr_1 = nsu2offline_cmd[5];
    dest_mem_addr_2 = nsu2offline_cmd[6];
    dest_mem_addr_3 = nsu2offline_cmd[7];

    // cmd[8-11] 解析（src_mem_addr）
    src_mem_addr_0  = nsu2offline_cmd[8];
    src_mem_addr_1  = nsu2offline_cmd[9];
    src_mem_addr_2  = nsu2offline_cmd[10];
    src_mem_addr_3  = nsu2offline_cmd[11];
  endfunction

endclass

`endif