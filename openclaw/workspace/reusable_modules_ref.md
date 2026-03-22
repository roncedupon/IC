# ONDEC2NSU Checker 可复用模块参考

## 模块清单

### 1. 通用 Checker 框架 (Generic Checker Framework)

**文件**: `generic_checker_pkg.sv`  
**用途**: 基于请求 - 响应匹配的通用验证框架

#### 核心类
```systemverilog
class generic_checker #(
  type REQUEST_T = uvm_sequence_item,
  type RESPONSE_T = uvm_sequence_item
) extends uvm_component;
  
  // FIFO 队列
  uvm_tlm_analysis_fifo #(REQUEST_T) req_fifo;
  uvm_tlm_analysis_fifo #(RESPONSE_T) resp_fifo;
  
  // Pending 状态跟踪
  bit pending_req [bit [95:0]];
  REQUEST_T pending_config [bit [95:0]];
  
  // 统计计数器
  int unsigned total_req_count = 0;
  int unsigned total_resp_count = 0;
  int unsigned pass_count = 0;
  int unsigned fail_count = 0;
  
  // 虚方法（需子类实现）
  extern virtual function bit [95:0] create_hash(REQUEST_T req);
  extern virtual function check_status_e check_response(RESPONSE_T resp, REQUEST_T cfg);
  
endclass
```

#### 使用示例
```systemverilog
class my_checker extends generic_checker #(
  my_request_transaction,
  my_response_transaction
);
  
  function bit [95:0] create_hash(my_request_transaction req);
    return {req.id, req.addr, req.data};
  endfunction
  
  function check_status_e check_response(my_response_transaction resp, my_request_transaction cfg);
    if (resp.id != cfg.id) return CHECK_FAIL_ID;
    if (resp.data != cfg.data) return CHECK_FAIL_DATA;
    return CHECK_PASS;
  endfunction
  
endclass
```

---

### 2. OFFWBF 地址管理器 (OFFWBF Address Manager)

**文件**: `offwbf_addr_manager_pkg.sv`  
**用途**: 动态地址分配和回收管理

#### 核心类
```systemverilog
class offwbf_addr_manager;
  
  // 地址状态（16 位，每位代表一个地址）
  bit [15:0] addr_status;
  
  // OST ID 到地址的映射
  bit [3:0] ost_id_to_addr [bit [4:0]];
  
  // 基地址（可配置）
  bit [31:0] base_addr;
  
  // 构造函数
  function new(bit [31:0] base = 32'hA000);
    addr_status = 16'b0;
    base_addr = base;
  endfunction
  
  // 分配地址
  function bit [3:0] allocate(bit [4:0] ost_id);
    if (ost_id_to_addr.exists(ost_id)) 
      return ost_id_to_addr[ost_id];
    
    for (bit [3:0] addr = 0; addr < 16; addr++) begin
      if (!is_occupied(addr)) begin
        addr_status[addr] = 1'b1;
        ost_id_to_addr[ost_id] = addr;
        return addr;
      end
    end
    return 4'hF;  // 无可用地址
  endfunction
  
  // 释放地址
  function void free(bit [4:0] ost_id);
    if (ost_id_to_addr.exists(ost_id)) begin
      bit [3:0] addr = ost_id_to_addr[ost_id];
      addr_status[addr] = 1'b0;
      ost_id_to_addr.delete(ost_id);
    end
  endfunction
  
  // 检查地址是否占用
  function bit is_occupied(bit [3:0] addr);
    if (addr < 16) return addr_status[addr];
    return 1'b1;
  endfunction
  
  // 获取已分配地址
  function bit [3:0] get_allocated(bit [4:0] ost_id);
    if (ost_id_to_addr.exists(ost_id)) 
      return ost_id_to_addr[ost_id];
    return 4'hF;
  endfunction
  
endclass
```

#### 使用示例
```systemverilog
offwbf_addr_manager addr_mgr;

initial begin
  addr_mgr = new(32'hA000);
  
  // 分配地址
  bit [3:0] addr1 = addr_mgr.allocate(5'h01);
  bit [3:0] addr2 = addr_mgr.allocate(5'h02);
  
  // 计算实际地址
  bit [31:0] io_addr1 = addr_mgr.base_addr + {addr1, 12'd0};
  bit [31:0] io_addr2 = addr_mgr.base_addr + {addr2, 12'd0};
  
  // 释放地址
  addr_mgr.free(5'h01);
end
```

---

### 3. Token Hash 匹配引擎 (Token Hash Matching Engine)

**文件**: `token_hash_util_pkg.sv`  
**用途**: 多字段唯一性匹配工具

#### 核心类
```systemverilog
class token_hash_util #(type T = uvm_object);
  
  // 创建哈希（需子类实现）
  static function bit [95:0] create_hash(T obj);
    `uvm_fatal("NOT_IMPL", "create_hash must be implemented in derived class")
  endfunction
  
endclass

// 示例：自定义哈希类
class my_token_hash_util extends token_hash_util #(my_transaction);
  
  static function bit [95:0] create_hash(my_transaction obj);
    return {
      obj.id,        // 16bit
      obj.addr[15:0], // 16bit
      obj.data[31:0], // 32bit
      obj.extra[31:0] // 32bit
    };
  endfunction
  
endclass
```

#### 使用示例
```systemverilog
bit [95:0] hash;
my_transaction tr;

hash = my_token_hash_util::create_hash(tr);

