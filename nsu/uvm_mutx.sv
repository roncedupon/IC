`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*; // 确保完整导入UVM包

// 1. 定义事务类
class transaction_t extends uvm_sequence_item;
  `uvm_object_utils(transaction_t)
  
  int         ost_id;
  logic [31:0] data;
  int         len;
  logic [7:0]  cmd;

  function new(string name = "transaction_t");
    super.new(name);
  endfunction

  // 随机化方法（用于producer产生测试数据）
  function void randomize_trans(int ost_id);
    this.ost_id = ost_id;
    this.data   = $urandom_range(32'h1000, 32'hFFFF);
    this.len    = $urandom_range(1, 8);
    this.cmd    = $urandom_range(8'h01, 8'h0F);
  endfunction

  // 打印事务信息（纯英文输出）
  function void print();
    `uvm_info("TRANSACTION", $sformatf("ost_id=%0d, data=0x%0h, len=%0d, cmd=0x%0h", 
               ost_id, data, len, cmd), UVM_MEDIUM)
  endfunction
endclass

// 2. Producer类：通过analysis port发送事务
class producer extends uvm_component;
  `uvm_component_utils(producer)
  
  uvm_analysis_port#(transaction_t) ap; // 分析端口
  int send_count; // 发送计数
  int target_ost_id; // 目标ost_id

  function new(string name = "producer", uvm_component parent = null);
    super.new(name, parent);
    ap = new("ap", this);
    send_count = 0;
    target_ost_id = 10; // 固定ost_id，可按需修改
  endfunction

  // 主任务：周期性发送事务（模拟异步写入）
  virtual task run_phase(uvm_phase phase);
    transaction_t trans;
    phase.raise_objection(this);
    
    `uvm_info("PRODUCER_START", "Start sending transactions to checker...", UVM_LOW)
    
    // 循环发送5个事务（模拟持续写入）
    repeat(5) begin
      trans = transaction_t::type_id::create("trans");
      trans.randomize_trans(target_ost_id);
      send_count++;
      
      // 通过analysis port发送事务（触发checker的write函数）
      ap.write(trans);
      `uvm_info("PRODUCER_SEND", $sformatf("Sent transaction #%0d to checker", send_count), UVM_MEDIUM)
      trans.print();
      
      // 随机延时（模拟异步时序）
      #10ns;
    //   #($urandom_range(10, 50) ns);
    end
    
    `uvm_info("PRODUCER_FINISH", "Finished sending all transactions", UVM_LOW)
    phase.drop_objection(this);
  endtask
endclass

// 3. Checker类：接收事务并处理（核心同步逻辑：替换为uvm_semaphore）
class checker extends uvm_component;
  `uvm_component_utils(checker)
  
  uvm_analysis_imp#(transaction_t, checker) analysis_imp; // 分析实现端口
  transaction_t trans_queue[$]; // 共享队列（易产生冲突）
  semaphore queue_sem; // 核心替换：用uvm_semaphore替代uvm_mutex
  uvm_event trigger_event; // 触发事件：控制run_phase处理时机

  function new(string name = "checker", uvm_component parent = null);
    super.new(name, parent);
    analysis_imp = new("analysis_imp", this);
    // 初始化信号量：计数值=1（等价于互斥锁）
    queue_sem = new("queue_sem", 1); 
    trigger_event = new("trigger_event"); // 初始化触发事件
  endfunction

  // write函数：接收事务并写入队列（加锁保护）
  virtual function void write(transaction_t t);
    // 1. 获取信号量（阻塞式，等价于lock）
    queue_sem.get(1);
    
    // 2. 写入队列（原子操作）
    trans_queue.push_back(t);
    `uvm_info("CHECKER_WRITE", $sformatf("Added transaction to queue, current queue size: %0d", trans_queue.size()), UVM_MEDIUM)
    
    // 3. 释放信号量（等价于unlock）
    queue_sem.put(1);
    
    // 4. 触发run_phase处理（每写入1个事务触发1次）
    trigger_event.trigger();
  endfunction

  // run_phase：随机访问/删除队列元素（加锁保护）
  virtual task run_phase(uvm_phase phase);
    int target_idx; // 目标元素索引（模拟随机访问，非FIFO）
    super.run_phase(phase);

    
    phase.raise_objection(this);
    `uvm_info("CHECKER_START", "Start processing transactions from queue...", UVM_LOW)
    
    forever begin
      // 等待触发事件（无数据时阻塞）
      trigger_event.wait_trigger();
      
      // 1. 获取信号量（与write函数互斥）
      queue_sem.get(1);
      
      // 2. 模拟随机访问：取队列中第3个元素（索引2），若无则取最后1个
      if(trans_queue.size() >= 3) begin
        target_idx = 2;
      end else if(trans_queue.size() > 0) begin
        target_idx = trans_queue.size() - 1;
      end else begin
        `uvm_warning("CHECKER_EMPTY", "Queue is empty, skip processing")
        queue_sem.put(1); // 必须释放信号量，避免死锁
        continue;
      end
      
      // 3. 处理目标元素并删除
      `uvm_info("CHECKER_PROCESS", $sformatf("Processing element at index %0d (queue size: %0d)", target_idx, trans_queue.size()), UVM_MEDIUM)
      trans_queue[target_idx].print();
      trans_queue.delete(target_idx); // 删除指定索引元素
      `uvm_info("CHECKER_DELETE", $sformatf("Deleted element at index %0d, current queue size: %0d", target_idx, trans_queue.size()), UVM_MEDIUM)
      
      // 4. 释放信号量
      queue_sem.put(1);
      
      // 模拟处理延时（可选）
      #10 ns;
    end
    
    phase.drop_objection(this);
  endtask
endclass

// 4. Env类：连接producer和checker
class env extends uvm_env;
  `uvm_component_utils(env)
  
  producer prod;
  checker chk;

  function new(string name = "env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // 构建阶段：创建组件
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    prod = producer::type_id::create("prod", this);
    chk = checker::type_id::create("chk", this);
  endfunction

  // 连接阶段：绑定analysis port和imp
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    prod.ap.connect(chk.analysis_imp); // 核心连接
    `uvm_info("ENV_CONNECT", "Connected producer's analysis port to checker's analysis imp", UVM_LOW)
  endfunction
endclass

// 5. Test类：顶层测试
class base_test extends uvm_test;
  `uvm_component_utils(base_test)
  
  env env_h;

  function new(string name = "base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env_h = env::type_id::create("env_h", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    
    // 等待producer和checker完成工作
    #1000 ns;
    
    `uvm_info("TEST_FINISH", "Test completed successfully", UVM_LOW)
    phase.drop_objection(this);
  endtask
endclass

// 6. 顶层模块：启动UVM仿真
module tb;
  initial begin
    run_test("base_test");
  end
endmodule