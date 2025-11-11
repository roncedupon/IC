
`ifndef GUARD_I2C_SVT_INTERCONNECT_SV_WRAPPER_SV
`define GUARD_I2C_SVT_INTERCONNECT_SV_WRAPPER_SV

/**
 * Abstract: 
 * In order to instantiate the hdl_interconnect in SystemVerilog top level RTL
 * connection file (top.sv), this wrapper is created. The function of this 
 * wrapper module is simply to connect the Verilog hdl_interconnect's ports to 
 * the corresponding  signals in the SystemVerilog interfaces.
 */

`include "hdl_interconnect.v"
`include "svt_i2c_if.svi"

module i2c_svt_interconnect_sv_wrapper(svt_i2c_if i2c_if);

  /** Instantiate hdl dut */
  hdl_interconnect hdl_interconnect_instance (.scl_master (i2c_if.SCL) ,
					      .sda_master (i2c_if.SDA) , 
					      .scl_slave  (i2c_if.SCL) , 
					      .sda_slave  (i2c_if.SDA));


endmodule : i2c_svt_interconnect_sv_wrapper

`endif

//------------------------------------------------------------------------
//-----------------------END OF FILE--------------------------------------
//------------------------------------------------------------------------
