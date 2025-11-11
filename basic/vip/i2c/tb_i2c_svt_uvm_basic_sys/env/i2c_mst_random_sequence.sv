
/**
 * Abstract:
 * This class defines a sequence in which it generates the request object randomly
 * and sends it using `uvm_do() UVM macro to the sequencer. 
 */

`ifndef GUARD_I2C_MST_RANDOM_SEQUENCE_SV
`define GUARD_I2C_MST_RANDOM_SEQUENCE_SV

class i2c_mst_random_sequence extends uvm_sequence #(svt_i2c_master_transaction); 

  /** Parameter that controls the number of I2C frames that would be generated */
  rand int unsigned sequence_length = 1;
  
  /** UVM object utility macro */
  `uvm_object_utils(i2c_mst_random_sequence)

  /** This macro is used to declare a variable p_sequencer whose type is svt_i2c_master_transaction_sequencer */
  `uvm_declare_p_sequencer(svt_i2c_master_transaction_sequencer)

  svt_i2c_master_transaction mst_item;

  /** I2C configuration handle */ 
  svt_i2c_configuration i2c_cfg;

  /** Class constructor */
  function new (string name = "i2c_mst_random_sequence");
    super.new(name);
  endfunction : new

  /** Raise an objection if this is the parent sequence */
  virtual task pre_body();
    uvm_phase phase;
    super.pre_body();
`ifdef SVT_UVM_12_OR_HIGHER
    phase = get_starting_phase();
`else
    phase = starting_phase;
`endif
    if (phase!=null) begin
      phase.raise_objection(this);
    end
  endtask: pre_body
  
  /** Drop an objection if this is the parent sequence */
  virtual task post_body();
    uvm_phase phase;
    super.post_body();
`ifdef SVT_UVM_12_OR_HIGHER
    phase = get_starting_phase();
`else
    phase = starting_phase;
`endif
    if (phase!=null) begin
      phase.drop_objection(this);
    end
  endtask: post_body
  
  /** Define task body() */
  virtual task body();
    /** SVT configuration handle */ 
    svt_configuration cfg;
    bit status;
    `uvm_info("body", "Entering...", UVM_DEBUG)

    /** Get the SVT configuration */
    p_sequencer.get_cfg(cfg);
    
    /** Cast the SVT configuration handle on the local I2C configuration handle */
    if (!$cast(i2c_cfg, cfg)) begin
      `svt_xvm_fatal("body", "Unable to cast the configuration to a svt_i2c_configuration class");
    end
    
    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    `uvm_info("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"), UVM_LOW);

    for(int i = 0; i < sequence_length; i++) begin
      `uvm_info("body", $sformatf("Calling `uvm_do, iteration=%0d", i), UVM_LOW)

      /** Generate I2C Frames randomly.  */
`ifdef SVT_UVM_1800_2_2017_OR_HIGHER
      `uvm_do(mst_item, p_sequencer, -1,
                  {
                   mst_item.addr == `SVT_I2C_SLAVE0_ADDRESS;
                  })
`else
      `uvm_do_with(mst_item,
                  {
                   mst_item.addr == `SVT_I2C_SLAVE0_ADDRESS;
                  })
`endif
      /** 
       * Call get_response only if configuration attribute,
       * enable_put_response is set 1.
       */
      if(i2c_cfg.enable_put_response == 1)
        get_response(rsp);
    end
    `uvm_info("body", "Exiting ...", UVM_DEBUG)
  endtask : body

endclass : i2c_mst_random_sequence 

`endif // GUARD_I2C_RANDOM_SEQUENCE_SV
