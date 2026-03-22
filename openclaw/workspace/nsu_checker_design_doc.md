# ONDEC2NSU Checker 设计文档

## 1. 项目概述

### 1.1 系统背景
**ONDEC2NSU Checker** 是一个基于 UVM 的验证环境组件，用于验证 NSU (NAND Storage Unit) 与 ONDEC (ONFI Decoder) 之间的交互协议。该 Checker 实现了完整的 3 步检查流程，支持 8 个 plane_pair 的并行处理和 2 个独立组的分组判断。

### 1.2 核心功能
- **分组处理机制**：将 8 个 plane_pair 分为 2 组（Group 0: PP[0:3], Group 1: PP[4:7]），每组独立处理
- **3 步检查流程**：
  1. 接收 `ondec2nsu_group_transaction` 并判断每组需要何种响应
  2. 检查 `nsu2cpu_deep_resp_transaction`（深度读响应）
  3. 检查 `offdec2nsu_transaction`（OFFWBF 命令）
- **智能匹配机制**：基于 token hash 匹配请求与响应
- **OFFWBF 地址管理**：模拟 DUT 的优先级编码器行为，管理 16 个地址空间

### 1.3 设计亮点
- ✅ **Group 独立处理**：每组通过 `nsu_ost_id` 独立判断，互不干扰
- ✅ **双响应支持**：同一 token 可同时期望 `deep_resp` 和 `offwbf`
- ✅ **地址复用管理**：动态分配和释放 OFFWBF 地址，模拟真实硬件行为
- ✅ **完整统计**：按组统计 decode success/fail、CRC 错误等指标
- ✅ **最终检查**：`final_phase` 确保所有 FIFO 清空且无未处理事务

---

## 2. 架构设计

### 2.1 模块结构
```
ondec2nsu_checker
├── FIFO 队列
│   ├── ondec_fifo[8]          # 8 个 plane_pair 输入队列
│   ├── ondec_group_cmd_fifo   # 打包后的 group 命令队列
│   ├── deep_read_resp_fifo    # 深度读响应队列
│   └── offwbf_cmd_fifo        # OFFWBF 命令队列
├── 查找表
│   ├── pending_deep_resp      # 期望 deep_resp 的 token 标记
│   ├── pending_offwbf         # 期望 offwbf 的 token 标记
│   └── pending_config         # 待处理的 group 配置
├── 统计计数器
│   ├── 全局统计 (total/pass/fail)
│   └── 分组统计 (group0/group1)
└── OFFWBF 地址管理器
    ├── offwbf_addr_status     # 16 位地址占用状态
    └── offwbf_ost_id_to_addr  # OST ID 到地址的映射
```

### 2.2 数据流
```
[8× ondec2nsu_transaction] 
        ↓
  pack_ondec_transactions()
        ↓
[ondec2nsu_group_transaction] 
        ↓
  check_ondec_cmd()
        ↓
  ┌─────────────────────┬─────────────────────┐
  │  Group 0 (PP[0:3])  │  Group 1 (PP[4:7])  │
  │  独立判断需求       │  独立判断需求       │
  └─────────────────────┴─────────────────────┘
        ↓                         ↓
  期望 deep_resp?          期望 deep_resp?
  期望 offwbf?             期望 offwbf?
        ↓                         ↓
  注册 pending_config  ←──────────┘
        ↓
  ┌──────────────────────────────────────────┐
  │  check_deep_read_resp()  |  check_offwbf_cmd()  │
  │  匹配并验证 deep_resp    │  匹配并验证 offwbf    │
  └──────────────────────────────────────────┘
        ↓                         ↓
  清除 deep_resp 标记      清除 offwbf 标记
        ↓                         ↓
  所有标记清除？→ 删除 config
```

---

## 3. 核心算法

