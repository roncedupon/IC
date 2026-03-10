`ifndef MYCHECKER_SV
`define MYCHECKER_SV

//=============================================================================
// mychecker.sv - ONDEC2NSU Checker (Group 独立处理版本)
//=============================================================================
// 三步检查流程:
// 1. 获取 ondec2nsu_group_transaction (8 个 plane_pair = 2 个 group)
// 2. 按 group 判断：每个 group 独立判断 (dec_suc, crc_pass, data_out_en)
// 3. 从对应队列中找到匹配的 transaction 进行比较
//
// Group 划分:
//   - Group 0: plane_pair[0:3], ost_id = tr[0].nsu_ost_id
//   - Group 1: plane_pair[4:7], ost_id = tr[4].nsu_ost_id
//
// nsu2cpu_deep_resp_transaction 字段:
//   - group0_ost_id: Group 0 的 OST ID
//   - group1_ost_id: Group 1 的 OST ID
//=============================================================================
typedef class offdec2nsu_transaction;  // 前向声明 (避免循环依赖)
package ondec2nsu_checker_pkg;
    
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
    // Group 检查配置 (每个 group 独立)
    // Group 0: plane_pair[0:3], Group 1: plane_pair[4:7]
    //=========================================================================
    typedef struct  {
        logic        valid;
        logic [15:0] instruction_index;
        logic [4:0]  nsu_ost_id;               // Group 独立的 OST ID
        logic [3:0]  plane_sel;                // 4 个 plane_pair 选择
        logic [3:0]  dec_suc;                  // 4 个 plane_pair 译码成功
        logic [3:0]  crc_pass;                 // 4 个 plane_pair CRC 通过
        logic [3:0]  data_out_en;              // 4 个 plane_pair 数据输出使能
        logic [3:0]  offline_wbf_work_en;      // 4 个 plane_pair offwbf 使能
        logic [3:0]  flip_threshold_sel;       // 4 个 plane_pair flip_threshold_sel
        logic [3:0]  syn_weight_over_threshold; // 4 个 plane_pair syn_weight_over_threshold
        logic [3:0]  descramble_en;            // 4 个 plane_pair descramble_en
        logic [15:0] descramble_seed [4];     // 4 个 plane_pair descramble_seed
        logic [3:0]  write_pos_jdg;            // 4 个 plane_pair write_pos_jdg
        logic        deep_read_sel;            // deep read 选择 (group 内一致)
        logic        read_mode;                // 读模式 (group 内一致)
        logic [31:0] dest_memory_addr;         // 目标内存地址 (对应 group_0_dest_memory_addr 等)
        logic [31:0] dec_fail_dest_addr;       // 译码失败目标地址 (对应 dec_fail_dest_addr_0 等)
        logic [15:0] plane_group_block_addr;   // 块地址 (对应 group0_block_addr 等)
        logic [11:0] page_addr_plane_group;    // 页地址 (对应 page_address_plane_group_0 等)
    } group_check_config_t;

