module tb_packet_checker;

// -------------------------- 信号定义 --------------------------
logic        clk;
logic        rst_n;
logic        din;
logic [7:0]  dout;
logic        valid;
logic        err;

// -------------------------- DUT例化 --------------------------
packet_checker u_dut (
    .clk    (clk),
    .rst_n  (rst_n),
    .din    (din),
    .dout   (dout),
    .valid  (valid),
    .err    (err)
);

// -------------------------- 时钟生成 --------------------------
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk; // 100MHz时钟（周期10ns）
end

// -------------------------- 覆盖率组定义（修正兼容版） --------------------------
covergroup cov_group @(posedge clk);
    // 1. Line Coverage：仿真器自动收集（编译时启用-cm line）
    
    // 2. FSM Coverage：状态覆盖 + 状态转移覆盖（兼容写法）
    // 2.1 FSM状态覆盖（拆分all_states，避免复合range）
    cp_fsm_state: coverpoint u_dut.curr_state {
        bins idle    = {u_dut.IDLE};
        bins start   = {u_dut.START};
        bins data    = {u_dut.DATA};
        bins check   = {u_dut.CHECK};
        bins stop    = {u_dut.STOP};
        bins error   = {u_dut.ERROR};
        // 移除复合all_states，改为显式覆盖所有状态（避免Single Range List报错）
    }

    // 2.2 FSM状态转移覆盖（改用基础transition写法，兼容低版本仿真器）
    cp_fsm_trans_idle: coverpoint u_dut.curr_state {
        bins idle2start = (u_dut.IDLE => u_dut.START) iff (u_dut.din == 1'b0);
        bins idle2idle  = (u_dut.IDLE => u_dut.IDLE)  iff (u_dut.din == 1'b1);
    }

    cp_fsm_trans_start: coverpoint u_dut.curr_state {
        bins start2data  = (u_dut.START => u_dut.DATA)  iff (u_dut.din == 1'b0);
        bins start2error = (u_dut.START => u_dut.ERROR) iff (u_dut.din == 1'b1);
    }

    cp_fsm_trans_data: coverpoint u_dut.curr_state {
        bins data2data  = (u_dut.DATA => u_dut.DATA)  iff (u_dut.data_cnt != 3'd7);
        bins data2check = (u_dut.DATA => u_dut.CHECK) iff (u_dut.data_cnt == 3'd7);
    }

    cp_fsm_trans_check: coverpoint u_dut.curr_state {
        bins check2stop  = (u_dut.CHECK => u_dut.STOP)  iff (u_dut.din == u_dut.parity_calc);
        bins check2error = (u_dut.CHECK => u_dut.ERROR) iff (u_dut.din != u_dut.parity_calc);
    }

    cp_fsm_trans_stop: coverpoint u_dut.curr_state {
        bins stop2idle  = (u_dut.STOP => u_dut.IDLE)  iff (u_dut.din == 1'b1);
        bins stop2error = (u_dut.STOP => u_dut.ERROR) iff (u_dut.din == 1'b0);
    }

    cp_fsm_trans_error: coverpoint u_dut.curr_state {
        bins error2idle = (u_dut.ERROR => u_dut.IDLE);
    }

    // 3. Condition Coverage：关键条件判断覆盖（简化写法，兼容）
    cp_start_cond: coverpoint u_dut.din {
        bins start_cond_true  = {1'b0} iff (u_dut.curr_state == u_dut.IDLE);
        bins start_cond_false = {1'b1} iff (u_dut.curr_state == u_dut.IDLE);
    }

    cp_parity_cond: coverpoint u_dut.din {
        bins parity_cond_true  = {u_dut.parity_calc} iff (u_dut.curr_state == u_dut.CHECK);
        bins parity_cond_false = {~u_dut.parity_calc} iff (u_dut.curr_state == u_dut.CHECK);
    }

    cp_stop_cond: coverpoint u_dut.din {
        bins stop_cond_true  = {1'b1} iff (u_dut.curr_state == u_dut.STOP);
        bins stop_cond_false = {1'b0} iff (u_dut.curr_state == u_dut.STOP);
    }

    // 4. Toggle Coverage：关键信号翻转覆盖（拆分写法，避免复合foreach）
    cp_din_toggle: coverpoint u_dut.din {
        bins din_0_to_1 = (1'b0 => 1'b1);
        bins din_1_to_0 = (1'b1 => 1'b0);
    }

    // 拆分dout每bit翻转，避免foreach触发兼容问题
    cp_dout_bit0_toggle: coverpoint u_dut.dout[0] {
        bins dout0_0_to_1 = (1'b0 => 1'b1);
        bins dout0_1_to_0 = (1'b1 => 1'b0);
    }
    cp_dout_bit1_toggle: coverpoint u_dut.dout[1] {
        bins dout1_0_to_1 = (1'b0 => 1'b1);
        bins dout1_1_to_0 = (1'b1 => 1'b0);
    }
    cp_dout_bit2_toggle: coverpoint u_dut.dout[2] {
        bins dout2_0_to_1 = (1'b0 => 1'b1);
        bins dout2_1_to_0 = (1'b1 => 1'b0);
    }
    cp_dout_bit3_toggle: coverpoint u_dut.dout[3] {
        bins dout3_0_to_1 = (1'b0 => 1'b1);
        bins dout3_1_to_0 = (1'b1 => 1'b0);
    }
    cp_dout_bit4_toggle: coverpoint u_dut.dout[4] {
        bins dout4_0_to_1 = (1'b0 => 1'b1);
        bins dout4_1_to_0 = (1'b1 => 1'b0);
    }
    cp_dout_bit5_toggle: coverpoint u_dut.dout[5] {
        bins dout5_0_to_1 = (1'b0 => 1'b1);
        bins dout5_1_to_0 = (1'b1 => 1'b0);
    }
    cp_dout_bit6_toggle: coverpoint u_dut.dout[6] {
        bins dout6_0_to_1 = (1'b0 => 1'b1);
        bins dout6_1_to_0 = (1'b1 => 1'b0);
    }
    cp_dout_bit7_toggle: coverpoint u_dut.dout[7] {
        bins dout7_0_to_1 = (1'b0 => 1'b1);
        bins dout7_1_to_0 = (1'b1 => 1'b0);
    }

    cp_valid_toggle: coverpoint u_dut.valid {
        bins valid_0_to_1 = (1'b0 => 1'b1);
        bins valid_1_to_0 = (1'b1 => 1'b0);
    }

    cp_err_toggle: coverpoint u_dut.err {
        bins err_0_to_1 = (1'b0 => 1'b1);
        bins err_1_to_0 = (1'b1 => 1'b0);
    }

    // 5. Branch Coverage：分支语句覆盖（简化兼容写法）
    cp_idle_branch: coverpoint u_dut.curr_state {
        bins idle_branch_taken  = {u_dut.IDLE};
        bins idle_branch_not    = {u_dut.START, u_dut.DATA, u_dut.CHECK, u_dut.STOP, u_dut.ERROR};
    }

    cp_start_branch: coverpoint u_dut.curr_state {
        bins start_branch_taken  = {u_dut.START};
        bins start_branch_not    = {u_dut.IDLE, u_dut.DATA, u_dut.CHECK, u_dut.STOP, u_dut.ERROR};
    }

    cp_data_branch: coverpoint u_dut.curr_state {
        bins data_branch_taken  = {u_dut.DATA};
        bins data_branch_not    = {u_dut.IDLE, u_dut.START, u_dut.CHECK, u_dut.STOP, u_dut.ERROR};
    }

    cp_check_branch: coverpoint u_dut.curr_state {
        bins check_branch_taken  = {u_dut.CHECK};
        bins check_branch_not    = {u_dut.IDLE, u_dut.START, u_dut.DATA, u_dut.STOP, u_dut.ERROR};
    }

    cp_stop_branch: coverpoint u_dut.curr_state {
        bins stop_branch_taken  = {u_dut.STOP};
        bins stop_branch_not    = {u_dut.IDLE, u_dut.START, u_dut.DATA, u_dut.CHECK, u_dut.ERROR};
    }

    cp_error_branch: coverpoint u_dut.curr_state {
        bins error_branch_taken  = {u_dut.ERROR};
        bins error_branch_not    = {u_dut.IDLE, u_dut.START, u_dut.DATA, u_dut.CHECK, u_dut.STOP};
    }
endgroup

// 实例化覆盖率组
cov_group cov_inst = new();

// -------------------------- 激励任务定义 --------------------------
// 发送完整数据包（起始位+8bit数据+奇校验位+停止位）
task send_packet(input logic [7:0] data, input logic parity_err, input logic stop_err);
    logic parity_bit;
    // 计算奇校验位
    parity_bit = ~^data; // 奇校验：所有位异或后取反
    if (parity_err) parity_bit = ~parity_bit; // 注入校验错误

    @(posedge clk); din = 1'b0; // 起始位（0）
    repeat (8) begin // 8bit数据位
        @(posedge clk); din = data[0]; data = {1'b0, data[7:1]};
    end
    @(posedge clk); din = parity_bit; // 校验位
    @(posedge clk); din = stop_err ? 1'b0 : 1'b1; // 停止位（1，可选错误）
    @(posedge clk); din = 1'b1; // 回到空闲态
endtask

// 发送起始位错误的数据包
task send_start_err_packet;
    @(posedge clk); din = 1'b1; // 起始位错误（应为0，发1）
    repeat (10) @(posedge clk); // 后续无效数据
    @(posedge clk); din = 1'b1;
endtask

// -------------------------- 测试流程 --------------------------
initial begin
    // 初始化
    rst_n = 1'b0;
    din   = 1'b1;
    #15;  // 复位1.5个时钟周期
    rst_n = 1'b1;
    #10;

    // 场景1：发送正确数据包（覆盖正常路径）
    send_packet(8'h55, 1'b0, 1'b0);
    #20;

    // 场景2：发送起始位错误数据包（覆盖START->ERROR）
    send_start_err_packet;
    #20;

    // 场景3：发送校验位错误数据包（覆盖CHECK->ERROR）
    send_packet(8'hAA, 1'b1, 1'b0);
    #20;

    // 场景4：发送停止位错误数据包（覆盖STOP->ERROR）
    send_packet(8'h33, 1'b0, 1'b1);
    #20;

    // 场景5：发送多组数据覆盖dout翻转
    send_packet(8'h00, 1'b0, 1'b0);
    #10;
    send_packet(8'hFF, 1'b0, 1'b0);
    #10;
    send_packet(8'hF0, 1'b0, 1'b0);
    #10;

    // 场景6：空闲态等待（覆盖IDLE->IDLE）
    #50;

    // 结束仿真
    #100;
    $display("================ Coverage Report ================");
    $display("FSM State Coverage:    %.2f%%", cov_inst.cp_fsm_state.get_coverage());
    $display("FSM Trans Coverage:    %.2f%%", 
        (cov_inst.cp_fsm_trans_idle.get_coverage() + cov_inst.cp_fsm_trans_start.get_coverage() + 
         cov_inst.cp_fsm_trans_data.get_coverage() + cov_inst.cp_fsm_trans_check.get_coverage() + 
         cov_inst.cp_fsm_trans_stop.get_coverage() + cov_inst.cp_fsm_trans_error.get_coverage())/6);
    $display("Condition Coverage:    %.2f%%", 
        (cov_inst.cp_start_cond.get_coverage() + cov_inst.cp_parity_cond.get_coverage() + cov_inst.cp_stop_cond.get_coverage())/3);
    $display("Toggle Coverage:       %.2f%%", 
        (cov_inst.cp_din_toggle.get_coverage() + cov_inst.cp_valid_toggle.get_coverage() + cov_inst.cp_err_toggle.get_coverage() +
         cov_inst.cp_dout_bit0_toggle.get_coverage() + cov_inst.cp_dout_bit1_toggle.get_coverage() + cov_inst.cp_dout_bit2_toggle.get_coverage() +
         cov_inst.cp_dout_bit3_toggle.get_coverage() + cov_inst.cp_dout_bit4_toggle.get_coverage() + cov_inst.cp_dout_bit5_toggle.get_coverage() +
         cov_inst.cp_dout_bit6_toggle.get_coverage() + cov_inst.cp_dout_bit7_toggle.get_coverage())/11);
    $display("Branch Coverage:       %.2f%%", 
        (cov_inst.cp_idle_branch.get_coverage() + cov_inst.cp_start_branch.get_coverage() + cov_inst.cp_data_branch.get_coverage() + 
         cov_inst.cp_check_branch.get_coverage() + cov_inst.cp_stop_branch.get_coverage() + cov_inst.cp_error_branch.get_coverage())/6);
    $display("==================================================");
    
    $finish;
end

// -------------------------- 波形dump（可选） --------------------------
initial begin
    $fsdbDumpfile("tb_packet_checker.fsdb");
    $fsdbDumpvars(0, tb_packet_checker);
    $fsdbDumpMDA();
end

endmodule