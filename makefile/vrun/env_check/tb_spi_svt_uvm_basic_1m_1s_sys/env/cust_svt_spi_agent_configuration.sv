
`ifndef GUARD_CUST_SVT_SPI_CONFIGURATION_SV
`define GUARD_CUST_SVT_SPI_CONFIGURATION_SV

/**
 * Abstract:
 * This file contains the class extended from svt_spi_agent_configuration class.
 * Here the user has customized the configuration parameters as per test case requirement.
 */
class cust_svt_spi_agent_configuration extends svt_spi_agent_configuration;

  /** UVM object utility macro */
  `uvm_object_utils(cust_svt_spi_agent_configuration)

  /** Class constructor */
  function new(string name ="cust_svt_spi_agent_configuration" );
    super.new(name);
  endfunction
   
     
endclass
`endif //GUARD_CUST_SVT_SPI_CONFIGURATION_SV

