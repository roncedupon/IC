`ifdef SVT_UVM_TECHNOLOGY
  `uvm_analysis_imp_decl(_master_tx)
  `uvm_analysis_imp_decl(_slave_tx)
  `uvm_analysis_imp_decl(_master_rx)
  `uvm_analysis_imp_decl(_slave_rx)
`elsif SVT_OVM_TECHNOLOGY
  `ovm_analysis_imp_decl(_master_tx)
  `ovm_analysis_imp_decl(_slave_tx)
  `ovm_analysis_imp_decl(_master_rx)
  `ovm_analysis_imp_decl(_slave_rx)
`endif  
  

`ifdef SVT_UVM_TECHNOLOGY
  class spi_monitor_scoreboard extends uvm_scoreboard;

  // -------------------------------------------------------------------------------------------------
  // Analysis Ports
  // -------------------------------------------------------------------------------------------------
  /**
   * Analysis port to collect data from tx side of master.
   */
  uvm_analysis_imp_master_tx #(svt_spi_transaction, spi_monitor_scoreboard) item_collected_master_tx;
  uvm_component reporter = this;
  
  /**
   * Analysis port to collect data from tx side of slave.
   */
  uvm_analysis_imp_slave_tx #(svt_spi_transaction, spi_monitor_scoreboard) item_collected_slave_tx;
  
  /**
   * Analysis port to collect data from rx side of master.
   */
  uvm_analysis_imp_master_rx #(svt_spi_transaction, spi_monitor_scoreboard) item_collected_master_rx;
  
  /**
   * Analysis port to collect data from rx side of slave.
   */
  uvm_analysis_imp_slave_rx #(svt_spi_transaction, spi_monitor_scoreboard) item_collected_slave_rx;

`elsif SVT_OVM_TECHNOLOGY
  class spi_monitor_scoreboard extends ovm_scoreboard;
  
  // -------------------------------------------------------------------------------------------------
  // Analysis Ports
  // -------------------------------------------------------------------------------------------------
  /**
   * Analysis port to collect data from tx side of master.
   */
  ovm_analysis_imp_master_tx #(svt_spi_transaction, spi_monitor_scoreboard) item_collected_master_tx;
  ovm_component reporter = this;
  
  /**
   * Analysis port to collect data from tx side of slave.
   */
  ovm_analysis_imp_slave_tx #(svt_spi_transaction, spi_monitor_scoreboard) item_collected_slave_tx;
  
  /**
   * Analysis port to collect data from rx side of master.
   */
  ovm_analysis_imp_master_rx #(svt_spi_transaction, spi_monitor_scoreboard) item_collected_master_rx;
  
  /**
   * Analysis port to collect data from rx side of slave.
   */
  ovm_analysis_imp_slave_rx #(svt_spi_transaction, spi_monitor_scoreboard) item_collected_slave_rx;
`endif

  /**
   * enable : Parameter to enable scoreboard. <br/>
   * Default Value: 1
   */
  bit enable;
  /**
   * Integer counters: <br/>
   * count_mismatch_tx: This is the nummber of data mismaches counter in 1 simulation. <br/>
   * This mismatch is between master Tx and slave Rx. <br/>
   * This counter is displayed in scoreboard report. <br/>
   */
  int count_mismatch_tx;
  /**
   * Integer counters: <br/>
   * count_mismatch_rx: This is the nummber of data mismaches counter in 1 simulation. <br/>
   * This mismatch is between master Rx and slave Tx. <br/>
   * This counter is displayed in scoreboard report. <br/>
   */
  int count_mismatch_rx;
  /**
   * Integer counters: <br/>
   * count_master_tx: Number of Packets Transmitted by master.
   */
  int count_master_tx;
  /**
   * Integer counters: <br/>
   * count_slave_tx: Number of Packets Transmitted by slave.
   */
  int count_slave_tx;
  /**
   * Integer counters: <br/>
   * count_master_rx: Number of Packets Received by master.
   */
  int count_master_rx;
  /**
   * Integer counters: <br/>
   * count_slave_rx: Number of Packets Received by slave.
   */
  int count_slave_rx;  
  /**
   * Queue to store transactions from master TX side
   */
  svt_spi_transaction master_tx_trans[$];
  
  /**
   * Queue to store transactions from slave TX side
   */
  svt_spi_transaction slave_tx_trans[$];
  
  /**
   * Queue to store transactions from master RX side
   */
  svt_spi_transaction master_rx_trans[$];
  
  /**
   * Queue to store transactions from slave RX side
   */
  svt_spi_transaction slave_rx_trans[$];

  /** Configuration Instance for master agent */
  svt_spi_agent_configuration master_cfg;

  /** Configuration Instance for slave agent */
  svt_spi_agent_configuration slave_cfg;

  /** Mem backdoor pointer into the master mem_core that we are testing */
  svt_mem_backdoor master_mem_backdoor;

  /** Mem backdoor pointer into the slave mem_core that we are testing */
  svt_mem_backdoor slave_mem_backdoor;

  /** This fields stores the mem core maximum accessible address values<br/>
   * under different modes.                                            <br/>
   */
  bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] mem_core_end_address;
  bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] master_tx_mem_start_address;  
  bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] master_tx_mem_end_address;  
  bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] master_rx_mem_start_address;   
  bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] master_rx_mem_end_address;   
  bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] slave_tx_mem_start_address;    
  bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] slave_tx_mem_end_address;    
  bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] slave_rx_mem_start_address;    
  bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] slave_rx_mem_end_address;    

  /**
   * Counter to keep track of the number of packets droped from the Master Tx & Rx queue. <br/>
   * This value is printed in the scoreboard report in the end. 
   */
  int packet_drop_master;
  
  /**
   * Counter to keep track of the number of packets droped from the Slave Tx & Rx queue. <br/>
   * This value is printed in the scoreboard report in the end. 
   */
  int packet_drop_slave;

  /**
   * This Method flushes All Queues and pending transaction awaited signals.
   */ 
  extern virtual function void flush_pending_queues ();

  /**
   * This event is triggered when the master transmits a data packet and is received in Scoreboard.
   */
  event master_tx_get_event ; 
  /**
   * This event is triggered when the slave transmits a data packet and is received in Scoreboard.
   */
  event slave_tx_get_event ; 
  /**
   * This event is triggered when the master receives a data packet and is received in Scoreboard.
   */
  event master_rx_get_event ; 
  /**
   * This event is triggered when the slave receives a data packet and is received in Scoreboard.
   */
  event slave_rx_get_event ;

  /**
   * This event is triggered when the Scoreboard finishes comparison of Tx packet.
   */
  event sb_compare_done_tx;

  /**
   * This event is triggered when the Scoreboard finishes comparison of Rx packet.
   */
  event sb_compare_done_rx;

  bit drop_pkt_mstr_tx;
  bit drop_pkt_mstr_rx;
  bit drop_pkt_slv_tx;
  bit drop_pkt_slv_rx;

