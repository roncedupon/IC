class nsu_sequence extends uvm_sequence#(nsu_seq_item);
  `uvm_object_utils(nsu_sequence)
  `uvm_declare_p_sequencer(nsu_sequencer)

  function new(string name = "nsu_sequence");
    super.new(name);
  endfunction

  virtual task body();
    nsu_seq_item item;
    int num_samples = 10;
    int sample_count = 0;

    `uvm_info(get_type_name(), "Starting sequence to get DUT signals", UVM_MEDIUM)

    // 等待复位完成
    @(posedge p_sequencer.vif.clk);

    // 获取多个采样点的信号值
    repeat(num_samples) begin
      sample_count++;
      item = nsu_seq_item::type_id::create("item");
      start_item(item);

      // 使用接口获取DUT信号值
      item.offline_wbf_cur_state = p_sequencer.vif.offline_wbf_cur_state;
      item.rd_cmd_hw_cur_state = p_sequencer.vif.rd_cmd_hw_cur_state;
      item.nand_rd_cmd_cur_state = p_sequencer.vif.nand_rd_cmd_cur_state;

      finish_item(item);
      `uvm_info(get_type_name(), $sformatf("Sample %0d: offline_wbf=%0h, rd_cmd=%0h, nand_rd=%0h", 
                                         sample_count, 
                                         item.offline_wbf_cur_state, 
                                         item.rd_cmd_hw_cur_state, 
                                         item.nand_rd_cmd_cur_state), UVM_MEDIUM)

      // 等待一个时钟周期
      @(posedge p_sequencer.vif.clk);
    end

    `uvm_info(get_type_name(), "Sequence completed", UVM_MEDIUM)
  endtask
endclass
