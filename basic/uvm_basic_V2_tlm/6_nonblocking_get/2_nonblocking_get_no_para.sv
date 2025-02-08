`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
typedef class my_driver;
typedef class my_sequence;
//try get 没有参数
//1. 定义数据类
class Packet extends uvm_sequence_item;
  rand bit [7:0] addr;
  rand bit [7:0] data;

  `uvm_object_utils_begin(Packet)
    `uvm_field_int(addr, UVM_ALL_ON)
    `uvm_field_int(data, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "Packet");
    super.new(name);
  endfunction
endclass
class cfg extends uvm_object;
  rand bit [7:0] tx_nums;
  rand bit[2:0]data_width;
  `uvm_object_utils_begin(cfg)
    `uvm_field_int(tx_nums, UVM_ALL_ON)
    `uvm_field_int(data_width, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "cfg");
    super.new(name);
  endfunction
endclass

//2. 创建monitor
class my_monitor extends uvm_monitor;
  `uvm_component_utils(my_monitor)
  
  uvm_nonblocking_get_port#(cfg) m_get_port;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_get_port = new("m_get_port", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    cfg configuration;

    while(1)begin
      while(~m_get_port.try_get(configuration))begin
        `uvm_info("monitor", "waiting to receive configuration", UVM_LOW)        

      end
      configuration.print(uvm_default_line_printer);
    end

  endtask
endclass

//3. 创建sequencer
class my_sequencer extends uvm_sequencer#(Packet);
  bit can_get_flag=0;
  cfg configuration;
  `uvm_component_utils(my_sequencer)

  uvm_nonblocking_get_imp#(cfg, my_sequencer) m_get_imp;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    m_get_imp = new("m_get_imp", this);
  endfunction

  virtual function bit try_get(output cfg o_configuration);
    o_configuration=configuration;
    return can_get(); // 表示获取成功
  endfunction

  virtual function bit can_get();
      if(can_get_flag==1)begin
        can_get_flag=0;
        return 1;
      end
      else begin
        return 0;
      end
  endfunction
endclass

// 4. 连接端口与实现
class MyTest extends uvm_test;

    `uvm_component_utils(MyTest)

    my_sequencer sequencer;
    my_driver driver; // 添加 driver 的声明
    my_monitor monitor;

    function new(string name = "MyTest", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        sequencer = my_sequencer::type_id::create("sequencer", this);
        monitor = my_monitor::type_id::create("monitor", this);
        driver = my_driver::type_id::create("driver", this); // 实例化 driver

        // 配置默认序列
        uvm_config_db#(uvm_object_wrapper)::set(this, "sequencer.main_phase", "default_sequence", my_sequence::type_id::get());
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        // 连接 monitor 和 sequencer 的端口
        monitor.m_get_port.connect(sequencer.m_get_imp);

        // 连接 driver 和 sequencer
        driver.seq_item_port.connect(sequencer.seq_item_export); // 将 driver 的端口连接到 sequencer 的 export
    endfunction

endclass


//5. 创建sequence
class my_sequence extends uvm_sequence;
  my_sequencer target_sequencer;
  Packet pkt;
  `uvm_object_utils(my_sequence)
  function new(string name="my_sequence");
    super.new(name);
  endfunction
  virtual task body();
    super.body();
  if(starting_phase!=null)
    starting_phase.raise_objection(this);
  //先获取m_sequencer的句柄，并且置位can_get_flag,这样monitor那边就能get到新的配置了
    if($cast(target_sequencer,m_sequencer))begin
      target_sequencer.configuration=new("configuration");
      assert(target_sequencer.configuration.randomize());
      target_sequencer.can_get_flag=1;
    end
    else begin
      `uvm_fatal("cast error","cast m_sequencer to my_sequencer failed");
    end
  //然后再把transaction打给driver
  repeat(10)begin
    pkt=new("pkt");
    assert(pkt.randomize());
    `uvm_send(pkt)
  end
  if(starting_phase!=null)
    starting_phase.drop_objection(this);
  endtask
endclass


class my_driver extends uvm_driver #(Packet);
    // 声明虚拟接口
    // virtual my_if vif;

    `uvm_component_utils(my_driver)

    // 构造函数
    function new(string name = "my_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // 在build_phase中获取虚拟接口
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // if (!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
        //     `uvm_fatal("my_driver", "virtual interface must be set for vif!!!");
    endfunction

    // 在run_phase中获取事务并打印
    virtual task run_phase(uvm_phase phase);
        Packet req; // 声明请求事务
        forever begin
            seq_item_port.get_next_item(req); // 从sequencer获取事务
            // 打印事务信息
            #100;
            req.print();
            seq_item_port.item_done(); // 通知sequencer事务已完成处理
        end
    endtask
endclass


module top;
    reg clk;
    reg rstn;

    initial begin
        run_test("MyTest");
    end
    initial begin

        $display("start run dut test");
        $fsdbDumpfile("waves.fsdb");
        $fsdbDumpvars(0,top,"+mda");
   
        $dumpfile ("waves.vcd");//生成vcd文件，映射回windows远程文件夹，目前存放在上级目录中的waves中
        $dumpvars(0,top);
    end
    initial begin
        clk=0;
        rstn=0;
        #1000
        rstn=1;
        #5000
        $display("finish sim");
        $finish;
    end
    always#5 clk=~clk;

endmodule

/*
在 UVM 中，每个 run_phase 都是允许并行执行的，这意味着不同的组件可以同时进行各自的运行阶段。然而，如果在某个组件的 run_phase 中编写了一个不消耗仿真时间的 while(1) 死循环，环境会卡死的原因可以归结为以下几点：

1. 仿真时间和时间消耗
UVM 中的 run_phase 是一个 task phase，这意味着它会消耗仿真时间。每个 run_phase 的执行过程必须在仿真时间的上下文中运行。
当你在一个组件的 run_phase 中写入 while(1) 循环，它将不断占用时间片，不会让出控制权给其他组件。
2. 阻塞性控制
Blocking执行：while(1) 循环是一个阻塞性操作，它会阻止控制流继续到达其他正在运行的 run_phase，导致系统无法进行时间更新和其他组件的处理。
其他组件的运行也依赖于状态的更新和控制，如果某个组件的 run_phase 不退出或阻塞，整个仿真将无法继续。
3. UVM的objection机制
UVM使用objection机制来控制仿真过程中的执行。当一个组件的 run_phase 被阻止（如在死循环中），它将不会主动释放对仿真进程的控制权，其他组件的 run_phase 也不能开始。
这意味着，除非该组件的 run_phase 结束（例如，退出循环），否则其它任何请求都无法被处理，导致整个仿真环境“挂起”。
4. 通用的仿真原理
UVM仿真依赖于时间和事件的推进。任何长时间阻塞操作（如 while(1)）都可能导致仿真无法正常前进，仿真时间无法更新，也无其他事件被触发。
解决方案
如要在 run_phase 中执行长时间的操作，应考虑使用以下方法：

使用定时器或者控制信号：设置一个条件使循环可以在适当时候结束，而不是无限循环。
实现可中断的逻辑：通过在循环中引入待处理的事件或可检测的信号，使得可以适时退出循环，提供其他组件运行的机会。
*/