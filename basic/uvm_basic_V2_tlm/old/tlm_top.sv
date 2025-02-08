`include "dut_vif.sv"
`include "tlm_env.sv"
`include "tlm_dut.sv"
module tlm_top;
    reg clk;
    reg rstn;
    dut_vif vif(clk,rstn);
        tlm_dut dut(
        .clk(clk),
        .rstn(rstn),
        .a(vif.a),
        .b(vif.b),
        .c(vif.c)
    );
    initial begin
        run_test("tlm_env");
    end
    initial begin
        uvm_config_db#(virtual dut_vif)::set(null,"uvm_test_top.drv","vif",vif);
        uvm_config_db#(virtual dut_vif)::set(null,"uvm_test_top.mon","vif",vif);
        $display("start run dut test");
        $fsdbDumpfile("waves.fsdb");
        $fsdbDumpvars(0,tlm_top,"+mda");
   
        $dumpfile ("waves.vcd");//生成vcd文件，映射回windows远程文件夹，目前存放在上级目录中的waves中
        $dumpvars(0,tlm_top);
    end
    initial begin
        clk=0;
        rstn=0;
        #1000
        rstn=1;
        #5000
        $display("finish sim");
        $finish;
    end
    always#5 clk=~clk;

endmodule