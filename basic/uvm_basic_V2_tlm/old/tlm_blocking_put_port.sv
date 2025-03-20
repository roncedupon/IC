`ifndef TLM_PUT_PORT
`define TLM_PUT_PORT
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "tlm_tr.sv"
import uvm_pkg::*;
//这里可能有点绕，现在的想法就是实现了producer和comsumer
//对于put_port：producer为put_port,comsumer则为put_export，需要producer主动地将tr由port打给export
//对于get_port：producer的为get_export，consumer则为get_port，所以需要consumer主动地从producer获取tr
//这样就需要在producer和consumer中都是先run还有imp

//当然一开始producer里面的get和put都是port端口，但是对于get操作来说让producer从consumer中获取数据好像有点歧义。
class blocking_port_producer extends uvm_component;
    `uvm_component_utils(blocking_port_producer)
    uvm_blocking_put_port #(tlm_tr) put_port; // 1 parameter
    uvm_blocking_get_imp#(tlm_tr,blocking_port_producer)get_export;//2 parameters
    
    function new( string name="blocking_port_producer", uvm_component parent);
        super.new(name,parent);
        put_port = new("put_port", this);
        get_export = new("get_export", this);
    endfunction
    virtual task run_phase(uvm_phase phase);

        tlm_tr t;
        super.run_phase(phase);
        phase.raise_objection(this);
        for(int i = 0; i < 10; i=i+1) begin
            t=new();
            t.a=i;
            t.b=i;
            put_port.put(t);
            $display("[producer put port]:producer put one tr to consumer--a[%d]--b[%d]--c[%d]--expect[%d]",t.a,t.b,t.c,t.a+t.b);
        end
        phase.drop_objection(this);
    endtask

    task get(output tlm_tr t);//这地方要写一个output是为什么?

        for(int i=0;i<10;i=i+1)begin
            #50//发速度比收速度快
            t=new();
            t.a=123;
            t.b=67;
        end

    endtask
endclass


class blocking_port_comsumer extends uvm_component;
    uvm_blocking_put_imp#(tlm_tr,blocking_port_comsumer)put_export;//2 parameters,第二个参数是声明了所实现的imp方法的对象的类型（type of the object that declares the method implementation）
    `uvm_component_utils(blocking_port_comsumer)
    uvm_blocking_get_port #(tlm_tr) get_port;
    function new( string name="blocking_port_comsumer", uvm_component parent);
        super.new(name,parent);
        put_export = new("put_export", this);
        get_port =new("get_port",this);
        
    endfunction
    task put(tlm_tr t);//uvm_blocking_put_imp的imp就是put
        $display("[consumer put export]:consumer get one tr from producer--a[%d]--b[%d]--c[%d]--expect[%d]",t.a,t.b,t.c,t.a+t.b);
    endtask
    
    virtual task run_phase(uvm_phase phase);
        tlm_tr t;
        super.run_phase(phase);
        phase.raise_objection(this);
        for(int i=0;i<10;i=1+1)begin
            #100
            get_port.get(t);
            $display("[consumer put export]:consumer get one tr from producer--a[%d]--b[%d]--c[%d]--expect[%d]",t.a,t.b,t.c,t.a+t.b);
        end
        phase.drop_objection(this);
    endtask

endclass

class blocking_port_env extends uvm_env;
    `uvm_component_utils(blocking_port_env)
    uvm_tlm_fifo #(tlm_tr) fifo_producer2consumer;//控制流：producer:[put_port]--->[put_export] consumer
    uvm_tlm_fifo #(tlm_tr) fifo_consumer2producer;//控制流：consumer:[get_port]--->[get_export] producer
    blocking_port_comsumer consumer;
    blocking_port_producer producer;
    function new(string name="blocking_port_env",uvm_component parent);
        super.new(name,parent);
    endfunction
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        fifo_producer2consumer=new("fifo_producer2consumer",this);
        fifo_consumer2producer=new("fifo_consumer2producer",this);

        producer=blocking_port_producer::type_id::create("producer",this);
        consumer=blocking_port_comsumer::type_id::create("consumer",this);

    endfunction
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        // consumer.get_port.connect(fifo_producer2consumer.get_export);
        producer.put_port.connect(fifo_producer2consumer.put_export);
        consumer.get_port.connect(fifo_producer2consumer.get_export);

        // consumer.get_port.connect(fifo_consumer2producer.get_export);
        // fifo_consumer2producer.get.connect(producer.get_export);
    endfunction
    virtual task run_phase(uvm_phase phase);
        forever begin
            #50
            $display("fifo_size is %d",fifo_producer2consumer.used());
            if(fifo_producer2consumer.is_full())
                `uvm_info("UVM_TLM_FIFO","FIFO is now full !!",UVM_MEDIUM);
        end
    endtask
endclass



module tlm_fifo_test;
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
        run_test("blocking_port_env");
    end
    initial begin
        uvm_config_db#(virtual dut_vif)::set(null,"uvm_test_top.drv","vif",vif);
        uvm_config_db#(virtual dut_vif)::set(null,"uvm_test_top.mon","vif",vif);
        $display("start run dut test");
        $fsdbDumpfile("waves.fsdb");
        $fsdbDumpvars(0,tlm_fifo_test,"+mda");
   
        $dumpfile ("waves.vcd");//生成vcd文件，映射回windows远程文件夹，目前存放在上级目录中的waves中
        $dumpvars(0,tlm_fifo_test);
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
