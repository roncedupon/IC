
/**
 * Abstract:
 * This class is used by the testbench to provide default slave
 * transaction sequence which is initiated on the default virtual
 * sequence through the virtual sequencer.
 */

class i2c_default_slv_sequence extends uvm_sequence #(svt_i2c_slave_transaction); 

  rand int unsigned sequence_length =1;

  `uvm_object_utils(i2c_default_slv_sequence)
  `uvm_declare_p_sequencer(svt_i2c_slave_transaction_sequencer)
  
  /** I2C configuration handle */ 
  svt_i2c_configuration i2c_cfg;
   
  function new(string name="i2c_default_slv_sequence");
    super.new(name);
  endfunction 

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

    /** Get the SVT configuration */
    p_sequencer.get_cfg(cfg);
    
    /** Cast the SVT configuration handle on the local I2C configuration handle */
    if (!$cast(i2c_cfg, cfg)) begin
      `svt_xvm_fatal("body", "Unable to cast the configuration to a svt_i2c_configuration class");
    end
  
    `uvm_do(req)
    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

  endtask : body
   
endclass : i2c_default_slv_sequence
