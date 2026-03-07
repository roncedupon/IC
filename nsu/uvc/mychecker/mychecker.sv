`ifndef MYCHECKER_SV
`define MYCHECKER_SV

//=============================================================================
// mychecker.sv - ONDEC2NSU Checker (直接判断版本)
//=============================================================================
// 三步检查流程:
// 1. 获取 ondec2nsu_group_transaction (8 个 plane_pair)
// 2. 根据位域直接判断：译码失败→检查 deep_resp 或 offwbf
// 3. 从对应队列中找到匹配的 transaction 进行比较
//=============================================================================

package ondec2nsu_checker_pkg;
    
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import nsu_cpu_transactions_pkg::*;
    import nsu2offwbf_transaction_pkg::*;

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
    // Plane Pair 检查配置 (每个 plane_pair 独立)
    //=========================================================================
    typedef struct packed {
        logic        valid;
        logic [15:0] instruction_index;
        logic        plane_sel;              // plane 选择
        logic        dec_suc;                // 译码成功 (1=成功)
        logic        crc_pass;               // CRC 通过 (1=通过)
        logic        data_out_en;            // 数据输出使能
        logic        offline_wbf_work_en;    // offwbf 使能
        logic        deep_read_sel;          // deep read 选择
        logic        read_mode;              // 读模式
        logic [4:0]  nsu_ost_id;             // OST ID
        logic [31:0] dest_memory_addr;       // 目标内存地址
        logic [31:0] dec_fail_dest_addr;     // 译码失败目标地址
    } plane_pair_check_config_t;

endpackage

`define CLASS_NAME_DEFINE ondec2nsu_checker

//=============================================================================
// ondec2nsu_checker 类定义
//=============================================================================

class `CLASS_NAME_DEFINE extends uvm_component;

    `uvm_component_utils(`CLASS_NAME_DEFINE)

    import ondec2nsu_checker_pkg::*;
    import nsu_cpu_transactions_pkg::*;
    import nsu2offwbf_transaction_pkg::*;

    //-------------------------------------------------------------------------
    // FIFO 定义
    //-------------------------------------------------------------------------
    // ondec_cmd FIFO - 输入：ondec2nsu_group_transaction (8 个 plane_pair)
    uvm_tlm_analysis_fifo #(ondec2nsu_group_transaction) ondec_cmd_fifo;
    
    // deep_read_resp FIFO - 输入：NSU 上报给 CPU 的 deep read 响应
    uvm_tlm_analysis_fifo #(nsu2cpu_deep_resp_transaction) deep_read_resp_fifo;
    
    // offwbf_cmd FIFO - 输入：NSU 下发给 OFFWBF 的指令
    uvm_tlm_analysis_fifo #(nsu2offwbf_transaction) offwbf_cmd_fifo;
    
    //-------------------------------------------------------------------------
    // 待检查的配置跟踪表 (按 instruction_index 索引)
    //-------------------------------------------------------------------------
    bit [15:0] pending_instr_idx [$];
    plane_pair_check_config_t pending_config [bit [15:0]][7:0];  // [instr_idx][plane_pair_id]
    
    //-------------------------------------------------------------------------
    // 统计计数器
    //-------------------------------------------------------------------------
    int unsigned total_cmd_count = 0;
    int unsigned total_resp_count = 0;
    int unsigned total_offwbf_count = 0;
    int unsigned pass_count = 0;
    int unsigned fail_count = 0;
    
    // 每个 plane_pair 的统计
    int unsigned plane_pair_decode_success [7:0];
    int unsigned plane_pair_decode_fail [7:0];
    int unsigned plane_pair_crc_err [7:0];
    int unsigned plane_pair_lba_mismatch [7:0];
    int unsigned offwbf_success_count = 0;
    int unsigned offwbf_fail_count = 0;
    
    //-------------------------------------------------------------------------
    // Task 声明 (class 内声明)
    //-------------------------------------------------------------------------
    extern virtual task check_ondec_cmd();      // 第一步：获取 ondec_cmd，直接判断
    extern virtual task check_deep_read_resp(); // 第二步：检查 deep read resp
    extern virtual task check_offwbf_cmd();     // 第三步：检查 offwbf 指令
    
    //-------------------------------------------------------------------------
    // 构造函数
    //-------------------------------------------------------------------------
    function new(string name = "ondec2nsu_checker", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new
    
    //-------------------------------------------------------------------------
    // build_phase
    //-------------------------------------------------------------------------
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        ondec_cmd_fifo = new("ondec_cmd_fifo", this);
        deep_read_resp_fifo = new("deep_read_resp_fifo", this);
        offwbf_cmd_fifo = new("offwbf_cmd_fifo", this);
    endfunction : build_phase
    
    //-------------------------------------------------------------------------
    // run_phase
    //-------------------------------------------------------------------------
    virtual task run_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "ondec2nsu_checker started", UVM_MEDIUM)
        
        fork
            check_ondec_cmd();      // 第一步：获取 ondec_cmd，直接判断
            check_deep_read_resp(); // 第二步：检查 deep read resp
            check_offwbf_cmd();     // 第三步：检查 offwbf 指令
        join
    endtask : run_phase
    
    //-------------------------------------------------------------------------
    // report_phase
    //-------------------------------------------------------------------------
    virtual function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("Total ONDEC_CMD: %0d, Total RESP: %0d, Total OFFWBF: %0d", 
            total_cmd_count, total_resp_count, total_offwbf_count), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("Pass: %0d, Fail: %0d", pass_count, fail_count), UVM_LOW)
    endfunction : report_phase
    
