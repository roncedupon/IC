# offdec2nsu_transaction.sv 更新与 checker 修复

## 更新时间
2026-03-07

## offdec2nsu_transaction 结构

### offline2nsu_cmd (输入：OFFWBF → NSU)

**数组大小**: 27 bytes (index 0-26)

#### 字段映射

| Index | 位宽 | 字段名 | 说明 |
|-------|------|--------|------|
| 0 | [7:5] | `plane_num_in` | Plane 数量输入 |
| 0 | [4:0] | `ost_id_offline2nsu` | OFFWBF → NSU 的 OST ID |
| 1 | [7:0] | `correct_num_lsb` | 纠错数 LSB |
| 2 | [0] | `correct_num_msb` | 纠错数 MSB |
| 2 | [1] | `dec_suc` | 译码成功标志 |
| 2 | [2] | `write_pos_jdg` | 写入位置判断 |
| 2 | [3] | `offline_wbf_out_flag` | **OFFWBF 输出标志** (相当于 offwbf_start) |
| 3-18 | [7:0] | `meta_data_0[15]` | Meta 数据 (128bit = 16 bytes) |
| 19-22 | [7:0] | `act_out_addr_0[3]` | **实际输出内存地址** (32bit) |
| 23-26 | [7:0] | `exp_out_addr_0[3]` | **期望输出内存地址** (32bit) |
| - | - | `offline_wbf_err_addr_id` | OFFWBF 错误地址 ID |

### nsu2offline_cmd (输出：NSU → OFFWBF)

**数组大小**: 12 bytes (index 0-11)

#### 字段映射

| Index | 位宽 | 字段名 | 说明 |
|-------|------|--------|------|
| 0 | [7:5] | `plane_num` | Plane 数量 |
| 0 | [4:0] | `ost_id_nsu2offline` | **NSU → OFFWBF 的 OST ID** |
| 1 | [3] | `dest_sel` | 目标选择 |
| 1 | [2] | `flip_threshold_sel` | 翻转阈值选择 |
| 1 | [1] | `over_threshold` | 超过阈值 |
| 1 | [0] | `descramble_en` | 解扰使能 |
| 2-3 | [7:0] | `descramble_seed_0[1]` | 解扰种子 (16bit) |
| 4-7 | [7:0] | `dest_mem_addr_0[3]` | **目标内存地址** (32bit) |
| 8-11 | [7:0] | `src_mem_addr_0[3]` | **源内存地址** (32bit) |

## 32bit 地址组合方式

### src_mem_addr (32bit)
```systemverilog
logic [31:0] src_mem_addr_32bit;
src_mem_addr_32bit = {src_mem_addr_3, src_mem_addr_2, src_mem_addr_1, src_mem_addr_0};
```

### dest_mem_addr (32bit)
```systemverilog
logic [31:0] dest_mem_addr_32bit;
dest_mem_addr_32bit = {dest_mem_addr_3, dest_mem_addr_2, dest_mem_addr_1, dest_mem_addr_0};
```

### act_output_mem_addr (32bit)
```systemverilog
logic [31:0] act_out_addr_32bit;
act_out_addr_32bit = {act_out_addr_3, act_out_addr_2, act_out_addr_1, act_out_addr_0};
```

### exp_output_mem_addr (32bit)
```systemverilog
logic [31:0] exp_out_addr_32bit;
exp_out_addr_32bit = {exp_out_addr_3, exp_out_addr_2, exp_out_addr_1, exp_out_addr_0};
```

## mychecker.sv 修复

### 问题识别

**原代码错误**:
```systemverilog
// ❌ 使用了不存在的字段
offwbf_tr.instruction_index  // offdec2nsu_transaction 没有这个字段!
offwbf_tr.nsu_ost_id         // 应该是 ost_id_nsu2offline
offwbf_tr.src_mem_addr       // 应该是 src_mem_addr_0[3] 组合
offwbf_tr.dec_fail_dest_addr // 应该是 dest_mem_addr_0[3] 组合
offwbf_tr.offwbf_start       // 应该是 offline_wbf_out_flag
```

### 修复后的代码

