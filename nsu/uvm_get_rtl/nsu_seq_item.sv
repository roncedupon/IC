class nsu_seq_item extends uvm_sequence_item;
  `uvm_object_utils(nsu_seq_item)

  // 输出信号值
  logic [5:0] offline_wbf_cur_state;
  logic [3:0] rd_cmd_hw_cur_state;
  logic [2:0] nand_rd_cmd_cur_state;

  function new(string name = "nsu_seq_item");
    super.new(name);
  endfunction

  // 打印函数
  function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field("offline_wbf_cur_state", offline_wbf_cur_state, 6, UVM_HEX);
    printer.print_field("rd_cmd_hw_cur_state", rd_cmd_hw_cur_state, 4, UVM_HEX);
    printer.print_field("nand_rd_cmd_cur_state", nand_rd_cmd_cur_state, 3, UVM_HEX);
  endfunction

  // 比较函数
  function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    nsu_seq_item rhs_; 
    if(!$cast(rhs_, rhs)) return 0;
    return super.do_compare(rhs, comparer) &&
           (offline_wbf_cur_state == rhs_.offline_wbf_cur_state) &&
           (rd_cmd_hw_cur_state == rhs_.rd_cmd_hw_cur_state) &&
           (nand_rd_cmd_cur_state == rhs_.nand_rd_cmd_cur_state);
  endfunction
endclass
