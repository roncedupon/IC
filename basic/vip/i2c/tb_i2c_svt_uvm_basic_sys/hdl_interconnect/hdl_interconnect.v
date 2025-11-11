
/**
 * Abstract:
 * The HDL interconnect module in this example is a simple wire crossover 
 * between Master and Slave agents.
 */

`ifndef GUARD_I2C_HDL_INTERCONNECT_V
`define GUARD_I2C_HDL_INTERCONNECT_V

module hdl_interconnect ( 
    inout scl_master,
    inout sda_master,
    inout scl_slave,
    inout sda_slave);
   
   tran scl(scl_master, scl_slave);
   tran sda(sda_master, sda_slave);
   
endmodule
`endif

//------------------------------------------------------------------------
//-----------------------END OF FILE--------------------------------------
//------------------------------------------------------------------------
