
`ifndef GUARD_UART_VIRTUAL_SEQUENCER_SV
`define GUARD_UART_VIRTUAL_SEQUENCER_SV

/**
 * This class is Virtual Sequencer class, which encapsulates the 
 * agent's sequencers and allows a fine grain control over the user's
 * stimulus application to the selective sequencer.
 */
class uart_virtual_sequencer extends uvm_sequencer;
  
  /** Typedef of the reset modport to simplify access */
  typedef virtual uart_reset_if.uart_reset_modport UART_RESET_MP;

  /** Reset modport provides access to the reset signal */
  UART_RESET_MP reset_mp;

  /** UVM component utility macro */
  `uvm_component_utils(uart_virtual_sequencer)

  /** Instance of txrx sequencer for UART DTE agent */
  svt_uart_transaction_sequencer dte_sequencer;

  /** Instance of txrx sequencer for UART DCE agent */
  svt_uart_transaction_sequencer dce_sequencer;

  /** Class constructor */
  function new(string name="uart_virtual_sequencer",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered...", UVM_LOW)

    super.build_phase(phase);

    if (!uvm_config_db#(UART_RESET_MP)::get(this, "", "reset_mp", reset_mp)) begin
      `uvm_fatal("build_phase", "An uart_reset_modport must be set using the config db.");
    end

    `uvm_info("build_phase", "Exiting...", UVM_LOW)
  endfunction
   
endclass : uart_virtual_sequencer

`endif //  `ifndef GUARD_UART_VIRTUAL_SEQUENCER_SV

