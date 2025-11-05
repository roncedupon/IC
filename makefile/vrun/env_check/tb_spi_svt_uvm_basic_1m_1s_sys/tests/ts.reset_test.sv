
/**
 * Abstract:
 * This file test runs the default base test without modification
 */

`include "spi_base_test.sv"

class reset_test extends spi_base_test;

  /** UVM component utility macro */
  `uvm_component_utils(reset_test)

  /** Creating an instance of SPI simple reset sequence */
  spi_simple_reset_sequence reset_sequence;

  spi_default_virtual_sequence virt_seq;

  svt_spi_types::operation_mode_enum operation_mode;

  int count_clock = 0;

  /** Class constructor */
  function new(string name = "reset_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new
  
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered ...", UVM_LOW)
    super.build_phase(phase);
    uvm_config_db#(int unsigned)::set(this, "env.sequencer.spi_default_virtual_sequence", 
				      "sequence_length", 1);

    /** Creation of Reset sequence object */
    reset_sequence = new("reset_sequence");

    virt_seq = new("virt_seq");

    `uvm_info("build_phase", "Exited ...", UVM_LOW)
  endfunction : build_phase
 
  task main_phase(uvm_phase phase);
    super.main_phase(phase);
    phase.raise_objection(this);
    `uvm_info("main_phase", "Entered ...",UVM_LOW)

    fork
      env.master_agent.txrx.EVENT_TRANSACTION_STARTED_RX.wait_trigger();
      env.slave_agent.txrx.EVENT_TRANSACTION_STARTED_RX.wait_trigger();
    join

    if (enable_configurable_data_frame_width) 
      void'(std::randomize(count_clock) with {count_clock inside {[1: 2*master_cfg.data_frame_width]};});
    else 
      void'(std::randomize(count_clock) with {count_clock inside {[1:10]};});
    `uvm_info("SVT",$sformatf("Apply Reset after count_clock = %d number of clocks",count_clock),UVM_LOW)

    /** Applying Dynamic Reset */
    fork
    begin
      repeat(count_clock)
        @env.master_cfg.spi_if.sclk;
      reset_sequence.start(env.sequencer, null);
    end
    begin
      env.spi_scbd.drop_packet_master();
    end
    begin
      env.spi_scbd.drop_packet_slave();
    end
    join

    @env.master_cfg.spi_if.bus_clk;
    if(std::randomize(operation_mode) with {operation_mode != shared_cfg.operation_mode;})
      `uvm_info("SVT",$sformatf("operation_mode %d",operation_mode),UVM_LOW)
    `uvm_info("SVT","Reconfiguring after event trigger",UVM_LOW)

    master_cfg.operation_mode = operation_mode;
    env.master_agent.reconfigure(master_cfg);

    slave_cfg.operation_mode = operation_mode;
    env.slave_agent.reconfigure(slave_cfg);

    @env.master_cfg.spi_if.bus_clk;
    virt_seq.start(env.sequencer,null);

    phase.drop_objection(this);
    `uvm_info("main_phase", "Exited ...",UVM_LOW)
  endtask // main_phase

endclass

//----------------------------------------------------------------------------
//--------------------------END OF FILE---------------------------------------
//----------------------------------------------------------------------------
