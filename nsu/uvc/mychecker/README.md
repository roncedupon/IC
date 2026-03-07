# ONDEC2NSU Checker - Group 独立处理版本

## 概述

根据 `ondec2nsu_group_transaction` 的位域，**按 group 独立判断** NSU 的行为，并检查相应的响应。

**关键特性**：
- 8 个 plane_pair 分成 **2 个独立的 group**
- **Group 0**: plane_pair[0:3], ost_id = tr[0].nsu_ost_id
- **Group 1**: plane_pair[4:7], ost_id = tr[4].nsu_ost_id
- 每个 group 有 **独立的 ost_id**，需要独立处理和检查

## Group 划分

```
ondec2nsu_group_transaction (8 plane_pairs)
├── Group 0: plane_pair[0:3]
│   └── ost_id = tr[0].nsu_ost_id (独立)
└── Group 1: plane_pair[4:7]
    └── ost_id = tr[4].nsu_ost_id (独立)
```

**重要约束**：
- 两个 group 的 `ost_id` 可以不同（独立）
- 每个 group 独立判断需要什么响应（deep_resp 或 offwbf）
- 检查时通过 `ost_id` 匹配对应的 group

## 判断逻辑 (按 group 独立)

```
┌─────────────────────────────────────────────────────────────────┐
│ ondec2nsu_group_transaction (8 plane_pairs = 2 groups)          │
│   Group 0: PP[0:3], ost_id = tr[0].nsu_ost_id                   │
│   Group 1: PP[4:7], ost_id = tr[4].nsu_ost_id                   │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│ 对每个 group 独立判断 (遍历 group 内 4 个 plane_pair)               │
├─────────────────────────────────────────────────────────────────┤
│ 遍历 group 内 4 个 plane_pair:                                    │
│   if (dec_suc=0 && crc_pass=1 && data_out_en=0)                 │
│     → 该 group 需要上报 DEEP_READ_RESP                           │
│   if (dec_suc=0 && crc_pass=1 && data_out_en=1)                 │
│     → 该 group 需要调用 OFFWBF                                   │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│ 检查对应响应 (通过 ost_id 匹配 group)                              │
│   - DEEP_READ_RESP: ost_id 匹配 → 检查 plane_pair[4*gid:4*gid+3] │
│   - OFFWBF_CMD: ost_id 匹配 → 检查地址等字段                      │
└─────────────────────────────────────────────────────────────────┘
```

## 文件结构

```
mychecker/
├── nsu_cpu_transactions.sv          # Transaction 定义 (依赖)
├── ondec2nsu_transaction.sv         # ondec2nsu_group_transaction 定义
├── offwbf2nsu_transation.sv         # nsu2offwbf_transaction 定义
├── mychecker.sv                     # Checker 主文件 (Group 独立处理)
├── mychecker_tb.sv                  # 测试平台 (Group 独立测试)
└── README.md                        # 本文档
```

## 三步检查流程

### 第一步：获取 ondec2nsu_group_transaction

```systemverilog
task check_ondec_cmd();
    ondec2nsu_group_transaction group_tr;
    
    forever begin
        ondec_cmd_fifo.get(group_tr);
        
        // 按 group 处理 (Group 0: PP[0:3], Group 1: PP[4:7])
        for (int gid = 0; gid < 2; gid++) begin
            int pp_base = gid * 4;
            
            // 提取 group 配置
            grp_cfg.nsu_ost_id = group_tr.tr[pp_base].nsu_ost_id;
            for (int pp = 0; pp < 4; pp++) begin
                grp_cfg.dec_suc[pp] = group_tr.tr[pp_base + pp].dec_suc;
                grp_cfg.crc_pass[pp] = group_tr.tr[pp_base + pp].crc_pass;
                grp_cfg.data_out_en[pp] = group_tr.tr[pp_base + pp].data_out_en;
            end
            
            // 注册期望配置
            pending_config[instruction_index][gid] = grp_cfg;
        end
    end
endtask
```

### 第二步：按 group 判断