endclass : ondec2nsu_checker

//=============================================================================
// Task 实现 (class 外实现)
//=============================================================================

//-----------------------------------------------------------------------------
// check_ondec_cmd - 获取 ondec2nsu_group_transaction，直接判断并注册期望
// 
// 判断逻辑:
// - dec_suc=1: 译码成功，不需要上报 deep_resp 或 offwbf
// - dec_suc=0 && crc_pass=0: 译码失败且 CRC 失败，不需要上报
// - dec_suc=0 && crc_pass=1 && data_out_en=0: 译码失败但 CRC 成功，数据不输出 → 上报 deep_resp
// - dec_suc=0 && crc_pass=1 && data_out_en=1: 译码失败但 CRC 成功，数据输出 → 调用 offwbf
//-----------------------------------------------------------------------------
task `CLASS_NAME_DEFINE::check_ondec_cmd();
    ondec2nsu_group_transaction group_tr;
    plane_pair_check_config_t pp_cfg;
    
    forever begin
        // =========================================================
        // 第一步：获取 ondec2nsu_group_transaction
        // =========================================================
        ondec_cmd_fifo.get(group_tr);
        total_cmd_count++;
        
        `uvm_info(get_type_name(), $sformatf("Received ONDEC_GROUP: instr_idx=%0h, ost_id=%0h", 
            group_tr.tr[0].instruction_index, group_tr.tr[0].nsu_ost_id), UVM_MEDIUM)
        
        // =========================================================
        // 第二步：遍历 8 个 plane_pair，直接根据位域判断
        // =========================================================
        for (int pp = 0; pp < 8; pp++) begin
            pp_cfg.valid = 1'b1;
            pp_cfg.instruction_index = group_tr.tr[pp].instruction_index;
            pp_cfg.plane_sel = group_tr.tr[pp].plane_sel;
            pp_cfg.dec_suc = group_tr.tr[pp].dec_suc;
            pp_cfg.crc_pass = group_tr.tr[pp].crc_pass;
            pp_cfg.data_out_en = group_tr.tr[pp].data_out_en;
            pp_cfg.offline_wbf_work_en = group_tr.tr[pp].offline_wbf_work_en;
            pp_cfg.deep_read_sel = group_tr.tr[pp].deep_read_sel;
            pp_cfg.read_mode = group_tr.tr[pp].read_mode;
            pp_cfg.nsu_ost_id = group_tr.tr[pp].nsu_ost_id;
            pp_cfg.dest_memory_addr = group_tr.tr[pp].dest_memory_addr;
            pp_cfg.dec_fail_dest_addr = group_tr.tr[pp].dec_fail_dest_addr;
            
            `uvm_info(get_type_name(), $sformatf("  PP[%0d]: plane_sel=%0b, dec_suc=%0b, crc_pass=%0b, data_out_en=%0b, offwbf_en=%0b", 
                pp, pp_cfg.plane_sel, pp_cfg.dec_suc, pp_cfg.crc_pass, pp_cfg.data_out_en, pp_cfg.offline_wbf_work_en), UVM_HIGH)
            
            // 只处理选择的 plane_pair
            if (!pp_cfg.plane_sel) begin
                `uvm_info(get_type_name(), $sformatf("  PP[%0d]: Not selected, skip", pp), UVM_HIGH)
                continue;
            end
            
            // 判断逻辑
            if (pp_cfg.dec_suc) begin
                // 译码成功：不需要上报 deep_resp 或 offwbf
                `uvm_info(get_type_name(), $sformatf("  PP[%0d]: Decode success, no action needed", pp), UVM_HIGH)
            end else if (!pp_cfg.crc_pass) begin
                // 译码失败且 CRC 失败：不需要上报
                `uvm_info(get_type_name(), $sformatf("  PP[%0d]: Decode fail + CRC fail, no action needed", pp), UVM_HIGH)
            end else if (!pp_cfg.data_out_en) begin
                // 译码失败但 CRC 成功，数据不输出 → 需要上报 deep_resp
                `uvm_info(get_type_name(), $sformatf("  PP[%0d]: Decode fail + CRC success + no data output → Expect DEEP_READ_RESP", pp), UVM_LOW)
            end else begin
                // 译码失败但 CRC 成功，数据输出 → 需要调用 offwbf
                `uvm_info(get_type_name(), $sformatf("  PP[%0d]: Decode fail + CRC success + data output → Expect OFFWBF_CMD", pp), UVM_LOW)
            end
            
            // 注册期望配置
            pending_config[pp_cfg.instruction_index][pp] = pp_cfg;
        end
        
        // 记录 pending instruction index
        if (!pending_instr_idx.exists(group_tr.tr[0].instruction_index)) begin
            pending_instr_idx.push_back(group_tr.tr[0].instruction_index);
        end
        
        `uvm_info(get_type_name(), $sformatf("Registered config for instr_idx=%0h (waiting for resp/offwbf)", 
            group_tr.tr[0].instruction_index), UVM_MEDIUM)
    end
endtask : check_ondec_cmd

//-----------------------------------------------------------------------------
// check_deep_read_resp - 检查 NSU 上报给 CPU 的 deep read 响应
// 
// 检查内容:
// 1. instruction_index 匹配
// 2. plane_pair_ondec_flag (与 dec_suc 比较)
// 3. plane_crc_err (与 crc_pass 比较)
// 4. plane_pair_lba_comp (LBA 比对)
// 5. deep_read_sel 和 mode_sel
//-----------------------------------------------------------------------------
task `CLASS_NAME_DEFINE::check_deep_read_resp();
    nsu2cpu_deep_resp_transaction resp;
    
    forever begin
        deep_read_resp_fifo.get(resp);
        total_resp_count++;
        
        `uvm_info(get_type_name(), $sformatf("Received DEEP_READ_RESP: instr_idx=%0h, ost_id=%0h, pp_ondec_flag=%08b, pp_crc_err=%08b", 
            resp.instruction_index, resp.nsu_ost_id, resp.plane_pair_ondec_flag, resp.plane_crc_err), UVM_LOW)
        
        // 更新 plane_pair 统计
        for (int pp = 0; pp < 8; pp++) begin
            if (!resp.plane_pair_ondec_flag[pp]) begin
                plane_pair_decode_success[pp]++;
            end else begin
                plane_pair_decode_fail[pp]++;
            end
            
            if (!resp.plane_crc_err[pp]) begin
                plane_pair_crc_err[pp]++;
            end
            
            if (resp.plane_pair_lba_comp[pp]) begin
                plane_pair_lba_mismatch[pp]++;
            end
        end
        
        // 查找匹配的期望配置
        if (pending_config.exists(resp.instruction_index)) begin
            check_status_e status = CHECK_PASS;
            string fail_reason = "";
            
            // 遍历 8 个 plane_pair 进行检查
            for (int pp = 0; pp < 8; pp++) begin
                auto cfg = pending_config[resp.instruction_index][pp];
                
                if (!cfg.valid || !cfg.plane_sel) continue;
                
                // 只检查期望上报 deep_resp 的 plane_pair
                // (dec_suc=0 && crc_pass=1 && data_out_en=0)
                if (!cfg.dec_suc && cfg.crc_pass && !cfg.data_out_en) begin
                    // 检查译码状态 (plane_pair_ondec_flag: 0=成功，1=失败)
                    if (cfg.dec_suc != !resp.plane_pair_ondec_flag[pp]) begin
                        status = CHECK_FAIL_DECODE;
                        fail_reason = $sformatf("PP[%0d] decode mismatch: expected=%0b, got=%0b", 
                            pp, cfg.dec_suc, !resp.plane_pair_ondec_flag[pp]);
                        break;
                    end
                    
                    // 检查 CRC 状态 (plane_crc_err: 1=成功，0=失败)
                    if (cfg.crc_pass != resp.plane_crc_err[pp]) begin
                        status = CHECK_FAIL_CRC;
                        fail_reason = $sformatf("PP[%0d] CRC mismatch: expected=%0b, got=%0b", 
                            pp, cfg.crc_pass, resp.plane_crc_err[pp]);
                        break;
                    end
                    
                    // 检查 OST ID
                    if (cfg.nsu_ost_id != resp.nsu_ost_id) begin
                        status = CHECK_FAIL_OST_ID;
                        fail_reason = $sformatf("OST ID mismatch: expected=%0h, got=%0h", 
                            cfg.nsu_ost_id, resp.nsu_ost_id);
                        break;
                    end
                    
                    // 检查 deep_read_sel
                    if (cfg.deep_read_sel != resp.deep_read_sel) begin
                        status = CHECK_FAIL_DATA;
                        fail_reason = $sformatf("deep_read_sel mismatch: expected=%0b, got=%0b", 
                            cfg.deep_read_sel, resp.deep_read_sel);
                        break;
                    end
                    
                    // 检查 read_mode
                    if (cfg.read_mode != resp.mode_sel) begin
                        status = CHECK_FAIL_DATA;
                        fail_reason = $sformatf("read_mode mismatch: expected=%0b, got=%0b", 
                            cfg.read_mode, resp.mode_sel);
                        break;
                    end
                end
            end
            
            // 报告结果
            if (status == CHECK_PASS) begin
                pass_count++;
                `uvm_info(get_type_name(), $sformatf("DEEP_READ_RESP CHECK PASS: instr_idx=%0h", resp.instruction_index), UVM_LOW)
            end else begin
                fail_count++;
                `uvm_error(get_type_name(), $sformatf("DEEP_READ_RESP CHECK FAIL: instr_idx=%0h, status=%0b, reason=%s", 
                    resp.instruction_index, status, fail_reason))
            end
            
            // 清除已检查的配置
            pending_config.delete(resp.instruction_index);
        end else begin
            `uvm_warning(get_type_name(), $sformatf("DEEP_READ_RESP: No matching config for instr_idx=%0h", 
                resp.instruction_index))
        end
    end
