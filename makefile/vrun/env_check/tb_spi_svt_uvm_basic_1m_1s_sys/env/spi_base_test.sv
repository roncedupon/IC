`ifndef GUARD_SPI_BASE_TEST_SV
`define GUARD_SPI_BASE_TEST_SV

`include "cust_svt_spi_transaction.sv"
`include "cust_svt_spi_agent_configuration.sv"
`include "spi_basic_env.sv"
`include "spi_default_sequence.sv"
`include "spi_directed_sequence.sv"
`include "spi_default_virtual_sequence.sv"
`include "spi_random_timing_sequence.sv"
`include "spi_random_timing_virtual_sequence.sv"
`include "spi_simple_reset_sequence.sv"
`include "spi_null_virtual_sequence.sv"
`include "spi_shared_cfg.sv"
`include "svt_spi_catalog.svi"
`include "cust_svt_spi_txrx_callback_exception_collection.sv"
/**
 * Abstract:
 * This file creates a base test, which serves as the base class for the rest
 * of the tests in this environment.  This test sets up the default behavior
 * for the rest of the tests in this environment.
 *
 * In the build_phase phase of the test we will set the necessary test related 
 * information:
 *  - Use type wide factory override to set cust_svt_spi_transaction
 *    as the default transaction type
 *  - Create a default configuration and set it to the spi_basic_env instance
 *    using the configuration DB
 *  - Create the spi_basic_env instance (named env)
 *  - Configure the spi_default_virtual_sequence as the default
 *    sequence for the main phase of the SPI ENV virtual sequencer
 *  - Configure the sequence length to 10
 *  - Configure the spi_simple_reset_sequence as the default sequence
 *    for the reset phase of the TB ENV virtual sequencer
 *  - Set the Pass/Fail criterion in the final_phase() using report_server
 */

class svt_spi_part_number_policy;

  static function int weight(svt_spi_vendor_part part);
    string spi_part_number;
    if ($value$plusargs("part_number=%s", spi_part_number)) begin
       `uvm_info ("weight",$sformatf("User provided part_number=%s selected", spi_part_number),UVM_HIGH);
      return part.get_part_number() == spi_part_number;
    end 
    else begin
      return part.get_part_number() == "SPI_Mem_Model";
      `uvm_info ("weight",$sformatf("Default part_number=%s selected ", spi_part_number),UVM_HIGH);
    end  
  endfunction : weight
endclass : svt_spi_part_number_policy

class spi_base_test extends uvm_test;

  /** Instance of the environment */
  spi_basic_env env;
  
  /** Configuration Instance for Active MASTER agent */
  cust_svt_spi_agent_configuration master_cfg;

  /** Configuration Instance for MASTER Monitor agent */
  cust_svt_spi_agent_configuration master_mon_cfg;

  /** Configuration Instance for Active SLAVE agent */
  cust_svt_spi_agent_configuration slave_cfg;

  /** Configuration Instance for Slave Monitor agent */
  cust_svt_spi_agent_configuration slave_mon_cfg;

  /** No of Master Agents */
  int num_masters = `SVT_SPI_MAX_NUM_MASTERS; 

  /** No of Slave Agents */
  int num_slaves = `SVT_SPI_MAX_NUM_SLAVES;

  /** Handle for SPARSE Slave memory*/ 
  svt_mem_backdoor slave_mem_backdoor ;

  /** Handle for SPARSE Master memory*/ 
  svt_mem_backdoor master_mem_backdoor ;

  /** System common configuration */
  spi_shared_cfg shared_cfg;

  /** Current simulation cycle for generating bus_clk */
  int simulation_cycle;

  typedef string string_queue_t [$];

  /**
   This queue is populated by testcases calling the set_vip_checks_to_expected() function.
   This holds the message string present in error checks for which the svt_err_check_stats::default_fail_effect has been
   set to svt_err_check_stats::NOTE.<p>
   */
  string_queue_t fail_expected_master_vip_msg_pattern_array [];

  /**
   This queue is populated by testcases calling the set_vip_checks_to_expected() function.
   This holds the message string present in error checks for which the svt_err_check_stats::default_fail_effect has been
   set to svt_err_check_stats::NOTE.<p>
   */
  string_queue_t fail_expected_slave_vip_msg_pattern_array  [];

  /** Indicates the minimum number of times an error check is expected to trigger. */
  int expected_min_slave_agent_check_fail_count[$];
  
  /** Indicates the minimum number of times an error check is expected to trigger. */
  int expected_min_master_agent_check_fail_count[$];
  
  /**
   * Captures the value passed in from the command line by +enable_txrx_tracing=n.
   * If it is 1, trace will be enabled
   */
  bit enable_txrx_tracing = 1;

  /**
   * Controls how many data array elements are displayed in trace.
   * Defaults to '10', indicating display the first 10 elements. The supported values are:
   *  -  0  -- display all data array elements
   *  -  n  -- display the first n data array elements
   *  - -n  -- display the last  n data array elements
   */
  int psdisplay_data_size = 10;

  /**
   * Captures the value passed in from the command line by
   * +enable_txrx_reporting=n.
   * If it is >= 1, txrx Reporting in logfile will be enabled
   */
  bit enable_txrx_reporting = 0;

  /**
   * When enabled,configures the SPI agent to assert Chip select as ACTIVE_HIGH.
   */ 
  bit enable_active_high_cs_polarity = 1'b0;

  /**
   * This field allows to configure frame width specified by #data_frame_width Data Array.
   * By default a Random value in between 1 and `SVT_SPI_DATA_WIDTH is
   * selected.
   */ 
  bit enable_configurable_data_frame_width = 1'b0;

  /**
   * Specifies the valid Data Frame Width configuration.
   */ 
  int data_frame_width = `SVT_SPI_DATA_WIDTH; 

  /** Specifies minimum data frame width. */
  int min_data_frame_width = 1;

  /**
   * Specifies that Memory core is used to hold to Big Size data for Tx/Rx
   * rather than Transaction object dynamic array data[].
   * In This Mode, address bits are determined by cfg.spi_mem_cfg.addr_width
   * field.
   */ 
  bit enable_mem_core = 1'b0;

  /**
   * Captures the value passed in from the command line by +run_pa=n.
   * If it is 1, PA will be enabled
   */
  bit run_pa = 0;

  /**
   * Captures the value passed in from the command line by +disable_baud_rate_divisor=n.
   * If it is 1, baud rate divisor will be default 1 i.e sclk = bus_clk.
   */
  bit disable_baud_rate_divisor = 0;

  /** UVM component utility macro */
  `uvm_component_utils(spi_base_test)

  //----------------------------------------------------------------------------
  /** Class constructor */
  function new(string name ="spi_base_test", uvm_component parent);
    super.new(name,parent);
  endfunction : new

  //----------------------------------------------------------------------------
  /**
   * Build Phase
   * - Create and apply the customized configuration transaction factory
   * - Create the TB ENV
   * - Set the default sequences
   */
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered ...", UVM_LOW)
    super.build_phase(phase);

    /** Replace blueprint of svt_spi_transaction with cust_svt_spi_transaction using factories in UVM */
    set_type_override_by_type(svt_spi_transaction::get_type(),cust_svt_spi_transaction::get_type());
    
    /** Create the configuration object */
    shared_cfg = spi_shared_cfg::type_id::create("spi_shared_cfg");

    /** Create the configuration object for MASTER agent */
    master_cfg = cust_svt_spi_agent_configuration::type_id::create("master_cfg");

    /** Create the configuration object for SLAVE agent */
    slave_cfg = cust_svt_spi_agent_configuration::type_id::create("slave_cfg");

    fail_expected_master_vip_msg_pattern_array = new[num_masters];
    fail_expected_slave_vip_msg_pattern_array  = new[num_slaves];

    if (!shared_cfg.randomize() with{ 
        frame_format == svt_spi_types::SPI_STD;
        spi_feature  == svt_spi_types::SPI;}) begin
      `uvm_fatal("build_phase", "Shared Configuration Randomization failure.");
    end

    void' ($value$plusargs("enable_txrx_tracing=%d", enable_txrx_tracing));
    void' ($value$plusargs("psdisplay_data_size=%d", psdisplay_data_size));
    void' ($value$plusargs("enable_txrx_reporting=%d", enable_txrx_reporting));
    void' ($value$plusargs("enable_active_high_cs_polarity=%d", enable_active_high_cs_polarity));
    void' ($value$plusargs("enable_configurable_data_frame_width=%d", enable_configurable_data_frame_width));
    void' ($value$plusargs("enable_mem_core=%d", enable_mem_core));
    void' ($value$plusargs("run_pa=%d", run_pa));
    void' ($value$plusargs("disable_baud_rate_divisor=%d", disable_baud_rate_divisor));

    /** Set the configuration values for MASTER agent */
    if(!master_cfg.randomize() with {
        spi_feature       == shared_cfg.spi_feature;
        frame_format      == shared_cfg.frame_format;
        operation_mode    == shared_cfg.operation_mode;
        sppr              == shared_cfg.sppr;
        spr               == shared_cfg.spr;
        bit_endianness    == shared_cfg.bit_endianness;
        byte_endianness   == shared_cfg.byte_endianness;
        payload_word_size == shared_cfg.payload_word_size;
        default_master    == shared_cfg.default_master;
        default_slave     == shared_cfg.default_slave;
        is_master         == 1'b1;
        master_id         == 1'b0;
        }) begin
      `uvm_fatal("build_phase", "Master Configuration Randomization failure.");
    end
    if (enable_active_high_cs_polarity) begin
        master_cfg.cs_polarity = svt_spi_types::ACTIVE_HIGH;
    end
    
    /** Set the configuration values for SLAVE agent */
    if(!slave_cfg.randomize() with {
        spi_feature       == shared_cfg.spi_feature;
        frame_format      == shared_cfg.frame_format;
        operation_mode    == shared_cfg.operation_mode;
        sppr              == shared_cfg.sppr;
        spr               == shared_cfg.spr;
        bit_endianness    == shared_cfg.bit_endianness;
        byte_endianness   == shared_cfg.byte_endianness;
        payload_word_size == shared_cfg.payload_word_size;
        default_master    == shared_cfg.default_master;
        default_slave     == shared_cfg.default_slave;
        is_master         == 1'b0;
        slave_id          == 1'b0;
        }) begin
      `uvm_fatal("build_phase", "Slave Configuration Randomization failure.");
    end

    if (enable_active_high_cs_polarity) begin
        `uvm_info("build_phase", $sformatf("Chip select has been configured as Active High"),UVM_LOW);
        master_cfg.cs_polarity = svt_spi_types::ACTIVE_HIGH;
        slave_cfg.cs_polarity = svt_spi_types::ACTIVE_HIGH;
    end

    if (enable_configurable_data_frame_width) begin
      master_cfg.enable_configurable_data_frame_width = 1'b1;
      slave_cfg.enable_configurable_data_frame_width = 1'b1;

      data_frame_width = $urandom_range(`SVT_SPI_DATA_WIDTH,min_data_frame_width);
      master_cfg.data_frame_width = data_frame_width;
      slave_cfg.data_frame_width = data_frame_width;
    end
    
    if(run_pa==1) begin
      /** Enable XML generation for SPI transaction activity*/
      master_cfg.enable_txrx_xml_gen = 1'b1;
      slave_cfg.enable_txrx_xml_gen = 1'b1;
`ifdef SVT_FSDB_ENABLE
      master_cfg.pa_format_type = svt_xml_writer::format_type_enum'(2);
      slave_cfg.pa_format_type = svt_xml_writer::format_type_enum'(2);
`endif
    end

    if (enable_mem_core) begin
      master_cfg.enable_mem_core = 1'b1;
      slave_cfg.enable_mem_core = 1'b1;
      master_cfg.spi_mem_cfg = svt_spi_mem_configuration::type_id::create("spi_mem_cfg", this);
      slave_cfg.spi_mem_cfg = svt_spi_mem_configuration::type_id::create("spi_mem_cfg", this);
      generate_configuration(master_cfg);
      generate_configuration(slave_cfg);
      if(run_pa==1) begin
        /** Enable XML generation for memory transaction activity*/
        master_cfg.spi_mem_cfg.enable_xact_xml_gen = 1'b1;
        /** Enable .mempa file generation from memcore */
        master_cfg.spi_mem_cfg.enable_memcore_xml_gen = 1'b1;

        /** Enable XML generation for memory transaction activity*/
        slave_cfg.spi_mem_cfg.enable_xact_xml_gen = 1'b1;
        /** Enable .mempa file generation from memcore */
        slave_cfg.spi_mem_cfg.enable_memcore_xml_gen = 1'b1;
      end
    end

`ifdef SVT_SPI_ENABLE_PASSIVE_MONITOR
    /** Create the configuration object for Master Monitor using Active Master agent configuration*/
    if (!($cast(master_mon_cfg, master_cfg.clone()))) begin
      `uvm_fatal("build_phase","Failed to cast clone of provided 'master_cfg' object into object of type cust_svt_spi_agent_configuration.");
    end  
    else begin 
      master_mon_cfg.is_active = 1'b0;
      `uvm_info("build_phase", $sformatf("Master Passive Monitor is integrated in environment"),UVM_LOW);
      `uvm_info("build_phase", $sformatf("Master Monitor Configuration : \n%s",master_mon_cfg.sprint()),UVM_LOW);
    end  
`endif

    //`uvm_info("top", $sformatf("Master Configuration : \n%s",master_cfg.sprint()),UVM_LOW);
    //`uvm_info("top", $sformatf("Slave Configuration : \n%s",slave_cfg.sprint()),UVM_LOW);

`ifdef SVT_SPI_ENABLE_PASSIVE_MONITOR
    /** Create the configuration object for Slave Monitor using Active Slave agent configuration*/
    if (!($cast(slave_mon_cfg, slave_cfg.clone()))) begin
      `uvm_fatal("build_phase","Failed to cast clone of provided 'slave_cfg' object into object of type cust_svt_spi_agent_configuration.");
    end  
    else begin 
      `uvm_info("build_phase", $sformatf("Slave Passive Monitor is integrated in environment"),UVM_LOW);
      slave_mon_cfg.is_active = 1'b0;
      `uvm_info("build_phase", $sformatf("Slave Monitor Configuration : \n%s",slave_mon_cfg.sprint()),UVM_LOW);
    end  
`endif

    if (enable_txrx_reporting) begin
        master_cfg.enable_txrx_reporting = 1'b1;
        slave_cfg.enable_txrx_reporting = 1'b1;
`ifdef SVT_SPI_ENABLE_PASSIVE_MONITOR
        master_mon_cfg.enable_txrx_reporting = 1'b1;
        slave_mon_cfg.enable_txrx_reporting = 1'b1;
`endif    
    end

    if(enable_txrx_tracing==1)begin
        //Enable trace for master and slave transaction
        master_cfg.enable_txrx_tracing = 1'b1;
        slave_cfg.enable_txrx_tracing  = 1'b1;
        master_cfg.psdisplay_data_size = this.psdisplay_data_size; 
        slave_cfg.psdisplay_data_size  = this.psdisplay_data_size; 
`ifdef SVT_SPI_ENABLE_PASSIVE_MONITOR
        master_mon_cfg.enable_txrx_tracing = 1'b1;
        slave_mon_cfg.enable_txrx_tracing  = 1'b1;
        master_mon_cfg.psdisplay_data_size = this.psdisplay_data_size; 
        slave_mon_cfg.psdisplay_data_size  = this.psdisplay_data_size; 
`endif    
    end

    // Disable Baud rate divisor calculations.
    if(disable_baud_rate_divisor) begin
      master_cfg.disable_baud_rate_divisor = 1'b1;
      slave_cfg.disable_baud_rate_divisor  = 1'b1;
    end

`ifdef SVT_SPI_ENABLE_COV    
    master_cfg.enable_txrx_cov = 1'b1;
    slave_cfg.enable_txrx_cov = 1'b1;
`ifdef SVT_SPI_ENABLE_PASSIVE_MONITOR
    master_mon_cfg.enable_txrx_cov = 1'b1;
    slave_mon_cfg.enable_txrx_cov = 1'b1;
`endif    
`endif    
    /** Get Simulation Cycle in environment */
    if(uvm_config_db#(int)::get(this,"","simulation_cycle",simulation_cycle));
      `uvm_info("build_phse", $sformatf("Running with simulation cycle = %d",simulation_cycle) ,UVM_LOW)
  
    /** Set Master and Slave Min SCLK Period. */
    master_cfg.min_spi_bus_sclk_period_ns = set_min_sclk_period(simulation_cycle,shared_cfg.sppr,shared_cfg.spr,disable_baud_rate_divisor);
    slave_cfg.min_spi_bus_sclk_period_ns = set_min_sclk_period(simulation_cycle,shared_cfg.sppr,shared_cfg.spr,disable_baud_rate_divisor);

    /** Set MASTER configuration in environment */
    uvm_config_db#(cust_svt_spi_agent_configuration)::set(this,"env","master_cfg",master_cfg);

    /** Set SLAVE configuration in environment */
    uvm_config_db#(cust_svt_spi_agent_configuration)::set(this,"env","slave_cfg",slave_cfg);
    
`ifdef SVT_SPI_ENABLE_PASSIVE_MONITOR
    /** Set MASTER configuration in environment */
    uvm_config_db#(cust_svt_spi_agent_configuration)::set(this,"env","master_mon_cfg",master_mon_cfg);

    /** Set SLAVE configuration in environment */
    uvm_config_db#(cust_svt_spi_agent_configuration)::set(this,"env","slave_mon_cfg",slave_mon_cfg);
`endif    

    /** Create the environment */
    env = spi_basic_env::type_id::create("env", this);
     
    /** Apply the null virtual sequence to the SPI ENV virtual sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.sequencer.main_phase", "default_sequence", 
					    spi_default_virtual_sequence::type_id::get());

    /** Set the sequence 'length' to generate 10 transaction with constraints */
    uvm_config_db#(int unsigned)::set(this, "env.sequencer.spi_default_virtual_sequence", 
				      "sequence_length", 5);
    
    /** Apply the default reset sequence */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.sequencer.reset_phase", "default_sequence", 
					    spi_simple_reset_sequence::type_id::get());
   
    `uvm_info("build_phase", "Exited ...", UVM_LOW)
  endfunction : build_phase
  
  //----------------------------------------------------------------------------
  task configure_phase(uvm_phase phase);
    longint start_addr = 'h0;
    longint max_addr;
    bit [7:0] constant_pattern = 8'hff;
    bit [7:0] rand_pattern_start_value = 8'h0;

    `uvm_info("configure_phase", "Entered ...", UVM_LOW)
    super.configure_phase(phase);
    if (enable_mem_core) begin
      max_addr = ((1 << slave_cfg.spi_mem_cfg.addr_width) - 1);
      slave_mem_backdoor = env.slave_agent.mem_sequencer.get_backdoor();
      master_mem_backdoor = env.master_agent.mem_sequencer.get_backdoor();

      if(slave_mem_backdoor != null)begin