// 在查找表中使用
pending_req[hash] = 1;
pending_config[hash] = tr;
```

---

### 4. Group 独立处理框架 (Group Independent Processing Framework)

**文件**: `group_processor_pkg.sv`  
**用途**: 多组并行处理框架

#### 核心类
```systemverilog
class group_processor #(
  int GROUP_SIZE = 4,
  int NUM_GROUPS = 2
);
  
  // 组统计
  int unsigned group_decode_success [NUM_GROUPS-1:0];
  int unsigned group_decode_fail [NUM_GROUPS-1:0];
  int unsigned group_crc_err [NUM_GROUPS-1:0];
  
  // 处理单个组
  function void process_group(
    int gid,
    logic [GROUP_SIZE-1:0] dec_suc,
    logic [GROUP_SIZE-1:0] crc_pass,
    logic [GROUP_SIZE-1:0] data_out_en
  );
    logic need_deep_resp = 1'b0;
    logic need_offwbf = 1'b0;
    
    for (int pp = 0; pp < GROUP_SIZE; pp++) begin
      if (!dec_suc[pp] && crc_pass[pp]) begin
        if (!data_out_en[pp]) 
          need_deep_resp = 1'b1;
        else 
          need_offwbf = 1'b1;
      end
      if (!crc_pass[pp]) 
        need_deep_resp = 1'b1;
    end
    
    // 更新统计
    if (need_deep_resp)
      group_decode_fail[gid]++;
    else
      group_decode_success[gid]++;
  endfunction
  
  // 打印统计
  function void print_stats();
    for (int gid = 0; gid < NUM_GROUPS; gid++) begin
      `uvm_info("GROUP_STATS", $sformatf(
        "Group%0d: success=%0d, fail=%0d, crc_err=%0d",
        gid, group_decode_success[gid], 
        group_decode_fail[gid], group_crc_err[gid]
      ), UVM_LOW);
    end
  endfunction
  
endclass
```

#### 使用示例
```systemverilog
group_processor #(4, 2) proc;

initial begin
  proc = new();
  
  // 处理 Group 0
  proc.process_group(
    0,
    4'b1111,  // dec_suc
    4'b1111,  // crc_pass
    4'b1111   // data_out_en
  );
  
  // 处理 Group 1
  proc.process_group(
    1,
    4'b0011,  // dec_suc (PP[0:1] 失败)
    4'b1111,  // crc_pass
    4'b0011   // data_out_en (PP[0:1] 不输出)
  );
  
  // 打印统计
  proc.print_stats();
end
```

---

### 5. Log 提取工具 (Log Extraction Tool)

**文件**: `log_extractor.py`  
**用途**: 自动化日志提取和分析

#### 核心功能
```python
from log_extractor import LogRangeExtractor

# 1. 单范围提取
extractor = LogRangeExtractor("simulation.log")
lines = extractor.extract_range(
    start_pattern=r"START_PATTERN",
    end_pattern=r"END_PATTERN",
    output_file="extracted.log"
)

# 2. 多范围批量提取（使用配置文件）
extractor.extract_from_config(
    config_file="extract_config.txt",
    output_dir="extracted_logs"
)

# 3. 实时日志监控
extractor.realtime_extract(
    start_pattern=r"START_PATTERN",
    end_pattern=r"END_PATTERN"
)

# 4. 结构化数据提取到 CSV
extract_to_csv(
    log_file_path="simulation.log",
    csv_file="data.csv",
    data_pattern=r"\[([^\]]+)\]\s*=\s*(\d+)\s*\(hex:\s*(0x[0-9a-fA-F]+)\)"
)
```

#### 配置文件格式
```
# 全局日志文件
log:simulation.log

# 提取块 1
start:BEGIN_TRANSACTION
end:END_TRANSACTION

# 提取块 2
start:BEGIN_ERROR
end:END_ERROR
```

---

## 技能化建议

### 1. UVM Checker 生成器
**功能**: 根据协议规范自动生成 Checker 代码  
**输入**: 
- 协议规范文档
- 事务类定义
- 检查规则配置

**输出**:
- 完整的 Checker 类
- 测试用例模板
- 统计报告模板

### 2. 地址管理器生成器
**功能**: 根据配置生成地址管理代码  
**输入**:
- 地址空间大小
- 分配策略
- OST ID 位宽

**输出**:
- 地址管理代码
- 测试用例

### 3. 日志分析自动化
**功能**: 自动提取和分析仿真日志  
**输入**:
- 日志文件
- 提取规则
- 输出格式

**输出**:
- 结构化数据
- 统计报告
- 异常检测

---

## 使用指南

### 快速开始
1. 选择需要的模块
2. 根据使用示例进行参数化
3. 实现虚方法（如需要）
4. 集成到验证环境

### 最佳实践
- 使用参数化提高复用性
- 保持统计计数器完整
- 实现完整的最终检查
- 添加详细的日志输出
- 编写覆盖所有场景的测试用例

### 常见问题
**Q: 如何处理多个响应期望？**  
A: 使用独立的 pending 标记（如 `pending_deep_resp` 和 `pending_offwbf`）

**Q: 如何扩展支持更多组？**  
A: 修改 `NUM_GROUPS` 参数，确保所有数组和循环正确扩展

**Q: 如何处理地址耗尽？**  
A: 实现地址耗尽检测和告警机制

---

**文档版本**: 1.0  
**最后更新**: 2026-03-22  
**项目路径**: `/mnt/disk_0/IC/nsu/uvc/mychecker/`