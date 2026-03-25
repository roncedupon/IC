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
typedef class ondec2nsu_group_transaction;  // Forward declaration for ondec2nsu_group_transaction
typedef class token_transaction;  // Forward declaration for token_transaction
// Token transaction for identifying ondec2nsu_group_transaction
// Define hash type for flexibility
typedef bit [96:0] token_hash_t;//exp: token_hash_t hash={instruction_index, group0_ost_id, group1_ost_id,nsu_addr};
package ondec2nsu_checker_pkg;
    
    // Forward declaration for token_transaction
    // class token_transaction;
    
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
    


endpackage
`define CLASS_NAME_DEFINE ondec2nsu_checker

//=============================================================================
// ondec2nsu_checker class definition
//=============================================================================
import ondec2nsu_checker_pkg::*;

class `CLASS_NAME_DEFINE extends uvm_component;

    `uvm_component_utils(`CLASS_NAME_DEFINE)

    import ondec2nsu_checker_pkg::*;

    //-------------------------------------------------------------------------
    // FIFO definitions
    //-------------------------------------------------------------------------
    // Input queue for 8 plane_pair ondec2nsu_transaction
    uvm_tlm_analysis_fifo #(ondec2nsu_transaction) ondec_fifo [8];
    
    // ondec_cmd FIFO - Packed ondec2nsu_group_transaction (8 plane_pairs = 2 groups)
    uvm_tlm_analysis_fifo #(ondec2nsu_group_transaction) ondec_group_cmd_fifo;
    
    // deep_read_resp FIFO - Deep read response from NSU to CPU
    uvm_tlm_analysis_fifo #(nsu2cpu_deep_resp_transaction) deep_read_resp_fifo;
    
    // offwbf_cmd FIFO -  Command from NSU to OFFWBF
    uvm_tlm_analysis_fifo #(offdec2nsu_transaction) offwbf_cmd_fifo;
    bit[15:0] descramble_seed_que[$];//used to store descramble_seed

    // offwbf_cmd FIFO - Command from OFFWBF to NSU,used to check d
    uvm_tlm_analysis_fifo #(offdec2nsu_transaction) offwbf2nsu_cmd_fifo;
    
    //-------------------------------------------------------------------------
    // Pending config tracking table (indexed by token hash)
    //-------------------------------------------------------------------------
    logic pending_deep_resp [token_hash_t];     // Mark if deep read response is expected
    logic pending_offwbf [token_hash_t];        // Mark if offwbf command is expected
    ondec2nsu_group_transaction pending_config [token_hash_t];  // [token hash] --> Full group transaction
    
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
    // OFFWBF address management (simulates DUT's priority encoder behavior)
    //-------------------------------------------------------------------------
    bit [15:0] offwbf_addr_status;  // 16 address spaces (0-15), 0=free, 1=occupied
    bit [3:0] offwbf_ost_id_to_addr [bit [4:0]];  // Map from ost_id to allocated address
    logic [31:0] offwbf_base_addr;  // Base address for OFFWBF IO space
    
    // OFFWBF address management methods
    extern function void init_offwbf_addr_manager();
    extern function bit [3:0] allocate_offwbf_addr(bit [4:0] ost_id);
    extern function void test_offwbf_addr_manager();    
    extern function void free_offwbf_addr(bit [4:0] ost_id);
    extern function bit [3:0] get_allocated_offwbf_addr(bit [4:0] ost_id);
    extern function bit is_offwbf_addr_occupied(bit [3:0] addr);
    extern function void print_offwbf_addr_status();
    
    //-------------------------------------------------------------------------    
    // Deep resp offwbf mapping
    //-------------------------------------------------------------------------    
    offdec2nsu_transaction deep_resp_offwbf_map [logic [15:0]];  // Map descramble_seed to offdec2nsu_transaction
    semaphore deep_resp_offwbf_map_lock;  // Semaphore for thread-safe access to deep_resp_offwbf_map
    
    //-------------------------------------------------------------------------
    // Task declarations (inside class)
    //-------------------------------------------------------------------------
    extern virtual task pack_ondec_transactions();  // New: Pack transactions from 8 queues
    extern virtual task check_ondec_cmd();      // Step 1: Get ondec_cmd, judge by group
    extern virtual task check_deep_read_resp(); // Step 2: Check deep read response
    extern virtual task check_offwbf_cmd();     // Step 3: Check offwbf command
    extern virtual task check_offwbf_deep_resp();//step 4: Check offwbf2nsu cmd that needs deep_resp
    
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
        offwbf2nsu_cmd_fifo = new("offwbf2nsu_cmd_fifo",this);        
        
        // Initialize OFFWBF address manager
        init_offwbf_addr_manager();
        
        // Initialize semaphore for deep_resp_offwbf_map
        deep_resp_offwbf_map_lock = new(1);
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
            check_offwbf_cmd();     // Step 3: Check offwbf command(ondec_cmd-->offwbf_cmd)
            check_offwbf_deep_resp();//Step 4: offwbf2deep resp check(offwbf_cmd-->deep_resp)
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
        int pending_deep_count = 0;
        int pending_offwbf_count = 0;

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

        // Check pending deep_resp expectations
        foreach (pending_deep_resp[token_hash]) begin
            if (pending_deep_resp[token_hash]) begin
                `uvm_error(get_type_name(), $sformatf("FINAL_CHECK: Pending deep_resp expected for token_hash=%0x but not received", 
                    token_hash))
                has_unprocessed = 1'b1;
                pending_deep_count++;
            end
        end

        // Check pending offwbf expectations
        foreach (pending_offwbf[token_hash]) begin
            if (pending_offwbf[token_hash]) begin
                `uvm_error(get_type_name(), $sformatf("FINAL_CHECK: Pending offwbf expected for token_hash=%0x but not received", 
                    token_hash))
                has_unprocessed = 1'b1;
                pending_offwbf_count++;
            end
        end

        // Check pending configs (should be cleared if all responses are processed)
        // Only check configs that are still expecting responses
        foreach (pending_config[token_hash]) begin
            if (pending_deep_resp.exists(token_hash) && pending_deep_resp[token_hash]) begin
                `uvm_error(get_type_name(), $sformatf("FINAL_CHECK: Config for token_hash=%0x still exists but deep_resp not received", 
                    token_hash))
                has_unprocessed = 1'b1;
            end
            if (pending_offwbf.exists(token_hash) && pending_offwbf[token_hash]) begin
                `uvm_error(get_type_name(), $sformatf("FINAL_CHECK: Config for token_hash=%0x still exists but offwbf not received", 
                    token_hash))
                has_unprocessed = 1'b1;
            end
        end

        if (!has_unprocessed) begin
            `uvm_info(get_type_name(), "FINAL_CHECK: All FIFOs are empty, no unprocessed transactions", UVM_LOW)
        end else begin
            `uvm_error(get_type_name(), $sformatf("FINAL_CHECK FAILED: Some FIFOs contain unprocessed transactions! Pending deep_resp: %0x, Pending offwbf: %0d", 
                pending_deep_count, pending_offwbf_count))
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
//     --> Group needs to report deep_resp
//   - If any plane_pair meets (dec_suc=0 && crc_pass=1 && data_out_en=1)
//     --> Group needs to call offwbf
//-----------------------------------------------------------------------------
task `CLASS_NAME_DEFINE::check_ondec_cmd();
    ondec2nsu_group_transaction group_tr;
    int pp_base;
    logic group_need_deep_resp;
    logic group_need_offwbf;
    logic overall_need_deep_resp;
    logic overall_need_offwbf;        
    forever begin
        token_transaction token;
        token_hash_t token_hash;
        overall_need_deep_resp  =0 ;
        overall_need_offwbf     =0 ;        
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
                
                // Print detailed debug information with instruction_index
                `uvm_info(get_type_name(), $sformatf("    PP[%0d]: instr_idx=%0h, dec_suc=%b, crc_pass=%b, data_out_en=%b, deep_read_sel=%b", 
                    pp_base+pp, group_tr.tr[0].instruction_index, 
                    group_tr.tr[pp_base + pp].dec_suc, 
                    group_tr.tr[pp_base + pp].crc_pass, 
                    group_tr.tr[pp_base + pp].data_out_en, 
                    group_tr.tr[pp_base + pp].deep_read_sel), UVM_LOW)

                //wbf failed
                if (!group_tr.tr[pp_base + pp].dec_suc && group_tr.tr[pp_base + pp].crc_pass) begin
                    // 1.no enough addr,so data not outpu,and report deep_resp 
                    if (!group_tr.tr[pp_base + pp].data_out_en) begin
                        // No data output --> Need deep_resp report
                        group_need_deep_resp = 1'b1;
                        `uvm_info(get_type_name(), $sformatf("    PP[%0d]: instr_idx=%0h, decode_fail+crc_success+no_data --> Group%0d need DEEP_READ_RESP", 
                            pp_base+pp, group_tr.tr[0].instruction_index, gid), UVM_LOW)
                    end else begin
                    //2. addr enough, Data output --> Need offwbf call
                        group_need_offwbf = 1'b1;
                        group_tr.tr[pp_base + pp].offline_wbf_work_en = 1'b1;  // Set flag for offwbf-needed plane_pair
                        `uvm_info(get_type_name(), $sformatf("    PP[%0d]: instr_idx=%0h, decode_fail+crc_success+data --> Group%0d need OFFWBF_CMD", 
                            pp_base+pp, group_tr.tr[0].instruction_index, gid), UVM_LOW)
                    end
                end

                //crc failed
                if(!group_tr.tr[pp_base + pp].crc_pass)begin
                    group_need_deep_resp = 1'b1;
                    `uvm_info(get_type_name(), $sformatf("    PP[%0d]: instr_idx=%0h, crc_fail --> Group%0d need DEEP_READ_RESP", 
                        pp_base+pp, group_tr.tr[0].instruction_index, gid), UVM_LOW)
                end
                // //dec_suc 
                // if(!group_tr.tr[pp_base + pp].dec_suc)begin
                //     group_need_deep_resp = 1'b1;
                //     `uvm_info(get_type_name(), $sformatf("    PP[%0d]: instr_idx=%0h, decode_fail --> Group%0d need DEEP_READ_RESP", 
                //         pp_base+pp, group_tr.tr[0].instruction_index, gid), UVM_LOW)
                // end           
                //deep_read_sel
                if(group_tr.tr[pp_base + pp].deep_read_sel)begin
                    group_need_deep_resp = 1'b1;
                    `uvm_info(get_type_name(), $sformatf("    PP[%0d]: instr_idx=%0h, deep_read_sel=1 --> Group%0d need DEEP_READ_RESP", 
                        pp_base+pp, group_tr.tr[0].instruction_index, gid), UVM_LOW)
                end                
            end
            
            // Update overall need flags
            overall_need_deep_resp |= group_need_deep_resp; //check any group  that needs deep_resp
            overall_need_offwbf |= group_need_offwbf;       //check any group  that needs offwbf
            
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
                `uvm_info(get_type_name(), $sformatf("  Group%0d: No action needed (current group(4 planes) don't need deep_resp)", 
                    gid), UVM_LOW)
            end
        end
        
        // Only record config if we expect either deep_resp or offwbf
        if (overall_need_deep_resp || overall_need_offwbf) begin
            // Create token_transaction for identifying this group transaction
            token = token_transaction::type_id::create("token");
            token.instruction_index = group_tr.tr[0].instruction_index;
            token.group0_ost_id = group_tr.tr[0].nsu_ost_id;  // Group 0 OST ID from first transaction
            token.group1_ost_id = group_tr.tr[4].nsu_ost_id;  // Group 1 OST ID from fifth transaction
            token.group0_lba = group_tr.tr[0].meta_buffer_id;  // Group 0 nsu_addr from first transaction
            token.group1_lba = group_tr.tr[4].meta_buffer_id;  // Group 1 nsu_addr from fifth transaction
            
            // Record pending token and save full group transaction
            // Set flags based on what responses are expected
            token_hash = token.hash();
            pending_config[token_hash] = group_tr;
            
            // Set independent flags for deep_resp and offwbf
            // Note: Both can be set simultaneously for the same token
            pending_deep_resp[token_hash] |= overall_need_deep_resp;
            pending_offwbf[token_hash] |= overall_need_offwbf;
            
            `uvm_info(get_type_name(), $sformatf("Registered config for token=%0x (deep_resp=%0b, offwbf=%0b)", token_hash, pending_deep_resp[token_hash], pending_offwbf[token_hash]), UVM_LOW)
        end else begin
            `uvm_info(get_type_name(), $sformatf("No response expected for instr_idx=%0h, skipping config registration", group_tr.tr[0].instruction_index), UVM_LOW)
        end
    end
endtask : check_ondec_cmd

//-----------------------------------------------------------------------------
// check_deep_read_resp - Check deep read response from NSU to CPU
// 
// Check items (independent per group):
// 1. instruction_index match
// 2. group0_ost_id / group1_ost_id match (group-specific)
// 3. plane_pair_dec_result[7:0] (compare with dec_suc)  //todo
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
        token_transaction token;
        token_hash_t token_hash;
        deep_read_resp_fifo.get(resp);
        total_resp_count++;
        
        // Create token_transaction for identifying this response
        token = token_transaction::type_id::create("token");
        token.instruction_index = resp.instruction_index;
        token.group0_ost_id = resp.group0_ost_id;
        token.group1_ost_id = resp.group1_ost_id;
        token.group0_lba = resp.group0_meta_index_LBA;  // Group 0 nsu_addr from first transaction
        token.group1_lba = resp.group1_meta_index_LBA;  // Group 1 nsu_addr from fifth transaction        
        
        // Check if deep read response is expected for this token
        token_hash = token.hash();
        
        `uvm_info(get_type_name(), $sformatf("#%0d Received DEEP_READ_RESP: token_hash=%0h, instr_idx=%0h, group0_ost_id=%0h, group1_ost_id=%0h, group0_lba=%0h, group1_lba=%0h", 
            total_resp_count, token_hash, token.instruction_index, token.group0_ost_id, token.group1_ost_id, token.group0_lba, token.group1_lba), UVM_LOW)
        if (pending_deep_resp.exists(token_hash))begin
            status = CHECK_PASS;
            fail_reason = "";
            matched_gid = -1;
            
            // Check if config exists for this token
            if (!pending_config.exists(token_hash)) begin
                `uvm_error(get_type_name(), $sformatf("DEEP_READ_RESP: No config found for token=%0h, instr_idx=%0h", 
                    token_hash, resp.instruction_index))
                continue;  // Skip this response and process next one
            end
            
            // Iterate 2 groups to find matching group (via ost_id)
            for (int gid = 0; gid < 2; gid++) begin
                cfg = pending_config[token_hash];
                pp_base = gid * 4;  // Group 0: pp_base=0, Group 1: pp_base=4
                
                // Get corresponding ost_id from resp by group_id
                if (gid == 0) begin
                    resp_ost_id = resp.group0_ost_id;
                end else begin
                    resp_ost_id = resp.group1_ost_id;
                end
                
                // Check ost_id match (key for group independence)
                if (cfg.tr[pp_base].nsu_ost_id == resp_ost_id) begin
                    matched_gid = gid;//step1: compare group ost_id
                    
                    `uvm_info(get_type_name(), $sformatf("#%0d  Matched Group%0d (ost_id=%0h)", 
                        total_resp_count, gid, cfg.tr[pp_base].nsu_ost_id), UVM_LOW)
                    
                    // Iterate 4 plane_pairs in group for checks
                    // Only check plane_pairs expected to report deep_resp 
                    for (int pp = 0; pp < 4; pp++) begin
                        pp_idx = gid * 4 + pp;  // Global plane_pair index
                        
                        if (!cfg.tr[pp_idx].plane_sel) continue;  // Skip unselected plane_pair

                        // Check decode status (plane_pair_ecc_result: 0=success, 1=fail)
                        if (cfg.tr[pp_idx].dec_suc != (!resp.plane_pair_ecc_result[pp_idx])) begin
                            offdec2nsu_transaction offwbf_tr;
                            //dec_suc(crc_pass & wbf_pass) of deep_resp != dec_suc of ondec_cmd-->check offwbf 
                            deep_resp_offwbf_map_lock.get();
                            offwbf_tr = deep_resp_offwbf_map[cfg.tr[pp_idx].descramble_seed];
                            deep_resp_offwbf_map_lock.put();     
                            if(offwbf_tr.dec_suc)begin
                                `uvm_info(get_type_name(), $sformatf("#%0d  Plane %0d WBF failed, offwbf called and succeeded: descramble_seed=%0h, plane_num=%0d, offwbf dec_suc=%b", 
                                    total_resp_count, pp_idx, cfg.tr[pp_idx].descramble_seed, offwbf_tr.plane_num, offwbf_tr.dec_suc), UVM_LOW);
                                deep_resp_offwbf_map_lock.get();
                                deep_resp_offwbf_map.delete(cfg.tr[pp_idx].descramble_seed);
                                deep_resp_offwbf_map_lock.put();                                    
                            end
                            else begin
                                status = CHECK_FAIL_DECODE;
                                `uvm_error(get_type_name(), $sformatf("#%0d DEEP_READ_RESP Group%0d CHECK FAIL: instr_idx=%0h, token=%0h, reason=Group%0d PP[%0d] decode mismatch: expected=%0b, got=%0b", 
                                    total_resp_count, gid, resp.instruction_index, token_hash, gid, pp, cfg.tr[pp_idx].dec_suc, (!resp.plane_pair_ecc_result[pp_idx])));
                                // break;                                
                            end
                        end
                        
                        // Check data_out_en for planes that need deep_resp
                        // If plane_pair_ecc_result=1 (decode failed) , data_out_en should be 0 for deep_resp cases
                        if (resp.plane_pair_ecc_result[pp_idx]) begin//dec failed,data cannot be output
                            // Detailed debug information
                            `uvm_info(get_type_name(), $sformatf("#%0d    PP[%0d]: instr_idx=%0h, decode status=FAILED (ecc_result=1), data_out_en=%b, plane_sel=%b", 
                                total_resp_count, pp_idx, resp.instruction_index, cfg.tr[pp_idx].data_out_en, cfg.tr[pp_idx].plane_sel), UVM_LOW);
                            
                            if (cfg.tr[pp_idx].data_out_en != 0) begin
                                /*(ecc=0 ;data_out_en=1) means offwbf is going to be invoked,
                                and this is a deep_resp from offwbf, continuely check offwbf_cmd*/
                                status = CHECK_FAIL_DATA;
                                
                                if(deep_resp_offwbf_map.exists(cfg.tr[pp_idx].descramble_seed))begin
                                    offdec2nsu_transaction offwbf_tr;
                                    // Acquire lock for thread-safe access to deep_resp_offwbf_map
                                    deep_resp_offwbf_map_lock.get();
                                    offwbf_tr = deep_resp_offwbf_map[cfg.tr[pp_idx].descramble_seed];
                                    // Release lock
                                    deep_resp_offwbf_map_lock.put();
                                    
                                    // Check if offwbf_tr is valid
                                    if (offwbf_tr != null) begin
                                        `uvm_info(get_type_name(), $sformatf("#%0d  Found matching offwbf command in deep_resp_offwbf_map: descramble_seed=%0h, plane_num=%0d, offline_wbf_out_flag=%b", 
                                            total_resp_count, cfg.tr[pp_idx].descramble_seed, offwbf_tr.plane_num, offwbf_tr.offline_wbf_out_flag), UVM_LOW);
                                        
                                        // Check if plane_num matches
                                        if (offwbf_tr.plane_num != pp_idx) begin
                                            status = CHECK_FAIL_DATA;
                                            `uvm_error(get_type_name(), $sformatf("#%0d DEEP_READ_RESP Group%0d CHECK FAIL: instr_idx=%0h, token=%0h, reason=Group%0d PP[%0d] plane_num mismatch between deep_resp and offwbf: expected=%0d, got=%0d", 
                                                total_resp_count, gid, resp.instruction_index, token_hash, gid, pp, pp_idx, offwbf_tr.plane_num));
                                        end
                                        
                                        // Check if offline_wbf_out_flag is 0 (data not output)
                                        if (offwbf_tr.offline_wbf_out_flag != 0) begin
                                            status = CHECK_FAIL_DATA;
                                            `uvm_error(get_type_name(), $sformatf("#%0d DEEP_READ_RESP Group%0d CHECK FAIL: instr_idx=%0h, token=%0h, reason=Group%0d PP[%0d] offline_wbf_out_flag should be 0 for deep_resp case, got=%0b", 
                                                total_resp_count, gid, resp.instruction_index, token_hash, gid, pp, offwbf_tr.offline_wbf_out_flag));
                                        end
                                        
                                        // Check if dest_sel matches (corresponds to ondec.write_pos_jdg)
                                        if (offwbf_tr.dest_sel != cfg.tr[pp_idx].write_pos_jdg) begin
                                            status = CHECK_FAIL_DATA;
                                            `uvm_error(get_type_name(), $sformatf("#%0d DEEP_READ_RESP Group%0d CHECK FAIL: instr_idx=%0h, token=%0h, reason=Group%0d PP[%0d] dest_sel mismatch: expected=%0b, got=%0b", 
                                                total_resp_count, gid, resp.instruction_index, token_hash, gid, pp, cfg.tr[pp_idx].write_pos_jdg, offwbf_tr.dest_sel));
                                        end
                                        
                                        // Check if flip_threshold_sel matches
                                        if (offwbf_tr.flip_threshold_sel != cfg.tr[pp_idx].flip_threshold_sel) begin
                                            status = CHECK_FAIL_DATA;
                                            `uvm_error(get_type_name(), $sformatf("#%0d DEEP_READ_RESP Group%0d CHECK FAIL: instr_idx=%0h, token=%0h, reason=Group%0d PP[%0d] flip_threshold_sel mismatch: expected=%0b, got=%0b", 
                                                total_resp_count, gid, resp.instruction_index, token_hash, gid, pp, cfg.tr[pp_idx].flip_threshold_sel, offwbf_tr.flip_threshold_sel));
                                        end
                                        
                                        // Check if over_threshold matches (corresponds to ondec.syn_weight_over_threshold)
                                        if (offwbf_tr.over_threshold != cfg.tr[pp_idx].syn_weight_over_threshold) begin
                                            status = CHECK_FAIL_DATA;
                                            `uvm_error(get_type_name(), $sformatf("#%0d DEEP_READ_RESP Group%0d CHECK FAIL: instr_idx=%0h, token=%0h, reason=Group%0d PP[%0d] over_threshold mismatch: expected=%0b, got=%0b", 
                                                total_resp_count, gid, resp.instruction_index, token_hash, gid, pp, cfg.tr[pp_idx].syn_weight_over_threshold, offwbf_tr.over_threshold));
                                        end
                                        
                                        // After successful check, remove the entry from deep_resp_offwbf_map to avoid memory leak
                                        deep_resp_offwbf_map_lock.get();
                                        deep_resp_offwbf_map.delete(cfg.tr[pp_idx].descramble_seed);
                                        deep_resp_offwbf_map_lock.put();
                                        `uvm_info(get_type_name(), $sformatf("#%0d  Removed offwbf command from deep_resp_offwbf_map: descramble_seed=%0h", total_resp_count, cfg.tr[pp_idx].descramble_seed), UVM_LOW);
                                    end else begin
                                        `uvm_error(get_type_name(), $sformatf("#%0d DEEP_READ_RESP Group%0d CHECK FAIL: instr_idx=%0h, token=%0h, reason=Group%0d PP[%0d] offwbf_tr is null in deep_resp_offwbf_map", 
                                            total_resp_count, gid, resp.instruction_index, token_hash, gid, pp));
                                    end
                                end
                                else begin
                                    `uvm_error(get_type_name(), $sformatf("#%0d DEEP_READ_RESP Group%0d CHECK FAIL: instr_idx=%0h, token=%0h, reason=Group%0d PP[%0d] data_out_en should be 0 for deep_resp case (decode failed), got=%0b", 
                                        total_resp_count, gid, resp.instruction_index, token_hash, gid, pp, cfg.tr[pp_idx].data_out_en));
                                end
                            end else begin
                                `uvm_info(get_type_name(), $sformatf("#%0d    PP[%0d]: instr_idx=%0h, data_out_en=0 (correct for deep_resp case - decode failed)", 
                                    total_resp_count, pp_idx, resp.instruction_index), UVM_LOW);
                            end
                        end 
                        else begin//wbf&crc pass，data should be output
                            // Detailed debug information
                            `uvm_info(get_type_name(), $sformatf("#%0d    PP[%0d]: instr_idx=%0h, decode status=SUCCESS (ecc_result=0), data_out_en=%b, plane_sel=%b", 
                                total_resp_count, pp_idx, resp.instruction_index, cfg.tr[pp_idx].data_out_en, cfg.tr[pp_idx].plane_sel), UVM_LOW);
                            
                            if (cfg.tr[pp_idx].data_out_en != 1) begin
                                status = CHECK_FAIL_DATA;
                                `uvm_error(get_type_name(), $sformatf("#%0d DEEP_READ_RESP Group%0d CHECK FAIL: instr_idx=%0h, token=%0h, reason=Group%0d PP[%0d] data_out_en should be 1 for deep_resp case (decode success), got=%0b", 
                                    total_resp_count, gid, resp.instruction_index, token_hash, gid, pp, cfg.tr[pp_idx].data_out_en));
                            end else begin
                                `uvm_info(get_type_name(), $sformatf("#%0d    PP[%0d]: instr_idx=%0h, data_out_en=1 (correct for deep_resp case - decode success)", 
                                    total_resp_count, pp_idx, resp.instruction_index), UVM_LOW);
                            end                            
                        end              


                        // Check CRC status (plane_pair_crc_result: 1=success, 0=fail)
                        if (cfg.tr[pp_idx].crc_pass != (!resp.plane_pair_crc_result[pp_idx])) begin
                            status = CHECK_FAIL_CRC;
                            `uvm_error(get_type_name(), $sformatf("#%0d DEEP_READ_RESP Group%0d CHECK FAIL: instr_idx=%0h, token=%0h, reason=Group%0d PP[%0d] CRC mismatch: expected=%0b, got=%0b", 
                                total_resp_count, gid, resp.instruction_index, token_hash, gid, pp, cfg.tr[pp_idx].crc_pass, (!resp.plane_pair_crc_result[pp_idx])));
                            // break;
                        end                

                        // Check LBA comparison result (plane_pair_lba_comp: 1=mismatch, 0=match)
                        if (cfg.tr[pp_idx].error_flag && !resp.plane_pair_lba_comp[pp_idx]) begin
                            status = CHECK_FAIL_LBA;
                            `uvm_error(get_type_name(), $sformatf("#%0d DEEP_READ_RESP Group%0d CHECK FAIL: instr_idx=%0h, token=%0h, reason=Group%0d PP[%0d] LBA comp mismatch: expected mismatch but got match", 
                                total_resp_count, gid, resp.instruction_index, token_hash, gid, pp));
                            break;
                        end                        
                    end
                    
                    // Check deep_read_sel
                    if (cfg.tr[pp_base].deep_read_sel != resp.deep_read_sel) begin
                        status = CHECK_FAIL_DATA;
                        `uvm_error(get_type_name(), $sformatf("#%0d DEEP_READ_RESP Group%0d CHECK FAIL: instr_idx=%0h, reason=Group%0d deep_read_sel mismatch: expected=%0b, got=%0b", 
                            total_resp_count, gid, resp.instruction_index, gid, cfg.tr[pp_base].deep_read_sel, resp.deep_read_sel));
                    end
                    
                    // Check read_mode (safe_fast_read corresponds to read_mode)
                    if (cfg.tr[pp_base].read_mode != resp.safe_fast_read) begin
                        status = CHECK_FAIL_DATA;
                        `uvm_error(get_type_name(), $sformatf("#%0d DEEP_READ_RESP Group%0d CHECK FAIL: instr_idx=%0h, reason=Group%0d read_mode mismatch: expected=%0b, got=%0b", 
                            total_resp_count, gid, resp.instruction_index, gid, cfg.tr[pp_base].read_mode, resp.safe_fast_read));
                    end
                    
                    // Check block_addr (consistent within group),only use lower 8bits
                    if (cfg.tr[pp_base].plane_group_block_addr[7:0] != resp.group0_block_addr && gid == 0) begin
                        status = CHECK_FAIL_DATA;
                        `uvm_error(get_type_name(), $sformatf("#%0d DEEP_READ_RESP Group%0d CHECK FAIL: instr_idx=%0h, reason=Group%0d block_addr mismatch: expected=%0h, got=%0h", 
                            total_resp_count, gid, resp.instruction_index, gid, cfg.tr[pp_base].plane_group_block_addr, resp.group0_block_addr));
                    end
                    if (cfg.tr[pp_base].plane_group_block_addr[7:0] != resp.group1_block_addr && gid == 1) begin
                        status = CHECK_FAIL_DATA;
                        `uvm_error(get_type_name(), $sformatf("#%0d DEEP_READ_RESP Group%0d CHECK FAIL: instr_idx=%0h, reason=Group%0d block_addr mismatch: expected=%0h, got=%0h", 
                            total_resp_count, gid, resp.instruction_index, gid, cfg.tr[pp_base].plane_group_block_addr, resp.group1_block_addr));
                    end
                    
                    // Check page_addr (consistent within group)
                    if (cfg.tr[pp_base].page_addr_plane_group != resp.group0_page_addr && gid == 0) begin
                        status = CHECK_FAIL_DATA;
                        `uvm_error(get_type_name(), $sformatf("#%0d DEEP_READ_RESP Group%0d CHECK FAIL: instr_idx=%0h, reason=Group%0d page_addr mismatch: expected=%0h, got=%0h", 
                            total_resp_count, gid, resp.instruction_index, gid, cfg.tr[pp_base].page_addr_plane_group, resp.group0_page_addr));
                    end
                    if (cfg.tr[pp_base].page_addr_plane_group != resp.group1_page_addr && gid == 1) begin
                        status = CHECK_FAIL_DATA;
                        `uvm_error(get_type_name(), $sformatf("#%0d DEEP_READ_RESP Group%0d CHECK FAIL: instr_idx=%0h, reason=Group%0d page_addr mismatch: expected=%0h, got=%0h", 
                            total_resp_count, gid, resp.instruction_index, gid, cfg.tr[pp_base].page_addr_plane_group, resp.group1_page_addr));
                    end
                    
                    // Check meta_index_LBA (consistent within group)
                    if (cfg.tr[pp_base].lba[22:0] != resp.group0_meta_index_LBA && gid == 0) begin
                        status = CHECK_FAIL_DATA;
                        `uvm_error(get_type_name(), $sformatf("#%0d DEEP_READ_RESP Group%0d CHECK FAIL: instr_idx=%0h, reason=Group%0d meta_index_LBA mismatch: expected=%0h, got=%0h", 
                            total_resp_count, gid, resp.instruction_index, gid, cfg.tr[pp_base].lba[22:0], resp.group0_meta_index_LBA));
                    end
                    if (cfg.tr[pp_base].lba[22:0] != resp.group1_meta_index_LBA && gid == 1) begin
                        status = CHECK_FAIL_DATA;
                        `uvm_error(get_type_name(), $sformatf("#%0d DEEP_READ_RESP Group%0d CHECK FAIL: instr_idx=%0h, reason=Group%0d meta_index_LBA mismatch: expected=%0h, got=%0h", 
                            total_resp_count, gid, resp.instruction_index, gid, cfg.tr[pp_base].lba[22:0], resp.group1_meta_index_LBA));
                    end
                    
                    // Update statistics for this group
                    if (status == CHECK_PASS) begin
                        pass_count++;
                        group_decode_success[gid]++;
                        `uvm_info(get_type_name(), $sformatf("#%0d DEEP_READ_RESP Group%0d CHECK PASS: instr_idx=%0h (ost_id=%0h)", 
                            total_resp_count, gid, resp.instruction_index, resp_ost_id), UVM_LOW)
                    end else begin
                        fail_count++;
                        group_decode_fail[gid]++;
                    end
                    
                    // Process next group (do not break, check both groups)
                end else begin
                    // OST ID not matched for this group
                    `uvm_info(get_type_name(), $sformatf("#%0d  Group%0d OST ID not matched: expected=%0h, got=%0h", 
                        total_resp_count, gid, cfg.tr[pp_base].nsu_ost_id, resp_ost_id), UVM_LOW)
                end
            end
            
            // Note: Group-specific checks and reporting are done inside the loop above
            // Each group is checked independently
            
            // Clear deep_resp flag (offwbf flag is managed independently by check_offwbf_cmd)
            pending_deep_resp[token_hash] = 1'b0;
            
            // Check if both deep_resp and offwbf are cleared, then clear config
            if (!pending_deep_resp[token_hash] && !pending_offwbf[token_hash])begin
                pending_config.delete(token_hash);
                `uvm_info(get_type_name(), $sformatf("#%0d All responses processed for token=%0x, clearing config", 
                    total_resp_count, token_hash), UVM_LOW)
            end
        end else begin
            `uvm_error(get_type_name(), $sformatf("#%0d DEEP_READ_RESP: No matching config for token=%0x", 
                total_resp_count, token_hash))
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
        token_hash_t matched_tokens[$];
        token_hash_t matched_token;
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
        descramble_seed_que.push_back(descramble_seed);
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
        
        // Iterate all pending tokens to collect descramble_seed matches
        foreach (pending_config[token])begin
            cfg = pending_config[token];
            
            // Iterate all 8 plane_pairs to find descramble_seed match
            for (int pp = 0; pp < 8; pp++) begin
                if (!cfg.tr[pp].plane_sel) begin
                    `uvm_info(get_type_name(), $sformatf("  Skipping instr_idx=%0h, PP[%0d]: plane_sel=0 (not selected)", cfg.tr[0].instruction_index, pp), UVM_LOW)
                    continue;  // Skip unselected plane_pair
                end

                if (!cfg.tr[pp].offline_wbf_work_en) begin
                    `uvm_info(get_type_name(), $sformatf("  Skipping instr_idx=%0h, PP[%0d]: offline_wbf_work_en=0 (no offwbf needed)", cfg.tr[0].instruction_index, pp), UVM_LOW)
                    continue;  // Skip plane_pair not needing offwbf
                end

                // Check descramble_en (must be enabled for descramble_seed match)
                if (!cfg.tr[pp].descramble_en) begin
                    `uvm_info(get_type_name(), $sformatf("  Skipping instr_idx=%0h, PP[%0d]: descramble_en=0 (descramble disabled)", cfg.tr[0].instruction_index, pp), UVM_LOW)
                    continue;
                end
                
                // Exact descramble_seed match
                if (descramble_seed == cfg.tr[pp].descramble_seed) begin
                    `uvm_info(get_type_name(), $sformatf("  >>> MATCH FOUND: instr_idx=%0h, PP[%0d] (global_plane=%0d)\n      descramble_seed: %0h (matched)\n      plane_num:       %0d (offwbf) vs %0d (ondec)\n      src_addr:        %0h (offwbf) vs %0h (ondec)\n      dest_addr:       %0h (offwbf) vs %0h (ondec)", cfg.tr[0].instruction_index, pp % 4, pp, descramble_seed, offwbf_tr.plane_num, pp, src_mem_addr_32bit, cfg.tr[pp].dec_fail_dest_addr, dest_mem_addr_32bit, cfg.tr[pp].dest_memory_addr), UVM_LOW)
                    
                    // Record matches
                    match_count++;
                    matched_instr_indices.push_back(cfg.tr[0].instruction_index);
                    matched_pp_list.push_back(pp);
                    matched_cfg_idx.push_back(pp);
                    matched_tokens.push_back(token);

                    `uvm_info(get_type_name(), $sformatf("  Total matches so far: %0d", match_count), UVM_LOW)
                end else begin
                    `uvm_info(get_type_name(), $sformatf("  No match: instr_idx=%0h, PP[%0d], descramble_seed=%0h (expected %0h)", cfg.tr[0].instruction_index, pp, cfg.tr[pp].descramble_seed, descramble_seed), UVM_LOW)
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
            for (int i = 0; i < match_count; i++) begin
                `uvm_error(get_type_name(), $sformatf("    Match #%0d: instr_idx=%0h, PP[%0d] (global_plane=%0d)", i+1, matched_instr_indices[i], matched_pp_list[i] % 4, matched_pp_list[i]))
            end

            `uvm_warning(get_type_name(), $sformatf("  Current system does NOT support multiple matching offwbf_cmd cases.\n  Will process ONLY the FIRST match (instr_idx=%0h, PP[%0d]).\n=========================================\n", matched_instr_indices[0], matched_pp_list[0] % 4))
            
            // Process only first match
            matched_instr_idx = matched_instr_indices[0];
            matched_pp = matched_pp_list[0];
            matched_gid = matched_pp / 4;
            matched_pp = matched_pp % 4;
            matched_token = matched_tokens[0];
        end else begin
            // Unique match
            matched_instr_idx = matched_instr_indices[0];
            matched_pp = matched_pp_list[0];
            matched_gid = matched_pp / 4;
            matched_pp = matched_pp % 4;
            matched_token = matched_tokens[0];
            
            `uvm_info(get_type_name(), $sformatf("  Unique match found: instr_idx=%0h, Group%0d PP[%0d] (global_plane=%0d)\n  Matched token: %0x\n  offwbf plane_num: %0d, ost_id_nsu2offline: %0h\n  descramble_seed: %0h, write_pos_jdg: %0b", 
                                                  matched_instr_idx, matched_gid, matched_pp, matched_gid*4+matched_pp, 
                                                  matched_token, 
                                                  offwbf_tr.plane_num, offwbf_tr.ost_id_nsu2offline, 
                                                  descramble_seed, offwbf_tr.dest_sel), UVM_LOW)
        end
        
        // =========================================================
        // Step 4: Comprehensive check on matched offwbf_cmd
        // =========================================================
        // Handle match_count cases
        if (match_count == 1) begin//match_count==0 will be error; match_count>1 will be error too.
            int global_pp = matched_gid * 4 + matched_pp;
            // Add debug information
            `uvm_info(get_type_name(), $sformatf("Attempting to access pending_config with matched_token=%0x", matched_token), UVM_LOW)
            `uvm_info(get_type_name(), $sformatf("pending_config size: %0d", pending_config.size()), UVM_LOW)
            
            // Check if pending_config contains the token
            if (pending_config.exists(matched_token)) begin
                cfg = pending_config[matched_token];
                `uvm_info(get_type_name(), $sformatf("Successfully retrieved cfg for matched_token=%0x", matched_token), UVM_LOW)
            end else begin
                `uvm_error(get_type_name(), $sformatf("pending_config does not contain matched_token=%0x", matched_token))
                status = CHECK_INVALID_RESP;
                fail_reason = "Config not found in pending_config";
                // Print all existing tokens for debugging
                `uvm_info(get_type_name(), "Current tokens in pending_config:", UVM_LOW)
                foreach (pending_config[token]) begin
                    `uvm_info(get_type_name(), $sformatf("  token: %0x", token), UVM_LOW)
                end
            end
        end else begin
            // Handle match_count != 1 cases
            if (match_count == 0) begin
                `uvm_error(get_type_name(), $sformatf("No matching config found for offwbf_cmd:\n  plane_num: %0d\n  ost_id_nsu2offline: %0h\n  descramble_seed: %0h\n  dest_sel: %0b", 
                                                    offwbf_tr.plane_num, offwbf_tr.ost_id_nsu2offline, 
                                                    descramble_seed, offwbf_tr.dest_sel))
                status = CHECK_INVALID_RESP;
                fail_reason = "No matching config found";
            end else begin
                `uvm_error(get_type_name(), $sformatf("Multiple matching configs found (%0d matches) for offwbf_cmd:\n  plane_num: %0d\n  ost_id_nsu2offline: %0h\n  descramble_seed: %0h\n  dest_sel: %0b", 
                                                    match_count, offwbf_tr.plane_num, offwbf_tr.ost_id_nsu2offline, 
                                                    descramble_seed, offwbf_tr.dest_sel))
                status = CHECK_INVALID_RESP;
                fail_reason = "Multiple matching configs found";
                // Print all matched tokens for debugging
                `uvm_info(get_type_name(), "Matched tokens:", UVM_LOW)
                foreach (matched_tokens[i]) begin
                    `uvm_info(get_type_name(), $sformatf("  token[%0d]: %0x", i, matched_tokens[i]), UVM_LOW)
                end
            end
        end

        // =========================================================
        // Step 4: Comprehensive check on matched offwbf_cmd
        // =========================================================
        if (status == CHECK_PASS && match_count == 1) begin
            int global_pp = matched_gid * 4 + matched_pp;

            // Check if cfg is valid before accessing its members
            if (cfg == null) begin
                `uvm_error(get_type_name(), $sformatf("cfg is null for matched_token=%0x", matched_token))
                status = CHECK_INVALID_RESP;
                fail_reason = "Null config object";
            end else if (global_pp < 0 || global_pp >= 8) begin
                `uvm_error(get_type_name(), $sformatf("global_pp out of range: %0d (expected 0-7)", global_pp))
                status = CHECK_INVALID_RESP;
                fail_reason = "Invalid global_pp value";
            end else begin
                string info_str;
                info_str = $sformatf({"\n  [Starting Comprehensive Check]\n",
                                      "  Matched Config(ondec):\n",
                                      "    instruction_index: %0h\n",
                                      "    Group: %0d, PP: %0d (Global PP: %0d)\n",
                                      "    OST ID: %0h\n",
                                      "    plane_sel: %0b\n",
                                      "    offline_wbf_work_en: %0b\n",
                                      "    descramble_en: %0b\n",
                                      "    descramble_seed: %0h\n",
                                      "    read_mode: %0b\n",
                                      "    dest_memory_addr: %0h\n",
                                      "    dec_fail_dest_addr: %0h"}, 
                                      matched_instr_idx, matched_gid, matched_pp, global_pp, 
                                      cfg.tr[global_pp].nsu_ost_id, 
                                      cfg.tr[global_pp].plane_sel, 
                                      cfg.tr[global_pp].offline_wbf_work_en, 
                                      cfg.tr[global_pp].descramble_en, 
                                      cfg.tr[global_pp].descramble_seed, 
                                      cfg.tr[global_pp].read_mode, 
                                      cfg.tr[global_pp].dest_memory_addr, 
                                      cfg.tr[global_pp].dec_fail_dest_addr);
                `uvm_info(get_type_name(), info_str, UVM_LOW)
            end
            
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
                else begin//io-read,calculated by nsu-->io_offline_wbf_addr + {allocated_addr,12'd0};
                    // io_offline_wbf_addr + {allocated_addr,12'd0}
                    logic [31:0] exp_io_addr;
                    bit [3:0] allocated_addr;
                    
                    // Allocate address using the address manager (simulates DUT's priority encoder)
                    allocated_addr = allocate_offwbf_addr(offwbf_tr.ost_id_nsu2offline);
                    
                    // Calculate expected IO address
                    exp_io_addr = offwbf_base_addr + {allocated_addr, 12'd0};
                    
                    if (dest_mem_addr_32bit != exp_io_addr) begin
                        // status = CHECK_FAIL_DATA; //TODO FIXME 20260301
                        fail_reason = $sformatf(
                            "Group%0d PP[%0d] dest_mem_addr mismatch in IO-read: expected=%0h (io_offline_wbf_addr=%0h + allocated_addr=%0d), got=%0h",
                            matched_gid, matched_pp, exp_io_addr,
                            offwbf_base_addr, allocated_addr,
                            dest_mem_addr_32bit);
                        `uvm_warning(get_type_name(), fail_reason)//TODO addr allocate method 
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
        // Step 5.5: Free OFFWBF address (simulates DUT's address release)
        // =========================================================
        // Free the allocated address for this ost_id
        free_offwbf_addr(offwbf_tr.ost_id_nsu2offline);
        
        // =========================================================
        // Step 6: Clear offline_wbf_work_en flag for processed plane_pair
        // =========================================================
        if (match_count >= 1 && matched_instr_idx != 16'hFFFF) begin
            int global_pp = matched_gid * 4 + matched_pp;
            bit all_offwbf_completed = 1'b1;
            
            // Clear offline_wbf_work_en for corresponding plane_pair
            pending_config[matched_token].tr[global_pp].offline_wbf_work_en = 1'b0;

            // Check if all plane_pairs in group have offwbf completed
            for (int pp = 0; pp < 8; pp++)begin
                if (cfg.tr[pp].plane_sel && cfg.tr[pp].offline_wbf_work_en)begin
                    all_offwbf_completed = 1'b0;
                    break;
                end
            end

            // If all offwbf work is completed for this token, clear the offwbf flag
            if (all_offwbf_completed)begin
                pending_offwbf[matched_token] = 1'b0;
                `uvm_info(get_type_name(), $sformatf("All OFFWBF work completed for instr_idx=%0h, clearing offwbf flag", cfg.tr[0].instruction_index), UVM_LOW)
            end

            // Check if both deep_resp and offwbf are cleared, then clear config
            if (!pending_deep_resp[matched_token] && !pending_offwbf[matched_token])begin
                pending_config.delete(matched_token);
                `uvm_info(get_type_name(), $sformatf("All responses processed for instr_idx=%0h, clearing config", cfg.tr[0].instruction_index), UVM_LOW)
            end
        end
    end
endtask : check_offwbf_cmd

//-----------------------------------------------------------------------------
// pack_ondec_transactions - Pack 8 plane_pair ondec2nsu_transaction into ondec2nsu_group_transaction
// 
// This task reads 8 individual plane_pair transactions and packs them into a single
// ondec2nsu_group_transaction, maintaining the group structure (Group 0: PP[0:3], Group 1: PP[4:7])
//-----------------------------------------------------------------------------
task `CLASS_NAME_DEFINE::pack_ondec_transactions();
    ondec2nsu_transaction trs[8];
    ondec2nsu_group_transaction group_tr;
    int pp;
    
    forever begin
        bit all_plane_not_selected = 1;
        // Read one transaction from each of the 8 plane_pair FIFOs
        for (pp = 0; pp < 8; pp++)begin
            ondec_fifo[pp].get(trs[pp]);
        end
        
        // Create and populate group transaction
        group_tr = ondec2nsu_group_transaction::type_id::create("group_tr");
        for (pp = 0; pp < 8; pp++)begin
            group_tr.tr[pp] = trs[pp];
        end
        
        // Check if all 8 planes are not selected
        for (pp = 0; pp < 8; pp++)begin
            if (group_tr.tr[pp].plane_sel != 0) begin
                all_plane_not_selected = 0;
                break;
            end
        end
        if (all_plane_not_selected) begin
            `uvm_error(get_type_name(), $sformatf("All 8 are not selected, this is an error: instr_idx=%0h", 
                group_tr.tr[0].instruction_index));
        end
        
        // Write group transaction to output FIFO
        ondec_group_cmd_fifo.put(group_tr);
        
        `uvm_info(get_type_name(), $sformatf("Packed 8 plane_pair transactions into group transaction: instr_idx=%0h", 
            group_tr.tr[0].instruction_index), UVM_LOW)
    end
    
endtask : pack_ondec_transactions

//-----------------------------------------------------------------------------
// init_offwbf_addr_manager - Initialize OFFWBF address management
//-----------------------------------------------------------------------------
function void `CLASS_NAME_DEFINE::init_offwbf_addr_manager();
    offwbf_addr_status = 16'b0;  // All addresses free
    offwbf_base_addr = 32'hA000;  // Example base address
    `uvm_info(get_type_name(), $sformatf("OFFWBF address manager initialized: base_addr=%0h", offwbf_base_addr), UVM_LOW)
    print_offwbf_addr_status();
endfunction : init_offwbf_addr_manager

//-----------------------------------------------------------------------------
// allocate_offwbf_addr - Allocate OFFWBF address for OST ID (simulates DUT's priority encoder)
//-----------------------------------------------------------------------------
function bit [3:0] `CLASS_NAME_DEFINE::allocate_offwbf_addr(bit [4:0] ost_id);
    bit [3:0] addr;
    
    // Check if address already allocated for this ost_id
    if (offwbf_ost_id_to_addr.exists(ost_id)) begin
        addr = offwbf_ost_id_to_addr[ost_id];
        `uvm_info(get_type_name(), $sformatf("OFFWBF address already allocated for ost_id=%0h: addr=%0d", ost_id, addr), UVM_LOW)
        return addr;
    end
    
    // Find first free address (priority encoder behavior)
    for (addr = 0; addr < 16; addr++)begin
        if (!is_offwbf_addr_occupied(addr))begin
            // Allocate address
            offwbf_addr_status[addr] = 1'b1;
            offwbf_ost_id_to_addr[ost_id] = addr;
            `uvm_info(get_type_name(), $sformatf("Allocated OFFWBF address %0d for ost_id=%0h", addr, ost_id), UVM_LOW)
            print_offwbf_addr_status();
            return addr;
        end
    end
    
    // No free address found
    `uvm_error(get_type_name(), $sformatf("No free OFFWBF address available for ost_id=%0h", ost_id))
    return 4'hF;  // Invalid address
endfunction : allocate_offwbf_addr

//-----------------------------------------------------------------------------
// free_offwbf_addr - Free OFFWBF address for OST ID
//-----------------------------------------------------------------------------
function void `CLASS_NAME_DEFINE::free_offwbf_addr(bit [4:0] ost_id);
    bit [3:0] addr;
    
    if (offwbf_ost_id_to_addr.exists(ost_id)) begin
        addr = offwbf_ost_id_to_addr[ost_id];
        offwbf_addr_status[addr] = 1'b0;
        offwbf_ost_id_to_addr.delete(ost_id);
        `uvm_info(get_type_name(), $sformatf("Freed OFFWBF address %0d for ost_id=%0h", addr, ost_id), UVM_LOW)
        print_offwbf_addr_status();
    end else begin
        `uvm_warning(get_type_name(), $sformatf("No OFFWBF address allocated for ost_id=%0h", ost_id))
    end
endfunction : free_offwbf_addr

//-----------------------------------------------------------------------------
// get_allocated_offwbf_addr - Get allocated OFFWBF address for OST ID
//-----------------------------------------------------------------------------
function bit [3:0] `CLASS_NAME_DEFINE::get_allocated_offwbf_addr(bit [4:0] ost_id);
    if (offwbf_ost_id_to_addr.exists(ost_id)) begin
        return offwbf_ost_id_to_addr[ost_id];
    end else begin
        `uvm_warning(get_type_name(), $sformatf("No OFFWBF address allocated for ost_id=%0h", ost_id))
        return 4'hF;  // Invalid address
    end
endfunction : get_allocated_offwbf_addr

//-----------------------------------------------------------------------------
// is_offwbf_addr_occupied - Check if OFFWBF address is occupied
//-----------------------------------------------------------------------------
function bit `CLASS_NAME_DEFINE::is_offwbf_addr_occupied(bit [3:0] addr);
    if (addr < 16) begin
        return offwbf_addr_status[addr];
    end else begin
        `uvm_error(get_type_name(), $sformatf("Invalid OFFWBF address: %0d", addr))
        return 1'b1;  // Treat invalid address as occupied
    end
endfunction : is_offwbf_addr_occupied

//-----------------------------------------------------------------------------
// print_offwbf_addr_status - Print OFFWBF address status
//-----------------------------------------------------------------------------
function void `CLASS_NAME_DEFINE::print_offwbf_addr_status();
    `uvm_info(get_type_name(), $sformatf("OFFWBF address status: %016b", offwbf_addr_status), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("Allocated addresses: %0d/16", $countones(offwbf_addr_status)), UVM_LOW)
endfunction : print_offwbf_addr_status

//-----------------------------------------------------------------------------
// test_offwbf_addr_manager - Test OFFWBF address manager functionality
//-----------------------------------------------------------------------------
function void `CLASS_NAME_DEFINE::test_offwbf_addr_manager();
    bit [3:0] addr1, addr2, addr3;
    
    `uvm_info(get_type_name(), "Testing OFFWBF address manager...", UVM_LOW)
    
    // Test allocation
    addr1 = allocate_offwbf_addr(5'b00001);
    addr2 = allocate_offwbf_addr(5'b00010);
    addr3 = allocate_offwbf_addr(5'b00011);
    
    // Test duplicate allocation
    allocate_offwbf_addr(5'b00001);
    
    // Test free
    free_offwbf_addr(5'b00001);
    
    // Test re-allocation
    addr1 = allocate_offwbf_addr(5'b00100);
    
    // Test get allocated address
    addr1 = get_allocated_offwbf_addr(5'b00010);
    
    `uvm_info(get_type_name(), "OFFWBF address manager test completed", UVM_LOW)
endfunction : test_offwbf_addr_manager

//-----------------------------------------------------------------------------
// check_offwbf_deep_resp - Check offwbf2nsu cmd that needs deep_resp
//-----------------------------------------------------------------------------
task `CLASS_NAME_DEFINE::check_offwbf_deep_resp();
    int offwbf_cmd_count=0;
    logic [15:0]descramble_seed;    
    offdec2nsu_transaction offwbf_tr;    
    forever begin
        offwbf2nsu_cmd_fifo.get(offwbf_tr);
        descramble_seed = descramble_seed_que[offwbf_cmd_count];
        // if(!offwbf_tr.offline_wbf_out_flag && !offwbf_tr.dec_suc)begin //for deep_resp used--dec failed and data not output
        //     // Acquire lock for thread-safe access to deep_resp_offwbf_map
        //     deep_resp_offwbf_map_lock.get();
        //     `uvm_info(get_type_name(), $sformatf("[%0d] Recording  offwbf command that needs deep_resp: descramble_seed=%0h, plane_num=%0d, dec_suc=%b, offline_wbf_out_flag=%b", offwbf_cmd_count,
        //         descramble_seed, offwbf_tr.plane_num, offwbf_tr.dec_suc, offwbf_tr.offline_wbf_out_flag), UVM_LOW);
        //     deep_resp_offwbf_map[descramble_seed] = offwbf_tr;
        //     // Release lock
        //     deep_resp_offwbf_map_lock.put();
        // end


        // Acquire lock for thread-safe access to deep_resp_offwbf_map
        deep_resp_offwbf_map_lock.get();
        `uvm_info(get_type_name(), $sformatf("[%0d] Recording  offwbf command that needs deep_resp: descramble_seed=%0h, plane_num=%0d, dec_suc=%b, offline_wbf_out_flag=%b", offwbf_cmd_count,
            descramble_seed, offwbf_tr.plane_num, offwbf_tr.dec_suc, offwbf_tr.offline_wbf_out_flag), UVM_LOW);
        deep_resp_offwbf_map[descramble_seed] = offwbf_tr;
        // Release lock
        deep_resp_offwbf_map_lock.put();
        offwbf_cmd_count+=1;
    end
endtask : check_offwbf_deep_resp


class token_transaction extends uvm_object;
    `uvm_object_utils(token_transaction)
    
    bit [15:0] instruction_index;
    bit [4:0] group0_ost_id;
    bit [4:0] group1_ost_id;
    bit [22:0] group0_lba;
    bit [22:0] group1_lba;
    
    function new(string name = "token_transaction");
        super.new(name);
    endfunction
    
    // Compare method for associative array indexing
    virtual function bit compare(token_transaction other);
        if (other == null) return 0;
        return (instruction_index == other.instruction_index &&
                group0_ost_id == other.group0_ost_id &&
                group1_ost_id == other.group1_ost_id &&
                group0_lba    == other.group0_lba && 
                group1_lba    == other.group1_lba 
                );
    endfunction
    
    // Hash method for associative array indexing
    virtual function token_hash_t hash();
        token_hash_t hash_val;
        // Combine all fields into a single hash value
        // This allows for easy expansion when adding new fields
        hash_val = {instruction_index, group0_ost_id, group1_ost_id,group0_lba,group1_lba};
        return hash_val;
    endfunction
    
    // Convert to string for debugging
    virtual function string convert2string();
        return $sformatf("token_transaction(instr_idx=0x%0h, group0_ost_id=0x%0h, group1_ost_id=0x%0h)", 
                        instruction_index, group0_ost_id, group1_ost_id);
    endfunction
endclass

`endif