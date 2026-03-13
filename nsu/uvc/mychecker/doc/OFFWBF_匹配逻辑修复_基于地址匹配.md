# OFFWBF 匹配逻辑修复 - 基于地址匹配

## 更新时间
2026-03-07

## 架构理解修正

### ❌ 之前的错误理解

之前认为可以通过 `ost_id` 匹配 ondec2nsu 和 offdec2nsu transaction：
```systemverilog
// ❌ 错误：NSU 会重新生成 ost_id，两者不匹配
if (cfg.nsu_ost_id == offwbf_tr.ost_id_nsu2offline) begin
    // ...
end
```

### ✅ 正确的架构理解

**数据流关系**：
```
ONDEC (CPU) → ondec2nsu_transaction → NSU → (重新生成 ost_id) → OFFWBF
                                                    ↓
                                    offdec2nsu_transaction ← (返回 NSU)
```

**关键点**：
1. **NSU 是总控** - 接收 ondec cmd，处理后再分发给 OFFWBF
2. **OST_ID 重新生成** - NSU 会生成自己的内部 ost_id，与 ondec 的 ost_id 不同
3. **地址保持不变** - dest_memory_addr 和 dec_fail_dest_addr 在传递过程中保持一致

## 正确的匹配方式

### 通过地址匹配

**原理**：
- OFFWBF 从 NSU 指定的地址读取数据 → `src_mem_addr` 匹配 `dest_memory_addr`
- OFFWBF 将处理结果写入 NSU 指定的地址 → `dest_mem_addr` 匹配 `dec_fail_dest_addr`

**匹配条件**：
```systemverilog
if (cfg.dest_memory_addr == src_mem_addr_32bit && 
    cfg.dec_fail_dest_addr == dest_mem_addr_32bit) begin
    // 找到匹配的 transaction
    matched_gid = p_gid;
    matched_instr_idx = p_instr_idx;
end
```

### 地址映射关系

| ondec2nsu_transaction | offdec2nsu_transaction | 说明 |
|----------------------|------------------------|------|
| `dest_memory_addr` | `src_mem_addr_0[3]` (组合) | OFFWBF 从该地址读取数据 |
| `dec_fail_dest_addr` | `dest_mem_addr_0[3]` (组合) | OFFWBF 写入该地址 |

## 修复内容

### 1. 编译错误修复

**错误**：
```systemverilog
foreach (pending_config[instr_idx][gid]) begin
    bit [15:0] instr_idx;  // ❌ 变量在 foreach 之后定义
    int gid;
```

**修复**：
```systemverilog
task `CLASS_NAME_DEFINE::check_offwbf_cmd();
    // ✓ 变量在 task 开始处定义
    bit [15:0] p_instr_idx;
    int p_gid;
    // ...
    
    // ✓ foreach 循环中直接使用
    foreach (pending_config[p_instr_idx][p_gid]) begin
        cfg = pending_config[p_instr_idx][p_gid];
```

**SystemVerilog 规则**：
- 所有变量必须在 block 开始处声明
- foreach 循环变量也必须在使用前声明
- 不能像 C++ 那样在 for 循环中声明变量

### 2. 匹配逻辑修复

**之前 (通过 ost_id)**：
```systemverilog
// ❌ 错误：ost_id 不匹配
if (cfg.nsu_ost_id == offwbf_tr.ost_id_nsu2offline) begin
    // 检查地址...
end
```

**修复后 (通过地址)**：
```systemverilog
// ✓ 正确：通过地址匹配
if (cfg.dest_memory_addr == src_mem_addr_32bit && 
    cfg.dec_fail_dest_addr == dest_mem_addr_32bit) begin
    // 检查其他字段...
end
```

### 3. 检查流程

```systemverilog
task `CLASS_NAME_DEFINE::check_offwbf_cmd();
    offdec2nsu_transaction offwbf_tr;
    logic [31:0] src_mem_addr_32bit;
    logic [31:0] dest_mem_addr_32bit;
    
    forever begin
        offwbf_cmd_fifo.get(offwbf_tr);
        
        // 1. 组合 32bit 地址
        src_mem_addr_32bit = {offwbf_tr.src_mem_addr_3, offwbf_tr.src_mem_addr_2, 
                              offwbf_tr.src_mem_addr_1, offwbf_tr.src_mem_addr_0};
        dest_mem_addr_32bit = {offwbf_tr.dest_mem_addr_3, offwbf_tr.dest_mem_addr_2, 
                               offwbf_tr.dest_mem_addr_1, offwbf_tr.dest_mem_addr_0};
        
        // 2. 遍历 pending_config 查找地址匹配
        foreach (pending_config[p_instr_idx][p_gid]) begin
            cfg = pending_config[p_instr_idx][p_gid];
            
            if (!cfg.valid) continue;
            if (!cfg.offline_wbf_work_en[p_gid]) continue;
            
            // 3. 通过地址匹配 (而不是 ost_id)
            if (cfg.dest_memory_addr == src_mem_addr_32bit && 
                cfg.dec_fail_dest_addr == dest_mem_addr_32bit) begin
                
                matched_gid = p_gid;
                matched_instr_idx = p_instr_idx;
                
                // 4. 检查其他字段
                if (!offwbf_tr.offline_wbf_out_flag) begin
                    status = CHECK_FAIL_DATA;
                end
                
                if (cfg.read_mode != 1'b0) begin
                    status = CHECK_FAIL_DATA;
                end
                
                break;
            end
        end
        
        // 5. 报告结果并清除配置
        if (matched_gid >= 0) begin
            pending_config[matched_instr_idx][matched_gid].valid = 1'b0;
        end
    end
endtask
```

