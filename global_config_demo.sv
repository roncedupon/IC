`ifndef GLOBAL_CONFIG_DEMO_SV
`define GLOBAL_CONFIG_DEMO_SV

// 全局config类，定义在class外部
class global_config_t;
  int max_data_width;
  int timeout_cycles;
  bit enable_debug;
  string device_name;
  
  // 随机变量
  rand int random_seed;
  rand bit [7:0] random_value;
  rand enum {LOW, MEDIUM, HIGH} priority_level;
  rand int temperature;
  
  // 构造函数
  function new(int max_data_width = 32, int timeout_cycles = 1000, 
               bit enable_debug = 1, string device_name = "DUT");
    this.max_data_width = max_data_width;
    this.timeout_cycles = timeout_cycles;
    this.enable_debug = enable_debug;
    this.device_name = device_name;
    
    // 随机初始化
    randomize();
  endfunction
  
  // 打印配置
  function void print();
    $display("Global Config:");
    $display("  max_data_width: %0d", max_data_width);
    $display("  timeout_cycles: %0d", timeout_cycles);
    $display("  enable_debug: %0b", enable_debug);
    $display("  device_name: %s", device_name);
    $display("  random_seed: %0d", random_seed);
    $display("  random_value: %0h", random_value);
    $display("  priority_level: %s", priority_level.name());
    $display("  temperature: %0d", temperature);
  endfunction
endclass

// 全局config实例
global_config_t global_config = new();

// 使用全局config的类
class my_agent;
  string name;
  
  function new(string name = "my_agent");
    this.name = name;
  endfunction
  
  function void print_config();
    $display("[%s] Global Config:", name);
    $display("  max_data_width: %0d", global_config.max_data_width);
    $display("  timeout_cycles: %0d", global_config.timeout_cycles);
    $display("  enable_debug: %0b", global_config.enable_debug);
    $display("  device_name: %s", global_config.device_name);
  endfunction
  
  function void run();
    $display("[%s] Running with config: data_width=%0d, timeout=%0d", 
             name, global_config.max_data_width, global_config.timeout_cycles);
    if (global_config.enable_debug) begin
      $display("[%s] Debug mode enabled", name);
    end
  endfunction
endclass

// 另一个使用全局config的类
class my_monitor;
  string name;
  
  function new(string name = "my_monitor");
    this.name = name;
  endfunction
  
  function void check_config();
    $display("[%s] Checking config for device: %s", name, global_config.device_name);
    if (global_config.max_data_width > 64) begin
      $display("[%s] Warning: Data width exceeds recommended limit", name);
    end
  endfunction
endclass

// 测试模块
module test_global_config;
  my_agent agent;
  my_monitor monitor;
  
  initial begin
    $display("=== Global Config Demo ===");
    
    // 创建实例
    agent = new("Agent1");
    monitor = new("Monitor1");
    
    // 打印初始配置
    $display("\n1. Initial global config:");
    global_config.print();
    agent.print_config();
    
    // 运行agent
    $display("\n2. Running agent:");
    agent.run();
    
    // 检查配置
    $display("\n3. Checking config:");
    monitor.check_config();
    
    // 修改全局配置
    $display("\n4. Modifying global config:");
    global_config.max_data_width = 64;
    global_config.enable_debug = 0;
    global_config.device_name = "NewDUT";
    
    // 打印修改后的配置
    $display("\n5. Updated global config:");
    global_config.print();
    agent.print_config();
    
    // 再次运行agent
    $display("\n6. Running agent with updated config:");
    agent.run();
    
    $display("\n=== Demo Complete ===");
  end
endmodule

`endif // GLOBAL_CONFIG_DEMO_SV
