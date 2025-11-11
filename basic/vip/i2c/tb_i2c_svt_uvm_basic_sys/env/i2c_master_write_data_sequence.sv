
`ifndef GUARD_I2C_MASTER_WRITE_DATA_SEQUENCE_SV
`define GUARD_I2C_MASTER_WRITE_DATA_SEQUENCE_SV

/** 
 * Abstract:
 * This class is used by the testbench to provide default master 
 * transaction sequence which is initiated on the default virtual
 * sequence through the virtual sequencer.
 */ 

class i2c_master_write_data_sequence extends uvm_sequence #(svt_i2c_master_transaction); 

  `uvm_object_utils(i2c_master_write_data_sequence)

  /** This macro is used to declare a variable p_sequencer whose type is svt_i2c_master_transaction_sequencer */
  `uvm_declare_p_sequencer(svt_i2c_master_transaction_sequencer)  

  /** I2C configuration obtained from the sequencer */
  svt_i2c_configuration i2c_cfg;
  int insert_error = 0;
  bit is_write = 1; //if write needs to be send this bit should be set as 1.
 
  function new(string name="i2c_master_write_data_sequence");
     super.new(name);
  endfunction: new 

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
    `uvm_info("body","Entering...",UVM_LOW)

`ifdef SVT_UVM_1800_2_2017_OR_HIGHER
    `uvm_do( req, p_sequencer, -1, 
                { req.addr            == `SVT_I2C_SLAVE0_ADDRESS ;
                  req.cmd             == is_write ? I2C_WRITE : I2C_READ;
                  req.data.size()     == 5;
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;  
                  req.do_insert_error == insert_error;
                })
`else
    `uvm_do_with( req,
                { req.addr            == `SVT_I2C_SLAVE0_ADDRESS ;
                  req.cmd             == is_write ? I2C_WRITE : I2C_READ;
                  req.data.size()     == 5;
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;  
                  req.do_insert_error == insert_error;
                })
`endif

    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

    `uvm_info("body","Exiting...",UVM_LOW)
  endtask: body

endclass: i2c_master_write_data_sequence
`endif //GUARD_I2C_MASTER_WRITE_DATA_SEQUENCE_SV
