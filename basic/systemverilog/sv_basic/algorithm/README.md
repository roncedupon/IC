# SystemVerilog 算法模块 - Verilator 编译仿真指南

本目录包含 SystemVerilog 算法实现示例，本文档详细记录使用 Verilator 进行编译仿真的完整过程。

## 目录结构

```
algorithm/
├── 20250806_ceil.sv     # 向上取整除法实现
├── sim_main.cpp         # Verilator C++ 测试入口
├── obj_dir/             # Verilator 编译输出目录
│   └── Vceiling_division # 可执行文件
├── ceil_sim             # Iverilog 编译输出
└── README.md            # 本文档
```

## 源文件说明

### 20250806_ceil.sv

实现两种向上取整除法：

1. **位操作实现** (`ceiling_division` 模块)
   - 使用右移和归约或运算实现
   - 适用于除数为 2 的幂次方的情况

2. **通用公式实现** (`ceil_fun` 函数)
   - 公式：`ceil(a/b) = (a-1)/b + 1`
   - 适用于任意除数

---

## Verilator 安装

### 方法一：从源码编译安装（推荐）

#### 1. 安装依赖

```bash
apt-get install -y git make autoconf g++ flex bison libfl2 libfl-dev help2man
```

#### 2. 克隆源码

```bash
cd /tmp
git clone https://github.com/verilator/verilator.git
cd verilator
```

#### 3. 切换到稳定版本

```bash
git checkout v5.030
```

#### 4. 配置

```bash
autoconf
./configure --prefix=/usr/local
```

#### 5. 编译

```bash
make -j$(nproc)
```

#### 6. 安装

```bash
make install
```

#### 7. 验证安装

```bash
verilator --version
# 输出: Verilator 5.030 2024-10-27 rev v5.030
```

### 方法二：包管理器安装

```bash
# Ubuntu/Debian
apt-get install -y verilator

# CentOS/RHEL
yum install -y verilator

# macOS
brew install verilator
```

---

## Verilator 编译仿真流程

### 步骤 1：编写 C++ 测试入口

Verilator 需要一个 C++ main 函数作为仿真入口。创建 `sim_main.cpp`：

```cpp
#include "verilated.h"
#include "Vceiling_division.h"
#include <iostream>

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    
    // 实例化模块
    Vceiling_division* top = new Vceiling_division;
    
    // 运行仿真 (initial 块在构造时执行)
    // 对于纯组合逻辑，实例化即可触发 initial 块
    
    // 结束
    delete top;
    
    std::cout << "Simulation completed" << std::endl;
    return 0;
}
```

### 步骤 2：编译 SystemVerilog 文件

```bash
# 基本编译命令
verilator --cc 20250806_ceil.sv \
          --top-module ceiling_division \
          --exe sim_main.cpp \
          --build \
          -j 0
```

**参数说明：**

| 参数 | 说明 |
|------|------|
| `--cc` | 生成 C++ 输出（非 SystemC） |
| `--top-module` | 指定顶层模块名称 |
| `--exe` | 生成可执行文件 |
| `--build` | 自动调用 make 编译 |
| `-j 0` | 使用系统所有 CPU 核心 |

### 步骤 3：处理编译警告

如果遇到位宽相关警告，可添加参数忽略：

```bash
verilator --cc 20250806_ceil.sv \
          --top-module ceiling_division \
          --exe sim_main.cpp \
          --build \
          -j 0 \
          -Wno-WIDTHTRUNC \
          -Wno-WIDTHEXPAND
```

**常用警告控制参数：**

| 参数 | 说明 |
|------|------|
| `-Wno-WIDTHTRUNC` | 忽略位宽截断警告 |
| `-Wno-WIDTHEXPAND` | 忽略位宽扩展警告 |
| `-Wno-lint` | 忽略所有 lint 警告 |
| `-Wno-fatal` | 警告不视为错误 |

### 步骤 4：运行仿真

```bash
cd obj_dir
./Vceiling_division
```

**输出：**
```
Simulation completed
```

---

## 完整编译脚本

创建 `run_verilator.sh`：

```bash
#!/bin/bash

# 清理旧的编译文件
rm -rf obj_dir

# Verilator 编译
verilator --cc 20250806_ceil.sv \
          --top-module ceiling_division \
          --exe sim_main.cpp \
          --build \
          -j 0 \
          -Wno-WIDTHTRUNC \
          -Wno-WIDTHEXPAND

# 检查编译结果
if [ -f "obj_dir/Vceiling_division" ]; then
    echo "Build successful!"
    echo "Running simulation..."
    cd obj_dir
    ./Vceiling_division
else
    echo "Build failed!"
    exit 1
fi
```

---

## Icarus Verilog 仿真（支持 $display）

Verilator 不支持 `$display` 等系统任务输出。如需查看打印信息，可使用 Icarus Verilog：

### 安装 Icarus Verilog

```bash
apt-get install -y iverilog
```

### 编译运行

```bash
# 编译
iverilog -g2012 -o ceil_sim 20250806_ceil.sv

# 运行仿真
vvp ceil_sim
```

### 输出示例

```
ceil_div(129) = 2 (应输出2)
ceil_div(128) = 1 (应输出1)
ceil_div(127) = 1 (应输出1)
ceil_div(255) = 2 (应输出2)
ceil_div(256) = 2 (应输出2)
ceil_div(257) = 3 (应输出3)
ceil(10/2) = 5
ceil(10/3) = 4
ceil(10/4) = 3
ceil(10/5) = 2
ceil(10/6) = 2
ceil(10/7) = 2
ceil(4/4) = 1
ceil(3/4) = 1
```

---

## Verilator vs Icarus Verilog 对比

| 特性 | Verilator | Icarus Verilog |
|------|-----------|----------------|
| 编译方式 | 转换为 C++ | 直接解释执行 |
| 仿真速度 | 极快 | 较慢 |
| $display 支持 | ❌ 不支持 | ✅ 支持 |
| 波形输出 | ✅ VCD/FST | ✅ VCD |
| 适用场景 | 大规模设计、性能仿真 | 功能验证、调试 |

---

## 常见问题

### 1. `undefined reference to 'main'`

**原因**：缺少 C++ main 函数入口

**解决**：添加 `--exe your_main.cpp` 参数，并提供 main 函数

### 2. `make: help2man: No such file or directory`

**原因**：缺少 help2man 工具

**解决**：
```bash
apt-get install -y help2man
```

### 3. 位宽警告导致编译失败

**原因**：Verilog 代码存在位宽不匹配

**解决**：
- 修复源码中的位宽问题
- 或使用 `-Wno-xxx` 参数忽略警告

### 4. Verilator 不输出 $display 内容

**原因**：Verilator 不支持不可综合的系统任务

**解决**：
- 使用 Icarus Verilog 进行功能验证
- 或在 C++ 中添加打印语句

---

## 参考资源

- [Verilator 官方文档](https://verilator.org/guide/latest/)
- [Verilator GitHub](https://github.com/verilator/verilator)
- [Icarus Verilog 官网](http://iverilog.icarus.com/)
- [SystemVerilog IEEE 1800 标准](https://ieeexplore.ieee.org/document/8299595)

---

## 更新日志

| 日期 | 内容 |
|------|------|
| 2025-02-25 | 初版创建，记录 Verilator 编译仿真流程 |
