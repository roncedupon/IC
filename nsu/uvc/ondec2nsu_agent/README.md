# ONDEC2NSU Checker 使用说明

## 概述

`ondec2nsu_checker.sv` 是一个 UVM 检查器，用于验证 NSU 模块上报给 CPU 的响应是否正确。

**依赖**: `nsu_cpu_transactions.sv` (`nsu_cpu_transactions_pkg`)
- 包含 8 个 plane_pair 参数定义 (`PLANE_PAIR_NUM = 8`)
- 包含所有 NSU-CPU 交互 transaction 定义

**编译顺序**: 必须先编译 `nsu_cpu_transactions.sv`，再编译 `ondec2nsu_checker.sv`

**注意**: 本 checker **仅处理读操作相关**的 transaction，不包含 write 相关检查。

参考文档：`升维 MP-NSU-spec PN85.docx` 第 6.4 节 CPU 交互指令

## 文件结构

```
ondec2nsu_agent/
├── nsu_cpu_transactions.sv    # Transaction 定义 (依赖，必须先编译)
├── ondec2nsu_checker.sv       # Checker 主文件 (仅读操作)
├── ondec2nsu_checker_tb.sv    # 测试平台示例
└── README.md                  # 本文档
```

## 支持的 Transaction 类型 (仅读操作)

### NSU→CPU 响应 (检查)

| 响应类型 | Spec 章节 | Transaction 类 | FIFO 名称 |
|---------|----------|---------------|-----------|
| `READ_RESP` | 6.4.10 | `nsu2cpu_rcmd_transaction` | `read_resp_fifo` |
| `DEEP_READ_RESP` | 6.4.11 | `nsu2cpu_deep_resp_transaction` | `deep_read_resp_fifo` |
| `MSA_RESP` | 6.4.7 | `nsu2cpu_msa_resp_transaction` | `msa_resp_fifo` |

### CPU→NSU 命令 (监控)

| 命令类型 | Spec 章节 | Transaction 类 | FIFO 名称 |
|---------|----------|---------------|-----------|
| `MSA_REQ` | 6.4.6 | `cpu2nsu_msa_write_req_transaction` | `msa_req_fifo` |
| `UNMAP_CMD` | 6.4.8 | `cpu2nsu_unmap_cmd_transaction` | `unmap_cmd_fifo` |

## 关键参数 (从 nsu_cpu_transactions_pkg 导入)

```systemverilog
// 8 个 plane_pair
parameter PLANE_PAIR_NUM = 8;

// Queue 深度
parameter READ_RESP_QUEUE_DEPTH       = 128;  // 4 个队列
parameter DEEP_READ_RESP_QUEUE_DEPTH  = 109;
parameter MSA_RESP_QUEUE_DEPTH        = 8;
```

## 数据结构

### expected_resp_config_t - 期望响应配置

```systemverilog
typedef struct packed {
    logic valid;
    logic [4:0] expected_ost_id;           // 5bit outstanding ID
    logic [15:0] expected_instruction_index;
    logic expected_decode_success;         // 1: 译码成功
    logic expected_lba_match;              // 1: LBA 比对成功
    logic expected_err_flag_match;         // 1: error flag 比对成功
    logic expected_crc_success;            // 1: CRC 成功
    logic [7:0] expected_error_plane_pair_sel;  // 8 个 plane_pair
    logic [7:0] expected_plane_pair_en;         // 8 个 plane_pair
    logic [7:0] expected_plane_pair_ondec_flag; // 8 个 plane_pair 译码状态
    logic [7:0] expected_plane_pair_lba_comp;   // 8 个 plane_pair LBA 比对
    logic expected_mode_sel;             // 0: safe read, 1: fast read
} expected_resp_config_t;
```

## 使用方法

### 1. 编译顺序

```systemverilog
// 1. 先编译依赖
`include "nsu_cpu_transactions.sv"

// 2. 再编译 checker
`include "ondec2nsu_checker.sv"
```

### 2. 导入包

```systemverilog
import nsu_cpu_transactions_pkg::*;  // 导入所有 transaction 和参数
import ondec2nsu_checker_pkg::*;
```

### 3. 实例化 Checker

```systemverilog
ondec2nsu_checker checker;

function void build_phase(uvm_phase phase);
    checker = ondec2nsu_checker::type_id::create("checker", this);
endfunction
```

### 4. 连接 FIFO

```systemverilog
// NSU→CPU 响应 (检查)
dut.read_resp_port.connect(checker.read_resp_fifo.analysis_export);
dut.deep_read_resp_port.connect(checker.deep_read_resp_fifo.analysis_export);
dut.msa_resp_port.connect(checker.msa_resp_fifo.analysis_export);

// CPU→NSU 命令 (监控)
dut.msa_req_port.connect(checker.msa_req_fifo.analysis_export);
dut.unmap_cmd_port.connect(checker.unmap_cmd_fifo.analysis_export);
```