### 3.1 Group 分组判断逻辑
```systemverilog
for (int gid = 0; gid < 2; gid++) begin
  pp_base = gid * 4;  // Group 0: 0, Group 1: 4
  
  for (int pp = 0; pp < 4; pp++) begin
    if (!dec_suc && crc_pass) begin
      if (!data_out_en) 
        group_need_deep_resp = 1;  // 地址不足，需上报 deep_resp
      else 
        group_need_offwbf = 1;     // 地址足够，需调用 offwbf
    end
    if (!crc_pass) 
      group_need_deep_resp = 1;    // CRC 失败，需上报 deep_resp
    if (deep_read_sel) 
      group_need_deep_resp = 1;    // 选择深度读，需上报 deep_resp
  end
end
```

### 3.2 OFFWBF 地址管理算法
```systemverilog
// 分配地址（模拟优先级编码器）
function bit [3:0] allocate_offwbf_addr(bit [4:0] ost_id);
  if (已分配) return 已有地址;
  
  for (addr = 0; addr < 16; addr++) begin
    if (!is_occupied(addr)) begin
      标记占用;
      记录 ost_id → addr 映射;
      return addr;
    end
  end
  return 4'hF;  // 无可用地址
endfunction

// 释放地址
function void free_offwbf_addr(bit [4:0] ost_id);
  if (存在映射) begin
    获取 addr;
    标记空闲;
    删除映射;
  end
endfunction
```

### 3.3 Token Hash 匹配机制
```systemverilog
typedef bit [96:0] token_hash_t;

function token_hash_t hash();
  // 组合关键字段生成唯一 hash
  hash_val = {
    instruction_index,  // 16bit
    group0_ost_id,      // 5bit
    group1_ost_id,      // 5bit
    group0_lba,         // 23bit
    group1_lba          // 23bit
  };
  return hash_val;
endfunction
```

---

## 4. 事务类型

### 4.1 ondec2nsu_transaction
**用途**：单个 plane_pair 的 ONDEC 命令
**关键字段**：
- `instruction_index` (16bit): 指令索引
- `nsu_ost_id` (5bit): OST ID
- `plane_sel` (1bit): 平面选择
- `dec_suc` (1bit): 译码成功标志
- `crc_pass` (1bit): CRC 通过标志
- `data_out_en` (1bit): 数据输出使能
- `deep_read_sel` (1bit): 深度读选择
- `offline_wbf_work_en` (1bit): OFFWBF 工作使能
- `descramble_seed` (16bit): 解扰种子
- `dest_memory_addr` (32bit): 目标内存地址

### 4.2 ondec2nsu_group_transaction
**用途**：8 个 plane_pair 打包的组命令
**结构**：
```systemverilog
class ondec2nsu_group_transaction;
  ondec2nsu_transaction tr[8];  // 8 个 plane_pair 事务
endclass
```

### 4.3 nsu2cpu_deep_resp_transaction
**用途**：NSU 到 CPU 的深度读响应
**关键字段**：
- `instruction_index` (16bit)
- `group0_ost_id`, `group1_ost_id` (5bit each)
- `group0_meta_index_LBA`, `group1_meta_index_LBA` (23bit each)
- `plane_pair_dec_result` (8bit): 译码结果
- `plane_pair_crc_result` (8bit): CRC 结果
- `plane_pair_lba_comp` (8bit): LBA 比较结果
- `plane_pair_ecc_result` (8bit): ECC 结果
- `deep_read_sel`, `safe_fast_read` (1bit each)

### 4.4 offdec2nsu_transaction
**用途**：NSU 到 OFFWBF 的命令
**关键字段**：
- `plane_num` (3bit): 平面编号
- `ost_id_nsu2offline` (5bit): OST ID
- `descramble_seed` (16bit): 解扰种子（匹配关键）
- `dest_sel` (1bit): 目标选择
- `flip_threshold_sel` (1bit): 翻转阈值选择
- `over_threshold` (1bit): 超过阈值
- `descramble_en` (1bit): 解扰使能
- `src_mem_addr`, `dest_mem_addr` (32bit each)

---

## 5. 检查项详解

