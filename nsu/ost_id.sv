// 1. 定义基础事务类型（可根据你的实际需求扩展字段）
typedef struct {
    int         ost_id;        // 核心索引字段
    logic [31:0] data;         // 事务数据（示例）
    int         len;           // 数据长度（示例）
    logic [7:0]  cmd;          // 命令字（示例）
} transaction_t;

// 2. 定义事务队列类型（便于复用，传统写法兼容所有编译器）
typedef transaction_t transaction_queue_t[$];

// 3. 核心映射类：完全兼容低版本SV编译器
class OstIdTransMap;
    // 关联数组：key=ost_id，value=对应ost_id的事务队列
    protected transaction_queue_t m_ost_trans_map[int];

    // ===================== 核心方法：添加单条事务到指定ost_id的队列 =====================
    function automatic void add_single_trans(int ost_id, transaction_t trans);
        if(!m_ost_trans_map.exists(ost_id)) begin
            m_ost_trans_map[ost_id] = '{}; // 初始化空队列
        end
        m_ost_trans_map[ost_id].push_back(trans);
        $display("[OstIdTransMap] 成功添加事务到ost_id=%0d，当前队列长度：%0d", 
                 ost_id, m_ost_trans_map[ost_id].size());
    endfunction

    // ===================== 核心方法：批量添加事务到指定ost_id的队列 =====================
    function automatic void add_batch_trans(int ost_id, transaction_queue_t trans_q);
        if(!m_ost_trans_map.exists(ost_id)) begin
            m_ost_trans_map[ost_id] = '{};
        end
        // 遍历批量添加（兼容所有编译器）
        foreach(trans_q[i]) begin
            m_ost_trans_map[ost_id].push_back(trans_q[i]);
        end
        $display("[OstIdTransMap] 批量添加%0d条事务到ost_id=%0d，当前队列长度：%0d", 
                 trans_q.size(), ost_id, m_ost_trans_map[ost_id].size());
    endfunction

    // ===================== 核心方法：获取指定ost_id的事务队列 =====================
    function automatic transaction_queue_t get_queue_by_ost_id(int ost_id);
        if(m_ost_trans_map.exists(ost_id)) begin
            get_queue_by_ost_id = m_ost_trans_map[ost_id];
        end else begin
            get_queue_by_ost_id = '{}; // 不存在则返回空队列
            $warning("[OstIdTransMap] ost_id=%0d不存在，返回空队列", ost_id);
        end
    endfunction

    // ===================== 辅助方法：判断ost_id是否存在 =====================
    function automatic bit has_ost_id(int ost_id);
        return m_ost_trans_map.exists(ost_id);
    endfunction

    // ===================== 辅助方法：清空指定ost_id的队列 =====================
    function automatic void clear_queue_by_ost_id(int ost_id);
        if(m_ost_trans_map.exists(ost_id)) begin
            m_ost_trans_map[ost_id].delete();
            $display("[OstIdTransMap] 已清空ost_id=%0d的队列", ost_id);
        end else begin
            $warning("[OstIdTransMap] 清空失败：ost_id=%0d不存在", ost_id);
        end
    endfunction

    // ===================== 辅助方法：获取所有已存在的ost_id（关键修正） =====================
    // 修正：放弃队列返回值，改用"输出参数"方式（兼容所有编译器）
    function automatic void get_all_ost_ids(ref int ids[$]);
        ids.delete(); // 先清空输出队列，避免残留数据
        foreach(m_ost_trans_map[id]) begin
            ids.push_back(id);
        end
    endfunction

    // ===================== 辅助方法：打印所有ost_id的队列信息 =====================
    function automatic void print_all_ost_queues();
        int ids[$]; // 传统队列写法（兼容所有编译器）
        get_all_ost_ids(ids); // 调用修正后的方法（输出参数）
        
        if(ids.size() == 0) begin
            $display("[OstIdTransMap] 无任何ost_id的事务队列");
            return;
        end
        
        $display("[OstIdTransMap] 所有ost_id队列信息：");
        foreach(ids[i]) begin
            transaction_queue_t q = get_queue_by_ost_id(ids[i]);
            $display("  ost_id=%0d：队列长度=%0d", ids[i], q.size());
            foreach(q[j]) begin
                $display("    第%0d条事务：data=0x%0h, len=%0d", j+1, q[j].data, q[j].len);
            end
        end
    endfunction
endclass

// 4. 测试用例：适配修正后的方法
module tb_ost_id_trans_map;
    OstIdTransMap       ost_map;
    transaction_t       trans1;
    transaction_queue_t q1, res_q;
    int                 ids[$]; // 传统队列写法

    initial begin
        ost_map = new();

        // 场景1：添加单条事务
        trans1 = '{ost_id:10, data:32'h12345678, len:4, cmd:8'h01};
        ost_map.add_single_trans(10, trans1);

        // 场景2：批量添加事务
        q1 = '{
            '{ost_id:20, data:32'h87654321, len:8, cmd:8'h02},
            '{ost_id:20, data:32'habcdef00, len:4, cmd:8'h03}
        };
        ost_map.add_batch_trans(20, q1);

        // 场景3：获取指定ost_id的队列
        res_q = ost_map.get_queue_by_ost_id(10);
        $display("\n[测试] 获取ost_id=10的队列：");
        foreach(res_q[i]) begin
            $display("  事务%0d：ost_id=%0d, data=0x%0h", i+1, res_q[i].ost_id, res_q[i].data);
        end

        // 场景4：判断ost_id是否存在
        $display("\n[测试] ost_id=10是否存在：%0b", ost_map.has_ost_id(10));
        $display("[测试] ost_id=30是否存在：%0b", ost_map.has_ost_id(30));

        // 场景5：获取所有ost_id（适配输出参数方式）
        ost_map.get_all_ost_ids(ids);
        $display("\n[测试] 所有已存在的ost_id：");
        foreach(ids[i]) begin
            $display("  ost_id=%0d", ids[i]);
        end

        // 场景6：打印所有队列信息
        $display("\n[测试] 打印所有队列信息：");
        ost_map.print_all_ost_queues();

        // 场景7：清空队列
        ost_map.clear_queue_by_ost_id(20);
        $display("\n[测试] 清空后ost_id=20的队列长度：%0d", ost_map.get_queue_by_ost_id(20).size());

        $finish;
    end
endmodule