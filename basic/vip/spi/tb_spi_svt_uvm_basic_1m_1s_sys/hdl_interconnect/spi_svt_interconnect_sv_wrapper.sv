
`ifndef GUARD_SPI_SVT_INTERCONNECT_SV_WRAPPER_SV
`define GUARD_SPI_SVT_INTERCONNECT_SV_WRAPPER_SV

`include "hdl_interconnect.v"
`include "svt_spi_if.svi"

/**
 * Abstract: 
 * In order to instantiate the hdl_interconnect in SystemVerilog top level RTL
 * connection file (top.sv), this wrapper is created. The function of this 
 * wrapper module is simply to connect the Verilog hdl_interconnect's ports to 
 * the corresponding  signals in the SystemVerilog interfaces. In this file, the
 * SystemVerilog module uses SystemVerilog MASTER and SLAVE interface instances to 
 * create wrapper around Verilog hdl_interconnect module.
 */
module spi_svt_interconnect_sv_wrapper(svt_spi_if spi_master_if, svt_spi_if spi_slave_if);

  /** Instantiate hdl interconnect */
  hdl_interconnect interconnect_inst (
                                     /** SPI MASTER Interface Signals */
                                     .master_sclk  (spi_master_if.sclk),
                                     .master_mosi  (spi_master_if.mosi),
                                     .master_miso  (spi_master_if.miso),
                                     .master_ss_n  (spi_master_if.ss_n),

                                     /** SPI SLAVE Interface Signals */
                                     .slave_sclk  (spi_slave_if.sclk),
                                     .slave_mosi  (spi_slave_if.mosi),
                                     .slave_miso  (spi_slave_if.miso),
                                     .slave_ss_n  (spi_slave_if.ss_n)

                                     );

endmodule : spi_svt_interconnect_sv_wrapper

`endif

