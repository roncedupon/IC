# ONDEC2NSU Checker - 直接判断版本

## 概述

根据 `ondec2nsu_group_transaction` 的位域直接判断 NSU 的行为，并检查相应的响应。

**三步检查流程**：
1. 获取 `ondec2nsu_group_transaction` (8 个 plane_pair)
2. 根据位域直接判断：译码失败→检查 deep_resp 或 offwbf
3. 从对应队列中找到匹配的 transaction 进行比较

## 判断逻辑

```
┌─────────────────────────────────────────────────────────────────┐
│ ondec2nsu_group_transaction (8 plane_pairs)                     │
│   foreach plane_pair:                                           │
│     - plane_sel                                                 │
│     - dec_suc                                                   │
│     - crc_pass                                                  │
│     - data_out_en                                               │
│     - offline_wbf_work_en                                       │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│ 判断逻辑 (每个 plane_pair 独立)                                   │
├─────────────────────────────────────────────────────────────────┤
│ dec_suc=1                    → 译码成功，无需上报                │
│ dec_suc=0 && crc_pass=0      → 译码失败+CRC 失败，无需上报        │
│ dec_suc=0 && crc_pass=1      → 译码失败+CRC 成功                 │
│   && data_out_en=0           → 数据不输出 → 上报 DEEP_READ_RESP  │
│ dec_suc=0 && crc_pass=1      → 译码失败+CRC 成功                 │
│   && data_out_en=1           → 数据输出 → 调用 OFFWBF            │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│ 检查对应响应                                                     │
│   - DEEP_READ_RESP: 检查 plane_pair_ondec_flag, plane_crc_err   │
│   - OFFWBF_CMD: 检查 src_mem_addr, dec_fail_dest_addr           │
└─────────────────────────────────────────────────────────────────┘
```

## 文件结构

```
mychecker/
├── nsu_cpu_transactions.sv          # Transaction 定义 (依赖)
├── ondec2nsu_transaction.sv         # ondec2nsu_group_transaction 定义
├── offwbf2nsu_transation.sv         # nsu2offwbf_transaction 定义 (新增)
├── mychecker.sv                     # Checker 主文件 (重写)
├── mychecker_tb.sv                  # 测试平台 (更新)
└── README.md                        # 本文档
```

## 关键位域说明

### ondec2nsu_transaction 关键字段

| 字段 | 位宽 | 说明 |
|------|------|------|
| `plane_sel` | 1 | plane 选择 (1=选中) |
| `dec_suc` | 1 | 译码成功 (1=成功) |
| `crc_pass` | 1 | CRC 通过 (1=通过) |
| `data_out_en` | 1 | 数据输出使能 (1=使能) |
| `offline_wbf_work_en` | 1 | offwbf 使能 (1=使能) |
| `deep_read_sel` | 1 | deep read 选择 (1=使能) |
| `read_mode` | 1 | 读模式 (0=safe, 1=fast) |
| `instruction_index` | 16 | 指令索引 (用于匹配) |
| `nsu_ost_id` | 5 | OST ID |
| `dest_memory_addr` | 32 | 目标内存地址 |
| `dec_fail_dest_addr` | 32 | 译码失败目标地址 |

### nsu2cpu_deep_resp_transaction 关键字段

| 字段 | 位宽 | 说明 |
|------|------|------|
| `instruction_index` | 16 | 指令索引 |
| `nsu_ost_id` | 5 | OST ID |
| `plane_pair_ondec_flag[7:0]` | 8 | plane_pair 译码标志 (0=成功，1=失败) |
| `plane_pair_lba_comp[7:0]` | 8 | LBA 比对 (0=匹配，1=不匹配) |
| `plane_crc_err[7:0]` | 8 | CRC 错误 (0=失败，1=成功) |
| `deep_read_sel` | 1 | deep read 选择 |
| `mode_sel` | 1 | 模式选择 (0=safe, 1=fast) |

### nsu2offwbf_transaction 关键字段

| 字段 | 位宽 | 说明 |
|------|------|------|
| `instruction_index` | 16 | 指令索引 |
| `nsu_ost_id` | 5 | OST ID |
| `src_mem_addr` | 32 | 源内存地址 (从 dest_memory_addr 来) |
| `dec_fail_dest_addr` | 32 | 译码失败目标地址 |
| `offwbf_start` | 1 | offwbf 启动标志 |
| `read_mode` | 1 | 读模式 (offwbf 只在 safe read 下调用) |

## 检查流程详解

### 第一步：获取 ondec2nsu_group_transaction

