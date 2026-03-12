`ifndef MYCHECKER_SV
`define MYCHECKER_SV

//=============================================================================
// mychecker.sv - ONDEC2NSU Checker (Group Independent Processing Version)
//=============================================================================
// 3-step check flow:
// 1. Get ondec2nsu_group_transaction (8 plane_pairs = 2 groups)
// 2. Group-based judgment: Check dec_suc, crc_pass, data_out_en per group
// 3. Find matching transaction from queues for comparison
//
// Group division:
//   - Group 0: plane_pair[0:3], ost_id = tr[0].nsu_ost_id
//   - Group 1: plane_pair[4:7], ost_id = tr[4].nsu_ost_id
//
// nsu2cpu_deep_resp_transaction fields:
//   - group0_ost_id: OST ID for Group 0
//   - group1_ost_id: OST ID for Group 1
//=============================================================================
typedef class offdec2nsu_transaction;  // Forward declaration (avoid circular dependency)
package ondec2nsu_checker_pkg;
    
    //=========================================================================
    // Check status enumeration
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
    // Group check configuration (independent per group)
    // Group 0: plane_pair[0:3], Group 1: plane_pair[4:7]
    //=========================================================================
    typedef struct  {
        logic        valid;
        logic [15:0] instruction_index;
        logic [4:0]  nsu_ost_id;               // Group-specific OST ID
        logic [3:0]  plane_sel;                // 4 plane_pair selection
        logic [3:0]  dec_suc;                  // 4 plane_pair decode success
        logic [3:0]  crc_pass;                 // 4 plane_pair CRC pass
        logic [3:0]  data_out_en;              // 4 plane_pair data output enable
        logic [3:0]  offline_wbf_work_en;      // 4 plane_pair offwbf enable
        logic [3:0]  flip_threshold_sel;       // 4 plane_pair flip threshold select
        logic [3:0]  syn_weight_over_threshold; // 4 plane_pair sync weight over threshold
        logic [3:0]  descramble_en;            // 4 plane_pair descramble enable
        logic [15:0] descramble_seed [4];      // 4 plane_pair descramble seed
        logic [3:0]  write_pos_jdg;            // 4 plane_pair write position judgment
        logic        deep_read_sel;            // Deep read select (consistent in group)
        logic        read_mode;                // Read mode (consistent in group)
        logic [31:0] dest_memory_addr;         // Target memory address (group_0_dest_memory_addr)
        logic [31:0] dec_fail_dest_addr;       // Decode fail target address (dec_fail_dest_addr_0)
        logic [15:0] plane_group_block_addr;   // Block address (group0_block_addr)
        logic [11:0] page_addr_plane_group;    // Page address (page_address_plane_group_0)
    } group_check_config_t;

