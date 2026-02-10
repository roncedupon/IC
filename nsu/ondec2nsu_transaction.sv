class ondecznsu_transaction extends uvm_sequence_item;
  `uvm_object_utils(ondecznsu_transaction)

  // 你的事务类原有字段（和表格完全匹配）
  rand logic crc_err;          // crc译码错误标志（0=成功，1=失败）
  rand logic data_out_en;      // 数据输出使能（1=有数据输出，0=无）
  // 其他字段...（如meta_buffer_id、plane_num等）

  // ======================================
  // ✅ 核心约束：crc_err==0 → data_out_en必须为1
  // ======================================
  constraint c_crc_success_data_out {
    // 蕴含关系：如果crc译码成功（crc_err==0），则必须有数据输出（data_out_en==1）
    (crc_err == 1'b0) -> (data_out_en == 1'b1);
  }

  // 可选：补充约束（如果需要）
  // 比如crc译码失败时，data_out_en可以为0（无数据输出）
  constraint c_crc_fail_data_out {
    (crc_err == 1'b1) -> (data_out_en == 1'b0);
  }

  function new(string name = "ondecznsu_transaction");
    super.new(name);
  endfunction
endclass