`ifdef SVT_UVM_TECHNOLOGY
  // -------------------------------------------------------------------------------------------------
  // Uvm utility
  // -------------------------------------------------------------------------------------------------
  `uvm_component_utils_begin(spi_monitor_scoreboard)
   `uvm_field_int(packet_drop_master, UVM_ALL_ON|UVM_DEC|UVM_NOPRINT)
   `uvm_field_int(packet_drop_slave, UVM_ALL_ON|UVM_DEC|UVM_NOPRINT)
   `uvm_field_int(drop_pkt_mstr_tx, UVM_ALL_ON|UVM_DEC|UVM_NOPRINT)
   `uvm_field_int(drop_pkt_mstr_rx, UVM_ALL_ON|UVM_DEC|UVM_NOPRINT)
   `uvm_field_int(drop_pkt_slv_tx, UVM_ALL_ON|UVM_DEC|UVM_NOPRINT)
   `uvm_field_int(drop_pkt_slv_rx, UVM_ALL_ON|UVM_DEC|UVM_NOPRINT)
  `uvm_component_utils_end

`elsif SVT_OVM_TECHNOLOGY
  // -------------------------------------------------------------------------------------------------
  // ovm utility
  // -------------------------------------------------------------------------------------------------
  `ovm_component_utils_begin(spi_monitor_scoreboard)
   `ovm_field_int(packet_drop_master, OVM_ALL_ON|OVM_DEC|OVM_NOPRINT)
   `ovm_field_int(packet_drop_slave, OVM_ALL_ON|OVM_DEC|OVM_NOPRINT)
   `ovm_field_int(drop_pkt_mstr_tx, OVM_ALL_ON|OVM_DEC|OVM_NOPRINT)
   `ovm_field_int(drop_pkt_mstr_rx, OVM_ALL_ON|OVM_DEC|OVM_NOPRINT)
   `ovm_field_int(drop_pkt_slv_tx, OVM_ALL_ON|OVM_DEC|OVM_NOPRINT)
   `ovm_field_int(drop_pkt_slv_rx, OVM_ALL_ON|OVM_DEC|OVM_NOPRINT)
  `ovm_component_utils_end

`endif  
`ifdef SVT_UVM_TECHNOLOGY
  // ---------------------------------------------------------------------------------------------
  // new - constructor
  // ---------------------------------------------------------------------------------------------
  /**
   * This is the constructor of the scoreboard. <br/>
   * In this pahse a counters are initialized to 0.
   */
  extern function new (string name="spi_monitor_scoreboard", uvm_component parent=null);
  
  /**
   * This is the build phase of the Scoreboard. <br/>
   * All the analysis ports are created in this phase. 
   */
  extern function void build_phase(uvm_phase phase);
  
  /** This is the run phase of the Scoreboard. <br/>
   */
  extern task run_phase(uvm_phase phase);
  
  /**
   * This is the report phase of Scoreboard.
   * In this phase the scoreboard report is printed.
   */
  extern virtual function void report_phase(uvm_phase phase);
  
`elsif SVT_OVM_TECHNOLOGY
  // ---------------------------------------------------------------------------------------------
  // new - constructor
  // ---------------------------------------------------------------------------------------------
  /**
   * This is the constructor of the scoreboard. <br/>
   * In this pahse a counters are initialized to 0.
   */
  extern function new (string name="spi_monitor_scoreboard", ovm_component parent=null);
  
  /**
   * This is the build phase of the Scoreboard. <br/>
   * All the analysis ports are created in this phase. 
   */
  extern function void build();
  
  /** This is the run phase of the Scoreboard. <br/>
   */
  extern task run();
  
  /**
   * This is the report phase of Scoreboard.
   * In this phase the scoreboard report is printed.
   */
  extern virtual function void report();
`endif  
  /**
   * This task compares the master transactions transmitted and slave transactions received.
   */
  extern task master_tx_slave_rx_comparator();
  
  /**
   * This task compares the slave transactions transmitted and master transactions received.
   */
  extern task slave_tx_master_rx_comparator();

  /**
   * The compare task compares the two transactions from TX and RX queue. <br/>
   * It prints out the data bytes which are mismached. <br/>
   * It prints a 'MATCHED' print if transactions are matched.
   */
  extern function bit scb_compare(svt_spi_transaction master_tr,svt_spi_transaction slave_tr);

  /**
   * The compare task compares the two transactions from TX and RX queue. <br/>
   * It prints out the control word bytes which are mismached. <br/>
   * It prints a 'MATCHED' print if transactions are matched.
   */
  extern virtual function bit scb_control_word_compare(svt_spi_transaction master_tr,svt_spi_transaction slave_tr);

  /**
   * The compare task compares the mem core data from master and slave<br/>
   * agent. Memory data is being read by backdoor access to the master<br/>
   * and slave agent mem core instance and then compared. If the data <br/>
   * is mismatched, it flags error and prints out the mismatched data.<br/>
   * If the data is matched, with the suitable verbosity set,it prints<br/>
   * the matched data.                                                <br/>
   */
  extern virtual function bit scb_compare_mem_core_data(svt_spi_transaction master_tr, svt_spi_transaction slave_tr,
                                                        bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] master_mem_start_address,
                                                        bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] master_mem_end_address,
                                                        bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] slave_mem_start_address,
                                                        bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] slave_mem_end_address);
  
  /**
   * The write function implementaions for the analysis port item_collected_master_tx.
   */
  extern virtual function void write_master_tx(svt_spi_transaction tr);
  
  /**
   * The write function implementaions for the analysis port item_collected_slave_tx.
   */
  extern virtual function void write_slave_tx(svt_spi_transaction tr);
  
  /**
   * The write function implementaions for the analysis port item_collected_master_rx.
   */
  extern virtual function void write_master_rx(svt_spi_transaction tr);
  
  /**
   * The write function implementaions for the analysis port item_collected_slave_rx.
   */
  extern virtual function void write_slave_rx(svt_spi_transaction tr);

  /**
   * The routine is used to enable/disable the Scoreboard 
   */
  extern virtual function void set_scbd_enable(bit en);

  /**
   * The routine is used to drop the next packet reported at Master Tx and Rx
   * Queue. This routine shall be used only when we expect to drop packet at
   * Both Queue. This will be used to ignore the reported packet at scoreboard for 
   * scenarios like reset occuring during an ongoing 1transaction etc.
   */
  extern virtual task drop_packet_master();

  /**
   * The routine is used to drop the next packet reported at Master Tx Queue.
   * This will be used to ignore the reported packet at scoreboard for 
   * scenarios like reset occuring during an ongoing 1transaction etc.
   */
  extern virtual task drop_packet_master_tx();
  /**
   * The routine is used to drop the next packet reported at Master Rx Queue.
   * This will be used to ignore the reported packet at scoreboard for 
   * scenarios like reset occuring during an ongoing 1transaction etc.
   */
  extern virtual task drop_packet_master_rx();
  
  /**
   * The routine is used to drop the next packet reported at Slave Tx and Rx
   * Queue. This will be used to ignore the reported packet at scoreboard for 
   * scenarios like reset occuring during an ongoing 1transaction etc.
   */
  extern virtual task drop_packet_slave();

  /**
   * The routine is used to drop the next packet reported at Slave Tx Queue.
   * This will be used to ignore the reported packet at scoreboard for 
   * scenarios like reset occuring during an ongoing 1transaction etc.
   */
  extern virtual task drop_packet_slave_tx();

  /**
   * The routine is used to drop the next packet reported at Slave Rx Queue.
   * This will be used to ignore the reported packet at scoreboard for 
   * scenarios like reset occuring during an ongoing 1transaction etc.
   */
  extern virtual task drop_packet_slave_rx();

  /**
   * This function compares two safe SPI transactions from TX and RX<br/>
   * queue. It prints out safe spi frame which are mismatched and   <br/>
   * it prints a 'MATCHED' print if transactions are matched.       <br/>  
   */
  extern virtual function bit scb_compare_spi_safe_frame(svt_spi_transaction master_tr,svt_spi_transaction slave_tr, bit master_tx_slave_rx=0, bit slave_tx_master_rx=0);

endclass

`ifdef SVT_UVM_TECHNOLOGY
  function spi_monitor_scoreboard::new (string name="spi_monitor_scoreboard", uvm_component parent=null);
`elsif SVT_OVM_TECHNOLOGY
  function spi_monitor_scoreboard::new (string name="spi_monitor_scoreboard", ovm_component parent=null);