`ifdef SVT_SPI_FLASH_INIT_CONST_DATA
        `uvm_info("configure_phase",$sformatf(" Initialize the Memory with CONSTANT Pattern"), UVM_LOW);
        /** Initialize Slave memory with Constant data pattern*/
        slave_mem_backdoor.initialize(svt_mem_backdoor::INIT_CONST ,constant_pattern, start_addr , max_addr) ;
`else      
        `uvm_info("configure_phase",$sformatf(" Initialize the Memory with Random Pattern"), UVM_LOW);
        /** Initialize Slave memory with random data pattern*/
        slave_mem_backdoor.initialize(svt_mem_backdoor::INIT_RAND, rand_pattern_start_value, start_addr, max_addr) ;
`endif      
      end  
      else begin
        `uvm_fatal("configure_phase", "slave_mem_backdoor handle is null from slave agent");
      end

      if(master_mem_backdoor != null)begin
`ifdef SVT_SPI_FLASH_INIT_CONST_DATA
        `uvm_info("configure_phase",$sformatf(" Initialize the Memory with CONSTANT Pattern"), UVM_LOW);
        /** Initialize Master memory with Constant data pattern*/
        master_mem_backdoor.initialize(svt_mem_backdoor::INIT_CONST ,constant_pattern, start_addr , max_addr) ;