endpackage
`define CLASS_NAME_DEFINE ondec2nsu_checker

//=============================================================================
// ondec2nsu_checker 类定义
//=============================================================================

class `CLASS_NAME_DEFINE extends uvm_component;

    `uvm_component_utils(`CLASS_NAME_DEFINE)

    import ondec2nsu_checker_pkg::*;


    //-------------------------------------------------------------------------
    // FIFO 定义
    //-------------------------------------------------------------------------
    // 8 个 plane_pair 的 ondec2nsu_transaction 输入队列
    uvm_tlm_analysis_fifo #(ondec2nsu_transaction) ondec_fifo [8];
    
    // ondec_cmd FIFO - 输出：打包后的 ondec2nsu_group_transaction (8 个 plane_pair = 2 个 group)
    uvm_tlm_analysis_fifo #(ondec2nsu_group_transaction) ondec_group_cmd_fifo;
    
    // deep_read_resp FIFO - 输入：NSU 上报给 CPU 的 deep read 响应
    uvm_tlm_analysis_fifo #(nsu2cpu_deep_resp_transaction) deep_read_resp_fifo;
    
    // offwbf_cmd FIFO - 输入：NSU 下发给 OFFWBF 的指令
    uvm_tlm_analysis_fifo #(offdec2nsu_transaction) offwbf_cmd_fifo;
    
    //-------------------------------------------------------------------------
    // 待检查的配置跟踪表 (按 instruction_index 索引)
    //-------------------------------------------------------------------------
    logic pending_instr_exists [bit [15:0]];  // 关联数组：标记 instruction_index 是否存在
    ondec2nsu_group_transaction pending_config [bit [15:0]];  // [instr_idx] → 完整的group transaction
    
    //-------------------------------------------------------------------------
    // 统计计数器
    //-------------------------------------------------------------------------
    int unsigned total_cmd_count = 0;
    int unsigned total_resp_count = 0;
    int unsigned total_offwbf_count = 0;
    int unsigned pass_count = 0;
    int unsigned fail_count = 0;
    
    // Group 统计 (每个 group 独立)
    int unsigned group_decode_success [1:0];
    int unsigned group_decode_fail [1:0];
    int unsigned group_crc_err [1:0];
    int unsigned group_lba_mismatch [1:0];
    int unsigned offwbf_success_count = 0;
    int unsigned offwbf_fail_count = 0;
    
    //-------------------------------------------------------------------------
    // Task 声明 (class 内声明)
    //-------------------------------------------------------------------------
    extern virtual task pack_ondec_transactions();  // 新增：从 8 个队列打包 transaction
    extern virtual task check_ondec_cmd();      // 第一步：获取 ondec_cmd，按 group 判断
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
        
        // 初始化 8 个 plane_pair 的 FIFO
        for (int i = 0; i < 8; i++) begin
            ondec_fifo[i] = new($sformatf("ondec_fifo[%0d]", i), this);
        end
        
        ondec_group_cmd_fifo = new("ondec_group_cmd_fifo", this);
        deep_read_resp_fifo = new("deep_read_resp_fifo", this);
        offwbf_cmd_fifo = new("offwbf_cmd_fifo", this);
    endfunction : build_phase
    
    //-------------------------------------------------------------------------
    // run_phase
    //-------------------------------------------------------------------------
    virtual task run_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "ondec2nsu_checker started (GROUP-BASED processing)", UVM_LOW)
        
        fork
            pack_ondec_transactions();  // 新增：从 8 个队列打包 transaction
            check_ondec_cmd();      // 第一步：获取 ondec_cmd，按 group 判断
            check_deep_read_resp(); // 第二步：检查 deep read resp
            check_offwbf_cmd();     // 第三步：检查 offwbf 指令
        join
    endtask : run_phase
    
    //-------------------------------------------------------------------------
    // report_phase
    //-------------------------------------------------------------------------
    virtual function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("Total ONDEC_CMD: %0d, Total DEEP_RESP: %0d, Total OFFWBF: %0d", 
            total_cmd_count, total_resp_count, total_offwbf_count), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("Pass: %0d, Fail: %0d", pass_count, fail_count), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("Group0: decode_success=%0d, decode_fail=%0d, crc_err=%0d", 
            group_decode_success[0], group_decode_fail[0], group_crc_err[0]), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("Group1: decode_success=%0d, decode_fail=%0d, crc_err=%0d", 
            group_decode_success[1], group_decode_fail[1], group_crc_err[1]), UVM_LOW)
    endfunction : report_phase

    //-------------------------------------------------------------------------
    // final_phase - 检查所有FIFO队列是否为空
    //-------------------------------------------------------------------------
    virtual function void final_phase(uvm_phase phase);
        int unsigned fifo_size;
        bit has_unprocessed;

        has_unprocessed = 1'b0;

        // 检查8个ondec_fifo队列
        for (int i = 0; i < 8; i++) begin
            fifo_size = ondec_fifo[i].used();
            if (fifo_size > 0) begin
                `uvm_error(get_type_name(), $sformatf("FINAL_CHECK: ondec_fifo[%0d] is not empty, has %0d unprocessed transactions", 
                    i, fifo_size))
                has_unprocessed = 1'b1;
            end
        end

        // 检查ondec_group_cmd_fifo队列
        fifo_size = ondec_group_cmd_fifo.used();
        if (fifo_size > 0) begin
            `uvm_error(get_type_name(), $sformatf("FINAL_CHECK: ondec_group_cmd_fifo is not empty, has %0d unprocessed transactions", 
                fifo_size))
            has_unprocessed = 1'b1;
        end

        // 检查deep_read_resp_fifo队列
        fifo_size = deep_read_resp_fifo.used();
        if (fifo_size > 0) begin
            `uvm_error(get_type_name(), $sformatf("FINAL_CHECK: deep_read_resp_fifo is not empty, has %0d unprocessed transactions", 
                fifo_size))
            has_unprocessed = 1'b1;
        end

        // 检查offwbf_cmd_fifo队列
        fifo_size = offwbf_cmd_fifo.used();
        if (fifo_size > 0) begin
            `uvm_error(get_type_name(), $sformatf("FINAL_CHECK: offwbf_cmd_fifo is not empty, has %0d unprocessed transactions", 
                fifo_size))
            has_unprocessed = 1'b1;
        end

        if (!has_unprocessed) begin
            `uvm_info(get_type_name(), "FINAL_CHECK: All FIFOs are empty, no unprocessed transactions", UVM_LOW)
        end else begin
            `uvm_error(get_type_name(), "FINAL_CHECK FAILED: Some FIFOs contain unprocessed transactions!")
        end
    endfunction : final_phase
    
endclass : ondec2nsu_checker

//=============================================================================
// Task 实现 (class 外实现)
//=============================================================================

