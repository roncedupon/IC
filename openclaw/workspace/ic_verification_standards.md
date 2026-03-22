# IC 验证编码规范

## 1. 概述

本规范定义了 IC 验证环境开发中的编码标准和最佳实践，旨在提高代码质量、可维护性和团队协作效率。

## 2. SystemVerilog 编码规范

### 2.1 文件组织

#### 文件命名
- **包文件**: `*_pkg.sv` (e.g., `my_checker_pkg.sv`)
- **接口文件**: `*_if.sv` (e.g., `axi_interface_if.sv`)
- **测试文件**: `*_test.sv` (e.g., `my_test_test.sv`)
- **序列文件**: `*_sequence.sv` (e.g., `read_sequence.sv`)
- **事务文件**: `*_transaction.sv` (e.g., `axi_transaction.sv`)
- **Checker 文件**: `*_checker.sv` (e.g., `my_checker.sv`)
- **监视器文件**: `*_monitor.sv` (e.g., `axi_monitor.sv`)
- **驱动器文件**: `*_driver.sv` (e.g., `axi_driver.sv`)

#### 文件结构
```systemverilog
// 1. 版权声明 (如有)
// 2. 文件头注释
`ifndef FILENAME_SV
`define FILENAME_SV

// 3. import 语句
import uvm_pkg::*;
`include "uvm_macros.svh"
import package_name_pkg::*;

// 4. 类定义
class my_class extends uvm_component;
  // 类内容
endclass

// 5. 函数/任务定义
function void my_function();
  // 函数内容
endfunction

`endif // FILENAME_SV
```

### 2.2 命名规范

#### 类命名
- **首字母大写**，驼峰命名法
- **避免缩写**，除非是通用缩写
```systemverilog
// ✅ 推荐
class AxiTransaction;
class MyChecker;
class UvmBaseSequence;

// ❌ 不推荐
class axi_trans;
class my_chkr;
class UVMBaseSeq;
```

#### 变量命名
- **小写字母开头**，驼峰命名法
- **布尔变量** 以 `is_`, `has_`, `need_` 开头
- **数组变量** 使用复数形式
```systemverilog
// ✅ 推荐
bit is_valid;
bit has_error;
bit need_response;
axi_transaction tr_array[$];

// ❌ 不推荐
bit valid_flag;
bit error;
bit response_flag;
axi_transaction tr_arr[$];
```

#### 参数命名
- **全大写**，下划线分隔
```systemverilog
// ✅ 推荐
parameter int MAX_TRANS = 100;
parameter int ADDR_WIDTH = 32;

// ❌ 不推荐
parameter int maxTrans = 100;
parameter int addrWidth = 32;
```

#### 信号命名
- **小写下划线**，描述性名称
```systemverilog
// ✅ 推荐
logic [31:0] instruction_index;
logic [4:0] nsu_ost_id;
logic [7:0] plane_pair_sel;

// ❌ 不推荐
logic [31:0] idx;
logic [4:0] id;
logic [7:0] sel;
```

### 2.3 代码风格

#### 缩进和对齐
- **使用空格**，不要使用 Tab
- **缩进 2 个空格**
- **对齐相关代码**
```systemverilog
class my_checker extends uvm_component;
  // 成员变量
  uvm_tlm_analysis_fifo #(req_t)  req_fifo;
  uvm_tlm_analysis_fifo #(resp_t) resp_fifo;
  
  // 统计计数器
  int unsigned total_count = 0;
  int unsigned pass_count  = 0;
  int unsigned fail_count  = 0;
endclass
```

#### 括号和大括号
- **大括号独占一行**
- **括号内适当空格**
```systemverilog
// ✅ 推荐
if (condition) begin
  // code
end
else if (other_condition) begin
  // code
end
else begin
  // code
end

// ❌ 不推荐
if(condition){
  // code
}else if(other_condition){
  // code
}else{
  // code
}
```

