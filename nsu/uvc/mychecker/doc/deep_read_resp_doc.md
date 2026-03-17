# deep_read_resp 功能文档

## 1. 概述

`deep_read_resp` 是 NSU（NAND Storage Unit）向 CPU 发送的深度读取响应信号，用于报告解码失败、CRC 错误等异常情况。在 `ondec2nsu_checker` 中，`deep_read_resp` 检查器负责验证这些响应是否与预期一致，确保 NSU 在遇到异常情况时能够正确地向 CPU 报告相关信息。

## 2. 数据结构

### 2.1 相关 FIFO 定义

```systemverilog
// deep_read_resp FIFO - Input: Deep read response from NSU to CPU
uvm_tlm_analysis_fifo #(nsu2cpu_deep_resp_transaction) deep_read_resp_fifo;
```

### 2.2 相关数据结构

#### 2.2.1 检查状态枚举

```systemverilog
typedef enum logic [2:0] {
    CHECK_PASS           = 3'b000,
    CHECK_FAIL_DATA      = 3'b001,
    CHECK_FAIL_OST_ID    = 3'b010,
    CHECK_FAIL_INSTR_IDX = 3'b011,
    CHECK_FAIL_DECODE    = 3'b100,
    CHECK_FAIL_LBA       = 3'b101,
    CHECK_FAIL_CRC       = 3'b110,
    CHECK_INVALID_RESP   = 3'b111
} check_status_e;
```

#### 2.2.2 组检查配置

```systemverilog
typedef struct  {
    logic        valid;
    logic [15:0] instruction_index;
    logic [4:0]  nsu_ost_id;               // Group-specific OST ID
    logic [3:0]  plane_sel;                // 4 plane_pair selection
    logic [3:0]  dec_suc;                  // 4 plane_pair decode success
    logic [3:0]  crc_pass;                 // 4 plane_pair CRC pass
    logic [3:0]  data_out_en;              // 4 plane_pair data output enable
    logic [3:0]  offline_wbf_work_en;      // 4 plane_pair offwbf enable
    logic [3:0]  flip_threshold_sel;       // 4 plane_pair flip threshold select
    logic [3:0]  syn_weight_over_threshold; // 4 plane_pair sync weight over threshold
    logic [3:0]  descramble_en;            // 4 plane_pair descramble enable
    logic [15:0] descramble_seed [4];      // 4 plane_pair descramble seed
    logic [3:0]  write_pos_jdg;            // 4 plane_pair write position judgment
    logic        deep_read_sel;            // Deep read select (consistent in group)
    logic        read_mode;                // Read mode (consistent in group)
    logic [31:0] dest_memory_addr;         // Target memory address (group_0_dest_memory_addr)
    logic [31:0] dec_fail_dest_addr;       // Decode fail target address (dec_fail_dest_addr_0)
    logic [15:0] plane_group_block_addr;   // Block address (group0_block_addr)
    logic [11:0] page_addr_plane_group;    // Page address (page_address_plane_group_0)
} group_check_config_t;
```

## 3. 检查流程

### 3.1 触发条件

`deep_read_resp` 检查器在以下情况下被触发：

1. 当任一 plane_pair 满足 `dec_suc=0 && crc_pass=1 && data_out_en=0` 时，组需要报告 deep_resp
2. 当任一 plane_pair 满足 `crc_pass=0` 时，组需要报告 deep_resp
3. 当任一 plane_pair 满足 `deep_read_sel=1` 时，组需要报告 deep_resp

### 3.2 检查步骤

1. **获取 deep_read_resp 事务**：从 `deep_read_resp_fifo` 中获取响应
2. **验证指令索引**：检查该指令索引是否有预期的 deep_resp
3. **组匹配**：通过 ost_id 匹配对应的组（Group 0 或 Group 1）
4. **平面对检查**：对组内每个选中的 plane_pair 进行以下检查：
   - 解码状态检查
   - CRC 状态检查
   - LBA 比较结果检查
   - ECC 结果检查
5. **组级检查**：
   - deep_read_sel 检查
   - read_mode 检查
   - block_addr 检查
   - page_addr 检查
   - meta_index_LBA 检查
6. **状态更新**：根据检查结果更新统计信息
7. **清理配置**：如果所有响应都已处理，清理相关配置

### 3.3 核心检查逻辑

