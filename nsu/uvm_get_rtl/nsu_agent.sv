class nsu_agent extends uvm_agent;
  `uvm_component_utils(nsu_agent)

  // 组件
  nsu_driver driver;
  nsu_sequencer sequencer;

  function new(string name = "nsu_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // 构建函数
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // 创建驱动和序列器
    driver = nsu_driver::type_id::create("driver", this);
    sequencer = nsu_sequencer::type_id::create("sequencer", this);
  endfunction

  // 连接函数
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    // 连接驱动和序列器
    driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction
endclass
