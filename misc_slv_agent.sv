
//------------------------------------------------------------------------------
// Misc_slv UVM Agent 自动生成模板
// 包含：Transaction/Interface/Driver/Monitor/Agent
//------------------------------------------------------------------------------
`ifndef Misc_slv_UVM_AGENT_SV
`define Misc_slv_UVM_AGENT_SV

// ==============================================================================
// 1. Misc_slv Transaction（数据传输对象）
// ==============================================================================
class Misc_slvTransaction extends uvm_sequence_item;
    // 数据字段示例（根据实际协议修改）
    rand bit [31:0] data;          // 数据
    rand bit [7:0]  addr;          // 地址
    rand bit        wr_en;         // 写使能
    bit             resp;          // 响应信号（非随机）

    // UVM字段自动化（注册字段用于打印/拷贝/比较）
    `uvm_object_utils_begin(Misc_slvTransaction)
        `uvm_field_int(data, UVM_ALL_ON)
        `uvm_field_int(addr, UVM_ALL_ON)
        `uvm_field_int(wr_en, UVM_ALL_ON)
        `uvm_field_int(resp, UVM_ALL_ON)
    `uvm_object_utils_end

    // 构造函数
    function new(string name = "misc_slv_transaction");
        super.new(name);
    endfunction

    // 约束（根据实际协议添加）
    constraint c_data_range {
        data inside {[0:1023]};  // 数据范围约束示例
    }

    // 自定义打印函数（可选）
    virtual function void do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field("data", data, 32, UVM_DEC);
        printer.print_field("addr", addr, 8, UVM_DEC);
        printer.print_field("wr_en", wr_en, 1, UVM_DEC);
        printer.print_field("resp", resp, 1, UVM_DEC);
    endfunction

endclass: Misc_slvTransaction

