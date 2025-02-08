`ifndef __logic_base_test_sv__
`define __logic_base_test_sv__
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
class logic_base_test extends uvm_test;
    `uvm_component_utils(logic_base_test)
    function new(string name,uvm_component parent);
        super.new(name,parent);
    endfunction

    virtual function void report_phase(uvm_phase phase);
        uvm_report_server server;
        super.report();
        server=uvm_report_server::get_server();
        $display("\n**************************************************\n"); // 输出分隔线
        $display("* Number of message logged: \n"); // 输出标题
        $display("* infos    : %0d", server.get_severity_count(UVM_INFO)); // 输出 INFO 数量
        $display("* warnings : %0d", server.get_severity_count(UVM_WARNING)); // 输出 WARNING 数量
        $display("* errors   : %0d", server.get_severity_count(UVM_ERROR)); // 输出 ERROR 数量
        $display("* fatals   : %0d", server.get_severity_count(UVM_FATAL)); // 输出 FATAL 数量
        $display("\n**************************************************\n"); // 输出分隔线        
        if (server.get_severity_count(UVM_FATAL) + server.get_severity_count(UVM_ERROR) + server.get_severity_count(UVM_WARNING) == 0) 
        begin
            $display("\033[1;32m"); // 设置输出颜色为绿色
            $display("\n >>>>> SIMULATION RESULT: PASSED <<<<<<<<< \n");
            $display("\033[0m"); // 恢复默认输出颜色
            `uvm_info(get_full_name(), "Simulation Passed", UVM_NONE);
        end        
    endfunction

endclass


`endif
