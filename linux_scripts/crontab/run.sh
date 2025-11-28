#!/bin/bash
# 启用 alias 展开
shopt -s expand_aliases

# 加载 bashrc（或其他环境）
source ~/.bashrc

# 切换目录
cd /mnt/disk_0/IC/basic/systemverilog/sv_basic/1_virtual_extend || exit 1

# 执行命令
vrun -top example1.sv >> /tmp/vrun.log 2>&1
