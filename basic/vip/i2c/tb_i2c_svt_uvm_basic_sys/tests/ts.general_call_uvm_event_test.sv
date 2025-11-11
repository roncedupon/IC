
/**
 * Abstract:
 * The file contains the class extended from i2c_base_test
 * It disables the base test case virtual sequence on the virtual sequencer.
 * Two back to back general call commands are sent by the master.
 * After slave ACKs the second byte after general call EVENT_SECOND_BYTE_GEN_CALL_ACK_GENERATED
 * is trigerred and second byte is stored in data register.
 */

`include "i2c_base_test.sv"
`include "i2c_mst_gen_call_uvm_event_sequence.sv"
`include "i2c_slv_directed_sequence.sv"
`include "i2c_null_virtual_sequence.sv"

class general_call_uvm_event_test extends i2c_base_test;

  /** UVM component utility macro */
  `uvm_component_utils(general_call_uvm_event_test)
   uvm_event_pool ep1;
   uvm_event      e1;
   bit [7:0]      data;
   
  /** Class constructor */
  function new(string name = "general_call_uvm_event_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new

  /** build_phase() - Method to build various component */
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered ...", UVM_LOW)

    super.build_phase(phase);
 
   /** Disable the virtual default sequence on the the virtual sequencer started in the i2c_base_test */
   uvm_config_db#(uvm_object_wrapper)::set(this, "env.i2c_system_env.sequencer.main_phase", "default_sequence", i2c_null_virtual_sequence::type_id::get());

   /** Apply the master directed i2c sequence to the i2c master sequencer */
   uvm_config_db#(uvm_object_wrapper)::set(this, "env.i2c_system_env.master[0].sequencer.main_phase", "default_sequence", i2c_mst_gen_call_uvm_event_sequence::type_id::get());
 
   /** Apply the slave directed i2c sequence to the i2c slave sequencer */
   uvm_config_db#(uvm_object_wrapper)::set(this, "env.i2c_system_env.slave[0].sequencer.main_phase", "default_sequence", i2c_slv_directed_sequence::type_id::get());
  
   `uvm_info("build_phase", "Exited ...", UVM_LOW)
 endfunction : build_phase
 task run_phase(uvm_phase phase);
    ep1 = env.i2c_system_env.slave[0].driver.event_pool;
    e1 = ep1.get("EVENT_SECOND_BYTE_GEN_CALL_ACK_GENERATED");
    repeat(2) begin
      e1.wait_trigger();
      //Fetch the value of the second byte after General Call
      data = env.i2c_system_env.slave[0].driver.second_byte_gen_call;
     `uvm_info("general_call_uvm_event_test",$sformatf("Second byte of general call ACKed by Slave. Second_byte = %8b",data),UVM_LOW)
    end
 endtask


endclass
