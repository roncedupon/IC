
`ifndef GUARD_i2c_mst_directed_read_cov_seq_UVM_SV
`define GUARD_i2c_mst_directed_read_cov_seq_UVM_SV

/** This master directed sequence demonstrates, the way user can control the subset of 
 *  the svt_i2c_master_transaction transaction class members are assigned 
 *  values here. 
 *  It demonstrates the creation of transaction, assigning the fields directly.
 *  For full set of transaction class members and their complete description 
 *  refer "I2C Verification IP UVM Class Reference Manual".
 */

class i2c_mst_directed_read_cov_seq extends uvm_sequence #(svt_i2c_master_transaction); 

  svt_i2c_master_transaction tx_xacts_m;

  /** I2C configuration handle */ 
  svt_i2c_configuration i2c_cfg;

  /** UVM object utility macro */
  `uvm_object_utils(i2c_mst_directed_read_cov_seq)

  /** This macro is used to declare a variable p_sequencer whose type is svt_i2c_master_transaction_sequencer */
  `uvm_declare_p_sequencer(svt_i2c_master_transaction_sequencer)

  /** Class constructor */
  function new (string name = "i2c_mst_directed_read_cov_seq");
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
    `uvm_info("body", "Entering...", UVM_DEBUG)

    /** Get the SVT configuration */
    p_sequencer.get_cfg(cfg);
    
    /** Cast the SVT configuration handle on the local I2C configuration handle */
    if (!$cast(i2c_cfg, cfg)) begin
      `svt_xvm_fatal("body", "Unable to cast the configuration to a svt_i2c_configuration class");
    end

`ifdef SVT_UVM_1800_2_2017_OR_HIGHER
    `uvm_create(req,p_sequencer)
`else
    `uvm_create_on(req,p_sequencer)
`endif
    req.reasonable_sr_or_p_gen.constraint_mode(0);
    if (!req.randomize() with
                { req.addr                 == 7'b0000_001; //CBUS ADDRESS
                  req.cmd                  == I2C_READ;
                  req.data.size()          == 5;
                  req.sr_or_p_gen          == 1;
                  req.send_start_byte      == 0;
                  req.do_insert_error      == 0;
                })
                `uvm_error("Randomization failure"," i2c_mst_directed_read_cov_seq")
    `uvm_send(req)

`ifdef SVT_UVM_1800_2_2017_OR_HIGHER
    `uvm_create(req,p_sequencer)
`else
    `uvm_create_on(req,p_sequencer)
`endif
    req.reasonable_sr_or_p_gen.constraint_mode(0);
    if (!req.randomize() with
                { req.addr                 == 7'b0000_001; //CBUS ADDRESS
                  req.cmd                  == I2C_WRITE;
                  req.data.size()          == 5;
                  req.sr_or_p_gen          == 0;
                  req.send_start_byte      == 0;
                  req.do_insert_error      == 0;
                })
                `uvm_error("Randomization failure"," i2c_mst_directed_read_cov_seq")
    `uvm_send(req)

//10 BIT ADDRESSING 

`ifdef SVT_UVM_1800_2_2017_OR_HIGHER
    `uvm_create(req,p_sequencer)
`else
    `uvm_create_on(req,p_sequencer)
`endif

    req.reasonable_sr_or_p_gen.constraint_mode(0);
    req.reasonable_addr_10bit.constraint_mode(0);

    if (!req.randomize() with
                { req.cmd             == I2C_WRITE ;
                  req.addr            == 7'b0000_001;
                  req.data.size()     == 5;
                  req.data[0]         == 8'b1111_1111;
                  req.data[1]         == 8'b1111_0000;
                  req.data[2]         == 8'b1111_0000;
                  req.data[3]         == 8'b1111_0011;
                  req.data[4]         == 8'b1111_1111;
                  req.sr_or_p_gen     == 0 ;
                  req.addr_10bit      == 1 ;
                })
                `uvm_error("Randomization failure"," i2c_mst_directed_read_cov_seq")
    `uvm_send(req)

    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

    `uvm_info("body", "Exiting ...", UVM_DEBUG)
  endtask : body

endclass : i2c_mst_directed_read_cov_seq 

`endif // GUARD_I2C_DIRECTED_SEQUENCE_UVM_SV


