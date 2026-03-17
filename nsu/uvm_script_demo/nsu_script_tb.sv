`include "uvm_macros.svh"
`include "uvm_pkg.sv"
import uvm_pkg::*;

`include "nsu_script_test.sv"

module nsu_script_tb;
  initial begin
    `uvm_info("TB", "Starting UVM test...", UVM_MEDIUM)
    run_test("nsu_script_test");
  end
endmodule
