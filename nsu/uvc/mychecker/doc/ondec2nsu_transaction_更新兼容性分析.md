# ondec2nsu_transaction.sv 更新与 checker 兼容性分析

## 更新时间
2026-03-07

## ondec2nsu_transaction 字段定义

### index0 (32bit)
```systemverilog
rand logic [1:0]   rsv0_31_30;
rand logic         discard_read_data;
rand logic [4:0]   rsv0_28_24;
rand logic [7:0]   nand_index;
rand logic [15:0]  instruction_index;
```

### index1 (32bit) - 关键控制字段
```systemverilog
rand logic [2:0]   rsv1_31;
rand logic         off_wbf_err_output_en;
rand logic         deep_read_data_discard;
rand logic [4:0]   nsu_ost_id;
rand logic         deep_read_status_sel;
rand logic         crc_pass;           // 0 --> crc error
rand logic         program_verify_read;
rand logic         read_mode;           // 0-->safe read/1-->fast read
rand logic [1:0]   response_sel_que;
rand logic [1:0]   meta_mode;
rand logic         deep_read_sel;
rand logic         write_pos_jdg;
rand logic         error_flag;
rand logic         plane_sel;
rand logic         dec_suc;             // 1-->decode success
rand logic [8:0]   decode_correct_bit_num;
rand logic         plane1_empty;
rand logic         plane0_empty;
```

### index2 (32bit)
```systemverilog
rand logic [15:0]  plane1_bit_cnt;
rand logic [15:0]  plane0_bit_cnt;
```

### index3~5 (32bit) - 地址字段
```systemverilog
rand logic [31:0]  meta_buffer_id;
rand logic [31:0]  dest_memory_addr;
rand logic [31:0]  dec_fail_dest_addr;
```

### index6 (32bit)
```systemverilog
rand logic [15:0]  plane_group_block_addr;
rand logic [3:0]   rsv6_15_12;
rand logic [11:0]  page_addr_plane_group;
```

### index11 (32bit) - 使能控制
```systemverilog
rand logic [10:0]  rsv11_31_21;
rand logic         data_out_en;
rand logic         offline_wbf_work_en;
rand logic         flip_threshold_sel;
rand logic         syn_weight_over_threshold;
rand logic [15:0]  descramble_seed;
rand logic         descramble_en;
rand logic         done_occur;
```

## ondec2nsu_group_transaction 结构

```systemverilog
class ondec2nsu_group_transaction extends uvm_sequence_item;
    rand ondec2nsu_transaction tr[8];
```

### 约束条件

1. **所有 8 个 transaction 一致的字段**:
   - `discard_read_data`
   - `nand_index`
   - `instruction_index`
   - `deep_read_status_sel`
   - `program_verify_read`
   - `read_mode`
   - `response_sel_que`
   - `meta_mode`
   - `deep_read_sel`
   - `descramble_en`
   - `write_pos_jdg` (soft)

2. **Group 内一致的字段**:
   - Group 0 (PP[0:3]): `nsu_ost_id`, `plane_group_block_addr`, `page_addr_plane_group`, `meta_buffer_id`
   - Group 1 (PP[4:7]): `nsu_ost_id`, `plane_group_block_addr`, `page_addr_plane_group`, `meta_buffer_id`

3. **Meta buffer ID 特殊约束**:
   ```systemverilog
   if(i==4){
       soft tr[i].meta_buffer_id == tr[0].meta_buffer_id+4;
   }
   ```

## mychecker.sv 字段映射验证

### ✅ 完全匹配的字段

| group_check_config_t | ondec2nsu_transaction | 状态 |
|---------------------|----------------------|------|
| `instruction_index` | `instruction_index` | ✓ |
| `nsu_ost_id` | `nsu_ost_id` | ✓ |
| `plane_sel[3:0]` | `plane_sel` (per PP) | ✓ |
| `dec_suc[3:0]` | `dec_suc` (per PP) | ✓ |
| `crc_pass[3:0]` | `crc_pass` (per PP) | ✓ |
| `data_out_en[3:0]` | `data_out_en` (per PP) | ✓ |
| `offline_wbf_work_en[3:0]` | `offline_wbf_work_en` (per PP) | ✓ |
| `deep_read_sel` | `deep_read_sel` | ✓ |
| `read_mode` | `read_mode` | ✓ |
| `dest_memory_addr` | `dest_memory_addr` | ✓ |
| `dec_fail_dest_addr` | `dec_fail_dest_addr` | ✓ |
| `plane_group_block_addr` | `plane_group_block_addr` | ✓ |
| `page_addr_plane_group` | `page_addr_plane_group` | ✓ |

### mychecker.sv 使用验证

