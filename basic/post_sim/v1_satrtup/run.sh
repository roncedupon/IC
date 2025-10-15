#!/bin/bash

# 清理
rm -rf simv* csrc ucli.key post_sim.fsdb verdiLog

# 编译
vcs -sverilog tb_top.v dff.v \
    +define+POST_SIM \
    -debug_access+all \
    -o simv

# 运行仿真 + SDF 注入
./simv +vcs+lic+wait \
       +sdfverbose \
       -sdf typ:tb_top.dut:dff.sdf
