# IC Basic 学习指南

> 好好学习 UVM 📚

本目录是集成电路（IC）验证学习的基础资源库，涵盖从 Verilog/SystemVerilog 基础到 UVM 验证方法学的完整学习路径。

---

## 📁 目录结构

```
basic/
├── archive/          # 归档文件（历史资料）
├── post_sim/         # 后仿真相关资料
├── sva/              # SystemVerilog Assertions（断言）
├── systemverilog/    # SystemVerilog 语言基础
├── tasks/            # 练习任务与挑战
├── uvm/              # UVM 验证方法学（核心重点）
├── vcs_basic/        # VCS 仿真工具使用基础
└── vip/              # Verification IP（验证 IP）
    ├── spi/          # SPI 协议 VIP
    ├── uart/         # UART 协议 VIP
    └── ...
```

---

## 🎯 推荐学习路径

### 阶段 1：基础入门（1-2 周）
1. **SystemVerilog 基础** → `systemverilog/`
   - 数据类型、过程块、任务与函数
   - 面向对象编程（类、继承、多态）
   - 随机化与约束

2. **仿真工具使用** → `vcs_basic/`
   - VCS 编译与仿真流程
   - 波形查看与调试
   - Makefile 编写

### 阶段 2：协议与 VIP（2-3 周）
1. **UART VIP** → `vip/uart/`
   - UART 协议基础
   - Verilog UART 核心（`verilog-uart/`）
   - UVM UART Testbench（`tb_uart_svt_uvm_basic_sys/`）

2. **SPI VIP** → `vip/spi/`
   - SPI 协议基础
   - UVM SPI Testbench（`tb_spi_svt_uvm_basic_1m_1s_sys/`）

### 阶段 3：UVM 核心（4-6 周）⭐
1. **UVM 基础** → `uvm/`
   - UVM 架构（Factory、Registry、Phasing）
   - Component（Driver、Monitor、Sequencer、Agent）
   - Transaction Level Modeling (TLM)
   - Sequence 与 Sequencer

2. **UVM 工具与实践** → `uvm/uvm_tools/`
   - 实际测试案例
   - 覆盖率收集与分析
   - 回归测试流程

### 阶段 4：进阶主题
1. **SVA 断言** → `sva/`
   - 即时断言与并发断言
   - 属性编写与覆盖
   - 断言在验证中的应用

2. **后仿真** → `post_sim/`
   - 门级仿真
   - 时序反标
   - 功耗分析基础

---

## 📦 VIP 测试用例说明

### UART VIP 测试
| 测试文件 | 描述 |
|---------|------|
| `ts.base_test.sv` | 基础测试（默认 sequence） |
| `ts.directed_test.sv` | 定向测试（指定 sequence） |
| `ts.random_test.sv` | 随机测试 |
| `ts.reconfig_test.sv` | 可配置测试 |

**运行方式：**
```bash
# 使用 Makefile
gmake USE_SIMULATOR=vcsvlog directed_test WAVES=1

# 或使用脚本
./run_uart_svt_uvm_basic_sys -w random_test vcsvlog-svlog
```

### SPI VIP 测试
| 测试类型 | 描述 |
|---------|------|
| Base Test | 基础随机测试 |
| Master TX/RX | 主设备发送/接收 |
| EEPROM Mode | EEPROM 模式测试 |
| Reset Test | 复位测试 |
| Exception Tests | 异常场景测试 |

**运行方式：**
```bash
gmake USE_SIMULATOR=vcsvlog base_test WAVES=1
```

---

## 🔧 环境配置

### 必要工具
- **Synopsys VCS** - 仿真器
- **Verdi** - 波形查看与调试
- **DesignWare VIP** - Synopsys 验证 IP

### 环境变量
```bash
export DESIGNWARE_HOME=/path/to/designware
export VCS_HOME=/path/to/vcs
```

### 安装 VIP 示例
```bash
cd <目标目录>
mkdir design_dir
$DESIGNWARE_HOME/bin/dw_vip_setup -path ./design_dir -e uart_svt/tb_uart_svt_uvm_basic_sys -svtb
```

---

## 📚 参考文档

### 官方文档
- UVM Class Reference: `$DESIGNWARE_HOME/vip/svt/uart_svt/latest/doc/uart_svt_uvm_class_reference/`
- UVM User Guide: `$DESIGNWARE_HOME/vip/svt/uart_svt/latest/doc/uart_svt_uvm_user_guide.pdf`
- SPI VIP Class Reference: `$DESIGNWARE_HOME/vip/svt/spi_svt/latest/doc/spi_svt_uvm_class_reference/`

### 外部资源
- [UVM 1.2 LRM](https://accellera.org/)
- [Verification Academy](https://verificationacademy.com/)
- [Cocotb (开源验证框架)](https://www.cocotb.org/)

---

## 💡 学习建议

1. **动手优先** - 不要只读代码，跑仿真、看波形、改参数
2. **从小做起** - 先跑通 base_test，再尝试修改和扩展
3. **理解架构** - UVM 的核心是架构思想，不是语法
4. **善用波形** - Verdi 是你最好的老师
5. **记录问题** - 遇到问题记下来，解决后整理成笔记

---

## 📝 待办事项

- [ ] 完成 UART VIP 所有测试用例
- [ ] 理解 UVM Factory 机制
- [ ] 编写自定义 Sequence
- [ ] 学习覆盖率驱动验证
- [ ] 尝试 submodule_ibex 的验证

---

## 📞 支持

遇到问题？
1. 先查官方文档
2. 搜索错误信息
3. 查看 `uvm_lib/` 中的参考实现
4. 联系 Synopsys 支持中心

---

> **最后提醒：** 验证是 IC 设计中最重要也最耗时的环节。UVM 不是银弹，但它是行业标准。学好它，你的职业生涯会轻松很多。

_Good luck with your verification journey! 🚀_
