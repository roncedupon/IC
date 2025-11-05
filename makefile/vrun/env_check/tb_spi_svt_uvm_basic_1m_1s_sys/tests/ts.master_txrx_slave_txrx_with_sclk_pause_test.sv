
/**
 * Abstract:
 * This test is used to validate SCLK pause feature with SCLK paused <br/>
 * within valid expected range. It is expected that Slave will detect <br/>
 * the SCLK pause and will not trigger SCLK Period Check. <br/>
 */

`include "spi_base_test.sv"
`include "spi_default_virtual_sequence.sv"

class master_txrx_slave_txrx_with_sclk_pause_test extends spi_base_test;

  /** UVM component utility macro */
  `uvm_component_utils(master_txrx_slave_txrx_with_sclk_pause_test)

  /** Variables to calculate the baud rate divisor*/
  bit [2:0] sppr = 0;
  bit [2:0] spr  = 0;

  /** Class constructor */
  function new(string name = "master_txrx_slave_txrx_with_sclk_pause_test", uvm_component parent=null);
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
  
    // Disabling clock high/low check when clock stops
    // Enabling sclk pause feature
    master_cfg.enable_sclk_pause_feature = 1;
    master_cfg.disable_spi_bus_sclk_pulse_check_upon_sclk_pause= 1;
    master_cfg.min_spi_bus_sclk_pause_multiple_factor= 2; // Expecting clock pause after 20ns(clock_period)*2 =40ns.
    slave_cfg.enable_sclk_pause_feature = 1;
    slave_cfg.disable_spi_bus_sclk_pulse_check_upon_sclk_pause= 1;
    slave_cfg.min_spi_bus_sclk_pause_multiple_factor= 2; // Expecting clock pause after 20ns(clock_period)*2 =40ns.

    // Configuring min sclk period to 20ns
    master_cfg.min_spi_bus_sclk_period_ns = (20/1ns);
    slave_cfg.min_spi_bus_sclk_period_ns  = (20/1ns);
    
    /** Apply the null virtual sequence to the SPI ENV virtual sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.sequencer.main_phase", "default_sequence", 
					    spi_default_virtual_sequence::type_id::get());

    /** Set the sequence 'length' to generate 10 transaction with constraints */
    uvm_config_db#(int unsigned)::set(this, "env.sequencer.spi_default_virtual_sequence", 
				      "sequence_length", 50);

  endfunction : build_phase  

endclass : master_txrx_slave_txrx_with_sclk_pause_test

//----------------------------------------------------------------------------
//--------------------------END OF FILE---------------------------------------
//----------------------------------------------------------------------------