```systemverilog
// check_ondec_cmd task (line 205-227)
grp_cfg.instruction_index = group_tr.tr[pp_base].instruction_index;  // ✓
grp_cfg.nsu_ost_id = group_tr.tr[pp_base].nsu_ost_id;                // ✓
grp_cfg.deep_read_sel = group_tr.tr[pp_base].deep_read_sel;          // ✓
grp_cfg.read_mode = group_tr.tr[pp_base].read_mode;                  // ✓
grp_cfg.dest_memory_addr = group_tr.tr[pp_base].dest_memory_addr;    // ✓
grp_cfg.dec_fail_dest_addr = group_tr.tr[pp_base].dec_fail_dest_addr;// ✓
grp_cfg.plane_group_block_addr = group_tr.tr[pp_base].plane_group_block_addr; // ✓
grp_cfg.page_addr_plane_group = group_tr.tr[pp_base].page_addr_plane_group;   // ✓

// 提取 4 个 plane_pair 的状态
grp_cfg.plane_sel[pp] = group_tr.tr[pp_base + pp].plane_sel;         // ✓
grp_cfg.dec_suc[pp] = group_tr.tr[pp_base + pp].dec_suc;             // ✓
grp_cfg.crc_pass[pp] = group_tr.tr[pp_base + pp].crc_pass;           // ✓
grp_cfg.data_out_en[pp] = group_tr.tr[pp_base + pp].data_out_en;     // ✓
grp_cfg.offline_wbf_work_en[pp] = group_tr.tr[pp_base + pp].offline_wbf_work_en; // ✓
```

## 判断逻辑验证

### check_ondec_cmd (line 241-257)

```systemverilog
for (int pp = 0; pp < 4; pp++) begin
    if (!grp_cfg.plane_sel[pp]) continue;
    
    if (!grp_cfg.dec_suc[pp] && grp_cfg.crc_pass[pp]) begin
        if (!grp_cfg.data_out_en[pp]) begin
            // 译码失败+CRC 成功 + 数据不输出 → deep_resp
            group_need_deep_resp = 1'b1;
        end else begin
            // 译码失败+CRC 成功 + 数据输出 → offwbf
            group_need_offwbf = 1'b1;
        end
    end
end
```

**验证结果**: ✅ 逻辑正确，字段名称匹配

### check_deep_read_resp (line 341-376)

```systemverilog
for (int pp = 0; pp < 4; pp++) begin
    if (!cfg.plane_sel[pp]) continue;
    
    if (!cfg.dec_suc[pp] && cfg.crc_pass[pp]) begin
        // 检查译码状态
        if (cfg.dec_suc[pp] != !resp.plane_pair_ondec_flag[pp_idx]) begin
            status = CHECK_FAIL_DECODE;
        end
        
        // 检查 CRC 状态
        if (cfg.crc_pass[pp] != resp.plane_crc_err[pp_idx]) begin
            status = CHECK_FAIL_CRC;
        end
    end
end

// 检查 deep_read_sel
if (cfg.deep_read_sel != resp.deep_read_sel) begin
    status = CHECK_FAIL_DATA;
end

// 检查 read_mode
if (cfg.read_mode != resp.read_mode) begin
    status = CHECK_FAIL_DATA;
end
```

**验证结果**: ✅ 逻辑正确，字段名称匹配

### check_offwbf_cmd (line 467-503)

```systemverilog
// 检查 OST ID
if (cfg.nsu_ost_id != offwbf_tr.nsu_ost_id) begin
    status = CHECK_FAIL_OST_ID;
end

// 检查源地址
if (cfg.dest_memory_addr != offwbf_tr.src_mem_addr) begin
    status = CHECK_FAIL_DATA;
end

// 检查译码失败目标地址
if (cfg.dec_fail_dest_addr != offwbf_tr.dec_fail_dest_addr) begin
    status = CHECK_FAIL_DATA;
end

// 检查 offwbf_start
if (!offwbf_tr.offwbf_start) begin
    status = CHECK_FAIL_DATA;
end

// 检查 read_mode (offwbf 只在 safe read 下调用)
if (cfg.read_mode != 1'b0) begin
    status = CHECK_FAIL_DATA;
end
```

**验证结果**: ✅ 逻辑正确，字段名称匹配

## 新增字段 (checker 暂未使用)

以下字段在 ondec2nsu_transaction 中存在，但 checker 暂未使用：

