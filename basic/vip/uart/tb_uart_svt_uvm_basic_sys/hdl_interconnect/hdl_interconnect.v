
`ifndef GUARD_HDL_INTERCONNECT_V
`define GUARD_HDL_INTERCONNECT_V

/**
 * Abstract:
 * The HDL Interconnect module has two UART protocol interafces.
 * One connects to UART DTE device and the other to UART DCE device.
 * The behavior of this module is to simply connect two protocol interfaces
 * by assigning the outputs on the DTE side of HDL Interconnect to the
 * corresponding inputs on the DCE side of HDL interconnect and vice versa.
 *
 *     +-----------------+                          +-------------------+
 *     |                 |                          |                   |
 *     |   UART VIP      |Sout                  Sout|    UART     VIP   |
 *     |                 |                          |                   |
 *     |   1st instance  |                          |    2nd instance   |
 *     |        D        |DTR   +------------+   DTR|        D          |
 *     |                 |      |    HDL     |      |                   |
 *     |        C        |      |Interconnect|      |        T          |
 *     |                 |DSR   |            |   DSR|                   |
 *     |        E        |      |            |      |        E          |
 *     |                 |      |            |      |                   |
 *     |                 |RTS   +------------+   RTS|                   |
 *     |                 |                          |                   |
 *     |                 |                          |                   |
 *     |                 |CTS                    CTS|                   |
 *     |                 |                          |                   |
 *     |                 |                          |                   |
 *     |                 |Sin                    Sin|                   |
 *     |                 |                          |                   |
 *     +-----------------+                          +-------------------+
 */

module hdl_interconnect (
                        /* UART DTE Interface */
                        dte_rst , 
                        dte_clk , 
                        dte_sin , 
                        dte_dsr , 
                        dte_cts , 
                        dte_dtr , 
                        dte_rts , 
                        dte_sout ,
                        dte_de,
                        dte_re,
                        dte_baudout , 
`ifdef SVT_UART_GPIO                        
                        dte_gpi0 ,
                        dte_gpi1 ,
                        dte_gpi2 ,
                        dte_gpi3 ,
                        dte_gpi4 ,
                        dte_gpo0 ,
                        dte_gpo1 ,
                        dte_gpo2 ,
                        dte_gpo3 ,
                        dte_gpo4 ,
`endif                        
                        /* UART DCE Interface */
                        dce_rst , 
                        dce_clk , 
                        dce_sin , 
                        dce_dsr , 
                        dce_cts , 
                        dce_dtr , 
                        dce_rts , 
                        dce_sout ,
                        dce_de,
                        dce_re,
`ifdef SVT_UART_GPIO                        
                        dce_gpi0 ,
                        dce_gpi1 ,
                        dce_gpi2 ,
                        dce_gpi3 ,
                        dce_gpi4 ,
                        dce_gpo0 ,
                        dce_gpo1 ,
                        dce_gpo2 ,
                        dce_gpo3 ,
                        dce_gpo4 ,
`endif                        
                        dce_baudout
                        );

  /** UART DTE ports */ 
  input  dte_rst ; 
  input  dte_clk ; 
  input  dte_sin ; 
  input  dte_dsr ; 
  input  dte_cts ; 
`ifdef SVT_UART_GPIO                        
  input  dte_gpi0;
  input  dte_gpi1;
  input  dte_gpi2;
  input  dte_gpi3;
  input  dte_gpi4;
`endif                        
  output dte_dtr ; 
  output dte_rts ; 
  output dte_sout ;
  output dte_de;
  output dte_re;
  output dte_baudout ;
`ifdef SVT_UART_GPIO                        
  output dte_gpo0;
  output dte_gpo1;
  output dte_gpo2;
  output dte_gpo3;
  output dte_gpo4;
`endif                        

  /** UART DCE ports */ 
  input  dce_rst ;
  input  dce_clk ;
  input  dce_sout ;
  input  dce_de;
  input  dce_re;
  input  dce_dtr ;
  input  dce_rts ;
`ifdef SVT_UART_GPIO                        
  input  dce_gpi0;
  input  dce_gpi1;
  input  dce_gpi2;
  input  dce_gpi3;
  input  dce_gpi4;
`endif                        
  output dce_cts ;
  output dce_sin ;
  output dce_dsr ;
  output dce_baudout ;
`ifdef SVT_UART_GPIO                        
  output dce_gpo0;
  output dce_gpo1;
  output dce_gpo2;
  output dce_gpo3;
  output dce_gpo4;
`endif                        

  /**
   * Cross-connecting the signals in two protocol interfaces on either side of this
   * module: Connect output signals of DTE Interface to corresponding input 
   * signals of DCE Interface and vice versa.
   */                           

  assign dce_sout = dte_sout ;
  assign dce_re = dte_re;
  assign dce_de = dte_de;
  assign dte_sin  = dce_sin  ;

  assign dce_dtr  = dte_dtr  ;
  assign dte_dsr  = dce_dsr  ;

  /**
   * If in configuration class variable enable_tx_rx_handshake is set to 1'b1 
   * The hardware connection for RTS and CTS will be as follows <br/>
   * --------         --------   <br/>
   *|        |       |        |  <br/>
   *|  D  RTS|------>|CTS  D  |  <br/>
   *|  C     |       |     T  |  <br/>
   *|  E  CTS|<------|RTS  E  |  <br/>
   *|        |       |        |  <br/>
   * --------         --------   <br/>
   *By default enable_tx_rx_handshake is set to 1'b1  
   */ 
  assign dte_cts  = dce_rts  ;
  assign dce_cts  = dte_rts  ;

  /**
   * If in configuration class variable enable_tx_rx_handshake is set to 1'b0 
   * The hardware connection for RTS and CTS will be as follows <br/>
   * --------         --------  <br/>
   *|        |       |        | <br/>
   *|  D  RTS|<------|RTS  D  | <br/>
   *|  C     |       |     T  | <br/>
   *|  E  CTS|------>|CTS  E  | <br/>
   *|        |       |        | <br/>
   * --------         --------  <br/>
   *  The assign statement will be made as follows <br/>
   *  assign dce_rts = dte_rts <br/>
   *  assign dte_cts = dce_cts 
   */  

`ifdef SVT_UART_GPIO  
  assign dte_gpi0 = dce_gpo0;
  assign dte_gpi1 = dce_gpo1;
  assign dte_gpi2 = dce_gpo2;
  assign dte_gpi3 = dce_gpo3;
  assign dte_gpi4 = dce_gpo4;

  assign dce_gpi0 = dte_gpo0;
  assign dce_gpi1 = dte_gpo1;
  assign dce_gpi2 = dte_gpo2;
  assign dce_gpi3 = dte_gpo3;
  assign dce_gpi4 = dte_gpo4;
`endif  

endmodule
`endif

