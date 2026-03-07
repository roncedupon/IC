`ifndef ONDEC2NSU_CHECKER
`define ONDEC2NSU_CHECKER

//=============================================================================
// ondec2nsu_checker.sv
// ONDEC2NSU 响应检查器 (仅读操作相关)
// 
// 功能：根据 ondec2nsu_cmd 对 NSU 上报 CPU 的 resp 进行检查
// 参考：升维 MP-NSU-spec PN85.docx 第 6.4 节 CPU 交互指令
// 
// 依赖：nsu_cpu_transactions.sv (nsu_cpu_transactions_pkg)
//       - 包含 8 个 plane_pair 参数定义 (PLANE_PAIR_NUM = 8)
//       - 包含所有 NSU-CPU 交互 transaction 定义
//
// 编译顺序：必须先编译 nsu_cpu_transactions.sv，再编译本文件
//
// 注意：本 checker 仅处理读操作相关的 transaction，不包含 write 相关检查
//=============================================================================

package ondec2nsu_checker_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    
    // 导入 nsu_cpu_transactions_pkg 中的所有定义
    // 编译时需确保 nsu_cpu_transactions.sv 已先编译
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
    // 响应类型枚举 (仅读操作相关)
    //=========================================================================
    
    typedef enum logic [3:0] {
        RESP_TYPE_READ          = 4'b0001,  // nsu2cpu_rcmd_transaction
        RESP_TYPE_DEEP_READ     = 4'b0010,  // nsu2cpu_deep_resp_transaction
        RESP_TYPE_MSA           = 4'b0011,  // nsu2cpu_msa_resp_transaction
        RESP_TYPE_MSA_REQ       = 4'b0110,  // cpu2nsu_msa_write_req_transaction
        RESP_TYPE_UNMAP_CMD     = 4'b0111,  // cpu2nsu_unmap_cmd_transaction
        RESP_TYPE_UNKNOWN       = 4'b1111
    } resp_type_e;
    
    //=========================================================================
    // 期望响应配置
    //=========================================================================
    
    typedef struct packed {
        logic valid;
        logic [4:0] expected_ost_id;           // 5bit 支持更多 outstanding
        logic [15:0] expected_instruction_index;
        logic expected_decode_success;         // 1: 译码成功
        logic expected_lba_match;              // 1: LBA 比对成功
        logic expected_err_flag_match;         // 1: error flag 比对成功
        logic expected_crc_success;            // 1: CRC 成功
        logic [7:0] expected_error_plane_pair_sel;  // 8 个 plane_pair
        logic [7:0] expected_plane_pair_en;         // 8 个 plane_pair
        logic [7:0] expected_plane_pair_ondec_flag; // 8 个 plane_pair 译码状态
        logic [7:0] expected_plane_pair_lba_comp;   // 8 个 plane_pair LBA 比对
        logic expected_mode_sel;             // 0: safe read, 1: fast read
    } expected_resp_config_t;
    
    //=========================================================================
    // Plane Pair 状态辅助结构 (8 个 plane_pair)
    //=========================================================================
    
    typedef struct packed {
        logic empty;
        logic [8:0] alter_bit;      // 纠错 bit 数
        logic [15:0] bit_count;     // 0/1bit 数
        logic crc_err;
        logic ondec_success;
        logic lba_match;
        logic err_flag_match;
    } plane_pair_status_t;
    
endpackage : ondec2nsu_checker_pkg


//=============================================================================
// ondec2nsu_checker 类定义
//=============================================================================