#### 注释规范
- **文件头注释** 包含作者、日期、功能描述
- **类注释** 描述类功能和用法
- **方法注释** 描述参数和返回值
- **复杂逻辑注释** 解释算法思路
```systemverilog
//-----------------------------------------------------------------------------
// my_checker.sv - 我的检查器实现
//
// 功能: 验证 AXI 协议的正确性
// 作者: [你的名字]
// 日期: 2026-03-22
// 版本: 1.0
//
// 使用说明:
//   1. 实例化 checker
//   2. 连接 FIFO
//   3. 启动 run_phase
//-----------------------------------------------------------------------------

class my_checker extends uvm_component;
  //---------------------------------------------------------------------------
  // 功能: 检查 AXI 响应
  // 参数: resp - 待检查的响应事务
  // 返回: 1=通过, 0=失败
  //---------------------------------------------------------------------------
  function bit check_response(axi_resp_t resp);
    // 复杂算法的注释
    // 步骤 1: 验证地址对齐
    if (!is_aligned(resp.addr)) begin
      `uvm_error("ADDR_ALIGN", $sformatf("地址未对齐: 0x%0h", resp.addr))
      return 0;
    end
    
    // 步骤 2: 验证数据一致性
    return check_data_consistency(resp);
  endfunction
endclass
```

### 2.4 UVM 规范

#### 工厂注册
- **所有可创建类** 必须注册到 UVM 工厂
- **使用宏** 简化注册
```systemverilog
// 类注册
`uvm_component_utils_begin(my_checker)
  `uvm_field_int(my_var, UVM_ALL_ON)
`uvm_component_utils_end

// 事务注册
`uvm_object_utils_begin(axi_transaction)
  `uvm_field_int(addr, UVM_ALL_ON)
  `uvm_field_int(data, UVM_ALL_ON)
`uvm_object_utils_end
```

#### 相位方法
- **实现必要的 UVM 相位**
- **调用父类方法**
```systemverilog
function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  // 自定义 build 逻辑
  req_fifo = new("req_fifo", this);
endfunction

task run_phase(uvm_phase phase);
  super.run_phase(phase);
  // 自定义 run 逻辑
  fork
    check_requests();
    check_responses();
  join
endtask
```

#### 消息报告
- **使用 UVM 消息宏**
- **选择合适的严重级别**
```systemverilog
// 调试信息
`uvm_info(get_type_name(), $sformatf("收到事务: %s", tr.convert2string()), UVM_HIGH)

// 警告
`uvm_warning(get_type_name(), $sformatf("检测到异常: %s", error_msg))

// 错误
`uvm_error(get_type_name(), $sformatf("检查失败: %s", fail_reason))

// 致命错误
`uvm_fatal(get_type_name(), $sformatf("系统错误: %s", fatal_error))
```

### 2.5 事务类规范

#### 字段定义
- **明确位宽**
- **添加注释说明**
- **使用 rand 修饰随机字段**
```systemverilog
class axi_transaction extends uvm_sequence_item;
  // 地址字段
  rand bit [31:0] addr;        // 传输地址
  rand bit [2:0]  burst_size;  // 突发大小
  rand bit [7:0]  burst_len;   // 突发长度
  
  // 数据字段
  rand bit [31:0] data[];      // 传输数据
  rand bit [3:0]  strb;        // 字节选通
  
  // 响应字段
  bit [1:0] resp;              // 响应状态
  bit       last;              // 最后传输标志
endclass
```

#### 约束定义
- **分组约束**
- **添加注释**
- **使用软约束** 提高灵活性
```systemverilog
constraint c_addr_alignment {
  // 地址必须 4 字节对齐
  addr[1:0] == 2'b00;
}

constraint c_burst_size {
  // 突发大小限制
  burst_size inside {1, 2, 4, 8};
}

constraint c_data_size {
  // 数据数组大小
  data.size() == burst_len + 1;
  soft data.size() == 1;  // 软约束，可被覆盖
}
```

### 2.6 Checker 规范

