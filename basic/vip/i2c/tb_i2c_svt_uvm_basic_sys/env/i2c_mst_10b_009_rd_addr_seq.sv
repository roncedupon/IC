
`ifndef GUARD_I2C_MST_10B_009_RD_ADDR_SEQ_SV
`define GUARD_I2C_MST_10B_009_RD_ADDR_SEQ_SV

/** 
 * Abstract:
 * This class is used by the testbench to provide default master 
 * transaction sequence which is initiated on the default virtual
 * sequence through the virtual sequencer.
 */ 

class i2c_mst_10b_009_rd_addr_seq extends uvm_sequence #(svt_i2c_master_transaction); 

  `uvm_object_utils(i2c_mst_10b_009_rd_addr_seq)

  /** This macro is used to declare a variable p_sequencer whose type is svt_i2c_master_transaction_sequencer */
  `uvm_declare_p_sequencer(svt_i2c_master_transaction_sequencer)  

  /** I2C configuration obtained from the sequencer */
  svt_i2c_configuration i2c_cfg;
 
  function new(string name="i2c_mst_10b_009_rd_addr_seq");
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
    `uvm_create(req,p_sequencer)
`else
    `uvm_create_on(req,p_sequencer)
`endif

    req.reasonable_addr_10bit.constraint_mode(0);
    if (!req.randomize() with
                { req.addr            == 'h009;
                  req.cmd             == I2C_READ;
                  req.data.size()     == 10;
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;  
                  req.addr_10bit      == 1;
                })
                `uvm_error("Randomization failure"," i2c_mst_10b_009_rd_addr_seq")
    `uvm_send(req)

    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

    `uvm_info("body","Exiting...",UVM_LOW)
  endtask: body

endclass: i2c_mst_10b_009_rd_addr_seq
`endif //GUARD_I2C_MST_10B_009_RD_ADDR_SEQ_SV
