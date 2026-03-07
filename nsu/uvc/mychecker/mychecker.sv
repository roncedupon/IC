`ifndef ONDEC_RESP_CHECKER
`define ONDEC_RESP_CHECKER
`define CLASS_NAME_DEFINE ondec2nsu_checker

//=============================================================================
// ondec2nsu_checker.sv
// ONDEC2NSU 响应检查器 - 根据 ondec_cmd 检查 resp 是否正确
// 
// 第一步：获取 ondec_cmd，检查 resp 是否正确
// 从最简单开始：wbf 和 crc 全部译码成功的情况
//=============================================================================

package ondec2nsu_checker_pkg;
    
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import nsu_cpu_transactions_pkg::*;

    //=========================================================================
    // 检查状态枚举
    //=========================================================================
    typedef enum logic [2:0] {
        CHECK_PASS           = 3'b000,
        CHECK_FAIL_DATA      = 3'b001,
        CHECK_FAIL_OST_ID    = 3'b010,
        CHECK_FAIL_INSTR_IDX = 3'b011,
        CHECK_FAIL_DECODE    = 3'b100,
        CHECK_FAIL_LBA       = 3'b101,
        CHECK_FAIL_CRC       = 3'b110,
        CHECK_INVALID_RESP   = 3'b111
    } check_status_e;
    
    //=========================================================================
    // 期望响应配置
    //=========================================================================
    typedef struct packed {
        logic valid;
        logic [15:0] expected_instruction_index;
        logic expected_decode_success;         // 1: 译码成功
        logic expected_lba_match;              // 1: LBA 比对成功
        logic expected_crc_success;            // 1: CRC 成功
        logic [7:0] expected_plane_pair_en;    // 8 个 plane_pair 使能
    } expected_resp_config_t;
    
endpackage : ondec2nsu_checker_pkg


//=============================================================================
// ondec2nsu_checker 类定义
//=============================================================================

class `CLASS_NAME_DEFINE extends uvm_component;

    `uvm_component_utils(`CLASS_NAME_DEFINE)

    import ondec2nsu_checker_pkg::*;
    import nsu_cpu_transactions_pkg::*;

    //-------------------------------------------------------------------------
    // FIFO 定义 (仅读操作相关)
    //-------------------------------------------------------------------------
    // ondec_cmd FIFO - 用于获取 ondec 命令信息
    uvm_tlm_analysis_fifo #(nsu2cpu_deep_resp_transaction) ondec_cmd_fifo;
    
    // resp FIFO - 用于接收响应
    uvm_tlm_analysis_fifo #(nsu2cpu_deep_resp_transaction) deep_read_resp_fifo;
    
    //-------------------------------------------------------------------------
    // 待检查的配置跟踪表
    //-------------------------------------------------------------------------
    bit [15:0] pending_instr_idx [$];
    expected_resp_config_t pending_config [bit [15:0]];
    
    //-------------------------------------------------------------------------
    // 统计计数器
    //-------------------------------------------------------------------------
    int unsigned total_cmd_count;
    int unsigned total_resp_count;
    int unsigned pass_count;
    int unsigned fail_count;
    
    // 8 个 plane_pair 的状态统计
    int unsigned plane_pair_decode_success [0:7];
    int unsigned plane_pair_decode_fail [0:7];
    int unsigned plane_pair_crc_err [0:7];
    int unsigned plane_pair_lba_mismatch [0:7];

    //=========================================================
    // Task 声明 (extern - class 内声明，class 外实现)
    //=========================================================
    extern virtual task check_ondec_cmd();      // 第一步：获取 ondec_cmd
    extern virtual task check_deep_read_resp(); // 第二步：检查 resp

    //-------------------------------------------------------------------------
    // 构造函数
    //-------------------------------------------------------------------------
    function new(string name, uvm_component parent);
        super.new(name, parent);
        
        // 创建 FIFO
        ondec_cmd_fifo      = new("ondec_cmd_fifo", this);
        deep_read_resp_fifo = new("deep_read_resp_fifo", this);
        
        // 初始化计数器
        total_cmd_count = 0;
        total_resp_count = 0;
        pass_count = 0;
        fail_count = 0;
        
        // 初始化 plane_pair 统计 (8 个 plane_pair)
        for (int i = 0; i < PLANE_PAIR_NUM; i++) begin
            plane_pair_decode_success[i] = 0;
            plane_pair_decode_fail[i] = 0;
            plane_pair_crc_err[i] = 0;
            plane_pair_lba_mismatch[i] = 0;
        end
        
        `uvm_info(get_type_name(), $sformatf("ondec2nsu_checker created. PLANE_PAIR_NUM=%0d", PLANE_PAIR_NUM), UVM_LOW)
    endfunction : new
    
    //-------------------------------------------------------------------------
    // build_phase
    //-------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "build_phase completed", UVM_MEDIUM)
    endfunction : build_phase
    
    //-------------------------------------------------------------------------
    // run_phase - 启动检查任务
    //-------------------------------------------------------------------------
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        
        `uvm_info(get_type_name(), "run_phase started - monitoring ondec_cmd and resp", UVM_LOW)
        
        fork
            check_ondec_cmd();      // 第一步：获取 ondec_cmd，注册期望配置
            check_deep_read_resp(); // 第二步：检查 resp 是否正确
        join_none
    endtask : run_phase
    
    //-------------------------------------------------------------------------
    // report_phase
    //-------------------------------------------------------------------------
    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        
        `uvm_info(get_type_name(), "========================================", UVM_LOW)
        `uvm_info(get_type_name(), "ONDEC2NSU CHECKER SUMMARY", UVM_LOW)
        `uvm_info(get_type_name(), "========================================", UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("Total ONDEC_CMD:  %0d", total_cmd_count), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("Total RESP:       %0d", total_resp_count), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("Pass:             %0d", pass_count), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("Fail:             %0d", fail_count), UVM_LOW)
        `uvm_info(get_type_name(), "========================================", UVM_LOW)
        
        // Plane Pair 统计
        `uvm_info(get_type_name(), "PLANE_PAIR STATISTICS (8 plane_pairs)", UVM_LOW)
        for (int pp = 0; pp < PLANE_PAIR_NUM; pp++) begin
            `uvm_info(get_type_name(), $sformatf("  PP[%0d]: decode_success=%0d, decode_fail=%0d, crc_err=%0d, lba_mismatch=%0d",
                pp, plane_pair_decode_success[pp], plane_pair_decode_fail[pp], 
                plane_pair_crc_err[pp], plane_pair_lba_mismatch[pp]), UVM_LOW)
        end
        `uvm_info(get_type_name(), "========================================", UVM_LOW)
        
        if (fail_count > 0) begin
            `uvm_error(get_type_name(), $sformatf("CHECKER FAILED: %0d errors detected", fail_count))
        end else if (total_resp_count > 0) begin
            `uvm_info(get_type_name(), "CHECKER PASSED: All responses validated successfully", UVM_LOW)
        end
    endfunction : report_phase
    
endclass : `CLASS_NAME_DEFINE