// ==============================================================================
// 2. Misc_slv Interface（硬件接口）
// ==============================================================================
interface misc_slv_if(input clk, input rst_n);
    // 接口信号示例（根据实际协议修改）
    logic [31:0] data;
    logic [7:0]  addr;
    logic        wr_en;
    logic        resp;

    // 时钟块（用于Driver/Monitor同步）
    clocking drv_cb @(posedge clk);
        output data, addr, wr_en;
        input  resp;
    endclocking: drv_cb

    clocking mon_cb @(posedge clk);
        input data, addr, wr_en, resp;
    endclocking: mon_cb

    // 复位断言检查（可选）
    property p_rst_signals;
        @(posedge clk) !rst_n |-> (data == 0 && addr == 0 && wr_en == 0);
    endproperty: p_rst_signals
    `ASSERT(rst_signals_assert, p_rst_signals, "复位时信号未清零")

endinterface: misc_slv_if

// ==============================================================================
// 3. Misc_slv Driver（驱动模块）
// ==============================================================================
class Misc_slvDriver extends uvm_driver#(Misc_slvTransaction);
    // 接口句柄
    virtual misc_slv_if vif;

    // UVM组件注册
    `uvm_component_utils(Misc_slvDriver)

    // 构造函数
    function new(string name = "misc_slv_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // 构建阶段：获取接口
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual misc_slv_if)::get(this, "", "misc_slv_vif", vif)) begin
            `uvm_fatal("NO_VIF", "无法从config_db获取接口句柄")
        end
    endfunction

    // 运行阶段：驱动数据到DUT
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        // 复位初始状态
        reset_driver();

        forever begin
            // 从sequencer获取transaction
            seq_item_port.get_next_item(req);
            
            // 驱动transaction到接口
            drive_transaction(req);
            
            // 通知sequencer完成
            seq_item_port.item_done();
        end
    endtask

    // 复位Driver
    virtual task reset_driver();
        @(negedge vif.rst_n);
        vif.drv_cb.data  <= '0;
        vif.drv_cb.addr  <= '0;
        vif.drv_cb.wr_en <= '0;
        @(posedge vif.rst_n);
        `uvm_info(get_type_name(), "Driver复位完成", UVM_MEDIUM)
    endtask

    // 驱动单个Transaction
    virtual task drive_transaction(Misc_slvTransaction tr);
        @(vif.drv_cb);
        vif.drv_cb.data  <= tr.data;
        vif.drv_cb.addr  <= tr.addr;
        vif.drv_cb.wr_en <= tr.wr_en;
        
        // 等待响应（根据协议调整）
        @(vif.drv_cb);
        tr.resp = vif.drv_cb.resp;
        
        `uvm_info(get_type_name(), $sformatf("驱动Transaction：data=0x%08x, addr=0x%02x, wr_en=%0b, resp=%0b",
                   tr.data, tr.addr, tr.wr_en, tr.resp), UVM_MEDIUM)
    endtask

endclass: Misc_slvDriver

// ==============================================================================
// 4. Misc_slv Monitor（监测模块）
// ==============================================================================
class Misc_slvMonitor extends uvm_monitor;
    // 接口句柄
    virtual misc_slv_if vif;

    // Analysis Port（输出监测到的transaction）
    uvm_analysis_port#(Misc_slvTransaction) ap;

    // UVM组件注册
    `uvm_component_utils(Misc_slvMonitor)

    // 构造函数
    function new(string name = "misc_slv_monitor", uvm_component parent = null);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    // 构建阶段：获取接口
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual misc_slv_if)::get(this, "", "misc_slv_vif", vif)) begin
            `uvm_fatal("NO_VIF", "无法从config_db获取接口句柄")
        end
    endfunction

    // 运行阶段：监测接口信号
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            Misc_slvTransaction tr;
            tr = Misc_slvTransaction::type_id::create("tr");
            
            // 采样接口信号
            sample_transaction(tr);
            
            // 通过analysis port发送transaction
            ap.write(tr);
        end
    endtask

    // 采样Transaction
    virtual task sample_transaction(Misc_slvTransaction tr);
        @(vif.mon_cb);
        if (vif.rst_n) begin  // 仅在复位释放后采样
            tr.data  = vif.mon_cb.data;
            tr.addr  = vif.mon_cb.addr;
            tr.wr_en = vif.mon_cb.wr_en;
            tr.resp  = vif.mon_cb.resp;
            
            `uvm_info(get_type_name(), $sformatf("监测到Transaction：data=0x%08x, addr=0x%02x, wr_en=%0b, resp=%0b",
                       tr.data, tr.addr, tr.wr_en, tr.resp), UVM_LOW)
        end
    endtask

endclass: Misc_slvMonitor

// ==============================================================================
// 5. Misc_slv Agent（顶层封装）
// ==============================================================================
class Misc_slvAgent extends uvm_agent;
    // 子组件
    Misc_slvDriver    driver;
    Misc_slvMonitor   monitor;
    uvm_sequencer#(Misc_slvTransaction) sequencer;

    // UVM组件注册
    `uvm_component_utils(Misc_slvAgent)

    // 构造函数
    function new(string name = "misc_slv_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // 构建阶段：创建子组件
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        monitor = Misc_slvMonitor::type_id::create("monitor", this);
        
        // 根据is_active决定是否创建driver和sequencer
        if (is_active == UVM_ACTIVE) begin
            driver = Misc_slvDriver::type_id::create("driver", this);
            sequencer = uvm_sequencer#(Misc_slvTransaction)::type_id::create("sequencer", this);
        end
    endfunction

    // 连接阶段：连接driver和sequencer
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (is_active == UVM_ACTIVE) begin
            driver.seq_item_port.connect(sequencer.seq_item_export);
        end
    endfunction

    // 打印Agent配置信息
    virtual function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        `uvm_info(get_type_name(), $sformatf("Agent配置：is_active=%s", 
                   is_active == UVM_ACTIVE ? "UVM_ACTIVE" : "UVM_PASSIVE"), UVM_MEDIUM)
    endfunction

endclass: Misc_slvAgent

`endif // Misc_slv_UVM_AGENT_SV
