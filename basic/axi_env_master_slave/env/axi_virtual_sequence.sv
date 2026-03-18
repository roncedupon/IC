//=======================================================================
// AXI Virtual Sequence
// Description: Coordinates master and slave sequences
//=======================================================================

`ifndef GUARD_AXI_VIRTUAL_SEQUENCE_SV
`define GUARD_AXI_VIRTUAL_SEQUENCE_SV

class axi_virtual_sequence extends uvm_sequence;
  
  /** Master sequence to run */
  axi_master_write_read_sequence m_seq;
  
  /** Slave sequence to run */
  axi_slave_response_sequence s_seq;
  
  /** Virtual sequencer handle */
  axi_virtual_sequencer p_sequencer;
  
  /** UVM Object Utility macro */
  `uvm_object_utils(axi_virtual_sequence)
  
  /** Class Constructor */
  function new(string name = "axi_virtual_sequence");
    super.new(name);
  endfunction
  
  /** Body task - sequence execution */
  virtual task body();
    `uvm_info("body", "Entered...", UVM_LOW)
    
    // Get virtual sequencer handle
    if (!$cast(p_sequencer, m_sequencer))
      `uvm_fatal("body", "Unable to get virtual sequencer handle")
    
    // Start slave response sequence (runs forever)
    fork
      begin
        s_seq = axi_slave_response_sequence::type_id::create("s_seq");
        s_seq.start(p_sequencer.m_slave_seqr);
      end
    join_none
    
    // Wait for slave to be ready
    #100;
    
    // Run master sequence
    m_seq = axi_master_write_read_sequence::type_id::create("m_seq");
    m_seq.start(p_sequencer.m_master_seqr);
    
    // Wait for all transactions to complete
    #1000;
    
    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask
  
endclass

`endif // GUARD_AXI_VIRTUAL_SEQUENCE_SV
