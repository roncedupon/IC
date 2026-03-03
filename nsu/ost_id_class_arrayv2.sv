// 1. 示例：tsu2nsu_transaction 定义（模拟你项目中的真实 transaction）
class tsu2nsu_transaction;
    int         ost_id;        // Core index field
    logic [31:0] data;         // Transaction data
    int         len;           // Data length
    logic [7:0]  cmd;          // Command byte

    function new(int ost_id=0, logic [31:0] data=0, int len=0, logic [7:0] cmd=0);
        this.ost_id = ost_id;
        this.data   = data;
        this.len    = len;
        this.cmd    = cmd;
    endfunction

    function void print();
        $display("  ost_id=%0d, data=0x%0h, len=%0d, cmd=0x%0h", 
                 ost_id, data, len, cmd);
    endfunction
endclass

// 2. 参数化核心映射类：支持任意 transaction 类型 + 多映射表数组
class OstIdTransMap #(type ITEM_TYPE = tsu2nsu_transaction);
    // ===================== Embedded type definition (using parameterized ITEM_TYPE) =====================
    typedef ITEM_TYPE transaction_queue_t[$];

    // ===================== Member variables: Array of maps =====================
    // m_ost_trans_map_array[map_idx][ost_id] = transaction_queue_t
    protected transaction_queue_t m_ost_trans_map_array[int][int];

    // ===================== Core method: Add single transaction (with map_idx) =====================
    function automatic void add_single_trans(int map_idx, int ost_id, ITEM_TYPE trans);
        if(trans == null) begin
            $error("[OstIdTransMap] Failed to add transaction: null handle!");
            return;
        end
        // Initialize map_idx if not exists
        if(!m_ost_trans_map_array.exists(map_idx)) begin
            m_ost_trans_map_array[map_idx] = '{};
        end
        // Initialize ost_id queue if not exists
        if(!m_ost_trans_map_array[map_idx].exists(ost_id)) begin
            m_ost_trans_map_array[map_idx][ost_id] = '{};
        end
        m_ost_trans_map_array[map_idx][ost_id].push_back(trans);
        $display("[OstIdTransMap] [Map=%0d] Successfully added transaction to ost_id=%0d, current queue length: %0d", 
                 map_idx, ost_id, m_ost_trans_map_array[map_idx][ost_id].size());
    endfunction

    // ===================== Core method: Add batch transactions (with map_idx) =====================
    function automatic void add_batch_trans(int map_idx, int ost_id, transaction_queue_t trans_q);
        if(!m_ost_trans_map_array.exists(map_idx)) begin
            m_ost_trans_map_array[map_idx] = '{};
        end
        if(!m_ost_trans_map_array[map_idx].exists(ost_id)) begin
            m_ost_trans_map_array[map_idx][ost_id] = '{};
        end
        foreach(trans_q[i]) begin
            if(trans_q[i] == null) begin
                $warning("[OstIdTransMap] [Map=%0d] Skipping null handle during batch addition (index %0d)", map_idx, i);
                continue;
            end
            m_ost_trans_map_array[map_idx][ost_id].push_back(trans_q[i]);
        end
        $display("[OstIdTransMap] [Map=%0d] Batch added %0d transactions to ost_id=%0d, current queue length: %0d", 
                 map_idx, trans_q.size(), ost_id, m_ost_trans_map_array[map_idx][ost_id].size());
    endfunction

    // ===================== Core method: Get transaction queue by map_idx and ost_id =====================
    function automatic transaction_queue_t get_queue_by_ost_id(int map_idx, int ost_id);
        if(m_ost_trans_map_array.exists(map_idx) && m_ost_trans_map_array[map_idx].exists(ost_id)) begin
            get_queue_by_ost_id = m_ost_trans_map_array[map_idx][ost_id];
        end else begin
            get_queue_by_ost_id = '{};
            $warning("[OstIdTransMap] [Map=%0d] ost_id=%0d does not exist, returning empty queue", map_idx, ost_id);
        end
    endfunction

    // ===================== Auxiliary method: Check if map_idx exists =====================
    function automatic bit has_map(int map_idx);
        return m_ost_trans_map_array.exists(map_idx);
    endfunction

    // ===================== Auxiliary method: Check if ost_id exists in specific map =====================
    function automatic bit has_ost_id(int map_idx, int ost_id);
        if(m_ost_trans_map_array.exists(map_idx)) begin
            return m_ost_trans_map_array[map_idx].exists(ost_id);
        end else begin
            return 0;
        end
    endfunction

    // ===================== Auxiliary method: Clear queue by map_idx and ost_id =====================
    function automatic void clear_queue_by_ost_id(int map_idx, int ost_id);
        if(m_ost_trans_map_array.exists(map_idx) && m_ost_trans_map_array[map_idx].exists(ost_id)) begin
            foreach(m_ost_trans_map_array[map_idx][ost_id][i]) begin
                m_ost_trans_map_array[map_idx][ost_id][i] = null;
            end
            m_ost_trans_map_array[map_idx][ost_id].delete();
            $display("[OstIdTransMap] [Map=%0d] Cleared queue for ost_id=%0d", map_idx, ost_id);
        end else begin
            $warning("[OstIdTransMap] [Map=%0d] Clear failed: ost_id=%0d does not exist", map_idx, ost_id);
        end
    endfunction

    // ===================== Auxiliary method: Clear entire map =====================
    function automatic void clear_entire_map(int map_idx);
        if(m_ost_trans_map_array.exists(map_idx)) begin
            foreach(m_ost_trans_map_array[map_idx][ost_id]) begin
                clear_queue_by_ost_id(map_idx, ost_id);
            end
            m_ost_trans_map_array.delete(map_idx);
            $display("[OstIdTransMap] [Map=%0d] Cleared entire map", map_idx);
        end else begin
            $warning("[OstIdTransMap] [Map=%0d] Clear failed: map does not exist", map_idx);
        end
    endfunction

    // ===================== Auxiliary method: Get all map indices =====================
    function automatic void get_all_map_indices(ref int map_indices[$]);
        map_indices.delete();
        foreach(m_ost_trans_map_array[map_idx]) begin
            map_indices.push_back(map_idx);
        end
    endfunction

    // ===================== Auxiliary method: Get all ost_ids in a specific map =====================
    function automatic void get_all_ost_ids_in_map(int map_idx, ref int ids[$]);
        ids.delete();
        if(m_ost_trans_map_array.exists(map_idx)) begin
            foreach(m_ost_trans_map_array[map_idx][id]) begin
                ids.push_back(id);
            end
        end
    endfunction

    // ===================== Auxiliary method: Print all information for a specific map =====================
    function automatic void print_map(int map_idx);
        int ids[$];
        
        if(!m_ost_trans_map_array.exists(map_idx)) begin
            $display("[OstIdTransMap] [Map=%0d] Map does not exist", map_idx);
            return;
        end
        
        get_all_ost_ids_in_map(map_idx, ids);
        
        if(ids.size() == 0) begin
            $display("[OstIdTransMap] [Map=%0d] No ost_id transaction queues exist", map_idx);
            return;
        end
        
        $display("[OstIdTransMap] [Map=%0d] All ost_id queue information:", map_idx);
        foreach(ids[i]) begin
            transaction_queue_t q = get_queue_by_ost_id(map_idx, ids[i]);
            $display("  ost_id=%0d: queue length=%0d", ids[i], q.size());
            foreach(q[j]) begin
                $display("    Transaction #%0d:", j+1);
                q[j].print(); // 要求 transaction 类必须有 print() 方法
            end
        end
    endfunction

    // ===================== Auxiliary method: Print all maps =====================
    function automatic void print_all_maps();
        int map_indices[$];
        get_all_map_indices(map_indices);
        
        if(map_indices.size() == 0) begin
            $display("[OstIdTransMap] No maps exist");
            return;
        end
        
        $display("[OstIdTransMap] === Printing all maps ===");
        foreach(map_indices[i]) begin
            print_map(map_indices[i]);
        end
        $display("[OstIdTransMap] === Finished printing all maps ===");
    endfunction
