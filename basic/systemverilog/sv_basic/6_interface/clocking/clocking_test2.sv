//从uvm芯片验证技术案例集上看到的，但是不太明白具体应该如何使用
//这段代码调了好久，uvm1.1->1.2的变换
    //seq中不再需要phase.raise_objection,而是换成了set_automatic_phase_objection(1);

//seq1和seq2的区别就是phase.raise_objection
//当然手动启动seq还是可以用的，在test中手动启动seq代码：
    //    // virtual task run_phase(uvm_phase phase);
    //     tlm_seq seq;
    //     phase.raise_objection(this);
    //     // seq=tlm_seq::type_id::create("seq");
    //     // seq.start(agent.sequencer);
        
    //     phase.drop_objection(this);
    // endtask    


`timescale 1ns/1ps
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;

interface data_in_interface(input clk,input rst);
    logic [4:0]data_in;
    clocking drv@(posedge clk iff(!rst));
        default input #1step output #1step;
        output data_in;

    endclocking
    clocking mon@(posedge clk iff(!rst));
        default input #1step output #1step;
        input data_in;

    endclocking
endinterface

module dut(input clk, input rst, input [4:0] data_in, output reg [4:0] data_out);
    always @(posedge clk or posedge rst) begin
        if (rst)
            data_out <= 5'b0;
        else
            data_out <= data_in;
    end
endmodule
class data_transaction extends uvm_sequence_item;
    rand logic [4:0] data_in;

    `uvm_object_utils(data_transaction)

    function new(string name = "data_transaction");
        super.new(name);
    endfunction
endclass

class data_driver extends uvm_driver #(data_transaction);
    virtual data_in_interface vif;

    `uvm_component_utils(data_driver)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(req);
            for (int i=0;i<10;i=i+1)begin
                vif.drv.data_in <= req.data_in;
                @(posedge vif.clk);
            end
            seq_item_port.item_done();
        end
    endtask
endclass


class data_monitor extends uvm_monitor;
    virtual data_in_interface vif;
    uvm_analysis_port#(data_transaction) ap;

    `uvm_component_utils(data_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            @(posedge vif.clk);
            if (!vif.rst) begin
                data_transaction tr = data_transaction::type_id::create("tr");
                tr.data_in = vif.mon.data_in;
                ap.write(tr);
            end
        end
    endtask
endclass

class data_agent extends uvm_agent;
    data_driver driver;
    data_monitor monitor;
    uvm_sequencer#(data_transaction) sequencer;
    virtual data_in_interface vif;

    `uvm_component_utils(data_agent)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (get_is_active() == UVM_ACTIVE) begin
            $display("creating driver");
            $display("creating driver");
            $display("creating driver");
            $display("creating driver");
            $display("creating driver");
            driver = data_driver::type_id::create("driver", this);
            sequencer = uvm_sequencer#(data_transaction)::type_id::create("sequencer", this);
        end
        monitor = data_monitor::type_id::create("monitor", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (!uvm_config_db#(virtual data_in_interface)::get(this, "", "vif", vif))
            `uvm_fatal("CFG_ERR", "Failed to get interface")
        if (get_is_active() == UVM_ACTIVE) begin
            driver.seq_item_port.connect(sequencer.seq_item_export);
            driver.vif = vif;
        end
        monitor.vif = vif;
    endfunction
endclass

class tlm_seq extends uvm_sequence;
    data_transaction tr;
    `uvm_object_utils(tlm_seq)
    function new(string name="tlm_seq");
        super.new(name);
        set_automatic_phase_objection(1);
    endfunction
    virtual task body();
        super.body();
        // if(starting_phase!=null)
        //     starting_phase.raise_objection(this);
        repeat(10)begin
            `uvm_do(tr);
            $display("uvm transaction sended");
        end
        #1000;
        // if(starting_phase!=null)
        //     starting_phase.drop_objection(this);
    endtask
    
endclass
//seq1和seq2的区别就是phase.raise_objection
//当然手动启动seq还是可以用的，在test中手动启动seq代码：
    //    // virtual task run_phase(uvm_phase phase);
    //     tlm_seq seq;
    //     phase.raise_objection(this);
    //     // seq=tlm_seq::type_id::create("seq");
    //     // seq.start(agent.sequencer);
        
    //     phase.drop_objection(this);
    // endtask
class tlm_seq2 extends uvm_sequence;
    data_transaction tr;
    `uvm_object_utils(tlm_seq2)
    function new(string name="tlm_seq2");
        super.new(name);
        // set_automatic_phase_objection(1);
    endfunction
    virtual task body();
        super.body();
        if(starting_phase!=null)
            starting_phase.raise_objection(this);
        repeat(10)begin
            `uvm_do(tr);
            $display("uvm transaction sended");
        end
        #1000;
        if(starting_phase!=null)
            starting_phase.drop_objection(this);
    endtask
endclass

class data_test extends uvm_test;
    data_agent agent;
    virtual data_in_interface vif;

    `uvm_component_utils(data_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        agent = data_agent::type_id::create("agent", this);
        if (!uvm_config_db#(virtual data_in_interface)::get(this, "", "vif", vif))
            `uvm_fatal("CFG_ERR", "Failed to get interface")
        uvm_config_db#(virtual data_in_interface)::set(this, "agent", "vif", vif);
        
    endfunction

    // virtual task run_phase(uvm_phase phase);
    //     tlm_seq seq;
    //     phase.raise_objection(this);
    //     // seq=tlm_seq::type_id::create("seq");
    //     // seq.start(agent.sequencer);
        
    //     phase.drop_objection(this);
    // endtask
endclass




module top;
    logic clk;
    logic rst;
    logic [4:0] data_in;
    logic [4:0] data_out;

    // 实例化 DUT
    dut u_dut(.clk(clk), .rst(rst), .data_in(data_in), .data_out(data_out));

    // 实例化接口
    data_in_interface u_if(.clk(clk), .rst(rst));

    // 连接接口信号
    assign data_in = u_if.data_in;

    // 时钟生成
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // 复位生成
    initial begin
        rst = 1;
        #10 rst = 0;
    end
    initial begin
        #1000
        $finish;
    end
    // UVM 测试启动
    initial begin
        $fsdbDumpfile("waves.fsdb");
        $fsdbDumpvars(0,top,"+mda");
        uvm_config_db#(virtual data_in_interface)::set(null, "*", "vif", u_if);

        //uvm1.2和1.1的区别如下：
        // uvm_config_db#(uvm_object_wrapper)::set(uvm_root::get(),"uvm_test_top.agent.sequencer.main_phase","default_sequence",tlm_seq::type_id::get());//成功
        uvm_config_db#(uvm_object_wrapper)::set(uvm_root::get(),"uvm_test_top.agent.sequencer.main_phase","default_sequence",tlm_seq2::type_id::get());//失败
        run_test("data_test");
    end
endmodule