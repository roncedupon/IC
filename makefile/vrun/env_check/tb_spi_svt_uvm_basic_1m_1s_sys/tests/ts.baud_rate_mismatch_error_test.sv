
/**
 * Abstract:
 * This test validates baud rate mismatch error scenario.<br/>
 */
class baud_rate_mismatch_error_test extends spi_base_test;

  /** Variables to calculate the baud rate divisor*/
  bit [2:0] sppr = 0;
  bit [2:0] spr  = 0;
  bit status;
  /** UVM component utility macro */
  `uvm_component_utils(baud_rate_mismatch_error_test)

  /** Class constructor */
  function new(string name = "baud_rate_mismatch_error_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction : new
  
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered ...", UVM_LOW)

    super.build_phase(phase);
    status = std::randomize(sppr, spr); 
    if (!status) begin
      `uvm_error("build_phase", "sppr and spr randomization failed");
    end
    master_cfg.sppr = this.sppr;
    master_cfg.spr  = this.spr;

    slave_cfg.sppr  = this.sppr + 1;
    slave_cfg.spr   = this.spr  + 1;

    // Reconfiguring min sclk period as per updated sppr and spr values.
    master_cfg.min_spi_bus_sclk_period_ns = set_min_sclk_period(simulation_cycle,master_cfg.sppr,master_cfg.spr);
    slave_cfg.min_spi_bus_sclk_period_ns = set_min_sclk_period(simulation_cycle,master_cfg.sppr,master_cfg.spr);

    /** Apply the null virtual sequence to the SPI ENV virtual sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.sequencer.main_phase", "default_sequence", 
					    spi_default_virtual_sequence::type_id::get());

    /** Set the sequence_length to configure transaction iterations.*/
    uvm_config_db#(int unsigned)::set(this, "env.sequencer.default_virtual_seq", 
				      "sequence_length", 5);

  endfunction : build_phase 

  task configure_phase(uvm_phase phase);
    super.configure_phase(phase);
    /** Expected DUT/VIP check demotion. */                     
    set_slave_vip_checks_to_expected("svt_err_spi_invalid_baud_rate");
  endtask
endclass

//----------------------------------------------------------------------------
//--------------------------END OF FILE---------------------------------------
//----------------------------------------------------------------------------