```systemverilog
task `CLASS_NAME_DEFINE::check_offwbf_cmd();
    offdec2nsu_transaction offwbf_tr;
    logic [31:0] src_mem_addr_32bit;
    logic [31:0] dest_mem_addr_32bit;
    
    forever begin
        offwbf_cmd_fifo.get(offwbf_tr);
        
        // ✓ 正确组合 32bit 地址
        src_mem_addr_32bit = {offwbf_tr.src_mem_addr_3, offwbf_tr.src_mem_addr_2, 
                              offwbf_tr.src_mem_addr_1, offwbf_tr.src_mem_addr_0};
        dest_mem_addr_32bit = {offwbf_tr.dest_mem_addr_3, offwbf_tr.dest_mem_addr_2, 
                               offwbf_tr.dest_mem_addr_1, offwbf_tr.dest_mem_addr_0};
        
        // ✓ 使用正确的字段名
        `uvm_info(get_type_name(), $sformatf(
            "Received OFFWBF_CMD: ost_id=%0h, src_addr=%0h, dest_addr=%0h, offline_wbf_out_flag=%0b", 
            offwbf_tr.ost_id_nsu2offline, src_mem_addr_32bit, dest_mem_addr_32bit, 
            offwbf_tr.offline_wbf_out_flag), UVM_LOW)
        
        // ✓ 通过 ost_id 匹配 (而不是 instruction_index)
        foreach (pending_config[instr_idx][gid]) begin
            cfg = pending_config[instr_idx][gid];
            
            if (cfg.nsu_ost_id == offwbf_tr.ost_id_nsu2offline) begin
                // 检查源地址
                if (cfg.dest_memory_addr != src_mem_addr_32bit) begin
                    status = CHECK_FAIL_DATA;
                end
                
                // 检查目标地址
                if (cfg.dec_fail_dest_addr != dest_mem_addr_32bit) begin
                    status = CHECK_FAIL_DATA;
                end
                
                // 检查 offline_wbf_out_flag
                if (!offwbf_tr.offline_wbf_out_flag) begin
                    status = CHECK_FAIL_DATA;
                end
                
                // 检查 read_mode
                if (cfg.read_mode != 1'b0) begin
                    status = CHECK_FAIL_DATA;
                end
            end
        end
    end
endtask
```

## 字段映射对照表

### offdec2nsu_transaction → group_check_config_t

| offdec2nsu_transaction | group_check_config_t | 匹配方式 |
|------------------------|---------------------|---------|
| `ost_id_nsu2offline` | `nsu_ost_id` | 直接比较 |
| `src_mem_addr_0[3]` (组合) | `dest_memory_addr` | 32bit 组合后比较 |
| `dest_mem_addr_0[3]` (组合) | `dec_fail_dest_addr` | 32bit 组合后比较 |
| `offline_wbf_out_flag` | `offline_wbf_work_en[gid]` | 标志位检查 |
| - | `read_mode` | read_mode 检查 (safe read) |

## 匹配逻辑变化

### 之前 (错误的设计)
```systemverilog
// ❌ 假设有 instruction_index
if (pending_instr_exists[offwbf_tr.instruction_index]) begin
    cfg = pending_config[offwbf_tr.instruction_index][gid];
    if (cfg.nsu_ost_id == offwbf_tr.nsu_ost_id) ...
```

### 之后 (正确的设计)
```systemverilog
// ✓ 遍历所有 pending 配置，通过 ost_id 匹配
foreach (pending_config[instr_idx][gid]) begin
    cfg = pending_config[instr_idx][gid];
    
    if (cfg.nsu_ost_id == offwbf_tr.ost_id_nsu2offline) begin
        matched_gid = gid;
        matched_instr_idx = instr_idx;
        // 进行检查...
    end
end
```

## 关键约束条件

### offline2nsu_cmd_assign
```systemverilog
constraint offline2nsu_cmd_assign {
    offline2nsu_cmd[0]  == {plane_num_in, ost_id_offline2nsu};
    offline2nsu_cmd[1]  == correct_num_lsb;
    offline2nsu_cmd[2]  == {4'b0000, offline_wbf_out_flag, write_pos_jdg, dec_suc, correct_num_msb};
    offline2nsu_cmd[3]  == meta_data_0;
    // ...
    offline2nsu_cmd[19] == act_out_addr_0;
    // ...
    offline2nsu_cmd[23] == exp_out_addr_0;
    // ...
}
```

### nsu2offline_cmd_assign
```systemverilog
constraint nsu2offline_cmd_assign {
    nsu2offline_cmd[0]  == {plane_num, ost_id_nsu2offline};
    nsu2offline_cmd[1]  == {4'b0000, dest_sel, flip_threshold_sel, over_threshold, descramble_en};
    nsu2offline_cmd[2]  == descramble_seed_0;
    nsu2offline_cmd[3]  == descramble_seed_1;
    nsu2offline_cmd[4]  == dest_mem_addr_0;
    // ...
    nsu2offline_cmd[8]  == src_mem_addr_0;
    // ...
}
```

## 检查流程

### check_offwbf_cmd 流程

1. **从 FIFO 获取 offwbf_tr**
   ```systemverilog
   offwbf_cmd_fifo.get(offwbf_tr);
   ```

