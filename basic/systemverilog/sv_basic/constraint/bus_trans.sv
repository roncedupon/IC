`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
class bus_trans extends uvm_sequence_item;
    rand bit [31:0] addr;
    randc bit [1:0] cmd; // 0:读,1:写,2:配置,3:复位
    bit [7:0]  data;

    // 约束1：地址范围（0x1000~0x2000，且4字节对齐）
    constraint c_addr_range {
        addr inside {[32'h1000:32'h2000]};
        addr % 4 == 0; // 4字节对齐
    }

    // 约束2：指令类型仅支持0/1/2（禁用复位指令3）
    constraint c_cmd_type {
        cmd inside {0,1,2};
    }

    // 约束3：写指令时数据非0，读指令时数据为0
    constraint c_data {
        (cmd == 2) -> data == 12; // 隐含约束（->：if-then）
        (cmd == 0) -> data == 34;
        // (cmd == 1) -> data == 56;

    }

    `uvm_object_utils(bus_trans)
    function new(string name = "bus_trans");
        super.new(name);
    endfunction
endclass
module tb_top;
    bus_trans trans_item;
    initial begin
        trans_item=new();
        trans_item.randomize();
        $display("Address: 0x%0h", trans_item.addr);
        $display("Command: %0d  ", trans_item.cmd);
        $display("Data:    0x%0h", trans_item.data);
    
    end


endmodule