`ifndef ONDEC2NSU_CHECKER_TB
`define ONDEC2NSU_CHECKER_TB

//=============================================================================
// ondec2nsu_checker_tb.sv
// ONDEC2NSU Checker 测试平台示例 (仅读操作)
// 
// 依赖：nsu_cpu_transactions.sv (nsu_cpu_transactions_pkg)
//       ondec2nsu_checker.sv (ondec2nsu_checker_pkg)
//=============================================================================

package ondec2nsu_checker_tb_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    
    // 导入依赖包
    import nsu_cpu_transactions_pkg::*;
    import ondec2nsu_checker_pkg::*;

    //=========================================================================
    // 测试序列基类
    //=========================================================================
    
    class base_test_seq extends uvm_sequence #(uvm_object);
        `uvm_object_utils(base_test_seq)
        
        ondec2nsu_checker checker;
        
        function new(string name = "base_test_seq");
            super.new(name);
        endfunction
        
        virtual task body();
            `uvm_fatal(get_type_name(), "body() not implemented")
        endtask
    endclass : base_test_seq
    
    //=========================================================================
    // 测试用例：Read Resp 检查 (成功场景)
    //=========================================================================
    
    class read_resp_success_test_seq extends base_test_seq;
        `uvm_object_utils(read_resp_success_test_seq)
        
        function new(string name = "read_resp_success_test_seq");
            super.new(name);
        endfunction
        
        virtual task body();
            expected_resp_config_t cfg;
            nsu2cpu_rcmd_transaction resp;
            
            `uvm_info(get_type_name(), "Starting READ_RESP success test", UVM_LOW)
            
            // 配置期望译码成功 (8 个 plane_pair)
            cfg = '{
                valid: 1'b1,
                expected_ost_id: 5'h0,
                expected_instruction_index: 16'h0010,
                expected_decode_success: 1'b1,  // 期望译码成功
                expected_lba_match: 1'b1,
                expected_err_flag_match: 1'b1,
                expected_crc_success: 1'b1,
                expected_error_plane_pair_sel: 8'b0,  // 所有 plane_pair 成功
                expected_plane_pair_en: 8'hFF,
                expected_plane_pair_ondec_flag: 8'b0,
                expected_plane_pair_lba_comp: 8'b0,
                expected_mode_sel: 1'b0
            };
            
            checker.register_expected_config(cfg);
            
            // 模拟 DUT 发送成功的响应
            resp = nsu2cpu_rcmd_transaction::type_id::create("resp");
            resp.instruction_index = 16'h0010;
            resp.nand_cmd_index = 8'h01;
            resp.error_plane_pair_sel = 8'b0;  // 译码成功
            
            checker.read_resp_fifo.write(resp);
            
            `uvm_info(get_type_name(), "READ_RESP success test completed", UVM_LOW)
        endtask
    endclass : read_resp_success_test_seq
    
    //=========================================================================
    // 测试用例：Read Resp 检查 (失败场景)
    //=========================================================================
    
    class read_resp_fail_test_seq extends base_test_seq;
        `uvm_object_utils(read_resp_fail_test_seq)
        
        function new(string name = "read_resp_fail_test_seq");
            super.new(name);
        endfunction
        
        virtual task body();
            expected_resp_config_t cfg;
            nsu2cpu_rcmd_transaction resp;
            
            `uvm_info(get_type_name(), "Starting READ_RESP fail test", UVM_LOW)
            
            // 配置期望译码成功 (但实际会失败，用于验证检查器能捕获错误)
            cfg = '{
                valid: 1'b1,
                expected_ost_id: 5'h0,
                expected_instruction_index: 16'h0020,
                expected_decode_success: 1'b1,  // 期望成功
                expected_lba_match: 1'b1,
                expected_err_flag_match: 1'b1,
                expected_crc_success: 1'b1,
                expected_error_plane_pair_sel: 8'b0,
                expected_plane_pair_en: 8'hFF,
                expected_plane_pair_ondec_flag: 8'b0,
                expected_plane_pair_lba_comp: 8'b0,
                expected_mode_sel: 1'b0
            };
            
            checker.register_expected_config(cfg);
            
            // 模拟 DUT 发送失败的响应 (译码失败)
            resp = nsu2cpu_rcmd_transaction::type_id::create("resp");
            resp.instruction_index = 16'h0020;
            resp.nand_cmd_index = 8'h01;
            resp.error_plane_pair_sel = 8'b0000_0101;  // plane 0 和 2 失败
            
            checker.read_resp_fifo.write(resp);
            
            `uvm_info(get_type_name(), "READ_RESP fail test completed (expected to fail)", UVM_LOW)
        endtask
    endclass : read_resp_fail_test_seq
    
    //=========================================================================
    // 测试用例：Deep Read Resp 检查 (8 个 plane_pair)
    //=========================================================================
    
    class deep_read_resp_test_seq extends base_test_seq;
        `uvm_object_utils(deep_read_resp_test_seq)
        
        function new(string name = "deep_read_resp_test_seq");
            super.new(name);
        endfunction
        
        virtual task body();
            expected_resp_config_t cfg;
            nsu2cpu_deep_resp_transaction resp;
            
            `uvm_info(get_type_name(), "Starting DEEP_READ_RESP test", UVM_LOW)
            
            // 配置期望的响应
            cfg = '{
                valid: 1'b1,
                expected_ost_id: 5'h0,
                expected_instruction_index: 16'h0100,
                expected_decode_success: 1'b1,
                expected_lba_match: 1'b1,
                expected_err_flag_match: 1'b1,
                expected_crc_success: 1'b1,
                expected_error_plane_pair_sel: 8'b0,
                expected_plane_pair_en: 8'hFF,
                expected_plane_pair_ondec_flag: 8'b0,
                expected_plane_pair_lba_comp: 8'b0,
                expected_mode_sel: 1'b0
            };
            
            checker.register_expected_config(cfg);
            
            // 初始化响应
            resp = nsu2cpu_deep_resp_transaction::type_id::create("resp");
            
            // 设置关键字段
            resp.instruction_index = 16'h0100;
            resp.nand_cmd_index = 8'h02;
            resp.plane_pair_en = 8'hFF;  // 8 个 plane_pair 都使能
            resp.plane_pair_ondec_flag = 8'b0;  // 全部成功
            resp.plane_pair_lba_comp = 8'b0;    // LBA 全部匹配
            resp.plane_crc_err = 8'hFF;         // CRC 全部成功
            resp.mode_sel = 1'b0;               // safe read
            resp.deep_read_sel = 1'b0;
            
            checker.deep_read_resp_fifo.write(resp);
            
            `uvm_info(get_type_name(), "DEEP_READ_RESP test completed", UVM_LOW)
        endtask
    endclass : deep_read_resp_test_seq
    
    //=========================================================================
    // 测试用例：MSA Req-Resp 自动配对测试
    //=========================================================================
    
    class msa_auto_pair_test_seq extends base_test_seq;
        `uvm_object_utils(msa_auto_pair_test_seq)
        
        function new(string name = "msa_auto_pair_test_seq");
            super.new(name);
        endfunction
        
        virtual task body();
            cpu2nsu_msa_write_req_transaction msa_req;
            nsu2cpu_msa_resp_transaction msa_resp;
            
            `uvm_info(get_type_name(), "Starting MSA_AUTO_PAIR test", UVM_LOW)
            
            // 1. CPU 发送 MSA 请求 (checker 会自动注册期望配置)
            msa_req = cpu2nsu_msa_write_req_transaction::type_id::create("msa_req");
            msa_req.instruction_index = 16'h0200;
            msa_req.ost_id = 5'h3;
            msa_req.nsu_addr = 30'h12345;
            
            checker.msa_req_fifo.write(msa_req);
            
            // 2. NSU 返回 MSA 响应
            msa_resp = nsu2cpu_msa_resp_transaction::type_id::create("msa_resp");
            msa_resp.instruction_index = 16'h0200;  // 与请求匹配
            
            checker.msa_resp_fifo.write(msa_resp);
            
            `uvm_info(get_type_name(), "MSA_AUTO_PAIR test completed", UVM_LOW)
        endtask
    endclass : msa_auto_pair_test_seq
    
    //=========================================================================
    // 测试用例：Plane Pair 统计测试
    //=========================================================================
    
    class plane_pair_stats_test_seq extends base_test_seq;
        `uvm_object_utils(plane_pair_stats_test_seq)
        
        function new(string name = "plane_pair_stats_test_seq");
            super.new(name);
        endfunction
        
        virtual task body();
            nsu2cpu_deep_resp_transaction resp;
            int unsigned decode_success [0:7];
            int unsigned decode_fail [0:7];
            int unsigned crc_err [0:7];
            int unsigned lba_mismatch [0:7];
            
            `uvm_info(get_type_name(), "Starting PLANE_PAIR_STATS test", UVM_LOW)
            
            // 发送多个 deep read resp，模拟不同的 plane_pair 状态
            
            // 响应 1: plane 0,2,4 失败
            resp = nsu2cpu_deep_resp_transaction::type_id::create("resp1");
            resp.instruction_index = 16'h2001;
            resp.plane_pair_ondec_flag = 8'b0001_0101;  // plane 0,2,4 失败
            resp.plane_pair_lba_comp = 8'b0;
            resp.plane_crc_err = 8'hFF;
            checker.deep_read_resp_fifo.write(resp);
            
            // 响应 2: plane 1,3 失败
            resp = nsu2cpu_deep_resp_transaction::type_id::create("resp2");
            resp.instruction_index = 16'h2002;
            resp.plane_pair_ondec_flag = 8'b0000_1010;  // plane 1,3 失败
            resp.plane_pair_lba_comp = 8'b0000_0010;    // plane 1 LBA 失败
            resp.plane_crc_err = 8'hFD;                 // plane 1 CRC 失败
            checker.deep_read_resp_fifo.write(resp);
            
            // 获取统计
            checker.get_plane_pair_stats(decode_success, decode_fail, crc_err, lba_mismatch);
            
            `uvm_info(get_type_name(), "PLANE_PAIR Statistics:", UVM_LOW)
            for (int pp = 0; pp < PLANE_PAIR_NUM; pp++) begin
                `uvm_info(get_type_name(), $sformatf(
                    "  PP[%0d]: success=%0d, fail=%0d, crc_err=%0d, lba_mismatch=%0d",
                    pp, decode_success[pp], decode_fail[pp], crc_err[pp], lba_mismatch[pp]
                ), UVM_LOW)
            end
            
            `uvm_info(get_type_name(), "PLANE_PAIR_STATS test completed", UVM_LOW)
        endtask
    endclass : plane_pair_stats_test_seq
    
    //=========================================================================
    // 测试用例：混合场景测试 (仅读操作)
    //=========================================================================
    
    class mixed_read_test_seq extends base_test_seq;
        `uvm_object_utils(mixed_read_test_seq)
        
        function new(string name = "mixed_read_test_seq");
            super.new(name);
        endfunction
        
        virtual task body();
            expected_resp_config_t cfg;
            nsu2cpu_rcmd_transaction read_resp;
            nsu2cpu_deep_resp_transaction deep_resp;
            nsu2cpu_msa_resp_transaction msa_resp;
            
            `uvm_info(get_type_name(), "Starting MIXED_READ test", UVM_LOW)
            
            // 注册期望配置
            
            // 1. Read Resp
            cfg = '{
                valid: 1'b1,
                expected_ost_id: 5'h0,
                expected_instruction_index: 16'h1002,
                expected_decode_success: 1'b1,
                expected_lba_match: 1'b1,
                expected_err_flag_match: 1'b1,
                expected_crc_success: 1'b1,
                expected_error_plane_pair_sel: 8'b0,
                expected_plane_pair_en: 8'hFF,
                expected_plane_pair_ondec_flag: 8'b0,
                expected_plane_pair_lba_comp: 8'b0,
                expected_mode_sel: 1'b0
            };
            checker.register_expected_config(cfg);
            
            // 2. Deep Read Resp
            cfg.expected_instruction_index = 16'h1003;
            cfg.expected_decode_success = 1'b1;
            cfg.expected_lba_match = 1'b1;
            checker.register_expected_config(cfg);
            
            // 3. MSA Resp
            cfg.expected_instruction_index = 16'h1004;
            checker.register_expected_config(cfg);
            
            // 发送响应 (乱序以测试检查器鲁棒性)
            
            // 先发送 deep read resp
            deep_resp = nsu2cpu_deep_resp_transaction::type_id::create("deep_resp");
            deep_resp.instruction_index = 16'h1003;
            deep_resp.plane_pair_ondec_flag = 8'b0;
            checker.deep_read_resp_fifo.write(deep_resp);
            
            // 再发送 read resp
            read_resp = nsu2cpu_rcmd_transaction::type_id::create("read_resp");
            read_resp.instruction_index = 16'h1002;
            read_resp.nand_cmd_index = 8'h01;
            read_resp.error_plane_pair_sel = 8'b0;
            checker.read_resp_fifo.write(read_resp);
            
            // 最后发送 msa resp
            msa_resp = nsu2cpu_msa_resp_transaction::type_id::create("msa_resp");
            msa_resp.instruction_index = 16'h1004;
            checker.msa_resp_fifo.write(msa_resp);
            
            `uvm_info(get_type_name(), "MIXED_READ test completed", UVM_LOW)
        endtask
    endclass : mixed_read_test_seq
    