#### 架构设计
- **FIFO 队列管理**
- **Pending 状态跟踪**
- **统计计数器**
- **最终检查机制**
```systemverilog
class protocol_checker extends uvm_component;
  // FIFO 队列
  uvm_tlm_analysis_fifo #(req_t)  req_fifo;
  uvm_tlm_analysis_fifo #(resp_t) resp_fifo;
  
  // Pending 状态
  bit [63:0] pending_req;
  req_t      pending_config [bit [63:0]];
  
  // 统计计数器
  int unsigned total_count = 0;
  int unsigned pass_count  = 0;
  int unsigned fail_count  = 0;
  
  // 最终检查
  function void final_phase(uvm_phase phase);
    super.final_phase(phase);
    if (pending_req != 0) begin
      `uvm_error("PENDING", $sformatf("仍有 %0d 个未完成请求", $countones(pending_req)))
    end
  endfunction
endclass
```

#### 检查逻辑
- **清晰的检查步骤**
- **详细的错误信息**
- **可配置的检查级别**
```systemverilog
function void check_response(resp_t resp, req_t cfg);
  // 步骤 1: 基本字段检查
  if (!check_basic_fields(resp, cfg)) return;
  
  // 步骤 2: 协议规范检查
  if (!check_protocol_rules(resp, cfg)) return;
  
  // 步骤 3: 时序检查
  if (!check_timing(resp, cfg)) return;
  
  // 所有检查通过
  pass_count++;
  `uvm_info("CHECK_PASS", $sformatf("响应检查通过: %s", resp.convert2string()), UVM_HIGH)
endfunction
```

### 2.7 测试平台规范

