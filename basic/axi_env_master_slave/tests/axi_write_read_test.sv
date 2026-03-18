//=======================================================================
// AXI Write-Read Test
// Description: Test case for write-read transactions with data verification
//=======================================================================

`ifndef GUARD_AXI_WRITE_READ_TEST_SV
`define GUARD_AXI_WRITE_READ_TEST_SV

class axi_write_read_test extends axi_base_test;
  
  /** UVM Component Utility macro */
  `uvm_component_utils(axi_write_read_test)
  
  /** Class Constructor */
  function new(string name = "axi_write_read_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  /** Run Phase */
  virtual task run_phase(uvm_phase phase);
    axi_virtual_sequence vseq;
    
    phase.raise_objection(this, "Starting test");
    
    `uvm_info("run_phase", "Starting AXI Write-Read Test", UVM_LOW)
    
    // Create and start virtual sequence
    vseq = axi_virtual_sequence::type_id::create("vseq");
    vseq.start(env.sequencer);
    
    // Wait for all transactions to complete
    phase.drop_objection(this, "Test completed");
    
    `uvm_info("run_phase", "AXI Write-Read Test Completed", UVM_LOW)
  endtask
  
endclass

`endif // GUARD_AXI_WRITE_READ_TEST_SV
