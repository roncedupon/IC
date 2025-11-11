
`ifndef GUARD_I2C_MST_10_BIT_ADDR_RD_WR_P_3_BYTES_10_BIT_DISABLED_SEQUENCE_UVM_SV
`define GUARD_I2C_MST_10_BIT_ADDR_RD_WR_P_3_BYTES_10_BIT_DISABLED_SEQUENCE_UVM_SV

/** This master directed sequence demonstrates, the way user can control the subset of 
 *  the svt_i2c_master_transaction transaction class members are assigned 
 *  values here. 
 *  It demonstrates the creation of transaction, assigning the fields directly.
 *  For full set of transaction class members and their complete description 
 *  refer "I2C Verification IP UVM Class Reference Manual".
 */

class i2c_mst_10_bit_addr_rd_wr_p_3_bytes_10_bit_disabled_sequence extends uvm_sequence #(svt_i2c_master_transaction); 

  svt_i2c_master_transaction tx_xacts_m;

  /** I2C configuration handle */ 
  svt_i2c_configuration i2c_cfg;

  /** UVM object utility macro */
  `uvm_object_utils(i2c_mst_10_bit_addr_rd_wr_p_3_bytes_10_bit_disabled_sequence)

  /** This macro is used to declare a variable p_sequencer whose type is svt_i2c_master_transaction_sequencer */
  `uvm_declare_p_sequencer(svt_i2c_master_transaction_sequencer)

  /** Class constructor */
  function new (string name = "i2c_mst_10_bit_addr_rd_wr_p_3_bytes_10_bit_disabled_sequence");
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
 bit status;
 bit [9:0] slv_addr;
 
  /** Define task body() */
  virtual task body();
    /** SVT configuration handle */ 
    svt_configuration cfg;

   // svt_i2c_master_transaction tx_xacts_m;

    `uvm_info("body", "Entering...", UVM_LOW)
    
    /** Get the SVT configuration */
    p_sequencer.get_cfg(cfg);
    
    /** Cast the SVT configuration handle on the local I2C configuration handle */
//    if (!$cast(i2c_cfg, cfg)) begin
//      `svt_xvm_fatal("body", "Unable to cast the configuration to a svt_i2c_configuration class");
//    end
  //  bit [9:0] slv_addr = cfg.slave_cfg[0].slave_address; 
    status = uvm_config_db#(bit[9:0])::get(m_sequencer, get_type_name(), "address",slv_addr);
  `ifdef SVT_UVM_1800_2_2017_OR_HIGHER
`uvm_create(tx_xacts_m);
    tx_xacts_m.reasonable_addr_10bit.constraint_mode(0);
  //  bit [9:0] slv_addr = cfg.slave_cfg[0].slave_address;
    `uvm_rand_send(tx_xacts_m,-1, 
		       {
		         tx_xacts_m.cmd             == I2C_READ ;
		         tx_xacts_m.addr            == slv_addr;
		    //     tx_xacts_m.data.size()     == 5;
		    //     tx_xacts_m.data[0]         == 8'b1111_1111;
		    //     tx_xacts_m.data[1]         == 8'b1111_0000;
		    //     tx_xacts_m.data[2]         == 8'b1111_0000;
		    //     tx_xacts_m.data[3]         == 8'b1111_0011;
		    //     tx_xacts_m.data[4]         == 8'b1111_1111;
		         tx_xacts_m.sr_or_p_gen     == 0 ;
		         tx_xacts_m.addr_10bit      == 1 ;
             tx_xacts_m.send_3_bytes_10b_slv_sr_rd == 0 ;
		       })

    `uvm_create(tx_xacts_m);
    tx_xacts_m.reasonable_addr_10bit.constraint_mode(0);
  //  bit [9:0] slv_addr = cfg.slave_cfg[0].slave_address;
    `uvm_rand_send(tx_xacts_m, -1,
		       {
		         tx_xacts_m.cmd             == I2C_READ ;
		         tx_xacts_m.addr            == slv_addr; 
		    //     tx_xacts_m.data.size()     == 5;
		    //     tx_xacts_m.data[0]         == 8'b1111_1111;
		    //     tx_xacts_m.data[1]         == 8'b1111_0000;
		    //     tx_xacts_m.data[2]         == 8'b1111_0000;
		    //     tx_xacts_m.data[3]         == 8'b1111_0011;
		    //     tx_xacts_m.data[4]         == 8'b1111_1111;
		         tx_xacts_m.sr_or_p_gen     == 0 ;
		         tx_xacts_m.addr_10bit      == 1 ;
             tx_xacts_m.send_3_bytes_10b_slv_sr_rd == 0 ;
		       })

    `uvm_create(tx_xacts_m);
    tx_xacts_m.reasonable_addr_10bit.constraint_mode(0);
  //  bit [9:0] slv_addr = cfg.slave_cfg[0].slave_address;
    `uvm_rand_send(tx_xacts_m, -1,
		       {
		         tx_xacts_m.cmd             == I2C_WRITE ;
		         tx_xacts_m.addr            == slv_addr; 
		         tx_xacts_m.data.size()     == 5;
		         tx_xacts_m.data[0]         == 8'b1111_1111;
		         tx_xacts_m.data[1]         == 8'b1111_0000;
		         tx_xacts_m.data[2]         == 8'b1111_0000;
		         tx_xacts_m.data[3]         == 8'b1111_0011;
		         tx_xacts_m.data[4]         == 8'b1111_1111;
		         tx_xacts_m.sr_or_p_gen     == 0 ;
		         tx_xacts_m.addr_10bit      == 1 ;
             tx_xacts_m.send_3_bytes_10b_slv_sr_rd == 0 ;
		       })

    `uvm_create(tx_xacts_m);
    tx_xacts_m.reasonable_addr_10bit.constraint_mode(0);
 //   bit [9:0] slv_addr = cfg.slave_cfg[0].slave_address;
    `uvm_rand_send(tx_xacts_m, -1,
		       {
		         tx_xacts_m.cmd             == I2C_WRITE ;
		         tx_xacts_m.addr            == slv_addr; 
		         tx_xacts_m.data.size()     == 5;
		         tx_xacts_m.data[0]         == 8'b1111_1111;
		         tx_xacts_m.data[1]         == 8'b1111_0000;
		         tx_xacts_m.data[2]         == 8'b1111_0000;
		         tx_xacts_m.data[3]         == 8'b1111_0011;
		         tx_xacts_m.data[4]         == 8'b1111_1111;
		         tx_xacts_m.sr_or_p_gen     == 0 ;
		         tx_xacts_m.addr_10bit      == 1 ;
             tx_xacts_m.send_3_bytes_10b_slv_sr_rd == 0 ;
		       })

    `uvm_create(tx_xacts_m);
    tx_xacts_m.reasonable_addr_10bit.constraint_mode(0);
   // bit [9:0] slv_addr = cfg.slave_cfg[0].slave_address;
    `uvm_rand_send(tx_xacts_m, -1,
		       {
		         tx_xacts_m.cmd             == I2C_READ ;
		         tx_xacts_m.addr            == slv_addr; 
		    //     tx_xacts_m.data.size()     == 5;
		    //     tx_xacts_m.data[0]         == 8'b1111_1111;
		    //     tx_xacts_m.data[1]         == 8'b1111_0000;
		    //     tx_xacts_m.data[2]         == 8'b1111_0000;
		    //     tx_xacts_m.data[3]         == 8'b1111_0011;
		    //     tx_xacts_m.data[4]         == 8'b1111_1111;
		         tx_xacts_m.sr_or_p_gen     == 0 ;
		         tx_xacts_m.addr_10bit      == 1 ;
             tx_xacts_m.send_3_bytes_10b_slv_sr_rd == 0 ;
		       })

`else
    `uvm_create(tx_xacts_m);
    tx_xacts_m.reasonable_addr_10bit.constraint_mode(0);
  //  bit [9:0] slv_addr = cfg.slave_cfg[0].slave_address;
    `uvm_rand_send_with(tx_xacts_m, 
		       {
		         tx_xacts_m.cmd             == I2C_READ ;
		         tx_xacts_m.addr            == slv_addr;
		    //     tx_xacts_m.data.size()     == 5;
		    //     tx_xacts_m.data[0]         == 8'b1111_1111;
		    //     tx_xacts_m.data[1]         == 8'b1111_0000;
		    //     tx_xacts_m.data[2]         == 8'b1111_0000;
		    //     tx_xacts_m.data[3]         == 8'b1111_0011;
		    //     tx_xacts_m.data[4]         == 8'b1111_1111;
		         tx_xacts_m.sr_or_p_gen     == 0 ;
		         tx_xacts_m.addr_10bit      == 1 ;
             tx_xacts_m.send_3_bytes_10b_slv_sr_rd == 0 ;
		       })

    `uvm_create(tx_xacts_m);
    tx_xacts_m.reasonable_addr_10bit.constraint_mode(0);
  //  bit [9:0] slv_addr = cfg.slave_cfg[0].slave_address;
    `uvm_rand_send_with(tx_xacts_m, 
		       {
		         tx_xacts_m.cmd             == I2C_READ ;
		         tx_xacts_m.addr            == slv_addr; 
		    //     tx_xacts_m.data.size()     == 5;
		    //     tx_xacts_m.data[0]         == 8'b1111_1111;
		    //     tx_xacts_m.data[1]         == 8'b1111_0000;
		    //     tx_xacts_m.data[2]         == 8'b1111_0000;
		    //     tx_xacts_m.data[3]         == 8'b1111_0011;
		    //     tx_xacts_m.data[4]         == 8'b1111_1111;
		         tx_xacts_m.sr_or_p_gen     == 0 ;
		         tx_xacts_m.addr_10bit      == 1 ;
             tx_xacts_m.send_3_bytes_10b_slv_sr_rd == 0 ;
		       })

    `uvm_create(tx_xacts_m);
    tx_xacts_m.reasonable_addr_10bit.constraint_mode(0);
  //  bit [9:0] slv_addr = cfg.slave_cfg[0].slave_address;
    `uvm_rand_send_with(tx_xacts_m, 
		       {
		         tx_xacts_m.cmd             == I2C_WRITE ;
		         tx_xacts_m.addr            == slv_addr; 
		         tx_xacts_m.data.size()     == 5;
		         tx_xacts_m.data[0]         == 8'b1111_1111;
		         tx_xacts_m.data[1]         == 8'b1111_0000;
		         tx_xacts_m.data[2]         == 8'b1111_0000;
		         tx_xacts_m.data[3]         == 8'b1111_0011;
		         tx_xacts_m.data[4]         == 8'b1111_1111;
		         tx_xacts_m.sr_or_p_gen     == 0 ;
		         tx_xacts_m.addr_10bit      == 1 ;
             tx_xacts_m.send_3_bytes_10b_slv_sr_rd == 0 ;
		       })

    `uvm_create(tx_xacts_m);
    tx_xacts_m.reasonable_addr_10bit.constraint_mode(0);
 //   bit [9:0] slv_addr = cfg.slave_cfg[0].slave_address;
    `uvm_rand_send_with(tx_xacts_m, 
		       {
		         tx_xacts_m.cmd             == I2C_WRITE ;
		         tx_xacts_m.addr            == slv_addr; 
		         tx_xacts_m.data.size()     == 5;
		         tx_xacts_m.data[0]         == 8'b1111_1111;
		         tx_xacts_m.data[1]         == 8'b1111_0000;
		         tx_xacts_m.data[2]         == 8'b1111_0000;
		         tx_xacts_m.data[3]         == 8'b1111_0011;
		         tx_xacts_m.data[4]         == 8'b1111_1111;
		         tx_xacts_m.sr_or_p_gen     == 0 ;
		         tx_xacts_m.addr_10bit      == 1 ;
             tx_xacts_m.send_3_bytes_10b_slv_sr_rd == 0 ;
		       })

    `uvm_create(tx_xacts_m);
    tx_xacts_m.reasonable_addr_10bit.constraint_mode(0);
   // bit [9:0] slv_addr = cfg.slave_cfg[0].slave_address;
    `uvm_rand_send_with(tx_xacts_m, 
		       {
		         tx_xacts_m.cmd             == I2C_READ ;
		         tx_xacts_m.addr            == slv_addr; 
		    //     tx_xacts_m.data.size()     == 5;
		    //     tx_xacts_m.data[0]         == 8'b1111_1111;
		    //     tx_xacts_m.data[1]         == 8'b1111_0000;
		    //     tx_xacts_m.data[2]         == 8'b1111_0000;
		    //     tx_xacts_m.data[3]         == 8'b1111_0011;
		    //     tx_xacts_m.data[4]         == 8'b1111_1111;
		         tx_xacts_m.sr_or_p_gen     == 0 ;
		         tx_xacts_m.addr_10bit      == 1 ;
             tx_xacts_m.send_3_bytes_10b_slv_sr_rd == 0 ;
		       })
`endif

    /** 
     * Call get_response only if configuration attribute,
     * enable_put_response is set 1.
     */
  //  if(i2c_cfg.enable_put_response == 1)
  //    get_response(rsp);

    `uvm_info("body", "Exiting ...", UVM_LOW)
  endtask: body

endclass: i2c_mst_10_bit_addr_rd_wr_p_3_bytes_10_bit_disabled_sequence 

`endif // GUARD_I2C_MST_10_BIT_ADDR_RD_WR_P_3_BYTES_10_BIT_DISABLED_SEQUENCE_UVM_SV
