// 测试模块
module test_delete_queue;

  // 假设的事务类
  class tsu2nsu_transaction;
    int id;
    function new(int id);
      this.id = id;
    endfunction
  endclass

  // 修复后的函数
  function void delete_queue_items(ref tsu2nsu_transaction src_que[$], const ref tsu2nsu_transaction del_que[$]);
    int del_cnt = 0;
    int idx_que[$];
    if(src_que.size() == 0 || del_que.size() == 0) return;

    foreach(del_que[i]) begin
      if(del_que[i] == null) $fatal(0, "item in del que is null");
      idx_que = src_que.find_index with(item == del_que[i]);
      if(idx_que.size()>0) begin 
        // 关键修复：按降序排序索引
        idx_que.sort();
        idx_que.reverse();
        foreach(idx_que[idx])begin
          src_que.delete(idx_que[idx]); 
          del_cnt++; 
        end
      end
    end
    $display("Deleted %0d matched queue items", del_cnt);
  endfunction          
       

  initial begin
    // 创建测试队列
    tsu2nsu_transaction item1 = new(1);
    tsu2nsu_transaction item2 = new(2);
    tsu2nsu_transaction item3 = new(3);
    tsu2nsu_transaction item4 = new(4);
    tsu2nsu_transaction item5 = new(5);

    // 源队列
    tsu2nsu_transaction src_que[$] = {item1, item2, item3, item4, item5};
    
    // 待删除队列
    tsu2nsu_transaction del_que[$] = {item2, item4};

    $display("初始源队列:");
    foreach(src_que[i]) $display("  元素 %0d: id = %0d", i, src_que[i].id);

    $display("待删除队列:");
    foreach(del_que[i]) $display("  元素 %0d: id = %0d", i, del_que[i].id);

    // 调用删除函数
    delete_queue_items(src_que, del_que);

    $display("删除后的源队列:");
    foreach(src_que[i]) $display("  元素 %0d: id = %0d", i, src_que[i].id);
  end

endmodule