```systemverilog
task check_ondec_cmd();
    ondec2nsu_group_transaction group_tr;
    
    forever begin
        ondec_cmd_fifo.get(group_tr);
        
        // 遍历 8 个 plane_pair
        for (int pp = 0; pp < 8; pp++) begin
            // 提取关键字段
            pp_cfg.plane_sel = group_tr.tr[pp].plane_sel;
            pp_cfg.dec_suc = group_tr.tr[pp].dec_suc;
            pp_cfg.crc_pass = group_tr.tr[pp].crc_pass;
            pp_cfg.data_out_en = group_tr.tr[pp].data_out_en;
            
            // 注册期望配置
            pending_config[instruction_index][pp] = pp_cfg;
        end
    end
endtask
```

### 第二步：判断逻辑 (每个 plane_pair 独立)

```systemverilog
// 判断逻辑
if (pp_cfg.dec_suc) begin
    // 译码成功：不需要上报
    `uvm_info(..., "Decode success, no action needed", UVM_HIGH)
end else if (!pp_cfg.crc_pass) begin
    // 译码失败且 CRC 失败：不需要上报
    `uvm_info(..., "Decode fail + CRC fail, no action needed", UVM_HIGH)
end else if (!pp_cfg.data_out_en) begin
    // 译码失败但 CRC 成功，数据不输出 → 上报 deep_resp
    `uvm_info(..., "Expect DEEP_READ_RESP", UVM_LOW)
end else begin
    // 译码失败但 CRC 成功，数据输出 → 调用 offwbf
    `uvm_info(..., "Expect OFFWBF_CMD", UVM_LOW)
end
```

### 第三步：检查 deep_read_resp

```systemverilog
task check_deep_read_resp();
    nsu2cpu_deep_resp_transaction resp;
    
    forever begin
        deep_read_resp_fifo.get(resp);
        
        // 查找匹配的期望配置
        if (pending_config.exists(resp.instruction_index)) begin
            for (int pp = 0; pp < 8; pp++) begin
                cfg = pending_config[resp.instruction_index][pp];
                
                // 只检查期望上报 deep_resp 的 plane_pair
                if (!cfg.dec_suc && cfg.crc_pass && !cfg.data_out_en) begin
                    // 检查译码状态
                    if (cfg.dec_suc != !resp.plane_pair_ondec_flag[pp]) begin
                        status = CHECK_FAIL_DECODE;
                    end
                    
                    // 检查 CRC 状态
                    if (cfg.crc_pass != resp.plane_crc_err[pp]) begin
                        status = CHECK_FAIL_CRC;
                    end
                    
                    // 检查 OST ID
                    if (cfg.nsu_ost_id != resp.nsu_ost_id) begin
                        status = CHECK_FAIL_OST_ID;
                    end
                end
            end
        end
    end
endtask
```

### 第四步：检查 offwbf_cmd

```systemverilog
task check_offwbf_cmd();
    nsu2offwbf_transaction offwbf_tr;
    
    forever begin
        offwbf_cmd_fifo.get(offwbf_tr);
        
        // 查找匹配的期望配置
        if (pending_config.exists(offwbf_tr.instruction_index)) begin
            for (int pp = 0; pp < 8; pp++) begin
                cfg = pending_config[offwbf_tr.instruction_index][pp];
                
                // 只检查期望调用 offwbf 的 plane_pair
                if (!cfg.dec_suc && cfg.crc_pass && cfg.data_out_en) begin
                    // 检查 OST ID
                    if (cfg.nsu_ost_id != offwbf_tr.nsu_ost_id) begin
                        status = CHECK_FAIL_OST_ID;
                    end
                    
                    // 检查源地址
                    if (cfg.dest_memory_addr != offwbf_tr.src_mem_addr) begin
                        status = CHECK_FAIL_DATA;
                    end
                    
                    // 检查 offwbf_start
                    if (!offwbf_tr.offwbf_start) begin
                        status = CHECK_FAIL_DATA;
                    end
                end
            end
        end
    end
endtask
```

## 测试用例

### TEST 1: 所有 plane_pair 译码成功

```
ONDEC_GROUP:  instr_idx=0x0001, 8 plane_pairs (dec_suc=1, crc_pass=1)
判断结果：    无需上报 deep_resp 或 offwbf
期望行为：    无
```

### TEST 2: 译码失败 + CRC 成功 + 数据不输出

```
ONDEC_GROUP:  instr_idx=0x0002, 8 plane_pairs (dec_suc=0, crc_pass=1, data_out_en=0)
判断结果：    需要上报 DEEP_READ_RESP
期望响应：    plane_pair_ondec_flag=0xFF (全部失败)
             plane_crc_err=0xFF (全部成功)
检查结果：    PASS ✓
```

### TEST 3: 译码失败 + CRC 成功 + 数据输出

```
ONDEC_GROUP:  instr_idx=0x0003, 8 plane_pairs (dec_suc=0, crc_pass=1, data_out_en=1)
判断结果：    需要调用 OFFWBF
期望响应：    src_mem_addr = dest_memory_addr
             offwbf_start = 1
检查结果：    PASS ✓
```