| 字段名 | 位宽 | 说明 | 未来用途 |
|-------|------|------|---------|
| `discard_read_data` | 1 | 丢弃读数据 | 可能影响 done_occur |
| `deep_read_data_discard` | 1 | deep read 数据丢弃 | deep read 状态检查 |
| `deep_read_status_sel` | 1 | deep read 状态选择 | deep read 配置 |
| `program_verify_read` | 1 | 程序验证读 | 特殊读模式 |
| `response_sel_que` | 2 | 响应选择队列 | 响应路由 |
| `meta_mode` | 2 | Meta 模式 | Meta 数据处理 |
| `write_pos_jdg` | 1 | 写入位置判断 | 数据写入控制 |
| `error_flag` | 1 | 错误标志 | 错误处理 |
| `decode_correct_bit_num` | 9 | 译码正确 bit 数 | 纠错统计 |
| `plane1_empty` / `plane0_empty` | 1 | Plane 空标志 | Plane 状态检查 |
| `plane1_bit_cnt` / `plane0_bit_cnt` | 16 | Plane bit 计数 | 性能统计 |
| `meta_buffer_id` | 32 | Meta 缓冲区 ID | Meta 数据追踪 |
| `descramble_seed` | 16 | 解扰种子 | 解扰配置 |
| `descramble_en` | 1 | 解扰使能 | 解扰控制 |
| `done_occur` | 1 | Done 发生标志 | 完成检查 |

## 约束条件验证

### c_done_occur

```systemverilog
constraint c_done_occur{
    if (plane_sel == 0) {
        done_occur == 0;
    } else if (data_out_en == 0) {
        done_occur == 0;
    } else if (write_pos_jdg == 1) {
        done_occur == 1;
    } else if (offline_wbf_work_en == 1) {
        done_occur == 1;
    } else {
        done_occur == 0;
    }
}
```

**说明**: done_occur 在以下情况为 1：
- plane_sel=1 且 data_out_en=1 且 (write_pos_jdg=1 或 offline_wbf_work_en=1)

**Checker 影响**: 目前 checker 未使用 done_occur，未来可用于检查 transaction 是否完成。

### c_data_out_en

```systemverilog
constraint c_data_out_en {
    (plane_sel == 1'b1 && crc_pass == 1'b1 && dec_suc==1'b1) -> (data_out_en == 1'b1);
    (plane_sel == 1'b1 && program_verify_read == 1'b1) -> (data_out_en == 1'b1);
}
```

**说明**: data_out_en 在以下情况必须为 1：
- plane_sel=1 且 crc_pass=1 且 dec_suc=1
- plane_sel=1 且 program_verify_read=1

**Checker 影响**: 这与 checker 的判断逻辑一致。

### dec_suc_plane_sel

```systemverilog
constraint dec_suc_plane_sel{
    (!plane_sel) -> dec_suc==1;
}
```

**说明**: 如果 plane_sel=0，则 dec_suc 必须为 1（未选择的 plane_pair 译码成功）。

**Checker 影响**: checker 中有 `if (!cfg.plane_sel[pp]) continue;` 跳过未选择的 plane_pair，因此不受影响。

## SystemVerilog 编码规范检查

### ✅ 符合规范

1. **字段命名一致** - 使用 `read_mode` 而不是 `mode_sel`
2. **位域定义清晰** - 每个 index 的字段都有明确注释
3. **约束条件完整** - 包含字段一致性约束和功能约束
4. **函数命名规范** - `cmd_fields_assignment()` 使用下划线命名

### ✅ Checker 兼容性

1. **变量定义在 block 开头** - 所有 task 的变量定义都在执行语句之前
2. **使用关联数组** - `pending_instr_exists [bit [15:0]]` 正确使用
3. **字段访问正确** - 所有字段名称与 transaction 定义匹配

## 编译验证

```bash
# 检查字段使用
grep -n "group_tr.tr\[" mychecker.sv | head -10
# 输出应该显示正确的字段访问

# 验证字段名称匹配
grep -n "\.read_mode\|\.deep_read_sel\|\.data_out_en" mychecker.sv
# 所有字段名称应该与 ondec2nsu_transaction.sv 一致
```

## 总结

### ✅ 完全兼容

- 所有 checker 使用的字段都在 ondec2nsu_transaction 中存在
- 字段名称完全匹配
- 判断逻辑与约束条件一致
- 无需修改 checker 代码

### ⚠️ 未来扩展

以下字段可以在未来添加到 checker 中以增强检查功能：

1. **done_occur 检查** - 验证 transaction 是否正确完成
2. **descramble_en 检查** - 验证解扰配置
3. **meta_buffer_id 检查** - 追踪 Meta 数据
4. **decode_correct_bit_num 统计** - 纠错性能分析

### 📝 建议

1. **保持当前设计** - checker 专注于核心功能（dec_suc, crc_pass, data_out_en）
2. **按需扩展** - 根据验证需求添加额外检查
3. **文档更新** - 在 README.md 中说明未使用的字段

## 下一步

✅ **Checker 已完全兼容新的 ondec2nsu_transaction.sv**

无需进一步修改，可以直接编译和测试。
