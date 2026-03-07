`ifndef ONDEC2NSU_CHECKER_TB
`define ONDEC2NSU_CHECKER_TB

//=============================================================================
// ondec2nsu_checker_tb.sv
// 测试平台 - 测试 ondec_cmd 到 resp 的检查
//=============================================================================

module ondec2nsu_checker_tb;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import nsu_cpu_transactions_pkg::*;
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
        nsu2cpu_deep_resp_transaction ondec_cmd;
        nsu2cpu_deep_resp_transaction resp;
        
        $display("");
        $display("========================================");
        $display("TEST 1: All plane_pairs decode success");
        $display("========================================");
        
        // 测试 1: 所有 plane_pair 译码成功
        // 1. 发送 ondec_cmd
        ondec_cmd = nsu2cpu_deep_resp_transaction::type_id::create("ondec_cmd1");
        ondec_cmd.instruction_index = 16'h0001;
        ondec_cmd.plane_pair_en = 8'hFF;  // 8 个 plane_pair 都使能
        ondec_cmd.nand_cmd_index = 8'h01;
        ondec_cmd.mode_sel = 1'b0;  // safe read
        
        checker.ondec_cmd_fifo.write(ondec_cmd);
        $display("Sent ONDEC_CMD: instr_idx=%0h, pp_en=%08b", 
            ondec_cmd.instruction_index, ondec_cmd.plane_pair_en);
        
        #10;
        
        // 2. 发送 resp (全部成功)
        resp = nsu2cpu_deep_resp_transaction::type_id::create("resp1");
        resp.instruction_index = 16'h0001;
        resp.plane_pair_en = 8'hFF;
        resp.plane_pair_ondec_flag = 8'b0000_0000;  // 全部成功
        resp.plane_pair_lba_comp = 8'b0000_0000;    // LBA 全部匹配
        resp.plane_crc_err = 8'b1111_1111;          // CRC 全部成功
        resp.mode_sel = 1'b0;
        
        checker.deep_read_resp_fifo.write(resp);
        $display("Sent DEEP_READ_RESP: instr_idx=%0h, pp_ondec_flag=%08b, pp_crc_err=%08b", 
            resp.instruction_index, resp.plane_pair_ondec_flag, resp.plane_crc_err);
        
        #20;
        
        $display("");
        $display("========================================");
        $display("TEST 2: Some plane_pairs decode fail");
        $display("========================================");
        
        // 测试 2: 部分 plane_pair 译码失败
        // 1. 发送 ondec_cmd
        ondec_cmd = nsu2cpu_deep_resp_transaction::type_id::create("ondec_cmd2");
        ondec_cmd.instruction_index = 16'h0002;
        ondec_cmd.plane_pair_en = 8'hFF;
        ondec_cmd.nand_cmd_index = 8'h02;
        
        checker.ondec_cmd_fifo.write(ondec_cmd);
        $display("Sent ONDEC_CMD: instr_idx=%0h, pp_en=%08b", 
            ondec_cmd.instruction_index, ondec_cmd.plane_pair_en);
        
        #10;
        
        // 2. 发送 resp (plane 0,2,4 失败)
        resp = nsu2cpu_deep_resp_transaction::type_id::create("resp2");
        resp.instruction_index = 16'h0002;
        resp.plane_pair_en = 8'hFF;
        resp.plane_pair_ondec_flag = 8'b0001_0101;  // plane 0,2,4 失败
        resp.plane_pair_lba_comp = 8'b0000_0000;
        resp.plane_crc_err = 8'b1111_1111;
        
        checker.deep_read_resp_fifo.write(resp);
        $display("Sent DEEP_READ_RESP: instr_idx=%0h, pp_ondec_flag=%08b (0,2,4 fail)", 
            resp.instruction_index, resp.plane_pair_ondec_flag);
        
        #20;
        
        $display("");
        $display("========================================");
        $display("TEST 3: CRC failure");
        $display("========================================");
        
        // 测试 3: CRC 失败
        // 1. 发送 ondec_cmd
        ondec_cmd = nsu2cpu_deep_resp_transaction::type_id::create("ondec_cmd3");
        ondec_cmd.instruction_index = 16'h0003;
        ondec_cmd.plane_pair_en = 8'hFF;
        
        checker.ondec_cmd_fifo.write(ondec_cmd);
        $display("Sent ONDEC_CMD: instr_idx=%0h", ondec_cmd.instruction_index);
        
        #10;
        
        // 2. 发送 resp (plane 1,3 CRC 失败)
        resp = nsu2cpu_deep_resp_transaction::type_id::create("resp3");
        resp.instruction_index = 16'h0003;
        resp.plane_pair_ondec_flag = 8'b0000_0000;  // 译码全部成功
        resp.plane_pair_lba_comp = 8'b0000_0000;
        resp.plane_crc_err = 8'b1101_0101;          // plane 1,3 CRC 失败 (0=失败)
        
        checker.deep_read_resp_fifo.write(resp);
        $display("Sent DEEP_READ_RESP: instr_idx=%0h, pp_crc_err=%08b (1,3 fail)", 
            resp.instruction_index, resp.plane_crc_err);
        
        #20;
        
        $display("");
        $display("========================================");
        $display("TEST 4: Partial plane_pair enable");
        $display("========================================");
        
        // 测试 4: 部分 plane_pair 使能
        // 1. 发送 ondec_cmd (只使能 plane 0,2,4,6)
        ondec_cmd = nsu2cpu_deep_resp_transaction::type_id::create("ondec_cmd4");
        ondec_cmd.instruction_index = 16'h0004;
        ondec_cmd.plane_pair_en = 8'b0101_0101;  // 只使能 plane 0,2,4,6
        
        checker.ondec_cmd_fifo.write(ondec_cmd);
        $display("Sent ONDEC_CMD: instr_idx=%0h, pp_en=%08b (only 0,2,4,6)", 
            ondec_cmd.instruction_index, ondec_cmd.plane_pair_en);
        
        #10;
        
        // 2. 发送 resp (使能的都成功，未使能的失败也不影响)
        resp = nsu2cpu_deep_resp_transaction::type_id::create("resp4");
        resp.instruction_index = 16'h0004;
        resp.plane_pair_en = 8'b0101_0101;
        resp.plane_pair_ondec_flag = 8'b1010_1010;  // 未使能的 plane 1,3,5,7 失败
        resp.plane_pair_lba_comp = 8'b0000_0000;
        resp.plane_crc_err = 8'b1111_1111;          // 使能的都成功
        
        checker.deep_read_resp_fifo.write(resp);
        $display("Sent DEEP_READ_RESP: instr_idx=%0h, pp_ondec_flag=%08b", 
            resp.instruction_index, resp.plane_pair_ondec_flag);
        
        #20;
    endtask : run_test
    
    //-------------------------------------------------------------------------
    // 打印最终统计
    //-------------------------------------------------------------------------
    task print_final_stats();
        int unsigned total_cmd, total_resp, pass, fail;
        
        total_cmd = checker.total_cmd_count;
        total_resp = checker.total_resp_count;
        pass = checker.pass_count;
        fail = checker.fail_count;
        
        $display("");
        $display("========================================");
        $display("FINAL STATISTICS");
        $display("========================================");
        $display("Total ONDEC_CMD:  %0d", total_cmd);
        $display("Total RESP:       %0d", total_resp);
        $display("Pass:             %0d", pass);
        $display("Fail:             %0d", fail);
        $display("========================================");
        
        $display("");
        $display("PLANE_PAIR STATISTICS:");
        for (int pp = 0; pp < PLANE_PAIR_NUM; pp++) begin
            $display("  PP[%0d]: decode_success=%0d, decode_fail=%0d, crc_err=%0d, lba_mismatch=%0d",
                pp, 
                checker.plane_pair_decode_success[pp],
                checker.plane_pair_decode_fail[pp],
                checker.plane_pair_crc_err[pp],
                checker.plane_pair_lba_mismatch[pp]);
        end
        $display("");
        
        if (fail == 0 && total_resp > 0) begin
            $display(">>> TEST PASSED! <<<");
        end else if (fail > 0) begin
            $display(">>> TEST FAILED! <<<");
        end
        $display("");
    endtask : print_final_stats
    
endmodule : ondec2nsu_checker_tb


`endif // ONDEC2NSU_CHECKER_TB
