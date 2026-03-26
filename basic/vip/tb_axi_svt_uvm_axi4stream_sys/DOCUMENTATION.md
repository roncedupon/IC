# AXI4-Stream UVM Verification Environment 完整技术文档

## 目录
1. [概述](#1-概述)
2. [项目结构](#2-项目结构)
3. [架构设计](#3-架构设计)
4. [文件详解](#4-文件详解)
5. [配置系统](#5-配置系统)
6. [序列库](#6-序列库)
7. [测试用例](#7-测试用例)
8. [运行仿真](#8-运行仿真)
9. [接口信号](#9-接口信号)
10. [最佳实践](#10-最佳实践)

---

## 1. 概述

### 1.1 简介
本项目是一个基于 Synopsys AXI4-Stream VIP 的 UVM 验证环境示例，用于验证 AXI4-Stream 协议接口。该环境展示了如何使用 Synopsys DesignWare VIP 构建完整的 UVM testbench。

### 1.2 版权声明
```
COPYRIGHT (C) 2010, 2011, 2012, 2013 SYNOPSYS INC.
All Rights Reserved.
```

### 1.3 主要特性
- 完整的 UVM 验证环境框架
- 支持 AXI4-Stream 协议
- 单 Master / 单 Slave 配置
- 多种测试场景示例
- 支持 VCS 仿真器
- 波形调试支持

---

## 2. 项目结构

### 2.1 目录树
```
tb_axi_svt_uvm_axi4stream_sys/
├── README                      # 项目说明文档
├── Makefile                    # 编译仿真控制脚本
├── top.sv                      # 顶层 testbench 模块
├── top_test.sv                 # 测试文件包含列表
├── filelist.f                  # 文件列表
├── compile_opts                # 编译选项
├── sim_run_options             # 仿真运行选项
├── pc.optcfg                   # 配置文件
├── waves.tcl                   # DVE 波形配置脚本
├── waves.rc                    # 波形配置文件
├── run_axi_svt_uvm_axi4stream_sys  # 运行脚本
│
├── env/                        # 验证环境目录
│   ├── axi_basic_env.sv                    # 基础环境类
│   ├── axi_virtual_sequencer.sv            # 虚拟 sequencer
│   ├── axi_base_test.sv                    # 基础测试类
│   ├── cust_svt_axi_system_configuration.sv         # 系统配置类
│   ├── cust_svt_axi_system_cc_configuration.sv     # Config Creator 配置类
│   ├── cust_svt_axi_master_transaction.sv          # 自定义 Master 事务
│   ├── axi_master_random_sequence.sv               # 随机 Master 序列
│   ├── axi_master_zero_delay_sequence.sv           # 零延迟 Master 序列
│   ├── axi_master_random_discrete_sequence.sv      # 离散随机 Master 序列
│   ├── axi_master_random_discrete_virtual_sequence.sv # 虚拟离散序列
│   ├── axi_slave_mem_response_sequence.sv          # Slave 内存响应序列
│   ├── axi_slave_mem_zero_delay_sequence.sv        # Slave 零延迟响应序列
│   ├── axi_simple_reset_sequence.sv                # 复位序列
│   └── axi_null_virtual_sequence.sv                # 空虚拟序列
│
├── tests/                      # 测试用例目录
│   ├── ts.base_test.sv         # 基础测试
│   ├── ts.random_test.sv       # 随机测试
│   ├── ts.zero_delay_random_test.sv  # 零延迟随机测试
│   └── ts.config_creator_test.sv     # Config Creator 测试
│
├── hdl_interconnect/           # DUT 目录
│   ├── axi_svt_dut.v           # DUT Verilog 模块
│   └── axi_svt_dut_sv_wrapper.sv   # DUT SystemVerilog 包装器
│
└── simulation/                 # 仿真结果目录
    └── YYYY-MM-DD/
        └── build/              # 编译输出
```

---

## 3. 架构设计

### 3.1 整体架构图
```
┌─────────────────────────────────────────────────────────────────────────┐
│                          UVM Testbench (test_top)                       │
│  ┌─────────────────────────────────────────────────────────────────┐   │
│  │                    AXI System ENV (axi_basic_env)               │   │
│  │  ┌───────────────────────┐    ┌───────────────────────┐       │   │
│  │  │   AXI Master Agent    │    │    AXI Slave Agent    │       │   │
│  │  │  ┌─────┐  ┌────────┐ │    │  ┌────────┐  ┌─────┐ │       │   │
│  │  │  │Master│  │Monitor │ │    │  │Monitor │  │Slave│ │       │   │
│  │  │  │Driver│  │        │ │    │  │        │  │Driver│ │       │   │
│  │  │  └─────┘  └────────┘ │    │  └────────┘  └─────┘ │       │   │
│  │  │   *Active Mode*      │    │    *Active Mode*     │       │   │
│  │  └───────────┬───────────┘    └───────────┬─────────┘       │   │
│  │              │                            │                  │   │
│  └──────────────│────────────────────────────│──────────────────┘   │
│                 │                            │                      │
│                 ▼                            ▼                      │
│  ┌──────────────────────────────────────────────────────────────┐   │
│  │                  DUT (axi_svt_dut)                           │   │
│  │           [Pass-through AXI4-Stream Connection]              │   │
│  └──────────────────────────────────────────────────────────────┘   │
│                                                                       │
│  ┌─────────────────┐    ┌─────────────────┐                         │
│  │  axi_reset_if   │    │   svt_axi_if    │                         │
│  │  (Reset Interface)   │ (AXI Interface) │                         │
│  └─────────────────┘    └─────────────────┘                         │
└─────────────────────────────────────────────────────────────────────────┘
```

### 3.2 UVM 组件层次结构
```
test_top (module)
└── uvm_test_top
    └── axi_base_test / random_test / zero_delay_random_test / config_creator_test
        └── env (axi_basic_env)
            ├── axi_system_env (svt_axi_system_env)
            │   ├── master[0] (svt_axi_master_agent)
            │   │   ├── sequencer (svt_axi_master_sequencer)
            │   │   ├── driver (svt_axi_master_driver)
            │   │   └── monitor (svt_axi_master_monitor)
            │   ├── slave[0] (svt_axi_slave_agent)
            │   │   ├── sequencer (svt_axi_slave_sequencer)
            │   │   ├── driver (svt_axi_slave_driver)
            │   │   └── monitor (svt_axi_slave_monitor)
            │   └── sequencer (svt_axi_system_virtual_sequencer)
            └── sequencer (axi_virtual_sequencer)
```

### 3.3 连接关系
- **Master Agent**: 连接到 DUT 的 Master 侧接口 (axi_if.master_if[0])
- **Slave Agent**: 连接到 DUT 的 Slave 侧接口 (axi_if.slave_if[0])
- **DUT**: 简单的直通连接，将 Master 输出连接到 Slave 输入

---

## 4. 文件详解

### 4.1 顶层文件

#### 4.1.1 top.sv - 顶层 Testbench
**文件路径**: `top.sv`

**功能描述**:
- 实例化 AXI 接口和复位接口
- 生成时钟信号
- 通过 `uvm_config_db` 传递接口到 UVM 环境
- 启动 UVM 测试 (`run_test()`)

**关键代码片段**:
```systemverilog
module test_top;
    // 时钟周期参数
    parameter simulation_cycle = 50;
    bit SystemClock;
    
    // 导入 UVM 和 VIP 包
    import uvm_pkg::*;
    import svt_uvm_pkg::*;
    import svt_axi_uvm_pkg::*;
    
    // AXI 系统接口实例
    svt_axi_if axi_if();
    assign axi_if.common_aclk = SystemClock;
    
    // 复位接口实例
    axi_reset_if axi_reset_if();
    assign axi_if.master_if[0].aresetn = axi_reset_if.reset;
    assign axi_if.slave_if[0].aresetn = axi_reset_if.reset;
    
    // DUT 实例化
    axi_svt_dut_sv_wrapper dut_wrapper (axi_if);
    
    initial begin
        // 配置接口到 config_db
        uvm_config_db#(virtual axi_reset_if.axi_reset_modport)::set(
            uvm_root::get(), "uvm_test_top.env.sequencer", "reset_mp", 
            axi_reset_if.axi_reset_modport);
        uvm_config_db#(svt_axi_vif)::set(
            uvm_root::get(), "uvm_test_top.env.axi_system_env", "vif", axi_if);
        run_test();
    end
endmodule
```

#### 4.1.2 top_test.sv - 测试文件包含
**文件路径**: `top_test.sv`

**功能**: 包含所有测试类文件

```systemverilog
`include "ts.base_test.sv"
`include "ts.random_test.sv"
`include "ts.zero_delay_random_test.sv"
`include "ts.config_creator_test.sv"
```

### 4.2 环境文件 (env/)

#### 4.2.1 axi_basic_env.sv - 基础环境类
**文件路径**: `env/axi_basic_env.sv`

**类定义**:
```systemverilog
class axi_basic_env extends uvm_env;
    `uvm_component_utils(axi_basic_env)
    
    // 组件成员
    svt_axi_system_env axi_system_env;     // AXI System ENV
    axi_virtual_sequencer sequencer;        // TB 虚拟 sequencer
    cust_svt_axi_system_configuration cfg;  // 系统配置
    cust_svt_axi_system_cc_configuration cc_cfg; // CC 配置
    
    function new(string name="axi_basic_env", uvm_component parent=null);
        super.new(name, parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // 支持三种配置方式:
        // 1. Config Creator 配置
        // 2. 测试传递的配置
        // 3. 默认配置
        
        if (uvm_config_db#(cust_svt_axi_system_cc_configuration)::get(
            this, "", "cc_cfg", cc_cfg)) begin
            uvm_config_db#(svt_axi_system_configuration)::set(
                this, "axi_system_env", "cfg", cc_cfg);
        end
        else if (uvm_config_db#(cust_svt_axi_system_configuration)::get(
            this, "", "cfg", cfg)) begin
            uvm_config_db#(svt_axi_system_configuration)::set(
                this, "axi_system_env", "cfg", cfg);
        end
        else begin
            cfg = cust_svt_axi_system_configuration::type_id::create("cfg");
            uvm_config_db#(svt_axi_system_configuration)::set(
                this, "axi_system_env", "cfg", cfg);
        end
        
        // 创建组件
        axi_system_env = svt_axi_system_env::type_id::create("axi_system_env", this);
        sequencer = axi_virtual_sequencer::type_id::create("sequencer", this);
    endfunction
endclass
```

#### 4.2.2 axi_virtual_sequencer.sv - 虚拟 Sequencer
**文件路径**: `env/axi_virtual_sequencer.sv`

**功能**:
- 管理 reset 接口
- 作为测试层序列的执行容器

```systemverilog
class axi_virtual_sequencer extends uvm_sequencer;
    typedef virtual axi_reset_if.axi_reset_modport AXI_RESET_MP;
    AXI_RESET_MP reset_mp;  // 复位接口访问句柄
    
    `uvm_component_utils(axi_virtual_sequencer)
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(AXI_RESET_MP)::get(this, "", "reset_mp", reset_mp))
            `uvm_fatal("build_phase", "An axi_reset_modport must be set");
    endfunction
endclass
```

#### 4.2.3 axi_base_test.sv - 基础测试类
**文件路径**: `env/axi_base_test.sv`

**功能**:
- 作为所有测试的基类
- 配置默认序列和工厂覆盖
- 管理测试通过/失败状态

**关键配置**:
```systemverilog
class axi_base_test extends uvm_test;
    `uvm_component_utils(axi_base_test)
    
    axi_basic_env env;
    bit load_through_config_creator = 0;
    string axi_cfg_file = "./env/axi_config.cfg";
    cust_svt_axi_system_configuration cfg;
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Factory 覆盖: 替换默认 master transaction
        set_type_override_by_type(
            svt_axi_master_transaction::get_type(),
            cust_svt_axi_master_transaction::get_type());
        
        // 创建配置
        if (load_through_config_creator) begin
            cc_cfg = cust_svt_axi_system_cc_configuration::type_id::create("cc_cfg");
            cc_cfg.create_sub_cfgs(1,1);
            cc_cfg.load_prop_vals(axi_cfg_file);
            uvm_config_db#(cust_svt_axi_system_cc_configuration)::set(
                this, "env", "cc_cfg", this.cc_cfg);
        end
        else begin
            cfg = cust_svt_axi_system_configuration::type_id::create("cfg");
            uvm_config_db#(cust_svt_axi_system_configuration)::set(
                this, "env", "cfg", this.cfg);
        end
        
        // 创建环境
        env = axi_basic_env::type_id::create("env", this);
        
        // 配置默认序列
        // 主虚拟序列
        uvm_config_db#(uvm_object_wrapper)::set(this,
            "env.axi_system_env.sequencer.main_phase", "default_sequence",
            axi_master_random_discrete_virtual_sequence::type_id::get());
        
        // 序列长度
        uvm_config_db#(int unsigned)::set(this,
            "env.axi_system_env.sequencer.axi_master_random_discrete_virtual_sequence",
            "sequence_length", 50);
        
        // Slave 响应序列
        uvm_config_db#(uvm_object_wrapper)::set(this,
            "env.axi_system_env.slave[0].sequencer.run_phase", "default_sequence",
            axi_slave_mem_response_sequence::type_id::get());
        
        // 复位序列
        uvm_config_db#(uvm_object_wrapper)::set(this,
            "env.sequencer.reset_phase", "default_sequence",
            axi_simple_reset_sequence::type_id::get());
    endfunction
    
    // 检查测试结果
    function void final_phase(uvm_phase phase);
        uvm_report_server svr = uvm_report_server::get_server();
        if (svr.get_severity_count(UVM_FATAL) + 
            svr.get_severity_count(UVM_ERROR) + 
            svr.get_severity_count(UVM_WARNING) > 0)
            `uvm_info("final_phase", "\nSvtTestEpilog: Failed\n", UVM_LOW)
        else
            `uvm_info("final_phase", "\nSvtTestEpilog: Passed\n", UVM_LOW)
    endfunction
endclass
```

---

## 5. 配置系统

### 5.1 cust_svt_axi_system_configuration.sv - 系统配置类
**文件路径**: `env/cust_svt_axi_system_configuration.sv`

**功能**: 定义 AXI 系统级配置参数

```systemverilog
class cust_svt_axi_system_configuration extends svt_axi_system_configuration;
    `uvm_object_utils(cust_svt_axi_system_configuration)
    
    function new(string name = "cust_svt_axi_system_configuration");
        super.new(name);
        
        // 配置 Master/Slave 数量
        this.num_masters = 1;
        this.num_slaves = 1;
        
        // 创建端口配置
        this.create_sub_cfgs(1, 1);
        
        // 配置 Master 接口类型为 AXI4-Stream
        this.master_cfg[0].axi_interface_type = svt_axi_port_configuration::AXI4_STREAM;
        
        // 配置 Slave 接口类型为 AXI4-Stream
        this.slave_cfg[0].axi_interface_type = svt_axi_port_configuration::AXI4_STREAM;
        
        // 配置数据宽度
        master_cfg[0].tdata_width = 48;  // 数据宽度 48-bit
        master_cfg[0].tdest_width = 3;   // 目标 ID 宽度 3-bit
        master_cfg[0].tuser_width = 8;   // 用户信号宽度 8-bit
        master_cfg[0].is_active = 1;     // Active 模式
        
        slave_cfg[0].is_active = 1;      // Active 模式
        slave_cfg[0].tdata_width = 48;
        slave_cfg[0].tdest_width = 3;
        slave_cfg[0].tuser_width = 8;
        
        // 默认 tready 随机值
        slave_cfg[0].default_tready = $urandom_range(1, 0);
    endfunction
endclass
```

### 5.2 配置参数说明

| 参数 | 默认值 | 说明 |
|------|--------|------|
| `num_masters` | 1 | Master Agent 数量 |
| `num_slaves` | 1 | Slave Agent 数量 |
| `axi_interface_type` | AXI4_STREAM | 协议类型 |
| `tdata_width` | 48 | 数据位宽 |
| `tdest_width` | 3 | 目标 ID 位宽 |
| `tuser_width` | 8 | 用户信号位宽 |
| `is_active` | 1 | Active 模式使能 |

### 5.3 cust_svt_axi_master_transaction.sv - 自定义事务类
**文件路径**: `env/cust_svt_axi_master_transaction.sv`

```systemverilog
class cust_svt_axi_master_transaction extends svt_axi_master_transaction;
    // 用户自定义约束
    constraint master_constraints {
        addr >= 0;
    }
    
    `uvm_object_utils(cust_svt_axi_master_transaction)
    
    function new(string name = "cust_svt_axi_master_transaction");
        super.new(name);
    endfunction
endclass
```

---

## 6. 序列库

### 6.1 Master 序列

#### 6.1.1 axi_master_random_sequence.sv - 随机序列
**文件路径**: `env/axi_master_random_sequence.sv`

**功能**: 生成随机 AXI4-Stream 数据事务

```systemverilog
class axi_master_random_sequence extends svt_axi_master_base_sequence;
    rand int unsigned sequence_length = 10;
    
    constraint reasonable_sequence_length {
        sequence_length <= 100;
    }
    
    `uvm_object_utils(axi_master_random_sequence)
    
    virtual task body();
        bit status;
        super.body();
        
        // 从 config_db 获取序列长度
        status = uvm_config_db#(int unsigned)::get(
            null, get_full_name(), "sequence_length", sequence_length);
        
        fork
            forever begin get_response(rsp); end
        join_none
        
        // 生成 DATA_STREAM 类型事务
        repeat (sequence_length) begin
            `uvm_do_with(req, { xact_type == svt_axi_transaction::DATA_STREAM; })
        end
    endtask
endclass
```

#### 6.1.2 axi_master_zero_delay_sequence.sv - 零延迟序列
**文件路径**: `env/axi_master_zero_delay_sequence.sv`

**功能**: 生成 tvalid 连续有效的 AXI4-Stream 事务

```systemverilog
class axi_master_zero_delay_sequence extends svt_axi_master_base_sequence;
    rand int unsigned sequence_length = 10;
    
    constraint reasonable_sequence_length { sequence_length <= 100; }
    
    `uvm_object_utils(axi_master_zero_delay_sequence)
    
    virtual task body();
        repeat (sequence_length) begin
            `uvm_do_with(req, {
                xact_type == svt_axi_transaction::DATA_STREAM;
                foreach (tvalid_delay[i]) tvalid_delay[i] == 0;
            })
        end
    endtask
endclass
```

#### 6.1.3 axi_master_random_discrete_sequence.sv - 离散随机序列
**文件路径**: `env/axi_master_random_discrete_sequence.sv`

**功能**: 生成离散的随机 Master 事务

```systemverilog
class axi_master_random_discrete_sequence extends svt_axi_master_base_sequence;
    rand int unsigned sequence_length = 10;
    
    constraint reasonable_sequence_length { sequence_length <= 100; }
    
    `uvm_object_utils(axi_master_random_discrete_sequence)
    
    virtual task body();
        for(int i = 0; i < sequence_length; i++) begin
            `uvm_do(req)
        end
    endtask
endclass
```

#### 6.1.4 axi_master_random_discrete_virtual_sequence.sv - 虚拟离散序列
**文件路径**: `env/axi_master_random_discrete_virtual_sequence.sv`

**功能**: 在所有 Master 上并行执行离散随机序列

```systemverilog
class axi_master_random_discrete_virtual_sequence extends svt_axi_system_base_sequence;
    rand int unsigned sequence_length;
    
    constraint reasonable_sequence_length { sequence_length <= 100; }
    
    `uvm_object_utils(axi_master_random_discrete_virtual_sequence)
    
    virtual task body();
        axi_master_random_discrete_sequence master_seq[];
        int counter = 0;
        int local_sequence_length = sequence_length;
        
        master_seq = new[p_sequencer.master_sequencer.size()];
        
        // 在每个 Master 上并行执行序列
        foreach(p_sequencer.master_sequencer[i]) begin
            fork
                automatic int j = i;
                begin
                    `uvm_do_on_with(master_seq[j], p_sequencer.master_sequencer[j],
                        {sequence_length == local_sequence_length;})
                    counter++;
                end
            join_none
        end
        
        // 等待所有序列完成
        while (counter != p_sequencer.master_sequencer.size()) begin
            wait(counter);
        end
    endtask
endclass
```

### 6.2 Slave 序列

#### 6.2.1 axi_slave_mem_response_sequence.sv - 内存响应序列
**文件路径**: `env/axi_slave_mem_response_sequence.sv`

**功能**: 
- 响应 Slave 请求
- 维护内置内存模型
- 随机化 tready 延迟

```systemverilog
class axi_slave_mem_response_sequence extends svt_axi_slave_base_sequence;
    svt_axi_slave_transaction req_resp;
    
    `uvm_object_utils(axi_slave_mem_response_sequence)
    
    virtual task body();
        // 消费 driver 发送的响应
        sink_responses();
        
        forever begin
            // 从 sequencer 获取响应请求
            p_sequencer.response_request_port.peek(req_resp);
            
            // 随机化响应
            status = req_resp.randomize with {
                bresp == svt_axi_slave_transaction::OKAY;
                foreach (rresp[index]) {
                    rresp[index] == svt_axi_slave_transaction::OKAY;
                }
                foreach (tready_delay[i]) tready_delay[i] inside {[1:10]};
            };
            
            // 内存操作
            if(req_resp.xact_type == svt_axi_slave_transaction::WRITE)
                put_write_transaction_data_to_mem(req_resp);
            else
                get_read_data_from_mem_to_transaction(req_resp);
            
            $cast(req, req_resp);
            `uvm_send(req)
        end
    endtask
endclass
```

#### 6.2.2 axi_slave_mem_zero_delay_sequence.sv - 零延迟响应序列
**文件路径**: `env/axi_slave_mem_zero_delay_sequence.sv`

**功能**: tready 立即响应的 Slave 序列

```systemverilog
class axi_slave_mem_zero_delay_sequence extends svt_axi_slave_base_sequence;
    `uvm_object_utils(axi_slave_mem_zero_delay_sequence)
    
    virtual task body();
        forever begin
            p_sequencer.response_request_port.peek(req_resp);
            
            status = req_resp.randomize with {
                bresp == svt_axi_slave_transaction::OKAY;
                foreach (rresp[index]) {
                    rresp[index] == svt_axi_slave_transaction::OKAY;
                }
                foreach (tready_delay[i]) tready_delay[i] == 0;  // 零延迟
            };
            
            // 内存操作...
            `uvm_send(req)
        end
    endtask
endclass
```

### 6.3 辅助序列

#### 6.3.1 axi_simple_reset_sequence.sv - 复位序列
**文件路径**: `env/axi_simple_reset_sequence.sv`

**功能**: 驱动复位信号的一个完整周期

```systemverilog
class axi_simple_reset_sequence extends uvm_sequence;
    `uvm_object_utils(axi_simple_reset_sequence)
    `uvm_declare_p_sequencer(axi_virtual_sequencer)
    
    virtual task body();
        // 激活复位
        p_sequencer.reset_mp.reset <= 1'b1;
        repeat(10) @(posedge p_sequencer.reset_mp.clk);
        #2;
        
        // 释放复位
        p_sequencer.reset_mp.reset <= 1'b0;
        repeat(10) @(posedge p_sequencer.reset_mp.clk);
        
        // 恢复复位（高电平有效）
        p_sequencer.reset_mp.reset <= 1'b1;
    endtask
endclass
```

#### 6.3.2 axi_null_virtual_sequence.sv - 空序列
**文件路径**: `env/axi_null_virtual_sequence.sv`

**功能**: 用于禁用默认序列的空序列

```systemverilog
class axi_null_virtual_sequence extends uvm_sequence;
    `uvm_object_utils(axi_null_virtual_sequence)
    
    virtual task body();
        // 空实现，用于覆盖默认序列
    endtask
endclass
```

---

## 7. 测试用例

### 7.1 ts.base_test.sv - 基础测试
**文件路径**: `tests/ts.base_test.sv`

```systemverilog
`include "axi_base_test.sv"

class base_test extends axi_base_test;
    `uvm_component_utils(base_test)
    
    function new(string name = "base_test", uvm_component parent=null);
        super.new(name, parent);
    endfunction
endclass
```

**运行命令**:
```bash
gmake USE_SIMULATOR=vcsvlog base_test WAVES=1
```

### 7.2 ts.random_test.sv - 随机测试
**文件路径**: `tests/ts.random_test.sv`

**功能**: 执行 50 个随机 AXI4-Stream 事务

```systemverilog
`include "axi_base_test.sv"
`include "axi_null_virtual_sequence.sv"
`include "axi_master_random_sequence.sv"

class random_test extends axi_base_test;
    `uvm_component_utils(random_test)
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // 禁用系统级虚拟序列
        uvm_config_db#(uvm_object_wrapper)::set(this,
            "env.axi_system_env.sequencer.main_phase", "default_sequence",
            axi_null_virtual_sequence::type_id::get());
        
        // 配置 Master 随机序列
        uvm_config_db#(uvm_object_wrapper)::set(this,
            "env.axi_system_env.master*.sequencer.main_phase", "default_sequence",
            axi_master_random_sequence::type_id::get());
        
        // 设置序列长度为 50
        uvm_config_db#(int unsigned)::set(this,
            "env.axi_system_env.master*.sequencer.axi_master_random_sequence",
            "sequence_length", 50);
        
        // 配置 Slave 响应序列
        uvm_config_db#(uvm_object_wrapper)::set(this,
            "env.axi_system_env.slave*.sequencer.run_phase", "default_sequence",
            axi_slave_mem_response_sequence::type_id::get());
    endfunction
endclass
```

**运行命令**:
```bash
gmake USE_SIMULATOR=vcsvlog random_test WAVES=1
```

### 7.3 ts.zero_delay_random_test.sv - 零延迟随机测试
**文件路径**: `tests/ts.zero_delay_random_test.sv`

**功能**: 执行 tvalid 连续有效的 AXI4-Stream 事务

```systemverilog
`include "axi_base_test.sv"
`include "axi_null_virtual_sequence.sv"
`include "axi_master_zero_delay_sequence.sv"
`include "axi_slave_mem_zero_delay_sequence.sv"

class zero_delay_random_test extends axi_base_test;
    `uvm_component_utils(zero_delay_random_test)
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // 禁用系统级虚拟序列
        uvm_config_db#(uvm_object_wrapper)::set(this,
            "env.axi_system_env.sequencer.main_phase", "default_sequence",
            axi_null_virtual_sequence::type_id::get());
        
        // 配置零延迟 Master 序列
        uvm_config_db#(uvm_object_wrapper)::set(this,
            "env.axi_system_env.master*.sequencer.main_phase", "default_sequence",
            axi_master_zero_delay_sequence::type_id::get());
        
        // 配置零延迟 Slave 序列
        uvm_config_db#(uvm_object_wrapper)::set(this,
            "env.axi_system_env.slave*.sequencer.run_phase", "default_sequence",
            axi_slave_mem_zero_delay_sequence::type_id::get());
    endfunction
endclass
```

**运行命令**:
```bash
gmake USE_SIMULATOR=vcsvlog zero_delay_random_test WAVES=1
```

### 7.4 ts.config_creator_test.sv - Config Creator 测试
**文件路径**: `tests/ts.config_creator_test.sv`

**功能**: 使用 Config Creator GUI 生成的配置文件运行测试

```systemverilog
`include "axi_base_test.sv"

class config_creator_test extends axi_base_test;
    `uvm_component_utils(config_creator_test)
    
    function new(string name = "config_creator_test", uvm_component parent=null);
        super.new(name, parent);
        load_through_config_creator = 1;  // 启用 Config Creator 配置
    endfunction
endclass
```

**运行命令**:
```bash
gmake USE_SIMULATOR=vcsvlog config_creator_test WAVES=1
```

---

## 8. 运行仿真

### 8.1 环境变量设置
```bash
# 设置 DesignWare VIP 路径
export DESIGNWARE_HOME=/path/to/designware
export VCS_HOME=/path/to/vcs
export UVM_HOME=/path/to/uvm
```

### 8.2 使用 Makefile 运行

#### 8.2.1 查看帮助
```bash
gmake help
```

#### 8.2.2 运行测试
```bash
# 运行 base_test
gmake USE_SIMULATOR=vcsvlog base_test

# 运行 random_test 并生成波形
gmake USE_SIMULATOR=vcsvlog random_test WAVES=1

# 运行 zero_delay_random_test
gmake USE_SIMULATOR=vcsvlog zero_delay_random_test WAVES=1

# 运行 config_creator_test
gmake USE_SIMULATOR=vcsvlog config_creator_test WAVES=1
```

#### 8.2.3 波形选项
```bash
# FSDB 波形 (需要 Verdi)
gmake USE_SIMULATOR=vcsvlog random_test WAVES_FSDB=1

# VCD 波形
gmake USE_SIMULATOR=vcsvlog random_test WAVES_VCD=1

# VPD 波形 (VCS 默认)
gmake USE_SIMULATOR=vcsvlog random_test WAVES=1
```

### 8.3 使用运行脚本
```bash
# 查看帮助
./run_axi_svt_uvm_axi4stream_sys -help

# 运行 random_test
./run_axi_svt_uvm_axi4stream_sys -w random_test vcsvlog

# 运行带波形
./run_axi_svt_uvm_axi4stream_sys -w random_test vcsvlog WAVES=1
```

### 8.4 编译选项
**文件**: `compile_opts`
```
+incdir+$CUR_PROJ_HOME
+incdir+$VIP_HOME/src/sverilog/vcs
+incdir+$VIP_HOME/include/sverilog
+incdir+$CUR_PROJ_HOME/src/sverilog/vcs
+incdir+$CUR_PROJ_HOME/hdl_interconnect/
+incdir+$CUR_PROJ_HOME/env/
+incdir+$CUR_PROJ_HOME/tests/
+define+SVT_AHB_MAX_DATA_WIDTH=32
+define+UVM_PACKER_MAX_BYTES=1500000
+define+UVM_DISABLE_AUTO_ITEM_RECORDING
+define+SVT_AHB_DISABLE_IMPLICIT_BUS_CONNECTION
-timescale=1ns/1ps
+define+WAVES_FSDB
```

### 8.5 运行选项
**文件**: `sim_run_options`
```
+UVM_TESTNAME=$scenario
+validation_cfg_filename=env/axi_config.cfg
```

---

## 9. 接口信号

### 9.1 AXI4-Stream 信号列表

| 信号名 | 方向 (Master) | 宽度 | 说明 |
|--------|--------------|------|------|
| `aclk` | 输入 | 1 | 时钟信号 |
| `aresetn` | 输入 | 1 | 复位信号 (低有效) |
| `tvalid` | 输出 | 1 | 数据有效指示 |
| `tready` | 输入 | 1 | 准备好接收 |
| `tdata` | 输出 | 48 | 数据总线 |
| `tstrb` | 输出 | - | 字节选通 |
| `tkeep` | 输出 | - | 数据保持指示 |
| `tlast` | 输出 | 1 | 最后一拍数据 |
| `tid` | 输出 | - | 数据流 ID |
| `tdest` | 输出 | 3 | 目标 ID |
| `tuser` | 输出 | 8 | 用户自定义信号 |

### 9.2 DUT 接口连接
```systemverilog
// Master 侧信号连接
.tvalid_m1(axi_if.master_if[0].tvalid),
.tdata_m1(axi_if.master_if[0].tdata),
.tready_m1(axi_if.master_if[0].tready),
// ... 其他信号

// Slave 侧信号连接
.tvalid_s1(axi_if.slave_if[0].tvalid),
.tdata_s1(axi_if.slave_if[0].tdata),
.tready_s1(axi_if.slave_if[0].tready),
// ... 其他信号
```

---

## 10. 最佳实践

### 10.1 添加新测试用例

1. **创建测试文件** `tests/ts.my_test.sv`:
```systemverilog
`include "axi_base_test.sv"

class my_test extends axi_base_test;
    `uvm_component_utils(my_test)
    
    function new(string name = "my_test", uvm_component parent=null);
        super.new(name, parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        // 添加自定义配置
    endfunction
endclass
```

2. **在 `top_test.sv` 中包含**:
```systemverilog
`include "ts.my_test.sv"
```

3. **添加到 Makefile 测试列表**:
```makefile
scenario_list = base_test random_test ... my_test
```

### 10.2 自定义配置

扩展 `cust_svt_axi_system_configuration`:
```systemverilog
class my_system_configuration extends cust_svt_axi_system_configuration;
    function new(string name = "my_system_configuration");
        super.new(name);
        // 自定义配置
        this.master_cfg[0].tdata_width = 64;  // 修改数据宽度
    endfunction
endclass
```

### 10.3 自定义序列

创建新的 Master 序列:
```systemverilog
class my_master_sequence extends svt_axi_master_base_sequence;
    rand int burst_length;
    
    constraint valid_burst { burst_length inside {[1:256]}; }
    
    virtual task body();
        repeat(burst_length) begin
            `uvm_do_with(req, {
                xact_type == svt_axi_transaction::DATA_STREAM;
                // 自定义约束
            })
        end
    endtask
endclass
```

### 10.4 调试技巧

1. **启用详细日志**:
```systemverilog
`uvm_info("DEBUG", "Message", UVM_HIGH)
```

2. **波形调试**:
```bash
# 使用 DVE 打开波形
dve -vpd vcdplus.vpd &
```

3. **使用 UVM 命令行选项**:
```bash
+UVM_VERBOSITY=UVM_HIGH
+UVM_TESTNAME=random_test
```

---

## 附录 A: VIP 接口文件路径

- **顶层接口**: `$DESIGNWARE_HOME/vip/svt/amba_svt/latest/sverilog/include/svt_axi_if.svi`
- **Master 接口**: `$DESIGNWARE_HOME/vip/svt/amba_svt/latest/sverilog/include/svt_axi_master_if.svi`
- **Slave 接口**: `$DESIGNWARE_HOME/vip/svt/amba_svt/latest/sverilog/include/svt_axi_slave_if.svi`
- **类参考文档**: `$DESIGNWARE_HOME/vip/svt/amba_svt/latest/doc/axi_svt_uvm_class_reference/html/index.html`

## 附录 B: 参考文档

- Synopsys AXI VIP User Guide
- UVM Class Reference Manual
- AXI4-Stream Protocol Specification

---

**文档版本**: 1.0  
**最后更新**: 2026-03-26  
**作者**: Auto-generated from source code analysis
