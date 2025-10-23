
/**
 * Abstract:<br/>
 * This test validates error scenario, executing sequence with trailing timer <br/>
 * less than minimum required trailing timer i.e one half SCLK.               <br/>
 * Error is inserted using exception callback.                               <br/>  
 */

`include "spi_base_test.sv"

class exception_minimum_trailing_timer_test extends spi_base_test;

  // Sequence length set as 10.
  int sequence_length = 10;
  
  /** Instances of the customer exception data and exception factory */
  cust_svt_spi_txrx_master_callback_min_trailing_timer_error master_cust_callback;

  /** UVM component utility macro */
  `uvm_component_utils(exception_minimum_trailing_timer_test)

  /** Class constructor */
  function new(string name = "exception_minimum_trailing_timer_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new
  
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered ...", UVM_LOW)
    super.build_phase(phase);

    /** Create the customer callback class */
    master_cust_callback = new("master_cust_callback",master_cfg);

    /** Apply the null virtual sequence to the SPI ENV virtual sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.sequencer.main_phase", "default_sequence", 
					    spi_random_timing_virtual_sequence::type_id::get());

    /** Set the min_timer_trailing in sequence. */
    uvm_config_db#(int)::set(this, "env.sequencer.spi_random_timing_virtual_sequence", 
          			      "max_timer_trailing", 1);

    /** Set the sequence 'length' to generate 10 transaction with constraints */
    uvm_config_db#(int unsigned)::set(this, "env.sequencer.spi_random_timing_virtual_sequence", 
				      "sequence_length", sequence_length);

  endfunction : build_phase  
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    //add the callback to the driver of master/slave agent
    uvm_callbacks#(svt_spi_txrx,cust_svt_spi_txrx_master_callback_min_trailing_timer_error)::add(env.master_agent.txrx, master_cust_callback);
    uvm_callbacks#(svt_spi_txrx,cust_svt_spi_txrx_master_callback_min_trailing_timer_error)::display();
  endfunction: connect_phase

  task configure_phase(uvm_phase phase);
    super.configure_phase(phase);
    /** 
     * For sequence length set as 10, "svt_err_spi_min_trailing_time" checker
     * is expected to trigger minimum 5 number of times as error exception is
     * inserted for every alterate transaction.
     * Expected DUT/VIP check demotion.
     */
    set_master_vip_checks_to_expected("svt_err_spi_min_trailing_time",sequence_length/2);
    set_slave_vip_checks_to_expected("svt_err_spi_min_trailing_time",sequence_length/2);
  endtask

endclass

//----------------------------------------------------------------------------
//--------------------------END OF FILE---------------------------------------
//----------------------------------------------------------------------------
