# nsu_cpu_transactions.sv 字段更新总结

## 更新时间
2026-03-07

## nsu2cpu_deep_resp_transaction 字段变化

### 字段重命名

| 原字段名 | 新字段名 | 位宽 | 说明 |
|---------|---------|------|------|
| `mode_sel` | `read_mode` | 1 | 读模式 (0=safe, 1=fast) |
| `group0_dest_memory_addr` | `group_0_dest_memory_addr` | 32 | Group 0 目标内存地址 |
| `group1_dest_memory_addr` | `group_1_dest_memory_addr` | 32 | Group 1 目标内存地址 |

### dec_fail_dest_addr 改为独立字段

**原设计** (数组):
```systemverilog
rand bit [31:0] dec_fail_dest_addr [0:7];  // 8 个 plane_pair 的译码失败目标地址
```

**新设计** (独立字段):
```systemverilog
rand bit [31:0] dec_fail_dest_addr_0;
rand bit [31:0] dec_fail_dest_addr_1;
rand bit [31:0] dec_fail_dest_addr_2;
rand bit [31:0] dec_fail_dest_addr_3;
rand bit [31:0] dec_fail_dest_addr_4;
rand bit [31:0] dec_fail_dest_addr_5;
rand bit [31:0] dec_fail_dest_addr_6;
rand bit [31:0] dec_fail_dest_addr_7;
```

### 新增字段

```systemverilog
// Index 17-27: 新增 plane 纠错 bit 数和 empty 标志
rand bit [15:0] plane1_01bit;
rand bit [15:0] plane0_01bit;
rand bit [15:0] plane3_01bit;
rand bit [15:0] plane2_01bit;
// ... (plane4-plane15)

rand bit [4:0]  rsv2;
rand bit [8:0]  plane_pair3_alter_bit;
rand bit        plane7_empty;
rand bit        plane6_empty;
// ... (更多 plane 状态)
```

## mychecker.sv 修复状态

### ✅ 已修复

1. **read_mode 字段**
   ```systemverilog
   // 修复前
   if (cfg.read_mode != resp.mode_sel)  // ❌ 旧字段名
   
   // 修复后
   if (cfg.read_mode != resp.read_mode)  // ✓ 新字段名
   ```

2. **group_check_config_t 注释更新**
   ```systemverilog
   logic [31:0] dest_memory_addr;         // 对应 group_0_dest_memory_addr 等
   logic [31:0] dec_fail_dest_addr;       // 对应 dec_fail_dest_addr_0 等
   logic [15:0] plane_group_block_addr;   // 对应 group0_block_addr 等
   logic [11:0] page_addr_plane_group;    // 对应 page_address_plane_group_0 等
   ```

### ⚠️ 需要注意的地方

#### 1. dest_memory_addr 的访问

**问题**: `group_check_config_t` 中只有一个 `dest_memory_addr`，但 resp 中有两个独立字段。

**当前处理**: 
- Group 0 使用 `resp.group_0_dest_memory_addr`
- Group 1 使用 `resp.group_1_dest_memory_addr`

**建议**: 如果需要访问 dest_memory_addr，应该在 check_deep_read_resp 中添加临时变量：
```systemverilog
logic [31:0] resp_dest_addr;

if (gid == 0) begin
    resp_dest_addr = resp.group_0_dest_memory_addr;
end else begin
    resp_dest_addr = resp.group_1_dest_memory_addr;
end

// 然后比较
if (cfg.dest_memory_addr != resp_dest_addr) begin
    // ...
end
```

#### 2. dec_fail_dest_addr 的访问

**问题**: `group_check_config_t` 中只有一个 `dec_fail_dest_addr`，但 resp 中有 8 个独立字段。

**当前处理**: offwbf 检查中暂未使用这些字段。

