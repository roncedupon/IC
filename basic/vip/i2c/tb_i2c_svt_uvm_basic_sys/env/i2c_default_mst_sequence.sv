
/** 
 * Abstract:
 * This class is used by the testbench to provide default master 
 * transaction sequence which is initiated on the default virtual
 * sequence through the virtual sequencer.
 */ 

class i2c_default_mst_sequence extends uvm_sequence #(svt_i2c_master_transaction); 

  rand int unsigned sequence_length =1;

  `uvm_object_utils(i2c_default_mst_sequence)
  `uvm_declare_p_sequencer(svt_i2c_master_transaction_sequencer)

  /** I2C configuration handle */ 
  svt_i2c_configuration i2c_cfg;
   
  function new(string name="i2c_default_mst_sequence");
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
  endtask : pre_body
  
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
    `uvm_info("body", "Entering...", UVM_DEBUG)
     
    /** Get the SVT configuration */
    p_sequencer.get_cfg(cfg);
    
    /** Cast the SVT configuration handle on the local I2C configuration handle */
    if (!$cast(i2c_cfg, cfg)) begin
      `svt_xvm_fatal("body", "Unable to cast the configuration to a svt_i2c_configuration class");
    end
`ifdef SVT_UVM_1800_2_2017_OR_HIGHER
    `uvm_do( req, p_sequencer, -1,
                { req.addr             == `SVT_I2C_SLAVE0_ADDRESS ;
                  req.cmd              == I2C_WRITE           ;
                  req.data.size()      == 1024                   ;
                  req.sr_or_p_gen      == 0                   ;
                  req.send_start_byte  == 0                   ;  
                })
`else
    `uvm_do_with( req,
                { req.addr             == `SVT_I2C_SLAVE0_ADDRESS ;
                  req.cmd              == I2C_WRITE           ;
                  req.data.size()      == 1024                   ;
                  req.sr_or_p_gen      == 0                   ;
                  req.send_start_byte  == 0                   ;  
                })
`endif
    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);
    `uvm_info("body", "Exiting...", UVM_DEBUG)
  endtask : body

endclass : i2c_default_mst_sequence