class ondec2nsu_checker extends uvm_component;
    
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import ondec2nsu_checker_pkg::*;
    import nsu_cpu_transactions_pkg::*;
    
    `uvm_component_utils(ondec2nsu_checker)
    
    //-------------------------------------------------------------------------
    // 使用 nsu_cpu_transactions_pkg 中的参数 (直接引用，无需前缀)
    //-------------------------------------------------------------------------
    // PLANE_PAIR_NUM = 8
    
    //-------------------------------------------------------------------------
    // TLM Port - FIFO 定义 (仅读操作相关)
    //-------------------------------------------------------------------------
    
    // 6.4.10 输出 read 状态 (4 个队列) (NSU→CPU)
    uvm_tlm_analysis_fifo #(nsu2cpu_rcmd_transaction)          read_resp_fifo;
    
    // 6.4.11 Deep read 上报 resp (NSU→CPU)
    uvm_tlm_analysis_fifo #(nsu2cpu_deep_resp_transaction)     deep_read_resp_fifo;
    
    // 6.4.7 MSA resp que (NSU→CPU)
    uvm_tlm_analysis_fifo #(nsu2cpu_msa_resp_transaction)      msa_resp_fifo;
    
    // 6.4.6 Msa write req que (CPU→NSU) - 用于监控 MSA 请求
    uvm_tlm_analysis_fifo #(cpu2nsu_msa_write_req_transaction) msa_req_fifo;
    
    // 6.4.8 Sw unmap req 指令 (CPU→NSU) - 用于监控 unmap 命令
    uvm_tlm_analysis_fifo #(cpu2nsu_unmap_cmd_transaction)     unmap_cmd_fifo;
    
    //-------------------------------------------------------------------------
    // 配置对象 - 存储期望的响应
    //-------------------------------------------------------------------------
    expected_resp_config_t expected_config;
    
    // 待检查的命令跟踪表 (instruction_index -> expected_config)
    bit [15:0] pending_instr_idx [$];
    expected_resp_config_t pending_config [bit [15:0]];
    
    // ost_id 跟踪表 (ost_id -> expected_config)
    bit [4:0] pending_ost_ids [$];
    expected_resp_config_t pending_ost_config [bit [4:0]];
    
    // 统计计数器
    int unsigned total_resp_count;
    int unsigned pass_count;
    int unsigned fail_count;
    
    // 按响应类型统计
    int unsigned read_resp_count;
    int unsigned deep_read_resp_count;
    int unsigned msa_resp_count;
    int unsigned msa_req_count;
    int unsigned unmap_cmd_count;
    
    // 8 个 plane_pair 的状态统计
    int unsigned plane_pair_decode_success [0:7];
    int unsigned plane_pair_decode_fail [0:7];
    int unsigned plane_pair_crc_err [0:7];
    int unsigned plane_pair_lba_mismatch [0:7];
    
    //-------------------------------------------------------------------------
    // 构造函数
    //-------------------------------------------------------------------------
    function new(string name = "ondec2nsu_checker", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new
    
    //-------------------------------------------------------------------------
    // build_phase - 创建 FIFO
    //-------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        read_resp_fifo        = new("read_resp_fifo", this);
        deep_read_resp_fifo   = new("deep_read_resp_fifo", this);
        msa_resp_fifo         = new("msa_resp_fifo", this);
        msa_req_fifo          = new("msa_req_fifo", this);
        unmap_cmd_fifo        = new("unmap_cmd_fifo", this);
        
        // 初始化计数器
        total_resp_count = 0;
        pass_count = 0;
        fail_count = 0;
        
        read_resp_count = 0;
        deep_read_resp_count = 0;
        msa_resp_count = 0;
        msa_req_count = 0;
        unmap_cmd_count = 0;
        
        // 初始化 plane_pair 统计 (8 个 plane_pair)
        for (int i = 0; i < PLANE_PAIR_NUM; i++) begin
            plane_pair_decode_success[i] = 0;
            plane_pair_decode_fail[i] = 0;
            plane_pair_crc_err[i] = 0;
            plane_pair_lba_mismatch[i] = 0;
        end
        
        `uvm_info(get_type_name(), $sformatf("ondec2nsu_checker built successfully. PLANE_PAIR_NUM=%0d (READ ONLY)", 
            PLANE_PAIR_NUM), UVM_LOW)
    endfunction : build_phase
    
    //-------------------------------------------------------------------------
    // run_phase - 主检查循环
    //-------------------------------------------------------------------------
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        
        fork
            check_read_resp();
            check_deep_read_resp();
            check_msa_resp();
            check_msa_req();
            check_unmap_cmd();
        join_none
        
        `uvm_info(get_type_name(), "ondec2nsu_checker monitoring started (READ ONLY)", UVM_LOW)
    endtask : run_phase
    
    //-------------------------------------------------------------------------
    // 检查函数声明 (仅读操作相关)
    //-------------------------------------------------------------------------
    virtual task check_read_resp();
    endtask : check_read_resp
    
    virtual task check_deep_read_resp();
    endtask : check_deep_read_resp
    
    virtual task check_msa_resp();
    endtask : check_msa_resp
    
    virtual task check_msa_req();
    endtask : check_msa_req
    
    virtual task check_unmap_cmd();
    endtask : check_unmap_cmd
    
    //-------------------------------------------------------------------------
    // 外部 API - 注册期望的响应配置 (通过 instruction_index)
    //-------------------------------------------------------------------------
    function void register_expected_config(expected_resp_config_t cfg);
        if (cfg.valid) begin
            pending_instr_idx.push_back(cfg.expected_instruction_index);
            pending_config[cfg.expected_instruction_index] = cfg;
            
            `uvm_info(get_type_name(), $sformatf("Registered expected config: instr_idx=%0h, ost_id=%0d, decode_success=%0b, pp_en=%08b", 
                cfg.expected_instruction_index, cfg.expected_ost_id, cfg.expected_decode_success, cfg.expected_plane_pair_en), UVM_MEDIUM)
        end else begin
            `uvm_warning(get_type_name(), "register_expected_config: cfg.valid is not set")
        end
    endfunction : register_expected_config
    
    //-------------------------------------------------------------------------
    // 外部 API - 注册期望的响应配置 (通过 ost_id)
    //-------------------------------------------------------------------------
    function void register_expected_ost_config(expected_resp_config_t cfg);
        if (cfg.valid) begin
            pending_ost_ids.push_back(cfg.expected_ost_id);
            pending_ost_config[cfg.expected_ost_id] = cfg;
            
            `uvm_info(get_type_name(), $sformatf("Registered expected OST config: ost_id=%0d, instr_idx=%0h", 
                cfg.expected_ost_id, cfg.expected_instruction_index), UVM_MEDIUM)
        end
    endfunction : register_expected_ost_config
    
    //-------------------------------------------------------------------------
    // 外部 API - 清除所有待处理配置
    //-------------------------------------------------------------------------
    function void clear_pending_configs();
        pending_instr_idx.delete();
        pending_config.delete();
        pending_ost_ids.delete();
        pending_ost_config.delete();
        `uvm_info(get_type_name(), "Cleared all pending configs", UVM_MEDIUM)
    endfunction : clear_pending_configs
    
    //-------------------------------------------------------------------------
    // 外部 API - 获取检查统计
    //-------------------------------------------------------------------------
    function void get_stats(output int unsigned total, output int unsigned pass, output int unsigned fail);
        total = total_resp_count;
        pass = pass_count;
        fail = fail_count;
    endfunction : get_stats
    
    //-------------------------------------------------------------------------
    // 外部 API - 获取详细统计
    //-------------------------------------------------------------------------
    function void get_detailed_stats(
        output int unsigned read,
        output int unsigned deep_read,
        output int unsigned msa,
        output int unsigned msa_req,
        output int unsigned unmap_cmd
    );
        read = read_resp_count;
        deep_read = deep_read_resp_count;
        msa = msa_resp_count;
        msa_req = msa_req_count;
        unmap_cmd = unmap_cmd_count;
    endfunction : get_detailed_stats
    
    //-------------------------------------------------------------------------
    // 外部 API - 获取 Plane Pair 统计 (8 个 plane_pair)
    //-------------------------------------------------------------------------
    function void get_plane_pair_stats(
        output int unsigned decode_success [0:7],
        output int unsigned decode_fail [0:7],
        output int unsigned crc_err [0:7],
        output int unsigned lba_mismatch [0:7]
    );
        for (int i = 0; i < PLANE_PAIR_NUM; i++) begin
            decode_success[i] = plane_pair_decode_success[i];
            decode_fail[i] = plane_pair_decode_fail[i];
            crc_err[i] = plane_pair_crc_err[i];
            lba_mismatch[i] = plane_pair_lba_mismatch[i];
        end
    endfunction : get_plane_pair_stats
    
    //-------------------------------------------------------------------------
    // report_phase - 报告检查结果
    //-------------------------------------------------------------------------
    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        
        `uvm_info(get_type_name(), "========================================", UVM_LOW)
        `uvm_info(get_type_name(), "ONDEC2NSU CHECKER SUMMARY (READ ONLY)", UVM_LOW)
        `uvm_info(get_type_name(), "========================================", UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("PLANE_PAIR_NUM: %0d", PLANE_PAIR_NUM), UVM_LOW)
        `uvm_info(get_type_name(), "----------------------------------------", UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("Total Responses: %0d", total_resp_count), UVM_LOW)
        `uvm_info(get_type_name(), "  NSU→CPU Responses:", UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("    READ_RESP:      %0d", read_resp_count), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("    DEEP_READ_RESP: %0d", deep_read_resp_count), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("    MSA_RESP:       %0d", msa_resp_count), UVM_LOW)
        `uvm_info(get_type_name(), "  CPU→NSU Commands (mon):", UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("    MSA_REQ:        %0d", msa_req_count), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("    UNMAP_CMD:      %0d", unmap_cmd_count), UVM_LOW)
        `uvm_info(get_type_name(), "----------------------------------------", UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("Pass: %0d", pass_count), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("Fail: %0d", fail_count), UVM_LOW)
        `uvm_info(get_type_name(), "========================================", UVM_LOW)
        
        // Plane Pair 统计
        `uvm_info(get_type_name(), "PLANE_PAIR STATISTICS (8 plane_pairs)", UVM_LOW)
        `uvm_info(get_type_name(), "----------------------------------------", UVM_LOW)
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
    
endclass : ondec2nsu_checker


//=============================================================================
// ondec2nsu_checker 类外实现
//=============================================================================

//-----------------------------------------------------------------------------
// check_read_resp - 6.4.10 输出 read 状态 (4 个队列)
//-----------------------------------------------------------------------------
task ondec2nsu_checker::check_read_resp();
    nsu2cpu_rcmd_transaction resp;
    
    forever begin
        read_resp_fifo.get(resp);
        total_resp_count++;
        read_resp_count++;
        
        `uvm_info(get_type_name(), $sformatf("Received READ_RESP: instr_idx=%0h, nand_cmd=%0h, error_pp_sel=%08b", 
            resp.instruction_index, resp.nand_cmd_index, resp.error_plane_pair_sel), UVM_MEDIUM)
        
        // 更新 plane_pair 统计 (8 个 plane_pair)
        for (int pp = 0; pp < PLANE_PAIR_NUM; pp++) begin
            if (resp.error_plane_pair_sel[pp]) begin
                plane_pair_decode_fail[pp]++;
            end else begin
                plane_pair_decode_success[pp]++;
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
                
                // 检查 decode 状态 (8 个 plane_pair)
                if (cfg.expected_decode_success) begin
                    // 期望所有 plane_pair 译码成功
                    if (resp.error_plane_pair_sel != 8'b0) begin
                        status = CHECK_FAIL_DECODE;
                        fail_reason = $sformatf("decode failed: pp_sel=%08b", resp.error_plane_pair_sel);
                    end
                end
                
                // 报告结果
                if (status == CHECK_PASS) begin
                    `uvm_info(get_type_name(), $sformatf("READ_RESP check PASS: instr_idx=%0h", resp.instruction_index), UVM_LOW)
                    pass_count++;
                end else begin
                    `uvm_error(get_type_name(), $sformatf("READ_RESP check FAIL: instr_idx=%0h, status=%0d, reason=%s", 
                        resp.instruction_index, status, fail_reason))
                    fail_count++;
                end
                
                // 清除已完成的配置
                pending_config.delete(resp.instruction_index);
            end
        end else begin
            `uvm_warning(get_type_name(), $sformatf("READ_RESP: instr_idx=%0h has no matching expected config", resp.instruction_index))
        end
    end
endtask : check_read_resp

//-----------------------------------------------------------------------------
// check_deep_read_resp - 6.4.11 Deep read 上报 resp
//-----------------------------------------------------------------------------
task ondec2nsu_checker::check_deep_read_resp();
    nsu2cpu_deep_resp_transaction resp;
    
    forever begin
        deep_read_resp_fifo.get(resp);
        total_resp_count++;
        deep_read_resp_count++;
        
        `uvm_info(get_type_name(), $sformatf("Received DEEP_READ_RESP: instr_idx=%0h, pp_ondec_flag=%08b, mode=%0b, deep_sel=%0b", 
            resp.instruction_index, resp.plane_pair_ondec_flag, resp.mode_sel, resp.deep_read_sel), UVM_MEDIUM)
        
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
                if (cfg.expected_decode_success) begin
                    if (resp.plane_pair_ondec_flag != 8'b0) begin
                        status = CHECK_FAIL_DECODE;
                        fail_reason = $sformatf("ondec failed: pp_flag=%08b", resp.plane_pair_ondec_flag);
                    end
                end
                
                // 检查 LBA 比对 (plane_pair_lba_comp: 0=成功，1=失败)
                if (cfg.expected_lba_match) begin
                    if (resp.plane_pair_lba_comp != 8'b0) begin
                        status = CHECK_FAIL_LBA;
                        fail_reason = $sformatf("LBA mismatch: pp_lba_comp=%08b", resp.plane_pair_lba_comp);
                    end
                end
                
                // 检查 CRC 状态 (plane_crc_err: 每位 0=失败)
                if (cfg.expected_crc_success) begin
                    // 注意：plane_crc_err[i]=0 表示该 plane pair CRC 失败
                    if (resp.plane_crc_err != 8'hFF) begin
                        status = CHECK_FAIL_CRC;
                        fail_reason = $sformatf("CRC error: pp_crc_err=%08b (0=fail)", resp.plane_crc_err);
                    end
                end
                
                // 检查 mode_sel
                if (cfg.expected_mode_sel != resp.mode_sel) begin
                    `uvm_warning(get_type_name(), $sformatf("mode_sel mismatch: expected=%0b, got=%0b", 
                        cfg.expected_mode_sel, resp.mode_sel))
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

//-----------------------------------------------------------------------------
// check_msa_resp - 6.4.7 MSA resp que
//-----------------------------------------------------------------------------
task ondec2nsu_checker::check_msa_resp();
    nsu2cpu_msa_resp_transaction resp;
    
    forever begin
        msa_resp_fifo.get(resp);
        total_resp_count++;
        msa_resp_count++;
        
        `uvm_info(get_type_name(), $sformatf("Received MSA_RESP: instr_idx=%0h", resp.instruction_index), UVM_MEDIUM)
        
        // 查找匹配的期望配置
        if (pending_config.exists(resp.instruction_index)) begin
            auto cfg = pending_config[resp.instruction_index];
            
            if (cfg.valid) begin
                if (cfg.expected_instruction_index == resp.instruction_index) begin
                    `uvm_info(get_type_name(), $sformatf("MSA_RESP check PASS: instr_idx=%0h", resp.instruction_index), UVM_LOW)
                    pass_count++;
                end else begin
                    `uvm_error(get_type_name(), $sformatf("MSA_RESP check FAIL: instr_idx=%0h, expected=%0h", 
                        resp.instruction_index, cfg.expected_instruction_index))
                    fail_count++;
                end
                
                pending_config.delete(resp.instruction_index);
            end
        end else begin
            `uvm_warning(get_type_name(), $sformatf("MSA_RESP: instr_idx=%0h has no matching expected config", resp.instruction_index))
        end
    end
endtask : check_msa_resp

//-----------------------------------------------------------------------------
// check_msa_req - 6.4.6 Msa write req que (CPU→NSU)
//-----------------------------------------------------------------------------
task ondec2nsu_checker::check_msa_req();
    cpu2nsu_msa_write_req_transaction resp;
    
    forever begin
        msa_req_fifo.get(resp);
        msa_req_count++;
        
        `uvm_info(get_type_name(), $sformatf("Received MSA_REQ: instr_idx=%0h, ost_id=%0d, nsu_addr=%0h, src_mem_addr=%0h", 
            resp.instruction_index, resp.ost_id, resp.nsu_addr, resp.src_mem_addr), UVM_MEDIUM)
        
        // MSA req 是 CPU→NSU 的命令，通常用于触发期望的 MSA resp
        // 自动注册期望的 MSA resp 配置
        expected_resp_config_t cfg;
        cfg.valid = 1'b1;
        cfg.expected_instruction_index = resp.instruction_index;
        cfg.expected_ost_id = resp.ost_id;
        register_expected_config(cfg);
        
        `uvm_info(get_type_name(), $sformatf("MSA_REQ: Registered expected MSA_RESP for instr_idx=%0h", 
            resp.instruction_index), UVM_MEDIUM)
    end
endtask : check_msa_req

//-----------------------------------------------------------------------------
// check_unmap_cmd - 6.4.8 Sw unmap req 指令 (CPU→NSU)
//-----------------------------------------------------------------------------
task ondec2nsu_checker::check_unmap_cmd();
    cpu2nsu_unmap_cmd_transaction resp;
    
    forever begin
        unmap_cmd_fifo.get(resp);
        unmap_cmd_count++;
        
        `uvm_info(get_type_name(), $sformatf("Received UNMAP_CMD: ost_id=%0d, nsu_addr=%0h, rd_length=%0d", 
            resp.ost_id, resp.nsu_addr, resp.rd_length), UVM_MEDIUM)
        
        // unmap_cmd 是 CPU→NSU 的命令，不需要 resp
        // 用于监控和统计
    end
endtask : check_unmap_cmd


`endif // ONDEC2NSU_CHECKER
