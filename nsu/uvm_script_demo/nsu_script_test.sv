`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;

class nsu_script_test extends uvm_test;
  `uvm_component_utils(nsu_script_test)

  function new(string name = "nsu_script_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), "Building test...", UVM_MEDIUM)
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    `uvm_info(get_type_name(), "Running test...", UVM_MEDIUM)
    // 模拟一些测试活动
    #100ns;
    `uvm_info(get_type_name(), "Test completed...", UVM_MEDIUM)
    phase.drop_objection(this);
  endtask

  virtual function void final_phase(uvm_phase phase);
    integer status;
    super.final_phase(phase);
    `uvm_info(get_type_name(), "Entering final phase...", UVM_MEDIUM)
    // 执行shell脚本
    status = $system("sh $CUR_PROJ_HOME/run_analysis.sh");
    if (status == 0) begin
      `uvm_info(get_type_name(), "Script executed successfully!", UVM_MEDIUM)
    end else begin
      `uvm_error(get_type_name(), "Script execution failed!")
    end
  endfunction
endclass