endclass

// 3. Testbench: 使用 tsu2nsu_transaction 测试参数化类
module tb_ost_id_trans_map;
    // 关键：例化参数化类，指定 ITEM_TYPE 为 tsu2nsu_transaction
    OstIdTransMap #(tsu2nsu_transaction)                ost_map;
    tsu2nsu_transaction                                    trans1, trans2, trans3, trans4;
    OstIdTransMap #(tsu2nsu_transaction)::transaction_queue_t q1, q2, res_q;
    int                                                    map_indices[$], ids[$];

    initial begin
        ost_map = new();

        // ============================================================
        // Test Map 0
        // ============================================================
        $display("\n\n");
        $display("################################################################");
        $display("### TESTING MAP 0 (tsu2nsu_transaction) ###");
        $display("################################################################");

        // Scenario 1: Add single transaction
        trans1 = new(10, 32'h12345678, 4, 8'h01); 
        ost_map.add_single_trans(0, 10, trans1);

        // Scenario 2: Add batch transactions
        trans2 = new(20, 32'h87654321, 8, 8'h02);
        trans3 = new(20, 32'habcdef00, 4, 8'h03);
        q1 = '{trans2, trans3};
        ost_map.add_batch_trans(0, 20, q1);

        // ============================================================
        // Test Map 1
        // ============================================================
        $display("\n\n");
        $display("################################################################");
        $display("### TESTING MAP 1 (tsu2nsu_transaction) ###");
        $display("################################################################");

        // Scenario 3: Add single transaction
        trans4 = new(30, 32'hdeadbeef, 16, 8'hff); 
        ost_map.add_single_trans(1, 30, trans4);

        // Scenario 4: Add batch transactions
        q2 = '{trans4, trans1};
        ost_map.add_batch_trans(1, 40, q2);

        // ============================================================
        // Verification and Print
        // ============================================================
        $display("\n\n");
        $display("################################################################");
        $display("### VERIFICATION AND PRINT ###");
        $display("################################################################");

        // Check existence
        $display("\n[Test] Does Map 0 exist: %0b", ost_map.has_map(0));
        $display("[Test] Does ost_id=10 exist in Map 0: %0b", ost_map.has_ost_id(0, 10));

        // Get and print queue
        res_q = ost_map.get_queue_by_ost_id(0, 10);
        $display("\n[Test] Get queue for ost_id=10 in Map 0:");
        foreach(res_q[i]) begin
            $display("  Transaction %0d details:", i+1);
            res_q[i].print();
        end

        // Print all maps
        $display("\n[Test] Print all maps:");
        ost_map.print_all_maps();

        // ============================================================
        // Clear and Verify
        // ============================================================
        $display("\n\n");
        $display("################################################################");
        $display("### CLEAR AND VERIFY ###");
        $display("################################################################");

        ost_map.clear_queue_by_ost_id(0, 20);
        ost_map.clear_entire_map(1);
        
        $display("\n[Test] Print final state:");
        ost_map.print_all_maps();

        $finish;
    end
endmodule