`endif  
    super.new(name, parent);
    enable=1;
    count_mismatch_tx=0;
    count_mismatch_rx=0;
    count_master_tx=0;
    count_slave_tx=0;
    count_master_rx=0;
    count_slave_rx=0;
    packet_drop_master=0;
    packet_drop_slave=0;
    drop_pkt_mstr_tx=0;
    drop_pkt_mstr_rx=0;
    drop_pkt_slv_tx=0;
    drop_pkt_slv_rx=0;
  endfunction : new

// -------------------------------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY
  task spi_monitor_scoreboard::run_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  task spi_monitor_scoreboard::run();
`endif  
  begin
     fork
       master_tx_slave_rx_comparator();
       slave_tx_master_rx_comparator();
     join_none
   end
 endtask

// ---------------------------------------------------------------------------------------------
`ifdef SVT_UVM_TECHNOLOGY
  function void spi_monitor_scoreboard::build_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  function void spi_monitor_scoreboard::build();
    ovm_object master_cfg_obj;
    ovm_object slave_cfg_obj;
`endif  
    item_collected_master_rx = new("item_collected_master_rx", this);
    item_collected_slave_rx  = new("item_collected_slave_rx", this);
    item_collected_master_tx = new("item_collected_master_tx", this);
    item_collected_slave_tx  = new("item_collected_slave_tx", this);
  
`ifdef SVT_UVM_TECHNOLOGY
    /** Get the configuration using config_db */
    void'(uvm_config_db#(svt_spi_agent_configuration)::get(this, "", "master_cfg", this.master_cfg));
    /** Get the configuration using config_db */
    void'(uvm_config_db#(svt_spi_agent_configuration)::get(this, "", "slave_cfg", this.slave_cfg));
    
    
`elsif SVT_OVM_TECHNOLOGY
    /** Get the MASTER configuration using config_db */
    if (!get_config_object("master_cfg", master_cfg_obj, 0)) begin
        `ovm_fatal("build", "A cust_svt_spi_agent_configuration object must be set using the ovm configuration infrastructure.");
    end
    else begin
      if (!$cast(master_cfg, master_cfg_obj)) begin
        `ovm_fatal("build", "The configuration object received was not $cast compatible with cust_svt_spi_agent_configuration.");
      end
    end  
    /** Get the SLAVE configuration using config_db */
    if (!get_config_object("slave_cfg", slave_cfg_obj, 0)) begin
      `ovm_fatal("build", "A cust_svt_spi_agent_configuration object must be set using the ovm configuration infrastructure.");
    end
    else begin
      if (!$cast(slave_cfg, slave_cfg_obj)) begin
        `ovm_fatal("build", "The configuration object received was not $cast compatible with cust_svt_spi_agent_configuration.");
      end
    end  
`endif  
  
    /** Calculate master and slave memory address boundaries.*/
    if ((master_cfg !=null) && (slave_cfg!=null) &&
        (master_cfg.enable_mem_core && slave_cfg.enable_mem_core)) begin
      mem_core_end_address        = ((1 << master_cfg.spi_mem_cfg.addr_width) -1);
      master_tx_mem_start_address = 0;
      slave_tx_mem_start_address  = 0; 
      if (master_cfg.frame_format == svt_spi_types::SPI_MULTILANE) begin
        master_tx_mem_end_address   = ((1 << master_cfg.spi_mem_cfg.addr_width) -1);
        master_rx_mem_start_address = 0;
        slave_tx_mem_end_address    = ((1 << master_cfg.spi_mem_cfg.addr_width) -1);
        slave_rx_mem_start_address  = 0; 
      end
      else begin
        master_tx_mem_end_address   = ((1 << (master_cfg.spi_mem_cfg.addr_width -1)) -1);
        master_rx_mem_start_address = (1 << (master_cfg.spi_mem_cfg.addr_width -1));
        slave_tx_mem_end_address    = ((1 << (master_cfg.spi_mem_cfg.addr_width -1)) -1);
        slave_rx_mem_start_address = (1 << (master_cfg.spi_mem_cfg.addr_width -1));
      end
      master_rx_mem_end_address   = mem_core_end_address;
      slave_rx_mem_end_address    = mem_core_end_address;
`ifdef SVT_UVM_TECHNOLOGY
      `uvm_info("build_phase", $sformatf("mem_core_end_address        = 'h%0h",  mem_core_end_address), UVM_HIGH);
      `uvm_info("build_phase", $sformatf("master_tx_mem_start_address = 'h%0h",master_tx_mem_start_address), UVM_HIGH);
      `uvm_info("build_phase", $sformatf("master_tx_mem_end_address   = 'h%0h",master_tx_mem_end_address), UVM_HIGH);
      `uvm_info("build_phase", $sformatf("master_rx_mem_start_address = 'h%0h",master_rx_mem_start_address), UVM_HIGH);
      `uvm_info("build_phase", $sformatf("master_rx_mem_end_address   = 'h%0h",master_rx_mem_end_address), UVM_HIGH);
      `uvm_info("build_phase", $sformatf("slave_tx_mem_start_address  = 'h%0h",slave_tx_mem_start_address), UVM_HIGH);
      `uvm_info("build_phase", $sformatf("slave_tx_mem_end_address    = 'h%0h",slave_tx_mem_end_address), UVM_HIGH);
      `uvm_info("build_phase", $sformatf("slave_rx_mem_start_address  = 'h%0h",slave_rx_mem_start_address), UVM_HIGH);
      `uvm_info("build_phase", $sformatf("slave_rx_mem_end_address    = 'h%0h",slave_rx_mem_end_address), UVM_HIGH);
`elsif SVT_OVM_TECHNOLOGY
      `ovm_info("build_phase", $sformatf("mem_core_end_address        = 'h%0h",mem_core_end_address), OVM_HIGH);
      `ovm_info("build_phase", $sformatf("master_tx_mem_start_address = 'h%0h",master_tx_mem_start_address), OVM_HIGH);
      `ovm_info("build_phase", $sformatf("master_tx_mem_end_address   = 'h%0h",master_tx_mem_end_address), OVM_HIGH);
      `ovm_info("build_phase", $sformatf("master_rx_mem_start_address = 'h%0h",master_rx_mem_start_address), OVM_HIGH);
      `ovm_info("build_phase", $sformatf("master_rx_mem_end_address   = 'h%0h",master_rx_mem_end_address), OVM_HIGH);
      `ovm_info("build_phase", $sformatf("slave_tx_mem_start_address  = 'h%0h",slave_tx_mem_start_address), OVM_HIGH);
      `ovm_info("build_phase", $sformatf("slave_tx_mem_end_address    = 'h%0h",slave_tx_mem_end_address), OVM_HIGH);
      `ovm_info("build_phase", $sformatf("slave_rx_mem_start_address  = 'h%0h",slave_rx_mem_start_address), OVM_HIGH);
      `ovm_info("build_phase", $sformatf("slave_rx_mem_end_address    = 'h%0h",slave_rx_mem_end_address), OVM_HIGH);
`endif  
    end
  endfunction

//--------------------------------------------------------------------------------------------------
task spi_monitor_scoreboard::master_tx_slave_rx_comparator();
  svt_spi_transaction      master_tr;
  svt_spi_transaction      slave_tr;
   forever
     begin
       wait((master_tx_trans.size > 0 && slave_rx_trans.size > 0) && ~drop_pkt_mstr_tx && ~drop_pkt_slv_rx); 
`ifdef SVT_UVM_TECHNOLOGY
       `uvm_info("master_tx_slave_rx_comparator",$sformatf("master Tx Queue size  = %d & slave Rx Queue size = %d",master_tx_trans.size ,slave_rx_trans.size),UVM_LOW);
`elsif SVT_OVM_TECHNOLOGY
       `ovm_info("master_tx_slave_rx_comparator",$sformatf("master Tx Queue size  = %0d & slave Rx Queue size = %0d",master_tx_trans.size ,slave_rx_trans.size),OVM_LOW);
