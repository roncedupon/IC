//--------------------------------------------------------------
// File: uvm_env_template.sv
// 说明：通用UVM验证环境模板
//--------------------------------------------------------------

`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;

//--------------------------------------------------------------
// 1. Transaction/Sequence Item
//--------------------------------------------------------------
class my_transaction extends uvm_sequence_item;
    rand logic [31:0] data;
    rand int          delay;

    `uvm_object_utils_begin(my_transaction)
        `uvm_field_int(data, UVM_ALL_ON)
        `uvm_field_int(delay, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "my_transaction");
        super.new(name);
    endfunction
endclass

//--------------------------------------------------------------
// 2. Sequence
//--------------------------------------------------------------
class base_sequence extends uvm_sequence#(my_transaction);
    `uvm_object_utils(base_sequence)

    function new(string name = "base_sequence");
        super.new(name);
    endfunction

    task body();
        `uvm_info("SEQ", "Executing base sequence", UVM_LOW)
        repeat(10) begin
            req = my_transaction::type_id::create("req");
            start_item(req);
            if(!req.randomize()) 
                `uvm_error("SEQ", "Randomization failed");
            finish_item(req);
        end
    endtask
endclass

//--------------------------------------------------------------
// 3. Driver
//--------------------------------------------------------------
class my_driver extends uvm_driver#(my_transaction);
    `uvm_component_utils(my_driver)
    
    virtual my_if vif;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
            `uvm_error("DRV", "Interface not found")
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(req);
            drive_transfer(req);
            seq_item_port.item_done();
        end
    endtask

    virtual task drive_transfer(my_transaction tr);
        // 添加具体驱动逻辑
    endtask
endclass

//--------------------------------------------------------------
// 4. Monitor
//--------------------------------------------------------------
class my_monitor extends uvm_monitor;
    `uvm_component_utils(my_monitor)
    
    virtual my_if vif;
    uvm_analysis_port#(my_transaction) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
            `uvm_error("MON", "Interface not found")
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            @(posedge vif.clk);
            // 添加具体监测逻辑
        end
    endtask
endclass

//--------------------------------------------------------------
// 5. Agent
//--------------------------------------------------------------
class my_agent extends uvm_agent;
    `uvm_component_utils(my_agent)
    
    my_driver    driver;
    my_monitor   monitor;
    uvm_sequencer#(my_transaction) sequencer;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        monitor = my_monitor::type_id::create("monitor", this);
        if(get_is_active() == UVM_ACTIVE) begin
            driver = my_driver::type_id::create("driver", this);
            sequencer = uvm_sequencer#(my_transaction)::type_id::create("sequencer", this);
        end
    endfunction

    function void connect_phase(uvm_phase phase);
        if(get_is_active() == UVM_ACTIVE)
            driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction
endclass

//--------------------------------------------------------------
// 6. Scoreboard
//--------------------------------------------------------------
class my_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(my_scoreboard)
    
    uvm_analysis_imp#(my_transaction, my_scoreboard) ap_imp;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap_imp = new("ap_imp", this);
    endfunction

    function void write(my_transaction tr);
        // 添加检查逻辑
    endfunction
endclass

//--------------------------------------------------------------
// 7. Environment
//--------------------------------------------------------------
class test_env extends uvm_env;
    `uvm_component_utils(test_env)
    
    my_agent       agent;
    my_scoreboard  scb;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent = my_agent::type_id::create("agent", this);
        scb = my_scoreboard::type_id::create("scb", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        agent.monitor.ap.connect(scb.ap_imp);
    endfunction
endclass

//--------------------------------------------------------------
// 8. Test
//--------------------------------------------------------------
class base_test extends uvm_test;
    `uvm_component_utils(base_test)
    
    test_env env;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = test_env::type_id::create("env", this);
    endfunction

    task run_phase(uvm_phase phase);
        base_sequence seq;
        phase.raise_objection(this);
        seq = base_sequence::type_id::create("seq");
        seq.start(env.agent.sequencer);
        phase.drop_objection(this);
    endtask
endclass

//--------------------------------------------------------------
// 9. Interface 和 Testbench 顶层
//--------------------------------------------------------------
interface my_if(input logic clk, rst_n);
    logic [31:0] data_in;
    logic [31:0] data_out;
endinterface

module dut(
    input        clk,
    input        rst_n,
    // 添加实际接口信号
    input  [31:0] data_in,
    output [31:0] data_out
);
    // 实现设计逻辑
    reg [31:0] reg_data;
    
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            reg_data <= 32'h0;
        end else begin
            reg_data <= data_in;
        end
    end
    
    assign data_out = reg_data;
endmodule

module tb_top;
    logic clk;
    logic rst_n;

    // 时钟生成
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // 复位生成
    initial begin
        rst_n = 0;
        #100 rst_n = 1;
    end

    // 实例化接口和DUT
    my_if dut_if(clk, rst_n);
    // 修改后（显式端口连接）
        dut my_dut(
            .clk     (dut_if.clk),
            .rst_n   (dut_if.rst_n),
            .data_in (dut_if.data_in),
            .data_out(dut_if.data_out)
        );
    // 将接口传递到UVM配置数据库
        initial begin
            uvm_config_db#(virtual my_if)::set(
                null,         // 使用全局上下文
                "uvm_test_top.env.agent*",  // 通配符匹配路径
                "vif",        // 必须与get的key一致
                dut_if       // 传递虚拟接口
            );
        end
    initial begin
        // 配置虚拟接口
        // uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env.agent", "vif", dut_if);
        // 启动测试
        run_test("base_test");
    end
endmodule