endpackage : ondec2nsu_checker_tb_pkg


//=============================================================================
// 测试平台顶层
//=============================================================================

module ondec2nsu_checker_tb;
    
    import uvm_pkg::*;
    import nsu_cpu_transactions_pkg::*;
    import ondec2nsu_checker_pkg::*;
    import ondec2nsu_checker_tb_pkg::*;
    
    ondec2nsu_checker checker;
    
    initial begin
        // 创建 checker 实例
        checker = new("checker");
        checker.build_phase(null);
        
        // 启动 checker
        fork
            checker.run_phase(null);
        join_none
        
        // 等待一段时间让 checker 启动
        #10;
        
        // 运行测试序列 (仅读操作相关)
        run_tests();
        
        // 等待检查完成
        #100;
        
        // 报告阶段
        checker.report_phase(null);
        
        // 打印最终统计
        print_final_stats();
        
        $finish;
    end
    
    task run_tests();
        read_resp_success_test_seq read_seq;
        deep_read_resp_test_seq deep_seq;
        msa_auto_pair_test_seq msa_seq;
        mixed_read_test_seq mixed_seq;
        plane_pair_stats_test_seq stats_seq;
        
        `uvm_info("TB", "=== Running Test 1: READ_RESP_SUCCESS ===", UVM_LOW)
        read_seq = read_resp_success_test_seq::type_id::create("read_seq");
        read_seq.checker = checker;
        read_seq.body();
        
        #10;
        
        `uvm_info("TB", "=== Running Test 2: DEEP_READ_RESP ===", UVM_LOW)
        deep_seq = deep_read_resp_test_seq::type_id::create("deep_seq");
        deep_seq.checker = checker;
        deep_seq.body();
        
        #10;
        
        `uvm_info("TB", "=== Running Test 3: MSA_AUTO_PAIR ===", UVM_LOW)
        msa_seq = msa_auto_pair_test_seq::type_id::create("msa_seq");
        msa_seq.checker = checker;
        msa_seq.body();
        
        #10;
        
        `uvm_info("TB", "=== Running Test 4: MIXED_READ ===", UVM_LOW)
        mixed_seq = mixed_read_test_seq::type_id::create("mixed_seq");
        mixed_seq.checker = checker;
        mixed_seq.body();
        
        #10;
        
        `uvm_info("TB", "=== Running Test 5: PLANE_PAIR_STATS ===", UVM_LOW)
        stats_seq = plane_pair_stats_test_seq::type_id::create("stats_seq");
        stats_seq.checker = checker;
        stats_seq.body();
        
        #10;
    endtask
    
    task print_final_stats();
        int unsigned total, pass, fail;
        int unsigned read, deep_read, msa, msa_req, unmap_cmd;
        
        checker.get_stats(total, pass, fail);
        checker.get_detailed_stats(read, deep_read, msa, msa_req, unmap_cmd);
        
        $display("");
        $display("========================================");
        $display("FINAL STATISTICS (READ ONLY)");
        $display("========================================");
        $display("PLANE_PAIR_NUM: %0d", PLANE_PAIR_NUM);
        $display("----------------------------------------");
        $display("Total Responses Checked: %0d", total);
        $display("  NSU→CPU Responses:");
        $display("    READ_RESP:      %0d", read);
        $display("    DEEP_READ_RESP: %0d", deep_read);
        $display("    MSA_RESP:       %0d", msa);
        $display("  CPU→NSU Commands (mon):");
        $display("    MSA_REQ:        %0d", msa_req);
        $display("    UNMAP_CMD:      %0d", unmap_cmd);
        $display("----------------------------------------");
        $display("Pass: %0d", pass);
        $display("Fail: %0d", fail);
        $display("========================================");
        
        if (fail == 0 && total > 0) begin
            $display("TEST PASSED!");
        end else if (fail > 0) begin
            $display("TEST FAILED!");
        end
        $display("");
    endtask
    
endmodule : ondec2nsu_checker_tb


`endif // ONDEC2NSU_CHECKER_TB
