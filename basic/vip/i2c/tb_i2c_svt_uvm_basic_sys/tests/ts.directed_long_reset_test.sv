
/**
 * Abstract:
 * The file contains the class extended from i2c_base_test
 * In this test reset is asserted in between 10 bit read operation.
 */

`include "i2c_base_test.sv"
`include "i2c_mst_directed_reset_in_ten_bit_rd_sequence.sv"
`include "i2c_slv_directed_sequence.sv"
`include "i2c_null_virtual_sequence.sv"
`include "i2c_mst_directed_long_reset_10_bit_rd_virtual_sequence.sv"
class directed_long_reset_test extends i2c_base_test;

  /** UVM component utility macro */
  `uvm_component_utils(directed_long_reset_test)

  /** Class constructor */
  function new(string name = "directed_long_reset_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new
  
  /** build_phase(uvm_phase phase) - Method to build various component */
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build phase", "Entered ...", UVM_LOW)

    super.build_phase(phase);
    cfg.slave_cfg[0].enable_10bit_addr = 1;
    cfg.slave_cfg[0].slave_address    = $urandom; 
   /** Disable the virtual default sequence on the the virtual sequencer started in the i2c_base_test */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.i2c_system_env.sequencer.main_phase", "default_sequence", i2c_null_virtual_sequence::type_id::get());
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.sequencer.main_phase", "default_sequence", i2c_mst_directed_long_reset_10_bit_rd_virtual_sequence::type_id::get());
 uvm_config_db#(bit [9:0])::set(this, "env.i2c_system_env.master[0].sequencer.i2c_mst_directed_reset_in_ten_bit_rd_sequence", "address", cfg.slave_cfg[0].slave_address);
    
   `uvm_info("build_phase", "Exited ...", UVM_LOW)
 endfunction : build_phase

  /** This is the main_phase */ 
  task main_phase(uvm_phase phase);
    `ifdef SVT_UVM_1800_2_2017_OR_HIGHER
     uvm_objection phase_d;
    `endif
    `uvm_info("main_phase", "Entered ...",UVM_LOW)
    `uvm_info("main_phase", $sformatf("Setting the drain time in the main_phase of the directed_long_reset_test"), UVM_NONE) 
      `ifdef SVT_UVM_1800_2_2017_OR_HIGHER
      phase_d = phase.get_objection();
      phase_d.set_drain_time(this, (200));
    `else
      phase.phase_done.set_drain_time(this, (200));
    `endif
    `uvm_info("main_phase", "Exited ...",UVM_LOW)
  endtask : main_phase

endclass