`endif  
       master_tr = master_tx_trans.pop_front();
       slave_tr = slave_rx_trans.pop_front();
       if ( 
           (master_cfg !=null && slave_cfg != null) && 
           (master_cfg.enable_mem_core && slave_cfg.enable_mem_core) && 
           ((master_cfg.frame_format == svt_spi_types::SPI_MULTILANE && master_tr.transfer_mode == 2'b01 && slave_tr.transfer_mode == 2'b01) || //WRITE_MODE  
            (master_cfg.frame_format == svt_spi_types::SPI_STD && (master_cfg.spi_feature== svt_spi_types::SPI || master_cfg.spi_feature== svt_spi_types::SSP)  && master_tr.transfer_mode != 2'b11) || // Other than EEPROM_MODE
            (master_cfg.frame_format == svt_spi_types::SPI_STD && master_cfg.spi_feature== svt_spi_types::UWIRE && master_tr.transfer_mode != 2'b00 && master_tr.uwire_deassert_start_bit == 1'b0)) 
          )  begin
         if (!scb_compare_mem_core_data(master_tr, slave_tr, master_tx_mem_start_address,master_tx_mem_end_address, slave_rx_mem_start_address,slave_rx_mem_end_address)) begin
           count_mismatch_tx++;
`ifdef SVT_UVM_TECHNOLOGY
           `uvm_error("master_tx_slave_rx_comparator", $sformatf("SPI transaction from master Not Matched at slave receiver"));
           `uvm_info("master_tx_slave_rx_comparator",$sformatf("Packet Txed by Master Agent is \n%s ",master_tr.sprint()),UVM_LOW);
           `uvm_info("master_tx_slave_rx_comparator",$sformatf("Packet Rxed by Slave  Agent is \n%s ",slave_tr.sprint()),UVM_LOW);
`elsif SVT_OVM_TECHNOLOGY
           `ovm_error("master_tx_slave_rx_comparator", $sformatf("SPI transaction from master Not Matched at slave receiver"));
           `ovm_info("master_tx_slave_rx_comparator",$sformatf("Packet Txed by Master Agent is \n%s ",master_tr.sprint()),OVM_LOW);
           `ovm_info("master_tx_slave_rx_comparator",$sformatf("Packet Rxed by Slave  Agent is \n%s ",slave_tr.sprint()),OVM_LOW);
`endif  
         end
         else begin
`ifdef SVT_UVM_TECHNOLOGY
           `uvm_info("master_tx_slave_rx_comparator", $sformatf("Packet Txed by Active SPI Agent is correctly recieved by slave"),UVM_LOW);
`elsif SVT_OVM_TECHNOLOGY
           `ovm_info("master_tx_slave_rx_comparator", $sformatf("Packet Txed by Active SPI Agent is correctly recieved by slave"),OVM_LOW);
`endif  
         end  
       end  
       else if (master_cfg.frame_format == svt_spi_types::SPI_SAFE && slave_cfg.frame_format == svt_spi_types::SPI_SAFE) begin
         if(!scb_compare_spi_safe_frame(master_tr,slave_tr)) begin
           count_mismatch_tx++;
  `ifdef SVT_UVM_TECHNOLOGY
           `uvm_error("master_tx_slave_rx_comparator", $sformatf("SPI transaction from master Not Matched at slave receiver"));
           `uvm_info("master_tx_slave_rx_comparator",$sformatf("Packet Txed by Master Agent is \n%s ",master_tr.sprint()),UVM_LOW);
           `uvm_info("master_tx_slave_rx_comparator",$sformatf("Packet Rxed by Slave  Agent is \n%s ",slave_tr.sprint()),UVM_LOW);
  `elsif SVT_OVM_TECHNOLOGY
           `ovm_error("master_tx_slave_rx_comparator", $sformatf("SPI transaction from master Not Matched at slave receiver"));
           `ovm_info("master_tx_slave_rx_comparator",$sformatf("Packet Txed by Master Agent is \n%s ",master_tr.sprint()),OVM_LOW);
           `ovm_info("master_tx_slave_rx_comparator",$sformatf("Packet Rxed by Slave  Agent is \n%s ",slave_tr.sprint()),OVM_LOW);
  `endif  
         end
         else begin
`ifdef SVT_UVM_TECHNOLOGY
           `uvm_info("master_tx_slave_rx_comparator", $sformatf("Packet Txed by Active SPI Agent is correctly recieved by slave"),UVM_LOW);
`elsif SVT_OVM_TECHNOLOGY
           `ovm_info("master_tx_slave_rx_comparator", $sformatf("Packet Txed by Active SPI Agent is correctly recieved by slave"),OVM_LOW);
`endif  
         end  
       end  
       else if(!scb_compare(master_tr,slave_tr)) begin
         count_mismatch_tx++;
`ifdef SVT_UVM_TECHNOLOGY
         `uvm_error("master_tx_slave_rx_comparator", $sformatf("SPI transaction from master Not Matched at slave receiver"));
         `uvm_info("master_tx_slave_rx_comparator",$sformatf("Packet Txed by Master Agent is \n%s ",master_tr.sprint()),UVM_LOW);
         `uvm_info("master_tx_slave_rx_comparator",$sformatf("Packet Rxed by Slave  Agent is \n%s ",slave_tr.sprint()),UVM_LOW);
`elsif SVT_OVM_TECHNOLOGY
         `ovm_error("master_tx_slave_rx_comparator", $sformatf("SPI transaction from master Not Matched at slave receiver"));
         `ovm_info("master_tx_slave_rx_comparator",$sformatf("Packet Txed by Master Agent is \n%s ",master_tr.sprint()),OVM_LOW);
         `ovm_info("master_tx_slave_rx_comparator",$sformatf("Packet Rxed by Slave  Agent is \n%s ",slave_tr.sprint()),OVM_LOW);
`endif  
       end
       else
`ifdef SVT_UVM_TECHNOLOGY
         `uvm_info("master_tx_slave_rx_comparator", $sformatf("Packet Txed by Active SPI Agent is correctly recieved by slave"),UVM_LOW);
`elsif SVT_OVM_TECHNOLOGY
         `ovm_info("master_tx_slave_rx_comparator", $sformatf("Packet Txed by Active SPI Agent is correctly recieved by slave"),OVM_LOW);
`endif   

       if( (master_cfg != null) && (master_cfg.frame_format == svt_spi_types::SPI_STD && master_cfg.spi_feature == svt_spi_types::UWIRE) && master_tr.uwire_deassert_start_bit == 1'b0) begin
         if (!scb_control_word_compare(master_tr, slave_tr)) begin
           count_mismatch_tx++;
`ifdef SVT_UVM_TECHNOLOGY
           `uvm_error("master_tx_slave_rx_comparator", $sformatf("SPI transaction from master Not Matched at slave receiver"));
           `uvm_info("master_tx_slave_rx_comparator",$sformatf("Packet Txed by Master Agent is \n%s ",master_tr.sprint()),UVM_LOW);
           `uvm_info("master_tx_slave_rx_comparator",$sformatf("Packet Rxed by Slave  Agent is \n%s ",slave_tr.sprint()),UVM_LOW);
`elsif SVT_OVM_TECHNOLOGY
           `ovm_error("master_tx_slave_rx_comparator", $sformatf("SPI transaction from master Not Matched at slave receiver"));
           `ovm_info("master_tx_slave_rx_comparator",$sformatf("Packet Txed by Master Agent is \n%s ",master_tr.sprint()),OVM_LOW);
           `ovm_info("master_tx_slave_rx_comparator",$sformatf("Packet Rxed by Slave  Agent is \n%s ",slave_tr.sprint()),OVM_LOW);
`endif  
         end
       end

         -> sb_compare_done_tx;
     end
endtask // master_tx_slave_rx_comparator

