def generate_uvm_agent(agent_name):
    """
    生成UVM Agent模板代码
    :param agent_name: Agent名称（小写，如uart/i2c）
    :return: 完整的UVM代码字符串
    """
    # 首字母大写（用于类名）
    agent_name_upper = agent_name.capitalize()
    
    # 模板内容
    uvm_code = f"""
//------------------------------------------------------------------------------
// {agent_name_upper} UVM Agent 自动生成模板
// 包含：Transaction/Interface/Driver/Monitor/Agent
//------------------------------------------------------------------------------
`ifndef {agent_name_upper}_UVM_AGENT_SV
`define {agent_name_upper}_UVM_AGENT_SV

// ==============================================================================
// 1. {agent_name_upper} Transaction（数据传输对象）
// ==============================================================================
class {agent_name_upper}Transaction extends uvm_sequence_item;
    // 数据字段示例（根据实际协议修改）
    rand bit [31:0] data;          // 数据
    rand bit [7:0]  addr;          // 地址
    rand bit        wr_en;         // 写使能
    bit             resp;          // 响应信号（非随机）

    // UVM字段自动化（注册字段用于打印/拷贝/比较）
    `uvm_object_utils_begin({agent_name_upper}Transaction)
        `uvm_field_int(data, UVM_ALL_ON)
        `uvm_field_int(addr, UVM_ALL_ON)
        `uvm_field_int(wr_en, UVM_ALL_ON)
        `uvm_field_int(resp, UVM_ALL_ON)
    `uvm_object_utils_end

    // 构造函数
    function new(string name = "{agent_name}_transaction");
        super.new(name);
    endfunction

    // 约束（根据实际协议添加）
    constraint c_data_range {{
        data inside {{[0:1023]}};  // 数据范围约束示例
    }}

    // 自定义打印函数（可选）
    virtual function void do_print(uvm_printer printer);
        super.do_print(printer);
        printer.print_field("data", data, 32, UVM_DEC);
        printer.print_field("addr", addr, 8, UVM_DEC);
        printer.print_field("wr_en", wr_en, 1, UVM_DEC);
        printer.print_field("resp", resp, 1, UVM_DEC);
    endfunction

endclass: {agent_name_upper}Transaction

// ==============================================================================
// 2. {agent_name_upper} Interface（硬件接口）
// ==============================================================================
interface {agent_name}_if(input clk, input rst_n);
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

endinterface: {agent_name}_if

// ==============================================================================
// 3. {agent_name_upper} Driver（驱动模块）
// ==============================================================================
class {agent_name_upper}Driver extends uvm_driver#({agent_name_upper}Transaction);
    // 接口句柄
    virtual {agent_name}_if vif;

    // UVM组件注册
    `uvm_component_utils({agent_name_upper}Driver)

    // 构造函数
    function new(string name = "{agent_name}_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // 构建阶段：获取接口
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual {agent_name}_if)::get(this, "", "{agent_name}_vif", vif)) begin
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
    virtual task drive_transaction({agent_name_upper}Transaction tr);
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

endclass: {agent_name_upper}Driver

// ==============================================================================
// 4. {agent_name_upper} Monitor（监测模块）
// ==============================================================================
class {agent_name_upper}Monitor extends uvm_monitor;
    // 接口句柄
    virtual {agent_name}_if vif;

    // Analysis Port（输出监测到的transaction）
    uvm_analysis_port#({agent_name_upper}Transaction) ap;

    // UVM组件注册
    `uvm_component_utils({agent_name_upper}Monitor)

    // 构造函数
    function new(string name = "{agent_name}_monitor", uvm_component parent = null);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    // 构建阶段：获取接口
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual {agent_name}_if)::get(this, "", "{agent_name}_vif", vif)) begin
            `uvm_fatal("NO_VIF", "无法从config_db获取接口句柄")
        end
    endfunction

    // 运行阶段：监测接口信号
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            {agent_name_upper}Transaction tr;
            tr = {agent_name_upper}Transaction::type_id::create("tr");
            
            // 采样接口信号
            sample_transaction(tr);
            
            // 通过analysis port发送transaction
            ap.write(tr);
        end
    endtask

    // 采样Transaction
    virtual task sample_transaction({agent_name_upper}Transaction tr);
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

endclass: {agent_name_upper}Monitor

// ==============================================================================
// 5. {agent_name_upper} Agent（顶层封装）
// ==============================================================================
class {agent_name_upper}Agent extends uvm_agent;
    // 子组件
    {agent_name_upper}Driver    driver;
    {agent_name_upper}Monitor   monitor;
    uvm_sequencer#({agent_name_upper}Transaction) sequencer;

    // UVM组件注册
    `uvm_component_utils({agent_name_upper}Agent)

    // 构造函数
    function new(string name = "{agent_name}_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // 构建阶段：创建子组件
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        monitor = {agent_name_upper}Monitor::type_id::create("monitor", this);
        
        // 根据is_active决定是否创建driver和sequencer
        if (is_active == UVM_ACTIVE) begin
            driver = {agent_name_upper}Driver::type_id::create("driver", this);
            sequencer = uvm_sequencer#({agent_name_upper}Transaction)::type_id::create("sequencer", this);
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

endclass: {agent_name_upper}Agent

`endif // {agent_name_upper}_UVM_AGENT_SV
"""
    return uvm_code


# 主程序：读取输入并生成模板
if __name__ == "__main__":
    # 读取用户输入的Agent名称
    agent_name = input("请输入UVM Agent名称（小写，如uart/i2c/spi）：").strip()
    
    # 输入验证
    if not agent_name:
        print("错误：Agent名称不能为空！")
    elif not agent_name.islower():
        print("警告：建议输入小写名称，已自动转换")
        agent_name = agent_name.lower()
    
    # 生成UVM代码
    uvm_template = generate_uvm_agent(agent_name)
    
    # 保存到文件
    filename = f"{agent_name}_agent.sv"
    with open(filename, "w", encoding="utf-8") as f:
        f.write(uvm_template)
    
    print(f"✅ UVM Agent模板已生成完成！")
    print(f"📄 生成文件：{filename}")
    print("\n模板包含以下核心模块：")
    print(f"  1. {agent_name.capitalize()}Transaction（数据对象）")
    print(f"  2. {agent_name}_if（硬件接口）")
    print(f"  3. {agent_name.capitalize()}Driver（驱动模块）")
    print(f"  4. {agent_name.capitalize()}Monitor（监测模块）")
    print(f"  5. {agent_name.capitalize()}Agent（顶层封装）")