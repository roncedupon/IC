`ifndef TLM_PUT_PORT
`define TLM_PUT_PORT
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "tlm_tr.sv"
import uvm_pkg::*;
//实现put后，记得调用put 并且如果有时间开销的时候，记得使用objection

class producer extends uvm_component;
    `uvm_component_utils(producer)
    uvm_blocking_put_port #(tlm_tr) put_port; // 1 parameter
    function new(string name="producer",uvm_component parent);
        super.new(name,parent);
        put_port=new("put_port",this);
    endfunction
    virtual task run_phase(uvm_phase phase);
        tlm_tr tr;
        phase.raise_objection(this);
        repeat(10)begin
            #10
            tr=new("tr");
            assert(tr.randomize());
            put_port.put(tr);
            #5
            $display("[%0d]tr has been put",$time);//由于这里用的是blocking put,所以后面的语句被阻塞了
        end
        phase.drop_objection(this);
    endtask
endclass


class consumer extends uvm_component;
    `uvm_component_utils(consumer)
    uvm_blocking_put_export #(tlm_tr) put_export; // 1 parameter
    uvm_blocking_put_imp#(tlm_tr,consumer) put_imp;
    function new(string name="consumer",uvm_component parent);
        super.new(name,parent);
        put_export=new("put_export",this);
        put_imp=new("put_imp",this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        put_export.connect(put_imp);
    endfunction

    function void put(tlm_tr tr);
        $display("[%0d]put function in consumer called",$time);
    endfunction
    
    // task put(tlm_tr tr);
    // endtask

endclass


class producer_wrapper extends uvm_component;
    `uvm_component_utils(producer_wrapper)
    uvm_blocking_put_port #(tlm_tr) put_port;
    producer producer0;
    function new(string name="producer_wrapper",uvm_component parent);
        super.new(name,parent);
        producer0=producer::type_id::create("producer0",this);
    endfunction
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        put_port.connect(producer0.put_port);
    endfunction
endclass

class Myenv extends uvm_component;
    `uvm_component_utils(Myenv)
    producer producer_wrapper;
    consumer consumer0;
    function new(string name="Myenv",uvm_component parent);
        super.new(name,parent);
        producer_wrapper=producer::type_id::create("producer_wrapper",this);
        consumer0=consumer::type_id::create("consumer0",this);
    endfunction
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        producer_wrapper.put_port.connect(consumer0.put_export);
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
