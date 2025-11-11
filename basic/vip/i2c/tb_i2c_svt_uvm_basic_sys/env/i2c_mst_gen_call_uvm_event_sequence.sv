
`ifndef GUARD_I2C_MST_GEN_CALL_UVM_EVENT_SEQUENCE_UVM_SV
`define GUARD_I2C_MST_GEN_CALL_UVM_EVENT_SEQUENCE_UVM_SV

/** This sequence demonstrates, creates a scenario for back to back General call by master.
 * In first transaction second byte is configured as 'h04 whreas in second tx its value is 'h06 
 */

class i2c_mst_gen_call_uvm_event_sequence extends uvm_sequence #(svt_i2c_master_transaction); 

//  svt_i2c_master_transaction tx_xacts_m;

  /** I2C configuration handle */ 
  svt_i2c_configuration i2c_cfg;

  /** UVM object utility macro */
  `uvm_object_utils(i2c_mst_gen_call_uvm_event_sequence)

  /** This macro is used to declare a variable p_sequencer whose type is svt_i2c_master_transaction_sequencer */
  `uvm_declare_p_sequencer(svt_i2c_master_transaction_sequencer)

  /** Class constructor */
  function new (string name = "i2c_mst_gen_call_uvm_event_sequence");
    super.new(name);
  endfunction : new

  /** Raise an objection if this is the parent sequence */
  virtual task pre_body();
    uvm_phase phase;
    super.pre_body();
    `uvm_info("pre_body","Entering...",UVM_LOW)
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
    `uvm_info("post_body","Entering...",UVM_LOW)
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

    svt_i2c_master_transaction tx_xacts_m;

    `uvm_info("body", "Entering...", UVM_LOW)
    
    /** Get the SVT configuration */
    p_sequencer.get_cfg(cfg);
    
    /** Cast the SVT configuration handle on the local I2C configuration handle */
    if (!$cast(i2c_cfg, cfg)) begin
      `svt_xvm_fatal("body", "Unable to cast the configuration to a svt_i2c_configuration class");
    end
  `ifdef SVT_UVM_1800_2_2017_OR_HIGHER

   `uvm_create(tx_xacts_m);
    tx_xacts_m.reasonable_sr_or_p_gen.constraint_mode(0);
    tx_xacts_m.reasonable_addr_10bit.constraint_mode(0);
    tx_xacts_m.reasonable_cmd.constraint_mode(0);

    `uvm_rand_send(tx_xacts_m,-1, 
		        {
		         tx_xacts_m.cmd               == I2C_GEN_CALL ;
		         tx_xacts_m.sec_byte_gen_call == 8'h04;
		         tx_xacts_m.sr_or_p_gen       == 1 ;
		        })
    `uvm_create(tx_xacts_m);
    tx_xacts_m.reasonable_sr_or_p_gen.constraint_mode(0);
    tx_xacts_m.reasonable_addr_10bit.constraint_mode(0);
    tx_xacts_m.reasonable_cmd.constraint_mode(0);

    `uvm_rand_send(tx_xacts_m, -1,
		        {
		         tx_xacts_m.cmd               == I2C_GEN_CALL ;
		         tx_xacts_m.sec_byte_gen_call == 8'h06;
		         tx_xacts_m.sr_or_p_gen       == 0 ;
		        })
`else 
    `uvm_create(tx_xacts_m);
    tx_xacts_m.reasonable_sr_or_p_gen.constraint_mode(0);
    tx_xacts_m.reasonable_addr_10bit.constraint_mode(0);
    tx_xacts_m.reasonable_cmd.constraint_mode(0);

    `uvm_rand_send_with(tx_xacts_m, 
		        {
		         tx_xacts_m.cmd               == I2C_GEN_CALL ;
		         tx_xacts_m.sec_byte_gen_call == 8'h04;
		         tx_xacts_m.sr_or_p_gen       == 1 ;
		        })
    `uvm_create(tx_xacts_m);
    tx_xacts_m.reasonable_sr_or_p_gen.constraint_mode(0);
    tx_xacts_m.reasonable_addr_10bit.constraint_mode(0);
    tx_xacts_m.reasonable_cmd.constraint_mode(0);

    `uvm_rand_send_with(tx_xacts_m, 
		        {
		         tx_xacts_m.cmd               == I2C_GEN_CALL ;
		         tx_xacts_m.sec_byte_gen_call == 8'h06;
		         tx_xacts_m.sr_or_p_gen       == 0 ;
		        })
`endif
    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
    if(i2c_cfg.enable_put_response == 1)
      get_response(rsp);

    `uvm_info("body", "Exiting ...", UVM_LOW)
  endtask: body

endclass: i2c_mst_gen_call_uvm_event_sequence 

`endif // GUARD_I2C_MST_GEN_CALL_UVM_EVENT_SEQUENCE_UVM_SV