//--------------------------------------------------------------------------------------------------
task spi_monitor_scoreboard::slave_tx_master_rx_comparator();
  svt_spi_transaction      master_tr;
  svt_spi_transaction      slave_tr;
  forever
    begin
      wait((master_rx_trans.size > 0 && slave_tx_trans.size > 0) && ~drop_pkt_mstr_rx && ~drop_pkt_slv_tx);
`ifdef SVT_UVM_TECHNOLOGY
       `uvm_info("slave_tx_master_rx_comparator",$sformatf("slave Tx Queue size = %0d & master Rx Queue size = %0d",slave_tx_trans.size,master_rx_trans.size),UVM_LOW);
`elsif SVT_OVM_TECHNOLOGY
       `ovm_info("slave_tx_master_rx_comparator",$sformatf("slave Tx Queue size = %0d & master Rx Queue size = %0d",slave_tx_trans.size,master_rx_trans.size),OVM_LOW);
`endif  
      slave_tr  = slave_tx_trans.pop_front();
      master_tr = master_rx_trans.pop_front();
      if ( 
          (master_cfg !=null && slave_cfg != null) && 
          (master_cfg.enable_mem_core && slave_cfg.enable_mem_core) && 
          ((master_cfg.frame_format == svt_spi_types::SPI_MULTILANE && master_tr.transfer_mode == 2'b10 && slave_tr.transfer_mode == 2'b10) || //READ_MODE  
           (master_cfg.frame_format == svt_spi_types::SPI_STD)) //All SPI standard modes
         )  begin
        if (!scb_compare_mem_core_data(master_tr, slave_tr, master_rx_mem_start_address,master_rx_mem_end_address, slave_tx_mem_start_address,slave_tx_mem_end_address)) begin
          count_mismatch_tx++;
`ifdef SVT_UVM_TECHNOLOGY
          `uvm_error("slave_tx_master_rx_comparator", $sformatf("SPI transaction from slave Not Matched at master receiver"));
          `uvm_info("slave_tx_master_rx_comparator",$sformatf("Packet Txed by Slave  Agent is \n%s ",slave_tr.sprint()),UVM_LOW);
          `uvm_info("slave_tx_master_rx_comparator",$sformatf("Packet Rxed by Master Agent is \n%s ",master_tr.sprint()),UVM_LOW);
`elsif SVT_OVM_TECHNOLOGY
          `ovm_error("slave_tx_master_rx_comparator", $sformatf("SPI transaction from slave Not Matched at master receiver"));
          `ovm_info("slave_tx_master_rx_comparator",$sformatf("Packet Txed by Slave  Agent is \n%s ",slave_tr.sprint()),OVM_LOW);
          `ovm_info("slave_tx_master_rx_comparator",$sformatf("Packet Rxed by Master Agent is \n%s ",master_tr.sprint()),OVM_LOW);
`endif  
        end
        else begin
`ifdef SVT_UVM_TECHNOLOGY
          `uvm_info("slave_tx_master_rx_comparator", $sformatf("Packet Txed by slave is correctly recieved by master"),UVM_LOW);
`elsif SVT_OVM_TECHNOLOGY
          `ovm_info("slave_tx_master_rx_comparator", $sformatf("Packet Txed by slave is correctly recieved by master"),OVM_LOW);
`endif  
        end  
      end  
      else if (master_cfg.frame_format == svt_spi_types::SPI_SAFE && slave_cfg.frame_format == svt_spi_types::SPI_SAFE) begin
        if(!scb_compare_spi_safe_frame(master_tr,slave_tr, .slave_tx_master_rx(1'b1))) begin
          count_mismatch_rx++;
  `ifdef SVT_UVM_TECHNOLOGY
          `uvm_error("slave_tx_master_rx_comparator", $sformatf("SPI transaction from slave Not Matched at master receiver"));
          `uvm_info("slave_tx_master_rx_comparator",$sformatf("Packet Txed by Slave  Agent is \n%s ",slave_tr.sprint()),UVM_LOW);
          `uvm_info("slave_tx_master_rx_comparator",$sformatf("Packet Rxed by Master Agent is \n%s ",master_tr.sprint()),UVM_LOW);
  `elsif SVT_OVM_TECHNOLOGY
          `ovm_error("slave_tx_master_rx_comparator", $sformatf("SPI transaction from slave Not Matched at master receiver"));
          `ovm_info("slave_tx_master_rx_comparator",$sformatf("Packet Txed by Slave  Agent is \n%s ",slave_tr.sprint()),OVM_LOW);
          `ovm_info("slave_tx_master_rx_comparator",$sformatf("Packet Rxed by Master Agent is \n%s ",master_tr.sprint()),OVM_LOW);
  `endif  
        end  
        else begin
`ifdef SVT_UVM_TECHNOLOGY
          `uvm_info("slave_tx_master_rx_comparator", $sformatf("Packet Txed by slave is correctly recieved by master"),UVM_LOW);
`elsif SVT_OVM_TECHNOLOGY
          `ovm_info("slave_tx_master_rx_comparator", $sformatf("Packet Txed by slave is correctly recieved by master"),OVM_LOW);
`endif  
        end  
      end
      else if (!scb_compare(master_tr,slave_tr)) begin
        count_mismatch_rx++;
`ifdef SVT_UVM_TECHNOLOGY
        `uvm_error("slave_tx_master_rx_comparator", $sformatf("SPI transaction from slave Not Matched at master receiver"));
        `uvm_info("slave_tx_master_rx_comparator",$sformatf("Packet Txed by Slave  Agent is \n%s ",slave_tr.sprint()),UVM_LOW);
        `uvm_info("slave_tx_master_rx_comparator",$sformatf("Packet Rxed by Master Agent is \n%s ",master_tr.sprint()),UVM_LOW);
`elsif SVT_OVM_TECHNOLOGY
        `ovm_error("slave_tx_master_rx_comparator", $sformatf("SPI transaction from slave Not Matched at master receiver"));
        `ovm_info("slave_tx_master_rx_comparator",$sformatf("Packet Txed by Slave  Agent is \n%s ",slave_tr.sprint()),OVM_LOW);
        `ovm_info("slave_tx_master_rx_comparator",$sformatf("Packet Rxed by Master Agent is \n%s ",master_tr.sprint()),OVM_LOW);
`endif  
      end  
      else
`ifdef SVT_UVM_TECHNOLOGY
        `uvm_info("slave_tx_master_rx_comparator", $sformatf("Packet Txed by slave is correctly recieved by master"),UVM_LOW);
`elsif SVT_OVM_TECHNOLOGY
        `ovm_info("slave_tx_master_rx_comparator", $sformatf("Packet Txed by slave is correctly recieved by master"),OVM_LOW);
`endif  
        
       -> sb_compare_done_rx;
    end
endtask // slave_tx_master_rx_comparator

// ------------------------------------------------------------------------------------------------
function bit spi_monitor_scoreboard::scb_compare(
                                              svt_spi_transaction master_tr,
                                              svt_spi_transaction slave_tr
                                              );
  int common_data_sz;
  scb_compare = 1;
  for (int i=0;i<master_tr.data.size();i++) begin
    
    if (master_tr.data[i] !== slave_tr.data[i]) begin
      scb_compare = 0;
`ifdef SVT_UVM_TECHNOLOGY
      `uvm_error("scb_compare",$sformatf("DATA COMPARE MISMATCH MASTER.DATA[%0d] = %h But SLAVE.DATA[%0d] = %h",i,master_tr.data[i],i,slave_tr.data[i]));
`elsif SVT_OVM_TECHNOLOGY
      `ovm_error("scb_compare",$sformatf("DATA COMPARE MISMATCH MASTER.DATA[%0d] = %h But SLAVE.DATA[%0d] = %h",i,master_tr.data[i],i,slave_tr.data[i]));
`endif  
    end
    else begin
