    // 第一步：必须先导入UVM HDL包（解决uvm_hdl_*函数未定义问题）
    `include "uvm_macros.svh"
    `include "uvm_pkg.sv"  // 关键：导入HDL访问函数
    import uvm_pkg::*;


    // ===================== 1. RTL待测模块 =====================
    module nsu_dut(
        input  clk,
        input  rst_n,
        output reg [5:0] offline_wbf_cur_state,
        output reg [3:0] rd_cmd_hw_cur_state,
        output reg [2:0] nand_rd_cmd_cur_state
    );

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            offline_wbf_cur_state  <= 6'd0;
            rd_cmd_hw_cur_state    <= 4'd0;
            nand_rd_cmd_cur_state  <= 3'd0;
        end else begin
            offline_wbf_cur_state  <= $urandom_range(0, 63);
            rd_cmd_hw_cur_state    <= $urandom_range(0, 15);
            nand_rd_cmd_cur_state  <= $urandom_range(0, 7);
        end
    end

    endmodule

    // ===================== 2. UVM环境（修复HDL函数调用） =====================
    class fsm_monitor extends uvm_component;
        `uvm_component_utils(fsm_monitor)

        string fsm_path_list[$] = '{
            "tb_top.u_dut.offline_wbf_cur_state",
            "tb_top.u_dut.rd_cmd_hw_cur_state",
            "tb_top.u_dut.nand_rd_cmd_cur_state"
        };

        function new(string name = "fsm_monitor", uvm_component parent = null);
            super.new(name, parent);
        endfunction

        // 修复：正确调用uvm_hdl_path_exists（已导入uvm_hdl_pkg）
        function bit read_rtl_signal(string path, ref logic [31:0] value);
            if(!uvm_hdl_path_exists(path)) begin  // 现在能正确识别
                `uvm_error("PATH_ERR", $sformatf("RTL路径不存在: %s", path))
                return 0;
            end

            if(!uvm_hdl_read(path, value)) begin
                `uvm_error("READ_ERR", $sformatf("读取RTL信号失败: %s", path))
                return 0;
            end

            `uvm_info("READ_SUCCESS", $sformatf("读取成功 | 路径: %s | 值: 0x%0h", path, value), UVM_MEDIUM)
            return 1;
        endfunction

        function void read_all_fsm_states();
            logic [31:0] state_val;
            int error_cnt = 0;

            `uvm_info("START_READ", "开始批量读取FSM状态...", UVM_LOW)
            foreach(fsm_path_list[i]) begin
                if(!read_rtl_signal(fsm_path_list[i], state_val)) begin
                    error_cnt++;
                end else begin
                    if(state_val != '0) begin
                        `uvm_warning("FSM_NOT_IDLE", $sformatf("FSM非空闲 | 路径: %s | 状态: 0x%0h", fsm_path_list[i], state_val))
                    end
                end
            end

            `uvm_info("READ_SUMMARY", $sformatf("批量读取完成 | 总数量: %0d | 失败数: %0d", fsm_path_list.size(), error_cnt), UVM_LOW)
        endfunction

        function bit write_rtl_signal(string path, logic [31:0] value);
            if(!uvm_hdl_path_exists(path)) begin  // 修复后可识别
                `uvm_error("PATH_ERR", $sformatf("RTL路径不存在: %s", path))
                return 0;
            end

            if(!uvm_hdl_deposit(path, value)) begin
                `uvm_error("WRITE_ERR", $sformatf("写入RTL信号失败: %s", path))
                return 0;
            end

            `uvm_info("WRITE_SUCCESS", $sformatf("写入成功 | 路径: %s | 值: 0x%0h", path, value), UVM_MEDIUM)
            return 1;
        endfunction

    endclass

    class nsu_env extends uvm_env;
        `uvm_component_utils(nsu_env)
        fsm_monitor fsm_mon;

        function new(string name = "nsu_env", uvm_component parent = null);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            fsm_mon = fsm_monitor::type_id::create("fsm_mon", this);
        endfunction

    endclass

    // ===================== 3. UVM测试用例（修复时钟等待逻辑） =====================
    class nsu_test extends uvm_test;
        `uvm_component_utils(nsu_test)
        nsu_env env;

        // 关键：通过uvm_config_db传递时钟周期，避免直接引用tb_top.clk
        int clk_period = 20;  // 时钟周期20ns（对应50MHz）

        function new(string name = "nsu_test", uvm_component parent = null);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            env = nsu_env::type_id::create("env", this);
            // 将时钟周期配置到UVM数据库，供全环境使用
            uvm_config_db#(int)::set(this, "*", "clk_period", clk_period);
        endfunction

        task run_phase(uvm_phase phase);
            logic [31:0] single_state;
            phase.raise_objection(this);

            `uvm_info("TEST_START", "UVM测试用例启动，开始读取RTL信号", UVM_LOW)

            // 1. 单次读取
            `uvm_info("SINGLE_READ", "-------- 单次读取演示 --------", UVM_MEDIUM)
            env.fsm_mon.read_rtl_signal("tb_top.u_dut.offline_wbf_cur_state", single_state);

            // 2. 批量读取
            `uvm_info("BATCH_READ", "-------- 批量读取演示 --------", UVM_MEDIUM)
            env.fsm_mon.read_all_fsm_states();

            // 3. 写入信号
            `uvm_info("WRITE_DEMO", "-------- 写入信号演示 --------", UVM_MEDIUM)
            env.fsm_mon.write_rtl_signal("tb_top.u_dut.offline_wbf_cur_state", 6'd0);

            // 修复：用时间等待替代直接引用tb_top.clk（UVM标准做法）
            `uvm_info("WAIT_CLK", $sformatf("等待5个时钟周期（%0dns）", 5*clk_period), UVM_MEDIUM)
            #(5*clk_period);  // 等待5个时钟周期（无需引用tb_top）

            // 再次读取
            `uvm_info("RE_READ", "-------- 写入后再次读取 --------", UVM_MEDIUM)
            env.fsm_mon.read_all_fsm_states();

            phase.drop_objection(this);
            `uvm_info("TEST_END", "UVM测试用例结束", UVM_LOW)
        endtask

    endclass

    // ===================== 4. 仿真顶层（独立编译域，避免跨域引用） =====================
    module tb_top;
        reg clk;
        reg rst_n;

        nsu_dut u_dut(
            .clk(clk),
            .rst_n(rst_n),
            .offline_wbf_cur_state(),
            .rd_cmd_hw_cur_state(),
            .nand_rd_cmd_cur_state()
        );

        // 生成时钟
        initial begin
            clk = 0;
            forever #10 clk = ~clk;
        end

        // 复位
        initial begin
            rst_n = 0;
            #20 rst_n = 1;
        end

        // 启动UVM（顶层中仅做这一件事，避免UVM和RTL编译域冲突）
        initial begin
            uvm_config_db#(string)::set(null, "*", "TESTNAME", "nsu_test");
            run_test();
        end

        // 仿真结束
        initial begin
            #1000;
            `uvm_info("SIM_END", "仿真结束", UVM_LOW)
            $finish;
        end

    endmodule