// 新接口（信号命名不同，逻辑和原接口一致）
interface new_tsu_misc_slv_interface #(parameter DATA_WIDTH = 32) (input logic new_clk);  
    logic                  new_valid;         // 对应原valid
    logic                  new_rdy;           // 对应原rdy
    logic [DATA_WIDTH-1:0] new_tr_data;       // 对应原tr_data
         
    // 新接口的clocking块（信号名是新的）
    clocking driver_cb @(posedge new_clk);            
        input new_valid, new_tr_data;            
        output new_rdy;        
    endclocking   
             
    clocking monitor_cb @(posedge new_clk);            
        input new_valid, new_rdy, new_tr_data;        
    endclocking

    modport slave_mp(clocking driver_cb, input new_clk);        
    modport monitor_mp(clocking monitor_cb, input new_clk);  
endinterface

// 适配接口：将新接口信号映射为原monitor期望的信号名
interface tsu_misc_slv_adapter_interface #(parameter DATA_WIDTH = 32) ();
    // 1. 导入新接口（作为适配层的内部接口）
    new_tsu_misc_slv_interface#(DATA_WIDTH) new_if();

    // 2. 定义原monitor期望的接口信号（和原interface完全一致）
    logic                  valid;         
    logic                  rdy;
    logic [DATA_WIDTH-1:0] tr_data;   
    logic                  clk;

    // 3. 信号映射：新接口 → 原接口名（核心适配逻辑）
    assign clk       = new_if.new_clk;
    assign valid     = new_if.new_valid;
    assign rdy       = new_if.new_rdy;
    assign tr_data   = new_if.new_tr_data;
    assign new_if.new_rdy = rdy; // 反向赋值（driver输出的rdy）

    // 4. 原monitor需要的clocking块（复用原信号名）
    clocking driver_cb @(posedge clk);            
        input valid, tr_data;            
        output rdy;        
    endclocking   
             
    clocking monitor_cb @(posedge clk);            
        input valid, rdy, tr_data;        
    endclocking

    modport slave_mp(clocking driver_cb, input clk);        
    modport monitor_mp(clocking monitor_cb, input clk);  

    // 5. 绑定新接口的时钟（需在顶层连接实际时钟）
    bind new_tsu_misc_slv_interface new_if_inst(.*);
    initial begin
        new_if.new_clk = clk;
    end
endinterface

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


module top;
    logic clk;
    // 1. 实例化新接口
    new_tsu_misc_slv_interface#(32) new_if(.new_clk(clk));

    // 2. 实例化适配接口
    tsu_misc_slv_adapter_interface#(32) adapter_if();

    // 3. 绑定新接口到适配层
    assign adapter_if.new_if.new_clk = clk;
    assign adapter_if.new_if.new_valid = dut.new_valid; // 对接DUT的新接口
    assign adapter_if.new_if.new_tr_data = dut.new_tr_data;
    assign dut.new_rdy = adapter_if.new_if.new_rdy;

    // 4. 实例化原monitor，传入适配接口（完全无需修改monitor）
    tsu_misc_slv_monitor#(32) monitor_inst;
    initial begin
        monitor_inst = tsu_misc_slv_monitor#(32)::type_id::create("monitor_inst", null);
        // 将适配接口的monitor_mp传给原monitor
        uvm_config_db#(virtual tsu_misc_slv_interface#(32)::monitor_mp)::set(
            null, "*", "tsu_misc_slv_vif", adapter_if.monitor_mp
        );
    end
endmodule