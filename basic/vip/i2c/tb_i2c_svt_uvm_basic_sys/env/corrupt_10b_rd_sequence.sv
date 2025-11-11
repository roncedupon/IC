
`ifndef GUARD_CORRUPT_10B_RD_SEQ_SV
`define GUARD_CORRUPT_10B_RD_SEQ_SV

/** 
 * Abstract:
 * This sequence demonstrates  a use case for corrupting 
 * first frame sent by master during 10 bit read.
 * Master sends READ instead of WRITE for 1st frame. 
 */ 

class corrupt_10b_rd_sequence extends uvm_sequence #(svt_i2c_master_transaction); 

  `uvm_object_utils(corrupt_10b_rd_sequence)

  /** This macro is used to declare a variable p_sequencer whose type is svt_i2c_master_transaction_sequencer */
  `uvm_declare_p_sequencer(svt_i2c_master_transaction_sequencer)  

  /** I2C configuration obtained from the sequencer */
  svt_i2c_configuration i2c_cfg;
 
  function new(string name="corrupt_10b_rd_sequence");
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
    req.reasonable_sr_or_p_gen.constraint_mode(0);
    if (!req.randomize() with
                { req.addr            == 'h006;
                  req.cmd             == I2C_READ;
                  req.data.size()     == 10;
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;  
                  req.addr_10bit      == 1;
                  req.do_insert_error == 1;
            
                })
                `uvm_error("Randomization failure"," corrupt_10b_rd_sequence")
    `uvm_send(req)

`ifdef SVT_UVM_1800_2_2017_OR_HIGHER
    `uvm_create(req,p_sequencer)
`else
    `uvm_create_on(req,p_sequencer)
`endif
    req.reasonable_addr_10bit.constraint_mode(0);
    if (!req.randomize() with
                { req.addr            == 'h006;
                  req.cmd             == I2C_READ;
                  req.data.size()     == 10;
                  req.sr_or_p_gen     == 0;
                  req.send_start_byte == 0;  
                  req.addr_10bit      == 1;
                  req.do_insert_error == 0;
                  req.send_3_bytes_10b_slv_sr_rd == 0 ;
                  
                })
                `uvm_error("Randomization failure"," corrupt_10b_rd_sequence")
    `uvm_send(req)

    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

    `uvm_info("body","Exiting...",UVM_LOW)
  endtask: body

endclass: corrupt_10b_rd_sequence
`endif //GUARD_CORRUPT_10B_RD_SEQ_SV