`ifdef SVT_UVM_TECHNOLOGY
      `uvm_info("scb_compare",$sformatf("DATA COMPARE MATCH MASTER.DATA[%0d] = %h & SLAVE.DATA[%0d] = %h",i,master_tr.data[i],i,slave_tr.data[i]),UVM_HIGH);
`elsif SVT_OVM_TECHNOLOGY
      `ovm_info("scb_compare",$sformatf("DATA COMPARE MATCH MASTER.DATA[%0d] = %h & SLAVE.DATA[%0d] = %h",i,master_tr.data[i],i,slave_tr.data[i]),OVM_HIGH);
`endif      
    end
  end
endfunction: scb_compare
// ------------------------------------------------------------------------------------------------
function bit spi_monitor_scoreboard::scb_compare_spi_safe_frame(
                                              svt_spi_transaction master_tr,
                                              svt_spi_transaction slave_tr,
                                              bit master_tx_slave_rx=0,
                                              bit slave_tx_master_rx=0
                                              );
  scb_compare_spi_safe_frame = 1;
  if ((master_tr.spi_safe_status == svt_spi_types::SPI_SAFE_OPERATION_ERROR) || (slave_tr.spi_safe_status == svt_spi_types::SPI_SAFE_OPERATION_ERROR)) begin
`ifdef SVT_UVM_TECHNOLOGY
      `uvm_info("scb_compare_spi_safe_frame",$sformatf("Data Comparison ignored as SPI_SAFE_OPERATION_ERROR asserted while processing the Safe SPI error/exception transaction"),UVM_LOW);
`elsif SVT_OVM_TECHNOLOGY
      `ovm_info("scb_compare_spi_safe_frame",$sformatf("Data Comparison ignored as SPI_SAFE_OPERATION_ERROR asserted while processing the Safe SPI error/exception transaction"),OVM_LOW);
`endif  
      return(1);
  end
  if(slave_tx_master_rx  && master_cfg.spi_safe_frame_mode == svt_spi_types::IN_FRAME)
    //Slave transmits its higher 5 MSB as high-Z.
    slave_tr.spi_safe_frame = slave_tr.spi_safe_frame[`SVT_SPI_SAFE_MAX_FRAME_WIDTH-6:0];

  if (master_tr.spi_safe_frame != slave_tr.spi_safe_frame) begin
    scb_compare_spi_safe_frame = 0;
`ifdef SVT_UVM_TECHNOLOGY
    `uvm_error("scb_compare_spi_safe_frame",$sformatf("SPI SAFE FRAME COMPARE MISMATCH MASTER FRAME = 0x%0h but SLAVE FRAME = 0x%0h",master_tr.spi_safe_frame,slave_tr.spi_safe_frame));
`elsif SVT_OVM_TECHNOLOGY
    `ovm_error("scb_compare_spi_safe_frame",$sformatf("SPI SAFE FRAME COMPARE MISMATCH MASTER FRAME = 0x%0h but SLAVE FRAME = 0x%0h",master_tr.spi_safe_frame,slave_tr.spi_safe_frame));
`endif  
  end
  else begin
`ifdef SVT_UVM_TECHNOLOGY
    `uvm_info("scb_compare_spi_safe_frame",$sformatf("SPI SAFE FRAME COMPARE MATCH MASTER FRAME = 0x%0h SLAVE FRAME = 0x%0h",master_tr.spi_safe_frame,slave_tr.spi_safe_frame), UVM_LOW);
  `elsif SVT_OVM_TECHNOLOGY
    `ovm_info("scb_compare_spi_safe_frame",$sformatf("SPI SAFE FRAME COMPARE MATCH MASTER FRAME = 0x%0h SLAVE FRAME = 0x%0h",master_tr.spi_safe_frame,slave_tr.spi_safe_frame), OVM_LOW);
  `endif      
  end  
endfunction: scb_compare_spi_safe_frame

// ------------------------------------------------------------------------------------------------
function bit spi_monitor_scoreboard::scb_control_word_compare(
                                              svt_spi_transaction master_tr,
                                              svt_spi_transaction slave_tr
                                              );
  scb_control_word_compare = 1'b0;
`ifdef SVT_UVM_TECHNOLOGY
    `uvm_fatal("scb_compare_mem_core_data",$sformatf("This routine must be overridden by the extended class"));
`elsif SVT_OVM_TECHNOLOGY
    `ovm_fatal("scb_compare_mem_core_data",$sformatf("This routine must be overridden by the extended class"));
`endif      
endfunction
// ------------------------------------------------------------------------------------------------
function bit spi_monitor_scoreboard::scb_compare_mem_core_data(
                                       svt_spi_transaction master_tr,
                                       svt_spi_transaction slave_tr,
                                       bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] master_mem_start_address,
                                       bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] master_mem_end_address,
                                       bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] slave_mem_start_address,
                                       bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] slave_mem_end_address
                                     );
  bit[`SVT_SPI_DATA_WIDTH-1:0] master_rd_data;
  bit[`SVT_SPI_DATA_WIDTH-1:0] slave_rd_data;
  bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] master_mem_current_read_address;
  bit[`SVT_SPI_MAX_ADDR_FRAME_WIDTH-1:0] slave_mem_current_read_address;
  bit[`SVT_SPI_DATA_WIDTH:0] data_mask;
  bit success;
  scb_compare_mem_core_data = 1;
  master_mem_current_read_address = master_tr.address_frame;
  slave_mem_current_read_address  = slave_tr.address_frame;

  if (master_cfg.enable_configurable_data_frame_width) 
    data_mask = (1'b1 << master_cfg.data_frame_width) -1;

  for (int i=0; i<master_tr.data_frame_size; i++) begin
    success = master_mem_backdoor.peek(master_mem_current_read_address, master_rd_data); //to_do check for success bit
    success = slave_mem_backdoor.peek(slave_mem_current_read_address, slave_rd_data);
    if (master_cfg.enable_configurable_data_frame_width) begin
      master_rd_data = master_rd_data & data_mask;
      slave_rd_data  = slave_rd_data  & data_mask;
    end
      
    if (master_rd_data !== slave_rd_data) begin
      scb_compare_mem_core_data = 0;
`ifdef SVT_UVM_TECHNOLOGY
      `uvm_error("scb_compare_mem_core_data",$sformatf("DATA COMPARE MISMATCH MASTER_DATA = 'h%0h at address = 'h%0h But SLAVE_DATA = 'h%0h at address = 'h%0h", 
         master_rd_data, master_mem_current_read_address, slave_rd_data, slave_mem_current_read_address));
`elsif SVT_OVM_TECHNOLOGY
      `ovm_error("scb_compare_mem_core_data",$sformatf("DATA COMPARE MISMATCH MASTER_DATA = 'h%0h at address = 'h%0h But SLAVE_DATA = 'h%0h at address = 'h%0h", 
         master_rd_data, master_mem_current_read_address, slave_rd_data, slave_mem_current_read_address));
`endif  
    end
    else begin
`ifdef SVT_UVM_TECHNOLOGY
      `uvm_info("scb_compare_mem_core_data",$sformatf("DATA COMPARE MATCH MASTER_DATA = 'h%0h at address = 'h%0h & SLAVE_DATA = 'h%0h at address = 'h%0h", 
         master_rd_data, master_mem_current_read_address, slave_rd_data, slave_mem_current_read_address), UVM_HIGH);
`elsif SVT_OVM_TECHNOLOGY
      `ovm_info("scb_compare_mem_core_data",$sformatf("DATA COMPARE MATCH MASTER_DATA = 'h%0h at address = 'h%0h & SLAVE_DATA = 'h%0h at address = 'h%0h", 
         master_rd_data, master_mem_current_read_address, slave_rd_data, slave_mem_current_read_address), OVM_HIGH);
`endif  
    end
    //Wrap the address at memory boundary
    if (master_mem_current_read_address == master_mem_end_address)
      master_mem_current_read_address = master_mem_start_address;
    else
      master_mem_current_read_address++;

    if (slave_mem_current_read_address == slave_mem_end_address)
      slave_mem_current_read_address = slave_mem_start_address;
    else
      slave_mem_current_read_address++;
  end
endfunction: scb_compare_mem_core_data
// ------------------------------------------------------------------------------------------------
  
`ifdef SVT_UVM_TECHNOLOGY
  function void spi_monitor_scoreboard::report_phase(uvm_phase phase);
`elsif SVT_OVM_TECHNOLOGY
  function void spi_monitor_scoreboard::report();
`endif  
   if(enable) begin
    if(count_mismatch_tx || count_mismatch_rx) begin
`ifdef SVT_UVM_TECHNOLOGY
    `uvm_error("scb_compare",
      $sformatf("No Of Mismatch in SPI Transactions = %d",count_mismatch_tx + count_mismatch_rx));
`elsif SVT_OVM_TECHNOLOGY
      `ovm_error("scb_compare",
        $sformatf("No Of Mismatch in SPI Transactions = %d",count_mismatch_tx + count_mismatch_rx));
`endif  
    end
    else if ((master_tx_trans.size > 0) || (master_rx_trans.size > 0) || (slave_tx_trans.size > 0) || (slave_rx_trans.size > 0)) begin
      if (master_tx_trans.size > 0) begin
`ifdef SVT_UVM_TECHNOLOGY
      `uvm_error("scb_compare",$sformatf("Total SPI Transaction pending in master Tx Queue %d",master_tx_trans.size));
`elsif SVT_OVM_TECHNOLOGY
      `ovm_error("scb_compare",$sformatf("Total SPI Transaction pending in master Tx Queue %d",master_tx_trans.size));
`endif  
      end
      if (master_rx_trans.size > 0) begin
`ifdef SVT_UVM_TECHNOLOGY
      `uvm_error("scb_compare",$sformatf("Total SPI Transaction pending in master Rx Queue %d",master_rx_trans.size));
`elsif SVT_OVM_TECHNOLOGY
      `ovm_error("scb_compare",$sformatf("Total SPI Transaction pending in master Rx Queue %d",master_rx_trans.size));
`endif  
      end
      if (slave_tx_trans.size > 0) begin
`ifdef SVT_UVM_TECHNOLOGY
      `uvm_error("scb_compare",$sformatf("Total SPI Transaction pending in slave Tx Queue %d",slave_tx_trans.size));
`elsif SVT_OVM_TECHNOLOGY
      `ovm_error("scb_compare",$sformatf("Total SPI Transaction pending in slave Tx Queue %d",slave_tx_trans.size));
`endif  
      end
      if (slave_rx_trans.size > 0) begin
`ifdef SVT_UVM_TECHNOLOGY
      `uvm_error("scb_compare",$sformatf("Total SPI Transaction pending in slave Rx Queue %d",slave_rx_trans.size));
`elsif SVT_OVM_TECHNOLOGY
      `ovm_error("scb_compare",$sformatf("Total SPI Transaction pending in slave Rx Queue %d",slave_rx_trans.size));
`endif  
      end
    end
    else    
      begin
`ifdef SVT_UVM_TECHNOLOGY
    `uvm_info("report_phase",
                    $sformatf(" \n\
                         Scoreboard : ---------------------------------------------------------------------\n\
                         Scoreboard : NO mismatch in SPI transaction object \n\
                         Scoreboard : ---------------------------------------------------------------------"),UVM_LOW) ;
       
`elsif SVT_OVM_TECHNOLOGY
    `ovm_info("report_phase",
                    $sformatf(" \n\
                         Scoreboard : ---------------------------------------------------------------------\n\
                         Scoreboard : NO mismatch in SPI transaction object \n\
                         Scoreboard : ---------------------------------------------------------------------"),OVM_LOW) ;
       
`endif  
      end               
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_info("report_phase",
                  $sformatf(" \n\
 --------------------------------------------------\n\
| Scoreboard Report                                |\n\
 --------------------------------------------------\n\
| SPI Transactions transmitted by master Tx   %5d  |\n\
| SPI Transactions received    by slave Rx    %5d  |\n\
| SPI Transactions Not Matched                %5d  |\n\
 --------------------------------------------------\n\
| SPI Transactions transmitted by slave Tx    %5d  |\n\
| SPI Transactions received    by master Rx   %5d  |\n\
| SPI Transactions Not Matched                %5d  |\n\
 --------------------------------------------------\n\
| SPI Transactions dropped     by master      %5d  |\n\
| SPI Transactions dropped     by slave       %5d  |\n\
 --------------------------------------------------",
                            count_master_tx, 
                            count_slave_rx,
                            count_mismatch_tx,
                            count_slave_tx,
                            count_master_rx,
                            count_mismatch_rx,
                            packet_drop_master,
                            packet_drop_slave),UVM_LOW);
`elsif SVT_OVM_TECHNOLOGY
    `ovm_info("report_phase",
                    $sformatf(" \n\
   --------------------------------------------------\n\
  | Scoreboard Report                                |\n\
   --------------------------------------------------\n\
  | SPI Transactions transmitted by master Tx   %5d  |\n\
  | SPI Transactions received    by slave Rx    %5d  |\n\
  | SPI Transactions Not Matched                %5d  |\n\
   --------------------------------------------------\n\
  | SPI Transactions transmitted by slave Tx    %5d  |\n\
  | SPI Transactions received    by master Rx   %5d  |\n\
  | SPI Transactions Not Matched                %5d  |\n\
   --------------------------------------------------\n\
  | SPI Transactions dropped     by master      %5d  |\n\
  | SPI Transactions dropped     by slave       %5d  |\n\
   --------------------------------------------------",
                              count_master_tx, 
                              count_slave_rx,
                              count_mismatch_tx,
                              count_slave_tx,
                              count_master_rx,
                              count_mismatch_rx,
                              packet_drop_master,
                              packet_drop_slave),OVM_LOW);
`endif  
   end
   endfunction 

// ------------------------------------------------------------------------------------------------
task spi_monitor_scoreboard::drop_packet_master_rx();
  svt_spi_transaction trans_trash;
  drop_pkt_mstr_rx = 1'b1;
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_info("drop_packet_master_rx","Registering to ignore next packet",UVM_LOW);
`elsif SVT_OVM_TECHNOLOGY
  `ovm_info("drop_packet_master_rx","Registering to ignore next packet",OVM_LOW);
`endif  
  wait(master_rx_trans.size >0);
  trans_trash = master_rx_trans.pop_front();
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_info("drop_packet_master_rx",
                  $psprintf("Packet dropped from Master Rx queue"),UVM_LOW);
`elsif SVT_OVM_TECHNOLOGY
  `ovm_info("drop_packet_master_rx",
                  $psprintf("Packet dropped from Master Rx queue"),OVM_LOW);
`endif  
  packet_drop_master = packet_drop_master + 1; 
  drop_pkt_mstr_rx = 1'b0;
endtask

// ------------------------------------------------------------------------------------------------
task spi_monitor_scoreboard::drop_packet_master_tx();
  svt_spi_transaction trans_trash;
  drop_pkt_mstr_tx = 1'b1;
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_info("drop_packet_master_tx","Registering to ignore next packet",UVM_LOW);
`elsif SVT_OVM_TECHNOLOGY
  `ovm_info("drop_packet_master_tx","Registering to ignore next packet",OVM_LOW);
`endif  
  wait(master_tx_trans.size >0);
  trans_trash = master_tx_trans.pop_front();
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_info("drop_packet_master_tx",
                  $psprintf("Packet dropped from Master Tx queue"),UVM_LOW);
`elsif SVT_OVM_TECHNOLOGY
  `ovm_info("ddrop_packet_master_tx",
                  $psprintf("Packet dropped from Master Tx queue"),OVM_LOW);
`endif  
  packet_drop_master = packet_drop_master + 1; 
  drop_pkt_mstr_tx = 1'b0;
endtask

// ------------------------------------------------------------------------------------------------
task spi_monitor_scoreboard::drop_packet_slave_rx();
  svt_spi_transaction trans_trash;
  drop_pkt_slv_rx = 1'b1;
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_info("drop_packet_slave_rx","Registering to ignore next packet",UVM_LOW);
`elsif SVT_OVM_TECHNOLOGY
  `ovm_info("drop_packet_slave_rx","Registering to ignore next packet",OVM_LOW);
`endif  
  wait(slave_rx_trans.size >0);
  trans_trash = slave_rx_trans.pop_front();
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_info("drop_packet_slave_rx",
                  $psprintf("Packet dropped from slave Rx queue"),UVM_LOW);
`elsif SVT_OVM_TECHNOLOGY
  `ovm_info("drop_packet_slave_rx",
                  $psprintf("Packet dropped from slave Rx queue"),OVM_LOW);
`endif  
  packet_drop_slave = packet_drop_slave + 1; 
  drop_pkt_slv_rx = 1'b0;
endtask

// ------------------------------------------------------------------------------------------------
task spi_monitor_scoreboard::drop_packet_slave_tx();
  svt_spi_transaction trans_trash;
  drop_pkt_slv_tx = 1'b1;
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_info("drop_packet_slave_tx","Registering to ignore next packet",UVM_LOW);
`elsif SVT_OVM_TECHNOLOGY
  `ovm_info("drop_packet_slave_tx","Registering to ignore next packet",OVM_LOW);
`endif  
  wait(slave_tx_trans.size >0);
  trans_trash = slave_tx_trans.pop_front();
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_info("drop_packet_slave_tx",
                  $psprintf("Packet dropped from slave Tx queue"),UVM_LOW);
`elsif SVT_OVM_TECHNOLOGY
  `ovm_info("drop_packet_slave_tx",
                  $psprintf("Packet dropped from slave Tx queue"),OVM_LOW);
`endif  
  packet_drop_slave = packet_drop_slave + 1; 
  drop_pkt_slv_tx = 1'b0;
endtask

// ------------------------------------------------------------------------------------------------
task spi_monitor_scoreboard::drop_packet_master();
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_info("drop_packet_master","Registering to ignore next packet",UVM_LOW);
`elsif SVT_OVM_TECHNOLOGY
  `ovm_info("drop_packet_master","Registering to ignore next packet",OVM_LOW);
`endif  
  fork
  begin
    drop_packet_master_tx;
  end
  begin
    drop_packet_master_rx;
  end
  join
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_info("drop_packet_master",
                  $psprintf("Packet dropped from Master Tx & Rx queue"),UVM_LOW);
`elsif SVT_OVM_TECHNOLOGY
  `ovm_info("drop_packet_master",
                  $psprintf("Packet dropped from Master Tx & Rx queue"),OVM_LOW);
`endif  
  packet_drop_master = packet_drop_master + 1; 
endtask

// ------------------------------------------------------------------------------------------------
task spi_monitor_scoreboard::drop_packet_slave();
  svt_spi_transaction trans_trash;
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_info("drop_packet_slave","Registering to ignore next packet",UVM_LOW);
`elsif SVT_OVM_TECHNOLOGY
  `ovm_info("drop_packet_slave","Registering to ignore next packet",OVM_LOW);
`endif  
  fork
  begin
    drop_packet_slave_tx;
  end
  begin
    drop_packet_slave_rx;
  end
  join
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_info("drop_packet_slave",
                  $psprintf("Packet dropped from slave Tx & Rx queue"),UVM_LOW);
`elsif SVT_OVM_TECHNOLOGY
  `ovm_info("drop_packet_slave",
                  $psprintf("Packet dropped from slave Tx & Rx queue"),OVM_LOW);
`endif  
  packet_drop_slave = packet_drop_slave + 1; 
endtask


// ------------------------------------------------------------------------------------------------
function void spi_monitor_scoreboard::write_master_tx(svt_spi_transaction tr);
  svt_spi_transaction trans_scoreboard;
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_info("write_master_tx",
                  $psprintf("Packet received at Master Tx"),UVM_LOW);
`endif
  if(enable) begin
    if(
       (slave_cfg.frame_format == svt_spi_types::SPI_SAFE) && 
       (tr.spi_safe_status == svt_spi_types::SLAVE_SELECT_ADDR_MISMATCH)
    ) begin
    //Do not push the recieved transaction to the queue.
    end
    else begin
      master_tx_trans.push_back(tr);
      count_master_tx++;
      ->master_tx_get_event;   
    end  
  end
endfunction // write_master_tx

// ------------------------------------------------------------------------------------------------
function void spi_monitor_scoreboard::write_slave_tx(svt_spi_transaction tr)      ;
  svt_spi_transaction trans_scoreboard;
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_info("write_slave_tx",
                  $psprintf("Packet received at Slave Tx"),UVM_LOW);
`endif
  if(enable) begin
    if(
       (slave_cfg.frame_format == svt_spi_types::SPI_SAFE) && 
       (tr.spi_safe_status == svt_spi_types::SLAVE_SELECT_ADDR_MISMATCH)
    ) begin
    //Do not push the recieved transaction to the queue.
    end
    else begin
      slave_tx_trans.push_back(tr);
      count_slave_tx++;
      ->slave_tx_get_event;
    end  
  end  
endfunction // write_slave_tx

// ------------------------------------------------------------------------------------------------
function void spi_monitor_scoreboard::write_master_rx(svt_spi_transaction tr);
  svt_spi_transaction trans_scoreboard;
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_info("write_master_rx",
                  $psprintf("Packet received at Master Rx"),UVM_LOW);
`endif
  if(enable) begin
    if(
       (slave_cfg.frame_format == svt_spi_types::SPI_SAFE) && 
       (tr.spi_safe_status == svt_spi_types::SLAVE_SELECT_ADDR_MISMATCH)
    ) begin
    //Do not push the recieved transaction to the queue.
    end
    else begin
      master_rx_trans.push_back(tr);
      count_master_rx++;
      ->master_rx_get_event;   
    end  
  end
endfunction // write_master_rx

// ------------------------------------------------------------------------------------------------
function void spi_monitor_scoreboard::write_slave_rx(svt_spi_transaction tr);
  svt_spi_transaction trans_scoreboard;
`ifdef SVT_UVM_TECHNOLOGY
  `uvm_info("write_slave_rx",
                  $psprintf("Packet received at Slave Rx"),UVM_LOW);
`endif
  if(enable) begin
    if(
       (slave_cfg.frame_format == svt_spi_types::SPI_SAFE) && 
       (tr.spi_safe_status == svt_spi_types::SLAVE_SELECT_ADDR_MISMATCH)
    ) begin
    //Do not push the recieved transaction to the queue.
    end
    else begin
      slave_rx_trans.push_back(tr);
      count_slave_rx++;
      ->slave_rx_get_event;
    end  
  end
endfunction // write_slave_rx
     
// ------------------------------------------------------------------------------------------------
function void spi_monitor_scoreboard::set_scbd_enable (bit en);
  this.enable = en;
endfunction

// ------------------------------------------------------------------------------------------------
function void spi_monitor_scoreboard::flush_pending_queues ();
  master_tx_trans.delete;
  slave_tx_trans.delete;
  master_rx_trans.delete;
  slave_rx_trans.delete;
endfunction

//************************ END OF FILE ********************************;

