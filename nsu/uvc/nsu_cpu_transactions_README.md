# NSU-CPU Transaction 定义文档

## 概述

`nsu_cpu_transactions.sv` 包含 NSU 与 CPU 之间交互的 10 个 UVM transaction 类定义。

参考文档：**升维 MP-NSU-spec PN85.docx** 第 6.4 节 CPU 交互指令

## Transaction 列表

| # | Transaction 类名 | 方向 | Spec 章节 | 描述 |
|---|-----------------|------|----------|------|
| 1 | `nsu2cpu_deep_resp_transaction` | NSU→CPU | 6.4.11 | Deep read 上报 resp (IO read error 和 deep read) |
| 2 | `cpu2nsu_unmap_cmd_transaction` | CPU→NSU | 6.4.8 | Sw unmap req 指令 |
| 3 | `nsu2cpu_rcmd_transaction` | NSU→CPU | 6.4.10 | 输出 read 状态 (4 个队列) |
| 4 | `cpu2nsu_write_addr_transaction` | CPU→NSU | 6.4.3 | Io write addr queue |
| 5 | `nsu2cpu_write_req_transaction` | NSU→CPU | 6.4.1 | Io write req queue |
| 6 | `nsu2cpu_write_addr_resp_transaction` | NSU→CPU | 6.4.4 | Io write addr resp queue |
| 7 | `nsu2cpu_write_resp_transaction` | NSU→CPU | 6.4.5 | Io write resp queue |
| 8 | `cpu2nsu_msa_write_req_transaction` | CPU→NSU | 6.4.6 | Msa write req que |
| 9 | `nsu2cpu_msa_resp_transaction` | NSU→CPU | 6.4.7 | MSA resp que |
| 10 | `nsu2cpu_resp_transaction` | NSU→CPU | 通用 | 通用响应 (未分类) |

## 使用示例

### 1. 导入包

```systemverilog
import nsu_cpu_transactions_pkg::*;
```

### 2. 创建 Transaction

```systemverilog
// 创建 deep read resp transaction
nsu2cpu_deep_resp_transaction deep_resp;
deep_resp = nsu2cpu_deep_resp_transaction::type_id::create("deep_resp");

// 创建 write req transaction
nsu2cpu_write_req_transaction write_req;
write_req = nsu2cpu_write_req_transaction::type_id::create("write_req");
```

### 3. 使用 fields_assignment 从数组解析数据

```systemverilog
// 模拟从 DUT 接收到的数据
bit [31:0] raw_data [];
raw_data = new[3];
raw_data[0] = 32'h0102_0005;  // err_bitmap[31:16], wr_length[8:5], cmd_type[4], ost_id[3:0]
raw_data[1] = 32'h0000_1234;  // nsu_addr[29:0]
raw_data[2] = 32'h8000_0000;  // wr_memory_addr[31:0]

// 将原始数据赋值给 transaction
write_req.data_array = raw_data;

// 调用 fields_assignment 解析到位域
write_req.fields_assignment();

// 现在可以访问解析后的字段
`uvm_info("TEST", $sformatf("ost_id=%0d, cmd_type=%0b, wr_length=%0d", 
    write_req.ost_id, write_req.cmd_type, write_req.wr_length), UVM_LOW)
```

### 4. 使用 pack_to_array 将位域打包到数组

```systemverilog
bit [31:0] packed [];

// 设置字段值
deep_resp.instruction_index = 16'h0001;
deep_resp.plane_pair_en = 8'hFF;
deep_resp.nand_cmd_index = 8'h02;

// 打包到数组
deep_resp.pack_to_array(packed);

// packed 数组现在包含可以发送到 DUT 的数据
```

### 5. 随机化 Transaction

```systemverilog
// 随机化 write req transaction
if (!write_req.randomize()) begin
    `uvm_error("TEST", "Randomization failed")
end

// 带约束的随机化
if (!write_req.randomize() with {
    cmd_type == 1'b0;  // program 命令
    wr_length inside {[1:4]};
}) begin
    `uvm_error("TEST", "Constrained randomization failed")
