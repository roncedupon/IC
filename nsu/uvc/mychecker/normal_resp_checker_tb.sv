`ifndef NORMAL_RESP_CHECKER_TB_SV
`define NORMAL_RESP_CHECKER_TB_SV

//=============================================================================
// normal_resp_checker_tb.sv - Testbench for normal_resp_checker
//=============================================================================

`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;

program normal_resp_checker_tb;

    initial begin
        run_test("normal_resp_checker_test");
    end

endprogram

class normal_resp_checker_test extends uvm_test;

    `uvm_component_utils(normal_resp_checker_test)

    normal_resp_checker checker;
    nsu2cpu_resp_transaction resp;

    function new(string name = "normal_resp_checker_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        checker = normal_resp_checker::type_id::create("checker", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);

        `uvm_info(get_type_name(), "Starting normal_resp_checker test", UVM_LOW)

        test_basic_resp();
        test_decode_fail();
        test_multiple_plane_pairs();

        #100ns;
        phase.drop_objection(this);
    endtask

    virtual task test_basic_resp();
        `uvm_info(get_type_name(), "Test 1: Basic response - all decode success", UVM_LOW)

        checker.pending_instr_exists[16'h0001] = 1'b1;
        checker.pending_expect[16'h0001].valid = 1'b1;
        checker.pending_expect[16'h0001].instruction_index = 16'h0001;
        checker.pending_expect[16'h0001].expected_nand_index = 8'h05;
        checker.pending_expect[16'h0001].plane_sel = 8'hFF;
        checker.pending_expect[16'h0001].dec_suc = 8'hFF;
        checker.pending_expect[16'h0001].lba_comp = 8'h00;
        checker.pending_expect[16'h0001].err_flag_comp = 8'h00;
        checker.pending_expect[16'h0001].force_report_en = 1'b0;

        resp = nsu2cpu_resp_transaction::type_id::create("resp");
        resp.instruction_index = 16'h0001;
        resp.nand_index = 8'h05;
        resp.error_plane_pair_sel = 8'h00;

        checker.normal_resp_fifo.write(resp);

        #10ns;
    endtask

    virtual task test_decode_fail();
        `uvm_info(get_type_name(), "Test 2: Decode fail on plane_pair[2]", UVM_LOW)

        checker.pending_instr_exists[16'h0002] = 1'b1;
        checker.pending_expect[16'h0002].valid = 1'b1;
        checker.pending_expect[16'h0002].instruction_index = 16'h0002;
        checker.pending_expect[16'h0002].expected_nand_index = 8'h0A;
        checker.pending_expect[16'h0002].plane_sel = 8'hFF;
        checker.pending_expect[16'h0002].dec_suc = 8'hFB;
        checker.pending_expect[16'h0002].lba_comp = 8'h00;
        checker.pending_expect[16'h0002].err_flag_comp = 8'h00;
        checker.pending_expect[16'h0002].force_report_en = 1'b0;

        resp = nsu2cpu_resp_transaction::type_id::create("resp");
        resp.instruction_index = 16'h0002;
        resp.nand_index = 8'h0A;
        resp.error_plane_pair_sel = 8'h04;

        checker.normal_resp_fifo.write(resp);

        #10ns;
    endtask

    virtual task test_multiple_plane_pairs();
        `uvm_info(get_type_name(), "Test 3: Multiple plane_pair decode fail", UVM_LOW)

        checker.pending_instr_exists[16'h0003] = 1'b1;
        checker.pending_expect[16'h0003].valid = 1'b1;
        checker.pending_expect[16'h0003].instruction_index = 16'h0003;
        checker.pending_expect[16'h0003].expected_nand_index = 8'h10;
        checker.pending_expect[16'h0003].plane_sel = 8'hAA;
        checker.pending_expect[16'h0003].dec_suc = 8'hA0;
        checker.pending_expect[16'h0003].lba_comp = 8'h00;
        checker.pending_expect[16'h0003].err_flag_comp = 8'h00;
        checker.pending_expect[16'h0003].force_report_en = 1'b0;

        resp = nsu2cpu_resp_transaction::type_id::create("resp");
        resp.instruction_index = 16'h0003;
        resp.nand_index = 8'h10;
        resp.error_plane_pair_sel = 8'h0A;

        checker.normal_resp_fifo.write(resp);

        #10ns;
    endtask

endclass

`endif
