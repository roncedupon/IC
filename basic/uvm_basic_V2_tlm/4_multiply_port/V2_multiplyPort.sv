`ifndef TLM_PUT_PORT
`define TLM_PUT_PORT
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "tlm_tr.sv"
import uvm_pkg::*;
//修改new函数，实现一个producer对应多个consumer的连接
//这版代码是为了实现至少和4个export进行连接的功能

//error描述：无法广播,从输出可以看到只启动了consumer0的put
// [20]put function in consumer0 called
// [30]put function in consumer0 called
// [40]put function in consumer0 called
// [40]tr has been put
// [40]trigger detected ,tr has been put


class producer extends uvm_component;
    `uvm_component_utils(producer)
    uvm_blocking_put_port #(tlm_tr) put_port; // 1 parameter
    function new(string name="producer",uvm_component parent);
        super.new(name,parent);
        
        put_port=new("put_port",this,4,4);//修改这里，

    endfunction
    virtual task run_phase(uvm_phase phase);
        tlm_tr tr;

        phase.raise_objection(this);
                #10
                tr=new("tr");
                assert(tr.randomize());
                put_port.put(tr);
        phase.drop_objection(this);
    endtask
endclass
class consumer extends uvm_component;

    `uvm_component_utils(consumer)
    uvm_blocking_put_imp#(tlm_tr,consumer) put_imp;

    function new(string name="consumer",uvm_component parent);
        super.new(name,parent);
        put_imp=new("put_imp",this);
    endfunction

    task put(tlm_tr tr);//这里改了一下，验证连接多个port时是如何阻塞的
        #10
        $display("[%0d]put function in %s called",$time,get_name());
    endtask
    


endclass
class Myenv extends uvm_component;
    `uvm_component_utils(Myenv)
    producer producer0;
    consumer consumer0;
    consumer consumer1;
    consumer consumer2;
    consumer consumer3;
    function new(string name="Myenv",uvm_component parent);
        super.new(name,parent);
        producer0=producer::type_id::create("producer0",this);
        consumer0=consumer::type_id::create("consumer0",this);
        consumer1=consumer::type_id::create("consumer1",this);
        consumer2=consumer::type_id::create("consumer2",this);
        consumer3=consumer::type_id::create("consumer3",this);

    endfunction
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        producer0.put_port.connect(consumer0.put_imp);//看这里，把port和imp进行了连接，现在没有export了
        producer0.put_port.connect(consumer1.put_imp);//看这里，把port和imp进行了连接，现在没有export了
        producer0.put_port.connect(consumer2.put_imp);//看这里，把port和imp进行了连接，现在没有export了
        producer0.put_port.connect(consumer3.put_imp);//看这里，把port和imp进行了连接，现在没有export了
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
        #50000
        $display("finish sim");
        $finish;
    end
    always#5 clk=~clk;

endmodule

`endif
