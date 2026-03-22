//=======================================================================
// AXI Advanced Test
// Description: Advanced test demonstrating various AXI4 features
//=======================================================================

`ifndef GUARD_AXI_ADVANCED_TEST_SV
`define GUARD_AXI_ADVANCED_TEST_SV

class axi_advanced_test extends axi_base_test;
  
  /** UVM Component Utility macro */
  `uvm_component_utils(axi_advanced_test)
  
  /** Class Constructor */
  function new(string name = "axi_advanced_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  /** Build Phase - override configuration */
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // Configure for more comprehensive testing
    cfg.master_cfg[0].outstanding_xact = 8;  // Allow multiple outstanding transactions
    cfg.master_cfg[0].max_burst_length = 16; // Support longer bursts
    
    // Enable protocol checking
    cfg.master_cfg[0].protocol_check_enable = 1;
    cfg.slave_cfg[0].protocol_check_enable = 1;
    
    // Set timeout values
    cfg.master_cfg[0].xact_timeout = 1000;   // 1000 cycles timeout
    cfg.slave_cfg[0].xact_timeout = 1000;
    
    `uvm_info("build_phase", "Advanced AXI configuration applied", UVM_LOW)
  endfunction
  
  /** Run Phase */
  virtual task run_phase(uvm_phase phase);
    axi_virtual_sequence vseq;
    
    phase.raise_objection(this, "Starting advanced test");
    
    `uvm_info("run_phase", "Starting AXI Advanced Test Suite", UVM_LOW)
    
    // Test 1: Basic Write-Read
    `uvm_info("TEST_SUITE", "=== Test 1: Basic Write-Read ===", UVM_LOW)
    vseq = axi_virtual_sequence::type_id::create("vseq_basic");
    vseq.start(env.sequencer);
    #500ns;
    
    // Test 2: Longer burst transactions
    `uvm_info("TEST_SUITE", "=== Test 2: Long Burst Transactions ===", UVM_LOW)
    uvm_config_db#(int unsigned)::set(null, "uvm_test_top.env", "sequence_length", 5);
    vseq = axi_virtual_sequence::type_id::create("vseq_long_burst");
    vseq.start(env.sequencer);
    #500ns;
    
    // Test 3: Different burst types
    `uvm_info("TEST_SUITE", "=== Test 3: Different Burst Types ===", UVM_LOW)
    test_burst_types();
    
    // Wait for completion
    #1000ns;
    
    phase.drop_objection(this, "Advanced test completed");
    
    `uvm_info("run_phase", "AXI Advanced Test Suite Completed", UVM_LOW)
  endtask
  
  /** Test different burst types */
  virtual task test_burst_types();
    axi_virtual_sequencer vseqr = env.sequencer;
    axi_master_write_read_sequence m_seq;
    
    // Test INCR burst
    m_seq = axi_master_write_read_sequence::type_id::create("incr_seq");
    m_seq.start(vseqr.m_master_seqr);
    
    // Wait between tests
    #300ns;
    
  endtask
  
endclass

`endif // GUARD_AXI_ADVANCED_TEST_SV