2. **组合 32bit 地址**
   ```systemverilog
   src_mem_addr_32bit = {src_mem_addr_3, src_mem_addr_2, src_mem_addr_1, src_mem_addr_0};
   dest_mem_addr_32bit = {dest_mem_addr_3, dest_mem_addr_2, dest_mem_addr_1, dest_mem_addr_0};
   ```

3. **遍历 pending_config 查找匹配**
   ```systemverilog
   foreach (pending_config[instr_idx][gid]) begin
       if (cfg.nsu_ost_id == offwbf_tr.ost_id_nsu2offline) begin
           // 找到匹配
       end
   end
   ```

4. **执行检查**
   - OST ID 匹配 ✓
   - src_mem_addr 匹配 ✓
   - dest_mem_addr 匹配 ✓
   - offline_wbf_out_flag 检查 ✓
   - read_mode 检查 ✓

5. **清除已检查的配置**
   ```systemverilog
   if (matched_gid >= 0 && matched_instr_idx != 16'hFFFF) begin
       pending_config[matched_instr_idx][matched_gid].valid = 1'b0;
   end
   ```

## 与 ondec2nsu_transaction 的关系

### ondec2nsu_transaction 中的 offwbf 相关字段

```systemverilog
// ondec2nsu_transaction (CPU → NSU 的命令)
rand logic         data_out_en;
rand logic         offline_wbf_work_en;  // 标记需要 offwbf 操作
rand logic [31:0]  dest_memory_addr;     // 目标内存地址
rand logic [31:0]  dec_fail_dest_addr;   // 译码失败目标地址
rand logic         read_mode;            // 读模式
```

### offdec2nsu_transaction (OFFWBF → NSU 的响应)

```systemverilog
// offdec2nsu_transaction (OFFWBF → NSU 的响应)
rand logic [4:0]   ost_id_nsu2offline;   // OST ID
rand logic [7:0]   src_mem_addr_0[3];    // 源内存地址 (从 NSU 读取)
rand logic [7:0]   dest_mem_addr_0[3];   // 目标内存地址 (写入 NSU)
rand logic         offline_wbf_out_flag; // OFFWBF 完成标志
```

### 数据流

```
CPU → ondec2nsu_transaction → NSU → (判断需要 offwbf) → OFFWBF
                                                    ↓
offdec2nsu_transaction ← NSU ← OFFWBF (处理完成)
```

## 注意事项

### ⚠️ instruction_index 缺失

`offdec2nsu_transaction` **没有** `instruction_index` 字段，因此：
- 不能通过 instruction_index 直接索引 pending_config
- 必须遍历所有 pending_config，通过 ost_id 匹配

### ⚠️ 地址字段是 byte 数组

- `src_mem_addr_0[3]` 是 4 个 8bit 字段，需要组合成 32bit
- `dest_mem_addr_0[3]` 同理
- 不能直接访问 `src_mem_addr` 或 `dest_mem_addr`

### ⚠️ 字段命名差异

| ondec2nsu_transaction | offdec2nsu_transaction |
|----------------------|------------------------|
| `nsu_ost_id` | `ost_id_nsu2offline` |
| `dest_memory_addr` | `dest_mem_addr_0[3]` (组合) |
| `dec_fail_dest_addr` | `dest_mem_addr_0[3]` (组合) |
| `offline_wbf_work_en` | `offline_wbf_out_flag` |

## 编译验证

```bash
# 检查字段使用
grep -n "ost_id_nsu2offline\|offline_wbf_out_flag" mychecker.sv

# 检查地址组合
grep -n "src_mem_addr_32bit\|dest_mem_addr_32bit" mychecker.sv

# 验证没有使用错误的字段
grep -n "offwbf_tr\.instruction_index\|offwbf_tr\.nsu_ost_id" mychecker.sv
# 应该为空
```

## 总结

### ✅ 修复内容

1. **字段名称修正** - 使用 `ost_id_nsu2offline` 而不是 `nsu_ost_id`
2. **地址组合** - 将 4 个 8bit 字段组合成 32bit 地址
3. **标志位修正** - 使用 `offline_wbf_out_flag` 而不是 `offwbf_start`
4. **匹配逻辑** - 通过 ost_id 遍历匹配，而不是通过 instruction_index 索引

### ✅ 保持的功能

1. **Group 独立检查** - 每个 group 独立匹配 ost_id
2. **地址检查** - src_mem_addr 和 dest_mem_addr 检查
3. **模式检查** - offwbf 只在 safe read 模式下调用
4. **配置清除** - 检查完成后清除 pending_config

### 📝 下一步

1. **验证编译** - 确保没有语法错误
2. **运行测试** - 验证 offwbf 检查逻辑正确
3. **添加覆盖率** - 覆盖 offwbf 相关场景
