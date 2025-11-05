//=======================================================================
// Slave footprint infrastructure
`define SVT_SPI_VALID_IDX_NUM_SLAVES_0 \
 // Nothing to do

`define SVT_SPI_VALID_IDX_NUM_SLAVES_1 \
 `define SVT_SPI_VALID_SLAVE_IDX_0

`define SVT_SPI_VALID_IDX_NUM_SLAVES_2 \
 `SVT_SPI_VALID_IDX_NUM_SLAVES_1 \
 `define SVT_SPI_VALID_SLAVE_IDX_1

`define SVT_SPI_VALID_IDX_NUM_SLAVES_3 \
 `SVT_SPI_VALID_IDX_NUM_SLAVES_2 \
 `define SVT_SPI_VALID_SLAVE_IDX_2

`define SVT_SPI_VALID_IDX_NUM_SLAVES_4 \
 `SVT_SPI_VALID_IDX_NUM_SLAVES_3 \
 `define SVT_SPI_VALID_SLAVE_IDX_3

`define SVT_SPI_VALID_IDX_NUM_SLAVES_5 \
 `SVT_SPI_VALID_IDX_NUM_SLAVES_4 \
 `define SVT_SPI_VALID_SLAVE_IDX_4


//=======================================================================
// MASTER footprint infrastructure
`define SVT_SPI_VALID_IDX_NUM_MASTERS_0 \
 // Nothing to do

`define SVT_SPI_VALID_IDX_NUM_MASTERS_1 \
 `define SVT_SPI_VALID_MASTER_IDX_0

`define SVT_SPI_VALID_IDX_NUM_MASTERS_2 \
  `SVT_SPI_VALID_IDX_NUM_MASTERS_1 \
  `define SVT_SPI_VALID_MASTER_IDX_1

//=======================================================================
/** Max number of slaves. */
`ifdef SVT_SPI_MAX_NUM_SLAVES_0
 `SVT_SPI_VALID_IDX_NUM_SLAVES_0
 `define SVT_SPI_MAX_NUM_SLAVES 0
`else
 `ifdef SVT_SPI_MAX_NUM_SLAVES_1
  `SVT_SPI_VALID_IDX_NUM_SLAVES_1
  `define SVT_SPI_MAX_NUM_SLAVES 1
 `else
  `ifdef SVT_SPI_MAX_NUM_SLAVES_2
   `SVT_SPI_VALID_IDX_NUM_SLAVES_2
   `define SVT_SPI_MAX_NUM_SLAVES 2
  `else
   `ifdef SVT_SPI_MAX_NUM_SLAVES_3
     `SVT_SPI_VALID_IDX_NUM_SLAVES_3
     `define SVT_SPI_MAX_NUM_SLAVES 3
   `else
    `ifdef SVT_SPI_MAX_NUM_SLAVES_4
      `SVT_SPI_VALID_IDX_NUM_SLAVES_4
      `define SVT_SPI_MAX_NUM_SLAVES 4
    `else
     `ifdef SVT_SPI_MAX_NUM_SLAVES_5
       `SVT_SPI_VALID_IDX_NUM_SLAVES_5
       `define SVT_SPI_MAX_NUM_SLAVES 5
     `endif
    `endif  
   `endif  
  `endif  
 `endif  
`endif 


//=======================================================================
/** Max number of Masters. */
`ifdef SVT_SPI_MAX_NUM_MASTERS_0
 `SVT_SPI_VALID_IDX_NUM_MASTERS_0
 `define SVT_SPI_MAX_NUM_MASTERS 0
`else
 `ifdef SVT_SPI_MAX_NUM_MASTERS_1
  `SVT_SPI_VALID_IDX_NUM_MASTERS_1
  `define SVT_SPI_MAX_NUM_MASTERS 1
 `else
  `ifdef SVT_SPI_MAX_NUM_MASTERS_2
   `SVT_SPI_VALID_IDX_NUM_MASTERS_2
   `define SVT_SPI_MAX_NUM_MASTERS 2
  `endif
  `endif

`endif


