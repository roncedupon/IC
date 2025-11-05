/**
 * Abstract:<br/>
 * This test validates error scenario, violating minimum sclk period. <br/> 
 * The error check will be triggered for every clock period violation. <br/>   
 * Error is generated through sclk pause feature of configuration.      <br/>  
 */

`include "spi_base_test.sv"

class exception_clock_period_with_sclk_pause_test extends spi_base_test;

  spi_flash_directed_sclk_pause_sequence    master_directed_sclk_pause_sequence;
  spi_flash_directed_sclk_pause_sequence    slave_directed_sclk_pause_sequence;
  
  /** Variables to calculate the baud rate divisor*/
  bit [2:0] sppr = 0;
  bit [2:0] spr  = 0;

  /** UVM component utility macro */
  `uvm_component_utils(exception_clock_period_with_sclk_pause_test)

  /** Class constructor */
  function new(string name = "exception_clock_period_with_sclk_pause_test", uvm_component parent=null);
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
  
    // Configuring min sclk period more than sclk pause period(50ns), 
    // to violate "svt_err_spi_min_sclk_period" during sclk stop pause.
    master_cfg.min_spi_bus_sclk_period_ns = (70/1ns);
    slave_cfg.min_spi_bus_sclk_period_ns  = (70/1ns);
    
    // Disabling Baud rate check and clock high/low check when clock stops
    // Enabling sclk pause feature
    master_cfg.enable_baud_rate_check = 0;
    master_cfg.enable_sclk_pause_feature = 1;
    slave_cfg.enable_sclk_pause_feature = 1;
    slave_cfg.enable_baud_rate_check = 0;

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

  task configure_phase(uvm_phase phase);
    super.configure_phase(phase);
    /** 
     * Expected DUT/VIP check demotion.
     */
    set_master_vip_checks_to_expected("svt_err_spi_min_sclk_period");
    set_slave_vip_checks_to_expected("svt_err_spi_min_sclk_period");
  endtask
endclass

//----------------------------------------------------------------------------
//--------------------------END OF FILE---------------------------------------
//----------------------------------------------------------------------------