**建议**: 如果需要检查，应该根据 plane_pair 索引选择对应的字段：
```systemverilog
logic [31:0] resp_dec_fail_addr;

case (pp_idx)
    0: resp_dec_fail_addr = resp.dec_fail_dest_addr_0;
    1: resp_dec_fail_addr = resp.dec_fail_dest_addr_1;
    2: resp_dec_fail_addr = resp.dec_fail_dest_addr_2;
    3: resp_dec_fail_addr = resp.dec_fail_dest_addr_3;
    4: resp_dec_fail_addr = resp.dec_fail_dest_addr_4;
    5: resp_dec_fail_addr = resp.dec_fail_dest_addr_5;
    6: resp_dec_fail_addr = resp.dec_fail_dest_addr_6;
    7: resp_dec_fail_addr = resp.dec_fail_dest_addr_7;
endcase
```

#### 3. page_address 的访问

**问题**: `group_check_config_t` 中只有一个 `page_addr_plane_group`，但 resp 中有两个独立字段。

**当前处理**: 暂未检查这些字段。

**建议**: 
```systemverilog
logic [11:0] resp_page_addr;

if (gid == 0) begin
    resp_page_addr = resp.page_address_plane_group_0;
end else begin
    resp_page_addr = resp.page_address_plane_group_1;
end
```

## mychecker_tb.sv 修复状态

### 需要更新的测试用例

测试平台中使用 deep_resp 的地方需要更新字段名：

```systemverilog
// 修复前
deep_resp.mode_sel = 1'b0;  // ❌ 旧字段名
deep_resp.group0_dest_memory_addr = 32'h1000_0000;  // ❌ 旧字段名

// 修复后
deep_resp.read_mode = 1'b0;  // ✓ 新字段名
deep_resp.group_0_dest_memory_addr = 32'h1000_0000;  // ✓ 新字段名
```

## 完整的字段映射表

### Group 0 (PP[0:3])

| group_check_config_t | nsu2cpu_deep_resp_transaction |
|---------------------|-------------------------------|
| `nsu_ost_id` | `group0_ost_id` |
| `dest_memory_addr` | `group_0_dest_memory_addr` |
| `plane_group_block_addr` | `group0_block_addr` |
| `page_addr_plane_group` | `page_address_plane_group_0` |
| `dec_fail_dest_addr` | `dec_fail_dest_addr_0` ~ `dec_fail_dest_addr_3` |

### Group 1 (PP[4:7])

| group_check_config_t | nsu2cpu_deep_resp_transaction |
|---------------------|-------------------------------|
| `nsu_ost_id` | `group1_ost_id` |
| `dest_memory_addr` | `group_1_dest_memory_addr` |
| `plane_group_block_addr` | `group1_block_addr` |
| `page_addr_plane_group` | `page_address_plane_group_1` |
| `dec_fail_dest_addr` | `dec_fail_dest_addr_4` ~ `dec_fail_dest_addr_7` |

## SystemVerilog 编码规范检查

### ✅ 符合规范

1. **变量定义在 block 开头** - 所有 task 的变量定义都在执行语句之前
2. **使用关联数组** - `pending_instr_exists [bit [15:0]]` 正确使用关联数组
3. **字段命名一致** - 使用 `read_mode` 与 spec 一致

### ⚠️ 需要注意

1. **数组 vs 独立字段** - `dec_fail_dest_addr` 从数组改为独立字段，访问方式需要调整
2. **Group 分离** - Group 0 和 Group 1 的字段完全独立，不能混用

## 下一步建议

1. **更新测试平台** - 将 mychecker_tb.sv 中的旧字段名改为新字段名
2. **添加地址检查** - 在 check_deep_read_resp 中添加 dest_memory_addr 和 dec_fail_dest_addr 的检查
3. **添加 page_addr 检查** - 如果需要，添加 page_address_plane_group 的检查
4. **更新文档** - 更新 README.md 中的字段说明

## 编译验证

```bash
# 检查旧字段名使用 (应该为空)
grep -n "\.mode_sel" mychecker.sv
grep -n "group0_dest_memory_addr" mychecker.sv  # 不带下划线

# 检查新字段名使用
grep -n "\.read_mode" mychecker.sv
grep -n "group_0_dest_memory_addr" mychecker.sv
grep -n "group_1_dest_memory_addr" mychecker.sv
```
