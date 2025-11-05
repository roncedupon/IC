
/**
 * Abstract:<br/>
 * This test validates error scenario, violating minimum sclk period. <br/>
 * Error is inserted by updated "min_spi_bus_sclk_period_ns" more than running sclk period. <br/>  
 */

`include "spi_base_test.sv"

class exception_clock_period_test extends spi_base_test;

  // Sequence length set as 5.
  int sequence_length = 5;
  
  /** Variables to calculate the baud rate divisor*/
  bit [2:0] sppr = 0;
  bit [2:0] spr  = 0;

  /** UVM component utility macro */
  `uvm_component_utils(exception_clock_period_test)

  /** Class constructor */
  function new(string name = "exception_clock_period_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new
  
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered ...", UVM_LOW)
    min_data_frame_width = 2;
    super.build_phase(phase);

    /** For Expected Bus_Clk frequency of 100 MHz and SPPR =0 and SPR = 0, SCLK frequency will be 50 MHz. */
    master_cfg.sppr = this.sppr;
    master_cfg.spr  = this.spr;
    slave_cfg.sppr  = this.sppr;
    slave_cfg.spr   = this.spr;
  
    /** Setting min sclk period to 40ns i.e 25 MHz.*/
    master_cfg.min_spi_bus_sclk_period_ns = (40/1ns);
    slave_cfg.min_spi_bus_sclk_period_ns = (40/1ns);

    /** Set the min_timer_idling in sequence. */
    uvm_config_db#(int)::set(this, "env.sequencer.spi_random_timing_virtual_sequence", 
        			      "min_timer_idling_between_transfers", 2);

    /** Set the min_transmit delay in sequence. */
    uvm_config_db#(int)::set(this, "env.sequencer.spi_random_timing_virtual_sequence", 
        			      "min_transmit_delay", 1);
    
    /** Set the min_timer_leading in sequence. */
    uvm_config_db#(int)::set(this, "env.sequencer.spi_random_timing_virtual_sequence", 
          			      "min_timer_leading", 2);

    /** Set the min_timer_trailing in sequence. */
    uvm_config_db#(int)::set(this, "env.sequencer.spi_random_timing_virtual_sequence", 
          			      "min_timer_trailing", 2);

    /** Apply the null virtual sequence to the SPI ENV virtual sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.sequencer.main_phase", "default_sequence", 
					    spi_random_timing_virtual_sequence::type_id::get());

    /** Set the sequence 'length' to generate 50 transaction with constraints */
    uvm_config_db#(int unsigned)::set(this, "env.sequencer.spi_random_timing_virtual_sequence", 
				      "sequence_length", sequence_length);

  endfunction : build_phase  
  
  task configure_phase(uvm_phase phase);
    super.configure_phase(phase);
    /** 
     * For sequence length set as 5, "svt_err_spi_min_sclk_period" checker
     * is expected to trigger minimum 5 number of times.
     * Expected DUT/VIP check demotion.
     */
    set_master_vip_checks_to_expected("svt_err_spi_min_sclk_period",sequence_length);
    set_slave_vip_checks_to_expected("svt_err_spi_min_sclk_period",sequence_length);
  endtask

endclass

//----------------------------------------------------------------------------
//--------------------------END OF FILE---------------------------------------
//----------------------------------------------------------------------------
