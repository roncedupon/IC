class nsu_env extends uvm_env;
  `uvm_component_utils(nsu_env)

  // 组件
  nsu_agent agent;

  function new(string name = "nsu_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // 构建函数
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // 创建代理
    agent = nsu_agent::type_id::create("agent", this);
  endfunction
endclass
