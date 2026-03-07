`ifndef ONDEC2NSU_CHECKER_TB
`define ONDEC2NSU_CHECKER_TB

//=============================================================================
// mychecker_tb.sv - 测试平台 (Group 独立处理版本)
// Group 0: plane_pair[0:3], ost_id = tr[0].nsu_ost_id
// Group 1: plane_pair[4:7], ost_id = tr[4].nsu_ost_id
//=============================================================================

module ondec2nsu_checker_tb;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import nsu_cpu_transactions_pkg::*;
    import ondec2nsu_transaction_pkg::*;
    import nsu2offwbf_transaction_pkg::*;
    import ondec2nsu_checker_pkg::*;
    
    ondec2nsu_checker checker;
    
    initial begin
        // 创建 checker 实例
        checker = new("checker", null);
        checker.build_phase(null);
        
        // 启动 checker
        fork
            checker.run_phase(null);
        join_none
        
        // 等待 checker 启动
        #10;
        
        // 运行测试
        run_test();
        
        // 等待检查完成
        #50;
        
        // 报告
        checker.report_phase(null);
        
        // 打印最终统计
        print_final_stats();
        
        $finish;
    end
    
    //-------------------------------------------------------------------------
    // 测试任务
    //-------------------------------------------------------------------------
    task run_test();
        ondec2nsu_group_transaction ondec_cmd;
        nsu2cpu_deep_resp_transaction deep_resp;
        nsu2offwbf_transaction offwbf_tr;
        
        $display("");
        $display("========================================");
        $display("TEST 1: Both groups decode success");
        $display("        Group0 (PP[0:3]) + Group1 (PP[4:7])");
        $display("========================================");
        
        // 测试 1: 两个 group 都译码成功 (不需要上报 deep_resp 或 offwbf)
        ondec_cmd = ondec2nsu_group_transaction::type_id::create("ondec_cmd1");
        for (int i = 0; i < 8; i++) begin
            ondec_cmd.tr[i].instruction_index = 16'h0001;
            ondec_cmd.tr[i].plane_sel = 1'b1;
            ondec_cmd.tr[i].dec_suc = 1'b1;         // 译码成功
            ondec_cmd.tr[i].crc_pass = 1'b1;        // CRC 成功
            ondec_cmd.tr[i].data_out_en = 1'b1;     // 数据输出使能
        end
        // Group 0: ost_id=0, Group 1: ost_id=0 (一致)
        ondec_cmd.tr[0].nsu_ost_id = 5'h00;
        ondec_cmd.tr[4].nsu_ost_id = 5'h00;
        
        checker.ondec_cmd_fifo.write(ondec_cmd);
        $display("Sent ONDEC_GROUP: instr_idx=%0h, all 8 plane_pairs decode success", 
            ondec_cmd.tr[0].instruction_index);
        $display("  Group0 (PP[0:3]): ost_id=%0h, all decode success → No action", ondec_cmd.tr[0].nsu_ost_id);
        $display("  Group1 (PP[4:7]): ost_id=%0h, all decode success → No action", ondec_cmd.tr[4].nsu_ost_id);
        
        #20;
        
        $display("");
        $display("========================================");
        $display("TEST 2: Group0 need DEEP_READ_RESP");
        $display("        Group0: decode_fail+crc_success+no_data");
        $display("        Group1: decode_success");
        $display("========================================");
        
        // 测试 2: Group0 需要 deep_resp, Group1 无需动作
        ondec_cmd = ondec2nsu_group_transaction::type_id::create("ondec_cmd2");
        // Group 0 (PP[0:3]): 译码失败但 CRC 成功，数据不输出 → deep_resp
        for (int i = 0; i < 4; i++) begin
            ondec_cmd.tr[i].instruction_index = 16'h0002;
            ondec_cmd.tr[i].plane_sel = 1'b1;
            ondec_cmd.tr[i].dec_suc = 1'b0;         // 译码失败
            ondec_cmd.tr[i].crc_pass = 1'b1;        // CRC 成功
            ondec_cmd.tr[i].data_out_en = 1'b0;     // 数据不输出
            ondec_cmd.tr[i].deep_read_sel = 1'b1;
            ondec_cmd.tr[i].read_mode = 1'b0;
        end
        ondec_cmd.tr[0].nsu_ost_id = 5'h01;  // Group 0: ost_id=1
        
        // Group 1 (PP[4:7]): 译码成功 → 无需动作
        for (int i = 4; i < 8; i++) begin
            ondec_cmd.tr[i].instruction_index = 16'h0002;
            ondec_cmd.tr[i].plane_sel = 1'b1;
            ondec_cmd.tr[i].dec_suc = 1'b1;         // 译码成功
            ondec_cmd.tr[i].crc_pass = 1'b1;
            ondec_cmd.tr[i].data_out_en = 1'b1;
        end
        ondec_cmd.tr[4].nsu_ost_id = 5'h02;  // Group 1: ost_id=2 (独立)
        
        checker.ondec_cmd_fifo.write(ondec_cmd);
        $display("Sent ONDEC_GROUP: instr_idx=%0h", ondec_cmd.tr[0].instruction_index);
        $display("  Group0 (PP[0:3]): ost_id=%0h, decode_fail+crc_success+no_data → Expect DEEP_READ_RESP", ondec_cmd.tr[0].nsu_ost_id);
        $display("  Group1 (PP[4:7]): ost_id=%0h, decode_success → No action", ondec_cmd.tr[4].nsu_ost_id);
        
        #10;
        
        // 发送匹配的 deep_read_resp (Group 0)
        deep_resp = nsu2cpu_deep_resp_transaction::type_id::create("deep_resp2");
        deep_resp.instruction_index = 16'h0002;
        deep_resp.nsu_ost_id = 5'h01;  // 匹配 Group 0
        deep_resp.plane_pair_ondec_flag = 8'b0000_1111;  // PP[0:3] 失败，PP[4:7] 成功
        deep_resp.plane_pair_lba_comp = 8'b0000_0000;
        deep_resp.plane_crc_err = 8'b0000_1111;          // PP[0:3] CRC 成功
        deep_resp.deep_read_sel = 1'b1;
        deep_resp.mode_sel = 1'b0;
        
        checker.deep_read_resp_fifo.write(deep_resp);
        $display("Sent DEEP_READ_RESP: instr_idx=%0h, ost_id=%0h (matching Group0)", 
            deep_resp.instruction_index, deep_resp.nsu_ost_id);
        $display("  pp_ondec_flag=%08b (PP[0:3]=1=fail), pp_crc_err=%08b (PP[0:3]=1=success)", 
            deep_resp.plane_pair_ondec_flag, deep_resp.plane_crc_err);
        
        #20;
        
        $display("");
        $display("========================================");
        $display("TEST 3: Group1 need OFFWBF_CMD");
        $display("        Group0: decode_success");
        $display("        Group1: decode_fail+crc_success+data");
        $display("========================================");
        
        // 测试 3: Group1 需要 offwbf, Group0 无需动作
        ondec_cmd = ondec2nsu_group_transaction::type_id::create("ondec_cmd3");
        // Group 0 (PP[0:3]): 译码成功 → 无需动作
        for (int i = 0; i < 4; i++) begin
            ondec_cmd.tr[i].instruction_index = 16'h0003;
            ondec_cmd.tr[i].plane_sel = 1'b1;
            ondec_cmd.tr[i].dec_suc = 1'b1;
            ondec_cmd.tr[i].crc_pass = 1'b1;
            ondec_cmd.tr[i].data_out_en = 1'b1;
        end
        ondec_cmd.tr[0].nsu_ost_id = 5'h03;  // Group 0: ost_id=3
        
        // Group 1 (PP[4:7]): 译码失败但 CRC 成功，数据输出 → offwbf
        for (int i = 4; i < 8; i++) begin
            ondec_cmd.tr[i].instruction_index = 16'h0003;
            ondec_cmd.tr[i].plane_sel = 1'b1;
            ondec_cmd.tr[i].dec_suc = 1'b0;         // 译码失败
            ondec_cmd.tr[i].crc_pass = 1'b1;        // CRC 成功
            ondec_cmd.tr[i].data_out_en = 1'b1;     // 数据输出
            ondec_cmd.tr[i].offline_wbf_work_en = 1'b1;
            ondec_cmd.tr[i].read_mode = 1'b0;       // safe read
        end
        ondec_cmd.tr[4].nsu_ost_id = 5'h04;  // Group 1: ost_id=4 (独立)
        
        checker.ondec_cmd_fifo.write(ondec_cmd);
        $display("Sent ONDEC_GROUP: instr_idx=%0h", ondec_cmd.tr[0].instruction_index);
        $display("  Group0 (PP[0:3]): ost_id=%0h, decode_success → No action", ondec_cmd.tr[0].nsu_ost_id);
        $display("  Group1 (PP[4:7]): ost_id=%0h, decode_fail+crc_success+data → Expect OFFWBF_CMD", ondec_cmd.tr[4].nsu_ost_id);
        
        #10;
        
        // 发送匹配的 offwbf_cmd (Group 1)
        offwbf_tr = nsu2offwbf_transaction::type_id::create("offwbf_tr3");
        offwbf_tr.instruction_index = 16'h0003;
        offwbf_tr.nsu_ost_id = 5'h04;  // 匹配 Group 1
        offwbf_tr.src_mem_addr = 32'h3000_0000;
        offwbf_tr.dec_fail_dest_addr = 32'h3000_1000;
        offwbf_tr.offwbf_start = 1'b1;
        offwbf_tr.read_mode = 1'b0;
        
        checker.offwbf_cmd_fifo.write(offwbf_tr);
        $display("Sent OFFWBF_CMD: instr_idx=%0h, ost_id=%0h (matching Group1)", 
            offwbf_tr.instruction_index, offwbf_tr.nsu_ost_id);
        $display("  src_addr=%0h, offwbf_start=1", offwbf_tr.src_mem_addr);
        
        #20;
        
        $display("");
        $display("========================================");
        $display("TEST 4: Both groups need different actions");
        $display("        Group0: DEEP_READ_RESP (ost_id=5)");
        $display("        Group1: OFFWBF_CMD (ost_id=6)");
        $display("========================================");
        
        // 测试 4: 两个 group 需要不同的响应
        ondec_cmd = ondec2nsu_group_transaction::type_id::create("ondec_cmd4");
        // Group 0 (PP[0:3]): 译码失败但 CRC 成功，数据不输出 → deep_resp
        for (int i = 0; i < 4; i++) begin
            ondec_cmd.tr[i].instruction_index = 16'h0004;
            ondec_cmd.tr[i].plane_sel = 1'b1;
            ondec_cmd.tr[i].dec_suc = 1'b0;
            ondec_cmd.tr[i].crc_pass = 1'b1;
            ondec_cmd.tr[i].data_out_en = 1'b0;
            ondec_cmd.tr[i].deep_read_sel = 1'b1;
            ondec_cmd.tr[i].read_mode = 1'b0;
        end
        ondec_cmd.tr[0].nsu_ost_id = 5'h05;  // Group 0: ost_id=5
        
        // Group 1 (PP[4:7]): 译码失败但 CRC 成功，数据输出 → offwbf
        for (int i = 4; i < 8; i++) begin
            ondec_cmd.tr[i].instruction_index = 16'h0004;
            ondec_cmd.tr[i].plane_sel = 1'b1;
            ondec_cmd.tr[i].dec_suc = 1'b0;
            ondec_cmd.tr[i].crc_pass = 1'b1;
            ondec_cmd.tr[i].data_out_en = 1'b1;
            ondec_cmd.tr[i].offline_wbf_work_en = 1'b1;
            ondec_cmd.tr[i].read_mode = 1'b0;
        end
        ondec_cmd.tr[4].nsu_ost_id = 5'h06;  // Group 1: ost_id=6 (独立)
        
        checker.ondec_cmd_fifo.write(ondec_cmd);
        $display("Sent ONDEC_GROUP: instr_idx=%0h", ondec_cmd.tr[0].instruction_index);
        $display("  Group0 (PP[0:3]): ost_id=%0h → Expect DEEP_READ_RESP", ondec_cmd.tr[0].nsu_ost_id);
        $display("  Group1 (PP[4:7]): ost_id=%0h → Expect OFFWBF_CMD", ondec_cmd.tr[4].nsu_ost_id);
        
        #10;
        
        // 发送 deep_read_resp (Group 0)
        deep_resp = nsu2cpu_deep_resp_transaction::type_id::create("deep_resp4");
        deep_resp.instruction_index = 16'h0004;
        deep_resp.nsu_ost_id = 5'h05;  // 匹配 Group 0
        deep_resp.plane_pair_ondec_flag = 8'b0000_1111;  // PP[0:3] 失败
        deep_resp.plane_pair_lba_comp = 8'b0000_0000;
        deep_resp.plane_crc_err = 8'b0000_1111;          // PP[0:3] CRC 成功
        deep_resp.deep_read_sel = 1'b1;
        deep_resp.mode_sel = 1'b0;
        
        checker.deep_read_resp_fifo.write(deep_resp);
        $display("Sent DEEP_READ_RESP: instr_idx=%0h, ost_id=%0h (matching Group0)", 
            deep_resp.instruction_index, deep_resp.nsu_ost_id);
        
        #10;
        
        // 发送 offwbf_cmd (Group 1)
        offwbf_tr = nsu2offwbf_transaction::type_id::create("offwbf_tr4");
        offwbf_tr.instruction_index = 16'h0004;
        offwbf_tr.nsu_ost_id = 5'h06;  // 匹配 Group 1
        offwbf_tr.src_mem_addr = 32'h4000_0000;
        offwbf_tr.dec_fail_dest_addr = 32'h4000_1000;
        offwbf_tr.offwbf_start = 1'b1;
        offwbf_tr.read_mode = 1'b0;
        
        checker.offwbf_cmd_fifo.write(offwbf_tr);
        $display("Sent OFFWBF_CMD: instr_idx=%0h, ost_id=%0h (matching Group1)", 
            offwbf_tr.instruction_index, offwbf_tr.nsu_ost_id);
        
        #20;
    endtask : run_test
    
    //-------------------------------------------------------------------------
    // 打印最终统计
    //-------------------------------------------------------------------------
    task print_final_stats();
        int unsigned total_cmd, total_resp, total_offwbf, pass, fail;
        
        total_cmd = checker.total_cmd_count;
        total_resp = checker.total_resp_count;
        total_offwbf = checker.total_offwbf_count;
        pass = checker.pass_count;
        fail = checker.fail_count;
        
        $display("");
        $display("========================================");
        $display("FINAL STATISTICS");
        $display("========================================");
        $display("Total ONDEC_CMD:    %0d", total_cmd);
        $display("Total DEEP_RESP:    %0d", total_resp);
        $display("Total OFFWBF_CMD:   %0d", total_offwbf);
        $display("Pass:               %0d", pass);
        $display("Fail:               %0d", fail);
        $display("========================================");
        
        $display("");
        $display("Group Statistics (INDEPENDENT):");
        for (int gid = 0; gid < 2; gid++) begin
            $display("  Group%0d (PP[%0d:%0d]):", gid, gid*4, gid*4+3);
            $display("    decode_success=%0d, decode_fail=%0d, crc_err=%0d, lba_mismatch=%0d",
                checker.group_decode_success[gid], 
                checker.group_decode_fail[gid],
                checker.group_crc_err[gid],
                checker.group_lba_mismatch[gid]);
        end
        
        $display("");
        $display("OFFWBF Statistics:");
        $display("  OFFWBF success: %0d", checker.offwbf_success_count);
        $display("  OFFWBF fail:    %0d", checker.offwbf_fail_count);
        $display("========================================");
    endtask : print_final_stats
    
endmodule

`endif
