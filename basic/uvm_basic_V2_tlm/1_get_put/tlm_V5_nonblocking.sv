`ifndef TLM_PUT_PORT
`define TLM_PUT_PORT
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "tlm_tr.sv"
import uvm_pkg::*;
//实现put后，记得调用put 并且如果有时间开销的时候，记得使用objection

class producer extends uvm_component;
    `uvm_component_utils(producer)
    uvm_nonblocking_put_port #(tlm_tr) put_port; // 1 parameter
    function new(string name="producer",uvm_component parent);
        super.new(name,parent);
        put_port=new("put_port",this);
    endfunction
    virtual task run_phase(uvm_phase phase);
        tlm_tr tr;
        bit rt;
        int sentnum=10;
        phase.raise_objection(this);
        while(sentnum>0)begin

            tr=new("tr");
            assert(tr.randomize());
            rt=put_port.try_put(tr);
            if(rt)sentnum--;
            $display("[%0d] sentnum is %0d,try put has been called,returned %0d",$time,sentnum,rt);//由于这里用的是blocking put,所以后面的语句被阻塞了
            #15;
            
        end
        phase.drop_objection(this);
    endtask
endclass
class consumer extends uvm_component;
    `uvm_component_utils(consumer)
    tlm_tr tr_queue[$];
    uvm_nonblocking_put_export #(tlm_tr) put_export; // 1 parameter
    uvm_nonblocking_put_imp#(tlm_tr,consumer) put_imp;
    function new(string name="consumer",uvm_component parent);
        super.new(name,parent);
        put_export=new("put_export",this);
        put_imp=new("put_imp",this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        put_export.connect(put_imp);
    endfunction


    function bit can_put();
        if(tr_queue.size()>2)
            return 0;
        else return 1;
    endfunction

    function bit try_put(tlm_tr tr);
        if(can_put())begin
            $display("[%0d]put function in consumer called",$time);
            tr_queue.push_back(tr);
            return 1;
        end
        else begin
            $display("[%0d]can not put !! size in queue is %0d",$time,tr_queue.size());
            return 0;
        end
    endfunction

    virtual task run_phase(uvm_phase phase);
        tlm_tr tr;
        super.run_phase(phase);
        forever begin
            #30
            tr= tr_queue.pop_front();
            $display("[%0d] queue pop now,size in queue is %0d",$time,tr_queue.size());
        end

    endtask


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