end
```

## 详细字段说明

### 1. nsu2cpu_deep_resp_transaction (6.4.11)

**用途**: Deep read 上报 resp，处理 IO read error 和 deep read

**关键字段**:
| 字段 | 位宽 | 描述 |
|------|------|------|
| `plane_pair_en` | 8 | plane_pair 选择 |
| `nand_cmd_index` | 8 | NAND 的操作命令 |
| `instruction_index` | 16 | 用于标识指令 |
| `plane_crc_err` | 8 | CRC 译码失败标志 (0=失败) |
| `plane_pair_lba_comp` | 8 | LBA 比对结果 (0=成功) |
| `plane_pair_ondec_flag` | 8 | 解码器译码状态 (0=成功) |
| `mode_sel` | 1 | 0=safe read, 1=fast read |
| `deep_read_sel` | 1 | 1=resp 走 deep resp queue |
| `dec_fail_dest_addr[0:7]` | 8×32 | 译码失败写出数据地址 |
| `plane_pairX_alter_bit` | 9 | 纠错 bit 数 |
| `planeX_empty` | 1 | 没有 program 就 read 该 plane |

### 2. cpu2nsu_unmap_cmd_transaction (6.4.8)

**用途**: Sw unmap req 指令，NSU CPU 通知 NSU 给 TSU 返回固定 pattern

**关键字段**:
| 字段 | 位宽 | 描述 |
|------|------|------|
| `nsu_addr` | 30 | lba |
| `rd_length` | 8 | read 长度，最大 32KB，1=4KB |
| `ost_id` | 5 | 读 outstanding 的 id |

### 3. nsu2cpu_rcmd_transaction (6.4.10)

**用途**: 输出 read 状态 (4 个队列)

**关键字段**:
| 字段 | 位宽 | 描述 |
|------|------|------|
| `error_plane_pair_sel` | 8 | 解码器译码状态 (0=成功) |
| `nand_cmd_index` | 8 | NAND 的操作命令 |
| `instruction_index` | 16 | 用于标识指令 |

### 4. cpu2nsu_write_addr_transaction (6.4.3)

**用途**: Io write addr queue，NSU CPU 分配 share memory 地址

**关键字段**:
| 字段 | 位宽 | 描述 |
|------|------|------|
| `ost_id` | 4 | 用于标识指令 |
| `instruction_index` | 16 | 用于标识指令 |
| `write_addr` | 32 | 临时缓存地址 (256bit 对齐) |

### 5. nsu2cpu_write_req_transaction (6.4.1)

**用途**: Io write req queue，TSU 下发的 program 指令

**关键字段**:
| 字段 | 位宽 | 描述 |
|------|------|------|
| `err_bitmap` | 16 | 每 4KB 有 1bit err_bit_map |
| `wr_length` | 4 | program 长度，32KB-128KB，1=32KB |
| `cmd_type` | 1 | 0=program, 1=delet |
| `ost_id` | 4 | 写 outstanding 的 id |
| `nsu_addr` | 30 | lba |
| `wr_memory_addr` | 32 | share memory 地址 |

### 6. nsu2cpu_write_addr_resp_transaction (6.4.4)

**用途**: Io write addr resp queue，NSU 写完数据后返回 resp

**关键字段**:
| 字段 | 位宽 | 描述 |
|------|------|------|
| `instruction_index` | 16 | 用于标识指令 |

### 7. nsu2cpu_write_resp_transaction (6.4.5)

**用途**: Io write resp queue，NSU CPU program 完成后发送 resp

**关键字段**:
| 字段 | 位宽 | 描述 |
|------|------|------|
| `ost_id` | 4 | outstanding id |

### 8. cpu2nsu_msa_write_req_transaction (6.4.6)

**用途**: Msa write req que，MSA 解码完成后通知 NSU 取数据

**关键字段**:
| 字段 | 位宽 | 描述 |
|------|------|------|
| `nsu_addr` | 30 | lba |
| `err_flag` | 32 | 软件 merge 的 error flag |
| `instruction_index` | 16 | 用于标识指令 |
| `ost_id` | 5 | Rcmd outstanding 队列 id |
| `src_mem_addr` | 32 | 解码后数据 sram 地址 (256b 对齐) |

### 9. nsu2cpu_msa_resp_transaction (6.4.7)

**用途**: MSA resp que，MSA 命令执行完成后返回 resp

**关键字段**:
| 字段 | 位宽 | 描述 |
|------|------|------|
| `instruction_index` | 16 | 用于标识指令 |

### 10. nsu2cpu_resp_transaction (通用)

**用途**: 通用响应，用于其他未分类的 NSU→CPU 响应

**响应类型**:
- `RESP_TYPE_GENERIC` - 通用
- `RESP_TYPE_PROGRAM` - program 响应
- `RESP_TYPE_READ` - read 响应
- `RESP_TYPE_ERROR` - 错误响应
- `RESP_TYPE_STATUS` - 状态响应
- `RESP_TYPE_INTERRUPT` - 中断响应

## 约束条件

每个 transaction 都定义了相应的约束：

```systemverilog
// write_req 约束
constraint valid_constraint {
    wr_length inside {[1:4]};  // 32KB-128KB
    cmd_type inside {[0:1]};   // 0=program, 1=delet
}