```systemverilog
task `CLASS_NAME_DEFINE::check_deep_read_resp();
    nsu2cpu_deep_resp_transaction resp;
    check_status_e status;
    string fail_reason;
    int matched_gid;
    int pp_idx;
    logic [4:0] resp_ost_id;
    ondec2nsu_group_transaction cfg;
    int pp_base;
    
    forever begin
        deep_read_resp_fifo.get(resp);
        total_resp_count++;
        
        // 检查是否预期有 deep read response
        if (pending_deep_resp[resp.instruction_index]) begin
            status = CHECK_PASS;
            fail_reason = "";
            matched_gid = -1;
            
            // 遍历两个组寻找匹配的组（通过 ost_id）
            for (int gid = 0; gid < 2; gid++) begin
                cfg = pending_config[resp.instruction_index];
                pp_base = gid * 4;  // Group 0: pp_base=0, Group 1: pp_base=4
                
                // 根据组 ID 获取对应的 ost_id
                if (gid == 0) {
                    resp_ost_id = resp.group0_ost_id;
                } else {
                    resp_ost_id = resp.group1_ost_id;
                }
                
                // 检查 ost_id 匹配（组独立性的关键）
                if (cfg.tr[pp_base].nsu_ost_id == resp_ost_id) {
                    matched_gid = gid;//step1: compare group ost_id
                    
                    // 遍历组内 4 个 plane_pairs 进行检查
                    for (int pp = 0; pp < 4; pp++) {
                        if (!cfg.tr[pp_base + pp].plane_sel) continue;  // 跳过未选中的 plane_pair
                        
                        if (!cfg.tr[pp_base + pp].crc_pass) begin //如果 crc 失败，会报告 deep resp
                            pp_idx = gid * 4 + pp;  // 全局 plane_pair 索引
                            
                            // 检查解码状态
                            if (cfg.tr[pp_base + pp].dec_suc != resp.plane_pair_dec_result[pp_idx]) {
                                status = CHECK_FAIL_DECODE;
                                fail_reason = $sformatf("Group%0d PP[%0d] decode mismatch: expected=%0b, got=%0b", 
                                    gid, pp, cfg.tr[pp_base + pp].dec_suc, resp.plane_pair_dec_result[pp_idx]);
                                break;
                            }
                            
                            // 检查 CRC 状态
                            if (cfg.tr[pp_base + pp].crc_pass != resp.plane_pair_crc_result[pp_idx]) {
                                status = CHECK_FAIL_CRC;
                                fail_reason = $sformatf("Group%0d PP[%0d] CRC mismatch: expected=%0b, got=%0b", 
                                    gid, pp, cfg.tr[pp_base + pp].crc_pass, resp.plane_pair_crc_result[pp_idx]);
                                break;
                            }
                            
                            // 检查 LBA 比较结果
                            if (cfg.tr[pp_base + pp].error_flag && !resp.plane_pair_lba_comp[pp_idx]) {
                                status = CHECK_FAIL_LBA;
                                fail_reason = $sformatf("Group%0d PP[%0d] LBA comp mismatch: expected mismatch but got match", 
                                    gid, pp);
                                break;
                            }
                            
                            // 检查 ECC 结果
                            if (!cfg.tr[pp_base + pp].dec_suc && resp.plane_pair_ecc_result[pp_idx]) {
                                `uvm_info(get_type_name(), $sformatf("  Group%0d PP[%0d]: ECC correction successful", 
                                    gid, pp), UVM_LOW)
                            }
                        }
                    }
                    
                    // 检查 deep_read_sel
                    if (cfg.tr[pp_base].deep_read_sel != resp.deep_read_sel) {
                        status = CHECK_FAIL_DATA;
                        fail_reason = $sformatf("Group%0d deep_read_sel mismatch: expected=%0b, got=%0b", 
                            gid, cfg.tr[pp_base].deep_read_sel, resp.deep_read_sel);
                    }
                    
                    // 检查 read_mode
                    if (cfg.tr[pp_base].read_mode != resp.safe_fast_read) {
                        status = CHECK_FAIL_DATA;
                        fail_reason = $sformatf("Group%0d read_mode mismatch: expected=%0b, got=%0b", 
                            gid, cfg.tr[pp_base].read_mode, resp.safe_fast_read);
                    }
                    
                    // 检查 block_addr
                    if (cfg.tr[pp_base].plane_group_block_addr != resp.group0_block_addr && gid == 0) {
                        status = CHECK_FAIL_DATA;
                        fail_reason = $sformatf("Group%0d block_addr mismatch: expected=%0h, got=%0h", 
                            gid, cfg.tr[pp_base].plane_group_block_addr, resp.group0_block_addr);
                    }
                    if (cfg.tr[pp_base].plane_group_block_addr != resp.group1_block_addr && gid == 1) {
                        status = CHECK_FAIL_DATA;
                        fail_reason = $sformatf("Group%0d block_addr mismatch: expected=%0h, got=%0h", 
                            gid, cfg.tr[pp_base].plane_group_block_addr, resp.group1_block_addr);
                    }
                    
                    // 检查 page_addr
                    if (cfg.tr[pp_base].page_addr_plane_group != resp.group0_page_addr && gid == 0) {
                        status = CHECK_FAIL_DATA;
                        fail_reason = $sformatf("Group%0d page_addr mismatch: expected=%0h, got=%0h", 
                            gid, cfg.tr[pp_base].page_addr_plane_group, resp.group0_page_addr);
                    }
                    if (cfg.tr[pp_base].page_addr_plane_group != resp.group1_page_addr && gid == 1) {
                        status = CHECK_FAIL_DATA;
                        fail_reason = $sformatf("Group%0d page_addr mismatch: expected=%0h, got=%0h", 
                            gid, cfg.tr[pp_base].page_addr_plane_group, resp.group1_page_addr);
                    }
                    
                    // 检查 meta_index_LBA
                    if (cfg.tr[pp_base].lba[22:0] != resp.group0_meta_index_LBA && gid == 0) {
                        status = CHECK_FAIL_DATA;
                        fail_reason = $sformatf("Group%0d meta_index_LBA mismatch: expected=%0h, got=%0h", 
                            gid, cfg.tr[pp_base].lba[22:0], resp.group0_meta_index_LBA);
                    }
                    if (cfg.tr[pp_base].lba[22:0] != resp.group1_meta_index_LBA && gid == 1) {
                        status = CHECK_FAIL_DATA;
                        fail_reason = $sformatf("Group%0d meta_index_LBA mismatch: expected=%0h, got=%0h", 
                            gid, cfg.tr[pp_base].lba[22:0], resp.group1_meta_index_LBA);
                    }
                    
                    // 更新统计信息并报告
                    if (status == CHECK_PASS) {
                        pass_count++;
                        group_decode_success[gid]++;
                        `uvm_info(get_type_name(), $sformatf("DEEP_READ_RESP Group%0d CHECK PASS: instr_idx=%0h (ost_id=%0h)", 
                            gid, resp.instruction_index, resp_ost_id), UVM_LOW)
                    } else {
                        fail_count++;
                        group_decode_fail[gid]++;
                        `uvm_error(get_type_name(), $sformatf("DEEP_READ_RESP Group%0d CHECK FAIL: instr_idx=%0h, status=%0b, reason=%s", 
                            gid, resp.instruction_index, status, fail_reason))
                    }
                }
            }
            
            // 清除 deep_resp 标志
            pending_deep_resp[resp.instruction_index] = 1'b0;
            
            // 检查是否所有响应都已处理，然后清除配置
            if (!pending_deep_resp[resp.instruction_index] && !pending_offwbf[resp.instruction_index]) {
                pending_instr_exists[resp.instruction_index] = 1'b0;
                pending_config.delete(resp.instruction_index);
            }
        } else {
            `uvm_error(get_type_name(), $sformatf("DEEP_READ_RESP: No matching config for instr_idx=%0h", 
                resp.instruction_index))
        }
    end
endtask : check_deep_read_resp
```

## 4. 字段说明

### 4.1 nsu2cpu_deep_resp_transaction 字段

| 字段名 | 位宽 | 说明 |
|--------|------|------|
| instruction_index | 16 | 指令索引，用于匹配对应的命令 |
| group0_ost_id | 5 | Group 0 的 OST ID |
| group1_ost_id | 5 | Group 1 的 OST ID |
| plane_pair_dec_result | 8 | 8 个 plane_pair 的解码结果（1=成功，0=失败） |
| plane_pair_crc_result | 8 | 8 个 plane_pair 的 CRC 结果（1=成功，0=失败） |
| plane_pair_lba_comp | 8 | 8 个 plane_pair 的 LBA 比较结果（1=不匹配，0=匹配） |
| plane_pair_ecc_result | 8 | 8 个 plane_pair 的 ECC 结果（1=可纠正，0=不可纠正） |
| deep_read_sel | 1 | 深度读取选择 |
| safe_fast_read | 1 | 安全/快速读取模式 |
| group0_block_addr | 16 | Group 0 的块地址 |
| group1_block_addr | 16 | Group 1 的块地址 |
| group0_page_addr | 12 | Group 0 的页地址 |
| group1_page_addr | 12 | Group 1 的页地址 |
| group0_meta_index_LBA | 23 | Group 0 的元数据索引 LBA |
| group1_meta_index_LBA | 23 | Group 1 的元数据索引 LBA |

### 4.2 检查项说明

| 检查项 | 说明 | 失败状态 |
|--------|------|----------|
| instruction_index 匹配 | 响应的指令索引是否与预期一致 | CHECK_INVALID_RESP |
| ost_id 匹配 | 组的 OST ID 是否与预期一致 | CHECK_FAIL_OST_ID |
| 解码状态 | plane_pair_dec_result 是否与 dec_suc 一致 | CHECK_FAIL_DECODE |
| CRC 状态 | plane_pair_crc_result 是否与 crc_pass 一致 | CHECK_FAIL_CRC |
| LBA 比较 | plane_pair_lba_comp 是否与 error_flag 一致 | CHECK_FAIL_LBA |
| deep_read_sel | deep_read_sel 是否与预期一致 | CHECK_FAIL_DATA |
| read_mode | safe_fast_read 是否与 read_mode 一致 | CHECK_FAIL_DATA |
| block_addr | 块地址是否与预期一致 | CHECK_FAIL_DATA |
| page_addr | 页地址是否与预期一致 | CHECK_FAIL_DATA |
| meta_index_LBA | 元数据索引 LBA 是否与预期一致 | CHECK_FAIL_DATA |

## 5. 组处理机制

### 5.1 组划分

- **Group 0**：包含 plane_pair[0:3]，使用 tr[0].nsu_ost_id 作为组 OST ID
- **Group 1**：包含 plane_pair[4:7]，使用 tr[4].nsu_ost_id 作为组 OST ID

### 5.2 组独立性

检查器采用组独立处理机制，每个组：
1. 有自己的 OST ID
2. 独立判断是否需要 deep_resp
3. 独立进行检查和报告
4. 独立更新统计信息

## 6. 统计信息

检查器维护以下统计信息：

| 统计项 | 说明 |
|--------|------|
| total_resp_count | 处理的 deep_read_resp 总数 |
| pass_count | 检查通过的总数 |
| fail_count | 检查失败的总数 |
| group_decode_success[0/1] | 组 0/1 的解码成功计数 |
| group_decode_fail[0/1] | 组 0/1 的解码失败计数 |
| group_crc_err[0/1] | 组 0/1 的 CRC 错误计数 |

## 7. 错误处理

### 7.1 错误类型

| 错误状态 | 说明 |
|----------|------|
| CHECK_PASS | 检查通过 |
| CHECK_FAIL_DATA | 数据不匹配 |
| CHECK_FAIL_OST_ID | OST ID 不匹配 |
| CHECK_FAIL_INSTR_IDX | 指令索引不匹配 |
| CHECK_FAIL_DECODE | 解码状态不匹配 |
| CHECK_FAIL_LBA | LBA 比较结果不匹配 |
| CHECK_FAIL_CRC | CRC 状态不匹配 |
| CHECK_INVALID_RESP | 无效响应 |

### 7.2 错误报告

当检查失败时，检查器会：
1. 设置相应的错误状态
2. 生成详细的错误原因
3. 输出错误信息
4. 更新失败统计

## 8. 使用示例

### 8.1 触发 deep_read_resp 的场景

#### 场景 1：解码失败且无数据输出

```systemverilog
// 配置 plane_pair 以触发 deep_read_resp
ondec2nsu_transaction tr;
tr.dec_suc = 0;      // 解码失败
tr.crc_pass = 1;     // CRC 成功
tr.data_out_en = 0;  // 无数据输出
```

#### 场景 2：CRC 失败

```systemverilog
// 配置 plane_pair 以触发 deep_read_resp
ondec2nsu_transaction tr;
tr.crc_pass = 0;     // CRC 失败
```

#### 场景 3：深度读取选择

```systemverilog
// 配置 plane_pair 以触发 deep_read_resp
ondec2nsu_transaction tr;
tr.deep_read_sel = 1; // 深度读取选择
```

### 8.2 检查流程示例

1. **配置阶段**：创建 ondec2nsu_group_transaction 并设置触发条件
2. **命令处理**：check_ondec_cmd 任务检测到需要 deep_resp 并设置标志
3. **响应处理**：check_deep_read_resp 任务接收响应并进行检查
4. **结果报告**：输出检查结果和统计信息

## 9. 性能考虑

- **组并行处理**：两个组可以并行处理，提高检查效率
- **状态管理**：使用关联数组管理待处理的配置，快速查找
- **错误处理**：一旦发现错误，立即停止当前组的检查，提高效率

## 10. 总结

`deep_read_resp` 检查器是 ONDEC2NSU 验证环境中的重要组件，负责验证 NSU 在遇到异常情况时向 CPU 报告的深度读取响应。通过组独立处理机制，它能够有效地验证 8 个 plane_pair 的状态，并确保 NSU 能够正确地报告解码失败、CRC 错误等异常情况。

检查器的设计考虑了以下因素：
- 组独立性：每个组有自己的 OST ID 和检查逻辑
- 全面性：检查所有相关字段和状态
- 效率：并行处理和快速错误检测
- 可维护性：清晰的错误报告和统计信息

通过使用 `deep_read_resp` 检查器，可以确保 NSU 在处理 NAND 存储操作时能够正确地处理异常情况，并向 CPU 提供准确的状态报告。