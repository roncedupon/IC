
`ifndef GUARD_SPI_VIRTUAL_SEQUENCER_SV
`define GUARD_SPI_VIRTUAL_SEQUENCER_SV

/**
 * This class is Virtual Sequencer class, which encapsulates the 
 * agent's sequencers and allows a fine grain control over the user's
 * stimulus application to the selective sequencer.
 */
class spi_virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);
  
  /** Typedef of the reset modport to simplify access */
  typedef virtual spi_reset_if.spi_reset_modport SPI_RESET_MP;

  /** Reset modport provides access to the reset signal */
  SPI_RESET_MP reset_mp;

  /** UVM component utility macro */
  `uvm_component_utils(spi_virtual_sequencer)

  /** Instance of txrx sequencer for SPI MASTER agent */
  svt_spi_transaction_sequencer master_sequencer;

  /** Instance of txrx sequencer for SPI SLAVE agent */
  svt_spi_transaction_sequencer slave_sequencer;

 /** Handle to agent configuration object */
  svt_spi_agent_configuration cfg;

  /** Class constructor */
  function new(string name="spi_virtual_sequencer",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered...", UVM_LOW)

    super.build_phase(phase);

    if (!uvm_config_db#(SPI_RESET_MP)::get(this, "", "reset_mp", reset_mp)) begin
      `uvm_fatal("build_phase", "An spi_reset_modport must be set using the config db.");
    end

    if (!uvm_config_db#(svt_spi_agent_configuration)::get(this,"","cfg",this.cfg) || (this.cfg == null)) begin
      `uvm_fatal("build_phase", "'cfg' is null. A svt_spi_agent_configuration object must be set using the UVM configuration infrastructure.");
    end

    `uvm_info("build_phase", "Exiting...", UVM_LOW)
  endfunction
   
endclass : spi_virtual_sequencer

`endif //  `ifndef GUARD_SPI_VIRTUAL_SEQUENCER_SV

