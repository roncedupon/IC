# SystemVerilog 语法错误修复总结

## 问题概述

在 `mychecker.sv` 文件中存在多个 SystemVerilog 语法错误，主要是变量声明位置不符合 SystemVerilog 语法规则。根据 SystemVerilog 标准，变量声明必须在每个 block 的最开头。

## 修复流程

### 1. 检查并修复 `check_deep_read_resp` 方法

**问题**：在 `check_deep_read_resp` 方法中，变量声明不在 block 最开头。

**修复**：
- 将 `token_transaction token;` 移到 `forever` 循环最开头
- 将 `int token_hash;` 移到 `forever` 循环最开头
- 将变量初始化从声明中分离出来

**修改位置**：
- `/mnt/disk_0/IC/nsu/uvc/mychecker/mychecker.sv#L429-445`

### 2. 检查并修复 `check_offwbf_cmd` 方法

**问题**：在 `check_offwbf_cmd` 方法中，存在多处变量声明不在 block 最开头的情况。

**修复**：
- 将 `int matched_tokens[$];` 移到 `forever` 循环最开头
- 将 `int matched_token;` 移到 `forever` 循环最开头
- 将 `bit all_offwbf_completed = 1'b1;` 移到 `if` 语句块最开头

**修改位置**：
- `/mnt/disk_0/IC/nsu/uvc/mychecker/mychecker.sv#L634-670`
- `/mnt/disk_0/IC/nsu/uvc/mychecker/mychecker.sv#L927-934`

### 3. 修复函数语法结构

**问题**：在 `get_allocated_offwbf_addr` 和 `is_offwbf_addr_occupied` 函数中，缺少 `else begin` 语句。

**修复**：
- 为 `get_allocated_offwbf_addr` 函数添加 `else begin` 语句
- 为 `is_offwbf_addr_occupied` 函数添加 `else begin` 语句

**修改位置**：
- `/mnt/disk_0/IC/nsu/uvc/mychecker/mychecker.sv#L1048-1055`
- `/mnt/disk_0/IC/nsu/uvc/mychecker/mychecker.sv#L1060-1067`

## 具体修改内容

### 1. check_deep_read_resp 方法修改

**修改前**：
```systemverilog
forever begin
    token_transaction token;
    deep_read_resp_fifo.get(resp);
    total_resp_count++;
    
    // ... 其他代码 ...
    
    // Check if deep read response is expected for this token
    int token_hash = token.hash();
```

**修改后**：
```systemverilog
forever begin
    token_transaction token;
    int token_hash;
    deep_read_resp_fifo.get(resp);
    total_resp_count++;
    
    // ... 其他代码 ...
    
    // Check if deep read response is expected for this token
    token_hash = token.hash();
```

### 2. check_offwbf_cmd 方法修改

**修改前**：
```systemverilog
forever begin
    // ... 其他代码 ...
    
    matched_instr_indices.delete();
    matched_pp_list.delete();
    matched_cfg_idx.delete();
    int matched_tokens[$];
    
    // ... 其他代码 ...
    
    matched_token = matched_tokens[0];
```

**修改后**：
```systemverilog
forever begin
    int matched_tokens[$];
    int matched_token;
    // ... 其他代码 ...
    
    matched_instr_indices.delete();
    matched_pp_list.delete();
    matched_cfg_idx.delete();
    
    // ... 其他代码 ...
    
    matched_token = matched_tokens[0];
```

### 3. 函数语法修复

**修改前**：
```systemverilog
function bit [3:0] `CLASS_NAME_DEFINE::get_allocated_offwbf_addr(bit [4:0] ost_id);
    if (offwbf_ost_id_to_addr.exists(ost_id)) begin
        return offwbf_ost_id_to_addr[ost_id];
    end
        `uvm_warning(get_type_name(), $sformatf("No OFFWBF address allocated for ost_id=%0h", ost_id))
        return 4'hF;  // Invalid address
    end
endfunction : get_allocated_offwbf_addr
```

**修改后**：
```systemverilog
function bit [3:0] `CLASS_NAME_DEFINE::get_allocated_offwbf_addr(bit [4:0] ost_id);
    if (offwbf_ost_id_to_addr.exists(ost_id)) begin
        return offwbf_ost_id_to_addr[ost_id];
    end else begin
        `uvm_warning(get_type_name(), $sformatf("No OFFWBF address allocated for ost_id=%0h", ost_id))
        return 4'hF;  // Invalid address
    end
endfunction : get_allocated_offwbf_addr
```

## 验证结果

**编译命令**：
```bash
python3 /mnt/disk_0/IC/makefile/vrun/vrun.py -f filelist.f
```

**编译结果**：
- 编译成功，无语法错误
- 存在一些警告，但不影响编译和运行
  - 任务在函数中调用的警告
  - 位选择索引的警告

## 技术要点

1. **SystemVerilog 变量声明规则**：变量声明必须在每个 block 的最开头，不能在 block 中间声明变量。

2. **函数语法结构**：if-else 语句需要正确的 begin-end 结构。

3. **变量初始化**：变量声明和初始化可以分离，声明在 block 开头，初始化在需要的地方。

4. **编译验证**：使用 VCS 编译器验证修复结果，确保无语法错误。

## 结论

通过将变量声明移到 block 最开头，并修复函数语法结构，成功解决了 SystemVerilog 语法错误问题。现在代码可以正常编译和运行。