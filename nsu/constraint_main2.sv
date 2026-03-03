`timescale 1ns/1ps

// 1. 严格前置声明所有类/结构体
typedef struct {
  bit [31:0] nsu_addr_que[8];
  bit [7:0]  plane_sel[8];
  bit [7:0]  crc_pass[8];
  bit [7:0]  wbf_pass[8];
  bit        done_occur[8];
  bit [7:0]  ost_id;
  bit [2:0]  core_id;
} nsu2cpu_rcmd_tr_t;

class tr_item;
  rand bit [31:0] meta_buffer_id;
  rand bit        done_occur;
  rand bit [7:0]  ost_id;
  rand bit        deep_read_status_sel;
  rand bit        program_verify_read;
  rand bit [1:0]  read_mode;
  rand bit [2:0]  response_sel_que;
  rand bit        meta_mode;
  rand bit        deep_read_sel;
  rand bit        write_pos_jdg;
  rand bit        crc_pass;
  rand bit        wbf_pass;
  rand bit        error_flag;
  rand bit        plane_sel;
  rand bit        dec_suc;
endclass

// 2. 顶层模块
module tb_randomize_demo;

  tr_item             tr[8];
  nsu2cpu_rcmd_tr_t   local_struct;
  bit                 data_out_en = 1;

  initial begin
    // 【严格规范】所有变量声明在initial块最前面
    bit [7:0] final_dec_suc_with_bracket;
    bit [7:0] final_dec_suc_without_bracket;
    int i;

    // 1. 初始化local变量（固定值，确保两次测试条件一致）
    foreach(local_struct.plane_sel[i]) begin
      local_struct.plane_sel[i] = (i < 4) ? 1 : 0;
      local_struct.crc_pass[i]    = 1;
      local_struct.wbf_pass[i]   = (i == 0) ? 0 : 1;
      local_struct.done_occur[i]  = 0;
      local_struct.nsu_addr_que[i] = 32'h1000_0000 + i*'h1000;
    end
    local_struct.ost_id  = 8'h12;
    local_struct.core_id = 3'h5;

    // ============================================================
    // 场景1：带括号的正确写法
    // ============================================================
    $display("\n\n");
    $display("################################################################");
    $display("### SCENARIO 1: WITH BRACKETS (CORRECT) ###");
    $display("################################################################");

    // 初始化tr句柄
    foreach(tr[i]) tr[i] = new();

    // 逐个randomize（带括号）
    foreach(tr[i]) begin
      if (!tr[i].randomize() with {
        if (i == 0) {
          this.meta_buffer_id == local_struct.nsu_addr_que[0];
        }
        this.done_occur       == local_struct.done_occur[i];
        this.ost_id           == local_struct.ost_id;
        this.deep_read_status_sel == 0;
        this.program_verify_read   == 0;
        this.read_mode              == 0;
        this.response_sel_que       == local_struct.core_id;
        this.meta_mode              == 0;
        this.deep_read_sel          == 0;
        this.write_pos_jdg          == 0;
        this.crc_pass               == (local_struct.plane_sel[i] ? local_struct.crc_pass[i] : 1'b1);
        this.wbf_pass               == (local_struct.plane_sel[i] ? local_struct.wbf_pass[i] : 1'b1);
        this.error_flag             == 0;
        this.plane_sel              == local_struct.plane_sel[i];
        // 关键：带括号的正确写法
        this.dec_suc  == (local_struct.plane_sel[i] ? (local_struct.crc_pass[i] & local_struct.wbf_pass[i]) : 1'b1);
      }) begin
        $error("Randomization FAILED for tr[%0d] (with bracket)!", i);
        $finish;
      end
    end

    // 打印场景1结果
    $display("\n--- Results (with brackets) ---");
    foreach(tr[i]) begin
      $display("tr[%0d]: plane_sel=%0b, crc_pass=%0b, wbf_pass=%0b, dec_suc=%0b",
               i, tr[i].plane_sel, tr[i].crc_pass, tr[i].wbf_pass, tr[i].dec_suc);
    end
    foreach(tr[i]) final_dec_suc_with_bracket[i] = tr[i].dec_suc;
    $display("\nFinal dec_suc (with brackets): binary=%8b, hex=0x%02h", 
             final_dec_suc_with_bracket, final_dec_suc_with_bracket);

    // ============================================================
    // 场景2：缺括号的错误写法
    // ============================================================
    $display("\n\n");
    $display("################################################################");
    $display("### SCENARIO 2: WITHOUT BRACKETS (WRONG) ###");
    $display("################################################################");

    // 重新初始化tr句柄（重置状态）
    foreach(tr[i]) begin
      tr[i] = new();
      // 关键：给dec_suc一个初始值，让缺括号的结果更明显
      tr[i].dec_suc = 0; 
    end

    // 逐个randomize（缺括号）
    foreach(tr[i]) begin
      if (!tr[i].randomize() with {
        if (i == 0) {
          this.meta_buffer_id == local_struct.nsu_addr_que[0];
        }
        this.done_occur       == local_struct.done_occur[i];
        this.ost_id           == local_struct.ost_id;
        this.deep_read_status_sel == 0;
        this.program_verify_read   == 0;
        this.read_mode              == 0;
        this.response_sel_que       == local_struct.core_id;
        this.meta_mode              == 0;
        this.deep_read_sel          == 0;
        this.write_pos_jdg          == 0;
        this.crc_pass               == (local_struct.plane_sel[i] ? local_struct.crc_pass[i] : 1'b1);
        this.wbf_pass               == (local_struct.plane_sel[i] ? local_struct.wbf_pass[i] : 1'b1);
        this.error_flag             == 0;
        this.plane_sel              == local_struct.plane_sel[i];
        // 关键：缺括号的错误写法
        this.dec_suc  == local_struct.plane_sel[i] ? (local_struct.crc_pass[i] & local_struct.wbf_pass[i]) : 1'b1;
      }) begin
        $error("Randomization FAILED for tr[%0d] (without bracket)!", i);
        $finish;
      end
    end

    // 打印场景2结果
    $display("\n--- Results (without brackets) ---");
    foreach(tr[i]) begin
      $display("tr[%0d]: plane_sel=%0b, crc_pass=%0b, wbf_pass=%0b, dec_suc=%0b",
               i, tr[i].plane_sel, tr[i].crc_pass, tr[i].wbf_pass, tr[i].dec_suc);
    end
    foreach(tr[i]) final_dec_suc_without_bracket[i] = tr[i].dec_suc;
    $display("\nFinal dec_suc (without brackets): binary=%8b, hex=0x%02h", 
             final_dec_suc_without_bracket, final_dec_suc_without_bracket);

    // ============================================================
    // 最终对比总结
    // ============================================================
    $display("\n\n");
    $display("################################################################");
    $display("### FINAL COMPARISON ###");
    $display("################################################################");
    $display("With brackets (correct):    binary=%8b, hex=0x%02h", 
             final_dec_suc_with_bracket, final_dec_suc_with_bracket);
    $display("Without brackets (wrong):   binary=%8b, hex=0x%02h", 
             final_dec_suc_without_bracket, final_dec_suc_without_bracket);
    $display("################################################################");

    $finish;
  end

endmodule