endtask : check_deep_read_resp

//-----------------------------------------------------------------------------
// check_offwbf_cmd - 检查 NSU 下发给 OFFWBF 的指令
// 
// 检查内容:
// 1. instruction_index 匹配
// 2. src_mem_addr (与 dest_memory_addr 比较)
// 3. dec_fail_dest_addr 匹配
// 4. offwbf_start 标志
// 5. descramble_en 和 descramble_seed
//-----------------------------------------------------------------------------
task `CLASS_NAME_DEFINE::check_offwbf_cmd();
    nsu2offwbf_transaction offwbf_tr;
    
    forever begin
        offwbf_cmd_fifo.get(offwbf_tr);
        total_offwbf_count++;
        
        `uvm_info(get_type_name(), $sformatf("Received OFFWBF_CMD: instr_idx=%0h, ost_id=%0h, src_addr=%0h, offwbf_start=%0b", 
            offwbf_tr.instruction_index, offwbf_tr.nsu_ost_id, offwbf_tr.src_mem_addr, offwbf_tr.offwbf_start), UVM_LOW)
        
        // 查找匹配的期望配置
        if (pending_config.exists(offwbf_tr.instruction_index)) begin
            check_status_e status = CHECK_PASS;
            string fail_reason = "";
            
            // 遍历 8 个 plane_pair 进行检查
            for (int pp = 0; pp < 8; pp++) begin
                auto cfg = pending_config[offwbf_tr.instruction_index][pp];
                
                if (!cfg.valid || !cfg.plane_sel) continue;
                
                // 只检查期望调用 offwbf 的 plane_pair
                // (dec_suc=0 && crc_pass=1 && data_out_en=1)
                if (!cfg.dec_suc && cfg.crc_pass && cfg.data_out_en) begin
                    // 检查 OST ID
                    if (cfg.nsu_ost_id != offwbf_tr.nsu_ost_id) begin
                        status = CHECK_FAIL_OST_ID;
                        fail_reason = $sformatf("OST ID mismatch: expected=%0h, got=%0h", 
                            cfg.nsu_ost_id, offwbf_tr.nsu_ost_id);
                        break;
                    end
                    
                    // 检查源地址 (offwbf 从 dest_memory_addr 读取数据)
                    if (cfg.dest_memory_addr != offwbf_tr.src_mem_addr) begin
                        status = CHECK_FAIL_DATA;
                        fail_reason = $sformatf("src_mem_addr mismatch: expected=%0h, got=%0h", 
                            cfg.dest_memory_addr, offwbf_tr.src_mem_addr);
                        break;
                    end
                    
                    // 检查译码失败目标地址
                    if (cfg.dec_fail_dest_addr != offwbf_tr.dec_fail_dest_addr) begin
                        status = CHECK_FAIL_DATA;
                        fail_reason = $sformatf("dec_fail_dest_addr mismatch: expected=%0h, got=%0h", 
                            cfg.dec_fail_dest_addr, offwbf_tr.dec_fail_dest_addr);
                        break;
                    end
                    
                    // 检查 offwbf_start 标志
                    if (!offwbf_tr.offwbf_start) begin
                        status = CHECK_FAIL_DATA;
                        fail_reason = "offwbf_start not asserted";
                        break;
                    end
                    
                    // 检查 read_mode (offwbf 只在 safe read 模式下调用)
                    if (cfg.read_mode != 1'b0) begin
                        status = CHECK_FAIL_DATA;
                        fail_reason = $sformatf("offwbf called in non-safe mode: read_mode=%0b", cfg.read_mode);
                        break;
                    end
                end
            end
            
            // 报告结果
            if (status == CHECK_PASS) begin
                pass_count++;
                offwbf_success_count++;
                `uvm_info(get_type_name(), $sformatf("OFFWBF_CMD CHECK PASS: instr_idx=%0h", offwbf_tr.instruction_index), UVM_LOW)
            end else begin
                fail_count++;
                offwbf_fail_count++;
                `uvm_error(get_type_name(), $sformatf("OFFWBF_CMD CHECK FAIL: instr_idx=%0h, status=%0b, reason=%s", 
                    offwbf_tr.instruction_index, status, fail_reason))
            end
            
            // 清除已检查的配置
            pending_config.delete(offwbf_tr.instruction_index);
        end else begin
            `uvm_warning(get_type_name(), $sformatf("OFFWBF_CMD: No matching config for instr_idx=%0h", 
                offwbf_tr.instruction_index))
        end
    end
endtask : check_offwbf_cmd

`endif