## 为什么不能用 ost_id 匹配

### NSU 的 ost_id 重映射

```
ONDEC 发送:
  instruction_index = 0x1234
  nsu_ost_id = 0x05
  dest_memory_addr = 0x1000_0000
  dec_fail_dest_addr = 0x2000_0000

NSU 内部处理:
  - 接收 ondec cmd
  - 生成内部 ost_id = 0x0A (可能与 ondec 的不同)
  - 保持地址不变

NSU 发送给 OFFWBF:
  ost_id_nsu2offline = 0x0A (NSU 生成的)
  src_mem_addr = 0x1000_0000 (保持不变)
  dest_mem_addr = 0x2000_0000 (保持不变)

OFFWBF 返回 NSU:
  ost_id_nsu2offline = 0x0A (与 NSU 发送的一致)
  src_mem_addr = 0x1000_0000
  dest_mem_addr = 0x2000_0000
  offline_wbf_out_flag = 1
```

**结论**：
- ondec 的 `nsu_ost_id` (0x05) ≠ offwbf 的 `ost_id_nsu2offline` (0x0A)
- 但是地址保持一致，可以通过地址匹配

## 地址匹配的优势

### ✅ 优势

1. **可靠性高** - 地址在 NSU 内部不会改变
2. **唯一性好** - 同一时刻不太可能有两个 transaction 使用相同的地址对
3. **符合硬件设计** - 地址是数据通路的标识符

### ⚠️ 注意事项

1. **地址对齐** - 确保地址是 256-bit 对齐的 (低 5 位为 0)
2. **地址复用** - 如果地址快速复用，可能需要额外的匹配条件
3. **多 group 场景** - 两个 group 可能有不同的地址，需要分别匹配

## 检查项目

### 必须检查的字段

| 检查项 | 匹配方式 | 说明 |
|-------|---------|------|
| src_mem_addr | 地址匹配 | offwbf 从该地址读取数据 |
| dest_mem_addr | 地址匹配 | offwbf 写入该地址 |
| offline_wbf_out_flag | 直接比较 | 必须为 1 |
| read_mode | 直接比较 | offwbf 只在 safe read 下调用 |

### 可选检查的字段

| 检查项 | 说明 |
|-------|------|
| ost_id | 仅用于日志，不用于匹配 |
| descramble_en | 解扰配置检查 |
| dest_sel | 目标选择检查 |

## 测试场景

### 场景 1: 正常 offwbf 流程

```systemverilog
// ondec2nsu (CPU → NSU)
ondec_tr.nsu_ost_id = 5'h05;
ondec_tr.dest_memory_addr = 32'h1000_0000;
ondec_tr.dec_fail_dest_addr = 32'h2000_0000;
ondec_tr.offline_wbf_work_en = 1'b1;
ondec_tr.read_mode = 1'b0;  // safe read

// offdec2nsu (OFFWBF → NSU)
offwbf_tr.ost_id_nsu2offline = 5'h0A;  // NSU 重新生成
offwbf_tr.src_mem_addr = 32'h1000_0000;  // 匹配 dest_memory_addr
offwbf_tr.dest_mem_addr = 32'h2000_0000;  // 匹配 dec_fail_dest_addr
offwbf_tr.offline_wbf_out_flag = 1'b1;

// 检查结果: ✓ PASS (地址匹配)
```

### 场景 2: 地址不匹配

```systemverilog
// ondec2nsu
ondec_tr.dest_memory_addr = 32'h1000_0000;
ondec_tr.dec_fail_dest_addr = 32'h2000_0000;

// offdec2nsu
offwbf_tr.src_mem_addr = 32'h3000_0000;  // ❌ 不匹配
offwbf_tr.dest_mem_addr = 32'h2000_0000;

// 检查结果: ✗ FAIL (src_mem_addr 不匹配)
```

### 场景 3: offline_wbf_out_flag 未置位

```systemverilog
// ondec2nsu
ondec_tr.offline_wbf_work_en = 1'b1;

// offdec2nsu
offwbf_tr.offline_wbf_out_flag = 1'b0;  // ❌ 应该为 1

// 检查结果: ✗ FAIL (offline_wbf_out_flag not asserted)
```

## 代码验证

```bash
# 检查地址匹配逻辑
grep -n "dest_memory_addr == src_mem_addr" mychecker.sv
grep -n "dec_fail_dest_addr == dest_mem_addr" mychecker.sv

# 检查没有使用 ost_id 匹配
grep -n "nsu_ost_id == offwbf_tr" mychecker.sv
# 应该为空

# 检查变量定义
grep -n "p_instr_idx\|p_gid" mychecker.sv
```

## 总结

### ✅ 修复内容

1. **编译错误** - 修复 foreach 循环变量定义
2. **匹配逻辑** - 从 ost_id 匹配改为地址匹配
3. **变量命名** - 使用 p_instr_idx/p_gid 避免冲突

### ✅ 架构理解

1. **NSU 是总控** - 重新生成 ost_id
2. **地址不变** - dest_memory_addr 和 dec_fail_dest_addr 保持不变
3. **独立关系** - ondec 和 offwbf 通过 NSU 连接，但 ost_id 独立

### 📝 下一步

1. **编译验证** - 确保没有语法错误
2. **功能测试** - 验证地址匹配逻辑正确
3. **边界测试** - 测试地址复用、多 group 等场景