### 5.1 Deep Read Response 检查
| 检查项 | 说明 | 匹配条件 |
|--------|------|----------|
| instruction_index | 指令索引匹配 | resp.instruction_index == cfg.instruction_index |
| group_ost_id | 组 OST ID 匹配 | resp.group0/group1_ost_id == cfg.tr[pp_base].nsu_ost_id |
| dec_result | 译码结果 | cfg.dec_suc == !resp.plane_pair_ecc_result[pp] |
| crc_result | CRC 结果 | cfg.crc_pass == !resp.plane_pair_crc_result[pp] |
| lba_comp | LBA 比较 | cfg.error_flag == resp.plane_pair_lba_comp[pp] |
| deep_read_sel | 深度读选择 | cfg.deep_read_sel == resp.deep_read_sel |
| read_mode | 读模式 | cfg.read_mode == resp.safe_fast_read |
| block_addr | 块地址 | cfg.plane_group_block_addr[7:0] == resp.group0/1_block_addr |
| page_addr | 页地址 | cfg.page_addr_plane_group == resp.group0/1_page_addr |
| meta_index_LBA | 元数据索引 LBA | cfg.lba[22:0] == resp.group0/1_meta_index_LBA |

### 5.2 OFFWBF Command 检查
| 检查项 | 说明 | 匹配条件 |
|--------|------|----------|
| descramble_seed | 解扰种子（主匹配条件） | offwbf.seed == cfg.descramble_seed |
| plane_num | 平面编号 | offwbf.plane_num == global_pp |
| dest_sel | 目标选择 | offwbf.dest_sel == cfg.write_pos_jdg |
| flip_threshold_sel | 翻转阈值 | offwbf.flip_threshold_sel == cfg.flip_threshold_sel |
| over_threshold | 超过阈值 | offwbf.over_threshold == cfg.syn_weight_over_threshold |
| descramble_en | 解扰使能 | offwbf.descramble_en == cfg.descramble_en |
| src_mem_addr | 源地址 | offwbf.src_addr == cfg.dec_fail_dest_addr |
| dest_mem_addr | 目标地址 | 根据 write_pos_jdg 判断（background/IO） |
| offline_wbf_out_flag | 输出标志 | offwbf.offline_wbf_out_flag == 1 |
| read_mode | 读模式 | cfg.read_mode == 0 (safe read) |

---

## 6. 可复用模块提炼

### 6.1 通用 Checker 基类模板
**适用场景**：任何需要请求 - 响应匹配验证的场景
**核心特性**：
- FIFO 队列管理
- Pending 状态跟踪（基于 hash）
- 分组独立处理
- 统计计数器
- 最终检查机制

**复用建议**：
```systemverilog
// 模板参数化
class generic_checker #(
  type REQUEST_T = uvm_sequence_item,
  type RESPONSE_T = uvm_sequence_item,
  type CONFIG_T = uvm_sequence_item
) extends uvm_component;
  // 通用实现
endclass
```

### 6.2 OFFWBF 地址管理器
**适用场景**：需要动态地址分配和回收的硬件模拟
**核心功能**：
- 优先级编码器行为
- OST ID 到地址映射
- 地址占用状态跟踪
- 自动释放机制

**复用建议**：
```systemverilog
// 独立包，可被其他模块引用
package offwbf_addr_manager_pkg;
  class offwbf_addr_manager;
    // 分配、释放、查询方法
  endclass
endpackage
```

### 6.3 Token Hash 匹配引擎
**适用场景**：多字段唯一性匹配
**核心特性**：
- 灵活字段组合
- 96bit 哈希空间
- 快速查找（associative array）

**复用建议**：
```systemverilog
// 通用哈希工具类
class token_hash_util #(type T = uvm_object);
  static function bit [96:0] create_hash(T obj);
    // 动态字段组合
  endfunction
endclass
```

### 6.4 Group 独立处理框架
**适用场景**：多组并行处理的验证场景
**核心特性**：
- 自动分组（参数化组大小）
- 组内独立统计
- 组间隔离判断