### TEST 4: 混合场景

```
ONDEC_GROUP:  instr_idx=0x0004
             PP[0,2,4,6]: dec_suc=0, crc_pass=1, data_out_en=0 → DEEP_READ_RESP
             PP[1,3,5,7]: dec_suc=0, crc_pass=1, data_out_en=1 → OFFWBF_CMD
检查结果：    PASS ✓ (两者都通过)
```

## 检查状态码

| 状态码 | 值 | 描述 |
|-------|-----|------|
| `CHECK_PASS` | 3'b000 | 检查通过 |
| `CHECK_FAIL_DECODE` | 3'b100 | 译码状态不匹配 |
| `CHECK_FAIL_CRC` | 3'b110 | CRC 状态不匹配 |
| `CHECK_FAIL_OST_ID` | 3'b010 | OST ID 不匹配 |
| `CHECK_FAIL_DATA` | 3'b001 | 数据不匹配 (地址、标志等) |
| `CHECK_FAIL_INSTR_IDX` | 3'b011 | instruction_index 不匹配 |
| `CHECK_FAIL_LBA` | 3'b101 | LBA 比对错误 |
| `CHECK_INVALID_RESP` | 3'b111 | 无效的响应 |

## 使用方法

### 1. 编译顺序

```systemverilog
// 1. 先编译依赖
`include "nsu_cpu_transactions.sv"
`include "ondec2nsu_transaction.sv"
`include "offwbf2nsu_transation.sv"

// 2. 再编译 checker
`include "mychecker.sv"

// 3. 编译测试平台
`include "mychecker_tb.sv"
```

### 2. 实例化 Checker

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

### 3. 连接 FIFO

```systemverilog
// ondec_cmd FIFO - 输入 (ondec2nsu_group_transaction)
dut.ondec_cmd_port.connect(checker.ondec_cmd_fifo.analysis_export);

// deep_read_resp FIFO - 输入 (nsu2cpu_deep_resp_transaction)
dut.deep_read_resp_port.connect(checker.deep_read_resp_fifo.analysis_export);

// offwbf_cmd FIFO - 输入 (nsu2offwbf_transaction)
dut.offwbf_cmd_port.connect(checker.offwbf_cmd_fifo.analysis_export);
```

### 4. 发送测试数据

```systemverilog
// 1. 发送 ondec2nsu_group_transaction
ondec2nsu_group_transaction ondec_cmd;
ondec_cmd = ondec2nsu_group_transaction::type_id::create("ondec_cmd");
for (int i = 0; i < 8; i++) begin
    ondec_cmd.tr[i].instruction_index = 16'h0001;
    ondec_cmd.tr[i].plane_sel = 1'b1;
    ondec_cmd.tr[i].dec_suc = 1'b0;     // 译码失败
    ondec_cmd.tr[i].crc_pass = 1'b1;    // CRC 成功
    ondec_cmd.tr[i].data_out_en = 1'b0; // 数据不输出
end

checker.ondec_cmd_fifo.write(ondec_cmd);

// 2a. 发送 deep_read_resp (如果 data_out_en=0)
nsu2cpu_deep_resp_transaction resp;
resp = nsu2cpu_deep_resp_transaction::type_id::create("resp");
resp.instruction_index = 16'h0001;
resp.plane_pair_ondec_flag = 8'b1111_1111;  // 全部失败
resp.plane_crc_err = 8'b1111_1111;          // 全部成功

checker.deep_read_resp_fifo.write(resp);

// 2b. 发送 offwbf_cmd (如果 data_out_en=1)
nsu2offwbf_transaction offwbf_tr;
offwbf_tr = nsu2offwbf_transaction::type_id::create("offwbf_tr");
offwbf_tr.instruction_index = 16'h0001;
offwbf_tr.src_mem_addr = 32'h1000_0000;
offwbf_tr.offwbf_start = 1'b1;

checker.offwbf_cmd_fifo.write(offwbf_tr);
```

## 关键特性

1. **直接判断**: 移除 `expected_resp_config_t`，直接根据 `ondec2nsu_group_transaction` 的位域判断
2. **8 个 plane_pair 独立**: 每个 plane_pair 独立判断和检查
3. **三路检查**: deep_read_resp 和 offwbf_cmd 并行检查
4. **智能匹配**: 根据 `dec_suc`, `crc_pass`, `data_out_en` 自动判断期望的响应类型
5. **详细错误报告**: 指出具体哪个 plane_pair 不匹配

## 下一步开发

1. **添加更多检查项**:
   - LBA 比对检查
   - meta_buffer_id 检查
   - descramble_en 和 descramble_seed 检查

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
