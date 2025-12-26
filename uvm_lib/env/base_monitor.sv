class tsu_misc_slv_monitor #(parameter DATA_WIDTH = 32) extends uvm_monitor;
  `uvm_component_param_utils(tsu_misc_slv_monitor#(DATA_WIDTH))

  logic [DATA_WIDTH-1:0] dump_data[];
  string default_file_name = "dump_data.txt";
  int file_handle;

  virtual interface tsu_misc_slv_interface#(DATA_WIDTH) tsu_misc_slv_vif;
  tsu_misc_slv_config                                   tsu_misc_slv_cfg;

  logic                   check_flag = 1'b1;
  logic [DATA_WIDTH-1:0]  tr_data_check;
  logic                   valid_data_check_flag;

  uvm_analysis_port #(tsu_misc_slv_transaction#(DATA_WIDTH)) ap;


  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
    dump_data = {};
  endfunction


  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(tsu_misc_slv_config)::get(this, "", "tsu_misc_slv_cfg", tsu_misc_slv_cfg)) begin
      `uvm_fatal("tsu_misc_slv_monitor", "Slave agent configuration not found")
    end
    if (tsu_misc_slv_cfg.DATA_WIDTH != DATA_WIDTH) begin
      `uvm_fatal("tsu_misc_slv_monitor", $sformatf("Config DATATsu_misc_ifA_WIDTH (%0d) doesn't match monitor parameter (%0d)", tsu_misc_slv_cfg.DATA_WIDTH, DATA_WIDTH))
    end
  endfunction


  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if (!uvm_config_db#(virtual interface tsu_misc_slv_interface#(DATA_WIDTH))::get(this, "", "tsu_misc_slv_vif", tsu_misc_slv_vif)) begin
      `uvm_fatal("tsu_misc_mst_monitor", "Virtual interface not found for monitor")
    end
  endfunction


  virtual task monitor_transaction();
    tsu_misc_slv_transaction#(DATA_WIDTH) tr;

    if (tsu_misc_slv_vif.monitor_cb.valid === 1'b1 && tsu_misc_slv_vif.monitor_cb.rdy === 1'b0) begin
      valid_data_check_flag = 1'b1;
      tr_data_check = tsu_misc_slv_vif.monitor_cb.tr_data;
    end

    if (tsu_misc_slv_vif.monitor_cb.valid === 1'b1 && tsu_misc_slv_vif.monitor_cb.rdy === 1'b1) begin
      tr = tsu_misc_slv_transaction#(DATA_WIDTH)::type_id::create("tr");
      tr.tr_data = tsu_misc_slv_vif.monitor_cb.tr_data;
      dump_data.push_back(tsu_misc_slv_vif.monitor_cb.tr_data);
      ap.write(tr);
      tr_data_check = tr.tr_data;
      valid_data_check_flag = 1'b0;
      `uvm_info("tsu_misc_slv_monitor", $sformatf("Monitor transaction: tr_data=0x%0h", tsu_misc_slv_vif.monitor_cb.tr_data), UVM_HIGH)
    end
  endtask


  virtual task perform_protocol_checks();
    if (tsu_misc_slv_cfg.slv_enable_protocol_checks == 1 && tsu_misc_slv_vif.monitor_cb.valid === 1'b1) begin
      if ($isunknown(tsu_misc_slv_vif.monitor_cb.tr_data)) begin
        `uvm_error("tsu_misc_slv_monitor", $sformatf("Data has X/Z state when valid=1: 0x%0h", tsu_misc_slv_vif.monitor_cb.tr_data))
      end
    end

    if (tsu_misc_slv_cfg.slv_enable_protocol_checks == 1 && valid_data_check_flag == 1'b1) begin
      if(tsu_misc_slv_vif.monitor_cb.valid == 1'b0) begin
        `uvm_error("tsu_misc_slv_monitor", $sformatf("Valid is changed when not wait rdy=1: 0x%0h", tsu_misc_slv_vif.monitor_cb.valid))
      end

      if(tsu_misc_slv_vif.monitor_cb.tr_data != tr_data_check) begin
        `uvm_error("tsu_misc_slv_monitor", $sformatf("Data is changed when valid=1 & rdy=0: 0x%0h", tsu_misc_slv_vif.monitor_cb.tr_data))
      end
    end
  endtask


  virtual function void dump_all_data(string file_name);
    if(file_name == "") begin
      file_name = default_file_name;
      `uvm_error("tsu_misc_slv_monitor", "file name is empty, dump to default file (dump_data.txt) !")
    end

    file_handle = $fopen(file_name, "w");

    if (file_handle == 0) begin
      `uvm_error("tsu_misc_slv_monitor", $sformatf("%s Open fail to dump all data !",file_name))
      return;
    end
    else begin
      foreach(dump_data[i]) $fdisplay(file_handle,"%0h",dump_data[i]);
    end
    $fclose(file_handle);
  endfunction


  virtual task run_phase(uvm_phase phase);
    forever begin
      @(tsu_misc_slv_vif.monitor_cb);
      monitor_transaction();
      perform_protocol_checks();
    end
  endtask

endclass