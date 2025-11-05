
/**
 * Abstract:<br/>
 * This test validates error scenario, override tristated lane during device is in data phase.<br/>
 * Error is inserted using exception callback.                                                <br/>  
 */

`include "spi_base_test.sv"
`include "spi_master_tx_slave_rx_virtual_sequence.sv"

class exception_override_data_phase_tristate_master_tx_slave_rx_test extends spi_base_test;

  /** Instances of the customer exception data and exception factory */
  cust_svt_spi_txrx_callback_override_data_phase_tristate_error slave_cust_callback;

  /** UVM component utility macro */
  `uvm_component_utils(exception_override_data_phase_tristate_master_tx_slave_rx_test)

  /** Class constructor */
  function new(string name = "exception_override_data_phase_tristate_master_tx_slave_rx_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new
  
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered ...", UVM_LOW)
    super.build_phase(phase);

    /** Create the customer callback class */
    slave_cust_callback  = new("slave_cust_callback" ,slave_cfg);

    /** Apply the null virtual sequence to the SPI ENV virtual sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.sequencer.main_phase", "default_sequence", 
					    spi_master_tx_slave_rx_virtual_sequence::type_id::get());

    /** Set the sequence 'length' to generate 50 transaction with constraints */
    uvm_config_db#(int unsigned)::set(this, "env.sequencer.spi_master_tx_slave_rx_virtual_sequence", 
				      "sequence_length", 50);

  endfunction : build_phase  
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    //add the callback to the driver of master/slave agent
    uvm_callbacks#(svt_spi_txrx,cust_svt_spi_txrx_callback_override_data_phase_tristate_error)::add(env.slave_agent.txrx, slave_cust_callback);
    uvm_callbacks#(svt_spi_txrx,cust_svt_spi_txrx_callback_override_data_phase_tristate_error)::display();
  endfunction: connect_phase

  task configure_phase(uvm_phase phase);
    super.configure_phase(phase);
    /** Expected DUT/VIP check demotion. */                     
    set_master_vip_checks_to_expected("svt_err_spi_invalid_data_phase_content");
    set_slave_vip_checks_to_expected("svt_err_spi_invalid_data_phase_content");
  endtask
endclass

//----------------------------------------------------------------------------
//--------------------------END OF FILE---------------------------------------
//----------------------------------------------------------------------------
