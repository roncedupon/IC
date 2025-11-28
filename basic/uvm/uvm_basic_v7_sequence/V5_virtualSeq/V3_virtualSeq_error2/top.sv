

`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "dut.sv"
`include "mycase.sv"

import uvm_pkg::*;

module test_top;



  /** Signal to generate the clock */
  bit clk;
  reg rst_n;

  delay_interface vif1(clk,rst_n);
  delay_interface vif2(clk,rst_n);
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
    
    uvm_config_db#(virtual delay_interface)::set(uvm_root::get(), "uvm_test_top.env1.drv", "vif", vif1);
    uvm_config_db#(virtual delay_interface)::set(uvm_root::get(), "uvm_test_top.env2.drv", "vif", vif2);
    uvm_config_db#(uvm_object_wrapper)::set(uvm_root::get(),"uvm_test_top.Vseqr.main_phase","default_sequence",Virtua1Sequence::type_id::get());
    run_test("mycase");

  end


  dual_dut dut(
    .clk(clk),
    .rst_n(rst_n),
    .data1(vif1.data),
    .valid1(vif1.valid),
    .delay_times1(vif1.delay_times),
    .ready1(vif1.ready),


    .data2(vif2.data),
    .valid2(vif2.valid),
    .delay_times2(vif2.delay_times),
    .ready2(vif2.ready)
  );
endmodule