```systemverilog
// 对每个 group 独立判断
for (int gid = 0; gid < 2; gid++) begin
    logic group_need_deep_resp = 1'b0;
    logic group_need_offwbf = 1'b0;
    
    // 遍历 group 内 4 个 plane_pair
    for (int pp = 0; pp < 4; pp++) begin
        if (!grp_cfg.dec_suc[pp] && grp_cfg.crc_pass[pp]) begin
            if (!grp_cfg.data_out_en[pp]) begin
                group_need_deep_resp = 1'b1;  // 该 group 需要 deep_resp
            end else begin
                group_need_offwbf = 1'b1;     // 该 group 需要 offwbf
            end
        end
    end
end
```

### 第三步：检查响应 (通过 ost_id 匹配 group)

```systemverilog
task check_deep_read_resp();
    nsu2cpu_deep_resp_transaction resp;
    
    forever begin
        deep_read_resp_fifo.get(resp);
        
        // 遍历 2 个 group，通过 ost_id 匹配
        for (int gid = 0; gid < 2; gid++) begin
            cfg = pending_config[resp.instruction_index][gid];
            
            if (cfg.nsu_ost_id == resp.nsu_ost_id) begin
                // 找到匹配的 group
                matched_gid = gid;
                
                // 检查该 group 的 4 个 plane_pair
                for (int pp = 0; pp < 4; pp++) begin
                    int pp_idx = gid * 4 + pp;  // 全局 plane_pair 索引
                    
                    // 检查译码状态、CRC 状态等
                    if (cfg.dec_suc[pp] != !resp.plane_pair_ondec_flag[pp_idx]) begin
                        status = CHECK_FAIL_DECODE;
                    end
                end
            end
        end
    end
endtask
```

## 关键数据结构

### group_check_config_t

```systemverilog
typedef struct packed {
    logic        valid;
    logic [15:0] instruction_index;
    logic [4:0]  nsu_ost_id;               // Group 独立的 OST ID
    logic [3:0]  plane_sel;                // 4 个 plane_pair 选择
    logic [3:0]  dec_suc;                  // 4 个 plane_pair 译码成功
    logic [3:0]  crc_pass;                 // 4 个 plane_pair CRC 通过
    logic [3:0]  data_out_en;              // 4 个 plane_pair 数据输出使能
    logic [3:0]  offline_wbf_work_en;      // 4 个 plane_pair offwbf 使能
    logic        deep_read_sel;            // deep read 选择 (group 内一致)
    logic        read_mode;                // 读模式 (group 内一致)
    logic [31:0] dest_memory_addr;
    logic [31:0] dec_fail_dest_addr;
} group_check_config_t;
```

### pending_config 索引

```systemverilog
group_check_config_t pending_config [bit [15:0]][1:0];  // [instr_idx][group_id]
```

- `pending_config[instr_idx][0]`: Group 0 (PP[0:3]) 的配置
- `pending_config[instr_idx][1]`: Group 1 (PP[4:7]) 的配置

## 测试用例

### TEST 1: 两个 group 都译码成功

```
ONDEC_GROUP:  instr_idx=0x0001
  Group0 (PP[0:3]): ost_id=0, all decode_success → No action
  Group1 (PP[4:7]): ost_id=0, all decode_success → No action
期望行为：    无需上报 deep_resp 或 offwbf
```

### TEST 2: Group0 需要 deep_resp

```
ONDEC_GROUP:  instr_idx=0x0002
  Group0 (PP[0:3]): ost_id=1, decode_fail+crc_success+no_data → DEEP_READ_RESP
  Group1 (PP[4:7]): ost_id=2, decode_success → No action
期望响应：    DEEP_READ_RESP (ost_id=1, pp_ondec_flag[3:0]=1111)
检查结果：    PASS ✓
```

### TEST 3: Group1 需要 offwbf

```
ONDEC_GROUP:  instr_idx=0x0003
  Group0 (PP[0:3]): ost_id=3, decode_success → No action
  Group1 (PP[4:7]): ost_id=4, decode_fail+crc_success+data → OFFWBF_CMD
期望响应：    OFFWBF_CMD (ost_id=4, src_addr=dest_memory_addr)
检查结果：    PASS ✓
```

### TEST 4: 两个 group 需要不同的响应

```
ONDEC_GROUP:  instr_idx=0x0004
  Group0 (PP[0:3]): ost_id=5 → DEEP_READ_RESP
  Group1 (PP[4:7]): ost_id=6 → OFFWBF_CMD
期望响应：    DEEP_READ_RESP (ost_id=5) + OFFWBF_CMD (ost_id=6)
检查结果：    PASS ✓ (两者都通过)
```

