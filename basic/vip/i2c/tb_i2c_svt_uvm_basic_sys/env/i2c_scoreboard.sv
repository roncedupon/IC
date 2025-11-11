
`ifndef GUARD_I2C_SCOREBOARD_SV
`define GUARD_I2C_SCOREBOARD_SV

/** Macro that define two analysis ports with unique suffixes for master and slave */
`uvm_analysis_imp_decl(_master)
`uvm_analysis_imp_decl(_slave)
`uvm_analysis_imp_decl(_master_pre)
`uvm_analysis_imp_decl(_slave_pre)
`uvm_analysis_imp_decl(_master_data)
`uvm_analysis_imp_decl(_slave_data)

/**
 * Abstract:
 * The file contains the i2c_scoreboard class extended from uvm_scoreboard
 * A i2c_scoreboard class showcases the scoreboarding functionality.
 * It compare the transaction sent by master and transaction received by slave
 */
class i2c_scoreboard extends uvm_scoreboard;

  /** Analysis port connected to the I2C Master/Slave Agent */
  uvm_analysis_imp_master #(svt_i2c_master_transaction, i2c_scoreboard) item_collected_master;
  uvm_analysis_imp_slave #(svt_i2c_slave_transaction, i2c_scoreboard) item_collected_slave;

  uvm_analysis_imp_master_pre #(svt_i2c_master_transaction, i2c_scoreboard) item_collected_master_pre;
  uvm_analysis_imp_slave_pre #(svt_i2c_slave_transaction, i2c_scoreboard)   item_collected_slave_pre;

  uvm_analysis_imp_master_data #(svt_i2c_master_transaction, i2c_scoreboard) item_collected_master_data;
  uvm_analysis_imp_slave_data #(svt_i2c_slave_transaction, i2c_scoreboard)   item_collected_slave_data;

  /** Handle of master and slave transaction */
  svt_i2c_master_transaction master_tr;
  svt_i2c_slave_transaction slave_tr;
  svt_i2c_master_transaction master_pre_tr;
  svt_i2c_slave_transaction slave_pre_tr;

  /** Queue for master transaction */
  svt_i2c_master_transaction master_trans[$];
  svt_i2c_master_transaction master_data_trans, mst_data_tr;
  svt_i2c_master_transaction master_pre_trans[$];
  /** Queue for slave transaction */
  svt_i2c_slave_transaction slave_trans[$];
  svt_i2c_slave_transaction slave_data_trans, slv_data_tr;
  svt_i2c_slave_transaction slave_pre_trans[$];

  svt_i2c_configuration cfg;

  /** event for tracking the master transaction */
  event master_get_event; 
  bit master_get_bit; 
  bit master_data_get_bit; 
  bit slave_data_get_bit; 
  event master_pre_get_event; 
  bit master_pre_get_bit; 
  /** event for tracking the slave transaction */
  event slave_get_event; 
  event slave_pre_get_event; 
  /** variable to enable and disable scoreboard */  
  bit enable = 1;
  /** number of transaction sent by master */
  integer count_master = 0;
  integer count_master_pre = 0;
  /** number of transaction received by slave */
  integer count_slave = 0;
  integer count_slave_pre = 0;
  /** variable to count no. of mismatch in master and slave transaction */
  int mismatch_count = 0;
  int retry_count;
  bit fresh_mst_data = 1, fresh_slv_data = 1;

  `uvm_component_utils_begin(i2c_scoreboard)
    `uvm_field_int(enable, UVM_ALL_ON | UVM_NOPRINT)
    `uvm_field_int(count_slave, UVM_ALL_ON | UVM_NOPRINT)
    `uvm_field_int(count_master, UVM_ALL_ON | UVM_NOPRINT)
    `uvm_field_int(count_slave_pre, UVM_ALL_ON | UVM_NOPRINT)
    `uvm_field_int(count_master_pre, UVM_ALL_ON | UVM_NOPRINT)
    `uvm_field_int(mismatch_count, UVM_ALL_ON | UVM_NOPRINT)
  `uvm_component_utils_end

  // ---------------------------------------------------------------------------------------------
  // new - constructor
  // ---------------------------------------------------------------------------------------------
  function new (string name="i2c_scoreboard", uvm_component parent=null);
    super.new(name, parent);
  endfunction: new

  // ---------------------------------------------------------------------------------------------
  // build phase
  // ---------------------------------------------------------------------------------------------
  virtual function void build_phase(uvm_phase phase);
    item_collected_master = new("item_collected_master", this);
    item_collected_slave = new("item_collected_slave", this);
    item_collected_master_pre = new("item_collected_master_pre", this);
    item_collected_slave_pre = new("item_collected_slave_pre", this);
    item_collected_master_data = new("item_collected_master_data", this);
    item_collected_slave_data = new("item_collected_slave_data", this);
  endfunction: build_phase

  function void set_i2c_config(svt_i2c_configuration cfg);
    if(!$cast(this.cfg,cfg))
      `uvm_fatal("set_i2c_config"," Unable to cast configuration ")
    else
      `uvm_info("build_phase",$sformatf("**********Configuration**********\n%0s",cfg.sprint()),UVM_LOW);
  endfunction

  // ---------------------------------------------------------------------------------------------
  // run phase
  // ---------------------------------------------------------------------------------------------
  virtual task run_phase(uvm_phase phase);
    forever
      begin
        fork
          begin
            //@(master_get_event);
            wait (master_get_bit==1);
            master_tr = master_trans.pop_front();
            master_get_bit = 0;
            if (retry_count !== 0) begin
              if (cfg.bus_speed == `SVT_I2C_HIGHSPEED_MODE) begin
                if (!master_pre_tr.addr_10bit) begin
                  if (master_pre_tr.send_start_byte) begin
                    if (!master_tr.ack_detected[0] && !master_tr.ack_detected[1] && master_tr.ack_detected[2])
                      retry_count = 0;
                  end else begin
                    if(!master_tr.ack_detected[0] && master_tr.ack_detected[1])
                      retry_count = 0;
                  end
                  if(retry_count !== 0) begin
                    disable wait_for_mst_pre;
                  end
                end else begin
                  if (master_pre_tr.send_start_byte) begin
                    if (master_tr.cmd == `I2C_NVS_WRITE) begin
                      if (!master_tr.ack_detected[0] && !master_tr.ack_detected[1] && master_tr.ack_detected[2])
                        retry_count = 0;
                    end
                  end else begin
                    if (master_tr.cmd == `I2C_NVS_WRITE) begin
                      if(!master_tr.ack_detected[0] && master_tr.ack_detected[1])
                        retry_count = 0;
                    end
                  end
                  if(retry_count !== 0) begin
                    disable wait_for_mst_pre;
                  end
                end
              end else begin
                if (!master_pre_tr.addr_10bit) begin
                  if (master_pre_tr.send_start_byte) begin
                    if (!master_tr.ack_detected[0] && master_tr.ack_detected[1])
                      retry_count = 0;
                  end else begin
                    if (master_tr.ack_detected[0])
                      retry_count = 0;
                  end
                  if(retry_count !== 0) begin
                    disable wait_for_mst_pre;
                  end
                end else begin
                  if (master_pre_tr.send_start_byte) begin
                    if (master_tr.cmd == `I2C_NVS_WRITE) begin
                      if (!master_tr.ack_detected[0] && master_tr.ack_detected[1])
                        retry_count = 0;
                    end
                  end else begin
                    if (master_tr.cmd == `I2C_NVS_WRITE) begin
                      if(master_tr.ack_detected[0])
                        retry_count = 0;
                    end
                  end
                  if(retry_count !== 0) begin
                    disable wait_for_mst_pre;
                  end
                end
              end
            end
          end
          begin : wait_for_mst_pre
            wait(retry_count == 0);      
            //@(master_pre_get_event);
            wait(master_pre_get_bit==1);
            master_pre_tr = master_pre_trans.pop_front();
            if (master_pre_tr.retry_if_nack) begin
              retry_count = master_pre_tr.num_of_retry;
            end
            master_pre_get_bit = 0;
          end
          begin
            @(slave_get_event);
            slave_tr = slave_trans.pop_front();
          end
          begin
            if(cfg.enable_i2c_data_port_with_ack_and_sr_p) begin
              wait(master_data_get_bit == 1);
              master_data_get_bit = 0;
              mst_data_tr = master_data_trans;
            end
          end
          begin
            if(cfg.enable_i2c_data_port_with_ack_and_sr_p) begin
              wait(slave_data_get_bit == 1);
              slave_data_get_bit = 0;
              slv_data_tr = slave_data_trans;
            end
          end
          //if (slave_pre_trans.size() != 0) begin
          //  //@(slave_pre_get_event);
          //  slave_pre_tr = slave_pre_trans.pop_front();
          //end
        join
       
        fork
          compare_transaction(master_tr , "master" , slave_tr , "slave", mst_data_tr, slv_data_tr); 
          if (retry_count == 0)
            compare_pre_post_master_transaction(master_pre_tr, "pre_master", master_tr, "master");
        join
      end 
  endtask: run_phase

  // ------------------------------------------------------------------------------------------------
  // report phase
  // ------------------------------------------------------------------------------------------------
  virtual function void report_phase(uvm_phase phase);
    if(enable) begin
      `uvm_info(get_type_name(),
      $sformatf("\n\
  ----------------------------------------------\n\
 | ScoreBoard Report                             |\n\
  ---------------------------------------------- \n\
 | Transactions recieved by Master       %5d   |\n\
 | Transactions recieved by Slave        %5d   |\n\
 | Mismatch in transactions              %5d   |\n\
  ---------------------------------------------- ",
      count_master, count_slave,mismatch_count ), UVM_LOW);
      
      if((count_master==0) || (count_slave==0)) begin
        `uvm_error(get_type_name(),$sformatf("Scoreboard Error : NO transaction observed on the bus"))
      end  
      if(master_trans.size != 0) begin
        `uvm_error(get_type_name(),$sformatf("Scoreboard Error : master transaction queue still have %0d pending transaction",master_trans.size()))
      end
      if(slave_trans.size != 0) begin
        `uvm_error(get_type_name(),$sformatf("Scoreboard Error : Slave transaction queue still have %0d pending transaction",slave_trans.size()))
      end
      if(master_pre_trans.size != 0) begin
        `uvm_error(get_type_name(),$sformatf("Scoreboard Error : master pre transaction queue still have %0d pending transaction",master_pre_trans.size()))
      end
      //if(slave_pre_trans.size != 0) begin
      //  `uvm_error(get_type_name(),$sformatf("Scoreboard Error : Slave pre transaction queue still have %0d pending transaction",slave_pre_trans.size()))
      //end
      if(count_master != count_slave) begin
        `uvm_error(get_type_name(),$sformatf("Scoreboard Error : Mismatch detected in number of transaction of master - %0d and slave - %0d",count_master,count_slave))
      end
    end
  endfunction: report_phase

  // ---------------------------------------------------------------------------------------------
  // write_master_wr
  // ---------------------------------------------------------------------------------------------
  virtual function void write_master(svt_i2c_master_transaction tr);
    if(enable) begin
      master_trans.push_back(tr);
      count_master ++;
      -> master_get_event ;
      master_get_bit = 1;
    end
  endfunction: write_master

  // ---------------------------------------------------------------------------------------------
  // write_master_wr
  // ---------------------------------------------------------------------------------------------
  virtual function void write_master_pre(svt_i2c_master_transaction tr);
    if(enable) begin
      master_pre_trans.push_back(tr);
      count_master_pre ++;
      -> master_pre_get_event ;
      master_pre_get_bit = 1;
    end
  endfunction: write_master_pre

  // ---------------------------------------------------------------------------------------------
  // write_master_data
  // ---------------------------------------------------------------------------------------------
  virtual function void write_master_data(svt_i2c_master_transaction tr);
    if(enable && cfg.enable_i2c_data_port_with_ack_and_sr_p) begin
      if(fresh_mst_data) begin
        master_data_trans = svt_i2c_master_transaction::type_id::create();
        $cast(master_data_trans, tr);
        if(tr.stop_detected==0 && tr.rep_start_detected==0)
          fresh_mst_data = 0;
        else begin
          fresh_mst_data = 1;
          master_data_get_bit = 1;
        end
      end
      else begin
        if(tr.stop_detected==0 && tr.rep_start_detected==0) begin
          `SVT_I2C_DA_PUSH_BACK(master_data_trans.data, tr.data[0]);
          `SVT_I2C_DA_PUSH_BACK(master_data_trans.ack_detected, tr.ack_detected[0]);
        end
        else begin
          fresh_mst_data = 1;
          master_data_trans.stop_detected       = tr.stop_detected;
          master_data_trans.rep_start_detected  = tr.rep_start_detected;
          master_data_get_bit = 1;
        end
      end
    end
  endfunction: write_master_data

  // ---------------------------------------------------------------------------------------------
  // write_slave_data
  // ---------------------------------------------------------------------------------------------
  virtual function void write_slave_data(svt_i2c_slave_transaction tr);
    if(enable && cfg.enable_i2c_data_port_with_ack_and_sr_p) begin
      if(fresh_slv_data) begin
        slave_data_trans = svt_i2c_slave_transaction::type_id::create();
        $cast(slave_data_trans, tr);
        if(tr.stop_detected==0 && tr.rep_start_detected==0)
          fresh_slv_data = 0;
        else begin
          fresh_slv_data = 1;
          slave_data_get_bit = 1;
        end
      end
      else begin
        if(tr.stop_detected==0 && tr.rep_start_detected==0) begin
          `SVT_I2C_DA_PUSH_BACK(slave_data_trans.data, tr.data[0]);
          `SVT_I2C_DA_PUSH_BACK(slave_data_trans.ack_detected, tr.ack_detected[0]);
        end
        else begin
          fresh_slv_data = 1;
          slave_data_trans.stop_detected       = tr.stop_detected;
          slave_data_trans.rep_start_detected  = tr.rep_start_detected;
          slave_data_get_bit = 1;
        end
      end
    end
  endfunction: write_slave_data


  // ---------------------------------------------------------------------------------------------
  // write_slave_wr
  // ---------------------------------------------------------------------------------------------
  virtual function void write_slave(svt_i2c_slave_transaction tr);
    if(enable) begin
      slave_trans.push_back(tr);
      count_slave ++;
      -> slave_get_event ;
    end
  endfunction: write_slave

  // ---------------------------------------------------------------------------------------------
  // write_slave_wr
  // ---------------------------------------------------------------------------------------------
  virtual function void write_slave_pre(svt_i2c_slave_transaction tr);
    if(enable) begin
      slave_pre_trans.push_back(tr);
      count_slave_pre ++;
      -> slave_pre_get_event ;
    end
  endfunction: write_slave_pre

  // ---------------------------------------------------------------------------------------------
  // comparing the transaction sent by master and received by slave
  // ---------------------------------------------------------------------------------------------
  function void compare_transaction(svt_i2c_master_transaction mst_tr,
                                    string fst_obj_name="master",
                                    svt_i2c_slave_transaction slv_tr,
                                    string sec_obj_name="slave",
                                    svt_i2c_master_transaction master_data_trans,
                                    svt_i2c_slave_transaction slave_data_trans
                                  );
    string mismatch_str,match_str ;
    bit mismatch_detected = 0 ;
    bit mismatch_in_data_observed_detected = 0 ;
    string combined_str;
    combined_str= {fst_obj_name,sec_obj_name};

    for(int i=0;i<slv_tr.data.size();i++)
      begin
        if(mst_tr.data[i]  != slv_tr.data[i])
          begin
            $sformat(mismatch_str,"Byte transferred different in %s value is %h and %s slave received byte value is %h ",fst_obj_name,mst_tr.data[i],sec_obj_name,slv_tr.data[i]);
            `uvm_info("Scoreboard", mismatch_str, UVM_LOW);
            mismatch_detected = 1;
          end
      end

  if(cfg.enable_i2c_data_port_with_ack_and_sr_p) begin
    if(master_data_trans.data.size != slave_data_trans.data.size || master_data_trans.data.size != mst_tr.data.size || slave_data_trans.data.size != slv_tr.data.size) begin
      `uvm_error("Scoreboard", $sformatf("Data size mismatch detected:: master_data_trans.data.size=%0d, slave_data_trans.data.size=%0d, mst_tr.data.size=%0d, slv_tr.data.size=%0d", master_data_trans.data.size, slave_data_trans.data.size, mst_tr.data.size, slv_tr.data.size));
    end
    else begin
      for(int i=0;i<master_data_trans.data.size();i++)
        begin
          //check between Master/Slave data_observed_port
          if(master_data_trans.data[i]  != slave_data_trans.data[i])
            begin
              $sformat(mismatch_str,"Difference observed in %0s data_observed_port and %0s data_observed_port. Data %0h vs Data %0h ",fst_obj_name,sec_obj_name,master_data_trans.data[i],slave_data_trans.data[i]);
              `uvm_error("Scoreboard", mismatch_str);
              mismatch_in_data_observed_detected = 1;
            end

          //check between Master data_observed_port & Slave RX port
          if(master_data_trans.data[i]  != slv_tr.data[i])
            begin
              $sformat(mismatch_str,"Difference observed in %0s data_observed_port and %0s RX-port. Data %0h vs Data %0h ",fst_obj_name,sec_obj_name,master_data_trans.data[i],slv_tr.data[i]);
              `uvm_error("Scoreboard", mismatch_str);
              mismatch_in_data_observed_detected = 1;
            end

          //check if cmd mismatch found
          if(master_data_trans.cmd != slave_data_trans.cmd || master_data_trans.cmd != mst_tr.cmd || slave_data_trans.cmd != slv_tr.cmd)
            begin
              $sformat(mismatch_str,"Difference observed in cmd attribute:: master_data_trans.cmd=%0s, slave_data_trans.cmd=%0s, mst_tr.cmd=%0s, slv_tr.cmd=%0s", master_data_trans.cmd.name, slave_data_trans.cmd.name, mst_tr.cmd, slv_tr.cmd);
              `uvm_error("Scoreboard", mismatch_str);
              mismatch_in_data_observed_detected = 1;
            end

          //check between Master/Slave  - ack_detected
            if((master_data_trans.cmd inside {I2C_WRITE, I2C_GEN_CALL} && ((i != master_data_trans.data.size-1 && (master_data_trans.ack_detected[i] == 0 || slave_data_trans.ack_detected[i] == 0)) || (i == master_data_trans.data.size-1 && (master_data_trans.ack_detected[i] != slave_data_trans.ack_detected[i])))) ||
               (master_data_trans.cmd inside {I2C_READ, I2C_DEVICE_ID} &&  ((i != master_data_trans.data.size-1 && (master_data_trans.ack_detected[i] == 0 || slave_data_trans.ack_detected[i] == 0)) || (i == master_data_trans.data.size-1 && (master_data_trans.ack_detected[i] == 1 || slave_data_trans.ack_detected[i] == 1))) ))
            begin
              $sformat(mismatch_str,"For Write data, all ack should be populated as 1's, while for Read data all ack except last one should be populated as 1. Cmd Rcvd = %0s, Master Ack[i=%0d] = %0d, Slave Ack[i=%0d] = %0d",master_data_trans.cmd.name, i, master_data_trans.ack_detected[i], i, slave_data_trans.ack_detected[i]);
              `uvm_error("Scoreboard", mismatch_str);
              mismatch_in_data_observed_detected = 1;
            end
        end
      end //else

      //check for settings rep_start/stop, Master data_observed_port vs Slave data_observed_port
      if(master_data_trans.stop_detected      != slave_data_trans.stop_detected      || master_data_trans.stop_detected      != mst_tr.stop_detected       || slave_data_trans.stop_detected      != slv_tr.stop_detected ||
         master_data_trans.rep_start_detected != slave_data_trans.rep_start_detected )
        `uvm_error("Scoreboard", $sformatf(" Either Stop or Rep-start condition Mismatch:: \n------Error params----:: master_data_trans.stop_detected=%0d, slave_data_trans.stop_detected=%0d, mst_tr.stop_detected=%0d, slv_tr.stop_detected=%0d \n------Error params----:: master_data_trans.rep_start_detected=%0d, slave_data_trans.rep_start_detected=%0d, mst_tr.rep_start_detected=%0d, slv_tr.rep_start_detected=%0d", master_data_trans.stop_detected, slave_data_trans.stop_detected, mst_tr.stop_detected, slv_tr.stop_detected, master_data_trans.rep_start_detected, slave_data_trans.rep_start_detected, mst_tr.rep_start_detected, slv_tr.rep_start_detected));
  end// if(cfg.enable_i2c_data_port_with_ack_and_sr_p)

    // check for no mismatch
    if(!mismatch_detected)
      begin
        $sformat(match_str,"Trans match between %s and %s",fst_obj_name,sec_obj_name);
        `uvm_info("Scoreboard", match_str, UVM_LOW);
      end
    if(mismatch_detected && combined_str=="masterslave")
      begin
        mismatch_count++    ;
      end
  endfunction: compare_transaction
    
  // ---------------------------------------------------------------------------------------------
  // comparing the transaction sent by master and received by slave
  // ---------------------------------------------------------------------------------------------
  function void compare_pre_post_master_transaction(svt_i2c_master_transaction mst_pre_tr,
                                                    string fst_obj_name="pre_master",
                                                    svt_i2c_master_transaction mst_tr,
                                                    string sec_obj_name="master");
    string mismatch_str,match_str ;
    bit mismatch_detected = 0 ;
    string combined_str;
    combined_str= {fst_obj_name,sec_obj_name};

    `uvm_info("Scoreboard"," start comparing pre and post transactions",UVM_LOW)

    if((mst_pre_tr.cmd == `I2C_NVS_WRITE) && (((mst_tr.ack_detected.size > 0 && mst_tr.ack_detected[0] == 1) && !mst_pre_tr.addr_10bit) || (mst_pre_tr.addr_10bit && mst_tr.ack_detected.size > 1 && mst_tr.ack_detected[0] && mst_tr.ack_detected[1])) && (mst_pre_tr.addr !== 'h7c)) begin
      for(int i=0;i<mst_tr.data.size();i++) begin
        if(mst_pre_tr.data[i] != mst_tr.data[i]) begin
          `uvm_error(get_type_name(),$sformatf(" data[%0d] transferred different in %s value is %h and %s received byte value is %h ",i,fst_obj_name,mst_pre_tr.data[i],sec_obj_name,mst_tr.data[i]))
        end
      end
    end

    // Do not check cmd and address for reserved address sent through sequence
    if (((mst_pre_tr.addr[6:0] !== 7'b0000000) && (mst_pre_tr.addr[6:0] !== 7'b1111100) && !mst_pre_tr.addr_10bit) ||
      ((mst_pre_tr.addr !== 10'b0000000000) && (mst_pre_tr.addr !== 10'b0001111100) && mst_pre_tr.addr_10bit)) begin
      if(mst_pre_tr.cmd !== mst_tr.cmd)
        `uvm_error(get_type_name(),$sformatf(" Command different in %s value is %h and %s received byte value is %h ",fst_obj_name,mst_pre_tr.cmd,sec_obj_name,mst_tr.cmd))

      if (mst_pre_tr.cmd !== `SVT_I2C_GEN_CALL) begin
        if (mst_pre_tr.addr_10bit == 1) begin 
          if(mst_pre_tr.addr !== mst_tr.addr)
            `uvm_error(get_type_name(),$sformatf(" 10 bit address different in %s value is %h and %s received byte value is %h ",fst_obj_name,mst_pre_tr.addr,sec_obj_name,mst_tr.addr))
        end else begin
          if(mst_pre_tr.addr[6:0] !== mst_tr.addr[6:0])
            `uvm_error(get_type_name(),$sformatf(" 7 bit address different in %s value is %h and %s received byte value is %h ",fst_obj_name,mst_pre_tr.addr[6:0],sec_obj_name,mst_tr.addr[6:0]))
        end
      end
    end

    if (mst_pre_tr.sr_or_p_gen !== mst_tr.sr_or_p_gen) begin
      if (mst_pre_tr.sr_or_p_gen)
        `uvm_error(get_type_name(),$sformatf(" Repeated Start was configured through sequence but did not trasfer on the bus "))
      else if (mst_tr.sr_or_p_gen)
        `uvm_error(get_type_name(),$sformatf(" Repeated Start was not configured through sequence but trasferred on the bus "))
    end

    if (mst_pre_tr.send_start_byte && !mst_tr.send_start_byte)
      `uvm_error(get_type_name(),$sformatf(" Start byte was configured through sequence but not trasferred on the bus "))
    else if (!mst_pre_tr.send_start_byte && mst_tr.send_start_byte)
      `uvm_error(get_type_name(),$sformatf(" Start byte was not configured through sequence but trasferred on the bus "))

    if (mst_pre_tr.enable_clk_stretch_after_byte && !mst_tr.enable_clk_stretch_after_byte)
      `uvm_error(get_type_name(),$sformatf(" Clock stretching is enabled by master through sequence but not reflected on bus "))

    `uvm_info("Scoreboard"," end comparing pre and post transactions",UVM_LOW)
  endfunction //compare_transaction

endclass: i2c_scoreboard
`endif //GUARD_I2C_SCOREBOARD_SV
