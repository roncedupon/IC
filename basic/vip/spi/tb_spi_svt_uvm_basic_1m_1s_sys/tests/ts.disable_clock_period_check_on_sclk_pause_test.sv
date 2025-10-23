/**
 * Abstract:<br/>
 * This test validates that "svt_err_spi_min_sclk_period" is disabled on sclk pause .<br/>
 * Once sclk is paused for duration more than "sclk_period*min_spi_bus_sclk_pause_multiple_factor" .<br/>
 * clock period checks should not get triggered.
 */

`include "spi_base_test.sv"

class disable_clock_period_check_on_sclk_pause_test extends spi_base_test;

  spi_flash_directed_sclk_pause_sequence    master_directed_sclk_pause_sequence;
  spi_flash_directed_sclk_pause_sequence    slave_directed_sclk_pause_sequence;
  
  /** Variables to calculate the baud rate divisor*/
  bit [2:0] sppr = 0;
  bit [2:0] spr  = 0;

  /** UVM component utility macro */
  `uvm_component_utils(disable_clock_period_check_on_sclk_pause_test)

  /** Class constructor */
  function new(string name = "disable_clock_period_check_on_sclk_pause_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new
  
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered ...", UVM_LOW)
    super.build_phase(phase);

    /** For Expected Bus_Clk frequency of 100 MHz and SPPR =0 and SPR = 0, SCLK frequency will be 50 MHz. */
    master_cfg.sppr = this.sppr;
    master_cfg.spr  = this.spr;
    slave_cfg.sppr  = this.sppr;
    slave_cfg.spr   = this.spr;
  
    // Configuring min sclk period.
    master_cfg.min_spi_bus_sclk_period_ns = set_min_sclk_period(simulation_cycle,master_cfg.sppr,master_cfg.spr);
    slave_cfg.min_spi_bus_sclk_period_ns = set_min_sclk_period(simulation_cycle,master_cfg.sppr,master_cfg.spr);
    
    // Disabling clock high/low check when clock stops
    // Enabling sclk pause feature
    master_cfg.enable_sclk_pause_feature = 1;
    master_cfg.disable_spi_bus_sclk_pulse_check_upon_sclk_pause= 1;
    master_cfg.min_spi_bus_sclk_pause_multiple_factor= 2; // Expecting clock pause after 20ns(clock_period)*2 =40ns.
   
    slave_cfg.enable_sclk_pause_feature = 1;
    slave_cfg.disable_spi_bus_sclk_pulse_check_upon_sclk_pause= 1;
    slave_cfg.min_spi_bus_sclk_pause_multiple_factor= 2; // Expecting clock pause after 20ns(clock_period)*2 =40ns.

    uvm_config_db#(uvm_object_wrapper)::set(this, "env.sequencer.main_phase", "default_sequence", 
					                                  spi_null_virtual_sequence::type_id::get());
    
    master_directed_sclk_pause_sequence = spi_flash_directed_sclk_pause_sequence::type_id::create("master_directed_sclk_pause_sequence");
    slave_directed_sclk_pause_sequence  = spi_flash_directed_sclk_pause_sequence::type_id::create("slave_directed_sclk_pause_sequence");
  endfunction : build_phase  
  
  task main_phase(uvm_phase phase);
    `uvm_info("main_phase", "Entered ...",UVM_LOW)

    master_directed_sclk_pause_sequence.set_sequencer(env.sequencer.master_sequencer);
    slave_directed_sclk_pause_sequence.set_sequencer(env.sequencer.slave_sequencer);

    super.main_phase(phase);

    if (phase!=null) begin
      phase.raise_objection(this);
    end

    fork
      begin
        master_directed_sclk_pause_sequence.start(env.sequencer.master_sequencer);
      end
      begin
        slave_directed_sclk_pause_sequence.start(env.sequencer.slave_sequencer);
      end
    join

    if (phase!=null) begin
      phase.drop_objection(this);
    end
                
  endtask
endclass

//----------------------------------------------------------------------------
//--------------------------END OF FILE---------------------------------------
//----------------------------------------------------------------------------
