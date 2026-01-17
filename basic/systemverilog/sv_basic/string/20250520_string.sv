`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
task func(input string str="asds");
    $display(str);//这样打印也行
endtask
module top;
    string aaa="1234";

    // 方式1：声明时直接初始化
    string bin_path1[] = {"test1.bin", "test2.bin", "firmware.bin"};

    // 方式2：先声明，后赋值
    string bin_path2[];
    


    initial begin
        bin_path2 = {"mem_init.bin", "data_in.bin"}; // 覆盖整个数组
        $display("%s",{aaa,{"ddddsada"}});
        func(.str({aaa,{"ddddsada"}}));
        // 验证中打印确认（调试必备）
        foreach(bin_path1[i]) begin
        `uvm_info("BIN_CFG", $sformatf("bin_path1[%0d] = %s", i, bin_path1[i]), UVM_MEDIUM)
        end            
        foreach(bin_path2[i]) begin
        `uvm_info("BIN_CFG", $sformatf("bin_path2[%0d] = %s", i, bin_path2[i]), UVM_MEDIUM)
        end            
    end
endmodule