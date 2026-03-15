# ONDEC2NSU Checker 开发记录

## 项目概述

ONDEC2NSU Checker 是一个基于 UVM 的验证组件，用于检查 ONDEC2NSU 模块的功能正确性。该组件采用分组独立处理架构，支持 8 个 plane\_pair 的并行处理，能够自动检测和验证 deep read response 和 offwbf 命令。

## 代码架构

### 核心组件

1. **ondec2nsu\_checker** - 主检查器类
   - 8 个输入 FIFO 队列（对应 8 个 plane\_pair）
   - 1 个输出 FIFO 队列（打包后的 group transaction）
   - 2 个响应 FIFO 队列（deep read response 和 offwbf command）
2. **事务类型  aaa**
   - `ondec2nsu_transaction` - 单个 plane\_pair 的命令事务
   - `ondec2nsu_group_transaction` - 8 个 plane\_pair 打包后的组事务
   - `nsu2cpu_deep_resp_transaction` - deep read 响应事务
   - `offdec2nsu_transaction` - offwbf 命令事务

### 处理流程

1. **打包阶段** - `pack_ondec_transactions()`
   - 从 8 个输入 FIFO 中获取 transaction
   - 检查 instruction\_index 一致性
   - 打包成 group transaction 并发送到输出 FIFO
2. **命令检查阶段** - `check_ondec_cmd()`
   - 按组处理（Group 0: PP\[0:3], Group 1: PP\[4:7]）
   - 判断每个组是否需要 deep read response 或 offwbf 命令
   - 记录预期响应
3. **响应检查阶段**
   - `check_deep_read_resp()` - 检查 deep read 响应
   - `check_offwbf_cmd()` - 检查 offwbf 命令

## 核心功能

### 1. 分组独立处理

- **分组策略**：8 个 plane\_pair 分为 2 组（每组 4 个）
  - Group 0: plane\_pair\[0:3]
  - Group 1: plane\_pair\[4:7]
- **独立判断**：每组独立判断是否需要 deep read response 或 offwbf 命令
- **并行处理**：4 个核心任务并行执行

### 2. 智能匹配机制

- **Deep Read Response 匹配**：通过 instruction\_index 和 ost\_id 匹配
- **Offwbf Command 匹配**：通过 descramble\_seed 精确匹配
- **多匹配处理**：支持多个 offwbf 命令的情况，按优先级处理

### 3. OFFWBF 地址管理

- **地址分配**：模拟 DUT 的优先级编码器行为
- **地址释放**：处理完 offwbf 命令后自动释放地址
- **地址冲突检测**：避免地址重复分配

### 4. 完整的状态检查

- **Decode 状态检查**：验证 decode 成功/失败状态
- **CRC 状态检查**：验证 CRC 校验结果
- **LBA 比较检查**：验证 LBA 比较结果
- **ECC 结果检查**：验证 ECC 校正结果
- **地址检查**：验证内存地址和 IO 地址

### 5. 详细的统计信息

- **命令统计**：总命令数、响应数、offwbf 命令数
- **分组统计**：每组的 decode 成功/失败、CRC 错误、LBA 不匹配
- **通过率统计**：总通过数、失败数

## 测试情况

### 测试场景

1. **多 plane offwbf 测试**
   - 模拟 8 个 plane\_pair 的 transaction
   - Group 0 的 plane 0 和 plane 1 需要 offwbf
   - 发送 2 个 offwbf 命令，验证 checker 能正确处理

### 测试结果

- **功能验证**：能够正确识别需要 offwbf 的 plane\_pair
- **匹配验证**：能够通过 descramble\_seed 正确匹配 offwbf 命令
- **状态验证**：能够验证 offwbf 命令的各个字段
- **统计验证**：能够正确统计 offwbf 成功/失败次数

## 更新历史

### 2026-03-07 更新

1. **新增 8 个 ondec2nsu\_transaction 输入队列**
   - 每个 plane\_pair 对应一个独立的 FIFO 队列
   - 支持并行接收来自不同 plane\_pair 的 transaction
2. **新增 pack\_ondec\_transactions 任务**
   - 自动打包 8 个 plane\_pair 的 transaction
   - 检查 instruction\_index 一致性
   - 提高处理效率和准确性
3. **更新 build\_phase**
   - 初始化 8 个输入 FIFO 队列
   - 保持输出和响应 FIFO 队列
4. **更新 run\_phase**
   - 并行执行 4 个核心任务
   - 优化处理流程

## 使用说明

### 在测试平台中使用

```systemverilog
class my_test extends uvm_test;
    ondec2nsu_checker checker;
    ondec2nsu_transaction ondec_tr;
    
    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        
        // 向 8 个 FIFO 写入 transaction
        for (int i = 0; i < 8; i++) {
            ondec_tr = ondec2nsu_transaction::type_id::create($sformatf("tr_%0d", i));
            ondec_tr.instruction_index = 16'h0001;
            ondec_tr.plane_sel = 1'b1;
            ondec_tr.nsu_ost_id = 5'h01;
            // ... 设置其他字段
            
            checker.ondec_fifo[i].write(ondec_tr);
        }
        
        // pack_ondec_transactions 会自动打包并送入 ondec_cmd_fifo
        // check_ondec_cmd 会自动从 ondec_cmd_fifo 取出并处理
        
        #100ns;
        phase.drop_objection(this);
    endtask
endclass
```

### 注意事项

1. **instruction\_index 一致性**：8 个 plane\_pair 的 transaction 必须具有相同的 instruction\_index，否则会被丢弃并报错
2. **阻塞行为**：pack\_ondec\_transactions 任务会阻塞直到 8 个队列都有 transaction
3. **并行处理**：使用 fork-join 结构并行从 8 个队列获取 transaction，确保同时到达
4. **错误处理**：如果检测到 instruction\_index 不匹配，会：
   - 打印错误信息
   - 丢弃当前 8 个 transaction
   - 继续等待下一批 transaction

## 架构优势

1. **模块化**：8 个独立的输入队列，便于扩展和维护
2. **自动化**：自动打包，无需手动管理 group transaction
3. **错误检测**：自动检测 instruction\_index 不匹配的情况
4. **清晰的检查流程**：
   - 第一步：打包 8 个 plane\_pair transaction
   - 第二步：按 group 判断（Group 0: PP\[0:3], Group 1: PP\[4:7]）
   - 第三步：检查 deep read resp 和 offwbf cmd
5. **分组独立**：每组独立处理，提高并行度和准确性
6. **智能匹配**：通过多种方式精确匹配响应和命令
7. **详细统计**：提供全面的统计信息，便于分析验证结果

## 相关文件

- `/mnt/disk_0/IC/nsu/uvc/mychecker/mychecker.sv` - 主 checker 文件
- `/mnt/disk_0/IC/nsu/uvc/mychecker/mychecker_test.sv` - 测试文件
- `/mnt/disk_0/IC/nsu/uvc/mychecker/doc/mychecker_update_notes.md` - 更新说明
- `/mnt/disk_0/IC/nsu/uvc/mychecker/ondec2nsu_transaction.sv` - Transaction 定义
- `/mnt/disk_0/IC/nsu/uvc/mychecker/normal_resp_checker.sv` - Normal response checker

