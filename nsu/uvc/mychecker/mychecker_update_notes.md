# mychecker.sv 更新说明

## 更新日期
2026-03-07

## 更新内容

### 1. 新增 8 个 ondec2nsu_transaction 输入队列

**修改位置**: `mychecker.sv` 第 73-86 行

```systemverilog
// 8 个 plane_pair 的 ondec2nsu_transaction 输入队列
uvm_tlm_analysis_fifo #(ondec2nsu_transaction) ondec_fifo [7:0];

// ondec_cmd FIFO - 输出：打包后的 ondec2nsu_group_transaction
uvm_tlm_analysis_fifo #(ondec2nsu_group_transaction) ondec_cmd_fifo;
```

**说明**:
- 新增 8 个独立的 FIFO 队列，分别对应 8 个 plane_pair
- 每个 FIFO 接收来自对应 plane_pair 的 `ondec2nsu_transaction`
- 原有的 `ondec_cmd_fifo` 改为输出 FIFO，用于输出打包后的 `ondec2nsu_group_transaction`

### 2. 新增 pack_ondec_transactions task

**修改位置**: `mychecker.sv` 第 531-619 行

**功能描述**:
1. 持续监控 8 个 `ondec_fifo` 队列
2. 根据 `instruction_index` 将相同 `instruction_index` 的 8 个 transaction 打包
3. 打包成 `ondec2nsu_group_transaction` 后送入 `ondec_cmd_fifo`

**打包策略**:
- 等待 8 个队列中都有 transaction（使用 `fork-join` 并行获取）
- 检查 8 个 transaction 的 `instruction_index` 是否相同
- 如果相同，打包成 `group_transaction` 并发送到 `ondec_cmd_fifo`
- 如果不同，报错并丢弃不匹配的 transaction

**工作流程**:
```
Plane Pair 0 → ondec_fifo[0] ┐
Plane Pair 1 → ondec_fifo[1] ├─→ pack_ondec_transactions() ─→ ondec_cmd_fifo
Plane Pair 2 → ondec_fifo[2] ├─→ (检查 instruction_index)
...
Plane Pair 7 → ondec_fifo[7] ┘
```

### 3. 更新 build_phase

**修改位置**: `mychecker.sv` 第 129-143 行

```systemverilog
virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // 初始化 8 个 plane_pair 的 FIFO
    for (int i = 0; i < 8; i++) begin
        ondec_fifo[i] = new($sformatf("ondec_fifo[%0d]", i), this);
    end
    
    ondec_cmd_fifo = new("ondec_cmd_fifo", this);
    deep_read_resp_fifo = new("deep_read_resp_fifo", this);
    offwbf_cmd_fifo = new("offwbf_cmd_fifo", this);
endfunction
```

### 4. 更新 run_phase

**修改位置**: `mychecker.sv` 第 145-155 行

```systemverilog
virtual task run_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "ondec2nsu_checker started (GROUP-BASED processing)", UVM_MEDIUM)
    
    fork
        pack_ondec_transactions();  // 新增：从 8 个队列打包 transaction
        check_ondec_cmd();      // 第一步：获取 ondec_cmd，按 group 判断
        check_deep_read_resp(); // 第二步：检查 deep read resp
        check_offwbf_cmd();     // 第三步：检查 offwbf 指令
    join
endtask
```

## 使用示例

### 在测试平台中使用

```systemverilog
class my_test extends uvm_test;
    ondec2nsu_checker checker;
    ondec2nsu_transaction ondec_tr;
    
    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        
        // 向 8 个 FIFO 写入 transaction
        for (int i = 0; i < 8; i++) begin
            ondec_tr = ondec2nsu_transaction::type_id::create($sformatf("tr_%0d", i));
            ondec_tr.instruction_index = 16'h0001;
            ondec_tr.plane_sel = 1'b1;
            ondec_tr.nsu_ost_id = 5'h01;
            // ... 设置其他字段
            
            checker.ondec_fifo[i].write(ondec_tr);
        end
        
        // pack_ondec_transactions 会自动打包并送入 ondec_cmd_fifo
        // check_ondec_cmd 会自动从 ondec_cmd_fifo 取出并处理
        
        #100ns;
        phase.drop_objection(this);
    endtask
endclass
```

## 注意事项

1. **instruction_index 一致性**: 8 个 plane_pair 的 transaction 必须具有相同的 `instruction_index`，否则会被丢弃并报错

2. **阻塞行为**: `pack_ondec_transactions` task 会阻塞直到 8 个队列都有 transaction

3. **并行处理**: 使用 `fork-join` 结构并行从 8 个队列获取 transaction，确保同时到达

4. **错误处理**: 如果检测到 `instruction_index` 不匹配，会：
   - 打印错误信息
   - 丢弃当前 8 个 transaction
   - 继续等待下一批 transaction

## 架构优势

1. **模块化**: 8 个独立的输入队列，便于扩展和维护
2. **自动化**: 自动打包，无需手动管理 group transaction
3. **错误检测**: 自动检测 instruction_index 不匹配的情况
4. **清晰的检查流程**: 
   - 第一步：打包 8 个 plane_pair transaction
   - 第二步：按 group 判断（Group 0: PP[0:3], Group 1: PP[4:7]）
   - 第三步：检查 deep read resp 和 offwbf cmd

## 相关文件

- `/mnt/disk_0/IC/nsu/uvc/mychecker/mychecker.sv` - 主 checker 文件
- `/mnt/disk_0/IC/nsu/uvc/mychecker/ondec2nsu_transaction.sv` - Transaction 定义
- `/mnt/disk_0/IC/nsu/uvc/mychecker/normal_resp_checker.sv` - Normal response checker（新增）
