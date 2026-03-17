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

