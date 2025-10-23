
`ifndef GUARD_HDL_INTERCONNECT_V
`define GUARD_HDL_INTERCONNECT_V

/**
 * Abstract:
 * The HDL Interconnect module has two SPI protocol interafces.
 * One connects to SPI MASTER device and the other to SPI SLAVE device.
 * The behavior of this module is to simply connect two protocol interfaces
 * by assigning the outputs on the MASTER side of HDL Interconnect to the
 * corresponding inputs on the SLAVE side of HDL interconnect and vice versa.
 *
 *     +-----------------+                          +-------------------+
 *     |                 |                          |                   |
 *     |   SPI VIP       |                          |    SPI     VIP    |
 *     |                 |                          |                   |
 *     |   1st instance  |                          |    2nd instance   |
 *     |        M        |      +------------+      |        S          |
 *     |                 |      |    HDL     |      |                   |
 *     |        A        |      |Interconnect|      |        L          |
 *     |                 |      |            |      |                   |
 *     |        S        |      |            |      |        A          |
 *     |                 |      |            |      |                   |
 *     |        T        |      +------------+      |        V          |
 *     |                 |                          |                   |
 *     |        E        |                          |        E          |
 *     |                 |                          |                   |
 *     |        R        |                          |                   |
 *     |                 |                          |                   |
 *     |                 |                          |                   |
 *     |                 |                          |                   |
 *     +-----------------+                          +-------------------+
 */

module hdl_interconnect (
                        /* SPI MASTER Interface */
                        inout master_sclk , 
                        inout [(`SVT_SPI_IO_WIDTH-1):0] master_mosi , 
                        inout [(`SVT_SPI_IO_WIDTH-1):0] master_miso ,
                        inout [(`SVT_SPI_MAX_NUM_SLAVES-1):0] master_ss_n,
 
                        /* SPI SLAVE Interface */
                        inout slave_sclk , 
                        inout [(`SVT_SPI_IO_WIDTH-1):0] slave_mosi , 
                        inout [(`SVT_SPI_IO_WIDTH-1):0] slave_miso ,
                        inout [(`SVT_SPI_MAX_NUM_SLAVES-1):0] slave_ss_n			 
                        );

  tran sclk(master_sclk, slave_sclk);
  tran ssn_n(master_ss_n, slave_ss_n);
genvar i;

 generate
    for (i=0; i < `SVT_SPI_IO_WIDTH; i=i+1) begin :IO_CONNECT
      tran mosi(master_mosi[i], slave_mosi[i]);
      tran miso(master_miso[i], slave_miso[i]);
    end  
    endgenerate
endmodule
`endif

