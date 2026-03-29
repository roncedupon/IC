`ifndef QUEUE_DEMO_SV
`define QUEUE_DEMO_SV

// 定义一个简单的类
class my_item;
  int id;
  int value;
  
  function new(int id = 0, int value = 0);
    this.id = id;
    this.value = value;
  endfunction
  
  function void print();
    $display("Item: id=%0d, value=%0d", id, value);
  endfunction
endclass

// 测试模块
module test_queue;
  // 定义队列，元素类型为my_item
  my_item queue[$];
  my_item item;
  
  // 定义semaphore用于加锁
  semaphore sem = new(1);
  
  // 标志位，指示push任务是否正在运行
  bit push_task_running;
  
  // 进程1：push数据到队列
  task push_task();
    my_item temp_item;
    
    for (int i = 0; i < 5; i++) begin
      // 加锁
      sem.get();
      
      // new一个class实例作为中间变量
      temp_item = new(i, i * 10);
      // 赋值给item变量
      item = temp_item;
      
      // 模拟队列大小异常增长的问题
      if (i == 0) begin
        // 第一次push，正常添加一个元素
        queue.push_back(temp_item);
      end else if (i == 1) begin
        // 第二次push，异常添加3个元素（总共4个）
        queue.push_back(temp_item);
        queue.push_back(new(10, 100)); // 额外添加元素
        queue.push_back(new(11, 110)); // 额外添加元素
      end else begin
        // 后续push，正常添加一个元素
        queue.push_back(temp_item);
      end
      
      // 打印队列大小
      $display("[Push] After push_back item %0d: queue size = %0d", i, queue.size());
      // 打印刚push的item
      temp_item.print();
      
      // 解锁
      sem.put();
      
      // 随机延迟
      #($urandom_range(1, 5));
    end
    
    // push任务完成，设置标志位为0
    push_task_running = 0;
  endtask
  
  // 进程2：从队列pop数据
  task pop_task();
    // 等待一段时间，让push任务先开始
    #2;
    
    while (1) begin
      // 加锁
      sem.get();
      
      if (queue.size() > 0) begin
        // pop_front获取队列头部元素
        item = queue.pop_front();
        // 打印队列大小
        $display("[Pop] After pop_front: queue size = %0d", queue.size());
        // 打印刚pop的item
        item.print();
      end else if (queue.size() == 0 && !push_task_running) begin
        // 队列为空且push任务已完成，退出循环
        sem.put();
        break;
      end
      
      // 解锁
      sem.put();
      
      // 随机延迟
      #($urandom_range(1, 3));
    end
  endtask
  
  initial begin
    $display("=== Queue Demo with Semaphore ===");
    
    // 初始队列大小
    $display("Initial queue size: %0d", queue.size());
    
    // 启动两个进程
    push_task_running = 1;
    fork
      push_task();
      pop_task();
    join
    
    // 最终队列大小
    $display("\nFinal queue size: %0d", queue.size());
    
    $display("=== Demo Complete ===");
  end
endmodule

`endif // QUEUE_DEMO_SV
