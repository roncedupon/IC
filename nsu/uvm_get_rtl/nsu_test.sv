class nsu_test extends uvm_test;
  `uvm_component_utils(nsu_test)

  // 环境
  nsu_env env;
  // 序列
  nsu_sequence seq;

  function new(string name = "nsu_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // 构建函数
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // 创建环境
    env = nsu_env::type_id::create("env", this);
    // 创建序列
    seq = nsu_sequence::type_id::create("seq");
  endfunction

  // 运行函数
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    // 设置相位为活跃
    phase.raise_objection(this);
    // 启动序列
    seq.start(env.agent.sequencer);
    // 等待序列完成
    #100ns;
    // 结束相位
    phase.drop_objection(this);
  endtask
endclass
