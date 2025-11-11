
`ifndef GUARD_I2C_MST_DIRECTED_READ_SEQ_UVM_SV
`define GUARD_I2C_MST_DIRECTED_READ_SEQ_UVM_SV

/** This master directed sequence demonstrates, the way user can control the subset of 
 *  the svt_i2c_master_transaction transaction class members are assigned 
 *  values here. 
 *  It demonstrates the creation of transaction, assigning the fields directly.
 *  For full set of transaction class members and their complete description 
 *  refer "I2C Verification IP UVM Class Reference Manual".
 */

class i2c_mst_directed_read_seq extends uvm_sequence #(svt_i2c_master_transaction); 

  svt_i2c_master_transaction tx_xacts_m;

  /** I2C configuration handle */ 
  svt_i2c_configuration i2c_cfg;

  /** UVM object utility macro */
  `uvm_object_utils(i2c_mst_directed_read_seq)

  /** This macro is used to declare a variable p_sequencer whose type is svt_i2c_master_transaction_sequencer */
  `uvm_declare_p_sequencer(svt_i2c_master_transaction_sequencer)

  /** Class constructor */
  function new (string name = "i2c_mst_directed_read_seq");
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
    `uvm_do(tx_xacts_m, p_sequencer, -1, 
		  {
		    tx_xacts_m.cmd             == I2C_READ;
		    tx_xacts_m.addr            == `SVT_I2C_SLAVE0_ADDRESS;
		    tx_xacts_m.data.size()     == 5;
		    tx_xacts_m.sr_or_p_gen     == 0;
		    tx_xacts_m.send_start_byte == 0;
		    tx_xacts_m.do_insert_error == 1;
		  })
    `uvm_do(tx_xacts_m, p_sequencer, -1, 
		  {
		    tx_xacts_m.cmd             == I2C_WRITE;
		    tx_xacts_m.addr            == `SVT_I2C_SLAVE0_ADDRESS;
		    tx_xacts_m.data.size()     == 5;
		    tx_xacts_m.sr_or_p_gen     == 0;
		    tx_xacts_m.send_start_byte == 0;
		    tx_xacts_m.do_insert_error == 0;
		  })
    `uvm_do(tx_xacts_m, p_sequencer, -1, 
		  {
		    tx_xacts_m.cmd             == I2C_READ;
		    tx_xacts_m.addr            == `SVT_I2C_SLAVE0_ADDRESS;
		    tx_xacts_m.data.size()     == 5;
		    tx_xacts_m.sr_or_p_gen     == 0;
		    tx_xacts_m.send_start_byte == 0;
		    tx_xacts_m.do_insert_error == 0;
		  })
    `uvm_do(tx_xacts_m, p_sequencer, -1, 
		  {
		    tx_xacts_m.cmd             == I2C_READ;
		    tx_xacts_m.addr            == `SVT_I2C_SLAVE0_ADDRESS;
		    tx_xacts_m.data.size()     == 5;
		    tx_xacts_m.sr_or_p_gen     == 0;
		    tx_xacts_m.send_start_byte == 0;
		    tx_xacts_m.do_insert_error == 1;
		  })
`else
    `uvm_do_with(tx_xacts_m, 
		  {
                    tx_xacts_m.cmd             == I2C_READ;
		    tx_xacts_m.addr            == `SVT_I2C_SLAVE0_ADDRESS;
		    tx_xacts_m.data.size()     == 5;
		    tx_xacts_m.sr_or_p_gen     == 0;
		    tx_xacts_m.send_start_byte == 0;
		    tx_xacts_m.do_insert_error == 1; //error injected
		  })
    `uvm_do_with(tx_xacts_m, 
		  {
                    tx_xacts_m.cmd             == I2C_WRITE;
		    tx_xacts_m.addr            == `SVT_I2C_SLAVE0_ADDRESS;
		    tx_xacts_m.data.size()     == 5;
		    tx_xacts_m.sr_or_p_gen     == 0;
		    tx_xacts_m.send_start_byte == 0;
		    tx_xacts_m.do_insert_error == 0;
		  })
    `uvm_do_with(tx_xacts_m, 
		  {
                    tx_xacts_m.cmd             == I2C_READ;
		    tx_xacts_m.addr            == `SVT_I2C_SLAVE0_ADDRESS;
		    tx_xacts_m.data.size()     == 5;
		    tx_xacts_m.sr_or_p_gen     == 0;
		    tx_xacts_m.send_start_byte == 0;
		    tx_xacts_m.do_insert_error == 1; //error injected
		  })
    `uvm_do_with(tx_xacts_m, 
		  {
                    tx_xacts_m.cmd             == I2C_READ;
		    tx_xacts_m.addr            == `SVT_I2C_SLAVE0_ADDRESS;
		    tx_xacts_m.data.size()     == 5;
		    tx_xacts_m.sr_or_p_gen     == 0;
		    tx_xacts_m.send_start_byte == 0;
		    tx_xacts_m.do_insert_error == 0;
		  })
`endif
    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

    `uvm_info("body", "Exiting ...", UVM_DEBUG)
  endtask : body

endclass : i2c_mst_directed_read_seq 

`endif // GUARD_I2C_DIRECTED_SEQUENCE_UVM_SV
