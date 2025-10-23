
/**
 * Abstract:
 * This test generates a scenario to verify data frame width<br/>
 * reconfiguration feature of SPI generic mode. In this test<br/>
 * data frame width is reconfigured to a new value.         <br/>
 */
class master_tx_slave_rx_with_reconfigurable_data_frame_width_test extends spi_base_test;

  spi_master_tx_slave_rx_virtual_sequence master_tx_slave_rx_virtual_seq; 

  /** UVM component utility macro */
  `uvm_component_utils(master_tx_slave_rx_with_reconfigurable_data_frame_width_test)

  /** Class constructor */
  function new(string name = "master_tx_slave_rx_with_reconfigurable_data_frame_width_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction : new
  
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered ...", UVM_LOW)

    //Enable the configurable data frame width feature.
    enable_configurable_data_frame_width = 1'b1;

    super.build_phase(phase);
      
    /** Apply the null virtual sequence to the SPI ENV virtual sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.sequencer.main_phase", "default_sequence", 
					    spi_null_virtual_sequence::type_id::get());

    /** Set the sequence_length to configure transaction iterations.*/
    uvm_config_db#(int unsigned)::set(this, "env.sequencer.master_tx_slave_rx_virtual_seq", 
				      "sequence_length", 5);

  endfunction : build_phase 

  task main_phase(uvm_phase phase);
    bit status;
    int data_frame_width = 1;
    longint start_addr = 'h0;
    longint max_addr;
    bit [`SVT_SPI_DATA_WIDTH-1:0] rand_pattern_start_value = `SVT_SPI_DATA_WIDTH'h0;

    `uvm_info("main_phase", "Entered ...", UVM_LOW)
    super.main_phase(phase);

    master_tx_slave_rx_virtual_seq = spi_master_tx_slave_rx_virtual_sequence::type_id::create("master_tx_slave_rx_virtual_seq");

    if (phase != null)
      phase.raise_objection(this);

    master_tx_slave_rx_virtual_seq.start(env.sequencer);

    //Reconfigure the data frame width.
    if (enable_configurable_data_frame_width) begin
      status = std::randomize(data_frame_width) with {data_frame_width inside {[1:`SVT_SPI_DATA_WIDTH]};};
      if (!status)
        `uvm_error("main_phase", "data_frame_width randomization failed")

      master_cfg.data_frame_width = data_frame_width;
      slave_cfg.data_frame_width  = data_frame_width;
      `uvm_info("main_phase", $sformatf("Reconfiguring the data frame width to value = %d",data_frame_width), UVM_LOW);
      `uvm_info("main_phase", $sformatf("Latest Master Configuration : \n%s",master_cfg.sprint()),UVM_LOW);
      `uvm_info("main_phase", $sformatf("Latest Slave Configuration  : \n%s",slave_cfg.sprint()),UVM_LOW);
      env.master_agent.reconfigure(master_cfg);
      env.slave_agent.reconfigure(slave_cfg);

      //Initialize the mem_core after mem sequencer reconfiguration.
      if (enable_mem_core) begin
        max_addr = ((1 << slave_cfg.spi_mem_cfg.addr_width) - 1);

        if(slave_mem_backdoor != null)begin
          `uvm_info("configure_phase",$sformatf(" Initialize the Memory with Random Pattern"), UVM_LOW);
          /** Initialize Slave memory with random data pattern*/
          slave_mem_backdoor.initialize(svt_mem_backdoor::INIT_RAND, rand_pattern_start_value, start_addr, max_addr) ;
        end  
        else begin
          `uvm_fatal("configure_phase", "slave_mem_backdoor handle is null from slave agent");
        end

        if(master_mem_backdoor != null)begin
          `uvm_info("configure_phase",$sformatf(" Initialize the Memory with Random Pattern"), UVM_LOW);
          /** Initialize Master memory with random data pattern*/
          master_mem_backdoor.initialize(svt_mem_backdoor::INIT_RAND, rand_pattern_start_value, start_addr, max_addr) ;
        end  
        else begin
          `uvm_fatal("configure_phase", "master_mem_backdoor handle is null from master agent");
        end
      end 
    end 

    master_tx_slave_rx_virtual_seq.start(env.sequencer);

    `uvm_info("main_phase", "Exited ...", UVM_LOW)

    if (phase != null)
      phase.drop_objection(this);

  endtask

endclass

//----------------------------------------------------------------------------
//--------------------------END OF FILE---------------------------------------
//----------------------------------------------------------------------------
