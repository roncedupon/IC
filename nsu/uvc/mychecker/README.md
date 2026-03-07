# ONDEC2NSU Checker - 第一步实现

## 概述

实现根据 `ondec_cmd` 检查 `resp` 是否正确的功能。

**第一步：从最简单开始**
- 获取 `ondec_cmd` 中的信息
- 假设 wbf 和 crc 全部译码成功
- 检查 `resp` 是否与期望匹配

## 文件结构

```
mychecker/
├── nsu_cpu_transactions.sv    # Transaction 定义 (依赖)
├── mychecker.sv               # Checker 主文件
└── mychecker_tb.sv            # 测试平台
```

## 实现原理

### 两步检查流程

```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐
│  ondec_cmd  │────>│  期望配置注册 │────>│   检查 resp  │
│  (输入)     │     │  (pending)   │     │   (验证)    │
└─────────────┘     └──────────────┘     └─────────────┘
```

### 第一步：获取 ondec_cmd

从 `ondec_cmd` 中提取期望信息：
- `instruction_index`: 用于匹配 resp
- `plane_pair_en`: 哪些 plane_pair 被使能
- 期望：所有使能的 plane_pair 都译码成功 (wbf 和 crc 成功)

```systemverilog
task check_ondec_cmd();
    forever begin
        ondec_cmd_fifo.get(cmd);
        
        // 提取期望信息
        cfg.valid = 1'b1;
        cfg.expected_instruction_index = cmd.instruction_index;
        cfg.expected_decode_success = 1'b1;  // 期望译码成功
        cfg.expected_crc_success = 1'b1;     // 期望 CRC 成功
        cfg.expected_plane_pair_en = cmd.plane_pair_en;
        
        // 注册期望配置
        pending_config[cfg.expected_instruction_index] = cfg;
    end
endtask
```

### 第二步：检查 resp

检查内容：
1. `instruction_index` 匹配
2. 译码状态 (`plane_pair_ondec_flag`): 0=成功，1=失败
3. CRC 状态 (`plane_crc_err`): 0=失败
4. LBA 比对 (`plane_pair_lba_comp`): 0=成功，1=失败

```systemverilog
task check_deep_read_resp();
    forever begin
        deep_read_resp_fifo.get(resp);
        
        // 查找匹配的期望配置
        if (pending_config.exists(resp.instruction_index)) begin
            cfg = pending_config[resp.instruction_index];
            
            // 检查译码状态 (只检查使能的 plane_pair)
            for (int pp = 0; pp < PLANE_PAIR_NUM; pp++) begin
                if (cfg.expected_plane_pair_en[pp] && resp.plane_pair_ondec_flag[pp]) begin
                    status = CHECK_FAIL_DECODE;
                end
            end
            
            // 检查 CRC 状态
            for (int pp = 0; pp < PLANE_PAIR_NUM; pp++) begin
                if (cfg.expected_plane_pair_en[pp] && !resp.plane_crc_err[pp]) begin
                    status = CHECK_FAIL_CRC;
                end
            end
        end
    end
endtask
```

## 使用方法

### 1. 编译顺序

```systemverilog
// 1. 先编译依赖
`include "nsu_cpu_transactions.sv"

// 2. 再编译 checker
`include "mychecker.sv"

// 3. 编译测试平台
`include "mychecker_tb.sv"
```

### 2. 实例化 Checker

```systemverilog
import nsu_cpu_transactions_pkg::*;
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
// ondec_cmd FIFO - 输入
dut.ondec_cmd_port.connect(checker.ondec_cmd_fifo.analysis_export);

// resp FIFO - 输入
dut.deep_read_resp_port.connect(checker.deep_read_resp_fifo.analysis_export);
```

### 4. 发送测试数据

```systemverilog
// 1. 发送 ondec_cmd
nsu2cpu_deep_resp_transaction ondec_cmd;
ondec_cmd = nsu2cpu_deep_resp_transaction::type_id::create("ondec_cmd");
ondec_cmd.instruction_index = 16'h0001;
ondec_cmd.plane_pair_en = 8'hFF;  // 8 个 plane_pair 都使能

checker.ondec_cmd_fifo.write(ondec_cmd);

