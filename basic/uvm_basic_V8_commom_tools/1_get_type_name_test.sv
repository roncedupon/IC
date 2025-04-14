`ifndef GURD_get_type_name_test_SV
`define GURD_get_type_name_test_SV
`include "uvm_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
class get_type_name_test extends uvm_component;
    function new(string name="get_type_name_test", uvm_component parent);
        super.new(name, parent);        
    endfunction
    `uvm_component_utils(get_type_name_test)
    task run_phase(uvm_phase phase);
    `uvm_info("DRVR", $sformatf("This is %s", get_type_name()), UVM_MEDIUM)
    endtask
endclass

module top;

    initial begin
        run_test("get_type_name_test");
        $display("hh");
    end

endmodule
`endif 
