`ifndef NORMAL_RESP_CHECKER_SV
`define NORMAL_RESP_CHECKER_SV

//=============================================================================
// normal_resp_checker.sv - NSU2CPU Normal Response Checker
//=============================================================================
// 基于规范文档: 升维MP-NSU-spec PN85.docx 第 6.4.10 节
// 功能: 检查 NSU 输出给 CPU 的 read 状态响应 (normal_resp)
//
// nsu2cpu_resp_transaction 位域定义 (32位):
//   根据 nsu_cpu_transactions.sv 中的定义:
//   [31:24] error_plane_pair_sel - 解码器译码状态，0：成功；1：失败
//   [23:16] nand_index           - NAND的操作命令
//   [15:0]  instruction_index    - 用于标识指令 (16位)
//
// 注意: nsu_cpu_transactions.sv 中 instruction_index 定义为 bit [7:0],
//       但 fields_assignment 中赋值给 nsu2cpu_resp[0][15:0],
//       实际应为 16 位。本 checker 按 16 位处理。
//
// error_plane_pair_sel 计算公式 (规范文档):
//   译码状态 & (!强制报错) & lba比较 & err_flag比较的结果
//   注：比较的前提是 plane_sel 选中以及 meta 时比较模式
//=============================================================================

package normal_resp_checker_pkg;

    typedef enum logic [2:0] {
        NORMAL_CHECK_PASS           = 3'b000,
        NORMAL_CHECK_FAIL_DECODE    = 3'b001,
        NORMAL_CHECK_FAIL_NAND_IDX  = 3'b010,
        NORMAL_CHECK_FAIL_INSTR_IDX = 3'b011,
        NORMAL_CHECK_FAIL_TIMEOUT   = 3'b100,
        NORMAL_CHECK_FAIL_MISMATCH  = 3'b101,
        NORMAL_CHECK_INVALID_RESP   = 3'b111
    } normal_check_status_e;

    typedef struct packed {
        logic        valid;
        logic [15:0] instruction_index;
        logic [7:0]  expected_error_plane_pair_sel;
        logic [7:0]  expected_nand_index;
        logic [7:0]  plane_sel;
        logic [7:0]  dec_suc;
        logic [7:0]  lba_comp;
        logic [7:0]  err_flag_comp;
        logic        force_report_en;
    } normal_resp_expect_t;

endpackage

class normal_resp_checker extends uvm_component;

    `uvm_component_utils(normal_resp_checker)

    import normal_resp_checker_pkg::*;

    uvm_tlm_analysis_fifo #(nsu2cpu_resp_transaction) normal_resp_fifo;

    logic pending_instr_exists [bit [15:0]];
    normal_resp_expect_t pending_expect [bit [15:0]];

    int unsigned total_resp_count = 0;
    int unsigned pass_count = 0;
    int unsigned fail_count = 0;
    int unsigned decode_success_count = 0;
    int unsigned decode_fail_count = 0;
    int unsigned timeout_count = 0;

    extern virtual task check_normal_resp();
    extern virtual function void report_check_result(
        input nsu2cpu_resp_transaction resp,
        input normal_check_status_e status,
        input string fail_reason
    );

    function new(string name = "normal_resp_checker", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        normal_resp_fifo = new("normal_resp_fifo", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "normal_resp_checker started", UVM_MEDIUM)
        check_normal_resp();
    endtask

    virtual function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("Total NORMAL_RESP: %0d", total_resp_count), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("Pass: %0d, Fail: %0d", pass_count, fail_count), UVM_LOW)
        `uvm_info(get_type_name(), $sformatf("Decode success: %0d, Decode fail: %0d", 
            decode_success_count, decode_fail_count), UVM_LOW)
        if (timeout_count > 0) begin
            `uvm_warning(get_type_name(), $sformatf("Timeout waiting for expected response: %0d", timeout_count))
        end
    endfunction

endclass

task normal_resp_checker::check_normal_resp();
    nsu2cpu_resp_transaction resp;
    normal_check_status_e status;
    string fail_reason;
    normal_resp_expect_t expect;
    logic [7:0] calc_error_plane_pair_sel;
    int plane_pair_decode_success;
    int plane_pair_decode_fail;

    forever begin
        normal_resp_fifo.get(resp);
        total_resp_count++;

        `uvm_info(get_type_name(), $sformatf(
            "Received NORMAL_RESP: instr_idx=%0h, nand_idx=%0h, error_pp_sel=%08b", 
            resp.instruction_index, resp.nand_index, resp.error_plane_pair_sel), UVM_LOW)

        status = NORMAL_CHECK_PASS;
        fail_reason = "";

        if (pending_instr_exists[resp.instruction_index]) begin
            expect = pending_expect[resp.instruction_index];

            if (!expect.valid) begin
                status = NORMAL_CHECK_INVALID_RESP;
                fail_reason = "Expected config is invalid";
            end else begin
                if (resp.nand_index != expect.expected_nand_index) begin
                    status = NORMAL_CHECK_FAIL_NAND_IDX;
                    fail_reason = $sformatf(
                        "nand_index mismatch: expected=%0h, got=%0h", 
                        expect.expected_nand_index, resp.nand_index);
                end

                if (status == NORMAL_CHECK_PASS) begin
                    calc_error_plane_pair_sel = '0;
                    plane_pair_decode_success = 0;
                    plane_pair_decode_fail = 0;

                    for (int pp = 0; pp < 8; pp++) begin
                        if (!expect.plane_sel[pp]) continue;

                        if (!expect.dec_suc[pp] && 
                            !expect.force_report_en && 
                            !expect.lba_comp[pp] && 
                            !expect.err_flag_comp[pp]) begin
                            calc_error_plane_pair_sel[pp] = 1'b1;
                            plane_pair_decode_fail++;
                        end else begin
                            plane_pair_decode_success++;
                        end
                    end

                    if (resp.error_plane_pair_sel != calc_error_plane_pair_sel) begin
                        status = NORMAL_CHECK_FAIL_DECODE;
                        fail_reason = $sformatf(
                            "error_plane_pair_sel mismatch: expected=%08b, got=%08b", 
                            calc_error_plane_pair_sel, resp.error_plane_pair_sel);
                    end else begin
                        decode_success_count += plane_pair_decode_success;
                        decode_fail_count += plane_pair_decode_fail;
                    end
                end
            end

            pending_instr_exists[resp.instruction_index] = 1'b0;
            pending_expect[resp.instruction_index].valid = 1'b0;

        end else begin
            status = NORMAL_CHECK_FAIL_INSTR_IDX;
            fail_reason = $sformatf(
                "No pending expectation for instruction_index=%0h", 
                resp.instruction_index);
        end

        report_check_result(resp, status, fail_reason);
    end
endtask

function void normal_resp_checker::report_check_result(
    input nsu2cpu_resp_transaction resp,
    input normal_check_status_e status,
    input string fail_reason
);
    if (status == NORMAL_CHECK_PASS) begin
        pass_count++;
        `uvm_info(get_type_name(), $sformatf(
            "NORMAL_RESP CHECK PASS: instr_idx=%0h, nand_idx=%0h, error_pp_sel=%08b", 
            resp.instruction_index, resp.nand_index, resp.error_plane_pair_sel), UVM_LOW)
    end else begin
        fail_count++;
        `uvm_error(get_type_name(), $sformatf(
            "NORMAL_RESP CHECK FAIL [%s]: instr_idx=%0h - %s", 
            status.name(), resp.instruction_index, fail_reason))
    end
endfunction

`endif
