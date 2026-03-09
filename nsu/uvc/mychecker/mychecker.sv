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
    typedef struct packed {
        logic        valid;
        logic [15:0] instruction_index;
        logic [4:0]  nsu_ost_id;               // Group 独立的 OST ID
        logic [3:0]  plane_sel;                // 4 个 plane_pair 选择
        logic [3:0]  dec_suc;                  // 4 个 plane_pair 译码成功
        logic [3:0]  crc_pass;                 // 4 个 plane_pair CRC 通过
        logic [3:0]  data_out_en;              // 4 个 plane_pair 数据输出使能
        logic [3:0]  offline_wbf_work_en;      // 4 个 plane_pair offwbf 使能
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
    // 待检查的配置跟踪表 (按 instruction_index 和 group_id 索引)
    //-------------------------------------------------------------------------
    logic pending_instr_exists [bit [15:0]];  // 关联数组：标记 instruction_index 是否存在
    group_check_config_t pending_config [bit [15:0]][1:0];  // [instr_idx][group_id: 0 或 1]
    
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
        `uvm_info(get_type_name(), "ondec2nsu_checker started (GROUP-BASED processing)", UVM_MEDIUM)
        
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
    group_check_config_t grp_cfg;
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
            group_tr.tr[0].instruction_index), UVM_MEDIUM)
        
        // =========================================================
        // 第二步：按 group 处理 (Group 0: PP[0:3], Group 1: PP[4:7])
        // =========================================================
        for (int gid = 0; gid < 2; gid++) begin
            pp_base = gid * 4;  // Group 0: pp_base=0, Group 1: pp_base=4
            
            `uvm_info(get_type_name(), $sformatf("  Processing Group%0d (PP[%0d:%0d])", 
                gid, pp_base, pp_base+3), UVM_MEDIUM)
            
            // 初始化 group 配置
            grp_cfg.valid = 1'b1;
            grp_cfg.instruction_index = group_tr.tr[pp_base].instruction_index;
            grp_cfg.nsu_ost_id = group_tr.tr[pp_base].nsu_ost_id;
            grp_cfg.deep_read_sel = group_tr.tr[pp_base].deep_read_sel;
            grp_cfg.read_mode = group_tr.tr[pp_base].read_mode;
            grp_cfg.dest_memory_addr = group_tr.tr[pp_base].dest_memory_addr;
            grp_cfg.dec_fail_dest_addr = group_tr.tr[pp_base].dec_fail_dest_addr;
            grp_cfg.plane_group_block_addr = group_tr.tr[pp_base].plane_group_block_addr;
            grp_cfg.page_addr_plane_group = group_tr.tr[pp_base].page_addr_plane_group;
            
            // 提取 4 个 plane_pair 的状态
            grp_cfg.plane_sel = '0;
            grp_cfg.dec_suc = '0;
            grp_cfg.crc_pass = '0;
            grp_cfg.data_out_en = '0;
            grp_cfg.offline_wbf_work_en = '0;
            
            for (int pp = 0; pp < 4; pp++) begin
                grp_cfg.plane_sel[pp] = group_tr.tr[pp_base + pp].plane_sel;
                grp_cfg.dec_suc[pp] = group_tr.tr[pp_base + pp].dec_suc;
                grp_cfg.crc_pass[pp] = group_tr.tr[pp_base + pp].crc_pass;
                grp_cfg.data_out_en[pp] = group_tr.tr[pp_base + pp].data_out_en;
                grp_cfg.offline_wbf_work_en[pp] = group_tr.tr[pp_base + pp].offline_wbf_work_en;
            end
            
            `uvm_info(get_type_name(), $sformatf("    Group%0d: ost_id=%0h, plane_sel=%04b, dec_suc=%04b, crc_pass=%04b, data_out_en=%04b", 
                gid, grp_cfg.nsu_ost_id, grp_cfg.plane_sel, grp_cfg.dec_suc, grp_cfg.crc_pass, grp_cfg.data_out_en), UVM_HIGH)
            
            // =========================================================
            // 第三步：判断 group 需要什么响应
            // =========================================================
            group_need_deep_resp = 1'b0;
            group_need_offwbf = 1'b0;
            
            // 遍历 group 内 4 个 plane_pair，判断是否需要 deep_resp 或 offwbf
            for (int pp = 0; pp < 4; pp++) begin
                if (!grp_cfg.plane_sel[pp]) continue;  // 跳过未选择的 plane_pair
                
                if (!grp_cfg.dec_suc[pp] && grp_cfg.crc_pass[pp]) begin
                    // 译码失败但 CRC 成功
                    if (!grp_cfg.data_out_en[pp]) begin
                        // 数据不输出 → 需要上报 deep_resp
                        group_need_deep_resp = 1'b1;
                        `uvm_info(get_type_name(), $sformatf("    PP[%0d]: decode_fail+crc_success+no_data → Group%0d need DEEP_READ_RESP", 
                            pp_base+pp, gid), UVM_LOW)
                    end else begin
                        // 数据输出 → 需要调用 offwbf
                        group_need_offwbf = 1'b1;
                        `uvm_info(get_type_name(), $sformatf("    PP[%0d]: decode_fail+crc_success+data → Group%0d need OFFWBF_CMD", 
                            pp_base+pp, gid), UVM_LOW)
                    end
                end
            end
            
            // 记录判断结果
            if (group_need_deep_resp) begin
                `uvm_info(get_type_name(), $sformatf("  Group%0d: Will expect DEEP_READ_RESP (ost_id=%0h)", 
                    gid, grp_cfg.nsu_ost_id), UVM_LOW)
            end
            if (group_need_offwbf) begin
                `uvm_info(get_type_name(), $sformatf("  Group%0d: Will expect OFFWBF_CMD (ost_id=%0h)", 
                    gid, grp_cfg.nsu_ost_id), UVM_LOW)
            end
            if (!group_need_deep_resp && !group_need_offwbf) begin
                `uvm_info(get_type_name(), $sformatf("  Group%0d: No action needed (all decode success or crc_fail)", 
                    gid), UVM_HIGH)
            end
            
            // =========================================================
            // 第四步：注册期望配置
            // =========================================================
            pending_config[grp_cfg.instruction_index][gid] = grp_cfg;
        end
        
        // 记录 pending instruction index (使用关联数组标记存在)
        pending_instr_exists[group_tr.tr[0].instruction_index] = 1'b1;
        
        `uvm_info(get_type_name(), $sformatf("Registered config for instr_idx=%0h (2 groups, waiting for resp/offwbf)", 
            group_tr.tr[0].instruction_index), UVM_MEDIUM)
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
    group_check_config_t cfg;
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
                cfg = pending_config[resp.instruction_index][gid];
                
                if (!cfg.valid) continue;
                
                // 根据 group_id 获取 resp 中对应的 ost_id
                if (gid == 0) begin
                    resp_ost_id = resp.group0_ost_id;
                end else begin
                    resp_ost_id = resp.group1_ost_id;
                end
                
                // 检查 ost_id 是否匹配 (group 独立的关键)
                if (cfg.nsu_ost_id == resp_ost_id) begin
                    matched_gid = gid;
                    
                    `uvm_info(get_type_name(), $sformatf("  Matched Group%0d (ost_id=%0h)", 
                        gid, cfg.nsu_ost_id), UVM_HIGH)
                    
                    // 遍历 group 内 4 个 plane_pair 进行检查
                    for (int pp = 0; pp < 4; pp++) begin
                        if (!cfg.plane_sel[pp]) continue;  // 跳过未选择的 plane_pair
                        
                        // 只检查期望上报 deep_resp 的 plane_pair
                        if (!cfg.dec_suc[pp] && cfg.crc_pass[pp]) begin
                            pp_idx = gid * 4 + pp;  // 全局 plane_pair 索引
                            
                            // 检查译码状态 (plane_pair_ondec_flag: 0=成功，1=失败)
                            if (cfg.dec_suc[pp] != !resp.plane_pair_ondec_flag[pp_idx]) begin
                                status = CHECK_FAIL_DECODE;
                                fail_reason = $sformatf("Group%0d PP[%0d] decode mismatch: expected=%0b, got=%0b", 
                                    gid, pp, cfg.dec_suc[pp], !resp.plane_pair_ondec_flag[pp_idx]);
                                break;
                            end
                            
                            // 检查 CRC 状态 (plane_crc_err: 1=成功，0=失败)
                            if (cfg.crc_pass[pp] != resp.plane_crc_err[pp_idx]) begin
                                status = CHECK_FAIL_CRC;
                                fail_reason = $sformatf("Group%0d PP[%0d] CRC mismatch: expected=%0b, got=%0b", 
                                    gid, pp, cfg.crc_pass[pp], resp.plane_crc_err[pp_idx]);
                                break;
                            end
                        end
                    end
                    
                    // 检查 deep_read_sel
                    if (cfg.deep_read_sel != resp.deep_read_sel) begin
                        status = CHECK_FAIL_DATA;
                        fail_reason = $sformatf("Group%0d deep_read_sel mismatch: expected=%0b, got=%0b", 
                            gid, cfg.deep_read_sel, resp.deep_read_sel);
                    end
                    
                    // 检查 read_mode
                    if (cfg.read_mode != resp.read_mode) begin
                        status = CHECK_FAIL_DATA;
                        fail_reason = $sformatf("Group%0d read_mode mismatch: expected=%0b, got=%0b", 
                            gid, cfg.read_mode, resp.read_mode);
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
                pending_config[resp.instruction_index][matched_gid].valid = 1'b0;
            end
        end else begin
            `uvm_warning(get_type_name(), $sformatf("DEEP_READ_RESP: No matching config for instr_idx=%0h", 
                resp.instruction_index))
        end
    end
endtask : check_deep_read_resp

//-----------------------------------------------------------------------------
// check_offwbf_cmd - 检查 NSU 下发给 OFFWBF 的指令
// 
// 检查内容 (按 group 独立检查):
// 1. ost_id_nsu2offline 匹配 (group 独立)
// 2. src_mem_addr (与 dest_memory_addr 比较)
// 3. dest_mem_addr (与 dec_fail_dest_addr 比较)
// 4. offline_wbf_out_flag 标志
// 5. read_mode (offwbf 只在 safe read 下调用)
//-----------------------------------------------------------------------------
task `CLASS_NAME_DEFINE::check_offwbf_cmd();
    offdec2nsu_transaction offwbf_tr;
    check_status_e status;
    string fail_reason;
    int matched_gid;
    bit [15:0] matched_instr_idx;
    bit [15:0] p_instr_idx;
    int p_gid;
    group_check_config_t cfg;
    logic [31:0] src_mem_addr_32bit;
    logic [31:0] dest_mem_addr_32bit;
    forever begin
        offwbf_cmd_fifo.get(offwbf_tr);
        total_offwbf_count++;
        
        // 组合 32bit 地址
        src_mem_addr_32bit = {offwbf_tr.src_mem_addr_3, offwbf_tr.src_mem_addr_2, 
                              offwbf_tr.src_mem_addr_1, offwbf_tr.src_mem_addr_0};
        dest_mem_addr_32bit = {offwbf_tr.dest_mem_addr_3, offwbf_tr.dest_mem_addr_2, 
                               offwbf_tr.dest_mem_addr_1, offwbf_tr.dest_mem_addr_0};
        
        `uvm_info(get_type_name(), $sformatf("Received OFFWBF_CMD: ost_id=%0h, src_addr=%0h, dest_addr=%0h, offline_wbf_out_flag=%0b", 
            offwbf_tr.ost_id_nsu2offline, src_mem_addr_32bit, dest_mem_addr_32bit, offwbf_tr.offline_wbf_out_flag), UVM_LOW)
        
        // 查找匹配的期望配置 (通过地址匹配)
        status = CHECK_PASS;
        fail_reason = "";
        matched_gid = -1;
        matched_instr_idx = 16'hFFFF;
        
        // 遍历所有 pending 的 instruction_index 和 group
        foreach (pending_config[p_instr_idx][p_gid]) begin
            cfg = pending_config[p_instr_idx][p_gid];
            
            if (!cfg.valid) continue;
            if (!cfg.offline_wbf_work_en[p_gid]) continue;  // 只检查需要 offwbf 的 group
            
            // 通过地址匹配 (而不是 ost_id，因为 NSU 会重新生成 ost_id)
            // offwbf 的 src_mem_addr 应该匹配 ondec 的 dest_memory_addr
            // offwbf 的 dest_mem_addr 应该匹配 ondec 的 dec_fail_dest_addr
            if (cfg.dest_memory_addr == src_mem_addr_32bit && 
                cfg.dec_fail_dest_addr == dest_mem_addr_32bit) begin
                matched_gid = p_gid;
                matched_instr_idx = p_instr_idx;
                
                `uvm_info(get_type_name(), $sformatf("  Matched Group%0d (instr_idx=%0h, addr=%0h)", 
                    p_gid, p_instr_idx, src_mem_addr_32bit), UVM_HIGH)
                
                // 检查 offline_wbf_out_flag 标志
                if (!offwbf_tr.offline_wbf_out_flag) begin
                    status = CHECK_FAIL_DATA;
                    fail_reason = $sformatf("Group%0d offline_wbf_out_flag not asserted", p_gid);
                    break;
                end
                
                // 检查 read_mode (offwbf 只在 safe read 模式下调用)
                if (cfg.read_mode != 1'b0) begin
                    status = CHECK_FAIL_DATA;
                    fail_reason = $sformatf("Group%0d offwbf called in non-safe mode: read_mode=%0b", 
                        p_gid, cfg.read_mode);
                    break;
                end
                
                break;  // 找到匹配的 group 后退出
            end
        end
        
        // 报告结果
        if (status == CHECK_PASS) begin
            pass_count++;
            offwbf_success_count++;
            `uvm_info(get_type_name(), $sformatf("OFFWBF_CMD CHECK PASS: Group%0d (ost_id=%0h, instr_idx=%0h)", 
                matched_gid, offwbf_tr.ost_id_nsu2offline, matched_instr_idx), UVM_LOW)
        end else begin
            fail_count++;
            offwbf_fail_count++;
            `uvm_error(get_type_name(), $sformatf("OFFWBF_CMD CHECK FAIL: Group%0d, status=%0b, reason=%s", 
                matched_gid, status, fail_reason))
        end
        
        // 清除已检查的 group 配置
        if (matched_gid >= 0 && matched_instr_idx != 16'hFFFF) begin
            pending_config[matched_instr_idx][matched_gid].valid = 1'b0;
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
    
    `uvm_info(get_type_name(), "pack_ondec_transactions task started", UVM_MEDIUM)
    
    forever begin
        // =========================================================
        // 第一步：等待 8 个队列都有 transaction
        // =========================================================
        `uvm_info(get_type_name(), "Waiting for 8 plane_pair transactions...", UVM_HIGH)
        
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
        
        `uvm_info(get_type_name(), "Received 8 plane_pair transactions", UVM_HIGH)
        
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
            ref_instr_idx), UVM_MEDIUM)
        
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
            ref_instr_idx), UVM_MEDIUM)
        
        // =========================================================
        // 第四步：发送到 ondec_group_cmd_fifo
        // =========================================================
        ondec_group_cmd_fifo.write(group_tr);
        
        `uvm_info(get_type_name(), $sformatf(
            "Sent group transaction to ondec_group_cmd_fifo (instr_idx=%0h)", 
            ref_instr_idx), UVM_HIGH)
    end
endtask : pack_ondec_transactions

`endif
