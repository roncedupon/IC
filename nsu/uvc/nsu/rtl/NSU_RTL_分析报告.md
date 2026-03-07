# NSU RTL 代码分析报告

**文档版本**: v1.0  
**生成日期**: 2026-03-07  
**分析对象**: `/mnt/disk_0/IC/nsu/uvc/nsu/rtl/nsu_nand_rd_cmd_merge_ctrl.v`  
**参考规格**: 升维 MP-NSU-spec PN85.docx Section 6.4 (CPU 交互指令)

---

## 📋 目录

1. [模块概述](#1-模块概述)
2. [接口信号完整说明](#2-接口信号完整说明)
3. [内部状态机分析](#3-内部状态机分析)
4. [命令处理流程](#4-命令处理流程)
5. [数据路径详解](#5-数据路径详解)
6. [关键子模块分析](#6-关键子模块分析)
7. [时序关系](#7-时序关系)
8. [与验证组件的映射](#8-与验证组件的映射)
9. [附录：参数定义](#9-附录参数定义)

---

## 1. 模块概述

### 1.1 模块功能

**`nsu_nand_rd_cmd_merge_ctrl`** 是 NSU (NAND Storage Unit) 的核心控制模块，负责：

1. **命令接收**: 接收来自 5 种源头的命令
   - 8 路在线译码命令 (ONDEC[7:0])
   - 离线译码命令 (OFFWBF)
   - MSA 命令 (Meta Storage Access)
   - 硬件 UNMAP 命令
   - 软件 UNMAP 命令

2. **命令仲裁**: 根据优先级选择待处理的命令

3. **命令解码**: 解析 384bit 命令字，提取控制字段

4. **状态控制**: 根据 `read_mode` 和 `dec_status` 决定处理路径

5. **响应生成**: 生成 Read Response 或 Deep Response

6. **数据路由**: 控制数据流向 (直接响应 / OFFWBF 处理 / MSA)

### 1.2 模块在 NSU 中的位置

```
┌─────────────────────────────────────────────────────────┐
│                         NSU Top                          │
│  ┌─────────────────────────────────────────────────────┐ │
│  │           nsu_nand_rd_cmd_merge_ctrl                │ │
│  │  (本模块 - 命令合并与状态控制)                        │ │
│  └─────────────────────────────────────────────────────┘ │
│                          │                                │
│  ┌───────────────────────┼───────────────────────┐       │
│  │                       │                       │       │
│  ▼                       ▼                       ▼       │
│ ┌──────────┐      ┌──────────┐           ┌──────────┐   │
│ │ nsu_rd_  │      │ nsu_tx_  │           │ nsu_read │   │
│ │ inst_    │      │ wbf_cmd  │           │ _resp_   │   │
│ │ decoder  │      │          │           │ ctrl     │   │
│ └──────────┘      └──────────┘           └──────────┘   │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

### 1.3 设计特点

| 特点 | 说明 |
|------|------|
| **8 路并行** | 支持 8 个 plane_pair 同时处理 |
| **Group 独立** | Group 0 (PP[0:3]) 和 Group 1 (PP[4:7]) 独立处理 |
| **双模式** | Fast Read (快速) 和 Safe Read (安全) |
| **OFFWBF 协作** | Safe Read 模式下可调用 OFFWBF 二次译码 |
| **优先级仲裁** | 5 种命令源按固定优先级仲裁 |

---

## 2. 接口信号完整说明

### 2.1 时钟与复位

| 信号 | 位宽 | 方向 | 说明 |
|------|------|------|------|
| `clk` | 1 | Input | 系统时钟 |
| `rst_n` | 1 | Input | 异步复位 (低有效) |

### 2.2 配置接口 (CFG)

| 信号 | 位宽 | 方向 | 说明 |
|------|------|------|------|
| `io_fast_read_err_report` | 1 | Input | Fast Read 错误上报使能 |
| `cfg_error_flag` | 32 | Input | 配置错误标志 |
| `cfg_error_flag_mask` | 32 | Input | 错误标志掩码 |
| `cfg_lba_mask` | 32 | Input | LBA 比较掩码 |
| `fifo_clr` | 1 | Input | FIFO 清零 |
| `io_fast_read_err_dis` | 1 | Input | Fast Read 错误禁用 |
| `error_flag_position` | 2 | Input | 错误标志位置 |
| `lba_position` | 2 | Input | LBA 位置 |
| `meta_data_base_addr` | 32 | Input | Meta 数据基地址 |
| `off_wbf_fail_base_addr` | 32 | Input | OFFWBF 失败基地址 |

### 2.3 在线译码命令输入 (ONDEC[7:0])

**每组 4 个信号，共 8 组 (32 个信号)**:

| 信号 | 位宽 | 方向 | 说明 |
|------|------|------|------|
| `on_dec[i]_cmd_vld` | 1 | Input | 命令有效 (i=0~7) |
| `on_dec[i]_cmd_rdy` | 1 | Output | 命令就绪 (反压) |
| `on_dec[i]_cmd` | 32 | Input | 命令数据 (32bit × 12) |
| `on_dec[i]_dat_done` | 1 | Input | 数据完成标志 |

**命令结构** (32bit × 12 = 384bit):

```
Index 0  (32bit): [31:30]rsv0, [29]discard_read_data, [28:24]rsv0, [23:16]nand_index, [15:0]instruction_index
Index 1  (32bit): [31]rsv1, [30]off_wbf_err_output_en, [29]deep_read_data_discard, 
                  [28:24]nsu_ost_id, [23]deep_read_status_sel, [22]crc_pass, 
                  [21]program_verify_read, [20]read_mode, [19:18]response_sel_que,
                  [17:16]meta_mode, [15]deep_read_sel, [14]write_pos_jdg,
                  [13]error_flag, [12]plane_sel, [11]dec_suc, 
                  [10:2]decode_correct_bit_num, [1]plane1_empty, [0]plane0_empty
Index 2  (32bit): [31:16]plane1_bit_cnt, [15:0]plane0_bit_cnt
Index 3  (32bit): meta_buffer_id
Index 4  (32bit): dest_memory_addr
Index 5  (32bit): dec_fail_dest_addr
Index 6  (32bit): [31:16]plane_group_block_addr, [15:12]rsv6, [11:0]page_addr_plane_group
Index 7-10 (32bit): meta_data_0 ~ meta_data_3
Index 11 (32bit): [31:21]rsv11, [20]data_out_en, [19]offline_wbf_work_en,
                  [18]flip_threshold_sel, [17]syn_weight_over_threshold,
                  [16:1]descramble_seed, [0]descramble_en
```

### 2.4 Read Response 队列接口

| 信号 | 位宽 | 方向 | 说明 |
|------|------|------|------|
| `read_resp_que[3:0]_ready` | 1 | Input | 队列就绪 (4 个队列) |
| `read_resp_que_wcen` | 1 | Output | 写使能 |
| `read_resp_que_waddr` | 7 | Output | 写地址 |
| `read_resp_que_din` | 32 | Output | 写数据 |
| `read_resp_que[3:0]_wcen` | 1 | Output | 各队列写使能 |
| `read_resp_que[3:0]_start_addr` | 7 | Input | 各队列起始地址 |
| `read_resp_que[3:0]_len` | 8 | Input | 各队列长度 |
| `act_read_resp_que[3:0]_len` | 7 | Input | 各队列实际长度 |

**Read Response 格式** (32bit):
```
[31:24] error_plane_pair_sel (错误 plane_pair 选择，取反)
[23:16] nand_index           (NAND 索引)
[15:0]  instruction_index    (指令索引)
```

### 2.5 Deep Response 接口

| 信号 | 位宽 | 方向 | 说明 |
|------|------|------|------|
| `deep_read_que_ready` | 1 | Input | Deep Read 队列就绪 |
| `deep_read_que_wren` | 1 | Output | Deep Read 队列写使能 |
| `deep_read_sram_wren` | 1 | Output | Deep Read SRAM 写使能 |
| `deep_read_sram_wdat` | 32 | Output | Deep Read SRAM 写数据 |
| `deep_read_sram_waddr` | 12 | Output | Deep Read SRAM 写地址 |

**Deep Response 格式** (28 × 32bit = 896bit):

| Index | 字段 | 说明 |
|-------|------|------|
| 0 | `{plane_sel, nand_index, inst_index}` | 基本信息 |
| 1 | `{8'd0, ~comp_err_flag, ~comp_lba, ~plane_pair_err}` | 错误状态 |
| 2 | `{deep_read_sel, fast_safe_flag, 2'd0, page_addr[1:0]}` | 页地址 |
| 3 | `{group1_blk_addr, group0_blk_addr}` | 块地址 |
| 4-7 | `group0_meta_id`, `group1_meta_id`, `group0_dest_addr`, `group1_dest_addr` | 地址信息 |
| 8-15 | `fail_addr[0:7]` | 8 个失败地址 |
| 16 | `{group1_ost_id, correct_num[1], plane_empty[1], group0_ost_id, ...}` | OST ID 和纠错数 |
| 17-27 | `plane_set_bit[0:7]` | Plane 纠错 bit 数 |

### 2.6 MSA 接口

| 信号 | 位宽 | 方向 | 说明 |
|------|------|------|------|
| `msa_cmd_vld` | 1 | Input | MSA 命令有效 |
| `msa_cmd_rdy` | 1 | Output | MSA 命令就绪 |
| `msa_cmd` | 32 | Input | MSA 命令数据 |
| `msa_resp_que_full` | 1 | Input | MSA 响应队列满 |
| `msa_resp_que_wren` | 1 | Output | MSA 响应队列写使能 |
| `msa_resp_sram_rden` | 1 | Input | MSA SRAM 读使能 |
| `msa_resp_sram_raddr` | 3 | Input | MSA SRAM 读地址 |
| `msa_resp_sram_rdat` | 16 | Output | MSA SRAM 读数据 |
| `msa_resp_sram_rdat_vld` | 1 | Output | MSA SRAM 读数据有效 |
| `msa_write_done` | 1 | Input | MSA 写完成 |

### 2.7 UNMAP 接口

| 信号 | 位宽 | 方向 | 说明 |
|------|------|------|------|
| `hw_unmap_vld` | 1 | Input | 硬件 UNMAP 有效 |
| `hw_unmap_rdy` | 1 | Output | 硬件 UNMAP 就绪 |
| `hw_unmap_cmd` | 45 | Input | 硬件 UNMAP 命令 |
| `sw_unmap_vld` | 1 | Input | 软件 UNMAP 有效 |
| `sw_unmap_rdy` | 1 | Output | 软件 UNMAP 就绪 |
| `sw_unmap_cmd` | 32 | Input | 软件 UNMAP 命令 |
| `unmap_write_done` | 8 | Input | UNMAP 写完成 (8 路) |
| `unmap_read_sel` | 8 | Output | UNMAP 读选择 (8 路) |

### 2.8 OFFWBF 接口

| 信号 | 位宽 | 方向 | 说明 |
|------|------|------|------|
| `offline_wbf_cmd_vld` | 1 | Input | OFFWBF 命令有效 |
| `offline_wbf_cmd_rdy` | 1 | Output | OFFWBF 命令就绪 |
| `offline_wbf_cmd` | 64 | Input | OFFWBF 命令数据 |
| `grant` | 5 | Input | 仲裁结果 |
| `tx_off_wbf_vld` | 1 | Output | 发送 OFFWBF 有效 |
| `tx_off_wbf_rdy` | 1 | Input | 发送 OFFWBF 就绪 |
| `tx_off_wbf_dat` | 64 | Output | 发送 OFFWBF 数据 |
| `off_wbf_write_done` | 1 | Input | OFFWBF 写完成 |
| `off_wbf_dat_addr` | 32 | Output | OFFWBF 数据地址 |
| `off_wbf_addr_vld` | 8 | Output | OFFWBF 地址有效 (8 路) |
| `off_wbf_pp_vld` | 8 | Output | OFFWBF plane_pair 有效 |

### 2.9 AXI Master 接口 (写通道)

| 信号 | 位宽 | 方向 | 说明 |
|------|------|------|------|
| `lm_wreq` | 1 | Output | 写请求 |
| `lm_wack` | 1 | Input | 写确认 |
| `lm_wid` | 10 | Output | 写 ID |
| `lm_wlen` | 9 | Output | 写长度 (BLEN) |
| `lm_waddr` | 34 | Output | 写地址 |
| `lm_wvld` | 1 | Output | 写有效 |
| `lm_wrdy` | 1 | Input | 写就绪 |
| `lm_wdat` | 256 | Output | 写数据 |
| `lm_wdat_last` | 1 | Output | 写最后 beat |
| `lm_wmask` | 32 | Output | 写掩码 (STRB) |
| `lm_wdone_id` | 10 | Input | 写完成 ID |
| `lm_wdone_id_vld` | 1 | Input | 写完成 ID 有效 |

### 2.10 TSU/MSG 接口

| 信号 | 位宽 | 方向 | 说明 |
|------|------|------|------|
| `nsu_get_msg_vld` | 1 | Output | NSU 获取消息有效 |
| `nsu_plane_sel` | 1 | Output | NSU plane 选择 |
| `nsu_rd_ost_id` | 5 | Output | NSU 读 OST ID |
| `nsu_rd_ost_id_vld` | 1 | Output | NSU 读 OST ID 有效 |
| `nsu_rd_lba` | 30 | Output | NSU 读 LBA |
| `tsu_nsu_err_msg` | 32 | Output | TSU-NSU 错误消息 |
| `tsu_req_ost_id` | 8 | Input | TSU 请求 OST ID |
| `nsu_info_vld` | 1 | Output | NSU 信息有效 |
| `nsu_info` | 17 | Output | NSU 信息数据 |
| `nsu_info_rdy` | 1 | Input | NSU 信息就绪 |
| `cmd_arb_done` | 1 | Output | 命令仲裁完成 |

### 2.11 统计输出

| 信号 | 位宽 | 方向 | 说明 |
|------|------|------|------|
| `online_dec_fast_fail_stat` | 32 | Output | Fast Read 失败计数 |
| `online_dec_fast_pass_stat` | 32 | Output | Fast Read 成功计数 |
| `online_dec_safe_fail_stat` | 32 | Output | Safe Read 失败计数 |
| `online_dec_safe_pass_stat` | 32 | Output | Safe Read 成功计数 |

---

## 3. 内部状态机分析

### 3.1 状态定义

```systemverilog
localparam IDLE_STATE   = 4'd0;   // 空闲状态
localparam ONLIE_STATE  = 4'd1;   // 在线命令处理 (图片原拼写)
localparam FAST_STATE   = 4'd2;   // Fast Read 模式
localparam RESP_STATE   = 4'd3;   // 响应写入
localparam SAFE_STATE   = 4'd4;   // Safe Read 模式
localparam TX_WBF_STATE = 4'd5;   // 发送 OFFWBF
localparam RX_WBF_STATE = 4'd6;   // 接收 OFFWBF 结果
localparam UNMAP_STATE  = 4'd7;   // UNMAP 处理
localparam MSA_STATE    = 4'd9;   // MSA 处理
localparam DONE_STATE   = 4'd10;  // 完成状态
```

### 3.2 状态转移图

```
                                    ┌─────────────┐
                                    │   IDLE      │
                                    │   (d0)      │
                                    └──────┬──────┘
                                           │
                    ┌──────────────────────┼──────────────────────┐
                    │                      │                      │
            grant=5'b0_0001        grant=5'b0_0010        grant=5'b0_0100
            (在线命令)              (OFFWBF)              (MSA)
                    │                      │                      │
                    ▼                      ▼                      ▼
            ┌─────────────┐        ┌─────────────┐        ┌─────────────┐
            │   ONLIE     │        │   RX_WBF    │        │    MSA      │
            │   (d1)      │        │   (d6)      │        │    (d9)     │
            └──────┬──────┘        └──────┬──────┘        └──────┬──────┘
                   │                      │                      │
         ┌─────────┴─────────┐            │                      │
         │                   │            │                      ▼
    prg_verify=1      fast_safe_flag    │              msa_resp_que_wren
    (Program Verify)         │          │                      │
         │                   │          │                      ▼
         ▼                   ▼          ▼              ┌─────────────┐
    ┌─────────────┐    ┌─────────────┐          ┌─────────────┐
    │   DONE      │    │   FAST      │          │   DONE      │
    │   (d10)     │    │   (d2)      │          │   (d10)     │
    └──────┬──────┘    └──────┬──────┘          └──────┬──────┘
           │                  │                        │
           │                  │                        │
           ▼                  ▼                        ▼
    ┌─────────────┐    ┌─────────────┐          ┌─────────────┐
    │   IDLE      │    │   RESP      │          │   IDLE      │
    │   (d0)      │    │   (d3)      │          │   (d0)      │
    └─────────────┘    └──────┬──────┘          └─────────────┘
                              │
                              │
                              ▼
                       ┌─────────────┐
                       │   DONE      │
                       │   (d10)     │
                       └──────┬──────┘
                              │
                              ▼
                       ┌─────────────┐
                       │   IDLE      │
                       │   (d0)      │
                       └─────────────┘

ONLIE 状态详细转移:
┌─────────────┐
│   ONLIE     │
│   (d1)      │
└──────┬──────┘
       │
       │ prg_verify=1
       ▼
┌─────────────┐         fast_safe_flag=0         ┌─────────────┐
│   DONE      │◄─────────────────────────────────│   SAFE      │
│   (d10)     │                                  │   (d4)      │
└─────────────┘                                  └──────┬──────┘
       ▲                                                │
       │                                                │ |off_wbf_work_en|
       │                                                ▼
       │                                         ┌─────────────┐
       │                                         │   TX_WBF    │
       │                                         │   (d5)      │
       │                                         └──────┬──────┘
       │                                                │
       │                  online_wr_dat_done=1          │
       │                  tx_off_wbf_cmd_busy=0         │
       │                                                ▼
       │                                         ┌─────────────┐
       └─────────────────────────────────────────│   DONE      │
                     complete=1                   │   (d10)     │
                     mux_ping_pong_rdy=1          └─────────────┘
```

### 3.3 状态转移条件

| 当前状态 | 下一状态 | 条件 |
|---------|---------|------|
| IDLE | ONLIE | `grant == 5'b0_0001` (在线命令) |
| IDLE | RX_WBF | `grant == 5'b0_0010` (OFFWBF) |
| IDLE | MSA | `grant == 5'b0_0100` (MSA) |
| IDLE | UNMAP | `grant == 5'b0_1000` 或 `5'b1_0000` |
| ONLIE | DONE | `prg_verify == 1` |
| ONLIE | SAFE | `fast_safe_flag == 0` |
| ONLIE | FAST | `fast_safe_flag == 1` |
| FAST | RESP | 无条件 |
| SAFE | TX_WBF | `\|off_wbf_work_en == 1` |
| SAFE | RESP | `\|off_wbf_work_en == 0` |
| RESP | DONE | `read_resp_que_busy=0 & deep_resp_que_busy=0 & meta_data_busy=0 & wr_dat_done=1` |
| TX_WBF | DONE | `online_wr_dat_done=1 & tx_off_wbf_cmd_busy=0` |
| RX_WBF | RESP | 无条件 |
| UNMAP | DONE | `unmap_busy == 8'b0` |
| MSA | DONE | `msa_resp_que_wren` |
| DONE | IDLE | `complete & mux_ping_pong_rdy` |

### 3.4 cmd_sel 控制

```systemverilog
always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        cmd_sel <= 3'd0;
    else if(state_done)
        cmd_sel <= 3'd0;
    else if(cur_state == IDLE_STATE & nxt_state == ONLIE_STATE)
        cmd_sel <= 3'd1;      // 在线命令
    else if(cur_state == IDLE_STATE & nxt_state == RX_WBF_STATE)
        cmd_sel <= 3'd2;      // OFFWBF
    else if(cur_state == IDLE_STATE & nxt_state == MSA_STATE)
        cmd_sel <= 3'd3;      // MSA
    else if(cur_state == IDLE_STATE & nxt_state == UNMAP_STATE)
        cmd_sel <= 3'd4;      // UNMAP
end
```

**cmd_sel 用途**: 标识当前处理的命令类型，用于数据路径选择。

---

## 4. 命令处理流程

### 4.1 完整处理流程 (8 步)

```
┌─────────────────────────────────────────────────────────────────┐
│ Step 1: 命令接收                                                  │
│ ─────────────────────────────────────────────────────────────── │
│ - 8 路 on_dec_cmd 输入                                           │
│ - 存入 dec_fifo (深度 24, 384bit 输出)                           │
│ - 每路独立 FIFO，支持并发存储                                     │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│ Step 2: 命令仲裁                                                  │
│ ─────────────────────────────────────────────────────────────── │
│ - 5 路请求：在线 > OFFWBF > MSA > HW_UNMAP > SW_UNMAP           │
│ - 外部 arbiter 返回 grant[4:0]                                  │
│ - 选中命令的 FIFO 输出使能                                        │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│ Step 3: 指令解码                                                  │
│ ─────────────────────────────────────────────────────────────── │
│ - nsu_rd_inst_decoder 解析 384bit 命令字                         │
│ - 提取字段：plane_sel, ost_id, read_mode, dest_addr 等          │
│ - 输出 8 路并行控制信号                                           │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│ Step 4: 模式判断                                                  │
│ ─────────────────────────────────────────────────────────────── │
│ - Fast Read: fast_safe_flag=1, 译码成功 → 直接响应              │
│ - Safe Read: fast_safe_flag=0, 译码失败 → OFFWBF 处理           │
│ - Program Verify: prg_verify=1 → 直接完成                       │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│ Step 5: 数据分流                                                  │
│ ─────────────────────────────────────────────────────────────── │
│ - dest_sel=0: 数据从 NAND 读取 (IO Read)                        │
│ - dest_sel=1: 数据写入 Share Memory (响应)                       │
│ - off_wbf_work_en=1: 发送 OFFWBF 处理                           │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│ Step 6: OFFWBF 处理 (如需要)                                      │
│ ─────────────────────────────────────────────────────────────── │
│ - TX_WBF_STATE: 发送 64bit 命令给 OFFWBF                         │
│ - OFFWBF 执行二次译码                                            │
│ - RX_WBF_STATE: 接收 OFFWBF 返回结果                             │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│ Step 7: 响应写入                                                  │
│ ─────────────────────────────────────────────────────────────── │
│ - Read Response: 32bit, 写入 4 个响应队列之一                    │
│ - Deep Response: 896bit (28×32), 写入 Deep Read SRAM            │
│ - MSA Response: 16bit, 写入 MSA 响应队列                         │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│ Step 8: 完成上报                                                  │
│ ─────────────────────────────────────────────────────────────── │
│ - nsu_info: 17bit, 包含 ost_id 和完成数量                        │
│ - 通过 ping_pong 机制上报 TSU                                    │
│ - 状态返回 IDLE，等待下一命令                                     │
└─────────────────────────────────────────────────────────────────┘
```

### 4.2 Fast Read 路径

```
IDLE → ONLIE → FAST → RESP → DONE → IDLE
              │
              │ fast_safe_flag=1
              │
              ▼
         ┌─────────┐
         │ 译码成功 │ → Read Response (32bit)
         │ dec_status=1 │
         └─────────┘
```

**特点**:
- 处理速度快
- 只生成 Read Response
- 不调用 OFFWBF
- 适用于高吞吐场景

### 4.3 Safe Read 路径 (无需 OFFWBF)

```
IDLE → ONLIE → SAFE → RESP → DONE → IDLE
              │
              │ fast_safe_flag=0
              │ off_wbf_work_en=0
              ▼
         ┌─────────┐
         │ 译码成功 │ → Read Response (32bit)
         │ dec_status=1 │
         └─────────┘
```

**特点**:
- 译码检查更严格
- 生成 Read Response 或 Deep Response
- 适用于数据完整性要求高的场景

### 4.4 Safe Read 路径 (需要 OFFWBF)

```
IDLE → ONLIE → SAFE → TX_WBF → DONE → IDLE
              │         │
              │         │ 发送命令
              │         ▼
              │    ┌─────────┐
              │    │  OFFWBF │
              │    │ 二次译码 │
              │    └─────────┘
              │         │
              │         │ 返回结果
              ▼         ▼
         ┌─────────────────┐
         │ 译码失败+CRC 成功 │ → Deep Response (896bit)
         │ dec_suc=0, crc=1 │
         └─────────────────┘
```

**特点**:
- 译码失败时调用 OFFWBF
- OFFWBF 执行更强的纠错
- 生成 Deep Response 包含详细状态

### 4.5 MSA 路径

```
IDLE → MSA → DONE → IDLE
         │
         │ msa_cmd_vld=1
         ▼
    ┌─────────┐
    │ MSA 处理 │ → MSA Response (16bit)
    └─────────┘
```

**特点**:
- 独立于 Read 路径
- 处理 Meta 数据访问
- 响应格式简单

### 4.6 UNMAP 路径

```
IDLE → UNMAP → DONE → IDLE
         │
         │ hw_unmap_vld 或 sw_unmap_vld
         ▼
    ┌─────────┐
    │ UNMAP 处理│ → 无响应 (仅完成标志)
    └─────────┘
```

**特点**:
- 硬件/软件两种 UNMAP
- 处理 8 路 plane_pair
- 无需响应写入

---

## 5. 数据路径详解

### 5.1 命令数据流

```
                    ┌──────────────────────────────────────┐
                    │         Input FIFO Array             │
                    │  ┌────┐ ┌────┐ ┌────┐ ┌────┐        │
on_dec0_cmd ───────►│  │FIFO│ │FIFO│ │FIFO│ │FIFO│ ...    │
on_dec1_cmd ───────►│  │ 0  │ │ 1  │ │ 2  │ │ 3  │        │
  ...               │  └────┘ └────┘ └────┘ └────┘        │
on_dec7_cmd ───────►│    │      │      │      │           │
                    │    └──────┴──────┴──────┴───────────│
                    │              │                       │
                    │         dec_fifo_rdat               │
                    │         (384bit = 12×32)            │
                    └──────────────┼──────────────────────┘
                                   │
                                   ▼
                    ┌──────────────────────────────────────┐
                    │      nsu_rd_inst_decoder             │
                    │  - 解析 plane_sel[7:0]               │
                    │  - 解析 group0_ost_id, group1_ost_id │
                    │  - 解析 dest_addr[7:0]               │
                    │  - 解析 fail_addr[7:0]               │
                    │  - 解析 dat_out_en[7:0]              │
                    │  - 解析 off_wbf_work_en[7:0]         │
                    └──────────────┬───────────────────────┘
                                   │
                                   ▼
                    ┌──────────────────────────────────────┐
                    │         State Machine                │
                    │  根据 read_mode 和 dec_status 分流   │
                    └──────────────┬───────────────────────┘
                                   │
           ┌───────────────────────┼───────────────────────┐
           │                       │                       │
           ▼                       ▼                       ▼
    ┌─────────────┐        ┌─────────────┐        ┌─────────────┐
    │  Read Resp  │        │  Deep Resp  │        │  OFFWBF     │
    │  (32bit)    │        │  (896bit)   │        │  (64bit)    │
    └─────────────┘        └─────────────┘        └─────────────┘
```

### 5.2 LBA 计算逻辑

```systemverilog
// 根据 meta_id 计算 8 个 plane_pair 的实际 LBA
always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        act_lba[0] <= 'd0;
        // ...
    end
    else if(lba_compute_en[0]) begin
        act_lba[0] <= group0_meta_id;           // PP0
        act_lba[1] <= group0_meta_id + 1;       // PP1
        act_lba[2] <= group0_meta_id + 2;       // PP2
        act_lba[3] <= group0_meta_id + 3;       // PP3
        act_lba[4] <= group1_meta_id;           // PP4
        act_lba[5] <= group1_meta_id + 1;       // PP5
        act_lba[6] <= group1_meta_id + 2;       // PP6
        act_lba[7] <= group1_meta_id + 3;       // PP7
    end
end
```

**说明**:
- Group 0: PP[0:3] 使用 `group0_meta_id` 基地址
- Group 1: PP[4:7] 使用 `group1_meta_id` 基地址
- 每个 group 内 4 个 plane_pair 地址连续

### 5.3 错误比较逻辑

```systemverilog
// LBA 比较
assign comp_lba[i] = (meta_mode == 2'b01 & plane_sel[i]) ? 
    ((nand_lba[i] | cfg_lba_mask) == (act_lba[i] | cfg_lba_mask)) : 1'b1;

// 错误标志比较
assign comp_err_bit[i][j] = (meta_mode == 2'b01 & plane_sel[i]) ? 
    ((cfg_error_flag[j] | cfg_error_flag_mask[j]) == 
     (nand_error_flag[i][j] | cfg_error_flag_mask[j])) : 1'b1;

assign comp_err_flag[i] = &comp_err_bit[i];  // 所有 bit 都匹配

// 最终错误标志
assign err_report[i] = (!err_report[i] & comp_lba[i] & dec_status[i]) == 1'b0;
```

**说明**:
- `meta_mode=2'b01`: 需要 LBA 和错误标志比较
- `cfg_lba_mask` / `cfg_error_flag_mask`: 掩码用于忽略某些 bit
- `comp_err_flag`: 所有 error bit 都匹配才为 1

### 5.4 data_out_en 生成

```systemverilog
// 根据译码状态和模式决定 data_out_en
constraint c_data_out_en {
    // CRC 成功 + 译码成功 → 数据输出使能
    (plane_sel == 1'b1 && crc_pass == 1'b1 && dec_suc==1'b1) -> (data_out_en == 1'b1);
    
    // Program verify read → 数据输出使能
    (plane_sel == 1'b1 && program_verify_read == 1'b1) -> (data_out_en == 1'b1);
    
    // Fast read → 数据输出使能
    (plane_sel == 1'b1 && read_mode == 1'b1) -> (data_out_en == 1'b1);
    
    // offline_wbf_work_en=1 → data_out_en=1
    (plane_sel == 1'b1 && offline_wbf_work_en == 1'b1) -> (data_out_en == 1'b1);
    
    // plane_sel=0 → data_out_en=0
    (plane_sel == 1'b0) -> (data_out_en == 1'b0);
    
    // data_out_en=0 → offline_wbf_work_en=0
    (data_out_en==1'b0) -> (offline_wbf_work_en==1'b0);
}
```

### 5.5 done_occur 逻辑

```systemverilog
constraint c_done_occur {
    if (plane_sel == 0) {
        done_occur == 0;
    } else if (data_out_en == 0) {
        done_occur == 0;
    } else if (write_pos_jdg == 1) {  // data_out_en=1, write_pos_jdg=1 → to sharemem
        done_occur == 1;
    } else if (offline_wbf_work_en == 1) {  // data_out_en=1, offline_wbf_work_en=1 → to sharemem
        done_occur == 1;
    } else {
        done_occur == 0;
    }
}
```

**说明**: done_occur 在以下情况为 1:
- `plane_sel=1` 且 `data_out_en=1` 且 (`write_pos_jdg=1` 或 `offline_wbf_work_en=1`)

### 5.6 plane_pair_wdone 判断

```systemverilog
assign plane_pair_wdone[i] = (dat_out_en[i] & cmd_sel == 3'd1) ? 
    (!on_dec_done_empty[i]) : 1'b1;

assign on_dec_done_rden[i] = state_done & dat_out_en[i] & cmd_sel == 3'd1;
```

**说明**:
- 在线命令模式下，需要等待 `on_dec_dat_done`
- 其他模式下，plane_pair 自动完成

---

## 6. 关键子模块分析

### 6.1 nsu_rd_inst_decoder (指令解码器)

**功能**: 解析 384bit 命令字，提取控制字段

**输入**:
- `dec_fifo_rdat[383:0]`: 8 路命令拼接 (每路 32bit × 12)

**输出**:
- `plane_sel[7:0]`: 8 个 plane_pair 选择
- `dec_status[7:0]`: 8 个译码状态
- `group0_ost_id[4:0]`, `group1_ost_id[4:0]`: Group OST ID
- `dest_addr[7:0][31:0]`: 8 个目标地址
- `fail_addr[7:0][31:0]`: 8 个失败地址
- `dat_out_en[7:0]`: 8 个数据输出使能
- `off_wbf_work_en[7:0]`: 8 个 OFFWBF 使能
- ... (共 50+ 输出信号)

**解码逻辑**:
```systemverilog
// Index 0 解析
assign inst_index = dec_fifo_rdat[15:0];
assign nand_index = dec_fifo_rdat[23:16];

// Index 1 解析 (按 plane_pair 分离)
assign group0_ost_id = dec_fifo_rdat[60:56];  // PP0 的 ost_id
assign group1_ost_id = dec_fifo_rdat[60+32:56+32];  // PP4 的 ost_id
assign fast_safe_flag = dec_fifo_rdat[20];  // read_mode
assign deep_read_sel = dec_fifo_rdat[15];

// Index 4-5 解析
assign group0_dest_addr = dec_fifo_rdat[159:128];  // dest_memory_addr
assign group0_fail_addr = dec_fifo_rdat[191:160];  // dec_fail_dest_addr
```

### 6.2 nsu_tx_wbf_cmd (OFFWBF 命令发送)

**功能**: 生成发送给 OFFWBF 的 64bit 命令

**输入**:
- `tx_off_wbf_cmd_start`: 发送启动信号
- `group0_ost_id`, `group1_ost_id`: OST ID
- `group0_dest_addr`, `group1_dest_addr`: 源地址
- `fail_addr[7:0]`: 目标地址
- `plane_sel[7:0]`, `dec_status[7:0]`: plane 状态

**输出**:
- `tx_off_wbf_vld`: 命令有效
- `tx_off_wbf_dat[63:0]`: 命令数据

**命令格式** (64bit):
```
[63:32] meta_data 或地址信息
[31:27] ost_id
[26:24] plane_num
[23:0]  控制字段 (dest_sel, flip_threshold_sel, seed 等)
```

### 6.3 nsu_read_resp_ctrl (Read 响应控制)

**功能**: 控制 Read Response 写入 4 个响应队列

**输入**:
- `start`: 写启动
- `resp_sel_que[1:0]`: 响应队列选择
- `read_resp_que_status[31:0]`: 响应数据
- `read_que[3:0]_ready`: 队列就绪

**输出**:
- `read_resp_que_wcen`: 写使能
- `read_resp_que_waddr[6:0]`: 写地址
- `read_resp_que_din[31:0]`: 写数据
- `read_resp_que[3:0]_wcen`: 各队列写使能

**响应数据格式**:
```
[31:24] ~err_plane_pair  (错误 plane_pair 选择，取反)
[23:16] nand_index       (NAND 索引)
[15:0]  inst_index       (指令索引)
```

### 6.4 nsu_write_meta_ctrl (Meta 数据写控制)

**功能**: 通过 AXI Master 接口写入 Meta 数据

**输入**:
- `start`: 写启动
- `meta0_addr`, `meta1_addr`: Meta 地址
- `plane_sel[7:0]`: plane 选择
- `meta_data[3:0][31:0]`: Meta 数据

**输出** (AXI 写通道):
- `lm_wreq`, `lm_wack`: 写请求/确认
- `lm_wid[9:0]`: 写 ID
- `lm_wlen[8:0]`: 写长度
- `lm_waddr[33:0]`: 写地址
- `lm_wdat[255:0]`: 写数据
- `lm_wmask[31:0]`: 写掩码

### 6.5 nsu_fifo_conv_width (FIFO 位宽转换)

**功能**: 实现不同位宽之间的 FIFO 转换

**参数**:
- `IN_WIDTH`: 输入位宽
- `OUT_WIDTH`: 输出位宽
- `FIFO_DEPTH`: FIFO 深度
- `COMMON_DIVISOR`: 公约数 (用于计算深度)

**实例**:
```systemverilog
// OFFWBF 命令 FIFO (64bit → 2560bit)
nsu_fifo_conv_width #(
    .COMMON_DIVISOR(64),
    .IN_WIDTH(64),
    .OUT_WIDTH(2560),
    .FIFO_DEPTH(40)
) u_offline_wbf_cmd_resize_fifo(...);

// MSA 命令 FIFO (32bit → 128bit)
nsu_fifo_conv_width #(
    .COMMON_DIVISOR(32),
    .IN_WIDTH(32),
    .OUT_WIDTH(128),
    .FIFO_DEPTH(4)
) u_msa_cmd_resize_fifo(...);
```

---

## 7. 时序关系

### 7.1 命令接收时序

```
Cycle:  1    2    3    4    5    6    7    8
        │    │    │    │    │    │    │    │
on_dec_cmd_vld ─┐    ┌─────────────────────────
                │    │
on_dec_cmd_rdy ─┴────┘
                │    │
on_dec_cmd  ────CMD0───CMD1───CMD2─── ...
                │    │    │    │
dec_fifo_wen ───┼────┼────┼────┼────
                │    │    │    │
dec_full   ─────┴────┴────┴────┴──── (FIFO 满时拉低 rdy)
```

### 7.2 仲裁时序

```
Cycle:  1    2    3    4    5    6
        │    │    │    │    │    │
req_cmd_vld[0] ─┐    ┌─────────────  (在线命令)
                │    │
req_cmd_vld[1] ─┴────┘                (OFFWBF)
                │    │
grant      ──────ARB0───ARB1─────────
                │    │
dec_fifo_ren ───┼────┘                (选中时读 FIFO)
```

### 7.3 状态机时序

```
Cycle:  1    2    3    4    5    6    7    8    9    10
        │    │    │    │    │    │    │    │    │    │
cur_state  IDLE  ONLIE FAST  RESP  DONE  IDLE
        │    │    │    │    │    │    │
nxt_state  ONLIE FAST  RESP  DONE  IDLE
        │    │    │    │    │
grant    ARB0
        │
cmd_sel     1
        │    │    │    │
fast_safe     1
        │    │    │
dest_sel        1
```

### 7.4 OFFWBF 交互时序

```
Cycle:  1    2    3    4    5    6    7    8    9    10
        │    │    │    │    │    │    │    │    │    │
cur_state  SAFE  TX_WBF            RX_WBF  RESP  DONE
        │    │    │    │    │    │    │    │
tx_off_wbf_vld ─┐    │    │    │    │
                │    │    │    │    │
tx_off_wbf_rdy ─┴────┘    │    │    │
        │    │    │    │    │    │
offwbf_cmd_vld ──────────┐    │    │
                │    │    │    │    │
offwbf_cmd_rdy ──────────┴────┘    │
        │    │    │    │    │    │
off_wbf_write_done ───────────────┘
```

### 7.5 响应写入时序

```
Cycle:  1    2    3    4    5    6
        │    │    │    │    │    │
read_resp_wr_start ─┐    │    │    │
                    │    │    │    │
read_resp_que_busy ─┴────┼────┼────┘
                    │    │    │
read_resp_wren   ────┼────┼────┘
                    │    │
read_resp_que_wcen ──┴────┘
                    │
read_resp_que_waddr ─────ADDR
                    │
read_resp_que_din ───────DATA
```

### 7.6 Ping-Pong 上报时序

```
Cycle:  1    2    3    4    5    6    7    8
        │    │    │    │    │    │    │    │
ping_pong_vld ─┐    │    │    │    │    │
               │    │    │    │    │    │
nsu_info_vld ──┴────┼────┼────┼────┼────┘
               │    │    │    │    │
nsu_info_rdy ──┴────┼────┼────┼────┘
               │    │    │    │
ping_pong_flag ─────┴────┴────┴──── (翻转)
```

---

## 8. 与验证组件的映射

### 8.1 Transaction 类映射

| RTL 信号 | UVM Transaction 字段 | 说明 |
|---------|---------------------|------|
| `on_dec[i]_cmd[31:0]` | `on_dec_cmd[11:0]` | 12 个 32bit 命令字 |
| `inst_index[15:0]` | `instruction_index` | 指令索引 |
| `nand_index[7:0]` | `nand_index` | NAND 索引 |
| `group0_ost_id[4:0]` | `nsu_ost_id` (Group 0) | Group 0 OST ID |
| `group1_ost_id[4:0]` | `nsu_ost_id` (Group 1) | Group 1 OST ID |
| `fast_safe_flag` | `read_mode` | Fast(1)/Safe(0) |
| `deep_read_sel` | `deep_read_sel` | Deep Read 选择 |
| `dest_addr[i][31:0]` | `dest_memory_addr` | 目标内存地址 |
| `fail_addr[i][31:0]` | `dec_fail_dest_addr` | 译码失败地址 |
| `plane_sel[7:0]` | `plane_sel` | Plane 选择 |
| `dec_status[7:0]` | `dec_suc` | 译码状态 |
| `dat_out_en[7:0]` | `data_out_en` | 数据输出使能 |
| `off_wbf_work_en[7:0]` | `offline_wbf_work_en` | OFFWBF 使能 |

### 8.2 响应 Transaction 映射

#### Read Response (32bit)

| RTL 信号 | UVM Transaction 字段 |
|---------|---------------------|
| `read_resp_que_din[31:24]` | `error_plane_pair_sel` |
| `read_resp_que_din[23:16]` | `nand_index` |
| `read_resp_que_din[15:0]` | `instruction_index` |

对应 `nsu2cpu_resp_transaction` 或 `nsu2cpu_rcmd_transaction`。

#### Deep Response (28×32bit)

| RTL 信号 | UVM Transaction 字段 |
|---------|---------------------|
| `deep_read_status[0]` | `plane_sel`, `nand_index`, `instruction_index` |
| `deep_read_status[1]` | `plane_crc_err`, `plane_pair_lba_comp`, `plane_pair_err_flag_comp` |
| `deep_read_status[2]` | `deep_read_sel`, `read_mode`, `page_address` |
| `deep_read_status[3]` | `group0_block_addr`, `group1_block_addr` |
| `deep_read_status[4-7]` | `group0_meta_addr`, `group1_meta_addr`, `dest_memory_addr` |
| `deep_read_status[8-15]` | `dec_fail_dest_addr[0:7]` |
| `deep_read_status[16]` | `group0_ost_id`, `group1_ost_id`, `correct_num` |
| `deep_read_status[17-27]` | `plane_set_bit[0:7]` |

对应 `nsu2cpu_deep_resp_transaction`。

### 8.3 Checker 检查点映射

| RTL 状态 | Checker 检查点 | 检查内容 |
|---------|---------------|---------|
| FAST_STATE | `check_read_resp()` | Read Response 格式 |
| SAFE_STATE | `check_ondec_cmd()` | ONDEC 命令解析 |
| TX_WBF_STATE | `check_offwbf_cmd()` | OFFWBF 命令生成 |
| RX_WBF_STATE | `check_deep_read_resp()` | Deep Response 内容 |
| RESP_STATE | `check_msa_resp()` | MSA 响应格式 |

### 8.4 验证场景覆盖

| 场景 | RTL 路径 | 验证组件 |
|------|---------|---------|
| Fast Read 成功 | IDLE→ONLIE→FAST→RESP→DONE | `ondec2nsu_agent` |
| Safe Read 成功 | IDLE→ONLIE→SAFE→RESP→DONE | `ondec2nsu_agent` |
| Safe Read + OFFWBF | IDLE→ONLIE→SAFE→TX_WBF→RX_WBF→RESP→DONE | `mychecker` |
| MSA 访问 | IDLE→MSA→DONE→IDLE | `msa_agent` |
| UNMAP | IDLE→UNMAP→DONE→IDLE | `unmap_agent` |

---

## 9. 附录：参数定义

### 9.1 命令相关参数

```systemverilog
parameter DEC_CMD_WIDTH            = 32;   // 单路命令位宽
parameter CMD_PIPE_NUM             = 12;   // 命令字数量 (Index 0-11)
parameter ONLINE_WIDTH             = 384;  // 8 路命令总位宽 (32×12)
```

### 9.2 地址相关参数

```systemverilog
parameter ADDR_WIDTH               = 34;   // AXI 地址位宽
parameter LBA_LEN                  = 30;   // LBA 位宽
parameter MSA_RESP_ADDR            = 3;    // MSA 响应地址位宽 (深度 8)
parameter READ_RESP_ADDR           = 7;    // Read 响应地址位宽 (深度 128)
parameter DEEP_READ_ADDR           = 12;   // Deep Read 地址位宽 (深度 4096)
```

### 9.3 ID 相关参数

```systemverilog
parameter ID_WIDTH                 = 10;   // AXI ID 位宽
parameter OST_WH                   = 5;    // OST ID 位宽
parameter HW_UNMAP_WH              = 45;   // HW UNMAP 命令位宽
```

### 9.4 数据相关参数

```systemverilog
parameter DATA_WIDTH               = 256;  // AXI 数据位宽
parameter BLEN_WIDTH               = 9;    // AXI 突发长度位宽
localparam STRB_WIDTH              = 32;   // AXI 掩码位宽 (256/8)
```

### 9.5 Deep Response 参数

```systemverilog
localparam DEEP_CNT_MAX            = 27;   // Deep Response 计数最大值 (28 个字)
localparam DEEP_ADDR_MAX           = 3051; // Deep Read SRAM 最大地址
```

### 9.6 状态编码

```systemverilog
localparam IDLE_STATE              = 4'd0;
localparam ONLIE_STATE             = 4'd1;   // 图片原拼写
localparam FAST_STATE              = 4'd2;
localparam RESP_STATE              = 4'd3;
localparam SAFE_STATE              = 4'd4;
localparam TX_WBF_STATE            = 4'd5;
localparam RX_WBF_STATE            = 4'd6;
localparam UNMAP_STATE             = 4'd7;
localparam MSA_STATE               = 4'd9;
localparam DONE_STATE              = 4'd10;
```

---

## 10. 总结

### 10.1 模块核心功能

`nsu_nand_rd_cmd_merge_ctrl` 是 NSU 的**命令处理核心**，负责:

1. **接收** 5 种命令源 (在线/OFFWBF/MSA/UNMAP)
2. **仲裁** 选择优先级最高的命令
3. **解码** 提取控制字段
4. **分流** 根据模式决定处理路径
5. **响应** 生成 Read/Deep/MSA 响应
6. **上报** 向 TSU 报告完成状态

### 10.2 关键设计特点

| 特点 | 实现方式 |
|------|---------|
| **8 路并行** | 8 路独立 FIFO + 并行解码 |
| **Group 独立** | Group 0/1 独立 OST ID 和地址 |
| **双模式** | Fast/Safe Read 状态机分流 |
| **OFFWBF 协作** | TX/RX_WBF 状态处理 |
| **优先级仲裁** | 固定优先级 5 选 1 |
| **灵活响应** | Read/Deep/MSA 三种响应格式 |

### 10.3 验证建议

1. **功能覆盖**:
   - Fast Read 成功/失败
   - Safe Read 成功/失败
   - OFFWBF 调用流程
   - MSA 访问
   - UNMAP 处理

2. **性能测试**:
   - 8 路并发命令
   - 响应队列满处理
   - OFFWBF 延迟容忍

3. **边界测试**:
   - FIFO 满/空
   - 地址对齐检查
   - OST ID 冲突

### 10.4 后续分析模块

建议继续分析以下模块以完整理解 NSU:

1. **`nsu_rd_inst_decoder.v`** - 指令解码器详细实现
2. **`nsu_tx_wbf_cmd.v`** - OFFWBF 命令生成逻辑
3. **`nsu_read_resp_ctrl.v`** - Read 响应控制
4. **`nsu_write_meta_ctrl.v`** - Meta 数据写控制
5. **`nsu_nand_rd_data_path.v`** - 数据路径控制

---

**文档结束**

*生成时间：2026-03-07*  
*分析工具：OpenClaw Assistant*  
*参考规格：升维 MP-NSU-spec PN85.docx Section 6.4*
