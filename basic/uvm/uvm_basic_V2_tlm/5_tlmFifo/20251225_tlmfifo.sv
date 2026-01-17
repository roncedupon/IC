`include "uvm_macros.svh"
import uvm_pkg::*;

// -------------------------- 1. 定义简单的事务类（TLM FIFO传输的数据类型） --------------------------
class my_trans extends uvm_sequence_item;
  rand int data;        // 事务核心数据
  rand int id;          // 事务ID（用于区分不同事务）

  // 注册字段，支持打印/拷贝
  `uvm_object_utils_begin(my_trans)
    `uvm_field_int(data, UVM_ALL_ON)
    `uvm_field_int(id, UVM_ALL_ON)
  `uvm_object_utils_end

  // 构造函数
  function new(string name = "my_trans");
    super.new(name);
  endfunction
endclass

// -------------------------- 2. 生产者组件：向TLM FIFO写入数据 --------------------------
class producer extends uvm_component;
  `uvm_component_utils(producer)

  // TLM FIFO的写入端口（blocking_put_port：阻塞写入）
  uvm_blocking_put_port #(my_trans) put_port;

  // 构造函数
  function new(string name = "producer", uvm_component parent = null);
    super.new(name, parent);
    put_port = new("put_port", this); // 初始化写入端口
  endfunction

  // 核心逻辑：在run_phase中生成事务并写入FIFO
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this); // 阻止仿真提前结束

    my_trans tr;
    // 生成3个事务并写入FIFO
    for (int i = 0; i < 3; i++) begin
      tr = my_trans::type_id::create("tr");
      assert(tr.randomize() with {data == i*10; id == i;}); // 固定数据方便验证
      
      // 阻塞写入FIFO（FIFO满时会等待）
      `uvm_info("PRODUCER", $sformatf("写入事务：id=%0d, data=%0d", tr.id, tr.data), UVM_MEDIUM)
      put_port.put(tr); // 核心API：put() 阻塞写入
      
      // 写入后查询FIFO已使用深度
      `uvm_info("PRODUCER", $sformatf("FIFO当前已使用深度：%0d", put_port.get_connected_fifo().used()), UVM_MEDIUM)
    end

    phase.drop_objection(this); // 释放objection
  endtask
endclass

// -------------------------- 3. 消费者组件：从TLM FIFO读取数据 --------------------------
class consumer extends uvm_component;
  `uvm_component_utils(consumer)

  // TLM FIFO的读取端口（blocking_get_port：阻塞读取，读取后移除数据）
  uvm_blocking_get_port #(my_trans) get_port;
  // 可选：peek端口（阻塞读取，读取后不移除数据）
  uvm_blocking_peek_port #(my_trans) peek_port;

  // 构造函数
  function new(string name = "consumer", uvm_component parent = null);
    super.new(name, parent);
    get_port = new("get_port", this);   // 初始化读取端口
    peek_port = new("peek_port", this); // 初始化peek端口
  endfunction

  // 核心逻辑：在run_phase中读取FIFO数据
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);

    my_trans tr;
    // 步骤1：peek操作（读取但不移除数据）
    `uvm_info("CONSUMER", "开始peek操作（读取不移除）", UVM_MEDIUM)
    peek_port.peek(tr); // 核心API：peek() 读取不移除
    `uvm_info("CONSUMER", $sformatf("Peek到事务：id=%0d, data=%0d", tr.id, tr.data), UVM_MEDIUM)
    `uvm_info("CONSUMER", $sformatf("Peek后FIFO已使用深度：%0d", peek_port.get_connected_fifo().used()), UVM_MEDIUM)

    // 步骤2：get操作（读取并移除数据）
    `uvm_info("CONSUMER", "开始get操作（读取并移除）", UVM_MEDIUM)
    for (int i = 0; i < 3; i++) begin
      get_port.get(tr); // 核心API：get() 读取并移除
      `uvm_info("CONSUMER", $sformatf("Get到事务：id=%0d, data=%0d", tr.id, tr.data), UVM_MEDIUM)
      `uvm_info("CONSUMER", $sformatf("Get后FIFO已使用深度：%0d", get_port.get_connected_fifo().used()), UVM_MEDIUM)
    end

    // 步骤3：清空FIFO（可选）
    `uvm_info("CONSUMER", "清空FIFO", UVM_MEDIUM)
    get_port.get_connected_fifo().flush(); // 核心API：flush() 清空FIFO
    `uvm_info("CONSUMER", $sformatf("清空后FIFO已使用深度：%0d", get_port.get_connected_fifo().used()), UVM_MEDIUM)

    phase.drop_objection(this);
  endtask
endclass

// -------------------------- 4. 环境类：实例化FIFO、生产者、消费者，并连接端口 --------------------------
class env extends uvm_env;
  `uvm_component_utils(env)

  producer prod;       // 生产者
  consumer cons;       // 消费者
  uvm_tlm_fifo #(my_trans) fifo; // TLM FIFO（深度默认16，可自定义）

  // 构造函数
  function new(string name = "env", uvm_component parent = null);
    super.new(name, parent);
    // 创建FIFO，指定深度为8（可选，默认16）
    fifo = new("fifo", this, 8);
  endfunction

  // Build_phase：创建生产者和消费者
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    prod = producer::type_id::create("prod", this);
    cons = consumer::type_id::create("cons", this);
  endfunction

  // Connect_phase：连接端口和FIFO
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    // 生产者的put_port连接到FIFO的put_export
    prod.put_port.connect(fifo.put_export);
    // 消费者的get_port连接到FIFO的get_export
    cons.get_port.connect(fifo.get_export);
    // 消费者的peek_port连接到FIFO的peek_export
    cons.peek_port.connect(fifo.peek_export);
  endfunction
endclass

// -------------------------- 5. 测试类：启动环境 --------------------------
class tlm_fifo_test extends uvm_test;
  `uvm_component_utils(tlm_fifo_test)

  env env_inst;

  function new(string name = "tlm_fifo_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env_inst = env::type_id::create("env_inst", this);
  endfunction

  // 无需自定义run_phase，依赖组件的run_phase即可
endclass

// -------------------------- 6. 顶层模块：启动UVM仿真 --------------------------
module tb;
  initial begin
    run_test("tlm_fifo_test"); // 启动测试
  end
endmodule