#### 测试类结构
- **继承自 uvm_test**
- **创建环境实例**
- **配置测试参数**
```systemverilog
class my_test extends uvm_test;
  my_env env;
  
  `uvm_component_utils(my_test)
  
  function new(string name = "my_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = my_env::type_id::create("env", this);
    
    // 配置测试参数
    uvm_config_db#(int)::set(this, "env", "test_mode", 1);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    // 测试逻辑
    run_test_cases();
    phase.drop_objection(this);
  endtask
endclass
```

#### 测试用例
- **独立的测试场景**
- **清晰的测试目标**
- **完整的测试覆盖**
```systemverilog
task run_test_cases();
  // 测试 1: 正常传输
  `uvm_info("TEST", "开始测试: 正常传输", UVM_LOW)
  run_normal_transfer_test();
  
  // 测试 2: 错误场景
  `uvm_info("TEST", "开始测试: 错误场景", UVM_LOW)
  run_error_scenarios_test();
  
  // 测试 3: 边界条件
  `uvm_info("TEST", "开始测试: 边界条件", UVM_LOW)
  run_boundary_conditions_test();
  
  // 测试 4: 压力测试
  `uvm_info("TEST", "开始测试: 压力测试", UVM_LOW)
  run_stress_test();
endtask
```

## 3. Python 工具规范

### 3.1 文件结构

#### 模块组织
```python
# log_extractor.py
"""
日志提取工具 - 自动化日志分析和数据提取
"""

import re
import sys
from pathlib import Path
from typing import Optional, List, Dict, Tuple

class LogRangeExtractor:
    """通用日志范围提取器"""
    
    def __init__(self, log_file_path: str):
        self.log_file_path = Path(log_file_path)
    
    def extract_range(self, start_pattern: str, end_pattern: str) -> List[str]:
        """提取指定范围的日志"""
        pass

# 工具函数
def extract_to_csv(log_file_path: str, csv_file: str) -> None:
    """提取结构化数据到 CSV"""
    pass

if __name__ == "__main__":
    # 示例用法
    pass
```

### 3.2 代码风格

#### 命名规范
- **类名**: 驼峰命名法 (CamelCase)
- **函数名**: 小写下划线 (snake_case)
- **变量名**: 小写下划线 (snake_case)
- **常量**: 全大写 (UPPER_CASE)

```python
# ✅ 推荐
class LogRangeExtractor:
    DEFAULT_TIMEOUT = 30
    
    def extract_log_range(self, start_pattern: str) -> List[str]:
        log_lines = []
        return log_lines

# ❌ 不推荐
class logExtractor:
    defaultTimeout = 30
    
    def extractLogRange(self, startPattern: str) -> list:
        LogLines = []
        return LogLines
```

#### 文档字符串
- **模块文档**: 描述模块功能
- **类文档**: 描述类用途
- **函数文档**: 描述参数和返回值

```python
def extract_to_csv(
    log_file_path: str,
    csv_file: str,
    data_pattern: str = r"\[([^\]]+)\]\s*=\s*([0-9]+)"
) -> None:
    """
    提取结构化数据到 CSV 文件
    
    Args:
        log_file_path: 日志文件路径
        csv_file: 输出 CSV 文件路径
        data_pattern: 数据提取正则表达式
        
    Returns:
        None
        
    Raises:
        FileNotFoundError: 日志文件不存在
        ValueError: 正则表达式无效
    """
    pass
```

### 3.3 错误处理

#### 异常处理
- **具体的异常类型**
- **清晰的错误信息**
- **适当的日志记录**

```python
try:
    with open(log_file_path, 'r', encoding='utf-8') as f:
        content = f.read()
except FileNotFoundError:
    raise FileNotFoundError(f"日志文件未找到: {log_file_path}")
except UnicodeDecodeError:
    raise ValueError(f"文件编码错误: {log_file_path}")
```

## 4. Makefile 规范

### 4.1 文件结构
```makefile
# Makefile for IC Verification

# 工具定义
VCS     = vcs
SIMV    = simv
UVM_HOME = $(shell echo $$UVM_HOME)

# 文件列表
SV_FILES = \
  axi_transaction.sv \
  axi_driver.sv \
  axi_monitor.sv \
  axi_checker.sv \
  axi_env.sv \
  axi_test.sv

# 编译目标
all: compile run

compile:
	$(VCS) -sverilog -ntb_opts uvm-1.2 \
    -timescale=1ns/1ps \
    -debug_access+all \
    +incdir+$(UVM_HOME)/src \
    $(SV_FILES) \
    -o $(SIMV)

run:
	./$(SIMV) +UVM_TESTNAME=axi_test

clean:
	rm -rf csrc *.log *.key *.vdb $(SIMV) simv.daidir

.PHONY: all compile run clean
```

### 4.2 变量使用
- **大写变量名**
- **清晰的变量含义**
- **注释说明**

```makefile
# 仿真时间精度
TIMESCALE = 1ns/1ps

# 调试选项
DEBUG_FLAGS = -debug_access+all

# UVM 版本
UVM_VERSION = uvm-1.2
```

## 5. Git 规范

### 5.1 提交信息格式
```
<type>: <subject>

<body>

<footer>
```

#### Type 类型
- **feat**: 新功能
- **fix**: 修复 bug
- **docs**: 文档更新
- **style**: 代码格式调整
- **refactor**: 代码重构
- **test**: 测试相关
- **chore**: 构建过程或辅助工具的变动

#### 示例
```
feat: 添加 AXI 协议检查器

- 实现 AXI 读写事务检查
- 添加地址对齐验证
- 添加数据一致性检查
- 添加统计计数器

Closes: #123
```

### 5.2 分支管理
- **main**: 主分支，稳定版本
- **develop**: 开发分支
- **feature/***: 功能分支
- **hotfix/***: 紧急修复分支

## 6. 文档规范

### 6.1 Markdown 格式

#### 标题层级
```markdown
# 一级标题
## 二级标题
### 三级标题
#### 四级标题
```

#### 代码块
````markdown
```systemverilog
class my_checker;
  // code
endclass
```

```python
def my_function():
    # code
    pass
```
````

#### 表格
```markdown
| 字段 | 类型 | 说明 |
|------|------|------|
| addr | [31:0] | 地址 |
| data | [31:0] | 数据 |
```

### 6.2 文档内容
- **清晰的标题结构**
- **详细的说明**
- **完整的示例**
- **版本历史**

## 7. 质量保障

### 7.1 代码审查
- **同行评审**
- **代码质量检查**
- **测试覆盖验证**

### 7.2 测试要求
- **功能覆盖率**: ≥95%
- **代码覆盖率**: ≥90%
- **断言覆盖率**: ≥85%

### 7.3 性能要求
- **编译时间**: ≤10 分钟
- **仿真速度**: ≥1000 事务/秒
- **内存使用**: ≤4GB

---

**版本**: 1.0  
**最后更新**: 2026-03-22  
**适用范围**: IC 验证团队  
**维护者**: [你的名字]