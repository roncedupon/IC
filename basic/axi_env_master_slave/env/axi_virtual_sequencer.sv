//=======================================================================
// AXI Virtual Sequencer
// Description: Coordinates sequences between master and slave agents
//=======================================================================

`ifndef GUARD_AXI_VIRTUAL_SEQUENCER_SV
`define GUARD_AXI_VIRTUAL_SEQUENCER_SV

class axi_virtual_sequencer extends uvm_sequencer;
  
  /** Handle to Master Sequencer */
  svt_axi_master_sequencer m_master_seqr;
  
  /** Handle to Slave Sequencer */
  svt_axi_slave_sequencer m_slave_seqr;
  
  /** UVM Component Utility macro */
  `uvm_component_utils(axi_virtual_sequencer)
  
  /** Class Constructor */
  function new(string name = "axi_virtual_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
endclass

`endif // GUARD_AXI_VIRTUAL_SEQUENCER_SV