// 2. 发送 resp (全部成功)
nsu2cpu_deep_resp_transaction resp;
resp = nsu2cpu_deep_resp_transaction::type_id::create("resp");
resp.instruction_index = 16'h0001;
resp.plane_pair_ondec_flag = 8'b0000_0000;  // 全部成功
resp.plane_crc_err = 8'b1111_1111;          // CRC 全部成功

checker.deep_read_resp_fifo.write(resp);
```

## 测试用例

### TEST 1: 所有 plane_pair 译码成功

```
ONDEC_CMD:  instr_idx=0x0001, pp_en=0xFF (全部使能)
期望：      全部译码成功，CRC 成功
RESP:       pp_ondec_flag=0x00, pp_crc_err=0xFF
结果：      PASS ✓
```

### TEST 2: 部分 plane_pair 译码失败

```
ONDEC_CMD:  instr_idx=0x0002, pp_en=0xFF (全部使能)
期望：      全部译码成功
RESP:       pp_ondec_flag=0x15 (plane 0,2,4 失败)
结果：      FAIL ✗ (CHECK_FAIL_DECODE)
```

### TEST 3: CRC 失败

```
ONDEC_CMD:  instr_idx=0x0003, pp_en=0xFF (全部使能)
期望：      CRC 全部成功
RESP:       pp_ondec_flag=0x00 (译码成功), pp_crc_err=0xD5 (plane 1,3 失败)
结果：      FAIL ✗ (CHECK_FAIL_CRC)
```

### TEST 4: 部分 plane_pair 使能

```
ONDEC_CMD:  instr_idx=0x0004, pp_en=0x55 (只使能 plane 0,2,4,6)
期望：      使能的 plane_pair 成功即可
RESP:       pp_ondec_flag=0xAA (未使能的 plane 1,3,5,7 失败)
结果：      PASS ✓ (只检查使能的 plane_pair)
```

## 检查状态码

| 状态码 | 值 | 描述 |
|-------|-----|------|
| `CHECK_PASS` | 3'b000 | 检查通过 |
| `CHECK_FAIL_INSTR_IDX` | 3'b011 | instruction_index 不匹配 |
| `CHECK_FAIL_DECODE` | 3'b100 | 译码状态错误 |
| `CHECK_FAIL_CRC` | 3'b110 | CRC 错误 |
| `CHECK_FAIL_LBA` | 3'b101 | LBA 比对错误 |

## Plane Pair 位域说明

### plane_pair_ondec_flag (8bit)
- 每位对应一个 plane_pair
- `0`: 译码成功
- `1`: 译码失败

### plane_crc_err (8bit)
- 每位对应一个 plane_pair
- `1`: CRC 成功
- `0`: CRC 失败

### plane_pair_lba_comp (8bit)
- 每位对应一个 plane_pair
- `0`: LBA 匹配成功
- `1`: LBA 比对失败

### plane_pair_en (8bit)
- 每位对应一个 plane_pair
- `1`: 该 plane_pair 使能
- `0`: 该 plane_pair 未使能

## 统计信息

### 计数器
- `total_cmd_count`: 接收到的 ondec_cmd 数量
- `total_resp_count`: 接收到的 resp 数量
- `pass_count`: 检查通过数量
- `fail_count`: 检查失败数量

### Plane Pair 统计 (8 个)
- `plane_pair_decode_success[0:7]`: 每个 plane_pair 译码成功次数
- `plane_pair_decode_fail[0:7]`: 每个 plane_pair 译码失败次数
- `plane_pair_crc_err[0:7]`: 每个 plane_pair CRC 错误次数
- `plane_pair_lba_mismatch[0:7]`: 每个 plane_pair LBA 比对失败次数

## 下一步开发

1. **添加更多检查项**:
   - mode_sel 检查 (safe read vs fast read)
   - deep_read_sel 检查
   - 更多字段验证

2. **完善错误处理**:
   - 超时处理 (resp 未及时到达)
   - 乱序处理 (resp 顺序与 cmd 不一致)

3. **添加 Coverage**:
   - 功能覆盖率
   - 代码覆盖率

4. **集成到完整环境**:
   - 与 driver/monitor 集成
   - 与 scoreboarding 集成
