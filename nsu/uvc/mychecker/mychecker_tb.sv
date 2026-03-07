`ifndef ONDEC2NSU_CHECKER_TB
`define ONDEC2NSU_CHECKER_TB

//=============================================================================
// mychecker_tb.sv - 测试平台 (直接判断版本)
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
        $display("TEST 1: All plane_pairs decode success");
        $display("========================================");
        
        // 测试 1: 所有 plane_pair 译码成功 (不需要上报 deep_resp 或 offwbf)
        ondec_cmd = ondec2nsu_group_transaction::type_id::create("ondec_cmd1");
        for (int i = 0; i < 8; i++) begin
            ondec_cmd.tr[i].instruction_index = 16'h0001;
            ondec_cmd.tr[i].plane_sel = 1'b1;
            ondec_cmd.tr[i].dec_suc = 1'b1;         // 译码成功
            ondec_cmd.tr[i].crc_pass = 1'b1;        // CRC 成功
            ondec_cmd.tr[i].data_out_en = 1'b1;     // 数据输出使能
            ondec_cmd.tr[i].offline_wbf_work_en = 1'b0;
            ondec_cmd.tr[i].deep_read_sel = 1'b0;
            ondec_cmd.tr[i].read_mode = 1'b0;
            ondec_cmd.tr[i].nsu_ost_id = 5'h01;
            ondec_cmd.tr[i].dest_memory_addr = 32'h1000_0000;
        end
        
        checker.ondec_cmd_fifo.write(ondec_cmd);
        $display("Sent ONDEC_GROUP: instr_idx=%0h, all 8 plane_pairs decode success (EXPECT: no action)", 
            ondec_cmd.tr[0].instruction_index);
        
        #20;
        
        $display("");
        $display("========================================");
        $display("TEST 2: Decode fail + CRC success + no data output");
        $display("         → Expect DEEP_READ_RESP");
        $display("========================================");
        
        // 测试 2: 译码失败但 CRC 成功，数据不输出 → 需要上报 deep_resp
        ondec_cmd = ondec2nsu_group_transaction::type_id::create("ondec_cmd2");
        for (int i = 0; i < 8; i++) begin
            ondec_cmd.tr[i].instruction_index = 16'h0002;
            ondec_cmd.tr[i].plane_sel = 1'b1;
            ondec_cmd.tr[i].dec_suc = 1'b0;         // 译码失败
            ondec_cmd.tr[i].crc_pass = 1'b1;        // CRC 成功
            ondec_cmd.tr[i].data_out_en = 1'b0;     // 数据不输出
            ondec_cmd.tr[i].offline_wbf_work_en = 1'b0;
            ondec_cmd.tr[i].deep_read_sel = 1'b1;   // deep read 使能
            ondec_cmd.tr[i].read_mode = 1'b0;       // safe read
            ondec_cmd.tr[i].nsu_ost_id = 5'h02;
            ondec_cmd.tr[i].dest_memory_addr = 32'h2000_0000;
            ondec_cmd.tr[i].dec_fail_dest_addr = 32'h2000_1000;
        end
        
        checker.ondec_cmd_fifo.write(ondec_cmd);
        $display("Sent ONDEC_GROUP: instr_idx=%0h, decode fail + CRC success + no data output (EXPECT: DEEP_READ_RESP)", 
            ondec_cmd.tr[0].instruction_index);
        
        #10;
        
        // 发送匹配的 deep_read_resp
        deep_resp = nsu2cpu_deep_resp_transaction::type_id::create("deep_resp2");
        deep_resp.instruction_index = 16'h0002;
        deep_resp.nsu_ost_id = 5'h02;
        deep_resp.plane_pair_ondec_flag = 8'b1111_1111;  // 全部译码失败 (1=失败)
        deep_resp.plane_pair_lba_comp = 8'b0000_0000;    // LBA 全部匹配
        deep_resp.plane_crc_err = 8'b1111_1111;          // CRC 全部成功 (1=成功)
        deep_resp.deep_read_sel = 1'b1;
        deep_resp.mode_sel = 1'b0;
        
        checker.deep_read_resp_fifo.write(deep_resp);
        $display("Sent DEEP_READ_RESP: instr_idx=%0h, pp_ondec_flag=%08b (all fail), pp_crc_err=%08b (all success) (EXPECT PASS)", 
            deep_resp.instruction_index, deep_resp.plane_pair_ondec_flag, deep_resp.plane_crc_err);
        
        #20;
        
        $display("");
        $display("========================================");
        $display("TEST 3: Decode fail + CRC success + data output");
        $display("         → Expect OFFWBF_CMD");
        $display("========================================");
        
        // 测试 3: 译码失败但 CRC 成功，数据输出 → 需要调用 offwbf
        ondec_cmd = ondec2nsu_group_transaction::type_id::create("ondec_cmd3");
        for (int i = 0; i < 8; i++) begin
            ondec_cmd.tr[i].instruction_index = 16'h0003;
            ondec_cmd.tr[i].plane_sel = 1'b1;
            ondec_cmd.tr[i].dec_suc = 1'b0;         // 译码失败
            ondec_cmd.tr[i].crc_pass = 1'b1;        // CRC 成功
            ondec_cmd.tr[i].data_out_en = 1'b1;     // 数据输出
            ondec_cmd.tr[i].offline_wbf_work_en = 1'b1;  // offwbf 使能
            ondec_cmd.tr[i].deep_read_sel = 1'b0;
            ondec_cmd.tr[i].read_mode = 1'b0;       // safe read
            ondec_cmd.tr[i].nsu_ost_id = 5'h03;
            ondec_cmd.tr[i].dest_memory_addr = 32'h3000_0000;
            ondec_cmd.tr[i].dec_fail_dest_addr = 32'h3000_1000;
        end
        
        checker.ondec_cmd_fifo.write(ondec_cmd);
        $display("Sent ONDEC_GROUP: instr_idx=%0h, decode fail + CRC success + data output (EXPECT: OFFWBF_CMD)", 
            ondec_cmd.tr[0].instruction_index);
        
        #10;
        
        // 发送匹配的 offwbf_cmd
        offwbf_tr = nsu2offwbf_transaction::type_id::create("offwbf_tr3");
        offwbf_tr.instruction_index = 16'h0003;
        offwbf_tr.nsu_ost_id = 5'h03;
        offwbf_tr.src_mem_addr = 32'h3000_0000;      // 与 dest_memory_addr 匹配
        offwbf_tr.dec_fail_dest_addr = 32'h3000_1000;
        offwbf_tr.offwbf_start = 1'b1;
        offwbf_tr.read_mode = 1'b0;
        
        checker.offwbf_cmd_fifo.write(offwbf_tr);
        $display("Sent OFFWBF_CMD: instr_idx=%0h, src_addr=%0h, offwbf_start=1 (EXPECT PASS)", 
            offwbf_tr.instruction_index, offwbf_tr.src_mem_addr);
        
        #20;
        
        $display("");
        $display("========================================");
        $display("TEST 4: Mixed scenario");
        $display("         PP[0,2,4,6]: decode fail + no data output → DEEP_READ_RESP");
        $display("         PP[1,3,5,7]: decode fail + data output → OFFWBF_CMD");
        $display("========================================");
        
        // 测试 4: 混合场景
        ondec_cmd = ondec2nsu_group_transaction::type_id::create("ondec_cmd4");
        for (int i = 0; i < 8; i++) begin
            ondec_cmd.tr[i].instruction_index = 16'h0004;
            ondec_cmd.tr[i].plane_sel = 1'b1;
            ondec_cmd.tr[i].dec_suc = 1'b0;         // 全部译码失败
            ondec_cmd.tr[i].crc_pass = 1'b1;        // 全部 CRC 成功
            ondec_cmd.tr[i].nsu_ost_id = 5'h04;
            ondec_cmd.tr[i].dest_memory_addr = 32'h4000_0000;
            ondec_cmd.tr[i].dec_fail_dest_addr = 32'h4000_1000;
            ondec_cmd.tr[i].read_mode = 1'b0;
            
            // 偶数 plane_pair: 数据不输出 → deep_resp
            if (i inside {[0,2,4,6]}) begin
                ondec_cmd.tr[i].data_out_en = 1'b0;
                ondec_cmd.tr[i].offline_wbf_work_en = 1'b0;
                ondec_cmd.tr[i].deep_read_sel = 1'b1;
            end
            // 奇数 plane_pair: 数据输出 → offwbf
            else begin
                ondec_cmd.tr[i].data_out_en = 1'b1;
                ondec_cmd.tr[i].offline_wbf_work_en = 1'b1;
                ondec_cmd.tr[i].deep_read_sel = 1'b0;
            end
        end
        
        checker.ondec_cmd_fifo.write(ondec_cmd);
        $display("Sent ONDEC_GROUP: instr_idx=%0h, mixed scenario", 
            ondec_cmd.tr[0].instruction_index);
        
        #10;
        
        // 发送 deep_read_resp (检查偶数 plane_pair)
        deep_resp = nsu2cpu_deep_resp_transaction::type_id::create("deep_resp4");
        deep_resp.instruction_index = 16'h0004;
        deep_resp.nsu_ost_id = 5'h04;
        deep_resp.plane_pair_ondec_flag = 8'b1111_1111;  // 全部失败
        deep_resp.plane_pair_lba_comp = 8'b0000_0000;
        deep_resp.plane_crc_err = 8'b1111_1111;
        deep_resp.deep_read_sel = 1'b1;
        deep_resp.mode_sel = 1'b0;
        
        checker.deep_read_resp_fifo.write(deep_resp);
        $display("Sent DEEP_READ_RESP: instr_idx=%0h (checking PP[0,2,4,6])", deep_resp.instruction_index);
        
        #10;
        
        // 发送 offwbf_cmd (检查奇数 plane_pair)
        offwbf_tr = nsu2offwbf_transaction::type_id::create("offwbf_tr4");
        offwbf_tr.instruction_index = 16'h0004;
        offwbf_tr.nsu_ost_id = 5'h04;
        offwbf_tr.src_mem_addr = 32'h4000_0000;
        offwbf_tr.dec_fail_dest_addr = 32'h4000_1000;
        offwbf_tr.offwbf_start = 1'b1;
        offwbf_tr.read_mode = 1'b0;
        
        checker.offwbf_cmd_fifo.write(offwbf_tr);
        $display("Sent OFFWBF_CMD: instr_idx=%0h (checking PP[1,3,5,7])", offwbf_tr.instruction_index);
        
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
        $display("Plane Pair Statistics:");
        for (int pp = 0; pp < 8; pp++) begin
            $display("  PP[%0d]: decode_success=%0d, decode_fail=%0d, crc_err=%0d, lba_mismatch=%0d",
                pp, checker.plane_pair_decode_success[pp], 
                checker.plane_pair_decode_fail[pp],
                checker.plane_pair_crc_err[pp],
                checker.plane_pair_lba_mismatch[pp]);
        end
        
        $display("");
        $display("OFFWBF Statistics:");
        $display("  OFFWBF success: %0d", checker.offwbf_success_count);
        $display("  OFFWBF fail:    %0d", checker.offwbf_fail_count);
        $display("========================================");
    endtask : print_final_stats
    
endmodule

`endif
