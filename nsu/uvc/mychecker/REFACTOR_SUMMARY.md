# mychecker.sv 重构总结

## 重构日期
2026-03-10

## 重构目标
对 `check_offwbf_cmd` task 进行重构，实现基于 `descramble_seed` 的匹配逻辑，并处理多匹配情况。

## 重构步骤

### 第一步：获取有效的 ondec_group_cmd 对象
- 从测试环境或相关接口中获取一个有效的 `offwbf_cmd` 对象
- 确保其包含完整的命令信息和必要参数
- 组合 32bit 地址和 16bit `descramble_seed`

### 第二步：基于 descramble_seed 的严格匹配
- 根据 `offwbf_cmd` 中的 `descramble_seed` 值，在 `pending_config` 中查找匹配的 `ondec_group_cmd`
- 实现严格的匹配逻辑，确保 `descramble_seed` 值完全一致
- 遍历所有 pending 的 `instruction_index` 和 8 个 `plane_pair`
- 只匹配满足以下条件的 plane_pair：
  - `plane_sel = 1` (已选择)
  - `offline_wbf_work_en = 1` (需要 offwbf)
  - `descramble_en = 1` (descramble 使能)
  - `descramble_seed` 完全匹配

### 第三步：多匹配检测与处理
- 如果检测到**多个** `offwbf_cmd` 对象的 `descramble_seed` 与目标值匹配：
  - 通过 `uvm_warning` 输出明确的警告信息
  - 警告内容包括：
    - `descramble_seed` 值
    - 匹配数量
    - 所有匹配的指令信息（instr_idx, PP 编号）
  - 说明当前系统**不支持**多个匹配的 offwbf_cmd 情况
  - **仅处理第一个匹配项**

### 第四步：全面检查（唯一匹配或第一个匹配）
对成功匹配的 `offwbf_cmd` 按照项目标准流程进行全面检查：

1. **offline_wbf_out_flag** 标志检查
2. **plane_num** 匹配检查（与 global plane 索引对应）
3. **dest_sel** 检查（与 ondec.write_pos_jdg 对应）
4. **flip_threshold_sel** 检查
5. **over_threshold** 检查（与 ondec.syn_weight_over_threshold 对应）
6. **descramble_en** 检查
7. **descramble_seed** 二次确认
8. **src_mem_addr** 检查（与 ondec.dest_memory_addr 对应）
9. **dest_mem_addr** 检查（与 ondec.dec_fail_dest_addr 对应）
10. **read_mode** 检查（offwbf 只在 safe read 模式下调用）

### 第五步：结果报告与状态更新
- 报告检查结果（PASS/FAIL）
- 更新统计计数器
- 清除已处理的 plane_pair 的 `offline_wbf_work_en` 标志
- 如果该 instruction_index 没有未处理的 offwbf 请求，清除整个配置

## 主要变更

### 新增变量
```systemverilog
int matched_pp_list [$];    // 存储所有匹配的 plane_pair 索引
int matched_cfg_idx [$];    // 存储所有匹配的 config 索引
```

### 新增日志
- 详细的匹配搜索过程日志
- 每个 candidate 的跳过原因说明
- 匹配成功时的详细信息
- 多匹配警告信息（uvm_warning）
- 全面检查的每个步骤日志

### 匹配逻辑变更
**原逻辑**：通过 plane_num 和地址直接匹配
**新逻辑**：
1. 首先基于 `descramble_seed` 进行严格匹配
2. 收集所有匹配项
3. 检测多匹配情况并发出警告
4. 只处理第一个匹配项

## 文件变更
- **文件路径**: `/mnt/disk_0/IC/nsu/uvc/mychecker/mychecker.sv`
- **修改范围**: 行 469-890 (check_offwbf_cmd task)
- **备份文件**: `mychecker.sv.bak`

## 验证要点
1. 确保 `descramble_seed` 匹配逻辑正确
2. 验证多匹配警告机制正常工作
3. 确认所有检查项按顺序执行
4. 验证状态更新和清理逻辑正确

## 测试建议
1. 正常场景：唯一 descramble_seed 匹配
2. 异常场景 1：无 descramble_seed 匹配
3. 异常场景 2：多个 descramble_seed 匹配（验证警告）
4. 边界场景：descramble_en=0 的情况
