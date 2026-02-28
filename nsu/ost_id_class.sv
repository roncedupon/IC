// 1. 定义事务类（保持不变）
class transaction_t;
    int         ost_id;        // 核心索引字段
    logic [31:0] data;         // 事务数据（示例）
    int         len;           // 数据长度（示例）
    logic [7:0]  cmd;          // 命令字（示例）

    // 构造函数：初始化成员变量
    function new(int ost_id=0, logic [31:0] data=0, int len=0, logic [7:0] cmd=0);
        this.ost_id = ost_id;
        this.data   = data;
        this.len    = len;
        this.cmd    = cmd;
    endfunction

    // 打印事务信息的方法
    function void print();
        $display("  ost_id=%0d, data=0x%0h, len=%0d, cmd=0x%0h", 
                 ost_id, data, len, cmd);
    endfunction
endclass

// 2. 核心映射类：队列类型内嵌到类内部，代码更整洁
class OstIdTransMap;
    // ===================== 内嵌类型定义（核心优化） =====================
    // 将事务队列类型定义在类内部，仅该类及外部通过类名引用
    typedef transaction_t transaction_queue_t[$];

    // ===================== 成员变量（使用内嵌类型） =====================
    // 关联数组：key=ost_id，value=类内部定义的事务队列类型
    protected transaction_queue_t m_ost_trans_map[int];

    // ===================== 核心方法：添加单条事务 =====================
    function automatic void add_single_trans(int ost_id, transaction_t trans);
        if(trans == null) begin
            $error("[OstIdTransMap] 添加失败：事务句柄为null！");
            return;
        end
        if(!m_ost_trans_map.exists(ost_id)) begin
            m_ost_trans_map[ost_id] = '{};
        end
        m_ost_trans_map[ost_id].push_back(trans);
        $display("[OstIdTransMap] 成功添加事务到ost_id=%0d，当前队列长度：%0d", 
                 ost_id, m_ost_trans_map[ost_id].size());
    endfunction

    // ===================== 核心方法：批量添加事务 =====================
    function automatic void add_batch_trans(int ost_id, transaction_queue_t trans_q);
        if(!m_ost_trans_map.exists(ost_id)) begin
            m_ost_trans_map[ost_id] = '{};
        end
        foreach(trans_q[i]) begin
            if(trans_q[i] == null) begin
                $warning("[OstIdTransMap] 批量添加时跳过空句柄（索引%0d）", i);
                continue;
            end
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
            get_queue_by_ost_id = '{};
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
            foreach(m_ost_trans_map[ost_id][i]) begin
                m_ost_trans_map[ost_id][i] = null;
            end
            m_ost_trans_map[ost_id].delete();
            $display("[OstIdTransMap] 已清空ost_id=%0d的队列", ost_id);
        end else begin
            $warning("[OstIdTransMap] 清空失败：ost_id=%0d不存在", ost_id);
        end
    endfunction

    // ===================== 辅助方法：获取所有已存在的ost_id =====================
    function automatic void get_all_ost_ids(ref int ids[$]);
        ids.delete();
        foreach(m_ost_trans_map[id]) begin
            ids.push_back(id);
        end
    endfunction

    // ===================== 辅助方法：打印所有ost_id的队列信息 =====================
    function automatic void print_all_ost_queues();
        int ids[$];
        get_all_ost_ids(ids);
        
        if(ids.size() == 0) begin
            $display("[OstIdTransMap] 无任何ost_id的事务队列");
            return;
        end
        
        $display("[OstIdTransMap] 所有ost_id队列信息：");
        foreach(ids[i]) begin
            transaction_queue_t q = get_queue_by_ost_id(ids[i]);
            $display("  ost_id=%0d：队列长度=%0d", ids[i], q.size());
            foreach(q[j]) begin
                $display("    第%0d条事务：", j+1);
                q[j].print();
            end
        end
    endfunction
endclass

// 4. 测试用例：外部使用内嵌类型需通过"类名::类型名"引用
module tb_ost_id_trans_map;
    OstIdTransMap                ost_map;
    transaction_t                trans1, trans2, trans3;
    // 外部引用类内部的队列类型：OstIdTransMap::transaction_queue_t
    OstIdTransMap::transaction_queue_t q1, res_q;
    int                          ids[$];

    initial begin
        ost_map = new();

        // 场景1：添加单条事务
        trans1 = new(10, 32'h12345678, 4, 8'h01);
        ost_map.add_single_trans(10, trans1);

        // 场景2：批量添加事务
        trans2 = new(20, 32'h87654321, 8, 8'h02);
        trans3 = new(20, 32'habcdef00, 4, 8'h03);
        q1 = '{trans2, trans3}; // 直接使用内嵌类型
        ost_map.add_batch_trans(20, q1);

        // 场景3：获取指定ost_id的队列并打印
        res_q = ost_map.get_queue_by_ost_id(10);
        $display("\n[测试] 获取ost_id=10的队列：");
        foreach(res_q[i]) begin
            $display("  事务%0d详情：", i+1);
            res_q[i].print();
        end

        // 场景4：判断ost_id是否存在
        $display("\n[测试] ost_id=10是否存在：%0b", ost_map.has_ost_id(10));
        $display("[测试] ost_id=30是否存在：%0b", ost_map.has_ost_id(30));

        // 场景5：获取所有ost_id
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