`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
`include "test_list.sv"
module top;
    initial begin

        run_test();
    end

endmodule