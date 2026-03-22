# AXI Master-Slave Environment - Enhanced Version

## 项目概述

这是一个基于 Synopsys SVT AXI VIP 的 AXI4 验证环境框架，包含一个 Master Agent 和一个 Slave Agent，用于验证 AXI4 接口功能。本版本包含增强的验证组件，包括记分板、功能覆盖率和高级测试用例。

## 目录结构

```
axi_env_master_slave/
├── env/                              # 验证环境
│   ├── cust_svt_axi_system_configuration.sv  # 系统配置类
│   ├── axi_basic_env.sv             # 基础环境类
│   ├── axi_virtual_sequencer.sv      # 虚拟序列器
│   ├── axi_scoreboard.sv            # 数据验证记分板
│   ├── axi_coverage.sv              # 功能覆盖率收集
│   ├── axi_master_write_read_sequence.sv  # Master 写读序列
│   ├── axi_slave_response_sequence.sv     # Slave 响应序列
│   └── axi_virtual_sequence.sv      # 虚拟序列
├── tests/                            # 测试用例
│   ├── axi_base_test.sv             # 基础测试类
│   ├── axi_write_read_test.sv       # 写读测试用例
│   └── axi_advanced_test.sv         # 高级测试用例
├── hdl_interconnect/                 # 硬件互连
│   ├── axi_dut.v                    # Pass-through DUT
│   └── axi_dut_wrapper.sv           # DUT 封装
├── top.sv                            # 顶层模块
├── Makefile                          # 编译脚本
└── README.md                         # 说明文档
```

## 功能特性

### 1. Master Agent
- 支持AXI4协议完整特性
- 64位数据宽度，32位地址宽度
- 可配置的突发传输（支持FIXED, INCR, WRAP）
- 支持读写事务及数据验证
- 多未完成事务支持

### 2. Slave Agent
- 内置存储模型，支持64KB内存
- 自动响应机制，支持随机延迟
- 数据完整性检查
- 支持所有AXI4响应类型

### 3. 虚拟序列
- 协调Master和Slave序列
- 支持数据验证
- 可配置事务数量

### 4. 增强验证组件
- **记分板(Scoreboard)**：实时跟踪和验证数据一致性
- **功能覆盖率**：收集AXI协议各项功能覆盖率
- **高级测试**：支持多种突发类型和边界条件测试

## 使用方法

### 前置条件
1. Synopsys VCS 仿真器
2. SVT AXI VIP 许可证
3. UVM 1.2 库

### 编译与运行

```bash
# 设置VIP路径
export VIP_HOME=/path/to/vip/svt_axi

# 编译
make compile

# 运行仿真
make run

# 带波形的调试运行
make debug

# 生成波形文件
make wave

# 使用Verdi查看波形
make verdi
```

### 查看日志
```bash
cat sim.log
```

## 配置参数

### 顶层参数 (top.sv)
```systemverilog
// 序列长度（事务数量）
uvm_config_db#(int unsigned)::set(null, "uvm_test_top.env", "sequence_length", 20);

// 时钟周期
parameter CLOCK_PERIOD = 10;  // 10ns = 100MHz
```

### AXI配置 (cust_svt_axi_system_configuration.sv)
```systemverilog
// 基础接口配置
this.master_cfg[0].data_width = 64;      // 64位数据宽度
this.master_cfg[0].addr_width = 32;      // 32位地址宽度
this.master_cfg[0].id_width = 4;         // 4位ID宽度
this.master_cfg[0].user_width = 8;       // 8位用户信号宽度

// 高级配置
this.master_cfg[0].outstanding_xact = 8; // 支持8个未完成事务
this.master_cfg[0].max_burst_length = 16; // 最大突发长度
this.slave_cfg[0].mem_size = 32'h10000; // 64KB从设备内存
```

### 测试选择
```bash
# 运行基础测试
make run TESTNAME=axi_write_read_test

# 运行高级测试
make run TESTNAME=axi_advanced_test
```

## 运行流程

1. **复位阶段**：复位信号保持10个时钟周期
2. **配置阶段**：UVM环境初始化，配置传递
3. **主序列阶段**：Master发送写读事务
4. **从序列阶段**：Slave响应事务请求
5. **验证阶段**：检查读写数据一致性
6. **结束阶段**：生成覆盖率报告

## 注意事项

1. 确保 `VIP_HOME` 环境变量指向正确的 VIP 安装路径
2. 运行前检查许可证是否可用
3. 修改配置时注意 Master 和 Slave 的参数匹配
