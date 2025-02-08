`timescale 1ns/1ns
`include "dut.sv"
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "dut_test.sv"

import uvm_pkg::*;
module top;
    reg clk;
    reg rstn;
    dut_vif vif(clk,rstn);
    dut dut_inst(
        .data_in(vif.data_in),
        .data_out(vif.data_out),
        .en_i(vif.en_i),
        .en_o(vif.en_o),
        .clk(clk),
        .rstn(rstn)
    );
always#5 clk=~clk;
initial begin
    run_test("dut_test");
end
initial begin
    clk=0;
    rstn=1'b0;
    #1000
    rstn=1'b1;
end

initial begin
    uvm_config_db#(virtual dut_vif)::set(null,"uvm_test_top","dut_test",vif);//初始化interface
    uvm_config_db#(virtual dut_vif)::set(null,"uvm_test_top.dut_env_inst.dut_agent_inst.dut_driver_inst","vif",vif);//这里的意思就是将获取到的vif继续传输给agent里的所有子模块
                                                                                    //之前这里agent.driver没有接收到vif，是因为粗心把set写成了get
    uvm_config_db#(virtual dut_vif)::set(null,"uvm_test_top.dut_env_inst.dut_agent_inst.dut_monitor_inst","vif",vif);//这里的意思就是将获取到的vif继续传输给agent里的所有子模块
                                                                                    //之前这里agent.driver没有接收到vif，是因为粗心把set写成了get
    $display("start run dut test");

    $fsdbDumpfile("waves.fsdb");
    $fsdbDumpvars(0,top,"+mda");
   
    $dumpfile ("waves.vcd");//生成vcd文件，映射回windows远程文件夹，目前存放在上级目录中的waves中
    $dumpvars(0,top);
    #10000
    $finish;
end
always@(posedge clk)
    $display("clk posedge");
endmodule