## Group 独立处理的关键点

### 1. ost_id 独立

```systemverilog
// Group 0 和 Group 1 可以有独立的 ost_id
ondec_cmd.tr[0].nsu_ost_id = 5'h01;  // Group 0: ost_id=1
ondec_cmd.tr[4].nsu_ost_id = 5'h02;  // Group 1: ost_id=2 (独立)
```

### 2. 判断逻辑独立

```systemverilog
// 每个 group 独立判断需要什么响应
for (int gid = 0; gid < 2; gid++) begin
    // Group 0 和 Group 1 的判断互不影响
    if (group_need_deep_resp) begin
        // 该 group 需要 deep_resp
    end
    if (group_need_offwbf) begin
        // 该 group 需要 offwbf
    end
end
```

### 3. 检查时通过 ost_id 匹配

```systemverilog
// 通过 ost_id 找到匹配的 group
for (int gid = 0; gid < 2; gid++) begin
    if (cfg.nsu_ost_id == resp.nsu_ost_id) begin
        matched_gid = gid;  // 找到匹配的 group
        // 检查该 group 的 plane_pair
    end
end
```

### 4. 统计独立

```systemverilog
int unsigned group_decode_success [1:0];  // Group 0 和 Group 1 独立统计
int unsigned group_decode_fail [1:0];
int unsigned group_crc_err [1:0];
```

## 检查状态码

| 状态码 | 值 | 描述 |
|-------|-----|------|
| `CHECK_PASS` | 3'b000 | 检查通过 |
| `CHECK_FAIL_DECODE` | 3'b100 | 译码状态不匹配 |
| `CHECK_FAIL_CRC` | 3'b110 | CRC 状态不匹配 |
| `CHECK_FAIL_OST_ID` | 3'b010 | OST ID 不匹配 |
| `CHECK_FAIL_DATA` | 3'b001 | 数据不匹配 (地址、标志等) |

## 使用方法

### 编译顺序

```systemverilog
`include "nsu_cpu_transactions.sv"
`include "ondec2nsu_transaction.sv"
`include "offwbf2nsu_transation.sv"
`include "mychecker.sv"
`include "mychecker_tb.sv"
```

### 实例化

```systemverilog
import nsu_cpu_transactions_pkg::*;
import ondec2nsu_transaction_pkg::*;
import nsu2offwbf_transaction_pkg::*;
import ondec2nsu_checker_pkg::*;

ondec2nsu_checker checker;

initial begin
    checker = new("checker", null);
    checker.build_phase(null);
    
    fork
        checker.run_phase(null);
    join_none
end
```

### 连接 FIFO

```systemverilog
// ondec_cmd FIFO - 输入 (ondec2nsu_group_transaction)
dut.ondec_cmd_port.connect(checker.ondec_cmd_fifo.analysis_export);

// deep_read_resp FIFO - 输入 (nsu2cpu_deep_resp_transaction)
dut.deep_read_resp_port.connect(checker.deep_read_resp_fifo.analysis_export);

// offwbf_cmd FIFO - 输入 (nsu2offwbf_transaction)
dut.offwbf_cmd_port.connect(checker.offwbf_cmd_fifo.analysis_export);
```

## 关键特性

1. **Group 独立处理**: 8 个 plane_pair 分成 2 个 group，每个 group 独立判断和检查
2. **ost_id 匹配**: 通过 ost_id 匹配对应的 group，支持两个 group 有不同的 ost_id
3. **三路检查**: deep_read_resp 和 offwbf_cmd 并行检查
4. **智能判断**: 根据 group 内 plane_pair 的状态自动判断期望的响应类型
5. **独立统计**: Group 0 和 Group 1 的统计独立

## 下一步开发

1. **添加更多检查项**:
   - LBA 比对检查
   - meta_buffer_id 检查
   - plane_group_block_addr 和 page_addr_plane_group 检查

2. **完善错误处理**:
   - 超时处理 (resp 未到达)
   - 乱序处理 (out-of-order resp)

3. **添加 Coverage**:
   - 功能覆盖率
   - 代码覆盖率

4. **集成到完整 NSU agent**:
   - 添加 driver
   - 添加 monitor
   - 添加 sequence