**复用建议**：
```systemverilog
// 参数化分组处理
class group_processor #(
  int GROUP_SIZE = 4,
  int NUM_GROUPS = 2
);
  // 通用分组逻辑
endclass
```

### 6.5 Log 提取工具 (Python)
**适用场景**：自动化日志分析
**核心功能**：
- 正则表达式匹配
- 多范围批量提取
- CSV 数据导出
- 实时日志监控

**复用建议**：
- 独立 Python 包，支持配置文件驱动
- 支持自定义数据模式提取

---

## 7. 技能化建议

### 7.1 UVM Checker 生成器 Skill
**功能**：根据协议规范自动生成 UVM Checker 代码
**输入**：
- 协议规范文档（Word/PDF）
- 事务类定义
- 检查规则配置
**输出**：
- 完整的 Checker 类
- 测试用例模板
- 统计报告模板

**关键特性**：
- 自动解析协议字段
- 生成匹配逻辑
- 生成检查项
- 生成统计代码

### 7.2 地址管理器生成器 Skill
**功能**：根据地址空间配置生成地址管理代码
**输入**：
- 地址空间大小
- 分配策略（优先级/轮询/随机）
- OST ID 位宽
**输出**：
- 地址分配/释放代码
- 状态跟踪代码
- 测试用例

### 7.3 日志分析自动化 Skill
**功能**：自动提取和分析仿真日志
**输入**：
- 日志文件路径
- 提取规则配置
- 输出格式（CSV/JSON/文本）
**输出**：
- 结构化数据
- 统计报告
- 异常检测

---

## 8. 测试策略

### 8.1 单元测试
- **分组判断测试**：验证每组独立判断逻辑
- **地址分配测试**：验证地址分配和释放
- **Hash 匹配测试**：验证 token 匹配正确性
- **边界条件测试**：验证满/空 FIFO、地址耗尽等

### 8.2 集成测试
- **完整流程测试**：从命令到响应的完整流程
- **并发处理测试**：多组同时处理
- **异常场景测试**：超时、不匹配、重复等

### 8.3 覆盖率驱动
- **功能覆盖率**：所有检查项组合
- **代码覆盖率**：分支/条件/状态机
- **断言覆盖率**：所有断言触发

---

## 9. 性能优化建议

### 9.1 哈希优化
- 使用更高效的哈希算法（如 MurmurHash）
- 考虑使用哈希表（associative array 已足够）

### 9.2 内存优化
- 及时清理已处理的 config
- 使用对象池减少分配开销

### 9.3 并行优化
- 利用 fork-join 并行处理多组
- 考虑使用 UVM 的 parallel processing 机制

---

## 10. 扩展方向

### 10.1 支持更多组
- 参数化组数量和组大小
- 动态分组策略

### 10.2 支持更多响应类型
- 扩展响应类型枚举
- 通用响应匹配框架

### 10.3 可视化监控
- 实时状态面板
- 统计图表生成
- 异常告警机制

---

## 附录

### A. 文件清单
| 文件 | 说明 |
|------|------|
| mychecker.sv | Checker 主实现 |
| mychecker_tb.sv | 测试平台 |
| nsu_cpu_transactions.sv | 事务类定义 |
| offdec2nsu_transaction.sv | OFFWBF 事务类 |
| axi_read_monitor.sv | AXI 读监视器 |
| normal_resp_checker.sv | Normal Response Checker |
| log_extractor.py | 日志提取工具 |

### B. 依赖关系
```
mychecker.sv
├── uvm_pkg
├── ondec2nsu_checker_pkg
│   ├── ondec2nsu_group_transaction
│   ├── nsu2cpu_deep_resp_transaction
│   └── offdec2nsu_transaction
└── normal_resp_checker_pkg
```

### C. 版本历史
- v1.0: 初始版本，支持 2 组独立处理
- 后续版本：支持更多组、更多响应类型

---

**文档生成时间**: 2026-03-22  
**作者**: OpenClaw Assistant  
**项目路径**: `/mnt/disk_0/IC/nsu/uvc/mychecker/`
