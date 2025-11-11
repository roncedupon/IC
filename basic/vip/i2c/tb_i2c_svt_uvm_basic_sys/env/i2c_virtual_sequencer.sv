
`ifndef GUARD_I2C_VIRTUAL_SEQUENCER_SV
  `define GUARD_I2C_VIRTUAL_SEQUENCER_SV

/**
 * Abstract:
 * This class is Virtual Sequencer class, which encapsulates the 
 * agent's sequencers and allows a fine grain control over the user's
 * stimulus application to the selective sequencer.
 */
class i2c_virtual_sequencer extends uvm_sequencer;
  
   /** Typedef of the reset modport to simplify access */
   typedef virtual i2c_reset_if.i2c_reset_modport I2C_RESET_MP;

   /** Reset modport provides access to the reset signal */
   I2C_RESET_MP reset_mp;

   /** UVM component utility macro */
   `uvm_component_utils(i2c_virtual_sequencer)

   /** Instance of master sequencer */
   svt_i2c_master_transaction_sequencer master_sequencer;
   /** Instance of slave sequencer */
   svt_i2c_slave_transaction_sequencer  slave_sequencer;

   /** Class constructor */
   function new(string name="i2c_virtual_sequencer",uvm_component parent = null);
     super.new(name,parent);
   endfunction
   
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entering...", UVM_LOW)

    super.build_phase(phase);

    if (!uvm_config_db#(I2C_RESET_MP)::get(this, "", "reset_mp", reset_mp)) begin
      `uvm_fatal("build_phase", "An i2c_reset_modport must be set using the config db.");
    end

    `uvm_info("build_phase", "Exiting...", UVM_LOW)
  endfunction
   
endclass : i2c_virtual_sequencer

`endif //  `ifndef GUARD_I2C_VIRTUAL_SEQUENCER_SV


//------------------------------------------------------------------------
//-----------------------END OF FILE--------------------------------------
//------------------------------------------------------------------------
