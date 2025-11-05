
/**
 * Abstract:
 * This file test runs the default base test without modification
 */

`include "spi_base_test.sv"
`include "spi_eeprom_virtual_sequence.sv"

class eeprom_test extends spi_base_test;

  /** UVM component utility macro */
  `uvm_component_utils(eeprom_test)

  /** Class constructor */
  function new(string name = "eeprom_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction : new
  
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered ...", UVM_LOW)
    super.build_phase(phase);
    /** Apply the null virtual sequence to the SPI ENV virtual sequencer */
    uvm_config_db#(uvm_object_wrapper)::set(this, "env.sequencer.main_phase", "default_sequence", 
					    spi_eeprom_virtual_sequence::type_id::get());

    /** Set the sequence 'length' to generate 10 transaction with constraints */
    uvm_config_db#(int unsigned)::set(this, "env.sequencer.spi_eeprom_virtual_sequence", 
				      "sequence_length", 50);

  endfunction : build_phase  

endclass

//----------------------------------------------------------------------------
//--------------------------END OF FILE---------------------------------------
//----------------------------------------------------------------------------
