

`include "uvm_pkg.sv"
`include "uvm_macros.svh"
`include "env.sv"
`include "Virtua1Sequence.sv"
import uvm_pkg::*;
interface delay_interface #(parameter WIDTH = 8, parameter MAX_DELAY = 16)(input clk,rst_n);


  // 输入信号
  logic [WIDTH-1:0] data;
  logic valid;
  logic [$clog2(MAX_DELAY)-1:0] delay_times;
  logic ready;
endinterface

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
    
    uvm_config_db#(virtual delay_interface)::set(uvm_root::get(), "uvm_test_top.spi_drv", "vif", vif1);
    uvm_config_db#(virtual delay_interface)::set(uvm_root::get(), "uvm_test_top.apb_drv", "vif", vif2);
    uvm_config_db#(uvm_object_wrapper)::set(uvm_root::get(),"uvm_test_top.virtual_sequencer.main_phase","default_sequence",Virtua1Sequence::type_id::get());
    run_test("env");

  end

endmodule