`else      
        `uvm_info("configure_phase",$sformatf(" Initialize the Memory with Random Pattern"), UVM_LOW);
        /** Initialize Master memory with random data pattern*/
        master_mem_backdoor.initialize(svt_mem_backdoor::INIT_RAND, rand_pattern_start_value, start_addr, max_addr) ;
`endif      
      end  
      else begin
        `uvm_fatal("configure_phase", "master_mem_backdoor handle is null from master agent");
      end
    end 
    `uvm_info("top", $sformatf("Master Configuration : \n%s",master_cfg.sprint()),UVM_LOW);
    `uvm_info("top", $sformatf("Slave Configuration : \n%s",slave_cfg.sprint()),UVM_LOW);
    `uvm_info("configure_phase", "Exited ...", UVM_LOW)
  endtask

  //----------------------------------------------------------------------------
  /** The drain time is set up for the main phase, as 
   * the stimulus is set for the main_phase. 
   * The value of drain time is set such as to ensure that all the  
   * transmitted packets are successfully received at the Receiver.
   * The timeunit must be ensured to be in units of 
   * nanoseconds(ns).
   */
  task main_phase(uvm_phase phase);
`ifdef SVT_UVM_1800_2_2017_OR_HIGHER
     uvm_objection phase_over;
`endif
    `uvm_info("main_phase", "Entered ...",UVM_LOW)
    `uvm_info("main_phase",$sformatf("Setting the drain time in the main_phase of the base test to 6000000"),UVM_NONE) 
`ifdef SVT_UVM_1800_2_2017_OR_HIGHER
     phase_over = phase.get_objection();
     phase_over.set_drain_time(this, (6000000));
