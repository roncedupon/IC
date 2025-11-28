`ifndef TLM_PUT_PORT
`define TLM_PUT_PORT
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "tlm_tr.sv"
import uvm_pkg::*;
//如果仅仅简单连接put_port和port_export，那么就会报错,这个例子里没有实现put方法也没有imp
// UVM_ERROR @ 0: uvm_test_top.consumer0.put_export [Connection Error] connection count of 0 does not meet required minimum of 1
// UVM_ERROR @ 0: uvm_test_top.producer0.put_port [Connection Error] connection count of 0 does not meet required minimum of 1
// UVM_FATAL @ 0: reporter [BUILDERR] stopping due to build errors
class producer extends uvm_component;
    `uvm_component_utils(producer)
    uvm_blocking_put_port #(tlm_tr) put_port; // 1 parameter
    function new(string name="producer",uvm_component parent);
        super.new(name,parent);
        put_port=new("put_port",this);
    endfunction
endclass
class consumer extends uvm_component;
    `uvm_component_utils(consumer)
    uvm_blocking_put_export #(tlm_tr) put_export; // 1 parameter
    function new(string name="consumer",uvm_component parent);
        super.new(name,parent);
        put_export=new("put_export",this);
    endfunction
endclass
class Myenv extends uvm_component;
    `uvm_component_utils(Myenv)
    producer producer0;
    consumer consumer0;
    function new(string name="Myenv",uvm_component parent);
        super.new(name,parent);
        producer0=producer::type_id::create("producer0",this);
        consumer0=consumer::type_id::create("consumer0",this);
    endfunction
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        producer0.put_port.connect(consumer0.put_export);
    endfunction
endclass


module tlm_top;
    reg clk;
    reg rstn;

    initial begin
        run_test("Myenv");
    end
    initial begin

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

`endif
