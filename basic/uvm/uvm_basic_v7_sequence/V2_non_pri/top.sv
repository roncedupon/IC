

`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "delay_interface.sv"
`include "myenv.sv"

import uvm_pkg::*;

module test_top;



  /** Signal to generate the clock */
  bit clk;
  reg rst_n;

  delay_interface vif(clk,rst_n);
  initial begin
    $fsdbDumpfile("waves.fsdb");
    $fsdbDumpvars(0,test_top);
  end
  

  initial begin
    clk = 0 ;
    forever begin
      #(10/2)
        clk = ~clk ;
    end
  end
  initial begin
    rst_n=0;
    #1000
    rst_n=1;
  end

  initial begin
    
    uvm_config_db#(virtual delay_interface)::set(uvm_root::get(), "uvm_test_top.drv", "vif", vif);
    run_test("myenv");

  end


  dynamic_delay dut(
    .clk(clk),
    .rst_n(rst_n),
    .data_in(vif.data),
    .data_valid(vif.valid),
    .delay_times(vif.delay_times),
    .ready(vif.ready)

  );
endmodule
