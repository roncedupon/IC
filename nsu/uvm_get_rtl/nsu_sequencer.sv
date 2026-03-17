class nsu_sequencer extends uvm_sequencer#(nsu_seq_item);
  `uvm_component_utils(nsu_sequencer)

  // 接口句柄
  virtual nsu_if vif;

  function new(string name = "nsu_sequencer", uvm_component parent = null);
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
endclass