`else
    phase.phase_done.set_drain_time(this, (6000000));
`endif
    `uvm_info("main_phase", "Exited ...",UVM_LOW)
  endtask // main_phase

  //----------------------------------------------------------------------------
  /**
   * Calculate the pass or fail status for the test in the final phase method of the
   * test. If a UVM_FATAL, UVM_ERROR, or a UVM_WARNING message has been generated the
   * test will fail.
   */
  function void final_phase(uvm_phase phase);
    uvm_report_server svr;
    `uvm_info("final_phase", "Entered ...",UVM_LOW)

    super.final_phase(phase);

    svr = uvm_report_server::get_server();

    if (svr.get_severity_count(UVM_FATAL) + 
      svr.get_severity_count(UVM_ERROR) + 
      svr.get_severity_count(UVM_WARNING) > 0)
      `uvm_info("final_phase", "\nSvtTestEpilog: Failed\n", UVM_LOW)
    else
      `uvm_info("final_phase", "\nSvtTestEpilog: Passed\n", UVM_LOW)
    `uvm_info("final_phase", "Exited ...",UVM_LOW)
  endfunction

  //----------------------------------------------------------------------------
  /**
   * This method selects a part number from the SPI catalog when enable_mem_core is asserted and uses that to populate
   * the VIP configuration.  Extended tests can override this behavior by overriding this
   * method.
   */
  virtual function void generate_configuration(cust_svt_spi_agent_configuration agent_cfg);
    svt_spi_vendor_part spi_vendor_part;
    int mem_core_addr_width;

    /** Select the part number from the catalog using the policy defined earlier */
    spi_vendor_part = svt_mem_part_mgr#(svt_spi_vendor_part,svt_spi_part_number_policy)::pick(); 

    if (spi_vendor_part!=null) begin
      `uvm_info("generate_configuration", $sformatf("Loading %s part number",spi_vendor_part.get_part_number()) ,UVM_LOW)
      if (agent_cfg.spi_mem_cfg.load_prop_vals(spi_vendor_part.get_cfgfile())) begin
        `uvm_info("generate_configuration", "Successfully loaded svt_spi_configuration ...", UVM_LOW)
        if (agent_cfg.is_valid(0)) begin
          `uvm_info("generate_configuration", "Loaded configuration is VALID ...",UVM_LOW);
        end
        else begin
          `uvm_fatal("generate_configuration", "Loaded configuration is NOT VALID ...");
        end
      end
      else begin
        `uvm_fatal("generate_configuration", "Failed attempting to load configuration ...");
      end
    
      if ($value$plusargs("mem_core_addr_width=%d",mem_core_addr_width)) begin
        agent_cfg.spi_mem_cfg.addr_width = mem_core_addr_width;
        agent_cfg.spi_mem_cfg.row_addr_width = mem_core_addr_width-1;
      end
      
    end
    else begin
      `uvm_fatal("generate_configuration", "Failed in selecting part number from catalog ...");
    end
  endfunction

  //----------------------------------------------------------------------------
  /**
   * This method sets checks which message ID has a the message_id_pattern
   * to be as NOTE, thus prevent the message from causing the test to fail.
   *
   * @param message_id_pattern The string pattern of the message id.
   */
  virtual function void set_master_vip_checks_to_expected(string message_id_pattern="",int expected_min_fail_note_count = 1);
    svt_err_check_stats  fail_expected_vip_check_q[$];
    for (int master_id = 0;master_id < num_masters;master_id++) begin
      fail_expected_vip_check_q.delete;
      /** Each Slave Agent has its own such message */
      env.master_agent.err_check.find_checks(,,fail_expected_vip_check_q, message_id_pattern);

      foreach (fail_expected_vip_check_q[i]) begin
        /** Demote the checks from UVM_ERROR to UVM_INFO/UVM_NONE ('NOTE' level), because they are NOTE to fail.*/
        `uvm_info("set_master_vip_checks_to_expected", $sformatf("Demoting Check[%0d] %s.%s to NOTE check", i, fail_expected_vip_check_q[i].get_full_name(),message_id_pattern), UVM_LOW);
        fail_expected_vip_check_q[i].set_default_fail_effect(svt_err_check_stats::NOTE);
      end
      if(fail_expected_vip_check_q.size() > 0) begin
        fail_expected_master_vip_msg_pattern_array[master_id].push_back(message_id_pattern);
        expected_min_master_agent_check_fail_count.push_back(expected_min_fail_note_count);
      end
    end  
  endfunction

  //----------------------------------------------------------------------------
  /**
   * This method sets checks which message ID has a the message_id_pattern
   * to be as NOTE, thus prevent the message from causing the test to fail.
   *
   * @param message_id_pattern The string pattern of the message id.
   */
  virtual function void set_slave_vip_checks_to_expected(string message_id_pattern="",int expected_min_fail_note_count = 1);
    svt_err_check_stats  fail_expected_vip_check_q[$];
    for (int slave_id = 0;slave_id < num_slaves;slave_id++) begin
      fail_expected_vip_check_q.delete;
      /** Each Slave Agent has its own such message */
      env.slave_agent.err_check.find_checks(,,fail_expected_vip_check_q, message_id_pattern);

      foreach (fail_expected_vip_check_q[i]) begin
        /** Demote the checks from UVM_ERROR to UVM_INFO/UVM_NONE ('NOTE' level), because they are NOTE to fail.*/
        `uvm_info("set_slave_vip_checks_to_expected", $sformatf("Demoting Check[%0d] %s.%s to NOTE check", i, fail_expected_vip_check_q[i].get_full_name(),message_id_pattern), UVM_LOW);
        fail_expected_vip_check_q[i].set_default_fail_effect(svt_err_check_stats::NOTE);
      end
      if(fail_expected_vip_check_q.size() > 0) begin
        fail_expected_slave_vip_msg_pattern_array[slave_id].push_back(message_id_pattern);
        expected_min_slave_agent_check_fail_count.push_back(expected_min_fail_note_count);
      end
    end  
  endfunction

  virtual function void report_phase(uvm_phase phase);
    svt_err_check_stats fail_expected_vip_check_q[$];
    int  unsigned fail_note_count = 0;
    super.report_phase(phase);

    for (int slave_id = 0;slave_id < num_slaves;slave_id++) begin
      fail_expected_vip_check_q.delete;
      if (fail_expected_slave_vip_msg_pattern_array[slave_id].size() > 0) begin
        for (int i=0;i<fail_expected_slave_vip_msg_pattern_array[slave_id].size();i++) begin
          fail_expected_vip_check_q.delete();
          //env.slave_agent[slave_id].err_check.find_checks(,,fail_expected_vip_check_q, fail_expected_slave_vip_msg_pattern_array[slave_id][i]);
          env.slave_agent.err_check.find_checks(,,fail_expected_vip_check_q, fail_expected_slave_vip_msg_pattern_array[slave_id][i]);
          if (fail_expected_vip_check_q.size() > 0) begin
            fail_note_count = 0;
            foreach (fail_expected_vip_check_q[j]) begin
              if (fail_expected_vip_check_q[j].fail_note_count > 0) begin
                `uvm_info("report_phase", $sformatf("VIP error check %0s %0s with default_fail_effect = NOTE was triggered (fail_note_count = %0d)!",
                                                    fail_expected_vip_check_q[j].get_full_name(), fail_expected_vip_check_q[j].get_check_id_str(),
                                                    fail_expected_vip_check_q[j].fail_note_count), UVM_LOW);
                fail_note_count += fail_expected_vip_check_q[j].fail_note_count;
              end
              else begin
                `uvm_info("report_phase", $sformatf("VIP error check %0s %0s with default_fail_effect = NOTE was not triggered!",
                                                    fail_expected_vip_check_q[j].get_full_name(), fail_expected_vip_check_q[j].get_check_id_str()), UVM_LOW);
              end
            end

            if (fail_note_count == 0) begin
              `uvm_error("report_phase", $sformatf("No VIP error check %0s failures with default_fail_effect = NOTE were triggered as failed!",fail_expected_slave_vip_msg_pattern_array[slave_id][i]));
            end
            if(fail_note_count < expected_min_slave_agent_check_fail_count[i])
              `uvm_error("report_phase", $sformatf("VIP error check %0s failures with default_fail_effect = NOTE was triggered for %d number of times. Expected minimum failure count %d",fail_expected_slave_vip_msg_pattern_array[slave_id][i],fail_note_count,expected_min_slave_agent_check_fail_count[i]));
          end
        end
      end
    end

    for (int master_id = 0;master_id < num_masters;master_id++) begin
      fail_expected_vip_check_q.delete;
      if (fail_expected_master_vip_msg_pattern_array[master_id].size() > 0) begin
        for (int i=0;i<fail_expected_master_vip_msg_pattern_array[master_id].size();i++) begin
          fail_expected_vip_check_q.delete();
          //env.master_agent[master_id].err_check.find_checks(,,fail_expected_vip_check_q, fail_expected_master_vip_msg_pattern_array[master_id][i]);
          env.master_agent.err_check.find_checks(,,fail_expected_vip_check_q, fail_expected_master_vip_msg_pattern_array[master_id][i]);
          if (fail_expected_vip_check_q.size() > 0) begin
            fail_note_count = 0;
            foreach (fail_expected_vip_check_q[j]) begin
              if (fail_expected_vip_check_q[j].fail_note_count > 0) begin
                `uvm_info("report_phase", $sformatf("VIP error check %0s %0s with default_fail_effect = NOTE was triggered (fail_note_count = %0d)!",
                                                    fail_expected_vip_check_q[j].get_full_name(), fail_expected_vip_check_q[j].get_check_id_str(),
                                                    fail_expected_vip_check_q[j].fail_note_count), UVM_LOW);
                fail_note_count += fail_expected_vip_check_q[j].fail_note_count;
              end
              else begin
                `uvm_info("report_phase", $sformatf("VIP error check %0s %0s with default_fail_effect = NOTE was not triggered!",
                                                    fail_expected_vip_check_q[j].get_full_name(), fail_expected_vip_check_q[j].get_check_id_str()), UVM_LOW);
              end
            end

            if (fail_note_count == 0) begin
              `uvm_error("report_phase", $sformatf("No VIP error check %0s failures with default_fail_effect = NOTE were triggered as failed!",fail_expected_master_vip_msg_pattern_array[master_id][i]));
            end
            if(fail_note_count < expected_min_master_agent_check_fail_count[i])
              `uvm_error("report_phase", $sformatf("VIP error check %0s failures with default_fail_effect = NOTE was triggered for %d number of times. Expected minimum failure count %d",fail_expected_master_vip_msg_pattern_array[master_id][i],fail_note_count,expected_min_master_agent_check_fail_count[i]));
          end
        end
      end
    end

    fail_note_count = 0;
    
  endfunction

  //----------------------------------------------------------------------------
  /** 
   *  This method will return minimum SCLK period
   *  based on current simulation cycle and baud_rate_divisor.
   */
  virtual function real set_min_sclk_period(input int simulation_cycle = 10, sppr = 0, spr = 0, disable_baud_rate_divisor = 0);
    int baud_rate_divisor;
    if(disable_baud_rate_divisor)
      baud_rate_divisor = 1;
    else  
      baud_rate_divisor = (sppr+1) << (spr+1);
    set_min_sclk_period = (baud_rate_divisor * simulation_cycle)/1ns;
  endfunction
endclass : spi_base_test

`endif //  `ifndef GUARD_SPI_BASE_TEST_SV