// write_addr 约束 - 地址对齐
constraint addr_align_constraint {
    write_addr[4:0] == 5'b0;  // 256bit 对齐
}

// msa_write_req 约束 - 地址对齐
constraint addr_align_constraint {
    src_mem_addr[4:0] == 5'b0;  // 256b 对齐
}
```

## UVM 集成

### 在 Agent 中使用

```systemverilog
class nsu_agent extends uvm_agent;
    import nsu_cpu_transactions_pkg::*;
    
    uvm_analysis_port #(nsu2cpu_write_req_transaction) write_req_ap;
    uvm_analysis_port #(nsu2cpu_deep_resp_transaction) deep_resp_ap;
    
    function void build_phase(uvm_phase phase);
        write_req_ap = new("write_req_ap", this);
        deep_resp_ap = new("deep_resp_ap", this);
    endfunction
endclass
```

### 在 Sequence 中使用

```systemverilog
class nsu_write_seq extends uvm_sequence #(nsu2cpu_write_req_transaction);
    `uvm_object_utils(nsu_write_seq)
    
    virtual task body();
        req = nsu2cpu_write_req_transaction::type_id::create("req");
        
        start_item(req);
        
        if (!req.randomize() with {
            cmd_type == 1'b0;
            ost_id == 4'h5;
        }) begin
            `uvm_error(get_type_name(), "Randomize failed")
        end
        
        finish_item(req);
    endtask
endclass
```

## 文件结构

```
/mnt/disk_0/IC/nsu/uvc/
├── nsu_cpu_transactions.sv    # Transaction 定义 (977 行)
└── ondec2nsu_agent/
    ├── ondec2nsu_checker.sv   # Checker 定义
    ├── ondec2nsu_checker_tb.sv # Checker 测试平台
    └── README.md              # Checker 文档
```

## 注意事项

1. **所有 transaction 都 extends uvm_sequence_item**，支持 UVM 的 field automation
2. **fields_assignment 函数** 用于从原始数据数组解析到位域
3. **pack_to_array 函数** 用于将位域打包到原始数据数组
4. **地址对齐约束**: write_addr 和 src_mem_addr 需要 256bit 对齐 (低 5bit 为 0)
5. **instruction_index** 用于唯一标识每条指令，在 request/response 配对时使用
6. **ost_id** 用于 outstanding 命令跟踪

## 下一步

1. 创建对应的 driver 和 monitor
2. 实现 sequencer
3. 创建完整的 agent
4. 添加 coverage model
5. 编写测试用例
