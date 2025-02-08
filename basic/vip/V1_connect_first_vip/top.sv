
// `include "dut.sv"
`include "mydefine.sv"

`include "uvm_pkg.sv"

`include "uvm_macros.svh"

`include "svt_ahb_if.svi"
/** Include the AHB SVT UVM package */
`include "svt_ahb.uvm.pkg"
/** Include the AMBA COMMON SVT UVM package */
`include "svt_amba_common.uvm.pkg"
`include "import_amba_packages.svi"
/** Import UVM Package */
import uvm_pkg::*;
/** Import the SVT UVM Package */
import svt_uvm_pkg::*;
/** Import the AHB VIP */
import svt_ahb_uvm_pkg::*;
/** Import the AMBA COMMON Package for amba_pv_extension */
import svt_amba_common_uvm_pkg::*;

//my include
`include "myenv.sv"
`include "ahb_master_directed_sequence.sv"

module test_top;



  /** Signal to generate the clock */
  bit clk;
  reg rst_n;
  svt_ahb_master_if mastervif(clk,rst_n);
  // my_ahb_if vif();

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
    #1000
    $finish;
  end

  initial begin
    
    uvm_config_db#(virtual svt_ahb_master_if)::set(uvm_root::get(), "uvm_test_top.agt", "vif", mastervif);

    run_test("myenv");

  end

assign mastervif.hready=1'b1;
// assign masterif.hrdata=32'hffffffff;
// ahb_slave dut(.port(mastervif));
endmodule

