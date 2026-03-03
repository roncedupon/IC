// 1. Transaction class definition (unchanged)
class transaction_t;
    int         ost_id;        // Core index field
    logic [31:0] data;         // Transaction data (example)
    int         len;           // Data length (example)
    logic [7:0]  cmd;          // Command byte (example)

    // Constructor: Initialize member variables
    function new(int ost_id=0, logic [31:0] data=0, int len=0, logic [7:0] cmd=0);
        this.ost_id = ost_id;
        this.data   = data;
        this.len    = len;
        this.cmd    = cmd;
    endfunction

    // Method: Print transaction information
    function void print();
        $display("  ost_id=%0d, data=0x%0h, len=%0d, cmd=0x%0h", 
                 ost_id, data, len, cmd);
    endfunction
endclass

// 2. Core mapping class: Queue type embedded inside the class for cleaner code structure
class OstIdTransMap;
    // ===================== Embedded type definition (core optimization) =====================
    // Define transaction queue type inside the class, accessible only via class name externally
    typedef transaction_t transaction_queue_t[$];

    // ===================== Member variables (using embedded type) =====================
    // Associative array: key=ost_id, value=transaction queue type defined inside the class
    protected transaction_queue_t m_ost_trans_map[int];

    // ===================== Core method: Add single transaction =====================
    function automatic void add_single_trans(int ost_id, transaction_t trans);
        if(trans == null) begin
            $error("[OstIdTransMap] Failed to add transaction: null handle!");
            return;
        end
        if(!m_ost_trans_map.exists(ost_id)) begin
            m_ost_trans_map[ost_id] = '{};
        end
        m_ost_trans_map[ost_id].push_back(trans);
        $display("[OstIdTransMap] Successfully added transaction to ost_id=%0d, current queue length: %0d", 
                 ost_id, m_ost_trans_map[ost_id].size());
    endfunction

    // ===================== Core method: Add batch transactions =====================
    function automatic void add_batch_trans(int ost_id, transaction_queue_t trans_q);
        if(!m_ost_trans_map.exists(ost_id)) begin
            m_ost_trans_map[ost_id] = '{};
        end
        foreach(trans_q[i]) begin
            if(trans_q[i] == null) begin
                $warning("[OstIdTransMap] Skipping null handle during batch addition (index %0d)", i);
                continue;
            end
            m_ost_trans_map[ost_id].push_back(trans_q[i]);
        end
        $display("[OstIdTransMap] Batch added %0d transactions to ost_id=%0d, current queue length: %0d", 
                 trans_q.size(), ost_id, m_ost_trans_map[ost_id].size());
    endfunction

    // ===================== Core method: Get transaction queue by ost_id =====================
    function automatic transaction_queue_t get_queue_by_ost_id(int ost_id);
        if(m_ost_trans_map.exists(ost_id)) begin
            get_queue_by_ost_id = m_ost_trans_map[ost_id];
        end else begin
            get_queue_by_ost_id = '{};
            $warning("[OstIdTransMap] ost_id=%0d does not exist, returning empty queue", ost_id);
        end
    endfunction

    // ===================== Auxiliary method: Check if ost_id exists =====================
    function automatic bit has_ost_id(int ost_id);
        return m_ost_trans_map.exists(ost_id);
    endfunction

    // ===================== Auxiliary method: Clear queue by ost_id =====================
    function automatic void clear_queue_by_ost_id(int ost_id);
        if(m_ost_trans_map.exists(ost_id)) begin
            foreach(m_ost_trans_map[ost_id][i]) begin
                m_ost_trans_map[ost_id][i] = null;
            end
            m_ost_trans_map[ost_id].delete();
            $display("[OstIdTransMap] Cleared queue for ost_id=%0d", ost_id);
        end else begin
            $warning("[OstIdTransMap] Clear failed: ost_id=%0d does not exist", ost_id);
        end
    endfunction

    // ===================== Auxiliary method: Get all existing ost_ids =====================
    function automatic void get_all_ost_ids(ref int ids[$]);
        ids.delete();
        foreach(m_ost_trans_map[id]) begin
            ids.push_back(id);
        end
    endfunction

    // ===================== Auxiliary method: Print all ost_id queue information =====================
    function automatic void print_all_ost_queues();
        int ids[$];
        get_all_ost_ids(ids);
        
        if(ids.size() == 0) begin
            $display("[OstIdTransMap] No ost_id transaction queues exist");
            return;
        end
        
        $display("[OstIdTransMap] All ost_id queue information:");
        foreach(ids[i]) begin
            transaction_queue_t q = get_queue_by_ost_id(ids[i]);
            $display("  ost_id=%0d: queue length=%0d", ids[i], q.size());
            foreach(q[j]) begin
                $display("    Transaction #%0d:", j+1);
                q[j].print();
            end
        end
    endfunction
endclass

// 4. Testbench: Reference embedded type via "class name::type name" externally
module tb_ost_id_trans_map;
    OstIdTransMap                ost_map;
    transaction_t                trans1, trans2, trans3;
    // Reference embedded queue type externally: OstIdTransMap::transaction_queue_t
    OstIdTransMap::transaction_queue_t q1, res_q;
    int                          ids[$];

    initial begin
        ost_map = new();

        // Scenario 1: Add single transaction
        trans1 = new(10, 32'h12345678, 4, 8'h01); 
        ost_map.add_single_trans(10, trans1);

        // Scenario 2: Add batch transactions
        trans2 = new(20, 32'h87654321, 8, 8'h02);
        trans3 = new(20, 32'habcdef00, 4, 8'h03);
        q1 = '{trans2, trans3}; // Use embedded type directly
        ost_map.add_batch_trans(20, q1);

        // Scenario 3: Get queue by ost_id and print
        res_q = ost_map.get_queue_by_ost_id(10);
        $display("\n[Test] Get queue for ost_id=10:");
        foreach(res_q[i]) begin
            $display("  Transaction %0d details:", i+1);
            res_q[i].print();
        end

        // Scenario 4: Check if ost_id exists
        $display("\n[Test] Does ost_id=10 exist: %0b", ost_map.has_ost_id(10));
        $display("[Test] Does ost_id=30 exist: %0b", ost_map.has_ost_id(30));

        // Scenario 5: Get all existing ost_ids
        ost_map.get_all_ost_ids(ids);
        $display("\n[Test] All existing ost_ids:");
        foreach(ids[i]) begin
            $display("  ost_id=%0d", ids[i]);
        end

        // Scenario 6: Print all queue information
        $display("\n[Test] Print all queue info:");
        ost_map.print_all_ost_queues();

        // Scenario 7: Clear queue
        ost_map.clear_queue_by_ost_id(20);
        $display("\n[Test] Queue length for ost_id=20 after clear: %0d", ost_map.get_queue_by_ost_id(20).size());

        $finish;
    end
endmodule