### 5. 注册期望的响应

```systemverilog
// 创建期望配置 (通过 instruction_index)
expected_resp_config_t cfg;
cfg.valid = 1'b1;
cfg.expected_instruction_index = 16'h0001;
cfg.expected_ost_id = 5'h5;
cfg.expected_decode_success = 1'b1;  // 期望译码成功
cfg.expected_lba_match = 1'b1;       // 期望 LBA 匹配
cfg.expected_crc_success = 1'b1;     // 期望 CRC 成功
cfg.expected_plane_pair_en = 8'hFF;  // 8 个 plane_pair 都使能

// 注册配置 (用于 read_resp, deep_read_resp, msa_resp)
checker.register_expected_config(cfg);
```

### 6. 获取统计信息

```systemverilog
// 基本统计
int unsigned total, pass, fail;
checker.get_stats(total, pass, fail);

// 详细统计 (按响应类型)
int unsigned read, deep_read, msa, msa_req, unmap_cmd;
checker.get_detailed_stats(read, deep_read, msa, msa_req, unmap_cmd);

// Plane Pair 统计 (8 个 plane_pair)
int unsigned decode_success [0:7];
int unsigned decode_fail [0:7];
int unsigned crc_err [0:7];
int unsigned lba_mismatch [0:7];
checker.get_plane_pair_stats(decode_success, decode_fail, crc_err, lba_mismatch);
```

## 检查逻辑

### NSU→CPU 响应检查

#### READ_RESP 检查 (6.4.10)
- 通过 `instruction_index` 匹配
- 检查 `error_plane_pair_sel` (8bit, 每位对应一个 plane_pair)
- 0=译码成功，1=译码失败
- 更新 plane_pair 统计计数器

#### DEEP_READ_RESP 检查 (6.4.11)
- 通过 `instruction_index` 匹配
- 检查 `plane_pair_ondec_flag` (8bit, 0=成功，1=失败)
- 检查 `plane_pair_lba_comp` (8bit, 0=成功，1=失败)
- 检查 `plane_crc_err` (8bit, 0=失败)
- 检查 `mode_sel` (0=safe read, 1=fast read)
- 更新 plane_pair 统计计数器

#### MSA_RESP 检查 (6.4.7)
- 通过 `instruction_index` 匹配
- 验证 MSA 解码完成响应

### CPU→NSU 命令监控

#### MSA_REQ 监控 (6.4.6)
- 监控 CPU 发送的 MSA write 请求
- **自动注册期望的 MSA resp 配置**

#### UNMAP_CMD 监控 (6.4.8)
- 监控 CPU 发送的 unmap 命令
- 用于统计，不需要 resp

## 状态码

| 状态码 | 值 | 描述 |
|-------|-----|------|
| `CHECK_PASS` | 3'b000 | 检查通过 |
| `CHECK_FAIL_DATA` | 3'b001 | 数据错误 |
| `CHECK_FAIL_OST_ID` | 3'b010 | ost_id 不匹配 |
| `CHECK_FAIL_INSTR_IDX` | 3'b011 | instruction_index 不匹配 |
| `CHECK_FAIL_DECODE` | 3'b100 | 译码状态错误 |
| `CHECK_FAIL_LBA` | 3'b101 | LBA 比对错误 |
| `CHECK_FAIL_CRC` | 3'b110 | CRC 错误 |
| `CHECK_INVALID_RESP` | 3'b111 | 无效响应 |

## Plane Pair 统计 (8 个)

检查器为每个 plane_pair 维护以下统计：

| 统计项 | 描述 |
|-------|------|
| `decode_success` | 译码成功次数 |
| `decode_fail` | 译码失败次数 |
| `crc_err` | CRC 错误次数 |
| `lba_mismatch` | LBA 比对失败次数 |

## 示例代码

### 完整测试序列示例

```systemverilog
class ondec2nsu_test_seq extends uvm_sequence #(uvm_object);
    `uvm_object_utils(ondec2nsu_test_seq)
    
    ondec2nsu_checker checker;
    
    virtual task body();
        expected_resp_config_t cfg;
        nsu2cpu_deep_resp_transaction deep_resp;
        
        // 1. 注册期望配置
        cfg = '{
            valid: 1'b1,
            expected_instruction_index: 16'h0001,
            expected_ost_id: 5'h5,
            expected_decode_success: 1'b1,
            expected_lba_match: 1'b1,
            expected_crc_success: 1'b1,
            expected_plane_pair_en: 8'hFF,
            expected_plane_pair_ondec_flag: 8'h00,
            expected_plane_pair_lba_comp: 8'h00,
            expected_mode_sel: 1'b0  // safe read
        };
        
        checker.register_expected_config(cfg);
        
        // 2. 创建并发送响应
        deep_resp = nsu2cpu_deep_resp_transaction::type_id::create("deep_resp");
        deep_resp.instruction_index = 16'h0001;
        deep_resp.plane_pair_en = 8'hFF;
        deep_resp.plane_pair_ondec_flag = 8'h00;  // 全部成功
        deep_resp.plane_pair_lba_comp = 8'h00;    // LBA 全部匹配
        deep_resp.plane_crc_err = 8'hFF;          // CRC 全部成功
        deep_resp.mode_sel = 1'b0;
        
        checker.deep_read_resp_fifo.write(deep_resp);
        
        // 3. 获取统计
        int unsigned total, pass, fail;
        checker.get_stats(total, pass, fail);
        `uvm_info("TEST", $sformatf("Stats: total=%0d, pass=%0d, fail=%0d", 
            total, pass, fail), UVM_LOW)
    endtask
endclass
```

