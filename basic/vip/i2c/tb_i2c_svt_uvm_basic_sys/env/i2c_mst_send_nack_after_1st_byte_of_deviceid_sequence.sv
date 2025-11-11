
`ifndef GUARD_I2C_MST_SEND_NACK_AFTER_1ST_BYTE_OF_DEVICEID_SEQUENCE_UVM_SV
`define GUARD_I2C_MST_SEND_NACK_AFTER_1ST_BYTE_OF_DEVICEID_SEQUENCE_UVM_SV

/** This master directed sequence demonstrates, the way user can control the subset of 
 *  the svt_i2c_master_transaction transaction class members are assigned 
 *  values here. 
 *  It demonstrates the creation of transaction, assigning the fields directly.
 *  For full set of transaction class members and their complete description 
 *  refer "I2C Verification IP UVM Class Reference Manual".
 */

class i2c_mst_send_nack_after_1st_byte_of_deviceid_sequence extends uvm_sequence #(svt_i2c_master_transaction); 

  svt_i2c_master_transaction tx_xacts_m;

  /** I2C configuration handle */ 
  svt_i2c_configuration i2c_cfg;

  /** UVM object utility macro */
  `uvm_object_utils(i2c_mst_send_nack_after_1st_byte_of_deviceid_sequence)

  /** This macro is used to declare a variable p_sequencer whose type is svt_i2c_master_transaction_sequencer */
  `uvm_declare_p_sequencer(svt_i2c_master_transaction_sequencer)

  /** Class constructor */
  function new (string name = "i2c_mst_send_nack_after_1st_byte_of_deviceid_sequence");
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
    `uvm_create(tx_xacts_m)
      tx_xacts_m.reasonable_cmd.constraint_mode(0);
`ifdef SVT_UVM_1800_2_2017_OR_HIGHER
    `uvm_rand_send(tx_xacts_m, -1,
		       {
		         tx_xacts_m.cmd             == I2C_DEVICE_ID; 
		         tx_xacts_m.addr            ==`SVT_I2C_SLAVE0_ADDRESS ;
		         tx_xacts_m.sr_or_p_gen     == 0 ;
		         tx_xacts_m.send_start_byte == 0 ;
		         tx_xacts_m.m_device_id_gen_stop == 0;
		         tx_xacts_m.nack_at_device_id_byte == 1;
		         tx_xacts_m.device_id_rollback_iteration == 0;

		        })
`else
    `uvm_rand_send_with(tx_xacts_m, 
		       {
		         tx_xacts_m.cmd             == I2C_DEVICE_ID; 
		         tx_xacts_m.addr            ==`SVT_I2C_SLAVE0_ADDRESS ;
		         tx_xacts_m.sr_or_p_gen     == 0 ;
		         tx_xacts_m.send_start_byte == 0 ;
		         tx_xacts_m.m_device_id_gen_stop == 0;
		         tx_xacts_m.nack_at_device_id_byte == 1;
		         tx_xacts_m.device_id_rollback_iteration == 0;

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

endclass : i2c_mst_send_nack_after_1st_byte_of_deviceid_sequence 

`endif // GUARD_I2C_MST_SEND_NACK_AFTER_1ST_BYTE_OF_DEVICEID_SEQUENCE_UVM_SV
