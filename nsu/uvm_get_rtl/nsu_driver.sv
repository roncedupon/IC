class nsu_driver extends uvm_driver#(nsu_seq_item);
  `uvm_component_utils(nsu_driver)

  // 接口句柄
  virtual nsu_if vif;

  function new(string name = "nsu_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // 构建函数
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // 获取接口
    if(!uvm_config_db#(virtual nsu_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal(get_type_name(), "Failed to get virtual interface")
    end
  endfunction

  // 运行函数
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    // 由于我们主要是读取信号，这里不需要驱动逻辑
    // 信号读取在sequence中通过uvm_hdl_read完成
  endtask
endclass
