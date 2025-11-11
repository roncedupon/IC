`ifndef GUARD_I2C_RANDOM_ALL_CMD_SCENARIO_WITH_ACK_NACK_SEQ_UVM_SV
`define GUARD_I2C_RANDOM_ALL_CMD_SCENARIO_WITH_ACK_NACK_SEQ_UVM_SV

/** This master directed sequence demonstrates, the way user can control the subset of 
 *  the svt_i2c_master_transaction transaction class members are assigned 
 *  values here. 
 *  It demonstrates the creation of transaction, assigning the fields directly.
 *  For full set of transaction class members and their complete description 
 *  refer "I2C Verification IP UVM Class Reference Manual".
 */

class i2c_random_all_cmd_scenario_with_ack_nack_seq extends uvm_sequence #(svt_i2c_master_transaction); 

  svt_i2c_master_transaction tx_xacts_m;
  svt_i2c_slave_transaction  tx_xacts_s;
  /** I2C configuration handle */ 
  svt_i2c_configuration i2c_cfg;
  int sequence_length=10;
  int nack_at_device_id_byte_s;
  int device_id_rollback_iteration_s;
  bit status;

  /** UVM object utility macro */
  `uvm_object_utils(i2c_random_all_cmd_scenario_with_ack_nack_seq)

  /** This macro is used to declare a variable p_sequencer whose type is svt_i2c_master_transaction_sequencer */
  `uvm_declare_p_sequencer(i2c_virtual_sequencer)

  /** Class constructor */
  function new (string name = "i2c_random_all_cmd_scenario_with_ack_nack_seq");
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
    status = uvm_config_db#(svt_i2c_configuration)::get(m_sequencer, get_type_name(), "i2c_cfg", i2c_cfg);
    status = uvm_config_db#(int)::get(m_sequencer, get_type_name(), "sequence_length", sequence_length);

`ifdef SVT_UVM_1800_2_2017_OR_HIGHER
    repeat(sequence_length) begin
      fork
        begin
          nack_at_device_id_byte_s        = $urandom_range(0, 10);
          device_id_rollback_iteration_s  = (nack_at_device_id_byte_s%3 == 0) ? nack_at_device_id_byte_s/3 : nack_at_device_id_byte_s/3+1;
          `uvm_create(req, p_sequencer.master_sequencer)
          req.reasonable_send_start_byte.constraint_mode(0);
          req.reasonable_cmd.constraint_mode(0);
          `uvm_rand_send( req, -1,
                      { req.addr             == `SVT_I2C_SLAVE0_ADDRESS ;
                        req.cmd              inside {I2C_READ,    I2C_WRITE ,    I2C_GEN_CALL,   I2C_DEVICE_ID};
                        req.data.size()      inside {2,10};
                        req.sr_or_p_gen      inside {0,1};
                        req.send_start_byte  inside {0,1};  
                        req.m_device_id_gen_stop inside {0,1};
                        req.nack_at_device_id_byte == nack_at_device_id_byte_s;
                        req.device_id_rollback_iteration == device_id_rollback_iteration_s;
                      })
        end
        begin
          `uvm_create(tx_xacts_s, p_sequencer.slave_sequencer)
            tx_xacts_s.nack_addr = $urandom_range(0,1);
            tx_xacts_s.nack_addr_count = 1;
            tx_xacts_s.data = new[$urandom_range(2,10)];
            foreach(tx_xacts_s.data[i]) tx_xacts_s.data[i] = $urandom;
          `uvm_send(tx_xacts_s)
        end
      join
    end
`else
    repeat(sequence_length) begin
      fork
        begin
          nack_at_device_id_byte_s        = $urandom_range(0, 10);
          device_id_rollback_iteration_s  = (nack_at_device_id_byte_s%3 == 0) ? nack_at_device_id_byte_s/3 : nack_at_device_id_byte_s/3+1;
          `uvm_create_on(req, p_sequencer.master_sequencer)
          req.reasonable_send_start_byte.constraint_mode(0);
          req.reasonable_cmd.constraint_mode(0);
          `uvm_rand_send_with( req,
                      { req.addr             == `SVT_I2C_SLAVE0_ADDRESS ;
                        req.cmd              inside {I2C_READ,    I2C_WRITE ,    I2C_GEN_CALL,   I2C_DEVICE_ID};
                        req.data.size()      inside {2,10};
                        req.sr_or_p_gen      inside {0,1};
                        req.send_start_byte  inside {0,1};  
                        req.m_device_id_gen_stop inside {0,1};
                        req.nack_at_device_id_byte == nack_at_device_id_byte_s;
                        req.device_id_rollback_iteration == device_id_rollback_iteration_s;
                      })
        end
        begin
          `uvm_create_on(tx_xacts_s, p_sequencer.slave_sequencer)
            tx_xacts_s.nack_addr = $urandom_range(0,1);
            tx_xacts_s.nack_addr_count = 1;
            tx_xacts_s.data = new[$urandom_range(2,10)];
            foreach(tx_xacts_s.data[i]) tx_xacts_s.data[i] = $urandom;
          `uvm_send(tx_xacts_s)
        end
      join
    end
`endif
    `uvm_info("body", "Exiting ...", UVM_DEBUG)
  endtask : body

endclass : i2c_random_all_cmd_scenario_with_ack_nack_seq 

`endif // GUARD_I2C_RANDOM_ALL_CMD_SCENARIO_WITH_ACK_NACK_SEQ_UVM_SV
