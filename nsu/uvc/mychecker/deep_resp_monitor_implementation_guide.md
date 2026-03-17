# deep_resp_monitor 实现指南

## 1. 需求分析

### 1.1 功能需求
- 实现一个 `deep_resp_monitor` 类，继承自 `uvm_component`
- 通过 AXI 接口获取 deep_resp 数据
- 支持地址范围为 0x4000~0x57D4 的数据读取
- 每个 deep_resp entry 由 14 个 32bit 组成，需要 14 次读取才能完成一个完整 entry
- 共 109 个 entry
- 实现 SVT AXI transaction 类型的 imp 接口
- 实现 `uvm_tlm_analysis_fifo#(nsu2cpu_deep_resp_transaction)` 用于输出完整的 deep_resp 事务

### 1.2 技术要求
- 参考 `$VIP_HOME` 目录下的 `svt_axi_transaction` 定义
- 参考 `/mnt/disk_0/IC/nsu/uvc/mychecker/nsu_cpu_transactions.sv` 中的 `nsu2cpu_deep_resp_transaction` 定义
- 确保 imp 接口的 write 函数只接受指定地址范围内的数据
- 将 14 个 32bit 数据打包成一个完整的 `nsu2cpu_deep_resp_transaction` 并送入 analysis fifo

## 2. 设计思路

### 2.1 组件结构
```
deep_resp_monitor
├── axi_trans_imp (uvm_tlm_analysis_imp#(svt_axi_transaction, deep_resp_monitor))
├── deep_read_resp_que (uvm_tlm_analysis_fifo#(nsu2cpu_deep_resp_transaction))
├── deep_resp_data (logic [31:0][14]) - 临时存储 14 个 32bit 数据
└── 地址范围常量定义
```

### 2.2 工作流程
1. AXI monitor 通过 imp 接口发送 `svt_axi_transaction` 到 `deep_resp_monitor`
2. `deep_resp_monitor` 检查地址是否在 0x4000~0x57D4 范围内
3. 计算当前数据对应的 entry 索引和 word 索引
4. 存储数据到 `deep_resp_data` 数组中
5. 当收集到 14 个 word 时，创建 `nsu2cpu_deep_resp_transaction` 对象
6. 将收集的数据复制到新创建的 transaction 中
7. 调用 `fields_assignment()` 方法解析字段
8. 将完整的 transaction 写入 `deep_read_resp_que`

## 3. 实现步骤

### 3.1 步骤 1：创建 deep_resp_monitor 类
```systemverilog
class deep_resp_monitor extends uvm_component;
  // 组件定义
endclass
```

### 3.2 步骤 2：导入必要的包和定义接口
```systemverilog
// Import SVT AXI transaction
import svt_axi_v1_0_pkg::svt_axi_transaction;

// TLM imp interface for SVT AXI transactions
uvm_tlm_analysis_imp#(svt_axi_transaction, deep_resp_monitor) axi_trans_imp;

// Analysis FIFO for deep read responses
uvm_tlm_analysis_fifo#(nsu2cpu_deep_resp_transaction) deep_read_resp_que;
```

### 3.3 步骤 3：定义本地存储和常量
```systemverilog
// Local storage for deep response data
logic [31:0] deep_resp_data[14];

// Address range constants
localparam bit [31:0] DEEP_RESP_BASE_ADDR = 32'h4000;
localparam bit [31:0] DEEP_RESP_END_ADDR = 32'h57D4;
localparam int ENTRY_SIZE = 14; // 14 words per entry
localparam int TOTAL_ENTRIES = 109;
```

### 3.4 步骤 4：实现构造函数
```systemverilog
function new(string name = "deep_resp_monitor", uvm_component parent = null);
super.new(name, parent);
axi_trans_imp = new("axi_trans_imp", this);
deep_read_resp_que = new("deep_read_resp_que", this);
endfunction
```

### 3.5 步骤 5：实现 write 函数
```systemverilog
function void write(svt_axi_transaction trans);
  // 地址和数据提取
  // 地址范围检查
  // 计算索引
  // 数据存储
  // 完整 entry 检查和处理
endfunction
```