### MSA Req-Resp 自动配对示例

```systemverilog
// 1. CPU 发送 MSA 请求 (checker 会自动注册期望配置)
cpu2nsu_msa_write_req_transaction msa_req;
msa_req = cpu2nsu_msa_write_req_transaction::type_id::create("msa_req");
msa_req.instruction_index = 16'h0100;
msa_req.ost_id = 5'h3;
checker.msa_req_fifo.write(msa_req);

// 2. NSU 返回 MSA 响应
nsu2cpu_msa_resp_transaction msa_resp;
msa_resp = nsu2cpu_msa_resp_transaction::type_id::create("msa_resp");
msa_resp.instruction_index = 16'h0100;  // 与请求匹配
checker.msa_resp_fifo.write(msa_resp);

// 3. checker 自动验证匹配并报告 PASS
```

### Plane Pair 统计查询示例

```systemverilog
int unsigned decode_success [0:7];
int unsigned decode_fail [0:7];
int unsigned crc_err [0:7];
int unsigned lba_mismatch [0:7];

checker.get_plane_pair_stats(decode_success, decode_fail, crc_err, lba_mismatch);

for (int pp = 0; pp < 8; pp++) begin
    `uvm_info("STATS", $sformatf(
        "PP[%0d]: success=%0d, fail=%0d, crc_err=%0d, lba_mismatch=%0d",
        pp, decode_success[pp], decode_fail[pp], crc_err[pp], lba_mismatch[pp]
    ), UVM_LOW)
end
```

## 注意事项

1. **编译顺序**: 必须先编译 `nsu_cpu_transactions.sv`，再编译 `ondec2nsu_checker.sv`

2. **直接使用类名**: 导入 `nsu_cpu_transactions_pkg::*` 后，直接使用类名如 `nsu2cpu_deep_resp_transaction`，无需前缀

3. **仅读操作**: 本 checker 不包含 write 相关的检查 (io_write_resp, write_req 等)

4. **Plane Pair 数量**: 固定为 8 个，由 `PLANE_PAIR_NUM` 参数定义

5. **Instruction Index**: 用于唯一标识每条指令，必须与期望配置中的 index 匹配

6. **OST ID**: 5bit 宽度，支持 32 个 outstanding 命令

7. **Plane Pair 位域**:
   - `error_plane_pair_sel[i]`: 第 i 个 plane_pair 的译码状态 (READ_RESP)
   - `plane_pair_ondec_flag[i]`: 第 i 个 plane_pair 的 ondec 状态 (DEEP_READ_RESP)
   - `plane_pair_lba_comp[i]`: 第 i 个 plane_pair 的 LBA 比对 (DEEP_READ_RESP)
   - `plane_crc_err[i]`: 第 i 个 plane_pair 的 CRC 状态 (DEEP_READ_RESP)

8. **自动注册**: `msa_req_fifo` 会自动注册期望的 MSA resp 配置

9. **Task 实现格式**: 所有 check task 采用 class 内声明、class 外实现的格式

## UVM 集成

### Agent 中的使用

```systemverilog
class ondec2nsu_agent extends uvm_agent;
    import nsu_cpu_transactions_pkg::*;
    import ondec2nsu_checker_pkg::*;
    
    ondec2nsu_checker checker;
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        checker = ondec2nsu_checker::type_id::create("checker", this);
    endfunction
    
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        // 连接 monitor 到 checker (仅读相关)
        monitor.read_resp_ap.connect(checker.read_resp_fifo.analysis_export);
        monitor.deep_resp_ap.connect(checker.deep_read_resp_fifo.analysis_export);
        monitor.msa_resp_ap.connect(checker.msa_resp_fifo.analysis_export);
        monitor.msa_req_ap.connect(checker.msa_req_fifo.analysis_export);
        monitor.unmap_cmd_ap.connect(checker.unmap_cmd_fifo.analysis_export);
    endfunction
endclass
```

## 下一步开发

1. 添加 coverage model (covergroup)
2. 实现 `ondec2nsu_cmd_monitor` 自动捕获 ondec2nsu_cmd
3. 集成到完整的 NSU verification environment
