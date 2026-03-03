// 定义命令结构体（模拟实际业务）
typedef struct {
    int cmd_id;
    int cmd_data;
} rcmd_t;

module tb_queue_traverse;
    rcmd_t rcmd_tmp_que[$]; // 命令队列
    rcmd_t curr_cmd;
    initial begin
        // 初始化队列
        rcmd_tmp_que.push_back('{cmd_id: 1, cmd_data: 100});
        rcmd_tmp_que.push_back('{cmd_id: 2, cmd_data: 200});
        rcmd_tmp_que.push_back('{cmd_id: 3, cmd_data: 300});

        // 消费式遍历队列（核心逻辑）
        $display("=== 开始处理命令队列 ===");

        while(rcmd_tmp_que.size()>0) begin
            // 弹出头部命令
            curr_cmd = rcmd_tmp_que.pop_front();
            
            // 处理命令（业务逻辑）
            $display("处理命令ID：%0d，数据：%0d", curr_cmd.cmd_id, curr_cmd.cmd_data);
            
            // 模拟命令处理耗时
            #1;
        end
        
        $display("=== 所有命令处理完成 ===");
        $display("最终队列长度：%0d", rcmd_tmp_que.size()); // 输出0
    end
endmodule