endpackage
`define CLASS_NAME_DEFINE ondec2nsu_checker

//=============================================================================
// ondec2nsu_checker class definition
//=============================================================================
class `CLASS_NAME_DEFINE extends uvm_component;

    `uvm_component_utils(`CLASS_NAME_DEFINE)

    import ondec2nsu_checker_pkg::*;

    //-------------------------------------------------------------------------
    // FIFO definitions
    //-------------------------------------------------------------------------
    // Input queue for 8 plane_pair ondec2nsu_transaction
    uvm_tlm_analysis_fifo #(ondec2nsu_transaction) ondec_fifo [8];
    
    // ondec_cmd FIFO - Output: Packed ondec2nsu_group_transaction (8 plane_pairs = 2 groups)
    uvm_tlm_analysis_fifo #(ondec2nsu_group_transaction) ondec_group_cmd_fifo;
    
    // deep_read_resp FIFO - Input: Deep read response from NSU to CPU
    uvm_tlm_analysis_fifo #(nsu2cpu_deep_resp_transaction) deep_read_resp_fifo;
    
    // offwbf_cmd FIFO - Input: Command from NSU to OFFWBF
    uvm_tlm_analysis_fifo #(offdec2nsu_transaction) offwbf_cmd_fifo;
    
    //-------------------------------------------------------------------------
    // Pending config tracking table (indexed by instruction_index)
    //-------------------------------------------------------------------------
    logic pending_instr_exists [bit [15:0]];  // Associative array: Mark if instruction_index exists
    ondec2nsu_group_transaction pending_config [bit [15:0]];  // [instr_idx] → Full group transaction
    
    //-------------------------------------------------------------------------
    // Statistics counters
    //-------------------------------------------------------------------------
    int unsigned total_cmd_count = 0;
    int unsigned total_resp_count = 0;
    int unsigned total_offwbf_count = 0;
    int unsigned pass_count = 0;
    int unsigned fail_count = 0;
    
    // Group statistics (independent per group)
    int unsigned group_decode_success [1:0];
    int unsigned group_decode_fail [1:0];
    int unsigned group_crc_err [1:0];
    int unsigned group_lba_mismatch [1:0];
    int unsigned offwbf_success_count = 0;
    int unsigned offwbf_fail_count = 0;
    
    //-------------------------------------------------------------------------
    // Task declarations (inside class)
    //-------------------------------------------------------------------------
    extern virtual task pack_ondec_transactions();  // New: Pack transactions from 8 queues
    extern virtual task check_ondec_cmd();      // Step 1: Get ondec_cmd, judge by group
    extern virtual task check_deep_read_resp(); // Step 2: Check deep read response
    extern virtual task check_offwbf_cmd();     // Step 3: Check offwbf command
    
    //-------------------------------------------------------------------------
    // Constructor
    //-------------------------------------------------------------------------
    function new(string name = "ondec2nsu_checker", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new
    
    //-------------------------------------------------------------------------
    // build_phase
    //-------------------------------------------------------------------------
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Initialize 8 plane_pair FIFOs
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
            pack_ondec_transactions();  // New: Pack transactions from 8 queues
            check_ondec_cmd();      // Step 1: Get ondec_cmd, judge by group
            check_deep_read_resp(); // Step 2: Check deep read response
            check_offwbf_cmd();     // Step 3: Check offwbf command
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
    // final_phase - Check if all FIFO queues are empty
    //-------------------------------------------------------------------------
    virtual function void final_phase(uvm_phase phase);
        int unsigned fifo_size;
        bit has_unprocessed;

        has_unprocessed = 1'b0;

        // Check 8 ondec_fifo queues
        for (int i = 0; i < 8; i++) begin
            fifo_size = ondec_fifo[i].used();
            if (fifo_size > 0) begin
                `uvm_error(get_type_name(), $sformatf("FINAL_CHECK: ondec_fifo[%0d] is not empty, has %0d unprocessed transactions", 
                    i, fifo_size))
                has_unprocessed = 1'b1;
            end
        end

        // Check ondec_group_cmd_fifo queue
        fifo_size = ondec_group_cmd_fifo.used();
        if (fifo_size > 0) begin
            `uvm_error(get_type_name(), $sformatf("FINAL_CHECK: ondec_group_cmd_fifo is not empty, has %0d unprocessed transactions", 
                fifo_size))
            has_unprocessed = 1'b1;
        end

        // Check deep_read_resp_fifo queue
        fifo_size = deep_read_resp_fifo.used();
        if (fifo_size > 0) begin
            `uvm_error(get_type_name(), $sformatf("FINAL_CHECK: deep_read_resp_fifo is not empty, has %0d unprocessed transactions", 
                fifo_size))
            has_unprocessed = 1'b1;
        end

        // Check offwbf_cmd_fifo queue
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
// Task Implementations (outside class)
//=============================================================================

//-----------------------------------------------------------------------------
// check_ondec_cmd - Get ondec2nsu_group_transaction, judge by group and register expectations
// 
// Group division:
//   - Group 0: plane_pair[0:3], ost_id = tr[0].nsu_ost_id
//   - Group 1: plane_pair[4:7], ost_id = tr[4].nsu_ost_id
//
// Judgment logic (independent per group):
//   Iterate 4 plane_pairs in group:
//   - If any plane_pair meets (dec_suc=0 && crc_pass=1 && data_out_en=0)
//     → Group needs to report deep_resp
//   - If any plane_pair meets (dec_suc=0 && crc_pass=1 && data_out_en=1)
//     → Group needs to call offwbf
//-----------------------------------------------------------------------------
task `CLASS_NAME_DEFINE::check_ondec_cmd();
    ondec2nsu_group_transaction group_tr;
    int pp_base;
    logic group_need_deep_resp;
    logic group_need_offwbf;
    
    forever begin
        // =========================================================
        // Step 1: Get ondec2nsu_group_transaction
        // =========================================================
        ondec_group_cmd_fifo.get(group_tr);
        total_cmd_count++;
        
        `uvm_info(get_type_name(), $sformatf("Received ONDEC_GROUP: instr_idx=%0h", 
            group_tr.tr[0].instruction_index), UVM_LOW)
        
        // =========================================================
        // Step 2: Process by group (Group 0: PP[0:3], Group 1: PP[4:7])
        // =========================================================
        for (int gid = 0; gid < 2; gid++) begin
            pp_base = gid * 4;  // Group 0: pp_base=0, Group 1: pp_base=4
            
            `uvm_info(get_type_name(), $sformatf("  Processing Group%0d (PP[%0d:%0d])", 
                gid, pp_base, pp_base+3), UVM_LOW)
            
            // =========================================================
            // Step 3: Judge required responses for group
            // =========================================================
            group_need_deep_resp = 1'b0;
            group_need_offwbf = 1'b0;
            
            // Iterate 4 plane_pairs in group to judge deep_resp/offwbf need
            for (int pp = 0; pp < 4; pp++) begin
                if (!group_tr.tr[pp_base + pp].plane_sel) continue;  // Skip unselected plane_pair
                
                if (!group_tr.tr[pp_base + pp].dec_suc && group_tr.tr[pp_base + pp].crc_pass) begin
                    // Decode fail but CRC success
                    if (!group_tr.tr[pp_base + pp].data_out_en) begin
                        // No data output → Need deep_resp report
                        group_need_deep_resp = 1'b1;
                        `uvm_info(get_type_name(), $sformatf("    PP[%0d]: decode_fail+crc_success+no_data → Group%0d need DEEP_READ_RESP", 
                            pp_base+pp, gid), UVM_LOW)
                    end else begin
                        // Data output → Need offwbf call
                        group_need_offwbf = 1'b1;
                        group_tr.tr[pp_base + pp].offline_wbf_work_en = 1'b1;  // Set flag for offwbf-needed plane_pair
                        `uvm_info(get_type_name(), $sformatf("    PP[%0d]: decode_fail+crc_success+data → Group%0d need OFFWBF_CMD", 
                            pp_base+pp, gid), UVM_LOW)
                    end
                end
            end
            
            // Record judgment results
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
        
        // Record pending instruction index (mark existence via associative array) and save full group transaction
        pending_instr_exists[group_tr.tr[0].instruction_index] = 1'b1;
        pending_config[group_tr.tr[0].instruction_index] = group_tr;
        
        `uvm_info(get_type_name(), $sformatf("Registered config for instr_idx=%0h (8 plane_pairs, waiting for resp/offwbf)", 
            group_tr.tr[0].instruction_index), UVM_LOW)
    end
endtask : check_ondec_cmd

//-----------------------------------------------------------------------------
// check_deep_read_resp - Check deep read response from NSU to CPU
// 
// Check items (independent per group):
// 1. instruction_index match
// 2. group0_ost_id / group1_ost_id match (group-specific)
// 3. plane_pair_dec_result[7:0] (compare with dec_suc)
// 4. plane_pair_crc_result[7:0] (compare with crc_pass)
// 5. plane_pair_lba_comp[7:0] (LBA comparison)
// 6. plane_pair_ecc_result[7:0] (compare with ecc result)
// 7. deep_read_sel and safe_fast_read (read_mode)
// 8. group0_block_addr / group1_block_addr
// 9. group0_page_addr / group1_page_addr
// 10. group0_meta_index_LBA / group1_meta_index_LBA
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
        
        `uvm_info(get_type_name(), $sformatf("Received DEEP_READ_RESP: instr_idx=%0h, pp_dec_result=%08b, pp_crc_result=%08b, pp_lba_comp=%08b", 
            resp.instruction_index, resp.plane_pair_dec_result, resp.plane_pair_crc_result, resp.plane_pair_lba_comp), UVM_LOW)
        
        // Find matching expected config
        if (pending_instr_exists[resp.instruction_index]) begin
            status = CHECK_PASS;
            fail_reason = "";
            matched_gid = -1;
            
            // Iterate 2 groups to find matching group (via ost_id)
            for (int gid = 0; gid < 2; gid++) begin
                cfg = pending_config[resp.instruction_index];
                pp_base = gid * 4;  // Group 0: pp_base=0, Group 1: pp_base=4
                
                // Get corresponding ost_id from resp by group_id
                if (gid == 0) begin
                    resp_ost_id = resp.group0_ost_id;
                end else begin
                    resp_ost_id = resp.group1_ost_id;
                end
                
                // Check ost_id match (key for group independence)
                if (cfg.tr[pp_base].nsu_ost_id == resp_ost_id) begin
                    matched_gid = gid;
                    
                    `uvm_info(get_type_name(), $sformatf("  Matched Group%0d (ost_id=%0h)", 
                        gid, cfg.tr[pp_base].nsu_ost_id), UVM_LOW)
                    
                    // Iterate 4 plane_pairs in group for checks
                    for (int pp = 0; pp < 4; pp++) begin
                        if (!cfg.tr[pp_base + pp].plane_sel) continue;  // Skip unselected plane_pair
                        
                        // Only check plane_pairs expected to report deep_resp (dec_suc=0 && crc_pass=1)
                        if (!cfg.tr[pp_base + pp].dec_suc && cfg.tr[pp_base + pp].crc_pass) begin
                            pp_idx = gid * 4 + pp;  // Global plane_pair index
                            
                            // Check decode status (plane_pair_dec_result: 1=success, 0=fail)
                            if (cfg.tr[pp_base + pp].dec_suc != resp.plane_pair_dec_result[pp_idx]) begin
                                status = CHECK_FAIL_DECODE;
                                fail_reason = $sformatf("Group%0d PP[%0d] decode mismatch: expected=%0b, got=%0b", 
                                    gid, pp, cfg.tr[pp_base + pp].dec_suc, resp.plane_pair_dec_result[pp_idx]);
                                break;
                            end
                            
                            // Check CRC status (plane_pair_crc_result: 1=success, 0=fail)
                            if (cfg.tr[pp_base + pp].crc_pass != resp.plane_pair_crc_result[pp_idx]) begin
                                status = CHECK_FAIL_CRC;
                                fail_reason = $sformatf("Group%0d PP[%0d] CRC mismatch: expected=%0b, got=%0b", 
                                    gid, pp, cfg.tr[pp_base + pp].crc_pass, resp.plane_pair_crc_result[pp_idx]);
                                break;
                            end
                            
                            // Check LBA comparison result (plane_pair_lba_comp: 1=mismatch, 0=match)
                            if (cfg.tr[pp_base + pp].error_flag && !resp.plane_pair_lba_comp[pp_idx]) begin
                                status = CHECK_FAIL_LBA;
                                fail_reason = $sformatf("Group%0d PP[%0d] LBA comp mismatch: expected mismatch but got match", 
                                    gid, pp);
                                break;
                            end
                            
                            // Check ECC result (plane_pair_ecc_result: 1=correctable, 0=uncorrectable)
                            if (!cfg.tr[pp_base + pp].dec_suc && resp.plane_pair_ecc_result[pp_idx]) begin
                                `uvm_info(get_type_name(), $sformatf("  Group%0d PP[%0d]: ECC correction successful", 
                                    gid, pp), UVM_LOW)
                            end
                        end
                    end
                    
                    // Check deep_read_sel
                    if (cfg.tr[pp_base].deep_read_sel != resp.deep_read_sel) begin
                        status = CHECK_FAIL_DATA;
                        fail_reason = $sformatf("Group%0d deep_read_sel mismatch: expected=%0b, got=%0b", 
                            gid, cfg.tr[pp_base].deep_read_sel, resp.deep_read_sel);
                    end
                    
                    // Check read_mode (safe_fast_read corresponds to read_mode)
                    if (cfg.tr[pp_base].read_mode != resp.safe_fast_read) begin
                        status = CHECK_FAIL_DATA;
                        fail_reason = $sformatf("Group%0d read_mode mismatch: expected=%0b, got=%0b", 
                            gid, cfg.tr[pp_base].read_mode, resp.safe_fast_read);
                    end
                    
                    // Check block_addr (consistent within group)
                    if (cfg.tr[pp_base].plane_group_block_addr != resp.group0_block_addr && gid == 0) begin
                        status = CHECK_FAIL_DATA;
                        fail_reason = $sformatf("Group%0d block_addr mismatch: expected=%0h, got=%0h", 
                            gid, cfg.tr[pp_base].plane_group_block_addr, resp.group0_block_addr);
                    end
                    if (cfg.tr[pp_base].plane_group_block_addr != resp.group1_block_addr && gid == 1) begin
                        status = CHECK_FAIL_DATA;
                        fail_reason = $sformatf("Group%0d block_addr mismatch: expected=%0h, got=%0h", 
                            gid, cfg.tr[pp_base].plane_group_block_addr, resp.group1_block_addr);
                    end
                    
                    // Check page_addr (consistent within group)
                    if (cfg.tr[pp_base].page_addr_plane_group != resp.group0_page_addr && gid == 0) begin
                        status = CHECK_FAIL_DATA;
                        fail_reason = $sformatf("Group%0d page_addr mismatch: expected=%0h, got=%0h", 
                            gid, cfg.tr[pp_base].page_addr_plane_group, resp.group0_page_addr);
                    end
                    if (cfg.tr[pp_base].page_addr_plane_group != resp.group1_page_addr && gid == 1) begin
                        status = CHECK_FAIL_DATA;
                        fail_reason = $sformatf("Group%0d page_addr mismatch: expected=%0h, got=%0h", 
                            gid, cfg.tr[pp_base].page_addr_plane_group, resp.group1_page_addr);
                    end
                    
                    // Check meta_index_LBA (consistent within group)
                    if (cfg.tr[pp_base].lba[22:0] != resp.group0_meta_index_LBA && gid == 0) begin
                        status = CHECK_FAIL_DATA;
                        fail_reason = $sformatf("Group%0d meta_index_LBA mismatch: expected=%0h, got=%0h", 
                            gid, cfg.tr[pp_base].lba[22:0], resp.group0_meta_index_LBA);
                    end
                    if (cfg.tr[pp_base].lba[22:0] != resp.group1_meta_index_LBA && gid == 1) begin
                        status = CHECK_FAIL_DATA;
                        fail_reason = $sformatf("Group%0d meta_index_LBA mismatch: expected=%0h, got=%0h", 
                            gid, cfg.tr[pp_base].lba[22:0], resp.group1_meta_index_LBA);
                    end
                    
                    break;  // Exit after finding matching group
                end
            end
            
            // Update statistics (per group)
            if (matched_gid >= 0) begin
                for (int pp = 0; pp < 4; pp++) begin
                    pp_idx = matched_gid * 4 + pp;
                    // plane_pair_dec_result: 1=success, 0=fail
                    if (resp.plane_pair_dec_result[pp_idx]) begin
                        group_decode_success[matched_gid]++;
                    end else begin
                        group_decode_fail[matched_gid]++;
                    end
                    // plane_pair_crc_result: 1=success, 0=fail
                    if (resp.plane_pair_crc_result[pp_idx]) begin
                        group_crc_err[matched_gid]++;
                    end
                    // plane_pair_lba_comp: 1=mismatch
                    if (resp.plane_pair_lba_comp[pp_idx]) begin
                        group_lba_mismatch[matched_gid]++;
                    end
                end
            end
            
            // Report results
            if (status == CHECK_PASS) begin
                pass_count++;
                `uvm_info(get_type_name(), $sformatf("DEEP_READ_RESP CHECK PASS: instr_idx=%0h, Group%0d (ost_id=%0h)", 
                    resp.instruction_index, matched_gid, resp_ost_id), UVM_LOW)
            end else begin
                fail_count++;
                `uvm_error(get_type_name(), $sformatf("DEEP_READ_RESP CHECK FAIL: instr_idx=%0h, Group%0d, status=%0b, reason=%s", 
                    resp.instruction_index, matched_gid, status, fail_reason))
            end
            
            // Clear checked group config
            if (matched_gid >= 0) begin
                pending_instr_exists[resp.instruction_index] = 1'b0;
            end
        end else begin
            `uvm_warning(get_type_name(), $sformatf("DEEP_READ_RESP: No matching config for instr_idx=%0h", 
                resp.instruction_index))
        end
    end
endtask : check_deep_read_resp

//-----------------------------------------------------------------------------
// check_offwbf_cmd - Check command from NSU to OFFWBF (descramble_seed-based match)
// 
// Check flow:
// 1. Get valid offwbf_cmd from test environment
// 2. Find matching ondec_group_cmd in pending_config via descramble_seed
// 3. Issue UVM warning if multiple offwbf_cmd match same descramble_seed
// 4. Perform comprehensive check on uniquely matched offwbf_cmd
//
// Check items (independent per plane):
// 1. Exact descramble_seed match (primary match condition)
// 2. plane_num match (corresponds to plane in ondec)
// 3. dest_sel match (corresponds to ondec.write_pos_jdg)
// 4. flip_threshold_sel match (corresponds to ondec.flip_threshold_sel)
// 5. over_threshold match (corresponds to ondec.syn_weight_over_threshold)
// 6. descramble_en match (corresponds to ondec.descramble_en)
// 7. src_mem_addr match (corresponds to ondec.dest_memory_addr)
// 8. dest_mem_addr match (corresponds to ondec.dec_fail_dest_addr)
// 9. offline_wbf_out_flag
// 10. read_mode (offwbf only called in safe read)
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
    int matched_pp_list [$];  // Store all matched plane_pair indices
    int matched_cfg_idx [$];  // Store all matched config indices
    
    forever begin
        // =========================================================
        // Step 1: Get valid offwbf_cmd from test environment/interface
        // Ensure complete command info and required parameters
        // =========================================================
        offwbf_cmd_fifo.get(offwbf_tr);
        total_offwbf_count++;
        
        // Combine 32-bit address
        src_mem_addr_32bit = {offwbf_tr.src_mem_addr_3, offwbf_tr.src_mem_addr_2, 
                              offwbf_tr.src_mem_addr_1, offwbf_tr.src_mem_addr_0};
        dest_mem_addr_32bit = {offwbf_tr.dest_mem_addr_3, offwbf_tr.dest_mem_addr_2, 
                               offwbf_tr.dest_mem_addr_1, offwbf_tr.dest_mem_addr_0};
        
        // Combine 16-bit descramble_seed
        descramble_seed = {offwbf_tr.descramble_seed_1, offwbf_tr.descramble_seed_0};
        
        `uvm_info(get_type_name(), $sformatf( "\n========== Received OFFWBF_CMD #%0d ==========\n plane_num: %0d\n ost_id_nsu2offline: %0h\n src_mem_addr (32bit): %0h\n dest_mem_addr (32bit): %0h\n descramble_seed: %0h\n offline_wbf_out_flag: %0b\n=============================================\n", total_offwbf_count, offwbf_tr.plane_num, offwbf_tr.ost_id_nsu2offline, src_mem_addr_32bit, dest_mem_addr_32bit, descramble_seed, offwbf_tr.offline_wbf_out_flag), UVM_LOW)
        
        // =========================================================
        // Step 2: Find matching ondec_group_cmd in pending_config via descramble_seed
        // Implement exact match logic for descramble_seed
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
        
        // Iterate all pending instruction_index to collect descramble_seed matches
        foreach (pending_config[p_instr_idx]) begin
            cfg = pending_config[p_instr_idx];
            
            // Iterate all 8 plane_pairs to find descramble_seed match
            for (pp = 0; pp < 8; pp++) begin
                if (!cfg.tr[pp].plane_sel) begin
                    `uvm_info(get_type_name(), $sformatf("  Skipping instr_idx=%0h, PP[%0d]: plane_sel=0 (not selected)", p_instr_idx, pp), UVM_LOW)
                    continue;  // Skip unselected plane_pair
                end

                if (!cfg.tr[pp].offline_wbf_work_en) begin
                    `uvm_info(get_type_name(), $sformatf("  Skipping instr_idx=%0h, PP[%0d]: offline_wbf_work_en=0 (no offwbf needed)", p_instr_idx, pp), UVM_LOW)
                    continue;  // Skip plane_pair not needing offwbf
                end

                // Check descramble_en (must be enabled for descramble_seed match)
                if (!cfg.tr[pp].descramble_en) begin
                    `uvm_info(get_type_name(), $sformatf("  Skipping instr_idx=%0h, PP[%0d]: descramble_en=0 (descramble disabled)", p_instr_idx, pp), UVM_LOW)
                    continue;
                end
                
                // Exact descramble_seed match
                if (descramble_seed == cfg.tr[pp].descramble_seed) begin
                    `uvm_info(get_type_name(), $sformatf("  >>> MATCH FOUND: instr_idx=%0h, PP[%0d] (global_plane=%0d)\n      descramble_seed: %0h (matched)\n      plane_num:       %0d (offwbf) vs %0d (ondec)\n      src_addr:        %0h (offwbf) vs %0h (ondec)\n      dest_addr:       %0h (offwbf) vs %0h (ondec)", p_instr_idx, pp % 4, pp, descramble_seed, offwbf_tr.plane_num, pp, src_mem_addr_32bit, cfg.tr[pp].dec_fail_dest_addr, dest_mem_addr_32bit, cfg.tr[pp].dest_memory_addr), UVM_LOW)
                    
                    // Record matches
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
        // Step 3: Check match results, handle multiple matches
        // =========================================================
        if (match_count == 0) begin
            `uvm_error(get_type_name(), $sformatf("OFFWBF_CMD: No matching ondec_group_cmd found for descramble_seed=%0h", descramble_seed))
            status = CHECK_INVALID_RESP;
            fail_reason = $sformatf("No matching config found for descramble_seed=%0h", descramble_seed);
        end else if (match_count > 1) begin
            // Multiple matches detected, issue UVM warning
            `uvm_warning(get_type_name(), $sformatf("\n========== MULTIPLE MATCH WARNING ==========\n  Multiple offwbf_cmd objects match the same descramble_seed!\n  descramble_seed: %0h\n  Match count: %0d\n  Matched instructions:", descramble_seed, match_count))
            
            // Record all matched instruction info
            for (i = 0; i < match_count; i++) begin
                `uvm_warning(get_type_name(), $sformatf("    Match #%0d: instr_idx=%0h, PP[%0d] (global_plane=%0d)", i+1, matched_instr_indices[i], matched_pp_list[i] % 4, matched_pp_list[i]))
            end

            `uvm_warning(get_type_name(), $sformatf("  Current system does NOT support multiple matching offwbf_cmd cases.\n  Will process ONLY the FIRST match (instr_idx=%0h, PP[%0d]).\n=========================================\n", matched_instr_indices[0], matched_pp_list[0] % 4))
            
            // Process only first match
            matched_instr_idx = matched_instr_indices[0];
            matched_pp = matched_pp_list[0];
            matched_gid = matched_pp / 4;
            matched_pp = matched_pp % 4;
        end else begin
            // Unique match
            matched_instr_idx = matched_instr_indices[0];
            matched_pp = matched_pp_list[0];
            matched_gid = matched_pp / 4;
            matched_pp = matched_pp % 4;
            
            `uvm_info(get_type_name(), $sformatf("  Unique match found: instr_idx=%0h, Group%0d PP[%0d] (global_plane=%0d)", matched_instr_idx, matched_gid, matched_pp, matched_gid*4+matched_pp), UVM_LOW)
        end
        
        // =========================================================
        // Step 4: Comprehensive check on matched offwbf_cmd
        // =========================================================
        if (match_count >= 1) begin
            int global_pp = matched_gid * 4 + matched_pp;
            cfg = pending_config[matched_instr_idx];

            `uvm_info(get_type_name(), $sformatf("\n  [Starting Comprehensive Check]\n  Matched Config(ondec):\n    instruction_index: %0h\n    Group: %0d, PP: %0d (Global PP: %0d)\n    OST ID: %0h\n    plane_sel: %0b\n    offline_wbf_work_en: %0b\n    descramble_en: %0b\n    descramble_seed: %0h\n    read_mode: %0b\n    dest_memory_addr: %0h\n    dec_fail_dest_addr: %0h", matched_instr_idx, matched_gid, matched_pp, global_pp, cfg.tr[global_pp].nsu_ost_id, cfg.tr[global_pp].plane_sel, cfg.tr[global_pp].offline_wbf_work_en, cfg.tr[global_pp].descramble_en, cfg.tr[global_pp].descramble_seed, cfg.tr[global_pp].read_mode, cfg.tr[global_pp].dest_memory_addr, cfg.tr[global_pp].dec_fail_dest_addr), UVM_LOW)
            
            // 4.1 Check offline_wbf_out_flag
            if (!offwbf_tr.offline_wbf_out_flag) begin
                status = CHECK_FAIL_DATA;
                fail_reason = $sformatf(
                    "Group%0d PP[%0d] offline_wbf_out_flag not asserted (expected 1, got 0)", 
                    matched_gid, matched_pp);
                `uvm_error(get_type_name(), fail_reason)
            end
            
            if (status != CHECK_PASS) begin
                // Skip further checks on error
            end else begin
                // 4.2 Check plane_num match
                if (offwbf_tr.plane_num != global_pp) begin
                    status = CHECK_FAIL_DATA;
                    fail_reason = $sformatf(
                        "Group%0d PP[%0d] plane_num mismatch: expected=%0d (global), got=%0d", 
                        matched_gid, matched_pp, global_pp, offwbf_tr.plane_num);
                    `uvm_error(get_type_name(), fail_reason)
                end
            end
            
            if (status != CHECK_PASS) begin
                // Skip further checks on error
            end else begin
                // 4.3 Check dest_sel (corresponds to ondec.write_pos_jdg)
                if (offwbf_tr.dest_sel != cfg.tr[global_pp].write_pos_jdg) begin
                    status = CHECK_FAIL_DATA;
                    fail_reason = $sformatf(
                        "Group%0d PP[%0d] dest_sel mismatch: expected=%0b, got=%0b", 
                        matched_gid, matched_pp, cfg.tr[global_pp].write_pos_jdg, offwbf_tr.dest_sel);
                    `uvm_error(get_type_name(), fail_reason)
                end
            end
            
            if (status != CHECK_PASS) begin
                // Skip further checks on error
            end else begin
                // 4.4 Check flip_threshold_sel
                if (offwbf_tr.flip_threshold_sel != cfg.tr[global_pp].flip_threshold_sel) begin
                    status = CHECK_FAIL_DATA;
                    fail_reason = $sformatf(
                        "Group%0d PP[%0d] flip_threshold_sel mismatch: expected=%0b, got=%0b", 
                        matched_gid, matched_pp, cfg.tr[global_pp].flip_threshold_sel, offwbf_tr.flip_threshold_sel);
                    `uvm_error(get_type_name(), fail_reason)
                end
            end
            
            if (status != CHECK_PASS) begin
                // Skip further checks on error
            end else begin
                // 4.5 Check over_threshold (corresponds to ondec.syn_weight_over_threshold)
                if (offwbf_tr.over_threshold != cfg.tr[global_pp].syn_weight_over_threshold) begin
                    status = CHECK_FAIL_DATA;
                    fail_reason = $sformatf(
                        "Group%0d PP[%0d] over_threshold mismatch: expected=%0b, got=%0b", 
                        matched_gid, matched_pp, cfg.tr[global_pp].syn_weight_over_threshold, offwbf_tr.over_threshold);
                    `uvm_error(get_type_name(), fail_reason)
                end
            end
            
            if (status != CHECK_PASS) begin
                // Skip further checks on error
            end else begin
                // 4.6 Check descramble_en
                if (offwbf_tr.descramble_en != cfg.tr[global_pp].descramble_en) begin
                    status = CHECK_FAIL_DATA;
                    fail_reason = $sformatf(
                        "Group%0d PP[%0d] descramble_en mismatch: expected=%0b, got=%0b", 
                        matched_gid, matched_pp, cfg.tr[global_pp].descramble_en, offwbf_tr.descramble_en);
                    `uvm_error(get_type_name(), fail_reason)
                end
            end
            
            if (status != CHECK_PASS) begin
                // Skip further checks on error
            end else begin
                // 4.7 Double-check descramble_seed
                if (descramble_seed != cfg.tr[global_pp].descramble_seed) begin
                    status = CHECK_FAIL_DATA;
                    fail_reason = $sformatf(
                        "Group%0d PP[%0d] descramble_seed mismatch: expected=%0h, got=%0h", 
                        matched_gid, matched_pp, cfg.tr[global_pp].descramble_seed, descramble_seed);
                    `uvm_error(get_type_name(), fail_reason)
                end
            end
            
            if (status != CHECK_PASS) begin
                // Skip further checks on error
            end else begin
                // 4.8 Check src_mem_addr (corresponds to ondec.dec_fail_dest_addr)
                if (cfg.tr[global_pp].dec_fail_dest_addr != src_mem_addr_32bit) begin
                    status = CHECK_FAIL_DATA;
                    fail_reason = $sformatf(
                        "Group%0d PP[%0d] src_mem_addr mismatch: expected=%0h, got=%0h", 
                        matched_gid, matched_pp, cfg.tr[global_pp].dec_fail_dest_addr, src_mem_addr_32bit);
                    `uvm_error(get_type_name(), fail_reason)
                end
            end
            
            if (status != CHECK_PASS) begin
                // Skip further checks on error
            end else begin
                // 4.9 Check dest_memory_addr (corresponds to ondec.dest_memory_addr)
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
                // Skip further checks on error
            end else begin
                // 4.10 Check read_mode (offwbf only called in safe read mode)
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
        // Step 5: Report check results and update status
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
        // Step 6: Clear offline_wbf_work_en flag for processed plane_pair
        // =========================================================
        if (match_count >= 1 && matched_instr_idx != 16'hFFFF) begin
            int global_pp = matched_gid * 4 + matched_pp;
            
            // Clear offline_wbf_work_en for corresponding plane_pair
            pending_config[matched_instr_idx].tr[global_pp].offline_wbf_work_en = 1'b0;
            `uvm_info(get_type_name(), $sformatf("  Cleared offline_wbf_work_en for Group%0d PP[%0d] (global PP%0d)", matched_gid, matched_pp, global_pp), UVM_LOW)
            
            // Check if any pending offwbf requests remain for this instruction_index
            has_pending_offwbf = 1'b0;
            for (pp = 0; pp < 8; pp++) begin
                if (pending_config[matched_instr_idx].tr[pp].plane_sel && 
                    pending_config[matched_instr_idx].tr[pp].offline_wbf_work_en) begin
                    has_pending_offwbf = 1'b1;
                    break;
                end
            end
            
            // Clear entire instruction_index if no pending offwbf requests
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
// pack_ondec_transactions - Pack transactions from 8 plane_pair queues
// 
// Function:
//   1. Continuously monitor 8 ondec_fifo queues
//   2. Pack 8 transactions with same instruction_index
//   3. Send packed ondec2nsu_group_transaction to ondec_group_cmd_fifo
//
// Packing strategy:
//   - Wait for transactions in all 8 queues
//   - Check if instruction_index matches across 8 transactions
//   - Pack into group_transaction and send if matched
//   - Error and discard if mismatched
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
        // Step 1: Wait for transactions in all 8 queues
        // =========================================================
        `uvm_info(get_type_name(), "Waiting for 8 plane_pair transactions...", UVM_LOW)
        
        // Get transactions from 8 queues in parallel
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
        // Step 2: Check if instruction_index is consistent
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
            continue;  // Discard mismatched transactions, continue next round
        end
        
        `uvm_info(get_type_name(), $sformatf(
            "All 8 plane_pairs have matching instruction_index=%0h", 
            ref_instr_idx), UVM_LOW)
        
        // =========================================================
        // Step 3: Pack into ondec2nsu_group_transaction
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
        // Step 4: Send to ondec_group_cmd_fifo
        // =========================================================
        ondec_group_cmd_fifo.write(group_tr);
        
        `uvm_info(get_type_name(), $sformatf(
            "Sent group transaction to ondec_group_cmd_fifo (instr_idx=%0h)", 
            ref_instr_idx), UVM_LOW)
    end
endtask : pack_ondec_transactions

`endif