# UVM环境搭建与脚本执行指南

## 一、UVM环境搭建

### 1. 项目结构
创建了包含以下文件的demo：
- `nsu_script_test.sv` - UVM测试文件，实现了在final_phase执行shell脚本的功能
- `run_analysis.sh` - 简单的分析脚本，显示当前日期和目录信息
- `nsu_script_tb.sv` - 测试平台，启动UVM测试

### 2. 实现功能
- 在UVM测试的final_phase中使用`$system`函数执行shell脚本
- 检查脚本执行状态并打印相应消息
- 脚本执行成功后显示分析完成消息

## 二、关闭UVM打印消息的方法

### 1. 方法1：使用UVM命令行选项
在运行仿真时添加以下命令行选项，设置特定组件的verbosity级别：
```
+uvm_set_verbosity=uvm_test_top.env.axi_env.axi_system_env.master[0].sequencer,UVM_NONE
```

### 2. 方法2：在测试代码中添加消息过滤
在测试的build_phase中添加：
```systemverilog
uvm_report_server::get_server().set_id_verbosity("body", UVM_NONE, "uvm_test_top.env.axi_env.axi_system_env.master[0].sequencer");
```

### 3. 方法3：修改序列代码
如果能找到`axi_reg_access_sequence`的定义文件，可以直接注释掉或修改打印语句，将`uvm_info`改为更低的verbosity级别。

### 4. 方法4：全局verbosity控制
如果要关闭所有非关键消息，可以使用：
```
+UVM_VERBOSITY=UVM_WARNING
```

## 三、使用说明
1. 编译UVM测试：`vcs -sverilog -full64 nsu_script_tb.sv /mnt/disk_0/IC/uvm-1.2/src/uvm_pkg.sv /mnt/disk_0/IC/uvm-1.2/src/dpi/uvm_dpi.cc +incdir+/mnt/disk_0/IC/uvm-1.2/src -timescale=1ns/1ns -CFLAGS -DVCS -l compile.log`
2. 运行仿真：`./simv -l sim.log`
3. 查看结果：仿真结束后，会在终端看到shell脚本的执行输出

## 四、注意事项
- 确保shell脚本有执行权限：`chmod +x run_analysis.sh`
- 确保UVM库路径正确设置
- 根据实际需要修改shell脚本的内容和UVM测试的逻辑
