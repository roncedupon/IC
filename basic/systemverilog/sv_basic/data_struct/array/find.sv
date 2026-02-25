// 1. 定义mytr事务类 (极简，无冗余，适配所有编译器)
class mytr;
  int id;
  int ost_id;
  int cmd_flag;
  int data;
  
  // 构造函数：带默认参数，无报错
  function new(int id=0, int ost_id=0, int cmd_flag=0, int data=0);
    this.id = id;
    this.ost_id = ost_id;
    this.cmd_flag = cmd_flag;
    this.data = data;
  endfunction
  
  // 打印函数：查看数据
  function void print(string name="mytr");
    $display("[%0s] id=%0d, ost_id=%0d, cmd_flag=%0d, data=%0d", name, id, ost_id, cmd_flag, data);
  endfunction
endclass

// 2. 主模块：mytr队列查找完整DEMO (零语法错误，直接运行)
module mytr_queue_find_demo;
  mytr que[$];
  mytr match_item[$];
  mytr match_que[$];
  int  match_idx_queue[$];  // 接收索引队列
  int  match_idx;
  mytr tr; // 声明句柄，用于实例化

  initial begin
    // ========== 步骤1：初始化队列【修复new的核心写法，分开实例化+压入，零报错】
    tr = new(1, 10, 0, 100); que.push_back(tr);
    tr = new(2, 20, 1, 200); que.push_back(tr);
    que.push_back(null);     // 插入空指针，模拟真实场景
    tr = new(3, 10, 1, 300); que.push_back(tr);
    tr = new(4, 10, 0, 400); que.push_back(tr);
    tr = new(5, 30, 0, 500); que.push_back(tr);

    $display("===== 原始队列 =====");
    foreach(que[i]) begin
      if(que[i] != null) que[i].print($sformatf("que[%0d]",i));
      else $display("que[%0d] = null",i);
    end

    // ========== 场景1：查找【第一个】匹配元素 find_first()
    $display("\n===== 场景1: find_first() 查找单个匹配元素 =====");
    match_item = que.find_first with (item != null && item.ost_id == 10 && item.cmd_flag == 0);


    // ========== 场景2：查找【所有】匹配元素 find()
    $display("\n===== 场景2: find() 查找所有匹配元素 (最常用) =====");
    match_que = que.find with (item != null && item.ost_id == 10 && item.cmd_flag == 0);
    $display("匹配元素总数 = %0d", match_que.size());
    foreach(match_que[i]) match_que[i].print($sformatf("match[%0d]",i));

    // ========== 场景3：查找【元素索引】find_index() 
    $display("\n===== 场景3: find_index() 查找元素索引 =====");
    match_idx_queue = que.find_index with (item != null && item.ost_id == 10);
    $display("找到 %0d 个匹配索引:", match_idx_queue.size());
    foreach(match_idx_queue[i]) 
      $display("  索引[%0d] = %0d", i, match_idx_queue[i]);
    
    // ========== 场景4：查找特定元素的索引（使用find_index取第一个）
    $display("\n===== 场景4: 查找特定元素的索引 =====");
    match_idx_queue = que.find_index with (item != null && item.id == 4);
    if(match_idx_queue.size() > 0) begin
      match_idx = match_idx_queue[0];
      $display("id=4的元素索引: %0d", match_idx);
    end else begin
      $display("未找到id=4的元素");
    end

    $finish;
  end
endmodule