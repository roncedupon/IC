
`ifndef GUARD_UART_RESET_IF_SVI
`define GUARD_UART_RESET_IF_SVI

/**
 * Abstract:
 * Defines an interface that provides access to a reset signal.  This
 * interface can be used to write sequences to drive the reset logic.
 */
interface uart_reset_if();

  logic reset;
  logic clk;

  modport uart_reset_modport (input clk, output reset);

endinterface

`endif // GUARD_UART_RESET_IF_SVI