//=============================================================================
// Task 实现 (class 外实现)
//=============================================================================

//-----------------------------------------------------------------------------
// check_ondec_cmd - 第一步：获取 ondec_cmd，提取期望信息
// 
// 从 ondec_cmd 中提取：
// - instruction_index: 用于匹配 resp
// - plane_pair_en: 哪些 plane_pair 被使能
// - 期望译码成功 (wbf 和 crc 全部成功)
//-----------------------------------------------------------------------------
task `CLASS_NAME_DEFINE::check_ondec_cmd();
    nsu2cpu_deep_resp_transaction cmd;
    expected_resp_config_t cfg;
    
    forever begin
        ondec_cmd_fifo.get(cmd);
        total_cmd_count++;
        
        `uvm_info(get_type_name(), $sformatf("Received ONDEC_CMD: instr_idx=%0h, pp_en=%08b, mode=%0b", 
            cmd.instruction_index, cmd.plane_pair_en, cmd.mode_sel), UVM_MEDIUM)
        
        // 从 ondec_cmd 中提取期望信息
        // 假设：ondec_cmd 中的 plane_pair_en 表示哪些 plane_pair 被使能
        // 期望：所有使能的 plane_pair 都应该译码成功 (wbf 和 crc 成功)
        
        cfg.valid = 1'b1;
        cfg.expected_instruction_index = cmd.instruction_index;
        cfg.expected_decode_success = 1'b1;  // 期望译码成功
        cfg.expected_crc_success = 1'b1;     // 期望 CRC 成功
        cfg.expected_lba_match = 1'b1;       // 期望 LBA 匹配
        cfg.expected_plane_pair_en = cmd.plane_pair_en;
        
        // 注册期望配置
        pending_instr_idx.push_back(cfg.expected_instruction_index);
        pending_config[cfg.expected_instruction_index] = cfg;
        
        `uvm_info(get_type_name(), $sformatf("ONDEC_CMD: Registered expected config for instr_idx=%0h, pp_en=%08b", 
            cfg.expected_instruction_index, cfg.expected_plane_pair_en), UVM_MEDIUM)
    end
endtask : check_ondec_cmd

//-----------------------------------------------------------------------------
// check_deep_read_resp - 第二步：检查 resp 是否正确
// 
// 检查内容：
// 1. instruction_index 匹配
// 2. 译码状态 (plane_pair_ondec_flag) - 期望全部成功
// 3. CRC 状态 (plane_crc_err) - 期望全部成功
// 4. LBA 比对 (plane_pair_lba_comp) - 期望全部匹配
//-----------------------------------------------------------------------------
task `CLASS_NAME_DEFINE::check_deep_read_resp();
    nsu2cpu_deep_resp_transaction resp;
    
    forever begin
        deep_read_resp_fifo.get(resp);
        total_resp_count++;
        
        `uvm_info(get_type_name(), $sformatf("Received DEEP_READ_RESP: instr_idx=%0h, pp_ondec_flag=%08b, pp_crc_err=%08b, pp_lba_comp=%08b", 
            resp.instruction_index, resp.plane_pair_ondec_flag, resp.plane_crc_err, resp.plane_pair_lba_comp), UVM_LOW)
        
        // 更新 plane_pair 统计 (8 个 plane_pair)
        for (int pp = 0; pp < PLANE_PAIR_NUM; pp++) begin
            // ondec_flag: 0=成功，1=失败
            if (!resp.plane_pair_ondec_flag[pp]) begin
                plane_pair_decode_success[pp]++;
            end else begin
                plane_pair_decode_fail[pp]++;
            end
            
            // crc_err: 0=失败
            if (!resp.plane_crc_err[pp]) begin
                plane_pair_crc_err[pp]++;
            end
            
            // lba_comp: 0=成功，1=失败
            if (resp.plane_pair_lba_comp[pp]) begin
                plane_pair_lba_mismatch[pp]++;
            end
        end
        
        // 查找匹配的期望配置
        if (pending_config.exists(resp.instruction_index)) begin
            auto cfg = pending_config[resp.instruction_index];
            
            if (cfg.valid) begin
                check_status_e status = CHECK_PASS;
                string fail_reason = "";
                
                // 检查 instruction_index 匹配
                if (cfg.expected_instruction_index != resp.instruction_index) begin
                    status = CHECK_FAIL_INSTR_IDX;
                    fail_reason = "instruction_index mismatch";
                end
                
                // 检查 decode 状态 (plane_pair_ondec_flag: 0=成功，1=失败)
                // 期望：所有使能的 plane_pair 都译码成功
                if (cfg.expected_decode_success) begin
                    // 只检查使能的 plane_pair
                    for (int pp = 0; pp < PLANE_PAIR_NUM; pp++) begin
                        if (cfg.expected_plane_pair_en[pp] && resp.plane_pair_ondec_flag[pp]) begin
                            status = CHECK_FAIL_DECODE;
                            fail_reason = $sformatf("PP[%0d] decode failed", pp);
                            break;
                        end
                    end
                end
                
                // 检查 CRC 状态 (plane_crc_err: 0=失败)
                // 期望：所有使能的 plane_pair CRC 都成功
                if (cfg.expected_crc_success && status == CHECK_PASS) begin
                    for (int pp = 0; pp < PLANE_PAIR_NUM; pp++) begin
                        if (cfg.expected_plane_pair_en[pp] && !resp.plane_crc_err[pp]) begin
                            status = CHECK_FAIL_CRC;
                            fail_reason = $sformatf("PP[%0d] CRC failed", pp);
                            break;
                        end
                    end
                end
                
                // 检查 LBA 比对 (plane_pair_lba_comp: 0=成功，1=失败)
                if (cfg.expected_lba_match && status == CHECK_PASS) begin
                    for (int pp = 0; pp < PLANE_PAIR_NUM; pp++) begin
                        if (cfg.expected_plane_pair_en[pp] && resp.plane_pair_lba_comp[pp]) begin
                            status = CHECK_FAIL_LBA;
                            fail_reason = $sformatf("PP[%0d] LBA mismatch", pp);
                            break;
                        end
                    end
                end
                
                // 报告结果
                if (status == CHECK_PASS) begin
                    `uvm_info(get_type_name(), $sformatf("DEEP_READ_RESP check PASS: instr_idx=%0h", resp.instruction_index), UVM_LOW)
                    pass_count++;
                end else begin
                    `uvm_error(get_type_name(), $sformatf("DEEP_READ_RESP check FAIL: instr_idx=%0h, status=%0d, reason=%s", 
                        resp.instruction_index, status, fail_reason))
                    fail_count++;
                end
                
                // 清除已完成的配置
                pending_config.delete(resp.instruction_index);
            end
        end else begin
            `uvm_warning(get_type_name(), $sformatf("DEEP_READ_RESP: instr_idx=%0h has no matching expected config", resp.instruction_index))
        end
    end
endtask : check_deep_read_resp


`endif // ONDEC_RESP_CHECKER