//-----------------------------------------------------------------------------
// check_ondec_cmd - 获取 ondec2nsu_group_transaction，按 group 判断并注册期望
// 
// Group 划分:
//   - Group 0: plane_pair[0:3], ost_id = tr[0].nsu_ost_id
//   - Group 1: plane_pair[4:7], ost_id = tr[4].nsu_ost_id
//
// 判断逻辑 (每个 group 独立):
//   遍历 group 内 4 个 plane_pair:
//   - 只要有任意 plane_pair 满足 (dec_suc=0 && crc_pass=1 && data_out_en=0)
//     → 该 group 需要上报 deep_resp
//   - 只要有任意 plane_pair 满足 (dec_suc=0 && crc_pass=1 && data_out_en=1)
//     → 该 group 需要调用 offwbf
//-----------------------------------------------------------------------------
task `CLASS_NAME_DEFINE::check_ondec_cmd();
    ondec2nsu_group_transaction group_tr;
    int pp_base;
    logic group_need_deep_resp;
    logic group_need_offwbf;
    
    forever begin
        // =========================================================
        // 第一步：获取 ondec2nsu_group_transaction
        // =========================================================
        ondec_group_cmd_fifo.get(group_tr);
        total_cmd_count++;
        
        `uvm_info(get_type_name(), $sformatf("Received ONDEC_GROUP: instr_idx=%0h", 
            group_tr.tr[0].instruction_index), UVM_LOW)
        
        // =========================================================
        // 第二步：按 group 处理 (Group 0: PP[0:3], Group 1: PP[4:7])
        // =========================================================
        for (int gid = 0; gid < 2; gid++) begin
            pp_base = gid * 4;  // Group 0: pp_base=0, Group 1: pp_base=4
            
            `uvm_info(get_type_name(), $sformatf("  Processing Group%0d (PP[%0d:%0d])", 
                gid, pp_base, pp_base+3), UVM_LOW)
            
            // =========================================================
            // 第三步：判断 group 需要什么响应
            // =========================================================
            group_need_deep_resp = 1'b0;
            group_need_offwbf = 1'b0;
            
            // 遍历 group 内 4 个 plane_pair，判断是否需要 deep_resp 或 offwbf
            for (int pp = 0; pp < 4; pp++) begin
                if (!group_tr.tr[pp_base + pp].plane_sel) continue;  // 跳过未选择的 plane_pair
                
                if (!group_tr.tr[pp_base + pp].dec_suc && group_tr.tr[pp_base + pp].crc_pass) begin
                    // 译码失败但 CRC 成功
                    if (!group_tr.tr[pp_base + pp].data_out_en) begin
                        // 数据不输出 → 需要上报 deep_resp
                        group_need_deep_resp = 1'b1;
                        `uvm_info(get_type_name(), $sformatf("    PP[%0d]: decode_fail+crc_success+no_data → Group%0d need DEEP_READ_RESP", 
                            pp_base+pp, gid), UVM_LOW)
                    end else begin
                        // 数据输出 → 需要调用 offwbf
                        group_need_offwbf = 1'b1;
                        group_tr.tr[pp_base + pp].offline_wbf_work_en = 1'b1;  // 为每个需要offwbf的plane_pair设置标志
                        `uvm_info(get_type_name(), $sformatf("    PP[%0d]: decode_fail+crc_success+data → Group%0d need OFFWBF_CMD", 
                            pp_base+pp, gid), UVM_LOW)
                    end
                end
            end
            
            // 记录判断结果
            if (group_need_deep_resp) begin
                `uvm_info(get_type_name(), $sformatf("  Group%0d: Will expect DEEP_READ_RESP (ost_id=%0h)", 
                    gid, group_tr.tr[pp_base].nsu_ost_id), UVM_LOW)
            end
            if (group_need_offwbf) begin
                `uvm_info(get_type_name(), $sformatf("  Group%0d: Will expect OFFWBF_CMD (ost_id=%0h)", 
                    gid, group_tr.tr[pp_base].nsu_ost_id), UVM_LOW)
            end
            if (!group_need_deep_resp && !group_need_offwbf) begin
                `uvm_info(get_type_name(), $sformatf("  Group%0d: No action needed (all decode success or crc_fail)", 
                    gid), UVM_LOW)
            end
        end
        
        // 记录 pending instruction index (使用关联数组标记存在)并保存完整的group transaction
        pending_instr_exists[group_tr.tr[0].instruction_index] = 1'b1;
        pending_config[group_tr.tr[0].instruction_index] = group_tr;
        
        `uvm_info(get_type_name(), $sformatf("Registered config for instr_idx=%0h (8 plane_pairs, waiting for resp/offwbf)", 
            group_tr.tr[0].instruction_index), UVM_LOW)
    end
endtask : check_ondec_cmd

//-----------------------------------------------------------------------------
// check_deep_read_resp - 检查 NSU 上报给 CPU 的 deep read 响应
// 
// 检查内容 (按 group 独立检查):
// 1. instruction_index 匹配
// 2. group0_ost_id 或 group1_ost_id 匹配 (group 独立)
// 3. plane_pair_ondec_flag[7:0] (与 dec_suc 比较)
// 4. plane_crc_err[7:0] (与 crc_pass 比较)
// 5. plane_pair_lba_comp[7:0] (LBA 比对)
// 6. deep_read_sel 和 mode_sel
//-----------------------------------------------------------------------------
task `CLASS_NAME_DEFINE::check_deep_read_resp();
    nsu2cpu_deep_resp_transaction resp;
    check_status_e status;
    string fail_reason;
    int matched_gid;
    int pp_idx;
    logic [4:0] resp_ost_id;
    ondec2nsu_group_transaction cfg;
    int pp_base;
    forever begin
        deep_read_resp_fifo.get(resp);
        total_resp_count++;
        
        `uvm_info(get_type_name(), $sformatf("Received DEEP_READ_RESP: instr_idx=%0h, pp_ondec_flag=%08b, pp_crc_err=%08b", 
            resp.instruction_index, resp.plane_pair_ondec_flag, resp.plane_crc_err), UVM_LOW)
        
        // 查找匹配的期望配置
        if (pending_instr_exists[resp.instruction_index]) begin
            status = CHECK_PASS;
            fail_reason = "";
            matched_gid = -1;
            
            // 遍历 2 个 group，找到匹配的 group (通过 ost_id)
            for (int gid = 0; gid < 2; gid++) begin
                cfg = pending_config[resp.instruction_index];
                pp_base = gid * 4;  // Group 0: pp_base=0, Group 1: pp_base=4
                
                // 根据 group_id 获取 resp 中对应的 ost_id
                if (gid == 0) begin
                    resp_ost_id = resp.group0_ost_id;
                end else begin
                    resp_ost_id = resp.group1_ost_id;
                end
                
                // 检查 ost_id 是否匹配 (group 独立的关键)
                if (cfg.tr[pp_base].nsu_ost_id == resp_ost_id) begin
                    matched_gid = gid;
                    
                    `uvm_info(get_type_name(), $sformatf("  Matched Group%0d (ost_id=%0h)", 
                        gid, cfg.tr[pp_base].nsu_ost_id), UVM_LOW)
                    
                    // 遍历 group 内 4 个 plane_pair 进行检查
                    for (int pp = 0; pp < 4; pp++) begin
                        if (!cfg.tr[pp_base + pp].plane_sel) continue;  // 跳过未选择的 plane_pair
                        
                        // 只检查期望上报 deep_resp 的 plane_pair
                        if (!cfg.tr[pp_base + pp].dec_suc && cfg.tr[pp_base + pp].crc_pass) begin
                            pp_idx = gid * 4 + pp;  // 全局 plane_pair 索引
                            
                            // 检查译码状态 (plane_pair_ondec_flag: 0=成功，1=失败)
                            if (cfg.tr[pp_base + pp].dec_suc != !resp.plane_pair_ondec_flag[pp_idx]) begin
                                status = CHECK_FAIL_DECODE;
                                fail_reason = $sformatf("Group%0d PP[%0d] decode mismatch: expected=%0b, got=%0b", 
                                    gid, pp, cfg.tr[pp_base + pp].dec_suc, !resp.plane_pair_ondec_flag[pp_idx]);
                                break;
                            end
                            
                            // 检查 CRC 状态 (plane_crc_err: 1=成功，0=失败)
                            if (cfg.tr[pp_base + pp].crc_pass != resp.plane_crc_err[pp_idx]) begin
                                status = CHECK_FAIL_CRC;
                                fail_reason = $sformatf("Group%0d PP[%0d] CRC mismatch: expected=%0b, got=%0b", 
                                    gid, pp, cfg.tr[pp_base + pp].crc_pass, resp.plane_crc_err[pp_idx]);
                                break;
                            end
                        end
                    end
                    
                    // 检查 deep_read_sel
                    if (cfg.tr[pp_base].deep_read_sel != resp.deep_read_sel) begin
                        status = CHECK_FAIL_DATA;
                        fail_reason = $sformatf("Group%0d deep_read_sel mismatch: expected=%0b, got=%0b", 
                            gid, cfg.tr[pp_base].deep_read_sel, resp.deep_read_sel);
                    end
                    
                    // 检查 read_mode
                    if (cfg.tr[pp_base].read_mode != resp.read_mode) begin
                        status = CHECK_FAIL_DATA;
                        fail_reason = $sformatf("Group%0d read_mode mismatch: expected=%0b, got=%0b", 
                            gid, cfg.tr[pp_base].read_mode, resp.read_mode);
                    end
                    
                    break;  // 找到匹配的 group 后退出
                end
            end
            
            // 更新统计 (按 group)
            if (matched_gid >= 0) begin
                for (int pp = 0; pp < 4; pp++) begin
                    pp_idx = matched_gid * 4 + pp;
                    if (!resp.plane_pair_ondec_flag[pp_idx]) begin
                        group_decode_success[matched_gid]++;
                    end else begin
                        group_decode_fail[matched_gid]++;
                    end
                    if (!resp.plane_crc_err[pp_idx]) begin
                        group_crc_err[matched_gid]++;
                    end
                    if (resp.plane_pair_lba_comp[pp_idx]) begin
                        group_lba_mismatch[matched_gid]++;
                    end
                end
            end
            
            // 报告结果
            if (status == CHECK_PASS) begin
                pass_count++;
                `uvm_info(get_type_name(), $sformatf("DEEP_READ_RESP CHECK PASS: instr_idx=%0h, Group%0d (ost_id=%0h)", 
                    resp.instruction_index, matched_gid, resp_ost_id), UVM_LOW)
            end else begin
                fail_count++;
                `uvm_error(get_type_name(), $sformatf("DEEP_READ_RESP CHECK FAIL: instr_idx=%0h, Group%0d, status=%0b, reason=%s", 
                    resp.instruction_index, matched_gid, status, fail_reason))
            end
            
            // 清除已检查的 group 配置
            if (matched_gid >= 0) begin
                pending_instr_exists[resp.instruction_index] = 1'b0;
            end
        end else begin
            `uvm_warning(get_type_name(), $sformatf("DEEP_READ_RESP: No matching config for instr_idx=%0h", 
                resp.instruction_index))
        end
    end
endtask : check_deep_read_resp

//-----------------------------------------------------------------------------// check_offwbf_cmd - 检查 NSU 下发给 OFFWBF 的指令
// 
// 检查内容 (按 plane 独立检查):
// 1. plane_num 匹配 (对应 ondec 中的 plane)
// 2. dest_sel 匹配 (与 ondec 写位位置判断对应)
// 3. flip_threshold_sel 匹配 (与 ondec.flip_threshold_sel 对应)
// 4. over_threshold 匹配 (与 ondec.syn_weight_over_threshold 对应)
// 5. descramble_en 匹配 (与 ondec.descramble_en 对应)
// 6. descramble_seed 匹配 (与 ondec.descramble_seed 对应)
// 7. src_mem_addr 匹配 (与 ondec.dest_memory_addr 对应)
// 8. dest_mem_addr 匹配 (与 ondec.dec_fail_dest_addr 对应)
// 9. offline_wbf_out_flag 标志
// 10. read_mode (offwbf 只在 safe read 下调用)
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// check_offwbf_cmd - 检查 NSU 下发给 OFFWBF 的指令 (基于 descramble_seed 匹配)
// 
// 检查流程:
// 1. 从测试环境获取一个有效的 offwbf_cmd
// 2. 根据 offwbf_cmd 中的 descramble_seed 值，在 pending_config 中查找匹配的 ondec_group_cmd
// 3. 如果检测到多个 offwbf_cmd 对象的 descramble_seed 与目标值匹配，发出 UVM 警告
// 4. 对成功匹配的唯一 offwbf_cmd 进行全面检查
//
// 检查内容 (按 plane 独立检查):
// 1. descramble_seed 严格匹配 (首要匹配条件)
// 2. plane_num 匹配 (对应 ondec 中的 plane)
// 3. dest_sel 匹配 (与 ondec.write_pos_jdg 对应)
// 4. flip_threshold_sel 匹配 (与 ondec.flip_threshold_sel 对应)
// 5. over_threshold 匹配 (与 ondec.syn_weight_over_threshold 对应)
// 6. descramble_en 匹配 (与 ondec.descramble_en 对应)
// 7. src_mem_addr 匹配 (与 ondec.dest_memory_addr 对应)
// 8. dest_mem_addr 匹配 (与 ondec.dec_fail_dest_addr 对应)
// 9. offline_wbf_out_flag 标志
// 10. read_mode (offwbf 只在 safe read 下调用)
//-----------------------------------------------------------------------------
task `CLASS_NAME_DEFINE::check_offwbf_cmd();
    offdec2nsu_transaction offwbf_tr;
    check_status_e status;
    string fail_reason;
    int matched_gid;
    int matched_pp;
    bit [15:0] matched_instr_idx;
    bit [15:0] p_instr_idx;
    int p_gid;
    int p_pp;
    int pp;
    int i;
    ondec2nsu_group_transaction cfg;
    logic [31:0] src_mem_addr_32bit;
    logic [31:0] dest_mem_addr_32bit;
    logic [15:0] descramble_seed;
    logic has_pending_offwbf;
    int match_count;
    bit [15:0] matched_instr_indices [$];
    int matched_pp_list [$];  // 存储所有匹配的 plane_pair 索引
    int matched_cfg_idx [$];  // 存储所有匹配的 config 索引
    
    forever begin
        // =========================================================
        // 第一步：从测试环境或相关接口中获取一个有效的 offwbf_cmd
        // 确保其包含完整的命令信息和必要参数
        // =========================================================
        offwbf_cmd_fifo.get(offwbf_tr);
        total_offwbf_count++;
        
        // 组合 32bit 地址
        src_mem_addr_32bit = {offwbf_tr.src_mem_addr_3, offwbf_tr.src_mem_addr_2, 
                              offwbf_tr.src_mem_addr_1, offwbf_tr.src_mem_addr_0};
        dest_mem_addr_32bit = {offwbf_tr.dest_mem_addr_3, offwbf_tr.dest_mem_addr_2, 
                               offwbf_tr.dest_mem_addr_1, offwbf_tr.dest_mem_addr_0};
        
        // 组合 16bit descramble_seed
        descramble_seed = {offwbf_tr.descramble_seed_1, offwbf_tr.descramble_seed_0};
        
        `uvm_info(get_type_name(), $sformatf( "\n========== Received OFFWBF_CMD #%0d ==========\n plane_num: %0d\n ost_id_nsu2offline: %0h\n src_mem_addr (32bit): %0h\n dest_mem_addr (32bit): %0h\n descramble_seed: %0h\n offline_wbf_out_flag: %0b\n=============================================\n", total_offwbf_count, offwbf_tr.plane_num, offwbf_tr.ost_id_nsu2offline, src_mem_addr_32bit, dest_mem_addr_32bit, descramble_seed, offwbf_tr.offline_wbf_out_flag), UVM_LOW)
        
        // =========================================================
        // 第二步：根据 descramble_seed 在 pending_config 中查找匹配的 ondec_group_cmd
        // 实现严格的匹配逻辑，确保 descramble_seed 值完全一致
        // =========================================================
        `uvm_info(get_type_name(), $sformatf("  Searching for matching ondec_group_cmd with descramble_seed=%0h...", descramble_seed), UVM_LOW)
        
        status = CHECK_PASS;
        fail_reason = "";
        matched_gid = -1;
        matched_pp = -1;
        matched_instr_idx = 16'hFFFF;
        match_count = 0;
        matched_instr_indices.delete();
        matched_pp_list.delete();
        matched_cfg_idx.delete();
        
        // 遍历所有 pending 的 instruction_index，收集所有 descramble_seed 匹配项
        foreach (pending_config[p_instr_idx]) begin
            cfg = pending_config[p_instr_idx];
            
            // 遍历所有 8 个 plane_pair，查找 descramble_seed 匹配的 plane_pair
            for (pp = 0; pp < 8; pp++) begin
                if (!cfg.tr[pp].plane_sel) begin
                    `uvm_info(get_type_name(), $sformatf("  Skipping instr_idx=%0h, PP[%0d]: plane_sel=0 (not selected)", p_instr_idx, pp), UVM_LOW)
                    continue;  // 跳过未选择的 plane_pair
                end

                if (!cfg.tr[pp].offline_wbf_work_en) begin
                    `uvm_info(get_type_name(), $sformatf("  Skipping instr_idx=%0h, PP[%0d]: offline_wbf_work_en=0 (no offwbf needed)", p_instr_idx, pp), UVM_LOW)
                    continue;  // 跳过不需要 offwbf 的 plane_pair
                end

                // 检查 descramble_en (必须使能才能进行 descramble_seed 匹配)
                if (!cfg.tr[pp].descramble_en) begin
                    `uvm_info(get_type_name(), $sformatf("  Skipping instr_idx=%0h, PP[%0d]: descramble_en=0 (descramble disabled)", p_instr_idx, pp), UVM_LOW)
                    continue;
                end
                
                // 严格匹配 descramble_seed
                if (descramble_seed == cfg.tr[pp].descramble_seed) begin
                    `uvm_info(get_type_name(), $sformatf("  >>> MATCH FOUND: instr_idx=%0h, PP[%0d] (global_plane=%0d)\n      descramble_seed: %0h (matched)\n      plane_num:       %0d (offwbf) vs %0d (ondec)\n      src_addr:        %0h (offwbf) vs %0h (ondec)\n      dest_addr:       %0h (offwbf) vs %0h (ondec)", p_instr_idx, pp % 4, pp, descramble_seed, offwbf_tr.plane_num, pp, src_mem_addr_32bit, cfg.tr[pp].dec_fail_dest_addr, dest_mem_addr_32bit, cfg.tr[pp].dest_memory_addr), UVM_LOW)
                    
                    // 记录匹配项
                    match_count++;
                    matched_instr_indices.push_back(p_instr_idx);
                    matched_pp_list.push_back(pp);
                    matched_cfg_idx.push_back(pp);

                    `uvm_info(get_type_name(), $sformatf("  Total matches so far: %0d", match_count), UVM_LOW)
                end else begin
                    `uvm_info(get_type_name(), $sformatf("  No match: instr_idx=%0h, PP[%0d], descramble_seed=%0h (expected %0h)", p_instr_idx, pp, cfg.tr[pp].descramble_seed, descramble_seed), UVM_LOW)
                end
            end
        end
        
        // =========================================================
        // 第三步：检查匹配结果，处理多匹配情况
        // =========================================================
        if (match_count == 0) begin
            `uvm_error(get_type_name(), $sformatf("OFFWBF_CMD: No matching ondec_group_cmd found for descramble_seed=%0h", descramble_seed))
            status = CHECK_INVALID_RESP;
            fail_reason = $sformatf("No matching config found for descramble_seed=%0h", descramble_seed);
        end else if (match_count > 1) begin
            // 检测到多个匹配，发出 UVM 警告
            `uvm_warning(get_type_name(), $sformatf("\n========== MULTIPLE MATCH WARNING ==========\n  Multiple offwbf_cmd objects match the same descramble_seed!\n  descramble_seed: %0h\n  Match count: %0d\n  Matched instructions:", descramble_seed, match_count))
            
            // 记录所有匹配的指令信息
            for (i = 0; i < match_count; i++) begin
                `uvm_warning(get_type_name(), $sformatf("    Match #%0d: instr_idx=%0h, PP[%0d] (global_plane=%0d)", i+1, matched_instr_indices[i], matched_pp_list[i] % 4, matched_pp_list[i]))
            end

            `uvm_warning(get_type_name(), $sformatf("  Current system does NOT support multiple matching offwbf_cmd cases.\n  Will process ONLY the FIRST match (instr_idx=%0h, PP[%0d]).\n=========================================\n", matched_instr_indices[0], matched_pp_list[0] % 4))
            
            // 使用第一个匹配项进行处理
            matched_instr_idx = matched_instr_indices[0];
            matched_pp = matched_pp_list[0];
            matched_gid = matched_pp / 4;
            matched_pp = matched_pp % 4;
        end else begin
            // 唯一匹配
            matched_instr_idx = matched_instr_indices[0];
            matched_pp = matched_pp_list[0];
            matched_gid = matched_pp / 4;
            matched_pp = matched_pp % 4;
            
            `uvm_info(get_type_name(), $sformatf("  Unique match found: instr_idx=%0h, Group%0d PP[%0d] (global_plane=%0d)", matched_instr_idx, matched_gid, matched_pp, matched_gid*4+matched_pp), UVM_LOW)
        end
        
        // =========================================================
        // 第四步：对成功匹配的 offwbf_cmd 进行全面检查
        // =========================================================
        if (match_count >= 1) begin
            int global_pp = matched_gid * 4 + matched_pp;
            cfg = pending_config[matched_instr_idx];


            `uvm_info(get_type_name(), $sformatf("\n  [Starting Comprehensive Check]\n  Matched Config(ondec):\n    instruction_index: %0h\n    Group: %0d, PP: %0d (Global PP: %0d)\n    OST ID: %0h\n    plane_sel: %0b\n    offline_wbf_work_en: %0b\n    descramble_en: %0b\n    descramble_seed: %0h\n    read_mode: %0b\n    dest_memory_addr: %0h\n    dec_fail_dest_addr: %0h", matched_instr_idx, matched_gid, matched_pp, global_pp, cfg.tr[global_pp].nsu_ost_id, cfg.tr[global_pp].plane_sel, cfg.tr[global_pp].offline_wbf_work_en, cfg.tr[global_pp].descramble_en, cfg.tr[global_pp].descramble_seed, cfg.tr[global_pp].read_mode, cfg.tr[global_pp].dest_memory_addr, cfg.tr[global_pp].dec_fail_dest_addr), UVM_LOW)
            
            // 4.1 检查 offline_wbf_out_flag 标志
            if (!offwbf_tr.offline_wbf_out_flag) begin
                status = CHECK_FAIL_DATA;
                fail_reason = $sformatf(
                    "Group%0d PP[%0d] offline_wbf_out_flag not asserted (expected 1, got 0)", 
                    matched_gid, matched_pp);
                `uvm_error(get_type_name(), fail_reason)
            end
            
            if (status != CHECK_PASS) begin
                // 已有错误，跳过后续检查
            end else begin
                // 4.2 检查 plane_num 匹配
                if (offwbf_tr.plane_num != global_pp) begin
                    status = CHECK_FAIL_DATA;
                    fail_reason = $sformatf(
                        "Group%0d PP[%0d] plane_num mismatch: expected=%0d (global), got=%0d", 
                        matched_gid, matched_pp, global_pp, offwbf_tr.plane_num);
                    `uvm_error(get_type_name(), fail_reason)
                end
            end
            
            if (status != CHECK_PASS) begin
                // 已有错误，跳过后续检查
            end else begin
                // 4.3 检查 dest_sel (与 ondec.write_pos_jdg 对应)
                if (offwbf_tr.dest_sel != cfg.tr[global_pp].write_pos_jdg) begin
                    status = CHECK_FAIL_DATA;
                    fail_reason = $sformatf(
                        "Group%0d PP[%0d] dest_sel mismatch: expected=%0b, got=%0b", 
                        matched_gid, matched_pp, cfg.tr[global_pp].write_pos_jdg, offwbf_tr.dest_sel);
                    `uvm_error(get_type_name(), fail_reason)
                end
            end
            
            if (status != CHECK_PASS) begin
                // 已有错误，跳过后续检查
            end else begin
                // 4.4 检查 flip_threshold_sel
                if (offwbf_tr.flip_threshold_sel != cfg.tr[global_pp].flip_threshold_sel) begin
                    status = CHECK_FAIL_DATA;
                    fail_reason = $sformatf(
                        "Group%0d PP[%0d] flip_threshold_sel mismatch: expected=%0b, got=%0b", 
                        matched_gid, matched_pp, cfg.tr[global_pp].flip_threshold_sel, offwbf_tr.flip_threshold_sel);
                    `uvm_error(get_type_name(), fail_reason)
                end
            end
            
            if (status != CHECK_PASS) begin
                // 已有错误，跳过后续检查
            end else begin
                // 4.5 检查 over_threshold (与 ondec.syn_weight_over_threshold 对应)
                if (offwbf_tr.over_threshold != cfg.tr[global_pp].syn_weight_over_threshold) begin
                    status = CHECK_FAIL_DATA;
                    fail_reason = $sformatf(
                        "Group%0d PP[%0d] over_threshold mismatch: expected=%0b, got=%0b", 
                        matched_gid, matched_pp, cfg.tr[global_pp].syn_weight_over_threshold, offwbf_tr.over_threshold);
                    `uvm_error(get_type_name(), fail_reason)
                end
            end
            
            if (status != CHECK_PASS) begin
                // 已有错误，跳过后续检查
            end else begin
                // 4.6 检查 descramble_en
                if (offwbf_tr.descramble_en != cfg.tr[global_pp].descramble_en) begin
                    status = CHECK_FAIL_DATA;
                    fail_reason = $sformatf(
                        "Group%0d PP[%0d] descramble_en mismatch: expected=%0b, got=%0b", 
                        matched_gid, matched_pp, cfg.tr[global_pp].descramble_en, offwbf_tr.descramble_en);
                    `uvm_error(get_type_name(), fail_reason)
                end
            end
            
            if (status != CHECK_PASS) begin
                // 已有错误，跳过后续检查
            end else begin
                // 4.7 检查 descramble_seed (二次确认)
                if (descramble_seed != cfg.tr[global_pp].descramble_seed) begin
                    status = CHECK_FAIL_DATA;
                    fail_reason = $sformatf(
                        "Group%0d PP[%0d] descramble_seed mismatch: expected=%0h, got=%0h", 
                        matched_gid, matched_pp, cfg.tr[global_pp].descramble_seed, descramble_seed);
                    `uvm_error(get_type_name(), fail_reason)
                end
            end
            
            if (status != CHECK_PASS) begin
                // 已有错误，跳过后续检查
            end else begin
                // 4.8 检查 src_mem_addr (与 ondec.dec_fail_dest_addr 对应)
                if (cfg.tr[global_pp].dec_fail_dest_addr != src_mem_addr_32bit) begin
                    status = CHECK_FAIL_DATA;
                    fail_reason = $sformatf(
                        "Group%0d PP[%0d] src_mem_addr mismatch: expected=%0h, got=%0h", 
                        matched_gid, matched_pp, cfg.tr[global_pp].dec_fail_dest_addr, src_mem_addr_32bit);
                    `uvm_error(get_type_name(), fail_reason)
                end
            end
            
            if (status != CHECK_PASS) begin
                // 已有错误，跳过后续检查
            end else begin
                // 4.9 检查 dest_memory_addr (与 ondec.dest_memory_addr 对应)
                if(cfg.tr[global_pp].write_pos_jdg==1)begin//background read
                    if (cfg.tr[global_pp].dest_memory_addr != dest_mem_addr_32bit) begin
                        status = CHECK_FAIL_DATA;
                        fail_reason = $sformatf(
                            "Group%0d PP[%0d] dest_memory_addr mismatch: expected=%0h, got=%0h", 
                            matched_gid, matched_pp, cfg.tr[global_pp].dest_memory_addr, dest_mem_addr_32bit);
                        `uvm_error(get_type_name(), fail_reason)
                    end
                end
                else begin//io-read,calculated by nsu-->io_offline_wbf_addr + {out_id,12'd0};
                    // io_offline_wbf_addr + {out_id,12'd0}
                    logic [31:0] exp_io_addr;
                    logic [31:0] offwbf_base_addr='ha00;//TODO get it from global cfg---reg_write("nsu0", `NSU_REG_BASE + 'ha0, 'ha00);//offwbf success ,data output addr
                    exp_io_addr = offwbf_base_addr + {offwbf_tr.ost_id_nsu2offline, 12'd0};
                    if (dest_mem_addr_32bit != exp_io_addr) begin
                        status = CHECK_FAIL_DATA;
                        fail_reason = $sformatf(
                            "Group%0d PP[%0d] dest_mem_addr mismatch in IO-read: expected=%0h (io_offline_wbf_addr=%0h + ost_id=%0h), got=%0h",
                            matched_gid, matched_pp, exp_io_addr,
                            offwbf_base_addr, offwbf_tr.ost_id_nsu2offline,
                            dest_mem_addr_32bit);
                        `uvm_error(get_type_name(), fail_reason)
                    end
                end
            end
            
            if (status != CHECK_PASS) begin
                // 已有错误，跳过后续检查
            end else begin
                // 4.10 检查 read_mode (offwbf 只在 safe read 模式下调用)
                if (cfg.tr[global_pp].read_mode != 1'b0) begin
                    status = CHECK_FAIL_DATA;
                    fail_reason = $sformatf(
                        "Group%0d PP[%0d] offwbf called in non-safe mode: read_mode=%0b (expected 0)", 
                        matched_gid, matched_pp, cfg.tr[global_pp].read_mode);
                    `uvm_error(get_type_name(), fail_reason)
                end
            end
        end
        
        // =========================================================
        // 第五步：报告检查结果并更新状态
        // =========================================================
        if (status == CHECK_PASS) begin
            pass_count++;
            offwbf_success_count++;
            `uvm_info(get_type_name(), $sformatf("\n========== OFFWBF_CMD CHECK PASS ==========\n  Group: %0d, PP: %0d (Global PP: %0d)\n  plane_num: %0d\n  OST ID: %0h\n  InstrIdx: %0h\n  descramble_seed: %0h\n  This is OFFWBF success #%0d\n===========================================\n", matched_gid, matched_pp, matched_gid*4+matched_pp, offwbf_tr.plane_num, offwbf_tr.ost_id_nsu2offline, matched_instr_idx, descramble_seed, offwbf_success_count), UVM_LOW)
        end else begin
            fail_count++;
            offwbf_fail_count++;
            `uvm_error(get_type_name(), $sformatf("\n========== OFFWBF_CMD CHECK FAIL ==========\n  Group: %0d, PP: %0d\n  Status: %0b\n  Reason: %s\n  Total FAIL count: %0d\n============================================\n", matched_gid, matched_pp, status, fail_reason, fail_count))
        end
        
        // =========================================================
        // 第六步：清除已处理的 plane_pair 的 offline_wbf_work_en 标志
        // =========================================================
        if (match_count >= 1 && matched_instr_idx != 16'hFFFF) begin
            int global_pp = matched_gid * 4 + matched_pp;
            
            // 清除对应的 plane_pair 的 offline_wbf_work_en 标志
            pending_config[matched_instr_idx].tr[global_pp].offline_wbf_work_en = 1'b0;
            `uvm_info(get_type_name(), $sformatf("  Cleared offline_wbf_work_en for Group%0d PP[%0d] (global PP%0d)", matched_gid, matched_pp, global_pp), UVM_LOW)
            
            // 检查该 instruction_index 是否还有未处理的 offwbf 请求
            has_pending_offwbf = 1'b0;
            for (pp = 0; pp < 8; pp++) begin
                if (pending_config[matched_instr_idx].tr[pp].plane_sel && 
                    pending_config[matched_instr_idx].tr[pp].offline_wbf_work_en) begin
                    has_pending_offwbf = 1'b1;
                    break;
                end
            end
            
            // 如果没有未处理的 offwbf 请求，清除整个 instruction_index
            if (!has_pending_offwbf) begin
                pending_instr_exists[matched_instr_idx] = 1'b0;
                `uvm_info(get_type_name(), $sformatf("  No more pending offwbf for instr_idx=%0h, clearing config", matched_instr_idx), UVM_LOW)
            end else begin
                `uvm_info(get_type_name(), $sformatf("  Still has pending offwbf requests for instr_idx=%0h", matched_instr_idx), UVM_LOW)
            end
        end
    end
endtask : check_offwbf_cmd

//=============================================================================
// pack_ondec_transactions - 从 8 个 plane_pair 队列打包 transaction
// 
// 功能:
//   1. 持续监控 8 个 ondec_fifo 队列
//   2. 根据 instruction_index 将相同 instruction_index 的 8 个 transaction 打包
//   3. 打包成 ondec2nsu_group_transaction 后送入 ondec_group_cmd_fifo
//
// 打包策略:
//   - 等待 8 个队列中都有 transaction
//   - 检查 8 个 transaction 的 instruction_index 是否相同
//   - 如果相同，打包成 group_transaction 并发送到 ondec_group_cmd_fifo
//   - 如果不同，报错并丢弃
//=============================================================================
task `CLASS_NAME_DEFINE::pack_ondec_transactions();
    ondec2nsu_transaction ondec_tr [7:0];
    ondec2nsu_group_transaction group_tr;
    logic [15:0] ref_instr_idx;
    logic all_valid;
    int timeout_cnt;
    
    `uvm_info(get_type_name(), "pack_ondec_transactions task started", UVM_LOW)
    
    forever begin
        // =========================================================
        // 第一步：等待 8 个队列都有 transaction
        // =========================================================
        `uvm_info(get_type_name(), "Waiting for 8 plane_pair transactions...", UVM_LOW)
        
        // 并行从 8 个队列获取 transaction
        fork
            begin ondec_fifo[0].get(ondec_tr[0]); end
            begin ondec_fifo[1].get(ondec_tr[1]); end
            begin ondec_fifo[2].get(ondec_tr[2]); end
            begin ondec_fifo[3].get(ondec_tr[3]); end
            begin ondec_fifo[4].get(ondec_tr[4]); end
            begin ondec_fifo[5].get(ondec_tr[5]); end
            begin ondec_fifo[6].get(ondec_tr[6]); end
            begin ondec_fifo[7].get(ondec_tr[7]); end
        join
        
        `uvm_info(get_type_name(), "Received 8 plane_pair transactions", UVM_LOW)
        
        // =========================================================
        // 第二步：检查 instruction_index 是否一致
        // =========================================================
        ref_instr_idx = ondec_tr[0].instruction_index;
        all_valid = 1'b1;
        
        for (int i = 1; i < 8; i++) begin
            if (ondec_tr[i].instruction_index != ref_instr_idx) begin
                `uvm_error(get_type_name(), $sformatf(
                    "instruction_index mismatch: PP[0]=%0h, PP[%0d]=%0h", 
                    ref_instr_idx, i, ondec_tr[i].instruction_index))
                all_valid = 1'b0;
            end
        end
        
        if (!all_valid) begin
            `uvm_error(get_type_name(), "Discarding mismatched transactions")
            continue;  // 丢弃不匹配的 transaction，继续下一轮
        end
        
        `uvm_info(get_type_name(), $sformatf(
            "All 8 plane_pairs have matching instruction_index=%0h", 
            ref_instr_idx), UVM_LOW)
        
        // =========================================================
        // 第三步：打包成 ondec2nsu_group_transaction
        // =========================================================
        group_tr = ondec2nsu_group_transaction::type_id::create(
            $sformatf("group_tr_%0h", ref_instr_idx));
        
        for (int i = 0; i < 8; i++) begin
            group_tr.tr[i] = ondec_tr[i];
        end
        
        `uvm_info(get_type_name(), $sformatf(
            "Packed 8 transactions into group (instr_idx=%0h)", 
            ref_instr_idx), UVM_LOW)
        
        // =========================================================
        // 第四步：发送到 ondec_group_cmd_fifo
        // =========================================================
        ondec_group_cmd_fifo.write(group_tr);
        
        `uvm_info(get_type_name(), $sformatf(
            "Sent group transaction to ondec_group_cmd_fifo (instr_idx=%0h)", 
            ref_instr_idx), UVM_LOW)
    end
endtask : pack_ondec_transactions

`endif
