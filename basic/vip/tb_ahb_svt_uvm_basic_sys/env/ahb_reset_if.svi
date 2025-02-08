
/**
 * Abstract:
 * Defines an interface that provides access to a reset signal.  This
 * interface can be used to write sequences to drive the reset logic.
 */

`ifndef GUARD_AHB_RESET_IF_SVI
`define GUARD_AHB_RESET_IF_SVI

interface ahb_reset_if();

  logic resetn;
  logic clk;

  modport ahb_reset_modport (input clk, output resetn);

endinterface

`endif // GUARD_AHB_RESET_IF_SVI