### 3.6 步骤 6：实现标准 UVM 阶段方法
```systemverilog
function void build_phase(uvm_phase phase);
super.build_phase(phase);
endfunction

function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
endfunction

task run_phase(uvm_phase phase);
super.run_phase(phase);
endtask
```

## 4. 代码解析

### 4.1 关键数据结构
- **axi_trans_imp**：TLM 分析接口，用于接收来自 AXI monitor 的事务
- **deep_read_resp_que**：分析 FIFO，用于输出完整的 deep_resp 事务
- **deep_resp_data**：临时存储 14 个 32bit 数据的数组

### 4.2 地址计算逻辑
```systemverilog
int entry_offset = addr - DEEP_RESP_BASE_ADDR;
int entry_idx = entry_offset / (ENTRY_SIZE * 4); // 4 bytes per word
int word_idx = (entry_offset % (ENTRY_SIZE * 4)) / 4;
```
- `entry_offset`：计算当前地址与基地址的偏移量
- `entry_idx`：计算当前地址对应的 entry 索引
- `word_idx`：计算当前地址在 entry 中的 word 索引

### 4.3 数据处理流程
1. 检查地址是否在有效范围内
2. 提取 AXI 事务中的数据
3. 存储数据到对应位置
4. 当收集到完整的 14 个 word 时，创建并填充 deep_resp 事务
5. 调用 `fields_assignment()` 解析字段
6. 将事务写入 FIFO

## 5. 如何使用

### 5.1 在环境中实例化
```systemverilog
deep_resp_monitor deep_resp_mon;

function void build_phase(uvm_phase phase);
super.build_phase(phase);
deep_resp_mon = deep_resp_monitor::type_id::create("deep_resp_mon", this);
endfunction
```

### 5.2 连接 AXI monitor
```systemverilog
function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
// 连接 AXI monitor 的分析端口到 deep_resp_monitor 的 imp 接口
axi_monitor.analysis_port.connect(deep_resp_mon.axi_trans_imp);
endfunction
```

### 5.3 使用 deep_read_resp_que
```systemverilog
// 在其他组件中获取 deep_read_resp_que 的分析导出
uvm_tlm_analysis_export#(nsu2cpu_deep_resp_transaction) deep_resp_export;

function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
deep_resp_mon.deep_read_resp_que.connect(deep_resp_export);
endfunction
```

## 6. 注意事项

1. **地址范围检查**：确保只处理 0x4000~0x57D4 范围内的地址
2. **数据完整性**：确保每个 entry 收集完整的 14 个 word
3. **数据顺序**：确保数据按照正确的顺序存储到 deep_resp_data 数组中
4. **字段解析**：调用 `fields_assignment()` 确保所有字段被正确解析
5. **错误处理**：处理没有读取数据的情况

## 7. 性能考虑

- **内存使用**：使用固定大小的数组存储临时数据，避免动态内存分配
- **时间效率**：直接计算索引，避免复杂的地址映射逻辑
- **并发性**：使用 TLM 接口确保线程安全的数据传输

## 8. 测试建议

1. **地址范围测试**：测试边界地址（0x4000 和 0x57D4）
2. **数据完整性测试**：确保 14 个 word 被正确收集和打包
3. **字段解析测试**：验证 `fields_assignment()` 正确解析所有字段
4. **性能测试**：测试连续读取多个 entry 的情况

## 9. 总结

`deep_resp_monitor` 是一个专门用于从 AXI 总线收集和处理 deep_resp 数据的 UVM 组件。它通过 TLM 接口接收 AXI 事务，过滤出指定地址范围内的数据，将 14 个 32bit 数据打包成一个完整的 `nsu2cpu_deep_resp_transaction`，并通过分析 FIFO 输出。

该实现满足了所有需求，包括地址范围检查、数据完整性保证和字段解析。它设计简洁，易于集成到现有的 UVM 环境中。