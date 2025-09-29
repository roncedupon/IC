
`ifndef GUARD_UART_SVT_INTERCONNECT_SV_WRAPPER_SV
`define GUARD_UART_SVT_INTERCONNECT_SV_WRAPPER_SV

`include "hdl_interconnect.v"
`include "svt_uart_if.svi"

/**
 * Abstract: 
 * In order to instantiate the hdl_interconnect in SystemVerilog top level RTL
 * connection file (top.sv), this wrapper is created. The function of this 
 * wrapper module is simply to connect the Verilog hdl_interconnect's ports to 
 * the corresponding  signals in the SystemVerilog interfaces. In this file, the
 * SystemVerilog module uses SystemVerilog DTE and DCE interface instances to 
 * create wrapper around Verilog hdl_interconnect module.
 */
module uart_svt_interconnect_sv_wrapper(svt_uart_if uart_dte_if, svt_uart_if uart_dce_if);

  /** Instantiate hdl interconnect */
  hdl_interconnect interconnect_inst (
                                     /** UART DTE Interface Signals */
                                     .dte_rst      (uart_dte_if.rst), 
                                     .dte_clk      (uart_dte_if.clk), 
                                     .dte_sin      (uart_dte_if.sin), 
                                     .dte_dsr      (uart_dte_if.dsr), 
                                     .dte_cts      (uart_dte_if.cts), 
                                     .dte_dtr      (uart_dte_if.dtr), 
                                     .dte_rts      (uart_dte_if.rts), 
                                     .dte_sout     (uart_dte_if.sout),
                                     .dte_re     (uart_dte_if.re),
                                     .dte_de     (uart_dte_if.de),
                                     .dte_baudout  (uart_dte_if.baudout),
`ifdef SVT_UART_GPIO                        
                                     .dte_gpi0     (uart_dte_if.gpi0),
                                     .dte_gpi1     (uart_dte_if.gpi1),
                                     .dte_gpi2     (uart_dte_if.gpi2),
                                     .dte_gpi3     (uart_dte_if.gpi3),
                                     .dte_gpi4     (uart_dte_if.gpi4),
                                     .dte_gpo0     (uart_dte_if.gpo0),
                                     .dte_gpo1     (uart_dte_if.gpo1),
                                     .dte_gpo2     (uart_dte_if.gpo2),
                                     .dte_gpo3     (uart_dte_if.gpo3),
                                     .dte_gpo4     (uart_dte_if.gpo4),
`endif                        
                                     /** UART DCE Interface Signals */
                                     .dce_rst      (uart_dce_if.rst), 
                                     .dce_clk      (uart_dce_if.clk), 
                                     .dce_sin      (uart_dce_if.sin), 
                                     .dce_dsr      (uart_dce_if.dsr), 
                                     .dce_cts      (uart_dce_if.cts), 
                                     .dce_dtr      (uart_dce_if.dtr), 
                                     .dce_rts      (uart_dce_if.rts), 
                                     .dce_sout     (uart_dce_if.sout),
                                     .dce_de     (uart_dce_if.de),
                                     .dce_re     (uart_dce_if.re),
`ifdef SVT_UART_GPIO                        
                                     .dce_gpi0     (uart_dce_if.gpi0),
                                     .dce_gpi1     (uart_dce_if.gpi1),
                                     .dce_gpi2     (uart_dce_if.gpi2),
                                     .dce_gpi3     (uart_dce_if.gpi3),
                                     .dce_gpi4     (uart_dce_if.gpi4),
                                     .dce_gpo0     (uart_dce_if.gpo0),
                                     .dce_gpo1     (uart_dce_if.gpo1),
                                     .dce_gpo2     (uart_dce_if.gpo2),
                                     .dce_gpo3     (uart_dce_if.gpo3),
                                     .dce_gpo4     (uart_dce_if.gpo4),
`endif                        
                                     .dce_baudout  (uart_dce_if.baudout)
                                     );

endmodule : uart_svt_interconnect_sv_wrapper

`endif

