`timescale 1ns/1ns
`include "dut.sv"
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
// `include "dut_test.sv"
`include "dut_vif.sv"
`include "dut_env.sv"
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
    run_test("dut_env");
end
initial begin
    clk=0;
    rstn=1'b0;
    #1000
    rstn=1'b1;
end

initial begin
    uvm_config_db#(virtual dut_vif)::set(null,"uvm_test_top.*","vif",vif);//初始化interface
    $display("start run dut test");

    $fsdbDumpfile("waves.fsdb");
    $fsdbDumpvars(0,top,"+mda");
   
    $dumpfile ("waves.vcd");//生成vcd文件，映射回windows远程文件夹，目前存放在上级目录中的waves中
    $dumpvars(0,top);
    // #10000
    // $finish;
end
always@(posedge clk)
    $display("clk posedge");
endmodule
